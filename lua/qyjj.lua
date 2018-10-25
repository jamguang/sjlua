--[[
> 你向玄慈大师打听有关『易筋经』的消息。
玄慈大师说道：「你来的也太勤快耶？」
> 你向玄慈大师打听有关『如梦如幻』的消息。
玄慈大师说道：「你想干什么？」
> 【谣言】某人：听说本斯在明教天字门找到了一本锻造术精要！
你向玄慈大师打听有关『一梦如是』的消息。
玄慈大师说道：「你想干什么？」
]]

quests = quests or {}
quests["yjj"] = {}
quests["yjj"].auto = 0
quests["yjj"].name = '易筋经绝世'

questTongji = questTongji or {}
questTongji["yjj"] = "yjjTongji"

questCal = questCal or {}
questCal["yjj"] = "yjjCal"

questList = questList or {}
questList["yjj"] = function() if score.party=="少林派" then return quests["yjj"].name else return false end end


function yjjCal()
    if GetVariable("autoyjj") and Bag["火折"] and score.party=="少林派" and score.con and score.con>39 then
      if GetVariable("timeyjj") then
		 quests["yjj"].time=tonumber(GetVariable("timeyjj"))
	  end
	  if GetVariable("autoyjj") then
		 quests["yjj"].auto=tonumber(GetVariable("autoyjj"))
	  end
	  if quests["yjj"].time==nil or os.time()-quests["yjj"].time > 24*60*60 then
	     quests["yjj"].time = os.time() - 22*60*60
		 SetVariable("timeyjj",quests["yjj"].time)
	     if quests["yjj"].auto==nil or quests["yjj"].auto == 0 then
	        quests["yjj"].auto = 1
	     end
	     if quests["yjj"].auto == 1 then
		    exe('pray pearl')
		    return "questyjj"
	     end
	  else
	     if quests["yjj"].auto == 1 and quests["yjj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["yjj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["yjj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function yjjTongji()
    if GetVariable("autoyjj") and Bag["火折"] and quests["yjj"] and quests["yjj"].auto == 1 and quests["yjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["yjj"].time)
	   checkQuestNote(quests["yjj"].name,l_time)
	end
end

function questyjj()
    if not Bag["火折"] then
	   return yjjFire()
	end
	return yjjBfGo()
end
function yjjFire()
    return go(yjjFireBuy,"襄阳城","杂货铺")
end
function yjjFireBuy()
    exe('buy fire')
	checkBags()
	return check_busy(questYjj)
end
function yjjBfGo()
    flag.idle = 0
    if Bag["深色包袱"] then
	   return yjjXinGo()
	end
    return go(yjjBfAsk,"燕子坞","听香水榭")
end
function yjjBfAsk()
    if locl.room ~= "听香水榭" or not locl.id["阿朱"] then
	   return yjjBfGo()
	end
	exe('ask a zhu about 易容术')
	wait.make(function() 
       wait.time(3)
	   exe('ask a zhu about 高深')
	   wait.time(3)
	   exe('ask a zhu about 人皮面具')
	   wait.time(3)
	   exe('ask a zhu about 心愿')
	   checkBags()
	   return check_bei(yjjBfGo)
	end)
end
function yjjXinGo()
    flag.idle = 0
    if Bag["亲笔信函"] then
	   return yjjMjGo()
	end
	return go(yjjXinAsk,"嵩山少林","证道院")
end
function yjjXinAsk()
    if locl.room ~= "证道院" or not locl.id["玄生大师"] then
	   return yjjXinGo()
	end
	exe('ask xuansheng dashi about 易筋经')
	wait.make(function() 
       wait.time(3)
	   exe('give bao fu to xuansheng dashi')
	   checkBags()
	   return check_bei(yjjXinGo)
	end)
end
function yjjMjGo()
    flag.idle = 0
    if Bag["面具"] then
	   return yjjFzGo()
	end
	return go(yjjMjAsk,"燕子坞","听香水榭")
end
function yjjMjAsk()
    if locl.room ~= "听香水榭" or not locl.id["阿朱"] then
	   return yjjMjGo()
	end
	exe('give xuanci letter to a zhu')
	checkBags()
	return check_bei(yjjMjGo)
end
function yjjFzGo()
    flag.idle = 0
    return go(yjjFzAsk,"嵩山少林","方丈室")
end
function yjjFzAsk()
    if locl.room ~= "方丈室" or not locl.id["玄慈大师"] then
	   return yjjFzGo()
	end
	DeleteTriggerGroup("yjjask")
	create_trigger_t('yjjask1',"^(> )*玄慈大师说道：「你来的也太勤快耶？」",'','yjjBusy')
	create_trigger_t('yjjask2','^(> )*玄慈大师说道：「你想干什么？」','','yjjBusy')
	create_trigger_t('yjjask3','^(> )*玄慈大师说道：「易筋经乃是我少林第一武技','','yjjFzask2')
	SetTriggerOption("yjjask1","group","yjjask")
    SetTriggerOption("yjjask2","group","yjjask")
	SetTriggerOption("yjjask3","group","yjjask")
	exe('ask xuanci about 易筋经')
end
function yjjFzask2()
    EnableTriggerGroup("yjjask",false)
	wait.make(function() 
       wait.time(3)
	   exe('ask xuanci about 如梦如幻')
	   wait.time(3)
	   exe('ask xuanci about 一梦如是')
	   return check_bei(yjjStart)
	end)
end
function yjjStart()
    flag.idle = 0
    return go(yjjWipe,"嵩山少林","藏经阁二楼")
end
function yjjWipe()
    return wipe("huizhen zunzhe",yjjLook)
end
function yjjLook()
    exe('look 铜镜;dian 蜡烛')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*你怔立片刻，无意中回头又向铜镜瞧了一眼，见到了自己的背影','','yjjJump')
	SetTriggerOption("yjj1","group","yjj")
end
function yjjJump()
    exe('jump up;kan down')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*你心想自己乃是蒙面而来','','yjjJumpDown')
	SetTriggerOption("yjj1","group","yjj")
end
function yjjJumpDown()
    EnableTriggerGroup("yjj",false)
	return checkWait(yjjKill,3)
end 
function yjjKill()
    
	return wipe("dashi",yjjMo)
end
function yjjMo()
    flag.idle = 0
    exe('mo book')
	DeleteTriggerGroup("yjj")
    create_trigger_t('yjj1','^(> )*你虽然得知易筋经的所在，但因机缘不到，不能得到易筋经真传。','','yjjFail')
	create_trigger_t('yjj2','^(> )*恭喜你，因机缘巧合，历尽千辛万苦，你终于获得了少林第一神功','','yjjSucc')
	SetTriggerOption("yjj1","group","yjj")
	SetTriggerOption("yjj2","group","yjj")
	questStartLog(quests["yjj"].name)
end
function yjjFail()
    EnableTriggerGroup("yjj",false)
	quests["yjj"].time = os.time()
	return yjjOver()
end
function yjjBusy()
    EnableTriggerGroup("yjj",false)
	EnableTriggerGroup("yjjask",false)
	quests["yjj"].time = os.time() - 20*60*60
	return yjjOver()
end
function yjjSucc()
    EnableTriggerGroup("yjj",false)
	quests["yjj"].time = os.time()
	quests["yjj"].auto = 2
	questSucLog(quests["yjj"].name)
	return yjjOver()
end
function yjjOver()
    SetVariable("timeyjj",quests["yjj"].time)
	SetVariable("autoyjj",quests["yjj"].auto)
	exe('drop mian ju')
	DeleteTriggerGroup("yjjask")
	DeleteTriggerGroup("yjj")
	CloseLog()
	return check_bei(checkQuestOver)
end