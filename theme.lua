--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗    
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝    
--         ██║   ███████║█████╗  ██╔████╔██║█████╗      
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝      
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗    
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝    

-- ===================================================================
-- Imports
-- ===================================================================


local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


-- Font
theme.font          = "SF Pro Text 9"
theme.title_font    = "SF Pro Display Medium 10"

-- Background
theme.bg_normal     = "#002B36"
theme.bg_dark       = "#000000"
theme.bg_focus      = "#003A40"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#002B60"
theme.bg_systray    = theme.bg_normal

-- Foreground
theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

-- Sizing
theme.corner_radius       = dpi(6)            -- border radius of rounded theme elements
theme.useless_gap         = dpi(7)            -- window gap distance
theme.gap_single_client   = true              -- gaps if only one window is open?

-- Window Borders
theme.border_width          = dpi(0)            -- window border width
theme.border_normal         = theme.bg_normal
theme.border_focus          = "#ff8a65"
theme.border_marked         = theme.fg_urgent

-- Titlebars
theme.titlebar_font = theme.title_font
theme.titlebar_bg = theme.bg_normal
theme.titlebar_bg_focus = theme.titlebar_bg -- make titlebars not change color when focused

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = '#ffffff1A'
theme.taglist_bg_urgent = '#E91E6399'
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Notifications
theme.notification_max_width = dpi(500)
theme.notification_margin = dpi(5)
theme.notification_padding = dpi(8)

-- Menu
theme.menu_font = theme.font
theme.menu_submenu = '' -- ➤


-- ===================================================================
-- Icons
-- ===================================================================


-- You can use your own layout icons like this:
theme.layout_tile = "~/.config/awesome/icons/layouts/view-quilt.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/view-float.png"
theme.layout_max = "~/.config/awesome/icons/layouts/arrow-expand-all.png"
theme.layout_fairv = "~/.config/awesome/icons/layouts/fairvw.png"
theme.layout_fairh = "~/.config/awesome/icons/layouts/fairhw.png"

--theme.icon_theme = "McMojave-circle-blue-dark"

-- return theme
return theme
