--songshan
job.list = job.list or {}
job.list["songshan"] = function() if  hp.exp>100000 and hp.exp<4000000 then return "嵩山并派" else return false end end
joblast = joblast or {}
joblast["嵩山并派"]   = "songshan"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["songshan"] = "songshanTriggerDel"
jobFindAgain = jobFindAgain or {}
jobFindAgain["songshan"] = "songshanFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["songshan"] = "songshanFindFail"
faintFunc = faintFunc or {}
faintFunc["songshan"] = "songshanFaint"

local noPerform = {
     ["亲兵"]     = true,
	 ["亲兵队长"] = true,
	 ["富家公子"] = true,
	 ["黑衣大盗"] = true,
	 ["大盗"]     = true,
	 ["独脚大盗"] = true,
	 ["王掌柜"]   = true,
	 ["刘老板"]   = true,
	 ["钱青健"]   = true,
	 ["吴青烈"]   = true,
	 ["沈青刚"]   = true,
	 ["马青雄"]   = true,
	 ["侯通海"]   = true,
	 ["李员外"]   = true,
	 ["凌震天"]   = true,
	 ["黄令天"]   = true,
}
local npcExp = {
     ["马光佐"]   = 500000,
	 ["玉虚散人"] = 1000000,
	 ["陆大有"]   = 1000000,
	 ["高升泰"]   = 1000000,
	 ["心观大师"] = 2000000,
	 ["丘处机"] = 4000000,
}

