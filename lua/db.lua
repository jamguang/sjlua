--Êý¾Ý¿â

local db_name = "sj.db"
local database_path = world.GetInfo (66) .. db_name

function isDbOpen()
    local databases = DatabaseList()
	if databases then
        for _, v in ipairs (databases) do
	        if v=="sj" then
			    return true
		    end
        end
    end
	return false
end
function dbOpen()
	if not isDbOpen() then
	    DatabaseOpen ("sj", database_path, 6)
		DatabaseExec("sj",[[
	    Create  TABLE IF NOT EXISTS SJ_User([uid] text,[uname] text,[nick] text,[title] text,[party] text,[gender] text,[canwu] integer,[group] integer,[mtime] integer, PRIMARY KEY(uid));
		Create  TABLE IF NOT EXISTS SJ_Trea([tname] text,[tfrom] text,[towner] text,[tdate] text,[tmemo] text,[ttime] integer);
		Create  TABLE IF NOT EXISTS SJ_Path([sourid] text,[destid] text,[sourroom] text,[destroom] text,[path] text,[uid] text,[mtime] integer,CONSTRAINT pk_path PRIMARY KEY(sourid,destid,uid));
		Create  TABLE IF NOT EXISTS SJ_Dark([sourid] text,[destid] text,[path] text,[uid] text,CONSTRAINT pk_dark PRIMARY KEY(sourid,destid,uid));
        Create  TABLE IF NOT EXISTS SJ_Var([uid] text,[uvar] text,[desc] text, CONSTRAINT pk_var PRIMARY KEY(uid,uvar));
		Create  TABLE IF NOT EXISTS SJ_Room([rid] text,[rdesc1] text,[rdesc2] text,[rdesc3] text,[rdesc4] text,[rdesc5] text,[rdesc6] text,[rdesc7] text,[rdesc8] text, CONSTRAINT pk_var PRIMARY KEY(rid));
	]])
	end
	--
end

function dbUserCompare()
    dbOpen()
    local lastTime = dbUserLastUpdate()
	if os.time() - lastTime < 60 * 2 then 
	    return
	end
    local sjuser = dbUserRead()
	sjUser = sjUser or {}
	
	for p,q in pairs(sjUser) do
	    if not sjuser[p] then
		    local l_string = table.concat({q["uid"],q["uname"],q["nick"],q["title"],q["party"],q["gender"],q["canwu"],q["group"]},"|")
			dbUserInsert(l_string)
		else
		    local l_flag = false
			local v = sjuser[p]
			if q["uid"] == v["uid"] then
			    if isNil(q["uname"]) then
				    q["uname"] = v["uname"]
				else
				    if q["uname"] ~= v["uname"] then l_flag = true end
				end
				if isNil(q["nick"]) then
				    q["nick"] = v["nick"]
				else
				    if q["nick"] ~= v["nick"] then l_flag = true end
				end
				if isNil(q["title"]) then
				    q["title"] = v["title"]
				else
				    if q["title"] ~= v["title"] then l_flag = true end
				end
				if isNil(q["party"]) then
				    q["party"] = v["party"]
				else
				    if q["party"] ~= v["party"] then l_flag = true end
				end
				if isNil(q["gender"]) then
				    q["gender"] = v["gender"]
				else
				    if q["gender"] ~= v["gender"] then l_flag = true end
				end
				if isNil(q["canwu"]) or q["canwu"]==0 then
				    q["canwu"] = v["canwu"]
				else
				    if q["canwu"] ~= v["canwu"] then l_flag = true end
				end
				if isNil(q["group"]) or q["group"]==0 then
				    q["group"] = v["group"]
				else
				    if q["group"] ~= v["group"] then l_flag = true end
				end
				if l_flag then
				    local l_string = table.concat({q["uid"],q["uname"],q["nick"],q["title"],q["party"],q["gender"],q["canwu"],q["group"]},"|")
			        dbUserUpdate(l_string)
				end
			end
		end
    end
	for p,q in pairs(sjuser) do
	    if not sjUser[p] then
		    sjUser[p] = sjuser[p]
		end
	end
