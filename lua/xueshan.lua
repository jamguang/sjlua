--ѩɽ

job.list = job.list or {}
job.list["xueshan"] = "ѩɽ����Ů"
joblast = joblast or {}
joblast["ǿ����Ů"] = "xueshan"
jobCond = jobCond or {}
jobCond["xueshan"] = function() if not condition["ѩɽǿ����Ů"] or (condition["ѩɽǿ����Ů"] and condition["ѩɽǿ����Ů"]<=0) or (condition["����æ״̬"] and condition["ѩɽǿ����Ů"] and condition["ѩɽǿ����Ů"]<=condition["����æ״̬"]) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["xueshan"] = "xueshan_triggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["xueshan"] = "xueshanFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["xueshan"] = "xueshanFindFail"
faintFunc = faintFunc or {}
faintFunc["xueshan"] = "xueshan_fangqi_go"


local xstab = {}

dangerousNpc = {
["��Ȯ"]     = "ao quan",
["����"]     = "zang ao",
["�蹷"]     = "feng gou",
["ͷ��"]     = "tou lang",
["Ұ��"]     = "ye lang",
["����"]     = "du she",
["����"]     = "ma zei",
["�ϻ�"]     = "lao hu",
["���"]     = "yu feng",
["�˻���"]   = "caihua she",
["��Ҷ��"]   = "zhuye qing",
--["÷����"]   = "mei chaofeng",
["ѩ��"]     = "xue bao",
["Ұ��"]     = "ye zhu",
["����"]     = "guai mang",
["����"]     = "ju mang",
["����"]     = "du mang",
["��Ȯ"]     = "e quan",
["���"]     = "wu gong",
["�۳彫��"] = "zhechong jiangjun",
["ƽ�ܽ���"] = "pingkou jiangjun",
["��������"] = "zhengdong jiangjun",
["���ｫ��"] = "cheqi jiangjun",
["��������"] = "huizhen zunzhe",
["����"]     = "yang xiao",
["������"]   = "chuchen zi",
["��ɫ����"] = "heise dushe",
["���������"] = "jiao zhong",
["��ľ�����"] = "jiao zhong",
["��������"] = "jiao zhong",
["�һ������"] = "jiao zhong",
["��ˮ�����"] = "jiao zhong",
["���°���"] = "heiyi bangzhong",
["���°���"] = "huiyi bangzhong",
}

