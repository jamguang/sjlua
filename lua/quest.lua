require "qyusui"
require "qdyys"
require "qfeiwu"
require "qluoying"
require "qlingxi"
require "qcibei"
require "qfuxue"
require "qbishen"
require "qruying"
require "qqianshou"
require "qtiezhou"
require "qmrqx"
require "qchaozong"
require "qqimen"
require "qsongyang"
require "qranmu"
require "qshoudao"
require "qlhss"
require "qsszongh"
require "qbzgjj"
require "qjdhj"
require "qsshbzq"
require "qniqiu"
require "qanran"
require "qrybrh"
require "qthd"
require "qbgz"
require "qyzc"
require "qynj"
require "qnxsz"
require "qwxjz"
require "qtzzd"
require "qals"
require "qyjj"
require "qxyj"
require "qtjq"
require "qtjj"
require "qbizhen"
require "qsjz"
require "qcuixin"
require "qcanhe"
require "qdzxy"
require "qfmq"
require "qqkdny"
require "qlengquan"
require "qwhdmd"
require "qwuhu"
require "qshenzhao"
require "qtiejiao"
require "qthdbg"
require "qbaduan"
require "qzhenlong"
require "qjuding"
require "qchongyang"
require "qyusuo"
require "qjianqi"


quests = quests or {}
quests["hubo"]={}
quests["hubo"].auto = 0
quests["hubo"].name = "˫�ֻ���"

quests["tlbb"]={}
quests["tlbb"].auto = 0
quests["tlbb"].name = "�����˲�"

quests["lcj"]={}
quests["lcj"].auto = 0
quests["lcj"].name = "���Ǿ�"

quests["fox"]={}
quests["fox"].auto = 0
quests["fox"].name = "ѩɽ�ɺ�"

quests["hero"]={}
quests["hero"].auto = 0
quests["hero"].name = "���Ӣ�۴�"


--[[
������������������������������������������������������������
                        ���ɺ��书��                        
������������������������������������������������������������
  �书��¼ʱ�䣺����һ����ʮ���¶��ն�ʮʱʮ���ֶ�ʮ���롣  
                   �书��¼���飺8673279��                  
--]]				  

function checkQuest()
   DeleteTriggerGroup("story")
   create_trigger_t('story1',"^(> )*(\\D*)�㻹��(|��)ѧϰ(\\D*)�Ļ��ᡣ",'','storySkilla')
   create_trigger_t('story2',"^(> )*(\\D*)��ʧȥ(|��)ѧϰ(\\D*)��(\\D*)�λ���",'','storySkilla')
   create_trigger_t('story3',"^(> )*(\\D*)������ӵ��(|��)ѧϰ(\\D*)�Ļ���",'','storySkilla')
   create_trigger_t('story4',"^(> )*(\\D*)(������ӵ�дӵ��ƴ�������߲�����վ��Ļ���|��ʧȥ�˵��ƴ��������վ���)",'','storySkillc')
   create_trigger_t('story5',"^(> )*(\\D*)(������ӵ���������վ��Ļ���|��ʧȥ�Ӷ����������վ���)",'','storySkilld')
   create_trigger_t('story6',"^(> )*(\\D*)��Ӷ���ѧ�����վ������������ʹ�����վ�����",'','storySkille')
   create_trigger_t('story7',"^(> )*(\\D*)��ӳ����紦����˳������������澭�¾�",'','storySkillf')
   create_trigger_t('story8',"^(> )*(\\D*)�Ѿ�ѧ����(\\D*)(��|��)",'','storySkillg')
   create_trigger_t('story9',"^(> )*(\\D*)��ӵ���ѧϰ����ʬ�����������������־�����",'','storySkillh')
   create_trigger_t('storya',"^(> )*(\\D*)���ִӵ��ƴ����һЩ���飬�����վ����Ÿ����ε�����",'','storySkillb')
   create_trigger_t('storyb',"^(> )*(\\D*)������(���˷�|���)���й�(\\D*)�����������(\\D*)ʤ����",'','storyFoxFight')
   SetTriggerOption("story1","group","story")
   SetTriggerOption("story2","group","story")
   SetTriggerOption("story3","group","story")
   SetTriggerOption("story4","group","story")
   SetTriggerOption("story5","group","story")
   SetTriggerOption("story6","group","story")
   SetTriggerOption("story7","group","story") 
   SetTriggerOption("story8","group","story")
   SetTriggerOption("story9","group","story") 
   SetTriggerOption("storya","group","story")
   SetTriggerOption("storyb","group","story")
   --EnableTriggerGroup("story",false)
   job.temp=job.last
   job.name="quest"
   exe('story')
   return check_bei(checkQuestCal)
end

function storySkilla(n,l,w)
    --print(w[4])
    if w[4] == "��ʬ����" then
        if quests["lcj"].auto == 0 or quests["lcj"].auto == 3 then
            quests["lcj"].auto = 5
	 	    SetVariable("autolcj",quests["lcj"].auto)
	    end
    end
    if w[4] == "�貨΢��" then
	    if quests["tlbb"].auto == 0 or quests["tlbb"].auto == 4 then
            quests["tlbb"].auto = 1
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if w[4] == "��ڤ��" then
	    quests["tlbb"].beiming = true
        if quests["tlbb"].auto == 0 or quests["tlbb"].auto == 2 then
            quests["tlbb"].auto = 3
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if string.find(w[4],"���ҵ���") then
        if quests["fox"].auto ==0 or quests["fox"].auto == 3 then
            quests["fox"].auto = 1
	        SetVariable("autofox",quests["fox"].auto)
	    end
    end
    if string.find(w[4],"��ҽ���") then
        if quests["fox"].auto ==0 or quests["fox"].auto == 3 then
            quests["fox"].auto = 2
	        SetVariable("autofox",quests["fox"].auto)
	    end
	    quests["fox"].mjjf = true
    end
	if w[4] == "��Ȫ��" then
	    if quests["fox"]["miao"] and quests["fox"]["hufei"] then
	        quests["fox"]["lengquan"] = true
		end
    end
end
function storyFoxFight(n,l,w)
    if w[3]=="���˷�" then
	    quests["fox"]["miao"] = true
	end
	if w[3]=="���" then
	    quests["fox"]["hufei"] = true
	end
end
function storySkillb()
    if quests["lcj"].auto == 2 then
        quests["lcj"].auto = 3
        SetVariable("autolcj",quests["lcj"].auto)
    end
    quests["lcj"].szj = true
	quests["lcj"]["shenzhao"] = true
	--if GetVariable("autoshenzhao") and GetVariable("autoshenzhao")=="1" then
	--    quests["lcj"].auto = 3
	--    SetVariable("autolcj",quests["lcj"].auto)
	--end
end
function storySkillc()
    if quests["lcj"].auto < 5 or quests["lcj"].auto == 7 then
        quests["lcj"].auto = 2
        SetVariable("autolcj",quests["lcj"].auto)
    end
    quests["lcj"].szj = true
end
function storySkilld()
    if quests["lcj"].auto < 5 or quests["lcj"].auto == 7 then
        quests["lcj"].auto = 1
        SetVariable("autolcj",quests["lcj"].auto)
    end
end
function storySkille()
   quests["lcj"].szj = true
end
function storySkillf()
    if GetVariable("autobgz") and quests["bgz"] and quests["bgz"].auto == 1 then 
        quests["bgz"].auto = 2
        SetVariable("autobgz",quests["bgz"].auto)
    end
end
function storySkillh()
    if quests["lcj"].auto == 0 or quests["lcj"].auto == 5 then
        quests["lcj"].auto = 6
	 	SetVariable("autolcj",quests["lcj"].auto)
    end
end
function storySkillg(n,l,w)
    --print(w[3])
    if string.find(w[3],"���ҵ���") then
        if quests["fox"].auto == 1 then
	        quests["fox"].auto = 2
	 	    SetVariable("autofox",quests["fox"].auto)
	    end
    end
    if string.find(w[3],"��ҽ���") then
        if quests["fox"].auto == 2 then
	        quests["fox"].auto = 3
	 	    SetVariable("autofox",quests["fox"].auto)
	    end
	    quests["fox"].mjjf = true
    end
	if string.find(w[3],"��Ȫ��") then
		if GetVariable("autolengquan") and GetVariable("autolengquan")=="1" then
		    quests["lengquan"].auto = 2
	        SetVariable("autolengquan",quests["lengquan"].auto)
		end
    end
	if string.find(w[3],"�貨΢��") then
	    if quests["tlbb"].auto == 1 then
            quests["tlbb"].auto = 2
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if string.find(w[3],"��ڤ��") then
        if quests["tlbb"].auto == 3 then
            quests["tlbb"].auto = 4
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
end
	  
