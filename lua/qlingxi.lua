quests = quests or {}
quests["lingxi"] = {}
quests["lingxi"].auto = 0
quests["lingxi"].name = "��Ϭһָ"

questTongji = questTongji or {}
questTongji["lingxi"] = "lingxiTongji"

questCal = questCal or {}
questCal["lingxi"] = "lingxiCal"

questList = questList or {}
questList["fuxue"] = function() if score.party and score.party=="�һ���" and skills["tanzhi-shentong"] then return "��Ϭһָ" else return false end end


function lingxiCal()
    if score.party=="�һ���" and GetVariable("autolingxi") and skills["tanzhi-shentong"] then
      if GetVariable("timelingxi") then
		 quests["lingxi"].time=tonumber(GetVariable("timelingxi"))
	  end
	  if GetVariable("autolingxi") then
		 quests["lingxi"].auto=tonumber(GetVariable("autolingxi"))
	  end
	  if quests["lingxi"].time==nil or os.time()-quests["lingxi"].time > 24*60*60 then
	     quests["lingxi"].time = os.time() - 12*60*60
		 SetVariable("timelingxi",quests["lingxi"].time)
	     if quests["lingxi"].auto==nil or quests["lingxi"].auto == 0 then
	        quests["lingxi"].auto = 1
	     end
	     if quests["lingxi"].auto == 1 then
		    exe('pray pearl')
		    return "questLingxi"
	     end
	  else
	     if quests["lingxi"].auto == 1 and quests["lingxi"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lingxi"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("��Ϭһָ",l_time)
			end
	     end
	     return false
	  end
   end
end
function lingxiTongji()
    if GetVariable("autolingxi") and quests["lingxi"] and quests["lingxi"].auto == 1 and quests["lingxi"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lingxi"].time)
	   checkQuestNote("��Ϭһָ",l_time)
	end
end
function questLingxi()
   return go(lingxiPre,"�һ���","����ͤ")
end
function lingxiPre()
    if not locl.id["��ҩʦ"] then
	   quests["lingxi"].time = os.time() - 20*60*60
	   return check_bei(lingxiOver)
	end
    DeleteTriggerGroup("lingxiAsk")
    create_trigger_t('lingxiAsk1',"^(> )*�����ҩʦ�����йء���Ϭһָ������Ϣ",'','lingxiAsk')
    create_trigger_t('lingxiAsk2',"^(> )*����û������ˡ�$",'','lingxiNobody')
    SetTriggerOption("lingxiAsk1","group","lingxiAsk")
    SetTriggerOption("lingxiAsk2","group","lingxiAsk")
	questStartLog(quests["lingxi"].name)
	exe('ask huang yaoshi about ��Ϭһָ')
	exe('alias action ��Ϭһָ')
end
function lingxiAsk()
    EnableTriggerGroup("lingxiAsk",false)
	DeleteTriggerGroup("lingxi")
	create_trigger_t('lingxi1',"^(> )*��ҩʦ˵������\\D*����ȥ��Ϣһ�°ɡ���",'','lingxiFail')
	create_trigger_t('lingxi2','^(> )*��ҩʦ˵������Ҫʹ�á���Ϭһָ�������ľ���һ�����������㻹���´���˵�ɡ���','','lingxiContinue')
	create_trigger_t('lingxi3','^(> )*��� "action" �趨Ϊ "��Ϭһָ" �ɹ���ɡ�','','lingxiSucc')
	SetTriggerOption("lingxi1","group","lingxi")
    SetTriggerOption("lingxi2","group","lingxi")
	SetTriggerOption("lingxi3","group","lingxi")
end
function lingxiSucc()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time()
	quests["lingxi"].auto = 2
	questSucLog(quests["lingxi"].name)
	return check_bei(lingxiOver)
end
function lingxiContinue()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time()
	return check_bei(lingxiOver)
end
function lingxiFail()
    EnableTriggerGroup("lingxi",false)
	quests["lingxi"].time = os.time() - 12*60*60
	return check_bei(lingxiOver)
end
function lingxiNobody()
    EnableTriggerGroup("lingxiAsk",false)
	quests["lingxi"].time = os.time() - 18*60*60
	return check_bei(lingxiOver)
end
function lingxiOver()
	SetVariable("timelingxi",quests["lingxi"].time)
	SetVariable("autolingxi",quests["lingxi"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end