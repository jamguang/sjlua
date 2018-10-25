
sjParty = {}

sjParty["list"] = {
    ["普通百姓"] = "baixing",
    ["白驼山庄"] = "baituo",
    ["大轮寺"]   = "xueshan",
    ["峨嵋派"]   = "emei",
    ["姑苏慕容"] = "murong",
    ["古墓派"]   = "gumu",
    ["华山派"]   = "huashan",
    ["昆仑派"]   = "kunlun",
    ["灵鹫宫"]   = "lingjiu",
    ["明教"]     = "mingjiao",
    ["全真教"]   = "quanzhen",
    ["日月神教"] = "riyue",
    ["少林派"]   = "shaolin",
    ["神龙教"]   = "shenlong",
    ["桃花岛"]   = "taohua",
	["天龙寺"]   = "tianlong",
	["铁掌帮"]   = "tiezhang",
	["武当派"]   = "wudang",
	["星宿派"]   = "xingxiu",
	["血刀门"]   = "xuedao",
	["丐帮"]     = "gaibang",
	["嵩山派"]   = "songshan",
	["逍遥派"]   = "xiaoyao",
    }

sjParty["sleep"] = {
    ["神龙教"]   = "神龙岛卧室",
    ["全真教"]   = "quanzhen/xiuxishi",
	["少林派"]   = function() if string.find(score.title,"俗家") then return "shaolin/sengshe3" else return "shaolin/sengshe3" end end,
	["桃花岛"]   = "归云庄客房",
	["武当派"]   = function() if score.gender == "女" then return "武当山女休息室" else return "武当山男休息室" end end,
	["嵩山派"]   = function() if score.gender == "女" then return "songshan/nv-room" else return "songshan/nan-room" end end,
	["天龙寺"]   = "大理王府卧室",
	["姑苏慕容"] = "mr/xiangfang",
}

function sjGetSleepRoom()
    if sjParty["sleep"] and score.party and sjParty["sleep"][score.party] then
	    local lsleep
	    local lroom = sjParty["sleep"][score.party]
		if type(lroom) == "function" then
		    lsleep = lroom()
		else
		    lsleep = lroom
		end
		return locateroom(lsleep)
	end
    return false
end

function sjParty:new(party)
	local party = party or {}
	setmetatable(party,self)
	self.__index = self
	return party
end

function partyPrepare()
    local sparty = score.party
    if score.party=="普通百姓" and hp.exp<10000 and GetVariable("party") and sjParty[GetVariable("party")] then
	    sparty = GetVariable("party")
	end
    if sjParty[sparty] then
	    local partycond = sjParty[sparty]
        for _,p in ipairs(partycond) do
		    if p["cond"] and p["cond"]() then
			    if p["jobzuhe"] then
				    if p["jobzuhe"]() then
					    SetVariable("jobzuhe",p["jobzuhe"]())
					else
				        SetVariable("jobzuhe",p["jobzuhe"])
					end
				end
				if p["jobfirst"] then
				    if p["jobfirst"]() then
					    SetVariable("jobfirst",p["jobfirst"]())
					else
				        SetVariable("jobfirst",p["jobfirst"])
					end
				else
				    DeleteVariable("jobfirst")
				end
				if p["jobsecond"] then
				    if p["jobsecond"]() then
					    SetVariable("jobsecond",p["jobsecond"]())
					else
				        SetVariable("jobsecond",p["jobsecond"])
					end
				else
				    DeleteVariable("jobsecond")
				end
				jobGetVar()
				if p["xuexilist"] then
				    local lset = utils.split(p["xuexilist"],"|")
					for _,q in pairs(lset) do
					    xuexiList = xuexiList or {}
						xuexiList[q] = true
					end
					for sk in pairs(skills) do
					    if not xuexiList[sk] and (weaponKind[sk] or unarmedKind[sk]) and skills[sk].lvl<80 then
						    exe("fangqi "..sk..";y")
						end
					end
				end
				if p["performforce"] and skills[p["performforce"]] then
				    perform.force = p["performforce"]
	 	            SetVariable("performforce",p["performforce"]) 
					if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl<10 then
					    exe("fangqi shenzhao-jing;y")
					end
				end
				if p["performpre"] then
				    if p["performpre"]() then
					    perform.pre = p["performpre"]()
					else
				        perform.pre = p["performpre"]
					end
	 	            SetVariable("performpre",perform.pre)
				end
				if p["performskill"] then
				    perform.skill = p["performskill"]
	 	            SetVariable("performskill",p["performskill"])
				end
				if p["performgift"] then
				    local p_set = {}
				    local l_set = utils.split(p["performgift"],"|")
					for _,q in pairs(l_set) do
					    local q_set = utils.split(q,":")
						if score[q_set[1]] and not isNil(q_set[2]) then
						    p_set[q_set[1]] = tonumber(q_set[2])
						end
					end
					changeGift(p_set)
				end
				if p["prepare"] and p["prepare"]() then
				    return p["prepare"]()
				end
			end
        end		
	end
    return false
end

