--ȫ��������Ĺ�մ�

job.list = job.list or {}
job.list["shouwei"] = function() if score.party and score.party=="ȫ���" and hp.exp>200000 then return "������Ĺ" else return false end end
joblast = joblast or {}
joblast["������Ĺ"]   = "shouwei"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["shouwei"] = "shouwei_triggerDel"

function shouwei_trigger()
    DeleteTriggerGroup("shouweiask")
    create_trigger_t('shouweiask1',"^(> )*������־ƽ�����йء�������Ĺ",'','shouweiConsider')
    create_trigger_t('shouweiask2',"^(> )*����û������ˡ�$",'','shouweiNobody')
    SetTriggerOption("shouweiask1","group","shouweiask")    
	SetTriggerOption("shouweiask2","group","shouweiask")
    EnableTriggerGroup("shouweiask",false)	
    DeleteTriggerGroup("shouweiAccept")
    create_trigger_t('shouweiAccept1',"^(> )*��־ƽ˵������"..score.name..",����������Ϣ����һ��������ʿ��������ɽ���¼��ᡣ��",'','shouweiJJ')
	create_trigger_t('shouweiAccept2',"^(> )*��־ƽ˵������"..score.name..",����������æ�У���������Ϣһ��ɡ���",'','shouweiBusy')
    create_trigger_t('shouweiAccept3',"^(> )*��־ƽ˵������"..score.name..",����һ������û����ء���",'','shouweifangqi')
	create_trigger_t('shouweiAccept4',"^(> )*��־ƽ˵������"..score.name..",��ս���������Ĺ����������Ϣһ��ɡ���",'','shouweiBusy')
	create_trigger_t('shouweiAccept5',"^(> )*��־ƽ˵�������Ҳ�������ȥɱ",'','shouweifangqi')
	SetTriggerOption("shouweiAccept1","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept2","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept3","group","shouweiAccept")
	SetTriggerOption("shouweiAccept4","group","shouweiAccept") 
	SetTriggerOption("shouweiAccept5","group","shouweiAccept") 
    EnableTriggerGroup("shouweiAccept",false)
    DeleteTriggerGroup("shouwei_task")
	create_trigger_t('shouwei_task1',"^(> )*һ��"..score.name.."��Ҫ׷�õ�(\\D*)�����Ƶ����˹����������ڴ��������������㷢�����ҵĹ�����",'','shouweiGetTaget')	
    create_trigger_t('shouwei_task2',"^(> )*��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����",'','shouweiCut')
	create_trigger_t('shouwei_task3',"^(> )*����һ�����ȣ����ڵ��ϻ��˹�ȥ��",'','shouweiAttack')
	SetTriggerOption("shouwei_task1","group","shouwei_task")
	SetTriggerOption("shouwei_task2","group","shouwei_task")
	SetTriggerOption("shouwei_task3","group","shouwei_task")
	EnableTriggerGroup("shouwei_task",false)	
    DeleteTriggerGroup("shouwei_Finish")
	create_trigger_t('shouwei_Finish1',"^(> )*��־ƽ˵�������ܺã�"..score.name.."����Ȼ�������������ɱ�ˣ��Ҿ͸�����¾�Ǯ����",'','shouweiOver')
	create_trigger_t('shouwei_Finish2',"^(> )*��˴ο��ع��õ�(\\D*)�㾭�飬(\\D*)��Ǳ��",'','shouweiExp')
	SetTriggerOption("shouwei_Finish1","group","shouwei_finish")
	SetTriggerOption("shouwei_Finish2","group","shouwei_finish")
	EnableTriggerGroup("shouwei_Finish",false)
	DeleteTriggerGroup("shouweiCut")
	create_trigger_t('shouweiCut1','^(> )*ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն���������������С�','','shouweiCutCon')
	create_trigger_t('shouweiCut2','^(> )*����ü����������߲���������ʬ���ͷ����','','shouweiCut')
	SetTriggerOption("shouweiCut1","group","shouweiCut")
	SetTriggerOption("shouweiCut2","group","shouweiCut")
	EnableTriggerGroup("shouweiCut",false)
end
function shouwei_triggerDel()
	EnableTriggerGroup("shouwei_task",false)
    EnableTriggerGroup("shouweiAccept",false)
    EnableTriggerGroup("shouweiask",false)
    EnableTriggerGroup("shouweiCut",false)
	EnableTriggerGroup("shouwei_Finish",false)
	EnableTriggerGroup("shouwei2_kill",false)
    DeleteTriggerGroup("shouwei_task")
	DeleteTriggerGroup("shouweiAccept")
	DeleteTriggerGroup("shouweiask")
	DeleteTriggerGroup("shouweiCut")
	DeleteTriggerGroup("shouwei2_kill")
	DeleteTriggerGroup("shouwei_Finish")
end
function shouweifangqi()
	return check_bei(shouweifangqi2,1)
end
function shouweifangqi2()
	exe('ask yin zhiping about ����')
	return check_bei(check_heal,1)
end 
function shouwei()
    shouwei_trigger()
    job.name='shouwei'
    job.time.b=os.time()
    job.flag()
	exe('hp')	
	flag.idle=0
	return prepare_lianxi(shouweiGO)
end

function shouweiGO()
    return go(shouweiStart,'ȫ��','�̱�')
end
function shouweiStart()
	if locl.room ~= '�̱�' then
	    return check_busy(shouweiGO)
	end
	checkWield()
	--exe("bai yin zhiping")
	return prepare_neili(shouweiAsk)
end
function shouweiBusy()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiask",false)
	job.last="shouwei"
    return check_bei(check_heal,1)
end
function shouweiAsk()
    EnableTriggerGroup("shouweiask",true)
	EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouwei_task",false) 
	exe('ask yin zhiping about ������Ĺ')	
