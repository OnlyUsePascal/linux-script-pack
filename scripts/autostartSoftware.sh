#!/usr/bin/bash

sleep 3

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
#     "yakuake"
#     "snixembed --fork"
#     "ibus-daemon -drx"
#     "warp-taskbar"
#     "dropbox"
    "bash /mnt/data/_linux/Script_pack/topBar.sh"
    "bash /mnt/data/_linux/Script_pack/autostartConfig.sh"
    # "bash /mnt/Data/_linux/Script_pack/conky.sh"
    # "picom"
)
startProgs "${progArr[@]}"

