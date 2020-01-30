local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi


local separator =  wibox.widget
  {
    orientation = 'horizontal',
    forced_height = dpi(16),
    opacity = 0.20,
    widget = wibox.widget.separator
  }

return wibox.widget {
  layout = wibox.layout.align.vertical,
  {
    separator,
    require("widgets.rofi-tag.rofi"),
    layout = wibox.layout.fixed.vertical,

  },

}