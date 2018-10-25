function qrySkillEnable(sk)
    local ske = skillsEnable[sk]
    if not ske then
	   return false
	end 
	local skl = {}
	if type(ske)=="function" then
	   if ske() then
	      skl = utils.split(ske(),",")
	   else
	      return false
	   end
	else
	   skl = utils.split(ske,",")
	end
	local skr = {}
	for _,p in pairs(skl) do
	   skr[p] = true
	end
	if countTab(skr) > 0 then
	   return skr
	else
	   return false
	end
end


skillLianxi={["bizhen-qingzhang"] = 0.3,
}

skillEnable={["anying-fuxiang"] = "dodge",
["anran-zhang"] = "strike",
["baduan-jin"] = "force",
["bahuang-gong"] = "force",
["baihua-cuoquan"] = "cuff",
["banruo-zhang"] = "strike",
["beiming-shengong"] = "force",
["bihai-chaosheng"] = "force",
["bizhen-qingzhang"] = "strike",
["canglang-goufa"] = "hook",
["canhe-zhi"] = "finger",
["cansi-shou"] = "hand",
["caoshang-fei"] = "dodge",
["chongling-jian"] = "sword",
["chousui-zhang"] = "strike",
["chuanyun-tui"] = "leg",
["cihang-bian"] = "whip",
["cibei-dao"] = "blade",
["cuixin-zhang"] = "strike",
["cuogu-shou"] = "hand",
["dafumo-quan"] = "cuff",
["dagou-bang"] = "stick",
["damo-jian"] = "sword",
["dashou-yin"] = "hand",
["ding-dodge"] = "dodge",
["duanjia-jianfa"] = "sword",
["duanjia-quan"] = "cuff",
["dugu-jiujian"] = "sword",
["dulong-dafa"] = "force",
["duoming-jinhua"] = "throwing",
["fanliangyi-dao"] = "blade",
["fengmo-zhang"] = "staff",
["fengyun-shou"] = "hand",
["fuhu-quan"] = "cuff",
["fumo-jian"] = "sword",
["fuqin-shi"] = "whip",
["furong-jinzhen"] = "throwing",
["guiyuan-tunafa"] = "force",
["hamabu"] = "dodge",
["hamagong"] = "force",
["hanbing-mianzhang"] = "strike",
["hanbing-shenzhang"] = "strike",
["hanbing-zhenqi"] = "force",
["haotian-zhang"] = "strike",
["hansha-sheying"] = "throwing",
["hengshan-jian"] = "sword",
["hengshan-jianfa"] = "sword",
["henshan-jianfa"] = "sword",
["huagong-dafa"] = "force",
["huagu-mianzhang"] = "strike",
["huanmo-wubu"] = "dodge",
["huanmo-longtianwu"] = "dodge",
["huanyin-zhi"] = "finger",
["huashan-jianfa"] = "sword",
["huashan-qigong"] = "force",
["huashan-shenfa"] = "dodge",
["huifeng-bian"] = "whip",
["huifeng-jian"] = "sword",
["hujia-daofa"] = "blade",
["huntian-qigong"] = "force",
["hunyuan-zhang"] = "strike",
["huoyan-dao"] = "strike",
["huyan-qiang"] = "spear",
["jieshou-jiushi"] = "hand",
["jimie-zhua"] = "claw",
["jindao-heijian"] = "sword",
["jingang-quan"] = "cuff",
["jinshe-jianfa"] = "sword",
["jinshe-zhangfa"] = "strike",
["jinshe-zhuifa"] = "throwing",
["jinwu-daofa"] = "blade",
["jinyan-gong"] = "dodge",
["jiuyang-shengong"] = "force",
["jiuyin-baiguzhua"] = "claw",
["jiuyin-shenfa"] = "dodge",
["jiuyin-shenzhang"] = "strike",
["jiuyin-shenzhua"] = "claw",
["jiuyin-zhengong"] = "force",
["juehu-shou"] = "hand",
["kaishan-fu"] = "axe",
["kaishan-zhang"] = "strike",
["kongming-quan"] = "cuff",
["kuaihuo-zhang"] = "strike",
["kuihua-feiying"] = "dodge",
["kuihua-mogong"] = "force",
["kuihua-shengong"] = "force",
["kunlun-zhang"] = "strike",
["kurong-changong"] = "force",
["lanhua-shou"] = "hand",
["lengquan-shengong"] = "force",
["liangyi-jian"] = "sword",
["lianhua-zhang"] = "strike",
["lietian-fu"] = "axe",
["liehuo-jian"] = "sword",
["lieyan-dao"] = "blade",
["lingbo-weibu"] = "dodge",
["lingshe-bianfa"] = "whip",
["lingshe-quanfa"] = "cuff",
["lingxu-bu"] = "dodge",
["linji-zhuang"] = "force",
["liuhe-daofa"] = "blade",
["liuyang-zhang"] = "strike",
["liuye-daofa"] = "blade",
["longxiang-boruo"] = "force",
["longzhua-gong"] = "claw",
["luohan-quan"] = "cuff",
["luoying-zhang"] = "strike",
["mantian-huayu"] = "throwing",
["meinu-quanfa"] = "cuff",
["miaojia-jianfa"] = "sword",
["mohe-zhi"] = "finger",
["murong-daofa"] = "blade",
["murong-jianfa"] = "sword",
["nianhua-zhi"] = "finger",
["ningxue-shenzhao"] = "claw",
["ningxue-shenzhua"] = "claw",
["niqiu-gong"] = "dodge",
["pangen-fu"] = "axe",
--["pixie-jian"] = "sword",
["piaomiao-shenfa"] = "dodge",
["piaoyi-bu"] = "dodge",
["piaoyi-shenfa"] = "dodge",
["pinxu-lingfeng"] = "dodge",
["pomopima-jian"] = "sword",
["poyu-quan"] = "cuff",
["qiantian-yiyang"] = "force",
["qianye-shou"] = "hand",
["qianzhu-wandushou"] = "hand",
["qingyan-zhang"] = "strike",
["qingxin-jian"] = "sword",
["qishang-quan"] = "cuff",
["qixian-wuxingjian"] = "sword",
["quanzhen-jianfa"] = "sword",
["ranmu-daofa"] = "blade",
["riyue-bian"] = "whip",
["ruyi-dao"] = "blade",
["ruying-suixingtui"] = "leg",
["sanhua-zhang"] = "strike",
["sanyin-zhua"] = "claw",
["shaolin-shenfa"] = "dodge",
["shaolin-tantui"] = "leg",
["shenghuo-lingfa"] = "dagger",
["shenghuo-shengong"] = "force",
["shenlong-tuifa"] = "leg",
["shenxing-baibian"] = "dodge",
["shenyuan-gong"] = "force",
["shenzhao-jing"] = "force",
["shexing-diaoshou"] = "hand",
["shuishangpiao"] = "dodge",
["sixiang-zhang"] = "strike",
["songshan-jian"] = "sword",
["songshan-qigong"] = "force",
["songyang-bian"] = "whip",
["songyang-shou"] = "hand",
["songyang-zhang"] = "strike",
["suibo-zhuliu"] = "dodge",
["suohou-shou"] = "hand",
["taiji-jian"] = "sword",
["taiji-quan"] = "cuff",
["taiji-shengong"] = "force",
["taishan-jianfa"] = "sword",
["taixuan-gong"] = "strike",
["taizu-quan"] = "cuff",
["tangshi-jianfa"] = "sword",
["tanzhi-shentong"] = "finger",
["taxue-wuhen"] = "dodge",
["tenglong-bifa"] = "dagger",
["tianmo-dao"] = "blade",
["tianmo-gong"] = "force",
["tianmo-gun"] = "club",
["tianmo-jian"] = "sword",
["tianmo-shou"] = "hand",
["tianmo-zhang"] = "strike",
["tiangang-zhang"] = "strike",
["tianlong-xiang"] = "dodge",
["tianluo-diwang"] = "hand",
["tianshan-zhang"] = "staff",
["tianwang-zhua"] = "claw",
["tianyu-qijian"] = "sword",
["tiezhang-zhangfa"] = "strike",
["tiyunzong"] = "dodge",
["weituo-chu"] = "club",
["weituo-zhang"] = "strike",
["wudang-mianzhang"] = "strike",
["wudu-yanluobu"] = "dodge",
["wuhu-duanmendao"] = "blade",
["wuxiang-zhi"] = "finger",
["wuyue-jianfa"] = "sword",
["xiangfu-lun"] = "hammer",
["xianglong-zhang"] = "strike",
["xiangmo-chu"] = "hammer",
["xiantian-gong"] = "force",
["xiaohun-zhang"] = "strike",
["xiaoyaoyou"] = "dodge",
["xiaoyao-jian"] = "sword",
["xingyi-zhang"] = "strike",
["xiuluo-dao"] = "blade",
["xixing-dafa"] = "force",
["xuanfeng-tui"] = "leg",
["xuangong-quan"] = "cuff",
["xuanming-shenzhang"] = "strike",
["xuantian-wuji"] = "force",
["xuantian-zhi"] = "finger",
["xuantie-jianfa"] = "sword",
["xuanxu-daofa"] = "blade",
["xuanyin-jian"] = "sword",
["xuedao-jing"] = "blade",
["xunlei-jian"] = "sword",
["yangjia-qiang"] = "spear",
["yanling-shenfa"] = "dodge",
["yanxing-daofa"] = "blade",
["yijin-jing"] = "force",
["yingou-bifa"] = "brush",
["yinlong-bian"] = "whip",
["yingshe-shengsibo"] = "claw",
["yinsuo-jinling"] = "whip",
["yitian-tulong"] = "sword",
["yiyang-zhi"] = "finger",
["yizhi-chan"] = "finger",
["yinyun-ziqi"] = "force",
["youlong-bian"] = "whip",
["youlong-shenfa"] = "dodge",
["youming-zhao"] = "claw",
["yuanyang-lianhuantui"] = "leg",
["yuenu-jian"] = "sword",
["yueying-wubu"] = "dodge",
["yunu-jianfa"] = "sword",
["yunu-xinjing"] = "force",
["yunu-shenfa"] = "dodge",
["yuxiao-jian"] = "sword",
["yuxue-dunxing"] = "dodge",
["zhaixingshu"] = "dodge",
["zhemei-shou"] = "hand",
["zhenshan-mianzhang"] = "strike",
["zhentian-quan"] = "cuff",
["zhong-qiang"] = "spear",
["zhongyuefeng"] = "dodge",
["zhuihun-gou"] = "hook",
["zhusha-zhang"] = "strike",
["zixia-gong"] = "force",
["zuibaxian"] = "dodge",
["zui-gun"] = "club",
}

