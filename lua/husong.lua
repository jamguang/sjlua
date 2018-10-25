------少林护送
jobSpecial = jobSpecial or {}
jobSpecial["husong"] = true
job.list = job.list or {}
job.list["husong"] = function() if score.party and score.party=="少林派" and hp.exp and hp.exp>2000000 then return "少林护送" else return false end end
joblast = joblast or {}
joblast["恒山救援"]   = "husong"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["husong"] = "husongTriggerDel"

function husongTrigger()
	DeleteTriggerGroup("husongAsk")
    create_trigger_t('husongAsk1',"^(> )*你向玄慈大师打听有关",'','husongAsk')
    create_trigger_t('husongAsk2',"^(> )*这里没有这个人。$",'','husongNobody')
    SetTriggerOption("husongAsk1","group","husongAsk")
    SetTriggerOption("husongAsk2","group","husongAsk")
    EnableTriggerGroup("husongAsk",false)
    DeleteTriggerGroup("husongAccept")
    create_trigger_t('husongAccept1',"^(> )*玄慈大师说道：「(\\D*)现在(\\D*)。」$",'','husongConsider')
    create_trigger_t('husongAccept2',"^(> )*玄慈大师说道：「(\\D*)似乎尚无力单独完成这个任务。」$",'','husongFail')
    create_trigger_t('husongAccept3',"^(> )*玄慈大师说道：「嗯，已经有人在帮我了，你还是去忙点别的什么吧。」",'','husongBusy')
    create_trigger_t('husongAccept4',"^(> )*玄慈大师说道：「你刚才不是已经问过了吗？」",'','husongQuit')
    create_trigger_t('husongAccept5',"^(> )*玄慈大师说道：「你武功精进也太慢了，老衲怎么放心让你去干啊。」",'','husongBusy')
    create_triggerex_lvl('husongAccept6',"^(> )*玄慈大师说道：「我这里现在没有什么任务给你。」",'','husongBusy',95)
    SetTriggerOption("husongAccept1","group","husongAccept")
    SetTriggerOption("husongAccept2","group","husongAccept")
    SetTriggerOption("husongAccept3","group","husongAccept")
    SetTriggerOption("husongAccept4","group","husongAccept")
    SetTriggerOption("husongAccept5","group","husongAccept")
    SetTriggerOption("husongAccept6","group","husongAccept")
    EnableTriggerGroup("husongAccept",false)
	DeleteTriggerGroup("husongDashiAsk")
    create_trigger_t('husongDashiAsk1',"^(> )*你向(\\D*)大师打听有关",'','husongDashiStart')
    create_trigger_t('husongDashiAsk2',"^(> )*这里没有这个人。$",'','husongNobody')
    SetTriggerOption("husongDashiAsk1","group","husongDashiAsk")
    SetTriggerOption("husongDashiAsk2","group","husongDashiAsk")
    EnableTriggerGroup("husongDashiAsk",false)
	DeleteTriggerGroup("husongJiaotu")
    create_trigger_t('husongJiaotu1','^(> )*突然从路边冲出一个魔教教徒，一声不吭的向(\\D*)冲去。','','husongJiaotu')
	create_trigger_t('husongJiaotu2','^(> )*看起来魔教教徒想杀死你！','','husongFight')
    SetTriggerOption("husongJiaotu1","group","husongJiaotu")
	SetTriggerOption("husongJiaotu2","group","husongJiaotu")
    EnableTriggerGroup("husongJiaotu",false)
	DeleteTriggerGroup("husongFight")
    create_trigger_t('husongFight1',"^(> )*".. score.id .."'s jiaotu 不在这里",'','husongFightOver')
	create_trigger_t('husongFight2','^(> )*(\\D*)「啪」的一声倒在地上','','husongDie')
	create_trigger_t('husongFight3','^(> )*你仔细的上前打量了魔教教徒一番。','','husongCompare')
    SetTriggerOption("husongFight1","group","husongFight")
	SetTriggerOption("husongFight2","group","husongFight")
	SetTriggerOption("husongFight3","group","husongFight")
    EnableTriggerGroup("husongFight",false)
    DeleteTriggerGroup("husongFinish")
    create_trigger_t('husongFinish1','^(> )*(\\D*)不幸阵亡，你任务失败。','','husongDashiDie')
    create_trigger_t('husongFinish2',"^(> )*好，任务完成，你得到了(\\D*)点实战经验和(\\D*)点潜能。",'','husongFinishExp')
	create_trigger_t('husongFinish3','^(> )*(\\D*)在你的耳边悄声说道：刚才我碰到方生师弟，他似乎有一些','','husongFinishQuest')
    SetTriggerOption("husongFinish1","group","husongFinish")
    SetTriggerOption("husongFinish2","group","husongFinish")
	SetTriggerOption("husongFinish3","group","husongFinish")
    EnableTriggerGroup("husongFinish",false)
