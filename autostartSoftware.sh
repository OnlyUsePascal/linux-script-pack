#!/usr/bin/bash

sleep 5

#yakuake
# programs
function startProgs() {
    arr=("$@")
    for value in "${arr[@]}"
    do
        $value > /dev/null 2>&1 &
    done
}

# phase 2
progArr=(
    "yakuake"
    "ibus-daemon -drx"
    "warp-taskbar"
)
startProgs "${progArr[@]}"

