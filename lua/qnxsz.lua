quests = quests or {}
quests["nxsz"] = {}
quests["nxsz"].auto = 0
quests["nxsz"].name = '凝血神爪'

questTongji = questTongji or {}
questTongji["nxsz"] = "nxszTongji"

questCal = questCal or {}
questCal["nxsz"] = "nxszCal"

questList = questList or {}
questList["nxsz"] = function() if jobtimes and jobtimes["天地会"] and type(jobtimes["天地会"])=="number" and jobtimes["天地会"]>1049 then return quests["nxsz"].name else return false end end


function nxszCal()
    if GetVariable("autonxsz") and score.dex > 14 and score.con > 14 and jobtimes and jobtimes["天地会"] and type(jobtimes["天地会"])=="number" and jobtimes["天地会"]>1049 then
      if GetVariable("timenxsz") then
		 quests["nxsz"].time=tonumber(GetVariable("timenxsz"))
	  end
	  if GetVariable("autonxsz") then
		 quests["nxsz"].auto=tonumber(GetVariable("autonxsz"))
	  end
	  if quests["nxsz"].time==nil or os.time()-quests["nxsz"].time > 24*60*60 then
	     quests["nxsz"].time = os.time() - 22*60*60
		 SetVariable("timenxsz",quests["nxsz"].time)
	     if quests["nxsz"].auto==nil or quests["nxsz"].auto == 0 then
	        quests["nxsz"].auto = 1
	     end
	     if quests["nxsz"].auto == 1 then
		    exe('pray pearl')
		    return "questnxsz"
	     end
	  else
	     if quests["nxsz"].auto == 1 and quests["nxsz"].time then
	        local l_time = 24*60*60 - (os.time() - quests["nxsz"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["nxsz"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function nxszTongji()
    if GetVariable("autonxsz") and quests["nxsz"] and quests["nxsz"].auto == 1 and quests["nxsz"].time then
	   local l_time = 24*60*60 - (os.time() - quests["nxsz"].time)
	   checkQuestNote(quests["nxsz"].name,l_time)
	end
end

function questnxsz()
    DeleteTriggerGroup("nxszFind")
    create_trigger_t('nxszFind1','^(> )*\\D*陈近南\\(Chen jinnan\\)','','nxszFollow')
    create_trigger_t('nxszFind2','^(> )*这里没有 chen jinnan','','nxszGoon')
    create_trigger_t('nxszFind3','^(> )*你决定跟随\\D*一起行动。','','nxszPre')
    create_trigger_t('nxszFind4','^(> )*你已经这样做了。','','nxszPre')
    SetTriggerOption("nxszFind1","group","nxszFind")
    SetTriggerOption("nxszFind2","group","nxszFind")
    SetTriggerOption("nxszFind3","group","nxszFind")
    SetTriggerOption("nxszFind4","group","nxszFind")
    EnableTriggerGroup("nxszFind",false)
	return go(nxszFind,"福州城","废园")
end
function nxszFind()
    EnableTriggerGroup("nxszFind",true)
	exe('look')
	return find()
end
function nxszFollow()
    flag.find = 1
	exe('follow chen jinnan')
end
function nxszGoon()
    flag.wait=0
    flag.find=0
    return walk_wait()
end
function nxszPre()
    EnableTriggerGroup("nxszFind",false)
    DeleteTriggerGroup("nxszAsk")
    create_trigger_t('nxszAsk1',"^(> )*你向陈近南打听有关『凝血神爪』的消息",'','nxszAsk')
    create_trigger_t('nxszAsk2',"^(> )*这里没有这个人。$",'','nxszNobody')
    SetTriggerOption("nxszAsk1","group","nxszAsk")
    SetTriggerOption("nxszAsk2","group","nxszAsk")
	questStartLog(quests["nxsz"].name)
	return exe('ask chen jinnan about 凝血神爪')
end
function nxszAsk()
    EnableTriggerGroup("nxszAsk",false)
	DeleteTriggerGroup("nxsz")
	create_trigger_t('nxsz1',"^(> )*陈近南(对你|)说道：(「|)我不是和你说了，你暂时无法学会凝血神爪么？",'','nxszFail')
	create_trigger_t('nxsz2','^(> )*陈近南(对你|)说道：(「|)这位\\D*看来还需要努力一番才行','','nxszContinue')
	create_trigger_t('nxsz3',"^(> )*陈近南(对你|)说道：(「|)嗯，不错，你资质不错是块学武的料",'','nxszSucc')
	create_trigger_t('nxsz4',"^(> )*陈近南(对你|)说道：(「|)凝血神爪？你从那里听说的？",'','nxszDel')
	create_trigger_t('nxsz5',"^(> )*陈近南(对你|)说道：(「|)在下是出来游山玩水的，不回答问题。",'','nxszAskk')
	SetTriggerOption("nxsz1","group","nxsz")
    SetTriggerOption("nxsz2","group","nxsz")
	SetTriggerOption("nxsz3","group","nxsz")
	SetTriggerOption("nxsz4","group","nxsz")
	SetTriggerOption("nxsz5","group","nxsz")
end
function nxszAskk()
    EnableTriggerGroup("nxsz",false)
	EnableTriggerGroup("nxszAsk",true)
	return check_bei(nxszPre,1)
end
function nxszSucc()
    EnableTriggerGroup("nxsz",false)
	quests["nxsz"].time = os.time()
	quests["nxsz"].auto = 2
	questSucLog(quests["nxsz"].name)
	return check_bei(nxszOver)
end
function nxszDel()
    EnableTriggerGroup("nxsz",false)
	quests["nxsz"].time = 0
	quests["nxsz"].auto = 0
	DeleteVariable("timenxsz")
	DeleteVariable("autonxsz")
	CloseLog()
	return check_bei(checkQuestOver)
end
function nxszContinue()
    EnableTriggerGroup("nxsz",false)
	quests["nxsz"].time = os.time()
	quests["nxsz"].auto = 1
	return check_bei(nxszOver)
end
function nxszFail()
    EnableTriggerGroup("nxsz",false)
	quests["nxsz"].time = os.time() - 12*60*60
	return check_bei(nxszOver)
end
function nxszNobody()
    EnableTriggerGroup("nxszAsk",false)
	quests["nxsz"].time = os.time() - 18*60*60
	return check_bei(nxszOver)
end
function nxszOver()
    DeleteTriggerGroup("nxszFind")
	DeleteTriggerGroup("nxsz")
	DeleteTriggerGroup("nxszAsk")
	exe("follow none")
	SetVariable("timenxsz",quests["nxsz"].time)
	SetVariable("autonxsz",quests["nxsz"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end