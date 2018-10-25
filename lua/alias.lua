
function handFree()
	unwieldWeapon()
	unwieldCutweapon()
	unwieldIntweapon()
	return true
end

function wieldCutweapon()
	local cutweapon = getCutweapon()
	e("wield " .. cutweapon)
	return true
end

function unwieldCutweapon()
	--local weapon = getWeapon()
	--if weapon ~= "empty" then
	--	return true
	--end
	local cutweapon = getCutweapon()
	if cutweapon then
		e("unwield " .. cutweapon)
	end
	return true
end

function wieldIntweapon()
	local intweapon = intWeapon()
	if intweapon then
		e("wield " .. intweapon)
	end
end

function unwieldIntweapon()
	local intweapon = intWeapon()
	if intweapon then
		e("unwield " .. intweapon)
	end
end

function unwieldWeapon()
	local weapon = getWeapon()
	if weapon ~= "empty" then
		e("unwield " .. weapon)
		return true
	end
	return true
end

function wieldWeapon()
	local weapon = getWeapon()
	if weapon ~= "empty" then
		e("wield " .. weapon)
		return true
	end
	return true
end

function outGb()
	if not validHere("大戈壁") then
		return false
	end
	e("#12 s")
	wait(1500)
	if validHere("草棚") then
		return true
	else
		return outGb()
	end
end

function outTssd()
	if not validHere("山道") then
		return false
	end
	e("#10 e")
	wait(1500)
	if validHere("山径") then
		return true
	else
		return outTssd()
	end
end

function outThz()
	local ways = {"east", "west", "south", "north"}
	while true do
		local coins = {}
		for _, way in pairs(ways) do
			e("l " .. way)
			e("set coin " .. way)
			addListener([[^  (\S+)文铜钱\(Coin\)$]], "s:return trans(wildcards[1])", "coin")
			addListener([[^设定环境变量：coin = "]] .. way .. [["]], "s:return 0", "coin")
			local n = listen()
			coins[way] = n
		end
		local min = 10000
		local goWay
		for k, v in pairs(coins) do
			if v < min then
				min = v
				goWay = k
			end
		end
		e(goWay)
		if here().name == "小院" then
			return true
		else
			e("drop 1 coin")
			wait(1000)
		end
	end
end

function goYd()
	local _i = i()
	if _i["weight"] >= 20 then
		return false
	end
	if _i["nao gou"] == 0 or _i["tao suo"] == 0 then
		go("心禅堂")
		local id = getId("方生大师")
		if not id then
			wait(2000)
			return goYd()
		end
		e("ask fangsheng dashi about 挠钩")
		waitbusy()
		e("ask fangsheng dashi about 套索")
		waitbusy()
		go("断崖坪")
	end
	e("gou naogou;shuai taosuo;pa up")
	set("yd")
	addListener("^你借助手中的挠钩套索，施展轻功爬了上去。$", "s:return false", "yd")
	addSetListener("yd", "yd")
	if listen() then
		log.error("去少林无相禅师失败")
	end
end

function goHt()
	local id = getId("公孙止")
	if not id then
		wait(2000)
		return goHt()
	end
	e("ask gongsun zhi about 绝情谷")
	waitbusy()
	e("xian hua;zuan dao")
	return true
end

function goXtj()
	xtjStart()
	e("n;e;n;e;w;s;n;n")
end

function outXtj()
	xtjStart()
	e("s")
end

function xtjStart()
	if not validHere("树林") then
		return false
	end
	local ways = {"e", "s", "n", "w"}
	local _, way = randomGet(ways)
	e(way)
	e("n;e;n;e;w;s;n;s;s;n")
	local _here = here()
	_here.exits = around(_here.exits)
	wait(2000)
	if _here.exits["south"].name == "山路" then
		return true
	else
		return xtjStart()
	end
end

function yjh()
	if getExp() > 1200000 and getLcj().quest == 1 then
		e("w;get ye juhua;e;s")
	else
		e("s")
	end
end

function dmd()
	local _here = here()
	if _here.name ~= "竹林" then
		return false
	end
	randomMove(_here.exits)
	local exits = {"e", "s", "n", "w"}
	for i=1,5 do
		local _, exit = randomGet(exits)
		e(exit)
	end
	e("nw;n")
	if validHere("达摩洞") then
		return true
	else
		return dmd()
	end
end

function outYs()
	local _hp = hp()
	if _hp.shen < 0 then
		e("#20 mianbi")
		wait(2000)
		return outYs()
	else
		e("ask di yun about 离开")
		waitbusy()
		e("jump up")
		waitbusy()
	end
end

