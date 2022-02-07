#!/bin/bash

set -o nounset
set -o errexit

WORKSPACE_NAME=kemtls-experiment
WORKSPACE_BASE_DIR=/root/workspaces
WORKSPACE_DIR=${WORKSPACE_BASE_DIR}/${WORKSPACE_NAME}
WORKSPACE_URL="https://git.fslab.de/rgonza2s/zephyr-project.git"
BUILD_DIR=${WORKSPACE_DIR}/build

if [ ! -d $WORKSPACE_DIR ]; then
    echo "No '$WORKSPACE_DIR' folder. Initializing workspace from ${WORKSPACE_URL}."
    mkdir -p ${WORKSPACE_DIR}
    cd ${WORKSPACE_DIR}
    west init -m ${WORKSPACE_URL}
    west update
    cd
fi

if [ $# -gt 0 ]; then
    if [ "$1" == "--rebuild" ]; then
        cd ${WORKSPACE_DIR}
        if [ -d ${BUILD_DIR} ]; then
            echo "Erasing build dir"
            rm -rf $BUILD_DIR
        fi
        echo "Updating dependencies"
        west update
        cd
    else
        echo "[$0] Unknown command line option: $1"
    fi
fi


cd $WORKSPACE_DIR
west build -p auto -b efm32gg_stk3701a modules/crypto/wolfssl/zephyr/samples/wolfssl_tls_sock/
