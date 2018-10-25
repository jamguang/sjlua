--只听端木宙向远处大喝一声：“狗贼，鬼鬼祟祟跟到这里，还不出来受死！”喊声中气十足。
--天地会任务

job.list = job.list or {}
job.list["tdh"] = "天地会"
joblast = joblast or {}
joblast["天地会"]   = "tdh"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["tdh"] = "tdh_triggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["tdh"] = "tdhFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["tdh"] = "tdhFindFail"
faintFunc = faintFunc or {}
faintFunc["tdh"] = "tdh_fangqi_go"

local tdhRouter = {
    ["扬州城中央广场"] = "city/guangchang",
	["大理城城中心"]   = "dali/dalics",
	["襄阳城世德堂"]   = "xiangyang/wen/shidetang",
	["苏州城宝带桥"]   = "suzhou/baodaiqiao",
	["宁波城阿育王寺"] = "ningbo/aywsi",
	["恒山云阁虹桥"]   = "hengshan/yunge",
	["塘沽城中心广场"] = "tanggu/center",
	["大雪山赞普广场"] = "xueshan/zanpugc",
}

--天地会
function tdh_trigger()
    DeleteTriggerGroup("tdh_find")
    DeleteTriggerGroup("tdh_ask")
    create_trigger_t('tdh_ask1',"^(> )*你向李式开打听有关",'','tdh_ask')
    create_trigger_t('tdh_ask2',"^(> )*这里没有这个人。$",'','tdh_nobody')
    SetTriggerOption("tdh_ask1","group","tdh_ask")
    SetTriggerOption("tdh_ask2","group","tdh_ask")
    EnableTriggerGroup("tdh_ask",false)
    DeleteTriggerGroup("tdh_accept")
    create_trigger_t('tdh_accept1',"^(> )*李式开在你的耳边悄声说道：速去",'','tdh_fangqi')
    create_trigger_t('tdh_accept2',"^(> )*李式开说道：「既然你做不了，也就算了。」",'','tdh_shibai')
	create_trigger_t('tdh_accept3',"^(> )*李式开对你说道：你又没领过任务，放弃什么",'','tdh_busy')
    create_trigger_t('tdh_accept4',"^(> )*李式开说道：「暂时没有事情需要做，以后再说吧。」",'','tdh_busy')
	create_trigger_t('tdh_accept5',"^(> )*李式开说道：「听说陈总舵主有事找你，你还是先去找总舵主询问吧。」",'','tdh_quest')
    create_trigger_t('tdh_accept6',"^(> )*李式开在你的耳边悄声说道：他的名字叫(\\D*)，你路上小心。",'','tdh_consider')
    create_trigger_t('tdh_accept7',"^(> )*李式开在你的耳边悄声说道：你马上去(\\D*)联络一个会里的兄弟。",'','tdh_where')
	create_trigger_t('tdh_accept8',"^(> )*李式开白了你一眼，说：你无聊不无聊啊？",'','tdh_join')
	create_trigger_t('tdh_accept9',"^(> )*李式开说道：「你还在做任务呢！",'','tdh_shibai')
    SetTriggerOption("tdh_accept1","group","tdh_accept")
    SetTriggerOption("tdh_accept2","group","tdh_accept")
    SetTriggerOption("tdh_accept3","group","tdh_accept")
    SetTriggerOption("tdh_accept4","group","tdh_accept")
    SetTriggerOption("tdh_accept5","group","tdh_accept")
	SetTriggerOption("tdh_accept6","group","tdh_accept")
	SetTriggerOption("tdh_accept7","group","tdh_accept")
	SetTriggerOption("tdh_accept8","group","tdh_accept")
	SetTriggerOption("tdh_accept9","group","tdh_accept")
    EnableTriggerGroup("tdh_accept",false)
end
function tdh_triggerDel()
    DeleteTriggerGroup("tdh_find")
    DeleteTriggerGroup("tdh_ask")
	DeleteTriggerGroup("tdh_cask")
    DeleteTriggerGroup("tdh_accept")
    DeleteTriggerGroup("tdh_fight")
	DeleteTriggerGroup("tdh_finish")
	DeleteTriggerGroup("tdhId")
end