function outTlsSsl()
	local _here = here()
	if _here.name ~= "松树林" and _here.name ~= "石板路" then
		return false
	end
	e("s;w;s;w")
	e("#11 s")
	wait(2000)
	if not validHere("雨花阁") then
		return outTlsSsl()
	else
		return true
	end
end

function toXdt()
	e("#9 n;#6 e")
	return toXdt0(0)
end

function toXdt0(n)
	if n > 30 then
		return false
	end
	if validHere("小洞天") then
		return true
	end
	e("w;e")
	return toXdt0(n + 1)
end

function toRyp()
	if not validHere("石门") then
		return false
	end
	local id = getId("贾布")
	if id then
		e("whisper jia 教主文成武德，一统江湖")
		e("whisper jia 教主千秋万载，一统江湖")
		e("whisper jia 属下忠心为主，万死不辞")
		e("whisper jia 教主令旨英明，算无遗策")
		e("whisper jia 教主烛照天下，造福万民")
		e("whisper jia 教主战无不胜，攻无不克")
		e("whisper jia 日月神教文成武德、仁义英明")
		e("whisper jia 教主中兴圣教，泽被苍生")
		e("wu")
		if validHere("日月坪") then
			return true
		else
			return false
		end
	else
		wait(2000)
		return toRyp()
	end
end

function hmy(locate)
	local _here = here()
	if _here.name ~= "日月坪" and _here.name ~= "崖顶" then
		return false
	end
	local _hp = hp()
	if getJifaDodge() >= 300 and getMaxNeili() >= 4000 and _hp.neili >= 1500 and _hp.jingli >= 1000 then
		local result = fly("zong")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return hmy(locate)
		end
	end
	e("yell " .. locate .. ";r;tuna")
	set("hmy")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "hmy")
	addSetListener("hmy", "hmy")
	if listen() == "hmy" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		hmy(locate)
	else
		listener([[^竹篓晃了几下，在一间石屋之内停了下来。$]])
		e("out")
	end
end

function outTl()
	e("set look")
	local _here = here()
	_here.exits[""] = true
	for k in pairs(_here.exits) do
		e("l " .. k)
		set("outtl")
		addListener("舍利院", "s:return 'ok'", "outtl")
		addSetListener("outtl", "outtl")
		local result = listen()
		if result == "ok" then
			wait(2000)
			e(k)
			e("ne;n;nw;sw;w;ne;w;s;nw;sw;n")
			return true
		end
	end
	wait(2000)
	_here.exits[""] = nil
	randomMove(_here.exits)
	return outTl()
end

function toSsa()
	local _hp = hp()
	if _hp.qi >= 100 then
		e("climb")
		if validHere("三圣坳") then
			return true
		else
			return toSsa()
		end
	elseif _hp.neili >= 20 then
		e("yun qi")
		return toSsa()
	else
		return false
	end
end

function wdSqd(i)
	i = i or 0
	if i > 10 then
		return false
	end
	if validHere("三清殿") then
		return true
	end
	e("n")
	return wdSqd(i+1)
end

function wdYm()
	if not validHere("小径") then
		return false
	end
	e("s")
	return wdYm0()
end

function wdYm0()
	if validHere("院门") then
		return true
	end
	local ways = {
		["东"] = "east",
		["南"] = "south",
		["西"] = "west",
		["北"] = "north",
	}
	local result = listener([[^你站在小径上，四周打量，仿佛看见(\S+)面有些亮光。$]], "s:return wildcards[1]")
	e(ways[result])
	return wdYm0()
end

function outJgSq()
	outJg()
	if validHere("大石桥") then
		return true
	else
		return go("大石桥", "归云庄")
	end
end

function outJgZq()
	outJg()
	if validHere("归云庄前") then
		return true
	else
		return go("归云庄前", "归云庄")
	end
end

function outJg()
	local _here = here()
	if _here.name == "归云庄前" or _here.name == "大石桥" then
		return true
	end
	if not validHere("九宫桃花阵") then
		return false
	end
	wait(2000)
	e("#2 n;#2 w")
	getTaohua()
	e("e")
	getTaohua()
	e("e")
	getTaohua()
	e("s")
	getTaohua()
	e("w")
	getTaohua()
	e("w")
	getTaohua()
	e("s")
	getTaohua()
	e("e")
	getTaohua()
	e("e")
	getTaohua()
	wait(2000)
	e("drop 5 taohua;w;drop 5 taohua;w;drop 5 taohua;n;drop 5 taohua;e;drop 5 taohua;e;drop 5 taohua;n;drop 5 taohua;w;drop 5 taohua;w;drop 5 taohua")
end

