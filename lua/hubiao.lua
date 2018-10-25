--hubiao
jobSpecial = jobSpecial or {}
jobSpecial["hubiao"] = true 
job.list = job.list or {}
job.list["hubiao"] =function() if canwu and canwu.gift and canwu.gift>1 then return "福州护镖" else return false end end
joblast = joblast or {}
joblast["福州护镖"] = "hubiao"
jobCond = jobCond or {}
jobCond["hubiao"] = function() if job.last~="hubiao" and job.teamname and (not condition["福州镖局护镖倒计时"] or (condition["福州镖局护镖倒计时"] and condition["福州镖局护镖倒计时"]==0) or (condition["任务繁忙状态"] and condition["福州镖局护镖倒计时"] and condition["福州镖局护镖倒计时"]<=condition["任务繁忙状态"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["hubiao"] = "hubiaoTriggerDel"

function hubiaoTrigger()
    DeleteTriggerGroup("hubiaoTeam")
    create_trigger_t('hubiaoTeam1',"^(> )*如果你愿意加入，请用 team with (\\D*)。$",'','hubiaoTeam')
    create_triggerex_lvl('hubiaoTeam2',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：where are you?",'','hubiaoTeamWhere',95)
    create_triggerex_lvl('hubiaoTeam3',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：我已到达【(\\D*)】!",'','hubiaoTeamReply',95)
    create_trigger_t('hubiaoTeam4',"^(> )*"..job.teamname.."决定加入你的队伍。",'','hubiaoTeamMeet')
    create_triggerex_lvl('hubiaoTeam5',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：我已经到达目的地！",'','hubiaoTeamReady',95)
    create_triggerex_lvl('hubiaoTeam6',"^(> )*由于你护镖失败，交给镖局的五十两黄金被用来赔偿了。$",'','hubiaoTeamFail',95)
	create_triggerex_lvl('hubiaoTeam7',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：船来了！",'','hubiaoTeamEnter',95)
    create_triggerex_lvl('hubiaoTeam8',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：hubiao 任务放弃!",'','hubiaoTeamFangqi',95)
	create_triggerex_lvl('hubiaoTeam9',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：我正在(\\D*)独自赶车前往(\\D*)送货给(\\D*)，请尽快赶来！",'','hubiaoTeamHurry',95)
    create_triggerex_lvl('hubiaoTeama',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：(\\D*)换个任务",'','hubiaoQuit',95)
    SetTriggerOption("hubiaoTeam1","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam2","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam3","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam4","group","hubiaoTeam")--：人没到齐，换个任务！
    SetTriggerOption("hubiaoTeam5","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam6","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam7","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam8","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam9","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeama","group","hubiaoTeam")
    DeleteTriggerGroup("hubiaoAsk")
    create_trigger_t('hubiaoAsk1',"^(> )*(你|"..job.teamlead..")向林震南打听有关",'','hubiaoAsk')
    create_trigger_t('hubiaoAsk2',"^(> )*这里没有这个人。$",'','hubiaoNobody')
    SetTriggerOption("hubiaoAsk1","group","hubiaoAsk")
    SetTriggerOption("hubiaoAsk2","group","hubiaoAsk")
    EnableTriggerGroup("hubiaoAsk",false)
    DeleteTriggerGroup("hubiaoAccept")
    create_trigger_t('hubiaoAccept1',"^(> )*林震南说道：「请护送这一笔镖银到(\\D*)的(\\D*)手中。",'','hubiaoWhere')
    create_trigger_t('hubiaoAccept2',"^(> )*林震南说道：「你还是将",'','hubiaoFail')
    create_trigger_t('hubiaoAccept3',"^(> )*林震南说道：「夜间护镖，实在太过危险，我放心不下。",'','hubiaoBusy')
    create_trigger_t('hubiaoAccept4',"^(> )*林震南说道：「你来晚了已经有人接下这支镖了",'','hubiaoBusy')
    create_trigger_t('hubiaoAccept5',"^(> )*林震南说道：「护镖路途危险，你这么少的人，我可不放心。",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept6',"^(> )*林震南说道：「护镖路途危险，单靠人多是没用的。",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept7',"^(> )*林震南说道：「只有队伍首领才能提出接镖。",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept8',"^(> )*林震南说道：「你的队伍出现了问题，请解散并重新组建。",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept9',"^(> )*林震南说道：「嗯？你的队伍里怎么有如此贪婪之人？",'','hubiaoFail')
    create_trigger_t('hubiaoAccept10',"^(> )*林震南说道：「咦？怎么好象人不全啊？",'','hubiaoTeamMiss')
    create_trigger_t('hubiaoAccept11',"^(> )*林震南说道：「护镖是危险的事，我看",'','hubiaoFail')
    create_trigger_t('hubiaoAccept12',"^(> )*林震南说道：「护镖路途危险，我看诸位队伍随意搭配",'','hubiaoFail')
    create_trigger_t('hubiaoAccept13',"^(> )*林震南说道：「现在没有镖需要劳驾",'','hubiaoBusyF')
    create_trigger_t('hubiaoAccept14',"^(> )*林震南说道：「(一直护镖很辛苦的|兄台上次护镖辛苦了)",'','hubiaoBusy')
    SetTriggerOption("hubiaoAccept1","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept2","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept3","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept4","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept5","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept6","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept7","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept8","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept9","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept10","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept11","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept12","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept13","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept14","group","hubiaoAccept")
    EnableTriggerGroup("hubiaoAccept",false)
    DeleteTriggerGroup("hubiaoFight")
    create_trigger_t('hubiaoFight1','^(> )*(\\D*)「啪」的一声倒在地上','','hubiaoJiefeiDie')
    create_trigger_t('hubiaoFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','hubiaoJiefeiFaint')
    create_trigger_t('hubiaoFight3','^(> )*你想攻击谁？','','')
    create_triggerex_lvl('hubiaoFight4','^(> )*看起来(\\D*)想杀死你！$','','hubiaoJiefeiKill',98)
    SetTriggerOption("hubiaoFight1","group","hubiaoFight") 
    SetTriggerOption("hubiaoFight2","group","hubiaoFight")
    SetTriggerOption("hubiaoFight3","group","hubiaoFight")
    SetTriggerOption("hubiaoFight4","group","hubiaoFight")
    EnableTriggerGroup("hubiaoFight",false)
    DeleteTriggerGroup("hubiaoBoat")
    create_trigger_t('hubiaoBoat1','^(> )*艄公(们|)把踏脚板收','','hubiaoBoat')
    create_trigger_t('hubiaoBoat2','^(> )*艄公把踏脚板收起来，说了一声','','hubiaoBoat')
    create_trigger_t('hubiaoBoat3','^(> )*(渡船猛地一震，已经靠岸|艄公说“到啦，上岸吧”)','','hubiaoBoatOut')
    create_trigger_t('hubiaoBoat4','^(> )*说着将一块踏脚板搭上堤岸，形成一个出去','','hubiaoBoatOut')
	create_trigger_t('hubiaoBoat5','^(> )*(一叶扁舟缓缓地驶了过来，艄公将一块踏脚板搭上堤岸，以便乘客上下。|一艘渡船缓缓地驶了过来，艄公将一块踏脚板搭上堤岸，以便乘客上下)','','hubiaoEnter')
    SetTriggerOption("hubiaoBoat1","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat2","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat3","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat4","group","hubiaoBoat")
	SetTriggerOption("hubiaoBoat5","group","hubiaoBoat")
    EnableTriggerGroup("hubiaoBoat",false)
    DeleteTriggerGroup("hubiaoDriver")
    create_trigger_t('hubiaoDriver1','^(> )*你要往哪里去？','','hubiaoTestPass')
    create_trigger_t('hubiaoDriver2','^(> )*劫匪尚未除去，你想往哪里走','','hubiaoTestJiefei')
    create_trigger_t('hubiaoDriver3','^(> )*(你现在正忙，不能指挥镖车前进|你推那么快，想把镖车弄散架吗)','','hubiaoTest')
    create_trigger_t('hubiaoDriver4','^(> )*你现在在船上，没地方可去。','','hubiaoTest')
	create_trigger_t('hubiaoDriver5','^(> )*镖车在(你|'.. job.teamname ..')的护卫下缓缓','','hubiaoTestGo')
    SetTriggerOption("hubiaoDriver1","group","hubiaoDriver") 
    SetTriggerOption("hubiaoDriver2","group","hubiaoDriver")
    SetTriggerOption("hubiaoDriver3","group","hubiaoDriver")
    SetTriggerOption("hubiaoDriver4","group","hubiaoDriver")
	SetTriggerOption("hubiaoDriver5","group","hubiaoDriver")
	EnableTriggerGroup("hubiaoDriver",false)
    DeleteTriggerGroup("hubiaoFinish")
    create_trigger_t('hubiaoFinish1','^(> )*只有队伍首领才能决定护镖是否已经结束。','','hubiaoFinishWait')
    create_trigger_t('hubiaoFinish2','^(> )*劫匪还在，本次任务尚未完成！','','hubiaoJiefei')
    create_trigger_t('hubiaoFinish3','^(> )*你的队员尚未到齐！','','hubiaoFinishWait')
    create_trigger_t('hubiaoFinish4','^(> )*你被奖励了(\\D*)点经验，(\\D*)点潜能，(\\D*)两黄金','','hubiaoFinish')
    SetTriggerOption("hubiaoFinish1","group","hubiaoFinish") 
    SetTriggerOption("hubiaoFinish2","group","hubiaoFinish")
    SetTriggerOption("hubiaoFinish3","group","hubiaoFinish")
    SetTriggerOption("hubiaoFinish4","group","hubiaoFinish")
end

function hubiaoTriggerDel()
    DeleteTriggerGroup("hubiaoTeam")
    DeleteTriggerGroup("hubiaoAsk")
    DeleteTriggerGroup("hubiaoAccept")
    DeleteTriggerGroup("hubiaoFight")
    DeleteTriggerGroup("hubiaoBoat")
    DeleteTriggerGroup("hubiaoDriver")
    DeleteTriggerGroup("hubiaoFinish")
end
function hubiaoNobody()
    EnableTriggerGroup("hubiaoAsk",false)
    return hubiao()
end

function hubiao()
    if not Bag["大还丹"] or Bag["大还丹"].cnt<2 then
	    return checkDhd()
	end
    --job.name = 'hubiao'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
    tmp.hbteamfail = nil
    if not job.teamlead or job.teamlead=="" or job.teamlead==" " then job.teamlead=score.name end
    hubiaoTrigger()
    return prepare_lianxi(hubiaoGo)
end
function hubiaoGo()
    return go(hubiaoPre,"福州城","福威镖局")
end
function hubiaoPre()
    flag.idle = 0
    --if os.time()-job.time.b>1800 then
	if os.time()-job.time.b>300 then
       --job.zuhe["hubiao"]=nil
       return hubiaoChang()
    end
    locate()
    return checkWait(hubiaoWait,3)
end
function hubiaoTeam(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
       exe('team dismiss')
       exe('team with '..job.teamid)
       if locl.room=="福威镖局" then
          dis_all()
          exe('halt')
		  locate()
          return check_bei(hubiaoStart)
		  --return prepare_neili(hubiaoStart)
       end
    end
end
function hubiaoTeamWhere(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)
    if wildcards[2]==job.teamname and not tmp.hblost then 
       exe('tt 我已到达【'.. locl.area .. locl.room ..'】!')
    end
end
function hubiaoTeamReply(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and tmp.hblost then
       DeleteTimer("hubiaoc")
       disWait()
       local l_where=wildcards[4]
       dest.room,dest.area=getAddr(l_where)
       if not dest.room or dest.room==locl.room then
          return checkWait(hubiaoTeamAsk,3)
       end
       if string.find(dest.room,"渡船") then
          return checkWait(hubiaoTeamAsk,3)
       end
       local l_rooms=getRooms(dest.room,dest.area)
       local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
       tmp.sourid=l_dest
       tmphubiaocart=nil
       job.killer={}
       return go(hubiaoConsider,l_dest,l_room)
    end
end
function hubiaoTeamAsk()
    exe('tt where are you?')
end
function hubiaoTeamReady(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and not tmp.hubiaoready then
       if job.area~=locl.area and locl.area ~= "不知道哪里" then
	      tmp.hubiaoready = true
          DeleteTimer("hubiaoc")
          disWait()
          dest.room,dest.area=getAddr(job.where)
	      local l_rooms=getRooms(dest.room,dest.area)
          local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
          tmp.sourid=l_dest
          tmphubiaocart=nil
          job.killer={}
		  tmp.jiefei = nil
          return go(hubiaoConsider,l_dest,l_room)
       end
    end
end

function hubiaoTeamFail()
    tmp.hbteamfail = true
    messageShow('护镖任务：护镖失败！')
	--SetVariable("hubiaofailadd",job.where)
	hubiaoFailadd(job.where)
    return check_heal()
end
function hubiaoTeamMeet()
    if locl.room=="福威镖局" then
       dis_all()
       exe('halt')
       return check_bei(hubiaoStart)
    end
end
function hubiaoWait()
    if locl.area~="福州城" or locl.room~="福威镖局" then
       return hubiaoGo()
    end
    if locl.id[job.teamname] and score.name==job.teamlead then
	   job.teamid = locl.id[job.teamname]
       exe('team dismiss')
       exe('team with '.. job.teamid)
    else
       return prepare_lianxi(hubiaoPre)
    end
end
function hubiaoStart()
    DeleteTrigger("hubiaoTeam4")
    DeleteTrigger("hubiaoTeam5")
    EnableTriggerGroup("hubiaoAsk",true)
	job.name = 'hubiao'
    exe('s')
    locate()
	return check_bei(hubiaoStartLoc,1)
end
function hubiaoStartLoc()
    if locl.room=="福威镖局" then
	    return hubiaoStart()
	end
    if job.teamlead==score.name then
	    if not locl.id[job.teamname] then
		    locate()
			return checkWait(hubiaoStartLoc,2)
		end
        exe('askk lin zhennan about 护镖')
    end
end
function hubiaoAsk()
    EnableTriggerGroup("hubiaoAsk",false)
    EnableTriggerGroup("hubiaoAccept",true)
    EnableTriggerGroup("hubiaoTeam",true)
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
end
function hubiaoBusy()
    EnableTriggerGroup("hubiaoAccept",false)
    --job.last='hubiao'
    return checkJob()
end
function hubiaoBusyF()
    EnableTriggerGroup("hubiaoAccept",false)
    tmp.hbbusy = tmp.hbbusy or 0
    tmp.hbbusy = tmp.hbbusy + 1
    if tmp.hbbusy > 30 then
        tmp.hbbusy = 0
		exe('tt 接不到任务，换个任务！')
        return check_bei(hubiaoChang,1)
    else
        return check_bei(hubiaoStart,1)
    end
end
function hubiaoQuit(n,l,w)
    if w[2]==job.teamname then
        --return check_bei(husongQuit,1)
		return check_bei(hubiaoChang,1)
	end
end
function hubiaoChang()
    condition["福州镖局护镖倒计时"] = 100
	return checkJob()
end
function hubiaoTeamDis()
    EnableTriggerGroup("hubiaoAccept",false)
    EnableTriggerGroup("hubiaoAsk",true)
    exe('team dismiss')
    if job.teamlead==score.name then
       exe('team with '..job.teamid)
    end
    return check_bei(hubiaoStart)    
end
function hubiaoTeamMiss()
    EnableTriggerGroup("hubiaoAccept",false)
	exe('tt 人没到齐，换个任务！')
    return check_bei(hubiaoChang,1)
end
function hubiaoFail()
    EnableTriggerGroup("hubiaoAccept",false)
    job.last='hubiao'
    job.zuhe["hubiao"]=nil
    return check_job()    
end
function hubiaoTeamFangqi(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname then
	   return hubiaoFangqi()
	end
end
function hubiaoTeamHurry(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname then
	   if tmp.pre then
	      tmp.pre = nil
	   else
	      local l_where=wildcards[4]
          dest.room,dest.area=getAddr(l_where)
	      job.where = wildcards[5]
		  job.target = wildcards[6]
			 
		  if locl.area~="不知道哪里" and dest.area~="不知道哪里" and locl.area~=dest.area then
             DeleteTimer("hubiaoc")
             disWait()
             tmp.hblost = true
             if not dest.room or dest.room==locl.room then
                return checkWait(hubiaoTeamAsk,3)
             end
             if string.find(dest.room,"渡船") then
                return checkWait(hubiaoTeamAsk,3)
             end
             local l_rooms=getRooms(dest.room,dest.area)
             local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
             tmp.sourid=l_dest
             tmphubiaocart=nil
             job.killer={}
             return go(hubiaoConsider,l_dest)
		  end
	   end
	end
end
function hubiaoFangqi()
    dis_all()
    messageShow('护镖任务：任务地点【'..job.where..'】不可到达，任务放弃。')
	--SetVariable("hubiaoerradd",job.where)
	hubiaoErradd(job.where)
	exe('driver north')
	messageShow('护镖任务：hubiao 任务放弃!')
    return go(check_heal,'柳宗镇','药房')
end
function hubiaoErradd(p_where)
    if isNil(p_where) then return end
    local hubiaoerradd = GetVariable("hubiaoerradd")
	if not isNil(hubiaoerradd) then
	    hubiaoerradd = hubiaoerradd .."|"..p_where	
	else
	    hubiaoerradd = p_where
	end
	SetVariable("hubiaoerradd",hubiaoerradd)
end
function hubiaoFailadd(p_where)
    if isNil(p_where) then return end
    local hubiaofailadd = GetVariable("hubiaofailadd")
	if not isNil(hubiaofailadd) then
	    hubiaofailadd = hubiaofailadd .."|"..p_where	
	else
	    hubiaofailadd = p_where
	end
	SetVariable("hubiaofailadd",hubiaofailadd)
end 
function hubiaoWhere(n,l,w)
    EnableTriggerGroup("hubiaoAccept",false)
	EnableTriggerGroup("hubiaoDriver",false)
    job.time.b = os.time()
    job.last='hubiao'
    job.killer={}
	job.drive={}
	tmp.move = 0
    job.where=Trim(w[2])
    job.target=Trim(w[3])
    job.room,job.area=getAddr(job.where)
    hubiaoLocate()
    return checkNext(hubiaoConsider)
end
local hubiaoIgnores = {
	["华山松树林"] = true,
	["襄阳郊外树林"] = true,
	["武当山院门"] = true,
	--["武当山小径"] = true,
	["武当山后山小院"] = true,
	["摩天崖"] = true,
}
function hubiaoConsider()
    EnableTriggerGroup("hubiaoFight",true)
	EnableTriggerGroup("hubiaoDriver",false)
	DeleteTimer("hubiaoc")
    dest.room=job.room
    dest.area=job.area
    flag.times=1
	sour.id = nil
    if tmp.sourid then
       sour.id=tmp.sourid
       tmp.sourid=nil
    end
    dest.id = nil
    if hubiaoIgnores[dest.area] or hubiaoIgnores[job.where] or not job.room or not path_cal() then
       return hubiaoFangqi()
    end
    messageShow('护镖任务：从【'.. locl.area .. locl.room ..'】前往【'..job.where..'】！')
	--job.drive = utils.split(path_cal(),';')
	local l_drive = path_cal()
	local l_sour = road.id
	local l_rooms = {}
	for p,q in pairs(dest.rooms) do
	    if q ~= l_sour then
	       table.insert(l_rooms,q)
	    end
	end
	--printTab(dest.rooms)
	while countTab(l_rooms)>0 do
	      printTab(l_rooms)
	      local l_dest,l_distance=getNearRoom(l_sour,l_rooms)
		  --messageShow(l_sour,l_dest)
		  if l_dest then
		     local l_path = path_cal_get(l_sour,l_dest)
			 if l_path and type(l_path)=="string" then
			    l_drive = l_drive .. ';' .. l_path
			    l_sour = l_dest
			    l_rooms = delElement(l_rooms,l_dest)
			 else
                return hubiaoFangqi()
			 end
		  else
		     l_rooms = {}
             return hubiaoFangqi()
          end			 
	end
	job.drive = utils.split(l_drive,';')
	messageShow('护镖任务：路径已准备好!')
	local hubiaoFunc = {
	      ["#duHhe"] = true,
		  ["#duCjiang"] = true,
	--	  ["#wipe"] = true,
		  ["#walkBusy"] = true,
		  ["#weaponWWalk"] = true,
		  ["#weaponUnWalk"] = true,
	}
	local hubiaoExit = {
	      ["e"] = true,
		  ["w"] = true,
		  ["s"] = true,
		  ["n"] = true,
		  ["up"] = true,
		  ["down"] = true,
	      ["east"]  = true,
		  ["west"]  = true,
		  ["south"] = true,
		  ["north"] = true,
	}
	local l_func = true
	for p,q in pairs(job.drive) do
	    if string.find(q,"#") and not hubiaoFunc[q] and not string.find(q,"#wipe") then
		   --messageShow(q)
		   l_func = nil
		end
		if string.find(q,"jump") or string.find(q,"tiao") then
		   --messageShow(q)
		   l_func = nil
		end
	end
	
	if not l_func then
       return hubiaoFangqi()
	end
	
    fight_prepare()
    return check_bei(hubiaoDir,1) 
end
function hubiaoDir()
    EnableTriggerGroup("hubiaoTeam",true)
    EnableTriggerGroup("hubiaoBoat",true)
    EnableTriggerGroup("hubiaoFight",true)
    EnableTriggerGroup("hubiaoFinish",true)
	DeleteTimer("jiefei")

    if not job.drive or table.getn(job.drive)==0 then
	   hubiaoLocate()
       return check_busy(hubiaoRoom)
    end
    job.dir=job.drive[1]
    if job.dir=='halt' or isNil(job.dir) then
       table.remove(job.drive,1)
       return hubiaoDir()
    end
    if job.dir=="#duHhe" or job.dir=="#duCjiang" or job.dir=="dujiang" then
       table.remove(job.drive,1)
       table.insert(job.drive,1,"out")
       table.insert(job.drive,1,"enter")
       return hubiaoDir()
    end

    --messageShow('距离目的地'.. job.where .. '还有'.. countTab(job.drive) ..'步!')

    local l_cnt
    if countTab(job.drive) > 10 then
	   l_cnt = 10
    else
	   l_cnt = countTab(job.drive)
    end
	--for i=1,l_cnt do
	--    messageShow('第 '..i..' 步为:'..job.drive[i])
	--end

	tmp.enter = nil
	tmp.pre = nil
	
	cntrH = countR(20)
	
    return hubiaoDrive()
end
faintFunc = faintFunc or {}
faintFunc["hubiao"] = "hubiaoDrive"
function hubiaoDrive()

    local dukou = {
      ["陕晋渡口"] = true,
	  ["西夏渡口"] = true,
	  ["澜沧江边"] = true,
	  ["大渡口"] = true,
	  ["长江南岸"] = true,
	  ["汉水东岸"] = true,
    }

    if tmp.jiefei then return hubiaoJieFeiStop() end

    if locl.room==job.room and locl.id[job.target] then
       hubiaoLocate()
       return check_busy(hubiaoRoom)
    end
    if table.getn(job.drive)==0 then
       hubiaoLocate()
       return check_busy(hubiaoRoom)
    end

    if string.find(job.dir,"#wipe") then
       local l_wipe = del_string(job.dir,"#wipe ")
       return wipe(l_wipe,hubiaoNext)
    end
    if string.find(job.dir,"open") or string.find(job.dir,"pull") or string.find(job.dir,"knock") then
       tmp.dir = job.dir
       exe(job.dir)
       return check_bei(hubiaoNext,1)
    end
    if string.find(job.dir,"#walkBusy") then
       return check_bei(hubiaoNext,1)
    end
    if string.find(job.dir,"#weaponWWalk") then
       weapon_wield()
       return hubiaoNext()
    end
    if string.find(job.dir,"#weaponUnWalk") then
       weapon_unwield()
       return hubiaoNext()
    end

	if dukou[locl.room] and job.dir=="enter" and not tmp.enter then
	   EnableTriggerGroup("hubiaoBoat",true)
	   if locl.id[job.teamname] then
	      exe('yell boat')
	   end
	   if not tmphubiaocart then
	      tmp.enter=true
	   end
	   hubiaoLocate()
       return checkWait(hubiaoDrive,2)
	end
	
    if string.find(locl.room,"渡船") then
	   tmp.enter = nil
	end

    if string.find(locl.room,"渡船") and job.dir=="enter" then
       EnableTriggerGroup("hubiaoBoat",true)
       table.remove(job.drive,1)
       return hubiaoDir()
    end
	
    if string.find(locl.room,"渡船") and not tmp.hbboat then
       EnableTriggerGroup("hubiaoBoat",true)
	   if not locl.exit["out"] then
	      tmp.hbboat = true
       end	   
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if string.find(locl.room,"渡船") and job.dir=="out" and not locl.exit[job.dir] then
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if tmphubiaocart then
	   if cntrH()>0 and not locl.id[job.teamname] and not dukou[locl.room] and not string.find(locl.room,"渡船") then
	      hubiaoLocate()
          return checkWait(hubiaoDrive,3)
	   end
	   if not locl.id[job.teamname] then
	      exe('tt 我正在'..locl.where..'独自赶车前往'..job.where..'送货给'..job.target..'，请尽快赶来！')
	   end
       tmp.move = 0
       EnableTriggerGroup("hubiaoDriver",false)
       tmp.hblost = nil
       exe('driver '.. job.dir)
       hubiaoLocate()
       return check_bei(hubiaoDrive,1)
    else
       tmp.move = tmp.move or 0
	   tmp.move = tmp.move + 1
       if tmp.move > 20 then
          tmp.move = 0
          tmp.hblost = true
	      messageShow('护镖任务：在【'.. locl.area .. locl.room ..'】丢失镖车！')
          hubiaoTeamAsk()
	  --return checkWait(hubiaoRconsider,30)
       end
    end
    hubiaoLocate()
    return check_busy(hubiaoConfirm,1)
end
function hubiaoConfirm()
    local dukou = {
          ["陕晋渡口"] = true,
	  ["西夏渡口"] = true,
	  ["澜沧江边"] = true,
	  ["大渡口"] = true,
	  ["长江南岸"] = true,
	  ["汉水东岸"] = true,
    }

    if tmp.jiefei then return hubiaoJieFeiStop() end

    if dukou[locl.room] then
       exe('yell boat')
    end
	
    if string.find(locl.room,"渡船") and job.dir=="out" and not locl.exit[job.dir] then
       tmp.move = 0
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if tmphubiaocart and dukou[locl.room] and job.dir=="enter" then
       return checkWait(hubiaoDrive,1)
    end
	
    if tmphubiaocart and not locl.id[job.target] and not string.find(locl.room,"渡船") then
       tmp.hbcnt = tmp.hbcnt or 0
       tmp.hbcnt = tmp.hbcnt + 1
       messageShow('护镖任务：原地推车第'.. tmp.hbcnt ..'次!')
       if tmp.hbcnt>20 then
          tmp.hbcnt = 0
	      messageShow('护镖任务：在【'.. locl.area .. locl.room ..'】发现线路错误，重新计算线路！')
          return hubiaoConsider()
       end
       return checkWait(hubiaoDrive,2)
    end
    return hubiaoPrepare()
end
function hubiaoLocate()
    EnableTriggerGroup("hubiaoDriver",true)
    tmphubiaocart=nil
    locate()
    exe('driver test')
end
function hubiaoTest()
    tmphubiaocart=true
end
function hubiaoTestPass()
    tmphubiaocart=true
    job.killer={}
end
function hubiaoTestGo()
    local dukou = {
      ["陕晋渡口"] = true,
	  ["西夏渡口"] = true,
	  ["澜沧江边"] = true,
	  ["大渡口"] = true,
	  ["长江南岸"] = true,
	  ["汉水东岸"] = true,
    }

    if not dukou[locl.room] then
       return hubiaoJiefeiOver()
    end

end
function hubiaoTestJiefei()
    tmphubiaocart=true
    for i=1,3 do
        exe('kill jie fei '..i)
    end
end
function hubiaoJieFeiStop()
    for p in pairs(job.killer) do
	    --messageShow('拦路劫匪: '..p)
	end
end
function hubiaoPrepare()
    if tmp.jiefei then return hubiaoJieFeiStop() end
	
	tmp.pre = true
	
    local dukou = {
        ["陕晋渡口"] = true,
	    ["西夏渡口"] = true,
	    ["澜沧江边"] = true,
	    ["大渡口"] = true,
	    ["长江南岸"] = true,
	    ["汉水东岸"] = true,
    }
    if dukou[locl.room] then
       return check_bei(hubiaoMove)
    end
    if perform.force and skills[perform.force] then
       exe('jifa force '.. perform.force)
    end
    exe('yun qi;yun jing;yun jingli;hp')
    if (hp.qixue_per<80 or hp.jingxue_per<80 or hp.neili<3000) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
       exe('eat dan;hp')
       checkBags()
       return check_bei(hubiaoPrepare)
    end
    if hp.qixue_per<90 and not (Bag["大还丹"] or Bag["大还丹(盒)"]) then
       exe('yun heal')
       return check_bei(hubiaoPrepare)
    end
    if hp.neili<hp.neili_max*1.2 then
        --return prepare_neili(hubiaoPrepare,1.3)
		return prepare_neili(hubiaoMove,1.3)
    end
	
	fightSkillPrepare()
	
    return check_busy(hubiaoMove,1)
end
function hubiaoMove()
    if tmp.jiefei then return hubiaoJieFeiStop() end

	tmp.pre = nil
	
    local dukou = {
        ["陕晋渡口"] = true,
	    ["西夏渡口"] = true,
	    ["澜沧江边"] = true,
	    ["大渡口"] = true,
	    ["长江南岸"] = true,
	    ["汉水东岸"] = true,
    }

    if dukou[locl.room] then
       exe('yell boat')
    end
    --messageShow('前进方向: '.. job.dir)
    if tmp.dir then
       exe(tmp.dir)
       tmp.dir = nil
    end
    exe(job.dir)
    
    hubiaoLocate()
	if locl.area == "嵩山少林" then
       checkWield()
	end
    return checkNext(hubiaoNext)
end
function hubiaoNext()
    local dukou = {
      ["陕晋渡口"] = true,
	  ["西夏渡口"] = true,
	  ["澜沧江边"] = true,
	  ["大渡口"] = true,
	  ["长江南岸"] = true,
	  ["汉水东岸"] = true,
    }

    if tmp.hbboat and not string.find(locl.room,"渡船") then tmp.hbboat=nil end
    --tmphubiaocart=nil
    --job.killer={}
    tmp.hbcnt=0

    if dukou[locl.room] and job.dir=="enter" then
       hubiaoLocate()
       return checkWait(hubiaoDrive,1)
    end
	
    --messageShow('移除路径: '.. job.dir)
    table.remove(job.drive,1)
    hubiaoLocate()

    if tmp.jiefei then return hubiaoJieFeiStop() end

    return check_bei(hubiaoDir,1)
end
function hubiaoJiefeiKill(n,l,w)
    exe('set wimpy 100')
    if not job.killer[w[2]] and not dangerousNpc[w[2]] then
       job.killer[w[2]]="jie fei"
       messageShow('护镖任务：在【' ..locl.area ..locl.room.. '】遭遇劫匪:' ..w[2])
       tmp.jiefei = true
       flag.idle = 0
       if countTab(job.killer)>1 then
          if job.teamlead==score.name then
	     --killPfm('jie fei 2')
	     exe('kill jie fei 2')
	     exe('kill jie fei 1')
	  else
	     --killPfm('jie fei 1')
	     exe('kill jie fei 1')
	     exe('kill jie fei 2')
	  end
       end
    end 
    --if locl.id[w[2]] then
    --   job.killer[w[2]]=locl.id[w[2]]
    --   killPfm(job.killer[w[2]])
    --end
    --hubiaoLocate()
    --return check_busy(hubiaoDrive,1)
	create_timer_s('jiefei',15,'hubiaoJiefeiLocate')
end
function hubiaoJiefeiFaint(n,l,w)
    if job.killer[w[2]] and locl.id[w[2]] then
       exe('kill '.. locl.id[w[2]])
       --job.killer[w[2]]="faint"
    end    
end
function hubiaoJiefeiDie(n,l,w)
    hubiaoJieFeiStop()
    if job.killer[w[2]] then
	   messageShow('护镖任务：'..w[2]..'死了！')
       job.killer[w[2]] = nil
       if countTab(job.killer)==0 then
          tmp.jiefei = nil
	      messageShow('护镖任务：在【' ..locl.area ..locl.room.. '】搞定一波劫匪！此时距离目的地'.. job.where .. '还有'.. countTab(job.drive) ..'步!')
          return hubiaoJiefeiOver()
       end
    end	   
end
function hubiaoJiefeiLocate()
    locate()
	return checkNext(hubiaoJiefeiCheck)
end
function hubiaoJiefeiCheck()
    local l_flag = true
	for p in pairs(job.killer) do
	    if locl.id[p] then l_flag = false end
	end
	if l_flag then
	   return hubiaoJiefeiOver()
	end
end
function hubiaoJiefeiOver()
    EnableTimer("jiefei",false)
    DeleteTimer("jiefei")
    --hubiaoLocate()
    --return check_busy(hubiaoDir,1)
	disWait()
	checkWield()
    return check_bei(hubiaoDir)

end
function hubiaoBoat()
    if string.find(locl.room,"渡船") then
       tmp.hbboat=true
	end
end
function hubiaoEnter()
    local dukou = {
      ["陕晋渡口"] = true,
	  ["西夏渡口"] = true,
	  ["澜沧江边"] = true,
	  ["大渡口"] = true,
	  ["长江南岸"] = true,
	  ["汉水东岸"] = true,
    }
	
    if dukou[locl.room] and job.dir=="enter" and not tmp.jiefei then
	   if locl.id[job.teamname] then
	      exe('tt 船来了！')
		  tmp.enter=true
	   end
	   if not tmphubiaocart then
	      tmp.enter=true
	   end
	end
end
function hubiaoBoatOut()
    EnableTriggerGroup("hubiaoBoat",false)
    disWait()
    return check_bei(hubiaoDrive)
end
function hubiaoTeamEnter(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and not tmp.enter then
	   local dukou = {
          ["陕晋渡口"] = true,
	      ["西夏渡口"] = true,
	      ["澜沧江边"] = true,
	      ["大渡口"] = true,
	      ["长江南岸"] = true,
	      ["汉水东岸"] = true,
       }
       if dukou[locl.room] then
          tmp.enter = true
	   end
	end
end
function hubiaoRoom()
    hubiaoTrigger()
    if tmp.jiefei then return hubiaoJieFeiStop() end
    if locl.room==job.room and locl.id["镖车"] and tmphubiaocart and locl.id[job.target] then
       EnableTriggerGroup("hubiaoFinish",true)
       exe("finish")
       tmp.hubiaoready = true
       exe('tt 我已经到达目的地！')
    else
       if locl.room==job.room and locl.id[job.target] then
          if not tmp.hbfail or tmp.hbfail>3 then
	         tmp.hbfail = 0
	      end
	      tmp.hbfail = tmp.hbfail + 1
	      if tmp.hbfail>2 then 
	         tmp.hbfail = nil
	         messageShow('护镖任务：多次丢失镖车，护镖失败！')
	         return hubiaoFangqi()
	      end
       end
       hubiaoLocate()
       tmp.hblost = true
       messageShow('护镖任务：在【'.. locl.area .. locl.room ..'】丢失镖车，准备从头开始！')
       hubiaoTeamAsk()
       return checkWait(hubiaoRconsider,40)
    end
end
function hubiaoRconsider()
    EnableTimer("hubiaoc",false)
    if tmp.hbteamfail then
       messageShow('护镖任务：在【'.. locl.area .. locl.room ..'】丢失镖车，护镖失败！')
	   return hubiaoFangqi()
    end
    return go(hubiaoConsider,"福州城","镖局正厅")
end
function hubiaoFinish(n,l,w)
    EnableTriggerGroup("hubiaoFinish",false)
    messageShow('护镖任务：成功抵达【'..job.where..'】,奖励经验:【'..w[2]..'】点，潜能:【'..w[3]..'】点，黄金:【'..w[4]..'】两！')
    tmp.hubiaoready = nil
    return check_heal()
end
function hubiaoFinishWait()
    if job.teamlead==score.name then
       return checkWait(hubiaoRoom,3)
    end
end