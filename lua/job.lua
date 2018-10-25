job={}
job.time={}
job.time.b=os.time()
job.time.e=os.time()
job.time["refresh"]=94
job.name=nil
job.prepare=test
job.target='任务目标'
job.exp=0
job.pot=0
job.guard={}
job.party='未检测'
job.zuhe={}
job.killer={}
job.list= job.list or {}
job.id = 'jobid'

require "hubiao"
require "shoumu"
require "husong"
require "wuguan"
require "jiaohua"
require "songshan"
require "quest"
require "xueshan"
require "songxin"
require "wudang"
require "huashan"
require "tdh"
require "smy"
require "clb"
require "kanshou"
require "tmonk"
require "gaibang"
require "zhuoshe"
require "sldsm"
require "fuxing"
require "zhujian"
require "was"
require "gmd"
require "caiyao"
require "shouwei"
require "qzjx"


gaibangCancel='看守|尼摩星|看窑弟子|赵敏|出尘子|吕文德|侯君集|忽必烈|摘星子|飘然子|黯然子|狮吼子|阿紫|马掌柜|飞天子'
sldsmCancel='铁木真|吕文德|执勤兵|玉玑子|玉磬子|玉音子|梁子翁|达尔巴|看守|尼摩星|看窑弟子|赵敏|出尘子|侯君集|忽必烈|摘星子|飘然子|黯然子|狮吼子|阿紫|马掌柜|飞天子'
loseTj={}
loseTj.succ=0
loseTj.fail=0

--任务难度
jobLevel = {
   ["wdlvl"]    = 1000,
   ["sxlvl"]    = 1000,
   ["wudang"]   = 10,
   ["songxin"]  = 10,
   ["已入化境"] = 7,
   ["极其厉害"] = 6,
   ["颇为了得"] = 5,
   ["马马虎虎"] = 4,
   ["融会贯通"] = 3,
   ["普普通通"] = 2,
   ["微不足道"] = 1,
}    

tongji={}

skillIgnores = {
    ["独孤九剑"] = true,
	["太极拳"] = true,
	["九阴银龙鞭"] = true,
--  ["化骨绵掌"] = true,
--  ["慈航鞭"]   = true,
--	["天山杖法"] = true,
--  ["玄阴剑法"] = true,
}

prepare_trigger=function()
    DeleteTriggerGroup("prepare_neili")
    create_trigger_t('prepare_neili1',"^(> )*(你已将「冷泉内劲」游走|你将八段锦呼吸之法在体内运行十二周天|你将北冥真气在体内运行十二周天|过了片刻，你感觉自己已经将玄天无极神功|你将寒冰真气按周天之势搬运了一周|你只觉真力运转顺畅，周身气力充沛|你将纯阳神通功运行完毕|你只觉神元归一，全身精力弥漫|你将内息走了个一个周天|你将内息游走全身，但觉全身舒畅|你将真气逼入体内，将全身聚集的蓝色气息|你将紫气在体内运行了一个周天|你运功完毕，站了起来|你一个周天行将下来，精神抖擞的站了起来|你分开双手，黑气慢慢沉下|你将内息走满一个周天，只感到全身通泰|你真气在体内运行了一个周天，冷热真气收于丹田|你真气在体内运行了一个周天，缓缓收气于丹田|你双眼微闭，缓缓将天地精华之气吸入体内|你慢慢收气，归入丹田，睁开眼睛|你将内息又运了一个小周天，缓缓导入丹田|你感觉毒素越转越快，就快要脱离你的控制了！|你将周身内息贯通经脉，缓缓睁开眼睛，站了起来|你呼翕九阳，抱一含元，缓缓睁开双眼|你吸气入丹田，真气运转渐缓，慢慢收功|你将真气在体内沿脉络运行了一圈，缓缓纳入丹田|你将内息在体内运行十二周天，返回丹田|你将内息走了个小周天，流回丹田，收功站了起来|过了片刻，你已与这大自然融合在一起，精神抖擞的站了起)",'','prepare_neili_b')
    create_trigger_t('prepare_neili2',"^(> )*(你盘膝而坐，形神合一|你深深吸一口气导入丹田，然后由丹田下行|你盘膝而坐，双目紧闭，深深吸一口气|你运起玄天无极神功，气聚丹田|你手捏剑诀，将寒冰真气|你盘膝而坐，运起八荒六合唯我独尊功|你运起纯阳神通功，片刻之间|你抉弃杂念盘膝坐定，手捏气诀|你盘膝坐下，默运天魔大法|你凝神静气，盘坐下来|你随意坐下，双手平放在双膝，默念口诀|你手捏绣花针，盘膝坐下，默运葵花神功|你坐下来运气用功，一股内息开始在体内流动|你慢慢盘膝而坐，双手摆于胸前|你五心向天，排除一切杂念，内息顺经脉缓缓流动|你盘膝坐下，双手合十置于头顶，潜运内力|你屏息静气，坐了下来，左手搭在右手之上|你盘膝坐下，垂目合什，默运枯荣禅功|你盘膝坐下，闭目合什，运起乾天一阳神功|你盘膝坐下，暗运内力，试图采取天地之精华|你轻轻的吸一口气，闭上眼睛，运起玉女心经|你盘腿坐下，双目微闭，双手掌心相向成虚握太极|你气运丹田，将体内毒素慢慢逼出，控制着它环绕你缓缓飘动|你盘膝而坐，双手垂于胸前成火焰状，深吸口气|你盘膝而坐，运使九阳，气向下沉|你随意坐下，双手平放在双膝，默念口诀|你随意一站，双手缓缓抬起，深吸一口气|你盘膝而坐，双目紧闭，深深吸一口气引入丹田|你席地而坐，五心向天，脸上红光时隐时现|你暗运临济十二庄，气聚丹田)",'','prepare_neili_t')
    create_trigger_t('prepare_neili3',"^(> )*卧室不能(吐纳|打坐)，会影响别人休息。",'','prepare_neili_w')
    create_trigger_t('prepare_neili4',"^(> )*(你正要有所动作|你无法静下心来修炼|你还是专心拱猪吧)",'','prepare_neili_w')
    create_trigger_t('prepare_neili5',"^(> )*这里不准战斗，也不准(吐纳|打坐)。",'','prepare_neili_w')
    create_trigger_t('prepare_neili6',"^(> )*这里可不是让你提高(内力|精力)的地方。",'','prepare_neili_w')
    create_trigger_t('prepare_neili7',"^(> )*你吐纳完毕，睁开双眼，站了起来。",'','prepare_neili_b')
    create_trigger_t('prepare_neili8',"^(> )*你闭上眼睛开始吐纳。",'','prepare_neili_t')
	create_trigger_t('prepare_neili9',"^(> )*你现在手脚戴着镣铐，不能做出正确的姿势来打坐",'','prepare_neili_liaokao')
    SetTriggerOption("prepare_neili1","group","prepare_neili")
    SetTriggerOption("prepare_neili2","group","prepare_neili")
    SetTriggerOption("prepare_neili3","group","prepare_neili")
    SetTriggerOption("prepare_neili4","group","prepare_neili")
    SetTriggerOption("prepare_neili5","group","prepare_neili")
    SetTriggerOption("prepare_neili6","group","prepare_neili")
    SetTriggerOption("prepare_neili7","group","prepare_neili")
    SetTriggerOption("prepare_neili8","group","prepare_neili")
    SetTriggerOption("prepare_neili9","group","prepare_neili")
    EnableTriggerGroup("prepare_neili",false)
