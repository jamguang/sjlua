--tmonk
job.list = job.list or {}
job.list["tmonk"] = function() if score.party and score.party == "少林派" and hp.exp<2000000 and string.find(score.master,"渡") then return "少林教和尚" else return false end end
joblast = joblast or {}
joblast["训练武僧"]   = "tmonk"

	  
function tmonkTrigger()
    DeleteTriggerGroup("tmonkFollow")
    create_trigger_t('tmonkFollow1',"^(> )*你决定跟随玄惭大师一起行动。",'','tmonkFollow')
    create_trigger_t('tmonkFollow2',"^(> )*这里没有 xuancan dashi。$",'','tmonkNobody')
    SetTriggerOption("tmonkFollow1","group","tmonkFollow")
    SetTriggerOption("tmonkFollow2","group","tmonkFollow")
    EnableTriggerGroup("tmonkFollow",false)
    DeleteTriggerGroup("tmonkAsk")
    create_trigger_t('tmonkAsk1',"^(> )*你向玄惭大师打听有关",'','tmonkAsk')
    create_trigger_t('tmonkAsk2',"^(> )*这里没有这个人。$",'','tmonkNobody')
    SetTriggerOption("tmonkAsk1","group","tmonkAsk")
    SetTriggerOption("tmonkAsk2","group","tmonkAsk")
    EnableTriggerGroup("tmonkAsk",false)
    DeleteTriggerGroup("tmonkAccept")
    create_trigger_t('tmonkAccept1',"^(> )*玄惭大师说道：「你刚才不是已经问过了吗？",'','tmonkStart')
    create_trigger_t('tmonkAccept2',"^(> )*玄惭大师说道：「你正在忙着做其它任务呢。",'','tmonkBusy')
    create_trigger_t('tmonkAccept3',"^(> )*玄惭大师说道：「你刚训练武僧结束，还是先休息一会吧。",'','tmonkFangqi')
    create_trigger_t('tmonkAccept4',"^(> )*玄惭大师说道：「你现在正忙着做其他任务呢",'','tmonkBusy')
    create_trigger_t('tmonkAccept5',"^(> )*玄惭大师说道：「\\D*你累犯数戒，身带重罪",'','tmonkGuilty')
    create_trigger_t('tmonkAccept6',"^(> )*玄惭说道：好吧，你就在罗汉堂里训练武僧",'','tmonkStart')
    SetTriggerOption("tmonkAccept1","group","tmonkAccept")
    SetTriggerOption("tmonkAccept2","group","tmonkAccept")
    SetTriggerOption("tmonkAccept3","group","tmonkAccept")
    SetTriggerOption("tmonkAccept4","group","tmonkAccept")
    SetTriggerOption("tmonkAccept5","group","tmonkAccept")
    SetTriggerOption("tmonkAccept6","group","tmonkAccept")
    EnableTriggerGroup("tmonkAccept",false)
    DeleteTriggerGroup("tmonkFind")
    create_trigger_t('tmonkFind1','^^(> )*\\D*玄惭大师\\((\\D*)\\)','','tmonkDashi')
    SetTriggerOption("tmonkFind1","group","tmonkFind")
    EnableTriggerGroup("tmonkFind",false)
    DeleteTriggerGroup("tmonkWujiAsk")
    create_trigger_t('tmonkWujiAsk1',"^(> )*你向圆(心|业|觉|慧|灭|音)和尚打听有关",'','tmonkWujiAsk')
    create_trigger_t('tmonkWujiAsk2',"^(> )*这里没有这个人。$",'','tmonkWujiNobody')
    SetTriggerOption("tmonkWujiAsk1","group","tmonkWujiAsk")
    SetTriggerOption("tmonkWujiAsk2","group","tmonkWujiAsk")
    EnableTriggerGroup("tmonkWujiAsk",false)
	DeleteTriggerGroup("tmonkWujiReply")
    create_trigger_t('tmonkWujiReply1',"^(> )*圆(心|业|觉|慧|灭|音)和尚说道：「这个可不能乱说。",'','tmonkFinish')
    create_trigger_t('tmonkWujiReply2',"^(> )*圆(心|业|觉|慧|灭|音)和尚一脸神秘地",'','tmonkWujiNobody')
    create_trigger_t('tmonkWujiReply3',"^(> )*圆(心|业|觉|慧|灭|音)和尚生气地看着你",'','tmonkWujiNobody')
    create_trigger_t('tmonkWujiReply4',"^(> )*圆(心|业|觉|慧|灭|音)和尚说道：「小僧在学",'','tmonkTeachStart')
    SetTriggerOption("tmonkWujiReply1","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply2","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply3","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply4","group","tmonkWujiReply")
    EnableTriggerGroup("tmonkWujiReply",false)
	DeleteTriggerGroup("tmonkTeach")
    create_trigger_t('tmonkTeach1',"^(> )*你还是先去跟玄惭大师打声招呼吧。",'','tmonkFinish')
    create_trigger_t('tmonkTeach2',"^(> )*圆(心|业|觉|慧|灭|音)和尚说道：「我正由",'','tmonkWujiNobody')
    create_trigger_t('tmonkTeach3',"^(> )*你的修为还不如我呢，还想教我？",'','tmonkWujiKill')
    create_trigger_t('tmonkTeach4',"^(> )*圆(心|业|觉|慧|灭|音)和尚太累了，现在没有办法学。",'','tmonkChange')
	create_trigger_t('tmonkTeach5',"^(> )*圆(心|业|觉|慧|灭|音)和尚正忙着呢。",'','tmonkChange')
	create_trigger_t('tmonkTeach6',"^(> )*你(正忙着呢。|尽心竭力，对)",'','tmonkContinue')
	create_trigger_t('tmonkTeach7','^(> )*你把 "action" 设定为 "teach" 成功完成。$','','tmonkTeachCon')
	create_trigger_t('tmonkTeach8',"^(> )*(\\D*)在你旁边，你无法专心指点。",'','tmonkChange')
	create_trigger_t('tmonkTeach9',"^(> )*圆(心|业|觉|慧|灭|音)和尚神情振奋，一声大叫向(\\D*)奔去",'','tmonkMotou')
    SetTriggerOption("tmonkTeach1","group","tmonkTeach")
    SetTriggerOption("tmonkTeach2","group","tmonkTeach")
    SetTriggerOption("tmonkTeach3","group","tmonkTeach")
    SetTriggerOption("tmonkTeach4","group","tmonkTeach")
	SetTriggerOption("tmonkTeach5","group","tmonkTeach")
	SetTriggerOption("tmonkTeach6","group","tmonkTeach")
	SetTriggerOption("tmonkTeach7","group","tmonkTeach")
	SetTriggerOption("tmonkTeach8","group","tmonkTeach")
	SetTriggerOption("tmonkTeach9","group","tmonkTeach")
    EnableTriggerGroup("tmonkTeach",false)
	DeleteTriggerGroup("tmonkMotouFind")
    create_trigger_t('tmonkMotouFind1','^^(> )*邪道魔头高举右拳，对着你','','tmonkMotouKill')
    SetTriggerOption("tmonkMotouFind1","group","tmonkMotouFind")
    EnableTriggerGroup("tmonkMotouFind",false)
    DeleteTriggerGroup("tmonkFight")
    create_trigger_t('tmonkFight1','^(> )*邪道魔头「啪」的一声倒在地上','','tmonkDie')
    create_trigger_t('tmonkFight2','^(> )*邪道魔头神志迷糊，脚下一个不稳，倒在地上昏了过去。','','tmonkFaint')
    SetTriggerOption("tmonkFight1","group","tmonkFight")
    SetTriggerOption("tmonkFight2","group","tmonkFight")
    EnableTriggerGroup("tmonkFight",false)
