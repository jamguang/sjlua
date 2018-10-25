require "movewindow"  -- load the movewindow.lua module
local show_message=false

-- configuration

-- number of lines to show
local MAX_LINES = 20

-- font
local FONT_NAME = "Dina"
local FONT_SIZE = 8

-- where to put the window
local WINDOW_POSITION = miniwin.pos_top_right

-- colours
local WINDOW_BACKGROUND_COLOUR = "black"
local WINDOW_TITLE_COLOUR = "black"
local WINDOW_TITLE_BACKGROUND = "darkgoldenrod"

local NOTE_COLOUR = "Cyan"


-- window title
local title = "任务信息"

-- offset of text from edge
local TEXT_INSET = 5

-- where to store the message lines
local lines = {}  -- table of recent message lines
local styles = {} -- current line

-- display one line
local m_win
local function show_line (n, styles)

  local left = TEXT_INSET
  local top = (n - 1) * font_height + TEXT_INSET

  -- display each style, including the appropriate background under it
  for _, v in ipairs (styles) do
    local width = WindowTextWidth (m_win, "f", v.text) -- get width of text
    local right = left + width                       -- work out RH side
    local bottom = top + font_height                 -- work out bottom
    WindowRectOp (m_win, miniwin.rect_fill, left, top, right, bottom,
                  ColourNameToRGB (v.backcolour or WINDOW_BACKGROUND_COLOUR))  -- draw background
    WindowText (m_win, "f", v.text, left, top, window_width - TEXT_INSET, 0,
                  ColourNameToRGB (v.textcolour or NOTE_COLOUR))  -- draw text
    left = left + width  -- advance horizontally
  end -- for each style run

end -- Display_Line

local function add_line (line)

  -- remove first line if filled up
  if #lines >= MAX_LINES then
    table.remove (lines, 1)
  end -- if

  -- add new line
  table.insert (lines, line)

end -- add_line

-- here on output to display
local function redraw_all ()

  -- blank existing window contents
  WindowRectOp (m_win, miniwin.rect_fill, 0, 0, 0, 0, ColourNameToRGB (WINDOW_BACKGROUND_COLOUR))

  -- draw drag bar rectangle
  WindowRectOp (m_win, miniwin.rect_fill, 0, 0, 0, font_height + 2, ColourNameToRGB (WINDOW_TITLE_BACKGROUND))

  -- draw border
  check (WindowRectOp (m_win, miniwin.rect_draw_edge, 0, 0, 0, 0, miniwin.rect_edge_raised, miniwin.rect_edge_at_all))

  local sz = WindowTextWidth (m_win, "fb", title)
  WindowText (m_win, "fb", title, (window_width - sz) / 2, 1, window_width - TEXT_INSET, 0,
              ColourNameToRGB (WINDOW_TITLE_COLOUR))

  -- display all lines
  for k, v in ipairs (lines) do
    show_line (k + 1, v)
  end -- for

  Redraw ()

end -- end redraw_all

local function warning (msg)
  ColourNote ("white", "red", msg)
end -- warning

