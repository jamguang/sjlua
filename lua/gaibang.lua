--gaibang
job.list = job.list or {}
job.list["gaibang"] = "ؤ���ⳤ��ɱ������"
joblast = joblast or {}
joblast["ؤ���ⳤ��ɱ������"] = "gaibang"
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
    create_trigger_t('gaibangAsk1',"^(> )*�����ⳤ�ϴ����й�",'','gaibangAsk')
    create_trigger_t('gaibangAsk2',"^(> )*����û������ˡ�$",'','gaibangNobody')
    SetTriggerOption("gaibangAsk1","group","gaibangAsk")
    SetTriggerOption("gaibangAsk2","group","gaibangAsk")
    EnableTriggerGroup("gaibangAsk",false)
    DeleteTriggerGroup("gaibangAccept")
    create_trigger_t('gaibangAccept1',"^(> )*�ⳤ��˵�������ðɣ������(\\D*)��һֱ����ؤ������",'','gaibangTarget')
    create_trigger_t('gaibangAccept2',"^(> )*\\s*����������(\\D*)һ��",'','gaibangConsider')
    create_trigger_t('gaibangAccept3',"^(> )*�ⳤ��˵��������Ȼ��ɲ���Ҳû��ϵ",'','gaibangFail')
    create_trigger_t('gaibangAccept4',"^(> )*�ⳤ��˵�����������ϸ�����ȥ������ȥ",'','gaibangFail')
    create_trigger_t('gaibangAccept5',"^(> )*�ⳤ��˵�����������ҿ�û�и�������񣬵Ȼ������ɣ�",'','gaibangBusy')
    create_trigger_t('gaibangAccept6',"^(> )*�ⳤ��˵��������û��������",'','gaibang')
    create_trigger_t('gaibangAccept7',"^(> )*�ⳤ��˵������û��������æ����",'','gaibangWait')
    create_trigger_t('gaibangAccept8',"^(> )*�ⳤ��˵��������������ȥɱ",'','gaibangFangqiGo')
    create_trigger_t('gaibangAccept9',"^(> )*�ⳤ��˵�����������ҿ�û�и�������񣬵Ȼ���ô����",'','gaibangFail')
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
    create_trigger_t('gaibangFight1','^(> )*(\\D*)��ž����һ�����ڵ���','','gaibangDie')
    create_trigger_t('gaibangFight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','gaibangFaint')
    create_trigger_t('gaibangFight3','^(> )*(\\D*)����ææ���뿪�ˡ�','','gaibangRun')
    create_trigger_t('gaibangFight4','^(> )*����û�п�ʹ�õĶ���','','gaibangNoTarget')
    SetTriggerOption("gaibangFight1","group","gaibangFight")
    SetTriggerOption("gaibangFight2","group","gaibangFight")
    SetTriggerOption("gaibangFight3","group","gaibangFight")
    SetTriggerOption("gaibangFight4","group","gaibangFight")
    EnableTriggerGroup("gaibangFight",false)
    DeleteTriggerGroup("gaibangCut")
    create_trigger_t('gaibangCut1','^>*\\s*ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն���������������С�','','gaibangCutCon')
    create_trigger_t('gaibangCut2','^>*\\s*����ü����������߲���������ʬ���ͷ����','','gaibangCutWeapon')
    create_trigger_t('gaibangCut3','(> )*��� "action" �趨Ϊ "Cut" �ɹ���ɡ�','','gaibangCutFail')
    SetTriggerOption("gaibangCut1","group","gaibangCut") 
    SetTriggerOption("gaibangCut2","group","gaibangCut")
    SetTriggerOption("gaibangCut3","group","gaibangCut")
    EnableTriggerGroup("gaibangCut",false)
    DeleteTriggerGroup("gaibangGive")
    create_trigger_t('gaibangGive1','^(> )*����ⳤ��һ��(\\D*)���׼���','','gaibangFinish')
    create_trigger_t('gaibangGive2','^(> )*�ⳤ��˵�������ٺ١���������ɱ�����ˡ���','','gaibangFinish')
    create_trigger_t('gaibangGive3','^(> )*�ⳤ��˵��������������æ���أ����Ե�һ�°ɡ���','','gaibangGiveBusy')
    SetTriggerOption("gaibangGive1","group","gaibangGive")
    SetTriggerOption("gaibangGive2","group","gaibangGive")
    SetTriggerOption("gaibangGive3","group","gaibangGive")
    EnableTriggerGroup("gaibangGive",false)
    DeleteTriggerGroup("gaibangHead")
    create_trigger_t('gaibangHead1','^(> )*����һ��(\\D*)��(�׼�|��ͷ)','','gaibangHeadCheck')
    create_trigger_t('gaibangHead2','^(> )*��� "action" �趨Ϊ "check_head" �ɹ���ɡ�','','gaibangHeadCon')
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
    go(gaibangStart,"���ݳ�","����")
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
       messageShow('ؤ����������Ŀ�꡾'..job.target..'�����ɵ�����������')
       return 0
    end
    if not job.room or not path_cal() then
       check_bei(gaibangFangqi)
       messageShow('ؤ����������ص㡾'..job.where..'�����ɵ�����������')
       return
    end
    check_bei(gaibangFind)
    messageShow('ؤ�����񣺿�ʼǰ����'..job.where..'����Ѱ������NPC����'..job.target..'������')
end
function gaibangFangqi()
    EnableTriggerGroup("gaibangAsk",true)
    job.name='fangqi'
    exe('ask wu zhanglao about ����')
end
function gaibangFangqiGo()
    EnableTriggerGroup("gaibangAccept",false)
    go(gaibangFangqi,'���ݳ�','����')
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
    messageShow('ؤ�����񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'��������NPC����'..job.target..'������')
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
    messageShow('ؤ�����񣺸㶨����NPC����'..job.target..'����')
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
    go(gaibangHead,'���ݳ�','����')
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