require "wait"
require "tprint"
require "message"
require "lujing"
require "chat"
require "job"
require "rooms"
--require "emoted"
require "xuncheng"
require "skill"
require "weapon"
require "button"
require "party"



-- ����һ����ͨ����
function create_alias(a_name,a_match,a_response)
      return AddAlias(a_name,a_match,a_response,alias_flag.Enabled+alias_flag.Replace+alias_flag.RegularExpression,'')
end
-- ����һ���ű�����
function create_alias_s(a_name,a_match,a_function)
      return AddAlias(a_name,a_match,'',alias_flag.Enabled+alias_flag.Replace,a_function)
end
-- ����һ���ֶ�ʱ��
function create_timer_m(t_name,t_min,t_function)
      return AddTimer(t_name,0,t_min,0,'',timer_flag.Enabled+timer_flag.ActiveWhenClosed+timer_flag.Replace,t_function)
end
-- ����һ���붨ʱ��
function create_timer_s(t_name,t_second,t_function)
      return AddTimer(t_name,0,0,t_second,'',timer_flag.Enabled+timer_flag.ActiveWhenClosed+timer_flag.Replace,t_function)
end
-- ����һ��һ�����붨ʱ��
function create_timer_st(t_name,t_second,t_function)
      return AddTimer(t_name,0,0,t_second,'',timer_flag.Enabled+timer_flag.ActiveWhenClosed+timer_flag.Replace+timer_flag.OneShot,t_function)
end
-- ����һ�������� 
function create_trigger_t(t_name,t_match,t_response,t_function )
      return AddTrigger(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace,-1,0,"",t_function)
end
-- ����һ����ʱ�Ĵ�����(������Ϣ��ɫ�ı䣬��Ŀ) 
function create_trigger_tc(t_name,t_match,t_response,t_function )
      return AddTrigger(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace,8,0,"",t_function)
end
-- ����һ����ʱ�Ĵ����� 
function create_trigger_f(t_name,t_match,t_response,t_function )
      return AddTrigger(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace+trigger_flag.Temporary,-1,0,"",t_function)
end
-- ����һ����ʱ��һ���Դ����� 
function create_trigger(t_name,t_match,t_response,t_function )
      return AddTrigger(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace+trigger_flag.Temporary+trigger_flag.OneShot,-1,0,"",t_function)
end
-- ����һ��ex������ 
function create_triggerex_t(t_name,t_match,t_response,t_function )
      return AddTriggerEx(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace,-1,0,"",t_function,12,99)
end
function create_triggerex_t101(t_name,t_match,t_response,t_function )
      return AddTriggerEx(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace,-1,0,"",t_function,12,101)
end
function create_triggerex_lvl(t_name,t_match,t_response,t_function,lvl)
      return AddTriggerEx(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace,-1,0,"",t_function,12,lvl)
end
-- ����һ����ʱ�Ĵ����� 
function create_triggerex_f(t_name,t_match,t_response,t_function )
      return AddTriggerEx(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace+trigger_flag.Temporary,-1,0,"",t_function,12,100)
end
-- ����һ����ʱ��һ���Դ����� 
function create_triggerex(t_name,t_match,t_response,t_function )
      return AddTriggerEx(t_name,t_match,t_response,trigger_flag.Enabled+trigger_flag.RegularExpression+trigger_flag.Replace+trigger_flag.Temporary+trigger_flag.OneShot,-1,0,"",t_function,12,100)
end
-- ����һ����ʱ��һ���Զ�ʱ��
function create_timer( t_name, t_time, t_com, t_function )
return AddTimer (
t_name,
0,
0,
t_time,
t_com,
timer_flag.Enabled + timer_flag.OneShot + timer_flag.TimerSpeedWalk + timer_flag.Replace + timer_flag.Temporary,
t_function
)
end
skills={}
skillsLingwu={'force','finger','parry','dodge','strike','blade','cuff','claw','hand','leg','whip','club','sword','stick','hammer','dagger','brush','throwing','spear','staff','axe'}

master={}

perform={}
perform.pre='wield blade;yun fengyun;perform blade.huanying'
perform.xiqi='wield blade;perform blade.feiyan'

hp={
jingxue=0,
jingxue_max=0,
jingxue_per=0,
jingli=0,
jingli_max=0,
jingli_lim=0,
qixue=0,
qixue_max=0,
qixue_per=0,
neili=0,
neili_max=0,
neili_lim=0,
food=100,
water=100,
pot=0,
pot_max=0,
pot_save=0,
exp=0,
heqi=0,
dazuo=10,
tuna=10,
shen=0
}
score={}
score.id='id'
score.name='name'
score.dex=20
score.dex_t=20
score.int=20
score.int_t=20
score.str=20
score.str_t=20
score.con=20
score.con_t=20
score.age=14
score.gold=0
score.party='��ͨ����'

flag={
xuexi=0,
lingwu=0,
lianxi=0,
prepare=0,
go=0,
find=0,
wait=0,
times=1,
gold=1,
duhe=1,
dujiang=1,
jixu=1,
wipe=0}
flag.autoll=1
flag.food=0
flag.month=0
flag.wxjz=0

flagFull={}
tmp={}
condition={}
weapon={}
count={}
count.gold_max=30
count.nxw_max=2
count.cty_max=2
drug={}
drug.heal='dahuan dan'
drug.neili='chuanbei wan'
bags={}
Bag = {}
team={}

drugBuy ={
["������Ϣ��"] = {"dali/yaopu","zhiye/yaodian1"},
["а����"] = {"dali/yaopu","zhiye/yaodian1"},
["������"] = {"dali/yaopu","zhiye/yaodian1"},
["������"] = {"dali/yaopu","zhiye/yaodian1"},
["������"] = {"dali/yaopu","zhiye/yaodian1"},
["������"] = {"dali/yaopu","zhiye/yaodian1"},
["��Ϣ��"] = {"dali/yaopu","zhiye/yaodian1"},
["��ʳ��"] = {"dali/yaopu","zhiye/yaodian1"},
["��ˮ��"] = {"dali/yaopu","zhiye/yaodian1"},
["��ҩ"] = {"dali/yaopu","zhiye/yaodian1"},
["�ƾ���"] = {"dali/yaopu","zhiye/yaodian1"},
["������"] = {"dali/yaopu","zhiye/yaodian1"},
["а����"] = {"dali/yaopu","zhiye/yaodian1"},
["����������"] = {"dali/yaopu","zhiye/yaodian1"},
["���߲�����"] = {"dali/yaopu","zhiye/yaodian1"},
["����������"] = {"dali/yaopu","zhiye/yaodian1"},
["������Ϣ��"] = {"dali/yaopu","zhiye/yaodian1"},
["���ɽ�ҩ"] = {"dali/yaopu","zhiye/yaodian1"},
["��Ѫ�ƾ���"] = {"dali/yaopu","zhiye/yaodian1"},
["�ⶾ��"] = {"dali/yaopu","zhiye/yaodian1"},
["�󻹵�"] = "city/dangpu",
["�ۻ�"] = {"dali/yaopu","city/zahuopu","xiangyang/yaopu","city/yaopu"},
["����"] = "xiangyang/zahuopu",
}

drugPoison={
["�Ż���¶��"] = true,
}

itemSave={
["��Ӣ֮��"] = true,
["���콳����ƪ"] = true,
["����������ƪ"] = true,
["�Խ���"] = true,
["���¾����Ͼ�"] = true,
["������"] = true,
["����"] = true,
["��������"] = true,
["���꺮����"] = true,
["���������ʮ�ľ���Ҫ"] = true,
}

function isItemSave(item)
    if not item or type(item)~="string" then return false end
    local l_result = false
    for p in pairs(itemSave) do
        if string.find(item,p) then l_result = true break end 
    end
	return l_result
end

i=1

check_skills=function(n,l,w)

   local l_skills=" "
   if w[3] then
      l_skills= l_skills .. w[3]
   end
   if w[4] then
      l_skills= l_skills .. w[4]
   end
   if w[5] then
      l_skills= l_skills .. w[5]
   end
   l_skills=Trim(l_skills)
   skills[l_skills] = skills[l_skills] or {}
   skills[l_skills].lvl=tonumber(w[6])
   skills[l_skills].pot=tonumber(w[7])
   skills[l_skills].name=Trim(w[2])
   if skills[l_skills].lvl>=220 then
      skills[l_skills].mstlvl=220
   end
   if perform.force and l_skills==perform.force and skills[l_skills].mstlvl and skills[l_skills].mstlvl<220 and skills[l_skills].mstlvl<hp.pot_max-100 then
      skills[l_skills].mstlvl=nil
   end
   if perform.skill and l_skills==perform.skill and skills[l_skills].mstlvl and skills[l_skills].mstlvl<220 and skills[l_skills].mstlvl<hp.pot_max-100 then
      skills[l_skills].mstlvl=nil
   end

end

hp_jingxue_check=function(n,l,w)
         hp.jingxue    =tonumber(w[1])
         hp.jingxue_max=tonumber(w[2])
         hp.jingxue_per=tonumber(w[3])
         hp.jingli     =tonumber(w[4])
         hp.jingli_max =tonumber(w[5])
         hp.jingli_lim =tonumber(w[6])            
end
hp_qixue_check=function(n,l,w)
         hp.qixue    =tonumber(w[1])
         hp.qixue_max=tonumber(w[2])
         hp.qixue_per=tonumber(w[3])
         hp.neili    =tonumber(w[4])
         hp.neili_max=tonumber(w[5])            
end
hp_shen_check=function(n,l,w)
         local l_type=tostring(w[1])
	 hp.shen     =tonumber(del_string(tostring(w[2]),','))
         hp.neili_lim=tonumber(w[3])
	 if l_type=='��' then
            hp.shen=hp.shen * -1
	 end
end
hp_pot_check=function(n,l,w)
         hp.food     =tonumber(w[1])
         hp.pot      =tonumber(w[2])
         hp.pot_max  =tonumber(w[3])
	 
	 for p in pairs(skillEnable) do
	     q=skillEnable[p]
	     if skills[p] and skills[q] then
	        skills[p].full=0
	     	if q=='force' and (hp.pot<50 or skills[p].lvl<200) then
	           skills[p].full=1
	        end
	        --if (skills[p].lvl==skills[q].lvl and skills[p].pot==(skills[p].lvl+1)*(skills[p].lvl+1)) or skills[p].lvl>skills[q].lvl then
			if skills[p].lvl>=skills[q].lvl then
	           skills[p].full=1    
	        end
			if skills[p].fullever then
			   skills[p].full=1
			end
			if skills[p].lvl>=hp.pot_max-100 then
			   skills[p].full=1
			end
			if p=="wuxiang-zhi" then
			   if not skills[p].olvl then skills[p].olvl=skills[p].lvl end
			   if skills[p].lvl < skills[p].olvl then skills[p].olvl=skills[p].lvl end
			   if skills[p].lvl > skills[p].olvl then
			      flag.wxjz=0
				  skills[p].olvl=skills[p].lvl
			   end
			end
			--if p=="wuxiang-zhi" and (skills[p].lvl<200 or flag.wxjz==0 or score.int<33) then
			if p=="wuxiang-zhi" and (skills[p].lvl<200 or flag.wxjz==0) then
			   skills[p].full=1
			end
			if p== "yuxiao-jian" and perform.force ~= "bihai-chaosheng" then
			   skills[p].full=1
            end
			if p=="wuhu-duanmendao" and skills[p].lvl==150 then
			    skills[p].full=1
			end
			if p=="ranmu-daofa" and (not skills["cibei-dao"] or skills["cibei-dao"].lvl<450) then
			    skills[p].full=1
			end
	     end
	 end
	 if perform.force then
	   if not skills[perform.force] then
	      perform.force = nil
	   end
	 end
	 if not perform.force then
	    tmp.lvl = 0
	    for p in pairs(skills) do
	        q=skillEnable[p]
		    if q=="force" then
		       if skills[p].lvl > tmp.lvl then
		  	      tmp.lvl = skills[p].lvl
				  perform.force = p
			   end
		    end
	    end
	 end
	 if skills["force"] and skills["force"].lvl<hp.pot_max-100 and skills["force"].lvl<220 then
        flag.xuexi=1
     end
 
end
hp_exp_check=function(n,l,w)
         hp.water    =tonumber(w[1])
         hp.exp      =tonumber(del_string(tostring(w[2]),','))       
end
hp_dazuo_check=function(n,l,w)
         hp.dazuo=trans(w[1])
end
score_name_check=function(n,l,w)
    score.name =tostring(w[1])
    score.id   =string.lower(tostring(w[2]))
    score.dex_t=tonumber(w[3])
    score.dex  =tonumber(w[4])
    score.int_t=tonumber(w[5])
    score.int  =tonumber(w[6])
end
score_title_check=function(n,l,w)
    score.title=Trim(tostring(w[1]))
    score.str_t=tonumber(w[2])
    score.str  =tonumber(w[3])
    score.con_t=tonumber(w[4])
    score.con  =tonumber(w[5])
end
score_age_check=function(n,l,w)
    local l_str = Trim(w[1])
	local l_n = string.find(l_str,'��')
	local l_m = string.find(l_str,'��')

	score.age=trans(string.sub(l_str,1,l_n-1))
	
	local l_mon = 0
	
	if l_m then
	   l_mon = trans(string.sub(l_str,l_n+4,l_m-3))
	end
	
	score.month = score.age * 12 + l_mon	
end
score_gold_check=function(n,l,w)
    score.gold=trans(w[1])
    if not score.gold then
       score.gold=0
    end
    --score.party=w[3]
    --score.master=w[4]
	if string.match(w[3],"��%S*��") then
	    local l_str = string.match(w[3],"��%S*��")
		if string.find(l_str,"����") then
		    score.party = string.sub(l_str,3,string.find(l_str,"����")-1)
	        score.master=string.sub(l_str,string.find(l_str,"����")+4,string.len(l_str)-2)
	    else
		    l_str=del_string(l_str,"��")
			score.party=del_string(l_str,"��")
	        score.master="��ͨ����"
		end
	end
end
score_busy_check=function(n,l,w)
    local l_str = Trim(w[1])
	local l_cond,l_char,l_cnt,l_time
	l_str = string.gsub(l_str,"��"," ")
    if string.find(l_str,"��") or string.find(l_str,"��") then
	    local l_set = utils.split(l_str," ")
		for _,q in pairs(l_set) do
		    --messageShow(q)
		    local l_string = Trim(q)
			--messageShow(l_string)
		    if not isNil(l_string) then
			    if string.find(l_string,"��") or string.find(l_string,"��") then
					l_char = string.sub(l_string,1,string.len(l_string)-2)
					l_time = string.sub(l_string,string.len(l_string)-1,string.len(l_string))
					l_cnt = trans(l_char)
				else
				    l_cond = Trim(l_string)
				end
			end 
		end
		
	    --messageShow(l_cond .. " " .. l_char .. " " .. l_cnt)
        if l_time=='��' then
		    condition[l_cond] = l_cnt * 60
	        if l_cond=="����æ״̬" then
                condition.busy=l_cnt * 60
	        end
	    	if Trim(w[2])=="��" then
	    	    condition.poison=l_cnt * 60
	    	end
	    	if Trim(w[2])=="��" then
	    	    condition.wound=l_cnt * 60
	    	end
	    	if Trim(w[2])=="ҩ" then
	    	    condition.drug=l_cnt * 60
	    	end
	    	if string.find(l_cond,"����") then
	    	    condition.noperform=l_cnt * 60
	    	end
	    	if string.find(l_cond,"����") then
	    	    condition.noexert=l_cnt * 60
	    	end
        end
		if l_time=='��' then
		    condition[l_cond] = l_cnt
	        if l_cond=="����æ״̬" then
                condition.busy=l_cnt
	        end
		    if Trim(w[2])=="��" then
		        condition.poison=l_cnt
		    end
		    if Trim(w[2])=="��" then
		        condition.wound=l_cnt
		    end
		    if Trim(w[2])=="ҩ" then
		        condition.drug=l_cnt
		    end
		    if string.find(l_cond,"����") then
		        condition.noperform=l_cnt 
		    end
		    if string.find(l_cond,"����") then
		        condition.noexert=l_cnt
		    end
		end	
    end
end
score_gender_check=function(n,l,w)
   if string.len(w[1]) == 2 then
      score.gender=w[1]
   end
   if string.len(w[2]) == 8 then
      score.level=w[2]
   end
end
score_vip_check=function(n,l,w)
   score.vip = Trim(w[1])
end
function score_vip_time(n,l,w)
    local l_time = Trim(w[1])
    score.viptime = 0
	if string.find(l_time,"��") then
	    local l_b,l_e = string.find(l_time,"��")
		local l_viptime = trans(string.sub(l_time,1,l_b-1))*24*60
		score.viptime = score.viptime + l_viptime
		l_time = string.sub(l_time,l_e+1,string.len(l_time))
	end
	if string.find(l_time,"Сʱ") then
		local l_b,l_e = string.find(l_time,"Сʱ")
		local l_viptime = trans(string.sub(l_time,1,l_b-1))*60
		score.viptime = score.viptime + l_viptime
		l_time = string.sub(l_time,l_e+1,string.len(l_time))
	end
	if string.find(l_time,"��") then
		local l_b,l_e = string.find(l_time,"��")
		local l_viptime = trans(string.sub(l_time,1,l_b-1))
		score.viptime = score.viptime + l_viptime
	end
