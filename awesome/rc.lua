-- Include awesome libraries, with lots of useful function!
require("awful")
require("beautiful")
require('naughty')

--naughty.config.timeout          = 5
--naughty.config.screen           = 1
--naughty.config.position         = "top_right"
--naughty.config.margin           = 4
--naughty.config.height           = 16
--naughty.config.width            = 300
--naughty.config.gap              = 1
--naughty.config.ontop            = true
--naughty.config.font             = beautiful.font or "Verdana 8"
--naughty.config.icon             = nil
--naughty.config.icon_size        = 16
naughty.config.fg               = beautiful.fg_focus or '#ffffff'
naughty.config.bg               = beautiful.bg_focus or '#535d6c'
naughty.config.border_color     = beautiful.border_focus or '#535d6c'
naughty.config.border_width     = 1
--naughty.config.hover_timeout    = nil

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
-- theme_path = "/usr/local/share/awesome/themes/default/theme"
-- Uncommment this for a lighter theme
theme_path = "/usr/local/share/awesome/themes/gigamos/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    "tile",
--    "tileleft",
    "tilebottom",
--    "tiletop",
--    "fairh",
--    "fairv",
    "magnifier",
    "max",
    "fullscreen",
--    "spiral",
--    "dwindle",
    "floating"
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    ["Pidgin"] = { screen = 1, tag = 8 },
    ["Skype.real"] = { screen = 1, tag = 9 },
    ["xine"] = { screen = 1, tag = 5 },
    ["rhythmbox"] = { screen = 1, tag = 6 },
    ["banshee-1"] = { screen = 1, tag = 6 },
    ["com.sun.javaws.Main"] = { screen = 1, tag = 4 },
}

-- Applications to be added to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
appaddtags =
{
    ["XTerm"] = { screen = 1, tag = 2 },
    ["URxvt"] = { screen = 1, tag = 2 },
    ["Firefox"] = { screen = 1, tag = 3 },
    ["browser"] = { screen = 1, tag = 3 },
    ["conversation"] = { screen = 1, tag = 7 },
    ["Chats"] = { screen = 1, tag = 7 },
}

tagdeffunctions = {
  [2] = terminal,
  [3] = "firefox",
  [4] = "batclient",
  [5] = "xine",
  [6] = "banshee-1",
  [8] = "pidgin",
  [9] = "skype"
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
tags[1] = {}
tags[1][1] = tag({ name = "work", layout = "magnifier" })
tags[1][1].mwfact = 0.8
tags[1][1].screen = 1

tags[1][2] = tag({ name = "terminal", layout = "tilebottom" })
tags[1][2].mwfact = 0.5
tags[1][2].screen = 1

tags[1][3] = tag({ name = "www", layout = "tile" })
tags[1][3].mwfact = 0.8
tags[1][3].screen = 1

tags[1][4] = tag({ name = "batmud", layout = "max" })
tags[1][4].mwfact = 0.9
tags[1][4].screen = 1

tags[1][5] = tag({ name = "video", layout = "fullscreen" })
tags[1][5].screen = 1

tags[1][6] = tag({ name = "music", layout = "max" })
tags[1][6].screen = 1

tags[1][7] = tag({ name = "conversation", layout = "tile" })
tags[1][7].mwfact = 0.5
tags[1][7].screen = 1

tags[1][8] = tag({ name = "pidgin", layout = "tile" })
tags[1][8].mwfact = 0.3
tags[1][8].screen = 1

tags[1][9] = tag({ name = "skype", layout = "tile" })
tags[1][9].mwfact = 0.3
tags[1][9].screen = 1

tags[1][1].selected = true

for s = 2, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for tagnumber = 1, 9 do
        tags[s][tagnumber] = tag({ name = tagnumber, layout = layouts[1] })
        -- Add tags to screen one by one
        tags[s][tagnumber].screen = s
    end
    -- I'm sure you want to see at least one tag.
end

-- }}}

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

