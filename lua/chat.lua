require "db"

Mchat={}
Mchat.time=os.time()
MudUser={}
MudUnique={}

local partyWho = false

chat_trigger=function()
    DeleteTriggerGroup("chat")
    create_trigger_t('chat1',"^(> )*(\\! )*��(�ٸ�ͨ��|����|ؤ��|���ư�|������|����|������|����Ľ��|������|��ɽ��|�䵱��|�һ���|������|������|ҥ��|�齣|����|���)��",'','color_chats')
    create_triggerex_lvl('chat2',"^(.*)���齣��Ц��II(.*)������ң�$",'','chatWhoParty',99)
    create_triggerex_lvl('chat3',"^(> )*(\\! )*��ҥ�ԡ�ĳ�ˣ�(\\D*)Ū����һ(��|��|֧|��|��|��|��|��|��|��|��)(\\D*)��$",'','chat_unique',99)
    create_triggerex_lvl('chat4',"^(> )*(\\! )*��ҥ�ԡ�ĳ�ˣ����˴���(\\D*)��(\\D*)һ�����֣�$",'','rumor_unique',99)
    create_triggerex_lvl('chat5',"^(> )*(\\! )*��ҥ�ԡ�ĳ�ˣ�(\\D*)��(\\D*)���õ���һ(��|��|֧|��|��|��|��|��|��|��|��)(\\D*)��$",'','chat_Unique',99)
    create_triggerex_lvl('chat6',"^(> )*(\\! )*�����ġ�(\\D*)\\((\\D*)\\)��(.*)",'','chatUser',95)
	create_triggerex_lvl('chat7',"^(> )*(\\s*\\d*: | )��(\\D*)��(.*)\\((\\w*)\\)$",'','chatWho',99)
	create_triggerex_lvl('chat8',"(.*)��ʾ������$",'','chatWhoOver',99)
	create_triggerex_lvl('chat9',"^(> )*(\\! )*��ҥ�ԡ�ĳ�ˣ���˵(\\D*)���ŋ��񶴽����˵�(\\D*)���츳ǿ����$",'','chatCanwu',99)
    SetTriggerOption("chat1","group","chat")
	SetTriggerOption("chat2","group","chat")
    SetTriggerOption("chat3","group","chat")
    SetTriggerOption("chat4","group","chat")
    SetTriggerOption("chat5","group","chat")
    SetTriggerOption("chat6","group","chat")
	SetTriggerOption("chat7","group","chat")
	SetTriggerOption("chat8","group","chat")
	SetTriggerOption("chat9","group","chat")
end

function chatWhoList()
    if not GetVariable("flagdb") then
	    return
	end
    if math.random(1,4) > 1 then return end
    local wParty = {"baituo","xueshan","xuedao","emei","murong","gumu","huashan","kunlun","lingjiu","mingjiao","quanzhen","riyue",
	                "shaolin","shenlong","taohua","tianlong","tiezhang","wudang","xingxiu","gaibang","songshan","p"}
	local l_p = getRandomElement(wParty)
	exe("who -l -"..l_p..";p")
end
function chatWhoParty(n,l,w)
    partyWho = Trim(tostring(w[2]))
	--Note(partyWho)
end
function chatWhoOver()
    partyWho = false
	--Note("flase")
	if GetVariable("flagdb") then
	    dbUserCompare()
	end	
end
function chatWho(n,l,w)
    if not partyWho then return end
    if not GetVariable("flagdb") then
	    return
	end
    --printTab(w)
	if partyWho=="0" then partyWho="��ͨ����" end
	sjUser = sjUser or {}
	local uid = string.lower(Trim(w[5]))
	local uname,nick,title
	local l_str = Trim(w[4])
	--Note(l_str)
	--Note(string.find(l_str,'��(.*)��'))
	if string.find(l_str,'��(.*)��') then
	   local p_a,p_b,p_str = string.find(l_str,'��(.*)��')
	   if not p_a or not p_b then return end
	   title = Trim(string.sub(l_str,1,p_a-1))
	   nick = Trim(string.sub(l_str,p_a+2,p_b-2))
	   uname = Trim(string.sub(l_str,p_b+1,string.len(l_str)))
	else
	   local p_a,p_b = string.find(l_str,'%s')
	   if not p_a or not p_b then return end
	   title = Trim(string.sub(l_str,1,p_a-1))
	   nick = ""
	   uname = Trim(string.sub(l_str,p_b+1,string.len(l_str)))
	end
	if title then title = del_string(title,"+") end
	sjUser[uid] = sjUser[uid] or {}
	sjUser[uid] = {
	                ["uid"]   = uid,
		            ["uname"] = uname,
					["nick"]  = nick,
					["title"] = title,  
					["party"] = partyWho,
					["gender"]= sjUser[uid]["gender"] or "",
					["canwu"] = sjUser[uid]["canwu"] or 0,
					["group"] = sjUser[uid]["group"] or 0,
	}
