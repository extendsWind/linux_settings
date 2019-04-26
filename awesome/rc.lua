-- Depandency
--  icon in Arc-Maia (optional, used for exit menu)
--  xtrlock for screen lock (optional, for lock the screen)
--  j4-dmenu for quick application search (important for start x-application)
--  and blow software

--(important for running terminal)
terminal = os.getenv("TERMINAL") or "xfce4-terminal" 
editor = os.getenv("EDITOR") or "nvim"
file_manager = "nemo"


editor_cmd = terminal .. " -e " .. editor

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


-- my notification settings
naughty.config.defaults.timeout = 10

-- Freedesktop menu
-- removed for needing additional library and seldom use
--local freedesktop = require("freedesktop")



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

---------------------------------------
-- my theme settings 
beautiful.bg_normal = "#000000"  -- #00000000 透明
beautiful.bg_systray = "#000000"

-- beautiful.taglist_font = "Noto Sans 8"


beautiful.border_width = 0
beautiful.systray_icon_spacing = 2
beautiful.tasklist_disable_task_name = true
beautiful.tasklist_align = "center"
beautiful.wibar_height = 18
beautiful.wallpaper = awful.util.get_configuration_dir() .. "wallpaper1.jpg"
beautiful.newAwesomeIcon = awful.util.get_configuration_dir() .. "awesome-icon.png"
--beautiful.tasklist_plain_task_name = true
--
--


---------------------------------------


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
--   { "manual", terminal .. " -e man awesome" }, 
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

-- my power menu
  
myexitmenu= {
    { "log out", function() awesome.quit() end, "/usr/share/icons/Arc-Maia/actions/24@2x/system-log-out.png" },
    { "suspend", "systemctl suspend", "/usr/share/icons/Arc-Maia/actions/24@2x/gnome-session-suspend.png" },
    { "hibernate", "systemctl hibernate", "/usr/share/icons/Arc-Maia/actions/24@2x/gnome-session-hibernate.png" },
    { "reboot", "systemctl reboot", "/usr/share/icons/Arc-Maia/actions/24@2x/view-refresh.png" },
    { "shutdown", "poweroff", "/usr/share/icons/Arc-Maia/actions/24@2x/system-shutdown.png" }
}

-- -- not use for depending on the library "freedesktop"
--mymainmenu = freedesktop.menu.build({
--    before = {
--        { "Terminal", terminal, "/usr/share/icons/Adwaita/32x32/apps/utilities-terminal.png" },
--        { "Browser", browser, "/usr/share/icons/hicolor/24x24/apps/chromium.png" },
--        { "Files", filemanager, "/usr/share/icons/Adwaita/32x32/apps/system-file-manager.png" },
--        -- other triads can be put here
--    },
--    after = {
--        { "Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome16.png" },
--        { "Exit", myexitmenu, "/usr/share/icons/Arc-Maia/actions/24@2x/system-restart.png" },
--        -- other triads can be put here
--    }
--})

mymainmenu = awful.menu({ items = {
    { "awesome", myawesomemenu, beautiful.newAwesomeIcon},
    { "lock", "xtrlock"},
    { "open terminal", terminal },
    { "Exit", myexitmenu, "/usr/share/icons/Arc-Maia/actions/24@2x/system-restart.png" },
}})

mylauncher = awful.widget.launcher({ image = beautiful.newAwesomeIcon, menu = mymainmenu})


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%b-%d %H:%M")


-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    -- Each screen has its own tag table.
    local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    local l = awful.layout.suit  -- Just to save some typing: use an alias.
    local layouts = { l.tile, l.floating, l.tile, l.float, l.tile,
    l.tile, l.tile.left, l.tile, l.tile}
    awful.tag(names, s, layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))


    -- 左下角的窗口tag
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- 每个应用的任务栏
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox 底部状态栏
    s.mywibox = awful.wibar({ position = "bottom", screen = s })


    -- system tray 右下角图标
    s.mySystray = wibox.widget.systray()
    -- s.mySystray:set_base_size(10)
    

    blue        = "#9EBABA"
    seperator = wibox.widget.textbox(' <span color="' .. blue .. '">  | </span>')

    -- Add widgets to the wibox
    s.mywibox:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox -- 命令行盒子 ctrl+p
    },
    s.mytasklist, -- Middle widget  任务栏中窗口的图标和名称
    { -- Right widgets
    layout = wibox.layout.fixed.horizontal,
    wibox.widget.systray(),
    seperator,
    --mykeyboardlayout,
    mytextclock,
    s.mylayoutbox,
    },
  }
end
)


