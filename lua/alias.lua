
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
	if not validHere("����") then
		return false
	end
	e("#12 s")
	wait(1500)
	if validHere("����") then
		return true
	else
		return outGb()
	end
end

function outTssd()
	if not validHere("ɽ��") then
		return false
	end
	e("#10 e")
	wait(1500)
	if validHere("ɽ��") then
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
			addListener([[^  (\S+)��ͭǮ\(Coin\)$]], "s:return trans(wildcards[1])", "coin")
			addListener([[^�趨����������coin = "]] .. way .. [["]], "s:return 0", "coin")
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
		if here().name == "СԺ" then
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
		go("������")
		local id = getId("������ʦ")
		if not id then
			wait(2000)
			return goYd()
		end
		e("ask fangsheng dashi about �ӹ�")
		waitbusy()
		e("ask fangsheng dashi about ����")
		waitbusy()
		go("����ƺ")
	end
	e("gou naogou;shuai taosuo;pa up")
	set("yd")
	addListener("^��������е��ӹ�������ʩչ�Ṧ������ȥ��$", "s:return false", "yd")
	addSetListener("yd", "yd")
	if listen() then
		log.error("ȥ����������ʦʧ��")
	end
end

function goHt()
	local id = getId("����ֹ")
	if not id then
		wait(2000)
		return goHt()
	end
	e("ask gongsun zhi about �����")
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
	if not validHere("����") then
		return false
	end
	local ways = {"e", "s", "n", "w"}
	local _, way = randomGet(ways)
	e(way)
	e("n;e;n;e;w;s;n;s;s;n")
	local _here = here()
	_here.exits = around(_here.exits)
	wait(2000)
	if _here.exits["south"].name == "ɽ·" then
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
	if _here.name ~= "����" then
		return false
	end
	randomMove(_here.exits)
	local exits = {"e", "s", "n", "w"}
	for i=1,5 do
		local _, exit = randomGet(exits)
		e(exit)
	end
	e("nw;n")
	if validHere("��Ħ��") then
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
		e("ask di yun about �뿪")
		waitbusy()
		e("jump up")
		waitbusy()
	end
end

function outTlsSsl()
	local _here = here()
	if _here.name ~= "������" and _here.name ~= "ʯ��·" then
		return false
	end
	e("s;w;s;w")
	e("#11 s")
	wait(2000)
	if not validHere("�껨��") then
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
	if validHere("С����") then
		return true
	end
	e("w;e")
	return toXdt0(n + 1)
end

function toRyp()
	if not validHere("ʯ��") then
		return false
	end
	local id = getId("�ֲ�")
	if id then
		e("whisper jia �����ĳ���£�һͳ����")
		e("whisper jia ����ǧ�����أ�һͳ����")
		e("whisper jia ��������Ϊ������������")
		e("whisper jia ������ּӢ���������Ų�")
		e("whisper jia �����������£��츣����")
		e("whisper jia ����ս�޲�ʤ�����޲���")
		e("whisper jia ��������ĳ���¡�����Ӣ��")
		e("whisper jia ��������ʥ�̣��󱻲���")
		e("wu")
		if validHere("����ƺ") then
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
	if _here.name ~= "����ƺ" and _here.name ~= "�¶�" then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "hmy")
	addSetListener("hmy", "hmy")
	if listen() == "hmy" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		hmy(locate)
	else
		listener([[^��¨���˼��£���һ��ʯ��֮��ͣ��������$]])
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
		addListener("����Ժ", "s:return 'ok'", "outtl")
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
		if validHere("��ʥ��") then
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
	if validHere("�����") then
		return true
	end
	e("n")
	return wdSqd(i+1)
end

function wdYm()
	if not validHere("С��") then
		return false
	end
	e("s")
	return wdYm0()
end

function wdYm0()
	if validHere("Ժ��") then
		return true
	end
	local ways = {
		["��"] = "east",
		["��"] = "south",
		["��"] = "west",
		["��"] = "north",
	}
	local result = listener([[^��վ��С���ϣ����ܴ������·𿴼�(\S+)����Щ���⡣$]], "s:return wildcards[1]")
	e(ways[result])
	return wdYm0()
end

function outJgSq()
	outJg()
	if validHere("��ʯ��") then
		return true
	else
		return go("��ʯ��", "����ׯ")
	end
end

function outJgZq()
	outJg()
	if validHere("����ׯǰ") then
		return true
	else
		return go("����ׯǰ", "����ׯ")
	end
end