function tdh()
    tdh_trigger()
    job.name='tdh'
    job.time.b=os.time()
    job.flag()
    job.target='任务目标'
	tmp.router = nil
    return prepare_lianxi(tdh_start)
end

function tdhFindAgain()
    EnableTriggerGroup("tdh_find",false)
    return go(tdh_find_act,dest.area,dest.room)
end
function tdhFindFail()
    EnableTriggerGroup("tdh_find",false)
    return check_bei(tdh_fangqi_go)
end
function tdh_start()
    return go(job_tdh,'扬州城','小金山')
end
function job_tdh()
    DeleteTriggerGroup("check_job")
    EnableTriggerGroup("tdh_ask",true)
    exe('ask li shikai about job')
    messageShow('天地会任务：任务开始。')
end
function tdh_ask()
    EnableTriggerGroup("tdh_ask",false)
    EnableTriggerGroup("tdh_accept",true)
end
function tdh_nobody()
    EnableTriggerGroup("tdh_ask",false)
    return tdh_start()
end
function tdh_busy()
    EnableTriggerGroup("tdh_accept",false)
	--job.last = "tdh"
    return check_heal()
end
function tdh_quest()
    EnableTriggerGroup("tdh_accept",false)
    return questnxsz()
end
function tdh_fangqi_go()
    return go(tdh_fangqi,'扬州城','小金山')
end
function tdh_fangqi()
    EnableTriggerGroup("tdh_accept",false)
    return check_bei(tdh_fangqi_ask)
end
function tdh_fangqi_ask()
    EnableTriggerGroup("tdh_ask",true)
    exe('ask li shikai about 放弃')
end
function tdh_shibai()
    EnableTriggerGroup("tdh_accept",false)
	for p in pairs(job.zuhe) do
	    if p~="tdh" and p~=job.last then
		    return _G[p]()
		end
	end
end
function tdh_join()
    EnableTriggerGroup("tdh_accept",false)
    return check_bei(tdh_join_ask1)
end
function tdh_join_ask1()
    exe('ask li shikai about 万云龙')
	return check_bei(tdh_join_ask2)
end
function tdh_join_ask2()
    exe('ask li shikai about 天地会')
	return check_bei(tdh_join_ask3)
end
function tdh_join_ask3()
    exe('ask li shikai about 反清复明')
	return check_bei(job_tdh)
end
function tdh_where(n,l,w)
    job.where=Trim(w[2])
