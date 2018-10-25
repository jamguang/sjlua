quests = quests or {}
quests["jianqi"] = {}
quests["jianqi"].auto = 0
quests["jianqi"].name = '全真剑气'

questTongji = questTongji or {}
questTongji["jianqi"] = "jianqiTongji"

questCal = questCal or {}
questCal["jianqi"] = "jianqiCal"

questList = questList or {}
questList["jianqi"] = function() if score.party and score.party=="全真教" and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then return quests["jianqi"].name else return false end end


function jianqiCal()
    if string.find("亥|子|丑",locl.time) and GetVariable("autojianqi") and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then
      if GetVariable("timejianqi") then
		 quests["jianqi"].time=tonumber(GetVariable("timejianqi"))
	  end
	  if GetVariable("autojianqi") then
		 quests["jianqi"].auto=tonumber(GetVariable("autojianqi"))
	  end
	  if quests["jianqi"].time==nil or os.time()-quests["jianqi"].time > 24*60*60 then
	     quests["jianqi"].time = os.time() - 22*60*60
		 SetVariable("timejianqi",quests["jianqi"].time)
	     if quests["jianqi"].auto==nil or quests["jianqi"].auto == 0 then
	        quests["jianqi"].auto = 1
	     end
	     if quests["jianqi"].auto == 1 then
		    exe('pray pearl')
		    return "questjianqi"
	     end
	  else
	     if quests["jianqi"].auto == 1 and quests["jianqi"].time then
	        local l_time = 24*60*60 - (os.time() - quests["jianqi"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["jianqi"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function jianqiTongji()
    if GetVariable("autojianqi") and quests["jianqi"] and quests["jianqi"].auto == 1 and quests["jianqi"].time and skills["xiantian-gong"] and skills["xiantian-gong"].lvl>500 then
	   local l_time = 24*60*60 - (os.time() - quests["jianqi"].time)
	   checkQuestNote(quests["jianqi"].name,l_time)
	end
end
function questjianqi()
    checkBags()
	--questStartLog(quests["jianqi"].name)
    return go(jianqicheckbags,"全真","教碑")
end
function jianqicheckbags()   
    if Bag["七星剑"] then
        print("有七星剑")
	    return go(jianqiqcjask,"全真","老君殿")
    end  
    print("身上没有七星剑")
    return go(jianqiPre,"全真","清净居")
end
function jianqiPre()
    if not locl.id["孙不二"] then
	    quests["jianqi"].time = os.time() - 23.7*60*60
	    return check_bei(jianqiOver)
	end
    DeleteTriggerGroup("jianqiAsk")
    create_trigger_t('jianqiAsk1',"^(> )*你向孙不二打听有关",'','jianqiAsk')
    create_trigger_t('jianqiAsk2',"^(> )*这里没有这个人。$",'','jianqiNobody')
    SetTriggerOption("jianqiAsk1","group","jianqiAsk")
    SetTriggerOption("jianqiAsk2","group","jianqiAsk")
	exe('askk sun buer about 王重阳')				
end
function jianqiAsk()
    EnableTriggerGroup("jianqiAsk",true)
	DeleteTriggerGroup("jianqi")                             
	create_trigger_t('jianqi1',"^(> )*孙不二说道：「我方才不是给你了么？」",'','jianqikiller')
	create_trigger_t('jianqi2',"^(> )*孙不二说道：「七星宝剑不在我手里，我已经送人了！」",'','jianqikiller')
    create_trigger_t('jianqi3','^(> )*孙不二对你说道：七星宝剑是我全真教至高无上宝物！','','jianqiqxbj')
    create_trigger_t('jianqi4',"^(> )*孙不二抽出一把寒光四射的宝剑递给你!",'','jianqigoqcj')
	SetTriggerOption("jianqi1","group","jianqi")
	SetTriggerOption("jianqi2","group","jianqi")
	SetTriggerOption("jianqi3","group","jianqi")
	SetTriggerOption("jianqi4","group","jianqi")
end
function jianqiqxbj()
    exe('askk sun buer about 七星宝剑')
end
function jianqigoqcj()
    return go(jianqiqcjask,'全真','老君殿')   
end
function jianqiqcjask()
    if not locl.id["丘处机"] then
	    quests["jianqi"].time = os.time() - 23.8*60*60
	    return check_bei(jianqiOver)
	end 
    EnableTriggerGroup("jianqiqcjask",true)
    create_trigger_t('jianqiqiuAsk1',"^(> )*这里没有这个人。$",'','jianqiNobody')
    create_trigger_t('jianqiqiuAsk2',"^(> )*如不是亲身体会估计很难领悟，近来你的武功已有所小成，如果你有信心，可以来向我请教一下",'','jianqiqingjiao')
    create_trigger_t('jianqiqiuAsk3',"^(> )*丘处机对你说道：姑娘，我刚才不是已经回答你了吗？",'','jianqiqingjiao')
    create_trigger_t('jianqiqiuAsk4',"^(> )*丘处机对你说道：嗯？你不是刚来请教过我剑诀吗？还是再努力段时间吧！",'','jianqiFail')
    create_trigger_t('jianqiqiuAsk5',"^(> )*你听了丘处机的指点，可是对全真剑法绝技的奥妙全然不得要领。",'','jianqifinish')
	create_trigger_t('jianqiqiuAsk6',"^(> )*（原来|恭喜|原来如此|终于|你已经）",'','jianqiSucc')
    create_trigger_t('jianqiqiuAsk7',"^(> )*丘处机对你说道：你来的太频繁了！",'','jianqiFail')
	create_trigger_t('jianqiqiuAsk8',"^(> )*丘处机对你说道：我现在无法看见天空中北斗七星，又如何指导你学习全真剑法的剑诀精髓。",'','jianqiWait')
	SetTriggerOption("jianqiqiuAsk1","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk2","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk3","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk4","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk5","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk6","group","jianqiqiuAsk")
	SetTriggerOption("jianqiqiuAsk7","group","jianqiqiuAsk")
    SetTriggerOption("jianqiqiuAsk8","group","jianqiqiuAsk")
	questStartLog(quests["jianqi"].name)
	return exe('askk qiu chuji about 全真剑气')
end
function jianqiqxbj1()
	return check_busy(jianqiqxbj1)
end
function jianqiqingjiao()
	wait.make(function()
	    wait.time(5)
        exe('qingjiao')
   end)		
end
function jianqikiller()
	--exe('kill sun buer;pfmpfm')
	quests["jianqi"].time = os.time() - 23.6*60*60
	return wipe("sun buer",jianqiOver)
end
function jianqiWait()
    flag.idle = 0
    wait.make(function()
	    wait.time(10)
        exe('askk qiu chuji about 全真剑气')
   end)	
end
function jianqiSucc()
    EnableTriggerGroup("jianqi",false)
	questSucLog(quests["jianqi"].name)
	quests["jianqi"].time = os.time()
	quests["jianqi"].auto = 2
	return check_bei(jianqiOver)
end
function jianqiFail()
    EnableTriggerGroup("jianqi",false)
	quests["jianqi"].time = os.time() - 23.8*60*60
	return check_bei(jianqiOver)
end
function jianqifinish()
    EnableTriggerGroup("jianqi",false)
    EnableTriggerGroup("jianqiAsk",false)
    EnableTriggerGroup("jianqiAskqiu",false)
    EnableTriggerGroup("jianqiqcjask",false)
	quests["jianqi"].time = os.time()
	SetVariable("timejianqi",quests["jianqi"].time)
	print("解密全真剑气结束") 	
    return check_bei(jianqiQuit)
end
function jianqiNobody()
    EnableTriggerGroup("jianqiAsk",false)
	quests["jianqi"].time = os.time() - 23.7*60*60
	return check_bei(jianqiOver)
end
function jianqiOver()
	SetVariable("timejianqi",quests["jianqi"].time)
	EnableTriggerGroup("jianqiAsk",false)
    EnableTriggerGroup("jianqiAskqiu",false)
    EnableTriggerGroup("jianqiqcjask",false)
	print("解密全真剑气结束")
	CloseLog()
    return check_bei(checkQuestOver)
end
function jianqiQuit()
    return husongQuit()				
end

function jianqiDel()
    EnableTriggerGroup("jianqi",false)
	quests["jianqi"].time = os.time()
	quests["jianqi"].auto = 0
	DeleteVariable("timejianqi")
	DeleteVariable("autojianqi")
	CloseLog()
	return check_bei(checkQuestOver)
end