skillsEnable={
["anying-fuxiang"] = "dodge",
["anran-zhang"] = "strike",
["baduan-jin"] = "force",
["bahuang-gong"] = "force",
["baihua-cuoquan"] = "cuff",
["banruo-zhang"] = "strike",
["beiming-shengong"] = "force",
["bihai-chaosheng"] = "force",
["bizhen-qingzhang"] = "strike",
["canglang-goufa"] = "hook",
["canhe-zhi"] = "finger",
["cansi-shou"] = "hand",
["caoshang-fei"] = "dodge",
["chongling-jian"] = "sword",
["chousui-zhang"] = "strike",
["chuanyun-tui"] = "leg",
["cihang-bian"] = "whip",
["cibei-dao"] = "blade",
["cuixin-zhang"] = "strike",
["cuogu-shou"] = "hand",
["dafumo-quan"] = "cuff",
["dagou-bang"] = "stick",
["damo-jian"] = "sword",
["dashou-yin"] = "hand",
["ding-dodge"] = "dodge",
["duanjia-jianfa"] = "sword",
["duanjia-quan"] = "cuff",
["dugu-jiujian"] = "sword",
["dulong-dafa"] = "force",
["duoming-jinhua"] = "throwing",
["fanliangyi-dao"] = "blade",
["fengmo-zhang"] = "staff",
["fengyun-shou"] = "hand",
["fuhu-quan"] = "cuff",
["fumo-jian"] = "sword",
["fuqin-shi"] = "whip",
["furong-jinzhen"] = "throwing",
["guiyuan-tunafa"] = "force",
["hamabu"] = "dodge",
["hamagong"] = "force",
["hanbing-mianzhang"] = "strike",
["hanbing-shenzhang"] = "strike",
["hanbing-zhenqi"] = "force",
["haotian-zhang"] = "strike",
["hansha-sheying"] = "throwing",
["hengshan-jian"] = "sword",
["hengshan-jianfa"] = "sword",
["henshan-jianfa"] = "sword",
["huagong-dafa"] = "force",
["huagu-mianzhang"] = "strike",
["huanmo-wubu"] = "dodge",
["huanmo-longtianwu"] = "dodge",
["huanyin-zhi"] = "finger",
["huashan-jianfa"] = "sword",
["huashan-qigong"] = "force",
["huashan-shenfa"] = "dodge",
["huifeng-bian"] = "whip",
["huifeng-jian"] = "sword",
["hujia-daofa"] = "blade",
["huntian-qigong"] = "force",
["hunyuan-zhang"] = "strike",
["huoyan-dao"] = "strike",
["huyan-qiang"] = "spear",
["jieshou-jiushi"] = "hand",
["jimie-zhua"] = "claw",
["jindao-heijian"] = "sword,blade",
["jingang-quan"] = "cuff",
["jinshe-jianfa"] = "sword",
["jinshe-zhangfa"] = "strike",
["jinshe-zhuifa"] = "throwing",
["jinwu-daofa"] = "blade",
["jinyan-gong"] = "dodge",
["jiuyang-shengong"] = "force",
["jiuyin-baiguzhua"] = "claw",
["jiuyin-shenfa"] = function () if skills["jiuyin-shenfa"] and skills["jiuyin-shenfa"].lvl>220 then retrun "dodge" else return false end end,
["jiuyin-shenzhang"] = "strike",
["jiuyin-shenzhua"] = "claw",
["jiuyin-zhengong"] = function () if skills["jiuyin-zhengong"] and skills["jiuyin-zhengong"].lvl>220 then retrun "force" else return false end end,
["juehu-shou"] = "hand",
["kaishan-fu"] = "axe",
["kaishan-zhang"] = "strike",
["kongming-quan"] = "cuff",
["kuaihuo-zhang"] = "strike",
["kuihua-feiying"] = "dodge",
["kuihua-mogong"] = "force",
["kuihua-shengong"] = "force",
["kunlun-zhang"] = "strike",
["kurong-changong"] = "force",
["lanhua-shou"] = "hand",
["lengquan-shengong"] = "force",
["liangyi-jian"] = "sword",
["lianhua-zhang"] = "strike",
["lietian-fu"] = "axe",
["liehuo-jian"] = "sword",
["lieyan-dao"] = "blade",
["lingbo-weibu"] = "dodge",
["lingshe-bianfa"] = "whip",
["lingshe-quanfa"] = "cuff",
["lingxu-bu"] = "dodge",
["linji-zhuang"] = "force",
["liuhe-daofa"] = "blade",
["liuyang-zhang"] = "strike",
["liuye-daofa"] = "blade",
["longxiang-boruo"] = "force",
["longzhua-gong"] = "claw",
["luohan-quan"] = "cuff",
["luoying-zhang"] = "strike",
--["luoying-zhang"] = "sword,strike",
["mantian-huayu"] = "throwing",
["meinu-quanfa"] = "cuff",
["miaojia-jianfa"] = "sword",
["mohe-zhi"] = "finger",
["murong-daofa"] = "blade",
["murong-jianfa"] = "sword",
["nianhua-zhi"] = "finger",
["ningxue-shenzhao"] = "claw",
["ningxue-shenzhua"] = "claw",
["niqiu-gong"] = "dodge",
["pangen-fu"] = "axe",
["pixie-jian"] = function () if skills["pixie-jian"] and skills["pixie-jian"].lvl>220 then retrun "dodge,sword" else return false end end,
["piaomiao-shenfa"] = "dodge",
["piaoyi-bu"] = "dodge",
["piaoyi-shenfa"] = "dodge",
["pinxu-lingfeng"] = "dodge",
["pomopima-jian"] = "sword",
["poyu-quan"] = "cuff",
["qiantian-yiyang"] = "force",
["qianye-shou"] = "hand",
["qianzhu-wandushou"] = "hand",
["qingyan-zhang"] = "strike",
["qingxin-jian"] = "sword",
["qishang-quan"] = "cuff",
["qixian-wuxingjian"] = "sword",
["quanzhen-jianfa"] = "sword",
["ranmu-daofa"] = "blade",
["riyue-bian"] = "whip",
["ruyi-dao"] = "blade",
["ruying-suixingtui"] = "leg",
["sanhua-zhang"] = "strike",
["sanyin-zhua"] = "claw",
["shaolin-shenfa"] = "dodge",
["shaolin-tantui"] = "leg",
["shenghuo-lingfa"] = "dagger",
["shenghuo-shengong"] = "force",
["shenlong-tuifa"] = "leg",
["shenxing-baibian"] = "dodge",
["shenyuan-gong"] = "force",
["shenzhao-jing"] = "force",
["shexing-diaoshou"] = "hand",
["shuishangpiao"] = "dodge",
["sixiang-zhang"] = "strike",
["songshan-jian"] = "sword",
["songshan-qigong"] = "force",
["songyang-bian"] = "whip",
["songyang-shou"] = "hand",
["songyang-zhang"] = "strike",
["suibo-zhuliu"] = "dodge",
["suohou-shou"] = "hand",
["taiji-jian"] = "sword",
["taiji-quan"] = "cuff",
["taiji-shengong"] = "force",
["taishan-jianfa"] = "sword",
["taixuan-gong"] = "strike",
["taizu-quan"] = "cuff",
["tangshi-jianfa"] = "sword",
["tanzhi-shentong"] = "finger,throwing",
["taxue-wuhen"] = "dodge",
["tenglong-bifa"] = "dagger",
["tianmo-dao"] = "blade",
["tianmo-gong"] = "force",
["tianmo-gun"] = "club",
["tianmo-jian"] = "sword",
["tianmo-shou"] = "hand",
["tianmo-zhang"] = "strike",
["tiangang-zhang"] = "strike",
["tianlong-xiang"] = "dodge",
["tianluo-diwang"] = "hand",
["tianshan-zhang"] = "staff",
["tianwang-zhua"] = "claw",
["tianyu-qijian"] = "sword",
["tiezhang-zhangfa"] = "strike",
["tiyunzong"] = "dodge",
["weituo-chu"] = "club",
["weituo-zhang"] = "strike",
["wudang-mianzhang"] = "strike",
["wudu-yanluobu"] = "dodge",
["wuhu-duanmendao"] = "blade",
["wuxiang-zhi"] = "finger",
["wuyue-jianfa"] = "sword",
["xiangfu-lun"] = "hammer",
["xianglong-zhang"] = "strike",
["xiangmo-chu"] = "hammer",
["xiantian-gong"] = "force",
["xiaohun-zhang"] = "strike",
["xiaoyaoyou"] = "dodge",
["xiaoyao-jian"] = "sword",
["xingyi-zhang"] = "strike",
["xiuluo-dao"] = "blade",
["xixing-dafa"] = "force",
["xuanfeng-tui"] = "leg",
["xuangong-quan"] = "cuff",
["xuanming-shenzhang"] = "strike",
["xuantian-wuji"] = "force",
["xuantian-zhi"] = "finger",
["xuantie-jianfa"] = "sword",
["xuanxu-daofa"] = "blade",
["xuanyin-jian"] = "sword",
["xuedao-jing"] = "blade",
["xunlei-jian"] = "sword",
["yangjia-qiang"] = "spear",
["yanling-shenfa"] = "dodge",
["yanxing-daofa"] = "blade",
["yijin-jing"] = "force",
["yingou-bifa"] = "brush",
["yinlong-bian"] = "whip",
["yingshe-shengsibo"] = "claw,hand",
["yinsuo-jinling"] = "whip",
["yitian-tulong"] = "sword",
["yiyang-zhi"] = "finger",
["yizhi-chan"] = "finger",
["yinyun-ziqi"] = "force",
["youlong-bian"] = "whip",
["youlong-shenfa"] = "dodge",
["youming-zhao"] = "claw",
["yuanyang-lianhuantui"] = "leg",
["yuenu-jian"] = "sword",
["yueying-wubu"] = "dodge",
["yunu-jianfa"] = "sword",
["yunu-xinjing"] = "force",
["yunu-shenfa"] = "dodge",
["yuxiao-jian"] = "sword",
["yuxue-dunxing"] = "dodge",
["zhaixingshu"] = "dodge",
["zhemei-shou"] = "hand",
["zhenshan-mianzhang"] = "strike",
["zhentian-quan"] = "cuff",
["zhong-qiang"] = "spear",
["zhongyuefeng"] = "dodge",
["zhuihun-gou"] = "hook",
["zhusha-zhang"] = "strike",
["zixia-gong"] = "force",
["zuibaxian"] = "dodge",
["zui-gun"] = "club",
}