local function _init()
    --world.ColourNote("salmon", "", "afk:set_command cmd  - 设置 AFK 命令，cmd 为任何你想发送的 MUD 命令")
    --[[world.ColourNote("salmon", "", "afk:set_time seconds - 设置 AFK 的时间，seconds 为大于 0 小于 3600 的数字（秒）,发送一个set afk命令")
    world.ColourNote("salmon", "", "afk:enable           - 启用 AFK 插件")
    world.ColourNote("salmon", "", "afk:disable          - 禁用 AFK 插件")
    world.ColourNote("salmon", "", "afk:show_state       - 显示 AFK 当前的状态")
	--alias
	world.AddAlias("afk_settime", "^afk:set_time (\\\d*)$", "set_AFKTime(%1)", alias_flag.Enabled + alias_flag.RegularExpression, "")
    world.SetAliasOption ("afk_settime", "send_to", 12) --向脚本发送

    --world.AddAlias("afk_cmd", "^afk:set_command (.*)$", "set_AFKCmd('%1')", alias_flag.Enabled + alias_flag.RegularExpression , "")
    --world.SetAliasOption ("afk_cmd", "send_to", 12) --向脚本发送

	world.AddAlias("afk_enable", "afk:enable", "Enable_AFK()", alias_flag.Enabled, "")
    world.SetAliasOption ("afk_enable", "send_to", 12) --向脚本发送

	world.AddAlias("afk_disable", "afk:disable", "Disable_AFK()", alias_flag.Enabled, "")
    world.SetAliasOption ("afk_disable", "send_to", 12) --向脚本发送

	world.AddAlias("afk_status", "afk:show_state", "Status_AFK()", alias_flag.Enabled, "")
    world.SetAliasOption ("afk_status", "send_to", 12) --向脚本发送]]
end

-- EXPOSED FUNCTIONS

-- hide window on removal

function messageLoad()
   OnPluginInstall()
end
function OnPluginInstall()
   --ColourNote("white", "red", "叶知秋版_for_书剑_信息插件0.1版")
   CreateMessage()
   _init()
   mbutton()

end

function OnPluginClose ()
  WindowShow (m_win,  false)  -- hide it
end -- OnPluginClose

-- hide window on disable
function OnPluginDisable ()
  WindowShow (m_win,  false)  -- hide it
end -- OnPluginDisable

-- show window on enable
function OnPluginEnable ()
  if #lines > 0 then
    WindowShow (m_win,  true)  -- show it
  end -- if
end -- OnPluginEnable

function OnPluginSaveState ()
  -- save window current location for next time
  movewindow.save_state (m_win)
end -- function OnPluginSaveState

function OnPluginConnect()

end

function OnPluginDisconnect()

end

-- eg. CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", "test note")
--     CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", "test note", "yellow") -- yellow text
--     CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", "test note", "yellow", "white") -- yellow on white



function MsgNote (text, textcolour, backcolour)

  -- add this style (if any text)
  if text then

    if type (text) ~= "string" then
     warning ("First argument to MsgNote must be message text (string)")
     return
    end -- if

    table.insert (styles, { text = text, textcolour = textcolour, backcolour = backcolour } )
  end -- if

  -- add all styles to this line
  add_line (styles)

  -- start new line
  styles = {}

  -- display existing lines
  redraw_all ()

  WindowShow (m_win,  true)  -- show it

end -- MsgNote




-- eg.  CallPlugin ("126d9061f9758498c878a204", "MsgClear")

function MsgClear ()
  lines = {}
  styles = {}
   -- display blank window
  redraw_all ()
end -- MsgClear

-- eg.  CallPlugin ("126d9061f9758498c878a204", "MsgHide")

function MsgHide ()
  WindowShow (m_win,  false)  -- hide it
end -- MsgHide

-- eg.  CallPlugin ("126d9061f9758498c878a204", "MsgShow")

function MsgShow ()
  WindowShow (m_win,  true)  -- show it
  redraw_all ()
end -- MsgShow

-- eg.  CallPlugin ("126d9061f9758498c878a204", "MsgTitle", "Combat Messages")

function MsgTitle (new_title)
  if type (new_title) ~= "string" then
     warning ("First argument to MsgTitle must be window title (string)")
     return
  end -- if

  title = new_title
  redraw_all ()
end -- MsgTitle

function CreateMessage()
  -- startup stuff - create window, find font characteristics

--m_win = GetPluginID ()  -- get a unique name
m_win="message1"
-- make the window
WindowCreate (m_win , 0, 0, 1, 1, WINDOW_POSITION, 0, 0)  -- create window

fonts = utils.getfontfamilies ()

if not fonts.Dina then
  AddFont (GetInfo (66) .. "\\Dina.fon")
