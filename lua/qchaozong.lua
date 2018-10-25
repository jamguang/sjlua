quests = quests or {}
quests["chaozong"] = {}
quests["chaozong"].auto = 0
quests["chaozong"].name = '万岳朝宗'

questTongji = questTongji or {}
questTongji["chaozong"] = "chaozongTongji"

questCal = questCal or {}
questCal["chaozong"] = "chaozongCal"

questList = questList or {}
questList["chaozong"] = function() if score.party and score.party=="嵩山派" and skills["songshan-jian"] and skills["songshan-jian"].lvl>350 then return quests["chaozong"].name else return false end end


function chaozongCal()
    if score.party=="嵩山派" and GetVariable("autochaozong") and skills["songshan-jian"] and skills["songshan-jian"].lvl>350 then
      if GetVariable("timechaozong") then
		 quests["chaozong"].time=tonumber(GetVariable("timechaozong"))
	  end
	  if GetVariable("autochaozong") then
		 quests["chaozong"].auto=tonumber(GetVariable("autochaozong"))
	  end
	  if quests["chaozong"].time==nil or os.time()-quests["chaozong"].time > 24*60*60 then
	     quests["chaozong"].time = os.time() - 12*60*60
		 SetVariable("timechaozong",quests["chaozong"].time)
	     if quests["chaozong"].auto==nil or quests["chaozong"].auto == 0 then
	        quests["chaozong"].auto = 1
	     end
	     if quests["chaozong"].auto == 1 then
		    exe('pray pearl')
		    return "questChaozong"
	     end
	  else
	     if quests["chaozong"].auto == 1 and quests["chaozong"].time then
	        local l_time = 24*60*60 - (os.time() - quests["chaozong"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["chaozong"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function chaozongTongji()
    if GetVariable("autochaozong") and quests["chaozong"] and quests["chaozong"].auto == 1 and quests["chaozong"].time then
	   local l_time = 24*60*60 - (os.time() - quests["chaozong"].time)
	   checkQuestNote(quests["chaozong"].name,l_time)
	end
end
function questChaozong()
   return go(chaozongPre,"嵩山","封禅台")
end
function chaozongPre()
    if not locl.id["左冷禅"] then
	   quests["chaozong"].time = os.time() - 23*60*60
	   return check_bei(chaozongOver)
	end
    DeleteTriggerGroup("chaozongAsk")
    create_trigger_t('chaozongAsk1',"^(> )*你向左冷禅打听有关『万岳朝宗』的消息",'','chaozongAsk')
    create_trigger_t('chaozongAsk2',"^(> )*这里没有这个人。$",'','chaozongNobody')
    SetTriggerOption("chaozongAsk1","group","chaozongAsk")
    SetTriggerOption("chaozongAsk2","group","chaozongAsk")
	questStartLog(quests["chaozong"].name)
	exe('ask zuo lengchan about 万岳朝宗')
end
function chaozongAsk()
    EnableTriggerGroup("chaozongAsk",false)
	DeleteTriggerGroup("chaozong")
	create_trigger_t('chaozong1',"^(> )*左冷禅说道：「你也太勤快点了耶？？」",'','chaozongFail')
	create_trigger_t('chaozong2','^(> )*参悟万岳朝宗绝技解密失败！','','chaozongContinue')
	create_trigger_t('chaozong3','^(> )*左冷禅说道：「你已经开了这个谜题','','chaozongSucc')
	SetTriggerOption("chaozong1","group","chaozong")
    SetTriggerOption("chaozong2","group","chaozong")
	SetTriggerOption("chaozong3","group","chaozong")
end
function chaozongSucc()
    EnableTriggerGroup("chaozong",false)
	quests["chaozong"].time = os.time()
	quests["chaozong"].auto = 2
	questSucLog(quests["chaozong"].name)
	return check_bei(chaozongOver)
end
function chaozongContinue()
    EnableTriggerGroup("chaozong",false)
	quests["chaozong"].time = os.time()
	return check_bei(chaozongOver)
end
function chaozongFail()
    EnableTriggerGroup("chaozong",false)
	quests["chaozong"].time = os.time() - 12*60*60
	return check_bei(chaozongOver)
end
function chaozongNobody()
    EnableTriggerGroup("chaozongAsk",false)
	EnableTriggerGroup("chaozongJue",false)
	quests["chaozong"].time = os.time() - 18*60*60
	return check_bei(chaozongOver)
end
function chaozongOver()
	SetVariable("timechaozong",quests["chaozong"].time)
	SetVariable("autochaozong",quests["chaozong"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end