function outJg()
	local _here = here()
	if _here.name == "����ׯǰ" or _here.name == "��ʯ��" then
		return true
	end
	if not validHere("�Ź��һ���") then
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
	addListener([[^    ����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵�����(\S+)���һ�\(taohua\)��$]],"s:return wildcards[1]", "taohua")
	addListener([[^    ����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵���һ���һ�\(taohua\)Ҳû�С�$]],"s:return false", "taohua")
	local result = listen()
	if result then
		e("get " .. trans(result) .. " taohua")
	end
end

function stToSd()
	if not validHere("ˮ��") then
		return false
	end
	e("eu")
	if validHere("ɽ��ƽ��") then
		return true
	elseif validHere("����") then
		zlToSt()
		return stToSd()
	else
		return false
	end
end

function zlToSt()
	if validHere("ˮ��") then
		return true
	end
	if not validHere("����") then
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
		addListener([[^��������������(\S+)��$]],"s:return 'city',wildcards[1]","mzRoom")
		addListener([[^�Ĵ���ض���÷����֦Ҷï�ܵ�����ն�����ס�ˣ����ѿ�����Χ�������$]],"s:return 'north', true","mzRoom")
		addListener([[^��һ����ׯԺ���Ĵ���ض���÷����֦Ҷï�ܵ�����ն�����ס�ˣ����ѿ���$]],"s:return 'south', true","mzRoom")
		addListener([[^(\S+) - $]],"s:return 'name',wildcards[1]","mzRoom")
		addListener([[^(?:    ����û���κ����Եĳ�·|    ����Ψһ�ĳ����� (\S+)|    �������Եĳ����� (.+))��$]],"OnExits","mzRoom")
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
	if getParty() == "�һ���" then
		local _hp = hp()
		if _hp.shen > 180000 then
			e("ask huang about �̻�")
			waitbusy()
		end
	end
	e("ask huang about �뵺")
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
		if _here.name == "÷��" then
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
		if room.name == "�����" then
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
	go("���ɽ�", "��ɽ")
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
		go("���ի")
		money(0,50)
	end
	go("ľ����", "������")
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
	go("������", "������")
	e("get mu dao")
	e("ask daochen chanshi about ľ��")
	waitbusy()
	local _i = i()
	if _i["mu dao"] > 0 then
		return true
	else
		local id = getId("������ʦ")
		if not id then
			return false
		else
			db()
			e("kill daochen chanshi")
			addListener("^������ʦ��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$", nil, "mudao")
			addListener("^����û������ˡ�$", nil, "mudao")
			listen()
		end
	end
end

function getMrCj()
	go("�ӻ���", "��٢��ɽׯ")
	e("na jian from jia")
	addListener("��ӱ��������ó�һ��������$", "s:return true", "mr")
	addListener("���Ѿ��ù��ˡ�$", "s:return false", "mr")
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
	go("�ɿ�", "������")
	e("give ling pai to chuan fu")
	local result = listener("^������һԾ������С����$", nil, nil, 30, function() return "timeout" end)
	if result == "timeout" then
		return outSld()
	end
	e("order ����")
	listener("^������һԾ�����˴���$")
end

function stealLingpai()
	if not validHere("½������") then
		return false
	end
	e("steal lingpai")
	addListener("^���Ѿ��������ƣ���͵��������$", "s:return true", "ling")
	addListener("^��ɹ���͵���˿�ͨ������!$", "s:return true", "ling")
	addListener([[^½����һ�Ű�\S+���˳�ȥ��$]], "s:return false", "ling")
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
	if not validHere("��̲") then
		return false
	end
	local _i = i()
	local cutweapon = getCutweapon()
	if _i[cutweapon] == 0 then
		while true do
			if getMujian() then
				go("��̲", "������")
				return toSld()
			else
				wait(5000)
			end
		end
	end
	if _i["cu shengzi"] == 0 then
		if _i.silver < 50 then
			go("Ǯׯ", "������")
			money(0, 50)
			go("��̲", "������")
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
	addListener("^ľ����û����ʵ�����������ɡ�$", "s:return false", "mf")
	addListener("^ֻ��������һԾ��������ľ���ϡ�$", "s:return true", "mf")
	local result = listen(2, function() return "timeout" end)
	if not result or result == "timeout "then
		return toSld()
	end
	huaMufa()
	listener("^���ͷһ����Сľ��ײ��ɢ�ܣ����������ˡ�$")
end

function huaMufa()
	e("hua mufa")
	set("sld")
	addListener("^������ľ���ϵ�һ��ľͷ����ľ����ǰ��ȥ��$", "s:return 'hua'", "sld")
	addSetListener("sld", "sld")
	if listen() == "sld" then
		return true
	else
		listener("^Сľ��˳�ź��磬һֱ��Ʈȥ��$")
		return huaMufa()
	end
