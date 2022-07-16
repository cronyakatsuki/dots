local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

theme.wallpaper = "/usr/share/backgrounds/catppuccin-wallpapers/landscapes/shaded_landscape.png"

theme.bg1='#1E1E2E'
theme.bg2='#575268'
theme.bg3='#161320'
theme.fg1='#D9E0EE'
theme.fg2='#C3BAC6'
theme.bl1='#96CDFB'
theme.bl2='#89DCEB'
theme.mg1='#F5C2E7'
theme.mg2='#E8A2AF'
theme.gr1='#ABE9B3'
theme.gr2='#B5E8E0'
theme.red='#F28FAD'
theme.org='#F8BD96'
theme.ylw='#FAE3B0'

theme.font          = "JetBrainsMonoMedium Nerd Font 7"

theme.bg_normal     = theme.bg1
theme.bg_focus      = theme.bl1
theme.bg_urgent     = theme.red
theme.bg_systray    = theme.bg2

theme.fg_normal     = theme.fg1
theme.fg_focus      = theme.fg1
theme.fg_urgent     = theme.fg1
theme.systray_icon_spacing = dpi(6)

theme.useless_gap   = dpi(6)
theme.border_width  = dpi(1.5)
theme.border_normal = theme.bl1
theme.border_focus  = theme.gr1
theme.border_marked = theme.red

theme.taglist_bg_focus    = theme.bg3
theme.taglist_bg_urgent   = theme.bg3
theme.taglist_bg_occupied = theme.bg3
theme.taglist_bg_empty    = theme.bg3
theme.taglist_bg_volatile = theme.bg3
theme.taglist_font        = "IPAGothic 9"

theme.taglist_fg_focus    = theme.bl1
theme.taglist_fg_urgent   = theme.red
theme.taglist_fg_occupied = theme.ylw
theme.taglist_fg_empty    = theme.fg1
theme.taglist_fg_volatile = theme.fg1

theme.tasklist_bg_focus  = theme.bg1
theme.tasklist_bg_urgent = theme.bg1

theme.tasklist_fg_focus  = theme.mg1
theme.tasklist_fg_urgent = theme.red

theme.icon_theme = nil

return theme