sjParty["全真教"] = {
    [1] = {["cond"] = function() if score.master and score.master=="普通百姓" then return true else return false end end,
           ["jobzuhe"] = "caiyao_clb",
           ["prepare"] = function() return quanzhenPrea() end,		   
	      },
	[2] = {["cond"] = function() if hp.exp<200000 then return true else return false end end,
	       ["jobzuhe"] = "caiyao_clb",
		   ["performforce"] = "xiantian-gong",
		   ["performskill"] = "yuanyang-lianhuantui",
		   ["performgift"] = "dex:25|int:32|str:13|con:10",
		   ["performpre"] = "bei none;enable dodge jinyan-gong;enable leg yuanyang-lianhuantui;enable parry yuanyang-lianhuantui;bei leg;jiali max;perform leg.yuanyang;jiali 1",
		   ["xuexilist"] = "force|xiantian-gong|dodge|jinyan-gong|leg|parry|yuanyang-lianhuantui",
		   ["prepare"] = function() return quanzhenPreb() end,
	      },
	[3] = {["cond"] = function() if not skills["haotian-zhang"] or skills["haotian-zhang"].lvl<250 then return true else return false end end,
	       ["jobzuhe"] = "shouwei_huashan_clb",
		   ["jobfirst"] = "shouwei",
		   ["jobsecond"] = "huashan",
		   ["performforce"] = "xiantian-gong",
		   ["performskill"] = "yuanyang-lianhuantui",
		   ["performpre"] = "bei none;enable dodge jinyan-gong;enable leg yuanyang-lianhuantui;enable parry yuanyang-lianhuantui;bei leg;jiali max;perform leg.yuanyang;jiali 1",
		   ["xuexilist"] = "force|xiantian-gong|dodge|jinyan-gong|leg|parry|yuanyang-lianhuantui|strike|haotian-zhang",
		   ["prepare"] = function() return quanzhenPrec() end,
	      },
	[4] = {["cond"] = function() if score.master and score.master~="丘处机" then return true else return false end end,
	       ["jobzuhe"] = "shouwei_huashan_clb",
		   ["jobfirst"] = "shouwei",
		   ["jobsecond"] = "huashan",
		   ["performforce"] = "xiantian-gong",
		   ["performskill"] = "yuanyang-lianhuantui",
		   ["performpre"] = "bei none;enable dodge jinyan-gong;enable leg yuanyang-lianhuantui;enable parry yuanyang-lianhuantui;bei leg;jiali max;perform leg.yuanyang;jiali 1",
		   ["xuexilist"] = "force|xiantian-gong|dodge|jinyan-gong|leg|parry|yuanyang-lianhuantui|strike|haotian-zhang",
		   ["prepare"] = function() return quanzhenPrec() end,
	      },
	[5] = {["cond"] = function() if score.master and score.master=="丘处机" then return true else return false end end,
		   ["jobzuhe"] = function() return quanzhenJobzuhe() end,
		   ["jobfirst"] = function() return quanzhenJobf() end,
		   ["jobsecond"] = function() return quanzhenJobs() end,
		   ["performforce"] = "xiantian-gong",
		   ["performskill"] = "yuanyang-lianhuantui",
		   ["performpre"] = function() return quanzhenPerform() end,
		   ["xuexilist"] = "force|xiantian-gong|dodge|jinyan-gong|leg|parry|yuanyang-lianhuantui|strike|haotian-zhang|sword|quanzhen-jianfa",
		   ["prepare"] = function() return quanzhenPred() end,
	      },
    }	
	
function quanzhenJobzuhe()
    local zuhe
    if GetVariable("autojuding") and GetVariable("autojuding")=="2" then
	    zuhe = "shouwei_songxin2_huashan"
	else
	    zuhe = "shouwei_huashan_clb"
	end
	if skills["kongming-quan"] and skills["kongming-quan"].lvl > 499 then
	    zuhe = "qzjx_songxin2_huashan"
	end
	return zuhe
end
function quanzhenJobf()
    local fjob = "shouwei"
	if skills["kongming-quan"] and skills["kongming-quan"].lvl > 499 then
	    fjob = "qzjx"
	end
	return fjob
end
function quanzhenJobs()
    local sjob
	if GetVariable("autojuding") and GetVariable("autojuding")=="2" then
	    sjob = "songxin2"
	else
	    sjob = "huashan"
	end
	if skills["kongming-quan"] and skills["kongming-quan"].lvl > 499 then
	    sjob = "songxin2"
	end
	if hp.shen and hp.shen < 2000000 then
        sjob = "huashan"
	end	
	return sjob
end
function quanzhenPerform()
    if not GetVariable("autojuding") or GetVariable("autojuding") ~= "2" then
	    return "bei none;enable dodge jinyan-gong;enable leg yuanyang-lianhuantui;enable parry yuanyang-lianhuantui;bei leg;jiali max;perform leg.tiejiao;perform leg.yuanyang;jiali 1"
	end
	local l_perform = "yun daojue;jiali max;bei none;enable dodge jinyan-gong;enable cuff kongming-quan;enable leg yuanyang-lianhuantui;enable strike haotian-zhang;"
	
	if GetVariable("autotiejiao") and GetVariable("autotiejiao")=="2" then
	    if not skills["kongming-quan"] then 
		    l_perform = l_perform .. "enable parry yuanyang-lianhuantui;"
		end
		l_perform = l_perform .. "bei leg;perform leg.tiejiao;"
	end
	if GetVariable("autojuding") and GetVariable("autojuding")=="2" then
	    l_perform = l_perform .. "enable parry haotian-zhang;bei none;bei strike;perform strike.juding;"
	end
	
	if skills["kongming-quan"] then
	    l_perform = l_perform .. "enable parry kongming-quan;perform cuff.ming;"
	else
	    l_perform = l_perform .. "enable parry yuanyang-lianhuantui;"
	end
	
	if skills["kongming-quan"] and skills["kongming-quan"].lvl > 499 then
	    l_perform = l_perform .. "bei none;bei cuff;perform cuff.shuangjue;jiali 1"
	else
	    l_perform = l_perform .. "bei none;bei leg;perform leg.lianhuan;jiali 1"
		--l_perform = l_perform .. "bei none;bei leg;perform leg.yuanyang;jiali 1"
	end
	return l_perform