end

function outSsl()
	if not validHere("������") then
		return false
	end
	while true do
		e("n;e;e;e;e")
		wait(400)
		if validHere("ʯ��") then
			return true
		end
	end
end

function toQc()
	if not validHere("ɳĮ") then
		return false
	end
	e("n;n")
	for i=0, 20 do
		e("#10 e")
		local _here = here()
		if validHere("���") then
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
	addListener("^��˫��Ͼ����Ὺ�˴�ʯͷ��$", "s:return true", "move")
	addListener("^��ʹ���˳��̵�������Ҳû�Ὺ��ʯͷ��$", "s:return false", "move")
	local result = listen()
	if result then
		e("nd")
	else
		hsToQyg()
	end
end

function enterJqg()
	if not validHere("СϪ��") then
		return false
	end
	e("l boat;jump boat")
	listener("^�ֻ��������Ϫ�ĺ��оſ��ʯӭ����������������һ�㣬��ס������ȥ·��$")
	e("out")
end

function outJqg()
	if not validHere("������") then
		return false
	end
	waitperform()
	unwieldWeapon()
	e("tui boat;jump boat")
	wieldWeapon()
	listener("^�ֻ��������Ϫ�����ۣ�С�۾������˼�������ֻص�Ϫ�ߡ�$")
	e("out")
end

function outJld()
	e("leave")
	addListener([[^����ûͷ��Ӭһ���ڶ���Ϲ�꣬���һͷײ�ڶ����ϡ�\n��������κ����ģ��ƺ�ײɵ�ˡ�$]], "s:return false", "outJld")
	addListener([[^��ת��תȥ������ת���˶��ڡ�$]], "s:return true", "outJld")
	if listen() then
		return true
	else
		return outJld()
	end
end

function yzwToSz()
	if not validHere("����") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "yzwToSz")
	addSetListener("boat", "yzwToSz")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		yzwToSz()
	else
		listener([[^����˵���������ϰ��ɡ����漴��һ��̤�Ű���ϵ̰���$]])
		e("out")
	end
end

function szToXz()
	e("qu xiaozhu")
	addListener("^���ڿڴ��﷭����ȥ���Ҵ�Ǯ��$", "s:return 'ok'", "szToXz")
	addListener("^��⵰��һ�ߴ���ȥ��$", "s:return 'nomoney'", "szToXz")
	local result = listen()
	if result == "nomoney" then
		log.error("ûǮ������Ľ�ٻ�ȥ�ˣ�������Ǯ��")
	end
	listener("^�����С�ۿ��ڰ��ߣ����´��ɡ�$")
	e("out")
end

function szToYzw()
	e("qu yanziwu")
	addListener("^���ڿڴ��﷭����ȥ���Ҵ�Ǯ��$", "s:return 'ok'", "szToXz")
	addListener("^��⵰��һ�ߴ���ȥ��$", "s:return 'nomoney'", "szToXz")
	local result = listen()
	if result == "nomoney" then
		log.error("ûǮ������Ľ�ٻ�ȥ�ˣ�������Ǯ��")
	end
	listener("^�����С�ۿ��ڰ��ߣ����´��ɡ�$")
	e("out")
end

function xzToSz()
	if not validHere("�����") then
		return false
	end
	e("play qin")
	listener("^���ڵ��˰��ߣ������С�ۿ��ڰ��ߣ����´��ɡ�$")
	e("out")
end

function outXz()
	if not validHere("С����") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "outXz")
	addSetListener("boat", "outXz")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		outXz()
	else
		addListener([[^����˵���������ϰ��ɡ����漴��һ��̤�Ű���ϵ̰���$]], nil, "xz")
		addListener([[^��������˵���������´��ɣ���ҲҪ��ȥ�ˡ���$]], nil, "xz")
		listen()
		e("out")
	end
end

function outYzw()
	if not validHere("����") then
		return false
	end
	e("yell boat;r;tuna")
	set("boat")
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "outYzw")
	addSetListener("boat", "outYzw")
	if listen() == "boat" then
		local _hp = hp()
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		outYzw()
	else
		addListener([[^����˵���������ϰ��ɡ����漴��һ��̤�Ű���ϵ̰���$]], nil, "yzw")
		addListener([[^��������˵���������´��ɣ���ҲҪ��ȥ�ˡ���$]], nil, "yzw")
		listen()
		e("out")
	end
end

