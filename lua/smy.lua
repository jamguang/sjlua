--组队颂摩崖
jobSpecial = jobSpecial or {}
jobSpecial["smy"] = true
job.list = job.list or {}
job.list["smy"] = function() if canwu and canwu.gift and canwu.gift>1 then return "颂摩崖" else return false end end
joblast = joblast or {}
joblast["抗敌颂摩崖"] = "smy"
jobCond = jobCond or {}
jobCond["smy"] = function() if job.last~="smy" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["颂摩崖任务倒计时"] or (condition["颂摩崖任务倒计时"] and condition["颂摩崖任务倒计时"]==0) or (condition["任务繁忙状态"] and condition["颂摩崖任务倒计时"] and condition["颂摩崖任务倒计时"]<=condition["任务繁忙状态"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["smy"] = "smyTriggerDel"

local smyRounds = 9 --默认杀9轮
local smyRound  = 0
local smyKilled = 0
local smyWushi = 0
local smyQuit   = false

function smyTrigger()
    DeleteTriggerGroup("smyTeam")
    create_trigger_t('smyTeam1',"^(> )*如果你愿意加入，请用 team with (\\D*)。$",'','smyTeam')
    create_trigger_t('smyTeam2',"^(> )*"..job.teamname.."决定加入你的队伍。",'','smyTeamMeet')
    create_trigger_t('smyTeam3',"^(> )*如果你愿意加入，请用\\s*lineup\\s*with\\s*(\\D*)。$",'','smyTeamLineup')
	create_triggerex_lvl('smyTeam4',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：(.*)",'','smyTeamComm',95)
    SetTriggerOption("smyTeam1","group","smyTeam")
    SetTriggerOption("smyTeam2","group","smyTeam")
    SetTriggerOption("smyTeam3","group","smyTeam")
	SetTriggerOption("smyTeam4","group","smyTeam")
    DeleteTriggerGroup("smyAsk")
    create_trigger_t('smyAsk1',"^(> )*(你|"..job.teamlead..")向鲁有脚打听有关",'','smyAccept')
    create_trigger_t('smyAsk2',"^(> )*这里没有这个人。$",'','smyNobody')
	SetTriggerOption("smyAsk1","group","smyAsk")
    SetTriggerOption("smyAsk2","group","smyAsk")
    EnableTriggerGroup("smyAsk",false)
    DeleteTriggerGroup("smyAccept")
    create_trigger_t('smyAccept1',"^(> )*鲁有脚说道：「时间紧急，我用地道送你们过去",'','smyLocate')
    create_trigger_t('smyAccept2',"^(> )*鲁有脚说道：「你\\D*刚做完",'','smyBusy')
	create_trigger_t('smyAccept3',"^(> )*鲁有脚说道：「你的队伍里有奸佞小人",'','smyBusy')
	create_trigger_t('smyAccept4',"^(> )*鲁有脚说道：「我看你獐头鼠目，不象",'','smyBusy')
    SetTriggerOption("smyAccept1","group","smyAccept")
    SetTriggerOption("smyAccept2","group","smyAccept")
	SetTriggerOption("smyAccept3","group","smyAccept")
	SetTriggerOption("smyAccept4","group","smyAccept")
	EnableTriggerGroup("smyAccept",false)
	DeleteTriggerGroup("smyFight")
    create_trigger_t('smyFight1','^(> )*西夏武士「啪」的一声倒在地上','','smyWuDie')
    create_trigger_t('smyFight2','^(> )*西夏武士神志迷糊，脚下一个不稳，倒在地上昏了过去。','kill wu shi','')
    create_trigger_t('smyFight3','^(> )*这里没有这个人。','','smyCount')
	create_trigger_t('smyFight4','^(> )*远处的山路传来一阵轻啸，隐约听得有人施展轻功飞驰而来。','','smyPrepare')
	create_trigger_t('smyFight5','^(> )*山崖北面的小路上闪出几条人影','','smyKillWushi')
	create_trigger_t('smyFight6','^(> )*一阵天旋地转，你一阵恍惚，才发现自己退出了副本空间。','','smyFinish')
	create_trigger_t('smyFight7','^(> )*'.. job.teamname ..'「啪」的一声倒在地','','smyDie')
	create_trigger_t('smyFight8','^(> )*(远处传来一阵野兽的叫声|一阵呼啸的山风刮过|山崖下的山谷传来一声凄厉的长啸|一对契丹服饰的夫妇)','','smyCheckQuit')
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
	exe('tt 鲁长老不在了，换个任务吧！')
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
	if not Bag["大还丹"] or Bag["大还丹"].cnt<2 then
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
	messageShow('颂摩崖任务：任务开始。')
	return prepare_lianxi(smyGo)
end
function smyGo()
    if locl.room == "颂摩崖-副本" then
	    disWait()
	    EnableTriggerGroup("smyAsk",false)
		EnableTriggerGroup("smyAccept",false)
		EnableTriggerGroup("smyFight",true)
		EnableTriggerGroup("smyTeam",true)
		return smyLocate()
	end
	return go(smyPre,"丐帮","土地庙")
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
    if locl.room~="土地庙" then
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
    if not locl.id["鲁有脚"] then
	    return smyBusy()
	end
	if job.teamlead==score.name then
	    exe('ask lu youjiao about 报效国家')
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
    if locl.room=="土地庙" then
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
	    if string.find(w[4],"顶不住了") then smyQuit = true end
	end
	if job.teamname and w[2]==job.teamname and string.lower(w[3])==job.teamid then
	    if string.find(w[4],"换个任务") then
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
    if locl.room ~= "颂摩崖-副本" then
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('颂摩崖任务：进入作战地点。')
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
	    messageShow("颂摩崖任务：接到队友警报，提前撤退。")
	    return smyLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("颂摩崖任务：中毒超过二十秒，准备撤退。")
	    return smyLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("颂摩崖任务：受伤超过二十秒，准备撤退。")
	    return smyLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("颂摩崖任务：闭气超过二十秒，准备撤退。")
	    return smyLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("颂摩崖任务：封招超过二十秒，准备撤退。")
	    return smyLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("颂摩崖任务：受伤超过百分之八十，准备撤退。")
	        return smyLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("颂摩崖任务：受伤超过百分之八十，准备撤退。")
	        return smyLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("颂摩崖任务：受伤超过百分之八十，准备撤退。")
	        return smyLeave() 
		end
	end
	if not Bag["大还丹"] and not Bag["大还丹(盒)"] then 
	    messageShow("颂摩崖任务：大还丹用光了，准备撤退。")
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
	messageShow("颂摩崖任务：已解决第"..smyRound.."轮，计划完成"..smyRounds.."轮。")
	if smyRound >= smyRounds then smyLeave() end
	return smyStatus()
end
function smyLeave()
    if job.teamlead and job.teamlead~=score.name then
	    return exe('tt 队长，我已经顶不住了！申请撤退！')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(smyLeaveCheck,1)
end
function smyCheckQuit()
    if smyQuit then
        messageShow("颂摩崖任务：接到队友警报，提前撤退。")	
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
    if locl.room == "颂摩崖-副本" then
	    return check_bei(smyLeave,1)
	end
	return check_bei(smyFinish,1)
end
function smyFinish()
    messageShow("颂摩崖任务：此次任务一共坚持"..smyRound.."轮袭击，共解决了"..smyWushi.."个西夏武士。")
	return check_heal()
end
