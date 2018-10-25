sour={area='������',room='����'}
dest={area='������',room='����'}
locl={}
locl.area='������'
locl.room='����'
locl.where='�����ǵ���'
locl.time='��'
locl.id={}
locl.exit={}
road={}
road.sour='����_������'
road.city='������_������'
road.dest='������_����'
road.where='�����ǵ���'
road.test={}
road.detail={}
road.act=nil
road.i=0
road.temp=0
road.find=0
road.wipe_id=nil
road.wipe_who=nil
road.wipe_con=nil
road.resume=nil
road.wait=0.2
--road.steps=7
road.steps=6
road.cmd=nil
road.cmd_save=nil
road.maze=nil
exits={}
exits.locl={}
--exits.reverse={}

sjPathPublic = {}
sjPathSingle = {}
sjDark = {}

AddrIgnores = {
	["������"]     = true,
	["����Ľ��"]   = true,
    ["�һ���"]     = true,
	["������"]     = true,
	["��٢��ɽׯ"] = true,
	["����"]       = true,
	["Ħ����"]     = true,
}
WhereIgnores = {
	["���ݳ�ɽ·"]     = true,
	["�䵱ɽԺ��"]     = true,
	["�䵱ɽ��ɽСԺ"] = true,
	["������ɼ��"] = true,
	["����������"] = true,
	["����������"] = true,
	["���̷�����"] = true,
	["���̵�����"] = true,
}

AddrIgnoresSX = {
	["��٢��ɽׯ"] = true,
	["������"] = true,
	["��Դ��"] = true,
	["������"] = true,
	["����Ľ��"] = true,
	["÷ׯ"] = true,
}
WhereIgnoresSX = {
	["����������"] = true,
	["���̵�����"] = true,
	["����������"] = true,
	["���̷�����"] = true,
	["������ɼ��"] = true,
	["��������"] = true,
	["���޺�ɽ��"] = true,
	--["Ѫ����ɽ��"] = true,
	["ȫ���ҩ����"] = true,
	["ƽ���ݿͷ�"] = true,
	["���ݳǹ뷿"] = true,
	["�䵱ɽԺ��"] = true,
	["�䵱ɽ��ɽСԺ"] = true,	
--	["Ѫ����ɽ·"] = true,
	["��������ɽ·"] = true,
	["��������·"] = true,
	["���ݳ���ʯ���"] = true,
	["���ݳ�ɽ·"] = true,
	["��ɽ����ʯ��"] = true,
	["����ȴ���"] = true,
	["�����С��  "] = true,
}

AddrIgnoresXS = {
	["��٢��ɽׯ"] = true,
	["������"] = true,
	["��Դ��"] = true,
	["������"] = true,
	["����Ľ��"] = true,
	["÷ׯ"] = true,
}
AddrIgnoresMRXS = {
	--["��٢��ɽׯ"] = true,
	--["������"] = true,
	["��Դ��"] = true,
	["������"] = true,
	--["����Ľ��"] = true,
	["÷ׯ"] = true,
}
WhereIgnoresXS = {
	["����������"] = true,
	["���̵�����"] = true,
	["����������"] = true,
	["���̷�����"] = true,
	["������ɼ��"] = true,
	["��������"] = true,
--	["���޺�ɽ��"] = true,
--	["Ѫ����ɽ��"] = true,
--	["ȫ���ҩ����"] = true,
	["ƽ���ݿͷ�"] = true,
	["���ݳǹ뷿"] = true,
	["�䵱ɽԺ��"] = true,
	["�䵱ɽ��ɽСԺ"] = true,	
	["���ݳ�ɽ·"] = true,
	["��������ɽ·"] = true,
--	["Ѫ����ɽ·"] = true,
	["��������·"] = true,
	["���ݳ���ʯ���"] = true,
	["��ɽ����ʯ��"] = true,
	["����ȴ���"] = true,
	["�����С��"] = true,
}

local WipeNoPerform = {
     ["guan bing"] = true,
	 ["zhiqin bing"] = true,
	 ["wu jiang"] = true,
	 ["guan jia"] = true,
	 ["ya yi"] = true,
	 ["da yayi"] = true,
	 ["huanggong shiwei"] = true,
	 ["dali guanbing"] = true,
	 ["dali wujiang"] = true,
	 ["yu guangbiao"] = true,
	 ["wu guangsheng"] = true,
	-- ["yin wushou"] = true,
	 ["jia ding"] = true,
	 ["ya huan"] = true,
	-- ["wu seng"] = true,
	-- ["daoyi chanshi"] = true,
	 ["zhuang ding"] = true,
	 ["heiyi bangzhong"] = true,
	 ["xingxiu dizi"] = true,
	-- ["hufa lama"] = true,
	-- ["zayi lama"] = true,
	 ["caihua zi"] = true,
	 ["wudujiao dizi"] = true,
	-- ["wei shi"] = true,
}

local ItemGet = {
    ["�ƽ�"] = true,
--  ["����"] = true,
    ["ҼǪ����Ʊ"] = true,
    ["ҼǪ����Ʊ"] = true,
    ["��Ӣ֮��"] = true,
    ["����������ƪ"] = true,
    ["���콳����ƪ"] = true,
}

function exe(cmd)
    if GetConnectDuration() == 0 then
       return Connect()
    end
    if cmd==nil then cmd='look' end
    Execute(cmd)
end
function exe_road(cmd)
    if GetConnectDuration() == 0 then
       return Connect()
    end
    if cmd==nil then cmd='look' end
    road.cmd=cmd
    if locl.area and locl.area~="����ɽ" then
       Execute('halt')
    end
    Execute(cmd)
end
function lujing_trigger()
    walk_trigger()
end
function locate_trigger()
    DeleteTriggerGroup("locate")
    create_trigger_t('locate1',"^(> )*(\\D*)\\s*\\-\\s*$",'','local_room')
    create_trigger_t('locate2',"^(> )*��������������(\\D*)��$",'','local_area')
    --create_trigger_t('locate3',"^( )*����(�������|���Ե�|Ψһ��|���ü���Ψһ)������(\\D*)��$",'','local_exit')
    --create_trigger_t('locate4',"^(\\D*) = (\\D*)$",'','local_id')
    create_trigger_t('locate5','^(> )*��� "action" �趨Ϊ "���ڶ�λ" �ɹ���ɡ�$','','local_start')
    create_trigger_t('locate6',"^(> )*������\\D*��\\D*��\\D*��(\\D*)ʱ(һ|��|��|)(��|��)",'','local_time')
    SetTriggerOption("locate1","group","locate")
    SetTriggerOption("locate2","group","locate")
    --SetTriggerOption("locate3","group","locate")
    --SetTriggerOption("locate4","group","locate")
    SetTriggerOption("locate5","group","locate")
    SetTriggerOption("locate6","group","locate")
    EnableTriggerGroup("locate",false)    
end
local_start=function()
    EnableTriggerGroup("locate",true)
    locl.area='��֪������'
    exits.locl={}
    locl.id={}
	locl.item = {}
    locl.exit={}
    locl.dir="east"
end
local_room=function(n,l,w)
    EnableTrigger("locate1",false)    
    locl.room=Trim(w[2])
    exe('unset look')
    locl.where=locl.area..locl.room
end
local_area=function(n,l,w)    
    locl.area=Trim(w[2])
end
local_exit=function(n,l,w)
    return localExit(w[3])
end
function localExit(p_exit)
    local cnt
    exits.locl=exit_set(p_exit)
    local l_set=exits.locl
    
    if roomNodir[locl.where] then
       l_set=del_element(l_set,roomNodir[locl.where])
    end
    --cnt=table.getn(l_set)
    --if cnt==0 or cnt==nil then
    --   cnt=1
    --end
    --cnt=math.random(1,cnt)
    --locl.dir=l_set[cnt]
	locl.dir = randomElement(exits.locl)
    if not locl.dir then
       locl.dir='east'
    end
    for _,p in pairs(exits.locl) do
       locl.exit[p]=true
    end
end
local_time=function(n,l,w)
    EnableTriggerGroup("locate",false)
    --DeleteTriggerGroup("locate")
    locl.time=w[2]
	locl.quarter = trans(w[3])
    userSave()
	roomDesc = {}
	local l_desc = false
	--for i = GetLinesInBufferCount()-1,GetLinesInBufferCount()-50,-1 do
	for i = GetLinesInBufferCount()-1,1,-1 do
	    local l_string = GetLineInfo(i,1)
		--print(l_string)
	    if locl.room and locl.room..' - ' == GetLineInfo(i,1) then l_desc = false end
		if l_string and (string.find(l_string,"���￴����ĳ�����") or string.find(l_string,"���￴�ü���Ψһ������") or string.find(l_string,"����Ψһ�ĳ�����") or string.find(l_string,"�������Եĳ�����")) then 
		   l_desc = true 
		   localExit(l_string)
		end
		if l_desc then table.insert(roomDesc,1,l_string) end
		
		if l_string and string.find(l_string,"���ڶ�λ") then break end
		if l_string and string.find(l_string," = ") then
		    local l_name = Trim(string.sub(l_string,1,string.find(l_string," = ")-1))
			local l_id = Trim(string.sub(l_string,string.find(l_string," = ")+3,string.len(l_string)))
		    localId(l_name,l_id)
		end
    end
end
local_id=function(n,l,w)
    local l_name=w[1]
    local l_id=w[2]
	if l_name and l_id then
	    return localId(l_name,l_id)
	end
end
function localId(p_name,p_id)
    local l_name = p_name
	local l_id = p_id
    local l_set={}
    if string.find(l_id,",") then
        l_set=utils.split(l_id,',')
        l_id=l_set[1]
    else
        if not string.find(l_id," ") and string.len(l_name)<9 then
            MudUser[l_name]=l_id
		    usrList = usrList or {}
		    usrList[l_id] = l_name
        end
    end
    locl.id[l_name]=Trim(l_id)
    if ItemGet[l_name] then
        exe('get '.. l_id)
    end
	if l_name=="����" and GetVariable("autolengquan") and GetVariable("autolengquan") == "1" and not Bag["����"] then
	    exe('get '.. l_id)
	end
    if l_name=="����" and job.zuhe["wudang"] and job.zuhe["xueshan"] then
        exe('get '.. l_id)
    end
    if string.len(l_name)==6 and (string.sub(l_name,5,6)=="��" or string.sub(l_name,5,6)=="��") and (not drugPoison[l_name] and not drugBuy[l_name]) then
        exe('get '.. l_id)
    end
    if weaponPrepare[l_name] and (not weaponStore[l_name] or not Bag[l_name])then
	    Bag[l_name] = {}
		Bag[l_name].id = {}
		Bag[l_name].id[l_id] = true
		Bag[l_name].cnt = 1
        exe('get '.. l_id)
    end
	
	l_set=utils.split(p_id,',')
	locl.item[l_name] = {}
	for p,q in pairs(l_set) do
	    locl.item[l_name][Trim(q)] = true  
	end
end
exit_set=function(p_exit)
    local l_set={}
    local l_exit=Trim(p_exit)
    for w in string.gmatch(l_exit, "(%w+)") do
        table.insert(l_set, w)
    end
    return l_set    
end
locate=function()
    locate_trigger()
    EnableTrigger("locate5",true)
    exe('alias action ���ڶ�λ')
    exe('id here')
    exe('set look;l;time')
end
function walk_trigger()
    DeleteTriggerGroup("walk")
    create_trigger_t('walk1','^(> )*��� "action" �趨Ϊ "���ڸ�·��" �ɹ���ɡ�$','','walk_goon')
    SetTriggerOption("walk1","group","walk")
    EnableTriggerGroup("walk",false)
end
function walk_wait()
       EnableTriggerGroup("walk",true)
	   EnableTrigger("hp12",true)
	   if tmp.find then
	      --messageShow('find wait')
	      create_timer_s('walkWait',0.5,'walkTimer')
		  if cntr1() > 0 then
                     exe('alias action ���ڸ�·��')
		  else
		     cntr1 = countR(15)
		  end
	   else
	      --messageShow('walk wait')
          create_timer_s('walkWait',road.wait,'walkTimer')
	   end
end
function walkTimer()
    --EnableTriggerGroup("walk",true)
	if tmp.find then
	   if flag.find == 1 or flag.wait == 1 then
	      --messageShow('find 1')
	   else
	      --messageShow('find 0')
	   end
	else
	   --messageShow('walk 0')
	end
    exe('alias action ���ڸ�·��')
end
function walk_goon()
    EnableTriggerGroup("walk",false)
    EnableTimer('walkwait',false)
	EnableTrigger("hp12",false)
	
	--messageShow(flag.find)
	
	if tmp.findfunc then
	   local l_func = tmp.findfunc
	   tmp.findfunc = nil
	   if _G[l_func] then
	      return _G[l_func]()
	   end
	end
	
	if flag.find==1 then return end
    if flag.wait==1 then return end
	
	if tmp.find then
	   --messageShow('finding')
	   
       return searchFunc()
	else
	   
	   EnableTrigger("hp12",true)
       create_timer_s('roadWait',road.wait,'path_start')
	end
end
function goto(where)
   dis_all()
   local l_dest={}
   sour.id = nil
   dest.id = nil
   tmp.goto = true
   where = Trim(where)
   
   l_dest.area,l_dest.room = locateroom(where)
   
   if l_dest.area then
      return go(test,l_dest.area,l_dest.room)
   else
      return ColourNote ("red","blue","�Ҳ������޷������(�ص�|����)��"..where)
   end

end

function go(job,area,room,sId)
    tmp.goto = nil
    sour.id=sId
    dest.id = nil
    if area~=nil then
       dest.area=area
    end
    if room~=nil then
       dest.room=room
    end
    if string.find(dest.area,"/") then
       dest.id = dest.area
       Note(dest.id)
       dest.room = map.rooms[dest.id].name
       Note(dest.room)
    end
    if job==nil then
       job=test
    end 
    flag.find=0
    flag.wait=0
    road.act=job
    road.i=0
    flag.dw=1
    tmp.find = nil
    --if sour.id ~= nil then
    --   return check_busy(path_consider)
    --else
       return check_busy(go_locate)
    --end
end
go_locate=function()
    locate()
    check_bei(path_consider)
end
function goContinue()
    return go(road.act)
