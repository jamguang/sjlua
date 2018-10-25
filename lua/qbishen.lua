quests = quests or {}
quests["bishen"] = {}
quests["bishen"].auto = 0
quests["bishen"].name = "以彼之道还施彼身"

questTongji = questTongji or {}
questTongji["bishen"] = "bishenTongji"

questCal = questCal or {}
questCal["bishen"] = "bishenCal"

questList = questList or {}
questList["bishen"] = function() if score.party and score.party=="姑苏慕容" and skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl>350 then return "以彼之道还施彼身" else return false end end

function bishenCal()
    if score.party=="姑苏慕容" and GetVariable("autobishen") and skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl>350 then
      if GetVariable("timebishen") then
		 quests["bishen"].time=tonumber(GetVariable("timebishen"))
	  end
	  if GetVariable("autobishen") then
		 quests["bishen"].auto=tonumber(GetVariable("autobishen"))
	  end
	  if quests["bishen"].time==nil or os.time()-quests["bishen"].time > 24*60*60 then
	     quests["bishen"].time = os.time() - 12*60*60
		 SetVariable("timebishen",quests["bishen"].time)
	     if quests["bishen"].auto==nil or quests["bishen"].auto == 0 then
	        quests["bishen"].auto = 1
	     end
	     if quests["bishen"].auto == 1 then
		    exe('pray pearl')
		    return "questBishen"
	     end
	  else
	     if quests["bishen"].auto == 1 and quests["bishen"].time then
	        local l_time = 24*60*60 - (os.time() - quests["bishen"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("以彼之道还施彼身",l_time)
			end
	     end
	     return false
	  end
   end
end
function bishenTongji()
    if GetVariable("autobishen") and quests["bishen"] and quests["bishen"].auto == 1 and quests["bishen"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bishen"].time)
	   checkQuestNote("以彼之道还施彼身",l_time)
	end
end
function questBishen()
   return go(bishenPre,"燕子坞","院门")
end
function bishenPre()
    if not locl.id["慕容复"] then
	   quests["bishen"].time = os.time() - 20*60*60
	   return check_bei(bishenOver)
	end
    DeleteTriggerGroup("bishenAsk")
    create_trigger_t('bishenAsk1',"^(> )*你向慕容复打听有关『以彼之道还施彼身』的消息",'','bishenAsk')
    create_trigger_t('bishenAsk2',"^(> )*这里没有这个人。$",'','bishenNobody')
    SetTriggerOption("bishenAsk1","group","bishenAsk")
    SetTriggerOption("bishenAsk2","group","bishenAsk")
	questStartLog(quests["bishen"].name)
	exe('ask murong fu about 以彼之道还施彼身')
	exe('alias action 以彼之道还施彼身')
end
function bishenAsk()
    EnableTriggerGroup("bishenAsk",false)
	DeleteTriggerGroup("bishen")
	create_trigger_t('bishen1',"^(> )*慕容复说道：「你解迷时间未到,请稍后再来。」",'','bishenFail')
	create_trigger_t('bishen2','^(> )*慕容复说道：「看来你还是未到明白其中奥妙所在的时候!」','','bishenContinue')
	create_trigger_t('bishen3','^(> )*你把 "action" 设定为 "以彼之道还施彼身" 成功完成。','','bishenSucc')
	SetTriggerOption("bishen1","group","bishen")
    SetTriggerOption("bishen2","group","bishen")
	SetTriggerOption("bishen3","group","bishen")
end
function bishenSucc()
    EnableTriggerGroup("bishen",false)
	quests["bishen"].time = os.time()
	quests["bishen"].auto = 2
	questSucLog(quests["bishen"].name)
	return check_bei(bishenOver)
end
function bishenContinue()
    EnableTriggerGroup("bishen",false)
	quests["bishen"].time = os.time()
	return check_bei(bishenOver)
end
function bishenFail()
    EnableTriggerGroup("bishen",false)
	quests["bishen"].time = os.time() - 12*60*60
	return check_bei(bishenOver)
end
function bishenNobody()
    EnableTriggerGroup("bishenAsk",false)
	quests["bishen"].time = os.time() - 18*60*60
	return check_bei(bishenOver)
end
function bishenOver()
	SetVariable("timebishen",quests["bishen"].time)
	SetVariable("autobishen",quests["bishen"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end