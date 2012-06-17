#!/bin/sh

VENDOR=samsung
DEVICE=vibrantmtd
COMMON=aries-common

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

# Get common files
(cd ../$COMMON && ./extract-files.sh)

echo "Pulling device files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
done

# Modem
echo "Pulling modem..."
adb pull /radio/modem.bin $BASE/modem.bin

./setup-makefiles.sh
