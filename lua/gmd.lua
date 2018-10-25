--Χ��������
jobSpecial = jobSpecial or {}
jobSpecial["gmd"] = true
job.list = job.list or {}
job.list["gmd"] = function() if canwu and canwu.gift and canwu.gift>1 then return "Χ��������" else return false end end
joblast = joblast or {}
joblast["Χ��������"] = "gmd"
jobCond = jobCond or {}
jobCond["gmd"] = function() if job.last~="gmd" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["����������æ״̬"] or (condition["����������æ״̬"] and condition["����������æ״̬"]==0) or (condition["����æ״̬"] and condition["����������æ״̬"] and condition["����������æ״̬"]<=condition["����æ״̬"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["gmd"] = "gmdTriggerDel"

local gmdRounds = 11
local gmdRound  = 0
local gmdKilled = 0
local gmdWushi  = 0
local gmdQuit   = false
local gmdNext   = false

function gmdNeedDhd()
    if perform.force=="lengquan-shengong" then return false end
	if skills["lingbo-weibu"] then return false end
	if skills["yuenv-jian"] then return false end
    return true
end

function gmdTrigger()
    DeleteTriggerGroup("gmdTeam")
    create_trigger_t('gmdTeam1',"^(> )*�����Ը����룬���� team with (\\D*)��$",'','gmdTeam')
    create_trigger_t('gmdTeam2',"^(> )*"..job.teamname.."����������Ķ��顣",'','gmdTeamMeet')
    create_trigger_t('gmdTeam3',"^(> )*�����Ը����룬����\\s*lineup\\s*with\\s*(\\D*)��$",'','gmdTeamLineup')
	create_triggerex_lvl('gmdTeam4',"^(> )*�����顿(\\D*)\\((\\D*)\\)��(.*)",'','gmdTeamComm',95)
	create_trigger_t('gmdTeam5',"^(> )*��������,�Ѿ�����˽��������������ʱ����",'','gmdFail')
    SetTriggerOption("gmdTeam1","group","gmdTeam")
    SetTriggerOption("gmdTeam2","group","gmdTeam")
    SetTriggerOption("gmdTeam3","group","gmdTeam")
	SetTriggerOption("gmdTeam4","group","gmdTeam")
	SetTriggerOption("gmdTeam5","group","gmdTeam")
    DeleteTriggerGroup("gmdAsk")
    create_trigger_t('gmdAsk1',"^(> )*(��|"..job.teamlead..")�����������й�",'','gmdAccept')
    create_trigger_t('gmdAsk2',"^(> )*����û������ˡ�$",'','gmdNobody')
	SetTriggerOption("gmdAsk1","group","gmdAsk")
    SetTriggerOption("gmdAsk2","group","gmdAsk")
    EnableTriggerGroup("gmdAsk",false)
    DeleteTriggerGroup("gmdAccept")
    create_trigger_t('gmdAccept1',"^(> )*����(����|)˵����(��|)�����в�������",'','gmdSpeed')
    create_trigger_t('gmdAccept2',"^(> )*����(����|)˵����(��|)��(\\D*)������",'','gmdChang')
	create_trigger_t('gmdAccept3',"^(> )*����(����|)˵����(��|)��Ķ������м���С��",'','gmdChang')
	create_trigger_t('gmdAccept4',"^(> )*����(����|)˵����(��|)�㻵��������",'','gmdChang')
    SetTriggerOption("gmdAccept1","group","gmdAccept")
    SetTriggerOption("gmdAccept2","group","gmdAccept")
	SetTriggerOption("gmdAccept3","group","gmdAccept")
	SetTriggerOption("gmdAccept4","group","gmdAccept")
	EnableTriggerGroup("gmdAccept",false)
	DeleteTriggerGroup("gmdFight")
    create_trigger_t('gmdFight1','^(> )*���̽��ڡ�ž����һ�����ڵ���','','gmdWuDie')
    create_trigger_t('gmdFight2','^(> )*���̽�����־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','kill jiaozhong','')
    create_trigger_t('gmdFight3','^(> )*����û������ˡ�','','gmdCount')
	create_trigger_t('gmdFight4','^(> )*��վ�ڹ���������׼��ӭս������Ⱥ����ս��(\\D*)��','','gmdPrepare')
	create_trigger_t('gmdFight5','ͻȻ֮�䣬��������Ⱥ�У��м�����ִ���������������ǰ','','gmdKillWushi')
	create_trigger_t('gmdFight6','^(> )*һ��������ת����һ���㱣��ŷ����Լ��˳��˸����ռ䡣','','gmdFinish')
	create_trigger_t('gmdFight7','^(> )*'.. job.teamname ..'��ž����һ�����ڵ�','','gmdDie')
	create_trigger_t('gmdFight8','^(> )*(��һ·����|�ֲ�ʱ�����ҽ�|�������ϲ�ʱƮ��������ײ|���Ȼ���һ����˭����ս)','','gmdCheckQuit')
    SetTriggerOption("gmdFight1","group","gmdFight") 
    SetTriggerOption("gmdFight2","group","gmdFight")
    SetTriggerOption("gmdFight3","group","gmdFight")
	SetTriggerOption("gmdFight4","group","gmdFight")
	SetTriggerOption("gmdFight5","group","gmdFight")
	SetTriggerOption("gmdFight6","group","gmdFight")
	SetTriggerOption("gmdFight7","group","gmdFight")
	SetTriggerOption("gmdFight8","group","gmdFight")
    EnableTriggerGroup("gmdFight",false)
end
function gmdTriggerDel()
    DeleteTriggerGroup("gmdTeam")
    DeleteTriggerGroup("gmdAsk")
    DeleteTriggerGroup("gmdAccept")
    DeleteTriggerGroup("gmdFight")
end
function gmdNobody()
    EnableTriggerGroup("gmdAsk",false)
	exe('tt ���������ˣ���������ɣ�')
    return gmdBusy()
end
function gmdBusy()
    EnableTriggerGroup("gmdTeam",false)
    EnableTriggerGroup("gmdAsk",false)
	EnableTriggerGroup("gmdAccept",false)
	gmdTriggerDel()	
	return checkJob()
end
function gmdChang()
	exe('tt ����������������������������ɣ�')
	return gmdBusy()
end
function gmdFail()
    exe('tt �ٶ�̫��ʧ���ˣ���������ɣ�')
	return gmdBusy()
end
function gmd()
    if hp.shen>0 then
	    return turnShen('-')
	end
	if gmdNeedDhd() and (not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    job.name = 'gmd'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
	
	job.killer = {}
	job.killer["���̽���"] = true
	
	gmdRound  = 0
	gmdWushi = 0
	gmdQuit = false
    if not job.teamlead or job.teamlead=="" or job.teamlead==" " then job.teamlead=score.name end
	jobTriggerDel()
    gmdTrigger()
	if GetVariable("flaggmdround") then
	    local l_round = tonumber(GetVariable("flaggmdround"))
		if l_round > 0 and l_round <= 1000 then
		    gmdRounds = l_round
		end
	end
	messageShow('��������������ʼ��')
	return prepare_lianxi(gmdGo)
end
function gmdGo()
    checkBags()
	return go(gmdPre,"���ݳ�","ƫ��")
end
function gmdPre()
	if (not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    flag.idle = 0
    --if os.time()-job.time.b>1800 then
	if os.time()-job.time.b>300 then
        --job.zuhe["gmd"]=nil
        --return check_job()
		return gmdBusy()
    end
    locate()
    return checkWait(gmdWait,3)
end
function gmdWait()
    if locl.room~="ƫ��" then
        return gmdGo()
    end
    if locl.id[job.teamname] and score.name==job.teamlead then
	    job.teamid = locl.id[job.teamname]
        exe('team dismiss')
        exe('team with '.. job.teamid)
    else
        return prepare_lianxi(gmdPre)
    end
end
function gmdStart()
    if not locl.id["����"] then
	    return gmdBusy()
	end
	EnableTriggerGroup("gmdAsk",true)
	exe('ask zhao min about Χ��������')
end
function gmdTeam(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
	    disWait()
	    EnableTriggerGroup("gmdTeam",true)
        exe('team dismiss')
        exe('team with '..job.teamid)        
    end
end
function gmdTeamMeet()
    if locl.room=="ƫ��" then
       dis_all()
       exe('halt')
       return check_bei(gmdStart)
    end
end
function gmdTeamLineup(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
        exe('lineup with '..job.teamid)
    end
end
function gmdTeamComm(n,l,w)
    if job.teamname and w[2]==job.teamname and string.lower(w[3])==job.teamid then
	    if string.find(w[4],"����ס��") then gmdQuit = true end
	    if string.find(w[4],"��������") then
            return gmdBusy()		
		end
		if string.find(w[4],"׼����λ") then
		    return gmdDyd()
		end
		if string.find(w[4],"�Ͽ����") then
		    if not road.act==gmdLocGo or locl.room=="ƫ��" then
		        return gmdDyd()
			end
		end
		if string.find(w[4],"��ʼ��һ��") then
		    return gmdPreNext()
		end
		if string.find(w[4],"��ȪʧЧʱ��") and string.find(w[4],"��") and string.find(w[4],"��") then
		    local lqtime = tonumber(string.sub(w[4],string.find(w[4],"��")+2,string.find(w[4],"��")-1))
			teamlengquan = teamlengquan or {}
			teamlengquan[job.teamname] = lqtime
		end
	end
end
function gmdAccept()
    EnableTriggerGroup("gmdAsk",false)
	EnableTriggerGroup("gmdAccept",true)
end
function gmdSpeed()
    exe("tt �ӵ������ˣ�׼����λ��")
	return gmdDyd()
end
function gmdDyd()
    disWait()
	prepare_neili_stop()
    return go(gmdLocGo,"����","������")
end
function gmdLocGo()
    if locl.room~= "������" then
	    return gmdDyd()
	end
	tmp.loc = 0
	return check_bei(gmdLocate,1)
end
function gmdLocate()
    EnableTriggerGroup("gmdAccept",false)
	EnableTriggerGroup("gmdTeam",true)
	tmp.loc = 0
    
	if job.teamlead==score.name and locl.id[job.teamname] then
	    exe('weigong')
	end
	locate()
	return check_bei(gmdLocateCheck,1)
end
function gmdLocateCheck()
    if not string.find(locl.room,"����") then
	    tmp.loc = tmp.loc or 0
		tmp.loc = tmp.loc + 1
		if tmp.loc > 60 then
		    exe("tt �Ȳ����㣬���������ˣ�")
			return gmdBusy()
		else
		    if math.fmod(tmp.loc,2)==0 then
		        exe("tt ��ô��û�����Ͽ������")
			end
		end
	    return checkWait(gmdLocate,3)
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('���������񣺽�����ս�ص㡣')
	exe('halt')
	return check_bei(gmdStatus,1)
end
function gmdStatus()
    EnableTriggerGroup("gmdFight",true)
    condition = {}
    exe('yun qi;yun jingli;hp;cond')
	checkBags()
	locate()
	return check_bei(gmdStatusCheck,1)
end
function gmdKillWushi()
    disWait()
    exe('kill jiaozhong')
	exe('pfmpfm')
    create_timer_s('gmd',3,'gmdKillCmd')
end
function gmdKillCmd()
    exe('kill jiaozhong')
end
function gmdStatusCheck()
    if job.teamlead and job.teamlead~=score.name then
	    exe('get gold from corpse')
	else  
	    exe('get gold from corpse 2')
	end
    if gmdQuit then 
	    messageShow("���������񣺽ӵ����Ѿ�������ǰ���ˡ�")
	    return gmdLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("�����������ж�������ʮ�룬׼�����ˡ�")
	    return gmdLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("�������������˳�����ʮ�룬׼�����ˡ�")
	    return gmdLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("���������񣺱���������ʮ�룬׼�����ˡ�")
	    return gmdLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("���������񣺷��г�����ʮ�룬׼�����ˡ�")
	    return gmdLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�������������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return gmdLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�������������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return gmdLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["�󻹵�"] and Bag["�󻹵�"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("�������������˳����ٷ�֮��ʮ��׼�����ˡ�")
	        return gmdLeave() 
		end
	end
	if gmdNeedDhd() and not Bag["�󻹵�"] and not Bag["�󻹵�(��)"] and gmdRound and gmdRound > 11 then 
	    messageShow("���������񣺴󻹵��ù��ˣ�׼�����ˡ�")
	    return gmdLeave() 
	end
	exe('yun jing;yun qi;yun jingli')
	exe('unset heal;yun heal')
	return check_bei(gmdPreNeili,1)
end
function gmdPreNeili()
    if gmdQuit then return gmdLeave() end
	if gmdRound and gmdRound == 0 then
	    return prepare_neili()
	else
        return prepare_neili(gmdPreTeam)
	end
end
function gmdPreTeam()
    if gmdQuit then return gmdLeave() end
	
	if gmdRound and gmdRound > 10 and perform.force=="lengquan-shengong" then
	    tmp.lengquan = tmp.lengquan or os.time()
    	if (tmp.lengquan + math.modf(skills["lengquan-shengong"].lvl/5)) > os.time() and (tmp.lengquan + math.modf(skills["lengquan-shengong"].lvl/5)) < (os.time() + 40) then 
            messageShow("������������Ȫ����".. tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5) - os.time() .."��ʧЧ����һ�ȡ�")
    		return checkWait(gmdPreTeam,2)
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
			    messageShow("����������".. p .."����Ȫ����".. q - os.time() .."��ʧЧ����һ�ȡ�")
    		    return checkWait(gmdPreTeam,2)
			end
		end
		
	    if gmdNext then
		    --gmdNext = false
			return check_busy(gmdPreUp)
        else
		    return checkWait(gmdPreTeam,2)
        end		
	end
end
function gmdPreNext()
    gmdNext = true
end
function gmdPreUp()
    gmdNext = false
    exe("up")
end
function gmdPrepare(n,l,w)
    if gmdQuit then return gmdLeave() end
	gmdRound = trans(w[2])
    prepare_neili_stop()
	return check_bei(fight_prepare,1)
end
function gmdWuDie()
    gmdWushi = gmdWushi + 1
end
function gmdCount()
    flag.idle = 0
	EnableTimer('gmd',false)
	DeleteTimer("gmd")
	messageShow("�����������Ѵ�����"..gmdRound.."�㣬�����"..gmdWushi.."�����̽��ڣ��˴ι��ƻ�����"..gmdRounds.."�㡣")
	if gmdRound >= gmdRounds then gmdLeave() end
	return gmdStatus()
end
function gmdLeave()
    if gmdRound and gmdRound < 1 then
	    messageShow("���������񣺻�δ������һ�㣬�����ߡ�")
		return check_bei(gmdPreNeili,1)
	end
    if job.teamlead and job.teamlead~=score.name then
	    gmdQuit = true
	    return exe('tt �ӳ������Ѿ�����ס�ˣ����볷�ˣ�')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(gmdLeaveCheck,1)
end
function gmdCheckQuit()
    if gmdQuit then
        messageShow("���������񣺽ӵ����Ѿ�������ǰ���ˡ�")	
	    return gmdLeave() 
	end
end
function gmdDie()
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(gmdLeaveCheck,1)
end
function gmdLeaveCheck()
    if string.find(locl.room,"����") then
	    return check_bei(gmdLeave,1)
	end
	return check_bei(gmdFinish,1)
end
function gmdFinish()
    dis_all()
    messageShow("���������񣺴˴�����һ������"..gmdRound.."�㣬�������"..gmdWushi.."�����̽��ڡ�")
	return go(check_heal,"������","����")
end