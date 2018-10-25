--全真守卫古墓嫡传

job.list = job.list or {}
job.list["shouwei"] = function() if score.party and score.party=="全真教" and hp.exp>200000 then return "守卫古墓" else return false end end
joblast = joblast or {}
joblast["守卫古墓"]   = "shouwei"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["shouwei"] = "shouwei_triggerDel"

function shouwei_trigger()
    DeleteTriggerGroup("shouweiask")
    create_trigger_t('shouweiask1',"^(> )*你向尹志平打听有关『守卫古墓",'','shouweiConsider')
    create_trigger_t('shouweiask2',"^(> )*这里没有这个人。$",'','shouweiNobody')
    SetTriggerOption("shouweiask1","group","shouweiask")    
	SetTriggerOption("shouweiask2","group","shouweiask")
    EnableTriggerGroup("shouweiask",false)	
    DeleteTriggerGroup("shouweiAccept")
    create_trigger_t('shouweiAccept1',"^(> )*尹志平说道：「"..score.name..",今日闻听消息，有一批不明人士正在终南山脚下集结。」",'','shouweiJJ')
	create_trigger_t('shouweiAccept2',"^(> )*尹志平说道：「"..score.name..",你正在任务繁忙中，还是先休息一会吧。」",'','shouweiBusy')
    create_trigger_t('shouweiAccept3',"^(> )*尹志平说道：「"..score.name..",你上一次任务还没完成呢。」",'','shouweifangqi')
	create_trigger_t('shouweiAccept4',"^(> )*尹志平说道：「"..score.name..",你刚结束守卫古墓，还是先休息一会吧。」",'','shouweiBusy')
	create_trigger_t('shouweiAccept5',"^(> )*尹志平说道：「我不是让你去杀",'','shouweifangqi')
	SetTriggerOption("shouweiAccept1","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept2","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept3","group","shouweiAccept")
	SetTriggerOption("shouweiAccept4","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept5","group","shouweiAccept") 
    EnableTriggerGroup("shouweiAccept",false)
    DeleteTriggerGroup("shouwei_task")
	create_trigger_t('shouwei_task1',"^(> )*一名"..score.name.."所要追拿的(\\D*)晃悠悠的走了过来，见你在此守卫，立即对你发起猛烈的攻击！",'','shouweiGetTaget')	
    create_trigger_t('shouwei_task2',"^(> )*「啪」的一声倒在地上，挣扎着抽动了几下就死了",'','shouweiCut')
	create_trigger_t('shouwei_task3',"^(> )*脚下一个不稳，倒在地上昏了过去。",'','shouweiAttack')
	SetTriggerOption("shouwei_task1","group","shouwei_task")
	SetTriggerOption("shouwei_task2","group","shouwei_task")
	SetTriggerOption("shouwei_task3","group","shouwei_task")
	EnableTriggerGroup("shouwei_task",false)	
    DeleteTriggerGroup("shouwei_Finish")
	create_trigger_t('shouwei_Finish1',"^(> )*尹志平说道：「很好，"..score.name.."，既然你把这批淫贼给杀了，我就给你点下酒钱！」",'','shouweiOver')
	create_trigger_t('shouwei_Finish2',"^(> )*你此次看守共得到(\\D*)点经验，(\\D*)点潜能",'','shouweiExp')
	SetTriggerOption("shouwei_Finish1","group","shouwei_finish")
	SetTriggerOption("shouwei_Finish2","group","shouwei_finish")
	EnableTriggerGroup("shouwei_Finish",false)
	DeleteTriggerGroup("shouweiCut")
	create_trigger_t('shouweiCut1','^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','shouweiCutCon')
	create_trigger_t('shouweiCut2','^(> )*你得用件锋利的器具才能切下这尸体的头来。','','shouweiCut')
	SetTriggerOption("shouweiCut1","group","shouweiCut")
	SetTriggerOption("shouweiCut2","group","shouweiCut")
	EnableTriggerGroup("shouweiCut",false)
end
function shouwei_triggerDel()
	EnableTriggerGroup("shouwei_task",false)
    EnableTriggerGroup("shouweiAccept",false)
    EnableTriggerGroup("shouweiask",false)
    EnableTriggerGroup("shouweiCut",false)
	EnableTriggerGroup("shouwei_Finish",false)
	EnableTriggerGroup("shouwei2_kill",false)
    DeleteTriggerGroup("shouwei_task")
	DeleteTriggerGroup("shouweiAccept")
	DeleteTriggerGroup("shouweiask")
	DeleteTriggerGroup("shouweiCut")
	DeleteTriggerGroup("shouwei2_kill")
	DeleteTriggerGroup("shouwei_Finish")
end
function shouweifangqi()
	return check_bei(shouweifangqi2,1)
end
function shouweifangqi2()
	exe('ask yin zhiping about 放弃')
	return check_bei(check_heal,1)
end 
function shouwei()
    shouwei_trigger()
    job.name='shouwei'
    job.time.b=os.time()
    job.flag()
	exe('hp')	
	flag.idle=0
	return prepare_lianxi(shouweiGO)
end

function shouweiGO()
    return go(shouweiStart,'全真','教碑')
end
function shouweiStart()
	if locl.room ~= '教碑' then
	    return check_busy(shouweiGO)
	end
	checkWield()
	--exe("bai yin zhiping")
	return prepare_neili(shouweiAsk)
end
function shouweiBusy()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiask",false)
	job.last="shouwei"
    return check_bei(check_heal,1)
