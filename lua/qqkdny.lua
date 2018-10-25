quests = quests or {}
quests["qkdny"] = {}
quests["qkdny"].auto = 0
quests["qkdny"].name = '乾坤大挪移神功'

questTongji = questTongji or {}
questTongji["qkdny"] = "qkdnyTongji"

questCal = questCal or {}
questCal["qkdny"] = "qkdnyCal"

questList = questList or {}
questList["qkdny"] = function() if score.party=="明教" then return quests["qkdny"].name else return false end end


function qkdnyCal()
    if GetVariable("autoqkdny") and score.party=="明教" and skills["force"] and skills["force"].lvl>450 then
        if GetVariable("timeqkdny") then
		    quests["qkdny"].time=tonumber(GetVariable("timeqkdny"))
	    end
	    if GetVariable("autoqkdny") then
		    quests["qkdny"].auto=tonumber(GetVariable("autoqkdny"))
	    end
	    if quests["qkdny"].time==nil or os.time()-quests["qkdny"].time > 24*60*60 then
	        quests["qkdny"].time = os.time() - 22*60*60
		    SetVariable("timeqkdny",quests["qkdny"].time)
	        if quests["qkdny"].auto==nil or quests["qkdny"].auto == 0 then
	            quests["qkdny"].auto = 1
	        end
	        if quests["qkdny"].auto == 1 then
		        exe('pray pearl')
		        return "questqkdny"
	        end
	    else
	        if quests["qkdny"].auto == 1 and quests["qkdny"].time then
	            local l_time = 24*60*60 - (os.time() - quests["qkdny"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["qkdny"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function qkdnyTongji()
    if GetVariable("autoqkdny") and score.party=="明教" and skills["force"] and skills["force"].lvl>450 and quests["qkdny"] and quests["qkdny"].auto == 1 and quests["qkdny"].time then
	   local l_time = 24*60*60 - (os.time() - quests["qkdny"].time)
	   checkQuestNote(quests["qkdny"].name,l_time)
	end
end

function questqkdny()
    return go(qkdnyPre,"明教","圣火堂")
end
function qkdnyPre()
    if not locl.id["张无忌"] then
	   quests["qkdny"].time = os.time() - 23*60*60
	   return check_bei(qkdnyOver)
	end
    DeleteTriggerGroup("qkdnyAsk")
    create_trigger_t('qkdnyAsk1',"^(> )*你向张无忌打听有关『乾坤大挪移神功』的消息。$",'','qkdnyAsk')
    create_trigger_t('qkdnyAsk2',"^(> )*这里没有这个人。$",'','qkdnyNobody')
    SetTriggerOption("qkdnyAsk1","group","qkdnyAsk")
    SetTriggerOption("qkdnyAsk2","group","qkdnyAsk")
	questStartLog(quests["qkdny"].name)
	return exe('ask zhang wuji about 乾坤大挪移神功')
end
function qkdnyAsk()
    EnableTriggerGroup("qkdnyAsk",false)
	DeleteTriggerGroup("qkdny")
	create_trigger_t('qkdny1',"^(> )*张无忌说道：「今天先教到到这里吧，明天吧。」$",'','qkdnyFail')
	create_trigger_t('qkdny2','^(> )*张无忌对你失望极了','','qkdnyContinue')
	create_trigger_t('qkdny3',"^(> )*张无忌说道：「你已经彻底",'','qkdnySucc')
	create_trigger_t('qkdny4',"^(> )*瑛姑说道：「你太懒了，不愿意搭理你",'','qkdnyDel')
	SetTriggerOption("qkdny1","group","qkdny")
    SetTriggerOption("qkdny2","group","qkdny")
	SetTriggerOption("qkdny3","group","qkdny")
	SetTriggerOption("qkdny4","group","qkdny")
end
function qkdnySucc()
    EnableTriggerGroup("qkdny",false)
	quests["qkdny"].time = os.time()
	quests["qkdny"].auto = 2
	questSucLog(quests["qkdny"].name)
	return check_bei(qkdnyOver)
end
function qkdnyDel()
    EnableTriggerGroup("qkdny",false)
	quests["qkdny"].time = 0
	quests["qkdny"].auto = 0
	DeleteVariable("timeqkdny")
	DeleteVariable("autoqkdny")
	CloseLog()
	return check_bei(checkQuestOver)
end
function qkdnyContinue()
    EnableTriggerGroup("qkdny",false)
	quests["qkdny"].time = os.time()
	return check_bei(qkdnyOver)
end
function qkdnyFail()
    EnableTriggerGroup("qkdny",false)
	quests["qkdny"].time = os.time() - 20*60*60
	return check_bei(qkdnyOver)
end
function qkdnyNobody()
    EnableTriggerGroup("qkdnyAsk",false)
	quests["qkdny"].time = os.time() - 23*60*60
	return check_bei(qkdnyOver)
end
function qkdnyOver()
	SetVariable("timeqkdny",quests["qkdny"].time)
	SetVariable("autoqkdny",quests["qkdny"].auto)
	DeleteTriggerGroup("qkdnyAsk")
	DeleteTriggerGroup("qkdny")
	CloseLog()
    return check_bei(checkQuestOver)
end