--sldsm

job.list = job.list or {}
job.list["sldsm"] = function() if score.party and score.party == "������" then return "����������" else return false end end
joblast = joblast or {}
joblast["����������"] = "sldsm"
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
    create_trigger_t('sldsmAsk1',"^(> )*����鰲ͨ�����й�",'','sldsmAsk')
    create_trigger_t('sldsmAsk2',"^(> )*����û������ˡ�$",'','sldsmNobody')
    SetTriggerOption("sldsmAsk1","group","sldsmAsk")
    SetTriggerOption("sldsmAsk2","group","sldsmAsk")
    EnableTriggerGroup("sldsmAsk",false)
    DeleteTriggerGroup("sldsmAccept")
    create_trigger_t('sldsmAccept1',"^(> )*�鰲ͨ˵������(\\D*)���뱾�����ԣ�����ȥ(\\D*)����ɱ�ˣ�",'','sldsmConsiderK')
    create_trigger_t('sldsmAccept2',"^(> )*�鰲ͨ˵����������������ȥ(\\D*)�跨��(\\D*)��˳���̣���",'','sldsmConsiderZ')
    create_trigger_t('sldsmAccept3',"^(> )*�鰲ͨ˵���������Ȱ�ǰһ�����������˵����",'','sldsmFangqi')
    create_trigger_t('sldsmAccept4',"^(> )*�鰲ͨ˵��������С�Ӿ���͵͵���������ɵ����񣬻����������������ȥô",'','sldsmBusy')
    create_trigger_t('sldsmAccept5',"^(> )*�鰲ͨ˵���������������������Ϣһ�°ɡ���",'','sldsmFail')
    create_trigger_t('sldsmAccept6',"^(> )*�鰲ͨ˵������������Ϣһ�°ɡ�",'','sldsmBusy')
    create_trigger_t('sldsmAccept7',"^(> )*�鰲ͨ˵��������ô�������뿹�����ɣ���",'','sldsmBusy')
    create_trigger_t('sldsmAccept8',"^(> )*�鰲ͨ˵��������ô�����鶼�첻�ˣ�Ҫ����������֮�˺��ã���",'','sldsmBusy')
    create_trigger_t('sldsmAccept9',"^(> )*�鰲ͨ˵��������������ο��������ǲ��ǲ����",'','sldsmHeiw')
    create_trigger_t('sldsmAccept10',"^(> )*�鰲ͨ˵����������û����������������ɡ���",'','sldsmBusy')
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
    create_trigger_t('sldsmFight1','^(> )*(\\D*)��ž����һ�����ڵ���','','sldsmDie')
    create_trigger_t('sldsmFight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','sldsmFaint')
    create_trigger_t('sldsmFight3',"^(> )*����û��(\\D*)��",'','sldsmLost')
    create_trigger_t('sldsmFight4',"^(> )*(\\D*)���ڵأ��ߺ������������ͨ���ս�޲�ʤ��",'','sldsmFlop')
    create_trigger_t('sldsmFight5',"^(> )*û��������������˹�˳ѽ!",'','sldsmZhNext')
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
    go(sldsmStart,"������","����")
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
    if not Bag["��ϥ"] then
       exe('ask shou toutuo about ��ϥ')
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
       messageShow('������������Ŀ�꡾'..job.target..'�����ɵ�����������')
       return check_pot(1)
    end
    if not job.room or not path_cal() then
       messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return check_pot(1)
    end
    check_bei(sldsmFind)
    messageShow('�������񣺿�ʼǰ����'..job.where..'��������'..job.target..'����')
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
       messageShow('������������Ŀ�꡾'..job.target..'�����ɵ�����������')
       return check_pot(1)
    end
    if not job.room or not path_cal() then
       messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return check_pot(1)
    end
    check_bei(sldsmFind)
    messageShow('�������񣺿�ʼǰ����'..job.where..'���л꡾'..job.target..'����')
end
function sldsmFangqiGo()
    go(sldsmFangqi,'������','����')
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
    messageShow('�������񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
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
    messageShow('��������������ɣ�')
    return go(check_heal,'������','ҩ��')
end