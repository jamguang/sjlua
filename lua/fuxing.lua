xsWhereIgnores ={
    ["武当山后山小院"] = true,
	["襄阳郊外山洞"] = true,
    ["武当山院门"] = true,
    ["明教树林"] = true,
	["明教树林深处"] = true,
	["全真派药剂室"] = true,
	["福州城山路"] = true,
	["苗疆山路"] = true,
	["扬州城瘦西湖酒馆"] = true,	
	["扬州城瘦西湖雅楼"] = true,
	["桃源县山洞"] = true,
	["桃源县岸边"] = true,
	["桃源县山顶"] = true,
	["桃源县山坡"]= true,
	["桃源县石梁"] = true,
	["桃源县石梁尽头"] = true,
	["桃源县河塘"] = true,
	["桃源县小石桥"] = true,
	["桃源县禅院大殿"] = true,
	["桃源县西厢房"] = true,
	["桃源县东厢房"] = true,
	["桃源县禅院后院"] = true,
	["桃源县斋堂"] = true,
	["桃源县练功房"] = true,
	["桃源县青石小径"] = true,
	["桃源县竹林"] = true,
	["桃源县石屋正房"] = true,
	["桃源县石屋厢房"] = true,
    ["明教天字门"] = true,
    ["明教树林"] = true,
    ["明教地字门"] = true,
    ["明教雷字门"] = true,
	["明教风字门"] = true,
	["嵩山少林石板路"] = true, -- ain

}
local Yiliaddr2 ={
	["伊犁城客栈"] = true,
	["伊犁城客栈二楼"] = true,
	["伊犁城铁铺"] = true,
	["伊犁城商铺"] = true,
	["伊犁城城中心"] = true,
	["伊犁城巴依家院"] = true,
}
--fuxing
jobSpecial = jobSpecial or {}
job.list = job.list or {}
job.list["fuxing"] = "日月复兴"
joblast = joblast or {}
joblast["日月复兴"] = "fuxing"
jobCond = jobCond or {}
jobCond["fuxing"] = function() if hp.shen<-5000 and (not condition["日月复兴"] or (condition["日月复兴"] and condition["日月复兴"]<=0) or (condition["任务繁忙状态"] and condition["日月复兴"] and condition["日月复兴"]<=condition["任务繁忙状态"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["fuxing"] = "fuxingTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["fuxing"] = "fuxingFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["fuxing"] = "fuxingFindFail"
faintFunc = faintFunc or {}
faintFunc["fuxing"] = "fuxingFaint"
--此人看上去师承蛤蟆功传人，擅长使用灵蛇杖法伤敌！
--此人看上去师承铁掌帮，擅长使用裂天斧伤敌！
--汝鄢祁马扫了你一眼道：“贱人，既然派你来，想必有几分真才实学，就让大爷我来掂量掂量你吧！”
fuxingIgnoresskill = {
    ["太极拳"] = true,
    ["避邪剑法"] = true,
 --   ["太极剑法"]   = true,
   ["打狗棒法"] = true,
	--   ["玉箫剑法"] = true,
 --    ["玄阴剑法"] = true,
	 --玄阴剑法
	-- ["慕容刀法"] = true,
--	  ["黯然销魂掌"] = true,
   ["血刀刀法"]=true,
   ["少林醉棍"] = true,
 --   ["天羽奇剑"] = true,
--	["一阳指"]=true,
--	["嵩山剑法"]=true,
--	  ["如意刀法"] = true,
	  ["独孤九剑"]=true,
	  ["玄铁剑法"]=true,
--	  ["玉女素心剑"]=true,
	  ["韦陀杵"]=true,
--	  ["雁行刀法"]=true,
	--  ["修罗刀"]=true,
	--  ["回风拂柳剑"]=true,
	--  ["慈航鞭"]=true,
	--  ["灵蛇鞭法"]=true,
	--  ["七弦无形剑"]=true,
	 ["金刚降伏轮"]=true,
	--  ["全真剑法"]=true,
	  ["灵蛇拳法"]=true,
	  ["灵蛇杖法"]=true,
	  
	  
}
function fuxingTrigger()
    EnableTriggerGroup("fuxingAsk",false)
    EnableTriggerGroup("fuxingAccept",false)
    
    DeleteTriggerGroup("fuxingAsk") 
    create_trigger_t('fuxingAsk1',"^(> )*你向向问天打听有关",'','fuxingAsk')
    create_trigger_t('fuxingAsk2',"^(> )*这里没有这个人。$",'','fuxingNobody')
    SetTriggerOption("fuxingAsk1","group","fuxingAsk")
    SetTriggerOption("fuxingAsk2","group","fuxingAsk")
    EnableTriggerGroup("fuxingAsk",false)
    DeleteTriggerGroup("fuxingAccept")
    --道杨的尸体(Corpse)
   --向问天对你说道：你没有领任务，和我嚷嚷什么？ 
    create_trigger_t('fuxingAccept1',"^(> )*向问天在你的耳边悄声说道：你听着，有弟子回报(\\D*)(门主|舵主|堂主|香主|旗主|朝奉|长老)(\\D*)这人忠于东方不败，那么……",'','fuxingNpc')
    create_trigger_t('fuxingAccept11',"^(> )*向问天在你的耳边悄声说道：对了，(\\D*)(门主|舵主|堂主|香主|旗主|朝奉|长老)(\\D*)和我交情不错，如得他相助，救出任教主之事简直易如反掌",'','fuxingNpc')
    create_trigger_t('fuxingAccept2',"^(> )*向问天对你说道：(嘿嘿，他在|你就代表我去)(\\D*)(一带，你去将他杀了|邀请他)",'','fuxingConsider')
    create_trigger_t('fuxingAccept3',"^(> )*向问\\D*说道\\D*不是让你去",'','fuxingFangqi')
    create_trigger_t('fuxingAccept4',"^(> )*向问\\D*说道\\D*你正忙着呢",'','fuxingFail')
    create_trigger_t('fuxingAccept5',"^(> )*向问\\D*说道\\D*你刚帮过我，还是休息一下吧。",'','fuxingFail')
    create_trigger_t('fuxingAccept6',"^(> )*向问\\D*说道\\D*你没有领任务,和我嚷嚷什么?",'','fuxingFail')
    create_trigger_t('fuxingAccept7',"^(> )*向问\\D*说道\\D*嗯，我现在正在思考并派大计，你别打扰。",'','fuxingFail')
    create_trigger_t('fuxingAccept8',"^(> )*向问\\D*说道\\D*你这样偷奸耍滑，何时才能救出任教主！！！",'','fuxingFail')
    create_trigger_t('fuxingAccept9',"^(> )*向问\\D*说道\\D*嗯，我现在忙，你别打扰。",'','fuxingFail')
    create_trigger_t('fuxingAccept10',"^(> )*向\\D*说道\\D*现在没有任务，你等下再来吧。」",'','fuxingFail')
 --   create_trigger_t('fuxingAccept12',"^(> )*向问天对你说道：你这样偷奸耍滑，何时才能救出任教主！！！",'','fuxingcancle')
    create_trigger_t('fuxingAccept13',"^(> )*向问天对你说道：你上次的日月复兴任务还没有吧。",'','fuxingFail')
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
    create_trigger_t('fuxingFight1','^(> )*(\\D*)「啪」的一声倒在地上','','fuxingDie')
    create_trigger_t('fuxingFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','fuxingNFaint')
    create_trigger_t('fuxingFight3',"^(> )*这里没有(\\D*)。",'','fuxingLost')
    create_trigger_t('fuxingFight4',"^(> )*(这里没有这个人耶|你想邀请的对象不在这里)",'','fuxingFind')
    create_trigger_t('fuxingFight5',"^(> )*(你双手一拱，笑着|你胜了这招，向后跃开三尺|你哈哈大笑，说道：承让了！|没看见|你正忙着呢，先歇口气吧|你正在打架呢，等会儿再说吧|你正在极力邀请人家呢|你要先等他醒过来再说|你精神不振，先休息一下吧)",'','fuxingQingNext')
    create_trigger_t('fuxingFight6',"^(> )*(你的任务好象不是要邀请这人吧|你的任务好象不是要邀请谁吧)",'','fuxingFangqiGo')
    create_trigger_t('fuxingFight7',"^(> )*(\\D*)已经接受了邀请，你不用再费劲啦。",'','fuxingBackCheck')
    create_trigger_t('fuxingFight10',"^(> )*(\\D*)哈哈一笑：“\\D*的功夫果然不错，承蒙向左使看得起，你先去吧我随后就到",'','fuxingFollow')
    create_trigger_tc('fuxingFight11',"^(> )*你(一脸的恭敬|对着\\D*深深一躬|面带笑容，对|对\\D*鞠躬道)",'','fuxingadd')
    create_trigger_tc('fuxingFight8',"^(> )*(\\D*)(决定跟随你一起行动。|身形一闪，已经消失不见。)",'','fuxingFollow')
    --create_trigger_t('fuxingFight9',"^(> )*(\\D*)(向后一纵|向后退了几步，说道|轻蔑地扫了|嘿嘿一声：|脸色苍白，只看了|转过头来，上上下下看了|脸色微变，说道：佩服，佩服|一脸不耐烦的表情)",'','fuxingQingCheck')
    create_trigger_tc('fuxingFight12',"^(> )*此人看上去师承(\\D*)，擅长使用(\\D*)伤敌！",'','fuxingescap')
	
    create_trigger_t('fuxingFight13',"^(> )*(\\D*)'扫了你一眼道：“\\D*，既然派你来，想必有几分真才实学，就让\\D*我来掂量掂量你吧！”",'','fxfightpfm')  -- ain
    create_trigger_t('fuxingFight14',"^一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……",'','faint_check')
	create_trigger_t('fuxingFight15',"^(> )*(\\D*)说道：「我与你往日无冤，近日无仇！」",'','fuxingFind')
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
    create_trigger_t('fuxingCut1','^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','fuxingCutCon')
    create_trigger_t('fuxingCut2','^(> )*(你得用件锋利的器具才能切下这尸体的头来。|你手上这件兵器无锋无刃，如何能切下这尸体的头来？)','','fuxingCutWeapon')
    create_trigger_tc('fuxingCut3',"^(> )*(\\D*)的尸体\\(Corpse\\)",'','fuxingDie')  -- ain
    create_trigger_t('fuxingCut4','^(> )*你将(\\D*)的尸体扶了起来背在背上。','','fuxing_get_con') -- ain
    create_trigger_t('fuxingCut5','^(> )*(\\D*)的尸体对你而言太重了\\)','','fuxingCutWeapon') -- ain
        
    SetTriggerOption("fuxingCut1","group","fuxingCut") 
    SetTriggerOption("fuxingCut2","group","fuxingCut")
    SetTriggerOption("fuxingCut3","group","fuxingCut")
    SetTriggerOption("fuxingCut4","group","fuxingCut")
    SetTriggerOption("fuxingCut5","group","fuxingCut")
    EnableTriggerGroup("fuxingCut",false)
    
    --班艳娟的尸体(Corpse)
    EnableTriggerGroup("fuxingGive",false)
    DeleteTriggerGroup("fuxingGive")
    create_trigger_t('fuxingGive1','^(> )*你给向问天一颗(\\D*)的首级。','','fuxingFinish')
    SetTriggerOption("fuxingGive1","group","fuxingGive")
    EnableTriggerGroup("fuxingGive",false)
    DeleteTriggerGroup("fuxingHead")
    create_trigger_t('fuxingHead1','^(> )*这是一颗(\\D*)的(首级|人头)','','fuxingHeadCheck')
    create_trigger_t('fuxingHead2','^(> )*你把 "action" 设定为 "check_head" 成功完成。','','fuxingHeadCon')
    create_trigger_t('fuxingHead3','^(> )*(\\D*)的的尸体\\(Corpse\\)','','fuxingHeadCheck')
    SetTriggerOption("fuxingHead1","group","fuxingHead")
    SetTriggerOption("fuxingHead2","group","fuxingHead")
    SetTriggerOption("fuxingHead3","group","fuxingHead")
  
    EnableTriggerGroup("fuxingHead",false)
    DeleteTriggerGroup("fuxingFinish")
    create_trigger_t('fuxingFinish1','^(> )*向问天说道：「(\\D*)能来，我救出任教主又多了一份把握','','fuxingFinishCheck')
    SetTriggerOption("fuxingFinish1","group","fuxingFinish") 
    EnableTriggerGroup("fuxingFinish",false)
	
	EnableTriggerGroup("xxdfquest",false)
    DeleteTriggerGroup("xxdfquest")
	create_trigger_t('xxdfquest1','^(> )*向问天说道：「'.. score.name ..'，听说杭州梅庄四位庄主喜欢琴棋书画，你若能投其所好送去礼物，或许会有一番机缘。','','xxdfQuest')
	create_trigger_t('xxdfquest2','^(> )*向问天对你说道：「'.. score.name ..'，听说杭州梅庄四位庄主喜欢琴棋书画，你若能投其所好送去礼物，或许会有一番机缘。','','xxdfQuest')
	
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
    go(fuxingStart,'黑木崖','凉亭')
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
	if not skills["xixing-dafa"] and score.party=='日月神教' then
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
	  print("自动获取NPC id："..job.id)	
    job.killer={}
    job.killer[job.target]=true   
end

function fuxingConsider(n,l,w)
    DeleteTimer("fxasktimer")
    job.last='fuxing'
    job.fuxing=0
    EnableTriggerGroup("fuxingAccept",false)
    if string.find(w[4],"请") then
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
       messageShow('日月任务：任务地点【'..job.where..'】不可到达，任务放弃。')
      -- ainlogline2("地址找不到",16)
       return fuxingFangqi()
    end
    if xsWhereIgnores[job.where] or not job.room then
       messageShow('日月任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return fuxingFangqi()
    end
	if Yiliaddr2[job.where] and MidNight[locl.time] then
	  
       messageShow('日月任务：但是去 '..Yiliaddr2[job.where]..'时间 '..MidNight[locl.time]..' 时间不够，任务放弃。')
       return fuxingFangqi()
    end
	
	if score.party=='姑苏慕容' then
		if WhereIgnoresXS[job.where] or AddrIgnoresMRXS[dest.area]  then
		   messageShow('日月任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return fuxingFangqi()
		end
	else
		if WhereIgnoresXS[job.where] or AddrIgnoresXS[dest.area]  then
		   messageShow('日月任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return fuxingFangqi()
		end
	
	end
    if job.type and job.type=="qing" then
       messageShow('日月任务：开始前往【'..job.where..'】请【'..job.target..'】！')
    else
       messageShow('日月任务：开始前往【'..job.where..'】杀【'..job.target..'】！')
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
    go(fuxingFangqi,'黑木崖','凉亭')
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
    create_trigger_tc('fuxingFind2','^(> )*\\D*对着你发出一阵阴笑，说道','','fuxingTarget2')
    create_trigger_tc('fuxingFind3','^(> )*\\D*'..job.target..'从\\D*走了过来。','','fuxingTarget2')
    SetTriggerOption("fuxingFind1","group","fuxingFind")
    SetTriggerOption("fuxingFind2","group","fuxingFind")
    SetTriggerOption("fuxingFind3","group","fuxingFind")
    EnableTriggerGroup("fuxingFind",true)  -- ain 改true
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
    		messageShow('日月任务：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
   elseif job.fuxing==1 then
   			--ain_print("已遭遇过目标NPC:"..job.target)
   elseif job.fuxing==2 then
         fuxingCut()   -- ain 
       -- ain_print("已搞定目标NPC:"..job.target)
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
      messageShow('日月任务：找到【'.. job.target ..'】！')
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
	--	messageShow('日月任务：开始与【'.. job.target ..'】战斗！')
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
    messageShow('日月任务：找到【'.. job.target ..'】！')
	  exe('set wimpy 100')
    exe('halt;follow '..job.id)
      -- 	if skills["niqiu-gong"] and skills["niqiu-gong"].lvl>499 then -- ain
	    --       exe('jifa dodge niqiu-gong;set wimpycmd \\pfmpfm\\hp;set wimpy 100') -- ain add
    	 -- else
             exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
      --  end    

	  if score.party=="嵩山派" then
         exe("set 嵩山剑法 削")
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
		messageShow('日月任务：开始请【'.. job.target ..'】，第'..Qingtimes..'次！')
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
 -- logfile = GetInfo(59) .. "/log/日月任务切头-"..score.id .."-"..os.time() .. ".txt"
 -- OpenLog (logfile , false)
--	print("开始记录log到",logfile )
       job.time.ef=os.time()  -- ain
       job.time.ff=job.time.ef-job.time.sf  -- ain
    job.fuxing=2
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          --exe('qing '..job.id)
          print("fuxing job 请人失败!",logfile )
          messageShow('日月任务：失手打死了请人对象【'.. job.target ..'】！'..'耗时:【'..job.time.ff..'】秒')
		      -- return check_bei(fuxingQing,1) -- wapian
		       -- ain add log2  	 		
         -- ain_debug("Debug一览.txt",",日月任务：失手打死了请人对象【".. job.target .."】")
       --   ainlogline2("失手打死了请人对象",3000)
	          disWait()
		      return check_busy(fuxingFangqiGo)  -- ain
       else
          job.progress=3 --add
          job.fuxing=2  -- ain
          print("fuxing job 杀人成功!")
          DeleteTimer("perform")
		      messageShow('日月任务：已经干掉了【'.. job.target ..'】！'..'耗时:【'..job.time.ff..'】秒')
          -- check_busy1(fuxingCut) -- ain 不要用这个
          check_busy(fuxingCut)
       end
    end
end

function fuxingQingCheck(n,l,w)
    if job.target==w[2] or b.target=="你" then
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
 elseif job.area=="绝情谷" then
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
    create_trigger_t('hs_get1','^(> )*(光天化日的想抢劫啊|\\D*的尸体对你而言太重了)','','huashan_get_next')
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
    messageShow('日月任务：搞定了，回黑木崖！')
    exe('say 日月任务：搞定了，回黑木崖！')
  --  CloseLog()
     --	road.wait=road.wait1
      --road.steps=road.steps1
    go(fuxingHead,'黑木崖','凉亭')
end
function fuxingHead()
 if not locl.id["向问天"] then  -- ain add 
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
	    exe('askk xiang wentian about 完成')
    messageShow('日月任务：任务完成！')
    job.last='fuxing'
    job.progress=0
	EnableTriggerGroup("xxdfquest",true)
	if not skills["xixing-dafa"] and score.party == '日月神教' then
		return check_bei(check_heal,2)
	else
		return checkWait(check_heal,1)
	end
end
function fuxingescap(n,l,w)
job.progress=0  -- ain
----- ain -------------------------
local npcskills=w[3]
messageShow('日月任务：'..npcskills)
	if GetVariable("RYjobSkillsFangqi") and GetVariable("RYjobSkillsFangqi")~="" then
       RYjobSkillsFangqi=GetVariable("RYjobSkillsFangqi")    --格式:微不足道,马马虎虎,小有所成,融会贯通,颇为了得,极其厉害
    end
   
   
			--if RYjobSkillsFangqi and string.find(RYjobSkillsFangqi,npcskills)  then
			if fuxingIgnoresskill[npcskills] then 
			 	  DeleteTimer("fuxing")
    			DeleteTimer("perform")
    			EnableTriggerGroup("fuxingFight",false)
    			EnableTriggerGroup("fuxingFinish",true)
    			messageShow('日月任务：对手太厉害，回黑木崖放弃！')
    			exe('say 日月任务：对手太厉害，回黑木崖放弃！')
    			exe('set wimpycmd 10')
  				  CloseLog()
    		--	ainlogline2("日月复兴任务逃跑".."-"..npcskills,50)
    		--	go(check_heal,'黑木崖','凉亭')
    		   flag.find=2
    	--	   road.wait=road.wait1
          -- road.steps=road.steps1
			exe('halt')
			exe(locl.dir)
    			 --go(fuxingFangqi,'黑木崖','凉亭')
    			fuxingFangqiGo()
			else
				messageShow('日月任务：开始与【'.. job.target ..'】战斗！')
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
               				print('遇到【'..npcskills..'】切换到化学pfm模式：'..perform.pre)   
              				-- ain add log2  	 		
	 										local file = io.open(GetInfo(59) .. "/log/Debug一览.txt", "a")
	      							file:write(os.date()..','..score.id ..",Debug==="..",启用化学技能,"..npcskills..",")
	      							file:write("\n")
        							file:close()
        						-- 
        	   				 -- ain add log
             				 logfile = GetInfo(59) .. "/log/化学pfm技能记录 【"..npcskills.."】-"..score.id .."-"..os.time() .. ".txt"
              				OpenLog (logfile , false)
       	     					 print("开始记录化学pfm log到",logfile )
       	     		  end 			 
       	    --  fight_prepare()

        	 else
        	    if GetVariable("flagdebug") and tonumber(GetVariable("flagdebug"))==1 then
           		   print('遇到【'..sxjob.skills..'】只好硬抗了：'..perform.pre)   
              		-- ain add log2  	 		
	 								local file = io.open(GetInfo(59) .. "/log/Debug一览.txt", "a")
	      					file:write(os.date()..','..score.id ..",Debug==="..",没有化学技能,"..sxjob.skills)
	      						file:write("\n")
        						file:close()
        						exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
        			 end
        	  end	
       end
	   --]]
-----------------------------------------------------------


    if w[2]=="蛤蟆功传人" then
 			   	DeleteTimer("fuxing")
    			DeleteTimer("perform")
    			EnableTriggerGroup("fuxingFight",false)
    			EnableTriggerGroup("fuxingFinish",true)
    			messageShow('日月任务：对手太厉害，回黑木崖放弃！')
    			exe('say 日月任务：对手太厉害，回黑木崖放弃！')
    			exe('set wimpycmd 10')
  				--  CloseLog()
    		--	ainlogline2("日月复兴任务逃跑".."-".."蛤蟆功传人",50)
    			go(fuxingFangqi,'黑木崖','凉亭')
     elseif w[2]=="铁掌帮"	or w[2]=="武当派"	or w[2]=="慕容派"	then
        	  if score.party=="嵩山派" then
                 exe("unset 嵩山剑法")
            end 
                 
     end
end
function fuxingcancle()
        EnableTriggerGroup("fuxingFight",false)
    
       ---  fuxingTriggerDel() -- ain add
        job.last='fuxing'
         messageShow('日月任务：任务放弃！')
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

function get_id(name,party,f)--得到name的id
local id=""
--local f=f or 0 
if data_system_npc[name] then--系统npc
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
		if string.find(n,"风") and string.find(p,"桃花岛") then
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
		if string.find(n,"风") and string.find(p,"桃花岛") then
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

data_name={["芝"]="zhi",["时"]="shi",["润"]="run",["光"]="guang",["标"]="biao",["田"]="tian",["杜"]="du",["若"]="ruo",["彩"]="cai",["徐"]="xu",["郝"]="hao",["谷梁"]="guliang",["禄"]="lu",["虎"]="hu",["支"]="zhi",["许"]="xu",["伟"]="wei",["度"]="du",["表"]="biao",["蔡"]="cai",["瑛"]="ying",["羲"]="xi",["法"]="fa",["渡"]="du",["超"]="chao",["陆"]="lu",["淳于"]="chunyu",["俊"]="jun",["峥"]="zheng",["造"]="zao",["浩"]="hao",["严"]="yan",["朝伟"]="chaowei",["旭"]="xu",["端"]="duan",["史"]="shi",["佰赏"]="baishang",["欧阳"]="ouyang",["伍藏"]="wuzang",["凝"]="ning",["未"]="wei",["萍"]="ping",["宁"]="ning",["麟"]="lin",["玲"]="ling",["归"]="gui",["朝"]="chao",["吕"]="lv",["九"]="jiu",["平"]="ping",["花"]="hua",["黛"]="dai",["冶"]="ye",["端木"]="duanmu",["皇甫"]="huangpu",["之"]="zhi",["斌"]="bin",["邵"]="shao",["延"]="yan",["段"]="duan",["三"]="san",["拓"]="tuo",["培"]="pei",["华"]="hua",["断"]="duan",["言"]="yan",["樊"]="fan",["令狐"]="linghu",["铁"]="tie",["雕"]="diao",["式"]="shi",["和"]="he",["宾"]="bin",["阎"]="yan",["单于"]="chanyu",["叶"]="ye",["魏"]="wei",["何"]="he",["乐正"]="yuezheng",["士"]="shi",["开"]="kai",["合"]="he",["桂"]="gui",["凡"]="fan",["赵"]="zhao",["凌"]="ling",["舌"]="she",["轩"]="xuan",["公西"]="gongxi",["世"]="shi",["嵘"]="rong",["佩"]="pei",["化"]="hua",["藏"]="zang",["僖"]="xi",["沛"]="pei",["律"]="lv",["尉"]="wei",["破"]="po",["凯"]="kai",["曾"]="zeng",["茅"]="mao",["轩辕"]="xuanyuan",["一"]="yi",["魄"]="po",["金"]="jin",["河"]="he",["范"]="fan",["窦"]="dou",["富城"]="fucheng",["玄"]="xuan",["卫"]="wei",["焘"]="tao",["毛"]="mao",["曹"]="cao",["千"]="qian",["艳"]="yan",["姗"]="shan",["令"]="ling",["赫"]="he",["颛孔"]="zhuankong",["温"]="wen",["趾"]="zhi",["燕"]="yan",["睿"]="rui",["欢"]="huan",["鹤"]="he",["策"]="ce",["濮阳"]="puyang",["长孙"]="zhangsun",["文"]="wen",["谦"]="qian",["茂"]="mao",["帅"]="shuai",["彭"]="peng",["贺"]="he",["郭"]="guo",["段千"]="duanqian",["闻"]="wen",["乾"]="qian",["菊"]="ju",["国"]="guo",["芳"]="fang",["申"]="shen",["微生"]="weisheng",["志"]="zhi",["康"]="kang",["戟"]="ji",["方"]="fang",["巫马"]="wuma",["英"]="ying",["进"]="jin",["佘"]="she",["钱"]="qian",["陈"]="chen",["孟达"]="mengda",["过"]="guo",["多"]="duo",["刘"]="liu",["深"]="shen",["前"]="qian",["举"]="ju",["哈"]="ha",["晋"]="jin",["潜"]="qian",["朋"]="peng",["流"]="liu",["逵"]="kui",["司马"]="sima",["珍"]="zhen",["仪"]="yi",["鹏"]="peng",["伦"]="lun",["水"]="shui",["柳"]="liu",["颛"]="zhuan",["亢"]="kang",["六"]="liu",["翁"]="weng",["城"]="cheng",["祝"]="zhu",["真"]="zhen",["普"]="pu",["龙"]="long",["福"]="fu",["沈"]="shen",["川"]="chuan",["成"]="cheng",["艾"]="ai",["澹台"]="tantai",["赫连"]="helian",["学友"]="xueyou",["德华"]="dehua",["智"]="zhi",["荧"]="ying",["婉"]="wan",["顺"]="shun",["爱"]="ai",["甫"]="pu",["公孙"]="gongsun",["杨"]="yang",["万"]="wan",["程"]="cheng",["夏候"]="xiahou",["小春"]="xiaochun",["罗"]="luo",["飞"]="fei",["汝鄢"]="ruyan",["虹"]="hong",["汪"]="wang",["柯"]="ke",["黄"]="huang",["澄"]="chen",["公良"]="gongliang",["盈"]="ying",["诚"]="cheng",["安"]="an",["王"]="wang",["曼玉"]="manyu",["寿"]="shou",["美"]="mei",["洪"]="hong",["褚"]="zhu",["戚"]="qi",["羊"]="yang",["生"]="sheng",["治"]="zhi",["颖"]="ying",["斯"]="si",["坤"]="kun",["宏"]="hong",["师空"]="shikong",["七"]="qi",["昆"]="kun",["阳"]="yang",["巫"]="wu",["皇"]="huang",["南郭"]="nanguo",["骧驷"]="xiangsi",["振"]="zhen",["强"]="qiang",["吉"]="ji",["红"]="hong",["罡"]="gang",["太叔"]="taishu",["闻人"]="wenren",["思"]="si",["奚"]="xi",["漆"]="qi",["黛玉"]="daiyu",["忠"]="zhong",["媛"]="yuan",["可"]="ke",["娟"]="juan",["费"]="fei",["门"]="men",["楚晋"]="chujin",["涂钦"]="tuqin",["易"]="yi",["婷"]="ting",["芬"]="fen",["钟"]="zhong",["司"]="si",["克"]="ke",["霞"]="xia",["威"]="wei",["阔"]="kuo",["厚"]="hou",["亿"]="yi",["奇"]="qi",["蒙"]="meng",["候"]="hou",["复"]="fu",["迟"]="chi",["诸葛"]="zhuge",["傅"]="fu",["灰"]="hui",["后"]="hou",["敖"]="ao",["昝"]="jiu",["夹谷"]="jiagu",["西门"]="ximen",["付"]="fu",["春"]="chun",["驰"]="chi",["乔"]="qiao",["鄢"]="yan",["呼"]="hu",["拓哉"]="tuozai",["四"]="si",["仲"]="zhong",["逸"]="yi",["崎"]="qi",["辉"]="hui",["昌"]="chang",["翱"]="ao",["墨"]="mo",["马"]="ma",["叔"]="shu",["柳任"]="liuren",["权"]="quan",["猛"]="meng",["吴"]="wu",["舒"]="shu",["耳"]="er",["父"]="fu",["舟"]="zhou",["小"]="xiao",["淑"]="shu",["傲"]="ao",["齐"]="qi",["嫣"]="yan",["孝"]="xiao",["武"]="wu",["泉"]="quan",["孟"]="meng",["周"]="zhou",["正"]="zheng",["淳"]="chun",["呼延"]="huyan",["青霞"]="qingxia",["五"]="wu",["永"]="yong",["富"]="fu",["夏"]="xia",["政"]="zheng",["东郭"]="dongguo",["宇文"]="yuwen",["宝钗"]="baochai",["二"]="er",["意"]="yi",["台"]="tai",["松"]="song",["空"]="kong",["肖"]="xiao",["祁"]="qi",["胡"]="hu",["润发"]="runfa",["勇"]="yong",["毅"]="yi",["泰"]="tai",["谋"]="mou",["麦"]="mai",["谯"]="qiao",["赖"]="lai",["东方"]="dongfang",["忆"]="yi",["起"]="qi",["慧"]="hui",["牟"]="mou",["孔"]="kong",["狐"]="hu",["裕"]="yu",["义"]="yi",["迈"]="mai",["均"]="jun",["宝"]="bao",["伍"]="wu",["太"]="tai",["楚红"]="chuhong",["益"]="yi",["惠"]="hui",["丰"]="feng",["尉迟"]="yuchi",["豫"]="yu",["封"]="feng",["丹"]="dan",["宋"]="song",["启"]="qi",["军"]="jun",["米"]="mi",["单"]="shan",["八"]="ba",["尤"]="you",["宙"]="zhou",["贤"]="xian",["满"]="man",["兰"]="lan",["峻"]="jun",["钗"]="chai",["鲍"]="bao",["钦"]="qin",["锋"]="feng",["巴"]="ba",["异"]="yi",["曼"]="man",["健"]="jian",["风"]="feng",["元"]="yuan",["珠"]="zhu",["务"]="wu",["济"]="ji",["功"]="gong",["秦"]="qin",["苏"]="su",["琴"]="qin",["弃"]="qi",["剑"]="jian",["恭"]="gong",["袁"]="yuan",["申屠"]="shentu",["勤"]="qin",["龚"]="gong",["慕"]="mu",["左丘"]="zuoqiu",["潭"]="tan",["芹"]="qin",["群"]="qun",["木"]="mu",["计"]="ji",["朱"]="zhu",["甘"]="gan",["冯"]="feng",["熙"]="xi",["然"]="ran",["立"]="li",["有"]="you",["谭"]="tan",["仇"]="qiu",["辕"]="yuan",["柏芝"]="baizhi",["友"]="you",["公"]="gong",["霸"]="ba",["谈"]="tan",["诸"]="zhu",["宗政"]="zongzheng",["殷"]="yin",["西"]="xi",["坦"]="tan",["牧"]="mu",["琅"]="lang",["建"]="jian",["奉"]="feng",["宫"]="gong",["贝"]="bei",["星驰"]="xingchi",["圆"]="yuan",["凤"]="feng",["当"]="dang",["穆"]="mu",["阎法"]="yanfa",["青"]="qing",["力"]="li",["白"]="bai",["姜"]="jiang",["驷"]="si",["公冶"]="gongye",["柏"]="bo",["夫"]="fu",["郎"]="lang",["纪"]="ji",["百"]="bai",["东门"]="dongmen",["仲孙"]="zhongsun",["熙凤"]="xifeng",["子"]="zi",["朗"]="lang",["江"]="jiang",["嘉"]="jia",["苗"]="miao",["缑"]="gou",["自"]="zi",["宪"]="xian",["谢"]="xie",["佰"]="bai",["瑜"]="yu",["寅"]="yin",["清"]="qing",["莲"]="lian",["宽"]="kuan",["汤"]="tang",["桑"]="sang",["蒋"]="jiang",["夹"]="jia",["卫健"]="weijian",["纳"]="na",["佳"]="jia",["刚"]="gang",["于"]="yu",["连"]="lian",["尹"]="yin",["农"]="nong",["匡"]="kuang",["钢"]="gang",["廷"]="ting",["堂"]="tang",["廉"]="lian",["本"]="ben",["老"]="lao",["霍"]="huo",["欣"]="xin",["棠"]="tang",["班"]="ban",["虞"]="yu",["宗"]="zong",["亭"]="ting",["随"]="sui",["纲"]="gang",["楚"]="chu",["邝"]="kuang",["香"]="xiang",["新"]="xin",["庭"]="ting",["仁"]="ren",["唐"]="tang",["贾"]="jia",["崔"]="cui",["人"]="ren",["庆"]="qing",["南"]="nan",["灭"]="mie",["甲"]="jia",["余"]="yu",["邬"]="wu",["伏"]="fu",["司徒"]="situ",["岳"]="yue",["琼"]="qiong",["民"]="min",["俞"]="yu",["钟离"]="zhongli",["道"]="dao",["湘"]="xiang",["信"]="xin",["通"]="tong",["难"]="nan",["邹"]="zhou",["况"]="kuang",["拓趾"]="tuozhi",["桐"]="tong",["森"]="sen",["秋"]="qiu",["任"]="ren",["乐"]="yue",["焦"]="jiao",["星"]="xing",["遂"]="sui",["敏"]="min",["雷"]="lei",["高"]="gao",["德"]="de",["薛"]="xue",["丁"]="ding",["丘"]="qiu",["学"]="xue",["祥"]="xiang",["翠"]="cui",["邱"]="qiu",["南宫"]="nangong",["同"]="tong",["璞"]="pu",["芙"]="fu",["云"]="yun",["佟"]="tong",["铜"]="tong",["涛"]="tao",["明"]="ming",["波"]="bo",["孙"]="sun",["滔"]="tao",["梁"]="liang",["奎"]="kui",["宰父"]="zaifu",["欧"]="ou",["鸣"]="ming",["魁"]="kui",["娇"]="jiao",["姑"]="gu",["鼎"]="ding",["登"]="deng",["童"]="tong",["沙"]="sha",["雨"]="yu",["良"]="liang",["坚"]="jian",["海"]="hai",["碧"]="bi",["祖"]="zu",["项"]="xiang",["定"]="ding",["傻"]="sha",["骧"]="xiang",["亥"]="hai",["哥"]="ge",["归海"]="guihai",["统"]="tong",["蓉"]="rong",["能"]="neng",["行"]="xing",["禹"]="yu",["邓"]="deng",["秦东"]="qindong",["宇"]="yu",["荣"]="rong",["东"]="dong",["陶"]="tao",["曲"]="qu",["谷"]="gu",["韬"]="tao",["亮"]="liang",["冬"]="dong",["羽"]="yu",["隆"]="long",["达"]="da",["萧"]="xiao",["屈"]="qu",["倪"]="ni",["董"]="dong",["玉"]="yu",["冷"]="leng",["顾"]="gu",["藤"]="teng",["晶"]="jing",["敌"]="di",["容"]="rong",["韩"]="han",["腾"]="teng",["山"]="shan",["栋"]="dong",["慕容"]="murong",["大"]="da",["狄"]="di",["公羊"]="gongyang",["黎"]="li",["葛"]="ge",["呆"]="dai",["澹"]="tan",["哉"]="zai",["图"]="tu",["卜"]="bo",["辟"]="pi",["逆"]="ni",["喻"]="yu",["皮"]="pi",["左"]="zuo",["徒"]="tu",["上官"]="shangguan",["雄"]="xiong",["炜"]="wei",["离"]="li",["戴"]="dai",["宰"]="zai",["盛"]="sheng",["熊"]="xiong",["了"]="liao",["包"]="bao",["涂"]="tu",["濮"]="pu",["羊舌"]="yangshe",["晓"]="xiao",["珂"]="ke",["斗"]="dou",["屠"]="tu",["漆雕"]="qidiao",["作"]="zuo",["胜"]="sheng",["髯"]="ran",["年"]="nian",["代"]="dai",["布"]="bu",["卢"]="lu",["李"]="li",["如"]="ru",["廖"]="liao",["第"]="di",["里"]="li",["湘云"]="xiangyun",["微"]="wei",["静"]="jing",["师"]="shi",["潘"]="pan",["岑"]="cen",["列"]="lie",["礼"]="li",["岚"]="lan",["根"]="gen",["部"]="bu",["关"]="guan",["赞"]="zan",["念"]="nian",["莉"]="li",["都"]="du",["韦"]="wei",["官"]="guan",["汝"]="ru",["梁丘"]="liangqiu",["楠"]="nan",["烈"]="lie",["施"]="shi",["莘"]="xin",["倩"]="qian",["飘"]="piao",["汉"]="han",["湛"]="zhan",["商"]="shang",["鲁"]="lu",["管"]="guan",["嫣然"]="yanran",["常"]="chang",["唯"]="wei",["琳"]="lin",["丽"]="li",["靖"]="jing",["阮"]="ruan",["卞"]="bian",["赏"]="shang",["长"]="chang",["箐"]="qing",["才"]="cai",["章"]="zhang",["裘"]="qiu",["林"]="lin",["为"]="wei",["天"]="tian",["瑞"]="rui",["财"]="cai",["姚"]="yao",["庞"]="pang",["聂"]="nie",["上"]="shang",["百里"]="baili",["虚"]="xu",["添"]="tian",["锐"]="rui",["杰"]="jie",["发"]="fa",["郑"]="zheng",["石"]="shi",["蒯"]="kuai",["维"]="wei",["贯"]="guan",["张"]="zhang"}
data_name_fuxing={["谷梁"]=true,["淳于"]=true,["朝伟"]=true,["佰赏"]=true,["欧阳"]=true,["伍藏"]=true,["端木"]=true,["皇甫"]=true,["令狐"]=true,["单于"]=true,["乐正"]=true,["公西"]=true,["轩辕"]=true,["富城"]=true,["颛孔"]=true,["濮阳"]=true,["长孙"]=true,["段千"]=true,["微生"]=true,["巫马"]=true,["孟达"]=true,["司马"]=true,["澹台"]=true,["赫连"]=true,["学友"]=true,["德华"]=true,["公孙"]=true,["夏候"]=true,["小春"]=true,["汝鄢"]=true,["公良"]=true,["曼玉"]=true,["师空"]=true,["南郭"]=true,["骧驷"]=true,["太叔"]=true,["闻人"]=true,["黛玉"]=true,["楚晋"]=true,["涂钦"]=true,["诸葛"]=true,["夹谷"]=true,["西门"]=true,["拓哉"]=true,["柳任"]=true,["呼延"]=true,["青霞"]=true,["东郭"]=true,["宇文"]=true,["宝钗"]=true,["润发"]=true,["东方"]=true,["楚红"]=true,["尉迟"]=true,["申屠"]=true,["左丘"]=true,["柏芝"]=true,["宗政"]=true,["星驰"]=true,["阎法"]=true,["公冶"]=true,["东门"]=true,["仲孙"]=true,["熙凤"]=true,["卫健"]=true,["司徒"]=true,["钟离"]=true,["拓趾"]=true,["南宫"]=true,["宰父"]=true,["归海"]=true,["慕容"]=true,["公羊"]=true,["上官"]=true,["羊舌"]=true,["漆雕"]=true,["湘云"]=true,["梁丘"]=true,["嫣然"]=true,["百里"]=true}
data_system_npc={["官兵"]="guan bing",["长乐帮帮众"]="bang zhong",["贾老六"]="jia laolu",["票友"]="piao you",["弟子"]="dizi",["厨师"]="chu zi",["黑衣人"]="heiyi ren",["地字门教众"]="jiao zhong",["牧羊女"]="muyang nu",["牧羊人"]="muyang ren",["邱山风"]="qiu shanfeng",["冼掌柜"]="zhanggui",["兰剑"]="lan jian",["殷梨亭"]="yin liting",["耶律齐"]="yelv qi",["黄真"]="huang zhen",["青龙帮弟子"]="dizi",["大盗"]="da dao",["道明小师傅"]="daoming shifu",["苏梦清"]="su mengqing",["老头子"]="lao touzi",["令狐冲"]="linghu chong",["庄丁"]="zhuang ding",["上官剑南"]="shangguan jiannan",["方舵主"]="fang duozhu",["大苦大师"]="daku dashi",["文方小师太"]="wen fang",["朱长龄"]="zhu changling",["香客"]="xiang ke",["王夫人"]="wang furen",["莽汉"]="mang han",["风松道长"]="fengsong daozhang",["张三"]="zhang san",["沈老板"]="laoban",["司马大"]="sima da",["小贩"]="xiao fan",["乔三槐"]="qiao",["维吾尔族妇女"]="woman",["药店掌柜"]="yaodian zhanggui",["天镜禅师"]="tianjing chanshi",["成高道长"]="chenggao daozhang",["蒋调侯"]="jiang tiaohou",["崔莺莺"]="cui yingying",["单伯山"]="shan boshan",["陈运清"]="chen yunqing",["万事通"]="wanshi tong",["刀疤张"]="daoba zhang",["小僮"]="xiao tong",["范晔"]="fan ye",["边防武将"]="wu jiang",["乐厚"]="le hou",["尼姑"]="ni gu",["杨不悔"]="yang buhui",["苗若兰"]="miao ruolan",["李员外"]="li yuanwai",["马夫子"]="ma fuzi",["郝长老"]="hao zhanglao",["边防官兵"]="guan bing",["壮年僧人"]="seng",["符敏仪"]="fu mingyi",["王大米"]="wang dami",["管家"]="guan jia",["万老板"]="laoban",["上官鹏"]="shangguan peng",["成不忧"]="cheng buyou",["阿根"]="a gen",["胡青牛"]="hu qingniu",["知客僧"]="zhike seng",["裘千丈"]="qiu qianzhang",["铸剑师"]="zhujian shi",["流氓头"]="liumang tou",["中军侍卫"]="shiwei",["执法弟子"]="zhifa dizi",["桑三娘"]="sang sanniang",["黄老板"]="huang laoban",["张巡捕"]="zhang xunbu",["萧半和"]="xiao banhe",["邓百川"]="deng baichuan",["慧方尊者"]="huifang zunzhe",["麻衣长老"]="mayi zhanglao",["独行侠"]="duxing xia",["于三娘"]="yu sanniang",["清缘比丘"]="biqiu",["无根道人"]="wugen daoren",["打手"]="da shou",["郑镖头"]="zheng biaotou",["天字门教众"]="jiao zhong",["幽草"]="you cao",["小厨子"]="xiao chuzi",["玄痛大师"]="dashi",["波斯商人"]="bosi shangren",["张镖头"]="zhang biaotou",["任飞燕"]="ren feiyan",["采石人"]="caishi ren",["洪水旗教众"]="jiao zhong",["陆柏"]="lu bo",["亲兵队长"]="qinbing duizhang",["温方达"]="wen fangda",["卖花姑娘"]="maihua guniang",["大衙役"]="da yayi",["中年乞丐"]="qi gai",["蒙面人"]="mengmian ren",["张千"]="zhang qian",["商人"]="shang ren",["天门道人"]="tianmen daoren",["采花子"]="caihua zi",["哲罗星"]="zheluo xing",["郭靖"]="guo jing",["辉月使"]="huiyue shi",["澄思"]="luohan",["江北大盗"]="jiangbei dadao",["正宫皇后"]="huanghou",["小贩子"]="xiao fan",["穷汉"]="qiong han",["烈火旗教众"]="jiao zhong",["武僧"]="wu seng",["抢匪"]="fei",["哑木匠"]="ya mujiang",["天龙寺武僧"]="wu seng",["采药人"]="caiyao ren",["妇女"]="woman",["狱卒"]="yu zu",["许镖头"]="xu biaotou",["温方山"]="wen fangshan",["巡捕"]="xun bu",["西域客商"]="xiyu keshang",["五毒教弟子"]="dizi",["瘦头陀"]="shou toutuo",["石嫂"]="shi sao",["蒙哥"]="meng ge",["星宿派鼓手"]="gu shou",["三丑"]="san chou",["黎生"]="li sheng",["道象禅师"]="chanshi",["泉建男"]="quan jiannan",["查老学士"]="zha xueshi",["巡逻亲兵"]="qing bing",["蓝铁匠"]="tiejiang",["壮年乞丐"]="qigai",["伙计"]="huoji",["赵良栋"]="zhao liangdong",["殷无福"]="yin wufu",["慧真尊者"]="zunzhe",["史伯威"]="shi bowei",["胖嫂"]="pang sao",["镖头"]="biao tou",["紫竹"]="zi zhu",["吴柏英"]="wu baiying",["裘千仞"]="qiu qianren",["展飞"]="zhan fei",["大理武将"]="dali wujiang",["张康"]="zhang kang",["史镖头"]="shi biaotou",["猪肉荣"]="zhurou rong",["虚通"]="xu tong",["老和尚"]="monk",["大理官兵"]="dali guanbing",["单叔山"]="shan shushan",["单仲山"]="shan zhongshan",["巴依"]="bayi",["无相禅师"]="chanshi",["跑堂"]="waiter",["段正明"]="duan zhengming",["私塾先生"]="sishu xiansheng",["静虚师太"]="jingxu shitai",["周芷若"]="zhou zhiruo",["土匪"]="fei",["过三拳"]="guo sanquan",["丁典"]="ding dian",["心清比丘"]="xinqing biqiu",["元哀尊者"]="yuanai zunzhe",["钟镇"]="zhong zhen",["土娼"]="tu chang",["凤天南"]="feng tiannan",["崔算盘"]="cui suanpan",["单小山"]="shan xiaoshan",["达尔巴"]="daer ba",["慕容复"]="murong fu",["黑龙门弟子"]="dizi",["木匠"]="mu jiang",["妙风使"]="miaofeng shi",["清乐比丘"]="biqiu",["张淡月"]="zhang danyue",["龟奴"]="gui nu",["丫头"]="ya tou",["进香客"]="jinxiang ke",["范长老"]="fan zhanglao",["胡斐"]="hu fei",["游驹"]="you ju",["菊剑"]="ju jian",["大理小贩"]="dali xiaofan",["虚明"]="xu ming",["徐霞客"]="xu xiake",["逍遥子"]="xiaoyao zi",["梁发"]="liang fa",["元广波"]="yuan guangbo",["天松道人"]="tiansong daoren",["殷无寿"]="yin wushou",["渡难"]="du nan",["值勤兵"]="zhiqin bing",["程玉环"]="cheng yuhuan",["陈达海"]="chen dahai",["护法使者"]="shi zhe",["木人"]="mu ren",["狄修"]="di xiu",["澄意"]="luohan",["万青里"]="wan qingli",["书生"]="shu sheng",["傅思归"]="fu sigui",["丐帮弟子"]="gaibang dizi",["玉玑子"]="yuji zi",["船老大"]="lao da",["米横野"]="mi hengye",["菊友"]="ju you",["空空儿"]="kong kong",["唢呐手"]="suona shou",["农夫"]="fu",["梅超风"]="mei chaofeng",["温方施"]="wen fangshi",["钱善人"]="qian shanren",["殷锦"]="yin jin",["钱缝"]="qian feng",["何师我"]="he shiwo",["冯铁匠"]="feng tiejiang",["回族兵"]="huizu bing",["马舵主"]="ma duozhu",["胜谛"]="sheng di",["镖师"]="biao shi",["红娘"]="hong niang",["古笃诚"]="gu ducheng",["黄伯流"]="huang boliu",["地痞"]="dipi",["江来福"]="jiang laifu",["货郎"]="huo lang",["周虎威"]="zhou huwei",["青鬏龟童"]="gui tong",["侯通海"]="hou tonghai",["方评"]="fang ping",["哈萨克牧民"]="hasake mumin",["任盈盈"]="ren yingying",["公冶乾"]="gongye gan",["本观大师"]="benguan dashi",["洪安通"]="hong antong",["冼老板"]="xian laoban",["俞朝奉"]="yu chaofeng",["大汉"]="da han",["苗族青年"]="miaozu qingnian",["阎基"]="yan ji",["汤英鹗"]="tang yinge",["玉磬子"]="yuqing zi",["程瑶迦"]="cheng yaojia",["陈长老"]="chen zhanglao",["瑛姑"]="ying gu",["彭连虎"]="peng lianhu",["哲布尊巴丹"]="huo fo",["郁光标"]="yu guangbiao",["宋老板"]="laoban",["粘而帖"]="zhan ertie",["绿衣弟子"]="dizi",["顾炎武"]="gu yanwu",["静和师太"]="jinghe shitai",["陈正德"]="chen zhengde",["乌老大"]="wu laoda",["沙天江"]="sha tianjiang",["苏鲁克"]="su luke",["黄龙门弟子"]="dizi",["陆高轩"]="lu gaoxuan",["完颜萍"]="wanyan ping",["吴劲草"]="wu jincao",["邓八公"]="deng bagong",["知府大人"]="zhifu daren",["流氓"]="liu mang",["赵敏"]="zhao min",["朱九真"]="zhu jiuzhen",["徐小五"]="xu xiaowu",["张中"]="zhang zhong",["金人"]="jin ren",["史仲猛"]="shi zhongmeng",["客商"]="ke shang",["衙役"]="ya yi",["大理镖头"]="biaotou",["静照师太"]="jingzhao shitai",["马青雄"]="ma qingxiong",["陈清"]="chen qing",["蒙古卫士"]="weishi",["老仆"]="laopu",["小道童"]="daotong",["蓝凤凰"]="lan fenghuang",["黑衣杀手"]="shashou",["执戒僧"]="zhijie seng",["烧饼刘"]="shaobing liu",["澄寂"]="luohan",["老者"]="lao zhe",["绿衣小僮"]="luyi xiaotong",["周孤桐"]="zhou gutong",["苗人凤"]="miao renfeng",["小侍童"]="xiao shitong",["侍粥僧"]="shizhou seng",["枯荣长老"]="kurong zhanglao",["苏习之"]="su xizhi",["店小二"]="xiao er",["刘老实"]="liu laoshi",["扫地仆人"]="saodi puren",["静迦师太"]="jingjia shitai",["计老人"]="ji laoren",["张妈"]="zhang ma",["厚土旗教众"]="jiao zhong",["玄渡大师"]="dashi",["家丁"]="jia ding",["小乞丐"]="xiao qigai",["香女"]="xiang nu",["进喜儿"]="jinxi er",["静玄师太"]="jingxuan shitai",["王老汉"]="wang laohan",["小二"]="xiao er",["仪清"]="yi qing",["穆人清"]="mu renqing",["丫鬟"]="ya huan",["黑衣大盗"]="heiyi dadao",["说不得"]="shuo bude",["慧空尊者"]="zunzhe",["赌客"]="du ke",["朱老板"]="laoban",["仆人"]="pu ren",["樵夫"]="qiao fu",["本参大师"]="bencan dashi",["蒋涛"]="jiang tao",["黛绮丝"]="dai qisi",["周颠"]="zhou dian",["道品禅师"]="chanshi",["谷虚道长"]="guxu daozhang",["鸠摩智"]="jiumo zhi",["赵城之"]="zhao chengzhi",["樵子"]="qiao zi",["方碧琳"]="fang bilin",["了思禅师"]="liaosi chanshi",["小喽罗"]="xiao louluo",["肖老头"]="xiao laotou",["江湖豪客"]="hao ke",["波斯生意人"]="shengyi ren",["王长老"]="wang zhanglao",["昆仑派弟子"]="dizi",["凌退思"]="ling tuisi",["天柏道人"]="tianbai daoren",["玄惭大师"]="dashi",["许雪亭"]="xu xueting",["丁敏君"]="ding minjun",["何红药"]="he hongyao",["苗族老汉"]="miaozu laohan",["执法僧兵"]="bing",["殷老板"]="yin laoban",["余婆婆"]="yu popo",["温仪"]="wen yi",["清晓比丘"]="biqiu",["归二娘"]="gui erniang",["钱眼开"]="qian yankai",["王公公"]="wang gonggong",["生意人"]="shengyi ren",["吴青烈"]="wu qinglie",["风清扬"]="feng qingyang",["夏雪宜"]="xia xueyi",["采矿师傅"]="caikuang shifu",["珠宝商"]="zhubao shang",["秦绢"]="qin juan",["药师"]="yao shi",["归钟"]="gui zhong",["都大锦"]="du dajin",["费彬"]="fei bin",["李招财"]="li zhaocai",["清善比丘"]="biqiu",["张泉"]="zhang quan",["火工头陀"]="huogong toutuo",["独行大侠"]="duxing daxia",["牛老板"]="niu laoban",["京城客"]="jingcheng ke",["杂货铺老板"]="laoban",["游客"]="you ke",["葛光佩"]="ge guangpei",["大理地痞"]="dipi",["公孙止"]="gongsun zhi",["王合计"]="wang heji",["丁婆婆"]="ding popo",["武敦儒"]="wu dunru",["星宿派号手"]="hao shou",["奚长老"]="xi zhanglao",["天虹禅师"]="tianhong chanshi",["元决尊者"]="yuanjue zunzhe",["史孟捷"]="shi mengjie",["铜人"]="tong ren",["巴天石"]="ba tianshi",["东方不败"]="dongfang bubai",["宁中则"]="ning zhongze",["何铁手"]="he tieshou",["王三力"]="wang sanli",["元悔尊者"]="yuanhui zunzhe",["卫天望"]="wei tianwang",["林震南"]="lin zhennan",["绿竹翁"]="lu zhuweng",["西方月"]="fae shizhe",["宋远桥"]="song yuanqiao",["酒楼掌柜"]="jiulou zhanggui",["账房先生"]="zhangfang xiansheng",["盐枭"]="yanxiao",["过彦之"]="guo yanzhi",["文音小师太"]="wenyin",["男孩"]="boy",["桃花姑娘"]="tao hua",["冯默风"]="feng mofeng",["孙婆婆"]="sun popo",["清观比丘"]="biqiu",["药铺老板"]="laoban",["侍茶小僮"]="tong",["枯荣禅师"]="kurong chanshi",["赤龙门弟子"]="dizi",["莫声谷"]="mo shenggu",["高升泰"]="gao shengtai",["静真师太"]="jingzhen shitai",["陈阿婆"]="chen apo",["武修文"]="wu xiuwen",["全冠清"]="quan guanqing",["中年男子"]="zhongnian nanzi",["裸体女子"]="luoti nvzi",["韦春芳"]="wei chunfang",["辛双清"]="xin shuangqing",["黄大雄"]="huang daxiong",["无名老翁"]="lao weng",["纺织女"]="fangzhi nu",["学童"]="xue tong",["盐商"]="yanshang",["一品堂 武士"]="wu shi",["定逸师太"]="dingyi shitai",["鲍大楚"]="bao dachu",["红衣杀手"]="shashou",["从不弃"]="cong buqi",["澄灭"]="luohan",["清为比丘"]="biqiu",["茶馆小二"]="chaguan xiaoer",["岭南大侠"]="daxia",["大理衙役"]="dali yayi",["四丑"]="si chou",["蒋舵主"]="jiang duozhu",["澄心"]="luohan",["渡劫"]="du jie",["文清小师太"]="wen qing",["杏芳"]="xing fang",["王语嫣"]="wang yuyan",["崔老板"]="cui laoban",["吴长老"]="wu zhanglao",["澄信"]="luohan",["道一禅师"]="chanshi",["马钰"]="ma yu",["裘千尺"]="qiu qianchi",["刀客"]="dao ke",["色楞"]="se leng",["何太冲"]="he taichong",["何足道"]="he zudao",["酒保"]="jiu bao",["董帐房"]="zhangfang",["马夫"]="ma fu",["齐云敖"]="qi yunao",["玉灵子"]="yuling zi",["知客道长"]="zhike daozhang",["张算盘"]="zhang suanpan",["五丑"]="wu chou",["元悲尊者"]="yuanbei zunzhe",["李捕头"]="li butou",["大理赌客"]="duke",["邝宝官"]="kuang baoguan",["接引弟子"]="jieyin dizi",["缘根和尚"]="yuangen",["傻姑"]="sha gu",["道尘禅师"]="chanshi",["唐文德"]="tang wende",["玉虚散人"]="yuxu sanren",["昆仑派女弟子"]="dizi",["程青霜"]="cheng qingshuang",["采花大盗"]="caihua dadao",["韩铁匠"]="han tiejiang",["澄明"]="luohan",["清法比丘"]="biqiu",["当铺老板"]="lao ban",["江湖艺人"]="yiren",["打铁匠"]="jiang",["王城"]="wang cheng",["杨莲亭"]="yang lianting",["星宿派钹手"]="bo shou",["赵爵爷"]="zhao jueye",["建除道人"]="jianchu daoren",["尹克西"]="yin kexi",["道果禅师"]="chanshi",["卜沉"]="bu chen",["史叔刚"]="shi shugang",["茶博士"]="cha boshi",["林平之"]="lin pingzhi",["来福儿"]="laifu er",["矮老者"]="ai laozhe",["劳德诺"]="lao denuo",["孙老板"]="sun laoban",["澄坚"]="luohan",["李式开"]="li shikai",["茅十八"]="mao shiba",["一灯大师"]="yideng dashi",["傣族大嫂"]="daizu dasao",["萧中慧"]="xiao zhonghui",["梁子翁"]="liang ziweng",["风波恶"]="feng boe",["藏族牧民"]="zangzu mumin",["宋长老"]="song zhanglao",["黄眉和尚"]="huangmei heshang",["贾布"]="jia bu",["史登达"]="shi dengda",["摘星子"]="zhaixing zi",["胡贵"]="hu gui",["养蚕婆婆"]="yangcan popo",["趟子手"]="tangzi shou",["雪仙儿"]="xue xianer",["李半仙"]="li banxian",["落魄公子"]="gong zi",["祖千秋"]="zu qianqiu",["岳灵珊"]="yue lingshan",["陆无双"]="lu wushuang",["西夏兵"]="xixia bing",["慕容博"]="murong bo",["黄蓉"]="huang rong",["炼丹道童"]="daotong",["小土匪"]="xiao tufei",["护镖镖师"]="hubiao biaoshi",["飘然子"]="piaoran zi",["成昆"]="cheng kun",["大癫大师"]="dadian dashi",["澄行"]="luohan",["陈近南"]="chen jinnan",["洪哮天"]="hong xiaotian",["采药道长"]="caiyao daozhang",["范遥"]="fan yao",["老乞丐"]="qigai",["岳不群"]="yue buqun",["打铁僧"]="datie seng",["温南扬"]="wen nanyang",["刘竹庄"]="liu zhuzhuang",["大理盐枭"]="yanxiao",["看窑弟子"]="kanyao dizi",["定闲师太"]="dingxian shitai",["上官云"]="shangguan yun",["龙卷风"]="long juanfeng",["守律僧"]="seng",["白世镜"]="bai shijing",["双儿"]="shuang er",["蒙古武士"]="wushi",["容子矩"]="rong ziju",["严掌柜"]="zhanggui",["曲洋"]="qu yang",["无名小子"]="wuming xiaozi",["青龙门弟子"]="dizi",["白龙门弟子"]="dizi",["掌柜"]="zhanggui",["颜垣"]="yan tan",["道成禅师"]="chanshi",["慧色尊者"]="zunzhe",["采花贼"]="caihua zei",["鹤笔翁"]="he biweng",["小沙弥"]="shami",["茶客"]="cha ke",["玄澄大师"]="dashi",["金轮法王"]="jinlun fawang",["萧老板"]="xiao laoban",["元兵"]="yuan bing",["孤鸿子"]="guhong zi",["文菲小师太"]="wen fei",["袁冠男"]="yuan guannan",["亲兵"]="qin bing",["陆冠英"]="lu guanying",["竹剑"]="zhu jian",["老裁缝"]="lao caifeng",["钟志灵"]="zhong zhiling",["张松溪"]="zhang songxi",["大理盐商"]="yanshang",["玄生大师"]="dashi",["挑夫"]="tiao fu",["落魄书生"]="luopo shusheng",["乔福"]="qiao fu",["公孙绿萼"]="gongsun lve",["万大平"]="wan daping",["小翠"]="xiao cui",["天狼子"]="tianlang zi",["回族武将"]="wu jiang",["星宿派弟子"]="dizi",["游坦之"]="you tanzhi",["朱丹臣"]="zhu danchen",["哈萨克妇女"]="woman",["花铁干"]="hua tiegan",["桑结"]="sang jie",["王坏水"]="wang huaishui",["钟万仇"]="zhong wanchou",["静空师太"]="jingkong shitai",["慧云尊者"]="huiyun zunzhe",["元怒尊者"]="yuannu zunzhe",["捕头"]="bu tou",["武三通"]="wu santong",["风字门教众"]="jiao zhong",["黄药师"]="huang yaoshi",["了宽禅师"]="liaokuan chanshi",["了清禅师"]="liaoqing chanshi",["忽必烈"]="hu bilie",["洪七公"]="hong qigong",["静慧师太"]="jinghui shitai",["小童"]="xiao tong",["小孩"]="kid",["总坛弟子"]="dizi",["常遇春"]="chang yuchun",["闻苍松"]="wen cangsong",["皇宫侍卫"]="shiwei",["豆腐西施"]="doufu xishi",["女弟子"]="dizi",["张朝唐"]="zhang chaotang",["钟小二"]="zhong xiaoer",["魔教杀手"]="mojiao shashou",["方生大师"]="fangsheng dashi",["了惑禅师"]="liaohuo chanshi",["瑞婆婆"]="rui popo",["侯君集"]="hou junji",["张帐房"]="zhangfang",["男弟子"]="dizi",["纪晓芙"]="ji xiaofu",["仪琳"]="yi lin",["俞岱岩"]="yu daiyan",["迟百城"]="chi baicheng",["富家公子"]="gong zi",["澄欲"]="luohan",["慧名尊者"]="zunzhe",["清闻比丘"]="biqiu",["阿曼"]="aman",["灰衣帮众"]="bangzhong",["李春来"]="li chunlai",["陈冲之"]="chen chongzhi",["童百熊"]="tong baixiong",["锐金旗教众"]="jiao zhong",["苏荃"]="su quan",["波罗星"]="boluo xing",["彭莹玉"]="peng yingyu",["俞莲舟"]="yu lianzhou",["赵灵珠"]="zhao lingzhu",["李老板"]="li laoban",["东方日"]="shangshan shizhe",["赌场老板"]="laoban",["血刀老祖"]="xuedao laozu",["哲别"]="zhe bie",["盐枭老者"]="yanxiao",["苗兵"]="miao bing",["高克新"]="gao kexin",["一品堂武士"]="wu shi",["归辛树"]="gui xinshu",["阿朱"]="a zhu",["严妈妈"]="yan mama",["西华子"]="xi huazi",["辛然"]="xin ran",["王五"]="wang wu",["巫师"]="wizard",["静风师太"]="jingfeng shitai",["扫地僧"]="saodi seng",["厨子"]="chu zi",["游方和尚"]="seng ren",["独脚大盗"]="dujiao dadao",["马光佐"]="ma guangzuo",["詹春"]="zhan chun",["澄观"]="luohan",["摩诃巴思"]="mohe basi",["侍剑"]="shi jian",["铁匠"]="tie jiang",["静闲师太"]="jingxian shitai",["郑萼"]="zheng e",["张夫人"]="zhang furen",["田伯光"]="tian boguang",["小丫鬟"]="xiao yahuan",["总管家"]="zong guanjia",["护林僧兵"]="bing",["白衣武士"]="wei shi",["青衣武士"]="wei shi",["李铁嘴"]="li tiezui",["江湖浪子"]="jianghu langzi",["买卖提"]="maimaiti",["轿夫头"]="jiaofu tou",["黄富霸"]="huang fuba",["任无月"]="Ren wuyue",["包子王"]="baozi wang",["阿紫"]="a zi",["朱元璋"]="zhu yuanzhang",["庄铮"]="zhuang zheng",["药铺伙计"]="huoji",["吴光胜"]="wu guangsheng",["平婆婆"]="ping popo",["方天劳"]="fang tianlao",["宝象"]="bao xiang",["铁人"]="tie ren",["钱青健"]="qian qingjian",["单季山"]="shan jishan",["梅剑"]="mei jian",["了明禅师"]="liaoming chanshi",["黯然子"]="anran zi",["鲁有脚"]="lu youjiao",["元痛尊者"]="yuantong zunzhe",["澄净"]="luohan",["澄尚"]="luohan",["贝海石"]="bei haishi",["苏普"]="su pu",["麦鲸"]="mai jing",["赵知仁"]="zhao zhiren",["陆乘风"]="lu chengfeng",["翠花"]="cui hua",["温方义"]="wen fangyi",["丁春秋"]="ding chunqiu",["道正禅师"]="chanshi",["潘天耕"]="pan tiangeng",["公子哥儿"]="gong zi",["岭南大盗"]="dadao",["班淑娴"]="ban shuxian",["道觉禅师"]="chanshi",["丁当"]="ding dang",["李莫愁"]="li mochou",["丁勉"]="ding mian",["薛慕华"]="xue muhua",["方正大师"]="da shi",["酒馆老板"]="jiuguan laoban",["平一指"]="ping yizhi",["张老板"]="laoban",["陆立鼎"]="lu liding",["五毒教女弟子"]="dizi",["游骥"]="you ji",["武馆门卫"]="men wei",["锣鼓手"]="luogu shou",["女店主"]="nv dianzhu",["萧峰"]="xiao feng",["慧修尊者"]="zunzhe",["胖头陀"]="pang toutuo",["薛烛"]="xue zhu",["小龙女"]="xiao longnv",["徐达"]="xu da",["嫖客"]="piao ke",["仪和"]="yi he",["了行禅师"]="liaoxing chanshi",["总镖头"]="zong biaotou",["作坊主人"]="zuofang zhuren",["慧如尊者"]="zunzhe",["文晖小师太"]="wen hui",["绿衣僮儿"]="luyi tonger",["计无施"]="ji wushi",["陈玄风"]="chen xuanfeng",["玄慈大师"]="dashi",["龙三爷"]="long sanye",["桃花"]="tao hua",["牧童"]="mutong",["温卧儿"]="wenwo er",["梁长老"]="liang zhanglao",["澄识"]="luohan",["澄知"]="luohan",["史季强"]="shi jiqiang",["浪荡公子"]="gong zi",["盐商头子"]="yanshang",["高根明"]="gao genming",["水兵"]="shui bing",["飞天子"]="feitian zi",["凌霜华"]="ling shuanghua",["章达夫"]="zhang dafu",["者勒米"]="zhe lemi",["项长老"]="xiang zhanglao",["王潭"]="wang tan",["鹿杖客"]="lu zhangke",["阿香"]="a xiang",["萨老板"]="laoban",["老板"]="lao ban",["温方悟"]="wen fangwu",["出尘子"]="chuchen zi",["玄苦大师"]="dashi",["善勇"]="shan yong",["欧阳老板"]="ouyang laoban",["仇松年"]="chou songnian",["雷字门教众"]="jiao zhong",["烧饭僧"]="shaofan seng",["关明梅"]="guan mingmei",["玄悲大师"]="dashi",["说书人"]="shuoshu ren",["崔员外"]="cui yuanwai",["李裁缝"]="li caifeng",["华赫艮"]="hua hegen",["花剑影"]="Hua jianying",["凌震天"]="ling zhentian",["狮吼子"]="shihou zi",["尼摩星"]="nimo xing",["大痴大师"]="dachi dashi",["玄寂大师"]="dashi",["王掌柜"]="zhanggui",["周伯通"]="zhou botong",["渡厄"]="du e",["段正淳"]="duan zhengchun",["盖一鸣"]="gai yiming",["施戴子"]="shi daizi",["黄令天"]="huang lingtian",["澄和"]="luohan",["清无比丘"]="biqiu",["青年乞丐"]="qigai",["沙通天"]="sha tongtian",["月下老人"]="yuexia laoren",["霍先生"]="xianshen",["封不平"]="feng buping",["陆大有"]="lu dayou",["巨木旗教众"]="jiao zhong",["船夫"]="chuan fu",["侍女"]="shi nv",["老大娘"]="lao daniang",["殷野王"]="yin yewang",["庙祝"]="miao zhu",["钟阿四"]="zhong asi",["钟四嫂"]="zhong sisao",["游迅"]="you xun",["僧人"]="seng ren",["阿祥"]="a xiang",["官府士兵"]="guanfu shibing",["本因大师"]="benyin dashi",["慧虚尊者"]="zunzhe",["司空玄"]="sikong xuan",["静心师太"]="jingxin shitai",["凤七"]="feng qi",["仪文"]="yi wen",["常长风"]="chang changfeng",["郭芙"]="guo fu",["吕文德"]="lv wende",["张无忌"]="zhang wuji",["澄灵"]="luohan",["渔人"]="yu ren",["静道师太"]="jingdao shitai",["樊一翁"]="fan yiweng",["剑客"]="jian ke",["程灵素"]="cheng lingsu",["单正"]="shan zheng",["卓不凡"]="zhuo bufan",["阿拉木罕"]="alamuhan",["慧光尊者"]="zunzhe",["侯三姐"]="hou sanjie",["赵老板"]="laoban",["哑妇"]="ya fu",["公子哥"]="gongzi ge",["黑林钵夫"]="heilin bofu",["大丑"]="da chou",["巡捕王"]="xunbu wang",["元伤尊者"]="yuanshang zunzhe",["托钵僧"]="tuobo seng",["平威"]="ping wei",["史青山"]="shi qingshan",["神秘镖师"]="shenmi biaoshi",["了修禅师"]="liaoxiu chanshi",["殷无禄"]="yin wulu",["慧洁尊者"]="zunzhe",["女孩"]="girl",["凤一鸣"]="feng yiming",["潇湘子"]="xiaoxiang zi",["沈青刚"]="shen qinggang",["阿碧"]="a bi",["守寺僧兵"]="bing",["宗赞王子"]="zongzan wangzi",["藏族妇女"]="woman",["殷天正"]="yin tianzheng",["戏子"]="xi zi",["吴大鹏"]="wu dapeng",["甘宝宝"]="gan baobao",["贝锦仪"]="bei jinyi",["风陵师太"]="fengling shitai",["灭绝师太"]="miejue shitai",["丁同"]="ding tong",["殷离"]="yin li",["无名老僧"]="wuming laoseng",["巫婆"]="wu po",["小和尚"]="monk",["褚万里"]="zhu wanli",["沈铁匠"]="shen tiejiang",["向问天"]="xiang wentian",["艄公"]="shao gong",["师爷"]="shi ye",["道童"]="dao tong",["呼巴音"]="hu bayin",["平四"]="ping si",["小丫环"]="xiao yahuan",["周威信"]="zhou",["侍童"]="shi tong",["包不同"]="bao butong",["左冷禅"]="zuo lengchan",["张浩天"]="zhang haotian",["蒙面大盗"]="mengmian dadao",["灵智上人"]="lingzhi shangren",["钱老本"]="qian laoben",["钟灵"]="zhong ling",["李明霞"]="li mingxia",["西夏武士"]="wu shi",["李文秀"]="li wenxiu",["谢逊"]="xie xun",["宋青书"]="song qingshu",["裸体男子"]="luoti nanzi",["轿夫"]="jiao fu",["华辉"]="hua hui",["哑巴"]="yaba",["达官贵人"]="gui ren",["行者"]="xing zhe",["玉音子"]="yuyin zi",["穆念慈"]="mu nianci",["土匪头"]="tufei tou",["李二嫂"]="li ersao",["马掌柜"]="ma zhanggui",["简长老"]="jian zhanglao",["杨逍"]="yang xiao",["庄家"]="zhuang jia",["刘好弈"]="liu haoyi",["史松"]="shi song",["龚光杰"]="gong guangjie",["淳于蓝"]="chunyu lan",["定静师太"]="dingjing shitai",["苗家女子"]="miaojia nuzi",["门主"]="men zhu",["红衣武士"]="wei shi",["朱富"]="zhu fu",["本相大师"]="benxiang dashi",["看守"]="kan shou",["杨过"]="yang guo",["流云使"]="liuyun shi",["韦一笑"]="wei yixiao",["澄志"]="luohan",["干光豪"]="gan guanghao",["彝族小伙"]="yizu xiaohuo",["白袍剑侠"]="baipao jianxia",["林玉龙"]="lin yulong",["教书先生"]="xian sheng",["冷谦"]="leng qian",["唐洋"]="tang yang",["李公公"]="li gonggong",["阿庆嫂"]="aqing sao",["婢女"]="bi nu",["马贼"]="ma zei",["王厨子"]="wang chuzi",["黑衣帮众"]="bangzhong",["张三丰"]="zhang sanfeng",["唐光雄"]="tang guangxiong",["施琅"]="shi lang",["道相禅师"]="chanshi",["老秀才"]="lao xiucai",["马五德"]="ma wude",["何师爷"]="he shiye",["仪质"]="yi zhi",["高则成"]="gao zecheng",["武将"]="wu jiang",["长安客商"]="changan keshang",["左子穆"]="zuo zimu",["刘老板"]="laoban",["高老者"]="gao laozhe",["缘根"]="yuan gen",["二丑"]="er chou",["慧合尊者"]="zunzhe",["玄难大师"]="dashi",
["汪啸风"] = "wang xiaofeng",
["小喇嘛"] ="xiao lama",
["胜雄"] = "sheng xiong",
["妙可"] = "miao ke",
["炼药喇嘛"] = "shishi lama",
["妙谛"] = "miao di",
["老僧"] = "lao seng",
["央宗"] = "yangzong",
["卓玛"] = "zhuoma",
["水笙"] = "shui sheng",
["陆天抒"] ="lu tianshu",
["刘承风"] = "liu chengfeng",
["水岱"] = "shui dai",
["敬香客"] = "jingxiang ke",
["枯木大师"] = "kumu dashi",
["焦木大师"] = "jiaomu dashi",
["鹿清笃"] ="lu qingdu",
["姬清虚"]="ji qingxu",
["帕洛萨贡"]="jian gong",
["绵羊"]="mian yang",
["拉洛萨多"]="shi bing",
["黄牛"]="huang niu",
["花卡"]="nv gong",
["夹桑喀"]="nv gong",
["副指挥史"] = "fu zhihuishi",
["猴子"]="hou zi",
["青蛙"]="qing wa",
["毒蛇"]="du she",
["杨康"]="yang kang",
["赵志敬"]="zhao zhijing",
["野兔"] ="ye tu",
["松鼠"] ="song shu",
["掌药道长"]="zhangyao daozhang",
["掌经道长"]="zhangjing daozhang",
["韩小莹"]="han xiaoying",
["华筝公主"]="Huazheng",
["柯镇恶"]="ke zhene",
["苟读"]="gou du",
["老虎"]="lao hu",
["虚竹"]="xu zhu",
["谭处端"]="tan chuduan",
["李志常"]="li zhichang",
["丘处机"]="qiu chuji",
["韩宝驹"]="han baoju",
["全金发"]="quan jinfa",
["艺人"]="yi ren",
["平寇将军"]="pingkou jiangjun",
["狗仆"]="gou pu",
["车骑将军"]="cheqi jiangjun",
["折冲将军"]="zhechong jiangjun",
["征东将军"]="zhengdong jiangjun",
["简捷"]="jian jie",
["杀手的雕像"]="statuary",
["闪电的雕像"]="statuary",
["近卫兵"]="jinwei bing",
["冯阿三"]="feng asan",
["大理老者"]="yanxiao",
["王处一"]="wang chuyi",
["掌园道长"]="zhangyuan daozhang",
["刘处玄"]="liu chuxuan",
["术赤"]="shu chi",
["康广陵"]="kang guangling",
["苏星河"]="su xinghe",
["拖雷"]="tuo lei",
["铁木真"]="tiemuzhen",
["近卫兵"]="jinwei bing",
["獒犬"]="dog",
["察合台"]="cha hetai",
["朱聪"]="zhu cong",
["火工道人"]="huogong daoren",
["祁志诚"]="qi zhicheng",
["崔志方"]="cui zhifang",
["掌理道长"]="zhangli daozhang",
["郝大通"]="hao datong",
["申志凡"]="shen zhifan",
["许老板"]="xu laoban",
["尹志平"]="yin zhiping",
["孙不二"]="sun buer",
["王志坦"]="wang zhitan",
["李萍"]="li ping",
["郭啸天"]="guo xiaotian",
["野猪"]="ye zhu",
["神雕"]="shen diao",
["蔡德忠"]="cai dezhong",
["房志起"]="fang zhiqi",
["南希仁"]="nan xiren",
["张阿生"]="zhang asheng",
["博尔术"]="boer shu",
["蜜蜂"]="bee",
}