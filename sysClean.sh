#!/usr/bin/bash

echo "> clean old kernels"
yay autoremove

echo "> clean cache - /var/cache"
sudo du -sh /var/cache
sudo rm -r /var/cache/*

echo "> clean cache - ~/.cache"
sudo du -sh ~/.cache
sudo rm -r ~/.cache/*

echo "> clean log"
sudo du -sh /var/log
sudo rm -r /var/log/*

echo "> clean journal"
sudo journalctl --disk-usage
sudo journalctl --vacuum-size=50M

echo "> clean orphan pkgs"
yay -Rns $(yay -Qtdq)

echo '> clean coredumb - adb'
sudo rm /var/lib/systemd/coredump/core.adb*

echo '> clean google cache'
killall chromium
rm -r /home/joun/.config/chromium/Profile\ 2/Service\ Worker/CacheStorage/*

# echo '> clean gradle cache'
# rm -r /home/joun/.gradle/caches/*




# echo "> clean snap"
# set -eu
# snap list --all | awk '/disabled/{print $1, $3}' |
#     while read snapname revision; do
#         snap remove "$snapname" --revision="$revision"
#     done
