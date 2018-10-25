--全真采药
jobSpecial = jobSpecial or {}
jobSpecial["caiyao"] = true 
job.list = job.list or {}
job.list["caiyao"] =function() if score.party and score.party=="全真教" and hp.exp<200000 then return "全真采药" else return false end end
joblast = joblast or {}
joblast["全真采药"]   = "caiyao"
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["caiyao"] = "caiyaoTriggerdel"

function caiyao()
    flag.idle=0				
	job.prossce=0
	i=0
    caiyaoTrigger()
    job.name="caiyao"
    job.time.b=os.time()
	if condition["任务繁忙状态"] and condition["任务繁忙状态"] > 10 then
	    return go(caiyaoDazuo,"全真","会真堂")
	end
    return check_busy(caiyaoGo)
end
function caiyaoGo()
	messageShow('全真采药：任务开始！')
    return go(caiyaoStart,"全真","大堂一进")      
end
function caiyaoStart() 
    return check_busy(caiyaoStart1)
end
function caiyaoStart1()
    EnableTriggerGroup("caiyaoask",true)
    return exe('ask lu about 采药')
end
function caiyaoBusy()
    EnableTriggerGroup("caiyaoAccept",false)
	messageShow('全真采药：忙碌中，打坐吧！')
	condition = {}
	exe("unset 积蓄")
	exe("cond")
	return go(caiyaoDazuo,"全真","会真堂")
end
function caiyaoDazuo()
    if not condition["任务繁忙状态"] or condition["任务繁忙状态"] == 0 then
	    exe("yun qi;yun jing;yun jingli")
	    return caiyaoGo()
	end
	condition = {}
	exe("unset 积蓄")
	exe("cond")
	if perform.force and skills[perform.force] and skills[perform.force].lvl>100 then
	    exe("yun qi")
	end
	if hp.neili_lim - hp.neili_max < 10 and hp.neili > hp.neili_max then
	    exe("yun jing;tuna "..hp.jingxue)
	else
	    exe("yun jing;dazuo "..hp.dazuo)
	end
	exe("hp")
	return check_bei(caiyaoDazuo,1)
end

