require "qyusui"
require "qdyys"
require "qfeiwu"
require "qluoying"
require "qlingxi"
require "qcibei"
require "qfuxue"
require "qbishen"
require "qruying"
require "qqianshou"
require "qtiezhou"
require "qmrqx"
require "qchaozong"
require "qqimen"
require "qsongyang"
require "qranmu"
require "qshoudao"
require "qlhss"
require "qsszongh"
require "qbzgjj"
require "qjdhj"
require "qsshbzq"
require "qniqiu"
require "qanran"
require "qrybrh"
require "qthd"
require "qbgz"
require "qyzc"
require "qynj"
require "qnxsz"
require "qwxjz"
require "qtzzd"
require "qals"
require "qyjj"
require "qxyj"
require "qtjq"
require "qtjj"
require "qbizhen"
require "qsjz"
require "qcuixin"
require "qcanhe"
require "qdzxy"
require "qfmq"
require "qqkdny"
require "qlengquan"
require "qwhdmd"
require "qwuhu"
require "qshenzhao"
require "qtiejiao"
require "qthdbg"
require "qbaduan"
require "qzhenlong"
require "qjuding"
require "qchongyang"
require "qyusuo"
require "qjianqi"


quests = quests or {}
quests["hubo"]={}
quests["hubo"].auto = 0
quests["hubo"].name = "双手互搏"

quests["tlbb"]={}
quests["tlbb"].auto = 0
quests["tlbb"].name = "天龙八部"

quests["lcj"]={}
quests["lcj"].auto = 0
quests["lcj"].name = "连城诀"

quests["fox"]={}
quests["fox"].auto = 0
quests["fox"].name = "雪山飞狐"

quests["hero"]={}
quests["hero"].auto = 0
quests["hero"].name = "射雕英雄传"


--[[
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                        【飞狐武功】                        
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  武功纪录时间：二零一三年十二月二日二十时十六分二十三秒。  
                   武功纪录经验：8673279。                  
--]]				  

function checkQuest()
   DeleteTriggerGroup("story")
   create_trigger_t('story1',"^(> )*(\\D*)你还有(|了)学习(\\D*)的机会。",'','storySkilla')
   create_trigger_t('story2',"^(> )*(\\D*)你失去(|了)学习(\\D*)的(\\D*)次机会",'','storySkilla')
   create_trigger_t('story3',"^(> )*(\\D*)你现在拥有(|了)学习(\\D*)的机会",'','storySkilla')
   create_trigger_t('story4',"^(> )*(\\D*)(你现在拥有从狄云处领悟更高层次神照经的机会|你失去了狄云处领悟神照经的)",'','storySkillc')
   create_trigger_t('story5',"^(> )*(\\D*)(你现在拥有领悟神照经的机会|你失去从丁典领悟神照经的)",'','storySkilld')
   create_trigger_t('story6',"^(> )*(\\D*)你从丁典学到神照经，并更能灵活使用神照绝技。",'','storySkille')
   create_trigger_t('story7',"^(> )*(\\D*)你从陈玄风处获得了臭名昭著九阴真经下卷。",'','storySkillf')
   create_trigger_t('story8',"^(> )*(\\D*)已经学到了(\\D*)(，|。)",'','storySkillg')
   create_trigger_t('story9',"^(> )*(\\D*)你从狄云学习到躺尸剑法，并更能灵活各种绝技。",'','storySkillh')
   create_trigger_t('storya',"^(> )*(\\D*)你又从狄云处获得一些经验，对神照经有着更深层次的领悟。",'','storySkillb')
   create_trigger_t('storyb',"^(> )*(\\D*)你曾与(苗人凤|胡斐)进行过(\\D*)较量，并获得(\\D*)胜利。",'','storyFoxFight')
   SetTriggerOption("story1","group","story")
   SetTriggerOption("story2","group","story")
   SetTriggerOption("story3","group","story")
   SetTriggerOption("story4","group","story")
   SetTriggerOption("story5","group","story")
   SetTriggerOption("story6","group","story")
   SetTriggerOption("story7","group","story") 
   SetTriggerOption("story8","group","story")
   SetTriggerOption("story9","group","story") 
   SetTriggerOption("storya","group","story")
   SetTriggerOption("storyb","group","story")
   --EnableTriggerGroup("story",false)
   job.temp=job.last
   job.name="quest"
   exe('story')
   return check_bei(checkQuestCal)
end

function storySkilla(n,l,w)
    --print(w[4])
    if w[4] == "躺尸剑法" then
        if quests["lcj"].auto == 0 or quests["lcj"].auto == 3 then
            quests["lcj"].auto = 5
	 	    SetVariable("autolcj",quests["lcj"].auto)
	    end
    end
    if w[4] == "凌波微步" then
	    if quests["tlbb"].auto == 0 or quests["tlbb"].auto == 4 then
            quests["tlbb"].auto = 1
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if w[4] == "北冥神功" then
	    quests["tlbb"].beiming = true
        if quests["tlbb"].auto == 0 or quests["tlbb"].auto == 2 then
            quests["tlbb"].auto = 3
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if string.find(w[4],"胡家刀法") then
        if quests["fox"].auto ==0 or quests["fox"].auto == 3 then
            quests["fox"].auto = 1
	        SetVariable("autofox",quests["fox"].auto)
	    end
    end
    if string.find(w[4],"苗家剑法") then
        if quests["fox"].auto ==0 or quests["fox"].auto == 3 then
            quests["fox"].auto = 2
	        SetVariable("autofox",quests["fox"].auto)
	    end
	    quests["fox"].mjjf = true
    end
	if w[4] == "冷泉神功" then
	    if quests["fox"]["miao"] and quests["fox"]["hufei"] then
	        quests["fox"]["lengquan"] = true
		end
    end
end
function storyFoxFight(n,l,w)
    if w[3]=="苗人凤" then
	    quests["fox"]["miao"] = true
	end
	if w[3]=="胡斐" then
	    quests["fox"]["hufei"] = true
	end
end
function storySkillb()
    if quests["lcj"].auto == 2 then
        quests["lcj"].auto = 3
        SetVariable("autolcj",quests["lcj"].auto)
    end
    quests["lcj"].szj = true
	quests["lcj"]["shenzhao"] = true
	--if GetVariable("autoshenzhao") and GetVariable("autoshenzhao")=="1" then
	--    quests["lcj"].auto = 3
	--    SetVariable("autolcj",quests["lcj"].auto)
	--end
end
function storySkillc()
    if quests["lcj"].auto < 5 or quests["lcj"].auto == 7 then
        quests["lcj"].auto = 2
        SetVariable("autolcj",quests["lcj"].auto)
    end
    quests["lcj"].szj = true
end
function storySkilld()
    if quests["lcj"].auto < 5 or quests["lcj"].auto == 7 then
        quests["lcj"].auto = 1
        SetVariable("autolcj",quests["lcj"].auto)
    end
end
function storySkille()
   quests["lcj"].szj = true
end
function storySkillf()
    if GetVariable("autobgz") and quests["bgz"] and quests["bgz"].auto == 1 then 
        quests["bgz"].auto = 2
        SetVariable("autobgz",quests["bgz"].auto)
    end
end
function storySkillh()
    if quests["lcj"].auto == 0 or quests["lcj"].auto == 5 then
        quests["lcj"].auto = 6
	 	SetVariable("autolcj",quests["lcj"].auto)
    end
end
function storySkillg(n,l,w)
    --print(w[3])
    if string.find(w[3],"胡家刀法") then
        if quests["fox"].auto == 1 then
	        quests["fox"].auto = 2
	 	    SetVariable("autofox",quests["fox"].auto)
	    end
    end
    if string.find(w[3],"苗家剑法") then
        if quests["fox"].auto == 2 then
	        quests["fox"].auto = 3
	 	    SetVariable("autofox",quests["fox"].auto)
	    end
	    quests["fox"].mjjf = true
    end
	if string.find(w[3],"冷泉神功") then
		if GetVariable("autolengquan") and GetVariable("autolengquan")=="1" then
		    quests["lengquan"].auto = 2
	        SetVariable("autolengquan",quests["lengquan"].auto)
		end
    end
	if string.find(w[3],"凌波微步") then
	    if quests["tlbb"].auto == 1 then
            quests["tlbb"].auto = 2
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
    if string.find(w[3],"北冥神功") then
        if quests["tlbb"].auto == 3 then
            quests["tlbb"].auto = 4
	        SetVariable("autotlbb",quests["tlbb"].auto)
		end
    end
end
	  