end	

function quanzhenPrea()
    if score.party == "普通百姓" and hp.exp<10000 and hp.shen>=0 then
	    return "quanzhenRumen"
	end
end

function quanzhenRumen()
    return go(quanzhenRuBai,"全真","大堂一进") 
end
function quanzhenRuBai()
    if locl.room ~= "大堂一进" then
	    return quanzhenRumen()
    end	
	if not locl.id["鹿清笃"] then
	    return quanzhenRumen()
	end
	DeleteTriggerGroup("rumenask")
    create_trigger_t('rumenask1',"^(> )*你向鹿清笃打听有关『入教",'','quanzhenRuAnswer')
    create_trigger_t('rumenask2',"^(> )*这里没有这个人。$",'','quanzhenRuNo')
    SetTriggerOption("rumenask1","group","rumenask")    
	SetTriggerOption("rumenask2","group","rumenask")
    return exe('ask lu qingdu about 入教')
end
function quanzhenRuAnswer()
    EnableTriggerGroup("rumenask",false)
	DeleteTriggerGroup("rumen")
    create_trigger_t('rumen1',"^(> )*鹿清笃(对你|)说道：(|「)无缘无故，非奸即盗",'','quanzhenRumen')
	create_trigger_t('rumen2',"^(> )*你瞎答应什么？",'','quanzhenRumen')
    create_trigger_t('rumen3',"^(> )*你满脸堆笑，对鹿清笃连声答应，说道",'','quanzhenRumen')
	create_trigger_t('rumen4',"^(> )*鹿清笃(对你|)说道：(|「)好好干,跟我混有你的光明前途！",'','quanzhenRuSucc')
    SetTriggerOption("rumen1","group","rumen")    
	SetTriggerOption("rumen2","group","rumen")
	SetTriggerOption("rumen3","group","rumen")
	SetTriggerOption("rumen4","group","rumen")
	exe("answer 愿意")
end
function quanzhenRuSucc()
    EnableTriggerGroup("rumenask",false)
	EnableTriggerGroup("rumen",false)
	DeleteTriggerGroup("rumenask")
	DeleteTriggerGroup("rumen")
	return check_heal()
end

function quanzhenPreb()
    if hp.exp>100000 and hp.pot_save>1000 and (not skills["force"] or skills["force"].lvl<100 or not skills["xiantian-gong"] or skills["xiantian-gong"].lvl<100) then
	    return "xuexi"
	end
	if hp.exp>100000 and hp.neili_lim>1000 and hp.neili_max<1000 then
	    return "fullNeili"
	end
	if hp.exp>100000 and hp.jingli_lim>800 and hp.jingli_max<800 then
	    return "fulljingli"
	end
	if hp.exp>100000 and (not skills["dodge"] or skills["dodge"].lvl < 100) then
	    return "qzfulldodge"
	end
	if hp.exp>100000 and (not skills["leg"] or skills["leg"].lvl < 100) then
	    return "qzfullleg"
	end
	if hp.exp>1000000 and ((not skills["cuff"] and skills["kongming-quan"]) or (skills["cuff"] and skills["cuff"].lvl < 100)) then
	    return "qzfullcuff"
	end
	if hp.exp>100000 and skills["parry"] and skills["parry"].lvl>29 and skills["parry"].lvl < 100 then
	    return "fullparry"
	end
	if hp.exp>100000 and hp.pot_save>1000 and (not skills["yuanyang-lianhuantui"] or skills["yuanyang-lianhuantui"].lvl<100 or not skills["jinyan-gong"]) then
	    return "xuexi"
	end
	return false
end
function qzfulldodge()
    exe('hp')
    return go(qzfulldodgeCheck,"quanzhen/wuchang")
end
function qzfulldodgeCheck()
    flag.idle = 0
	if skills["dodge"] and skills["dodge"].lvl >= 100 then
	   return check_heal()
	end
    if hp.jingli < 130 then
	   return qzfulldodgeRest()
	end
	return qzfulldodgeTiao()
end
function qzfulldodgeTiao()
    exe('#3(tiao zhuang)')
	exe('yun jingli;hp;cha')
	return checkWait(qzfulldodgeCheck,1)
end
function qzfulldodgeRest()
    return go(qzfulldodgeSleep,"quanzhen/xiuxishi")
end
function qzfulldodgeSleep()
    exe('sleep')
	return check_bei(qzfulldodge)
end

