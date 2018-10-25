quests = quests or {}
quests["ranmu"] = {}
quests["ranmu"].auto = 0
quests["ranmu"].name = "ȼľ����"

questTongji = questTongji or {}
questTongji["ranmu"] = "ranmuTongji"

questCal = questCal or {}
questCal["ranmu"] = "ranmuCal"

questList = questList or {}
questList["ranmu"] = function() if score.party and score.party=="������" then return quests["ranmu"].name else return false end end


function ranmuCal()
    if isInBags("ľ��") and skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and GetVariable("autoranmu") then
      if GetVariable("timeranmu") then
		 quests["ranmu"].time=tonumber(GetVariable("timeranmu"))
	  end
	  if GetVariable("autoranmu") then
		 quests["ranmu"].auto=tonumber(GetVariable("autoranmu"))
	  end
	  if quests["ranmu"].time==nil or os.time()-quests["ranmu"].time > 24*60*60 then
	     quests["ranmu"].time = os.time() - 22*60*60
		 SetVariable("timeranmu",quests["ranmu"].time)
	     if quests["ranmu"].auto==nil or quests["ranmu"].auto == 0 then
	        quests["ranmu"].auto = 1
	     end
	     if quests["ranmu"].auto == 1 then
		    exe('pray pearl')
		    return "questRanmu"
	     end
	  else
	     if quests["ranmu"].auto == 1 and quests["ranmu"].time then
	        local l_time = 24*60*60 - (os.time() - quests["ranmu"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["ranmu"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function ranmuTongji()
    if GetVariable("autoranmu") and skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and quests["ranmu"] and quests["ranmu"].auto == 1 and quests["ranmu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["ranmu"].time)
	   checkQuestNote(quests["ranmu"].name,l_time)
	end
end
function questRanmu()
   return go(ranmuPre,"��ɽ����","�޺���")
end
function ranmuPre()
    if not locl.id["�����ʦ"] then
	   quests["ranmu"].time = os.time() - 20*60*60
	   return check_bei(ranmuOver)
	end
    DeleteTriggerGroup("ranmuAsk")
    create_trigger_t('ranmuAsk1',"^(> )*���������ʦ�����йء�ȼľ����������Ϣ",'','ranmuAsk')
    create_trigger_t('ranmuAsk2',"^(> )*����û������ˡ�$",'','ranmuNobody')
    SetTriggerOption("ranmuAsk1","group","ranmuAsk")
    SetTriggerOption("ranmuAsk2","group","ranmuAsk")
	exe('ask xuanku dashi about ȼľ����')
end
function ranmuAsk()
    EnableTriggerGroup("ranmuAsk",false)
	DeleteTriggerGroup("ranmu")
	create_trigger_t('ranmu1',"^(> )*�����ʦ˵�����������뽫ȼľ������һ��̨�ף���ȥ�����������ҳ���",'','ranmuGo')
	create_trigger_t('ranmu2','^(> )*�����ʦ˵������������̫Ƶ���ˣ�Ҫ֪����ҽ������Ƕ��򣡡�','','ranmuFail')
	SetTriggerOption("ranmu1","group","ranmu")
    SetTriggerOption("ranmu2","group","ranmu")
end
function ranmuGo()
    EnableTriggerGroup("ranmu",false)
	return go(ranmuXin,"��ɽ����","����������")
end
function ranmuXin()
    if not locl.id["����"] then
	   quests["ranmu"].time = os.time() - 20*60*60
	   return check_bei(ranmuOver)
	end
    DeleteTriggerGroup("ranmuAsk")
    create_trigger_t('ranmuAsk1',"^(> )*������Ŵ����йء�ȼľ����������Ϣ��",'','ranmuXinAsk')
    create_trigger_t('ranmuAsk2',"^(> )*����û������ˡ�$",'','ranmuNobody')
    SetTriggerOption("ranmuAsk1","group","ranmuAsk")
    SetTriggerOption("ranmuAsk2","group","ranmuAsk")
	questStartLog(quests["ranmu"].name)
	exe('ask chengxin luohan about ȼľ����')
end
function ranmuXinAsk()
    EnableTriggerGroup("ranmuAsk",false)
	return check_bei(ranmuPi,1)
end
function ranmuPi()
	DeleteTriggerGroup("ranmu")
	create_trigger_t('ranmu1',"^(> )*�������ڽ������Ƕ�����������̫Ƶ����",'','ranmuFail')
	create_trigger_t('ranmu2','^(> )*�ǳ��ź�,����ȼľʧ��','','ranmuContinue')
	create_trigger_t('ranmu3','^(> )*��� "action" �趨Ϊ "ȼľ����" �ɹ���ɡ�','','ranmuSucc')
	create_trigger_t('ranmu4','^(> )*��һ���������پ�����ľ��һ������','','ranmuSucc')
	SetTriggerOption("ranmu1","group","ranmu")
    SetTriggerOption("ranmu2","group","ranmu")
	SetTriggerOption("ranmu3","group","ranmu")
	SetTriggerOption("ranmu4","group","ranmu")
	weapon_unwield()
	exe('wield mu dao;i')
	exe('pi ľ��')
    exe('alias action ȼľ����')
end
function ranmuSucc()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time()
	quests["ranmu"].auto = 2
	questSucLog(quests["ranmu"].name)
	return check_bei(ranmuOver)
end
function ranmuContinue()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time()
	return check_bei(ranmuOver)
end
function ranmuFail()
    EnableTriggerGroup("ranmu",false)
	quests["ranmu"].time = os.time() - 12*60*60
	return check_bei(ranmuOver)
end
function ranmuNobody()
    EnableTriggerGroup("ranmuAsk",false)
	quests["ranmu"].time = os.time() - 18*60*60
	return check_bei(ranmuOver)
end
function ranmuOver()
	SetVariable("timeranmu",quests["ranmu"].time)
	SetVariable("autoranmu",quests["ranmu"].auto)
	DeleteTriggerGroup("ranmuAsk")
	DeleteTriggerGroup("ranmu")
	CloseLog()
    return check_bei(checkQuestOver)
end