skillHubei={
  ["longzhua-gong"] = "yizhi-chan",
  ["yizhi-chan"] =  "longzhua-gong",
  ["jingang-quan"] = "banruo-zhang",
  ["banruo-zhang"] = "jingan-quan",
  ["ruiying-suixingtui"] = "qianye-shou",
  ["qianye-shou"] = "ruying-suixingtui",
  ["sanhua-zhang"] = "nianhua-zhi",
  ["nianhua-zhi"] = "sanhua-zhang",
  ["xuanfeng-tui"] = "luoying-zhang",
  ["luoying-zhang"] = "xuanfeng-tui",
  ["wuxiang-zhi"] = "luohan-quan",
  ["luohan-quan"] = "wuxiang-zhi",
 }

skillPrepare={
  ["suibo-zhuliu"] = function() if skills["suibo-zhuliu"] and not skills["niqiu-gong"] and not skills["lingbo-weibu"] and skills["suibo-zhuliu"].lvl>250 then return "enable dodge suibo-zhuliu;perform dodge.wuzhuan ".. score.id else return false end end, 
  ["tiyunzong"] = function() if skills["tiyunzong"] and not skills["niqiu-gong"] and not skills["lingbo-weibu"] and skills["tiyunzong"].lvl>250 then return "enable dodge tiyunzong;perform dodge.zong ".. score.id else return false end end,
  ["shuishangpiao"] = function() if skills["shuishangpiao"] and not skills["niqiu-gong"] and not skills["lingbo-weibu"] and skills["shuishangpiao"].lvl>250 then return "enable dodge shuishangpiao;perform dodge.piao ".. score.id else return false end end,
  ["bihai-chaosheng"] = function() if skills["bihai-chaosheng"] and perform.force and perform.force=="bihai-chaosheng" then return "yun qimen" else return false end end,
  ["beiming-shengong"] = function() if skills["beiming-shengong"] and perform.force and perform.force=="beiming-shengong" then return "yun beiming" else return false end end,
  ["hanbing-zhenqi"] = function() if skills["hanbing-zhenqi"] and perform.force and perform.force=="hanbing-zhenqi" then return "yun huti" else return false end end,
  ["yijin-jing"] = function() if skills["yijin-jing"] and perform.force and perform.force=="yijin-jing" then return "yun powerup" else return false end end,
  ["niqiu-gong"] = function() if skills["niqiu-gong"] and not skills["lingbo-weibu"] and skills["niqiu-gong"].lvl>250 then return "enable dodge niqiu-gong" else return false end end,
  ["lingbo-weibu"] = function() if skills["lingbo-weibu"] then return "enable dodge lingbo-weibu;perform dodge.luoshen ".. score.id else return false end end,
  ["lengquan-shengong"] = function() if skills["lengquan-shengong"] and perform.force and perform.force=="lengquan-shengong" then return "yun lengquan" else return false end end,
}

skillsAddInt = {
  ["linji-zhuang"] = "yun zhixin",
  ["bihai-chaosheng"] = "yun qimen",
  ["yunu-xinjing"] = "yun xinjing",
}