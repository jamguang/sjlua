xuncheng={
[1]='wu;eu;wu;nu;n;s;sd;ed;sd;sw;su;nd;w;nw;sw;u;d;ne;se;sw;su',
[2]='nd;w;nw;sw;u;d;ne;se;sw;su;nd;ne;e;ne;ed;e',
[3]='n;w;e;n;w;e;n;w;e;n;w;buy huasheng;buy doufu;eat huasheng;#2(drink);eat doufu',
[4]='e;n;s;e;s;e;n;n;s;s;s;s;n;e;n;n;n;cun 2 gold;cun 50 silver;s;s;e;e',
[5]='s;s;e;e;w;w;n;n;s;e;n;s;e;w;s;e;w;s;e;w;n',
[6]='e;w;s;e;w;s;e;w;s;e;e;se;n;s;s;e;w;s;e;w;su;enter',
[7]='d;d;d;e;e;up;e;w;d;w;w;up;up;up;out;nd;n;n;nw',
[8]='ne;#6(eu);se;se;enter;n;n;n',
[9]='s;s;s;out;#4(nw);wd;wd;sw;w;w',
[10]='s;e;w;s;e;w;s;e;w;s;e;w;s;n;w;s;n;w;n;e;w;w',
[11]='e;n;s;s;s;s;su;e;w;se;w;w;e;e;s;su',
[12]='sw;ne;nd;n;su;n;s;s;n;nd;nw;nd;n;n;w',
[13]='s;n;w;s;n;w;e;n;w;e;n;w;e;n;w;e;n;w'
}

local i=0

function xunCheng()
    if hp.exp and hp.exp>149000 then
       return check_heal()
    else
       return go(xuncheng_start,'�����','����')
    end
end
function xuncheng_nobody()
    DeleteTemporaryTriggers()
end

function xuncheng_start()
    flag.idle = 0
    DeleteTemporaryTriggers()
    if hp.exp and hp.exp>150000 then
        return fullNeili()
    else
        i=0
        create_trigger_f('xuncheng_start1',"^>*\\s*�����쵤�������йء�Ѳ�ǡ�����Ϣ��",'','xuncheng_accept')
        create_trigger_f('xuncheng_start2',"^>*\\s*����û������ˡ�",'','xuncheng_nobody')
        Execute('ask zhu danchen about Ѳ��')
    end
end
function xuncheng_start_wait()
    DeleteTemporaryTriggers()
    wait.make(function() 
       wait.time(5)
       xuncheng_start()
    end)
end
function xuncheng_accept()
    DeleteTemporaryTriggers()
    create_triggerex_f('xuncheng_accept1',"^>*\\s*�쵤��˵������\\D*���㲻�Ǳ�������ӣ��˻��Ӻ�˵�𣿡�",'xuncheng_join()','')
    create_triggerex_f('xuncheng_accept2',"^>*\\s*�쵤��˵�������ðɣ�����ڴ������Χ�Ĵ��鿴һ��",'xuncheng_go()','')
    create_triggerex_f('xuncheng_accept3',"^>*\\s*�쵤��˵�������㲻���Ѿ�����Ѳ�ǵ�������",'xuncheng_go()','')
    create_triggerex_f('xuncheng_accept4',"^>*\\s*�쵤��˵������\\D*�����������",'xuncheng_start_wait()','')    
end
function xuncheng_join()
    DeleteTemporaryTriggers()
    wait.make(function()
       wait.time(3)
       Execute('e;#4s;#4e;#3n;e')
       Execute('s;ask fu sigui about join') 
       wait.time(2)
       check_busy(xuncheng_join_back)
    end)    
end
function xuncheng_join_back()
    Execute('n')
    Execute('w;#3s;#4w;#4n;w')
    xuncheng_start()
end

function xuncheng_go()
    DeleteTemporaryTriggers()
    if hp.neili_lim<=hp.neili_max then
       Execute('yun jingli')
    end
    if hp.jingxue>=hp.jingxue_max*0.5 then
       --Execute('#8(du book)')
    end
    Execute('hp')
    wait.make(function()
       wait.time(1)
       exe('yun jing;du book')	   
         if hp.jingli>100 then
            i=i+1
            xuncheng_step()
         else
            xuncheng_wait()
         end    
    end)
end
function xuncheng_step()
    Execute(xuncheng[i])
    if i<13 then
          --Execute('dazuo 30')
          wait.make(function()
             wait.time(1)
			 exe('yun jing;du book')
             check_busy(xuncheng_go)
          end)       
    else
       xuncheng_task()
    end   
end
function xuncheng_wait()
    wait.make(function()
       wait.time(1)
	   exe('yun jing;du book')
       --Execute('dazuo 10')
       check_busy(xuncheng_go)
    end)
end
function xuncheng_task()
    DeleteTemporaryTriggers()
    create_triggerex_f('xuncheng_task1',"^>*\\s*�쵤����������������ͷ��",'xuncheng_check()','')
    create_triggerex_f('xuncheng_task2',"^>*\\s*��ûѲ��������ʲô����",'xuncheng_start()','')
    create_triggerex_f('xuncheng_task3',"^>*\\s*�쵤���������ؿ����㡣",'xuncheng_task_wait()','')
    create_triggerex_f('xuncheng_task4',"^>*\\s*���ǲ���͵��",'xuncheng_start()','')
    Execute('task ok')
end
function xuncheng_task_wait()
    DeleteTemporaryTriggers()
    wait.make(function() 
       wait.time(3)
       Execute('e;dazuo 30')
       check_busy(xuncheng_task_goon)
    end)
end
function xuncheng_task_goon()
    Execute('w')
    xuncheng_task()
end
function xuncheng_check()
    DeleteTemporaryTriggers()
    Execute('cha;score;yun jingli;hp')
    check_bei(xuncheng_checkpot)
end
function xuncheng_checkpot()
    if hp.pot>100 then
       if hp.jingli>100 then
          return go(xunchengPot,"������","Ǳ������")
       else
          return checkWait(xuncheng_check,5)
       end
    else
       return xuncheng_start()   
    end
end

function xunchengPot()
    exe('qn_cun '.. hp.pot)
	exe("qn_cha")
    return xunCheng()
end

function dushu(p_book)
    disAll()
    create_triggerex('dushu1',"^(> )*(����������̫��|���ж���һ���|��Ļ�����û�д��|���ʵս���鲻��)",'','check_heal')
	create_triggerex('dushu2',"^(> )*(������������������ƿ��|�㾲������,���ƺ��ѵ���ƿ����|�Ȿ���������˵|Ҳ����ȱ��ʵս����|����ϸ�ض���һ��|���Ѿ��޷��ٴ��ؼ���ѧ��ʲô|������Ļ�����������|��о��Լ������廢���ŵ�|�㽫�����ؼ��ж�����)",'','check_heal')
    tmp.book=Trim(p_book)
    return check_bei(dushuStart)
	--return go(dushuStart,"����ɽ","���۵�")
