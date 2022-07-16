#!/bin/sh

mode=$(envycontrol -q | awk '{ print $5 }')
nv_screen="eDP-1-0"
screen="eDP"

[ "$(echo $XDG_SESSION_TYPE)" != "x11" ] || exit

if [ "$mode" = "nvidia" ]; then
    # xrandr --output $nv_screen --set TearFree on
    xrandr --output $nv_screen --set "PRIME Synchronization" 1
elif [ "$mode" = "integrated" ]; then
    xrandr --output $screen --set TearFree on
elif [ "$mode" = "hybrid" ]; then
    xrandr --output $screen --set TearFree on
fi

