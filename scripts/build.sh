#!/bin/bash

set -o nounset
set -o errexit

WORKSPACE_NAME=kemtls-experiment
WORKSPACE_BASE_DIR=/root/workspaces
WORKSPACE_DIR=${WORKSPACE_BASE_DIR}/${WORKSPACE_NAME}
WORKSPACE_URL="https://git.fslab.de/rgonza2s/zephyr-project.git"

if [ ! -d $WORKSPACE_DIR ]; then
    echo "No '$WORKSPACE_DIR' folder. Initializing workspace from ${WORKSPACE_URL}."
    mkdir -p ${WORKSPACE_DIR}
    cd ${WORKSPACE_DIR}
    west init -m ${WORKSPACE_URL}
    cd
fi

cd $WORKSPACE_DIR
rm -rf build
west update
west build -p auto -b efm32gg_stk3701a modules/crypto/wolfssl/zephyr/samples/wolfssl_tls_sock/
