quests = quests or {}
quests["rybrh"] = {}
quests["rybrh"].auto = 0
quests["rybrh"].name = '日月鞭融合'

questTongji = questTongji or {}
questTongji["rybrh"] = "rybrhTongji"

questCal = questCal or {}
questCal["rybrh"] = "rybrhCal"

questList = questList or {}
questList["rybrh"] = function() if score.party=="少林派" then return quests["rybrh"].name else return false end end


function rybrhCal()
    if GetVariable("autorybrh") and Bag["火折"] and hp.shen>0 and score.party=="少林派" and skills["riyue-bian"] and skills["riyue-bian"].lvl>450 and skills["yinlong-bian"] and skills["yinlong-bian"].lvl>450 then
      if GetVariable("timerybrh") then
		 quests["rybrh"].time=tonumber(GetVariable("timerybrh"))
	  end
	  if GetVariable("autorybrh") then
		 quests["rybrh"].auto=tonumber(GetVariable("autorybrh"))
	  end
	  if quests["rybrh"].time==nil or os.time()-quests["rybrh"].time > 24*60*60 then
	     quests["rybrh"].time = os.time() - 22*60*60
		 SetVariable("timerybrh",quests["rybrh"].time)
	     if quests["rybrh"].auto==nil or quests["rybrh"].auto == 0 then
	        quests["rybrh"].auto = 1
	     end
	     if quests["rybrh"].auto == 1 then
		    exe('pray pearl')
		    return "questrybrh"
	     end
	  else
	     if quests["rybrh"].auto == 1 and quests["rybrh"].time then
	        local l_time = 24*60*60 - (os.time() - quests["rybrh"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["rybrh"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function rybrhTongji()
    if GetVariable("autorybrh") and Bag["火折"] and hp.shen>0 and quests["rybrh"] and quests["rybrh"].auto == 1 and quests["rybrh"].time then
	   local l_time = 24*60*60 - (os.time() - quests["rybrh"].time)
	   checkQuestNote(quests["rybrh"].name,l_time)
	end
end

function questrybrh()
    return go(rybrhPre,"shaolin/fumoquan")
end
function rybrhPre()
    if not locl.id["渡厄"] then
	   quests["rybrh"].time = os.time() - 20*60*60
	   return check_bei(rybrhNobody)
	end
	EnableTriggerGroup("rybrhAsk",false)
    DeleteTriggerGroup("rybrhAsk")
    create_trigger_t('rybrhAsk1',"^(> )*你向渡厄打听有关『日月鞭融合』的消息",'','rybrhAsk')
    create_trigger_t('rybrhAsk2',"^(> )*这里没有这个人。$",'','rybrhNobody')
    SetTriggerOption("rybrhAsk1","group","rybrhAsk")
    SetTriggerOption("rybrhAsk2","group","rybrhAsk")
    
	return exe('askk du e about 日月鞭融合')
end
function rybrhAsk()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1',"^(> )*渡厄说道：「你还是去休息一下吧。」",'','rybrhFail')
	create_trigger_t('rybrh2','^(> )*渡厄对你说道：周掌门的鞭子乃当世一绝技，虽不如日月鞭的刚劲强横，但却极尽变化之极致。','','rybrhgoem')
	SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
end
function rybrhgoem()
    EnableTriggerGroup("rybrhAsk",false)
    return go(rybrhgozhou,"chengdu/tulu1")
end  
function rybrhgozhou()
    return go(rybrhaskzhou,"emei/shanpo")
end
function rybrhaskzhou()
    EnableTriggerGroup("rybrhAsk",false)
    DeleteTriggerGroup("rybrhAsk")
    create_trigger_t('rybrhAsk1',"^(> )*你向周芷若打听有关『九阴银龙鞭技巧』的消息",'','rybrhAsk2')
    create_trigger_t('rybrhAsk2',"^(> )*这里没有这个人。$",'','rybrhNobody')
    SetTriggerOption("rybrhAsk1","group","rybrhAsk")
    SetTriggerOption("rybrhAsk2","group","rybrhAsk")
	return exe('askk zhou zhiruo about 九阴银龙鞭技巧')
end
function rybrhAsk2()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1','^(> )*周芷若说道：「你已经将九阴银龙鞭的秘密融会贯通，来消遣我么？」','','rybrhSucc')
	create_trigger_t('rybrh2','^(> )*周芷若说道：「你若有心，我把这门心法都刻在藏经楼，可以去看看,能否得到就看你的机缘了。」','','rybrhgocjl')
    SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
	--周芷若说道：「你已经将九阴银龙鞭的秘密融会贯通，来消遣我么？」
end

function rybrhgocjl()
    return go(rybrhfanshu,"emei/cangjinglou")
end
function rybrhfanshu()
    rybrhAsk3()
	questStartLog(quests["rybrh"].name)
	return exe('fan 经书')
end
function rybrhAsk3()
    EnableTriggerGroup("rybrhAsk",false)
	DeleteTriggerGroup("rybrh")
	create_trigger_t('rybrh1',"^(> )*解密银龙鞭法技巧失败！",'','rybrhContinue')
	create_trigger_t('rybrh2','^(> )*你把银龙鞭的招式从头开始演练，一路演练下来，潇洒自如。','','rybrhSucc')
	create_trigger_t('rybrh3',"^(> )*你来的太频繁了,此乃练武大忌讳!",'','rybrhFail')
	create_trigger_t('rybrh4',"^(> )*你的银龙鞭法不足450，连飞都没有",'','rybrhDel')
	SetTriggerOption("rybrh1","group","rybrh")
    SetTriggerOption("rybrh2","group","rybrh")
    SetTriggerOption("rybrh3","group","rybrh")
	SetTriggerOption("rybrh4","group","rybrh")
	--你按照周芷若的指点，结合自己演习所得，对银龙鞭法的奥妙似乎有些心得。
    --你把银龙鞭的招式从头开始演练，一路演练下来，潇洒自如。越练越是纯熟。
    --忽然间，你灵光一闪，以前无论如何也想不明白的问题忽然间豁然贯通，忍不住哈哈大笑.
end
function rybrhDel()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = 0
	quests["rybrh"].auto = 0
	DeleteVariable("timerybrh")
	DeleteVariable("autorybrh")
	CloseLog()
	return check_bei(checkQuestOver)
end
function rybrhSucc()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time()
	quests["rybrh"].auto = 2
	questSucLog(quests["rybrh"].name)
	return check_bei(rybrhOver)
end
function rybrhContinue()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time()
	return check_bei(rybrhOver)
end
function rybrhFail()
    EnableTriggerGroup("rybrh",false)
	quests["rybrh"].time = os.time() - 16*60*60
	return check_bei(rybrhOver)
end
function rybrhNobody()
    EnableTriggerGroup("rybrhAsk",false)
	quests["rybrh"].time = os.time() - 18*60*60
	return check_bei(rybrhOver)
end
function rybrhOver()
    CloseLog()
	DeleteTriggerGroup("rybrhAsk")
	DeleteTriggerGroup("rybrh")
	SetVariable("timerybrh",quests["rybrh"].time)
	SetVariable("autorybrh",quests["rybrh"].auto)
    return check_bei(checkQuestOver)
end