quests = quests or {}
quests["tzzd"] = {}
quests["tzzd"].auto = 0
quests["tzzd"].name = '�����Ƶ�����'

questTongji = questTongji or {}
questTongji["tzzd"] = "tzzdTongji"

questCal = questCal or {}
questCal["tzzd"] = "tzzdCal"

questList = questList or {}
questList["tzzd"] = function() if score.party=="���ư�" and skills["guiyuan-tunafa"] and skills["guiyuan-tunafa"].lvl>250 then return quests["tzzd"].name else return false end end


function tzzdCal()
    if GetVariable("autotzzd") and score.party=="���ư�" and skills["guiyuan-tunafa"] and skills["guiyuan-tunafa"].lvl>250 then
      if GetVariable("timetzzd") then
		 quests["tzzd"].time=tonumber(GetVariable("timetzzd"))
	  end
	  if GetVariable("autotzzd") then
		 quests["tzzd"].auto=tonumber(GetVariable("autotzzd"))
	  end
	  if quests["tzzd"].time==nil or os.time()-quests["tzzd"].time > 24*60*60 then
	     quests["tzzd"].time = os.time() - 22*60*60
		 SetVariable("timetzzd",quests["tzzd"].time)
	     if quests["tzzd"].auto==nil or quests["tzzd"].auto == 0 then
	        quests["tzzd"].auto = 1
	     end
	     if quests["tzzd"].auto == 1 then
		    exe('pray pearl')
		    return "questtzzd"
	     end
	  else
	     if quests["tzzd"].auto == 1 and quests["tzzd"].time then
	        local l_time = 24*60*60 - (os.time() - quests["tzzd"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["tzzd"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function tzzdTongji()
    if GetVariable("autotzzd") and quests["tzzd"] and quests["tzzd"].auto == 1 and quests["tzzd"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tzzd"].time)
	   checkQuestNote(quests["tzzd"].name,l_time)
	end
end

function questtzzd()
   return go(tzzdPre,"����ɽ","���᷿")
end
function tzzdPre()
    if not locl.id["��ǧ��"] then
	   quests["tzzd"].time = os.time() - 20*60*60
	   return check_bei(tzzdOver)
	end
    DeleteTriggerGroup("tzzdAsk")
    create_trigger_t('tzzdAsk1',"^(> )*������ǧ������йء������Ƶ�����������Ϣ",'','tzzdAsk')
    create_trigger_t('tzzdAsk2',"^(> )*����û������ˡ�$",'','tzzdNobody')
    SetTriggerOption("tzzdAsk1","group","tzzdAsk")
    SetTriggerOption("tzzdAsk2","group","tzzdAsk")
	questStartLog(quests["tzzd"].name)
	exe('ask qiu qianren about �����Ƶ�����')
end
function tzzdAsk()
    EnableTriggerGroup("tzzdAsk",ftzzde)
	DeleteTriggerGroup("tzzd")
	create_trigger_t('tzzd1',"^(> )*��ǧ��(����|)˵����(��|)������̫�ڿ��ˣ�",'','tzzdFail')
	create_trigger_t('tzzd2','^(> )*���������Ƶ���������ʧ�ܣ�','','tzzdContinue')
	create_trigger_t('tzzd3','^(> )*��ǧ��(����|)˵����(��|)���Ѿ�ȫ�������������Ƶ��似��','','tzzdSucc')
	SetTriggerOption("tzzd1","group","tzzd")
    SetTriggerOption("tzzd2","group","tzzd")
	SetTriggerOption("tzzd3","group","tzzd")
end
function tzzdSucc()
    EnableTriggerGroup("tzzd",ftzzde)
	quests["tzzd"].time = os.time()
	quests["tzzd"].auto = 2
	questSucLog(quests["tzzd"].name)
	return check_bei(tzzdOver)
end
function tzzdContinue()
    EnableTriggerGroup("tzzd",ftzzde)
	quests["tzzd"].time = os.time()
	return check_bei(tzzdOver)
end
function tzzdFail()
    EnableTriggerGroup("tzzd",ftzzde)
	quests["tzzd"].time = os.time() - 12*60*60
	return check_bei(tzzdOver)
end
function tzzdNobody()
    EnableTriggerGroup("tzzdAsk",ftzzde)
	quests["tzzd"].time = os.time() - 18*60*60
	return check_bei(tzzdOver)
end
function tzzdOver()
	SetVariable("timetzzd",quests["tzzd"].time)
	SetVariable("autotzzd",quests["tzzd"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end