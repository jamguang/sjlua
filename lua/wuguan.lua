
local wgAct
local wgRm = false

function wuguanRoad(where)
    local l_dest={}
    where = Trim(where)
    if string.find(where,"/") then
        local l_path=path_cal_get(where,"wuguan/dating")
        if l_path then
            return l_path
	    end
    else
        l_dest.room,l_dest.area=getAddr(Trim(where))
    end
	local long_path = false
    if l_dest.area then
        local l_rooms=getRooms(l_dest.room,l_dest.area)
	    for k,v in pairs(l_rooms) do
	        local l_path=path_cal_get(v,"wuguan/dating")
            if l_path and (not long_path or string.len(long_path)<string.len(l_path))then
                long_path = l_path
	        end
	    end
    end
    if long_path then return long_path end
    return false
end

function wuguanTrigger()
    DeleteTriggerGroup("wuguanAsk")
    create_trigger_t('wuguanAsk1',"^(> )*����³�������й�",'','wuguanAsk')
    create_trigger_t('wuguanAsk2',"^(> )*����û������ˡ�$",'','wuguanNobody')
    SetTriggerOption("wuguanAsk1","group","wuguanAsk")
    SetTriggerOption("wuguanAsk2","group","wuguanAsk")
    EnableTriggerGroup("wuguanAsk",false)
    DeleteTriggerGroup("wuguanAccept")
    create_trigger_t('wuguanAccept1',"^(> )*³��˵������(���������кö���Ҫ��|�����ݺ�æ)��(����ȥ����Ʒ���칤��|��������Ʒ����ù���)",'','wuguanTool')
    create_trigger_t('wuguanAccept2',"^(> )*³��˵�������㲻���Ѿ����˹���",'','wuguanTool')
    create_trigger_t('wuguanAccept3',"^(> )*³��˵������\\D*����û��ʲô�¿���������ʱ�������ɡ���",'','wuguanBusy')
	create_trigger_t('wuguanAccept4',"^(> )*³��˵�������㹦���Ѿ�ͦ���ˣ�����û��ʲô�ʺ���Ĺ����ˡ���",'','wuguanBusy')
    SetTriggerOption("wuguanAccept1","group","wuguanAccept")
    SetTriggerOption("wuguanAccept2","group","wuguanAccept")
    SetTriggerOption("wuguanAccept3","group","wuguanAccept")
	SetTriggerOption("wuguanAccept4","group","wuguanAccept")
    EnableTriggerGroup("wuguanAccept",false)
    DeleteTriggerGroup("wuguanTool")
    create_trigger_t('wuguanTool1',"^(> )*����û������ˡ�$",'','wuguanNobody')
    create_trigger_t('wuguanTool2',"^(> )*��\\D*(��|��)��һ(��|��|ֻ|��)(\\D*)(�������С�|���ڼ��С�)",'','wuguanToolConsider')
    SetTriggerOption("wuguanTool1","group","wuguanTool")
    SetTriggerOption("wuguanTool2","group","wuguanTool")
    EnableTriggerGroup("wuguanTool",false)
    DeleteTriggerGroup("wuguanWork")
    create_trigger_t('wuguanWork1',"^(> )*(�����˸��ط���ʼɨ������|����ư�Ӹ���Ҩ��ˮ|������ͷ|�����һ��ľͷ|��������ˮͰ�е�ˮ����|�����һ��ľͷ)",'','wuguanGoon')
    create_trigger_t('wuguanWork2',"^(> )*(�˵�|��|ˮ��|ľ��|��|��԰)����˵�������ɵĲ���",'','wuguanBack')
    SetTriggerOption("wuguanWork1","group","wuguanWork")
    SetTriggerOption("wuguanWork2","group","wuguanWork")
    EnableTriggerGroup("wuguanWork",false)
    DeleteTriggerGroup("wuguanFinish")
    create_trigger_t('wuguanFinish1',"^(> )*³����������ĵ�һЦ��",'','wuguanLit')
    create_trigger_t('wuguanFinish2',"^(> )*(�˵�|��|ˮ��|ľ��|��|��԰)����˵�������ɵĲ���",'','wuguanBack')
    SetTriggerOption("wuguanFinish1","group","wuguanFinish")
    SetTriggerOption("wuguanFinish2","group","wuguanFinish")
    EnableTriggerGroup("wuguanFinish",false)
    DeleteTriggerGroup("wuguanLit")
    create_trigger_t('wuguanLit1',"^(> )*�����˲�ԫ��ָ�����ƺ���Щ�ĵá�",'','wuguanLitXue')
    create_trigger_t('wuguanLit2',"^(> )*������ѧϰһ������Ҫ�ķ���",'','wuguanFind')
    create_trigger_t('wuguanLit3',"^(> )*(�����̫���ˣ����ʲôҲû��ѧ��|��û����ô��Ǳ����ѧϰ)",'','wuguanSleep')
    SetTriggerOption("wuguanLit1","group","wuguanLit")
    SetTriggerOption("wuguanLit2","group","wuguanLit")
    SetTriggerOption("wuguanLit3","group","wuguanLit")
    EnableTriggerGroup("wuguanLit",false)
    DeleteTriggerGroup("wuguanSleep")
    create_trigger_t('wuguanSleep1',"^(> )*��һ������",'','wuguanFood')
    SetTriggerOption("wuguanSleep1","group","wuguanSleep")
    EnableTriggerGroup("wuguanSleep",false)
    DeleteTriggerGroup("wuguanFind")
    create_trigger_t('wuguanFind1',"^>*\\s*��ݽ�ͷ\\(Wuguan jiaotou\\)",'','wuguanXueBasic')
    SetTriggerOption("wuguanFind1","group","wuguanFind")
    EnableTriggerGroup("wuguanFind",false)
	DeleteTriggerGroup("wuguanSmFind")
    create_trigger_t('wuguanSmFind1',"^>*\\s*���� ��������\\(Suanming xiansheng\\)",'','wuguanSmFollow')
    SetTriggerOption("wuguanSmFind1","group","wuguanSmFind")
    EnableTriggerGroup("wuguanSmFind",false)
	DeleteTriggerGroup("wuguanSmRm")
    create_trigger_t('wuguanSmRm1','(> )*��������(������|������|������ɤ�ӣ�|�е���ǿ��)˵��(\\D*)','','wuguanSmRm')
    SetTriggerOption("wuguanSmRm1","group","wuguanSmRm")
    EnableTriggerGroup("wuguanSmRm",false)
    DeleteTriggerGroup("wuguanXue")
    create_trigger_t('wuguanXue1',"^(> )*��������ݽ�ͷ��ָ",'','wuguanXuexi')
    create_trigger_t('wuguanXue2',"^(> )*��Ҫ��˭��̣�",'','wuguanSleep')
    SetTriggerOption("wuguanXue1","group","wuguanXue")
    SetTriggerOption("wuguanXue2","group","wuguanXue")
    EnableTriggerGroup("wuguanXue",false)
