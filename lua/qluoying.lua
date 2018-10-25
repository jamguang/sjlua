quests = quests or {}
quests["luoying"] = {}
quests["luoying"].auto = 0
quests["luoying"].name = "��Ӣ�Ʒ�Ծ"

questTongji = questTongji or {}
questTongji["luoying"] = "luoyingTongji"

questCal = questCal or {}
questCal["luoying"] = "luoyingCal"

questList = questList or {}
questList["luoying"] = function() if score.party and score.party=="�һ���" and skills["luoying-zhang"] then return "��Ӣ�Ʒ�Ծ" else return false end end


function luoyingCal()
    if score.party=="�һ���" and GetVariable("autoluoying") and skills["luoying-zhang"] then
      if GetVariable("timeluoying") then
		 quests["luoying"].time=tonumber(GetVariable("timeluoying"))
	  end
	  if GetVariable("autoluoying") then
		 quests["luoying"].auto=tonumber(GetVariable("autoluoying"))
	  end
	  if quests["luoying"].time==nil or os.time()-quests["luoying"].time > 24*60*60 then
	     quests["luoying"].time = os.time() - 12*60*60
		 SetVariable("timeluoying",quests["luoying"].time)
	     if quests["luoying"].auto==nil or quests["luoying"].auto == 0 then
	        quests["luoying"].auto = 1
	     end
	     if quests["luoying"].auto == 1 then
		    exe('pray pearl')
		    return "questLuoying"
	     end
	  else
	     if quests["luoying"].auto == 1 and quests["luoying"].time then
	        local l_time = 24*60*60 - (os.time() - quests["luoying"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("��Ӣ�Ʒ�Ծ",l_time)
			end
	     end
	     return false
	  end
   end
end
function luoyingTongji()
    if GetVariable("autoluoying") and quests["luoying"] and quests["luoying"].auto == 1 and quests["luoying"].time then
	   local l_time = 24*60*60 - (os.time() - quests["luoying"].time)
	   checkQuestNote("��Ӣ�Ʒ�Ծ",l_time)
	end
end
function questLuoying()
   return go(luoyingPre,"�һ���","����ͤ")
end
function luoyingPre()
    if not locl.id["��ҩʦ"] then
	   quests["luoying"].time = os.time() - 20*60*60
	   return check_bei(luoyingOver)
	end
    DeleteTriggerGroup("luoyingAsk")
    create_trigger_t('luoyingAsk1',"^(> )*�����ҩʦ�����йء��һ�Ӱ����񽣡�����Ϣ",'','luoyingAsk')
    create_trigger_t('luoyingAsk2',"^(> )*����û������ˡ�$",'','luoyingNobody')
    SetTriggerOption("luoyingAsk1","group","luoyingAsk")
    SetTriggerOption("luoyingAsk2","group","luoyingAsk")
	questStartLog(quests["luoying"].name)
	exe('ask huang yaoshi about �һ�Ӱ�����')
	exe('alias action �һ�Ӱ�����')
end
function luoyingAsk()
    EnableTriggerGroup("luoyingAsk",false)
	DeleteTriggerGroup("luoying")
	create_trigger_t('luoying1',"^(> )*��ҩʦ˵������\\D*����ȥ��Ϣһ�°ɡ���",'','luoyingFail')
	create_trigger_t('luoying2','^(> )*��ҩʦ˵������Ҫʹ�á��һ�Ӱ����񽣡������ľ���һ�����������㻹���´���˵�ɡ���','','luoyingContinue')
	create_trigger_t('luoying3','^(> )*��� "action" �趨Ϊ "�һ�Ӱ�����" �ɹ���ɡ�','','luoyingSucc')
	create_trigger_t('luoying4','^(> )*��ҩʦϸ�ĵ����㽲����һ�У�������ѧ���ˡ�','','luoyingSucc')
	SetTriggerOption("luoying1","group","luoying")
    SetTriggerOption("luoying2","group","luoying")
	SetTriggerOption("luoying3","group","luoying")
	SetTriggerOption("luoying4","group","luoying")
end
function luoyingSucc()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time()
	quests["luoying"].auto = 2
	questSucLog(quests["luoying"].name)
	return check_bei(luoyingOver)
end
function luoyingContinue()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time()
	return check_bei(luoyingOver)
end
function luoyingFail()
    EnableTriggerGroup("luoying",false)
	quests["luoying"].time = os.time() - 12*60*60
	return check_bei(luoyingOver)
end
function luoyingNobody()
    EnableTriggerGroup("luoyingAsk",false)
	quests["luoying"].time = os.time() - 18*60*60
	return check_bei(luoyingOver)
end
function luoyingOver()
	SetVariable("timeluoying",quests["luoying"].time)
	SetVariable("autoluoying",quests["luoying"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end