function songshanTrigger()
    DeleteTriggerGroup("songshanAsk")
    create_trigger_t('songshanAsk1',"^(> )*你向左冷禅打听有关",'','songshanAsk')
    create_trigger_t('songshanAsk2',"^(> )*这里没有这个人。$",'','songshanNobody')
    SetTriggerOption("songshanAsk1","group","songshanAsk")
    SetTriggerOption("songshanAsk2","group","songshanAsk")
    EnableTriggerGroup("songshanAsk",false)
    DeleteTriggerGroup("songshanAccept")
    create_trigger_t('songshanAccept1',"^(> )*左冷禅说道：「(你听好了，有弟子回报|对了，)(\\D*)(这人对我五岳并派之举深表不满|和我交情不错，如得他相助)",'','songshanNpc')
    create_trigger_t('songshanAccept2',"^(> )*左冷禅说道：「(嘿嘿，他在|你就代表我去)(\\D*)(一带，你去将他杀了|邀请他，)",'','songshanConsider')
    create_trigger_t('songshanAccept3',"^(> )*左冷禅说道：「不是让你去",'','songshanFangqi')
    create_trigger_t('songshanAccept4',"^(> )*左冷禅说道：「我正忙着呢，你等等。",'','songshanBusy')
    create_trigger_t('songshanAccept5',"^(> )*左冷禅说道：「你刚做完任务，先休息一下吧。」",'','songshanFail')
    create_trigger_t('songshanAccept6',"^(> )*左冷禅说道：「你没有领任务,和我嚷嚷什么?",'','songshanFail')
    create_trigger_t('songshanAccept7',"^(> )*左冷禅说道：「嗯，我现在正在思考并派大计，你别打扰。",'','songshanFail')
    create_trigger_t('songshanAccept8',"^(> )*左冷禅说道：「既然你干不了也没关系",'','songshanFail')
    create_trigger_t('songshanAccept9',"^(> )*左冷禅说道：「嗯，我现在忙，你别打扰。",'','songshanBusy')
    create_trigger_t('songshanAccept10',"^(> )*左冷禅说道：「现在没有任务，你等下再来吧。」",'','songshanBusy')
    SetTriggerOption("songshanAccept1","group","songshanAccept")
    SetTriggerOption("songshanAccept2","group","songshanAccept")
    SetTriggerOption("songshanAccept3","group","songshanAccept")
    SetTriggerOption("songshanAccept4","group","songshanAccept")
    SetTriggerOption("songshanAccept5","group","songshanAccept")
    SetTriggerOption("songshanAccept6","group","songshanAccept")
    SetTriggerOption("songshanAccept7","group","songshanAccept")
    SetTriggerOption("songshanAccept8","group","songshanAccept")
    SetTriggerOption("songshanAccept9","group","songshanAccept")
    SetTriggerOption("songshanAccept10","group","songshanAccept")
    EnableTriggerGroup("songshanAccept",false)
    DeleteTriggerGroup("songshanFight")
    create_trigger_t('songshanFight1','^(> )*(\\D*)「啪」的一声倒在地上','','songshanDie')
    create_trigger_t('songshanFight2','^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。','','songshanNFaint')
    create_trigger_t('songshanFight3',"^(> )*这里没有(\\D*)。",'','songshanLost')
    create_trigger_t('songshanFight4',"^(> )*(这里没有这个人耶|你想邀请的对象不在这里)",'','songshanFind')
    create_trigger_t('songshanFight5',"^(> )*(你双手一拱，笑着|你胜了这招，向后跃开三尺|你哈哈大笑，说道：承让了！|没看见|你正忙着呢，先歇口气吧|你正在打架呢，等会儿再说吧|你正在极力邀请人家呢|你要先等他醒过来再说|你精神不振，先休息一下吧)",'','songshanQing')
    create_trigger_t('songshanFight6',"^(> )*(你的任务好象不是要邀请这人吧|你的任务好象不是要邀请谁吧)",'','songshanFangqiGo')
    create_trigger_t('songshanFight7',"^(> )*(\\D*)已经接受了邀请，你不用再费劲啦。",'','songshanBackCheck')
    create_trigger_t('songshanFight8',"^(> )*(\\D*)决定跟随你一起行动。",'','songshanFollow')
    create_trigger_t('songshanFight9',"^(> )*(\\D*)(向后一纵|向后退了几步，说道|轻蔑地扫了|嘿嘿一声：|脸色苍白，只看了|转过头来，上上下下看了|脸色微变，说道：佩服，佩服|一脸不耐烦的表情)",'','songshanQingCheck')
    SetTriggerOption("songshanFight1","group","songshanFight")
    SetTriggerOption("songshanFight2","group","songshanFight")
    SetTriggerOption("songshanFight3","group","songshanFight")
    SetTriggerOption("songshanFight4","group","songshanFight")
    SetTriggerOption("songshanFight5","group","songshanFight")
    SetTriggerOption("songshanFight6","group","songshanFight")
    SetTriggerOption("songshanFight7","group","songshanFight")
    SetTriggerOption("songshanFight8","group","songshanFight")
    SetTriggerOption("songshanFight9","group","songshanFight")
    EnableTriggerGroup("songshanFight",false)
    DeleteTriggerGroup("songshanCut")
    create_trigger_t('songshanCut1','^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','songshanCutCon')
    create_trigger_t('songshanCut2','^(> )*你得用件锋利的器具才能切下这尸体的头来。','','songshanCutWeapon')
    SetTriggerOption("songshanCut1","group","songshanCut") 
    SetTriggerOption("songshanCut2","group","songshanCut")
    EnableTriggerGroup("songshanCut",false)
    DeleteTriggerGroup("songshanGive")
    create_trigger_t('songshanGive1','^(> )*你给左冷禅一颗(\\D*)的首级。','','songshanFinish')
    SetTriggerOption("songshanGive1","group","songshanGive")
    EnableTriggerGroup("songshanGive",false)
    DeleteTriggerGroup("songshanHead")
    create_trigger_t('songshanHead1','^(> )*这是一颗(\\D*)的(首级|人头)','','songshanHeadCheck')
    create_trigger_t('songshanHead2','^(> )*你把 "action" 设定为 "check_head" 成功完成。','','songshanHeadCon')
    SetTriggerOption("songshanHead1","group","songshanHead")
    SetTriggerOption("songshanHead2","group","songshanHead")
    EnableTriggerGroup("songshanHead",false)
    DeleteTriggerGroup("songshanFinish")
    create_trigger_t('songshanFinish1','^(> )*左冷禅说道：「(\\D*)能来，我嵩山派又多了一份力量啦','','songshanFinishCheck')
    SetTriggerOption("songshanFinish1","group","songshanFinish")
    EnableTriggerGroup("songshanFinish",false)