function checkQuestOver()
    DeleteTriggerGroup("story")
    if job.temp then job.last = job.temp end
    job.temp = nil
    if Bag["��Ƥ"] or Bag["�����澭�¾�"] or Bag["����ͼ"] then
        return husongQuit()
    end
	if Bag["���"] then
	    exe('drop mian ju')
    end
	if Bag["���±���"] then
	    exe('drop baodao')
    end
    return check_bei(check_jobx,1)
end
function checkQuestTongji()
    if not drugPrepare["��������"] then
	    ColourNote ('white','red','QUEST��Ҫ��ʾ��׼��ҩƷ�б�û��ѡ���������飬����������Զ����ܣ�')
	end
    if quests["hubo"].auto and quests["hubo"].auto > 0 and quests["hubo"].auto < 3 then
        if GetVariable("timehubo") then
	        quests["hubo"].time=tonumber(GetVariable("timehubo"))
	    end
        if quests["hubo"].time then
	        local l_time = 24*60*60 - (os.time() - quests["hubo"].time)
	        checkQuestNote("˫�ֻ���",l_time)
	    end
    end
    if quests["lcj"].auto and (quests["lcj"].auto==1 or quests["lcj"].auto==2 or quests["lcj"].auto==5 or quests["lcj"].auto==6) then
        if GetVariable("timelcj") then
	        quests["lcj"].time=tonumber(GetVariable("timelcj"))
	    end
        if quests["lcj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lcj"].time)
	        checkQuestNote("�����书",l_time)
	    end
    end
    if quests["tlbb"].auto == 1 or quests["tlbb"].auto == 3 then
        if GetVariable("timetlbb") then
	        quests["tlbb"].time=tonumber(GetVariable("timetlbb"))
	    end
        if quests["tlbb"].time then
            local l_time = 24*60*60 - (os.time() - quests["tlbb"].time)
            checkQuestNote("�����书",l_time)
	    end 
    end
    
    if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3 then 
        if GetVariable("timefox") then
	        quests["fox"].time=tonumber(GetVariable("timefox"))
	    end
        if quests["fox"].time then
            local l_time
            if job.expAvg and job.expAvg > 0 then
	            l_time = (500000/job.expAvg) + 5
	        else
	            l_time = 9999
	        end
	        if canwu and canwu.exp and canwu.exp>0 then
	            l_time = 24
	        end
    	    local b_time = l_time*60*60 - (os.time() - quests["fox"].time)
    	    checkQuestNote("�ɺ��书",b_time)
	    end
    end
   
    questTongji = questTongji or {}
    for p,q in pairs(questTongji) do
        if _G[q] then
		    _G[q]()
	    end 
    end
end
function checkQuestNote(p_quest,p_time)
    if not p_quest or not p_time then return end
    if p_time <= 0 then 
	    ColourNote ('white','red','QUEST��ʾ�����������ڳ��Խ��ܡ�'.. p_quest ..'���������ע��')
    else   
        local l_hour= math.modf(p_time/3600)
        local l_min = math.modf((p_time-l_hour*3600)/60)
        local l_sec = p_time-l_hour*3600-l_min*60        
        ColourNote ('yellow','blue','QUEST��ʾ������һ�γ��Խ��ܡ�'.. p_quest ..'����Ż��С�'.. l_hour ..'Сʱ'.. l_min .. '��' .. l_sec ..'��' ..'����')
    end
end

questList = questList or {}
questList["hubo"] = function() if hp.exp>2000000 and skills["qimen-bagua"] and skills["qimen-bagua"].lvl>150 then return "˫�ֻ���" else return false end end


function checkQuestCal()
    EnableTriggerGroup("story",false)
	
	if not drugPrepare["��������"] then
	    return checkQuestOver()
	end
	
	dbVarCompareTime()
    
    if hp.exp>2000000 and skills["qimen-bagua"] and skills["qimen-bagua"].lvl>150 then
        if GetVariable("autohubo") then
	 	    quests["hubo"].auto=tonumber(GetVariable("autohubo"))
	    end
        if quests["hubo"].auto==nil or quests["hubo"].auto == 0 then
	        quests["hubo"].auto = 1
	    end
	    if GetVariable("timehubo") then
	 	    quests["hubo"].time=tonumber(GetVariable("timehubo"))
	    end
	    if quests["hubo"].time==nil then 
	        quests["hubo"].time = os.time() - 25*60*60
	    end
	    if os.time()-quests["hubo"].time > 24*60*60 then
	        if (quests["hubo"].auto==1 and hp.shen<0) then
	            return turnShen("+")
	 	    end
	    end 
	    if  (quests["hubo"].auto==1 and hp.shen>=0) or quests["hubo"].auto==2 then
	        if quests["hubo"].time==nil or os.time()-quests["hubo"].time > 24*60*60 then
	 	        quests["hubo"].time = os.time() - 18*60*60
	 	 	    SetVariable("timehubo",quests["hubo"].time)
	 	 	    exe('pray pearl')
	 	 	    return questHubo()
	        else
	 	        if quests["hubo"].time then
	 	 	        local l_time = 24*60*60 - (os.time() - quests["hubo"].time)
	 	 	        if l_time < 0 or l_time * math.random() < 1800 then
	 	 	            checkQuestNote("˫�ֻ���",l_time)
	 	 	        end
	 	 	    end
	 	    end
	    end
    end
   
    if quests["lcj"].auto and (quests["lcj"].auto==1 or quests["lcj"].auto==2 or quests["lcj"].auto==5 or quests["lcj"].auto==6) then
        if GetVariable("timelcj") then
	 	    quests["lcj"].time=tonumber(GetVariable("timelcj"))
	    end
        if quests["lcj"].time==nil or os.time()-quests["lcj"].time > 24*60*60 then
	 	    quests["lcj"].time = os.time() - 18*60*60
	 	    SetVariable("timelcj",quests["lcj"].time)
	 	    if GetVariable("autolcj") then
	 	        quests["lcj"].auto=tonumber(GetVariable("autolcj"))
	        end
            if quests["lcj"].auto == 5 or quests["lcj"].auto == 6 then
	            exe('pray pearl')
	 	        return questTsjf()
	        end
	 	    if quests["lcj"].auto == 1 then
	            exe('pray pearl')
	 	        return questSzj()
	        end
	 	    if quests["lcj"].auto == 2 then
	            exe('pray pearl')
	 	        return questSzjDy()
	        end
	    else
	 	    if quests["lcj"].time then
	 	 	    local l_time = 24*60*60 - (os.time() - quests["lcj"].time)
	 	 	    if l_time < 0 or l_time * math.random() < 1800 then
	 	 	        checkQuestNote("�����书",l_time)
	 	 	    end
	 	 	end
	    end
    end
   
    if quests["tlbb"].auto == 1 or quests["tlbb"].auto == 3 then
        if GetVariable("timetlbb") then
	 	    quests["tlbb"].time=tonumber(GetVariable("timetlbb"))
	    end
        if quests["tlbb"].time==nil or os.time()-quests["tlbb"].time > 24*60*60 then
	 	    quests["tlbb"].time = os.time() - 18*60*60
	 	    SetVariable("timetlbb",quests["tlbb"].time)
            if quests["tlbb"].auto > 0 then
	            exe('pray pearl')
	 	        return questLbwb()
	        end
	    else
	 	    if quests["tlbb"].auto > 0 and quests["tlbb"].time then
	 	 	    local l_time = 24*60*60 - (os.time() - quests["tlbb"].time)
	 	 	    if l_time < 0 or l_time * math.random() < 1800 then
	 	 	        checkQuestNote("�����书",l_time)
	 	 	    end
	 	 	end
	    end
    end
   
    if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3 then
	    --print(GetVariable("autofox"))
		--print(quests["fox"].auto)
        local l_time
        if GetVariable("timefox") then
	 	    quests["fox"].time=tonumber(GetVariable("timefox"))
	    end
	    --if GetVariable("autofox") and quests["fox"].auto==0 then
		if GetVariable("autofox") then
	 	    quests["fox"].auto=tonumber(GetVariable("autofox"))
	    end
	    if job.expAvg and job.expAvg > 0 then
	        l_time = (500000/job.expAvg) + 5
	    else
	        l_time = 9999
	    end
	    if canwu and canwu.exp and canwu.exp>0 then
	        l_time = 24
	    end
        if quests["fox"].time==nil or os.time()-quests["fox"].time > l_time*60*60 then
	 	    quests["fox"].time = os.time() - 12*60*60
	 	    SetVariable("timefox",quests["fox"].time)
	 	    SetVariable("autofox",quests["fox"].auto)
            if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3  then
	            exe('pray pearl')
	 	        return questFox()
	        end
	    else
	        if quests["fox"].auto > 0 and quests["fox"].time then
	 	 	    local b_time = l_time*60*60 - (os.time() - quests["fox"].time)
	 	 	    if b_time < 0 or b_time * math.random() < 1800 then
	 	 	        checkQuestNote("�ɺ��书",b_time)
	 	 	    end
	 	    end
	    end
    end
	
	questCal = questCal or {}
    for p,q in pairs(questCal) do
        if _G[q] then
		    local l_func =  _G[q]()
		    if l_func then
		        return _G[l_func]()
		    end
	    end 
    end

    return checkQuestOver()