end
function tmonkTriggerDel()
    DeleteTriggerGroup("tmonkFollow")
    DeleteTriggerGroup("tmonkAsk")
    DeleteTriggerGroup("tmonkAccept")
    DeleteTriggerGroup("tmonkFight")
    DeleteTriggerGroup("tmonkFind")
	DeleteTriggerGroup("tmonkWujiAsk")
	DeleteTriggerGroup("tmonkWujiReply")
	DeleteTriggerGroup("tmonkTeach")
	DeleteTriggerGroup("tmonkMotouFind")
end

function tmonk()
    job.name='tmonk'
    tm = tm or {}
	tmroom = {}
	tmroom["shaolin/wstang1"] = true
	tmroom["shaolin/wstang2"] = true
	tmroom["shaolin/wstang3"] = true
	tmroom["shaolin/wstang4"] = true
	tmroom["shaolin/wstang5"] = true
	tmroom["shaolin/wstang6"] = true
	for p in pairs(tm) do
	    tmroom[p] = nil
	end
    tmonkTrigger()
	messageShow('Tmonk任务：任务开始。','green')
	
    return prepare_neili(tmonkGuilty)
end
function tmonkFindAgain()
    EnableTriggerGroup("tmonkFind",false)
	EnableTriggerGroup("tmonkMotouFind",false)
    return go(find,dest.area,dest.room)
