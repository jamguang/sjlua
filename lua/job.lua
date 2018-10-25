job={}
job.time={}
job.time.b=os.time()
job.time.e=os.time()
job.time["refresh"]=94
job.name=nil
job.prepare=test
job.target='����Ŀ��'
job.exp=0
job.pot=0
job.guard={}
job.party='δ���'
job.zuhe={}
job.killer={}
job.list= job.list or {}
job.id = 'jobid'

require "hubiao"
require "shoumu"
require "husong"
require "wuguan"
require "jiaohua"
require "songshan"
require "quest"
require "xueshan"
require "songxin"
require "wudang"
require "huashan"
require "tdh"
require "smy"
require "clb"
require "kanshou"
require "tmonk"
require "gaibang"
require "zhuoshe"
require "sldsm"
require "fuxing"
require "zhujian"
require "was"
require "gmd"
require "caiyao"
require "shouwei"
require "qzjx"


gaibangCancel='����|��Ħ��|��Ҥ����|����|������|���ĵ�|�����|������|ժ����|ƮȻ��|��Ȼ��|ʨ����|����|���ƹ�|������'
sldsmCancel='��ľ��|���ĵ�|ִ�ڱ�|������|������|������|������|�����|����|��Ħ��|��Ҥ����|����|������|�����|������|ժ����|ƮȻ��|��Ȼ��|ʨ����|����|���ƹ�|������'
loseTj={}
loseTj.succ=0
loseTj.fail=0

--�����Ѷ�
jobLevel = {
   ["wdlvl"]    = 1000,
   ["sxlvl"]    = 1000,
   ["wudang"]   = 10,
   ["songxin"]  = 10,
   ["���뻯��"] = 7,
   ["��������"] = 6,
   ["��Ϊ�˵�"] = 5,
   ["������"] = 4,
   ["�ڻ��ͨ"] = 3,
   ["����ͨͨ"] = 2,
   ["΢�����"] = 1,
}    

tongji={}

skillIgnores = {
    ["���¾Ž�"] = true,
	["̫��ȭ"] = true,
	["����������"] = true,
--  ["��������"] = true,
--  ["�Ⱥ���"]   = true,
--	["��ɽ�ȷ�"] = true,
--  ["��������"] = true,
}

prepare_trigger=function()
    DeleteTriggerGroup("prepare_neili")
    create_trigger_t('prepare_neili1',"^(> )*(���ѽ�����Ȫ�ھ�������|�㽫�˶ν�����֮������������ʮ������|�㽫��ڤ��������������ʮ������|����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ��������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ������ȫ���泩|�㽫�����������ڣ���ȫ��ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����)",'','prepare_neili_b')
    create_trigger_t('prepare_neili2',"^(> )*(����ϥ�����������һ|��������һ�������뵤�Ȼ���ɵ�������|����ϥ������˫Ŀ���գ�������һ����|�����������޼��񹦣����۵���|�����󽣾�������������|����ϥ����������˻�����Ψ�Ҷ���|����������ͨ����Ƭ��֮��|�����������ϥ��������������|����ϥ���£�Ĭ����ħ��|������������������|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|�������廨�룬��ϥ���£�Ĭ�˿�����|�������������ù���һ����Ϣ��ʼ����������|��������ϥ������˫�ְ�����ǰ|���������죬�ų�һ�������Ϣ˳������������|����ϥ���£�˫�ֺ�ʮ����ͷ����Ǳ������|����Ϣ�������������������ִ�������֮��|����ϥ���£���Ŀ��ʲ��Ĭ�˿�������|����ϥ���£���Ŀ��ʲ������Ǭ��һ����|����ϥ���£�������������ͼ��ȡ���֮����|���������һ�����������۾���������Ů�ľ�|���������£�˫Ŀ΢�գ�˫���������������̫��|�����˵�������ڶ��������Ƴ����������������㻺��Ʈ��|����ϥ������˫�ִ�����ǰ�ɻ���״����������|����ϥ��������ʹ�����������³�|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|������һվ��˫�ֻ���̧������һ����|����ϥ������˫Ŀ���գ�������һ�������뵤��|��ϯ�ض������������죬���Ϻ��ʱ��ʱ��|�㰵���ټ�ʮ��ׯ�����۵���)",'','prepare_neili_t')
    create_trigger_t('prepare_neili3',"^(> )*���Ҳ���(����|����)����Ӱ�������Ϣ��",'','prepare_neili_w')
    create_trigger_t('prepare_neili4',"^(> )*(����Ҫ��������|���޷�������������|�㻹��ר�Ĺ����)",'','prepare_neili_w')
    create_trigger_t('prepare_neili5',"^(> )*���ﲻ׼ս����Ҳ��׼(����|����)��",'','prepare_neili_w')
    create_trigger_t('prepare_neili6',"^(> )*����ɲ����������(����|����)�ĵط���",'','prepare_neili_w')
    create_trigger_t('prepare_neili7',"^(> )*��������ϣ�����˫�ۣ�վ��������",'','prepare_neili_b')
    create_trigger_t('prepare_neili8',"^(> )*������۾���ʼ���ɡ�",'','prepare_neili_t')
	create_trigger_t('prepare_neili9',"^(> )*�������ֽŴ�����������������ȷ������������",'','prepare_neili_liaokao')
    SetTriggerOption("prepare_neili1","group","prepare_neili")
    SetTriggerOption("prepare_neili2","group","prepare_neili")
    SetTriggerOption("prepare_neili3","group","prepare_neili")
    SetTriggerOption("prepare_neili4","group","prepare_neili")
    SetTriggerOption("prepare_neili5","group","prepare_neili")
    SetTriggerOption("prepare_neili6","group","prepare_neili")
    SetTriggerOption("prepare_neili7","group","prepare_neili")
    SetTriggerOption("prepare_neili8","group","prepare_neili")
    SetTriggerOption("prepare_neili9","group","prepare_neili")
    EnableTriggerGroup("prepare_neili",false)