end
function chatCanwu(n,l,w,styles)
    local l_flag=false
	--txtJobLog(w[3].."|"..w[4])
    for p, v in ipairs (styles) do
	    --txtJobLog(v.text)
        if v.text==w[4] then l_flag=true end 
    end
    if not l_flag then return end
    local l_name = w[3]
	local l_canwu = trans(w[4])
	--txtJobLog(l_name.."|"..l_canwu)
	sjUser = sjUser or {}
	for p,q in pairs(sjUser) do
	    if q["uname"]==l_name then
		    sjUser[p]["canwu"] = l_canwu 
		end
	end
end
function ircZyl(n,l,w)
    local l_dir = tostring(w[3])
	road.zyl = {}
    road.zyl[l_dir] = true
end
function ircSpecial(n,l,w)
    local l_name = tostring(w[3])
	local l_room = tostring(w[4])
    MudSpecial= MudSpecial or {}
    MudSpecial[l_name] = {}
    MudSpecial[l_name]["room"] = l_room
    MudSpecial[l_name]["time"] = os.time()
    MudSpecial[l_name]["date"] = os.date()
end

function userSave()
    local l_user
    local l_id
    for p in pairs(MudUser) do

        l_id=p .. '_' .. MudUser[p]

        if l_user then
	        l_user=l_user .. ',' .. l_id
	    else
	        l_user=l_id
	    end
    end
	if type(l_user)=="string" then
       SetVariable("muduser",l_user)
    end
	
	l_user = nil
	
	usrList = usrList or {}
	for p in pairs(usrList) do
	    l_id = p .. '_' .. usrList[p]
        if l_user then
		    l_user=l_user .. '|' .. l_id 
        else
		    l_user=l_id
        end		
	end
	if type(l_user)=="string" then
       SetVariable("usrlist",l_user)
    end
    
end
function userGet()
    local l_user=GetVariable("muduser")
    local l_set={}
    local l_id={}

    if l_user==nil then return false end

    l_set=utils.split(l_user,',')
	MudUser = MudUser or {}
    for i=1,table.getn(l_set) do
        l_id=utils.split(l_set[i],'_')
        if l_id[1] then
	        MudUser[l_id[1]]=l_id[2]
	    end
    end
	
	l_user = GetVariable("usrlist")
	if l_user==nil then return false end
	l_set=utils.split(l_user,'|')
	usrList = usrList or {}
	for i=1,table.getn(l_set) do
        l_id=utils.split(l_set[i],'_')
        if l_id[1] then
	        usrList[l_id[1]]=l_id[2]
	    end
    end
end
function userTell(n,l,w)
   local l_name = string.lower(tostring(w[1]))
   local l_uid = string.lower(tostring(w[2]))
   local l_area = locl.area
   local l_room = locl.room
   
   if GetVariable("block") and (string.lower(GetVariable("block"))=='yes' or string.find(string.lower(GetVariable("block")),l_uid)) then
      local l_random = getRandomElement(map.rooms)
	  l_area = getLookCity(l_random.id)
	  if not l_area then
	     l_area = "��ԭ����"
	  end
	  l_room = l_random.name
   end
   
   exe("tell ".. l_uid .." ���ڡ�".. l_area .."-".. l_room .."��")  
end
function userAdd(set)

    for p in pairs(set) do
        MudUser[p]=set[p]
    end

end

chat_world = "chat"   --��������޸�������Ϣ���ڵ����ơ�
local first_time = true

