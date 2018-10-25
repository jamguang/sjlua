jobSpecial = jobSpecial or {}
job.list["qzjx"] = "全真锄奸"
jobCond = jobCond or {}
jobCond["qzjx"] = function() if job.last~="qzjx" and (not condition["执行全真锄奸任务"] or (condition["执行全真锄奸任务"] and condition["执行全真锄奸任务"]==0) or (condition["任务繁忙状态"] and condition["执行全真锄奸任务"] and condition["执行全真锄奸任务"]<=condition["任务繁忙状态"])) then return true else return false end end
joblast = joblast or {}
joblast["全真锄奸"] = "qzjx"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["qzjx"] = "qzjxTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["qzjx"] = "qzjxFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["qzjx"] = "qzjxFindFail"
faintFunc = faintFunc or {}
faintFunc["qzjx"] = "qzjxFaint"
qzjxIgnoresskill = {
  --  ["太极拳"] = true,
  --  ["辟邪剑法"] = true,
--	["少林醉棍"] = true,
 --   ["太极剑法"]   = true,
    -- ["打狗棒法"] = true,
}

--│执行全真锄奸任务三分

function qzjxTrigger()
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",false)
    DeleteTriggerGroup("qzjxAsk") 
    create_trigger_t('qzjxAsk1',"^(> )*你向丘处机打听有关",'','qzjxAsk')
    create_trigger_t('qzjxAsk2',"^(> )*这里没有这个人。$",'','qzjxNobody')
	create_trigger_t('qzjxAsk3',"^(> )*你觉得有点什么不对劲, 可是你却说不上来",'','qzjxNobody')
    SetTriggerOption("qzjxAsk1","group","qzjxAsk")
    SetTriggerOption("qzjxAsk2","group","qzjxAsk")
	SetTriggerOption("qzjxAsk3","group","qzjxAsk")
    EnableTriggerGroup("qzjxAsk",false)
    DeleteTriggerGroup("qzjxAccept")
	create_trigger_t('qzjxAccept1',"^(> )*丘处机对你说道，“据门中飞鸽传书得知，(\\D*)应该在(\\D*)一带活动，你速去将他除去！",'','qzjxConsider')
    create_trigger_t('qzjxAccept3',"^(> )*丘处机(对你|)说道：「"..score.name..",你(|正在执行追杀金国奸细任务中上一次任务还没完成呢)",'','qzjxFangqi')
    create_trigger_t('qzjxAccept4',"^(> )*丘处机(对你|)说道：「"..score.name..",你正在任务繁忙中，还是先休息一会吧。」",'','qzjxFail')
    create_trigger_t('qzjxAccept5',"^(> )*丘处机(对你|)说道：「"..score.name..",你刚结束全真锄奸，还是先休息一会吧。」",'','qzjxFail')
    create_trigger_t('qzjxAccept6',"^(> )*丘处机(对你|)说道\\D*你到处瞎跑，什么都没干成",'','qzjxFinish')
    create_trigger_t('qzjxAccept7',"^(> )*你觉得有点什么不对劲, 可是你却说不上来",'','qzjxNobody')
	create_trigger_t('qzjxAccept14',"^(> )*丘处机(对你|)说道：你现在正忙着做其他任务呢！",'','qzjxFail')
    EnableTriggerGroup("qzjxAccept",false)
    SetTriggerOption("qzjxAccept1","group","qzjxAccept")
    SetTriggerOption("qzjxAccept3","group","qzjxAccept")
    SetTriggerOption("qzjxAccept4","group","qzjxAccept")
    SetTriggerOption("qzjxAccept5","group","qzjxAccept")--你正在执行追杀金国奸细任务中,为啥不赶快去？」
    SetTriggerOption("qzjxAccept6","group","qzjxAccept")
    SetTriggerOption("qzjxAccept7","group","qzjxAccept")
	SetTriggerOption("qzjxAccept14","group","qzjxAccept")
    EnableTriggerGroup("qzjxAccept",false)
    DeleteTriggerGroup("qzjxFight")
    create_trigger_t('qzjxFight1','^(> )*(\\D*)「啪」的一声倒在地上，挣扎着抽动了几下就死了。','','qzjxDie')
    create_trigger_t('qzjxFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','qzjxNFaint')
    create_trigger_tc('qzjxFight3',"^(> )*此人看上去师承(\\D*)，擅长使用(\\D*)伤敌！",'','qzjxescap')
	create_trigger_tc('qzjxFight4',"^(> )*你忍不住想狠狠踢(kick)这个家伙一脚。",'','qzjxnofight')          
    create_trigger_t('qzjxFight5','^(> )*(\\D*)(这里不准战斗。|你正要有所动作)','','qzjxnofight')   
    create_trigger_t('qzjxFight6','^(> )*你要对谁做这个动作？','','qzjxfightnobody')    
    SetTriggerOption("qzjxFight1","group","qzjxFight")
    SetTriggerOption("qzjxFight2","group","qzjxFight")
    SetTriggerOption("qzjxFight3","group","qzjxFight")
    SetTriggerOption("qzjxFight4","group","qzjxFight")
    SetTriggerOption("qzjxFight5","group","qzjxFight")
    SetTriggerOption("qzjxFight6","group","qzjxFight")    
    EnableTriggerGroup("qzjxFight",false) 
    DeleteTriggerGroup("qzjxCut")
    create_trigger_t('qzjxCut1','^(> )*你从(\\D*)的尸体身上搜出一块重阳令。','','qzjxCutCon')
    create_trigger_tc('qzjxCut3',"^(> )*(\\D*)的尸体\\(Corpse\\)",'','qzjxDie') 
    SetTriggerOption("qzjxCut1","group","qzjxCut") 
    SetTriggerOption("qzjxCut3","group","qzjxCut")
    EnableTriggerGroup("qzjxCut",false)
    DeleteTriggerGroup("qzjxGive")
    create_trigger_t('qzjxGive1','^(> )*丘处机对着你「哈哈哈」大笑几声。','','qzjxFinish')
	create_trigger_t('qzjxGive2',"^(> )*你觉得有点什么不对劲, 可是你却说不上来",'','qzjxBUG')	
    SetTriggerOption("qzjxGive1","group","qzjxGive")
	SetTriggerOption("qzjxGive2","group","qzjxGive")
    EnableTriggerGroup("qzjxGive",false)
    DeleteTriggerGroup("qzjxHead")
    create_trigger_t('qzjxHead1','^(> )*这是一颗(\\D*)的(首级|人头)','','qzjxHeadCheck')
    create_trigger_t('qzjxHead2','^(> )*你把 "action" 设定为 "check_ling" 成功完成。','','qzjxHeadCon')
    create_trigger_t('qzjxHead3','^(> )*(\\D*)的的尸体\\(Corpse\\)','','qzjxHeadCheck')
    SetTriggerOption("qzjxHead1","group","qzjxHead")
    SetTriggerOption("qzjxHead2","group","qzjxHead")
    SetTriggerOption("qzjxHead3","group","qzjxHead")
    EnableTriggerGroup("qzjxHead",false)
    DeleteTriggerGroup("qzjxFinish")
    create_trigger_t('qzjxFinish1','^(> )*丘处机轻轻地拍了拍你的头。','','qzjxFinishCheck')
    create_trigger_t('qzjxFinish2',"^(> )*你觉得有点什么不对劲, 可是你却说不上来",'','qzjxBUG')
    SetTriggerOption("qzjxFinish1","group","qzjxFinish")
	SetTriggerOption("qzjxFinish2","group","qzjxFinish")
    EnableTriggerGroup("qzjxFinish",false)
