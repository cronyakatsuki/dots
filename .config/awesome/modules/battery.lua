local wibox = require("wibox")
local watch = require("awful.widget.watch")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
beautiful.init("/home/crony/.config/awesome/theme.lua")

-- Create the text widget
local text = wibox.widget{
    widget = wibox.widget.textbox,
}

-- Create the background widget
local widget = wibox.widget.background()
widget:set_widget(wibox.container.background(wibox.container.margin(text, dpi(4), dpi(4)), beautiful.bl1))

widget:set_fg(beautiful.bg1)

watch(
  "sb-battery", 15,
  function(_, stdout)
    text:set_text(stdout)

    collectgarbage()
  end,
  widget
)

text:set_text(" ??? ")

return widget
