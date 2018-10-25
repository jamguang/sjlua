--gaibang
job.list = job.list or {}
job.list["gaibang"] = "丐帮吴长老杀人任务"
joblast = joblast or {}
joblast["丐帮吴长老杀人任务"] = "gaibang"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["gaibang"] = "gaibangTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["gaibang"] = "gaibangFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["gaibang"] = "gaibangFangqiGo"
faintFunc = faintFunc or {}
faintFunc["gaibang"] = "gaibangFangqiGo"


function gaibangTrigger()
    DeleteTriggerGroup("gaibangAsk")
    create_trigger_t('gaibangAsk1',"^(> )*你向吴长老打听有关",'','gaibangAsk')
    create_trigger_t('gaibangAsk2',"^(> )*这里没有这个人。$",'','gaibangNobody')
    SetTriggerOption("gaibangAsk1","group","gaibangAsk")
    SetTriggerOption("gaibangAsk2","group","gaibangAsk")
    EnableTriggerGroup("gaibangAsk",false)
    DeleteTriggerGroup("gaibangAccept")
    create_trigger_t('gaibangAccept1',"^(> )*吴长老说道：「好吧，最近「(\\D*)」一直和我丐帮作对",'','gaibangTarget')
    create_trigger_t('gaibangAccept2',"^(> )*\\s*此人现在在(\\D*)一带",'','gaibangConsider')
    create_trigger_t('gaibangAccept3',"^(> )*吴长老说道：「既然你干不了也没关系",'','gaibangFail')
    create_trigger_t('gaibangAccept4',"^(> )*吴长老说道：「你连上个任务去都不想去",'','gaibangFail')
    create_trigger_t('gaibangAccept5',"^(> )*吴长老说道：「现在我可没有给你的任务，等会再来吧！",'','gaibangBusy')
    create_trigger_t('gaibangAccept6',"^(> )*吴长老说道：「你没有领任务",'','gaibang')
    create_trigger_t('gaibangAccept7',"^(> )*吴长老说道：「没看见我正忙着吗",'','gaibangWait')
    create_trigger_t('gaibangAccept8',"^(> )*吴长老说道：「不是让你去杀",'','gaibangFangqiGo')
    create_trigger_t('gaibangAccept9',"^(> )*吴长老说道：「现在我可没有给你的任务，等会怎么样？",'','gaibangFail')
    SetTriggerOption("gaibangAccept1","group","gaibangAccept")
    SetTriggerOption("gaibangAccept2","group","gaibangAccept")
    SetTriggerOption("gaibangAccept3","group","gaibangAccept")
    SetTriggerOption("gaibangAccept4","group","gaibangAccept")
    SetTriggerOption("gaibangAccept5","group","gaibangAccept")
    SetTriggerOption("gaibangAccept6","group","gaibangAccept")
    SetTriggerOption("gaibangAccept7","group","gaibangAccept")
    SetTriggerOption("gaibangAccept8","group","gaibangAccept")
    SetTriggerOption("gaibangAccept9","group","gaibangAccept")
    EnableTriggerGroup("gaibangAccept",false)
    DeleteTriggerGroup("gaibangFight")
    create_trigger_t('gaibangFight1','^(> )*(\\D*)「啪」的一声倒在地上','','gaibangDie')
    create_trigger_t('gaibangFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','gaibangFaint')
    create_trigger_t('gaibangFight3','^(> )*(\\D*)急急忙忙地离开了。','','gaibangRun')
    create_trigger_t('gaibangFight4','^(> )*这里没有可使用的对象。','','gaibangNoTarget')
    SetTriggerOption("gaibangFight1","group","gaibangFight")
    SetTriggerOption("gaibangFight2","group","gaibangFight")
    SetTriggerOption("gaibangFight3","group","gaibangFight")
    SetTriggerOption("gaibangFight4","group","gaibangFight")
    EnableTriggerGroup("gaibangFight",false)
    DeleteTriggerGroup("gaibangCut")
    create_trigger_t('gaibangCut1','^>*\\s*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','gaibangCutCon')
    create_trigger_t('gaibangCut2','^>*\\s*你得用件锋利的器具才能切下这尸体的头来。','','gaibangCutWeapon')
    create_trigger_t('gaibangCut3','(> )*你把 "action" 设定为 "Cut" 成功完成。','','gaibangCutFail')
    SetTriggerOption("gaibangCut1","group","gaibangCut") 
    SetTriggerOption("gaibangCut2","group","gaibangCut")
    SetTriggerOption("gaibangCut3","group","gaibangCut")
    EnableTriggerGroup("gaibangCut",false)
    DeleteTriggerGroup("gaibangGive")
    create_trigger_t('gaibangGive1','^(> )*你给吴长老一颗(\\D*)的首级。','','gaibangFinish')
    create_trigger_t('gaibangGive2','^(> )*吴长老说道：「嘿嘿。。。，你杀错人了。」','','gaibangFinish')
    create_trigger_t('gaibangGive3','^(> )*吴长老说道：「我现在正忙着呢，你稍等一下吧。」','','gaibangGiveBusy')
    SetTriggerOption("gaibangGive1","group","gaibangGive")
    SetTriggerOption("gaibangGive2","group","gaibangGive")
    SetTriggerOption("gaibangGive3","group","gaibangGive")
    EnableTriggerGroup("gaibangGive",false)
    DeleteTriggerGroup("gaibangHead")
    create_trigger_t('gaibangHead1','^(> )*这是一颗(\\D*)的(首级|人头)','','gaibangHeadCheck')
    create_trigger_t('gaibangHead2','^(> )*你把 "action" 设定为 "check_head" 成功完成。','','gaibangHeadCon')
    SetTriggerOption("gaibangHead1","group","gaibangHead")
    SetTriggerOption("gaibangHead2","group","gaibangHead")
    EnableTriggerGroup("gaibangHead",false)
