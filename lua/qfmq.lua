quests = quests or {}
quests["fmq"] = {}
quests["fmq"].auto = 0
quests["fmq"].name = '伏魔圈绝技'

questTongji = questTongji or {}
questTongji["fmq"] = "fmqTongji"

questCal = questCal or {}
questCal["fmq"] = "fmqCal"

questList = questList or {}
questList["fmq"] = function() if score.party=="少林派" then return quests["fmq"].name else return false end end


function fmqCal()
    if GetVariable("autofmq") and score.party=="少林派" and skills["riyue-bian"] and skills["riyue-bian"].lvl>450 and score.int>34 then
      if GetVariable("timefmq") then
		 quests["fmq"].time=tonumber(GetVariable("timefmq"))
	  end
	  if GetVariable("autofmq") then
		 quests["fmq"].auto=tonumber(GetVariable("autofmq"))
	  end
	  if quests["fmq"].time==nil or os.time()-quests["fmq"].time > 24*60*60 then
	     quests["fmq"].time = os.time() - 22*60*60
		 SetVariable("timefmq",quests["fmq"].time)
	     if quests["fmq"].auto==nil or quests["fmq"].auto == 0 then
	        quests["fmq"].auto = 1
	     end
	     if quests["fmq"].auto == 1 then
		    exe('pray pearl')
		    return "questfmq"
	     end
	  else
	     if quests["fmq"].auto == 1 and quests["fmq"].time then
	        local l_time = 24*60*60 - (os.time() - quests["fmq"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["fmq"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function fmqTongji()
    if GetVariable("autofmq") and quests["fmq"] and quests["fmq"].auto == 1 and quests["fmq"].time then
	   local l_time = 24*60*60 - (os.time() - quests["fmq"].time)
	   checkQuestNote(quests["fmq"].name,l_time)
	end
end

function questfmq()
    return go(fmqPre,"shaolin/fumoquan")
end
function fmqPre()
    if not locl.id["渡厄"] then
	   quests["fmq"].time = os.time() - 23*60*60
	   return check_bei(fmqNobody)
	end
	EnableTriggerGroup("fmqAsk",false)
    DeleteTriggerGroup("fmqAsk")
    create_trigger_t('fmqAsk1',"^(> )*你向渡厄打听有关『伏魔圈绝技』的消息",'','fmqAsk')
    create_trigger_t('fmqAsk2',"^(> )*这里没有这个人。$",'','fmqNobody')
    SetTriggerOption("fmqAsk1","group","fmqAsk")
    SetTriggerOption("fmqAsk2","group","fmqAsk")
    questStartLog(quests["fmq"].name)
	return exe('askk du e about 伏魔圈绝技')
end
function fmqAsk()
    EnableTriggerGroup("fmqAsk",false)
	DeleteTriggerGroup("fmq")
	create_trigger_t('fmq1',"^(> )*渡厄(对你|)说道：(「|)你来的太频繁了，明天再来试试!",'','fmqFail')
	create_trigger_t('fmq2',"^(> )*渡厄对你失望极了",'','fmqContinue')
	create_trigger_t('fmq3',"^(> )*你按照渡厄的指点，对日月鞭法的真正奥妙似乎有些心得。",'','fmqSucc')
	SetTriggerOption("fmq1","group","fmq")
    SetTriggerOption("fmq2","group","fmq")
	SetTriggerOption("fmq3","group","fmq")
end
function fmqDel()
    EnableTriggerGroup("fmq",false)
	quests["fmq"].time = 0
	quests["fmq"].auto = 0
	DeleteVariable("timefmq")
	DeleteVariable("autofmq")
	CloseLog()
	return check_bei(checkQuestOver)
end
function fmqSucc()
    EnableTriggerGroup("fmq",false)
	quests["fmq"].time = os.time()
	quests["fmq"].auto = 2
	questSucLog(quests["fmq"].name)
	return check_bei(fmqOver)
end
function fmqContinue()
    EnableTriggerGroup("fmq",false)
	quests["fmq"].time = os.time()
	return check_bei(fmqOver)
end
function fmqFail()
    EnableTriggerGroup("fmq",false)
	quests["fmq"].time = os.time() - 16*60*60
	return check_bei(fmqOver)
end
function fmqNobody()
    EnableTriggerGroup("fmqAsk",false)
	quests["fmq"].time = os.time() - 23*60*60
	return check_bei(fmqOver)
end
function fmqOver()
    DeleteTriggerGroup("fmq")
	DeleteTriggerGroup("fmqAsk")
    CloseLog()
	SetVariable("timefmq",quests["fmq"].time)
	SetVariable("autofmq",quests["fmq"].auto)
    return check_bei(checkQuestOver)
end