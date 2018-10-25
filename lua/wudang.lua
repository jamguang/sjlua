--wudang

--jobSpecial = jobSpecial or {}
--jobSpecial["wudang"] = true 
job.list = job.list or {}
job.list["wudang"] ="武当杀恶贼"
joblast = joblast or {}
joblast["武当"] = "wudang"
joblast["武当锄奸"] = "wudang"
jobCond = jobCond or {}
jobCond["wudang"] = function() if hp.shen>20000 and (not condition["武当锄奸"] or (condition["武当锄奸"] and condition["武当锄奸"]<=0) or (condition["任务繁忙状态"] and condition["武当锄奸"] and condition["武当锄奸"]<=condition["任务繁忙状态"])) then return true else return false end end
--jobCond["wudang"] = function() if hp.shen>20000 then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["wudang"] = "wudangTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["wudang"] = "wudangFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["wudang"] = "wudangFindFail"
faintFunc = faintFunc or {}
faintFunc["wudang"] = "wudangFaint"

local ftab = {}

function wudangTrigger()
    DeleteTriggerGroup("wudangAsk")
    create_trigger_t('wudangAsk1',"^(> )*你向宋远桥打听有关",'','wudangAsk')
    create_trigger_t('wudangAsk2',"^(> )*这里没有这个人。$",'','wudangNobody')
    SetTriggerOption("wudangAsk1","group","wudangAsk")
    SetTriggerOption("wudangAsk2","group","wudangAsk")
    EnableTriggerGroup("wudangAsk",false)
    DeleteTriggerGroup("wudangAccept")
    create_trigger_t('wudangAccept1',"^(> )*宋远桥在你的耳边悄声说道：据说(江南|江北|西南|中原|西北|河南|河北|东北)(草寇|寨主|恶霸|山贼|土匪|飞贼|盗贼)(\\D*)正在(\\D*)捣乱",'','wudangWhere')
    create_trigger_t('wudangAccept2',"^(> )*宋远桥说道：「我不是告诉你了吗，有人在",'','wudangFangqi')
    create_trigger_t('wudangAccept3',"^(> )*宋远桥在你的耳边悄声说道(\\D*)尤为擅长(\\D*)的功夫。",'','wudangNpc')
    create_trigger_t('wudangAccept4',"^(> )*宋远桥说道：「你正忙着别的事情呢",'','wudangFail')
    create_trigger_t('wudangAccept5',"^(> )*宋远桥说道：「你刚做完(\\D*)任务",'','wudangFail')
    create_trigger_t('wudangAccept6',"^(> )*宋远桥说道：「现在暂时没有适合你的工作",'','wudangFail')
    create_trigger_t('wudangAccept7',"^(> )*宋远桥说道：「暂时没有任务需要做，你过一会儿再来吧",'','wudangFail')
    create_trigger_t('wudangAccept8',"^(> )*宋远桥(对你|)说道：(「|)\\D*，(这个任务确实比较难完成|你太让我失望了)",'','wudangFail')
    create_trigger_t('wudangAccept9',"^(> )*宋远桥说道：「\\D*，你又没在我这里领任务，瞎放弃什么呀",'','wudangFail')
	create_trigger_t('wudangAccepta',"^(> )*宋远桥在你的耳边悄声说道：此人的武功(\\D*)，",'','wudangLevel')
	create_trigger_t('wudangAcceptb',"^(> )*宋远桥说道：「你快去快回，一切小心啊。」$",'','wudangConsider')
	create_trigger_t('wudangAcceptc',"^(> )*宋远桥说道：「(\\D*)的正气还不够，我无法放心让你做这个任务！」$",'','wudangFail')
    SetTriggerOption("wudangAccept1","group","wudangAccept")
    SetTriggerOption("wudangAccept2","group","wudangAccept") 
    SetTriggerOption("wudangAccept3","group","wudangAccept")
    SetTriggerOption("wudangAccept4","group","wudangAccept")
    SetTriggerOption("wudangAccept5","group","wudangAccept") --
    SetTriggerOption("wudangAccept6","group","wudangAccept")
    SetTriggerOption("wudangAccept7","group","wudangAccept")
    SetTriggerOption("wudangAccept8","group","wudangAccept")
    SetTriggerOption("wudangAccept9","group","wudangAccept")
	SetTriggerOption("wudangAccepta","group","wudangAccept")
	SetTriggerOption("wudangAcceptb","group","wudangAccept")
	SetTriggerOption("wudangAcceptc","group","wudangAccept")
    EnableTriggerGroup("wudangAccept",false)
    DeleteTriggerGroup("wudangFinish")
    create_trigger_t('wudangFinish1','^(> )*宋远桥对着你竖起了右手大拇指，好样的。','','wudangFinishT')
    create_trigger_t('wudangFinish2',"^(> )*宋远桥被你气得昏了过去。",'','wudangFinish')
    create_trigger_t('wudangFinish3',"^(> )*宋远桥说道：「"..score.name.."你怎么搞的",'','wudangFinish')
    SetTriggerOption("wudangFinish1","group","wudangFinish")
    SetTriggerOption("wudangFinish2","group","wudangFinish")
    SetTriggerOption("wudangFinish3","group","wudangFinish")
    EnableTriggerGroup("wudangFinish",false)
	DeleteTriggerGroup("wudangQuest")
    create_trigger_t('wudangQuest1',"^(> )*宋远桥说道：「".. score.name ..",今日是师傅九十寿辰之日,往常都是我们七个师兄弟集齐向师傅拜寿。",'','wudangQuest')
	SetTriggerOption("wudangQuest1","group","wudangQuest")
	EnableTriggerGroup("wudangQuest",false)
