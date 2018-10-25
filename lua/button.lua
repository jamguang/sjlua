require "movewindow"

local help_win = "help_window"
local help_win_width = 400
local help_win_height = 25
local FONT_NAME = "f1"
local FONT_SIZE = "9"
local left = 50
local top = 10

function buttonTest()
    return function(flags,hotspot_id)
	    messageShow(flags)
		messageShow(hotspot_id)
        if flags==16 then
	       test()
	    end
    end
end
function buttonSet()
    return function(flags,hotspot_id)
        if flags==16 then
	       shujian_set()
	    end
    end
end
function buttonStart()
    return function(flags,hotspot_id)
        if flags==16 then
	       main()
	    end
    end
end
function buttonStop()
    return function(flags,hotspot_id)
        if flags==16 then
	       disAll()
	    end
    end
end
function buttonTongji()
    return function(flags,hotspot_id)
        if flags==16 then
	       jobExpTongji()
		   checkQuestTongji()
	    end
    end
end
function buttonPath()
    return function(flags,hotspot_id)
        if flags==16 then
	        sjPathReset()
	    end
    end
end
function buttonQuest()
    return function(flags,hotspot_id)
        if flags==16 then
	       --checkQuestTongji()
		   questSet()
	    end
    end
end
function buttonPfm()
    return function(flags,hotspot_id)
        if flags==16 then
	       pfmSet()
	    end
    end
end
function buttonWeapon()
    return function(flags,hotspot_id)
        if flags==16 then
	       weaponSet()
	    end
    end
end
function buttonJob()
    return function(flags,hotspot_id)
        if flags==16 then
	       jobSet()
	    end
    end
end
function buttonDrug()
    return function(flags,hotspot_id)
        if flags==16 then
	       drugSet()
	    end
    end
end
function buttonQianwang()
    return function(flags,hotspot_id)
        if flags==16 then
	       qianwang()
	    end
    end
end
function buttonDangpu()
    return function(flags,hotspot_id)
        if flags==16 then
	       goto_set.yz()
	    end
    end
end
function buttonDraw()
    WindowCreate (help_win, 0, 0,  help_win_width, help_win_height, miniwin.pos_bottom_left, 0, 0x000010)
	local help_win_info = movewindow.install(help_win, miniwin.pos_bottom_left, miniwin.create_absolute_location, true)
	WindowCreate(help_win, help_win_info.window_left, help_win_info.window_top, help_win_width, help_win_height, help_win_info.window_mode, help_win_info.window_flags, 0x000010)
	movewindow.add_drag_handler (help_win, 0, 0, help_win_width, 30)
	WindowFont (help_win, FONT_NAME, "Arial", FONT_SIZE)
	WindowResize (help_win, help_win_width, help_win_height, 0x000010)
    WindowCircleOp (help_win, miniwin.circle_round_rectangle, 0, 2, 38, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 40, 2, 78, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 80, 2, 118, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 120, 2, 158, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 160, 2, 198, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 200, 2, 238, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 240, 2, 278, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 280, 2, 318, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 320, 2, 358, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 360, 2, help_win_width, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	--help_win_width
	left = 5
	top = 5

	WindowText (help_win, FONT_NAME, "设置",
					7, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	WindowText (help_win, FONT_NAME, "启动",
					47, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
	WindowText (help_win, FONT_NAME, "停止",
				    87, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
	WindowText (help_win, FONT_NAME, "路径",
				    127, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

    WindowText (help_win, FONT_NAME, "解密",
				    167, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	WindowText (help_win, FONT_NAME, "PFM",
				    207, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
					
	WindowText (help_win, FONT_NAME, "武器",
				    247, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
					
	WindowText (help_win, FONT_NAME, "任务",
				    287, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
					
	WindowText (help_win, FONT_NAME, "药品",
				    327, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
	WindowText (help_win, FONT_NAME, "前往",
				    367, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	top = top + 15
	WindowShow (help_win, true)
	movewindow.save_state(help_win)
    local _buttonset=buttonSet()
    _G["at_mousedown"]=_buttonset
    local _buttonstart=buttonStart()
    _G["at_mousedown1"]=_buttonstart
    local _buttonstop=buttonStop()
    _G["at_mousedown2"]=_buttonstop
    local _buttonpath=buttonPath()
    _G["at_mousedown3"]=_buttonpath
    local _buttonquest=buttonQuest()
	_G["at_mousedown4"]=_buttonquest
	local _buttonpfm=buttonPfm()
	_G["at_mousedown5"]=_buttonpfm
	local _buttonweapon=buttonWeapon()
	_G["at_mousedown6"]=_buttonweapon
	local _buttonjob=buttonJob()
	_G["at_mousedown7"]=_buttonjob
	local _buttondrug=buttonDrug()
	_G["at_mousedown8"]=_buttondrug
	local _buttonqianwang=buttonQianwang()
	_G["at_mousedown9"]=_buttonqianwang

   WindowAddHotspot(help_win, "setting_hotspot",
                    10,  0, 35, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "设置机器人",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags

   WindowAddHotspot(help_win, "start_hotspot",
                    50,  0, 75, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown1",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "启动机器人",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
    WindowAddHotspot(help_win, "stop_hotspot",
                    90,  0, 115, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown2",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "停止机器人",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	 WindowAddHotspot(help_win, "path_hotspot",
                    130,  0, 155, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown3",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "整理路径资料",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "quest_hotspot",
                    170,  0, 195, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown4",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "解密情况统计",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "pfm_hotspot",
                    210,  0, 235, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown5",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "PFM设置",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
    WindowAddHotspot(help_win, "weapon_hotspot",
                    250,  0, 275, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown6",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "武器设置",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "job_hotspot",
                    290,  0, 315, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown7",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "任务设置",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
    WindowAddHotspot(help_win, "drug_hotspot",
                    330,  0, 355, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown8",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "药品设置",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "qianwang_hotspot",
                    370,  0, 395, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown9",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "前往目的地",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
end