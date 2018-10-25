quests = quests or {}
quests["tjq"] = {}
quests["tjq"].auto = 0
quests["tjq"].name = '̫��ȭ����'

questTongji = questTongji or {}
questTongji["tjq"] = "tjqTongji"

questCal = questCal or {}
questCal["tjq"] = "tjqCal"

questList = questList or {}
questList["tjq"] = function() if score.party=="�䵱��" and score.int > 39 and score.str > 39 then return quests["tjq"].name else return false end end


function tjqCal()
    if GetVariable("autotjq") and score.party=="�䵱��" and score.int > 39 and score.str > 39 then
      if GetVariable("timetjq") then
		 quests["tjq"].time=tonumber(GetVariable("timetjq"))
	  end
	  if GetVariable("autotjq") then
		 quests["tjq"].auto=tonumber(GetVariable("autotjq"))
	  end
	  if quests["tjq"].time==nil or os.time()-quests["tjq"].time > 24*60*60 then
	     quests["tjq"].time = os.time() - 22*60*60
		 SetVariable("timetjq",quests["tjq"].time)
	     if quests["tjq"].auto==nil or quests["tjq"].auto == 0 then
	        quests["tjq"].auto = 1
	     end
	     if quests["tjq"].auto == 1 then
		    exe('pray pearl')
		    return "questtjq"
	     end
	  else
	     if quests["tjq"].auto == 1 and quests["tjq"].time then
	        local l_time = 24*60*60 - (os.time() - quests["tjq"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["tjq"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function tjqTongji()
    if GetVariable("autotjq") and quests["tjq"] and quests["tjq"].auto == 1 and quests["tjq"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tjq"].time)
	   checkQuestNote(quests["tjq"].name,l_time)
	end
end

function questtjq()
    return go(tjqAsk,"�䵱ɽ","��ɽСԺ")
end
function tjqAsk()
    if locl.room~="��ɽСԺ" then
	   return questTjq()
	end
	if not locl.id["������"] then
       return tjqBusy()	   
	end
	DeleteTriggerGroup("tjq")
    create_trigger_t('tjq1',"^(> )*��������������йء�̫��ȭ����������Ϣ",'','tjqAccept')
    create_trigger_t('tjq2',"^(> )*����û������ˡ�$",'','tjqBusy')
    SetTriggerOption("tjq1","group","tjq")
    SetTriggerOption("tjq2","group","tjq")
	questStartLog(quests["tjq"].name)
	exe("ask zhang sanfeng about ̫��ȭ����")
end
function tjqAccept()
    EnableTriggerGroup("tjq",false)
	DeleteTriggerGroup("accept")
	create_trigger_t('accept1',"^(> )*(���������У�ͻȻ��|���������˵�����㲻���Ѿ������̫������)",'','tjqSucc')
	create_trigger_t('accept2','^(> )*��ץ����������˼ڤ�룬�����Լ������޷����̫���������ڣ�����һ��Īչ��','','tjqFail')
	create_trigger_t('accept3',"^(> )*���������˵����(��|)���ĸ����꣬���������̫��ȭ��!",'','tjqBusy')
	SetTriggerOption("accept1","group","accept")
    SetTriggerOption("accept2","group","accept")
	SetTriggerOption("accept3","group","accept")
end
function tjqBusy()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time() - 20*60*60
	return check_bei(tjqOver)
end
function tjqFail()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time()
	return check_bei(tjqOver)
end
function tjqSucc()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time()
	quests["tjq"].auto = 2
	questSucLog(quests["tjq"].name)
	return check_bei(tjqOver)
end
function tjqOver()
	DeleteTriggerGroup("tjq")
	DeleteTriggerGroup("accept")
    SetVariable("timetjq",quests["tjq"].time)
	SetVariable("autotjq",quests["tjq"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end