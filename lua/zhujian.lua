jobSpecial = jobSpecial or {}
jobSpecial["zhujian"] = true
job.list = job.list or {}
job.list["zhujian"] ="��������"
joblast = joblast or {}
joblast["��������"]   = "zhujian"
jobFindAgain = jobFindAgain or {}
jobFindAgain["zhujian"] = "zhujianFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["zhujian"] = "zhujianFindFail"
faintFunc = faintFunc or {}
faintFunc["zhujian"] = "zhujianFindFail"


AddrIgnoresSongJian = {
	--["��٢��ɽׯ"] = true,
	--["������"] = true,
	["��Դ��"] = true,
	["������"] = true,
	--["����Ľ��"] = true,
	["÷ׯ"] = true,
}


function zhujianTrigger()
    DeleteTriggerGroup("zhujianAsk")
    create_trigger_t('zhujianAsk1',"^(> )*��������ʦ�����й�",'','zhujianAsk')
    create_trigger_t('zhujianAsk2',"^(> )*����û������ˡ�$",'','zhujianNobody')
    SetTriggerOption("zhujianAsk1","group","zhujianAsk")
    SetTriggerOption("zhujianAsk2","group","zhujianAsk")
    EnableTriggerGroup("zhujianAsk",false)
    DeleteTriggerGroup("zhujianAccept")
    create_trigger_t('zhujianAccept1',"^(> )*����ʦ����Ķ�������˵��������Ұѱ����͸�(\\D*)������(\\D*)",'','zhujianConsider')
    create_trigger_t('zhujianAccept2',"^(> )*����ʦ����Ķ�������˵��������Ұѱ����͸�(\\D*)��(\\D*)��",'','zhujianConsiderT')
    create_trigger_t('zhujianAccept3',"^(> )*����ʦ˵�������Ҳ��ǽ���ѱ����͸�",'','zhujianFangqi')
    create_trigger_t('zhujianAccept4',"^(> )*����ʦ˵��������̫æ�˰ɣ�Ҫע����Ϣ������",'','zhujianFail')
    create_trigger_t('zhujianAccept5',"^(> )*����ʦ˵�������������(�䵱����|������ͽ|�Ͷ�����|��������)����",'','zhujianFail')
    create_trigger_t('zhujianAccept6',"^(> )*����ʦ˵������\\D*���������ȷʵ�Ƚ�����ɣ��´θ���򵥵ģ������°ɣ���",'','zhujianFail')
    create_trigger_t('zhujianAccept7',"^(> )*����ʦ˵��������ʱû��������Ҫ�������һ���������",'','zhujianFail')
    create_trigger_t('zhujianAccept8',"^(> )*(����ʦ����ʧ������|����ʦŭ�����գ�һ��������������)",'','zhujianFail')
    create_trigger_t('zhujianAccept9',"^(> )*����ʦ˵��������Ҫ����ʲô����",'','zhujianFail')

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
    create_trigger_t('zhujianGive1','^(> )*(\\D*)������������Ц������','','zhujianGiveAct')
    create_trigger_t('zhujianGive2','^(> )*��Ѹոմ���õĶ��Ʊ����͸�(\\D*)��','','zhujianBack')
    create_trigger_t('zhujianGive3',"^(> )*����û��(\\D*)��",'','zhujianLost')
    SetTriggerOption("zhujianGive1","group","zhujianGive")
    SetTriggerOption("zhujianGive2","group","zhujianGive")
    SetTriggerOption("zhujianGive3","group","zhujianGive")
    EnableTriggerGroup("zhujianGive",false)

    DeleteTriggerGroup("zhujianFinish")
    create_trigger_t('zhujianFinish1','^(> )*����ʦ����������������ɵúá�','','zhujianFinishT')
    create_trigger_t('zhujianFinish2',"^(> )*����ʦ�������û��˹�ȥ��",'','zhujianFinish')
    SetTriggerOption("zhujianFinish1","group","zhujianFinish")
    SetTriggerOption("zhujianFinish2","group","zhujianFinish")
    EnableTriggerGroup("zhujianFinish",false)

    DeleteTriggerGroup("zhujianQuest")
    create_trigger_t('zhujianQuest1',"^(> )*����ʦ˵����������������",'','zhujianQuest')
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
   -- messageShowDebug('Ѱ��ʧ�ܣ���'..job.where..'��')
    EnableTriggerGroup("zhujianFind",false)
    return go(zhujianFangqi,"���ݳ�","������")
