jobSpecial = jobSpecial or {}
job.list["qzjx"] = "ȫ�����"
jobCond = jobCond or {}
jobCond["qzjx"] = function() if job.last~="qzjx" and (not condition["ִ��ȫ���������"] or (condition["ִ��ȫ���������"] and condition["ִ��ȫ���������"]==0) or (condition["����æ״̬"] and condition["ִ��ȫ���������"] and condition["ִ��ȫ���������"]<=condition["����æ״̬"])) then return true else return false end end
joblast = joblast or {}
joblast["ȫ�����"] = "qzjx"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["qzjx"] = "qzjxTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["qzjx"] = "qzjxFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["qzjx"] = "qzjxFindFail"
faintFunc = faintFunc or {}
faintFunc["qzjx"] = "qzjxFaint"
qzjxIgnoresskill = {
  --  ["̫��ȭ"] = true,
  --  ["��а����"] = true,
--	["�������"] = true,
 --   ["̫������"]   = true,
    -- ["�򹷰���"] = true,
}

--��ִ��ȫ�������������

function qzjxTrigger()
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",false)
    DeleteTriggerGroup("qzjxAsk") 
    create_trigger_t('qzjxAsk1',"^(> )*�����𴦻������й�",'','qzjxAsk')
    create_trigger_t('qzjxAsk2',"^(> )*����û������ˡ�$",'','qzjxNobody')
	create_trigger_t('qzjxAsk3',"^(> )*������е�ʲô���Ծ�, ������ȴ˵������",'','qzjxNobody')
    SetTriggerOption("qzjxAsk1","group","qzjxAsk")
    SetTriggerOption("qzjxAsk2","group","qzjxAsk")
	SetTriggerOption("qzjxAsk3","group","qzjxAsk")
    EnableTriggerGroup("qzjxAsk",false)
    DeleteTriggerGroup("qzjxAccept")
	create_trigger_t('qzjxAccept1',"^(> )*�𴦻�����˵�����������зɸ봫���֪��(\\D*)Ӧ����(\\D*)һ���������ȥ������ȥ��",'','qzjxConsider')
    create_trigger_t('qzjxAccept3',"^(> )*�𴦻�(����|)˵������"..score.name..",��(|����ִ��׷ɱ�����ϸ��������һ������û�����)",'','qzjxFangqi')
    create_trigger_t('qzjxAccept4',"^(> )*�𴦻�(����|)˵������"..score.name..",����������æ�У���������Ϣһ��ɡ���",'','qzjxFail')
    create_trigger_t('qzjxAccept5',"^(> )*�𴦻�(����|)˵������"..score.name..",��ս���ȫ����飬��������Ϣһ��ɡ���",'','qzjxFail')
    create_trigger_t('qzjxAccept6',"^(> )*�𴦻�(����|)˵��\\D*�㵽��Ϲ�ܣ�ʲô��û�ɳ�",'','qzjxFinish')
    create_trigger_t('qzjxAccept7',"^(> )*������е�ʲô���Ծ�, ������ȴ˵������",'','qzjxNobody')
	create_trigger_t('qzjxAccept14',"^(> )*�𴦻�(����|)˵������������æ�������������أ�",'','qzjxFail')
    EnableTriggerGroup("qzjxAccept",false)
    SetTriggerOption("qzjxAccept1","group","qzjxAccept")
    SetTriggerOption("qzjxAccept3","group","qzjxAccept")
    SetTriggerOption("qzjxAccept4","group","qzjxAccept")
    SetTriggerOption("qzjxAccept5","group","qzjxAccept")--������ִ��׷ɱ�����ϸ������,Ϊɶ���Ͽ�ȥ����
    SetTriggerOption("qzjxAccept6","group","qzjxAccept")
    SetTriggerOption("qzjxAccept7","group","qzjxAccept")
	SetTriggerOption("qzjxAccept14","group","qzjxAccept")
    EnableTriggerGroup("qzjxAccept",false)
    DeleteTriggerGroup("qzjxFight")
    create_trigger_t('qzjxFight1','^(> )*(\\D*)��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�','','qzjxDie')
    create_trigger_t('qzjxFight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','qzjxNFaint')
    create_trigger_tc('qzjxFight3',"^(> )*���˿���ȥʦ��(\\D*)���ó�ʹ��(\\D*)�˵У�",'','qzjxescap')
	create_trigger_tc('qzjxFight4',"^(> )*���̲�ס��ݺ���(kick)����һ�һ�š�",'','qzjxnofight')          
    create_trigger_t('qzjxFight5','^(> )*(\\D*)(���ﲻ׼ս����|����Ҫ��������)','','qzjxnofight')   
    create_trigger_t('qzjxFight6','^(> )*��Ҫ��˭�����������','','qzjxfightnobody')    
    SetTriggerOption("qzjxFight1","group","qzjxFight")
    SetTriggerOption("qzjxFight2","group","qzjxFight")
    SetTriggerOption("qzjxFight3","group","qzjxFight")
    SetTriggerOption("qzjxFight4","group","qzjxFight")
    SetTriggerOption("qzjxFight5","group","qzjxFight")
    SetTriggerOption("qzjxFight6","group","qzjxFight")    
    EnableTriggerGroup("qzjxFight",false) 
    DeleteTriggerGroup("qzjxCut")
    create_trigger_t('qzjxCut1','^(> )*���(\\D*)��ʬ�������ѳ�һ�������','','qzjxCutCon')
    create_trigger_tc('qzjxCut3',"^(> )*(\\D*)��ʬ��\\(Corpse\\)",'','qzjxDie') 
    SetTriggerOption("qzjxCut1","group","qzjxCut") 
    SetTriggerOption("qzjxCut3","group","qzjxCut")
    EnableTriggerGroup("qzjxCut",false)
    DeleteTriggerGroup("qzjxGive")
    create_trigger_t('qzjxGive1','^(> )*�𴦻������㡸����������Ц������','','qzjxFinish')
	create_trigger_t('qzjxGive2',"^(> )*������е�ʲô���Ծ�, ������ȴ˵������",'','qzjxBUG')	
    SetTriggerOption("qzjxGive1","group","qzjxGive")
	SetTriggerOption("qzjxGive2","group","qzjxGive")
    EnableTriggerGroup("qzjxGive",false)
    DeleteTriggerGroup("qzjxHead")
    create_trigger_t('qzjxHead1','^(> )*����һ��(\\D*)��(�׼�|��ͷ)','','qzjxHeadCheck')
    create_trigger_t('qzjxHead2','^(> )*��� "action" �趨Ϊ "check_ling" �ɹ���ɡ�','','qzjxHeadCon')
    create_trigger_t('qzjxHead3','^(> )*(\\D*)�ĵ�ʬ��\\(Corpse\\)','','qzjxHeadCheck')
    SetTriggerOption("qzjxHead1","group","qzjxHead")
    SetTriggerOption("qzjxHead2","group","qzjxHead")
    SetTriggerOption("qzjxHead3","group","qzjxHead")
    EnableTriggerGroup("qzjxHead",false)
    DeleteTriggerGroup("qzjxFinish")
    create_trigger_t('qzjxFinish1','^(> )*�𴦻���������������ͷ��','','qzjxFinishCheck')
    create_trigger_t('qzjxFinish2',"^(> )*������е�ʲô���Ծ�, ������ȴ˵������",'','qzjxBUG')
    SetTriggerOption("qzjxFinish1","group","qzjxFinish")
	SetTriggerOption("qzjxFinish2","group","qzjxFinish")
    EnableTriggerGroup("qzjxFinish",false)
