jobSpecial = jobSpecial or {}
jobSpecial["zhujian"] = true
job.list = job.list or {}
job.list["zhujian"] ="宝剑运送"
joblast = joblast or {}
joblast["宝剑运送"]   = "zhujian"
jobFindAgain = jobFindAgain or {}
jobFindAgain["zhujian"] = "zhujianFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["zhujian"] = "zhujianFindFail"
faintFunc = faintFunc or {}
faintFunc["zhujian"] = "zhujianFindFail"


AddrIgnoresSongJian = {
	--["曼佗罗山庄"] = true,
	--["燕子坞"] = true,
	["桃源县"] = true,
	["神龙岛"] = true,
	--["姑苏慕容"] = true,
	["梅庄"] = true,
}


function zhujianTrigger()
    DeleteTriggerGroup("zhujianAsk")
    create_trigger_t('zhujianAsk1',"^(> )*你向铸剑师打听有关",'','zhujianAsk')
    create_trigger_t('zhujianAsk2',"^(> )*这里没有这个人。$",'','zhujianNobody')
    SetTriggerOption("zhujianAsk1","group","zhujianAsk")
    SetTriggerOption("zhujianAsk2","group","zhujianAsk")
    EnableTriggerGroup("zhujianAsk",false)
    DeleteTriggerGroup("zhujianAccept")
    create_trigger_t('zhujianAccept1',"^(> )*铸剑师在你的耳边悄声说道：快帮我把宝剑送给(\\D*)，他在(\\D*)",'','zhujianConsider')
    create_trigger_t('zhujianAccept2',"^(> )*铸剑师在你的耳边悄声说道：快帮我把宝剑送给(\\D*)的(\\D*)。",'','zhujianConsiderT')
    create_trigger_t('zhujianAccept3',"^(> )*铸剑师说道：「我不是叫你把宝剑送给",'','zhujianFangqi')
    create_trigger_t('zhujianAccept4',"^(> )*铸剑师说道：「你太忙了吧，要注意休息啊。」",'','zhujianFail')
    create_trigger_t('zhujianAccept5',"^(> )*铸剑师说道：「你刚做完(武当锄奸|星宿叛徒|惩恶扬善|大理送信)任务",'','zhujianFail')
    create_trigger_t('zhujianAccept6',"^(> )*铸剑师说道：「\\D*，这个任务确实比较难完成，下次给你简单的，先退下吧！」",'','zhujianFail')
    create_trigger_t('zhujianAccept7',"^(> )*铸剑师说道：「暂时没有任务需要做，你过一会儿再来吧",'','zhujianFail')
    create_trigger_t('zhujianAccept8',"^(> )*(铸剑师对你失望极了|铸剑师怒火中烧，一刀把你劈成两半)",'','zhujianFail')
    create_trigger_t('zhujianAccept9',"^(> )*铸剑师说道：「你要放弃什么？」",'','zhujianFail')

    SetTriggerOption("zhujianAccept1","group","zhujianAccept")
    SetTriggerOption("zhujianAccept2","group","zhujianAccept")
    SetTriggerOption("zhujianAccept3","group","zhujianAccept")
    SetTriggerOption("zhujianAccept4","group","zhujianAccept")
    SetTriggerOption("zhujianAccept5","group","zhujianAccept")
    SetTriggerOption("zhujianAccept6","group","zhujianAccept")
    SetTriggerOption("zhujianAccept7","group","zhujianAccept")
    SetTriggerOption("zhujianAccept8","group","zhujianAccept")
    SetTriggerOption("zhujianAccept9","group","zhujianAccept")
    EnableTriggerGroup("zhujianAccept",false)

    DeleteTriggerGroup("zhujianGive")
    create_trigger_t('zhujianGive1','^(> )*(\\D*)「哈哈哈」大笑几声。','','zhujianGiveAct')
    create_trigger_t('zhujianGive2','^(> )*你把刚刚打造好的定制宝剑送给(\\D*)。','','zhujianBack')
    create_trigger_t('zhujianGive3',"^(> )*这里没有(\\D*)。",'','zhujianLost')
    SetTriggerOption("zhujianGive1","group","zhujianGive")
    SetTriggerOption("zhujianGive2","group","zhujianGive")
    SetTriggerOption("zhujianGive3","group","zhujianGive")
    EnableTriggerGroup("zhujianGive",false)

    DeleteTriggerGroup("zhujianFinish")
    create_trigger_t('zhujianFinish1','^(> )*铸剑师对着你鼓起掌来，干得好。','','zhujianFinishT')
    create_trigger_t('zhujianFinish2',"^(> )*铸剑师被你气得昏了过去。",'','zhujianFinish')
    SetTriggerOption("zhujianFinish1","group","zhujianFinish")
    SetTriggerOption("zhujianFinish2","group","zhujianFinish")
    EnableTriggerGroup("zhujianFinish",false)

    DeleteTriggerGroup("zhujianQuest")
    create_trigger_t('zhujianQuest1',"^(> )*铸剑师说道：「你能领悟了",'','zhujianQuest')
    SetTriggerOption("zhujianQuest1","group","zhujianQuest")
    EnableTriggerGroup("zhujianQuest",false)