end
function wuguanNobody()
    EnableTriggerGroup("wuguanAsk",false)
    wuguan()
end
function wuguan()
    wuguanTrigger()
    job.name='wuguan'
    job.time.b=os.time()
	locate()
    exe('answer n')
    checkWait(wuguanGo,2)
end
function wuguanGo()
    --go(wuguanStart,"���","��ݴ���")
	local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   checkWait(wuguanStart,2)
	else
	   exe(locl.dir)
	   checkWait(wuguan,2)
	end
end
function wuguanStart()
    EnableTriggerGroup("wuguanAsk",true)
    exe('ask lu kun about job')
end
function wuguanBusy()
    EnableTriggerGroup("wuguanAccept",false)
    checkWait(wuguan,5)
end
function wuguanAsk()
    EnableTriggerGroup("wuguanAsk",false)
    EnableTriggerGroup("wuguanAccept",true)
end
function wuguanTool()
    EnableTriggerGroup("wuguanAccept",false)
	flag.idle = 0
    return check_halt(wuguanToolAsk)
end
function wuguanToolAsk()
    EnableTriggerGroup("wuguanTool",true)
    exe('se;ask wu about tools')
    return checkWait(wuguanToolUnwield,3)
end
function wuguanToolUnwield()
    exe('unwield piao;unwield chu tou;unwield chai dao;unwield shui tong;unwield ju zi;unwield sao zhou')
    exe('wield all')
