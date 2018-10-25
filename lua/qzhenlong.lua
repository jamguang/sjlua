quests = quests or {}
quests["zhenlong"] = {}
quests["zhenlong"].auto = 0
quests["zhenlong"].name = '逍遥珍珑棋局'

questTongji = questTongji or {}
questTongji["zhenlong"] = "zhenlongTongji"

questCal = questCal or {}
questCal["zhenlong"] = "zhenlongCal"

questList = questList or {}
questList["zhenlong"] = function() if hp.exp and hp.exp > 20000000 and score.gender and score.gender == "男" and score.int and score.int > 40 and skills["force"] and skills["force"].lvl>550 then return quests["zhenlong"].name else return false end end


function zhenlongCal()
    if GetVariable("autozhenlong") and skills["force"] and skills["force"].lvl>550 then
      if GetVariable("timezhenlong") then
		 quests["zhenlong"].time=tonumber(GetVariable("timezhenlong"))
	  end
	  if GetVariable("autozhenlong") then
		 quests["zhenlong"].auto=tonumber(GetVariable("autozhenlong"))
	  end
	  if quests["zhenlong"].time==nil or os.time()-quests["zhenlong"].time > 24*60*60 then
	     quests["zhenlong"].time = os.time() - 22*60*60
		 SetVariable("timezhenlong",quests["zhenlong"].time)
	     if quests["zhenlong"].auto==nil or quests["zhenlong"].auto == 0 then
	        quests["zhenlong"].auto = 1
	     end
	     if quests["zhenlong"].auto == 1 then
		    exe('pray pearl')
		    return "questzhenlong"
	     end
	  else
	     if quests["zhenlong"].auto == 1 and quests["zhenlong"].time then
	        local l_time = 24*60*60 - (os.time() - quests["zhenlong"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["zhenlong"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function zhenlongTongji()
    if GetVariable("autozhenlong") and quests["zhenlong"] and quests["zhenlong"].auto == 1 and quests["zhenlong"].time then
	   local l_time = 24*60*60 - (os.time() - quests["zhenlong"].time)
	   checkQuestNote(quests["zhenlong"].name,l_time)
	end
end
function questzhenlong()
   return go(zhenlongPre,"逍遥派","崖壁前")
end
function zhenlongPre()
    if not locl.id["苏星河"] then
	   quests["zhenlong"].time = os.time() - 20*60*60
	   return check_bei(zhenlongOver)
	end
    DeleteTriggerGroup("zhenlongAsk")
  
    create_trigger_t('zhenlongAsk1',"^(> )*你向苏星河打听有关『无涯子』的消息。$",'','zhenlongAsk')
    create_trigger_t('zhenlongAsk2',"^(> )*这里没有这个人。$",'','zhenlongNobody')
    SetTriggerOption("zhenlongAsk1","group","zhenlongAsk")
    SetTriggerOption("zhenlongAsk2","group","zhenlongAsk")
	questStartLog(quests["zhenlong"].name)
	exe('askk su xinghe about 无涯子')
	return exe('askk su xinghe about 珍珑棋局')
end
function zhenlongAsk()
    EnableTriggerGroup("zhenlongAsk",false)
	DeleteTriggerGroup("zhenlong")
	create_trigger_t('zhenlong1',"^(> )*苏星河说道：「这个‘珍珑’，牵涉异常重大，你过来好好的瞧上一瞧，倘能破解得开，那是一件大大的妙事。」$",'','zhenlongA')
	create_triggerex_lvl('zhenlong2','^(> )*一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……','','zhenlongContinue',90)
	create_trigger_t('zhenlong3',"^(> )*你心头一震，一时之间百感交集，反来覆去只是想着两句话：",'','zhenlongContinue')
    create_trigger_t('zhenlong4',"^(> )*苏星河说道：「你还是去休息一下吧，解珍珑棋局不急！」",'','zhenlongFail')
    create_trigger_t('zhenlong5',"^(> )*苏星河说道：「你容貌欠佳，怕是不行，这中间大有干系，大有干系。。。」",'','zhenlongDel')
	SetTriggerOption("zhenlong1","group","zhenlong")
    SetTriggerOption("zhenlong2","group","zhenlong")
	SetTriggerOption("zhenlong3","group","zhenlong")
	SetTriggerOption("zhenlong4","group","zhenlong")
	SetTriggerOption("zhenlong5","group","zhenlong")
end
function zhenlongA()
    return check_busy(zhenlongA1)
end
function zhenlongA1()
    return exe('look zhenlong')
end
function zhenlongSucc()
    EnableTriggerGroup("zhenlong",false)
	questSucLog(quests["zhenlong"].name)
	quests["zhenlong"].time = os.time()
	quests["zhenlong"].auto = 2
	return check_bei(zhenlongOver)
end
function zhenlongDel()
    EnableTriggerGroup("zhenlong",false)
	quests["zhenlong"].time = os.time()
	quests["zhenlong"].auto = 0
	DeleteVariable("timezhenlong")
	DeleteVariable("autozhenlong")
	CloseLog()
	return check_bei(checkQuestOver)
end
function zhenlongContinue()
    EnableTriggerGroup("zhenlong",false)
	quests["zhenlong"].time = os.time()
	wait.make(function() 
        wait.time(3)
	    return zhenlongOver()
	end)
	--return checkWait(zhenlongOver,3)
end
function zhenlongFail()
    EnableTriggerGroup("zhenlong",false)
	quests["zhenlong"].time = os.time() - 20*60*60
	return check_bei(zhenlongOver)
end
function zhenlongNobody()
    EnableTriggerGroup("zhenlongAsk",false)
	quests["zhenlong"].time = os.time() - 23.5*60*60
	return check_bei(zhenlongOver)
end
function zhenlongOver()
	SetVariable("timezhenlong",quests["zhenlong"].time)
	SetVariable("autozhenlong",quests["zhenlong"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end