end
function path_consider()
    local l_sour,l_dest,l_path,l_way
    local l_where=locl.area .. locl.room
    sour.rooms={}
    dest.rooms={}

	if sour.id and map.rooms[sour.id].name ~= locl.room then
	    sour.id = nil
	end
	
    if not sour.id and road.id and map.rooms[road.id] and map.rooms[road.id].name == locl.room then
        sour.id = road.id
    end
    if sour.id == nil then
        sour.room=locl.room
        sour.area=locl.area
        sour.rooms=getRooms(sour.room,sour.area)
    end
    if dest.id == nil then
        dest.rooms=getRooms(dest.room,dest.area)
    end
	if dest.id == nil and table.getn(dest.rooms)==0 then
       Note('Path Consier GetRooms Error!')
       return false
    end
    
    if sour.id ~= nil then
        chats_locate('��λϵͳ���ӡ�'.. sour.id ..'������!')
	    path_create()
        return check_bei(path_start)
    end

    if table.getn(sour.rooms)==0 then
        chats_locate('��λϵͳ����ͼϵͳ�޴˵ص㡾'..locl.area .. locl.room ..'�����ϣ�����ƶ�Ѱ��ȷ�ж�λ�㣡','red')
        exe('leavefb;stand;leave')
        exe(locl.dir)
        return checkWait(goContinue,0.2)
    end
	   
	if table.getn(sour.rooms)>1 then
	    for p in pairs(locl.id) do
	        local l_cnt = 0
	        local l_id
	        for k,v in pairs(sour.rooms) do
	            local l_corpse
	            if string.find(p,"��ʬ��") then
		            l_corpse = del_string(p,"��ʬ��")
	            else
	                l_corpse = p
	            end
		        if map.rooms[v] and map.rooms[v].objs and (map.rooms[v].objs[p] or map.rooms[v].objs[l_corpse]) then
			        l_cnt = l_cnt + 1
		            l_id = v
			    end
		    end  
		    if l_cnt == 1 then
	            return go(road.act,dest.area,dest.room,l_id)
	        end
	    end
	    if not roomMaze[l_where] then
            for p in pairs(locl.exit) do
                local l_cnt = 0
	            local l_id
                for i=1,table.getn(sour.rooms) do
                    if map.rooms[sour.rooms[i]] and map.rooms[sour.rooms[i]].ways and map.rooms[sour.rooms[i]].ways[p] then
                        l_cnt = l_cnt + 1
		                l_id = sour.rooms[i]
	                end
                end
                if l_cnt == 1 then
	                return go(road.act,dest.area,dest.room,l_id)
	            end
            end
	    end
	end
	
	if roomMaze[l_where] then
	    if type(roomMaze[l_where])=='function' then
	        l_way = roomMaze[l_where]()
	    else
	        l_way = roomMaze[l_where]
	    end
	end
    if l_way then
        exe(l_way)
	    exe("yun jingli")
        chats_locate('��λϵͳ����ͼϵͳ�˵ص㡾'..locl.area .. locl.room ..'���޼�·�����ƶ�Ѱ��ȷ�ж�λ�㣡','red')
        return checkWait(goContinue,1)
    end
	   
    if table.getn(sour.rooms)>1 then
        chats_locate('��λϵͳ����ͼϵͳ�˵ص㡾'..locl.area .. locl.room ..'�����ڲ�ֹһ��������ƶ�Ѱ��ȷ�ж�λ�㣡','red')
        exe('stand;leave')
        exe(locl.dir)
        return checkWait(goContinue,1)
    end 
	
	chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'������!')
	path_create()
    return check_bei(path_start)
end
function path_cal()
    local l_sour,l_dest,l_path,l_distance
    sour.rooms={}
    dest.rooms={}

    if sour.id == nil then
        sour.room=locl.room
        sour.area=locl.area
        sour.rooms=getRooms(sour.room,sour.area)
        if table.getn(sour.rooms)==0 then
            Note('Path Cal GetSourRooms 0 Error!')
            return false
        end
        l_sour=sour.rooms[1]
    else
        l_sour=sour.id
    end
    if dest.id == nil then
        dest.rooms=getRooms(dest.room,dest.area)
        
        if table.getn(dest.rooms)==0 then
            Note('Path Cal GetDestRooms 0 Error!')
            return false
        end
	   
        l_dest,l_distance=getNearRoom(l_sour,dest.rooms)
	    if not l_dest then
		    messageShow("�޷�����".. dest.area .. dest.room)
		    return false
	    end
    end

    if dest.id ~= nil then l_dest = dest.id end
    if sour.id ~= nil then l_sour = sour.id end
    road.id = l_dest
	
	l_path = path_cal_get(l_sour,l_dest)
	
	if not l_path then
        return false
    end
	return l_path
end
function path_cal_get(l_sour,l_dest)
    if l_sour==l_dest then return "halt;" end
	
    local l_path, l_len, l_public 
	
	sjPathPublic = sjPathPublic or {}
	if isTableEmpty(sjPathPublic) or (sjPathPublic["time"] and os.time()-sjPathPublic["time"] > 12*60*60) then
	    sjPathPublic = dbPathPublicGetTime()
		sjPathPublic["time"] = os.time()
	end
	l_path=sjPathPublic[l_sour.. "|" .. l_dest]
	if l_path then return l_path end
	
	l_path=dbPathPublicGet(l_sour,l_dest)
	if l_path then return l_path end
	
    local doorNight = {["foshan/"] = true,
	                   ["hxshan/"] = true,
					   ["city/jiulou"]  = true,
					   ["city/zhubaodian"] = true,
					   ["fuzhou/bridge"]   = true,
					   ["fuzhou/wroad"]    = true,
					   ["fuzhou/shanpo"]    = true,
					   ["fuzhou/wjiuguan"]    = true,
					   ["group/entry/fzwroad5"] = true,
					   ["thd/guiyun/jiuguan"] = true,
					   ["xingxiu/yili/yili2"] = true,
					   ["xingxiu/yili/kezhan"] = true,
					   ["xingxiu/yili/house"]  = true,
					   ["xingxiu/yili/store"]  = true,
	                  }

	local doorClose = false
	if MidNight[locl.time] then
	    for p in pairs(doorNight) do 
		    if string.find(l_sour,p) or string.find(l_dest,p) then doorClose = true end
	    end	
	end
	if doorClose then
	    sjDark = sjDark or {}
		if isTableEmpty(sjDark) or (sjDark["time"] and os.time()-sjDark["time"] > 12*60*60) then
	        sjDark = dbDarkGetTime()
		    sjDark["time"] = os.time()
	    end
		l_path=sjDark[l_sour.. "|" .. l_dest]
	    if l_path then return l_path end
		
	    l_path=dbDarkGet(l_sour,l_dest)
	    if l_path then return l_path end
	    l_path=map:getPath(l_sour,l_dest)
		if l_path then
		    dbDarkInsert(l_sour,l_dest,l_path)
		end
		return l_path
	end
	
	sjPathSingle = sjPathSingle or {}
	if isTableEmpty(sjPathSingle) or (sjPathSingle["time"] and os.time()-sjPathSingle["time"] > 12*60*60) then
	    sjPathSingle = dbPathGetTime()
		sjPathSingle["time"] = os.time()
	end
	l_path=sjPathSingle[l_sour.. "|" .. l_dest]
	if l_path then return l_path end
	
    l_path=dbPathGet(l_sour,l_dest)
	if l_path then return l_path end
		
    l_path, l_len, l_public=map:getPath(l_sour,l_dest)
	if not l_path then return false end
	
	if l_public then
	    dbPathInsertPublic(l_sour,l_dest,"","",l_path)
	else
	    dbPathInsert(l_sour,l_dest,"","",l_path)
	end
	
    return l_path
end

function path_create()
    local l_set
    local l_num=0
    local l_cnt=1
    road.detail={}

    l_path=path_cal()
    --Note(l_path)
    if type(l_path)~='string' then
       if math.random(1,4)==1 then
          l_path='stand;out;northeast;northwest;southeast;southwest;south;south;south;south;south'
       elseif math.random(1,4)==2 then
          l_path='stand;out;northeast;northwest;southeast;southwest;east;east;east;east;east;east'
       elseif math.random(1,4)==3 then
          l_path='stand;out;northeast;northwest;southeast;southwest;west;west;west;west;west;west'
       else
          l_path='stand;out;northeast;northwest;southeast;southwest;north;north;north;north;north'
       end
    end
    l_set=utils.split(l_path,';')
    for i=1,table.getn(l_set) do
        if string.find(l_set[i],'#') then
	        if l_num>0 then
	          l_cnt=l_cnt+1
            end
	        road.detail[l_cnt]=l_set[i]
	        l_cnt=l_cnt+1
	        l_num=0
	    else
	        if l_num==0 then
	          road.detail[l_cnt]=l_set[i]
	        else
	          road.detail[l_cnt]=road.detail[l_cnt]..';'..l_set[i]
            end
	        l_num=l_num+1
	        if l_num>road.steps then
	           l_cnt=l_cnt+1
	           l_num=0
	        end
        end
    end

end
function path_start()
    EnableTrigger("hp12",false)
    EnableTimer("roadWait",false)
	DeleteTimer("roadWait",false)
    local l_road
    road.i=road.i + 1
    if flag.find==1 then return end  
    if road.i>table.getn(road.detail) then
       locate()
       --if job.name=='huashan' then
       --   return road.act()
       --else
          return check_bei(go_confirm)
       --end
    end
    l_road=road.detail[road.i]        
    if string.find(l_road,'#') then
       local _,_,func,params = string.find(l_road,"^#(%a%w*)%s*(.-)$")
       if func then
		return _G[func](params)
	end 
    else
       --exe(l_road)
	   create_alias('goset','goset','alias goalias '.. l_road)
       exe('goset')
	   exe('goalias')
       exe('yun jingli')
       return walk_wait()
    end
end

function go_confirm()
    --checkWield()
    sour.id = nil
    if flag.go==nil then flag.go=0 end
    flag.go = flag.go + 1
    if flag.go>3 then flag.go=0 end
    if locl.room==dest.room or flag.go==0 then
       if locl.room==dest.room  then
          chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'������������Ŀ�ĵء�'..dest.area .. dest.room ..'����','seagreen')
       else
          chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'��������δ��Ŀ�ĵء�'..dest.area .. dest.room ..'�����յ�Ϊ��'.. locl.area .. locl.room ..'����','cyan')
       end
       flag.go=0
       return road.act()
    else
       return go(road.act)
    end
end

function find(l_area,l_room)
    do return search() end
end

find_nobody=function()
    if string.find(job.name,'songxin') then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','greenyellow')
    end
    if job.name=='wudang' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','greenyellow')
    end
	if job.name=='clb' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','greenyellow')
    end
	if job.name=='husong' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','greenyellow')
    end
    
    flag.times=flag.times + 1
	
	if hp.exp < 3000 then return main() end
	
	if flag.times>2 then
	   jobFindFail = jobFindFail or {}
	   if job.name and jobFindFail[job.name] then
	      local p = jobFindFail[job.name]
		  return _G[p]()
	   else
	      return go(check_heal,'�����','ҩ��')
	   end
	else
	   jobFindAgain = jobFindAgain or {}
	   if job.name and jobFindAgain[job.name] then
	      local p = jobFindAgain[job.name]
		  return _G[p]()
	   else
	      return go(check_heal,'�����','ҩ��')
	   end
	end
    
end

function search()
    tmp.find = true
    if flag.find==1 then return end
	cntr1 = countR(15)
    exe('look')
    return check_busy(searchStart,1)
end
function searchPathGet()
	
	local l_path 
	
	local l_distance = 6
	if job.name and (job.name=="clb" or job.name=='tdh' or job.name=="tmonk") and flag.times==1 then
	   l_distance = 0
	end
	
	road.rooms={}
	local p_room = map.rooms[road.id].name
	local p_dest = getLookCity(road.id)
	
    local rooms = getAroundRooms(p_room,p_dest,l_distance,'all')
    local to = {}
    for id in pairs(rooms) do
	    table.insert(to,id)
    end
    local from = road.id
    for i=1,countTab(to) do
	    local l_dest,l_p=getNearRoom(from,to)
		if l_dest then
	        table.insert(road.rooms,l_dest)
        end		   
	    table.remove(to,l_p)
    end
	
	l_path = "halt;"
	while table.getn(road.rooms)>0 do
	    local path, length = path_cal_get(road.id, road.rooms[1])
		if type(path)=="string" then
		    l_path = l_path .. path
            road.id = road.rooms[1]            
		end
		table.remove(road.rooms,1)
	end
	return l_path
end
function searchStart()
    if flag.find==1 then return end
    if flag.wait==1 then return end
    
	local path = searchPathGet()
	
	return searchFunc(path)
	
end
function searchFunc(path)
    if flag.find==1 then return end
    if flag.wait==1 then return end
	
    road.pathset = road.pathset or {}
    if path then
        road.pathset=utils.split(path,";")
	    for i=1,table.getn(road.pathset) do
	        for p=1, table.getn(road.pathset) do
		        if isNil(road.pathset[p]) or road.pathset[p]=="halt" then
		 	        table.remove(road.pathset,p)
		 		    break
		 	    end
		    end
	    end
	end
	if table.getn(road.pathset)==0 then
	   --return searchStart()
	   return find_nobody()
	end

    if string.find(road.pathset[1],'#') then
	    local _,_,func,params = string.find(road.pathset[1],"^#(%a%w*)%s*(.-)$")
	    if func then
	        table.remove(road.pathset,1)
	        return _G[func](params)
	    else
	        exe(road.pathset[1])
	        table.remove(road.pathset,1)
		    return walk_wait()
	    end
	else
	    exe(road.pathset[1])
	    table.remove(road.pathset,1)
		return walk_wait()
	end
end

function searchWait()
    EnableTriggerGroup("find",true)
    exe('alias action ������Ѱ��')
end

delElement=function(set,dir)
    local l_cnt=0
    for i=1,table.getn(set) do
        if set[i]==dir then
           l_cnt=i
           break
        end
    end
    table.remove(set,l_cnt)
    return set
end

