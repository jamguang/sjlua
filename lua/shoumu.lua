local smPath = {
    ["sm1"] = "w;d;w;d;sw;d",
	["sm2"] = "nw;d;nw;d;w;d",
	["sm3"] = "nu;d;nu;d;nw;d",
	["sm4"] = "n;d;n;d;nu;d",
	["sm5"] = "nd;d;nd;d;n;d",
	["sm6"] = "ne;d;ne;d;nd;d",
	["sm7"] = "e;d;e;d;ne;d",
	["sm8"] = "se;d;se;d;e;d",
	["sm9"] = "su;d;su;d;se;d",
	["sm10"] = "s;d;s;d;su;d",
	["sm11"] = "sd;d;sd;d;s;d",
	["sm12"] = "sw;d;sw;d;sd;d",
}	

job.list = job.list or {}	
job.list["shoumu"] = function() if score.party and score.party == "�һ���" then return "�һ�����Ĺ" else return false end end
joblast = joblast or {}
joblast["�һ���Ĺ"]   = "shoumu"
jobCond = jobCond or {}
jobCond["jobCond"] = function() if MidNight[locl.time] then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["shoumu"] = "shoumuTriggerDel"

function shoumuTrigger()
    DeleteTriggerGroup("shoumuAsk")
    create_trigger_t('shoumuAsk1',"^(> )*������ش����йء�(��Ĺ|����)������Ϣ��",'','shoumuAsk')
    create_trigger_t('shoumuAsk2',"^(> )*����û������ˡ�$",'','shoumuNobody')
    create_trigger_t('shoumuAsk3',"^(> )*������ش����йء�ʦĸ������Ϣ��",'','shoumuShimu')
	SetTriggerOption("shoumuAsk1","group","shoumuAsk")
    SetTriggerOption("shoumuAsk2","group","shoumuAsk")
	SetTriggerOption("shoumuAsk3","group","shoumuAsk")
    EnableTriggerGroup("shoumuAsk",false)
    DeleteTriggerGroup("shoumuAccept")
    create_trigger_t('shoumuAccept1',"^(> )*����˵�������Բ�����������û��ʲô���Ը������ġ���",'','shoumuBusy')
    create_trigger_t('shoumuAccept2',"^(> )*�����ɻ�Ŀ�����,˵��: ���ڴ����ģ���ʲôĹѽ",'','shoumuBusy')
    create_trigger_t('shoumuAccept3',"^(> )*����˵��������ո�������Ĺ���񣬻�������Ϣһ��ɡ���",'','shoumuFail')
    create_trigger_t('shoumuAccept4',"^(> )*����˵���������书��ô�ã������鷳������",'','shoumuFangqi')
    create_trigger_t('shoumuAccept5',"^(> )*���ص�����һ��,˵��: ���ǽ���ȥ�����㻹���������ʲô",'','shoumuFail')
    create_trigger_t('shoumuAccept6',"^(> )*����˵�������Ѿ�����ȥ��Ĺ��",'','shoumuCon')
    create_trigger_t('shoumuAccept7',"^(> )*����˵�������ѵ�����������⣬������ĸ�׵�Ĺ���������ܽ�ȥ�ġ�",'','shoumuWait')
    create_trigger_t('shoumuAccept8',"^(> )*����˵��������ҪС�ĵ㣬��ĸ�׵�Ĺ�ɲ���һ���˶��ܽ�ȥ�ġ�",'','shoumuWait')
    SetTriggerOption("shoumuAccept1","group","shoumuAccept")
    SetTriggerOption("shoumuAccept2","group","shoumuAccept")
    SetTriggerOption("shoumuAccept3","group","shoumuAccept")
    SetTriggerOption("shoumuAccept4","group","shoumuAccept")
    SetTriggerOption("shoumuAccept5","group","shoumuAccept")
    SetTriggerOption("shoumuAccept6","group","shoumuAccept")
    SetTriggerOption("shoumuAccept7","group","shoumuAccept")
    SetTriggerOption("shoumuAccept8","group","shoumuAccept")
    EnableTriggerGroup("shoumuAccept",false)
end
function shoumuTriggerDel()
    DeleteTriggerGroup("shoumuAsk")
    DeleteTriggerGroup("shoumuAccept")
    DeleteTriggerGroup("shoumuWa")
end
function shoumuNobody()
    EnableTriggerGroup("shoumuAsk",false)
    return shoumu()
end
function shoumu()
    shoumuTrigger()
    job.name='shoumu'
    job.time.b=os.time()
	locate()
	return checkWait(shoumuCheck,2)
