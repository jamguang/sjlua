quests = quests or {}
quests["jdhj"] = {}
quests["jdhj"].auto = 0
quests["jdhj"].name = '金刀黑剑'

questTongji = questTongji or {}
questTongji["jdhj"] = "jdhjTongji"

questCal = questCal or {}
questCal["jdhj"] = "jdhjCal"

questList = questList or {}
questList["jdhj"] = function() if skills["force"] and skills["force"].lvl>250 then return quests["jdhj"].name else return false end end


function jdhjCal()
    if GetVariable("autojdhj") and skills["force"] and skills["force"].lvl>250 then
      if GetVariable("timejdhj") then
		 quests["jdhj"].time=tonumber(GetVariable("timejdhj"))
	  end
	  if GetVariable("autojdhj") then
		 quests["jdhj"].auto=tonumber(GetVariable("autojdhj"))
	  end
	  if quests["jdhj"].time==nil or os.time()-quests["jdhj"].time > 24*60*60 then
	     quests["jdhj"].time = os.time() - 22*60*60
		 SetVariable("timejdhj",quests["jdhj"].time)
	     if quests["jdhj"].auto==nil or quests["jdhj"].auto == 0 then
	        quests["jdhj"].auto = 1
	     end
	     if quests["jdhj"].auto == 1 then
		    exe('pray pearl')
		    return "questjdhj"
	     end
	  else
	     if quests["jdhj"].auto == 1 and quests["jdhj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["jdhj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["jdhj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function jdhjTongji()
    if GetVariable("autojdhj") and quests["jdhj"] and quests["jdhj"].auto == 1 and quests["jdhj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["jdhj"].time)
	   checkQuestNote(quests["jdhj"].name,l_time)
	end
end
function questjdhj()
   return go(jdhjPre,"绝情谷","大厅")
end
function jdhjPre()
    if not locl.id["公孙止"] then
	   quests["jdhj"].time = os.time() - 20*60*60
	   return check_bei(jdhjOver)
	end
    DeleteTriggerGroup("jdhjAsk")
  
    create_trigger_t('jdhjAsk1',"^(> )*你向公孙止打听有关『金刀黑剑』的消息。$",'','jdhjAsk')
    create_trigger_t('jdhjAsk2',"^(> )*这里没有这个人。$",'','jdhjNobody')
    SetTriggerOption("jdhjAsk1","group","jdhjAsk")
    SetTriggerOption("jdhjAsk2","group","jdhjAsk")
	questStartLog(quests["jdhj"].name)
	return exe('askk gongsun zhi about 金刀黑剑')
end
function jdhjAsk()
    EnableTriggerGroup("jdhjAsk",false)
	DeleteTriggerGroup("jdhj")
	create_trigger_t('jdhj1',"^(> )*公孙止说道：「今天先切磋到这里吧，明天吧。」$",'','jdhjFail')
	create_trigger_t('jdhj2','^(> )*公孙止怜惜的对你说，好可怜的孩子，你的眼圈马上就红了起来。','','jdhjContinue')
	create_trigger_t('jdhj3',"^(> )*公孙止说道：「你不学已经学了金刀黑剑阴阳双刃了吗。」|你「哈哈哈」大笑几声，说道：“原来如此，原来如此。”|你听了公孙止的指点,终于领悟了金刀黑剑的精华所在。",'','jdhjSucc')
    create_trigger_t('jdhj4',"^(> )*公孙止说道：「以你当前的经验恐怕还是难以领悟",'','jdhjContinue')
    create_trigger_t('jdhj5',"^(> )*公孙止似乎不懂你的意思。",'','jdhjDel')
	SetTriggerOption("jdhj1","group","jdhj")
    SetTriggerOption("jdhj2","group","jdhj")
	SetTriggerOption("jdhj3","group","jdhj")
	SetTriggerOption("jdhj4","group","jdhj")
	SetTriggerOption("jdhj5","group","jdhj")
end
function jdhjSucc()
    EnableTriggerGroup("jdhj",false)
	questSucLog(quests["jdhj"].name)
	quests["jdhj"].time = os.time()
	quests["jdhj"].auto = 2
	return check_bei(jdhjOver)
end
function jdhjDel()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time()
	quests["jdhj"].auto = 0
	DeleteVariable("timejdhj")
	DeleteVariable("autojdhj")
	CloseLog()
	return check_bei(checkQuestOver)
end
function jdhjContinue()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time()
	return check_bei(jdhjOver)
end
function jdhjFail()
    EnableTriggerGroup("jdhj",false)
	quests["jdhj"].time = os.time() - 20*60*60
	return check_bei(jdhjOver)
end
function jdhjNobody()
    EnableTriggerGroup("jdhjAsk",false)
	quests["jdhj"].time = os.time() - 23.5*60*60
	return check_bei(jdhjOver)
end
function jdhjOver()
	SetVariable("timejdhj",quests["jdhj"].time)
	SetVariable("autojdhj",quests["jdhj"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end