function color_chats (name, line, wildcards, styles)

    if GetVariable("flagchat") and GetVariable("flagchat")=="yes" then
	    txtChatLog(line)
    end
   
   if not flag.log or flag.log=="no" then return end

   -- try to find "chat" world
   local w = GetWorld (chat_world)   -- get "chat" world

   -- if not found, try to open it
   if first_time and not w then
     local filename = GetInfo (67) .. chat_world .. ".mcl"
     Open (filename)
     w = GetWorld (chat_world)   -- try again
     if not w then
       ColourNote ("white", "red", "Can't open chat world file: " .. filename)
       first_time = false   -- don't repeatedly show failure message
     end -- can't find world
   end -- can't find world first time around

   if w then   -- if present
     w:ColourTell ("white","black",os.date())
     for _, v in ipairs (styles) do       
       w:ColourTell (RGBColourToName (v.textcolour),
                     RGBColourToName (v.backcolour),
                     v.text)
     end -- for each style run
     w:Note ("")   -- wrap up line

   end -- world found

end -- function redirect 

function chatUser(name, line, wildcards, styles)
   color_chats(name, line, wildcards, styles)

   if score.id and score.id~='xxx' then
      return false
   end

   local l_name=tostring(wildcards[3])
   local l_id=string.lower(tostring(wildcards[4]))
   local l_words=tostring(wildcards[5])

   if l_id==score.id then return end
   if string.len(l_id)>8 then return end
   
   if score.id and MudUser[score.name] and l_words then
      if string.find(l_words,score.id) or string.find(l_words,score.name) then
         if string.find(l_words,"������") then
	    locate()
            chatTel(l_id,l_name..'ͬѧ,ȫ��λϵͳǰһ�ζ�λ�ص�Ϊ��'.. locl.area .. locl.room ..'���������׼ȷ����Ϣ�����ٲ�ѯһ�Σ�')
	    return 
	 end
      end
   end

end

function chatTel(id,chat)
   create_alias('tel','tel','tell '..id..' '..chat)
   exe('tel')
end

function chats_log(logs,color,bcolor)
    local w = GetWorld ("log")   -- get "chat" world
    local c_text='yellow'
    local c_back= bcolor or 'black'
    local log_world='log'
    
    if score.id then
        logs='��'..score.id..'��'..logs
    end
    
    if flag.log and flag.log=="yes" then
        -- if not found, try to open it
        if first_time and not w then
            local filename = GetInfo (67) .. log_world .. ".mcl"
            Note(filename)
            --local filename = GetInfo (67) .. "log.mcl"
            Open (filename)
            w = GetWorld (log_world)   -- try again
            if not w then
                ColourNote ("white", "red", "Can't open chat world file: " .. filename)
                first_time = false   -- don't repeatedly show failure message
            end -- can't find world
        end -- can't find world first time around
       
        if job.name=='songxin' then c_text='dodgerblue' end
        if job.name=='wudang' or job.name=='sldsm' then c_text='forestgreen' end
        if job.name=='xueshan' or job.name=='gaibang' then c_text='cyan' end
        if job.name=='gblu' then c_text='darkviolet' end
        
        if color~=nil then c_text=color end
        
        if w then
            w:ColourTell ("white","black",os.date())
            w:ColourTell (c_text,c_back,logs)
            w:Note("")
        end
    end
end

function chats_locate(logs,color)
    local w = GetWorld ("locate")   -- get "locate" world
    local c_text='peru'
    local c_back='black'
    local locate_world='locate'
    
	txtLocateLog(logs)
	
    if not flag.log or flag.log=="no" then return end
    
    if color~=nil then c_text=color end
    
    if score.id then
        logs='��'..score.id..'��'..logs
    end

    -- if not found, try to open it
    if first_time and not w then
        local filename = GetInfo (67) .. locate_world .. ".mcl"
        Open (filename)
        w = GetWorld (locate_world)   -- try again
        if not w then
            ColourNote ("white", "red", "Can't open chat world file: " .. filename)
            first_time = false   -- don't repeatedly show failure message
        end -- can't find world
    end -- can't find world first time around
    
    if w then
        w:ColourTell ("white","black",os.date())
        w:ColourTell (c_text,c_back,logs)
        w:Note("")
    end
end

function chat_unique(name, line, wildcards, styles)

    color_chats(name, line, wildcards, styles)

    if not GetVariable("flagdb") then
	    return
	end

    local l_flag=false
    for p, v in ipairs (styles) do
        if v.text==wildcards[5] then l_flag=true end 
    end
    if not l_flag then return end

	local l_string = table.concat({wildcards[5],"",wildcards[3],os.date(),"",os.time()},"|")
    dbTreaInsert(l_string)
