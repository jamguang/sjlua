-------华山

job.list = job.list or {}
job.list["huashan"] ="华山惩恶扬善"
joblast = joblast or {}
joblast["惩恶扬善"] = "huashan"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["huashan"] = "huashan_triggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["huashan"] = "huashanFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["huashan"] = "huashanFindFail"

local ftab = {}

function huashan()
    if hp.shen<0 then
	   return turnShen('+')
	end
    huashan_trigger()
    job.name='huashan'
    job.time.b=os.time()
    job.target='任务目标'
	checkWield()
    return prepare_lianxi(huashan_start)
end
function huashanFindAgain()
    EnableTriggerGroup("huashan_find",false)
    return go(huashanFindAct,dest.area,dest.room)
end
function huashanFindFail()
    EnableTriggerGroup("huashan_find",false)
    return go(huashan_shibai,'华山','正气堂')
end
function huashan_start()
    return go(job_huashan,'华山','正气堂')
end
function job_huashan()
    EnableTriggerGroup("huashan_ask",true)
    exe('ask yue buqun about job')
    return messageShow('华山任务：开始任务。')
end
function huashan_trigger()
    DeleteTriggerGroup("huashan_ask")
    create_trigger_t('huashan_ask1',"^(> )*你向岳不群打听有关『job』的消息。$",'','huashan_ask')
    create_trigger_t('huashan_ask2',"^(> )*这里没有这个人。$",'','huashan_nobody')
    SetTriggerOption("huashan_ask1","group","huashan_ask")
    SetTriggerOption("huashan_ask2","group","huashan_ask")
    EnableTriggerGroup("huashan_ask",false)
    DeleteTriggerGroup("huashan_accept")
    create_trigger_t('huashan_accept1',"^(> )*岳不群说道：「你不能光说呀，倒是做出点成绩给我看看！",'','huashan_shibai')
    create_trigger_t('huashan_accept2',"^(> )*岳不群说道：「你现在正忙着做其他任务呢！",'','huashan_busy')
    create_trigger_t('huashan_accept3',"^(> )*岳不群说道：「现在没有听说有恶人为害百姓",'','huashan_fangqi')
    create_trigger_t('huashan_accept4',"^(> )*岳不群给了你一块令牌。$",'','huashan_npc')
	create_trigger_t('huashan_accept5',"^(> )*岳不群对你说道：你还是先去思过崖面壁思过去吧。",'','huashanjjQuest')
    SetTriggerOption("huashan_accept1","group","huashan_accept")
    SetTriggerOption("huashan_accept2","group","huashan_accept")
    SetTriggerOption("huashan_accept3","group","huashan_accept")
	SetTriggerOption("huashan_accept4","group","huashan_accept")
	SetTriggerOption("huashan_accept5","group","huashan_accept")
    EnableTriggerGroup("huashan_accept",false)
    DeleteTriggerGroup("huashan_npc")
    create_trigger_t('huashan_npc1',"^(> )*(冷不防|突然|猛地|忽然|冷不丁)从树林\\D*你的令牌，向(\\D*)(处|方向)\\D*逃去。$",'','huashan_where')
    create_trigger_t('huashan_npc2',"^(> )*你一把抓向蒙面人试图抢回令牌，但被蒙面人敏捷得躲了过去，你顺手扯下蒙面人的面罩，发现原来是曾经名震江湖的(\\D*)。",'','huashan_find')
    create_trigger_t('huashan_npc3','^(> )*你把 "hsjob" 设定为 "闲逛中" 成功完成。','','huashan_npc_goon')
    SetTriggerOption("huashan_npc1","group","huashan_npc")
    SetTriggerOption("huashan_npc2","group","huashan_npc")
    SetTriggerOption("huashan_npc3","group","huashan_npc")
    EnableTriggerGroup("huashan_npc",false)
	DeleteTriggerGroup("huashanQuest")
    create_trigger_t('huashanQuest1',"^(> )*岳不群说道：「".. score.name .."，听说魔教教主被关在杭州西湖湖底，你去把他杀了",'','huashanQuest')
	create_trigger_t('huashanQuest2',"^(> )*岳不群说道：「".. score.name .."你杀了不少恶人，未免杀气过重不如上思过崖面壁忏悔吧",'','huashanDgjj')
	SetTriggerOption("huashanQuest1","group","huashanQuest")
	SetTriggerOption("huashanQuest2","group","huashanQuest")
	EnableTriggerGroup("huashanQuest",false)
end
function huashan_triggerDel()
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_ask")
    DeleteTriggerGroup("huashan_accept")
    DeleteTriggerGroup("huashan_npc")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_cut")
    DeleteTriggerGroup("huashan_yls")
    DeleteTriggerGroup("huashan_yls_ask")
    DeleteTriggerGroup("huashan_over")
	DeleteTriggerGroup("huashanQuest")
end
function huashan_ask()
    EnableTriggerGroup("huashan_ask",false)
    EnableTriggerGroup("huashan_accept",true)
end
function huashan_nobody()
    EnableTriggerGroup("huashan_ask",false)
    return huashan_start()
