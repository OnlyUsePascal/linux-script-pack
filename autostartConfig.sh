#!/usr/bin/bash

sleep 5

# Fn Binding
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

# Time Sync
# timeRow="`curl -X 'GET' 'https://timeapi.io/api/Time/current/zone?timeZone=Asia/Ho_Chi_Minh' -H 'accept: application/json' | jq .dateTime`"
# timeRow=`echo ${timeRow:1:19} | tr T ' '`
# echo $timeRow
# sudo timedatectl set-time "${timeRow}"

