#!/usr/bin/bash

sleep 5

# config
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