function qzfullleg()
    exe('hp')
    return go(qzfulllegCheck,"quanzhen/wuchang1")
end
function qzfulllegCheck()
    flag.idle = 0
	if skills["leg"] and skills["leg"].lvl >= 100 then
	   return check_heal()
	end
    if hp.jingli < 130 then
	   return qzfulllegRest()
	end
	return qzfulllegTi()
end
function qzfulllegTi()
    exe('#3(ti shadai)')
	exe('yun jingli;hp;cha')
	return checkWait(qzfulllegCheck,1)
end
function qzfulllegRest()
    return go(qzfulllegSleep,"quanzhen/xiuxishi")
end
function qzfulllegSleep()
    exe('sleep')
	return check_bei(qzfullleg)
end

function qzfullcuff()
    exe('hp')
    return go(qzfullcuffCheck,"quanzhen/liangongfang")
end
function qzfullcuffCheck()
    flag.idle = 0
	if skills["cuff"] and skills["cuff"].lvl >= 100 then
	   return check_heal()
	end
    if hp.jingli < 130 then
	   return qzfullcuffRest()
	end
	return qzfullcuffDa()
end
function qzfullcuffDa()
    exe('#3(da bag)')
	exe('yun jingli;hp;cha')
	return checkWait(qzfullcuffCheck,1)
end
function qzfullcuffRest()
    return go(qzfullcuffSleep,"quanzhen/xiuxishi")
end
function qzfullcuffSleep()
    exe('sleep')
	return check_bei(qzfullcuff)
end

function quanzhenPrec()
    if not skills["medicine"] or skills["medicine"].lvl<30 then
	    return "learnMeda"
	end
    if not GetVariable("luohanwinner") or GetVariable("luohanwinner")=="no" then
	    return "luohanWinner"
	end
	if hp.pot_save and hp.pot_save>20000 and score.master and score.master=="李志常" and (not skills["haotian-zhang"] or skills["haotian-zhang"].lvl<220) then
	    return "xuexi"
	end
	if hp.exp>1000000 and ((not skills["cuff"] and skills["kongming-quan"]) or (skills["cuff"] and skills["cuff"].lvl < 100)) then
	    return "qzfullcuff"
	end
	if hp.shen>1200000 and not skills["haotian-zhang"] and score.master and score.master~="李志常" then
	    return "baishiLizhichang"
	end
	if skills["xiantian-gong"] and skills["xiantian-gong"].lvl>350 and score.master and score.master~="丘处机" then
	    return "baishiQiuchuji"
	end
	if hp.exp>2000000 and score.age>25 and not string.find(GetVariable("drugprepare"),"幸运珍珠") then
	    return "varAddPearl"
	end
	return false
end

function quanzhenPred()
    if not skills["medicine"] or skills["medicine"].lvl<30 then
	    return "learnMeda"
	end
	if not skills["taoism"] or skills["taoism"].lvl<100 then
	    return "learnTaoa"
	end
	if hp.exp>1000000 and ((not skills["cuff"] and skills["kongming-quan"]) or (skills["cuff"] and skills["cuff"].lvl < 100)) then
	    return "qzfullcuff"
	end
	if hp.exp>1000000 and score.int_t and score.int_t>45 and (not skills["jinguan-yusuojue"] or skills["jinguan-yusuojue"].lvl<100) then
	    return "learnYusuo"
	end 
	if hp.exp>1000000 and score.int_t and score.int_t>45 and (skills["jinguan-yusuojue"] and skills["jinguan-yusuojue"].lvl>99 and skills["jinguan-yusuojue"].lvl<200) then
	    return "learnYSuo"
	end
	if hp.pot_save and hp.pot_save>20000 and score.master and score.master=="丘处机" and (not skills["quanzhen-jianfa"] or skills["quanzhen-jianfa"].lvl<220 or not skills["sword"] or skills["sword"].lvl<220) then
	    return "xuexi"
	end
	if hp.exp>2000000 and score.age>25 and not string.find(GetVariable("drugprepare"),"幸运珍珠") then
	    return "varAddPearl"
	end
	return false
end

function luohanWinner()
    for p in pairs(skills) do
	    if p~="medicine" and skills[p].lvl<80 then
		    exe("fangqi "..p..";y")
		end
	end
    if Bag["黄金"].cnt<1 then
	    return check_gold()
	end
	fight_prepare()
	return searchNpc("扬州城","托钵僧","luohanSeng")
end
function luohanSeng()
    exe("give 1 gold to tuobo seng")
	checkBags()
	return checkWait(luohanLing,2)
end
function luohanLing()
    if not Bag["少林英雄令"] then
	    return luohanSeng()
	end
	return go(luohanXuanku,"嵩山少林","罗汉堂")
end
function luohanXuanku()
    if locl.room ~= "罗汉堂" then
	    return go(luohanXuanku,"嵩山少林","罗汉堂")
	end
	if not locl.id["玄苦大师"] then
	    return go(luohanXuanku,"嵩山少林","罗汉堂")
	end
	exe("ask xuanku dashi about 罗汉大阵")
	return go(luohanXuannan,"嵩山少林","般若堂")
