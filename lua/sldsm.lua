--sldsm

job.list = job.list or {}
job.list["sldsm"] = function() if score.party and score.party == "神龙教" then return "神龙岛任务" else return false end end
joblast = joblast or {}
joblast["神龙岛任务"] = "sldsm"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["sldsm"] = "sldsmTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["sldsm"] = "sldsmFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["sldsm"] = "sldsmFangqiGo"
faintFunc = faintFunc or {}
faintFunc["sldsm"] = "sldsmFangqiGo"


function sldsmTrigger()
    DeleteTriggerGroup("sldsmAsk")
    create_trigger_t('sldsmAsk1',"^(> )*你向洪安通打听有关",'','sldsmAsk')
    create_trigger_t('sldsmAsk2',"^(> )*这里没有这个人。$",'','sldsmNobody')
    SetTriggerOption("sldsmAsk1","group","sldsmAsk")
    SetTriggerOption("sldsmAsk2","group","sldsmAsk")
    EnableTriggerGroup("sldsmAsk",false)
    DeleteTriggerGroup("sldsmAccept")
    create_trigger_t('sldsmAccept1',"^(> )*洪安通说道：「(\\D*)常与本教做对，你速去(\\D*)把他杀了！",'','sldsmConsiderK')
    create_trigger_t('sldsmAccept2',"^(> )*洪安通说道：「现在令你速去(\\D*)设法让(\\D*)归顺本教！」",'','sldsmConsiderZ')
    create_trigger_t('sldsmAccept3',"^(> )*洪安通说道：「你先把前一个任务完成再说。」",'','sldsmFangqi')
    create_trigger_t('sldsmAccept4',"^(> )*洪安通说道：「你小子竟敢偷偷做其他门派的任务，还想在神龙教里呆下去么",'','sldsmBusy')
    create_trigger_t('sldsmAccept5',"^(> )*洪安通说道：「你刚做完任务，先休息一下吧。」",'','sldsmFail')
    create_trigger_t('sldsmAccept6',"^(> )*洪安通说道：「你先休息一下吧。",'','sldsmBusy')
    create_trigger_t('sldsmAccept7',"^(> )*洪安通说道：「怎么？！你想抗命不成？！",'','sldsmBusy')
    create_trigger_t('sldsmAccept8',"^(> )*洪安通说道：「这么点事情都办不了，要你这种无用之人何用！」",'','sldsmBusy')
    create_trigger_t('sldsmAccept9',"^(> )*洪安通说道：「你三番五次抗命不遵，是不是不想活",'','sldsmHeiw')
    create_trigger_t('sldsmAccept10',"^(> )*洪安通说道：「现在没有任务，你等下再来吧。」",'','sldsmBusy')
    SetTriggerOption("sldsmAccept1","group","sldsmAccept")
    SetTriggerOption("sldsmAccept2","group","sldsmAccept")
    SetTriggerOption("sldsmAccept3","group","sldsmAccept")
    SetTriggerOption("sldsmAccept4","group","sldsmAccept")
    SetTriggerOption("sldsmAccept5","group","sldsmAccept")
    SetTriggerOption("sldsmAccept6","group","sldsmAccept")
    SetTriggerOption("sldsmAccept7","group","sldsmAccept")
    SetTriggerOption("sldsmAccept8","group","sldsmAccept")
    SetTriggerOption("sldsmAccept9","group","sldsmAccept")
    SetTriggerOption("sldsmAccept10","group","sldsmAccept")
    EnableTriggerGroup("sldsmAccept",false)
    DeleteTriggerGroup("sldsmFight")
    create_trigger_t('sldsmFight1','^(> )*(\\D*)「啪」的一声倒在地上','','sldsmDie')
    create_trigger_t('sldsmFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','sldsmFaint')
    create_trigger_t('sldsmFight3',"^(> )*这里没有(\\D*)。",'','sldsmLost')
    create_trigger_t('sldsmFight4',"^(> )*(\\D*)跪倒在地，高呼道：洪教主神通广大，战无不胜！",'','sldsmFlop')
    create_trigger_t('sldsmFight5',"^(> )*没有让你诱迫这个人归顺呀!",'','sldsmZhNext')
    SetTriggerOption("sldsmFight1","group","sldsmFight")
    SetTriggerOption("sldsmFight2","group","sldsmFight")
    SetTriggerOption("sldsmFight3","group","sldsmFight")
    SetTriggerOption("sldsmFight4","group","sldsmFight")
    SetTriggerOption("sldsmFight5","group","sldsmFight")
    EnableTriggerGroup("sldsmFight",false)
end
function sldsmTriggerDel()
    DeleteTriggerGroup("sldsmAsk")
    DeleteTriggerGroup("sldsmAccept")
    DeleteTriggerGroup("sldsmFight")
    DeleteTriggerGroup("sldsmFind")
end
function sldsmNobody()
    EnableTriggerGroup("sldsmAsk",false)
    sldsm()
end
function sldsm()
    sldsmTrigger()
    job.name='sldsm'
    job.time.b=os.time()
    prepare_neili(sldsmGo)
end
function sldsmGo()
    go(sldsmStart,"神龙岛","大厅")
end
function sldsmStart()
    EnableTriggerGroup("sldsmAsk",true)
    exe('ask hong antong about job')