end
fight_trigger=function()
    DeleteTriggerGroup("fight")
    create_trigger_t('fight1',"^>*\\s*\\( (\\D*)(ҡͷ���ԡ�����бб��վ��վ���ȣ��ۿ���Ҫ���ڵ���|�Ѿ��˺����ۣ���������֧���Ų�����ȥ|�����൱�ص��ˣ�ֻ�»�������Σ��|�Ѿ�һ��ͷ�ؽ����ģ������������֧���Ų�����ȥ|��Ϣ���أ�������ʼɢ�ң��������ܵ�����ʵ����|�Ѿ�һ��ͷ�ؽ����ģ������������֧���Ų�����ȥ|�ƺ�ʮ��ƣ����������Ҫ�ú���Ϣ��|�������Ѿ�����������|�������꣬������״������̫��|�����ƺ���ʼ�е㲻̫��⣬������Ȼ��������|�������������˵�����|������������Щ����|���˼����ˣ������ƺ���������|���˲��ᣬ������״������̫��|�ƺ����˵����ˣ������������������|�ƺ���Щƣ����������Ȼʮ���л���|�Ѿ���������״̬����ʱ������ˤ����ȥ|���˹��أ��Ѿ�����һϢ�����ڵ�Ϧ��|���˹��أ��Ѿ�������в�����ʱ�����ܶ���)�� \\)",'','fight_check')    
    create_triggerex_lvl('fight2',"^(> )*�㡸ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����",'','fightDie',9)
	create_trigger_t('fight3',"^(> )*�㵱���������У��ò�ʹ�죡�������߶���Ȫ���ھ�����ʹ������Ȫ��������",'','fightlengquan')
    create_trigger_t('fight4',"^(> )*������(\\D*)��ɱ���㣡$",'','fightConsider')
    create_trigger_t('fight5',"^(��)(����������������|����̫����|��������̫��|���з�ţ�����ȫ����)",'','fight_check')
    create_trigger_t('fight8',"^(> )*̫���ߣ��޼���������֮��֣���֮��ϣ��������׼�����糵�֣�����\\D*����\\D*��(\\D*)һ�ͣ����������ȣ�ȫ��������մ�",'','fightLiuhe')
    create_trigger_t('fight9',"^(> )*��(�����ջ����������еĺ��|�����޷��չ�|����������һ����ͻȻ��������|����һ�ɣ���Ҳ֧�ֲ�)",'','yunWudiDone')
    create_trigger_t('fight10',"^(> )*��(�����е������������ͨ����ҽ�ս�޲�ʤ|�����Ľе������������ͨ����)",'','yunWudi')
    create_trigger_t('fight12',"^(��)(������̫���ˣ��޷�|��������̫��|Ŀǰ����̫��|������������)",'','fight_check')
	create_trigger_t('fight13',"^(> )*�����Ҫ��(\\D*)\\((\\w*)\\)�����ಫ������Ҳ���������һ�� kill ָ�",'','fightPk')
	create_trigger_t('fight14',"^(\\D*)(���Ͻ�ղ����������Ķ��𣬺���һײ|��������һ�ɷ���֮���������Ѳ���ȫ�������|��������һ�ɷ���֮���������ײ��|��������һ�ɷ���֮�������ȷ��𣬽������|ͻȻ�������Ǵ󷨣���ͻȻ����|���������У�ָ��һתֱ��|Ĭ����������ᣬ�����մ󽭡������������Ķ��������)",'','fightHitback')
	create_trigger_t('fight16',"^һ��ů�����Ե�������ȫ�����������ָֻ���֪������",'','faint_check')
    create_trigger_t('fight18',"^(> )*��(����ʹ�ý�|����������ô��|�������|����û��|������|������)",'','weapon_unwield')
	create_trigger_t('fight19',"^(> )*(����û������,���|�ȷ������е�����|ʹ�á�\\D*��ʱ˫�ֱ�����ţ�)",'','weapon_unwield')
    SetTriggerOption("fight1","group","fight")
    SetTriggerOption("fight2","group","fight")
    SetTriggerOption("fight3","group","fight")
    SetTriggerOption("fight4","group","fight")
    SetTriggerOption("fight5","group","fight")
    SetTriggerOption("fight6","group","fight")
    SetTriggerOption("fight7","group","fight")
    SetTriggerOption("fight8","group","fight")
    SetTriggerOption("fight9","group","fight")
    SetTriggerOption("fight10","group","fight")
    SetTriggerOption("fight11","group","fight")
    SetTriggerOption("fight12","group","fight")
	SetTriggerOption("fight13","group","fight")
	SetTriggerOption("fight14","group","fight")
    SetTriggerOption("fight16","group","fight")
    SetTriggerOption("fight18","group","fight")
	SetTriggerOption("fight19","group","fight")
    job_exp_trigger()
