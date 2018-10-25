quests = quests or {}
quests["als"] = {}
quests["als"].auto = 0
quests["als"].name = '����ɽ����'

questTongji = questTongji or {}
questTongji["als"] = "alsTongji"

questCal = questCal or {}
questCal["als"] = "alsCal"

questList = questList or {}
questList["als"] = function() if score.party=="������" and skills["qiantian-yiyang"] and skills["qiantian-yiyang"].lvl>220 then return quests["als"].name else return false end end


function alsCal()
    if GetVariable("autoals") and score.party=="������" and skills["qiantian-yiyang"] and skills["qiantian-yiyang"].lvl>220 then
      if GetVariable("timeals") then
		 quests["als"].time=tonumber(GetVariable("timeals"))
	  end
	  if GetVariable("autoals") then
		 quests["als"].auto=tonumber(GetVariable("autoals"))
	  end
	  if quests["als"].time==nil or os.time()-quests["als"].time > 24*60*60 then
	     quests["als"].time = os.time() - 22*60*60
		 SetVariable("timeals",quests["als"].time)
	     if quests["als"].auto==nil or quests["als"].auto == 0 then
	        quests["als"].auto = 1
	     end
	     if quests["als"].auto == 1 then
		    exe('pray pearl')
		    return "questals"
	     end
	  else
	     if quests["als"].auto == 1 and quests["als"].time then
	        local l_time = 24*60*60 - (os.time() - quests["als"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["als"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function alsTongji()
    if GetVariable("autoals") and quests["als"] and quests["als"].auto == 1 and quests["als"].time then
	   local l_time = 24*60*60 - (os.time() - quests["als"].time)
	   checkQuestNote(quests["als"].name,l_time)
	end
end

function questals()
   return go(alsPre,"��������","ů��")
end
function alsPre()
    if not locl.id["������"] then
	   quests["als"].time = os.time() - 20*60*60
	   return check_bei(alsOver)
	end
    DeleteTriggerGroup("alsAsk")
    create_trigger_t('alsAsk1',"^(> )*��������������йء�����ɽ���⡻����Ϣ",'','alsAsk')
    create_trigger_t('alsAsk2',"^(> )*����û������ˡ�$",'','alsNobody')
    SetTriggerOption("alsAsk1","group","alsAsk")
    SetTriggerOption("alsAsk2","group","alsAsk")
	questStartLog(quests["als"].name)
	exe('ask duan zhengchun about ����ɽ����')
	exe('alias action ����ɽ����')
end
function alsAsk()
    EnableTriggerGroup("alsAsk",false)
	DeleteTriggerGroup("als")
	create_trigger_t('als1',"^(> )*������(����|)˵����(��|)������Ҳ̫�ڿ��ˣ�����������",'','alsFail')
	create_trigger_t('als2','^(> )*����Ȼ��������˵����μҽ���','','alsContinue')
	create_trigger_t('als3','^(> )*��� "action" �趨Ϊ "����ɽ����" �ɹ���ɡ�','','alsSucc')
	SetTriggerOption("als1","group","als")
    SetTriggerOption("als2","group","als")
	SetTriggerOption("als3","group","als")
end
function alsSucc()
    EnableTriggerGroup("als",false)
	quests["als"].time = os.time()
	quests["als"].auto = 2
	questSucLog(quests["als"].name)
	return check_bei(alsOver)
end
function alsContinue()
    EnableTriggerGroup("als",false)
	quests["als"].time = os.time()
	return check_bei(alsOver)
end
function alsFail()
    EnableTriggerGroup("als",false)
	quests["als"].time = os.time() - 12*60*60
	return check_bei(alsOver)
end
function alsNobody()
    EnableTriggerGroup("alsAsk",false)
	quests["als"].time = os.time() - 18*60*60
	return check_bei(alsOver)
end
function alsOver()
	SetVariable("timeals",quests["als"].time)
	SetVariable("autoals",quests["als"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end