end
function dbUserRead()
    local sql = "SELECT [uid],[uname],[nick],[title],[party],[gender],[canwu],[group] FROM SJ_User "
	DatabasePrepare ("sj", sql)
	--messageShow(DatabaseError("sj"))
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		result[values[1]]={
		                   ["uid"]   = values[1],
		                   ["uname"] = values[2],
						   ["nick"]  = values[3],
						   ["title"] = values[4],
						   ["party"] = values[5],
						   ["gender"]= values[6],
						   ["canwu"] = values[7],
						   ["group"] = values[8],
		                  }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbUserReadParty(p_party)
    if p_party == nil then return end
    local sql = "SELECT [uid],[uname],[nick],[title],[party],[gender],[canwu],[group] FROM SJ_User WHERE [party]='"..p_party.."' "
	DatabasePrepare ("sj", sql)
	--messageShow(DatabaseError("sj"))
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		result[values[1]]={
		                   ["uid"]   = values[1],
		                   ["uname"] = values[2],
						   ["nick"]  = values[3],
						   ["title"] = values[4],
						   ["party"] = values[5],
						   ["gender"]= values[6],
						   ["canwu"] = values[7],
						   ["group"] = values[8],
		                  }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbUserReadId(p_id)
    if p_id == nil then return end
    local sql = "SELECT [uid],[uname],[nick],[title],[party],[gender],[canwu],[group] FROM SJ_User WHERE [uid]='"..p_id.."' "
	DatabasePrepare ("sj", sql)
	--messageShow(DatabaseError("sj"))
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		result={
		        ["uid"]   = values[1],
		        ["uname"] = values[2],
				["nick"]  = values[3],
				["title"] = values[4],
				["party"] = values[5],
				["gender"]= values[6],
				["canwu"] = values[7],
				["group"] = values[8],
		        }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbUserInsert(p_string)
    --messageShow(p_string)
    local l_set = utils.split(p_string,'|')
	if isNil(l_set[1]) then return end
	local cmd="INSERT INTO SJ_User ([uid],[uname],[nick],[title],[party],[gender],[canwu],[group],[mtime]) VALUES('"..l_set[1].."','"..l_set[2].."','"..l_set[3].."','"..l_set[4].."','"..l_set[5].."','"..l_set[6].."',"..l_set[7]..","..l_set[8]..",".. os.time() ..")"
    --messageShow(cmd)
    local result = DatabaseExec("sj",cmd)
	--messageShow(result)
	--messageShow(DatabaseError("sj"))
end
function dbUserUpdate(p_string)
    local l_set = utils.split(p_string,'|')
	local cmd="UPDATE SJ_User SET [uname]='"..l_set[2].."',[nick]='"..l_set[3].."',[title]='"..l_set[4].."',[party]='"..l_set[5].."',[gender]='"..l_set[6].."',[canwu]="..l_set[7]..",[group]="..l_set[8]..",[mtime]="..os.time().." WHERE uid='"..l_set[1].."'"
    --Note(cmd)
    local result = DatabaseExec("sj",cmd)
	--Note(DatabaseError("sj"))
end
function dbUserLastUpdate()
    local sql = "SELECT MAX(mtime) FROM SJ_User "
	local result = DatabaseGetField ("sj", sql)
	if result == nil then result = 0 end
	return result
end

function dbTreaInsert(p_string)
    local l_set = utils.split(p_string,'|')
	if isNil(l_set[1]) then return end
	local cmd="INSERT INTO SJ_Trea ([tname],[tfrom],[towner],[tdate],[tmemo],[ttime]) VALUES('"..l_set[1].."','"..l_set[2].."','"..l_set[3].."','"..l_set[4].."','"..l_set[5].."',".. l_set[6] ..")"
    local result = DatabaseExec("sj",cmd)
	if math.random(1,10) == 1 then  
	    dbTreaDelete()
	end
end
function dbTreaLastOwner(p_trea)
    local sql
	if p_trea then
        sql = "SELECT [tname],[tfrom],[towner],[tdate],[tmemo],[ttime] FROM SJ_Trea WHERE [tname]='"..p_trea.."' AND ttime=(SELECT MAX(ttime) FROM SJ_Trea WHERE [tname]='"..p_trea.."') "
	else
	    sql = "SELECT [tname],[tfrom],[towner],'',[tmemo],MAX(ttime) FROM SJ_Trea WHERE 1=1 GROUP BY [tname],[tfrom],[towner],[tmemo] "
    end	
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	local times = 0
	while rc == 100 do
	    times = times + 1
		if times > 50 then break end
	    local values = DatabaseColumnValues ("sj")
		result["tname"]={
		                 ["tname"]   = values[1],
		                 ["tfrom"]   = values[2],
				         ["towner"]  = values[3],
				         ["tdate"]   = values[4],
				         ["tmemo"]   = values[5],
						 ["ttime"]   = values[6],
		                 }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbTreaDelete()
    local cmd = "DELETE FROM SJ_Trea WHERE ttime < ".. os.time() .." - 10*24*60*60 "
	local result = DatabaseExec("sj",cmd)
