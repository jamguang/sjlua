
local GO_AGAIN_WAIT = 3000

function OnMove(name,line,wildcards)
	hereId = nil
	local moveName = wildcards[1]
	local moveExits = utils.split(string.gsub(wildcards[2],"、","|"),"|")
	move = {name = moveName, exits = {}}
	for _,v in pairs(moveExits) do
		move.exits[v] = true
	end
end

function here()
	local _here = {}
	hide("set look")
	e("l")
	set("here")
	while true do
		addListener([[^【你现在正处于(\S+)】$]],"s:return 'city',wildcards[1]","here")
		addListener([[^(\S+) - $]],"s:return 'name',wildcards[1]","here")
		addListener([[^(?:    这里没有任何明显的出路|    这里唯一的出口是 (\S+)|    这里明显的出口是 (.+))。$]],"OnExits","here")
		addSetListener("here","here")
		local k, v = listen(5, function() return false end)
		if not k then
			return here()
		elseif k == "here" then
			break
		else
			_here[k] = v
		end
	end
	return _here
end

function around(exits)
	local around = {}
	hide("set look")
	for exit in pairs(exits) do
		e("l " .. exit)
		e("set exit " .. exit)
	end
	e("unset exit")
	set("around")
	local lookroom = {}
	while true do
		addListener([[^【你现在正处于(\S+)】$]],"s:return 'city',wildcards[1]","around")
		addListener([[^(\S+) - $]],"s:return 'name',wildcards[1]","around")
		addListener([[^设定环境变量：exit = "(.+)"$]],"s:return 'exit',wildcards[1]","around",trigger_flag.OmitFromOutput)
		addSetListener("around","around")
		local k,v = listen()
		if k == "around" then
			break
		elseif k == "exit" then
			around[v] = lookroom
			lookroom = {}
		else
			lookroom[k] = v
		end
	end
	return around
end

function OnExits (name, line, wildcards)
	local exits = {}
	local exitOne = wildcards[1]
	local exitMulti = wildcards[2]
	if exitOne and exitOne ~= "" then
		exits[exitOne] = true
	elseif exitMulti and exitMulti ~= "" then
		exitMulti = string.gsub(exitMulti," 和 ","、")
		exitMulti = string.gsub(exitMulti,"、","|")
		for _,v in pairs(utils.split(exitMulti,"|")) do
			exits[v] = true
		end
	end
	return "exits",exits
end

function locateHere()
	if hereId then
		return hereId
	end
	if move then
		local movePath = getHerePath(move, true)
		if not movePath then
			wait(1000)
			return locateHere()
		elseif table.getn(movePath) == 1 then
			hereId = movePath[1]
			return hereId
		else
			TraceOut("从 move 定位：" .. save(movePath))
		end
	end
	local here = here()
	local herePath = getHerePath(here, false)
	if not herePath then
		if here.exits then
			randomMove(here.exits)
			wait(200)
			return locateHere()
		else
			wait(1000)
			return locateHere()
		end
	elseif table.getn(herePath) == 1 then
		hereId = herePath[1]
		return hereId
	else
		here.exits = around(here.exits)
		herePath = getHerePath(here, false)
		if not herePath then
			if here.exits then
				randomMove(here.exits)
				wait(200)
				return locateHere()
			else
				wait(1000)
				return locateHere()
			end
		elseif table.getn(herePath) == 1 then
			hereId = herePath[1]
			return hereId
		else
			log.debug("定位当前位置有重复：")
			for _, v in pairs(herePath) do
				log.debug(v)
			end
			randomMove(here.exits)
			wait(200)
			return locateHere()
		end
	end
end

function randomMove(exits)
	local exit = randomGet(exits)
	e(exit)
end

function getHerePath(here,isMove)
	local herePath = {}
	for k,v in pairs(map.rooms) do
		if sameRoom(here,v,isMove) then
			table.insert(herePath,k)
		end
	end
	if table.getn(herePath) == 0 then
		move = nil
		hereId = nil
		--log.error("未找到当前位置：" .. save(here))
		return nil
	end
	return herePath
end

function sameRoom(here,room,isMove)
	return ((isMove and not here.city) or here.city == getLookCity(room.id)) and here.name == room.name and sameExits(here,room)
end