function xueshan_trigger()
    DeleteTriggerGroup("xueshan_find")
    DeleteTriggerGroup("xueshan_ask")
    create_trigger_t('xueshan_ask1',"^(> )*����������й�",'','xueshan_ask')
    create_trigger_t('xueshan_ask2',"^(> )*����û������ˡ�$",'','xueshan_nobody')
    SetTriggerOption("xueshan_ask1","group","xueshan_ask")
    SetTriggerOption("xueshan_ask2","group","xueshan_ask")
    EnableTriggerGroup("xueshan_ask",false)
    DeleteTriggerGroup("xueshan_accept")
    create_trigger_t('xueshan_accept1',"^(> )*����˵��������ô�򵥵���������ô���Է����أ���ȥ�ɣ���",'','xueshan_shibai')
    create_trigger_t('xueshan_accept2',"^(> )*����˵��������������ǱȽ����ѣ����겻��Ҳ����ȫ���㡣��",'','xueshan_fangqi_heal')
    create_trigger_t('xueshan_accept3',"^(> )*����˵�������Ҳ��ǽ���",'','xueshan_finish')
    create_trigger_t('xueshan_accept4',"^(> )*����˵�����������Ǹ����ı�Ǯ����ͬ־���㻹����ЪϢһ����ɡ���",'','xueshan_busy')
    create_trigger_t('xueshan_accept5',"^(> )*����˵��������Ҫ����������үү����һ�ߴ���ȥ����",'','xueshan_rest')
    create_trigger_t('xueshan_accept7',"^(> )*����˵��������(������û����|�ú÷�ʡ)",'','xueshan_busy')
    create_trigger_t('xueshan_accept8',"^(> )*����˵���������У��е�רҵ����ò��ã�",'','xueshan_shibai')
    create_trigger_t('xueshan_accept9',"^(> )*����ʼ�����Ƿ�Ҫɱ���㡣",'','xueshan_busy')
    create_trigger_t('xueshan_accept6',"^(> )*��������Ķ�������˵������˵���(\\D*)�������˸�Ư����С椣���ȥ����Ū����",'','xueshan_consider')
    SetTriggerOption("xueshan_accept1","group","xueshan_accept")
    SetTriggerOption("xueshan_accept2","group","xueshan_accept")
    SetTriggerOption("xueshan_accept3","group","xueshan_accept")
    SetTriggerOption("xueshan_accept4","group","xueshan_accept")
    SetTriggerOption("xueshan_accept5","group","xueshan_accept")
    SetTriggerOption("xueshan_accept6","group","xueshan_accept")
    SetTriggerOption("xueshan_accept7","group","xueshan_accept")
    SetTriggerOption("xueshan_accept8","group","xueshan_accept")
    SetTriggerOption("xueshan_accept9","group","xueshan_accept")
    EnableTriggerGroup("xueshan_accept",false)
    DeleteTriggerGroup("xueshan_kill")
    create_trigger_t('xueshan_kill1',"^(> )*�����(\\D*)(һ����Ц|�ٺ�һЦ|˵��|�ͺ�|���|���|�ȵ�|����һ��)",'','xueshan_kill_who')
    create_trigger_t('xueshan_kill2','^(> )*(\\D*)˵���������컯��Ҳ������','','xueshan_kill_judge')
	create_trigger_t('xueshan_kill3','^(> )*��� "action" �趨Ϊ "fight" �ɹ���ɡ�','','xueshan_fight_judge')
    create_trigger_t('xueshan_kill4','^(> )*����û������ˡ�','','xueshan_kill_nobody')
    create_trigger_t('xueshan_kill5','^(> )*(���ﲻ׼ս����|����Ҫ��������)','','xueshan_kill_nofight')
	create_trigger_t('xueshan_kill6','^(> )*������(\\D*)��������������','','xueshan_fight_unaccept')
    SetTriggerOption("xueshan_kill1","group","xueshan_kill")
    SetTriggerOption("xueshan_kill2","group","xueshan_kill")
    SetTriggerOption("xueshan_kill3","group","xueshan_kill")
    SetTriggerOption("xueshan_kill4","group","xueshan_kill")
    SetTriggerOption("xueshan_kill5","group","xueshan_kill")
    SetTriggerOption("xueshan_kill6","group","xueshan_kill")
    EnableTriggerGroup("xueshan_kill",false)
    DeleteTriggerGroup("xueshan_guard")
    create_trigger_t('xueshan_guard1',"^(> )*(����|����|����|����|����|��ԭ|����|����|�ӱ�|����)(��ͷ|����|��ͷ|��Ժ|����) \\D*\\((\\D*)\\)",'','xueshan_guard_check')
    create_trigger_t('xueshan_guard2','^(> )*��� "action" �趨Ϊ "check_guard" �ɹ���ɡ�','','xueshan_guard_look')
    SetTriggerOption("xueshan_guard1","group","xueshan_guard")
    SetTriggerOption("xueshan_guard2","group","xueshan_guard")
    EnableTriggerGroup("xueshan_guard",false)
    DeleteTriggerGroup("xueshan_judge")
    create_trigger_t('xueshan_judge1',"^(> )*��λ�����ƺ�����(\\D*)��",'','xueshan_judge_party')
    create_trigger_t('xueshan_judge2',"^����ΰ���̫�ã�����������ر�Ӿ��������ģ���˵�������Ǵ��ڸ����أ�",'','xueshan_judge_super')
    create_trigger_t('xueshan_judge3',"^  ��(���|����|����|һ������|�ֵ�|��)\\(",'','xueshan_judge_weapon')
    create_trigger_t('xueshan_judge4','^(> )*��� "action" �趨Ϊ "judge_guard" �ɹ���ɡ�','','xueshan_judge')
    SetTriggerOption("xueshan_judge1","group","xueshan_judge")
    SetTriggerOption("xueshan_judge2","group","xueshan_judge")
    SetTriggerOption("xueshan_judge3","group","xueshan_judge")
    SetTriggerOption("xueshan_judge4","group","xueshan_judge")
    EnableTriggerGroup("xueshan_judge",false)
    DeleteTriggerGroup("xueshan_f_ask")
    create_trigger_t('xueshan_f_ask1',"^(> )*����������й�",'','xueshan_f_ask')
    create_trigger_t('xueshan_f_ask2',"^(> )*����û������ˡ�$",'','xueshan_f_nobody')
    SetTriggerOption("xueshan_f_ask1","group","xueshan_f_ask")
    SetTriggerOption("xueshan_f_ask2","group","xueshan_f_ask")
    EnableTriggerGroup("xueshan_f_ask",false)
    DeleteTriggerGroup("xueshan_finish")
    create_trigger_t('xueshan_finish1',"^(> )*����˵���������������������������",'','xueshan_over')
    create_trigger_t('xueshan_finish2',"^(> )*����˵��������ʲô��˼����",'','xueshan_over')
    create_trigger_t('xueshan_finish3',"^(> )*����˵��������С��û��ɣ����뵽����үү",'','xueshan_fangqi')
    SetTriggerOption("xueshan_finish1","group","xueshan_finish")
    SetTriggerOption("xueshan_finish2","group","xueshan_finish")
    SetTriggerOption("xueshan_finish3","group","xueshan_finish")
    EnableTriggerGroup("xueshan_finish",false)
    DeleteTriggerGroup("xueshan_fight")
    create_trigger_t('xueshan_fight1','^(> )*(\\D*)��ž����һ�����ڵ���','','xueshan_sa')
    create_trigger_t('xueshan_fight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','xueshan_faint')
    create_trigger_t('xueshan_fight3',"^(> )*(\\D*)(������Ц��˵��|˫��һ����Ц��˵��|ʤ�����У����Ծ��|���һ�ݣ�˵��|���һ�ݣ�������Ҿ|������˼�����˵��|��ɫ΢�䣬˵������������)",'','xueshan_fight_over')
    SetTriggerOption("xueshan_fight1","group","xueshan_fight")
    SetTriggerOption("xueshan_fight2","group","xueshan_fight")
    SetTriggerOption("xueshan_fight3","group","xueshan_fight")
    EnableTriggerGroup("xueshan_fight",false)
    DeleteTriggerGroup("xueshan_sa")
    create_trigger_t('xueshan_sa1','^(> )*��ٺ���Ц�˼���','','xueshan_finish')
    create_trigger_t('xueshan_sa2','^(> )*��Ҫ��˭��','','xueshan_finish')
    SetTriggerOption("xueshan_sa1","group","xueshan_sa") 
    SetTriggerOption("xueshan_sa2","group","xueshan_sa")
    EnableTriggerGroup("xueshan_sa",false)
