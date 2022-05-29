#!/bin/bash

set -o nounset
set -o errexit

WORKSPACE_BASE_DIR=/root/workspaces

if [[ "$@" =~ "--pqtls" ]]; then
    WORKSPACE_URL="https://git.fslab.de/rgonza2s/zephyr-project-pqtls.git"
    WORKSPACE_NAME=pqtls-experiment
else
    WORKSPACE_URL="https://git.fslab.de/rgonza2s/zephyr-project.git"
    WORKSPACE_NAME=kemtls-experiment
fi

WORKSPACE_DIR=${WORKSPACE_BASE_DIR}/${WORKSPACE_NAME}
BUILD_DIR=${WORKSPACE_DIR}/build

if [ ! -d $WORKSPACE_DIR ]; then
    echo "No '$WORKSPACE_DIR' folder. Initializing workspace from ${WORKSPACE_URL}."
    mkdir -p ${WORKSPACE_DIR}
    cd ${WORKSPACE_DIR}
    west init -m ${WORKSPACE_URL}
    west update
    cd
fi

if [[ "$@" =~ "--init" ]]; then
    echo "Done with initialization"
    exit 0
fi

if [ $# -gt 0 ]; then
    if [[ "$@" =~ "--rebuild" ]]; then
        cd ${WORKSPACE_DIR}
        if [ -d ${BUILD_DIR} ]; then
            echo "Erasing build dir"
            rm -rf $BUILD_DIR
        fi
        cd
    fi
    if [[ "$@" =~ "--update" ]]; then
        cd ${WORKSPACE_DIR}
        echo "Updating dependencies"
        west update
        cd
    fi
fi


cd $WORKSPACE_DIR
west build -p auto -b efm32gg_stk3701a modules/crypto/wolfssl/zephyr/samples/wolfssl_tls_sock/
