quests = quests or {}
quests["tjj"] = {}
quests["tjj"].auto = 0
quests["tjj"].name = '太极剑绝技'

questTongji = questTongji or {}
questTongji["tjj"] = "tjjTongji"

questCal = questCal or {}
questCal["tjj"] = "tjjCal"

questList = questList or {}
questList["tjj"] = function() if score.party=="武当派" and score.int > 39 then return quests["tjj"].name else return false end end


function tjjCal()
    if GetVariable("autotjj") and score.party=="武当派" and score.int > 39 then
      if GetVariable("timetjj") then
		 quests["tjj"].time=tonumber(GetVariable("timetjj"))
	  end
	  if GetVariable("autotjj") then
		 quests["tjj"].auto=tonumber(GetVariable("autotjj"))
	  end
	  if quests["tjj"].time==nil or os.time()-quests["tjj"].time > 24*60*60 then
	     quests["tjj"].time = os.time() - 22*60*60
		 SetVariable("timetjj",quests["tjj"].time)
	     if quests["tjj"].auto==nil or quests["tjj"].auto == 0 then
	        quests["tjj"].auto = 1
	     end
	     if quests["tjj"].auto == 1 then
		    exe('pray pearl')
		    return "questtjj"
	     end
	  else
	     if quests["tjj"].auto == 1 and quests["tjj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["tjj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["tjj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function tjjTongji()
    if GetVariable("autotjj") and quests["tjj"] and quests["tjj"].auto == 1 and quests["tjj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tjj"].time)
	   checkQuestNote(quests["tjj"].name,l_time)
	end
end

function questtjj()
    return go(tjjAsk,"武当山","后山小院")
end
function tjjAsk()
    if locl.room~="后山小院" then
	   return questTjj()
	end
	if not locl.id["张三丰"] then
       return tjjBusy()	   
	end
	DeleteTriggerGroup("tjj")
    create_trigger_t('tjj1',"^(> )*你向张三丰打听有关『太极剑绝技』的消息",'','tjjAccept')
    create_trigger_t('tjj2',"^(> )*这里没有这个人。$",'','tjjBusy')
    SetTriggerOption("tjj1","group","tjj")
    SetTriggerOption("tjj2","group","tjj")
	questStartLog(quests["tjj"].name)
	exe("ask zhang sanfeng about 太极剑绝技")
end
function tjjAccept()
    EnableTriggerGroup("tjj",false)
	DeleteTriggerGroup("accept")
	create_trigger_t('accept1',"^(> )*(你明悟其中，突然间|张三丰对你说道：你不是已经领会了)",'','tjjSucc')
	create_trigger_t('accept2','^(> )*你抓耳挠腮，苦思冥想，发现自己还是无法理解','','tjjFail')
	create_trigger_t('accept3',"^(> )*张三丰(对你|)说道：(「|)你心浮气躁，如此频繁骚扰我",'','tjjBusy')
	SetTriggerOption("accept1","group","accept")
    SetTriggerOption("accept2","group","accept")
	SetTriggerOption("accept3","group","accept")
end
function tjjBusy()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time() - 20*60*60
	return check_bei(tjjOver)
end
function tjjFail()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time()
	return check_bei(tjjOver)
end
function tjjSucc()
    EnableTriggerGroup("tjj",false)
	EnableTriggerGroup("accept",false)
	quests["tjj"].time = os.time()
	quests["tjj"].auto = 2
	questSucLog(quests["tjj"].name)
	return check_bei(tjjOver)
end
function tjjOver()
	DeleteTriggerGroup("tjj")
	DeleteTriggerGroup("accept")
    SetVariable("timetjj",quests["tjj"].time)
	SetVariable("autotjj",quests["tjj"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end