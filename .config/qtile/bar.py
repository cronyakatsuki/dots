from libqtile.config import Screen
from libqtile.bar import Bar

from libqtile import widget
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.groupbox import GroupBox
from libqtile.widget.currentlayout import CurrentLayout
from libqtile.widget.window_count import WindowCount
from libqtile.widget.windowname import WindowName
from libqtile.widget.cpu import CPU
from libqtile.widget.memory import Memory
from libqtile.widget.wlan import Wlan
from libqtile.widget.battery import Battery
from libqtile.widget.clock import Clock
from libqtile.widget.systray import Systray
from libqtile.widget.spacer import Spacer
from libqtile.widget.df import DF
from libqtile.widget.net import Net

from colors import catppuccino as colors
from unicodes import lower_left_triangle
from widgets.commandtextbox import CommandTextBox

from os.path import expanduser

widget_defaults = dict(
    font="JetBrainsMonoMedium Nerd Font",
    fontsize=13,
    padding=4,
    background=colors['bg1'],
    foreground=colors['fg1'],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=Bar(
            [
                GroupBox(
                    font="IPAGothic",
                    borderwidth=0,
                    active=colors['yl'],
                    inactive=colors['fg1'],
                    disable_drag=True,
                    block_highlight_text_color=colors['bl1'],
                    highlight_color=colors['bg1'],
                    highlight_method="line",
                    use_mouse_wheel=False,
                    padding=8
                ),
                CurrentLayout(
                    foreground=colors['bl1'],
                    padding=0,
                ),
                Spacer(
                    length=5
                ),
                WindowCount(
                    show_zero=True,
                    foreground=colors['yl'],
                    padding=0,
                ),
                lower_left_triangle(colors['bg1'], colors['bg3']),
                WindowName(
                    background=colors['bg3'],
                    foreground=colors['mg2'],
                ),
                lower_left_triangle(colors['bg3'], colors['bg1']),
                Spacer(
                    length=10
                ),
                CommandTextBox(
                    command=['sb-optimus'],
                    foreground=colors['mg1'],
                    padding=0
                ),
                Spacer(
                    length=4
                ),
                CPU(
                    format=' {load_percent}%',
                    update_interval=10,
                    background=colors['bg1'],
                    foreground=colors['mg2'],
                ),
                widget.ThermalSensor(
                    tag_sensor="Tctl",
                    fmt=" {}",
                    update_interval=10,
                    foreground=colors['rd'],
                    background=colors['bg1'],
                    threshold=65
                ),
                Memory(
                    fmt=" {}",
                    measure_mem="G",
                    format='{MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}',
                    update_interval=10,
                    foreground=colors['or'],
                    background=colors['bg1']
                ),
                DF(
                    partition='/',
                    format=' {uf}{m}/{s}{m}',
                    visible_on_warn=False,
                    update=43200,
                    foreground=colors['yl'],
                    background=colors['bg1'],
                    padding=0,
                ),
                DF(
                    partition='/home/',
                    format='|{uf}{m}/{s}{m}',
                    visible_on_warn=False,
                    update=43200,
                    foreground=colors['yl'],
                    background=colors['bg1'],
                    padding=0,
                ),
                Wlan(
                    interface="wlp4s0",
                    format='直 {percent:2.0%}',
                    disconnected_message='睊',
                    update_interval=10,
                    foreground=colors['gr1'],
                    background=colors['bg1']
                ),
                Net(
                    prefix='M',
                    format='{up} ↕ {down}',
                    foreground=colors['gr2'],
                    background=colors['bg1'],
                ),
                Battery(
                    show_short_text=False,
                    format='{char}{percent:2.0%}',
                    full_char=' ',
                    charge_char=' ',
                    discharge_char=' ',
                    update_interval=10,
                    foreground=colors['bl1'],
                    background=colors['bg1']
                ),
                Spacer(
                    background=colors['bg1'],
                    length=4
                ),
                Clock(
                    format=" %d.%m %H:%M",
                    update_interval=10,
                    foreground=colors['bl2'],
                    background=colors['bg1'],
                    padding=0
                ),
                lower_left_triangle(colors['bg1'], colors['bg2']),
                Systray(
                    background=colors['bg2'],
                    padding=4
                ),
                Spacer(
                    background=colors['bg2'],
                    length=4
                ),
            ],
            24,
        ),
        wallpaper=expanduser(
            "/usr/share/backgrounds/catppuccin-wallpapers/misc/doggocat.png"),
        wallpaper_mode='fill'
    ),
]
