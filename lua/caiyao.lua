--ȫ���ҩ
jobSpecial = jobSpecial or {}
jobSpecial["caiyao"] = true 
job.list = job.list or {}
job.list["caiyao"] =function() if score.party and score.party=="ȫ���" and hp.exp<200000 then return "ȫ���ҩ" else return false end end
joblast = joblast or {}
joblast["ȫ���ҩ"]   = "caiyao"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["caiyao"] = "caiyaoTriggerdel"

function caiyao()
    flag.idle=0				
	job.prossce=0
	i=0
    caiyaoTrigger()
    job.name="caiyao"
    job.time.b=os.time()
	if condition["����æ״̬"] and condition["����æ״̬"] > 10 then
	    return go(caiyaoDazuo,"ȫ��","������")
	end
    return check_busy(caiyaoGo)
end
function caiyaoGo()
	messageShow('ȫ���ҩ������ʼ��')
    return go(caiyaoStart,"ȫ��","����һ��")      
end
function caiyaoStart() 
    return check_busy(caiyaoStart1)
end
function caiyaoStart1()
    EnableTriggerGroup("caiyaoask",true)
    return exe('ask lu about ��ҩ')
end
function caiyaoBusy()
    EnableTriggerGroup("caiyaoAccept",false)
	messageShow('ȫ���ҩ��æµ�У������ɣ�')
	condition = {}
	exe("unset ����")
	exe("cond")
	return go(caiyaoDazuo,"ȫ��","������")
end
function caiyaoDazuo()
    if not condition["����æ״̬"] or condition["����æ״̬"] == 0 then
	    exe("yun qi;yun jing;yun jingli")
	    return caiyaoGo()
	end
	condition = {}
	exe("unset ����")
	exe("cond")
	if perform.force and skills[perform.force] and skills[perform.force].lvl>100 then
	    exe("yun qi")
	end
	if hp.neili_lim - hp.neili_max < 10 and hp.neili > hp.neili_max then
	    exe("yun jing;tuna "..hp.jingxue)
	else
	    exe("yun jing;dazuo "..hp.dazuo)
	end
	exe("hp")
	return check_bei(caiyaoDazuo,1)
end

