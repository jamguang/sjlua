weaponPrepare= {}
weaponUsave  = {}
itemWield    = {}


--������ʱ�ﵽ���������趪���Ķ���
itemDrop = {
["�����"]    = 1,
["�޻�����"]  = 1,
["�޻�"]      = 1,
["��ͭ"]      = 1,
["�ֵ�"]      = 1,
["ҩ��"]      = 1,
["������"]    = 2,
["ҹ����"]    = 2,
}

weaponStore={
["��"] = "city/yueqidian",
["ľ��"] = "xiangyang/mujiangpu",
["ľ��"] = "xiangyang/mujiangpu",
["����"] = "zhiye/bingqipu1",
["����"] = "zhiye/bingqipu1",
["��ǹ"] = "zhiye/bingqipu1",
--["�ֵ�"] = "zhiye/bingqipu1",
["���Ǵ�"] = "zhiye/bingqipu1",
["����"] = "zhiye/bingqipu1",
["����"] = "zhiye/bingqipu1",
["����"] = "zhiye/bingqipu1",
["����"] = "zhiye/bingqipu1",
["���"] = "zhiye/bingqipu1",
["�ָ�"] = "zhiye/bingqipu1",
["��ɱذ��"] = "zhiye/bingqipu1",
["���ѩ�轣"] = "xiangyang/bingqipu",
["��������"] = "xiangyang/bingqipu",
["�����"] = "xiangyang/bingqipu",
["����"] = "xiangyang/bingqipu",
["�ٱ�ذ��"] = "xiangyang/bingqipu",
["���ô�"] = "xiangyang/bingqipu",
["��ü��"] = "xiangyang/bingqipu",
["������"] = "xiangyang/bingqipu",
["�ش�����"] = "xiangyang/bingqipu",
["��ӧ������ǹ"] = "xiangyang/bingqipu",
["����"] = "xiangyang/bingqipu",
["ѩ�鵶"] = "xiangyang/bingqipu",
["�йٱ�"] = "xiangyang/bingqipu",
["���߽�"] = "xiangyang/bingqipu",
["������"] = "xiangyang/bingqipu",
["��������"] = "xiangyang/bingqipu",
["�����滨��"] = "xiangyang/bingqipu",
}

weaponStoreId={
["��"] = "xiao",
["ľ��"] = "mu jian",
["ľ��"] = "mu dao",
["����"] = "changjian",
["����"] = "tie bi",
["��ǹ"] = "chang qiang",
--["�ֵ�"] = "blade",
["���Ǵ�"] = "liuxing chui",
["����"] = "tiegun",
["����"] = "gangzhang",
["����"] = "changbian",
["����"] = "hook",
["���"] = "zhubang",
["�ָ�"] = "gang fu",
["��ɱذ��"] = "ansha bishou",
["���ѩ�轣"] = "snowsword",
["��������"] = "youlong bian",
["�����"] = "zhu bang",
["����"] = "yu xiao",
["�ٱ�ذ��"] = "bishou",
["���ô�"] = "kulou chui",
["��ü��"] = "tiegun",
["������"] = "dafu",
["�ش�����"] = "falun",
["��ӧ������ǹ"] = "hongying qiang",
["����"] = "hanyu gou",
["ѩ�鵶"] = "xue sui",
["�йٱ�"] = "panguan bi",
["���߽�"] = "yinshe sword",
["������"] = "tianshe zhang",
["��������"] = "tie ling",
["�����滨��"] = "zhen",
}

weaponFunc = {
   ["���ƹŽ�"] = "if score.master and score.master=='������' then return true else return false end",
   --["ľ��"] = "if score.party and score.party=='������' then return true else return false end",
}
weaponFuncName = {
   ["���ƹŽ�"] = "weaponGetSwj",
   --["ľ��"] = "weaponGetMudao",
}

weaponThrowing = {
["ͭǮ"]   = true,
["ʯ��"]   = true,
["˦��"]   = true,
["������"] = true,
["�����滨��"] = true,
["�ɻ�ʯ"] = true,
}

weaponKind = {
["blade"]   = "cut",
["sword"]   = "cut",
["stick"]   = true,
["club"]    = true,
["hammer"]  = true,
["whip"]    = true,
["axe"]     = "cut",
["staff"]   = true,
["hook"]    = "cut",
["brush"]   = true,
["dagger"]  = "cut",
["spear"]   = true,
["throwing"]= true,
["xiao"]    = "cut",
["arrow"]   = true,
["fork"]    = true,
}

unarmedKind = {
["cuff"]    = true,
["strike"]  = true,
["finger"]  = true,
["claw"]    = true,
["hand"]    = true,
["leg"]     = true,
}

