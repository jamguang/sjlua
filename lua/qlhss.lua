--��ҩʦ˵�������������������һ����Ҵ�֮������������֮�˲��ô��ڣ�
--��ҩʦ˵������Ȼ��������������Ҿͽ�����ʽ�������㣡�ܷ�����ͨ�Ϳ�����컯�ˡ�
--��ҩʦ̾�˿�����˵���������̷���Ҳ������ǰ�ĺ��̷��ˡ���
--��ҩʦ˵�������һ������������Ǻ��������������ء���
--��ҩʦ˵�������һ��������������ǼҴ���������һʱ�������ˣ�Ҳ�е���Ϊ���ˣ�������Ҫһ�����������㻹���´���˵�ɡ���
--��ҩʦ����ʧ�����ˣ�����û���ˡ���

quests = quests or {}
quests["lhss"] = {}
quests["lhss"].auto = 0
quests["lhss"].name = "������ʽ����"

questTongji = questTongji or {}
questTongji["lhss"] = "lhssTongji"

questCal = questCal or {}
questCal["lhss"] = "lhssCal"

questList = questList or {}
questList["lhss"] = function() if score.party and score.party=="�һ���" and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>500 and score.str and score.str>44 then return "������ʽ����" else return false end end


function lhssCal()
    if score.party=="�һ���" and GetVariable("autolhss") and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>200 and score.str and score.str>44 then
      if GetVariable("timelhss") then
		 quests["lhss"].time=tonumber(GetVariable("timelhss"))
	  end
	  if GetVariable("autolhss") then
		 quests["lhss"].auto=tonumber(GetVariable("autolhss"))
	  end
	  if quests["lhss"].time==nil or os.time()-quests["lhss"].time > 24*60*60 then
	     quests["lhss"].time = os.time() - 12*60*60
		 SetVariable("timelhss",quests["lhss"].time)
	     if quests["lhss"].auto==nil or quests["lhss"].auto == 0 then
	        quests["lhss"].auto = 1
	     end
	     if quests["lhss"].auto == 1 then
		    exe('pray pearl')
		    return "questLhss"
	     end
	  else
	     if quests["lhss"].auto == 1 and quests["lhss"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lhss"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("������ʽ����",l_time)
			end
	     end
	     return false
	  end
   end
end
function lhssTongji()
    if GetVariable("autolhss") and quests["lhss"] and quests["lhss"].auto == 1 and quests["lhss"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lhss"].time)
	   checkQuestNote("������ʽ����",l_time)
	end
end
function questLhss()
   return go(lhssPre,"�һ���","����ͤ")
end
function lhssPre()
    if not locl.id["��ҩʦ"] then
	   quests["lhss"].time = os.time() - 20*60*60
	   return check_bei(lhssOver)
	end
    DeleteTriggerGroup("lhssAsk")
    create_trigger_t('lhssAsk1',"^(> )*�����ҩʦ�����йء�������ʽ����������Ϣ",'','lhssAsk')
    create_trigger_t('lhssAsk2',"^(> )*����û������ˡ�$",'','lhssNobody')
    SetTriggerOption("lhssAsk1","group","lhssAsk")
    SetTriggerOption("lhssAsk2","group","lhssAsk")
	questStartLog(quests["lhss"].name)
	exe('ask huang yaoshi about ������ʽ����')
	exe('alias action ������ʽ����')
end
function lhssAsk()
    EnableTriggerGroup("lhssAsk",false)
	DeleteTriggerGroup("lhss")
	create_trigger_t('lhss1',"^(> )*��ҩʦ˵������\\D*����ȥ��Ϣһ�°ɡ���",'','lhssFail')
	create_trigger_t('lhss2','^(> )*��ҩʦ˵�������һ��������������ǼҴ���������һʱ��������','','lhssContinue')
	create_trigger_t('lhss5','^(> )*��ҩʦ����ʧ�����ˣ�����û���ˡ���','','lhssContinue')                                
	create_trigger_t('lhss3','^(> )*��� "action" �趨Ϊ "������ʽ����" �ɹ���ɡ�','','lhssSucc')
	create_trigger_t('lhss4','^(> )*��ҩʦϸ�ĵ����㽲����һ�У�������ѧ���ˡ�','','lhssSucc')
	SetTriggerOption("lhss1","group","lhss")
    SetTriggerOption("lhss2","group","lhss")
	SetTriggerOption("lhss3","group","lhss")
	SetTriggerOption("lhss4","group","lhss")
	SetTriggerOption("lhss5","group","lhss")
end
function lhssSucc()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time()
	quests["lhss"].auto = 2
	questSucLog(quests["lhss"].name)
	return check_bei(lhssOver)
end
function lhssContinue()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time()
	return check_bei(lhssOver)
end
function lhssFail()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time() - 12*60*60
	return check_bei(lhssOver)
end
function lhssNobody()
    EnableTriggerGroup("lhssAsk",false)
	quests["lhss"].time = os.time() - 18*60*60
	return check_bei(lhssOver)
end
function lhssOver()
	SetVariable("timelhss",quests["lhss"].time)
	SetVariable("autolhss",quests["lhss"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end