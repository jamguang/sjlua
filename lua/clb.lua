------长乐帮

job.list = job.list or {}
job.list["clb"] = "长乐帮任务"
joblast = joblast or {}
joblast["长乐帮"]   = "clb"
jobFindAgain = jobFindAgain or {}
jobFindAgain["clb"] = "clbFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["clb"] = "clbFindFail"
faintFunc = faintFunc or {}
faintFunc["clb"] = "clbFindFail"

function clbTrigger()
	DeleteTriggerGroup("clbAsk")
    create_trigger_t('clbAsk1',"^(> )*你向贝海石打听有关",'','clbAsk')
    create_trigger_t('clbAsk2',"^(> )*这里没有这个人。$",'','clbNobody')
    SetTriggerOption("clbAsk1","group","clbAsk")
    SetTriggerOption("clbAsk2","group","clbAsk")
    EnableTriggerGroup("clbAsk",false)
    DeleteTriggerGroup("clbAccept")
    create_trigger_t('clbAccept1',"^(> )*贝海石在你的耳边悄声说道：我接到飞鸽传书，(龙灵堂|狮威堂|熊敏堂|虎猛堂|豹捷堂)属下帮众(\\D*)在(\\D*)处遇到袭击",'','clbConsider')
    create_trigger_t('clbAccept2',"^(> )*贝海石说道：「(你不是已经知道了|啊……，对不起|你不是已经进展|我不是告诉你了吗)",'','clbFangqi')
    create_trigger_t('clbAccept3',"^(> )*贝海石说道：「你刚做完长乐帮任务",'','clbFail')
    create_trigger_t('clbAccept4',"^(> )*贝海石说道：「(我帮现在比较空闲|现在我这里没有给你的任务|暂时没有任务需要做)",'','clbBusy')
    create_trigger_t('clbAccept5',"^(> )*贝海石说道：「你刚做完(惩恶扬善|大理送信)任务",'','clbBusy')
    create_trigger_t('clbAccept6',"^(> )*贝海石说道：「现在暂时没有适合你的工作",'','clbBusy')
    create_trigger_t('clbAccept7',"^(> )*贝海石说道：「暂时没有任务需要做，你过一会儿再来吧",'','clbBusy')
    create_trigger_t('clbAccept8',"^(> )*贝海石说道：「既然你无法完成",'','clbFail')
    create_trigger_t('clbAccept9',"^(> )*贝海石说道：「你根本就没有领任务",'','clbFail')
    SetTriggerOption("clbAccept1","group","clbAccept")
    SetTriggerOption("clbAccept2","group","clbAccept")
    SetTriggerOption("clbAccept3","group","clbAccept")
    SetTriggerOption("clbAccept4","group","clbAccept")
    SetTriggerOption("clbAccept5","group","clbAccept")
    SetTriggerOption("clbAccept6","group","clbAccept")
    SetTriggerOption("clbAccept7","group","clbAccept")
    SetTriggerOption("clbAccept8","group","clbAccept")
    SetTriggerOption("clbAccept9","group","clbAccept")
    EnableTriggerGroup("clbAccept",false)
	DeleteTriggerGroup("clbChakan")
    create_trigger_t('clbChakan1','^(> )*你仔细地查看','','clbBack')
	create_trigger_t('clbChakan2','^(> )*(\\D*)「啪」的一声倒在地上','','clbDie')
	create_trigger_t('clbChakan3','^(> )*你把 "action" 设定为 "chakan" 成功完成。$','','clbCkBack')
    SetTriggerOption("clbChakan1","group","clbChakan")
	SetTriggerOption("clbChakan2","group","clbChakan")
	SetTriggerOption("clbChakan3","group","clbChakan")
    EnableTriggerGroup("clbChakan",false)
    DeleteTriggerGroup("clbFinish")
    create_trigger_t('clbFinish1','^(> )*贝海石说道：「(你根本就没有领任务|既然已经知道了是|哎，可惜不能手刃此奸贼|做的好！这些金子)','','clbFinish')
    create_trigger_t('clbFinish2',"^(> )*贝海石说道：「你真的完成任务了",'','clbFangqi')
    SetTriggerOption("clbFinish1","group","clbFinish")
    SetTriggerOption("clbFinish2","group","clbFinish")
    EnableTriggerGroup("clbFinish",false)
end
function clbTriggerDel()
    DeleteTriggerGroup("clbAsk")
    DeleteTriggerGroup("clbAccept")
    DeleteTriggerGroup("clbChakan")
    DeleteTriggerGroup("clbFinish")
    DeleteTriggerGroup("clbFind")