function getTaohua()
	e("l")
	addListener([[^    这是一片茂密的桃花丛，你一走进来就迷失了方向。地上有(\S+)株桃花\(taohua\)。$]],"s:return wildcards[1]", "taohua")
	addListener([[^    这是一片茂密的桃花丛，你一走进来就迷失了方向。地上一株桃花\(taohua\)也没有。$]],"s:return false", "taohua")
	local result = listen()
	if result then
		e("get " .. trans(result) .. " taohua")
	end
end

function stToSd()
	if not validHere("水塘") then
		return false
	end
	e("eu")
	if validHere("山顶平地") then
		return true
	elseif validHere("竹林") then
		zlToSt()
		return stToSd()
	else
		return false
	end
end

function zlToSt()
	if validHere("水塘") then
		return true
	end
	if not validHere("竹林") then
		return false
	end
	wait(500)
	findInZl()
	e("wd")
	return zlToSt()
end

function findInZl()
	local exits = {
		east = true,
		west = true,
		south = true,
		north = true,
	}
	randomMove(exits)
end

function mzRoom()
	local mzRoom = {}
	hide("set look")
	e("l")
	set("mzRoom")
	while true do
		addListener([[^【你现在正处于(\S+)】$]],"s:return 'city',wildcards[1]","mzRoom")
		addListener([[^四处遍地都是梅树，枝叶茂密地连天空都被遮住了，很难看清周围的情况。$]],"s:return 'north', true","mzRoom")
		addListener([[^是一个大庄院。四处遍地都是梅树，枝叶茂密地连天空都被遮住了，很难看清$]],"s:return 'south', true","mzRoom")
		addListener([[^(\S+) - $]],"s:return 'name',wildcards[1]","mzRoom")
		addListener([[^(?:    这里没有任何明显的出路|    这里唯一的出口是 (\S+)|    这里明显的出口是 (.+))。$]],"OnExits","mzRoom")
		addSetListener("mzRoom","mzRoom")
		local k,v = listen()
		if k == "mzRoom" then
			break
		else
			mzRoom[k] = v
		end
	end
	return mzRoom
end

function outThd()
	if getParty() == "桃花岛" then
		local _hp = hp()
		if _hp.shen > 180000 then
			e("ask huang about 教诲")
			waitbusy()
		end
	end
	e("ask huang about 离岛")
	waitbusy()
end

function outMl(way)
	local places = {
		north = "south",
		south = "north",
		east = "west",
		west = "east",
	}
	way = places[way]
	local place = way
	while true do
		local _here = mzRoom()
		if _here.name == "梅林" then
			direction = getNextWay(_here, place, way)
			e(direction)
			place = places[direction]
			--wait(200)
		else
			break
		end
	end
end

function getNextWay(_here, direction, ignoreExit)
	local exits = _here.exits
	local ways = {
		north = "east",
		east = "south",
		south = "west",
		west = "north",
	}
	local goalExit = ways[ways[ignoreExit]]
	while true do
		direction = ways[direction]
		if exits[direction] then
			if direction == goalExit and _here[goalExit] then
				return goalExit
			end
			if direction ~= ignoreExit then
				return direction
			elseif not _here[ignoreExit] then
				return direction
			end
		end
	end
end

function toSc()
	local _here = here()
	local _around = around(_here.exits)
	for exit, room in pairs(_around) do
		if room.name == "树林深处" then
			e(exit)
			return
		end
	end
end

function toXcm()
	local _i = i()
	local cutweapon = getCutweapon()
	if _i[cutweapon] == 0 then
		while true do
			if getMujian() then
				return toXcm()
			else
				wait(5000)
			end
		end
	end
	go("百丈涧", "天山")
	unwieldWeapon()
	waitbusy()
	wieldCutweapon()
	e("zhan tielian")
	waitbusy()
	unwieldCutweapon()
	waitbusy()
	wieldWeapon()
	e("jump duimian")
	waitbusy()
end

function getMujian()
	local _i = i()
	if _i.silver < 50 and _i.gold == 0 then
		go("天阁斋")
		money(0,50)
	end
	go("木匠铺", "襄阳城")
	e("get mu jian")
	e("buy mu jian")
	waitbusy()
	local _i = i()
	if _i["mu jian"] > 0 then
		return true
	else
		db()
		wait(10000)
		getMujian()
	end
end

function getMudao()
	go("武器库", "少林寺")
	e("get mu dao")
	e("ask daochen chanshi about 木刀")
	waitbusy()
	local _i = i()
	if _i["mu dao"] > 0 then
		return true
	else
		local id = getId("道尘禅师")
		if not id then
			return false
		else
			db()
			e("kill daochen chanshi")
			addListener("^道尘禅师「啪」的一声倒在地上，挣扎着抽动了几下就死了。$", nil, "mudao")
			addListener("^这里没有这个人。$", nil, "mudao")
			listen()
		end
	end