function checkQuestOver()
    DeleteTriggerGroup("story")
    if job.temp then job.last = job.temp end
    job.temp = nil
    if Bag["人皮"] or Bag["九阴真经下卷"] or Bag["宝藏图"] then
        return husongQuit()
    end
	if Bag["面具"] then
	    exe('drop mian ju')
    end
	if Bag["冷月宝刀"] then
	    exe('drop baodao')
    end
    return check_bei(check_jobx,1)
end
function checkQuestTongji()
    if not drugPrepare["幸运珍珠"] then
	    ColourNote ('white','red','QUEST重要提示：准备药品列表没有选择幸运珍珠，将不会进行自动解密！')
	end
    if quests["hubo"].auto and quests["hubo"].auto > 0 and quests["hubo"].auto < 3 then
        if GetVariable("timehubo") then
	        quests["hubo"].time=tonumber(GetVariable("timehubo"))
	    end
        if quests["hubo"].time then
	        local l_time = 24*60*60 - (os.time() - quests["hubo"].time)
	        checkQuestNote("双手互搏",l_time)
	    end
    end
    if quests["lcj"].auto and (quests["lcj"].auto==1 or quests["lcj"].auto==2 or quests["lcj"].auto==5 or quests["lcj"].auto==6) then
        if GetVariable("timelcj") then
	        quests["lcj"].time=tonumber(GetVariable("timelcj"))
	    end
        if quests["lcj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["lcj"].time)
	        checkQuestNote("连城武功",l_time)
	    end
    end
    if quests["tlbb"].auto == 1 or quests["tlbb"].auto == 3 then
        if GetVariable("timetlbb") then
	        quests["tlbb"].time=tonumber(GetVariable("timetlbb"))
	    end
        if quests["tlbb"].time then
            local l_time = 24*60*60 - (os.time() - quests["tlbb"].time)
            checkQuestNote("天龙武功",l_time)
	    end 
    end
    
    if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3 then 
        if GetVariable("timefox") then
	        quests["fox"].time=tonumber(GetVariable("timefox"))
	    end
        if quests["fox"].time then
            local l_time
            if job.expAvg and job.expAvg > 0 then
	            l_time = (500000/job.expAvg) + 5
	        else
	            l_time = 9999
	        end
	        if canwu and canwu.exp and canwu.exp>0 then
	            l_time = 24
	        end
    	    local b_time = l_time*60*60 - (os.time() - quests["fox"].time)
    	    checkQuestNote("飞狐武功",b_time)
	    end
    end
   
    questTongji = questTongji or {}
    for p,q in pairs(questTongji) do
        if _G[q] then
		    _G[q]()
	    end 
    end
end
function checkQuestNote(p_quest,p_time)
    if not p_quest or not p_time then return end
    if p_time <= 0 then 
	    ColourNote ('white','red','QUEST提示：即将或正在尝试解密【'.. p_quest ..'】，敬请关注！')
    else   
        local l_hour= math.modf(p_time/3600)
        local l_min = math.modf((p_time-l_hour*3600)/60)
        local l_sec = p_time-l_hour*3600-l_min*60        
        ColourNote ('yellow','blue','QUEST提示：离下一次尝试解密【'.. p_quest ..'】大概还有【'.. l_hour ..'小时'.. l_min .. '分' .. l_sec ..'秒' ..'】！')
    end
end

questList = questList or {}
questList["hubo"] = function() if hp.exp>2000000 and skills["qimen-bagua"] and skills["qimen-bagua"].lvl>150 then return "双手互搏" else return false end end


function checkQuestCal()
    EnableTriggerGroup("story",false)
	
	if not drugPrepare["幸运珍珠"] then
	    return checkQuestOver()
	end
	
	dbVarCompareTime()
    
    if hp.exp>2000000 and skills["qimen-bagua"] and skills["qimen-bagua"].lvl>150 then
        if GetVariable("autohubo") then
	 	    quests["hubo"].auto=tonumber(GetVariable("autohubo"))
	    end
        if quests["hubo"].auto==nil or quests["hubo"].auto == 0 then
	        quests["hubo"].auto = 1
	    end
	    if GetVariable("timehubo") then
	 	    quests["hubo"].time=tonumber(GetVariable("timehubo"))
	    end
	    if quests["hubo"].time==nil then 
	        quests["hubo"].time = os.time() - 25*60*60
	    end
	    if os.time()-quests["hubo"].time > 24*60*60 then
	        if (quests["hubo"].auto==1 and hp.shen<0) then
	            return turnShen("+")
	 	    end
	    end 
	    if  (quests["hubo"].auto==1 and hp.shen>=0) or quests["hubo"].auto==2 then
	        if quests["hubo"].time==nil or os.time()-quests["hubo"].time > 24*60*60 then
	 	        quests["hubo"].time = os.time() - 18*60*60
	 	 	    SetVariable("timehubo",quests["hubo"].time)
	 	 	    exe('pray pearl')
	 	 	    return questHubo()
	        else
	 	        if quests["hubo"].time then
	 	 	        local l_time = 24*60*60 - (os.time() - quests["hubo"].time)
	 	 	        if l_time < 0 or l_time * math.random() < 1800 then
	 	 	            checkQuestNote("双手互搏",l_time)
	 	 	        end
	 	 	    end
	 	    end
	    end
    end
   
    if quests["lcj"].auto and (quests["lcj"].auto==1 or quests["lcj"].auto==2 or quests["lcj"].auto==5 or quests["lcj"].auto==6) then
        if GetVariable("timelcj") then
	 	    quests["lcj"].time=tonumber(GetVariable("timelcj"))
	    end
        if quests["lcj"].time==nil or os.time()-quests["lcj"].time > 24*60*60 then
	 	    quests["lcj"].time = os.time() - 18*60*60
	 	    SetVariable("timelcj",quests["lcj"].time)
	 	    if GetVariable("autolcj") then
	 	        quests["lcj"].auto=tonumber(GetVariable("autolcj"))
	        end
            if quests["lcj"].auto == 5 or quests["lcj"].auto == 6 then
	            exe('pray pearl')
	 	        return questTsjf()
	        end
	 	    if quests["lcj"].auto == 1 then
	            exe('pray pearl')
	 	        return questSzj()
	        end
	 	    if quests["lcj"].auto == 2 then
	            exe('pray pearl')
	 	        return questSzjDy()
	        end
	    else
	 	    if quests["lcj"].time then
	 	 	    local l_time = 24*60*60 - (os.time() - quests["lcj"].time)
	 	 	    if l_time < 0 or l_time * math.random() < 1800 then
	 	 	        checkQuestNote("连城武功",l_time)
	 	 	    end
	 	 	end
	    end
    end
   
    if quests["tlbb"].auto == 1 or quests["tlbb"].auto == 3 then
        if GetVariable("timetlbb") then
	 	    quests["tlbb"].time=tonumber(GetVariable("timetlbb"))
	    end
        if quests["tlbb"].time==nil or os.time()-quests["tlbb"].time > 24*60*60 then
	 	    quests["tlbb"].time = os.time() - 18*60*60
	 	    SetVariable("timetlbb",quests["tlbb"].time)
            if quests["tlbb"].auto > 0 then
	            exe('pray pearl')
	 	        return questLbwb()
	        end
	    else
	 	    if quests["tlbb"].auto > 0 and quests["tlbb"].time then
	 	 	    local l_time = 24*60*60 - (os.time() - quests["tlbb"].time)
	 	 	    if l_time < 0 or l_time * math.random() < 1800 then
	 	 	        checkQuestNote("天龙武功",l_time)
	 	 	    end
	 	 	end
	    end
    end
   
    if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3 then
	    --print(GetVariable("autofox"))
		--print(quests["fox"].auto)
        local l_time
        if GetVariable("timefox") then
	 	    quests["fox"].time=tonumber(GetVariable("timefox"))
	    end
	    --if GetVariable("autofox") and quests["fox"].auto==0 then
		if GetVariable("autofox") then
	 	    quests["fox"].auto=tonumber(GetVariable("autofox"))
	    end
	    if job.expAvg and job.expAvg > 0 then
	        l_time = (500000/job.expAvg) + 5
	    else
	        l_time = 9999
	    end
	    if canwu and canwu.exp and canwu.exp>0 then
	        l_time = 24
	    end
        if quests["fox"].time==nil or os.time()-quests["fox"].time > l_time*60*60 then
	 	    quests["fox"].time = os.time() - 12*60*60
	 	    SetVariable("timefox",quests["fox"].time)
	 	    SetVariable("autofox",quests["fox"].auto)
            if quests["fox"].auto == 1 or quests["fox"].auto == 2 or quests["fox"].auto == 3  then
	            exe('pray pearl')
	 	        return questFox()
	        end
	    else
	        if quests["fox"].auto > 0 and quests["fox"].time then
	 	 	    local b_time = l_time*60*60 - (os.time() - quests["fox"].time)
	 	 	    if b_time < 0 or b_time * math.random() < 1800 then
	 	 	        checkQuestNote("飞狐武功",b_time)
	 	 	    end
	 	    end
	    end
    end
	
	questCal = questCal or {}
    for p,q in pairs(questCal) do
        if _G[q] then
		    local l_func =  _G[q]()
		    if l_func then
		        return _G[l_func]()
		    end
	    end 
    end

    return checkQuestOver()
end

function questFox()
    if quests["fox"].auto == 1 then
       return go(foxPre,"黄河流域","墓地")
	else
	   return go(foxPre,"兰州城","正厅")
	end
end
function foxPre()
    if not locl.id["胡斐"] and not locl.id["苗人凤"] then
	   quests["fox"].time = os.time() - 23*60*60
	   return check_bei(foxOver)
	end
    DeleteTriggerGroup("hjdf")
    create_trigger_t('hjdf1',"^(> )*你向(胡斐|苗人凤)打听有关『(胡家刀法|苗家剑法|刀剑融合)』的消息",'','foxAsk')
    create_trigger_t('hjdf2',"^(> )*这里没有这个人。$",'','foxNobody')
    SetTriggerOption("hjdf1","group","hjdf")
    SetTriggerOption("hjdf2","group","hjdf")
	questStartLog(quests["fox"].name)
	if quests["fox"].auto == 1 then
	   exe('ask hu fei about 胡家刀法')
	elseif quests["fox"].auto == 2 then
	   exe('ask miao renfeng about 苗家剑法')
	else
	   exe('ask miao renfeng about 刀剑融合')
	end
end
function foxAsk()
    EnableTriggerGroup("hjdf",false)
	DeleteTriggerGroup("fox")
	create_trigger_t('fox1',"^(> )*(胡斐|苗人凤)说道：「以你当前的经验恐怕还是难以领悟",'','foxFail')
	create_trigger_t('fox2',"^(> )*(胡斐|苗人凤)对着你摇了摇头。",'','foxFail')
	create_trigger_t('fox3','^(> )*你摇了摇头，道：“好像还是很困难的','','foxContinue')
	create_trigger_t('fox4',"^(> )*(你听了苗人凤的指点，对苗家剑法和胡家刀法的奥妙似乎更加明白|你听了胡斐的指点，对胡家刀法的奥妙|你明悟其中，突然间明白了一切|苗人凤说道：「你已经刀剑融合)",'','foxSucc')
	SetTriggerOption("fox1","group","fox")
    SetTriggerOption("fox2","group","fox")
	SetTriggerOption("fox3","group","fox")
	SetTriggerOption("fox4","group","fox")
end
function foxSucc()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time()
	quests["fox"].auto = quests["fox"].auto + 1
	local l_name = "雪山飞狐"
    if quests["fox"].auto==2 then l_name = "胡家刀法" end 
    if quests["fox"].auto==3 then l_name = "苗家剑法" end 
    if quests["fox"].auto==4 then l_name = "刀剑融合" end 
    --if quests["fox"].auto==5 then l_name = "冷泉神功" end 	
	questSucLog(l_name)
	return check_bei(foxOver)
end
function foxContinue()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time()
	return check_bei(foxOver)
end
function foxFail()
    EnableTriggerGroup("fox",false)
	quests["fox"].time = os.time() - 23*60*60
	return check_bei(foxOver)
end
function foxNobody()
    EnableTriggerGroup("hjdf",false)
	quests["fox"].time = os.time() - 13*60*60
	return check_bei(foxOver)
end
function foxOver()
    DeleteTriggerGroup("hjdf")
	DeleteTriggerGroup("fox")
	SetVariable("timefox",quests["fox"].time)
	SetVariable("autofox",quests["fox"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end

function questLbwb()
    return go(lbwbKetou,"无量山","内室")
end
function lbwbKetou()
    
    if locl.room ~= "内室" then
	    quests["tlbb"].time = os.time() - 20*60*60
	    return lbwbOver()
	end
	
	questStartLog(quests["tlbb"].name)
	
	if skills["lingbo-weibu"] then
	    quests["tlbb"].time = os.time()
	    return lbwbYanjiu()
	end
	
	exe('ketou yuxiang;l left;l right')
	exe('#10(ketou yuxiang)')
	
	return check_bei(lbwbBag,1)
end
function lbwbBag()
    exe('#10(ketou yuxiang)')
	checkBags()
	return check_busy(lbwbBojuan,1)
end
function lbwbBojuan()
    if Bag["帛卷"] then
	    exe('pray pearl')
	    exe('#10(fan bo juan)')
		
	    return check_bei(lbwbContinue,1)
	else
	    quests["tlbb"].time = os.time() - 20*60*60
	    return lbwbYanjiu()
	end
end
function lbwbContinue()
    exe('#10(fan bo juan)')
	checkBags()
	quests["tlbb"].time = os.time()
	return check_busy(lbwbYanjiu)
end
function lbwbYanjiu()
    if quests["tlbb"].beiming then
        exe('#3(yanjiu picture)')
	end
	exe('cha')
	checkBags()
	return check_busy(lbwbOver)
end
function lbwbBook()
	quests["tlbb"].auto = 2
	SetVariable("autotlbb",quests["tlbb"].auto)
	questSucLog('凌波微步')
	return dushu("bo juan")
end
function lbwbOver()
    
	if quests["tlbb"].auto == 1 and skills["lingbo-weibu"] then 
	    quests["tlbb"].auto = 2
	end
	if quests["tlbb"].auto == 3 and skills["beiming-shengong"] then
	    quests["tlbb"].auto = 4
	end
	SetVariable("timetlbb",quests["tlbb"].time)
	SetVariable("autotlbb",quests["tlbb"].auto)
    CloseLog()
	if Bag["帛卷"] then
	    return lbwbBook()
	end
    return check_bei(checkQuestOver,1)
end

function questSzj()
    return go(questSzjChk,"苏州城","北门兵营")
end
function questSzjChk()
    if hp.exp>1000000 then
	   return wipe("zhao liangdong",questSzjGo)
	else
	   return questSzjGo()
	end
end
function questSzjGo()
    exe('west')
	locate()
	return check_busy(szjAsk,1)
end
function szjAsk()
    if not locl.id["丁典"] then
	   return check_bei(tsjfOver)
	end
    DeleteTriggerGroup("szjAsk")
    create_trigger_t('szjAsk1',"^(> )*你向丁典打听有关『神照经』的消息",'','szjTAsk')
    create_trigger_t('szjAsk2',"^(> )*这里没有这个人。$",'','dyNobody')
    SetTriggerOption("szjAsk1","group","szjAsk")
    SetTriggerOption("szjAsk2","group","szjAsk")
	questStartLog(quests["lcj"].name)
	exe('ask ding dian about 神照经')
	exe('alias action 神照经')
end
function szjTAsk()
    EnableTriggerGroup("szjAsk",false)
	DeleteTriggerGroup("szjTwo")
	create_trigger_t('szjTwo1',"^(> )*你听了丁典的指点，对神照经的奥妙似乎有些心得",'','szjSucc')
	create_trigger_t('szjTwo2','^(> )*你把 "action" 设定为 "神照经" 成功完成。$','','szjTwoContinue')
	create_trigger_t('szjTwo3',"^(> )*你听了丁典的指点，可是对神照经的奥妙全然不得要领",'','szjTwoFail')
	SetTriggerOption("szjTwo1","group","szjTwo")
    SetTriggerOption("szjTwo2","group","szjTwo")
	SetTriggerOption("szjTwo3","group","szjTwo")
end
function questSzjDy()
    return go(szjDyAsk,"大雪山","岩石")
end
function szjDyAsk()
    DeleteTriggerGroup("dyAsk")
    create_trigger_t('dyAsk1',"^(> )*你向狄云打听有关『神照经』的消息",'','szjTwoAsk')
    create_trigger_t('dyAsk2',"^(> )*这里没有这个人。$",'','dyNobody')
    SetTriggerOption("dyAsk1","group","dyAsk")
    SetTriggerOption("dyAsk2","group","dyAsk")
	questStartLog(quests["lcj"].name)
	exe('ask di yun about 神照经')
	exe('alias action 神照经')
end
function szjTwoAsk()
    EnableTriggerGroup("dyAsk",false)
	DeleteTriggerGroup("szjTwo")
	create_trigger_t('szjTwo1',"^(> )*你听了狄云的指点，对神照经的奥妙似乎有些心得",'','szjTwoSucc')
	create_trigger_t('szjTwo2','^(> )*你把 "action" 设定为 "神照经" 成功完成。$','','szjTwoContinue')
	create_trigger_t('szjTwo3',"^(> )*你听了狄云的指点，可是对神照经的奥妙全然不得要领",'','szjTwoFail')
	SetTriggerOption("szjTwo1","group","szjTwo")
    SetTriggerOption("szjTwo2","group","szjTwo")
	SetTriggerOption("szjTwo3","group","szjTwo")
end
function szjSucc()
    EnableTriggerGroup("szjTwo",false)
	questSucLog("神照经一段")
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function szjTwoSucc()
    EnableTriggerGroup("szjTwo",false)
	questSucLog("神照经二段")
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end 
function szjTwoFail()
    EnableTriggerGroup("szjTwo",false)
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function szjTwoContinue()
    EnableTriggerGroup("szjTwo",false)
	quests["lcj"].time = os.time() - 16*60*60
	return check_bei(tsjfOver)
end  

function questTsjf()
    return go(dyAsk,"大雪山","岩石")
end
function dyAsk()
    DeleteTriggerGroup("dyAsk")
    create_trigger_t('dyAsk1',"^(> )*你向狄云打听有关『(躺尸剑法|连城剑法)』的消息",'','tsjfAsk')
    create_trigger_t('dyAsk2',"^(> )*这里没有这个人。$",'','dyNobody')
    SetTriggerOption("dyAsk1","group","dyAsk")
    SetTriggerOption("dyAsk2","group","dyAsk")
	questStartLog(quests["lcj"].name)
	if quests["lcj"].auto == 5 then
	   exe('ask di yun about 躺尸剑法')
	else
	   exe('ask di yun about 连城剑法')
	end
	exe('alias action 躺尸剑法')
end
function tsjfAsk()
    EnableTriggerGroup("dyAsk",false)
	DeleteTriggerGroup("tsjf")
	create_trigger_t('tsjf1',"^(> )*(你听了狄云的指点，对躺尸剑法|你按照狄云的指点，对唐诗剑法|狄云说道：「你已经彻底领悟了唐诗剑法奥秘)",'','tsjfSucc')
	create_trigger_t('tsjf2','^(> )*你把 "action" 设定为 "躺尸剑法" 成功完成。$','','tsjfFail')
	create_trigger_t('tsjf3','^(> )*(你听了狄云的指点，可是对躺尸剑法|你听了狄云的指点，虽然看见了唐诗剑法的招式)','','tsjfContinue')
	SetTriggerOption("tsjf1","group","tsjf")
    SetTriggerOption("tsjf2","group","tsjf")
	SetTriggerOption("tsjf3","group","tsjf")
end
function dyNobody()
    EnableTriggerGroup("dyAsk",false)
	quests["lcj"].time = os.time() - 22*60*60
	return check_bei(tsjfOver)
end
function tsjfSucc()
    EnableTriggerGroup("tsjf",false)
	if quests["lcj"].auto == 5 then
	   quests["lcj"].auto = 6
	   questSucLog("躺尸剑法")
	else
	   quests["lcj"].auto = 7
	   questSucLog("连城剑法")
	end
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function tsjfContinue()
    EnableTriggerGroup("tsjf",false)
	quests["lcj"].time = os.time()
	return check_bei(tsjfOver)
end
function tsjfFail()
    EnableTriggerGroup("tsjf",false)
	quests["lcj"].time = os.time() - 16*60*60
	return check_bei(tsjfOver)
end
function tsjfOver()
    DeleteTriggerGroup("szjAsk")
	DeleteTriggerGroup("dyAsk")
	DeleteTriggerGroup("tsjf")
	DeleteTriggerGroup("szjTwo")
    SetVariable("timelcj",quests["lcj"].time)
	SetVariable("autolcj",quests["lcj"].auto)
	CloseLog()
    return check_bei(checkQuestOver)
end

function questHubo()
    return toZbt()
end
toZbt=function()
    road.id=nil
	return go(toZbtDong,"桃花岛","洞口")
end
function toZbtDong()
	exe('enter')
	locate()
	return check_bei(questHuboLocate)
end
function questHuboLocate()
    if not locl.id["周伯通"] then
	   exe('out;enter')
	end
	questStartLog(quests["hubo"].name)
	if quests["hubo"].auto == 1 then
	    --if score.int > 25 and score.int < 33 then
	    --    exe('cgift '.. score.int-25 ..' int to str')
		--    exe('kick')
	    --end
	    --if score.int < 25 then
	    --    tmp.gift = 25-score.int
	    --    exe('cgift '.. tmp.gift ..' str to int')
		--    exe('kick')
	    --end
		if score.int < 33 and score.int~=25 then
		    changeGift({["int"]=25})
		end
	end 
	return check_busy(questHuboZbt,1)
end
function questHuboZbt()
    DeleteTriggerGroup("zbtAsk")
    create_trigger_t('zbtAsk1',"^(> )*你向周伯通打听有关『结拜』的消息",'','jiebaiAsk')
    create_trigger_t('zbtAsk2',"^(> )*这里没有这个人。$",'','zbtNobody')
	create_trigger_t('zbtAsk3',"^(> )*你向周伯通打听有关『双手互搏』的消息",'','huboAsk')
    SetTriggerOption("zbtAsk1","group","zbtAsk")
    SetTriggerOption("zbtAsk2","group","zbtAsk")
	SetTriggerOption("zbtAsk3","group","zbtAsk")
    if quests["hubo"].auto == 1 then
	    exe('ask zhou botong about 结拜')
	    exe('alias action 结拜')
	else
	    exe('ask zhou botong about 双手互搏')
	    exe('alias action 双手互搏')
	end
end
function zbtNobody()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].time = os.time() - 23*60*60
	return check_bei(huboOver)
end
function jiebaiAsk()
    EnableTriggerGroup("zbtAsk",false)
	DeleteTriggerGroup("jiebai")
    create_trigger_t('jiebai1',"^(> )*看起来周伯通在(\\D*)之内不准备理你。",'','jiebaiFail')
	create_trigger_t('jiebai2',"^(> )*周伯通与你并肩而跪",'','jiebaiSucc')
	create_trigger_t('jiebai3',"^(> )*周伯通说道：「咱俩不是结拜过了吗",'','jiebaiNext')
	create_trigger_t('jiebai4','^(> )*你把 "action" 设定为 "结拜" 成功完成。$','','jiebaiContinue')
	create_trigger_t('jiebai5',"^(> )*周伯通说道：「我现在没有空，要不你先陪我玩玩",'','jiebaiBusy')
	SetTriggerOption("jiebai1","group","jiebai")
    SetTriggerOption("jiebai2","group","jiebai")
	SetTriggerOption("jiebai3","group","jiebai")
	SetTriggerOption("jiebai4","group","jiebai")
	SetTriggerOption("jiebai5","group","jiebai")
end
function jiebaiFail(n,l,w)
    EnableTriggerGroup("jiebai",false)
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
	
	quests["hubo"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(huboOver)
end
function jiebaiSucc()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].auto = 2
	questSucLog("结拜周伯通")
	return check_bei(questHuboZbt)
end
function jiebaiNext()
    EnableTriggerGroup("jiebai",false)
	quests["hubo"].auto = 2
	return check_bei(questHuboZbt)
end
function jiebaiBusy()
    EnableTriggerGroup("jiebai",false)
    quests["hubo"].time = os.time()
    return check_bei(huboOver)
end
function jiebaiContinue()
    EnableTriggerGroup("jiebai",false)
    quests["hubo"].time = os.time()
	return check_bei(huboOver)
end
function huboAsk()
    EnableTriggerGroup("zbtAsk",false)
	DeleteTriggerGroup("hubo")
    create_trigger_t('hubo1',"^(> )*看起来周伯通在(\\D*)之内不准备理你。",'','huboFail')
	create_trigger_t('hubo2',"^(> )*周伯通说道：「你先练练这第一课",'','huboHua')
	create_trigger_t('hubo3',"^(> )*周伯通说道：「你不是已经学会",'','huboNext')
	create_trigger_t('hubo4','^(> )*你把 "action" 设定为 "双手互搏" 成功完成。$','','huboContinue')
	create_trigger_t('hubo5',"^(> )*周伯通将他领悟出来的这门天下无比的奇功，一古脑儿都教给了你",'','huboNext')
	SetTriggerOption("hubo1","group","hubo")
    SetTriggerOption("hubo2","group","hubo")
	SetTriggerOption("hubo3","group","hubo")
	SetTriggerOption("hubo4","group","hubo")
	SetTriggerOption("hubo5","group","hubo")
end
function huboFail(n,l,w)
    EnableTriggerGroup("hubo",false)
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
	
	quests["hubo"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(huboOver)
end
function huboNext()
    EnableTriggerGroup("hubo",false)
	quests["hubo"].auto = 3
	quests["hubo"].time = os.time()
	questSucLog(quests["hubo"].name)
	return check_bei(huboOver)
end
function huboHua()
    EnableTriggerGroup("hubo",false)
	quests["hubo"].time = os.time()
	wait.make(function()
	   wait.time(3)
	   exe('#23(hua fang yuan)')
	   return check_bei(huboOver)
	end)
end
function huboContinue()
    EnableTriggerGroup("hubo",false)
	return check_bei(huboOver)
end
function huboOver()
    DeleteTriggerGroup("zbtAsk")
	DeleteTriggerGroup("hubo")
	DeleteTriggerGroup("jiebai")
    SetVariable("timehubo",quests["hubo"].time)
	SetVariable("autohubo",quests["hubo"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end


goldRoom={
   ["珠宝商"]   = "changan/zhubaohang",
   ["黑衣大盗"] = "xiangyang/outnroad3",
   ["采花贼"]   = "city/wroad2",
   ["独脚大盗"] = "xiangyang/hunanroad2",
   ["大盗"]     = "taishan/hsroad2",
   ["蒙面大盗"] = "xiangyang/xiaolu1",
   ["落魄公子"] = "city/lichunyuan",
}

function getGold()
   if score.id~="panix" then
      return getGoldOver()
   end
   if job.goldtime then
	   if type(job.goldtime)~="number" or os.time()-job.goldtime<16*60 then
	      return getGoldOver()
	   end
   end
   job.goldtime=os.time()
   tmp.gold={}
   for p,q in pairs(goldRoom) do
       table.insert(tmp.gold,p)
   end
   return getGoldGo()
end
function getGoldGo()
   if type(tmp.gold)~="table" or table.getn(tmp.gold)==0 then
      return getGoldOver()
   end
   return go(getGoldKill,goldRoom[tmp.gold[1]],"")
end
function getGoldKill()
   if not locl.id[tmp.gold[1]] then
      return getGoldNext()
   end
   if tmp.gold[1]=="落魄公子" then
      exe('ask gong zi about 周芷若')
	  return wipe("song qingshu",getGoldNext)
   else
      return wipe(locl.id[tmp.gold[1]],getGoldNext)
   end
end
function getGoldNext()
   table.remove(tmp.gold,1)
   return getGoldGo()
end
function getGoldOver()
   tmp.gold=nil
   return check_heal()
end

function turnShen(p_flag)
    if p_flag == '+' then
           if locl.area=="大雪山" then
	      return go(turnShenJump,"大雪山","雪谷")
	   end
	   if Bag["正气丹"] then
	      exe('eat zhengqi dan;hp')
		  checkBags()
		  return check_bei(check_job,1)
	   end
	   return go(turnShenJump,"大雪山","雪谷")
	else
	   if Bag["邪气丸"] then
	      exe('eat xieqi wan;hp')
		  checkBags()
		  return check_bei(check_job,1)
	   end
	   if Bag["暴雨梨花针"] then
	       return go(turnShenGive,"神龙岛","大厅")
	   end
	   return go(turnShenBuy,"襄阳城","兵器铺")
	end
end
function turnShenJump()
    exe('jump down')
	locate()
	return check_busy(turnShenStone,1)
end
function turnShenStone()
    if locl.room=="岩石" then
	   return turnShenMb()
	else
	   return go(turnShenJump,"大雪山","雪谷")
	end
end
function turnShenMb()
    exe('#20(mianbi);hp')
	return checkWait(turnShenChk,0.5)
end
function turnShenChk()
    if hp.shen>0 then
	   return check_heal()
	else
	   return turnShenMb()
	end
end
function turnShenBuy()
    if locl.room~="兵器铺" then
	   return go(turnShenBuy,"襄阳城","兵器铺")
	end
    if Bag["暴雨梨花针"] then
	   return go(turnShenGive,"神龙岛","大厅")
	else
	   exe('buy zhen')
	   checkBags()
	   return check_busy(turnShenBuy,1)
	end
end
function turnShenGive()
    if locl.room~="大厅" or not locl.id["洪安通"] then
	   return go(turnShenGive,"神龙岛","大厅")
	end
	exe('give 1 lihuan zhen to hong antong;hp')
	checkBags()
	return check_busy(turnShenCheck,1)
end
function turnShenCheck()
    if hp.shen<0 then
	   return check_heal()
	end
	if Bag["暴雨梨花针"] then
	   return check_bei(turnShenGive)
	else
	   return go(turnShenBuy,"襄阳城","兵器铺")
	end
end

function mrForce()
    return go(mrKetou,"燕子坞","墓地")
end
function mrKetou()
    if locl.room~="墓地" then
	   return mrForce()
	end
	flag.idle = 0
    exe('yun jing;#3(ketou);w;e;get book')
    exe('hp')
	return check_bei(mrKetouChk)
end
function mrKetouChk()
    if skills["force"].lvl>100 then
	   return check_heal()
	end
    locate()
	exe('cha')
    if hp.jingxue>100 then
	   return checkWait(mrKetou,3)
	else
	   exe('hp')
	   return checkWait(mrKetouChk,8)
	end
end

function huxi()
    if hp.exp and hp.exp>2000000 then
       return go(huxiStart,"昆仑山","白牛山")
	else
	   return go(huxiXhz,"昆仑山","前厅")
	end
end
function huxiXhz()
    if locl.room~="前厅" then
	   return huxi()
	end
	if locl.id["西华子"] then
	   locate()
	   return checkWait(huxiXhz,5)
	else
	   exe('#4s')
	   return go(huxiStart,"昆仑山","白牛山")
	end
end
function huxiStart()
    if locl.room~="白牛山" then
	   return huxi()
	end
    DeleteTriggerGroup("huxi")
    create_trigger_t('huxi1',"^(> )*你集聚体内真气，深深吸进几口气",'','huxiCheck')
    create_trigger_t('huxi2',"^(> )*寒风凛冽，你刚运过功",'','huxiChk')
	SetTriggerOption("huxi1","group","huxi")
	SetTriggerOption("huxi2","group","huxi")
	exe('enable force '.. perform.force)
    exe('wo stone;huxi;hp')
end
function huxiChk()
    flag.idle = 0
    if skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100 then
	   return check_bei(huxiOver,1)
	end
    wait.make(function() 
          wait.time(1)          
          if hp.jingxue<60 then
	         exe('yun jing')
	      end
	      if hp.qixue<60 then
	         exe('yun qi')
	      end
		  exe('wo stone;huxi;hp;cha')
    end)
end
function huxiCheck()
    flag.idle = 0
    if skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100 then
	   return check_bei(huxiOver,1)
	end
    wait.make(function() 
          wait.time(2)          
          if hp.jingxue<60 then
	         exe('yun jing')
	      end
	      if hp.qixue<60 then
	         exe('yun qi')
	      end
		  exe('wo stone;huxi;hp;cha')
    end)
end
function huxiOver()
    DeleteTriggerGroup("huxi")
	return check_heal()
end

function wxjzFofa()
    return go(wxjzFofaPot,"襄阳城","潜能银行")
end
function wxjzFofaPot()
    exe('qn_qu 3000')
    return go(wxjzFofaPre,"嵩山少林","心禅堂")
end
function wxjzFofaPre()
    EnableTrigger("fight16",false)
    if Bag["挠钩"] and Bag["套索"] then
	   exe('n')
	   exe('pray pearl')
	   for p in pairs(Bag) do
	       if Bag[p].kind then
		      for i = 1,Bag[p].cnt do
			      exe('drop '..Bag[p].fullid)
			  end
		   end
	   end
	   exe('drop silver')
	   exe('drop stone')
	   exe('drop stone')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzFofaAsk,1)
	end
    if locl.id["方生大师"] then
	   if not Bag["挠钩"] then
	      exe('ask fangsheng about 挠钩')
	   end
	   if not Bag["套索"] then
	      exe('ask fangsheng about 套索')
	   end
	   checkBags()
	   return check_busy(wxjzFofaPre,1)
	else
	   return check_heal()
	end
end
function wxjzFofaAsk()
    if locl.room=="心禅堂" then
	   exe('n')
	   exe('pray pearl')
	   exe('shuai tao suo')
	   exe('da nao gou;pa up;enter')
	   locate()
	   return check_busy(wxjzFofaAsk,1)
	end
	if not locl.id["无相禅师"] then
	   return check_heal()
	end
	DeleteTriggerGroup("fofa")
    create_trigger_t('fofa1',"^(> )*你向无相禅师打听有关『佛法』的消息",'','fofaAccept')
    create_trigger_t('fofa2',"^(> )*这里没有这个人。$",'','fofaNobody')
    SetTriggerOption("fofa1","group","fofa")
    SetTriggerOption("fofa2","group","fofa")
	exe('ask wuxiang chanshi about 佛法')
end
function fofaNobody()
    EnableTriggerGroup("fofa",false)
	return check_bei(wxjzFofaOver)
end
function wxjzFofaOver()
    DeleteTriggerGroup("fofa")
	DeleteTriggerGroup("ffacp")
	exe('out;d;get all')
	return check_heal()
end
function fofaAccept()
    EnableTriggerGroup("fofa",false)
	DeleteTriggerGroup("ffacp")
	create_trigger_t('ffacp1',"^(> )*你端坐良久，若有所悟。",'','fofaAskCon')
	create_trigger_t('ffacp2',"^(> )*无相禅师(对你|)说道：(「|)你的潜能不够了。",'','fofaAskPot')
	create_trigger_t('ffacp3',"^(> )*无相禅师(对你|)说道：(「|)\\D*佛法精深",'','fofaAskOver')
	SetTriggerOption("ffacp1","group","ffacp")
	SetTriggerOption("ffacp2","group","ffacp")
	SetTriggerOption("ffacp3","group","ffacp")
end
function fofaAskCon()
    EnableTriggerGroup("ffacp",false)
	return check_bei(wxjzFofaAsk,1)
end
function fofaAskPot()
    EnableTriggerGroup("ffacp",false)
	return check_bei(wxjzFofaOver,1)
end
function fofaAskOver()
    EnableTriggerGroup("ffacp",false)
	flag.wxjz=1
	return check_bei(wxjzFofaOver,1)
end

function learnSzj()
    return go(learnSzjChk,"苏州城","北门兵营")
end
function learnSzjChk()
    if hp.exp>500000 then
	   return wipe("zhao liangdong",learnSzjGo)
	else
	   return learnSzjGo()
	end
end
function learnSzjGo()
    exe('west')
	locate()
	return check_busy(learnSzjAsk,1)
end
function learnSzjAsk()
    flag.idle = 0
    if not locl.id["丁典"] then
	    return check_bei(learnSzjOver)
	end
	if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl >= hp.pot_max-100 then
	    return check_bei(learnSzjOver)
	end
	if tmp.busy and (not condition["任务繁忙状态"] or condition["任务繁忙状态"]<=20) then
	    return check_bei(learnSzjOver)
    end
	if hp.pot<10 then
	    return check_bei(learnSzjOver)
	end
	if hp.neili<1000 and Bag["川贝内息丸"] then
	    exe('eat chuanbei wan')
	end
	if hp.neili<500 then
        if Bag["大还丹"] then
	        exe('eat dan')
	    else
	        return check_bei(learnSzjOver)
	    end
	end
	exe('yun jing;ask ding dian about 神照经;cha;hp')
	if math.random(1,5)==1 then
        locate()
		condition = {}
		exe('cond')
		checkBags()
    end
	return check_busy(learnSzjAsk,1)
end
function learnSzjOver()
    if hp.pot >= hp.pot_max then
	    return potSave()
	end
	return check_heal()
end

function learnQmbg()
    return go(learnQmbgAsk,"thd/neishi1","")
end
function learnQmbgAsk()
    flag.idle = 0
    if not locl.id["黄蓉"] then
	   return check_bei(learnQmbgOver)
	end
	if skills["qimen-bagua"] and skills["qimen-bagua"].lvl >= 200 then
	   return check_bei(learnQmbgOver)
	end
	if hp.pot<10 then
	   return check_bei(learnQmbgOver)
	end
	if hp.neili<1000 and Bag["川贝内息丸"] then
	   exe('eat chuanbei wan')
	end
	if hp.neili<500 then
       if Bag["大还丹"] then
	      exe('eat dan')
	   else
	      return prepare_neili(learnQmbgAsk)
	   end
	end
	exe('yun jing;ask huang rong about 奇门八卦;cha;hp')
	locate()
	checkBags()
	return check_busy(learnQmbgAsk,1)
end
function learnQmbgOver()
    if hp.pot >= hp.pot_max then
	   return potSave()
	end
	return check_heal()
end



function tiaoshui()
    return go(tiaoshuiAsk,"嵩山少林","后殿")
end
function tiaoshuiAsk()
    if locl.id["慧空尊者"] then
	   wait.make(function()
	      exe('ask huikong zunzhe about 挑水')
	      wait.time(3)
	      exe('get tie tong')
	      checkBags()
	      return check_busy(tiaoshuiTong,1)
	   end)
	end
	return go(tiaoshuiAsk,"嵩山少林","后殿")
end
function tiaoshuiTong()
    if Bag["大铁桶"] then
	   return go(tiaoshuiFill,"嵩山少林","佛心井")
	end
	return go(tiaoshuiAsk,"嵩山少林","后殿")
end
function tiaoshuiFill()
    flag.idle = 0
    exe('fill tie tong')
	return go(tiaoshuiPour,"嵩山少林","后殿")
end
function tiaoshuiPour()
    exe('pour gang')
	checkBags()
	return check_busy(tiaoshuiChk,1)
end
function tiaoshuiChk()
    if not Bag["镣铐"] then
	   return check_heal()
	end
	if not Bag["大铁桶"] then
	   return go(tiaoshuiAsk,"嵩山少林","后殿")
	end
	return go(tiaoshuiFill,"嵩山少林","佛心井")
end

function emLingwuF()
    if perform.force then 
       exe('enable force '.. perform.force)
	end
    exe('cha;hp')
    go(emLingwuFStart,'峨嵋山','雷洞坪')
end
function emLingwuFStart()
    if locl.room=='雷洞坪' then
       exe('yun jing;lingwu force 30;hp')
       check_bei(emLingwuFCheck)
    else
       return check_heal()
    end
end
function emLingwuFCheck()
    flag.idle = 0
    if hp.pot<30 or (skills["force"] and skills[perform.force] and skills[perform.force].lvl<skills["force"].lvl) or (skills[perform.force] and skills[perform.force].lvl==hp.pot_max-100) or skills["force"].lvl>200 then
       return check_heal()
    end
    if hp.neili<500 then
       return prepare_neili(emLingwuF)
    end
    exe('yun jing;lingwu force 30;cha;hp')
    return check_bei(emLingwuFCheck)
end

function canWu(p_canwu)
    tmp.canwu = p_canwu
	if tmp.canwu=="exp" then
	   return go(canwuDo,"曼佗罗山庄","娘缳玉洞-实战部")
	end
	if tmp.canwu=="gift" then
	   return go(canwuDo,"曼佗罗山庄","娘缳玉洞-天赋部")
	end
end
function canwuDo()
    local expcut = 1800000
	if score.vip and score.vip=="荣誉终身贵宾" then expcut = 1600000 end
	if score.vip and score.vip=="年卡贵宾" then expcut = 1700000 end
    if tongji.exp then tongji.exp = tongji.exp - expcut end
    if tmp.canwu=="exp" then
       exe('canwu combat')
	end
	if tmp.canwu=="gift" then
       exe('canwu gift')
	end
	return check_bei(canwuOver,1)
end
function canwuOver()
    
    return go(check_heal,'柳宗镇','药房')
end

function lingqi()
    return go(lingqiCheck,"嵩山","封禅台")
end
function lingqiCheck()
    if not locl.id["左冷禅"] then
       return lingqi()
    end
    return wipe("zuo lengchan",lingqiGet)
end
function lingqiGet()
    for i=1,3 do
        exe('get lingqi from corpse '..i)
	exe('get shuaiyi tie from corpse '..i)
    end
    return ouxuepu()
end
function ouxuepu()
    return go(ouxuepuCheck,"成都城","大厅")
end
function ouxuepuCheck()
    if not locl.id["刘好弈"] then
       return check_heal()
	end
	DeleteTriggerGroup("oxpAsk")
    create_trigger_t('oxpAsk1',"^(> )*你向刘好弈打听有关『question』的消息",'','ouxuepuAsk')
    create_trigger_t('oxpAsk2',"^(> )*这里没有这个人。$",'','ouxuepuNobody')
    SetTriggerOption("oxpAsk1","group","oxpAsk")
    SetTriggerOption("oxpAsk2","group","oxpAsk")
	exe('ask liu about question')
end
function ouxuepuNobody()
    EnableTriggerGroup("oxpAsk",false)
	return check_heal()
end
function ouxuepuNext()
    return check_bei(ouxuepuCheck)
end
function ouxuepuAsk()
    EnableTriggerGroup("oxpAsk",false)
	DeleteTriggerGroup("oxp")
	create_trigger_t('oxp1','^(> )*刘好弈点点头道：“好了，来猜','','ouxuepuGuess')
	create_trigger_t('oxp2','^(> )*刘好弈道：“你还有','','ouxuepuGuess')
	create_trigger_t('oxp3','^(> )*刘好弈道：“下次再猜吧','','ouxuepuNext')
	create_trigger_t('oxp4','^(> )*刘好弈在墙上按了几下','','ouxuepuPass')
	SetTriggerOption("oxp1","group","oxp")
	SetTriggerOption("oxp2","group","oxp")
	SetTriggerOption("oxp3","group","oxp")
	SetTriggerOption("oxp4","group","oxp")
end
function ouxuepuGuess()
    --EnableTriggerGroup("oxp",false)
	tmp.guess = tmp.guess or {}
	--if not tmp.guess["1"] then
	--   tmp.guess["1"]=math.random(1,7)
	--end
	local a,b,c,d
	a = math.random(1,7)
	b = math.random(1,7)
    while b == a do
	   	b = math.random(1,7)
	end
	c = math.random(1,7)
	while c == a or c == b do
	   	c = math.random(1,7)
	end
	d = math.random(1,7)
	while d == a or d == b or d == c do
	   	d = math.random(1,7)
	end
	exe('guess '..a..b..c..d)
end
function ouxuepuPass()
    EnableTriggerGroup("oxp",false)
	exe('w;l shelf')
	return checkWait(glsanGo,2)
end
function glsanGo()
    return go(glsBuy,"峨嵋山","草棚")
end
function glsBuy()
    if locl.id["小贩子"] then
	   exe('buy tie qiao')
	   checkBags()
	   return checkWait(glsCheck,2)
	else 
	   return glsanGo()
	end
end
function glsCheck()
    if Bag["铁锹"] then
	   return go(glsDig,"襄阳城","蔡邕墓")
	else
	   return glsanGo()
	end
end
function glsDig()
    exe('wa mu')
	return checkWait(xishantuGo,2)
end
function xishantuGo()
    return go(xishantuFan,"牛家村","密室")
end
function xishantuFan()
    exe('open xiang;open jiaceng')
	exe('#25(fan painting)')
	locate()
	checkBags()
	return check_bei(xishantuOver,1)
end
function xishantuOver()
    if Bag["呕血谱"] and Bag["五岳令旗"] and Bag["广陵散"] and Bag["溪山行旅图"] and Bag["率意帖"] then
	   return go(xxdfGiveSan,"梅庄","琴室")
	end
end
function xxdfGo()
    return go(xxdfQiao,"梅庄","庄院大门")
end
function xxdfQiao()
    create_trigger_f('xxdf',"^(> )*过了半晌，大门缓缓打开，并肩走出两个家人装束的老者",'','xxdfHuida')
	wait.make(function()
         exe('qiao gate 4 times')
		 wait.time(3)
	     exe('qiao gate 2 times')
		 wait.time(3)
	     exe('qiao gate 5 times')
		 wait.time(3)
	     exe('qiao gate 3 times')
	end)
end
function xxdfHuida()
    exe('huida 求见江南四友;show wuyue lingqi')
	return check_bei(xxdfGiveSan)
end
function xxdfGiveSan()
    if locl.room~="琴室" then 
	   return go(xxdfGiveSan,"梅庄","琴室")
	end
    if not locl.id["黄钟公"] then 
	   return go(xxdfGiveSan,"梅庄","琴室")
	end
	exe("give guangling san to huangzhong gong")
	return go(xxdfGivePu,"梅庄","棋室")
end
function xxdfGivePu()
    if locl.room~="棋室" then 
	   return go(xxdfGivePu,"梅庄","棋室")
	end
    if not locl.id["黑白子"] then 
	   return go(xxdfGivePu,"梅庄","棋室")
	end
	exe("give ou xie pu to heibai zi")
	return go(xxdfGiveTie,"梅庄","书房")
end
function xxdfGiveTie()
    if locl.room~="书房" then 
	   return go(xxdfGiveTie,"梅庄","书房")
	end
    if not locl.id["秃笔翁"] then 
	   return go(xxdfGiveTie,"梅庄","书房")
	end
	exe("give shuaiyi tie to tubi weng")
	return go(xxdfGiveTu,"梅庄","画室")
end
function xxdfGiveTu()
    if locl.room~="画室" then 
	   return go(xxdfGiveTu,"梅庄","画室")
	end
    if not locl.id["丹青生"] then 
	   return go(xxdfGiveTu,"梅庄","画室")
	end
	exe("give xinglv tu to tubi weng")
	exe("ask danqing sheng about 秘密")
	return go(xxdfWipe,"梅庄","酒室")
end
function xxdfWipe()
    if locl.room~="酒室" then 
	   return go(xxdfWipe,"梅庄","酒室")
	end
	return wipe("ding jian",xxdfZuan)
end
function xxdfZuan()
    exe('zuan table;n;n;pull floor;d;n;n;s;kai men;n')
	locate()
	return check_bei(xxdfRwx)
end
function xxdfRwx()
    if locl.id["任我行"] then
	   disAll()
	   exe("pray pearl")
	   exe("ask ren woxing about 比剑")
	   return checkWait(xxdfMove,3)
	end
end
function xxdfMove()
    exe("move man")
	locate()
	checkBags()
	return check_busy(xxdfDushu)
end
function xxdfDushu()
    if Bag["吸星大法拓本"] then
       messageShow("吸星大法解密成功，读完秘籍后请执行push door！")	
	   return dushu("miji")
	else 
	   messageShow("吸星大法解密失败，请主动QUIT一次！")
	end
end

function yanxiwall()
    if hp.neili > 1000 then
	   exe('#20(yanxi east wall);yun jing;yun jingli;hp')
	   return checkWait(yanxiwall,0.3)
	end
	return prepare_neili(yanxiwall)
end

function jinshe()
    if not Bag["火折"] then
	   return jinsheFire()
	end
	if not Bag["铁锄"] then
	   return jinsheStaff()
	end
	if not Bag["小树枝"] then
	   return jinsheTree()
	end
	return jinsheGo()
end
function jinsheFire()
    return go(jinsheFireBuy,"襄阳城","杂货铺")
end
function jinsheFireBuy()
    exe('buy fire')
	checkBags()
	return check_busy(jinshe)
end
function jinsheStaff()
    return go(jinsheStaffAsk,"苏州城","打铁铺")
end
function jinsheStaffAsk()
    exe('ask tie jiang about 铁锄')
	checkBags()
	return check_busy(jinshe)
end
function jinsheTree()
    return go(jinsheTreeGet,"苏州城","灵岩山")
end
function jinsheTreeGet()
    exe('get xiao shuzhi')
	checkBags()
	return check_busy(jinshe)
end
function jinsheGo()
    return go(jinsheClimb,"华山","猢狲愁")
end
function jinsheClimb()
    DeleteTriggerGroup("jsjf")
	create_trigger_t('jsjf1',"^(> )*树藤已经被(\\D*)折光了。$",'','jinsheFail')
	create_trigger_t('jsjf2',"^(> )*你想就这样跳下去",'','jinsheFail')
	create_trigger_t('jsjf3',"^(> )*你坐在藤篮里面，战战兢兢消失在洞口。$",'','jinsheBa')
	SetTriggerOption("jsjf1","group","jsjf")
    SetTriggerOption("jsjf2","group","jsjf")
	SetTriggerOption("jsjf3","group","jsjf")
	for p in pairs(Bag) do
	       if Bag[p].kind then
		      for i = 1,Bag[p].cnt do
			      exe('drop '..Bag[p].fullid)
			  end
		   end
	end
	exe('drop silver;drop gold')
    exe('l tieyuan;pa ya')
	if not Bag["藤筐"] then
	   exe('break shuteng;bian kuang')
	end
	exe('chan shu;dian fire;bo zhui;climb down')
end
function jinsheFail()
    EnableTriggerGroup("jsjf",false)
	EnableTriggerGroup("jsba",false)
	EnableTriggerGroup("jszang",false)
	EnableTriggerGroup("jsdz",false)
	exe('climb up;d;get all')
	exe('drop jinshe sword;drop corpse')
	if not tmp.time or tmp.time <= os.time() then
	   tmp.time = os.time()
	end
	if Bag["小铁匣"] then
	   exe('kai tie xia')
	   return dushu("jianfa")
	end
	if Bag["家信"] then
	   return go(jinsheZhangfa,"襄阳城","吟淼阁")
	end
	return jinsheOver()
end
function jinsheZhangfa()
    exe('give xin jian to wen yi;ask wen yi about 宝物')
	return dushu("zhangfa")
end
function jinsheBa()
    DeleteTriggerGroup("jsba")
    create_trigger_t('jsba1','^(> )*你想伸手去拔剑，可是发现剑已经没有了。$','','jinsheFail')
	create_trigger_t('jsba2','^(> )*你暂时与金蛇秘籍无缘了，有时间还是快去练功吧。$','','jinsheQuit')
	create_trigger_t('jsba3',"^(> )*你抓住剑柄，微一运力，只觉得剑柄稍微活动了一下。$",'','jinsheCon')
	create_trigger_t('jsba4',"^(> )*你紧紧握住剑柄，潜运内力，嗤的一声响，把剑拔了出来。$",'','jinsheZang')
	SetTriggerOption("jsba1","group","jsba")
    SetTriggerOption("jsba2","group","jsba")
	SetTriggerOption("jsba3","group","jsba")
	SetTriggerOption("jsba4","group","jsba")
	if skills["jinshe-jianfa"] then
	   locate()
	   return check_bei(jinsheBox)
	end
	
	exe('ba bing')
end
function jinsheBox()
    if locl.id["大铁盒"] then
	   exe('open tie he')
	   checkBags()
	   return check_busy(jinsheFail,1)
	end
	exe('ba bing') 
end
function jinsheQuit()
    EnableTriggerGroup("jsba",false)
	return check_bei(husongQuit)
end
function jinsheCon()
    EnableTriggerGroup("jsba",false)
    return check_bei(jinsheBa)
end
function jinsheZang()
    EnableTriggerGroup("jsba",false)
	DeleteTriggerGroup("jszang")
    create_trigger_t('jszang1','^(> )*这里不关你的事，你还是去努力练功吧。$','','jinsheFail')
	create_trigger_t('jszang2','^(> )*你想活埋谁？$','','jinsheFail')
	create_trigger_t('jszang3',"^(> )*(".. score.name .."|你)(你|)心下恻然，不禁想安葬这个骷髅，于是抡起锄头，",'','jinsheDeep')
	create_trigger_t('jszang4',"^(> )*你费力的挖了挖，这里似乎已经被人挖过了。$",'','jinsheFail')
	SetTriggerOption("jszang1","group","jszang")
    SetTriggerOption("jszang2","group","jszang")
	SetTriggerOption("jszang3","group","jszang")
	SetTriggerOption("jszang4","group","jszang")
	exe('zang haigu')
end
function jinsheDeep()
    EnableTriggerGroup("jszang",false)
	DeleteTriggerGroup("jsdz")
    create_trigger_t('jsdz1','^(> )*这里不关你的事，你还是去努力练功吧。$','','jinsheFail')
	create_trigger_t('jsdz2','^(> )*你要做什麽？$','','jinsheFail')
	create_trigger_t('jsdz3',"^(> )*(".. score.name .."|你)(你|)又把坑挖深了几尺，得到一个铁匣",'','jinsheSucc')
	create_trigger_t('jsdz4',"^(> )*(".. score.name .."|你)(你|)又把坑挖深了几尺，埋葬了骷髅，突然看到一个铁匣",'','jinsheSucc')
	create_trigger_t('jsdz5',"^(> )*你费力的挖了挖，显然已经被人挖过了。$",'','jinsheDeepCon')
	create_trigger_t('jsdz6',"^(> )*你把坑又挖了深许，也不知够不够。$",'','jinsheDeepCon')
	create_trigger_t('jsdz7',"^(> )*(".. score.name .."|你)(你|)又把坑深挖了几尺，没有发现任何东西",'','jinsheFail')
	SetTriggerOption("jsdz1","group","jsdz")
    SetTriggerOption("jsdz2","group","jsdz")
	SetTriggerOption("jsdz3","group","jsdz")
	SetTriggerOption("jsdz4","group","jsdz")
	SetTriggerOption("jsdz5","group","jsdz")
	SetTriggerOption("jsdz6","group","jsdz")
	SetTriggerOption("jsdz7","group","jsdz")
	return check_bei(jinsheDeepZang)
end
function jinsheDeepZang()
    if skills["jinshe-jianfa"] then
	   exe('open tie he')
	   checkBags()
	   return check_busy(jinsheFail)
	end
    EnableTriggerGroup("jsdz",true)
	exe('yun jingli;shenzang haigu')
end
function jinsheDeepCon()
    EnableTriggerGroup("jsdz",false)
    return check_bei(jinsheDeepZang)
end
function jinsheSucc()
    tmp.time = 999999999999
	locate()
    return check_busy(jinsheFail)
end
function jinsheOver()
    if tmp.time then
       SetVariable("timejsjf",tmp.time)
	end
	return check_heal()
end

function tzRonghe()
    if tmp.ghost then
	   return go(tzrhSg,"铁掌山","无名峰")
	end
    return go(tzrhQqz,"铁掌山","瓜架")
end
function tzrhQqz()
    if locl.room ~= "瓜架" and locl.room ~= "蝴蝶泉" and locl.room ~= "广场" then
	   return tzRonghe()
	end
    if locl.id["裘千丈"] then
	   tmp.ghost = true
	   exe('ask qiu qianzhang about 闹鬼')
	   return go(tzrhSg,"铁掌山","无名峰")
	else
	   if locl.room == "瓜架" then
	      if math.random(1,3) > 1 then
	         exe('se')
		  else
		     exe('w')
		  end
	   end
	   if locl.room == "蝴蝶泉" then
	      exe('nw')
	   end
	   if locl.room == "广场" then
	      exe('e')
	   end
	   return checkWait(tzrhQm,2)
	end
end
function tzrhQm()
    locate()
    return check_busy(tzrhQqz)
end
function tzrhSg()
    exe('move bei;enter;ed;nd;wd')
	locate()
	return checkNext(tzrhSgCheck,1)
end
function tzrhSgCheck()
    if locl.room ~= "石室" or not locl.id["上官剑南"] then
	   return tzRonghe()
	end
	exe('ask shangguan about 宝物')
	return go(tzrhTui,"tiezhang/taijie-2")
end
function tzrhTui()
    DeleteTriggerGroup("tzrh")
	create_trigger_t('tzrh1',"^(> )*\\D*太勤快",'','tzrhFlag')
	create_trigger_t('tzrh2','^(> )*\\D*看到兵器架上的武器','','tzrhFlag')
	SetTriggerOption("tzrh1","group","tzrh")
    SetTriggerOption("tzrh2","group","tzrh")
	--你沉思许久，不得要领。
	--你来的太勤快了！
    exe('tui gate')
	wait.make(function() 
       wait.time(4)
	   if not tmp.ronghe then
	      return tzRonghe()
	   end
	end)
end
function tzrhFlag()
    tmp.ronghe = true
end

function questSucLog(p_quest)
    local file = io.open(GetInfo(59) .. "/log/解密一览.txt", "a")
	file:write(os.date()..','..score.id ..",解密==="..","..p_quest..",成功★")
	file:write("\n")
    file:close()
end
function questStartLog(p_quest)
    local logfile = GetInfo(59) .. "/log/解密"..p_quest.."-"..score.id .."-"..os.time() .. ".txt"
	OpenLog (logfile , false)
end

function questSet()
    local t = {}
	questList = questList or {}
	for p,q in pairs(questList) do
        if type(q) == 'function' then
	        if q() then t['auto'..p] = q() end
        else	   
            t['auto'..p] = q
	    end
    end
	
	if countTab(t) == 0 then return end
	
	local qlst = {}
	
	local varlist = GetVariableList()
	if varlist then
	    for p,q in pairs(varlist) do
	        if t[p] then
		        qlst[p] = q
		    end
	    end
	end
	
	local l_tmp=utils.multilistbox ("你准备要自动去解的QUEST有(请按CTRL多选)?", "QUEST选择", t,qlst)
	l_tmp = l_tmp or {}
	for p in pairs(l_tmp) do
	    if not GetVariable(p) then 
		    SetVariable(p,1)
		end
	end
	for p in pairs(qlst) do
	    if not l_tmp[p] then
		    DeleteVariable(p)
		end
	end 
	
end

function questGetVar()
    local varlist = GetVariableList()
	if varlist then
	    for p,q in pairs(varlist) do
	        if string.find(p,'auto') then
			    local qst = string.sub(p,5,-1)
			    if quests[qst] then
				   quests[qst].auto = tonumber(q)
			    end
			end
			if string.find(p,'time') then
			    local qst = string.sub(p,5,-1)
			    if quests[qst] then
				   quests[qst].time = tonumber(q)
			    end
			end
	    end
	end
end








