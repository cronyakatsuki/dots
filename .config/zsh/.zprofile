# Config by
  # ____                            _    _         _             _    _
 # / ___|_ __ ___  _ __  _   _     / \  | | ____ _| |_ ___ _   _| | _(_)
# | |   | '__/ _ \| '_ \| | | |   / _ \ | |/ / _` | __/ __| | | | |/ / |
# | |___| | | (_) | | | | |_| |  / ___ \|   < (_| | |_\__ \ |_| |   <| |
 # \____|_|  \___/|_| |_|\__, | /_/   \_\_|\_\__,_|\__|___/\__,_|_|\_\_|
                       # |___/

export QT_QPA_PLATFORMTHEME=qt5ct

# clipmenu
export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=0
export CM_MAX_CLIPS=2
export CM_HISTLENGTH=5

# run wm
[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -c $HOME/.config/X11/xinitrc -- vt1 &> /dev/null
# [[ $(fgconsole 2>/dev/null) == 1 ]] && exec start-wayland -- vt1 &> /dev/null

eval "$(ssh-agent -s)" &> /dev/null