end
function huashan_shibai()
    EnableTriggerGroup("huashan_accept",false)
    return check_busy(huashan_shibai_b)
end
function huashan_shibai_b()
    Execute('ask yue buqun about 失败')
    messageShow('华山任务：任务失败。')
    return check_job()
end
function huashan_fangqi()
    job.last="huashan"
    return check_heal()
end
function huashan_busy()
    EnableTriggerGroup("huashan_accept",false)
    return check_bei(huashan_busy_dazuo)
end
function huashan_busy_dazuo()
    exe('#3s')
    return prepare_lianxi(check_heal)
end
function huashan_npc()
    EnableTriggerGroup("huashan_accept",false)
	job.last="huashan"
    return check_bei(huashan_npc_go)
end
function huashan_npc_go()
    go(huashan_npc_get,'华山','山脚下')
end
function huashan_npc_get()
    EnableTriggerGroup("huashan_npc",true)
	fight_prepare()
    exe('s')
    return check_bei(huashan_npc_goon)
end
function huashan_npc_goon()
    exe('n;e;e')
    locate()
    return check_busy(huashan_ssl,1)
end
function huashan_ssl()
    if locl.room=="石屋" then
       return check_bei(huashan_npc_ssl)
    else
       return check_bei(huashan_npc_goon)
    end
end
function huashan_npc_ssl()
    return exe('w;s;s;alias hsjob 闲逛中')    
end
huashan_where=function(n,l,w)
    job.room=tostring(w[3])
end
huashan_find=function(n,l,w)
    local flag_huashan=0
    dis_all()
    job.target=tostring(w[2])
	job.killer={}
	job.killer[job.target]=true
    DeleteTriggerGroup("huashan_find")
    create_trigger_t('huashan_find1','^( )*'..job.target..'\\((\\D*)\\)','','huashan_fight')
	create_trigger_t('huashan_find2','^(> )*你把 "action" 设定为 "快速搜寻中" 成功完成。$','','huashanFindRoad')
    SetTriggerOption("huashan_find1","group","huashan_find")
	SetTriggerOption("huashan_find2","group","huashan_find")
    job.flag()
    dest.room=job.room
    dest.area="华山"
    if not path_cal() then
       dest.area="华山村"
    end
	--messageShow(dest.area,dest.room)
    flag.times=1
	tmp.fast = true
	messageShow('华山任务：追杀逃跑到【'..job.room..'】的【'..job.target..'】。')
    --return go(find,dest.area,dest.room)
	exe('look')
	return go(huashanFindAct,dest.area,dest.room) 
end
function huashanFindAct()
    EnableTriggerGroup("huashan_find",true)
	
    job.flag()
	fight_prepare()
	
	if not tmp.fast then
	    return find()
	end
    
	tmp.target = 0
	tmp.froom = 0
	
    ftab = {}
	local path = searchPathGet()
	local pset = utils.split(path,";")
	for p,q in ipairs(pset) do
	    if not (isNil(q) or q=='halt') then 
	       table.insert(ftab,q)
		end
	end
	exe('look')
	return checkWait(huashanFindRoad,0.2)
end
function huashanFindRoad()
    tmp.froom = 0
	tmp.froad = {}
	while table.getn(ftab)>0 do
	    if table.getn(tmp.froad)>9 then
		    return huashanFindMove()
		end		
	    local path = ftab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.froad)>0 then
			    return huashanFindMove()
		    else
			    table.remove(ftab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
						tmp.findfunc = "huashanFindMove"
	                    return _G[func](params)
					else
					    exe(path)
						return huashanFindMove()
					end
				else
				    exe(path)
					return huashanFindMove()
				end
		    end
		else
		    table.remove(ftab,1)
		    table.insert(tmp.froad,path)
		end	
	end
	return huashanFindMove()
end
function huashanFindMove()
    tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
		tmp.fast = nil
	    if flag.times > 2 then
	        messageShow('华山任务：于【'..job.room..'】找不到【' .. job.target ..'】，任务放弃。')
	        return huashanFindFail()
	    else
	        return huashanFindAgain()
	    end
	else
	    local path = table.concat(tmp.froad,";")
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action 快速搜寻中')
	    end)
	end
end
huashan_fight=function(n,l,w)
    job.id=string.lower(w[2])
    if usrList and usrList[job.id] then
       return 
	end
	tmp.findfunc = nil
    flag.find=1
    exe('follow '..job.id)
	job.killer[job.target]=job.id
	killPfm(job.id)
    dis_all()
    DeleteTriggerGroup("huashan_fight")
    create_trigger_t('huashan_fight1','^(> )*'..job.target..'「啪」的一声倒在地上','','huashan_cut')
    create_trigger_t('huashan_fight2','^(> )*'..job.target..'神志迷糊，脚下一个不稳，倒在地上昏了过去。','unset wimpy;kill '..job.id,'')
    SetTriggerOption("huashan_fight1","group","huashan_fight") 
    SetTriggerOption("huashan_fight2","group","huashan_fight") 
