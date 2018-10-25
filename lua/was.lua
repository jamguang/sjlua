--勇闯万安寺
jobSpecial = jobSpecial or {}
jobSpecial["was"] = true
job.list = job.list or {}
job.list["was"] = function() if canwu and canwu.gift and canwu.gift>1 then return "勇闯万安寺" else return false end end
joblast = joblast or {}
joblast["勇闯万安寺"] = "was"
jobCond = jobCond or {}
jobCond["was"] = function() if job.last~="was" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["万安寺任务繁忙状态"] or (condition["万安寺任务繁忙状态"] and condition["万安寺任务繁忙状态"]==0) or (condition["任务繁忙状态"] and condition["万安寺任务繁忙状态"] and condition["万安寺任务繁忙状态"]<=condition["任务繁忙状态"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["was"] = "wasTriggerDel"

local wasRounds = 11 --默认杀11轮
local wasRound  = 0
local wasKilled = 0
local wasWushi  = 0
local wasQuit   = false
local wasNext   = false

function wasTrigger()
    DeleteTriggerGroup("wasTeam")
    create_trigger_t('wasTeam1',"^(> )*如果你愿意加入，请用 team with (\\D*)。$",'','wasTeam')
    create_trigger_t('wasTeam2',"^(> )*"..job.teamname.."决定加入你的队伍。",'','wasTeamMeet')
    create_trigger_t('wasTeam3',"^(> )*如果你愿意加入，请用\\s*lineup\\s*with\\s*(\\D*)。$",'','wasTeamLineup')
	create_triggerex_lvl('wasTeam4',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：(.*)",'','wasTeamComm',95)
	create_trigger_t('wasTeam5',"^(> )*你来晚了,已经错过了进入万安寺的最佳时机。",'','wasFail')
    SetTriggerOption("wasTeam1","group","wasTeam")
    SetTriggerOption("wasTeam2","group","wasTeam")
    SetTriggerOption("wasTeam3","group","wasTeam")
	SetTriggerOption("wasTeam4","group","wasTeam")
	SetTriggerOption("wasTeam5","group","wasTeam")
    DeleteTriggerGroup("wasAsk")
    create_trigger_t('wasAsk1',"^(> )*(你|"..job.teamlead..")向张无忌打听有关",'','wasAccept')
    create_trigger_t('wasAsk2',"^(> )*这里没有这个人。$",'','wasNobody')
	SetTriggerOption("wasAsk1","group","wasAsk")
    SetTriggerOption("wasAsk2","group","wasAsk")
    EnableTriggerGroup("wasAsk",false)
    DeleteTriggerGroup("wasAccept")
    create_trigger_t('wasAccept1',"^(> )*张无忌(对你|)说道：(「|)这批武士中不乏高手",'','wasSpeed')
    create_trigger_t('wasAccept2',"^(> )*张无忌(对你|)说道：(「|)你(\\D*)刚做完",'','wasChang')
	create_trigger_t('wasAccept3',"^(> )*张无忌(对你|)说道：(「|)你的队伍里有奸佞小人",'','wasChang')
	create_trigger_t('wasAccept4',"^(> )*张无忌(对你|)说道：(「|)你坏事做多了",'','wasChang')
    SetTriggerOption("wasAccept1","group","wasAccept")
    SetTriggerOption("wasAccept2","group","wasAccept")
	SetTriggerOption("wasAccept3","group","wasAccept")
	SetTriggerOption("wasAccept4","group","wasAccept")
	EnableTriggerGroup("wasAccept",false)
	DeleteTriggerGroup("wasFight")
    create_trigger_t('wasFight1','^(> )*蒙古武士「啪」的一声倒在地上','','wasWuDie')
    create_trigger_t('wasFight2','^(> )*蒙古武士神志迷糊，脚下一个不稳，倒在地上昏了过去。','kill wu shi','')
    create_trigger_t('wasFight3','^(> )*这里没有这个人。','','wasCount')
	create_trigger_t('wasFight4','^(> )*你来到高塔内的第(\\D*)层','','wasPrepare')
	create_trigger_t('wasFight5','突然之间，宝塔上亮起火光','','wasKillWushi')
	create_trigger_t('wasFight6','^(> )*一阵天旋地转，你一阵恍惚，才发现自己退出了副本空间。','','wasFinish')
	create_trigger_t('wasFight7','^(> )*'.. job.teamname ..'「啪」的一声倒在地','','wasDie')
	create_trigger_t('wasFight8','^(> )*(你悄悄一路潜行|又不时传来惨叫|塔上不时飘来兵刃碰撞)','','wasCheckQuit')
    SetTriggerOption("wasFight1","group","wasFight") 
    SetTriggerOption("wasFight2","group","wasFight")
    SetTriggerOption("wasFight3","group","wasFight")
	SetTriggerOption("wasFight4","group","wasFight")
	SetTriggerOption("wasFight5","group","wasFight")--你借助灌木从林，慢慢靠近高塔，利用灯火闪烁之际一个闪身已飘然入塔。
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
	exe('tt 张无忌不在了，换个任务吧！')
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
	exe('tt 队伍中有人条件不符，换个任务吧！')
	return wasBusy()
end
function wasFail()
    exe('tt 速度太慢失败了，换个任务吧！')
	return wasBusy()
end
function was()
    if hp.shen<0 then
	    return turnShen('+')
	end
	if (not Bag["大还丹"] or Bag["大还丹"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    job.name = 'was'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
	
	job.killer = {}
	job.killer["蒙古武士"] = true
	
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
	messageShow('万安寺任务：任务开始。')
	return prepare_lianxi(wasGo)
end
function wasGo()
    checkBags()
	return go(wasPre,"明教","圣火堂")
end
function wasPre()
    if (not Bag["大还丹"] or Bag["大还丹"].cnt<2) and score.tongbao and score.tongbao>500 then
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
    if locl.room~="圣火堂" then
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
    if not locl.id["张无忌"] then
	    return wasBusy()
	end
	EnableTriggerGroup("wasAsk",true)
	exe('ask zhang wuji about 万安寺')
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
    if locl.room=="圣火堂" then
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
	    if string.find(w[4],"顶不住了") then wasQuit = true end
	    if string.find(w[4],"换个任务") then
            return wasBusy()		
		end
		if string.find(w[4],"准备就位") then
		    return wasDyd()
		end
		if string.find(w[4],"赶快出发") then
		    if not road.act==wasLocGo or locl.room=="圣火堂" then
		        return wasDyd()
			end
		end
		if string.find(w[4],"开始下一层") then
		    return wasPreNext()
		end
		if string.find(w[4],"冷泉失效时间") and string.find(w[4],"【") and string.find(w[4],"】") then
		    local lqtime = tonumber(string.sub(w[4],string.find(w[4],"【")+2,string.find(w[4],"】")-1))
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
    exe("tt 接到任务了，准备就位！")
	return wasDyd()
end
function wasDyd()
    disWait()
	prepare_neili_stop()
    return go(wasLocGo,"万安寺","万安寺外")
end
function wasLocGo()
    if locl.room~= "万安寺外" then
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
    if not string.find(locl.room,"副本") then
	    tmp.loc = tmp.loc or 0
		tmp.loc = tmp.loc + 1
		if tmp.loc > 60 then
		    exe("tt 等不到你，换个任务了！")
			return wasBusy()
		else
		    if math.fmod(tmp.loc,2)==0 then
		        exe("tt 怎么还没到，赶快出发！")
			end
		end
	    return checkWait(wasLocate,3)
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('万安寺任务：进入作战地点。')
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
	    messageShow("万安寺任务：接到队友警报，提前撤退。")
	    return wasLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("万安寺任务：中毒超过二十秒，准备撤退。")
	    return wasLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("万安寺任务：受伤超过二十秒，准备撤退。")
	    return wasLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("万安寺任务：闭气超过二十秒，准备撤退。")
	    return wasLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("万安寺任务：封招超过二十秒，准备撤退。")
	    return wasLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	   if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("万安寺任务：受伤超过百分之八十，准备撤退。")
	        return wasLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("万安寺任务：受伤超过百分之八十，准备撤退。")
	        return wasLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("万安寺任务：受伤超过百分之八十，准备撤退。")
	        return wasLeave() 
		end
	end
	if not Bag["大还丹"] and not Bag["大还丹(盒)"] and wasRound and wasRound > 11 then 
	    messageShow("万安寺任务：大还丹用光了，准备撤退。")
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
            messageShow("万安寺任务：冷泉还差".. tmp.lengquan + skills['lengquan-shengong'].lvl/5 - os.time() .."秒失效了，等一等。")
    		return checkWait(wasPreTeam,2)
		end 
		
		teamlengquan = teamlengquan or {}
		if not (teamlengquan[score.name] and teamlengquan[score.name]==tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5)) then
		    exe("tt 冷泉失效时间：【"..tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5).."】。")
		    teamlengquan[score.name] = tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5)
		end
	end
    if job.teamlead and job.teamlead~=score.name then
	    exe("tt 队长，我准备好了，开始下一层探险吧！")
	else
	    teamlengquan = teamlengquan or {}
		for p,q in pairs(teamlengquan) do
		    if q > os.time() and q < os.time() - 40 then
			    messageShow("万安寺任务：".. p .."的冷泉还差".. q - os.time() .."秒失效，等一等。")
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
	messageShow("万安寺任务：已闯过第"..wasRound.."层，解决了"..wasWushi.."个蒙古武士，此次共计划闯过"..wasRounds.."层。")
	if wasRound >= wasRounds then wasLeave() end
	return wasStatus()
end
function wasLeave()
    if wasRound and wasRound < 1 then
        messageShow("万安寺任务：还未闯过第一层，不能走。")
		return wasPreNeili()
	end
    if job.teamlead and job.teamlead~=score.name then
	    wasQuit = true
	    return exe('tt 队长，我已经顶不住了！申请撤退！')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(wasLeaveCheck,1)
end
function wasCheckQuit()
    if wasQuit then
        messageShow("万安寺任务：接到队友警报，提前撤退。")	
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
    if string.find(locl.room,"副本") then
	    return check_bei(wasLeave,1)
	end
	return check_bei(wasFinish,1)
end
function wasFinish()
    dis_all()
    messageShow("万安寺任务：此次任务一共闯过"..wasRound.."层，共解决了"..wasWushi.."个蒙古武士。")
	return go(check_heal,"襄阳城","当铺")
end