end
function wuguanToolConsider(n,l,w)
    EnableTriggerGroup("wuguanTool",false)
    if w[4]=="��ͷ" then
       return check_halt(wuguanChucao)
    elseif w[4]=="��" then
       return check_halt(wuguanPichai)
    elseif w[4]=="ˮͰ" then
       return check_halt(wuguanTiaoshui)
    elseif w[4]=="����" then
       return check_halt(wuguanJumutou)
    elseif w[4]=="ư" then
       return check_halt(wuguanJiaoshui)
    elseif w[4]=="ɨ��" then
       return check_halt(wuguanSaomafang)
    end
end
function wuguanChucao()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield chu tou')
    exe('nw;wd;w;#3n')
    wgAct="chu ��"
    exe(wgAct)
end
function wuguanPichai()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield chai dao')
    exe('nw;wd;w;#2n;w')
    wgAct="pi ��"
    exe(wgAct)
end
function wuguanTiaoshui()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield shui tong')
    exe('nw;wd;w;#2s;e')
    wgAct="tiao ˮ"
    exe(wgAct)
end
function wuguanJumutou()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield ju zi')
    exe('nw;wd;w;#2s;w')
    wgAct="ju ľͷ"
    exe(wgAct)
end
function wuguanJiaoshui()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield piao')
    exe('nw;wd;w;#2n;e')
    wgAct="jiao ˮ"
    exe(wgAct)
end
function wuguanSaomafang()
    EnableTriggerGroup("wuguanWork",true)
    exe('wield sao zhou')
    exe('nw;wd;w;#2s;s')
    wgAct="sao ��"
    exe(wgAct)
end
function wuguanGoon()
    exe('hp')
    check_halt(wuguanCheck)
end
function wuguanCheck()
    if hp.jingli>30 then
       exe(wgAct)
    else
       checkWait(wuguanGoon,3)
    end
end
function wuguanBack()
    EnableTriggerGroup("wuguanWork",false)
    --go(wuguanFinish,"���","��Ʒ��")
	locate()
	return checkWait(wuguanBackGo,2)
end
function wuguanBackGo()
    local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe("se")
	   checkWait(wuguanFinish,2)
	else
	   exe(locl.dir)
	   checkWait(wuguanBack,2)
	end
end
function wuguanFinish()
    EnableTriggerGroup("wuguanFinish",true)
    exe('give wu all')
    exe('nw;task ok')
end
function wgSuanming()
    checkBags()
	return checkWait(wuguanSmFind,3)
end
function wuguanSmFind()    
    flag.times=1
	flag.find =0
    --go(wuguanSmFindAct,"���","���ǰԺ")
	locate()
	return checkWait(wuguanSmFindGo)
end
function wuguanSmFindGo()
    local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe("sd")
	   return checkWait(wuguanSmFindAct,2)
	else
	   exe(locl.dir)
	   return checkWait(wuguanSmFind,2)
	end
end
function wuguanSmFindAct()
    EnableTriggerGroup("wuguanSmFind",true)
    exe('look')
	road.id = "wuguan/dayuan"
    return find()
end
function wuguanSmFollow()
    flag.find=1
    dis_all()
    exe('follow suanming xiansheng;hp')
	locate()
    return check_halt(wuguanSmGive)
end
function wuguanSmGive()
    if not locl.id["��������"] then
	    return checkWait(wgSuanming,2)
	end
    EnableTriggerGroup("wuguanSmRm",true)
	local logfile = GetInfo(59) .. "/log/"..score.id .."ˢ��ò-"..os.time() .. ".txt"
	OpenLog (logfile , false)
	if Bag["ͭǮ"] then 
	    return exe("give 1 coin to suanming xiansheng")
	end
	if Bag["����"] and Bag["����"].cnt>1 then
	    return exe("give 1 silver to suanming xiansheng")
    end	