end
function luohanXuannan()
    if locl.room ~= "般若堂" then
	    return go(luohanXuannan,"嵩山少林","般若堂")
	end
	if not locl.id["玄难大师"] then
	    return go(luohanXuannan,"嵩山少林","般若堂")
	end
	exe("ask xuannan dashi about 罗汉大阵")
	return go(luohanFight,"shaolin/hguangz2")
end
function luohanFight()
    if locl.room ~= "后殿广场" then
	    return go(luohanFight,"shaolin/hguangz2")
	end
	fight_prepare()
	create_timer_s('luohan',1,'luohanYun')
	create_triggerex('luohan',"^(> )*玄苦大师挥了挥手， 罗汉堂长老们随即鱼贯离开练武场",'','luohanOver')
end
function luohanYun()
    exe("yun qi;yun jing")
end
function luohanOver()
    SetVariable("luohanwinner","yes")
	return check_heal()
end

function learnTaoa()
    if not Bag["道德经「上卷」"] then
	    return go(learnTaoaAsk,"全真","存道塔顶")
	end
	return dushu("jing")
end
function learnTaoaAsk()
    if locl.room ~= "存道塔顶" then
	    return go(learnTaoaAsk,"全真","存道塔顶")
	end
    if not locl.id["掌经道长"] then
	    return check_job()
	end
	exe("ask zhangjing daozhang about 道德经")
	checkBags()
	return checkWait(learnTaoa,3)
end

function learnYusuo()
    if not Bag["金关玉锁二十四诀【上册】"] then
	    return go(learnYusuoBook,"全真","存道塔顶")
	end
	return dushu("book")
end
function learnYusuoBook()
    if locl.room ~= "存道塔顶" then
	    return go(learnYusuoBook,"全真","存道塔顶")
	end
	exe("search 金关玉锁二十四诀")
	checkBags()
	return checkWait(learnYusuo,3)
end
--金关玉锁二十四诀【下册】
function learnYSuo()
    if not Bag["金关玉锁二十四诀【下册】"] then
	    return go(learnYSuoAsk,"全真","大堂二进")
	end
	return dushu("book")
end
function learnYSuoAsk()
    if not locl.id["掌理道长"] then
	    return go(learnYSuoAsk,"全真","大堂二进")
	end
	if Bag["龟苓膏"] then 
	    return learnYSuoBook()
	end
	exe("askk zhangli daozhang about 身体安康")
	wait.make(function() 
        wait.time(3)
		exe("askk zhangli daozhang about 金关玉锁诀秘籍")
	    checkBags()
	    return check_bei(learnYSuoBag,1)
	end)
end
function learnYSuoGui()
    if not locl.id["商人"] then
	    return go(learnYSuoGui,"终南山","集市")
	end
	exe("buy gui jia")
	checkBags()
	return check_bei(learnYSuoBag,1)
end
function learnYSuoBag()
    if not Bag["茯苓"] then
	    tmp.fuling = true
		return caiyao()
	end
	if not Bag["乌龟甲"] then
	    return go(learnYSuoGui,"终南山","集市")
	end
	return go(learnYSuoYao,"全真","药剂室")
end
function learnYSuoYao()
    if not locl.id["掌药道长"] then
	    return go(learnYSuoYao,"全真","药剂室")
	end
	exe("give gui jia to zhangyao daozhang;give fu ling to zhangyao daozhang")
	checkBags()
	return check_bei(learnYSuoGao,1)
end
function learnYSuoGao()
    if not Bag["龟苓膏"] then 
	    return learnYSuoBag()
	end
	return go(learnYSuoBook,"全真","大堂二进")
end
function learnYSuoBook()
    if not locl.id["掌理道长"] then
	    return go(learnYSuoBook,"全真","大堂二进")
	end
	exe("give guiling gao to zhangli daozhang")
	exe("askk zhangli daozhang about 金关玉锁诀秘籍")
	--wait.make(function() 
    --   wait.time(3)
	--   exe("askk zhangli daozhang about 道德经")
	--end)
	checkBags()
	return check_bei(learnYSuo,1)
end

function baishiLizhichang()
    return baishi("李志常")
end
function baishiYinzhiping()
    return baishi("尹志平")
end
function baishiQiuchuji()
    return baishi("丘处机")
end

function baishi(p_master)
    --if not p_master then return check_heal() end
	local masterroom = locateroom(p_master)
	if not masterroom then return check_heal() end
	tmp.master = p_master
	return go(baishiBai,masterroom)
end
function baishiBai()
    if not locl.id[tmp.master] then return check_heal() end
	exe("bai ".. locl.id[tmp.master])
	return check_heal()
end

