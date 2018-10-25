quests = quests or {}
quests["cibei"] = {}
quests["cibei"].auto = 0
quests["cibei"].name = "�ȱ�������"

questTongji = questTongji or {}
questTongji["cibei"] = "cibeiTongji"

questCal = questCal or {}
questCal["cibei"] = "cibeiCal"

questList = questList or {}
questList["cibei"] = function() if score.party and score.party=="������" and skills["cibei-dao"] then return quests["cibei"].name else return false end end


function cibeiCal()
    if score.party=="������" and GetVariable("autocibei") and skills["cibei-dao"] then
      if GetVariable("timecibei") then
		 quests["cibei"].time=tonumber(GetVariable("timecibei"))
	  end
	  if GetVariable("autocibei") then
		 quests["cibei"].auto=tonumber(GetVariable("autocibei"))
	  end
	  if quests["cibei"].time==nil or os.time()-quests["cibei"].time > 24*60*60 then
	     quests["cibei"].time = os.time() - 22*60*60
		 SetVariable("timecibei",quests["cibei"].time)
	     if quests["cibei"].auto==nil or quests["cibei"].auto == 0 then
	        quests["cibei"].auto = 1
	     end
	     if quests["cibei"].auto == 1 then
		    exe('pray pearl')
		    return "questCibei"
	     end
	  else
	     if quests["cibei"].auto == 1 and quests["cibei"].time then
	        local l_time = 24*60*60 - (os.time() - quests["cibei"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("�ȱ�������",l_time)
			end
	     end
	     return false
	  end
   end
end
function cibeiTongji()
    if GetVariable("autocibei") and quests["cibei"] and quests["cibei"].auto == 1 and quests["cibei"].time then
	   local l_time = 24*60*60 - (os.time() - quests["cibei"].time)
	   checkQuestNote("�ȱ�������",l_time)
	end
end
function questCibei()
   return go(cibeiPre,"��ɽ����","��ĦԺ")
end
function cibeiPre()
    if not locl.id["������ʦ"] then
	   quests["cibei"].time = os.time() - 20*60*60
	   return check_bei(cibeiOver)
	end
    DeleteTriggerGroup("cibeiAsk")
    create_trigger_t('cibeiAsk1',"^(> )*����������ʦ�����йء��ȱ�������������Ϣ",'','cibeiAsk')
    create_trigger_t('cibeiAsk2',"^(> )*����û������ˡ�$",'','cibeiNobody')
    SetTriggerOption("cibeiAsk1","group","cibeiAsk")
    SetTriggerOption("cibeiAsk2","group","cibeiAsk")
	exe('ask xuanbei dashi about �ȱ�������')
end
function cibeiAsk()
    EnableTriggerGroup("cibeiAsk",false)
	DeleteTriggerGroup("cibei")
	create_trigger_t('cibei1',"^(> )*������ʦ˵������������ѧ���Ը��������ȱ������⡣��",'','cibeiGo')
	create_trigger_t('cibei2','^(> )*������ʦ����˵�������򰡣�','','cibeiFail')
	SetTriggerOption("cibei1","group","cibei")
    SetTriggerOption("cibei2","group","cibei")
end
function cibeiGo()
    EnableTriggerGroup("cibei",false)
	return go(cibeiXin,"������","��ͯ����")
end
function cibeiXin()
    if not locl.id["�Ĺ۴�ʦ"] then
	   quests["cibei"].time = os.time() - 20*60*60
	   return check_bei(cibeiOver)
	end
    DeleteTriggerGroup("cibeiAsk")
    create_trigger_t('cibeiAsk1',"^(> )*�����Ĺ۴�ʦ�����йء��ȱ�������������Ϣ",'','cibeiXinAsk')
    create_trigger_t('cibeiAsk2',"^(> )*����û������ˡ�$",'','cibeiNobody')
    SetTriggerOption("cibeiAsk1","group","cibeiAsk")
    SetTriggerOption("cibeiAsk2","group","cibeiAsk")
	questStartLog(quests["cibei"].name)
	exe('ask xinguan dashi about �ȱ�������')
	exe('alias action �ȱ�������')
end
function cibeiXinAsk()
    EnableTriggerGroup("cibeiAsk",false)
	DeleteTriggerGroup("cibei")
	create_trigger_t('cibei1',"^(> )*�Ĺ۴�ʦ˵��������̫�ڿ��ˣ���ɮ�Ҳ���ɧ�ţ���",'','cibeiFail')
	create_trigger_t('cibei2','^(> )*�������Ĺ۴�ʦ��ָ�㣬��Ȼ�����˴ȱ������İ���','','cibeiContinue')
	create_trigger_t('cibei3','^(> )*��� "action" �趨Ϊ "�ȱ�������" �ɹ���ɡ�','','cibeiSucc')
	create_trigger_t('cibei4','^(> )*������ǧ����࣬���ڵó���Ը�����ȱ������ڻ��ͨ��','','cibeiSucc')
	SetTriggerOption("cibei1","group","cibei")
    SetTriggerOption("cibei2","group","cibei")
	SetTriggerOption("cibei3","group","cibei")
	SetTriggerOption("cibei4","group","cibei")
end
function cibeiSucc()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time()
	quests["cibei"].auto = 2
	questSucLog(quests["cibei"].name)
	return check_bei(cibeiOver)
end
function cibeiContinue()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time()
	return check_bei(cibeiOver)
end
function cibeiFail()
    EnableTriggerGroup("cibei",false)
	quests["cibei"].time = os.time() - 12*60*60
	return check_bei(cibeiOver)
end
function cibeiNobody()
    EnableTriggerGroup("cibeiAsk",false)
	quests["cibei"].time = os.time() - 18*60*60
	return check_bei(cibeiOver)
end
function cibeiOver()
	SetVariable("timecibei",quests["cibei"].time)
	SetVariable("autocibei",quests["cibei"].auto)
	DeleteTriggerGroup("cibeiAsk")
	DeleteTriggerGroup("cibei")
	CloseLog()
    return check_bei(checkQuestOver)
end