#!/bin/bash

echo "Initializing Configuration File"

if [ -f "${SETTINGS_FILE}" ]; then
    echo "Configuration File Found"
    echo "Removing Configuration File"
    chmod u+rw "${SETTINGS_FILE}"
    rm ${SETTINGS_FILE}
fi


cat << EOF > "${SETTINGS_FILE}"


EOF

chown steam:steam "${SETTINGS_FILE}"
chmod u-wx "${SETTINGS_FILE}"

echo "Wrote Configuration File"

cat "${SETTINGS_FILE}"