--tmonk
job.list = job.list or {}
job.list["tmonk"] = function() if score.party and score.party == "������" and hp.exp<2000000 and string.find(score.master,"��") then return "���ֽ̺���" else return false end end
joblast = joblast or {}
joblast["ѵ����ɮ"]   = "tmonk"

	  
function tmonkTrigger()
    DeleteTriggerGroup("tmonkFollow")
    create_trigger_t('tmonkFollow1',"^(> )*������������Ѵ�ʦһ���ж���",'','tmonkFollow')
    create_trigger_t('tmonkFollow2',"^(> )*����û�� xuancan dashi��$",'','tmonkNobody')
    SetTriggerOption("tmonkFollow1","group","tmonkFollow")
    SetTriggerOption("tmonkFollow2","group","tmonkFollow")
    EnableTriggerGroup("tmonkFollow",false)
    DeleteTriggerGroup("tmonkAsk")
    create_trigger_t('tmonkAsk1',"^(> )*�������Ѵ�ʦ�����й�",'','tmonkAsk')
    create_trigger_t('tmonkAsk2',"^(> )*����û������ˡ�$",'','tmonkNobody')
    SetTriggerOption("tmonkAsk1","group","tmonkAsk")
    SetTriggerOption("tmonkAsk2","group","tmonkAsk")
    EnableTriggerGroup("tmonkAsk",false)
    DeleteTriggerGroup("tmonkAccept")
    create_trigger_t('tmonkAccept1',"^(> )*���Ѵ�ʦ˵��������ղŲ����Ѿ��ʹ�����",'','tmonkStart')
    create_trigger_t('tmonkAccept2',"^(> )*���Ѵ�ʦ˵������������æ�������������ء�",'','tmonkBusy')
    create_trigger_t('tmonkAccept3',"^(> )*���Ѵ�ʦ˵���������ѵ����ɮ��������������Ϣһ��ɡ�",'','tmonkFangqi')
    create_trigger_t('tmonkAccept4',"^(> )*���Ѵ�ʦ˵��������������æ��������������",'','tmonkBusy')
    create_trigger_t('tmonkAccept5',"^(> )*���Ѵ�ʦ˵������\\D*���۷����䣬�������",'','tmonkGuilty')
    create_trigger_t('tmonkAccept6',"^(> )*����˵�����ðɣ�������޺�����ѵ����ɮ",'','tmonkStart')
    SetTriggerOption("tmonkAccept1","group","tmonkAccept")
    SetTriggerOption("tmonkAccept2","group","tmonkAccept")
    SetTriggerOption("tmonkAccept3","group","tmonkAccept")
    SetTriggerOption("tmonkAccept4","group","tmonkAccept")
    SetTriggerOption("tmonkAccept5","group","tmonkAccept")
    SetTriggerOption("tmonkAccept6","group","tmonkAccept")
    EnableTriggerGroup("tmonkAccept",false)
    DeleteTriggerGroup("tmonkFind")
    create_trigger_t('tmonkFind1','^^(> )*\\D*���Ѵ�ʦ\\((\\D*)\\)','','tmonkDashi')
    SetTriggerOption("tmonkFind1","group","tmonkFind")
    EnableTriggerGroup("tmonkFind",false)
    DeleteTriggerGroup("tmonkWujiAsk")
    create_trigger_t('tmonkWujiAsk1',"^(> )*����Բ(��|ҵ|��|��|��|��)���д����й�",'','tmonkWujiAsk')
    create_trigger_t('tmonkWujiAsk2',"^(> )*����û������ˡ�$",'','tmonkWujiNobody')
    SetTriggerOption("tmonkWujiAsk1","group","tmonkWujiAsk")
    SetTriggerOption("tmonkWujiAsk2","group","tmonkWujiAsk")
    EnableTriggerGroup("tmonkWujiAsk",false)
	DeleteTriggerGroup("tmonkWujiReply")
    create_trigger_t('tmonkWujiReply1',"^(> )*Բ(��|ҵ|��|��|��|��)����˵����������ɲ�����˵��",'','tmonkFinish')
    create_trigger_t('tmonkWujiReply2',"^(> )*Բ(��|ҵ|��|��|��|��)����һ�����ص�",'','tmonkWujiNobody')
    create_trigger_t('tmonkWujiReply3',"^(> )*Բ(��|ҵ|��|��|��|��)���������ؿ�����",'','tmonkWujiNobody')
    create_trigger_t('tmonkWujiReply4',"^(> )*Բ(��|ҵ|��|��|��|��)����˵������Сɮ��ѧ",'','tmonkTeachStart')
    SetTriggerOption("tmonkWujiReply1","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply2","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply3","group","tmonkWujiReply")
    SetTriggerOption("tmonkWujiReply4","group","tmonkWujiReply")
    EnableTriggerGroup("tmonkWujiReply",false)
	DeleteTriggerGroup("tmonkTeach")
    create_trigger_t('tmonkTeach1',"^(> )*�㻹����ȥ�����Ѵ�ʦ�����к��ɡ�",'','tmonkFinish')
    create_trigger_t('tmonkTeach2',"^(> )*Բ(��|ҵ|��|��|��|��)����˵������������",'','tmonkWujiNobody')
    create_trigger_t('tmonkTeach3',"^(> )*�����Ϊ���������أ�������ң�",'','tmonkWujiKill')
    create_trigger_t('tmonkTeach4',"^(> )*Բ(��|ҵ|��|��|��|��)����̫���ˣ�����û�а취ѧ��",'','tmonkChange')
	create_trigger_t('tmonkTeach5',"^(> )*Բ(��|ҵ|��|��|��|��)������æ���ء�",'','tmonkChange')
	create_trigger_t('tmonkTeach6',"^(> )*��(��æ���ء�|���Ľ�������)",'','tmonkContinue')
	create_trigger_t('tmonkTeach7','^(> )*��� "action" �趨Ϊ "teach" �ɹ���ɡ�$','','tmonkTeachCon')
	create_trigger_t('tmonkTeach8',"^(> )*(\\D*)�����Աߣ����޷�ר��ָ�㡣",'','tmonkChange')
	create_trigger_t('tmonkTeach9',"^(> )*Բ(��|ҵ|��|��|��|��)����������ܣ�һ�������(\\D*)��ȥ",'','tmonkMotou')
    SetTriggerOption("tmonkTeach1","group","tmonkTeach")
    SetTriggerOption("tmonkTeach2","group","tmonkTeach")
    SetTriggerOption("tmonkTeach3","group","tmonkTeach")
    SetTriggerOption("tmonkTeach4","group","tmonkTeach")
	SetTriggerOption("tmonkTeach5","group","tmonkTeach")
	SetTriggerOption("tmonkTeach6","group","tmonkTeach")
	SetTriggerOption("tmonkTeach7","group","tmonkTeach")
	SetTriggerOption("tmonkTeach8","group","tmonkTeach")
	SetTriggerOption("tmonkTeach9","group","tmonkTeach")
    EnableTriggerGroup("tmonkTeach",false)
	DeleteTriggerGroup("tmonkMotouFind")
    create_trigger_t('tmonkMotouFind1','^^(> )*а��ħͷ�߾���ȭ��������','','tmonkMotouKill')
    SetTriggerOption("tmonkMotouFind1","group","tmonkMotouFind")
    EnableTriggerGroup("tmonkMotouFind",false)
    DeleteTriggerGroup("tmonkFight")
    create_trigger_t('tmonkFight1','^(> )*а��ħͷ��ž����һ�����ڵ���','','tmonkDie')
    create_trigger_t('tmonkFight2','^(> )*а��ħͷ��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��','','tmonkFaint')
    SetTriggerOption("tmonkFight1","group","tmonkFight")
    SetTriggerOption("tmonkFight2","group","tmonkFight")
    EnableTriggerGroup("tmonkFight",false)