function busyFunc()
    if hp.exp>100000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and (not skills["medicine"] or skills["medicine"].lvl<30) and Bag["黄金"].cnt>1 then
        tmp.busy = true
	    return "learnMeda"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and not MidNight[locl.time] and skills["medicine"] and skills["medicine"].lvl>29 and skills["medicine"].lvl<40 and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnMedb"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and not MidNight[locl.time] and skills["medicine"] and skills["medicine"].lvl>39 and skills["medicine"].lvl<50 and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnMedc"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and not MidNight[locl.time] and skills["medicine"] and skills["medicine"].lvl>49 and skills["medicine"].lvl<62 and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnMedd"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and not MidNight[locl.time] and skills["medicine"] and skills["medicine"].lvl>61 and skills["medicine"].lvl<72 and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnMede"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and not MidNight[locl.time] and skills["medicine"] and skills["medicine"].lvl>71 and skills["medicine"].lvl<82 and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnMedf"
	end
    if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and score.int_t and score.int_t>25 and (not skills["jingmai-xue"] or skills["jingmai-xue"].lvl<40) and Bag["黄金"].cnt>1 then
        tmp.busy = true
    	return "learnJmxa"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and score.int_t and score.int_t>25 and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>39 and skills["jingmai-xue"].lvl<80 and Bag["黄金"].cnt>2 then
        tmp.busy = true
    	return "learnJmxb"
	end
	if hp.exp>1000000 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and score.int_t and score.int_t>25 and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>79 and skills["jingmai-xue"].lvl<120 and Bag["黄金"].cnt>15 then
        tmp.busy = true
    	return "learnJmxc"
	end
	if condition["任务繁忙状态"] and condition["任务繁忙状态"]>20 and Bag["高级经脉学"] and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>119 then
	    return "learnJmxSell"
	end
	if hp.pot>100 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and skills["lengquan-shengong"] and skills["lengquan-shengong"].lvl<hp.pot_max-100 and skills["lengquan-shengong"].lvl<200 then
	    tmp.busy = true
	    return "learnLengquan"
	end
	if hp.pot>100 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>40 and quests["lcj"] and quests["lcj"].szj and skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl<hp.pot_max-100 and skills["shenzhao-jing"].lvl<300 then
	    tmp.busy = true
	    return "learnSzj"
	end
	if hp.exp>1000000 and flag.autoxuexi and flag.autoxuexi==1 and condition["任务繁忙状态"] and condition["任务繁忙状态"]>60 then
	    lingwuFlag()
		if flag.lingwu==1 then
		    tmp.busy = true
	        return "lingwu"
		end
	end
	if hp.exp>1000000 and skills["qimen-bagua"] and skills["qimen-bagua"].lvl > 50 and skills["qimen-bagua"].lvl < 150 then
        return "dushibei"
	end
	if hp.exp>2000000 and hp.neili_max < hp.neili_lim - 1000 then
	    tmp.busy = true
	    return "fullNeili"
	end
    return false
end

function learnMeda()
    if not Bag["肘後备急方"] then
	    return go(learnMedaBuy,"扬州城","药铺")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMedaBuy()
    if locl.room~= "药铺" then
	    return go(learnMedaBuy,"扬州城","药铺")
	end
	exe("buy ji fang")
	checkBags()
	return check_bei(learnMeda,1)