end
function qzjxBUG()
    messageShow('ȫ���ϸ�������������ֳ�BUG����������������!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!��')
end

function qzjxTriggerDel()
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",false)
    EnableTriggerGroup("qzjxFight",false)
    EnableTriggerGroup("qzjxFind",false)
    EnableTriggerGroup("qzjxCut",false)
    EnableTriggerGroup("qzjxGive",false)
    EnableTriggerGroup("qzjxHead",false)
    EnableTriggerGroup("qzjxFinish",false)
	EnableTriggerGroup("checkroom",false)
    DeleteTriggerGroup("qzjxAsk")
    DeleteTriggerGroup("qzjxAccept")
    DeleteTriggerGroup("qzjxFight")
    DeleteTriggerGroup("qzjxFind")
    DeleteTriggerGroup("qzjxCut")
    DeleteTriggerGroup("qzjxGive")
    DeleteTriggerGroup("qzjxHead")
    DeleteTriggerGroup("qzjxFinish")
	DeleteTriggerGroup("checkroom")
end
function qzjxNobody()
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",false)	
	messageShow('ȫ���ϸ�������������ֳ�BUG����������������!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
    return check_heal()
end
function qzjx()
    jobTriggerDel() 
    job.name='qzjx'
    job.time.b=os.time()
    job.time.sf=os.time()
    job.progress=0 
	flag.idleEND = 8
	flag.idle=0
    if GetVariable("performpre") then
        perform.pre=GetVariable("performpre")    
        create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
        exe('pfmset')
        exe('set wimpy 100;yield no;time')
        exe('set wimpycmd pfmpfm\\hp')
    end  	
    return qzjxGo()
end
function qzjxGo()
    return go(qzjxStart,'ȫ��','�Ͼ���')
end
function qzjxStart()
    job.qzjx=0  
	qzjxTrigger()
	create_timer_s('fxasktimer',5,'qzjx')
    EnableTriggerGroup("qzjxAsk",true)
    exe('time;askk qiu chuji about ȫ�����')
end
function qzjxAsk()
    DeleteTimer("fxasktimer")
    EnableTriggerGroup("qzjxFight",false)
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",true)
end
function qzjxBusy()    
    exe('jobtimes;hp;time')
	return go(check_heal,'��ɽ','��ȪԺ')
end

function qzjxBusyDazuo()
    DeleteTimer("fxasktimer")
    prepare_lianxi(qzjxStart)
end
function qzjxFail()
    EnableTriggerGroup("qzjxAccept",false)
    job.last='qzjx'
	exe('jobtimes;cond')
	return go(check_heal,'��ɽ','��ȪԺ')
end

function qzjxConsider(n,l,w)
    job.target='';
    job.last='qzjx'
    job.qzjx=0
    print(Trim(w[2])) --name
    if GetVariable("performpreB") then
        perform.pre=GetVariable("performpreB")
        create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
        exe('pfmset') 
        exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
    end     
    job.where=Trim(w[3])
	EnableTriggerGroup("qzjxAccept",false)  -- ain
    
    job.id="test1"
   

    job.target=Trim(w[2])
    job.id=get_id(job.target)
    job.id=Trim(w[3])
    print("�Զ���ȡNPC id��"..job.id)	
    job.killer={}
    job.killer[job.target]=true  
    print ("address:" ..job.where)
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.area=job.area
    dest.room=job.room
   
	
    if not job.room or not path_cal() then
        messageShow('ȫ����飺����ص㡾'..job.where..'�����ɵ�����������')
        return qzjxFangqi()
    else 
        messageShow('ȫ����飺��ʼǰ����'..job.where..'���ҡ�'..job.target..'����')
    end    
    EnableTrigger("qzjxFind1",true)
  	flag.idle=0
    return check_bei(qzjxFind) 
end

function qzjxNpc(n,l,w)
    EnableTriggerGroup("qzjxAccept",false)  -- ain
    
    job.id="test1"
    DeleteTimer("fxasktimer")
    job.target=Trim(w[2])
	job.id=get_id(job.target)
	job.id=Trim(w[3])
	print("�Զ���ȡNPC id��"..job.id)	
    job.killer={}
    print ("address:" ..job.where)
    job.where=addrTrim(job.where)
    job.area="ȫ��ɽ"
    job.room=job.where
    dest.room=job.room
    dest.area="ȫ��ɽ"
    print(job.area)
    print (job.room) 
    print(dest.area)
    print (dest.room)
    if not job.room then
        messageShow('ȫ����飺����ص㡾'..job.where..'�����ɵ�����������')
        return qzjxFangqi()
    else 
        messageShow('ȫ����飺��ʼǰ����'..job.where..'��ɱ��'..job.target..'����')
    end    
    EnableTrigger("qzjxFind1",true)
  	flag.idle=0
    return check_bei(qzjxFind) 
end

function qzjxFangqiGo()
    EnableTriggerGroup("qzjxFind",false)
    DeleteTimer("fxasktimer")
    DeleteTimer("qzjx")
    DeleteTimer("perform")
    EnableTriggerGroup("qzjxFight",false)
    locate()
    --flag.idle=4
    return go(qzjxFangqi,"ȫ��","�Ͼ���")
end
function qzjxFangqi()
    EnableTriggerGroup("qzjxAsk",true)
    return check_bei(qzjxFangqiAsk)
end
function qzjxFangqiAsk()
    EnableTriggerGroup("qzjxAccept",false)
    job.progress=0 -- ain add
    exe('hp;cond;drop ling;askk qiu chuji about ����;hp')
	--flag.idle=0
	return check_heal()
end
function qzjxFind()
    EnableTriggerGroup("qzjxFind",false)
    DeleteTriggerGroup("qzjxFind")
    create_trigger_t('qzjxFind2','^(> )*(\\D*)�੹�Ц���ϣ���Ȼ�����ˣ��Ǿ��������ɣ�','','qzjxTarget2')
	create_trigger_t('qzjxFind3','^(> )*'..job.target..'��(\\D*)�뿪','','qzjxfightnobody') 
	create_trigger_t('qzjxFin5','^(> )*�������'..score.name..'Ҫ׷ɱ�Ľ����ϸ!','','qzjxTarget3')
	create_trigger_t('qzjxFin6','^(> )*�����Ȼһ�ѽ������ϵ�������͵�ߣ�Ȼ���������֣�ԭ��������Ҫ׷ɱ�Ľ����϶��','','qzjxstop')
    SetTriggerOption("qzjxFind1","group","qzjxFind")
    SetTriggerOption("qzjxFind2","group","qzjxFind")
	SetTriggerOption("qzjxFind3","group","qzjxFind")
	SetTriggerOption("qzjxFind6","group","qzjxFind")
    EnableTriggerGroup("qzjxFind",true)  
    flag.idle=0
    fight_prepare()
    return go(qzjxFindAct,job.area,job.room)  
end
function qzjxstop()
    flag.wait=1
    flag.find=1
    dis_all()
    
    EnableTriggerGroup("qzjxFind",true)  
    exe('say ͣ���Ҽ�ϸ')
    messageShow('ȫ����飺���Ʊ������ˣ����ֿ��ɷ��䣬ͣ�µ���')
    checkRoom()
end
function qzjxfightnobody()  --ƨ��
    dis_all()
    messageShow('ȫ����飺NPC�뿪��,����Ѱ�ҡ�'.. job.target ..'����')
    print('NPC�뿪��,����Ѱ�ң�')
 
    EnableTriggerGroup("qzjxFind",false)
    DeleteTriggerGroup("qzjxFind")
    create_trigger_t('qzjxFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','qzjxTarget1')
  --  create_trigger_t('qzjxFind2','^(> )*'..job.target..'�����㷢��һ����Ц��˵��','','qzjxTarget2')
--	create_trigger_t('qzjxFind3','^(> )*'..job.target..'��(\\D*)�뿪','','qzjxfightnobody')  
 --   create_trigger_t('qzjxFind4','^(> )*'..job.target..'˵��������һֱ������ô���죬��Ȼ�������㣬��ү����ͳ����㣡','','qzjxTarget2')		
    SetTriggerOption("qzjxFind1","group","qzjxFind")
--	SetTriggerOption("qzjxFind2","group","qzjxFind")
--	SetTriggerOption("qzjxFind3","group","qzjxFind")
--	SetTriggerOption("qzjxFind4","group","qzjxFind")	
	
    EnableTrigger("qzjxFind",true)
    flag.idle=0
	--exe('unset wimpy')
    return check_bei(qzjxFindAct)
end
function qzjxnofight()
    messageShow('��ս�����䣬Ƶ��ɧ�š�'.. job.target ..'����')
    exe('kick '..job.id)
    job.time.f=os.time()    
    create_timer_s('qzjxkick',2,'qzjxMove')

end
function qzjxMove()
--    EnableTriggerGroup("qzjxFight",false)
    DeleteTimer("qzjxkick")
--	if job.id then
	   exe('follow '..job.id)
	   exe('kick '..job.id)
	   exe('kill '..job.id)
 --          killPfm(job.id)
--	end
--    exe(locl.dir)
--    qzjxFind()
end
function qzjxFindAgain()
    EnableTriggerGroup("qzjxFind",false)
    return go(qzjxFindAct,job.area,job.room)
end
function qzjxFindFail()
    EnableTriggerGroup("qzjxFind",false)
    return qzjxFangqiGo()
end
function qzjxFaint()
     flag.idle=0
   if job.progress==3 then  
	      return qzjxBack() 
   elseif job.progress ~=1 then
          return qzjxFind()
    else
    	 return qzjxFangqiGo()      	
   end 
end
function qzjxFindAct()
    		EnableTriggerGroup("qzjxFind",true)
    		job.flag()
				weapon_wield()
			--checkRoom()
			
    		find()
			EnableTriggerGroup("qzjxFight",true)
    		messageShow('ȫ����飺��ʼѰ�ҡ�'..dest.area .. dest.room ..'����'..'��'.. job.target ..'����')
	
end
function qzjxTarget1(n,l,w)
    thread_resume(lookfor)
--    exe('ask '..job.id..' about name')
    EnableTriggerGroup("qzjxFind",false)
	EnableTrigger("qzjxFind2",true)
--	dis_all()
	EnableTriggerGroup("checkroom",false)
    EnableTriggerGroup("qzjxFight",true)
    job.progress=1 
	job.qzjx=1
    flag.wait=1
    flag.find=1
	flag.idle=0
--	qzjx_flag='bad';
--print(job.target)

   --job.target=Trim(w[2])
   

	--job.id=get_id(job.target)
	--print(job.target);
	print('t1 '..job.id);
	exe('set wimpy 100;kick '..job.id)

      messageShow('ȫ����飺�ҵ���'.. job.target ..'����')
     -- exe('set wimpy 100;kill '..job.id)
	 -- exe('follow '..job.id) 
     messageShow('ȫ����飺��ʼ�롾'.. job.target ..'��ս����')
--      exe('l '..job.id)
	exe('kill '..job.id)   
	print('kill '..job.id)
	 messageShow('ȫ����飺��ɱ��'.. job.target ..'��ս����')
end

function qzjxTarget2(n,l,w)
DeleteTimer('checkroom')
 l_i=0
    EnableTriggerGroup("qzjxFind",false)
	thread_resume(lookfor)
--	dis_all()
    EnableTriggerGroup("qzjxFight",true)
    job.progress=1 
	job.qzjx=1
    flag.wait=0
    flag.find=1
	flag.idle=0
    thread_resume(lookfor)
    
	job.target=Trim(w[2]);
	job.id=get_id(job.target)
	messageShow('ȫ����飺��ʼɱ��'.. job.target ..'����')
	exe('poke '..job.id)
      exe('set wimpy 100;kill '..job.id)
end

function qzjxFollow(n,l,w)
    if job.target==w[2] then
       job.qzjx=2
	     Qingok=1
	     flag.idle=1
	     job.progress=3 
	     return qzjxBack()
	  end
end

function qzjxDie(n,l,w)
       job.time.ef=os.time()  
       job.time.ff=job.time.ef-job.time.sf  
    job.qzjx=2
    if job.target==w[2] then     
          job.progress=2 
          job.qzjx=2  
          print("qzjx job ɱ�˳ɹ�!")
		  dis_all()
		  flag.idle=0
          DeleteTimer("perform")
		  messageShow('ȫ����飺�Ѿ��ɵ��ˡ�'.. job.target ..'����'..'��ʱ:��'..job.time.ff..'����')
          check_halt(qzjxCut)
     
    end
end
function qzjxCut()
     EnableTriggerGroup("qzjxFight",false)
     EnableTriggerGroup("qzjxCut",true)
	      for i=1,3 do
           exe('get chongyang ling from corpse '..i) 
         end  
		 exe('get gold from corpse;get silver from corpse') 
end
function qzjxCut2()
    EnableTriggerGroup("qzjxFight",false)
    EnableTriggerGroup("qzjxCut",true)
	   for i=1,3 do
           exe('get chongyang ling from corpse '..i)    
       end 
	   exe('get gold from corpse;get silver from corpse') 
end

function qzjxCutWeapon()
    EnableTriggerGroup("qzjxCut",false)
    checkWait(qzjxCut,1)
end
function qzjxCutCon(n,l,w)
    EnableTriggerGroup("qzjxCut",false)
    if job.target~=tostring(w[2]) then
       exe('drop head')
       check_bei(qzjxCut)
    else
       job.progress=3
	  -- exe('unwield mu jian;unwield changjian')
       return qzjxBack()
    end
end
function qzjx_get_con(n,l,w) 
		 if job.target==tostring(w[2]) then
         EnableTriggerGroup("qzjxCut",false)
		     return qzjxBack()
 		 else
  			 exe('drop corpse')
   			   EnableTriggerGroup("qzjxFight",false)
          EnableTriggerGroup("qzjxCut",true)
	       weaponWieldCut()
	       
	     wait.make(function()
	      wait.time(1.5)
	       for i=1,3 do
           exe('qie corpse '..i)
    
         end 
     end)
   		end	 
end
function qzjx_get_act1()
  --   EnableTriggerGroup("qzjx",true)
    DeleteTriggerGroup("hs_get")
    create_trigger_t('hs_get1','^(> )*(���컯�յ������ٰ�|\\D*��ʬ��������̫����)','','huashan_get_next')
    SetTriggerOption("hs_get1","group","hs_get")
	tmp.hscorpsecnt=1
	tmp.hsgettimes=1
	exe('get corpse')
end

function qzjxLost(n,l,w)
    if job.id==Trim(w[2]) then
       dis_all()
       return qzjxFind()
    end
end
function qzjxBckCheck(n,l,w)
    if job.target==w[2] then
       qzjxBack()
    end
end
function qzjxBack()
    DeleteTimer("qzjx")
    DeleteTimer("perform")
    EnableTriggerGroup("qzjxFight",false)
    EnableTriggerGroup("qzjxFinish",true)
    messageShow('ȫ����飺�㶨�ˣ�������')
    exe('say ȫ����飺�㶨�ˣ�������')
    go(qzjxHead,'ȫ��','�Ͼ���')
end
function qzjxHead()
 if not locl.id["�𴦻�"] then  
    checkWait(qzjxBack,2)
 else
       EnableTriggerGroup("qzjxHead",true)
       tmp.flag=0
       exe('alias action check_ling')

 end
end
function qzjxHeadCheck(n,l,w)
    if w[2] == job.target then
       tmp.flag=1
    end
end
function qzjxHeadCon()
    EnableTriggerGroup("qzjxHead",false)
    if tmp.flag==1 then
       return qzjxGive()
    else
       return qzjxFinish()
    end
end
function qzjxGive()
    EnableTriggerGroup("qzjxGive",true)
	--exe ('qie corpse')
    exe('give ling to qiu chuji')
	--exe('drop head')	
end
function qzjxFinishWait()
    if cntr1()>1 then
       return qzjxFinish()
    else
       exe('s;n')
       checkWait(qzjxFinishWait,1)
    end
end
function qzjxFinishCheck(n,l,w)
    if w[2]==job.target then
       return qzjxFinish()
    end
end
function qzjxFinish()
    EnableTriggerGroup("qzjxFight",false)	
	exe('give ling to qiu chuji;')
    messageShow('ȫ����飺������ɣ�')
	local l_time=os.time()-job.time.b
    local l_hour=math.modf(l_time/3600)
    local l_min=math.modf((l_time-l_hour*3600)/60)
    local l_sec=l_time-l_hour*3600-l_min*60
    messageShow('ȫ���������������ɣ�(��ʱ:'..l_min ..'��'..l_sec..'��)')
    job.last='qzjx'
    job.progress=0
	--flag.idle=0
    qzjxTriggerDel()
--    return checkWait(check_heal,1)
	--return go(check_heal,'ȫ��','�̱�')
    return check_heal()
end
function qzjxescap(n,l,w)
job.progress=1  
local npcskills=w[3]
print(npcskills)
 messageShow('ȫ�������ϸ��'.. job.target ..'���书�ǡ�'.. npcskills ..'����')
end

function checkRoomStart()
   EnableTriggerGroup("checkroom",true)
end
 
function checkRoom()
   DeleteTriggerGroup("checkroom")
   create_trigger_t('checkroom1',"^(> )*�����������, ���Ｐ��Ʒ��(Ӣ��)�������£�",'','checkRoomStart')
   create_trigger_t('checkroom2',"^(> )*(\\D*) = (\\D*)$",'','checkRoomId')
   create_trigger_t('checkroom3','^(> )*(\\D*)�������'..score.name..'Ҫ׷ɱ�Ľ����ϸ!','','killqzjx')
   --����һλ���ǿ����׳���ʿ���ƺ������ա�
   --������Һ������Ҫ׷ɱ�Ľ����ϸ!
  -- create_trigger_t('checkroom3','^(> )*����һλ���ǿ����׳���ʿ���ƺ������ա�','','killqzjx')
 --  create_trigger_t('checkroom5','^(> )*��� "action" �趨Ϊ "check room over" �ɹ���ɡ�$','','checkRoomOver')
   --[[
   ������(Gongxi zan)
���˾������պ����ɵ���ԭ�ĺ��»�������������������ʹ����
������Һ������Ҫ׷ɱ�Ľ����ϸ!
   --]]
   SetTriggerOption("checkroom1","group","bags")
   SetTriggerOption("checkroom2","group","bags")
   SetTriggerOption("checkroom3","group","bags")
 --  SetTriggerOption("checkroom5","group","bags")
 
 
   EnableTriggerGroup("checkroom",false)
   EnableTrigger("checkroom1",true)
   EnableTrigger("checkroom2",true)
  --������Һ������Ҫ׷ɱ�Ľ����ϸ!
  RoomName={}
  Roomqzjx={}

  l_i=0
   exe('id here')
  -- checkWield()
  
    create_timer_s('checkroom',1,'checkRoomOver')
end
function checkRoomOver()
	--exe('alias action check room over')
	print('over')
	qzjxjob={}
	qzjxjob.id={}
	
	--for k,v in ipairs(RoomName) do
	--print(k)
	
	local l_b=1
	l_c=''
	
	--print(RoomName[l_id])
	l_c=l_i+l_b
	
	print(l_c)
	
	l_i=l_c
	if(RoomName[l_c]) then
	exe('look '..RoomName[l_c])
	--if qzjx_flag == 'bad' then
	qzjxjob.id=RoomName[l_c]
	exe('kick '..qzjxjob.id)
	end
	--end
	--end
end
function checkRoomId(n,l,w)
   local l_name=Trim(w[2])
   --local l_qzjxid
   local l_id=Trim(w[3])
   local l_set={}
   
  -- RoomName.id={}
   --RoomName.name={}
  -- qzjx_flag='good'
  --������Һ������Ҫ׷ɱ�Ľ����ϸ!
  
  if string.find(l_id,",") then
  print('==')
	print(l_name)
	if( l_name =='ͭǮ' or l_name =='����' or  l_name =='�ƽ�' or  l_name =='����' or  l_name =='�ֵ�' or  l_name =='����'  
	or  l_name =='ҹ����'   or  l_name =='���Ǵ�' or l_name=='��ɱذ��' or l_name=='�ɻ�ʯ' or l_name=='������' or l_name=='�ݸɵĺ���'
	or l_name=='�ָ�' or l_name=='���ѩ�轣' or l_name =='�����滨��' or l_name =='������' or l_name =='ѩ�鵶'  or l_name =='���߽�' 
	or l_name =='ɥ�Ŷ�' or l_name =='�����' or l_name =='��ü��' or l_name =='���ô�' or l_name =='�ٱ�ذ��' or l_name =='����'
	or l_name =='�����' or l_name =='��������' or l_name =='����' or l_name =='����'  or l_name=='�йٱ�' or l_name=='ľ��' or l_name=='����'
	or l_name=='���' or l_name=='��ǹ' or l_name=='��' or l_name=='˦��' or l_name=='ʯ��' or l_name=='������' or l_name=='��������'
	or l_name=='���õ�Ůʬ' or l_name=='���õ���ʬ' or l_name=='����' or l_name=='��Ѳ��') then
		print('���� �·� ���� ������')
	else
	
	l_qzjxid=filter_npcid(l_name);
	
	if not Roomqzjx[l_id] then
      Roomqzjx[l_id]={}
	end
	
	if l_qzjxid=='���ǳ���NPC' then
		if not string.find(l_id,"'") then
		if string.find(l_id,",") then
			l_set=utils.split(l_id,',')
			
			l_id=l_set[1]
			if  l_id =='corpse' or l_id =='wu jiang' or l_id =='shi bing' or l_id =='nil' or l_id=='bang zhong' or l_id=='nv jiaozhong' then 
				
			else
			
			
			 
			
			
				
				 --RoomName=l_id
				
				 table.insert(RoomName,l_id)
				 Roomqzjx[l_id]=l_name
				 -- table.insert(RoomName.name,l_name)
				-- table.insert(RoomName,l_id)
				 --table.insert(RoomName.name,l_name)
				print('��������id �Ѽ����')
				 -- exe('look '..l_id)
				  
				
				 
				
			end
		end
		end
	end
	end
	print('==')
	
	
  end
	
	--[[
	checkid={}
    if not checkid[l_name] then
      checkid[l_name]={}
   end
   checkid[l_name].id={}
   if string.find(l_id,",") then
      l_set=utils.split(l_id,',')
      l_id=l_set[1]
      for k,v in ipairs(l_set) do
         
		  checkid[l_name].id[Trim(v)]=true
	     
      end
   else
      checkid[l_name].id[Trim(l_id)]=true
     
      checkid[l_name].fullid=Trim(l_id)
   end
   --]]
end
function filter_npcid(name)--���˳���npc��id
	local id=""
	--local f=f or 0 
	if data_system_npc[name] then--ϵͳnpc
		id=data_system_npc[name]
	
	end
	if id =='' then
		return '���ǳ���NPC'
	else
		return '����'
	end
end
function killqzjx()
l_i=0
DeleteTimer('checkroom')
	 EnableTriggerGroup("findqzjxnpc",false)
	 EnableTriggerGroup("checkroom",false)
	  EnableTriggerGroup("qzjxFight",true)
	job.target=Roomqzjx[qzjxjob.id]
	print('test')
	print(qzjxjob.id)
	messageShow('ȫ���ϸ�����ּ�ϸ ��Id�� ��'..qzjxjob.id..'�� ���ֽ�  ��'..Roomqzjx[qzjxjob.id]..'��' )
	messageShow('kill '..qzjxjob.id)
	exe('set wimpy 100;kill '..qzjxjob.id)
end