end
fight_trigger=function()
    DeleteTriggerGroup("fight")
    create_trigger_t('fight1',"^>*\\s*\\( (\\D*)(摇头晃脑、歪歪斜斜地站都站不稳，眼看就要倒在地上|已经伤痕累累，正在勉力支撑着不倒下去|受了相当重的伤，只怕会有生命危险|已经一副头重脚轻的模样，正在勉力支撑着不倒下去|气息粗重，动作开始散乱，看来所受的伤着实不轻|已经一副头重脚轻的模样，正在勉力支撑着不倒下去|似乎十分疲惫，看来需要好好休息了|看起来已经力不从心了|气喘嘘嘘，看起来状况并不太好|动作似乎开始有点不太灵光，但是仍然有条不紊|看起来可能受了点轻伤|看起来可能有些累了|受了几处伤，不过似乎并不碍事|受伤不轻，看起来状况并不太好|似乎受了点轻伤，不过光从外表看不大出来|似乎有些疲惫，但是仍然十分有活力|已经陷入半昏迷状态，随时都可能摔倒晕去|受伤过重，已经奄奄一息，命在旦夕了|受伤过重，已经有如风中残烛，随时都可能断气)。 \\)",'','fight_check')    
    create_triggerex_lvl('fight2',"^(> )*你「啪」的一声倒在地上，挣扎着抽动了几下就死了",'','fightDie',9)
	create_trigger_t('fight3',"^(> )*你当下正遇劲敌，好不痛快！便连连催动冷泉神功内劲，竟使出「冷泉」绝技！",'','fightlengquan')
    create_trigger_t('fight4',"^(> )*看起来(\\D*)想杀死你！$",'','fightConsider')
    create_trigger_t('fight5',"^(你)(的体力快消耗完了|现在太累了|现在真气太弱|口诵佛号，凝聚全身功力)",'','fight_check')
    create_trigger_t('fight8',"^(> )*太极者，无极而生；动之则分，静之则合！你立如秤准，活如车轮，运起\\D*带动\\D*的(\\D*)一送，让他马步不稳，全力都打向空处",'','fightLiuhe')
    create_trigger_t('fight9',"^(> )*你(缓缓收回内力，眼中的红光|现在无法收功|好象虚脱了一样，突然垮了下来|心神一松，再也支持不)",'','yunWudiDone')
    create_trigger_t('fight10',"^(> )*你(大声叫道：“洪教主神通广大，我教战无不胜|发疯般的叫道：“洪教主神通护佑)",'','yunWudi')
    create_trigger_t('fight12',"^(你)(的内力太少了，无法|现在内力太弱|目前内力太少|现在内力不足)",'','fight_check')
	create_trigger_t('fight13',"^(> )*如果你要和(\\D*)\\((\\w*)\\)性命相搏，请你也对这个人下一次 kill 指令。",'','fightPk')
	create_trigger_t('fight14',"^(\\D*)(身上金刚不坏体神功随心而起，和你一撞|身上生出一股反震之力，功力已布满全身，将你的|身上生出一股反震之力，你便如撞在|身上生出一股反震之力，抢先反震，将你震得|突然发动吸星大法，你突然觉得|不等你收招，指力一转直向|默念“他横由他横，明月照大江”，九阳神功随心而起，你便如)",'','fightHitback')
	create_trigger_t('fight16',"^一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……",'','faint_check')
    create_trigger_t('fight18',"^(> )*你(必须使用剑|拿着武器怎么能|必须空手|手里没有|手里无|手上无)",'','weapon_unwield')
	create_trigger_t('fight19',"^(> )*(手中没有武器,如何|先放下手中的武器|使用「\\D*」时双手必须空着！)",'','weapon_unwield')
    SetTriggerOption("fight1","group","fight")
    SetTriggerOption("fight2","group","fight")
    SetTriggerOption("fight3","group","fight")
    SetTriggerOption("fight4","group","fight")
    SetTriggerOption("fight5","group","fight")
    SetTriggerOption("fight6","group","fight")
    SetTriggerOption("fight7","group","fight")
    SetTriggerOption("fight8","group","fight")
    SetTriggerOption("fight9","group","fight")
    SetTriggerOption("fight10","group","fight")
    SetTriggerOption("fight11","group","fight")
    SetTriggerOption("fight12","group","fight")
	SetTriggerOption("fight13","group","fight")
	SetTriggerOption("fight14","group","fight")
    SetTriggerOption("fight16","group","fight")
    SetTriggerOption("fight18","group","fight")
	SetTriggerOption("fight19","group","fight")
    job_exp_trigger()
