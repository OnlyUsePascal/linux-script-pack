# Config
## More disk space
### Cleanup
```bash
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

echo "> clean packages"
yay -Scc

echo "> clean orphan pkgs"
yay -Rns $(yay -Qtdq)
```

### Swap file
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

## Boot 
### Boot missing
1. Chroot from live usb
- install
```bash
yay -S arch-install-scripts
```

- mount os disk
```bash
sudo mount /dev/nvme0n1p6 /mnt
sudo mount /dev/nvme0n1p5 /mnt/efi
```

- chroot
```bash
sudo chroot /mnt

#update
yay -Syu
```

- reinstall kernel
```bash
yay -S kernel-install-for-dracut
reinstall-kernels
#reboot after this
```

- custom bootloader entry menu
```bash
sudo mkdir /mnt/bootWin
sudo mount /dev/nvme0n1p1 /mnt/bootWin
sudo cp -r /mnt/bootWin/EFI/Microsoft /efi/EFI

sudo nano /efi/loader/loader.conf
# add these line 
timeout 5
console-mode keep
```


## Other
### Fn Binding
```bash
#run this at startup
#only work if keyboard is connected
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
```

### Cannot switch screen 
- settings &rarr; window management &rarr; multiscreen behaviour &rarr; turn off `active screen follows mouse`

### open file without printing
```bash
someCommand > /dev/null 2>&1 &
```

### drive not found to boot while installation
- switch drive boot mode to AHCI 

### mixed langugue
- go to file /etc/locale.conf
- set every variable to "en_US.UTF-8"

### remove mic noise
- use EasyEffects


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

