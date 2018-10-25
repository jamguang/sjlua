quests = quests or {}
quests["dyys"] = {}
quests["dyys"].auto = 0
quests["dyys"].name = "阴阳手绝技"

questTongji = questTongji or {}
questTongji["dyys"] = "dyysTongji"

questCal = questCal or {}
questCal["dyys"] = "dyysCal"

questList = questList or {}
questList["dyys"] = function() if score.party and score.party=="嵩山派" and skills["songyang-shou"] then return "阴阳手绝技" else return false end end


function dyysCal()
    if score.party=="嵩山派" and GetVariable("autodyys") and skills["songyang-shou"] then
      if GetVariable("timedyys") then
		 quests["dyys"].time=tonumber(GetVariable("timedyys"))
	  end
	  if GetVariable("autodyys") then
		 quests["dyys"].auto=tonumber(GetVariable("autodyys"))
	  end
	  if quests["dyys"].time==nil or os.time()-quests["dyys"].time > 24*60*60 then
	     quests["dyys"].time = os.time() - 12*60*60
		 SetVariable("timedyys",quests["dyys"].time)
	     if quests["dyys"].auto==nil or quests["dyys"].auto == 0 then
	        quests["dyys"].auto = 1
	     end
	     if quests["dyys"].auto == 1 then
		    exe('pray pearl')
		    return "questDyys"
	     end
	  else
	     if quests["dyys"].auto == 1 and quests["dyys"].time then
	        local l_time = 24*60*60 - (os.time() - quests["dyys"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("阴阳手绝技",l_time)
			end
	     end
	     return false
	  end
   end
end
function dyysTongji()
    if GetVariable("autodyys") and quests["dyys"] and quests["dyys"].auto == 1 and quests["dyys"].time then
	   local l_time = 24*60*60 - (os.time() - quests["dyys"].time)
	   checkQuestNote("阴阳手绝技",l_time)
	end
end
function questDyys()
   return go(dyysPre,"嵩山","大铁梁峡")
end
function dyysPre()
    if not locl.id["乐厚"] then
	   quests["dyys"].time = os.time() - 20*60*60
	   return check_bei(dyysOver)
	end
    DeleteTriggerGroup("dyysAsk")
    create_trigger_t('dyysAsk1',"^(> )*你向乐厚打听有关『大阴阳手』的消息",'','dyysAsk')
    create_trigger_t('dyysAsk2',"^(> )*这里没有这个人。$",'','dyysNobody')
    SetTriggerOption("dyysAsk1","group","dyysAsk")
    SetTriggerOption("dyysAsk2","group","dyysAsk")
	questStartLog(quests["dyys"].name)
	exe('ask le hou about 大阴阳手')
end
function dyysAsk()
    EnableTriggerGroup("dyysAsk",false)
	DeleteTriggerGroup("dyys")
	create_trigger_t('dyys1',"^(> )*乐厚说道：「\\D*，你来的太勤奋了。」",'','dyysFail')
	create_trigger_t('dyys2','^(> )*乐厚说道：「\\D*，我的大阴阳手绝技，那可是天下武功数一数二的！」','','dyysJue')
	SetTriggerOption("dyys1","group","dyys")
    SetTriggerOption("dyys2","group","dyys")
end
function dyysJue()
    EnableTriggerGroup("dyys",false)
	DeleteTriggerGroup("dyysJue")
	create_trigger_t('dyysJue1','^(> )*你把 "action" 设定为 "阴阳绝技" 成功完成。','','dyysSucc')
	create_trigger_t('dyysJue2','^(> )*乐厚说道：「小兄弟，你这是什么意思？」','','dyysFail')
	create_trigger_t('dyysJue3','^(> )*乐厚随即将阴阳手的诀窍悉数传授于你，你终于学会了大阴阳手！','','dyysSucc')
	create_trigger_t('dyysJue4','^(> )*乐厚虽然传授给你很多诀窍，但你还是太笨，领悟不了，解密失败！','','dyysContinue')
	SetTriggerOption("dyysJue1","group","dyysJue")
    SetTriggerOption("dyysJue2","group","dyysJue")
	SetTriggerOption("dyysJue3","group","dyysJue")
	SetTriggerOption("dyysJue4","group","dyysJue")
	return check_bei(dyysJueAsk)
end
function dyysJueAsk()
    exe('ask le hou about 阴阳绝技')
	exe('alias action 阴阳绝技')
end
function dyysSucc()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time()
	quests["dyys"].auto = 2
	questSucLog(quests["dyys"].name)
	return check_bei(dyysOver)
end
function dyysContinue()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time()
	return check_bei(dyysOver)
end
function dyysFail()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time() - 12*60*60
	return check_bei(dyysOver)
end
function dyysNobody()
    EnableTriggerGroup("dyysAsk",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time() - 18*60*60
	return check_bei(dyysOver)
end
function dyysOver()
	SetVariable("timedyys",quests["dyys"].time)
	SetVariable("autodyys",quests["dyys"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end