end
function dushuStart()
    exe('yun jing;yun qi;cha;hp')
    --return check_bei(dushuDazuo)
	return check_bei(dushuAct)
end
function dushuDazuo()
    exe('yun jing;yun qi;dazuo '..hp.dazuo)
    return check_bei(dushuAct)
end
function dushuAct()
    flag.idle = 0
    exe('hp')
    return check_bei(dushuCheck)
end
function dushuCheck()
    local bookRead = {
	      ["medicine book"] = true,
		  ["bo juan"] = true,
		  ["miji"] = true,
		  ["jiuyin-baiguzhua"] = true,
		  ["cuixin-zhang"] = true,
		  ["yinlong-bian"] = true,
          ["jianfa"] = true,
          ["zhangfa"] = true,
	}
	local bookMian = {
	    ["lianxin shi"] = true,
	}
	
	if hp.neili < hp.neili_max*0.05 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   end
    end
	
	if hp.neili<hp.neili_max*0.5 and Bag["������Ϣ��"] then
       exe('eat '.. drug.neili)
    end
	
	if hp.neili < hp.neili_max*0.03 then
       return prepare_neili(dushuAct)
	end
	
	if tmp.busy and (not condition["����æ״̬"] or condition["����æ״̬"]<=20) then
	    return check_heal()
	end
	
    exe('yun jing')
    if bookRead[tmp.book] then
        exe('#5(read '..tmp.book..')')
    else
	    if bookMian[tmp.book] then
            exe('#5(mianbi '..tmp.book..')')
	    else
            --exe('#5(du '..tmp.book..')')
			exe('du '..tmp.book..' 100')
			exe('#5(du '..tmp.book..')')
	    end
    end
	condition = {}
    exe('cond')
    return check_busy(dushuAct,1)
end


function dzfull(p_book)
    disAll()
    create_triggerex('dushu1',"^(> )*(����������̫��|���ж���һ���|��Ļ�����û�д��|���ʵս���鲻��)",'','check_heal')
	create_triggerex('dushu2',"^(> )*(�㾲������,���ƺ��ѵ���ƿ����|�Ȿ���������˵|Ҳ����ȱ��ʵս����|����ϸ�ض���һ��|���Ѿ��޷��ٴ��ؼ���ѧ��ʲô|������Ļ�����������|��о��Լ������廢���ŵ�|�㽫�����ؼ��ж�����)",'','check_heal')
    tmp.book=Trim(p_book)
	tmp.df = 0
    return check_bei(dzfullStart)
end
function dzfullStart()
    exe('yun jing;yun qi;cha')
    --return check_bei(dzfullDazuo)
	return check_bei(dzfullAct)
end
function dzfullDazuo()
    exe('yun qi;dazuo '..hp.dazuo)
    return check_bei(dzfullAct)
end
function dzfullAct()
    flag.idle = 0
    exe('hp')
    return check_bei(dzfullCheck)
end
function dzfullCheck()
	
	if hp.neili < hp.neili_max*0.05 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   end
    end
	
	if hp.neili<hp.neili_max*0.5 and Bag["������Ϣ��"] then
       exe('eat '.. drug.neili)
    end
	
	if hp.neili < hp.neili_max*0.03 then
       return prepare_neili(dzfullAct)
	end
	
	tmp.neili = tmp.neili or 0
	tmp.df = tmp.df or 0
	if tmp.neili == hp.neili then
	   if tmp.df > 100 then
	      return check_heal()
	   else
	      tmp.df = tmp.df + 1
	   end
	else
	   tmp.df = 0
	end
	tmp.neili = hp.neili
	
    exe('yun jing;yun jingli')
 
        exe('#5('..tmp.book..')')
    
    return check_busy(dzfullAct)
end


function dushuf(p_book)
    tmp.book = Trim(p_book)
	exe('hp')
    return go(dushufCheck,'����ɽ','���۵�')
end
function dushufCheck()
    local bookRead = {
	      ["medicine book"] = true,
		  ["bo juan"] = true,
		  ["miji"] = true,
		  ["jiuyin-baiguzhua"] = true,
		  ["cuixin-zhang"] = true,
		  ["yinlong-bian"] = true,
          ["jianfa"] = true,
          ["zhangfa"] = true,
	}
	
	if hp.jingxue < 50 then
	   return dushufRest()
	end
    exe('yun jing;hp')
    if bookRead[tmp.book] then
        exe('#5(read '..tmp.book..')')
    else
        exe('#5(du '..tmp.book..')')
    end
	return checkWait(dushufCheck,1)
end
function dushufRest()
    flag.idle = 0
    exe('e;sleep')
	return checkWait(dushufCon,3)
end
function dushufCon()
    exe('w;hp')
	return check_busy(dushufCheck,1)
end

function fullNeili()
    exe('unset ����')
    exe('cha;hp')
    --if score.party and score.party=="ؤ��" then
    --    return go(fullNeiliStart,'���ݳ�','Ĺ��ͨ��')
    --end
    return go(fullNeiliStart,'����ɽ','���۵�')
end
function fullNeiliStart()
    exe('unset ����')
    exe('hp')
    return check_bei(fullNeiliCheck)
end
function fullNeiliCheck()
    flag.idle = 0
	
    if hp.neili_max>=hp.neili_lim then
	    if hp.jingli < 1000 then
	        return fulljingli()
	    else
            return check_heal()
	    end
    end

	tmp.neili_max = tmp.neili_max or hp.neili_max
	if tmp.busy and hp.neili_max>tmp.neili_max and (not condition["����æ״̬"] or condition["����æ״̬"]<=20) then
	    return check_heal()
	end
	if tmp.busy and hp.neili_max>tmp.neili_max and condition["����æ״̬"] and condition["����æ״̬"]>20 then
	    tmp.neili_max = hp.neili_max
	end
	
    if perform.force and skills[perform.force].lvl>99 and hp.qixue<hp.dazuo*2 then
        exe('yun qi;dazuo '..hp.dazuo)
	else
	    exe('dazuo '..hp.dazuo)
	end
       
	return fullNeiliCon()
end
function fullNeiliCon()
    condition = {}
    exe('hp;cond')
    return check_bei(fullNeiliCheck)
end