end
function score_canwu_check(n,l,w)
    canwu = canwu or {}
    canwu.exp=trans(w[1])
	if w[2] then
	    canwu.gift=trans(w[2])
	end
	if w[4] then
	    canwu.left=trans(w[4])
	end
end

function test()
   Note("TEST OK!")
   return fight_prepare()
end
function test_text()
    Note('TEXT')
end
beihook=test
halthook=test
function main()
    CloseLog()
	setAlias()
    delete_all_triggers()
    delete_all_timers()
    DeleteTemporaryTriggers()
    create_trigger_t('main',"^���齣\\D*��\\D*�Ѿ�����ִ����",'','login')
    create_trigger_t('main1',"^Are you using BIG5 font\\(y/N\\)? ",'','login_choose')
    lujing_trigger()
    chat_trigger()
    hp_trigger()
    fight_trigger()
    idle()
    getVariable()
    userGet()
	fight_prepare()
	if _G["buttonDraw"] then
	    _G["buttonDraw"]()
	end
	messageLoad()
    exe('follow none;score;cha;hp;stand')
	exe('irc /create heros Ӣ���޵� no 111111')
	exe('irc /join heros 111111')
	locate()
	exe('halt')
	exe('wear all')
	return checkWait(mainCheck,3)
end
function mainCheck()
    if locl.room=="�����԰" then
	    exe("down")
		locate()
	    return checkWait(mainCheck,3)
	end
    if hp.exp<3000 and locl.area == '���' and _G["wuguan"] then
	    return _G["wuguan"]()
	end
	if hp.exp>150000 and not perform.skill or not perform.pre or not job.zuhe or countTab(job.zuhe)<2 then
	    return shujian_set()
	end
	flag.dazuo = nil
	if hp.jingxue_per<85 or hp.qixue_per<70 then
	    return check_heal()
	end
    return hp_dazuo_count()
end
function login_choose()
    Send('n')
end
function login()
    dis_all()
    DeleteTriggerGroup("login")
	create_trigger_t('login1',"����ĳ�������Ҫ����ַ������ұ���������ֺ�Ӣ�Ĵ�д��ĸ��",'','loginPwd')
    create_trigger_t('login2',"^����������������ʶ������\\(passwd\\)��",'','login_passwd')
	create_trigger_t('login3',"^���������ĸ��մ���������������ִ��������������Ժ���������ģ�",'','loginName')
	create_trigger_t('login4',"^�������Լ�ָ������һ���ֵ",'','loginGift')
	create_trigger_t('login5',"^��ӭ��ע���Ϊ�齣������",'','loginWuguan')
	create_trigger_t('login6',"�Բ����������ֻ���������˵����š�$",'','loginName')
	SetTriggerOption("login1","group","login")
    SetTriggerOption("login2","group","login")
	SetTriggerOption("login3","group","login")
	SetTriggerOption("login4","group","login")
	SetTriggerOption("login5","group","login")
	SetTriggerOption("login6","group","login")
    local l_id=GetVariable("id")
    local l_passwd=GetVariable("passwd")
    Note(l_id,l_passwd)
    if l_id~=nil and l_passwd~=nil then
       Send(l_id)
       Send(l_passwd)
	   Send('y')
	   Send(l_id)
       Send('y')
    else
       return shujian_set()
    end
end
function loginPwd()
    local l_passwd=GetVariable("passwd")
	Send(l_passwd)
	Send(l_passwd)
end
function loginName()
    local l_name=GetVariable("name")
	if not l_name then
        if getRandomIndex(data_name_fuxing) and getRandomIndex(data_name) then
		    l_name = getRandomIndex(data_name_fuxing) .. getRandomIndex(data_name)
		end
	end
	if not l_name then l_name = "δ����" end
	wait.make(function()
	    wait.time(2)
        Send(l_name)
	end)
end
function loginGift()
    local l_gender=GetVariable("gender")
	if l_gender and l_gender=="Ů" then
	    l_gender = "f"
	else
	    l_gender = "m"
	end
    wait.make(function()
	    wait.time(2)
        Send('2')
		wait.time(2)
	    Send('30')
		wait.time(2)
	    Send('y')
		wait.time(2)
		loginMail()
		wait.time(2)
		Send(l_gender)
	end)
end
function loginMail()
    local aset = {'a','b','c','d','e','f','g','h','i','j','k','l','m'}
	local bset = {'n','o','p','q','r','s','t','u','v','w','x','y','z'}
	local cset = {'com','net','cn','jp','hk'}
	local l_mail = getRandomElement(aset)..getRandomElement(bset)..getRandomElement(aset).."@"..getRandomElement(aset)..getRandomElement(bset)..getRandomElement(aset).."."..getRandomElement(cset)
	Send(l_mail)
end
function loginWuguan()
    EnableTriggerGroup("login",false)
	DeleteTriggerGroup("login")
    wait.make(function()
	    wait.time(2)
        Send('n')
		main()
	end)
end
function login_passwd()
    EnableTriggerGroup("login",false)
    wait.make(function()
       wait.time(2)
       main()
    end)
end
function disAll()
    local tl = GetTriggerList()
    if tl then
       for k, v in ipairs (tl) do 
           EnableTrigger(v,false) 
       end
    end
    delete_all_timers()
	EnableTrigger("main",true)
	EnableTrigger("main1",true)
	EnableTriggerGroup("hp",true)
    EnableTriggerGroup("score",true)
	EnableTriggerGroup("chat",true)
end
function dis_all()
    local tl = GetTriggerList()
    if tl then
       for k, v in ipairs (tl) do 
           EnableTrigger(v,false) 
       end
    end
    delete_all_timers()
    EnableTrigger('main',true)
    EnableTrigger('main1',true)
    --EnableTrigger('idle',true)
    EnableTriggerGroup("chat",true)
    EnableTriggerGroup("hp",true)
    EnableTriggerGroup("score",true)
    EnableTriggerGroup("count",true)
    EnableTriggerGroup("fight",true)
    EnableTriggerGroup("job_exp",true)
	EnableTrigger("hp12",false)
    beihook=test
    busyhook=test
    waithook=test
    flag.find=1
    --thread_resume(lookfor)
    idle()
end
function delete_all_triggers()
    local tl = GetTriggerList()
    if tl then
       for k, v in ipairs (tl) do 
           DeleteTrigger(v) 
       end
    end 
end
function delete_all_timers()
    local tl = GetTimerList()
    if tl then
       for k, v in ipairs (tl) do 
           DeleteTimer(v) 
       end
    end 
end
hp_dazuo_count=function()
    DeleteTriggerGroup("dz_count")
    create_trigger_t('dz_count1','^>*\\s*���Ҳ��ܴ�������Ӱ�������Ϣ��','','hp_dz_where')
    create_trigger_t('dz_count2','^>*\\s*���޷���������������','','hp_dz_where')
    create_trigger_t('dz_count3','^>*\\s*(���ﲻ׼ս����Ҳ��׼������|����ɲ���������������ĵط���)','','hp_dz_where')
	create_trigger_t('dz_count4',"^(> )*�������ֽŴ�����������������ȷ������������",'','hp_dz_liaokao')
	create_trigger_t('dz_count5',"^(> )*(�㻹����ϴ���|����Ҫ��������|���޷�������������|�㻹��ר�Ĺ����)",'','hp_dz_where')
    SetTriggerOption("dz_count1","group","dz_count")
    SetTriggerOption("dz_count2","group","dz_count")
    SetTriggerOption("dz_count3","group","dz_count")
	SetTriggerOption("dz_count4","group","dz_count")
	SetTriggerOption("dz_count5","group","dz_count")
    if perform.force and skills[perform.force] then
	   exe('jifa force '.. perform.force)
	else
	   for p in pairs(skills) do
	      if skillEnable[p] == "force" then
		     exe('jifa force '.. p)
			 exe('cha')
		  end
	   end
	end
    if skills["linji-zhuang"] and skills["linji-zhuang"].lvl>149 then
       exe('yun yinyang')
    end
	if skills["force"] and skills["force"].lvl<220 then
       flag.xuexi=1
    end
    exe('yun qi;hp')
    hp.dazuo=10

    return check_bei(hp_dazuo_act)
end
hp_dazuo_act=function()
    tmp.qixue=hp.qixue
    exe('yun jing;dazuo '..hp.qixue)
    tmp.i=0
    return create_timer_s('dazuo_count',1.5,'hp_dazuo_timer')
end
hp_dazuo_timer=function()
    tmp.i = tmp.i + 1
    if tmp.i > 30 then
       return main()
    end
    exe('hp;yun jing;yun qi;dazuo '..hp.qixue)
    return checkWait(hp_dz_count,0.5)
end
hp_dz_count=function()
    EnableTriggerGroup("dz_count",false)

    local l_times=1
       if hp.qixue<tmp.qixue then
          if hp.qixue_max>1000 then
             l_times=math.modf(math.modf(hp.qixue_max/5)/(tmp.qixue-hp.qixue))+1
	  end
	  hp.dazuo=l_times*(tmp.qixue-hp.qixue)
	  if hp.dazuo<10 then
	     hp.dazuo=10
	  end
	  --if hp.dazuo>10 and hp.dazuo <100 then
	  --   l_times=math.modf(100/hp.dazuo)+1
	  --   hp.dazuo=l_times*hp.dazuo
	  --end
	  Note('��Ѵ���ֵΪ��'..hp.dazuo)
	  flag.dazuo = true
	  DeleteTriggerGroup("dz_count")
	  DeleteTimer("dazuo_count")
	  exe('halt')
	  if flag.quit then
	     flag.quit=nil
		 return check_bei(cityQu)
	  else
	     return check_bei(check_heal)
	  end
   end
end
hp_dz_where=function()
   EnableTriggerGroup("dz_count",false)
   DeleteTimer("dazuo_count")
   locate()
   check_bei(hp_dz_go)
end
hp_dz_go=function()
   EnableTriggerGroup("dz_count",true)
   exe(locl.dir)
   hp_dazuo_act()
end
function hp_dz_liaokao()
    dis_all()
	return tiaoshui()
end

function cityQu()
    exe('get seng xie;get hu yao;get hu wan;drop shoes 2')
    exe('get xiong huang;get sheng zi')
    tmp.cnt = 0
    return go(cityQuWeapon,"���ݳ�","�ӻ���")
end
function cityQuWeapon()
    for p in pairs(weaponPrepare) do
        if not Bag[p] and weaponStore[p] then
	        exe('qu '.. weaponStoreId[p])
	    end
    end
	for p in pairs(weaponPrepare) do
        if weaponStore[p] then
	        exe('qu '.. weaponStoreId[p])
	    end
    end
    tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
    checkBags()
    if tmp.cnt < 8 then
	    return check_busy(cityQuWeapon,1)
    else
	    tmp.cnt = 0
        return check_busy(cityQuDhd,1)
    end
end
function cityQuDhd()
    exe('qu dahuan dan')
    checkBags()
	tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
	if tmp.cnt < 5 then
	    return check_bei(cityQuDhd,1)
    else
	    tmp.cnt = 0
        return check_bei(cityQuBingchan,1)
	end
end
function cityQuBingchan()
    exe('qu bingchan')
    checkBags()
	tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
	if tmp.cnt < 3 then
	    return check_busy(cityQuBingchan,1)
    else
	    tmp.cnt = 0
        return check_busy(cityQuPearl,1)
	end
end
function cityQuPearl(p_num)
    exe('qu pearl')
    checkBags()
	tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
	if tmp.cnt < 3 then
	    return check_bei(cityQuPearl,1)
    else
	    tmp.cnt = 0
        return check_bei(cityQuCbw,1)
	end
end
function cityQuCbw()
    exe('qu chuanbei wan')
    checkBags()
	tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
	if tmp.cnt < 3 then
	    return check_busy(cityQuCbw,1)
    else
	    tmp.cnt = 0
        return check_busy(cityQuOver,1)
	end
end
function cityQuOver()
    return check_heal()
end
function hp_trigger()
    DeleteTriggerGroup("hp")
    create_trigger_t('hp1',"^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\d*)\\((\\d*)\\)$",'','hp_jingxue_check')
    create_trigger_t('hp2',"^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\s*\\d*)\\(\\+\\d*\\)$",'','hp_qixue_check')
    create_trigger_t('hp3',"^��ʳ�\\s*(\\d*)\\.\\d*\\%\\s*��Ǳ�ܡ�\\s*(\\d*)\\s*\\/\\s*(\\d*)$",'','hp_pot_check')
    create_trigger_t('hp4',"^����ˮ��\\s*(\\d*)\\.\\d*\\%\\s*�����顤\\s*(.*)\\s*\\(",'','hp_exp_check')
    create_trigger_t('hp5',"^��(��|��)����\\s*(.*)\\s*���������ޡ�\\s*(\\d*)\\s*\\/",'','hp_shen_check')
    create_trigger_t('hp7',"^(��)*\\s*(\\D*)\\s*\\((\\D*)(\\-)*(\\D*)\\)\\s*\\-\\s*\\D*\\s*(\\d*)\\/\\s*(\\d*)$",'','check_skills')
    create_trigger_t('hp8',"^>*\\s*��������Ҫ(\\D*)�������������",'','hp_dazuo_check')
    create_trigger_t('hp9',"^��(\\D*)����\\s*��\\s*(\\d*) ��\\s*�� ",'','checkJobtimes')
    create_trigger_t('hp10',"^��(\\D*)\\(\\D*\\)$",'','checkWieldCatch')
    create_trigger_t('hp11',"^(> )*������������(\\D*)����$",'','checkJoblast')
    --create_triggerex_lvl('hp12',"^(> )*(\\D*)",'','resetWait',200)
    create_trigger_t('hp13',"^���齣ͨ����(\\D*)(��|��)",'','checkTongbao')
    create_trigger_t('hp14',"^\\D*��һ�������ˡ�$",'','checkRefresh')
    create_trigger_t('hp15',"^(> )*���ڱ����й�����(\\D*)��Ǳ�ܡ�",'','checkpotSave')
	create_trigger_t('hp16',"^  \\D* \\((\\D*)\\)\\s*�� (\\D*)\\s*��Ч�ȼ���(\\d*)\\s*",'','checkEnable')
    SetTriggerOption("hp1","group","hp")
    SetTriggerOption("hp2","group","hp")
    SetTriggerOption("hp3","group","hp")
    SetTriggerOption("hp4","group","hp")
    SetTriggerOption("hp5","group","hp")
    SetTriggerOption("hp7","group","hp")
    SetTriggerOption("hp8","group","hp")
    SetTriggerOption("hp9","group","hp")
    SetTriggerOption("hp10","group","hp")
    SetTriggerOption("hp11","group","hp")
    --SetTriggerOption("hp12","group","hp")
    SetTriggerOption("hp13","group","hp")
    SetTriggerOption("hp14","group","hp")
    SetTriggerOption("hp15","group","hp")
    SetTriggerOption("hp16","group","hp")
    DeleteTriggerGroup("score")
    create_trigger_t('score1',"^����    ����(\\D*)\\((\\D*)\\)\\s*����  ������(\\d*)\/(\\d*)��\\s*��  �ԣ���(\\d*)\/(\\d*)��",'','score_name_check')
    create_trigger_t('score2',"^��ͷ    �Σ�(\\D*)\\s*����  ������(\\d*)\/(\\d*)��\\s*��  �ǣ���(\\d*)\/(\\d*)��",'','score_title_check')
    create_trigger_t('score3',"^����    �䣺(\\D*)\\s*��    ����",'','score_age_check')
    create_trigger_t('score4',"^��(\\D*)\\s*(ʱ��|æ|��|��|ҩ|��|��)( |)��$",'','score_busy_check')
    --create_trigger_t('score5',"^��Ǯׯ��(\\D*)(���ƽ�|����)\\s*ʦ\\s*�У���(\\D*)����(\\D*)��",'','score_gold_check')
    create_trigger_t('score6',"^����    ��(\\D*)��\\s*����(\\D*)\\s* �㣺",'','score_gender_check')
    create_trigger_t('score7',"^��Ǯׯ��(\\D*)(���ƽ�|����)\\s*ʦ\\s*�У�(\\D*)",'','score_gold_check')
    create_trigger_t('score8',"^����������ȡ�����ٷ�֮(\\D*)��\\s*�����츳��(\\D*)(��|��)\\s*δ�����츳(\\D*)(��|��)",'','score_canwu_check')
	create_trigger_t('score9',"^��Ŀǰ�Ĵ�������ǣ�(\\D*)���ƽ�",'','checkGoldLmt')
	create_trigger_t('score10',"^��ע�᣺(\\D*)��ʦ��",'','score_vip_check')
	create_trigger_t('score11',"^���ʣ��ʱ�䣺(\\D*)��$",'','score_vip_time')
    SetTriggerOption("score1","group","score")
    SetTriggerOption("score2","group","score")
    SetTriggerOption("score3","group","score")
    SetTriggerOption("score4","group","score")
    SetTriggerOption("score5","group","score")
    SetTriggerOption("score6","group","score")
    SetTriggerOption("score7","group","score")
    SetTriggerOption("score8","group","score")
	SetTriggerOption("score9","group","score")
	SetTriggerOption("score10","group","score")
	SetTriggerOption("score11","group","score")
