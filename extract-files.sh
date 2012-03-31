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
adb pull /system/lib/libclientgps.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/vendor/bin/gpsd ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/vendor/lib/hw/gps.aries.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/etc/gps.conf ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/lib/libril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/lib/libsecril-client.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/lib/libsec-ril.so ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /system/bin/rild ../../../vendor/$MANUFACTURER/$DEVICE/proprietary
adb pull /radio/modem.bin ../../../vendor/$MANUFACTURER/$DEVICE/proprietary

# aries-common
adb pull /system/vendor/bin/pvrsrvinit ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/firmware/bcm4329.hcd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/firmware/nvram_net.txt ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/firmware/cypress-touchkey.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/firmware/samsung_mfc_fw.bin ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/egl/libGLES_android.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/egl/libEGL_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/egl/libGLESv1_CM_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/egl/libGLESv2_POWERVR_SGX540_120.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/hw/gralloc.aries.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libakm.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libglslcompiler.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libIMGegl.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libpvr2d.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libpvrANDROID_WSEGL.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libPVRScopeServices.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libsrv_init.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libsrv_um.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libusc.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/lib/libsensor_yamaha_test.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/bin/orientationd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/vendor/bin/geomagneticd ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/libtvout.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/libtvout_jni.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/lib_tvoutengine.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/libtvoutfimc.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/libtvouthdmi.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/lib/libtvoutservice.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/bin/tvoutserver ../../../vendor/$MANUFACTURER/$COMMON/proprietary
adb pull /system/bin/charging_mode ../../../vendor/$MANUFACTURER/$COMMON/proprietary/charging_mode
adb pull /system/bin/playlpm ../../../vendor/$MANUFACTURER/$COMMON/proprietary/playlpm
adb pull /system/lib/libQmageDecoder.so ../../../vendor/$MANUFACTURER/$COMMON/proprietary/libQmageDecoder.so
adb pull /system/media/battery_charging_10.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_10.qmg
adb pull /system/media/battery_charging_100.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_100.qmg
adb pull /system/media/battery_charging_15.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_15.qmg
adb pull /system/media/battery_charging_20.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_20.qmg
adb pull /system/media/battery_charging_25.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_25.qmg
adb pull /system/media/battery_charging_30.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_30.qmg
adb pull /system/media/battery_charging_35.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_35.qmg
adb pull /system/media/battery_charging_40.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_40.qmg
adb pull /system/media/battery_charging_45.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_45.qmg
adb pull /system/media/battery_charging_5.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_5.qmg
adb pull /system/media/battery_charging_50.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_50.qmg
adb pull /system/media/battery_charging_55.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_55.qmg
adb pull /system/media/battery_charging_60.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_60.qmg
adb pull /system/media/battery_charging_65.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_65.qmg
adb pull /system/media/battery_charging_70.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_70.qmg
adb pull /system/media/battery_charging_75.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_75.qmg
adb pull /system/media/battery_charging_80.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_80.qmg
adb pull /system/media/battery_charging_85.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_85.qmg
adb pull /system/media/battery_charging_90.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_90.qmg
adb pull /system/media/battery_charging_95.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/battery_charging_95.qmg
adb pull /system/media/chargingwarning.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/chargingwarning.qmg
adb pull /system/media/Disconnected.qmg ../../../vendor/$MANUFACTURER/$COMMON/proprietary/Disconnected.qmg

(cat << EOF) | sed s/__COMMON__/$COMMON/g | sed s/__DEVICE__/$DEVICE/g | sed s/__MANUFACTURER__/$MANUFACTURER/g > ../../../vendor/$MANUFACTURER/$DEVICE/$DEVICE-vendor-blobs.mk
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
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gps.conf:system/etc/gps.conf \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gpsd:system/vendor/bin/gpsd \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gps.xml:system/vendor/etc/gps.xml \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/gps.aries.so:system/vendor/lib/hw/gps.aries.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libril.so:system/lib/libril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsecril-client.so:system/lib/libsecril-client.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/libsec-ril.so:system/lib/libsec-ril.so \\
    vendor/__MANUFACTURER__/__DEVICE__/proprietary/rild:system/bin/rild \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libsensor_yamaha_test.so:system/vendor/lib/libsensor_yamaha_test.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/orientationd:system/vendor/bin/orientationd \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/geomagneticd:system/vendor/bin/geomagneticd

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
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libusc.so:system/vendor/lib/libusc.so \\

# tvout
PRODUCT_COPY_FILES += \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvout.so:system/lib/libtvout.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvout_jni.so:system/lib/libtvout_jni.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/lib_tvoutengine.so:system/lib/lib_tvoutengine.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvoutfimc.so:system/lib/libtvoutfimc.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvouthdmi.so:system/lib/libtvouthdmi.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/libtvoutservice.so:system/lib/libtvoutservice.so \\
    vendor/__MANUFACTURER__/__COMMON__/proprietary/tvoutserver:system/bin/tvoutserver \\

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
