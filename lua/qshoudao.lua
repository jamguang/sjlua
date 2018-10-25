quests = quests or {}
quests["shoudao"] = {}
quests["shoudao"].auto = 0
quests["shoudao"].name = "燃木手刀绝技"

questTongji = questTongji or {}
questTongji["shoudao"] = "shoudaoTongji"

questCal = questCal or {}
questCal["shoudao"] = "shoudaoCal"

questList = questList or {}
questList["shoudao"] = function() if score.party and score.party=="少林派" then return quests["shoudao"].name else return false end end


function shoudaoCal()
    if skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and GetVariable("autoshoudao") then
      if GetVariable("timeshoudao") then
		 quests["shoudao"].time=tonumber(GetVariable("timeshoudao"))
	  end
	  if GetVariable("autoshoudao") then
		 quests["shoudao"].auto=tonumber(GetVariable("autoshoudao"))
	  end
	  if quests["shoudao"].time==nil or os.time()-quests["shoudao"].time > 24*60*60 then
	     quests["shoudao"].time = os.time() - 12*60*60
		 SetVariable("timeshoudao",quests["shoudao"].time)
	     if quests["shoudao"].auto==nil or quests["shoudao"].auto == 0 then
	        quests["shoudao"].auto = 1
	     end
	     if quests["shoudao"].auto == 1 then
		    exe('pray pearl')
		    return "questShoudao"
	     end
	  else
	     if quests["shoudao"].auto == 1 and quests["shoudao"].time then
	        local l_time = 24*60*60 - (os.time() - quests["shoudao"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["shoudao"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function shoudaoTongji()
    if GetVariable("autoshoudao") and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and quests["shoudao"] and quests["shoudao"].auto == 1 and quests["shoudao"].time then
	   local l_time = 24*60*60 - (os.time() - quests["shoudao"].time)
	   checkQuestNote(quests["shoudao"].name,l_time)
	end
end
function questShoudao()
   return go(shoudaoPre,"嵩山少林","罗汉堂")
end
function shoudaoPre()
    if not locl.id["玄苦大师"] then
	   quests["shoudao"].time = os.time() - 20*60*60
	   return check_bei(shoudaoOver)
	end
    DeleteTriggerGroup("shoudaoAsk")
    create_trigger_t('shoudaoAsk1',"^(> )*你向玄苦大师打听有关『燃木手刀绝技』的消息",'','shoudaoAsk')
    create_trigger_t('shoudaoAsk2',"^(> )*这里没有这个人。$",'','shoudaoNobody')
    SetTriggerOption("shoudaoAsk1","group","shoudaoAsk")
    SetTriggerOption("shoudaoAsk2","group","shoudaoAsk")
	exe('ask xuanku dashi about 燃木手刀绝技')
end
function shoudaoAsk()
    EnableTriggerGroup("shoudaoAsk",false)
	DeleteTriggerGroup("shoudao")
	create_trigger_t('shoudao1',"^(> )*玄苦大师说道：「大轮明王佛法无边，已经大彻大悟，你去请教，我想能有一番收获。」",'','shoudaoGo')
	create_trigger_t('shoudao2','^(> )*玄苦大师说道：「你来的太频繁了，要知道佛家讲究的是顿悟！」','','shoudaoFail')
	SetTriggerOption("shoudao1","group","shoudao")
    SetTriggerOption("shoudao2","group","shoudao")
end
function shoudaoGo()
    EnableTriggerGroup("shoudao",false)
	return go(shoudaoXin,"大雪山","法堂二楼")
end
function shoudaoXin()
    if not locl.id["鸠摩智"] then
	   quests["shoudao"].time = os.time() - 20*60*60
	   return check_bei(shoudaoOver)
	end
    DeleteTriggerGroup("shoudaoAsk")
    create_trigger_t('shoudaoAsk1',"^(> )*你向鸠摩智打听有关『燃木刀法绝技』的消息。",'','shoudaoXinAsk')
    create_trigger_t('shoudaoAsk2',"^(> )*这里没有这个人。$",'','shoudaoNobody')
    SetTriggerOption("shoudaoAsk1","group","shoudaoAsk")
    SetTriggerOption("shoudaoAsk2","group","shoudaoAsk")
	questStartLog(quests["shoudao"].name)
	exe('ask jiumo zhi about 燃木刀法绝技')
	exe('alias action 燃木手刀绝技')
end
function shoudaoXinAsk()
    EnableTriggerGroup("shoudaoAsk",false)
	DeleteTriggerGroup("shoudao")
	create_trigger_t('shoudao1',"^(> )*鸠摩智说道：「我虽然已然大彻大悟，但你贼胆包天的这里骚扰，难道不想活了！」",'','shoudaoFail')
	create_trigger_t('shoudao2','^(> )*你听了鸠摩智的指点，可是对燃木刀之手刀绝技的奥妙全然不得要领。','','shoudaoContinue')
	create_trigger_t('shoudao3','^(> )*你把 "action" 设定为 "燃木手刀绝技" 成功完成。','','shoudaoSucc')
	SetTriggerOption("shoudao1","group","shoudao")
    SetTriggerOption("shoudao2","group","shoudao")
	SetTriggerOption("shoudao3","group","shoudao")
end
function shoudaoSucc()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time()
	quests["shoudao"].auto = 2
	questSucLog(quests["shoudao"].name)
	return check_bei(shoudaoOver)
end
function shoudaoContinue()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time()
	return check_bei(shoudaoOver)
end
function shoudaoFail()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time() - 12*60*60
	return check_bei(shoudaoOver)
end
function shoudaoNobody()
    EnableTriggerGroup("shoudaoAsk",false)
	quests["shoudao"].time = os.time() - 18*60*60
	return check_bei(shoudaoOver)
end
function shoudaoOver()
	SetVariable("timeshoudao",quests["shoudao"].time)
	SetVariable("autoshoudao",quests["shoudao"].auto)
	DeleteTriggerGroup("shoudaoAsk")
	DeleteTriggerGroup("shoudao")
	CloseLog()
    return check_bei(checkQuestOver)
end