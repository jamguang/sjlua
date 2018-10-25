quests = quests or {}
quests["whdmd"] = {}
quests["whdmd"].auto = 0
quests["whdmd"].name = '�廢���ŵ�'

questTongji = questTongji or {}
questTongji["whdmd"] = "whdmdTongji"

questCal = questCal or {}
questCal["whdmd"] = "whdmdCal"

questList = questList or {}
questList["whdmd"] = function() if skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 then return quests["whdmd"].name else return false end end


function whdmdCal()
    if GetVariable("autowhdmd") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 then
        if GetVariable("timewhdmd") then
		    quests["whdmd"].time=tonumber(GetVariable("timewhdmd"))
	    end
	    if GetVariable("autowhdmd") then
		    quests["whdmd"].auto=tonumber(GetVariable("autowhdmd"))
	    end
	    if quests["whdmd"].time==nil or os.time()-quests["whdmd"].time > 24*60*60 then
	        quests["whdmd"].time = os.time() - 22*60*60
		    SetVariable("timewhdmd",quests["whdmd"].time)
	        if quests["whdmd"].auto==nil or quests["whdmd"].auto == 0 then
	            quests["whdmd"].auto = 1
	        end
	        if quests["whdmd"].auto == 1 then
		        exe('pray pearl')
		        return "questwhdmd"
	        end
	    else
	        if quests["whdmd"].auto == 1 and quests["whdmd"].time then
	            local l_time = 24*60*60 - (os.time() - quests["whdmd"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["whdmd"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function whdmdTongji()
    if GetVariable("autowhdmd") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl==150 and quests["whdmd"] and quests["whdmd"].auto == 1 and quests["whdmd"].time then
	   local l_time = 24*60*60 - (os.time() - quests["whdmd"].time)
	   checkQuestNote(quests["whdmd"].name,l_time)
	end
end

function questwhdmd()
    return go(whdmdPre,"���ݳ�","���᷿")
end
function whdmdPre()
    if not locl.id["éʮ��"] then
	   quests["whdmd"].time = os.time() - 23*60*60
	   return check_bei(whdmdOver)
	end
    DeleteTriggerGroup("whdmdAsk")
    create_trigger_t('whdmdAsk1',"^(> )*����éʮ�˴����йء��廢���ŵ�������Ϣ��$",'','whdmdAsk')
    create_trigger_t('whdmdAsk2',"^(> )*����û������ˡ�$",'','whdmdNobody')
    SetTriggerOption("whdmdAsk1","group","whdmdAsk")
    SetTriggerOption("whdmdAsk2","group","whdmdAsk")
	questStartLog(quests["whdmd"].name)
	exe('ask mao shiba about �廢���ŵ�')
	exe('alias action �廢���ŵ�')
end
function whdmdAsk()
    EnableTriggerGroup("whdmdAsk",false)
	DeleteTriggerGroup("whdmd")
	create_trigger_t('whdmd1',"^(> )*éʮ��(����|)˵����(|��)�������ڼ䲻��̫Ƶ���ش��㣬��һ����������",'','whdmdFail')
	create_trigger_t('whdmd2','^(> )*éʮ��(����|)˵����(|��)���������ڼ䣬���鲻�ã���һ��������','','whdmdContinue')
	create_trigger_t('whdmd3','^(> )*��� "action" �趨Ϊ "�廢���ŵ�" �ɹ���ɡ�','','whdmdSucc')
	create_trigger_t('whdmd4',"^(> )*����˵��������̫���ˣ���Ը�������",'','whdmdDel')
	create_trigger_t('whdmd5',"^(> )*������éʮ�˵Ļ������л�Ȼ���ʣ��廢���ŵ������������һ�㣡",'','whdmdSucc')
	SetTriggerOption("whdmd1","group","whdmd")
    SetTriggerOption("whdmd2","group","whdmd")
	SetTriggerOption("whdmd3","group","whdmd")
	SetTriggerOption("whdmd4","group","whdmd")
	SetTriggerOption("whdmd5","group","whdmd")
end
function whdmdSucc()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time()
	quests["whdmd"].auto = 2
	questSucLog(quests["whdmd"].name)
	return check_bei(whdmdOver)
end
function whdmdDel()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = 0
	quests["whdmd"].auto = 0
	DeleteVariable("timewhdmd")
	DeleteVariable("autowhdmd")
	CloseLog()
	return check_bei(checkQuestOver)
end
function whdmdContinue()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time()
	return check_bei(whdmdOver)
end
function whdmdFail()
    EnableTriggerGroup("whdmd",false)
	quests["whdmd"].time = os.time() - 20*60*60
	return check_bei(whdmdOver)
end
function whdmdNobody()
    EnableTriggerGroup("whdmdAsk",false)
	quests["whdmd"].time = os.time() - 23*60*60
	return check_bei(whdmdOver)
end
function whdmdOver()
	SetVariable("timewhdmd",quests["whdmd"].time)
	SetVariable("autowhdmd",quests["whdmd"].auto)
	DeleteTriggerGroup("whdmdAsk")
	DeleteTriggerGroup("whdmd")
	CloseLog()
    return check_bei(checkQuestOver)
end