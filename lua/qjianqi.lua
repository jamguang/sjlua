quests = quests or {}
quests["jianqi"] = {}
quests["jianqi"].auto = 0
quests["jianqi"].name = 'ȫ�潣��'

questTongji = questTongji or {}
questTongji["jianqi"] = "jianqiTongji"

questCal = questCal or {}
questCal["jianqi"] = "jianqiCal"

questList = questList or {}
questList["jianqi"] = function() if score.party and score.party=="ȫ���" and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then return quests["jianqi"].name else return false end end


function jianqiCal()
    if string.find("��|��|��",locl.time) and GetVariable("autojianqi") and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then
      if GetVariable("timejianqi") then
		 quests["jianqi"].time=tonumber(GetVariable("timejianqi"))
	  end
	  if GetVariable("autojianqi") then
		 quests["jianqi"].auto=tonumber(GetVariable("autojianqi"))
	  end
	  if quests["jianqi"].time==nil or os.time()-quests["jianqi"].time > 24*60*60 then
	     quests["jianqi"].time = os.time() - 22*60*60
		 SetVariable("timejianqi",quests["jianqi"].time)
	     if quests["jianqi"].auto==nil or quests["jianqi"].auto == 0 then
	        quests["jianqi"].auto = 1
	     end
	     if quests["jianqi"].auto == 1 then
		    exe('pray pearl')
		    return "questjianqi"
	     end
	  else
	     if quests["jianqi"].auto == 1 and quests["jianqi"].time then
	        local l_time = 24*60*60 - (os.time() - quests["jianqi"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["jianqi"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function jianqiTongji()
    if GetVariable("autojianqi") and quests["jianqi"] and quests["jianqi"].auto == 1 and quests["jianqi"].time and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then
	   local l_time = 24*60*60 - (os.time() - quests["jianqi"].time)
	   checkQuestNote(quests["jianqi"].name,l_time)
	end
end
function questjianqi()
    checkBags()
	--questStartLog(quests["jianqi"].name)
    return go(jianqicheckbags,"ȫ��","�̱�")
end
function jianqicheckbags()   
    if Bag["���ǽ�"] then
        print("�����ǽ�")
	    return go(jianqiqcjask,"ȫ��","�Ͼ���")
    end  
    print("����û�����ǽ�")
    return go(jianqiPre,"ȫ��","�徻��")
end
function jianqiPre()
    if not locl.id["�ﲻ��"] then
	    quests["jianqi"].time = os.time() - 23.7*60*60
	    return check_bei(jianqiOver)
	end
    DeleteTriggerGroup("jianqiAsk")
    create_trigger_t('jianqiAsk1',"^(> )*�����ﲻ�������й�",'','jianqiAsk')
    create_trigger_t('jianqiAsk2',"^(> )*����û������ˡ�$",'','jianqiNobody')
    SetTriggerOption("jianqiAsk1","group","jianqiAsk")
    SetTriggerOption("jianqiAsk2","group","jianqiAsk")
	exe('askk sun buer about ������')				
end
function jianqiAsk()
    EnableTriggerGroup("jianqiAsk",true)
	DeleteTriggerGroup("jianqi")                             
	create_trigger_t('jianqi1',"^(> )*�ﲻ��˵�������ҷ��Ų��Ǹ�����ô����",'','jianqikiller')
	create_trigger_t('jianqi2',"^(> )*�ﲻ��˵���������Ǳ���������������Ѿ������ˣ���",'','jianqikiller')
    create_trigger_t('jianqi3','^(> )*�ﲻ������˵�������Ǳ�������ȫ����������ϱ��','','jianqiqxbj')
    create_trigger_t('jianqi4',"^(> )*�ﲻ�����һ�Ѻ�������ı����ݸ���!",'','jianqigoqcj')
	SetTriggerOption("jianqi1","group","jianqi")
	SetTriggerOption("jianqi2","group","jianqi")
	SetTriggerOption("jianqi3","group","jianqi")
	SetTriggerOption("jianqi4","group","jianqi")
end
function jianqiqxbj()
    exe('askk sun buer about ���Ǳ���')
end
function jianqigoqcj()
    return go(jianqiqcjask,'ȫ��','�Ͼ���')   
end
function jianqiqcjask()
    if not locl.id["�𴦻�"] then
	    quests["jianqi"].time = os.time() - 23.8*60*60
	    return check_bei(jianqiOver)
	end 
    EnableTriggerGroup("jianqiqcjask",true)
    create_trigger_t('jianqiqiuAsk1',"^(> )*����û������ˡ�$",'','jianqiNobody')
    create_trigger_t('jianqiqiuAsk2',"^(> )*�粻�����������ƺ������򣬽�������书������С�ɣ�����������ģ��������������һ��",'','jianqiqingjiao')
    create_trigger_t('jianqiqiuAsk3',"^(> )*�𴦻�����˵��������ҸղŲ����Ѿ��ش�������",'','jianqiqingjiao')
    create_trigger_t('jianqiqiuAsk4',"^(> )*�𴦻�����˵�����ţ��㲻�Ǹ�����̹��ҽ����𣿻�����Ŭ����ʱ��ɣ�",'','jianqiFail')
    create_trigger_t('jianqiqiuAsk5',"^(> )*�������𴦻���ָ�㣬���Ƕ�ȫ�潣�������İ���ȫȻ����Ҫ�졣",'','jianqifinish')
	create_trigger_t('jianqiqiuAsk6',"^(> )*��ԭ��|��ϲ|ԭ�����|����|���Ѿ���",'','jianqiSucc')
    create_trigger_t('jianqiqiuAsk7',"^(> )*�𴦻�����˵����������̫Ƶ���ˣ�",'','jianqiFail')
	create_trigger_t('jianqiqiuAsk8',"^(> )*�𴦻�����˵�����������޷���������б������ǣ������ָ����ѧϰȫ�潣���Ľ������衣",'','jianqiWait')
	SetTriggerOption("jianqiqiuAsk1","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk2","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk3","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk4","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk5","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk6","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk7","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk8","group","jianqiqiuAsk")
	questStartLog(quests["jianqi"].name)
	return exe('askk qiu chuji about ȫ�潣��')
end
function jianqiqxbj1()
	return check_busy(jianqiqxbj1)
end
function jianqiqingjiao()
	wait.make(function()
	    wait.time(5)
        exe('qingjiao')
   end)		
end
function jianqikiller()
	--exe('kill sun buer;pfmpfm')
	quests["jianqi"].time = os.time() - 23.6*60*60
	return wipe("sun buer",jianqiOver)
end
function jianqiWait()
    flag.idle = 0
    wait.make(function()
	    wait.time(10)
        exe('askk qiu chuji about ȫ�潣��')
   end)	
end
function jianqiSucc()
    EnableTriggerGroup("jianqi",false)
	questSucLog(quests["jianqi"].name)
	quests["jianqi"].time = os.time()
	quests["jianqi"].auto = 2
	return check_bei(jianqiOver)
end
function jianqiFail()
    EnableTriggerGroup("jianqi",false)
	quests["jianqi"].time = os.time() - 23.8*60*60
	return check_bei(jianqiOver)
end
function jianqifinish()
    EnableTriggerGroup("jianqi",false)
    EnableTriggerGroup("jianqiAsk",false)
    EnableTriggerGroup("jianqiAskqiu",false)
    EnableTriggerGroup("jianqiqcjask",false)
	quests["jianqi"].time = os.time()
	SetVariable("timejianqi",quests["jianqi"].time)
	print("����ȫ�潣������") 	
    return check_bei(jianqiQuit)
end
function jianqiNobody()
    EnableTriggerGroup("jianqiAsk",false)
	quests["jianqi"].time = os.time() - 23.7*60*60
	return check_bei(jianqiOver)
end
function jianqiOver()
	SetVariable("timejianqi",quests["jianqi"].time)
	EnableTriggerGroup("jianqiAsk",false)
    EnableTriggerGroup("jianqiAskqiu",false)
    EnableTriggerGroup("jianqiqcjask",false)
	print("����ȫ�潣������")
	CloseLog()
    return check_bei(checkQuestOver)
end
function jianqiQuit()
    return husongQuit()				
end

function jianqiDel()
    EnableTriggerGroup("jianqi",false)
	quests["jianqi"].time = os.time()
	quests["jianqi"].auto = 0
	DeleteVariable("timejianqi")
	DeleteVariable("autojianqi")
	CloseLog()
	return check_bei(checkQuestOver)
end

