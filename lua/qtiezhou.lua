quests = quests or {}
quests["tiezhou"] = {}
quests["tiezhou"].auto = 0
quests["tiezhou"].name = "�����ȹ�"

questTongji = questTongji or {}
questTongji["tiezhou"] = "tiezhouTongji"

questCal = questCal or {}
questCal["tiezhou"] = "tiezhouCal"

questList = questList or {}
questList["tiezhou"] = function() if score.party and score.party=="������" then return quests["tiezhou"].name else return false end end


function tiezhouCal()
    if score.party and score.party=="������" and GetVariable("autotiezhou") and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 and skills["shaolin-tantui"] and skills["shaolin-tantui"].lvl>450 then
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
   return go(tiezhouPre,"��ɽ����","֤��Ժ")
end
function tiezhouPre()
    if not locl.id["������ʦ"] then
	   quests["tiezhou"].time = os.time() - 23*60*60
	   return check_bei(tiezhouOver)
	end
    DeleteTriggerGroup("tiezhouAsk")
    create_trigger_t('tiezhouAsk1',"^(> )*����������ʦ�����йء������ȹ�������Ϣ",'','tiezhouAsk')
    create_trigger_t('tiezhouAsk2',"^(> )*����û������ˡ�$",'','tiezhouNobody')
    SetTriggerOption("tiezhouAsk1","group","tiezhouAsk")
    SetTriggerOption("tiezhouAsk2","group","tiezhouAsk")
	questStartLog(quests["tiezhou"].name)
	exe('ask xuansheng dashi about �����ȹ�')
end
function tiezhouAsk()
    EnableTriggerGroup("tiezhouAsk",false)
	DeleteTriggerGroup("tiezhouAsk")
	DeleteTriggerGroup("tiezhou")
	create_trigger_t('tiezhou1',"^(> )*������ʦ(����|)˵��������˵�ڿ��޳����Ǳ��ݣ���������̫Ƶ���ˣ������߻���ħ����",'','tiezhouFail')
	create_trigger_t('tiezhou2','^(> )*������ʦ˵���������������ϰ�˼��ܣ�����ȥ���߰����ô�','','tiezhouLuohan')
	SetTriggerOption("tiezhou1","group","tiezhou")
    SetTriggerOption("tiezhou2","group","tiezhou")
end
function tiezhouLuohan()
    EnableTriggerGroup("tiezhou",false)
	DeleteTriggerGroup("tiezhou")
	return go(tiezhouLuoAsk,"��ɽ����","�������߲�")
end
function tiezhouLuoAsk()
    if not locl.id["����"] then
	   quests["tiezhou"].time = os.time() - 23*60*60
	   return check_bei(tiezhouOver)
	end
	DeleteTriggerGroup("tiezhouAsk")
	create_trigger_t('tiezhouAsk1',"^(> )*����(����|)˵�������˵������ְ�����ר���ȷ�����",'','tiezhouFail')
	create_trigger_t('tiezhouAsk2','^(> )*����(����|)˵�������ã���Ȼ��ʦ������','','tiezhouCan')
	SetTriggerOption("tiezhouAsk1","group","tiezhouAsk")
    SetTriggerOption("tiezhouAsk2","group","tiezhouAsk")
	exe('ask chengling luohan about �����ȹ�')
end
function tiezhouCan()
    EnableTriggerGroup("tiezhouAsk",false)
	DeleteTriggerGroup("tiezhouAsk")
	DeleteTriggerGroup("tiezhouCan")
	create_trigger_t('tiezhouCan1',"^(> )*������������˲��������������������㣿",'','tiezhouFail')
	create_trigger_t('tiezhouCan2','^(> )*������Ӱ�����ȵ����㹦ʧ�ܣ�','','tiezhouContinue')
	create_trigger_t('tiezhouCan3','^(> )*�㹧ϲ�㣬����ǧ�����գ�����������Ӱ�����ȵ����㹦������','','tiezhouSucc')
	create_trigger_t('tiezhouCan4','^(> )*��� "action" �趨Ϊ "���㹦" �ɹ���ɡ�','','tiezhouSucc')
	SetTriggerOption("tiezhouCan1","group","tiezhouCan")
    SetTriggerOption("tiezhouCan2","group","tiezhouCan")
	SetTriggerOption("tiezhouCan3","group","tiezhouCan")
	SetTriggerOption("tiezhouCan4","group","tiezhouCan")
	return check_bei(tiezhouCanchan,1)
end
function tiezhouCanchan()
	exe('canchan ���㹦')
	exe('alias action ���㹦')
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