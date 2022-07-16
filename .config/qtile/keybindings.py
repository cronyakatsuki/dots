from os import environ
from os.path import expanduser

from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy


mod = "mod4"
terminal = environ["TERMINAL"]
browser = environ["BROWSER"]

keys = [
    # qtile general
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "e", lazy.shutdown(), desc="Shutdown Qtile"),

    # Focus
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Left", lazy.layout.left(), desc="Move focus left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus right"),

    # Moving windows
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(),
        desc="Move window right"),

    # Growing the windows
    Key([mod, "control"], "Left",  lazy.layout.grow_left(),
        lazy.layout.shrink_main(), desc="Grow window left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(),
        lazy.layout.grow_main(), desc="Grow window right"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),

    # Swapping columns
    Key([mod, "shift", "control"], "Left",
        lazy.layout.swap_column_left(), desc="Swap column left"),
    Key([mod, "shift", "control"], "Right",
        lazy.layout.swap_column_right(), desc="Swap column right"),

    # normalizing
    Key([mod, "shift"], "n", lazy.layout.normalize(),
        desc="Normalize all size changes"),

    # Specific for layout
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle beetwen split and unsplit"),

    # Layout's playground
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod,  "shift"], "space", lazy.window.toggle_floating(),
        desc="Toggle floating mode"),
    Key([mod], "F11", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "Tab", lazy.screen.toggle_group(),
        desc="Move to the last visited group"),

    # Terminal and terminal programs
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "f", lazy.spawn(
        f"{terminal} -e lf"), desc="Run lf file manager"),
    Key([mod], "n", lazy.spawn(
        f"{terminal} -e newsboat"), desc="Run newsboat rss reader"),

    # Graphical programs
    Key([mod], "b", lazy.spawn(browser), desc="Run a browser"),
    KeyChord([mod], "g", [
        Key([], "f", lazy.spawn("pcmanfm"), desc="Run a gui file manager"),
        Key([], "l", lazy.spawn("slock"), desc="Run a lockscreen"),
        Key([], "p", lazy.spawn("gparted"), desc="Run gparted"),
    ]),

    # Dmenu scripts
    Key([mod, "shift"], "e", lazy.spawn(
        "dmenu-power-menu"), desc="System powermenu"),
    Key([], "Print", lazy.spawn("dmenu-screenshot"),
        desc="Dmenu script for screenshoting"),
    Key([mod], "F12", lazy.spawn("dmenu-ryzenadj"),
        desc="Dmenu ryzenadj profile runner"),
    Key([mod], "c", lazy.spawn("clipmenu -l 10"),
        desc="Dmenu clipboard manager"),
    Key([mod], "d", lazy.spawn("dmenu_run -p 'Run:'"), desc="Program launcher"),
    KeyChord([mod], "p", [
        Key([], "l", lazy.spawn(
            f"dmenu-file-handler {expanduser('~/Lightnovels')}"), desc="Run dmenu script for listing my Lightnovels"),
        Key([], "g", lazy.spawn("dmenu-games"), desc="Dmenu games runner"),
        Key([], "e", lazy.spawn("dmenu-configs"),
            desc="Dmenu quick config edit"),
        Key([], "k", lazy.spawn("dmenu-kill"),
            desc="Dmenu script for killing programs"),
        Key([], "u", lazy.spawn("dmenu-usb-man"),
            desc="Dmenu script for managing usb's"),
        Key([], "w", lazy.spawn("dmenu-wifi"),
            desc="Dmenu script for managing usb's"),
        Key([], "p", lazy.spawn(
            f"dmenu-ryzenadj-prof-manager {expanduser('~/Documents/ryzenadj-profiles/')}"), desc="Dmenu script for managing usb's"),
        Key([], "s", lazy.spawn(
                "dmenu-pulse-port-man"), desc="Dmenu script for port changing"),
        Key([], "d", lazy.spawn(
                "dmenu-dict"), desc="Dmenu script for spelling"),
        Key([], "a", lazy.spawn(
                "dmenu-wiki"), desc="Dmenu script for searching arch wiki"),
    ]),

    # Volume managment
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "sb-volume-update up"), desc="Raise volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "sb-volume-update down"), desc="Lower volume"),
    Key([], "XF86AudioMute", lazy.spawn(
        "sb-volume-update mute"), desc="Mute volume"),

    # Brightness managment
    Key([], "XF86MonBrightnessUp", lazy.spawn(
        "sb-backlight-update up"), desc="Raise brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(
        "sb-backlight-update down"), desc="Lower brightness"),

    # Mpris support playback managment
    Key([], "XF86AudioPlay", lazy.spawn(
        "playerctl play-pause"), desc="Toggle playback"),
    Key([], "XF86AudioPrev", lazy.spawn(
        "playerctl previous"), desc="Play previous"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Play next"),

    # Scripts runners
    Key([mod, "shift"], "F12", lazy.spawn("toggle-program picom --experimental-backends"),
        desc="Script to toggle my compositor"),
    Key([mod], "F1", lazy.spawn("get-wm_class"),
        desc="Script to get wm_class name into the clipboard"),
    Key([mod], "F2", lazy.spawn("get-color"),
        desc="Script to choose a color and save it to clipboard")
]
