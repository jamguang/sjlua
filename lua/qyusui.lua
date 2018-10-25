quests = quests or {}
quests["yusui"] = {}
quests["yusui"].auto = 0
quests["yusui"].name = "���鵶��"

questTongji = questTongji or {}
questTongji["yusui"] = "yusuiTongji"

questCal = questCal or {}
questCal["yusui"] = "yusuiCal"

questList = questList or {}
questList["yusui"] = function() if score.party and score.party=="����Ľ��" and skills["murong-daofa"] then return "���鵶��" else return false end end


function yusuiCal()
    if score.party=="����Ľ��" and GetVariable("autoyusui") and skills["murong-daofa"] then
      if GetVariable("timeyusui") then
		 quests["yusui"].time=tonumber(GetVariable("timeyusui"))
	  end
	  if GetVariable("autoyusui") then
		 quests["yusui"].auto=tonumber(GetVariable("autoyusui"))
	  end
	  if quests["yusui"].time==nil or os.time()-quests["yusui"].time > 24*60*60 then
	     quests["yusui"].time = os.time() - 12*60*60
		 SetVariable("timeyusui",quests["yusui"].time)
	     if quests["yusui"].auto==nil or quests["yusui"].auto == 0 then
	        quests["yusui"].auto = 1
	     end
	     if quests["yusui"].auto == 1 then
		    exe('pray pearl')
		    return "questYusui"
	     end
	  else
	     if quests["yusui"].auto == 1 and quests["yusui"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yusui"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("���鵶��",l_time)
			end
	     end
	     return false
	  end
   end
end
function yusuiTongji()
    if GetVariable("autoyusui") and quests["yusui"] and quests["yusui"].auto == 1 and quests["yusui"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yusui"].time)
	   checkQuestNote("���鵶��",l_time)
	end
end
function questYusui()
   return go(yusuiPre,"����Ľ��","С��")
end
function yusuiPre()
    if not locl.id["����ͬ"] then
	   quests["yusui"].time = os.time() - 20*60*60
	   return check_bei(yusuiOver)
	end
    DeleteTriggerGroup("yusuiAsk")
    create_trigger_t('yusuiAsk1',"^(> )*�������ͬ�����йء����鵶�����������Ϣ",'','yusuiAsk')
    create_trigger_t('yusuiAsk2',"^(> )*����û������ˡ�$",'','yusuiNobody')
    SetTriggerOption("yusuiAsk1","group","yusuiAsk")
    SetTriggerOption("yusuiAsk2","group","yusuiAsk")
	questStartLog(quests["yusui"].name)
	exe('ask bao butong about ���鵶�����')
	exe('alias action ���鵶�����')
end
function yusuiAsk()
    EnableTriggerGroup("yusuiAsk",false)
	DeleteTriggerGroup("yusui")
	create_trigger_t('yusui1',"^(> )*����ͬ(����|)˵����(��|)������Ҳ̫�ڿ���",'','yusuiFail')
	create_trigger_t('yusui2','^(> )*����Ȼ������ͬ','','yusuiContinue')
	create_trigger_t('yusui3','^(> )*��� "action" �趨Ϊ "���鵶�����" �ɹ���ɡ�','','yusuiContinue')
	create_trigger_t('yusui4','^(> )*�������Խ��Խ����������','','yusuiSucc')
	create_trigger_t('yusui5','^(> )*����ͬ˵���������Ѿ��⿪�ˣ���','','yusuiSucc')
	SetTriggerOption("yusui1","group","yusui")
    SetTriggerOption("yusui2","group","yusui")
	SetTriggerOption("yusui3","group","yusui")
	SetTriggerOption("yusui4","group","yusui")
	SetTriggerOption("yusui5","group","yusui")
end
function yusuiSucc()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time()
	quests["yusui"].auto = 2
	questSucLog(quests["yusui"].name)
	return check_bei(yusuiOver)
end
function yusuiContinue()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time()
	return check_bei(yusuiOver)
end
function yusuiFail()
    EnableTriggerGroup("yusui",false)
	quests["yusui"].time = os.time() - 12*60*60
	return check_bei(yusuiOver)
end
function yusuiNobody()
    EnableTriggerGroup("yusuiAsk",false)
	quests["yusui"].time = os.time() - 18*60*60
	return check_bei(yusuiOver)
end
function yusuiOver()
	SetVariable("timeyusui",quests["yusui"].time)
	SetVariable("autoyusui",quests["yusui"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end