end
function husongTriggerDel()
    DeleteTriggerGroup("husongAsk")
    DeleteTriggerGroup("husongAccept")
    DeleteTriggerGroup("husongDashiAsk")
    DeleteTriggerGroup("husongJiaotu")
    DeleteTriggerGroup("husongFind")
	DeleteTriggerGroup("husongFight")
	DeleteTriggerGroup("husongFinish")
	DeleteTriggerGroup("husongBoat")
end
husongRoom={
    ["山坡"]   = "group/entry/slxiaoj1",
	["土路"]   = "group/entry/canroad6",
	["农田口"] = "zhiye/nongtian0",
	["桑林外"] = "zhiye/sanglin0",
}
function husongNobody()
    EnableTriggerGroup("husongAsk",false)
    return prepare_neili(husong)
end

function husong()
    if job.hstime then
	   if type(job.hstime)~="number" or os.time()-job.hstime<20*60 then
	      return checkJob()
	   end
	end 
    husongTrigger()
    job.name='husong'
	messageShow('少林护送任务：任务开始。')
    return prepare_lianxi(husongGo)
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["husong"] = "husongFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["husong"] = "husongFindFail"
function husongFindAgain()
    EnableTriggerGroup("husongFind",false)
    return go(find,road.id_o,dest.room)
end
function husongFindFail()
    EnableTriggerGroup("husongFind",false)
    return go(husongLostDashi,road.id_o,dest.room)
end
function husongGo()
    return go(husongStart,"嵩山少林","方丈室")
end
function husongStart()
    EnableTriggerGroup("husongAsk",true)
    fight_prepare()
    exe('ask xuanci about job')
end
function husongAsk()
    EnableTriggerGroup("husongAsk",false)
    EnableTriggerGroup("husongAccept",true)
end
function husongBusy()
    EnableTriggerGroup("husongAccept",false)
	EnableTriggerGroup("husongFinish",false)
	job.hstime=os.time()-14*60
    return check_heal()
end
function husongQuit()
    EnableTriggerGroup("husongAccept",false)
	checkBags()
	return go(husongCunWeapon,"扬州城","杂货铺")
end
function husongCunWeapon()
    weapon_unwield()
	exe('drop zhen')
    for p in pairs(Bag) do
	    if weaponStore[p] then
		   exe('cun '.. Bag[p].fullid)
		   exe('cun '.. Bag[p].fullid .. ' 2')
		   exe('cun '.. Bag[p].fullid .. ' 3')
		end
	end
	checkBags()
	return check_busy(husongCunDhd,1)
end
function husongCunDhd()
    tmp.hcnt = tmp.hcnt or 0
	tmp.hcnt = tmp.hcnt + 1
    local l_flag = false
	for p in pairs(Bag) do
	    if weaponStore[p] then
		   l_flag = true
		end
	end
    if l_flag and tmp.hcnt<8 then
	   return husongCunWeapon()
	end
	if Bag["大还丹"] then
	   exe('cun dahuan dan')
	end
	checkBags()
	return check_busy(husongCunBingchan)
end
function husongCunBingchan()
    if Bag["大还丹"] then
	   return husongCunDhd()
	end
	if Bag["朱睛冰蟾"] then
	   exe('cun bingchan')
	end
	checkBags()
	return check_busy(husongCunPearl)
end
function husongCunPearl()
    if Bag["朱睛冰蟾"] then
	   return husongCunBingchan()
	end
	if Bag["幸运珍珠"] then
	   exe('cun pearl')
	end
	checkBags()
	return check_busy(husongCunCbw)