end
function tmonkTriggerDel()
    DeleteTriggerGroup("tmonkFollow")
    DeleteTriggerGroup("tmonkAsk")
    DeleteTriggerGroup("tmonkAccept")
    DeleteTriggerGroup("tmonkFight")
    DeleteTriggerGroup("tmonkFind")
	DeleteTriggerGroup("tmonkWujiAsk")
	DeleteTriggerGroup("tmonkWujiReply")
	DeleteTriggerGroup("tmonkTeach")
	DeleteTriggerGroup("tmonkMotouFind")
end

function tmonk()
    job.name='tmonk'
    tm = tm or {}
	tmroom = {}
	tmroom["shaolin/wstang1"] = true
	tmroom["shaolin/wstang2"] = true
	tmroom["shaolin/wstang3"] = true
	tmroom["shaolin/wstang4"] = true
	tmroom["shaolin/wstang5"] = true
	tmroom["shaolin/wstang6"] = true
	for p in pairs(tm) do
	    tmroom[p] = nil
	end
    tmonkTrigger()
	messageShow('Tmonk��������ʼ��','green')
	
    return prepare_neili(tmonkGuilty)
end
function tmonkFindAgain()
    EnableTriggerGroup("tmonkFind",false)
	EnableTriggerGroup("tmonkMotouFind",false)
    return go(find,dest.area,dest.room)
