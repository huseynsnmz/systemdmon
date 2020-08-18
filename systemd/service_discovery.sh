#!/usr/bin/env bash

# This script gathers unit files of services for checking of their statuses

SERVICELIST=$(systemctl list-unit-files | grep -E '\.service\s+(generated|enabled)' | awk -F'.service ' '{print $1}')
echo -n '{"data":[';for s in ${SERVICELIST}; do echo -n "{\"{#SERVICE}\": \"$s\"},";done | sed -e 's:\},$:\}:';echo -n ']}'