end
function clbNobody()
    EnableTriggerGroup("clbAsk",false)
    return clb()
end

function clb()
    clbTrigger()
    job.name='clb'
    job.time.b=os.time()
	messageShow('长乐帮任务：任务开始。')
    return clbGo()
end

function clbFindAgain()
    EnableTriggerGroup("clbFind",false)
    return go(clbFindAct,dest.area,dest.room)
end
function clbFindFail()
    EnableTriggerGroup("clbFind",false)
    return go(clbFangqi,"长乐帮","小厅")
end
function clbGo()
    return go(clbStart,"长乐帮","小厅")
end
function clbStart()
    EnableTriggerGroup("clbAsk",true)
    exe('ask bei haishi about job')
end
function clbAsk()
    EnableTriggerGroup("clbAsk",false)
    EnableTriggerGroup("clbAccept",true)
end
function clbBusy()
    EnableTriggerGroup("clbAccept",false)
    return check_bei(clbBusyDazuo)
end
function clbBusyDazuo()
    exe('e')
    return prepare_lianxi(clbGo)
end
function clbFail()
    EnableTriggerGroup("clbAccept",false)
    job.last='clb'
	--return getGold()
    return check_heal()
end
function clbConsider(n,l,w)
    EnableTriggerGroup("clbAccept",false)
    job.last='clb'
    job.target=Trim(w[3])
    job.killer={}
    job.killer[job.target]=true
    job.where=Trim(w[4])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       messageShow('长乐帮任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(clbFangqi)
    end
    messageShow('长乐帮任务：开始前往【'..job.where..'】！')
	return check_bei(clbFind)
end
function clbFangqiGo()
    go(clbFangqi,'长乐帮','小厅')
end
function clbFangqi()
    EnableTriggerGroup("clbAsk",true)
    EnableTriggerGroup("clbAccept",false)
    EnableTriggerGroup("clbFinish",false)
    check_bei(clbFangqiAsk)
end
function clbFangqiAsk()
    exe('ask bei haishi about 放弃')
end
function clbFind()
    DeleteTriggerGroup("clbFind")
    create_trigger_t('clbFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','clbTarget')
	create_trigger_t('clbFind2','^(> )*\\D*'..job.target..'的尸体\\((\\D*)\\)','','clbTarget')
    SetTriggerOption("clbFind1","group","clbFind")
	SetTriggerOption("clbFind2","group","clbFind")
	EnableTriggerGroup("clbFind",false)
    flag.times=1
	flag.clbdie=nil
    return go(clbFindAct,job.area,job.room)    
end
function clbFindAct()
    EnableTriggerGroup("clbFind",true)
    DeleteTimer("clb")
    job.flag()
    exe('look')
	messageShow('长乐帮任务：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
    return find()
end
function clbTarget()
    EnableTriggerGroup("clbFind",false)
    dis_all()
    EnableTriggerGroup("clbChakan",true)
	locate()	
	return check_busy(clbLocate)
end
function clbLocate()
    if locl.id[job.target] then
	   return checkWait(clbTarget,1)
	elseif locl.id[job.target ..'的尸体'] then
	   return check_halt(clbChakan)
	else
	   return clbFind()
	end
end
function clbDie(n,l,w)
    if job.target==tostring(w[2]) then
	   flag.clbdie=true
       --return check_bei(clbChakan)
	end
end
function clbChakan()
    exe('yield yes')
    exe('halt')
    for i=1,3 do
	    exe('get cu bu from corpse '.. i)
	end
	exe('chakan cu bu')
	exe('chakan corpse')
	exe('get corpse 2;drop corpse')
	--exe('chakan cu bu')
	exe('chakan corpse')
	exe('get corpse 3;drop corpse')
	--exe('chakan cu bu')
	exe('chakan corpse')
	exe('yield no')
	exe('alias action chakan')
end
function clbCkBack()
    EnableTriggerGroup("clbChakan",false)
    return check_bei(clbCkSec,1)
end
function clbCkSec()
    clbChakan()
	return clbBack()
end
function clbBack()
    EnableTriggerGroup("clbChakan",false)
    return go(clbFinishWait,'长乐帮','小厅')
end
function clbFinishWait()
	if locl.id["贝海石"] then
	   EnableTriggerGroup("clbFinish",true)
	   exe('ask bei haishi about 完成')
	else
	   return go(clbFinishWait,'长乐帮','小厅')
	end
end
function clbFinish()
    EnableTriggerGroup("clbFinish",false)
	messageShow('长乐帮任务：任务结束。')
    return check_bei(check_heal)
end