end
function checkEnable(n,l,w)
    enableSkill = enableSkill or {}
	local l_p = Trim(tostring(w[1]))
	local l_q = Trim(tostring(w[2]))
	local l_s = tonumber(w[3])
	enableSkill[l_p] = {}
	enableSkill[l_p].lvl = l_s
	for p in pairs(skills) do
	    if skills[p].name == l_q and skills[l_p] and skills[l_p].lvl then
		   enableSkill[l_p].std = skills[l_p].lvl/2 + skills[p].lvl
		   break
		end
	end
end

function checkMonth()
    SetVariable("month",score.month)
	if drugPrepare["��������"] and score.tongbao and score.tongbao>500 then
	   if Bag["��������"] then
	      return prayPearlOver()
	   else
          return prayPearl()
	   end
	else
	   return checkMonthParty()
    end
end
function prayPearl()
   return go(prayPearlBuy,"���ݳ�","����")
end
function prayPearlBuy()
   exe('duihuan pearl')
   checkBags()
   return check_busy(prayPearlBag)
end
function prayPearlBag()
   if isInBags("��������") then
      return prayPearlOver()
   end
   return checkWait(prayPearlBuy,3)
end
function prayPearlOver()
   exe('pray pearl')
   return checkMonthParty()
end
function checkMonthParty()
	if score.party and score.party == "����Ľ��" and (score.master == "Ľ�ݸ�" or score.master == "Ľ�ݲ�") then
	   return murongFenglu()
	end
	return check_heal()
end
function murongFenglu()
    return go(murongFengAsk,'������','Ժ��')
end
function murongFengAsk()
    exe("ask murong fu about ٺ»")
	return check_heal()
end

function checkTongbao(n,l,w)
    score.tongbao=trans(w[1])
end
function checkGoldLmt(n,l,w)
    score.goldlmt=trans(w[1])
end
function checkpotSave(n,l,w)
    hp.pot_save = trans(w[2])
end

function lingwu_trigger()
    DeleteTriggerGroup("lingwu")
    create_trigger_t('lingwu1',"^>*\\s*(��ֻ�ܴ����⼼��������|�㲻�����ּ��ܡ�|��Ҫ����ʲô��)",'','lingwu_next')
    create_trigger_t('lingwu2',"^>*\\s*���ʵս�еõ���Ǳ���Ѿ������ˡ�",'','lingwu_finish')
    create_trigger_t('lingwu3',"^>*\\s*���\\D*�������޷��������һ��Ļ���",'','lingwu_next')
    create_trigger_t('lingwu9',"^>*\\s*�������ڵĻ����ڹ���Ϊ�����޷���������ڹ���",'','lingwu_next')
    create_trigger_t('lingwu5',"^>*\\s*����ʵս���鲻�㣬�谭����ġ�\\D*������",'','lingwu_next')
    create_trigger_t('lingwu6','^>*\\s*��� "action" �趨Ϊ "����������Ǻð������Ǻã�" �ɹ���ɡ�','','lingwu_goon') 
    SetTriggerOption("lingwu1","group","lingwu")
    SetTriggerOption("lingwu2","group","lingwu")
    SetTriggerOption("lingwu3","group","lingwu")
    SetTriggerOption("lingwu9","group","lingwu")
    SetTriggerOption("lingwu5","group","lingwu")
    SetTriggerOption("lingwu6","group","lingwu")
    EnableTriggerGroup("lingwu",false)
end
function jifaAll()
    exe('bei none')
	local lvlParry = 0
    for p in pairs(skills) do
	    local sk = qrySkillEnable(p)
	    if sk and sk["force"] and perform.force and perform.force==p then
		   exe('jifa force '..p)
		end
	    if sk and not sk["force"] and not sk["dodge"] and skills[p].lvl>lvlParry then
			lvlParry = skills[p].lvl
		    exe('jifa parry '..p)
		end
		if sk and not sk["force"] then
		   for q in pairs(sk) do
		       if skills[q] and skills[p].lvl>=skills[q].lvl then
		          exe('jifa '..q..' '..p)
			   end
		   end
		end
	end
end
function jifaDodge()
    for p in pairs(skills) do
	    q = skillEnable[p]
		if q=="dodge" and skills[q] and skills[p].lvl>=skills[q].lvl then
		   exe('jifa '..q..' '..p)
		   break
		end
	end
end
function lingwuFlag()
    flag.lingwu=0
    for p in pairs(skillEnable) do
        if skills[p] then
            q=skillEnable[p]
	        if q and skills[q] and q~="force" and skills[q].lvl>100 and skills[q].lvl<hp.pot_max-100 and skills[q].lvl<=skills[p].lvl and skills[q].lvl<hp.pot_max-100 then
	            flag.lingwu=1
	        end
        end
    end
    if (GetVariable("lingwuskill") and skills[GetVariable("lingwuskill")]) or (tmp.xskill and skills[tmp.xskill] and skillEnable[tmp.xskill] and skills[skillEnable[tmp.xskill]]) then
        flag.lingwu = 0
	     
	    if tmp.xskill and skills[tmp.xskill] and skillEnable[tmp.xskill] and skills[skillEnable[tmp.xskill]] then
	        local p = tmp.xskill
		    local q = skillEnable[p]
	        if skills[q].lvl<hp.pot_max-100 and skills[q].lvl>100 and skills[q].lvl<=skills[p].lvl and skills[q].lvl<hp.pot_max-100 then
		        flag.lingwu=1
		    end
        end 
	    if GetVariable("lingwuskill") then
		    local q = GetVariable("lingwuskill")
		    for p in pairs(skills) do
	            if skillEnable[p]==q and skills[q].lvl<hp.pot_max-100 and skills[q].lvl>100 and skills[q].lvl<=skills[p].lvl and skills[q].lvl<hp.pot_max-100 then
		            flag.lingwu=1
		        end 
		    end
	    end
	end
end
function lingwu()
    DeleteTemporaryTriggers()
    lingwu_trigger()

	skillsLingwu = {}
	if tmp.xskill and skills[tmp.xskill] and skillEnable[tmp.xskill] and skills[skillEnable[tmp.xskill]] then
	   table.insert(skillsLingwu,1,skillEnable[tmp.xskill])
	end
	if GetVariable("lingwuskill") then
	   tmp.skill = GetVariable("lingwuskill")
	   if skills[tmp.skill] then
	      table.insert(skillsLingwu,1,tmp.skill)
	   end
	end
	if table.getn(skillsLingwu) == 0 then
	   for p in pairs(skills) do
		    local sk = qrySkillEnable(p)
		    if sk then
		       for q in pairs(sk) do
			       if skills[q] and skills[q].lvl<hp.pot_max-100 then
				      table.insert(skillsLingwu,1,q)
				   end
			   end
		    end
	   end
	   table.insert(skillsLingwu,1,'throwing')
	   table.insert(skillsLingwu,1,'parry')
	   for p in pairs(skills) do
	       if skillEnable[p] then
		      local l_skill=skillEnable[p]
	          if l_skill=="force" and skills[l_skill].lvl<hp.pot_max-100 then
                 table.insert(skillsLingwu,1,l_skill)
	          end
              if l_skill=="dodge" and skills[l_skill].lvl<hp.pot_max-100 then
                 table.insert(skillsLingwu,1,l_skill)
	          end
	          if perform.skill and skillEnable[perform.skill] and l_skill==skillEnable[perform.skill] and skills[l_skill].lvl<hp.pot_max-100 then
                 table.insert(skillsLingwu,1,l_skill)
	          end
		   end
	   end
	end
    road.temp=0
    tmp.lingwu=1
    --prepare_neili(lingwu_go)
    if hp.pot < 5000 then
	   return go(lingwuPot,"������","Ǳ������")
    else
       return go(lingwuGuigu,"�����","���")
    end
end
function lingwuPot()
    exe("qn_qu ".. hp.pot_max*2)
	exe("qn_cha")
    return go(lingwuGuigu,"�����","���")
end
function lingwuGuigu()
    return prepare_neili(lingwuGuiguAsk)
end
function lingwuGuiguAsk()
    exe("ask ying gu about start")
	return lingwu_go()
end
function lingwu_skill()
    local p_i,p_lvl
    local l_skill,l_lvl
    p_lvl=9999

    for i=1,table.getn(skillsLingwu) do
        l_skill=skillsLingwu[i]
	    if skills[l_skill] and skills[l_skill].lvl>0 then 
	        l_lvl=skills[l_skill].lvl
            if l_lvl<p_lvl then
	            p_i=i
	            p_lvl=l_lvl
	        end
	    end
    end
    return p_i
end
function lingwu_go()
	tmp.jifa = true
    return go(lingwu_goon,'��ɽ����','��ĦԺ���')
end
function lingwu_goon()
    if locl.room~="��ĦԺ���" then
        return lingwu_finish()
    end
	
	local l_times = 5
	if hp.jingxue < 800 then
	    l_times = 3
	end
	if hp.jingxue < 500 then
	    l_times = 2
	end
	
	if tmp.jifa then
	    tmp.jifa = nil
	    jifaAll()
	end
	
    EnableTriggerGroup("lingwu",true)
    local skill=skillsLingwu[tmp.lingwu]
	
	if not skills[skill] or skills[skill].lvl==0 or skills[skill].lvl>=hp.pot_max-100 then
	    return lingwu_next()
	end
	if tmp.busy and (not condition["����æ״̬"] or condition["����æ״̬"]<=20) then
	    flag.lingwu=0
        return check_bei(lingwu_finish)
	end
    if hp.neili<500 then
	    if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
		    exe('eat dan')
		    checkBags()
	    else
            EnableTriggerGroup("lingwu",false)
            exe('s')
            return prepare_neili(lingwu_go)
	    end
    end
	if hp.neili<hp.neili_max/2 then
	    if Bag["������Ϣ��"] then
	        exe('eat chuanbei wan')
	    end
	end
    yunAddInt()
	exe('hp;yun jing;#'.. l_times ..'(lingwu '..skill..')')
	
	if tmp.busy and math.random(1,4)==1 then
	    condition = {}
		exe('cond')
		return checkWait(lingwu_alias,1.5)
	end
    return check_bei(lingwu_alias,1)
end
function lingwu_alias()
    exe('alias action ����������Ǻð������Ǻã�')
end
function lingwu_next()
    EnableTriggerGroup("lingwu",false)
    tmp.lingwu=tmp.lingwu+1
    local length=table.getn(skillsLingwu)
    if tmp.lingwu>length then
       flag.lingwu=0
       return check_bei(lingwu_finish)
    else
       local skill=skillsLingwu[tmp.lingwu]
       if skills[skill] and skills[skill].lvl>0 and skills[skill].lvl<hp.pot_max-100 then
          return check_bei(lingwu_goon,1)
       else
          return lingwu_next()
       end
    end
end
function lingwu_finish()
    local skill=skillsLingwu[tmp.lingwu]
    EnableTriggerGroup("lingwu",false)
    DeleteTriggerGroup("lingwu")
    exe('cha;hp')
    if tmp.lingwu>1 and tmp.lingwu<=table.getn(skillsLingwu) then
       table.remove(skillsLingwu,tmp.lingwu)
       table.insert(skillsLingwu,1,skill)
    end
	return go(xuexiYingover,"�����","���")
    --check_bei(check_heal)
end

function xuexiTrigger()
    DeleteTriggerGroup("xuexi")
    create_trigger_t('xuexi1',"^(> )*��(\\D*)".. score.master .."(\\D*)(ָ��|����)",'','xuexiAction')
    create_trigger_t('xuexi2',"^(> )*��������æ���ء�",'','xuexiAction')
    create_trigger_t('xuexi3',"^(> )*�����̫���ˣ����ʲôҲû��ѧ����",'','xuexiSleep')
    create_trigger_t('xuexi4',"^(> )*(�������ֻ��ͨ������|���̫��ȭ���̫ǳ|������Ѩ���˻Ƶ����Ҵ���ѧ|������Ѩ���˶�������ʦ������ѧ|������ԣ��޷�|���\\D*(����|����|��)����|��ɽ������ô�ݵ�|��һ������ү��|���Ѿ��޷����|��Ļ�������̫��|���а��̫��|�����һ���|��ת����ֻ��ͨ�����������|ѧ��ֻ��ѧ��������|����������ʿ|ֻ�д����֮��|�㲻������������|�㲻����ѧϰ����ѧ|����ѧֻ�ܿ��ж�|��Ķ���д��|��������ֻ��ͨ����ϰҽѧ|��\\D*�������|\\D*���ﲻ����������|��Ļ��������δ��|����ʱ�޷���|���������|���ŷ�ɮ������|��ʹ�õ���������|��������Ѿ��޷�ͨ��ѧϰ|���������±����ұ���ѧ��|�����ȥѧ��ѧϰ����д��|Ҳ����ȱ��ʵս����|���(��˷�|�����ķ�)��Ϊ����|�������ĳ̶��Ѿ�������ʦ��)",'','xuexiNext')
    create_trigger_t('xuexi5',"^(> )*��û����ô��Ǳ����ѧϰ",'','xuexiFinish')
    create_trigger_t('xuexi6',"^(> )*��Ҫ��˭��̣�",'','xuexiFinish')
    create_trigger_t('xuexi7',"^(> )*��ġ�(\\D*)�������ˣ�",'','xuexiLvlUp')
    SetTriggerOption("xuexi1","group","xuexi")
    SetTriggerOption("xuexi2","group","xuexi")
    SetTriggerOption("xuexi3","group","xuexi")
    SetTriggerOption("xuexi4","group","xuexi")
    SetTriggerOption("xuexi5","group","xuexi")
    SetTriggerOption("xuexi6","group","xuexi")
    SetTriggerOption("xuexi7","group","xuexi")
    EnableTriggerGroup("xuexi",false)
end
function xuexi()

    --[[
    if GetVariable("masterid") then
       master.id=GetVariable("masterid")
    end
	if score.master and masterRoom[score.master] then
	   master.room,master.area=getAddr(masterRoom[score.master])
	   Note(master.room,master.area)
	else
       if GetVariable("masterroom") then
          master.room,master.area=getAddr(GetVariable("masterroom"))
       end
	end
	--]]
	master = {}

	if hp.exp<150000 then
	   master.times=3
	else
	   master.times=math.modf(hp.jingxue/40)
	   if score.int>9  then master.times = master.times + 2 end
	   if score.int>19 then master.times = master.times + 2 end
	   if score.int>29 then master.times = master.times + 2 end
	   if master.times>50 then master.times=50 end
	end



    master.skills={'literate','force'}
	
    for p in pairs(skills) do
        if skillEnable[p]==nil and p~="force" then
	        if flag.type and flag.type=='xuexi' and perform.skill and p==skillEnable[perform.skill] and tmp.skill and skills[tmp.skill] and skills[p].lvl<skills[tmp.skill].lvl then
                table.insert(master.skills,1,p)
	        else
	            table.insert(master.skills,p)
	        end
	    else
	        table.insert(master.skills,p)
	    end
    end
	table.insert(master.skills,1,perform.force)
	
	xuexiList = xuexiList or {}
	for p in pairs(xuexiList) do
	    if skillEnable[p]=="force" or p=="force" then
		    table.insert(master.skills,1,p)
		else
	        table.insert(master.skills,p)
		end
	end

    flag.times= 1
	flag.idle = 0

    if score.party and score.party=="������" and hp.exp>151000 and skills["buddhism"] and skills["buddhism"].lvl<200 then 
       return go(chanhuiXuexi,'��ɽ����','����Ժ')
    elseif hp.exp>151000 then
       return prepare_neili(xuexiGo)
    else
       return xuexiGo()
    end
end
function chanhuiXuexi()
    return checkWait(chanhuiCon,3)
end
function chanhuiCon()
    return prepare_neili(xuexiGo)
end
function xuexiGo()
    return go(xuexiPot,"������","Ǳ������")
end
function xuexiPot()
    exe('qn_qu '.. hp.pot_max*2)
	exe("qn_cha")
	return go(xuexiYinggu,"�����","���")
end
function xuexiYinggu()
    exe('ask ying gu about start')
    xuexiTrigger()
    if score.master then
       --return go(xuexiCheck,master.area,master.room)
	   master.area = locateroom(score.master)
	   if master.area then
	      return go(xuexiCheck,master.area,master.room)
	   else
	      ColourNote ("white","blue","δ�ҵ�ʦ��סַ������ϵPANIX���£�")
	      return xuexiFinish()
	   end
    else
	   return xuexiFinish()
       --return go(xuexiStart,master.area,master.room)
    end