end
function tmonkGo()
    return go(tmonkXuancan,"嵩山少林","演武堂")
end
function tmonkXuancan()
    EnableTriggerGroup("tmonkFind",true)
    job.flag()
	flag.times=2
    return find()
end
function tmonkDashi()
    flag.find = 1
	dis_all()
	EnableTriggerGroup("tmonkFind",false)
    EnableTriggerGroup("tmonkFollow",true)
    exe('follow xuancan dashi')
end
function tmonkNobody()
    EnableTriggerGroup("tmonkFollow",false)
    EnableTriggerGroup("tmonkAsk",false)
    return go(tmonkXuancan,"嵩山少林","演武堂")
end
function tmonkFollow()
    EnableTriggerGroup("tmonkFollow",false)
    EnableTriggerGroup("tmonkAsk",true)
    exe('ask xuancan dashi about 罗汉堂值勤')
end
function tmonkAsk()
    EnableTriggerGroup("tmonkAsk",false)
    EnableTriggerGroup("tmonkAccept",true)
	job.last = 'tmonk'
    exe('follow none')
end
function tmonkGuilty()
    EnableTriggerGroup("tmonkAccept",false)
	if score.party and score.party=="少林派" and score.master=="无名老僧" and skills["buddhism"] and skills["buddhism"].lvl==200 then
	   return go(tmonkFofa,"嵩山少林","里屋")
	end
    return go(tmonkCh,'嵩山少林','戒律院')
end
function tmonkFofa()
    exe("ask wuming about 佛法")
	return tmonkGo()
end
function tmonkCh()
    checkWait(tmonkGo,2)
end
function tmonkFangqi()
    EnableTriggerGroup("tmonkAccept",false)
    job.last='tmonk'
    return check_heal()
end
function tmonkBusy()
    EnableTriggerGroup("tmonkAccept",false)
    return prepare_lianxi(tmonk)
end
function tmonkStart()
    EnableTriggerGroup("tmonkAccept",false)
	job.last='tmonk'
    if countTab(tm) > 0 then
       local l_id
       for p in pairs(tm) do
           l_id = p
       end
       return go(tmonkWuji,l_id)
    else
       return go(tmonkWuji,"shaolin/wstang1")
    end
end
function tmonkWuji()
    EnableTriggerGroup("tmonkWujiAsk",true)
    exe('ask monk about 武技')
end
function tmonkWujiAsk()
    EnableTriggerGroup("tmonkWujiAsk",false)
    EnableTriggerGroup("tmonkWujiReply",true)
end
function tmonkWujiNobody()
    EnableTriggerGroup("tmonkWujiReply",false)
    EnableTriggerGroup("tmonkWujiAsk",false)
	EnableTriggerGroup("tmonkTeach",false)
	tm[road.id] = nil
	tmroom[road.id] = nil
	return check_bei(tmonkWujiFind)
