quests = quests or {}
quests["thd"] = {}
quests["thd"].auto = 0
quests["thd"].name = '�һ���ѧ'

questTongji = questTongji or {}
questTongji["thd"] = "thdTongji"

questCal = questCal or {}
questCal["thd"] = "thdCal"

questList = questList or {}
questList["thd"] = function() if score.party=="�һ���" and score.int and score.int>39 then return quests["thd"].name else return false end end


function thdCal()
    if GetVariable("autothd") and score.party=="�һ���" and score.int and score.int>39 then
      if GetVariable("timethd") then
		 quests["thd"].time=tonumber(GetVariable("timethd"))
	  end
	  if GetVariable("autothd") then
		 quests["thd"].auto=tonumber(GetVariable("autothd"))
	  end
	  if quests["thd"].time==nil or os.time()-quests["thd"].time > 24*60*60 then
	     quests["thd"].time = os.time() - 22*60*60
		 SetVariable("timethd",quests["thd"].time)
	     if quests["thd"].auto==nil or quests["thd"].auto == 0 then
	        quests["thd"].auto = 1
	     end
	     if quests["thd"].auto == 1 then
		    exe('pray pearl')
		    return "questthd"
	     end
	  else
	     if quests["thd"].auto == 1 and quests["thd"].time then
	        local l_time = 24*60*60 - (os.time() - quests["thd"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["thd"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function thdTongji()
    if GetVariable("autothd") and quests["thd"] and quests["thd"].auto == 1 and quests["thd"].time then
	   local l_time = 24*60*60 - (os.time() - quests["thd"].time)
	   checkQuestNote(quests["thd"].name,l_time)
	end
end

function questthd()
   return go(thdPre,"�һ���","����ͤ")
end
function thdPre()
    if not locl.id["��ҩʦ"] then
	   quests["thd"].time = os.time() - 20*60*60
	   return check_bei(thdOver)
	end
    DeleteTriggerGroup("thdAsk")
    create_trigger_t('thdAsk1',"^(> )*�����ҩʦ�����йء��һ�����ѧ������Ϣ",'','thdAsk')
    create_trigger_t('thdAsk2',"^(> )*����û������ˡ�$",'','thdNobody')
    SetTriggerOption("thdAsk1","group","thdAsk")
    SetTriggerOption("thdAsk2","group","thdAsk")
	questStartLog(quests["thd"].name)
	return exe('ask huang yaoshi about �һ�����ѧ')
end
function thdAsk()
    EnableTriggerGroup("thdAsk",false)
	DeleteTriggerGroup("thd")
	create_trigger_t('thd1',"^(> )*��ҩʦ˵�������㻹��ȥ��Ϣһ�°ɡ���",'','thdFail')
	create_trigger_t('thd2','^(> )*��ҩʦ����ʧ������','','thdContinue')
	create_trigger_t('thd3',"^(> )*��ҩʦ˵�������㲻���Ѿ�ѧ�����𣿡�",'','thdSucc')
	SetTriggerOption("thd1","group","thd")
    SetTriggerOption("thd2","group","thd")
	SetTriggerOption("thd3","group","thd")
end
function thdSucc()
    EnableTriggerGroup("thd",false)
	quests["thd"].time = os.time()
	quests["thd"].auto = 2
	questSucLog(quests["thd"].name)
	return check_bei(thdOver)
end
function thdContinue()
    EnableTriggerGroup("thd",false)
	quests["thd"].time = os.time()
	return check_bei(thdOver)
end
function thdFail()
    EnableTriggerGroup("thd",false)
	quests["thd"].time = os.time() - 12*60*60
	return check_bei(thdOver)
end
function thdNobody()
    EnableTriggerGroup("thdAsk",false)
	quests["thd"].time = os.time() - 18*60*60
	return check_bei(thdOver)
end
function thdOver()
	SetVariable("timethd",quests["thd"].time)
	SetVariable("autothd",quests["thd"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end