end 
function xuexiCheck() 
    checkWield()
    if locl.id[score.master] then
	   if score.party and score.party=="������" and score.master=="������ɮ" and skills["buddhism"] and skills["buddhism"].lvl==200 then
	      exe('ask wuming about ��')
	   end
       return check_bei(xuexiStart)
    else
	   ColourNote ("white","blue","ʦ�����ڼң�������ֵ�ַ�д�����ϵPANIX���£�")
	   return xuexiFinish()
    end
end
function xuexiStart()
    EnableTriggerGroup("xuexi",true)
    tmp.xuexi=1
	
	if master.id and locl.item and locl.item[score.master] and not locl.item[score.master][master.id] then
	   master.id = nil
	end
	
	if not master.id and locl.item and locl.item[score.master] then
	   for p in pairs(locl.item[score.master]) do
	       if not string.find(p," ") then
		      master.id = p
			  local l_unique = true
			  for q in pairs(locl.item) do
			      if q ~= score.master and q[master.id] then
				     l_unique = false
				  end
			  end
			  if l_unique then
			     break
			  end
		   end
	   end
	end 
	
    exe('bai '..master.id)
    yunAddInt()
	local l_skill = skillEnable[master.skills[tmp.xuexi]]
	--if l_skill and unarmedKind[l_skill] then
	   weapon_unwield()
	--end
	if l_skill and weaponKind[l_skill] then
	   if master.skills[tmp.xuexi]=="yuxiao-jian" then l_skill = "xiao" end
	   for p in pairs(Bag) do
	       if Bag[p].kind and Bag[p].kind==l_skill then
		      exe('wield '.. Bag[p].fullid)
		   end
	   end
	   checkWield()
	end
    return xuexiContinue()
end
function xuexiAction()
    EnableTriggerGroup("xuexi",false)
	
    if hp.exp>151000 and hp.neili<300 then
       return prepare_neili(xuexiContinue) 
    else
       return check_bei(xuexiContinue,1)
    end
end
function xuexiContinue()
    yunAddInt()
    flag.idle=0
	if hp.neili<1000 and Bag["������Ϣ��"] then
	   exe('eat chuanbei wan')
	end
	if hp.neili<600 and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
	    exe('eat dan')
	end
    EnableTriggerGroup("xuexi",true)
	exe('yun jing;xue '..master.id..' '.. master.skills[tmp.xuexi] ..' '.. master.times)
	if master.skills[tmp.xuexi]=="taiji-quan" then
	   exe('ask zhang sanfeng about ̫��ȭ��')
	end
    exe('hp')
end
function xuexiNext()
    EnableTriggerGroup("xuexi",false)
    tmp.skill=master.skills[tmp.xuexi]
    if skills[tmp.skill] then
       if skills[tmp.skill].lvl>=220 then
          skills[tmp.skill].mstlvl=220
       else
          skills[tmp.skill].mstlvl=skills[tmp.skill].lvl
       end
    end
    tmp.xuexi=tmp.xuexi+1
    if tmp.xuexi>table.getn(master.skills) then
       flag.xuexi=0
       return xuexiFinish()
    end
	local l_skill = skillEnable[master.skills[tmp.xuexi]]
	--if l_skill and unarmedKind[l_skill] then
	   weapon_unwield()
	--end
	if l_skill and weaponKind[l_skill] then
	   if master.skills[tmp.xuexi]=="yuxiao-jian" then l_skill = "xiao" end
	   for p in pairs(Bag) do
	       if Bag[p].kind and Bag[p].kind==l_skill then
		      exe('wield '.. Bag[p].fullid)
		   end
	   end
	   checkWield()
	end
	
    return check_bei(xuexiContinue)
end
function xuexiLvlUp(n,l,w)
    for p in pairs(skills) do
        if skills[p].name==w[2] then
	   skills[p].mstlvl=nil
	   break
	end
    end
end
function xuexiSleep()
    EnableTriggerGroup("xuexi",false)
	
	if hp.neili > 500 and master.times and master.times > 1 then
	    master.times = math.modf(master.times/2)
		if master.times < 1 then
		   master.times = 1
		end
		return check_bei(xuexiContinue,1)
	end
	
	local l_where,l_room = sjGetSleepRoom()
	if l_where then
	    return go(xuexiSleepOver,l_where,l_room)
	else
	    return xuexiFinish()
	end
	
    if score.party and score.party=="������" then
       return go(xuexiSleepOver,"������","����")
    end
    if score.party and score.party=="������" then
       return go(xuexiSleepOver,"shaolin/sengshe3","")
    end
	if score.party and score.party=="�һ���" then
       return go(xuexiSleepOver,"����ׯ","�ͷ�")
    end  
	if score.party and score.party=="�䵱��" then
	   if score.gender == "Ů" then
          return go(xuexiSleepOver,"�䵱ɽ","Ů��Ϣ��")
	   else
	      return go(xuexiSleepOver,"�䵱ɽ","����Ϣ��")
	   end
    end
	if score.party and score.party=="��ɽ��" then
	   if score.gender == "Ů" then
          return go(xuexiSleepOver,"songshan/nv-room","")
	   else
	      return go(xuexiSleepOver,"songshan/nan-room","")
	   end
    end
	if score.party and score.party=="������" then
       return go(xuexiSleepOver,"��������","����")
    end
	if score.party and score.party=="����Ľ��" then
       return go(xuexiSleepOver,"mr/xiangfang","")
    end
	if score.party and score.party=="ȫ���" then
       return go(xuexiSleepOver,"ȫ���","��Ϣ��")
    end

    --return check_heal()
	return xuexiFinish()
end
function xuexiSleepOver()
    exe('sleep')
    checkWait(xuexiYinggu,3)
end
function xuexiFinish()
    EnableTriggerGroup("xuexi",false)
    DeleteTriggerGroup("xuexi")
    return go(xuexiYingover,"�����","���")
end
function xuexiYingover()
    exe('ask ying gu about over')
    if tmp.xskill then
       return fullSkill(tmp.xskill)
    else
	   if hp.pot > 100 then
	      return potSave()
	   else
	      return check_heal()
	   end
    end
end
function yunAddInt()
    --[[
    if perform.force and perform.force=="linji-zhuang" then
       exe('yun zhixin')
    end
	if perform.force and perform.force=="bihai-chaosheng" then
       exe('yun qimen')
    end
	if perform.force and perform.force=="yunu-xinjing" then
       exe('yun xinjing')
    end
	]]--
	if perform.force and skillsAddInt[perform.force] then
	    exe(skillsAddInt[perform.force])
	end
end

function literate()
    DeleteTemporaryTriggers()
	if hp.exp<151000 then
	    master.times=3
	else
	    master.times=math.modf(hp.jingxue/100)
	    if score.int>9  then master.times = master.times + 2 end
	    if score.int>19 then master.times = master.times + 2 end
	    if score.int>29 then master.times = master.times + 2 end
	    if master.times>50 then master.times=50 end
	end
	return go(literatePot,"������","Ǳ������")
end
function litYinggu()
    return prepare_neili(litYingguAsk)
end
function litYingguAsk()
    exe('ask ying gu about start')
    return literateGo()
end
function literatePot()
    exe('qn_qu 3000')
	exe("qn_cha")
	return go(litYinggu,"�����","���")
end
function literateGo()
    go(literateCheck,'���ݳ�','��Ժ')
end
function literateCheck()
    flag.idle = 0
    exe('score;hp;cha')
    checkBags()
    return checkWait(literateXue,0.8)
end
function literateXue()
    if not locl.id["������"] then
	   return literateBack()
	end
    if hp.neili<100 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   else
          return literateBack()
	   end
    end
	if hp.neili<1000 then
	   exe('eat '.. drug.neili)
	end
	if score.int and skills["literate"].lvl>=hp.pot_max-100 then
       return literateBack()
    end
    if score.int and skills["literate"].lvl>=score.int*10 then
       return literateBack()
    end
    if Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>30 and hp.pot>master.times-1 then
       yunAddInt()
       exe('yun jing;xue gu literate '..master.times)
       return literateCheck()
    elseif hp.pot<master.times then
       return literateBack()
    elseif score.gold>300 then
       return check_bei(literateQu,1)
	else
	   return literateBack() 
    end
end
function literateQu()
    exe('s;w;#3n;w;qu 30 gold')
    exe('e;#3s;e;n')
    return check_busy(literateCheck,1)
end
function literateBack()
    exe('hp')
    return go(xuexiYingover,"�����","���")
end

function duanzao()
    DeleteTemporaryTriggers()
	if hp.exp<151000 then
	    master.times=3
	else
	    master.times=math.modf(hp.jingxue/100)
	    if master.times>50 then master.times=50 end
	end
	return go(duanzaoPot,"������","Ǳ������")
end
function duanzaoYinggu()
    exe('ask ying gu about start')
    return prepare_neili(duanzaoGo)
end
function duanzaoPot()
    exe('qn_qu 3000')
	exe("qn_cha")
	return go(duanzaoYinggu,"�����","���")
end
function duanzaoGo()
    return go(duanzaoCheck,'���ݳ�','������')
end
function duanzaoCheck()
    flag.idle = 0
    exe('score;hp;cha')
    checkBags()
    return checkWait(duanzaoXue,0.8)
end
function duanzaoXue()
    if not locl.id["����ʦ"] then
	   return duanzaoBack()
	end
    if hp.neili<100 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   else
          return duanzaoBack()
	   end
    end
	if hp.neili<1000 then
	   exe('eat '.. drug.neili)
	end
    if skills["duanzao"] and skills["duanzao"].lvl>=221 then
       return duanzaoBack()
    end
    if Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>30 and hp.pot>master.times-1 then
       yunAddInt()
       exe('yun jing;xue shi duanzao '..master.times)
       return duanzaoCheck()
    elseif hp.pot<master.times then
       return duanzaoBack()
    elseif score.gold>300 then
       return check_bei(duanzaoQu,1)
	else
	   return duanzaoBack() 
    end
end
function duanzaoQu()
    exe('n;#3w;#3n;w;qu 30 gold')
    exe('e;#3s;#3e;s')
    return check_busy(duanzaoCheck,1)
end
function duanzaoBack()
    exe('hp')
    return go(xuexiYingover,"�����","���")
end

function zhizao()
    DeleteTemporaryTriggers()
	if hp.exp<151000 then
	    master.times=3
	else
	    master.times=math.modf(hp.jingxue/100)
	    if master.times>50 then master.times=50 end
	end
	return go(zhizaoPot,"������","Ǳ������")
end
function zhizaoYinggu()
    exe('ask ying gu about start')
    return prepare_neili(zhizaoGo)
end
function zhizaoPot()
    exe('qn_qu 3000')
	exe("qn_cha")
	return go(zhizaoYinggu,"�����","���")
end
function zhizaoGo()
    return go(zhizaoCheck,'�����','�÷��')
end
function zhizaoCheck()
    flag.idle = 0
    exe('score;hp;cha')
    checkBags()
    return checkWait(zhizaoXue,0.8)
end
function zhizaoXue()
    if not locl.id["�ϲ÷�"] then
	   return zhizaoBack()
	end
    if hp.neili<100 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   else
          return zhizaoBack()
	   end
    end
	if hp.neili<1000 then
	   exe('eat '.. drug.neili)
	end
    if skills["zhizao"] and skills["zhizao"].lvl>=221 then
       return zhizaoBack()
    end
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>30 and hp.pot>master.times-1 then
       yunAddInt()
       exe('yun jing;xue caifeng zhizao '..master.times)
       return zhizaoCheck()
    elseif hp.pot<master.times then
       return zhizaoBack()
    elseif score.gold>300 then
       return check_bei(zhizaoQu,1)
	else
	   return zhizaoBack() 
    end
end
function zhizaoQu()
    exe('e;n;#3e;n;qu 30 gold')
    exe('s;#3w;s;w')
    return check_busy(zhizaoCheck,1)
end
function zhizaoBack()
    exe('hp')
    return go(xuexiYingover,"�����","���")
end

function wuxingzhen()
    DeleteTemporaryTriggers()
    flag.times=1
    return go(wuxingzhenCheck,'xiangyang/wen/wofang1')
end
function wuxingzhenCheck()
    if locl.id["�·�ɽ"] then
        return wuxingzhenStart()
    else
        return wuxingzhenFinish()
    end
end
function wuxingzhenStart()
    exe('yun jing')
	exe('ask wen fangshan about ������')
    if math.random(1,5)==1 then
        exe('cha;hp')
        locate()
		condition = {}
		exe('cond')
    end
    return check_bei(wuxingzhenCon,1)
end
function wuxingzhenCon()
    if skills["wuxing-zhen"] and skills["wuxing-zhen"].lvl>199 then
        return wuxingzhenFinish()
    end
    if not locl.id["�·�ɽ"] or hp.pot<20 then 
        return wuxingzhenFinish()
    end
	if tmp.wxz and (not condition["����æ״̬"] or condition["����æ״̬"]<=20) then
	    return wuxingzhenFinish()
    end
    return check_busy(wuxingzhenStart,1)
end
function wuxingzhenFinish()
    tmp.wxz = nil
    return check_heal()
end