function caiyaoTrigger()
    DeleteTriggerGroup("caiyaoask")
    create_trigger_t('caiyaoask1',"^(> )*����¹���ƴ����йء���ҩ",'','caiyaoConsider')
    create_trigger_t('caiyaoask2',"^(> )*����û������ˡ�$",'','caiyaoNobody')
    SetTriggerOption("caiyaoask1","group","caiyaoask")    
	SetTriggerOption("caiyaoask2","group","caiyaoask")
    EnableTriggerGroup("caiyaoask",false)
    DeleteTriggerGroup("caiyaoAccept")
    create_trigger_t('caiyaoAccept1',"^(> )*¹���ƶ�(��|"..score.name..")˵��(\\D*)����������",'','caiyaogo')
	create_trigger_t('caiyaoAccept2',"^(> )*¹����(����|)˵������(\\D*)�Ҳ��ǰ�����ȥ��ҩȥ��ô���ǲ���͵����",'','caiyaogo')
	create_trigger_t('caiyaoAccept3',"^(> )*¹����(����|)˵������(\\D*)�����ڹ���æµ�У���������",'','caiyaoBusy')
    SetTriggerOption("caiyaoAccept1","group","caiyaoAccept") 
	SetTriggerOption("caiyaoAccept2","group","caiyaoAccept") 
	SetTriggerOption("caiyaoAccept3","group","caiyaoAccept")
    EnableTriggerGroup("caiyaoAccept",false)
	DeleteTriggerGroup("caiyaoChutou")
    create_trigger_t('caiyaoChutou1',"^(> )*������������һ����ҩר�õ�ҩ��",'','caiyaoChutou2')
	create_trigger_t('caiyaoChutou3',"^(> )*������˵�������㲻�������𣬻���Ҫʲ�᣿��",'','caiyaoChutou2')
    SetTriggerOption("caiyaoChutou1","group","caiyaoChutou") 
	SetTriggerOption("caiyaoChutou3","group","caiyaoChutou") 
    EnableTriggerGroup("caiyaoChutou",false)
    DeleteTriggerGroup("caiyao_task")
	create_trigger_t('caiyao_task1',"^(> )*����ҩ�����ϵĲ��������ܵ�ɽ�ݣ���Ȼ�����Ӳ�֮����һ���ر�Ĳ�",'','caiyaoAttack')	
    create_trigger_t('caiyao_task2',"^(> )*����ҩ�����������ܵĹ�ľ�Ӳݣ���ϸ�ؿ���û�в�ҩ",'','caiyaoCyao5')
	create_trigger_t('caiyao_task3',"^(> )*��̫���ˣ���ЪϢһ�����",'','caiyaowait')
	create_trigger_t('caiyao_task4',"^(> )*¹��������˦��"..score.name,'','caiyaoOk')
	create_trigger_t('caiyao_task5',"^(> )*��û�й��ߣ��޷�������ľɽ��Ѱ�Ҳ�ҩ",'','caiyaoExp')
	create_trigger_t('caiyao_task6',"^(> )*������ܵĹ�ľ�Ӳݶ������ˣ�����û����ʲô����������ûָ��",'','caiyaoAgain')
	create_trigger_t('caiyao_task7',"^(> )*ͻȻ�Ӳݴ���",'','caiyaoKill')
	create_trigger_t('caiyao_task8',"^(> )*���¹����",'','caiyaoOk')
	create_trigger_t('caiyao_task9',"^(> )*���˷ܹ��ȣ���ҩ��һ˦�������°�һ����ҩ����Ϊ���أ�",'','caiyaoCyaox2')
	SetTriggerOption("caiyao_task1","group","caiyao_task")
	SetTriggerOption("caiyao_task2","group","caiyao_task")
	SetTriggerOption("caiyao_task3","group","caiyao_task")
	SetTriggerOption("caiyao_task4","group","caiyao_task")
	SetTriggerOption("caiyao_task5","group","caiyao_task")
	SetTriggerOption("caiyao_task6","group","caiyao_task")
	SetTriggerOption("caiyao_task7","group","caiyao_task")	
	SetTriggerOption("caiyao_task8","group","caiyao_task")	
	SetTriggerOption("caiyao_task9","group","caiyao_task")	
	EnableTriggerGroup("caiyao_task",false)
	DeleteTriggerGroup("caiyaoKill")
	create_trigger_t('caiyaoKill1',"^(> )*(\\D*)(��ҵĺ��˼���|�Һ�һ�������ˣ�)",'','caiyaoJixu')	
    create_trigger_t('caiyaoKill3',"^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��",'','caiyaoKill')
    create_trigger_t('caiyaoKill2',"^(> )*(\\D*)��ž����һ�����ڵ���",'','caiyaoJixu')
    SetTriggerOption("caiyaoKill1","group","caiyaoKill")
	SetTriggerOption("caiyaoKill2","group","caiyaoKill")
	SetTriggerOption("caiyaoKill3","group","caiyaoKill")	
	EnableTriggerGroup("caiyaoKill",false)
end
function caiyaoTriggerdel()
    EnableTriggerGroup("caiyaoask",false)
	EnableTriggerGroup("caiyaoAccept",false)   
	EnableTriggerGroup("caiyao_task",false)
	EnableTriggerGroup("caiyaoChutou",false)
	EnableTriggerGroup("caiyaoKill",false)
	DeleteTriggerGroup("caiyaoask")
	DeleteTriggerGroup("caiyaoAccept")
	DeleteTriggerGroup("caiyaoChutou")
	DeleteTriggerGroup("caiyao_task")
	DeleteTriggerGroup("caiyaoKill")
end
function caiyaoConsider()
    EnableTriggerGroup("caiyaoask",false)
	EnableTriggerGroup("caiyaoAccept",true)   
