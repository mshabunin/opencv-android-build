#!/usr/bin/env bash

set -ex

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/_vars.sh

export PATH=${JAVA_HOME}/bin:${ANDROID_SDK_ROOT}/cmake/${V_CMAKE}/bin:${PATH}

[ -d opencv ] || git clone --depth=1 https://github.com/opencv/opencv

mkdir -p build
pushd build && rm -rf *
python3 /workspace/opencv/platforms/android/build_sdk.py --config ndk-25.config.py . ../opencv

# mkdir -p build
# pushd build && rm -rf *
# # gradle etc. version from config for ndk 22 from package build script
# cmake \
#     -GNinja \
#     -DCMAKE_TOOLCHAIN_FILE=${ANDROID_SDK_ROOT}/ndk/${V_NDK}/build/cmake/android.toolchain.cmake \
#     -DANDROID_SDK_TOOLS=${ANDROID_SDK_ROOT}/platform-tools \
#     -DANDROID_ABI=x86_64 \
#     -DCMAKE_INSTALL_PREFIX=install \
#     -DANDROID_GRADLE_PLUGIN_VERSION=4.1.2 \
#     -DGRADLE_VERSION=6.5 \
#     -DKOTLIN_PLUGIN_VERSION=1.5.10 \
#     -DCMAKE_BUILD_TYPE=Release \
#     ../opencv
# ninja install
# popd
#
# pushd build/install/samples
# ./gradlew bundle
# popd