wipe_trigger=function()
    DeleteTriggerGroup("wipe")
    create_trigger_t('wipe1',"^>*\\s*(\\D*)��\\D*��Ķ����ˡ�$",'','wipe_goon')
    create_trigger_t('wipe2',"^>*\\s*(\\D*)��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����",'','wipe_goon')
    create_trigger_t('wipe3',"^>*\\s*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ",'','wipe_faint')
    create_trigger_t('wipe7',"^>*\\s*(\\D*)���Ӷ��˶������������˼��������ѹ���",'','wipe_wake')
    create_trigger_t('wipe4',"^>*\\s*�����(\\D*)(�ͺ�|���|���|�ȵ�|����һ��)",'','wipe_who')
    create_trigger_t('wipe5',"^>*\\s*����û������ˡ�",'','wipe_over')
    create_trigger_t('wipe6',"^>*\\s*��Ҫ��˭�����������",'','wipe_over')
    SetTriggerOption("wipe1","group","wipe")
    SetTriggerOption("wipe2","group","wipe")
    SetTriggerOption("wipe3","group","wipe")
    SetTriggerOption("wipe4","group","wipe")
    SetTriggerOption("wipe5","group","wipe")
    SetTriggerOption("wipe6","group","wipe")
    SetTriggerOption("wipe7","group","wipe")
    EnableTriggerGroup("wipe",false)    
end
wipe=function(wipe_str,wipe_con)
    wipe_trigger()
    EnableTriggerGroup("wipe",true)
    road.wipe_id=wipe_str
    road.wipe_con=wipe_con
    weapon_wield()
    if WipeNoPerform[road.wipe_id] or tmp.gold then
       exe('kill '..road.wipe_id)
       if score.party and score.party=="�䵱��" then
          exe("jiali 0")
       else
          exe("jiali 1")
       end
	   exe('unset wimpy')
    else
       killPfm(road.wipe_id)
    end
    create_timer_s('wipe',2,'wipe_set')
end
wipe_set=function()
    exe('kill '..road.wipe_id)
end
wipe_who=function(n,l,w)
    road.wipe_who=Trim(w[1])
    job.killer=job.killer or {}
    if not WipeNoPerform[road.wipe_id] then
       job.killer[road.wipe_who]=road.wipe_id
    end
end
wipe_faint=function(n,l,w)
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
       job.killer[road.wipe_who]="faint"
    end
end
wipe_wake=function(n,l,w)
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
    end
end
wipe_goon=function(n,l,w)
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
    end
end
wipe_over=function()
    DeleteTimer('wipe')
    DeleteTimer('perform')
    EnableTriggerGroup("wipe",false)
	DeleteTriggerGroup("wipe")
    road.wipe_id="wipe_id"
    exe('get silver from corpse;get silver from corpse 2;get gold from corpse;get gold from corpse 2')
	exe('set wimpy 100')
    if road.wipe_con~=nil then
       return check_bei(road.wipe_con)
    else
       return check_bei(walk_wait)
    end   
end

function thread_resume(thread)
    if type(thread)=='thread' then
       coroutine.resume(thread)
    end
end
function walkBusy()
    if locl.room and locl.room=="ϴ��ر�" then
	   return check_bei(walk_wait)
	end
    return check_halt(walk_wait)
end

hsssl=function()
    road.temp=0
    exe('n;e;e')
    return hsssl_check()
end
function hsssl_check()
    locate()
    return checkWait(hsssl_goon,0.2)
end
hsssl_goon=function()
       road.temp = road.temp + 1
       if road.temp > 100 then
          dis_all()
	      return check_heal()
       end
       if locl.room=='����' or locl.room=='������' or locl.room=='�յ�' then
          exe('n;e;e')
          return check_bei(hsssl_check,1)
       else
          return hsssl_out()
       end
end
hsssl_out=function()
    return walk_wait()
end

hscaidi=function()
    DeleteTriggerGroup("hscaidi")
    create_trigger_t('hscaidi1','^>*\\s*��� "action" �趨Ϊ "�뿪�˵�����" �ɹ���ɡ�$','','hscaidi_goon')    
    create_trigger_t('hscaidi2','^>*\\s*������\\s*\\-','','hscaidi_out')
    SetTriggerOption("hscaidi1","group","hscaidi")
    SetTriggerOption("hscaidi2","group","hscaidi")
    flag.find=0
    road.temp=0
    exe('n;alias action �뿪�˵�����')
end
hscaidi_goon=function()
    if flag.find==1 then
       EnableTriggerGroup("hscaidi",false)
       return walk_wait()
    else
       road.temp = road.temp + 1
       if road.temp > 100 then
          dis_all()
	      return check_heal()
       end
       wait.make(function()
	      wait.time(0.1)
          exe('n;alias action �뿪�˵�����')
       end)
    end
end
hscaidi_out=function()
    EnableTriggerGroup("hscaidi",false)
	DeleteTriggerGroup("hscaidi")
    return walk_wait()
end

duhe_trigger=function()
    DeleteTriggerGroup("duhe")
    create_trigger_t('duhe1','^>*\\s*�����ǰ�̤�Ű�������','','duhe_duhe')
    create_trigger_t('duhe2','^>*\\s*˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ','','duhe_out')
    create_trigger_t('duhe3','^>*\\s*(��|��)��̫���ˣ����û����;�����ĵط�����û����Խ��ȥ��','','duhe_wait')
    create_trigger_t('duhe4','^>*\\s*��ľ��������ˣ�','','duhe_jingli')
    create_trigger_t('duhe5','^>*\\s*���\\D*��Ϊ����','','duhe_cannt')
    create_trigger_t('duhe6','^>*\\s*������������ˣ�','','duhe_wait')
    create_trigger_t('duhe7','^>*\\s*��������������ȴ�������ϴ���Ǯ�����ˡ�','','duhe_silver')
    create_trigger_t('duhe8','^>*\\s*��һ����Ϣ����׼��(��|��)�жɴ�λ�ã�ʹ��','','duhe_fly')
    create_trigger_t('duhe9','^>*\\s*�����ǰ�̤�Ű���������������һ��','','duhe_duhe')
    create_trigger_t('duhe10','^>*\\s*һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����','','duhe_enter')
    create_trigger_t('duhe11','^>*\\s*�д������������Cool����','','duhe_wait')
    create_trigger_t('duhe12','^>*\\s*���ڽ��жɴ�������һ�㣬��������','','duhe_fly')
    SetTriggerOption("duhe1","group","duhe")
    SetTriggerOption("duhe2","group","duhe")
    SetTriggerOption("duhe3","group","duhe")
    SetTriggerOption("duhe4","group","duhe")
    SetTriggerOption("duhe5","group","duhe")
    SetTriggerOption("duhe6","group","duhe")
    SetTriggerOption("duhe7","group","duhe")
    SetTriggerOption("duhe8","group","duhe")
    SetTriggerOption("duhe9","group","duhe")
    SetTriggerOption("duhe10","group","duhe")
    SetTriggerOption("duhe11","group","duhe")
    SetTriggerOption("duhe12","group","duhe")
    EnableTriggerGroup("duhe",false)
end
duHhe=function()
    if hp.neili_max > 3000 then
	   flag.duhe=1
	end
	if GetVariable("flagdujiang") then
	   flag.duhe=tonumber(GetVariable("flagdujiang"))
	end
    duhe_trigger()
    locate()
    return check_bei(duHhe_start)
end
duHhe_start=function()
    if string.find(locl.room,'��') then
       EnableTriggerGroup("duhe",true)
       if flag.duhe==1 then
          return exe('yell boat;duhe')
       else
          return duhe_enter()
       end
    else
       if math.random(1,10)>1 then
          return go(road.act)
       else
          return duhe_over()
       end
    end
end
duhe_duhe=function()
    if flag.duhe==1 then
       prepare_neili_stop()
       return check_bei(duhe_jump)
    end
end
duhe_jump=function()
    return exe('yell boat;duhe')
end
duhe_enter=function()
    if flag.duhe==0 then
       prepare_neili_stop()
       return check_bei(duhe_enter_in)
    end
end
duhe_enter_in=function()
    prepare_neili_stop()
    exe('yell boat;enter')
    locate()
    return check_busy(duhe_enter_check)
end
duhe_enter_check=function()
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
       return prepare_neili_stop()
    else
       if not GetVariable("flagdujiang") then
          return prepare_lianxi()
	   end
    end
end
duhe_out=function()
    exe('out')
    return duhe_over()
end
duhe_over=function()
    EnableTriggerGroup("duhe",false)
    DeleteTriggerGroup("duhe")
    weapon_unwield()
    weapon_wield()
    return walk_wait()
end
duhe_wait=function()
    return prepare_lianxi(duHhe_start)
end
duhe_jingli=function()
    return exe('yun jingli;duhe')
end
duhe_cannt=function()
    flag.duhe=0
	jifaDodge()
    return checkWait(duHhe_start,0.5)
end
duhe_silver=function()
    EnableTriggerGroup("duhe",false)
    exe('dig')
    return check_bei(duHhe)
end
duhe_fly=function()
    if _G["chatWhoList"] then
        _G["chatWhoList"]()
    end
    return check_bei(duhe_over)
end
dujiang_trigger=function()
    DeleteTriggerGroup("dujiang")
    --create_trigger_t('dujiang1','^(> )*�����ˮ̫��̫������ɲ���ȥ��','','')
    create_trigger_t('dujiang2','^(> )*(�ɴ��͵�һ���Ѿ�����|����˵���������ϰ��ɡ�)','','dujiang_out')
    create_trigger_t('dujiang3','^(> )*(��|��)��̫���ˣ����û����;�����ĵط�����û����Խ��ȥ��','','dujiang_wait')
    create_trigger_t('dujiang4','^(> )*��ľ��������ˣ�','','dujiang_jingli')
    create_trigger_t('dujiang5','^(> )*���\\D*��Ϊ����','','dujiang_cannt')
    create_trigger_t('dujiang6','^(> )*������������ˣ�','','dujiang_wait')
    create_trigger_t('dujiang7','^(> )*�����ˮ̫��̫������ɲ���ȥ��','','dujiang_move')
    create_trigger_t('dujiang8','^(> )*��һ����Ϣ����׼��(��|��)�жɴ�λ�ã�ʹ��','','dujiang_fly')
    create_trigger_t('dujiang9','^(> )*����(��|)��̤�Ű���','','dujiang_dujiang')
    create_trigger_t('dujiang10','^(> )*һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����','','dujiang_enter')
    create_trigger_t('dujiang11','^(> )*�д������������Cool����','','dujiang_wait')
    create_trigger_t('dujiang12','^(> )*���ڽ��жɴ�������һ�㣬��������','','dujiang_fly')
    SetTriggerOption("dujiang1","group","dujiang")
    SetTriggerOption("dujiang2","group","dujiang")
    SetTriggerOption("dujiang3","group","dujiang")
    SetTriggerOption("dujiang4","group","dujiang")
    SetTriggerOption("dujiang5","group","dujiang")
    SetTriggerOption("dujiang6","group","dujiang")
    SetTriggerOption("dujiang7","group","dujiang")
    SetTriggerOption("dujiang8","group","dujiang")
    SetTriggerOption("dujiang9","group","dujiang")
    SetTriggerOption("dujiang10","group","dujiang")
    SetTriggerOption("dujiang11","group","dujiang")
    SetTriggerOption("dujiang12","group","dujiang")
    EnableTriggerGroup("dujiang",false)
end
duCjiang=function()
    tmp.dujiang = "east"
    if hp.neili_max > 3500 then
	   flag.dujiang=1
	end
	if GetVariable("flagdujiang") then
	   flag.dujiang=tonumber(GetVariable("flagdujiang"))
	end
    dujiang_trigger()
    locate()
    return check_bei(duCjiang_start)
end
duCjiang_start=function()
    if string.find(locl.room,'��') then
       EnableTriggerGroup("dujiang",true)
       if flag.dujiang==1 then
          return exe('yell boat;dujiang')
       else
          return dujiang_enter()
       end
    else
       if math.random(1,10)>1 then
          return go(road.act)
       else
          return dujiang_over()
       end
    end
end
dujiang_dujiang=function()
    if flag.dujiang==1 then
       prepare_neili_stop()
       return check_bei(dujiang_jump)
    end
end
dujiang_jump=function()
    exe('yell boat;dujiang')
end
dujiang_enter=function()
    if flag.dujiang==0 then
       prepare_neili_stop()
       return check_bei(dujiang_enter_in)
    end
end
dujiang_enter_in=function()
    prepare_neili_stop()
    exe('yell boat;enter')
    locate()
    return check_busy(dujiang_enter_check)
end
dujiang_enter_check=function()
    local Change = {
	      ["east"] = "w;w",
		  ["w;w"] = "e",
          ["e"]	= "east",	  
	}
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
    else
	   --if not GetVariable("flagdujiang") then
	      if locl.room == "�����ϰ�" or locl.room == "��������" then
	         if not tmp.dujiang or not Change[tmp.dujiang] then tmp.dujiang="east" end
		     exe(tmp.dujiang)
		     tmp.dujiang = Change[tmp.dujiang]
	         return checkWait(duCjiang_start,1)
	      else
             return prepare_lianxi()
		  end
	   --end
    end
end
dujiang_out=function()
    exe('out')
    return dujiang_over()
end
dujiang_over=function()
    EnableTriggerGroup("dujiang",false)
    DeleteTriggerGroup("dujiang")
    weapon_unwield()
    weapon_wield()
	exe('e;e;w')
    return walk_wait()
end
dujiang_wait=function()
    return prepare_lianxi(duCjiang_start)
end
dujiangChange=function()
    local Change = {
	      ["east"] = "w;w",
		  ["w;w"] = "e",
          ["e"]	= "east",	  
	}
    if locl.room == "�����ϰ�" or locl.room == "��������" then
	    if not tmp.dujiang or not Change[tmp.dujiang] then tmp.dujiang="east" end
		exe(tmp.dujiang)
		tmp.dujiang = Change[tmp.dujiang]
	    return checkWait(duCjiang_start,1)
	else
	   return dujiang_wait()
	end
end
dujiang_jingli=function()
    return exe('yun jingli;dujiang')
end
dujiang_cannt=function()
    flag.dujiang=0
	jifaDodge()
    return checkWait(duCjiang_start,0.5)
end
dujiang_fly=function()
    if _G["chatWhoList"] then
        _G["chatWhoList"]()
    end
    return check_bei(dujiang_over)
end
dujiang_move=function()
   exe('e;e;w')
   return dujiang_dujiang()
end

