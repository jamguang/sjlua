quests = quests or {}
quests["niqiu"] = {}
quests["niqiu"].auto = 0
quests["niqiu"].name = '����������'

questTongji = questTongji or {}
questTongji["niqiu"] = "niqiuTongji"

questCal = questCal or {}
questCal["niqiu"] = "niqiuCal"

questList = questList or {}
questList["niqiu"] = function() if hp.neili_max and hp.neili_max>20000 then return quests["niqiu"].name else return false end end


function niqiuCal()
    if GetVariable("autoniqiu") and hp.neili_max and hp.neili_max>20000 then
      if GetVariable("timeniqiu") then
		 quests["niqiu"].time=tonumber(GetVariable("timeniqiu"))
	  end
	  if GetVariable("autoniqiu") then
		 quests["niqiu"].auto=tonumber(GetVariable("autoniqiu"))
	  end
	  if quests["niqiu"].time==nil or os.time()-quests["niqiu"].time > 24*60*60 then
	     quests["niqiu"].time = os.time() - 22*60*60
		 SetVariable("timeniqiu",quests["niqiu"].time)
	     if quests["niqiu"].auto==nil or quests["niqiu"].auto == 0 then
	        quests["niqiu"].auto = 1
	     end
	     if quests["niqiu"].auto == 1 then
		    exe('pray pearl')
		    return "questniqiu"
	     end
	  else
	     if quests["niqiu"].auto == 1 and quests["niqiu"].time then
	        local l_time = 24*60*60 - (os.time() - quests["niqiu"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["niqiu"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function niqiuTongji()
    if GetVariable("autoniqiu") and quests["niqiu"] and quests["niqiu"].auto == 1 and quests["niqiu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["niqiu"].time)
	   checkQuestNote(quests["niqiu"].name,l_time)
	end
end

function questniqiu()
   return go(niqiuPre,"�����","���")
end
function niqiuPre()
    if not locl.id["����"] then
	   quests["niqiu"].time = os.time() - 23*60*60
	   return check_bei(niqiuOver)
	end
    DeleteTriggerGroup("niqiuAsk")
    create_trigger_t('wxjAsk1',"^(> )*�������ô����йء�����������������Ϣ",'','niqiuAsk')
    create_trigger_t('wxjAsk2',"^(> )*����û������ˡ�$",'','niqiuNobody')
    SetTriggerOption("wxjAsk1","group","niqiuAsk")
    SetTriggerOption("wxjAsk2","group","niqiuAsk")
	questStartLog(quests["niqiu"].name)
	return exe('ask ying gu about ����������')
end
function niqiuAsk()
    EnableTriggerGroup("niqiuAsk",false)
	DeleteTriggerGroup("niqiu")
	create_trigger_t('niqiu1',"^(> )*���ö�������˵�ͷ��",'','niqiuFail')
	create_trigger_t('niqiu2','^(> )*��о��Ͳ�һ�㴰��ֽ���·������ǰ����ȴ������ġ�','','niqiuContinue')
	create_trigger_t('niqiu3',"^(> )*����˵��������ϲ�����������������!��",'','niqiuSucc')
	create_trigger_t('niqiu4',"^(> )*����˵��������̫���ˣ���Ը�������",'','niqiuDel')
	SetTriggerOption("niqiu1","group","niqiu")
    SetTriggerOption("niqiu2","group","niqiu")
	SetTriggerOption("niqiu3","group","niqiu")
	SetTriggerOption("niqiu4","group","niqiu")
end
function niqiuSucc()
    EnableTriggerGroup("niqiu",false)
	quests["niqiu"].time = os.time()
	quests["niqiu"].auto = 2
	questSucLog(quests["niqiu"].name)
	return check_bei(niqiuOver)
end
function niqiuDel()
    EnableTriggerGroup("niqiu",false)
	quests["niqiu"].time = 0
	quests["niqiu"].auto = 0
	DeleteVariable("timeniqiu")
	DeleteVariable("autoniqiu")
	CloseLog()
	return check_bei(checkQuestOver)
end
function niqiuContinue()
    EnableTriggerGroup("niqiu",false)
	quests["niqiu"].time = os.time()
	return check_bei(niqiuOver)
end
function niqiuFail()
    EnableTriggerGroup("niqiu",false)
	quests["niqiu"].time = os.time() - 20*60*60
	return check_bei(niqiuOver)
end
function niqiuNobody()
    EnableTriggerGroup("niqiuAsk",false)
	quests["niqiu"].time = os.time() - 23*60*60
	return check_bei(niqiuOver)
end
function niqiuOver()
	SetVariable("timeniqiu",quests["niqiu"].time)
	SetVariable("autoniqiu",quests["niqiu"].auto)
	DeleteTriggerGroup("niqiuAsk")
	DeleteTriggerGroup("niqiu")
	CloseLog()
    return check_bei(checkQuestOver)
end