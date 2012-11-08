/*
 * Vibrant GPS Shim (forked off the generic shim by arcee)
 *
 * Copyright (C) 2006 Ricardo Cerquiera
 * Copyright (C) 2012 Daniel Bateman
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_NDEBUG 0
#define LOG_TAG "VibrantGps"

#include <stdlib.h>
#include <utils/Log.h>
#include <dlfcn.h>

#include <hardware/gps.h>
#include <openssl/sha.h>
#include <openssl/hmac.h>

#include "gps.h"

static GpsCallbacks *originalCallbacks;
static const OldAGpsInterface* oldAGPS = NULL;
static AGpsInterface newAGPS;
static const OldAGpsRilInterface* oldAGPSRIL = NULL;
static AGpsRilInterface newAGPSRIL;
static const OldGpsNiInterface* oldNI = NULL;
static GpsNiInterface newNI;

static const OldGpsInterface* originalGpsInterface = NULL;
static GpsInterface newGpsInterface;

static gps_get_hardware_interface_t getHardwareInterface;

static void *hal;

// used for agpsril_ni_message
static const char *suplHost = NULL;

static void location_callback(OldGpsLocation *location)
{
    static GpsLocation newLocation;
    newLocation.size = sizeof(GpsLocation);
    newLocation.flags = location->flags;
    newLocation.latitude = location->latitude;
    newLocation.longitude = location->longitude;
    newLocation.altitude = location->altitude;
    newLocation.speed = location->speed;
    newLocation.bearing = location->bearing;
    newLocation.accuracy = location->accuracy;
    newLocation.timestamp = location->timestamp;

    ALOGV("I have a location");

    originalCallbacks->create_thread_cb("gpsshim-location",(void *)originalCallbacks->location_cb,(void *)&newLocation);
}

static void status_callback(OldGpsStatus *status)
{
    static GpsStatus newStatus;
    newStatus.size = sizeof(GpsStatus);
    newStatus.status = status->status;

    ALOGV("Status value is %u",status->status);
    originalCallbacks->create_thread_cb("gpsshim-status",(void *)originalCallbacks->status_cb,(void *)&newStatus);
}

static void svstatus_callback(OldGpsSvStatus *sv_info)
{
    static GpsSvStatus newSvStatus;
    int i;
    ALOGV("I have a svstatus");

    newSvStatus.size = sizeof(GpsSvStatus);
    newSvStatus.num_svs = sv_info->num_svs;

    for (i = 0; i < newSvStatus.num_svs; ++i) {
        newSvStatus.sv_list[i].size = sizeof(GpsSvInfo);
        newSvStatus.sv_list[i].prn = sv_info->sv_list[i].prn;
        newSvStatus.sv_list[i].snr = sv_info->sv_list[i].snr;
        newSvStatus.sv_list[i].elevation = sv_info->sv_list[i].elevation;
        newSvStatus.sv_list[i].azimuth = sv_info->sv_list[i].azimuth;
    }

    newSvStatus.ephemeris_mask = sv_info->ephemeris_mask;
    newSvStatus.almanac_mask = sv_info->almanac_mask;
    newSvStatus.used_in_fix_mask = sv_info->used_in_fix_mask;

    originalCallbacks->create_thread_cb("gpsshim-svstatus",
            (void *) originalCallbacks->sv_status_cb, (void *) &newSvStatus);
}

typedef struct {
    GpsUtcTime timestamp;
    const char *nmea;
    int length;
} NmeaData;

static void nmea_thread(NmeaData *data)
{
    originalCallbacks->nmea_cb(data->timestamp, data->nmea, data->length);
}

static void nmea_callback(GpsUtcTime timestamp, const char* nmea, int length)
{
    static NmeaData data;
    data.timestamp = timestamp;
    data.nmea = nmea;
    data.length = length;

    originalCallbacks->create_thread_cb("gpsshim-nmea", (void *) nmea_thread,
            (void *) &data);
}

/*
 * AGPS
 */