function weaponSet()
    weaponPrepare={}
    local t = {}
	for p in pairs(weaponStore) do
	    t[p] = p
	end
	for p in pairs(Bag) do
	    if Bag[p].kind then
		   t[p] = p
		end
	end
	for p,q in pairs(weaponFunc) do
	    if loadstring(q)() then
		   t[p] = p
		end
	end
	if GetVariable("weaponprepare") then
      tmp.weapon = utils.split(GetVariable("weaponprepare"),'_')
	  tmp.pre = {}
      for _,p in pairs(tmp.weapon) do
          tmp.pre[p]=true
      end
    end
	local l_tmp=utils.multilistbox ("��׼��Ҫʹ�õ�������(�밴CTRL��ѡ)?", "����ѡ��", t,tmp.pre)
    local l_result=nil
	if type(l_tmp)=="table" then
       for p in pairs(l_tmp) do
           weaponPrepare[p]=true
           if l_result then
              l_result = l_result .. '_' .. p
           else
              l_result = p
          end
       end
	end
    if l_result then
      SetVariable("weaponprepare",l_result)
	else
	  DeleteVariable("weaponprepare")
    end
	
	for p in pairs(t) do
	    if not weaponPrepare[p] then
		   t[p] = nil
		end
	end
	
	if countTab(t)>1 then
	   l_result=utils.listbox("������ʹ�õ�������","��������",t,GetVariable("weaponfirst"))
       if l_result~=nil then
          SetVariable("weaponfirst",l_result)
          weapon.first=l_result
       else
	      weapon.first = nil
          DeleteVariable("weaponfirst")
       end
	end
end
function weaponGetVar()
    weaponPrepare={}
    if GetVariable("weaponprepare") then
      tmp.weapon = utils.split(GetVariable("weaponprepare"),'_')
      for _,p in pairs(tmp.weapon) do
          weaponPrepare[p]=true
      end
    end
	if GetVariable("weaponfirst") then
	   weapon.first = GetVariable("weaponfirst")
	else
	   weapon.first = nil
	end
end

weaponInBag=function(p_kind)
    for p in pairs(Bag) do
	    if Bag[p].kind and Bag[p].kind == p_kind then
		   return true
		end
	end
	return false
end

weaponInWield=function(p_kind)
    itemWield = itemWield or {}
	for p in pairs(itemWield) do
        if Bag[p] and Bag[p].kind and Bag[p].kind == p_kind then
		   return true
		end
    end
	return false
end

weaponIsWield=function()
    itemWield = itemWield or {}
	for p in pairs(itemWield) do
        if Bag[p] and Bag[p].kind then
		   return true
		end
    end
	return false
end

weapon_wield=function()
    if perform and perform.skill and skillEnable[perform.skill] and weaponKind[skillEnable[perform.skill]] then
        if weapon.first and Bag[weapon.first] and Bag[weapon.first].fullid then
	        exe('wield '.. Bag[weapon.first].fullid)
	    end
	    for p in pairs(Bag) do
	        if Bag[p].kind and Bag[p].kind==skillEnable[perform.skill] and perform.skill~="yuxiao-jian" then
		        if Bag[p].fullid and (not weapon.first or weapon.first~=p) then
		            exe('wield '.. Bag[p].fullid)
		 	    end
		    end
		    if Bag[p].kind and Bag[p].kind=="xiao" and perform.skill=="yuxiao-jian" then
		        if Bag[p].fullid and (not weapon.first or weapon.first~=p) then
		            exe('wield '.. Bag[p].fullid)
		 	    end
		    end
		    if Bag[p].fullid and (not weapon.first or weapon.first~=p) and weaponUsave and weaponUsave[p] and (not skills["duanzao"] or skills["duanzao"].lvl < 200) then
		        exe('unwield '.. Bag[p].fullid)
		    end
	    end
    end
	checkWield()
end
weaponWWalk=function()
    weapon_wield()
    return walk_wait()
end
weapon_unwield=function()
    for p in pairs(Bag) do
	    if Bag[p].fullid and Bag[p].kind and (not itemWield or itemWield[p]) then
		    local _,l_cnt = isInBags(Bag[p].fullid)
		    for i = 1,l_cnt do
		         exe('unwield '.. Bag[p].fullid ..' '..i)
		    end
		end
	end
	checkWield()
end
weaponUnWalk=function()
    weapon_unwield()
    return walk_wait()
end
weaponWieldCut=function()
    for p in pairs(Bag) do
	    if Bag[p].fullid and Bag[p].kind and weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind]=="cut" then
		    if not (Bag[p].kind == "xiao" and weaponUsave[p]) then
		        for q in pairs(Bag) do
		            if Bag[q].kind == "xiao" and weaponUsave[q] then
			            exe('unwield '.. Bag[q].fullid )
			        end
		        end
		        exe('wield '.. Bag[p].fullid )
		    end
		end
	end
	checkWield()
