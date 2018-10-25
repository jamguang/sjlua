quests = quests or {}
quests["lingxi"] = {}
quests["lingxi"].auto = 0
quests["lingxi"].name = "灵犀一指"

questTongji = questTongji or {}
questTongji["lingxi"] = "lingxiTongji"

questCal = questCal or {}
questCal["lingxi"] = "lingxiCal"

questList = questList or {}
questList["fuxue"] = function() if score.party and score.party=="桃花岛" and skills["tanzhi-shentong"] then return "灵犀一指" else return false end end


function lingxiCal()
    if score.party=="桃花岛" and GetVariable("autolingxi") and skills["tanzhi-shentong"] then
      if GetVariable("timelingxi") then
		 quests["lingxi"].time=tonumber(GetVariable("timelingxi"))
	  end
	  if GetVariable("autolingxi") then
		 quests["lingxi"].auto=tonumber(GetVariable("autolingxi"))
	  end
	  if quests["lingxi"].time==nil or os.time()-quests["lingxi"].time > 24*60*60 then
	     quests["lingxi"].time = os.time() - 12*60*60
		 SetVariable("timelingxi",quests["lingxi"].time)
	     if quests["lingxi"].auto==nil or quests["lingxi"].auto == 0 then
	        quests["lingxi"].auto = 1
	     end
	     if quests["lingxi"].auto == 1 then
		    exe('pray pearl')
		    return "questLingxi"
	     end
	  else
	     if quests["lingxi"].auto == 1 and quests["lingxi"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lingxi"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("灵犀一指",l_time)
			end
	     end
	     return false
	  end
   end
end
function lingxiTongji()
    if GetVariable("autolingxi") and quests["lingxi"] and quests["lingxi"].auto == 1 and quests["lingxi"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lingxi"].time)
	   checkQuestNote("灵犀一指",l_time)
	end
end
function questLingxi()
   return go(lingxiPre,"桃花岛","积翠亭")
end
function lingxiPre()
    if not locl.id["黄药师"] then
	   quests["lingxi"].time = os.time() - 20*60*60
	   return check_bei(lingxiOver)
	end
    DeleteTriggerGroup("lingxiAsk")
    create_trigger_t('lingxiAsk1',"^(> )*你向黄药师打听有关『灵犀一指』的消息",'','lingxiAsk')
    create_trigger_t('lingxiAsk2',"^(> )*这里没有这个人。$",'','lingxiNobody')
    SetTriggerOption("lingxiAsk1","group","lingxiAsk")
    SetTriggerOption("lingxiAsk2","group","lingxiAsk")
	questStartLog(quests["lingxi"].name)
	exe('ask huang yaoshi about 灵犀一指')
	exe('alias action 灵犀一指')
end
function lingxiAsk()
    EnableTriggerGroup("lingxiAsk",false)
	DeleteTriggerGroup("lingxi")
	create_trigger_t('lingxi1',"^(> )*黄药师说道：「\\D*还是去休息一下吧。」",'','lingxiFail')
	create_trigger_t('lingxi2','^(> )*黄药师说道：「要使用”灵犀一指“这样的绝招一定的毅力，你还是下次再说吧。」','','lingxiContinue')
	create_trigger_t('lingxi3','^(> )*你把 "action" 设定为 "灵犀一指" 成功完成。','','lingxiSucc')
	SetTriggerOption("lingxi1","group","lingxi")
    SetTriggerOption("lingxi2","group","lingxi")
	SetTriggerOption("lingxi3","group","lingxi")
end
function lingxiSucc()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time()
	quests["lingxi"].auto = 2
	questSucLog(quests["lingxi"].name)
	return check_bei(lingxiOver)
end
function lingxiContinue()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time()
	return check_bei(lingxiOver)
end
function lingxiFail()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time() - 12*60*60
	return check_bei(lingxiOver)
end
function lingxiNobody()
    EnableTriggerGroup("lingxiAsk",false)
	quests["lingxi"].time = os.time() - 18*60*60
	return check_bei(lingxiOver)
end
function lingxiOver()
	SetVariable("timelingxi",quests["lingxi"].time)
	SetVariable("autolingxi",quests["lingxi"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end