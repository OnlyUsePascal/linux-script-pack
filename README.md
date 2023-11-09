# Tips & Tricks
## Swap file
```bash
# Init
sudo fallocate -l 5G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# make swap permanent
sudo nano /etc/fstab
# add this line to bottom of the file
/swapfile swap swap defaults 0 0
```

## Wifi 
```bash
sudo systemctl disable --now iwd
sudo systemctl enable wpa_supplicant
sudo systemctl restart NetworkManager
sudo systemctl enable NetworkManager
```

## Mount disk 
### Find disk 
```bash
$ sudo fdisk -l
[sudo] password for joun: 
#...
Device             Start        End   Sectors   Size Type
/dev/nvme0n1p1      2048     206847    204800   100M EFI System
/dev/nvme0n1p2    206848     239615     32768    16M Microsoft reserved
/dev/nvme0n1p3    239616  209955548 209715933   100G Microsoft basic data
/dev/nvme0n1p4 209956864  841854975 631898112 301.3G Microsoft basic data
/dev/nvme0n1p5 841854976  842924031   1069056   522M Windows recovery environment
/dev/nvme0n1p6 842924032  843972607   1048576   512M EFI System
/dev/nvme0n1p7 843972608 1000215182 156242575  74.5G Linux filesystem
```

### Mount
```bash
sudo mkdir /mnt/Data
sudo mount /dev/nvme0n1p4 /mnt/Data

# make mount permanent
sudo nano /etc/fstab
# add this line to bottom 
/dev/nvme0n1p4 /mnt/Data ntfs defaults 0 0
```

## Bluetooth
```bash
yay -S bluez
yay -S bluez-utils
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service
```

## Bash
### open file without printing
```bash
someCommand > /dev/null 2>&1 &
```

# Troubleshoot
## System
### Boot missing
Chroot from live usb

install
```bash
yay -S arch-install-scripts
```

mount os disk
```bash
sudo mount /dev/nvme0n1p6 /mnt
sudo mount /dev/nvme0n1p5 /mnt/efi
```

chroot
```bash
sudo arch-chroot /mnt
```

Update
```bash
yay -Syu
```
reinstall kernel
```bash
yay -S kernel-install-for-dracut
reinstall-kernels
#reboot after this
```

custom bootloader entry menu
```bash
sudo mkdir /mnt/bootWin
sudo mount /dev/nvme0n1p1 /mnt/bootWin
sudo cp -r /mnt/bootWin/EFI/Microsoft /efi/EFI

sudo nano /efi/loader/loader.conf
# add these line 
timeout 5
console-mode keep
```

### Cannot switch screen 
settings &rarr; window management &rarr; window behavior &rarr; multiscreen behaviour (only show when u connect with another screen) &rarr; turn off `active screen follows mouse` + turn on `separate screen focus`

### drive not found to boot while installation
switch drive boot mode to AHCI 

## Input
### Fn Binding
```bash
#run this at startup
#only work if keyboard is connected
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

## mixed langugue
go to file /etc/locale.conf

set every variable to `en_US.UTF-8`


## Audio
### remove mic noise
use EasyEffects

### micro auto adjust 
Go to `chrome://flags`

disable a flag: `Allow WebRTC to adjust the input volume.`

# Software
## Priority
```bash
yay -Syu
nvidia-inst
```

## Unikey
```bash
# install ibus bamboo
yay -S ibus-bamboo

# start
ibus-daemon -drx
```

## Mongo
```bash
#install
yay -S mongodb-bin

#config
#create folder for config
mkdir mongo
mkdir mongo/database
touch mongo/config.conf
touch mongo/log.log
```

`config.conf`
```bash
# Where and how to store data.
storage:
  dbPath: /mongo/database/
#  engine:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /mongo/log.log

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:
```

Run
```bash
#run server
sudo mongod --config /mongo/config.conf

#run shell
mongosh
``` 

