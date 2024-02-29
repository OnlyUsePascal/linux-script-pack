#!/bin/sh

#
# User Configuration
#
show_controls=yes
icon_color=f5e0dc
play_icon=""
pause_icon=""
player_icon=""

# Get song title
title=$(playerctl metadata | grep -Po '(?<=title               )([^\n]*)')

# Get song artist
artist=$(playerctl metadata | grep -Po '(?<=:artist              )[^,]*')

# Get play/paused status
status=$(playerctl status)

# Set play_pause_icon to $play_icon or $pause_icon depending on player status
if [ $status == "Paused" ]; then
    play_pause_icon=$play_icon
else
    play_pause_icon=$pause_icon
fi

# If title and artist are null, print an empty string so polybar hides the module
if [ -z $title ] && [ -z $artist ]; then
    echo "%{F#$icon_color}$player_icon%{F-} %{T7}(－ω－)%{T-}"
else
    # Print polybar widget string
    if [ $show_controls == "yes" ]; then
        echo "%{F#$icon_color}$player_icon%{F-} $(echo $title | sed 's/\(.\{25\}\).*/\1.../') %{F#$icon_color}%{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}$play_pause_icon%{A} %{A1:playerctl next:}%{A}%{F-}"
    else
        echo "%{F#$icon_color}$player_icon%{F-} $(head -c 30 <<< $title)%{F-}"
    fi
fi