end
function xueshan_triggerDel()
    DeleteTriggerGroup("xueshan_find")
    DeleteTriggerGroup("xueshan_ask")
    DeleteTriggerGroup("xueshan_accept")
    DeleteTriggerGroup("xueshan_kill")
    DeleteTriggerGroup("xueshan_guard")
    DeleteTriggerGroup("xueshan_judge")
    DeleteTriggerGroup("xueshan_f_ask")
    DeleteTriggerGroup("xueshan_finish")
    DeleteTriggerGroup("xueshan_fight")
    DeleteTriggerGroup("xueshan_sa")
end

function xueshan()
    if hp.shen>=0 then
	   return turnShen('-')
	end
    xueshan_trigger()
    job.name='xueshan'
    job.time.b=os.time()
    job.flag()
    flag.xueshan=1
    job.target='����Ŀ��'
	xstab = {}
    return prepare_lianxi(xueshan_start)
end

function xueshanFindAgain()
    EnableTriggerGroup("xueshan_find",false)
    return go(xueshan_find_act,dest.area,dest.room)
end
function xueshanFindFail()
    EnableTriggerGroup("xueshan_find",false)
    return check_bei(xueshan_fangqi_go)
end
function xueshan_start()
    return go(job_xueshan,'��ѩɽ','���Ŀ�')
end
function job_xueshan()
    DeleteTriggerGroup("check_job")
    EnableTriggerGroup("xueshan_ask",true)
    exe('ask bao xiang about job')
    messageShow('ѩɽ��������ʼ��')
end
function xueshan_ask()
    EnableTriggerGroup("xueshan_ask",false)
    EnableTriggerGroup("xueshan_accept",true)