end
function husongCunCbw()
    if Bag["幸运珍珠"] then
	   return husongCunPearl()
	end
	if Bag["川贝内息丸"] then
	   exe('cun chuanbei wan')
	end
	checkBags()
	return check_busy(husongCunJinhe)
end
function husongCunJinhe()
    if Bag["川贝内息丸"] then
	   return husongCunCbw()
	end
	if Bag["锦盒"] then
	   exe('cun jin he')
	end
	checkBags()
	return check_busy(husongCunBook)
end
function husongCunBook()
    if Bag["锦盒"] then
	   return husongCunJinhe()
	end
	if Bag["精英之书"] or Bag["倚天匠技残篇"] or Bag["屠龙匠技残篇"] then
	   exe('cun book')
	end
	checkBags()
	return check_busy(husongCunHammer)
end
function husongCunHammer()
    if Bag["精英之书"] or Bag["倚天匠技残篇"] or Bag["屠龙匠技残篇"] then
	   return husongCunBook()
	end
	if Bag["韦兰之锤"] then
	   exe("cun weilan's hammer")
	end
	checkBags()
	return check_busy(husongCunQuit)
end
function husongCunQuit()
    if Bag["韦兰之锤"] then
	   return husongCunHammer()
	end
    flag.quit=true
    wait.make(function()
         exe('quit')
	     wait.time(2)
		 exe('quit')
		 wait.time(5)
		 exe('look')
	end)
end
function husongFail()
    EnableTriggerGroup("husongAccept",false)
	job.zuhe["husong"] = nil
	dis_all()
	return husongQuest()
end
function husongFinishExp(n,l,w)
    tmp.jiaotu = tmp.jiaotu or 0
    messageShow('少林护送奖励：干掉【'.. tmp.jiaotu ..'】个魔教教徒，获得经验:【'.. w[2] ..'】点，，潜能:【'.. w[3] ..'】点！','darkorange')
	return husongFinish()
end
function husongFinishQuest(n,l,w)
    if Trim(w[2]) == job.target then
	   messageShow('少林护送任务：获得无相劫指学习提示！','red')
	   --dis_all()
	   --return husongQuest()
	   tmp.wxjz = true
	end
end
function husongQuest()
    return go(husongQuestAsk,"嵩山少林","心禅堂")
end
function husongQuestAsk()
    SetVariable("timewxz",os.date())
    exe('askk fangsheng about 少林武技')
	return check_heal()
end
function husongFinish()
    EnableTriggerGroup("husongAccept",false)
	disWait()
	messageShow('少林护送任务：任务结束。')
	return checkWait(husongFinishWait,2)
end
function husongFinishWait()
	if tmp.wxjz then
	    dis_all()
	    return husongQuest()
	end
	      --if score.id=="panix" then
	      --   dis_all()
	      --   return husongQuit()
	      --end
    return check_heal()
end
function husongConsider(n,l,w)
    job.hstime=os.time()
    EnableTriggerGroup("husongAccept",false)
    job.target=Trim(w[2])
    job.killer={}
    job.where=Trim(w[3])
	if job.where=="鼓楼" then job.where="鼓楼七层" end
	if job.where=="钟楼" then job.where="钟楼七层" end
    job.where="嵩山少林".. job.where
    job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
	tmp.jiaotu=0
    if not job.room or not path_cal() then
       messageShow('少林护送任务：任务地点【'..job.where..'】不可到达，任务放弃。')
       return check_bei(husongFail)
    end
    messageShow('少林护送任务：开始前往【'..job.where..'】！')
	return go(husongDashi,dest.area,dest.room)
end
function husongDashi()
    if locl.room~=job.room then
	   return go(husongDashi,job.area,job.room)
	end
	if not locl.id[job.target] then
	   return husongBusy()
	end
	return husongDashiAsk()
end
function husongDashiAsk()
    EnableTriggerGroup("husongDashiAsk",true)
    exe("ask ".. score.id .."'s dashi about 救援")
end
function husongDashiStart()
    EnableTriggerGroup("husongDashiAsk",false)
	EnableTriggerGroup("husongFinish",true)
	local path, len = path_cal_get(road.id,"hengshan/baiyunan")
	road.husong=utils.split(path,";")
	return checkWait(husongStep,2)
