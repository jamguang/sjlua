quests = quests or {}
quests["baduan"] = {}
quests["baduan"].auto = 0
quests["baduan"].name = '�˶ν�����'

questTongji = questTongji or {}
questTongji["baduan"] = "baduanTongji"

questCal = questCal or {}
questCal["baduan"] = "baduanCal"

questList = questList or {}
questList["baduan"] = function() if skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 then return quests["baduan"].name else return false end end


function baduanCal()
    if GetVariable("autobaduan") and skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 then
        if GetVariable("timebaduan") then
		    quests["baduan"].time=tonumber(GetVariable("timebaduan"))
	    end
	    if GetVariable("autobaduan") then
		    quests["baduan"].auto=tonumber(GetVariable("autobaduan"))
	    end
	    if quests["baduan"].time==nil or os.time()-quests["baduan"].time > 24*60*60 then
	        quests["baduan"].time = os.time() - 22*60*60
		    SetVariable("timebaduan",quests["baduan"].time)
	        if quests["baduan"].auto==nil or quests["baduan"].auto == 0 then
	            quests["baduan"].auto = 1
	        end
	        if quests["baduan"].auto == 1 then
		        exe('pray pearl')
		        return "questbaduan"
	        end
	    else
	        if quests["baduan"].auto == 1 and quests["baduan"].time then
	            local l_time = 24*60*60 - (os.time() - quests["baduan"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["baduan"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function baduanTongji()
    if GetVariable("autobaduan") and skills["baduan-jin"] and skills["baduan-jin"].lvl>=400 and quests["baduan"] and quests["baduan"].auto == 1 and quests["baduan"].time then
	   local l_time = 24*60*60 - (os.time() - quests["baduan"].time)
	   checkQuestNote(quests["baduan"].name,l_time)
	end
end

function questbaduan()
    return go(baduanZhu,"���ݳ�","������")
end
function baduanZhu()
    if not locl.id["����ʦ"] then
	    return go(baduanZhu,"���ݳ�","������")
	end
	exe("askk zhujian shi about ������")
    return fastSearch("���ݳ�����㳡","�Ծ�ү","baduanPre")
end
function baduanPre()
    if not locl.id["�Ծ�ү"] then
	   quests["baduan"].time = os.time() - 23*60*60
	   return check_bei(baduanOver)
	end
    DeleteTriggerGroup("baduanAsk")
    create_trigger_t('baduanAsk1',"^(> )*�����Ծ�ү�����йء��˶ν������ܡ�����Ϣ��$",'','baduanAsk')
    create_trigger_t('baduanAsk2',"^(> )*����û������ˡ�$",'','baduanNobody')
    SetTriggerOption("baduanAsk1","group","baduanAsk")
    SetTriggerOption("baduanAsk2","group","baduanAsk")
	questStartLog(quests["baduan"].name)
	exe('askk zhao jueye about �˶ν�������')
end
function baduanAsk()
    EnableTriggerGroup("baduanAsk",false)
	DeleteTriggerGroup("baduan")
	create_trigger_t('baduan1',"^(> )*�Ծ�ү(����|)˵����(|��)�ţ��㲻�Ǹ���",'','baduanFail')
	create_trigger_t('baduan2','^(> )*��ҡ��ҡͷ����','','baduanContinue')
	create_trigger_t('baduan3','^(> )*���Ѿ�ϰ��','','baduanSucc')
	create_trigger_t('baduan4',"^(> )*�Ծ�ү(����|)˵����(|��)�Ҳ�֪������˵ʲô",'','baduanRst')
	create_trigger_t('baduan5',"^(> )*�Ծ�ү����˵������ϲ���������ɾ���",'','baduanSucc')
	SetTriggerOption("baduan1","group","baduan")
    SetTriggerOption("baduan2","group","baduan")
	SetTriggerOption("baduan3","group","baduan")
	SetTriggerOption("baduan4","group","baduan")
	SetTriggerOption("baduan5","group","baduan")
end
function baduanRst()
    EnableTriggerGroup("baduan",false)
	return questbaduan()
end
function baduanSucc()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time()
	quests["baduan"].auto = 2
	questSucLog(quests["baduan"].name)
	return check_bei(baduanOver)
end
function baduanDel()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = 0
	quests["baduan"].auto = 0
	DeleteVariable("timebaduan")
	DeleteVariable("autobaduan")
	CloseLog()
	return check_bei(checkQuestOver)
end
function baduanContinue()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time()
	return check_bei(baduanOver)
end
function baduanFail()
    EnableTriggerGroup("baduan",false)
	quests["baduan"].time = os.time() - 20*60*60
	return check_bei(baduanOver)
end
function baduanNobody()
    EnableTriggerGroup("baduanAsk",false)
	quests["baduan"].time = os.time() - 23*60*60
	return check_bei(baduanOver)
end
function baduanOver()
	SetVariable("timebaduan",quests["baduan"].time)
	SetVariable("autobaduan",quests["baduan"].auto)
	DeleteTriggerGroup("baduanAsk")
	DeleteTriggerGroup("baduan")
	CloseLog()
    return check_bei(checkQuestOver)
end