end
function gaibangTriggerDel()
    DeleteTriggerGroup("gaibangAsk")
    DeleteTriggerGroup("gaibangAccept")
    DeleteTriggerGroup("gaibangFight")
    DeleteTriggerGroup("gaibangCut")
    DeleteTriggerGroup("gaibangGive")
    DeleteTriggerGroup("gaibangHead")
    DeleteTriggerGroup("gaibangFind")
end
function gaibangNobody()
    EnableTriggerGroup("gaibangAsk",false)
    gaibang()
end
function gaibang()
    gaibangTrigger()
    job.name='gaibang'
    job.time.b=os.time()
    prepare_neili(gaibangGo)
end
function gaibangGo()
    go(gaibangStart,"福州城","船舱")
end
function gaibangStart()
    EnableTriggerGroup("gaibangAsk",true)
    exe('ask wu zhanglao about job')
end
function gaibangAsk()
    EnableTriggerGroup("gaibangAsk",false)
    EnableTriggerGroup("gaibangAccept",true)
end
function gaibangBusy()
    EnableTriggerGroup("gaibangAccept",false)
    if condition.busy and condition.busy==0 then
       job.last='gaibang'
       return check_heal()
    else
       check_bei(gaibangBusyDazuo)
    end
end
function gaibangBusyDazuo()
    exe('out')
    prepare_lianxi(gaibangBusyStart)
end
function gaibangBusyStart()
    exe('enter')
    gaibangStart()
end
function gaibangWait()
    EnableTriggerGroup("gaibangAccept",false)
    if job.name=='fangqi' then
       check_bei(gaibangFangqi)
    else
       check_bei(gaibangStart)
    end
end
function gaibangTarget(n,l,w)
    job.target=Trim(w[2])
    job.killer={}
    job.killer[job.target]=true