end

function dbPathInsert(p_sid,p_did,p_sroom,p_droom,p_path)
    if isNil(p_sid) or isNil(p_did) or isNil(p_path) then return false end
	dbOpen()
	local cmd = "INSERT INTO SJ_Path ([sourid],[destid],[sourroom],[destroom],[path],[uid],[mtime]) VALUES('"..p_sid.."','"..p_did.."','"..p_sroom.."','"..p_droom.."','"..p_path.."','"..score.id.."',0)"
	local result = DatabaseExec("sj",cmd)
end
function dbPathInsertPublic(p_sid,p_did,p_sroom,p_droom,p_path)
    if isNil(p_sid) or isNil(p_did) or isNil(p_path) then return false end
	dbOpen()
	local cmd = "INSERT INTO SJ_Path ([sourid],[destid],[sourroom],[destroom],[path],[uid],[mtime]) VALUES('"..p_sid.."','"..p_did.."','"..p_sroom.."','"..p_droom.."','"..p_path.."','all',0)"
	local result = DatabaseExec("sj",cmd)
end
function dbPathGet(p_sour,p_dest)
	if not p_sour or not p_dest then return false end
	dbOpen()
	local sql = "SELECT [path] FROM SJ_Path WHERE [uid] = '"..score.id.."' AND [sourid] = '"..p_sour.."' AND [destid] = '"..p_dest.."'"
	local result = DatabaseGetField ("sj", sql)
	if result then
	    dbPathTimeAdd(p_sour,p_dest)
	end
	if result == nil then result = false end
	return result
end
function dbPathTimeAdd(p_sour,p_dest)
    if not p_sour or not p_dest then return false end
	dbOpen()
	local cmd = "UPDATE SJ_Path SET [mtime] = [mtime] + 1 WHERE [uid] = '"..score.id.."' AND [sourid] = '"..p_sour.."' AND [destid] = '"..p_dest.."'"
	local result = DatabaseExec("sj",cmd)
end
function dbPathGetTime()
	dbOpen()
	local sql = "SELECT [sourid],[destid],[path] FROM SJ_Path WHERE [uid]='"..score.id.."' AND mtime > 0 ORDER BY mtime DESC "
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	local times = 0
	while rc == 100 do
	    times = times + 1
		if times > 2000 then break end
	    local values = DatabaseColumnValues ("sj")
		local pathid = values[1] .. "|" .. values[2]
		result[pathid] = values[3]
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbPathPublicGet(p_sour,p_dest)
	if not p_sour or not p_dest then return false end
	dbOpen()
	local sql = "SELECT [path] FROM SJ_Path WHERE [uid] = 'all' AND [sourid] = '"..p_sour.."' AND [destid] = '"..p_dest.."'"
	local result = DatabaseGetField ("sj", sql)
	if result then
	    dbPathPublicTimeAdd(p_sour,p_dest)
	end
	if result == nil then result = false end
	return result
end
function dbPathPublicTimeAdd(p_sour,p_dest)
    if not p_sour or not p_dest then return false end
	dbOpen()
	local cmd = "UPDATE SJ_Path SET [mtime] = [mtime] + 1 WHERE [uid] = 'all' AND [sourid] = '"..p_sour.."' AND [destid] = '"..p_dest.."'"
	local result = DatabaseExec("sj",cmd)
end
function dbPathPublicGetTime()
	dbOpen()
	local sql = "SELECT [sourid],[destid],[path] FROM SJ_Path WHERE [uid]='all' AND mtime > 0 ORDER BY mtime DESC "
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	local times = 0
	while rc == 100 do
	    times = times + 1
		if times > 8000 then break end
	    local values = DatabaseColumnValues ("sj")
		local pathid = values[1] .. "|" .. values[2]
		result[pathid] = values[3]
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbPathDelete()
    local cmd = "DELETE FROM SJ_Path WHERE [uid] = '"..score.id.."' "
	local result = DatabaseExec("sj",cmd)
