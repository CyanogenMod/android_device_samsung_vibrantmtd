#!/bin/sh

VENDOR=samsung
DEVICE=vibrantmtd
COMMON=aries-common

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
done

./setup-makefiles.sh

# Get common files
echo "Fetching $COMMON files..."
cd ../$COMMON
./extract-files.sh
cd ../$DEVICE