end

function questFox()
    if quests["fox"].auto == 1 then
       return go(foxPre,"�ƺ�����","Ĺ��")
	else
	   return go(foxPre,"���ݳ�","����")
	end
end
function foxPre()
    if not locl.id["���"] and not locl.id["���˷�"] then
	   quests["fox"].time = os.time() - 23*60*60
	   return check_bei(foxOver)
	end
    DeleteTriggerGroup("hjdf")
    create_trigger_t('hjdf1',"^(> )*����(���|���˷�)�����йء�(���ҵ���|��ҽ���|�����ں�)������Ϣ",'','foxAsk')
    create_trigger_t('hjdf2',"^(> )*����û������ˡ�$",'','foxNobody')
    SetTriggerOption("hjdf1","group","hjdf")
    SetTriggerOption("hjdf2","group","hjdf")
	questStartLog(quests["fox"].name)
	if quests["fox"].auto == 1 then
	   exe('ask hu fei about ���ҵ���')
	elseif quests["fox"].auto == 2 then
	   exe('ask miao renfeng about ��ҽ���')
	else
	   exe('ask miao renfeng about �����ں�')
	end
end
function foxAsk()
    EnableTriggerGroup("hjdf",false)
	DeleteTriggerGroup("fox")
	create_trigger_t('fox1',"^(> )*(���|���˷�)˵���������㵱ǰ�ľ�����»�����������",'','foxFail')
	create_trigger_t('fox2',"^(> )*(���|���˷�)������ҡ��ҡͷ��",'','foxFail')
	create_trigger_t('fox3','^(> )*��ҡ��ҡͷ�������������Ǻ����ѵ�','','foxContinue')
	create_trigger_t('fox4',"^(> )*(���������˷��ָ�㣬����ҽ����ͺ��ҵ����İ����ƺ���������|�����˺�쳵�ָ�㣬�Ժ��ҵ����İ���|���������У�ͻȻ��������һ��|���˷�˵���������Ѿ������ں�)",'','foxSucc')
	SetTriggerOption("fox1","group","fox")
    SetTriggerOption("fox2","group","fox")
	SetTriggerOption("fox3","group","fox")
	SetTriggerOption("fox4","group","fox")
end
function foxSucc()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time()
	quests["fox"].auto = quests["fox"].auto + 1
	local l_name = "ѩɽ�ɺ�"
    if quests["fox"].auto==2 then l_name = "���ҵ���" end 
    if quests["fox"].auto==3 then l_name = "��ҽ���" end 
    if quests["fox"].auto==4 then l_name = "�����ں�" end 
    --if quests["fox"].auto==5 then l_name = "��Ȫ��" end 	
	questSucLog(l_name)
	return check_bei(foxOver)
end
function foxContinue()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time()
	return check_bei(foxOver)
end
function foxFail()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time() - 23*60*60
	return check_bei(foxOver)
end
function foxNobody()
    EnableTriggerGroup("hjdf",false)
	quests["fox"].time = os.time() - 13*60*60
	return check_bei(foxOver)
