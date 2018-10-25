quests = quests or {}
quests["ranmu"] = {}
quests["ranmu"].auto = 0
quests["ranmu"].name = "燃木绝技"

questTongji = questTongji or {}
questTongji["ranmu"] = "ranmuTongji"

questCal = questCal or {}
questCal["ranmu"] = "ranmuCal"

questList = questList or {}
questList["ranmu"] = function() if score.party and score.party=="少林派" then return quests["ranmu"].name else return false end end


function ranmuCal()
    if isInBags("木刀") and skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and GetVariable("autoranmu") then
      if GetVariable("timeranmu") then
		 quests["ranmu"].time=tonumber(GetVariable("timeranmu"))
	  end
	  if GetVariable("autoranmu") then
		 quests["ranmu"].auto=tonumber(GetVariable("autoranmu"))
	  end
	  if quests["ranmu"].time==nil or os.time()-quests["ranmu"].time > 24*60*60 then
	     quests["ranmu"].time = os.time() - 22*60*60
		 SetVariable("timeranmu",quests["ranmu"].time)
	     if quests["ranmu"].auto==nil or quests["ranmu"].auto == 0 then
	        quests["ranmu"].auto = 1
	     end
	     if quests["ranmu"].auto == 1 then
		    exe('pray pearl')
		    return "questRanmu"
	     end
	  else
	     if quests["ranmu"].auto == 1 and quests["ranmu"].time then
	        local l_time = 24*60*60 - (os.time() - quests["ranmu"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["ranmu"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function ranmuTongji()
    if GetVariable("autoranmu") and skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and quests["ranmu"] and quests["ranmu"].auto == 1 and quests["ranmu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["ranmu"].time)
	   checkQuestNote(quests["ranmu"].name,l_time)
	end
end
function questRanmu()
   return go(ranmuPre,"嵩山少林","罗汉堂")
end
function ranmuPre()
    if not locl.id["玄苦大师"] then
	   quests["ranmu"].time = os.time() - 20*60*60
	   return check_bei(ranmuOver)
	end
    DeleteTriggerGroup("ranmuAsk")
    create_trigger_t('ranmuAsk1',"^(> )*你向玄苦大师打听有关『燃木绝技』的消息",'','ranmuAsk')
    create_trigger_t('ranmuAsk2',"^(> )*这里没有这个人。$",'','ranmuNobody')
    SetTriggerOption("ranmuAsk1","group","ranmuAsk")
    SetTriggerOption("ranmuAsk2","group","ranmuAsk")
	exe('ask xuanku dashi about 燃木绝技')
end
function ranmuAsk()
    EnableTriggerGroup("ranmuAsk",false)
	DeleteTriggerGroup("ranmu")
	create_trigger_t('ranmu1',"^(> )*玄苦大师说道：「你若想将燃木刀再上一个台阶，就去般若堂六部找澄信",'','ranmuGo')
	create_trigger_t('ranmu2','^(> )*玄苦大师说道：「你来的太频繁了，要知道佛家讲究的是顿悟！」','','ranmuFail')
	SetTriggerOption("ranmu1","group","ranmu")
    SetTriggerOption("ranmu2","group","ranmu")
end
function ranmuGo()
    EnableTriggerGroup("ranmu",false)
	return go(ranmuXin,"嵩山少林","般若堂六部")
end
function ranmuXin()
    if not locl.id["澄信"] then
	   quests["ranmu"].time = os.time() - 20*60*60
	   return check_bei(ranmuOver)
	end
    DeleteTriggerGroup("ranmuAsk")
    create_trigger_t('ranmuAsk1',"^(> )*你向澄信打听有关『燃木绝技』的消息。",'','ranmuXinAsk')
    create_trigger_t('ranmuAsk2',"^(> )*这里没有这个人。$",'','ranmuNobody')
    SetTriggerOption("ranmuAsk1","group","ranmuAsk")
    SetTriggerOption("ranmuAsk2","group","ranmuAsk")
	questStartLog(quests["ranmu"].name)
	exe('ask chengxin luohan about 燃木绝技')
end
function ranmuXinAsk()
    EnableTriggerGroup("ranmuAsk",false)
	return check_bei(ranmuPi,1)
end
function ranmuPi()
	DeleteTriggerGroup("ranmu")
	create_trigger_t('ranmu1',"^(> )*少林禅宗讲究的是顿悟，练功不宜太频繁！",'','ranmuFail')
	create_trigger_t('ranmu2','^(> )*非常遗憾,解密燃木失败','','ranmuContinue')
	create_trigger_t('ranmu3','^(> )*你把 "action" 设定为 "燃木绝技" 成功完成。','','ranmuSucc')
	create_trigger_t('ranmu4','^(> )*你一刀劈出，顿觉手中木刀一阵炙热','','ranmuSucc')
	SetTriggerOption("ranmu1","group","ranmu")
    SetTriggerOption("ranmu2","group","ranmu")
	SetTriggerOption("ranmu3","group","ranmu")
	SetTriggerOption("ranmu4","group","ranmu")
	weapon_unwield()
	exe('wield mu dao;i')
	exe('pi 木柴')
    exe('alias action 燃木绝技')
end
function ranmuSucc()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time()
	quests["ranmu"].auto = 2
	questSucLog(quests["ranmu"].name)
	return check_bei(ranmuOver)
end
function ranmuContinue()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time()
	return check_bei(ranmuOver)
end
function ranmuFail()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time() - 12*60*60
	return check_bei(ranmuOver)
end
function ranmuNobody()
    EnableTriggerGroup("ranmuAsk",false)
	quests["ranmu"].time = os.time() - 18*60*60
	return check_bei(ranmuOver)
end
function ranmuOver()
	SetVariable("timeranmu",quests["ranmu"].time)
	SetVariable("autoranmu",quests["ranmu"].auto)
	DeleteTriggerGroup("ranmuAsk")
	DeleteTriggerGroup("ranmu")
	CloseLog()
    return check_bei(checkQuestOver)
end