-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--    awful.button({ }, 2, function (c) c:kill() end),
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
--              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),


    -- screen
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end, {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end, {description = "focus the previous screen", group = "screen"}),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "p",     function () awful.screen.focused().mypromptbox:run() end,
             {description = "run prompt", group = "launcher"}),


    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    --awful.key({ modkey }, "r", function() menubar.show() end, {description = "show the menubar", group = "launcher"}),




    -- my key settings
    --
    --
    awful.key({"Mod1"}, "F1", function() awful.spawn("xfce4-terminal --drop-down") end, {description = "terminal drop down", group = "MySettings"}), 
    awful.key({"Control", "Mod1"}, "z", function() awful.spawn("/opt/deepinwine/tools/sendkeys.sh z") end, {description = "TIM/QQ toggle", group = "MySettings"}),
    awful.key({"Control", "Mod1"}, "w", function() awful.spawn("/opt/deepinwine/tools/sendkeys.sh WeChat w 4") end, {description = "WeChat toggle", group = "MySettings"}),
    awful.key({"Control", "Mod1"}, "a", function() awful.spawn("/opt/deepinwine/tools/sendkeys.sh a") end, {description = "TIM/QQ screenshot", group = "MySettings"}),
    awful.key({ modkey }, "e", function() awful.spawn.with_shell(file_manager .. " /home/fly/public_download")
	     end, {description = "open file manager", group = "MySettings"}),
    awful.key({ modkey }, "r", function() awful.spawn.with_shell ("j4-dmenu-desktop") end, {description = "j4-dmenu-desktop", group = "MySettings"}),
    awful.key({modkey}, "F12", function() awful.spawn.with_shell ("xtrlock") end, {description = "j4-dmenu-desktop", group = "MySettings"}),

--    awful.key({ modkey}, "[", function() awful.spawn.with_shell("xdotool getactivewindow key --window %1 Down") end, {description = "move down", group = "MySettings"}),
--    awful.key({ modkey}, "]", function() awful.spawn("python /home/fly/.config/awesome/keydown.py ") end, {description = "move up", group = "MySettings"}),
--    awful.key({ modkey}, "]", function() awful.spawn("xdotool click 5") end, {description = "move down", group = "MySettings"}),
    awful.key({ modkey}, "Insert", function() awful.spawn.with_shell("xprop > ~/aa.txt") end, {description = "xprop(get window class) to ~/aa.txt", group = "MySettings"}),
    awful.key({ modkey}, "Up", function() awful.spawn.with_shell("pulseaudio-ctl up") end, {description = "audio volume up", group = "MySettings"}),
    awful.key({ modkey}, "Down", function() awful.spawn.with_shell("pulseaudio-ctl down") end, {description = "audio volume down", group = "MySettings"}),

    -- tag control
    awful.key({ modkey, "Mod1"}, "j",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Mod1"}, "k",  awful.tag.viewnext,
              {description = "view next", group = "tag"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    awful.key({ modkey, "Shift" }, "o",      function (c) c:move_to_screen()    awful.screen.focus_relative(-1) end ,
              {description = "move to other screen without move focus", group = "MySettings-Screen"}),
    awful.key({ "Mod1" }, "Escape", function () awful.screen.focus_relative(-1) end, {description = "focus the previous screen", group = "MySettings-Screen"}),

    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

        -- MySettings-client
    awful.key({ "Mod1"}, "F4", function (c) c:kill() end, {description = "close", group = "MySettings-client"}),
    awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "window go back", group = "MySettings-client"}),


    
    awful.key({ modkey , "Mod1" }, "h", 
    function (c) 
      local sw = c.screen.geometry.width
      if c.x ~= 0 then 
        if c.x-30 > 0 then c:relative_move(-30,0,30,0) end
      else 
        if c.width-30 > 0 then c:relative_move(0,0,-30, 0) end
      end
    end, 
    {description = "left move window", group = "MySettings-client"}),


    awful.key({ modkey , "Mod1" }, "l", 
    function (c) 
      local sw = c.screen.geometry.width
      if c.x ~= 0 then 
        if c.x+30 < sw then c:relative_move(30,0,-30,0) end
      else 
        if c.width+30 < sw then c:relative_move(0,0,30, 0) end
      end
    end, 
    {description = "right move window", group = "MySettings-client"})


 
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
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
                  {description = "move focused client to tag #"..i, group = "tag"}),
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
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
--

---- for wine TIM and QQ
local old_filter = awful.client.focus.filter
function myfocus_filter(c)
  if old_filter(c) then
    -- TM.exe completion pop-up windows
    if (c.instance == 'tm.exe' or c.instance == 'TIM.exe')
        and c.above and c.skip_taskbar
        and (c.type == 'normal' or c.type == 'dialog') -- dialog type is for tooltip windows
        and (c.class == 'qq.exe' or c.class == 'QQ.exe' or c.class == 'TIM.exe') then
        return nil
    -- This works with tooltips and some popup-menus
    elseif c.class == 'Wine' and c.above == true then
      return nil
    elseif (c.class == 'Wine' or c.class == 'QQ.exe' or c.class == 'qq.exe')
      and c.type == 'dialog'
      and c.skip_taskbar == true
      and c.size_hints.max_width and c.size_hints.max_width < 160
      then
      -- for popup item menus of Photoshop CS5
      return nil
    -- popups for Settings page in Firefox
    elseif c.skip_taskbar and c.instance == 'Popup' and c.class == 'Firefox' then
      return nil
    elseif c.class == 'Key-mon' then
      return nil
    else
      return c
    end
  end
