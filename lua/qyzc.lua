quests = quests or {}
quests["yzc"] = {}
quests["yzc"].auto = 0
quests["yzc"].name = 'һָ������'

questTongji = questTongji or {}
questTongji["yzc"] = "yzcTongji"

questCal = questCal or {}
questCal["yzc"] = "yzcCal"

questList = questList or {}
questList["yzc"] = function() if score.party=="������" and skills["buddhism"] and  skills["buddhism"].lvl>160 and skills["yizhi-chan"] and skills["yizhi-chan"].lvl>200 then return quests["yzc"].name else return false end end


function yzcCal()
    if GetVariable("autoyzc") and score.party=="������" and skills["buddhism"] and  skills["buddhism"].lvl>160 and skills["yizhi-chan"] and skills["yizhi-chan"].lvl>200 then
      if GetVariable("timeyzc") then
		 quests["yzc"].time=tonumber(GetVariable("timeyzc"))
	  end
	  if GetVariable("autoyzc") then
		 quests["yzc"].auto=tonumber(GetVariable("autoyzc"))
	  end
	  if quests["yzc"].time==nil or os.time()-quests["yzc"].time > 24*60*60 then
	     quests["yzc"].time = os.time() - 22*60*60
		 SetVariable("timeyzc",quests["yzc"].time)
	     if quests["yzc"].auto==nil or quests["yzc"].auto == 0 then
	        quests["yzc"].auto = 1
	     end
	     if quests["yzc"].auto == 1 then
		    exe('pray pearl')
		    return "questyzc"
	     end
	  else
	     if quests["yzc"].auto == 1 and quests["yzc"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yzc"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["yzc"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function yzcTongji()
    if GetVariable("autoyzc") and quests["yzc"] and quests["yzc"].auto == 1 and quests["yzc"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yzc"].time)
	   checkQuestNote(quests["yzc"].name,l_time)
	end
end

function questyzc()
   return go(yzcPre,"shaolin/chanfang-1")
end
function yzcPre()
    if not locl.id["���δ�ʦ"] then
	   quests["yzc"].time = os.time() - 20*60*60
	   return check_bei(yzcOver)
	end
    DeleteTriggerGroup("yzcAsk")
    create_trigger_t('yzcAsk1',"^(> )*�������δ�ʦ�����йء�һָ��������Ϣ",'','yzcAsk')
    create_trigger_t('yzcAsk2',"^(> )*����û������ˡ�$",'','yzcNobody')
    SetTriggerOption("yzcAsk1","group","yzcAsk")
    SetTriggerOption("yzcAsk2","group","yzcAsk")
	return exe('ask xuancheng dashi about һָ��')
end
function yzcAsk()
    EnableTriggerGroup("yzcAsk",false)
	return go(yzcCanwu,"��ɽ����","��Ħ��")
end
function yzcCanwu()
    if locl.room ~= "��Ħ��" then
	    return go(yzcCanwu,"��ɽ����","��Ħ��")
	end
	DeleteTriggerGroup("yzc")
    create_trigger_t('yzc1',"^(> )*�������죬�ķ����ң����Ѿ�������",'','yzcContinue')
    create_trigger_t('yzc2',"^(> )*������Ҳ̫�ڿ���ˣ�",'','yzcFail')
	create_trigger_t('yzc3','^(> )*��� "action" �趨Ϊ "����һָ��" �ɹ���ɡ�','','yzcSucc')
    SetTriggerOption("yzc1","group","yzc") --���Ѿ�ͨ����Ħ��Ħͼ��������һָ���İ��
    SetTriggerOption("yzc2","group","yzc")
	SetTriggerOption("yzc3","group","yzc")
	questStartLog(quests["yzc"].name)
	exe('canwu һָ��')
	exe('alias action ����һָ��')
end
function yzcSucc()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time()
	quests["yzc"].auto = 2
	questSucLog(quests["yzc"].name)
	return check_bei(yzcOver)
end
function yzcContinue()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time()
	return check_bei(yzcOver)
end
function yzcFail()
    EnableTriggerGroup("yzc",false)
	quests["yzc"].time = os.time() - 12*60*60
	return check_bei(yzcOver)
end
function yzcNobody()
    EnableTriggerGroup("yzcAsk",false)
	quests["yzc"].time = os.time() - 18*60*60
	return check_bei(yzcOver)
end
function yzcOver()
	SetVariable("timeyzc",quests["yzc"].time)
	SetVariable("autoyzc",quests["yzc"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end