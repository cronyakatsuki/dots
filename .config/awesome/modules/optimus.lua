local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local awful = require("awful")
local dpi = xresources.apply_dpi
beautiful.init("/home/crony/.config/awesome/theme.lua")

-- Create the text widget
local text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local widget = wibox.widget.background()
widget:set_widget(wibox.container.background(wibox.container.margin(text, dpi(4), dpi(4)), beautiful.mg1))

widget:set_fg(beautiful.bg1)

awful.spawn.easy_async("sb-optimus", function (stdout)
    text:set_text(stdout)
end)

collectgarbage()

return widget
