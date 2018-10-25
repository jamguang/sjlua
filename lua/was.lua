--�´�����
jobSpecial = jobSpecial or {}
jobSpecial["was"] = true
job.list = job.list or {}
job.list["was"] = function() if canwu and canwu.gift and canwu.gift>1 then return "�´�����" else return false end end
joblast = joblast or {}
joblast["�´�����"] = "was"
jobCond = jobCond or {}
jobCond["was"] = function() if job.last~="was" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["��������æ״̬"] or (condition["��������æ״̬"] and condition["��������æ״̬"]==0) or (condition["����æ״̬"] and condition["��������æ״̬"] and condition["��������æ״̬"]<=condition["����æ״̬"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["was"] = "wasTriggerDel"

local wasRounds = 11 --Ĭ��ɱ11��
local wasRound  = 0
local wasKilled = 0
local wasWushi  = 0
local wasQuit   = false
local wasNext   = false

function wasTrigger()
    DeleteTriggerGroup("wasTeam")
    create_trigger_t('wasTeam1',"^(> )*�����Ը����룬���� team with (\\D*)��$",'','wasTeam')
    create_trigger_t('wasTeam2',"^(> )*"..job.teamname.."����������Ķ��顣",'','wasTeamMeet')
    create_trigger_t('wasTeam3',"^(> )*�����Ը����룬����\\s*lineup\\s*with\\s*(\\D*)��$",'','wasTeamLineup')
	create_triggerex_lvl('wasTeam4',"^(> )*�����顿(\\D*)\\((\\D*)\\)��(.*)",'','wasTeamComm',95)
	create_trigger_t('wasTeam5',"^(> )*��������,�Ѿ�����˽������µ����ʱ����",'','wasFail')
    SetTriggerOption("wasTeam1","group","wasTeam")
    SetTriggerOption("wasTeam2","group","wasTeam")
    SetTriggerOption("wasTeam3","group","wasTeam")
	SetTriggerOption("wasTeam4","group","wasTeam")
	SetTriggerOption("wasTeam5","group","wasTeam")
    DeleteTriggerGroup("wasAsk")
    create_trigger_t('wasAsk1',"^(> )*(��|"..job.teamlead..")�����޼ɴ����й�",'','wasAccept')
    create_trigger_t('wasAsk2',"^(> )*����û������ˡ�$",'','wasNobody')
	SetTriggerOption("wasAsk1","group","wasAsk")
    SetTriggerOption("wasAsk2","group","wasAsk")
    EnableTriggerGroup("wasAsk",false)
    DeleteTriggerGroup("wasAccept")
    create_trigger_t('wasAccept1',"^(> )*���޼�(����|)˵����(��|)������ʿ�в�������",'','wasSpeed')
    create_trigger_t('wasAccept2',"^(> )*���޼�(����|)˵����(��|)��(\\D*)������",'','wasChang')
	create_trigger_t('wasAccept3',"^(> )*���޼�(����|)˵����(��|)��Ķ������м���С��",'','wasChang')
	create_trigger_t('wasAccept4',"^(> )*���޼�(����|)˵����(��|)�㻵��������",'','wasChang')
    SetTriggerOption("wasAccept1","group","wasAccept")
    SetTriggerOption("wasAccept2","group","wasAccept")
	SetTriggerOption("wasAccept3","group","wasAccept")
	SetTriggerOption("wasAccept4","group","wasAccept")
	EnableTriggerGroup("wasAccept",false)
	DeleteTriggerGroup("wasFight")
    create_trigger_t('wasFight1','^(> )*�ɹ���ʿ��ž����һ�����ڵ���','','wasWuDie')
    create_trigger_t('wasFight2','^(> )*�ɹ���ʿ��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','kill wu shi','')
    create_trigger_t('wasFight3','^(> )*����û������ˡ�','','wasCount')
	create_trigger_t('wasFight4','^(> )*�����������ڵĵ�(\\D*)��','','wasPrepare')
	create_trigger_t('wasFight5','ͻȻ֮�䣬������������','','wasKillWushi')
	create_trigger_t('wasFight6','^(> )*һ��������ת����һ���㱣��ŷ����Լ��˳��˸����ռ䡣','','wasFinish')
	create_trigger_t('wasFight7','^(> )*'.. job.teamname ..'��ž����һ�����ڵ�','','wasDie')
	create_trigger_t('wasFight8','^(> )*(������һ·Ǳ��|�ֲ�ʱ�����ҽ�|���ϲ�ʱƮ��������ײ)','','wasCheckQuit')
    SetTriggerOption("wasFight1","group","wasFight") 
    SetTriggerOption("wasFight2","group","wasFight")
    SetTriggerOption("wasFight3","group","wasFight")
	SetTriggerOption("wasFight4","group","wasFight")
	SetTriggerOption("wasFight5","group","wasFight")--�������ľ���֣������������������õƻ���˸֮��һ��������ƮȻ������
	SetTriggerOption("wasFight6","group","wasFight")
	SetTriggerOption("wasFight7","group","wasFight")
	SetTriggerOption("wasFight8","group","wasFight")
    EnableTriggerGroup("wasFight",false)
end
function wasTriggerDel()
    DeleteTriggerGroup("wasTeam")
    DeleteTriggerGroup("wasAsk")
    DeleteTriggerGroup("wasAccept")
    DeleteTriggerGroup("wasFight")
end
function wasNobody()
    EnableTriggerGroup("wasAsk",false)
	exe('tt ���޼ɲ����ˣ���������ɣ�')
    return wasBusy()
end
function wasBusy()
    EnableTriggerGroup("wasTeam",false)
    EnableTriggerGroup("wasAsk",false)
	EnableTriggerGroup("wasAccept",false)
	wasTriggerDel()	
	return checkJob()
end
function wasChang()
	exe('tt ����������������������������ɣ�')
	return wasBusy()
end
function wasFail()
    exe('tt �ٶ�̫��ʧ���ˣ���������ɣ�')
	return wasBusy()
end
function was()
    if hp.shen<0 then
	    return turnShen('+')
	end
	if (not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    job.name = 'was'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
	
	job.killer = {}
	job.killer["�ɹ���ʿ"] = true
	
	wasRound  = 0
	wasWushi = 0
	wasQuit = false
    if not job.teamlead or job.teamlead=="" or job.teamlead==" " then job.teamlead=score.name end
	jobTriggerDel()
    wasTrigger()
	if GetVariable("flagwasround") then
	    local l_round = tonumber(GetVariable("flagwasround"))
		if l_round > 0 and l_round <= 1000 then
		    wasRounds = l_round
		end
	end
	messageShow('������������ʼ��')
	return prepare_lianxi(wasGo)
end
function wasGo()
    checkBags()
	return go(wasPre,"����","ʥ����")
end
function wasPre()
    if (not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    flag.idle = 0
    --if os.time()-job.time.b>1800 then
	if os.time()-job.time.b>300 then
        --job.zuhe["was"]=nil
        --return check_job()
		return wasBusy()
    end
    locate()
    return checkWait(wasWait,3)
end
function wasWait()
    if locl.room~="ʥ����" then
        return wasGo()
    end
    if locl.id[job.teamname] and score.name==job.teamlead then
	    job.teamid = locl.id[job.teamname]
        exe('team dismiss')
        exe('team with '.. job.teamid)
    else
        return prepare_lianxi(wasPre)
    end
end
function wasStart()
    if not locl.id["���޼�"] then
	    return wasBusy()
	end
	EnableTriggerGroup("wasAsk",true)
	exe('ask zhang wuji about ����')
end
function wasTeam(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
	    disWait()
	    EnableTriggerGroup("wasTeam",true)
        exe('team dismiss')
        exe('team with '..job.teamid)        
    end
end
function wasTeamMeet()
    if locl.room=="ʥ����" then
       dis_all()
       exe('halt')
       return check_bei(wasStart)
    end
end
function wasTeamLineup(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
        exe('lineup with '..job.teamid)
    end
end
function wasTeamComm(n,l,w)
    if job.teamname and w[2]==job.teamname and string.lower(w[3])==job.teamid then
	    if string.find(w[4],"����ס��") then wasQuit = true end
	    if string.find(w[4],"��������") then
            return wasBusy()		
		end
		if string.find(w[4],"׼����λ") then
		    return wasDyd()
		end
		if string.find(w[4],"�Ͽ����") then
		    if not road.act==wasLocGo or locl.room=="ʥ����" then
		        return wasDyd()
			end
		end
		if string.find(w[4],"��ʼ��һ��") then
		    return wasPreNext()
		end
		if string.find(w[4],"��ȪʧЧʱ��") and string.find(w[4],"��") and string.find(w[4],"��") then
		    local lqtime = tonumber(string.sub(w[4],string.find(w[4],"��")+2,string.find(w[4],"��")-1))
			teamlengquan = teamlengquan or {}
			teamlengquan[job.teamname] = lqtime
		end
	end
end
function wasAccept()
    EnableTriggerGroup("wasAsk",false)
	EnableTriggerGroup("wasAccept",true)
end
function wasSpeed()
    exe("tt �ӵ������ˣ�׼����λ��")
	return wasDyd()
end
function wasDyd()
    disWait()
	prepare_neili_stop()
    return go(wasLocGo,"����","������")
end
function wasLocGo()
    if locl.room~= "������" then
	    return wasDyd()
	end
	tmp.loc = 0
	return check_bei(wasLocate,1)
end
function wasLocate()
    EnableTriggerGroup("wasAccept",false)
	EnableTriggerGroup("wasTeam",true)
	tmp.loc = 0
    
	if job.teamlead==score.name and locl.id[job.teamname] then
	    exe('yingjiu')
	end
	locate()
	return check_bei(wasLocateCheck,1)
end
function wasLocateCheck()
    if not string.find(locl.room,"����") then
	    tmp.loc = tmp.loc or 0
		tmp.loc = tmp.loc + 1
		if tmp.loc > 60 then
		    exe("tt �Ȳ����㣬���������ˣ�")
			return wasBusy()
		else
		    if math.fmod(tmp.loc,2)==0 then
		        exe("tt ��ô��û�����Ͽ������")
			end
		end
	    return checkWait(wasLocate,3)
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('�������񣺽�����ս�ص㡣')
	exe('halt')
	return check_bei(wasStatus,1)
end
function wasStatus()
    EnableTriggerGroup("wasFight",true)
    condition = {}
    exe('yun qi;yun jingli;hp;cond')
	checkBags()
	locate()
	return check_bei(wasStatusCheck,1)
end
function wasKillWushi()
    disWait()
    exe('kill wu shi')
	exe('pfmpfm')
    create_timer_s('was',3,'wasKillCmd')
end
function wasKillCmd()
    exe('kill wu shi')
end
function wasStatusCheck()
    if job.teamlead and job.teamlead~=score.name then
	    exe('get gold from corpse')
	else  
	    exe('get gold from corpse 2')
	end
    if wasQuit then 
	    messageShow("�������񣺽ӵ����Ѿ�������ǰ���ˡ�")
	    return wasLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("���������ж�������ʮ�룬׼�����ˡ�")
	    return wasLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("�����������˳�����ʮ�룬׼�����ˡ�")
	    return wasLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("�������񣺱���������ʮ�룬׼�����ˡ�")
	    return wasLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("�������񣺷��г�����ʮ�룬׼�����ˡ�")
	    return wasLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	   if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�����������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return wasLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�����������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return wasLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�����������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return wasLeave() 
		end
	end
	if not Bag["�󻹵�"] and not Bag["�󻹵�(��)"] and wasRound and wasRound > 11 then 
	    messageShow("�������񣺴󻹵��ù��ˣ�׼�����ˡ�")
	    return wasLeave() 
	end
	exe('yun jing;yun qi;yun jingli')
	exe('unset heal;yun heal')
	return check_bei(wasPreNeili,1)
end
function wasPreNeili()
    if wasQuit then return wasLeave() end
	if wasRound and wasRound == 0 then
	    return prepare_neili()
	else
        return prepare_neili(wasPreTeam)
	end
end
function wasPreTeam()
    if wasQuit then return wasLeave() end
	if wasRound and wasRound > 10 and perform.force=="lengquan-shengong" then
	    tmp.lengquan = tmp.lengquan or os.time()
    	if (tmp.lengquan + skills["lengquan-shengong"].lvl/5) > os.time() and (tmp.lengquan + skills["lengquan-shengong"].lvl/5) < (os.time() + 40) then 
            messageShow("����������Ȫ����".. tmp.lengquan + skills['lengquan-shengong'].lvl/5 - os.time() .."��ʧЧ�ˣ���һ�ȡ�")
    		return checkWait(wasPreTeam,2)
		end 
		
		teamlengquan = teamlengquan or {}
		if not (teamlengquan[score.name] and teamlengquan[score.name]==tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5)) then
		    exe("tt ��ȪʧЧʱ�䣺��"..tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5).."����")
		    teamlengquan[score.name] = tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5)
		end
	end
    if job.teamlead and job.teamlead~=score.name then
	    exe("tt �ӳ�����׼�����ˣ���ʼ��һ��̽�հɣ�")
	else
	    teamlengquan = teamlengquan or {}
		for p,q in pairs(teamlengquan) do
		    if q > os.time() and q < os.time() - 40 then
			    messageShow("��������".. p .."����Ȫ����".. q - os.time() .."��ʧЧ����һ�ȡ�")
    		    return checkWait(wasPreTeam,2)
			end
		end
		
	    if wasNext then
		    --wasNext = false
			return check_busy(wasPreUp)
        else
		    return checkWait(wasPreTeam,2)
        end		
	end
end
function wasPreNext()
    wasNext = true
end
function wasPreUp()
    wasNext = false
    exe("up")
end
function wasPrepare(n,l,w)
    if wasQuit then return wasLeave() end
	wasRound = trans(w[2])
    prepare_neili_stop()
	return check_bei(fight_prepare,1)
end
function wasWuDie()
    wasWushi = wasWushi + 1
end
function wasCount()
    flag.idle = 0
	EnableTimer('was',false)
	DeleteTimer("was")
	messageShow("���������Ѵ�����"..wasRound.."�㣬�����"..wasWushi.."���ɹ���ʿ���˴ι��ƻ�����"..wasRounds.."�㡣")
	if wasRound >= wasRounds then wasLeave() end
	return wasStatus()
end
function wasLeave()
    if wasRound and wasRound < 1 then
        messageShow("�������񣺻�δ������һ�㣬�����ߡ�")
		return wasPreNeili()
	end
    if job.teamlead and job.teamlead~=score.name then
	    wasQuit = true
	    return exe('tt �ӳ������Ѿ�����ס�ˣ����볷�ˣ�')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(wasLeaveCheck,1)
end
function wasCheckQuit()
    if wasQuit then
        messageShow("�������񣺽ӵ����Ѿ�������ǰ���ˡ�")	
	    return wasLeave() 
	end
end
function wasDie()
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(wasLeaveCheck,1)
end
function wasLeaveCheck()
    if string.find(locl.room,"����") then
	    return check_bei(wasLeave,1)
	end
	return check_bei(wasFinish,1)
end
function wasFinish()
    dis_all()
    messageShow("�������񣺴˴�����һ������"..wasRound.."�㣬�������"..wasWushi.."���ɹ���ʿ��")
	return go(check_heal,"������","����")
end