end
function wuguanSmRm(n,l,w)
    EnableTriggerGroup("wuguanSmRm",false)
	exe("follow none")
	--CloseLog()
	if string.find(w[3],"ò���˰����������ǣ��������") or string.find(w[3],"�������㣬�߻�����") then
	    wgRm = true
		CloseLog()
		return checkWait(wuguanGo,2)
	else
	    return checkWait(wuguanSf,2)
	end
end
function wuguanLit()
    EnableTriggerGroup("wuguanFinish",false)
	if not wgRm then
	    return wgSuanming()
	end
    exe('ed;e;n')
    if not skills["literate"] or (skills["literate"] and skills["literate"].lvl<20) then
       EnableTriggerGroup("wuguanLit",true)
       exe('xue bo literate')
    elseif hp.pot>50 then
       return wuguanFind()
    else
       return wuguanLitBack()
    end
end
function wuguanLitXue()
    checkWait(wuguanLitGoon,0.2)
end
function wuguanLitGoon()
    exe('xue bo literate')
end
function wuguanLitBack()
    EnableTriggerGroup("wuguanLit",false)
    EnableTriggerGroup("wuguanSleep",true)
    exe('s;e')
    if score.gender=="��" then
       exe('n')
    else
       exe('s')
    end
    exe('sleep')
end
function wuguanFood()
    EnableTriggerGroup("wuguanSleep",false)
    exe('cha')
    if score.gender=="��" then
       exe('s')
    else
       exe('n')
    end
	exe("hp")
    exe('w;w;wu;wd;w;w')
    exe('ask wang about ʳ��')
    check_halt(wuguanEat)
end
function wuguanEat()
    exe('get rice;#3(eat rice);#2(drop rice)')
    exe('ask wang about ˮ')
    return check_halt(wuguanDrink,1)
end
function wuguanDrink()
    exe('get tea;#3(drink tea);#2(drop tea)')
	if hp.exp < 3000 then
       return wuguan()
	else
	   --return wuguanOut()
	   return wuguanSzj()
	end
end
function wuguanFind()
    
    flag.times=1
	flag.find =0
    --go(wuguanFindAct,"���","���ǰԺ")
	locate()
	checkWait(wuguanFindGo)
end
function wuguanFindGo()
    local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe("sd")
	   checkWait(wuguanFindAct,2)
	else
	   exe(locl.dir)
	   checkWait(wuguanFind,2)
	end
end
function wuguanFindAct()
    EnableTriggerGroup("wuguanFind",true)
    exe('look')
	road.id = "wuguan/dayuan"
    find()
end
function wuguanXueBasic()
    flag.find=1
    dis_all()
    exe('follow jiaotou;hp')
	locate()
    check_halt(wuguanXueCheck)
end
function wuguanXueCheck()
    if not locl.id["��ݽ�ͷ"] then
	   return wuguanSleep()
	end
    EnableTriggerGroup("wuguanXue",true)
    if hp.jingxue>30 and hp.pot>50 then
       exe('xue jiaotou force')
    else
       return wuguanSleep()
    end
end
function wuguanXuexi()
    EnableTriggerGroup("wuguanXue",false)
    exe('hp')
	locate()
    checkWait(wuguanXueCheck,2)
end
function wuguanSleep()
    exe('follow none')
	locate()
    checkWait(wuguanSleepGo,2)
end
function wuguanSleepGo()
	local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe('ed;e;n')
	   checkWait(wuguanLitBack,2)
	else
	   exe(locl.dir)
	   checkWait(wuguanSleep,2)
	end
end
function wuguanOut()
    EnableTriggerGroup("wuguanAccept",false)
    locate()
	return checkWait(wuguanOutGo,2)
end
function wuguanOutGo()
    local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe("enter;n;n")
	   checkWait(wuguanOutAct,2)
	else
	   exe(locl.dir)
	   checkWait(wuguanOut,2)
	end
end
function wuguanOutAct()
    exe('ask wan zhenshan about ���')
	return check_halt(wuguanOutSun)
end
function wuguanOutSun()
    exe("s;s;out;sd;s;s")
	exe('ask sun jun about ���')
	return check_halt(wuguanOutVip)
