quests = quests or {}
quests["ruying"] = {}
quests["ruying"].auto = 0
quests["ruying"].name = "如影随形腿绝技"

questTongji = questTongji or {}
questTongji["ruying"] = "ruyingTongji"

questCal = questCal or {}
questCal["ruying"] = "ruyingCal"

questList = questList or {}
questList["ruying"] = function() if score.party and score.party=="少林派" then return "如影随形腿绝技" else return false end end


function ruyingCal()
    if score.party and score.party=="少林派" and GetVariable("autoruying") and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 then
        if GetVariable("timeruying") then
		    quests["ruying"].time=tonumber(GetVariable("timeruying"))
	    end
	    if GetVariable("autoruying") then
		    quests["ruying"].auto=tonumber(GetVariable("autoruying"))
	    end
	    if quests["ruying"].time==nil or os.time()-quests["ruying"].time > 24*60*60 then
	        quests["ruying"].time = os.time() - 22*60*60
		    SetVariable("timeruying",quests["ruying"].time)
	        if quests["ruying"].auto==nil or quests["ruying"].auto == 0 then
	            quests["ruying"].auto = 1
	        end
	        if quests["ruying"].auto == 1 then
		        exe('pray pearl')
		        return "questRuying"
	        end
	    else
	        if quests["ruying"].auto == 1 and quests["ruying"].time then
	            local l_time = 24*60*60 - (os.time() - quests["ruying"].time)
			    if l_time < 0 or l_time * math.random() < 1800 then
			        checkQuestNote("如影随形腿绝技",l_time)
			    end
	        end
	        return false
	    end
    end
end
function ruyingTongji()
    if GetVariable("autoruying") and quests["ruying"] and quests["ruying"].auto == 1 and quests["ruying"].time and score.party=="少林派" and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 then
	    local l_time = 24*60*60 - (os.time() - quests["ruying"].time)
	    checkQuestNote("如影随形腿绝技",l_time)
	end
end
function questRuying()
   return go(ruyingPre,"嵩山少林","心禅堂")
end
function ruyingPre()
    if not locl.id["方生大师"] then
	   quests["ruying"].time = os.time() - 20*60*60
	   return check_bei(ruyingOver)
	end
    DeleteTriggerGroup("ruyingAsk")
    create_trigger_t('ruyingAsk1',"^(> )*你向方生大师打听有关『如影随形腿绝技』的消息",'','ruyingAsk')
    create_trigger_t('ruyingAsk2',"^(> )*这里没有这个人。$",'','ruyingNobody')
    SetTriggerOption("ruyingAsk1","group","ruyingAsk")
    SetTriggerOption("ruyingAsk2","group","ruyingAsk")
	questStartLog(quests["ruying"].name)
	exe('ask fangsheng about 如影随形腿绝技')
end
function ruyingAsk()
    EnableTriggerGroup("ruyingAsk",false)
	DeleteTriggerGroup("ruyingAsk")
	DeleteTriggerGroup("ruying")
	create_trigger_t('ruying1',"^(> )*方生大师(对你|)说道：(\\D*)少林最重顿悟，你来的太频繁了，请继续努力！",'','ruyingFail')
	create_trigger_t('ruying2','^(> )*方生大师(对你|)说道：(「|)如影随形腿从不弱于人！你要好好修习。','','ruyingCan')
	SetTriggerOption("ruying1","group","ruying")
    SetTriggerOption("ruying2","group","ruying")
end
function ruyingCan()
    EnableTriggerGroup("ruying",false)
	DeleteTriggerGroup("ruying")
	DeleteTriggerGroup("ruyingCan")
	create_trigger_t('ruyingCan1',"^(> )*此地乃是少林寺般若堂刀法要地，你就不怕",'','ruyingFail')
	create_trigger_t('ruyingCan2','^(> )*非常遗憾,解密如影随形腿失败','','ruyingContinue')
	create_trigger_t('ruyingCan3','^(> )*你把 "action" 设定为 "如影随形腿绝技" 成功完成。','','ruyingSucc')
	SetTriggerOption("ruyingCan1","group","ruyingCan")
    SetTriggerOption("ruyingCan2","group","ruyingCan")
	SetTriggerOption("ruyingCan3","group","ruyingCan")
	return check_bei(ruyingCanchan,1)
end
function ruyingCanchan()
	exe('canchan 如影随形腿绝技')
	exe('alias action 如影随形腿绝技')
end
function ruyingSucc()
    EnableTriggerGroup("ruying",false)
	EnableTriggerGroup("ruyingCan",false)
	quests["ruying"].time = os.time()
	quests["ruying"].auto = 2
	questSucLog(quests["ruying"].name)
	return check_bei(ruyingOver)
end
function ruyingContinue()
    EnableTriggerGroup("ruying",false)
	EnableTriggerGroup("ruyingCan",false)
	quests["ruying"].time = os.time()
	return check_bei(ruyingOver)
end
function ruyingFail()
    EnableTriggerGroup("ruying",false)
	EnableTriggerGroup("ruyingCan",false)
	quests["ruying"].time = os.time() - 12*60*60
	return check_bei(ruyingOver)
end
function ruyingNobody()
    EnableTriggerGroup("ruyingAsk",false)
	quests["ruying"].time = os.time() - 18*60*60
	return check_bei(ruyingOver)
end
function ruyingOver()
	SetVariable("timeruying",quests["ruying"].time)
	SetVariable("autoruying",quests["ruying"].auto)
	DeleteTriggerGroup("ruyingAsk")
	DeleteTriggerGroup("ruying")
	DeleteTriggerGroup("ruyingCan")
	CloseLog()
    return check_bei(checkQuestOver)
end