--Ľ�ݽ���
jobSpecial = jobSpecial or {}
jobSpecial["jiaohua"] = true
job.list["jiaohua"] = function() if score.party and score.party == "����Ľ��" and hp.exp and hp.exp < 1000000 then return "Ľ�ݽ���" else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["jiaohua"] = "jiaohuaTriggerDel"

local l_haoke

function jiaohuaTrigger()
    DeleteTriggerGroup("jiaohuaAsk")
    create_trigger_t('jiaohuaAsk1',"^(> )*���������˴����йء�job������Ϣ��",'','jiaohuaAccept')
    create_trigger_t('jiaohuaAsk2',"^(> )*����û������ˡ�$",'','jiaohuaNobody')
	SetTriggerOption("jiaohuaAsk1","group","jiaohuaAsk")
    SetTriggerOption("jiaohuaAsk2","group","jiaohuaAsk")
    EnableTriggerGroup("jiaohuaAsk",false)
    DeleteTriggerGroup("jiaohuaAccept")
    create_trigger_t('jiaohuaAccept1',"^(> )*������˵��\\D*�軨������Ĳ�ʢ���úú�����һ���ˣ���ȥ�������ţ��������Ű�",'','jiaohuaGo')
    create_trigger_t('jiaohuaAccept2',"^(> )*������˵�������㲻���Ѿ����˹���ô��������ȥ������",'','jiaohuaGo')
    create_trigger_t('jiaohuaAccept3',"^(> )*������˵���������������ݣ����һ�������ɡ���",'','jiaohuaBusy')
    SetTriggerOption("jiaohuaAccept1","group","jiaohuaAccept")
    SetTriggerOption("jiaohuaAccept2","group","jiaohuaAccept")
    SetTriggerOption("jiaohuaAccept3","group","jiaohuaAccept")
    EnableTriggerGroup("jiaohuaAccept",false)
	DeleteTriggerGroup("jiaohuaJiao")
    create_trigger_t('jiaohuaJiao1',"^(> )*��������æ���أ�",'','jiaohuaCon')
    create_trigger_t('jiaohuaJiao2',"^(> )*���Ѿ������ˣ��������������ѻ�����ѽ��",'','jiaohuaBack')
    create_trigger_t('jiaohuaJiao3',"^(> )*������ս���У��޷�ר�ĸɻ",'','jiaohuaCon')
	create_trigger_t('jiaohuaJiao4',"^(> )*�㻹û��ȥҪ���ߣ���ô�ɻ�ѽ��",'','jiaohua')
    create_trigger_t('jiaohuaJiao5',"^(> )*������ʲô��������������",'','jiaohua')
    create_trigger_t('jiaohuaJiao6',"^(> )*���������Ľ�������Ȼһ���������ʹ��˽�����һ���������ˮư",'','jiaohuaKill')
	create_trigger_t('jiaohuaJiao7',"^(> )*�����ˮ�Ѿ����Ĳ���ˣ����Ի�ȥ�����ˡ�",'','jiaohuaBack')
	create_trigger_t('jiaohuaJiao8',"^(> )*���ˮ����Ҩ��ưˮ��С������İ�ˮ����",'','jiaohuaCon')
	create_trigger_t('jiaohuaJiao9',"^(> )*�������͡�ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�",'','jiaohuaGet')
    SetTriggerOption("jiaohuaJiao1","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao2","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao3","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao4","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao5","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao6","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao7","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao8","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao9","group","jiaohuaJiao")
    EnableTriggerGroup("jiaohuaJiao",false)
	--ͻȻһ���Ҷ����˳����������ȵ�������ô������������ȡ���ˡ�
end
function jiaohuaTriggerDel()
    DeleteTriggerGroup("jiaohuaAsk")
    DeleteTriggerGroup("jiaohuaAccept")
    DeleteTriggerGroup("jiaohuaJiao")
end
function jiaohuaNobody()
    EnableTriggerGroup("jiaohuaAsk",false)
    return jiaohuaBusy()
end
function jiaohuaBusy()
    EnableTriggerGroup("jiaohuaAsk",false)
	EnableTriggerGroup("jiaohuaAccept",false)
	return prepare_lianxi(jiaohua)
end
function jiaohua()
    jiaohuaTrigger()
    job.name='jiaohua'
    job.time.b=os.time()
	locate()
	return prepare_lianxi(jiaohuaStart)
end
function jiaohuaStart()
	return go(jiaohuaAsk,"��٢��ɽׯ","�ƽ�¥")
end
function jiaohuaAsk()
    if not locl.id["������"] then
	   return jiaohuaBusy()
	else
	   EnableTriggerGroup("jiaohuaAsk",true)
	   exe("ask wang furen about job")
	end
end
function jiaohuaAccept()
    EnableTriggerGroup("jiaohuaAsk",false)
	EnableTriggerGroup("jiaohuaAccept",true)
end
function jiaohuaGo()
    EnableTriggerGroup("jiaohuaAccept",false)
	return check_bei(jiaohuaYan)
end
function jiaohuaYan()
    exe('s;w')
    return jiaohuaYanAsk()
end
function jiaohuaYanAsk()
	exe('ask yan mama about ����')
	return check_bei(jiaohuaCong)
end
function jiaohuaCong()
    exe('e;#4n;#6w')
	--exe('wield piao')
	locate()
	checkBags()
	return checkWait(jiaohuaPre,1)
end
function jiaohuaPre()
	fight_prepare()
	return check_bei(jiaohuaCongCheck)
end
function jiaohuaCongCheck()
    if locl.room ~= '������' then
	   return jiaohua()
	end
	if not Bag["ư"] then
	   return jiaohua()
	end
	road.id = "mr/mtl/hc3"
	return jiaohuaJiao()
end
function jiaohuaJiao()
	EnableTriggerGroup("jiaohuaJiao",true)
	exe('wield piao')
	exe('yun qi;yun jingli;jiaoshui')
end
function jiaohuaCon()
    --EnableTriggerGroup("jiaohuaJiao",false)
    if not l_haoke then
	   return check_bei(jiaohuaJiao)
    else
	   return checkWait(jiaohuaJiao,5)
	end
end
function jiaohuaKill()
    --EnableTriggerGroup("jiaohuaJiao",false)
	l_haoke = true
	exe('set wimpy 100')
	exe("pfmpfm")
end
function jiaohuaGet()
    l_haoke = nil
    for i = 1,3 do
	    exe('get piao from corpse '.. i)
		exe('get silver from corpse '.. i)
	end
	exe('wield piao')
	return check_bei(jiaohuaJiao)
end
function jiaohuaBack()
    EnableTriggerGroup("jiaohuaJiao",false)
	return go(jiaohuaFinish,'��٢��ɽׯ','���ʷ�')
end
function jiaohuaFinish()
    exe('give piao to yan mama')
	exe('drop piao 2')
	exe('e;n')
	exe('ask wang furen about ok')
	exe('hp;cha;score')
	return check_heal()
end