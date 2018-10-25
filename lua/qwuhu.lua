quests = quests or {}
quests["wuhu"] = {}
quests["wuhu"].auto = 0
quests["wuhu"].name = '�廢����'

questTongji = questTongji or {}
questTongji["wuhu"] = "wuhuTongji"

questCal = questCal or {}
questCal["wuhu"] = "wuhuCal"

questList = questList or {}
questList["wuhu"] = function() if skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl>=300 then return quests["wuhu"].name else return false end end


function wuhuCal()
    if GetVariable("autowuhu") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl>=300 then
        if GetVariable("timewuhu") then
		    quests["wuhu"].time=tonumber(GetVariable("timewuhu"))
	    end
	    if GetVariable("autowuhu") then
		    quests["wuhu"].auto=tonumber(GetVariable("autowuhu"))
	    end
	    if quests["wuhu"].time==nil or os.time()-quests["wuhu"].time > 24*60*60 then
	        quests["wuhu"].time = os.time() - 22*60*60
		    SetVariable("timewuhu",quests["wuhu"].time)
	        if quests["wuhu"].auto==nil or quests["wuhu"].auto == 0 then
	            quests["wuhu"].auto = 1
	        end
	        if quests["wuhu"].auto == 1 then
		        exe('pray pearl')
		        return "questwuhu"
	        end
	    else
	        if quests["wuhu"].auto == 1 and quests["wuhu"].time then
	            local l_time = 24*60*60 - (os.time() - quests["wuhu"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["wuhu"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function wuhuTongji()
    if GetVariable("autowuhu") and skills["wuhu-duanmendao"] and skills["wuhu-duanmendao"].lvl>=300 and quests["wuhu"] and quests["wuhu"].auto == 1 and quests["wuhu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["wuhu"].time)
	   checkQuestNote(quests["wuhu"].name,l_time)
	end
end

function questwuhu()
    return go(wuhuPre,"��٢��ɽׯ","������")
end
function wuhuPre()
    if not locl.id["������"] then
	   quests["wuhu"].time = os.time() - 23*60*60
	   return check_bei(wuhuOver)
	end
    DeleteTriggerGroup("wuhuAsk")
    create_trigger_t('wuhuAsk1',"^(> )*���������̴����йء��廢���ŵ�������Ϣ��$",'','wuhuAsk')
    create_trigger_t('wuhuAsk2',"^(> )*����û������ˡ�$",'','wuhuNobody')
    SetTriggerOption("wuhuAsk1","group","wuhuAsk")
    SetTriggerOption("wuhuAsk2","group","wuhuAsk")
	questStartLog(quests["wuhu"].name)
	create_timer_s('wuhu',3,'wuhuAskWang')
	exe('askk wang yuyan about �廢���ŵ�')
end
function wuhuAskWang()
	exe('askk wang yuyan about �廢���ŵ�')
end
function wuhuAsk()
    EnableTimer('wuhu',false)
	DeleteTimer("wuhu")
    EnableTriggerGroup("wuhuAsk",false)
	DeleteTriggerGroup("wuhu")
	create_trigger_t('wuhu1',"^(> )*������(����|)˵����(|��)������̫Ƶ���ˣ����е�����",'','wuhuFail')
	create_trigger_t('wuhu2','^(> )*�����������̵�ָ�㣬��Ȼ�������廢��������ʽ������','','wuhuContinue')
	create_trigger_t('wuhu3','^(> )*���Ѿ�ϰ��','','wuhuSucc')
	create_trigger_t('wuhu4',"^(> )*������(����|)˵����(|��)����廢���ŵ�����",'','wuhuDel')
	create_trigger_t('wuhu5',"^(> )*�㰴�������̵�ָ�㣬���廢���������������ƺ���Щ�ĵ�",'','wuhuSucc')
	SetTriggerOption("wuhu1","group","wuhu")
    SetTriggerOption("wuhu2","group","wuhu")
	SetTriggerOption("wuhu3","group","wuhu")
	SetTriggerOption("wuhu4","group","wuhu")
	SetTriggerOption("wuhu5","group","wuhu")
end
function wuhuSucc()
    EnableTriggerGroup("wuhu",false)
	quests["wuhu"].time = os.time()
	quests["wuhu"].auto = 2
	questSucLog(quests["wuhu"].name)
	return check_bei(wuhuOver)
end
function wuhuDel()
    EnableTriggerGroup("wuhu",false)
	quests["wuhu"].time = 0
	quests["wuhu"].auto = 0
	DeleteVariable("timewuhu")
	DeleteVariable("autowuhu")
	CloseLog()
	return check_bei(checkQuestOver)
end
function wuhuContinue()
    EnableTriggerGroup("wuhu",false)
	quests["wuhu"].time = os.time()
	return check_bei(wuhuOver)
end
function wuhuFail()
    EnableTriggerGroup("wuhu",false)
	quests["wuhu"].time = os.time() - 20*60*60
	return check_bei(wuhuOver)
end
function wuhuNobody()
    EnableTriggerGroup("wuhuAsk",false)
	quests["wuhu"].time = os.time() - 23*60*60
	return check_bei(wuhuOver)
end
function wuhuOver()
	SetVariable("timewuhu",quests["wuhu"].time)
	SetVariable("autowuhu",quests["wuhu"].auto)
	DeleteTriggerGroup("wuhuAsk")
	DeleteTriggerGroup("wuhu")
	CloseLog()
    return check_bei(checkQuestOver)
end