#!/bin/sh

killall dunst
killall /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
killall sxhkd
killall polybar
killall picom
rm /tmp/bspwm-startup.lock
bspc quit
