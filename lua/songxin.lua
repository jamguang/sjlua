------����

job.list = job.list or {}
job.list["songxin"] = "��������"
job.list["songxin2"] = "��������2"
joblast = joblast or {}
joblast["��������"] = "songxin"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["songxin"] = "songxin_triggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["songxin"] = "songxinFindAgain"
jobFindAgain["songxin2"] = "songxinFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["songxin"] = "songxinFindFail"
jobFindFail["songxin2"] = "songxinFindFail"
faintFunc = faintFunc or {}
faintFunc["songxin"] = "songxinFaint"
faintFunc["songxin2"] = "songxinFaint"

local ftab = {}

sxjob={}
sxjob.cancel='��������|��ľ�����|��������|��ˮ�����|���������|�һ������|֪�͵���|������|������|�ͷ|ֵ�ڱ�|����Ϫ|��һ��|����»|������|��Ѳ��|������|����ʹ��|��ѩ��|������|���°���|���°���|����|����|����ʦ̫|������|������|������'
sxjob.skillslist=''
sxjob.killer1='ɱ��һ'
sxjob.killer1='ɱ�ֶ�'
sxjob.skills='XXXXX'
sxjob.sx2=0
sxjob.id='sxtarget'

local dangerousNpc = {
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


function songxin_trigger()
    DeleteTriggerGroup("songxin_find")
    DeleteTriggerGroup("songxin_ask")
    create_trigger_t('songxin_ask1',"^>*\\s*�������������",'','songxin_ask')
    create_trigger_t('songxin_ask2',"^>*\\s*����û������ˡ�$",'','songxin_nobody')
    SetTriggerOption("songxin_ask1","group","songxin_ask")
    SetTriggerOption("songxin_ask2","group","songxin_ask")
    EnableTriggerGroup("songxin_ask",false)
    DeleteTriggerGroup("songxin_accept")
    create_trigger_t('songxin_accept1',"^>*\\s*������\\D*˵������\\D*���㲻�Ǳ�������ӣ��˻��Ӻ�˵��",'','songxin_join')
    create_trigger_t('songxin_accept2',"^>*\\s*������\\D*˵������(����ȥ��Ϣһ��ɣ�|������ʱû�и��������)",'','songxin_busy')
    create_trigger_t('songxin_accept3',"^>*\\s*������\\D*˵��������Ȼ\\D*�����ˣ�Ҳ�Ͱ��ˡ�",'','songxin_fangqi_heal')
    create_trigger_t('songxin_accept4',"^>*\\s*������\\D*˵�������㲻���Ѿ��������ŵ������𣿻�����ȥ����",'','songxin_fangqi')
    create_trigger_t('songxin_accept5',"^>*\\s*������\\D*˵�����������������������񣬻���ȥ��Ϣһ��ɡ�",'','songxin_rest')
    create_trigger_t('songxin_accept6',"^>*\\s*�����ｻ����һ���ܺ���",'','songxin_xin')
	create_trigger_t('songxin_accept7',"^^(> )*������\\D*˵������\\D*�㲢û���������ŵ�����˵ʲô������",'','songxin_rest')
    SetTriggerOption("songxin_accept1","group","songxin_accept")
    SetTriggerOption("songxin_accept2","group","songxin_accept")
    SetTriggerOption("songxin_accept3","group","songxin_accept")
    SetTriggerOption("songxin_accept4","group","songxin_accept")
    SetTriggerOption("songxin_accept5","group","songxin_accept")
    SetTriggerOption("songxin_accept6","group","songxin_accept")
	SetTriggerOption("songxin_accept7","group","songxin_accept")
    EnableTriggerGroup("songxin_accept",false)
    DeleteTriggerGroup("songxin_letter")
    create_trigger_t('songxin_letter1',"^>*\\s*��(\\D*) (\\D*)�� ������",'','songxin_consider')
    SetTriggerOption("songxin_letter1","group","songxin_letter")
    EnableTriggerGroup("songxin_letter",false)
    DeleteTriggerGroup("songxin_killer")
    create_trigger_t('songxin_killer1',"^>*\\s*����Լ�о�������Χ�˹�����",'','songxin_killer')
    create_trigger_t('songxin_killer2',"^>*\\s*(\\D*)˵������С�ӣ��Թ԰��ܺ��������ɣ�������",'','songxin_killer_1')
    create_trigger_t('songxin_killer3',"^>*\\s*��⣬�ֳ������˸��ˣ�",'','songxin_killer_2')
    create_trigger_t('songxin_killer4',"^>*\\s*(\\D*)˵������ʦ�֣�����Ӳ�úܣ��������㣡������",'','songxin_killer_3')
    SetTriggerOption("songxin_killer1","group","songxin_killer")
    SetTriggerOption("songxin_killer2","group","songxin_killer")
    SetTriggerOption("songxin_killer3","group","songxin_killer")
    SetTriggerOption("songxin_killer4","group","songxin_killer")
    EnableTriggerGroup("songxin_killer",false)
    DeleteTriggerGroup("songxin2_check")
    create_trigger_t('songxin2_check1',"(> )*\\D*����Ķ�������˵������Ͻ������͵���(\\D*)���ġ�(\\D*)�����ϡ�",'','songxin2_target')
    create_trigger_t('songxin2_check2',"(> )*\\D*����Ķ�������˵���������и��书�������(\\D*)�ļһ�Ҫ������",'','songxin2_level')
    create_trigger_t('songxin2_check3','^>*\\s*��� "action" �趨Ϊ "sx_back" �ɹ���ɡ�','','songxin2_consider')
    SetTriggerOption("songxin2_check1","group","songxin2_check")
    SetTriggerOption("songxin2_check2","group","songxin2_check")
    SetTriggerOption("songxin2_check3","group","songxin2_check")
    EnableTriggerGroup("songxin2_check",false)
    DeleteTriggerGroup("songxin2_killer")
    create_trigger_t('songxin2_killer1',"^>*\\s*�㶨��һ����ԭ����(\\D*)�����Ҵ���\\D*���ƺ��õ���(\\D*)��(\\D*)��",'','songxin2_check')
    SetTriggerOption("songxin2_killer1","group","songxin2_killer")
    EnableTriggerGroup("songxin2_killer",false)
end
function songxin_triggerDel()
    DeleteTriggerGroup("songxin_find")
    DeleteTriggerGroup("songxin_ask")
    DeleteTriggerGroup("songxin_accept")
    DeleteTriggerGroup("songxin_letter")
    DeleteTriggerGroup("songxin_killer")
    DeleteTriggerGroup("songxin2_check")
    DeleteTriggerGroup("songxin2_killer")
    DeleteTriggerGroup("songxin_fight")
end

function songxin()
    songxin_trigger()
    job.name='songxin'
    job.time.b=os.time()
	if jobLevel and jobLevel["sxlvl"] and jobLevel["sxlvl"] < hp.pot_max - 95 then
	   jobLevel["songxin"] = 10
	   jobLevel["sxlvl"] = hp.pot_max - 100
	end
    return prepare_lianxi(songxin_start)
end

function songxinFindAgain()
    EnableTriggerGroup("songxin_find",false)
    return go(songxin_find_go,dest.area,dest.room)
end
function songxinFaint()
    jobLevel = jobLevel or {}
	if job.level and jobLevel[job.level] and jobLevel["songxin"] and jobLevel["songxin"]>jobLevel[job.level] then
	   jobLevel["songxin"] = jobLevel[job.level]
	   if jobLevel["songxin"] and jobLevel["songxin"] < 5 then
	      jobLevel["songxin"] = 5
	   end
	   jobLevel["sxlvl"] = hp.pot_max - 100
	end
    return songxin_fangqi_go()
end
function songxinFindFail()
    EnableTriggerGroup("songxin_find",false)
    return go(songxin_fangqi,'�����','��վ')
end
function songxin_start()
    return go(job_songxin,'�����','��վ')
end
function job_songxin()
    DeleteTriggerGroup("check_job")
    EnableTriggerGroup("songxin_ask",true)
    exe('ask zhu wanli about job')
    messageShow('������������ʼ��')
end
function songxin_ask()
    EnableTriggerGroup("songxin_ask",false)
    EnableTriggerGroup("songxin_accept",true)
end
function songxin_nobody()
    EnableTriggerGroup("songxin_ask",false)
    songxin_start()
end
function songxin_join()
    EnableTriggerGroup("songxin_accept",false)
    check_bei(songxin_join_go)
end
function songxin_join_go()
    exe('w;s;e;e;n;n;n;e;s;askk fu about join')
    check_bei(songxin_huanggong_ask)
end
function songxin_huanggong_ask()
    exe('n;w;#3s;#4w;#3n;w;askk gao shengtai about ��ʹ�')
    check_bei(songxin_start)
end
function songxin_busy()
    EnableTriggerGroup("songxin_accept",false)
    check_bei(songxin_busy_dazuo)
end
function songxin_busy_dazuo()
    exe('w;w')
    prepare_lianxi(songxin_start)
end
function songxin_fangqi()
    EnableTriggerGroup("songxin_accept",false)
    check_bei(songxin_fangqi_ask)
end
function songxin_fangqi_ask()
    EnableTriggerGroup("songxin_ask",true)
    exe('ask zhu wanli about ����')
end
function songxin_fangqi_heal()
    EnableTriggerGroup("songxin_accept",false)
    return check_bei(job_songxin)
end
function songxin_rest()
    EnableTriggerGroup("songxin_accept",false)
    job.last="songxin"
    check_bei(check_heal)
end
function songxin_xin()
    EnableTriggerGroup("songxin_accept",false)
    EnableTriggerGroup("songxin_letter",true)
    job.last="songxin"
    exe('look letter')
end
function songxin_consider(n,l,w)
    EnableTriggerGroup("songxin_letter",false)
    job.where=tostring(w[1])
    job.target=tostring(w[2])
    if string.find(sxjob.cancel,job.target) then
       messageShow('������������Ŀ�꡾'..job.target..'�������ʹ���������')
       return check_bei(songxin_fangqi)
    end
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if WhereIgnores[job.where] or AddrIgnores[dest.area] or not job.room or not path_cal() then
       messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return check_bei(songxin_fangqi)
    end
	job.killer={}
	messageShow('������������Ŀ�꡾'..job.target..'������ʼǰ����'..job.where..'�����ȴ�Killer��')
    return check_bei(songxin_find)
end
function songxin_find()
    DeleteTriggerGroup("songxin_find")
    create_trigger_t('songxin_find1','^>*\\s*\\D*'..job.target..'\\((\\D*)\\)','','songxin_send')
    create_trigger_t('songxin_find2','^>*\\s*��Ҫ�͸�˭','','songxin_goon')
    create_trigger_t('songxin_find3','^>*\\s*\\D*����(����Ų��Ǹ��ҵģ�|�㿴�����)','','songxin_add')
    create_trigger_t('songxin_find4','^>*\\s*����Ų����͸�����˵ġ�','','songxin_add')
    create_trigger_t('songxin_find5','^>*\\s*�����һ�Ѷ�ͷ�ĺ����ӻ����ͳ��Ž���','','songxin_finish')
	create_trigger_t('songxin_find6','^(> )*(\\D*) - ','','songxinRoom')
	create_trigger_t('songxin_find7','^(> )*��� "action" �趨Ϊ "������Ѱ��" �ɹ���ɡ�$','','songxinFindCheck')
	create_trigger_t('songxin_find8','^(> )*������㣬���ǻ����𣿣�','','songxinSendWait')
    SetTriggerOption("songxin_find1","group","songxin_find")
    SetTriggerOption("songxin_find2","group","songxin_find")--
    SetTriggerOption("songxin_find3","group","songxin_find")
    SetTriggerOption("songxin_find4","group","songxin_find")
    SetTriggerOption("songxin_find5","group","songxin_find")
	SetTriggerOption("songxin_find6","group","songxin_find")
	SetTriggerOption("songxin_find7","group","songxin_find")
	SetTriggerOption("songxin_find8","group","songxin_find")
    EnableTriggerGroup("songxin_find",false)
    EnableTrigger("songxin_killer1",true)
    job.flag()
    flag.times=1
	tmp.fast = true
	
    fight_prepare()
    --if skills.force.pot==(skills.force.lvl+1)*(skills.force.lvl+1) then
    --   go(prepare_neili,job.area,job.room)
    --else
	if score.party and score.party~= "����Ľ��" and job.area and (job.area=="����Ľ��" or job.area=="������" or job.area=="��٢��ɽׯ") then
	   return go(prepare_neili,"����Ľ��","��ͷ")
	elseif score.party and score.party~= "������" and job.area and job.area=="������" then
	   return go(prepare_neili,"������","��̲")
	else
       --return go(songxin_find_go,job.area,job.room)
	   return go(prepare_neili,job.area,job.room)
    end
end
function songxin_find_go()
    EnableTriggerGroup("songxin_find",true)
	EnableTrigger("songxin_find6",false)
    job.flag()
    exe('look')
    messageShow('�������񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'���ġ�'.. job.target ..'�����������ţ�')
	
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
	return check_busy(songxinFindCheck,1)
end
function songxinFindCheck()
    EnableTrigger("songxin_find6",false)
    --Note('tmp.target' .. tmp.target)
	--Note('tmp.froom' .. tmp.froom)
    if tmp.target and tmp.target > 0 then
	    if tmp.froom ==0 then
	        return songxin_check()
	    else
	        return songxinFindBack()
	    end
	else
	    return songxinFindRoad()
	end
end
function songxinFindBack()
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
	
	EnableTrigger("songxin_find6",true)
	create_alias('goset','goset','alias goalias '.. path)
    exe('goset')
	exe('goalias')
	   
    return check_bei(songxin_check)
end
function songxinFindRoad()
    tmp.froom = 0
	tmp.froad = {}
	while table.getn(ftab)>0 do
	    if table.getn(tmp.froad)>9 then
		    return songxinFindMove()
		end		
	    local path = ftab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.froad)>0 then
			    return songxinFindMove()
		    else
			    table.remove(ftab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
						tmp.findfunc = "songxin_check"
	                    return _G[func](params)
					else
					    exe(path)
						return songxin_check()
					end
				else
				    exe(path)
					return songxin_check()
				end
		    end
		else
		    table.remove(ftab,1)
		    table.insert(tmp.froad,path)
		end	
	end
	return songxinFindMove()
end
function songxinFindMove()
    tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    EnableTriggerGroup("songxin_kill",false)
        EnableTriggerGroup("songxin_find",false)
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
		tmp.fast = nil
	    if flag.times > 2 then
	        messageShow('���������ڡ�'..job.where..'���Ҳ�����' .. job.target ..'�������������')
	        return songxin_fangqi_go()
	    else
	        return songxinFindAgain()
	    end
	else
	    local path = table.concat(tmp.froad,";")
		
		EnableTrigger("songxin_find6",true)
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action ������Ѱ��')
	    end)
	end
end
function songxinRoom()
    tmp.froom = tmp.froom or 0
    if tmp.target == 0 then
	    tmp.froom = tmp.froom + 1
	end
end
function songxin_send(n,l,w)
    
	sxjob.id=string.lower(w[1])
	sxjob.cnt=1
	
	if tmp.fast then
	    tmp.target = 1
	else 
        if flag.wait==0 then
		   EnableTrigger("songxin_find1",false)
           flag.wait=1
           exe('hp;follow '..sxjob.id)
           --checkBags()
           return checkWait(songxin_check,1)
           --return check_halt(songxin_send_act)
        end
	end
end
function songxin_check()    
    EnableTrigger("songxin_find6",false)
	checkBags()
	locate()
	return checkWait(songxin_dangerous,1)
    --return checkWait(songxin_send_act,1)
end
function songxin_dangerous()
    for p,q in pairs(dangerousNpc) do
	    if locl.id[p] and locl.id[p]==q then
	       return wipe(locl.id[p],songxin_send_act)
		end
	end
	return check_bei(songxin_send_act)
end
function songxin_send_act()
    if not Bag["�ż�"] then
	    messageShow('���������ż���ʧ�����������')
	    return songxin_fangqi_go()
	end
    exe('halt;songxin '..sxjob.id)
    tmp.cnt = 0
end
function songxin_act_set()
    if tmp.cnt then
	   tmp.cnt = tmp.cnt + 1
	end
    if not tmp.cnt or tmp.cnt > 50 then
       return check_heal()
    end
    exe('halt;songxin '..sxjob.id..' '..sxjob.cnt)
end
function songxin_add()
    sxjob.cnt=sxjob.cnt + 1
    exe('halt;songxin '..sxjob.id..' '..sxjob.cnt)
    tmp.cnt = 0
	EnableTrigger("hp12",true)
    --create_timer_s('songxin',1,'songxin_act_set')
end
function songxinSendWait()
    wait.make(function()
        wait.time(3)
	    songxin_act_set()
    end)
end
function songxin_goon()
    if not tmp.fast then
        EnableTrigger("songxin_find1",true)
        flag.wait=0
        DeleteTimer('songxin')
        return walk_wait()
    end
	tmp.target = 0
	tmp.froom = 0
	tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    return songxinFindCheck()
	else
	    return songxinFindMove()
	end
end
function songxin_finish()
    dis_all()
    flag.find=1
    flag.times=1 
	tmp.findfunc = nil
    locate()
    sxjob.sx2=0
    messageShow('��������������ɣ�')
    EnableTriggerGroup("songxin2_check",true)
	return check_bei(songxin_back,1)
end
function songxin_back()
    condition = {}
    exe('cond')
    exe('follow none;hp;alias action sx_back')
end
function songxin_killer()
    flag.find=1
    dis_all()
    exe('halt')
    EnableTrigger("songxin_killer2",true)    
end
function songxin_killer_1(n,l,w)
    EnableTrigger("songxin_killer2",false)
    EnableTrigger("songxin_killer3",true)
    sxjob.killer1=tostring(w[1])
    sxjob.killer2='͵��ɱ��2'
    sxjob.letter=0
    sxjob.id1='killer1'
    sxjob.id2='killer2'
	job.killer[sxjob.killer1]=true
    DeleteTriggerGroup("songxin_fight")
    create_trigger_t('songxin_fight1','^>*\\s*\\D*'..sxjob.killer1..'\\((\\D*)\\)','','songxin_kill_1')
    create_trigger_t('songxin_fight2','^>*\\s*(\\D*)��ž����һ�����ڵ���','','songxin_kill_die')
    create_trigger_t('songxin_fight3','^>*\\s*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','songxin_kill_faint')
    create_trigger_t('songxin_fight4','^  (\\D*)���ż�','','songxin_letter')
    create_trigger_t('songxin_fight5','^>*\\s*���빥��˭��','','songxin_kill_over')
    create_trigger_t('songxin_fight6','^>*\\s*��� "action" �趨Ϊ "check_letter" �ɹ���ɡ�','','songxin_kill_check')
    create_trigger_t('songxin_fight7','^(> )*(\\D*)�������ù���һ�㲻��ʮ�壬���ǻ������ģ�','','songxin_kill_fail')
    SetTriggerOption("songxin_fight1","group","songxin_fight") 
    SetTriggerOption("songxin_fight2","group","songxin_fight")
    SetTriggerOption("songxin_fight3","group","songxin_fight")
    SetTriggerOption("songxin_fight4","group","songxin_fight")
    SetTriggerOption("songxin_fight5","group","songxin_fight")
    SetTriggerOption("songxin_fight6","group","songxin_fight")
    SetTriggerOption("songxin_fight7","group","songxin_fight")
    exe('look')
    exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
    messageShow('�������񣺿�ʼ���͵��ɱ��1��'..sxjob.killer1)
end
function songxin_letter(n,l,w)
    if tostring(w[1])=='һ' or tostring(w[1])=='��' then
       sxjob.letter=1
    end
	--if tostring(w[1])=='��' then
    --   dis_all()
	--   return husongQuit()
    --end
end
function songxin_killer_2()
    EnableTrigger("songxin_killer3",false)
    EnableTrigger("songxin_killer4",true)
end
function songxin_killer_3(n,l,w)
    EnableTrigger("songxin_killer4",false)
    sxjob.killer2=tostring(w[1])
	job.killer[sxjob.killer2]=true
    create_trigger_t('songxin_fight7','^>*\\s*\\D*'..sxjob.killer2..'\\((\\D*)\\)','','songxin_kill_2')
    SetTriggerOption("songxin_fight7","group","songxin_fight")
    exe('look')
    messageShow('�������񣺿�ʼ���͵��ɱ��2��'..sxjob.killer2)
end
function songxin_kill_1(n,l,w)
    sxjob.id1=string.lower(w[1])
	job.killer[sxjob.killer1]=sxjob.id1
    --exe('kill '..sxjob.id1)
	killPfm(sxjob.id1)
end
function songxin_kill_2(n,l,w)
    sxjob.id2=string.lower(w[1])
	job.killer[sxjob.killer2]=sxjob.id2
    --exe('kill '..sxjob.id2)
	killPfm(sxjob.id2)
end
function songxin_kill_faint(n,l,w)
    if w[1]==sxjob.killer1 then
       exe('fight '..sxjob.id1)
    end
    if w[1]==sxjob.killer2 then
       exe('fight '..sxjob.id2)
    end    
end
function songxin_kill_die(n,l,w)
    if w[1]==sxjob.killer1 then
       --exe('fight '..sxjob.id2)
       messageShow('�������񣺸㶨͵��ɱ��1��'..sxjob.killer1)
	   --return songxinWaitKill2()
	   wait.make(function() 
          wait.time(2)
          exe('fight '.. sxjob.id2)
       end)
    end
    if w[1]==sxjob.killer2 then
       --exe('fight '..sxjob.id1)
       messageShow('�������񣺸㶨͵��ɱ��2��'..sxjob.killer2)
	   --return songxinWaitKill1()
	   wait.make(function() 
          wait.time(2)
          exe('fight '.. sxjob.id1)
       end)
    end    
end
function songxin_kill_over()
    EnableTriggerGroup("songxin_killer",false)
	job.killer={}
    return check_bei(songxin_kill_get)
end
function songxin_kill_get()
    for i=1,3 do
       exe('get letter from corpse '..i)
	   if score.gold<5000 then
	      exe('get silver from corpse '..i)
	   end
    end
    weapon_unwield()
    exe('i;alias action check_letter')
end
function songxin_kill_check()
    EnableTriggerGroup("songxin_fight",false)
	job.flag()
    flag.times=1
	tmp.fast = true
    if sxjob.letter==1 then
       if locl.room==job.room and locl.area==job.area then
          return songxin_find_go()
       else
          return go(songxin_find_go,job.area,job.room)
       end
    else
       return go(songxin_fangqi,'�����','��վ')
    end
end
function songxin_kill_fail(n,l,w)
    if w[2]==sxjob.killer1 or w[2]==sxjob.killer2 then
       EnableTriggerGroup("songxin_fight",false)
	   job.killer={}
       checkBags()
       return check_halt(songxin_kill_letter)
    end
end
function songxin_kill_letter()
    if Bag["�ż�"] then
       return go(songxin_find_go,job.area,job.room)
    else
       return go(songxin_fangqi,'�����','��վ')
    end
end
function songxin2_target(n,l,w)
    sxjob.killer1='͵��ɱ��1'
    sxjob.killer2='͵��ɱ��2'
    sxjob.letter=0
    sxjob.id1='killer1'
    sxjob.id2='killer2'
    sxjob.sx2=1
    job.target=tostring(w[3])
    job.where=tostring(w[2])
    create_trigger_t('songxin_find1','^>*\\s*\\D*'..job.target..'\\((\\D*)\\)','','songxin_send')
    SetTriggerOption("songxin_find1","group","songxin_find")
    EnableTriggerGroup("songxin_find",false)
end
function songxin2_level(n,l,w)
    job.level=tostring(w[2])
end
function songxin2_consider()
    EnableTriggerGroup("songxin2_check",false)
    --do return songxin2_refuse() end
	if not flag.sx2 then return songxin2_refuse() end
    if job.zuhe["hubiao"] and (not condition.hubiao or condition.hubiao==0) then
       return songxin2_refuse()
    end
	if job.zuhe["smy"] and (not condition.smy or condition.smy==0) then
       return songxin2_refuse()
    end
    if string.find(sxjob.cancel,job.target) or sxjob.sx2==0 then 
       if sxjob.sx2==1 then
          messageShow('������������Ŀ�꡾'..job.target..'�������ʹ����ܾ���')
       end
       return check_bei(songxin2_refuse)
    end
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
	job.name='songxin2'
    if WhereIgnores[job.where] or not job.room or not path_cal() then
       messageShow('������������ص㡾'..job.where..'�����ɵ������ܾ���')
       return songxin2_refuse()
    end
	
	if job.level and jobLevel[job.level] and jobLevel["songxin"] and jobLevel[job.level] >= jobLevel["songxin"] then
	   messageShow('��������'.. job.target ..'���书�ǡ�'.. job.level ..'���������У����������')
	   return songxin2_refuse()
	end
	
    messageShow('������������Ŀ���ǡ�'..job.where..'���ġ�'..job.target..'����ɱ�ֵȼ�Ϊ��'..job.level..'����ԭ�صȴ�Killer��')
    return songxin2_wait()
end
function songxin2_refuse()
    songxin_triggerDel()
    exe('no')
	return check_heal()
    --return go(check_heal,'������','ҩ��')
end
function songxin2_wait()
    EnableTriggerGroup("songxin2_killer",true)
    return prepare_neili(fight_prepare)
end
function songxin2_check(n,l,w)
    EnableTriggerGroup("songxin2_killer",false)
    sxjob.killer1=tostring(w[1])
    sxjob.skills=tostring(w[3])
    prepare_neili_stop()
	job.killer[sxjob.killer1]=true
    if skillIgnores[sxjob.skills] then
       messageShow('��������ɱ��ʹ�õ��书�ǡ�'..w[2]..'���ġ�'..sxjob.skills..'���������У����������')
	   return songxin2_fangqi()
    else
       messageShow('��������ɱ��ʹ�õ��书�ǡ�'..w[2]..'���ġ�'..sxjob.skills..'������ʼ�����')
       return songxin2_kill()    
    end
end
function songxin2_fangqi()
    dis_all()
    exe('set wimpycmd halt\\'..locl.dir)
    return check_bei(songxin_fangqi_go)
end
function songxin_fangqi_go()
    dis_all()
    return go(songxin_fangqi,'�����','��վ')
end
function songxin2_kill()
    DeleteTriggerGroup("songxin_fight")
    create_trigger_t('songxin_fight1','^>*\\s*\\D*'..sxjob.killer1..'\\((\\D*)\\)','','songxin_kill_1')
    create_trigger_t('songxin_fight2','^>*\\s*(\\D*)��ž����һ�����ڵ���','','songxin_kill_die')
    create_trigger_t('songxin_fight3','^>*\\s*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','songxin_kill_faint')
    create_trigger_t('songxin_fight4','^  (\\D*)���ż�','','songxin_letter')
    create_trigger_t('songxin_fight5','^>*\\s*���빥��˭��','','songxin_kill_over')
    create_trigger_t('songxin_fight6','^>*\\s*��� "action" �趨Ϊ "check_letter" �ɹ���ɡ�','','songxin_kill_check')
    SetTriggerOption("songxin_fight1","group","songxin_fight") 
    SetTriggerOption("songxin_fight2","group","songxin_fight")
    SetTriggerOption("songxin_fight3","group","songxin_fight")
    SetTriggerOption("songxin_fight4","group","songxin_fight")
    SetTriggerOption("songxin_fight5","group","songxin_fight")
    SetTriggerOption("songxin_fight6","group","songxin_fight")
    exe('look')
	exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
end