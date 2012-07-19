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

#include <hardware/gps.h>

#define LOG_NDEBUG 0

#include <stdlib.h>
#define LOG_TAG "gps.aries"
#include <utils/Log.h>

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

extern const OldGpsInterface* gps_get_hardware_interface();

/*------------------------------*/
/* * * * *  General GPS * * * * */
/*------------------------------*/

static void location_callback_wrapper(OldGpsLocation *location) {
    static GpsLocation newLocation;
    ALOGV("I have a location");
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

static void status_callback_wrapper(OldGpsStatus *status) {
    static GpsStatus newStatus;
    newStatus.size = sizeof(GpsStatus);
    ALOGV("Status value is %u",status->status);
    newStatus.status = status->status;
    originalCallbacks->create_thread_cb("gpsshim-status",(void *)originalCallbacks->status_cb,(void *)&newStatus);
}

static void svstatus_callback_wrapper(OldGpsSvStatus *sv_info) {
    static GpsSvStatus newSvStatus;
    int i=0;
    ALOGV("I have a svstatus");
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

GpsUtcTime nmeasave_timestamp; const char* nmeasave_nmea; int nmeasave_length;

static void nmea_callback(void *unused) {
    ALOGV("Invoking nmea callback");
    originalCallbacks->nmea_cb(nmeasave_timestamp, nmeasave_nmea, nmeasave_length);
}

static void nmea_callback_wrapper(GpsUtcTime timestamp, const char* nmea, int length) {
    nmeasave_timestamp = timestamp; nmeasave_nmea = nmea; nmeasave_length=length;
    originalCallbacks->create_thread_cb("gpsshim-nmea",(void *)nmea_callback,NULL);
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

static void agps_init_wrapper(AGpsCallbacks * callbacks)
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

static void agpsril_setid_cb(uint32_t flags)
{
    ALOGV("AGPSRIL setid callback");
    newAGpsRilCallbacks->create_thread_cb("gpsshim-agpsril-setid",(void *)newAGpsRilCallbacks->request_setid,&flags);
}

static void agpsril_refloc_cb(uint32_t flags)
{
    ALOGV("AGPSRIL refloc callback");
    newAGpsRilCallbacks->create_thread_cb("gpsshim-agpsril-refloc",(void *)newAGpsRilCallbacks->request_refloc,&flags);
}

static void agpsril_init_wrapper(AGpsRilCallbacks * callbacks)
{
    newAGpsRilCallbacks = callbacks;
    oldAGpsRilCallbacks.request_setid = agpsril_setid_cb;
    oldAGpsRilCallbacks.request_refloc = agpsril_refloc_cb;
    ALOGV("AGPSRIL init");

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

static int xtra_init_wrapper(GpsXtraCallbacks * callbacks)
{
    newXtraCallbacks = callbacks;
    oldXtraCallbacks.download_request_cb = xtra_download_cb;

#ifdef NEEDS_INITIAL_XTRA
    xtra_download_cb();
#endif

    return oldXTRA->init(&oldXtraCallbacks);
}

static const void* wrapper_get_extension(const char* name)
{
    if (!strcmp(name, GPS_XTRA_INTERFACE) &&
            (oldXTRA = originalGpsInterface->get_extension(name))) {
        newXTRA.size = sizeof(GpsXtraInterface);
        newXTRA.init = xtra_init_wrapper;
        newXTRA.inject_xtra_data = oldXTRA->inject_xtra_data;
        return &newXTRA;
    } else if (!strcmp(name, AGPS_INTERFACE) &&
            (oldAGPS = originalGpsInterface->get_extension(name))) {
        newAGPS.size = sizeof(AGpsInterface);
        newAGPS.init = agps_init_wrapper;
        newAGPS.data_conn_open = oldAGPS->data_conn_open;
        newAGPS.data_conn_closed = oldAGPS->data_conn_closed;
        newAGPS.data_conn_failed = oldAGPS->data_conn_failed;
        newAGPS.set_server = oldAGPS->set_server;
        return &newAGPS;
    } else if (!strcmp(name, AGPS_RIL_INTERFACE) &&
            (oldAGPSRIL = originalGpsInterface->get_extension(name))) {
        newAGPSRIL.size = sizeof(AGpsRilInterface);
        newAGPSRIL.init = agpsril_init_wrapper;
        newAGPSRIL.set_ref_location = oldAGPSRIL->set_ref_location;
        newAGPSRIL.set_set_id = oldAGPSRIL->set_set_id;
        newAGPSRIL.ni_message = oldAGPSRIL->ni_message;
        return &newAGPSRIL;
    } else if (strcmp(name, GPS_NI_INTERFACE) == 0) {
        oldNI = originalGpsInterface->get_extension(name);
        newNI.size = sizeof(GpsNiInterface);
        newNI.init = oldNI->init;
        newNI.respond = oldNI->respond;
        return &newNI;
    }

    return NULL;
}

static int  init_wrapper(GpsCallbacks* callbacks) {
    ALOGV("init_wrapper was called");
    static OldGpsCallbacks oldCallbacks;
    originalCallbacks = callbacks;
    oldCallbacks.location_cb = location_callback_wrapper;
    oldCallbacks.status_cb = status_callback_wrapper;
    oldCallbacks.sv_status_cb = svstatus_callback_wrapper;
    oldCallbacks.nmea_cb = nmea_callback_wrapper;
#ifdef NO_AGPS
    originalCallbacks->set_capabilities_cb(0);
#else
    originalCallbacks->set_capabilities_cb(GPS_CAPABILITY_MSB|GPS_CAPABILITY_MSA);
#endif
    return originalGpsInterface->init(&oldCallbacks);
}

static int set_position_mode_wrapper(GpsPositionMode mode, GpsPositionRecurrence recurrence,  uint32_t min_interval, uint32_t preferred_accuracy, uint32_t preferred_time) {
    return originalGpsInterface->set_position_mode(mode, recurrence ? 0 : (min_interval/1000));
}

static int stop_wrapper() {
    int ret = originalGpsInterface->stop();
    originalCallbacks->release_wakelock_cb();
    return ret;
}

static int start_wrapper() {
    originalCallbacks->acquire_wakelock_cb();
    return originalGpsInterface->start();
}

/* HAL Methods */
const GpsInterface* gps__get_gps_interface(struct gps_device_t* dev)
{
	ALOGV("get_interface was called");
    originalGpsInterface = gps_get_hardware_interface();

    newGpsInterface.size = sizeof(GpsInterface);
    newGpsInterface.init = init_wrapper;
    newGpsInterface.start = start_wrapper;
    newGpsInterface.stop = stop_wrapper;
    newGpsInterface.cleanup = originalGpsInterface->cleanup;
    newGpsInterface.inject_time = originalGpsInterface->inject_time;
    newGpsInterface.inject_location = originalGpsInterface->inject_location;
    newGpsInterface.delete_aiding_data = originalGpsInterface->delete_aiding_data;
    newGpsInterface.set_position_mode = set_position_mode_wrapper;
    newGpsInterface.get_extension = wrapper_get_extension;


    return &newGpsInterface;
}

static int open_gps(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    struct gps_device_t *dev = malloc(sizeof(struct gps_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->get_gps_interface = gps__get_gps_interface;

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
    .author = "Daniel Bateman, Ricardo Cerquiera",
    .methods = &gps_module_methods,
};
