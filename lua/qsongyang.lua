quests = quests or {}
quests["songyang"] = {}
quests["songyang"].auto = 0
quests["songyang"].name = '������'

questTongji = questTongji or {}
questTongji["songyang"] = "songyangTongji"

questCal = questCal or {}
questCal["songyang"] = "songyangCal"

questList = questList or {}
questList["songyang"] = function() if score.party and score.party=="��ɽ��" and skills["songshan-jian"] and skills["songshan-jian"].lvl>450 then return quests["songyang"].name else return false end end


function songyangCal()
    if score.party=="��ɽ��" and GetVariable("autosongyang") and skills["songshan-jian"] and skills["songshan-jian"].lvl>450 then
      if GetVariable("timesongyang") then
		 quests["songyang"].time=tonumber(GetVariable("timesongyang"))
	  end
	  if GetVariable("autosongyang") then
		 quests["songyang"].auto=tonumber(GetVariable("autosongyang"))
	  end
	  if quests["songyang"].time==nil or os.time()-quests["songyang"].time > 24*60*60 then
	     quests["songyang"].time = os.time() - 12*60*60
		 SetVariable("timesongyang",quests["songyang"].time)
	     if quests["songyang"].auto==nil or quests["songyang"].auto == 0 then
	        quests["songyang"].auto = 1
	     end
	     if quests["songyang"].auto == 1 then
		    exe('pray pearl')
		    return "questSongyang"
	     end
	  else
	     if quests["songyang"].auto == 1 and quests["songyang"].time then
	        local l_time = 24*60*60 - (os.time() - quests["songyang"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["songyang"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function songyangTongji()
    if GetVariable("autosongyang") and quests["songyang"] and quests["songyang"].auto == 1 and quests["songyang"].time then
	   local l_time = 24*60*60 - (os.time() - quests["songyang"].time)
	   checkQuestNote(quests["songyang"].name,l_time)
	end
end
function questSongyang()
   return go(songyangPre,"��ɽ","����̨")
end
function songyangPre()
    if not locl.id["������"] then
	   quests["songyang"].time = os.time() - 23*60*60
	   return check_bei(songyangOver)
	end
    DeleteTriggerGroup("songyangAsk")
    create_trigger_t('songyangAsk1',"^(> )*���������������йء�������������Ϣ",'','songyangAsk')
    create_trigger_t('songyangAsk2',"^(> )*����û������ˡ�$",'','songyangNobody')
    SetTriggerOption("songyangAsk1","group","songyangAsk")
    SetTriggerOption("songyangAsk2","group","songyangAsk")
	questStartLog(quests["songyang"].name)
	exe('ask zuo lengchan about ������')
	exe('alias action ������')
end
function songyangAsk()
    EnableTriggerGroup("songyangAsk",false)
	DeleteTriggerGroup("songyang")
	create_trigger_t('songyang1',"^(> )*������\\D*ѧϰ������Ҳ���ü���һʱ",'','songyangFail')
	create_trigger_t('songyang2',"^(> )*������\\D*�����æ��",'','songyangFail')
	create_trigger_t('songyang3','^(> )*������\\D*�����������','','songyangContinue')
	create_trigger_t('songyang4','^(> )*��� "action" �趨Ϊ "������" �ɹ���ɡ�','','songyangSucc')
	SetTriggerOption("songyang1","group","songyang")
    SetTriggerOption("songyang2","group","songyang")
	SetTriggerOption("songyang3","group","songyang")
	SetTriggerOption("songyang4","group","songyang")
end
function songyangSucc()
    EnableTriggerGroup("songyang",false)
	quests["songyang"].time = os.time()
	quests["songyang"].auto = 2
	questSucLog(quests["songyang"].name)
	return check_bei(songyangOver)
end
function songyangContinue()
    EnableTriggerGroup("songyang",false)
	quests["songyang"].time = os.time()
	return check_bei(songyangOver)
end
function songyangFail()
    EnableTriggerGroup("songyang",false)
	quests["songyang"].time = os.time() - 12*60*60
	return check_bei(songyangOver)
end
function songyangNobody()
    EnableTriggerGroup("songyangAsk",false)
	EnableTriggerGroup("songyangJue",false)
	quests["songyang"].time = os.time() - 18*60*60
	return check_bei(songyangOver)
end
function songyangOver()
	SetVariable("timesongyang",quests["songyang"].time)
	SetVariable("autosongyang",quests["songyang"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end