jqgin=function()
   DeleteTriggerGroup("jqgin")
   create_trigger_t('jqgin1','^>*\\s*��Ҫ��ʲô��','','jqgin_look')
   create_trigger_t('jqgin2','^>*\\s*һҶС�ۣ�ƮƮ����������Ϫ����������ȥ��','','jqgin_jump')
   create_trigger_t('jqgin3','^>*\\s*�ֻ��������Ϫ�ĺ��оſ��ʯӭ����������������һ�㣬��ס������ȥ·��','','jqgin_out') 
   SetTriggerOption("jqgin1","group","jqgin")
   SetTriggerOption("jqgin2","group","jqgin")
   SetTriggerOption("jqgin3","group","jqgin")
   road.temp=0
   exe('look boat')
end
jqgin_look=function()
   road.temp = road.temp + 1
   if road.temp > 100 then
      dis_all()
      check_heal()
      return
   end
   wait.make(function() 
      wait.time(2)
      exe('look boat')
   end)
end
jqgin_jump=function()
   exe('jump boat')
end
jqgin_out=function()
   EnableTriggerGroup("jqgin",false)
   DeleteTriggerGroup("jqgin")
   exe('out')
   --thread_resume(walk)
   walk_wait()
end
jqgout=function()
   DeleteTriggerGroup("jqgout")
   create_trigger_t('jqgout1','^>*\\s*�����ű�����ô�ƶ�С�ۣ�','','jqgout_weapon')
   create_trigger_t('jqgout2','^>*\\s*�ֻ��������Ϫ�����ۣ�С�۾������˼�������ֻص�Ϫ�ߡ�','','jqgout_out')
   SetTriggerOption("jqgout1","group","jqgout")
   SetTriggerOption("jqgout2","group","jqgout")
   jqgout_weapon()
end
jqgout_weapon=function()
   weapon_unwield()
   exe('tui boat')
   check_bei(jgqout_jump)
end
jgqout_jump=function()
   exe('jump boat')
end
jqgout_out=function()
   EnableTriggerGroup("jqgout",false)
   DeleteTriggerGroup("jqgout")
   exe('out')
   --thread_resume(walk)
   walk_wait()
end
jqgzlin=function()
   DeleteTriggerGroup("jqgzlin")
   create_trigger_t('jqgzlin1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','jqgzlin_goon')
   SetTriggerOption("jqgzlin1","group","jqgzlin")
   exe('nd')
   locate()
   check_bei(jqgzlin_con)
end
function jqgzlin_con()
   exe('alias action �뿪��������')
end
jqgzlin_goon=function()
   if locl.room~="����" then
      return jqgzlin_over()
   end
   local l_set={'east','west','south','north'}
   local l_cnt=math.random(1,table.getn(l_set))
   exe(l_set[l_cnt])
   exe('su;nd;wd')
   locate()
   checkWait(jqgzlin_con,1)
end
jqgzlin_over=function()
   EnableTriggerGroup("jqgzlin",false)
   DeleteTriggerGroup("jqgzlin")
   walk_wait()
end
jqgzlout=function()
   DeleteTriggerGroup("jqgzlout")
   create_trigger_t('jqgzlout1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','jqgzlout_goon')
   SetTriggerOption("jqgzlout1","group","jqgzlout")
   exe('eu')
   locate()
   check_bei(jqgzlout_con)
end
function jqgzlout_con()
   exe('alias action �뿪��������')
end
jqgzlout_goon=function()
   if locl.room~="����" then
      return jqgzlout_over()
   end
   local l_set={'east','west','south','north'}
   local l_cnt=math.random(1,table.getn(l_set))
   exe(l_set[l_cnt])
   exe('wd;eu;su')
   locate()
   checkWait(jqgzlout_con,1)
end
jqgzlout_over=function()
   EnableTriggerGroup("jqgzlout",false)
   DeleteTriggerGroup("jqgzlout")
   walk_wait()
end

function outJjl()
   locate()
   check_bei(outJjl_check)
end
function outJjl_check()
   if locl.room~='������' and locl.room~='ɽ·' then
      return outJjl_over()
   else
      exe('yun jingli;yun qi;s')
      return outJjl()
   end
end
function outJjl_over()
   walk_wait()
end

function goHt()
	exe("ask gongsun zhi about �����")
	check_bei(goHt_act)
end
function goHt_act()
	exe("xian hua;zuan dao")
	walk_wait()
end

function outGb()
        locate()
	check_bei(outGb_check)
end
function outGb_check()
	if locl.room~="����" then
           return outGb_over()
	else
	   wait.make(function()
	      exe("#12s")
	      wait.time(1)
              return outGb()
           end)
	end
end
function outGb_over()
        exe('north')
        walk_wait()
end

function toQc()
        locate()
	check_bei(toQc_check)
end
function toQc_check()
	if locl.room~="ɳĮ" then
           return toQc_over()
	else
	   --wait.make(function()
	      exe("#5s;#5n")
	    --  wait.time(1.5)
              return toQc()
         --  end)
	end
end
function toQc_over()
        walk_wait()
end

function outzsl()
    exe("halt;nw;w")
    locate()
	return checkWait(outzsl_check,0.3)
end
function outzsl_check()
    if locl.room == "�����" then
	   exe("halt;#3s")
	   return outzsl_over()
	end
	if locl.room == "��ˮ��" then
	   return outzsl_over()
	end 
	if locl.room ~= "��ɼ��" and 
	   locl.room ~= "������" and 
	   locl.room ~= "������" and 
	   locl.room ~= "������" and 
	   locl.room ~= "������" then
	    return outzsl_over()
	else
	    return outzsl()
	end
end
function outzsl_over()
        walk_wait()
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

function mjMen(way, name)
    DeleteTriggerGroup("zsl")
    create_trigger_t('zsl1',"^(> )*(\\D*)- $",'','zslLook')
    SetTriggerOption("zsl1","group","zsl")    
	exe("se;" .. way)
	exe("l east;l south;l west;l north")
	tmp.look = 0
	tmp.men = {}
	tmp.way = way
	tmp.name = name
	return check_busy(mjMenLocate,0.2)
end
function zslLook(n,l,w)
    tmp.men = tmp.men or {}
    tmp.look = tmp.look or 0
	tmp.look = tmp.look + 1
	local direct = {
	    [1] = "east",
		[2] = "south",
		[3] = "west",
		[4] = "north",
	}
	local lroom = Trim(w[2])
	if string.find(lroom,"����") then
	    tmp.men[lroom] = direct[tmp.look]
	end
end
function mjMenLocate()
    EnableTriggerGroup("zsl",false)
	DeleteTriggerGroup("zsl")
    tmp.men = tmp.men or {}
    if tmp.men[tmp.name] then
	    exe(tmp.men[tmp.name])
		locate()
		return check_busy(mjMen_check,0.2)
	end 
	return mjMen(tmp.way,tmp.name)
end
function mjMen_check()    
    if locl.room==tmp.name then
	   return mjMen_over()
	else
	   return mjMen(tmp.way,tmp.name)
	end
end
function mjMen_over()
        walk_wait()
end

function outZyl()
   DeleteTriggerGroup("outzyl")
   create_trigger_t('outzyl1','^>*\\s*��� "action" �趨Ϊ "�뿪��Ҷ������" �ɹ���ɡ�','','outZylCheck')
   create_trigger_t('outzyl2','^>*\\s*���۵ð���������ҵ�����ȷ�ķ���','','outZyl_over')
   SetTriggerOption("outzyl1","group","outzyl")
   SetTriggerOption("outzyl2","group","outzyl")
   --exe('alias action �뿪��Ҷ������')
   cntr1 = countR(50)
   --road.zyl = road.zyl or {}
   --for p in pairs(road.zyl) do
   --    tmp.oz = p
   --end
   road.zyl = {}
   return outZylCheck()
end
function outZylCheck()
   locate()
   return check_busy(outZyl_goon,1)
end
function outZyl_goon()
   if locl.room~="��Ҷ��" then
      return go(road.act)
   end
   road.zyl = road.zyl or {}
   if countTab(road.zyl)==0 then
      road.zyl["#10e"] = true
	  road.zyl["#10s"] = true
	  road.zyl["#10w"] = true
	  road.zyl["#10n"] = true
   end
   for p in pairs(road.zyl) do
       tmp.zyl = p
	   road.zyl[p] = nil
       exe('halt;ne')
       exe(p)
       return exe('alias action �뿪��Ҷ������')
   end
end
function outZyl_over()
   EnableTriggerGroup("outzyl",false)
   DeleteTriggerGroup("outzyl")
   --road.zyl = {}
   --road.zyl[tmp.zyl] = true
   --if tmp.zyl and (not tmp.oz or tmp.oz ~= tmp.zyl) and math.random(1,5)==1 then 
   --   exe('irc ��Ҷ��Ŀǰ·��Ϊ'.. tmp.zyl ..'����')
   --end
   walk_wait()
end

function dmd()
    if not tmp.dmd then
	   tmp.dmd = true
	   exe("s;w;n;nw;n")
	else
	   exe('nw;w;e;e;s;w;n;nw;n')
	end
	locate()
	check_bei(dmd_check)
end
function dmd_check()
	if locl.room ~= "����" then
	   return dmd_over()
	else
	   wait.make(function()
	      wait.time(1)
	      return dmd()
	   end)
	end
end
function dmd_over()
        walk_wait()
end

function toXcm()
	weapon_unwield()
	weaponWieldCut()
	exe("zhan tielian")
    return check_bei(toXcm_jump)
end
function toXcm_jump()
	exe("jump duimian")
	return check_bei(toXcm_over)
end
function toXcm_over()
    weapon_unwield()
    return walk_wait()
end

function outTlsSsl()
        exe("s;w;s;w")
	exe("#11 s")
	locate()
	return check_bei(outTlsSsl_check,1)
end
function outTlsSsl_check()
	if locl.room ~= "������" and locl.room ~= "ʯ��·" then
	   return outTlsSsl_over()
	else
	   return outTlsSsl()
	end
end
function outTlsSsl_over()
    return walk_wait()
end

function hmyUp()
    jifaDodge()
    exe('zong')
	return check_bei(hmyUpLocate,1)
end
function hmyUpLocate()
        locate()
	return check_bei(hmyUpCheck)
end
function hmyUpCheck()
        if locl.room ~= "����ƺ" then
	   return hmyUpOver()
	else
	   return hmyUp()
	end
end
function hmyUpOver()
    return walk_wait()
end

function hmyDown()
    jifaDodge()
    exe('zong')
	check_bei(hmyDownLocate)
end
function hmyDownLocate()
        locate()
	return check_bei(hmyDownCheck,1)
end
function hmyDownCheck()
        if locl.room ~= "�¶�" then
	   return hmyDownOver()
	else
	   return hmyDown()
	end
end
function hmyDownOver()
    return walk_wait()
end

function toRyp()
	exe("whisper bu �����ĳ���£�һͳ����")
	exe("whisper bu ����ǧ�����أ�һͳ����")
	exe("whisper bu ��������Ϊ������������")
	exe("whisper bu ������ּӢ���������Ų�")
	exe("whisper bu �����������£��츣����")
	exe("whisper bu ����ս�޲�ʤ�����޲���")
	exe("whisper bu ��������ĳ���¡�����Ӣ��")
	exe("whisper bu ��������ʥ�̣��󱻲���")
	exe("wu")
    return walk_wait()
end

function boatYell()
    exe("yell boat;enter")
	locate()
	tmp.cnt = 0
	DeleteTimer('boat')
	create_timer_s('boat',3,'boatInCheck')
end
function boatInCheck()
    DeleteTimer('boat')
	tmp.cnt = tmp.cnt + 1
	if tmp.cnt > 20 then
	   return boatOut()
	end
	exe('yell boat;enter')
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
	   return boatWait()
	else
	   locate()
	   return create_timer_s('boat',3,'boatInCheck')
	end
end
function boatWait()
	DeleteTimer('boat')
	create_timer_s('boat',15,'boatCheck')
end
function boatCheck()
        DeleteTimer('boat')
	locate()
	check_bei(boatOutCheck)
end
function boatReCheck()
        DeleteTimer('boat')
	boatOutTrigger()
	create_timer_s('boat',2,'boatCheck')
end
function boatOutCheck()
        DeleteTimer('boat')
        local cnt=table.getn(exits.locl)
	if cnt==0 then
	   check_bei(boatReCheck)
	else
	   return boatOut()
	end
end
function boatOutTrigger()
    DeleteTriggerGroup("boat")
    create_trigger_t('boat1','^(> )*(�����С�ۿ��ڰ��ߣ����´��ɡ�|����˵���������ϰ��ɡ����漴��һ��̤�Ű���ϵ̰���|���ڵ���С���ߣ������С�ۿ��ڰ��ߣ����´��ɡ�)','','boatOut')
	SetTriggerOption("boat1","group","boat")  
end
function boatOut()
    EnableTimer('boat',false)
    DeleteTimer('boat')
	DeleteTriggerGroup("boat")
        exe("out")
        walk_wait()
end

function outJgzW()
    return outJgz()
end
function outJgzE()
    return outJgz()
end 
function outJgz()
    DeleteTriggerGroup("jiugz")
    create_trigger_t('jiugz1','^>*\\s*����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵�����(\\D*)���һ�\\(taohua\\)��$','','outJgzGet')
    create_trigger_t('jiugz2','^>*\\s*����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵���һ���һ�\\(taohua\\)Ҳû�С�$','','outJgzGo')
    SetTriggerOption("jiugz1","group","jiugz") 
    SetTriggerOption("jiugz2","group","jiugz")
    EnableTriggerGroup("jiugz",false)
    exe('w;w;n;n')
    return outJgzTaohua(1)
end
function outJgzTaohua(p_cnt)
    if p_cnt then tmp.i=p_cnt else tmp.i=tmp.i+1 end
    if tmp.i==2 then exe('e') end
    if tmp.i==3 then exe('e') end
    if tmp.i==4 then exe('s') end
    if tmp.i==5 then exe('w') end
    if tmp.i==6 then exe('w') end
    if tmp.i==7 then exe('s') end
    if tmp.i==8 then exe('e') end
    if tmp.i==9 then exe('e') end
	if tmp.i==10 then
	   return outJgzDrop()
	end
	EnableTriggerGroup("jiugz",true)
    exe('look')
end
function outJgzGet(n,l,w)
    EnableTriggerGroup("jiugz",false)
    exe('get '.. trans(w[1]) .. ' taohua')
    return check_bei(outJgzTaohua)
end
function outJgzGo()
    EnableTriggerGroup("jiugz",false)
    return check_bei(outJgzTaohua)
