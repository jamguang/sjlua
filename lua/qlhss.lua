--黄药师说道：这兰花手乃是我桃花岛家传之绝技，非至亲之人不得传授！
--黄药师说道：既然你如此有毅力，我就将此招式传授与你！能否领会贯通就看你的造化了。
--黄药师叹了口气，说道：“寒烟风再也不是以前的寒烟风了。”
--黄药师说道：「桃花岛的兰花手是和先天臂力休戚相关。」
--黄药师说道：「桃花岛的兰花手乃是家传绝技，你一时间领悟不了，也有点难为你了，这是需要一定的毅力，你还是下次再说吧。」
--黄药师对你失望极了：“你没救了。”

quests = quests or {}
quests["lhss"] = {}
quests["lhss"].auto = 0
quests["lhss"].name = "兰花三式绝技"

questTongji = questTongji or {}
questTongji["lhss"] = "lhssTongji"

questCal = questCal or {}
questCal["lhss"] = "lhssCal"

questList = questList or {}
questList["lhss"] = function() if score.party and score.party=="桃花岛" and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>500 and score.str and score.str>44 then return "兰花三式绝技" else return false end end


function lhssCal()
    if score.party=="桃花岛" and GetVariable("autolhss") and skills["lanhua-shou"] and skills["lanhua-shou"].lvl>200 and score.str and score.str>44 then
      if GetVariable("timelhss") then
		 quests["lhss"].time=tonumber(GetVariable("timelhss"))
	  end
	  if GetVariable("autolhss") then
		 quests["lhss"].auto=tonumber(GetVariable("autolhss"))
	  end
	  if quests["lhss"].time==nil or os.time()-quests["lhss"].time > 24*60*60 then
	     quests["lhss"].time = os.time() - 12*60*60
		 SetVariable("timelhss",quests["lhss"].time)
	     if quests["lhss"].auto==nil or quests["lhss"].auto == 0 then
	        quests["lhss"].auto = 1
	     end
	     if quests["lhss"].auto == 1 then
		    exe('pray pearl')
		    return "questLhss"
	     end
	  else
	     if quests["lhss"].auto == 1 and quests["lhss"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lhss"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote("兰花三式绝技",l_time)
			end
	     end
	     return false
	  end
   end
end
function lhssTongji()
    if GetVariable("autolhss") and quests["lhss"] and quests["lhss"].auto == 1 and quests["lhss"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lhss"].time)
	   checkQuestNote("兰花三式绝技",l_time)
	end
end
function questLhss()
   return go(lhssPre,"桃花岛","积翠亭")
end
function lhssPre()
    if not locl.id["黄药师"] then
	   quests["lhss"].time = os.time() - 20*60*60
	   return check_bei(lhssOver)
	end
    DeleteTriggerGroup("lhssAsk")
    create_trigger_t('lhssAsk1',"^(> )*你向黄药师打听有关『兰花三式绝技』的消息",'','lhssAsk')
    create_trigger_t('lhssAsk2',"^(> )*这里没有这个人。$",'','lhssNobody')
    SetTriggerOption("lhssAsk1","group","lhssAsk")
    SetTriggerOption("lhssAsk2","group","lhssAsk")
	questStartLog(quests["lhss"].name)
	exe('ask huang yaoshi about 兰花三式绝技')
	exe('alias action 兰花三式绝技')
end
function lhssAsk()
    EnableTriggerGroup("lhssAsk",false)
	DeleteTriggerGroup("lhss")
	create_trigger_t('lhss1',"^(> )*黄药师说道：「\\D*还是去休息一下吧。」",'','lhssFail')
	create_trigger_t('lhss2','^(> )*黄药师说道：「桃花岛的兰花手乃是家传绝技，你一时间领悟不了','','lhssContinue')
	create_trigger_t('lhss5','^(> )*黄药师对你失望极了：“你没救了。”','','lhssContinue')                                
	create_trigger_t('lhss3','^(> )*你把 "action" 设定为 "兰花三式绝技" 成功完成。','','lhssSucc')
	create_trigger_t('lhss4','^(> )*黄药师细心地向你讲解这一招，你终于学会了。','','lhssSucc')
	SetTriggerOption("lhss1","group","lhss")
    SetTriggerOption("lhss2","group","lhss")
	SetTriggerOption("lhss3","group","lhss")
	SetTriggerOption("lhss4","group","lhss")
	SetTriggerOption("lhss5","group","lhss")
end
function lhssSucc()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time()
	quests["lhss"].auto = 2
	questSucLog(quests["lhss"].name)
	return check_bei(lhssOver)
end
function lhssContinue()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time()
	return check_bei(lhssOver)
end
function lhssFail()
    EnableTriggerGroup("lhss",false)
	quests["lhss"].time = os.time() - 12*60*60
	return check_bei(lhssOver)
end
function lhssNobody()
    EnableTriggerGroup("lhssAsk",false)
	quests["lhss"].time = os.time() - 18*60*60
	return check_bei(lhssOver)
end
function lhssOver()
	SetVariable("timelhss",quests["lhss"].time)
	SetVariable("autolhss",quests["lhss"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end