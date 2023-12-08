# Making life easier
## Swap 
### Pure swap
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

### Zram
- [Article here](https://wiki.archlinux.org/title/Zram)

- Somehow i got builtin setup, so how to change the zram capacity

Checking info - usally format name of `/dev/zram`
```shell
$ lsblk

NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
...
zram0        254:0    0     4G  0 disk [SWAP]
```

Change size / compress algo 
```shell
swapoff /dev/zram0

zramctl /dev/zram0 --algorithm zstd --size 32G

mkswap -U clear /dev/zram0

swapon --priority 100 /dev/zram0
```

## Cleanup 
Refers to the [cleanup script](./sysClean.sh)

## Autostart
Making program running as a service
Create a new file as `/etc/systemd/system/_myscript_.service` and add the following contents:
```shell
[Unit]
Description=My script
 
[Service]
ExecStart=/usr/bin/my-script
 
[Install]
WantedBy=multi-user.target
```

# Configuration

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
### Reinstall Nvidia
Fucking nvidia

Source
- https://wiki.archlinux.org/title/NVIDIA
- https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
- https://computingforgeeks.com/install-nvidia-3d-graphics-driver-on-arch-linux/

Install driver 
```
$ yay -S nvidia-lts nvidia-utils lib32-nvidia-utils
$ yay -S nvidia-settings
```

AND FULL UPDATE (no need to upgrade packages from `aur/`) AND REBOOT
```
$ yay -Syu
```

Append `splash nvidia-drm.modeset=1`  to `options` line
```
$ sudo nano /boot/loader/entries
```

Use module: change the file `/etc/mkinitcpio.conf` like this
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

Then remake linux image
```bash
$ sudo mkinitcpio -P
```

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

Main step
- Create boot option
```shell
bootctl install
```

- Or just reinstall kernel 
```
yay -S linux-lts linux-lts-headers
```

#### custom bootloader entry menu
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

### cannot preview font
Maybe u are using Plasma, switch to Xorg

## Input
### Fn Binding
```bash
#run this at startup
#only work if keyboard is connected
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

### mixed langugue
go to file /etc/locale.conf
set every variable to `en_US.UTF-8`

## Audio
### remove mic noise
use EasyEffects

### micro auto adjust 
Go to `chrome://flags`
disable a flag: `Allow WebRTC to adjust the input volume.`

### Microphone for bluetooth


# Software

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

## Android
### Adb server
install `android-udev` and `android`

### Env var
Create symlinks from these folders to elsewhere to avoid filling up ur main disk 
- `/home/joun/.gradle/caches/`
- `/home/joun/.android/avd/`