function fulljingli()
    exe('unset ����')
    exe('cha;hp')
    if score.party and score.party=="ؤ��" then
       go(fulljingliStart,'���ݳ�','Ĺ��ͨ��')
    else
       go(fulljingliStart,'����ɽ','���۵�')
    end
end
function fulljingliStart()
    exe('unset ����')
    exe('hp')
    check_bei(fulljingliCheck)
end
function fulljingliCheck()
    flag.idle = 0
	
    if hp.jingli_max>=hp.jingli_lim then
       return check_heal()
    end

    exe('yun jing;tuna '.. hp.jingxue_max/2)
       
	--if hp.neili<1000 then
	--    return checkWait(fulljingliCon,3)
	--else
	      return check_busy(fulljingliCon,1)
	--end
end
function fulljingliCon()
    exe('hp')
	if hp.neili<hp.neili_max/2 then
	   exe('yun jing;yun qi;dazuo '.. hp.dazuo)
	end
    return check_bei(fulljingliCheck)
end

function fullSkill(xskill)
    tmp.i = 0
	if xskill then
        tmp.xskill = Trim(xskill)
	else
	    tmp.xskill = nil
	end
	tmp.pskill=nil
	tmp.oskill=nil
	return washfullSkill()
    --return go(fullSkillStart,'����ɽ','���۵�')
end
function fullSkillStart()
    --if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
    --    lianxi(999,tmp.xskill)
	--	local l_lx = skillEnable[tmp.xskill] 
	--	if l_lx and type(l_lx) == "string" then
	--		exe('yun jingli')
    --        exe('lian '..l_lx)
	--		exe('yun jingli')
    --       exe('lian '..l_lx)
	--	end
	--	exe('eat dan')
	--    exe('cha;hp')
	--	checkBags()
	--	return checkWait(fullSkillCheck,2)
	--end
	checkBags()
    return prepare_neili(fullSkillCheck)
end
function fullSkillCheck()
    flag.idle = 0
    --messageShow(tmp.xskill)
    lianxi(5,tmp.xskill)
    if (tmp.pskill and not tmp.oskill) or (tmp.oskill and tmp.pskill and tmp.oskill~=tmp.pskill) then 
	    tmp.oskill=tmp.pskill
        tmp.skillpot=nil
        tmp.i = 0	   
	end
	if tmp.oskill and tmp.pskill and tmp.oskill==tmp.pskill and skills[tmp.pskill] then
	    if tmp.skillpot==nil then 
	        tmp.skillpot = skills[tmp.pskill].pot
        end
        if tmp.skillpot==skills[tmp.pskill].pot then
	        tmp.i = tmp.i + 1
		    if tmp.i>100 then
		        skills[tmp.pskill].fullever=true
		        return check_heal()
		    end
        end 		  
	end
    if flag.lianxi==1 then 
        if tmp.xskill and tmp.pskill then
            messageShow(tmp.xskill..' '..tmp.pskill)
        end
		--if tmp.xskill and tmp.pskill and tmp.xskill == tmp.pskill and skills[tmp.xskill].lvl<hp.pot_max-100 then
		if tmp.xskill and skills[tmp.xskill].lvl<hp.pot_max-100 then
		    messageShow("lingwu "..tmp.xskill)
            return lingwu()
        else
		    messageShow("return check_heal ")
	        return check_heal()
	    end
    end
	if hp.neili<hp.neili_max/2 then
	    return fullSkillStart()
	end
	if hp.neili==hp.neili_max*2 then
	    if not tmp.e then tmp.e = 0 end
	    tmp.e = tmp.e + 1
	    if tmp.e > 100 then
		    messageShow("tmp.e = 0 return check_heal ")
	        return check_heal()
		end
	else
	    tmp.e = 0
	end
	
    local l_cnt=math.modf(hp.neili_max/50)
    if l_cnt<1 then l_cnt=1 end
	exe('yun jingli;yun qi')
    lianxi(l_cnt,tmp.xskill)
	exe('cha;hp')
	
	if not tmp.f then tmp.f = 0 end
	tmp.f = tmp.f + 1
	if tmp.f > 1 then tmp.f = 0 end
	if tmp.f and tmp.f == 0 then
	    return check_bei(fullSkillCheck,1)
	else
	    return check_busy(fullSkillCheck,1)
	end
end

function washfullSkill()
    if hp.neili_max < 10000 then return go(fullSkillStart,'����ɽ','���۵�') end
    if score.gold and score.gold < 1000 then
		return go(fullSkillStart,'����ɽ','���۵�')
	end
	if Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>50 then
	    return go(washfullSkillLoc,"������","���")
	end
	if math.random(1,4)==1 then
        return go(washfullSkillGold,"�����","����Ǯׯ")
    end
	if math.random(1,4)==2 then
        return go(washfullSkillGold,"������","����ի")
    end
	if math.random(1,4)==3 then
        return go(washfullSkillGold,"�ɶ���","ī��ի")
    end
	return go(washfullSkillGold,"���ݳ�","���ի")
end
function washfullSkillGold()
    if not locl.id["���ƹ�"] and not locl.id["Ǯ����"] and not locl.id["���ƹ�"] and not locl.id["Ǯ��"] then
	    return fullSkill(tmp.xskill)
	end
	exe('qu 50 gold')
	checkBags()
	return check_bei(washfullSkillGoldWait,1)
end
function washfullSkillGoldWait()
    if not Bag["�ƽ�"] or (Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<50) then
	    locate()
	    return check_busy(washfullSkillGold,1)
	end
	exe("score")
	return go(washfullSkillLoc,"������","���")
end
function washfullSkillLoc()
    if locl.room ~= "���" then
	    return go(washfullSkillLoc,"������","���")
	end
	if not locl.id["СѾ��"] then
	    return go(washfullSkillLoc,"������","���")
	end
	return washfullSkillCheck()
