#!/usr/bin/zsh

# polybar
echo 'Polybar'
killall polybar
sleep 1
polybar l1 & disown
polybar l2 & disown
polybar r1 & disown

echo 'Latte Dock'
killall latte-dock
latte-dock & disown