function quMr()
	if not validHere("��ͷ") then
		return false
	end
	local _i = i()
	if _i.silver < 20 then
		go("�۱�ի", "���ݳ�")
		money(0, 20)
		go("��ͷ", "����Ľ��")
	end
	e("qu mr")
	addListener("^���ڿڴ��﷭����ȥ���Ҵ�Ǯ��$", "s:return 'ok'", "quMr")
	addListener("^��⵰��һ�ߴ���ȥ��$", "s:return 'nomoney'", "quMr")
	local result = listen()
	if result == "nomoney" then
		return quMr()
	end
	listener("^���ڵ���С���ߣ������С�ۿ��ڰ��ߣ����´��ɡ�$")
	e("out")
end

function quYzw()
	if not validHere("��ͷ") then
		return false
	end
	local _i = i()
	if _i.silver < 20 then
		go("�۱�ի", "���ݳ�")
		money(0, 20)
		go("��ͷ", "����Ľ��")
	end
	e("qu yanziwu")
	addListener("^���ڿڴ��﷭����ȥ���Ҵ�Ǯ��$", "s:return 'ok'", "quYzw")
	addListener("^��⵰��һ�ߴ���ȥ��$", "s:return 'nomoney'", "quYzw")
	local result = listen()
	if result == "nomoney" then
		return quYzw()
	end
	listener("^�����С�ۿ��ڰ��ߣ����´��ɡ�$")
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
		addListener("^��������һͨ����Ȼ�����Լ��߻���ԭ�ء�$", "s:return true", "outcd")
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
	if _here.name == "ɽ��СϪ" then
		return true
	end
	if _here.name == "ɽ·" then
		wait(500)
		e("s")
		return outJjl()
	end
end

function outZyl()
	if here().name ~= "��Ҷ��" then
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
		addListener("^���۵ð���������ҵ�����ȷ�ķ���$", "s:return 'ok'", "outzyl")
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
	if here().name ~= "ɽ��" then
		return false
	else
		wait(500)
		e("e")
		set("outtssd")
		addListener("^�������������ƿ��е��а�š���$", "s:return 'ok'", "outtssd")
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
	mjMen("n", "������")
end

function leiMen()
	mjMen("n", "������")
end

function diMen()
	mjMen("s", "������")
end

function fengMen()
	mjMen("s", "������")
end

