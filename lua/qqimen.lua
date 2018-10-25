quests = quests or {}
quests["qimen"] = {}
quests["qimen"].auto = 0
quests["qimen"].name = '碧海潮生按玉箫'

questTongji = questTongji or {}
questTongji["qimen"] = "qimenTongji"

questCal = questCal or {}
questCal["qimen"] = "qimenCal"

questList = questList or {}
questList["qimen"] = function() if score.party and score.party=="桃花岛" and skills["yuxiao-jian"] and skills["yuxiao-jian"].lvl>200 then return quests["qimen"].name else return false end end


function qimenCal()
    if score.party=="桃花岛" and GetVariable("autoqimen") and skills["yuxiao-jian"] and skills["yuxiao-jian"].lvl>200 then
      if GetVariable("timeqimen") then
		 quests["qimen"].time=tonumber(GetVariable("timeqimen"))
	  end
	  if GetVariable("autoqimen") then
		 quests["qimen"].auto=tonumber(GetVariable("autoqimen"))
	  end
	  if quests["qimen"].time==nil or os.time()-quests["qimen"].time > 24*60*60 then
	     quests["qimen"].time = os.time() - 12*60*60
		 SetVariable("timeqimen",quests["qimen"].time)
	     if quests["qimen"].auto==nil or quests["qimen"].auto == 0 then
	        quests["qimen"].auto = 1
	     end
	     if quests["qimen"].auto == 1 then
		    exe('pray pearl')
		    return "questQimen"
	     end
	  else
	     if quests["qimen"].auto == 1 and quests["qimen"].time then
	        local l_time = 24*60*60 - (os.time() - quests["qimen"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["qimen"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function qimenTongji()
    if GetVariable("autoqimen") and quests["qimen"] and quests["qimen"].auto == 1 and quests["qimen"].time then
	   local l_time = 24*60*60 - (os.time() - quests["qimen"].time)
	   checkQuestNote(quests["qimen"].name,l_time)
	end
end
function questQimen()
   return go(qimenPre,"桃花岛","积翠亭")
end
function qimenPre()
    if not locl.id["黄药师"] then
	   quests["qimen"].time = os.time() - 20*60*60
	   return check_bei(qimenOver)
	end
    DeleteTriggerGroup("qimenAsk")
    create_trigger_t('qimenAsk1',"^(> )*你向黄药师打听有关『碧海潮生按玉箫』的消息",'','qimenAsk')
    create_trigger_t('qimenAsk2',"^(> )*这里没有这个人。$",'','qimenNobody')
    SetTriggerOption("qimenAsk1","group","qimenAsk")
    SetTriggerOption("qimenAsk2","group","qimenAsk")
	questStartLog(quests["qimen"].name)
	exe('ask huang yaoshi about 碧海潮生按玉箫')
	exe('alias action 碧海潮生按玉箫')
end
function qimenAsk()
    EnableTriggerGroup("qimenAsk",false)
	DeleteTriggerGroup("qimen")
	create_trigger_t('qimen1',"^(> )*黄药师说道：「\\D*还是去休息一下吧。」",'','qimenFail')
	create_trigger_t('qimen2','^(> )*黄药师说道：「要使用”碧海潮生按玉箫“这样的绝招一定的毅力，你还是下次再说吧。」','','qimenContinue')
	create_trigger_t('qimen3','^(> )*你把 "action" 设定为 "碧海潮生按玉箫" 成功完成。','','qimenSucc')
	create_trigger_t('qimen4','^(> )*黄药师细心地向你讲解这一招，你终于学会了。','','qimenSucc')
	SetTriggerOption("qimen1","group","qimen")
    SetTriggerOption("qimen2","group","qimen")
	SetTriggerOption("qimen3","group","qimen")
	SetTriggerOption("qimen4","group","qimen")
end
function qimenSucc()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time()
	quests["qimen"].auto = 2
	questSucLog(quests["qimen"].name)
	return check_bei(qimenOver)
end
function qimenContinue()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time()
	return check_bei(qimenOver)
end
function qimenFail()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time() - 12*60*60
	return check_bei(qimenOver)
end
function qimenNobody()
    EnableTriggerGroup("qimenAsk",false)
	quests["qimen"].time = os.time() - 18*60*60
	return check_bei(qimenOver)
end
function qimenOver()
	SetVariable("timeqimen",quests["qimen"].time)
	SetVariable("autoqimen",quests["qimen"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end