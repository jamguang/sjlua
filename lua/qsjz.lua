quests = quests or {}
quests["sjz"] = {}
quests["sjz"].auto = 0
quests["sjz"].name = '三绝指'

questTongji = questTongji or {}
questTongji["sjz"] = "sjzTongji"

questCal = questCal or {}
questCal["sjz"] = "sjzCal"

questList = questList or {}
questList["sjz"] = function() if score.party=="姑苏慕容" then return quests["sjz"].name else return false end end


function sjzCal()
    if GetVariable("autosjz") and score.party=="姑苏慕容" and skills["canhe-zhi"] and skills["canhe-zhi"].lvl>499 then
      if GetVariable("timesjz") then
		 quests["sjz"].time=tonumber(GetVariable("timesjz"))
	  end
	  if GetVariable("autosjz") then
		 quests["sjz"].auto=tonumber(GetVariable("autosjz"))
	  end
	  if quests["sjz"].time==nil or os.time()-quests["sjz"].time > 24*60*60 then
	     quests["sjz"].time = os.time() - 22*60*60
		 SetVariable("timesjz",quests["sjz"].time)
	     if quests["sjz"].auto==nil or quests["sjz"].auto == 0 then
	        quests["sjz"].auto = 1
	     end
	     if quests["sjz"].auto == 1 then
		    exe('pray pearl')
		    return "questsjz"
	     end
	  else
	     if quests["sjz"].auto == 1 and quests["sjz"].time then
	        local l_time = 24*60*60 - (os.time() - quests["sjz"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["sjz"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function sjzTongji()
    if GetVariable("autosjz") and quests["sjz"] and quests["sjz"].auto == 1 and quests["sjz"].time then
	   local l_time = 24*60*60 - (os.time() - quests["sjz"].time)
	   checkQuestNote(quests["sjz"].name,l_time)
	end
end

function questsjz()
   return go(sjzPre,"shaolin/houyuan")
end
function sjzPre()
    if not locl.id["慕容博"] then
	   quests["sjz"].time = os.time() - 23*60*60
	   return check_bei(sjzOver)
	end
    DeleteTriggerGroup("sjzAsk")
    create_trigger_t('sjzAsk1',"^(> )*你向慕容博打听有关『三绝指』的消息",'','sjzAsk')
    create_trigger_t('sjzAsk2',"^(> )*这里没有这个人。$",'','sjzNobody')
    SetTriggerOption("sjzAsk1","group","sjzAsk")
    SetTriggerOption("sjzAsk2","group","sjzAsk")

    questStartLog(quests["sjz"].name)
	return exe('ask murong bo about 三绝指')
	
end
function sjzAsk()
    EnableTriggerGroup("sjzAsk",false)
	DeleteTriggerGroup("sjz")
	create_trigger_t('sjz1',"^(> )*慕容博说道：「(你若想学这门招式，你就去少林寺藏经阁一趟，去多偷看|你方才不是问了么，我已经告诉你，赶紧去吧！)",'','sjzGo')
	SetTriggerOption("sjz1","group","sjz")
end
function sjzGo()
    EnableTriggerGroup("sjz",false)
    return go(sjzkill,"shaolin/cjlou1")
end
function sjzkill()
    return wipe("huizhen zunzhe",sjztouxue)
end
function sjztouxue()
	DeleteTriggerGroup("sjz")
	create_trigger_t('sjz1',"^(> )*你虽然得知三绝指招式，但因机缘不到，不能得到彻底融会贯通。",'','sjzContinue')
	create_trigger_t('sjz2',"^(> )*恭喜你",'','sjzSucc')
	create_trigger_t('sjz3',"^(> )*你(没事跑到藏经楼偷看什么东西|太勤快了耶)",'','sjzFail')
	SetTriggerOption("sjz1","group","sjz")
	SetTriggerOption("sjz2","group","sjz")
	SetTriggerOption("sjz3","group","sjz")
	exe("toukan 指法秘籍")
end
function sjzSucc()
    EnableTriggerGroup("sjz",false)
	questSucLog(quests["sjz"].name)
	quests["sjz"].time = os.time()
	quests["sjz"].auto = 2
	questSucLog(quests["sjz"].name)
	return check_bei(sjzOver)
end
function sjzDel()
    EnableTriggerGroup("sjz",false)
	quests["sjz"].time = 0
	quests["sjz"].auto = 0
	DeleteVariable("timesjz")
	DeleteVariable("autosjz")
	CloseLog()
	return check_bei(checkQuestOver)
end
function sjzContinue()
    EnableTriggerGroup("sjz",false)
	quests["sjz"].time = os.time()
	return check_bei(sjzOver)
end
function sjzFail()
    EnableTriggerGroup("sjz",false)
	quests["sjz"].time = os.time() - 20*60*60
	return check_bei(sjzOver)
end
function sjzNobody()
    EnableTriggerGroup("sjzAsk",false)
	quests["sjz"].time = os.time() - 23*60*60
	return check_bei(sjzOver)
end
function sjzOver()
	SetVariable("timesjz",quests["sjz"].time)
	SetVariable("autosjz",quests["sjz"].auto)
	DeleteTriggerGroup("sjzAsk")
	DeleteTriggerGroup("sjz")
	CloseLog()
    return check_bei(checkQuestOver)
end