end
function foxOver()
    DeleteTriggerGroup("hjdf")
	DeleteTriggerGroup("fox")
	SetVariable("timefox",quests["fox"].time)
	SetVariable("autofox",quests["fox"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end

function questLbwb()
    return go(lbwbKetou,"����ɽ","����")
end
function lbwbKetou()
    
    if locl.room ~= "����" then
	    quests["tlbb"].time = os.time() - 20*60*60
	    return lbwbOver()
	end
	
	questStartLog(quests["tlbb"].name)
	
	if skills["lingbo-weibu"] then
	    quests["tlbb"].time = os.time()
	    return lbwbYanjiu()
	end
	
	exe('ketou yuxiang;l left;l right')
	exe('#10(ketou yuxiang)')
	
	return check_bei(lbwbBag,1)
end
function lbwbBag()
    exe('#10(ketou yuxiang)')
	checkBags()
	return check_busy(lbwbBojuan,1)
end
function lbwbBojuan()
    if Bag["����"] then
	    exe('pray pearl')
	    exe('#10(fan bo juan)')
		
	    return check_bei(lbwbContinue,1)
	else
	    quests["tlbb"].time = os.time() - 20*60*60
	    return lbwbYanjiu()
	end
end
function lbwbContinue()
    exe('#10(fan bo juan)')
	checkBags()
	quests["tlbb"].time = os.time()
	return check_busy(lbwbYanjiu)
end
function lbwbYanjiu()
    if quests["tlbb"].beiming then
        exe('#3(yanjiu picture)')
	end
	exe('cha')
	checkBags()
	return check_busy(lbwbOver)
end
function lbwbBook()
	quests["tlbb"].auto = 2
	SetVariable("autotlbb",quests["tlbb"].auto)
	questSucLog('�貨΢��')
	return dushu("bo juan")
end
function lbwbOver()
    
	if quests["tlbb"].auto == 1 and skills["lingbo-weibu"] then 
	    quests["tlbb"].auto = 2
	end
	if quests["tlbb"].auto == 3 and skills["beiming-shengong"] then
	    quests["tlbb"].auto = 4
	end
	SetVariable("timetlbb",quests["tlbb"].time)
	SetVariable("autotlbb",quests["tlbb"].auto)
    CloseLog()
	if Bag["����"] then
	    return lbwbBook()
	end
    return check_bei(checkQuestOver,1)
end

function questSzj()
    return go(questSzjChk,"���ݳ�","���ű�Ӫ")
end
function questSzjChk()
    if hp.exp>1000000 then
	   return wipe("zhao liangdong",questSzjGo)
	else
	   return questSzjGo()
	end
end
function questSzjGo()
    exe('west')
	locate()
	return check_busy(szjAsk,1)
end
function szjAsk()
    if not locl.id["����"] then
	   return check_bei(tsjfOver)
	end
    DeleteTriggerGroup("szjAsk")
    create_trigger_t('szjAsk1',"^(> )*���򶡵�����йء����վ�������Ϣ",'','szjTAsk')
    create_trigger_t('szjAsk2',"^(> )*����û������ˡ�$",'','dyNobody')
    SetTriggerOption("szjAsk1","group","szjAsk")
    SetTriggerOption("szjAsk2","group","szjAsk")
	questStartLog(quests["lcj"].name)
	exe('ask ding dian about ���վ�')
	exe('alias action ���վ�')
end
function szjTAsk()
    EnableTriggerGroup("szjAsk",false)
	DeleteTriggerGroup("szjTwo")
	create_trigger_t('szjTwo1',"^(> )*�����˶����ָ�㣬�����վ��İ����ƺ���Щ�ĵ�",'','szjSucc')
	create_trigger_t('szjTwo2','^(> )*��� "action" �趨Ϊ "���վ�" �ɹ���ɡ�$','','szjTwoContinue')
	create_trigger_t('szjTwo3',"^(> )*�����˶����ָ�㣬���Ƕ����վ��İ���ȫȻ����Ҫ��",'','szjTwoFail')
	SetTriggerOption("szjTwo1","group","szjTwo")
    SetTriggerOption("szjTwo2","group","szjTwo")
	SetTriggerOption("szjTwo3","group","szjTwo")
end
function questSzjDy()
    return go(szjDyAsk,"��ѩɽ","��ʯ")
end
function szjDyAsk()
    DeleteTriggerGroup("dyAsk")
    create_trigger_t('dyAsk1',"^(> )*������ƴ����йء����վ�������Ϣ",'','szjTwoAsk')
    create_trigger_t('dyAsk2',"^(> )*����û������ˡ�$",'','dyNobody')
    SetTriggerOption("dyAsk1","group","dyAsk")
    SetTriggerOption("dyAsk2","group","dyAsk")
	questStartLog(quests["lcj"].name)
	exe('ask di yun about ���վ�')
	exe('alias action ���վ�')
end
function szjTwoAsk()
    EnableTriggerGroup("dyAsk",false)
	DeleteTriggerGroup("szjTwo")
	create_trigger_t('szjTwo1',"^(> )*�����˵��Ƶ�ָ�㣬�����վ��İ����ƺ���Щ�ĵ�",'','szjTwoSucc')
	create_trigger_t('szjTwo2','^(> )*��� "action" �趨Ϊ "���վ�" �ɹ���ɡ�$','','szjTwoContinue')
	create_trigger_t('szjTwo3',"^(> )*�����˵��Ƶ�ָ�㣬���Ƕ����վ��İ���ȫȻ����Ҫ��",'','szjTwoFail')
	SetTriggerOption("szjTwo1","group","szjTwo")
    SetTriggerOption("szjTwo2","group","szjTwo")
	SetTriggerOption("szjTwo3","group","szjTwo")
end
function szjSucc()
    EnableTriggerGroup("szjTwo",false)
	questSucLog("���վ�һ��")
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function szjTwoSucc()
    EnableTriggerGroup("szjTwo",false)
	questSucLog("���վ�����")
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end 
function szjTwoFail()
    EnableTriggerGroup("szjTwo",false)
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function szjTwoContinue()
    EnableTriggerGroup("szjTwo",false)
	quests["lcj"].time = os.time() - 16*60*60
	return check_bei(tsjfOver)
end  

function questTsjf()
    return go(dyAsk,"��ѩɽ","��ʯ")
end
function dyAsk()
    DeleteTriggerGroup("dyAsk")
    create_trigger_t('dyAsk1',"^(> )*������ƴ����йء�(��ʬ����|���ǽ���)������Ϣ",'','tsjfAsk')
    create_trigger_t('dyAsk2',"^(> )*����û������ˡ�$",'','dyNobody')
    SetTriggerOption("dyAsk1","group","dyAsk")
    SetTriggerOption("dyAsk2","group","dyAsk")
	questStartLog(quests["lcj"].name)
	if quests["lcj"].auto == 5 then
	   exe('ask di yun about ��ʬ����')
	else
	   exe('ask di yun about ���ǽ���')
	end
	exe('alias action ��ʬ����')
end
function tsjfAsk()
    EnableTriggerGroup("dyAsk",false)
	DeleteTriggerGroup("tsjf")
	create_trigger_t('tsjf1',"^(> )*(�����˵��Ƶ�ָ�㣬����ʬ����|�㰴�յ��Ƶ�ָ�㣬����ʫ����|����˵���������Ѿ�������������ʫ��������)",'','tsjfSucc')
	create_trigger_t('tsjf2','^(> )*��� "action" �趨Ϊ "��ʬ����" �ɹ���ɡ�$','','tsjfFail')
	create_trigger_t('tsjf3','^(> )*(�����˵��Ƶ�ָ�㣬���Ƕ���ʬ����|�����˵��Ƶ�ָ�㣬��Ȼ��������ʫ��������ʽ)','','tsjfContinue')
	SetTriggerOption("tsjf1","group","tsjf")
    SetTriggerOption("tsjf2","group","tsjf")
	SetTriggerOption("tsjf3","group","tsjf")
end
function dyNobody()
    EnableTriggerGroup("dyAsk",false)
	quests["lcj"].time = os.time() - 22*60*60
	return check_bei(tsjfOver)
end
function tsjfSucc()
    EnableTriggerGroup("tsjf",false)
	if quests["lcj"].auto == 5 then
	   quests["lcj"].auto = 6
	   questSucLog("��ʬ����")
	else
	   quests["lcj"].auto = 7
	   questSucLog("���ǽ���")
	end
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function tsjfContinue()
    EnableTriggerGroup("tsjf",false)
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function tsjfFail()
    EnableTriggerGroup("tsjf",false)
	quests["lcj"].time = os.time() - 16*60*60
	return check_bei(tsjfOver)
end
function tsjfOver()
    DeleteTriggerGroup("szjAsk")
	DeleteTriggerGroup("dyAsk")
	DeleteTriggerGroup("tsjf")
	DeleteTriggerGroup("szjTwo")
    SetVariable("timelcj",quests["lcj"].time)
	SetVariable("autolcj",quests["lcj"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end

function questHubo()
    return toZbt()
end
toZbt=function()
    road.id=nil
	return go(toZbtDong,"�һ���","����")
end
function toZbtDong()
	exe('enter')
	locate()
	return check_bei(questHuboLocate)
end
function questHuboLocate()
    if not locl.id["�ܲ�ͨ"] then
	   exe('out;enter')
	end
	questStartLog(quests["hubo"].name)
	if quests["hubo"].auto == 1 then
	    --if score.int > 25 and score.int < 33 then
	    --    exe('cgift '.. score.int-25 ..' int to str')
		--    exe('kick')
	    --end
	    --if score.int < 25 then
	    --    tmp.gift = 25-score.int
	    --    exe('cgift '.. tmp.gift ..' str to int')
		--    exe('kick')
	    --end
		if score.int < 33 and score.int~=25 then
		    changeGift({["int"]=25})
		end
	end 
	return check_busy(questHuboZbt,1)
end
function questHuboZbt()
    DeleteTriggerGroup("zbtAsk")
    create_trigger_t('zbtAsk1',"^(> )*�����ܲ�ͨ�����йء���ݡ�����Ϣ",'','jiebaiAsk')
    create_trigger_t('zbtAsk2',"^(> )*����û������ˡ�$",'','zbtNobody')
	create_trigger_t('zbtAsk3',"^(> )*�����ܲ�ͨ�����йء�˫�ֻ���������Ϣ",'','huboAsk')
    SetTriggerOption("zbtAsk1","group","zbtAsk")
    SetTriggerOption("zbtAsk2","group","zbtAsk")
	SetTriggerOption("zbtAsk3","group","zbtAsk")
    if quests["hubo"].auto == 1 then
	    exe('ask zhou botong about ���')
	    exe('alias action ���')
	else
	    exe('ask zhou botong about ˫�ֻ���')
	    exe('alias action ˫�ֻ���')
	end
end
function zbtNobody()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].time = os.time() - 23*60*60
	return check_bei(huboOver)
end
function jiebaiAsk()
    EnableTriggerGroup("zbtAsk",false)
	DeleteTriggerGroup("jiebai")
    create_trigger_t('jiebai1',"^(> )*�������ܲ�ͨ��(\\D*)֮�ڲ�׼�����㡣",'','jiebaiFail')
	create_trigger_t('jiebai2',"^(> )*�ܲ�ͨ���㲢�����",'','jiebaiSucc')
	create_trigger_t('jiebai3',"^(> )*�ܲ�ͨ˵�������������ǽ�ݹ�����",'','jiebaiNext')
	create_trigger_t('jiebai4','^(> )*��� "action" �趨Ϊ "���" �ɹ���ɡ�$','','jiebaiContinue')
	create_trigger_t('jiebai5',"^(> )*�ܲ�ͨ˵������������û�пգ�Ҫ��������������",'','jiebaiBusy')
	SetTriggerOption("jiebai1","group","jiebai")
    SetTriggerOption("jiebai2","group","jiebai")
	SetTriggerOption("jiebai3","group","jiebai")
	SetTriggerOption("jiebai4","group","jiebai")
	SetTriggerOption("jiebai5","group","jiebai")
end
function jiebaiFail(n,l,w)
    EnableTriggerGroup("jiebai",false)
	local l_str = Trim(w[2])
	local l_n = string.find(l_str,'Сʱ')
	local l_m = string.find(l_str,'��')
	
	local l_hour = 0
	local l_min  = 0
	
	if l_n then
	    l_hour = trans(string.sub(l_str,1,l_n-1))
		if l_m then 
		    l_min = trans(string.sub(l_str,l_n+4,l_m-1))
		end
	else
	    if l_m then
		    l_min = trans(string.sub(l_str,1,l_m-1))
		end
	end
	
	l_min = l_min + 1
	
	quests["hubo"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(huboOver)
end
function jiebaiSucc()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].auto = 2
	questSucLog("����ܲ�ͨ")
	return check_bei(questHuboZbt)
end
function jiebaiNext()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].auto = 2
	return check_bei(questHuboZbt)
end
function jiebaiBusy()
    EnableTriggerGroup("jiebai",false)
    quests["hubo"].time = os.time()
    return check_bei(huboOver)
end
function jiebaiContinue()
    EnableTriggerGroup("jiebai",false)
    quests["hubo"].time = os.time()
	return check_bei(huboOver)
end
function huboAsk()
    EnableTriggerGroup("zbtAsk",false)
	DeleteTriggerGroup("hubo")
    create_trigger_t('hubo1',"^(> )*�������ܲ�ͨ��(\\D*)֮�ڲ�׼�����㡣",'','huboFail')
	create_trigger_t('hubo2',"^(> )*�ܲ�ͨ˵�����������������һ��",'','huboHua')
	create_trigger_t('hubo3',"^(> )*�ܲ�ͨ˵�������㲻���Ѿ�ѧ��",'','huboNext')
	create_trigger_t('hubo4','^(> )*��� "action" �趨Ϊ "˫�ֻ���" �ɹ���ɡ�$','','huboContinue')
	create_trigger_t('hubo5',"^(> )*�ܲ�ͨ����������������������ޱȵ��湦��һ���Զ����̸�����",'','huboNext')
	SetTriggerOption("hubo1","group","hubo")
    SetTriggerOption("hubo2","group","hubo")
	SetTriggerOption("hubo3","group","hubo")
	SetTriggerOption("hubo4","group","hubo")
	SetTriggerOption("hubo5","group","hubo")
end
function huboFail(n,l,w)
    EnableTriggerGroup("hubo",false)
	local l_str = Trim(w[2])
	local l_n = string.find(l_str,'Сʱ')
	local l_m = string.find(l_str,'��')
	
	local l_hour = 0
	local l_min  = 0
	
	if l_n then
	    l_hour = trans(string.sub(l_str,1,l_n-1))
		if l_m then 
		    l_min = trans(string.sub(l_str,l_n+4,l_m-1))
		end
	else
	    if l_m then
		    l_min = trans(string.sub(l_str,1,l_m-1))
		end
	end
	
	l_min = l_min + 1
	
	quests["hubo"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(huboOver)
end
function huboNext()
    EnableTriggerGroup("hubo",false)
	quests["hubo"].auto = 3
	quests["hubo"].time = os.time()
	questSucLog(quests["hubo"].name)
	return check_bei(huboOver)
end
function huboHua()
    EnableTriggerGroup("hubo",false)
	quests["hubo"].time = os.time()
	wait.make(function()
	   wait.time(3)
	   exe('#23(hua fang yuan)')
	   return check_bei(huboOver)
	end)
end
function huboContinue()
    EnableTriggerGroup("hubo",false)
	return check_bei(huboOver)
end
function huboOver()
    DeleteTriggerGroup("zbtAsk")
	DeleteTriggerGroup("hubo")
	DeleteTriggerGroup("jiebai")
    SetVariable("timehubo",quests["hubo"].time)
	SetVariable("autohubo",quests["hubo"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end


goldRoom={
   ["�鱦��"]   = "changan/zhubaohang",
   ["���´��"] = "xiangyang/outnroad3",
   ["�ɻ���"]   = "city/wroad2",
   ["���Ŵ��"] = "xiangyang/hunanroad2",
   ["���"]     = "taishan/hsroad2",
   ["������"] = "xiangyang/xiaolu1",
   ["���ǹ���"] = "city/lichunyuan",
}

function getGold()
   if score.id~="panix" then
      return getGoldOver()
   end
   if job.goldtime then
	   if type(job.goldtime)~="number" or os.time()-job.goldtime<16*60 then
	      return getGoldOver()
	   end
   end
   job.goldtime=os.time()
   tmp.gold={}
   for p,q in pairs(goldRoom) do
       table.insert(tmp.gold,p)
   end
   return getGoldGo()
end
function getGoldGo()
   if type(tmp.gold)~="table" or table.getn(tmp.gold)==0 then
      return getGoldOver()
   end
   return go(getGoldKill,goldRoom[tmp.gold[1]],"")
end
function getGoldKill()
   if not locl.id[tmp.gold[1]] then
      return getGoldNext()
   end
   if tmp.gold[1]=="���ǹ���" then
      exe('ask gong zi about ������')
	  return wipe("song qingshu",getGoldNext)
   else
      return wipe(locl.id[tmp.gold[1]],getGoldNext)
   end
end
function getGoldNext()
   table.remove(tmp.gold,1)
   return getGoldGo()
end
function getGoldOver()
   tmp.gold=nil
   return check_heal()
end

function turnShen(p_flag)
    if p_flag == '+' then
           if locl.area=="��ѩɽ" then
	      return go(turnShenJump,"��ѩɽ","ѩ��")
	   end
	   if Bag["������"] then
	      exe('eat zhengqi dan;hp')
		  checkBags()
		  return check_bei(check_job,1)
	   end
	   return go(turnShenJump,"��ѩɽ","ѩ��")
	else
	   if Bag["а����"] then
	      exe('eat xieqi wan;hp')
		  checkBags()
		  return check_bei(check_job,1)
	   end
	   if Bag["�����滨��"] then
	       return go(turnShenGive,"������","����")
	   end
	   return go(turnShenBuy,"������","������")
	end
end
function turnShenJump()
    exe('jump down')
	locate()
	return check_busy(turnShenStone,1)
end
function turnShenStone()
    if locl.room=="��ʯ" then
	   return turnShenMb()
	else
	   return go(turnShenJump,"��ѩɽ","ѩ��")
	end
end
function turnShenMb()
    exe('#20(mianbi);hp')
	return checkWait(turnShenChk,0.5)
end
function turnShenChk()
    if hp.shen>0 then
	   return check_heal()
	else
	   return turnShenMb()
	end
end
function turnShenBuy()
    if locl.room~="������" then
	   return go(turnShenBuy,"������","������")
	end
    if Bag["�����滨��"] then
	   return go(turnShenGive,"������","����")
	else
	   exe('buy zhen')
	   checkBags()
	   return check_busy(turnShenBuy,1)
	end
end
function turnShenGive()
    if locl.room~="����" or not locl.id["�鰲ͨ"] then
	   return go(turnShenGive,"������","����")
	end
	exe('give 1 lihuan zhen to hong antong;hp')
	checkBags()
	return check_busy(turnShenCheck,1)
end
function turnShenCheck()
    if hp.shen<0 then
	   return check_heal()
	end
	if Bag["�����滨��"] then
	   return check_bei(turnShenGive)
	else
	   return go(turnShenBuy,"������","������")
	end
end

function mrForce()
    return go(mrKetou,"������","Ĺ��")
end
function mrKetou()
    if locl.room~="Ĺ��" then
	   return mrForce()
	end
	flag.idle = 0
    exe('yun jing;#3(ketou);w;e;get book')
    exe('hp')
	return check_bei(mrKetouChk)
end
function mrKetouChk()
    if skills["force"].lvl>100 then
	   return check_heal()
	end
    locate()
	exe('cha')
    if hp.jingxue>100 then
	   return checkWait(mrKetou,3)
	else
	   exe('hp')
	   return checkWait(mrKetouChk,8)
	end
end

function huxi()
    if hp.exp and hp.exp>2000000 then
       return go(huxiStart,"����ɽ","��ţɽ")
	else
	   return go(huxiXhz,"����ɽ","ǰ��")
	end
end
function huxiXhz()
    if locl.room~="ǰ��" then
	   return huxi()
	end
	if locl.id["������"] then
	   locate()
	   return checkWait(huxiXhz,5)
	else
	   exe('#4s')
	   return go(huxiStart,"����ɽ","��ţɽ")
	end
end
function huxiStart()
    if locl.room~="��ţɽ" then
	   return huxi()
	end
    DeleteTriggerGroup("huxi")
    create_trigger_t('huxi1',"^(> )*�㼯��������������������������",'','huxiCheck')
    create_trigger_t('huxi2',"^(> )*��������������˹���",'','huxiChk')
	SetTriggerOption("huxi1","group","huxi")
	SetTriggerOption("huxi2","group","huxi")
	exe('enable force '.. perform.force)
    exe('wo stone;huxi;hp')
end
function huxiChk()
    flag.idle = 0
    if skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100 then
	   return check_bei(huxiOver,1)
	end
    wait.make(function() 
          wait.time(1)          
          if hp.jingxue<60 then
	         exe('yun jing')
	      end
	      if hp.qixue<60 then
	         exe('yun qi')
	      end
		  exe('wo stone;huxi;hp;cha')
    end)
end
function huxiCheck()
    flag.idle = 0
    if skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100 then
	   return check_bei(huxiOver,1)
	end
    wait.make(function() 
          wait.time(2)          
          if hp.jingxue<60 then
	         exe('yun jing')
	      end
	      if hp.qixue<60 then
	         exe('yun qi')
	      end
		  exe('wo stone;huxi;hp;cha')
    end)
end
function huxiOver()
    DeleteTriggerGroup("huxi")
	return check_heal()
end

function wxjzFofa()
    return go(wxjzFofaPot,"������","Ǳ������")
end
function wxjzFofaPot()
    exe('qn_qu 3000')
    return go(wxjzFofaPre,"��ɽ����","������")
end
function wxjzFofaPre()
    EnableTrigger("fight16",false)
    if Bag["�ӹ�"] and Bag["����"] then
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
	   exe('drop stone')
	   exe('drop stone')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzFofaAsk,1)
	end
    if locl.id["������ʦ"] then
	   if not Bag["�ӹ�"] then
	      exe('ask fangsheng about �ӹ�')
	   end
	   if not Bag["����"] then
	      exe('ask fangsheng about ����')
	   end
	   checkBags()
	   return check_busy(wxjzFofaPre,1)
	else
	   return check_heal()
	end
end
function wxjzFofaAsk()
    if locl.room=="������" then
	   exe('n')
	   exe('pray pearl')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzFofaAsk,1)
	end
	if not locl.id["������ʦ"] then
	   return check_heal()
	end
	DeleteTriggerGroup("fofa")
    create_trigger_t('fofa1',"^(> )*����������ʦ�����йء��𷨡�����Ϣ",'','fofaAccept')
    create_trigger_t('fofa2',"^(> )*����û������ˡ�$",'','fofaNobody')
    SetTriggerOption("fofa1","group","fofa")
    SetTriggerOption("fofa2","group","fofa")
	exe('ask wuxiang chanshi about ��')
end
function fofaNobody()
    EnableTriggerGroup("fofa",false)
	return check_bei(wxjzFofaOver)
end
function wxjzFofaOver()
    DeleteTriggerGroup("fofa")
	DeleteTriggerGroup("ffacp")
	exe('out;d;get all')
	return check_heal()
end
function fofaAccept()
    EnableTriggerGroup("fofa",false)
	DeleteTriggerGroup("ffacp")
	create_trigger_t('ffacp1',"^(> )*��������ã���������",'','fofaAskCon')
	create_trigger_t('ffacp2',"^(> )*������ʦ(����|)˵����(��|)���Ǳ�ܲ����ˡ�",'','fofaAskPot')
	create_trigger_t('ffacp3',"^(> )*������ʦ(����|)˵����(��|)\\D*�𷨾���",'','fofaAskOver')
	SetTriggerOption("ffacp1","group","ffacp")
	SetTriggerOption("ffacp2","group","ffacp")
	SetTriggerOption("ffacp3","group","ffacp")
end
function fofaAskCon()
    EnableTriggerGroup("ffacp",false)
	return check_bei(wxjzFofaAsk,1)
end
function fofaAskPot()
    EnableTriggerGroup("ffacp",false)
	return check_bei(wxjzFofaOver,1)
end
function fofaAskOver()
    EnableTriggerGroup("ffacp",false)
	flag.wxjz=1
	return check_bei(wxjzFofaOver,1)
end

function learnSzj()
    return go(learnSzjChk,"���ݳ�","���ű�Ӫ")
end
function learnSzjChk()
    if hp.exp>500000 then
	   return wipe("zhao liangdong",learnSzjGo)
	else
	   return learnSzjGo()
	end
end
function learnSzjGo()
    exe('west')
	locate()
	return check_busy(learnSzjAsk,1)
end
function learnSzjAsk()
    flag.idle = 0
    if not locl.id["����"] then
	    return check_bei(learnSzjOver)
	end
	if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl >= hp.pot_max-100 then
	    return check_bei(learnSzjOver)
	end
	if tmp.busy and (not condition["����æ״̬"] or condition["����æ״̬"]<=20) then
	    return check_bei(learnSzjOver)
    end
	if hp.pot<10 then
	    return check_bei(learnSzjOver)
	end
	if hp.neili<1000 and Bag["������Ϣ��"] then
	    exe('eat chuanbei wan')
	end
	if hp.neili<500 then
        if Bag["�󻹵�"] then
	        exe('eat dan')
	    else
	        return check_bei(learnSzjOver)
	    end
	end
	exe('yun jing;ask ding dian about ���վ�;cha;hp')
	if math.random(1,5)==1 then
        locate()
		condition = {}
		exe('cond')
		checkBags()
    end
	return check_busy(learnSzjAsk,1)
end
function learnSzjOver()
    if hp.pot >= hp.pot_max then
	    return potSave()
	end
	return check_heal()
end

function learnQmbg()
    return go(learnQmbgAsk,"thd/neishi1","")
end
function learnQmbgAsk()
    flag.idle = 0
    if not locl.id["����"] then
	   return check_bei(learnQmbgOver)
	end
	if skills["qimen-bagua"] and skills["qimen-bagua"].lvl >= 200 then
	   return check_bei(learnQmbgOver)
	end
	if hp.pot<10 then
	   return check_bei(learnQmbgOver)
	end
	if hp.neili<1000 and Bag["������Ϣ��"] then
	   exe('eat chuanbei wan')
	end
	if hp.neili<500 then
       if Bag["�󻹵�"] then
	      exe('eat dan')
	   else
	      return prepare_neili(learnQmbgAsk)
	   end
	end
	exe('yun jing;ask huang rong about ���Ű���;cha;hp')
	locate()
	checkBags()
	return check_busy(learnQmbgAsk,1)
end
function learnQmbgOver()
    if hp.pot >= hp.pot_max then
	   return potSave()
	end
	return check_heal()
end



function tiaoshui()
    return go(tiaoshuiAsk,"��ɽ����","���")
end
function tiaoshuiAsk()
    if locl.id["�ۿ�����"] then
	   wait.make(function()
	      exe('ask huikong zunzhe about ��ˮ')
	      wait.time(3)
	      exe('get tie tong')
	      checkBags()
	      return check_busy(tiaoshuiTong,1)
	   end)
	end
	return go(tiaoshuiAsk,"��ɽ����","���")
end
function tiaoshuiTong()
    if Bag["����Ͱ"] then
	   return go(tiaoshuiFill,"��ɽ����","���ľ�")
	end
	return go(tiaoshuiAsk,"��ɽ����","���")
end
function tiaoshuiFill()
    flag.idle = 0
    exe('fill tie tong')
	return go(tiaoshuiPour,"��ɽ����","���")
end
function tiaoshuiPour()
    exe('pour gang')
	checkBags()
	return check_busy(tiaoshuiChk,1)
end
function tiaoshuiChk()
    if not Bag["����"] then
	   return check_heal()
	end
	if not Bag["����Ͱ"] then
	   return go(tiaoshuiAsk,"��ɽ����","���")
	end
	return go(tiaoshuiFill,"��ɽ����","���ľ�")
end

function emLingwuF()
    if perform.force then 
       exe('enable force '.. perform.force)
	end
    exe('cha;hp')
    go(emLingwuFStart,'����ɽ','�׶�ƺ')
end
function emLingwuFStart()
    if locl.room=='�׶�ƺ' then
       exe('yun jing;lingwu force 30;hp')
       check_bei(emLingwuFCheck)
    else
       return check_heal()
    end
end
function emLingwuFCheck()
    flag.idle = 0
    if hp.pot<30 or (skills["force"] and skills[perform.force] and skills[perform.force].lvl<skills["force"].lvl) or (skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100) or skills["force"].lvl>200 then
       return check_heal()
    end
    if hp.neili<500 then
       return prepare_neili(emLingwuF)
    end
    exe('yun jing;lingwu force 30;cha;hp')
    return check_bei(emLingwuFCheck)
end

function canWu(p_canwu)
    tmp.canwu = p_canwu
	if tmp.canwu=="exp" then
	   return go(canwuDo,"��٢��ɽׯ","������-ʵս��")
	end
	if tmp.canwu=="gift" then
	   return go(canwuDo,"��٢��ɽׯ","������-�츳��")
	end
end
function canwuDo()
    local expcut = 1800000
	if score.vip and score.vip=="����������" then expcut = 1600000 end
	if score.vip and score.vip=="�꿨���" then expcut = 1700000 end
    if tongji.exp then tongji.exp = tongji.exp - expcut end
    if tmp.canwu=="exp" then
       exe('canwu combat')
	end
	if tmp.canwu=="gift" then
       exe('canwu gift')
	end
	return check_bei(canwuOver,1)
end
function canwuOver()
    
    return go(check_heal,'������','ҩ��')
end

function lingqi()
    return go(lingqiCheck,"��ɽ","����̨")
end
function lingqiCheck()
    if not locl.id["������"] then
       return lingqi()
    end
    return wipe("zuo lengchan",lingqiGet)
end
function lingqiGet()
    for i=1,3 do
        exe('get lingqi from corpse '..i)
	exe('get shuaiyi tie from corpse '..i)
    end
    return ouxuepu()
end
function ouxuepu()
    return go(ouxuepuCheck,"�ɶ���","����")
end
function ouxuepuCheck()
    if not locl.id["������"] then
       return check_heal()
	end
	DeleteTriggerGroup("oxpAsk")
    create_trigger_t('oxpAsk1',"^(> )*���������Ĵ����йء�question������Ϣ",'','ouxuepuAsk')
    create_trigger_t('oxpAsk2',"^(> )*����û������ˡ�$",'','ouxuepuNobody')
    SetTriggerOption("oxpAsk1","group","oxpAsk")
    SetTriggerOption("oxpAsk2","group","oxpAsk")
	exe('ask liu about question')
end
function ouxuepuNobody()
    EnableTriggerGroup("oxpAsk",false)
	return check_heal()
end
function ouxuepuNext()
    return check_bei(ouxuepuCheck)
end
function ouxuepuAsk()
    EnableTriggerGroup("oxpAsk",false)
	DeleteTriggerGroup("oxp")
	create_trigger_t('oxp1','^(> )*�����ĵ��ͷ���������ˣ�����','','ouxuepuGuess')
	create_trigger_t('oxp2','^(> )*�����ĵ������㻹��','','ouxuepuGuess')
	create_trigger_t('oxp3','^(> )*�����ĵ������´��ٲ°�','','ouxuepuNext')
	create_trigger_t('oxp4','^(> )*��������ǽ�ϰ��˼���','','ouxuepuPass')
	SetTriggerOption("oxp1","group","oxp")
	SetTriggerOption("oxp2","group","oxp")
	SetTriggerOption("oxp3","group","oxp")
	SetTriggerOption("oxp4","group","oxp")
end
function ouxuepuGuess()
    --EnableTriggerGroup("oxp",false)
	tmp.guess = tmp.guess or {}
	--if not tmp.guess["1"] then
	--   tmp.guess["1"]=math.random(1,7)
	--end
	local a,b,c,d
	a = math.random(1,7)
	b = math.random(1,7)
    while b == a do
	   	b = math.random(1,7)
	end
	c = math.random(1,7)
	while c == a or c == b do
	   	c = math.random(1,7)
	end
	d = math.random(1,7)
	while d == a or d == b or d == c do
	   	d = math.random(1,7)
	end
	exe('guess '..a..b..c..d)
end
function ouxuepuPass()
    EnableTriggerGroup("oxp",false)
	exe('w;l shelf')
	return checkWait(glsanGo,2)
end
function glsanGo()
    return go(glsBuy,"����ɽ","����")
end
function glsBuy()
    if locl.id["С����"] then
	   exe('buy tie qiao')
	   checkBags()
	   return checkWait(glsCheck,2)
	else 
	   return glsanGo()
	end
end
function glsCheck()
    if Bag["����"] then
	   return go(glsDig,"������","����Ĺ")
	else
	   return glsanGo()
	end
end
function glsDig()
    exe('wa mu')
	return checkWait(xishantuGo,2)
end
function xishantuGo()
    return go(xishantuFan,"ţ�Ҵ�","����")
end
function xishantuFan()
    exe('open xiang;open jiaceng')
	exe('#25(fan painting)')
	locate()
	checkBags()
	return check_bei(xishantuOver,1)
end
function xishantuOver()
    if Bag["ŻѪ��"] and Bag["��������"] and Bag["����ɢ"] and Bag["Ϫɽ����ͼ"] and Bag["������"] then
	   return go(xxdfGiveSan,"÷ׯ","����")
	end
end
function xxdfGo()
    return go(xxdfQiao,"÷ׯ","ׯԺ����")
end
function xxdfQiao()
    create_trigger_f('xxdf',"^(> )*���˰��Σ����Ż����򿪣������߳���������װ��������",'','xxdfHuida')
	wait.make(function()
         exe('qiao gate 4 times')
		 wait.time(3)
	     exe('qiao gate 2 times')
		 wait.time(3)
	     exe('qiao gate 5 times')
		 wait.time(3)
	     exe('qiao gate 3 times')
	end)
end
function xxdfHuida()
    exe('huida �����������;show wuyue lingqi')
	return check_bei(xxdfGiveSan)
end
function xxdfGiveSan()
    if locl.room~="����" then 
	   return go(xxdfGiveSan,"÷ׯ","����")
	end
    if not locl.id["���ӹ�"] then 
	   return go(xxdfGiveSan,"÷ׯ","����")
	end
	exe("give guangling san to huangzhong gong")
	return go(xxdfGivePu,"÷ׯ","����")
end
function xxdfGivePu()
    if locl.room~="����" then 
	   return go(xxdfGivePu,"÷ׯ","����")
	end
    if not locl.id["�ڰ���"] then 
	   return go(xxdfGivePu,"÷ׯ","����")
	end
	exe("give ou xie pu to heibai zi")
	return go(xxdfGiveTie,"÷ׯ","�鷿")
end
function xxdfGiveTie()
    if locl.room~="�鷿" then 
	   return go(xxdfGiveTie,"÷ׯ","�鷿")
	end
    if not locl.id["ͺ����"] then 
	   return go(xxdfGiveTie,"÷ׯ","�鷿")
	end
	exe("give shuaiyi tie to tubi weng")
	return go(xxdfGiveTu,"÷ׯ","����")
end
function xxdfGiveTu()
    if locl.room~="����" then 
	   return go(xxdfGiveTu,"÷ׯ","����")
	end
    if not locl.id["������"] then 
	   return go(xxdfGiveTu,"÷ׯ","����")
	end
	exe("give xinglv tu to tubi weng")
	exe("ask danqing sheng about ����")
	return go(xxdfWipe,"÷ׯ","����")
end
function xxdfWipe()
    if locl.room~="����" then 
	   return go(xxdfWipe,"÷ׯ","����")
	end
	return wipe("ding jian",xxdfZuan)
end
function xxdfZuan()
    exe('zuan table;n;n;pull floor;d;n;n;s;kai men;n')
	locate()
	return check_bei(xxdfRwx)
end
function xxdfRwx()
    if locl.id["������"] then
	   disAll()
	   exe("pray pearl")
	   exe("ask ren woxing about �Ƚ�")
	   return checkWait(xxdfMove,3)
	end
end
function xxdfMove()
    exe("move man")
	locate()
	checkBags()
	return check_busy(xxdfDushu)
end
function xxdfDushu()
    if Bag["���Ǵ��ر�"] then
       messageShow("���Ǵ󷨽��ܳɹ��������ؼ�����ִ��push door��")	
	   return dushu("miji")
	else 
	   messageShow("���Ǵ󷨽���ʧ�ܣ�������QUITһ�Σ�")
	end
end

function yanxiwall()
    if hp.neili > 1000 then
	   exe('#20(yanxi east wall);yun jing;yun jingli;hp')
	   return checkWait(yanxiwall,0.3)
	end
	return prepare_neili(yanxiwall)
end

function jinshe()
    if not Bag["����"] then
	   return jinsheFire()
	end
	if not Bag["����"] then
	   return jinsheStaff()
	end
	if not Bag["С��֦"] then
	   return jinsheTree()
	end
	return jinsheGo()
end
function jinsheFire()
    return go(jinsheFireBuy,"������","�ӻ���")
end
function jinsheFireBuy()
    exe('buy fire')
	checkBags()
	return check_busy(jinshe)
end
function jinsheStaff()
    return go(jinsheStaffAsk,"���ݳ�","������")
end
function jinsheStaffAsk()
    exe('ask tie jiang about ����')
	checkBags()
	return check_busy(jinshe)
end
function jinsheTree()
    return go(jinsheTreeGet,"���ݳ�","����ɽ")
end
function jinsheTreeGet()
    exe('get xiao shuzhi')
	checkBags()
	return check_busy(jinshe)
end
function jinsheGo()
    return go(jinsheClimb,"��ɽ","�����")
end
function jinsheClimb()
    DeleteTriggerGroup("jsjf")
	create_trigger_t('jsjf1',"^(> )*�����Ѿ���(\\D*)�۹��ˡ�$",'','jinsheFail')
	create_trigger_t('jsjf2',"^(> )*�������������ȥ",'','jinsheFail')
	create_trigger_t('jsjf3',"^(> )*�������������棬սս������ʧ�ڶ��ڡ�$",'','jinsheBa')
	SetTriggerOption("jsjf1","group","jsjf")
    SetTriggerOption("jsjf2","group","jsjf")
	SetTriggerOption("jsjf3","group","jsjf")
	for p in pairs(Bag) do
	       if Bag[p].kind then
		      for i = 1,Bag[p].cnt do
			      exe('drop '..Bag[p].fullid)
			  end
		   end
	end
	exe('drop silver;drop gold')
    exe('l tieyuan;pa ya')
	if not Bag["�ٿ�"] then
	   exe('break shuteng;bian kuang')
	end
	exe('chan shu;dian fire;bo zhui;climb down')
end
function jinsheFail()
    EnableTriggerGroup("jsjf",false)
	EnableTriggerGroup("jsba",false)
	EnableTriggerGroup("jszang",false)
	EnableTriggerGroup("jsdz",false)
	exe('climb up;d;get all')
	exe('drop jinshe sword;drop corpse')
	if not tmp.time or tmp.time <= os.time() then
	   tmp.time = os.time()
	end
	if Bag["С��ϻ"] then
	   exe('kai tie xia')
	   return dushu("jianfa")
	end
	if Bag["����"] then
	   return go(jinsheZhangfa,"������","����")
	end
	return jinsheOver()
end
function jinsheZhangfa()
    exe('give xin jian to wen yi;ask wen yi about ����')
	return dushu("zhangfa")
end
function jinsheBa()
    DeleteTriggerGroup("jsba")
    create_trigger_t('jsba1','^(> )*��������ȥ�ν������Ƿ��ֽ��Ѿ�û���ˡ�$','','jinsheFail')
	create_trigger_t('jsba2','^(> )*����ʱ������ؼ���Ե�ˣ���ʱ�仹�ǿ�ȥ�����ɡ�$','','jinsheQuit')
	create_trigger_t('jsba3',"^(> )*��ץס������΢һ������ֻ���ý�����΢���һ�¡�$",'','jinsheCon')
	create_trigger_t('jsba4',"^(> )*�������ס������Ǳ���������͵�һ���죬�ѽ����˳�����$",'','jinsheZang')
	SetTriggerOption("jsba1","group","jsba")
    SetTriggerOption("jsba2","group","jsba")
	SetTriggerOption("jsba3","group","jsba")
	SetTriggerOption("jsba4","group","jsba")
	if skills["jinshe-jianfa"] then
	   locate()
	   return check_bei(jinsheBox)
	end
	
	exe('ba bing')
end
function jinsheBox()
    if locl.id["������"] then
	   exe('open tie he')
	   checkBags()
	   return check_busy(jinsheFail,1)
	end
	exe('ba bing') 
end
function jinsheQuit()
    EnableTriggerGroup("jsba",false)
	return check_bei(husongQuit)
end
function jinsheCon()
    EnableTriggerGroup("jsba",false)
    return check_bei(jinsheBa)
end
function jinsheZang()
    EnableTriggerGroup("jsba",false)
	DeleteTriggerGroup("jszang")
    create_trigger_t('jszang1','^(> )*���ﲻ������£��㻹��ȥŬ�������ɡ�$','','jinsheFail')
	create_trigger_t('jszang2','^(> )*�������˭��$','','jinsheFail')
	create_trigger_t('jszang3',"^(> )*(".. score.name .."|��)(��|)������Ȼ�������밲��������ã����������ͷ��",'','jinsheDeep')
	create_trigger_t('jszang4',"^(> )*������������ڣ������ƺ��Ѿ������ڹ��ˡ�$",'','jinsheFail')
	SetTriggerOption("jszang1","group","jszang")
    SetTriggerOption("jszang2","group","jszang")
	SetTriggerOption("jszang3","group","jszang")
	SetTriggerOption("jszang4","group","jszang")
	exe('zang haigu')
end
function jinsheDeep()
    EnableTriggerGroup("jszang",false)
	DeleteTriggerGroup("jsdz")
    create_trigger_t('jsdz1','^(> )*���ﲻ������£��㻹��ȥŬ�������ɡ�$','','jinsheFail')
	create_trigger_t('jsdz2','^(> )*��Ҫ��ʲ�᣿$','','jinsheFail')
	create_trigger_t('jsdz3',"^(> )*(".. score.name .."|��)(��|)�ְѿ������˼��ߣ��õ�һ����ϻ",'','jinsheSucc')
	create_trigger_t('jsdz4',"^(> )*(".. score.name .."|��)(��|)�ְѿ������˼��ߣ����������ã�ͻȻ����һ����ϻ",'','jinsheSucc')
	create_trigger_t('jsdz5',"^(> )*������������ڣ���Ȼ�Ѿ������ڹ��ˡ�$",'','jinsheDeepCon')
	create_trigger_t('jsdz6',"^(> )*��ѿ�����������Ҳ��֪��������$",'','jinsheDeepCon')
	create_trigger_t('jsdz7',"^(> )*(".. score.name .."|��)(��|)�ְѿ������˼��ߣ�û�з����κζ���",'','jinsheFail')
	SetTriggerOption("jsdz1","group","jsdz")
    SetTriggerOption("jsdz2","group","jsdz")
	SetTriggerOption("jsdz3","group","jsdz")
	SetTriggerOption("jsdz4","group","jsdz")
	SetTriggerOption("jsdz5","group","jsdz")
	SetTriggerOption("jsdz6","group","jsdz")
	SetTriggerOption("jsdz7","group","jsdz")
	return check_bei(jinsheDeepZang)
end
function jinsheDeepZang()
    if skills["jinshe-jianfa"] then
	   exe('open tie he')
	   checkBags()
	   return check_busy(jinsheFail)
	end
    EnableTriggerGroup("jsdz",true)
	exe('yun jingli;shenzang haigu')
end
function jinsheDeepCon()
    EnableTriggerGroup("jsdz",false)
    return check_bei(jinsheDeepZang)
end
function jinsheSucc()
    tmp.time = 999999999999
	locate()
    return check_busy(jinsheFail)
end
function jinsheOver()
    if tmp.time then
       SetVariable("timejsjf",tmp.time)
	end
	return check_heal()
end

function tzRonghe()
    if tmp.ghost then
	   return go(tzrhSg,"����ɽ","������")
	end
    return go(tzrhQqz,"����ɽ","�ϼ�")
end
function tzrhQqz()
    if locl.room ~= "�ϼ�" and locl.room ~= "����Ȫ" and locl.room ~= "�㳡" then
	   return tzRonghe()
	end
    if locl.id["��ǧ��"] then
	   tmp.ghost = true
	   exe('ask qiu qianzhang about �ֹ�')
	   return go(tzrhSg,"����ɽ","������")
	else
	   if locl.room == "�ϼ�" then
	      if math.random(1,3) > 1 then
	         exe('se')
		  else
		     exe('w')
		  end
	   end
	   if locl.room == "����Ȫ" then
	      exe('nw')
	   end
	   if locl.room == "�㳡" then
	      exe('e')
	   end
	   return checkWait(tzrhQm,2)
	end
end
function tzrhQm()
    locate()
    return check_busy(tzrhQqz)
end
function tzrhSg()
    exe('move bei;enter;ed;nd;wd')
	locate()
	return checkNext(tzrhSgCheck,1)
end
function tzrhSgCheck()
    if locl.room ~= "ʯ��" or not locl.id["�Ϲٽ���"] then
	   return tzRonghe()
	end
	exe('ask shangguan about ����')
	return go(tzrhTui,"tiezhang/taijie-2")
end
function tzrhTui()
    DeleteTriggerGroup("tzrh")
	create_trigger_t('tzrh1',"^(> )*\\D*̫�ڿ�",'','tzrhFlag')
	create_trigger_t('tzrh2','^(> )*\\D*�����������ϵ�����','','tzrhFlag')
	SetTriggerOption("tzrh1","group","tzrh")
    SetTriggerOption("tzrh2","group","tzrh")
	--���˼��ã�����Ҫ�졣
	--������̫�ڿ��ˣ�
    exe('tui gate')
	wait.make(function() 
       wait.time(4)
	   if not tmp.ronghe then
	      return tzRonghe()
	   end
	end)
end
function tzrhFlag()
    tmp.ronghe = true
end

function questSucLog(p_quest)
    local file = io.open(GetInfo(59) .. "/log/����һ��.txt", "a")
	file:write(os.date()..','..score.id ..",����==="..","..p_quest..",�ɹ���")
	file:write("\n")
    file:close()
end
function questStartLog(p_quest)
    local logfile = GetInfo(59) .. "/log/����"..p_quest.."-"..score.id .."-"..os.time() .. ".txt"
	OpenLog (logfile , false)
end

function questSet()
    local t = {}
	questList = questList or {}
	for p,q in pairs(questList) do
        if type(q) == 'function' then
	        if q() then t['auto'..p] = q() end
        else	   
            t['auto'..p] = q
	    end
    end
	
	if countTab(t) == 0 then return end
	
	local qlst = {}
	
	local varlist = GetVariableList()
	if varlist then
	    for p,q in pairs(varlist) do
	        if t[p] then
		        qlst[p] = q
		    end
	    end
	end
	
	local l_tmp=utils.multilistbox ("��׼��Ҫ�Զ�ȥ���QUEST��(�밴CTRL��ѡ)?", "QUESTѡ��", t,qlst)
	l_tmp = l_tmp or {}
	for p in pairs(l_tmp) do
	    if not GetVariable(p) then 
		    SetVariable(p,1)
		end
	end
	for p in pairs(qlst) do
	    if not l_tmp[p] then
		    DeleteVariable(p)
		end
	end 
	
end

function questGetVar()
    local varlist = GetVariableList()
	if varlist then
	    for p,q in pairs(varlist) do
	        if string.find(p,'auto') then
			    local qst = string.sub(p,5,-1)
			    if quests[qst] then
				   quests[qst].auto = tonumber(q)
			    end
			end
			if string.find(p,'time') then
			    local qst = string.sub(p,5,-1)
			    if quests[qst] then
				   quests[qst].time = tonumber(q)
			    end
			end
	    end
	end
end