## warp vpn
```bash
#install 
yay -S cloudflare-warp-bin

#config
#enable service
sudo systemctl start warp-svc.service
sudo systemctl enable warp-svc.service

#make use
warp-cli register
warp-cli connect / disconnect / status
```
warp connection status
```
warp-taskbar
```

## Chromium
### Scaling window
```bash
chromium --force-device-scale-factor=1.2 %U
```


# Some automation script
## Autostart
```bash
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
```

## Config
```bash
#!/usr/bin/bash

sleep 5

# Fn Binding
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode

# Time Sync
timeRow="`curl -X 'GET' 'https://timeapi.io/api/Time/current/zone?timeZone=Asia/Ho_Chi_Minh' -H 'accept: application/json' | jq .dateTime`"
timeRow=`echo ${timeRow:1:19} | tr T ' '`
echo $timeRow
sudo timedatectl set-time "${timeRow}"
```

## Cleanup
```bash
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

# echo "> clean snap"
# set -eu
# snap list --all | awk '/disabled/{print $1, $3}' |
#     while read snapname revision; do
#         snap remove "$snapname" --revision="$revision"
#     done

```

## Open programs faster

`bashrc`
```bash
...
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"
alias 'gadd'="git add"
alias "op"="bash '/mnt/Data/_linux/Script_pack/openProgram.sh'"
alias 'gpush'='git push'
alias 'gcom'='git commit -m'
alias 'glog'='git log --oneline'
alias 'gpull'='git pull'
alias 'py'='python'
alias 'vim'='nvim'
alias 'gr'='gradle'

```

Combined with this script
```bash
echo "Opening: $1"
command="send nudes"
chrome_scale="--force-device-scale-factor=0.9"
browser="google-chrome-stable"

case $1 in
# system
    "sdown")
        shutdown -h now
        exit
        ;;
    "rboot")
        reboot
        exit
        ;;
    "sleep")
        systemctl suspend
        exit
        ;;
    "aConf")
        sudo /mnt/Data/_linux/Script_pack/autostartConfig.sh
        exit
        ;;
    "clean")
        /mnt/Data/_linux/Script_pack/sysClean.sh
        exit
        ;;
    "vpn")
        str=$(warp-cli status)
        sub="Connected"

        if [[ "${str}" == *"${sub}"* ]]; then
            echo "Connected, now disconnect"
            command="warp-cli disconnect"
        else
            echo "Not connected, now connect"
            command="warp-cli connect"
        fi
        ;;

# Chrome base
	"calen")
        command="$browser $chrome_scale --new-window https://calendar.google.com/"
        ;;
    "chr")
        command="$browser $chrome_scale"
        ;;
    "trelo")
        command="$browser $chrome_scale --new-window https://trello.com/"
        ;;
    "note")
        command="$browser $chrome_scale --new-window https://www.notion.so/"
        ;;
    "team")
        command="$browser $chrome_scale --new-window https://teams.microsoft.com/"
        ;;
    "dis")
        command="$browser $chrome_scale --new-window https://www.discord.com/login"
        ;;

# code
    "idea")
        command="/mnt/Data/_linux/Programs/idea-IC-231.9161.38/bin/idea.sh"
        ;;
    "code")
        command="code"
        ;;
    "mongo")
        sudo mongod --config /mnt/Data/_linux/Programs/mongodb/mongodb.conf
        exit
        ;;
    "maria")
        sudo systemctl start mariadb.service
        exit
        ;;
    "dbeav")
        command="dbeaver"
        ;;

# editor
    "menu")
        code /mnt/Data/_linux/Script_pack/openProgram.sh
        exit
        ;;
    "vim")
        command="gtk-launch nvim"
        ;;
    "bashrc")
        sudo nano ~/.bashrc
        exit
        ;;
    "todo")
        code /home/joun/Desktop/todo.txt
        exit
        ;;

# other 
    "xdm")
        command="xdman"
        ;;

    *)
        echo "Invalid Input?"
        exit
        ;;


esac

$command > /dev/null 2>&1 &

```
