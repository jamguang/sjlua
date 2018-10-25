--zhuoshe

job.list = job.list or {}
job.list["zhuoshe"] = function() if score.party and score.party == "丐帮" then return "丐帮捉蛇" else return false end end
joblast = joblast or {}
joblast["丐帮捉蛇"] = "zhuoshe"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["zhuoshe"] = "zhuosheTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["zhuoshe"] = "zhuosheFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["zhuoshe"] = "zhuosheFangqiGo"
faintFunc = faintFunc or {}
faintFunc["zhuoshe"] = "zhuosheFangqiGo"

function zhuosheTrigger()
    DeleteTriggerGroup("zhuosheAsk")
    create_trigger_t('zhuosheAsk1',"^(> )*你向陈长老打听有关",'','zhuosheAsk')
    create_trigger_t('zhuosheAsk2',"^(> )*这里没有这个人。$",'','zhuosheNobody')
    SetTriggerOption("zhuosheAsk1","group","zhuosheAsk")
    SetTriggerOption("zhuosheAsk2","group","zhuosheAsk")
    EnableTriggerGroup("zhuosheAsk",false)
    DeleteTriggerGroup("zhuosheAccept")
    create_trigger_t('zhuosheAccept1',"^(> )*陈长老说道：你去(\\D*)附近帮我捉条蛇回来吧！",'','zhuosheConsider')
    create_trigger_t('zhuosheAccept2',"^(> )*陈长老说道：「你帮不了我，那你就去练功吧。以后我再找你。」",'','zhuosheFail')
    create_trigger_t('zhuosheAccept3',"^(> )*陈长老暂时不想抓蛇，你过一会儿再来吧。",'','zhuosheBusy')
    create_trigger_t('zhuosheAccept4',"^(> )*陈长老说道：「刚才不是让你帮我抓蛇去了吗，你怎么还不去",'','zhuosheFangqiGo')
    create_trigger_t('zhuosheAccept5',"^(> )*陈长老说道：「什么放弃？放什么弃？",'','check_heal')
    create_trigger_t('zhuosheAccept6',"^(> )*陈长老说道：「你手头还有其他的事吧？过一会再来吧！",'','zhuosheBusy')
    create_trigger_t('zhuosheAccept7',"^(> )*陈长老说道：「你刚抓完蛇，还是先去休息一会吧。",'','zhuosheFail')
    SetTriggerOption("zhuosheAccept1","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept2","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept3","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept4","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept5","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept6","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept7","group","zhuosheAccept")
    EnableTriggerGroup("zhuosheAccept",false)
    DeleteTriggerGroup("zhuosheFind")
    create_trigger_t('zhuosheFind1','^(> )*突然你发现草丛中有一条蛇。','','zhuosheTarget')
    SetTriggerOption("zhuosheFind1","group","zhuosheFind")
    EnableTriggerGroup("zhuosheFind",false)
    DeleteTriggerGroup("zhuosheFight")
    create_trigger_t('zhuosheFight1','^(> )*(\\D*)「啪」的一声倒在地上','','zhuosheBack')
    create_trigger_t('zhuosheFight2','^(> )*(\\D*)缩成一团，不动了。你伸手抓了起来。','','zhuosheBack')
    create_trigger_t('zhuosheFight3','^(> )*你决定跟随(\\D*)一起行动。','','zhuosheName')
    SetTriggerOption("zhuosheFight1","group","zhuosheFight")
    SetTriggerOption("zhuosheFight2","group","zhuosheFight")
    SetTriggerOption("zhuosheFight3","group","zhuosheFight")
    EnableTriggerGroup("zhuosheFight",false)
    DeleteTriggerGroup("zhuosheFinish")
    create_trigger_t('zhuosheFinish1','^(> )*陈长老从你手里接过蛇，转身装进一个口袋里。','','zhuosheFinish')
    create_trigger_t('zhuosheFinish2',"^(> )*陈长老说道：「这么简单的事都办不好，你下去吧",'','zhuosheFinish')
    SetTriggerOption("zhuosheFinish1","group","zhuosheFinish")
    SetTriggerOption("zhuosheFinish2","group","zhuosheFinish")
    EnableTriggerGroup("zhuosheFinish",false)
end
function zhuosheTriggerDel()
    DeleteTriggerGroup("zhuosheAsk")
    DeleteTriggerGroup("zhuosheAccept")
    DeleteTriggerGroup("zhuosheFind")
    DeleteTriggerGroup("zhuosheFight")
    DeleteTriggerGroup("zhuosheFinish")
