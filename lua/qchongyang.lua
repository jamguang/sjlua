quests = quests or {}
quests["chongyang"] = {}
quests["chongyang"].auto = 0
quests["chongyang"].name = '����������'

questTongji = questTongji or {}
questTongji["chongyang"] = "chongyangTongji"

questCal = questCal or {}
questCal["chongyang"] = "chongyangCal"

questList = questList or {}
questList["chongyang"] = function() if skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" then return quests["chongyang"].name else return false end end


function chongyangCal()
    if string.find("��|��|��",locl.time) and hp.shen and hp.shen > 2000000 and GetVariable("autochongyang") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" then
        if GetVariable("timechongyang") then
		    quests["chongyang"].time=tonumber(GetVariable("timechongyang"))
	    end
	    if GetVariable("autochongyang") then
		    quests["chongyang"].auto=tonumber(GetVariable("autochongyang"))
	    end
	    if quests["chongyang"].time==nil or os.time()-quests["chongyang"].time > 24*60*60 then
	        quests["chongyang"].time = os.time() - 22*60*60
		    SetVariable("timechongyang",quests["chongyang"].time)
	        if quests["chongyang"].auto==nil or quests["chongyang"].auto == 0 then
	            quests["chongyang"].auto = 1
	        end
	        if quests["chongyang"].auto == 1 then
		        exe('pray pearl')
		        return "questchongyang"
	        end
	    else
	        if quests["chongyang"].auto == 1 and quests["chongyang"].time then
	            local l_time = 24*60*60 - (os.time() - quests["chongyang"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["chongyang"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function chongyangTongji()
    if hp.shen and hp.shen > 2000000 and GetVariable("autochongyang") and skills["haotian-zhang"] and skills["haotian-zhang"].lvl>=300 and GetVariable("autojuding") and GetVariable("autojuding")=="2" and quests["chongyang"] and quests["chongyang"].auto == 1 and quests["chongyang"].time then
	   local l_time = 24*60*60 - (os.time() - quests["chongyang"].time)
	   checkQuestNote(quests["chongyang"].name,l_time)
	end
end

function questchongyang()
    return go(chongyangPre,"ȫ��","��Ϊ��")
end
function chongyangPre()
    if not locl.id["����"] then
	   quests["chongyang"].time = os.time() - 23*60*60
	   return check_bei(chongyangOver)
	end
    DeleteTriggerGroup("chongyangAsk")
    create_trigger_t('chongyangAsk1',"^(> )*�������ڴ����йء����������ƾ���������Ϣ��$",'','chongyangAsk')
    create_trigger_t('chongyangAsk2',"^(> )*����û������ˡ�$",'','chongyangNobody')
    SetTriggerOption("chongyangAsk1","group","chongyangAsk")
    SetTriggerOption("chongyangAsk2","group","chongyangAsk")
	questStartLog(quests["chongyang"].name)
	exe('askk ma yu about ���������ƾ���')
end
function chongyangAsk()
    EnableTriggerGroup("chongyangAsk",false)
	DeleteTriggerGroup("chongyang")
	create_trigger_t('chongyang1',"^(> )*����(����|)˵����(|��)������̫Ƶ����",'','chongyangFail')
	create_trigger_t('chongyang2',"^(> )*����(����|)˵����(|��)����̨�����ã�����Ե�ɺ��ܲ����Ƕ�֮��",'','chongyangGo')
	create_trigger_t('chongyang3',"^(> )*���ڶ���˵������ϲ���������ɾ���",'','chongyangSucc')
	SetTriggerOption("chongyang1","group","chongyang")
    SetTriggerOption("chongyang2","group","chongyang")
	SetTriggerOption("chongyang3","group","chongyang")
end
function chongyangGo()
    EnableTriggerGroup("chongyang",false)
	return go(chongyangKetou,'ȫ��','��ɽɽ��')
end
function chongyangKetou()
    if locl.room ~="��ɽɽ��" then 
		return check_bei(chongyangGo,2)
	end
	flag.idle=0
	exe('ketou ��;ketou ��;ketou ��;ketou ��;ketou ��;ketou ��')
	exe('ketou ��ש;ketou ��ש;ketou ��ש;ketou ��ש;ketou ��ש;ketou ��ש;')
	exe('rukou;eu;nu;wu;u')
	--exe('canwu ��������')
	return check_bei(chongyangCanwu)
end
function chongyangCanwu()
	DeleteTriggerGroup("chongyang")                           
	create_trigger_t('chongyang1',"^(> )*������̫Ƶ����",'','chongyangFail')
	create_trigger_t('chongyang2','^(> )*��ץ����������˼ڤ�룬�����Լ������޷������������������ư������ڣ�����һ��Īչ��','','chongyangContinue')
	create_trigger_t('chongyang3',"^(> )*��ԭ��|��ϲ|ԭ�����|����|���Ѿ���",'','chongyangSucc')
	create_trigger_t('chongyang4',"^(> )*�����ǰ��죬���޷����򱱶��������Ʊ仯��",'','chongyangFail')
	--create_trigger_t('chongyang5',"^(> )*����ϥ�������������죬�������ϱ���������ת�仯�����г����䣬������ȣ�",'','diseableTickcanwu')
	SetTriggerOption("chongyang1","group","chongyang")
    SetTriggerOption("chongyang2","group","chongyang")
	SetTriggerOption("chongyang3","group","chongyang")
	SetTriggerOption("chongyang4","group","chongyang")
	--SetTriggerOption("chongyang5","group","chongyang")
	exe('canwu ��������')
end
function chongyangSucc()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time()
	quests["chongyang"].auto = 2
	questSucLog(quests["chongyang"].name)
	return check_bei(chongyangOver)
end
function chongyangDel()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = 0
	quests["chongyang"].auto = 0
	DeleteVariable("timechongyang")
	DeleteVariable("autochongyang")
	CloseLog()
	return check_bei(checkQuestOver)
end
function chongyangContinue()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time()
	return check_bei(chongyangOver)
end
function chongyangFail()
    EnableTriggerGroup("chongyang",false)
	quests["chongyang"].time = os.time() - 20*60*60
	return check_bei(chongyangOver)
end
function chongyangNobody()
    EnableTriggerGroup("chongyangAsk",false)
	quests["chongyang"].time = os.time() - 23*60*60
	return check_bei(chongyangOver)
end
function chongyangOver()
	SetVariable("timechongyang",quests["chongyang"].time)
	SetVariable("autochongyang",quests["chongyang"].auto)
	DeleteTriggerGroup("chongyangAsk")
	DeleteTriggerGroup("chongyang")
	CloseLog()
    return check_bei(checkQuestOver)
end