quests = quests or {}
quests["bgzjj"] = {}
quests["bgzjj"].auto = 0
quests["bgzjj"].name = '九阴白骨爪绝技'

questTongji = questTongji or {}
questTongji["bgzjj"] = "bgzjjTongji"

questCal = questCal or {}
questCal["bgzjj"] = "bgzjjCal"

questList = questList or {}
questList["bgzjj"] = function() if skills["jiuyin-baiguzhua"] and skills["jiuyin-baiguzhua"].lvl>350 then return quests["bgzjj"].name else return false end end


function bgzjjCal()
    if string.find("亥|子|丑",locl.time) and GetVariable("autobgzjj") and Bag["火折"] and skills["jiuyin-baiguzhua"] and skills["jiuyin-baiguzhua"].lvl>350 and hp.shen<0 then
        if GetVariable("timebgzjj") then
		   quests["bgzjj"].time=tonumber(GetVariable("timebgzjj"))
	    end
	    if GetVariable("autobgzjj") then
		   quests["bgzjj"].auto=tonumber(GetVariable("autobgzjj"))
	    end
	    if quests["bgzjj"].time==nil or os.time()-quests["bgzjj"].time > 24*60*60 then
	       quests["bgzjj"].time = os.time() - 12*60*60
		   SetVariable("timebgzjj",quests["bgzjj"].time)
	       if quests["bgzjj"].auto==nil or quests["bgzjj"].auto == 0 then
	          quests["bgzjj"].auto = 1
	       end
	       if quests["bgzjj"].auto < 2 then
		      exe('pray pearl')
		      return "questbgzjj"
	       end
	    else
	       if quests["bgzjj"].auto < 2 and quests["bgzjj"].time then
	          local l_time = 24*60*60 - (os.time() - quests["bgzjj"].time)
		  	if l_time < 0 or l_time * math.random() < 1800 then
		  	   checkQuestNote(quests["bgzjj"].name,l_time)
		  	end
	       end
	       return false
	    end
    end
end
function bgzjjTongji()
    if GetVariable("autobgzjj") and hp.shen<0 and Bag["火折"] and quests["bgzjj"] and quests["bgzjj"].auto < 2 and quests["bgzjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bgzjj"].time)
	   checkQuestNote(quests["bgzjj"].name,l_time)
	end
end

function checkKulouYz()
    checkBags()
    if not Bag["骷髅头"] then
       return go(checkKulouQu,"扬州城","杂货铺")
    else
       return check_bei(questbgzjj)
    end   
end
function checkKulouQu()
   exe('qu kulou tou')
   checkBags()
   return check_bei(checkKulouZhp,1)
end
function checkKulouZhp()
    if not Bag["骷髅头"] then
       return checkKulouEmei()
    else
       return check_bei(questbgzjj)
    end 
end
function checkKulouEmei()
    if not Bag["火折"] then
	    return go(checkKulouFire,randomElement(drugBuy["火折"]))
	else
	    return go(checkKulouGet,"峨嵋山","山坡") 
	end
end
function checkKulouFire()
    exe('buy fire')
	checkBags()
	return check_bei(checkKulouEmei,1)
end
function checkKulouGet()
    exe('get tou')
	checkBags()
	return check_bei(checkKulouGetWait,1)
end
function checkKulouGetWait()
    if not Bag["骷髅头"] then
	    quests["bgzjj"].time = os.time() - 23*60*60
	    return check_bei(bgzjjOver)
    else
        return check_bei(questbgzjj)
    end
end
function questbgzjj()
    if not Bag["骷髅头"] then
	    return checkKulouYz()
	else  
		return questbgzjjask()  
	end
end

function questbgzjjask()
    return go(bgzjjPre,"兰州城","石洞")
end
function bgzjjPre()
    if not locl.id["梅超风"] then
	    quests["bgzjj"].time = os.time() - 23*60*60
	    return check_bei(bgzjjOver)
	end
    DeleteTriggerGroup("askbgz")
    create_trigger_t('askbgz1',"^(> )*你向梅超风打听有关『九阴白骨爪』的消息",'','bgzjjAsk')
    create_trigger_t('askbgz2',"^(> )*这里没有这个人。$",'','bgzjjNobody')

    SetTriggerOption("askbgz1","group","askbgz")
    SetTriggerOption("askbgz2","group","askbgz")
    questStartLog(quests["bgzjj"].name)
	exe('askk mei chaofeng about 九阴白骨爪')
end
function bgzjjAskagain()
    EnableTriggerGroup("askbgz",true)
    exe('ask mei chaofeng about 九阴白骨爪')
end
function bgzjjAsk()
    EnableTriggerGroup("askbgz",false)
	DeleteTriggerGroup("bgzjj")
	--梅超风说：“姑娘你先帮我找来骷髅头吧！”
	create_trigger_t('bgzjj1',"^(> )*但是很显然的，梅超风现在的状况没有办法给你任何答覆。",'','bgzjjwait')
	create_trigger_t('bgzjj2',"^(> )*梅超风对你说道：(练习九阴白骨爪必须夜深人静时分|嗯？你不是刚来请教过我吗？还是再努力段时间吧！)",'','bgzjjFail')
	create_trigger_t('bgzjj3','^(> )*(你摇了摇头，道：“好像还是很困难的|你觉得有点什么不对劲, 可是你却说不上来)','','bgzjjContinue')
	create_trigger_t('bgzjj4',"^(> )*你突然捕捉住交手瞬间的一幕，渐渐领悟出九阴白骨爪的真谛。",'','bgzjjSucc')
	create_trigger_t('bgzjj5',"^(> )*梅超风说：“\\D*你先帮我找来骷髅头吧！”",'','checkKulouain')
    create_trigger_t('bgzjj6',"^(> )*梅超风(对你说道：梅超风正忙着呢。|说道：「梅超风正忙着呢。」)",'','bgzjjwait')

	SetTriggerOption("bgzjj1","group","bgzjj")
    SetTriggerOption("bgzjj2","group","bgzjj")
	SetTriggerOption("bgzjj3","group","bgzjj")
	SetTriggerOption("bgzjj4","group","bgzjj")
	SetTriggerOption("bgzjj5","group","bgzjj")
	SetTriggerOption("bgzjj6","group","bgzjj")	
end
function bgzjjwait()
    EnableTriggerGroup("bgzjj",false)
   	return check_bei(bgzjjAskagain,1)
end
function bgzjjSucc()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].auto = 2
    questSucLog(quests["bgzjj"].name)
	return check_bei(bgzjjOver)
end
function bgzjjContinue()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].time = os.time()
	
	return check_bei(bgzjjOver)
end
function bgzjjFail()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].time = os.time() - 22*60*60
	
	return check_bei(bgzjjOver)
end
function bgzjjNobody()
    EnableTriggerGroup("askbgz",false)
	quests["bgzjj"].time = os.time() - 23*60*60
	return check_bei(bgzjjOver)
end
function bgzjjOver()
    EnableTriggerGroup("bgzjj",false)
	DeleteTriggerGroup("bgzjj")
	DeleteTriggerGroup("askbgz")
	SetVariable("timebgzjj",quests["bgzjj"].time)
	SetVariable("autobgzjj",quests["bgzjj"].auto)
	CloseLog()
    return go(cunkulou,"扬州城","杂货铺")
end
function cunkulou()
    exe("cun tou")
    return check_bei(checkQuestOver)
end