end
weaponUcheck=function()
    DeleteTriggerGroup("weapon")
    create_trigger_t('weapon1','^(> )*��� "action" �趨Ϊ "checkUweapon" �ɹ���ɡ�','','weaponUdone')
    create_trigger_t('weapon2','^(> )*����һ(��)��\\D*(��ͭ|����|����|��ʯ|����ʯ|����|����|����|��������|���꺮����)�Ƴɣ���\\D*��(\\D*)��$','','weaponUtmp')
    create_trigger_t('weapon3','^(> )*������(��Ҫ����|�Ѿ�ʹ�ù�һ��ʱ��|���Ͼ�Ҫ��)�ˡ�','','weaponUneed')
	create_trigger_t('weapon4','^(> )*������û��ʲô�𻵡�','','weaponUwell')
    SetTriggerOption("weapon1","group","weapon")
    SetTriggerOption("weapon2","group","weapon")
	SetTriggerOption("weapon3","group","weapon")
	SetTriggerOption("weapon4","group","weapon")
	
	weaponUcannt = weaponUcannt or {}
	tmp.uweapon = nil
    for p in pairs(weaponUsave) do
	    if Bag[p] and Bag[p].kind and Bag[p].fullid and weaponKind[Bag[p].kind] and not weaponUcannt[p] then
		   exe('l '..Bag[p].fullid)
		end
	end
	exe('alias action checkUweapon')
end
weaponUtmp=function(n,l,w)
    if weaponUsave[w[4]] and Bag[w[4]] then
	   tmp.uweapon = w[4]
	end
end
weaponUneed=function()
    if tmp.uweapon and weaponUsave[tmp.uweapon] then
	   weaponUsave[tmp.uweapon] = "repair"
	   tmp.uweapon = nil
	end
end
weaponUwell=function()
    if tmp.uweapon and weaponUsave[tmp.uweapon] then
	   weaponUsave[tmp.uweapon] = true
	   tmp.uweapon = nil
	end
end
weaponUdone=function()
    EnableTriggerGroup("weapon",false)
	for p in pairs(weaponUsave) do
	    if weaponUsave[p] and type(weaponUsave[p])=="string" and weaponUsave[p]=="repair" then
           return weaponRepair(p)
		end
	end
	return check_bei(weaponRepairOver)
end
weaponRepair=function(p_weapon)
    tmp.uweapon = p_weapon
    if not Bag["����"] then
	   cntr1 = countR(3)
	   return go(weaponRepairQu,"���ݳ�","�ӻ���")
	end
	return weaponRepairGo()
end
weaponRepairQu=function()
	exe('qu tiechui')
	checkBags()
	return check_bei(weaponRepairQuCheck,1)
end
weaponRepairQuCheck=function()
    if cntr1()> 0 and not Bag["����"] then
	   return weaponRepairQu()
	end
	if Bag["����"] then
	   return weaponRepairGo()
    else
	   return weaponRepairFind()
	end
end
weaponRepairFind=function()
    DeleteTriggerGroup("weaponFind")
    create_trigger_t('weaponFind1','^(> )*\\s*�ɿ�ʦ��\\(Caikuang shifu\\)','','weaponRepairFollow')
    create_trigger_t('weaponFind2','^(> )*����û�� caikuang shifu','','weaponRepairGoon')
    create_trigger_t('weaponFind3','^(> )*���������\\D*һ���ж���','','weaponRepairBuy')
    create_trigger_t('weaponFind4','^(> )*���Ѿ��������ˡ�','','weaponRepairBuy')
    SetTriggerOption("weaponFind1","group","weaponFind")
    SetTriggerOption("weaponFind2","group","weaponFind")
    SetTriggerOption("weaponFind3","group","weaponFind")
    SetTriggerOption("weaponFind4","group","weaponFind")
    EnableTriggerGroup("weaponFind",false)
	cntr1 = countR(20)
	return go(weaponRepairFact,"���ݳ�","������")
end
weaponRepairFact=function()
    EnableTriggerGroup("weaponFind",true)
	exe('look')
	return find()
end
weaponRepairFollow=function()
    flag.find = 1
	exe('follow caikuang shifu')
end
weaponRepairGoon=function()
    flag.wait=0
    flag.find=0
    return walk_wait()
end
weaponRepairBuy=function()
    EnableTriggerGroup("weaponFind",false)
	exe('buy tie chui')
	locate()
	checkBags()
	return checkWait(weaponRepairItem,0.5)
