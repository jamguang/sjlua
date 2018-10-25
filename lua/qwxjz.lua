quests = quests or {}
quests["wxjz"] = {}
quests["wxjz"].auto = 0
quests["wxjz"].name = '�����ָ'

questTongji = questTongji or {}
questTongji["wxjz"] = "wxjzTongji"

questCal = questCal or {}
questCal["wxjz"] = "wxjzCal"

questList = questList or {}
questList["wxjz"] = function() if score.party and score.party == "������" then return quests["wxjz"].name else return false end end


function wxjzCal()
    if GetVariable("autowxjz") and score.party and score.party == "������" and jobtimes and jobtimes["���־�Ԯ"] and jobtimes["���־�Ԯ"]>1200 then
      if GetVariable("timewxjz") then
		 quests["wxjz"].time=tonumber(GetVariable("timewxjz"))
	  end
	  if GetVariable("autowxjz") then
		 quests["wxjz"].auto=tonumber(GetVariable("autowxjz"))
	  end
	  if quests["wxjz"].time==nil or os.time()-quests["wxjz"].time > 24*60*60 then
	     quests["wxjz"].time = os.time() - 22*60*60
		 SetVariable("timewxjz",quests["wxjz"].time)
	     if quests["wxjz"].auto==nil or quests["wxjz"].auto == 0 then
	        quests["wxjz"].auto = 1
	     end
		 if skills["wuxiang-zhi"] and quests["wxjz"].auto == 1 then
	        quests["wxjz"].auto = 2
	     end
	     if quests["wxjz"].auto <3 then
		    exe('pray pearl')
		    return "questwxjz"
	     end
	  else
	     if quests["wxjz"].auto == 1 and quests["wxjz"].time then
	        local l_time = 24*60*60 - (os.time() - quests["wxjz"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["wxjz"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function wxjzTongji()
    if GetVariable("autowxjz") and quests["wxjz"] and quests["wxjz"].auto < 3 and quests["wxjz"].time then
	   local l_time = 24*60*60 - (os.time() - quests["wxjz"].time)
	   checkQuestNote(quests["wxjz"].name,l_time)
	end
end

function questwxjz()
    return go(wxjzPre,"��ɽ����","������")
end
function wxjzPre()
    if locl.id["������ʦ"] then
	   EnableTrigger("fight16",false)
	   if not Bag["�ӹ�"] then
	      exe('ask fangsheng about �ӹ�')
		  checkBags()
		  return go(wxjzPre,"��ɽ����","������")
	   end
	   if not Bag["����"] then
	      exe('ask fangsheng about ����')
		  checkBags()
		  return go(wxjzPre,"��ɽ����","������")
	   end
	   exe('n')
	   exe('pray pearl')
	   for p in pairs(Bag) do
	       if Bag[p].kind then
		      for i = 1,Bag[p].cnt do
			      exe('drop '..Bag[p].fullid)
			  end
		   end
	   end
	   exe('drop silver')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzAsk,1)
	else
	   quests["wxjz"].time = os.time() - 23*60*60
	   return check_bei(wxjzOver)
	end
end
function wxjzAsk()
    if locl.room=="������" then
	   exe('n')
	   exe('pray pearl')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzAsk,1)
	end
    if not locl.id["������ʦ"] then
	   quests["wxjz"].time = os.time() - 23*60*60
	   return check_bei(wxjzOver)
	end
	DeleteTriggerGroup("wxjz")
    create_trigger_t('wxjz1',"^(> )*����������ʦ�����йء������ָ������Ϣ",'','wxjzSkill')
    create_trigger_t('wxjz2',"^(> )*����û������ˡ�$",'','wxjzNobody')
	create_trigger_t('wxjz3',"^(> )*����������ʦ�����йء��������������Ϣ",'','wxjzPfm')
    SetTriggerOption("wxjz1","group","wxjz")
    SetTriggerOption("wxjz2","group","wxjz")
	SetTriggerOption("wxjz3","group","wxjz")
	questStartLog(quests["wxjz"].name)
    if quests["wxjz"].auto < 2 then
	   wait.make(function()
	      exe('ask wuxiang chanshi about �����似')
	      wait.time(3)
	      exe('ask wuxiang chanshi about �����ָ')
	      exe('alias action �����ָ')
	   end)
	else
	   exe('ask wuxiang chanshi about �������')
	   exe('alias action �������')
	end
end
function wxjzPfm()
    EnableTriggerGroup("wxjz",false)
	DeleteTriggerGroup("wxjzPfm")
	create_trigger_t('wxjzPfm1',"^(> )*��\\D*����ʽ",'','wxjzPfmSucc')
	create_trigger_t('wxjzPfm2',"^(> )*������ʦ˵�����������Ƚ̵�������ɣ�����ɡ���",'','wxjzSkFail')
	create_trigger_t('wxjzPfm3','^(> )*��� "action" �趨Ϊ "�������" �ɹ���ɡ�$','','wxjzPfmContinue')
	SetTriggerOption("wxjzPfm1","group","wxjzPfm")
    SetTriggerOption("wxjzPfm2","group","wxjzPfm")
	SetTriggerOption("wxjzPfm3","group","wxjzPfm")
end
function wxjzPfmContinue()
    EnableTriggerGroup("wxjzPfm",false)
	quests["wxjz"].time = os.time()
	return check_bei(wxjzOver)
end
function wxjzPfmSucc()
    EnableTriggerGroup("wxjzPfm",false)
	quests["wxjz"].time = 999999999999
	quests["wxjz"].auto = 3
	questSucLog(quests["niqiu"].name.."����")
	return check_bei(wxjzOver)
end
function wxjzSkill()
    EnableTriggerGroup("wxjz",false)
	DeleteTriggerGroup("wxjzSk")
	create_trigger_t('wxjzSk1',"^(> )*��\\D*����ʽ",'','wxjzSkSucc')
	create_trigger_t('wxjzSk2',"^(> )*������ʦ˵�����������Ƚ̵�������ɣ�����ɡ���",'','wxjzSkFail')
	create_trigger_t('wxjzSk3','^(> )*��� "action" �趨Ϊ "�����ָ" �ɹ���ɡ�$','','wxjzSkContinue')
	SetTriggerOption("wxjzSk1","group","wxjzSk")
    SetTriggerOption("wxjzSk2","group","wxjzSk")
	SetTriggerOption("wxjzSk3","group","wxjzSk")
end
function wxjzSkSucc()
    EnableTriggerGroup("wxjzSk",false)
	quests["wxjz"].time = os.time()
	quests["wxjz"].auto = 2
	questSucLog(quests["niqiu"].name)
	return wxjzAsk()
end
function wxjzSkContinue()
    EnableTriggerGroup("wxjzSk",false)
	quests["wxjz"].time = os.time()
	return check_bei(wxjzOver)
end
function wxjzSkFail()
    EnableTriggerGroup("wxjzSk",false)
	EnableTriggerGroup("wxjzPfm",false)
	quests["wxjz"].time = os.time() - 16*60*60
	return check_bei(wxjzOver)
end
function wxjzNobody()
    EnableTriggerGroup("wxjz",false)
	quests["wxjz"].time = os.time() - 22*60*60
	return check_bei(wxjzOver)
end
function wxjzOver()
    exe('out;d;get all')
	DeleteTriggerGroup("wxjz")
	DeleteTriggerGroup("wxjzSk")
	DeleteTriggerGroup("wxjzPfm")
	SetVariable("timewxjz",quests["wxjz"].time)
	SetVariable("autowxjz",quests["wxjz"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end