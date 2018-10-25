quests = quests or {}
quests["chongyang"] = {}
quests["chongyang"].auto = 0
quests["chongyang"].name = '重阳连环掌'

questTongji = questTongji or {}
questTongji["chongyang"] = "chongyangTongji"

questCal = questCal or {}
questCal["chongyang"] = "chongyangCal"

questList = questList or {}
questList["chongyang"] = function() if skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" then return quests["chongyang"].name else return false end end


function chongyangCal()
    if string.find("亥|子|丑",locl.time) and hp.shen and hp.shen > 2000000 and GetVariable("autochongyang") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" then
        if GetVariable("timechongyang") then
		    quests["chongyang"].time=tonumber(GetVariable("timechongyang"))
	    end
	    if GetVariable("autochongyang") then
		    quests["chongyang"].auto=tonumber(GetVariable("autochongyang"))
	    end
	    if quests["chongyang"].time==nil or os.time()-quests["chongyang"].time > 24*60*60 then
	        quests["chongyang"].time = os.time() - 22*60*60
		    SetVariable("timechongyang",quests["chongyang"].time)
	        if quests["chongyang"].auto==nil or quests["chongyang"].auto == 0 then
	            quests["chongyang"].auto = 1
	        end
	        if quests["chongyang"].auto == 1 then
		        exe('pray pearl')
		        return "questchongyang"
	        end
	    else
	        if quests["chongyang"].auto == 1 and quests["chongyang"].time then
	            local l_time = 24*60*60 - (os.time() - quests["chongyang"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["chongyang"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function chongyangTongji()
    if hp.shen and hp.shen > 2000000 and GetVariable("autochongyang") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" and quests["chongyang"] and quests["chongyang"].auto == 1 and quests["chongyang"].time then
	   local l_time = 24*60*60 - (os.time() - quests["chongyang"].time)
	   checkQuestNote(quests["chongyang"].name,l_time)
	end
end

function questchongyang()
    return go(chongyangPre,"全真","事为室")
end
function chongyangPre()
    if not locl.id["马钰"] then
	   quests["chongyang"].time = os.time() - 23*60*60
	   return check_bei(chongyangOver)
	end
    DeleteTriggerGroup("chongyangAsk")
    create_trigger_t('chongyangAsk1',"^(> )*你向马钰打听有关『重阳连环掌绝技』的消息。$",'','chongyangAsk')
    create_trigger_t('chongyangAsk2',"^(> )*这里没有这个人。$",'','chongyangNobody')
    SetTriggerOption("chongyangAsk1","group","chongyangAsk")
    SetTriggerOption("chongyangAsk2","group","chongyangAsk")
	questStartLog(quests["chongyang"].name)
	exe('askk ma yu about 重阳连环掌绝技')
end
function chongyangAsk()
    EnableTriggerGroup("chongyangAsk",false)
	DeleteTriggerGroup("chongyang")
	create_trigger_t('chongyang1',"^(> )*马钰(对你|)说道：(|「)你来的太频繁了",'','chongyangFail')
	create_trigger_t('chongyang2',"^(> )*马钰(对你|)说道：(|「)观星台空气好，若机缘巧合能参悟星斗之力",'','chongyangGo')
	create_trigger_t('chongyang3',"^(> )*马钰对你说道：恭喜解密铁脚仙绝技",'','chongyangSucc')
	SetTriggerOption("chongyang1","group","chongyang")
    SetTriggerOption("chongyang2","group","chongyang")
	SetTriggerOption("chongyang3","group","chongyang")
end
function chongyangGo()
    EnableTriggerGroup("chongyang",false)
	return go(chongyangKetou,'全真','后山山洞')
end
function chongyangKetou()
    if locl.room ~="后山山洞" then 
		return check_bei(chongyangGo,2)
	end
	flag.idle=0
	exe('ketou 画;ketou 画;ketou 画;ketou 画;ketou 画;ketou 画')
	exe('ketou 青砖;ketou 青砖;ketou 青砖;ketou 青砖;ketou 青砖;ketou 青砖;')
	exe('rukou;eu;nu;wu;u')
	--exe('canwu 北斗七星')
	return check_bei(chongyangCanwu)
end
function chongyangCanwu()
	DeleteTriggerGroup("chongyang")                           
	create_trigger_t('chongyang1',"^(> )*你来的太频繁了",'','chongyangFail')
	create_trigger_t('chongyang2','^(> )*你抓耳挠腮，苦思冥想，发现自己还是无法理解昊天掌重阳连环掌奥意所在，脸上一筹莫展。','','chongyangContinue')
	create_trigger_t('chongyang3',"^(> )*（原来|恭喜|原来如此|终于|你已经）",'','chongyangSucc')
	create_trigger_t('chongyang4',"^(> )*现在是白天，你无法观悟北斗七星阵势变化！",'','chongyangFail')
	--create_trigger_t('chongyang5',"^(> )*你盘膝而坐，五心向天，观悟天上北斗七星运转变化，心中潮起潮落，万物寂寥！",'','diseableTickcanwu')
	SetTriggerOption("chongyang1","group","chongyang")
    SetTriggerOption("chongyang2","group","chongyang")
	SetTriggerOption("chongyang3","group","chongyang")
	SetTriggerOption("chongyang4","group","chongyang")
	--SetTriggerOption("chongyang5","group","chongyang")
	exe('canwu 北斗七星')
end
function chongyangSucc()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time()
	quests["chongyang"].auto = 2
	questSucLog(quests["chongyang"].name)
	return check_bei(chongyangOver)
end
function chongyangDel()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = 0
	quests["chongyang"].auto = 0
	DeleteVariable("timechongyang")
	DeleteVariable("autochongyang")
	CloseLog()
	return check_bei(checkQuestOver)
end
function chongyangContinue()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time()
	return check_bei(chongyangOver)
end
function chongyangFail()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time() - 20*60*60
	return check_bei(chongyangOver)
end
function chongyangNobody()
    EnableTriggerGroup("chongyangAsk",false)
	quests["chongyang"].time = os.time() - 23*60*60
	return check_bei(chongyangOver)
end
function chongyangOver()
	SetVariable("timechongyang",quests["chongyang"].time)
	SetVariable("autochongyang",quests["chongyang"].auto)
	DeleteTriggerGroup("chongyangAsk")
	DeleteTriggerGroup("chongyang")
	CloseLog()
    return check_bei(checkQuestOver)
end