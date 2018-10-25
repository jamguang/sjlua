quests = quests or {}
quests["ruying"] = {}
quests["ruying"].auto = 0
quests["ruying"].name = "��Ӱ�����Ⱦ���"

questTongji = questTongji or {}
questTongji["ruying"] = "ruyingTongji"

questCal = questCal or {}
questCal["ruying"] = "ruyingCal"

questList = questList or {}
questList["ruying"] = function() if score.party and score.party=="������" then return "��Ӱ�����Ⱦ���" else return false end end


function ruyingCal()
    if score.party and score.party=="������" and GetVariable("autoruying") and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 then
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
			        checkQuestNote("��Ӱ�����Ⱦ���",l_time)
			    end
	        end
	        return false
	    end
    end
end
function ruyingTongji()
    if GetVariable("autoruying") and quests["ruying"] and quests["ruying"].auto == 1 and quests["ruying"].time and score.party=="������" and skills["ruying-suixingtui"] and skills["ruying-suixingtui"].lvl>450 then
	    local l_time = 24*60*60 - (os.time() - quests["ruying"].time)
	    checkQuestNote("��Ӱ�����Ⱦ���",l_time)
	end
end
function questRuying()
   return go(ruyingPre,"��ɽ����","������")
end
function ruyingPre()
    if not locl.id["������ʦ"] then
	   quests["ruying"].time = os.time() - 20*60*60
	   return check_bei(ruyingOver)
	end
    DeleteTriggerGroup("ruyingAsk")
    create_trigger_t('ruyingAsk1',"^(> )*��������ʦ�����йء���Ӱ�����Ⱦ���������Ϣ",'','ruyingAsk')
    create_trigger_t('ruyingAsk2',"^(> )*����û������ˡ�$",'','ruyingNobody')
    SetTriggerOption("ruyingAsk1","group","ruyingAsk")
    SetTriggerOption("ruyingAsk2","group","ruyingAsk")
	questStartLog(quests["ruying"].name)
	exe('ask fangsheng about ��Ӱ�����Ⱦ���')
end
function ruyingAsk()
    EnableTriggerGroup("ruyingAsk",false)
	DeleteTriggerGroup("ruyingAsk")
	DeleteTriggerGroup("ruying")
	create_trigger_t('ruying1',"^(> )*������ʦ(����|)˵����(\\D*)�������ض���������̫Ƶ���ˣ������Ŭ����",'','ruyingFail')
	create_trigger_t('ruying2','^(> )*������ʦ(����|)˵����(��|)��Ӱ�����ȴӲ������ˣ���Ҫ�ú���ϰ��','','ruyingCan')
	SetTriggerOption("ruying1","group","ruying")
    SetTriggerOption("ruying2","group","ruying")
end
function ruyingCan()
    EnableTriggerGroup("ruying",false)
	DeleteTriggerGroup("ruying")
	DeleteTriggerGroup("ruyingCan")
	create_trigger_t('ruyingCan1',"^(> )*�˵����������°����õ���Ҫ�أ���Ͳ���",'','ruyingFail')
	create_trigger_t('ruyingCan2','^(> )*�ǳ��ź�,������Ӱ������ʧ��','','ruyingContinue')
	create_trigger_t('ruyingCan3','^(> )*��� "action" �趨Ϊ "��Ӱ�����Ⱦ���" �ɹ���ɡ�','','ruyingSucc')
	SetTriggerOption("ruyingCan1","group","ruyingCan")
    SetTriggerOption("ruyingCan2","group","ruyingCan")
	SetTriggerOption("ruyingCan3","group","ruyingCan")
	return check_bei(ruyingCanchan,1)
end
function ruyingCanchan()
	exe('canchan ��Ӱ�����Ⱦ���')
	exe('alias action ��Ӱ�����Ⱦ���')
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