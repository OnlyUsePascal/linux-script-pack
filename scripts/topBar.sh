#!/usr/bin/zsh

# polybar
echo '> Polybar'
killall polybar
sleep 1
param='--quiet'
polybar l1 $param & disown

echo '> Latte Dock'
killall latte-dock
sleep 2
latte-dock & disown
