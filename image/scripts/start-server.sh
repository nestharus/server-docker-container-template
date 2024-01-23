#!/bin/bash

echo "Starting Server"

COMMAND_ARGS=""

###############################################
#
# Required Parameters
#
#COMMAND_ARGS="${COMMAND_ARGS} -flag ${FLAG}"
###############################################
#
# Optional Toggles
#
#if [ "${FLAG}" = "true" ]; then
#    COMMAND_ARGS="${COMMAND_ARGS} Thing=Thing"
#
#    echo "FLAG enabled"
#fi
###############################################
#
# Optional Parameters
#
#if [ -n "${PARAMETER}" ]; then
#    COMMAND_ARGS="${COMMAND_ARGS} -PARAMETER ${PARAMETER}"
#
#    echo "Server Parameter"
#fi
###############################################
#
# Run Server
echo "Processed Arguments"
echo "${COMMAND_ARGS}"

su steam -c "${SERVER_RUN_LOCATION} ${COMMAND_ARGS}"