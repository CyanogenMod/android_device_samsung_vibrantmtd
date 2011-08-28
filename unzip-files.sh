#!/bin/sh

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

DEVICE=vibrantmtd
COMMON=aries-common
MANUFACTURER=samsung

mkdir -p ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
mkdir -p ../../../vendor/$MANUFACTURER/$COMMON/proprietary

# vibrantmtd
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libclientgps.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libril.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libsecril-client.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libsec-ril.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/bin/rild -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/hw/gps.aries.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/bin/gpsd -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/agpsd
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libsamsungcamera.so -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary/libcamera.so
unzip -j -o ../../../${DEVICE}_update.zip modem.bin -d ../../../vendor/$MANUFACTURER/$DEVICE/proprietary

# aries-common
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/bin/pvrsrvinit -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/firmware/bcm4329.hcd -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/firmware/nvram_net.txt -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/firmware/cypress-touchkey.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/firmware/samsung_mfc_fw.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/egl/libGLES_android.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/hw/gralloc.aries.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libakm.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libglslcompiler.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libIMGegl.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libpvr2d.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libpvrANDROID_WSEGL.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libPVRScopeServices.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libsrv_init.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libsrv_um.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/firmware/CE147F02.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libusc.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libsensor_yamaha_test.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/lib/libsensorservice.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/bin/orientationd -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/vendor/bin/geomagneticd -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libActionShot.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libarccamera.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libcamera_client.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libcamerafirmwarejni.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libcameraservice.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libCaMotion.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libcaps.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libPanoraMax1.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libPlusMe.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libs3cjpeg.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libseccamera.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libseccameraadaptor.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libsecjpegencoder.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libtvout.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/lib_tvoutengine.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libtvoutfimc.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libtvouthdmi.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libtvoutservice.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/bin/tvoutserver -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/cameradata/datapattern_420sp.yuv -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/cameradata/datapattern_front_420sp.yuv -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/firmware/CE147F00.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/firmware/CE147F01.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/firmware/CE147F02.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/firmware/CE147F03.bin -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary
unzip -j -o ../../../${DEVICE}_update.zip system/bin/charging_mode -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/charging_mode
unzip -j -o ../../../${DEVICE}_update.zip system/bin/playlpm -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/playlpm
unzip -j -o ../../../${DEVICE}_update.zip system/lib/libQmageDecoder.so -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/libQmageDecoder.so
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_10.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_10.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_100.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_100.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_15.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_15.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_20.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_20.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_25.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_25.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_30.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_30.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_35.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_35.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_40.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_40.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_45.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_45.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_5.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_5.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_50.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_50.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_55.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_55.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_60.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_60.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_65.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_65.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_70.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_70.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_75.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_75.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_80.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_80.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_85.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_85.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_90.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_90.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/battery_charging_95.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_95.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/chargingwarning.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/chargingwarning.qmg
unzip -j -o ../../../${DEVICE}_update.zip system/media/Disconnected.qmg -d ../../../vendor/$MANUFACTURER/$COMMON/proprietary/Disconnected.qmg

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
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libril.so:obj/lib/libril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsecril-client.so:obj/lib/libsecril-client.so


# All the blobs necessary for galaxys devices
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libclientgps.so:system/lib/libclientgps.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libril.so:system/lib/libril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsec-ril.so:system/lib/libsec-ril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gps.aries.so:system/vendor/lib/hw/gps.aries.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/rild:system/bin/rild \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/agpsd:system/vendor/bin/gpsd \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libcamera.so:system/lib/libsamsungcamera.so
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
    vendor/__MANUFACTURER__/__COMMON__/proprietary/CE147F02.bin:system/vendor/firmware/CE147F02.bin \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libusc.so:system/vendor/lib/libusc.so

# fascinatemtd uses older sensor drivers
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

# low power mode
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/charging_mode:system/bin/charging_mode \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/playlpm:system/bin/playlpm \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/Disconnected.qmg:system/media/Disconnected.qmg
EOF


./setup-makefiles.sh