end
function outJgzDrop()
    exe('w;w;n;n')
    exe('drop 2 taohua')
	exe('e')
	exe('drop 9 taohua')
	exe('e')
	exe('drop 4 taohua')
	exe('s')
	exe('drop 3 taohua')
	exe('w')
	exe('drop 5 taohua')
	exe('w')
	exe('drop 7 taohua')
	exe('s')
	exe('drop 6 taohua')
	exe('e')
	exe('drop 1 taohua')
	exe('e')
	exe('drop 8 taohua')
	locate()
	return check_bei(outJgzCheck)
end
function outJgzCheck()
    if locl.room=="�Ź��һ���" then
	   return outJgz()
	else
	   return outJgzOver()
	end
end
function outJgzOver()
    EnableTriggerGroup("jiugz",false)
	DeleteTriggerGroup("jiugz")
	return walk_wait()
end

function wdYm()
    DeleteTriggerGroup("wdxj")
    create_trigger_t('wdxj1','^>*\\s*��վ��С���ϣ����ܴ������·𿴼�(\\D*)����Щ���⡣$','','wdYmGo')
    SetTriggerOption("wdxj1","group","wdxj")
    exe('s')
    locate()
    check_bei(wdYmCheck)
    tmp.i=1
end
function wdYmCheck()
    DeleteTimer("wdxjTimer")
    if locl.room~="С��" then
       return wdYmOver()
    end
    create_timer_s('wdxjTimer',15,'wdYmRandom')
end
function wdYmRandom()
    tmp.i=tmp.i+1
    exe('s')
    locate()
    check_bei(wdYmCheck)
end
function wdYmGo(n,l,w)
    local l_dir
    DeleteTimer("wdxjTimer")
    if w[1]=="��" then l_dir='e' end
    if w[1]=="��" then l_dir='w' end
    if w[1]=="��" then l_dir='s' end
    if w[1]=="��" then l_dir='n' end
    exe(l_dir)
    locate()
    check_bei(wdYmCheck)
end
function wdYmOver()
    DeleteTimer("wdxjTimer")
    EnableTriggerGroup("wdxj",false)
	DeleteTriggerGroup("wdxj")
    walk_wait()
end

function mjSlout()
    locate()
    check_bei(mjSloutCheck)
end
function mjSloutCheck()
    if locl.room=="������" then
       return mjSloutOver()
    end
    if locl.room=="�����" then
       return mjScout()
    end
    if locl.id["��ʯͷ"] then 
       exe('halt;e;nu') 
    elseif locl.id["������"] then 
       exe('halt;w;nu') 
    else 
       exe(locl.dir) 
    end
    return check_bei(mjSlout)
end
function mjScout()
    locate()
    check_bei(mjScoutCheck)
end
function mjScoutCheck()
    if locl.room=="������" then
       return mjSloutOver()
    end
    if locl.room=="����" then
       return mjSlout()
    end
    if locl.id["�ϻ�"] then 
       exe('halt;n;w;nu') 
    elseif locl.id["С��֦"] then 
       exe('halt;w;nw;n;w;nu') 
    elseif locl.id["����ʬ��"] then 
       exe('halt;nw;n;w;nu') 
    elseif locl.id["������"] then 
       exe('halt;w;n;w;nu') 
    else 
       exe(locl.dir) 
    end
    return check_bei(mjScout)
end
function mjSloutOver()
    walk_wait()
end

function ptoSld()
    exe('yell ������鸣����')
    checkWait(ptoSldCheck,2)
end
function ptoSldCheck()
    locate()
    check_bei(ptosldDukou)
end
function ptosldDukou()
    if locl.room=="�ɿ�" then
       return toSldOver()
    else
       return checkWait(ptoSldCheck,2)
    end
end

function toSld()
    weapon_unwield()
    weaponWieldCut()
	if not Bag["������"] then
       exe('buy cu shengzi')
       exe('drop cu shengzi 2')
	end
    return check_bei(toSldChop)
end
function toSldChop()
    exe('chop tree;bang mu tou;zuo mufa')
	checkBags()
    locate()
    return check_bei(toSldCheck,1)
end
function toSldCheck()
    if locl.room=="Сľ��" or locl.room=="ľ��" then
       return toSldHua()
    else
       return toSld()
    end
end
function toSldHua()
    weapon_unwield()
    exe('hua mufa')
    checkWait(toSldDukou,2)
end
function toSldDukou()
    locate()
    check_bei(toSldDkCheck)
end
function toSldDkCheck()
    if locl.room=="�ɿ�" then
       return toSldOver()
    else
       return toSldHua()
    end
end
function toSldOver()
    return walk_wait()
end

function outSld()
    if score.party and score.party=="������" then
       exe('ask lu gaoxuan about ling pai')
    else
       exe('steal lingpai')
    end
    check_bei(outSldGive)
end
function outSldGive()
    exe('out;#3s;give ling pai to chuan fu')
    checkWait(outSldWait,3)
end
function outSldWait()
    locate()
    check_bei(outSldCheck)
end
function outSldCheck()
    if locl.room=="�ɿ�" then
       exe('#3n;enter')
       return outSld()
    else
	   cntr1 = countR(20)
       return outSldBoat()
    end
end
function outSldBoat()
    if cntr1() < 1 then
	   return go(road.act)
	end
    exe('order ����')
    locate()
    return check_bei(outSldBoatCheck)
end
function outSldBoatCheck()
    if locl.room=="��̲" then
       return outSldOver()
    else
       return checkWait(outSldBoat,3)
    end
end
function outSldOver()
    walk_wait()
end

function PoutSld()
    if score.party and score.party=="������" then
       exe('ask lu gaoxuan about ling pai')
    else
       exe('steal lingpai')
    end
    return check_bei(PoutSldGive)
end
function PoutSldGive()
    exe('out;#3s;give ling pai to chuan fu')
    return checkWait(PoutSldWait,3)
end
function PoutSldWait()
    locate()
    return check_bei(PoutSldCheck)
end
function PoutSldCheck()
    if not string.find(locl.room,"��") then
       exe('#3n;enter')
       return PoutSld()
    else
	   cntr1 = countR(20)
       return PoutSldBoat()
    end
end
function PoutSldBoat()
    if cntr1() < 1 then
	   return go(road.act)
	end
    exe('order ȥ�뺣��')
    locate()
    return check_bei(PoutSldBoatCheck)
end
function PoutSldBoatCheck()
    if not string.find(locl.room,"��") then
       return PoutSldOver()
    else
       return checkWait(PoutSldBoat,3)
    end
end
function PoutSldOver()
    return walk_wait()
end

function outHeiw()
    exe('repent')
    locate()
    check_bei(outHeiwCheck)
end
function outHeiwCheck()
    if locl.room~="����" then
       return outHeiwOver()
    end
    checkWait(outHeiw,15)
end
function outHeiwOver()
    walk_wait()
end

function goXtj()
    DeleteTriggerGroup("goxtj")
    create_trigger_t('goxtj1',"^(> )*����\\s*\\-",'','goXtjShulin')
    create_trigger_t('goxtj2',"^(> )*ɽ·\\s*\\-",'','goXtjShanlu')
    SetTriggerOption("goxtj1","group","goxtj")
    SetTriggerOption("goxtj2","group","goxtj")
    EnableTriggerGroup("goxtj",false)

    exe('n')
    locate()
    check_bei(goXtjCheck)
end
function goXtjCheck()
    if locl.room~="����" then
       return goXtjOver()
    end
    
    tmp.goxtj=0
    EnableTriggerGroup("goxtj",true)
    exe('l east;l south;l west;l north')
end
function goXtjShulin()
    if not tmp.goxtj then tmp.goxtj=0 end
    tmp.goxtj = tmp.goxtj + 1
    if tmp.goxtj>3 then
       EnableTriggerGroup("goxtj",false)
       checkWait(goXtjGo,1.5)
    end
end
function goXtjShanlu()
    EnableTriggerGroup("goxtj",false)
    if not tmp.goxtj then tmp.goxtj=0 end
    if tmp.goxtj==1 then
       exe('s')
    end
    exe('n')
    locate()
    checkWait(goXtjCheck,1)
end
function goXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_bei(goXtjCheck)
end
function goXtjOver()
    EnableTriggerGroup("goxtj",false)
    DeleteTriggerGroup("goxtj")
    walk_wait()
end

function outXtj()
    DeleteTriggerGroup("outxtj")
    create_trigger_t('outxtj1',"^(> )*����\\s*\\-",'','outXtjShulin')
    create_trigger_t('outxtj2',"^(> )*ɽ·\\s*\\-",'','outXtjShanlu')
    SetTriggerOption("outxtj1","group","outxtj")
    SetTriggerOption("outxtj2","group","outxtj")
    EnableTriggerGroup("outxtj",false)

    exe('s')
    locate()
    check_bei(outXtjCheck)
end
function outXtjCheck()
    if locl.room~="����" then
       return outXtjOver()
    end
    
    tmp.outxtj=0
    EnableTriggerGroup("outxtj",true)
    exe('l east;l south;l west;l north')
end
function outXtjShulin()
    if not tmp.outxtj then tmp.outxtj=0 end
    tmp.outxtj = tmp.outxtj + 1
    if tmp.outxtj>3 then
       EnableTriggerGroup("outxtj",false)
       checkWait(outXtjGo,1.5)
    end
end
function outXtjShanlu()
    EnableTriggerGroup("outxtj",false)
    if not tmp.outxtj then tmp.outxtj=0 end
    if tmp.outxtj>1 then
       exe('n')
    end
    exe('s')
    locate()
    checkWait(outXtjCheck,1)
end
function outXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_bei(outXtjCheck)
end
function outXtjOver()
    EnableTriggerGroup("outxtj",false)
    DeleteTriggerGroup("outxtj")
    walk_wait()
end

function toThd()
    DeleteTriggerGroup("toThd")
    create_trigger_t('toThd1',"^(> )*��ԶԶ��ȥ�����������дУ�һ���̡�һ�ź졢һ�Żơ�һ���ϣ��˵��Ƿ����ƽ���",'','toThdLocate')
    SetTriggerOption("toThd1","group","toThd")
    exe('l rock;jump boat')
end
function toThdLocate()
    locate()
	return checkWait(toThdCheck,2)
end
function toThdCheck()
    if locl.room == '����' then
	   return toThdOver()
	else
	   return toThdLocate()
	end
end
function toThdOver()
    EnableTriggerGroup("toThd",false)
	walk_wait()
end

function songlinIn()
    DeleteTriggerGroup("songlin")
    create_trigger_t('songlin1',"^(> )*������\\s*\\-",'','songlinInSonglin')
    create_trigger_t('songlin2',"^(> )*���ٲ�\\s*\\-",'','songlinInPubu')
	create_trigger_t('songlin3',"^(> )*��Ժ\\s*\\-",'','songlinInSonglin')
    SetTriggerOption("songlin1","group","songlin")
    SetTriggerOption("songlin2","group","songlin")
	SetTriggerOption("songlin3","group","songlin")
    EnableTriggerGroup("songlin",false)
	exe('n')
	cntrl = countR(100)
    locate()
    check_bei(songlinInCheck)
end
function songlinInCheck()
    if locl.room=="���ٲ�" then
       return songlinInOver()
    end
	if locl.room=="��Ժ" then
       exe('n')
    end
    if cntrl()<0 then
	   quests["tlbb"].time = os.time() - 22*60*60
	   return check_heal()
	end
    tmp.songlin=0
    EnableTriggerGroup("songlin",true)
    exe('l east;l south;l west;l north')
end
function songlinInSonglin()
    if not tmp.songlin then tmp.songlin=0 end
    tmp.songlin = tmp.songlin + 1
    if tmp.songlin>3 then
       EnableTriggerGroup("songlin",false)
       checkWait(songlinInGo,1)
    end
end
function songlinInPubu()
    EnableTriggerGroup("songlin",false)
    exe('e')
    locate()
    checkWait(songlinInCheck,1)
end
function songlinInGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_bei(songlinInCheck)
end
function songlinInOver()
    EnableTriggerGroup("songlin",false)
    DeleteTriggerGroup("songlin")
    walk_wait()
end
function songlinOut()
    DeleteTriggerGroup("songlin")
    create_trigger_t('songlin1',"^(> )*������\\s*\\-",'','songlinOutSonglin')
    create_trigger_t('songlin2',"^(> )*���ٲ�\\s*\\-",'','songlinOutPubu')
	create_trigger_t('songlin3',"^(> )*��Ժ\\s*\\-",'','songlinOutHouyuan')
    SetTriggerOption("songlin1","group","songlin")
    SetTriggerOption("songlin2","group","songlin")
	SetTriggerOption("songlin3","group","songlin")
    EnableTriggerGroup("songlin",false)
	exe('n')
    locate()
    check_bei(songlinOutCheck)
end
function songlinOutCheck()
    if locl.room=="���ٲ�" then
	   exe('w;s')
       return songlinOutOver()
    end
	if locl.room=="��Ժ" then
       return songlinOutOver()
    end

    tmp.songlin=0
    EnableTriggerGroup("songlin",true)
    exe('l east;l south;l west;l north')
end
function songlinOutSonglin()
    if not tmp.songlin then tmp.songlin=0 end
    tmp.songlin = tmp.songlin + 1
    if tmp.songlin>2 then
       EnableTriggerGroup("songlin",false)
       checkWait(songlinOutGo,1)
    end
end
function songlinOutPubu()
    EnableTriggerGroup("songlin",false)
    exe('e')
    locate()
    checkWait(songlinOutCheck,1)
end
function songlinOutHouyuan()
    EnableTriggerGroup("songlin",false)
	exe('s')
    return songlinOutOver()
end
function songlinOutGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_bei(songlinOutCheck)
end
function songlinOutOver()
    EnableTriggerGroup("songlin",false)
    DeleteTriggerGroup("songlin")
    walk_wait()
end

function xsMianbi()
    if hp.shen>0 then
	   return xsMianbiOver()
	else
	   exe('#20(mianbi);hp')
	   return check_bei(xsMianbiChk,1)
	end
end
function xsMianbiChk()
    if hp.shen>0 then
	   return xsMianbiOver()
	else
	   exe('#20(mianbi);hp')
	   return check_bei(xsMianbi,1)
	end
end
function xsMianbiOver()
    return walk_wait()
end

function mlIn()
    tmp.way = "south"
	tmp.ml = "in"
	locate()
	return checkWait(wayMl,0.1)
end
function mlOut()
    tmp.way = "north"
	tmp.ml = "out"
	locate()
	return checkWait(wayMl,0.1)