end
function xueshan_nobody()
    EnableTriggerGroup("xueshan_ask",false)
    xueshan_start()
end
function xueshan_busy()
    EnableTriggerGroup("xueshan_accept",false)
	job.last = "xueshan"
    return check_heal()
end
function xueshan_busy_dazuo()
    return prepare_neili(xueshan_start,1)
end

function xueshan_fangqi_go()
    return go(xueshan_fangqi,'��ѩɽ','���Ŀ�')
end
function xueshan_fangqi()
    EnableTriggerGroup("xueshan_finish",false)
    EnableTriggerGroup("xueshan_accept",false)
    return check_bei(xueshan_fangqi_ask)
end
function xueshan_fangqi_ask()
    EnableTriggerGroup("xueshan_ask",true)
    fight_prepare()
    exe('ask bao xiang about ����')
end
function xueshan_shibai()
    EnableTriggerGroup("xueshan_accept",false)
    return check_bei(xueshan_shibai_ask)
end
function xueshan_shibai_ask()
    EnableTriggerGroup("xueshan_ask",true)
    exe('ask bao xiang about ʧ��')
end
function xueshan_fangqi_heal()
    EnableTriggerGroup("xueshan_accept",false)
    --job.last = "xueshan"
    return xueshan()
end
function xueshan_rest()
    EnableTriggerGroup("xueshan_accept",false)
    job.last = "xueshan"
    return check_heal()
end
function xueshan_finish()
    EnableTriggerGroup("xueshan_accept",false)
    EnableTriggerGroup("xueshan_sa",false)
	for i=1,3 do
        exe('get gold from corpse '.. i)
    end
    flag.times=1
    go(xueshan_finish_ask,'��ѩɽ','���Ŀ�')
end
function xueshan_finish_error()
    EnableTriggerGroup("xueshan_sa",false)
    xueshan_fangqi_go()
    messageShow('ѩɽ����ɱ�걣���Ҳ�����Ů�ˣ����������')
end
function xueshan_finish_ask()
    EnableTriggerGroup("xueshan_accept",false)
    EnableTriggerGroup("xueshan_f_ask",true)
    exe('ask bao xiang about finish')
end
function xueshan_f_ask()
    EnableTriggerGroup("xueshan_f_ask",false)
    EnableTriggerGroup("xueshan_finish",true)
end
function xueshan_f_nobody()
    EnableTriggerGroup("xueshan_f_ask",false)
    return xueshan_finish()
end
function xueshan_over()
    EnableTriggerGroup("xueshan_finish",false)
	messageShow('ѩɽ����������ɣ�')
    return check_bei(check_heal)
end
function xueshan_consider(n,l,w)
    EnableTriggerGroup("xueshan_accept",false)
    job.where=tostring(w[2])
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    job.last = "xueshan"
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       check_bei(xueshan_fangqi)
       messageShow('ѩɽ��������ص㡾'..job.where..'�����ɵ�����������')
       return
    end
	messageShow('ѩɽ���񣺿�ʼǰ����'..job.where..'����Ѱ����Ů��')
    return check_bei(xueshan_find)
end
function xueshan_find()
    DeleteTriggerGroup("xueshan_find")
    create_trigger_t('xueshan_find1','(���|����|С��|����|����|����)\\(Beauty\\)','','xueshanBeauty')
    create_trigger_t('xueshan_find2','^(> )*��Ҫ��ʲô��','','xueshanFindGoon')
    create_trigger_t('xueshan_find3','^��������Ѫ������Ҫ��(\\D*)\\(\\D*\\)ǿ������Ů��','','xueshan_add')
    create_trigger_t('xueshan_find4','^(> )*����û�� beauty','','xueshanFindGoon')
    create_trigger_t('xueshan_find5','^(> )*���������\\D*һ���ж���','','xueshan_guard')
    create_trigger_t('xueshan_find6','^(> )*���Ѿ��������ˡ�','','xueshan_guard')
	create_trigger_t('xueshan_find7','^(> )*(\\D*) - ','','xueshanRoom')
	--create_trigger_t('xueshan_find8','^(> )*(\\D*) - $','','xueshanRoom')
	create_trigger_t('xueshan_find9','^(> )*��� "action" �趨Ϊ "������Ѱ��" �ɹ���ɡ�$','','xueshanFindCheck')
    SetTriggerOption("xueshan_find1","group","xueshan_find")
    SetTriggerOption("xueshan_find2","group","xueshan_find")
    SetTriggerOption("xueshan_find3","group","xueshan_find")
    SetTriggerOption("xueshan_find4","group","xueshan_find")
    SetTriggerOption("xueshan_find5","group","xueshan_find")
    SetTriggerOption("xueshan_find6","group","xueshan_find")
	SetTriggerOption("xueshan_find7","group","xueshan_find")
	--SetTriggerOption("xueshan_find8","group","xueshan_find")
	SetTriggerOption("xueshan_find9","group","xueshan_find")
    EnableTriggerGroup("xueshan_find",false)
    flag.times=1
	tmp.fast = true
	
    return check_bei(xueshan_find_go)
