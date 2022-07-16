#!/usr/bin/sh

killall picom
killall polybar
killall sxhkd
killall dunst
killall floating.sh
killall acpi-listener

# status bar
polybar top -r &
disown $@
# keybindings daemon
sxhkd &
disown $@
# compositor
picom --experimental-backends &
disown $@
# notification daemon
dunst &
disown $@

floating.sh &
disown $@

acpi-listener &
disown $@
