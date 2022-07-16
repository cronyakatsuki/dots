#!/bin/sh

mode=$(system76-power graphics)
nv_screen="eDP-1-0"
screen="eDP"

if [ "$mode" = "nvidia" ]; then
    xrandr --output $nv_screen --set TearFree on
    xrandr --output $nv_screen --set "PRIME Synchronization" 1
elif [ "$mode" = "integrated" ]; then
    xrandr --output $screen --set TearFree on
elif [ "$mode" = "hybrid" ]; then
    xrandr --output $screen --set TearFree on
fi