end
weaponRepairItem=function()
   if cntr1()>0 and not Bag["����"] then
      return weaponRepairBuy()
   end
   if not Bag["����"] then
      return weaponRepairOver()
   end
   return weaponRepairGo()
end
weaponRepairGo=function()
    return go(weaponRepairDo,"���ݳ�","������")
end
weaponRepairDo=function()
    DeleteTriggerGroup("repair")
    create_trigger_t('repair1','^(> )*�㿪ʼ��ϸ��ά��(\\D*)����ʱ���������ô��','','')
    create_trigger_t('repair2','^(> )*����ϸ��ά��(\\D*)��������»ָ�������ԭò��$','','weaponRepairOver')
    create_trigger_t('repair3','^(> )*����������������������$','','weaponRepairOver')
	create_trigger_t('repair4','^(> )*�����������������˽ⲻ�࣬�޷�����$','','weaponRepairCannt')
	create_trigger_t('repair5','^(> )*�������Ǯ�����ˣ�����Ҫ','','weaponRepairGold')
    SetTriggerOption("repair1","group","repair")
    SetTriggerOption("repair2","group","repair")
    SetTriggerOption("repair3","group","repair")
	SetTriggerOption("repair4","group","repair")
	SetTriggerOption("repair5","group","repair")
	wait.make(function() 
       wait.time(3)
       weapon_unwield()
	   wait.time(2)
       exe('wield tie chui')
	   wait.time(2)
	   exe('i')
	   exe('repair '..Bag[tmp.uweapon].fullid)
	   create_timer_m('repair',3,'weaponRepairOver')
	end)
end
function weaponRepairCannt()
    weaponUcannt = weaponUcannt or {}
	weaponUcannt[tmp.uweapon] = true 
	return weaponRepairOver()
end
function weaponRepairGold()
    EnableTriggerGroup("repair",false)
	EnableTimer("repair",false)
	exe('n;#3w;#3n;w;qu 25 gold;e;#3s;#3e;s')
	return checkWait(weaponRepairDo,2)
end
weaponRepairOver=function()
    EnableTriggerGroup("repair",false)
	EnableTimer("repair",false)
	cntr2 = countR(3)
	exe('unwield tie chui')
	return go(weaponRepairCun,"���ݳ�","�ӻ���")
end
weaponRepairCun=function()
    if not Bag["����"] then
	   return check_heal()
	end
    if cntr2()>0 and Bag["����"] then
	   weapon_unwield()
	   exe('cun tie chui')
	   checkBags()
	   return check_busy(weaponRepairCun,1)
	end
	return check_job()
end

weaponGetSwj=function()
    return go(swjAsk,"�䵱ɽ","��ɽСԺ")
end
function swjAsk()
    if locl.room~="��ɽСԺ" or not locl.id["������"] then
	   return weaponGetSwj()
	end
	exe('ask zhang sanfeng about ��ɽ')
	wait.make(function() 
       wait.time(3)
	   exe('ask zhang sanfeng about �̻�')
	   checkBags()
	   return check_bei(swjOver)
	end)
end
function swjOver()
    return checkPrepare()
end

weaponGetXiao = function()
    return go(dXiaoAsk,"�һ���","����ͤ")
end
function dXiaoAsk()
    exe('ask huang yaoshi about ����')
	return check_bei(byXiaoAsk,1)
end
function byXiaoAsk()
    exe('ask huang yaoshi about ������')
	return check_bei(byXiaoCheck,1)
end
function byXiaoCheck()
    exe('enter')
	locate()
	return byXiaoGet()
end
function byXiaoGet()
    if locl.id["������"] then
	   exe('get '.. locl.id["������"])
	end
	if locl.id["������"] then
	   exe('get '.. locl.id["������"])
	end
	checkBags()
	return check_bei(xiaoGetOver)
end
function xiaoGetOver()
    return checkPrepare()
end

weaponGetMudao = function()
    return go(mudaoAsk,"��ɽ����","������")
end
function mudaoAsk()
    if locl.id["ľ��"] then
	   exe('get mu dao')
	end
	if not locl.id["������ʦ"] then
	   return mudaoOver()
	end
	exe('ask daochen chanshi about ľ��')
	checkBags()
	return check_bei(mudaoCheck,1)
end
function mudaoCheck()
    local l_mudao,l_cnt = isInBags("ľ��")
	if l_mudao and l_cnt > 1 then
	   return mudaoOver()
	end
	exe('ask daochen chanshi about ľ��')
	checkBags()
	return check_bei(mudaoConsider,1)
end
function mudaoConsider()
    local l_mudao,l_cnt = isInBags("ľ��")
	if l_mudao and l_cnt > 1 then
	   return mudaoOver()
	end
	return wipe("daochen chanshi",mudaoOver)
end
function mudaoOver()
    return checkPrepare()
end







