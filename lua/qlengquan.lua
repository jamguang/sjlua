quests = quests or {}
quests["lengquan"] = {}
quests["lengquan"].auto = 0
quests["lengquan"].name = '��Ȫ��'

questTongji = questTongji or {}
questTongji["lengquan"] = "lengquanTongji"

questCal = questCal or {}
questCal["lengquan"] = "lengquanCal"

questList = questList or {}
questList["lengquan"] = function() if canwu and canwu.gift and canwu.gift>19 then return quests["lengquan"].name else return false end end


function lengquanCal()
    if GetVariable("autolengquan") and Bag["����"] and quests["fox"] and quests["fox"]["lengquan"] then
        if GetVariable("timelengquan") then
		    quests["lengquan"].time = tonumber(GetVariable("timelengquan"))
	    end
	    if GetVariable("autolengquan") then
		    quests["lengquan"].auto=tonumber(GetVariable("autolengquan"))
	    end
	    if quests["lengquan"].time==nil or os.time()-quests["lengquan"].time > 24*60*60 then
	        quests["lengquan"].time = os.time() - 22*60*60
		    SetVariable("timelengquan",quests["lengquan"].time)
	        if quests["lengquan"].auto==nil or quests["lengquan"].auto == 0 then
	            quests["lengquan"].auto = 1
	        end
	        if quests["lengquan"].auto == 1 then
		        exe('pray pearl')
		        return "questlengquan"
	        end
	    else
	        if quests["lengquan"].auto == 1 and quests["lengquan"].time then
	            local l_time = 24*60*60 - (os.time() - quests["lengquan"].time)
		  	    if l_time < 0 or l_time * math.random() < 1800 then
		  	        checkQuestNote(quests["lengquan"].name,l_time)
		  	    end
	        end
	        return false
	    end
    end
