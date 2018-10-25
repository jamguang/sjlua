quests = quests or {}
quests["ynj"] = {}
quests["ynj"].auto = 0
quests["ynj"].name = '越女剑'

questTongji = questTongji or {}
questTongji["ynj"] = "ynjTongji"

questCal = questCal or {}
questCal["ynj"] = "ynjCal"

questList = questList or {}
questList["ynj"] = function() if score.gender and score.gender == "女" and score.int and score.int > 32 and not skills["yuenu-jian"] then return quests["ynj"].name else return false end end


function ynjCal()
    if GetVariable("autoynj") and score.gender and score.gender == "女" and score.int and score.int > 32 and not skills["yuenu-jian"] then
      if GetVariable("timeynj") then
		 quests["ynj"].time=tonumber(GetVariable("timeynj"))
	  end
	  if GetVariable("autoynj") then
		 quests["ynj"].auto=tonumber(GetVariable("autoynj"))
	  end
	  if quests["ynj"].time==nil or os.time()-quests["ynj"].time > 24*60*60 then
	     quests["ynj"].time = os.time() - 22*60*60
		 SetVariable("timeynj",quests["ynj"].time)
	     if quests["ynj"].auto==nil or quests["ynj"].auto == 0 then
	        quests["ynj"].auto = 1
	     end
	     if quests["ynj"].auto == 1 then
		    exe('pray pearl')
		    return "questynj"
	     end
	  else
	     if quests["ynj"].auto == 1 and quests["ynj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["ynj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["ynj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function ynjTongji()
    if GetVariable("autoynj") and quests["ynj"] and quests["ynj"].auto == 1 and quests["ynj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["ynj"].time)
	   checkQuestNote(quests["ynj"].name,l_time)
	end
end

function questynj()
   return go(ynjPre,"苏州城","南林")
end
function ynjPre()
    if not locl.id["阿青"] then
	   quests["ynj"].time = os.time() - 22*60*60
	   return check_bei(ynjOver)
	end
    DeleteTriggerGroup("ynjAsk")
    create_trigger_t('ynjAsk1',"^(> )*你向阿青打听有关『越女剑』的消息。",'','ynjAsk')
    create_trigger_t('ynjAsk2',"^(> )*这里没有这个人。$",'','ynjNobody')
    SetTriggerOption("ynjAsk1","group","ynjAsk")
    SetTriggerOption("ynjAsk2","group","ynjAsk")
	questStartLog(quests["ynj"].name)
	exe('askk aqing about 越女剑')
	exe('alias action 越女剑')
end
function ynjAsk()
    EnableTriggerGroup("ynjAsk",false)
	DeleteTriggerGroup("ynj")
	create_trigger_t('ynj1',"^(> )*阿青说道：「你还是去休息一下吧，没事别来烦我！」",'','ynjFail')
	create_trigger_t('ynj2','^(> )*很可惜，你本次尝试越女剑秘密失败！','','ynjContinue')
	create_trigger_t('ynj3','^(> )*你把 "action" 设定为 "越女剑" 成功完成。','','ynjSucc')
	SetTriggerOption("ynj1","group","ynj")
    SetTriggerOption("ynj2","group","ynj")
	SetTriggerOption("ynj3","group","ynj")
end
function ynjSucc()
    EnableTriggerGroup("ynj",false)
	quests["ynj"].time = os.time()
	quests["ynj"].auto = 2
	questSucLog(quests["ynj"].name)
	return check_bei(ynjOver)
end
function ynjContinue()
    EnableTriggerGroup("ynj",false)
	quests["ynj"].time = os.time()
	return check_bei(ynjOver)
end
function ynjFail()
    EnableTriggerGroup("ynj",false)
	quests["ynj"].time = os.time() - 12*60*60
	return check_bei(ynjOver)
end
function ynjNobody()
    EnableTriggerGroup("ynjAsk",false)
	quests["ynj"].time = os.time() - 18*60*60
	return check_bei(ynjOver)
end
function ynjOver()
	SetVariable("timeynj",quests["ynj"].time)
	SetVariable("autoynj",quests["ynj"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end