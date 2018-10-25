quests = quests or {}
quests["feiwu"] = {}
quests["feiwu"].auto = 0
quests["feiwu"].name = "飞舞绝技"

questTongji = questTongji or {}
questTongji["feiwu"] = "feiwuTongji"

questCal = questCal or {}
questCal["feiwu"] = "feiwuCal"

questList = questList or {}
questList["feiwu"] = function() if score.party and score.party=="嵩山派" and skills["songshan-jian"] then return "飞舞绝技" else return false end end


local feiwuRoom = {}

function feiwuCal()
    if score.party=="嵩山派" and GetVariable("autofeiwu") and skills["songshan-jian"] then
      if GetVariable("timefeiwu") then
		 quests["feiwu"].time=tonumber(GetVariable("timefeiwu"))
	  end
	  if GetVariable("autofeiwu") then
		 quests["feiwu"].auto=tonumber(GetVariable("autofeiwu"))
	  end
	  if quests["feiwu"].time==nil or os.time()-quests["feiwu"].time > 24*60*60 then
	     quests["feiwu"].time = os.time() - 12*60*60
		 SetVariable("timefeiwu",quests["feiwu"].time)
	     if quests["feiwu"].auto==nil or quests["feiwu"].auto == 0 then
	        quests["feiwu"].auto = 1
	     end
	     if quests["feiwu"].auto == 1 then
		    exe('pray pearl')
		    return "questFeiwu"
	     end
	  else
	     if quests["feiwu"].auto == 1 and quests["feiwu"].time then
	        local l_time = 24*60*60 - (os.time() - quests["feiwu"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("飞舞绝技",l_time)
			end
	     end
	     return false
	  end
   end
end
function feiwuTongji()
    if GetVariable("autofeiwu") and quests["feiwu"] and quests["feiwu"].auto == 1 and quests["feiwu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["feiwu"].time)
	   checkQuestNote("飞舞绝技",l_time)
	end
end
function questFeiwu()
    quests["feiwu"].time = os.time() - 20*60*60
	feiwuRoom = {}
    return go(feiwuFind,"嵩山","封禅台")
end
function feiwuFind()
    EnableTriggerGroup("feiwuFollow",false)
    if locl.id["费彬"] then
	   return feiwuFollow()
	end
	
	feiwuRoom = feiwuRoom or {}
	if countTab(feiwuRoom) == 0 then
	   feiwuRoom = getCityRooms("嵩山")
	end
	
	local from = road.id
	for i=1,countTab(feiwuRoom) do
	    local l_dest,l_p=getNearRoom(from,feiwuRoom)
		table.remove(feiwuRoom,l_p)
		if l_dest then
		   	--local path, len = map:getPath(from,l_dest)
	        --if path then
	        --   table.insert(road.rooms,l_dest)
			--end
			return go(feiwuFind,l_dest)
        end		   
    end
	
end
function feiwuFollow()
    DeleteTriggerGroup("feiwuFollow")
    create_trigger_t('feiwuFollow1',"^(> )*你决定跟随费彬一起行动。",'','feiwuPre')
    create_trigger_t('feiwuFollow2',"^(> )*这里没有 fei bin。$",'','feiwuFind')
    SetTriggerOption("feiwuFollow1","group","feiwuFollow")
    SetTriggerOption("feiwuFollow2","group","feiwuFollow")
    exe("follow fei bin")
end
function feiwuPre()
    EnableTriggerGroup("feiwuFollow",false)
    DeleteTriggerGroup("feiwuAsk")
    create_trigger_t('feiwuAsk1',"^(> )*你向费彬打听有关『观日峰』的消息",'','feiwuAsk')
    create_trigger_t('feiwuAsk2',"^(> )*这里没有这个人。$",'','feiwuNobody')
    SetTriggerOption("feiwuAsk1","group","feiwuAsk")
    SetTriggerOption("feiwuAsk2","group","feiwuAsk")
	exe('ask fei bin about 观日峰')
end
function feiwuAsk()
    EnableTriggerGroup("feiwuAsk",false)
	DeleteTriggerGroup("feiwu")
	create_trigger_t('feiwu1','^(> )*费彬说道：「看你是不错的人才，我就告诉你这些，你自己去领悟去吧。」','','feiwuGo')
	SetTriggerOption("feiwu1","group","feiwu")
end
function feiwuGo()
    EnableTriggerGroup("feiwu",false)
	DeleteTriggerGroup("feiwu")
	return go(feuwuGuan,"嵩山","观日峰")
end
function feuwuGuan()
    EnableTriggerGroup("feiwu",false)
	DeleteTriggerGroup("feiwuJue")
	create_trigger_t('feiwuJue1','^(> )*你把 "action" 设定为 "飞舞绝技" 成功完成。','','feiwuSucc')
	create_trigger_t('feiwuJue2','^(> )*你也太勤快点了，还是需要继续努力才好!','','feiwuFail')
	--create_trigger_t('feiwuJue3','^(> )*乐厚说道：「你已经解开了？」','','feiwuSucc')
	create_trigger_t('feiwuJue4','^(> )*领悟失败，你不禁有些灰心丧气','','feiwuContinue')
	SetTriggerOption("feiwuJue1","group","feiwuJue")
    SetTriggerOption("feiwuJue2","group","feiwuJue")
	SetTriggerOption("feiwuJue3","group","feiwuJue")
	SetTriggerOption("feiwuJue4","group","feiwuJue")
	questStartLog(quests["feiwu"].name)
    exe('guanwu songtao;look')
	exe('alias action 飞舞绝技')
end
function feiwuSucc()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time()
	quests["feiwu"].auto = 2
	questSucLog(quests["feiwu"].name)
	return check_bei(feiwuOver)
end
function feiwuContinue()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time()
	return check_bei(feiwuOver)
end
function feiwuFail()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time() - 18*60*60
	return check_bei(feiwuOver)
end
function feiwuNobody()
    EnableTriggerGroup("feiwuAsk",false)
	EnableTriggerGroup("feiwuJue",false)
	EnableTriggerGroup("feiwuFollow",false)
	quests["feiwu"].time = os.time() - 22*60*60
	return check_bei(feiwuOver)
end
function feiwuOver()
	SetVariable("timefeiwu",quests["feiwu"].time)
	SetVariable("autofeiwu",quests["feiwu"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end