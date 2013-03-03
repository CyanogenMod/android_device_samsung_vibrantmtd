#!/bin/sh

# device/samsung/vibrantmtd/copy-files-from-nightly.sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Unpack the nightly zip into:
NIGHTLY=../../../../nightly

DEVICE=vibrantmtd
COMMON=aries-common
MANUFACTURER=samsung

mkdir -p ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
mkdir -p ../../../vendor/$MANUFACTURER/$COMMON/proprietary

# vibrantmtd
cp -p $NIGHTLY/system/lib/libclientgps.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/lib/libril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/lib/libsecril-client.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/lib/libsec-ril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/bin/rild ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/vendor/lib/hw/gps.aries.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/system/vendor/bin/gpsd ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/agpsd
cp -p $NIGHTLY/system/lib/libcamera.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
cp -p $NIGHTLY/modem.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary

# aries-common
cp -p $NIGHTLY/system/vendor/bin/pvrsrvinit ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/firmware/bcm4329.hcd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/firmware/nvram_net.txt ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/firmware/cypress-touchkey.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/firmware/samsung_mfc_fw.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/egl/libGLES_android.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/hw/gralloc.aries.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libakm.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libglslcompiler.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libIMGegl.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libpvr2d.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libpvrANDROID_WSEGL.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libPVRScopeServices.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libsrv_init.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libsrv_um.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/firmware/CE147F02.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary/svf_CE147F02.bin
cp -p $NIGHTLY/system/vendor/lib/libusc.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libsensor_yamaha_test.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/lib/libsensorservice.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/bin/orientationd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/vendor/bin/geomagneticd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libActionShot.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libarccamera.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libcamera_client.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libcamerafirmwarejni.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libcameraservice.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libCaMotion.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libcaps.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libPanoraMax1.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libPlusMe.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libs3cjpeg.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libseccamera.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libseccameraadaptor.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libsecjpegencoder.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libtvout.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/lib_tvoutengine.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libtvoutfimc.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libtvouthdmi.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/lib/libtvoutservice.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/bin/tvoutserver ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/cameradata/datapattern_420sp.yuv ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/cameradata/datapattern_front_420sp.yuv ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/firmware/CE147F00.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/firmware/CE147F01.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/firmware/CE147F02.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
cp -p $NIGHTLY/system/firmware/CE147F03.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary


(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES := \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libcamera.so:obj/lib/libcamera.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libril.so:obj/lib/libril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsecril-client.so:obj/lib/libsecril-client.so


# All the blobs necessary for galaxys _DEVICE_ devices
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libclientgps.so:system/lib/libclientgps.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libril.so:system/lib/libril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsec-ril.so:system/lib/libsec-ril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/rild:system/bin/rild \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gps.aries.so:system/vendor/lib/hw/gps.aries.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/agpsd:system/vendor/bin/gpsd \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libcamera.so:system/lib/libcamera.so
EOF


(cat << EOF) | sed s/__COMMON__/$COMMON/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$COMMON/aries-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# All the blobs necessary for galaxys devices
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/pvrsrvinit:system/vendor/bin/pvrsrvinit \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/bcm4329.hcd:system/vendor/firmware/bcm4329.hcd \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/nvram_net.txt:system/vendor/firmware/nvram_net.txt \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/cypress-touchkey.bin:system/vendor/firmware/cypress-touchkey.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/__MANUFACTURER___mfc_fw.bin:system/vendor/firmware/__MANUFACTURER___mfc_fw.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libGLES_android.so:system/lib/egl/libGLES_android.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libEGL_POWERVR_SGX540_120.so:system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libGLESv1_CM_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libGLESv2_POWERVR_SGX540_120.so:system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/gralloc.aries.so:system/vendor/lib/hw/gralloc.aries.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libakm.so:system/vendor/lib/libakm.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libglslcompiler.so:system/vendor/lib/libglslcompiler.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libIMGegl.so:system/vendor/lib/libIMGegl.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libpvr2d.so:system/vendor/lib/libpvr2d.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libpvrANDROID_WSEGL.so:system/vendor/lib/libpvrANDROID_WSEGL.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libPVRScopeServices.so:system/vendor/lib/libPVRScopeServices.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsrv_init.so:system/vendor/lib/libsrv_init.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsrv_um.so:system/vendor/lib/libsrv_um.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/svf_CE147F02.bin:system/vendor/firmware/CE147F02.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libusc.so:system/vendor/lib/libusc.so


# vibrantmtd uses older sensor drivers
ifndef TARGET_USES_OLD_LIBSENSORS_HAL
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsensor_yamaha_test.so:system/vendor/lib/libsensor_yamaha_test.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsensorservice.so:system/vendor/lib/libsensorservice.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/orientationd:system/vendor/bin/orientationd \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/geomagneticd:system/vendor/bin/geomagneticd
endif

# camera and tvout
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libActionShot.so:system/lib/libActionShot.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libarccamera.so:system/lib/libarccamera.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcamera_client.so:system/lib/libcamera_client.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcamerafirmwarejni.so:system/lib/libcamerafirmwarejni.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcameraservice.so:system/lib/libcameraservice.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libCaMotion.so:system/lib/libCaMotion.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libcaps.so:system/lib/libcaps.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libPanoraMax1.so:system/lib/libPanoraMax1.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libPlusMe.so:system/lib/libPlusMe.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libs3cjpeg.so:system/lib/libs3cjpeg.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libseccamera.so:system/lib/libseccamera.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libseccameraadaptor.so:system/lib/libseccameraadaptor.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsecjpegencoder.so:system/lib/libsecjpegencoder.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvout.so:system/lib/libtvout.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_tvoutengine.so:system/lib/lib_tvoutengine.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvoutfimc.so:system/lib/libtvoutfimc.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvouthdmi.so:system/lib/libtvouthdmi.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvoutservice.so:system/lib/libtvoutservice.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/tvoutserver:system/bin/tvoutserver \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/CE147F00.bin:system/firmware/CE147F00.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/CE147F01.bin:system/firmware/CE147F01.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/CE147F02.bin:system/firmware/CE147F02.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/CE147F03.bin:system/firmware/CE147F03.bin
EOF


./setup-makefiles.sh
