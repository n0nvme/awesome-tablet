local awful = require("awful")



mykeyboardlayout = awful.widget.keyboardlayout()
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.font = 'Material Design Icons Desktop 10'
kbdcfg.layout = { { "us", "", "🇺🇸" }, { "ru", "", "🇷🇺" } }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.widget = wibox.widget.textbox()
kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][3] .. " ")
kbdcfg.widget.font = 'terminus 25'
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = kbdcfg.layout[kbdcfg.current]
   kbdcfg.widget:set_text( " " .. t[3] .. " ")
   os.execute( kbdcfg.cmd .. " " .. t[1] .. " " .. t[2] )
end
