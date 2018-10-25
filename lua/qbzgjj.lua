quests = quests or {}
quests["bgzjj"] = {}
quests["bgzjj"].auto = 0
quests["bgzjj"].name = '�����׹�צ����'

questTongji = questTongji or {}
questTongji["bgzjj"] = "bgzjjTongji"

questCal = questCal or {}
questCal["bgzjj"] = "bgzjjCal"

questList = questList or {}
questList["bgzjj"] = function() if skills["jiuyin-baiguzhua"] and skills["jiuyin-baiguzhua"].lvl>350 then return quests["bgzjj"].name else return false end end


function bgzjjCal()
    if string.find("��|��|��",locl.time) and GetVariable("autobgzjj") and Bag["����"] and skills["jiuyin-baiguzhua"] and skills["jiuyin-baiguzhua"].lvl>350 and hp.shen<0 then
        if GetVariable("timebgzjj") then
		   quests["bgzjj"].time=tonumber(GetVariable("timebgzjj"))
	    end
	    if GetVariable("autobgzjj") then
		   quests["bgzjj"].auto=tonumber(GetVariable("autobgzjj"))
	    end
	    if quests["bgzjj"].time==nil or os.time()-quests["bgzjj"].time > 24*60*60 then
	       quests["bgzjj"].time = os.time() - 12*60*60
		   SetVariable("timebgzjj",quests["bgzjj"].time)
	       if quests["bgzjj"].auto==nil or quests["bgzjj"].auto == 0 then
	          quests["bgzjj"].auto = 1
	       end
	       if quests["bgzjj"].auto < 2 then
		      exe('pray pearl')
		      return "questbgzjj"
	       end
	    else
	       if quests["bgzjj"].auto < 2 and quests["bgzjj"].time then
	          local l_time = 24*60*60 - (os.time() - quests["bgzjj"].time)
		  	if l_time < 0 or l_time * math.random() < 1800 then
		  	   checkQuestNote(quests["bgzjj"].name,l_time)
		  	end
	       end
	       return false
	    end
    end
end
function bgzjjTongji()
    if GetVariable("autobgzjj") and hp.shen<0 and Bag["����"] and quests["bgzjj"] and quests["bgzjj"].auto < 2 and quests["bgzjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bgzjj"].time)
	   checkQuestNote(quests["bgzjj"].name,l_time)
	end
end

function checkKulouYz()
    checkBags()
    if not Bag["����ͷ"] then
       return go(checkKulouQu,"���ݳ�","�ӻ���")
    else
       return check_bei(questbgzjj)
    end   
end
function checkKulouQu()
   exe('qu kulou tou')
   checkBags()
   return check_bei(checkKulouZhp,1)
end
function checkKulouZhp()
    if not Bag["����ͷ"] then
       return checkKulouEmei()
    else
       return check_bei(questbgzjj)
    end 
end
function checkKulouEmei()
    if not Bag["����"] then
	    return go(checkKulouFire,randomElement(drugBuy["����"]))
	else
	    return go(checkKulouGet,"����ɽ","ɽ��") 
	end
end
function checkKulouFire()
    exe('buy fire')
	checkBags()
	return check_bei(checkKulouEmei,1)
end
function checkKulouGet()
    exe('get tou')
	checkBags()
	return check_bei(checkKulouGetWait,1)
end
function checkKulouGetWait()
    if not Bag["����ͷ"] then
	    quests["bgzjj"].time = os.time() - 23*60*60
	    return check_bei(bgzjjOver)
    else
        return check_bei(questbgzjj)
    end
end
function questbgzjj()
    if not Bag["����ͷ"] then
	    return checkKulouYz()
	else  
		return questbgzjjask()  
	end
end

function questbgzjjask()
    return go(bgzjjPre,"���ݳ�","ʯ��")
end
function bgzjjPre()
    if not locl.id["÷����"] then
	    quests["bgzjj"].time = os.time() - 23*60*60
	    return check_bei(bgzjjOver)
	end
    DeleteTriggerGroup("askbgz")
    create_trigger_t('askbgz1',"^(> )*����÷��������йء������׹�צ������Ϣ",'','bgzjjAsk')
    create_trigger_t('askbgz2',"^(> )*����û������ˡ�$",'','bgzjjNobody')

    SetTriggerOption("askbgz1","group","askbgz")
    SetTriggerOption("askbgz2","group","askbgz")
    questStartLog(quests["bgzjj"].name)
	exe('askk mei chaofeng about �����׹�צ')
end
function bgzjjAskagain()
    EnableTriggerGroup("askbgz",true)
    exe('ask mei chaofeng about �����׹�צ')
end
function bgzjjAsk()
    EnableTriggerGroup("askbgz",false)
	DeleteTriggerGroup("bgzjj")
	--÷����˵�����������Ȱ�����������ͷ�ɣ���
	create_trigger_t('bgzjj1',"^(> )*���Ǻ���Ȼ�ģ�÷�������ڵ�״��û�а취�����κδ𸲡�",'','bgzjjwait')
	create_trigger_t('bgzjj2',"^(> )*÷�������˵����(��ϰ�����׹�צ����ҹ���˾�ʱ��|�ţ��㲻�Ǹ�����̹����𣿻�����Ŭ����ʱ��ɣ�)",'','bgzjjFail')
	create_trigger_t('bgzjj3','^(> )*(��ҡ��ҡͷ�������������Ǻ����ѵ�|������е�ʲô���Ծ�, ������ȴ˵������)','','bgzjjContinue')
	create_trigger_t('bgzjj4',"^(> )*��ͻȻ��׽ס����˲���һĻ����������������׹�צ�����С�",'','bgzjjSucc')
	create_trigger_t('bgzjj5',"^(> )*÷����˵����\\D*���Ȱ�����������ͷ�ɣ���",'','checkKulouain')
    create_trigger_t('bgzjj6',"^(> )*÷����(����˵����÷������æ���ء�|˵������÷������æ���ء���)",'','bgzjjwait')

	SetTriggerOption("bgzjj1","group","bgzjj")
    SetTriggerOption("bgzjj2","group","bgzjj")
	SetTriggerOption("bgzjj3","group","bgzjj")
	SetTriggerOption("bgzjj4","group","bgzjj")
	SetTriggerOption("bgzjj5","group","bgzjj")
	SetTriggerOption("bgzjj6","group","bgzjj")	
end
function bgzjjwait()
    EnableTriggerGroup("bgzjj",false)
   	return check_bei(bgzjjAskagain,1)
end
function bgzjjSucc()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].auto = 2
    questSucLog(quests["bgzjj"].name)
	return check_bei(bgzjjOver)
end
function bgzjjContinue()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].time = os.time()
	
	return check_bei(bgzjjOver)
end
function bgzjjFail()
    EnableTriggerGroup("bgzjj",false)
	quests["bgzjj"].time = os.time() - 22*60*60
	
	return check_bei(bgzjjOver)
end
function bgzjjNobody()
    EnableTriggerGroup("askbgz",false)
	quests["bgzjj"].time = os.time() - 23*60*60
	return check_bei(bgzjjOver)
end
function bgzjjOver()
    EnableTriggerGroup("bgzjj",false)
	DeleteTriggerGroup("bgzjj")
	DeleteTriggerGroup("askbgz")
	SetVariable("timebgzjj",quests["bgzjj"].time)
	SetVariable("autobgzjj",quests["bgzjj"].auto)
	CloseLog()
    return go(cunkulou,"���ݳ�","�ӻ���")
end
function cunkulou()
    exe("cun tou")
    return check_bei(checkQuestOver)
end