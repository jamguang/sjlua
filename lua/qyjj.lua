--[[
> �������ȴ�ʦ�����йء��׽������Ϣ��
���ȴ�ʦ˵������������Ҳ̫�ڿ�Ү����
> �������ȴ�ʦ�����йء�������á�����Ϣ��
���ȴ�ʦ˵�����������ʲô����
> ��ҥ�ԡ�ĳ�ˣ���˵��˹�������������ҵ���һ����������Ҫ��
�������ȴ�ʦ�����йء�һ�����ǡ�����Ϣ��
���ȴ�ʦ˵�����������ʲô����
]]

quests = quests or {}
quests["yjj"] = {}
quests["yjj"].auto = 0
quests["yjj"].name = '�׽����'

questTongji = questTongji or {}
questTongji["yjj"] = "yjjTongji"

questCal = questCal or {}
questCal["yjj"] = "yjjCal"

questList = questList or {}
questList["yjj"] = function() if score.party=="������" then return quests["yjj"].name else return false end end


function yjjCal()
    if GetVariable("autoyjj") and Bag["����"] and score.party=="������" and score.con and score.con>39 then
      if GetVariable("timeyjj") then
		 quests["yjj"].time=tonumber(GetVariable("timeyjj"))
	  end
	  if GetVariable("autoyjj") then
		 quests["yjj"].auto=tonumber(GetVariable("autoyjj"))
	  end
	  if quests["yjj"].time==nil or os.time()-quests["yjj"].time > 24*60*60 then
	     quests["yjj"].time = os.time() - 22*60*60
		 SetVariable("timeyjj",quests["yjj"].time)
	     if quests["yjj"].auto==nil or quests["yjj"].auto == 0 then
	        quests["yjj"].auto = 1
	     end
	     if quests["yjj"].auto == 1 then
		    exe('pray pearl')
		    return "questyjj"
	     end
	  else
	     if quests["yjj"].auto == 1 and quests["yjj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yjj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["yjj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function yjjTongji()
    if GetVariable("autoyjj") and Bag["����"] and quests["yjj"] and quests["yjj"].auto == 1 and quests["yjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yjj"].time)
	   checkQuestNote(quests["yjj"].name,l_time)
	end
end

function questyjj()
    if not Bag["����"] then
	   return yjjFire()
	end
	return yjjBfGo()
end
function yjjFire()
    return go(yjjFireBuy,"������","�ӻ���")
end
function yjjFireBuy()
    exe('buy fire')
	checkBags()
	return check_busy(questYjj)
end
function yjjBfGo()
    flag.idle = 0
    if Bag["��ɫ����"] then
	   return yjjXinGo()
	end
    return go(yjjBfAsk,"������","����ˮ�")
end
function yjjBfAsk()
    if locl.room ~= "����ˮ�" or not locl.id["����"] then
	   return yjjBfGo()
	end
	exe('ask a zhu about ������')
	wait.make(function() 
       wait.time(3)
	   exe('ask a zhu about ����')
	   wait.time(3)
	   exe('ask a zhu about ��Ƥ���')
	   wait.time(3)
	   exe('ask a zhu about ��Ը')
	   checkBags()
	   return check_bei(yjjBfGo)
	end)
end
function yjjXinGo()
    flag.idle = 0
    if Bag["�ױ��ź�"] then
	   return yjjMjGo()
	end
	return go(yjjXinAsk,"��ɽ����","֤��Ժ")
end
function yjjXinAsk()
    if locl.room ~= "֤��Ժ" or not locl.id["������ʦ"] then
	   return yjjXinGo()
	end
	exe('ask xuansheng dashi about �׽')
	wait.make(function() 
       wait.time(3)
	   exe('give bao fu to xuansheng dashi')
	   checkBags()
	   return check_bei(yjjXinGo)
	end)
