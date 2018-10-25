quests = quests or {}
quests["canhe"] = {}
quests["canhe"].auto = 0
quests["canhe"].name = '�κ�ָ��ѧ'

questTongji = questTongji or {}
questTongji["canhe"] = "canheTongji"

questCal = questCal or {}
questCal["canhe"] = "canheCal"

questList = questList or {}
questList["canhe"] = function() if score.party=="����Ľ��" then return quests["canhe"].name else return false end end


function canheCal()
    if GetVariable("autocanhe") and score.party=="����Ľ��" and score.int>39 and skills["canhe-zhi"] and skills["canhe-zhi"].lvl>499 then
      if GetVariable("timecanhe") then
		 quests["canhe"].time=tonumber(GetVariable("timecanhe"))
	  end
	  if GetVariable("autocanhe") then
		 quests["canhe"].auto=tonumber(GetVariable("autocanhe"))
	  end
	  if quests["canhe"].time==nil or os.time()-quests["canhe"].time > 24*60*60 then
	     quests["canhe"].time = os.time() - 22*60*60
		 SetVariable("timecanhe",quests["canhe"].time)
	     if quests["canhe"].auto==nil or quests["canhe"].auto == 0 then
	        quests["canhe"].auto = 1
	     end
	     if quests["canhe"].auto == 1 then
		    exe('pray pearl')
		    return "questcanhe"
	     end
	  else
	     if quests["canhe"].auto == 1 and quests["canhe"].time then
	        local l_time = 24*60*60 - (os.time() - quests["canhe"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["canhe"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function canheTongji()
    if GetVariable("autocanhe") and quests["canhe"] and quests["canhe"].auto == 1 and quests["canhe"].time then
	   local l_time = 24*60*60 - (os.time() - quests["canhe"].time)
	   checkQuestNote(quests["canhe"].name,l_time)
	end
end

function questcanhe()
   return go(canhePre,"shaolin/houyuan")
end
function canhePre()
    if not locl.id["Ľ�ݲ�"] then
	   quests["canhe"].time = os.time() - 23*60*60
	   return check_bei(canheOver)
	end
    DeleteTriggerGroup("canheAsk")
    create_trigger_t('canheAsk1',"^(> )*����Ľ�ݲ������йء��κ�ָ��ѧ������Ϣ",'','canheAsk')
    create_trigger_t('canheAsk2',"^(> )*����û������ˡ�$",'','canheNobody')
    SetTriggerOption("canheAsk1","group","canheAsk")
    SetTriggerOption("canheAsk2","group","canheAsk")

    questStartLog(quests["canhe"].name)
	return exe('ask murong bo about �κ�ָ��ѧ')
	
end
function canheAsk()
    EnableTriggerGroup("canheAsk",false)
	DeleteTriggerGroup("canhe")
	create_trigger_t('canhe1',"^(> )*Ľ�ݲ�˵������������Ҳ̫Ƶ���ˣ����Խ���ʱ��δ��,���Ժ���������",'','canheFail')
	create_trigger_t('canhe2','^(> )*Ľ�ݲ�˵�����������㻹��δ���������а������ڵ�ʱ��,����������!��','','canheContinue')
	create_trigger_t('canhe3',"^(> )*Ľ�ݲ�˵�������ð�,�Ҿͽ�����Ľ�ݲκ�ָ�������ռ����������ɡ���",'','canheSucc')
	SetTriggerOption("canhe1","group","canhe")
    SetTriggerOption("canhe2","group","canhe")
	SetTriggerOption("canhe3","group","canhe")
end
function canheSucc()
    EnableTriggerGroup("canhe",false)
	questSucLog(quests["canhe"].name)
	quests["canhe"].time = os.time()
	quests["canhe"].auto = 2
	questSucLog(quests["canhe"].name)
	return check_bei(canheOver)
end
function canheDel()
    EnableTriggerGroup("canhe",false)
	quests["canhe"].time = 0
	quests["canhe"].auto = 0
	DeleteVariable("timecanhe")
	DeleteVariable("autocanhe")
	CloseLog()
	return check_bei(checkQuestOver)
end
function canheContinue()
    EnableTriggerGroup("canhe",false)
	quests["canhe"].time = os.time()
	return check_bei(canheOver)
end
function canheFail()
    EnableTriggerGroup("canhe",false)
	quests["canhe"].time = os.time() - 20*60*60
	return check_bei(canheOver)
end
function canheNobody()
    EnableTriggerGroup("canheAsk",false)
	quests["canhe"].time = os.time() - 23*60*60
	return check_bei(canheOver)
end
function canheOver()
    DeleteTriggerGroup("canheAsk")
    DeleteTriggerGroup("canhe")
	SetVariable("timecanhe",quests["canhe"].time)
	SetVariable("autocanhe",quests["canhe"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end