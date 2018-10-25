quests = quests or {}
quests["jdhj"] = {}
quests["jdhj"].auto = 0
quests["jdhj"].name = '�𵶺ڽ�'

questTongji = questTongji or {}
questTongji["jdhj"] = "jdhjTongji"

questCal = questCal or {}
questCal["jdhj"] = "jdhjCal"

questList = questList or {}
questList["jdhj"] = function() if skills["force"] and skills["force"].lvl>250 then return quests["jdhj"].name else return false end end


function jdhjCal()
    if GetVariable("autojdhj") and skills["force"] and skills["force"].lvl>250 then
      if GetVariable("timejdhj") then
		 quests["jdhj"].time=tonumber(GetVariable("timejdhj"))
	  end
	  if GetVariable("autojdhj") then
		 quests["jdhj"].auto=tonumber(GetVariable("autojdhj"))
	  end
	  if quests["jdhj"].time==nil or os.time()-quests["jdhj"].time > 24*60*60 then
	     quests["jdhj"].time = os.time() - 22*60*60
		 SetVariable("timejdhj",quests["jdhj"].time)
	     if quests["jdhj"].auto==nil or quests["jdhj"].auto == 0 then
	        quests["jdhj"].auto = 1
	     end
	     if quests["jdhj"].auto == 1 then
		    exe('pray pearl')
		    return "questjdhj"
	     end
	  else
	     if quests["jdhj"].auto == 1 and quests["jdhj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["jdhj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["jdhj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function jdhjTongji()
    if GetVariable("autojdhj") and quests["jdhj"] and quests["jdhj"].auto == 1 and quests["jdhj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["jdhj"].time)
	   checkQuestNote(quests["jdhj"].name,l_time)
	end
end
function questjdhj()
   return go(jdhjPre,"�����","����")
end
function jdhjPre()
    if not locl.id["����ֹ"] then
	   quests["jdhj"].time = os.time() - 20*60*60
	   return check_bei(jdhjOver)
	end
    DeleteTriggerGroup("jdhjAsk")
  
    create_trigger_t('jdhjAsk1',"^(> )*������ֹ�����йء��𵶺ڽ�������Ϣ��$",'','jdhjAsk')
    create_trigger_t('jdhjAsk2',"^(> )*����û������ˡ�$",'','jdhjNobody')
    SetTriggerOption("jdhjAsk1","group","jdhjAsk")
    SetTriggerOption("jdhjAsk2","group","jdhjAsk")
	questStartLog(quests["jdhj"].name)
	return exe('askk gongsun zhi about �𵶺ڽ�')
end
function jdhjAsk()
    EnableTriggerGroup("jdhjAsk",false)
	DeleteTriggerGroup("jdhj")
	create_trigger_t('jdhj1',"^(> )*����ֹ˵�������������д赽����ɣ�����ɡ���$",'','jdhjFail')
	create_trigger_t('jdhj2','^(> )*����ֹ��ϧ�Ķ���˵���ÿ����ĺ��ӣ������Ȧ���Ͼͺ���������','','jdhjContinue')
	create_trigger_t('jdhj3',"^(> )*����ֹ˵�������㲻ѧ�Ѿ�ѧ�˽𵶺ڽ�����˫�����𡣡�|�㡸����������Ц������˵������ԭ����ˣ�ԭ����ˡ���|�����˹���ֹ��ָ��,���������˽𵶺ڽ��ľ������ڡ�",'','jdhjSucc')
    create_trigger_t('jdhj4',"^(> )*����ֹ˵���������㵱ǰ�ľ�����»�����������",'','jdhjContinue')
    create_trigger_t('jdhj5',"^(> )*����ֹ�ƺ����������˼��",'','jdhjDel')
	SetTriggerOption("jdhj1","group","jdhj")
    SetTriggerOption("jdhj2","group","jdhj")
	SetTriggerOption("jdhj3","group","jdhj")
	SetTriggerOption("jdhj4","group","jdhj")
	SetTriggerOption("jdhj5","group","jdhj")
end
function jdhjSucc()
    EnableTriggerGroup("jdhj",false)
	questSucLog(quests["jdhj"].name)
	quests["jdhj"].time = os.time()
	quests["jdhj"].auto = 2
	return check_bei(jdhjOver)
end
function jdhjDel()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time()
	quests["jdhj"].auto = 0
	DeleteVariable("timejdhj")
	DeleteVariable("autojdhj")
	CloseLog()
	return check_bei(checkQuestOver)
end
function jdhjContinue()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time()
	return check_bei(jdhjOver)
end
function jdhjFail()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time() - 20*60*60
	return check_bei(jdhjOver)
end
function jdhjNobody()
    EnableTriggerGroup("jdhjAsk",false)
	quests["jdhj"].time = os.time() - 23.5*60*60
	return check_bei(jdhjOver)
end
function jdhjOver()
	SetVariable("timejdhj",quests["jdhj"].time)
	SetVariable("autojdhj",quests["jdhj"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end