quests = quests or {}
quests["tiejiao"] = {}
quests["tiejiao"].auto = 0
quests["tiejiao"].name = '�����ɾ���'

questTongji = questTongji or {}
questTongji["tiejiao"] = "tiejiaoTongji"

questCal = questCal or {}
questCal["tiejiao"] = "tiejiaoCal"

questList = questList or {}
questList["tiejiao"] = function() if skills["yuanyang-lianhuantui"] and skills["yuanyang-lianhuantui"].lvl>=200 then return quests["tiejiao"].name else return false end end


function tiejiaoCal()
    if GetVariable("autotiejiao") and skills["yuanyang-lianhuantui"] and skills["yuanyang-lianhuantui"].lvl>=200 then
        if GetVariable("timetiejiao") then
		    quests["tiejiao"].time=tonumber(GetVariable("timetiejiao"))
	    end
	    if GetVariable("autotiejiao") then
		    quests["tiejiao"].auto=tonumber(GetVariable("autotiejiao"))
	    end
	    if quests["tiejiao"].time==nil or os.time()-quests["tiejiao"].time > 24*60*60 then
	        quests["tiejiao"].time = os.time() - 22*60*60
		    SetVariable("timetiejiao",quests["tiejiao"].time)
	        if quests["tiejiao"].auto==nil or quests["tiejiao"].auto == 0 then
	            quests["tiejiao"].auto = 1
	        end
	        if quests["tiejiao"].auto == 1 then
		        exe('pray pearl')
		        return "questtiejiao"
	        end
	    else
	        if quests["tiejiao"].auto == 1 and quests["tiejiao"].time then
	            local l_time = 24*60*60 - (os.time() - quests["tiejiao"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["tiejiao"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function tiejiaoTongji()
    if GetVariable("autotiejiao") and skills["yuanyang-lianhuantui"] and skills["yuanyang-lianhuantui"].lvl>=200 and quests["tiejiao"] and quests["tiejiao"].auto == 1 and quests["tiejiao"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tiejiao"].time)
	   checkQuestNote(quests["tiejiao"].name,l_time)
	end
end

function questtiejiao()
    return go(tiejiaoPre,"ȫ��","������")
end
function tiejiaoPre()
    if not locl.id["����һ"] then
	   quests["tiejiao"].time = os.time() - 23*60*60
	   return check_bei(tiejiaoOver)
	end
    DeleteTriggerGroup("tiejiaoAsk")
    create_trigger_t('tiejiaoAsk1',"^(> )*��������һ�����йء����ž���������Ϣ��$",'','tiejiaoAsk')
    create_trigger_t('tiejiaoAsk2',"^(> )*����û������ˡ�$",'','tiejiaoNobody')
    SetTriggerOption("tiejiaoAsk1","group","tiejiaoAsk")
    SetTriggerOption("tiejiaoAsk2","group","tiejiaoAsk")
	questStartLog(quests["tiejiao"].name)
	exe('askk wang chuyi about ���ž���')
end
function tiejiaoAsk()
    EnableTriggerGroup("tiejiaoAsk",false)
	DeleteTriggerGroup("tiejiao")
	create_trigger_t('tiejiao1',"^(> )*����һ(����|)˵����(|��)������̫Ƶ����",'','tiejiaoFail')
	create_trigger_t('tiejiao2','^(> )*����������һ��ָ�㣬���Ƕ�����ԧ����','','tiejiaoContinue')
	create_trigger_t('tiejiao3','^(> )*���Ѿ�ϰ��','','tiejiaoSucc')
	create_trigger_t('tiejiao4',"^(> )*����һ(����|)˵����(|��)�������ԧ���Ȳ���",'','tiejiaoDel')
	create_trigger_t('tiejiao5',"^(> )*����һ����˵������ϲ���������ɾ���",'','tiejiaoSucc')
	SetTriggerOption("tiejiao1","group","tiejiao")
    SetTriggerOption("tiejiao2","group","tiejiao")
	SetTriggerOption("tiejiao3","group","tiejiao")
	SetTriggerOption("tiejiao4","group","tiejiao")
	SetTriggerOption("tiejiao5","group","tiejiao")
end
function tiejiaoSucc()
    EnableTriggerGroup("tiejiao",false)
	quests["tiejiao"].time = os.time()
	quests["tiejiao"].auto = 2
	questSucLog(quests["tiejiao"].name)
	return check_bei(tiejiaoOver)
end
function tiejiaoDel()
    EnableTriggerGroup("tiejiao",false)
	quests["tiejiao"].time = 0
	quests["tiejiao"].auto = 0
	DeleteVariable("timetiejiao")
	DeleteVariable("autotiejiao")
	CloseLog()
	return check_bei(checkQuestOver)
end
function tiejiaoContinue()
    EnableTriggerGroup("tiejiao",false)
	quests["tiejiao"].time = os.time()
	return check_bei(tiejiaoOver)
end
function tiejiaoFail()
    EnableTriggerGroup("tiejiao",false)
	quests["tiejiao"].time = os.time() - 20*60*60
	return check_bei(tiejiaoOver)
end
function tiejiaoNobody()
    EnableTriggerGroup("tiejiaoAsk",false)
	quests["tiejiao"].time = os.time() - 23*60*60
	return check_bei(tiejiaoOver)
end
function tiejiaoOver()
	SetVariable("timetiejiao",quests["tiejiao"].time)
	SetVariable("autotiejiao",quests["tiejiao"].auto)
	DeleteTriggerGroup("tiejiaoAsk")
	DeleteTriggerGroup("tiejiao")
	CloseLog()
    return check_bei(checkQuestOver)
end