end
function husongStep()
       flag.idle = 0
       EnableTriggerGroup("husongFinish",true)
       if locl.room=="白云庵" then
	      return
	   end
	   if type(road.husong)~="table" then
	      return husongWhere()
	   end
	   if table.getn(road.husong)==0 then
	      return husongWhere()
	   end
	   if hp.qixue_per<60 then
	      exe('fu dan')
	   end
	   road.step = road.husong[1]
	   if isNil(road.step) or road.step=="halt" or road.step=="open gate" or string.find(road.step,"#") then
	      table.remove(road.husong,1)
	      return husongStep()
	   end
	   EnableTriggerGroup("husongJiaotu",true)
	   flag.jiaotu=nil
	   flag.lost=nil
	   if locl.room=="山门殿" then
	      exe('open gate')
	   end
	   if locl.room=="渡船" then
	      return husongBoat()
	   end
	   if locl.room=="陕晋渡口" and road.id=="changan/road2" then
		  exe('yell boat;enter')
		  return check_bei(husongBoat)
	   end
	   exe(road.step)
	   exe('hp')
	   return check_halt(husongLocate)
end
function husongBoat()
       locate()
	   return check_busy(husongBoatChk)
end
function husongBoatChk()
       if locl.room=="渡船" then
	      if not locl.id[job.target] then
		     exe('out')
			 locate()
			 checkWait(husongStep,1)
		  end
	      return husongBoatWait()
	   else
	      return checkWait(husongStep,2)
	   end
end
function husongBoatWait()
       DeleteTriggerGroup("husongBoat")
       create_trigger_t('husongBoat1','^>*\\s*(说着将一块踏脚板搭上堤岸，形成一个出去|渡船猛地一震，已经靠岸)','','husongBoatOut')
	   SetTriggerOption("husongBoat1","group","husongBoat")
end
function husongBoatOut()
    EnableTriggerGroup("husongBoat",false)
	exe('out')
	--road.id="changan/road3"
	--table.remove(road.husong,1)
	return check_halt(husongLocate)
end
function husongJiaotu(n,l,w)
    if w[2]== job.target then
	   tmp.jiaotu = tmp.jiaotu or 0
	   tmp.jiaotu = tmp.jiaotu + 1
	   return husongFight()
	end
end
function husongFight()
    flag.times=1
    dis_all()
    EnableTriggerGroup("husongJiaotu",false)
	EnableTriggerGroup("husongFight",true)
	EnableTriggerGroup("husongFinish",true)
	flag.jiaotu=true
	exe("compare ".. score.id .."'s jiaotu")
	exe("kill ".. score.id .."'s jiaotu")
	exe('set wimpy 100')
	exe('pfmpfm')
end
function husongCompare()
    --flag.jiaotu=true
	job.killer["魔教教徒"]=score.id .."'s jiaotu"
	killPfm(score.id .."'s jiaotu")
end
function husongDie()
    exe("compare ".. score.id .."'s jiaotu")
end
function husongFightOver()
    EnableTriggerGroup("husongFight",false)
	flag.jiaotu=nil
	job.killer={}
    return husongLocate()
end
function husongLocate()
    DeleteTimer('husong')
    for i=1,2 do
	    exe('get silver from corpse '.. i)
	end
    if flag.jiaotu then
	   return
	end
    locate()
	return check_busy(husongChkDashi)
end
function husongChkDashi()
    if flag.lost then
	   flag.lost=nil
	   return husongDashiStart()
	end
    --if not flag.jiaotu then
	   table.remove(road.husong,1)
	   road.id=map.rooms[road.id].ways[road.step]
	--end
	flag.jiaotu=nil
	if isNil(road.id) then
	   return husongWhere()
	end
	if locl.room~=map.rooms[road.id].name then
	   return husongWhere()
	end
    if locl.id[job.target] then
	   if hp.neili<hp.neili_max then
	      return prepare_neili(husongStep)
	   else
	      return husongStep()
	   end
	else
	   return husongLost()
	end
