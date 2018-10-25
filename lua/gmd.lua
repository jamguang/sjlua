--围攻光明顶
jobSpecial = jobSpecial or {}
jobSpecial["gmd"] = true
job.list = job.list or {}
job.list["gmd"] = function() if canwu and canwu.gift and canwu.gift>1 then return "围攻光明顶" else return false end end
joblast = joblast or {}
joblast["围攻光明顶"] = "gmd"
jobCond = jobCond or {}
jobCond["gmd"] = function() if job.last~="gmd" and job.teamname and not condition.noexert and not condition.noperform and not condition.wound and not condition.poison and (not condition["光明顶任务繁忙状态"] or (condition["光明顶任务繁忙状态"] and condition["光明顶任务繁忙状态"]==0) or (condition["任务繁忙状态"] and condition["光明顶任务繁忙状态"] and condition["光明顶任务繁忙状态"]<=condition["任务繁忙状态"])) then return true else return false end end
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
    create_trigger_t('gmdTeam1',"^(> )*如果你愿意加入，请用 team with (\\D*)。$",'','gmdTeam')
    create_trigger_t('gmdTeam2',"^(> )*"..job.teamname.."决定加入你的队伍。",'','gmdTeamMeet')
    create_trigger_t('gmdTeam3',"^(> )*如果你愿意加入，请用\\s*lineup\\s*with\\s*(\\D*)。$",'','gmdTeamLineup')
	create_triggerex_lvl('gmdTeam4',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：(.*)",'','gmdTeamComm',95)
	create_trigger_t('gmdTeam5',"^(> )*你来晚了,已经错过了进攻光明顶的最佳时机。",'','gmdFail')
    SetTriggerOption("gmdTeam1","group","gmdTeam")
    SetTriggerOption("gmdTeam2","group","gmdTeam")
    SetTriggerOption("gmdTeam3","group","gmdTeam")
	SetTriggerOption("gmdTeam4","group","gmdTeam")
	SetTriggerOption("gmdTeam5","group","gmdTeam")
    DeleteTriggerGroup("gmdAsk")
    create_trigger_t('gmdAsk1',"^(> )*(你|"..job.teamlead..")向赵敏打听有关",'','gmdAccept')
    create_trigger_t('gmdAsk2',"^(> )*这里没有这个人。$",'','gmdNobody')
	SetTriggerOption("gmdAsk1","group","gmdAsk")
    SetTriggerOption("gmdAsk2","group","gmdAsk")
    EnableTriggerGroup("gmdAsk",false)
    DeleteTriggerGroup("gmdAccept")
    create_trigger_t('gmdAccept1',"^(> )*赵敏(对你|)说道：(「|)明教中不乏高手",'','gmdSpeed')
    create_trigger_t('gmdAccept2',"^(> )*赵敏(对你|)说道：(「|)你(\\D*)刚做完",'','gmdChang')
	create_trigger_t('gmdAccept3',"^(> )*赵敏(对你|)说道：(「|)你的队伍里有奸佞小人",'','gmdChang')
	create_trigger_t('gmdAccept4',"^(> )*赵敏(对你|)说道：(「|)你坏事做多了",'','gmdChang')
    SetTriggerOption("gmdAccept1","group","gmdAccept")
    SetTriggerOption("gmdAccept2","group","gmdAccept")
	SetTriggerOption("gmdAccept3","group","gmdAccept")
	SetTriggerOption("gmdAccept4","group","gmdAccept")
	EnableTriggerGroup("gmdAccept",false)
	DeleteTriggerGroup("gmdFight")
    create_trigger_t('gmdFight1','^(> )*明教教众「啪」的一声倒在地上','','gmdWuDie')
    create_trigger_t('gmdFight2','^(> )*明教教众神志迷糊，脚下一个不稳，倒在地上昏了过去。','kill jiaozhong','')
    create_trigger_t('gmdFight3','^(> )*这里没有这个人。','','gmdCount')
	create_trigger_t('gmdFight4','^(> )*你站在光明顶处，准备迎战光明顶群雄轮战第(\\D*)关','','gmdPrepare')
	create_trigger_t('gmdFight5','突然之间，从明教人群中，有几人手执兵刃来到了你的面前','','gmdKillWushi')
	create_trigger_t('gmdFight6','^(> )*一阵天旋地转，你一阵恍惚，才发现自己退出了副本空间。','','gmdFinish')
	create_trigger_t('gmdFight7','^(> )*'.. job.teamname ..'「啪」的一声倒在地','','gmdDie')
	create_trigger_t('gmdFight8','^(> )*(你一路行来|又不时传来惨叫|光明顶上不时飘来兵刃碰撞|你忽然大吼一声，谁敢来战)','','gmdCheckQuit')
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
	exe('tt 赵敏不在了，换个任务吧！')
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
	exe('tt 队伍中有人条件不符，换个任务吧！')
	return gmdBusy()
end
function gmdFail()
    exe('tt 速度太慢失败了，换个任务吧！')
	return gmdBusy()
end
function gmd()
    if hp.shen>0 then
	    return turnShen('-')
	end
	if gmdNeedDhd() and (not Bag["大还丹"] or Bag["大还丹"].cnt<2) and score.tongbao and score.tongbao>500 then
	    return checkDhd()
	end
    job.name = 'gmd'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
	
	job.killer = {}
	job.killer["明教教众"] = true
	
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
	messageShow('光明顶任务：任务开始。')
	return prepare_lianxi(gmdGo)
end
function gmdGo()
    checkBags()
	return go(gmdPre,"扬州城","偏厅")
end
function gmdPre()
	if (not Bag["大还丹"] or Bag["大还丹"].cnt<2) and score.tongbao and score.tongbao>500 then
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
    if locl.room~="偏厅" then
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
    if not locl.id["赵敏"] then
	    return gmdBusy()
	end
	EnableTriggerGroup("gmdAsk",true)
	exe('ask zhao min about 围攻光明顶')
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
    if locl.room=="偏厅" then
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
	    if string.find(w[4],"顶不住了") then gmdQuit = true end
	    if string.find(w[4],"换个任务") then
            return gmdBusy()		
		end
		if string.find(w[4],"准备就位") then
		    return gmdDyd()
		end
		if string.find(w[4],"赶快出发") then
		    if not road.act==gmdLocGo or locl.room=="偏厅" then
		        return gmdDyd()
			end
		end
		if string.find(w[4],"开始下一层") then
		    return gmdPreNext()
		end
		if string.find(w[4],"冷泉失效时间") and string.find(w[4],"【") and string.find(w[4],"】") then
		    local lqtime = tonumber(string.sub(w[4],string.find(w[4],"【")+2,string.find(w[4],"】")-1))
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
    exe("tt 接到任务了，准备就位！")
	return gmdDyd()
end
function gmdDyd()
    disWait()
	prepare_neili_stop()
    return go(gmdLocGo,"明教","光明顶")
end
function gmdLocGo()
    if locl.room~= "光明顶" then
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
    if not string.find(locl.room,"副本") then
	    tmp.loc = tmp.loc or 0
		tmp.loc = tmp.loc + 1
		if tmp.loc > 60 then
		    exe("tt 等不到你，换个任务了！")
			return gmdBusy()
		else
		    if math.fmod(tmp.loc,2)==0 then
		        exe("tt 怎么还没到，赶快出发！")
			end
		end
	    return checkWait(gmdLocate,3)
	end
	if job.teamlead==score.name then
	    exe('lineup form wuxing-zhen')
        exe('lineup with '..job.teamid)
	end
	messageShow('光明顶任务：进入作战地点。')
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
	    messageShow("光明顶任务：接到队友警报，提前撤退。")
	    return gmdLeave() 
	end
    if condition.poison and condition.poison > 20 then 
	    messageShow("光明顶任务：中毒超过二十秒，准备撤退。")
	    return gmdLeave() 
	end
	if condition.wound and condition.wound > 20 then 
	    messageShow("光明顶任务：受伤超过二十秒，准备撤退。")
	    return gmdLeave() 
    end
	if condition.noexert and condition.noexert > 20 then 
	    messageShow("光明顶任务：闭气超过二十秒，准备撤退。")
	    return gmdLeave() 
	end
	if condition.noperform and condition.noperform > 20 then 
	    messageShow("光明顶任务：封招超过二十秒，准备撤退。")
	    return gmdLeave() 
	end
	if hp.qixue_per<80 or hp.jingxue_per<80 then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("光明顶任务：受伤超过百分之八十，准备撤退。")
	        return gmdLeave() 
		end
	end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("光明顶任务：受伤超过百分之八十，准备撤退。")
	        return gmdLeave() 
		end
	end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 80) then 
	    if Bag["大还丹"] and Bag["大还丹"].cnt > 1 then
		    exe("eat dan")
		else
	        messageShow("光明顶任务：受伤超过百分之八十，准备撤退。")
	        return gmdLeave() 
		end
	end
	if gmdNeedDhd() and not Bag["大还丹"] and not Bag["大还丹(盒)"] and gmdRound and gmdRound > 11 then 
	    messageShow("光明顶任务：大还丹用光了，准备撤退。")
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
            messageShow("光明顶任务：冷泉还差".. tmp.lengquan + math.modf(skills['lengquan-shengong'].lvl/5) - os.time() .."秒失效，等一等。")
    		return checkWait(gmdPreTeam,2)
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
			    messageShow("光明顶任务：".. p .."的冷泉还差".. q - os.time() .."秒失效，等一等。")
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
	messageShow("光明顶任务：已闯过第"..gmdRound.."层，解决了"..gmdWushi.."个明教教众，此次共计划闯过"..gmdRounds.."层。")
	if gmdRound >= gmdRounds then gmdLeave() end
	return gmdStatus()
end
function gmdLeave()
    if gmdRound and gmdRound < 1 then
	    messageShow("光明顶任务：还未闯过第一层，不能走。")
		return check_bei(gmdPreNeili,1)
	end
    if job.teamlead and job.teamlead~=score.name then
	    gmdQuit = true
	    return exe('tt 队长，我已经顶不住了！申请撤退！')
	end
    exe('halt')
	exe('leavefb')
	locate()
	return check_bei(gmdLeaveCheck,1)
end
function gmdCheckQuit()
    if gmdQuit then
        messageShow("光明顶任务：接到队友警报，提前撤退。")	
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
    if string.find(locl.room,"副本") then
	    return check_bei(gmdLeave,1)
	end
	return check_bei(gmdFinish,1)
end
function gmdFinish()
    dis_all()
    messageShow("光明顶任务：此次任务一共闯过"..gmdRound.."层，共解决了"..gmdWushi.."个明教教众。")
	return go(check_heal,"襄阳城","当铺")
end