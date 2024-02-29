#!/usr/bin/bash

str=$(warp-cli status)
sub="Connected"

if [[ "${str}" == *"${sub}"* ]]; then
    echo "Connected, now disconnect"
    warp-cli disconnect
else
    echo "Not connected, now connect"
    warp-cli connect
fi

# echo "${str}"
