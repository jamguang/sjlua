xsWhereIgnores ={
    ["�䵱ɽ��ɽСԺ"] = true,
	["��������ɽ��"] = true,
    ["�䵱ɽԺ��"] = true,
    ["��������"] = true,
	["���������"] = true,
	["ȫ����ҩ����"] = true,
	["���ݳ�ɽ·"] = true,
	["�置ɽ·"] = true,
	["���ݳ��������ƹ�"] = true,	
	["���ݳ���������¥"] = true,
	["��Դ��ɽ��"] = true,
	["��Դ�ذ���"] = true,
	["��Դ��ɽ��"] = true,
	["��Դ��ɽ��"]= true,
	["��Դ��ʯ��"] = true,
	["��Դ��ʯ����ͷ"] = true,
	["��Դ�غ���"] = true,
	["��Դ��Сʯ��"] = true,
	["��Դ����Ժ���"] = true,
	["��Դ�����᷿"] = true,
	["��Դ�ض��᷿"] = true,
	["��Դ����Ժ��Ժ"] = true,
	["��Դ��ի��"] = true,
	["��Դ��������"] = true,
	["��Դ����ʯС��"] = true,
	["��Դ������"] = true,
	["��Դ��ʯ������"] = true,
	["��Դ��ʯ���᷿"] = true,
    ["����������"] = true,
    ["��������"] = true,
    ["���̵�����"] = true,
    ["����������"] = true,
	["���̷�����"] = true,
	["��ɽ����ʯ��·"] = true, -- ain

}
local Yiliaddr2 ={
	["����ǿ�ջ"] = true,
	["����ǿ�ջ��¥"] = true,
	["���������"] = true,
	["���������"] = true,
	["����ǳ�����"] = true,
	["����ǰ�����Ժ"] = true,
}
--fuxing
jobSpecial = jobSpecial or {}
job.list = job.list or {}
job.list["fuxing"] = "���¸���"
joblast = joblast or {}
joblast["���¸���"] = "fuxing"
jobCond = jobCond or {}
jobCond["fuxing"] = function() if hp.shen<-5000 and (not condition["���¸���"] or (condition["���¸���"] and condition["���¸���"]<=0) or (condition["����æ״̬"] and condition["���¸���"] and condition["���¸���"]<=condition["����æ״̬"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["fuxing"] = "fuxingTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["fuxing"] = "fuxingFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["fuxing"] = "fuxingFindFail"
faintFunc = faintFunc or {}
faintFunc["fuxing"] = "fuxingFaint"
--���˿���ȥʦ�и�󡹦���ˣ��ó�ʹ�������ȷ��˵У�
--���˿���ȥʦ�����ư�ó�ʹ�����츫�˵У�
--��۳����ɨ����һ�۵��������ˣ���Ȼ������������м������ʵѧ�����ô�ү��������������ɣ���
fuxingIgnoresskill = {
    ["̫��ȭ"] = true,
    ["��а����"] = true,
 --   ["̫������"]   = true,
   ["�򹷰���"] = true,
	--   ["���｣��"] = true,
 --    ["��������"] = true,
	 --��������
	-- ["Ľ�ݵ���"] = true,
--	  ["��Ȼ������"] = true,
   ["Ѫ������"]=true,
   ["�������"] = true,
 --   ["�����潣"] = true,
--	["һ��ָ"]=true,
--	["��ɽ����"]=true,
--	  ["���⵶��"] = true,
	  ["���¾Ž�"]=true,
	  ["��������"]=true,
--	  ["��Ů���Ľ�"]=true,
	  ["Τ����"]=true,
--	  ["���е���"]=true,
	--  ["���޵�"]=true,
	--  ["�ط������"]=true,
	--  ["�Ⱥ���"]=true,
	--  ["���߱޷�"]=true,
	--  ["�������ν�"]=true,
	 ["��ս�����"]=true,
	--  ["ȫ�潣��"]=true,
	  ["����ȭ��"]=true,
	  ["�����ȷ�"]=true,
	  
	  
}
function fuxingTrigger()
    EnableTriggerGroup("fuxingAsk",false)
    EnableTriggerGroup("fuxingAccept",false)
    
    DeleteTriggerGroup("fuxingAsk") 
    create_trigger_t('fuxingAsk1',"^(> )*��������������й�",'','fuxingAsk')
    create_trigger_t('fuxingAsk2',"^(> )*����û������ˡ�$",'','fuxingNobody')
    SetTriggerOption("fuxingAsk1","group","fuxingAsk")
    SetTriggerOption("fuxingAsk2","group","fuxingAsk")
    EnableTriggerGroup("fuxingAsk",false)
    DeleteTriggerGroup("fuxingAccept")
    --�����ʬ��(Corpse)
   --���������˵������û�������񣬺�������ʲô�� 
    create_trigger_t('fuxingAccept1',"^(> )*����������Ķ�������˵���������ţ��е��ӻر�(\\D*)(����|����|����|����|����|����|����)(\\D*)�������ڶ������ܣ���ô����",'','fuxingNpc')
    create_trigger_t('fuxingAccept11',"^(> )*����������Ķ�������˵�������ˣ�(\\D*)(����|����|����|����|����|����|����)(\\D*)���ҽ��鲻��������������ȳ��ν���֮�¼�ֱ���練��",'','fuxingNpc')
    create_trigger_t('fuxingAccept2',"^(> )*���������˵����(�ٺ٣�����|��ʹ�����ȥ)(\\D*)(һ������ȥ����ɱ��|������)",'','fuxingConsider')
    create_trigger_t('fuxingAccept3',"^(> )*����\\D*˵��\\D*��������ȥ",'','fuxingFangqi')
    create_trigger_t('fuxingAccept4',"^(> )*����\\D*˵��\\D*����æ����",'','fuxingFail')
    create_trigger_t('fuxingAccept5',"^(> )*����\\D*˵��\\D*��հ���ң�������Ϣһ�°ɡ�",'','fuxingFail')
    create_trigger_t('fuxingAccept6',"^(> )*����\\D*˵��\\D*��û��������,��������ʲô?",'','fuxingFail')
    create_trigger_t('fuxingAccept7',"^(> )*����\\D*˵��\\D*�ţ�����������˼�����ɴ�ƣ������š�",'','fuxingFail')
    create_trigger_t('fuxingAccept8',"^(> )*����\\D*˵��\\D*������͵��ˣ������ʱ���ܾȳ��ν���������",'','fuxingFail')
    create_trigger_t('fuxingAccept9',"^(> )*����\\D*˵��\\D*�ţ�������æ�������š�",'','fuxingFail')
    create_trigger_t('fuxingAccept10',"^(> )*��\\D*˵��\\D*����û����������������ɡ���",'','fuxingFail')
 --   create_trigger_t('fuxingAccept12',"^(> )*���������˵����������͵��ˣ������ʱ���ܾȳ��ν���������",'','fuxingcancle')
    create_trigger_t('fuxingAccept13',"^(> )*���������˵�������ϴε����¸�������û�аɡ�",'','fuxingFail')
    EnableTriggerGroup("fuxingAccept",false)
    SetTriggerOption("fuxingAccept1","group","fuxingAccept")
    SetTriggerOption("fuxingAccept2","group","fuxingAccept")
    SetTriggerOption("fuxingAccept3","group","fuxingAccept")
    SetTriggerOption("fuxingAccept4","group","fuxingAccept")
    SetTriggerOption("fuxingAccept5","group","fuxingAccept")
    SetTriggerOption("fuxingAccept6","group","fuxingAccept")
    SetTriggerOption("fuxingAccept7","group","fuxingAccept")
    SetTriggerOption("fuxingAccept8","group","fuxingAccept")
    SetTriggerOption("fuxingAccept9","group","fuxingAccept")
    SetTriggerOption("fuxingAccept10","group","fuxingAccept")
    SetTriggerOption("fuxingAccept11","group","fuxingAccept")
--    SetTriggerOption("fuxingAccept12","group","fuxingAccept")
    SetTriggerOption("fuxingAccept13","group","fuxingAccept")
    EnableTriggerGroup("fuxingAccept",false)
    
    EnableTriggerGroup("fuxingFight",false)
    DeleteTriggerGroup("fuxingFight")
    create_trigger_t('fuxingFight1','^(> )*(\\D*)��ž����һ�����ڵ���','','fuxingDie')
    create_trigger_t('fuxingFight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','fuxingNFaint')
    create_trigger_t('fuxingFight3',"^(> )*����û��(\\D*)��",'','fuxingLost')
    create_trigger_t('fuxingFight4',"^(> )*(����û�������Ү|��������Ķ���������)",'','fuxingFind')
    create_trigger_t('fuxingFight5',"^(> )*(��˫��һ����Ц��|��ʤ�����У����Ծ������|�������Ц��˵���������ˣ�|û����|����æ���أ���Ъ������|�����ڴ���أ��Ȼ����˵��|�����ڼ��������˼���|��Ҫ�ȵ����ѹ�����˵|�㾫��������Ϣһ�°�)",'','fuxingQingNext')
    create_trigger_t('fuxingFight6',"^(> )*(������������Ҫ�������˰�|������������Ҫ����˭��)",'','fuxingFangqiGo')
    create_trigger_t('fuxingFight7',"^(> )*(\\D*)�Ѿ����������룬�㲻���ٷѾ�����",'','fuxingBackCheck')
    create_trigger_t('fuxingFight10',"^(> )*(\\D*)����һЦ����\\D*�Ĺ����Ȼ������������ʹ����������ȥ�������͵�",'','fuxingFollow')
    create_trigger_tc('fuxingFight11',"^(> )*��(һ���Ĺ���|����\\D*����һ��|���Ц�ݣ���|��\\D*�Ϲ���)",'','fuxingadd')
    create_trigger_tc('fuxingFight8',"^(> )*(\\D*)(����������һ���ж���|����һ�����Ѿ���ʧ������)",'','fuxingFollow')
    --create_trigger_t('fuxingFight9',"^(> )*(\\D*)(���һ��|������˼�����˵��|�����ɨ��|�ٺ�һ����|��ɫ�԰ף�ֻ����|ת��ͷ�����������¿���|��ɫ΢�䣬˵������������|һ�����ͷ��ı���)",'','fuxingQingCheck')
    create_trigger_tc('fuxingFight12',"^(> )*���˿���ȥʦ��(\\D*)���ó�ʹ��(\\D*)�˵У�",'','fuxingescap')
	
    create_trigger_t('fuxingFight13',"^(> )*(\\D*)'ɨ����һ�۵�����\\D*����Ȼ������������м������ʵѧ������\\D*��������������ɣ���",'','fxfightpfm')  -- ain
    create_trigger_t('fuxingFight14',"^һ��ů�����Ե�������ȫ�����������ָֻ���֪������",'','faint_check')
	create_trigger_t('fuxingFight15',"^(> )*(\\D*)˵������������������ԩ�������޳𣡡�",'','fuxingFind')
    SetTriggerOption("fuxingFight1","group","fuxingFight")
    SetTriggerOption("fuxingFight2","group","fuxingFight")
    SetTriggerOption("fuxingFight3","group","fuxingFight")
    SetTriggerOption("fuxingFight4","group","fuxingFight")
    SetTriggerOption("fuxingFight5","group","fuxingFight")
    SetTriggerOption("fuxingFight6","group","fuxingFight")
    SetTriggerOption("fuxingFight7","group","fuxingFight")
    SetTriggerOption("fuxingFight8","group","fuxingFight")
   -- SetTriggerOption("fuxingFight9","group","fuxingFight")
    SetTriggerOption("fuxingFight10","group","fuxingFight")
    SetTriggerOption("fuxingFight11","group","fuxingFight")
    SetTriggerOption("fuxingFight12","group","fuxingFight")
    SetTriggerOption("fuxingFight13","group","fuxingFight")  -- ain
    SetTriggerOption("fuxingFight14","group","fuxingFight")
	SetTriggerOption("fuxingFight15","group","fuxingFight")
    EnableTriggerGroup("fuxingFight",false)

    EnableTriggerGroup("fuxingCut",false)   
    DeleteTriggerGroup("fuxingCut")
    create_trigger_t('fuxingCut1','^(> )*ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն���������������С�','','fuxingCutCon')
    create_trigger_t('fuxingCut2','^(> )*(����ü����������߲���������ʬ���ͷ����|��������������޷����У������������ʬ���ͷ����)','','fuxingCutWeapon')
    create_trigger_tc('fuxingCut3',"^(> )*(\\D*)��ʬ��\\(Corpse\\)",'','fuxingDie')  -- ain
    create_trigger_t('fuxingCut4','^(> )*�㽫(\\D*)��ʬ������������ڱ��ϡ�','','fuxing_get_con') -- ain
    create_trigger_t('fuxingCut5','^(> )*(\\D*)��ʬ��������̫����\\)','','fuxingCutWeapon') -- ain
        
    SetTriggerOption("fuxingCut1","group","fuxingCut") 
    SetTriggerOption("fuxingCut2","group","fuxingCut")
    SetTriggerOption("fuxingCut3","group","fuxingCut")
    SetTriggerOption("fuxingCut4","group","fuxingCut")
    SetTriggerOption("fuxingCut5","group","fuxingCut")
    EnableTriggerGroup("fuxingCut",false)
    
    --���޾��ʬ��(Corpse)
    EnableTriggerGroup("fuxingGive",false)
    DeleteTriggerGroup("fuxingGive")
    create_trigger_t('fuxingGive1','^(> )*���������һ��(\\D*)���׼���','','fuxingFinish')
    SetTriggerOption("fuxingGive1","group","fuxingGive")
    EnableTriggerGroup("fuxingGive",false)
    DeleteTriggerGroup("fuxingHead")
    create_trigger_t('fuxingHead1','^(> )*����һ��(\\D*)��(�׼�|��ͷ)','','fuxingHeadCheck')
    create_trigger_t('fuxingHead2','^(> )*��� "action" �趨Ϊ "check_head" �ɹ���ɡ�','','fuxingHeadCon')
    create_trigger_t('fuxingHead3','^(> )*(\\D*)�ĵ�ʬ��\\(Corpse\\)','','fuxingHeadCheck')
    SetTriggerOption("fuxingHead1","group","fuxingHead")
    SetTriggerOption("fuxingHead2","group","fuxingHead")
    SetTriggerOption("fuxingHead3","group","fuxingHead")
  
    EnableTriggerGroup("fuxingHead",false)
    DeleteTriggerGroup("fuxingFinish")
    create_trigger_t('fuxingFinish1','^(> )*������˵������(\\D*)�������Ҿȳ��ν����ֶ���һ�ݰ���','','fuxingFinishCheck')
    SetTriggerOption("fuxingFinish1","group","fuxingFinish") 
    EnableTriggerGroup("fuxingFinish",false)
	
	EnableTriggerGroup("xxdfquest",false)
    DeleteTriggerGroup("xxdfquest")
	create_trigger_t('xxdfquest1','^(> )*������˵������'.. score.name ..'����˵����÷ׯ��λׯ��ϲ�������黭��������Ͷ��������ȥ����������һ����Ե��','','xxdfQuest')
	create_trigger_t('xxdfquest2','^(> )*���������˵������'.. score.name ..'����˵����÷ׯ��λׯ��ϲ�������黭��������Ͷ��������ȥ����������һ����Ե��','','xxdfQuest')
	
    SetTriggerOption("xxdfquest1","group","xxdfquest")
	SetTriggerOption("xxdfquest2","group","xxdfquest")
	EnableTriggerGroup("xxdfquest",true)
end
function xxdfQuest()

  exe('nick $HIR$xxdf')
  SetVariable("timexxdf",os.date())


end
function fuxingTriggerDel()
    EnableTriggerGroup("fuxingAsk",false)
    EnableTriggerGroup("fuxingAccept",false)
    EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingFind",false)
    EnableTriggerGroup("fuxingCut",false)
    EnableTriggerGroup("fuxingGive",false)
    EnableTriggerGroup("fuxingHead",false)
    EnableTriggerGroup("fuxingFinish",false)

    DeleteTriggerGroup("fuxingAsk")
    DeleteTriggerGroup("fuxingAccept")
    DeleteTriggerGroup("fuxingFight")
    DeleteTriggerGroup("fuxingFind")
    DeleteTriggerGroup("fuxingCut")
    DeleteTriggerGroup("fuxingGive")
    DeleteTriggerGroup("fuxingHead")
    DeleteTriggerGroup("fuxingFinish")
end
function fuxingNobody()
    EnableTriggerGroup("fuxingAsk",false)
    fuxing()
end
function fuxing()
    if hp.shen>=0 then
	   return turnShen('-')
	end
    jobTriggerDel() -- ain
    fuxingTrigger()
    job.name='fuxing'
    job.time.b=os.time()
    job.time.sf=os.time()
    job.progress=0 -- ain add
	flag.idle=0
	Qingok=0
    if GetVariable("performpreB") then
       perform.pre=GetVariable("performpreB")
    
       create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
       exe('pfmset')
       exe('set wimpy 100;yield no;time')
       exe('set wimpycmd pfmpfm\\hp')
    end  	
    return prepare_lianxi(fuxingGo)
end
function fuxingGo()
    go(fuxingStart,'��ľ��','��ͤ')
end
function fuxingStart()
   return check_busy(fuxingStart_chbusy)
end
function fuxingStart_chbusy()
    job.fuxing=0  -- ain
	  create_timer_s('fxasktimer',5,'fuxing')
    EnableTriggerGroup("fuxingAsk",true)
    exe('time;askk xiang wentian about job')
end
function fuxingAsk()
  DeleteTimer("fxasktimer")
   EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingAsk",false)
    EnableTriggerGroup("fuxingAccept",true)
end
function fuxingBusy()
   DeleteTimer("fxasktimer")
    EnableTriggerGroup("fuxingAccept",false)
    	job.last='fuxing'
    check_bei(fuxingBusyDazuo)
end
function fuxingBusyDazuo()
   DeleteTimer("fxasktimer")
    prepare_lianxi(fuxingStart)
end
function fuxingFail()
    EnableTriggerGroup("fuxingAccept",false)
	if not skills["xixing-dafa"] and score.party=='�������' then
		return check_heal()
	else
		job.last='fuxing'
		return checkJob()
	end
end
function fuxingNpc(n,l,w)
    job.id="test1"
    DeleteTimer("fxasktimer")
    job.party=Trim(w[2])
    job.target=Trim(w[4])
	  job.id=get_id(job.target)
	  print("�Զ���ȡNPC id��"..job.id)	
    job.killer={}
    job.killer[job.target]=true   
end

function fuxingConsider(n,l,w)
    DeleteTimer("fxasktimer")
    job.last='fuxing'
    job.fuxing=0
    EnableTriggerGroup("fuxingAccept",false)
    if string.find(w[4],"��") then
       job.type="qing"
       -- ain
        -- ain add log2  
         if GetVariable("pfmfuxingjob") then
     		  perform.pre=GetVariable("pfmfuxingjob")
     		  create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
     		  exe('pfmset')
     		 end 
     		  exe('set wimpy 100;yield no')
     		  
     		          exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
     	
  
    else 
         if GetVariable("performpreB") then
     		 
     		  perform.pre=string.gsub(GetVariable("performpreB"), "@id", job.id)
     		  create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
     		  exe('pfmset')
     		 end 
     		  exe('set wimpy 100;yield no')
     		
     		          exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
     	
       job.type="kill"
    end
    job.where=Trim(w[3])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    --dest.area,dest.room = locateroom(job.where)   
    --if dest.area then
	dest.room=job.room
    dest.area=job.area	
    if dest.room and dest.area and path_cal() then
       pathconfirm=1
    else
       pathconfirm=0
       messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
      -- ainlogline2("��ַ�Ҳ���",16)
       return fuxingFangqi()
    end
    if xsWhereIgnores[job.where] or not job.room then
       messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return fuxingFangqi()
    end
	if Yiliaddr2[job.where] and MidNight[locl.time] then
	  
       messageShow('�������񣺵���ȥ '..Yiliaddr2[job.where]..'ʱ�� '..MidNight[locl.time]..' ʱ�䲻�������������')
       return fuxingFangqi()
    end
	
	if score.party=='����Ľ��' then
		if WhereIgnoresXS[job.where] or AddrIgnoresMRXS[dest.area]  then
		   messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return fuxingFangqi()
		end
	else
		if WhereIgnoresXS[job.where] or AddrIgnoresXS[dest.area]  then
		   messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
       return fuxingFangqi()
		end
	
	end
    if job.type and job.type=="qing" then
       messageShow('�������񣺿�ʼǰ����'..job.where..'���롾'..job.target..'����')
    else
       messageShow('�������񣺿�ʼǰ����'..job.where..'��ɱ��'..job.target..'����')
    end
    EnableTrigger("fuxingFind1",true)
	flag.idle=0
    check_bei(fuxingFind)
end
function fuxingFangqiGo()
   EnableTriggerGroup("fuxingFind",false)
   DeleteTimer("fxasktimer")
       DeleteTimer("fuxing")
    DeleteTimer("perform")
    EnableTriggerGroup("fuxingFight",false)
    locate()
    flag.idle=4
    go(fuxingFangqi,'��ľ��','��ͤ')
end
function fuxingFangqi()
    EnableTriggerGroup("fuxingAsk",true)
    check_bei(fuxingFangqiAsk)
end
function fuxingFangqiAsk()
    EnableTriggerGroup("fuxingAccept",false)
    job.progress=0 -- ain add
    exe('hp;cond;askk xiang wentian about cancel;hp')
end
function fuxingFind()
    EnableTriggerGroup("fuxingFind",false)
    DeleteTriggerGroup("fuxingFind")
    create_trigger_tc('fuxingFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','fuxingTarget1')
    create_trigger_tc('fuxingFind2','^(> )*\\D*�����㷢��һ����Ц��˵��','','fuxingTarget2')
    create_trigger_tc('fuxingFind3','^(> )*\\D*'..job.target..'��\\D*���˹�����','','fuxingTarget2')
    SetTriggerOption("fuxingFind1","group","fuxingFind")
    SetTriggerOption("fuxingFind2","group","fuxingFind")
    SetTriggerOption("fuxingFind3","group","fuxingFind")
    EnableTriggerGroup("fuxingFind",true)  -- ain ��true
    flag.times=1
    fight_prepare()
	--fightReady()
      --road.wait=road.wait2
      --road.steps=road.steps2
    return go(fuxingFindAct,job.area,job.room)    
end
function fuxingFindAgain()
    EnableTriggerGroup("fuxingFind",false)
    return go(fuxingFindAct,job.area,job.room)
end
function fuxingFindFail()
    EnableTriggerGroup("fuxingFind",false)
    --road.wait=road.wait1
    --road.steps=road.steps1
    return fuxingFangqiGo()
end
function fuxingFaint()
   if job.type and job.type=="qing" and job.progress==11 then  -- ain add
   		  exe('yun jing;yun qi')
	      return check_bei(fuxingQing)
	 elseif job.type and job.type~="qing" and job.progress==11 then  -- ain add   
	      check_bei(fuxingFind)
	 elseif job.type and job.type=="qing" and job.progress==2 then  -- ain add   
	      return fuxingBack()
	 elseif job.progress==3 then  -- ain add 
	      return fuxingBack() 
   else
    	flag.idle=4  -- ain
    	EnableTriggerGroup("fuxingFind",false)
    	--road.wait=road.wait1
        --road.steps=road.steps1
    	return fuxingFangqiGo()  
    --	return main()
   end 
end
function fuxingFindAct()
   if job.fuxing==0 then
    		EnableTriggerGroup("fuxingFind",true)
    		job.flag()
				weapon_wield()
    		exe('look;askk '..job.id..' about name')
    		find()
    		messageShow('�������񣺿�ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
   elseif job.fuxing==1 then
   			--ain_print("��������Ŀ��NPC:"..job.target)
   elseif job.fuxing==2 then
         fuxingCut()   -- ain 
       -- ain_print("�Ѹ㶨Ŀ��NPC:"..job.target)
   end 		
end
function fuxingTarget1(n,l,w)
    EnableTriggerGroup("fuxingFind",false)
    EnableTriggerGroup("fuxingFight",true)
    EnableTrigger("fuxingFind",true)  -- ain add 20170317
    job.progress=1 --add
    flag.wait=0
    flag.find=1
	flag.idle=0
    thread_resume(lookfor)
    fxjobid=string.lower(w[2])
	if fxjobid~=job.id then job.id=fxjobid end
      job.killer[job.target]=job.id
      messageShow('���������ҵ���'.. job.target ..'����')
		  exe('set wimpy 100')
      exe('halt;follow '..job.id)
    if job.type and job.type=="qing" then
       job.time.sf=os.time()
   	   if GetVariable("pfmfuxingjob") then
     		  perform.pre=GetVariable("pfmfuxingjob")
     		  create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
     		  exe('pfmset')
     		  exe('set wimpy 100;yield no')
     		  exe('set wimpycmd pfmpfm\\hp;set wimpy 100') 
   		 end  
	     Qingtimes=1
	     --check_nofight(fuxingQingNext)
		 fuxingQingNext()
    else
	--	messageShow('�������񣺿�ʼ�롾'.. job.target ..'��ս����')
     --  check_busy(killfuxing,1)
		exe('l '..job.id)
    end
end
function killfuxing()
	exe('l '..job.id)
    exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
	exe('kill '..job.id)
end
function fuxingTarget2(n,l,w)
    job.progress=1 --add
    job.fuxing=1
    job.time.sf=os.time()  -- ain
    EnableTriggerGroup("fuxingFind",false)
    EnableTriggerGroup("fuxingFight",true)
    EnableTrigger("fuxingFind",true)  -- ain add 20170317
    flag.wait=0
    flag.find=1
	  flag.idle=0
    thread_resume(lookfor)
    job.killer[job.target]=job.id
    messageShow('���������ҵ���'.. job.target ..'����')
	  exe('set wimpy 100')
    exe('halt;follow '..job.id)
      -- 	if skills["niqiu-gong"] and skills["niqiu-gong"].lvl>499 then -- ain
	    --       exe('jifa dodge niqiu-gong;set wimpycmd \\pfmpfm\\hp;set wimpy 100') -- ain add
    	 -- else
             exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
      --  end    

	  if score.party=="��ɽ��" then
         exe("set ��ɽ���� ��")
    end 
    exe('l '..job.id)
 	  exe('kill '..job.id)
 	--  ain_print('fuxing job: kill '..job.id)
end

function fuxingQingNext(n,l,w)
	if Qingok==1 then
	      return fuxingBack()
	else
        create_timer_s('fuxing',2,'fuxingQingNext2')
	end
end

function fuxingQingNext2(n,l,w)
	if Qingok==1 then
	    return fuxingBack()
	else
	    EnableTriggerGroup("fuxingFight",true) -- ain
		exe ('hp')
		if(hp.qixue_per<75) or (hp.neili <hp.neili_max ) then
			return check_busy(fuxingFangqiGo,2)
		else
			exe('yun jing;yun jingli;yun qi;pfmpfm;qing '..job.id)
		end
	end
end

function fuxingadd(n,l,w)
		messageShow('�������񣺿�ʼ�롾'.. job.target ..'������'..Qingtimes..'�Σ�')
		Qingtimes=Qingtimes+1
	--	flag.idle=2 -- ain
end

function fuxingNFaint(n,l,w)
   EnableTriggerGroup("fuxingFight",true)  -- ain add
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          exe('halt')
		      exe('set wimpy 100')
		      exe('yun jing;yun qi;dazuo '.. hp.dazuo)
	        return check_bei(fuxingQing)
       else
          job.progress=2 --add
          exe('kill '..job.id)
       end
    end
end


function fuxingFollow(n,l,w)
    if job.target==w[2] then
       job.fuxing=2
	     Qingok=1
	     flag.idle=1
	     job.progress=3 --add
	     return fuxingBack()
	  end
end

function fuxingDie(n,l,w)
  -- ain add log
 -- logfile = GetInfo(59) .. "/log/����������ͷ-"..score.id .."-"..os.time() .. ".txt"
 -- OpenLog (logfile , false)
--	print("��ʼ��¼log��",logfile )
       job.time.ef=os.time()  -- ain
       job.time.ff=job.time.ef-job.time.sf  -- ain
    job.fuxing=2
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          --exe('qing '..job.id)
          print("fuxing job ����ʧ��!",logfile )
          messageShow('��������ʧ�ִ��������˶���'.. job.target ..'����'..'��ʱ:��'..job.time.ff..'����')
		      -- return check_bei(fuxingQing,1) -- wapian
		       -- ain add log2  	 		
         -- ain_debug("Debugһ��.txt",",��������ʧ�ִ��������˶���".. job.target .."��")
       --   ainlogline2("ʧ�ִ��������˶���",3000)
	          disWait()
		      return check_busy(fuxingFangqiGo)  -- ain
       else
          job.progress=3 --add
          job.fuxing=2  -- ain
          print("fuxing job ɱ�˳ɹ�!")
          DeleteTimer("perform")
		      messageShow('���������Ѿ��ɵ��ˡ�'.. job.target ..'����'..'��ʱ:��'..job.time.ff..'����')
          -- check_busy1(fuxingCut) -- ain ��Ҫ�����
          check_busy(fuxingCut)
       end
    end
end

function fuxingQingCheck(n,l,w)
    if job.target==w[2] or b.target=="��" then
       return checkWait(fuxingQing,2)
    end
	
end
function fuxingQing()
 
    		exe('hp')
    		check_bei(fuxingQingAct,1)

end
function fuxingQingAct()
    --if hp.neili<hp.neili_lim then
    --   return prepare_neili(fuxingQing,1)
    --else
	-- or (hp.neili <hp.neili_max )
       exe('yun jing;yun jingli;pfmpfm;qing '..job.id)

    --end
end
function fuxingCut()
   if weaponKind[skillEnable[perform.skill]] == 'cut' or perform.skill ~= 'yuxiao-jian' then  -- ain
    EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingCut",true)
    exe('halt')
    for i=1,3 do
        exe('qie corpse '..i)
    end
 elseif job.area=="�����" then
     EnableTriggerGroup("fuxingFight",false)
     EnableTriggerGroup("fuxingCut",true)
	   weaponWieldCut()
	   wait.make(function()
	      wait.time(1.5)
	      for i=1,3 do
           exe('qie corpse '..i)
    
        end 
     end)
  
 else
    EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingCut",true)
    exe('halt')
    exe("get corpse")
	check_busy(fuxingCut2,1)
 end 
   
end
function fuxingCut2() -- ain
    EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingCut",true)
	weapon_unwield()
     weaponWieldCut()
	   
	     
	      for i=1,3 do
           exe('qie corpse '..i)
    
        end 
    
end

function fuxingCutWeapon()
    EnableTriggerGroup("fuxingCut",false)
    checkWait(fuxingCut2,1)
end
function fuxingCutCon(n,l,w)
    EnableTriggerGroup("fuxingCut",false)
    if job.target~=tostring(w[2]) then
       exe('drop head')
       check_bei(fuxingCut)
    else
       
       return fuxingBack()
    end
end
function fuxing_get_con(n,l,w) -- ain add
		 if job.target==tostring(w[2]) then
         EnableTriggerGroup("fuxingCut",false)
		     return fuxingBack()
 		 else
  			 exe('drop corpse')
   			   EnableTriggerGroup("fuxingFight",false)
          EnableTriggerGroup("fuxingCut",true)
	       weaponWieldCut()
	       
	     wait.make(function()
	      wait.time(1.5)
	       for i=1,3 do
           exe('qie corpse '..i)
    
         end 
     end)
   		end	 
end

-- ain

function fuxing_get_act1()
  --   EnableTriggerGroup("fuxing",true)
    DeleteTriggerGroup("hs_get")
    create_trigger_t('hs_get1','^(> )*(���컯�յ������ٰ�|\\D*��ʬ��������̫����)','','huashan_get_next')
    SetTriggerOption("hs_get1","group","hs_get")
	tmp.hscorpsecnt=1
	tmp.hsgettimes=1
	exe('get corpse')
end

-----------------------

function fuxingLost(n,l,w)
    if job.id==Trim(w[2]) then
       dis_all()
       return fuxingFind()
    end
end
function fuxingBckCheck(n,l,w)
    if job.target==w[2] then
       fuxingBack()
    end
end
function fuxingBack()
    DeleteTimer("fuxing")
    DeleteTimer("perform")
    EnableTriggerGroup("fuxingFight",false)
    EnableTriggerGroup("fuxingFinish",true)
    messageShow('�������񣺸㶨�ˣ��غ�ľ�£�')
    exe('say �������񣺸㶨�ˣ��غ�ľ�£�')
  --  CloseLog()
     --	road.wait=road.wait1
      --road.steps=road.steps1
    go(fuxingHead,'��ľ��','��ͤ')
end
function fuxingHead()
 if not locl.id["������"] then  -- ain add 
    checkWait(fuxingBack,2)
 else
    if job.type and job.type=="qing" then
       cntr1 = countR(8)
       return fuxingFinishWait()
    else
       EnableTriggerGroup("fuxingHead",true)
       tmp.flag=0
       exe('look head;l corpse')
       exe('alias action check_head')
    end
 end
end
function fuxingHeadCheck(n,l,w)
    if w[2] == job.target then
       tmp.flag=1
    end
end
function fuxingHeadCon()
    EnableTriggerGroup("fuxingHead",false)
    if tmp.flag==1 then
       return fuxingGive()
    else
       return fuxingFinish()
    end
end
function fuxingGive()
    EnableTriggerGroup("fuxingGive",true)
    exe('give head to xiang wentian;give corpse to xiang wentian')
end
function fuxingFinishWait()
    if cntr1()>1 then
       return fuxingFinish()
    else
       exe('s;n')
       checkWait(fuxingFinishWait,1)
    end
end
function fuxingFinishCheck(n,l,w)
    if w[2]==job.target then
       return fuxingFinish()
    end
end
function fuxingFinish()
    EnableTriggerGroup("fuxingFight",false)
	    exe('give head to xiang wentian;give corpse to xiang wentian')
	    exe('askk xiang wentian about ���')
    messageShow('��������������ɣ�')
    job.last='fuxing'
    job.progress=0
	EnableTriggerGroup("xxdfquest",true)
	if not skills["xixing-dafa"] and score.party == '�������' then
		return check_bei(check_heal,2)
	else
		return checkWait(check_heal,1)
	end
end
function fuxingescap(n,l,w)
job.progress=0  -- ain
----- ain -------------------------
local npcskills=w[3]
messageShow('��������'..npcskills)
	if GetVariable("RYjobSkillsFangqi") and GetVariable("RYjobSkillsFangqi")~="" then
       RYjobSkillsFangqi=GetVariable("RYjobSkillsFangqi")    --��ʽ:΢�����,������,С������,�ڻ��ͨ,��Ϊ�˵�,��������
    end
   
   
			--if RYjobSkillsFangqi and string.find(RYjobSkillsFangqi,npcskills)  then
			if fuxingIgnoresskill[npcskills] then 
			 	  DeleteTimer("fuxing")
    			DeleteTimer("perform")
    			EnableTriggerGroup("fuxingFight",false)
    			EnableTriggerGroup("fuxingFinish",true)
    			messageShow('�������񣺶���̫�������غ�ľ�·�����')
    			exe('say �������񣺶���̫�������غ�ľ�·�����')
    			exe('set wimpycmd 10')
  				  CloseLog()
    		--	ainlogline2("���¸�����������".."-"..npcskills,50)
    		--	go(check_heal,'��ľ��','��ͤ')
    		   flag.find=2
    	--	   road.wait=road.wait1
          -- road.steps=road.steps1
			exe('halt')
			exe(locl.dir)
    			 --go(fuxingFangqi,'��ľ��','��ͤ')
    			fuxingFangqiGo()
			else
				messageShow('�������񣺿�ʼ�롾'.. job.target ..'��ս����')
				check_busy(killfuxing,1)
			end
			
--[[
      if huaxueskill[npcskills] then
           if GetVariable("pfmhuaxue") then
              -- perform.pre=GetVariable("pfmhuaxue")
              perform.pre=string.gsub(GetVariable("pfmhuaxue"), "@id", job.id)
              create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
             exe('pfmset')
     		  --	 if skills["niqiu-gong"] and skills["niqiu-gong"].lvl>499 then -- ain
	            --    exe('jifa dodge niqiu-gong;set wimpycmd \\pfmpfm\\hp;set wimpy 100') -- ain add
			--	else
     		          exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
     		  --   end      

                 if GetVariable("flagdebug") and tonumber(GetVariable("flagdebug"))==1 then
               				print('������'..npcskills..'���л�����ѧpfmģʽ��'..perform.pre)   
              				-- ain add log2  	 		
	 										local file = io.open(GetInfo(59) .. "/log/Debugһ��.txt", "a")
	      							file:write(os.date()..','..score.id ..",Debug==="..",���û�ѧ����,"..npcskills..",")
	      							file:write("\n")
        							file:close()
        						-- 
        	   				 -- ain add log
             				 logfile = GetInfo(59) .. "/log/��ѧpfm���ܼ�¼ ��"..npcskills.."��-"..score.id .."-"..os.time() .. ".txt"
              				OpenLog (logfile , false)
       	     					 print("��ʼ��¼��ѧpfm log��",logfile )
       	     		  end 			 
       	    --  fight_prepare()

        	 else
        	    if GetVariable("flagdebug") and tonumber(GetVariable("flagdebug"))==1 then
           		   print('������'..sxjob.skills..'��ֻ��Ӳ���ˣ�'..perform.pre)   
              		-- ain add log2  	 		
	 								local file = io.open(GetInfo(59) .. "/log/Debugһ��.txt", "a")
	      					file:write(os.date()..','..score.id ..",Debug==="..",û�л�ѧ����,"..sxjob.skills)
	      						file:write("\n")
        						file:close()
        						exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
        			 end
        	  end	
       end
	   --]]
-----------------------------------------------------------


    if w[2]=="��󡹦����" then
 			   	DeleteTimer("fuxing")
    			DeleteTimer("perform")
    			EnableTriggerGroup("fuxingFight",false)
    			EnableTriggerGroup("fuxingFinish",true)
    			messageShow('�������񣺶���̫�������غ�ľ�·�����')
    			exe('say �������񣺶���̫�������غ�ľ�·�����')
    			exe('set wimpycmd 10')
  				--  CloseLog()
    		--	ainlogline2("���¸�����������".."-".."��󡹦����",50)
    			go(fuxingFangqi,'��ľ��','��ͤ')
     elseif w[2]=="���ư�"	or w[2]=="�䵱��"	or w[2]=="Ľ����"	then
        	  if score.party=="��ɽ��" then
                 exe("unset ��ɽ����")
            end 
                 
     end
end
function fuxingcancle()
        EnableTriggerGroup("fuxingFight",false)
    
       ---  fuxingTriggerDel() -- ain add
        job.last='fuxing'
         messageShow('�����������������')
     -- job.last='fuxing'
       job.fuxing=0
       return check_bei(check_heal)
end

function fxfightpfm(n,l,w)  -- ain
	if w[2]== job.target then
  		if skills["niqiu-gong"] and skills["niqiu-gong"].lvl>499 and id then -- ain
  		 --   exe ('perform dodge.niqiu '..job.id)
      	--  exe('set wimpycmd \\pfmpfm\\hp;set wimpy 100') -- ain add
   			--	else
   	 	--    exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
   		 end  
  end      
end

function get_id(name,party,f)--�õ�name��id
local id=""
--local f=f or 0 
if data_system_npc[name] then--ϵͳnpc
	id=data_system_npc[name]
else
	local n1=string.sub(name,1,2)
	local n2=string.sub(name,3,4)
	local n3=string.sub(name,5,6)
	local n4=string.sub(name,7,8)
	local n12=string.sub(name,1,4)
	local n23=string.sub(name,3,6)
	local n34=string.sub(name,5,8)
	local n=string.sub(name,-2)
	local p=killer_party or "none"
	--echo(C.W..p)
	local l=string.len(name)
	local data_name_n1=data_name[n1] or ""
	local data_name_n2=data_name[n2] or ""
	local data_name_n3=data_name[n3] or ""
	local data_name_n4=data_name[n4] or ""
	local data_name_n12=data_name[n12] or ""
	local data_name_n23=data_name[n23] or ""
	local data_name_n34=data_name[n34] or ""
	if l==8 then
		if string.find(n,"��") and string.find(p,"�һ���") then
			if data_name_fuxing[n12] then
	--			id=data_name[n1]..data_name[n2]..data_name[n3].." "..data_name[n4]
				id=data_name_n12..data_name_n3.." "..data_name_n4
			elseif data_name_fuxing[n23] then
				id=data_name_n1..data_name_n23.." "..data_name_n4
			else
				id=data_name_n1..data_name_n2..data_name_n3.." "..data_name_n4
			end
		else
			if data_name_fuxing[n12] and data_name_fuxing[n34] then
				id=data_name_n12.." "..data_name_n34
			elseif data_name_fuxing[n12] then
				id=data_name_n12.." "..data_name_n3..data_name_n4
			elseif data_name_fuxing[n23] then
				id=data_name_n1.." "..data_name_n23..data_name_n4
			elseif data_name_fuxing[n34] then
				id=data_name_n1.." "..data_name_n2..data_name_n34
			else
				id=data_name_n1..data_name_n2.." "..data_name_n3..data_name_n4
			end
		end
	elseif l==6 then
		if string.find(n,"��") and string.find(p,"�һ���") then
			if data_name_fuxing[n12] then
				id=data_name_n12.." "..data_name_n3
			else
				id=data_name_n1..data_name_n2.." "..data_name_n3
			end
		else
			if data_name_fuxing[n12] then
				id=data_name_n12.." "..data_name_n3
			elseif data_name_fuxing[n23] then
				id=data_name_n1.." "..data_name_n23
			else
				id=data_name_n1.." "..data_name_n2..data_name_n3
			end
		end
	elseif l==4 then
			if data_name_fuxing[n12] then
				id=data_name_n12
			else
				id=data_name_n1.." "..data_name_n2
			end
	elseif l==2 then
		id=data_name_n1
	end

end
print(id)
return id
end

data_name={["֥"]="zhi",["ʱ"]="shi",["��"]="run",["��"]="guang",["��"]="biao",["��"]="tian",["��"]="du",["��"]="ruo",["��"]="cai",["��"]="xu",["��"]="hao",["����"]="guliang",["»"]="lu",["��"]="hu",["֧"]="zhi",["��"]="xu",["ΰ"]="wei",["��"]="du",["��"]="biao",["��"]="cai",["��"]="ying",["��"]="xi",["��"]="fa",["��"]="du",["��"]="chao",["½"]="lu",["����"]="chunyu",["��"]="jun",["�"]="zheng",["��"]="zao",["��"]="hao",["��"]="yan",["��ΰ"]="chaowei",["��"]="xu",["��"]="duan",["ʷ"]="shi",["����"]="baishang",["ŷ��"]="ouyang",["���"]="wuzang",["��"]="ning",["δ"]="wei",["Ƽ"]="ping",["��"]="ning",["��"]="lin",["��"]="ling",["��"]="gui",["��"]="chao",["��"]="lv",["��"]="jiu",["ƽ"]="ping",["��"]="hua",["��"]="dai",["ұ"]="ye",["��ľ"]="duanmu",["�ʸ�"]="huangpu",["֮"]="zhi",["��"]="bin",["��"]="shao",["��"]="yan",["��"]="duan",["��"]="san",["��"]="tuo",["��"]="pei",["��"]="hua",["��"]="duan",["��"]="yan",["��"]="fan",["���"]="linghu",["��"]="tie",["��"]="diao",["ʽ"]="shi",["��"]="he",["��"]="bin",["��"]="yan",["����"]="chanyu",["Ҷ"]="ye",["κ"]="wei",["��"]="he",["����"]="yuezheng",["ʿ"]="shi",["��"]="kai",["��"]="he",["��"]="gui",["��"]="fan",["��"]="zhao",["��"]="ling",["��"]="she",["��"]="xuan",["����"]="gongxi",["��"]="shi",["��"]="rong",["��"]="pei",["��"]="hua",["��"]="zang",["��"]="xi",["��"]="pei",["��"]="lv",["ξ"]="wei",["��"]="po",["��"]="kai",["��"]="zeng",["é"]="mao",["��ԯ"]="xuanyuan",["һ"]="yi",["��"]="po",["��"]="jin",["��"]="he",["��"]="fan",["�"]="dou",["����"]="fucheng",["��"]="xuan",["��"]="wei",["��"]="tao",["ë"]="mao",["��"]="cao",["ǧ"]="qian",["��"]="yan",["�"]="shan",["��"]="ling",["��"]="he",["��"]="zhuankong",["��"]="wen",["ֺ"]="zhi",["��"]="yan",["�"]="rui",["��"]="huan",["��"]="he",["��"]="ce",["���"]="puyang",["����"]="zhangsun",["��"]="wen",["ǫ"]="qian",["ï"]="mao",["˧"]="shuai",["��"]="peng",["��"]="he",["��"]="guo",["��ǧ"]="duanqian",["��"]="wen",["Ǭ"]="qian",["��"]="ju",["��"]="guo",["��"]="fang",["��"]="shen",["΢��"]="weisheng",["־"]="zhi",["��"]="kang",["�"]="ji",["��"]="fang",["����"]="wuma",["Ӣ"]="ying",["��"]="jin",["��"]="she",["Ǯ"]="qian",["��"]="chen",["�ϴ�"]="mengda",["��"]="guo",["��"]="duo",["��"]="liu",["��"]="shen",["ǰ"]="qian",["��"]="ju",["��"]="ha",["��"]="jin",["Ǳ"]="qian",["��"]="peng",["��"]="liu",["��"]="kui",["˾��"]="sima",["��"]="zhen",["��"]="yi",["��"]="peng",["��"]="lun",["ˮ"]="shui",["��"]="liu",["�"]="zhuan",["��"]="kang",["��"]="liu",["��"]="weng",["��"]="cheng",["ף"]="zhu",["��"]="zhen",["��"]="pu",["��"]="long",["��"]="fu",["��"]="shen",["��"]="chuan",["��"]="cheng",["��"]="ai",["�̨"]="tantai",["����"]="helian",["ѧ��"]="xueyou",["�»�"]="dehua",["��"]="zhi",["ӫ"]="ying",["��"]="wan",["˳"]="shun",["��"]="ai",["��"]="pu",["����"]="gongsun",["��"]="yang",["��"]="wan",["��"]="cheng",["�ĺ�"]="xiahou",["С��"]="xiaochun",["��"]="luo",["��"]="fei",["��۳"]="ruyan",["��"]="hong",["��"]="wang",["��"]="ke",["��"]="huang",["��"]="chen",["����"]="gongliang",["ӯ"]="ying",["��"]="cheng",["��"]="an",["��"]="wang",["����"]="manyu",["��"]="shou",["��"]="mei",["��"]="hong",["��"]="zhu",["��"]="qi",["��"]="yang",["��"]="sheng",["��"]="zhi",["ӱ"]="ying",["˹"]="si",["��"]="kun",["��"]="hong",["ʦ��"]="shikong",["��"]="qi",["��"]="kun",["��"]="yang",["��"]="wu",["��"]="huang",["�Ϲ�"]="nanguo",["����"]="xiangsi",["��"]="zhen",["ǿ"]="qiang",["��"]="ji",["��"]="hong",["�"]="gang",["̫��"]="taishu",["����"]="wenren",["˼"]="si",["��"]="xi",["��"]="qi",["����"]="daiyu",["��"]="zhong",["��"]="yuan",["��"]="ke",["��"]="juan",["��"]="fei",["��"]="men",["����"]="chujin",["Ϳ��"]="tuqin",["��"]="yi",["��"]="ting",["��"]="fen",["��"]="zhong",["˾"]="si",["��"]="ke",["ϼ"]="xia",["��"]="wei",["��"]="kuo",["��"]="hou",["��"]="yi",["��"]="qi",["��"]="meng",["��"]="hou",["��"]="fu",["��"]="chi",["���"]="zhuge",["��"]="fu",["��"]="hui",["��"]="hou",["��"]="ao",["��"]="jiu",["�й�"]="jiagu",["����"]="ximen",["��"]="fu",["��"]="chun",["��"]="chi",["��"]="qiao",["۳"]="yan",["��"]="hu",["����"]="tuozai",["��"]="si",["��"]="zhong",["��"]="yi",["��"]="qi",["��"]="hui",["��"]="chang",["��"]="ao",["ī"]="mo",["��"]="ma",["��"]="shu",["����"]="liuren",["Ȩ"]="quan",["��"]="meng",["��"]="wu",["��"]="shu",["��"]="er",["��"]="fu",["��"]="zhou",["С"]="xiao",["��"]="shu",["��"]="ao",["��"]="qi",["��"]="yan",["Т"]="xiao",["��"]="wu",["Ȫ"]="quan",["��"]="meng",["��"]="zhou",["��"]="zheng",["��"]="chun",["����"]="huyan",["��ϼ"]="qingxia",["��"]="wu",["��"]="yong",["��"]="fu",["��"]="xia",["��"]="zheng",["����"]="dongguo",["����"]="yuwen",["����"]="baochai",["��"]="er",["��"]="yi",["̨"]="tai",["��"]="song",["��"]="kong",["Ф"]="xiao",["��"]="qi",["��"]="hu",["��"]="runfa",["��"]="yong",["��"]="yi",["̩"]="tai",["ı"]="mou",["��"]="mai",["��"]="qiao",["��"]="lai",["����"]="dongfang",["��"]="yi",["��"]="qi",["��"]="hui",["Ĳ"]="mou",["��"]="kong",["��"]="hu",["ԣ"]="yu",["��"]="yi",["��"]="mai",["��"]="jun",["��"]="bao",["��"]="wu",["̫"]="tai",["����"]="chuhong",["��"]="yi",["��"]="hui",["��"]="feng",["ξ��"]="yuchi",["ԥ"]="yu",["��"]="feng",["��"]="dan",["��"]="song",["��"]="qi",["��"]="jun",["��"]="mi",["��"]="shan",["��"]="ba",["��"]="you",["��"]="zhou",["��"]="xian",["��"]="man",["��"]="lan",["��"]="jun",["��"]="chai",["��"]="bao",["��"]="qin",["��"]="feng",["��"]="ba",["��"]="yi",["��"]="man",["��"]="jian",["��"]="feng",["Ԫ"]="yuan",["��"]="zhu",["��"]="wu",["��"]="ji",["��"]="gong",["��"]="qin",["��"]="su",["��"]="qin",["��"]="qi",["��"]="jian",["��"]="gong",["Ԭ"]="yuan",["����"]="shentu",["��"]="qin",["��"]="gong",["Ľ"]="mu",["����"]="zuoqiu",["̶"]="tan",["��"]="qin",["Ⱥ"]="qun",["ľ"]="mu",["��"]="ji",["��"]="zhu",["��"]="gan",["��"]="feng",["��"]="xi",["Ȼ"]="ran",["��"]="li",["��"]="you",["̷"]="tan",["��"]="qiu",["ԯ"]="yuan",["��֥"]="baizhi",["��"]="you",["��"]="gong",["��"]="ba",["̸"]="tan",["��"]="zhu",["����"]="zongzheng",["��"]="yin",["��"]="xi",["̹"]="tan",["��"]="mu",["��"]="lang",["��"]="jian",["��"]="feng",["��"]="gong",["��"]="bei",["�ǳ�"]="xingchi",["Բ"]="yuan",["��"]="feng",["��"]="dang",["��"]="mu",["�ַ�"]="yanfa",["��"]="qing",["��"]="li",["��"]="bai",["��"]="jiang",["��"]="si",["��ұ"]="gongye",["��"]="bo",["��"]="fu",["��"]="lang",["��"]="ji",["��"]="bai",["����"]="dongmen",["����"]="zhongsun",["����"]="xifeng",["��"]="zi",["��"]="lang",["��"]="jiang",["��"]="jia",["��"]="miao",["��"]="gou",["��"]="zi",["��"]="xian",["л"]="xie",["��"]="bai",["�"]="yu",["��"]="yin",["��"]="qing",["��"]="lian",["��"]="kuan",["��"]="tang",["ɣ"]="sang",["��"]="jiang",["��"]="jia",["����"]="weijian",["��"]="na",["��"]="jia",["��"]="gang",["��"]="yu",["��"]="lian",["��"]="yin",["ũ"]="nong",["��"]="kuang",["��"]="gang",["͢"]="ting",["��"]="tang",["��"]="lian",["��"]="ben",["��"]="lao",["��"]="huo",["��"]="xin",["��"]="tang",["��"]="ban",["��"]="yu",["��"]="zong",["ͤ"]="ting",["��"]="sui",["��"]="gang",["��"]="chu",["��"]="kuang",["��"]="xiang",["��"]="xin",["ͥ"]="ting",["��"]="ren",["��"]="tang",["��"]="jia",["��"]="cui",["��"]="ren",["��"]="qing",["��"]="nan",["��"]="mie",["��"]="jia",["��"]="yu",["��"]="wu",["��"]="fu",["˾ͽ"]="situ",["��"]="yue",["��"]="qiong",["��"]="min",["��"]="yu",["����"]="zhongli",["��"]="dao",["��"]="xiang",["��"]="xin",["ͨ"]="tong",["��"]="nan",["��"]="zhou",["��"]="kuang",["��ֺ"]="tuozhi",["ͩ"]="tong",["ɭ"]="sen",["��"]="qiu",["��"]="ren",["��"]="yue",["��"]="jiao",["��"]="xing",["��"]="sui",["��"]="min",["��"]="lei",["��"]="gao",["��"]="de",["Ѧ"]="xue",["��"]="ding",["��"]="qiu",["ѧ"]="xue",["��"]="xiang",["��"]="cui",["��"]="qiu",["�Ϲ�"]="nangong",["ͬ"]="tong",["�"]="pu",["ܽ"]="fu",["��"]="yun",["١"]="tong",["ͭ"]="tong",["��"]="tao",["��"]="ming",["��"]="bo",["��"]="sun",["��"]="tao",["��"]="liang",["��"]="kui",["�׸�"]="zaifu",["ŷ"]="ou",["��"]="ming",["��"]="kui",["��"]="jiao",["��"]="gu",["��"]="ding",["��"]="deng",["ͯ"]="tong",["ɳ"]="sha",["��"]="yu",["��"]="liang",["��"]="jian",["��"]="hai",["��"]="bi",["��"]="zu",["��"]="xiang",["��"]="ding",["ɵ"]="sha",["��"]="xiang",["��"]="hai",["��"]="ge",["�麣"]="guihai",["ͳ"]="tong",["��"]="rong",["��"]="neng",["��"]="xing",["��"]="yu",["��"]="deng",["�ض�"]="qindong",["��"]="yu",["��"]="rong",["��"]="dong",["��"]="tao",["��"]="qu",["��"]="gu",["�"]="tao",["��"]="liang",["��"]="dong",["��"]="yu",["¡"]="long",["��"]="da",["��"]="xiao",["��"]="qu",["��"]="ni",["��"]="dong",["��"]="yu",["��"]="leng",["��"]="gu",["��"]="teng",["��"]="jing",["��"]="di",["��"]="rong",["��"]="han",["��"]="teng",["ɽ"]="shan",["��"]="dong",["Ľ��"]="murong",["��"]="da",["��"]="di",["����"]="gongyang",["��"]="li",["��"]="ge",["��"]="dai",["�"]="tan",["��"]="zai",["ͼ"]="tu",["��"]="bo",["��"]="pi",["��"]="ni",["��"]="yu",["Ƥ"]="pi",["��"]="zuo",["ͽ"]="tu",["�Ϲ�"]="shangguan",["��"]="xiong",["�"]="wei",["��"]="li",["��"]="dai",["��"]="zai",["ʢ"]="sheng",["��"]="xiong",["��"]="liao",["��"]="bao",["Ϳ"]="tu",["�"]="pu",["����"]="yangshe",["��"]="xiao",["��"]="ke",["��"]="dou",["��"]="tu",["���"]="qidiao",["��"]="zuo",["ʤ"]="sheng",["��"]="ran",["��"]="nian",["��"]="dai",["��"]="bu",["¬"]="lu",["��"]="li",["��"]="ru",["��"]="liao",["��"]="di",["��"]="li",["����"]="xiangyun",["΢"]="wei",["��"]="jing",["ʦ"]="shi",["��"]="pan",["�"]="cen",["��"]="lie",["��"]="li",["�"]="lan",["��"]="gen",["��"]="bu",["��"]="guan",["��"]="zan",["��"]="nian",["��"]="li",["��"]="du",["Τ"]="wei",["��"]="guan",["��"]="ru",["����"]="liangqiu",["�"]="nan",["��"]="lie",["ʩ"]="shi",["ݷ"]="xin",["ٻ"]="qian",["Ʈ"]="piao",["��"]="han",["տ"]="zhan",["��"]="shang",["³"]="lu",["��"]="guan",["��Ȼ"]="yanran",["��"]="chang",["Ψ"]="wei",["��"]="lin",["��"]="li",["��"]="jing",["��"]="ruan",["��"]="bian",["��"]="shang",["��"]="chang",["��"]="qing",["��"]="cai",["��"]="zhang",["��"]="qiu",["��"]="lin",["Ϊ"]="wei",["��"]="tian",["��"]="rui",["��"]="cai",["Ҧ"]="yao",["��"]="pang",["��"]="nie",["��"]="shang",["����"]="baili",["��"]="xu",["��"]="tian",["��"]="rui",["��"]="jie",["��"]="fa",["֣"]="zheng",["ʯ"]="shi",["��"]="kuai",["ά"]="wei",["��"]="guan",["��"]="zhang"}
data_name_fuxing={["����"]=true,["����"]=true,["��ΰ"]=true,["����"]=true,["ŷ��"]=true,["���"]=true,["��ľ"]=true,["�ʸ�"]=true,["���"]=true,["����"]=true,["����"]=true,["����"]=true,["��ԯ"]=true,["����"]=true,["��"]=true,["���"]=true,["����"]=true,["��ǧ"]=true,["΢��"]=true,["����"]=true,["�ϴ�"]=true,["˾��"]=true,["�̨"]=true,["����"]=true,["ѧ��"]=true,["�»�"]=true,["����"]=true,["�ĺ�"]=true,["С��"]=true,["��۳"]=true,["����"]=true,["����"]=true,["ʦ��"]=true,["�Ϲ�"]=true,["����"]=true,["̫��"]=true,["����"]=true,["����"]=true,["����"]=true,["Ϳ��"]=true,["���"]=true,["�й�"]=true,["����"]=true,["����"]=true,["����"]=true,["����"]=true,["��ϼ"]=true,["����"]=true,["����"]=true,["����"]=true,["��"]=true,["����"]=true,["����"]=true,["ξ��"]=true,["����"]=true,["����"]=true,["��֥"]=true,["����"]=true,["�ǳ�"]=true,["�ַ�"]=true,["��ұ"]=true,["����"]=true,["����"]=true,["����"]=true,["����"]=true,["˾ͽ"]=true,["����"]=true,["��ֺ"]=true,["�Ϲ�"]=true,["�׸�"]=true,["�麣"]=true,["Ľ��"]=true,["����"]=true,["�Ϲ�"]=true,["����"]=true,["���"]=true,["����"]=true,["����"]=true,["��Ȼ"]=true,["����"]=true}
data_system_npc={["�ٱ�"]="guan bing",["���ְ����"]="bang zhong",["������"]="jia laolu",["Ʊ��"]="piao you",["����"]="dizi",["��ʦ"]="chu zi",["������"]="heiyi ren",["�����Ž���"]="jiao zhong",["����Ů"]="muyang nu",["������"]="muyang ren",["��ɽ��"]="qiu shanfeng",["���ƹ�"]="zhanggui",["����"]="lan jian",["����ͤ"]="yin liting",["Ү����"]="yelv qi",["����"]="huang zhen",["���������"]="dizi",["���"]="da dao",["����Сʦ��"]="daoming shifu",["������"]="su mengqing",["��ͷ��"]="lao touzi",["�����"]="linghu chong",["ׯ��"]="zhuang ding",["�Ϲٽ���"]="shangguan jiannan",["������"]="fang duozhu",["����ʦ"]="daku dashi",["�ķ�Сʦ̫"]="wen fang",["�쳤��"]="zhu changling",["���"]="xiang ke",["������"]="wang furen",["ç��"]="mang han",["���ɵ���"]="fengsong daozhang",["����"]="zhang san",["���ϰ�"]="laoban",["˾���"]="sima da",["С��"]="xiao fan",["������"]="qiao",["ά����帾Ů"]="woman",["ҩ���ƹ�"]="yaodian zhanggui",["�쾵��ʦ"]="tianjing chanshi",["�ɸߵ���"]="chenggao daozhang",["������"]="jiang tiaohou",["��ݺݺ"]="cui yingying",["����ɽ"]="shan boshan",["������"]="chen yunqing",["����ͨ"]="wanshi tong",["������"]="daoba zhang",["С��"]="xiao tong",["����"]="fan ye",["�߷��佫"]="wu jiang",["�ֺ�"]="le hou",["���"]="ni gu",["���"]="yang buhui",["������"]="miao ruolan",["��Ա��"]="li yuanwai",["�����"]="ma fuzi",["�³���"]="hao zhanglao",["�߷��ٱ�"]="guan bing",["׳��ɮ��"]="seng",["������"]="fu mingyi",["������"]="wang dami",["�ܼ�"]="guan jia",["���ϰ�"]="laoban",["�Ϲ���"]="shangguan peng",["�ɲ���"]="cheng buyou",["����"]="a gen",["����ţ"]="hu qingniu",["֪��ɮ"]="zhike seng",["��ǧ��"]="qiu qianzhang",["����ʦ"]="zhujian shi",["��åͷ"]="liumang tou",["�о�����"]="shiwei",["ִ������"]="zhifa dizi",["ɣ����"]="sang sanniang",["���ϰ�"]="huang laoban",["��Ѳ��"]="zhang xunbu",["�����"]="xiao banhe",["�˰ٴ�"]="deng baichuan",["�۷�����"]="huifang zunzhe",["���³���"]="mayi zhanglao",["������"]="duxing xia",["������"]="yu sanniang",["��Ե����"]="biqiu",["�޸�����"]="wugen daoren",["����"]="da shou",["֣��ͷ"]="zheng biaotou",["�����Ž���"]="jiao zhong",["�Ĳ�"]="you cao",["С����"]="xiao chuzi",["��ʹ��ʦ"]="dashi",["��˹����"]="bosi shangren",["����ͷ"]="zhang biaotou",["�η���"]="ren feiyan",["��ʯ��"]="caishi ren",["��ˮ�����"]="jiao zhong",["½��"]="lu bo",["�ױ��ӳ�"]="qinbing duizhang",["�·���"]="wen fangda",["��������"]="maihua guniang",["������"]="da yayi",["������ؤ"]="qi gai",["������"]="mengmian ren",["��ǧ"]="zhang qian",["����"]="shang ren",["���ŵ���"]="tianmen daoren",["�ɻ���"]="caihua zi",["������"]="zheluo xing",["����"]="guo jing",["����ʹ"]="huiyue shi",["��˼"]="luohan",["�������"]="jiangbei dadao",["�����ʺ�"]="huanghou",["С����"]="xiao fan",["�"]="qiong han",["�һ������"]="jiao zhong",["��ɮ"]="wu seng",["����"]="fei",["��ľ��"]="ya mujiang",["��������ɮ"]="wu seng",["��ҩ��"]="caiyao ren",["��Ů"]="woman",["����"]="yu zu",["����ͷ"]="xu biaotou",["�·�ɽ"]="wen fangshan",["Ѳ��"]="xun bu",["�������"]="xiyu keshang",["�嶾�̵���"]="dizi",["��ͷ��"]="shou toutuo",["ʯɩ"]="shi sao",["�ɸ�"]="meng ge",["�����ɹ���"]="gu shou",["����"]="san chou",["����"]="li sheng",["������ʦ"]="chanshi",["Ȫ����"]="quan jiannan",["����ѧʿ"]="zha xueshi",["Ѳ���ױ�"]="qing bing",["������"]="tiejiang",["׳����ؤ"]="qigai",["���"]="huoji",["������"]="zhao liangdong",["���޸�"]="yin wufu",["��������"]="zunzhe",["ʷ����"]="shi bowei",["��ɩ"]="pang sao",["��ͷ"]="biao tou",["����"]="zi zhu",["���Ӣ"]="wu baiying",["��ǧ��"]="qiu qianren",["չ��"]="zhan fei",["�����佫"]="dali wujiang",["�ſ�"]="zhang kang",["ʷ��ͷ"]="shi biaotou",["������"]="zhurou rong",["��ͨ"]="xu tong",["�Ϻ���"]="monk",["����ٱ�"]="dali guanbing",["����ɽ"]="shan shushan",["����ɽ"]="shan zhongshan",["����"]="bayi",["������ʦ"]="chanshi",["����"]="waiter",["������"]="duan zhengming",["˽������"]="sishu xiansheng",["����ʦ̫"]="jingxu shitai",["������"]="zhou zhiruo",["����"]="fei",["����ȭ"]="guo sanquan",["����"]="ding dian",["�������"]="xinqing biqiu",["Ԫ������"]="yuanai zunzhe",["����"]="zhong zhen",["���"]="tu chang",["������"]="feng tiannan",["������"]="cui suanpan",["��Сɽ"]="shan xiaoshan",["�����"]="daer ba",["Ľ�ݸ�"]="murong fu",["�����ŵ���"]="dizi",["ľ��"]="mu jiang",["���ʹ"]="miaofeng shi",["���ֱ���"]="biqiu",["�ŵ���"]="zhang danyue",["��ū"]="gui nu",["Ѿͷ"]="ya tou",["�����"]="jinxiang ke",["������"]="fan zhanglao",["���"]="hu fei",["�ξ�"]="you ju",["�ս�"]="ju jian",["����С��"]="dali xiaofan",["����"]="xu ming",["��ϼ��"]="xu xiake",["��ң��"]="xiaoyao zi",["����"]="liang fa",["Ԫ�㲨"]="yuan guangbo",["���ɵ���"]="tiansong daoren",["������"]="yin wushou",["����"]="du nan",["ֵ�ڱ�"]="zhiqin bing",["����"]="cheng yuhuan",["�´ﺣ"]="chen dahai",["����ʹ��"]="shi zhe",["ľ��"]="mu ren",["����"]="di xiu",["����"]="luohan",["������"]="wan qingli",["����"]="shu sheng",["��˼��"]="fu sigui",["ؤ�����"]="gaibang dizi",["������"]="yuji zi",["���ϴ�"]="lao da",["�׺�Ұ"]="mi hengye",["����"]="ju you",["�տն�"]="kong kong",["������"]="suona shou",["ũ��"]="fu",["÷����"]="mei chaofeng",["�·�ʩ"]="wen fangshi",["Ǯ����"]="qian shanren",["���"]="yin jin",["Ǯ��"]="qian feng",["��ʦ��"]="he shiwo",["������"]="feng tiejiang",["�����"]="huizu bing",["�����"]="ma duozhu",["ʤ��"]="sheng di",["��ʦ"]="biao shi",["����"]="hong niang",["���Ƴ�"]="gu ducheng",["�Ʋ���"]="huang boliu",["��Ʀ"]="dipi",["������"]="jiang laifu",["����"]="huo lang",["�ܻ���"]="zhou huwei",["���ݹ�ͯ"]="gui tong",["��ͨ��"]="hou tonghai",["����"]="fang ping",["����������"]="hasake mumin",["��ӯӯ"]="ren yingying",["��ұǬ"]="gongye gan",["���۴�ʦ"]="benguan dashi",["�鰲ͨ"]="hong antong",["���ϰ�"]="xian laoban",["�ᳯ��"]="yu chaofeng",["��"]="da han",["��������"]="miaozu qingnian",["�ֻ�"]="yan ji",["��Ӣ��"]="tang yinge",["������"]="yuqing zi",["������"]="cheng yaojia",["�³���"]="chen zhanglao",["����"]="ying gu",["������"]="peng lianhu",["�ܲ���͵�"]="huo fo",["�����"]="yu guangbiao",["���ϰ�"]="laoban",["ճ����"]="zhan ertie",["���µ���"]="dizi",["������"]="gu yanwu",["����ʦ̫"]="jinghe shitai",["������"]="chen zhengde",["���ϴ�"]="wu laoda",["ɳ�콭"]="sha tianjiang",["��³��"]="su luke",["�����ŵ���"]="dizi",["½����"]="lu gaoxuan",["����Ƽ"]="wanyan ping",["�⾢��"]="wu jincao",["�˰˹�"]="deng bagong",["֪������"]="zhifu daren",["��å"]="liu mang",["����"]="zhao min",["�����"]="zhu jiuzhen",["��С��"]="xu xiaowu",["����"]="zhang zhong",["����"]="jin ren",["ʷ����"]="shi zhongmeng",["����"]="ke shang",["����"]="ya yi",["������ͷ"]="biaotou",["����ʦ̫"]="jingzhao shitai",["������"]="ma qingxiong",["����"]="chen qing",["�ɹ���ʿ"]="weishi",["����"]="laopu",["С��ͯ"]="daotong",["�����"]="lan fenghuang",["����ɱ��"]="shashou",["ִ��ɮ"]="zhijie seng",["�ձ���"]="shaobing liu",["�μ�"]="luohan",["����"]="lao zhe",["����С��"]="luyi xiaotong",["�ܹ�ͩ"]="zhou gutong",["���˷�"]="miao renfeng",["С��ͯ"]="xiao shitong",["����ɮ"]="shizhou seng",["���ٳ���"]="kurong zhanglao",["��ϰ֮"]="su xizhi",["��С��"]="xiao er",["����ʵ"]="liu laoshi",["ɨ������"]="saodi puren",["����ʦ̫"]="jingjia shitai",["������"]="ji laoren",["����"]="zhang ma",["���������"]="jiao zhong",["���ɴ�ʦ"]="dashi",["�Ҷ�"]="jia ding",["С��ؤ"]="xiao qigai",["��Ů"]="xiang nu",["��ϲ��"]="jinxi er",["����ʦ̫"]="jingxuan shitai",["���Ϻ�"]="wang laohan",["С��"]="xiao er",["����"]="yi qing",["������"]="mu renqing",["Ѿ��"]="ya huan",["���´��"]="heiyi dadao",["˵����"]="shuo bude",["�ۿ�����"]="zunzhe",["�Ŀ�"]="du ke",["���ϰ�"]="laoban",["����"]="pu ren",["�Է�"]="qiao fu",["���δ�ʦ"]="bencan dashi",["����"]="jiang tao",["���˿"]="dai qisi",["�ܵ�"]="zhou dian",["��Ʒ��ʦ"]="chanshi",["�������"]="guxu daozhang",["�Ħ��"]="jiumo zhi",["�Գ�֮"]="zhao chengzhi",["����"]="qiao zi",["������"]="fang bilin",["��˼��ʦ"]="liaosi chanshi",["С���"]="xiao louluo",["Ф��ͷ"]="xiao laotou",["��������"]="hao ke",["��˹������"]="shengyi ren",["������"]="wang zhanglao",["�����ɵ���"]="dizi",["����˼"]="ling tuisi",["��ص���"]="tianbai daoren",["���Ѵ�ʦ"]="dashi",["��ѩͤ"]="xu xueting",["������"]="ding minjun",["�κ�ҩ"]="he hongyao",["�����Ϻ�"]="miaozu laohan",["ִ��ɮ��"]="bing",["���ϰ�"]="yin laoban",["������"]="yu popo",["����"]="wen yi",["��������"]="biqiu",["�����"]="gui erniang",["Ǯ�ۿ�"]="qian yankai",["������"]="wang gonggong",["������"]="shengyi ren",["������"]="wu qinglie",["������"]="feng qingyang",["��ѩ��"]="xia xueyi",["�ɿ�ʦ��"]="caikuang shifu",["�鱦��"]="zhubao shang",["�ؾ�"]="qin juan",["ҩʦ"]="yao shi",["����"]="gui zhong",["�����"]="du dajin",["�ѱ�"]="fei bin",["���в�"]="li zhaocai",["���Ʊ���"]="biqiu",["��Ȫ"]="zhang quan",["��ͷ��"]="huogong toutuo",["���д���"]="duxing daxia",["ţ�ϰ�"]="niu laoban",["���ǿ�"]="jingcheng ke",["�ӻ����ϰ�"]="laoban",["�ο�"]="you ke",["�����"]="ge guangpei",["�����Ʀ"]="dipi",["����ֹ"]="gongsun zhi",["���ϼ�"]="wang heji",["������"]="ding popo",["�����"]="wu dunru",["�����ɺ���"]="hao shou",["�ɳ���"]="xi zhanglao",["�����ʦ"]="tianhong chanshi",["Ԫ������"]="yuanjue zunzhe",["ʷ�Ͻ�"]="shi mengjie",["ͭ��"]="tong ren",["����ʯ"]="ba tianshi",["��������"]="dongfang bubai",["������"]="ning zhongze",["������"]="he tieshou",["������"]="wang sanli",["Ԫ������"]="yuanhui zunzhe",["������"]="wei tianwang",["������"]="lin zhennan",["������"]="lu zhuweng",["������"]="fae shizhe",["��Զ��"]="song yuanqiao",["��¥�ƹ�"]="jiulou zhanggui",["�˷�����"]="zhangfang xiansheng",["����"]="yanxiao",["����֮"]="guo yanzhi",["����Сʦ̫"]="wenyin",["�к�"]="boy",["�һ�����"]="tao hua",["��Ĭ��"]="feng mofeng",["������"]="sun popo",["��۱���"]="biqiu",["ҩ���ϰ�"]="laoban",["�̲�С��"]="tong",["������ʦ"]="kurong chanshi",["�����ŵ���"]="dizi",["Ī����"]="mo shenggu",["����̩"]="gao shengtai",["����ʦ̫"]="jingzhen shitai",["�°���"]="chen apo",["������"]="wu xiuwen",["ȫ����"]="quan guanqing",["��������"]="zhongnian nanzi",["����Ů��"]="luoti nvzi",["Τ����"]="wei chunfang",["��˫��"]="xin shuangqing",["�ƴ���"]="huang daxiong",["��������"]="lao weng",["��֯Ů"]="fangzhi nu",["ѧͯ"]="xue tong",["����"]="yanshang",["һƷ�� ��ʿ"]="wu shi",["����ʦ̫"]="dingyi shitai",["�����"]="bao dachu",["����ɱ��"]="shashou",["�Ӳ���"]="cong buqi",["����"]="luohan",["��Ϊ����"]="biqiu",["���С��"]="chaguan xiaoer",["���ϴ���"]="daxia",["��������"]="dali yayi",["�ĳ�"]="si chou",["������"]="jiang duozhu",["����"]="luohan",["�ɽ�"]="du jie",["����Сʦ̫"]="wen qing",["�ӷ�"]="xing fang",["������"]="wang yuyan",["���ϰ�"]="cui laoban",["�ⳤ��"]="wu zhanglao",["����"]="luohan",["��һ��ʦ"]="chanshi",["����"]="ma yu",["��ǧ��"]="qiu qianchi",["����"]="dao ke",["ɫ��"]="se leng",["��̫��"]="he taichong",["�����"]="he zudao",["�Ʊ�"]="jiu bao",["���ʷ�"]="zhangfang",["���"]="ma fu",["���ư�"]="qi yunao",["������"]="yuling zi",["֪�͵���"]="zhike daozhang",["������"]="zhang suanpan",["���"]="wu chou",["Ԫ������"]="yuanbei zunzhe",["�ͷ"]="li butou",["����Ŀ�"]="duke",["������"]="kuang baoguan",["��������"]="jieyin dizi",["Ե������"]="yuangen",["ɵ��"]="sha gu",["������ʦ"]="chanshi",["���ĵ�"]="tang wende",["����ɢ��"]="yuxu sanren",["������Ů����"]="dizi",["����˪"]="cheng qingshuang",["�ɻ����"]="caihua dadao",["������"]="han tiejiang",["����"]="luohan",["�巨����"]="biqiu",["�����ϰ�"]="lao ban",["��������"]="yiren",["������"]="jiang",["����"]="wang cheng",["����ͤ"]="yang lianting",["����������"]="bo shou",["�Ծ�ү"]="zhao jueye",["��������"]="jianchu daoren",["������"]="yin kexi",["������ʦ"]="chanshi",["����"]="bu chen",["ʷ���"]="shi shugang",["�販ʿ"]="cha boshi",["��ƽ֮"]="lin pingzhi",["������"]="laifu er",["������"]="ai laozhe",["�͵�ŵ"]="lao denuo",["���ϰ�"]="sun laoban",["�μ�"]="luohan",["��ʽ��"]="li shikai",["éʮ��"]="mao shiba",["һ�ƴ�ʦ"]="yideng dashi",["�����ɩ"]="daizu dasao",["���л�"]="xiao zhonghui",["������"]="liang ziweng",["�粨��"]="feng boe",["��������"]="zangzu mumin",["�γ���"]="song zhanglao",["��ü����"]="huangmei heshang",["�ֲ�"]="jia bu",["ʷ�Ǵ�"]="shi dengda",["ժ����"]="zhaixing zi",["����"]="hu gui",["��������"]="yangcan popo",["������"]="tangzi shou",["ѩ�ɶ�"]="xue xianer",["�����"]="li banxian",["���ǹ���"]="gong zi",["��ǧ��"]="zu qianqiu",["����ɺ"]="yue lingshan",["½��˫"]="lu wushuang",["���ı�"]="xixia bing",["Ľ�ݲ�"]="murong bo",["����"]="huang rong",["������ͯ"]="daotong",["С����"]="xiao tufei",["������ʦ"]="hubiao biaoshi",["ƮȻ��"]="piaoran zi",["����"]="cheng kun",["����ʦ"]="dadian dashi",["����"]="luohan",["�½���"]="chen jinnan",["������"]="hong xiaotian",["��ҩ����"]="caiyao daozhang",["��ң"]="fan yao",["����ؤ"]="qigai",["����Ⱥ"]="yue buqun",["����ɮ"]="datie seng",["������"]="wen nanyang",["����ׯ"]="liu zhuzhuang",["��������"]="yanxiao",["��Ҥ����"]="kanyao dizi",["����ʦ̫"]="dingxian shitai",["�Ϲ���"]="shangguan yun",["�����"]="long juanfeng",["����ɮ"]="seng",["������"]="bai shijing",["˫��"]="shuang er",["�ɹ���ʿ"]="wushi",["���Ӿ�"]="rong ziju",["���ƹ�"]="zhanggui",["����"]="qu yang",["����С��"]="wuming xiaozi",["�����ŵ���"]="dizi",["�����ŵ���"]="dizi",["�ƹ�"]="zhanggui",["��ԫ"]="yan tan",["������ʦ"]="chanshi",["��ɫ����"]="zunzhe",["�ɻ���"]="caihua zei",["�ױ���"]="he biweng",["Сɳ��"]="shami",["���"]="cha ke",["���δ�ʦ"]="dashi",["���ַ���"]="jinlun fawang",["���ϰ�"]="xiao laoban",["Ԫ��"]="yuan bing",["�º���"]="guhong zi",["�ķ�Сʦ̫"]="wen fei",["Ԭ����"]="yuan guannan",["�ױ�"]="qin bing",["½��Ӣ"]="lu guanying",["��"]="zhu jian",["�ϲ÷�"]="lao caifeng",["��־��"]="zhong zhiling",["����Ϫ"]="zhang songxi",["��������"]="yanshang",["������ʦ"]="dashi",["����"]="tiao fu",["��������"]="luopo shusheng",["�Ǹ�"]="qiao fu",["��������"]="gongsun lve",["���ƽ"]="wan daping",["С��"]="xiao cui",["������"]="tianlang zi",["�����佫"]="wu jiang",["�����ɵ���"]="dizi",["��̹֮"]="you tanzhi",["�쵤��"]="zhu danchen",["�����˸�Ů"]="woman",["������"]="hua tiegan",["ɣ��"]="sang jie",["����ˮ"]="wang huaishui",["�����"]="zhong wanchou",["����ʦ̫"]="jingkong shitai",["��������"]="huiyun zunzhe",["Ԫŭ����"]="yuannu zunzhe",["��ͷ"]="bu tou",["����ͨ"]="wu santong",["�����Ž���"]="jiao zhong",["��ҩʦ"]="huang yaoshi",["�˿���ʦ"]="liaokuan chanshi",["������ʦ"]="liaoqing chanshi",["������"]="hu bilie",["���߹�"]="hong qigong",["����ʦ̫"]="jinghui shitai",["Сͯ"]="xiao tong",["С��"]="kid",["��̳����"]="dizi",["������"]="chang yuchun",["�Ų���"]="wen cangsong",["�ʹ�����"]="shiwei",["������ʩ"]="doufu xishi",["Ů����"]="dizi",["�ų���"]="zhang chaotang",["��С��"]="zhong xiaoer",["ħ��ɱ��"]="mojiao shashou",["������ʦ"]="fangsheng dashi",["�˻���ʦ"]="liaohuo chanshi",["������"]="rui popo",["�����"]="hou junji",["���ʷ�"]="zhangfang",["�е���"]="dizi",["����ܽ"]="ji xiaofu",["����"]="yi lin",["�����"]="yu daiyan",["�ٰٳ�"]="chi baicheng",["���ҹ���"]="gong zi",["����"]="luohan",["��������"]="zunzhe",["���ű���"]="biqiu",["����"]="aman",["���°���"]="bangzhong",["���"]="li chunlai",["�³�֮"]="chen chongzhi",["ͯ����"]="tong baixiong",["��������"]="jiao zhong",["����"]="su quan",["������"]="boluo xing",["��Ө��"]="peng yingyu",["������"]="yu lianzhou",["������"]="zhao lingzhu",["���ϰ�"]="li laoban",["������"]="shangshan shizhe",["�ĳ��ϰ�"]="laoban",["Ѫ������"]="xuedao laozu",["�ܱ�"]="zhe bie",["��������"]="yanxiao",["���"]="miao bing",["�߿���"]="gao kexin",["һƷ����ʿ"]="wu shi",["������"]="gui xinshu",["����"]="a zhu",["������"]="yan mama",["������"]="xi huazi",["��Ȼ"]="xin ran",["����"]="wang wu",["��ʦ"]="wizard",["����ʦ̫"]="jingfeng shitai",["ɨ��ɮ"]="saodi seng",["����"]="chu zi",["�η�����"]="seng ren",["���Ŵ��"]="dujiao dadao",["�����"]="ma guangzuo",["ղ��"]="zhan chun",["�ι�"]="luohan",["Ħڭ��˼"]="mohe basi",["�̽�"]="shi jian",["����"]="tie jiang",["����ʦ̫"]="jingxian shitai",["֣��"]="zheng e",["�ŷ���"]="zhang furen",["�ﲮ��"]="tian boguang",["СѾ��"]="xiao yahuan",["�ܹܼ�"]="zong guanjia",["����ɮ��"]="bing",["������ʿ"]="wei shi",["������ʿ"]="wei shi",["������"]="li tiezui",["��������"]="jianghu langzi",["������"]="maimaiti",["�η�ͷ"]="jiaofu tou",["�Ƹ���"]="huang fuba",["������"]="Ren wuyue",["������"]="baozi wang",["����"]="a zi",["��Ԫ�"]="zhu yuanzhang",["ׯ�"]="zhuang zheng",["ҩ�̻��"]="huoji",["���ʤ"]="wu guangsheng",["ƽ����"]="ping popo",["������"]="fang tianlao",["����"]="bao xiang",["����"]="tie ren",["Ǯ�ཡ"]="qian qingjian",["����ɽ"]="shan jishan",["÷��"]="mei jian",["������ʦ"]="liaoming chanshi",["��Ȼ��"]="anran zi",["³�н�"]="lu youjiao",["Ԫʹ����"]="yuantong zunzhe",["�ξ�"]="luohan",["����"]="luohan",["����ʯ"]="bei haishi",["����"]="su pu",["��"]="mai jing",["��֪��"]="zhao zhiren",["½�˷�"]="lu chengfeng",["�仨"]="cui hua",["�·���"]="wen fangyi",["������"]="ding chunqiu",["������ʦ"]="chanshi",["�����"]="pan tiangeng",["���Ӹ��"]="gong zi",["���ϴ��"]="dadao",["�����"]="ban shuxian",["������ʦ"]="chanshi",["����"]="ding dang",["��Ī��"]="li mochou",["����"]="ding mian",["ѦĽ��"]="xue muhua",["������ʦ"]="da shi",["�ƹ��ϰ�"]="jiuguan laoban",["ƽһָ"]="ping yizhi",["���ϰ�"]="laoban",["½����"]="lu liding",["�嶾��Ů����"]="dizi",["����"]="you ji",["�������"]="men wei",["�����"]="luogu shou",["Ů����"]="nv dianzhu",["����"]="xiao feng",["��������"]="zunzhe",["��ͷ��"]="pang toutuo",["Ѧ��"]="xue zhu",["С��Ů"]="xiao longnv",["���"]="xu da",["�ο�"]="piao ke",["�Ǻ�"]="yi he",["������ʦ"]="liaoxing chanshi",["����ͷ"]="zong biaotou",["��������"]="zuofang zhuren",["��������"]="zunzhe",["����Сʦ̫"]="wen hui",["�����׶�"]="luyi tonger",["����ʩ"]="ji wushi",["������"]="chen xuanfeng",["���ȴ�ʦ"]="dashi",["����ү"]="long sanye",["�һ�"]="tao hua",["��ͯ"]="mutong",["���Զ�"]="wenwo er",["������"]="liang zhanglao",["��ʶ"]="luohan",["��֪"]="luohan",["ʷ��ǿ"]="shi jiqiang",["�˵�����"]="gong zi",["����ͷ��"]="yanshang",["�߸���"]="gao genming",["ˮ��"]="shui bing",["������"]="feitian zi",["��˪��"]="ling shuanghua",["�´��"]="zhang dafu",["������"]="zhe lemi",["���"]="xiang zhanglao",["��̶"]="wang tan",["¹�ȿ�"]="lu zhangke",["����"]="a xiang",["���ϰ�"]="laoban",["�ϰ�"]="lao ban",["�·���"]="wen fangwu",["������"]="chuchen zi",["�����ʦ"]="dashi",["����"]="shan yong",["ŷ���ϰ�"]="ouyang laoban",["������"]="chou songnian",["�����Ž���"]="jiao zhong",["�շ�ɮ"]="shaofan seng",["����÷"]="guan mingmei",["������ʦ"]="dashi",["˵����"]="shuoshu ren",["��Ա��"]="cui yuanwai",["��÷�"]="li caifeng",["������"]="hua hegen",["����Ӱ"]="Hua jianying",["������"]="ling zhentian",["ʨ����"]="shihou zi",["��Ħ��"]="nimo xing",["��մ�ʦ"]="dachi dashi",["���Ŵ�ʦ"]="dashi",["���ƹ�"]="zhanggui",["�ܲ�ͨ"]="zhou botong",["�ɶ�"]="du e",["������"]="duan zhengchun",["��һ��"]="gai yiming",["ʩ����"]="shi daizi",["������"]="huang lingtian",["�κ�"]="luohan",["���ޱ���"]="biqiu",["������ؤ"]="qigai",["ɳͨ��"]="sha tongtian",["��������"]="yuexia laoren",["������"]="xianshen",["�ⲻƽ"]="feng buping",["½����"]="lu dayou",["��ľ�����"]="jiao zhong",["����"]="chuan fu",["��Ů"]="shi nv",["�ϴ���"]="lao daniang",["��Ұ��"]="yin yewang",["��ף"]="miao zhu",["�Ӱ���"]="zhong asi",["����ɩ"]="zhong sisao",["��Ѹ"]="you xun",["ɮ��"]="seng ren",["����"]="a xiang",["�ٸ�ʿ��"]="guanfu shibing",["�����ʦ"]="benyin dashi",["��������"]="zunzhe",["˾����"]="sikong xuan",["����ʦ̫"]="jingxin shitai",["����"]="feng qi",["����"]="yi wen",["������"]="chang changfeng",["��ܽ"]="guo fu",["���ĵ�"]="lv wende",["���޼�"]="zhang wuji",["����"]="luohan",["����"]="yu ren",["����ʦ̫"]="jingdao shitai",["��һ��"]="fan yiweng",["����"]="jian ke",["������"]="cheng lingsu",["����"]="shan zheng",["׿����"]="zhuo bufan",["����ľ��"]="alamuhan",["�۹�����"]="zunzhe",["������"]="hou sanjie",["���ϰ�"]="laoban",["�Ƹ�"]="ya fu",["���Ӹ�"]="gongzi ge",["���ֲ���"]="heilin bofu",["���"]="da chou",["Ѳ����"]="xunbu wang",["Ԫ������"]="yuanshang zunzhe",["�в�ɮ"]="tuobo seng",["ƽ��"]="ping wei",["ʷ��ɽ"]="shi qingshan",["������ʦ"]="shenmi biaoshi",["������ʦ"]="liaoxiu chanshi",["����»"]="yin wulu",["�۽�����"]="zunzhe",["Ů��"]="girl",["��һ��"]="feng yiming",["������"]="xiaoxiang zi",["�����"]="shen qinggang",["����"]="a bi",["����ɮ��"]="bing",["��������"]="zongzan wangzi",["���帾Ů"]="woman",["������"]="yin tianzheng",["Ϸ��"]="xi zi",["�����"]="wu dapeng",["�ʱ���"]="gan baobao",["������"]="bei jinyi",["����ʦ̫"]="fengling shitai",["���ʦ̫"]="miejue shitai",["��ͬ"]="ding tong",["����"]="yin li",["������ɮ"]="wuming laoseng",["����"]="wu po",["С����"]="monk",["������"]="zhu wanli",["������"]="shen tiejiang",["������"]="xiang wentian",["����"]="shao gong",["ʦү"]="shi ye",["��ͯ"]="dao tong",["������"]="hu bayin",["ƽ��"]="ping si",["СѾ��"]="xiao yahuan",["������"]="zhou",["��ͯ"]="shi tong",["����ͬ"]="bao butong",["������"]="zuo lengchan",["�ź���"]="zhang haotian",["������"]="mengmian dadao",["��������"]="lingzhi shangren",["Ǯ�ϱ�"]="qian laoben",["����"]="zhong ling",["����ϼ"]="li mingxia",["������ʿ"]="wu shi",["������"]="li wenxiu",["лѷ"]="xie xun",["������"]="song qingshu",["��������"]="luoti nanzi",["�η�"]="jiao fu",["����"]="hua hui",["�ư�"]="yaba",["��ٹ���"]="gui ren",["����"]="xing zhe",["������"]="yuyin zi",["�����"]="mu nianci",["����ͷ"]="tufei tou",["���ɩ"]="li ersao",["���ƹ�"]="ma zhanggui",["����"]="jian zhanglao",["����"]="yang xiao",["ׯ��"]="zhuang jia",["������"]="liu haoyi",["ʷ��"]="shi song",["�����"]="gong guangjie",["������"]="chunyu lan",["����ʦ̫"]="dingjing shitai",["���Ů��"]="miaojia nuzi",["����"]="men zhu",["������ʿ"]="wei shi",["�츻"]="zhu fu",["�����ʦ"]="benxiang dashi",["����"]="kan shou",["���"]="yang guo",["����ʹ"]="liuyun shi",["ΤһЦ"]="wei yixiao",["��־"]="luohan",["�ɹ��"]="gan guanghao",["����С��"]="yizu xiaohuo",["���۽���"]="baipao jianxia",["������"]="lin yulong",["��������"]="xian sheng",["��ǫ"]="leng qian",["����"]="tang yang",["���"]="li gonggong",["����ɩ"]="aqing sao",["�Ů"]="bi nu",["����"]="ma zei",["������"]="wang chuzi",["���°���"]="bangzhong",["������"]="zhang sanfeng",["�ƹ���"]="tang guangxiong",["ʩ��"]="shi lang",["������ʦ"]="chanshi",["�����"]="lao xiucai",["�����"]="ma wude",["��ʦү"]="he shiye",["����"]="yi zhi",["�����"]="gao zecheng",["�佫"]="wu jiang",["��������"]="changan keshang",["������"]="zuo zimu",["���ϰ�"]="laoban",["������"]="gao laozhe",["Ե��"]="yuan gen",["����"]="er chou",["�ۺ�����"]="zunzhe",["���Ѵ�ʦ"]="dashi",
["��Х��"] = "wang xiaofeng",
["С����"] ="xiao lama",
["ʤ��"] = "sheng xiong",
["���"] = "miao ke",
["��ҩ����"] = "shishi lama",
["����"] = "miao di",
["��ɮ"] = "lao seng",
["����"] = "yangzong",
["׿��"] = "zhuoma",
["ˮ��"] = "shui sheng",
["½����"] ="lu tianshu",
["���з�"] = "liu chengfeng",
["ˮ�"] = "shui dai",
["�����"] = "jingxiang ke",
["��ľ��ʦ"] = "kumu dashi",
["��ľ��ʦ"] = "jiaomu dashi",
["¹����"] ="lu qingdu",
["������"]="ji qingxu",
["��������"]="jian gong",
["����"]="mian yang",
["��������"]="shi bing",
["��ţ"]="huang niu",
["����"]="nv gong",
["��ɣ��"]="nv gong",
["��ָ��ʷ"] = "fu zhihuishi",
["����"]="hou zi",
["����"]="qing wa",
["����"]="du she",
["�"]="yang kang",
["��־��"]="zhao zhijing",
["Ұ��"] ="ye tu",
["����"] ="song shu",
["��ҩ����"]="zhangyao daozhang",
["�ƾ�����"]="zhangjing daozhang",
["��СӨ"]="han xiaoying",
["���ݹ���"]="Huazheng",
["�����"]="ke zhene",
["����"]="gou du",
["�ϻ�"]="lao hu",
["����"]="xu zhu",
["̷����"]="tan chuduan",
["��־��"]="li zhichang",
["�𴦻�"]="qiu chuji",
["������"]="han baoju",
["ȫ��"]="quan jinfa",
["����"]="yi ren",
["ƽ�ܽ���"]="pingkou jiangjun",
["����"]="gou pu",
["���ｫ��"]="cheqi jiangjun",
["�۳彫��"]="zhechong jiangjun",
["��������"]="zhengdong jiangjun",
["���"]="jian jie",
["ɱ�ֵĵ���"]="statuary",
["����ĵ���"]="statuary",
["������"]="jinwei bing",
["�밢��"]="feng asan",
["��������"]="yanxiao",
["����һ"]="wang chuyi",
["��԰����"]="zhangyuan daozhang",
["������"]="liu chuxuan",
["����"]="shu chi",
["������"]="kang guangling",
["���Ǻ�"]="su xinghe",
["����"]="tuo lei",
["��ľ��"]="tiemuzhen",
["������"]="jinwei bing",
["��Ȯ"]="dog",
["���̨"]="cha hetai",
["���"]="zhu cong",
["�𹤵���"]="huogong daoren",
["��־��"]="qi zhicheng",
["��־��"]="cui zhifang",
["�������"]="zhangli daozhang",
["�´�ͨ"]="hao datong",
["��־��"]="shen zhifan",
["���ϰ�"]="xu laoban",
["��־ƽ"]="yin zhiping",
["�ﲻ��"]="sun buer",
["��־̹"]="wang zhitan",
["��Ƽ"]="li ping",
["��Х��"]="guo xiaotian",
["Ұ��"]="ye zhu",
["���"]="shen diao",
["�̵���"]="cai dezhong",
["��־��"]="fang zhiqi",
["��ϣ��"]="nan xiren",
["�Ű���"]="zhang asheng",
["������"]="boer shu",
["�۷�"]="bee",
}