end
function dbPathGetIndex()
	dbOpen()
	local sql = "SELECT DISTINCT [sourid],[destid] FROM SJ_Path WHERE [uid]!='all' "
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		local pathid = values[1] .. "|" .. values[2]
		result[pathid]={
		        ["sourid"]   = values[1],
		        ["destid"]   = values[2],
		        }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end

function dbDarkInsert(p_sid,p_did,p_path)
    if isNil(p_sid) or isNil(p_did) or isNil(p_path) then return false end
	dbOpen()
	local cmd = "INSERT INTO SJ_Dark ([sourid],[destid],[path],[uid]) VALUES('"..p_sid.."','"..p_did.."','"..p_path.."','"..score.id.."')"
	local result = DatabaseExec("sj",cmd)
end
function dbDarkGet(p_sour,p_dest)
	if not p_sour or not p_dest then return false end
	dbOpen()
	local sql = "SELECT [path] FROM SJ_Dark WHERE [uid] = '"..score.id.."' AND [sourid] = '"..p_sour.."' AND [destid] = '"..p_dest.."'"
	local result = DatabaseGetField ("sj", sql)
	if result == nil then result = false end
	return result
end
function dbDarkGetTime()
	dbOpen()
	local sql = "SELECT [sourid],[destid],[path] FROM SJ_Dark WHERE [uid]='"..score.id.."' "
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	local times = 0
	while rc == 100 do
	    times = times + 1
		if times > 1000 then break end
	    local values = DatabaseColumnValues ("sj")
		local pathid = values[1] .. "|" .. values[2]
		result[pathid] = values[3]
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbDarkDelete()
    local cmd = "DELETE FROM SJ_Dark WHERE [uid] = '"..score.id.."' "
	local result = DatabaseExec("sj",cmd)
end
function dbDarkGetIndex()
	dbOpen()
	local sql = "SELECT DISTINCT [sourid],[destid] FROM SJ_Dark "
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		local pathid = values[1] .. "|" .. values[2]
		result[pathid]={
		        ["sourid"]   = values[1],
		        ["destid"]   = values[2],
		        }
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end

function dbVarInsert(p_set)
	if not p_set or not p_set["uid"] or not p_set["uvar"] or not p_set["desc"] then return end
	local cmd="INSERT INTO SJ_Var ([uid],[uvar],[desc]) VALUES('"..p_set['uid'].."','"..p_set['uvar'].."','"..p_set['desc'].."')"
    local result = DatabaseExec("sj",cmd)
end
function dbVarUpdate(p_set)
    if not p_set or not p_set["uid"] or not p_set["uvar"] or not p_set["desc"] then return end
	local cmd="UPDATE SJ_Var SET [desc]='"..p_set['desc'].."' WHERE uid='"..p_set['uid'].."' AND uvar='"..p_set['uvar'].."'"
	--Note(cmd)
    local result = DatabaseExec("sj",cmd)
	--Note(DatabaseError("sj"))
end
function dbVarReadId()
    dbOpen()
	local sql = "SELECT [uvar],[desc] FROM SJ_Var WHERE uid = '"..score.id.."'"
	DatabasePrepare ("sj", sql)
	local rc = DatabaseStep ("sj")
	local result = {}
	while rc == 100 do
	    local values = DatabaseColumnValues ("sj")
		result[values[1]]=values[2]
		rc = DatabaseStep ("sj")
	end
	DatabaseFinalize ("sj")
	return result
end
function dbVarCompareTime()
    dbOpen()
    local sjvar = dbVarReadId()
	local sjVar = GetVariableList()
	
	for p,q in pairs(sjVar) do
	    if string.match(p,'^time%w') and tonumber(q) then
	        if not sjvar[p] then
		    	dbVarInsert({["uid"]=score.id,["uvar"]=p,["desc"]=q})
		    else
		        if tonumber(sjvar[p]) and tonumber(sjVar[p]) < tonumber(sjvar[p]) and tonumber(sjvar[p]) < os.time() then
				    SetVariable(p,tonumber(sjvar[p]))
				else
				    --if tonumber(sjVar[p]) ~= tonumber(sjvar[p]) then
					if sjVar[p] ~= sjvar[p] then
		    	        dbVarUpdate({["uid"]=score.id,["uvar"]=p,["desc"]=q})
					end
		    	end
		    end
		end
    end
end