end
function husongWhere()
    if locl.area=="不知道哪里" then
	   if husongRoom[loc.room] then
	      road.id=husongRoom[loc.room]
		  messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
		  return husongDashiStart()
	   else
	      --messageShow('少林护送任务：无法在地点【'.. locl.area .. locl.room ..'】重新启程，任务放弃。')
	      return husongLostDashi()
	   end
	elseif locl.room=="陕晋渡口" then
	   messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
	   if locl.exit["southeast"] or locl.exit["south"] then
	      road.id="changan/road2"
		  return husongDashiStart()
	   end
	   if locl.exit["north"] then
	      road.id="changan/road3"
		  return husongDashiStart()
	   end
	   locate()
	   return check_busy(husongWhere)
	else
	   if locl.room=="石阶" then 
	      road.id="shaolin/ting"
		  messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
		  return husongDashiStart()
	   end
	   if locl.room=="黄河岸边" then 
	      road.id="huanghe/huanghe7"
		  messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
		  return husongDashiStart()
	   end
	   local l_rooms=getRooms(locl.room,locl.area)
	   if locl.area=="长安城" and locl.room=="大道" then
	      local l_cnt = math.random(1,table.getn(l_rooms))
		  road.id=l_rooms[l_cnt]
		  messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
		  return husongDashiStart()
	   end
	   if table.getn(l_rooms)==0 then
	      --messageShow('少林护送任务：无法在地点【'.. locl.area .. locl.room ..'】重新启程，任务放弃。')
	      return husongLostDashi()
	   else
	      local l_dest,l_distance=getNearRoom("shaolin/fumoquan",l_rooms)
		  if l_dest then
		     road.id=l_dest
			 messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】找到大师，重新启程。')
			 return husongDashiStart()
		  else
		     --messageShow('少林护送任务：无法在地点【'.. locl.area .. locl.room ..'】重新启程，任务放弃。')
		     return husongLostDashi()
		  end
	   end
	end
end
function husongDashiDie(n,l,w)
    if w[2] == job.target then
	   return husongLostEver()
	end
end
function husongLostEver()
    dis_all()
    messageShow('少林护送任务：在地点【'.. locl.area .. locl.room ..'】永远的失去大师，任务放弃。','blue')
	return husongBusy()
end
function husongLost()
    DeleteTriggerGroup("husongFind")
    create_trigger_t('husongFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)$','','husongTarget')
	create_trigger_t('husongFind2','^(> )*\\D*'..job.target..'正在运功疗伤','','husongTarget')
	create_trigger_t('husongFind3','^(> )*\\D*'..job.target..'的尸体\\((\\D*)\\)','','husongLostEver')
	create_trigger_t('husongFind4','^(> )*\\D*'..job.target..'\\((\\D*)\\) <昏迷不醒>$','','husongTargetWait')
	create_trigger_t('husongFind5','^(> )*\\D*'..job.target..'\\((\\D*)\\) <战斗中>$','','husongTarget')
    SetTriggerOption("husongFind1","group","husongFind")
	SetTriggerOption("husongFind2","group","husongFind")
	SetTriggerOption("husongFind3","group","husongFind")
	SetTriggerOption("husongFind4","group","husongFind")
	SetTriggerOption("husongFind5","group","husongFind")
	--EnableTriggerGroup("husongFind",false)
	job.flag()
	messageShow('少林护送任务：在【'.. locl.area .. locl.room ..'】丢失大师，开始寻找！')
	flag.lost=true
	road.id_o =road.id
	find()
end
function husongTargetWait()
    dis_all()
	flag.times=1
	EnableTriggerGroup("husongFinish",true)
	locate()
	DeleteTriggerGroup("husongFaint")
    create_trigger_t('husongFaint1','^(> )*\\D*'..job.target..'身子动了动，口中呻吟了几声，清醒过来','','husongWake')
	SetTriggerOption("husongFaint1","group","husongFaint")
	create_timer_s('husong',50,'husongWake')
	--return check_busy(husongLostDashi)
end
function husongWake()
    EnableTriggerGroup("husongWake",false)
    return check_busy(husongLostDashi)
end
function husongTarget()
    flag.times=1
    DeleteTimer('husong')
    dis_all()
	EnableTriggerGroup("husongFinish",true)
	locate()
	return check_busy(husongLostDashi)
end
function husongLostDashi()
    DeleteTimer('husong')
    if locl.id[job.target] then
	   return husongFight()
	else
	   return husongLost()
	end
end