--wudang

--jobSpecial = jobSpecial or {}
--jobSpecial["wudang"] = true 
job.list = job.list or {}
job.list["wudang"] ="�䵱ɱ����"
joblast = joblast or {}
joblast["�䵱"] = "wudang"
joblast["�䵱����"] = "wudang"
jobCond = jobCond or {}
jobCond["wudang"] = function() if hp.shen>20000 and (not condition["�䵱����"] or (condition["�䵱����"] and condition["�䵱����"]<=0) or (condition["����æ״̬"] and condition["�䵱����"] and condition["�䵱����"]<=condition["����æ״̬"])) then return true else return false end end
--jobCond["wudang"] = function() if hp.shen>20000 then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["wudang"] = "wudangTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["wudang"] = "wudangFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["wudang"] = "wudangFindFail"
faintFunc = faintFunc or {}
faintFunc["wudang"] = "wudangFaint"

local ftab = {}

function wudangTrigger()
    DeleteTriggerGroup("wudangAsk")
    create_trigger_t('wudangAsk1',"^(> )*������Զ�Ŵ����й�",'','wudangAsk')
    create_trigger_t('wudangAsk2',"^(> )*����û������ˡ�$",'','wudangNobody')
    SetTriggerOption("wudangAsk1","group","wudangAsk")
    SetTriggerOption("wudangAsk2","group","wudangAsk")
    EnableTriggerGroup("wudangAsk",false)
    DeleteTriggerGroup("wudangAccept")
    create_trigger_t('wudangAccept1',"^(> )*��Զ������Ķ�������˵������˵(����|����|����|��ԭ|����|����|�ӱ�|����)(�ݿ�|կ��|���|ɽ��|����|����|����)(\\D*)����(\\D*)����",'','wudangWhere')
    create_trigger_t('wudangAccept2',"^(> )*��Զ��˵�������Ҳ��Ǹ���������������",'','wudangFangqi')
    create_trigger_t('wudangAccept3',"^(> )*��Զ������Ķ�������˵��(\\D*)��Ϊ�ó�(\\D*)�Ĺ���",'','wudangNpc')
    create_trigger_t('wudangAccept4',"^(> )*��Զ��˵����������æ�ű��������",'','wudangFail')
    create_trigger_t('wudangAccept5',"^(> )*��Զ��˵�������������(\\D*)����",'','wudangFail')
    create_trigger_t('wudangAccept6',"^(> )*��Զ��˵������������ʱû���ʺ���Ĺ���",'','wudangFail')
    create_trigger_t('wudangAccept7',"^(> )*��Զ��˵��������ʱû��������Ҫ�������һ���������",'','wudangFail')
    create_trigger_t('wudangAccept8',"^(> )*��Զ��(����|)˵����(��|)\\D*��(�������ȷʵ�Ƚ������|��̫����ʧ����)",'','wudangFail')
    create_trigger_t('wudangAccept9',"^(> )*��Զ��˵������\\D*������û��������������Ϲ����ʲôѽ",'','wudangFail')
	create_trigger_t('wudangAccepta',"^(> )*��Զ������Ķ�������˵�������˵��书(\\D*)��",'','wudangLevel')
	create_trigger_t('wudangAcceptb',"^(> )*��Զ��˵���������ȥ��أ�һ��С�İ�����$",'','wudangConsider')
	create_trigger_t('wudangAcceptc',"^(> )*��Զ��˵������(\\D*)�����������������޷�����������������񣡡�$",'','wudangFail')
    SetTriggerOption("wudangAccept1","group","wudangAccept")
    SetTriggerOption("wudangAccept2","group","wudangAccept") 
    SetTriggerOption("wudangAccept3","group","wudangAccept")
    SetTriggerOption("wudangAccept4","group","wudangAccept")
    SetTriggerOption("wudangAccept5","group","wudangAccept") --
    SetTriggerOption("wudangAccept6","group","wudangAccept")
    SetTriggerOption("wudangAccept7","group","wudangAccept")
    SetTriggerOption("wudangAccept8","group","wudangAccept")
    SetTriggerOption("wudangAccept9","group","wudangAccept")
	SetTriggerOption("wudangAccepta","group","wudangAccept")
	SetTriggerOption("wudangAcceptb","group","wudangAccept")
	SetTriggerOption("wudangAcceptc","group","wudangAccept")
    EnableTriggerGroup("wudangAccept",false)
    DeleteTriggerGroup("wudangFinish")
    create_trigger_t('wudangFinish1','^(> )*��Զ�Ŷ��������������ִ�Ĵָ�������ġ�','','wudangFinishT')
    create_trigger_t('wudangFinish2',"^(> )*��Զ�ű������û��˹�ȥ��",'','wudangFinish')
    create_trigger_t('wudangFinish3',"^(> )*��Զ��˵������"..score.name.."����ô���",'','wudangFinish')
    SetTriggerOption("wudangFinish1","group","wudangFinish")
    SetTriggerOption("wudangFinish2","group","wudangFinish")
    SetTriggerOption("wudangFinish3","group","wudangFinish")
    EnableTriggerGroup("wudangFinish",false)
	DeleteTriggerGroup("wudangQuest")
    create_trigger_t('wudangQuest1',"^(> )*��Զ��˵������".. score.name ..",������ʦ����ʮ�ٳ�֮��,�������������߸�ʦ�ֵܼ�����ʦ�����١�",'','wudangQuest')
	SetTriggerOption("wudangQuest1","group","wudangQuest")
	EnableTriggerGroup("wudangQuest",false)
