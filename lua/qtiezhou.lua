quests = quests or {}
quests["tiezhou"] = {}
quests["tiezhou"].auto = 0
quests["tiezhou"].name = "铁帚腿功"

questTongji = questTongji or {}
questTongji["tiezhou"] = "tiezhouTongji"

questCal = questCal or {}
questCal["tiezhou"] = "tiezhouCal"

questList = questList or {}
questList["tiezhou"] = function() if score.party and score.party=="少林派" then return quests["tiezhou"].name else return false end end


function tiezhouCal()
    if score.party and score.party=="少林派" and GetVariable("autotiezhou") and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 and skills["shaolin-tantui"] and skills["shaolin-tantui"].lvl>450 then
        if GetVariable("timetiezhou") then
		    quests["tiezhou"].time=tonumber(GetVariable("timetiezhou"))
	    end
	    if GetVariable("autotiezhou") then
		    quests["tiezhou"].auto=tonumber(GetVariable("autotiezhou"))
	    end
	    if quests["tiezhou"].time==nil or os.time()-quests["tiezhou"].time > 24*60*60 then
	        quests["tiezhou"].time = os.time() - 12*60*60
		    SetVariable("timetiezhou",quests["tiezhou"].time)
	        if quests["tiezhou"].auto==nil or quests["tiezhou"].auto == 0 then
	            quests["tiezhou"].auto = 1
	        end
	        if quests["tiezhou"].auto == 1 then
		        exe('pray pearl')
		        return "questTiezhou"
	        end
	    else
	        if quests["tiezhou"].auto == 1 and quests["tiezhou"].time then
	            local l_time = 24*60*60 - (os.time() - quests["tiezhou"].time)
			    if l_time < 0 or l_time * math.random() < 1800 then
			        checkQuestNote(quests["tiezhou"].name,l_time)
			    end
	        end
	        return false
	    end
    end
end
function tiezhouTongji()
    if GetVariable("autotiezhou") and quests["tiezhou"] and quests["tiezhou"].auto == 1 and quests["tiezhou"].time then
	    local l_time = 24*60*60 - (os.time() - quests["tiezhou"].time)
	    checkQuestNote(quests["tiezhou"].name,l_time)
	end
end
function questTiezhou()
   return go(tiezhouPre,"嵩山少林","证道院")
end
function tiezhouPre()
    if not locl.id["玄生大师"] then
	   quests["tiezhou"].time = os.time() - 23*60*60
	   return check_bei(tiezhouOver)
	end
    DeleteTriggerGroup("tiezhouAsk")
    create_trigger_t('tiezhouAsk1',"^(> )*你向玄生大师打听有关『铁帚腿功』的消息",'','tiezhouAsk')
    create_trigger_t('tiezhouAsk2',"^(> )*这里没有这个人。$",'','tiezhouNobody')
    SetTriggerOption("tiezhouAsk1","group","tiezhouAsk")
    SetTriggerOption("tiezhouAsk2","group","tiezhouAsk")
	questStartLog(quests["tiezhou"].name)
	exe('ask xuansheng dashi about 铁帚腿功')
end
function tiezhouAsk()
    EnableTriggerGroup("tiezhouAsk",false)
	DeleteTriggerGroup("tiezhouAsk")
	DeleteTriggerGroup("tiezhou")
	create_trigger_t('tiezhou1',"^(> )*玄生大师(对你|)说道：「虽说勤快修持乃是本份，但你来的太频繁了，容易走火入魔！」",'','tiezhouFail')
	create_trigger_t('tiezhou2','^(> )*玄生大师说道：「你如果想修习此技能，还是去第七般若堂处','','tiezhouLuohan')
	SetTriggerOption("tiezhou1","group","tiezhou")
    SetTriggerOption("tiezhou2","group","tiezhou")
end
function tiezhouLuohan()
    EnableTriggerGroup("tiezhou",false)
	DeleteTriggerGroup("tiezhou")
	return go(tiezhouLuoAsk,"嵩山少林","般若堂七部")
end
function tiezhouLuoAsk()
    if not locl.id["澄灵"] then
	   quests["tiezhou"].time = os.time() - 23*60*60
	   return check_bei(tiezhouOver)
	end
	DeleteTriggerGroup("tiezhouAsk")
	create_trigger_t('tiezhouAsk1',"^(> )*澄灵(对你|)说道：「此地乃少林般若堂专研腿法所在",'','tiezhouFail')
	create_trigger_t('tiezhouAsk2','^(> )*澄灵(对你|)说道：「好，既然有师叔所命','','tiezhouCan')
	SetTriggerOption("tiezhouAsk1","group","tiezhouAsk")
    SetTriggerOption("tiezhouAsk2","group","tiezhouAsk")
	exe('ask chengling luohan about 铁帚腿功')
end
function tiezhouCan()
    EnableTriggerGroup("tiezhouAsk",false)
	DeleteTriggerGroup("tiezhouAsk")
	DeleteTriggerGroup("tiezhouCan")
	create_trigger_t('tiezhouCan1',"^(> )*你鬼鬼祟祟的来此参禅修炼不怕少林灭了你？",'','tiezhouFail')
	create_trigger_t('tiezhouCan2','^(> )*参悟如影随形腿的铁帚功失败！','','tiezhouContinue')
	create_trigger_t('tiezhouCan3','^(> )*你恭喜你，历经千难万险，终于领悟如影随形腿的铁帚功绝技。','','tiezhouSucc')
	create_trigger_t('tiezhouCan4','^(> )*你把 "action" 设定为 "铁帚功" 成功完成。','','tiezhouSucc')
	SetTriggerOption("tiezhouCan1","group","tiezhouCan")
    SetTriggerOption("tiezhouCan2","group","tiezhouCan")
	SetTriggerOption("tiezhouCan3","group","tiezhouCan")
	SetTriggerOption("tiezhouCan4","group","tiezhouCan")
	return check_bei(tiezhouCanchan,1)
end
function tiezhouCanchan()
	exe('canchan 铁帚功')
	exe('alias action 铁帚功')
end
function tiezhouSucc()
    EnableTriggerGroup("tiezhou",false)
	EnableTriggerGroup("tiezhouAsk",false)
	EnableTriggerGroup("tiezhouCan",false)
	quests["tiezhou"].time = os.time()
	quests["tiezhou"].auto = 2
	questSucLog(quests["tiezhou"].name)
	return check_bei(tiezhouOver)
end
function tiezhouContinue()
    EnableTriggerGroup("tiezhou",false)
	EnableTriggerGroup("tiezhouAsk",false)
	EnableTriggerGroup("tiezhouCan",false)
	quests["tiezhou"].time = os.time()
	return check_bei(tiezhouOver)
end
function tiezhouFail()
    EnableTriggerGroup("tiezhou",false)
	EnableTriggerGroup("tiezhouAsk",false)
	EnableTriggerGroup("tiezhouCan",false)
	quests["tiezhou"].time = os.time() - 12*60*60
	return check_bei(tiezhouOver)
end
function tiezhouNobody()
    EnableTriggerGroup("tiezhouAsk",false)
	quests["tiezhou"].time = os.time() - 18*60*60
	return check_bei(tiezhouOver)
end
function tiezhouOver()
    DeleteTriggerGroup("tiezhouAsk")
	DeleteTriggerGroup("tiezhou")
	DeleteTriggerGroup("tiezhouCan")
	SetVariable("timetiezhou",quests["tiezhou"].time)
	SetVariable("autotiezhou",quests["tiezhou"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end