end
function wayMl()
    local ways = {
		["north"] = "east",
		["east"]  = "south",
		["south"] = "west",
		["west"]  = "north",
	}
	local wayt = {
		["north"] = "west",
		["east"]  = "north",
		["south"] = "east",
		["west"]  = "south",
	}
	if not tmp.way or not ways[tmp.way]then
	   tmp.way = 'south'
	end
	if locl.room=="��ʯ���·" then
	   if tmp.ml and tmp.ml=="in" then
	      return wayMlOver()
	   else
	      tmp.way = "north"
	      exe(tmp.way)
		  locate()
	      return checkWait(wayMl,0.1)
	   end 
    end
    if locl.room=="С·" then
	   if tmp.ml and tmp.ml=="out" then
	      return wayMlOver()
	   else
	      tmp.way = "south"
	      exe('south;south')
		  locate()
	      return checkWait(wayMl,0.1)
	   end 
    end
    if locl.room~="С·" and locl.room~="��ʯ���·" and locl.room~="÷��" then
       return wayMlOver()
    end	
	tmp.way = ways[tmp.way]
	while not locl.exit[tmp.way] do
	    Note(tmp.way)
	    tmp.way = wayt[tmp.way]
	end
	exe(tmp.way)
	locate()
	return checkWait(wayMl,0.2)
end
function wayMlOver()
    return walk_wait()
end

function mzDoor()
    create_trigger_f('xxdf',"^(> )*���˰��Σ����Ż����򿪣������߳���������װ��������",'','mzDoorHuida')
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
function mzDoorHuida()
    exe('huida �����������;show wuyue lingqi;s')
	return check_bei(mzDoorOver)
end
function mzDoorOver()
    return walk_wait()
end

function yuRen()
	DeleteTriggerGroup("yrAsk")
    create_trigger_t('yrAsk1',"^(> )*�������˴����йء�һ�ƴ�ʦ������Ϣ",'','yuRenAsk')
    create_trigger_t('yrAsk2',"^(> )*����û������ˡ�$",'','yuRenOver')
    SetTriggerOption("yrAsk1","group","yrAsk")
    SetTriggerOption("yrAsk2","group","yrAsk")
	checkWield()
	return exe('ask yu ren about һ�ƴ�ʦ')
end
function yuRenAsk()
    EnableTriggerGroup("yrAsk",false)
	DeleteTriggerGroup("yren")
	create_trigger_t('yren1',"^(> )*����(����|)˵����(��|)�Ҳ����Ѿ���������ɽ�ķ�����ô��",'','yuRenCheck')
	create_trigger_t('yren2','^(> )*����(����|)˵����(��|)������ȥ�ҵĽ������أ�','','yuRenWaa')
	create_trigger_t('yren3',"^(> )*����(����|)˵����(��|)Ҫ����ʦ����Ҳ���ѣ������Ҹն�ʧ������������",'','yuRenWaa')
	SetTriggerOption("yren1","group","yren")
    SetTriggerOption("yren2","group","yren")
	SetTriggerOption("yren3","group","yren")
end
function yuRenWaa()
    EnableTriggerGroup("yren",false)
	EnableTriggerGroup("yrj",false)
	EnableTriggerGroup("yrz",false)
	cntr1 = countR(20)
	return check_bei(yuRenJump)
end
function yuRenJump()
    EnableTriggerGroup("yren",false)
	EnableTriggerGroup("yrz",false)
	DeleteTriggerGroup("yrj")
	create_trigger_t('yrj1',"^(> )*(���ٲ����ڶ�ȥ��ˮĭ�Ľ���ֻ��|�ٲ����Ѿ������ˣ�������ȥ̫Σ����)",'','yuRenWait')
	create_trigger_t('yrj2','^(> )*�㵱��һ�ﲻ����Ҳ�����¿�Ь�࣬ӿ������ٲ������䡣','','yuRenZhua')
	--create_trigger_t('yrj3',"^(> )*����æ���ء�",'','yuRenWaa')
	SetTriggerOption("yrj1","group","yrj")
    SetTriggerOption("yrj2","group","yrj")
	--SetTriggerOption("yrj3","group","yrj")
	weapon_unwield()
	exe('look pubu')
	exe('jump pubu')
end
function yuRenWait()
    EnableTriggerGroup("yrj",false)
    if cntr1() < 1 then
	   return yuRenOver()
	end
	return checkWait(yuRenJump,3)
end
function yuRenZhua()
    DeleteTriggerGroup("yrz")
	create_trigger_t('yrz1',"^(> )*�㲻���Ѿ�ץ����������ô��",'','yuRenCheck')
	create_trigger_t('yrz2','^(> )*����\\D*��ץ������ô��','','yuRenUw')
	create_trigger_t('yrz3',"^(> )*����æ���ء�",'','yuRenZhuaYu')
	create_trigger_t('yrz4','^(> )*����������ȥ׽�ǶԽ����ޣ�һ��һ��','','yuRenZhuaYu')
	create_trigger_t('yrz5',"^(> )*�����ֵ����������Ǵ�ʯ��������һ̧",'','yuRenCheck')
	create_trigger_t('yrz6',"^(> )*��ʵ��֧�Ų���ȥ�ˣ������������ٲ����ߡ�",'','yuRenWaa')
	SetTriggerOption("yrz1","group","yrz")
    SetTriggerOption("yrz2","group","yrz")
	SetTriggerOption("yrz3","group","yrz")
	SetTriggerOption("yrz4","group","yrz")
	SetTriggerOption("yrz5","group","yrz")
	SetTriggerOption("yrz6","group","yrz")
	return yuRenZhuaYu()
end
function yuRenUw()
    weapon_unwield()
	return check_bei(yuRenZhuaYu)
end
function yuRenZhuaYu() 
    EnableTriggerGroup("yrz",true)
	wait.make(function() 
       wait.time(3)
	   exe('zhua yu')
	end)
end
function yuRenCheck()
    EnableTriggerGroup("yrz",false)
    checkBags()
	exe('jump anbian')
	return check_busy(yuRenBag,1)
end
function yuRenBag()
    if not Bag["������"] then
	   return check_bei(yuRenAsk)
	end
	exe('give jin wawa to yu ren')
	return checkWait(yuRenGive,4)
end
function yuRenGive()
	DeleteTriggerGroup("yrp")
	create_trigger_t('yrp1',"^(> )*�ٲ���ˮ�������ļ��������Ѿ����������ں����ˣ��㻹���ȵȻ�ɡ�",'','yuRenPao')
	create_trigger_t('yrp2','^(> )*��ת��ɽ�ǣ���һ�������𣡡����������ٲ�������','','yuRenHua')
	create_trigger_t('yrp3',"^(> )*����æ���ء�",'','yuRenPao')
	SetTriggerOption("yrp1","group","yrp")
    SetTriggerOption("yrp2","group","yrp")
	SetTriggerOption("yrp3","group","yrp")
	return yuRenPao()
end
function yuRenPao()
    wait.make(function() 
       wait.time(1)
	   exe('zhi boat')
	end)
end
function yuRenHua()
    EnableTriggerGroup("yrp",false)
	DeleteTriggerGroup("yrh")
	create_trigger_t('yrh1',"^(> )*(�����У�|�����ڻ��أ�|������������æ�ӳ�)",'','yuRenBoat')
	create_trigger_t('yrh2','^(> )*���Ѿ��������ˣ���취�ϰ��ɣ�','','yuRenTiao')
	create_trigger_t('yrh3',"^(> )*����æ���ء�",'','yuRenBoat')
	create_trigger_t('yrh4',"^(> )*ͻȻ��һ�ɴ����嵽",'','yuRenOver')
	SetTriggerOption("yrh1","group","yrh")
    SetTriggerOption("yrh2","group","yrh")
	SetTriggerOption("yrh3","group","yrh")
	SetTriggerOption("yrh4","group","yrh")
	return yuRenBoat()
end
function yuRenBoat()
    EnableTriggerGroup("yrh",true)
	wait.make(function() 
       wait.time(2)
	   weapon_unwield()
	   exe('wield tie jiang')
	   checkWield()
	   exe('hua boat')
	end)
end
function yuRenTiao()
    EnableTriggerGroup("yrh",false)
	exe('jump shandong')
	return yuRenOver()
end
function yuRenOver()
    EnableTriggerGroup("yrh",false)
	DeleteTriggerGroup("yrh")
	DeleteTriggerGroup("yrp")
	DeleteTriggerGroup("yrz")
	DeleteTriggerGroup("yrj")
	DeleteTriggerGroup("yren")
	DeleteTriggerGroup("yrAsk")
	return walk_wait()
end

function jiaoZi()
    locate()
	return checkNext(jiaoZiLoc)
end
function jiaoZiLoc()
    if locl.room ~= "����" then
	   return jiaoZiOver()
	end
    if not locl.id["����"] then
	   return jiaoZiWait()
	end
	DeleteTriggerGroup("jiao")
	create_trigger_t('jiao1',"^(> )*����˵������������ۣ�������ŭ��ɽ�ӱ�������·���������������顣����",'','jiaoZiAnswer')
	SetTriggerOption("jiao1","group","jiao")
	tmp.jiaozi = true
	wait.make(function()
	   wait.time(20)
	   return jiaoZiAnswer()
	end)
end
function jiaoZiWait()
    wait.make(function() 
       wait.time(2)
	   return jiaoZi()
	end)
end
function jiaoZiAnswer()
    if not tmp.jiaozi then return end
	tmp.jiaozi = nil
    EnableTriggerGroup("jiao",false)
	exe('answer ��ɽ����������మ���β��������۹��ƽ����һéի��Ұ����������˭���˷�˭�ɰܣ�ª�ﵥư�����ա�ƶ�������ģ��־���ģ�')
	exe('pa teng')
	return jiaoZiOver()
end
function jiaoZiOver()
    DeleteTriggerGroup("jiao")
    return walk_wait()
end 

function duZi()
    locate()
	return checkNext(duZiLoc)
end
function duZiLoc()
    if locl.room ~= "ʯ����ͷ" then
	   return duZiOver()
	end
    if not locl.id["����"] then
	   return duZiWait()
	end
	DeleteTriggerGroup("du")
	create_trigger_t('du1',"^(> )*����(����|)˵����(��|)�ҳ�������Ŀ�����㣬",'','duZiQuestion')
	create_trigger_t('du2',"^(> )*����(����|)˵����(��|)������һ��ʫ��˵�������³������������ĸ��ֶ�",'','duZiAnswer')
	create_trigger_t('du3',"^(> )*����(����|)˵����(��|)�úã���Ȼ������һ�⣬����һ������",'','duZiAnswerTwo')
	create_trigger_t('du4',"^(> )*����(����|)˵����(��|)�һ���һ������",'','duZiAnswerThree')
	create_trigger_t('du5',"^(> )*����(����|)˵����(��|)��ɻش�ĳ��ҵ����⣿",'','duZiAnswerAll')
	create_trigger_t('du6',"^(> )*����(����|)˵����(��|)��λ\\D*����ʦ������ǰ�治Զ����ʯ���",'','duZiOver')
	SetTriggerOption("du1","group","du")
	SetTriggerOption("du2","group","du")
	SetTriggerOption("du3","group","du")
	SetTriggerOption("du4","group","du")
	SetTriggerOption("du5","group","du")
	SetTriggerOption("du6","group","du")
	return check_bei(duZiAsk)
end
function duZiAsk()
    exe('ask shu sheng about һ�ƴ�ʦ')
end
function duZiQuestion()
    wait.make(function() 
       wait.time(4)
	   exe('ask shu sheng about ��Ŀ')
	end)
end
function duZiWait()
    wait.make(function() 
       wait.time(2)
	   return duZi()
	end)
end
function duZiAnswerAll()
    wait.make(function() 
       wait.time(3)
	   exe('answer ��δ״Ԫ')
	   exe('answer ˪���Ҷ�����Ź����ң��')
	   exe('answer �������ˣ���С����Զǳ�')
	   exe('north')
	end)
end
function duZiAnswer()
    wait.make(function() 
       wait.time(4)
	   exe('answer ��δ״Ԫ')
	end)
end
function duZiAnswerTwo()
    exe('answer ˪���Ҷ�����Ź����ң��')
end
function duZiAnswerThree()
    exe('answer �������ˣ���С����Զǳ�')
	exe('north')
	return duZiOver()
end
function duZiOver()
    EnableTriggerGroup("du",false)
    return walk_wait()
end 

function nongFu() 
    locate()
	return checkNext(nongFuLoc)
end
function nongFuLoc()
    if locl.room ~= "ɽ��" then
	   return nongFuOver()
	end
    if not locl.id["ũ��"] then
	   return nongFuWait()
	end
	DeleteTriggerGroup("nong")
	create_trigger_t('nong1',"^(> )*(�Ѿ����������ˡ�|ũ���ڣ���ô���ʯ����һ�����޷�����)",'','nongFuTuo')
	create_trigger_t('nong2','^(> )*���Ѿ���ũ������ʯ���ˣ��������뿪��','','nongFuLeave')
	create_trigger_t('nong3',"^(> )*����æ���ء�",'','nongFuTuo')
	create_trigger_t('nong4',"^(> )*ũ��˫����ס��ʯ�������˾���ͦ���ʯ������˵��",'','nongFuLeave')
	SetTriggerOption("nong1","group","nong")
    SetTriggerOption("nong2","group","nong")
	SetTriggerOption("nong3","group","nong")
	SetTriggerOption("nong4","group","nong")
	return nongFuTuo()
end
function nongFuTuo()
    EnableTriggerGroup("nong",true)
	wait.make(function() 
       wait.time(2)
	   exe('tuo shi')
	end)
end
function nongFuWait()
    wait.make(function() 
       wait.time(2)
	   return nongFu()
	end)
end
function nongFuLeave()
    EnableTriggerGroup("nong",false)
	exe('east')
	return nongFuOver()
end
function nongFuOver()
    DeleteTriggerGroup("nong")
    return walk_wait()
end 

function liangFront()
    if hp.neili < 2000 then
	   return prepare_neili(liangFrontJump)
	end 
	return liangFrontJump()
end
function liangFrontJump()
    exe('jump front;hp')
	return check_bei(liangFrontOver,1)
end
function liangFrontOver()
    return walk_wait()
end 

function liangBack()
    if hp.neili < 2000 then
	   return prepare_neili(liangBackJump)
	end 
	return liangBackJump()