end
function sldsmAsk()
    EnableTriggerGroup("sldsmAsk",false)
    EnableTriggerGroup("sldsmAccept",true)
end
function sldsmBusy()
    EnableTriggerGroup("sldsmAccept",false)
    check_bei(sldsmBusyDazuo)
end
function sldsmBusyDazuo()
    if not Bag["护膝"] then
       exe('ask shou toutuo about 护膝')
    end
    prepare_lianxi(sldsmStart)
end
function sldsmFail()
    EnableTriggerGroup("sldsmAccept",false)
    job.last="sldsm"
    check_heal()
end
function sldsmHeiw()
    EnableTriggerGroup("sldsmAccept",false)
end
function sldsmConsiderK(n,l,w)
    EnableTriggerGroup("sldsmAccept",false)
    job.last='sldsm'
    job.target=Trim(w[2])
    job.id=nil
    job.sldtime=os.time()
    job.type="sm"
    job.killer={}
    job.killer[job.target]=true
    job.where=Trim(w[3])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if string.find(sldsmCancel,job.target) then
       messageShow('神龙任务：任务目标【'..job.target..'】不可到达，任务放弃。')
       return check_pot(1)
    end
    if not job.room or not path_cal() then
       messageShow('神龙任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_pot(1)
    end
    check_bei(sldsmFind)
    messageShow('神龙任务：开始前往【'..job.where..'】索命【'..job.target..'】！')
end
function sldsmConsiderZ(n,l,w)
    EnableTriggerGroup("sldsmAccept",false)
    job.last='sldsm'
    job.target=Trim(w[3])
    job.id=nil
    job.sldtime=os.time()
    job.type="zh"
    job.killer={}
    job.killer[job.target]=true
    job.where=Trim(w[2])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if string.find(sldsmCancel,job.target) then
       messageShow('神龙任务：任务目标【'..job.target..'】不可到达，任务放弃。')
       return check_pot(1)
    end
    if not job.room or not path_cal() then
       messageShow('神龙任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_pot(1)
    end
    check_bei(sldsmFind)
    messageShow('神龙任务：开始前往【'..job.where..'】招魂【'..job.target..'】！')
end
function sldsmFangqiGo()
    go(sldsmFangqi,'神龙岛','大厅')
end
function sldsmFangqi()
    EnableTriggerGroup("sldsmAccept",false)
    if job.sldtime and os.time()-job.sldtime<600 then
       return prepare_lianxi(sldsmFangqi)
    end
    check_bei(sldsmFangqiAsk)
end
function sldsmFangqiAsk()
    EnableTriggerGroup("sldsmAsk",true)
    exe('ask hong antong about cancel')
end
function sldsmFind()
    DeleteTriggerGroup("sldsmFind")
    create_trigger_t('sldsmFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','sldsmTarget')
    SetTriggerOption("sldsmFind1","group","sldsmFind")
    EnableTrigger("sldsmFind1",false)
    flag.times=1
    fight_prepare()
    go(sldsmFindAct,job.area,job.room)    
end
function sldsmFindAgain()
    EnableTrigger("sldsmFind1",false)
    go(sldsmFindAct,job.area,job.room)  
end
function sldsmFindAct()
    EnableTriggerGroup("sldsmFind",true)
    job.flag()
    exe('look')
    find()
    messageShow('神龙任务：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
end
function sldsmTarget(n,l,w)
    EnableTriggerGroup("sldsmFind",false)
    EnableTriggerGroup("sldsmFight",true)
    flag.wait=0
    flag.find=1
    thread_resume(lookfor)
    job.id=string.lower(w[2])
    job.killer[job.target]=job.id
    exe('halt;follow '..job.id)
    if job.type and job.type=="zh" then
       killPfm(job.id,"zh")
    else
       killPfm(job.id)
    end
end
function sldsmZh(n,l,w,styles)
    local l_flag=false
    for _, v in ipairs (styles) do
       --Note(v.text,RGBColourToName (v.textcolour))
       if RGBColourToName (v.textcolour)=="maroon" then l_flag=true end
    end
    if flag and job.id then
       exe('zh '.. job.id)
    end
end
function sldsmZhNext()
    job.id = job.id ..' 2'
    exe('follow '.. job.id)
end
function sldsmFaint(n,l,w)
    if job.target==w[2] then
       if job.type and job.type=="zh" then
          exe('halt')
       else
          exe('kill '..job.id)
       end
    end
end
function sldsmDie(n,l,w)
    if job.target==w[2] then
       if job.type and job.type=="zh" then
          exe('follow '..job.id)
       else
          check_bei(sldsmSm)
       end
    else
       if job.type and job.type=="sm" then
          exe('kill '.. job.id)
       end
    end
end
function sldsmFlop(n,l,w)
    if job.target==w[2] then
       return sldsmFinish()
    end
end
function sldsmSm()
    exe('halt')
    for i=1,3 do
        exe('sm corpse '..i)
    end
    return sldsmFinish()
end
function sldsmLost(n,l,w)
    if job.id==Trim(w[2]) then
       dis_all()
       return sldsmFind()
    end
end
function sldsmFinish()
    EnableTriggerGroup("sldsmFight",false)
    DeleteTimer("perform")
    messageShow('神龙任务：任务完成！')
    return go(check_heal,'襄阳城','药房')
end