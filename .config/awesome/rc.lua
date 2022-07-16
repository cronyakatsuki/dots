pcall(require, "luarocks.loader")

--> Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
--> Widget and layout library
local wibox = require("wibox")
--> Theme handling library
local beautiful = require("beautiful")
--> Notification library
local _dbus = dbus
dbus = nil
local naughty = require("naughty")
dbus = _dbus
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.hotkeys_popup.keys")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

awful.spawn.with_shell("~/Bin/qtile/startup")

--> icon size
awesome.set_preferred_icon_size(20)

--> Fix window snapping
awful.mouse.snap.edge_enabled = false

-->Error handling<--

--> Check if awesome encountered an error during startup and fell back to
--> another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

--> Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end

-->Variable definitions<--

--> Themes define colours, icons, font and wallpapers.
beautiful.init("/home/crony/.config/awesome/theme.lua")

--> This is used later as the default terminal and editor to run.
local terminal = os.getenv("TERMINAL")
local browser = os.getenv("BROWSER")

-->modkey
local modkey = "Mod4"

-->layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

-->bar setup<--
--> Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

--> wallpapaper setting
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-->tag names and layouts
local names = { "一", "二", "三", "四", "五", "六", "七", "八", "九" }
local l = awful.layout.suit
local layouts = { l.max, l.tile, l.tile, l.max, l.max, l.floating, l.tile, l.tile, l.tile }

--> Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

--> separators
local separators = require("lain").util.separators

local datetime = require("modules.timedate")

local battery = require("modules.battery")

local net = require("modules.network")

local wifi = require("modules.wifi")

local disk_space = require("modules.disk-space")

local ram = require("modules.ram")

local cpu_temp = require("modules.cpu-temp")

local cpu = require("modules.cpu")

local optimus = require("modules.optimus")

--> set screens
awful.screen.connect_for_each_screen(function(s)
    --> set wallpaper
    set_wallpaper(s)

    --> set tags
    awful.tag(names, s, layouts)

    --> taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })

    --> tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.focused,
    })

    --> bar
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 23 })

    --> bar widgets
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        { --> Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
            separators.arrow_left(beautiful.bg3, beautiful.bg1),
        },
        s.mytasklist, --> Middle widget
        { --> Right widgets
            layout = wibox.layout.fixed.horizontal,
            separators.arrow_left(beautiful.bg1, beautiful.mg1),
            optimus,
            separators.arrow_left(beautiful.mg1, beautiful.mg2),
            cpu,
            separators.arrow_left(beautiful.mg2, beautiful.red),
            cpu_temp,
            separators.arrow_left(beautiful.red, beautiful.org),
            ram,
            separators.arrow_left(beautiful.org, beautiful.ylw),
            disk_space,
            separators.arrow_left(beautiful.ylw, beautiful.gr1),
            wifi,
            separators.arrow_left(beautiful.gr1, beautiful.gr2),
            net,
            separators.arrow_left(beautiful.gr2, beautiful.bl1),
            battery,
            separators.arrow_left(beautiful.bl1, beautiful.bl2),
            datetime,
            separators.arrow_left(beautiful.bl2, beautiful.bg2),
            wibox.widget.systray(),
        },
    })
end)

