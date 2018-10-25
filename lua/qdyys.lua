quests = quests or {}
quests["dyys"] = {}
quests["dyys"].auto = 0
quests["dyys"].name = "�����־���"

questTongji = questTongji or {}
questTongji["dyys"] = "dyysTongji"

questCal = questCal or {}
questCal["dyys"] = "dyysCal"

questList = questList or {}
questList["dyys"] = function() if score.party and score.party=="��ɽ��" and skills["songyang-shou"] then return "�����־���" else return false end end


function dyysCal()
    if score.party=="��ɽ��" and GetVariable("autodyys") and skills["songyang-shou"] then
      if GetVariable("timedyys") then
		 quests["dyys"].time=tonumber(GetVariable("timedyys"))
	  end
	  if GetVariable("autodyys") then
		 quests["dyys"].auto=tonumber(GetVariable("autodyys"))
	  end
	  if quests["dyys"].time==nil or os.time()-quests["dyys"].time > 24*60*60 then
	     quests["dyys"].time = os.time() - 12*60*60
		 SetVariable("timedyys",quests["dyys"].time)
	     if quests["dyys"].auto==nil or quests["dyys"].auto == 0 then
	        quests["dyys"].auto = 1
	     end
	     if quests["dyys"].auto == 1 then
		    exe('pray pearl')
		    return "questDyys"
	     end
	  else
	     if quests["dyys"].auto == 1 and quests["dyys"].time then
	        local l_time = 24*60*60 - (os.time() - quests["dyys"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("�����־���",l_time)
			end
	     end
	     return false
	  end
   end
end
function dyysTongji()
    if GetVariable("autodyys") and quests["dyys"] and quests["dyys"].auto == 1 and quests["dyys"].time then
	   local l_time = 24*60*60 - (os.time() - quests["dyys"].time)
	   checkQuestNote("�����־���",l_time)
	end
end
function questDyys()
   return go(dyysPre,"��ɽ","������Ͽ")
end
function dyysPre()
    if not locl.id["�ֺ�"] then
	   quests["dyys"].time = os.time() - 20*60*60
	   return check_bei(dyysOver)
	end
    DeleteTriggerGroup("dyysAsk")
    create_trigger_t('dyysAsk1',"^(> )*�����ֺ�����йء��������֡�����Ϣ",'','dyysAsk')
    create_trigger_t('dyysAsk2',"^(> )*����û������ˡ�$",'','dyysNobody')
    SetTriggerOption("dyysAsk1","group","dyysAsk")
    SetTriggerOption("dyysAsk2","group","dyysAsk")
	questStartLog(quests["dyys"].name)
	exe('ask le hou about ��������')
end
function dyysAsk()
    EnableTriggerGroup("dyysAsk",false)
	DeleteTriggerGroup("dyys")
	create_trigger_t('dyys1',"^(> )*�ֺ�˵������\\D*��������̫�ڷ��ˡ���",'','dyysFail')
	create_trigger_t('dyys2','^(> )*�ֺ�˵������\\D*���ҵĴ������־������ǿ��������书��һ�����ģ���','','dyysJue')
	SetTriggerOption("dyys1","group","dyys")
    SetTriggerOption("dyys2","group","dyys")
end
function dyysJue()
    EnableTriggerGroup("dyys",false)
	DeleteTriggerGroup("dyysJue")
	create_trigger_t('dyysJue1','^(> )*��� "action" �趨Ϊ "��������" �ɹ���ɡ�','','dyysSucc')
	create_trigger_t('dyysJue2','^(> )*�ֺ�˵������С�ֵܣ�������ʲô��˼����','','dyysFail')
	create_trigger_t('dyysJue3','^(> )*�ֺ��漴�������ֵľ���Ϥ���������㣬������ѧ���˴������֣�','','dyysSucc')
	create_trigger_t('dyysJue4','^(> )*�ֺ���Ȼ���ڸ���ܶ���ϣ����㻹��̫���������ˣ�����ʧ�ܣ�','','dyysContinue')
	SetTriggerOption("dyysJue1","group","dyysJue")
    SetTriggerOption("dyysJue2","group","dyysJue")
	SetTriggerOption("dyysJue3","group","dyysJue")
	SetTriggerOption("dyysJue4","group","dyysJue")
	return check_bei(dyysJueAsk)
end
function dyysJueAsk()
    exe('ask le hou about ��������')
	exe('alias action ��������')
end
function dyysSucc()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time()
	quests["dyys"].auto = 2
	questSucLog(quests["dyys"].name)
	return check_bei(dyysOver)
end
function dyysContinue()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time()
	return check_bei(dyysOver)
end
function dyysFail()
    EnableTriggerGroup("dyys",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time() - 12*60*60
	return check_bei(dyysOver)
end
function dyysNobody()
    EnableTriggerGroup("dyysAsk",false)
	EnableTriggerGroup("dyysJue",false)
	quests["dyys"].time = os.time() - 18*60*60
	return check_bei(dyysOver)
end
function dyysOver()
	SetVariable("timedyys",quests["dyys"].time)
	SetVariable("autodyys",quests["dyys"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end