end
function tmonkGo()
    return go(tmonkXuancan,"��ɽ����","������")
end
function tmonkXuancan()
    EnableTriggerGroup("tmonkFind",true)
    job.flag()
	flag.times=2
    return find()
end
function tmonkDashi()
    flag.find = 1
	dis_all()
	EnableTriggerGroup("tmonkFind",false)
    EnableTriggerGroup("tmonkFollow",true)
    exe('follow xuancan dashi')
end
function tmonkNobody()
    EnableTriggerGroup("tmonkFollow",false)
    EnableTriggerGroup("tmonkAsk",false)
    return go(tmonkXuancan,"��ɽ����","������")
end
function tmonkFollow()
    EnableTriggerGroup("tmonkFollow",false)
    EnableTriggerGroup("tmonkAsk",true)
    exe('ask xuancan dashi about �޺���ֵ��')
end
function tmonkAsk()
    EnableTriggerGroup("tmonkAsk",false)
    EnableTriggerGroup("tmonkAccept",true)
	job.last = 'tmonk'
    exe('follow none')
end
function tmonkGuilty()
    EnableTriggerGroup("tmonkAccept",false)
	if score.party and score.party=="������" and score.master=="������ɮ" and skills["buddhism"] and skills["buddhism"].lvl==200 then
	   return go(tmonkFofa,"��ɽ����","����")
	end
    return go(tmonkCh,'��ɽ����','����Ժ')
end
function tmonkFofa()
    exe("ask wuming about ��")
	return tmonkGo()
end
function tmonkCh()
    checkWait(tmonkGo,2)
end
function tmonkFangqi()
    EnableTriggerGroup("tmonkAccept",false)
    job.last='tmonk'
    return check_heal()
end
function tmonkBusy()
    EnableTriggerGroup("tmonkAccept",false)
    return prepare_lianxi(tmonk)
end
function tmonkStart()
    EnableTriggerGroup("tmonkAccept",false)
	job.last='tmonk'
    if countTab(tm) > 0 then
       local l_id
       for p in pairs(tm) do
           l_id = p
       end
       return go(tmonkWuji,l_id)
    else
       return go(tmonkWuji,"shaolin/wstang1")
    end
end
function tmonkWuji()
    EnableTriggerGroup("tmonkWujiAsk",true)
    exe('ask monk about �似')
end
function tmonkWujiAsk()
    EnableTriggerGroup("tmonkWujiAsk",false)
    EnableTriggerGroup("tmonkWujiReply",true)
end
function tmonkWujiNobody()
    EnableTriggerGroup("tmonkWujiReply",false)
    EnableTriggerGroup("tmonkWujiAsk",false)
	EnableTriggerGroup("tmonkTeach",false)
	tm[road.id] = nil
	tmroom[road.id] = nil
	return check_bei(tmonkWujiFind)
