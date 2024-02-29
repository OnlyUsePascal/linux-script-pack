#!/usr/bin/env bash

scriptName=''
if [[ $1 == "launcher" ]]; then
  scriptName='launcher_t3'
else
  scriptName='powermenu_t4'
fi

# rofi -
if pgrep -x rofi; then
  killall rofi
else
  bash /home/joun/.config/rofi/scripts/${scriptName}
fi