--�����Ħ��
jobSpecial = jobSpecial or {}
jobSpecial["smy"] = true
job.list = job.list or {}
job.list["smy"] = function() if canwu and canwu.gift and canwu.gift>1 then return "��Ħ��" else return false end end
joblast = joblast or {}
joblast["������Ħ��"] = "smy"
jobCond = jobCond or {}
jobCond["smy"] = function() if job.last~="smy" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["��Ħ�����񵹼�ʱ"] or (condition["��Ħ�����񵹼�ʱ"] and condition["��Ħ�����񵹼�ʱ"]==0) or (condition["����æ״̬"] and condition["��Ħ�����񵹼�ʱ"] and condition["��Ħ�����񵹼�ʱ"]<=condition["����æ״̬"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["smy"] = "smyTriggerDel"

local smyRounds = 9 --Ĭ��ɱ9��
local smyRound  = 0
local smyKilled = 0
local smyWushi = 0
local smyQuit   = false

function smyTrigger()
    DeleteTriggerGroup("smyTeam")
    create_trigger_t('smyTeam1',"^(> )*�����Ը����룬���� team with (\\D*)��$",'','smyTeam')
    create_trigger_t('smyTeam2',"^(> )*"..job.teamname.."����������Ķ��顣",'','smyTeamMeet')
    create_trigger_t('smyTeam3',"^(> )*�����Ը����룬����\\s*lineup\\s*with\\s*(\\D*)��$",'','smyTeamLineup')
	create_triggerex_lvl('smyTeam4',"^(> )*�����顿(\\D*)\\((\\D*)\\)��(.*)",'','smyTeamComm',95)
    SetTriggerOption("smyTeam1","group","smyTeam")
    SetTriggerOption("smyTeam2","group","smyTeam")
    SetTriggerOption("smyTeam3","group","smyTeam")
	SetTriggerOption("smyTeam4","group","smyTeam")
    DeleteTriggerGroup("smyAsk")
    create_trigger_t('smyAsk1',"^(> )*(��|"..job.teamlead..")��³�нŴ����й�",'','smyAccept')
    create_trigger_t('smyAsk2',"^(> )*����û������ˡ�$",'','smyNobody')
	SetTriggerOption("smyAsk1","group","smyAsk")
    SetTriggerOption("smyAsk2","group","smyAsk")
    EnableTriggerGroup("smyAsk",false)
    DeleteTriggerGroup("smyAccept")
    create_trigger_t('smyAccept1',"^(> )*³�н�˵������ʱ����������õص������ǹ�ȥ",'','smyLocate')
    create_trigger_t('smyAccept2',"^(> )*³�н�˵��������\\D*������",'','smyBusy')
	create_trigger_t('smyAccept3',"^(> )*³�н�˵��������Ķ������м���С��",'','smyBusy')
	create_trigger_t('smyAccept4',"^(> )*³�н�˵�������ҿ����ͷ��Ŀ������",'','smyBusy')
    SetTriggerOption("smyAccept1","group","smyAccept")
    SetTriggerOption("smyAccept2","group","smyAccept")
	SetTriggerOption("smyAccept3","group","smyAccept")
	SetTriggerOption("smyAccept4","group","smyAccept")
	EnableTriggerGroup("smyAccept",false)
	DeleteTriggerGroup("smyFight")
    create_trigger_t('smyFight1','^(> )*������ʿ��ž����һ�����ڵ���','','smyWuDie')
    create_trigger_t('smyFight2','^(> )*������ʿ��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','kill wu shi','')
    create_trigger_t('smyFight3','^(> )*����û������ˡ�','','smyCount')
	create_trigger_t('smyFight4','^(> )*Զ����ɽ·����һ����Х����Լ��������ʩչ�Ṧ�ɳ۶�����','','smyPrepare')
	create_trigger_t('smyFight5','^(> )*ɽ�±����С·������������Ӱ','','smyKillWushi')
	create_trigger_t('smyFight6','^(> )*һ��������ת����һ���㱣��ŷ����Լ��˳��˸����ռ䡣','','smyFinish')
	create_trigger_t('smyFight7','^(> )*'.. job.teamname ..'��ž����һ�����ڵ�','','smyDie')
	create_trigger_t('smyFight8','^(> )*(Զ������һ��Ұ�޵Ľ���|һ���Х��ɽ��ι�|ɽ���µ�ɽ�ȴ���һ�������ĳ�Х|һ���������εķ�)','','smyCheckQuit')
    SetTriggerOption("smyFight1","group","smyFight") 
    SetTriggerOption("smyFight2","group","smyFight")
    SetTriggerOption("smyFight3","group","smyFight")
	SetTriggerOption("smyFight4","group","smyFight")
	SetTriggerOption("smyFight5","group","smyFight")
	SetTriggerOption("smyFight6","group","smyFight")
	SetTriggerOption("smyFight7","group","smyFight")
	SetTriggerOption("smyFight8","group","smyFight")
    EnableTriggerGroup("smyFight",false)
end
function smyTriggerDel()
    DeleteTriggerGroup("smyTeam")
    DeleteTriggerGroup("smyAsk")
    DeleteTriggerGroup("smyAccept")
    DeleteTriggerGroup("smyFight")
end
function smyNobody()
    EnableTriggerGroup("smyAsk",false)
    return checkJob()
end
function smyBusy()
    EnableTriggerGroup("smyTeam",false)
    EnableTriggerGroup("smyAsk",false)
	EnableTriggerGroup("smyAccept",false)
	exe('tt ³���ϲ����ˣ���������ɣ�')
	return smyChang()
end
function smyChang()
	smyTriggerDel()
	return checkJob()
end
function smy()
    if hp.shen<0 then
	    return turnShen('+')
	end
	if not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2 then
	    return checkDhd()
	end
    job.name = 'smy'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
	smyRound  = 0
	smyWushi = 0
	smyQuit = false
	if GetVariable("flaground") then
	    local l_round = tonumber(GetVariable("flaground"))
		if l_round > 1 and l_round <= 20 then
		    smyRounds = l_round
		end
	end
    if not job.teamlead or job.teamlead=="" or job.teamlead==" " then job.teamlead=score.name end
	jobTriggerDel()
    smyTrigger()
	messageShow('��Ħ����������ʼ��')
	return prepare_lianxi(smyGo)
end
function smyGo()
    if locl.room == "��Ħ��-����" then
	    disWait()
	    EnableTriggerGroup("smyAsk",false)
		EnableTriggerGroup("smyAccept",false)
		EnableTriggerGroup("smyFight",true)
		EnableTriggerGroup("smyTeam",true)
		return smyLocate()
	end
	return go(smyPre,"ؤ��","������")
end
function smyPre()
    flag.idle = 0
    --if os.time()-job.time.b>1800 then
	if os.time()-job.time.b>300 then
        --job.zuhe["smy"]=nil
        return smyChang()
    end
    locate()
    return checkWait(smyWait,3)
end
function smyWait()
    if locl.room~="������" then
        return smyGo()
    end
    if locl.id[job.teamname] and score.name==job.teamlead then
	    job.teamid = locl.id[job.teamname]
        exe('team dismiss')
        exe('team with '.. job.teamid)
    else
        return prepare_lianxi(smyPre)
    end
end
function smyStart()
    EnableTriggerGroup("smyAsk",true)
    if not locl.id["³�н�"] then
	    return smyBusy()
	end
	if job.teamlead==score.name then
	    exe('ask lu youjiao about ��Ч����')
	end
end
function smyTeam(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
	    disWait()
	    EnableTriggerGroup("smyAsk",true)
        exe('team dismiss')
        exe('team with '..job.teamid)        
    end
end
function smyTeamMeet()
    if locl.room=="������" then
       dis_all()
       exe('halt')
       return check_bei(smyStart)
    end
end
function smyTeamLineup(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
        exe('lineup with '..job.teamid)
    end
end
function smyTeamComm(n,l,w)
    if job.teamname and w[2]==job.teamname and string.lower(w[3])==job.teamid then
	    if string.find(w[4],"����ס��") then smyQuit = true end
	end
	if job.teamname and w[2]==job.teamname and string.lower(w[3])==job.teamid then
	    if string.find(w[4],"��������") then
            return smyBusy()		
		end
	end
end
function smyAccept()
    EnableTriggerGroup("smyAsk",false)
	EnableTriggerGroup("smyAccept",true)
end
function smyLocate()
    EnableTriggerGroup("smyAccept",false)
	EnableTriggerGroup("smyTeam",true)
    locate()
	return check_bei(smyLocateCheck,1)
end
function smyLocateCheck()
    if locl.room ~= "��Ħ��-����" then
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('��Ħ�����񣺽�����ս�ص㡣')
	exe('halt')
	return check_bei(smyStatus,1)
end
function smyStatus()
    EnableTriggerGroup("smyFight",true)
    condition = {}
    exe('yun qi;yun jingli;hp;cond')
	checkBags()
	locate()
	return check_bei(smyStatusCheck,1)
end
function smyKillWushi()
    disWait()
    exe('kill wu shi')
	exe('pfmpfm')
    create_timer_s('smy',3,'smyKillCmd')
end
function smyKillCmd()
    exe('kill wu shi')
end
function smyStatusCheck()
    if job.teamlead and job.teamlead~=score.name then
	    exe('get gold from corpse')
	else  
	    exe('get gold from corpse 2')
	end
    if smyQuit then 
	    messageShow("��Ħ�����񣺽ӵ����Ѿ�������ǰ���ˡ�")
	    return smyLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("��Ħ�������ж�������ʮ�룬׼�����ˡ�")
	    return smyLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("��Ħ���������˳�����ʮ�룬׼�����ˡ�")
	    return smyLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("��Ħ�����񣺱���������ʮ�룬׼�����ˡ�")
	    return smyLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("��Ħ�����񣺷��г�����ʮ�룬׼�����ˡ�")
	    return smyLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("��Ħ���������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return smyLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("��Ħ���������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return smyLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("��Ħ���������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return smyLeave() 
		end
	end
	if not Bag["�󻹵�"] and not Bag["�󻹵�(��)"] then 
	    messageShow("��Ħ�����񣺴󻹵��ù��ˣ�׼�����ˡ�")
	    return smyLeave() 
	end
	exe('yun jing;yun qi;yun jingli')
	exe('unset heal;yun heal')
	return check_bei(smyPreNeili,1)
end
function smyPreNeili()
    if smyQuit then return smyLeave() end
    return prepare_neili()
end
function smyPrepare()
    if smyQuit then return smyLeave() end
    prepare_neili_stop()
	return check_bei(fight_prepare,1)
end
function smyWuDie()
    smyWushi = smyWushi + 1
end
function smyCount()
    flag.idle = 0
	EnableTimer('smy',false)
	DeleteTimer("smy")
	if smyWushi and smyWushi>=smyRounds*2 then smyLeave() end
	if smyKilled and os.time()-smyKilled<60 then
	    return
	end
	smyKilled = os.time()
    smyRound = smyRound + 1
	messageShow("��Ħ�������ѽ����"..smyRound.."�֣��ƻ����"..smyRounds.."�֡�")
	if smyRound >= smyRounds then smyLeave() end
	return smyStatus()
end
function smyLeave()
    if job.teamlead and job.teamlead~=score.name then
	    return exe('tt �ӳ������Ѿ�����ס�ˣ����볷�ˣ�')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(smyLeaveCheck,1)
end
function smyCheckQuit()
    if smyQuit then
        messageShow("��Ħ�����񣺽ӵ����Ѿ�������ǰ���ˡ�")	
	    return smyLeave() 
	end
end
function smyDie()
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(smyLeaveCheck,1)
end
function smyLeaveCheck()
    if locl.room == "��Ħ��-����" then
	    return check_bei(smyLeave,1)
	end
	return check_bei(smyFinish,1)
end
function smyFinish()
    messageShow("��Ħ�����񣺴˴�����һ�����"..smyRound.."��Ϯ�����������"..smyWushi.."��������ʿ��")
	return check_heal()
end
