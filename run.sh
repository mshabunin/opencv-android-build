#!/bin/bash

set -e

TAG=opencv_android_builder
docker build -t ${TAG} .
docker run -it \
    -v `pwd`/scripts:/scripts:ro \
    -v `pwd`/workspace:/workspace \
    --user $(id -u):$(id -g) \
    ${TAG} \
    /bin/bash