end

function yunWudiDone()
    flag.wudi=0
end
function yunWudi()
    flag.wudi=1
end

function fightPk(n,l,w)
    local l_name = w[2]
	local l_id = string.lower(w[3])
	messageShow('遭遇'..l_name..':'..l_id..'发起的PK!','red','white')
	if job.name ~= "hubiao" then
	    dis_all()
	    exe('follow '.. l_id)
	    wipe(l_id,check_heal)
	end
end
function fightLiuhe(n,l,w)
    local l_force=w[2]
    if string.len(l_force)<6 then return end
    if string.find("化功大法|归元吐纳法|毒龙大法",w[2]) then
       exe('set 六合劲 螺旋')
    end
    if string.find("混天气功|龙象般若功|蛤蟆功",w[2]) then
       exe('set 六合劲 钻翻')
    end
    if string.find("乾天一阳功|易筋经|枯荣禅功",w[2]) then
       exe('set 六合劲 软手')
    end
    if string.find("神元功|紫霞功|圣火神功",w[2]) then
       exe('set 六合劲 开合')
    end
    if string.find("玉女心经|神照经",w[2]) then
       exe('set 六合劲 静恒')
    end
    if string.find("临济十二庄|寒冰真气|玄天无极功|先天功|碧海潮生功",w[2]) then
       exe('set 六合劲 虚灵')
    end
end

function fightConsider(n,l,w)
    --if not (job.killer and job.killer[w[2]]) and not (road.wipe_who and road.wipe_who==w[2]) then
    --  exe(perform.huaxue)
    --end
end
function fightlengquan()
    tmp.lengquan = os.time()
end

function fightDie()
    scrLog()
    dis_all()
	flag.wxjz=0
    create_triggerex('die',"^(> )*城隍庙 - $",'','main')
end
function fightHitback(n,l,w)
    job.killer = job.killer or {}
	job.guard = job.guard or {}
	if job.killer[w[1]] or job.guard[w[1]] or (job.target and w[1]==job.target) then
	    exe('hp')
        return checkAW(fightHpCheck,0.2)
	end
end
function fight_check(n,l,w,styles)
    if w[1]=='你' then
       exe('hp')
       return checkAW(fightHpCheck,0.2)
    elseif job.name=="sldsm" and job.type and job.type=="zh" and w[1]==job.target then
       return sldsmZh(n,l,w,styles)
    end
