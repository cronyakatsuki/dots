#!/bin/sh

[ -f "/tmp/dwm.lock" ] && exit

dwmblocks & disown dwmblocks

transmission-daemon & disown transmission-daemon
clipmenud & disown clipmenud
lxsession & disown lxsession

picom --experimental-backends --animations --animation-for-open-window zoom & disown picom

# pywal-discord

discord --start-minimized & disown discord

dunst & disown dunst
mpd
mpDris2 & disown mpDris2
mpd-discord-rpc & disown mpd-discord-rpc

touch /tmp/dwm.lock