end
function wuguanOutVip()
    exe("eat wan")
	exe("credit vip")
	return checkWait(wuguanDang,3)
end
function wuguanDang()
    exe('out;s;#10e;#3s')
	locate()
	return checkWait(wuguanDangDui,5)
end
function wuguanDangDui()
    DeleteTriggerGroup("wuguanDui")
    create_trigger_t('wuguanDui1',"^(> )*�Բ��������е�ͨ�������һ������˲�",'','wuguanTb')
    create_trigger_t('wuguanDui2',"^(> )*�㵱ǰ�Ĵ���ֵΪ:(\\d*)$",'','wuguanCp')
    SetTriggerOption("wuguanDui1","group","wuguanDui")
    SetTriggerOption("wuguanDui2","group","wuguanDui")
    EnableTriggerGroup("wuguanDui",true)
    exe('duihuan tianlong;read book')
    local logfile = GetInfo(59) .. "/log/"..score.id .."ˢ����-"..os.time() .. ".txt"
	OpenLog (logfile , false)	
end
function wuguanTb()
    return checkWait(wuguanSf,3)
end
function wuguanSf()
    wgRm = false
    idle()
	skills = {}
    exe('n;suicide -f')
	--scrLog()
	CloseLog()
	exe(GetVariable("passwd"))
	wait.make(function()
	    wait.time(20)
        Connect()
	end)
end
function wuguanCp(n,l,w)
    local l_cp = tonumber(w[2])
	if l_cp == 30 then
	    return check_halt(wuguanCompleted,1)
	else
	    return checkWait(wuguanDangDui,3)
	end
end
function wuguanCompleted()
	exe('jifa all')
	exe("save")
	exe("nick cp 30")
    CloseLog()
	disAll()
	Disconnect()
    --return check_heal()   
end
function wuguanSzj()
    locate()
	return checkWait(wuguanSzjGo,2)
end
function wuguanSzjGo()
    local l_path = wuguanRoad(locl.where)
	if l_path then
	   exe(l_path)
	   exe("ed;#5e;s")
	   locate()
	   return checkWait(wuguanSzjLoc,2)
	else
	   exe(locl.dir)
	   return checkWait(wuguanSzj,2)
	end
end
function wuguanSzjLoc()
    if locl.room~="��ɽ" then
	   return wuguanSzj()
	end
	exe("zuan feng")
	exe("hp")
	locate()
	return checkWait(wuguanSzjChk,5)
end
function wuguanSzjChk()
    if hp.jingxue < 95 then
	   exe("hp")
	   return checkWait(wuguanSzjChk,5)
	end
	exe('move shi;enter')
	locate()
	exe("hp;cha")
	return checkWait(wuguanSzjLw,3)
end
function wuguanSzjLw()
    flag.idle = 0
    if locl.room~="����" then
	    if locl.room=="��ɽ" then
	        if not locl.exit["north"] and not locl.exit["south"] then
		        return checkWait(wuguanSzjChk,5)
            else
		        return checkWait(wuguanSzjLoc,5)
            end		  
	    else
	        return checkWait(wuguanSzj,2)
	    end
	end
	if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl > 4 then
	    return checkWait(wuguanSzjBack,2)
	end
	if hp.jingxue < 20 then
	    exe("hp")
	    return checkWait(wuguanSzjLw,5)
	end
	if (hp.food < 10 or hp.water < 10) and skills["shenzhao-jing"] then
	    exe("hp")
	    return checkWait(wuguanSzjBack,5)
	end
	if hp.pot == 0 then
	    if not skills["shenzhao-jing"] or skills["shenzhao-jing"].lvl < 5 then
	        exe("hp")
	        return checkWait(wuguanSzjLw,5)
	    else
	        return checkWait(wuguanSzjBack,5)
	    end
	end
	return checkWait(wuguanSzjFh,2)
end
function wuguanSzjFh()
    exe("lingwu fuhao")
	exe("hp;cha")
	return checkWait(wuguanSzjLw,2)
end
function wuguanSzjBack()
    exe("out;zuan feng")
	return check_halt(wuguanSzjOver,1)
end
function wuguanSzjOver()
    exe("n")
	return wuguanOut()
end