end
function wudangTriggerDel()
    DeleteTriggerGroup("wudangAsk")
    DeleteTriggerGroup("wudangAccept")
    DeleteTriggerGroup("wudangFinish")
    DeleteTriggerGroup("wudangFind")
	DeleteTriggerGroup("wudangQuest")
end
function wudangNobody()
    EnableTriggerGroup("wudangAsk",false)
    wudang()
end

function wudang()
    if hp.shen<0 then
	    return turnShen('+')
	end
    wudangTrigger()
    job.name='wudang'
    job.time.b=os.time()
	jobLevel = jobLevel or {}
	if jobLevel and jobLevel["wdlvl"] and jobLevel["wdlvl"] < hp.pot_max - 95 then
	    jobLevel["wudang"] = 10
	    jobLevel["wdlvl"] = hp.pot_max - 100
	end
	if GetVariable("levelwudang") and jobLevel[GetVariable("levelwudang")] then
	    jobLevel["wudang"] = jobLevel[GetVariable("levelwudang")]
	end
	messageShow('�䵱��������ʼ��')
    return prepare_lianxi(wudangGo)
end

function wudangFindAgain()
    EnableTriggerGroup("wudangFind",false)
    return go(wudangFindAct,dest.area,dest.room)
end

function wudangFaint()
    jobLevel = jobLevel or {}
	if job.level and jobLevel[job.level] and jobLevel["wudang"] and jobLevel["wudang"]>jobLevel[job.level] then
	   jobLevel["wudang"] = jobLevel[job.level]
	   if jobLevel["wudang"] and jobLevel["wudang"] < 5 then
	      jobLevel["wudang"] = 5
	   end
	   jobLevel["wdlvl"] = hp.pot_max - 100
	end
    return wudangFindFail()
end
function wudangFindFail()
    EnableTriggerGroup("wudangFind",false)
    return go(wudangFangqi,"�䵱ɽ","�����")
end
function wudangGo()
    return go(wudangStart,"�䵱ɽ","�����")
end
function wudangStart()
    EnableTriggerGroup("wudangAsk",true)
    return exe('ask song yuanqiao about job')
end
function wudangAsk()
    EnableTriggerGroup("wudangAsk",false)
    EnableTriggerGroup("wudangAccept",true)
end
function wudangBusy()
    EnableTriggerGroup("wudangAccept",false)
	job.last='wudang'
    return check_bei(wudangBusyDazuo)
end
function wudangBusyDazuo()
    exe('n')
    return prepare_lianxi(check_heal)
end
function wudangFail()
    EnableTriggerGroup("wudangAccept",false)
    return check_heal()
end
function wudangWhere(n,l,w)
    job.title =Trim(w[3])
    job.target=Trim(w[4])
    job.killer={}
    job.killer[job.target]=true
    job.where=Trim(w[5])
	job.level = "����һ��"
	--Note(job.where)
	if string.find(job.where,"��Χ") then
	   local l_cnt = string.find(job.where,"��Χ")
	   job.where=string.sub(job.where,1,l_cnt-1)
	   --Note(job.where)
	end
    --job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
	if type(job.room)=="string" and string.find(job.room,"����") then
	   job.room="��ɼ��"
	end
end
function wudangNpc(n,l,w)
	sxjob.skills=tostring(w[3])
    dest.room=job.room
    dest.area=job.area
end
function wudangLevel(n,l,w)
	job.level = tostring(w[2])
end
function wudangConsider()	
    EnableTriggerGroup("wudangAccept",false)
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       messageShow('�䵱��������ص㡾'..job.where..'�����ɵ�����������')
       return check_bei(wudangFangqi)
    end
	if skillIgnores[sxjob.skills] then
       messageShow('�䵱����'.. job.target ..'ʹ�õ��书�ǡ�'..sxjob.skills..'���������У����������')
	   return check_bei(wudangFangqi)
	end
	
	if job.level and jobLevel[job.level] and jobLevel["wudang"] and jobLevel[job.level] >= jobLevel["wudang"] then
	   messageShow('�䵱����'.. job.target ..'���书�ǡ�'.. job.level ..'���������У����������')
	   return check_bei(wudangFangqi)
	end
	if job.level and sxjob.skills then
	    messageShow('�䵱����'.. job.target ..'ʹ�õ��书�ǡ�'.. job.level ..'���ġ�'..sxjob.skills..'����')
	end
	messageShow('�䵱���񣺿�ʼǰ����'..job.where..'����')
    return check_bei(wudangFind)