end -- if Dina not installed

-- grab a font
WindowFont (m_win, "f", FONT_NAME, FONT_SIZE) -- define font
WindowFont (m_win, "fb", FONT_NAME, FONT_SIZE, true) -- define font

-- work out how high and wide it is
font_height = WindowFontInfo (m_win, "f", 1)   -- height of the font
wrap_column = GetOption ("wrap_column")

window_width = 600--(wrap_column * WindowFontInfo (m_win, "f", 6)) + (TEXT_INSET * 2)
window_height = 300--(MAX_LINES + 1) * font_height + TEXT_INSET * 2  -- one more line for title



-- install the window movement handler, get back the window position
windowinfo = movewindow.install (m_win, WINDOW_POSITION)

-- remake the window with the correct width
WindowCreate (m_win,
               windowinfo.window_left,
               windowinfo.window_top,
               window_width, window_height,
               windowinfo.window_mode,
               windowinfo.window_flags,
               0)

-- add the drag handler so they can move the window around
movewindow.add_drag_handler (m_win, 0, 0, 0, font_height + 2)
-- add mouse wheel events
--[[WindowAddHotspot(m_win, "Mouse_wheel",
                 windowinfo.window_left, windowinfo.window_top, windowinfo.window_left+window_width, windowinfo.window_top+window_height,   -- rectangle
                 "",  -- mouseover
                 "",  -- cancelmouseover
                 "",  -- mousedown
                 "",  -- cancelmousedown
                 "",  -- mouseup
                 "",  -- tooltip text
                 miniwin.cursor_hand, 0)  -- hand cursor

WindowScrollwheelHandler (m_win,"Mouse_wheel", "wheel_updown")]]
--WindowShow(m_win,true)
end

function mousedown()
  return function (flags, hotspot_id)
    --print(flags)

	if flags==16 then
      if show_message==true then
        show_message=false
		 switch_name="∨"
		  MsgShow()
      else
        show_message=true
		switch_name="∧"
		 MsgHide()
      end
      	   --text add

	  WindowCircleOp (win, miniwin.circle_round_rectangle , 0, 0, 20, 20, 0x909090, 0, 1,0, 0, 9, 9)
	   --text add
      WindowFont (win, "f", "宋体", 8, true, false, false, false)
	  WindowText (win, "f", switch_name,4,4,18,18,ColourNameToRGB ("blue"), false) -- not Unicode
      WindowShow (win,  true)  -- show it
	end
  end
end

function mbutton()
   win="show_message_btn"
   WindowCreate(win,0,0,20,20,miniwin.pos_top_right,0,ColourNameToRGB("black"))
   local _mousedown=mousedown()
   _G["at_mousedownx"]=_mousedown
   WindowAddHotspot(win, "show_message_hotspot",
                    0,  0,20, 20,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedownx",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "显示自动记录信息",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags


	  local switch_name=""
	  if show_message==true then
	     switch_name="∨"
		 MsgShow()
		 --ColourNote("red", "black", "信息窗体开")
		 show_message=false
	  else
	     switch_name="∧"
		 --ColourNote("red", "black", "信息窗体关")
		 show_message=true
	  end
	 --WindowRectOp (win, miniwin.rect_fill, 0,0,15,15,0x909090)  -- raised, filled, softer, flat
	 --WindowRectOp (win, miniwin.rect_fill, 0,0,20,20,ColourNameToRGB("black"))  -- raised, filled, softer, flat 0x909090
     WindowCircleOp (win, miniwin.circle_round_rectangle , 0, 0, 20, 20, 0x909090, 0, 1,0, 0, 9, 9)
	   --text add
	 WindowFont (win, "f", "宋体", 8, true, false, false, false)
	 WindowText (win, "f", switch_name,4,4,18,18,ColourNameToRGB ("blue"), false) -- not Unicode
     WindowShow (win,  true)  -- show it

end


