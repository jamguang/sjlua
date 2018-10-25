quests = quests or {}
quests["shenzhao"] = {}
quests["shenzhao"].auto = 0
quests["shenzhao"].name = '���վ���'

questTongji = questTongji or {}
questTongji["shenzhao"] = "shenzhaoTongji"

questCal = questCal or {}
questCal["shenzhao"] = "shenzhaoCal"

questList = questList or {}
questList["shenzhao"] = function() if quests["lcj"]["shenzhao"] then return quests["shenzhao"].name else return false end end


function shenzhaoCal()
    if GetVariable("autoshenzhao") and quests["lcj"]["shenzhao"] then
        if GetVariable("timeshenzhao") then
		    quests["shenzhao"].time=tonumber(GetVariable("timeshenzhao"))
	    end
	    if GetVariable("autoshenzhao") then
		    quests["shenzhao"].auto=tonumber(GetVariable("autoshenzhao"))
	    end
	    if quests["shenzhao"].time==nil or os.time()-quests["shenzhao"].time > 24*60*60 then
	        quests["shenzhao"].time = os.time() - 22*60*60
		    SetVariable("timeshenzhao",quests["shenzhao"].time)
	        if quests["shenzhao"].auto==nil or quests["shenzhao"].auto == 0 then
	            quests["shenzhao"].auto = 1
	        end
	        if quests["shenzhao"].auto == 1 then
		        exe('pray pearl')
		        return "questshenzhao"
	        end
	    else
	        if quests["shenzhao"].auto == 1 and quests["shenzhao"].time then
	            local l_time = 24*60*60 - (os.time() - quests["shenzhao"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["shenzhao"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function shenzhaoTongji()
    if GetVariable("autoshenzhao") and quests["lcj"]["shenzhao"] and quests["shenzhao"] and quests["shenzhao"].auto == 1 and quests["shenzhao"].time then
	   local l_time = 24*60*60 - (os.time() - quests["shenzhao"].time)
	   checkQuestNote(quests["shenzhao"].name,l_time)
	end
end

function questshenzhao()
    return go(shenzhaoCan,"Ѫ����","Ұɽ��")
end
function shenzhaoCan()
    if locl.room~= "Ұɽ��" then
	    return check_bei(questshenzhao)
	end
    DeleteTriggerGroup("shenzhao")
	create_trigger_t('shenzhao1',"^(> )*(�㾭��������ĥ����|���Ѿ��⿪�����⣡)",'','shenzhaoSucc')
	create_trigger_t('shenzhao2','^(> )*���Ѿ������ˣ�����������','','shenzhaoFail')
	create_trigger_t('shenzhao3',"^(> )*�ǳ��ź����������վ��񹦵����ν���ʧ�ܣ�",'','shenzhaoContinue')
	create_trigger_t('shenzhao4',"^(> )*�㳤̾һ�������������˵��",'','shenzhaoContinue')
	create_trigger_t('shenzhao5',"^(> )*����δ��ɡ����Ǿ���֮������ƪ���½ڹ������ݣ�",'','shenzhaoDel')
	create_trigger_t('shenzhao6',"^(> )*����ͼ�������վ���",'','shenzhaoWait')
	SetTriggerOption("shenzhao1","group","shenzhao")
    SetTriggerOption("shenzhao2","group","shenzhao")
	SetTriggerOption("shenzhao3","group","shenzhao")
	SetTriggerOption("shenzhao4","group","shenzhao")
	SetTriggerOption("shenzhao5","group","shenzhao")
	SetTriggerOption("shenzhao6","group","shenzhao")
	questStartLog(quests["shenzhao"].name)
	return exe('canwu ���վ���')
end
function shenzhaoWait()
    wait.make(function()
	    wait.time(10)
        exe("enter")
		exe('canwu ���վ���')
	end)
end
function shenzhaoSucc()
    EnableTriggerGroup("shenzhao",false)
	quests["shenzhao"].time = os.time()
	quests["shenzhao"].auto = 2
	questSucLog(quests["shenzhao"].name)
	return check_bei(shenzhaoOver)
end
function shenzhaoDel()
    EnableTriggerGroup("shenzhao",false)
	quests["shenzhao"].time = 0
	quests["shenzhao"].auto = 0
	DeleteVariable("timeshenzhao")
	DeleteVariable("autoshenzhao")
	CloseLog()
	return check_bei(checkQuestOver)
end
function shenzhaoContinue()
    EnableTriggerGroup("shenzhao",false)
	quests["shenzhao"].time = os.time()
	return check_bei(shenzhaoOver)
end
function shenzhaoFail()
    EnableTriggerGroup("shenzhao",false)
	quests["shenzhao"].time = os.time() - 20*60*60
	return check_bei(shenzhaoOver)
end
function shenzhaoOver()
	SetVariable("timeshenzhao",quests["shenzhao"].time)
	SetVariable("autoshenzhao",quests["shenzhao"].auto)
	DeleteTriggerGroup("shenzhao")
	CloseLog()
    return check_bei(checkQuestOver)
end