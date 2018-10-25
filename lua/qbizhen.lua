quests = quests or {}
quests["bizhen"] = {}
quests["bizhen"].auto = 0
quests["bizhen"].name = '碧针清掌'

questTongji = questTongji or {}
questTongji["bizhen"] = "bizhenTongji"

questCal = questCal or {}
questCal["bizhen"] = "bizhenCal"

questList = questList or {}
questList["bizhen"] = function() if skills["strike"] and skills["strike"].lvl>350 then return quests["bizhen"].name else return false end end


function bizhenCal()
    if GetVariable("autobizhen") and skills["strike"] and skills["strike"].lvl>350 then
      if GetVariable("timebizhen") then
		 quests["bizhen"].time=tonumber(GetVariable("timebizhen"))
	  end
	  if GetVariable("autobizhen") then
		 quests["bizhen"].auto=tonumber(GetVariable("autobizhen"))
	  end
	  if quests["bizhen"].time==nil or os.time()-quests["bizhen"].time > 24*60*60 then
	     quests["bizhen"].time = os.time() - 22*60*60
		 SetVariable("timebizhen",quests["bizhen"].time)
	     if quests["bizhen"].auto==nil or quests["bizhen"].auto == 0 then
	        quests["bizhen"].auto = 1
	     end
	     if quests["bizhen"].auto == 1 then
		    exe('pray pearl')
		    return "questbizhen"
	     end
	  else
	     if quests["bizhen"].auto == 1 and quests["bizhen"].time then
	        local l_time = 24*60*60 - (os.time() - quests["bizhen"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["bizhen"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function bizhenTongji()
    if GetVariable("autobizhen") and quests["bizhen"] and quests["bizhen"].auto == 1 and quests["bizhen"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bizhen"].time)
	   checkQuestNote(quests["bizhen"].name,l_time)
	end
end

function questbizhen()
    return go(bizhenClimb,"摩天崖","摩天崖底")
end
function bizhenClimb()
    exe('climb lian')
	locate()
	return check_bei(bizhenPre,1)
end
function bizhenPre()
    if locl.room~='摩天崖顶' then
	    bizhenDel()
	end
    if not locl.id["谢烟客"] then
	    quests["bizhen"].time = os.time() - 23*60*60
	    return check_bei(bizhenOver)
	end
    DeleteTriggerGroup("bizhenAsk")
    create_trigger_t('wxjAsk1',"^(> )*你向谢烟客打听有关『碧针清掌』的消息。",'','bizhenAsk')
    create_trigger_t('wxjAsk2',"^(> )*这里没有这个人。$",'','bizhenNobody')
    SetTriggerOption("wxjAsk1","group","bizhenAsk")
    SetTriggerOption("wxjAsk2","group","bizhenAsk")
	questStartLog(quests["bizhen"].name)
	exe('ask xie yanke about 碧针清掌')
	exe('alias action 碧针清掌')
end
function bizhenAsk()
    EnableTriggerGroup("bizhenAsk",false)
	DeleteTriggerGroup("bizhen")
	create_trigger_t('bizhen1',"^(> )*谢烟客(|对你)说道：(|「)你来的也太勤快点了！",'','bizhenFail')
	create_trigger_t('bizhen2','^(> )*谢烟客(|对你)说道：(|「)非常遗憾','','bizhenContinue')
	create_trigger_t('bizhen3','^(> )*你把 "action" 设定为 "碧针清掌" 成功完成。','','bizhenSucc')
	create_trigger_t('bizhen4',"^(> )*你听了谢烟客的亲自指点，联想起早期自己所用摩天崖掌的种种心得，两下印照",'','bizhenSucc')
	SetTriggerOption("bizhen1","group","bizhen")
    SetTriggerOption("bizhen2","group","bizhen")
	SetTriggerOption("bizhen3","group","bizhen")
	SetTriggerOption("bizhen4","group","bizhen")
end
function bizhenSucc()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time()
	quests["bizhen"].auto = 2
	questSucLog(quests["bizhen"].name)
	return check_bei(bizhenOver)
end
function bizhenDel()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = 0
	quests["bizhen"].auto = 0
	DeleteVariable("timebizhen")
	DeleteVariable("autobizhen")
	CloseLog()
	return check_bei(checkQuestOver)
end
function bizhenContinue()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time()
	return check_bei(bizhenOver)
end
function bizhenFail()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time() - 20*60*60
	return check_bei(bizhenOver)
end
function bizhenNobody()
    EnableTriggerGroup("bizhenAsk",false)
	quests["bizhen"].time = os.time() - 23*60*60
	return check_bei(bizhenOver)
end
function bizhenOver()
	SetVariable("timebizhen",quests["bizhen"].time)
	SetVariable("autobizhen",quests["bizhen"].auto)
	DeleteTriggerGroup("bizhenAsk")
	DeleteTriggerGroup("bizhen")
	CloseLog()
    return check_bei(checkQuestOver)
end