function caiyaoTrigger()
    DeleteTriggerGroup("caiyaoask")
    create_trigger_t('caiyaoask1',"^(> )*你向鹿清笃打听有关『采药",'','caiyaoConsider')
    create_trigger_t('caiyaoask2',"^(> )*这里没有这个人。$",'','caiyaoNobody')
    SetTriggerOption("caiyaoask1","group","caiyaoask")    
	SetTriggerOption("caiyaoask2","group","caiyaoask")
    EnableTriggerGroup("caiyaoask",false)
    DeleteTriggerGroup("caiyaoAccept")
    create_trigger_t('caiyaoAccept1',"^(> )*鹿清笃对(你|"..score.name..")说道(\\D*)你来的正好",'','caiyaogo')
	create_trigger_t('caiyaoAccept2',"^(> )*鹿清笃(对你|)说道：「(\\D*)我不是安排你去采药去了么？是不是偷懒了",'','caiyaogo')
	create_trigger_t('caiyaoAccept3',"^(> )*鹿清笃(对你|)说道：「(\\D*)你正在工作忙碌中，待会再来",'','caiyaoBusy')
    SetTriggerOption("caiyaoAccept1","group","caiyaoAccept") 
	SetTriggerOption("caiyaoAccept2","group","caiyaoAccept") 
	SetTriggerOption("caiyaoAccept3","group","caiyaoAccept")
    EnableTriggerGroup("caiyaoAccept",false)
	DeleteTriggerGroup("caiyaoChutou")
    create_trigger_t('caiyaoChutou1',"^(> )*孙铁匠给了你一把挖药专用的药锄",'','caiyaoChutou2')
	create_trigger_t('caiyaoChutou3',"^(> )*孙铁匠说道：「你不是有了吗，还想要什麽？」",'','caiyaoChutou2')
    SetTriggerOption("caiyaoChutou1","group","caiyaoChutou") 
	SetTriggerOption("caiyaoChutou3","group","caiyaoChutou") 
    EnableTriggerGroup("caiyaoChutou",false)
    DeleteTriggerGroup("caiyao_task")
	create_trigger_t('caiyao_task1',"^(> )*你用药锄不断的拨动着四周的山草，忽然发现杂草之中有一株特别的草",'','caiyaoAttack')	
    create_trigger_t('caiyao_task2',"^(> )*你用药锄拨动着四周的灌木杂草，仔细地看有没有草药",'','caiyaoCyao5')
	create_trigger_t('caiyao_task3',"^(> )*你太累了，先歇息一会儿吧",'','caiyaowait')
	create_trigger_t('caiyao_task4',"^(> )*鹿清笃随手甩给"..score.name,'','caiyaoOk')
	create_trigger_t('caiyao_task5',"^(> )*你没有工具，无法拨开灌木山草寻找草药",'','caiyaoExp')
	create_trigger_t('caiyao_task6',"^(> )*你把四周的灌木杂草都翻遍了，可是没发现什么，看来这里没指望",'','caiyaoAgain')
	create_trigger_t('caiyao_task7',"^(> )*突然从草丛中",'','caiyaoKill')
	create_trigger_t('caiyao_task8',"^(> )*你给鹿清笃",'','caiyaoOk')
	create_trigger_t('caiyao_task9',"^(> )*你兴奋过度，把药锄一甩，忽听嘎巴一声，药锄断为两截！",'','caiyaoCyaox2')
	SetTriggerOption("caiyao_task1","group","caiyao_task")
	SetTriggerOption("caiyao_task2","group","caiyao_task")
	SetTriggerOption("caiyao_task3","group","caiyao_task")
	SetTriggerOption("caiyao_task4","group","caiyao_task")
	SetTriggerOption("caiyao_task5","group","caiyao_task")
	SetTriggerOption("caiyao_task6","group","caiyao_task")
	SetTriggerOption("caiyao_task7","group","caiyao_task")	
	SetTriggerOption("caiyao_task8","group","caiyao_task")	
	SetTriggerOption("caiyao_task9","group","caiyao_task")	
	EnableTriggerGroup("caiyao_task",false)
	DeleteTriggerGroup("caiyaoKill")
	create_trigger_t('caiyaoKill1',"^(> )*(\\D*)(凄惨的嚎了几声|惨嚎一声，死了！)",'','caiyaoJixu')	
    create_trigger_t('caiyaoKill3',"^(> )*(\\D*)神志迷糊，脚下一个不稳，倒在地上昏了过去。",'','caiyaoKill')
    create_trigger_t('caiyaoKill2',"^(> )*(\\D*)「啪」的一声倒在地上",'','caiyaoJixu')
    SetTriggerOption("caiyaoKill1","group","caiyaoKill")
	SetTriggerOption("caiyaoKill2","group","caiyaoKill")
	SetTriggerOption("caiyaoKill3","group","caiyaoKill")	
	EnableTriggerGroup("caiyaoKill",false)
end
function caiyaoTriggerdel()
    EnableTriggerGroup("caiyaoask",false)
	EnableTriggerGroup("caiyaoAccept",false)   
	EnableTriggerGroup("caiyao_task",false)
	EnableTriggerGroup("caiyaoChutou",false)
	EnableTriggerGroup("caiyaoKill",false)
	DeleteTriggerGroup("caiyaoask")
	DeleteTriggerGroup("caiyaoAccept")
	DeleteTriggerGroup("caiyaoChutou")
	DeleteTriggerGroup("caiyao_task")
	DeleteTriggerGroup("caiyaoKill")
end
function caiyaoConsider()
    EnableTriggerGroup("caiyaoask",false)
	EnableTriggerGroup("caiyaoAccept",true)   
