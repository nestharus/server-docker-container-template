#!/bin/bash

echo "Snapshotting Game State"

if [ ! -d "${SAVE_STATE_MOUNT_POINT}" ]; then
    echo "Unable To Snapshot. No Game State Present"
    exit 0
fi

if [ ! "$(ls -A ${SAVE_STATE_MOUNT_POINT})" ]; then
    echo "Unable To Snapshot. No Game State Present"
    exit 0
fi

timestamp=$(date +%Y%m%d%H%M%S)

# Create the dump directory
mkdir -p "/tmp/game-state"

echo "Snapshotting Game State Profile: ${SAVE_STATE_MOUNT_POINT}"

# Create a tar file from the folder
tar -czf /tmp/game-state/${timestamp}.tar.gz -C "${SAVE_STATE_MOUNT_POINT}" .

# Upload the tar file to the S3 bucket
s3cmd put /tmp/game-state/${timestamp}.tar.gz s3://${S3_BUCKET}/${S3_VOLUME}/${PUBLIC_IP}/

# Remove the tar file
rm /tmp/game-state/${timestamp}.tar.gz

echo "Snapshot Game State Successful"