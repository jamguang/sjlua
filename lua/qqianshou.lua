quests = quests or {}
quests["qianshou"] = {}
quests["qianshou"].auto = 0
quests["qianshou"].name = "����ǧҶ�־���"

questTongji = questTongji or {}
questTongji["qianshou"] = "qianshouTongji"

questCal = questCal or {}
questCal["qianshou"] = "qianshouCal"

questList = questList or {}
questList["qianshou"] = function() if score.party and score.party=="������" then return quests["qianshou"].name else return false end end


function qianshouCal()
    if score.party and score.party=="������" and GetVariable("autoqianshou") and skills["qianye-shou"] and skills["qianye-shou"].lvl>450 then
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
   return go(qianshouPre,"��ɽ����","������һ��")
end
function qianshouPre()
    if not locl.id["����"] then
	   quests["qianshou"].time = os.time() - 23*60*60
	   return check_bei(qianshouOver)
	end
    DeleteTriggerGroup("qianshouAsk")
    create_trigger_t('qianshouAsk1',"^(> )*������Ĵ����йء�����ǧҶ�־���������Ϣ",'','qianshouAsk')
    create_trigger_t('qianshouAsk2',"^(> )*����û������ˡ�$",'','qianshouNobody')
    SetTriggerOption("qianshouAsk1","group","qianshouAsk")
    SetTriggerOption("qianshouAsk2","group","qianshouAsk")
	questStartLog(quests["qianshou"].name)
	exe('ask chengxin luohan about ����ǧҶ�־���')
end
function qianshouAsk()
    EnableTriggerGroup("qianshouAsk",false)
	DeleteTriggerGroup("qianshouAsk")
	DeleteTriggerGroup("qianshou")
	create_trigger_t('qianshou1',"^(> )*����(����|)˵����(\\D*)�������ض���������̫Ƶ���ˣ������Ŭ����",'','qianshouFail')
	create_trigger_t('qianshou2','^(> )*����(����|)˵����(|��)����ǧҶ�ִӲ������ˣ�','','qianshouCan')
	SetTriggerOption("qianshou1","group","qianshou")
    SetTriggerOption("qianshou2","group","qianshou")
end
function qianshouCan()
    EnableTriggerGroup("qianshou",false)
	DeleteTriggerGroup("qianshou")
	DeleteTriggerGroup("qianshouCan")
	create_trigger_t('qianshouCan1',"^(> )*������������˲��������������������㣿",'','qianshouFail')
	create_trigger_t('qianshouCan2','^(> )*��������ǧҶ�־���ʧ�ܣ�','','qianshouContinue')
	create_trigger_t('qianshouCan3','^(> )*��� "action" �趨Ϊ "����ǧҶ��" �ɹ���ɡ�','','qianshouSucc')
	create_trigger_t('qianshouCan4','^(> )*��ϲ�㣬����ǧ�����գ�������������ǧҶ�־�����','','qianshouSucc')
	SetTriggerOption("qianshouCan1","group","qianshouCan")
    SetTriggerOption("qianshouCan2","group","qianshouCan")
	SetTriggerOption("qianshouCan3","group","qianshouCan")
	SetTriggerOption("qianshouCan4","group","qianshouCan")
	return check_bei(qianshouCanchan,1)
end
function qianshouCanchan()
	exe('canchan ����ǧҶ��')
	exe('alias action ����ǧҶ��')
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