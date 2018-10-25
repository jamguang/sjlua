--�䵱����ͭ��
job.list = job.list or {}
job.list["kanshou"] = function() if score.party and score.party == "�䵱��" then return "�䵱����ͭ��" else return false end end
joblast = joblast or {}
joblast["����ͭ��"]   = "kanshou"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["kanshou"] = "kanshou_triggerDel"

	  
function kanshou_trigger()
    DeleteTriggerGroup("kanshou_task")
	create_trigger_t('kanshou_task1',"^(> )*ֻ�����ѡ���һ�����죬һ��(\\D*)���Ŷ��룬���㷢�����ҵĹ�����",'','kanshouAttack')
    create_trigger_t('kanshou_task2',"^(> )*��˴ο��ع��õ�",'','kanshouOver')
	create_trigger_t('kanshou_task3',"^(> )*����æ�������������ء�",'','kanshouBusy')
	create_trigger_t('kanshou_task4',"^(> )*(���뿴��ͭ����¯��|�����ڿ���ͭ����)",'','kanshouTimer')
	SetTriggerOption("kanshou_task1","group","kanshou_task")
	SetTriggerOption("kanshou_task2","group","kanshou_task")
	SetTriggerOption("kanshou_task3","group","kanshou_task")
	SetTriggerOption("kanshou_task4","group","kanshou_task")
	EnableTriggerGroup("kanshou_task",false)
end
function kanshou_triggerDel()
    DeleteTriggerGroup("kanshou_task")
end
function kanshou()
    kanshou_trigger()
    job.name='kanshou'
    job.time.b=os.time()
    job.flag()
    job.target='����Ŀ��'
	if jobtimes and jobtimes["�䵱����ͭ��"] and jobtimes["�䵱����ͭ��"] > 400 then
	    exe('pray pearl')
	end
    return go(kanshouStart,'�䵱ɽ','������')
end
function kanshouStart()
    if locl.room ~= '������' then
	    return go(kanshouStart,'�䵱ɽ','������')
	end
	fight_prepare()
	return check_bei(kanshouAct)
end
function kanshouAct()
    EnableTriggerGroup("kanshou_task",true)
    exe('kanshou')
end
function kanshouAttack()
    dis_all()
	--fight_prepare()
	create_timer_s('kans',20,'kanshouWait')
end
function kanshouTimer()
    create_timer_s('kans',2,'kanshouWait')
end
function kanshouWait()
    EnableTimer("kans",false)
	DeleteTimer("kans")
	exe('hp')
	create_timer_s('kanc',20,'kanshouCheck')
	exe('unset ����')
	if hp.neili < hp.neili_max*1.5 or hp.neili_max < hp.neili_lim-10 then
	   exe('yun qi;dazuo '.. hp.dazuo)
	end
    return check_bei(kanshouCheck,1)
end
function kanshouCheck()
    EnableTimer("kanc",false)
	DeleteTimer("kanc")
    flag.idle = 0
	if hp.jingli_max < hp.jingli_lim then
	   exe('unset ����')
	   exe('yun jing;tuna '.. hp.jingxue/4)
    end	
	return check_busy(kanshouAct)
end
function kanshouOver()
    EnableTriggerGroup("kanshou_task",false)
	EnableTimer("kans",false)
	DeleteTimer("kans")
	EnableTimer("kanc",false)
	DeleteTimer("kanc")
    return check_heal()
end
function kanshouBusy()
    EnableTriggerGroup("kanshou_task",false)
    return checkWait(kanshouAct,5)
end