-->Key bindings<--
local globalkeys = gears.table.join(
    awful.key({ modkey }, "h", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Tab", awful.tag.history.restore, { description = "go back", group = "tag" }),

    awful.key({ modkey }, "Down", function()
        awful.client.focus.byidx(1)
    end, { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "Up", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),

    --> Layout manipulation
    awful.key({ modkey, "Shift" }, "Down", function()
        awful.client.swap.byidx(1)
    end, { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "Up", function()
        awful.client.swap.byidx(-1)
    end, { description = "swap with previous client by index", group = "client" }),

    --> awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Control" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),

    --> Standard program
    awful.key({ modkey }, "Return", function()
        awful.spawn(terminal)
    end, { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, "l", function()
        awful.spawn("locker")
    end, { description = "lock screen", group = "launcher" }),
    awful.key({ modkey }, "b", function()
        awful.spawn(browser)
    end, { description = "open a browser", group = "launcher" }),
    awful.key({ modkey, "Shift" }, "b", function()
        awful.spawn.with_shell("firefox -P Unsecure")
    end, { description = "open a browser", group = "launcher" }),
    awful.key({ modkey }, "n", function()
        awful.spawn.with_shell("$TERMINAL -e newsboat")
    end, { description = "open a rss reader", group = "launcher" }),
    awful.key({ modkey }, "f", function()
        awful.spawn.with_shell("$TERMINAL -e lf-run")
    end, { description = "open a file manager", group = "launcher" }),
    awful.key({ modkey }, "m", function()
        awful.spawn.with_shell("$TERMINAL -e neomutt")
    end, { description = "open a mail client", group = "launcher" }),
    awful.key({ modkey }, "d", function()
        awful.spawn.with_shell("dmenu_run -p 'Run:'")
    end, { description = "run prompt", group = "launcher" }),
    awful.key({ modkey, "Shift" }, "F12", function()
        awful.spawn.with_shell("toggle-program picom --experimental-backends --animations --animation-for-open-window zoom &")
    end, { description = "run prompt", group = "launcher" }),

    --> dmenu
    awful.key({ modkey, "Shift" }, "d", function()
        awful.spawn("dmenu-runner")
    end, { description = "dmenu scripts run prompt", group = "dmenu" }),
    awful.key({ modkey, "Shift" }, "e", function()
        awful.spawn("dmenu-power-menu")
    end, { description = "poweroff/reboot menu", group = "dmenu" }),
    awful.key({ modkey }, "e", function()
        awful.spawn("dmenu-configs")
    end, { description = "quick configs edit", group = "dmenu" }),
    awful.key({ modkey }, "g", function()
        awful.spawn("dmenu-games")
    end, { description = "games run prompt", group = "dmenu" }),
    awful.key({ modkey }, "k", function()
        awful.spawn("dmenu-kill")
    end, { description = "list programs to kill", group = "dmenu" }),
    awful.key({ modkey }, "s", function()
        awful.spawn("dmenu-pulse-port-man")
    end, { description = "change beetwen headphones and speakers", group = "dmenu" }),
    awful.key({ modkey }, "F12", function()
        awful.spawn("dmenu-ryzenadj")
    end, { description = "ryzenadj power change on fly", group = "dmenu" }),
    awful.key({}, "Print", function()
        awful.spawn("dmenu-screenshot")
    end, { description = "ryzenadj power change on fly", group = "dmenu" }),
    awful.key({ modkey }, "u", function()
        awful.spawn("dmenu-usb-man")
    end, { description = "dmenu usb manager", group = "dmenu" }),
    awful.key({ modkey }, "w", function()
        awful.spawn("dmenu-wifi")
    end, { description = "dmenu wifi manager", group = "dmenu" }),
    awful.key({ modkey }, "c", function()
        awful.spawn("clipmenu")
    end, { description = "dmenu wifi manager", group = "dmenu" }),
    awful.key({ modkey }, "r", function()
        awful.spawn.with_shell("dmenu-ryzenadj-prof-manager ~/Documents/ryzenadj-profiles/")
    end, { description = "dmenu wifi manager", group = "dmenu" }),

    -->Script runner
    awful.key({ modkey }, "F1", function()
        awful.spawn("get-wm_class")
    end, { description = "get wm class", group = "script" }),
    awful.key({ modkey }, "F2", function()
        awful.spawn("get-color")
    end, { description = "get color", group = "script" }),

    -->volume managment
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.with_shell("sb-volume-update up")
    end, { description = "raise volume", group = "volume" }),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.with_shell("sb-volume-update down")
    end, { description = "lower volume", group = "volume" }),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn.with_shell("sb-volume-update mute")
    end, { description = "toggle volume", group = "volume" }),

    -->backlight
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn.with_shell("sb-backlight-update up")
    end, { description = "backlight raise", group = "backlight" }),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn.with_shell("sb-backlight-update down")
    end, { description = "backlight lower", group = "backlight" }),

    -->mpris playback support
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn.with_shell("dmenu-playerctl play-pause")
    end, { description = "toggle playback", group = "playback" }),
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn.with_shell("dmenu-playerctl previous")
    end, { description = "play previous", group = "playback" }),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn.with_shell("dmenu-playerctl next")
    end, { description = "backlight lower", group = "playback" }),

    -->layout manipulation
    awful.key({ modkey }, "Right", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "Left", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "Right", function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "Left", function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "Right", function()
        awful.tag.incncol(1, nil, true)
    end, { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "Left", function()
        awful.tag.incncol(-1, nil, true)
    end, { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" })
)

local clientkeys = gears.table.join(
    awful.key({ modkey }, "F11", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, "Shift" }, "q", function(c)
        c:kill()
    end, { description = "close", group = "client" }),
    awful.key(
        { modkey, "Shift" },
        "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, "Control" }, "Return", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" })
)

--> Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = "view tag #" .. i, group = "tag" }),
        -- Move client to tag and view it.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, { description = "toggle tag #" .. i, group = "tag" }),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" })
    )
end

local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-->KEYS<--
root.keys(globalkeys)

-->Rules<--
awful.rules.rules = {
    --> rules for all clients
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_offscreen + awful.placement.centered,
            size_hints_honor = false,
            -- set_slave=true,
        },
    },

    --> Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",
                "copyq",
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",
                "Sxiv",
                "Tor Browser",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },
            name = {
                "Event Tester",
            },
            role = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up",
            },
        },
        properties = { floating = true },
    },

    --> disable titlebars
    { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

    --> tag 1 stuff
    {
        rule_any = {
            class = {
                "firefox",
            },
        },
        properties = {
            tag = names[1],
            focus = true,
        },
    },

    --> tag 4 stuff
    {
        rule_any = {
            class = {
                "mpv",
            },
        },
        properties = {
            tag = names[4],
            focus = true,
        },
    },

    --> tag 5 stuff
    {
        rule_any = {
            class = {
                "discord",
                "Ferdium",
            },
        },
        properties = {
            tag = names[5],
            focus = true,
        },
    },

    --> tag 6 stuff
    {
        rule_any = {
            class = {
                "heroic",
                "Lutris",
                "Steam",
            },
        },
        properties = {
            tag = names[6],
            focus = true,
        },
    },
}

-->Signals<--

--> Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

--> Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

--> disable window maximization
client.connect_signal("property::maximized", function(c)
    c.maximized = false
end)
client.connect_signal("property::maximized_horizontal", function(c)
    c.maximized_horizontal = false
end)
client.connect_signal("property::maximized_vertical", function(c)
    c.maximized_vertical = false
end)

--> disable window minimization
client.connect_signal("property::minimized", function(c)
    c.minimized = false
end)

--> Focus urgent clients automatically
client.connect_signal("property::urgent", function(c)
    c:jump_to()
end)

--> fullscreen with some specific windows
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c.fullscreen = true
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)
