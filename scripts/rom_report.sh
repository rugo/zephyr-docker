#!/bin/bash

set -o nounset
set -o errexit

WORKSPACE_NAME=kemtls-experiment
WORKSPACE_BASE_DIR=/root/workspaces
WORKSPACE_DIR=${WORKSPACE_BASE_DIR}/${WORKSPACE_NAME}


cd $WORKSPACE_DIR
west build -t rom_report