end
function zhujianGo()
    return go(zhujianStart,"���ݳ�","������")
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
    messageShow('�������ͣ���ʼ��')
    job.last='zhujian'
    job.target=tostring(w[2])
    job.where=tostring(w[3])
    if string.find(job.where,"��Χ") then
        local l_cnt = string.find(job.where,"��Χ")
        job.where=string.sub(job.where,1,l_cnt-1)
    end
    
    job.room,job.area=getAddr(job.where)
    if type(job.room)=="string" and string.find(job.room,"����") then
        job.room="��ɼ��"
    end

    if (job.where=="���޺����޺�" or job.where=="��ľ��" or job.where=="��ѩɽ���ö�¥" 
    or job.where=="��ѩɽ���ȷ���" or job.where=="���޺�ʯ��" or job.where=="���޺����߻�·" 
    or job.where=="���޺�����" or job.where=="���޺����¶���" or job.where=="���޺�С·" 
    or job.where=="���޺����¶�" or job.where=="���޺�ɽǰ�ĵ�"  or job.where=="����������"  
    or job.where=="���޺�ɽ��" or job.where=="������" or job.where=="���޺�ɽʯ"
    or job.where=="���޺�ҩ®") and hp.exp<2000000 then
       job.where="��Σ�ղ�ȥ"
       print(job.where)
    end
	
    if WhereIgnores[job.where] or AddrIgnoresSongJian[job.area]  or not job.room or not path_cal() then
       messageShow('�������ͣ��ص㡾'..job.where..'�����ɵ�����������')
       return check_bei(zhujianFangqi)
    end
    messageShow('�������ͣ�ǰ����'..job.where..'����')
    return check_bei(zhujianFind)
end
function zhujianConsiderT(n,l,w)
    messageShow('�������ͣ���ʼ��')
    job.last='zhujian'
    job.target=tostring(w[3])
    job.where=tostring(w[2])
	
	
	
    if string.find(job.where,"��Χ") then
        local l_cnt = string.find(job.where,"��Χ")
        job.where=string.sub(job.where,1,l_cnt-1)
    end
    
    job.room,job.area=getAddr(job.where)
    if type(job.room)=="string" and string.find(job.room,"����") then
        job.room="��ɼ��"
    end

	if (job.where=="���޺����޺�" or job.where=="��ľ��" or job.where=="��ѩɽ���ö�¥" 
    or job.where=="��ѩɽ���ȷ���" or job.where=="���޺�ʯ��" or job.where=="���޺����߻�·" 
    or job.where=="���޺�����" or job.where=="���޺����¶���" or job.where=="���޺�С·" 
    or job.where=="���޺����¶�" or job.where=="���޺�ɽǰ�ĵ�"  or job.where=="����������"  
    or job.where=="���޺�ɽ��" or job.where=="������" or job.where=="���޺�ɽʯ"
    or job.where=="���޺�ҩ®") and hp.exp<2000000 then
       job.where="��Σ�ղ�ȥ"
       print(job.where)
    end
	
    if WhereIgnores[job.where] or AddrIgnoresSongJian[job.area]  or not job.room or not path_cal() then
       messageShow('�������ͣ��ص㡾'..job.where..'�����ɵ�����������')
       return check_bei(zhujianFangqi)
    end
    messageShow('�������ͣ�ǰ����'..job.where..'����')
    return check_bei(zhujianFind)
end

function zhujianFangqiGo()
    go(zhujianFangqi,'���ݳ�','������')
end
function zhujianFangqi()
    EnableTriggerGroup("zhujianAccept",false)
    check_bei(zhujianFangqiAsk)
end
function zhujianFangqiAsk()
    EnableTriggerGroup("zhujianAsk",true)
    exe('ask zhujian shi about ����')
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
    messageShow('�������ͣ���ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
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
       messageShow('�������ͣ��͵�'..'��'.. job.target ..'����')
    end
end
function zhujianBackGet()
    return go(zhujianFinishWait,'���ݳ�','������')
end
function zhujianFinishWait()
    if locl.id["����ʦ"] then
        EnableTriggerGroup("zhujianFinish",true)
        EnableTriggerGroup("zhujianQuest",true)
        return check_busy(zhujianFinishAsk)
    else
       return go(zhujianFinishWait,'���ݳ�','������')
    end
end
function zhujianFinishAsk()
    exe('ask zhujian shi about ���')
end
function zhujianFinishT()
    job.last="zhujian"
    job.zjtime=0
    EnableTriggerGroup("zhujianFinish",false)
    return check_heal(zhujian)
end
function zhujianQuest()
    exe('set �˶ν�')
end
function zhujianFinish()
    job.last="zhujianfail"
    EnableTriggerGroup("zhujianFinish",false)
    wait.make(function()
         wait.time(5)
	 zhujian()
    end)
end