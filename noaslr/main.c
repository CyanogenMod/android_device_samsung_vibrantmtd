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

#define LOG_TAG "noaslr"

#include <stdio.h>
#include <unistd.h>
#include <utils/Log.h>
#include <errno.h>
#include <sys/personality.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("usage: noaslr <executable> [arguments]\n");
        ALOGE("noaslr called improperly.");
        return 1;
    }
    char *pathToBin = argv[1];

    int currentPersonality = personality(0xFFFFFFFF);
    if (personality(currentPersonality | ADDR_NO_RANDOMIZE) == -1) {
        ALOGE("Failed to turn off ASLR for %s! errno=%d", argv[1], errno);
        return 1;
    }

    // Prepare arguments for the binary.
    argv++;
    argv[0] = pathToBin;

    ALOGD("Starting %s", pathToBin);
    execv(pathToBin, argv);

    // If we made it here, it failed (since exec replaces the running app).
    ALOGE("Failed to start %s", pathToBin);

    return 1;
}
