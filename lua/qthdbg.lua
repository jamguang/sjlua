quests = quests or {}
quests["thdbg"] = {}
quests["thdbg"].auto = 0
quests["thdbg"].name = '桃花岛闭关'

questTongji = questTongji or {}
questTongji["thdbg"] = "thdbgTongji"

questCal = questCal or {}
questCal["thdbg"] = "thdbgCal"

questList = questList or {}
questList["thdbg"] = function() if score.party and score.party=="桃花岛" and score.int and score.int>49 and score.con and score.con>49 and score.dex and score.dex>49 and skills["flute"] and skills["flute"].lvl>=200 and skills["force"] and skills["force"].lvl>=500 then return quests["thdbg"].name else return false end end


function thdbgCal()
    if GetVariable("autothdbg") and score.int and score.int>49 and score.con and score.con>49 and score.dex and score.dex>49 and skills["flute"] and skills["flute"].lvl>=200 and skills["force"] and skills["force"].lvl>=500 then
      if GetVariable("timethdbg") then
		 quests["thdbg"].time=tonumber(GetVariable("timethdbg"))
	  end
	  if GetVariable("autothdbg") then
		 quests["thdbg"].auto=tonumber(GetVariable("autothdbg"))
	  end
	  if quests["thdbg"].time==nil or os.time()-quests["thdbg"].time > 24*60*60 then
	     quests["thdbg"].time = os.time() - 22*60*60
		 SetVariable("timethdbg",quests["thdbg"].time)
	     if quests["thdbg"].auto==nil or quests["thdbg"].auto == 0 then
	        quests["thdbg"].auto = 1
	     end
	     if quests["thdbg"].auto == 1 then
		    exe('pray pearl')
		    return "questthdbg"
	     end
	  else
	     if quests["thdbg"].auto == 1 and quests["thdbg"].time then
	        local l_time = 24*60*60 - (os.time() - quests["thdbg"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["thdbg"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function thdbgTongji()
    if GetVariable("autothdbg") and quests["thdbg"] and quests["thdbg"].auto == 1 and quests["thdbg"].time then
	   local l_time = 24*60*60 - (os.time() - quests["thdbg"].time)
	   checkQuestNote(quests["thdbg"].name,l_time)
	end
end

function questthdbg()
   return go(thdbgPre,"桃花岛","积翠亭")
end

function thdbgPre()
    if not locl.id["黄药师"] then
	   quests["thdbg"].time = os.time() - 20*60*60
	   return check_bei(thdbgOver)
	end
    DeleteTriggerGroup("thdbgAsk")
    create_trigger_t('thdbgAsk1',"^(> )*你向黄药师打听有关『闭关』的消息。",'','thdbgAsk')
    create_trigger_t('thdbgAsk2',"^(> )*这里没有这个人。$",'','thdbgNobody')
    SetTriggerOption("thdbgAsk1","group","thdbgAsk")
    SetTriggerOption("thdbgAsk2","group","thdbgAsk")
	questStartLog(quests["thdbg"].name)
	return exe('askk huang yaoshi about 闭关')
end

function thdbgAsk()
    EnableTriggerGroup("thdbgAsk",false)
	DeleteTriggerGroup("thdbg")
	create_trigger_t('thdbg1',"^(> )*你来的也太勤快了点？",'','thdbgFail')
	create_trigger_t('thdbg2','^(> )*桃花岛闭关失败!','','thdbgContinue')
	create_trigger_t('thdbg3',"^(> )*恭喜解密|闭关成功",'','thdbgSucc')
	create_trigger_t('thdbg4',"^(> )*黄药师(对你|)说道：(|「)你的碧海潮生太低了,不足500级！」",'','thdbgDel')
	create_trigger_t('thdbg5',"^(> )*黄药师(对你|)说道：(|「)好吧，既然你如此优秀，我就把我当初领悟的地点告诉你",'','thdbgGo')
	SetTriggerOption("thdbg1","group","thdbg")
    SetTriggerOption("thdbg2","group","thdbg")
	SetTriggerOption("thdbg3","group","thdbg")
	SetTriggerOption("thdbg4","group","thdbg")
	SetTriggerOption("thdbg5","group","thdbg")
end
function thdbgGo()
    EnableTriggerGroup("thdbg",false)
	return go(thdbgYue,"桃花岛","断崖")
end
function thdbgYue()
    if locl.room~="断崖" then
	    return go(thdbgYue,"桃花岛","断崖")
	end
	if Bag["ENCB"] and Bag["ENCB"].value >= 30 then
	    exe(gmDropStoneCmd())
	end
	exe("yue ya")
	locate()
	return checkWait(thdbgSit,2)
end
function thdbgSit()
    if locl.room=="断崖" then
	    exe("yue ya")
	    locate()
	    return checkWait(thdbgSit,2)
	end
	if locl.room~="试剑峰顶" then
	    return go(thdbgYue,"桃花岛","断崖")
	end
    return check_busy(thdbgSit1)
end
function thdbgSit1()
    exe('sit')
	return check_busy(thdbgAct)
end
function thdbgAct()
    DeleteTriggerGroup("thdbg")
	create_trigger_t('thdbg1',"^(> )*你来的也太勤快了点？",'','thdbgFail')
	create_trigger_t('thdbg2','^(> )*你长叹一生，自言自语地','','thdbgContinue')
	create_trigger_t('thdbg3',"^(> )*你经过不断领悟，终于彻底",'','thdbgSucc')
	SetTriggerOption("thdbg1","group","thdbg")
    SetTriggerOption("thdbg2","group","thdbg")
	SetTriggerOption("thdbg3","group","thdbg")
    exe('biguan')
end
function thdbgSucc()
    EnableTriggerGroup("thdbg",false)
	questSucLog(quests["thdbg"].name)
	quests["thdbg"].time = os.time()
	quests["thdbg"].auto = 2
	return check_bei(thdbgOver)
end
function thdbgContinue()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time()
	return check_bei(thdbgOver)
end
function thdbgFail()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time() - 16*60*60
	return check_bei(thdbgOver)
end
function thdbgNobody()
    EnableTriggerGroup("thdbgAsk",false)
	quests["thdbg"].time = os.time() - 18*60*60
	return check_bei(thdbgOver)
end
function thdbgOver()
    CloseLog()
	SetVariable("timethdbg",quests["thdbg"].time)
	SetVariable("autothdbg",quests["thdbg"].auto)
	exe('yue ya;wd;wd;sd;d;wd;n')
    return check_bei(checkQuestOver)
end	
function thdbgDel()
    EnableTriggerGroup("thdbg",false)
	quests["thdbg"].time = os.time()
	quests["thdbg"].auto = 0
	DeleteVariable("timethdbg")
	DeleteVariable("autothdbg")
	CloseLog()
	return check_bei(checkQuestOver)
end