end

function shouweiNobody()
    EnableTriggerGroup("shouweiask",false)
    return prepare_neili(shouweiStart)   
end

function shouweiConsider()
    EnableTriggerGroup("shouweiask",false)
	EnableTriggerGroup("shouweiAccept",true) 
end

function shouweiJJ()
	messageShow('ȫ��������Ĺ��������ʼ��')
	return go(shouweiSW,'����ɽ','ɽ·')
end
function shouweiSW()
	if not locl.room=='ɽ·' then
		return shouweiJJ()
	end
	fight_prepare()
	exe('eu')
	messageShow('ȫ��������Ĺ�������Ѿ����ˣ���ʼ����, ʲôɦ���� ʲô ������ �����ǲ��µ�')
	exe('shouwei')
	--fight_prepare()
	EnableTriggerGroup("shouwei_task",true)
end
function shouwei_two(n,l,w)	
	job.target=tostring(Trim(w[2]))
    messageShow('ȫ��������Ĺ��ɱ��ı '..job.target)
	--printTab(itemWield)
	weapon_unwield()
	weapon_wield()
    job.id=get_id(job.target)
	if GetVariable("flagshouwei2") and GetVariable("flagshouwei2") == "yes" then
        exe('answer yes')
	    messageShow('ȫ��������Ĺ������ȥɱ��ı '..job.target)
	    DeleteTriggerGroup("shouwei2_kill")
	    create_trigger_t('shouwei2_kill_1',"^(> )*"..job.target.."��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����",'','shouweiCut')
	    SetTriggerOption("shouwei2_kill_1","group","shouwei2_kill")
	    EnableTriggerGroup("shouwei2_kill",true)
	    return go(shouwei_twokill,'quanzhen/shijie2')
    end
	exe('answer no')
	messageShow('ȫ��������Ĺ������ ɱ��ı '..job.target)
    return check_bei(check_heal)
end
function goshouwei2()
	exe('w;nd;wd;nw')
	exe('say ����ʯ�� �� '..job.target)
	messageShow('ȫ��������Ĺ: ����ʯ�� �� '..job.target)
end
function shouwei_twokill()
    exe('say ����ʯ�� �� '..job.target)
	messageShow('ȫ��������Ĺ: ����ʯ�� �� '..job.target)
    EnableTriggerGroup("shouweiCut",true)
    exe('set wimpy 100;follow '..job.id)
    exe('kill '..job.id)
end
function shouweiGetTaget(n,l,w)
	job.target=tostring(w[2])
	EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	exe('look attacker')
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiGetTagetKill()
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiAttack()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweiAttack2()
    EnableTriggerGroup("shouweiAccept",false)
	EnableTriggerGroup("shouweiCut",true)
	create_timer_s('shouwei_kill',3,'shouweijobkilltime')
end
function shouweijobkilltime()
	exe('kill attacker;qie corpse')	
end
function shouweiCutWeapon()
    EnableTriggerGroup("shouweiCut",false)
    weapon_unwield()
    weaponWieldCut()
end
function shouweiCutCon()
	EnableTimer('shouwei_kill',false)
	DeleteTimer('shouwei_kill')	
	EnableTriggerGroup("shouweiCut",false)
	dis_all()
	EnableTriggerGroup("shouwei_Finish",true)
	--exe('unwield mu jian;')
	DeleteTimer("shouwei")
	DeleteTimer("perform")
	messageShow('ȫ��������Ĺ���Ѿ��ɵ� ����')
    job.target='��Ĺ1'
	return check_busy(shouweiBack,2)
end

function shouweiCut()
    return check_busy(shouweiCutAct,1)
end
function shouweiCutAct()
	EnableTriggerGroup("shouweiCut",true)
	weapon_unwield()
    weaponWieldCut()
	for i=1,3 do
        exe('qie corpse '..i)    
    end	
end

function shouweiExp(n,l,w)   
    messageShow('ȫ��������Ĺ��������þ���:��'.. w[2] ..'���㣬Ǳ��:��'.. w[3] ..'���㣡')
	EnableTriggerGroup("shouwei_task",false) 
	exe('unset env_msg') 
    exe('say �մ����մ�~��ʲôʱ��~~')
end
function shouweiBack()
    DeleteTimer("shouwei")
    DeleteTimer("perform")	
	EnableTriggerGroup("shouweiCut",false)
    EnableTriggerGroup("shouwei_Finish",true)
	DeleteTriggerGroup("shouwei2_task")
	create_trigger_t('shouwei2_task1','^(> )*��־ƽ�������С��˵�����������Ѿ����ˣ��˴�����Ϯ���������������(\\D*)���������','','shouwei_two')
	SetTriggerOption("shouwei2_task1","group","shouwei2_task")
    messageShow('ȫ��������Ĺ���㶨�ˣ�������')
    --exe('say ȫ���������㶨�ˣ�������')
	--weapon_unwield()
	--weapon_wield()
	--checkWield()
	exe('leavefb')
    return go(shouweiHead,'ȫ��','�̱�')
end
function shouweiHead()
	exe('give shouji to yin zhiping')
	return check_bei(shouweiOver,1)
end
function shouweiOver()
    messageShow('ȫ��������Ĺ����Ĺ���� 1 ������')
	--printTab(itemWield)
	weapon_unwield()
	weapon_wield()
    if not GetVariable("flagshouwei2") or GetVariable("flagshouwei2")=="no" then
		messageShow('ȫ��������Ĺ����ı�ر��� ��ɱ��ı')
		exe('answer no')
		job.last="shouwei"
		return check_bei(check_heal)
	end
    
	return check_bei(check_heal)
end