function checkPrepare()

    if score.vip == "������" or (score.viptime and score.viptime < 20) then
	    return vipMonthCard()
    end
	
	if GetVariable("flagshihui") and GetVariable("flagshihui")=="yes" then
	    return shihuiGet()
	end
	
	if GetVariable("flagautoparty") and GetVariable("flagautoparty")=="yes" then
	    local p_func = partyPrepare()
		if p_func and _G[p_func] then return _G[p_func]() end
	end
	
    enableSkill = enableSkill or {}
    for p in pairs(enableSkill) do
	    if enableSkill[p].std and enableSkill[p].lvl then
            local l_v = enableSkill[p].lvl
            local l_s = enableSkill[p].std * 2 / 3
            if enableSkill[p].std > 100 and l_s > l_v then
               return husongQuit()
            end
	    end
    end

    drugPrepare = drugPrepare or {}
	
	if hp.exp>140000 and score.party=="��ͨ����" and not skills["baduan-jin"] then
	    job.zuhe = {}
		job.zuhe["zhujian"] = true
		job.zuhe["clb"] = true
        return check_job()
	end
	
	if hp.exp>140000 and score.party== "������" and skills["force"] and skills["force"].lvl>29 and skills["force"].lvl<100 then
	    return fullforce()
	end
	
	if hp.exp>140000 and score.party~= "������" and skills["force"] and skills["force"].lvl>29 and skills["force"].lvl<100 then
	    return fullmrforce()
	end
	
	if hp.exp>140000 and score.party=="��ͨ����" and skills["baduan-jin"] and skills["baduan-jin"].lvl < 220 and skills["baduan-jin"].lvl < hp.pot_max-100 and skills["literate"] and skills["literate"].lvl > 30 then
        return fullbaduanjin()
	end
	
	if hp.exp>140000 and hp.neili_lim>1200 and hp.neili_max < 1200 then
	    return fullNeili()
	end
	
	if hp.exp>140000 and hp.jingli_max < hp.jingli_lim-100 and hp.jingli_max < 1000 then return fulljingli() end
	
	if hp.exp>140000 and skills["parry"] and skills["parry"].lvl>29 and skills["parry"].lvl<101 then
	   return fullparry()
	end
	
	if hp.exp>140000 and skills["strike"] and skills["strike"].lvl>29 and skills["strike"].lvl<101 then
	   return fullstrike()
	end
	
	if hp.exp>140000 and skills["leg"] and skills["leg"].lvl>29 and skills["leg"].lvl<101 then
	   return fullleg()
	end
	
	if hp.exp>140000 and skills["strike"] and skills["strike"].lvl>1 and skills["strike"].lvl<31 then
	   return fullemstrike()
	end
	
	if hp.exp>140000 and skills["dodge"] and skills["dodge"].lvl>29 and skills["dodge"].lvl<101 then
	   return fulldodge()
	end
	
	if hp.exp > 140000 and hp.exp < 160000 then
	    for p in pairs(skills) do
	        if skillEnable[p] then
		        local q = skillEnable[p]
		 	    if skills[p].lvl < skills[q].lvl then
		 	        return fullbskill(p)
		 	    end
		    end
	    end
	end
	
	--if GetVariable("flagfull") and GetVariable("flagfull")=="yes" and hp.exp>200000 and hp.neili_max < hp.neili_lim - 1000 then return fullNeili() end
    
	local l_month = tonumber(GetVariable("month"))
	l_month = l_month or 0
	if l_month < score.month then
	    return checkMonth()
	end
	
    if Bag["����"] then
	    return tiaoshui()
	end
	
	count.gold_max = 10
	for p in pairs(weaponPrepare) do
	    if not Bag[p] and weaponStore[p]=="xiangyang/bingqipu" then
		    count.gold_max = 20
		end
	end
	
    if Bag and Bag["����"] and Bag["����"].cnt and Bag["����"].cnt>500 then
        return check_gold()
    end
    if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<count.gold_max and score.gold>count.gold_max) or (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>count.gold_max*4) then
        return check_gold()
	end
	
	if hp.exp<150000 then
        return checkPrepareOver()
    end
	
	local l_drug,l_cnt = isInBags(drug.neili)
    if score.gold and score.gold>100 and (not l_drug or l_cnt<count.nxw_max) and drugPrepare["������Ϣ��"] then
        return checkNxw()
    end
	
	if not Bag["�ۻ�"] then
       return checkXionghuang()
    end
	
	if not flag.item then
       if score.party and score.party=="������" and not Bag["����"] then
          return check_item()
	   end
       if score.party=="������" and not Bag["����"] and not Bag["����"] then
	      return check_item()
	   end
	end
	
	if not Bag["�󻹵�"] and drugPrepare["�󻹵�"] and score.tongbao and score.tongbao>500 then 
	   return checkDhd()
	end
	
	if not Bag["�쾦���"] and drugPrepare["�쾦���"] and score.tongbao and score.tongbao>500 then
       return checkBingchan()
    end
	
	if not Bag["����"] and drugPrepare["����"] then
       return checkFire()
    end
	
	for p in pairs(weaponPrepare) do
	    local weaponxiao = {
		                ["������"] = true,
						["����"]   = true,
						["������"] = true,
		                   }
	    if weaponStore[p] and not Bag[p] and Bag["�ƽ�"].cnt>18 then
		   return checkWeapon(p)
		end
		if weaponFunc[p] and not Bag[p] then
		   return _G[weaponFuncName[p]]()
		end
		if score.party and score.party == "�һ���" and weaponxiao[p] and not Bag["������"] and not Bag["����"] and not Bag["������"] then
		   if not flag.xiao then flag.xiao = 0 end
		   flag.xiao = flag.xiao + 1
		   if flag.xiao > 30 then flag.xiao = 1 end
		   if flag.xiao == 1 then
		      return weaponGetXiao()
		   end
		end
	end
	
	local l_cut = false
	for p in pairs(Bag) do
	    if Bag[p].kind and weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind]=="cut" then
		   l_cut = true
		end
	end
	if not l_cut and not Bag["ľ��"] then
	   weaponPrepare["ľ��"] = true
	   return checkWeapon("ľ��")
	end
	
    if Bag["����"] then
	   return checkJinhe()
	end
   
    if Bag["�ɹ��غ�"] then
	   return checkMgmh()
	end
	
	if Bag["�����غ�"] then
	   return checkXymh()
	end
	
	if Bag["Τ��֮��"] then
	   return checkHammer()
	end
	
	for p in pairs(Bag) do
	    --if Bag[p] and itemSave[p] then
		if Bag[p] and isItemSave(p) then
           return checkYu(p)
		end
	    if Bag[p].id and Bag[p].id["yu"] and string.find(p,"��") then
		   return checkSell(p)
		end
    end
	
	exe('wear all')
	
	--if perform.force and skills[perform.force].lvl < skills["force"].lvl and skills[perform.force].lvl < hp.pot_max-120 then
	--   return fullSkill(perform.force)
	--end
	
	if GetVariable("flagfull") and GetVariable("flagfull")=="yes" and hp.exp>200000 and perform.skill and skills[perform.skill] and skillEnable[perform.skill] and skills[perform.skill].full==0 and skills[perform.skill].lvl < hp.pot_max-110 then
	    return fullSkill(perform.skill)
	end
	
	local l_cwexp = 15000000 
	if GetVariable("cwexp") then
	    l_cwexp = tonumber(GetVariable("cwexp"))
	    if l_cwexp < 15000000 then
		    l_cwexp = 15000000
		end
	end
	if hp.exp>l_cwexp then 
	    canwu = canwu or {}
	    if not canwu.exp or canwu.exp<100 then
		   flag.wxjz=0
	       return canWu("exp")
	    end
    end
	
	local l_cwgift = 20000000 
	if GetVariable("cwgift") then
	    l_cwgift = tonumber(GetVariable("cwgift"))
	    if l_cwgift < 20000000 then
		    l_cwgift = 20000000
		end
	end
	if hp.exp>l_cwgift then 
	   canwu = canwu or {}
	   if not canwu.gift or canwu.gift<120 then
	      flag.wxjz=0
	      return canWu("gift")
	   end
    end
	
    return checkPrepareOver()
end
function checkPrepareOver()
    if flag.autoxuexi==1 and score.party and score.party == "����Ľ��" and skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl>200 and
	   skills["shenyuan-gong"] and skills["shenyuan-gong"].lvl>200 and skills["douzhuan-xingyi"].lvl<hp.pot_max-100 and MidNight[locl.time] and
	   skills["dodge"] and skills["dodge"].lvl>250 then
	    return fulldzxy()
	end
    return check_pot()
end

jobtimes = {}
function checkJobtimes(n,l,w)
	jobtimes[w[1]] = tonumber(w[2])
end
function checkJoblast(n,l,w)
    joblast = joblast or {}

    if joblast[w[2]] then
       job.last = joblast[w[2]]
    end
end

function check_job()
    
    --if hp.exp<149000 then
    --    return xunCheng()
    --end
   
    if score.party=="�һ���" and (hp.shen>100000 or hp.shen<-100000) then
        if hp.shen>200000 then
	       return turnShen("-")
	    end
	    if hp.shen<-200000 then
	       return turnShen("+")
	    end
        return thdJiaohui()
    end
   
    if skills["duanzao"] and skills["duanzao"].lvl>200 and score.gold and score.gold>150 and weaponUsave and countTab(weaponUsave)>0 and math.random(1,10)==1 then
        return weaponUcheck()
    end
   
    condition = {}
    exe('follow none;cond;jobtimes') 
   
    return check_busy(checkQuest)
   --return check_jobx()
end
function check_jobx()

    if hp.exp>200000 and perform.skill and skills[perform.skill] and skills[perform.skill].lvl<150 and skills[perform.skill].lvl<skills[skillEnable[perform.skill]].lvl and
        skills[perform.skill].lvl<hp.pot_max-130 and flag.autoxuexi and flag.autoxuexi==1 then
        lianxi()
        if tmp.pskill and skillEnable[tmp.pskill]~="force" and flag.lianxi==0 then 
            return fullSkill()
	    end
    end
	
	jobExpTongji()
    
	if jobSpecial["was"] and job.zuhe["was"] and (not jobCond["was"] or jobCond["was"]()) then
        return _G["was"]()
	end
	
	if jobSpecial["gmd"] and job.zuhe["gmd"] and (not jobCond["gmd"] or jobCond["gmd"]()) then
        return _G["gmd"]()
	end
	
	--if jobSpecial["hubiao"] and job.zuhe["hubiao"] and (not jobCond["hubiao"] or jobCond["hubiao"]()) then
    --    return _G["hubiao"]()
	--end
	
    for p in pairs(jobSpecial) do
        if job.zuhe[p] and (not jobCond[p] or jobCond[p]()) then
            return _G[p]()
	 	end
    end
    
    return checkJob()
end
function checkJob()

    if job.zuhe["songxin2"] then
        job.zuhe["songxin2"]=nil
	    job.zuhe["songxin"]=true
	    flag.sx2=true
    end
   
    if job.last and job.zuhe[job.last] then
        if type(job.zuhe[job.last]) == "number" then
	        job.zuhe[job.last] = job.zuhe[job.last] + 1
	    else
	        job.zuhe[job.last] = 1
	    end
    end
   
    if score.party and score.party=="��ɽ��" and countTab(job.zuhe) > 2 and not skills["dugu-jiujian"] and job.zuhe["huashan"] and job.zuhe["songxin"] then
	    local t_hs,t_sx,t_gb 
	    
	    if jobtimes["��ɽ����Ⱥ�Ͷ�����"] then
	        t_hs = jobtimes["��ɽ����Ⱥ�Ͷ�����"]
	    else
	        t_hs = 0
	    end
	    if jobtimes["����������������"] then
	        t_sx = jobtimes["����������������"]
	    else 
	        t_sx = 0
	    end
	    if jobtimes["ؤ���ⳤ��ɱ������"] then
	        t_gb = jobtimes["ؤ���ⳤ��ɱ������"]
	    else 
	        t_gb = 0
	    end
        
	    local t_times = math.fmod((t_hs+t_sx+t_gb),50)
	    if t_times > 47 then
	        exe('pray pearl')
	        if job.last ~= "huashan" then
	 	        return huashan()
	 	    else
	 	        for p in pairs(job.zuhe) do
	 	 	        if p~= "huashan" and p~="songxin" and p~="hubiao" and p~="husong" then
	 	 	  	        return _G[p]()
	 	 	  	    end
	 	 	    end
	 	    end
	    end
    end

    if job.first and job.zuhe[job.first] and job.last~=job.first then
	    if not jobCond[job.first] or jobCond[job.first]() then
	  	    return _G[job.first]()
	    end
    end
   
    if job.second and job.zuhe[job.second] and job.last~=job.second then
        if not jobCond[job.second] or jobCond[job.second]() then
	  	    return _G[job.second]()
	    end
    end
   
    if job.third and job.zuhe[job.third] and job.last~=job.third then
        return _G[job.third]()
    end
    
    for p in pairs(job.zuhe) do
        if job.last ~= p and job.first ~= p and job.second ~= p then
	        if not jobSpecial or not jobSpecial[p] then
	            return _G[p]()
	  	    end
	    end
    end
    
    for p in pairs(job.zuhe) do
        if job.last ~= p then
	  	    if not jobSpecial or not jobSpecial[p] then
	            return _G[p]()
	  		end	
	    end
    end

end

function lianxi(times,xskill)
    local weapontype
    flag.lianxi=1
    local lianxi_times=5
    if times~=nil then
        lianxi_times=times
    end
    tmp.xskill = xskill
    if perform.force then
	    if not skills[perform.force] then
	        perform.force = nil
	    end
	end
	if not perform.force then
	    tmp.lvl = 0
	    for p in pairs(skills) do
	        q=skillEnable[p]
		    if q=="force" then
		        if skills[p].lvl > tmp.lvl then
		 	        tmp.lvl = skills[p].lvl
		 		    perform.force = p
		 	    end
		    end
	    end
	end
	
	tmp.lskill = nil
	for p in pairs(skills) do
	    local l_list = qrySkillEnable(p)
	    if l_list then
		   if not l_list["force"] and not l_list["dodge"] and skills[p].full==0 then
		       tmp.lskill=p
		   end
		end
	end
	--if GetVariable("lianxi") and skills[GetVariable("lianxi")] and skills[GetVariable("lianxi")].full == 0 then
	--    tmp.lskill=GetVariable("lianxi")
	--end
	for p in pairs(skills) do
	    local l_list = qrySkillEnable(p)
	    if l_list then
		    if l_list["dodge"] and skills[p].full==0 then
		        tmp.lskill=p
		    end
		end
	end
	if perform.skill and skills[perform.skill] and skills[perform.skill].full == 0 then
	    tmp.lskill=perform.skill
	end
	if perform.force and skills[perform.force] and skills[perform.force].full == 0 then
	    tmp.lskill=perform.force
	end
	if GetVariable("lianxi") then
	    local l_set=utils.split(GetVariable("lianxi"),'|')
		for p,q in ipairs(l_set) do
		    if skills[q] and skills[q].full == 0 then
			    tmp.lskill = q
				break
			end
		end
	end
	--if tmp.xskill and skills[tmp.xskill] and skills[tmp.xskill].full == 0 then
	if tmp.xskill and skills[tmp.xskill] then
	    tmp.lskill=tmp.xskill
	end
	
	--messageShow(tmp.lskill.. ' l')
	
	if tmp.lskill then
	    flag.lianxi=0
		
		if tmp.lskill and skills[tmp.lskill] and skills[tmp.lskill].full == 1 then
		    flag.lianxi=1
		end
		
	    local l_list = qrySkillEnable(tmp.lskill)
	    if l_list["force"] then lianxi_times=lianxi_times*0.5 end
	    if skillLianxi and skillLianxi[tmp.lskill] then lianxi_times=lianxi_times*skillLianxi[tmp.lskill] end
	    if tmp.lskill == "yuxiao-jian" then
	        weapontype = "xiao"
	    else
	        for q in pairs(l_list) do
		        if weaponKind[q] then
		 	        if skills[q] and weaponInBag(q) then
		 	 	        weapontype = q
		 	 	    end
		 	    else
		            weapontype = q
		 	    end
		    end
	    end
	   
	    --messageShow('flag.lianxi:'.. flag.lianxi)
	    if not weapontype then
	        flag.lianxi = 1
	    end
	    if weaponKind[weapontype] and not weaponInBag(weapontype) then
	        flag.lianxi = 1
	    end
	    if tmp.xskill and tmp.xskill ~= tmp.lskill then
	        flag.lianxi = 1
	    end
	    if flag.lianxi == 0 and unarmedKind[weapontype] then
            exe('bei none')			
	        if weaponIsWield() then
	    	    weapon_unwield()
	        end
	    end
	    if flag.lianxi == 0 and weaponKind[weapontype] and weaponIsWield() and not weaponInWield(weapontype) then
	        weapon_unwield()
	    end
	    if flag.lianxi == 0 then
	        if tmp.lskill == "yuxiao-jian" then
	            exe('enable sword yuxiao-jian')
	        else
	            exe('enable '..weapontype..' '..tmp.lskill)
		    end
	    end
	end
	
	--messageShow('flag.lianxi:'.. flag.lianxi)
	
	if flag.lianxi == 0 then
	    tmp.pskill = tmp.lskill
	    --messageShow(tmp.pskill.. ' p')
	    if weaponKind[weapontype] and not weaponInWield(weapontype) then
            exe('wield '.. weapontype)
	        for k,v in pairs(Bag) do
	            if Bag[k].kind == weapontype then
	                exe('wield '..Bag[k].fullid)
	            end
	        end
		    exe('i')
	    end
	    if tmp.lskill == "yuxiao-jian" then 
	        exe('lian sword '..lianxi_times)
	    else
            exe('lian '..weapontype..' '..lianxi_times)
	    end
	    exe('hp')
	end
	
	if not tmp.xskill then
       beiUnarmed()
	end
end
function beiUnarmed()
    local l_skill=beiUnarmedSkill()
	if l_skill and type(l_skill)=="string" and skillEnable[l_skill] then
	   exe('bei none')
	   exe('jifa '.. skillEnable[l_skill] ..' '.. l_skill)
	   exe('bei '.. skillEnable[l_skill])
	end
	if skillHubei[l_skill] and skills[skillHubei[l_skill]] then
	   l_skill = skillHubei[l_skill]
	   exe('jifa '.. skillEnable[l_skill] ..' '.. l_skill)
	   exe('bei '.. skillEnable[l_skill])
	end
end
function beiUnarmedSkill()
    local l_lvl=0
	local l_skill
    if perform and perform.skill and skillEnable[perform.skill] and unarmedKind[skillEnable[perform.skill]] then
       --exe('bei '.. skillEnable[perform.skill])
       return perform.skill
    end
    if score.party then 
       if score.party=="������" and skills["hand"] and skills["jieshou-jiushi"] then
          --exe('bei none;jifa hand jieshou-jiushi;bei hand')
	      return "jieshou-jiushi"
       end
       if score.party=="ؤ��" and skills["strike"] and skills["xianglong-zhang"] then
          --exe('bei none;jifa strike xianglong-zhang;bei strike')
	      return "xianglong-zhang"
       end
    end
    for p in pairs(skills) do
        if skillEnable[p] then
	       q = skillEnable[p]
	       if unarmedKind[q] then
	          if skills[p].lvl>l_lvl then
	             l_lvl=skills[p].lvl
			     l_skill=p
	             --exe('bei none;jifa '..q..' '..p..';bei '..q)
	          end
	       end
	    end
    end
	return l_skill
end

function check_busy(func,p_cmd)
    disWait()
	if hp.exp < 3000 then return check_halt(func,p_cmd)	end
    DeleteTriggerGroup("check_bei")
    create_trigger_t('check_bei1',"^(> )*(�������Ѿ����|����׼����һ�ּ�����|�����ٲ���������ȭ�ż��ܵ�����֮һ)",'','beiok')
    create_trigger_t('check_bei2',"^(> )*������û�м����κ���Ч���⼼�ܡ�",'','beinone')
    SetTriggerOption("check_bei1","group","check_bei")
	SetTriggerOption("check_bei2","group","check_bei")
	EnableTriggerGroup("check_bei",true)
	EnableTrigger("hp12",true)
    beihook=func
    
    if not p_cmd then
	    exe('bei bei bei')
	end
	return bei_timer()
end
function bei_timer()
       return create_timer_s('bei',0.4,'bei_timer_set')
end
function bei_timer_set()
    --EnableTriggerGroup("check_bei",true)
   exe('bei bei bei')
end
function beinone()
   for p,q in pairs(skillEnable) do
       if skills[p] and q~="force" then
          exe('jifa '..q..' '..p)
		  if math.random(1,3)==1 then
		     break
		  end
	   end
   end
