quests = quests or {}
quests["qianshou"] = {}
quests["qianshou"].auto = 0
quests["qianshou"].name = "如来千叶手绝技"

questTongji = questTongji or {}
questTongji["qianshou"] = "qianshouTongji"

questCal = questCal or {}
questCal["qianshou"] = "qianshouCal"

questList = questList or {}
questList["qianshou"] = function() if score.party and score.party=="少林派" then return quests["qianshou"].name else return false end end


function qianshouCal()
    if score.party and score.party=="少林派" and GetVariable("autoqianshou") and skills["qianye-shou"] and skills["qianye-shou"].lvl>450 then
        if GetVariable("timeqianshou") then
		    quests["qianshou"].time=tonumber(GetVariable("timeqianshou"))
	    end
	    if GetVariable("autoqianshou") then
		    quests["qianshou"].auto=tonumber(GetVariable("autoqianshou"))
	    end
	    if quests["qianshou"].time==nil or os.time()-quests["qianshou"].time > 24*60*60 then
	        quests["qianshou"].time = os.time() - 12*60*60
		    SetVariable("timeqianshou",quests["qianshou"].time)
	        if quests["qianshou"].auto==nil or quests["qianshou"].auto == 0 then
	            quests["qianshou"].auto = 1
	        end
	        if quests["qianshou"].auto == 1 then
		        exe('pray pearl')
		        return "questQianshou"
	        end
	    else
	        if quests["qianshou"].auto == 1 and quests["qianshou"].time then
	            local l_time = 24*60*60 - (os.time() - quests["qianshou"].time)
			    if l_time < 0 or l_time * math.random() < 1800 then
			        checkQuestNote(quests["qianshou"].name,l_time)
			    end
	        end
	        return false
	    end
    end
end
function qianshouTongji()
    if GetVariable("autoqianshou") and quests["qianshou"] and quests["qianshou"].auto == 1 and quests["qianshou"].time then
	    local l_time = 24*60*60 - (os.time() - quests["qianshou"].time)
	    checkQuestNote(quests["qianshou"].name,l_time)
	end
end
function questQianshou()
   return go(qianshouPre,"嵩山少林","般若堂一部")
end
function qianshouPre()
    if not locl.id["澄心"] then
	   quests["qianshou"].time = os.time() - 23*60*60
	   return check_bei(qianshouOver)
	end
    DeleteTriggerGroup("qianshouAsk")
    create_trigger_t('qianshouAsk1',"^(> )*你向澄心打听有关『如来千叶手绝技』的消息",'','qianshouAsk')
    create_trigger_t('qianshouAsk2',"^(> )*这里没有这个人。$",'','qianshouNobody')
    SetTriggerOption("qianshouAsk1","group","qianshouAsk")
    SetTriggerOption("qianshouAsk2","group","qianshouAsk")
	questStartLog(quests["qianshou"].name)
	exe('ask chengxin luohan about 如来千叶手绝技')
end
function qianshouAsk()
    EnableTriggerGroup("qianshouAsk",false)
	DeleteTriggerGroup("qianshouAsk")
	DeleteTriggerGroup("qianshou")
	create_trigger_t('qianshou1',"^(> )*澄心(对你|)说道：(\\D*)少林最重顿悟，你来的太频繁了，请继续努力！",'','qianshouFail')
	create_trigger_t('qianshou2','^(> )*澄心(对你|)说道：(|「)如来千叶手从不弱于人！','','qianshouCan')
	SetTriggerOption("qianshou1","group","qianshou")
    SetTriggerOption("qianshou2","group","qianshou")
end
function qianshouCan()
    EnableTriggerGroup("qianshou",false)
	DeleteTriggerGroup("qianshou")
	DeleteTriggerGroup("qianshouCan")
	create_trigger_t('qianshouCan1',"^(> )*你鬼鬼祟祟的来此参禅修炼不怕少林灭了你？",'','qianshouFail')
	create_trigger_t('qianshouCan2','^(> )*参悟如来千叶手绝技失败！','','qianshouContinue')
	create_trigger_t('qianshouCan3','^(> )*你把 "action" 设定为 "如来千叶手" 成功完成。','','qianshouSucc')
	create_trigger_t('qianshouCan4','^(> )*恭喜你，历经千难万险，终于领悟如来千叶手绝技。','','qianshouSucc')
	SetTriggerOption("qianshouCan1","group","qianshouCan")
    SetTriggerOption("qianshouCan2","group","qianshouCan")
	SetTriggerOption("qianshouCan3","group","qianshouCan")
	SetTriggerOption("qianshouCan4","group","qianshouCan")
	return check_bei(qianshouCanchan,1)
end
function qianshouCanchan()
	exe('canchan 如来千叶手')
	exe('alias action 如来千叶手')
end
function qianshouSucc()
    EnableTriggerGroup("qianshou",false)
	EnableTriggerGroup("qianshouCan",false)
	quests["qianshou"].time = os.time()
	quests["qianshou"].auto = 2
	questSucLog(quests["qianshou"].name)
	return check_bei(qianshouOver)
end
function qianshouContinue()
    EnableTriggerGroup("qianshou",false)
	EnableTriggerGroup("qianshouCan",false)
	quests["qianshou"].time = os.time()
	return check_bei(qianshouOver)
end
function qianshouFail()
    EnableTriggerGroup("qianshou",false)
	EnableTriggerGroup("qianshouCan",false)
	quests["qianshou"].time = os.time() - 12*60*60
	return check_bei(qianshouOver)
end
function qianshouNobody()
    EnableTriggerGroup("qianshouAsk",false)
	quests["qianshou"].time = os.time() - 18*60*60
	return check_bei(qianshouOver)
end
function qianshouOver()
    DeleteTriggerGroup("qianshouAsk")
	DeleteTriggerGroup("qianshou")
	DeleteTriggerGroup("qianshouCan")
	SetVariable("timeqianshou",quests["qianshou"].time)
	SetVariable("autoqianshou",quests["qianshou"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end