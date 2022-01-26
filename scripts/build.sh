#!/bin/bash

set -o nounset
set -o errexit

WORKSPACE_NAME=testkem
WORKSPACE_DIR=/root/workspaces/${WORKSPACE_NAME}

if [ ! -d $WORKSPACE_DIR ]; then
    echo "No '$WORKSPACE_DIR' folder."
    exit 1
fi

cd $WORKSPACE_DIR
rm -rf build
west update
west build -p auto -b efm32gg_stk3701a modules/crypto/wolfssl/zephyr/samples/wolfssl_tls_sock/