end
function xueshan_find_go()
    return go(xueshan_find_act,job.area,job.room)
end
function xueshan_find_act()
    EnableTriggerGroup("xueshan_find",true)
	EnableTrigger("xueshan_find7",false)
	EnableTrigger("xueshan_find8",false)
    job.flag()
    
	messageShow('ѩɽ���񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'������Ů��')
	
	if not tmp.fast then
	    return find()
	end
	
	tmp.beauty = 0
	tmp.xsroom = 0
	
	xstab = {}
	local path = searchPathGet()
	local pset = utils.split(path,";")
	for p,q in ipairs(pset) do
	    if not (isNil(q) or q=='halt') then 
	       table.insert(xstab,q)
		end
	end
	exe('look')
	return check_busy(xueshanFindCheck,1)
end
function xueshanFindCheck()
    EnableTrigger("xueshan_find7",false)
	EnableTrigger("xueshan_find8",false)
    --Note('tmp.beauty' .. tmp.beauty)
	--Note('tmp.xsroom' .. tmp.xsroom)
    if tmp.beauty and tmp.beauty > 0 then
	    if tmp.xsroom ==0 then
	        return xueshanFindLook()
	    else
	        return xueshanFindBack()
	    end
	else
	    return xueshanFindRoad()
	end
end
function xueshanFindLook()
    EnableTrigger("xueshan_find7",false)
	EnableTrigger("xueshan_find8",false)
    job.cnt=1
    exe('hp;look beauty')
end
function xueshanFindBack()
    tmp.xsroom = tmp.xsroom or 0
	
	for i = 1,tmp.xsroom do
	    table.remove(tmp.xsroad,1)
	end
	
	local path = ''
	
	for i = table.getn(tmp.xsroad),1,-1 do
	    if isNil(path) then
		    path = dirReverse[tmp.xsroad[i]]
		else
		    path = path .. ';' .. dirReverse[tmp.xsroad[i]]
		end
	end
	
	EnableTrigger("xueshan_find7",true)
	EnableTrigger("xueshan_find8",true)
	create_alias('goset','goset','alias goalias '.. path)
    exe('goset')
	exe('goalias')
	   
    return check_bei(xueshanFindLook)
end
function xueshanFindRoad()
    tmp.xsroom = 0
	tmp.xsroad = {}
	while table.getn(xstab)>0 do
	    if table.getn(tmp.xsroad)>9 then
		    return xueshanFindMove()
		end		
	    local path = xstab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.xsroad)>0 then
			    return xueshanFindMove()
		    else
			    table.remove(xstab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
						tmp.findfunc = "xueshanFindLook"
	                    return _G[func](params)
					else
					    exe(path)
						return xueshanFindLook()
					end
				else
				    exe(path)
					return xueshanFindLook()
				end
		    end
		else
		    table.remove(xstab,1)
		    table.insert(tmp.xsroad,path)
		end	
	end
	return xueshanFindMove()
end
function xueshanFindMove()
    tmp.xsroad = tmp.xsroad or {}
	if table.getn(tmp.xsroad)==0 then
	    EnableTriggerGroup("xueshan_kill",false)
        EnableTriggerGroup("xueshan_find",false)
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
		tmp.fast = nil
	    if flag.times > 2 then
	        messageShow('ѩɽ�����ڡ�'..job.where..'���Ҳ�����Ů�����������')
	        return xueshan_fangqi_go()
	    else
	        return xueshan_find_go()
	    end
	else
	    local path = table.concat(tmp.xsroad,";")
		
		EnableTrigger("xueshan_find7",true)
	    EnableTrigger("xueshan_find8",true)
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action ������Ѱ��')
	    end)
	end