end
function washfullSkillCheck()
    flag.idle = 0
    --messageShow(tmp.xskill)
    lianxi(5,tmp.xskill)
    if (tmp.pskill and not tmp.oskill) or (tmp.oskill and tmp.pskill and tmp.oskill~=tmp.pskill) then 
	    tmp.oskill=tmp.pskill
        tmp.skillpot=nil
        tmp.i = 0	   
	end
	if tmp.oskill and tmp.pskill and tmp.oskill==tmp.pskill and skills[tmp.pskill] then
	    if tmp.skillpot==nil then 
	        tmp.skillpot = skills[tmp.pskill].pot
        end
        if tmp.skillpot==skills[tmp.pskill].pot then
	        tmp.i = tmp.i + 1
		    if tmp.i>100 then
		        skills[tmp.pskill].fullever=true
		        return check_heal()
		    end
        end 		  
	end
    if flag.lianxi==1 then 
        if tmp.xskill and tmp.pskill then
            messageShow(tmp.xskill..' '..tmp.pskill)
        end
		if tmp.xskill and tmp.pskill and tmp.xskill == tmp.pskill and skills[tmp.xskill].lvl<hp.pot_max-100 then
		    exe("wear all")
            return lingwu()
        else
	        return check_heal()
	    end
    end
	if hp.neili<1000 then
	    return washfullSkillPay()
	end
	if hp.neili==hp.neili_max*2 then
	    if not tmp.e then tmp.e = 0 end
	    tmp.e = tmp.e + 1
	    if tmp.e > 100 then
	        return check_heal()
		end
	else
	    tmp.e = 0
	end
	
    local l_cnt=math.modf(hp.neili_max/50)
    if l_cnt<1 then l_cnt=1 end
	exe('yun jingli;yun qi')
    lianxi(l_cnt,tmp.xskill)
	exe('cha;hp')
	
	if not tmp.f then tmp.f = 0 end
	tmp.f = tmp.f + 1
	if tmp.f > 1 then tmp.f = 0 end
	if tmp.f and tmp.f == 0 then
	    return check_bei(washfullSkillCheck,1)
	end
	return checkWait(washfullSkillCheck,2)
end
function washfullSkillPay()
    if not Bag["�ƽ�"] or (Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<5) then
	    exe("wear all")
	    return fullSkill(tmp.xskill)
	end
	exe("give 1 gold to xiao yahuan")
	if score.gender == "Ů" then
	    exe('east')
	else
	    exe('west')
	end
	exe("remove all")
	weapon_unwield()
	exe("wash")
	locate()
	return check_bei(washfullSkillWash,1)
end
function washfullSkillWash()
    if locl.room ~= "����" and locl.room ~= "���" then
	    exe("wear all")
	    return fullSkill(tmp.xskill)
	end
	if locl.room == "����" then
	    exe('east')
	else
	    exe('west')
	end
	exe("hp;score")
	checkBags()
	return check_busy(washfullSkillCheck,1)
end

function fulldodge()
    exe('hp')
    return go(fulldodgeCheck,"��٢��ɽׯ","����")
end
function fulldodgeCheck()
    flag.idle = 0
	if skills["dodge"] and skills["dodge"].lvl > 100 then
	   return check_heal()
	end
    if hp.jingli < 130 then
	   return fulldodgeRest()
	end
	return fulldodgeYue()
end
function fulldodgeYue()
    exe('#3(yue tree)')
	exe('yun jingli;hp;cha')
	return checkWait(fulldodgeCheck,1)
end
function fulldodgeRest()
    return go(fulldodgeSleep,"��٢��ɽׯ","�᷿")
end
function fulldodgeSleep()
    exe('sleep')
	return check_bei(fulldodge)
end

function fullforce()
    exe('hp')
    return go(fullforceCheck,"��ɽ����","�󱯵�")
end
function fullforceCheck()
    flag.idle = 0
    if locl.room ~= "�󱯵�" then
	   return go(fullforceCheck,"��ɽ����","�󱯵�")
	end
    if not Bag["ϴ�辭"] then 
	   return fullforceMing()
	end
	exe('hp')
	return go(fullforceNei,"��ɽ����","���ֵ�")
end
function fullforceMing()
    exe('#3(mingxiang)')
	exe('get xisui jing')
	checkBags()
	return checkWait(fullforceCheck,1)
end
function fullforceNei()
    if skills["force"] and skills["force"].lvl>100 then
	   return check_heal()
	end
    if locl.room ~= "���ֵ�" then
	   return go(fullforceNei,"��ɽ����","���ֵ�")
	end
	if not Bag["ϴ�辭"] then 
	   go(fullforceCheck,"��ɽ����","�󱯵�")
	end
	if hp.jingxue < 100 then
	   return fullforceRest()
	end
	exe('#3(neishi)')
	checkBags()
	exe('yun jing;hp;cha')
	return checkWait(fullforceNei,1)
end
function fullforceRest()
    return go(fullforceSleep,"shaolin/sengshe3","")
end
function fullforceSleep()
    exe('sleep')
	return check_bei(fullforce,1)
end

function fullmrforce()
    exe('hp')
    return go(fullmrforceCheck,"������","Ĺ��")
end
function fullmrforceCheck()
    flag.idle = 0
    if locl.room ~= "Ĺ��" then
	   return go(fullmrforceCheck,"������","Ĺ��")
	end
    if not Bag["�ڹ��ķ�"] then 
	   return fullmrforceKetou()
	end
	exe('hp')
	return checkWait(fullmrforceNei,1)
end
function fullmrforceKetou()
    exe('#3(ketou)')
	exe('get force book')
	exe('w;e')
	checkBags()
	return checkWait(fullmrforceCheck,1)
end
function fullmrforceNei()
    if skills["force"] and skills["force"].lvl>99 then
	    return check_heal()
	end
    if locl.room ~= "Ĺ��" then
	   return go(fullmrforceNei,"������","Ĺ��")
	end
	if not Bag["�ڹ��ķ�"] then 
	   go(fullmrforceCheck,"������","Ĺ��")
	end
	if hp.jingxue < 100 then
	   return fullmrforceRest()
	end
	if skills["force"] and skills["force"].lvl>29 then
	    exe('#3(ketou)')
	else
	    exe('#3(du book)')
	end
	exe('w;e')
	checkBags()
	exe('yun jing;hp;cha')
	return checkWait(fullmrforceNei,1)
end
function fullmrforceRest()
    return go(fullmrforceSleep,"������","�᷿")
end
function fullmrforceSleep()
    exe('sleep')
	return check_bei(fullmrforce,1)
end

function fullparry()
    exe('hp')
    return go(fullparryCheck,"���ݳ�","����㳡")
end
function fullparryCheck()
    flag.idle = 0
	if skills["parry"] and skills["parry"].lvl>100 then
	    return check_heal()
	end
    if locl.room ~= "����㳡" then
	   return go(fullparryCheck,"���ݳ�","����㳡")
	end
	if hp.jingli < 100 then
	   return fullparryDazuo()
	end
	exe('#3(yao tree)')
	exe('yun jingli;hp;cha')
	return checkWait(fullparryCheck,1)
end
function fullparryDazuo() 
    if hp.qixue > 100 and hp.qixue > hp.dazuo then
	   exe('yun jingli;hp')
	   exe('dazuo '.. hp.qixue)
	   return check_bei(fullparryCheck,1)
    end	
	exe('hp')
	return checkWait(fullparryDazuo,5)
