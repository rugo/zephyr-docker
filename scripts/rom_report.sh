#!/bin/bash

set -o nounset
set -o errexit

if [ $# -lt 1 ] ; then
    echo "Zephyr workspace name not set. Call: $0 workspace_name"
    echo "Example: $0 kemtls-experiment"
    exit 1
fi

WORKSPACE_NAME=$1
WORKSPACE_BASE_DIR=/root/workspaces
WORKSPACE_DIR=${WORKSPACE_BASE_DIR}/${WORKSPACE_NAME}


cd $WORKSPACE_DIR
west build -t rom_report
