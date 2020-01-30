--      ██╗  ██╗███████╗██╗   ██╗███████╗
--      ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--      █████╔╝ █████╗   ╚████╔╝ ███████╗
--      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--      ██║  ██╗███████╗   ██║   ███████║
--      ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

-- Default Applications
local apps = require("apps");

-- Define mod key
local modkey = "Mod4"
local altkey = "Mod1"

local keys = {}




-- {{{ Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
kbdcfg = {}
kbdcfg.cmd = "setxkbmap"
kbdcfg.font = 'terminus 10'
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
   naughty.notify({title = "Keyboard Layout", text = t[1], timeout = 2})
end

-- Mouse bindings
kbdcfg.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () kbdcfg.switch() end)
))

--}}}



-- ===================================================================
-- Mouse bindings
-- ===================================================================


-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(
    -- left click on desktop to hide notification
    awful.button({}, 1,
        function ()
            naughty.destroy_all_notifications()
        end
    )
)

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)


-- ===================================================================
-- Key bindings
-- ===================================================================


keys.globalkeys = gears.table.join(
    -- =========================================
    -- APPLICATION KEY BINDINGS
    -- =========================================

    -- Spawn terminal
    awful.key({ modkey }, "Return",
        function ()
            awful.spawn(apps.terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    -- launch rofi
    awful.key({ modkey }, "d",
        function()
            awful.spawn(apps.launcher)
        end,
        {description = "application launcher", group = "launcher"}
    ),

    -- =========================================
    -- VOLUME / BRIGHTNESS / SCREENSHOT
    -- =========================================

    -- Brightness
    awful.key({}, 'XF86MonBrightnessUp',
        function()
            awful.spawn('xbacklight -inc 10')
            if toggleBriOSD ~= nil then
                toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                UpdateBriOSD()
            end
        end,
        {description = '+10%', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86MonBrightnessDown',
        function()
            awful.spawn('xbacklight -dec 10')
            if toggleBriOSD ~= nil then
                toggleBriOSD(true)
            end
            if UpdateBrOSD ~= nil then
                UpdateBriOSD()
            end
        end,
        {description = '-10%', group = 'hotkeys'}
    ),

    -- ALSA volume control
    awful.key({}, 'XF86AudioRaiseVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%+')
            if toggleVolOSD ~= nil then
                toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                UpdateVolOSD()
            end
        end,
        {description = 'volume up', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioLowerVolume',
        function()
            awful.spawn('amixer -D pulse sset Master 5%-')
            if toggleVolOSD ~= nil then
                toggleVolOSD(true)
            end
            if UpdateVolOSD ~= nil then
                UpdateVolOSD()
            end
        end,
        {description = 'volume down', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioMute',
        function()
            awful.spawn('amixer -D pulse set Master 1+ toggle')
        end,
        {description = 'toggle mute', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioNext',
        function()
            awful.spawn('mpc next')
        end,
        {description = 'next music', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioPrev',
        function()
            awful.spawn('mpc prev')
        end,
        {description = 'previous music', group = 'hotkeys'}
    ),
    awful.key({}, 'XF86AudioPlay',
        function()
            awful.spawn('mpc toggle')
        end,
        {description = 'play/pause music', group = 'hotkeys'}
    ),

    -- Screenshot on prtscn using scrot
    awful.key({}, "Print",
        function ()
            awful.util.spawn(apps.screenshot, false)
        end
    ),

    -- =========================================
    -- CLIENT MANIPULATION    
    -- =========================================

    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    awful.key({ modkey }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- =========================================
    -- TAG FOCUSING
    -- =========================================

    awful.key({ modkey }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
              
    -- =========================================
    -- SCREEN FOCUSING
    -- =========================================
    
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================

    -- Reload Awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),

    -- Quit Awesome
    awful.key({ modkey }, "Escape",
        function()
            exit_screen_show()
        end,
        {description = "quit awesome", group = "awesome"}
    ),

    awful.key({}, 'XF86PowerOff',
        function()
            exit_screen_show()
        end,
        {description = 'toggle exit screen', group = 'hotkeys'}
    ),

    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key({ modkey, "Shift" }, "minus",
        function ()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({ modkey }, "minus",
        function ()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),

    -- =========================================
    -- CLIENT RESIZING (TODO)
    -- =========================================

    -- =========================================
    -- Language switch
    -- =========================================

    awful.key({ modkey,           }, "space", function () kbdcfg.switch() end,
          {description = "change keyboard layout", group = "awesome"}),
    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================

    -- Number of master clients
    awful.key({ modkey, altkey }, "h",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "l",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Left",
        function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Right",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    
    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key({ modkey }, "Tab",
        function ()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    -- select previous layout
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),
    
    -- =========================================
    -- CLIENT CONTROL
    -- =========================================

    -- restore minimized client
    awful.key({ modkey, "Shift" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    )
)


keys.clientkeys = gears.table.join(
    -- toggle fullscreen
    awful.key({ modkey }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),

    -- close client
    awful.key({ modkey }, "q",
        function (c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),

    -- Minimize
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),

    -- Maximize
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

-- Bind all key numbers to tags
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

-- Set keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