static OldAGpsCallbacks oldAGpsCallbacks;
static const AGpsCallbacks* newAGpsCallbacks = NULL;

static void agps_status_cb(OldAGpsStatus* status)
{
    static AGpsStatus newAGpsStatus;
    newAGpsStatus.size = sizeof(AGpsStatus) - sizeof(uint32_t);
    newAGpsStatus.type = status->type;
    newAGpsStatus.status = status->status;

    ALOGD("%s: type=%d, status=%d", __func__, status->type, status->status);
    newAGpsCallbacks->create_thread_cb("gpsshim-agpsstatus",(void *)newAGpsCallbacks->status_cb,(void*)&newAGpsStatus);
    ALOGD("%s: exit", __func__);
}

static void agps_init(AGpsCallbacks * callbacks)
{
    newAGpsCallbacks = callbacks;
    oldAGpsCallbacks.status_cb = agps_status_cb;

    oldAGPS->init(&oldAGpsCallbacks);
}

static int agps_set_server(AGpsType type, const char* hostname, int port)
{
    int ret;

    if (type == AGPS_TYPE_SUPL)
        suplHost = hostname;

    ALOGD("%s: enter hostname=%s, port=%d", __func__, hostname, port);
    ret = oldAGPS->set_server(type, hostname, port);
    ALOGD("%s: exit ret=%d", __func__, ret);

    return ret;
}

static int agps_data_conn_open(const char* apn)
{
    int ret;
    ALOGD("%s: enter %s", __func__, apn);
    ret = oldAGPS->data_conn_open(apn);
    ALOGD("%s: exit ret=%d", __func__, ret);
    return ret;
}

static int agps_data_conn_closed()
{
    int ret;
    ALOGD("%s: enter", __func__);
    ret = oldAGPS->data_conn_closed();
    ALOGD("%s: exit ret=%d", __func__, ret);
    return ret;
}

static int agps_data_conn_failed()
{
    int ret;
    ALOGD("%s: enter", __func__);
    ret = oldAGPS->data_conn_failed();
    ALOGD("%s: exit ret=%d", __func__, ret);
    return ret;
}

/*
 * AGPSRIL
 */

static OldAGpsRilCallbacks oldAGpsRilCallbacks;
static const AGpsRilCallbacks* newAGpsRilCallbacks = NULL;

static void agpsril_refloc_cb(uint32_t flags)
{
    ALOGV("AGPSRIL refloc callback");
    ALOGD("%s: enter", __func__);
    newAGpsRilCallbacks->create_thread_cb("gpsshim-agpsril-refloc",(void *)newAGpsRilCallbacks->request_refloc,&flags);
    ALOGD("%s: exit", __func__);
}

static void agpsril_set_ref_location(const AGpsRefLocation *agps_reflocation,
        size_t sz_struct)
{
    static OldAGpsRefLocation loc;
    loc.type = agps_reflocation->type;
    loc.mcc = agps_reflocation->u.cellID.mcc;
    loc.mnc = agps_reflocation->u.cellID.mnc;
    loc.cid = agps_reflocation->u.cellID.cid;

    // Just in case...
    ALOGD("%s: got type=%d, mcc=%d, mnc=%d, cid=%d, sz_struct=%d", __func__,
            loc.type, loc.mcc, loc.mnc, loc.cid, sz_struct);

    ALOGD("%s: enter", __func__);
    oldAGPSRIL->set_ref_location(&loc, sizeof(OldAGpsRefLocation));
    ALOGD("%s: exit", __func__);
}

static void agpsril_init(AGpsRilCallbacks * callbacks)
{
    newAGpsRilCallbacks = callbacks;
    oldAGpsRilCallbacks.request_refloc = agpsril_refloc_cb;
    ALOGV("AGPSRIL init");

    oldAGPSRIL->init(&oldAGpsRilCallbacks);
}