end

function fullstrike()
    exe('hp')
    return go(fullstrikeCheck,"���ݳ�","����㳡")
end
function fullstrikeCheck()
    flag.idle = 0
	if skills["strike"] and skills["strike"].lvl>100 then
	    return check_heal()
	end
    if locl.room ~= "����㳡" then
	   return go(fullstrikeCheck,"���ݳ�","����㳡")
	end
	if hp.jingli < 100 then
	   return fullstrikeDazuo()
	end
	exe('#3(pai tree)')
	exe('yun jingli;hp;cha')
	return checkWait(fullstrikeCheck,1)
end
function fullstrikeDazuo() 
    if hp.qixue > 100 and hp.qixue > hp.dazuo then
	   exe('yun jingli;hp')
	   exe('dazuo '.. hp.qixue)
	   return check_bei(fullstrikeCheck,1)
    end	
	exe('hp')
	return checkWait(fullstrikeDazuo,5)
end

function fullemstrike()
    exe('hp')
    return go(fullemstrikeCheck,"emei/shierpan3","")
end
function fullemstrikeCheck()
    flag.idle = 0
	if skills["strike"] and skills["strike"].lvl>30 then
	    return fullstrike()
	end
    if locl.room ~= "ʮ����" then
	   return go(fullemstrikeCheck,"emei/shierpan3","")
	end
	if hp.jingli < 100 then
	   return fullemstrikeDazuo()
	end
	exe('#3(clap)')
	exe('yun jingli;hp;cha')
	return checkWait(fullemstrikeCheck,1)
end
function fullemstrikeDazuo() 
    if hp.qixue > 100 and hp.qixue > hp.dazuo then
	   exe('yun jingli;hp')
	   exe('dazuo '.. hp.qixue)
	   return check_bei(fullemstrikeCheck,1)
    end	
	exe('hp')
	return checkWait(fullemstrikeDazuo,5)
end

function fullleg()
    exe('hp')
	return go(fulllegJump,'����ׯ','���䳡')
end
function fulllegJump()
    exe('jump zhuang;hp')
	return check_bei(fulllegCheck)
end
function fulllegCheck()
    if skills["leg"].lvl > 100 then
       return check_heal()
	end
	exe('yun jingli')
	if hp.jingli < 150 then
	   exe('hp;cha')
	   if hp.qixue > 100 and hp.qixue > hp.dazuo then
	      exe('dazuo '.. hp.qixue)
		  return checkWait(fulllegCheck,3)
	   else
	      return checkWait(fulllegCheck,5)
	   end
	end
	exe('#3(dun)')
	exe('hp;cha')
	checkWait(fulllegCheck,1)
end

function fullbskill(p_skill)
    tmp.skill = p_skill
	return go(fullbsDazuo,"����ɽ","���۵�")
end
function fullbsDazuo()
    if hp.qixue > 100 and hp.qixue > hp.dazuo then
	    exe('dazuo '.. hp.qixue)
	end
	return check_bei(fullbsLian,1)
end
function fullbsLian()
    local p = skillEnable[tmp.skill]
	if skills[tmp.skill].lvl >= skills[p].lvl then
	   return check_heal()
	end
	exe('enable '.. p ..' '.. tmp.skill)
	if unarmedKind[p] then
	   weapon_unwield()
	end
	if weaponKind[p] then
	   weapon_wield()
	end
	exe('yun jingli;lian '.. p)
	exe('hp;cha')
	return check_busy(fullbsCheck,1)
end
function fullbsCheck()
    if hp.neili > 200 then
	   return checkWait(fullbsLian,1)
	else
	   return fullbsRest()
	end
end
function fullbsRest()
    flag.idle = 0
    exe('e;sleep')
	return check_bei(fullbsCon,1)
end
function fullbsCon()
    exe('w;hp')
	return checkWait(fullbsDazuo,1)
end

function washFull(p_skill)
    flag.idle = 0
    tmp.skill = p_skill
	if score.gold and score.gold < 500 then
		return utils.msgbox("�ƽ����500����ûǮȥϴ�裡") 
	end
	if Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt>50 then
	    return go(washFullLoc,"������","���")
	end
	if math.random(1,4)==1 then
        return go(washFullGold,"�����","����Ǯׯ")
    end
	if math.random(1,4)==2 then
        return go(washFullGold,"������","����ի")
    end
	if math.random(1,4)==3 then
        return go(washFullGold,"�ɶ���","ī��ի")
    end
	return go(washFullGold,"���ݳ�","���ի")
end
function washFullGold()
    if not locl.id["���ƹ�"] and not locl.id["Ǯ����"] and not locl.id["���ƹ�"] and not locl.id["Ǯ��"] then
	    return washFull(tmp.skill)
	end
	exe('qu 50 gold')
	checkBags()
	return check_bei(washFullGoldWait,1)
end
function washFullGoldWait()
    if not Bag["�ƽ�"] or (Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<50) then
	    locate()
	    return check_busy(washFullGold,1)
	end
	exe("score")
	return go(washFullLoc,"������","���")
end
function washFullLoc()
    if locl.room ~= "���" then
	    return go(washFullLoc,"������","���")
	end
	if not locl.id["СѾ��"] then
	    return go(washFullLoc,"������","���")
	end
	return washFullLian()
end
function washFullLian()
    local p = skillEnable[tmp.skill]
	if skills[tmp.skill].lvl >= skills[p].lvl then
	    exe("wear all")
	    return check_heal()
	end
	exe('enable '.. p ..' '.. tmp.skill)
	if unarmedKind[p] then
	    weapon_unwield()
	end
	if weaponKind[p] then
	    --weapon_wield()
		for i = 1,3 do
		    exe("wield "..p.." "..i)
		end
	end
	exe('yun jingli;lian '.. p)
	exe('hp;cha')
	return check_busy(washFullLianCheck,1)
end
function washFullLianCheck()
    if hp.neili > 1000 then
	    return checkWait(washFullLian,1)
	else
	    checkBags()
	    return check_bei(washFullPay,1)
	end
end
function washFullPay()
    if not Bag["�ƽ�"] or (Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt<5) then
	    exe("wear all")
	    return washFull(tmp.skill)
	end
	exe("give 1 gold to xiao yahuan")
	if score.gender == "Ů" then
	    exe('east')
	else
	    exe('west')
	end
	exe("remove all")
	weapon_unwield()
	exe("wash")
	locate()
	return check_bei(washFullWash,1)