end
function tmonkWujiFind()
	if countTab(tmroom)==0 then
	   if countTab(tm)==0 then
	      return tmonkFinish()
	   else
	      return tmonkStart()
	   end
	else
	   local l_id
       for p in pairs(tmroom) do
           l_id = p
       end
       return go(tmonkWuji,l_id)
	end
end
function tmonkChange()
    tmchg=true
end
function tmonkChgMonk()
    EnableTriggerGroup("tmonkTeach",false)
	if countTab(tm)>1 then
	   local l_id
	   for p in pairs(tm) do
	       if p ~= road.id then
		      l_id = p
		   end
	   end
	   if l_id then
	      return go(tmonkTeach,l_id)
	   else
	      return tmonkWujiFind()
	   end
	else
	   if countTab(tmroom)==0 then
	      return check_busy(tmonkTeach,1)
	   else
	      return tmonkWujiFind()
	   end
	end
end
function tmonkTeachStart()
    EnableTriggerGroup("tmonkWujiReply",false)
	tm[road.id] = true
	tmroom[road.id] = nil
	return check_bei(tmonkTeach)
end
function tmonkTeach()
	EnableTriggerGroup("tmonkTeach",true)
	tmcon=nil
	tmchg=nil
	exe('yun jing;#2(teach monk)')
	exe('alias action teach')
end
function tmonkTeachCon()
    EnableTriggerGroup("tmonkTeach",false)
	if tmchg then
	   --return tmonkChgMonk()
	   return check_busy(tmonkTeach,1)
	end
	if tmcon then
	   return check_bei(tmonkTeach)
	else
	   return tmonkWujiNobody()
	end
end
function tmonkContinue()
    tmcon=true
end
function tmonkWujiKill()
    EnableTriggerGroup("tmonkTeach",false)
    return wipe("monk",tmonkWujiNobody)
end
function tmonkMotou(n,l,w)
    EnableTriggerGroup("tmonkTeach",false)
	dest.room=Trim(w[3])
    dest.area="嵩山少林"
	road.idold = road.id
    if not dest.room or not path_cal() then
       messageShow('Teach任务：魔头出现地点【'.. dest.area .. dest.room ..'】不可到达，放弃MONK!')
	   road.id = road.idold
       return tmonkWujiNobody()
	else
	   messageShow('Tmonk任务：邪道魔头出现在'.. dest.room ..'。','green')
	   return tmonkMotouFind()
    end
end
function tmonkMotouFind()
    EnableTriggerGroup("tmonkMotouFind",true)
	if dest.room == "石板路" then
	   return go(find,"shaolin/sblu-3","")
	end
	return go(find,dest.area,dest.room)
end
function tmonkMotouKill()
    flag.find=1
	dis_all()
	EnableTriggerGroup("tmonkFight",true)
	exe('set wimpy 100')
	exe('kill mo tou')
	job.killer["邪道魔头"]="mo tou"
end
function tmonkFaint()
    exe('unset wimpy')
    exe('kill mo tou')
end
function tmonkDie()
    EnableTriggerGroup("tmonkFight",false)
	messageShow('Tmonk任务：搞定邪道魔头。','green')
	return check_bei(tmonkGet)
end
function tmonkGet()
    for i=1,3 do
	   exe('get gold from corpse '.. i)
	   exe('get muou from corpse '.. i)
	end
	checkBags()
	return check_busy(tmonkMuou)
end
function tmonkMuou()
    if Bag["十八木偶"] then
	   messageShow('Tmonk任务：运气很好，搞到十八木偶。','green')
	   return go(tmonkMuouGive,"嵩山少林","方丈室")
	else
	   return tmonkStart()
	end
end
function tmonkMuouGive()
    exe('give muou to xuanci dashi')
	return tmonkStart()
end
function tmonkFinish()
    dis_all()
    messageShow('Tmonk任务：任务完成。','green')
    return go(check_heal,"嵩山少林","罗汉堂")
end