end
function chat_Unique(name, line, wildcards, styles)

    color_chats(name, line, wildcards, styles)

    if score.id and score.id~='xxx' then
       return false
    end

    local l_flag=false
    for p, v in ipairs (styles) do
        if v.text==wildcards[6] then l_flag=true end 
    end
    if not l_flag then return end

    MudUnique = MudUnique or {}

    if MudUser[wildcards[3]] then
       if MudUser[wildcards[4]] then
          if MudUnique[wildcards[6]] and MudUnique[wildcards[6]]~=wildcards[3] then
             chatUniqueEarse(wildcards[6])
          end
          if not MudUnique[wildcards[6]] then
             flag.unique=2
          end
          MudUnique[wildcards[6]]=wildcards[3]
          chatUniqueChat(wildcards[6])
       end
    end
end
function chatUniqueEarse(p_unique)
    if score.id and score.id~='xxx' then
       return false
    end
    if os.time()-Mchat.time<20 or math.random(1,8)>5 then
       flag.unique=3
       return false
    end
    flag.unique=1
    Mchat.time=os.time()
    exe('chat* �ͳ�һ��С���������������'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'�����֡�')
end
function chatUniqueChat(p_unique)
    if score.id and score.id~='xxx' then
       return false
    end
    if flag.unique==3 then
       flag.unique=0
       return false
    end
    if (os.time()-Mchat.time<30 or math.random(1,8)>4) and flag.unique and flag.unique==0 then
       return false
    end
    Mchat.time=os.time()
    if flag.unique and flag.unique==2 then
       if math.random(1,3)==1 then
          exe('chat* �ͳ�һ��С�����ɿ��дд��������Լ���Կ�������ŤŤ��'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'�����֡�')
       elseif math.random(1,3)==2 then
          exe('chat* ��æ���һ����ֽ��д��'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'�����֣��ְ�������һ���ʼǱ����档')
       else
          exe('chat* �ó�һ����Ƥ�������˼�ҳ���˶�������д��'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'�������֡�')
       end
    elseif flag.unique and flag.unique==1 then
       exe('chat* ���ں�������'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'�����֡�')
    else
       exe('chat* �ͳ�һ��С������'.. p_unique .. MudUnique[p_unique] .. MudUser[MudUnique[p_unique]] ..'��������������һ�顣')
    end
    flag.unique=0
end

function rumor_unique(name, line, wildcards, styles)

    color_chats(name, line, wildcards, styles)

end

function printTab(tab,sp)
   local l_dis = 20
   if tmp.objs then l_dis = 5 end
   tmp.i = sp or 1
   if type(tab) ~= "table" then
      if type(v)=="boolean" then
	     if v then v = "true" else v = "false" end
	  end
	  if type(v)=="function" then
	     v = "function"
	  end
	  Note(v)
   else
      for p,v in pairs(tab) do
          if type(v) == "table" then
	    	  Tell (string.rep(" ",(tmp.i-1)*l_dis))
	    	  local s = p..' = '
	    	  local s = s.. string.rep(" ",l_dis - #s)
	    	  Tell (s)
	    	  Note('{')
	    	  printTab(v,tmp.i+1)
	    	  Tell (string.rep(" ",(tmp.i-2)*l_dis))
	    	  Note('},')
	    	  tmp.i = tmp.i - 1
	       else
	          Tell (string.rep(" ",(tmp.i-1)*l_dis))
	    	  if type(v)=="boolean" then
	    	     if v then v = "true" else v = "false" end
	    	  end
	    	  if type(v)=="function" then
	    	     v = "function"
	    	  end
	          Note('["'..p,'"] = "',v..'",')
	       end
      end
   end
end

function getRandomIndex(p_set)
    if type(p_set)~="table" then
	   return false
	end
	local l_cnt = countTab(p_set)
	if l_cnt == 0 then return false end
	local l_n = math.random(1,l_cnt)
	local l_i = 0
	for p in pairs(p_set) do
	    l_i = l_i + 1
		if l_i == l_n then
		   return p
		end
	end
	return false
end
function getRandomElement(p_set)
    if type(p_set)~="table" then
	   return false
	end
	local l_cnt = countTab(p_set)
	if l_cnt == 0 then return false end
	local l_n = math.random(1,l_cnt)
	local l_i = 0
	for p,q in pairs(p_set) do
	    l_i = l_i + 1
		if l_i == l_n then
		   return q
		end
	end
	return false
end