end
function washFullWash()
    if locl.room ~= "����" and locl.room ~= "���" then
	    exe("wear all")
	    return washFull(tmp.skill)
	end
	if locl.room == "����" then
	    exe('east')
	else
	    exe('west')
	end
	return check_busy(washFullLian)
end

function fangqiexp()
    exe('hp')
	return go(fangqiexpPre,'��������','��������')
end
function fangqiexpPre()
    if locl.room ~= '��������' or not locl.id["��˼��"] then
	   return go(fangqiexpPre,'��������','��������')
	end
    exe('ask fu sigui about join')
	return go(fangqiexpAsk,'�����','��վ')
end
function fangqiexpAsk()
    flag.idle = 0
	if hp.exp < 140000 then return check_heal() end
    if locl.room ~= '��վ' then
	   return go(fangqiexpAsk,'�����','��վ')
	end
	exe('ask zhu wanli about job')
	return check_bei(fangqiexpFangqi)
end
function fangqiexpFangqi()
    exe('ask zhu wanli about fangqi;hp')
	return check_busy(fangqiexpAsk)
end

function fulldzxy()
    return go(fulldzxyJump,"������","����̨")
end
function fulldzxyJump()
    exe('yun jing;yun jingli;jump zhuang;hp')
	return check_bei(fulldzxyLook)
end
function fulldzxyLook()
    DeleteTriggerGroup("lsky")
    create_trigger_t('lsky1',"^(> )*���������죬̫����������У����ƶ��",'','fulldzxyOver')
    create_trigger_t('lsky2',"^(> )*(����������һЩ��ʵս�����ö�ת���Ƶļ���|��ϧ��������æ���������|��ϧ����������ս����|��ϧ��̫����)",'','fulldzxyGoon')
	create_trigger_t('lsky3',"^(> )*���������죬���Ϸ��ǵ�㣬��˳�����ӵķ���ȥ��ȴ���ֲ��ֵ�ҹ�ձ���Χ�����ڵ�ס��",'','fulldzxyZhuang')
	create_trigger_t('lsky4','^(> )*���������죬���Ϸ��ǵ�㣬���������Ƕ����ƶ�������ѧ�ġ���ת���ơ���Ī�����ϵ��ȴ','','fulldzxyOver')
    SetTriggerOption("lsky1","group","lsky")
    SetTriggerOption("lsky2","group","lsky")
	SetTriggerOption("lsky3","group","lsky")
	SetTriggerOption("lsky4","group","lsky")
	return checkWait(fulldzxyCheck,1)
end
function fulldzxyCheck()
    EnableTriggerGroup("lsky",true)
	flag.idle = 0
	if skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl == hp.pot_max-100 then
	   return fulldzxyOver()
	end
	if hp.neili < 500 then 
	   if Bag["�󻹵�"] or Bag["�󻹵�(��)"] then
	      exe('eat dan')
	   end
    end
	
	if hp.neili<hp.neili_max*0.5 and Bag["������Ϣ��"] then
       exe('eat '.. drug.neili)
    end
	
	if hp.neili < 100 then
       return prepare_neili(fulldzxyCheck)
	end
	
	exe('#20(l sky)')
	exe('yun jing;hp')
end
function fulldzxyGoon()
    EnableTriggerGroup("lsky",false)
	return checkWait(fulldzxyCheck,0.5)
end
function fulldzxyZhuang()
    EnableTriggerGroup("lsky",false)
	return checkWait(fulldzxyJump,2)
end
function fulldzxyOver()
    EnableTriggerGroup("lsky",false)
	DeleteTriggerGroup("lsky")
	exe('jump down')
	return check_heal()
end

function vipMonthCard()
    return go(vipMonthWiz,"��������","�����")
end
function vipMonthWiz()
    if locl.room ~= "�����" then return vipMonthCard() end
	if not locl.id["��ʦ"] then return vipMonthCard() end
	exe("ask wizard about �¿����")
	exe("hp;score;time")
	return checkWait(vipMonthCheck,3)
end
function vipMonthCheck()
    if score.vip == "������" or (score.viptime and score.viptime<60) then
	    return vipMonthCard()
	end
	return check_heal()
end

function newbieLit()
    exe("hp;score")
	checkBags()
	return check_bei(newbieLitPre,1)
end
function newbieLitPre()
    if not Bag["�ƽ�"] or Bag["�ƽ�"].cnt < 5 then
	    if not score.gold or score.gold < 5 then
		    return check_heal()
		end
	    return newbieLitGold()
	end
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 5 then
	    if not score.gold or score.gold < 5 then
		    return check_heal()
		end
	    return newbieLitNxw()
	end
	return newbieLitGu()
end
function newbieLitGu()
    return go(newbieLitXue,'���ݳ�','��Ժ')
end
function newbieLitXue()
    if locl.room~= "��Ժ" then
	    return newbieLitGu()
	end
	if not locl.id["������"] then
	    return newbieLitGu()
	end
	if hp.pot < 10 then
	    return check_heal()
	end
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 2 then
	    return newbieLitPre()
	end
	if not Bag["�ƽ�"] or Bag["�ƽ�"].cnt < 2 then
	    return newbieLitPre()
	end
	exe("yun jing;xue gu literate")
	exe("hp;score")
	checkBags()
	return check_bei(newbieLitXue,1)
end
function newbieLitGold()
    return go(newbieLitGoldYz,"���ݳ�","���ի")
end
function newbieLitGoldYz()
    if not locl.id["Ǯ��"] then
	    return go(newbieLitGoldXy,"������","����ի")
	end
	exe("qu 5 gold")
	checkBags()
	return check_bei(newbieLitGoldCnt,1)
end
function newbieLitGoldXy()
    if not locl.id["Ǯ����"] then
	    return go(newbieLitGoldYz,"���ݳ�","���ի")
	end
	exe("qu 5 gold")
	checkBags()
	return check_bei(newbieLitGoldCnt,1)
end
function newbieLitGoldCnt()
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt >= 5 then
	    return newbieLitPre()
	end
	return newbieLitGold()
end
function newbieLitNxw()
    tmp.cnt = 0
    return go(newbieLitNxwBuy,randomElement(drugBuy["��Ϣ��"]))
end
function newbieLitNxwBuy()
    tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt < 30 then
        exe('buy neixi wan')
        checkBags()
        return check_bei(newbieLitNxwCnt)
    end
	return newbieLitPre()
end
function newbieLitNxwCnt()
    local l_drug,l_cnt = isInBags("��Ϣ��")
    if (not l_drug or l_cnt<5) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt>4 then
        return checkWait(newbieLitNxwBuy,1)
    end
    return newbieLitPre()
end

