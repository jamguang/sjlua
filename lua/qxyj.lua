quests = quests or {}
quests["xyj"] = {}
quests["xyj"].auto = 0
quests["xyj"].name = '�����澭�Ͼ�'

questTongji = questTongji or {}
questTongji["xyj"] = "xyjTongji"

questCal = questCal or {}
questCal["xyj"] = "xyjCal"

questList = questList or {}
questList["xyj"] = function() if canwu and canwu.gift and canwu.gift>19 then return quests["xyj"].name else return false end end


function xyjCal()
    if GetVariable("autoxyj") and canwu and canwu.gift and canwu.gift>19 then
      if GetVariable("timexyj") then
		 quests["xyj"].time=tonumber(GetVariable("timexyj"))
	  end
	  if GetVariable("autoxyj") then
		 quests["xyj"].auto=tonumber(GetVariable("autoxyj"))
	  end
	  if quests["xyj"].time==nil or os.time()-quests["xyj"].time > 24*60*60 then
	     quests["xyj"].time = os.time() - 22*60*60
		 SetVariable("timexyj",quests["xyj"].time)
	     if quests["xyj"].auto==nil or quests["xyj"].auto == 0 then
	        quests["xyj"].auto = 1
	     end
	     if quests["xyj"].auto == 1 then
		    exe('pray pearl')
		    return "questxyj"
	     end
	  else
	     if quests["xyj"].auto == 1 and quests["xyj"].time then
	        local l_time = 24*60*60 - (os.time() - quests["xyj"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["xyj"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function xyjTongji()
    if GetVariable("autoxyj") and quests["xyj"] and quests["xyj"].auto == 1 and quests["xyj"].time then
	   local l_time = 24*60*60 - (os.time() - quests["xyj"].time)
	   checkQuestNote(quests["xyj"].name,l_time)
	end
end

function questxyj()
    return go(xyjHask,"�һ���","����ͤ")
end
function xyjHask()
    if locl.room~="����ͤ" then
	   return questXyj()
	end
	if not locl.id["��ҩʦ"] then
       return xyjBusy()	   
	end
	exe("ask huang yaoshi about �ܲ�ͨ")
	return go(xyjRask,"thd/neishi1","����")
end
function xyjRask()
    if locl.room~="����" then
	   return go(xyjRask,"thd/neishi1","����")
	end
    if not locl.id["����"] then
       return xyjBusy()	   
	end
	exe("ask huang rong about �ܲ�ͨ")
	checkBags()
	return check_busy(xyjFanhe,1)
end
function xyjFanhe()
    if not Bag["����"] then
	   return xyjBusy()	
	end
	return go(xyjGive,"�һ���","�Ҷ�")
end
function xyjGive()
    if locl.room~="�Ҷ�" then
	   return go(xyjGive,"�һ���","�Ҷ�")
	end
	if not locl.id["�ܲ�ͨ"] then
       return go(xyjGive,"�һ���","�Ҷ�")  
	end
	DeleteTriggerGroup("xyj")
    create_trigger_t('xyj1','^(> )*�ܲ�ͨ˵������(����æ���ء�|����æ���أ��㻹���Ȼ�ȥ�ú�ѧѧ���հɡ�)','','xyjFail')
	create_trigger_t('xyj2','^(> )*�������ܲ�ͨ��(\\D*)֮�ڲ�׼�����㡣','','xyjTime')
	create_trigger_t('xyj3','^(> )*�ܲ�ͨ˵������(�㲻������ô��|������û�пգ��������澭�Ͼ���Ȼ�����Ҫ�ɡ�)','','xyjSucc')
	create_trigger_t('xyj4','^(> )*('..score.name..'|��)���³�¼��һ�ݾ����澭���Ͼ�$','','xyjSucc')
	create_trigger_t('xyj5','^(> )*�ܲ�ͨ˵��������û��������æ��ô��','','xyjWait')
	create_trigger_t('xyj6','^(> )*�ܲ�ͨ����('..score.name..'|��)˵�������ԹԵ�����˵���°ɡ���','','xyjStory')
	SetTriggerOption("xyj1","group","xyj")
	SetTriggerOption("xyj2","group","xyj")
	SetTriggerOption("xyj3","group","xyj")
	SetTriggerOption("xyj4","group","xyj")--�������ܲ�ͨ��һ�ֶ�ʮ����֮�ڲ�׼�����㡣
	SetTriggerOption("xyj5","group","xyj")
	SetTriggerOption("xyj6","group","xyj")
	exe("give fan he to zhou botong")
	exe("ask zhou botong about �����澭")
end
function xyjStory()
    EnableTriggerGroup("xyj",false)
	DeleteTriggerGroup("story")
    create_trigger_t('story1','^(> )*('..score.name..'|��)���ţ�Ҳѧ����Щȫ���������Ƥë��','','xyjQuestion')
	create_trigger_t('story2','^(> )*�ܲ�ͨ��ֵ��ʵ�����ʲô������������','','xyjBusy')
	SetTriggerOption("story1","group","story")
	SetTriggerOption("story2","group","story")
	wait.make(function()
	   wait.time(3)
	   exe("ask zhou botong about ����")
	   wait.time(3)
	   exe("ask zhou botong about ��������")
	end)
end
function xyjQuestion()
    EnableTriggerGroup("story",false)
	DeleteTriggerGroup("xyj")
    create_trigger_t('xyj1','^(> )*�ܲ�ͨ˵������(\\D*)��$','','xyjAnswer')
	create_trigger_t('xyj2','^(> )*�ܲ�ͨ��ֵ��ʵ�����ʲô������������','','xyjBusy')
	SetTriggerOption("xyj1","group","xyj")
	SetTriggerOption("xyj2","group","xyj")
	exe("answer no")
	tmp.answer = true
	create_timer_s('gongfu',90,'xyjGongfu')
	return xyjCheck()
end
function xyjAnswer(n,l,w)
    local answer = {
	     ["��ȫ��̵��ڹ��ķ���ʲô��"] = "xiantian-gong",
		 ["����а��������ָ����ʲô��"] = "tanzhi-shentong",
		 ["�μ�������ָΪ���Ľ�������ʲô���֣�"] = "liumai-shenjian",
		 ["���ư�������Ṧ�ǣ�"] = "shuishangpiao",
		 ["��������ͷ�İ����ǽ���ʲô��"] = "hansha-sheying",
		 ["�϶��������ڹ���ʲô��"] = "hamagong",
		 ["�Ͻл��͹��ֵܶ�����Ʒ���ʲô��"] = "xianglong-zhang",
		 ["���ֺ����ǵ��ڹ���ʲô��"] = "yijin-jing",
		 ["���ҵĽ�����ʲô��"] = "huifeng-jian",
		 ["�䵱����ͷ������������ȭ����ʲô���֣�"] = "taiji-quan",
		 ["�������޼���С�ӵ��ڹ���ʲô��"] = "jiuyang-shengong",
		 ["�����ɶ������õĹ�����ʲô��"] = "huagong-dafa",
		 ["Ľ�ݼҵļҴ������мܼ����ǣ�"] = "douzhuan-xingyi",
		 ["����ǰ������������ʲô���������߻�����ģ�"] = "qiankun-danuoyi",
		 ["����а���������������ڹ�����������ڹ��������ǣ�"] = "bihai-chaosheng",
		 ["�����ɾ���ѩ�˵Ľ�����ʲô���ƣ�"] = "jinshe-jianfa",
		 ["���ֽ���������ʹ�˾��Ӿ�����������������ʲô��"] = "pixie-jian",
		 ["��ɽ���ڵ���ɽ֮����ʲô��"] = "zixia-gong",
		 ["������ͯ���Դ�ȭ����ʲô����"] = "kongming-quan",
		 ["��ɽ���ڵĸ߼������ǣ�"] = "dugu-jiujian",
		 ["��Ĺ�ɵ��ڹ��ķ���ʲô��"] = "yunu-xinjing",
		 ["���������С�ӽ��ҵ��Ʒ�����ʲô���ƣ�"] = "anran-zhang",
		 ["һ�ƴ�ʦ�����־�ѧ��ʲô��"] = "yiyang-zhi",
		 ["�Ͻл��̻�����СѾͷ����ʲôȭ����"] = "xiaoyaoyou",
		 ["��Ĺһ�ɵ�����ȭ������ʲô���ƣ�"] = "mainu-quan",
		 ["����а���˽������ָ��ͨ��������ʲô�书��"] = "yuxiao-jian",
		 ["���õĸ�������ʲô��"] = "niqiugong",
		 ["���صļҴ��ַ���ʲô���֣�"] = "lanhua-shou",
		 ["�һ��Ŀ�����Ҫ��ʲô������ɨҶ�����ʩչ��"] = "luoying-zhang",
		 ["���ҵ����ʦ̫���������ֹ������޼ɴ�ĵ��ز���"] = "jieshou-jiushi",
	}
	
	if answer[w[2]] then
	   exe('answer '.. answer[w[2]])
	end
	
	if w[2]=="�����ɣ��ҽ�������Ĺ���" then
	   tmp.answer = nil
	   return xyjGongfu()
	end
	
	if w[2]=="��������ֱ������ģ���ȥ����ȥ��" then
	   tmp.answer = nil
	   return xyjFail()
	end
end
function xyjGongfu()
    EnableTriggerGroup("xyj",false)
	DeleteTriggerGroup("story")
    create_trigger_t('story1','^(> )*�ܲ�ͨ��('..score.name..'|��)��ϰ�����ᣬͻȻ������Ц������','','xyjSucc')
	create_trigger_t('story2','^(> )*('..score.name..'|��)������ô��ϰ�����޷��ɹ���','','xyjFail')
	SetTriggerOption("story1","group","story")
	SetTriggerOption("story2","group","story")
	tmp.answer = nil
	EnableTimer("Gongfu",false)
	DeleteTimer("Gongfu")
	questStartLog(quests["xyj"].name)
	exe("ask zhou botong about ����")
end
function xyjCheck()
    locate()
	return xyjCheckZhou()
end
function xyjCheckZhou()
    if not tmp.answer then return end
    if not locl.id["�ܲ�ͨ"] then
	   exe("out;enter")
	end
	return checkWait(xyjCheck,3)
end
function xyjWait()
    EnableTriggerGroup("xyj",false)
	return checkWait(xyjGive,3)
end
function xyjTime(n,l,w)
    EnableTriggerGroup("xyj",false)
	local l_str = Trim(w[2])
	local l_n = string.find(l_str,'Сʱ')
	local l_m = string.find(l_str,'��')
	
	local l_hour = 0
	local l_min  = 0
	
	if l_n then
	    l_hour = trans(string.sub(l_str,1,l_n-1))
		if l_m then 
		    l_min = trans(string.sub(l_str,l_n+4,l_m-1))
		end
	else
	    if l_m then
		    l_min = trans(string.sub(l_str,1,l_m-1))
		end
	end
	
	l_min = l_min + 1
	quests["xyj"].time = os.time() - 24*60*60 + l_hour*60*60 + l_min*60
	return check_bei(xyjOver)
end
function xyjBusy()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time() - 20*60*60
	return xyjOver()
end
function xyjFail()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time()
	return xyjOver()
end
function xyjSucc()
    EnableTriggerGroup("xyj",false)
	EnableTriggerGroup("story",false)
	quests["xyj"].time = os.time()
	quests["xyj"].auto = 2
	questSucLog(quests["xyj"].name)
	return xyjOver()
end
function xyjOver()
    DeleteTriggerGroup("story")
	DeleteTriggerGroup("xyj")
	tmp.answer = nil
    SetVariable("timexyj",quests["xyj"].time)
	SetVariable("autoxyj",quests["xyj"].auto)
	CloseLog()
	return check_bei(checkQuestOver)
end