end
function liangBackJump()
    exe('jump back;hp')
	return check_bei(liangBackOver,1)
end
function liangBackOver()
    return walk_wait()
end 

function mtyShamo()
    exe('#3n')
	locate()
	return check_busy(mtySmCheck)
end
function mtySmCheck()
    if locl.room ~= "����ɳĮ" then
	   return check_bei(mtySmOver)
	end	
	return mtyShamo()
end
function mtySmOver()
    exe('unset heal;yun heal')
    return check_bei(walk_wait)
end 

function climblian()
    exe('climb lian;hp')
	locate()
	return check_busy(climblianHeal)
end
function climblianHeal()
    flag.idle=0
    if locl.room=="Ħ���µ�" or locl.room=="Ħ���°�ɽ�ͱ�" then
        exe('yun qi;yun jingli;unset heal;yun heal')
	    return check_busy(climblian)
	else
	    return check_bei(walk_wait)
	end
end

function outMudao()
    locate()
	return check_bei(outMudaoCheck,1)
end
function outMudaoCheck()
    if locl.exit["up"] then
	   exe("up")
	   return outMudaoOver()
	end
	if countTab(locl.exit) > 2 and locl.exit["down"] then
	   exe("down")
	   return outMudaoOver()
	end
	for p in pairs(locl.exit) do
	    exe(p)
		return outMudaoOver()
	end
	return outMudaoOver()
end
function outMudaoOver()
    return walk_wait()
end
function gmGetStone()
    exe('jian shi')
	checkBags()
	return check_busy(gmGetStoneCheck,1)
end
function gmGetStoneCheck()
    if Bag["ENCB"] and Bag["ENCB"].value > 50 then
	    if Bag["ENCB"].value >= 100 then
		    exe('drop stone')
			exe('drop stone')
	    else
	        return gmGetStoneOver()
	    end
	end
	   
	return gmGetStone()
end
function gmGetStoneOver()
    exe('yun qi;yun jingli')
    return walk_wait()
end

function gmDropStone()
    if isInBags('stone') then
       local l_item,l_cnt = isInBags('stone')
	   exe('#'.. l_cnt ..'(drop stone)')
	else
	   if Bag["����"] and Bag["����"].cnt>0 then
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
	return check_busy(gmDropStoneCheck,1)
end
function gmDropStoneCheck()
    if Bag["ENCB"] and Bag["ENCB"].value >= 30 then
	    return gmDropStone()
	end
	return gmDropStoneOver()
end
function gmDropStoneOver()
    exe('yun qi;yun jingli') 
    return walk_wait()
end
function gmDropStoneCmd()
    if isInBags('stone') then
	   checkBags()
	   return 'drop stone'
	else
	   if Bag["����"] and Bag["����"].cnt>0 then
	      checkBags()
	      return 'drop silver'
	   else
	      for p in pairs(Bag) do
		      if Bag[p].kind and perform.skill and Bag[p].kind~=skillEnable[perform.skill] then
			     local l_s = 'drop '.. Bag[p].fullid
			     checkBags()
			     return l_s
			  end
			  if Bag[p].kind then
                 local l_s = 'drop '.. Bag[p].fullid
			     checkBags()
			     return l_s
			  end
		  end
	   end
	end	
end

--�����������������֣��ս�һ��������ֻС������ƺ��������֣�
--����æ���ء�
function gensuiBee()
    exe('find �۷�')
    wait.make(function()
	   wait.time(3)
	   exe('gensui ���')
	   wait.time(2)
	   locate()
	   return gensuiCheck()
	end)
end
function gensuiCheck()
    if locl.room ~= "�ٻ���" then
	   return gensuiBee()
	end 
	return walk_wait()
end

function xxsmWest()
    exe('#5w')
	locate()
	return check_busy(xxsmWestCheck,1)
end
function xxsmWestCheck()
    if locl.room == "��ɳĮ" then
	   return xxsmWestCon()
	end 
	return xxsmWestOver()
end
function xxsmWestCon()
    exe('#2w')
	locate()
	return check_busy(xxsmWestCheck,1)
end
function xxsmWestOver()
    return walk_wait()
end
function xxsmEast()
    exe('#5e')
	locate()
	return check_busy(xxsmEastCheck,1)
end
function xxsmEastCheck()
    if locl.room == "��ɳĮ" then
	   return xxsmEastCon()
	end 
	return xxsmEastOver()
end
function xxsmEastCon()
    exe('#2e')
	locate()
	return check_busy(xxsmEastCheck,1)
end
function xxsmEastOver()
    return walk_wait()
end
 
room={}
roomMaze={
['�ɶ��Ǳ����']='s',
['�ɶ����ϴ��']='n',
['�ɶ��Ƕ����']='w',
['�ɶ��������']='e',
['�ɶ����ϲ��']='s',
['�ɶ��ǳǸ�·']='e;se;se;s;s',

['���ԭ�ݺ�']=function() return locl.dir end,

['�����Ƕ���ǽ']='#8n;#4s',
['�������ϳ�ǽ']='#10w;#5e',
['����������ǽ']='#8n;#4s',
['�����Ǳ���ǽ']='#10w;#5e',

['����Ǵ��������']='s;w',
['����Ǵ����ϴ��']='s',
['����Ǵ������']='e;n',
['����Ǵ������']='s;e',

['����ɽ��ʮ����']='ne;nd',
['����ɽ���϶�']=function() if locl.exit["enter"] then return 'enter' else return 'drop fire;leave;leave;leave;leave' end end,
['����ɽ��ɼ��']='sw;se',
['����ɽʮ����']='ne;ed;ne;ed',
['����ɽ������']='ed;ed',
--['����ɽϴ��ر�']='s;su',

['��ɽ���ּ��']='#2e;nw;ne;se;n',

['���ݳ�����']='#3n',

['�ؽ���Ҷ��']=function() if math.random(1,4)==1 then return 'ne;#10e' elseif math.random(1,4)==2 then return 'ne;#10w' elseif math.random(1,4)==3 then return 'ne;#10s' else return 'ne;#10n' end end,

['��ɽ������']='n;e;e',

['�ƺ�����ƺӰ���']='nu;#2(sw);#2w',
['�ƺ���������']='e;ne;#2n',
['�ƺ�����ݵ�']='e;s',
['�ƺ��������']='#2e;ne;n',

['ؤ��������']='e;n;w;n',

['����ׯ�����']='s;se;w;#2s;w;s',
['����ׯ����']='#2e;w;#2s',
['����ׯ�ݵ�']='#2e;w;s',

['����Ľ��������']='e;n;w;n;yue tree',

['������±�']='pa up',
--['����ȹȵ�ˮ̶']='drop stone;qian up;pa up',
--['����ȹȵ�ˮ̶']=function() if math.random(1,2)==1 then return 'drop stone;qian up;pa up' else return 'drop silver;drop jian;drop blade;drop whip;drop hammer;drop xiao;drop staff' end end,
['����ȹȵ�ˮ̶']=function() if math.random(1,2)==1 then return 'drop stone;qian up;pa up' else return gmDropStoneCmd() end end,

['����Сɳ��']='#4e',
['����ջ��']='#2(sw);#2(se);s',
['����ɽ·']='ed;wd;sd;nd',
['���������']=function() if locl.id["�ϻ�"] then return 'halt;n;w;nu' elseif locl.id["С��֦"] then return 'halt;w;nw;n;w;nu' elseif locl.id["����ʬ��"] then return 'halt;nw;n;w;nu' elseif locl.id["������"] then return 'halt;w;n;w;nu' else return locl.dir end end,
['��������']=function() if locl.id["��ʯͷ"] then return 'halt;e;nu' elseif locl.id["������"] then return 'halt;w;nu' else return locl.dir end end,

['������ɳ̲']='sw;se',
['����������']='sw;se;s',
['����������']='#2e;n',
['������ɽ��']='d;wd;su;sd;wd',
['������ɽ·']='s;sd;d;wd;su',

['��ɽ��������']=function() if math.random(1,4)==1 then return 'e;nw;w;e;e;s;w;n;nw;n;s' elseif math.random(1,4)==2 then return 'w;nw;w;e;e;s;w;n;nw;n;s' elseif math.random(1,4)==3 then return 'n;e;nw;w;e;e;s;w;n;nw;n;s' else return 's;e;nw;w;e;e;s;w;n;nw;n;s' end end,
['��ɽ���ֲ�԰��']='s;w;n;n;n;nw;n;n;w;w;w',
['��ɽ����С·']='n;nw;n;n;w;w',
['��ɽ���ַ���']='s;s;n;w',
['��ɽ���ֻ���']='n;w;n',
['��ɽ�������䳡']='s;s;n;e',
['��ɽ������ɮ��']='n;n;n;e',
['��ɽ���������']='n;w;w',
['��ɽ����ʯ��']='ed;sd;e',
['��ɽ��������']= function() if math.random(1,4)==1 then return 'e;s;e;ne;se;s;se;open door;e;e;e' elseif math.random(1,4)==2 then return 'w;s;e;ne;se;s;se;open door;e;e;e' elseif math.random(1,4)==3 then return 'n;s;e;ne;se;s;se;open door;e;e;e' else return 's;s;e;ne;se;s;se;open door;e;e;e' end end,
['��ɽ���ֻ�����']='w;n',
['��ɽ����������']='w;n;nw',
['��ɽ����ɮ��']=function() if locl.id["�ۺ�����"] then return 'w;s;e' elseif locl.id["��������"] then return 'e;s;w' else return locl.dir end end,

['������������']='s;w;s;w;#8s',

['�䵱ɽ����·']='e;e',
['�䵱ɽС��']='#5n',

['����ɽ������']='n;e;n;w;n',

['������ɽ��С·']='ne;nd;se;se;#2s;n;e',

['��Դ��ʯ��']='jump front',

['���޺����޺�']='se;#7n',
['���޺���ɳĮ']='#8w',

['Ѫ���Ź�ľ��']='s;s;e',

['���ݳǳ�������']='w;w;e;n',
['���ݳǳ����ϰ�']='w;w;e;s;se;s',
['���ݳ������']='e;n',
['���ݳ��ϴ��']='s;w',
['���ݳǱ����']='e',
['���ݳǶ����']='w;n',
}

roomNodir={
['����ʹ�����']={'north'},
['���ݳ����']={'northeast'},
['��������·']={'east','west'},
['���ݳ�ɽ·']={'east','west'},
['���ݳ�С��']={'southwest'},
['�ƺ���������']={'southwest'},
['��ɽ�������']={'northwest','northeast'},
['��ɽ�յ�']={'southdown'},
['��ɽɽ����']={'south'},
['�����ɽ��ƽ��']={'northdown'},
['���ݳ����ׯ�ſ�']={'west'},
['����ɽ���پ�']={'west'},
['����ɽ������']={'southwest'},
['����ɽ��Ժ��']={'east'},
['����ɽ��Ժ']={'south'},
['÷ׯС·']={'south'},
['���̻���ƺ']={'south','east'},
['���̾�ľ��']={'west','east'},
['�����һ���']={'west'},
['���̺�ˮ��']={'east'},
['���������']={'east'},
['���̺�����']={'east','west'},
['���̾�����']={'west'},
['�置ɽ��']={'northup','northwest'},
['�������ֽ��Ժ']={'south'},

['��ɽ����������']={'west'},
['��ɽ��������Ժ']={'west'},
['��ɽ����ɽ·']={'east','northwest'},

['��ɽ�޵�']={'north'},
['���ݳǺ�Ժ']={'north'},
['�䵱ɽС��']={'south','west','east'},
['����ɽ������']={'north','west'},
['����ɽ��Ժ']={'north'},

['���޺��¹Ȼ��ٹ��']={'south'},
['���޺���ɽ����']={'southwest'},
['���޺����޺�']={'south','north','east'},
['���޺����¶���']={'west','east'},
['���޺����¶�']={'north'},
['���޺�С·']={'south','west'},
['���޺����߻�·']={'south','north','east'},

}

MidNight={
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['��']=false,
['î']=false,
['��']=false,
['��']=false,
['��']=false,
['δ']=false,
['��']=false,
}

function del_element(set,element)
    for i=1,table.getn(element) do
        set=delElement(set,element[i])
    end
    return set
end

function del_string(string,sub)
    local l_s,l_e
    for i=1,string.len(string) do
        l_s,l_e=string.find(string,sub)
	if l_s==nil then break end
	string=string.sub(string,1,l_s-1)..string.sub(string,l_e+1,string.len(string))
    end
    return string
end

function addrTrim(addr)
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'�Ĵ�')
    addr=del_string(addr,'����')
    addr=del_string(addr,'�Ͻ�')
    addr=del_string(addr,'ɽ��')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=del_string(addr,'�س�')
    addr=del_string(addr,'����')
    addr=del_string(addr,'����')
    addr=string.gsub(addr,'С��','��ɽ��',1)
    addr=string.gsub(addr,'����������','������',1)
    addr=string.gsub(addr,'Ľ��','����Ľ��',1)
    return addr
end

goto_set={}
goto_set.xy=function()
    return goto('�����ǵ���')
end
goto_set.sl=function()
    return goto('��ɽ���ִ��۱���')
end
goto_set.xs=function()
    return goto('��ѩɽ���Ŀ�')
end
goto_set.hs=function()
    return goto('��ɽ������')
end
goto_set.yz=function()
    return goto('���ݳǵ���')
end
goto_set.wd=function()
    return goto('�䵱ɽ�����')
end
goto_set.thd=function()
    return goto('�һ�������ͤ')
end
goto_set.dl=function()
    return goto('�����ҩ��')
end

wxbGo=function()
    dis_all()
    return go(wxbAsk,"���ݳ�","����Ժ")
end
wxbAsk=function()
    create_trigger_f('wxbask',"^Τ����˵��������λ׳ʿ��������˵�����ǹԶ�������(\\D*)�������ء���",'','wxbGoto')
    Execute('ask wei chunfang about wei xiaobao')
end
wxbGoto=function(n,l,w)
    DeleteTemporaryTriggers()
    return goto(w[1])
end

function thdJiaohui()
    road.id=nil
	dis_all()
	return go(thdJiaohuiAsk,"�һ���","����ͤ")
end
function thdJiaohuiAsk()
    exe('ask huang yaoshi about �̻�')
	return check_heal()
end