end
function fightHpCheck()
	local l_flag = false
	local l_flagjing = false
	local l_flagjingli = false
	local l_flagneili = false
	local l_flagdan = false
    local performfight
	
	if (hp.qixue_per<70 or hp.jingxue_per<80) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 50) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 25) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if hp.neili<hp.neili_max*0.3 and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if hp.jingli<hp.jingli_max*0.2 and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if l_flagdan then
     	performfight="eat dan;"	
	end
    if hp.qixue<hp.qixue_max*0.7 then
	    l_flag = true
        if performfight then
		    performfight = performfight .. "yun qi;"
		else
		    performfight = "yun qi;"
		end
    end
    if hp.jingxue<hp.jingxue_max*0.5 then
	    l_flagjing = true
		if performfight then
		    performfight = performfight .. "yun jing;"
		else
		    performfight = "yun jing;"
		end
    end
	if hp.neili<hp.neili_max*0.5 and Bag["川贝内息丸"] then
	    l_flagneili = true
		if performfight then
		    performfight = performfight .. "eat ".. drug.neili .. ";"
		else
		    performfight = "eat ".. drug.neili .. ";"
		end
    end
	if hp.jingli<hp.jingli_max*0.7 then
	    l_flagjingli = true
		if performfight then
		    performfight = performfight .. "yun jingli;"
		else
		    performfight = "yun jingli;"
		end
    end
	if performfight then
	    perform.pre = performfight .. GetVariable("performpre")
	else
	    perform.pre = GetVariable("performpre")
	end
	if job.name == "smy" then
	    perform.pre = perform.pre .. ";kill wu shi"
	end
	create_alias('pfmset','pfmset','alias pfmpfm '.. perform.pre)
    exe('pfmset')
	if l_flagdan then exe('eat dan') end
	if l_flagneili then exe('eat '.. drug.neili) end
	if l_flag then exe('yun qi') end
	if l_flagjing then exe('yun jing') end
	if l_flagjingli then exe('yun jingli') end
	if performfight then	    
	    exe('hp')
        return checkAW(fightHpCheck,0.5)
	end
end
function nmHpCheck()
	local l_flag = false
	local l_flagjing = false
	local l_flagjingli = false
	local l_flagdan = false
	
	if (hp.qixue_per<70 or hp.jingxue_per<80) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if (hp.qixue / (hp.qixue_max / hp.qixue_per ) < 50) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if (hp.jingxue / (hp.jingxue_max / hp.jingxue_per ) < 25) and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if hp.neili<hp.neili_max*0.3 and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
	if hp.jingli<hp.jingli_max*0.2 and (Bag["大还丹"] or Bag["大还丹(盒)"]) then
	    l_flagdan = true
    end
    if hp.qixue<hp.qixue_max*0.7 then
	    l_flag = true
    end
    if hp.jingxue<hp.jingxue_max*0.5 then
	    l_flagjing = true
    end
	if hp.jingli<hp.jingli_max*0.7 then
	    l_flagjingli = true
    end
	if l_flagdan then exe('eat dan') end
	if l_flag then exe('yun qi') end
	if l_flagjing then exe('yun jing') end
	if l_flagjingli then exe('yun jingli') end
end

faintFunc = faintFunc or {}
function faint_check()
    nmHpCheck()
	job.killer = {}
	tmp = {}
	faintFunc = faintFunc or {}
	for k,v in pairs(faintFunc) do
	    if job.name == k then
		   return _G[v]()
		end
	end
    return check_heal()
	
end


function killPfm(id,p_cmd)
    local l_cmd="kill"
    if p_cmd and type(p_cmd)=="string" then l_cmd=p_cmd end
    if id then
       exe(l_cmd ..' '..id)
    end
    tmp.pfm=100
    tmp.busytest=0
	exe('set wimpycmd pfmpfm\\hp;set wimpy 100')
end