end 
function beiok()
     EnableTriggerGroup("check_bei",false)
	 EnableTrigger("hp12",false)
	 --DeleteTimer('bei')
	 --DeleteTriggerGroup("check_bei")
	 EnableTimer('bei',false)
	 if beihook==nil then
	    beihook=test
	 end
         return beihook()
end
function check_halt(func)
         disWait()
		 
         DeleteTriggerGroup("check_halt")
         create_trigger_t('check_halt1',"^>*\\s*(�����ڲ�æ��|���������һԾ������սȦ�����ˡ�)",'','haltok')
         SetTriggerOption("check_halt1","group","check_halt")
		 EnableTriggerGroup("check_halt",true)
		 EnableTrigger("hp12",true)
         halthook=func         
         exe('halt')
	     return halt_timer()
end
function halt_timer()
       return create_timer_s('halt',0.4,'halt_timer_set')
end
function halt_timer_set()
    --EnableTriggerGroup("check_halt",true)
   exe('halt')
end
function haltok()
     EnableTriggerGroup("check_halt",false)
	 EnableTrigger("hp12",false)
	 --DeleteTimer('halt')
	 EnableTimer('halt',false)
	 --DeleteTriggerGroup("check_halt")
	 if halthook==nil then
	    halthook=test
	 end
    return halthook()
end
busyhook=test
function check_bei(func,p_cmd)
    disWait()
	if hp.exp < 3000 then return check_halt(func,p_cmd)	end
    DeleteTriggerGroup("check_busy")
    create_trigger_t('check_busy1',"^>*\\s*û������������࣬��",'','busyok')
    SetTriggerOption("check_busy1","group","check_busy")
	EnableTriggerGroup("check_busy",true)
	EnableTrigger("hp12",true)
    busyhook=func
	if not p_cmd then
        exe('jifa jifa jifa')
	end
	jifa_timer()
end
function jifa_timer()
       return create_timer_s('jifa',0.4,'jifa_timer_set')
end
function jifa_timer_set()
    --EnableTriggerGroup("check_busy",true)	
    exe('jifa jifa jifa')
end
function busyok()
     EnableTriggerGroup("check_busy",false)		
     EnableTrigger("hp12",false)	 
	 --DeleteTimer('jifa')
	 EnableTimer('jifa',false)
	 if busyhook==nil then
	    busyhook=test
	 end
     return busyhook()
end

waithook=test
function checkWait(func,sec)
   disWait()
   DeleteTriggerGroup("checkwait")
   create_trigger_t('checkwait1','^(> )*��� "action" �趨Ϊ "�ȴ�һ��" �ɹ���ɡ�$','','checkWaitOk')
   SetTriggerOption("checkwait1","group","checkwait")
   EnableTriggerGroup("checkwait",true)
   EnableTrigger("hp12",true)
   waithook=func
   if sec == nil then sec=5 end
      return create_timer_s('waitimer',sec,'wait_timer_set')
end
function wait_timer_set()
   --EnableTriggerGroup("checkwait",true)
   exe('alias action �ȴ�һ��')