function xunZhao(p_who)
    local l_who = Trim(p_who)
	local l_set=utils.split(l_who,',')
    local l_city = l_set[1]
	local l_npc = l_set[2]
	if l_city and l_npc then
	    local l_msg = 'ǰ��'..l_city..'Ѱ��'..l_npc..'!'
	    ColourNote ("white","blue",l_msg)
	    return searchNpc(l_city,l_npc)
	end
end
function searchNpc(city,npc,func)
    if city then
       tmp.rooms = getCityRooms(city)
	end
	if npc then
	   tmp.npc = npc
	end
	if func then
	   tmp.func = func
	end
	tmp.rooms = tmp.rooms or {}
	tmp.sour = tmp.sour or "city/dangpu"
	while countTab(tmp.rooms) > 0 do
	      local l_sour = "city/dangpu"
	      if tmp.sour ~= "city/dangpu" then
		     l_sour = tmp.sour
		  end
	      local l_dest,l_distance=getNearRoom(l_sour,tmp.rooms)
		  if l_dest then
		     tmp.rooms = delElement(tmp.rooms,l_dest)
			 --local l_path=map:getPath(l_sour,l_dest)
			 local l_path=path_cal_get(l_sour,l_dest)
			 if l_path then
			    tmp.sour = l_dest
		        return go(searchNpcLocate,l_dest,'',l_sour)
		     end
		  else
		     tmp.rooms = {}
		  end
    end	
	ColourNote ("white","blue","Object������ϣ�")
	printTab(tmp.objs)
end
function searchNpcLocate()
    locate()
	return check_bei(searchNpcAdd,1)
end
function searchNpcAdd()
    tmp.objs = tmp.objs or {}
    for p,q in pairs(locl.id) do
	    Note(p .." = "..q)
		if tmp.npc and p == tmp.npc then
		   exe('follow '.. q)
		   if tmp.func and _G[tmp.func] then
		       return _G[tmp.func]()
		   end
		   return dis_all()
		end
	    if ItemGet[p] or weaponStore[p] or weaponThrowing[p] or drugBuy[p] or drugPoison[p] or itemSave[p] then
		   locl.id[p] = nil
		end
		if string.find(p,"�ڳ�") or string.find(p,"����") or string.find(p,"��ƪ") or string.find(p,"��Ҫ") or string.find(p,"�佫") or string.find(p,"�ٱ�") or string.find(p,"���ϵ�") or string.find(p,"����") or string.find(p,"��ʦ") or string.find(p,"����") or string.find(p,"����") or string.find(p,"�趨��������") or string.find(p,"��ʬ") or string.find(p,"Ůʬ") or string.find(p,"ʬ��") or string.find(p,"�ϵ���") or string.find(p,"�����") or string.find(p,"�׼�") or string.find(p,"����") or string.find(p,"����") then
		   locl.id[p] = nil
		end
		if p == score.name or MudUser[p] then
		   locl.id[p] = nil
		end
		if locl.item[p]["cloth"] or locl.item[p]["shoes"] or locl.item[p]["shoe"] or locl.item[p]["blade"] or locl.item[p]["sword"] then
		   locl.id[p] = nil
		end
		if map.rooms[tmp.sour] and map.rooms[tmp.sour].objs and type(map.rooms[tmp.sour].objs)=="table" then
		   for k in pairs(map.rooms[tmp.sour].objs) do
		       if p == k then
			      locl.id[p] = nil
			   end
		   end
		end
	end
    if countTab(locl.id) > 0 then
	   for p,q in pairs(locl.id) do
		   tmp.objs[tmp.sour] = tmp.objs[tmp.sour] or {}
		   tmp.objs[tmp.sour].objs = tmp.objs[tmp.sour].objs or {}
		   ColourNote ("white","blue",p.." = "..q)
		   tmp.objs[tmp.sour].objs[p] = q
	   end
	end
    return searchNpc()
end

function locateroom(where)
   if not where then return false end
   local l_dest={}
   where = Trim(where)
   if string.find(where,"/") then
      --local l_path=map:getPath("xiangyang/dangpu",where)
	  local l_path=path_cal_get("xiangyang/dangpu",where)
      if l_path then
         return where
	  end
   else
      l_dest.room,l_dest.area=getAddr(Trim(where))
   end
   if l_dest.area then
      local l_rooms=getRooms(l_dest.room,l_dest.area)
	  for k,v in pairs(l_rooms) do
	      --local l_path=map:getPath("xiangyang/dangpu",v)
		  local l_path=path_cal_get("xiangyang/dangpu",v)
          if l_path then
             return l_dest.area,l_dest.room
		  end
	  end
   end
   
   for p in pairs(map.rooms) do
       if map.rooms[p].objs then
	      for k in pairs(map.rooms[p].objs) do
		      if k == where then
			     --local l_path=map:getPath("xiangyang/dangpu",p)
				 local l_path=path_cal_get("xiangyang/dangpu",p)
                 if l_path then
			        return p
			     end
			  end
		  end
	   end
   end
   return false
end

dirReverse = {
   ["up"] = "down",
   ["u"] = "d",
   ["down"] = "up",
   ["d"] = "u",
   ["east"] = "west",
   ["e"] = "w",
   ["west"] = "east",
   ["w"] = "e",
   ["eastup"] = "westdown",
   ["eu"] = "wd",
   ["westup"] = "eastdown",
   ["wu"] = "ed",
   ["eastdown"] = "westup",
   ["ed"] = "wu",
   ["westdown"] = "eastup",
   ["wd"] = "eu",
   ["south"] = "north",
   ["s"] = "n",
   ["north"] = "south",
   ["n"] = "s",
   ["southup"] = "northdown",
   ["su"] = "nd",
   ["northup"] = "southdown",
   ["nu"] = "sd",
   ["southdown"] = "northup",
   ["sd"] = "nu",
   ["northdown"] = "southup",
   ["nd"] = "su",
   ["southeast"] = "northwest",
   ["se"] = "nw",
   ["southwest"] = "northeast",
   ["sw"] = "ne",
   ["northeast"] = "southwest",
   ["ne"] = "sw",
   ["northwest"] = "southeast",
   ["nw"] = "se",
   ["enter"] = "out",
   ["out"] = "enter",
}

function sjPathReset()
    local l_result=utils.msgbox ( "�Ƿ����������ID����·������?", "·������", "yesno", "?", 1 )
	if not (l_result and l_result=="yes") then return end
	
	local spath = dbPathGetIndex()
	local sdark = dbDarkGetIndex()
		
	dbPathDelete()
	dbDarkDelete()
	
	Note("��ʼ����·�����ϣ�������Ҫ�����ӻ�ʮ���ӣ������ĵȴ���")	

	create_trigger_t('co1','��������·������:','','coresume')
	local l_cnt = 0
	if spath then
	    ls_co = coroutine.create(function()
		locl.time = "��"
        for _,q in pairs(spath) do
		    local l_path, l_len, l_public = map:getPath(q["sourid"],q["destid"])
			if l_path then
			    if l_public then
				    dbPathInsertPublic(q["sourid"],q["destid"],"","",l_path)
				else
			        dbPathInsert(q["sourid"],q["destid"],"","",l_path)
				end
			end
			
			l_cnt = l_cnt + 1
			if math.fmod(l_cnt,8)==0 then
			    local l_msg = "��������·������:"..q["sourid"].."|"..q["destid"].."|"..l_cnt
			    exe("say "..l_msg)
			    coroutine.yield()
			end
	    end
		locl.time = "��"
		for _,q in pairs(sdark) do
		    local l_path = map:getPath(q["sourid"],q["destid"])
			if l_path then
			    dbDarkInsert(q["sourid"],q["destid"],l_path)
			end
			l_cnt = l_cnt + 1
			if math.fmod(l_cnt,8)==0 then
			    local l_msg = "��������·������:"..q["sourid"].."|"..q["destid"].."|"..l_cnt
			    exe("say "..l_msg)
			    coroutine.yield()
			end
		end
		Note("����·��������ɣ�һ��������"..l_cnt.."�����ϡ�")
		DeleteTrigger("co1")
		end)
	end
	exe("say ��������·������:123")
end
function coresume()
    wait.make(function() 
	    wait.time(0.1)
        if ls_co and type(ls_co)=="thread" then
	        if coroutine.status(ls_co)=="suspended" then
	            coroutine.resume (ls_co)
	    	end
	    end
	end)
end

function txtFindLog(p_msg)
    if score.id=="id" then return end
    local filename = GetInfo (67) .. "logs\\" .. score.id .. "_find.log"
	local file = io.open(filename,"a")
	local s = os.date() .. " " .. p_msg .. "\n"
	if file then
	    file:write(s)  
        file:close()
	end
end

function qianwang()
    local t = {}
	for p,q in pairs(lookCitys) do
	    if not isNil(q) then t[q] = q end
	end
    local l_result=utils.listbox("����ǰ���������л�����","��������",t,"���ݳ�")
	if not l_result then return end
	
	local l_rooms = getCityRooms(l_result)
	l_result = nil
	t = {}
	for _,p in pairs(l_rooms) do
	    t[p] = map.rooms[p].name.."("..p..")"
	end
	l_result=utils.listbox("����ǰ���ĸ����䣿","ѡ�񷿼�",t,"")
	if not l_result then return end
	
	return goto(l_result)
end

function isTableEmpty(t)
    return _G["next"](t) == nil
end
function isGlobalFunc(f)
    return _G[f] and type(_G[f])=="function"
end

function fastSearch(cityroom,npc,func,fail)
    job.where=Trim(cityroom)
    job.target=Trim(npc)
	job.func = func
	job.fail = fail
	
	flag.times=1
	
	job.room,job.area=getAddr(job.where)
    dest.room=job.room
    dest.area=job.area
	
    DeleteTriggerGroup("fastfind")
    create_trigger_t('fastfind1','^>*\\s*\\D*'..job.target..'\\((\\D*)\\)','','fastSearchTarget')
	create_trigger_t('fastfind2','^(> )*(\\D*) - ','','fastSearchRoom')
	create_trigger_t('fastfind3','^(> )*��� "action" �趨Ϊ "������Ѱ��" �ɹ���ɡ�$','','fastSearchCheck')
	SetTriggerOption("fastfind1","group","fastfind")
    SetTriggerOption("fastfind2","group","fastfind")
    SetTriggerOption("fastfind3","group","fastfind")
    EnableTriggerGroup("fastfind",false)
	
	return go(fastSearchGo,job.area,job.room)
end
function fastSearchGo()
	EnableTriggerGroup("fastfind",true)
	EnableTrigger("fastfind2",false)
	
	messageShow('������Ѱ����ʼѰ�ҡ�'..dest.area .. dest.room ..'���ġ�'.. job.target ..'����')
	
	tmp.target = 0
	tmp.froom = 0
	
	ftab = {}
	local path = searchPathGet()
	local pset = utils.split(path,";")
	for p,q in ipairs(pset) do
	    if not (isNil(q) or q=='halt') then 
	       table.insert(ftab,q)
		end
	end
	exe('look')
	return check_busy(fastSearchCheck,1)
end
function fastSearchCheck()
    EnableTrigger("fastfind2",false)
    if tmp.target and tmp.target > 0 then
	    if tmp.froom ==0 then
	        return fastSearchLocate()
	    else
	        return fastSearchBack()
	    end
	else
	    return fastSearchRoad()
	end
end
function fastSearchBack()
    tmp.froom = tmp.froom or 0
	
	for i = 1,tmp.froom do
	    table.remove(tmp.froad,1)
	end
	
	local path = ''
	
	for i = table.getn(tmp.froad),1,-1 do
	    if isNil(path) then
		    path = dirReverse[tmp.froad[i]]
		else
		    path = path .. ';' .. dirReverse[tmp.froad[i]]
		end
	end
	
	EnableTrigger("fastfind2",true)
	create_alias('goset','goset','alias goalias '.. path)
    exe('goset')
	exe('goalias')
	   
    return check_bei(fastSearchLocate)
end
function fastSearchLocate()
    EnableTrigger("fastfind2",false)
	checkBags()
	locate()
	return checkWait(fastSearchFollow,1)
end
function fastSearchFollow()
    if locl.id[job.target] then
	    messageShow('������Ѱ���ڡ�'.. locl.area..locl.room ..'���ҵ���' .. job.target ..'����')
	    exe("follow ".. locl.id[job.target])
	    if isGlobalFunc(job.func) then 
		    return _G[job.func]()
		else
		    return check_heal()
		end
	end
	tmp.target = 0
	tmp.froom = 0
	tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    return fastSearchCheck()
	else
	    return fastSearchMove()
	end
end
function fastSearchRoad()
    tmp.froom = 0
	tmp.froad = {}
	while table.getn(ftab)>0 do
	    if table.getn(tmp.froad)>9 then
		    return fastSearchMove()
		end		
	    local path = ftab[1]
		
		if not dirReverse[path] then
		    if table.getn(tmp.froad)>0 then
			    return fastSearchMove()
		    else
			    table.remove(ftab,1)
			    if string.find(path,'#') then
				    local _,_,func,params = string.find(path,"^#(%a%w*)%s*(.-)$")
	                if func then
						tmp.findfunc = "fastSearchLocate"
	                    return _G[func](params)
					else
					    exe(path)
						return fastSearchLocate()
					end
				else
				    exe(path)
					return fastSearchLocate()
				end
		    end
		else
		    table.remove(ftab,1)
		    table.insert(tmp.froad,path)
		end	
	end
	return fastSearchMove()
end
function fastSearchMove()
    tmp.froad = tmp.froad or {}
	if table.getn(tmp.froad)==0 then
	    flag.times = flag.times or 1
	    flag.times = flag.times + 1
	    if flag.times > 2 then
	        messageShow('������Ѱ���ڡ�'..job.where..'���Ҳ�����' .. job.target ..'����')
			if isGlobalFunc(job.func) then 
		        return _G[job.func]()
			else
			    return check_heal()
			end
		else
		    return go(fastSearchGo,job.area,job.room)
		end
	else
	    local path = table.concat(tmp.froad,";")
		
		EnableTrigger("fastfind2",true)
	
	    create_alias('goset','goset','alias goalias '.. path)
        exe('goset')
	    exe('goalias')
	    wait.make(function() 
            wait.time(0.3)
	        exe('alias action ������Ѱ��')
	    end)
	end
end
function fastSearchRoom()
    tmp.froom = tmp.froom or 0
    if tmp.target == 0 then
	    tmp.froom = tmp.froom + 1
	end
end
function fastSearchTarget(n,l,w)
    tmp.target = 1
end
