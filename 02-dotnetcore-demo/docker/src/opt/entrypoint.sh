#!/usr/bin/env bash

set -eux

echo "[Info] Hello!!"

function configure_logging
{
    NLOG_CONFIG=/demo-app/nlog.config

    if [ ! -f ${NLOG_CONFIG} ]; then
        echo "[Error] Cannot find ${NLOG_CONFIG} file"
        exit 1
    fi

    sed -i "s|variable name=\"logFolder\" value=\".*\"|variable name=\"logFolder\" value=\"${LOG_DIR}\"|g" $NLOG_CONFIG
    echo "[Info] Logging directory configured"
}

if [ ! -z ${LOG_DIR} ]; then
    configure_logging
fi

exec "$@"
