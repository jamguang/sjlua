quests = quests or {}
quests["luoying"] = {}
quests["luoying"].auto = 0
quests["luoying"].name = "落英掌飞跃"

questTongji = questTongji or {}
questTongji["luoying"] = "luoyingTongji"

questCal = questCal or {}
questCal["luoying"] = "luoyingCal"

questList = questList or {}
questList["luoying"] = function() if score.party and score.party=="桃花岛" and skills["luoying-zhang"] then return "落英掌飞跃" else return false end end


function luoyingCal()
    if score.party=="桃花岛" and GetVariable("autoluoying") and skills["luoying-zhang"] then
      if GetVariable("timeluoying") then
		 quests["luoying"].time=tonumber(GetVariable("timeluoying"))
	  end
	  if GetVariable("autoluoying") then
		 quests["luoying"].auto=tonumber(GetVariable("autoluoying"))
	  end
	  if quests["luoying"].time==nil or os.time()-quests["luoying"].time > 24*60*60 then
	     quests["luoying"].time = os.time() - 12*60*60
		 SetVariable("timeluoying",quests["luoying"].time)
	     if quests["luoying"].auto==nil or quests["luoying"].auto == 0 then
	        quests["luoying"].auto = 1
	     end
	     if quests["luoying"].auto == 1 then
		    exe('pray pearl')
		    return "questLuoying"
	     end
	  else
	     if quests["luoying"].auto == 1 and quests["luoying"].time then
	        local l_time = 24*60*60 - (os.time() - quests["luoying"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("落英掌飞跃",l_time)
			end
	     end
	     return false
	  end
   end
end
function luoyingTongji()
    if GetVariable("autoluoying") and quests["luoying"] and quests["luoying"].auto == 1 and quests["luoying"].time then
	   local l_time = 24*60*60 - (os.time() - quests["luoying"].time)
	   checkQuestNote("落英掌飞跃",l_time)
	end
end
function questLuoying()
   return go(luoyingPre,"桃花岛","积翠亭")
end
function luoyingPre()
    if not locl.id["黄药师"] then
	   quests["luoying"].time = os.time() - 20*60*60
	   return check_bei(luoyingOver)
	end
    DeleteTriggerGroup("luoyingAsk")
    create_trigger_t('luoyingAsk1',"^(> )*你向黄药师打听有关『桃花影落飞神剑』的消息",'','luoyingAsk')
    create_trigger_t('luoyingAsk2',"^(> )*这里没有这个人。$",'','luoyingNobody')
    SetTriggerOption("luoyingAsk1","group","luoyingAsk")
    SetTriggerOption("luoyingAsk2","group","luoyingAsk")
	questStartLog(quests["luoying"].name)
	exe('ask huang yaoshi about 桃花影落飞神剑')
	exe('alias action 桃花影落飞神剑')
end
function luoyingAsk()
    EnableTriggerGroup("luoyingAsk",false)
	DeleteTriggerGroup("luoying")
	create_trigger_t('luoying1',"^(> )*黄药师说道：「\\D*还是去休息一下吧。」",'','luoyingFail')
	create_trigger_t('luoying2','^(> )*黄药师说道：「要使用”桃花影落飞神剑“这样的绝招一定的毅力，你还是下次再说吧。」','','luoyingContinue')
	create_trigger_t('luoying3','^(> )*你把 "action" 设定为 "桃花影落飞神剑" 成功完成。','','luoyingSucc')
	create_trigger_t('luoying4','^(> )*黄药师细心地向你讲解这一招，你终于学会了。','','luoyingSucc')
	SetTriggerOption("luoying1","group","luoying")
    SetTriggerOption("luoying2","group","luoying")
	SetTriggerOption("luoying3","group","luoying")
	SetTriggerOption("luoying4","group","luoying")
end
function luoyingSucc()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time()
	quests["luoying"].auto = 2
	questSucLog(quests["luoying"].name)
	return check_bei(luoyingOver)
end
function luoyingContinue()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time()
	return check_bei(luoyingOver)
end
function luoyingFail()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time() - 12*60*60
	return check_bei(luoyingOver)
end
function luoyingNobody()
    EnableTriggerGroup("luoyingAsk",false)
	quests["luoying"].time = os.time() - 18*60*60
	return check_bei(luoyingOver)
end
function luoyingOver()
	SetVariable("timeluoying",quests["luoying"].time)
	SetVariable("autoluoying",quests["luoying"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end