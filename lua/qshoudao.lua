quests = quests or {}
quests["shoudao"] = {}
quests["shoudao"].auto = 0
quests["shoudao"].name = "ȼľ�ֵ�����"

questTongji = questTongji or {}
questTongji["shoudao"] = "shoudaoTongji"

questCal = questCal or {}
questCal["shoudao"] = "shoudaoCal"

questList = questList or {}
questList["shoudao"] = function() if score.party and score.party=="������" then return quests["shoudao"].name else return false end end


function shoudaoCal()
    if skills["ranmu-daofa"] and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and GetVariable("autoshoudao") then
      if GetVariable("timeshoudao") then
		 quests["shoudao"].time=tonumber(GetVariable("timeshoudao"))
	  end
	  if GetVariable("autoshoudao") then
		 quests["shoudao"].auto=tonumber(GetVariable("autoshoudao"))
	  end
	  if quests["shoudao"].time==nil or os.time()-quests["shoudao"].time > 24*60*60 then
	     quests["shoudao"].time = os.time() - 12*60*60
		 SetVariable("timeshoudao",quests["shoudao"].time)
	     if quests["shoudao"].auto==nil or quests["shoudao"].auto == 0 then
	        quests["shoudao"].auto = 1
	     end
	     if quests["shoudao"].auto == 1 then
		    exe('pray pearl')
		    return "questShoudao"
	     end
	  else
	     if quests["shoudao"].auto == 1 and quests["shoudao"].time then
	        local l_time = 24*60*60 - (os.time() - quests["shoudao"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["shoudao"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function shoudaoTongji()
    if GetVariable("autoshoudao") and skills["ranmu-daofa"].lvl>450 and skills["cibei-dao"] and skills["cibei-dao"].lvl>450 and skills["xiuluo-dao"] and skills["xiuluo-dao"].lvl>450 and quests["shoudao"] and quests["shoudao"].auto == 1 and quests["shoudao"].time then
	   local l_time = 24*60*60 - (os.time() - quests["shoudao"].time)
	   checkQuestNote(quests["shoudao"].name,l_time)
	end
end
function questShoudao()
   return go(shoudaoPre,"��ɽ����","�޺���")
end
function shoudaoPre()
    if not locl.id["�����ʦ"] then
	   quests["shoudao"].time = os.time() - 20*60*60
	   return check_bei(shoudaoOver)
	end
    DeleteTriggerGroup("shoudaoAsk")
    create_trigger_t('shoudaoAsk1',"^(> )*���������ʦ�����йء�ȼľ�ֵ�����������Ϣ",'','shoudaoAsk')
    create_trigger_t('shoudaoAsk2',"^(> )*����û������ˡ�$",'','shoudaoNobody')
    SetTriggerOption("shoudaoAsk1","group","shoudaoAsk")
    SetTriggerOption("shoudaoAsk2","group","shoudaoAsk")
	exe('ask xuanku dashi about ȼľ�ֵ�����')
end
function shoudaoAsk()
    EnableTriggerGroup("shoudaoAsk",false)
	DeleteTriggerGroup("shoudao")
	create_trigger_t('shoudao1',"^(> )*�����ʦ˵�����������������ޱߣ��Ѿ��󳹴�����ȥ��̣���������һ���ջ񡣡�",'','shoudaoGo')
	create_trigger_t('shoudao2','^(> )*�����ʦ˵������������̫Ƶ���ˣ�Ҫ֪����ҽ������Ƕ��򣡡�','','shoudaoFail')
	SetTriggerOption("shoudao1","group","shoudao")
    SetTriggerOption("shoudao2","group","shoudao")
end
function shoudaoGo()
    EnableTriggerGroup("shoudao",false)
	return go(shoudaoXin,"��ѩɽ","���ö�¥")
end
function shoudaoXin()
    if not locl.id["�Ħ��"] then
	   quests["shoudao"].time = os.time() - 20*60*60
	   return check_bei(shoudaoOver)
	end
    DeleteTriggerGroup("shoudaoAsk")
    create_trigger_t('shoudaoAsk1',"^(> )*�����Ħ�Ǵ����йء�ȼľ��������������Ϣ��",'','shoudaoXinAsk')
    create_trigger_t('shoudaoAsk2',"^(> )*����û������ˡ�$",'','shoudaoNobody')
    SetTriggerOption("shoudaoAsk1","group","shoudaoAsk")
    SetTriggerOption("shoudaoAsk2","group","shoudaoAsk")
	questStartLog(quests["shoudao"].name)
	exe('ask jiumo zhi about ȼľ��������')
	exe('alias action ȼľ�ֵ�����')
end
function shoudaoXinAsk()
    EnableTriggerGroup("shoudaoAsk",false)
	DeleteTriggerGroup("shoudao")
	create_trigger_t('shoudao1',"^(> )*�Ħ��˵����������Ȼ��Ȼ�󳹴��򣬵����������������ɧ�ţ��ѵ�������ˣ���",'','shoudaoFail')
	create_trigger_t('shoudao2','^(> )*�������Ħ�ǵ�ָ�㣬���Ƕ�ȼľ��֮�ֵ������İ���ȫȻ����Ҫ�졣','','shoudaoContinue')
	create_trigger_t('shoudao3','^(> )*��� "action" �趨Ϊ "ȼľ�ֵ�����" �ɹ���ɡ�','','shoudaoSucc')
	SetTriggerOption("shoudao1","group","shoudao")
    SetTriggerOption("shoudao2","group","shoudao")
	SetTriggerOption("shoudao3","group","shoudao")
end
function shoudaoSucc()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time()
	quests["shoudao"].auto = 2
	questSucLog(quests["shoudao"].name)
	return check_bei(shoudaoOver)
end
function shoudaoContinue()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time()
	return check_bei(shoudaoOver)
end
function shoudaoFail()
    EnableTriggerGroup("shoudao",false)
	quests["shoudao"].time = os.time() - 12*60*60
	return check_bei(shoudaoOver)
end
function shoudaoNobody()
    EnableTriggerGroup("shoudaoAsk",false)
	quests["shoudao"].time = os.time() - 18*60*60
	return check_bei(shoudaoOver)
end
function shoudaoOver()
	SetVariable("timeshoudao",quests["shoudao"].time)
	SetVariable("autoshoudao",quests["shoudao"].auto)
	DeleteTriggerGroup("shoudaoAsk")
	DeleteTriggerGroup("shoudao")
	CloseLog()
    return check_bei(checkQuestOver)
end