end

function yunWudiDone()
    flag.wudi=0
end
function yunWudi()
    flag.wudi=1
end

function fightPk(n,l,w)
    local l_name = w[2]
	local l_id = string.lower(w[3])
	messageShow('����'..l_name..':'..l_id..'�����PK!','red','white')
	if job.name ~= "hubiao" then
	    dis_all()
	    exe('follow '.. l_id)
	    wipe(l_id,check_heal)
	end
end
function fightLiuhe(n,l,w)
    local l_force=w[2]
    if string.len(l_force)<6 then return end
    if string.find("������|��Ԫ���ɷ�|������",w[2]) then
       exe('set ���Ͼ� ����')
    end
    if string.find("��������|���������|��󡹦",w[2]) then
       exe('set ���Ͼ� �귭')
    end
    if string.find("Ǭ��һ����|�׽|��������",w[2]) then
       exe('set ���Ͼ� ����')
    end
    if string.find("��Ԫ��|��ϼ��|ʥ����",w[2]) then
       exe('set ���Ͼ� ����')
    end
    if string.find("��Ů�ľ�|���վ�",w[2]) then
       exe('set ���Ͼ� ����')
    end
    if string.find("�ټ�ʮ��ׯ|��������|�����޼���|���칦|�̺�������",w[2]) then
       exe('set ���Ͼ� ����')
    end
end

function fightConsider(n,l,w)
    --if not (job.killer and job.killer[w[2]]) and not (road.wipe_who and road.wipe_who==w[2]) then
    --  exe(perform.huaxue)
    --end
end
function fightlengquan()
    tmp.lengquan = os.time()
end

function fightDie()
    scrLog()
    dis_all()
	flag.wxjz=0
    create_triggerex('die',"^(> )*������ - $",'','main')
end
function fightHitback(n,l,w)
    job.killer = job.killer or {}
	job.guard = job.guard or {}
	if job.killer[w[1]] or job.guard[w[1]] or (job.target and w[1]==job.target) then
	    exe('hp')
        return checkAW(fightHpCheck,0.2)
	end
end
function fight_check(n,l,w,styles)
    if w[1]=='��' then
       exe('hp')
       return checkAW(fightHpCheck,0.2)
    elseif job.name=="sldsm" and job.type and job.type=="zh" and w[1]==job.target then
       return sldsmZh(n,l,w,styles)
    end
