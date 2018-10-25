quests = quests or {}
quests["feiwu"] = {}
quests["feiwu"].auto = 0
quests["feiwu"].name = "�������"

questTongji = questTongji or {}
questTongji["feiwu"] = "feiwuTongji"

questCal = questCal or {}
questCal["feiwu"] = "feiwuCal"

questList = questList or {}
questList["feiwu"] = function() if score.party and score.party=="��ɽ��" and skills["songshan-jian"] then return "�������" else return false end end


local feiwuRoom = {}

function feiwuCal()
    if score.party=="��ɽ��" and GetVariable("autofeiwu") and skills["songshan-jian"] then
      if GetVariable("timefeiwu") then
		 quests["feiwu"].time=tonumber(GetVariable("timefeiwu"))
	  end
	  if GetVariable("autofeiwu") then
		 quests["feiwu"].auto=tonumber(GetVariable("autofeiwu"))
	  end
	  if quests["feiwu"].time==nil or os.time()-quests["feiwu"].time > 24*60*60 then
	     quests["feiwu"].time = os.time() - 12*60*60
		 SetVariable("timefeiwu",quests["feiwu"].time)
	     if quests["feiwu"].auto==nil or quests["feiwu"].auto == 0 then
	        quests["feiwu"].auto = 1
	     end
	     if quests["feiwu"].auto == 1 then
		    exe('pray pearl')
		    return "questFeiwu"
	     end
	  else
	     if quests["feiwu"].auto == 1 and quests["feiwu"].time then
	        local l_time = 24*60*60 - (os.time() - quests["feiwu"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("�������",l_time)
			end
	     end
	     return false
	  end
   end
end
function feiwuTongji()
    if GetVariable("autofeiwu") and quests["feiwu"] and quests["feiwu"].auto == 1 and quests["feiwu"].time then
	   local l_time = 24*60*60 - (os.time() - quests["feiwu"].time)
	   checkQuestNote("�������",l_time)
	end
end
function questFeiwu()
    quests["feiwu"].time = os.time() - 20*60*60
	feiwuRoom = {}
    return go(feiwuFind,"��ɽ","����̨")
end
function feiwuFind()
    EnableTriggerGroup("feiwuFollow",false)
    if locl.id["�ѱ�"] then
	   return feiwuFollow()
	end
	
	feiwuRoom = feiwuRoom or {}
	if countTab(feiwuRoom) == 0 then
	   feiwuRoom = getCityRooms("��ɽ")
	end
	
	local from = road.id
	for i=1,countTab(feiwuRoom) do
	    local l_dest,l_p=getNearRoom(from,feiwuRoom)
		table.remove(feiwuRoom,l_p)
		if l_dest then
		   	--local path, len = map:getPath(from,l_dest)
	        --if path then
	        --   table.insert(road.rooms,l_dest)
			--end
			return go(feiwuFind,l_dest)
        end		   
    end
	
end
function feiwuFollow()
    DeleteTriggerGroup("feiwuFollow")
    create_trigger_t('feiwuFollow1',"^(> )*���������ѱ�һ���ж���",'','feiwuPre')
    create_trigger_t('feiwuFollow2',"^(> )*����û�� fei bin��$",'','feiwuFind')
    SetTriggerOption("feiwuFollow1","group","feiwuFollow")
    SetTriggerOption("feiwuFollow2","group","feiwuFollow")
    exe("follow fei bin")
end
function feiwuPre()
    EnableTriggerGroup("feiwuFollow",false)
    DeleteTriggerGroup("feiwuAsk")
    create_trigger_t('feiwuAsk1',"^(> )*����ѱ�����йء����շ塻����Ϣ",'','feiwuAsk')
    create_trigger_t('feiwuAsk2',"^(> )*����û������ˡ�$",'','feiwuNobody')
    SetTriggerOption("feiwuAsk1","group","feiwuAsk")
    SetTriggerOption("feiwuAsk2","group","feiwuAsk")
	exe('ask fei bin about ���շ�')
end
function feiwuAsk()
    EnableTriggerGroup("feiwuAsk",false)
	DeleteTriggerGroup("feiwu")
	create_trigger_t('feiwu1','^(> )*�ѱ�˵�����������ǲ�����˲ţ��Ҿ͸�������Щ�����Լ�ȥ����ȥ�ɡ���','','feiwuGo')
	SetTriggerOption("feiwu1","group","feiwu")
end
function feiwuGo()
    EnableTriggerGroup("feiwu",false)
	DeleteTriggerGroup("feiwu")
	return go(feuwuGuan,"��ɽ","���շ�")
end
function feuwuGuan()
    EnableTriggerGroup("feiwu",false)
	DeleteTriggerGroup("feiwuJue")
	create_trigger_t('feiwuJue1','^(> )*��� "action" �趨Ϊ "�������" �ɹ���ɡ�','','feiwuSucc')
	create_trigger_t('feiwuJue2','^(> )*��Ҳ̫�ڿ���ˣ�������Ҫ����Ŭ���ź�!','','feiwuFail')
	--create_trigger_t('feiwuJue3','^(> )*�ֺ�˵���������Ѿ��⿪�ˣ���','','feiwuSucc')
	create_trigger_t('feiwuJue4','^(> )*����ʧ�ܣ��㲻����Щ����ɥ��','','feiwuContinue')
	SetTriggerOption("feiwuJue1","group","feiwuJue")
    SetTriggerOption("feiwuJue2","group","feiwuJue")
	SetTriggerOption("feiwuJue3","group","feiwuJue")
	SetTriggerOption("feiwuJue4","group","feiwuJue")
	questStartLog(quests["feiwu"].name)
    exe('guanwu songtao;look')
	exe('alias action �������')
end
function feiwuSucc()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time()
	quests["feiwu"].auto = 2
	questSucLog(quests["feiwu"].name)
	return check_bei(feiwuOver)
end
function feiwuContinue()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time()
	return check_bei(feiwuOver)
end
function feiwuFail()
    EnableTriggerGroup("feiwu",false)
	EnableTriggerGroup("feiwuJue",false)
	quests["feiwu"].time = os.time() - 18*60*60
	return check_bei(feiwuOver)
end
function feiwuNobody()
    EnableTriggerGroup("feiwuAsk",false)
	EnableTriggerGroup("feiwuJue",false)
	EnableTriggerGroup("feiwuFollow",false)
	quests["feiwu"].time = os.time() - 22*60*60
	return check_bei(feiwuOver)
end
function feiwuOver()
	SetVariable("timefeiwu",quests["feiwu"].time)
	SetVariable("autofeiwu",quests["feiwu"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end