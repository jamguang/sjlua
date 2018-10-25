quests = quests or {}
quests["fuxue"] = {}
quests["fuxue"].auto = 0
quests["fuxue"].name = "������Ѩ"

questTongji = questTongji or {}
questTongji["fuxue"] = "fuxueTongji"

questCal = questCal or {}
questCal["fuxue"] = "fuxueCal"

questList = questList or {}
questList["fuxue"] = function() if score.party and score.party=="�һ���" and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>200 then return "������Ѩ" else return false end end


function fuxueCal()
    if score.party=="�һ���" and GetVariable("autofuxue") and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>200 then
      if GetVariable("timefuxue") then
		 quests["fuxue"].time=tonumber(GetVariable("timefuxue"))
	  end
	  if GetVariable("autofuxue") then
		 quests["fuxue"].auto=tonumber(GetVariable("autofuxue"))
	  end
	  if quests["fuxue"].time==nil or os.time()-quests["fuxue"].time > 24*60*60 then
	     quests["fuxue"].time = os.time() - 12*60*60
		 SetVariable("timefuxue",quests["fuxue"].time)
	     if quests["fuxue"].auto==nil or quests["fuxue"].auto == 0 then
	        quests["fuxue"].auto = 1
	     end
	     if quests["fuxue"].auto == 1 then
		    exe('pray pearl')
		    return "questFuxue"
	     end
	  else
	     if quests["fuxue"].auto == 1 and quests["fuxue"].time then
	        local l_time = 24*60*60 - (os.time() - quests["fuxue"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("������Ѩ",l_time)
			end
	     end
	     return false
	  end
   end
end
function fuxueTongji()
    if GetVariable("autofuxue") and quests["fuxue"] and quests["fuxue"].auto == 1 and quests["fuxue"].time then
	   local l_time = 24*60*60 - (os.time() - quests["fuxue"].time)
	   checkQuestNote("������Ѩ",l_time)
	end
end
function questFuxue()
   return go(fuxuePre,"�һ���","����ͤ")
end
function fuxuePre()
    if not locl.id["��ҩʦ"] then
	   quests["fuxue"].time = os.time() - 20*60*60
	   return check_bei(fuxueOver)
	end
    DeleteTriggerGroup("fuxueAsk")
    create_trigger_t('fuxueAsk1',"^(> )*�����ҩʦ�����йء�������Ѩ������Ϣ",'','fuxueAsk')
    create_trigger_t('fuxueAsk2',"^(> )*����û������ˡ�$",'','fuxueNobody')
    SetTriggerOption("fuxueAsk1","group","fuxueAsk")
    SetTriggerOption("fuxueAsk2","group","fuxueAsk")
	questStartLog(quests["fuxue"].name)
	exe('ask huang yaoshi about ������Ѩ')
	exe('alias action ������Ѩ')
end
function fuxueAsk()
    EnableTriggerGroup("fuxueAsk",false)
	DeleteTriggerGroup("fuxue")
	create_trigger_t('fuxue1',"^(> )*��ҩʦ˵������\\D*����ȥ��Ϣһ�°ɡ���",'','fuxueFail')
	create_trigger_t('fuxue2','^(> )*��ҩʦ˵������Ҫʹ�á�������Ѩ�������ľ���һ�����������㻹���´���˵�ɡ���','','fuxueContinue')
	create_trigger_t('fuxue3','^(> )*��� "action" �趨Ϊ "������Ѩ" �ɹ���ɡ�','','fuxueSucc')
	create_trigger_t('fuxue4','^(> )*��ҩʦϸ�ĵ����㽲����һ�У�������ѧ���ˡ�','','fuxueSucc')
	SetTriggerOption("fuxue1","group","fuxue")
    SetTriggerOption("fuxue2","group","fuxue")
	SetTriggerOption("fuxue3","group","fuxue")
	SetTriggerOption("fuxue4","group","fuxue")
end
function fuxueSucc()
    EnableTriggerGroup("fuxue",false)
	quests["fuxue"].time = os.time()
	quests["fuxue"].auto = 2
	questSucLog(quests["fuxue"].name)
	return check_bei(fuxueOver)
end
function fuxueContinue()
    EnableTriggerGroup("fuxue",false)
	quests["fuxue"].time = os.time()
	return check_bei(fuxueOver)
end
function fuxueFail()
    EnableTriggerGroup("fuxue",false)
	quests["fuxue"].time = os.time() - 12*60*60
	return check_bei(fuxueOver)
end
function fuxueNobody()
    EnableTriggerGroup("fuxueAsk",false)
	quests["fuxue"].time = os.time() - 18*60*60
	return check_bei(fuxueOver)
end
function fuxueOver()
	SetVariable("timefuxue",quests["fuxue"].time)
	SetVariable("autofuxue",quests["fuxue"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end