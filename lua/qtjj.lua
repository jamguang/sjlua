quests = quests or {}
quests["tjj"] = {}
quests["tjj"].auto = 0
quests["tjj"].name = '̫��������'

questTongji = questTongji or {}
questTongji["tjj"] = "tjjTongji"

questCal = questCal or {}
questCal["tjj"] = "tjjCal"

questList = questList or {}
questList["tjj"] = function() if score.party=="�䵱��" and score.int > 39 then return quests["tjj"].name else return false end end


function tjjCal()
    if GetVariable("autotjj") and score.party=="�䵱��" and score.int > 39 then
      if GetVariable("timetjj") then
		 quests["tjj"].time=tonumber(GetVariable("timetjj"))
	  end
	  if GetVariable("autotjj") then
		 quests["tjj"].auto=tonumber(GetVariable("autotjj"))
	  end
	  if quests["tjj"].time==nil or os.time()-quests["tjj"].time > 24*60*60 then
	     quests["tjj"].time = os.time() - 22*60*60
		 SetVariable("timetjj",quests["tjj"].time)
	     if quests["tjj"].auto==nil or quests["tjj"].auto == 0 then
	        quests["tjj"].auto = 1
	     end
	     if quests["tjj"].auto == 1 then
		    exe('pray pearl')
		    return "questtjj"
	     end
	  else
	     if quests["tjj"].auto == 1 and quests["tjj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["tjj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["tjj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function tjjTongji()
    if GetVariable("autotjj") and quests["tjj"] and quests["tjj"].auto == 1 and quests["tjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tjj"].time)
	   checkQuestNote(quests["tjj"].name,l_time)
	end
end

function questtjj()
    return go(tjjAsk,"�䵱ɽ","��ɽСԺ")
end
function tjjAsk()
    if locl.room~="��ɽСԺ" then
	   return questTjj()
	end
	if not locl.id["������"] then
       return tjjBusy()	   
	end
	DeleteTriggerGroup("tjj")
    create_trigger_t('tjj1',"^(> )*��������������йء�̫��������������Ϣ",'','tjjAccept')
    create_trigger_t('tjj2',"^(> )*����û������ˡ�$",'','tjjBusy')
    SetTriggerOption("tjj1","group","tjj")
    SetTriggerOption("tjj2","group","tjj")
	questStartLog(quests["tjj"].name)
	exe("ask zhang sanfeng about ̫��������")
end
function tjjAccept()
    EnableTriggerGroup("tjj",false)
	DeleteTriggerGroup("accept")
	create_trigger_t('accept1',"^(> )*(���������У�ͻȻ��|���������˵�����㲻���Ѿ������)",'','tjjSucc')
	create_trigger_t('accept2','^(> )*��ץ����������˼ڤ�룬�����Լ������޷����','','tjjFail')
	create_trigger_t('accept3',"^(> )*������(����|)˵����(��|)���ĸ����꣬���Ƶ��ɧ����",'','tjjBusy')
	SetTriggerOption("accept1","group","accept")
    SetTriggerOption("accept2","group","accept")
	SetTriggerOption("accept3","group","accept")
end
function tjjBusy()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time() - 20*60*60
	return check_bei(tjjOver)
end
function tjjFail()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time()
	return check_bei(tjjOver)
end
function tjjSucc()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time()
	quests["tjj"].auto = 2
	questSucLog(quests["tjj"].name)
	return check_bei(tjjOver)
end
function tjjOver()
	DeleteTriggerGroup("tjj")
	DeleteTriggerGroup("accept")
    SetVariable("timetjj",quests["tjj"].time)
	SetVariable("autotjj",quests["tjj"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end