end
huashan_cut=function()
    EnableTriggerGroup("huashan_fight",false)
    EnableTriggerGroup("huashan_find",false)
    DeleteTriggerGroup("huashan_cut")
    create_trigger_t('huashan_cut1','^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','huashan_cut_con')
    create_trigger_t('huashan_cut2','^(> )*(乱切别人杀的人干嘛啊|你手上这件兵器无锋无刃|你得用件锋利的器具才能切下这尸体)','','huashan_cut_weapon')
    SetTriggerOption("huashan_cut1","group","huashan_cut") 
    SetTriggerOption("huashan_cut2","group","huashan_cut")
	job.killer={}
	messageShow('华山任务：搞定蒙面人：【'..job.target..'】。')
    return check_bei(huashan_cut_act)
end
huashan_cut_act=function()
    DeleteTimer('perform')
    weapon_unwield()
    weaponWieldCut()
    for i=1,2 do
       exe('get ling pai from corpse '..i)
       exe('get gold from corpse '..i)
       exe('qie corpse '..i)
    end
end
huashan_cut_weapon=function()
    return check_bei(huashan_cut_act,1)
end
huashan_cut_con=function(n,l,w)
    if job.target~=tostring(w[2]) then
       exe('drop head')
       return check_bei(huashan_cut_act)
    else
       EnableTriggerGroup("huashan_cut",false)
       return go(huashan_yls,'华山','祭坛')
    end
end
huashan_yls=function()
    DeleteTriggerGroup("huashan_yls")
    create_trigger_t('huashan_yls1','^(> )*(这里没有这个人。|你身上没有这样东西。|这人好象不是你杀的吧？|你的令牌呢|你还没有去找恶贼，怎么就来祭坛了？)','','huashan_yls_fail')
    create_trigger_t('huashan_yls2','^(> )*岳灵珊在你的令牌上写下了一个 (一|二) 字。','','huashan_yls_ask')
	create_trigger_t('huashan_yls3','^(> )*这好象不是你领的令牌吧？','','huashan_yls_lingpai')
    SetTriggerOption("huashan_yls1","group","huashan_yls")
    SetTriggerOption("huashan_yls2","group","huashan_yls")
	SetTriggerOption("huashan_yls3","group","huashan_yls")
    return exe('give head to yue lingshan;hp')
end
huashan_yls_fail=function()
    EnableTriggerGroup("huashan_yls",false)
	if locl.room~="祭坛" then
	   return go(huashan_yls,'华山','祭坛')
	end
    exe('out;w;s;se;su;su;s')
    return check_bei(huashan_shibai_b)
end
huashan_yls_lingpai=function()
    EnableTriggerGroup("huashan_yls",false)
	exe('drop ling pai')
    return check_bei(huashan_yls)
end
huashan_yls_ask=function(n,l,w)
    EnableTriggerGroup("huashan_yls",false)    
    DeleteTriggerGroup("huashan_yls_ask")
    create_trigger_t('huashan_yls_ask1','^(> )*你向岳灵珊打听有关『力不从心』的消息。','','huashan_yls_back')
    SetTriggerOption("huashan_yls_ask1","group","huashan_yls_ask")
    EnableTriggerGroup("huashan_yls_ask",false)
    if w[2]=='二' then
       return huashan_yls_back()
    else
       return check_bei(huashan_yls_lbcx)
    --   return check_bei(huashan_heal)
    end
end
huashan_heal=function()
    fight_prepare()
    return check_bei(huashan_neili)
end
huashan_neili=function()
    return prepare_neili(huashan_npc)
end
huashan_yls_lbcx=function()
    EnableTriggerGroup("huashan_yls_ask",true)
	weapon_unwield()
    return exe('drop head;askk yue lingshan about 力不从心')
end
huashan_yls_back=function()
    EnableTriggerGroup("huashan_yls_ask",false)
	EnableTriggerGroup("huashanQuest",true)
    DeleteTriggerGroup("huashan_over")
    create_trigger_t('huashan_over1','^(> )*你给岳不群一块令牌。','','huashan_finish')
    create_trigger_t('huashan_over2','^(> )*这里没有这个人。','','')
    SetTriggerOption("huashan_over1","group","huashan_over")
    SetTriggerOption("huashan_over2","group","huashan_over")
    return go(huashan_over,'华山','正气堂')
end
huashan_over=function()
    weapon_unwield()
	EnableTriggerGroup("huashanQuest",true)
    return exe('give ling pai to yue buqun')
end
huashan_finish=function()
    EnableTriggerGroup("huashan_over",false)
	EnableTriggerGroup("huashanQuest",true)
    --huashan_triggerDel()
    --flag.times=1
	exe('drop ling pai')
    messageShow('华山任务：完成任务。')
	return check_bei(check_heal)
end
function huashanQuest()
	SetVariable("timexxdf",os.date())
end
function huashanDgjj()
	SetVariable("timedgjj",os.date())
end
function huashanjjQuest()
    EnableTriggerGroup("huashan_accept",false)
    SetVariable("timedgjj",os.date())
	job.zuhe["huashan"] = nil
	return check_heal()
end