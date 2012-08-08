/*
 * Vibrant GPS HAL shim
 * 
 * Forked off of arcee's hardware/cm/gps
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

#include <hardware/gps.h>

#include <stdlib.h>
#include <utils/Log.h>
#include <dlfcn.h>

#include <gpsshim.h>

GpsCallbacks *originalCallbacks;
static const OldGpsXtraInterface* oldXTRA = NULL;
static GpsXtraInterface newXTRA;
static const OldAGpsInterface* oldAGPS = NULL;
static AGpsInterface newAGPS;
static const OldAGpsRilInterface* oldAGPSRIL = NULL;
static AGpsRilInterface newAGPSRIL;
static const OldGpsNiInterface* oldNI = NULL;
static GpsNiInterface newNI;

static const OldGpsInterface* originalGpsInterface = NULL;
static GpsInterface newGpsInterface;


//extern const OldGpsInterface* gps_get_hardware_interface();
typedef const OldGpsInterface* (*gps_get_hardware_interface_t)();
static gps_get_hardware_interface_t get_hardware;

static void *lib;

/*------------------------------*/
/* * * * *  General GPS * * * * */
/*------------------------------*/

static void cm_location_callback(OldGpsLocation *location) {
    static GpsLocation newLocation;
    LOGV("I have a location");
    newLocation.size = sizeof(GpsLocation);
    newLocation.flags = location->flags;
    newLocation.latitude = location->latitude;
    newLocation.longitude = location->longitude;
    newLocation.altitude = location->altitude;
    newLocation.speed = location->speed;
    newLocation.bearing = location->bearing;
    newLocation.accuracy = location->accuracy;
    newLocation.timestamp = location->timestamp;
    originalCallbacks->create_thread_cb("gpsshim-location",(void *)originalCallbacks->location_cb,(void *)&newLocation);
}

static void cm_status_callback(OldGpsStatus *status) {
    static GpsStatus newStatus;
    newStatus.size = sizeof(GpsStatus);
    LOGV("Status value is %u",status->status);
    newStatus.status = status->status;
    originalCallbacks->create_thread_cb("gpsshim-status",(void *)originalCallbacks->status_cb,(void *)&newStatus);
}

static void cm_svstatus_callback(OldGpsSvStatus *sv_info) {
    static GpsSvStatus newSvStatus;
    int i=0;
    LOGV("I have a svstatus");
    newSvStatus.size = sizeof(GpsSvStatus);
    newSvStatus.num_svs = sv_info->num_svs;
    for (i=0; i<newSvStatus.num_svs; i++) {
        newSvStatus.sv_list[i].size = sizeof(GpsSvInfo);
        newSvStatus.sv_list[i].prn = sv_info->sv_list[i].prn;
        newSvStatus.sv_list[i].snr = sv_info->sv_list[i].snr;
        newSvStatus.sv_list[i].elevation = sv_info->sv_list[i].elevation;
        newSvStatus.sv_list[i].azimuth = sv_info->sv_list[i].azimuth;
    }
    newSvStatus.ephemeris_mask = sv_info->ephemeris_mask;
    newSvStatus.almanac_mask = sv_info->almanac_mask;
    newSvStatus.used_in_fix_mask = sv_info->used_in_fix_mask;
    originalCallbacks->create_thread_cb("gpsshim-svstatus",(void *)originalCallbacks->sv_status_cb,(void *)&newSvStatus);
}

GpsUtcTime nmeasave_timestamp;
const char* nmeasave_nmea;
int nmeasave_length;

static void nmea_thread(void *unused) {
    originalCallbacks->nmea_cb(nmeasave_timestamp, nmeasave_nmea, nmeasave_length);
}

static void cm_nmea_callback(GpsUtcTime timestamp, const char* nmea, int length) {
    nmeasave_timestamp = timestamp;
    nmeasave_nmea = nmea;
    nmeasave_length = length;
    originalCallbacks->create_thread_cb("gpsshim-nmea", (void *)nmea_thread,NULL);
}

/*------------------------------*/
/* * * * *      AGPS    * * * * */
/*------------------------------*/

static OldAGpsCallbacks oldAGpsCallbacks;
static const AGpsCallbacks* newAGpsCallbacks = NULL;