end

function getMrCj()
	go("杂货室", "曼佗罗山庄")
	e("na jian from jia")
	addListener("你从兵器架上拿出一件长剑。$", "s:return true", "mr")
	addListener("你已经拿过了。$", "s:return false", "mr")
	if not listen() then
		e("quit")
		return false
	else
		return true
	end
end

function outSld()
	if not stealLingpai() then
		return false
	end
	go("渡口", "神龙岛")
	e("give ling pai to chuan fu")
	local result = listener("^你轻轻一跃，上了小船。$", nil, nil, 30, function() return "timeout" end)
	if result == "timeout" then
		return outSld()
	end
	e("order 开船")
	listener("^你轻轻一跃，下了船。$")
end

function stealLingpai()
	if not validHere("陆府正厅") then
		return false
	end
	e("steal lingpai")
	addListener("^你已经有了令牌，还偷它作甚？$", "s:return true", "ling")
	addListener("^你成功地偷到了块通行令牌!$", "s:return true", "ling")
	addListener([[^陆高轩一脚把\S+踢了出去！$]], "s:return false", "ling")
	local result = listen()
	if result then
		return true
	else
		e("h;r")
		wait(500)
		return stealLingpai()
	end
end

function toSld()
	if not validHere("海滩") then
		return false
	end
	local _i = i()
	local cutweapon = getCutweapon()
	if _i[cutweapon] == 0 then
		while true do
			if getMujian() then
				go("海滩", "神龙岛")
				return toSld()
			else
				wait(5000)
			end
		end
	end
	if _i["cu shengzi"] == 0 then
		if _i.silver < 50 then
			go("钱庄", "塘沽城")
			money(0, 50)
			go("海滩", "神龙岛")
		end
		e("get cu shengzi;buy cu shengzi")
		wait(1000)
		return toSld()
	end
	unwieldWeapon()
	waitbusy()
	wieldCutweapon()
	e("chop tree")
	unwieldCutweapon()
	waitbusy()
	wieldWeapon()
	e("bang mu tou;zuo mufa")
	addListener("^木筏还没扎结实，等下再坐吧。$", "s:return false", "mf")
	addListener("^只见你轻轻一跃，已坐在木筏上。$", "s:return true", "mf")
	local result = listen(2, function() return "timeout" end)
	if not result or result == "timeout "then
		return toSld()
	end
	huaMufa()
	listener("^你回头一看，小木筏撞得散架，沉到海里了。$")
end

function huaMufa()
	e("hua mufa")
	set("sld")
	addListener("^你拿起木筏上的一根木头，将木筏向前划去。$", "s:return 'hua'", "sld")
	addSetListener("sld", "sld")
	if listen() == "sld" then
		return true
	else
		listener("^小木筏顺着海风，一直向东飘去。$")
		return huaMufa()
	end
end

function outSsl()
	if not validHere("松树林") then
		return false
	end
	while true do
		e("n;e;e;e;e")
		wait(400)
		if validHere("石屋") then
			return true
		end
	end
end

function toQc()
	if not validHere("沙漠") then
		return false
	end
	e("n;n")
	for i=0, 20 do
		e("#10 e")
		local _here = here()
		if validHere("青城") then
			return true
		end
		e("n")
		wait(1000)
	end
	--quit()
	return false
end

function hsToQyg()
	e("move stone")
	addListener("^你双膀较劲，搬开了大石头。$", "s:return true", "move")
	addListener("^你使尽了吃奶的力气，也没搬开大石头。$", "s:return false", "move")
	local result = listen()
	if result then
		e("nd")
	else
		hsToQyg()
	end
end

function enterJqg()
	if not validHere("小溪边") then
		return false
	end
	e("l boat;jump boat")
	listener("^又划出三四里，溪心忽有九块大石迎面耸立，犹如屏风一般，挡住了来船去路。$")
	e("out")
end

function outJqg()
	if not validHere("独峰岭") then
		return false
	end
	waitperform()
	unwieldWeapon()
	e("tui boat;jump boat")
	wieldWeapon()
	listener("^又划出三四里，溪流曲折，小舟经划过了几个弯后又回到溪边。$")
	e("out")
end

function outJld()
	e("leave")
	addListener([[^你像没头苍蝇一样在洞里瞎钻，结果一头撞在洞壁上。\n你觉得你晕乎乎的，似乎撞傻了。$]], "s:return false", "outJld")
	addListener([[^你转来转去，终于转到了洞口。$]], "s:return true", "outJld")
	if listen() then
		return true
	else
		return outJld()
	end
