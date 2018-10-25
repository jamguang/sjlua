--慕容浇花
jobSpecial = jobSpecial or {}
jobSpecial["jiaohua"] = true
job.list["jiaohua"] = function() if score.party and score.party == "姑苏慕容" and hp.exp and hp.exp < 1000000 then return "慕容浇花" else return false end end
JobTriggerDel = JobTriggerDel or {}
JobTriggerDel["jiaohua"] = "jiaohuaTriggerDel"

local l_haoke

function jiaohuaTrigger()
    DeleteTriggerGroup("jiaohuaAsk")
    create_trigger_t('jiaohuaAsk1',"^(> )*你向王夫人打听有关『job』的消息。",'','jiaohuaAccept')
    create_trigger_t('jiaohuaAsk2',"^(> )*这里没有这个人。$",'','jiaohuaNobody')
	SetTriggerOption("jiaohuaAsk1","group","jiaohuaAsk")
    SetTriggerOption("jiaohuaAsk2","group","jiaohuaAsk")
    EnableTriggerGroup("jiaohuaAsk",false)
    DeleteTriggerGroup("jiaohuaAccept")
    create_trigger_t('jiaohuaAccept1',"^(> )*王夫人说道\\D*茶花最近开的不盛，该好好照料一下了，你去找严婆婆，听她安排吧",'','jiaohuaGo')
    create_trigger_t('jiaohuaAccept2',"^(> )*王夫人说道：「你不是已经领了工作么，还不快去做！」",'','jiaohuaGo')
    create_trigger_t('jiaohuaAccept3',"^(> )*王夫人说道：「我正在美容，你过一会再来吧。」",'','jiaohuaBusy')
    SetTriggerOption("jiaohuaAccept1","group","jiaohuaAccept")
    SetTriggerOption("jiaohuaAccept2","group","jiaohuaAccept")
    SetTriggerOption("jiaohuaAccept3","group","jiaohuaAccept")
    EnableTriggerGroup("jiaohuaAccept",false)
	DeleteTriggerGroup("jiaohuaJiao")
    create_trigger_t('jiaohuaJiao1',"^(> )*你现在正忙着呢！",'','jiaohuaCon')
    create_trigger_t('jiaohuaJiao2',"^(> )*你已经干完了，还在这里干吗？想把花浇死呀？",'','jiaohuaBack')
    create_trigger_t('jiaohuaJiao3',"^(> )*你正在战斗中，无法专心干活！",'','jiaohuaCon')
	create_trigger_t('jiaohuaJiao4',"^(> )*你还没有去要工具，怎么干活呀？",'','jiaohua')
    create_trigger_t('jiaohuaJiao5',"^(> )*你想用什么来浇花，用手吗？",'','jiaohua')
    create_trigger_t('jiaohuaJiao6',"^(> )*你正在用心浇花，忽然一个江湖豪客闯了进来，一把抢过你的水瓢",'','jiaohuaKill')
	create_trigger_t('jiaohuaJiao7',"^(> )*你觉得水已经浇的差不多了，可以回去复命了。",'','jiaohuaBack')
	create_trigger_t('jiaohuaJiao8',"^(> )*你从水缸中舀了瓢水，小心翼翼的把水浇在",'','jiaohuaCon')
	create_trigger_t('jiaohuaJiao9',"^(> )*江湖豪客「啪」的一声倒在地上，挣扎着抽动了几下就死了。",'','jiaohuaGet')
    SetTriggerOption("jiaohuaJiao1","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao2","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao3","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao4","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao5","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao6","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao7","group","jiaohuaJiao")
    SetTriggerOption("jiaohuaJiao8","group","jiaohuaJiao")
	SetTriggerOption("jiaohuaJiao9","group","jiaohuaJiao")
    EnableTriggerGroup("jiaohuaJiao",false)
	--突然一个家丁跳了出来，大声喝道：你怎么比猪还慢，任务被取消了。
end
function jiaohuaTriggerDel()
    DeleteTriggerGroup("jiaohuaAsk")
    DeleteTriggerGroup("jiaohuaAccept")
    DeleteTriggerGroup("jiaohuaJiao")
end
function jiaohuaNobody()
    EnableTriggerGroup("jiaohuaAsk",false)
    return jiaohuaBusy()
end
function jiaohuaBusy()
    EnableTriggerGroup("jiaohuaAsk",false)
	EnableTriggerGroup("jiaohuaAccept",false)
	return prepare_lianxi(jiaohua)
end
function jiaohua()
    jiaohuaTrigger()
    job.name='jiaohua'
    job.time.b=os.time()
	locate()
	return prepare_lianxi(jiaohuaStart)
end
function jiaohuaStart()
	return go(jiaohuaAsk,"曼佗罗山庄","云锦楼")
end
function jiaohuaAsk()
    if not locl.id["王夫人"] then
	   return jiaohuaBusy()
	else
	   EnableTriggerGroup("jiaohuaAsk",true)
	   exe("ask wang furen about job")
	end
end
function jiaohuaAccept()
    EnableTriggerGroup("jiaohuaAsk",false)
	EnableTriggerGroup("jiaohuaAccept",true)
end
function jiaohuaGo()
    EnableTriggerGroup("jiaohuaAccept",false)
	return check_bei(jiaohuaYan)
end
function jiaohuaYan()
    exe('s;w')
    return jiaohuaYanAsk()
end
function jiaohuaYanAsk()
	exe('ask yan mama about 工具')
	return check_bei(jiaohuaCong)
end
function jiaohuaCong()
    exe('e;#4n;#6w')
	--exe('wield piao')
	locate()
	checkBags()
	return checkWait(jiaohuaPre,1)
end
function jiaohuaPre()
	fight_prepare()
	return check_bei(jiaohuaCongCheck)
end
function jiaohuaCongCheck()
    if locl.room ~= '花丛中' then
	   return jiaohua()
	end
	if not Bag["瓢"] then
	   return jiaohua()
	end
	road.id = "mr/mtl/hc3"
	return jiaohuaJiao()
end
function jiaohuaJiao()
	EnableTriggerGroup("jiaohuaJiao",true)
	exe('wield piao')
	exe('yun qi;yun jingli;jiaoshui')
end
function jiaohuaCon()
    --EnableTriggerGroup("jiaohuaJiao",false)
    if not l_haoke then
	   return check_bei(jiaohuaJiao)
    else
	   return checkWait(jiaohuaJiao,5)
	end
end
function jiaohuaKill()
    --EnableTriggerGroup("jiaohuaJiao",false)
	l_haoke = true
	exe('set wimpy 100')
	exe("pfmpfm")
end
function jiaohuaGet()
    l_haoke = nil
    for i = 1,3 do
	    exe('get piao from corpse '.. i)
		exe('get silver from corpse '.. i)
	end
	exe('wield piao')
	return check_bei(jiaohuaJiao)
end
function jiaohuaBack()
    EnableTriggerGroup("jiaohuaJiao",false)
	return go(jiaohuaFinish,'曼佗罗山庄','花肥房')
end
function jiaohuaFinish()
    exe('give piao to yan mama')
	exe('drop piao 2')
	exe('e;n')
	exe('ask wang furen about ok')
	exe('hp;cha;score')
	return check_heal()
end