end
function wudangTriggerDel()
    DeleteTriggerGroup("wudangAsk")
    DeleteTriggerGroup("wudangAccept")
    DeleteTriggerGroup("wudangFinish")
    DeleteTriggerGroup("wudangFind")
	DeleteTriggerGroup("wudangQuest")
end
function wudangNobody()
    EnableTriggerGroup("wudangAsk",false)
    wudang()
end

function wudang()
    if hp.shen<0 then
	    return turnShen('+')
	end
    wudangTrigger()
    job.name='wudang'
    job.time.b=os.time()
	jobLevel = jobLevel or {}
	if jobLevel and jobLevel["wdlvl"] and jobLevel["wdlvl"] < hp.pot_max - 95 then
	    jobLevel["wudang"] = 10
	    jobLevel["wdlvl"] = hp.pot_max - 100
	end
	if GetVariable("levelwudang") and jobLevel[GetVariable("levelwudang")] then
	    jobLevel["wudang"] = jobLevel[GetVariable("levelwudang")]
	end
	messageShow('武当任务：任务开始。')
    return prepare_lianxi(wudangGo)
end

function wudangFindAgain()
    EnableTriggerGroup("wudangFind",false)
    return go(wudangFindAct,dest.area,dest.room)
end

function wudangFaint()
    jobLevel = jobLevel or {}
	if job.level and jobLevel[job.level] and jobLevel["wudang"] and jobLevel["wudang"]>jobLevel[job.level] then
	   jobLevel["wudang"] = jobLevel[job.level]
	   if jobLevel["wudang"] and jobLevel["wudang"] < 5 then
	      jobLevel["wudang"] = 5
	   end
	   jobLevel["wdlvl"] = hp.pot_max - 100
	end
    return wudangFindFail()
end
function wudangFindFail()
    EnableTriggerGroup("wudangFind",false)
    return go(wudangFangqi,"武当山","三清殿")
end
function wudangGo()
    return go(wudangStart,"武当山","三清殿")
end
function wudangStart()
    EnableTriggerGroup("wudangAsk",true)
    return exe('ask song yuanqiao about job')
end
function wudangAsk()
    EnableTriggerGroup("wudangAsk",false)
    EnableTriggerGroup("wudangAccept",true)
end
function wudangBusy()
    EnableTriggerGroup("wudangAccept",false)
	job.last='wudang'
    return check_bei(wudangBusyDazuo)
end
function wudangBusyDazuo()
    exe('n')
    return prepare_lianxi(check_heal)
end
function wudangFail()
    EnableTriggerGroup("wudangAccept",false)
    return check_heal()
end
function wudangWhere(n,l,w)
    job.title =Trim(w[3])
    job.target=Trim(w[4])
    job.killer={}
    job.killer[job.target]=true
    job.where=Trim(w[5])
	job.level = "不堪一击"
	--Note(job.where)
	if string.find(job.where,"周围") then
	   local l_cnt = string.find(job.where,"周围")
	   job.where=string.sub(job.where,1,l_cnt-1)
	   --Note(job.where)
	end
    --job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
	if type(job.room)=="string" and string.find(job.room,"字门") then
	   job.room="紫杉林"
	end
end
function wudangNpc(n,l,w)
	sxjob.skills=tostring(w[3])
    dest.room=job.room
    dest.area=job.area
end
function wudangLevel(n,l,w)
	job.level = tostring(w[2])
