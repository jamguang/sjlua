quests = quests or {}
quests["lengquan"] = {}
quests["lengquan"].auto = 0
quests["lengquan"].name = '冷泉神功'

questTongji = questTongji or {}
questTongji["lengquan"] = "lengquanTongji"

questCal = questCal or {}
questCal["lengquan"] = "lengquanCal"

questList = questList or {}
questList["lengquan"] = function() if canwu and canwu.gift and canwu.gift>19 then return quests["lengquan"].name else return false end end


function lengquanCal()
    if GetVariable("autolengquan") and Bag["火折"] and quests["fox"] and quests["fox"]["lengquan"] then
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
    if GetVariable("autolengquan") and Bag["火折"] and quests["fox"] and quests["fox"]["lengquan"]  and quests["lengquan"] and quests["lengquan"].auto == 1 and quests["lengquan"].time then
	   local l_time = 24*60*60 - (os.time() - quests["lengquan"].time)
	   checkQuestNote(quests["lengquan"].name,l_time)
	end
end

function questlengquan()
    if not Bag["绳子"] then
        return go(lengquanSz,"华山","寝室")
	end
	if not Bag["火折"] then
	    return go(lengquanFire,randomElement(drugBuy["火折"]))
	end
	if not Bag["冷月宝刀"] then
	    return go(lengquanBlade,"huanghe/fendi")
	end
end
function lengquanSz()
    if locl.id["绳子"] then
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
    if locl.room ~= "墓地" then
	    return go(lengquanBlade,"huanghe/fendi")
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*(你看准了墓后三尺之处，运劲于指，伸手挖土。|你挖了半天，只弄了一手泥。)",'','lengquanWa')
    create_trigger_t('lengquan2',"^(> )*你抓住刀柄轻轻把单刀从土中抽出，刀刃抽出寸许，毫无生锈。",'','lengquanBz')
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
    if locl.room ~= "正厅" then
	    return lengquanBz()
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*苗人凤交给你一张宝藏图。",'','lengquanGuan')
    create_trigger_t('lengquan2',"^(> )*苗人凤说道：「这样吧，你还是抓紧时间练功去吧，过一会再来问吧，我这就找找看。」",'','lengquanFail')
	create_trigger_t('lengquan3',"^(> )*苗人凤说道：「(刚才还在这里啊。我再找找看。|宝藏图在哪里呢。)",'','lengquanBz')
    SetTriggerOption("lengquan1","group","lengquan")
    SetTriggerOption("lengquan2","group","lengquan")
	SetTriggerOption("lengquan3","group","lengquan")
    exe("askk miao renfeng about 宝藏")
end
function lengquanGuan()
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*只是，你感到有些内力不适，怕是这次灌注已经大伤你的内功修为。",'','lengquanGuanzhu')
    create_trigger_t('lengquan2',"^(> )*你已经灌注了内力，刀身上的脉路更加清晰！",'','lengquanYan')
    create_trigger_t('lengquan3',"^(> )*你将冷月宝刀翻来覆去地研究着！",'','lengquanYan')
    create_trigger_t('lengquan4',"^(> )*你发现冷月宝刀刀身上刻有着数条脉路，似乎和藏宝图可以对照。",'','lengquanDui')
    create_trigger_t('lengquan5',"^(> )*你突然发现两者结合最终的标志竟然落在一个你曾经熟悉的地方——(\\D*)。",'','lengquanAdd')
    create_trigger_t('lengquan6',"^(> )*你已经发现刀身上的脉路，你可以尝试对照藏宝图！",'','lengquanDui')
    create_trigger_t('lengquan7',"^(> )*你感觉全身气血翻腾，看来刚才的研究已经大伤你的精神！",'','lengquanFail')
	create_trigger_t('lengquan8',"^(> )*地图已经什么都看不出来了！",'','lengquanQuit')
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
    Note("宝藏地址："..job.where)
   	wait.make(function()
	    wait.time(2)
        exe("jump")
	    wait.time(2)
        return lengquanSearchGo()   
	end)
