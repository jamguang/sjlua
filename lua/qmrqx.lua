quests = quests or {}
quests["mrqx"] = {}
quests["mrqx"].auto = 0
quests["mrqx"].name = '剑转七星'

questTongji = questTongji or {}
questTongji["mrqx"] = "mrqxTongji"

questCal = questCal or {}
questCal["mrqx"] = "mrqxCal"

questList = questList or {}
questList["mrqx"] = function() if score.party and score.party=="姑苏慕容" and skills["murong-jianfa"] and skills["murong-jianfa"].lvl>350 then return quests["mrqx"].name else return false end end

function mrqxCal()
    if score.party=="姑苏慕容" and GetVariable("automrqx") and skills["murong-jianfa"] and skills["murong-jianfa"].lvl>350 then
      if GetVariable("timemrqx") then
		 quests["mrqx"].time=tonumber(GetVariable("timemrqx"))
	  end
	  if GetVariable("automrqx") then
		 quests["mrqx"].auto=tonumber(GetVariable("automrqx"))
	  end
	  if quests["mrqx"].time==nil or os.time()-quests["mrqx"].time > 24*60*60 then
	     quests["mrqx"].time = os.time() - 12*60*60
		 SetVariable("timemrqx",quests["mrqx"].time)
	     if quests["mrqx"].auto==nil or quests["mrqx"].auto == 0 then
	        quests["mrqx"].auto = 1
	     end
	     if quests["mrqx"].auto == 1 then
		    exe('pray pearl')
		    return "questMrqx"
	     end
	  else
	     if quests["mrqx"].auto == 1 and quests["mrqx"].time then
	        local l_time = 24*60*60 - (os.time() - quests["mrqx"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["mrqx"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function mrqxTongji()
    if GetVariable("automrqx") and quests["mrqx"] and quests["mrqx"].auto == 1 and quests["mrqx"].time then
	   local l_time = 24*60*60 - (os.time() - quests["mrqx"].time)
	   checkQuestNote(quests["mrqx"].name,l_time)
	end
end
function questMrqx()
   return go(mrqxPre,"燕子坞","院门")
end
function mrqxPre()
    if not locl.id["慕容复"] then
	   quests["mrqx"].time = os.time() - 23*60*60
	   return check_bei(mrqxOver)
	end
    DeleteTriggerGroup("mrqxAsk")
    create_trigger_t('mrqxAsk1',"^(> )*你向慕容复打听有关『剑转七星』的消息",'','mrqxAsk')
    create_trigger_t('mrqxAsk2',"^(> )*这里没有这个人。$",'','mrqxNobody')
    SetTriggerOption("mrqxAsk1","group","mrqxAsk")
    SetTriggerOption("mrqxAsk2","group","mrqxAsk")
	questStartLog(quests["mrqx"].name)
	exe('ask murong fu about 剑转七星')
	exe('alias action 剑转七星')
end
function mrqxAsk()
    EnableTriggerGroup("mrqxAsk",false)
	DeleteTriggerGroup("mrqx")
	create_trigger_t('mrqx1',"^(> )*慕容复说道：「你解迷时间未到,请稍后再来。」",'','mrqxFail')
	create_trigger_t('mrqx2','^(> )*慕容复说道：「看来你还是未到明白其中奥妙所在的时候!」','','mrqxContinue')
	create_trigger_t('mrqx3','^(> )*你把 "action" 设定为 "剑转七星" 成功完成。','','mrqxSucc')
	SetTriggerOption("mrqx1","group","mrqx")
    SetTriggerOption("mrqx2","group","mrqx")
	SetTriggerOption("mrqx3","group","mrqx")
end
function mrqxSucc()
    EnableTriggerGroup("mrqx",false)
	quests["mrqx"].time = os.time()
	quests["mrqx"].auto = 2
	questSucLog(quests["mrqx"].name)
	return check_bei(mrqxOver)
end
function mrqxContinue()
    EnableTriggerGroup("mrqx",false)
	quests["mrqx"].time = os.time()
	return check_bei(mrqxOver)
end
function mrqxFail()
    EnableTriggerGroup("mrqx",false)
	quests["mrqx"].time = os.time() - 12*60*60
	return check_bei(mrqxOver)
end
function mrqxNobody()
    EnableTriggerGroup("mrqxAsk",false)
	quests["mrqx"].time = os.time() - 18*60*60
	return check_bei(mrqxOver)
end
function mrqxOver()
	SetVariable("timemrqx",quests["mrqx"].time)
	SetVariable("automrqx",quests["mrqx"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end