end
function learnMedb()
    if Bag["肘後备急方"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if not Bag["寓意草"] then
	    return go(learnMedbBuy,"伊犁城","商铺")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMedbBuy()
    if locl.room~= "商铺" then
	    return go(learnMedbBuy,"伊犁城","商铺")
	end
	if not locl.id["买卖提"] then
	    return check_heal()
	end
	exe("buy yuyi cao")
	checkBags()
	return check_bei(learnMedb,1)
end
function learnMedc()
    if Bag["肘後备急方"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["寓意草"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if not Bag["三冈识略"] then
	    return go(learnMedcBuy,"明教","药房")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMedcBuy()
    if locl.room~= "药房" then
	    return go(learnMedcBuy,"明教","药房")
	end
	if not locl.id["药师"] then
	    return check_heal()
	end
	exe("buy sangang shilue")
	checkBags()
	return check_bei(learnMedc,1)
end
function learnMedd()
    if Bag["肘後备急方"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["寓意草"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["三冈识略"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if not Bag["科金镜赋集解"] then
	    return go(learnMeddAsk,"扬州城","药铺")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMeddAsk()
    if locl.room~= "药铺" then
	    return go(learnMeddAsk,"扬州城","药铺")
	end
	if not locl.id["药铺老板"] then
	    return check_heal()
	end
	exe("ask yaopu laoban about 医书")
	return go(learnMeddBuy,"扬州城","小吃店")
end
function learnMeddBuy()
    if locl.room~= "小吃店" then
	    return go(learnMeddBuy,"扬州城","小吃店")
	end
	if not locl.id["跑堂"] then
	    return check_heal()
	end
	exe("buy kao ya")
	checkBags()
	return check_bei(learnMeddYa,1)
end
function learnMeddYa()
    if not Bag["烤鸭"] then
	    return learnMeddBuy()
	end
	--return searchNpc("扬州城","空空儿","learnMeddKong")
	return fastSearch("扬州城中央广场","空空儿","learnMeddKong")
end
function learnMeddKong()
    exe("ask kong kong about 医书")
	wait.make(function()
	   wait.time(4)
	   exe("give kao ya to kong kong")
	   checkBags()
	   return check_bei(learnMeddBook,1)
	end)
end
function learnMeddBook()
    exe("follow none")
    if Bag["科金镜赋集解"] then	    
	    return wipe("kong kong",learnMedd)
	else
	    return wipe("kong kong",check_heal)
	end
end
function learnMede()
    if Bag["肘後备急方"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["寓意草"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["三冈识略"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["科金镜赋集解"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if not Bag["痘疹定论"] then
	    return go(learnMedCaiyao,"wudang/shanlu2")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMedf()
    if Bag["肘後备急方"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["寓意草"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["三冈识略"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["科金镜赋集解"] then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if not Bag["博集稀痘方"] then
	    return go(learnMedCaiyao,"wudang/shanlu2")
	end
	--tmp.busy = true
	return dushu("medicine book")
end
function learnMedCaiyao()
    if locl.room~= "山路" then
	    return go(learnMedCaiyao,"wudang/shanlu2")
	end
	if not locl.id["采药道长"] then
	    return check_heal()
	end
	exe("ask caiyao daozhang about 药典")
	wait.make(function()
	   wait.time(4)
	   exe("ask caiyao daozhang about 只是")
	   return go(learnMedTaohua,"wudang/chating")
	end)
end
function learnMedTaohua()
    if locl.room~= "茶亭" then
	    return go(learnMedTaohua,"wudang/chating")
	end
	if not locl.id["桃花姑娘"] then
	    return check_heal()
	end
	exe("ask tao hua about rumor")
	return go(learnMedZuan,"wudang/houshan/taoyuan3")
end
function learnMedZuan()
    if locl.room~= "山顶" then
	    return go(learnMedZuan,"wudang/houshan/taoyuan3")
	end
	exe("zuan shulin")
	locate()
	return check_bei(learnMedWeng,1)
end
function learnMedWeng()
    if locl.room~= "茅屋" then
	    return check_heal()
	end
	if not locl.id["无名老翁"] then
	    return check_heal()
	end
	exe("ask lao weng about 采药道长")
	wait.make(function()
	   wait.time(4)
	   exe("ask lao weng about 搭救")
	   return go(learnMedCy,"wudang/shanlu2")
	end)
end
function learnMedCy()
    if locl.room~= "山路" then
	    return go(learnMedCy,"wudang/shanlu2")
	end
	if not locl.id["采药道长"] then
	    return check_heal()
	end
	exe("ask caiyao daozhang about 结果")
	checkBags()
	return check_bei(learnMedCyBook,1)
end
function learnMedCyBook()
    if skills["medicine"] and skills["medicine"].lvl>71 then
	    return check_bei(learnMedf,1)
	end
	if skills["medicine"] and skills["medicine"].lvl>61 then
	    return check_bei(learnMede,1)
	end
    return check_heal()
end
function learnMedSell()
    if locl.room~= "当铺" then
	    return go(learnMedSell,"扬州城","当铺")
	end
	if Bag["肘後备急方"] and skills["medicine"] and skills["medicine"].lvl>29 then
	    exe("sell ji fang")
	end
	if Bag["寓意草"] and skills["medicine"] and skills["medicine"].lvl>39 then
	    exe("sell yuyi cao")
	end
	if Bag["三冈识略"] and skills["medicine"] and skills["medicine"].lvl>49 then
	    exe("sell sangang shilue")
	end
	if Bag["科金镜赋集解"] and skills["medicine"] and skills["medicine"].lvl>59 then
	    exe("sell kejin jijie")
	end
	checkBags()
	if skills["medicine"] and skills["medicine"].lvl>29 and skills["medicine"].lvl<40 then
	    return check_bei(learnMedb,1)
	end
	if skills["medicine"] and skills["medicine"].lvl>39 and skills["medicine"].lvl<50 then
	    return check_bei(learnMedc,1)
	end
	if skills["medicine"] and skills["medicine"].lvl>49 and skills["medicine"].lvl<60 then
	    return check_bei(learnMedd,1)
	end
	return check_heal()
end

function learnJmxa()
    if not Bag["初级经脉学"] then
	    return go(learnJmxaBuy,"扬州城","药铺")
	end
	--tmp.busy = true
	return dushu("book")
end
function learnJmxaBuy()
    if locl.room~= "药铺" then
	    return go(learnJmxaBuy,"扬州城","药铺")
	end
	exe("buy jingmai book")
	checkBags()
	return check_bei(learnJmxa,1)
end
function learnJmxb()
    if Bag["初级经脉学"] then
	    return go(learnJmxSell,"扬州城","当铺")
	end
	if not Bag["进阶经脉学"] then
	    return go(learnJmxbBuy,"柳宗镇","正厅")
	end
	--tmp.busy = true
	return dushu("book")
end
function learnJmxbBuy()
    if locl.room~= "正厅" then
	    return go(learnJmxbBuy,"柳宗镇","正厅")
	end
	if not locl.id["薛慕华"] then
	    return check_heal()
	end
	exe("buy jingmai book")
	checkBags()
	return check_bei(learnJmxb,1)
end
function learnJmxc()
    if Bag["初级经脉学"] then
	    return go(learnJmxSell,"扬州城","当铺")
	end
	if Bag["进阶经脉学"] then
	    return go(learnJmxSell,"扬州城","当铺")
	end
	if not Bag["高级经脉学"] then
	    return go(learnJmxcBuy,"襄阳城","药材铺")
	end
	--tmp.busy = true
	exe("east")
	return dushu("book")
end
function learnJmxcBuy()
    if locl.room~= "药材铺" then
	    return go(learnJmxcBuy,"襄阳城","药材铺")
	end
	if not locl.id["平一指"] then
	    return check_heal()
	end
	exe("buy jingmai book")
	checkBags()
	return check_bei(learnJmxc,1)
end
function learnJmxSell()
    if locl.room~= "当铺" then
	    return go(learnJmxSell,"扬州城","当铺")
	end
	if Bag["初级经脉学"] and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>39 then
	    exe("sell jingmai book")
	end
	if Bag["进阶经脉学"] and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>79 then
	    exe("sell jingmai book")
	end
	if Bag["高级经脉学"] and skills["jingmai-xue"] and skills["jingmai-xue"].lvl>119 then
	    exe("sell jingmai book")
	end
	checkBags()
	if skills["jingmai-xue"] and skills["jingmai-xue"].lvl>39 and skills["jingmai-xue"].lvl<80 then
	    return check_bei(learnJmxb,1)
	end
	if skills["jingmai-xue"] and skills["jingmai-xue"].lvl>79 and skills["jingmai-xue"].lvl<120 then
	    return check_bei(learnJmxc,1)
	end
	return check_heal()
end


function changeGift(p_set)
	local s_set = {["int"] = 0,
	               ["str"] = 0,
                   ["con"] = 0,	
                   ["dex"] = 0,								   
	              }
	local cgf = 0
	for v,w in pairs(p_set) do
	    if s_set[v] then 
		    s_set[v] = p_set[v] - score[v]
			cgf = cgf + p_set[v] - score[v]
		end 
	end
	for v,w in pairs(s_set) do
	    if not p_set[v] then
		    if cgf > 0 and score[v] > 10 then
			    if score[v] - 10 >= cgf then
			        s_set[v] = cgf * -1
					cgf = 0
				else
				    s_set[v] = (score[v] - 10) * -1
					cgf = cgf - (score[v] - 10)
				end
			end
			if cgf < 0 and score[v] < 32 then
			    if cgf > score[v] - 32 then
				    s_set[v] = cgf * -1
					cgf = 0
				else
				    s_set[v] = (score[v] - 32) * -1
					cgf = cgf + (score[v] - 32)
				end
			end
		end
	end
	--printTab(s_set)
	local c_set = {}
	for v,w in pairs(s_set) do
	    if w > 0 then
		    for p,q in ipairs(c_set) do
			    if string.find(q,"to xxx") then
				    c_set[p] = string.gsub(q,"to xxx","to "..v)
			        w = w - 1
				end
				if w == 0 then break end
			end
			while w > 0 do
			    table.insert(c_set,"cgift 1 xxx to "..v)
				w = w - 1
				if w == 0 then break end
			end
		end
		if w < 0 then
		    for p,q in ipairs(c_set) do
			    if string.find(q,"cgift 1 xxx") then
				    c_set[p] = string.gsub(q,"cgift 1 xxx","cgift 1 "..v)
			        w = w + 1
				end
				if w == 0 then break end
			end
			while w < 0 do
			    table.insert(c_set,"cgift 1 ".. v .." to xxx")
				w = w + 1
				if w == 0 then break end
			end
		end
	end
	local p_cmd = {}
	for p,q in pairs(c_set) do
	    if not p_cmd[q] then p_cmd[q] = 0 end
		p_cmd[q] = p_cmd[q] + 1
	end
	for p,q in pairs(p_cmd) do
	    exe(string.gsub(p,"1",q))
	end
end

function learnLengquan()
    return go(learnLengquanAsk,"lanzhou/zhenting")
end
function learnLengquanAsk()
    flag.idle = 0
    if not locl.id["苗人凤"] then
	    return check_bei(learnLengquanOver)
	end
	if skills["lengquan-shengong"] and skills["lengquan-shengong"].lvl >= 200 then
	    return check_bei(learnLengquanOver)
	end
	if tmp.busy and (not condition["任务繁忙状态"] or condition["任务繁忙状态"]<=20) then
	    return check_bei(learnLengquanOver)
    end
	if hp.pot<10 then
	    return check_bei(learnLengquanOver)
	end
	if hp.neili<1000 and Bag["川贝内息丸"] then
	    exe('eat chuanbei wan')
	end
	if hp.neili<500 then
        if Bag["大还丹"] then
	        exe('eat dan')
	    else
	        return check_bei(learnLengquanOver)
	    end
	end
	exe('yun jing;askk miao about 冷泉神功;cha;hp')
	if math.random(1,5)==1 then
        locate()
		condition = {}
		exe('cond')
		checkBags()
    end
	return check_busy(learnLengquanAsk,1)
end
function learnLengquanOver()
    if hp.pot >= hp.pot_max then
	    return potSave()
	end
	return check_heal()
end

function dushibei()
    return go(dushibeiLoc,"thd/hill2","")
end
function dushibeiLoc()
    if locl.room~="山顶" then
	    return go(dushibeiLoc,"thd/hill2","")
	end
	return dushu("shibei")
end

function varAddPearl()
    return variableAdd("drugprepare","幸运珍珠")
end
function variableAdd(p_name,p_value,p_link)
    local l_name  = Trim(p_name)
	local l_value = Trim(p_value)
	if not l_name or not l_value then return end
	
	local l_link = "|"
	
	if p_link then l_link = p_link end
	
	if GetVariable(l_name) then
	    l_value = GetVariable(l_name) .. l_link .. l_value
	end
	SetVariable(l_name,l_value)
	getVariable()
	return check_heal()
end








