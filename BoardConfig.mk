# Copyright (C) 2007 The Android Open Source Project
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

# BoardConfig.mk
#
# Product-specific compile-time definitions.
#

# Kernel Config
TARGET_KERNEL_CONFIG := cyanogenmod_vibrantmtd_defconfig

# Recovery
BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/samsung/vibrantmtd/recovery/recovery_keys.c

# Telephony
BOARD_USES_FROYO_RILCLIENT := true

TARGET_OTA_ASSERT_DEVICE := vibrant,vibrantmtd,SGH-T959

# Import the aries-common BoardConfigCommon.mk
include device/samsung/aries-common/BoardConfigCommon.mk
