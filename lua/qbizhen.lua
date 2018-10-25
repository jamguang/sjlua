quests = quests or {}
quests["bizhen"] = {}
quests["bizhen"].auto = 0
quests["bizhen"].name = '��������'

questTongji = questTongji or {}
questTongji["bizhen"] = "bizhenTongji"

questCal = questCal or {}
questCal["bizhen"] = "bizhenCal"

questList = questList or {}
questList["bizhen"] = function() if skills["strike"] and skills["strike"].lvl>350 then return quests["bizhen"].name else return false end end


function bizhenCal()
    if GetVariable("autobizhen") and skills["strike"] and skills["strike"].lvl>350 then
      if GetVariable("timebizhen") then
		 quests["bizhen"].time=tonumber(GetVariable("timebizhen"))
	  end
	  if GetVariable("autobizhen") then
		 quests["bizhen"].auto=tonumber(GetVariable("autobizhen"))
	  end
	  if quests["bizhen"].time==nil or os.time()-quests["bizhen"].time > 24*60*60 then
	     quests["bizhen"].time = os.time() - 22*60*60
		 SetVariable("timebizhen",quests["bizhen"].time)
	     if quests["bizhen"].auto==nil or quests["bizhen"].auto == 0 then
	        quests["bizhen"].auto = 1
	     end
	     if quests["bizhen"].auto == 1 then
		    exe('pray pearl')
		    return "questbizhen"
	     end
	  else
	     if quests["bizhen"].auto == 1 and quests["bizhen"].time then
	        local l_time = 24*60*60 - (os.time() - quests["bizhen"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["bizhen"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function bizhenTongji()
    if GetVariable("autobizhen") and quests["bizhen"] and quests["bizhen"].auto == 1 and quests["bizhen"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bizhen"].time)
	   checkQuestNote(quests["bizhen"].name,l_time)
	end
end

function questbizhen()
    return go(bizhenClimb,"Ħ����","Ħ���µ�")
end
function bizhenClimb()
    exe('climb lian')
	locate()
	return check_bei(bizhenPre,1)
end
function bizhenPre()
    if locl.room~='Ħ���¶�' then
	    bizhenDel()
	end
    if not locl.id["л�̿�"] then
	    quests["bizhen"].time = os.time() - 23*60*60
	    return check_bei(bizhenOver)
	end
    DeleteTriggerGroup("bizhenAsk")
    create_trigger_t('wxjAsk1',"^(> )*����л�̿ʹ����йء��������ơ�����Ϣ��",'','bizhenAsk')
    create_trigger_t('wxjAsk2',"^(> )*����û������ˡ�$",'','bizhenNobody')
    SetTriggerOption("wxjAsk1","group","bizhenAsk")
    SetTriggerOption("wxjAsk2","group","bizhenAsk")
	questStartLog(quests["bizhen"].name)
	exe('ask xie yanke about ��������')
	exe('alias action ��������')
end
function bizhenAsk()
    EnableTriggerGroup("bizhenAsk",false)
	DeleteTriggerGroup("bizhen")
	create_trigger_t('bizhen1',"^(> )*л�̿�(|����)˵����(|��)������Ҳ̫�ڿ���ˣ�",'','bizhenFail')
	create_trigger_t('bizhen2','^(> )*л�̿�(|����)˵����(|��)�ǳ��ź�','','bizhenContinue')
	create_trigger_t('bizhen3','^(> )*��� "action" �趨Ϊ "��������" �ɹ���ɡ�','','bizhenSucc')
	create_trigger_t('bizhen4',"^(> )*������л�̿͵�����ָ�㣬�����������Լ�����Ħ�����Ƶ������ĵã�����ӡ��",'','bizhenSucc')
	SetTriggerOption("bizhen1","group","bizhen")
    SetTriggerOption("bizhen2","group","bizhen")
	SetTriggerOption("bizhen3","group","bizhen")
	SetTriggerOption("bizhen4","group","bizhen")
end
function bizhenSucc()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time()
	quests["bizhen"].auto = 2
	questSucLog(quests["bizhen"].name)
	return check_bei(bizhenOver)
end
function bizhenDel()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = 0
	quests["bizhen"].auto = 0
	DeleteVariable("timebizhen")
	DeleteVariable("autobizhen")
	CloseLog()
	return check_bei(checkQuestOver)
end
function bizhenContinue()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time()
	return check_bei(bizhenOver)
end
function bizhenFail()
    EnableTriggerGroup("bizhen",false)
	quests["bizhen"].time = os.time() - 20*60*60
	return check_bei(bizhenOver)
end
function bizhenNobody()
    EnableTriggerGroup("bizhenAsk",false)
	quests["bizhen"].time = os.time() - 23*60*60
	return check_bei(bizhenOver)
end
function bizhenOver()
	SetVariable("timebizhen",quests["bizhen"].time)
	SetVariable("autobizhen",quests["bizhen"].auto)
	DeleteTriggerGroup("bizhenAsk")
	DeleteTriggerGroup("bizhen")
	CloseLog()
    return check_bei(checkQuestOver)
end