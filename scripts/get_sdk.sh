#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/_vars.sh

#cleanup


wget -nc https://dl.google.com/android/repository/${FNAME}
ASUM=$(sha256sum ${FNAME} | cut -d ' ' -f 1)
if [ "${FSUM}" != "${ASUM}" ] ; then
    echo "Checksum wrong"
    exit 1
fi

[ -d ./cmdline-tools ] && rm -rf ./cmdline-tools
unzip ${FNAME}
chmod +x cmdline-tools/bin/sdkmanager
./cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --update
yes | ./cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses
./cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install \
    "build-tools;${V_BUILDTOOLS}" \
    "cmake;${V_CMAKE}" \
    "ndk;${V_NDK}" \
    'platform-tools' \
    'platforms;android-33' \
    'system-images;android-33;google_apis;x86_64' \
    'tools'
