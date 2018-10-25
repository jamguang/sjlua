quests = quests or {}
quests["bgz"] = {}
quests["bgz"].auto = 0
quests["bgz"].name = "九阴真经下卷"

questTongji = questTongji or {}
questTongji["bgz"] = "bgzTongji"

questCal = questCal or {}
questCal["bgz"] = "bgzCal"

questList = questList or {}
questList["bgz"] = function() if hp.exp > 9200000 then return quests["bgz"].name else return false end end


function bgzCal()
    if GetVariable("autobgz") and hp.exp > 9200000 then
      if GetVariable("timebgz") then
		 quests["bgz"].time=tonumber(GetVariable("timebgz"))
	  end
	  if GetVariable("autobgz") then
		 quests["bgz"].auto=tonumber(GetVariable("autobgz"))
	  end
	  if quests["bgz"].time==nil or os.time()-quests["bgz"].time > 24*60*60 then
	     quests["bgz"].time = os.time() - 22*60*60
		 SetVariable("timebgz",quests["bgz"].time)
	     if quests["bgz"].auto==nil or quests["bgz"].auto == 0 then
	        quests["bgz"].auto = 1
	     end
	     if quests["bgz"].auto == 1 then
		    exe('pray pearl')
		    return "questbgz"
	     end
	  else
	     if quests["bgz"].auto == 1 and quests["bgz"].time then
	        local l_time = 24*60*60 - (os.time() - quests["bgz"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["bgz"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function bgzTongji()
    if GetVariable("autobgz") and quests["bgz"] and quests["bgz"].auto == 1 and quests["bgz"].time then
	   local l_time = 24*60*60 - (os.time() - quests["bgz"].time)
	   checkQuestNote(quests["bgz"].name,l_time)
	end
end

function questbgz()
    return go(bgzMei,"兰州城","石洞")
end
function bgzMei()
    if locl.room~="石洞" then
	   return go(bgzMei,"兰州城","石洞")
	end
	
	return bgzChen()
end
function bgzChen()
    if not locl.id["陈玄风"] then
	   quests["bgz"].time = os.time() - 23*60*60
	   return check_bei(bgzOver)
	end
	questStartLog(quests["bgz"].name)
	return wipe("chen xuanfeng",bgzChkDong)
end
function bgzChkDong()
    locate()
	return check_bei(bgzChkCorpse)
end
function bgzChkCorpse()
    quests["bgz"].time = os.time()
    if not locl.id["陈玄风的尸体"] then
	   exe('out')
	   return wipe("chen xuanfeng",bgzOver)
	else
	   return check_bei(bgzOver)
	end
end
function bgzOver()
    checkBags()
	SetVariable("timebgz",quests["bgz"].time)
	SetVariable("autobgz",quests["bgz"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end