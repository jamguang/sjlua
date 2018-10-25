quests = quests or {}
quests["qimen"] = {}
quests["qimen"].auto = 0
quests["qimen"].name = '�̺�����������'

questTongji = questTongji or {}
questTongji["qimen"] = "qimenTongji"

questCal = questCal or {}
questCal["qimen"] = "qimenCal"

questList = questList or {}
questList["qimen"] = function() if score.party and score.party=="�һ���" and skills["yuxiao-jian"] and skills["yuxiao-jian"].lvl>200 then return quests["qimen"].name else return false end end


function qimenCal()
    if score.party=="�һ���" and GetVariable("autoqimen") and skills["yuxiao-jian"] and skills["yuxiao-jian"].lvl>200 then
      if GetVariable("timeqimen") then
		 quests["qimen"].time=tonumber(GetVariable("timeqimen"))
	  end
	  if GetVariable("autoqimen") then
		 quests["qimen"].auto=tonumber(GetVariable("autoqimen"))
	  end
	  if quests["qimen"].time==nil or os.time()-quests["qimen"].time > 24*60*60 then
	     quests["qimen"].time = os.time() - 12*60*60
		 SetVariable("timeqimen",quests["qimen"].time)
	     if quests["qimen"].auto==nil or quests["qimen"].auto == 0 then
	        quests["qimen"].auto = 1
	     end
	     if quests["qimen"].auto == 1 then
		    exe('pray pearl')
		    return "questQimen"
	     end
	  else
	     if quests["qimen"].auto == 1 and quests["qimen"].time then
	        local l_time = 24*60*60 - (os.time() - quests["qimen"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["qimen"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function qimenTongji()
    if GetVariable("autoqimen") and quests["qimen"] and quests["qimen"].auto == 1 and quests["qimen"].time then
	   local l_time = 24*60*60 - (os.time() - quests["qimen"].time)
	   checkQuestNote(quests["qimen"].name,l_time)
	end
end
function questQimen()
   return go(qimenPre,"�һ���","����ͤ")
end
function qimenPre()
    if not locl.id["��ҩʦ"] then
	   quests["qimen"].time = os.time() - 20*60*60
	   return check_bei(qimenOver)
	end
    DeleteTriggerGroup("qimenAsk")
    create_trigger_t('qimenAsk1',"^(> )*�����ҩʦ�����йء��̺��������������Ϣ",'','qimenAsk')
    create_trigger_t('qimenAsk2',"^(> )*����û������ˡ�$",'','qimenNobody')
    SetTriggerOption("qimenAsk1","group","qimenAsk")
    SetTriggerOption("qimenAsk2","group","qimenAsk")
	questStartLog(quests["qimen"].name)
	exe('ask huang yaoshi about �̺�����������')
	exe('alias action �̺�����������')
end
function qimenAsk()
    EnableTriggerGroup("qimenAsk",false)
	DeleteTriggerGroup("qimen")
	create_trigger_t('qimen1',"^(> )*��ҩʦ˵������\\D*����ȥ��Ϣһ�°ɡ���",'','qimenFail')
	create_trigger_t('qimen2','^(> )*��ҩʦ˵������Ҫʹ�á��̺���������������ľ���һ�����������㻹���´���˵�ɡ���','','qimenContinue')
	create_trigger_t('qimen3','^(> )*��� "action" �趨Ϊ "�̺�����������" �ɹ���ɡ�','','qimenSucc')
	create_trigger_t('qimen4','^(> )*��ҩʦϸ�ĵ����㽲����һ�У�������ѧ���ˡ�','','qimenSucc')
	SetTriggerOption("qimen1","group","qimen")
    SetTriggerOption("qimen2","group","qimen")
	SetTriggerOption("qimen3","group","qimen")
	SetTriggerOption("qimen4","group","qimen")
end
function qimenSucc()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time()
	quests["qimen"].auto = 2
	questSucLog(quests["qimen"].name)
	return check_bei(qimenOver)
end
function qimenContinue()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time()
	return check_bei(qimenOver)
end
function qimenFail()
    EnableTriggerGroup("qimen",false)
	quests["qimen"].time = os.time() - 12*60*60
	return check_bei(qimenOver)
end
function qimenNobody()
    EnableTriggerGroup("qimenAsk",false)
	quests["qimen"].time = os.time() - 18*60*60
	return check_bei(qimenOver)
end
function qimenOver()
	SetVariable("timeqimen",quests["qimen"].time)
	SetVariable("autoqimen",quests["qimen"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end