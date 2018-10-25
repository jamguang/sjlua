------���ְ�

job.list = job.list or {}
job.list["clb"] = "���ְ�����"
joblast = joblast or {}
joblast["���ְ�"]   = "clb"
jobFindAgain = jobFindAgain or {}
jobFindAgain["clb"] = "clbFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["clb"] = "clbFindFail"
faintFunc = faintFunc or {}
faintFunc["clb"] = "clbFindFail"

function clbTrigger()
	DeleteTriggerGroup("clbAsk")
    create_trigger_t('clbAsk1',"^(> )*���򱴺�ʯ�����й�",'','clbAsk')
    create_trigger_t('clbAsk2',"^(> )*����û������ˡ�$",'','clbNobody')
    SetTriggerOption("clbAsk1","group","clbAsk")
    SetTriggerOption("clbAsk2","group","clbAsk")
    EnableTriggerGroup("clbAsk",false)
    DeleteTriggerGroup("clbAccept")
    create_trigger_t('clbAccept1',"^(> )*����ʯ����Ķ�������˵�����ҽӵ��ɸ봫�飬(������|ʨ����|������|������|������)���°���(\\D*)��(\\D*)������Ϯ��",'','clbConsider')
    create_trigger_t('clbAccept2',"^(> )*����ʯ˵������(�㲻���Ѿ�֪����|���������Բ���|�㲻���Ѿ���չ|�Ҳ��Ǹ���������)",'','clbFangqi')
    create_trigger_t('clbAccept3',"^(> )*����ʯ˵������������곤�ְ�����",'','clbFail')
    create_trigger_t('clbAccept4',"^(> )*����ʯ˵������(�Ұ����ڱȽϿ���|����������û�и��������|��ʱû��������Ҫ��)",'','clbBusy')
    create_trigger_t('clbAccept5',"^(> )*����ʯ˵�������������(�Ͷ�����|��������)����",'','clbBusy')
    create_trigger_t('clbAccept6',"^(> )*����ʯ˵������������ʱû���ʺ���Ĺ���",'','clbBusy')
    create_trigger_t('clbAccept7',"^(> )*����ʯ˵��������ʱû��������Ҫ�������һ���������",'','clbBusy')
    create_trigger_t('clbAccept8',"^(> )*����ʯ˵��������Ȼ���޷����",'','clbFail')
    create_trigger_t('clbAccept9',"^(> )*����ʯ˵�������������û��������",'','clbFail')
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
    create_trigger_t('clbChakan1','^(> )*����ϸ�ز鿴','','clbBack')
	create_trigger_t('clbChakan2','^(> )*(\\D*)��ž����һ�����ڵ���','','clbDie')
	create_trigger_t('clbChakan3','^(> )*��� "action" �趨Ϊ "chakan" �ɹ���ɡ�$','','clbCkBack')
    SetTriggerOption("clbChakan1","group","clbChakan")
	SetTriggerOption("clbChakan2","group","clbChakan")
	SetTriggerOption("clbChakan3","group","clbChakan")
    EnableTriggerGroup("clbChakan",false)
    DeleteTriggerGroup("clbFinish")
    create_trigger_t('clbFinish1','^(> )*����ʯ˵������(�������û��������|��Ȼ�Ѿ�֪������|������ϧ�������д˼���|���ĺã���Щ����)','','clbFinish')
    create_trigger_t('clbFinish2',"^(> )*����ʯ˵��������������������",'','clbFangqi')
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
	messageShow('���ְ���������ʼ��')
    return clbGo()
end

function clbFindAgain()
    EnableTriggerGroup("clbFind",false)
    return go(clbFindAct,dest.area,dest.room)
end
function clbFindFail()
    EnableTriggerGroup("clbFind",false)
    return go(clbFangqi,"���ְ�","С��")
end
function clbGo()
    return go(clbStart,"���ְ�","С��")
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
       messageShow('���ְ���������ص㡾'..job.where..'�����ɵ�����������')
       return check_bei(clbFangqi)
    end
    messageShow('���ְ����񣺿�ʼǰ����'..job.where..'����')
	return check_bei(clbFind)
end
function clbFangqiGo()
    go(clbFangqi,'���ְ�','С��')
end
function clbFangqi()
    EnableTriggerGroup("clbAsk",true)
    EnableTriggerGroup("clbAccept",false)
    EnableTriggerGroup("clbFinish",false)
    check_bei(clbFangqiAsk)
end
function clbFangqiAsk()
    exe('ask bei haishi about ����')
end
function clbFind()
    DeleteTriggerGroup("clbFind")
    create_trigger_t('clbFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','clbTarget')
	create_trigger_t('clbFind2','^(> )*\\D*'..job.target..'��ʬ��\\((\\D*)\\)','','clbTarget')
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
	messageShow('���ְ����񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
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
	elseif locl.id[job.target ..'��ʬ��'] then
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
    return go(clbFinishWait,'���ְ�','С��')
end
function clbFinishWait()
	if locl.id["����ʯ"] then
	   EnableTriggerGroup("clbFinish",true)
	   exe('ask bei haishi about ���')
	else
	   return go(clbFinishWait,'���ְ�','С��')
	end
end
function clbFinish()
    EnableTriggerGroup("clbFinish",false)
	messageShow('���ְ��������������')
    return check_bei(check_heal)
end