static const char *bytes_as_hex(unsigned char *bytes, uint_t sz)
{
    char hex[sz*2];
    int j;
    for (j = 0; j < sz; ++j) {
        sprintf(hex+j*2, "%02x", bytes[j]);
    }
    return hex;
}

static void agpsril_ni_message(uint8_t *msg, size_t len)
{
    unsigned char *hmac_result;
    ALOGD("%s: suplHost=%s", __func__, suplHost);

    hmac_result = HMAC(EVP_sha1(), suplHost, suplHost ? strlen(suplHost) : 0,
            msg, len, NULL, NULL);

    if (hmac_result == NULL) {
        ALOGE("%s: HMAC computation failed!", __func__);
    } else {
        ALOGV("%s: HMAC = %s", __func__, bytes_as_hex(hmac_result, 20));
    }

    oldAGPSRIL->ni_message(msg, hmac_result);
    ALOGV("%s: Sent NI message", __func__);
}

/*
 * NI
 */

static void ni_init(GpsNiCallbacks *callbacks)
{
    ALOGD("%s: enter %x", __func__, callbacks);
    oldNI->init(callbacks);
    ALOGD("%s: exit", __func__);
}

static void ni_respond(int notif_id, GpsUserResponseType user_response)
{
    ALOGD("%s: enter %d %llu", __func__, notif_id, user_response);
    oldNI->respond(notif_id, user_response);
    ALOGD("%s: exit", __func__);
}

static const void* get_extension(const char* name)
{
    void *mod;
    ALOGD("%s: trying to load %s", __func__, name);

    if (!strcmp(name, AGPS_INTERFACE) && (oldAGPS = originalGpsInterface->get_extension(name))) {
        newAGPS.size = sizeof(AGpsInterface);
        newAGPS.init = agps_init;
        newAGPS.data_conn_open = agps_data_conn_open;
        newAGPS.data_conn_closed = agps_data_conn_closed;
        newAGPS.data_conn_failed = agps_data_conn_failed;
        newAGPS.set_server = agps_set_server;
        mod = &newAGPS;
    } else if (!strcmp(name, AGPS_RIL_INTERFACE) && (oldAGPSRIL = originalGpsInterface->get_extension(name))) {
        newAGPSRIL.size = sizeof(AGpsRilInterface);
        newAGPSRIL.init = agpsril_init;
        newAGPSRIL.set_ref_location = agpsril_set_ref_location;
        newAGPSRIL.ni_message = agpsril_ni_message;
        mod = &newAGPSRIL;
    } else if (strcmp(name, GPS_NI_INTERFACE) == 0 && (oldNI = originalGpsInterface->get_extension(name))) {
        newNI.size = sizeof(GpsNiInterface);
        newNI.init = ni_init;
        newNI.respond = ni_respond;
        mod = &newNI;
    }

    if (!mod) {
        if (originalGpsInterface->get_extension(name))
            ALOGE("%s: original GPS interface could load %s!", __func__);
        return NULL;
    }

    ALOGD("%s: loaded", __func__);

    return mod;
}

static int init(GpsCallbacks* callbacks)
{
    static OldGpsCallbacks oldCallbacks;
    ALOGV("init_wrapper was called");

    originalCallbacks = callbacks;
    oldCallbacks.location_cb = location_callback;
    oldCallbacks.status_cb = status_callback;
    oldCallbacks.sv_status_cb = svstatus_callback;
    oldCallbacks.nmea_cb = nmea_callback;
    originalCallbacks->set_capabilities_cb(GPS_CAPABILITY_MSB |
                                           GPS_CAPABILITY_MSA |
                                           GPS_CAPABILITY_SINGLE_SHOT);

    return originalGpsInterface->init(&oldCallbacks);
}

