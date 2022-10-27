FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk-headless \
    ninja-build \
    unzip \
    wget \
    git \
    python3 \
    ccache

ENV CCACHE_DIR=/workspace/.ccache

VOLUME /workspace
VOLUME /scripts
WORKDIR /workspace