function sameExits(here,room)
	if not here.exits then
		return true
	end
	local nolooks = room.nolooks
	local nolook = room.nolook
	local hereExitsCount = 0
	for k,v in pairs(here.exits) do
		if not nolooks[k] and (not nolook or room.ways[k]) then
			hereExitsCount = hereExitsCount + 1
			if not room.ways[k] then
				return false
			end
			if v ~= true then
				if not sameRoom(v,map:room(room.ways[k])) then
					return false
				end
			end
		end
	end
	local roomExitsCount = 0
	for k,v in pairs(room.ways) do
		if not nolooks[k] then
			roomExitsCount = roomExitsCount + 1
		end
	end
	if hereExitsCount ~= roomExitsCount then
		return false
	end
	return true
end

function getRooms(name, city, type)
	local type = type or "all"
	local isLookCity = type == "all" or type == "look"
	local isTaskCity = type == "all" or type == "task"
	if string.find(name,"/") then
		return {name}
	end
	local isNameFw = string.find(name,"^%l+$")
	local isCityFw = city and string.find(city,"^%l+$")
	local rooms = {}
	for id,room in pairs(map.rooms) do
		local roomName = isNameFw and getFirstWord(room.name) or room.name
		if roomName == name then
			if not city then
				table.insert(rooms,id)
			else
				local lookCity = isCityFw and getFirstWord(getLookCity(room.id)) or getLookCity(room.id)
				local taskCity = isCityFw and getFirstWord(getCity(room.id)) or getCity(room.id)
				if (isLookCity and city == lookCity) or (isTaskCity and city == taskCity) or (room.outdoor and room.outdoor == city) then
					table.insert(rooms,id)
				end
			end
		end
	end
	if count(rooms) == 0 then
		TraceOut("没找到房间：name = " .. name .. " , city = " .. tostring(city) .. " , type = " .. type)
	end
	return rooms
end

function getAroundRooms(name, city, length, type)
	local rooms = getRooms(name, city, type)
	local allRooms = {}
	for _, id in pairs(rooms) do
		local aroundRooms = map:getAroundRooms(id, length)
		for _, aroundRoom in pairs(aroundRooms) do
			if not map.rooms[aroundRoom].nofind then
				allRooms[aroundRoom] = true
			end
		end
	end
	return allRooms
end

function locateGo(name, city)
	local goRooms = getRooms(name, city)
	if table.getn(goRooms) == 0 then
		log.error("没找到目标：city = " .. tostring(city) .. " , name = " .. name)
		return false
	elseif table.getn(goRooms) > 1 then
		log.warn("有多个匹配目标：")
		for _,path in pairs(goRooms) do
			log.warn(path)
		end
		log.warn("取第一个：path = " .. goRooms[1] .. " , city = " .. tostring(city) .. " , name = " .. name)
		return goRooms[1]
	else
		return goRooms[1]
	end
end

function addWait(path)
	local waitLength = math.random(15,15)
	local waitTime = 600
	local p = utils.split(path, ";")
	local length = table.getn(p) - 4 -- 去掉最后的 set go;unset go;
	local waitCount = math.floor(length / waitLength)
	if math.fmod(length,waitLength * 2)==0 then
		waitCount = waitCount - 1
	end
	for i = waitCount,1,-1 do
		table.insert(p,i * waitLength + 1,"#waitpath " .. waitTime)
	end
	return table.concat(p,";")
end

function waitpath(seconds)
	set("waitpath")
	addSetListener("waitpath")
	listen()
	wait(seconds)
	e("halt")
end

function canFind(name, city, length, type)
	length = length and tonumber(length) or 0
	TraceOut("can find name = " .. name .. " , city = " .. tostring(city) .. " , length = " .. tostring(length))
	local rooms = getAroundRooms(name, city, length, type)
	local herePath = locateHere()
	return getMinPath(herePath, rooms)
end

