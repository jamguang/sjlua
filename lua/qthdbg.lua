quests = quests or {}
quests["thdbg"] = {}
quests["thdbg"].auto = 0
quests["thdbg"].name = '�һ����չ�'

questTongji = questTongji or {}
questTongji["thdbg"] = "thdbgTongji"

questCal = questCal or {}
questCal["thdbg"] = "thdbgCal"

questList = questList or {}
questList["thdbg"] = function() if score.party and score.party=="�һ���" and score.int and score.int>49 and score.con and score.con>49 and score.dex and score.dex>49 and skills["flute"] and skills["flute"].lvl>=200 and skills["force"] and skills["force"].lvl>=500 then return quests["thdbg"].name else return false end end


function thdbgCal()
    if GetVariable("autothdbg") and score.int and score.int>49 and score.con and score.con>49 and score.dex and score.dex>49 and skills["flute"] and skills["flute"].lvl>=200 and skills["force"] and skills["force"].lvl>=500 then
      if GetVariable("timethdbg") then
		 quests["thdbg"].time=tonumber(GetVariable("timethdbg"))
	  end
	  if GetVariable("autothdbg") then
		 quests["thdbg"].auto=tonumber(GetVariable("autothdbg"))
	  end
	  if quests["thdbg"].time==nil or os.time()-quests["thdbg"].time > 24*60*60 then
	     quests["thdbg"].time = os.time() - 22*60*60
		 SetVariable("timethdbg",quests["thdbg"].time)
	     if quests["thdbg"].auto==nil or quests["thdbg"].auto == 0 then
	        quests["thdbg"].auto = 1
	     end
	     if quests["thdbg"].auto == 1 then
		    exe('pray pearl')
		    return "questthdbg"
	     end
	  else
	     if quests["thdbg"].auto == 1 and quests["thdbg"].time then
	        local l_time = 24*60*60 - (os.time() - quests["thdbg"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["thdbg"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function thdbgTongji()
    if GetVariable("autothdbg") and quests["thdbg"] and quests["thdbg"].auto == 1 and quests["thdbg"].time then
	   local l_time = 24*60*60 - (os.time() - quests["thdbg"].time)
	   checkQuestNote(quests["thdbg"].name,l_time)
	end
end

function questthdbg()
   return go(thdbgPre,"�һ���","����ͤ")
end

function thdbgPre()
    if not locl.id["��ҩʦ"] then
	   quests["thdbg"].time = os.time() - 20*60*60
	   return check_bei(thdbgOver)
	end
    DeleteTriggerGroup("thdbgAsk")
    create_trigger_t('thdbgAsk1',"^(> )*�����ҩʦ�����йء��չء�����Ϣ��",'','thdbgAsk')
    create_trigger_t('thdbgAsk2',"^(> )*����û������ˡ�$",'','thdbgNobody')
    SetTriggerOption("thdbgAsk1","group","thdbgAsk")
    SetTriggerOption("thdbgAsk2","group","thdbgAsk")
	questStartLog(quests["thdbg"].name)
	return exe('askk huang yaoshi about �չ�')
end

function thdbgAsk()
    EnableTriggerGroup("thdbgAsk",false)
	DeleteTriggerGroup("thdbg")
	create_trigger_t('thdbg1',"^(> )*������Ҳ̫�ڿ��˵㣿",'','thdbgFail')
	create_trigger_t('thdbg2','^(> )*�һ����չ�ʧ��!','','thdbgContinue')
	create_trigger_t('thdbg3',"^(> )*��ϲ����|�չسɹ�",'','thdbgSucc')
	create_trigger_t('thdbg4',"^(> )*��ҩʦ(����|)˵����(|��)��ı̺�����̫����,����500������",'','thdbgDel')
	create_trigger_t('thdbg5',"^(> )*��ҩʦ(����|)˵����(|��)�ðɣ���Ȼ��������㣬�ҾͰ��ҵ�������ĵص������",'','thdbgGo')
	SetTriggerOption("thdbg1","group","thdbg")
    SetTriggerOption("thdbg2","group","thdbg")
	SetTriggerOption("thdbg3","group","thdbg")
	SetTriggerOption("thdbg4","group","thdbg")
	SetTriggerOption("thdbg5","group","thdbg")
end
function thdbgGo()
    EnableTriggerGroup("thdbg",false)
	return go(thdbgYue,"�һ���","����")
end
function thdbgYue()
    if locl.room~="����" then
	    return go(thdbgYue,"�һ���","����")
	end
	if Bag["ENCB"] and Bag["ENCB"].value >= 30 then
	    exe(gmDropStoneCmd())
	end
	exe("yue ya")
	locate()
	return checkWait(thdbgSit,2)
end
function thdbgSit()
    if locl.room=="����" then
	    exe("yue ya")
	    locate()
	    return checkWait(thdbgSit,2)
	end
	if locl.room~="�Խ��嶥" then
	    return go(thdbgYue,"�һ���","����")
	end
    return check_busy(thdbgSit1)
end
function thdbgSit1()
    exe('sit')
	return check_busy(thdbgAct)
end
function thdbgAct()
    DeleteTriggerGroup("thdbg")
	create_trigger_t('thdbg1',"^(> )*������Ҳ̫�ڿ��˵㣿",'','thdbgFail')
	create_trigger_t('thdbg2','^(> )*�㳤̾һ�������������','','thdbgContinue')
	create_trigger_t('thdbg3',"^(> )*�㾭�������������ڳ���",'','thdbgSucc')
	SetTriggerOption("thdbg1","group","thdbg")
    SetTriggerOption("thdbg2","group","thdbg")
	SetTriggerOption("thdbg3","group","thdbg")
    exe('biguan')
end
function thdbgSucc()
    EnableTriggerGroup("thdbg",false)
	questSucLog(quests["thdbg"].name)
	quests["thdbg"].time = os.time()
	quests["thdbg"].auto = 2
	return check_bei(thdbgOver)
end
function thdbgContinue()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time()
	return check_bei(thdbgOver)
end
function thdbgFail()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time() - 16*60*60
	return check_bei(thdbgOver)
end
function thdbgNobody()
    EnableTriggerGroup("thdbgAsk",false)
	quests["thdbg"].time = os.time() - 18*60*60
	return check_bei(thdbgOver)
end
function thdbgOver()
    CloseLog()
	SetVariable("timethdbg",quests["thdbg"].time)
	SetVariable("autothdbg",quests["thdbg"].auto)
	exe('yue ya;wd;wd;sd;d;wd;n')
    return check_bei(checkQuestOver)
end	
function thdbgDel()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time()
	quests["thdbg"].auto = 0
	DeleteVariable("timethdbg")
	DeleteVariable("autothdbg")
	CloseLog()
	return check_bei(checkQuestOver)
end