end
function wudangConsider()	
    EnableTriggerGroup("wudangAccept",false)
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       messageShow('武当任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(wudangFangqi)
    end
	if skillIgnores[sxjob.skills] then
       messageShow('武当任务：'.. job.target ..'使用的武功是【'..sxjob.skills..'】不可力敌，任务放弃。')
	   return check_bei(wudangFangqi)
	end
	
	if job.level and jobLevel[job.level] and jobLevel["wudang"] and jobLevel[job.level] >= jobLevel["wudang"] then
	   messageShow('武当任务：'.. job.target ..'的武功是【'.. job.level ..'】不可力敌，任务放弃。')
	   return check_bei(wudangFangqi)
	end
	if job.level and sxjob.skills then
	    messageShow('武当任务：'.. job.target ..'使用的武功是【'.. job.level ..'】的【'..sxjob.skills..'】。')
	end
	messageShow('武当任务：开始前往【'..job.where..'】！')
    return check_bei(wudangFind)
end
function wudangFangqiGo()
    return go(wudangFangqi,'武当山','三清殿')
end
function wudangFangqi()
    EnableTriggerGroup("wudangAccept",false)
    return check_bei(wudangFangqiAsk)
end
function wudangFangqiAsk()
    EnableTriggerGroup("wudangAsk",true)
    exe('ask song yuanqiao about 放弃')
end
function wudangFind()
    DeleteTriggerGroup("wudangFind")
    create_trigger_t('wudangFind1','^(> )*(\\D*)'..job.target..'\\((\\D*)\\)','','wudangTarget')
	create_triggerex_lvl('wudangFind2',"^(> )*这里没有(\\D*)。",'','wudangLost',120)
	create_triggerex_lvl('wudangFind3','^(> )*(\\D*) - ','','wudangRoom',120)
	create_trigger_t('wudangFind4','^(> )*你把 "action" 设定为 "快速搜寻中" 成功完成。$','','wudangFindCheck')
	create_trigger_t('wudangFind5','^(> )*'.. job.target ..'「啪」的一声倒在地上','','wudangBack')
    create_trigger_t('wudangFind6','^(> )*'.. job.target ..'大喊一声：不好！！转身几个起落就不见了','','wudangBack')
    create_trigger_t('wudangFind7','^(> )*'.. job.target ..'对着你发出一阵阴笑，说道\\D*(那也就只能算你命短了|我不客气了)','','wudangKillAct')
	create_trigger_t('wudangFind8','^(> )*'.. job.target ..'大喊一声：老子不奉陪了！转身几个起落就不见了','','wudangBack')
	create_trigger_t('wudangFind9','^(> )*你决定跟随'.. job.target ..'一起行动。','','wudangKillAct')
    SetTriggerOption("wudangFind1","group","wudangFind")
	SetTriggerOption("wudangFind2","group","wudangFind")
	SetTriggerOption("wudangFind3","group","wudangFind")
	SetTriggerOption("wudangFind4","group","wudangFind")
	SetTriggerOption("wudangFind5","group","wudangFind")
	SetTriggerOption("wudangFind6","group","wudangFind")
	SetTriggerOption("wudangFind7","group","wudangFind")
	SetTriggerOption("wudangFind8","group","wudangFind")
	SetTriggerOption("wudangFind9","group","wudangFind")
    flag.times=1
	tmp.fast = true
	--exe('unset wimpy')
	fight_prepare()
	EnableTriggerGroup("wudangFind",true)
	EnableTrigger("wudangFind3",false)
    return go(wudangFindAct,job.area,job.room)    
end
function wudangFindAct()
    EnableTriggerGroup("wudangFind",true)
	EnableTrigger("wudangFind3",false)
	if locl.id[job.target] and not (usrList and usrList[job.id]) then
       return wudangKillAct()
	end
    DeleteTimer("wudang")
    job.flag()
	fight_prepare()
	messageShow('武当任务：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
	
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
	return checkWait(wudangFindCheck,0.2)
end
function wudangFindCheck()
    EnableTrigger("wudangFind3",false)
    if tmp.target and tmp.target > 0 then
	    if tmp.froom ==0 then
	        return wudangFindFollow()
	    else
	        return wudangFindBack()
	    end
	else
	    return wudangFindRoad()
	end
end
function wudangFindBack()
    tmp.froom = tmp.froom or 0
	
	for i = 1,tmp.froom do
	    table.remove(tmp.froad,1)
	end
	
	local path = ''
	
	for i = table.getn(tmp.froad),1,-1 do
	    if isNil(path) then
		    path = dirReverse[tmp.froad[i]]
		else
		    path = path .. ';' .. dirReverse[tmp.froad[i]]
		end
	end
	
	EnableTrigger("wudangFind3",true)
	create_alias('goset','goset','alias goalias '.. path)
    exe('goset')
	exe('goalias')
	   
    return check_bei(wudangFindFollow)
end
function wudangFindRoad()
    tmp.froom = 0
	tmp.froad = {}
	while table.getn(ftab)>0 do
	    if table.getn(tmp.froad)>9 then
		    return wudangFindMove()
		end		
	    local path = ftab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.froad)>0 then
			    return wudangFindMove()
		    else
			    table.remove(ftab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
					    EnableTrigger("wudangFind2",false)
						EnableTrigger("wudangFind3",false)
						tmp.findfunc = "wudangFindFollow"
	                    return _G[func](params)
					else
					    exe(path)
						return wudangFindFollow()
					end
				else
				    exe(path)
					return wudangFindFollow()
				end
		    end
		else
		    table.remove(ftab,1)
		    table.insert(tmp.froad,path)
		end	
	end
	return wudangFindMove()
end
function wudangFindMove()
    tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
        EnableTriggerGroup("wudangFind",false)
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
		tmp.fast = nil
	    if flag.times > 2 then
	        messageShow('武当任务：于【'..job.where..'】找不到【' .. job.target ..'】，任务放弃。')
	        return wudangFindFail()
	    else
	        return wudangFindAgain()
	    end
	else
	    local path = table.concat(tmp.froad,";")
		
		EnableTrigger("wudangFind3",true)
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action 快速搜寻中')
	    end)
	end
end
function wudangRoom()
    tmp.froom = tmp.froom or 0
    if tmp.target == 0 then
	    tmp.froom = tmp.froom + 1
	end
end
function wudangFindFollow()
    EnableTrigger("wudangFind2",true)
	EnableTrigger("wudangFind3",true)
    exe('follow '..job.id)
	exe('kick '..job.id)
	if tmp.target and tmp.target== 1 then
	   create_timer_s('wudang',5,'wudangMove')
	end
	messageShow('武当任务：开始和【'..job.target..'】的战斗！')
end
function wudangTarget(n,l,w)
    local l_title = Trim(w[2])
	
    job.id=string.lower(w[3])
	
	if not (l_title and job.title and string.find(l_title,job.title)) then
	   return
	end
	if tmp.fast then
	    tmp.target = 1
	else 
        --EnableTriggerGroup("wudangFind",false)
        --EnableTriggerGroup("wudangFight",true)
        
        job.killer[job.target]=job.id
        exe('follow '..job.id)
	    exe('kick '..job.id)
        wudangKill()
        create_timer_s('wudang',5,'wudangMove')
		messageShow('武当任务：开始和【'..job.target..'】的战斗！')
	end
end
function wudangMove()
	if job.id then
	   exe('follow '..job.id)
	   exe('kick '..job.id)
	   exe('kill '..job.id)
	end
end
function wudangLost(n,l,w)
    if job.id~=Trim(w[2]) then
	   return 
	end
	DeleteTimer("wudang")
    if not tmp.fast then       
        dis_all()
        return wudangFindAgain()
	end 
	tmp.target = 0
	tmp.froom = 0
	tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    return wudangFindCheck()
	else
	    return wudangFindMove()
	end
end
function wudangKill()
    wait.make(function()
         wait.time(2)
	 wudangKillAct()
    end)
end
function wudangKillAct()
    exe('set wimpy 100;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    exe('kick '..job.id)
    killPfm(job.id)
	create_timer_s('wudang',5,'wudangMove')
	messageShow('武当任务：开始和【'..job.target..'】的战斗！')
end
function wudangBack(n,l,w)
    --DeleteTimer("wudang")
    --EnableTriggerGroup("wudangFight",false)
	--EnableTriggerGroup("wudangFind",false)
    --EnableTriggerGroup("wudangFinish",true)
    tmp.number = 0
	tmp.findfunc = nil
    --DeleteTimer("perform")
	--DeleteTimer("wudang")
	dis_all()
    messageShow('武当任务：搞定'..'【'.. job.target ..'】！')
	return check_bei(wudangBackGet)
end
function wudangBackGet()
    for i=1,2 do
       exe('get gold from corpse '..i)
    end
    return go(wudangFinishWait,'武当山','三清殿')
end
function wudangFinishWait()
	if locl.id["宋远桥"] then
	   EnableTriggerGroup("wudangFinish",true)
	   EnableTriggerGroup("wudangQuest",true)
	   return check_busy(wudangFinishAsk)
	else
	   return go(wudangFinishWait,'武当山','三清殿')
	end
end
function wudangFinishAsk()
    exe('ask song yuanqiao about 完成')
end
function wudangFinishT()
	return wudangFinish()
end
function wudangFinish()
    EnableTriggerGroup("wudangFinish",false)
	messageShow('武当任务：任务完成！')
    return check_bei(check_heal)
end
function wudangQuest()
	SetVariable("timeyttl",os.date())
end