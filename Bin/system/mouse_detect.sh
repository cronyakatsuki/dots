#!/bin/sh

_x11() {
    if xinput list | grep -i 'mouse' | grep -i 'MOSART' >> /dev/null; then
        exec `xinput disable ELAN0515:01\ 04F3:3142\ Touchpad`
    else
        exec `xinput enable ELAN0515:01\ 04F3:3142\ Touchpad`
    fi
    exit 0
}

_wayland () {
    if riverctl list-inputs | grep -i 'mouse' | grep -i 'MOSART' >> /dev/null ; then
        riverctl input pointer-1267-12610-ELAN0515:01_04F3:3142_Touchpad events disabled
    else
        riverctl input pointer-1267-12610-ELAN0515:01_04F3:3142_Touchpad events enabled
    fi
    exit 0
}

[ "$1" == "x11" ] && _x11
[ "$1" == "wayland" ] && _wayland
