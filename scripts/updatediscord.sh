#!/bin/bash

# version=$(ls ~/.config/discord | sed -n "s/^.*\([0-9]\+.[0-9]\+.[0-9]\+\).*$/\1/p")
#
# echo "Current version: $version"
# new_version=$(echo $version | awk -F. '{$NF = $NF + 1; print $0}' OFS=.)
echo "Downloading..."
wget --content-disposition "https://discord.com/api/download?platform=linux"
sudo apt-get install ./discord-*.deb
rm ./discord-*.deb