end
function wudangFangqiGo()
    return go(wudangFangqi,'�䵱ɽ','�����')
end
function wudangFangqi()
    EnableTriggerGroup("wudangAccept",false)
    return check_bei(wudangFangqiAsk)
end
function wudangFangqiAsk()
    EnableTriggerGroup("wudangAsk",true)
    exe('ask song yuanqiao about ����')
end
function wudangFind()
    DeleteTriggerGroup("wudangFind")
    create_trigger_t('wudangFind1','^(> )*(\\D*)'..job.target..'\\((\\D*)\\)','','wudangTarget')
	create_triggerex_lvl('wudangFind2',"^(> )*����û��(\\D*)��",'','wudangLost',120)
	create_triggerex_lvl('wudangFind3','^(> )*(\\D*) - ','','wudangRoom',120)
	create_trigger_t('wudangFind4','^(> )*��� "action" �趨Ϊ "������Ѱ��" �ɹ���ɡ�$','','wudangFindCheck')
	create_trigger_t('wudangFind5','^(> )*'.. job.target ..'��ž����һ�����ڵ���','','wudangBack')
    create_trigger_t('wudangFind6','^(> )*'.. job.target ..'��һ�������ã���ת��������Ͳ�����','','wudangBack')
    create_trigger_t('wudangFind7','^(> )*'.. job.target ..'�����㷢��һ����Ц��˵��\\D*(��Ҳ��ֻ������������|�Ҳ�������)','','wudangKillAct')
	create_trigger_t('wudangFind8','^(> )*'.. job.target ..'��һ�������Ӳ������ˣ�ת��������Ͳ�����','','wudangBack')
	create_trigger_t('wudangFind9','^(> )*���������'.. job.target ..'һ���ж���','','wudangKillAct')
    SetTriggerOption("wudangFind1","group","wudangFind")
	SetTriggerOption("wudangFind2","group","wudangFind")
	SetTriggerOption("wudangFind3","group","wudangFind")
	SetTriggerOption("wudangFind4","group","wudangFind")
	SetTriggerOption("wudangFind5","group","wudangFind")
	SetTriggerOption("wudangFind6","group","wudangFind")
	SetTriggerOption("wudangFind7","group","wudangFind")
	SetTriggerOption("wudangFind8","group","wudangFind")
	SetTriggerOption("wudangFind9","group","wudangFind")
    flag.times=1
	tmp.fast = true
	--exe('unset wimpy')
	fight_prepare()
	EnableTriggerGroup("wudangFind",true)
	EnableTrigger("wudangFind3",false)
    return go(wudangFindAct,job.area,job.room)    
end
function wudangFindAct()
    EnableTriggerGroup("wudangFind",true)
	EnableTrigger("wudangFind3",false)
	if locl.id[job.target] and not (usrList and usrList[job.id]) then
       return wudangKillAct()
	end
    DeleteTimer("wudang")
    job.flag()
	fight_prepare()
	messageShow('�䵱���񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
	
	if not tmp.fast then
	    return find()
	end
    
	tmp.target = 0
	tmp.froom = 0
	
	ftab = {}
	local path = searchPathGet()
	local pset = utils.split(path,";")
	for p,q in ipairs(pset) do
	    if not (isNil(q) or q=='halt') then 
	       table.insert(ftab,q)
		end
	end
	exe('look')
	return checkWait(wudangFindCheck,0.2)
end
function wudangFindCheck()
    EnableTrigger("wudangFind3",false)
    if tmp.target and tmp.target > 0 then
	    if tmp.froom ==0 then
	        return wudangFindFollow()
	    else
	        return wudangFindBack()
	    end
	else
	    return wudangFindRoad()
	end
end
function wudangFindBack()
    tmp.froom = tmp.froom or 0
	
	for i = 1,tmp.froom do
	    table.remove(tmp.froad,1)
	end
	
	local path = ''
	
	for i = table.getn(tmp.froad),1,-1 do
	    if isNil(path) then
		    path = dirReverse[tmp.froad[i]]
		else
		    path = path .. ';' .. dirReverse[tmp.froad[i]]
		end
	end
	
	EnableTrigger("wudangFind3",true)
	create_alias('goset','goset','alias goalias '.. path)
    exe('goset')
	exe('goalias')
	   
    return check_bei(wudangFindFollow)
end
function wudangFindRoad()
    tmp.froom = 0
	tmp.froad = {}
	while table.getn(ftab)>0 do
	    if table.getn(tmp.froad)>9 then
		    return wudangFindMove()
		end		
	    local path = ftab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.froad)>0 then
			    return wudangFindMove()
		    else
			    table.remove(ftab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
					    EnableTrigger("wudangFind2",false)
						EnableTrigger("wudangFind3",false)
						tmp.findfunc = "wudangFindFollow"
	                    return _G[func](params)
					else
					    exe(path)
						return wudangFindFollow()
					end
				else
				    exe(path)
					return wudangFindFollow()
				end
		    end
		else
		    table.remove(ftab,1)
		    table.insert(tmp.froad,path)
		end	
	end
	return wudangFindMove()
end
function wudangFindMove()
    tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
        EnableTriggerGroup("wudangFind",false)
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
		tmp.fast = nil
	    if flag.times > 2 then
	        messageShow('�䵱�����ڡ�'..job.where..'���Ҳ�����' .. job.target ..'�������������')
	        return wudangFindFail()
	    else
	        return wudangFindAgain()
	    end
	else
	    local path = table.concat(tmp.froad,";")
		
		EnableTrigger("wudangFind3",true)
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action ������Ѱ��')
	    end)
	end