end
function caiyaogo()
    return go(caiyaoChutou,"��Ĺ","����")	
end
function caiyaoChutou()
    return check_busy(caiyaoChutou1)	
end
function caiyaoChutou()
    EnableTriggerGroup("caiyaoChutou",true)
    return exe('s;ask sun about ҩ��')	
end
function caiyaoChutou2()
	messageShow('ȫ���ҩ��ҩ���õ���')
    EnableTriggerGroup("caiyaoChutou",false)	
    return go(caiyaoCyao,"����ɽ","������")	
end
function caiyaoCyao()
	job.prossce=0
	i=0
	EnableTriggerGroup("caiyao_task",true)
    exe('e;s')
    return check_busy(caiyaoCyao2)	
end
function caiyaoCyao1()
    if job.prossce==1 then
        return check_busy(caiyaoCyaox)	
    else
        return check_busy(caiyaoCyao5)
    end
end
function caiyaoAttack()
    job.prossce=1	
	dis_all()
	EnableTriggerGroup("caiyao_task",true)
	checkBags()
	return check_busy(caiyaoCyaox)
end
function caiyaoCyao2()
    i=i+1
    return check_busy(caiyaoCyao4)
end
function caiyaoCyao3()
    i=0
    exe('s')
    return caiyaoCyao2()
end
function caiyaoCyao4()
    exe('yun jing;search;hp')
end

function caiyaoCyao5()
    if i<5 then 
        return check_busy(caiyaoCyao2)
    else 
	    return check_busy(caiyaoCyao3)
    end
end
function caiyaoCyaox()
    exe('wa ҩ��;hp')
	messageShow('ȫ���ҩ���ڳ��Ⱥ�һ�ã�')
	return check_busy(caiyaoCyaox1,1)
end
function caiyaoCyaox2()
	EnableTriggerGroup("caiyao_task",false)
	EnableTriggerGroup("caiyaoKill",false)
	EnableTrigger("caiyao_task3",true)
	EnableTrigger("caiyao_task4",true)
	EnableTrigger("caiyao_task8",true)
	messageShow('ȫ���ҩ����ȥ��ҩ')
	return check_busy(caiyaoCyaox1,1)
end
function caiyaowait()   
	return check_busy(caiyaoCyao4,10)
end
function caiyaoCyaox1()
    exe('w;n;n;n;n;n;n;w')
	return check_busy(caiyaoCyaoy)
end
function caiyaoAgain()   
    return check_busy(caiyaoAgain1)
end
function caiyaoAgain1()
    i=0
    exe('n;n;n;n;n;n;n;s')
    return caiyaoCyao2()
end
function caiyaoCyaoy()
    checkBags()
    return go(caiyaoOver,"ȫ��","����һ��") 
end
function caiyaoOver()
    if tmp.fuling and Bag["����"] then
	   return check_heal()
	end
    exe('give lu zi;give lu huang lian;give lu he;give lu chuan bei;give lu ju geng;give lu hua;give lu di')
	exe('give lu fu ling')
end
function caiyaoOk()
    caiyaoTriggerdel()
	messageShow('ȫ���ҩ��������ɣ�')
	exe("bai lu")
    return check_bei(check_heal,1) 
end
function caiyaoExp()
	messageShow('ȫ���ҩ��ҩ�����ˣ�')
    EnableTriggerGroup("caiyao_task",false)
    EnableTriggerGroup("caiyaoChutou",true)	
    exe('w;n;n;n;n;n;n;w')
	return check_bei(caiyaogo,1)
end
function caiyaoKill()
    dis_all()
	EnableTriggerGroup("caiyaoKill",true)
    exe('l;id here;kill bee;kill deer;kill monkey;kill ye tu;kill wuya;kill xiao baozi;')
end
function caiyaoJixu()
    EnableTriggerGroup("caiyao_task",true)
	EnableTriggerGroup("caiyaoKill",false)
    check_busy(caiyaoCyao2)
end