end
function tmonkWujiFind()
	if countTab(tmroom)==0 then
	   if countTab(tm)==0 then
	      return tmonkFinish()
	   else
	      return tmonkStart()
	   end
	else
	   local l_id
       for p in pairs(tmroom) do
           l_id = p
       end
       return go(tmonkWuji,l_id)
	end
end
function tmonkChange()
    tmchg=true
end
function tmonkChgMonk()
    EnableTriggerGroup("tmonkTeach",false)
	if countTab(tm)>1 then
	   local l_id
	   for p in pairs(tm) do
	       if p ~= road.id then
		      l_id = p
		   end
	   end
	   if l_id then
	      return go(tmonkTeach,l_id)
	   else
	      return tmonkWujiFind()
	   end
	else
	   if countTab(tmroom)==0 then
	      return check_busy(tmonkTeach,1)
	   else
	      return tmonkWujiFind()
	   end
	end
end
function tmonkTeachStart()
    EnableTriggerGroup("tmonkWujiReply",false)
	tm[road.id] = true
	tmroom[road.id] = nil
	return check_bei(tmonkTeach)
end
function tmonkTeach()
	EnableTriggerGroup("tmonkTeach",true)
	tmcon=nil
	tmchg=nil
	exe('yun jing;#2(teach monk)')
	exe('alias action teach')
end
function tmonkTeachCon()
    EnableTriggerGroup("tmonkTeach",false)
	if tmchg then
	   --return tmonkChgMonk()
	   return check_busy(tmonkTeach,1)
	end
	if tmcon then
	   return check_bei(tmonkTeach)
	else
	   return tmonkWujiNobody()
	end
end
function tmonkContinue()
    tmcon=true
end
function tmonkWujiKill()
    EnableTriggerGroup("tmonkTeach",false)
    return wipe("monk",tmonkWujiNobody)
end
function tmonkMotou(n,l,w)
    EnableTriggerGroup("tmonkTeach",false)
	dest.room=Trim(w[3])
    dest.area="��ɽ����"
	road.idold = road.id
    if not dest.room or not path_cal() then
       messageShow('Teach����ħͷ���ֵص㡾'.. dest.area .. dest.room ..'�����ɵ������MONK!')
	   road.id = road.idold
       return tmonkWujiNobody()
	else
	   messageShow('Tmonk����а��ħͷ������'.. dest.room ..'��','green')
	   return tmonkMotouFind()
    end
end
function tmonkMotouFind()
    EnableTriggerGroup("tmonkMotouFind",true)
	if dest.room == "ʯ��·" then
	   return go(find,"shaolin/sblu-3","")
	end
	return go(find,dest.area,dest.room)
end
function tmonkMotouKill()
    flag.find=1
	dis_all()
	EnableTriggerGroup("tmonkFight",true)
	exe('set wimpy 100')
	exe('kill mo tou')
	job.killer["а��ħͷ"]="mo tou"
end
function tmonkFaint()
    exe('unset wimpy')
    exe('kill mo tou')
end
function tmonkDie()
    EnableTriggerGroup("tmonkFight",false)
	messageShow('Tmonk���񣺸㶨а��ħͷ��','green')
	return check_bei(tmonkGet)
end
function tmonkGet()
    for i=1,3 do
	   exe('get gold from corpse '.. i)
	   exe('get muou from corpse '.. i)
	end
	checkBags()
	return check_busy(tmonkMuou)
end
function tmonkMuou()
    if Bag["ʮ��ľż"] then
	   messageShow('Tmonk���������ܺã��㵽ʮ��ľż��','green')
	   return go(tmonkMuouGive,"��ɽ����","������")
	else
	   return tmonkStart()
	end
end
function tmonkMuouGive()
    exe('give muou to xuanci dashi')
	return tmonkStart()
end
function tmonkFinish()
    dis_all()
    messageShow('Tmonk����������ɡ�','green')
    return go(check_heal,"��ɽ����","�޺���")
end