-- Create a textbox widget for the Battery Status
mybatterybox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mybatterybox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c) client.focus = c; c:raise() end),
                       button({ }, 3, function () awful.menu.clients({ width=250 }) end),
                       button({ }, 4, function () awful.client.focus.byidx(1) end),
                       button({ }, 5, function () awful.client.focus.byidx(-1) end) }

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mybatterybox,
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }
    mywibox[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
awesome.buttons({
    button({ }, 3, function () mymainmenu:toggle() end),
    button({ }, 4, awful.tag.viewnext),
    button({ }, 5, awful.tag.viewprev)
})
-- }}}

-- {{{ Key bindings

-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    keybinding({ modkey }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                          awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding({ modkey, "Control" }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding({ modkey, "Shift" }, i,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.movetotag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
    keybinding({ modkey, "Control", "Shift" }, i,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.toggletag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
end

keybinding({ modkey }, "Left", awful.tag.viewprev):add()
keybinding({ modkey }, "Right", awful.tag.viewnext):add()
keybinding({ modkey }, "Escape", awful.tag.history.restore):add()

-- Standard program
keybinding({ modkey }, "Return", function () awful.util.spawn(terminal) end):add()

keybinding({ modkey, "Control" }, "r", function ()
                                           mypromptbox[mouse.screen].text =
                                               awful.util.escape(awful.util.restart())
                                        end):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()

keybinding({ modkey }, "r", function ()
        awful.prompt.run({ prompt = "ssh to: " },
        mypromptbox[mouse.screen],
        function(h)
                awful.util.spawn(terminal .. " -e ssh " .. h)
        end,
        function(cmd, cur_pos, ncomp)
                -- get the hosts
                local hosts = {}
                for host in io.open(os.getenv("HOME") .. "/.ssh/config"):read("*all"):gmatch("Host (%w+)") do
                        table.insert(hosts, host)
                end
                -- abort completion under certain circumstances
                if #cmd == 0 or (cur_pos ~= #cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " ") then
                        return cmd, cur_pos
                end
                -- match
                local matches = {}
                table.foreach(hosts, function(x)
                        if hosts[x]:find("^" .. cmd:sub(1,cur_pos)) then
                                table.insert(matches, hosts[x])
                        end
                end)
                -- if there are no matches
                if #matches == 0 then
                        return
                end
                -- cycle
                while ncomp > #matches do
                        ncomp = ncomp - #matches
                end
                -- return match and position
                return matches[ncomp], cur_pos
        end,
        awful.util.getdir("cache") .. "/ssh_history")
end):add()

-- Client manipulation
keybinding({ modkey }, "m", awful.client.maximize):add()
keybinding({ modkey }, "f", function () client.focus.fullscreen = not client.focus.fullscreen end):add()
keybinding({ modkey }, "x", function () client.focus:kill() end):add()
keybinding({ modkey }, "j", function () awful.client.focus.byidx(1); client.focus:raise() end):add()
keybinding({ modkey }, "k", function () awful.client.focus.byidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end):add()
keybinding({ modkey, "Shift" }, "k", function () awful.client.swap(-1) end):add()
keybinding({ modkey, "Control" }, "j", function () awful.screen.focus(1) end):add()
keybinding({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end):add()
keybinding({ modkey, "Control" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Control" }, "Return", function () client.focus:swap(awful.client.getmaster()) end):add()
keybinding({ modkey }, "o", awful.client.movetoscreen):add()
keybinding({ modkey }, "Tab", awful.client.focus.history.previous):add()
keybinding({ modkey }, "u", awful.client.urgent.jumpto):add()
keybinding({ modkey, "Shift" }, "r", function () client.focus:redraw() end):add()

-- Layout manipulation
keybinding({ modkey }, "l", function () awful.tag.incmwfact(0.05) end):add()
keybinding({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end):add()
keybinding({ modkey, "Shift" }, "h", function () awful.tag.incnmaster(1) end):add()
keybinding({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1) end):add()
keybinding({ modkey, "Control" }, "h", function () awful.tag.incncol(1) end):add()
keybinding({ modkey, "Control" }, "l", function () awful.tag.incncol(-1) end):add()
keybinding({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()

-- Prompt
keybinding({ modkey }, "p", function ()

  local s = mouse.screen
  local sel = awful.tag.selected(s)
  local tagindex = 0

  for k, t in ipairs(tags[s]) do
      if t == sel then
        tagindex = k
        break
      end
  end

  if tagdeffunctions[tagindex] then
    awful.util.spawn(tagdeffunctions[tagindex])
  else
    awful.prompt.run({ prompt = "Run: " }, mypromptbox[s], awful.util.spawn, awful.completion.bash, awful.util.getdir("cache") .. "/history")
  end

end):add()

keybinding({ modkey }, "F4", function ()
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox[mouse.screen], awful.util.eval, awful.prompt.bash,
                                                  awful.util.getdir("cache") .. "/history_eval")
                             end):add()

keybinding({ modkey, "Ctrl" }, "i", function ()
                                        local s = mouse.screen
                                        if mypromptbox[s].text then
                                            mypromptbox[s].text = nil
                                        else
                                            mypromptbox[s].text = nil
                                            if client.focus.class then
                                                mypromptbox[s].text = "Class: " .. client.focus.class .. " "
                                            end
                                            if client.focus.instance then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Instance: ".. client.focus.instance .. " "
                                            end
                                            if client.focus.role then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Role: ".. client.focus.role
                                            end
                                        end
                                    end):add()

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()

for i = 1, keynumber do
    keybinding({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

---- Hook function to execute when the mouse enters a client.
--awful.hooks.mouse_enter.register(function (c)
--    -- Sloppy focus, but disabled for magnifier layout
--    if awful.layout.get(c.screen) ~= "magnifier"
--        and awful.client.focus.filter(c) then
--        client.focus = c
--    end
--end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c)
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
        button({ modkey }, 1, function (c) c:mouse_move() end),
        button({ modkey }, 3, function (c) c:mouse_resize() end)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    local rle = c.role
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Check application->screen/tag mappings.
    if appaddtags[cls] then
        target = appaddtags[cls]
    elseif appaddtags[inst] then
        target = appaddtags[inst]
    elseif appaddtags[rle] then
        target = appaddtags[rle]
    end
    if target then
        c.screen = target.screen
        awful.client.toggletag(tags[target.screen][target.tag], c)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.honorsizehints = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    if client.focus then
        local c_c = client.focus:fullgeometry()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
end)

-- Hook called every second
awful.hooks.timer.register(1, function ()
    -- For unix time_t lovers
    -- mytextbox.text = " " .. os.time() .. " time_t "
    -- Otherwise use:
    mytextbox.text = " " .. os.date() .. " "
end)

function hook_battery()
    mybatterybox.text = " Battery : " .. get_acpibatt() .. " "
end

-- {{{ Statusbar battery
--
function get_acpibatt()

    local f = io.popen('acpi -b', 'r')
    if not f then
      return "acpi -b failed"
    end

    local s = f:read('*l')
    f:close()
    if not s then
      return '-';
    end

    -- Battery 0: Discharging, 89%, 00:02:14 remaining
    -- Battery 0: Charging, 58%, 00:02:14 until charged
    -- Battery 0: Full, 100%
    -- so find the first bit first and then go look for the time
    local st, en, status, percent = string.find(s, '%a+%s%d:%s(%a+),%s(%d+%%)');
    local st, en, time = string.find(s, ',%s(%d+:%d+:%d+)%s%a+', en);

    if not status or not percent then -- time can be empty if we're full
      return "couldn't parse line " .. s
    end

    if not time then
      return percent
    end

--    if status == 'Charging' then
--      status = 'c';
--    elseif status == 'Discarching' then
--      status = 'd';
--    else
--      status = '-';
--    end

    return percent .. ' (' .. status .. ')' .. ' ' .. time .. ' left';
end
-- }}}

-- {{{ check mail stack
--
function checkmail()

    local f = io.popen('~/checkmailsys.sh', 'r')
    if not f then
      naught.notify({ text="checkmailsys failed" });
    end

    local s = f:read('*a');
    f:close();
    if s then
      naughty.notify({ text=s });
    end
end
-- }}}

-- Set up some hooks
awful.hooks.timer.register(5, hook_battery)
awful.hooks.timer.register(240, checkmail)
-- }}}

-- }}}
