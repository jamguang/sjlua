quests = quests or {}
quests["sszongh"] = {}
quests["sszongh"].auto = 0
quests["sszongh"].name = '嵩山剑法纵横绝世'

questTongji = questTongji or {}
questTongji["sszongh"] = "sszonghTongji"

questCal = questCal or {}
questCal["sszongh"] = "sszonghCal"

questList = questList or {}
questList["sszongh"] = function() if score.party and score.party=="嵩山派" and drugPrepare["火折"] and skills["songshan-jian"] and skills["songshan-jian"].lvl>550 then return quests["sszongh"].name else return false end end


function sszonghCal()
    if score.party=="嵩山派" and GetVariable("autosszongh") and Bag["火折"] and skills["songshan-jian"] and skills["songshan-jian"].lvl>550 then
      if GetVariable("timesszongh") then
		 quests["sszongh"].time=tonumber(GetVariable("timesszongh"))
	  end
	  if GetVariable("autosszongh") then
		 quests["sszongh"].auto=tonumber(GetVariable("autosszongh"))
	  end
	  if quests["sszongh"].time==nil or os.time()-quests["sszongh"].time > 24*60*60 then
	     quests["sszongh"].time = os.time() - 12*60*60
		 SetVariable("timesszongh",quests["sszongh"].time)
	     if quests["sszongh"].auto==nil or quests["sszongh"].auto == 0 then
	        quests["sszongh"].auto = 1
	     end
		 if (quests["sszongh"].auto == 1 and not string.find("亥|子|丑|寅|卯",locl.time) and Bag["火折"]) or quests["sszongh"].auto == 2  then
		    return "questsszongh"
	     end
	  else
	     if quests["sszongh"].auto < 3 and quests["sszongh"].time then
	        local l_time = 24*60*60 - (os.time() - quests["sszongh"].time)
			if l_time < 0 or l_time * math.random() < 1800 then
			   checkQuestNote(quests["sszongh"].name,l_time)
			end
	     end
	     return false
	  end
   end
end
function sszonghTongji()
    if GetVariable("autosszongh") and quests["sszongh"] and quests["sszongh"].auto < 3 and quests["sszongh"].time then
	   local l_time = 24*60*60 - (os.time() - quests["sszongh"].time)
	   checkQuestNote(quests["sszongh"].name,l_time)
	end
end
------ ain 嵩山剑法宗  纵横绝技
----------ain sszongh ask
function questsszongh()
    return go(sszonghPre,"嵩山","封禅台")  
end 
function sszonghPre()
    if not locl.id["左冷禅"] then
	   quests["sszongh"].time = os.time() - 23.5*60*60
	   return check_bei(sszonghOver)
	end
    DeleteTriggerGroup("sszonghAsk")
  
    create_trigger_t('sszonghAsk1',"^(> )*你向左冷禅打听有关『华山石壁』的消息。",'','sszonghAsk')
	create_trigger_t('sszonghAsk2',"^(> )*你向左冷禅打听有关『嵩山剑法绝技』的消息。",'','sszonghAsk')
    create_trigger_t('sszonghAsk3',"^(> )*这里没有这个人。$",'','sszonghNobody')
  	create_trigger_t('sszonghAsk4',"^(> )*你听了左盟主的指点，虽然看见了嵩山剑法的厉害招式，可是对嵩山剑法的真正奥妙全然不得要领",'','sszonghContinue')

    SetTriggerOption("sszonghAsk1","group","sszonghAsk")
    SetTriggerOption("sszonghAsk2","group","sszonghAsk")
	SetTriggerOption("sszonghAsk3","group","sszonghAsk")
    SetTriggerOption("sszonghAsk4","group","sszonghAsk")
    questStartLog(quests["sszongh"].name)
    if quests["sszongh"].auto == 2 then
	      exe('askk zuo lengchan about 嵩山剑法绝技')
    else
    wait.make(function()
	      exe('askk zuo lengchan about 嵩山剑法绝技')
	      wait.time(2)
	       return exe('askk zuo lengchan about 华山石壁')
	     
	   end)
	   end
	--  return exe('askk zuo lengchan about 华山石壁')
end
--左冷禅说道：「你也太勤快点了耶？？」
function sszonghAsk()
    --print("ain debug 命中")
    EnableTriggerGroup("sszonghAsk",false)
	DeleteTriggerGroup("sszongh")
	create_trigger_t('sszongh1',"^(> )*左冷禅(对你|)说道：(|「)今天先教到这里吧，明天吧。」",'','sszonghFail')
	create_trigger_t('sszongh2','^(> )*我大嵩山也是在此战中无数高手陨落，使得我派绝技至今仍然残缺不全，很多招式','','sszonghgohs')
	create_trigger_t('sszongh3',"^(> )*你已经习得|^(> )*忽然间，你灵光一闪，以前无论如何也想不明白的问题忽然间豁然贯通",'','sszonghSucc')
	create_trigger_t('sszongh4',"^(> )*你听了左盟主的指点，虽然看见了嵩山剑法的厉害招式，可是对嵩山剑法的真正奥妙全然不得要领",'','sszonghContinue')
	create_trigger_t('sszongh5',"^(> )*左冷禅(对你|)说道：(|「)你已经将嵩山剑法融会贯通，来消遣本盟主么？」",'','sszonghSucc')
	SetTriggerOption("sszongh1","group","sszongh")
    SetTriggerOption("sszongh2","group","sszongh")
	SetTriggerOption("sszongh3","group","sszongh")
	SetTriggerOption("sszongh4","group","sszongh")
    SetTriggerOption("sszongh5","group","sszongh")