end
function qzjxBUG()
    messageShow('全真奸细：交任务又又又出BUG啦啦啦啦啦啦！！!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!！')
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
	messageShow('全真奸细：接任务又又又出BUG啦啦啦啦啦啦！！!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
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
    return go(qzjxStart,'全真','老君殿')
end
function qzjxStart()
    job.qzjx=0  
	qzjxTrigger()
	create_timer_s('fxasktimer',5,'qzjx')
    EnableTriggerGroup("qzjxAsk",true)
    exe('time;askk qiu chuji about 全真锄奸')
end
function qzjxAsk()
    DeleteTimer("fxasktimer")
    EnableTriggerGroup("qzjxFight",false)
    EnableTriggerGroup("qzjxAsk",false)
    EnableTriggerGroup("qzjxAccept",true)
end
function qzjxBusy()    
    exe('jobtimes;hp;time')
	return go(check_heal,'华山','玉泉院')
end

function qzjxBusyDazuo()
    DeleteTimer("fxasktimer")
    prepare_lianxi(qzjxStart)
end
function qzjxFail()
    EnableTriggerGroup("qzjxAccept",false)
    job.last='qzjx'
	exe('jobtimes;cond')
	return go(check_heal,'华山','玉泉院')
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
    print("自动获取NPC id："..job.id)	
    job.killer={}
    job.killer[job.target]=true  
    print ("address:" ..job.where)
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.area=job.area
    dest.room=job.room
   
	
    if not job.room or not path_cal() then
        messageShow('全真锄奸：任务地点【'..job.where..'】不可到达，任务放弃。')
        return qzjxFangqi()
    else 
        messageShow('全真锄奸：开始前往【'..job.where..'】找【'..job.target..'】！')
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
	print("自动获取NPC id："..job.id)	
    job.killer={}
    print ("address:" ..job.where)
    job.where=addrTrim(job.where)
    job.area="全真山"
    job.room=job.where
    dest.room=job.room
    dest.area="全真山"
    print(job.area)
    print (job.room) 
    print(dest.area)
    print (dest.room)
    if not job.room then
        messageShow('全真锄奸：任务地点【'..job.where..'】不可到达，任务放弃。')
        return qzjxFangqi()
    else 
        messageShow('全真锄奸：开始前往【'..job.where..'】杀【'..job.target..'】！')
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
    return go(qzjxFangqi,"全真","老君殿")
end
function qzjxFangqi()
    EnableTriggerGroup("qzjxAsk",true)
    return check_bei(qzjxFangqiAsk)
end
function qzjxFangqiAsk()
    EnableTriggerGroup("qzjxAccept",false)
    job.progress=0 -- ain add
    exe('hp;cond;drop ling;askk qiu chuji about 放弃;hp')
	--flag.idle=0
	return check_heal()
end
function qzjxFind()
    EnableTriggerGroup("qzjxFind",false)
    DeleteTriggerGroup("qzjxFind")
    create_trigger_t('qzjxFind2','^(> )*(\\D*)喋喋怪笑不断，既然发现了，那就纳命来吧！','','qzjxTarget2')
	create_trigger_t('qzjxFind3','^(> )*'..job.target..'往(\\D*)离开','','qzjxfightnobody') 
	create_trigger_t('qzjxFin5','^(> )*这是玩家'..score.name..'要追杀的金国奸细!','','qzjxTarget3')
	create_trigger_t('qzjxFin6','^(> )*金兵忽然一把将你身上的重阳令偷走！然后拉下面罩，原来正是你要追杀的金兵间隙！','','qzjxstop')
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
    exe('say 停下找奸细')
    messageShow('全真锄奸：令牌被抢走了，发现可疑房间，停下调查')
    checkRoom()
end
function qzjxfightnobody()  --屁哥
    dis_all()
    messageShow('全真锄奸：NPC离开了,重新寻找【'.. job.target ..'】！')
    print('NPC离开了,重新寻找！')
 
    EnableTriggerGroup("qzjxFind",false)
    DeleteTriggerGroup("qzjxFind")
    create_trigger_t('qzjxFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','qzjxTarget1')
  --  create_trigger_t('qzjxFind2','^(> )*'..job.target..'对着你发出一阵阴笑，说道','','qzjxTarget2')
--	create_trigger_t('qzjxFind3','^(> )*'..job.target..'往(\\D*)离开','','qzjxfightnobody')  
 --   create_trigger_t('qzjxFind4','^(> )*'..job.target..'说道：「你一直跟我这么多天，既然躲无所躲，大爷今天就超渡你！','','qzjxTarget2')		
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
    messageShow('非战斗房间，频繁骚扰【'.. job.target ..'】！')
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
    		messageShow('全真锄奸：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
	
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

      messageShow('全真锄奸：找到【'.. job.target ..'】！')
     -- exe('set wimpy 100;kill '..job.id)
	 -- exe('follow '..job.id) 
     messageShow('全真锄奸：开始与【'.. job.target ..'】战斗！')
--      exe('l '..job.id)
	exe('kill '..job.id)   
	print('kill '..job.id)
	 messageShow('全真锄奸：叫杀【'.. job.target ..'】战斗！')
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
	messageShow('全真锄奸：开始杀【'.. job.target ..'】！')
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
          print("qzjx job 杀人成功!")
		  dis_all()
		  flag.idle=0
          DeleteTimer("perform")
		  messageShow('全真锄奸：已经干掉了【'.. job.target ..'】！'..'耗时:【'..job.time.ff..'】秒')
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
    create_trigger_t('hs_get1','^(> )*(光天化日的想抢劫啊|\\D*的尸体对你而言太重了)','','huashan_get_next')
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
    messageShow('全真锄奸：搞定了，交任务！')
    exe('say 全真锄奸：搞定了，交任务！')
    go(qzjxHead,'全真','老君殿')
end
function qzjxHead()
 if not locl.id["丘处机"] then  
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
    messageShow('全真锄奸：任务完成！')
	local l_time=os.time()-job.time.b
    local l_hour=math.modf(l_time/3600)
    local l_min=math.modf((l_time-l_hour*3600)/60)
    local l_sec=l_time-l_hour*3600-l_min*60
    messageShow('全真锄奸任务：任务完成！(用时:'..l_min ..'分'..l_sec..'秒)')
    job.last='qzjx'
    job.progress=0
	--flag.idle=0
    qzjxTriggerDel()
--    return checkWait(check_heal,1)
	--return go(check_heal,'全真','教碑')
    return check_heal()
end
function qzjxescap(n,l,w)
job.progress=1  
local npcskills=w[3]
print(npcskills)
 messageShow('全真清除奸细：'.. job.target ..'的武功是【'.. npcskills ..'】。')
end

function checkRoomStart()
   EnableTriggerGroup("checkroom",true)
end
 
function checkRoom()
   DeleteTriggerGroup("checkroom")
   create_trigger_t('checkroom1',"^(> )*在这个房间中, 生物及物品的(英文)名称如下：",'','checkRoomStart')
   create_trigger_t('checkroom2',"^(> )*(\\D*) = (\\D*)$",'','checkRoomId')
   create_trigger_t('checkroom3','^(> )*(\\D*)这是玩家'..score.name..'要追杀的金国奸细!','','killqzjx')
   --他是一位体格强健的壮年道士，似乎身怀武艺。
   --这是玩家鸿钧老祖要追杀的金国奸细!
  -- create_trigger_t('checkroom3','^(> )*他是一位体格强健的壮年道士，似乎身怀武艺。','','killqzjx')
 --  create_trigger_t('checkroom5','^(> )*你把 "action" 设定为 "check room over" 成功完成。$','','checkRoomOver')
   --[[
   公西赞(Gongxi zan)
这人就是完颜洪烈派到中原的黑衣护卫金兵，来此完成秘密使命。
这是玩家鸿钧老祖要追杀的金国奸细!
   --]]
   SetTriggerOption("checkroom1","group","bags")
   SetTriggerOption("checkroom2","group","bags")
   SetTriggerOption("checkroom3","group","bags")
 --  SetTriggerOption("checkroom5","group","bags")
 
 
   EnableTriggerGroup("checkroom",false)
   EnableTrigger("checkroom1",true)
   EnableTrigger("checkroom2",true)
  --这是玩家鸿钧老祖要追杀的金国奸细!
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
  --这是玩家鸿钧老祖要追杀的金国奸细!
  
  if string.find(l_id,",") then
  print('==')
	print(l_name)
	if( l_name =='铜钱' or l_name =='白银' or  l_name =='黄金' or  l_name =='长剑' or  l_name =='钢刀' or  l_name =='长鞭'  
	or  l_name =='夜行衣'   or  l_name =='流星锤' or l_name=='暗杀匕首' or l_name=='飞蝗石' or l_name=='铁法轮' or l_name=='枯干的骸骨'
	or l_name=='钢斧' or l_name=='风回雪舞剑' or l_name =='暴雨梨花针' or l_name =='天蛇杖' or l_name =='雪碎刀'  or l_name =='银蛇剑' 
	or l_name =='丧门钉' or l_name =='绿绮琴' or l_name =='齐眉棍' or l_name =='骷髅锤' or l_name =='百辟匕首' or l_name =='玉箫'
	or l_name =='黄竹棒' or l_name =='游龙长鞭' or l_name =='单钩' or l_name =='钢杖'  or l_name=='判官笔' or l_name=='木剑' or l_name=='铁笔'
	or l_name=='竹棒' or l_name=='长枪' or l_name=='箫' or l_name=='甩箭' or l_name=='石子' or l_name=='神龙镖' or l_name=='精制铁令'
	or l_name=='腐烂的女尸' or l_name=='腐烂的男尸' or l_name=='铁棍' or l_name=='林巡捕') then
		print('武器 衣服 垃圾 非生物')
	else
	
	l_qzjxid=filter_npcid(l_name);
	
	if not Roomqzjx[l_id] then
      Roomqzjx[l_id]={}
	end
	
	if l_qzjxid=='不是常规NPC' then
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
				print('房间人物id 搜集完毕')
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
function filter_npcid(name)--过滤常规npc的id
	local id=""
	--local f=f or 0 
	if data_system_npc[name] then--系统npc
		id=data_system_npc[name]
	
	end
	if id =='' then
		return '不是常规NPC'
	else
		return '常规'
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
	messageShow('全真奸细：发现奸细 的Id是 【'..qzjxjob.id..'】 名字叫  【'..Roomqzjx[qzjxjob.id]..'】' )
	messageShow('kill '..qzjxjob.id)
	exe('set wimpy 100;kill '..qzjxjob.id)
end