end

function zhujianTriggerDel()
    DeleteTriggerGroup("zhujianAsk")
    DeleteTriggerGroup("zhujianAccept")
    DeleteTriggerGroup("zhujianGive")
    DeleteTriggerGroup("zhujianFinish")
    DeleteTriggerGroup("zhujianFind")
    DeleteTriggerGroup("zhujianQuest")
end
function zhujianNobody()
    EnableTriggerGroup("zhujianAsk",false)
    zhujian()
end

function zhujian()
    zhujianTrigger()
    job.name='zhujian'
    job.time.b=os.time()
    return zhujianGo()
end

function zhujianFindAgain()
    EnableTriggerGroup("zhujianFind",false)
    return go(zhujianFindAct,dest.area,dest.room)
end

function zhujianFindFail()
   -- messageShowDebug('寻找失败：【'..job.where..'】')
    EnableTriggerGroup("zhujianFind",false)
    return go(zhujianFangqi,"扬州城","兵器铺")
end
function zhujianGo()
    return go(zhujianStart,"扬州城","兵器铺")
end
function zhujianStart()
    flag.idle = 0
    EnableTriggerGroup("zhujianAsk",true)
    return exe('ask zhujian shi about job')
end
function zhujianAsk()
    EnableTriggerGroup("zhujianAsk",false)
    EnableTriggerGroup("zhujianAccept",true)
end
function zhujianBusy()
    EnableTriggerGroup("zhujianAccept",false)
    job.last='zhujian'
    return check_bei(zhujianBusyDazuo)
end
function zhujianBusyDazuo()
    exe('n')
    return prepare_lianxiz(check_heal)
end
function zhujianFail()
    flag.idle = 0
    EnableTriggerGroup("zhujianAccept",false)
    job.last='zhujian'
    wait.make(function()
         wait.time(5)
	 zhujianStart()
    end)
