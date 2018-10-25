quests = quests or {}
quests["yusuo"] = {}
quests["yusuo"].auto = 0
quests["yusuo"].name = '���������'

questTongji = questTongji or {}
questTongji["yusuo"] = "yusuoTongji"

questCal = questCal or {}
questCal["yusuo"] = "yusuoCal"

questList = questList or {}
questList["yusuo"] = function() if score.party and score.party=="ȫ���" and skills["jinguan-yusuojue"] and skills["jinguan-yusuojue"].lvl>99 then return quests["yusuo"].name else return false end end


function yusuoCal()
    if GetVariable("autoyusuo") and skills["jinguan-yusuojue"] and skills["jinguan-yusuojue"].lvl>99 then
        if GetVariable("timeyusuo") then
		    quests["yusuo"].time=tonumber(GetVariable("timeyusuo"))
	    end
	    if GetVariable("autoyusuo") then
		    quests["yusuo"].auto=tonumber(GetVariable("autoyusuo"))
	    end
		
	    if quests["yusuo"].time==nil or os.time()-quests["yusuo"].time > 24*60*60 then
	        quests["yusuo"].time = os.time() - 22*60*60
		    SetVariable("timeyusuo",quests["yusuo"].time)
	        if quests["yusuo"].auto==nil or quests["yusuo"].auto == 0 then
	            quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100)
	        end
			local yusuolvl = math.modf(skills["jinguan-yusuojue"].lvl/100)
	        if quests["yusuo"].auto <= yusuolvl then
		        exe('pray pearl')
		        return "questyusuo"
	        end
	    else
	        if quests["yusuo"].auto <= math.modf(skills["jinguan-yusuojue"].lvl/100) and quests["yusuo"].time then
	            local l_time = 24*60*60 - (os.time() - quests["yusuo"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["yusuo"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function yusuoTongji()
    if GetVariable("autoyusuo") and quests["yusuo"] and skills["jinguan-yusuojue"] and quests["yusuo"].auto <= math.modf(skills["jinguan-yusuojue"].lvl/100) and quests["yusuo"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yusuo"].time)
	   checkQuestNote(quests["yusuo"].name,l_time)
	end
end

function questyusuo()
    return go(yusuoQu,"���ݳ�","�ӻ���")
end
function yusuoQu()
    if locl.room ~= "�ӻ���" then
        return go(yusuoQu,"���ݳ�","�ӻ���")
    end
	tmp.i = 0
	exe("qu yusuo jingyao")
	checkBags()
	return check_bei(yusuoQuCheck,1)
end
function yusuoQuCheck()
    if not Bag["���������ʮ�ľ���Ҫ"] then
	    tmp.i = tmp.i or 1
		tmp.i = tmp.i + 1
		if tmp.i > 3 then
		    return yusuoGo()
		end
		return yusuoQu()
	end
	return yusuoGoChanfang()
end
function yusuoCun()
    if locl.room ~= "�ӻ���" then
        return go(yusuoCun,"���ݳ�","�ӻ���")
    end
	tmp.i = 0
	exe("cun yusuo jingyao")
	checkBags()
	return check_bei(yusuoCunCheck,1)
end
function yusuoCunCheck()
    if Bag["���������ʮ�ľ���Ҫ"] then
	    tmp.i = tmp.i or 1
		tmp.i = tmp.i + 1
		if tmp.i < 3 then
		    return yusuoCun()
		end
		return check_heal()
	end
	return check_heal()
end
function yusuoGo()
    return go(yusuoPre,"ȫ��","��Ϊ��")
end
function yusuoPre()
    if not locl.id["����"] then
	   quests["yusuo"].time = os.time() - 20*60*60
	   return check_bei(yusuoOver)
	end
    DeleteTriggerGroup("yusuoAsk")
    create_trigger_t('yusuoAsk1',"^(> )*�������ڴ����йء����������ʮ�ľ�������Ϣ��",'','yusuoAsk')
    create_trigger_t('yusuoAsk2',"^(> )*����û������ˡ�$",'','yusuoNobody')
	create_trigger_t('yusuoAsk3',"^(> )*����˵�����������ϲ������������ľ�Ҫô������",'','yusuoQuit')
	--create_trigger_t('yusuoAsk4',"^(> )*�������������������̫�٣�Ŀǰ�޷�����",'','yusuoDel')
	create_trigger_t('yusuoAsk5',"^(> )*����˵�����������Ȿ�������ġ������������Ҫ��������ȥ�Ҹ�����������������",'','yusuoGoChanfang')
    SetTriggerOption("yusuoAsk1","group","yusuoAsk")
    SetTriggerOption("yusuoAsk2","group","yusuoAsk")
	SetTriggerOption("yusuoAsk3","group","yusuoAsk")
	--SetTriggerOption("yusuoAsk4","group","yusuoAsk")
	SetTriggerOption("yusuoAsk5","group","yusuoAsk")
    --questStartLog(quests["yusuo"].name)
	return exe('askk ma about ���������ʮ�ľ�;score')
end
function yusuoGoChanfang()
	return go(yusuoCanwu,'ȫ��','����')
end
function yusuoCanwu()
	if locl.room ~="����" then 
		return check_bei(yusuoGoChanfang,2)
	end
	yusuoAsk()
	flag.idle=0
	questStartLog(quests["yusuo"].name)
	exe('sit;canwu ���������ʮ�ľ�')
end
function yusuoAsk()
    EnableTriggerGroup("yusuoAsk",false)
	DeleteTriggerGroup("yusuo")                                  
	create_trigger_t('yusuo1',"^(> )*������Ҫ��кͻ�Ե��̫Ƶ�������ã�",'','yusuoFail')
	create_trigger_t('yusuo2','^(> )*�������죬��Ȼ֪������������İ��أ����Ƕ�����ڻ��ͨ����������ȫȻ����Ҫ�졣','','yusuoContinue')
	create_trigger_t('yusuo3',"^(> )*��ֻ��һ�������Ƶ�����˲�������ζ�����",'','yusuoSucc')
	create_trigger_t('yusuo4',"^(> )*����ͼ��������������ȴ����",'','yusuoWait')
	create_trigger_t('yusuo5',"^(> )*�������������������̫�٣�Ŀǰ�޷�����",'','yusuoStop')
	SetTriggerOption("yusuo1","group","yusuo")
    SetTriggerOption("yusuo2","group","yusuo")
	SetTriggerOption("yusuo3","group","yusuo")
	SetTriggerOption("yusuo4","group","yusuo")
	SetTriggerOption("yusuo5","group","yusuo")
end
function yusuoWait()
    EnableTriggerGroup("yusuo",false)
    return checkWait(yusuoGoChanfang,10)
end
function yusuoStop()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100) + 1
	return check_bei(yusuoOver)
end
function yusuoSucc()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100) + 1
	questSucLog(quests["yusuo"].name.."��".. quests["yusuo"].auto-1 .."��")
	return check_bei(yusuoOver)
end
function yusuoContinue()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = math.modf(skills["jinguan-yusuojue"].lvl/100)
	return check_bei(yusuoOver)
end
function yusuoFail()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time() - 12*60*60
	return check_bei(yusuoOver)
end
function yusuoNobody()
    EnableTriggerGroup("yusuoAsk",false)
	quests["yusuo"].time = os.time() - 18*60*60
	return check_bei(yusuoOver)
end
function yusuoOver()
	SetVariable("timeyusuo",quests["yusuo"].time)
	SetVariable("autoyusuo",quests["yusuo"].auto)
	DeleteTriggerGroup("yusuoAsk")
	DeleteTriggerGroup("yusuo")
	--exe('stand;drop book') 
	exe('stand') 
    CloseLog()
	--return husongQuit()	
	return yusuoCun()
end
function yusuoQuit()
    EnableTriggerGroup("yusuo",false)
    DeleteTriggerGroup("yusuoAsk")
	DeleteTriggerGroup("yusuo")
    CloseLog()
	return husongQuit()
end
function yusuoDel()
    EnableTriggerGroup("yusuo",false)
	quests["yusuo"].time = os.time()
	quests["yusuo"].auto = 0
	DeleteVariable("timeyusuo")
	DeleteVariable("autoyusuo")
	CloseLog()
	return check_bei(checkQuestOver)
end