quests = quests or {}
quests["cibei"] = {}
quests["cibei"].auto = 0
quests["cibei"].name = "慈悲刀绝技"

questTongji = questTongji or {}
questTongji["cibei"] = "cibeiTongji"

questCal = questCal or {}
questCal["cibei"] = "cibeiCal"

questList = questList or {}
questList["cibei"] = function() if score.party and score.party=="少林派" and skills["cibei-dao"] then return quests["cibei"].name else return false end end


function cibeiCal()
    if score.party=="少林派" and GetVariable("autocibei") and skills["cibei-dao"] then
      if GetVariable("timecibei") then
		 quests["cibei"].time=tonumber(GetVariable("timecibei"))
	  end
	  if GetVariable("autocibei") then
		 quests["cibei"].auto=tonumber(GetVariable("autocibei"))
	  end
	  if quests["cibei"].time==nil or os.time()-quests["cibei"].time > 24*60*60 then
	     quests["cibei"].time = os.time() - 22*60*60
		 SetVariable("timecibei",quests["cibei"].time)
	     if quests["cibei"].auto==nil or quests["cibei"].auto == 0 then
	        quests["cibei"].auto = 1
	     end
	     if quests["cibei"].auto == 1 then
		    exe('pray pearl')
		    return "questCibei"
	     end
	  else
	     if quests["cibei"].auto == 1 and quests["cibei"].time then
	        local l_time = 24*60*60 - (os.time() - quests["cibei"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("慈悲刀绝技",l_time)
			end
	     end
	     return false
	  end
   end
end
function cibeiTongji()
    if GetVariable("autocibei") and quests["cibei"] and quests["cibei"].auto == 1 and quests["cibei"].time then
	   local l_time = 24*60*60 - (os.time() - quests["cibei"].time)
	   checkQuestNote("慈悲刀绝技",l_time)
	end
end
function questCibei()
   return go(cibeiPre,"嵩山少林","达摩院")
end
function cibeiPre()
    if not locl.id["玄悲大师"] then
	   quests["cibei"].time = os.time() - 20*60*60
	   return check_bei(cibeiOver)
	end
    DeleteTriggerGroup("cibeiAsk")
    create_trigger_t('cibeiAsk1',"^(> )*你向玄悲大师打听有关『慈悲刀绝技』的消息",'','cibeiAsk')
    create_trigger_t('cibeiAsk2',"^(> )*这里没有这个人。$",'','cibeiNobody')
    SetTriggerOption("cibeiAsk1","group","cibeiAsk")
    SetTriggerOption("cibeiAsk2","group","cibeiAsk")
	exe('ask xuanbei dashi about 慈悲刀绝技')
end
function cibeiAsk()
    EnableTriggerGroup("cibeiAsk",false)
	DeleteTriggerGroup("cibei")
	create_trigger_t('cibei1',"^(> )*玄悲大师说道：「你若想学可以跟他请教这慈悲刀真意。」",'','cibeiGo')
	create_trigger_t('cibei2','^(> )*玄悲大师对你说道：顿悟啊！','','cibeiFail')
	SetTriggerOption("cibei1","group","cibei")
    SetTriggerOption("cibei2","group","cibei")
end
function cibeiGo()
    EnableTriggerGroup("cibei",false)
	return go(cibeiXin,"宁波城","天童禅寺")
end
function cibeiXin()
    if not locl.id["心观大师"] then
	   quests["cibei"].time = os.time() - 20*60*60
	   return check_bei(cibeiOver)
	end
    DeleteTriggerGroup("cibeiAsk")
    create_trigger_t('cibeiAsk1',"^(> )*你向心观大师打听有关『慈悲刀绝技』的消息",'','cibeiXinAsk')
    create_trigger_t('cibeiAsk2',"^(> )*这里没有这个人。$",'','cibeiNobody')
    SetTriggerOption("cibeiAsk1","group","cibeiAsk")
    SetTriggerOption("cibeiAsk2","group","cibeiAsk")
	questStartLog(quests["cibei"].name)
	exe('ask xinguan dashi about 慈悲刀绝技')
	exe('alias action 慈悲刀绝技')
end
function cibeiXinAsk()
    EnableTriggerGroup("cibeiAsk",false)
	DeleteTriggerGroup("cibei")
	create_trigger_t('cibei1',"^(> )*心观大师说道：「你太勤宽了，老僧我不堪骚扰！」",'','cibeiFail')
	create_trigger_t('cibei2','^(> )*你听了心观大师的指点，虽然听见了慈悲刀法的奥秘','','cibeiContinue')
	create_trigger_t('cibei3','^(> )*你把 "action" 设定为 "慈悲刀绝技" 成功完成。','','cibeiSucc')
	create_trigger_t('cibei4','^(> )*你历尽千辛万苦，终于得偿所愿，将慈悲刀法融汇贯通。','','cibeiSucc')
	SetTriggerOption("cibei1","group","cibei")
    SetTriggerOption("cibei2","group","cibei")
	SetTriggerOption("cibei3","group","cibei")
	SetTriggerOption("cibei4","group","cibei")
end
function cibeiSucc()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time()
	quests["cibei"].auto = 2
	questSucLog(quests["cibei"].name)
	return check_bei(cibeiOver)
end
function cibeiContinue()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time()
	return check_bei(cibeiOver)
end
function cibeiFail()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time() - 12*60*60
	return check_bei(cibeiOver)
end
function cibeiNobody()
    EnableTriggerGroup("cibeiAsk",false)
	quests["cibei"].time = os.time() - 18*60*60
	return check_bei(cibeiOver)
end
function cibeiOver()
	SetVariable("timecibei",quests["cibei"].time)
	SetVariable("autocibei",quests["cibei"].auto)
	DeleteTriggerGroup("cibeiAsk")
	DeleteTriggerGroup("cibei")
	CloseLog()
    return check_bei(checkQuestOver)
end