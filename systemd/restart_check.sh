#!/usr/bin/env bash

# This script checks if the service restarted or not depends on host uptime

SERVICE="$1"
NOW=$(date +%s)

# Don't alert if the server has just been restarted
UPTIME=$(date +%s -d "$(uptime --since)")
if [[ $(( $now - $uptime)) -lt 180 ]]; then
        echo 0
else
        SERVICE_START=$(systemctl show "$SERVICE" --property=ActiveEnterTimestamp | awk -F= '{print $2}')
        SERVICE_START_EPOCH=$(date -d "$SERVICE_START" +%s)

        [[ $(( NOW - SERVICE_START_EPOCH )) -lt 180 ]] && echo 1 || echo 0
fi