end
awful.client.focus.filter = myfocus_filter


-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false -- for terminal not full maximize
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
	  "inkscape"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    -- 每个应用窗口上方的
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false}
      --}, properties = { titlebars_enabled = true }
    },

    
    -- my rules
    --
    
 { rule = {class = "Wine"}, 
   except = {name = "CAJViewer 7.2"},
   properties = {floating = true; sticky = true} },

--    {
--      rule = {class = "Wine"},
--      except = {name = "?*"},
--      properties = {focusable = false, floating = true, sticky = true},
--     -- callback = function (c)
--    --naughty.notify({ preset = naughty.config.presets.critical,
--     --                title = c.name.."--"..c.class.."--"..c.type,
--      --               text = awesome.startup_errors })
--      --             end
--      -- 解决qq选表情的闪退问题
--    },
--    {--wine
--     rule = {class = "Wine", name="?*"}, properties = {focusable = true, floating = true, sticky = true}
--    },
--    {-- 快捷键输入表情
--      rule = {class= "Wine", name="FaceSelector"}, properties = {focusable = false, floating = true, sticky = true}
--    },
    {-- Golden Dict
      rule_any = {
        class = {
        "GoldenDict" }
      }, 
      properties = {floating = true, sticky = true},
      callback = function (c)
        local swidth = c.screen.geometry.width
        local sheight = c.screen.geometry.height
        local xRatio = 0.3
        c:geometry({x = 0, y=sheight*0.5-c.screen.mywibox.heigh, width = swidth, height = sheight*0.5})
      end
    }, 
   {-- netease cloud music
      rule_any = {
        class = {"netease-cloud-music"
        }
      }, 
      properties = {floating = true, sticky = true}
    }, 
  
    {-- for floating application
      rule_any = {
        class = {
        "Zotero"}
      }, 
      properties = {floating = true,
      callback = function (c)
        local swidth = c.screen.geometry.width
        local sheight = c.screen.geometry.height
        local xRatio = 0.3
        c:geometry({x = 0, y=sheight*0.5-c.screen.mywibox.height, width = swidth, height = sheight*0.5})
      end
    }}, 
    {--pomodoro_tk
      rule = {class = "Tk"}, properties = {floating = true, sticky = true, skip_taskbar=true, focusable=false -- super+j/k will not get the focus
    }
    },
    {--pomodoro_tk
    rule = {class = "Thunar"},  
    callback = function(c)
        c.maximized = false
    end
},
    {--browser
      rule_any = {class = {"Vivaldi", "Firefox", "Chrome", "Browser360-beta"}}, properties = {tag = "2"}
    },
    {--Master PDF Editor
      rule = {class = "Master PDF Editor"},
      callback = function (c)
          local swidth = c.screen.geometry.width
          local xRatio = 0.3
          c:geometry({x = swidth*xRatio, y=0, width = swidth*(1-xRatio)})
      end
    },
    {--xfce4-terminal-drop-down
    rule = {role = "xfce4-terminal-dropdown"},properties = {floating = true, sticky = true}

  }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
    -- if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        -- and awful.client.focus.filter(c) then
        -- client.focus = c
    -- end
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--



-- autostart when log in
--
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

--os.execute("fcitx -r")
--os.execute("compton -b")

--os.execute("pomodoro")
--os.execute("emacs &")



--Name	Description
--Mod4	Also called Super, Windows and Command ⌘
--Mod1	Usually called Alt on PCs and Option on Macs
--Shift	Both left and right shift keys
--Control	Also called CTRL on some keyboards

-- 窗口上方的有个titlebar，设置为true时会显示。
-- 有窗口名称和system tray的是wibar，中间显示各个窗口的是tasklist
--
-- awful.key 设置各种快捷键
-- rules 设置各个窗口的出现规则
--
-- focus follows mouse.搜索这一段能够处理是否焦点跟随鼠标
--

-- lua  .和:    x:bar(3,4)should be the same as x.bar(x,3,4).
-- 


--awful.ewmh.add_activate_filter(function(c, source)
--  if ( source=="autofocus.check_focus" or source =="client.focus.bydirection"
--    ) and  c.class == "Wine" then
--    return false
--  end
--end) 

-- Active window information:
-- Title: 'b'FaceSelector''
-- Class: 'tim.exe.Wine'
