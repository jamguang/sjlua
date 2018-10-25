quests = quests or {}
quests["tjq"] = {}
quests["tjq"].auto = 0
quests["tjq"].name = '太极拳绝技'

questTongji = questTongji or {}
questTongji["tjq"] = "tjqTongji"

questCal = questCal or {}
questCal["tjq"] = "tjqCal"

questList = questList or {}
questList["tjq"] = function() if score.party=="武当派" and score.int > 39 and score.str > 39 then return quests["tjq"].name else return false end end


function tjqCal()
    if GetVariable("autotjq") and score.party=="武当派" and score.int > 39 and score.str > 39 then
      if GetVariable("timetjq") then
		 quests["tjq"].time=tonumber(GetVariable("timetjq"))
	  end
	  if GetVariable("autotjq") then
		 quests["tjq"].auto=tonumber(GetVariable("autotjq"))
	  end
	  if quests["tjq"].time==nil or os.time()-quests["tjq"].time > 24*60*60 then
	     quests["tjq"].time = os.time() - 22*60*60
		 SetVariable("timetjq",quests["tjq"].time)
	     if quests["tjq"].auto==nil or quests["tjq"].auto == 0 then
	        quests["tjq"].auto = 1
	     end
	     if quests["tjq"].auto == 1 then
		    exe('pray pearl')
		    return "questtjq"
	     end
	  else
	     if quests["tjq"].auto == 1 and quests["tjq"].time then
	        local l_time = 24*60*60 - (os.time() - quests["tjq"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["tjq"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function tjqTongji()
    if GetVariable("autotjq") and quests["tjq"] and quests["tjq"].auto == 1 and quests["tjq"].time then
	   local l_time = 24*60*60 - (os.time() - quests["tjq"].time)
	   checkQuestNote(quests["tjq"].name,l_time)
	end
end

function questtjq()
    return go(tjqAsk,"武当山","后山小院")
end
function tjqAsk()
    if locl.room~="后山小院" then
	   return questTjq()
	end
	if not locl.id["张三丰"] then
       return tjqBusy()	   
	end
	DeleteTriggerGroup("tjq")
    create_trigger_t('tjq1',"^(> )*你向张三丰打听有关『太极拳绝技』的消息",'','tjqAccept')
    create_trigger_t('tjq2',"^(> )*这里没有这个人。$",'','tjqBusy')
    SetTriggerOption("tjq1","group","tjq")
    SetTriggerOption("tjq2","group","tjq")
	questStartLog(quests["tjq"].name)
	exe("ask zhang sanfeng about 太极拳绝技")
end
function tjqAccept()
    EnableTriggerGroup("tjq",false)
	DeleteTriggerGroup("accept")
	create_trigger_t('accept1',"^(> )*(你明悟其中，突然间|张三丰对你说道：你不是已经领会了太极奥意)",'','tjqSucc')
	create_trigger_t('accept2','^(> )*你抓耳挠腮，苦思冥想，发现自己还是无法理解太极奥意所在，脸上一筹莫展。','','tjqFail')
	create_trigger_t('accept3',"^(> )*张三丰对你说道：(「|)你心浮气躁，如何能练好太极拳？!",'','tjqBusy')
	SetTriggerOption("accept1","group","accept")
    SetTriggerOption("accept2","group","accept")
	SetTriggerOption("accept3","group","accept")
end
function tjqBusy()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time() - 20*60*60
	return check_bei(tjqOver)
end
function tjqFail()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time()
	return check_bei(tjqOver)
end
function tjqSucc()
    EnableTriggerGroup("tjq",false)
	EnableTriggerGroup("accept",false)
	quests["tjq"].time = os.time()
	quests["tjq"].auto = 2
	questSucLog(quests["tjq"].name)
	return check_bei(tjqOver)
end
function tjqOver()
	DeleteTriggerGroup("tjq")
	DeleteTriggerGroup("accept")
    SetVariable("timetjq",quests["tjq"].time)
	SetVariable("autotjq",quests["tjq"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end