end
function checkWaitOk()
   EnableTriggerGroup("checkwait",false)
   EnableTrigger("hp12",false)
   --DeleteTimer('waitimer
   EnableTimer('waitimer',false)
   if waithook==nil then
      waithook=test
   end
   return waithook()
end

nexthook = test
function checkNext(func)
   disWait()
   DeleteTriggerGroup("checknext")
   create_trigger_t('checknext1','^(> )*��� "action" �趨Ϊ "����ǰ��" �ɹ���ɡ�$','','checkNextOk')
   SetTriggerOption("checknext1","group","checknext")
   EnableTriggerGroup("checknext",true)
   EnableTrigger("hp12",true)
   nexthook=func
   next_timer_set()
   return create_timer_s('nextimer',0.5,'next_timer_set')
end
function next_timer_set()
   exe('alias action ����ǰ��')
end
function checkNextOk()
   EnableTriggerGroup("checknext",false)
   EnableTrigger("hp12",false)
   EnableTimer('nextimer',false)
   if nexthook==nil then
      nexthook=test
   end
   return nexthook()
end

AWhook = test
function checkAW(func,sec)
   DeleteTriggerGroup("checkAW")
   create_trigger_t('checkAW1','^(> )*��� "action" �趨Ϊ "��һ��" �ɹ���ɡ�$','','checkAWOk')
   SetTriggerOption("checkAW1","group","checkAW")
   EnableTriggerGroup("checkAW",true)
   EnableTrigger("hp12",true)
   AWhook=func
   --AW_timer_set()
   if sec == nil then sec=2 end
   if IsTimer('AWimer')==0 then
      EnableTimer('AWimer',true)
   else
      return create_timer_s('AWimer',sec,'AW_timer_set')
   end
end
function AW_timer_set()
   exe('alias action ��һ��')
end
function checkAWOk()
   EnableTriggerGroup("checkAW",false)
   EnableTrigger("hp12",false)
   EnableTimer('AWimer',false)
   if AWhook==nil then
      AWhook=test
   end
   return AWhook()
end

function disWait()
    EnableTriggerGroup("checkwait",false)
	EnableTriggerGroup("check_bei",false)
    EnableTriggerGroup("check_busy",false)
    EnableTriggerGroup("check_halt",false)
	EnableTriggerGroup("checknext",false)
    DeleteTriggerGroup("checkwait")
    DeleteTriggerGroup("check_bei")
    DeleteTriggerGroup("check_busy")
    DeleteTriggerGroup("check_halt")
	DeleteTriggerGroup("checknext")
    EnableTimer('waitimer',false)
    EnableTimer('jifa',false)
    EnableTimer('halt',false)
    EnableTimer('bei',false)
	EnableTimer('nextimer',false)
end
function resetWait()
	local t = GetTimerList()
	
	--if math.random(1,2) == 1 then return end
	if t and type(t)=="table" then
	   for k, v in pairs (GetTimerList()) do 
	       --messageShow(v)
           if IsTimer(v)==0 and GetTimerInfo(v, 6) and tonumber(GetTimerInfo(v, 3))<tonumber(GetTimerInfo(v, 13)) then 
              messageShow(v..' '..'�趨ʱ��:'..GetTimerInfo(v, 3)..'�룬��һ��ʱ��:'..GetTimerInfo(v, 13)..'�롣')
	          ResetTimers()
			   break
           end
       end
	end
end

function transs(num)
   local words={}
   local i=0
   num=string.gsub(num,"��ʮ","10 ");
   num=string.gsub(num,"��","");
   num=string.gsub(num,"һ","1");
   num=string.gsub(num,"��","2");
   num=string.gsub(num,"��","3");
   num=string.gsub(num,"��","4");
   num=string.gsub(num,"��","5");
   num=string.gsub(num,"��","6");
   num=string.gsub(num,"��","7");
   num=string.gsub(num,"��","8");
   num=string.gsub(num,"��","9");
   i=string.find(num,"ʮ")
   if i==1 then
      num=string.gsub(num,"ʮ","10 ")
   else
      num=string.gsub(num,"ʮ","0 ")
   end
   num=string.gsub(num,"��","00 ")
   num=string.gsub(num,"ǧ","000 ")
   num=string.gsub(num,"��","0000 ")
   for w in string.gmatch(num,"(%w+)") do
       table.insert(words,w)
   end
   i=0
   for p=1,table.getn(words) do
       i=i+tonumber(words[p])
   end
   return i
end
function trans(s)----------------����ת��

   if s == nil then return 0 end
   
   local cur    = 0
   local yi    = 0
   local sgl    = 0
   local len    = string.len(s)
   local tt = {}
   tt["��"] = function() end
   tt["һ"] = function() sgl = 1   end
   tt["��"] = function() sgl = 2   end
   tt["��"] = function() sgl = 3   end
   tt["��"] = function() sgl = 4   end
   tt["��"] = function() sgl = 5   end
   tt["��"] = function() sgl = 6   end
   tt["��"] = function() sgl = 7   end
   tt['��'] = function() sgl = 8   end
   tt["��"] = function() sgl = 9   end
   tt["ʮ"] = function()
      if sgl == 0 then sgl = 1 end
      cur = cur + sgl * 10
      sgl = 0
   end
   tt["��"] = function()
      cur = cur + sgl * 100
      sgl = 0
   end
   tt["ǧ"] = function()
      cur = cur + sgl * 1000
      sgl = 0
   end
   tt["��"] = function()
      cur = (cur +sgl) * 10000
      sgl = 0
   end
   tt["��"] = function()
      yi = (cur + sgl) * 100000000
      cur = 0
      sgl = 0
   end
   for i = 1,len,2 do
      k = string.sub(s,i,i+1)
	  if tt[k] then
         tt[k]()
	  end
   end
   num = yi + cur +sgl
----   print(num)
   return num
end
function idle()
    hp.expBak = hp.expBak or -1
    if hp.exp and hp.exp~=hp.expBak then
       hp.expBak = hp.exp
	   cntrI = countR(20)
	else
	   if cntrI()<1 then
	      cntrI = countR(20)
	      flag.idle = 50
	      return idle_set()
	   end
	end
    flag.idle=0
    return create_timer_s('idle',30,'idle_set')
end
function idle_set()
   if not flag.idle or type(flag.idle)~="number" then
      flag.idle = 0
   end
   resetWait()
   flag.idle = flag.idle + 1
   if flag.idle<6 then
      return
   end
   if flag.idle<20 then
      chats_log("ROBOT �����ѷ���".. flag.idle/2 .."����!","deepskyblue")
	  return
   end
   dis_all()
   userSave()
   chats_locate('��λϵͳ������ʮ���Ӻ��ڡ�'.. locl.area .. locl.room ..'����������ϵͳ��','red')
   Disconnect()
   Connect()
end

function checkWield()
    itemWield = {}
    exe('i')
end
function checkWieldCatch(n,l,w)
    itemWield = itemWield or {}
    local l_item = w[1]
    for p in pairs(weaponThrowing) do
        if string.find(l_item,p) then
	       l_item = p
	    end
    end
    itemWield[l_item] = true
	
	local l_skill
	if perform.skill then
	    l_skill = skillEnable[perform.skill]
		if perform.skill == "yuxiao-jian" then
		    l_skill = "xiao"
		end
	end
	
	if l_skill and Bag[l_item] and Bag[l_item].kind == l_skill then
	    itemWield["perform"] = true
	end
end

function checkBags(func)
   DeleteTriggerGroup("bags")
   create_trigger_t('bags1',"^(> )*������Я����Ʒ�ı������",'','checkBagsStart')
   create_trigger_t('bags2',"^\\d*:(\\D*) = (\\D*)$",'','checkBagsId')
   --create_trigger_t('bags3','^(> )*��Ŀǰ�Ѿ�ӵ����(\\D*)��˽��װ����(\\D*)��$','','checkBagsU')
   create_trigger_t('bags4','^(> )*(\\D*)(��|��|��)(����|�ƽ�|ҼǪ����Ʊ)\\(','','checkBagsMoney')
   create_trigger_t('bags5','^(> )*��� "action" �趨Ϊ "������" �ɹ���ɡ�$','','checkBagsOver')
   create_trigger_t('bags6','^(> )*�����ϴ���(\\D*)������\\(����\\s*(\\d*)\\.\\d*\\%\\)��','','checkBagsW')
   SetTriggerOption("bags1","group","bags")
   SetTriggerOption("bags2","group","bags")
   --SetTriggerOption("bags3","group","bags")
   SetTriggerOption("bags4","group","bags")
   SetTriggerOption("bags5","group","bags")
   SetTriggerOption("bags6","group","bags")
   EnableTriggerGroup("bags",false)
   EnableTrigger("bags1",true)
   bags={}
   Bag={}
   Bag["�ƽ�"]={}
   Bag["�ƽ�"].id={}
   Bag["�ƽ�"].cnt=0
   Bag["����"]={}
   Bag["����"].id={}
   Bag["����"].cnt=0
   tmp.bags=func
   weaponUsave={}
   exe('id')
   checkWield()
   exe('uweapon;alias action ������')
end
function checkBagsStart()
   EnableTriggerGroup("bags",true)
end
function checkBagsId(n,l,w)
    local l_name=Trim(w[1])
    local l_id=w[2]
    local l_set={}
    local l_cnt=0

    Bag[l_name]=Bag[l_name] or {}
    Bag[l_name].id={}
    if string.find(l_id,",") then
        l_set=utils.split(l_id,',')
        l_id=l_set[1]
        for k,v in ipairs(l_set) do
	 	    Bag[l_name].id[Trim(v)]=true
	        if string.len(Trim(v))>l_cnt then
	            Bag[l_name].fullid=Trim(v)
	            l_cnt=string.len(Trim(v))
	        end
        end
    else
        Bag[l_name].id[Trim(l_id)]=true
        Bag[l_name].fullid=Trim(l_id)
    end
   
    if Bag[l_name].id["dao"] or Bag[l_name].id["blade"] then
        Bag[l_name].kind = "blade"
    end
    if Bag[l_name].id["jian"] or Bag[l_name].id["sword"] then
        Bag[l_name].kind = "sword"
    end
    if Bag[l_name].id["xiao"] then
        Bag[l_name].kind = "xiao"
    end
    if Bag[l_name].id["gun"] or Bag[l_name].id["club"] then
        Bag[l_name].kind = "club"
    end
    if Bag[l_name].id["stick"] or Bag[l_name].id["zhubang"] or Bag[l_name].id["bang"] then
        Bag[l_name].kind = "stick"
    end
    if Bag[l_name].id["bi"] or Bag[l_name].id["brush"] then
        Bag[l_name].kind = "brush"
    end
    if Bag[l_name].id["qiang"] or Bag[l_name].id["spear"] then
        Bag[l_name].kind = "spear"
    end
    if Bag[l_name].id["chui"] or Bag[l_name].id["hammer"] or Bag[l_name].id["falun"] then
        Bag[l_name].kind = "hammer"
    end
    if Bag[l_name].id["gangzhang"] or Bag[l_name].id["staff"] or Bag[l_name].id["zhang"] or Bag[l_name].id["jiang"] then
        Bag[l_name].kind = "staff"
    end
    if Bag[l_name].id["bian"] or Bag[l_name].id["whip"] then
        Bag[l_name].kind = "whip"
    end
   if Bag[l_name].id["hook"] then
       Bag[l_name].kind = "hook"
   end
   if Bag[l_name].id["fu"] or Bag[l_name].id["axe"] then
       Bag[l_name].kind = "axe"
   end
   if Bag[l_name].id["bishou"] or Bag[l_name].id["dagger"] then
       Bag[l_name].kind = "dagger"
   end
   if weaponThrowing[l_name] then
       Bag[l_name].kind = "throwing"
   end
   
    if (string.find(l_name,"��ƪ") or string.find(l_name,"��Ҫ")) and not itemSave[l_name] then
        exe('read book')
	    exe('drop '..Bag[l_name].fullid)
    end
    if string.len(l_name)==6 and (string.sub(l_name,5,6)=="��" or string.sub(l_name,5,6)=="��") and (not drugPoison[l_name] and not drugBuy[l_name]) then
	    exe('eat '.. Bag[l_name].fullid)
    end
   
    bags[l_name]=Trim(l_id)
	
    Bag[l_name].cnt = Bag[l_name].cnt or 0
    Bag[l_name].cnt = Bag[l_name].cnt + 1
    
    if Bag[l_name].kind and Bag[l_name].kind ~= "throwing" and Bag[l_name].cnt > 3 then
       exe('drop '.. Bag[l_name].fullid ..' 3')
    end
    if string.find(l_name,"����Ƭ֮") and Bag[l_name].cnt > 1 then
	    exe('drop '.. Bag[l_name].fullid ..' 2')
    end
end
function checkBagsU(n,l,w)
   local t = Trim(w[3])
   return checkBagsUweapon(t)
end
function checkBagsUweapon(t)
   local s = utils.split(t,',')
   for p,q in pairs(s) do
       weaponUsave[q] = true
   end
end
function checkBagsW(n,l,w)
   local t = tonumber(w[3])
   Bag = Bag or {}
   Bag["ENCB"] = {}
   Bag["ENCB"].value = t
end
function checkBagsMoney(n,l,w)
   local l_cnt=trans(Trim(w[2]))
   local l_name=Trim(w[4])
   if Bag[l_name] then
      Bag[l_name].cnt = l_cnt
   end
end
function checkBagsOver()
    EnableTriggerGroup("bags",false)
	
	for i = GetLinesInBufferCount()-1,1,-1 do
	    local l_string = GetLineInfo(i,1)
		if l_string and string.find(l_string,"������Я����Ʒ�ı������") then break end
		
		local _,_,uweapon = string.find(l_string,"��Ŀǰ�Ѿ�ӵ����%D*˽��װ����(%D*)��")
		if uweapon then checkBagsUweapon(uweapon) end
		
	end
	
    itemDrop = itemDrop or {}
    for p,q in pairs(itemDrop) do
        if Bag[p] and Bag[p].fullid and Bag[p].cnt >= q then
		    exe('drop '.. Bag[p].fullid)
		end
    end
    if tmp.bags~=nil then
        return tmp.bags()
    end
end

function isInBags(p_item)
   if p_item==nil then return false end
   local l_cnt = 0
   local l_item
   if Bag[p_item] then
      l_item = p_item
	  l_cnt = l_cnt + Bag[p_item].cnt
      --return p_item,Bag[p_item].cnt
   end
   for k,v in pairs(Bag) do
       if type(v)=="table" and v.id and type(v.id)=="table" then
          if v.id[p_item] then
			 l_item = k
			 l_cnt = l_cnt + Bag[k].cnt
          end
       end
   end
   if l_cnt>0 then
      return l_item,l_cnt
   end
   return false
end

function check_item()
   if score.party and score.party=="������" and not Bag["����"] then
      return check_item_go()
   elseif score.party=="������" and not Bag["����"] and not Bag["����"] then
      return go(checkSengxie,'��ɽ����','���߿�') 
   else
      return check_item_over()
   end
end
function checkSengxie()
   exe('ask chanshi about ɮЬ')
   return check_bei(checkHuyao)
end
function checkHuyao()
   exe('ask chanshi about ����')
   return check_bei(checkHuwan)
end
function checkHuwan()
   exe('ask chanshi about ����')
   return check_bei(check_item_over)
end
function check_item_go()
   go(check_item_belt,'����ɽ','�����')
end
function check_item_belt()
   exe('ask shitai about Ƥ����')
   check_bei(check_item_over)
end
function check_item_over()
   exe('drop shoes 2')
   exe('remove all')
   exe('wear all')

   flag.item=true
   
   return checkPrepare()
end

function checkJinhe()
    if Bag["����"] then
	   exe('#10(jiancha jinhe)')
	   return check_bei(checkJinheLook)
	else
	   return checkJinheOver()
	end
end
function checkJinheLook()
	DeleteTriggerGroup("jinhe")
    create_trigger_t('jinhe1',"^(> )*����Լ��",'','checkJinheChk')
    create_trigger_t('jinhe2','^(> )*���ݺὭ��ʱ����(\\D*)����Щ������','','checkJinheCon')
	create_trigger_t('jinhe3',"^(> )*��Ҫ��ʲô��",'','checkJinheNone')
    SetTriggerOption("jinhe1","group","jinhe")
    SetTriggerOption("jinhe2","group","jinhe")
	exe('look jin he')
end
function checkJinheNone()
    Bag["����"] = nil
	return checkJinheOver()
end
function checkJinheChk()
    EnableTriggerGroup("jinhe",false)
	checkBags()
	return check_busy(checkJinhe,1)
end
function checkJinheCon(n,l,w)
    EnableTriggerGroup("jinhe",false)
	job.where=tostring(w[2])
	job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if not job.room or not path_cal() then
	   exe('drop jin he')
	   checkBags()
       return check_bei(checkJinheOver,1)
    end
	tmp.rooms=getRooms(dest.room,dest.area)
	return check_bei(checkJinheGo,1)
	--return go(checkJinheDig,job.area,job.room)
end
function checkJinheGo()
    if type(tmp.rooms)=="table" and table.getn(tmp.rooms)>0 then
	   local l_path=map:getPath("xiangyang/dangpu",tmp.rooms[1])
	   if l_path then
		  return go(checkJinheCnt,tmp.rooms[1],job.room)
	   else
		  table.remove(tmp.rooms,1)
		  return check_bei(checkJinheGo,1)
	   end
	else
	   exe('drop jin he')
	   checkBags()
	   return check_busy(checkJinheOver,1)
	end
end
function checkJinheCnt()
    cntr1 = countR(3)
	return checkJinheDig()
end
function checkJinheDig()
    DeleteTriggerGroup("jinhe")
    create_trigger_t('jinhe1','^(> )*��� "action" �趨Ϊ "dig" �ɹ���ɡ�$','','checkJinheD')
    create_trigger_t('jinhe2',"^(> )*��ͻȻ(��|��)��",'','checkJinheChk')
	SetTriggerOption("jinhe1","group","jinhe")
    SetTriggerOption("jinhe2","group","jinhe")
    exe('dig')
	exe('alias action dig')
end
function checkJinheD()
    EnableTriggerGroup("jinhe",false)
	if cntr1() < 0 then
	   table.remove(tmp.rooms,1)
	   return check_busy(checkJinheGo,1)
	else
	   return check_busy(checkJinheDig,1)
    end	
end
function checkJinheOver()
    EnableTriggerGroup("jinhe",false)
	if Bag["����"] then
	   return checkJinhe()
	else
       return checkPrepare()
	end
end

function check_heal()
   --messageShow('check_heal')
   dis_all()
   tmp={}
   jobTriggerDel()  
   job.name='heal'
   exe('xidu')
   exe('enable;unset heal')
   checkBags()
   if score.party and score.party=="������" then
      exe('yun shougong '.. score.id)
   end
   if perform.force and skills[perform.force] then
	   exe('jifa force '.. perform.force)
   else
      for p in pairs(skills) do
         if skillEnable[p]=='force' then
            exe('enable force '..p)
	        break
         end
      end
   end

   exe('cha;hp;score')
   check_bei(check_jingxue_count)
end
function check_jingxue_count()
   if hp.exp<150000 then
      return check_heal_over()
   elseif hp.jingxue_per<96 or hp.qixue_per<96 then
      return check_xue()
   else
      return check_jingxue()
   end
end
function check_jingxue()
    if (hp.jingxue_per<85 or hp.qixue_per<70) and Bag["�󻹵�"] then
	    exe('eat dahuan dan;hp')
	    checkBags()
	    return check_busy(check_jingxue,1)
	else
	    if (hp.jingxue_per<80 or hp.qixue_per<40) and not Bag["�󻹵�"] and drugPrepare["�󻹵�"] then
	        return checkDhd()
	    end
	   --exe('yun heal')
	   --return check_bei(check_heal_over,1)
    end
	if hp.jingxue_per<100 then
	    exe('set heal jing')
		exe('yun heal')
	end
	return check_bei(check_qixue,1)
end
function check_qixue()
    exe('unset heal')
	exe('yun heal')
	return check_bei(check_heal_over,1)
end
function check_heal_over()
    DeleteTriggerGroup("ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    DeleteTriggerGroup("ck_xue_teach")
	if not flag.dazuo then
	   exe('cha;hp')
	   return check_bei(hp_dazuo_count,1)
    end	
	condition = {}
	exe('cond')
    return check_bei(checkPrepare,1)
end
function check_xue()
   tmp.xueSkills={}
   tmp.xueCount=1
   tmp.xueTimes=0
   for p in pairs(skills) do
       if skills[p].lvl > 100 then
          table.insert(tmp.xueSkills,p)
       end
   end
   if hp.exp>500000 then
      return go(check_xue_ask,'������','����')
   else
      return check_xue_fail()
   end 
end
function check_xue_ask()
   DeleteTriggerGroup("ck_xue_ask")
   create_trigger_t('ck_xue_ask1','^(> )*����ѦĽ�������йء����ˡ�����Ϣ��$','','check_xue_accept')
   create_trigger_t('ck_xue_ask2','^(> )*����û�������','','check_xue_fail')
   SetTriggerOption("ck_xue_ask1","group","ck_xue_ask")
   SetTriggerOption("ck_xue_ask2","group","ck_xue_ask")
   DeleteTriggerGroup("ck_xue_accept")
   create_trigger_t('ck_xue_accept1','^(> )*ѦĽ�����ٺٺ١���Ц�˼�����$','','check_xue_teach')
   create_trigger_t('ck_xue_accept2','^(> )*һ����Ĺ����ȥ�ˣ�����������Ѿ�����Ȭ���ˡ�','','check_xue_heal')
   create_trigger_t('ck_xue_accept3','^(> )*Ѧ��ҽ�ó�һ�������������������˲�λ������Ѩ��','','check_xue_wait')
   create_trigger_t('ck_xue_accept4','^(> )*ѦĽ���ƺ����������˼��$','','check_xue_heal')
   create_trigger_t('ck_xue_accept5','^(> )*ѦĽ����ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����','','check_xue_fail')
   SetTriggerOption("ck_xue_accept1","group","ck_xue_accept")
   SetTriggerOption("ck_xue_accept2","group","ck_xue_accept")
   SetTriggerOption("ck_xue_accept3","group","ck_xue_accept")
   SetTriggerOption("ck_xue_accept4","group","ck_xue_accept")
   SetTriggerOption("ck_xue_accept5","group","ck_xue_accept")
   EnableTriggerGroup("ck_xue_accept",false)
   DeleteTriggerGroup("ck_xue_teach")
   create_trigger_t('ck_xue_teach1','^(> )*Ѧ��ҽ����������Ѿ������ٽ����ˡ�$','','check_xue_next')
   create_trigger_t('ck_xue_teach2','^(> )*����ѦĽ����ϸ�ؽ�˵��$','','check_xue_goon')
   create_trigger_t('ck_xue_teach3','^(> )*��� "action" �趨Ϊ "teach" �ɹ���ɡ�','','check_xue_fail')
   SetTriggerOption("ck_xue_teach1","group","ck_xue_teach")
   SetTriggerOption("ck_xue_teach2","group","ck_xue_teach")
   SetTriggerOption("ck_xue_teach3","group","ck_xue_teach")
   EnableTriggerGroup("ck_xue_teach",false)
   exe('ask xue muhua about ����')
end
function check_xue_fail()
   EnableTriggerGroup("ck_xue_ask",false)
   EnableTriggerGroup("ck_xue_accept",false)
   EnableTriggerGroup("ck_xue_teach",false)
   return check_jingxue()
end
function check_xue_accept()
   EnableTriggerGroup("ck_xue_ask",false)
   EnableTriggerGroup("ck_xue_accept",true)
end
function check_xue_wait()
   EnableTrigger("ck_xue_accept1",false)
   EnableTrigger("ck_xue_accept3",false)
   EnableTrigger("ck_xue_accept4",false)
end
function check_xue_teach()
   EnableTriggerGroup("ck_xue_accept",false)
   EnableTriggerGroup("ck_xue_teach",true)
   if tmpxueskill then
      exe('teach xue '.. tmpxueskill)
   else
      exe('teach xue '.. tmp.xueSkills[tmp.xueCount])
   end
   exe('alias action teach')
end
function check_xue_next()
   EnableTriggerGroup("ck_xue_teach",false)
   if tmpxueskill then
      tmpxueskill = nil
      tmp.xueCount = 0
   end
   tmp.xueCount = tmp.xueCount + 1
   if tmp.xueCount>table.getn(tmp.xueSkills) then
      if hp.exp>3000000 and hp.jingxue_per>70 and hp.qixue_per>70 then
         return wipe("xue muhua",check_jingxue)
      else
         return check_jingxue()
      end
   else
      return checkWait(check_xue_teach,0.2)
   end
end
function check_xue_goon()
   EnableTriggerGroup("ck_xue_teach",false)
   tmpxueskill = tmp.xueSkills[tmp.xueCount]
   tmp.xueTimes = tmp.xueTimes + 1
   if tmp.xueTimes>4 then
      return check_bei(check_xue_ask)
   else
      return checkWait(check_xue_teach,0.2)
   end
end
function check_xue_heal()
   EnableTriggerGroup("ck_xue_accept",false)
   DeleteTriggerGroup("ck_xue_ask")
   DeleteTriggerGroup("ck_xue_accept")
   DeleteTriggerGroup("ck_xue_teach")
   return check_bei(check_heal_over)
end

function check_food_error()

   do return end
   if flag.food==1 then
      create_timer_m('food',3,'check_food_status')
      return
   end
   exe('hp')
   
   wait.make(function() 
      wait.time(2)
      if hp.food<50 or hp.water<50 then
         flag.food=1
         dis_all()
	 check_food()
      end
   end)
end

function check_food_status()
   flag.food=0
end

function check_food(func)
   DeleteTriggerGroup("ck_xue_accept")
   
   tmp.food=func

   do return check_food_over() end
   
   if perform.force and skills[perform.force] then
	   exe('jifa force '.. perform.force)
   else
      for p in pairs(skills) do
         if skillEnable[p]=='force' then
            exe('enable force '..p)
	        break
         end
      end
   end

   if hp.food<50 or hp.water<50 then
      go(wudang_eat,'�䵱ɽ','��ͤ')
   else
      check_bei(check_food_over)
   end
end
function wudang_eat()
   flag.food=0
   DeleteTimer("food")
   exe('sit chair;knock table;get tao;#3(eat tao);get tea;#4(drink tea);drop wan;drop tao')
   check_bei(check_food_over)
end
function check_food_over()
   if tmp.food==nil then
      return check_gold()
   else
      return tmp.food()
   end
end

function check_pot(p_cmd)
    local l_pot=hp.pot_max - hp.pot_max/10
    local l_skill
    if perform.skill then
        l_skill=skillEnable[perform.skill]
    end
   
    job_exp_tongji()

    lingwuFlag()
	
	if flag.lingwu==1 then
	    spUser = spUser or {}
		if countTab(spUser)==0 then
	        spUser = dbUserReadId(score.id)
			if not spUser["group"] then spUser["group"]=0 end
		end
	    if spUser["group"] and spUser["group"] == 999 and (not condition["����æ״̬"] or condition["����æ״̬"]<100) then
		    flag.lingwu=0
	    end
	end

    if hp.pot>=l_pot and flag.autoxuexi and flag.autoxuexi==1 then
        if score.gold and skills["literate"] and score.gold>300+skills["literate"].lvl*3 and skills["literate"].lvl<score.int*10 and skills["literate"].lvl<hp.pot_max-100 then
            return literate() 
        end

	    if score.master~="��ͨ����" then
            for p in pairs(skills) do
                local q=qrySkillEnable(p)
	            if q and q['force'] and perform.force and p==perform.force and skills[p].lvl<hp.pot_max-100 then
	                if not (skills[p].mstlvl and skills[p].mstlvl<=skills[p].lvl) then
	                    return xuexi()
		            end
	            end
		    	if p==perform.skill and skills[p].lvl<hp.pot_max-100 then
	                if not (skills[p].mstlvl and skills[p].mstlvl<=skills[p].lvl) then
	                   return xuexi()
		            end
	            end
            end
	    end

	    if score.party=="��ͨ����" and skills["force"].lvl<hp.pot_max-100 and skills["force"].lvl>=100 and skills[perform.force] and skills["force"].lvl<200 and skills[perform.force].lvl>skills["force"].lvl then
            return emLingwuF()
        end 
	    
	    if flag.lingwu==1 and skills["force"] and skills["force"].lvl>200 then
            return lingwu()
        end
	  
	    if flag.lingwu==1 and score.party=="��ͨ����" then
            return lingwu()
        end
	  
    end
   
    if hp.pot>=l_pot then
	    if skills["wuxiang-zhi"] then
	        if not flag.wxjz then flag.wxjz=0 end
	 	    if flag.wxjz==0 and skills["finger"] and skills["finger"].lvl>skills["wuxiang-zhi"].lvl and skills["wuxiang-zhi"].lvl<hp.pot_max-100 then
	 	        return wxjzFofa()
	 	    end
	    end
	    
	    return potSave()
    end
	
	if hp.pot>100 and job.teamname and condition["����æ״̬"] and condition["����æ״̬"]>60 and skills["wuxing-zhen"] and skills["wuxing-zhen"].lvl<200 then
        tmp.wxz = true
    	return wuxingzhen()
	end
	
	if condition["����æ״̬"] and condition["����æ״̬"]>30 then
	    local p_func = busyFunc()
		if p_func and _G[p_func] then return _G[p_func]() end
	end
   
    return check_job()
   
end

function potSave()
   return go(potSaveact,"������","Ǳ������")
end
function potSaveact()
   exe("qn_cun ".. hp.pot)
   exe("qn_cha")
   return check_bei(check_job)
end

function checkMgmh()
    return go(checkMgGive,"������","Ӫ����")
end
function checkMgGive()
    if Bag["�ɹ��غ�"] then
	   exe('give '.. Bag["�ɹ��غ�"].fullid ..' to meng ge')
	end 
	Bag["�ɹ��غ�"] = nil
	return checkPrepare()
end
function checkXymh()
    return go(checkXyGive,"������","������")
end
function checkXyGive()
    if Bag["�����غ�"] then
	   exe('give '.. Bag["�����غ�"].fullid ..' to guo jing')
	end 
	Bag["�����غ�"] = nil
	return checkPrepare()
end
function checkHammer()
    return go(checkHmGive,"���ݳ�","������")
end
function checkHmGive()
    if Bag["Τ��֮��"] then
	   exe('give '.. Bag["Τ��֮��"].fullid ..' to zhujian shi')
	end
	Bag["Τ��֮��"] = nil
	return checkPrepare()
end

function check_gold()
    tmp.cnt=0
    if math.random(1,4)==1 then
        return go(check_gold_dali,"�����","����Ǯׯ")
    end
	if math.random(1,4)==2 then
        return go(check_gold_xy,"������","����ի")
    end
	if math.random(1,4)==3 then
        return go(check_gold_cd,"�ɶ���","ī��ի")
    end
	return go(check_gold_yz,"���ݳ�","���ի")
end
function check_gold_dali()
    if not locl.id["���ƹ�"] then
	   return go(check_gold_xy,"������","����ի")
	else
	   return check_gold_count()
	end
end
function check_gold_xy()
    if not locl.id["Ǯ����"] then
	   return go(check_gold_cd,"�ɶ���","ī��ի")
	else
	   return check_gold_count()
	end
end
function check_gold_cd()
    if not locl.id["���ƹ�"] then
	   return go(check_gold_yz,"���ݳ�","���ի")
	else
	   return check_gold_count()
	end
end
function check_gold_yz()
    if not locl.id["Ǯ��"] then
	   return go(check_gold_dali,"�����","����Ǯׯ")
	else
	   return check_gold_count()
	end
end
function check_gold_count()
   if Bag['ҼǪ����Ʊ'] and Bag['ҼǪ����Ʊ'].cnt>10 then  
      exe('score;chazhang')
      if score.goldlmt and score.gold and (score.goldlmt-score.gold)>50 then
         return check_cash_cun()
	  end
   end
   if Bag and Bag["����"] and Bag["����"].cnt and Bag["����"].cnt>500 then
      return check_silver_qu()
   end
   if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<count.gold_max and score.gold>count.gold_max) or (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>count.gold_max*4) then
      return check_gold_qu()
   end

   return check_gold_over()
end
function check_cash_cun()
   if Bag['ҼǪ����Ʊ'] then
      local l_cnt
      if score.goldlmt and score.gold and (score.goldlmt-score.gold)<Bag['ҼǪ����Ʊ'].cnt*10 then
	     l_cnt = math.modf((score.goldlmt-score.gold)/10) - 1
	  else
	     l_cnt = Bag['ҼǪ����Ʊ'].cnt
	  end
	  if l_cnt > 0 then
         exe('cun '.. l_cnt ..' cash')
	  end
   end
   checkBags()
   return checkWait(check_gold_check,3)
end
function check_silver_qu()
   local l_cnt=Bag["����"].cnt-100
   exe('cun '.. l_cnt ..' silver')
   exe('qu 50 silver')
   checkBags()
   return checkWait(check_gold_check,3)
end
function check_gold_qu()
   local l_cnt=Bag["�ƽ�"].cnt-count.gold_max*2
   exe('duihuan '.. l_cnt ..' gold to cash')
   exe('cun '.. l_cnt ..' gold')
   if Bag["�ƽ�"].cnt<count.gold_max then
      exe('qu '.. count.gold_max ..' gold')
      if score.gold and score.gold<5 then
	     exe('qu 2 gold')
	     exe('qu 1 gold')
      end
   end
   checkBags()
   return checkWait(check_gold_check,3)
end
function check_gold_check()
   tmp.cnt = tmp.cnt + 1
   if tmp.cnt > 30 then
      return check_heal()
   end
   return check_gold_count()
end
function check_gold_over()
   return checkPrepare()
end

function checkZqd()
   tmp.cnt=0
   return go(checkZqdBuy,randomElement(drugBuy["������"]))
end
function checkZqdBuy()
   tmp.cnt = tmp.cnt + 1
   if tmp.cnt > 30 then
      return checkZqdOver()
   else
      exe('buy zhengqi dan')
      checkBags()
      return check_bei(checkZqdi)
   end
end
function checkZqdi()
   if Bag["�ƽ�"] and Bag["�ƽ�"].cnt>4 and (not Bag["������"] or Bag["������"].cnt<4) then
      return checkWait(checkZqdBuy,1)
   else
      return checkZqdOver()
   end
end
function checkZqdOver()
   checkBags()
   return check_bei(checkPrepare,1)
end

function checkXqw()
   tmp.cnt=0
   return go(checkXqwBuy,randomElement(drugBuy["а����"]))
end
function checkXqwBuy()
   tmp.cnt = tmp.cnt + 1
   if tmp.cnt > 30 then
      return checkXqwOver()
   else
      exe('buy xieqi wan')
      checkBags()
      return check_bei(checkXqwi)
   end
end
function checkXqwi()
   if Bag["�ƽ�"] and Bag["�ƽ�"].cnt>4 and (not Bag["а����"] or Bag["а����"].cnt<4) then
      return checkWait(checkXqwBuy,1)
   else
      return checkXqwOver()
   end
end
function checkXqwOver()
   checkBags()
   return check_bei(checkPrepare,1)
end

function checkNxw()
   tmp.cnt=0
   local l_drug,l_cnt = isInBags(drug.neili)
   if score.gold and score.gold>100 and (not l_drug or l_cnt<count.nxw_max) then
      return go(checkNxwBuy,randomElement(drugBuy["������Ϣ��"]))
   else
      return checkNxwOver()
   end
end
function checkNxwBuy()
   tmp.cnt = tmp.cnt + 1
   if tmp.cnt > 30 then
      return checkNxwOver()
   else
      exe('buy '..drug.neili)
      checkBags()
      return check_bei(checkNxwi)
   end
end
function checkNxwi()
   local l_drug,l_cnt = isInBags(drug.neili)
   if (not l_drug or l_cnt<count.nxw_max*2) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt>4 then
      return checkWait(checkNxwBuy,1)
   else
      return checkNxwOver()
   end
end
function checkNxwOver()
   checkBags()
   return check_bei(checkPrepare,1)
end

function checkXionghuang()
   if not Bag["�ۻ�"] then
      return go(checkXionghuangBuy,randomElement(drugBuy["�ۻ�"]))
   else
      return checkXionghuangOver()
   end
end
function checkXionghuangBuy()
   exe('buy xiong huang')
   checkBags()
   return checkXionghuangOver()
end
function checkXionghuangOver()
   exe('drop xiong huang 2')
   return check_busy(checkPrepare,1)
end

function checkFire()
   if not Bag["����"] then
      return go(checkFireBuy,randomElement(drugBuy["����"]))
   else
      return checkFireOver()
   end
end
function checkFireBuy()
   exe('buy fire')
   checkBags()
   return checkFireOver()
end
function checkFireOver()
   exe('drop fire 2')
   return check_busy(checkPrepare,1)
end

function checkYu(p_yu)
    tmp.yu = p_yu
	return go(checkYuCun,"���ݳ�","�ӻ���")
end
function checkYuCun()
    exe('cun '.. Bag[tmp.yu].fullid)
	return check_bei(checkYuOver)
end
function checkYuOver()
    exe('cun yu;drop yu')
	checkBags()
    return check_busy(checkPrepare,1)
end

function checkSell(p_sell)
    tmp.sell = p_sell
	return go(checkSellDo,"���ݳ�","����")
end
function checkSellDo()
    if Bag[tmp.sell] then
       exe('sell '.. Bag[tmp.sell].fullid)
	end 
	return check_bei(checkSellOver)
end
function checkSellOver()
    if Bag[tmp.sell] then
       exe('sell '.. Bag[tmp.sell].fullid)
       exe('drop '.. Bag[tmp.sell].fullid)
	end
	checkBags()
    return check_busy(checkPrepare,1)
end

function checkWeapon(p_weapon)
   tmp.cnt = 0
   tmp.weapon = p_weapon
   return go(checkWeaponBuy,weaponStore[p_weapon],'')
end
function checkWeaponBuy()
   tmp.cnt = tmp.cnt + 1
   if tmp.cnt > 10 then
      checkBags()
      return check_heal()
   else
      if tmp.weapon and weaponStoreId[tmp.weapon] then
         exe('list;buy '.. weaponStoreId[tmp.weapon])
         checkBags()
         return checkWait(checkWeaponI,3)
	  else
	     return check_heal()
	  end
   end
end
function checkWeaponI()
    if not Bag[tmp.weapon] then
       return checkWeaponBuy()
    else
       return checkWeaponOver()
    end
end
function checkWeaponOver()
    return checkPrepare()
end

function checkDhd()
   return go(checkDhdBuy,"���ݳ�","����")
end
function checkDhdBuy()
   exe('duihuan dahuan dan')
   checkBags()
   return check_busy(checkDhdBag)
end
function checkDhdBag()
   if Bag["�󻹵�"] and Bag["�󻹵�"].cnt>1 then
      return checkDhdOver()
   end
   return checkWait(checkDhdBuy,3)
end
function checkDhdOver()
   return check_bei(checkPrepare)
end

function checkBingchan()
   return go(checkBingchanBuy,"���ݳ�","����")
end
function checkBingchanBuy()
   exe('duihuan bingchan')
   checkBags()
   return check_busy(checkBingchanBag)
end
function checkBingchanBag()
   if isInBags("�쾦���") then
      return checkBingchanOver()
   end
   return checkWait(checkBingchanBuy,3)
end
function checkBingchanOver()
   return check_bei(checkPrepare)
end

function checkPearl()
   return go(checkPearlBuy,"���ݳ�","����")
end
function checkPearlBuy()
   exe('duihuan pearl')
   checkBags()
   return check_busy(checkPearlBag)
end
function checkPearlBag()
   if isInBags("��������") then
      return checkPearlOver()
   end
   return checkWait(checkPearlBuy,3)
end
function checkPearlOver()
   return check_bei(checkPrepare)
end


function checkCodeError()
   return dis_all()
end

function checkRefresh()
   job.time["refresh"]=os.time()%900
end

function shujian_set()
   checkBags()
   exe('score;cha;hp')
   local l_result
   local l_tmp
   local t
   l_result=utils.inputbox ("���Ӣ��ID��?", "ID", GetVariable("id"), "����" , "12")
   if l_result~=nil then
      SetVariable("id",l_result)
   else
      DeleteVariable("id")
   end
   l_result=utils.inputbox ("���������?", "Passwd", GetVariable("passwd"), "����" , "12")
   if l_result~=nil then
      SetVariable("passwd",l_result)
   else
      DeleteVariable("passwd")
   end

   l_result=utils.msgbox ( "�Ƿ�򿪼�¼����?", "FlagLog", "yesno", "?", 1 )
   if l_result and l_result=="yes" then
      flag.log="yes"
   else
      flag.log="no"
   end
   SetVariable("flaglog",flag.log)
   
   l_result=utils.msgbox ( "�Ƿ��Զ�FULL����&����?", "FlagFull", "yesno", "?", 1 )
   if l_result and l_result=="yes" then
      SetVariable("flagfull","yes")
   else
      SetVariable("flagfull","no")
   end
   
   l_result=utils.msgbox ( "�Ƿ��Զ�ѧϰ������", "XuexiLingwu", "yesno", "?", 1 )
   if l_result and l_result=="yes" then
      flag.autoxuexi=1
   else
      flag.autoxuexi=0
   end
   SetVariable("flagautoxuexi",flag.autoxuexi)
   
   pfmSet()
	  
   weaponSet()

   jobSet()
   
   drugSet() 
   
   questSet()

   Save()
   
   ColourNote ("red","blue","��ʹ��start�������������ˣ�stop����ֹͣ�����ˣ�iset���û����ˣ�")
end

function pfmSet()
    local l_result,l_tmp,t
   
    t = {}
    for p in pairs(skills) do
        if skillEnable[p]=="force" then
	       t[p] = skills[p].name
	    end
    end
    if countTab(t)==1 then
        for p in pairs(t) do
	        perform.force = p
	    end
    elseif countTab(t)>1 then
        l_result=utils.listbox("��ʹ�õ������ڹ���","�����ڹ�",t,GetVariable("performforce"))
	    if isNil(l_result) then
	        perform.force = nil
	 	    DeleteVariable("performforce")
        else
	        perform.force = l_result
	 	    SetVariable("performforce",l_result)
        end	  
    else
        perform.force = nil
    end
   
    t = {}
    for p in pairs(skills) do
        if skillEnable[p] and skillEnable[p]~= "force" then
	       t[p] = skills[p].name
	    end
    end
    if countTab(t)>0 then
        l_result=utils.listbox ("��׼��ս��ʹ�õĹ�����?", "performSkill", t,GetVariable("performskill"))
        if not isNil(l_result) then
            SetVariable("performskill",l_result)
            perform.skill=l_result
        else
            perform.skill = nil
	        SetVariable("performskill",l_result)
        end
    end
   
    l_result=utils.inputbox ("��ս����ʼʱ��׼��PFM(��ʽ��yun jingang;bei none;bei claw;enable claw longzhua-gong;perform claw.lianhuan)��?", "PerformPre", GetVariable("performpre"), "����" , "12")
    if not isNil(l_result) then
        SetVariable("performpre",l_result)
        perform.pre=l_result
	    create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
        exe('pfmset')
    end 
end


function drugSet() 
   drugPrepare={}
   local t={
   ["������Ϣ��"] = "������Ϣ��",
   ["�󻹵�"] = "�󻹵�",
   ["�쾦���"] = "�쾦���",
   ["����"] = "����",
   ["��������"] = "��������",
   }
   if GetVariable("drugprepare") then
      tmp.drug = utils.split(GetVariable("drugprepare"),'|')
	  tmp.pre = {}
      for _,p in pairs(tmp.drug) do
          tmp.pre[p]=true
      end
    end
   local l_tmp=utils.multilistbox ("������ǰ׼������Ʒ(�밴CTRL��ѡ)��?", "��Ʒ���", t,tmp.pre)
   local l_result=nil
   for p in pairs(l_tmp) do
       drugPrepare[p]=true
       if l_result then
          l_result = l_result .. '|' .. p
       else
          l_result = p
       end
   end
   if isNil(l_result) then
      DeleteVariable("drugprepare")
   else
      SetVariable("drugprepare",l_result)
   end
    if not drugPrepare["��������"] then
	    ColourNote ('white','red','��Ҫ��ʾ��ҩƷ�б�û��ѡ���������飬����������Զ����ܣ�')
	end
end

function getVariable()
    if GetVariable("flagautoxuexi") then
        flag.autoxuexi=GetVariable("flagautoxuexi")
	    if flag.autoxuexi=='1' or flag.autoxuexi=='0' then
	        flag.autoxuexi=tonumber(flag.autoxuexi)
	    end
    end
    if GetVariable("flaglog") then
        flag.log=GetVariable("flaglog")
    end
    if GetVariable("flagtype") then
        flag.type=GetVariable("flagtype")
    end
    if GetVariable("performforce") then
        perform.force=GetVariable("performforce")
    end
    if GetVariable("performskill") then
        perform.skill=GetVariable("performskill")
    end
    if GetVariable("performpre") then
        perform.pre=GetVariable("performpre")
    end
    
    jobGetVar()
    
    drugGetVar()
    
    weaponGetVar()
    
    questGetVar()
end

function drugGetVar()
    drugPrepare={}
    if GetVariable("drugprepare") then
      tmp.drug = utils.split(GetVariable("drugprepare"),'|')
      for _,p in pairs(tmp.drug) do
          drugPrepare[p]=true
      end
    end
end

function setAlias()
    create_alias_s('stop','stop','disAll')
	create_alias_s('start','start','main')
	create_alias_s('qu_wd','qu_wd','goto_set.wd')
	create_alias_s('qu_sl','qu_sl','goto_set.sl')
	create_alias_s('qu_xy','qu_xy','goto_set.xy')
	create_alias_s('qu_xs','qu_xs','goto_set.xs')
	create_alias_s('qu_hs','qu_hs','goto_set.hs')
	create_alias_s('qu_yz','qu_yz','goto_set.yz')
	create_alias_s('qu_thd','qu_thd','goto_set.thd')
	create_alias_s('qu_dl','qu_dl','goto_set.dl')
	create_alias_s('tj','tj','jobExpTongji')
	create_alias_s('qtj','qtj','checkQuestTongji')
	create_alias_s('duanzao','duanzao','duanzao')
	create_alias_s('zhizao','zhizao','zhizao')
	
	create_alias('sz','^sz(.*)$','goto("%1")')
	SetAliasOption ('sz','send_to','12')
	create_alias('dushu','^dushu(.*)$','dushu("%1")')
	SetAliasOption ('dushu','send_to','12')
	create_alias('full','^full(.*)$','fullSkill("%1")')
	SetAliasOption ('full','send_to','12')
	--create_alias('xun','^xun(.*)$','xunZhao("%1")')
	--SetAliasOption ('xun','send_to','12')
	create_alias('loop','^loop(.*)$','dzfull("%1")')
	SetAliasOption ('loop','send_to','12')
	if GetAlias("xun") then DeleteAlias("xun") end
end

function isNil(p_str)
   if p_str==nil then
      return true
   end
   if type(p_str)~="string" then
      return false
   else
      p_str=Trim(p_str)
      if p_str=="" then
         return true
      else
         return false
      end		 
   end
end
function countR(p_number)
   local i = p_number or 10
   return function()
       i = i - 1
	   return i
   end
end

function randomElement(p_set)
   local l_element

   if p_set and type(p_set)=="table" then
      local l_cnt = math.random(1,countTab(p_set))
	  local l_i = 0
	  for p,q in pairs(p_set) do
	      l_element = q
	      l_i = l_i + 1
		  if l_i == l_cnt then
		     return l_element
		  end
	  end
   else
      l_element = p_set
   end
   
   return l_element
end