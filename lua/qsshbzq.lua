quests = quests or {}
quests["sshbzq"] = {}
quests["sshbzq"].auto = 0
quests["sshbzq"].name = '������������'

questTongji = questTongji or {}
questTongji["sshbzq"] = "sshbzqTongji"

questCal = questCal or {}
questCal["sshbzq"] = "sshbzqCal"

questList = questList or {}
questList["sshbzq"] = function() if score.party and score.party=="��ɽ��" then return quests["sshbzq"].name else return false end end


function sshbzqCal()
    if score.party=="��ɽ��" and GetVariable("autosshbzq") and score.con>39 then
      if GetVariable("timesshbzq") then
		 quests["sshbzq"].time=tonumber(GetVariable("timesshbzq"))
	  end
	  if GetVariable("autosshbzq") then
		 quests["sshbzq"].auto=tonumber(GetVariable("autosshbzq"))
	  end
	  if quests["sshbzq"].time==nil or os.time()-quests["sshbzq"].time > 24*60*60 then
	     quests["sshbzq"].time = os.time() - 12*60*60
		 SetVariable("timesshbzq",quests["sshbzq"].time)
	     if quests["sshbzq"].auto==nil or quests["sshbzq"].auto == 0 then
	        quests["sshbzq"].auto = 1
	     end
	     if quests["sshbzq"].auto < 2 then
		    exe('pray pearl')
		    return "questsshbzq"
	     end
	  else
	     if quests["sshbzq"].auto < 2 and quests["sshbzq"].time then
	        local l_time = 24*60*60 - (os.time() - quests["sshbzq"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["sshbzq"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function sshbzqTongji()
    if GetVariable("autosshbzq") and quests["sshbzq"] and quests["sshbzq"].auto < 2 and quests["sshbzq"].time then
	   local l_time = 24*60*60 - (os.time() - quests["sshbzq"].time)
	   checkQuestNote(quests["sshbzq"].name,l_time)
	end
end
function questsshbzq()
   return go(sshbzqPre,"��ɽ","����̨")
end
function sshbzqPre()
    if not locl.id["������"] then
	    quests["sshbzq"].time = os.time() - 23*60*60
	    return check_bei(sshbzqOver)
	end
	EnableTriggerGroup("sshbzq",false)
    DeleteTriggerGroup("sshbzq")
  
    create_trigger_t('sshbzqAsk1',"^(> )*���������������йء���������������Ϣ��",'','sshbzqAsk')
    create_trigger_t('sshbzqAsk2',"^(> )*����û������ˡ�$",'','sshbzqNobody')
    SetTriggerOption("sshbzqAsk1","group","sshbzq")
    SetTriggerOption("sshbzqAsk2","group","sshbzq")
	
	return exe('askk zuo lengchan about ��������')
end

function sshbzqAsk()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*������˵������������̫Ƶ���ˡ���",'','sshbzqFail')
	create_trigger_t('sshbzq2','^(> )*�����������ھ�������ʧ��','','sshbzqContinue')
	create_trigger_t('sshbzq3',"^(> )*������˵���������ڵ�ַô���������������",'','sshbzqask2')
	create_trigger_t('sshbzq4',"^(> )*����������˵������ŵص����һ��Ͽ�ȸ���������ص���ʵ���벻�����ˡ�",'','sshbzqgodeng')
    create_trigger_t('sshbzq5',"^(> )*�˰˹�˵�������Ķ��Ƚ����գ�Ҫ��ȥ���ȥ������ʦ�֣�������һ���Ƚ���Ϥ����",'','sshbzqfindle')
    create_trigger_t('sshbzq6',"^(> )*�ֺ�����Ķ�������˵�������������£��ȵ��溮�ޱȣ��㵱С��Ϊ�ϡ�",'','sshbzqfindle')
    create_trigger_t('sshbzq7',"^(> )*�ֺ�����Ķ�������˵��������ɽ����֦��������ֻ��Ҫ�Ҽ�֦��֦����������Ϳ����¹��ˡ�",'','sshbzqfindle')
    create_trigger_t('sshbzq8',"^(> )*����������˵������������ص���Ҳ���Ǻ������",'','sshbzqask2')
	SetTriggerOption("sshbzq1","group","sshbzq")
    SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	SetTriggerOption("sshbzq4","group","sshbzq")
	SetTriggerOption("sshbzq5","group","sshbzq")
	SetTriggerOption("sshbzq6","group","sshbzq")
    SetTriggerOption("sshbzq7","group","sshbzq")
    SetTriggerOption("sshbzq8","group","sshbzq")
end
function sshbzqaskagain()
    return check_halt('sshbzqaskagain2')
end
function sshbzqaskagain2()
    exe('askk zuo lengchan about ��������')
end
--songshan/dtlxia
function sshbzqfindle()
    go(sshbzqaskle,"songshan/dtlxia")
end
function sshbzqaskle()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*�ֺ�����Ķ�������˵��������ɽ����֦��������ֻ��Ҫ�Ҽ�֦��֦����������Ϳ����¹��ˡ�",'','sshbzqgoshuzhi')
	create_trigger_t('sshbzq2',"^(> )*������ѽ?��ô��,��ô������ȥ��ȥ�Ҹ���������ȥ�ɣ���",'','sshbzqgoshuzhi')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
  
    exe('askk le hou about here')
    wait.make(function()
	    wait.time(3)
	    exe('askk le hou about ����')
	end)
end
function sshbzqask2()
    return check_busy(sshbzqask2_1)
end
function sshbzqask2_1()
    exe('askk zuo about ���')
end
function sshbzqgodeng()
    return go(sshbzqaskdeng,"songshan/yushu-lou")
end
function sshbzqgoshuzhi()
    return go(sshbzqgetshuzhi,"songshan/qgfeng")
end

function sshbzqgetshuzhi()
    if not Bag['����'] then
   	    exe("l ����;zhe shuzhi")
        wait.make(function()
	        wait.time(2)
	        exe('zhe shuzhi')
	        return check_busy(sshbzqcuoshuzhi)
	    end)
	else
	    go(sshbzqgodown,"songshan/dtlxia")
	end  

end
function sshbzqcuoshuzhi()
    exe("cuo shuzhi;cuo shuzhi;unwield guanri jian")
	weapon_unwield()
    return go(sshbzqgodown,"songshan/dtlxia")
end
function sshbzqgodown()
    exe("tie sheng;pa down;pa down;look stone;move stone;resist hanfeng")
   
    wait.make(function()
	    wait.time(1)
	    return check_busy(sshbzqrhfask)
	end)
end

function sshbzqrhfask()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*�㾲�����ȶ������������ں������������ĺ����࿹�⡣",'','sshbzqrhfcheck')
	create_trigger_t('sshbzq2',"^(> )*��һʱ���飬�۵�ͻ��һ����Ѫ����ʱ����ʦ���Ķ�������æ��ת���������ķ�����ʼ�ƶ�\\(liaodu\\)������",'','sshbzqliaodu')
	create_trigger_t('sshbzq3',"^(> )*������ѽ?��ô��,��ô������ȥ��ȥ�Ҹ���������ȥ�ɣ���",'','sshbzqgoshuzhi')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	questStartLog(quests["sshbzq"].name)
	exe("resist hanfeng")
end	

function sshbzqrhfcheck()
    flag.idle=0
    return check_busy(sshbzqrhfask)
end

function sshbzqliaodu()
    return check_busy(sshbzqliaodu2)
end

function sshbzqliaodu2()
    flag.idle=-6
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*���򺮱�������������ʧ�ܣ�",'','sshbzqContinue')
	create_trigger_t('sshbzq3',"^(> )*�㱳��ô�ණ�������µ�������",'','sshbzqback')
	create_trigger_t('sshbzq2',"^(> )*��ϲ�㡣",'','sshbzqSucc')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	exe("liaodu")
end	

function sshbzqback()
    exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
end

function sshbzqaskdeng()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*�˰˹�˵�������Ķ��Ƚ����գ�Ҫ��ȥ���ȥ������ʦ�֣�������һ���Ƚ���Ϥ����",'','sshbzqfindle')
	SetTriggerOption("sshbzq1","group","sshbzq")
    exe('askk deng about ���ɱ�')
end

function sshbzqSucc()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time()
	quests["sshbzq"].auto = 2
    questSucLog(quests["sshbzq"].name)
	return check_bei(sshbzqOver)
end
function sshbzqContinue()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
	quests["sshbzq"].time = os.time()+60
	quests["sshbzq"].auto = 1
	return check_halt(sshbzqOver)
end
function sshbzqFail()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time() - 23*60*60
	return check_halt(sshbzqOver)
end
function sshbzqNobody()
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time() - 23*60*60
	return check_bei(sshbzqOver)
end
function sshbzqOver()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	SetVariable("timesshbzq",quests["sshbzq"].time)
	SetVariable("autosshbzq",quests["sshbzq"].auto)
    --CloseLog()
    --return check_bei(checkQuestOver)
	checkBags()
	return check_bei(sshbzqDropCheck)
end
function sshbzqDropCheck()
    if Bag["ENCB"] and Bag["ENCB"].value >= 20 then
	    return sshbzqDrop()
	end
	CloseLog()
	exe('pa up')
	return check_bei(checkQuestOver)
end
function sshbzqDrop()
    exe('drop coin')
    if isInBags('stone') then
        local l_item,l_cnt = isInBags('stone')
	    exe('#'.. l_cnt ..'(drop stone)')
	else
	    if Bag["����"] and Bag["����"].cnt>0 then
	        exe('drop silver')
	    else
	        for p in pairs(Bag) do
		        if Bag[p].kind and perform.skill and Bag[p].kind~=skillEnable[perform.skill] then
			        exe('drop '.. Bag[p].fullid)
			  	    break
			    end
			    if Bag[p].kind then
			        exe('drop '.. Bag[p].fullid)
			  	    break
			    end
		    end
	    end
	end	
	checkBags()	
	return check_busy(sshbzqDropCheck,1)
end