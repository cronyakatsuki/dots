# Default libraries importing
import subprocess
import os

# Basic qtile imports
from libqtile import hook, qtile
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad
from libqtile.lazy import lazy

# Layouts importing
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.layout.xmonad import MonadTall
from libqtile.layout.stack import Stack

# My customs importing
from colors import catppuccino as colors
from bar import screens, widget_defaults
from keybindings import terminal, mod, keys

groups = [
    Group("1", label="一", matches=[
        Match(wm_class="Brave-browser")],  layout='stack'),

    Group("2", label="二", layout='monadtall'),

    Group("3", label="三", layout='columns'),

    Group("4", label="四", matches=[
        Match(wm_class="discord"), Match(wm_class="Ferdium")], layout='stack'),

    Group("5", label="五", matches=[
        Match(wm_class="Spotify")], layout='stack'),

    Group("6", label="六", matches=[
        Match(wm_class="Steam"), Match(wm_class="Lutris"), Match(wm_class="heroic"),
        Match(wm_class="itch")], layout='floating'),

    Group("7", label="七", layout='monadtall'),

    Group("8", label="八", layout='monadtall'),

    Group("9", label="九", matches=[
        Match(wm_class="Microsoft Teams - Preview")], layout='stack')]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)
                ),
            # mod1 + control + letter of group = switch to & move focused window to group
            Key(
                [mod, "control"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
        ]
    )

dropdown_theme = {'width': 0.7,
                  'height': 0.8,
                  'x': 0.15,
                  'y': 0.1,
                  'opacity': 1
                  }

groups.append(ScratchPad('scratchpad', [
    DropDown('term', f'{terminal}', **dropdown_theme),
    DropDown('lf', f'{terminal} -e lf', **dropdown_theme),
    DropDown('passwdman', 'bitwarden-desktop', **dropdown_theme),
]))

keys.extend([
    Key(["control"], "1", lazy.group['scratchpad'].dropdown_toggle('term')),
    Key(["control"], "2", lazy.group['scratchpad'].dropdown_toggle('lf')),
    Key(["control"], "3", lazy.group['scratchpad'].dropdown_toggle('passwdman')),
])

layout_theme = {"border_width": 1,
                "margin": 10,
                "border_focus": colors['bl1'],
                "border_normal": colors['bg1']
                }

layouts = [
    Columns(
        **layout_theme,
        border_normal_stack=colors['bg2'],
        border_focus_stack=colors['bl1'],
        insert_position=1,
    ),
    MonadTall(
        **layout_theme,
        ratio=0.54,
        single_border_width=0
    ),
    Stack(
        **layout_theme,
        num_stacks=1,
    ),
    Floating(
        border_width=1,
        margin=10,
        border_focus=colors['bl1'],
        border_normal=colors['bg1'],
    ),
]

floating_layout = Floating(
    border_width=1,
    margin=10,
    border_focus=colors['bl1'],
    border_normal=colors['bg1'],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="lxappearance"),  # Gtk theme setter
        Match(wm_class="ProtonUp-Qt"),  # Proton/wine manager
    ],
)

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "focus"
reconfigure_screens = True
auto_minimize = False
wmname = "LG3D"



# autostartup once
@hook.subscribe.startup_once
def startup_once():
    home = os.path.expanduser('~/Bin/qtile/startup_once')
    subprocess.Popen([home])



# autostart on every reload of the config
@hook.subscribe.startup
def startup():
    home = os.path.expanduser('~/Bin/qtile/startup')
    subprocess.call([home])
