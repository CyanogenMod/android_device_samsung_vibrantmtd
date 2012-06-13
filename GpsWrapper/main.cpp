/*
 * Copyright (C) 2012 Daniel Bateman
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "VibrantGps"

#include <stdio.h>
#include <unistd.h>
#include <utils/Log.h>
#include <errno.h>
#include <sys/personality.h>

#define GPSD_PATH "/system/vendor/bin/samsung-gpsd"

int main() {
    int cur = personality(0xFFFFFFFF);
    char *argv[] = { GPSD_PATH, NULL };
    if (personality(cur | ADDR_NO_RANDOMIZE) == -1) {
        LOGE("Failed to set personality! errno=%d", errno);
        return 1;
    }

    LOGD("Starting vendor gpsd");
    execv(GPSD_PATH, argv);
    LOGE("Failed to start gpsd!");

    return 1;
}
