quests = quests or {}
quests["yusuo"] = {}
quests["yusuo"].auto = 0
quests["yusuo"].name = '金关玉锁诀'

questTongji = questTongji or {}
questTongji["yusuo"] = "yusuoTongji"

questCal = questCal or {}
questCal["yusuo"] = "yusuoCal"

questList = questList or {}
questList["yusuo"] = function() if score.party and score.party=="全真教" and skills["jinguan-yusuojue"] and skills["jinguan-yusuojue"].lvl>99 then return quests["yusuo"].name else return false end end


function yusuoCal()
    if GetVariable("autoyusuo") and skills["jinguan-yusuojue"] and skills["jinguan-yusuojue"].lvl>99 then
        if GetVariable("timeyusuo") then
		    quests["yusuo"].time=tonumber(GetVariable("timeyusuo"))
	    end
	    if GetVariable("autoyusuo") then
		    quests["yusuo"].auto=tonumber(GetVariable("autoyusuo"))
	    end
		
	    if quests["yusuo"].time==nil or os.time()-quests["yusuo"].time > 24*60*60 then
	        quests["yusuo"].time = os.time() - 22*60*60
		    SetVariable("timeyusuo",quests["yusuo"].time)
	        if quests["yusuo"].auto==nil or quests["yusuo"].auto == 0 then
	            quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100)
	        end
			local yusuolvl = math.modf(skills["jinguan-yusuojue"].lvl/100)
	        if quests["yusuo"].auto <= yusuolvl then
		        exe('pray pearl')
		        return "questyusuo"
	        end
	    else
	        if quests["yusuo"].auto <= math.modf(skills["jinguan-yusuojue"].lvl/100) and quests["yusuo"].time then
	            local l_time = 24*60*60 - (os.time() - quests["yusuo"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["yusuo"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function yusuoTongji()
    if GetVariable("autoyusuo") and quests["yusuo"] and skills["jinguan-yusuojue"] and quests["yusuo"].auto <= math.modf(skills["jinguan-yusuojue"].lvl/100) and quests["yusuo"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yusuo"].time)
	   checkQuestNote(quests["yusuo"].name,l_time)
	end
end

function questyusuo()
    return go(yusuoQu,"扬州城","杂货铺")
end
function yusuoQu()
    if locl.room ~= "杂货铺" then
        return go(yusuoQu,"扬州城","杂货铺")
    end
	tmp.i = 0
	exe("qu yusuo jingyao")
	checkBags()
	return check_bei(yusuoQuCheck,1)
end
function yusuoQuCheck()
    if not Bag["金关玉锁二十四诀精要"] then
	    tmp.i = tmp.i or 1
		tmp.i = tmp.i + 1
		if tmp.i > 3 then
		    return yusuoGo()
		end
		return yusuoQu()
	end
	return yusuoGoChanfang()
end
function yusuoCun()
    if locl.room ~= "杂货铺" then
        return go(yusuoCun,"扬州城","杂货铺")
    end
	tmp.i = 0
	exe("cun yusuo jingyao")
	checkBags()
	return check_bei(yusuoCunCheck,1)
end
function yusuoCunCheck()
    if Bag["金关玉锁二十四诀精要"] then
	    tmp.i = tmp.i or 1
		tmp.i = tmp.i + 1
		if tmp.i < 3 then
		    return yusuoCun()
		end
		return check_heal()
	end
	return check_heal()
end
function yusuoGo()
    return go(yusuoPre,"全真","事为室")
end
function yusuoPre()
    if not locl.id["马钰"] then
	   quests["yusuo"].time = os.time() - 20*60*60
	   return check_bei(yusuoOver)
	end
    DeleteTriggerGroup("yusuoAsk")
    create_trigger_t('yusuoAsk1',"^(> )*你向马钰打听有关『金关玉锁二十四诀』的消息。",'','yusuoAsk')
    create_trigger_t('yusuoAsk2',"^(> )*这里没有这个人。$",'','yusuoNobody')
	create_trigger_t('yusuoAsk3',"^(> )*马钰说道：「你身上不是有玉锁诀的精要么？！」",'','yusuoQuit')
	--create_trigger_t('yusuoAsk4',"^(> )*你金关玉锁诀修炼感悟的太少，目前无法参悟。",'','yusuoDel')
	create_trigger_t('yusuoAsk5',"^(> )*马钰说道：「带上这本我修炼的《金关玉锁诀精要》到禅房去找个蒲团认真修炼！」",'','yusuoGoChanfang')
    SetTriggerOption("yusuoAsk1","group","yusuoAsk")
    SetTriggerOption("yusuoAsk2","group","yusuoAsk")
	SetTriggerOption("yusuoAsk3","group","yusuoAsk")
	--SetTriggerOption("yusuoAsk4","group","yusuoAsk")
	SetTriggerOption("yusuoAsk5","group","yusuoAsk")
    --questStartLog(quests["yusuo"].name)
	return exe('askk ma about 金关玉锁二十四诀;score')
end
function yusuoGoChanfang()
	return go(yusuoCanwu,'全真','禅房')
end
function yusuoCanwu()
	if locl.room ~="禅房" then 
		return check_bei(yusuoGoChanfang,2)
	end
	yusuoAsk()
	flag.idle=0
	questStartLog(quests["yusuo"].name)
	exe('sit;canwu 金关玉锁二十四诀')
end
function yusuoAsk()
    EnableTriggerGroup("yusuoAsk",false)
	DeleteTriggerGroup("yusuo")                                  
	create_trigger_t('yusuo1',"^(> )*参悟需要灵感和机缘，太频繁并不好！",'','yusuoFail')
	create_trigger_t('yusuo2','^(> )*你参悟半天，虽然知晓金关玉锁诀的奥秘，可是对如何融汇贯通的真正奥妙全然不得要领。','','yusuoContinue')
	create_trigger_t('yusuo3',"^(> )*你只觉一股真气浩荡而起，瞬间沿着任督二脉",'','yusuoSucc')
	create_trigger_t('yusuo4',"^(> )*你试图参悟金关玉锁诀，却发现",'','yusuoWait')
	create_trigger_t('yusuo5',"^(> )*你金关玉锁诀修炼感悟的太少，目前无法参悟。",'','yusuoStop')
	SetTriggerOption("yusuo1","group","yusuo")
    SetTriggerOption("yusuo2","group","yusuo")
	SetTriggerOption("yusuo3","group","yusuo")
	SetTriggerOption("yusuo4","group","yusuo")
	SetTriggerOption("yusuo5","group","yusuo")
end
function yusuoWait()
    EnableTriggerGroup("yusuo",false)
    return checkWait(yusuoGoChanfang,10)
end
function yusuoStop()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100) + 1
	return check_bei(yusuoOver)
end
function yusuoSucc()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100) + 1
	questSucLog(quests["yusuo"].name.."第".. quests["yusuo"].auto-1 .."层")
	return check_bei(yusuoOver)
end
function yusuoContinue()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100)
	return check_bei(yusuoOver)
end
function yusuoFail()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time() - 12*60*60
	return check_bei(yusuoOver)
end
function yusuoNobody()
    EnableTriggerGroup("yusuoAsk",false)
	quests["yusuo"].time = os.time() - 18*60*60
	return check_bei(yusuoOver)
end
function yusuoOver()
	SetVariable("timeyusuo",quests["yusuo"].time)
	SetVariable("autoyusuo",quests["yusuo"].auto)
	DeleteTriggerGroup("yusuoAsk")
	DeleteTriggerGroup("yusuo")
	--exe('stand;drop book') 
	exe('stand') 
    CloseLog()
	--return husongQuit()	
	return yusuoCun()
end
function yusuoQuit()
    EnableTriggerGroup("yusuo",false)
    DeleteTriggerGroup("yusuoAsk")
	DeleteTriggerGroup("yusuo")
    CloseLog()
	return husongQuit()
end
function yusuoDel()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = 0
	DeleteVariable("timeyusuo")
	DeleteVariable("autoyusuo")
	CloseLog()
	return check_bei(checkQuestOver)
end