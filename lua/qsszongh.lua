quests = quests or {}
quests["sszongh"] = {}
quests["sszongh"].auto = 0
quests["sszongh"].name = '��ɽ�����ݺ����'

questTongji = questTongji or {}
questTongji["sszongh"] = "sszonghTongji"

questCal = questCal or {}
questCal["sszongh"] = "sszonghCal"

questList = questList or {}
questList["sszongh"] = function() if score.party and score.party=="��ɽ��" and drugPrepare["����"] and skills["songshan-jian"] and skills["songshan-jian"].lvl>550 then return quests["sszongh"].name else return false end end


function sszonghCal()
    if score.party=="��ɽ��" and GetVariable("autosszongh") and Bag["����"] and skills["songshan-jian"] and skills["songshan-jian"].lvl>550 then
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
		 if (quests["sszongh"].auto == 1 and not string.find("��|��|��|��|î",locl.time) and Bag["����"]) or quests["sszongh"].auto == 2  then
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
------ ain ��ɽ������  �ݺ����
----------ain sszongh ask
function questsszongh()
    return go(sszonghPre,"��ɽ","����̨")  
end 
function sszonghPre()
    if not locl.id["������"] then
	   quests["sszongh"].time = os.time() - 23.5*60*60
	   return check_bei(sszonghOver)
	end
    DeleteTriggerGroup("sszonghAsk")
  
    create_trigger_t('sszonghAsk1',"^(> )*���������������йء���ɽʯ�ڡ�����Ϣ��",'','sszonghAsk')
	create_trigger_t('sszonghAsk2',"^(> )*���������������йء���ɽ��������������Ϣ��",'','sszonghAsk')
    create_trigger_t('sszonghAsk3',"^(> )*����û������ˡ�$",'','sszonghNobody')
  	create_trigger_t('sszonghAsk4',"^(> )*��������������ָ�㣬��Ȼ��������ɽ������������ʽ�����Ƕ���ɽ��������������ȫȻ����Ҫ��",'','sszonghContinue')

    SetTriggerOption("sszonghAsk1","group","sszonghAsk")
    SetTriggerOption("sszonghAsk2","group","sszonghAsk")
	SetTriggerOption("sszonghAsk3","group","sszonghAsk")
    SetTriggerOption("sszonghAsk4","group","sszonghAsk")
    questStartLog(quests["sszongh"].name)
    if quests["sszongh"].auto == 2 then
	      exe('askk zuo lengchan about ��ɽ��������')
    else
    wait.make(function()
	      exe('askk zuo lengchan about ��ɽ��������')
	      wait.time(2)
	       return exe('askk zuo lengchan about ��ɽʯ��')
	     
	   end)
	   end
	--  return exe('askk zuo lengchan about ��ɽʯ��')
end
--������˵��������Ҳ̫�ڿ����Ү������
function sszonghAsk()
    --print("ain debug ����")
    EnableTriggerGroup("sszonghAsk",false)
	DeleteTriggerGroup("sszongh")
	create_trigger_t('sszongh1',"^(> )*������(����|)˵����(|��)�����Ƚ̵�����ɣ�����ɡ���",'','sszonghFail')
	create_trigger_t('sszongh2','^(> )*�Ҵ���ɽҲ���ڴ�ս�������������䣬ʹ�����ɾ���������Ȼ��ȱ��ȫ���ܶ���ʽ','','sszonghgohs')
	create_trigger_t('sszongh3',"^(> )*���Ѿ�ϰ��|^(> )*��Ȼ�䣬�����һ������ǰ�������Ҳ�벻���׵������Ȼ���Ȼ��ͨ",'','sszonghSucc')
	create_trigger_t('sszongh4',"^(> )*��������������ָ�㣬��Ȼ��������ɽ������������ʽ�����Ƕ���ɽ��������������ȫȻ����Ҫ��",'','sszonghContinue')
	create_trigger_t('sszongh5',"^(> )*������(����|)˵����(|��)���Ѿ�����ɽ�����ڻ��ͨ������ǲ������ô����",'','sszonghSucc')
	SetTriggerOption("sszongh1","group","sszongh")
    SetTriggerOption("sszongh2","group","sszongh")
	SetTriggerOption("sszongh3","group","sszongh")
	SetTriggerOption("sszongh4","group","sszongh")
    SetTriggerOption("sszongh5","group","sszongh")
end
function sszonghgohs()
    return go(sszonghmb,"��ɽ","˼����")
end
function sszonghmb()
    EnableTriggerGroup("sszonghAsk",false)
	  DeleteTriggerGroup("sszongh")
	  create_trigger_t('sszongh1',"^(> )*�����ʯ�ڵ�����˼�����ã���������",'','sszonghmb2')
	  create_trigger_t('sszongh2','^(> )*����æ���أ��޷������������˼����','','sszonghmb2')
	  create_trigger_t('sszongh3',"^(> )*���Ȼ����һ���Ʊڵ�����������վ��������",'','sszonghbreak')
	  create_trigger_t('sszongh4',"^(> )*���Ѿ������������ķ����ӵ����켫�£�����һ�������������˽��ƣ�",'','sszonghyanjiu')
	 -- create_trigger_t('sszongh5',"^(> )*һ��ů�����Ե�������ȫ�����������ָֻ���֪������",'','sszonghfaint')
	  create_trigger_t('sszongh6',"^(> )*������������ã֮�ʣ�����������Ȼ���������������˹����������򵽴ˣ��������ǡ����ơ�����",'','sszonghSucc1')
		create_trigger_t('sszongh7',"^һ��ů�����Ե�������ȫ�����������ָֻ���֪������",'','sszonghyanjiu')--weimin
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
   exe('enter;use fire;left;e;l dazi;l wall;kan ziji;yun huti;wield jian;say kan ziji ��')
   
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
	  create_trigger_t('sszongh1',"^(> )*����ʧ�ܣ�����������",'','sszonghback')
	  create_trigger_t('sszongh2','^(> )*��ϲ��','','sszonghokback2')
	  SetTriggerOption("sszongh1","group","sszongh")
    SetTriggerOption("sszongh2","group","sszongh")
	--  SetTriggerOption("sszongh3","group","sszongh")
	  exe('yanjiu ��ɽ����')
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