end
function zhujianConsider(n,l,w)
    EnableTriggerGroup("zhujianAccept",false)
    messageShow('宝剑运送：开始！')
    job.last='zhujian'
    job.target=tostring(w[2])
    job.where=tostring(w[3])
    if string.find(job.where,"周围") then
        local l_cnt = string.find(job.where,"周围")
        job.where=string.sub(job.where,1,l_cnt-1)
    end
    
    job.room,job.area=getAddr(job.where)
    if type(job.room)=="string" and string.find(job.room,"字门") then
        job.room="紫杉林"
    end

    if (job.where=="星宿海星宿海" or job.where=="黑木崖" or job.where=="大雪山法堂二楼" 
    or job.where=="大雪山萨迦法堂" or job.where=="星宿海石道" or job.where=="星宿海海边荒路" 
    or job.where=="星宿海厨房" or job.where=="星宿海日月洞口" or job.where=="星宿海小路" 
    or job.where=="星宿海日月洞" or job.where=="星宿海山前荒地"  or job.where=="明教龙王殿"  
    or job.where=="星宿海山壁" or job.where=="虫谷入口" or job.where=="星宿海山石"
    or job.where=="星宿海药庐") and hp.exp<2000000 then
       job.where="有危险不去"
       print(job.where)
    end
	
    if WhereIgnores[job.where] or AddrIgnoresSongJian[job.area]  or not job.room or not path_cal() then
       messageShow('宝剑运送：地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(zhujianFangqi)
    end
    messageShow('宝剑运送：前往【'..job.where..'】！')
    return check_bei(zhujianFind)
end
function zhujianConsiderT(n,l,w)
    messageShow('宝剑运送：开始！')
    job.last='zhujian'
    job.target=tostring(w[3])
    job.where=tostring(w[2])
	
	
	
    if string.find(job.where,"周围") then
        local l_cnt = string.find(job.where,"周围")
        job.where=string.sub(job.where,1,l_cnt-1)
    end
    
    job.room,job.area=getAddr(job.where)
    if type(job.room)=="string" and string.find(job.room,"字门") then
        job.room="紫杉林"
    end

	if (job.where=="星宿海星宿海" or job.where=="黑木崖" or job.where=="大雪山法堂二楼" 
    or job.where=="大雪山萨迦法堂" or job.where=="星宿海石道" or job.where=="星宿海海边荒路" 
    or job.where=="星宿海厨房" or job.where=="星宿海日月洞口" or job.where=="星宿海小路" 
    or job.where=="星宿海日月洞" or job.where=="星宿海山前荒地"  or job.where=="明教龙王殿"  
    or job.where=="星宿海山壁" or job.where=="虫谷入口" or job.where=="星宿海山石"
    or job.where=="星宿海药庐") and hp.exp<2000000 then
       job.where="有危险不去"
       print(job.where)
    end
	
    if WhereIgnores[job.where] or AddrIgnoresSongJian[job.area]  or not job.room or not path_cal() then
       messageShow('宝剑运送：地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(zhujianFangqi)
    end
    messageShow('宝剑运送：前往【'..job.where..'】！')
    return check_bei(zhujianFind)
end

function zhujianFangqiGo()
    go(zhujianFangqi,'扬州城','兵器铺')
end
function zhujianFangqi()
    EnableTriggerGroup("zhujianAccept",false)
    check_bei(zhujianFangqiAsk)
end
function zhujianFangqiAsk()
    EnableTriggerGroup("zhujianAsk",true)
    exe('ask zhujian shi about 放弃')
end
function zhujianFind()
    DeleteTriggerGroup("zhujianFind")
    create_trigger_t('zhujianFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','zhujianTarget')
    SetTriggerOption("zhujianFind1","group","zhujianFind")
    flag.times=1
    exe('unset wimpy')
    go(zhujianFindAct,job.area,job.room)    
end
function zhujianFindAct()
    EnableTriggerGroup("zhujianFind",true)
    DeleteTimer("zhujian")
    job.flag()
--    fight_prepare()
    exe('look')
    find()
    messageShow('宝剑运送：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
end
function zhujianFindKill()
    dis_all()
    EnableTriggerGroup("zhujianFind",true)
    exe('look')
end
function zhujianTarget(n,l,w)
    EnableTriggerGroup("zhujianFind",false)
    dis_all()
    EnableTriggerGroup("zhujianGive",true)
    job.id=string.lower(w[2])
    exe('follow '..job.id)
    zhujianGive()
    create_timer_s('zhujian',5,'zhujianMove')
end
function zhujianMove()
    if job.id then
        exe('song '..job.id)
    end
end
function zhujianLost(n,l,w)
    if job.id==Trim(w[2]) then
       dis_all()
       return zhujianFind()
    end
end
function zhujianGive()
    wait.make(function()
         wait.time(1)
	 zhujianGiveAct()
    end)
end
function zhujianGiveAct()
    exe('song '..job.id)
end
function zhujianBack(n,l,w)
    DeleteTimer("zhujian")
    if w[2]==job.target then
       EnableTriggerGroup("zhujianGive",false)
       EnableTriggerGroup("zhujianFinish",true)
       tmp.number=0
       DeleteTimer("zhujian")
       check_halt(zhujianBackGet)
       messageShow('宝剑运送：送抵'..'【'.. job.target ..'】！')
    end
end
function zhujianBackGet()
    return go(zhujianFinishWait,'扬州城','兵器铺')
end
function zhujianFinishWait()
    if locl.id["铸剑师"] then
        EnableTriggerGroup("zhujianFinish",true)
        EnableTriggerGroup("zhujianQuest",true)
        return check_busy(zhujianFinishAsk)
    else
       return go(zhujianFinishWait,'扬州城','兵器铺')
    end
end
function zhujianFinishAsk()
    exe('ask zhujian shi about 完成')
end
function zhujianFinishT()
    job.last="zhujian"
    job.zjtime=0
    EnableTriggerGroup("zhujianFinish",false)
    return check_heal(zhujian)
end
function zhujianQuest()
    exe('set 八段锦')
end
function zhujianFinish()
    job.last="zhujianfail"
    EnableTriggerGroup("zhujianFinish",false)
    wait.make(function()
         wait.time(5)
	 zhujian()
    end)
end