function find(name, city, length, goal, type, callback, ...)
	length = length and tonumber(length) or 0
	Note("find name = " .. name .. " , city = " .. tostring(city) .. " , length = " .. tostring(length))
	local rooms = getAroundRooms(name, city, length, type)
	while count(rooms) > 0 do
		local herePath = locateHere()
		local minPath, room = getMinPath(herePath, rooms)
		if not minPath then
			return false
		end
		rooms[room] = nil
		local _, things = go(room, nil, true)
		local id = findGoal(room, goal, things)
		if id then
			if not callback then
				return id
			else
				local params = {...}
				table.insert(params, id)
				local result = {callback(unpack(params))}
				if result[1] then
					return unpack(result)
				end
			end
		end
		wait(200)
	end
	log.debug("find name = " .. name .. " , city = " .. tostring(city) .. " , length = " .. tostring(length) .. " , goal = " .. tostring(goal) .. " , type = " .. tostring(type) .. " ，未找到")
	return false
end

function findGoal(room, goal, things)
	if goal == true then
		return true
	end
	local _room = map.rooms[room]
	local result = findGoal0(goal, things)
	if result then
		return result
	end
	if _room.find then
		local path = _room.find.path
		local count = _room.find.count or 1
		for i = 1, count do
			for _, p in pairs(path) do
				--wait(100)
				e(p)
				result = findGoal0(goal)
				if result then
					return result
				end
			end
		end
	end
	return false
end

function findGoal0(goal, things)
	things = things or lookGoal()
	for name, id in pairs(things) do
		if string.find(name, goal) then
			return id
		end
	end
	return false
end

function getMinPath(from, toRooms)
	local minLength
	local minPath
	local room
	for id in pairs(toRooms) do
		local path, length = map:getPath(from, id)
		if not path then
			return false
		end
		if minLength == nil or length < minLength then
			minLength = length
			minPath = path
			room = id
		end
	end
	return minPath, room, minLength
end

function lookGoal(nosend)
	if not nosend then
		e("id here")
		set("lookGoal")
	end
	local things = {}
	addListener([[^在这个房间中, 生物及物品的\(英文\)名称如下：$]], nil, nil, trigger_flag.OmitFromOutput)
	listen()
	while true do
		addListener([[^(\S+) = ([\w ']+)(?:, ([\w ']+))*$]], "s:return wildcards[1], wildcards[2]", "lookGoal", trigger_flag.OmitFromOutput)
		addSetListener("lookGoal", "lookGoal")
		local name, id = listen()
		if name == "lookGoal" then
			break
		else
			things[name] = id
		end
	end
	return things
end

function go(name, city, look, again)
	again = again or 0
	if again > 20 then
		log.error("到： name = " .. name .. "，city = " .. tostring(city) .. "，重复了多次仍然未到达")
		return false
	end
	TraceOut("go name = " .. name .. " , city = " .. tostring(city))
	local herePath = locateHere()
	local goPath = locateGo(name,city)
	if not goPath then
		return false
	end
	if herePath == goPath then
		hereId = goPath
		local things
		if look then
			things = lookGoal()
		end
		waitbusy()
		return true, things
	end
	local path = map:getPath(herePath, goPath)
	log.debug("从：" .. herePath .. "，到：" .. goPath .. "，的路径是：" .. tostring(path))
	if path then
		if look then
			path = path .. "id here;set lookGoal;unset lookGoal"
		end
		waitbusy()
		e(path)
		addSetListener("go")
		listen()
		if not move or not sameRoom(move,map.rooms[goPath], true) then
			move = nil
			hereId = nil
			wait(GO_AGAIN_WAIT)
			again = again + 1
			e("yun jingli")
			return go(name,city, look, again)
		else
			hereId = goPath
			local things
			if look then
				things = lookGoal(true)
			end
			return true, things
		end
	else
		return false
	end
end

function goNofightRoom()
	local herePath = locateHere()
	local nofightRooms = getNofightRooms()
	local minLength
	local room
	for id in pairs(nofightRooms) do
		local path, length = map:getPath(herePath, id, true)
		if path then
			if minLength == nil or length < minLength then
				minLength = length
				room = id
			end
		end
	end
	if not room then
		log.error("无法到达 no fight room : " .. herePath)
		local _here = here()
		e("halt")
		randomMove(_here.exits)
	else
		go(room)
	end
end

function getNofightRooms()
	local nofightRooms = {}
	for k, v in pairs(map.rooms) do
		if v.no_fight then
			nofightRooms[v.id] = true
		end
	end
	return nofightRooms
end

-- alias goNoFightRoom
function nf()
	goNofightRoom()
end
