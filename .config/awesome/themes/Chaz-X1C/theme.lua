--[[
    Chaz-X1C Awesome WM theme
    Created by Chaz Davis
--]]

local themes_path = require("gears.filesystem").get_themes_dir("/home/chazdii/.config/awesome/themes")
local theme.dir = themes_path .. "/Chaz-X1C"


-- Main
local theme = {}
theme.wallpaper = theme.dir .. "/wall.png"

-- Styles
theme.font              = "Source Code Pro for Powerline Semibold 10"
theme.notification_font = "Source Code Pro Regular 12"

-- Colors
theme.bg_normal   = "#2d2b55"
theme.bg_focus    = "#2d2b55"
theme.bg_urgent   = "#e1efff"
theme.bg_minimize = "#1e1e3f"
theme.bg_systray  = theme.bg_normal

theme.fg_normal   = "#e1efff"
theme.fg_focus    = "#e1efff"
theme.fg_urgent   = "#2d2b55"
theme.fg_minimize = "#a599e9"

-- Borders
theme.border_width  = 1
theme.border_normal = "#8000ff"
theme.border_focus  = "#00ff00"
theme.border_marked = "#00ff00"

theme.hotkeys_modifiers_fg = "#00ff00"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.dir .. "/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "/Chaz-X1C/icons/submenu.png"
theme.menu_height = 25
theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = theme.dir .. "/titlebar/close_normal_arc.png"
theme.titlebar_close_button_focus               = theme.dir .. "/titlebar/close_focus_arc.png"

theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh      = theme.dir .. "/layouts/fairh.png"
theme.layout_fairv      = theme.dir .. "/layouts/fairv.png"
theme.layout_floating   = theme.dir .. "/layouts/floating.png"
theme.layout_magnifier  = theme.dir .. "/layouts/magnifier.png"
theme.layout_max        = theme.dir .. "/layouts/max.png"
theme.layout_fullscreen = theme.dir .. "/layouts/fullscreen.png"
theme.layout_tilebottom = theme.dir .. "/layouts/tilebottom.png"
theme.layout_tileleft   = theme.dir .. "/layouts/tileleft.png"
theme.layout_tile       = theme.dir .. "/layouts/tile.png"
theme.layout_tiletop    = theme.dir .. "/layouts/tiletop.png"
theme.layout_spiral     = theme.dir .. "/layouts/dwindle.png"
theme.layout_cornernw   = theme.dir .. "/layouts/cornernw.png"
theme.layout_cornerne   = theme.dir .. "/layouts/cornerne.png"
theme.layout_cornersw   = theme.dir .. "/layouts/cornersw.png"
theme.layout_cornerse   = theme.dir .. "/layouts/cornerse.png"
theme.layout_centerwork = theme.dir .. "/layouts/centerworkw.png"

theme.awesome_icon = theme.dir .. "/icons/manjaro64.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Papirus-Dark-Maia"

return theme
