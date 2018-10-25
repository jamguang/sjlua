quests = quests or {}
quests["yusui"] = {}
quests["yusui"].auto = 0
quests["yusui"].name = "玉碎刀光"

questTongji = questTongji or {}
questTongji["yusui"] = "yusuiTongji"

questCal = questCal or {}
questCal["yusui"] = "yusuiCal"

questList = questList or {}
questList["yusui"] = function() if score.party and score.party=="姑苏慕容" and skills["murong-daofa"] then return "玉碎刀光" else return false end end


function yusuiCal()
    if score.party=="姑苏慕容" and GetVariable("autoyusui") and skills["murong-daofa"] then
      if GetVariable("timeyusui") then
		 quests["yusui"].time=tonumber(GetVariable("timeyusui"))
	  end
	  if GetVariable("autoyusui") then
		 quests["yusui"].auto=tonumber(GetVariable("autoyusui"))
	  end
	  if quests["yusui"].time==nil or os.time()-quests["yusui"].time > 24*60*60 then
	     quests["yusui"].time = os.time() - 12*60*60
		 SetVariable("timeyusui",quests["yusui"].time)
	     if quests["yusui"].auto==nil or quests["yusui"].auto == 0 then
	        quests["yusui"].auto = 1
	     end
	     if quests["yusui"].auto == 1 then
		    exe('pray pearl')
		    return "questYusui"
	     end
	  else
	     if quests["yusui"].auto == 1 and quests["yusui"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yusui"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("玉碎刀光",l_time)
			end
	     end
	     return false
	  end
   end
end
function yusuiTongji()
    if GetVariable("autoyusui") and quests["yusui"] and quests["yusui"].auto == 1 and quests["yusui"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yusui"].time)
	   checkQuestNote("玉碎刀光",l_time)
	end
end
function questYusui()
   return go(yusuiPre,"姑苏慕容","小舍")
end
function yusuiPre()
    if not locl.id["包不同"] then
	   quests["yusui"].time = os.time() - 20*60*60
	   return check_bei(yusuiOver)
	end
    DeleteTriggerGroup("yusuiAsk")
    create_trigger_t('yusuiAsk1',"^(> )*你向包不同打听有关『玉碎刀光绝技』的消息",'','yusuiAsk')
    create_trigger_t('yusuiAsk2',"^(> )*这里没有这个人。$",'','yusuiNobody')
    SetTriggerOption("yusuiAsk1","group","yusuiAsk")
    SetTriggerOption("yusuiAsk2","group","yusuiAsk")
	questStartLog(quests["yusui"].name)
	exe('ask bao butong about 玉碎刀光绝技')
	exe('alias action 玉碎刀光绝技')
end
function yusuiAsk()
    EnableTriggerGroup("yusuiAsk",false)
	DeleteTriggerGroup("yusui")
	create_trigger_t('yusui1',"^(> )*包不同(对你|)说道：(「|)你来的也太勤快了",'','yusuiFail')
	create_trigger_t('yusui2','^(> )*你虽然听包不同','','yusuiContinue')
	create_trigger_t('yusui3','^(> )*你把 "action" 设定为 "玉碎刀光绝技" 成功完成。','','yusuiContinue')
	create_trigger_t('yusui4','^(> )*你的声音越来越大，声震云霄','','yusuiSucc')
	create_trigger_t('yusui5','^(> )*包不同说道：「你已经解开了？」','','yusuiSucc')
	SetTriggerOption("yusui1","group","yusui")
    SetTriggerOption("yusui2","group","yusui")
	SetTriggerOption("yusui3","group","yusui")
	SetTriggerOption("yusui4","group","yusui")
	SetTriggerOption("yusui5","group","yusui")
end
function yusuiSucc()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time()
	quests["yusui"].auto = 2
	questSucLog(quests["yusui"].name)
	return check_bei(yusuiOver)
end
function yusuiContinue()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time()
	return check_bei(yusuiOver)
end
function yusuiFail()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time() - 12*60*60
	return check_bei(yusuiOver)
end
function yusuiNobody()
    EnableTriggerGroup("yusuiAsk",false)
	quests["yusui"].time = os.time() - 18*60*60
	return check_bei(yusuiOver)
end
function yusuiOver()
	SetVariable("timeyusui",quests["yusui"].time)
	SetVariable("autoyusui",quests["yusui"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end