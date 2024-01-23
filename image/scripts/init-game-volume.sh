#!/bin/bash

echo "Initializing Game State"

chown -R steam:steam "${SAVE_STATE_MOUNT_POINT}"
ls -laR "${SAVE_STATE_MOUNT_POINT}"