end
function xueshanFindGoon()
    if not tmp.fast then
	    EnableTrigger("xueshan_find1",true)
        flag.wait=0
        flag.find=0
        return walk_wait()
	end
    tmp.beauty = 0
	tmp.xsroom = 0
	tmp.xsroad = tmp.xsroad or {}
	if table.getn(tmp.xsroad)==0 then
	    return xueshanFindCheck()
	else
	    return xueshanFindMove()
	end
end
function xueshanBeauty()
    if tmp.fast then
	    tmp.beauty = 1
	else 
	    EnableTrigger("xueshan_find1",false)
        if flag.wait==0 then
            flag.wait=1
            job.cnt=1
            exe('hp;look beauty')
        end
	end
end
function xueshanRoom()
    tmp.xsroom = tmp.xsroom or 0
    if tmp.beauty == 0 then
	    tmp.xsroom = tmp.xsroom + 1
	end
end
function xueshan_add(n,l,w)
    if w[1]==score.name then
       exe('follow beauty '.. job.cnt)
    else
       job.cnt=job.cnt + 1
       exe('look beauty '.. job.cnt)
    end
end
function xueshan_fight()
    if tmp.kill then
	   return
	end
	
	if hp.neili<hp.neili_max * 1.2 then
	    return prepare_neili(xueshan_fight)
	end
	   
    EnableTriggerGroup("xueshan_find",false)
    EnableTriggerGroup("xueshan_kill",true)
	EnableTriggerGroup("xueshan_fight",true)
    job.guard = job.guard or {}
	fight_prepare()
	messageShow('ѩɽ���񣺿�ʼFight���ڡ�'..job.target..'����')
    for i=1,3 do
       exe('fight guard '.. i)
    end
	exe('alias action fight')
end
function xueshan_fight_unaccept(n,l,w)
    job.guard[w[2]]=nil
end
function xueshan_fight_judge()
    EnableTriggerGroup("xueshan_kill",false)
    if countTab(job.guard)==1 then
	   EnableTriggerGroup("xueshan_fight",true)
	   for p in pairs(job.guard) do
	       job.target = p
		   create_timer_s('xsfight',3,'xueshan_fight')
	   end
	else
	   return check_bei(xueshan_kill,1)
	end
end
function xueshan_fight_over(n,l,w)
    if w[2]==job.target or w[2]=="��" then
	   DeleteTimer('xsfight')
	   EnableTrigger("xueshan_fight3",false)
	   
	   return checkWait(xueshan_fight,3)
	end
end
function xueshan_kill_act()
    for i=1,3 do
       exe('kill guard '.. i)
    end
end
function xueshan_kill()
    EnableTriggerGroup("xueshan_find",false)
    EnableTriggerGroup("xueshan_kill",true)
    job.guard={}
	DeleteTimer('xsfight')
    for i=1,3 do
       exe('kill guard '.. i)
    end
end
function xueshan_kill_who(n,l,w)
    job.guard[w[2]]=true
end
function xueshan_kill_judge(n,l,w)
    local l_str = del_string(w[2],'����������')
	Note(l_str)
    --for i=1,countTab(job.guard) do
        if job.guard[l_str] and l_str~= "������ʿ" and l_str~= "������ʿ" and l_str~= "������ʿ" then
	       job.target=l_str
	       dis_all()
	       EnableTriggerGroup("xueshan_kill",false)
	       EnableTriggerGroup("xueshan_fight",true)
	    end
    --end
end
function xueshan_kill_nobody()
    EnableTriggerGroup("xueshan_kill",false)
    EnableTriggerGroup("xueshan_find",false)
    if flag.xueshan > 1 then
	   messageShow('ѩɽ������Ůû�б��ڣ����������')
       return check_bei(xueshan_fangqi_go)
    else
       flag.xueshan = flag.xueshan + 1
	   if tmp.kill then
	      return xueshan_sa_act()
	   else
          return check_bei(xueshan_find_go)
	   end
    end
end
function xueshan_kill_nofight()
    for i=1,3 do
       exe('askk guard '.. i ..' about fight')
    end
    return check_bei(xueshan_judge,1)
