quests = quests or {}
quests["baduan"] = {}
quests["baduan"].auto = 0
quests["baduan"].name = '八段锦绝技'

questTongji = questTongji or {}
questTongji["baduan"] = "baduanTongji"

questCal = questCal or {}
questCal["baduan"] = "baduanCal"

questList = questList or {}
questList["baduan"] = function() if skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 then return quests["baduan"].name else return false end end


function baduanCal()
    if GetVariable("autobaduan") and skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 then
        if GetVariable("timebaduan") then
		    quests["baduan"].time=tonumber(GetVariable("timebaduan"))
	    end
	    if GetVariable("autobaduan") then
		    quests["baduan"].auto=tonumber(GetVariable("autobaduan"))
	    end
	    if quests["baduan"].time==nil or os.time()-quests["baduan"].time > 24*60*60 then
	        quests["baduan"].time = os.time() - 22*60*60
		    SetVariable("timebaduan",quests["baduan"].time)
	        if quests["baduan"].auto==nil or quests["baduan"].auto == 0 then
	            quests["baduan"].auto = 1
	        end
	        if quests["baduan"].auto == 1 then
		        exe('pray pearl')
		        return "questbaduan"
	        end
	    else
	        if quests["baduan"].auto == 1 and quests["baduan"].time then
	            local l_time = 24*60*60 - (os.time() - quests["baduan"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["baduan"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function baduanTongji()
    if GetVariable("autobaduan") and skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 and quests["baduan"] and quests["baduan"].auto == 1 and quests["baduan"].time then
	   local l_time = 24*60*60 - (os.time() - quests["baduan"].time)
	   checkQuestNote(quests["baduan"].name,l_time)
	end
end

function questbaduan()
    return go(baduanZhu,"扬州城","兵器铺")
end
function baduanZhu()
    if not locl.id["铸剑师"] then
	    return go(baduanZhu,"扬州城","兵器铺")
	end
	exe("askk zhujian shi about 大秘密")
    return fastSearch("扬州城中央广场","赵爵爷","baduanPre")
end
function baduanPre()
    if not locl.id["赵爵爷"] then
	   quests["baduan"].time = os.time() - 23*60*60
	   return check_bei(baduanOver)
	end
    DeleteTriggerGroup("baduanAsk")
    create_trigger_t('baduanAsk1',"^(> )*你向赵爵爷打听有关『八段锦的秘密』的消息。$",'','baduanAsk')
    create_trigger_t('baduanAsk2',"^(> )*这里没有这个人。$",'','baduanNobody')
    SetTriggerOption("baduanAsk1","group","baduanAsk")
    SetTriggerOption("baduanAsk2","group","baduanAsk")
	questStartLog(quests["baduan"].name)
	exe('askk zhao jueye about 八段锦的秘密')
end
function baduanAsk()
    EnableTriggerGroup("baduanAsk",false)
	DeleteTriggerGroup("baduan")
	create_trigger_t('baduan1',"^(> )*赵爵爷(对你|)说道：(|「)嗯？你不是刚来",'','baduanFail')
	create_trigger_t('baduan2','^(> )*你摇了摇头，道','','baduanContinue')
	create_trigger_t('baduan3','^(> )*你已经习得','','baduanSucc')
	create_trigger_t('baduan4',"^(> )*赵爵爷(对你|)说道：(|「)我不知道你在说什么",'','baduanRst')
	create_trigger_t('baduan5',"^(> )*赵爵爷对你说道：恭喜解密铁脚仙绝技",'','baduanSucc')
	SetTriggerOption("baduan1","group","baduan")
    SetTriggerOption("baduan2","group","baduan")
	SetTriggerOption("baduan3","group","baduan")
	SetTriggerOption("baduan4","group","baduan")
	SetTriggerOption("baduan5","group","baduan")
end
function baduanRst()
    EnableTriggerGroup("baduan",false)
	return questbaduan()
end
function baduanSucc()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time()
	quests["baduan"].auto = 2
	questSucLog(quests["baduan"].name)
	return check_bei(baduanOver)
end
function baduanDel()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = 0
	quests["baduan"].auto = 0
	DeleteVariable("timebaduan")
	DeleteVariable("autobaduan")
	CloseLog()
	return check_bei(checkQuestOver)
end
function baduanContinue()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time()
	return check_bei(baduanOver)
end
function baduanFail()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time() - 20*60*60
	return check_bei(baduanOver)
end
function baduanNobody()
    EnableTriggerGroup("baduanAsk",false)
	quests["baduan"].time = os.time() - 23*60*60
	return check_bei(baduanOver)
end
function baduanOver()
	SetVariable("timebaduan",quests["baduan"].time)
	SetVariable("autobaduan",quests["baduan"].auto)
	DeleteTriggerGroup("baduanAsk")
	DeleteTriggerGroup("baduan")
	CloseLog()
    return check_bei(checkQuestOver)
end