end

function yzwToSz()
	if not validHere("岸边") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "yzwToSz")
	addSetListener("boat", "yzwToSz")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		yzwToSz()
	else
		listener([[^艄公说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。$]])
		e("out")
	end
end

function szToXz()
	e("qu xiaozhu")
	addListener("^你在口袋里翻来覆去地找船钱。$", "s:return 'ok'", "szToXz")
	addListener("^穷光蛋，一边呆着去！$", "s:return 'nomoney'", "szToXz")
	local result = listen()
	if result == "nomoney" then
		log.error("没钱坐船从慕荣回去了，找人送钱吧")
	end
	listener("^船夫把小舟靠在岸边，快下船吧。$")
	e("out")
end

function szToYzw()
	e("qu yanziwu")
	addListener("^你在口袋里翻来覆去地找船钱。$", "s:return 'ok'", "szToXz")
	addListener("^穷光蛋，一边呆着去！$", "s:return 'nomoney'", "szToXz")
	local result = listen()
	if result == "nomoney" then
		log.error("没钱坐船从慕荣回去了，找人送钱吧")
	end
	listener("^船夫把小舟靠在岸边，快下船吧。$")
	e("out")
end

function xzToSz()
	if not validHere("听雨居") then
		return false
	end
	e("play qin")
	listener("^终于到了岸边，船夫把小舟靠在岸边，快下船吧。$")
	e("out")
end

function outXz()
	if not validHere("小岛边") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "outXz")
	addSetListener("boat", "outXz")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		outXz()
	else
		addListener([[^艄公说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。$]], nil, "xz")
		addListener([[^艄公轻声说道：“都下船吧，我也要回去了。”$]], nil, "xz")
		listen()
		e("out")
	end
end

function outYzw()
	if not validHere("岸边") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "outYzw")
	addSetListener("boat", "outYzw")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		outYzw()
	else
		addListener([[^艄公说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。$]], nil, "yzw")
		addListener([[^艄公轻声说道：“都下船吧，我也要回去了。”$]], nil, "yzw")
		listen()
		e("out")
	end
end

function quMr()
	if not validHere("码头") then
		return false
	end
	local _i = i()
	if _i.silver < 20 then
		go("聚宝斋", "苏州城")
		money(0, 20)
		go("码头", "姑苏慕容")
	end
	e("qu mr")
	addListener("^你在口袋里翻来覆去地找船钱。$", "s:return 'ok'", "quMr")
	addListener("^穷光蛋，一边呆着去！$", "s:return 'nomoney'", "quMr")
	local result = listen()
	if result == "nomoney" then
		return quMr()
	end
	listener("^终于到了小岛边，船夫把小舟靠在岸边，快下船吧。$")
	e("out")
end

function quYzw()
	if not validHere("码头") then
		return false
	end
	local _i = i()
	if _i.silver < 20 then
		go("聚宝斋", "苏州城")
		money(0, 20)
		go("码头", "姑苏慕容")
	end
	e("qu yanziwu")
	addListener("^你在口袋里翻来覆去地找船钱。$", "s:return 'ok'", "quYzw")
	addListener("^穷光蛋，一边呆着去！$", "s:return 'nomoney'", "quYzw")
	local result = listen()
	if result == "nomoney" then
		return quYzw()
	end
	listener("^船夫把小舟靠在岸边，快下船吧。$")
	e("out")
end

function outcd()
	waitbusy()
	local _hp = hp()
	if _hp.jingli <= 100 then
		e("yun jingli")
		wait(500)
		outcd()
	else
		e("#4 n")
		set("outcd")
		addListener("^你乱走了一通，居然发现自己走回了原地。$", "s:return true", "outcd")
		addSetListener("outcd", "outcd")
		if listen() == "outcd" then
			outcd()
		end
	end
end

function findZyl()
	local ways = {"e", "s", "n", "w"}
	local _, way = randomGet(ways)
	e(way)
end

function outJjl()
	local _here = here()
	if _here.name == "山中小溪" then
		return true
	end
	if _here.name == "山路" then
		wait(500)
		e("s")
		return outJjl()
	end
end

function outZyl()
	if here().name ~= "针叶林" then
		return false
	end
	local _hp = hp()
	if _hp.jingli < 100 then
		e("yun jingli")
		outZyl()
	else
		wait(1000)
		e("#10 w;#10 e;#10 n;#10 s")
		set("outzyl")
		addListener("^你累得半死，终於找到了正确的方向。$", "s:return 'ok'", "outzyl")
		addSetListener("outzyl", "outzyl")
		local result = listen()
		wait(2000)
		if result == "ok" then
			return true
		else
			return outZyl()
		end
	end