static int set_position_mode(GpsPositionMode mode, GpsPositionRecurrence recurrence,
        uint32_t min_interval, uint32_t preferred_accuracy, uint32_t preferred_time)
{
    int ret, freq;
    freq = recurrence ? 0 : (min_interval / 1000);

    ALOGD("%s: enter freq=%d", __func__, freq);
    ret = originalGpsInterface->set_position_mode(mode, freq);
    ALOGD("%s: exit ret=%d", __func__, ret);

    return ret;
}

static int stop()
{
    int ret;

    ALOGD("%s: enter", __func__);
    ret = originalGpsInterface->stop();
    ALOGD("%s: exit ret=%d", __func__, ret);

    originalCallbacks->release_wakelock_cb();

    return ret;
}

static int start()
{
    int ret;

    originalCallbacks->acquire_wakelock_cb();

    ALOGD("%s: enter", __func__);
    ret = originalGpsInterface->start();
    ALOGD("%s: exit ret=%d", __func__, ret);

    return ret;
}

static void cleanup()
{
    ALOGD("%s: enter", __func__);
    originalGpsInterface->cleanup();
    ALOGD("%s: exit", __func__);
}

// Not used?
static int inject_time(GpsUtcTime timestamp, int64_t timeReference, int uncertainty)
{
    int ret;

    ALOGD("%s: enter %llu, %llu, %d", __func__, timestamp, timeReference, uncertainty);
    ret = originalGpsInterface->inject_time(timestamp, timeReference, uncertainty);
    ALOGD("%s: exit ret=%d", __func__, ret);

    return ret;
}

// Not used?
static int inject_location(double latitude, double longitude, float accuracy)
{
    int ret;

    ALOGD("%s: enter %Lf %Lf %f", __func__, latitude, longitude, accuracy);
    ret = originalGpsInterface->inject_location(latitude, longitude, accuracy);
    ALOGD("%s: exit ret=%d", __func__, ret);

    return ret;
}

static void delete_aiding_data(GpsAidingData flags)
{
    ALOGD("%s: enter %llu", __func__, flags);
    originalGpsInterface->delete_aiding_data(flags);
    ALOGD("%s: exit", __func__);
}

/* HAL Methods */
const GpsInterface* get_gps_interface(struct gps_device_t* dev)
{
	ALOGD("Getting interface...");

    if (getHardwareInterface == NULL)
        return NULL;

    originalGpsInterface = getHardwareInterface();

    newGpsInterface.size = sizeof(GpsInterface);
    newGpsInterface.init = init;
    newGpsInterface.start = start;
    newGpsInterface.stop = stop;
    newGpsInterface.cleanup = cleanup;
    newGpsInterface.inject_time = inject_time;
    newGpsInterface.inject_location = inject_location;
    newGpsInterface.delete_aiding_data = delete_aiding_data;
    newGpsInterface.set_position_mode = set_position_mode;
    newGpsInterface.get_extension = get_extension;

    return &newGpsInterface;
}

static int close_gps(struct hw_device_t *device)
{
    ALOGV("Closing GPS module...");
    dlclose(hal);
    return 0;
}

static int open_gps(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    struct gps_device_t *dev = malloc(sizeof(struct gps_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*) module;
    dev->common.close = close_gps;

    ALOGD("Loading Samsung HAL...");
    hal = dlopen("/vendor/lib/libsamsung_hwlegacy.so", RTLD_LAZY);
    if (hal != NULL) {
        getHardwareInterface = (gps_get_hardware_interface_t) dlsym(hal, "gps_get_hardware_interface");
        if (getHardwareInterface == NULL) {
            ALOGE("Could not get interface functor. %s", dlerror());
        }
    } else {
        ALOGE("Could not load! %s", dlerror());
    }

    dev->get_gps_interface = get_gps_interface;

    *device = (struct hw_device_t*)dev;
    return 0;
}

static struct hw_module_methods_t gps_module_methods = {
    .open = open_gps
};

struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = GPS_HARDWARE_MODULE_ID,
    .name = "Vibrant GPS HAL Wrapper Module",
    .author = "The CyanogenMod Project",
    .methods = &gps_module_methods,
};
