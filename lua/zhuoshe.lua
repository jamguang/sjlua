--zhuoshe

job.list = job.list or {}
job.list["zhuoshe"] = function() if score.party and score.party == "ؤ��" then return "ؤ��׽��" else return false end end
joblast = joblast or {}
joblast["ؤ��׽��"] = "zhuoshe"
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
    create_trigger_t('zhuosheAsk1',"^(> )*����³��ϴ����й�",'','zhuosheAsk')
    create_trigger_t('zhuosheAsk2',"^(> )*����û������ˡ�$",'','zhuosheNobody')
    SetTriggerOption("zhuosheAsk1","group","zhuosheAsk")
    SetTriggerOption("zhuosheAsk2","group","zhuosheAsk")
    EnableTriggerGroup("zhuosheAsk",false)
    DeleteTriggerGroup("zhuosheAccept")
    create_trigger_t('zhuosheAccept1',"^(> )*�³���˵������ȥ(\\D*)��������׽���߻����ɣ�",'','zhuosheConsider')
    create_trigger_t('zhuosheAccept2',"^(> )*�³���˵��������ﲻ���ң������ȥ�����ɡ��Ժ��������㡣��",'','zhuosheFail')
    create_trigger_t('zhuosheAccept3',"^(> )*�³�����ʱ����ץ�ߣ����һ��������ɡ�",'','zhuosheBusy')
    create_trigger_t('zhuosheAccept4',"^(> )*�³���˵�������ղŲ����������ץ��ȥ��������ô����ȥ",'','zhuosheFangqiGo')
    create_trigger_t('zhuosheAccept5',"^(> )*�³���˵������ʲô��������ʲô����",'','check_heal')
    create_trigger_t('zhuosheAccept6',"^(> )*�³���˵����������ͷ�����������°ɣ���һ�������ɣ�",'','zhuosheBusy')
    create_trigger_t('zhuosheAccept7',"^(> )*�³���˵���������ץ���ߣ�������ȥ��Ϣһ��ɡ�",'','zhuosheFail')
    SetTriggerOption("zhuosheAccept1","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept2","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept3","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept4","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept5","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept6","group","zhuosheAccept")
    SetTriggerOption("zhuosheAccept7","group","zhuosheAccept")
    EnableTriggerGroup("zhuosheAccept",false)
    DeleteTriggerGroup("zhuosheFind")
    create_trigger_t('zhuosheFind1','^(> )*ͻȻ�㷢�ֲݴ�����һ���ߡ�','','zhuosheTarget')
    SetTriggerOption("zhuosheFind1","group","zhuosheFind")
    EnableTriggerGroup("zhuosheFind",false)
    DeleteTriggerGroup("zhuosheFight")
    create_trigger_t('zhuosheFight1','^(> )*(\\D*)��ž����һ�����ڵ���','','zhuosheBack')
    create_trigger_t('zhuosheFight2','^(> )*(\\D*)����һ�ţ������ˡ�������ץ��������','','zhuosheBack')
    create_trigger_t('zhuosheFight3','^(> )*���������(\\D*)һ���ж���','','zhuosheName')
    SetTriggerOption("zhuosheFight1","group","zhuosheFight")
    SetTriggerOption("zhuosheFight2","group","zhuosheFight")
    SetTriggerOption("zhuosheFight3","group","zhuosheFight")
    EnableTriggerGroup("zhuosheFight",false)
    DeleteTriggerGroup("zhuosheFinish")
    create_trigger_t('zhuosheFinish1','^(> )*�³��ϴ�������ӹ��ߣ�ת��װ��һ���ڴ��','','zhuosheFinish')
    create_trigger_t('zhuosheFinish2',"^(> )*�³���˵��������ô�򵥵��¶��첻�ã�����ȥ��",'','zhuosheFinish')
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
    go(zhuosheStart,"ؤ��","�յ�")
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
       messageShow('׽����������ص㡾'..job.where..'�����ɵ�����������')
       return
    end
    check_bei(zhuosheFind)
    messageShow('׽�����񣺿�ʼǰ����'..job.where..'����')
end
function zhuosheFangqiGo()
    go(zhuosheFangqi,'ؤ��','�յ�')
end
function zhuosheFangqi()
    EnableTriggerGroup("zhuosheAsk",true)
    job.name='fangqi'
    exe('ask chen zhanglao about ����')
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
    messageShow('׽�����񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'���Ķ��ߣ�')
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
       messageShow('׽�����񣺸㶨���ߣ�')
       return go(zhuosheReady,'ؤ��','�յ�')
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
    exe('ask chen zhanglao about �ٲݵ�')
    check_bei(zhuosheFudan)
end
function zhuosheFudan()
    exe('fu bai caodan')
    check_bei(zhuosheDan2)
end
function zhuosheDan2()
    exe('ask chen zhanglao about �ٲݵ�')
    check_bei(check_heal)
end