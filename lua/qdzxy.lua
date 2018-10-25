quests = quests or {}
quests["dzxy"] = {}
quests["dzxy"].auto = 0
quests["dzxy"].name = '斗转星移绝学'

questTongji = questTongji or {}
questTongji["dzxy"] = "dzxyTongji"

questCal = questCal or {}
questCal["dzxy"] = "dzxyCal"

questList = questList or {}
questList["dzxy"] = function() if score.party=="姑苏慕容" then return quests["dzxy"].name else return false end end


function dzxyCal()
    if GetVariable("autodzxy") and score.party=="姑苏慕容" and skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl>499 then
      if GetVariable("timedzxy") then
		 quests["dzxy"].time=tonumber(GetVariable("timedzxy"))
	  end
	  if GetVariable("autodzxy") then
		 quests["dzxy"].auto=tonumber(GetVariable("autodzxy"))
	  end
	  if quests["dzxy"].time==nil or os.time()-quests["dzxy"].time > 24*60*60 then
	     quests["dzxy"].time = os.time() - 22*60*60
		 SetVariable("timedzxy",quests["dzxy"].time)
	     if quests["dzxy"].auto==nil or quests["dzxy"].auto == 0 then
	        quests["dzxy"].auto = 1
	     end
	     if quests["dzxy"].auto == 1 then
		    exe('pray pearl')
		    return "questdzxy"
	     end
	  else
	     if quests["dzxy"].auto == 1 and quests["dzxy"].time then
	        local l_time = 24*60*60 - (os.time() - quests["dzxy"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["dzxy"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function dzxyTongji()
    if GetVariable("autodzxy") and quests["dzxy"] and quests["dzxy"].auto == 1 and quests["dzxy"].time then
	   local l_time = 24*60*60 - (os.time() - quests["dzxy"].time)
	   checkQuestNote(quests["dzxy"].name,l_time)
	end
end

function questdzxy()
   return go(dzxyPre,"shaolin/houyuan")
end
function dzxyPre()
    if not locl.id["慕容博"] then
	   quests["dzxy"].time = os.time() - 23*60*60
	   return check_bei(dzxyOver)
	end
    DeleteTriggerGroup("dzxyAsk")
    create_trigger_t('dzxyAsk1',"^(> )*你向慕容博打听有关『斗转星移绝学』的消息",'','dzxyAsk')
    create_trigger_t('dzxyAsk2',"^(> )*这里没有这个人。$",'','dzxyNobody')
    SetTriggerOption("dzxyAsk1","group","dzxyAsk")
    SetTriggerOption("dzxyAsk2","group","dzxyAsk")

    questStartLog(quests["dzxy"].name)
	return exe('ask murong bo about 斗转星移绝学')
	
end
function dzxyAsk()
    EnableTriggerGroup("dzxyAsk",false)
	DeleteTriggerGroup("dzxy")
	create_trigger_t('dzxy1',"^(> )*慕容博说道：「你解迷时间未到,请稍后再来。」",'','dzxyFail')
	create_trigger_t('dzxy2','^(> )*慕容博说道：「看来你还是未到明白这斗转星移的奥妙所在的时候,明天再来吧!」','','dzxyContinue')
	create_trigger_t('dzxy3',"^(> )*慕容博说道：「好吧,我就将姑苏慕容斗转星移的终极奥妙告诉你吧",'','dzxySucc')
	create_trigger_t('dzxy4',"^(> )*慕容博说道：「你不是已经明白其中的奥妙了吗？",'','dzxySucc')
	SetTriggerOption("dzxy1","group","dzxy")
    SetTriggerOption("dzxy2","group","dzxy")
	SetTriggerOption("dzxy3","group","dzxy")
	SetTriggerOption("dzxy4","group","dzxy")
end
function dzxySucc()
    EnableTriggerGroup("dzxy",false)
	quests["dzxy"].time = os.time()
	quests["dzxy"].auto = 2
	questSucLog(quests["dzxy"].name)
	return check_bei(dzxyOver)
end
function dzxyDel()
    EnableTriggerGroup("dzxy",false)
	quests["dzxy"].time = 0
	quests["dzxy"].auto = 0
	DeleteVariable("timedzxy")
	DeleteVariable("autodzxy")
	CloseLog()
	return check_bei(checkQuestOver)
end
function dzxyContinue()
    EnableTriggerGroup("dzxy",false)
	quests["dzxy"].time = os.time()
	return check_bei(dzxyOver)
end
function dzxyFail()
    EnableTriggerGroup("dzxy",false)
	quests["dzxy"].time = os.time() - 20*60*60
	return check_bei(dzxyOver)
end
function dzxyNobody()
    EnableTriggerGroup("dzxyAsk",false)
	quests["dzxy"].time = os.time() - 23*60*60
	return check_bei(dzxyOver)
end
function dzxyOver()
    DeleteTriggerGroup("dzxy")
	DeleteTriggerGroup("dzxyAsk")
	SetVariable("timedzxy",quests["dzxy"].time)
	SetVariable("autodzxy",quests["dzxy"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end