end
function songshanTriggerDel()
    DeleteTriggerGroup("songshanAsk")
    DeleteTriggerGroup("songshanAccept")
    DeleteTriggerGroup("songshanFight")
    DeleteTriggerGroup("songshanFind")
    DeleteTriggerGroup("songshanCut")
    DeleteTriggerGroup("songshanGive")
    DeleteTriggerGroup("songshanHead")
    DeleteTriggerGroup("songshanFinish")
end
function songshanNobody()
    EnableTriggerGroup("songshanAsk",false)
    songshan()
end
function songshan()
    if hp.shen>=0 then
	   return turnShen('-')
	end
    songshanTrigger()
    job.name='songshan'
    job.time.b=os.time()
    prepare_neili(songshanGo)
end
function songshanGo()
    go(songshanStart,"嵩山","封禅台")
end
function songshanStart()
    EnableTriggerGroup("songshanAsk",true)
    exe('ask zuo lengchan about job')
end
function songshanAsk()
    EnableTriggerGroup("songshanAsk",false)
    EnableTriggerGroup("songshanAccept",true)
end
function songshanBusy()
    EnableTriggerGroup("songshanAccept",false)
    check_bei(songshanBusyDazuo)
end
function songshanBusyDazuo()
    prepare_lianxi(songshanStart)
end
function songshanFail()
    EnableTriggerGroup("songshanAccept",false)
    job.last="songshan"
    check_heal()
end
function songshanNpc(n,l,w)
    job.target=Trim(w[3])
    job.killer={}
    job.killer[job.target]=true
