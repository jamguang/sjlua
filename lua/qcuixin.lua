quests = quests or {}
quests["cuixin"] = {}
quests["cuixin"].auto = 0
quests["cuixin"].name = '�����ƾ���'

questTongji = questTongji or {}
questTongji["cuixin"] = "cuixinTongji"

questCal = questCal or {}
questCal["cuixin"] = "cuixinCal"

questList = questList or {}
questList["cuixin"] = function() if skills["cuixin-zhang"] and skills["cuixin-zhang"].lvl>350 then return quests["cuixin"].name else return false end end


function cuixinCal()
    if GetVariable("autocuixin") and skills["cuixin-zhang"] and skills["cuixin-zhang"].lvl>350 and hp.shen<0 then
        if GetVariable("timecuixin") then
		   quests["cuixin"].time=tonumber(GetVariable("timecuixin"))
	    end
	    if GetVariable("autocuixin") then
		   quests["cuixin"].auto=tonumber(GetVariable("autocuixin"))
	    end
	    if quests["cuixin"].time==nil or os.time()-quests["cuixin"].time > 24*60*60 then
	       quests["cuixin"].time = os.time() - 12*60*60
		   SetVariable("timecuixin",quests["cuixin"].time)
	       if quests["cuixin"].auto==nil or quests["cuixin"].auto == 0 then
	          quests["cuixin"].auto = 1
	       end
	       if quests["cuixin"].auto < 2 then
		      exe('pray pearl')
		      return "questcuixin"
	       end
	    else
	       if quests["cuixin"].auto < 2 and quests["cuixin"].time then
	          local l_time = 24*60*60 - (os.time() - quests["cuixin"].time)
		  	if l_time < 0 or l_time * math.random() < 1800 then
		  	   checkQuestNote(quests["cuixin"].name,l_time)
		  	end
	       end
	       return false
	    end
    end
end
function cuixinTongji()
    if GetVariable("autocuixin") and hp.shen<0 and quests["cuixin"] and quests["cuixin"].auto < 2 and quests["cuixin"].time then
	   local l_time = 24*60*60 - (os.time() - quests["cuixin"].time)
	   checkQuestNote(quests["cuixin"].name,l_time)
	end
end

function questcuixin()
    return go(cuixinPre,"���ݳ�","ʯ��")
end
function cuixinPre()
    if not locl.id["������"] then
	    quests["cuixin"].time = os.time() - 23*60*60
	    return check_bei(cuixinOver)
	end
    DeleteTriggerGroup("askchen")
    create_trigger_t('askchen1',"^(> )*�������������йء������ơ�����Ϣ",'','cuixinAsk')
    create_trigger_t('askchen2',"^(> )*����û������ˡ�$",'','cuixinNobody')

    SetTriggerOption("askchen1","group","askchen")
    SetTriggerOption("askchen2","group","askchen")
    questStartLog(quests["cuixin"].name)
	exe('askk chen xuanfeng about ������')
end
function cuixinAskagain()
    EnableTriggerGroup("askchen",true)
    exe('askk chen xuanfeng about ������')
end
function cuixinAsk()
    EnableTriggerGroup("askchen",false)
	DeleteTriggerGroup("cuixin")
	create_trigger_t('cuixin1',"^(> )*���Ǻ���Ȼ�ģ����������ڵ�״��û�а취�����κδ𸲡�",'','cuixinwait')
	create_trigger_t('cuixin2',"^(> )*���������˵����������̫Ƶ���ˣ����е�����",'','cuixinFail')
	create_trigger_t('cuixin3','^(> )*(��ҡ��ҡͷ�������������Ǻ����ѵ�|������е�ʲô���Ծ�, ������ȴ˵������)','','cuixinContinue')
	create_trigger_t('cuixin4',"^(> )*��ͻȻ��׽ס����˲���һĻ�����������",'','cuixinSucc')
    create_trigger_t('cuixin5',"^(> )*������(����˵������������æ���ء�|˵��������������æ���ء���)",'','cuixinwait')
	SetTriggerOption("cuixin1","group","cuixin")
    SetTriggerOption("cuixin2","group","cuixin")
	SetTriggerOption("cuixin3","group","cuixin")
	SetTriggerOption("cuixin4","group","cuixin")
	SetTriggerOption("cuixin5","group","cuixin")
end
function cuixinwait()
    EnableTriggerGroup("cuixin",false)
   	return check_bei(cuixinAskagain,1)
end
function cuixinSucc() 	 	
    EnableTriggerGroup("cuixin",false)	
	questSucLog(quests["cuixin"].name)
 
	quests["cuixin"].time = os.time()
	quests["cuixin"].auto = 2
    questSucLog(quests["cuixin"].name)
	return check_bei(cuixinOver)
end
function cuixinContinue()
    EnableTriggerGroup("cuixin",false)
	quests["cuixin"].time = os.time()
	
	return check_bei(cuixinOver)
end
function cuixinFail()
    EnableTriggerGroup("cuixin",false)
	quests["cuixin"].time = os.time() - 22*60*60
	
	return check_bei(cuixinOver)
end
function cuixinNobody()
    EnableTriggerGroup("askbgz",false)
	quests["cuixin"].time = os.time() - 23*60*60
	return check_bei(cuixinOver)
end
function cuixinOver()
    EnableTriggerGroup("cuixin",false)
	DeleteTriggerGroup("cuixin")
	DeleteTriggerGroup("askchen")
	SetVariable("timecuixin",quests["cuixin"].time)
	SetVariable("autocuixin",quests["cuixin"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end