quests = quests or {}
quests["whdmd"] = {}
quests["whdmd"].auto = 0
quests["whdmd"].name = '五虎断门刀'

questTongji = questTongji or {}
questTongji["whdmd"] = "whdmdTongji"

questCal = questCal or {}
questCal["whdmd"] = "whdmdCal"

questList = questList or {}
questList["whdmd"] = function() if skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 then return quests["whdmd"].name else return false end end


function whdmdCal()
    if GetVariable("autowhdmd") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 then
        if GetVariable("timewhdmd") then
		    quests["whdmd"].time=tonumber(GetVariable("timewhdmd"))
	    end
	    if GetVariable("autowhdmd") then
		    quests["whdmd"].auto=tonumber(GetVariable("autowhdmd"))
	    end
	    if quests["whdmd"].time==nil or os.time()-quests["whdmd"].time > 24*60*60 then
	        quests["whdmd"].time = os.time() - 22*60*60
		    SetVariable("timewhdmd",quests["whdmd"].time)
	        if quests["whdmd"].auto==nil or quests["whdmd"].auto == 0 then
	            quests["whdmd"].auto = 1
	        end
	        if quests["whdmd"].auto == 1 then
		        exe('pray pearl')
		        return "questwhdmd"
	        end
	    else
	        if quests["whdmd"].auto == 1 and quests["whdmd"].time then
	            local l_time = 24*60*60 - (os.time() - quests["whdmd"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["whdmd"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function whdmdTongji()
    if GetVariable("autowhdmd") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 and quests["whdmd"] and quests["whdmd"].auto == 1 and quests["whdmd"].time then
	   local l_time = 24*60*60 - (os.time() - quests["whdmd"].time)
	   checkQuestNote(quests["whdmd"].name,l_time)
	end
end

function questwhdmd()
    return go(whdmdPre,"扬州城","东厢房")
end
function whdmdPre()
    if not locl.id["茅十八"] then
	   quests["whdmd"].time = os.time() - 23*60*60
	   return check_bei(whdmdOver)
	end
    DeleteTriggerGroup("whdmdAsk")
    create_trigger_t('whdmdAsk1',"^(> )*你向茅十八打听有关『五虎断门刀』的消息。$",'','whdmdAsk')
    create_trigger_t('whdmdAsk2',"^(> )*这里没有这个人。$",'','whdmdNobody')
    SetTriggerOption("whdmdAsk1","group","whdmdAsk")
    SetTriggerOption("whdmdAsk2","group","whdmdAsk")
	questStartLog(quests["whdmd"].name)
	exe('ask mao shiba about 五虎断门刀')
	exe('alias action 五虎断门刀')
end
function whdmdAsk()
    EnableTriggerGroup("whdmdAsk",false)
	DeleteTriggerGroup("whdmd")
	create_trigger_t('whdmd1',"^(> )*茅十八(对你|)说道：(|「)我养伤期间不能太频繁回答你，过一阵在再来！",'','whdmdFail')
	create_trigger_t('whdmd2','^(> )*茅十八(对你|)说道：(|「)我在养伤期间，心情不好，隔一阵再来！','','whdmdContinue')
	create_trigger_t('whdmd3','^(> )*你把 "action" 设定为 "五虎断门刀" 成功完成。','','whdmdSucc')
	create_trigger_t('whdmd4',"^(> )*瑛姑说道：「你太懒了，不愿意搭理你",'','whdmdDel')
	create_trigger_t('whdmd5',"^(> )*你听了茅十八的话，心中豁然开朗，五虎断门刀的造诣更深了一层！",'','whdmdSucc')
	SetTriggerOption("whdmd1","group","whdmd")
    SetTriggerOption("whdmd2","group","whdmd")
	SetTriggerOption("whdmd3","group","whdmd")
	SetTriggerOption("whdmd4","group","whdmd")
	SetTriggerOption("whdmd5","group","whdmd")
end
function whdmdSucc()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time()
	quests["whdmd"].auto = 2
	questSucLog(quests["whdmd"].name)
	return check_bei(whdmdOver)
end
function whdmdDel()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = 0
	quests["whdmd"].auto = 0
	DeleteVariable("timewhdmd")
	DeleteVariable("autowhdmd")
	CloseLog()
	return check_bei(checkQuestOver)
end
function whdmdContinue()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time()
	return check_bei(whdmdOver)
end
function whdmdFail()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time() - 20*60*60
	return check_bei(whdmdOver)
end
function whdmdNobody()
    EnableTriggerGroup("whdmdAsk",false)
	quests["whdmd"].time = os.time() - 23*60*60
	return check_bei(whdmdOver)
end
function whdmdOver()
	SetVariable("timewhdmd",quests["whdmd"].time)
	SetVariable("autowhdmd",quests["whdmd"].auto)
	DeleteTriggerGroup("whdmdAsk")
	DeleteTriggerGroup("whdmd")
	CloseLog()
    return check_bei(checkQuestOver)
end