end
function fightHpCheck()
	local l_flag = false
	local l_flagjing = false
	local l_flagjingli = false
	local l_flagneili = false
	local l_flagdan = false
    local performfight
	
	if (hp.qixue_per<70 or hp.jingxue_per<80) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 50) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 25) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if hp.neili<hp.neili_max*0.3 and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if hp.jingli<hp.jingli_max*0.2 and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if l_flagdan then
     	performfight="eat dan;"	
	end
    if hp.qixue<hp.qixue_max*0.7 then
	    l_flag = true
        if performfight then
		    performfight = performfight .. "yun qi;"
		else
		    performfight = "yun qi;"
		end
    end
    if hp.jingxue<hp.jingxue_max*0.5 then
	    l_flagjing = true
		if performfight then
		    performfight = performfight .. "yun jing;"
		else
		    performfight = "yun jing;"
		end
    end
	if hp.neili<hp.neili_max*0.5 and Bag["������Ϣ��"] then
	    l_flagneili = true
		if performfight then
		    performfight = performfight .. "eat ".. drug.neili .. ";"
		else
		    performfight = "eat ".. drug.neili .. ";"
		end
    end
	if hp.jingli<hp.jingli_max*0.7 then
	    l_flagjingli = true
		if performfight then
		    performfight = performfight .. "yun jingli;"
		else
		    performfight = "yun jingli;"
		end
    end
	if performfight then
	    perform.pre = performfight .. GetVariable("performpre")
	else
	    perform.pre = GetVariable("performpre")
	end
	if job.name == "smy" then
	    perform.pre = perform.pre .. ";kill wu shi"
	end
	create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
    exe('pfmset')
	if l_flagdan then exe('eat dan') end
	if l_flagneili then exe('eat '.. drug.neili) end
	if l_flag then exe('yun qi') end
	if l_flagjing then exe('yun jing') end
	if l_flagjingli then exe('yun jingli') end
	if performfight then	    
	    exe('hp')
        return checkAW(fightHpCheck,0.5)
	end
end
function nmHpCheck()
	local l_flag = false
	local l_flagjing = false
	local l_flagjingli = false
	local l_flagdan = false
	
	if (hp.qixue_per<70 or hp.jingxue_per<80) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 50) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 25) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if hp.neili<hp.neili_max*0.3 and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
	if hp.jingli<hp.jingli_max*0.2 and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    l_flagdan = true
    end
    if hp.qixue<hp.qixue_max*0.7 then
	    l_flag = true
    end
    if hp.jingxue<hp.jingxue_max*0.5 then
	    l_flagjing = true
    end
	if hp.jingli<hp.jingli_max*0.7 then
	    l_flagjingli = true
    end
	if l_flagdan then exe('eat dan') end
	if l_flag then exe('yun qi') end
	if l_flagjing then exe('yun jing') end
	if l_flagjingli then exe('yun jingli') end
end

faintFunc = faintFunc or {}
function faint_check()
    nmHpCheck()
	job.killer = {}
	tmp = {}
	faintFunc = faintFunc or {}
	for k,v in pairs(faintFunc) do
	    if job.name == k then
		   return _G[v]()
		end
	end
    return check_heal()
	
end


function killPfm(id,p_cmd)
    local l_cmd="kill"
    if p_cmd and type(p_cmd)=="string" then l_cmd=p_cmd end
    if id then
       exe(l_cmd ..' '..id)
    end
    tmp.pfm=100
    tmp.busytest=0
	exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
end