function newbieRead(p_book)
    tmp.book = p_book
    exe("hp;score")
	checkBags()
	return check_bei(newbieReadPre,1)
end
function newbieReadPre()
    if not Bag["�ƽ�"] or Bag["�ƽ�"].cnt < 5 then
	    if not score.gold or score.gold < 5 then
		    return check_heal()
		end
	    return newbieReadGold()
	end
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 5 then
	    if not score.gold or score.gold < 5 then
		    return check_heal()
		end
	    return newbieReadNxw()
	end
	return newbieReadGu()
end
function newbieReadGu()
    return go(newbieReadXue,'���ݳ�','��Ժ')
end
function newbieReadXue()
    if locl.room~= "��Ժ" then
	    return newbieReadGu()
	end
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 2 then
	    return newbieReadPre()
	end
	if not Bag["�ƽ�"] or Bag["�ƽ�"].cnt < 2 then
	    return newbieReadPre()
	end
	if skills["baduan-jin"] and skills["baduan-jin"].lvl == hp.pot_max-100 then
	    return check_heal()
	end
	exe("yun jing")
	exe("du "..tmp.book)
    exe("du "..tmp.book)
	exe("du "..tmp.book)
	exe("hp;score;cha")
	checkBags()
	return check_bei(newbieReadCheck,1)
end
function newbieReadCheck()
    if hp.neili < 100 then
	    exe("eat neixi wan")
    end
    return check_busy(newbieReadXue,1)
end
function newbieReadGold()
    return go(newbieReadGoldYz,"���ݳ�","���ի")
end
function newbieReadGoldYz()
    if not locl.id["Ǯ��"] then
	    return go(newbieReadGoldXy,"������","����ի")
	end
	exe("qu 5 gold")
	checkBags()
	return check_bei(newbieReadGoldCnt,1)
end
function newbieReadGoldXy()
    if not locl.id["Ǯ����"] then
	    return go(newbieReadGoldYz,"���ݳ�","���ի")
	end
	exe("qu 5 gold")
	checkBags()
	return check_bei(newbieReadGoldCnt,1)
end
function newbieReadGoldCnt()
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt >= 5 then
	    return newbieReadPre()
	end
	return newbieReadGold()
end
function newbieReadNxw()
    tmp.cnt = 0
    return go(newbieReadNxwBuy,randomElement(drugBuy["��Ϣ��"]))
end
function newbieReadNxwBuy()
    tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt < 30 then
        exe('buy neixi wan')
        checkBags()
        return check_bei(newbieReadNxwCnt)
    end
	return newbieReadPre()
end
function newbieReadNxwCnt()
    local l_drug,l_cnt = isInBags("��Ϣ��")
    if (not l_drug or l_cnt<5) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt>4 then
        return checkWait(newbieReadNxwBuy,1)
    end
    return newbieReadPre()
end

function newbieCuff()
    exe("hp;score")
	checkBags()
	return check_bei(newbieCuffPre,1)
end
function newbieCuffPre()
    if not skills["buddhism"] or skills["buddhism"].lvl < 30 then
	    return check_heal()
	end
	if not Bag["����Ӣ����"] then
	    return check_heal()
	end
    if not Bag["�ƽ�"] or Bag["�ƽ�"].cnt < 10 then
	    if not score.gold or score.gold < 10 then
		    return check_heal()
		end
	    return newbieCuffGold()
	end
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 15 then
	    if not score.gold or score.gold < 10 then
		    return check_heal()
		end
	    return newbieCuffNxw()
	end
	return newbieCuffGu()
end
function newbieCuffGu()
    return go(newbieCuffSay,'��ɽ����','ʥɮ��')
end
function newbieCuffSay()
    if locl.room~= "ʥɮ��" then
	    return newbieCuffGu()
	end
    exe("say ���մ�ϲ����ȴΣ����")
	exe("sheshen")
	return newbieCuffXue()
end
function newbieCuffXue()
	if not Bag["��Ϣ��"] or Bag["��Ϣ��"].cnt < 2 then
	    return newbieCuffPre()
	end
	exe("yun jing")
	exe("du lingan")
	exe("du lingan")
	exe("du lingan")
	exe("hp;score")
	checkBags()
	return check_bei(newbieCuffCheck,1)
end
function newbieCuffCheck()
    if hp.neili < 150 then
	    exe("eat neixi wan")
    end
    return newbieCuffXue()
end
function newbieCuffGold()
    return go(newbieCuffGoldYz,"���ݳ�","���ի")
end
function newbieCuffGoldYz()
    if not locl.id["Ǯ��"] then
	    return go(newbieCuffGoldXy,"������","����ի")
	end
	exe("qu 10 gold")
	checkBags()
	return check_bei(newbieCuffGoldCnt,1)
end
function newbieCuffGoldXy()
    if not locl.id["Ǯ����"] then
	    return go(newbieCuffGoldYz,"���ݳ�","���ի")
	end
	exe("qu 10 gold")
	checkBags()
	return check_bei(newbieCuffGoldCnt,1)
end
function newbieCuffGoldCnt()
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt >= 10 then
	    return newbieCuffPre()
	end
	return newbieCuffGold()
end
function newbieCuffNxw()
    tmp.cnt = 0
    return go(newbieCuffNxwBuy,randomElement(drugBuy["��Ϣ��"]))
end
function newbieCuffNxwBuy()
    tmp.cnt = tmp.cnt or 0
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt < 30 then
        exe('buy neixi wan')
        checkBags()
        return check_bei(newbieCuffNxwCnt)
    end
	return newbieCuffPre()
end
function newbieCuffNxwCnt()
    local l_drug,l_cnt = isInBags("��Ϣ��")
    if (not l_drug or l_cnt<15) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt>1 then
        return checkWait(newbieCuffNxwBuy,1)
    end
    return newbieCuffPre()
end

function fullbaduanjin()
    if not Bag["�˶ν��ڹ��ؼ�"] then
	    return go(fullbaduanjinAsk,"���ݳ�","������")
	end
	if score.gold and score.gold > 100 then
	    return newbieRead("book")
	else
	    return dushu("book")
	end
end
function fullbaduanjinAsk()
    if locl.room~= "������" then
        return go(fullbaduanjinAsk,"���ݳ�","������")
	end
	exe("ask zhujian shi about �˶ν�")
	checkBags()
	return check_bei(fullbaduanjin,1)
end

function shihuiGet()
    tmp.shihui = 0
    return go(shihuiBudai,"���ݳ�","�����ξ�")
