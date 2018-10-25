quests = quests or {}
quests["yzc"] = {}
quests["yzc"].auto = 0
quests["yzc"].name = '一指禅绝技'

questTongji = questTongji or {}
questTongji["yzc"] = "yzcTongji"

questCal = questCal or {}
questCal["yzc"] = "yzcCal"

questList = questList or {}
questList["yzc"] = function() if score.party=="少林派" and skills["buddhism"] and  skills["buddhism"].lvl>160 and skills["yizhi-chan"] and skills["yizhi-chan"].lvl>200 then return quests["yzc"].name else return false end end


function yzcCal()
    if GetVariable("autoyzc") and score.party=="少林派" and skills["buddhism"] and  skills["buddhism"].lvl>160 and skills["yizhi-chan"] and skills["yizhi-chan"].lvl>200 then
      if GetVariable("timeyzc") then
		 quests["yzc"].time=tonumber(GetVariable("timeyzc"))
	  end
	  if GetVariable("autoyzc") then
		 quests["yzc"].auto=tonumber(GetVariable("autoyzc"))
	  end
	  if quests["yzc"].time==nil or os.time()-quests["yzc"].time > 24*60*60 then
	     quests["yzc"].time = os.time() - 22*60*60
		 SetVariable("timeyzc",quests["yzc"].time)
	     if quests["yzc"].auto==nil or quests["yzc"].auto == 0 then
	        quests["yzc"].auto = 1
	     end
	     if quests["yzc"].auto == 1 then
		    exe('pray pearl')
		    return "questyzc"
	     end
	  else
	     if quests["yzc"].auto == 1 and quests["yzc"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yzc"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["yzc"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function yzcTongji()
    if GetVariable("autoyzc") and quests["yzc"] and quests["yzc"].auto == 1 and quests["yzc"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yzc"].time)
	   checkQuestNote(quests["yzc"].name,l_time)
	end
end

function questyzc()
   return go(yzcPre,"shaolin/chanfang-1")
end
function yzcPre()
    if not locl.id["玄澄大师"] then
	   quests["yzc"].time = os.time() - 20*60*60
	   return check_bei(yzcOver)
	end
    DeleteTriggerGroup("yzcAsk")
    create_trigger_t('yzcAsk1',"^(> )*你向玄澄大师打听有关『一指禅』的消息",'','yzcAsk')
    create_trigger_t('yzcAsk2',"^(> )*这里没有这个人。$",'','yzcNobody')
    SetTriggerOption("yzcAsk1","group","yzcAsk")
    SetTriggerOption("yzcAsk2","group","yzcAsk")
	return exe('ask xuancheng dashi about 一指禅')
end
function yzcAsk()
    EnableTriggerGroup("yzcAsk",false)
	return go(yzcCanwu,"嵩山少林","达摩洞")
end
function yzcCanwu()
    if locl.room ~= "达摩洞" then
	    return go(yzcCanwu,"嵩山少林","达摩洞")
	end
	DeleteTriggerGroup("yzc")
    create_trigger_t('yzc1',"^(> )*你参悟半天，心烦意乱，很难静下心来",'','yzcContinue')
    create_trigger_t('yzc2',"^(> )*你来的也太勤快点了！",'','yzcFail')
	create_trigger_t('yzc3','^(> )*你把 "action" 设定为 "参悟一指禅" 成功完成。','','yzcSucc')
    SetTriggerOption("yzc1","group","yzc") --你已经通过观摩达摩图像，领悟了一指禅的奥妙！
    SetTriggerOption("yzc2","group","yzc")
	SetTriggerOption("yzc3","group","yzc")
	questStartLog(quests["yzc"].name)
	exe('canwu 一指禅')
	exe('alias action 参悟一指禅')
end
function yzcSucc()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time()
	quests["yzc"].auto = 2
	questSucLog(quests["yzc"].name)
	return check_bei(yzcOver)
end
function yzcContinue()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time()
	return check_bei(yzcOver)
end
function yzcFail()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time() - 12*60*60
	return check_bei(yzcOver)
end
function yzcNobody()
    EnableTriggerGroup("yzcAsk",false)
	quests["yzc"].time = os.time() - 18*60*60
	return check_bei(yzcOver)
end
function yzcOver()
	SetVariable("timeyzc",quests["yzc"].time)
	SetVariable("autoyzc",quests["yzc"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end