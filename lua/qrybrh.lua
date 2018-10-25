quests = quests or {}
quests["rybrh"] = {}
quests["rybrh"].auto = 0
quests["rybrh"].name = '���±��ں�'

questTongji = questTongji or {}
questTongji["rybrh"] = "rybrhTongji"

questCal = questCal or {}
questCal["rybrh"] = "rybrhCal"

questList = questList or {}
questList["rybrh"] = function() if score.party=="������" then return quests["rybrh"].name else return false end end


function rybrhCal()
    if GetVariable("autorybrh") and Bag["����"] and hp.shen>0 and score.party=="������" and skills["riyue-bian"] and skills["riyue-bian"].lvl>450 and skills["yinlong-bian"] and skills["yinlong-bian"].lvl>450 then
      if GetVariable("timerybrh") then
		 quests["rybrh"].time=tonumber(GetVariable("timerybrh"))
	  end
	  if GetVariable("autorybrh") then
		 quests["rybrh"].auto=tonumber(GetVariable("autorybrh"))
	  end
	  if quests["rybrh"].time==nil or os.time()-quests["rybrh"].time > 24*60*60 then
	     quests["rybrh"].time = os.time() - 22*60*60
		 SetVariable("timerybrh",quests["rybrh"].time)
	     if quests["rybrh"].auto==nil or quests["rybrh"].auto == 0 then
	        quests["rybrh"].auto = 1
	     end
	     if quests["rybrh"].auto == 1 then
		    exe('pray pearl')
		    return "questrybrh"
	     end
	  else
	     if quests["rybrh"].auto == 1 and quests["rybrh"].time then
	        local l_time = 24*60*60 - (os.time() - quests["rybrh"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["rybrh"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function rybrhTongji()
    if GetVariable("autorybrh") and Bag["����"] and hp.shen>0 and quests["rybrh"] and quests["rybrh"].auto == 1 and quests["rybrh"].time then
	   local l_time = 24*60*60 - (os.time() - quests["rybrh"].time)
	   checkQuestNote(quests["rybrh"].name,l_time)
	end
end

function questrybrh()
    return go(rybrhPre,"shaolin/fumoquan")
end
function rybrhPre()
    if not locl.id["�ɶ�"] then
	   quests["rybrh"].time = os.time() - 20*60*60
	   return check_bei(rybrhNobody)
	end
	EnableTriggerGroup("rybrhAsk",false)
    DeleteTriggerGroup("rybrhAsk")
    create_trigger_t('rybrhAsk1',"^(> )*����ɶ�����йء����±��ںϡ�����Ϣ",'','rybrhAsk')
    create_trigger_t('rybrhAsk2',"^(> )*����û������ˡ�$",'','rybrhNobody')
    SetTriggerOption("rybrhAsk1","group","rybrhAsk")
    SetTriggerOption("rybrhAsk2","group","rybrhAsk")
    
	return exe('askk du e about ���±��ں�')
end
function rybrhAsk()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1',"^(> )*�ɶ�˵�������㻹��ȥ��Ϣһ�°ɡ���",'','rybrhFail')
	create_trigger_t('rybrh2','^(> )*�ɶ����˵���������ŵı����˵���һ�������䲻�����±޵ĸվ�ǿ�ᣬ��ȴ�����仯֮���¡�','','rybrhgoem')
	SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
end
function rybrhgoem()
    EnableTriggerGroup("rybrhAsk",false)
    return go(rybrhgozhou,"chengdu/tulu1")
end  
function rybrhgozhou()
    return go(rybrhaskzhou,"emei/shanpo")
end
function rybrhaskzhou()
    EnableTriggerGroup("rybrhAsk",false)
    DeleteTriggerGroup("rybrhAsk")
    create_trigger_t('rybrhAsk1',"^(> )*���������������йء����������޼��ɡ�����Ϣ",'','rybrhAsk2')
    create_trigger_t('rybrhAsk2',"^(> )*����û������ˡ�$",'','rybrhNobody')
    SetTriggerOption("rybrhAsk1","group","rybrhAsk")
    SetTriggerOption("rybrhAsk2","group","rybrhAsk")
	return exe('askk zhou zhiruo about ���������޼���')
end
function rybrhAsk2()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1','^(> )*������˵���������Ѿ������������޵������ڻ��ͨ������ǲ��ô����','','rybrhSucc')
	create_trigger_t('rybrh2','^(> )*������˵�������������ģ��Ұ������ķ������ڲؾ�¥������ȥ����,�ܷ�õ��Ϳ���Ļ�Ե�ˡ���','','rybrhgocjl')
    SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
	--������˵���������Ѿ������������޵������ڻ��ͨ������ǲ��ô����
end

function rybrhgocjl()
    return go(rybrhfanshu,"emei/cangjinglou")
end
function rybrhfanshu()
    rybrhAsk3()
	questStartLog(quests["rybrh"].name)
	return exe('fan ����')
end
function rybrhAsk3()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1',"^(> )*���������޷�����ʧ�ܣ�",'','rybrhContinue')
	create_trigger_t('rybrh2','^(> )*��������޵���ʽ��ͷ��ʼ������һ·�����������������硣','','rybrhSucc')
	create_trigger_t('rybrh3',"^(> )*������̫Ƶ����,���������ɻ�!",'','rybrhFail')
	create_trigger_t('rybrh4',"^(> )*��������޷�����450�����ɶ�û��",'','rybrhDel')
	SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
    SetTriggerOption("rybrh3","group","rybrh")
	SetTriggerOption("rybrh4","group","rybrh")
	--�㰴����������ָ�㣬����Լ���ϰ���ã��������޷��İ����ƺ���Щ�ĵá�
    --��������޵���ʽ��ͷ��ʼ������һ·�����������������硣Խ��Խ�Ǵ��졣
    --��Ȼ�䣬�����һ������ǰ�������Ҳ�벻���׵������Ȼ���Ȼ��ͨ���̲�ס������Ц.
end
function rybrhDel()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = 0
	quests["rybrh"].auto = 0
	DeleteVariable("timerybrh")
	DeleteVariable("autorybrh")
	CloseLog()
	return check_bei(checkQuestOver)
end
function rybrhSucc()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time()
	quests["rybrh"].auto = 2
	questSucLog(quests["rybrh"].name)
	return check_bei(rybrhOver)
end
function rybrhContinue()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time()
	return check_bei(rybrhOver)
end
function rybrhFail()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time() - 16*60*60
	return check_bei(rybrhOver)
end
function rybrhNobody()
    EnableTriggerGroup("rybrhAsk",false)
	quests["rybrh"].time = os.time() - 18*60*60
	return check_bei(rybrhOver)
end
function rybrhOver()
    CloseLog()
	DeleteTriggerGroup("rybrhAsk")
	DeleteTriggerGroup("rybrh")
	SetVariable("timerybrh",quests["rybrh"].time)
	SetVariable("autorybrh",quests["rybrh"].auto)
    return check_bei(checkQuestOver)
end