end
function caiyaogo()
    return go(caiyaoChutou,"古墓","集市")	
end
function caiyaoChutou()
    return check_busy(caiyaoChutou1)	
end
function caiyaoChutou()
    EnableTriggerGroup("caiyaoChutou",true)
    return exe('s;ask sun about 药锄')	
end
function caiyaoChutou2()
	messageShow('全真采药：药锄拿到！')
    EnableTriggerGroup("caiyaoChutou",false)	
    return go(caiyaoCyao,"终南山","老妪岩")	
end
function caiyaoCyao()
	job.prossce=0
	i=0
	EnableTriggerGroup("caiyao_task",true)
    exe('e;s')
    return check_busy(caiyaoCyao2)	
end
function caiyaoCyao1()
    if job.prossce==1 then
        return check_busy(caiyaoCyaox)	
    else
        return check_busy(caiyaoCyao5)
    end
end
function caiyaoAttack()
    job.prossce=1	
	dis_all()
	EnableTriggerGroup("caiyao_task",true)
	checkBags()
	return check_busy(caiyaoCyaox)
end
function caiyaoCyao2()
    i=i+1
    return check_busy(caiyaoCyao4)
end
function caiyaoCyao3()
    i=0
    exe('s')
    return caiyaoCyao2()
end
function caiyaoCyao4()
    exe('yun jing;search;hp')
end

function caiyaoCyao5()
    if i<5 then 
        return check_busy(caiyaoCyao2)
    else 
	    return check_busy(caiyaoCyao3)
    end
end
function caiyaoCyaox()
    exe('wa 药草;hp')
	messageShow('全真采药：挖出馊糊一棵！')
	return check_busy(caiyaoCyaox1,1)
end
function caiyaoCyaox2()
	EnableTriggerGroup("caiyao_task",false)
	EnableTriggerGroup("caiyaoKill",false)
	EnableTrigger("caiyao_task3",true)
	EnableTrigger("caiyao_task4",true)
	EnableTrigger("caiyao_task8",true)
	messageShow('全真采药：回去交药')
	return check_busy(caiyaoCyaox1,1)
end
function caiyaowait()   
	return check_busy(caiyaoCyao4,10)
end
function caiyaoCyaox1()
    exe('w;n;n;n;n;n;n;w')
	return check_busy(caiyaoCyaoy)
end
function caiyaoAgain()   
    return check_busy(caiyaoAgain1)
end
function caiyaoAgain1()
    i=0
    exe('n;n;n;n;n;n;n;s')
    return caiyaoCyao2()
end
function caiyaoCyaoy()
    checkBags()
    return go(caiyaoOver,"全真","大堂一进") 
end
function caiyaoOver()
    if tmp.fuling and Bag["茯苓"] then
	   return check_heal()
	end
    exe('give lu zi;give lu huang lian;give lu he;give lu chuan bei;give lu ju geng;give lu hua;give lu di')
	exe('give lu fu ling')
end
function caiyaoOk()
    caiyaoTriggerdel()
	messageShow('全真采药：任务完成！')
	exe("bai lu")
    return check_bei(check_heal,1) 
end
function caiyaoExp()
	messageShow('全真采药：药锄断了！')
    EnableTriggerGroup("caiyao_task",false)
    EnableTriggerGroup("caiyaoChutou",true)	
    exe('w;n;n;n;n;n;n;w')
	return check_bei(caiyaogo,1)
end
function caiyaoKill()
    dis_all()
	EnableTriggerGroup("caiyaoKill",true)
    exe('l;id here;kill bee;kill deer;kill monkey;kill ye tu;kill wuya;kill xiao baozi;')
end
function caiyaoJixu()
    EnableTriggerGroup("caiyao_task",true)
	EnableTriggerGroup("caiyaoKill",false)
    check_busy(caiyaoCyao2)
end