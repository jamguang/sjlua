quests = quests or {}
quests["juding"] = {}
quests["juding"].auto = 0
quests["juding"].name = '三花聚顶掌'

questTongji = questTongji or {}
questTongji["juding"] = "judingTongji"

questCal = questCal or {}
questCal["juding"] = "judingCal"

questList = questList or {}
questList["juding"] = function() if skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=200 then return quests["juding"].name else return false end end


function judingCal()
    if GetVariable("autojuding") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=200 then
        if GetVariable("timejuding") then
		    quests["juding"].time=tonumber(GetVariable("timejuding"))
	    end
	    if GetVariable("autojuding") then
		    quests["juding"].auto=tonumber(GetVariable("autojuding"))
	    end
	    if quests["juding"].time==nil or os.time()-quests["juding"].time > 24*60*60 then
	        quests["juding"].time = os.time() - 22*60*60
		    SetVariable("timejuding",quests["juding"].time)
	        if quests["juding"].auto==nil or quests["juding"].auto == 0 then
	            quests["juding"].auto = 1
	        end
	        if quests["juding"].auto == 1 then
		        exe('pray pearl')
		        return "questjuding"
	        end
	    else
	        if quests["juding"].auto == 1 and quests["juding"].time then
	            local l_time = 24*60*60 - (os.time() - quests["juding"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["juding"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function judingTongji()
    if GetVariable("autojuding") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=200 and quests["juding"] and quests["juding"].auto == 1 and quests["juding"].time then
	   local l_time = 24*60*60 - (os.time() - quests["juding"].time)
	   checkQuestNote(quests["juding"].name,l_time)
	end
end

function questjuding()
    return go(judingPre,"全真","事为室")
end
function judingPre()
    if not locl.id["马钰"] then
	   quests["juding"].time = os.time() - 23*60*60
	   return check_bei(judingOver)
	end
    DeleteTriggerGroup("judingAsk")
    create_trigger_t('judingAsk1',"^(> )*你向马钰打听有关『三花聚顶掌』的消息。$",'','judingAsk')
    create_trigger_t('judingAsk2',"^(> )*这里没有这个人。$",'','judingNobody')
    SetTriggerOption("judingAsk1","group","judingAsk")
    SetTriggerOption("judingAsk2","group","judingAsk")
	questStartLog(quests["juding"].name)
	for i = 1,3 do
	    exe("give head "..i.." to ma yu")
	end
	
	exe('askk ma yu about 三花聚顶掌')
end
function judingAsk()
    EnableTriggerGroup("judingAsk",false)
	DeleteTriggerGroup("juding")
	create_trigger_t('juding1',"^(> )*马钰(对你|)说道：(|「)你来的太频繁了",'','judingFail')
	create_trigger_t('juding2','^(> )*你听了马钰的指点，可是对','','judingContinue')
	create_trigger_t('juding3','^(> )*马钰(对你|)说道：(|「)你的昊天掌的三花聚顶掌已经解开了','','judingSucc')
	create_trigger_t('juding4',"^(> )*马钰(对你|)说道：(|「)这次你替我去杀了(\\D*)这个恶贼！",'','judingGo')
	create_trigger_t('juding5',"^(> )*马钰(对你|)说道：(|「)恭喜解密",'','judingSucc')
	SetTriggerOption("juding1","group","juding")
    SetTriggerOption("juding2","group","juding")
	SetTriggerOption("juding3","group","juding")
	SetTriggerOption("juding4","group","juding")
	SetTriggerOption("juding5","group","juding")
end
function judingGo(n,l,w)
    EnableTriggerGroup("juding",false)
	job.target=tostring(Trim(w[4]))
	if job.target=='欧阳克' then 
	    return check_bei(questjuding,1)
	end
	if job.target=="灵智上人" then
	    return fastSearch("大雪山礼佛大殿",job.target,"judingKill")
	end
	return fastSearch("黄河流域黄河帮寨门",job.target,"judingKill")
end
function judingKill()
    if not locl.id[job.target] then
	    return judingFail()
	end
	
	return wipe(locl.id[job.target],judingCut)
end
function judingCut()
    return commCut(job.target,"judingBack")
end
function judingBack()
    return go(judingPre,"全真","事为室")
end
function judingSucc()
    EnableTriggerGroup("juding",false)
	quests["juding"].time = os.time()
	quests["juding"].auto = 2
	questSucLog(quests["juding"].name)
	return check_bei(judingOver)
end
function judingDel()
    EnableTriggerGroup("juding",false)
	quests["juding"].time = 0
	quests["juding"].auto = 0
	DeleteVariable("timejuding")
	DeleteVariable("autojuding")
	CloseLog()
	return check_bei(checkQuestOver)
end
function judingContinue()
    EnableTriggerGroup("juding",false)
	quests["juding"].time = os.time()
	return check_bei(judingOver)
end
function judingFail()
    EnableTriggerGroup("juding",false)
	quests["juding"].time = os.time() - 20*60*60
	return check_bei(judingOver)
end
function judingNobody()
    EnableTriggerGroup("judingAsk",false)
	quests["juding"].time = os.time() - 23*60*60
	return check_bei(judingOver)
end
function judingOver()
	SetVariable("timejuding",quests["juding"].time)
	SetVariable("autojuding",quests["juding"].auto)
	DeleteTriggerGroup("judingAsk")
	DeleteTriggerGroup("juding")
	CloseLog()
    return check_bei(checkQuestOver)
end