end
function yjjMjGo()
    flag.idle = 0
    if Bag["���"] then
	   return yjjFzGo()
	end
	return go(yjjMjAsk,"������","����ˮ�")
end
function yjjMjAsk()
    if locl.room ~= "����ˮ�" or not locl.id["����"] then
	   return yjjMjGo()
	end
	exe('give xuanci letter to a zhu')
	checkBags()
	return check_bei(yjjMjGo)
end
function yjjFzGo()
    flag.idle = 0
    return go(yjjFzAsk,"��ɽ����","������")
end
function yjjFzAsk()
    if locl.room ~= "������" or not locl.id["���ȴ�ʦ"] then
	   return yjjFzGo()
	end
	DeleteTriggerGroup("yjjask")
	create_trigger_t('yjjask1',"^(> )*���ȴ�ʦ˵������������Ҳ̫�ڿ�Ү����",'','yjjBusy')
	create_trigger_t('yjjask2','^(> )*���ȴ�ʦ˵�����������ʲô����','','yjjBusy')
	create_trigger_t('yjjask3','^(> )*���ȴ�ʦ˵�������׽���������ֵ�һ�似','','yjjFzask2')
	SetTriggerOption("yjjask1","group","yjjask")
    SetTriggerOption("yjjask2","group","yjjask")
	SetTriggerOption("yjjask3","group","yjjask")
	exe('ask xuanci about �׽')
end
function yjjFzask2()
    EnableTriggerGroup("yjjask",false)
	wait.make(function() 
       wait.time(3)
	   exe('ask xuanci about �������')
	   wait.time(3)
	   exe('ask xuanci about һ������')
	   return check_bei(yjjStart)
	end)
end
function yjjStart()
    flag.idle = 0
    return go(yjjWipe,"��ɽ����","�ؾ����¥")
end
function yjjWipe()
    return wipe("huizhen zunzhe",yjjLook)
end
function yjjLook()
    exe('look ͭ��;dian ����')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*������Ƭ�̣������л�ͷ����ͭ������һ�ۣ��������Լ��ı�Ӱ','','yjjJump')
	SetTriggerOption("yjj1","group","yjj")
end
function yjjJump()
    exe('jump up;kan down')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*�������Լ������������','','yjjJumpDown')
	SetTriggerOption("yjj1","group","yjj")
end
function yjjJumpDown()
    EnableTriggerGroup("yjj",false)
	return checkWait(yjjKill,3)
end 
function yjjKill()
    
	return wipe("dashi",yjjMo)
end
function yjjMo()
    flag.idle = 0
    exe('mo book')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*����Ȼ��֪�׽�����ڣ������Ե���������ܵõ��׽�洫��','','yjjFail')
	create_trigger_t('yjj2','^(> )*��ϲ�㣬���Ե�ɺϣ�����ǧ����࣬�����ڻ�������ֵ�һ��','','yjjSucc')
	SetTriggerOption("yjj1","group","yjj")
	SetTriggerOption("yjj2","group","yjj")
	questStartLog(quests["yjj"].name)
end
function yjjFail()
    EnableTriggerGroup("yjj",false)
	quests["yjj"].time = os.time()
	return yjjOver()
end
function yjjBusy()
    EnableTriggerGroup("yjj",false)
	EnableTriggerGroup("yjjask",false)
	quests["yjj"].time = os.time() - 20*60*60
	return yjjOver()
end
function yjjSucc()
    EnableTriggerGroup("yjj",false)
	quests["yjj"].time = os.time()
	quests["yjj"].auto = 2
	questSucLog(quests["yjj"].name)
	return yjjOver()
end
function yjjOver()
    SetVariable("timeyjj",quests["yjj"].time)
	SetVariable("autoyjj",quests["yjj"].auto)
	exe('drop mian ju')
	DeleteTriggerGroup("yjjask")
	DeleteTriggerGroup("yjj")
	CloseLog()
	return check_bei(checkQuestOver)
end