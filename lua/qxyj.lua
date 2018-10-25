quests = quests or {}
quests["xyj"] = {}
quests["xyj"].auto = 0
quests["xyj"].name = '九阴真经上卷'

questTongji = questTongji or {}
questTongji["xyj"] = "xyjTongji"

questCal = questCal or {}
questCal["xyj"] = "xyjCal"

questList = questList or {}
questList["xyj"] = function() if canwu and canwu.gift and canwu.gift>19 then return quests["xyj"].name else return false end end


function xyjCal()
    if GetVariable("autoxyj") and canwu and canwu.gift and canwu.gift>19 then
      if GetVariable("timexyj") then
		 quests["xyj"].time=tonumber(GetVariable("timexyj"))
	  end
	  if GetVariable("autoxyj") then
		 quests["xyj"].auto=tonumber(GetVariable("autoxyj"))
	  end
	  if quests["xyj"].time==nil or os.time()-quests["xyj"].time > 24*60*60 then
	     quests["xyj"].time = os.time() - 22*60*60
		 SetVariable("timexyj",quests["xyj"].time)
	     if quests["xyj"].auto==nil or quests["xyj"].auto == 0 then
	        quests["xyj"].auto = 1
	     end
	     if quests["xyj"].auto == 1 then
		    exe('pray pearl')
		    return "questxyj"
	     end
	  else
	     if quests["xyj"].auto == 1 and quests["xyj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["xyj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["xyj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function xyjTongji()
    if GetVariable("autoxyj") and quests["xyj"] and quests["xyj"].auto == 1 and quests["xyj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["xyj"].time)
	   checkQuestNote(quests["xyj"].name,l_time)
	end
end

function questxyj()
    return go(xyjHask,"桃花岛","积翠亭")
end
function xyjHask()
    if locl.room~="积翠亭" then
	   return questXyj()
	end
	if not locl.id["黄药师"] then
       return xyjBusy()	   
	end
	exe("ask huang yaoshi about 周伯通")
	return go(xyjRask,"thd/neishi1","内室")
end
function xyjRask()
    if locl.room~="内室" then
	   return go(xyjRask,"thd/neishi1","内室")
	end
    if not locl.id["黄蓉"] then
       return xyjBusy()	   
	end
	exe("ask huang rong about 周伯通")
	checkBags()
	return check_busy(xyjFanhe,1)
end
function xyjFanhe()
    if not Bag["饭盒"] then
	   return xyjBusy()	
	end
	return go(xyjGive,"桃花岛","岩洞")
end
function xyjGive()
    if locl.room~="岩洞" then
	   return go(xyjGive,"桃花岛","岩洞")
	end
	if not locl.id["周伯通"] then
       return go(xyjGive,"桃花岛","岩洞")  
	end
	DeleteTriggerGroup("xyj")
    create_trigger_t('xyj1','^(> )*周伯通说道：「(我正忙着呢。|我正忙着呢，你还是先回去好好学学武艺吧。)','','xyjFail')
	create_trigger_t('xyj2','^(> )*看起来周伯通在(\\D*)之内不准备理你。','','xyjTime')
	create_trigger_t('xyj3','^(> )*周伯通说道：「(你不是有了么？|我现在没有空，「九阴真经上卷」你等会再来要吧。)','','xyjSucc')
	create_trigger_t('xyj4','^(> )*('..score.name..'|你)重新抄录了一份九阴真经的上卷。$','','xyjSucc')
	create_trigger_t('xyj5','^(> )*周伯通说道：「你没看见我正忙着么？','','xyjWait')
	create_trigger_t('xyj6','^(> )*周伯通拉着('..score.name..'|你)说道：“乖乖的听我说故事吧。”','','xyjStory')
	SetTriggerOption("xyj1","group","xyj")
	SetTriggerOption("xyj2","group","xyj")
	SetTriggerOption("xyj3","group","xyj")
	SetTriggerOption("xyj4","group","xyj")--看起来周伯通在一分二十四秒之内不准备理你。
	SetTriggerOption("xyj5","group","xyj")
	SetTriggerOption("xyj6","group","xyj")
	exe("give fan he to zhou botong")
	exe("ask zhou botong about 九阴真经")
end
function xyjStory()
    EnableTriggerGroup("xyj",false)
	DeleteTriggerGroup("story")
    create_trigger_t('story1','^(> )*('..score.name..'|你)听着，也学到了些全真教练气的皮毛。','','xyjQuestion')
	create_trigger_t('story2','^(> )*周伯通奇怪的问道：“什么后来怎样？”','','xyjBusy')
	SetTriggerOption("story1","group","story")
	SetTriggerOption("story2","group","story")
	wait.make(function()
	   wait.time(3)
	   exe("ask zhou botong about 故事")
	   wait.time(3)
	   exe("ask zhou botong about 后来怎样")
	end)
end
function xyjQuestion()
    EnableTriggerGroup("story",false)
	DeleteTriggerGroup("xyj")
    create_trigger_t('xyj1','^(> )*周伯通说道：「(\\D*)」$','','xyjAnswer')
	create_trigger_t('xyj2','^(> )*周伯通奇怪的问道：“什么后来怎样？”','','xyjBusy')
	SetTriggerOption("xyj1","group","xyj")
	SetTriggerOption("xyj2","group","xyj")
	exe("answer no")
	tmp.answer = true
	create_timer_s('gongfu',90,'xyjGongfu')
	return xyjCheck()
end
function xyjAnswer(n,l,w)
    local answer = {
	     ["我全真教的内功心法是什么？"] = "xiantian-gong",
		 ["黄老邪的那厉害指法是什么？"] = "tanzhi-shentong",
		 ["段家有门以指为剑的剑法，叫什么名字？"] = "liumai-shenjian",
		 ["铁掌帮的著名轻功是？"] = "shuishangpiao",
		 ["神龙洪老头的暗器是叫做什么？"] = "hansha-sheying",
		 ["老毒物的奇怪内功是什么？"] = "hamagong",
		 ["老叫化和郭兄弟都会的掌法是什么？"] = "xianglong-zhang",
		 ["少林和尚们的内功是什么？"] = "yijin-jing",
		 ["峨嵋的剑法是什么？"] = "huifeng-jian",
		 ["武当张老头创出的软绵绵拳法叫什么名字？"] = "taiji-quan",
		 ["明教张无忌那小子的内功是什么？"] = "jiuyang-shengong",
		 ["星宿派恶名昭彰的功夫是什么？"] = "huagong-dafa",
		 ["慕容家的家传特殊招架技能是？"] = "douzhuan-xingyi",
		 ["明教前教主阳顶天练什么功夫练到走火而死的？"] = "qiankun-danuoyi",
		 ["黄老邪的箫乐是由他的内功而来。这个内功的名字是？"] = "bihai-chaosheng",
		 ["金蛇郎君夏雪宜的剑法叫什么名称？"] = "jinshe-jianfa",
		 ["有种剑法，练了使人绝子绝孙。这个剑法的名字是什么？"] = "pixie-jian",
		 ["华山气宗的镇山之宝是什么？"] = "zixia-gong",
		 ["我老顽童的自创拳招是什么啊？"] = "kongming-quan",
		 ["华山剑宗的高级剑法是？"] = "dugu-jiujian",
		 ["古墓派的内功心法是什么？"] = "yunu-xinjing",
		 ["我求杨过这小子教我的掌法叫做什么名称？"] = "anran-zhang",
		 ["一灯大师的拿手绝学是什么？"] = "yiyang-zhi",
		 ["老叫化教黄蓉那小丫头的是什么拳法？"] = "xiaoyaoyou",
		 ["古墓一派的特殊拳法，叫什么名称？"] = "mainu-quan",
		 ["黄老邪除了教杨过弹指神通，还教了什么武功？"] = "yuxiao-jian",
		 ["瑛姑的高明身法是什么？"] = "niqiugong",
		 ["黄蓉的家传手法叫什么名字？"] = "lanhua-shou",
		 ["桃花的狂风绝技要以什么和旋风扫叶腿配合施展？"] = "luoying-zhang",
		 ["峨嵋的灭绝师太曾经以那种功夫将张无忌打的倒地不起？"] = "jieshou-jiushi",
	}
	
	if answer[w[2]] then
	   exe('answer '.. answer[w[2]])
	end
	
	if w[2]=="这样吧，我教你点好玩的功夫！" then
	   tmp.answer = nil
	   return xyjGongfu()
	end
	
	if w[2]=="你这个人又笨又无聊，出去！出去！" then
	   tmp.answer = nil
	   return xyjFail()
	end
end
function xyjGongfu()
    EnableTriggerGroup("xyj",false)
	DeleteTriggerGroup("story")
    create_trigger_t('story1','^(> )*周伯通在('..score.name..'|你)练习纯熟後，突然哈哈大笑起来。','','xyjSucc')
	create_trigger_t('story2','^(> )*('..score.name..'|你)无论怎么练习就是无法成功。','','xyjFail')
	SetTriggerOption("story1","group","story")
	SetTriggerOption("story2","group","story")
	tmp.answer = nil
	EnableTimer("Gongfu",false)
	DeleteTimer("Gongfu")
	questStartLog(quests["xyj"].name)
	exe("ask zhou botong about 功夫")
end
function xyjCheck()
    locate()
	return xyjCheckZhou()
end
function xyjCheckZhou()
    if not tmp.answer then return end
    if not locl.id["周伯通"] then
	   exe("out;enter")
	end
	return checkWait(xyjCheck,3)
end
function xyjWait()
    EnableTriggerGroup("xyj",false)
	return checkWait(xyjGive,3)
end
function xyjTime(n,l,w)
    EnableTriggerGroup("xyj",false)
	local l_str = Trim(w[2])
	local l_n = string.find(l_str,'小时')
	local l_m = string.find(l_str,'分')
	
	local l_hour = 0
	local l_min  = 0
	
	if l_n then
	    l_hour = trans(string.sub(l_str,1,l_n-1))
		if l_m then 
		    l_min = trans(string.sub(l_str,l_n+4,l_m-1))
		end
	else
	    if l_m then
		    l_min = trans(string.sub(l_str,1,l_m-1))
		end
	end
	
	l_min = l_min + 1
	quests["xyj"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(xyjOver)
end
function xyjBusy()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time() - 20*60*60
	return xyjOver()
end
function xyjFail()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time()
	return xyjOver()
end
function xyjSucc()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time()
	quests["xyj"].auto = 2
	questSucLog(quests["xyj"].name)
	return xyjOver()
end
function xyjOver()
    DeleteTriggerGroup("story")
	DeleteTriggerGroup("xyj")
	tmp.answer = nil
    SetVariable("timexyj",quests["xyj"].time)
	SetVariable("autoxyj",quests["xyj"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end