end
function zhuosheNobody()
    EnableTriggerGroup("zhuosheAsk",false)
    zhuoshe()
end

function zhuoshe()
    zhuosheTrigger()
    job.name='zhuoshe'
    job.time.b=os.time()
    prepare_neili(zhuosheGo)
end
function zhuosheGo()
    go(zhuosheStart,"丐帮","空地")
end
function zhuosheStart()
    EnableTriggerGroup("zhuosheAsk",true)
    exe('ask chen zhanglao about job')
end
function zhuosheAsk()
    EnableTriggerGroup("zhuosheAsk",false)
    EnableTriggerGroup("zhuosheAccept",true)
end
function zhuosheBusy()
    EnableTriggerGroup("zhuosheAccept",false)
    check_bei(zhuosheBusyDazuo)
end
function zhuosheBusyDazuo()
    prepare_lianxi(zhuosheStart)
end
function zhuosheFail()
    EnableTriggerGroup("zhuosheAccept",false)
    job.last='zhuoshe'
    check_bei(zhuosheDan)
end
function zhuosheWait()
    EnableTriggerGroup("zhuosheAccept",false)
    if job.name=='fangqi' then
       check_bei(zhuosheFangqi)
    else
       check_bei(zhuosheStart)
    end
end
function zhuosheConsider(n,l,w)
    EnableTriggerGroup("zhuosheAccept",false)
    job.last='zhuoshe'
    job.where=Trim(w[2])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if not job.room or not path_cal() then
       check_bei(zhuosheFangqi)
       messageShow('捉蛇任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return
    end
    check_bei(zhuosheFind)
    messageShow('捉蛇任务：开始前往【'..job.where..'】！')
end
function zhuosheFangqiGo()
    go(zhuosheFangqi,'丐帮','空地')
end
function zhuosheFangqi()
    EnableTriggerGroup("zhuosheAsk",true)
    job.name='fangqi'
    exe('ask chen zhanglao about 放弃')
end
function zhuosheFind()
    EnableTriggerGroup("zhuosheFind",true)
    flag.times=1
    fight_prepare()
    go(zhuosheFindAct,job.area,job.room)    
end
function zhuosheFindAgain()
    EnableTriggerGroup("zhuosheFind",true)
    go(zhuosheFindAct,job.area,job.room)
end
function zhuosheFindAct()
    EnableTriggerGroup("zhuosheFind",true)
    job.flag()
    exe('look')
    find()
    messageShow('捉蛇任务：开始寻找【'..dest.area .. dest.room ..'】的毒蛇！')
end
function zhuosheName(n,l,w)
    job.target=Trim(w[2])
    job.killer={}
    job.killer[job.target]="du she"
end
function zhuosheTarget()
    dis_all()
    zhuosheFight()
end
function zhuosheFight()
    EnableTriggerGroup("zhuosheFind",false)
    EnableTriggerGroup("zhuosheFight",true)
    flag.wait=0
    flag.find=1
    job.id='du she'
    exe('follow '..job.id)
    killPfm(job.id)
end
function zhuosheFaint(n,l,w)
    if job.target==w[2] then
       exe('kill '..job.id)
    end
end
function zhuosheBack(n,l,w)
    if job.target==w[2] then
       EnableTriggerGroup("zhuosheFight",false)
       EnableTriggerGroup("zhuosheFinish",true)
       DeleteTimer('perform')
       exe('halt;fu bai caodan')
       messageShow('捉蛇任务：搞定毒蛇！')
       return go(zhuosheReady,'丐帮','空地')
    end
end
function zhuosheReady()
    exe('e;w')
    checkWait(zhuosheReadyWait,2)
end
function zhuosheReadyWait()
    exe('e;w')
    checkWait(zhuosheReadyFail,2)
end
function zhuosheReadyFail()
    exe('e;w')
    checkWait(zhuosheFangqi,2)
end
function zhuosheFinish()
    EnableTriggerGroup("zhuosheFinish",false)
    dis_all()
    check_bei(zhuosheDan)
end
function zhuosheDan()
    exe('ask chen zhanglao about 百草丹')
    check_bei(zhuosheFudan)
end
function zhuosheFudan()
    exe('fu bai caodan')
    check_bei(zhuosheDan2)
end
function zhuosheDan2()
    exe('ask chen zhanglao about 百草丹')
    check_bei(check_heal)
end