#!/usr/bin/bash

echo "> clean old kernels"
yay autoremove

echo "> clean cache - /var/cache"
sudo rm -r /var/cache/*

echo "> clean cache - ~/.cache"
sudo rm -r ~/.cache/*

echo "> clean journal"
sudo journalctl --vacuum-size=50M

echo "> clean log"
sudo rm -r /var/log/*

echo "> clean orphan pkgs"
yay -Rns $(yay -Qtdq)

# echo "> clean snap"
# set -eu
# snap list --all | awk '/disabled/{print $1, $3}' |
#     while read snapname revision; do
#         snap remove "$snapname" --revision="$revision"
#     done