end
function xueshan_faint(n,l,w)
    if w[2]==job.target then
       tmp.kill=true
       DeleteTimer('xsfight')
       messageShow('ѩɽ���񣺿�ʼ������ڡ�'..job.target..'����')
       for i=1,3 do
          exe('kill guard '.. i)
       end
    end  
end
function xueshan_sa(n,l,w)
    if job.target==w[2] then
       tmp.kill=true
	   tmp.findfunc = nil
       EnableTriggerGroup("xueshan_fight",false)
       messageShow('ѩɽ���񣺸㶨���ڡ�'..job.target..'����')
       return check_bei(xueshan_sa_act,1)
    end
end
function xueshan_sa_act()
       EnableTriggerGroup("xueshan_sa",true)
       for i=1,3 do
          exe('sa beauty '.. i)
       end
end
function xueshan_guard()
    EnableTriggerGroup("xueshan_find",false)
    EnableTriggerGroup("xueshan_guard",true)
    flag.wait=0
    flag.find=1
    --thread_resume(lookfor)
	locate()
    exe('look;alias action check_guard')
end
function xueshan_guard_check(n,l,w)
end
function xueshan_guard_look()
    EnableTriggerGroup("xueshan_guard",false)
    EnableTriggerGroup("xueshan_judge",true)
    exe('look guard;alias action judge_guard')
    job.weapon='unarmed'
end
function xueshan_judge_party(n,l,w)
    job.party=w[2]
end
function xueshan_judge_super()
    tmp.super=true
end
function xueshan_judge_weapon(n,l,w)
    if w[1]=='���' then
       job.weapon='stick'
    elseif w[1]=='����' then
       job.weapon='sword'
    elseif w[1]=='�ֵ�' then
       job.weapon='blade'
    elseif w[1]=='����' then
       job.weapon='whip'
    elseif w[1]=='��' then
       job.weapon='xiao'
    elseif w[1]=='һ������' then
       job.weapon='dagger'
    else
       job.weapon='unarmed'
    end
end
function xueshan_judge()
    EnableTriggerGroup("xueshan_judge",false)
    job.skill='��'
    messageShow('ѩɽ���񣺱������ԡ�'..job.party..'����')
    if hp.exp>8000000 and job.party and job.party=='�䵱' and job.weapon=='unarmed' and tmp.super then
       messageShow('ѩɽ��������̫��ȭ���֣����������')
	   return xueshan_fangqi_go()
    end
	if hp.exp>8000000 and job.party and job.party=='��ɽ' and job.weapon=='sword' and tmp.super then
       messageShow('ѩɽ�����������¾Ž����֣����������')
	   return xueshan_fangqi_go()
    end
	--if hp.exp>8000000 and job.party and job.party=='��ɽ' and job.weapon=='blade' and tmp.super then
    --   messageShow('ѩɽ�������������ǵ����֣����������')
	--   return xueshan_fangqi_go()
    --end
	if locl.id["������ʿ"] or locl.id["������ʿ"] or locl.id["������ʿ"] then
	   EnableTriggerGroup("xueshan_guard",false)
	   return wipe("wei shi",xueshan_guard)
	end
	for p,q in pairs(dangerousNpc) do
	    if locl.id[p] and locl.id[p]==q then
		   EnableTriggerGroup("xueshan_guard",false)
	       return wipe(locl.id[p],xueshan_guard)
		end
	end
	if tmp.super then
	   messageShow('ѩɽ�����������ڸ��֡�')
	end
	job.guard = {}
	
	local autokill = {
	--      ["tangshi-jianfa"] = true,
	--	  ["wuhu-duanmendao"] = true,
		  ["dagou-bang"] = true,
		  ["yuxiao-jian"] = true,
	}
	
	fight_prepare()
	
	--if perform.skill and autokill[perform.skill] then
	--   return checkWait(xueshan_kill,2)
	--end
	
	if GetVariable("flagkill") then
	   flag.kill = tonumber(GetVariable("flagkill"))
	end
	if flag.kill and flag.kill==1 then
       return checkWait(xueshan_kill,2)
	end
	
	return create_timer_s('xsfight',2,'xueshan_fight')
	--return checkWait(xueshan_fight,2)
	--else
    --   return check_bei(xueshan_kill)
    --end
end