static void agps_status_cb(OldAGpsStatus* status)
{
    AGpsStatus newAGpsStatus;
    newAGpsStatus.size = sizeof(AGpsStatus);
    newAGpsStatus.type = status->type;
    newAGpsStatus.status = status->status;
    newAGpsCallbacks->create_thread_cb("gpsshim-agpsstatus",(void *)newAGpsCallbacks->status_cb,(void*)&newAGpsStatus);
}

static void cm_agps_init(AGpsCallbacks * callbacks)
{
    newAGpsCallbacks = callbacks;
    oldAGpsCallbacks.status_cb = agps_status_cb;

    oldAGPS->init(&oldAGpsCallbacks);
}

/*------------------------------*/
/* * * * *   AGPS RIL   * * * * */
/*------------------------------*/

static OldAGpsRilCallbacks oldAGpsRilCallbacks;
static const AGpsRilCallbacks* newAGpsRilCallbacks = NULL;

static void agpsril_refloc_cb(uint32_t flags)
{
    LOGV("AGPSRIL refloc callback");
    newAGpsRilCallbacks->create_thread_cb("gpsshim-agpsril-refloc",(void *)newAGpsRilCallbacks->request_refloc,&flags);
}

static void agpsril_set_ref_location(const AGpsRefLocation *agps_reflocation, size_t sz_struct) {
    OldAGpsRefLocation loc;
    loc.type = agps_reflocation->type;
    loc.mcc = agps_reflocation->u.cellID.mcc;
    loc.mnc = agps_reflocation->u.cellID.mnc;
    loc.cid = agps_reflocation->u.cellID.cid;

    // Just in case...
    LOGD("%s: got type=%d, mcc=%d, mnc=%d, cid=%d, sz_struct=%d", __func__,
            loc.type, loc.mcc,
            loc.mnc, loc.cid,
            sz_struct);

    oldAGPSRIL->set_ref_location(&loc, sizeof(OldAGpsRefLocation));
}

static void cm_agpsril_init(AGpsRilCallbacks * callbacks)
{
    newAGpsRilCallbacks = callbacks;
    oldAGpsRilCallbacks.request_refloc = agpsril_refloc_cb;
    LOGV("AGPSRIL init");

    oldAGPSRIL->init(&oldAGpsRilCallbacks);
}

/*------------------------------*/
/* * * * *     XTRA     * * * * */
/*------------------------------*/

static OldGpsXtraCallbacks oldXtraCallbacks;
static const GpsXtraCallbacks* newXtraCallbacks = NULL;

static void xtra_download_cb()
{
    newXtraCallbacks->create_thread_cb("gpsshim-xtradownload",(void *)newXtraCallbacks->download_request_cb,NULL);
}

static int cm_xtra_init(GpsXtraCallbacks * callbacks)
{
    newXtraCallbacks = callbacks;
    oldXtraCallbacks.download_request_cb = xtra_download_cb;

#ifdef NEEDS_INITIAL_XTRA
    xtra_download_cb();
#endif

    return oldXTRA->init(&oldXtraCallbacks);
}

static const void* cm_get_extension(const char* name)
{
    LOGD("cm_get_extension: getting %s", name);
    if (!strcmp(name, GPS_XTRA_INTERFACE) && (oldXTRA = originalGpsInterface->get_extension(name))) {
        LOGD("cm_get_extension: loaded %s", name);
        newXTRA.size = sizeof(GpsXtraInterface);
        newXTRA.init = cm_xtra_init;
        newXTRA.inject_xtra_data = oldXTRA->inject_xtra_data;
        return &newXTRA;
    } else if (!strcmp(name, AGPS_INTERFACE) && (oldAGPS = originalGpsInterface->get_extension(name))) {
        LOGD("cm_get_extension: loaded %s", name);
        newAGPS.size = sizeof(AGpsInterface);
        newAGPS.init = cm_agps_init;
        newAGPS.data_conn_open = oldAGPS->data_conn_open;
        newAGPS.data_conn_closed = oldAGPS->data_conn_closed;
        newAGPS.data_conn_failed = oldAGPS->data_conn_failed;
        newAGPS.set_server = oldAGPS->set_server;
        return &newAGPS;
    } else if (!strcmp(name, AGPS_RIL_INTERFACE) && (oldAGPSRIL = originalGpsInterface->get_extension(name))) {
        LOGD("cm_get_extension: loaded %s", name);
        newAGPSRIL.size = sizeof(AGpsRilInterface);
        newAGPSRIL.init = cm_agpsril_init;
        newAGPSRIL.set_ref_location = agpsril_set_ref_location;
        newAGPSRIL.ni_message = oldAGPSRIL->ni_message;
        return &newAGPSRIL;
    } else if (strcmp(name, GPS_NI_INTERFACE) == 0 && (oldNI = originalGpsInterface->get_extension(name))) {
        LOGD("cm_get_extension: loaded %s", name);
        newNI.size = sizeof(GpsNiInterface);
        newNI.init = oldNI->init;
        newNI.respond = oldNI->respond;
        return &newNI;
    }

    LOGD("cm_get_extension: did not load %s", name);
    return NULL;
}