end
function shouweiAsk()
    EnableTriggerGroup("shouweiask",true)
	EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouwei_task",false) 
	exe('ask yin zhiping about 守卫古墓')	
end

function shouweiNobody()
    EnableTriggerGroup("shouweiask",false)
    return prepare_neili(shouweiStart)   
end

function shouweiConsider()
    EnableTriggerGroup("shouweiask",false)
	EnableTriggerGroup("shouweiAccept",true) 
end

function shouweiJJ()
	messageShow('全真守卫古墓任务：任务开始。')
	return go(shouweiSW,'终南山','山路')
end
function shouweiSW()
	if not locl.room=='山路' then
		return shouweiJJ()
	end
	fight_prepare()
	exe('eu')
	messageShow('全真守卫古墓：老子已经到了，开始守卫, 什么搔虎， 什么 人来疯 老子是不怕的')
	exe('shouwei')
	--fight_prepare()
	EnableTriggerGroup("shouwei_task",true)
end
function shouwei_two(n,l,w)	
	job.target=tostring(Trim(w[2]))
    messageShow('全真守卫古墓：杀主谋 '..job.target)
	--printTab(itemWield)
	weapon_unwield()
	weapon_wield()
    job.id=get_id(job.target)
	if GetVariable("flagshouwei2") and GetVariable("flagshouwei2") == "yes" then
        exe('answer yes')
	    messageShow('全真守卫古墓：出发去杀主谋 '..job.target)
	    DeleteTriggerGroup("shouwei2_kill")
	    create_trigger_t('shouwei2_kill_1',"^(> )*"..job.target.."「啪」的一声倒在地上，挣扎着抽动了几下就死了",'','shouweiCut')
	    SetTriggerOption("shouwei2_kill_1","group","shouwei2_kill")
	    EnableTriggerGroup("shouwei2_kill",true)
	    return go(shouwei_twokill,'quanzhen/shijie2')
    end
	exe('answer no')
	messageShow('全真守卫古墓：放弃 杀主谋 '..job.target)
    return check_bei(check_heal)
end
function goshouwei2()
	exe('w;nd;wd;nw')
	exe('say 到了石阶 找 '..job.target)
	messageShow('全真守卫古墓: 到了石阶 找 '..job.target)
end
function shouwei_twokill()
    exe('say 到了石阶 找 '..job.target)
	messageShow('全真守卫古墓: 到了石阶 找 '..job.target)
    EnableTriggerGroup("shouweiCut",true)
    exe('set wimpy 100;follow '..job.id)
    exe('kill '..job.id)
end
function shouweiGetTaget(n,l,w)
	job.target=tostring(w[2])
	EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	exe('look attacker')
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiGetTagetKill()
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiAttack()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiAttack2()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweijobkilltime()
	exe('kill attacker;qie corpse')	
end
function shouweiCutWeapon()
    EnableTriggerGroup("shouweiCut",false)
    weapon_unwield()
    weaponWieldCut()
end
function shouweiCutCon()
	EnableTimer('shouwei_kill',false)
	DeleteTimer('shouwei_kill')	
	EnableTriggerGroup("shouweiCut",false)
	dis_all()
	EnableTriggerGroup("shouwei_Finish",true)
	--exe('unwield mu jian;')
	DeleteTimer("shouwei")
	DeleteTimer("perform")
	messageShow('全真守卫古墓：已经干掉 鸟人')
    job.target='守墓1'
	return check_busy(shouweiBack,2)
end

function shouweiCut()
    return check_busy(shouweiCutAct,1)
end
function shouweiCutAct()
	EnableTriggerGroup("shouweiCut",true)
	weapon_unwield()
    weaponWieldCut()
	for i=1,3 do
        exe('qie corpse '..i)    
    end	
end

function shouweiExp(n,l,w)   
    messageShow('全真守卫古墓奖励：获得经验:【'.. w[2] ..'】点，潜能:【'.. w[3] ..'】点！')
	EnableTriggerGroup("shouwei_task",false) 
	exe('unset env_msg') 
    exe('say 嫡传啊嫡传~你什么时候传~~')
end
function shouweiBack()
    DeleteTimer("shouwei")
    DeleteTimer("perform")	
	EnableTriggerGroup("shouweiCut",false)
    EnableTriggerGroup("shouwei_Finish",true)
	DeleteTriggerGroup("shouwei2_task")
	create_trigger_t('shouwei2_task1','^(> )*尹志平在你耳边小声说道，“事情已经明了，此次主持袭扰龙姑娘的主凶是(\\D*)这恶贼！”','','shouwei_two')
	SetTriggerOption("shouwei2_task1","group","shouwei2_task")
    messageShow('全真守卫古墓：搞定了，交任务！')
    --exe('say 全真守卫：搞定了，交任务！')
	--weapon_unwield()
	--weapon_wield()
	--checkWield()
	exe('leavefb')
    return go(shouweiHead,'全真','教碑')
end
function shouweiHead()
	exe('give shouji to yin zhiping')
	return check_bei(shouweiOver,1)
end
function shouweiOver()
    messageShow('全真守卫古墓：守墓任务 1 结束。')
	--printTab(itemWield)
	weapon_unwield()
	weapon_wield()
    if not GetVariable("flagshouwei2") or GetVariable("flagshouwei2")=="no" then
		messageShow('全真守卫古墓：主谋关闭中 不杀主谋')
		exe('answer no')
		job.last="shouwei"
		return check_bei(check_heal)
	end
    
	return check_bei(check_heal)
end