end
function lengquanSearchGo()
    checkBags()
    if job.where=="青城" then
        return go(lengquanSearch,"lanzhou/qingcheng")  
    elseif job.where=="兰州土门子" then
        return go(lengquanSearch,"lanzhou/tumenzi")  
    elseif job.where=="五佛寺" then
        return go(lengquanSearch,"lanzhou/wufosi") 
    elseif job.where=="草海" then
        return go(lengquanSearch,"hj/caoyuan1") 
    elseif job.where=="昆仑小溪" then
        return go(lengquanSearch,"fairyland/shanxi") 
    elseif job.where=="古长城" then
        return go(lengquanSearch,"lanzhou/gccheng")   
    end
end
function lengquanSearch()
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*你绕着\\D*走来走去，仔细观察着什么！",'','lengquanSearchAgain')
    create_trigger_t('lengquan2',"^(> )*你似乎发现\\D*一些什么特别的地方，绕着\\D*走来走去！",'','lengquanSearchAgain')
    create_trigger_t('lengquan3',"^(> )*你(已经发现找到藏宝地址了！|意外地发现一个可以通向地下的通道。)",'','lengquanRoad')
    create_trigger_t('lengquan4',"^(> )*突然从角落里跳出一个人，(\\D*)对着你嚷道：“我就是黑风寨。”",'','lengquanKiller')
    create_trigger_t('lengquan5',"^(> )*(\\D*)「啪」的一声倒在地上，挣扎着抽动了几下就死了。",'','lengquanDie')
	create_trigger_t('lengquan6',"^(> )*跟着又出来一个人，竟然是黑风寨二当家(\\D*)，嚷道：",'','lengquanKiller')
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
    create_trigger_t('lengquan1',"^(> )*你又暗里推算一番，原来如此：东行(\\D*)步，西行(\\D*)，北折(\\D*)，南回(\\D*)即可！",'','lengquanStep')
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
	if locl.room ~= "书房" then
	    return checkWait(lengquanUsefire,5)
	end
    job.progress=0
    flag.idle=-5
	tmp.mishi = tmp.mishi or {}
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*你按照纸团上的这些线线运行全身经脉，发现全无用处，更别说提高武功了。",'','lengquanRead')
    create_trigger_t('lengquan2',"^(> )*你突然发现这线线代表的不是武功秘籍，却是一个藏宝的地点。",'','lengquanSucc0')
    create_trigger_t('lengquan3',"^(> )*你已经明了冷泉神功的修炼方法。",'','lengquanSucc')
    create_trigger_t('lengquan4',"^(> )*"..score.name.."按照纸团提示的方位，并没有发现秘籍，但却发现一块",'','lengquanSucc1')
    create_trigger_t('lengquan5',"^(> )*你打开\\D*竟然发现里面有一张纸团。",'','lengquanReadB')
    create_trigger_t('lengquan6',"^(> )*你刚放进嘴里一咬，只听“咯嘣”一声，咬碎一颗牙齿！",'','lengquanGetYu')
	create_trigger_t('lengquan7',"^(> )*你转了转地上的花盆。",'','lengquanMsMove')
	create_trigger_t('lengquan8',"^(> )*你用力将绑好的桌子全部推到角落的一边。",'','lengquanMsTui')
	create_trigger_t('lengquan9',"^(> )*你感觉墓道似乎有崩塌的迹象，看来要抓紧时间寻宝了。",'','lengquanZhi')
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
    if locl.room == "书房" then
	    return lengquanGetBook()
	end
	--checkBags()
	if Bag["纸团"] then
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
	questSucLog("冷泉神功之纸团")
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
	if locl.room=="密室" then
	    return checkWait(lengquanGoShu,2)
	end
	if locl.room~="书房" then
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
	questSucLog("冷泉神功之玉佩")
	return go(lengquanMiao,"lanzhou/zhenting")
end
function lengquanMiao()
    if locl.room ~= "正厅" then
	    return go(lengquanMiao,"lanzhou/zhenting")
	end
    EnableTriggerGroup("lengquan",false)
    DeleteTriggerGroup("lengquan")
    create_trigger_t('lengquan1',"^(> )*对我有多次大恩。也罢，这门神功也传给你吧。",'','lengquanSucc')
    SetTriggerOption("lengquan1","group","lengquan")
	exe("give yu pei to miao")
	return check_bei(lengquanShengong,1)
end
function lengquanShengong()
    exe("askk miao renfeng about 冷泉神功")   
end

function lengquanContinue()
    EnableTriggerGroup("lengquan",false)
	dis_all()
	exe("drop ka;drop baodao;out;w;up")
	Note("需要quit 一次")
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