static int cm_init(GpsCallbacks* callbacks) {
    LOGV("init_wrapper was called");

    static OldGpsCallbacks oldCallbacks;
    originalCallbacks = callbacks;
    oldCallbacks.location_cb = cm_location_callback;
    oldCallbacks.status_cb = cm_status_callback;
    oldCallbacks.sv_status_cb = cm_svstatus_callback;
    oldCallbacks.nmea_cb = cm_nmea_callback;
#ifdef NO_AGPS
    originalCallbacks->set_capabilities_cb(0);
#else
    originalCallbacks->set_capabilities_cb(GPS_CAPABILITY_MSB|GPS_CAPABILITY_MSA);
#endif
    return originalGpsInterface->init(&oldCallbacks);
}

static int cm_set_position_mode(GpsPositionMode mode, GpsPositionRecurrence recurrence,  uint32_t min_interval, uint32_t preferred_accuracy, uint32_t preferred_time) {
    return originalGpsInterface->set_position_mode(mode, recurrence ? 0 : (min_interval/1000));
}

static int cm_stop() {
    int ret = originalGpsInterface->stop();
    originalCallbacks->release_wakelock_cb();
    return ret;
}

static int cm_start() {
    originalCallbacks->acquire_wakelock_cb();
    return originalGpsInterface->start();
}

/* HAL Methods */
const GpsInterface* cm_get_gps_interface(struct gps_device_t* dev)
{
	LOGD("Getting interface...");

    if (get_hardware == NULL)
        return NULL;

    originalGpsInterface = get_hardware();

    newGpsInterface.size = sizeof(GpsInterface);
    newGpsInterface.init = cm_init;
    newGpsInterface.start = cm_start;
    newGpsInterface.stop = cm_stop;
    newGpsInterface.cleanup = originalGpsInterface->cleanup;
    newGpsInterface.inject_time = originalGpsInterface->inject_time;
    newGpsInterface.inject_location = originalGpsInterface->inject_location;
    newGpsInterface.delete_aiding_data = originalGpsInterface->delete_aiding_data;
    newGpsInterface.set_position_mode = cm_set_position_mode;
    newGpsInterface.get_extension = cm_get_extension;

    return &newGpsInterface;
}

static int open_gps(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    struct gps_device_t *dev = malloc(sizeof(struct gps_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*) module;

    LOGD("Loading Samsung HAL...");
    lib = dlopen("/vendor/lib/libsamsung_hwlegacy.so", RTLD_LAZY);
    if (lib == NULL) {
        LOGE("Could not load!");
        LOGE("Error: %s", dlerror());
    } else {
        LOGD("Loaded!");
        get_hardware = (gps_get_hardware_interface_t) dlsym(lib, "gps_get_hardware_interface");
        if (get_hardware == NULL) {
            LOGE("Could not get interface functor.");
            LOGE("Error: %s", dlerror());
        }
    }

    dev->get_gps_interface = cm_get_gps_interface;

    *device = (struct hw_device_t*)dev;
    return 0;
}

static struct hw_module_methods_t gps_module_methods = {
    .open = open_gps
};

const struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = GPS_HARDWARE_MODULE_ID,
    .name = "Vibrant GPS HAL Wrapper Module",
    .author = "The CyanogenMod Project",
    .methods = &gps_module_methods,
};
