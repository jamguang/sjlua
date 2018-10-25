quests = quests or {}
quests["sshbzq"] = {}
quests["sshbzq"].auto = 0
quests["sshbzq"].name = '寒冰真气绝世'

questTongji = questTongji or {}
questTongji["sshbzq"] = "sshbzqTongji"

questCal = questCal or {}
questCal["sshbzq"] = "sshbzqCal"

questList = questList or {}
questList["sshbzq"] = function() if score.party and score.party=="嵩山派" then return quests["sshbzq"].name else return false end end


function sshbzqCal()
    if score.party=="嵩山派" and GetVariable("autosshbzq") and score.con>39 then
      if GetVariable("timesshbzq") then
		 quests["sshbzq"].time=tonumber(GetVariable("timesshbzq"))
	  end
	  if GetVariable("autosshbzq") then
		 quests["sshbzq"].auto=tonumber(GetVariable("autosshbzq"))
	  end
	  if quests["sshbzq"].time==nil or os.time()-quests["sshbzq"].time > 24*60*60 then
	     quests["sshbzq"].time = os.time() - 12*60*60
		 SetVariable("timesshbzq",quests["sshbzq"].time)
	     if quests["sshbzq"].auto==nil or quests["sshbzq"].auto == 0 then
	        quests["sshbzq"].auto = 1
	     end
	     if quests["sshbzq"].auto < 2 then
		    exe('pray pearl')
		    return "questsshbzq"
	     end
	  else
	     if quests["sshbzq"].auto < 2 and quests["sshbzq"].time then
	        local l_time = 24*60*60 - (os.time() - quests["sshbzq"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["sshbzq"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function sshbzqTongji()
    if GetVariable("autosshbzq") and quests["sshbzq"] and quests["sshbzq"].auto < 2 and quests["sshbzq"].time then
	   local l_time = 24*60*60 - (os.time() - quests["sshbzq"].time)
	   checkQuestNote(quests["sshbzq"].name,l_time)
	end
end
function questsshbzq()
   return go(sshbzqPre,"嵩山","封禅台")
end
function sshbzqPre()
    if not locl.id["左冷禅"] then
	    quests["sshbzq"].time = os.time() - 23*60*60
	    return check_bei(sshbzqOver)
	end
	EnableTriggerGroup("sshbzq",false)
    DeleteTriggerGroup("sshbzq")
  
    create_trigger_t('sshbzqAsk1',"^(> )*你向左冷禅打听有关『寒冰真气』的消息。",'','sshbzqAsk')
    create_trigger_t('sshbzqAsk2',"^(> )*这里没有这个人。$",'','sshbzqNobody')
    SetTriggerOption("sshbzqAsk1","group","sshbzq")
    SetTriggerOption("sshbzqAsk2","group","sshbzq")
	
	return exe('askk zuo lengchan about 寒冰真气')
end

function sshbzqAsk()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*左冷禅说道：「你来的太频繁了。」",'','sshbzqFail')
	create_trigger_t('sshbzq2','^(> )*参悟万岳朝宗绝技解密失败','','sshbzqContinue')
	create_trigger_t('sshbzq3',"^(> )*左冷禅说道：「关于地址么，这个，这个，这个",'','sshbzqask2')
	create_trigger_t('sshbzq4',"^(> )*左冷禅对你说道：大概地点就在一个峡谷附近，具体地点我实在想不起来了。",'','sshbzqgodeng')
    create_trigger_t('sshbzq5',"^(> )*邓八公说道：「哪儿比较凶险，要下去最好去问问乐师兄，他对那一带比较熟悉。」",'','sshbzqfindle')
    create_trigger_t('sshbzq6',"^(> )*乐厚在你的耳边悄声说道：我提醒你下，谷底奇寒无比，你当小心为上。",'','sshbzqfindle')
    create_trigger_t('sshbzq7',"^(> )*乐厚在你的耳边悄声说道：我嵩山的松枝极其柔软，只需要找几枝松枝，撮成绳，就可以下谷了。",'','sshbzqfindle')
    create_trigger_t('sshbzq8',"^(> )*左冷禅对你说道：这个嘛，具体地点我也不是很清楚！",'','sshbzqask2')
	SetTriggerOption("sshbzq1","group","sshbzq")
    SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	SetTriggerOption("sshbzq4","group","sshbzq")
	SetTriggerOption("sshbzq5","group","sshbzq")
	SetTriggerOption("sshbzq6","group","sshbzq")
    SetTriggerOption("sshbzq7","group","sshbzq")
    SetTriggerOption("sshbzq8","group","sshbzq")
end
function sshbzqaskagain()
    return check_halt('sshbzqaskagain2')
end
function sshbzqaskagain2()
    exe('askk zuo lengchan about 寒冰真气')
end
--songshan/dtlxia
function sshbzqfindle()
    go(sshbzqaskle,"songshan/dtlxia")
end
function sshbzqaskle()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*乐厚在你的耳边悄声说道：我嵩山的松枝极其柔软，只需要找几枝松枝，撮成绳，就可以下谷了。",'','sshbzqgoshuzhi')
	create_trigger_t('sshbzq2',"^(> )*你找死呀?这么高,怎么跳的下去，去找根绳子再下去吧！！",'','sshbzqgoshuzhi')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
  
    exe('askk le hou about here')
    wait.make(function()
	    wait.time(3)
	    exe('askk le hou about 方法')
	end)
end
function sshbzqask2()
    return check_busy(sshbzqask2_1)
end
function sshbzqask2_1()
    exe('askk zuo about 这个')
end
function sshbzqgodeng()
    return go(sshbzqaskdeng,"songshan/yushu-lou")
end
function sshbzqgoshuzhi()
    return go(sshbzqgetshuzhi,"songshan/qgfeng")
end

function sshbzqgetshuzhi()
    if not Bag['松绳'] then
   	    exe("l 松树;zhe shuzhi")
        wait.make(function()
	        wait.time(2)
	        exe('zhe shuzhi')
	        return check_busy(sshbzqcuoshuzhi)
	    end)
	else
	    go(sshbzqgodown,"songshan/dtlxia")
	end  

end
function sshbzqcuoshuzhi()
    exe("cuo shuzhi;cuo shuzhi;unwield guanri jian")
	weapon_unwield()
    return go(sshbzqgodown,"songshan/dtlxia")
end
function sshbzqgodown()
    exe("tie sheng;pa down;pa down;look stone;move stone;resist hanfeng")
   
    wait.make(function()
	    wait.time(1)
	    return check_busy(sshbzqrhfask)
	end)
end

function sshbzqrhfask()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*你静静盘腿而坐，运用体内寒冰真气和外界的寒风相抗衡。",'','sshbzqrhfcheck')
	create_trigger_t('sshbzq2',"^(> )*你一时不查，哇地突出一口鲜血，此时想起师傅的叮嘱，急忙运转寒冰真气心法，开始疗毒\\(liaodu\\)治愈。",'','sshbzqliaodu')
	create_trigger_t('sshbzq3',"^(> )*你找死呀?这么高,怎么跳的下去，去找根绳子再下去吧！！",'','sshbzqgoshuzhi')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	questStartLog(quests["sshbzq"].name)
	exe("resist hanfeng")
end	

function sshbzqrhfcheck()
    flag.idle=0
    return check_busy(sshbzqrhfask)
end

function sshbzqliaodu()
    return check_busy(sshbzqliaodu2)
end

function sshbzqliaodu2()
    flag.idle=-6
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*参悟寒冰真气绝技解密失败！",'','sshbzqContinue')
	create_trigger_t('sshbzq3',"^(> )*你背那么多东西，不怕掉下来吗？",'','sshbzqback')
	create_trigger_t('sshbzq2',"^(> )*恭喜你。",'','sshbzqSucc')
	SetTriggerOption("sshbzq1","group","sshbzq")
	SetTriggerOption("sshbzq2","group","sshbzq")
	SetTriggerOption("sshbzq3","group","sshbzq")
	exe("liaodu")
end	

function sshbzqback()
    exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
end

function sshbzqaskdeng()
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	create_trigger_t('sshbzq1',"^(> )*邓八公说道：「哪儿比较凶险，要下去最好去问问乐师兄，他对那一带比较熟悉。」",'','sshbzqfindle')
	SetTriggerOption("sshbzq1","group","sshbzq")
    exe('askk deng about 紫松鞭')
end

function sshbzqSucc()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time()
	quests["sshbzq"].auto = 2
    questSucLog(quests["sshbzq"].name)
	return check_bei(sshbzqOver)
end
function sshbzqContinue()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
	quests["sshbzq"].time = os.time()+60
	quests["sshbzq"].auto = 1
	return check_halt(sshbzqOver)
end
function sshbzqFail()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time() - 23*60*60
	return check_halt(sshbzqOver)
end
function sshbzqNobody()
    EnableTriggerGroup("sshbzq",false)
	quests["sshbzq"].time = os.time() - 23*60*60
	return check_bei(sshbzqOver)
end
function sshbzqOver()
    --exe("drop silver;drop blade;drop guanri jian;pa up")
    EnableTriggerGroup("sshbzq",false)
	DeleteTriggerGroup("sshbzq")
	SetVariable("timesshbzq",quests["sshbzq"].time)
	SetVariable("autosshbzq",quests["sshbzq"].auto)
    --CloseLog()
    --return check_bei(checkQuestOver)
	checkBags()
	return check_bei(sshbzqDropCheck)
end
function sshbzqDropCheck()
    if Bag["ENCB"] and Bag["ENCB"].value >= 20 then
	    return sshbzqDrop()
	end
	CloseLog()
	exe('pa up')
	return check_bei(checkQuestOver)
end
function sshbzqDrop()
    exe('drop coin')
    if isInBags('stone') then
        local l_item,l_cnt = isInBags('stone')
	    exe('#'.. l_cnt ..'(drop stone)')
	else
	    if Bag["白银"] and Bag["白银"].cnt>0 then
	        exe('drop silver')
	    else
	        for p in pairs(Bag) do
		        if Bag[p].kind and perform.skill and Bag[p].kind~=skillEnable[perform.skill] then
			        exe('drop '.. Bag[p].fullid)
			  	    break
			    end
			    if Bag[p].kind then
			        exe('drop '.. Bag[p].fullid)
			  	    break
			    end
		    end
	    end
	end	
	checkBags()	
	return check_busy(sshbzqDropCheck,1)
end