end
function tdh_consider(n,l,w)
    EnableTriggerGroup("tdh_accept",false)
	job.target=Trim(w[2])
	job.target2="未定"
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    --job.last = "tdh"
	tmp.tdh = 1
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       messageShow('天地会任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(tdh_fangqi)
    end
	messageShow('天地会任务：开始前往【'..job.where..'】，寻找革命同志！')
    return check_bei(tdh_find)   
end
function tdh_find()
    DeleteTriggerGroup("tdh_find")
    create_trigger_t('tdh_find1','^( )*(\\D*)'..job.target..'\\((\\D*)\\)','','tdh_comrade')
	create_trigger_t('tdh_find2','^( )*(\\D*)'..job.target2..'\\((\\D*)\\)','','tdhProtect')
	create_trigger_t('tdh_find3','^( )*(\\D*)'..job.target..'\\((\\D*)\\)','','tdhStop')
    SetTriggerOption("tdh_find1","group","tdh_find")
	SetTriggerOption("tdh_find2","group","tdh_find")
	SetTriggerOption("tdh_find3","group","tdh_find")
    EnableTriggerGroup("tdh_find",false)
    flag.times=1
    return check_bei(tdh_find_go)
end
function tdh_find_go()
    return go(tdh_find_act,job.area,job.room)   
end
function tdh_find_act()
    EnableTriggerGroup("tdh_find",true)
	if tmp.tdh then
	   if tmp.tdh == 1 then
	      EnableTrigger("tdh_find2",false)
		  EnableTrigger("tdh_find3",false)
	   end
	   if tmp.tdh == 2 then
	      EnableTrigger("tdh_find1",false)
		  EnableTrigger("tdh_find3",false)
	   end
	   if tmp.tdh == 3 then
	      EnableTrigger("tdh_find1",false)
		  EnableTrigger("tdh_find2",false)
	   end
	end
    job.flag()
    exe('look')
	messageShow('天地会任务：开始寻找【'..dest.area .. dest.room ..'】的革命同志！')
    return find()
end
function tdh_comrade(n,l,w)
    --EnableTriggerGroup("tdh_find",false)
	dis_all()
	flag.find=1
    job.id=string.lower(w[3])
	return check_bei(tdh_comrade_ff,1)
end
function tdh_comrade_ff()
	exe('ask '.. job.id ..' about 反清复明')
	return checkWait(tdh_comrade_ask,3)
end
function tdh_comrade_ask()
    DeleteTriggerGroup("tdh_cask")
    create_trigger_t('tdh_cask1','^( )*'..job.target..'说道：「在(\\D*)有一位叫做(\\D*)的兄弟，他想加入我们天地会。」','','tdhConsider')
	create_trigger_t('tdh_cask2','^( )*'..job.target..'白了你一眼，说：你无聊不无聊啊？','','tdh_qiekou')
    SetTriggerOption("tdh_cask1","group","tdh_cask")
	SetTriggerOption("tdh_cask2","group","tdh_cask")
    exe('ask '.. job.id ..' about 切口')
	locate()
	return check_bei(tdh_qiekou,1)
end
function tdh_qiekou()
    if not locl.id [job.target] then
	   return check_bei(tdh_find)
	end
    exe('qiekou')
end
function tdhConsider(n,l,w)
    EnableTriggerGroup("tdh_cask",false)
	job.where2=Trim(w[2])
	job.target2=Trim(w[3])
	job.room,job.area=getAddr(job.where2)
    dest.room=job.room
    dest.area=job.area
	tmp.tdh = 2
	if WhereIgnores[job.where2] or not job.room or not path_cal() then
       messageShow('天地会任务：任务地点【'..job.where2..'】不可到达，任务放弃。')
       return check_bei(tdh_fangqi_go)
    end
	messageShow('天地会任务：开始前往【'..job.where2..'】，寻找革命同志！')
    return check_bei(tdh_find) 
end
function tdhProtect(n,l,w)
    --EnableTriggerGroup("tdh_find",false)
	dis_all()
	flag.find=1
    job.id2=string.lower(w[3])
	exe('ask '.. job.id2 ..' about 天地会')
	locate()
	return check_busy(tdhProtectAsk,1)
end
function tdhProtectAsk() 
    if not locl.id [job.target2] then
	   return check_bei(tdh_find)
	end
    DeleteTriggerGroup("tdh_fight")
    create_trigger_t('tdh_fight1','^(> )*(\\D*)(转眼间走的无影无踪。|「啪」的一声倒在地上，挣扎着抽动了几下就死了。)','','tdhDie')
	create_trigger_t('tdh_fight2','^(> )*(\\D*)怒道：“官府缉拿钦犯，闲杂人等闪开！”说罢便与'.. job.target2 ..'战在了一起。','','tdhProtectId')
	create_trigger_t('tdh_fight3','^(> )*(\\D*)叫道：“缉拿钦犯，闲杂人等闪开！”说罢便与你战在了一起。','','tdhProtectId')
	create_trigger_t('tdh_fight4','^(> )*这里不准战斗。','','tdhNofight')
    SetTriggerOption("tdh_fight1","group","tdh_fight")
	SetTriggerOption("tdh_fight2","group","tdh_fight")
	SetTriggerOption("tdh_fight3","group","tdh_fight")
	SetTriggerOption("tdh_fight4","group","tdh_fight")
	fight_prepare()
    exe('ask '.. job.id2 ..' about 反清复明')
end
function tdhProtectId(n,l,w)
    dis_all()
	EnableTriggerGroup("tdh_fight",true)
    tmp.kill = tmp.kill or 0
	tmp.kill = tmp.kill + 1
    job.killer[w[2]] = true
    DeleteTriggerGroup("tdhId")
    create_trigger_t('tdhId1','^( )*(\\D*)'.. w[2] ..'\\((\\D*)\\)','','tdhId')
    SetTriggerOption("tdhId1","group","tdhId")
	exe('look')
	exe('set wimpy 100')
end
function tdhId(n,l,w)
    EnableTriggerGroup("tdhId",false)
	for p in pairs(job.killer) do
	    job.killer[p] = string.lower(w[3])
	end
	exe('kill '.. string.lower(w[3]))
end
function tdhDie(n,l,w)
    if job.killer[w[2]] then
	   job.killer[w[2]] = nil
	   locate()
	   exe('hp')
	   return checkNext(tdhPrepare)
	end
end
function tdhNofight()
    --if job.killer[w[2]] then
	--   job.killer[w[2]] = nil
	   locate()
	   exe('hp')
	   return checkNext(tdhPrepare)
	--end
end
function tdhPrepare()
    --EnableTriggerGroup("tdh_fight",false)
	
	if hp.neili < hp.neili_max then
	   return prepare_neili(tdhPrepare)
	end
	if tmp.kill and tmp.kill > 6 then
	   return tdhBack()
	end
	   
	--return check_busy(tdhMove)
	return check_busy(tdhRouterCheck)
end
function tdhRouterCheck()
    exe('yun qi;yun jing;yun jingli')
	fight_prepare()
	if not tmp.router or not tdhRouter[tmp.router] then
	    local l_from = getRooms(locl.room,locl.area)[1]
		--messageShow(l_from)
		local l_p,l_dis = map:lookPath(l_from)
		local l_min
		for k,v in pairs(tdhRouter) do
		    if l_dis[v] and (not l_min or l_dis[v]<l_min) then			   
			   l_min = l_dis[v]
			   tmp.router = k
			   --messageShow(k .. "--" .. l_min)
			end
		end
		if not l_min then tmp.router = "扬州城中央广场" end
	end
	if not tdhRouter[locl.area .. locl.room] then
	    return go(tdhMove,tdhRouter[tmp.router])
	end
	return tdhMove()
end
function tdhMove()
    local movestep = {
                    ["扬州城中央广场"] = "west;east",
                	["大理城城中心"]   = "west;east",
                	["襄阳城世德堂"]   = "south;north",
                	["苏州城宝带桥"]   = "south;north",
                	["宁波城阿育王寺"] = "northwest;southeast",
                	["恒山云阁虹桥"]   = "east;west",
                	["塘沽城中心广场"] = "south;north",
                	["大雪山赞普广场"] = "east;west",
                }
    exe('yun qi;yun jing;yun jingli')
	
	local l_cmd = movestep[locl.area .. locl.room]
	if l_cmd then
	    exe(l_cmd)
	    exe(l_cmd)
	    exe(l_cmd)
	    exe(l_cmd)
	    exe(l_cmd)
	else
	    exe(locl.dir)
	end
					   
	locate()
	exe('hp')
	return checkNext(tdhPrepare)
end
function tdhWait()
    tmp.tcnt = tmp.tcnt or 1
	tmp.tcnt = tmp.tcnt + 1
	if tmp.tcnt > 6 then
	   return tdhBack()
	end
	locate()
	exe('hp')
	return checkNext(tdhMove)
end
function tdhBack()
    --EnableTriggerGroup("tdh_fight",false)
	EnableTriggerGroup("tdhId",false)
	DeleteTriggerGroup("tdh_finish")
    create_trigger_t('tdh_finish1','^(> )*(\\D*)'.. job.target ..'抱拳道：“青山不改，绿水常流，咱们后会有期！”','','tdh_finish')
    SetTriggerOption("tdh_finish1","group","tdh_finish")
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
	tmp.tdh = 3
	
	local l_rooms = getRooms(locl.room,locl.area)
    if tmp.troom and type(tmp.troom)=="table" then
	   for k,v in pairs(tmp.troom) do
	       for _,x in pairs(l_rooms) do
		      if k == x then
                 road.id = k
			  end
		   end
	   end
	end
	
	tmp.troom = nil
	
    return check_bei(tdh_find) 
end
function tdhStop()
	dis_all()
	EnableTriggerGroup("tdh_finish",true)
	flag.find=1
	locate()
	return checkWait(tdhStopCheck,3)
end
function tdhStopCheck()
    if not locl.id [job.target] then
	   return check_bei(tdh_find)
	end
	return checkWait(tdh_fangqi_go,60)
end
function tdh_finish()
    return check_heal()
end