end
function wudangRoom()
    tmp.froom = tmp.froom or 0
    if tmp.target == 0 then
	    tmp.froom = tmp.froom + 1
	end
end
function wudangFindFollow()
    EnableTrigger("wudangFind2",true)
	EnableTrigger("wudangFind3",true)
    exe('follow '..job.id)
	exe('kick '..job.id)
	if tmp.target and tmp.target== 1 then
	   create_timer_s('wudang',5,'wudangMove')
	end
	messageShow('�䵱���񣺿�ʼ�͡�'..job.target..'����ս����')
end
function wudangTarget(n,l,w)
    local l_title = Trim(w[2])
	
    job.id=string.lower(w[3])
	
	if not (l_title and job.title and string.find(l_title,job.title)) then
	   return
	end
	if tmp.fast then
	    tmp.target = 1
	else 
        --EnableTriggerGroup("wudangFind",false)
        --EnableTriggerGroup("wudangFight",true)
        
        job.killer[job.target]=job.id
        exe('follow '..job.id)
	    exe('kick '..job.id)
        wudangKill()
        create_timer_s('wudang',5,'wudangMove')
		messageShow('�䵱���񣺿�ʼ�͡�'..job.target..'����ս����')
	end
end
function wudangMove()
	if job.id then
	   exe('follow '..job.id)
	   exe('kick '..job.id)
	   exe('kill '..job.id)
	end
end
function wudangLost(n,l,w)
    if job.id~=Trim(w[2]) then
	   return 
	end
	DeleteTimer("wudang")
    if not tmp.fast then       
        dis_all()
        return wudangFindAgain()
	end 
	tmp.target = 0
	tmp.froom = 0
	tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    return wudangFindCheck()
	else
	    return wudangFindMove()
	end
end
function wudangKill()
    wait.make(function()
         wait.time(2)
	 wudangKillAct()
    end)
end
function wudangKillAct()
    exe('set wimpy 100;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    exe('kick '..job.id)
    killPfm(job.id)
	create_timer_s('wudang',5,'wudangMove')
	messageShow('�䵱���񣺿�ʼ�͡�'..job.target..'����ս����')
end
function wudangBack(n,l,w)
    --DeleteTimer("wudang")
    --EnableTriggerGroup("wudangFight",false)
	--EnableTriggerGroup("wudangFind",false)
    --EnableTriggerGroup("wudangFinish",true)
    tmp.number = 0
	tmp.findfunc = nil
    --DeleteTimer("perform")
	--DeleteTimer("wudang")
	dis_all()
    messageShow('�䵱���񣺸㶨'..'��'.. job.target ..'����')
	return check_bei(wudangBackGet)
end
function wudangBackGet()
    for i=1,2 do
       exe('get gold from corpse '..i)
    end
    return go(wudangFinishWait,'�䵱ɽ','�����')
end
function wudangFinishWait()
	if locl.id["��Զ��"] then
	   EnableTriggerGroup("wudangFinish",true)
	   EnableTriggerGroup("wudangQuest",true)
	   return check_busy(wudangFinishAsk)
	else
	   return go(wudangFinishWait,'�䵱ɽ','�����')
	end
end
function wudangFinishAsk()
    exe('ask song yuanqiao about ���')
end
function wudangFinishT()
	return wudangFinish()
end
function wudangFinish()
    EnableTriggerGroup("wudangFinish",false)
	messageShow('�䵱����������ɣ�')
    return check_bei(check_heal)
end
function wudangQuest()
	SetVariable("timeyttl",os.date())
end