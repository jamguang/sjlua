quests = quests or {}
quests["anran"] = {}
quests["anran"].auto = 0
quests["anran"].name = '��Ȼ������'

questTongji = questTongji or {}
questTongji["anran"] = "anranTongji"

questCal = questCal or {}
questCal["anran"] = "anranCal"

questList = questList or {}
questList["anran"] = function() if skills["force"] and skills["force"].lvl>500 and score.gender=="��" then return quests["anran"].name else return false end end


function anranCal()
    if GetVariable("autoanran") and skills["force"] and skills["force"].lvl>500 and score.gender=="��" then
      if GetVariable("timeanran") then
		 quests["anran"].time=tonumber(GetVariable("timeanran"))
	  end
	  if GetVariable("autoanran") then
		 quests["anran"].auto=tonumber(GetVariable("autoanran"))
	  end
	  if quests["anran"].time==nil or os.time()-quests["anran"].time > 24*60*60 then
	     quests["anran"].time = os.time() - 12*60*60
		 SetVariable("timeanran",quests["anran"].time)
	     if quests["anran"].auto==nil or quests["anran"].auto == 0 then
	        quests["anran"].auto = 1
	     end
	     if quests["anran"].auto == 1 then
		    exe('pray pearl')
		    return "questanran"
	     end
	  else
	     if quests["anran"].auto == 1 and quests["anran"].time then
	        local l_time = 24*60*60 - (os.time() - quests["anran"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["anran"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function anranTongji()
    if GetVariable("autoanran") and quests["anran"] and quests["anran"].auto == 1 and quests["anran"].time then
	   local l_time = 24*60*60 - (os.time() - quests["anran"].time)
	   checkQuestNote(quests["anran"].name,l_time)
	end
end

--��Ȼ������
function questanran()
   return go(anranAsk,"gumu/jqg/xiaoshi","")
end
function anranAsk()
    if locl.room~="С��" then
	   return questanran()
	end
	if not locl.id["���"] then
            return anranBusy()	   
	end
        flag.idle=-60
	DeleteTriggerGroup("anran")
    create_trigger_t('anran1',"^(> )*������������йء���Ȼ�����ơ�����Ϣ��",'','anranAccept')
    create_trigger_t('anran2',"^(> )*����û������ˡ�$",'','anranBusy')
    SetTriggerOption("anran1","group","anran")
    SetTriggerOption("anran2","group","anran")
	--local logfile = GetInfo(59) .. "/log/������Ȼ������-"..score.id .."-"..os.time() .. ".txt"
	--OpenLog (logfile , false)
	questStartLog(quests["anran"].name)
	exe('pray pearl')
	
	return exe('ask yang guo about ��Ȼ������')
end
function anranAccept()
    EnableTriggerGroup("anran",false)
	DeleteTriggerGroup("accept")
	create_trigger_t('accept1',"^(> )*(*�ɹ�*|*��ϲ��*)",'','anranSucc')
	--create_trigger_t('accept2','^(> )*������Ȼ�����ƾ�������ʧ�ܣ�','','anranFail')	
	create_trigger_t('accept2','^(> )*�㳤̾һ�������������˵�������������������Ȼ�Ʒ����ǲ��ýⰡ','','anranFail')	
	create_trigger_t('accept3',"^(> )*���˵��������λ",'','anranBusy')
	create_trigger_t('accept4',"^(> )*���˵������û���Һ�æô",'','anranWait')
	create_trigger_t('accept5',"^(> )*��������㡸����������Ц������",'','anranTrigger')
	SetTriggerOption("accept1","group","accept")
    SetTriggerOption("accept2","group","accept")
    SetTriggerOption("accept3","group","accept")
	SetTriggerOption("accept4","group","accept")
	SetTriggerOption("accept5","group","accept")
end
function anranTrigger()
    EnableTrigger("accept3",false)
    EnableTrigger("accept4",false)
    EnableTrigger("accept5",false)
end
function anranBusy()
    EnableTriggerGroup("anran",false)
	EnableTriggerGroup("accept",false)
	quests["anran"].time = os.time() - 20*60*60
	return check_bei(anranOver)
end
function anranWait()
    EnableTriggerGroup("anran",false)
	EnableTriggerGroup("accept",false)
	quests["anran"].time = os.time()
	return check_bei(anranAsk,1)
end
function anranFail()
    EnableTriggerGroup("anran",false)
	EnableTriggerGroup("accept",false)
	quests["anran"].time = os.time()
	return check_bei(anranOver)
end
function anranSucc()
    EnableTriggerGroup("anran",false)
	EnableTriggerGroup("accept",false)
	quests["anran"].time = os.time()
	quests["anran"].auto = 2
    questSucLog(quests["anran"].name)
	return check_bei(anranOver)
end
function anranOver()
	DeleteTriggerGroup("anran")
	DeleteTriggerGroup("accept")
    SetVariable("timeanran",quests["anran"].time)
	SetVariable("autoanran",quests["anran"].auto)
    CloseLog()
	return check_bei(checkQuestOver)
end