--hubiao
jobSpecial = jobSpecial or {}
jobSpecial["hubiao"] = true 
job.list = job.list or {}
job.list["hubiao"] =function() if canwu and canwu.gift and canwu.gift>1 then return "���ݻ���" else return false end end
joblast = joblast or {}
joblast["���ݻ���"] = "hubiao"
jobCond = jobCond or {}
jobCond["hubiao"] = function() if job.last~="hubiao" and job.teamname and (not condition["�����ھֻ��ڵ���ʱ"] or (condition["�����ھֻ��ڵ���ʱ"] and condition["�����ھֻ��ڵ���ʱ"]==0) or (condition["����æ״̬"] and condition["�����ھֻ��ڵ���ʱ"] and condition["�����ھֻ��ڵ���ʱ"]<=condition["����æ״̬"])) then return true else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["hubiao"] = "hubiaoTriggerDel"

function hubiaoTrigger()
    DeleteTriggerGroup("hubiaoTeam")
    create_trigger_t('hubiaoTeam1',"^(> )*�����Ը����룬���� team with (\\D*)��$",'','hubiaoTeam')
    create_triggerex_lvl('hubiaoTeam2',"^(> )*�����顿(\\D*)\\((\\D*)\\)��where are you?",'','hubiaoTeamWhere',95)
    create_triggerex_lvl('hubiaoTeam3',"^(> )*�����顿(\\D*)\\((\\D*)\\)�����ѵ��(\\D*)��!",'','hubiaoTeamReply',95)
    create_trigger_t('hubiaoTeam4',"^(> )*"..job.teamname.."����������Ķ��顣",'','hubiaoTeamMeet')
    create_triggerex_lvl('hubiaoTeam5',"^(> )*�����顿(\\D*)\\((\\D*)\\)�����Ѿ�����Ŀ�ĵأ�",'','hubiaoTeamReady',95)
    create_triggerex_lvl('hubiaoTeam6',"^(> )*�����㻤��ʧ�ܣ������ھֵ���ʮ���ƽ������⳥�ˡ�$",'','hubiaoTeamFail',95)
	create_triggerex_lvl('hubiaoTeam7',"^(> )*�����顿(\\D*)\\((\\D*)\\)�������ˣ�",'','hubiaoTeamEnter',95)
    create_triggerex_lvl('hubiaoTeam8',"^(> )*�����顿(\\D*)\\((\\D*)\\)��hubiao �������!",'','hubiaoTeamFangqi',95)
	create_triggerex_lvl('hubiaoTeam9',"^(> )*�����顿(\\D*)\\((\\D*)\\)��������(\\D*)���Ըϳ�ǰ��(\\D*)�ͻ���(\\D*)���뾡�������",'','hubiaoTeamHurry',95)
    create_triggerex_lvl('hubiaoTeama',"^(> )*�����顿(\\D*)\\((\\D*)\\)��(\\D*)��������",'','hubiaoQuit',95)
    SetTriggerOption("hubiaoTeam1","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam2","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam3","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam4","group","hubiaoTeam")--����û���룬��������
    SetTriggerOption("hubiaoTeam5","group","hubiaoTeam")
    SetTriggerOption("hubiaoTeam6","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam7","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam8","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeam9","group","hubiaoTeam")
	SetTriggerOption("hubiaoTeama","group","hubiaoTeam")
    DeleteTriggerGroup("hubiaoAsk")
    create_trigger_t('hubiaoAsk1',"^(> )*(��|"..job.teamlead..")�������ϴ����й�",'','hubiaoAsk')
    create_trigger_t('hubiaoAsk2',"^(> )*����û������ˡ�$",'','hubiaoNobody')
    SetTriggerOption("hubiaoAsk1","group","hubiaoAsk")
    SetTriggerOption("hubiaoAsk2","group","hubiaoAsk")
    EnableTriggerGroup("hubiaoAsk",false)
    DeleteTriggerGroup("hubiaoAccept")
    create_trigger_t('hubiaoAccept1',"^(> )*������˵�������뻤����һ��������(\\D*)��(\\D*)���С�",'','hubiaoWhere')
    create_trigger_t('hubiaoAccept2',"^(> )*������˵�������㻹�ǽ�",'','hubiaoFail')
    create_trigger_t('hubiaoAccept3',"^(> )*������˵������ҹ�令�ڣ�ʵ��̫��Σ�գ��ҷ��Ĳ��¡�",'','hubiaoBusy')
    create_trigger_t('hubiaoAccept4',"^(> )*������˵���������������Ѿ����˽�����֧����",'','hubiaoBusy')
    create_trigger_t('hubiaoAccept5',"^(> )*������˵����������·;Σ�գ�����ô�ٵ��ˣ��ҿɲ����ġ�",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept6',"^(> )*������˵����������·;Σ�գ������˶���û�õġ�",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept7',"^(> )*������˵������ֻ�ж����������������ڡ�",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept8',"^(> )*������˵��������Ķ�����������⣬���ɢ�������齨��",'','hubiaoTeamDis')
    create_trigger_t('hubiaoAccept9',"^(> )*������˵�������ţ���Ķ�������ô�����̰��֮�ˣ�",'','hubiaoFail')
    create_trigger_t('hubiaoAccept10',"^(> )*������˵�������ף���ô�����˲�ȫ����",'','hubiaoTeamMiss')
    create_trigger_t('hubiaoAccept11',"^(> )*������˵������������Σ�յ��£��ҿ�",'','hubiaoFail')
    create_trigger_t('hubiaoAccept12',"^(> )*������˵����������·;Σ�գ��ҿ���λ�����������",'','hubiaoFail')
    create_trigger_t('hubiaoAccept13',"^(> )*������˵����������û������Ҫ�ͼ�",'','hubiaoBusyF')
    create_trigger_t('hubiaoAccept14',"^(> )*������˵������(һֱ���ں������|��̨�ϴλ���������)",'','hubiaoBusy')
    SetTriggerOption("hubiaoAccept1","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept2","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept3","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept4","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept5","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept6","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept7","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept8","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept9","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept10","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept11","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept12","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept13","group","hubiaoAccept")
    SetTriggerOption("hubiaoAccept14","group","hubiaoAccept")
    EnableTriggerGroup("hubiaoAccept",false)
    DeleteTriggerGroup("hubiaoFight")
    create_trigger_t('hubiaoFight1','^(> )*(\\D*)��ž����һ�����ڵ���','','hubiaoJiefeiDie')
    create_trigger_t('hubiaoFight2','^(> )*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','hubiaoJiefeiFaint')
    create_trigger_t('hubiaoFight3','^(> )*���빥��˭��','','')
    create_triggerex_lvl('hubiaoFight4','^(> )*������(\\D*)��ɱ���㣡$','','hubiaoJiefeiKill',98)
    SetTriggerOption("hubiaoFight1","group","hubiaoFight") 
    SetTriggerOption("hubiaoFight2","group","hubiaoFight")
    SetTriggerOption("hubiaoFight3","group","hubiaoFight")
    SetTriggerOption("hubiaoFight4","group","hubiaoFight")
    EnableTriggerGroup("hubiaoFight",false)
    DeleteTriggerGroup("hubiaoBoat")
    create_trigger_t('hubiaoBoat1','^(> )*����(��|)��̤�Ű���','','hubiaoBoat')
    create_trigger_t('hubiaoBoat2','^(> )*������̤�Ű���������˵��һ��','','hubiaoBoat')
    create_trigger_t('hubiaoBoat3','^(> )*(�ɴ��͵�һ���Ѿ�����|����˵���������ϰ��ɡ�)','','hubiaoBoatOut')
    create_trigger_t('hubiaoBoat4','^(> )*˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ','','hubiaoBoatOut')
	create_trigger_t('hubiaoBoat5','^(> )*(һҶ���ۻ�����ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿����¡�|һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����)','','hubiaoEnter')
    SetTriggerOption("hubiaoBoat1","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat2","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat3","group","hubiaoBoat")
    SetTriggerOption("hubiaoBoat4","group","hubiaoBoat")
	SetTriggerOption("hubiaoBoat5","group","hubiaoBoat")
    EnableTriggerGroup("hubiaoBoat",false)
    DeleteTriggerGroup("hubiaoDriver")
    create_trigger_t('hubiaoDriver1','^(> )*��Ҫ������ȥ��','','hubiaoTestPass')
    create_trigger_t('hubiaoDriver2','^(> )*�ٷ���δ��ȥ��������������','','hubiaoTestJiefei')
    create_trigger_t('hubiaoDriver3','^(> )*(��������æ������ָ���ڳ�ǰ��|������ô�죬����ڳ�Ūɢ����)','','hubiaoTest')
    create_trigger_t('hubiaoDriver4','^(> )*�������ڴ��ϣ�û�ط���ȥ��','','hubiaoTest')
	create_trigger_t('hubiaoDriver5','^(> )*�ڳ���(��|'.. job.teamname ..')�Ļ����»���','','hubiaoTestGo')
    SetTriggerOption("hubiaoDriver1","group","hubiaoDriver") 
    SetTriggerOption("hubiaoDriver2","group","hubiaoDriver")
    SetTriggerOption("hubiaoDriver3","group","hubiaoDriver")
    SetTriggerOption("hubiaoDriver4","group","hubiaoDriver")
	SetTriggerOption("hubiaoDriver5","group","hubiaoDriver")
	EnableTriggerGroup("hubiaoDriver",false)
    DeleteTriggerGroup("hubiaoFinish")
    create_trigger_t('hubiaoFinish1','^(> )*ֻ�ж���������ܾ��������Ƿ��Ѿ�������','','hubiaoFinishWait')
    create_trigger_t('hubiaoFinish2','^(> )*�ٷ˻��ڣ�����������δ��ɣ�','','hubiaoJiefei')
    create_trigger_t('hubiaoFinish3','^(> )*��Ķ�Ա��δ���룡','','hubiaoFinishWait')
    create_trigger_t('hubiaoFinish4','^(> )*�㱻������(\\D*)�㾭�飬(\\D*)��Ǳ�ܣ�(\\D*)���ƽ�','','hubiaoFinish')
    SetTriggerOption("hubiaoFinish1","group","hubiaoFinish") 
    SetTriggerOption("hubiaoFinish2","group","hubiaoFinish")
    SetTriggerOption("hubiaoFinish3","group","hubiaoFinish")
    SetTriggerOption("hubiaoFinish4","group","hubiaoFinish")
end

function hubiaoTriggerDel()
    DeleteTriggerGroup("hubiaoTeam")
    DeleteTriggerGroup("hubiaoAsk")
    DeleteTriggerGroup("hubiaoAccept")
    DeleteTriggerGroup("hubiaoFight")
    DeleteTriggerGroup("hubiaoBoat")
    DeleteTriggerGroup("hubiaoDriver")
    DeleteTriggerGroup("hubiaoFinish")
end
function hubiaoNobody()
    EnableTriggerGroup("hubiaoAsk",false)
    return hubiao()
end

function hubiao()
    if not Bag["�󻹵�"] or Bag["�󻹵�"].cnt<2 then
	    return checkDhd()
	end
    --job.name = 'hubiao'
    job.time.b = os.time()
    job.teamname = job.teamname or "teamname"
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
    tmp.hbteamfail = nil
    if not job.teamlead or job.teamlead=="" or job.teamlead==" " then job.teamlead=score.name end
    hubiaoTrigger()
    return prepare_lianxi(hubiaoGo)
end
function hubiaoGo()
    return go(hubiaoPre,"���ݳ�","�����ھ�")
end
function hubiaoPre()
    flag.idle = 0
    --if os.time()-job.time.b>1800 then
	if os.time()-job.time.b>300 then
       --job.zuhe["hubiao"]=nil
       return hubiaoChang()
    end
    locate()
    return checkWait(hubiaoWait,3)
end
function hubiaoTeam(n,l,w)
    if job.teamlead and job.teamlead==job.teamname and w[2]==job.teamid then
       exe('team dismiss')
       exe('team with '..job.teamid)
       if locl.room=="�����ھ�" then
          dis_all()
          exe('halt')
		  locate()
          return check_bei(hubiaoStart)
		  --return prepare_neili(hubiaoStart)
       end
    end
end
function hubiaoTeamWhere(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)
    if wildcards[2]==job.teamname and not tmp.hblost then 
       exe('tt ���ѵ��'.. locl.area .. locl.room ..'��!')
    end
end
function hubiaoTeamReply(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and tmp.hblost then
       DeleteTimer("hubiaoc")
       disWait()
       local l_where=wildcards[4]
       dest.room,dest.area=getAddr(l_where)
       if not dest.room or dest.room==locl.room then
          return checkWait(hubiaoTeamAsk,3)
       end
       if string.find(dest.room,"�ɴ�") then
          return checkWait(hubiaoTeamAsk,3)
       end
       local l_rooms=getRooms(dest.room,dest.area)
       local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
       tmp.sourid=l_dest
       tmphubiaocart=nil
       job.killer={}
       return go(hubiaoConsider,l_dest,l_room)
    end
end
function hubiaoTeamAsk()
    exe('tt where are you?')
end
function hubiaoTeamReady(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and not tmp.hubiaoready then
       if job.area~=locl.area and locl.area ~= "��֪������" then
	      tmp.hubiaoready = true
          DeleteTimer("hubiaoc")
          disWait()
          dest.room,dest.area=getAddr(job.where)
	      local l_rooms=getRooms(dest.room,dest.area)
          local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
          tmp.sourid=l_dest
          tmphubiaocart=nil
          job.killer={}
		  tmp.jiefei = nil
          return go(hubiaoConsider,l_dest,l_room)
       end
    end
end

function hubiaoTeamFail()
    tmp.hbteamfail = true
    messageShow('�������񣺻���ʧ�ܣ�')
	--SetVariable("hubiaofailadd",job.where)
	hubiaoFailadd(job.where)
    return check_heal()
end
function hubiaoTeamMeet()
    if locl.room=="�����ھ�" then
       dis_all()
       exe('halt')
       return check_bei(hubiaoStart)
    end
end
function hubiaoWait()
    if locl.area~="���ݳ�" or locl.room~="�����ھ�" then
       return hubiaoGo()
    end
    if locl.id[job.teamname] and score.name==job.teamlead then
	   job.teamid = locl.id[job.teamname]
       exe('team dismiss')
       exe('team with '.. job.teamid)
    else
       return prepare_lianxi(hubiaoPre)
    end
end
function hubiaoStart()
    DeleteTrigger("hubiaoTeam4")
    DeleteTrigger("hubiaoTeam5")
    EnableTriggerGroup("hubiaoAsk",true)
	job.name = 'hubiao'
    exe('s')
    locate()
	return check_bei(hubiaoStartLoc,1)
end
function hubiaoStartLoc()
    if locl.room=="�����ھ�" then
	    return hubiaoStart()
	end
    if job.teamlead==score.name then
	    if not locl.id[job.teamname] then
		    locate()
			return checkWait(hubiaoStartLoc,2)
		end
        exe('askk lin zhennan about ����')
    end
end
function hubiaoAsk()
    EnableTriggerGroup("hubiaoAsk",false)
    EnableTriggerGroup("hubiaoAccept",true)
    EnableTriggerGroup("hubiaoTeam",true)
    job.teamid = MudUser[job.teamname]
    job.teamid = job.teamid or "teamid"
end
function hubiaoBusy()
    EnableTriggerGroup("hubiaoAccept",false)
    --job.last='hubiao'
    return checkJob()
end
function hubiaoBusyF()
    EnableTriggerGroup("hubiaoAccept",false)
    tmp.hbbusy = tmp.hbbusy or 0
    tmp.hbbusy = tmp.hbbusy + 1
    if tmp.hbbusy > 30 then
        tmp.hbbusy = 0
		exe('tt �Ӳ������񣬻�������')
        return check_bei(hubiaoChang,1)
    else
        return check_bei(hubiaoStart,1)
    end
end
function hubiaoQuit(n,l,w)
    if w[2]==job.teamname then
        --return check_bei(husongQuit,1)
		return check_bei(hubiaoChang,1)
	end
end
function hubiaoChang()
    condition["�����ھֻ��ڵ���ʱ"] = 100
	return checkJob()
end
function hubiaoTeamDis()
    EnableTriggerGroup("hubiaoAccept",false)
    EnableTriggerGroup("hubiaoAsk",true)
    exe('team dismiss')
    if job.teamlead==score.name then
       exe('team with '..job.teamid)
    end
    return check_bei(hubiaoStart)    
end
function hubiaoTeamMiss()
    EnableTriggerGroup("hubiaoAccept",false)
	exe('tt ��û���룬��������')
    return check_bei(hubiaoChang,1)
end
function hubiaoFail()
    EnableTriggerGroup("hubiaoAccept",false)
    job.last='hubiao'
    job.zuhe["hubiao"]=nil
    return check_job()    
end
function hubiaoTeamFangqi(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname then
	   return hubiaoFangqi()
	end
end
function hubiaoTeamHurry(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname then
	   if tmp.pre then
	      tmp.pre = nil
	   else
	      local l_where=wildcards[4]
          dest.room,dest.area=getAddr(l_where)
	      job.where = wildcards[5]
		  job.target = wildcards[6]
			 
		  if locl.area~="��֪������" and dest.area~="��֪������" and locl.area~=dest.area then
             DeleteTimer("hubiaoc")
             disWait()
             tmp.hblost = true
             if not dest.room or dest.room==locl.room then
                return checkWait(hubiaoTeamAsk,3)
             end
             if string.find(dest.room,"�ɴ�") then
                return checkWait(hubiaoTeamAsk,3)
             end
             local l_rooms=getRooms(dest.room,dest.area)
             local l_dest=getNearRoom("fuzhou/biaoju",l_rooms)
             tmp.sourid=l_dest
             tmphubiaocart=nil
             job.killer={}
             return go(hubiaoConsider,l_dest)
		  end
	   end
	end
end
function hubiaoFangqi()
    dis_all()
    messageShow('������������ص㡾'..job.where..'�����ɵ�����������')
	--SetVariable("hubiaoerradd",job.where)
	hubiaoErradd(job.where)
	exe('driver north')
	messageShow('��������hubiao �������!')
    return go(check_heal,'������','ҩ��')
end
function hubiaoErradd(p_where)
    if isNil(p_where) then return end
    local hubiaoerradd = GetVariable("hubiaoerradd")
	if not isNil(hubiaoerradd) then
	    hubiaoerradd = hubiaoerradd .."|"..p_where	
	else
	    hubiaoerradd = p_where
	end
	SetVariable("hubiaoerradd",hubiaoerradd)
end
function hubiaoFailadd(p_where)
    if isNil(p_where) then return end
    local hubiaofailadd = GetVariable("hubiaofailadd")
	if not isNil(hubiaofailadd) then
	    hubiaofailadd = hubiaofailadd .."|"..p_where	
	else
	    hubiaofailadd = p_where
	end
	SetVariable("hubiaofailadd",hubiaofailadd)
end 
function hubiaoWhere(n,l,w)
    EnableTriggerGroup("hubiaoAccept",false)
	EnableTriggerGroup("hubiaoDriver",false)
    job.time.b = os.time()
    job.last='hubiao'
    job.killer={}
	job.drive={}
	tmp.move = 0
    job.where=Trim(w[2])
    job.target=Trim(w[3])
    job.room,job.area=getAddr(job.where)
    hubiaoLocate()
    return checkNext(hubiaoConsider)
end
local hubiaoIgnores = {
	["��ɽ������"] = true,
	["������������"] = true,
	["�䵱ɽԺ��"] = true,
	--["�䵱ɽС��"] = true,
	["�䵱ɽ��ɽСԺ"] = true,
	["Ħ����"] = true,
}
function hubiaoConsider()
    EnableTriggerGroup("hubiaoFight",true)
	EnableTriggerGroup("hubiaoDriver",false)
	DeleteTimer("hubiaoc")
    dest.room=job.room
    dest.area=job.area
    flag.times=1
	sour.id = nil
    if tmp.sourid then
       sour.id=tmp.sourid
       tmp.sourid=nil
    end
    dest.id = nil
    if hubiaoIgnores[dest.area] or hubiaoIgnores[job.where] or not job.room or not path_cal() then
       return hubiaoFangqi()
    end
    messageShow('�������񣺴ӡ�'.. locl.area .. locl.room ..'��ǰ����'..job.where..'����')
	--job.drive = utils.split(path_cal(),';')
	local l_drive = path_cal()
	local l_sour = road.id
	local l_rooms = {}
	for p,q in pairs(dest.rooms) do
	    if q ~= l_sour then
	       table.insert(l_rooms,q)
	    end
	end
	--printTab(dest.rooms)
	while countTab(l_rooms)>0 do
	      printTab(l_rooms)
	      local l_dest,l_distance=getNearRoom(l_sour,l_rooms)
		  --messageShow(l_sour,l_dest)
		  if l_dest then
		     local l_path = path_cal_get(l_sour,l_dest)
			 if l_path and type(l_path)=="string" then
			    l_drive = l_drive .. ';' .. l_path
			    l_sour = l_dest
			    l_rooms = delElement(l_rooms,l_dest)
			 else
                return hubiaoFangqi()
			 end
		  else
		     l_rooms = {}
             return hubiaoFangqi()
          end			 
	end
	job.drive = utils.split(l_drive,';')
	messageShow('��������·����׼����!')
	local hubiaoFunc = {
	      ["#duHhe"] = true,
		  ["#duCjiang"] = true,
	--	  ["#wipe"] = true,
		  ["#walkBusy"] = true,
		  ["#weaponWWalk"] = true,
		  ["#weaponUnWalk"] = true,
	}
	local hubiaoExit = {
	      ["e"] = true,
		  ["w"] = true,
		  ["s"] = true,
		  ["n"] = true,
		  ["up"] = true,
		  ["down"] = true,
	      ["east"]  = true,
		  ["west"]  = true,
		  ["south"] = true,
		  ["north"] = true,
	}
	local l_func = true
	for p,q in pairs(job.drive) do
	    if string.find(q,"#") and not hubiaoFunc[q] and not string.find(q,"#wipe") then
		   --messageShow(q)
		   l_func = nil
		end
		if string.find(q,"jump") or string.find(q,"tiao") then
		   --messageShow(q)
		   l_func = nil
		end
	end
	
	if not l_func then
       return hubiaoFangqi()
	end
	
    fight_prepare()
    return check_bei(hubiaoDir,1) 
end
function hubiaoDir()
    EnableTriggerGroup("hubiaoTeam",true)
    EnableTriggerGroup("hubiaoBoat",true)
    EnableTriggerGroup("hubiaoFight",true)
    EnableTriggerGroup("hubiaoFinish",true)
	DeleteTimer("jiefei")

    if not job.drive or table.getn(job.drive)==0 then
	   hubiaoLocate()
       return check_busy(hubiaoRoom)
    end
    job.dir=job.drive[1]
    if job.dir=='halt' or isNil(job.dir) then
       table.remove(job.drive,1)
       return hubiaoDir()
    end
    if job.dir=="#duHhe" or job.dir=="#duCjiang" or job.dir=="dujiang" then
       table.remove(job.drive,1)
       table.insert(job.drive,1,"out")
       table.insert(job.drive,1,"enter")
       return hubiaoDir()
    end

    --messageShow('����Ŀ�ĵ�'.. job.where .. '����'.. countTab(job.drive) ..'��!')

    local l_cnt
    if countTab(job.drive) > 10 then
	   l_cnt = 10
    else
	   l_cnt = countTab(job.drive)
    end
	--for i=1,l_cnt do
	--    messageShow('�� '..i..' ��Ϊ:'..job.drive[i])
	--end

	tmp.enter = nil
	tmp.pre = nil
	
	cntrH = countR(20)
	
    return hubiaoDrive()
end
faintFunc = faintFunc or {}
faintFunc["hubiao"] = "hubiaoDrive"
function hubiaoDrive()

    local dukou = {
      ["�½��ɿ�"] = true,
	  ["���Ķɿ�"] = true,
	  ["���׽���"] = true,
	  ["��ɿ�"] = true,
	  ["�����ϰ�"] = true,
	  ["��ˮ����"] = true,
    }

    if tmp.jiefei then return hubiaoJieFeiStop() end

    if locl.room==job.room and locl.id[job.target] then
       hubiaoLocate()
       return check_busy(hubiaoRoom)
    end
    if table.getn(job.drive)==0 then
       hubiaoLocate()
       return check_busy(hubiaoRoom)
    end

    if string.find(job.dir,"#wipe") then
       local l_wipe = del_string(job.dir,"#wipe ")
       return wipe(l_wipe,hubiaoNext)
    end
    if string.find(job.dir,"open") or string.find(job.dir,"pull") or string.find(job.dir,"knock") then
       tmp.dir = job.dir
       exe(job.dir)
       return check_bei(hubiaoNext,1)
    end
    if string.find(job.dir,"#walkBusy") then
       return check_bei(hubiaoNext,1)
    end
    if string.find(job.dir,"#weaponWWalk") then
       weapon_wield()
       return hubiaoNext()
    end
    if string.find(job.dir,"#weaponUnWalk") then
       weapon_unwield()
       return hubiaoNext()
    end

	if dukou[locl.room] and job.dir=="enter" and not tmp.enter then
	   EnableTriggerGroup("hubiaoBoat",true)
	   if locl.id[job.teamname] then
	      exe('yell boat')
	   end
	   if not tmphubiaocart then
	      tmp.enter=true
	   end
	   hubiaoLocate()
       return checkWait(hubiaoDrive,2)
	end
	
    if string.find(locl.room,"�ɴ�") then
	   tmp.enter = nil
	end

    if string.find(locl.room,"�ɴ�") and job.dir=="enter" then
       EnableTriggerGroup("hubiaoBoat",true)
       table.remove(job.drive,1)
       return hubiaoDir()
    end
	
    if string.find(locl.room,"�ɴ�") and not tmp.hbboat then
       EnableTriggerGroup("hubiaoBoat",true)
	   if not locl.exit["out"] then
	      tmp.hbboat = true
       end	   
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if string.find(locl.room,"�ɴ�") and job.dir=="out" and not locl.exit[job.dir] then
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if tmphubiaocart then
	   if cntrH()>0 and not locl.id[job.teamname] and not dukou[locl.room] and not string.find(locl.room,"�ɴ�") then
	      hubiaoLocate()
          return checkWait(hubiaoDrive,3)
	   end
	   if not locl.id[job.teamname] then
	      exe('tt ������'..locl.where..'���Ըϳ�ǰ��'..job.where..'�ͻ���'..job.target..'���뾡�������')
	   end
       tmp.move = 0
       EnableTriggerGroup("hubiaoDriver",false)
       tmp.hblost = nil
       exe('driver '.. job.dir)
       hubiaoLocate()
       return check_bei(hubiaoDrive,1)
    else
       tmp.move = tmp.move or 0
	   tmp.move = tmp.move + 1
       if tmp.move > 20 then
          tmp.move = 0
          tmp.hblost = true
	      messageShow('���������ڡ�'.. locl.area .. locl.room ..'����ʧ�ڳ���')
          hubiaoTeamAsk()
	  --return checkWait(hubiaoRconsider,30)
       end
    end
    hubiaoLocate()
    return check_busy(hubiaoConfirm,1)
end
function hubiaoConfirm()
    local dukou = {
          ["�½��ɿ�"] = true,
	  ["���Ķɿ�"] = true,
	  ["���׽���"] = true,
	  ["��ɿ�"] = true,
	  ["�����ϰ�"] = true,
	  ["��ˮ����"] = true,
    }

    if tmp.jiefei then return hubiaoJieFeiStop() end

    if dukou[locl.room] then
       exe('yell boat')
    end
	
    if string.find(locl.room,"�ɴ�") and job.dir=="out" and not locl.exit[job.dir] then
       tmp.move = 0
       hubiaoLocate()
       return checkWait(hubiaoDrive,2)
    end

    if tmphubiaocart and dukou[locl.room] and job.dir=="enter" then
       return checkWait(hubiaoDrive,1)
    end
	
    if tmphubiaocart and not locl.id[job.target] and not string.find(locl.room,"�ɴ�") then
       tmp.hbcnt = tmp.hbcnt or 0
       tmp.hbcnt = tmp.hbcnt + 1
       messageShow('��������ԭ���Ƴ���'.. tmp.hbcnt ..'��!')
       if tmp.hbcnt>20 then
          tmp.hbcnt = 0
	      messageShow('���������ڡ�'.. locl.area .. locl.room ..'��������·�������¼�����·��')
          return hubiaoConsider()
       end
       return checkWait(hubiaoDrive,2)
    end
    return hubiaoPrepare()
end
function hubiaoLocate()
    EnableTriggerGroup("hubiaoDriver",true)
    tmphubiaocart=nil
    locate()
    exe('driver test')
end
function hubiaoTest()
    tmphubiaocart=true
end
function hubiaoTestPass()
    tmphubiaocart=true
    job.killer={}
end
function hubiaoTestGo()
    local dukou = {
      ["�½��ɿ�"] = true,
	  ["���Ķɿ�"] = true,
	  ["���׽���"] = true,
	  ["��ɿ�"] = true,
	  ["�����ϰ�"] = true,
	  ["��ˮ����"] = true,
    }

    if not dukou[locl.room] then
       return hubiaoJiefeiOver()
    end

end
function hubiaoTestJiefei()
    tmphubiaocart=true
    for i=1,3 do
        exe('kill jie fei '..i)
    end
end
function hubiaoJieFeiStop()
    for p in pairs(job.killer) do
	    --messageShow('��·�ٷ�: '..p)
	end
end
function hubiaoPrepare()
    if tmp.jiefei then return hubiaoJieFeiStop() end
	
	tmp.pre = true
	
    local dukou = {
        ["�½��ɿ�"] = true,
	    ["���Ķɿ�"] = true,
	    ["���׽���"] = true,
	    ["��ɿ�"] = true,
	    ["�����ϰ�"] = true,
	    ["��ˮ����"] = true,
    }
    if dukou[locl.room] then
       return check_bei(hubiaoMove)
    end
    if perform.force and skills[perform.force] then
       exe('jifa force '.. perform.force)
    end
    exe('yun qi;yun jing;yun jingli;hp')
    if (hp.qixue_per<80 or hp.jingxue_per<80 or hp.neili<3000) and (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
       exe('eat dan;hp')
       checkBags()
       return check_bei(hubiaoPrepare)
    end
    if hp.qixue_per<90 and not (Bag["�󻹵�"] or Bag["�󻹵�(��)"]) then
       exe('yun heal')
       return check_bei(hubiaoPrepare)
    end
    if hp.neili<hp.neili_max*1.2 then
        --return prepare_neili(hubiaoPrepare,1.3)
		return prepare_neili(hubiaoMove,1.3)
    end
	
	fightSkillPrepare()
	
    return check_busy(hubiaoMove,1)
end
function hubiaoMove()
    if tmp.jiefei then return hubiaoJieFeiStop() end

	tmp.pre = nil
	
    local dukou = {
        ["�½��ɿ�"] = true,
	    ["���Ķɿ�"] = true,
	    ["���׽���"] = true,
	    ["��ɿ�"] = true,
	    ["�����ϰ�"] = true,
	    ["��ˮ����"] = true,
    }

    if dukou[locl.room] then
       exe('yell boat')
    end
    --messageShow('ǰ������: '.. job.dir)
    if tmp.dir then
       exe(tmp.dir)
       tmp.dir = nil
    end
    exe(job.dir)
    
    hubiaoLocate()
	if locl.area == "��ɽ����" then
       checkWield()
	end
    return checkNext(hubiaoNext)
end
function hubiaoNext()
    local dukou = {
      ["�½��ɿ�"] = true,
	  ["���Ķɿ�"] = true,
	  ["���׽���"] = true,
	  ["��ɿ�"] = true,
	  ["�����ϰ�"] = true,
	  ["��ˮ����"] = true,
    }

    if tmp.hbboat and not string.find(locl.room,"�ɴ�") then tmp.hbboat=nil end
    --tmphubiaocart=nil
    --job.killer={}
    tmp.hbcnt=0

    if dukou[locl.room] and job.dir=="enter" then
       hubiaoLocate()
       return checkWait(hubiaoDrive,1)
    end
	
    --messageShow('�Ƴ�·��: '.. job.dir)
    table.remove(job.drive,1)
    hubiaoLocate()

    if tmp.jiefei then return hubiaoJieFeiStop() end

    return check_bei(hubiaoDir,1)
end
function hubiaoJiefeiKill(n,l,w)
    exe('set wimpy 100')
    if not job.killer[w[2]] and not dangerousNpc[w[2]] then
       job.killer[w[2]]="jie fei"
       messageShow('���������ڡ�' ..locl.area ..locl.room.. '�������ٷ�:' ..w[2])
       tmp.jiefei = true
       flag.idle = 0
       if countTab(job.killer)>1 then
          if job.teamlead==score.name then
	     --killPfm('jie fei 2')
	     exe('kill jie fei 2')
	     exe('kill jie fei 1')
	  else
	     --killPfm('jie fei 1')
	     exe('kill jie fei 1')
	     exe('kill jie fei 2')
	  end
       end
    end 
    --if locl.id[w[2]] then
    --   job.killer[w[2]]=locl.id[w[2]]
    --   killPfm(job.killer[w[2]])
    --end
    --hubiaoLocate()
    --return check_busy(hubiaoDrive,1)
	create_timer_s('jiefei',15,'hubiaoJiefeiLocate')
end
function hubiaoJiefeiFaint(n,l,w)
    if job.killer[w[2]] and locl.id[w[2]] then
       exe('kill '.. locl.id[w[2]])
       --job.killer[w[2]]="faint"
    end    
end
function hubiaoJiefeiDie(n,l,w)
    hubiaoJieFeiStop()
    if job.killer[w[2]] then
	   messageShow('��������'..w[2]..'���ˣ�')
       job.killer[w[2]] = nil
       if countTab(job.killer)==0 then
          tmp.jiefei = nil
	      messageShow('���������ڡ�' ..locl.area ..locl.room.. '���㶨һ���ٷˣ���ʱ����Ŀ�ĵ�'.. job.where .. '����'.. countTab(job.drive) ..'��!')
          return hubiaoJiefeiOver()
       end
    end	   
end
function hubiaoJiefeiLocate()
    locate()
	return checkNext(hubiaoJiefeiCheck)
end
function hubiaoJiefeiCheck()
    local l_flag = true
	for p in pairs(job.killer) do
	    if locl.id[p] then l_flag = false end
	end
	if l_flag then
	   return hubiaoJiefeiOver()
	end
end
function hubiaoJiefeiOver()
    EnableTimer("jiefei",false)
    DeleteTimer("jiefei")
    --hubiaoLocate()
    --return check_busy(hubiaoDir,1)
	disWait()
	checkWield()
    return check_bei(hubiaoDir)

end
function hubiaoBoat()
    if string.find(locl.room,"�ɴ�") then
       tmp.hbboat=true
	end
end
function hubiaoEnter()
    local dukou = {
      ["�½��ɿ�"] = true,
	  ["���Ķɿ�"] = true,
	  ["���׽���"] = true,
	  ["��ɿ�"] = true,
	  ["�����ϰ�"] = true,
	  ["��ˮ����"] = true,
    }
	
    if dukou[locl.room] and job.dir=="enter" and not tmp.jiefei then
	   if locl.id[job.teamname] then
	      exe('tt �����ˣ�')
		  tmp.enter=true
	   end
	   if not tmphubiaocart then
	      tmp.enter=true
	   end
	end
end
function hubiaoBoatOut()
    EnableTriggerGroup("hubiaoBoat",false)
    disWait()
    return check_bei(hubiaoDrive)
end
function hubiaoTeamEnter(name, line, wildcards, styles)
    color_chats(name, line, wildcards, styles)

    if wildcards[2]==job.teamname and not tmp.enter then
	   local dukou = {
          ["�½��ɿ�"] = true,
	      ["���Ķɿ�"] = true,
	      ["���׽���"] = true,
	      ["��ɿ�"] = true,
	      ["�����ϰ�"] = true,
	      ["��ˮ����"] = true,
       }
       if dukou[locl.room] then
          tmp.enter = true
	   end
	end
end
function hubiaoRoom()
    hubiaoTrigger()
    if tmp.jiefei then return hubiaoJieFeiStop() end
    if locl.room==job.room and locl.id["�ڳ�"] and tmphubiaocart and locl.id[job.target] then
       EnableTriggerGroup("hubiaoFinish",true)
       exe("finish")
       tmp.hubiaoready = true
       exe('tt ���Ѿ�����Ŀ�ĵأ�')
    else
       if locl.room==job.room and locl.id[job.target] then
          if not tmp.hbfail or tmp.hbfail>3 then
	         tmp.hbfail = 0
	      end
	      tmp.hbfail = tmp.hbfail + 1
	      if tmp.hbfail>2 then 
	         tmp.hbfail = nil
	         messageShow('�������񣺶�ζ�ʧ�ڳ�������ʧ�ܣ�')
	         return hubiaoFangqi()
	      end
       end
       hubiaoLocate()
       tmp.hblost = true
       messageShow('���������ڡ�'.. locl.area .. locl.room ..'����ʧ�ڳ���׼����ͷ��ʼ��')
       hubiaoTeamAsk()
       return checkWait(hubiaoRconsider,40)
    end
end
function hubiaoRconsider()
    EnableTimer("hubiaoc",false)
    if tmp.hbteamfail then
       messageShow('���������ڡ�'.. locl.area .. locl.room ..'����ʧ�ڳ�������ʧ�ܣ�')
	   return hubiaoFangqi()
    end
    return go(hubiaoConsider,"���ݳ�","�ھ�����")
end
function hubiaoFinish(n,l,w)
    EnableTriggerGroup("hubiaoFinish",false)
    messageShow('�������񣺳ɹ��ִ'..job.where..'��,��������:��'..w[2]..'���㣬Ǳ��:��'..w[3]..'���㣬�ƽ�:��'..w[4]..'������')
    tmp.hubiaoready = nil
    return check_heal()
end
function hubiaoFinishWait()
    if job.teamlead==score.name then
       return checkWait(hubiaoRoom,3)
    end
end