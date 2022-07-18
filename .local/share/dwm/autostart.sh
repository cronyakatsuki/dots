#!/bin/sh

[ -f "/tmp/dwm.lock" ] && exit

acpi-listener & disown acpi-listener
dwmblocks & disown dwmblocks

transmission-daemon & disown transmission-daemon
clipmenud & disown clipmenud
lxsession & disown lxsession

picom --experimental-backends --animations --animation-for-open-window zoom & disown picom


dunst & disown dunst
mpd
mpDris2 & disown mpDris2
mpd-discord-rpc & disown mpd-discord-rpc

touch /tmp/dwm.lock

sleep 5
discord --start-minimized & disown discord