fight_prepare=function()
    local l_pfm
    weapon_unwield()
    weapon_wield()
    exe('remove biao;jiali 1;yield no')
    
    beiUnarmed()
    --l_pfm = perform.pre
	l_pfm = GetVariable("performpre")
	if job.name == "smy" then
	    l_pfm = l_pfm .. ";kill wu shi"
	end
    if perform and perform.skill and l_pfm then
       create_alias('pfmset','pfmset','alias pfmpfm '.. l_pfm)
       exe('pfmset')
    end
    exe('set wimpy 100;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    --if score.party=="������" and flag.wudi and flag.wudi==0 then
    --   l_pfm = "yun wudi ".. score.id
	--   exe(l_pfm)
    --end
    
	fightSkillPrepare()
end
function fightSkillPrepare()
    skillPrepare = skillPrepare or {}
    for p in pairs(skillPrepare) do
	    if type(skillPrepare[p])=="function" then
		    local cmd = skillPrepare[p]()
			if cmd then exe(cmd) end
		end
	end
end
prepare_lianxi=function(func)
    prepare_trigger()
    EnableTriggerGroup("prepare_neili",true)
    flag.prepare=1
    if func~=nil then
        job.prepare=func
    else
        job.prepare=test   
    end
    condition={}
    exe('cond')
    return check_busy(prepareLianxi,1)
end
function prepareLianxi()
    if not condition["����æ״̬"] or condition["����æ״̬"] == 0 then
        return prepare_neili(job.prepare)
    end
    flag.jixu=1
    if hp.neili_max>hp.neili_lim-10 then
        exe('set ����')
    elseif job.prepare and (job.prepare==test or job.prepare==duHhe_start or job.prepare==duCjiang_start) then
        exe('set ����')
    else
        flag.jixu=0
        exe('unset ����')
    end
    
    return prepare_neili_a()
end
prepare_neili=function(func,p_cmd)
    local l_db
    if func~=nil then
        job.prepare=func
    else
        job.prepare=test   
    end

    tmp.db=p_cmd
    l_db=3/2
	if score.party and score.party == "�һ���" then
	    l_db=5/3
	end
    if tmp.db and type(tmp.db)=="number" and tmp.db<2 then
        l_db=tmp.db
    end

    --if hp.neili>hp.neili_max*l_db and job.prepare~=test and job.prepare~=fight_prepare then
    --    return check_bei(job.prepare)
    --end

    flag.prepare=0   
    prepare_trigger()
    EnableTriggerGroup("prepare_neili",true)
    flag.jixu=1
    exe('set ����')
    exe('yun jing;yun jingli;hp')
    
    prepare_neili_a()
end
prepare_neili_at=function()
   if tmp.prepare then job.prepare=tmp.prepare end 
   prepare_trigger()

   EnableTriggerGroup("prepare_neili",true)
   create_timer_s('neili',3,'prepare_neili_idle')
end
prepare_neili_a=function()
    prepare_neili_idle()
    if hp.qixue_per<50 and isInBags(drug.heal) then
        exe('eat dan')
    end
    create_timer_s('neili',3,'prepare_neili_idle')
end
prepare_neili_b=function()
    exe('yun qi;hp')
    return check_bei(prepare_neili_c)
end
prepare_neili_c=function()
    local l_db=3/2
    
    if tmp.db and type(tmp.db)=="number" and tmp.db<2 then
        l_db=tmp.db
    end
    
    if not flag.prepare or type(flag.prepare)~='number' then flag.prepare=0 end
    if not condition["����æ״̬"] or condition["����æ״̬"]==0 then flag.prepare=0 end
    if job.prepare==duHhe_start or job.prepare==duCjiang_start then flag.prepare=0 end
    if hp.neili>hp.neili_max*l_db and flag.prepare==0 then
        EnableTriggerGroup("prepare_neili",false)
        DeleteTriggerGroup("prepare_neili")
        DeleteTimer('neili')
        exe('yun jing;yun qi;yun jingli')
        return check_bei(job.prepare)
    else
        return prepare_neili_a()
    end
end
prepare_neili_w=function()
    if job.name and job.name == "hubiao" then
        prepare_neili_stop()
        return check_bei(job.prepare)
    end
    locate()
    return check_bei(prepare_neili_g)
end
prepare_neili_g=function()
    exe(locl.dir)
end
prepare_neili_t=function()
    DeleteTimer('neili')
end
prepare_neili_idle=function()
    local l_cnt=0
    local l_db=3/2
    
    for p in pairs(skills) do
        if skillEnable[p] and skillEnable[p]=="force" then
            tmp.fskill=p
	        break
        end
    end
    if perform.force then
        tmp.fskill=perform.force
    end
	
	if (hp.neili_max>=hp.neili_lim-5 or flag.jixu==1 or skills[tmp.fskill].full==0) and hp.neili>hp.neili_max*l_db then
		if hp.neili>hp.neili_max*7/4 then
		    l_cnt=l_cnt + math.modf((hp.neili-hp.neili_max*7/4)/10)
		end
		l_cnt=l_cnt + math.modf(hp.neili_max/300)
		if l_cnt<1 then l_cnt=1 end
		lianxi(l_cnt)
	end
    
    if score.gold and score.gold>1000 and hp.neili<hp.neili_max and isInBags(drug.neili) then
        exe('eat '.. drug.neili)
    end
    exe('yun jingli;yun jing;yun qi')
    if hp.jingli_max<hp.jingli_lim-500 and flag.lianxi==1 and hp.neili>hp.neili_max*l_db and (hp.neili_max>=hp.neili_lim-5 or flag.jixu==1) then
        exe('unset ����')
        exe('tuna '..hp.jingxue/2)
    else
        exe('dazuo '..hp.dazuo)
    end
	condition={}
    exe('cond')
end
prepare_neili_stop=function()
    DeleteTimer('neili')
    DeleteTimer('bei')
    EnableTriggerGroup("prepare_neili",false)
    DeleteTriggerGroup("prepare_neili")
    beihook=test
    busyhook=test
    EnableTriggerGroup("check_bei",false)
    EnableTriggerGroup("check_busy",false)
    exe('halt')
end
prepare_neili_liaokao=function()
    dis_all()
	return tiaoshui()
end

function job.flag()
    flag.find=0
    flag.wait=0
end

function job_exp_trigger()
    DeleteTriggerGroup("job_exp")
    create_trigger_t('job_exp1',"^(> )*(\\D*)��Ǳ��!$",'','jobExppot')
    create_trigger_t('job_exp2',"^(> )*(\\D*)�㾭��!$",'','jobExpexp')
    create_trigger_t('job_exp3','^(> )*�㾲����������������ղŵ�������̣�������Ȼ���ʡ��������صõ���(\\D*)�㾭�飡','','jobExpExtra')
    create_trigger_t('job_exp4',"^>*\\s*��������л�Ȼ���ʣ�������(\\D*)��Ǳ�ܺ�(\\D*)�㾭�飡",'','job_exp_gb')
    create_trigger_t('job_exp5',"^(> )*��ϲ�㣡��ɹ��������(\\D*)�����㱻������",'','jobExp')
    SetTriggerOption("job_exp1","group","job_exp")
    SetTriggerOption("job_exp2","group","job_exp")
    SetTriggerOption("job_exp3","group","job_exp")
    SetTriggerOption("job_exp4","group","job_exp")
    SetTriggerOption("job_exp5","group","job_exp")
	EnableTrigger("job_exp1",false)
	EnableTrigger("job_exp2",false)
end
function jobExp(n,l,w)
    EnableTrigger("job_exp1",true)
	EnableTrigger("job_exp2",true)
    hp.exp_name=tostring(w[2])
end
function jobExpexp(n,l,w)
    hp.exp_exp=tostring(w[2])
end
function jobExppot(n,l,w)
    EnableTrigger("job_exp1",false)
	EnableTrigger("job_exp2",false)
	hp.exp_pot=tostring(w[2])
	if not isNil(hp.exp_name) and not isNil(hp.exp_exp) and not isNil(hp.exp_pot) then
	   return messageShow(hp.exp_name ..'������������:��'.. hp.exp_exp ..'���㣬��Ǳ��:��'.. hp.exp_pot ..'���㣡','darkorange')
	end
	hp.exp_name=nil
	hp.exp_exp=nil
	hp.exp_pot=nil
end

function jobExpExtra(n,l,w)
    messageShow('����������������:��'..w[2]..'���㣡','darkorange')
end

function job_exp_gb(n,l,w)
    if job.name=="gaibang" then
       messageShow('ؤ��������������:��'..w[2]..'���㣬Ǳ��:��'..w[1]..'���㣡')
    end
    if job.name=="songshan" then
       messageShow('��ɽ������������:��'..w[2]..'���㣬Ǳ��:��'..w[1]..'���㣡')
    end
end
function job_exp_zs(n,l,w)
    messageShow('׽��������������:��'..w[1]..'���㣬Ǳ��:��'..w[2]..'���㣡')
end

function job_exp_tongji(p_cmd)
    tongji = tongji or {}
    if tongji.exp==nil then 
       tongji.exp=hp.exp
       tongji.time=os.time()
       tongji.hour=math.modf(os.time()/900)
       messageShow('������ͳ�ƣ�ͳ�ƿ�ʼ','red')
       return
    end

    if not tongji.time or not tongji.hour then 
       tongji.exp=nil
       return
    end
    if math.modf(os.time()/900)<=tongji.hour and not p_cmd then return end

    tongji.hour=math.modf(os.time()/900)

    local l_exp=hp.exp
    local l_time=os.time()-tongji.time
    local l_hour=math.modf(l_time/3600)
    local l_min=math.modf((l_time-l_hour*3600)/60)
    local l_sec=l_time-l_hour*3600-l_min*60
    local l_exp=hp.exp-tongji.exp
    local l_avg=math.modf(l_exp*3600/l_time)
	
	job.expAvg = l_avg

	if flag.log and flag.log=="yes" then
       messageShow('������ͳ�ƣ������С�'.. l_hour ..'Сʱ'.. l_min .. '��' .. l_sec ..'��' ..'������þ��顾'..l_exp..'���㣬ƽ��ÿСʱ��'..l_avg..'���㣡','red')
    else
	   ColourNote ("white","blue",'������ͳ�ƣ������С�'.. l_hour ..'Сʱ'.. l_min .. '��' .. l_sec ..'��' ..'������þ��顾'..l_exp..'���㣬ƽ��ÿСʱ��'..l_avg..'���㣡')    
	end
	SetStatus('������ͳ�ƣ������С�'.. l_hour ..'Сʱ'.. l_min .. '��' .. l_sec ..'��' ..'������þ��顾'..l_exp..'���㣬ƽ��ÿСʱ��'..l_avg..'���㣡')
end
function jobExpTongji()
    return job_exp_tongji(1)
end

JobTriggerDel = JobTriggerDel or {}

function jobTriggerDel()
    local delList = {
	    ["huashan_triggerDel"] = true,
		["songxin_triggerDel"] = true,
		["gaibangTriggerDel"] = true,
		["zhuosheTriggerDel"] = true,
		["clbTriggerDel"] = true,
		["gbluTriggerDel"] = true,
		["sldsmTriggerDel"] = true,
		["tmonkTriggerDel"] = true,
		["husongTriggerDel"] = true,
		["wudangTriggerDel"] = true,
		["xueshan_triggerDel"] = true,
		["tdh_triggerDel"] = true,
	}
    
	for p in pairs(delList) do
	    if _G[p] then
		   _G[p]()
		end
	end
	
	JobTriggerDel = JobTriggerDel or {}
	for p,q in pairs(JobTriggerDel) do
	    if _G[q] then
	        _G[q]()
		end
	end
end

function jobSet()
    local l_result,l_tmp,t
    
    t={}
    
    for p,q in pairs(job.list) do
        if type(q) == 'function' then
	        if q() then t[p] = q() end
        else	   
            t[p] = q
	    end
    end
   
    job.zuhe={}
    if GetVariable("jobzuhe") then
        tmp.job=utils.split(GetVariable("jobzuhe"),'_')
	    tmp.zuhe = {}
        for _,p in pairs(tmp.job) do
            tmp.zuhe[p]=true
        end
    end
    l_tmp=utils.multilistbox ("����������(�밴CTRL��ѡ)��?", "�������", t,tmp.zuhe)
    l_result=nil
    for p in pairs(l_tmp) do
        job.zuhe[p]=true
        if l_result then
            l_result = l_result .. '_' .. p
        else
            l_result = p
        end
    end
    if l_result~=nil then
        SetVariable("jobzuhe",l_result)
    end
    for p in pairs(t) do
        if not job.zuhe[p] then
	        t[p]=nil
	    end
    end
    job.first = nil
    job.second = nil
   
    if jobSpecial then
        for p in pairs(jobSpecial) do
	        t[p] = nil
	    end
    end
   
    if countTab(t)>2 then
        l_result=utils.listbox("���һ����ȥ������","��������",t,GetVariable("jobfirst"))
        if l_result~=nil then
            SetVariable("jobfirst",l_result)
            job.first=l_result
	 	    t[job.first]=nil
        else
	        job.first = nil
            DeleteVariable("jobfirst")
        end
    end
    if countTab(t)>1 and job.first then
	    l_result=utils.listbox("��ڶ�����ȥ������","��������",t,GetVariable("jobsecond"))
        if l_result~=nil then
            SetVariable("jobsecond",l_result)
            job.second=l_result
        else
	        job.second = nil
            DeleteVariable("jobsecond")
        end
    else
	    job.second = nil
        DeleteVariable("jobsecond")
    end
    if not job.first then
        DeleteVariable("jobfirst")   
    end
    if not job.second then
        DeleteVariable("jobsecond")
    end
   
    if job.zuhe["hubiao"] or job.zuhe["smy"] or job.zuhe["was"] then
	    drugPrepare["�󻹵�"]=true
        if GetVariable("teamname") then
            l_result=utils.inputbox ("����ӵĶ���(��������)��?", "TeamName", GetVariable("teamname"), "����" , "12")
        else
            l_result=utils.inputbox ("����ӵĶ���(��������)��?", "TeamName", job.teamname, "����" , "12")
        end
        if not isNil(l_result) then
            SetVariable("teamname",l_result)
            job.teamname=l_result
        else
            DeleteVariable("teamname")
            job.teamname=nil
        end
        if GetVariable("teamlead") then
            l_result=utils.inputbox ("����ӵĶӳ�(��������)��?", "TeamLead", GetVariable("teamlead"), "����" , "12")
        else
            l_result=utils.inputbox ("����ӵĶӳ�(��������)��?", "TeamLead", job.teamlead, "����" , "12")
        end
        if not isNil(l_result) then
            SetVariable("teamlead",l_result)
            job.teamlead=l_result
        else
            DeleteVariable("teamlead")
            job.teamlead=nil
        end
    end
	if job.zuhe["smy"] then
	    if GetVariable("flaground") then
            l_result=utils.inputbox ("����Ħ�¿���׼��������?", "flaground", GetVariable("flaground"), "����" , "12")
        else
            l_result=utils.inputbox ("����Ħ�¿���׼��������?", "flaground", '9', "����" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flaground",l_result)
        else
            DeleteVariable("flaground")
        end
    end
	if job.zuhe["was"] then
	    if GetVariable("flagwasround") then
            l_result=utils.inputbox ("��׼�����´�������?", "flagwasround", GetVariable("flagwasround"), "����" , "12")
        else
            l_result=utils.inputbox ("��׼�����´�������?", "flagwasround", '19', "����" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flagwasround",l_result)
        else
            DeleteVariable("flagwasround")
        end
    end
	if job.zuhe["gmd"] then
	    if GetVariable("flagwasround") then
            l_result=utils.inputbox ("��׼����������������?", "flaggmdround", GetVariable("flaggmdround"), "����" , "12")
        else
            l_result=utils.inputbox ("��׼����������������?", "flaggmdround", '19', "����" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flaggmdround",l_result)
        else
            DeleteVariable("flaggmdround")
        end
    end
end
function jobGetVar()
    if GetVariable("jobzuhe") then
        tmp.job=utils.split(GetVariable("jobzuhe"),'_')
        for _,p in pairs(tmp.job) do
            job.zuhe[p]=true
        end
    end
    if GetVariable("jobfirst") then
        job.first=GetVariable("jobfirst")
	    if job.first=="songxin2" then job.first="songxin" end
    else
        job.first=nil
    end
    if GetVariable("jobsecond") then
        job.second=GetVariable("jobsecond")
	    if job.second=="songxin2" then job.second="songxin" end
    else
        job.second=nil
    end
    if job.zuhe["xueshan"] and job.zuhe["wudang"] and job.zuhe["huashan"] then
        job.third="huashan"
    else
        job.third=nil
    end
    if GetVariable("gaibangcancel") then
        gaibangCancel=GetVariable("gaibangcancel")
    end
    if GetVariable("sldsmcancel") then
        sldsmCancel=GetVariable("sldsmcancel")
    end
    if GetVariable("teamname") then
        job.teamname=GetVariable("teamname")
    end
    if GetVariable("teamlead") then
        job.teamlead=GetVariable("teamlead")
    end
end

function messageShow(p_msg,ccolor,bcolor) 
    local c_color = ccolor or "white"
	local b_color = bcolor or "blue"
	
	if isNil(p_msg) then return end
	
	local mcolor = {
	     ["songxin"] = "white",
		 ["wudang"]  = "forestgreen",
		 ["xueshan"] = "forestgreen",
		 ["clb"]     = "cyan",
		 ["was"]     = "cyan",
		 ["hubiao"]  = "yellow",
		 ["shouwei"]  = "yellow",
		 ["huashan"] = "blue",
		 ["fuxing"] = "hotpink",
	}
	
	if job.name and mcolor[job.name] then ccolor = mcolor[job.name] end

    if GetVariable("flaglog") and GetVariable("flaglog")=="yes" then
	    return chats_log(p_msg,ccolor,bcolor)
	end	
    if GetVariable("flagnote") and GetVariable("flagnote")=="yes" then
        --return ColourNote ("white","blue",p_msg)
		ColourNote ("white","blue",p_msg)
	end
	MsgNote(os.date("%H:%M:%S") .. " " ..p_msg,ccolor,bcolor)
	return txtJobLog(p_msg)
end

local lastWeekDay = os.date("%w")
function txtJobLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\" .. score.id .. "_" .. os.date("%w") .. "_job_log.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end
function txtLocateLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\" .. score.id .. "_" .. os.date("%w") .. "_locate.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end
function txtChatLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\xajh_" .. os.date("%w") .. "_chat.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end

function varShow(p_var)
    messageShow(p_var..': '.. _G[p_var])
end

function setJobwhere(p)
    job.where = p
end

function setGfunc(var,value)
    _G[var] = value
end

function scrLog()
    local filename = GetInfo (67) .. "logs\\����log_" .. score.id .. "_".. os.date('%Y_%m_%d_%H_%M_%S') .. ".log"
	
    local file = io.open(filename,"w")
   
    local t = {}
   
    for i = 1,GetLinesInBufferCount() do
        table.insert(t,GetLineInfo(i,1))
    end
   
    local s = table.concat(t,"\n") .. "\n"
	
	if file then
	    file:write(s)  
        file:close()
	end
end

function commCut(target,func)
    tmp.target = target
	tmp.func   = func
	
    DeleteTriggerGroup("commCut")
	create_trigger_t('commCut1','^(> )*ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն���������������С�','','commCutCon')
	create_trigger_t('commCut2','^(> )*����ü����������߲���������ʬ���ͷ����','','commCutWeapon')
	SetTriggerOption("commCut1","group","commCut")
	SetTriggerOption("commCut2","group","commCut")
	EnableTriggerGroup("commCut",false)
	
    return check_bei(commCutAct,1)
end
function commCutAct()
	EnableTriggerGroup("commCut",true)
	weapon_unwield()
    weaponWieldCut()
	create_timer_s('commcutter',1,'commCutTimer')
	commCutTimer()
end
function commCutTimer()
	for i=1,3 do
        exe('qie corpse '..i)    
    end	
end
function commCutWeapon()
    EnableTrigger("commCut2",false)
	checkBags()
    return checkWait(commCutAct,2)
end
function commCutCon(n,l,w)
    if w[2] == tmp.target then
	    dis_all()
		return check_bei(commCutOver,1)
	end
end
function commCutOver()
    DeleteTimer("commcutter")
	DeleteTriggerGroup("commCut")
	if isGlobalFunc(tmp.func) then 
	    return _G[tmp.func]()
	else
	    return check_heal()
	end
end