end
function shoumuCheck()
    if not MidNight[locl.time] then
	    for p in pairs(job.zuhe) do
	        if job.last ~= p and p ~= 'shoumu' then
		        return _G[p]()
		    end
	    end
	end
    return prepare_lianxi(shoumuGo)
end
function shoumuGo()
    if jobtimes and jobtimes["�һ�����Ĺɱ��"] and jobtimes["�һ�����Ĺɱ��"] > 400 then
	    exe('pray pearl')
	end
    return go(shoumuStart,"thd/neishi1","")
end
function shoumuStart()
    EnableTriggerGroup("shoumuAsk",true)
    return exe('ask huang rong about ʦĸ')
end
function shoumuShimu()
    return check_bei(shoumuJob,1)
end
function shoumuJob()
    return exe('ask huang rong about ��Ĺ')
end
function shoumuAsk()
    EnableTriggerGroup("shoumuAsk",false)
    EnableTriggerGroup("shoumuAccept",true)
end
function shoumuBusy()
    EnableTriggerGroup("shoumuAccept",false)
	for p in pairs(job.zuhe) do
	    if job.last ~= p and p ~= 'shoumu' then
		   return _G[p]()
		end
	end
    return prepare_lianxi(shoumuGo)
end
function shoumuCon()
    return prepare_lianxi(shoumuGo)
end
function shoumuFail()
    EnableTriggerGroup("shoumuAccept",false)
    job.last='shoumu'
	return check_bei(check_heal)
end
function shoumuFangqi()
    EnableTriggerGroup("shoumuAccept",false)
    job.zuhe["shoumu"] = nil
    return check_heal()
end
function shoumuWait()
    DeleteTriggerGroup("shoumuWa")
    create_trigger_t('shoumuWa1',"^(> )*ͻȻ����\\D*���һ����д���һ����Ĺ�������ʯ�ؾͲ����ˡ�",'','shoumuZei')
	SetTriggerOption("shoumuWa1","group","shoumuWa")
    --EnableTriggerGroup("shoumuWa",false)
end
function shoumuZei()
    EnableTriggerGroup("shoumuWa",false)
	return check_bei(shoumuEnter)
end
function shoumuEnter()
    fight_prepare()
    exe("#4(kneel mubei);#3(push mubei left);#3(push mubei right);d;d")
	locate()
	return check_bei(shoumuMove)
end
function shoumuMove()
    if locl.exit["southeast"] then
	   return shoumuCal()
	end
	exe('d')
	locate()
	return check_busy(shoumuMove,1)
end
function shoumuCal()
    local l_i = 0
	if locl.time == '��' or locl.time == '��' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 12
	   else
	      l_i = 11
	   end
	end
    if locl.time == '��' or locl.time == '��' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 10
	   else
	      l_i = 9
	   end
	end
	if locl.time == 'î' or locl.time == '��' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 8
	   else
	      l_i = 7
	   end
	end
	if locl.time == '��' or locl.time == '��' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 6
	   else
	      l_i = 5
	   end
	end
	if locl.time == '��' or locl.time == 'δ' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 4
	   else
	      l_i = 3
	   end
	end
	if locl.time == '��' or locl.time == '��' then
	   if locl.quarter == '��' or locl.quarter == '��' then
	      l_i = 2
	   else
	      l_i = 1
	   end
	end
	local sm = "sm" .. l_i
	exe(smPath[sm])
	locate()
	return checkNext(shoumuLoc)
end
function shoumuLoc()
    if locl.room ~= "Ĺ������" then
	   return check_bei(shoumuMove,1)
	end
	return checkNext(shoumuWipe)
end	
function shoumuWipe()
	return wipe("daomu zei",shoumuGet)
end
function shoumuGet()
    exe("get all from corpse;drop cloth 2;wear cloth;u")
	locate()
	return check_bei(shoumuBack,1)
end
function shoumuBack()
    for p in pairs(locl.exit) do
	    if p ~= "down" then
		   exe(p)
		end
	end
	exe("u;0;out;e;#6n")
	return go(shoumuFinish,"thd/neishi1","")
end
function shoumuFinish()
    if locl.room ~= "����" then
	   exe('0')
	   return go(shoumuFinish,"thd/neishi1","")
	end
	exe('give all to huang rong')
	exe('drop lv feicui')
	exe('drop meiyu')
	exe('drop yeming zhu')
	exe('drop zi manao')
	return check_heal()
end