function outzsl()
	while true do
		e("nw;w")
		local _here = here()
		if _here.name == "�����" then
			e("#3 s")
			_here = here()
		end
		if _here.name == "��ˮ��" then
			return true
		end 
		if _here.name ~= "��ɼ��"
			and _here.name ~= "������"
			and _here.name ~= "������"
			and _here.name ~= "������"
			and _here.name ~= "������" then
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
		addListener([[^����ϸ����ǰ������(\S+)һ����\n.+\n���Ա�����Ϊ�ж�\1(?:��)?����������Լ��(\S+)�ļ�����$]], "s:return wildcards[1], wildcards[2]", "pass")
		addListener("^" .. id .. [[ ��������$]], "s:return false", "pass")
		local name, level = listen(30)
		if name then
			local pfm = level ~= "�����������"
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
	addListener("^" .. name .. [[��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$]], "s:return 'faint'", "pass")
	addListener("^" .. name .. [[��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$]], "s:return 'die'", "pass")
	addListener("^" .. name .. [[��\S+��\S+��Ķ����ˡ�$]], "s:return 'away'", "pass")
	addListener("^" .. name .. [[�����������㲽Ѹ���쳣�����߼��籼�����������ȥ��$]], "s:return 'away'", "pass")
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
	addListener("^�����ô�صİ�������·�������⣬��˵���ˣ�$", "s:return 'boat'", "fly")
	addListener("^�����ˮ̫��̫������ɲ���ȥ��$", "s:return 'boat'", "fly")
	addListener("^����¨������ȥ�ɡ�$", "s:return 'wait'", "fly")
	addListener("^�д������������Cool����$", "s:return 'wait'", "fly")
	addListener("^(��|��)��̫���ˣ����û����;�����ĵط�����û����Խ��ȥ��$", "s:return 'wait'", "fly")
	addListener("^�ͱ�ʵ��̫���ˣ����û����;�����ĵط�����û������(��|��)ȥ��$", "s:return 'wait'", "fly")
	addListener([[^����(��|�ƺ�|��)�жɴ�������һ�㣬������������\S+����$]], "s:return 'ok'", "fly")
	addListener([[^��һ����Ϣ����׼���¼���¨λ�ã�ʹ�������־�������Ҫ����(��|��)�¡�$]], "s:return 'ok'", "fly")
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
	if not validHere("���Ķɿ�") then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return 'ok'", "xxdk")
	addListener("^��������������ȴ�������ϴ���Ǯ�����ˡ�$","s:return 'nomoney'","xxdk")
	addSetListener("boat","xxdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		xxdk(locate)
	elseif result == "nomoney" then
		if locate == "nw" then
			go("����Ǯׯ")
			money(0,5)
			go("lanzhou/road2")
			xxdk(locate)
		else
			go("���ի�ֵ�")
			money(0,5)
			go("lanzhou/road3")
			xxdk(locate)
		end
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out")
	end
end

function lzdk(locate)
	if not validHere("��ɿ�") then
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
	addListener("^���ͳ�һ�������ݸ����ң�����Ծ���˶ɴ���$","s:return 'ok'","lzdk")
	addListener("^��������������ȴ�������ϴ���Ǯ�����ˡ�$","s:return 'nomoney'","lzdk")
	addSetListener("boat","lzdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		lzdk(locate)
	elseif result == "nomoney" then
		if locate == "w" then
			go("����Ǯׯ")
			money(0,5)
			go("lanzhou/road2")
			lzdk(locate)
		else
			go("���ի�ֵ�")
			money(0,5)
			go("lanzhou/road3")
			lzdk(locate)
		end
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out")
	end
end

function hhdk(locate)
	if not validHere("��ɿ�") then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return 'ok'", "hhdk")
	addListener("^��������������ȴ�������ϴ���Ǯ�����ˡ�$","s:return 'nomoney'","hhdk")
	addSetListener("boat","hhdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		hhdk(locate)
	elseif result == "nomoney" then
		if locate == "n" then
			go("���ի")
			money(0,5)
			go("huanghe/road2")
			hhdk(locate)
		else
			go("������")
			money(0,5)
			go("huanghe/road3")
			hhdk(locate)
		end
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out")
	end
end

function sjdk(locate)
	if not validHere("�½��ɿ�") then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return 'ok'", "sjdk")
	addListener("^��������������ȴ�������ϴ���Ǯ�����ˡ�$", "s:return 'nomoney'", "sjdk")
	addSetListener("boat", "sjdk")
	local result = listen()
	if result == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		sjdk(locate)
	elseif result == "nomoney" then
		if locate == "n" then
			go("����Ǯׯ")
			money(0,5)
			go("huanghe/road2")
			sjdk(locate)
		else
			go("������")
			money(0,5)
			go("huanghe/road3")
			sjdk(locate)
		end
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out")
	end
end

function cj(nowait)
	local _here = here()
	if _here.name ~= "�����ϰ�" and _here.name ~= "��������" then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "cj")
	addSetListener("boat", "cj")
	if listen() == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		cj(true)
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out;#2 w;e")
	end
end

function lcj()
	if not validHere("���׽���") then
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
	addListener("^���ﲻ׼ս����Ҳ��׼���ɡ�$", "s:return true", "lcj")
	addSetListener("boat", "lcj")
	if listen() == "boat" then
		if not dq(_hp, _hp.max_neili * 2 - _hp.neili - 1) and not tj(_hp, _hp.eff_jingli * 2 - _hp.jingli - 1) then
			wait(2000)
		end
		lcj()
	else
		listener([[^˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ\(out\)�Ľ��ݡ�$]])
		e("out")
	end
end

function getJinhe(i)
	i = i or 1
	e("l jin he " .. i)
	addListener([[^����Լ��\(jiancha\)��������������ʲô���ܡ�$]], "s:return false", "jinhe")
	addListener([[^��Ҫ��ʲô��$]], "s:return 'no'", "jinhe")
	addListener([[^���ݺὭ��ʱ����(\S+)����Щ�����£�����Ե��ǰȥ�ھ�\(dig\)��$]], "s:return wildcards[1]", "jinhe")
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
	addListener("^���϶���һ������߰ߵ������ӣ�����˲�ע�⣬Ѹ�ٰ����д��뻳�С�$", "s:return false", "dig")
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
	addListener([[^��������ǽ�ϰ��˼��£����������ˣ�����Խ��鷿ȥ�ˡ���$]], "s:return true", "guessNum")
	addSetListener("guessNum", "guessNum")
	if listen() then
		return true
	else
		return guessNum()
	end
end

function hhb()
	go("��ɿ�", "���ݳ�")
end

function gbkl()
	go("��Ժ", "ؤ��")
	e("ask hong qigong about �л���")
	while not find("�϶��ֽ�", "������", 5, "������") do
	end
	e("ask wu xiuwen about �л���")
	while not find("��Ժ", "���ݳ�", 4, "�տն�") do
	end

	e("follow kong;ask kong about �л���")
	waitbusy()
	e("give kong 11 gold")
	gbkl()
end