end
function lengquanTongji()
    if GetVariable("autolengquan") and Bag["����"] and quests["fox"] and quests["fox"]["lengquan"]  and quests["lengquan"] and quests["lengquan"].auto == 1 and quests["lengquan"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lengquan"].time)
	   checkQuestNote(quests["lengquan"].name,l_time)
	end
end

function questlengquan()
    if not Bag["����"] then
        return go(lengquanSz,"��ɽ","����")
	end
	if not Bag["����"] then
	    return go(lengquanFire,randomElement(drugBuy["����"]))
	end
	if not Bag["���±���"] then
	    return go(lengquanBlade,"huanghe/fendi")
	end
end
function lengquanSz()
    if locl.id["����"] then
        exe('get sheng zi')
		checkBags()
	    return check_bei(questlengquan,1)
	else
	    return check_bei(lengquanNoItem,1)
    end
end
function lengquanFire()
    exe('buy fire')
	checkBags()
	return check_bei(questlengquan,1)
end
function lengquanBlade()
    if locl.room ~= "Ĺ��" then
	    return go(lengquanBlade,"huanghe/fendi")
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*(�㿴׼��Ĺ������֮�����˾���ָ������������|�����˰��죬ֻŪ��һ���ࡣ)",'','lengquanWa')
    create_trigger_t('lengquan2',"^(> )*��ץס��������ѵ��������г�������г�������������⡣",'','lengquanBz')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")--
    exe("wa di")
    tmp.wa = 0    
end
function lengquanWa()
    tmp.wa = tmp.wa or 0
	tmp.wa = tmp.wa + 1
    if tmp.wa > 30 then
	    EnableTriggerGroup("lengquan",false)
	    return lengquanNoItem()
	end
	wait.make(function()
	    wait.time(0.5)
        exe("yun jingli;wa di")
	end)
    
end
function lengquanBz()
    EnableTriggerGroup("lengquan",false)
	return go(lengquanBzAsk,"lanzhou/zhenting")
end
function lengquanBzAsk()
    if locl.room ~= "����" then
	    return lengquanBz()
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*���˷ｻ����һ�ű���ͼ��",'','lengquanGuan')
    create_trigger_t('lengquan2',"^(> )*���˷�˵�����������ɣ��㻹��ץ��ʱ������ȥ�ɣ���һ�������ʰɣ���������ҿ�����",'','lengquanFail')
	create_trigger_t('lengquan3',"^(> )*���˷�˵������(�ղŻ������ﰡ���������ҿ���|����ͼ�������ء�)",'','lengquanBz')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")
	SetTriggerOption("lengquan3","group","lengquan")
    exe("askk miao renfeng about ����")
end
function lengquanGuan()
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*ֻ�ǣ���е���Щ�������ʣ�������ι�ע�Ѿ���������ڹ���Ϊ��",'','lengquanGuanzhu')
    create_trigger_t('lengquan2',"^(> )*���Ѿ���ע�������������ϵ���·����������",'','lengquanYan')
    create_trigger_t('lengquan3',"^(> )*�㽫���±���������ȥ���о��ţ�",'','lengquanYan')
    create_trigger_t('lengquan4',"^(> )*�㷢�����±��������Ͽ�����������·���ƺ��Ͳر�ͼ���Զ��ա�",'','lengquanDui')
    create_trigger_t('lengquan5',"^(> )*��ͻȻ�������߽�����յı�־��Ȼ����һ����������Ϥ�ĵط�����(\\D*)��",'','lengquanAdd')
    create_trigger_t('lengquan6',"^(> )*���Ѿ����ֵ����ϵ���·������Գ��Զ��ղر�ͼ��",'','lengquanDui')
    create_trigger_t('lengquan7',"^(> )*��о�ȫ����Ѫ���ڣ������ղŵ��о��Ѿ�������ľ���",'','lengquanFail')
	create_trigger_t('lengquan8',"^(> )*��ͼ�Ѿ�ʲô�����������ˣ�",'','lengquanQuit')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")
    SetTriggerOption("lengquan3","group","lengquan")--
    SetTriggerOption("lengquan4","group","lengquan")
    SetTriggerOption("lengquan5","group","lengquan")
    SetTriggerOption("lengquan6","group","lengquan")
    SetTriggerOption("lengquan7","group","lengquan")
	SetTriggerOption("lengquan8","group","lengquan")
    wait.make(function()
	    wait.time(3)
        exe("guanzhu baodao")
	end)
end
function lengquanGuanzhu()
    return check_busy(lengquanGuandao,1)
end
function lengquanGuandao()
    return exe("guanzhu baodao")    
end
function lengquanYan()
    wait.make(function()
        wait.time(2)
        exe("yanjiu baodao")
    end)
end
function lengquanDui()
    wait.make(function()
	    wait.time(2)
        exe("duizhao baodao")
	end)
end
function lengquanAdd(n,l,w)
    EnableTriggerGroup("lengquan",false)
    job.where=w[2]
    Note("���ص�ַ��"..job.where)
   	wait.make(function()
	    wait.time(2)
        exe("jump")
	    wait.time(2)
        return lengquanSearchGo()   
	end)
end
function lengquanSearchGo()
    checkBags()
    if job.where=="���" then
        return go(lengquanSearch,"lanzhou/qingcheng")  
    elseif job.where=="����������" then
        return go(lengquanSearch,"lanzhou/tumenzi")  
    elseif job.where=="�����" then
        return go(lengquanSearch,"lanzhou/wufosi") 
    elseif job.where=="�ݺ�" then
        return go(lengquanSearch,"hj/caoyuan1") 
    elseif job.where=="����СϪ" then
        return go(lengquanSearch,"fairyland/shanxi") 
    elseif job.where=="�ų���" then
        return go(lengquanSearch,"lanzhou/gccheng")   
    end
end
function lengquanSearch()
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*������\\D*������ȥ����ϸ�۲���ʲô��",'','lengquanSearchAgain')
    create_trigger_t('lengquan2',"^(> )*���ƺ�����\\D*һЩʲô�ر�ĵط�������\\D*������ȥ��",'','lengquanSearchAgain')
    create_trigger_t('lengquan3',"^(> )*��(�Ѿ������ҵ��ر���ַ�ˣ�|����ط���һ������ͨ����µ�ͨ����)",'','lengquanRoad')
    create_trigger_t('lengquan4',"^(> )*ͻȻ�ӽ���������һ���ˣ�(\\D*)�������µ������Ҿ��Ǻڷ�կ����",'','lengquanKiller')
    create_trigger_t('lengquan5',"^(> )*(\\D*)��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�",'','lengquanDie')
	create_trigger_t('lengquan6',"^(> )*�����ֳ���һ���ˣ���Ȼ�Ǻڷ�կ������(\\D*)���µ���",'','lengquanKiller')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")
    SetTriggerOption("lengquan3","group","lengquan")
    SetTriggerOption("lengquan4","group","lengquan")
    SetTriggerOption("lengquan5","group","lengquan")
	SetTriggerOption("lengquan6","group","lengquan")
    
	weapon_unwield()
    weapon_wield()
	exe("set wimpy 100")
    exe("search")
	job.killer = {}
end   
function lengquanDie(n,l,w)
    local npcname=w[2]
    --if npcname==job.target then
    --    return check_busy(lengquanSearchAgain,2)	    
    --end
    job.killer = job.killer or {}
	if job.killer[npcname] then
	    job.killer[npcname] = nil
	end
	if countTab(job.killer)==0 then
	    return check_busy(lengquanSearchAgain,2)
	end
end
function lengquanKiller(n,l,w)
    disWait()
    --job.target=w[2]
	job.killer[w[2]] = true
end
function lengquanSearchAgain()
    job.killer = job.killer or {}
	if countTab(job.killer)==0 then
        return check_bei(lengquanSearchDo)
	end
end
function lengquanSearchDo()
    flag.idle=0
    exe("yun jingli;yun qi;search")
end
function lengquanRoad()
    EnableTriggerGroup("lengquan",false)
    return check_bei(lengquanDown)
end
function lengquanDown()
    EnableTriggerGroup("lengquan",false)
	exe("down;e")
	return check_bei(lengquanUsefire,1)
end
function lengquanUsefire()
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*���ְ�������һ����ԭ����ˣ�����(\\D*)��������(\\D*)������(\\D*)���ϻ�(\\D*)���ɣ�",'','lengquanStep')
    SetTriggerOption("lengquan1","group","lengquan")
	questStartLog(quests["lengquan"].name)
    exe("use fire")
end
function lengquanStep(n,l,w)
    EnableTriggerGroup("lengquan",false)
    local step_e = tonumber(trans(w[2]))
    local step_w = tonumber(trans(w[3]))
    local step_n = tonumber(trans(w[4]))
    local step_s = tonumber(trans(w[5]))
    Note("#"..step_e.."(e)"..";#"..step_w.."(w)"..";#"..step_n.."(n)"..";#"..step_s.."(s)" )
    exe("#"..step_e.."(e)" )
    exe("#"..step_w.."(w)" )
    exe("#"..step_n.."(n)" )
    wait.make(function()
	    wait.time(2)
        exe("#"..step_s.."(s)" )
		wait.time(2)
        locate()		
        return check_bei(lengquanGetBook,1) 
    end) 
end
function lengquanMsMove()
    tmp.mishi = tmp.mishi or {}
	tmp.mishi["move"] = true
end
function lengquanMsTui()
    tmp.mishi = tmp.mishi or {}
	tmp.mishi["tui"] = true
end
function lengquanGetBook()
    EnableTriggerGroup("lengquan",false)
	if locl.room ~= "�鷿" then
	    return checkWait(lengquanUsefire,5)
	end
    job.progress=0
    flag.idle=-5
	tmp.mishi = tmp.mishi or {}
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*�㰴��ֽ���ϵ���Щ��������ȫ����������ȫ���ô�������˵����书�ˡ�",'','lengquanRead')
    create_trigger_t('lengquan2',"^(> )*��ͻȻ���������ߴ���Ĳ����书�ؼ���ȴ��һ���ر��ĵص㡣",'','lengquanSucc0')
    create_trigger_t('lengquan3',"^(> )*���Ѿ�������Ȫ�񹦵�����������",'','lengquanSucc')
    create_trigger_t('lengquan4',"^(> )*"..score.name.."����ֽ����ʾ�ķ�λ����û�з����ؼ�����ȴ����һ��",'','lengquanSucc1')
    create_trigger_t('lengquan5',"^(> )*���\\D*��Ȼ����������һ��ֽ�š�",'','lengquanReadB')
    create_trigger_t('lengquan6',"^(> )*��շŽ�����һҧ��ֻ�������ԡ�һ����ҧ��һ�����ݣ�",'','lengquanGetYu')
	create_trigger_t('lengquan7',"^(> )*��ת��ת���ϵĻ��衣",'','lengquanMsMove')
	create_trigger_t('lengquan8',"^(> )*����������õ�����ȫ���Ƶ������һ�ߡ�",'','lengquanMsTui')
	create_trigger_t('lengquan9',"^(> )*��о�Ĺ���ƺ��б����ļ��󣬿���Ҫץ��ʱ��Ѱ���ˡ�",'','lengquanZhi')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")
    SetTriggerOption("lengquan3","group","lengquan")
    SetTriggerOption("lengquan4","group","lengquan")
    SetTriggerOption("lengquan5","group","lengquan")
    SetTriggerOption("lengquan6","group","lengquan")
	SetTriggerOption("lengquan7","group","lengquan")
	SetTriggerOption("lengquan8","group","lengquan")
	SetTriggerOption("lengquan9","group","lengquan")
    Note("move hua pen;#wa 3000;tui zhuozi;#wa 3000;tui anmen")
    wait.make(function()
	    
	    wait.time(2)
		if not tmp.mishi["move"] then
            exe("move hua pen")
		end
		
        wait.time(2)
        exe("bang zhuozi")

        wait.time(2)
		if not tmp.mishi["tui"] then
            exe("tui zhuozi")
		end
		
        wait.time(2)
        exe("tui anmen")
		
        wait.time(2)
        exe("search")
		
        wait.time(3)
        exe("search")
		
        wait.time(3)
        exe("search")		
		
		wait.time(2)
        checkBags()
        locate()
		
		wait.time(2)
		lengquanMishi()
	end)
end
function lengquanMishi()
    if locl.room == "�鷿" then
	    return lengquanGetBook()
	end
	--checkBags()
	if Bag["ֽ��"] then
	    exe("yanjiu zhituan")
	end
end
function lengquanGetYu()
    job.progress=8
end
function lengquanZhi()
    if not tmp.zhituan or tmp.zhituan<2 then
	    exe("search")
		checkBags()
	end
end
function lengquanReadB()
    tmp.zhituan = tmp.zhituan or 0
	tmp.zhituan = tmp.zhituan + 1
    --return check_bei(lengquanReadC)
	create_timer_s('lengquan',2,'lengquanReadC')
end
function lengquanRead()
    EnableTimer('lengquan',false)
	DeleteTimer("lengquan")
    job.progress=job.progress+1
    if job.progress<2 then
        wait.make(function()
		    wait.time(3)
            exe("search")
	        wait.time(3)
            exe("search")
            wait.time(3)
			checkBags()
            --exe("eat dan;eat wan;eat dan;eat wan;fu wan;fu dan")
            --return check_bei(lengquanReadC,1)
        end)  
    else   
        return check_bei(lengquanContinue,1)
    end
   
end
function lengquanReadC()
    exe("yanjiu zhituan")
end

function lengquanSucc0()
    dis_all()
	questSucLog("��Ȫ��ֽ֮��")
	--return check_bei(lengquanShuku)
	return check_bei(lengquanGoShu)
end
function lengquanGoShu()
    exe("drop ka;drop baodao")
	checkBags()
	exe("out")
	locate()
	return check_bei(lengquanShuku,1)
end
function lengquanShuku()
    --exe("out")
	if locl.room=="����" then
	    return checkWait(lengquanGoShu,2)
	end
	if locl.room~="�鷿" then
	    return lengquanOver()
	end
    exe("search")
	checkBags()
	
	return checkWait(lengquanShukuYu,3)
end
function lengquanShukuYu()
    if isInBags("yu pei") then
	    return check_bei(lengquanSucc1,1)
	end
	exe("search")
	checkBags()
	return checkWait(lengquanShukuYu,3)
end
function lengquanSucc1()
    dis_all()
    EnableTriggerGroup("lengquan",false)
    exe("w;up")
	questSucLog("��Ȫ��֮����")
	return go(lengquanMiao,"lanzhou/zhenting")
end
function lengquanMiao()
    if locl.room ~= "����" then
	    return go(lengquanMiao,"lanzhou/zhenting")
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*�����ж�δ����Ҳ�գ�������Ҳ������ɡ�",'','lengquanSucc')
    SetTriggerOption("lengquan1","group","lengquan")
	exe("give yu pei to miao")
	return check_bei(lengquanShengong,1)
end
function lengquanShengong()
    exe("askk miao renfeng about ��Ȫ��")   
end

function lengquanContinue()
    EnableTriggerGroup("lengquan",false)
	dis_all()
	exe("drop ka;drop baodao;out;w;up")
	Note("��Ҫquit һ��")
	quests["lengquan"].time = os.time()
	quests["lengquan"].auto = 1
	SetVariable("timelengquan",quests["lengquan"].time)
	SetVariable("autolengquan",quests["lengquan"].auto)
	checkBags()
	return check_bei(lengquanOut0)
end
function lengquanQuit()
    EnableTriggerGroup("lengquan",false)
	dis_all()
	quests["lengquan"].time = os.time() - 23.8*60*60
	quests["lengquan"].auto = 1
	SetVariable("timelengquan",quests["lengquan"].time)
	SetVariable("autolengquan",quests["lengquan"].auto)
	checkBags()
	return check_bei(lengquanOut0)
end
function lengquanOut0()
    return check_busy(lengquanout)
end
function lengquanout()
    DeleteTriggerGroup("lengquan")
	exe("drop ka;drop baodao")
    CloseLog()
	return husongQuit()
end
function lengquanSucc()
    dis_all()
    EnableTriggerGroup("lengquan",false)
	quests["lengquan"].time = os.time()
	quests["lengquan"].auto = 2
	questSucLog(quests["lengquan"].name)
	return check_bei(lengquanOver)
end
function lengquanFail()
    dis_all()
    EnableTriggerGroup("lengquan",false)
	quests["lengquan"].time = os.time() - 20*60*60
	return check_bei(lengquanOver)
end
function lengquanNoItem()
    EnableTriggerGroup("lengquanAsk",false)
	quests["lengquan"].time = os.time() - 23*60*60
	return check_bei(lengquanOver)
end
function lengquanOver()
	SetVariable("timelengquan",quests["lengquan"].time)
	SetVariable("autolengquan",quests["lengquan"].auto)
	exe("drop ka;drop baodao")
	exe("out;w;up")
	DeleteTriggerGroup("lengquan")
	CloseLog()
    return check_bei(checkQuestOver)
end