end
function gaibangConsider(n,l,w)
    EnableTriggerGroup("gaibangAccept",false)
    job.last='gaibang'
    job.where=Trim(w[2])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if string.find(gaibangCancel,job.target) then
       check_bei(gaibangFangqi)
       messageShow('丐帮任务：任务目标【'..job.target..'】不可到达，任务放弃。')
       return 0
    end
    if not job.room or not path_cal() then
       check_bei(gaibangFangqi)
       messageShow('丐帮任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return
    end
    check_bei(gaibangFind)
    messageShow('丐帮任务：开始前往【'..job.where..'】，寻找任务NPC：【'..job.target..'】。！')
end
function gaibangFangqi()
    EnableTriggerGroup("gaibangAsk",true)
    job.name='fangqi'
    exe('ask wu zhanglao about 放弃')
end
function gaibangFangqiGo()
    EnableTriggerGroup("gaibangAccept",false)
    go(gaibangFangqi,'福州城','船舱')
end
function gaibangFind()
    DeleteTriggerGroup("gaibangFind")
    create_trigger_t('gaibangFind1','^>*\\s*\\D*'..job.target..'\\((\\D*)\\)','','gaibangFight')
    SetTriggerOption("gaibangFind1","group","gaibangFind")
    EnableTriggerGroup("gaibangFind",false)
    flag.times=1
    fight_prepare()
    go(gaibangFindAct,job.area,job.room)    
end
function gaibangFindAgain()
    EnableTriggerGroup("gaibangFind",false)
    go(gaibangFindAct,job.area,job.room)    
end
function gaibangFindAct()
    EnableTriggerGroup("gaibangFind",true)
    job.flag()
    exe('look')
    find()
    messageShow('丐帮任务：开始寻找【'..dest.area .. dest.room ..'】的任务NPC：【'..job.target..'】。！')
end
function gaibangFight(n,l,w)
    EnableTriggerGroup("gaibangFind",false)
    EnableTriggerGroup("gaibangFight",true)
    flag.wait=0
    flag.find=1
    thread_resume(lookfor)
    job.id=string.lower(w[1])
    job.killer[job.target]=job.id
    exe('halt;follow '..job.id)
    --exe('kill '..job.id)
    killPfm(job.id)
end
function gaibangFaint(n,l,w)
    if job.target==w[2] then
       exe('kill '..job.id)
    end
end
function gaibangDie(n,l,w)
    if job.target==w[2] then
       DeleteTimer('perform')
       gaibangCut()
    end
end
function gaibangRun(n,l,w)
    EnableTriggerGroup("gaibangFight",false)
    if job.target==w[2] then
       check_bei(gaibangFind)
    end
end
function gaibangNoTarget()
    EnableTriggerGroup("gaibangFight",false)
    check_bei(gaibangFind)
end
function gaibangCut()
    EnableTriggerGroup("gaibangFight",false)
    messageShow('丐帮任务：搞定任务NPC：【'..job.target..'】。')
    check_bei(gaibangCutAct)
end
gaibangCutAct=function()
    EnableTriggerGroup("gaibangCut",true)
    exe('halt')
    weapon_unwield()
    weaponWieldCut()
    for i=1,3 do
       exe('qie corpse '..i)
    end
    exe('alias action Cut')
end
gaibangCutFail=function()
    EnableTriggerGroup("gaibangCut",false)
    gaibangFind()
end
gaibangCutWeapon=function()
    weapon_unwield()
    gaibangCutAct()
end
gaibangCutCon=function(n,l,w)
    if job.target~=tostring(w[1]) then
       exe('drop head')
       check_bei(gaibangCutAct)
    else
       EnableTriggerGroup("gaibangCut",false)
       return check_bei(gaibangBack)
    end
end
function gaibangBack()
    weapon_unwield()
    for i=1,2 do
       exe('get gold from corpse '..i)
       exe('get silver from corpse '..i)
    end
    go(gaibangHead,'福州城','船舱')
end
function gaibangHead()
    EnableTriggerGroup("gaibangHead",true)
    tmp.flag=0
    exe('look head')
    exe('alias action check_head')
end
function gaibangHeadCheck(n,l,w)
    if w[2] == job.target then
       tmp.flag=1
    end
end
function gaibangHeadCon()
    EnableTriggerGroup("gaibangHead",false)
    if tmp.flag==1 then
       gaibangGive()
    else
       gaibangFinish()
    end
end
function gaibangGive()
    EnableTriggerGroup("gaibangGive",true)
    exe('give wu head')
end
function gaibangGiveBusy()
    EnableTriggerGroup("gaibangGive",false)
    checkWait(gaibangGive)
end
function gaibangFail()
    EnableTriggerGroup("gaibangAccept",false)
    job.name='fangqi'
    job.last='gaibang'
    gaibangFinish()
end
function gaibangFinish()
    EnableTriggerGroup("gaibangAccept",false)
    EnableTriggerGroup("gaibangGive",false)
    checkWait(check_heal,3)
end