end
function shihuiBudai()
    if locl.room~= "�����ξ�" then
	    return shihuiGet()
	end
    if not Bag["����"] then
	    exe("na ����")
		exe("na ����")
		exe("na ����")
		checkBags()
		return check_bei(shihuiBudai,1)
	end
	return check_bei(shihuiZhua,1)
end
function shihuiZhua()
    tmp.shihui = tmp.shihui or 0
	tmp.shihui = tmp.shihui + 1
    exe("zhua ʯ��")
	exe("zhua ʯ��")
	exe("zhua ʯ��")
	exe("get shi hui from bu dai")
	checkBags()
	locate()
	return checkWait(shihuiCheck,3)
end
function shihuiCheck()
    if Bag["��ʯ��"] then
	    return go(shihuiCun,"���ݳ�","�ӻ���")
	end
	if tmp.shihui > 100 then
	    return shihuiOver()
	end
	return check_busy(shihuiZhua,1)
end
function shihuiCun()
    if locl.room ~= "�ӻ���" then
	    return go(shihuiCun,"���ݳ�","�ӻ���")
	end
	exe("cun shihui")
	checkBags()
	return check_busy(shihuiCheck,1)
end
function shihuiOver()
    return check_heal()
end

function szjsGo()
    return go(szjsDachang,"Ѫ����","Ұɽ��")
end
function szjsDachang()
    if locl.id["������"] then
	    exe("get niaoyu dachang")
		return go(szjsLu,"xuedao/beilu")
	end
end
function szjsLu()
    if locl.room ~= "��ѩɽ��´" then
	    return go(szjsLu,"xuedao/beilu")
	end
	if locl.id["½����"] then
	    exe("ask lu tianshu about ����")
	    return go(szjsHua,"xuedao/shanlu6")
	end
end
function szjsHua()
    if locl.room ~= "ɽ·" then
	    return go(szjsHua,"xuedao/shanlu6")
	end
	if locl.id["������"] then
	    exe("ask hua tiegan about ����")
	    return go(szjsLiu,"xuedao/shanlu3")
	end
end
function szjsLiu()
    if locl.room ~= "ɽ·" then
	    return go(szjsLiu,"xuedao/shanlu3")
	end
	if locl.id["���з�"] then
	    exe("ask liu chengfeng about ����")
	    return go(szjsShui,"xuedao/beilu")
	end
end
function szjsShui()
    if locl.room ~= "��ѩɽ��´" then
	    return go(szjsShui,"xuedao/beilu")
	end
	if locl.id["ˮ�"] then
	    exe("ask shui dai about ����")
	    return go(szjsXiong,"xuedao/shanlu7")
	end
end
function szjsXiong()
    if locl.room ~= "ɽ·" then
	    return go(szjsXiong,"xuedao/shanlu7")
	end
	if locl.id["��Х��"] then
	    exe("ask wang xiaofeng about ����")
	    wait.make(function()
		    wait.time(3)
			exe("ask wang xiaofeng about ʦ��")
			wait.time(3)
			exe("ask wang xiaofeng about ����")
			wait.time(3)
			exe("s")
			locate()
			return check_bei(szjsMei,1)
		end)
	end
end
function szjsMei()
    if not locl.id["ˮ��"] then
	    exe("n;s")
	    locate()
		return checkWait(szjsMei,5)
	end
	wait.make(function()
		exe("ask ".. locl.id["ˮ��"] .." about ����")
		wait.time(3)
		exe("ask ".. locl.id["ˮ��"] .." about Ѫ������")
		wait.time(3)
		exe("ask ".. locl.id["ˮ��"] .." about ������")
		wait.time(3)
		exe("give dachang to "..locl.id["ˮ��"])
		wait.time(3)
		return go(szjsTrigger,"��ѩɽ","��ʯ")
	end)
end
function szjsTrigger()
    DeleteTriggerGroup("szjt")
    create_trigger_t('szjt1','ˮ�ϻŻ����ŵ����˽���','','szjsbaohu')
    create_trigger_t('szjt2','���е��⽣Ӱ�������ݺᣬ�㿴ˮ��','','szjsbaohu')
    create_trigger_t('szjt3','Ѫ������ɫ���Եض�ˮ��Ц��','','szjsbaohu')
    create_trigger_t('szjt4','����һ������Ѫ������','','szjsqiang')
	create_trigger_t('szjt5','һ����������ũ���������ӽ��붴�к�Ѫ�����涷������','','szjsqiang')
	create_trigger_t('szjt6','^(> )*(\\D*)��ž����һ�����ڵ���','','szjsDie')
    SetTriggerOption("szjt1","group","szjt") 
    SetTriggerOption("szjt2","group","szjt")
    SetTriggerOption("szjt3","group","szjt")
    SetTriggerOption("szjt4","group","szjt")
	SetTriggerOption("szjt5","group","szjt")
	SetTriggerOption("szjt6","group","szjt")
	tmp.killed = {}
end
function szjsDie(n,l,w)
    tmp.killed = tmp.killed or {}
	tmp.killed[w[2]] = true
	if tmp.killed["ˮ�"] and tmp.killed["���з�"] and tmp.killed["������"] and tmp.killed["½����"] then
	    exe("unset wimpy")
	    exe("yield yes")
		return check_bei(szjsPre,1)
	end
	
end
function szjsbaohu()
    exe("baohu ˮ��")
end
function szjsqiang()
    exe("qiang ��")
end
function szjsPre()
    DeleteTriggerGroup("szjt")
    create_trigger_t('szjt1','Ѫ������ɫ���Եض�ˮ��Ц��','','szjsLaozu')
	create_trigger_t('szjt2','һ����������ũ���������ӽ��붴�к�Ѫ�����涷������','','szjsDy')
    SetTriggerOption("szjt1","group","szjt") 
    SetTriggerOption("szjt2","group","szjt")
	weapon_unwield()
	exe("bei none;enable finger wuxiang-zhi;enable parry wuxiang-zhi;bei finger")
	create_timer_s('szjs',1,'szjstimer')
end
function szjstimer()
    if score.id=="panix" then
	    exe("yield no")
		exe("perform finger.qiankun di yun")
		exe("perform finger.qiankun laozu")
		exe("yield yes")
	else
	    exe("yield no")
		exe("perform finger.qiankun laozu")
		exe("perform finger.qiankun di yun")
		exe("yield yes")
	end
end
function szjsLaozu()
    exe("yield no")
    exe("perform finger.qiankun laozu")
    exe("perform finger.qiankun di yun")
    exe("yield yes")
end
function szjsDy()
    exe("yield no")
	exe("perform finger.qiankun di yun")
    exe("perform finger.qiankun laozu")
    exe("yield yes")
end