end
function sszonghgohs()
    return go(sszonghmb,"华山","思过崖")
end
function sszonghmb()
    EnableTriggerGroup("sszonghAsk",false)
	  DeleteTriggerGroup("sszongh")
	  create_trigger_t('sszongh1',"^(> )*你对着石壁跌坐静思，良久，若有所悟。",'','sszonghmb2')
	  create_trigger_t('sszongh2','^(> )*你正忙着呢，无法静下心来面壁思过。','','sszonghmb2')
	  create_trigger_t('sszongh3',"^(> )*你忽然产生一种破壁的欲望，不禁站了起来。",'','sszonghbreak')
	  create_trigger_t('sszongh4',"^(> )*你已经将嵩阳诀的心法发挥的淋漓极致，长吁一口气，缓缓收了剑势！",'','sszonghyanjiu')
	 -- create_trigger_t('sszongh5',"^(> )*一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……",'','sszonghfaint')
	  create_trigger_t('sszongh6',"^(> )*就在你陷入迷茫之际，寒冰真气陡然发动，让你清醒了过来，你领悟到此，看了下那“尽破”二字",'','sszonghSucc1')
		create_trigger_t('sszongh7',"^一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……",'','sszonghyanjiu')--weimin
	  SetTriggerOption("sszongh1","group","sszongh")
    SetTriggerOption("sszongh2","group","sszongh")
	  SetTriggerOption("sszongh3","group","sszongh")
	  SetTriggerOption("sszongh4","group","sszongh")
	  SetTriggerOption("sszongh5","group","sszongh")
	  SetTriggerOption("sszongh6","group","sszongh")
		SetTriggerOption("sszongh7","group","sszongh")--weimin
	  exe('enter;set wimpy 100;mianbi')
end
function sszonghbreak()
   return check_halt(sszonghbreakenter)
end
function sszonghbreakenter()
   exe("wield jian;break")
   return check_halt(sszonghbreakentsan)
end
function sszonghbreakentsan()
    
   flag.idle=-10
   exe('enter;use fire;left;e;l dazi;l wall;kan ziji;yun huti;wield jian;say kan ziji 吧')
   
end

function sszonghmb2()
    wait.make(function()
	      wait.time(0.9)
	         return exe('mianbi')
	   end)
    
end   
function sszonghyanjiu()
  return check_busy(sszonghyanjiu2)
end
function sszonghyanjiu2()
   flag.idle=0
    EnableTriggerGroup("sszonghAsk",false)
	  DeleteTriggerGroup("sszongh")
	  create_trigger_t('sszongh1',"^(> )*解密失败，继续再来。",'','sszonghback')
	  create_trigger_t('sszongh2','^(> )*恭喜。','','sszonghokback2')
	  SetTriggerOption("sszongh1","group","sszongh")
    SetTriggerOption("sszongh2","group","sszongh")
	--  SetTriggerOption("sszongh3","group","sszongh")
	  exe('yanjiu 嵩山剑法')
end 
function sszonghback()
   return check_halt(sszonghback2)
end
function sszonghback2()
   exe('wield jian;w;out;break;out')
   return sszonghContinue()
end
function sszonghpkback()
   return check_halt(sszonghokback2)
end
function sszonghokback2()
   exe('w;out;break;out')
   return sszonghSucc()
end
function sszonghSucc1()
    EnableTriggerGroup("sszongh",false)
	quests["sszongh"].time = os.time()
	quests["sszongh"].auto = 2
	questSucLog(quests["sszongh"].name.."I")
	return check_bei(sszonghOver)
end
function sszonghSucc()
    EnableTriggerGroup("sszongh",false)
	quests["sszongh"].time = os.time()
	quests["sszongh"].auto = 3
	questSucLog(quests["sszongh"].name.."II")
	return check_bei(sszonghOver)
end
function sszonghContinue()
    EnableTriggerGroup("sszongh",false)
	quests["sszongh"].time = os.time()
	return check_bei(sszonghOver)
end
function sszonghFail()
    EnableTriggerGroup("sszongh",false)
  	quests["sszongh"].time = os.time() - 20*60*60
	return check_bei(sszonghOver)
end
function sszonghNobody()
    EnableTriggerGroup("sszonghAsk",false)
	quests["sszongh"].time = os.time() - 23.5*60*60
	return check_bei(sszonghOver)
end
function sszonghfaint()
    EnableTriggerGroup("sszongh",false)
	quests["sszongh"].time = os.time() - 23.9*60*60
	exe("wield jian;w;out;break;out")
	return check_bei(sszonghOver)
end
function sszonghOver()
    CloseLog()
	SetVariable("timesszongh",quests["sszongh"].time)
	SetVariable("autosszongh",quests["sszongh"].auto)
    return check_bei(checkQuestOver)
end