end

function outTssd()
	if here().name ~= "山道" then
		return false
	else
		wait(500)
		e("e")
		set("outtssd")
		addListener("^你喃喃骂道：「这灯可有点儿邪门。」$", "s:return 'ok'", "outtssd")
		addSetListener("outtssd", "outtssd")
		local result = listen()
		if result == "ok" then
			return true
		else
			return outTssd()
		end
	end
end

function tianMen()
	mjMen("n", "天字门")
end

function leiMen()
	mjMen("n", "雷字门")
end

function diMen()
	mjMen("s", "地字门")
end

function fengMen()
	mjMen("s", "风字门")
end

function outzsl()
	while true do
		e("nw;w")
		local _here = here()
		if _here.name == "锐金旗" then
			e("#3 s")
			_here = here()
		end
		if _here.name == "洪水旗" then
			return true
		end 
		if _here.name ~= "紫杉林"
			and _here.name ~= "天字门"
			and _here.name ~= "地字门"
			and _here.name ~= "风字门"
			and _here.name ~= "雷字门" then
			return false
		end
		wait(300)
	end
end

function mjMen(way, name)
	while true do
		local _hp = hp()
		if _hp.jingli < 100 then
			if _hp.neili >= 20 then
				e("yun jingli")
			else
				wait(2000)
			end
		else
			e("se;#20 " .. way)
			local here = here()
			if here.name == name then
				return true
			end
			wait(1000)
		end
	end
end

function passGb()
	if getExp() > 30000 then
		return pass("guan bing")
	else
		wait(2000)
	end
end

function pass(...)
	local id = table.concat({...}," ")
	while true do
		e("compare " .. id)
		addListener([[^你仔细的上前打量了(\S+)一番。\n.+\n你以本身修为判断\1(?:的)?江湖历练大约是(\S+)的级数。$]], "s:return wildcards[1], wildcards[2]", "pass")
		addListener("^" .. id .. [[ 不在这里$]], "s:return false", "pass")
		local name, level = listen(30)
		if name then
			local pfm = level ~= "超级菜鸟肉脚"
			passKill(id, name, pfm)
		else
			return true
		end
	end
end

function passKill(id, name, pfm)
	if not pfm then
		noPerform()
	end
	e("kill " .. id)
	if pfm then
		perform(id)
	end
	addListener("^" .. name .. [[神志迷糊，脚下一个不稳，倒在地上昏了过去。$]], "s:return 'faint'", "pass")
	addListener("^" .. name .. [[「啪」的一声倒在地上，挣扎着抽动了几下就死了。$]], "s:return 'die'", "pass")
	addListener("^" .. name .. [[往\S+的\S+落荒而逃了。$]], "s:return 'away'", "pass")
	addListener("^" .. name .. [[悲鸣数声，足步迅捷异常，行走疾如奔马往深谷中走去。$]], "s:return 'away'", "pass")
	local result = listen()
	if result == "die" then
		e("get silver from corpse;get gold from corpse")
	elseif result == "faint" then
		passKill(id, name)
	end
end

function fly(cmd)
	if isPk() then
		listener("haha")
	end
	e(cmd)
	addListener("^你带这么重的包袱，走路都成问题，别说飞了！$", "s:return 'boat'", "fly")
	addListener("^这里的水太深太急，你渡不过去。$", "s:return 'boat'", "fly")
	addListener("^有竹篓就坐上去吧。$", "s:return 'wait'", "fly")
	addListener("^有船不坐，你想扮Cool啊？$", "s:return 'wait'", "fly")
	addListener("^(江|河)面太宽了，如果没有中途借力的地方根本没法飞越过去！$", "s:return 'wait'", "fly")
	addListener("^峭壁实在太陡了，如果没有中途借力的地方根本没法纵身(上|下)去！$", "s:return 'wait'", "fly")
	addListener([[^你在(江|黄河|河)中渡船上轻轻一点，又提气飞纵向\S+岸。$]], "s:return 'ok'", "fly")
	addListener([[^你一提内息，看准了崖间竹篓位置，使出「纵字诀」，想要飞身(上|下)崖。$]], "s:return 'ok'", "fly")
	local result = listen()
	if result == "ok" then
		waitbusy()
		return "ok"
	elseif result == "wait" then
		--wait(1000)
		return "wait"
	else
		return false
	end
end