fight_prepare=function()
    local l_pfm
    weapon_unwield()
    weapon_wield()
    exe('remove biao;jiali 1;yield no')
    
    beiUnarmed()
    --l_pfm = perform.pre
	l_pfm = GetVariable("performpre")
	if job.name == "smy" then
	    l_pfm = l_pfm .. ";kill wu shi"
	end
    if perform and perform.skill and l_pfm then
       create_alias('pfmset','pfmset','alias pfmpfm '.. l_pfm)
       exe('pfmset')
    end
    exe('set wimpy 100;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    --if score.party=="神龙教" and flag.wudi and flag.wudi==0 then
    --   l_pfm = "yun wudi ".. score.id
	--   exe(l_pfm)
    --end
    
	fightSkillPrepare()
end
function fightSkillPrepare()
    skillPrepare = skillPrepare or {}
    for p in pairs(skillPrepare) do
	    if type(skillPrepare[p])=="function" then
		    local cmd = skillPrepare[p]()
			if cmd then exe(cmd) end
		end
	end
end
prepare_lianxi=function(func)
    prepare_trigger()
    EnableTriggerGroup("prepare_neili",true)
    flag.prepare=1
    if func~=nil then
        job.prepare=func
    else
        job.prepare=test   
    end
    condition={}
    exe('cond')
    return check_busy(prepareLianxi,1)
end
function prepareLianxi()
    if not condition["任务繁忙状态"] or condition["任务繁忙状态"] == 0 then
        return prepare_neili(job.prepare)
    end
    flag.jixu=1
    if hp.neili_max>hp.neili_lim-10 then
        exe('set 积蓄')
    elseif job.prepare and (job.prepare==test or job.prepare==duHhe_start or job.prepare==duCjiang_start) then
        exe('set 积蓄')
    else
        flag.jixu=0
        exe('unset 积蓄')
    end
    
    return prepare_neili_a()
end
prepare_neili=function(func,p_cmd)
    local l_db
    if func~=nil then
        job.prepare=func
    else
        job.prepare=test   
    end

    tmp.db=p_cmd
    l_db=3/2
	if score.party and score.party == "桃花岛" then
	    l_db=5/3
	end
    if tmp.db and type(tmp.db)=="number" and tmp.db<2 then
        l_db=tmp.db
    end

    --if hp.neili>hp.neili_max*l_db and job.prepare~=test and job.prepare~=fight_prepare then
    --    return check_bei(job.prepare)
    --end

    flag.prepare=0   
    prepare_trigger()
    EnableTriggerGroup("prepare_neili",true)
    flag.jixu=1
    exe('set 积蓄')
    exe('yun jing;yun jingli;hp')
    
    prepare_neili_a()
end
prepare_neili_at=function()
   if tmp.prepare then job.prepare=tmp.prepare end 
   prepare_trigger()

   EnableTriggerGroup("prepare_neili",true)
   create_timer_s('neili',3,'prepare_neili_idle')
end
prepare_neili_a=function()
    prepare_neili_idle()
    if hp.qixue_per<50 and isInBags(drug.heal) then
        exe('eat dan')
    end
    create_timer_s('neili',3,'prepare_neili_idle')
end
prepare_neili_b=function()
    exe('yun qi;hp')
    return check_bei(prepare_neili_c)
end
prepare_neili_c=function()
    local l_db=3/2
    
    if tmp.db and type(tmp.db)=="number" and tmp.db<2 then
        l_db=tmp.db
    end
    
    if not flag.prepare or type(flag.prepare)~='number' then flag.prepare=0 end
    if not condition["任务繁忙状态"] or condition["任务繁忙状态"]==0 then flag.prepare=0 end
    if job.prepare==duHhe_start or job.prepare==duCjiang_start then flag.prepare=0 end
    if hp.neili>hp.neili_max*l_db and flag.prepare==0 then
        EnableTriggerGroup("prepare_neili",false)
        DeleteTriggerGroup("prepare_neili")
        DeleteTimer('neili')
        exe('yun jing;yun qi;yun jingli')
        return check_bei(job.prepare)
    else
        return prepare_neili_a()
    end
end
prepare_neili_w=function()
    if job.name and job.name == "hubiao" then
        prepare_neili_stop()
        return check_bei(job.prepare)
    end
    locate()
    return check_bei(prepare_neili_g)
end
prepare_neili_g=function()
    exe(locl.dir)
end
prepare_neili_t=function()
    DeleteTimer('neili')
end
prepare_neili_idle=function()
    local l_cnt=0
    local l_db=3/2
    
    for p in pairs(skills) do
        if skillEnable[p] and skillEnable[p]=="force" then
            tmp.fskill=p
	        break
        end
    end
    if perform.force then
        tmp.fskill=perform.force
    end
	
	if (hp.neili_max>=hp.neili_lim-5 or flag.jixu==1 or skills[tmp.fskill].full==0) and hp.neili>hp.neili_max*l_db then
		if hp.neili>hp.neili_max*7/4 then
		    l_cnt=l_cnt + math.modf((hp.neili-hp.neili_max*7/4)/10)
		end
		l_cnt=l_cnt + math.modf(hp.neili_max/300)
		if l_cnt<1 then l_cnt=1 end
		lianxi(l_cnt)
	end
    
    if score.gold and score.gold>1000 and hp.neili<hp.neili_max and isInBags(drug.neili) then
        exe('eat '.. drug.neili)
    end
    exe('yun jingli;yun jing;yun qi')
    if hp.jingli_max<hp.jingli_lim-500 and flag.lianxi==1 and hp.neili>hp.neili_max*l_db and (hp.neili_max>=hp.neili_lim-5 or flag.jixu==1) then
        exe('unset 积蓄')
        exe('tuna '..hp.jingxue/2)
    else
        exe('dazuo '..hp.dazuo)
    end
	condition={}
    exe('cond')
end
prepare_neili_stop=function()
    DeleteTimer('neili')
    DeleteTimer('bei')
    EnableTriggerGroup("prepare_neili",false)
    DeleteTriggerGroup("prepare_neili")
    beihook=test
    busyhook=test
    EnableTriggerGroup("check_bei",false)
    EnableTriggerGroup("check_busy",false)
    exe('halt')
end
prepare_neili_liaokao=function()
    dis_all()
	return tiaoshui()
end

function job.flag()
    flag.find=0
    flag.wait=0
end

function job_exp_trigger()
    DeleteTriggerGroup("job_exp")
    create_trigger_t('job_exp1',"^(> )*(\\D*)点潜能!$",'','jobExppot')
    create_trigger_t('job_exp2',"^(> )*(\\D*)点经验!$",'','jobExpexp')
    create_trigger_t('job_exp3','^(> )*你静下心来，反复回想刚才的任务过程，不禁豁然开朗。。你额外地得到了(\\D*)点经验！','','jobExpExtra')
    create_trigger_t('job_exp4',"^>*\\s*你觉得脑中豁然开朗，增加了(\\D*)点潜能和(\\D*)点经验！",'','job_exp_gb')
    create_trigger_t('job_exp5',"^(> )*恭喜你！你成功的完成了(\\D*)任务！你被奖励了",'','jobExp')
    SetTriggerOption("job_exp1","group","job_exp")
    SetTriggerOption("job_exp2","group","job_exp")
    SetTriggerOption("job_exp3","group","job_exp")
    SetTriggerOption("job_exp4","group","job_exp")
    SetTriggerOption("job_exp5","group","job_exp")
	EnableTrigger("job_exp1",false)
	EnableTrigger("job_exp2",false)
end
function jobExp(n,l,w)
    EnableTrigger("job_exp1",true)
	EnableTrigger("job_exp2",true)
    hp.exp_name=tostring(w[2])
end
function jobExpexp(n,l,w)
    hp.exp_exp=tostring(w[2])
end
function jobExppot(n,l,w)
    EnableTrigger("job_exp1",false)
	EnableTrigger("job_exp2",false)
	hp.exp_pot=tostring(w[2])
	if not isNil(hp.exp_name) and not isNil(hp.exp_exp) and not isNil(hp.exp_pot) then
	   return messageShow(hp.exp_name ..'任务奖励：经验:【'.. hp.exp_exp ..'】点，，潜能:【'.. hp.exp_pot ..'】点！','darkorange')
	end
	hp.exp_name=nil
	hp.exp_exp=nil
	hp.exp_pot=nil
end

function jobExpExtra(n,l,w)
    messageShow('额外任务奖励：经验:【'..w[2]..'】点！','darkorange')
end

function job_exp_gb(n,l,w)
    if job.name=="gaibang" then
       messageShow('丐帮任务奖励：经验:【'..w[2]..'】点，潜能:【'..w[1]..'】点！')
    end
    if job.name=="songshan" then
       messageShow('嵩山任务奖励：经验:【'..w[2]..'】点，潜能:【'..w[1]..'】点！')
    end
end
function job_exp_zs(n,l,w)
    messageShow('捉蛇任务奖励：经验:【'..w[1]..'】点，潜能:【'..w[2]..'】点！')
end

function job_exp_tongji(p_cmd)
    tongji = tongji or {}
    if tongji.exp==nil then 
       tongji.exp=hp.exp
       tongji.time=os.time()
       tongji.hour=math.modf(os.time()/900)
       messageShow('任务奖励统计：统计开始','red')
       return
    end

    if not tongji.time or not tongji.hour then 
       tongji.exp=nil
       return
    end
    if math.modf(os.time()/900)<=tongji.hour and not p_cmd then return end

    tongji.hour=math.modf(os.time()/900)

    local l_exp=hp.exp
    local l_time=os.time()-tongji.time
    local l_hour=math.modf(l_time/3600)
    local l_min=math.modf((l_time-l_hour*3600)/60)
    local l_sec=l_time-l_hour*3600-l_min*60
    local l_exp=hp.exp-tongji.exp
    local l_avg=math.modf(l_exp*3600/l_time)
	
	job.expAvg = l_avg

	if flag.log and flag.log=="yes" then
       messageShow('任务奖励统计：共运行【'.. l_hour ..'小时'.. l_min .. '分' .. l_sec ..'秒' ..'】，获得经验【'..l_exp..'】点，平均每小时【'..l_avg..'】点！','red')
    else
	   ColourNote ("white","blue",'任务奖励统计：共运行【'.. l_hour ..'小时'.. l_min .. '分' .. l_sec ..'秒' ..'】，获得经验【'..l_exp..'】点，平均每小时【'..l_avg..'】点！')    
	end
	SetStatus('任务奖励统计：共运行【'.. l_hour ..'小时'.. l_min .. '分' .. l_sec ..'秒' ..'】，获得经验【'..l_exp..'】点，平均每小时【'..l_avg..'】点！')
end
function jobExpTongji()
    return job_exp_tongji(1)
end

JobTriggerDel = JobTriggerDel or {}

function jobTriggerDel()
    local delList = {
	    ["huashan_triggerDel"] = true,
		["songxin_triggerDel"] = true,
		["gaibangTriggerDel"] = true,
		["zhuosheTriggerDel"] = true,
		["clbTriggerDel"] = true,
		["gbluTriggerDel"] = true,
		["sldsmTriggerDel"] = true,
		["tmonkTriggerDel"] = true,
		["husongTriggerDel"] = true,
		["wudangTriggerDel"] = true,
		["xueshan_triggerDel"] = true,
		["tdh_triggerDel"] = true,
	}
    
	for p in pairs(delList) do
	    if _G[p] then
		   _G[p]()
		end
	end
	
	JobTriggerDel = JobTriggerDel or {}
	for p,q in pairs(JobTriggerDel) do
	    if _G[q] then
	        _G[q]()
		end
	end
end

function jobSet()
    local l_result,l_tmp,t
    
    t={}
    
    for p,q in pairs(job.list) do
        if type(q) == 'function' then
	        if q() then t[p] = q() end
        else	   
            t[p] = q
	    end
    end
   
    job.zuhe={}
    if GetVariable("jobzuhe") then
        tmp.job=utils.split(GetVariable("jobzuhe"),'_')
	    tmp.zuhe = {}
        for _,p in pairs(tmp.job) do
            tmp.zuhe[p]=true
        end
    end
    l_tmp=utils.multilistbox ("你的任务组合(请按CTRL多选)是?", "任务组合", t,tmp.zuhe)
    l_result=nil
    for p in pairs(l_tmp) do
        job.zuhe[p]=true
        if l_result then
            l_result = l_result .. '_' .. p
        else
            l_result = p
        end
    end
    if l_result~=nil then
        SetVariable("jobzuhe",l_result)
    end
    for p in pairs(t) do
        if not job.zuhe[p] then
	        t[p]=nil
	    end
    end
    job.first = nil
    job.second = nil
   
    if jobSpecial then
        for p in pairs(jobSpecial) do
	        t[p] = nil
	    end
    end
   
    if countTab(t)>2 then
        l_result=utils.listbox("你第一优先去的任务：","优先任务",t,GetVariable("jobfirst"))
        if l_result~=nil then
            SetVariable("jobfirst",l_result)
            job.first=l_result
	 	    t[job.first]=nil
        else
	        job.first = nil
            DeleteVariable("jobfirst")
        end
    end
    if countTab(t)>1 and job.first then
	    l_result=utils.listbox("你第二优先去的任务：","优先任务",t,GetVariable("jobsecond"))
        if l_result~=nil then
            SetVariable("jobsecond",l_result)
            job.second=l_result
        else
	        job.second = nil
            DeleteVariable("jobsecond")
        end
    else
	    job.second = nil
        DeleteVariable("jobsecond")
    end
    if not job.first then
        DeleteVariable("jobfirst")   
    end
    if not job.second then
        DeleteVariable("jobsecond")
    end
   
    if job.zuhe["hubiao"] or job.zuhe["smy"] or job.zuhe["was"] then
	    drugPrepare["大还丹"]=true
        if GetVariable("teamname") then
            l_result=utils.inputbox ("你组队的队友(中文名称)是?", "TeamName", GetVariable("teamname"), "宋体" , "12")
        else
            l_result=utils.inputbox ("你组队的队友(中文名称)是?", "TeamName", job.teamname, "宋体" , "12")
        end
        if not isNil(l_result) then
            SetVariable("teamname",l_result)
            job.teamname=l_result
        else
            DeleteVariable("teamname")
            job.teamname=nil
        end
        if GetVariable("teamlead") then
            l_result=utils.inputbox ("你组队的队长(中文名称)是?", "TeamLead", GetVariable("teamlead"), "宋体" , "12")
        else
            l_result=utils.inputbox ("你组队的队长(中文名称)是?", "TeamLead", job.teamlead, "宋体" , "12")
        end
        if not isNil(l_result) then
            SetVariable("teamlead",l_result)
            job.teamlead=l_result
        else
            DeleteVariable("teamlead")
            job.teamlead=nil
        end
    end
	if job.zuhe["smy"] then
	    if GetVariable("flaground") then
            l_result=utils.inputbox ("你颂摩崖抗敌准备抗几轮?", "flaground", GetVariable("flaground"), "宋体" , "12")
        else
            l_result=utils.inputbox ("你颂摩崖抗敌准备抗几轮?", "flaground", '9', "宋体" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flaground",l_result)
        else
            DeleteVariable("flaground")
        end
    end
	if job.zuhe["was"] then
	    if GetVariable("flagwasround") then
            l_result=utils.inputbox ("你准备万安寺闯过几层?", "flagwasround", GetVariable("flagwasround"), "宋体" , "12")
        else
            l_result=utils.inputbox ("你准备万安寺闯过几层?", "flagwasround", '19', "宋体" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flagwasround",l_result)
        else
            DeleteVariable("flagwasround")
        end
    end
	if job.zuhe["gmd"] then
	    if GetVariable("flagwasround") then
            l_result=utils.inputbox ("你准备光明顶闯过几层?", "flaggmdround", GetVariable("flaggmdround"), "宋体" , "12")
        else
            l_result=utils.inputbox ("你准备光明顶闯过几层?", "flaggmdround", '19', "宋体" , "12")
        end
        if not isNil(l_result) then
            SetVariable("flaggmdround",l_result)
        else
            DeleteVariable("flaggmdround")
        end
    end
end
function jobGetVar()
    if GetVariable("jobzuhe") then
        tmp.job=utils.split(GetVariable("jobzuhe"),'_')
        for _,p in pairs(tmp.job) do
            job.zuhe[p]=true
        end
    end
    if GetVariable("jobfirst") then
        job.first=GetVariable("jobfirst")
	    if job.first=="songxin2" then job.first="songxin" end
    else
        job.first=nil
    end
    if GetVariable("jobsecond") then
        job.second=GetVariable("jobsecond")
	    if job.second=="songxin2" then job.second="songxin" end
    else
        job.second=nil
    end
    if job.zuhe["xueshan"] and job.zuhe["wudang"] and job.zuhe["huashan"] then
        job.third="huashan"
    else
        job.third=nil
    end
    if GetVariable("gaibangcancel") then
        gaibangCancel=GetVariable("gaibangcancel")
    end
    if GetVariable("sldsmcancel") then
        sldsmCancel=GetVariable("sldsmcancel")
    end
    if GetVariable("teamname") then
        job.teamname=GetVariable("teamname")
    end
    if GetVariable("teamlead") then
        job.teamlead=GetVariable("teamlead")
    end
end

function messageShow(p_msg,ccolor,bcolor) 
    local c_color = ccolor or "white"
	local b_color = bcolor or "blue"
	
	if isNil(p_msg) then return end
	
	local mcolor = {
	     ["songxin"] = "white",
		 ["wudang"]  = "forestgreen",
		 ["xueshan"] = "forestgreen",
		 ["clb"]     = "cyan",
		 ["was"]     = "cyan",
		 ["hubiao"]  = "yellow",
		 ["shouwei"]  = "yellow",
		 ["huashan"] = "blue",
		 ["fuxing"] = "hotpink",
	}
	
	if job.name and mcolor[job.name] then ccolor = mcolor[job.name] end

    if GetVariable("flaglog") and GetVariable("flaglog")=="yes" then
	    return chats_log(p_msg,ccolor,bcolor)
	end	
    if GetVariable("flagnote") and GetVariable("flagnote")=="yes" then
        --return ColourNote ("white","blue",p_msg)
		ColourNote ("white","blue",p_msg)
	end
	MsgNote(os.date("%H:%M:%S") .. " " ..p_msg,ccolor,bcolor)
	return txtJobLog(p_msg)
end

local lastWeekDay = os.date("%w")
function txtJobLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\" .. score.id .. "_" .. os.date("%w") .. "_job_log.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end
function txtLocateLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\" .. score.id .. "_" .. os.date("%w") .. "_locate.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end
function txtChatLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\xajh_" .. os.date("%w") .. "_chat.log"
	local file
	if not lastWeekDay then lastWeekDay = os.date("%w") end
	if lastWeekDay ~= os.date("%w") then
	    file = io.open(filename,"w")
	else
	    file = io.open(filename,"a")
	end
	lastWeekDay = os.date("%w")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end

function varShow(p_var)
    messageShow(p_var..': '.. _G[p_var])
end

function setJobwhere(p)
    job.where = p
end

function setGfunc(var,value)
    _G[var] = value
end

function scrLog()
    local filename = GetInfo (67) .. "logs\\死亡log_" .. score.id .. "_".. os.date('%Y_%m_%d_%H_%M_%S') .. ".log"
	
    local file = io.open(filename,"w")
   
    local t = {}
   
    for i = 1,GetLinesInBufferCount() do
        table.insert(t,GetLineInfo(i,1))
    end
   
    local s = table.concat(t,"\n") .. "\n"
	
	if file then
	    file:write(s)  
        file:close()
	end
end

function commCut(target,func)
    tmp.target = target
	tmp.func   = func
	
    DeleteTriggerGroup("commCut")
	create_trigger_t('commCut1','^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。','','commCutCon')
	create_trigger_t('commCut2','^(> )*你得用件锋利的器具才能切下这尸体的头来。','','commCutWeapon')
	SetTriggerOption("commCut1","group","commCut")
	SetTriggerOption("commCut2","group","commCut")
	EnableTriggerGroup("commCut",false)
	
    return check_bei(commCutAct,1)
end
function commCutAct()
	EnableTriggerGroup("commCut",true)
	weapon_unwield()
    weaponWieldCut()
	create_timer_s('commcutter',1,'commCutTimer')
	commCutTimer()
end
function commCutTimer()
	for i=1,3 do
        exe('qie corpse '..i)    
    end	
end
function commCutWeapon()
    EnableTrigger("commCut2",false)
	checkBags()
    return checkWait(commCutAct,2)
end
function commCutCon(n,l,w)
    if w[2] == tmp.target then
	    dis_all()
		return check_bei(commCutOver,1)
	end
end
function commCutOver()
    DeleteTimer("commcutter")
	DeleteTriggerGroup("commCut")
	if isGlobalFunc(tmp.func) then 
	    return _G[tmp.func]()
	else
	    return check_heal()
	end
end