end
function songshanConsider(n,l,w)
    EnableTriggerGroup("songshanAccept",false)
    job.last='songshan'
    job.id=nil
    if string.find(w[4],"请") then
       job.type="qing"
    else 
       job.type="kill"
    end
    job.where=Trim(w[3])
    job.where=addrTrim(job.where)
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
    if string.find(sldsmCancel,job.target) then
       messageShow('嵩山任务：任务目标【'..job.target..'】不可到达，任务放弃。')
       return songshanFangqi()
    end
    if not job.room or not path_cal() then
       messageShow('嵩山任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return songshanFangqi()
    end
	if npcExp[job.target] and npcExp[job.target]>hp.exp then
	   messageShow('嵩山任务：任务目标【'..job.target..'】不可力敌，任务放弃。')
       return songshanFangqi()
	end
    check_bei(songshanFind)
    if job.type and job.type=="qing" then
       messageShow('嵩山任务：开始前往【'..job.where..'】请【'..job.target..'】！')
    else
       messageShow('嵩山任务：开始前往【'..job.where..'】杀【'..job.target..'】！')
    end
end
function songshanFangqiGo()
    go(songshanFangqi,'嵩山','封禅台')
end
function songshanFangqi()
    EnableTriggerGroup("songshanAsk",true)
    check_bei(songshanFangqiAsk)
end
function songshanFangqiAsk()
    EnableTriggerGroup("songshanAccept",false)
    exe('ask zuo lengchan about cancel')
end
function songshanFind()
    DeleteTriggerGroup("songshanFind")
    create_trigger_t('songshanFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','songshanTarget')
    SetTriggerOption("songshanFind1","group","songshanFind")
    EnableTrigger("songshanFind1",false)
    flag.times=1
    fight_prepare()
    go(songshanFindAct,job.area,job.room)    
end
function songshanFindAgain()
    EnableTriggerGroup("songshanFind",false)
    return go(songshanFindAct,job.area,job.room)
end
function songshanFindFail()
    EnableTriggerGroup("songshanFind",false)
    return songshanFangqiGo()
end
function songshanFaint()
    EnableTriggerGroup("songshanFind",false)
    return songshanFangqiGo()
end
function songshanFindAct()
    EnableTriggerGroup("songshanFind",true)
    job.flag()
    exe('look')
    find()
    messageShow('嵩山任务：开始寻找【'..dest.area .. dest.room ..'】的'..'【'.. job.target ..'】！')
end
function songshanTarget(n,l,w)
    EnableTriggerGroup("songshanFind",false)
    EnableTriggerGroup("songshanFight",true)
    flag.wait=0
    flag.find=1
    thread_resume(lookfor)
    job.id=string.lower(w[2])
    job.killer[job.target]=job.id
    exe('halt;follow '..job.id)
    if job.type and job.type=="qing" then
       killPfm(job.id,"qing")
	   if noPerform[job.target] then
	      exe('unset wimpy')
	   end
    else
       killPfm(job.id)
    end
end
function songshanNFaint(n,l,w)
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          exe('halt')
		  exe('unset wimpy')
		  exe('yun jing;yun qi;dazuo '.. hp.dazuo)
	      return check_bei(songshanQing)
       else
          exe('kill '..job.id)
       end
    end
end
function songshanFollow(n,l,w)
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          exe('halt')
	  return songshanBack()
       end
    end
end
function songshanDie(n,l,w)
    if job.target==w[2] then
       if job.type and job.type=="qing" then
          --exe('qing '..job.id)
		  return check_bei(songshanQing,1)
       else
          DeleteTimer("perform")
          check_bei(songshanCut)
       end
    end
end
function songshanQingCheck(n,l,w)
    if job.target==w[2] or b.target=="你" then
       return checkWait(songshanQing,3)
    end
	
end
function songshanQing()
    exe('hp')
    checkWait(songshanQingAct,2)
end
function songshanQingAct()
    --if hp.neili<hp.neili_lim then
    --   return prepare_neili(songshanQing,1)
    --else
       exe('yun jing;yun jingli;qing '..job.id)
    --end
end
function songshanCut()
    EnableTriggerGroup("songshanFight",false)
    EnableTriggerGroup("songshanCut",true)
    exe('halt')
	weaponWieldCut()
    for i=1,3 do
        exe('qie corpse '..i)
    end
end
function songshanCutWeapon()
    EnableTriggerGroup("songshanCut",false)
    checkWait(songshanCut,1)
end
function songshanCutCon(n,l,w)
    EnableTriggerGroup("songshanCut",false)
    if job.target~=tostring(w[2]) then
       exe('drop head')
       check_bei(songshanCut)
    else
       return songshanBack()
    end
end
function songshanLost(n,l,w)
    if job.id==Trim(w[2]) then
       dis_all()
       return songshanFind()
    end
end
function songshanBckCheck(n,l,w)
    if job.target==w[2] then
       songshanBack()
    end
end
function songshanBack()
    DeleteTimer("perform")
    EnableTriggerGroup("songshanFight",false)
    EnableTriggerGroup("songshanFinish",true)
    go(songshanHead,'嵩山','封禅台')
end
function songshanHead()
    if job.type and job.type=="qing" then
       --cntr1 = countR(8)
	   tmp.wait = 1
       return songshanFinishWait()
    else
       EnableTriggerGroup("songshanHead",true)
       tmp.flag=0
       exe('look head')
       exe('alias action check_head')
    end
end
function songshanHeadCheck(n,l,w)
    if w[2] == job.target then
       tmp.flag=1
    end
end
function songshanHeadCon()
    EnableTriggerGroup("songshanHead",false)
    if tmp.flag==1 then
       return songshanGive()
    else
       return songshanFinish()
    end
end
function songshanGive()
    EnableTriggerGroup("songshanGive",true)
    exe('give head to zuo lengchan')
end
function songshanFinishWait()
    tmp.wait = tmp.wait or 1
	tmp.wait = tmp.wait + 1
    --if cntr1()>1 then
	if tmp.wait > 10 then
       return songshanFinish()
    else
       exe('sd;nu')
       return checkWait(songshanFinishWait,3)
    end
end
function songshanFinishCheck(n,l,w)
    if w[2]==job.target then
       return songshanFinish()
    end
end
function songshanFinish()
    EnableTriggerGroup("songshanFight",false)
    messageShow('嵩山任务：任务完成！')
    return checkWait(check_heal,3)
end