function xxdk(locate)
	if not validHere("西夏渡口") then
		return false
	end
	local _hp = hp()
	e("yun jingli")
	if getJifaDodge() >= 250 and getMaxNeili() >= 3000 and _hp.neili > 900 and _hp.jingli > 1000 and not isPk() then
		local result = fly("duhe")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return xxdk(locate)
		end
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return 'ok'", "xxdk")
	addListener("^你掏了掏腰包，却发现身上带的钱不够了。$","s:return 'nomoney'","xxdk")
	addSetListener("boat","xxdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		xxdk(locate)
	elseif result == "nomoney" then
		if locate == "nw" then
			go("威信钱庄")
			money(0,5)
			go("lanzhou/road2")
			xxdk(locate)
		else
			go("天阁斋分店")
			money(0,5)
			go("lanzhou/road3")
			xxdk(locate)
		end
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out")
	end
end

function lzdk(locate)
	if not validHere("大渡口") then
		return false
	end
	local _hp = hp()
	e("yun jingli")
	if getJifaDodge() >= 250 and getMaxNeili() >= 3000 and _hp.neili > 900 and _hp.jingli > 1000 and not isPk() then
		local result = fly("duhe")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return lzdk(locate)
		end
	end
	e("yell boat;r")
	set("boat")
	addListener("^你掏出一两白银递给船家，纵身跃上了渡船。$","s:return 'ok'","lzdk")
	addListener("^你掏了掏腰包，却发现身上带的钱不够了。$","s:return 'nomoney'","lzdk")
	addSetListener("boat","lzdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		lzdk(locate)
	elseif result == "nomoney" then
		if locate == "w" then
			go("威信钱庄")
			money(0,5)
			go("lanzhou/road2")
			lzdk(locate)
		else
			go("天阁斋分店")
			money(0,5)
			go("lanzhou/road3")
			lzdk(locate)
		end
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out")
	end
end

function hhdk(locate)
	if not validHere("大渡口") then
		return false
	end
	local _hp = hp()
	e("yun jingli")
	if getJifaDodge() >= 250 and getMaxNeili() >= 3000 and _hp.neili > 900 and _hp.jingli > 1000 and not isPk() then
		local result = fly("duhe")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return hhdk(locate)
		end
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return 'ok'", "hhdk")
	addListener("^你掏了掏腰包，却发现身上带的钱不够了。$","s:return 'nomoney'","hhdk")
	addSetListener("boat","hhdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		hhdk(locate)
	elseif result == "nomoney" then
		if locate == "n" then
			go("天阁斋")
			money(0,5)
			go("huanghe/road2")
			hhdk(locate)
		else
			go("天音阁")
			money(0,5)
			go("huanghe/road3")
			hhdk(locate)
		end
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out")
	end
end

function sjdk(locate)
	if not validHere("陕晋渡口") then
		return false
	end
	local _hp = hp()
	e("yun jingli")
	if getJifaDodge() >= 250 and getMaxNeili() >= 3000 and _hp.neili > 900 and _hp.jingli > 1000 and not isPk() then
		local result = fly("duhe")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return sjdk(locate)
		end
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return 'ok'", "sjdk")
	addListener("^你掏了掏腰包，却发现身上带的钱不够了。$", "s:return 'nomoney'", "sjdk")
	addSetListener("boat", "sjdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		sjdk(locate)
	elseif result == "nomoney" then
		if locate == "n" then
			go("威信钱庄")
			money(0,5)
			go("huanghe/road2")
			sjdk(locate)
		else
			go("天音阁")
			money(0,5)
			go("huanghe/road3")
			sjdk(locate)
		end
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out")
	end
end

function cj(nowait)
	local _here = here()
	if _here.name ~= "长江南岸" and _here.name ~= "长江北岸" then
		return false
	end
	local _hp = hp()
	e("yun jingli")
	if getJifaDodge() >= 250 and getMaxNeili() >= 3500 and _hp.neili >= 1300 and _hp.jingli >= 1350 and not isPk() then
		local result = fly("dujiang")
		if result == "ok" then
			return true
		elseif result == "wait" then
			if dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) or tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			end
			return cj(true)
		end
	end
	if not nowait then
		wait(2000)
	end
	e("yell boat;r;w;yell boat;r;#2 e;yell boat;r;w;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "cj")
	addSetListener("boat", "cj")
	if listen() == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		cj(true)
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out;#2 w;e")
	end
end

function lcj()
	if not validHere("澜沧江边") then
		return false
	end
	local _hp = hp()
	if getJifaDodge() >= 270 and getMaxNeili() >= 3500 and _hp.neili >= 1300 and _hp.jingli >= 1350 then
		local result = fly("dujiang")
		if result == "ok" then
			return true
		elseif result == "wait" then
			return lcj()
		end
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^这里不准战斗，也不准吐纳。$", "s:return true", "lcj")
	addSetListener("boat", "lcj")
	if listen() == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		lcj()
	else
		listener([[^说着将一块踏脚板搭上堤岸，形成一个出去\(out\)的阶梯。$]])
		e("out")
	end
end

function getJinhe(i)
	i = i or 1
	e("l jin he " .. i)
	addListener([[^你可以检查\(jiancha\)它，看看里面有什么秘密。$]], "s:return false", "jinhe")
	addListener([[^你要看什么？$]], "s:return 'no'", "jinhe")
	addListener([[^吾纵横江湖时曾在(\S+)留下些许物事，待有缘人前去挖掘\(dig\)。$]], "s:return wildcards[1]", "jinhe")
	local addr = listen()
	if addr == "no" then
		return false
	end
	if not addr then
		e("#5 jiancha jinhe")
		wait(1000)
		return getJinhe(i)
	end
	local name, city = getAddr(addr)
	if not name or not find(name, city, 0, true, "all", digJinhe) then
		return getJinhe(i + 1)
	end
end

function digJinhe()
	e("dig")
	set("dig")
	addListener("^地上多了一个古绣斑斑的铁盒子，你趁人不注意，迅速把铁盒喘入怀中。$", "s:return false", "dig")
	addSetListener("dig", "dig")
	return not listen()
end

function validHere(name)
	local _here = here()
	return _here.name == name
end

function OnFightRoom(name, line, wildcards)
	run(leaveFightRoom)
end

function leaveFightRoom()
	wait(5000)
	randomMove(here().exits)
	init()
end

function goNongtian()
local signs = {
		["\\\#\\\* \\\*\\\#  \\\\\\\#\\\\"] = "n",
		["\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\%\\\% "] = "w",
		["\\\*  \\\*  \\\*"] = "s",
		["\\\*\\\#\\\# \\\*  \\\*\\\#"] = "s",
		["\\\*\\\#\\\*\\\#\\\*\\\#\\\*\\\*"] = "n",
		["\\\*\\\*  \\\*\\\* \\\*\\\\\\\\"] = "n",
		["\\\*\\\* \\\/\\\/   \\\-\\\-\\\-\\\-\\\-\\\-"] = "w",
		["\\\*\\\*\\\*  \\\*\\\*"] = "s",
		["\\\*\\\*\\\*\\\*   \\\\\\\\"] = "n",
		["\\\*\\\*\\\*\\\*\\\*\\\*\\\*    \\\*\\\*"] = "e",
		["\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\#\\\#\\\#"] = "e",
		["\\\*\\\*\\\*\\\*\\\*\\\*--\\\*\\\*\\\*\\\*\\\*\\\.\\\.\\\*"] = "e",
		["\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\/"] = "e",
		["\\\*\\\*\\\*\\\*\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-"] = "w",
		["\\\/\\\*\\\*\\\* \\\\\\\\\\\*\\\*      \\\*\\\*"] = "n",
		["\\\\   \\\* \\\/\\\/"] = "s",
		["\\\\  \\\|     \\\-\\\-"] = "s",
		["\\\\ \\\|  \\\/\\\/"] = "s",
		["\\\\\\\\\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*\\\*"] = "w",
		["\\\\\\\-\\\-\\\-    \\\-\\\-\\\-\\\-\\\-\\\-"] = "w",
		["\\\-\\\-\\\-   \\\/\\\/ \\\\\\\\    \\\|"] = "n",
		["\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\-\\\/"] = "e"
	}
	local go
	while true do
		set("lookSign")
		e("l sign")
		for match, path in pairs(signs) do
			--print(match)
			addListener(match, "s:return '".. path ..  "'", "lookSign")
		end
		addSetListener("lookSign","lookSign")
		local result = listen()
		if result ~= "lookSign" then
			print(result)
			break
		end
		wait(2000)
	end
end

function guessNum()
	e("ask liu about question")
	waitbusy()
	e("guess 7123;guess 4271;guess 2634;guess 4217;guess 7354;guess 7216;guess 1426;w")
	set("guessNum")
	addListener([[^刘好弈在墙上按了几下，道：“好了，你可以进书房去了。”$]], "s:return true", "guessNum")
	addSetListener("guessNum", "guessNum")
	if listen() then
		return true
	else
		return guessNum()
	end
end

function hhb()
	go("大渡口", "兰州城")
end

function gbkl()
	go("后院", "丐帮")
	e("ask hong qigong about 叫化鸡")
	while not find("南丁字街", "襄阳城", 5, "武修文") do
	end
	e("ask wu xiuwen about 叫化鸡")
	while not find("书院", "扬州城", 4, "空空儿") do
	end

	e("follow kong;ask kong about 叫化鸡")
	waitbusy()
	e("give kong 11 gold")
	gbkl()
end