--[[
    UI的文本描述

    TODO: 目前加载此文件的时候会加载所有语言内容, 如果有需要可以在使用的地方逐个加载 (直接使用languageManagerInstance:getLocalString(xxxxxx))
]]

UI = UI or {}

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
-- 当前登录人数过多,请继续尝试
UI.LOGIN_ERROR_SYSTEM_BUSY = languageManagerInstance:getLocalString(1111473)

UI.TEXT_DES_GOT_TITLE = languageManagerInstance:getLocalString(1111432)
-- "可用格子"
UI.TEXT_DES_GRID_COUNT = languageManagerInstance:getLocalString(1110001)
-- "等级 %d"
UI.TEXT_DES_LEVEL = languageManagerInstance:getLocalString(1110002)
-- "角色"
UI.TEXT_DES_ROLE = languageManagerInstance:getLocalString(1110003)
-- "任务"
UI.TEXT_DES_TASK = languageManagerInstance:getLocalString(1110004)
-- "技能"
UI.TEXT_DES_SKILL = languageManagerInstance:getLocalString(1110005)
-- "日志"
UI.TEXT_DES_LOG = languageManagerInstance:getLocalString(1110006)
-- "画册"
UI.TEXT_PICTURE_ALBUM = languageManagerInstance:getLocalString(1113975)
--天赋
UI.TEXT_DES_TALENT = languageManagerInstance:getLocalString(1111607)
-- "设置"
UI.TEXT_DES_SETTING = languageManagerInstance:getLocalString(1110007)
-- "点击选择一个单元格"
UI.TEXT_DES_USE_SPADE_TIP = languageManagerInstance:getLocalString(1110008)
-- "负重"
UI.TEXT_DES_WEIGHT = languageManagerInstance:getLocalString(1110009)
-- "魔力:"
UI.TEXT_DES_MAGIC = languageManagerInstance:getLocalString(1110010)
-- "格挡值:"
UI.TEXT_DES_BLOAK = languageManagerInstance:getLocalString(1110011)
-- "格挡等级:"
UI.TEXT_DES_BLOAK_LEVEL = languageManagerInstance:getLocalString(1110012)
-- "护甲穿透:"
UI.TEXT_DES_PENETRATE = languageManagerInstance:getLocalString(1110013)
-- "魔法穿透:"
UI.TEXT_DES_MAGIC_PENETRATE = languageManagerInstance:getLocalString(1110014)
-- "闪避等级:"
UI.TEXT_DES_DODGE = languageManagerInstance:getLocalString(1110015)
-- "暴击等级:"
UI.TEXT_DES_CRITICAL = languageManagerInstance:getLocalString(1110016)
-- "暴击伤害:"
UI.TEXT_DES_CRITICAL_DAMAGE = languageManagerInstance:getLocalString(1110017)
-- "幸运:"
UI.TEXT_DES_LUCK = languageManagerInstance:getLocalString(1110018)
-- "弱点"
UI.TEXT_DES_WEAK = languageManagerInstance:getLocalString(1110019)
-- "攻击强度"
UI.TEXT_DES_ATTACK_STRENGTH = languageManagerInstance:getLocalString(1110020)
-- "法力效果"
UI.TEXT_DES_MAGIC_STRENGTH  = languageManagerInstance:getLocalString(1110021)
-- "坚韧"
UI.TEXT_DES_TENACITY_STRENGTH = languageManagerInstance:getLocalString(1110022)
-- "等级需求:"
UI.TEXT_DES_LEVEL_NEED = languageManagerInstance:getLocalString(1110023)
-- "装备后的差异"
UI.TEXT_DES_EQUIPMENT_CONTRAST = languageManagerInstance:getLocalString(1110024)
-- "是否进入下一层？"
UI.TEXT_DES_DOWN_STAIRS = languageManagerInstance:getLocalString(1110025)
-- "是否使用回城卷轴返回城镇"
UI.TEXT_DES_BACK_TOWN = languageManagerInstance:getLocalString(1110026)
-- "%s层"
UI.TEXT_DES_MINI_MAP_LEVEL = languageManagerInstance:getLocalString(1110027)
-- "战利品\n（安全回程获得）"
UI.TEXT_DES_SBOLIS_TITLE = languageManagerInstance:getLocalString(1110028)
-- "战利品"
UI.TEXT_DES_SBOLIS = languageManagerInstance:getLocalString(1110029)
-- "图鉴"
UI.TEXT_DES_PICTURE = languageManagerInstance:getLocalString(1110030)
-- " 数据"
UI.TEXT_DES_FUNNNY = languageManagerInstance:getLocalString(1111018)

-- "第%d层"
UI.TEXT_110001 = languageManagerInstance:getLocalString(1110031)
-- "普通"
UI.TEXT_110002 = languageManagerInstance:getLocalString(1110032)
-- "噩梦"
UI.TEXT_110003 = languageManagerInstance:getLocalString(1110033)
-- "地狱"
UI.TEXT_110004 = languageManagerInstance:getLocalString(1110034)
-- "我是普通"
UI.TEXT_110005 = languageManagerInstance:getLocalString(1110035)
-- "我是噩梦"
UI.TEXT_110006 = languageManagerInstance:getLocalString(1110036)
-- "我是地狱"
UI.TEXT_110007 = languageManagerInstance:getLocalString(1110037)
-- "我是普通,普通经验奖励"
UI.TEXT_110008 = languageManagerInstance:getLocalString(1110038)
-- "我是噩梦,普通经验奖励"
UI.TEXT_110009 = languageManagerInstance:getLocalString(1110039)
-- "我是地狱,普通经验奖励"
UI.TEXT_110010 = languageManagerInstance:getLocalString(1110040)
-- "准备"
UI.TEXT_110011 = languageManagerInstance:getLocalString(1110041)
-- "取消"
UI.TEXT_110012 = languageManagerInstance:getLocalString(1110042)
-- "正在匹配队友"
UI.TEXT_110013 = languageManagerInstance:getLocalString(1110043)
-- "战利品"
UI.TEXT_110014 = languageManagerInstance:getLocalString(1110044)
-- "时光之门"
UI.TEXT_110101 = languageManagerInstance:getLocalString(1110045)
-- "%s模式:%d层"
UI.TEXT_110102 = languageManagerInstance:getLocalString(1110046)
-- "开始匹配"
UI.TEXT_110103 = languageManagerInstance:getLocalString(1110047)
-- 附魔
UI.TEXT_110201 = languageManagerInstance:getLocalString(1110212)
-- 点金
UI.TEXT_110202 = languageManagerInstance:getLocalString(1110213)
-- 改造
UI.TEXT_110203 = languageManagerInstance:getLocalString(1110403)
-- 请选择要改造的属性
UI.TEXT_110204 = languageManagerInstance:getLocalString(1110404)
-- 这件装备不能被改造
UI.TEXT_110205 = languageManagerInstance:getLocalString(1110405)
-- 强化成功率:%d%%
UI.TEXT_110206 = languageManagerInstance:getLocalString(1110406)
-- 强化
UI.TEXT_110207 = languageManagerInstance:getLocalString(1110407)
-- max
UI.TEXT_110208 = languageManagerInstance:getLocalString(1110408)
-- 被强化的装备达到满级
UI.TEXT_110209 = languageManagerInstance:getLocalString(1110409)
-- 金币不足
UI.TEXT_110210 = languageManagerInstance:getLocalString(1110410)
-- "获得了装备 %s"
UI.TEXT_110211 = languageManagerInstance:getLocalString(1111019)
-- "查看信息"
UI.TEXT_110015 = languageManagerInstance:getLocalString(1110048)
-- "添加好友"
UI.TEXT_110016 = languageManagerInstance:getLocalString(1110049)
-- "移出队伍"
UI.TEXT_110017 = languageManagerInstance:getLocalString(1110050)
-- "离开队伍"
UI.TEXT_110018 = languageManagerInstance:getLocalString(1110051)
-- "邀请入会"
UI.TEXT_10000  = LanguageManager:getInstance():getLocalString(1112995) --[["邀请入会"]]
-- "是否使用逃脱卷轴返回城镇"
UI.TEXT_110019 = languageManagerInstance:getLocalString(1110052)
-- "是否发起将（队员%s）移除队伍的投票
UI.TEXT_110020 = languageManagerInstance:getLocalString(1110053)
-- AvalonUtil.getIdentifier().."发起了踢出（队员"..AvalonUtil.getIdentifier().."）的投票"
UI.TEXT_110021 = languageManagerInstance:getLocalString(1110054)
-- "你由于某种原因被同伴申请离开队伍，请在倒计时结束前选择回城方式"
UI.TEXT_110022 = languageManagerInstance:getLocalString(1110055)
-- "是否使用逃脱卷轴回到城镇"
UI.TEXT_110023 = languageManagerInstance:getLocalString(1110056)
-- 确定离开队伍
UI.TEXT_110024 = languageManagerInstance:getLocalString(1110363)
-- 离开洞窟
UI.TEXT_110025 = languageManagerInstance:getLocalString(1110487)
-- 离开洞窟
UI.TEXT_110026 = languageManagerInstance:getLocalString(1110488)
-- "使用逃脱卷轴"
UI.TEXT_110027 = languageManagerInstance:getLocalString(1110489)
-- "直接回城"
UI.TEXT_110028 = languageManagerInstance:getLocalString(1110490)
-- "改变造型"
UI.TEXT_110029 = languageManagerInstance:getLocalString(1110491)
-- "锁定的物品不能作为素材"
UI.TEXT_110030 = languageManagerInstance:getLocalString(1170121)--(1110492)
-- 是否花费%d水晶解锁%d格仓库?
UI.TEXT_110031 = languageManagerInstance:getLocalString(1110493)
-- "仓库格子已达最大"
UI.TEXT_110032 = languageManagerInstance:getLocalString(1110494)
-- 仓库剩余空间不足！是否花费%d水晶解锁%d格仓库？
UI.TEXT_110033 = languageManagerInstance:getLocalString(1110495)
-- 层数
UI.TEXT_110034 = languageManagerInstance:getLocalString(1110496)
-- 回收
UI.TEXT_110035 = languageManagerInstance:getLocalString(1110532)
-- 放弃
UI.TEXT_110036 = languageManagerInstance:getLocalString(1110533)
-- 背包已满
UI.TEXT_110037 = languageManagerInstance:getLocalString(1110396)
-- (被动)
UI.TEXT_110038 = languageManagerInstance:getLocalString(1110535)
-- (主动)
UI.TEXT_110039 = languageManagerInstance:getLocalString(1110536)
-- Lv.
UI.TEXT_110040 = languageManagerInstance:getLocalString(1110537)
-- 大秘境中不能学习技能
UI.TEXT_110041 = languageManagerInstance:getLocalString(1110538)
-- 未解锁大秘境
UI.TEXT_110042 = languageManagerInstance:getLocalString(1110540)
-- 大秘境处于休赛期
UI.TEXT_110043 = languageManagerInstance:getLocalString(1110541)
-- 排行
UI.TEXT_110044 = languageManagerInstance:getLocalString(1110542)
-- 玩家昵称
UI.TEXT_110045 = languageManagerInstance:getLocalString(1110543)
-- 等级
UI.TEXT_110046 = languageManagerInstance:getLocalString(1110544)
-- 排行榜
UI.TEXT_110047 = languageManagerInstance:getLocalString(1110534)
-- 装备
UI.TEXT_110048 = languageManagerInstance:getLocalString(1110545)
-- 成就
UI.TEXT_110049 = languageManagerInstance:getLocalString(1110546)
-- 公会
UI.TEXT_110050 = languageManagerInstance:getLocalString(1110547)
-- %s不同意踢人
UI.TEXT_110051 = languageManagerInstance:getLocalString(1110548)
-- 装备等级
UI.TEXT_110052 = languageManagerInstance:getLocalString(1110549)
-- 贡献度
UI.TEXT_110053 = languageManagerInstance:getLocalString(1110550)
-- 大秘境排行榜
UI.TEXT_110054 = languageManagerInstance:getLocalString(1110531)
-- 楼层(时间)
UI.TEXT_110055 = languageManagerInstance:getLocalString(1110552)
-- 大秘境中不能重置技能
UI.TEXT_110056 = languageManagerInstance:getLocalString(1110539)
-- 补给包
UI.TEXT_110061 = languageManagerInstance:getLocalString(1110567)
-- 探照灯
UI.TEXT_110062 = languageManagerInstance:getLocalString(1110568)
-- 炼金手套
UI.TEXT_110063 = languageManagerInstance:getLocalString(1110569)
-- 倒计时结束:副本已关闭
UI.TEXT_110064 = languageManagerInstance:getLocalString(1110664)
-- 离副本关闭还有:%s
UI.TEXT_110065 = languageManagerInstance:getLocalString(1110665)
-- 离副本关闭还有:%d:%d
UI.TEXT_110066 = languageManagerInstance:getLocalString(1110666)
-- 勋章不足
UI.TEXT_110067 = languageManagerInstance:getLocalString(1110694)
-- 请加入公会
UI.TEXT_110068 = languageManagerInstance:getLocalString(1110668)
-- 贡献不足
UI.TEXT_110069 = languageManagerInstance:getLocalString(1110698)
-- 科技等级不足
UI.TEXT_110070 = languageManagerInstance:getLocalString(1110699)
-- "大秘境%d层"
UI.TEXT_110071 = languageManagerInstance:getLocalString(1110671)
-- 由于不准备次数过多,必须%d分钟以后才能再次进行多人游戏
UI.TEXT_110072 = languageManagerInstance:getLocalString(1110672)
-- %d层 %s
UI.TEXT_110073 = languageManagerInstance:getLocalString(1110673)
--捐献
UI.TEXT_110074 = languageManagerInstance:getLocalString(1110674)
--未进行大秘境
UI.TEXT_110075 = languageManagerInstance:getLocalString(1110682)
--玩家%s邀请你参加%s %s %s 层的冒险
UI.TEXT_110076 =  languageManagerInstance:getLocalString(1110683)
--玩家%s邀请你参加%s %s 层的冒险
UI.TEXT_110077 = languageManagerInstance:getLocalString(1110684)
--非该公会成员无法使用此服务
UI.TEXT_1110687 = languageManagerInstance:getLocalString(1110687)
--"%d级解锁"
UI.TEXT_1110688 = languageManagerInstance:getLocalString(1111213)
--"玩家%s邀请你参加 %s:%s 的冒险"
UI.TEXT_1110689 = languageManagerInstance:getLocalString(1111342) 
--好友
UI.TEXT_110078 = languageManagerInstance:getLocalString(1110739)
--公会
UI.TEXT_110079 = languageManagerInstance:getLocalString(1110740)
--已发送邀请
UI.TEXT_110080 = languageManagerInstance:getLocalString(1110741)
--已加入
UI.TEXT_110081 = languageManagerInstance:getLocalString(1110742)
--本赛季时间：规则：秘境排行榜每个赛季重置一次。\n以探索更多楼层同时花费时间更少为评分标准，实时刷新。\n当获得了更好的大秘境成绩时，将更新自己在服务器上的最好成就。\n大秘境榜单仅显示本服务器前200名玩家。
UI.TEXT_110082 = languageManagerInstance:getLocalString(1110703)
--休赛中。新赛季开启时间请以官方公告为准
UI.TEXT_110083 = languageManagerInstance:getLocalString(1110704)
--"规则：装备榜单以玩家历史装备总分为排序标准。\n当玩家任意部位装备的评分提升时，将更新自己的最高装备评分。\n相同装备总分玩家，更早获得此评分的玩家排序在前。\n仅显示本服务器前200名玩家。"
UI.TEXT_110084 = languageManagerInstance:getLocalString(1110705)
--规则：成就榜单以成就总分为排序标准。\n获得新成就时，将更新自己的总成就得分。\n相同成就总分玩家，更早获得此评分的玩家排序在前。\n仅显示本服务器前200名玩家。
UI.TEXT_110085 = languageManagerInstance:getLocalString(1110706)
--规则：公会榜单每周1零点重置。\n公会榜单以公会贡献度总分为排序标准。\n公会任意成员贡献了贡献度时，将更新公会的总贡献度。相同贡献度的多个公会，更早获得此贡献度的公会排序在前。\n仅显示本服务器前200名的公会。
UI.TEXT_110087 = languageManagerInstance:getLocalString(1110707)
--当前榜单无数据
UI.TEXT_110088 = languageManagerInstance:getLocalString(1110743)
--新赛季即将开始，请拭目以待。
UI.TEXT_110089 = languageManagerInstance:getLocalString(1110744)
--皮肤1
UI.TEXT_110090 = languageManagerInstance:getLocalString(1110745)
--皮肤2
UI.TEXT_110091 = languageManagerInstance:getLocalString(1110746)
--皮肤3
UI.TEXT_110092 = languageManagerInstance:getLocalString(1110747)
--随机
UI.TEXT_110094 = languageManagerInstance:getLocalString(1110748)
--开始冒险
UI.TEXT_110095 = languageManagerInstance:getLocalString(1110749)
--勇敢的冒险者,你的名字是
UI.TEXT_110096 = languageManagerInstance:getLocalString(1110750)
--%s拒绝了你的邀请
UI.TEXT_110097 = languageManagerInstance:getLocalString(1110751)
--你加入了%s的队伍
UI.TEXT_110098 = languageManagerInstance:getLocalString(1110752)
--%s加入了队伍
UI.TEXT_110099 = languageManagerInstance:getLocalString(1110753)
--你退出了队伍
UI.TEXT_111101 = languageManagerInstance:getLocalString(1110754)
--%s退出了队伍
UI.TEXT_111102 = languageManagerInstance:getLocalString(1110755)
--你被踢出了队伍
UI.TEXT_111103 = languageManagerInstance:getLocalString(1110756)
--%s被踢出了队伍
UI.TEXT_111104 = languageManagerInstance:getLocalString(1110757)
--%s取消了本次冒险匹配
UI.TEXT_111105 = languageManagerInstance:getLocalString(1110758)
--队伍已满
UI.TEXT_111106 = languageManagerInstance:getLocalString(1110759)
--%s离线了,请等待他上线
UI.TEXT_111107 = languageManagerInstance:getLocalString(1110760)
--你没有准备好,已经离开了队伍
UI.TEXT_111108 = languageManagerInstance:getLocalString(1110761)
--请输入你的名字
UI.TEXT_111109 = languageManagerInstance:getLocalString(1110762)
--音乐
UI.TEXT_111110 = languageManagerInstance:getLocalString(1110763)
--音效
UI.TEXT_111111 = languageManagerInstance:getLocalString(1110764)
--屏蔽聊天
UI.TEXT_111112 = languageManagerInstance:getLocalString(1110765)
--开
UI.TEXT_111113 = languageManagerInstance:getLocalString(1110766)
--关
UI.TEXT_111114 = languageManagerInstance:getLocalString(1110767)
--显示头盔
UI.TEXT_111115 = languageManagerInstance:getLocalString(1110768)
--移动方式
UI.TEXT_111116 = languageManagerInstance:getLocalString(1110769)
--方向键
UI.TEXT_111117 = languageManagerInstance:getLocalString(1110770)
--点击
UI.TEXT_111118 = languageManagerInstance:getLocalString(1110771)
--语言
UI.TEXT_111119 = languageManagerInstance:getLocalString(1110772)
--血量显示
UI.TEXT_111120 = languageManagerInstance:getLocalString(1110773)
--无
UI.TEXT_111121 = languageManagerInstance:getLocalString(1110774)
--百分比
UI.TEXT_111122 = languageManagerInstance:getLocalString(1110775)
--数字
UI.TEXT_111123 = languageManagerInstance:getLocalString(1110776)
--退出登录
UI.TEXT_111124 = languageManagerInstance:getLocalString(1110777)
--确定要退出登录吗?
UI.TEXT_111125 = languageManagerInstance:getLocalString(1110778)
--绑定账号(能让你在多台设备上进行游戏)
UI.TEXT_111126 = languageManagerInstance:getLocalString(1110779)
--当前账号有%s,等级%d,是否登录该账号
UI.TEXT_111127 = languageManagerInstance:getLocalString(1110780)
--你确定将语言切换至%s吗?
UI.TEXT_111128 = languageManagerInstance:getLocalString(1110782)
--你隐藏了自己的头盔
UI.TEXT_111129 = languageManagerInstance:getLocalString(1110794)
--你显示了自己的头盔
UI.TEXT_111130 = languageManagerInstance:getLocalString(1110795)
--移动方式更改为方向键移动
UI.TEXT_111131 = languageManagerInstance:getLocalString(1110796)
--移动方式更改为点击地面移动
UI.TEXT_111132 = languageManagerInstance:getLocalString(1110797)
--现在不会接收到聊天消息
UI.TEXT_111133 = languageManagerInstance:getLocalString(1110798)
--现在可以接收到聊天消息
UI.TEXT_111134 = languageManagerInstance:getLocalString(1110799)
--已关闭血量显示
UI.TEXT_111135 = languageManagerInstance:getLocalString(1110800)
--血量显示方式更改为百分比
UI.TEXT_111136 = languageManagerInstance:getLocalString(1110801)
--血量显示方式更改为数字
UI.TEXT_111137 = languageManagerInstance:getLocalString(1110802)
--服务器
UI.TEXT_111138 = languageManagerInstance:getLocalString(1110803)
--你确定要离开该地图吗？（本次探险进度将会丢失）
UI.TEXT_111139 = languageManagerInstance:getLocalString(1110804)
--你确定要离开该地图吗
UI.TEXT_111140 = languageManagerInstance:getLocalString(1110805)
--不满足匹配条件
UI.TEXT_120001 = languageManagerInstance:getLocalString(1110806)
-- 确定绑定账号吗
UI.TEXT_111141 = languageManagerInstance:getLocalString(1110788)
-- 登录失败,网络错误
UI.TEXT_111142 = languageManagerInstance:getLocalString(1110783)
-- 登录失败,请稍后再试
UI.TEXT_111143 = languageManagerInstance:getLocalString(1110784)
-- 分享成功
UI.TEXT_111144 = languageManagerInstance:getLocalString(1110785)
-- 分享失败
UI.TEXT_111145 = languageManagerInstance:getLocalString(1110786)
-- 绑定账号成功
UI.TEXT_111146 = languageManagerInstance:getLocalString(1110787)
-- 你缺少必要的第三方软件
UI.TEXT_111147 = languageManagerInstance:getLocalString(1170086)
-- 登录失败,登录之后才可分享到该平台
UI.TEXT_111148 = languageManagerInstance:getLocalString(1110791)
-- 取消分享
UI.TEXT_111149 = languageManagerInstance:getLocalString(1110789)
-- 取消登录
UI.TEXT_111150 = languageManagerInstance:getLocalString(1110790)
-- 被顶号
UI.TEXT_111151 = languageManagerInstance:getLocalString(1110807)
-- 请前往系统设置登录GameCenter
UI.TEXT_111152 = languageManagerInstance:getLocalString(1110792)
-- 确定切换到%s吗
UI.TEXT_111153 = languageManagerInstance:getLocalString(1110816)
-- 不再提示
UI.TEXT_111154 = languageManagerInstance:getLocalString(1110919)
-- 你的账号还没有绑定,是否前往设置界面绑定账号
UI.TEXT_111155 = languageManagerInstance:getLocalString(1110920)
--"可能改造出的属性"
UI.TEXT_111156 = languageManagerInstance:getLocalString(1111129)
-- 绑定账号
UI.TEXT_111157 = languageManagerInstance:getLocalString(1111214)
-- 绑定失败,改第三方已有绑定账号
UI.TEXT_111158 = languageManagerInstance:getLocalString(1170178)
-- 高帧率模式
UI.TEXT_111159 = languageManagerInstance:getLocalString(1111223)
-- 帧率模式修改成功
UI.TEXT_111160 = languageManagerInstance:getLocalString(1111224)
-- 当前运行缓慢,是否切换到低帧率模式
UI.TEXT_111161 = languageManagerInstance:getLocalString(1111225)
-- 切换
UI.TEXT_111162 = languageManagerInstance:getLocalString(1111227)
-- 隐藏墙体
UI.TEXT_111163 = languageManagerInstance:getLocalString(1111485)
-- 已显示墙体
UI.TEXT_111164 = languageManagerInstance:getLocalString(1111486)
-- 已隐藏墙体
UI.TEXT_111165 = languageManagerInstance:getLocalString(1111487)
-- 在以下道具选择
UI.TEXT_111166 = languageManagerInstance:getLocalString(1111491)
-- 件获得
UI.TEXT_111167 = languageManagerInstance:getLocalString(1111492)
-- 已选择
UI.TEXT_111168 = languageManagerInstance:getLocalString(1111493)
-- 使用
UI.TEXT_111169 = languageManagerInstance:getLocalString(1111494)
-- 所选道具不足%个,无法开启
UI.TEXT_111170 = languageManagerInstance:getLocalString(1111495)
-- 背包已满,无法开启
UI.TEXT_111171 = languageManagerInstance:getLocalString(1111496)
-- 请选择正确的数量后开启
UI.TEXT_111172 = languageManagerInstance:getLocalString(1111497)
-- 请选择物品后开启
UI.TEXT_111173 = languageManagerInstance:getLocalString(1111498)
-- "解锁条件"
UI.TEXT_111001 = languageManagerInstance:getLocalString(1110057)
-- "需要解锁等级: %d"
UI.TEXT_111002 = languageManagerInstance:getLocalString(1110058)
-- "需要学习技能: %s"
UI.TEXT_111003 = languageManagerInstance:getLocalString(1110059)
-- "HP消耗: %d"
UI.TEXT_111004 = languageManagerInstance:getLocalString(1110060)
-- "MP消耗: %d"
UI.TEXT_111005 = languageManagerInstance:getLocalString(1110061)
-- "技能CD: %.1f"
UI.TEXT_111006 = languageManagerInstance:getLocalString(1110062)
-- "技能描述:"
UI.TEXT_111007 = languageManagerInstance:getLocalString(1110063)
-- "重置技能"
UI.TEXT_111008 = languageManagerInstance:getLocalString(1110064)
-- "剩余技能点:%d"
UI.TEXT_111009 = languageManagerInstance:getLocalString(1110065)
-- "下个技能点获取:%d级"
UI.TEXT_111100 = languageManagerInstance:getLocalString(1111327)
-- 成就
UI.TEXT_111010 = languageManagerInstance:getLocalString(1110142)
-- 藏宝图
UI.TEXT_111011 = languageManagerInstance:getLocalString(1110143)
-- 出售所有白色和蓝色的装备？
UI.TEXT_111012 = languageManagerInstance:getLocalString(1110144)
--花费
UI.TEXT_111013 = languageManagerInstance:getLocalString(1110146)
-- 购买
UI.TEXT_111014 = languageManagerInstance:getLocalString(1110147)
-- 不足
UI.TEXT_111015 = languageManagerInstance:getLocalString(1110148)
-- 是否到商店购买？
UI.TEXT_111016 = languageManagerInstance:getLocalString(1110149)
-- 你将获得
UI.TEXT_111017 = languageManagerInstance:getLocalString(1110145)
-- 请求过于频繁，请稍后重试
UI.TEXT_111018 = languageManagerInstance:getLocalString(1110152)
-- 道具
UI.TEXT_111019 = languageManagerInstance:getLocalString(1110151)
-- 材料
UI.TEXT_111020 = languageManagerInstance:getLocalString(1110150)
-- 已完成
UI.TEXT_111021 = languageManagerInstance:getLocalString(1110153)
-- 未完成
UI.TEXT_111022 = languageManagerInstance:getLocalString(1110154)
-- 活动
UI.TEXT_111023 = languageManagerInstance:getLocalString(1110155)
-- 剩余时间：
UI.TEXT_111024 = languageManagerInstance:getLocalString(1110156)
-- 主线
UI.TEXT_111025 = languageManagerInstance:getLocalString(1110157)
-- 每日
UI.TEXT_111026 = languageManagerInstance:getLocalString(1110158)
-- 公会
UI.TEXT_1110659 = languageManagerInstance:getLocalString(1110659)
-- 连接服务器错误，请检查你的网络连接后重试
UI.TEXT_111027 = languageManagerInstance:getLocalString(1110249)
-- 安全汇成获得
UI.TEXT_111028 = languageManagerInstance:getLocalString(1110250)
-- 跳过
UI.TEXT_111029 = languageManagerInstance:getLocalString(1110369)
-- 获得奖励
UI.TEXT_111030 = languageManagerInstance:getLocalString(1110161)
-- 返回城镇
UI.TEXT_111031 = languageManagerInstance:getLocalString(1110162)
-- / 左斜杠
UI.TEXT_111032 = languageManagerInstance:getLocalString(1110284)
-- 小时
UI.TEXT_111033 = languageManagerInstance:getLocalString(1110163)
-- 分
UI.TEXT_111034 = languageManagerInstance:getLocalString(1110164)
-- 领取
UI.TEXT_111035 = languageManagerInstance:getLocalString(1110165)
--可提交
UI.TEXT_111036 = languageManagerInstance:getLocalString(1110904)
-- 复活队友
UI.TEXT_1110370 = languageManagerInstance:getLocalString(1110370)
-- 钻石不足
UI.TEXT_1110371 = languageManagerInstance:getLocalString(1110378)
-- 未知错误
UI.TEXT_1110372 = languageManagerInstance:getLocalString(1110382)
-- "你离开了队伍，请在倒计时结束前选择回城方式"
UI.TEXT_1110373 = languageManagerInstance:getLocalString(1110379)
-- "你被同伴申请离开队伍，请在倒计时结束前选择回城方式"
UI.TEXT_1110374 = languageManagerInstance:getLocalString(1110380)
-- "你的队伍被解散，请在倒计时结束前选择回城方式"
UI.TEXT_1110375 = languageManagerInstance:getLocalString(1110381)
-- 你没有队伍不能提出踢人
UI.TEXT_1110376 = languageManagerInstance:getLocalString(1110384)
-- 大于2人才能踢人
UI.TEXT_1110377 = languageManagerInstance:getLocalString(1110385)
-- 匹配失败
UI.TEXT_1110378 = languageManagerInstance:getLocalString(1110386)
-- 匹配失败
UI.TEXT_1110379 = languageManagerInstance:getLocalString(1110387)
-- 踢人失败
UI.TEXT_1110380 = languageManagerInstance:getLocalString(1110388)

--队伍中有人离线
UI.TEXT_1110381 = languageManagerInstance:getLocalString(1110390)
--踢人失败后%d分钟内不能重复踢人
UI.TEXT_1110382 = languageManagerInstance:getLocalString(1110389)
-- 线索TEXT_1110383
UI.TEXT_1110383 = languageManagerInstance:getLocalString(1110393)
--是否进入下一层地下城
UI.TEXT_1110384 = languageManagerInstance:getLocalString(1110398)
--有队友正在战斗中,不能让他分心
UI.TEXT_1110385 = languageManagerInstance:getLocalString(1110399)
--必须先复活才能投票
UI.TEXT_1110386 = languageManagerInstance:getLocalString(1110400)
--还有陌生人在队伍中，无法进入下一层
UI.TEXT_1110387 = languageManagerInstance:getLocalString(1110401)
--还有队友没有准备好
UI.TEXT_1110388 = languageManagerInstance:getLocalString(1110402)
-- 背包已满
UI.TEXT_1110501 = languageManagerInstance:getLocalString(1110396)
-- 碎片
UI.TEXT_1110502 = languageManagerInstance:getLocalString(1110397)
-- 残破的碎片
UI.TEXT_1110503 = languageManagerInstance:getLocalString(1161001)
-- 黄金不足
UI.TEXT_1110389 = languageManagerInstance:getLocalString(1110410)
-- 钻石不足
UI.TEXT_1110390 = languageManagerInstance:getLocalString(1110378)

-- 商品不存在
UI.TEXT_1170019 = languageManagerInstance:getLocalString(1170019)

-- 可强化 %d 次
UI.TEXT_1110391 = languageManagerInstance:getLocalString(1110416)
-- ???
UI.TEXT_1110392 = languageManagerInstance:getLocalString(1110412)
-- ????
UI.TEXT_1110393 = languageManagerInstance:getLocalString(1110413)
-- 装备分解后无法还原
UI.TEXT_1110394 = languageManagerInstance:getLocalString(1110437)
-- 分解
UI.TEXT_1110395 = languageManagerInstance:getLocalString(1110438)
-- 锻造
UI.TEXT_1110396 = languageManagerInstance:getLocalString(1110439)
-- 是否花费%s金币解锁%s格背包？
UI.TEXT_1110397 = languageManagerInstance:getLocalString(1110418)
-- 是否话费%s水晶解锁%s格背包？
UI.TEXT_1110398 = languageManagerInstance:getLocalString(1110419)
-- 钻石不足，到商店购买？
UI.TEXT_1110399 = languageManagerInstance:getLocalString(1110378)
-- 这个装备不能被分解
UI.TEXT_1110400 = languageManagerInstance:getLocalString(1170024)
-- 你获得了%s x %s
UI.TEXT_1110401 = languageManagerInstance:getLocalString(1110440)

-- "兑换码"
UI.TEXT_1150001 = languageManagerInstance:getLocalString(1110864)
-- 技能点数不足
UI.TEXT_1150002 = languageManagerInstance:getLocalString(1110865)
-- 该技能需要%d级才能学习
UI.TEXT_1150003 = languageManagerInstance:getLocalString(1110866)
-- "没有前置技能"
UI.TEXT_1150004 = languageManagerInstance:getLocalString(1110867)
-- "已经满级"
UI.TEXT_1150005 = languageManagerInstance:getLocalString(1110868)
-- "材料不足,重置技能失败"
UI.TEXT_1150006 = languageManagerInstance:getLocalString(1110869)
-- -- "请输入兑换码"
-- UI.TEXT_1150007 = languageManagerInstance:getLocalString(1110870)
-- 兑换失败，可能已经使用过相同类型的兑换码、兑换码已过期或输入错误
UI.TEXT_1150008 = languageManagerInstance:getLocalString(1110871)
-- 奖励已发送至邮箱
UI.TEXT_1150009 = languageManagerInstance:getLocalString(1110872)
-- 连接超时
UI.TEXT_1150010 = languageManagerInstance:getLocalString(1110873)
-- 兑换
UI.TEXT_1150011 = languageManagerInstance:getLocalString(1110874)
-- 请输入兑换的CD-KEY
UI.TEXT_1150012 = languageManagerInstance:getLocalString(1110875)
-- 输入想要修改的名字
UI.TEXT_1150013 = languageManagerInstance:getLocalString(1110880)
-- 冒险者%s的
UI.TEXT_1150014 = languageManagerInstance:getLocalString(1110881)
-- 剑盾天赋
UI.TEXT_1150015 = languageManagerInstance:getLocalString(1110883)
-- 大剑天赋
UI.TEXT_1150016 = languageManagerInstance:getLocalString(1110884)
-- 法杖天赋
UI.TEXT_1150017 = languageManagerInstance:getLocalString(1110885)
-- 修改造型成功
UI.TEXT_1150018 = languageManagerInstance:getLocalString(1110882)
-- 修改名字成功
UI.TEXT_1150019 = languageManagerInstance:getLocalString(1110879)
-- 没有学习技能不能分享
UI.TEXT_1150020 = languageManagerInstance:getLocalString(1110899)
-- 魔法值不足
UI.TEXT_1150021 = languageManagerInstance:getLocalString(1110900)
-- 该点金台已经被使用
UI.TEXT_1150022 = languageManagerInstance:getLocalString(1110901)
--正在加载数据
UI.TEXT_1150023 = languageManagerInstance:getLocalString(1110902)
--解锁噩梦难度
UI.TEXT_1150024 = languageManagerInstance:getLocalString(1111020)
--解锁地狱难度
UI.TEXT_1150025 = languageManagerInstance:getLocalString(1111021)
--联系客服
UI.TEXT_1150026 = languageManagerInstance:getLocalString(1111022)
--我知道了
UI.TEXT_1150027 = languageManagerInstance:getLocalString(1111023)
-- 未知的系统错误
UI.TEXT_1170002 = languageManagerInstance:getLocalString(1170002)
-- 数据异常，稍后重试
UI.TEXT_1170020 = languageManagerInstance:getLocalString(1170020)
-- 这个材料不能被锻造
UI.TEXT_1170021 = languageManagerInstance:getLocalString(1170025)
-- "%概率，锻造出结果"1110441
UI.TEXT_1170022 = languageManagerInstance:getLocalString(1110441)
-- %s/%s
UI.TEXT_1170023 = languageManagerInstance:getLocalString(1110442)
-- 配方
UI.TEXT_1170024 = languageManagerInstance:getLocalString(1110450)
-- 花费
UI.TEXT_1170025 = languageManagerInstance:getLocalString(1110451)
-- 图纸
UI.TEXT_1170026 = languageManagerInstance:getLocalString(1110452)
-- 已食用
UI.TEXT_1170029 = languageManagerInstance:getLocalString(1110509)
-- 猫饭
UI.TEXT_1170030 = languageManagerInstance:getLocalString(1110449)
-- 时光穿越
UI.TEXT_1170031 = languageManagerInstance:getLocalString(1111317)

--抽奖相关
--抽奖界面时间过期，请重新打开
UI.TEXT_1170100 = languageManagerInstance:getLocalString(1170030)
--今天还能抽奖%d次
UI.TEXT_1170101 = languageManagerInstance:getLocalString(1110502)
--奖池刷新时间
UI.TEXT_1170102 = languageManagerInstance:getLocalString(1110503)
--再转一次
UI.TEXT_1170103 = languageManagerInstance:getLocalString(1110504)
--购买次数已达上限
UI.TEXT_1170104 = languageManagerInstance:getLocalString(1110505)
--抽奖次数已用完
UI.TEXT_1170105 = languageManagerInstance:getLocalString(1110506)

UI.TEXT_1170106 = languageManagerInstance:getLocalString(1110497)

UI.TEXT_1170107 = languageManagerInstance:getLocalString(1110498)
--点击屏幕继续
UI.TEXT_1170108 = languageManagerInstance:getLocalString(1110507)
--表情发送太频繁,请稍后再发
UI.TEXT_1170109 = languageManagerInstance:getLocalString(1110508) 


--大秘境相关"单人"
UI.TEXT_1170201 = languageManagerInstance:getLocalString(1110636)
--"多人"
UI.TEXT_1170202 = languageManagerInstance:getLocalString(1110637)
--"大秘境描述内容："
UI.TEXT_1170203 = languageManagerInstance:getLocalString(1110638) 
--"奖励查询"
UI.TEXT_1170204 = languageManagerInstance:getLocalString(1110639) 
--"消耗这枚钥匙你将开启大秘境%d层"
UI.TEXT_1170205 = languageManagerInstance:getLocalString(1110640) 
--"第三十一赛季奖励"
UI.TEXT_1170206 = languageManagerInstance:getLocalString(1110641)
--"我的排名："
UI.TEXT_1170207 = languageManagerInstance:getLocalString(1110642)
--"赛季结束时间"
UI.TEXT_1170208 = languageManagerInstance:getLocalString(1110643)
--"赛季结束后玩家可以根据名次获得上述奖励"
UI.TEXT_1170209 = languageManagerInstance:getLocalString(1110644)
--"战利品"
UI.TEXT_1170210 = languageManagerInstance:getLocalString(1110028)
--"确定"
UI.TEXT_1170211 = languageManagerInstance:getLocalString(1110645)
--秘境大门
UI.TEXT_1170212 = languageManagerInstance:getLocalString(1110658)
--秘境钥匙
UI.TEXT_1170213 = languageManagerInstance:getLocalString(1102035)

UI.TEXT_1170214 = languageManagerInstance:getLocalString(1110681)

UI.TEXT_1170215 = languageManagerInstance:getLocalString(1110903)

UI.TEXT_1170216 = languageManagerInstance:getLocalString(1111024)

--聊天相关
--"「%s」"
UI.TEXT_1170301 = languageManagerInstance:getLocalString(1110595)
--"发送"
UI.TEXT_1170302 = languageManagerInstance:getLocalString(1110596)
--"点击输入聊天内容"
UI.TEXT_1170303 = languageManagerInstance:getLocalString(1110597)  
--"目标玩家"
UI.TEXT_1170304 = languageManagerInstance:getLocalString(1110598)
--"系统"
UI.TEXT_1170305 = languageManagerInstance:getLocalString(1110599)
--"队伍"
UI.TEXT_1170306 = languageManagerInstance:getLocalString(1110600)
--"工会"
UI.TEXT_1170307 = languageManagerInstance:getLocalString(1110547)
--"私聊"
UI.TEXT_1170308 = languageManagerInstance:getLocalString(1110602)
--"发送消息不能为空"
UI.TEXT_1170309 = languageManagerInstance:getLocalString(1110603)
--"请选择私聊对象"
UI.TEXT_1170310 = languageManagerInstance:getLocalString(1110604)
--"文字已超上限"
UI.TEXT_1170311 = languageManagerInstance:getLocalString(1110605)
--"只能有一个超链接"
UI.TEXT_1170312 = languageManagerInstance:getLocalString(1110606)
--"无"
UI.TEXT_1170313 = languageManagerInstance:getLocalString(1110608) --languageManagerInstance:getLocalString(1110607)
--"添加好友"
UI.TEXT_1170314 = languageManagerInstance:getLocalString(1110589)
--"删除好友"
UI.TEXT_1170315 = languageManagerInstance:getLocalString(1110590)
--"屏蔽好友"
UI.TEXT_1170316 = languageManagerInstance:getLocalString(1110591)
--"取消屏蔽"
UI.TEXT_1170317 = languageManagerInstance:getLocalString(1110592)
--"我"(第一人称)
UI.TEXT_1170318 = languageManagerInstance:getLocalString(1110593)
--">"
UI.TEXT_1170319 = ">"
--"你还没有加入任何队伍"
UI.TEXT_1170320 = languageManagerInstance:getLocalString(1110654)	
--"你还没有加入任何公会"
UI.TEXT_1170321 = languageManagerInstance:getLocalString(1110633)
--"物品信息已粘贴至聊天输入框"
UI.TEXT_1170322 = languageManagerInstance:getLocalString(1110635)
--"距本赛季结束还有 5 个小时"
UI.TEXT_1170323 = languageManagerInstance:getLocalString(1110808)

--"本赛季即将结束，你将在%d 分钟后被传送回城镇，请做好准备"
UI.TEXT_1170324 = languageManagerInstance:getLocalString(1110723)
-- 
UI.TEXT_1170325 = languageManagerInstance:getLocalString(1110722)
-- 黄金
UI.TEXT_1170326 = languageManagerInstance:getLocalString(1110725)
-- 水晶
UI.TEXT_1170327 = languageManagerInstance:getLocalString(1110726)
-- 你
UI.TEXT_1170328 = languageManagerInstance:getLocalString(1111025)
--"任务'%s' 可提交，前往城镇告示栏领取奖励"
UI.TEXT_1170329 = languageManagerInstance:getLocalString(1111026)
--"任务'%s' 完成进度（%d/%d）"
UI.TEXT_1170330 = languageManagerInstance:getLocalString(1111027)
--"任务'%s' 可提交，前往公会悬赏栏领取奖励"
UI.TEXT_1170331 = languageManagerInstance:getLocalString(1111028)
--你说话太快了 休息一下
UI.TEXT_1170332 = languageManagerInstance:getLocalString(1111130)
--附近
UI.TEXT_1170333 = languageManagerInstance:getLocalString(1111131)
-- 举报
UI.TEXT_1170334 = languageManagerInstance:getLocalString(1111217)
-- 举报成功
UI.TEXT_1170335 = languageManagerInstance:getLocalString(1111218)

-- 屏蔽成功
UI.TEXT_1170336 = languageManagerInstance:getLocalString(1111219)
-- 取消屏蔽成功
UI.TEXT_1170337 = languageManagerInstance:getLocalString(1111220)

UI.TEXT_1170338 = languageManagerInstance:getLocalString(1111318)

UI.TEXT_1170339 = languageManagerInstance:getLocalString(1111319)

UI.TEXT_1170340 = languageManagerInstance:getLocalString(1113060) -- "暂时没有消息"
--好友、
--"输入要添加的好友id"
UI.TEXT_1170400 = languageManagerInstance:getLocalString(1110646)
--"我的Id："
UI.TEXT_1170401 = languageManagerInstance:getLocalString(1110647)
--"离线"
UI.TEXT_1170402 = languageManagerInstance:getLocalString(1110648)

UI.TEXT_1170403 = languageManagerInstance:getLocalString(1110649)

UI.TEXT_1170404 = languageManagerInstance:getLocalString(1110650)

UI.TEXT_1170405 = languageManagerInstance:getLocalString(1110651)
--"你的好友数量已满"
UI.TEXT_1170406 = languageManagerInstance:getLocalString(1170057)
--"你们已经是好友"
UI.TEXT_1170407 = languageManagerInstance:getLocalString(1170055)
--"无法添加自己为好友"
UI.TEXT_1170408 = languageManagerInstance:getLocalString(1170056)
--"%s向%s发送了好友请求"
UI.TEXT_1170409 = languageManagerInstance:getLocalString(1110652)
-- "%s和%s成为了好友"
UI.TEXT_1170410 = languageManagerInstance:getLocalString(1110653)

UI.TEXT_1170411 = languageManagerInstance:getLocalString(1170061)
-- 操作太频繁，请稍后重试
UI.TEXT_1170412 = languageManagerInstance:getLocalString(1110611)
--好友请求已送出
UI.TEXT_1170413 = languageManagerInstance:getLocalString(1110655) 
--"已向该玩家发送过请求"
UI.TEXT_1170414 = languageManagerInstance:getLocalString(1110656) 
--非法输入
UI.TEXT_1170415 = languageManagerInstance:getLocalString(1110679)
--"未达到最低要求等级"
UI.TEXT_1170416 = languageManagerInstance:getLocalString(1110680) 

--"我"(第三人称)
UI.TEXT_1170417 = languageManagerInstance:getLocalString(1110594)

UI.TEXT_1170418 = languageManagerInstance:getLocalString(1111325)

UI.TEXT_1170419 = languageManagerInstance:getLocalString(1111326)

UI.TEXT_1170420 = languageManagerInstance:getLocalString(1111471)
-- 无法查看自己的信息
UI.TEXT_1110720 = languageManagerInstance:getLocalString(1110720) 
-- 已领取
UI.TEXT_1110721 = languageManagerInstance:getLocalString(1110721)
-- %s获得了%s
UI.TEXT_1110722 = languageManagerInstance:getLocalString(1110722)
-- 成就点数:
UI.TEXT_1170600 = languageManagerInstance:getLocalString(1110678)
-- %s消耗了%s
UI.TEXT_1170601 = languageManagerInstance:getLocalString(1110727)
-- 对方不在线，无法查看装备信息
UI.TEXT_1170603 = languageManagerInstance:getLocalString(1110781)
-- %s想加你为好友
UI.TEXT_1170604 = languageManagerInstance:getLocalString(1111029)
-- 想加你为好友
UI.TEXT_1170605 = languageManagerInstance:getLocalString(1111030)

--有队友不在线 移除失败
UI.TEXT_1170606 = languageManagerInstance:getLocalString(1170139)
--完成时间
UI.TEXT_1170607 = languageManagerInstance:getLocalString(1111132)

--邮件相关
--1皇家新闻社休假中
UI.TEXT_1170701 = languageManagerInstance:getLocalString(1110730)
--听说邮差倒在城门口了
UI.TEXT_1170702 = languageManagerInstance:getLocalString(1110731)
--"(有效期还剩：%s)"
UI.TEXT_1170704 = languageManagerInstance:getLocalString(1110732)
-- "%d天%d小时%d分钟%d秒"
UI.TEXT_1170705 = languageManagerInstance:getLocalString(1110733)
--"%d小时%d分钟%d秒"
UI.TEXT_1170706 = languageManagerInstance:getLocalString(1110734)
-- "%d分钟%d秒"
UI.TEXT_1170707 = languageManagerInstance:getLocalString(1110735)
--"%d秒"
UI.TEXT_1170708 = languageManagerInstance:getLocalString(1110736)
--"你有一封信邮件，请查收" 
UI.TEXT_1170709 = languageManagerInstance:getLocalString(1110737) 
--"去看看"
UI.TEXT_1170710 = languageManagerInstance:getLocalString(1110738)
-- "请输入公会名字"
UI.TEXT_1170711 = languageManagerInstance:getLocalString(1110836)
--邮件
UI.TEXT_1170712 = languageManagerInstance:getLocalString(1111031)
--金币
UI.TEXT_1170713 = languageManagerInstance:getLocalString(1111032)
--功能
UI.TEXT_1170714 = languageManagerInstance:getLocalString(1111033)
--"科技"
UI.TEXT_1170715 = languageManagerInstance:getLocalString(1111034)
--"天赋"
UI.TEXT_1170716 = languageManagerInstance:getLocalString(1111035)
--删除
UI.TEXT_1170717 = languageManagerInstance:getLocalString(1111097)
--分解数量已达上限
UI.TEXT_1170718 = languageManagerInstance:getLocalString(1111098)
--开始游戏
UI.TEXT_1170719 = languageManagerInstance:getLocalString(1111096)
--
UI.TEXT_1170720 = languageManagerInstance:getLocalString(1113423)--"公会协同作战加成" 

-----------------------------------------支付相关-----------------------------------------
-- 水晶
UI.TEXT_1170800 = languageManagerInstance:getLocalString(1092002)
-- 宝箱
UI.TEXT_1170801 = languageManagerInstance:getLocalString(1110876)
-- 余额不足
UI.TEXT_1170802 = languageManagerInstance:getLocalString(1170094)
-- 支付失败
UI.TEXT_1170803 = languageManagerInstance:getLocalString(1170095)
-- 充值功能未开放
UI.TEXT_1170804 = languageManagerInstance:getLocalString(1170096)
-- 订单号重复
UI.TEXT_1170805 = languageManagerInstance:getLocalString(1170097)
-- 当日充值额度达到上限
UI.TEXT_1170806 = languageManagerInstance:getLocalString(1170098)
-- 订单号不存在
UI.TEXT_1170807 = languageManagerInstance:getLocalString(1170099)
-- 游客账号无法充值
UI.TEXT_1170808 = languageManagerInstance:getLocalString(1170100)
-- 当日充值次数达到上限
UI.TEXT_1170809 = languageManagerInstance:getLocalString(1170103)
-- 连接游戏服务器网络异常
UI.TEXT_1170810 = languageManagerInstance:getLocalString(1170104)
-- 订单正在处理中
UI.TEXT_1170811 = languageManagerInstance:getLocalString(1170105)
-- 订单状态异常
UI.TEXT_1170812 = languageManagerInstance:getLocalString(1170106)
-- 上一笔订单还未完成
UI.TEXT_1170813 = languageManagerInstance:getLocalString(1170107)
-- 支付成功
UI.TEXT_1170814 = languageManagerInstance:getLocalString(1170108)
-- 支付取消
UI.TEXT_1170815 = languageManagerInstance:getLocalString(1170109)
-- 网络错误
UI.TEXT_1170816 = languageManagerInstance:getLocalString(1170110)
-- 支付信息提供不完全
UI.TEXT_1170817 = languageManagerInstance:getLocalString(1170111)
-- 推荐
UI.TEXT_1170818 = languageManagerInstance:getLocalString(1110877)
-- 获取商品信息失败
UI.TEXT_1170819 = languageManagerInstance:getLocalString(1170113)
-- 首充
UI.TEXT_1170820 = languageManagerInstance:getLocalString(1110878)
-- 商城
UI.TEXT_1170821 = languageManagerInstance:getLocalString(1110898)
-- 本周可购买
UI.TEXT_1170822 = languageManagerInstance:getLocalString(1110905)
-- 本日可购买
UI.TEXT_1170823 = languageManagerInstance:getLocalString(1110906)
-- 本周已售罄
UI.TEXT_1170824 = languageManagerInstance:getLocalString(1110907)
-- 总存货%d
UI.TEXT_1170825 = languageManagerInstance:getLocalString(1110908)
-- 已售罄
UI.TEXT_1170826 = languageManagerInstance:getLocalString(1110909)
-- 需要等级达到lv%d
UI.TEXT_1170827 = languageManagerInstance:getLocalString(1110913)
-- 需要探索洞窟层数达到%d
UI.TEXT_1170828 = languageManagerInstance:getLocalString(1110914)
-- 需要装备评分达到%d
UI.TEXT_1170829 = languageManagerInstance:getLocalString(1110915)
-- 需要探索大秘境层数达到%d
UI.TEXT_1170830 = languageManagerInstance:getLocalString(1110916)
-- 需要成就点数达到%d
UI.TEXT_1170831 = languageManagerInstance:getLocalString(1110917)
-- 需要公会贡献度达到%d
UI.TEXT_1170832 = languageManagerInstance:getLocalString(1110918)
-- 验证成功等待发货
UI.TEXT_1170833 = languageManagerInstance:getLocalString(1170160)
-- 验证失败
UI.TEXT_1170834 = languageManagerInstance:getLocalString(1170161)
-- 使用过的订单
UI.TEXT_1170835 = languageManagerInstance:getLocalString(1170162)
-- 订单ID和收据ID不匹配
UI.TEXT_1170836 = languageManagerInstance:getLocalString(1170163)
-- 订单不存在
UI.TEXT_1170837 = languageManagerInstance:getLocalString(1170164)
-- 到第三方验证订单失败
UI.TEXT_1170838 = languageManagerInstance:getLocalString(1170165)
-- 渠道不合法
UI.TEXT_1170839 = languageManagerInstance:getLocalString(1170166)
-- 发货失败
UI.TEXT_1170840 = languageManagerInstance:getLocalString(1170167)
-- 请求验证订单号失败
UI.TEXT_1170841 = languageManagerInstance:getLocalString(1170168)
-- 礼包在洞窟内无法购买
UI.TEXT_1170842 = languageManagerInstance:getLocalString(1111112)
-- 发货成功
UI.TEXT_1170843 = languageManagerInstance:getLocalString(1111110)
-- 发货失败
UI.TEXT_1170844 = languageManagerInstance:getLocalString(1111111)
-- 获得物品
UI.TEXT_1170845 = languageManagerInstance:getLocalString(1110728)
-- 即将推出
UI.TEXT_1170846 = languageManagerInstance:getLocalString(1111114)
-- 没有此商品
UI.TEXT_1170847 = languageManagerInstance:getLocalString(1111115)
-- 不满足条件
UI.TEXT_1170848 = languageManagerInstance:getLocalString(1111116)
-- 重复订单
UI.TEXT_1170849 = languageManagerInstance:getLocalString(1111117)
-- 系统错误
UI.TEXT_1170850 = languageManagerInstance:getLocalString(1111118)
-- 超过数量限制
UI.TEXT_1170851 = languageManagerInstance:getLocalString(1111119)
-- 游客身份无法进行充值。请先进行账号绑定
UI.TEXT_1170852 = languageManagerInstance:getLocalString(1111120)
-- 充值成功,水晶已到账,请注意查收
UI.TEXT_1170853 = languageManagerInstance:getLocalString(1111121)
-- 今日已售罄
UI.TEXT_1170854 = languageManagerInstance:getLocalString(1111122)
-- 有新的宝箱可以购买了
UI.TEXT_1170855 = languageManagerInstance:getLocalString(1111133)
-- 背包空间不足,获得物品将会发送到邮箱
UI.TEXT_1170856 = languageManagerInstance:getLocalString(1111039)
-- 验证超时,请稍后
UI.TEXT_1170857 = languageManagerInstance:getLocalString(1111209)
-- 初始化失败
UI.TEXT_1170858 = languageManagerInstance:getLocalString(1170112)
-- 订单已被锁
UI.TEXT_1170859 = languageManagerInstance:getLocalString(1112573)
-- 向第三方验证超时
UI.TEXT_1170860 = languageManagerInstance:getLocalString(1112574)
-- 未登录登录市场
UI.TEXT_1170861 = languageManagerInstance:getLocalString(1170267)

--系统解锁
UI.TEXT_1170900 = languageManagerInstance:getLocalString(1111387)
-- 该功能未解锁
UI.TEXT_1170901 = languageManagerInstance:getLocalString(1110886)
-- 解锁条件：
UI.TEXT_1170902 = languageManagerInstance:getLocalString(1110887)
-- 人物等级达到Lv.%d
UI.TEXT_1170903 = languageManagerInstance:getLocalString(1110888)
-- 完成任务
UI.TEXT_1170904 = languageManagerInstance:getLocalString(1110889)
-- 通关%s
UI.TEXT_1170905 = languageManagerInstance:getLocalString(1110890)
-- 通关%s
UI.TEXT_1170906 = languageManagerInstance:getLocalString(1110891)
-- 能安全回城就不错了，还想什么战利品？
UI.TEXT_1170907 = languageManagerInstance:getLocalString(1110892)
-- 什么信息都没有
UI.TEXT_1170908 = languageManagerInstance:getLocalString(1110893)

UI.TEXT_1170909 = languageManagerInstance:getLocalString(1110894)

UI.TEXT_1170910 = languageManagerInstance:getLocalString(1110895)

UI.TEXT_1170911 = languageManagerInstance:getLocalString(1110896)
-- 趣味数据
UI.TEXT_1170912 = languageManagerInstance:getLocalString(1110897)
--同意
UI.TEXT_1170913 = languageManagerInstance:getLocalString(1110910)
--残忍拒绝
UI.TEXT_1170914 = languageManagerInstance:getLocalString(1110911)
--是否愿意 提出你的宝贵意见
UI.TEXT_1170915 = languageManagerInstance:getLocalString(1110912)

--"你有%s条未读邮件"
UI.TEXT_1170916 = languageManagerInstance:getLocalString(1170114)
--"在告示板你还有%s条奖励未领取"
UI.TEXT_1170917 = languageManagerInstance:getLocalString(1170115)
--"该道具不能在此处使用"
UI.TEXT_1170918 = languageManagerInstance:getLocalString(1170116)
--"状态已满不能使用"
UI.TEXT_1170919 = languageManagerInstance:getLocalString(1170117)
--"需要等待一段时间才能使用"
UI.TEXT_1170920 = languageManagerInstance:getLocalString(1170118)
--"天"
UI.TEXT_1170921 = languageManagerInstance:getLocalString(1111036)
-- 
UI.TEXT_1170926 = languageManagerInstance:getLocalString(1111037)
-- 活动时间: %s----%s
UI.TEXT_1170929 = languageManagerInstance:getLocalString(1111009)
-- 你没有加入公会，无法前往 1110942
UI.TEXT_1170930 = languageManagerInstance:getLocalString(1110942)
-- 你没有解锁好友功能，无法前往
UI.TEXT_1170931 = languageManagerInstance:getLocalString(1110943)
-- 目前没有宝箱出售，无法前往
UI.TEXT_1170932 = languageManagerInstance:getLocalString(1110944)
-- 深渊内无法更换装备
UI.TEXT_1170933 = languageManagerInstance:getLocalString(1111038)
--"集齐配方中的材料可以在铁匠处锻造："
UI.TEXT_1170934 = languageManagerInstance:getLocalString(1111015)
--"有一定几率锻造出传奇属性！"
UI.TEXT_1170935 = languageManagerInstance:getLocalString(1111016)
--"名字 不能 含有emoji"
UI.TEXT_1170936 = languageManagerInstance:getLocalString(1170144)
-- "可领取"
UI.TEXT_1170937 = languageManagerInstance:getLocalString(1110945)
--每日任务将在1小时后刷新，请抓紧时间
UI.TEXT_1170938 = languageManagerInstance:getLocalString(1111083)
-- 请输入主城频道号
UI.TEXT_1170939 = languageManagerInstance:getLocalString(1111084)
-- 切换
UI.TEXT_1170940 = languageManagerInstance:getLocalString(1111085)
--游戏公告
UI.TEXT_1170941 = languageManagerInstance:getLocalString(1111086)
--服务器维护中...
UI.TEXT_1170942 = languageManagerInstance:getLocalString(1111087)
--
UI.TEXT_1170943 = languageManagerInstance:getLocalString(1111106)

UI.TEXT_1170944 = languageManagerInstance:getLocalString(1111107)

UI.TEXT_1170951 = languageManagerInstance:getLocalString(1111385)

UI.TEXT_1170945 = languageManagerInstance:getLocalString(1111320)

UI.TEXT_1170946 = languageManagerInstance:getLocalString(1111321)

UI.TEXT_1170947 = languageManagerInstance:getLocalString(1170187)

UI.TEXT_1170948 = languageManagerInstance:getLocalString(1111323)

UI.TEXT_1170949 = languageManagerInstance:getLocalString(1111324)
--"当前已有关卡特殊事件， 是否继续进行时光穿越？"
UI.TEXT_1170950 = languageManagerInstance:getLocalString(1111343)  
---------宝石相关----------
--合成
UI.TEXT_1172001 = languageManagerInstance:getLocalString(1111262)

UI.TEXT_1172002 = languageManagerInstance:getLocalString(1111263)

UI.TEXT_1172003 = languageManagerInstance:getLocalString(1111264)

UI.TEXT_1172004 = languageManagerInstance:getLocalString(1111265)
--合成
UI.TEXT_1172005 = languageManagerInstance:getLocalString(1111266)
--
UI.TEXT_1172006 = languageManagerInstance:getLocalString(1111267)
-- "多彩符文凹槽已经解锁"
UI.TEXT_1172007 = languageManagerInstance:getLocalString(1111277)
--"请先放入主宝石"
UI.TEXT_1172009 = languageManagerInstance:getLocalString(1111344)  
--"已经准备好，请点击转换按钮"
UI.TEXT_1172010 = languageManagerInstance:getLocalString(1111345)
--探索一次
UI.TEXT_1172011 = languageManagerInstance:getLocalString(1111362)
--探索十次
UI.TEXT_1172012 = languageManagerInstance:getLocalString(1111363)
--免费
UI.TEXT_1172013 = languageManagerInstance:getLocalString(1111364)
--在探索%d次，必得%d-%d级符文石
UI.TEXT_1172014 = languageManagerInstance:getLocalString(1111365)
--"本次探索，必得%d-%d级符文石"
UI.TEXT_1172015 = languageManagerInstance:getLocalString(1111366)

-- lv.%d级解锁
UI.TEXT_1172016 = languageManagerInstance:getLocalString(1111213)
-- "创建成功"
UI.TEXT_1172017 = languageManagerInstance:getLocalString(1111397)
-- "无称号" 
UI.TEXT_1172019 = languageManagerInstance:getLocalString(1111386)

UI.TEXT_1172020 = languageManagerInstance:getLocalString(1271041)

UI.TEXT_1172021 = languageManagerInstance:getLocalString(1271042)
UI.TEXT_1172022 = languageManagerInstance:getLocalString(1271043)
UI.TEXT_1172023 = languageManagerInstance:getLocalString(1271044)
UI.TEXT_1172024 = languageManagerInstance:getLocalString(1271045)
UI.TEXT_1172025 = languageManagerInstance:getLocalString(1271046)
UI.TEXT_1172026 = languageManagerInstance:getLocalString(1271047)
UI.TEXT_1172027 = languageManagerInstance:getLocalString(1271048)

UI.TEXT_1172028 = languageManagerInstance:getLocalString(1271049)
UI.TEXT_1172029 = languageManagerInstance:getLocalString(1271050)
UI.TEXT_1172030 = languageManagerInstance:getLocalString(1271051)
UI.TEXT_1172031 = languageManagerInstance:getLocalString(1271052)
UI.TEXT_1172032 = languageManagerInstance:getLocalString(1112084)

---------热更新--------
-- 检查更新中
UI.TEXT_1201001 = languageManagerInstance:getLocalString(1111074)
-- 读取本地版本文件失败
UI.TEXT_1201002 = languageManagerInstance:getLocalString(1111075)
-- 下载版本文件失败,是否重试？
UI.TEXT_1201003 = languageManagerInstance:getLocalString(1111076)
-- 解析版本文件失败,是否重试? 
UI.TEXT_1201004 = languageManagerInstance:getLocalString(1111077)
-- 开始更新
UI.TEXT_1201005 = languageManagerInstance:getLocalString(1111078)
-- 检测到你正使用移动数据,是否继续下载？
UI.TEXT_1201006 = languageManagerInstance:getLocalString(1111079)
-- 正在更新%d/%d
UI.TEXT_1201007 = languageManagerInstance:getLocalString(1111080)
-- 更新完毕,正在整理文件,请不要退出！
UI.TEXT_1201008 = languageManagerInstance:getLocalString(1111081)
-- 下载%d个文件失败,是否重新下载
UI.TEXT_1201009 = languageManagerInstance:getLocalString(1111082)

UI.TEXT_1201010 = languageManagerInstance:getLocalString(1111268)
UI.TEXT_1201011 = languageManagerInstance:getLocalString(1111269)
UI.TEXT_1201012 = languageManagerInstance:getLocalString(1111270)
UI.TEXT_1201013 = languageManagerInstance:getLocalString(1111271)
UI.TEXT_1201014 = languageManagerInstance:getLocalString(1111272)
UI.TEXT_1201015 = languageManagerInstance:getLocalString(1111273)
UI.TEXT_1201016 = languageManagerInstance:getLocalString(1111274)
UI.TEXT_1201017 = languageManagerInstance:getLocalString(1111276)
UI.TEXT_1201018 = languageManagerInstance:getLocalString(1111275)
UI.TEXT_1201019 = languageManagerInstance:getLocalString(1111278)
UI.TEXT_1201020 = languageManagerInstance:getLocalString(1111279)
UI.TEXT_1111299 = languageManagerInstance:getLocalString(1111299)
UI.TEXT_1111300 = languageManagerInstance:getLocalString(1116243)-- 个人信息收集清单
UI.TEXT_1111301 = languageManagerInstance:getLocalString(1116244)-- 第三方SDK收集信息清单

--首冲奖励
UI.TEXT_1212000 = languageManagerInstance:getLocalString(1111313)
--领取奖励
UI.TEXT_1212001 = languageManagerInstance:getLocalString(1111314)
--充值任意金额即可获得以下奖励
UI.TEXT_1212002 = languageManagerInstance:getLocalString(1111315)
--商店界面月卡tab
UI.TEXT_1212003 = languageManagerInstance:getLocalString(1111338)
--月卡
UI.TEXT_1212004 = languageManagerInstance:getLocalString(1111307)
--每日补给 
UI.TEXT_1212005 = languageManagerInstance:getLocalString(1111309)
--立即获得666水晶，之后30天每日补给可以额外获得100水晶  
UI.TEXT_1212006 = languageManagerInstance:getLocalString(1111308)
--月卡加成剩余%d天
UI.TEXT_1212007 = languageManagerInstance:getLocalString(1111310)
--今日已领取 
UI.TEXT_1212008 = languageManagerInstance:getLocalString(1111311)
--购买月卡可以增加补给数量 
UI.TEXT_1212009 = languageManagerInstance:getLocalString(1111312)
--洞窟内不能领取该奖励 
UI.TEXT_1212010 = languageManagerInstance:getLocalString(1111316)
--背包已满，请先清理 
UI.TEXT_1212011 = languageManagerInstance:getLocalString(1110793)
--购买月卡后可领取
UI.TEXT_1212012 = languageManagerInstance:getLocalString(1111328)

UI.TEXT_1212013 = languageManagerInstance:getLocalString(1111398)

UI.TEXT_1220000 = languageManagerInstance:getLocalString(1111392)
UI.TEXT_1220001 = languageManagerInstance:getLocalString(1111393)
UI.TEXT_1220002 = languageManagerInstance:getLocalString(1111400)
-- add by liujun
--放入装备
UI.TEXT_1300000 = languageManagerInstance:getLocalString(1110421)
--放入装备
UI.TEXT_1300001 = languageManagerInstance:getLocalString(1111399)
--角色头像
UI.TEXT_1212015 = languageManagerInstance:getLocalString(1110558)

--附魔失败
UI.TEXT_1212016 = languageManagerInstance:getLocalString(1111401)

UI.TEXT_1212017 = languageManagerInstance:getLocalString(1111424)
--"加入队伍后该频道才能发言"
UI.TEXT_1212018 = languageManagerInstance:getLocalString(1111425)
--"购买成功"
UI.TEXT_1212019 = LanguageManager:getInstance():getLocalString(1110688)
--"总成就点数:"
UI.TEXT_1212020 = languageManagerInstance:getLocalString(1111426)
--"Lv.%d 级后解锁该频道发言功能"
UI.TEXT_1212021 = languageManagerInstance:getLocalString(1111427)

UI.TEXT_1212022 = LanguageManager:getInstance():getLocalString(1111421) --"你将要卖掉传送卷轴，确认？"
UI.TEXT_1212023 = LanguageManager:getInstance():getLocalString(1111422) --"你将要丢弃掉传送卷轴，确认？"
--"技能重置成功"
UI.TEXT_1212024 = languageManagerInstance:getLocalString(1111428)
UI.TEXT_1212025 = languageManagerInstance:getLocalString(1111429)
-- 领取成功
UI.TEXT_1212026 = languageManagerInstance:getLocalString(1111430)

--强化等放入装备后显示的字符串
UI.TEXT_1212027 = LanguageManager:getInstance():getLocalString(1111423)
UI.TEXT_1212028 = LanguageManager:getInstance():getLocalString(1111431)

--强化失败 1111445
UI.TEXT_1212029 = languageManagerInstance:getLocalString(1111445)
--改造成功
UI.TEXT_1212030 = languageManagerInstance:getLocalString(1111446)

--镶嵌成功
UI.TEXT_1212031 = languageManagerInstance:getLocalString(1111443)
--拆卸成功
UI.TEXT_1212032 = languageManagerInstance:getLocalString(1111444)
--该装备有镶嵌符文，无法分解
UI.TEXT_1212033 = languageManagerInstance:getLocalString(1170194)
--已镶嵌同颜色符文
UI.TEXT_1212034 = languageManagerInstance:getLocalString(1111460)
-- 切换为都要的模式
UI.TEXT_1212035 = languageManagerInstance:getLocalString(1111459)
-- 都要
UI.TEXT_1212036 = languageManagerInstance:getLocalString(1111458)
-- 称号
UI.TEXT_1212037 = languageManagerInstance:getLocalString(1111461)
-- 显示UI
UI.TEXT_1212038 = languageManagerInstance:getLocalString(1111462)
-- 关闭界面后所有界面将会隐藏，点击头像区域，或者重启UI将会再次显示界面
UI.TEXT_1212039 = languageManagerInstance:getLocalString(1111463)
-- 点击这里，重新显示界面
UI.TEXT_1212040 = languageManagerInstance:getLocalString(1111464)
-- 你隐藏了界面
UI.TEXT_1212041 = languageManagerInstance:getLocalString(1111465)
-- 你显示了界面
UI.TEXT_1212042 = languageManagerInstance:getLocalString(1111466)
-- 等待
UI.TEXT_1212043 = languageManagerInstance:getLocalString(1110383)
-- 是否要重置技能
UI.TEXT_1212044 = languageManagerInstance:getLocalString(1111477)
-- "一键读取"
UI.TEXT_1212045 = languageManagerInstance:getLocalString(1111480)

UI.TEXT_1212046 = languageManagerInstance:getLocalString(1111481)

UI.TEXT_1212047 = languageManagerInstance:getLocalString(1170158)

UI.TEXT_1212048 = languageManagerInstance:getLocalString(1111482)

UI.TEXT_1212049 = languageManagerInstance:getLocalString(1111483)

UI.TEXT_1212050 = languageManagerInstance:getLocalString(1111490)

UI.TEXT_1212051 = languageManagerInstance:getLocalString(1111499)

UI.TEXT_1212052 = languageManagerInstance:getLocalString(1111500)

UI.TEXT_1212053 = languageManagerInstance:getLocalString(1111546)

UI.TEXT_1212054 = languageManagerInstance:getLocalString(1111547)
-- 正在组队匹配中
UI.TEXT_1212055 = languageManagerInstance:getLocalString(1111556)

UI.TEXT_1212056 = languageManagerInstance:getLocalString(1111571)

UI.TEXT_1212057 = languageManagerInstance:getLocalString(1111572)

UI.TEXT_1212058 = languageManagerInstance:getLocalString(1170198)

UI.TEXT_1212059 = languageManagerInstance:getLocalString(1111575)

-- "完成进度"
UI.TEXT_1212060 = languageManagerInstance:getLocalString(1111594)
UI.TEXT_1212061 = languageManagerInstance:getLocalString(1111595)
-- "打孔消耗:"
UI.TEXT_1212062 = languageManagerInstance:getLocalString(1111596)
-- "单件装备被打孔的次数越多,需要消耗的%s数量越多"
UI.TEXT_1212063 = languageManagerInstance:getLocalString(1111597)
-- "打孔"
UI.TEXT_1212064 = languageManagerInstance:getLocalString(1111598)
UI.TEXT_1212070 = languageManagerInstance:getLocalString(1111576)
-- "提交"
UI.TEXT_1212071 = languageManagerInstance:getLocalString(1111599)


UI.TEXT_1212070 = languageManagerInstance:getLocalString(1111576)
UI.TEXT_1212072 = languageManagerInstance:getLocalString(1111600) --"升级后"

UI.TEXT_1212073 = languageManagerInstance:getLocalString(1111601)  --"升级前"
UI.TEXT_1212074 = languageManagerInstance:getLocalString(1111602)  --"技能进阶的描述语言(需修饰)"
UI.TEXT_1212075 = languageManagerInstance:getLocalString(1111603)  --"进阶对比or 加持标题(需修饰)"
UI.TEXT_1212076 = languageManagerInstance:getLocalString(1111604)  --"转职后，将以往现在所有技能，此过程不可逆确认转职？"
UI.TEXT_1212077 = languageManagerInstance:getLocalString(1111605)  -- "转职"
UI.TEXT_1212071 = languageManagerInstance:getLocalString(1111599)   -- "提交"
UI.TEXT_1212078 = languageManagerInstance:getLocalString(1111626)  --"排行奖励"
UI.TEXT_1212079 = languageManagerInstance:getLocalString(1111627)   --"可能掉落:"

UI.TEXT_1212080 = languageManagerInstance:getLocalString(1111610)
UI.TEXT_1212081 = languageManagerInstance:getLocalString(1111361)   --"挑战"

UI.TEXT_1212082 = languageManagerInstance:getLocalString(1111628)   --"今日可以挑战:"
UI.TEXT_1212083 = languageManagerInstance:getLocalString(1111629)   --"剩余可挑战次数:"
UI.TEXT_1212084 = languageManagerInstance:getLocalString(1111630)   --"查看更多排行榜"

UI.TEXT_1212085 = languageManagerInstance:getLocalString(1111569)   --"伤害排名"
UI.TEXT_1212086 = languageManagerInstance:getLocalString(1111631)   --"奖品"
UI.TEXT_1212087 = languageManagerInstance:getLocalString(1111636)

UI.TEXT_1212090 = languageManagerInstance:getLocalString(1111646)

UI.TEXT_1212091 = languageManagerInstance:getLocalString(1111567)

UI.TEXT_1212092 = languageManagerInstance:getLocalString(1111647)

UI.TEXT_1212093 = languageManagerInstance:getLocalString(1111648)

UI.TEXT_1212094 = languageManagerInstance:getLocalString(1111649)

UI.TEXT_1212095 = languageManagerInstance:getLocalString(1111606)

UI.TEXT_1212096 = languageManagerInstance:getLocalString(1111609)

UI.TEXT_1212097 = languageManagerInstance:getLocalString(1111608)

UI.TEXT_1212098 = languageManagerInstance:getLocalString(1170199)

UI.TEXT_1212099 = languageManagerInstance:getLocalString(1111614)

UI.TEXT_1212100 = languageManagerInstance:getLocalString(1170200)

UI.TEXT_1212101 = languageManagerInstance:getLocalString(1111650)

UI.TEXT_1212202 = languageManagerInstance:getLocalString(1111632)

UI.TEXT_1212205 = languageManagerInstance:getLocalString(1111651)

UI.TEXT_1212206 = languageManagerInstance:getLocalString(1111652)

UI.TEXT_1212207 = languageManagerInstance:getLocalString(1111653)

UI.TEXT_1212208 = languageManagerInstance:getLocalString(1111654)

UI.TEXT_1212209 = languageManagerInstance:getLocalString(1111645)

UI.TEXT_1212210 = languageManagerInstance:getLocalString(1110919)

UI.TEXT_1212211 = languageManagerInstance:getLocalString(1111646)

UI.TEXT_1212212 = languageManagerInstance:getLocalString(1111655)

UI.TEXT_1212213 = languageManagerInstance:getLocalString(1111635)

UI.TEXT_1212214 = languageManagerInstance:getLocalString(1111656)

UI.TEXT_1212215 = languageManagerInstance:getLocalString(1111657)

UI.TEXT_1212216 = languageManagerInstance:getLocalString(1111675)   --"实际作用Lv.%d"
UI.TEXT_1212217 = languageManagerInstance:getLocalString(1111676)   --"%s后开启捐献功能"
UI.TEXT_1212218 = languageManagerInstance:getLocalString(1111677)   --"天赋实际作用等级不会超出公会解锁等级"

UI.TEXT_1212219 = languageManagerInstance:getLocalString(1111682)  --"解散队伍"
UI.TEXT_1212220 = languageManagerInstance:getLocalString(1111683)  --"你是否要发起解散队伍的请求？"
UI.TEXT_1212221 = languageManagerInstance:getLocalString(1111684)  --"你由于被踢出队伍或解散队伍，进入了单人模式"
UI.TEXT_1212222 = languageManagerInstance:getLocalString(1111685)  --"某某发起解散队伍请求，是否同意"
UI.TEXT_1212223 = languageManagerInstance:getLocalString(1111686)  --"请求解散队伍失败"
UI.TEXT_1212224 = languageManagerInstance:getLocalString(1111687)  --"发起解散队伍失败后%s内不能重复发起解散队伍"

UI.TEXT_1212225 = languageManagerInstance:getLocalString(1111715)--"启用中..."
UI.TEXT_1212226 = languageManagerInstance:getLocalString(1111716)--"注：将消耗奇遇等级最高的玩家奇遇进入关卡"

UI.TEXT_1212227 = languageManagerInstance:getLocalString(1111730)  --"兑换"
UI.TEXT_1212228 = languageManagerInstance:getLocalString(1111731)  --"可兑换"
UI.TEXT_1212229 = languageManagerInstance:getLocalString(1111732)  --"上交[%s]:"
UI.TEXT_1212230 = languageManagerInstance:getLocalString(1111733)  --"剩余可兑换次数:"
UI.TEXT_1212231 = languageManagerInstance:getLocalString(1111734)  --"今日可兑换次数:"
UI.TEXT_1212232 = languageManagerInstance:getLocalString(1111727)  --"放入的分解材料中包含稀有装备,是否继续分解?"
UI.TEXT_1212233 = languageManagerInstance:getLocalString(1111726)  --"放入的强化材料中包含稀有装备,是否继续强化?"


UI.TEXT_1212234 = languageManagerInstance:getLocalString(1111728)
UI.TEXT_1212235 = languageManagerInstance:getLocalString(1111729)

UI.TEXT_1212236 = languageManagerInstance:getLocalString(1111738)
UI.TEXT_1212237 = languageManagerInstance:getLocalString(1111739)
UI.TEXT_1212238 = languageManagerInstance:getLocalString(1111740)

UI.TEXT_1212242 = languageManagerInstance:getLocalString(1111750)
UI.TEXT_1212241 = languageManagerInstance:getLocalString(1111751)
UI.TEXT_1212240 = languageManagerInstance:getLocalString(1111752)
UI.TEXT_1212243 = languageManagerInstance:getLocalString(1111753)
UI.TEXT_1212244 = languageManagerInstance:getLocalString(1111754)

UI.TEXT_1212245 = languageManagerInstance:getLocalString(1111755)
UI.TEXT_1212246 = languageManagerInstance:getLocalString(1111756)
UI.TEXT_1212247 = languageManagerInstance:getLocalString(1111757)
UI.TEXT_1212248 = languageManagerInstance:getLocalString(1111758)
UI.TEXT_1212249 = languageManagerInstance:getLocalString(1111759)

UI.TEXT_1212250 = languageManagerInstance:getLocalString(1111805)
UI.TEXT_1212251 = languageManagerInstance:getLocalString(1111806)
UI.TEXT_1212252 = languageManagerInstance:getLocalString(1111807)
UI.TEXT_1212253 = languageManagerInstance:getLocalString(1111808)
UI.TEXT_1212254 = languageManagerInstance:getLocalString(1111809)
UI.TEXT_1212255 = languageManagerInstance:getLocalString(1111819)
UI.TEXT_1212256 = languageManagerInstance:getLocalString(1111810)
UI.TEXT_1212257 = languageManagerInstance:getLocalString(1111811)
UI.TEXT_1212258 = languageManagerInstance:getLocalString(1111773)
UI.TEXT_1212259 = languageManagerInstance:getLocalString(1111772)
UI.TEXT_1212260 = languageManagerInstance:getLocalString(1111812)
UI.TEXT_1212261 = languageManagerInstance:getLocalString(1111775)
UI.TEXT_1212262 = languageManagerInstance:getLocalString(1111813)
UI.TEXT_1212263 = languageManagerInstance:getLocalString(1111774)
UI.TEXT_1212264 = languageManagerInstance:getLocalString(1111814)
UI.TEXT_1212265 = languageManagerInstance:getLocalString(1111779)
UI.TEXT_1212266 = languageManagerInstance:getLocalString(1111815)
UI.TEXT_1212267 = languageManagerInstance:getLocalString(1170001)
UI.TEXT_1212268 = languageManagerInstance:getLocalString(1111818)
UI.TEXT_1212269 = languageManagerInstance:getLocalString(1111816)

UI.TEXT_1212270 = languageManagerInstance:getLocalString(1111761) --"可转换装备列表"
UI.TEXT_1212271 = languageManagerInstance:getLocalString(1111762) --"在原有英雄模式下获得的装备可以转化"
UI.TEXT_1212272 = languageManagerInstance:getLocalString(1111763) --"返回"
UI.TEXT_1212273 = languageManagerInstance:getLocalString(1111764) --"铁匠可以将你珍贵的装备进行转换"
        
UI.TEXT_1212274 = languageManagerInstance:getLocalString(1111765)
UI.TEXT_1212275 = languageManagerInstance:getLocalString(1111766)
UI.TEXT_1212276 = languageManagerInstance:getLocalString(1111767)
UI.TEXT_1212277 = languageManagerInstance:getLocalString(1111768)
UI.TEXT_1212278  = languageManagerInstance:getLocalString(1111769)       
UI.TEXT_1212279  = languageManagerInstance:getLocalString(1111771)     
UI.TEXT_1212280  =  languageManagerInstance:getLocalString(1111795)
UI.TEXT_1212281  =  languageManagerInstance:getLocalString(1111796)
UI.TEXT_1212282  =  languageManagerInstance:getLocalString(1111760)
UI.TEXT_1212283  = languageManagerInstance:getLocalString(1111770)       
UI.TEXT_1212284  = languageManagerInstance:getLocalString(1111834)     --"(当前客户端版本号%s)"    

UI.TEXT_1212289  = languageManagerInstance:getLocalString(1110620)      -- "未上榜"
UI.TEXT_1212290  = languageManagerInstance:getLocalString(1111784)      -- "上周"
UI.TEXT_1212291  = languageManagerInstance:getLocalString(1111785)      -- "本周"
UI.TEXT_1212292  = languageManagerInstance:getLocalString(1111786)      -- "累积贡献"
UI.TEXT_1212293  = languageManagerInstance:getLocalString(1110542)      -- "排名"
UI.TEXT_1212295  = languageManagerInstance:getLocalString(1110543)      -- "角色昵称"
UI.TEXT_1212296  = languageManagerInstance:getLocalString(1111787)      -- "排名规则"
UI.TEXT_1212297  = languageManagerInstance:getLocalString(1111788)      -- "排名规则内容"
UI.TEXT_1212298  = languageManagerInstance:getLocalString(1111789)      -- "奖励规则"
UI.TEXT_1212299  = languageManagerInstance:getLocalString(1111790)      -- "奖励规则内容"

UI.TEXT_1212300  = languageManagerInstance:getLocalString(1111791)      -- "神秘兑换所"
UI.TEXT_1212301  = languageManagerInstance:getLocalString(1111792)      -- "梦境等级提升，神秘兑换所的物品品质也会提升"
UI.TEXT_1212302  = languageManagerInstance:getLocalString(1111793)      -- "是否要兑换这件物品?"
UI.TEXT_1212303  = languageManagerInstance:getLocalString(1111794)      -- "你将花费"
UI.TEXT_1212304  = languageManagerInstance:getLocalString(1111798)      -- "卖光了"

UI.TEXT_1212305  = languageManagerInstance:getLocalString(1111799)      -- "梦境碎片不足，无法购买"
UI.TEXT_1212306  = languageManagerInstance:getLocalString(1111800)      -- "背包空间不足，无法购买"
UI.TEXT_1212307  = languageManagerInstance:getLocalString(1111801)      -- "商品数量不足，无法购买"
UI.TEXT_1212308  = languageManagerInstance:getLocalString(1111857)      --"放入装备"
UI.TEXT_1212309  = languageManagerInstance:getLocalString(1111858)      --"成功率"
UI.TEXT_1212310  = languageManagerInstance:getLocalString(1111859)      --"重铸后属性预览"
UI.TEXT_1212311  = languageManagerInstance:getLocalString(1111860)      --"强化等级和附魔属性不会改变"
UI.TEXT_1212312  = languageManagerInstance:getLocalString(1111861)      --"这件装备不能被重铸"
UI.TEXT_1212313  = languageManagerInstance:getLocalString(1170215)      --"嵌有符文的装备不能被重铸"
UI.TEXT_1212314  = languageManagerInstance:getLocalString(1111862)      --"重铸"
UI.TEXT_1212315  = languageManagerInstance:getLocalString(1111863)      --"确认重铸这件装备吗？强化等级和已附魔内容将被保留。基础属性、随机属性以及镶嵌孔将全部重新随机。"
UI.TEXT_1212316  = languageManagerInstance:getLocalString(1111864)      --"重铸成功，获得新装备！"
UI.TEXT_1212317  = languageManagerInstance:getLocalString(1111865)      --"重铸失败，装备没有变化..."
UI.TEXT_1212318  = languageManagerInstance:getLocalString(1111866)      --"请放入要重铸的装备"
UI.TEXT_1212319  = languageManagerInstance:getLocalString(1111867)      --"已准备好重铸"

UI.TEXT_1212320  = languageManagerInstance:getLocalString(1111909) --"收集奖励"
UI.TEXT_1212321  = languageManagerInstance:getLocalString(1111910) --"收集完成"
UI.TEXT_1212322  = languageManagerInstance:getLocalString(1111911) --"获取新的藏宝图碎片在任务界面查看"
UI.TEXT_1212323  = languageManagerInstance:getLocalString(1111908)
UI.TEXT_1212324  = languageManagerInstance:getLocalString(1111929) --"在城镇才能领取奖励"
UI.TEXT_1212325  = languageManagerInstance:getLocalString(1111936)  --"参与问卷调查将获得%d钻石的奖励，是否参与问卷调查？"
UI.TEXT_1212326  = languageManagerInstance:getLocalString(1091244) 
UI.TEXT_1212327  = languageManagerInstance:getLocalString(1111988)--"星辰之力"
UI.TEXT_1212328  = languageManagerInstance:getLocalString(1111989)--"重铸次数"
UI.TEXT_1212329  = languageManagerInstance:getLocalString(1111990)--"次数已满"
UI.TEXT_1212330  = languageManagerInstance:getLocalString(1170219)
UI.TEXT_1212331  = languageManagerInstance:getLocalString(1112354)--"上个等级"
UI.TEXT_1212332  = languageManagerInstance:getLocalString(1112355)--"是否需要挑战上一个等级"
UI.TEXT_1212333  = languageManagerInstance:getLocalString(1170234)--"梦境等级大于1时，才能挑战上一等级"
UI.TEXT_1212334  = languageManagerInstance:getLocalString(1170235)--"今日已成功挑战过当前等级BOSS"
UI.TEXT_1212335  = languageManagerInstance:getLocalString(1170236)--"今日已使用过'挑战上一等级'"
UI.TEXT_1212336  = languageManagerInstance:getLocalString(1113536)--""宝库"
UI.TEXT_1212337  = languageManagerInstance:getLocalString(1113537)--"兑换所"
UI.TEXT_1212338  = languageManagerInstance:getLocalString(1113538)--"梦境Lv%d解锁"
UI.TEXT_1212339  = languageManagerInstance:getLocalString(1113539) --"暂无拍卖物品记录"


UI.TEXT_1212350  = languageManagerInstance:getLocalString(1111817)
UI.TEXT_1212355  = languageManagerInstance:getLocalString(1091562)

UI.TEXT_1212356 = languageManagerInstance:getLocalString(1111837)      --"离线>%d天"
UI.TEXT_1212357 = languageManagerInstance:getLocalString(1111838)      --"请先选中需要删除的好友"
UI.TEXT_1212358 = languageManagerInstance:getLocalString(1111839)      --"确认删除所有被标记的好友吗？"
UI.TEXT_1212359 = languageManagerInstance:getLocalString(1111845)      -- "是否花费钻石帮助队友'%s'复活"
UI.TEXT_1212360 = languageManagerInstance:getLocalString(1170027)       -- "材料不足"
UI.TEXT_1212361 = languageManagerInstance:getLocalString(1111848)       -- "选择需要锻造的装备"
UI.TEXT_1212362 = languageManagerInstance:getLocalString(1111849)       -- "解锁后可使用"
UI.TEXT_1212363 = languageManagerInstance:getLocalString(1111850)       -- "解锁配方"
UI.TEXT_1212364 = languageManagerInstance:getLocalString(1111851)       -- "锻造成功!你获得了以下装备"
UI.TEXT_1212365 = languageManagerInstance:getLocalString(1111853)       -- "所需材料"
UI.TEXT_1212366 = languageManagerInstance:getLocalString(1111878)       -- "无装备"
UI.TEXT_1212367 = languageManagerInstance:getLocalString(1111937)       -- "材料减少"


UI.TEXT_1212518 = languageManagerInstance:getLocalString(1111912)       --"开%s有机会获得"
UI.TEXT_1212519 = languageManagerInstance:getLocalString(1111913)       --"开%s个数"
UI.TEXT_1212520 = languageManagerInstance:getLocalString(1091593)       --"陶罐"
UI.TEXT_1212521 = languageManagerInstance:getLocalString(1091594)       --"骨头堆"
UI.TEXT_1212522 = languageManagerInstance:getLocalString(1091595)       --"木宝箱"
UI.TEXT_1212523 = languageManagerInstance:getLocalString(1091596)       --"金宝箱"

UI.TEXT_1212524 = languageManagerInstance:getLocalString(1112097)       --"你可能获得%s品质的星痕"       --"金宝箱"
UI.TEXT_1212525 = languageManagerInstance:getLocalString(1112487)       --"金币抽奖次数：%s"


UI.TEXT_1212389 = languageManagerInstance:getLocalString(1110004) -- 
UI.TEXT_1212390 = languageManagerInstance:getLocalString(1111538) -- 
UI.TEXT_1212391 = languageManagerInstance:getLocalString(1111663) -- 
UI.TEXT_1212392 = languageManagerInstance:getLocalString(1111884) -- 
UI.TEXT_1212393 = languageManagerInstance:getLocalString(1111885) -- 
UI.TEXT_1212394 = languageManagerInstance:getLocalString(1111886) -- 
UI.TEXT_1212395 = languageManagerInstance:getLocalString(1111887) -- 
UI.TEXT_1212396 = languageManagerInstance:getLocalString(1111888) -- 
UI.TEXT_1212397 = languageManagerInstance:getLocalString(1111889) -- 
UI.TEXT_1212398 = languageManagerInstance:getLocalString(1111890) -- 
UI.TEXT_1212399 = languageManagerInstance:getLocalString(1111891) -- 
UI.TEXT_1212400 = languageManagerInstance:getLocalString(1111892) -- 
UI.TEXT_1212401 = languageManagerInstance:getLocalString(1111893) -- 
UI.TEXT_1212402 = languageManagerInstance:getLocalString(1111894) -- 
UI.TEXT_1212403 = languageManagerInstance:getLocalString(1111895) -- 
UI.TEXT_1212404 = languageManagerInstance:getLocalString(1111889) -- 
UI.TEXT_1212405 = languageManagerInstance:getLocalString(1111758) -- 
UI.TEXT_1212406 = languageManagerInstance:getLocalString(1111897) -- 
UI.TEXT_1212407 = languageManagerInstance:getLocalString(1111898) -- 
UI.TEXT_1212408 = languageManagerInstance:getLocalString(1111899) -- 
UI.TEXT_1212409 = languageManagerInstance:getLocalString(1111118) 
UI.TEXT_1212410 = languageManagerInstance:getLocalString(1170027) -- 
UI.TEXT_1212411 = languageManagerInstance:getLocalString(1111900) -- 
UI.TEXT_1212412 = languageManagerInstance:getLocalString(1111901) -- 
UI.TEXT_1212413 = languageManagerInstance:getLocalString(1110374) -- 
UI.TEXT_1212414 = languageManagerInstance:getLocalString(1111902) -- 
UI.TEXT_1212415 = languageManagerInstance:getLocalString(1111903) -- 
UI.TEXT_1212416 = languageManagerInstance:getLocalString(1111904) -- 
UI.TEXT_1212417 = languageManagerInstance:getLocalString(1111905) -- 
UI.TEXT_1212418 = languageManagerInstance:getLocalString(1111930)
UI.TEXT_1212419 = languageManagerInstance:getLocalString(1111931)
UI.TEXT_1212420 = languageManagerInstance:getLocalString(1111932)
UI.TEXT_1212421 = languageManagerInstance:getLocalString(1111933)
UI.TEXT_1212422 = languageManagerInstance:getLocalString(1111934)

UI.TEXT_1212423 = languageManagerInstance:getLocalString(1112073)--"是否观看视频获取免费抽奖机会？"
UI.TEXT_1212424 = languageManagerInstance:getLocalString(1112074)--"每日可领取%d次\n(不计入每日抽奖次数)"
UI.TEXT_1212425 = languageManagerInstance:getLocalString(1112075)--"是否观看视频获取免费料理？"
UI.TEXT_1212426 = languageManagerInstance:getLocalString(1112076)--"每日可领取%d次"
UI.TEXT_1212427 = languageManagerInstance:getLocalString(1112077)--"是否观看视频减少时间？"
UI.TEXT_1212428 = languageManagerInstance:getLocalString(1112078)--"每日可减少%d次"

UI.TEXT_1212429 = languageManagerInstance:getLocalString(1111949)--"超值礼包"
UI.TEXT_1212430 = languageManagerInstance:getLocalString(1112023)--"立即购买"
UI.TEXT_1212431 = languageManagerInstance:getLocalString(1112020)--"只需"
UI.TEXT_1212432 = languageManagerInstance:getLocalString(1112021)--"即可获得"
UI.TEXT_1212433 = languageManagerInstance:getLocalString(1112022)--"暗金武器"
UI.TEXT_1212434 = languageManagerInstance:getLocalString(1112088)--"快人一步"
UI.TEXT_1212435 = languageManagerInstance:getLocalString(1112024)--"进阶礼包"
UI.TEXT_1212436 = languageManagerInstance:getLocalString(1112277)--幸运冒险"
UI.TEXT_1212437 = languageManagerInstance:getLocalString(1112278)--"抽取%d次"
UI.TEXT_1212438 = languageManagerInstance:getLocalString(1112279)--"本次免费"
UI.TEXT_1212439 = languageManagerInstance:getLocalString(1112280)--"当前可抽取次数"
UI.TEXT_1212440 = languageManagerInstance:getLocalString(1112281)--"已抽取"
UI.TEXT_1212441 = languageManagerInstance:getLocalString(1112282)--"额外奖励"
UI.TEXT_1212442 = languageManagerInstance:getLocalString(1112283)--"活动结束倒计时\n%s"--
UI.TEXT_1212443 = languageManagerInstance:getLocalString(1112284)--"已抽取"
UI.TEXT_1212444 = languageManagerInstance:getLocalString(1112285)--"是否愿意刷新幸运转盘？"
UI.TEXT_1212445 = languageManagerInstance:getLocalString(1112289)--"当前幸运值未满"
UI.TEXT_1212446 = languageManagerInstance:getLocalString(1112361)--"当前抽取次数已用完，可以免费刷新转盘。"
UI.TEXT_1212447 = languageManagerInstance:getLocalString(1113001)--"下次自动刷新 今日24点" --
UI.TEXT_1212448 = languageManagerInstance:getLocalString(1112767) -- "启用"
UI.TEXT_1212449 = languageManagerInstance:getLocalString(1112768) -- "启用成功"


--占星
UI.TEXT_1212450 = languageManagerInstance:getLocalString(1111991)--"占星"
UI.TEXT_1212451 = languageManagerInstance:getLocalString(1111992)--"装配"
UI.TEXT_1212452 = languageManagerInstance:getLocalString(1111993)--"吞噬"
UI.TEXT_1212453 = languageManagerInstance:getLocalString(1111994)--"一键吞噬"
UI.TEXT_1212454 = languageManagerInstance:getLocalString(1111995)--"一键装备"
UI.TEXT_1212455 = languageManagerInstance:getLocalString(1111996)--"已经没有空位装星恒"
UI.TEXT_1212456 = languageManagerInstance:getLocalString(1111997)--"需要选择对应的物品才能吞噬"
UI.TEXT_1212457 = languageManagerInstance:getLocalString(1111998)--"材料不能为空"
UI.TEXT_1212458 = languageManagerInstance:getLocalString(1111999)--"吞噬成功"
UI.TEXT_1212459 = languageManagerInstance:getLocalString(1112000)--"先选择需要目标"
UI.TEXT_1212460 = languageManagerInstance:getLocalString(1112001)--"确定将所有蓝色和白色的星痕吞噬掉吗？"
UI.TEXT_1212461 = languageManagerInstance:getLocalString(1112002)--"确定将这些星痕吞噬掉以提供给经验值吗？"
UI.TEXT_1212462 = languageManagerInstance:getLocalString(1112003)--"确定将这些星痕吞噬掉以提供给经验值吗？其中包含金色及以上品质的星痕！"
UI.TEXT_1212463 = languageManagerInstance:getLocalString(1112004)--"没有可以穿戴的星痕"
UI.TEXT_1212464 = languageManagerInstance:getLocalString(1112005)--"没有可以一键吞噬的星痕"
UI.TEXT_1212465 = languageManagerInstance:getLocalString(1112006)--"同一种星痕只能装备一个"
UI.TEXT_1212466 = languageManagerInstance:getLocalString(1112007)--"不能吞噬已锁定的星痕"
UI.TEXT_1212467 = languageManagerInstance:getLocalString(1112018)--"当前星痕已经满级"
UI.TEXT_1212468 = languageManagerInstance:getLocalString(1170220)--"吞噬背包已满，不能再加入"
UI.TEXT_1212469 = languageManagerInstance:getLocalString(1170221)--"背包已满，请吞噬星痕"


UI.TEXT_1212470 = languageManagerInstance:getLocalString(1111953)--"祈星价格会根据奖池发生变化"
UI.TEXT_1212471 = languageManagerInstance:getLocalString(1170218)
UI.TEXT_1212473 = languageManagerInstance:getLocalString(1112769) -- "变身阶段不能调整技能"
UI.TEXT_1212474 = languageManagerInstance:getLocalString(1112766) -- "下一等级才能升升级%s"

UI.TEXT_1212475 = languageManagerInstance:getLocalString(1114820) -- 星恒经验溢出了%s,确认要吞噬?

UI.TEXT_1212571 = languageManagerInstance:getLocalString(1112058) --"产出速度"
UI.TEXT_1212572 = languageManagerInstance:getLocalString(1112059) --"%s:约"
UI.TEXT_1212573 = languageManagerInstance:getLocalString(1112060) --"快速探险"
UI.TEXT_1212574 = languageManagerInstance:getLocalString(1112061) --"开始探险"
UI.TEXT_1212575 = languageManagerInstance:getLocalString(1112062) --"结束探险"
UI.TEXT_1212576 = languageManagerInstance:getLocalString(1112063) --"探险中"
UI.TEXT_1212577 = languageManagerInstance:getLocalString(1112064) --"普通探险袋"
UI.TEXT_1212578 = languageManagerInstance:getLocalString(1112065) --"快速探险袋"
UI.TEXT_1212579 = languageManagerInstance:getLocalString(1112066) --"探险中无法领取道具"
UI.TEXT_1212580 = languageManagerInstance:getLocalString(1112067) --"全选"
UI.TEXT_1212581 = languageManagerInstance:getLocalString(1112068) --"金色以上"
UI.TEXT_1212582 = languageManagerInstance:getLocalString(1112069) --"批量领取"
UI.TEXT_1212583 = languageManagerInstance:getLocalString(1112070) --"批量分解"
UI.TEXT_1212584 = languageManagerInstance:getLocalString(1112071) --"经验"
UI.TEXT_1212585 = languageManagerInstance:getLocalString(1112072) --"探险剩余时间"
UI.TEXT_1212586 = languageManagerInstance:getLocalString(1112079) --"你当前正在探险中，继续挑战将会中断探险，是否继续"
UI.TEXT_1212587 = languageManagerInstance:getLocalString(1112080) --"你当前正在探险中，接受邀请将会中断探险，是否继续"
UI.TEXT_1212588 = languageManagerInstance:getLocalString(1112081) --"请先领取探险袋中尚未领取的道具" -> "请先领取%s中尚未领取的道具"
UI.TEXT_1212589 = languageManagerInstance:getLocalString(1112082) --"快速探险已完成"
UI.TEXT_1212590 = languageManagerInstance:getLocalString(1112083) --"已结束探险"
UI.TEXT_1212591 = languageManagerInstance:getLocalString(1112095) --"已领取全部物品"
UI.TEXT_1212592 = languageManagerInstance:getLocalString(1112096) --"背包空间不足，已领取部分道具"
UI.TEXT_1212593 = languageManagerInstance:getLocalString(1112110) --"本日探险[%s],%s增加"

UI.TEXT_1212594 = languageManagerInstance:getLocalString(1112230) --"未达到领取等级"
UI.TEXT_1212596 = languageManagerInstance:getLocalString(1112231) --"该物品无法出售"
UI.TEXT_1212597 = languageManagerInstance:getLocalString(1112232) --"领取等级礼包"
UI.TEXT_1212598 = languageManagerInstance:getLocalString(1112233) --"等级%s可以开启"
UI.TEXT_1212599 = languageManagerInstance:getLocalString(1112253) --"没有可选择的道具"
UI.TEXT_1212600 = languageManagerInstance:getLocalString(1112254) --"立即获取"
UI.TEXT_1212601 = languageManagerInstance:getLocalString(1112255) --"每日获取"
UI.TEXT_1212602 = languageManagerInstance:getLocalString(1112256) --"探险队收益"
UI.TEXT_1212603 = languageManagerInstance:getLocalString(1112257) --"生效中"
UI.TEXT_1212604 = languageManagerInstance:getLocalString(1112258) --"未激活"
UI.TEXT_1212605 = languageManagerInstance:getLocalString(1112259) --"已激活"
UI.TEXT_1212606 = languageManagerInstance:getLocalString(1112260) --"购买%s将额外获得"
UI.TEXT_1212607 = languageManagerInstance:getLocalString(1112261) --"是否前往购买？"
UI.TEXT_1212608 = languageManagerInstance:getLocalString(1112301) --"确认消耗水晶进行占星？"
UI.TEXT_1212609 = languageManagerInstance:getLocalString(1112336)--"活动即将开始，请耐心等待"
UI.TEXT_1212610 = languageManagerInstance:getLocalString(1112362)--"刷新成功"--"刷新成功"
UI.TEXT_1212611 = languageManagerInstance:getLocalString(1112363)--"免费刷新" --"免费刷新"
UI.TEXT_1212612 = languageManagerInstance:getLocalString(1113631)--"探险证数量不足"
UI.TEXT_1212613 = languageManagerInstance:getLocalString(1113632)--"单次最大上限：%d"
UI.TEXT_1212614 = languageManagerInstance:getLocalString(1113633)--"材料已锁定请先解锁"
UI.TEXT_1212615 = languageManagerInstance:getLocalString(1113852)--"切换进度"

--worldboss
UI.TEXT_1212622 = languageManagerInstance:getLocalString(1112262) --"你死啦！"
UI.TEXT_1212623 = languageManagerInstance:getLocalString(1112263) --"倒计时结束后将再出生点自动复活"
UI.TEXT_1212624 = languageManagerInstance:getLocalString(1112264) --"立刻原地复活"
UI.TEXT_1212625 = languageManagerInstance:getLocalString(1112265) --"购买buff"
UI.TEXT_1212626 = languageManagerInstance:getLocalString(1112266) --"当前增加伤害"
UI.TEXT_1212627 = languageManagerInstance:getLocalString(1112267) --"以鼓舞次数%s"
UI.TEXT_1212628 = languageManagerInstance:getLocalString(1112268) --"购买一层鼓舞治理？"
UI.TEXT_1212629 = languageManagerInstance:getLocalString(1112269) --"成功抵御首领入侵"
UI.TEXT_1212630 = languageManagerInstance:getLocalString(1112270) --"伤害榜前5名"
UI.TEXT_1212631 = languageManagerInstance:getLocalString(1112271) --"最终击杀者"
UI.TEXT_1212632 = languageManagerInstance:getLocalString(1112272) --"伤害排名"
UI.TEXT_1212633 = languageManagerInstance:getLocalString(1112273) --"伤害%s"
UI.TEXT_1212634 = languageManagerInstance:getLocalString(1112274) --"离开战场"
UI.TEXT_1212635 = languageManagerInstance:getLocalString(1112275) --"副本关闭倒计时%s"
UI.TEXT_1212636 = languageManagerInstance:getLocalString(1112276) --"虚伪一代"

UI.TEXT_1212637 = languageManagerInstance:getLocalString(1112302) --"立即加入"
UI.TEXT_1212638 = languageManagerInstance:getLocalString(1112303) --"活动报名已截止"
UI.TEXT_1212639 = languageManagerInstance:getLocalString(1112304) --"报名作战"
UI.TEXT_1212640 = languageManagerInstance:getLocalString(1112305) --"报名截止倒计时"
UI.TEXT_1212641 = languageManagerInstance:getLocalString(1112306) --"入场截止倒计时"
UI.TEXT_1212642 = languageManagerInstance:getLocalString(1112307) --"返回战场"
UI.TEXT_1212643 = languageManagerInstance:getLocalString(1112308) --"刚刚的战斗已经结束了"
UI.TEXT_1212644 = languageManagerInstance:getLocalString(1112309) --"作战已经开始"
UI.TEXT_1212645 = languageManagerInstance:getLocalString(1112310) --"首领入侵"
UI.TEXT_1212646 = languageManagerInstance:getLocalString(1112311) --"挑战次数已用完"
UI.TEXT_1212647 = languageManagerInstance:getLocalString(1112312) --"挑战次数:"
UI.TEXT_1212648 = languageManagerInstance:getLocalString(1112313) --"首领歼灭奖励:"
UI.TEXT_1212649 = languageManagerInstance:getLocalString(1112314) --"补刀奖励:"
UI.TEXT_1212650 = languageManagerInstance:getLocalString(1112315) --"贡献奖励:"
UI.TEXT_1212651 = languageManagerInstance:getLocalString(1112316) --"基于你造成的伤害平分 %d 的奖金池"
UI.TEXT_1212652 = languageManagerInstance:getLocalString(1112317) --"等级不足"
UI.TEXT_1212653 = languageManagerInstance:getLocalString(1112318) --"(%d号战场装备间)"
UI.TEXT_1212654 = languageManagerInstance:getLocalString(1112319) --"更换房间(%ss)"
UI.TEXT_1212655 = languageManagerInstance:getLocalString(1112320) --"不能频繁的更换房间"
UI.TEXT_1212656 = languageManagerInstance:getLocalString(1112321) --"放弃报名"
UI.TEXT_1212657 = languageManagerInstance:getLocalString(1112322) --"确认退出报名并离开房间吗？"
UI.TEXT_1212658 = languageManagerInstance:getLocalString(1112323) --"更换房间"
UI.TEXT_1212659 = languageManagerInstance:getLocalString(1112324) --"首领入侵活动已开始，请前往参加"
UI.TEXT_1212660 = languageManagerInstance:getLocalString(1112325) --"挑战次数已用完"
UI.TEXT_1212661 = languageManagerInstance:getLocalString(1112326) --"最小化准备间"
UI.TEXT_1212662 = languageManagerInstance:getLocalString(1112337) --"作战开始倒计时："
UI.TEXT_1212663 = languageManagerInstance:getLocalString(1112339) --"确认要离开主城场景吗？\n 离开主城将自动取消首领入侵的报名状态"
UI.TEXT_1212664 = languageManagerInstance:getLocalString(1112344)
UI.TEXT_1212665 = languageManagerInstance:getLocalString(1113020) --"洞窟内不能报名匹配"


-- 公会副本
UI.TEXT_1212700 = languageManagerInstance:getLocalString(1112346) --"每减少BOSS一条生命值即可获得奖励"
UI.TEXT_1212701 = languageManagerInstance:getLocalString(1112347) --"已获得"
UI.TEXT_1212702 = languageManagerInstance:getLocalString(1112348) --"前往挑战"
UI.TEXT_1212703 = languageManagerInstance:getLocalString(1112349) --"公会副本"
UI.TEXT_1212704 = languageManagerInstance:getLocalString(1112350) --"公会挑战"
UI.TEXT_1212705 = languageManagerInstance:getLocalString(1112351) --"%s 刚刚减少了 %s %s%% 的生命值"
UI.TEXT_1212706 = languageManagerInstance:getLocalString(1112352) --"%s 经过与 %s 的激烈战斗，给大家分享了%s个公会宝箱"
UI.TEXT_1212707 = languageManagerInstance:getLocalString(1112353) --"神秘的冒险者"
UI.TEXT_1212708 = languageManagerInstance:getLocalString(1112372) --"战斗中..."

--占星2.0
UI.TEXT_1212740 = languageManagerInstance:getLocalString(1112373) --"幸运值"
UI.TEXT_1212741 = languageManagerInstance:getLocalString(1112374) --"每个星球价格不一样"
UI.TEXT_1212742 = languageManagerInstance:getLocalString(1112445) --"祈星"


UI.TEXT_1212801 = languageManagerInstance:getLocalString(1112437) --"沙之眼"
UI.TEXT_1212802 = languageManagerInstance:getLocalString(1112447) --"沙之眼%d层"
UI.TEXT_1212803 = languageManagerInstance:getLocalString(1112458) --"扭曲空间"
UI.TEXT_1212804 = languageManagerInstance:getLocalString(1112449) --"扭曲空间%d层"
UI.TEXT_1212805 = languageManagerInstance:getLocalString(1112450) --"为了推荐符合您国家地区的广告，需要获取您的位置信息，是否前往开启权限？"
UI.TEXT_1212806 = languageManagerInstance:getLocalString(1112451) --"精英"

UI.TEXT_1212807 = languageManagerInstance:getLocalString(1112452) --"个人任务"
UI.TEXT_1212808 = languageManagerInstance:getLocalString(1112453) --"进度条："
UI.TEXT_1212809 = languageManagerInstance:getLocalString(1112454) --"任务奖励"
UI.TEXT_1212810 = languageManagerInstance:getLocalString(1112455) --"故事背景："
UI.TEXT_1212814 = languageManagerInstance:getLocalString(1112459) --"第%s层"

UI.TEXT_1212815 = languageManagerInstance:getLocalString(1112461) --"进行中..."
UI.TEXT_1212816 = languageManagerInstance:getLocalString(1112462) --"总进度条："
UI.TEXT_1212817 = languageManagerInstance:getLocalString(1112463) --"可挑战%d次" 
UI.TEXT_1212818 = languageManagerInstance:getLocalString(1112488) --"今日挑战次数已经用完"
    
UI.TEXT_1212836 = languageManagerInstance:getLocalString(1112464) --"首领激活"
UI.TEXT_1212837 = languageManagerInstance:getLocalString(1112465) --"预警值%s%%"
UI.TEXT_1212838 = languageManagerInstance:getLocalString(1112493) --"预警值%s%%"


--排行榜
UI.TEXT_1212850 = languageManagerInstance:getLocalString(1112412) --"沙之眼"
UI.TEXT_1212851 = languageManagerInstance:getLocalString(1112413) --"扭曲控件"

-- 装备移除等级
UI.TEXT_1212860 = languageManagerInstance:getLocalString(1112505) --"移除等级"
UI.TEXT_1212861 = languageManagerInstance:getLocalString(1112506) --"这件装备不能被移除穿戴等级"
UI.TEXT_1212862 = languageManagerInstance:getLocalString(1112507) --"需求材料"
UI.TEXT_1212863 = languageManagerInstance:getLocalString(1112508) --"确定将该装备穿戴需求等级移除？"
UI.TEXT_1212864 = languageManagerInstance:getLocalString(1112510) --"移除装备穿戴等级失败"
UI.TEXT_1212865 = languageManagerInstance:getLocalString(1112511) --"移除装备穿戴等级成功"

--符文石操作优化
UI.TEXT_1212870 = languageManagerInstance:getLocalString(1112512) --"符合条件符文不足"
UI.TEXT_1212871 = languageManagerInstance:getLocalString(1112513) --"升级后不能穿戴了，不能升级了" 
UI.TEXT_1212872 = languageManagerInstance:getLocalString(1112514) --"自动装入"
UI.TEXT_1212873 = languageManagerInstance:getLocalString(1112706) --"已装配符文不能作为材料"
UI.TEXT_1212874 = languageManagerInstance:getLocalString(1112707) --"符文已满级"
UI.TEXT_1212875 = languageManagerInstance:getLocalString(1112770) -- "有符文石，不能强化"


UI.TEXT_1212899 = languageManagerInstance:getLocalString(1112547)--"在城镇才能使用"
UI.TEXT_1212900 = languageManagerInstance:getLocalString(1112587)--"通行证" 
UI.TEXT_1212901 = languageManagerInstance:getLocalString(1112588)--"奖励" 
UI.TEXT_1212902 = languageManagerInstance:getLocalString(1112589)--"第%d季" 
UI.TEXT_1212903 = languageManagerInstance:getLocalString(1112590)--"巴萨坦通行证等级" 
UI.TEXT_1212904 = languageManagerInstance:getLocalString(1112591)--"通行证经验 %d/%d" 
UI.TEXT_1212905 = languageManagerInstance:getLocalString(1112592)--"获取经验"
UI.TEXT_1212906 = languageManagerInstance:getLocalString(1112593)--"本赛季可购买：%d次"
UI.TEXT_1212907 = languageManagerInstance:getLocalString(1112594)--"金色通行证单品"
UI.TEXT_1212908 = languageManagerInstance:getLocalString(1112595)--"豪华通行证礼包"
UI.TEXT_1212909 = languageManagerInstance:getLocalString(1112596)--"获取途径"
UI.TEXT_1212910 = languageManagerInstance:getLocalString(1112597)--"商城获得"
UI.TEXT_1212911 = languageManagerInstance:getLocalString(1112598)--"活跃度获得"
UI.TEXT_1212912 = languageManagerInstance:getLocalString(1112599)--"去商城获得描述"
UI.TEXT_1212913 = languageManagerInstance:getLocalString(1112600)--"去活跃度获得描述"
UI.TEXT_1212914 = languageManagerInstance:getLocalString(1112723)--"战斗通行证描述"
UI.TEXT_1212915 = languageManagerInstance:getLocalString(1112602)--"你没有解锁日常活跃度功能，无法前往"
UI.TEXT_1212916 = languageManagerInstance:getLocalString(1112603)--"需要通行证等级lv.%s"
UI.TEXT_1212917 = languageManagerInstance:getLocalString(1112604)--"通行证货币不足"
UI.TEXT_1212918 = languageManagerInstance:getLocalString(1112771) --"首次到达对应层数后可以领取奖励"
UI.TEXT_1212919 = languageManagerInstance:getLocalString(1112772) --"一键领取"
UI.TEXT_1212920 = languageManagerInstance:getLocalString(1112773) --"第%d层首通奖励"
UI.TEXT_1212921 = languageManagerInstance:getLocalString(1112774) --"首通奖励"
UI.TEXT_1212922 = languageManagerInstance:getLocalString(1112795) --"奖励已领取"
UI.TEXT_1212923 = languageManagerInstance:getLocalString(1112796) --"没有奖励可领取"

UI.TEXT_1212930 = languageManagerInstance:getLocalString(1112742) --"免费加速"
UI.TEXT_1212931 = languageManagerInstance:getLocalString(1112743) --"免费猫饭"
UI.TEXT_1212932 = languageManagerInstance:getLocalString(1112744) --"免费转盘"
UI.TEXT_1212933 = languageManagerInstance:getLocalString(1112817) --"回收装备"

-- 洞窟迷阵
UI.TEXT_1213000 = languageManagerInstance:getLocalString(1112605)--"奖励结算"
UI.TEXT_1213001 = languageManagerInstance:getLocalString(1112606)--"前3名" 
UI.TEXT_1213002 = languageManagerInstance:getLocalString(1112607)--"时长"
UI.TEXT_1213003 = languageManagerInstance:getLocalString(1112608)--"倒计时：%d"
UI.TEXT_1213004 = languageManagerInstance:getLocalString(1112609)--"已领取最终奖励"
UI.TEXT_1213005 = languageManagerInstance:getLocalString(1112610)--"洞窟迷阵"
UI.TEXT_1213006 = languageManagerInstance:getLocalString(1112611)--"退出"

UI.TEXT_1213007 = languageManagerInstance:getLocalString(1112612)--"%s历经千辛万苦，抵达终点"
UI.TEXT_1213008 = languageManagerInstance:getLocalString(1112613)--"%s踩中了你的陷阱，被传送回出生点"
UI.TEXT_1213009 = languageManagerInstance:getLocalString(1112614)--"你踩中了%s的陷阱，被传送回出生点"
UI.TEXT_1213010 = languageManagerInstance:getLocalString(1112615)--"你获得了一个%s"
UI.TEXT_1213011 = languageManagerInstance:getLocalString(1112616)--"道具拥有数量达到上限"
UI.TEXT_1213012 = languageManagerInstance:getLocalString(1112617)--"你触发了传送阵，被传送至出生点"
UI.TEXT_1213013 = languageManagerInstance:getLocalString(1112618)--"你触发了传送阵，被传送至随机位置"
UI.TEXT_1213014 = languageManagerInstance:getLocalString(1112619)--"是否使用标记技能？"
UI.TEXT_1213015 = languageManagerInstance:getLocalString(1112620)--"%s的旗子"

UI.TEXT_1213016 = languageManagerInstance:getLocalString(1112657)--"立即参加"
UI.TEXT_1213017 = languageManagerInstance:getLocalString(1112658)--"起止时间"
UI.TEXT_1213018 = languageManagerInstance:getLocalString(1112659)--"开启时间:"
UI.TEXT_1213019 = languageManagerInstance:getLocalString(1112660)--"玩法介绍"
UI.TEXT_1213020 = languageManagerInstance:getLocalString(1112661)--"10级可参与洞窟迷阵"
UI.TEXT_1213021 = languageManagerInstance:getLocalString(1112662)--"请先停止其他玩法匹配"
UI.TEXT_1213022 = languageManagerInstance:getLocalString(1112663)--"取消匹配"
UI.TEXT_1213023 = languageManagerInstance:getLocalString(1112664)--"准备(%ss)"
UI.TEXT_1213024 = languageManagerInstance:getLocalString(1112665)--"已准备"
UI.TEXT_1213025 = languageManagerInstance:getLocalString(1170252)--"活动未开启"
UI.TEXT_1213026 = languageManagerInstance:getLocalString(1112833)--"领取节日礼物"
UI.TEXT_1213027 = languageManagerInstance:getLocalString(1170294)--"道具使用次数已达上限"


UI.TEXT_1213034 = languageManagerInstance:getLocalString(1112708)--"属性变化"
UI.TEXT_1213035 = languageManagerInstance:getLocalString(1112709)--"精炼成功"
UI.TEXT_1213036 = languageManagerInstance:getLocalString(1112710)--"转换"
UI.TEXT_1213037 = languageManagerInstance:getLocalString(1112711)--"选择转换装备"
UI.TEXT_1213038 = languageManagerInstance:getLocalString(1112712)--"需求材料"
UI.TEXT_1213039 = languageManagerInstance:getLocalString(1112713)--"转换成功"
UI.TEXT_1213040 = languageManagerInstance:getLocalString(1112714)--"材料不足"
UI.TEXT_1213041 = languageManagerInstance:getLocalString(1112715)--"精炼失败"
UI.TEXT_1213042 = languageManagerInstance:getLocalString(1112716)--"转换失败"
UI.TEXT_1213043 = languageManagerInstance:getLocalString(1112717)--"请放入需要精炼材料的同名装备"
UI.TEXT_1213044 = languageManagerInstance:getLocalString(1112718)--"已准备好精炼"
UI.TEXT_1213045 = languageManagerInstance:getLocalString(1112719)--"请放入需要精炼的装备"
UI.TEXT_1213046 = languageManagerInstance:getLocalString(1112720)--"请放入需要转换的套装"
UI.TEXT_1213047 = languageManagerInstance:getLocalString(1112721)--"已准备好转换"
UI.TEXT_1213048 = languageManagerInstance:getLocalString(1112722)--"一穿戴装备不可以作为精炼材料"
UI.TEXT_1213049 = languageManagerInstance:getLocalString(1112775) --"镶嵌有符文石的装备不能作为精炼材料"
UI.TEXT_1213050 = languageManagerInstance:getLocalString(1112776) --"镶嵌有符文石的装备不能转换"

-- 道具开背包
UI.TEXT_1213080 = languageManagerInstance:getLocalString(1112777) --"你需要寻找可以开背包格子的道具"
UI.TEXT_1213081 = languageManagerInstance:getLocalString(1112778) --"是否花费%s解锁%s格背包？"

-- 七日目标
UI.TEXT_1213090 = languageManagerInstance:getLocalString(1112727) -- 今日计划
UI.TEXT_1213091 = languageManagerInstance:getLocalString(1112728) -- 今日目标
UI.TEXT_1213092 = languageManagerInstance:getLocalString(1112729) -- 明日计划
UI.TEXT_1213093 = languageManagerInstance:getLocalString(1112730) -- 第%s日计划
UI.TEXT_1213094 = languageManagerInstance:getLocalString(1112731) -- 第%s天
UI.TEXT_1213095 = languageManagerInstance:getLocalString(1112732) -- 签到
UI.TEXT_1213096 = languageManagerInstance:getLocalString(1112733) -- 待签到
UI.TEXT_1213097 = languageManagerInstance:getLocalString(1112734) -- 完成所有计划可以获得神秘大奖
UI.TEXT_1213098 = languageManagerInstance:getLocalString(1112735) -- 累计签到七天可以获得神秘大奖
UI.TEXT_1213099 = languageManagerInstance:getLocalString(1112752) -- 活动时间: 
UI.TEXT_1213100 = languageManagerInstance:getLocalString(1112753) -- 进度:
UI.TEXT_1213101 = languageManagerInstance:getLocalString(1112758) -- 完成所有计划内容后开启
UI.TEXT_1213102 = languageManagerInstance:getLocalString(1112759) -- 累计签到7天后开启
UI.TEXT_1213103 = languageManagerInstance:getLocalString(1112760) -- 七日计划
UI.TEXT_1213104 = languageManagerInstance:getLocalString(1112761) -- 七日签到
UI.TEXT_1213105 = languageManagerInstance:getLocalString(1112762) -- 签到
UI.TEXT_1213106 = languageManagerInstance:getLocalString(1112763) -- 计划
UI.TEXT_1213109 = languageManagerInstance:getLocalString(1112754) -- 新人计划
UI.TEXT_1213110 = languageManagerInstance:getLocalString(1112755) -- 神秘礼物
UI.TEXT_1213111 = languageManagerInstance:getLocalString(1112756) -- 第%s日目标
UI.TEXT_1213112 = languageManagerInstance:getLocalString(1112757) -- 未开启
UI.TEXT_1213113 = languageManagerInstance:getLocalString(1112790) -- 当天任务未完成
UI.TEXT_1213114 = languageManagerInstance:getLocalString(1112815) -- 节日活动
UI.TEXT_1213115 = languageManagerInstance:getLocalString(1113680) --"34级套装"
UI.TEXT_1213116 = languageManagerInstance:getLocalString(1113681) --"完成所有计划领取"
UI.TEXT_1213117 = languageManagerInstance:getLocalString(1113682) --"钢铁加鲁鲁"
UI.TEXT_1213118 = languageManagerInstance:getLocalString(1113683) --"礼包"
UI.TEXT_1213119 = languageManagerInstance:getLocalString(1113684) --"特惠进阶礼包"
UI.TEXT_1213120 = languageManagerInstance:getLocalString(1113685) --"签完七日可领取"
UI.TEXT_1213121 = languageManagerInstance:getLocalString(1113686) --"使用探险卡"
UI.TEXT_1213122 = languageManagerInstance:getLocalString(1114219) --"限定幻化套装"
UI.TEXT_1213123 = languageManagerInstance:getLocalString(1114220) --"完成所有签到后领取"
UI.TEXT_1213124 = languageManagerInstance:getLocalString(1114221) --"双节签到"
UI.TEXT_1213125 = languageManagerInstance:getLocalString(1115276) --"中秋签到"


-- 快速下楼
UI.TEXT_1213200 = languageManagerInstance:getLocalString(1112779) --"前往下层"
UI.TEXT_1213202 = languageManagerInstance:getLocalString(1112811) --"变身状态不能使用魂器变身"
UI.TEXT_1213203 = languageManagerInstance:getLocalString(1112812) --"已装备符文石不能进行售卖"
UI.TEXT_1213204 = languageManagerInstance:getLocalString(1112813) --"变身状态下不能幻化"
UI.TEXT_1213205 = languageManagerInstance:getLocalString(1112814) --"技能视频预览"
UI.TEXT_1213206 = languageManagerInstance:getLocalString(1112888) --"聊天窗口"
UI.TEXT_1213207 = languageManagerInstance:getLocalString(1112889) --"世界"
UI.TEXT_1213208 = languageManagerInstance:getLocalString(1112890) --"当前聊天"
UI.TEXT_1213209 = languageManagerInstance:getLocalString(1112896) --"20 级才可在此频道发言"

--技能 标签页
UI.TEXT_1213215 = languageManagerInstance:getLocalString(1112835) --"技能页一"
UI.TEXT_1213216 = languageManagerInstance:getLocalString(1112836) --"技能页2"
UI.TEXT_1213217 = languageManagerInstance:getLocalString(1112837) --"技能切换异常"
UI.TEXT_1213218 = languageManagerInstance:getLocalString(1112853) --"是否确定将技能页进行切换？"

UI.TEXT_1213230 = languageManagerInstance:getLocalString(1112675) --"任务"
UI.TEXT_1213231 = languageManagerInstance:getLocalString(1112838) --"请前往洞窟中寻找点金神像"
UI.TEXT_1213232 = languageManagerInstance:getLocalString(1112839) --"你要找的目标不在这里"
UI.TEXT_1213233 = languageManagerInstance:getLocalString(1112840) --"请回到城镇后领取奖励"
UI.TEXT_1213234 = languageManagerInstance:getLocalString(1112841) --"请寻找点金神像点金"
UI.TEXT_1213235 = languageManagerInstance:getLocalString(1112842) --"请寻找附魔台附魔"
UI.TEXT_1213236 = languageManagerInstance:getLocalString(1112843) --"请回到城镇后进行强化"
UI.TEXT_1213237 = languageManagerInstance:getLocalString(1112844) --"请先前往城镇场景"
UI.TEXT_1213238 = languageManagerInstance:getLocalString(1112845) --"[主线]"
UI.TEXT_1213239 = languageManagerInstance:getLocalString(1112846) --"[金币]"
UI.TEXT_1213240 = languageManagerInstance:getLocalString(1112847) --"[公会]"
UI.TEXT_1213241 = languageManagerInstance:getLocalString(1112848) --"[经验]"
UI.TEXT_1213242 = languageManagerInstance:getLocalString(1112849) --"[日常]"
UI.TEXT_1213243 = languageManagerInstance:getLocalString(1112850) --"[进阶]"
UI.TEXT_1213244 = languageManagerInstance:getLocalString(1112851) --"[扭曲]"
UI.TEXT_1213245 = languageManagerInstance:getLocalString(1112852) --"[英雄]"
UI.TEXT_1213246 = languageManagerInstance:getLocalString(1112670) --"已完成"


	
UI.TEXT_1213259 = languageManagerInstance:getLocalString(1112876) --"继续探险"
UI.TEXT_1213260 = languageManagerInstance:getLocalString(1112877) --"前往下一层"
UI.TEXT_1213261 = languageManagerInstance:getLocalString(1112878) --"返回城镇"
UI.TEXT_1213262 = languageManagerInstance:getLocalString(1112879) --"安全回城"
UI.TEXT_1213263 = languageManagerInstance:getLocalString(1112880) --"再考虑一下"
UI.TEXT_1213264 = languageManagerInstance:getLocalString(1112881) --"贪婪抉择"
UI.TEXT_1213265 = languageManagerInstance:getLocalString(1112882) --"在深入就有微信，先回城不及一下吧"
UI.TEXT_1213266 = languageManagerInstance:getLocalString(1112883) --"特殊回城"
UI.TEXT_1213267 = languageManagerInstance:getLocalString(1112898) --"在考虑下"
UI.TEXT_1213268 = languageManagerInstance:getLocalString(1112899) --"选择好了"
UI.TEXT_1213269 = languageManagerInstance:getLocalString(1112900) --"选择中……"

-- 公会许愿池
UI.TEXT_1213270 = languageManagerInstance:getLocalString(1112918) --"许愿"
UI.TEXT_1213271 = languageManagerInstance:getLocalString(1112919) --"次数已用完"
UI.TEXT_1213272 = languageManagerInstance:getLocalString(1112920) --"许愿次数"
UI.TEXT_1213273 = languageManagerInstance:getLocalString(1112921) --"铜质幸运币(%d/%d)"
UI.TEXT_1213274 = languageManagerInstance:getLocalString(1112922) --"银质幸运币(%d/%d)"
UI.TEXT_1213275 = languageManagerInstance:getLocalString(1112923) --"%d天前"
UI.TEXT_1213276 = languageManagerInstance:getLocalString(1112916) --"许愿池"
UI.TEXT_1213277 = languageManagerInstance:getLocalString(1112954) --"[%s]现在可以领取了"
UI.TEXT_1213278 = languageManagerInstance:getLocalString(1113039) --"入会后24小时才能许愿"

-- 公会技能拓展
UI.TEXT_1213300 = languageManagerInstance:getLocalString(1112910) --"需要%sLV%d解锁"
UI.TEXT_1213301 = languageManagerInstance:getLocalString(1112911) --"当前科技未解锁，请先学习前置科技"
UI.TEXT_1213302 = languageManagerInstance:getLocalString(1112912) --"需要去科技页解锁新的科技"
UI.TEXT_1213303 = languageManagerInstance:getLocalString(1112913) --"公会天赋已经升到最高等级"

UI.TEXT_1213304 = languageManagerInstance:getLocalString(1112929) --"每日刷新进度"

UI.TEXT_1213305 = languageManagerInstance:getLocalString(1112952) --"邀请你加入我们的公会%s"--
UI.TEXT_1213306 = languageManagerInstance:getLocalString(1113003) --"已同意"
UI.TEXT_1213307 = languageManagerInstance:getLocalString(1113004) --"已拒绝"
UI.TEXT_1213308 = languageManagerInstance:getLocalString(1113019) --"[招募]<%s>%s"
UI.TEXT_1213309 = languageManagerInstance:getLocalString(1113038) --"公会许愿池玩法说明"
UI.TEXT_1213310 = languageManagerInstance:getLocalString(1113422)--"感谢你对公会做出的贡献"
UI.TEXT_1213311 = languageManagerInstance:getLocalString(1116139)--"需要达到%s解锁"
UI.TEXT_1213312 = languageManagerInstance:getLocalString(1116140)--"需要达到%s生效"


UI.TEXT_1213326 = languageManagerInstance:getLocalString(1112998) --"锤子过热，请稍后再试"

-- 异鼠
UI.TEXT_1213330 = languageManagerInstance:getLocalString(1112955) -- "异鼠必须死"
UI.TEXT_1213331 = languageManagerInstance:getLocalString(1112956) -- "已就位"
UI.TEXT_1213332 = languageManagerInstance:getLocalString(1112957) -- "等待确认"
UI.TEXT_1213333 = languageManagerInstance:getLocalString(1112958) -- "即将进入比赛场地"
UI.TEXT_1213334 = languageManagerInstance:getLocalString(1112959) -- "得分:"
UI.TEXT_1213335 = languageManagerInstance:getLocalString(1112960) -- "今日奖励已达上限"
UI.TEXT_1213336 = languageManagerInstance:getLocalString(1112961) -- "获得奖励:"
UI.TEXT_1213337 = languageManagerInstance:getLocalString(1112962) -- "你输了，请再接再厉"
UI.TEXT_1213338 = languageManagerInstance:getLocalString(1112963) -- "今日可领取:%d/%d"
UI.TEXT_1213339 = languageManagerInstance:getLocalString(1112964) -- "关闭倒计时: %ss"

-- 探险额外添加
UI.TEXT_1213406 = languageManagerInstance:getLocalString(1113011) --"附近关卡产出"
UI.TEXT_1213407 = languageManagerInstance:getLocalString(1113012) --"有新的进度解锁，探险队是否同步为该进度"
UI.TEXT_1213408 = languageManagerInstance:getLocalString(1113013) --"开始探险成功"
UI.TEXT_1213409 = languageManagerInstance:getLocalString(1113014) --"更新探险进度成功"
UI.TEXT_1213410 = languageManagerInstance:getLocalString(1113028) --"你已经解锁新的进度，可以到探险页面开始新的探险！"
UI.TEXT_1213411 = languageManagerInstance:getLocalString(1113021) --"洞窟中无法操作物品"
UI.TEXT_1213412 = languageManagerInstance:getLocalString(1113075) --"复活宠物"

UI.TEXT_1213421 = languageManagerInstance:getLocalString(1113051) --"十连抽%s次的提示语言"
UI.TEXT_1213422 = languageManagerInstance:getLocalString(1113050) --"快速占星"
UI.TEXT_1213423 = languageManagerInstance:getLocalString(1113096) --"快速模式不会使用金币占星"



--大裂谷，周年庆
UI.TEXT_1213432 = languageManagerInstance:getLocalString(1113076) --"惩罚时间%s"
UI.TEXT_1213433 = languageManagerInstance:getLocalString(1113077) --"确定"
UI.TEXT_1213434 = languageManagerInstance:getLocalString(1113078) --"匹配成功"
UI.TEXT_1213435 = languageManagerInstance:getLocalString(1113079) --"阵营"
UI.TEXT_1213436 = languageManagerInstance:getLocalString(1113080) --"首领"
UI.TEXT_1213437 = languageManagerInstance:getLocalString(1113081) --"获得奖励"
UI.TEXT_1213438 = languageManagerInstance:getLocalString(1113082) --"今日已领取：%s/%s"
UI.TEXT_1213439 = languageManagerInstance:getLocalString(1113083) --"采集成功"
UI.TEXT_1213440 = languageManagerInstance:getLocalString(1113084) --"采集失败"
UI.TEXT_1213441 = languageManagerInstance:getLocalString(1113088) --"无法攻击对方阵营首领，请根据箭头指示移动"
UI.TEXT_1213442 = languageManagerInstance:getLocalString(1113089) --"%s已被玩家%s拾取"
UI.TEXT_1213443 = languageManagerInstance:getLocalString(1113090) --"采集中"
UI.TEXT_1213444 = languageManagerInstance:getLocalString(1113091) --"采集失败"
UI.TEXT_1213445 = languageManagerInstance:getLocalString(1113092) --"复活倒计时"
UI.TEXT_1213446 = languageManagerInstance:getLocalString(1113093) --"目标"
UI.TEXT_1213447 = languageManagerInstance:getLocalString(1113094) --"结算"
UI.TEXT_1213448 = languageManagerInstance:getLocalString(1113095) --"由于检测到你存在挂机行为，将对你后续参与活动进行限制"
UI.TEXT_1213449 = languageManagerInstance:getLocalString(1113130) --"我方"
UI.TEXT_1213450 = languageManagerInstance:getLocalString(1113131) --"敌方"
UI.TEXT_1213451 = languageManagerInstance:getLocalString(1113249) --"拾取光环"
UI.TEXT_1213452 = languageManagerInstance:getLocalString(1113250) --"伤害：%s"
UI.TEXT_1213453 = languageManagerInstance:getLocalString(1070280) --"操作失败，请查看物品是否存在"

UI.TEXT_1213500 = languageManagerInstance:getLocalString(1113097) --"隐藏他人魂器"
UI.TEXT_1213501 = languageManagerInstance:getLocalString(1113099) --"开启其他玩家魂器显示"
UI.TEXT_1213502 = languageManagerInstance:getLocalString(1113100) --"开启其他玩家宠物显示"
UI.TEXT_1213503 = languageManagerInstance:getLocalString(1113098) --"隐藏他人宠物"
UI.TEXT_1213504 = languageManagerInstance:getLocalString(1113101) --"关闭其他玩家魂器显示"
UI.TEXT_1213505 = languageManagerInstance:getLocalString(1113102) --"关闭他人宠物显示"

UI.TEXT_1213506 = languageManagerInstance:getLocalString(1113129) --"野生%s出现了"
UI.TEXT_1213507 = languageManagerInstance:getLocalString(1113710) --"魂器状态下无法替换装备"
UI.TEXT_1213508 = languageManagerInstance:getLocalString(1113711) --"战斗中无法更换装备"

UI.TEXT_1213601 = languageManagerInstance:getLocalString(1113134) --"宠物"
UI.TEXT_1213602 = languageManagerInstance:getLocalString(1113135) --"属性"
UI.TEXT_1213603 = languageManagerInstance:getLocalString(1113136) --"培养"
UI.TEXT_1213604 = languageManagerInstance:getLocalString(1113137) --"合成"
UI.TEXT_1213605 = languageManagerInstance:getLocalString(1113138) --"炼化"
UI.TEXT_1213606 = languageManagerInstance:getLocalString(1113139) --"图鉴"
UI.TEXT_1213607 = languageManagerInstance:getLocalString(1113140) --"突破成功"
UI.TEXT_1213608 = languageManagerInstance:getLocalString(1113141) --"突破后"
UI.TEXT_1213609 = languageManagerInstance:getLocalString(1113142) --"突破前"
UI.TEXT_1213610 = languageManagerInstance:getLocalString(1113143) --"升级后已超过角色等级，无法升级"
UI.TEXT_1213611 = languageManagerInstance:getLocalString(1113144) --"材料数量不足"
UI.TEXT_1213612 = languageManagerInstance:getLocalString(1113145) --"基础属性"
UI.TEXT_1213613 = languageManagerInstance:getLocalString(1113146) --"资质技能"
UI.TEXT_1213614 = languageManagerInstance:getLocalString(1113147) --"出战"
UI.TEXT_1213615 = languageManagerInstance:getLocalString(1113148) --"此宠物已出战"
UI.TEXT_1213616 = languageManagerInstance:getLocalString(1113149) --"战斗中不能出战"
UI.TEXT_1213617 = languageManagerInstance:getLocalString(1113150) --"此宠物已出战"
UI.TEXT_1213618 = languageManagerInstance:getLocalString(1113151) --"经验"
UI.TEXT_1213619 = languageManagerInstance:getLocalString(1113152) --"等级已满，无法升级"
UI.TEXT_1213620 = languageManagerInstance:getLocalString(1113153) --"等级无法超过角色等级"
UI.TEXT_1213621 = languageManagerInstance:getLocalString(1113154) --"请放入宠物"
UI.TEXT_1213622 = languageManagerInstance:getLocalString(1113155) --"合成"
UI.TEXT_1213623 = languageManagerInstance:getLocalString(1113156) --"请选择一个宠物"
UI.TEXT_1213624 = languageManagerInstance:getLocalString(1113157) --"无可用次数"
UI.TEXT_1213625 = languageManagerInstance:getLocalString(1113158) --"材料不足，无法合成"
UI.TEXT_1213626 = languageManagerInstance:getLocalString(1113159) --"确定要合成吗？"
UI.TEXT_1213627 = languageManagerInstance:getLocalString(1113160) --"无可用次数"
UI.TEXT_1213628 = languageManagerInstance:getLocalString(1113161) --"出战宠物无法用于合成"
UI.TEXT_1213629 = languageManagerInstance:getLocalString(1113162) --"攻击型"
UI.TEXT_1213630 = languageManagerInstance:getLocalString(1113163) --"防御型"
UI.TEXT_1213631 = languageManagerInstance:getLocalString(1113164) --"均衡型"
UI.TEXT_1213632 = languageManagerInstance:getLocalString(1113165) --"特殊型"
UI.TEXT_1213633 = languageManagerInstance:getLocalString(1113166) --"物攻资质"
UI.TEXT_1213634 = languageManagerInstance:getLocalString(1113167) --"物防资质"
UI.TEXT_1213635 = languageManagerInstance:getLocalString(1113168) --"法攻资质"
UI.TEXT_1213636 = languageManagerInstance:getLocalString(1113169) --"法防资质"
UI.TEXT_1213637 = languageManagerInstance:getLocalString(1113170) --"元素资质"
UI.TEXT_1213638 = languageManagerInstance:getLocalString(1113171) --"抗性资质"
UI.TEXT_1213639 = languageManagerInstance:getLocalString(1113172) --"生命资质"
UI.TEXT_1213640 = languageManagerInstance:getLocalString(1113173) --"每级提升%d攻击力"
UI.TEXT_1213641 = languageManagerInstance:getLocalString(1113174) --"选择"
UI.TEXT_1213642 = languageManagerInstance:getLocalString(1113175) --"炼化为%d颗资质丹"
UI.TEXT_1213643 = languageManagerInstance:getLocalString(1113176) --"炼化资质丹的宠物必须达到满级"
UI.TEXT_1213644 = languageManagerInstance:getLocalString(1113177) --"炼化"
UI.TEXT_1213645 = languageManagerInstance:getLocalString(1113178) --"炼化成功"
UI.TEXT_1213646 = languageManagerInstance:getLocalString(1113179) --"未选择炼化类型"
UI.TEXT_1213647 = languageManagerInstance:getLocalString(1113180) --"请选择资质丹"
UI.TEXT_1213648 = languageManagerInstance:getLocalString(1113181) --"请选择一种技能"
UI.TEXT_1213649 = languageManagerInstance:getLocalString(1113182) --"确定要炼化吗？"
UI.TEXT_1213650 = languageManagerInstance:getLocalString(1113183) --"出战宠物无法炼化"
UI.TEXT_1213651 = languageManagerInstance:getLocalString(1113184) --"百变宠物无法用于炼化"
UI.TEXT_1213652 = languageManagerInstance:getLocalString(1113185) --"珍兽变异！"
UI.TEXT_1213653 = languageManagerInstance:getLocalString(1113186) --"恭喜获得珍兽！"
UI.TEXT_1213654 = languageManagerInstance:getLocalString(1113187) --"宠物变异！"
UI.TEXT_1213655 = languageManagerInstance:getLocalString(1113188) --"恭喜获得宠物！"
UI.TEXT_1213656 = languageManagerInstance:getLocalString(1113189) --"合成成功"
UI.TEXT_1213657 = languageManagerInstance:getLocalString(1113190) --"洗炼成功"
UI.TEXT_1213658 = languageManagerInstance:getLocalString(1113191) --"洗炼完成"
UI.TEXT_1213659 = languageManagerInstance:getLocalString(1113192) --"洗练重生"
UI.TEXT_1213660 = languageManagerInstance:getLocalString(1113193) --"资质突破"
UI.TEXT_1213661 = languageManagerInstance:getLocalString(1113194) --"学习技能"
UI.TEXT_1213662 = languageManagerInstance:getLocalString(1113195) --"连续洗炼"
UI.TEXT_1213663 = languageManagerInstance:getLocalString(1113196) --"洗炼"
UI.TEXT_1213664 = languageManagerInstance:getLocalString(1113197) --"连续洗炼（出现变异时将自动停止）"
UI.TEXT_1213665 = languageManagerInstance:getLocalString(1113198) --"请到洞窟外进行此操作"
UI.TEXT_1213666 = languageManagerInstance:getLocalString(1113199) --"洗炼材料不足，无法连续洗炼"
UI.TEXT_1213667 = languageManagerInstance:getLocalString(1113200) --"停止洗炼"
UI.TEXT_1213668 = languageManagerInstance:getLocalString(1113201) --"洗炼丹不足"
UI.TEXT_1213669 = languageManagerInstance:getLocalString(1113202) --"%d/次"
UI.TEXT_1213670 = languageManagerInstance:getLocalString(1113203) --"确定要进行连续洗炼吗？"
UI.TEXT_1213671 = languageManagerInstance:getLocalString(1113204) --"确定要洗炼吗？"
UI.TEXT_1213672 = languageManagerInstance:getLocalString(1113205) --"使用"
UI.TEXT_1213673 = languageManagerInstance:getLocalString(1113206) --"资质已满，无法提升"
UI.TEXT_1213674 = languageManagerInstance:getLocalString(1113207) --"材料不足"
UI.TEXT_1213675 = languageManagerInstance:getLocalString(1113208) --"随机提升%d-%d点"
UI.TEXT_1213676 = languageManagerInstance:getLocalString(1113209) --"学习技能可能覆盖原技能"
UI.TEXT_1213677 = languageManagerInstance:getLocalString(1113210) --"可用技能书"
UI.TEXT_1213678 = languageManagerInstance:getLocalString(1113211) --"你使用了[#goodsname]X%s"
UI.TEXT_1213679 = languageManagerInstance:getLocalString(1113231) --"你没有任何经验胡萝卜"
UI.TEXT_1213680 = languageManagerInstance:getLocalString(1113239) --"宠物背包"
UI.TEXT_1213681 = languageManagerInstance:getLocalString(1113251) --"经验炼化"
UI.TEXT_1213682 = languageManagerInstance:getLocalString(1113252) --"资质炼化"
UI.TEXT_1213683 = languageManagerInstance:getLocalString(1113253) --"技能炼化"
UI.TEXT_1213684 = languageManagerInstance:getLocalString(1113254) --"*无可选技能"
UI.TEXT_1213685 = languageManagerInstance:getLocalString(1113259) --"请选择一个炼化方向"
UI.TEXT_1213686 = languageManagerInstance:getLocalString(1117211) --"保留宠物"
UI.TEXT_1213687 = languageManagerInstance:getLocalString(1117212) --"确定要炼化吗？（炼化后该宠物将变回宠物蛋）"



UI.TEXT_1213700  = languageManagerInstance:getLocalString(1113212) --"全部"
UI.TEXT_1213701  = languageManagerInstance:getLocalString(1113213) --"普通"
UI.TEXT_1213702  = languageManagerInstance:getLocalString(1113214) --"变异"
UI.TEXT_1213703  = languageManagerInstance:getLocalString(1113215) --"虚位以待"
UI.TEXT_1213704  = languageManagerInstance:getLocalString(1113216) --"您尚未获得该宠物"
UI.TEXT_1213705  = languageManagerInstance:getLocalString(1113217) --"还没有人获得该排名"
UI.TEXT_1213706  = languageManagerInstance:getLocalString(1113218) --"初始技能可能为："
UI.TEXT_1213707  = languageManagerInstance:getLocalString(1113219) --"使用"
UI.TEXT_1213708  = languageManagerInstance:getLocalString(1113220) --"快捷购买重生果实"
UI.TEXT_1213709  = languageManagerInstance:getLocalString(1113221) --"已学习此技能"
UI.TEXT_1213710  = languageManagerInstance:getLocalString(1113222) --"普通技能书"
UI.TEXT_1213711  = languageManagerInstance:getLocalString(1113223) --"高级技能书"
UI.TEXT_1213712  = languageManagerInstance:getLocalString(1113224) --"技能描述："
UI.TEXT_1213713  = languageManagerInstance:getLocalString(1113225) --"宠物背包已满"
UI.TEXT_1213714  = languageManagerInstance:getLocalString(1113226) --"确定要使用吗？"
UI.TEXT_1213715  = languageManagerInstance:getLocalString(1113227) --"特殊产出"
UI.TEXT_1213716  = languageManagerInstance:getLocalString(1113228) --"来源:"
UI.TEXT_1213717  = languageManagerInstance:getLocalString(1113229) --"等级上限：%d级"
UI.TEXT_1213718  = languageManagerInstance:getLocalString(1113230) --"改名"
UI.TEXT_1213719  = languageManagerInstance:getLocalString(1113240) --"每级提升%s攻击力"
UI.TEXT_1213720  = languageManagerInstance:getLocalString(1113241) --"每级提升%s物理防御"
UI.TEXT_1213721  = languageManagerInstance:getLocalString(1113242) --"每级提升%s魔力"
UI.TEXT_1213722  = languageManagerInstance:getLocalString(1113243) --"每级提升%s魔法防御"
UI.TEXT_1213723  = languageManagerInstance:getLocalString(1113244) --"每级提升%s元素攻击"
UI.TEXT_1213724  = languageManagerInstance:getLocalString(1113245) --"每级提升%s元素防御"
UI.TEXT_1213725  = languageManagerInstance:getLocalString(1113246) --"每级提升%s生命值"
UI.TEXT_1213726  = languageManagerInstance:getLocalString(1113247) --"你还没有获得宠物"
UI.TEXT_1213727  = languageManagerInstance:getLocalString(1113248) --"储备血量已满"
UI.TEXT_1213728  = languageManagerInstance:getLocalString(1113255) --"宠物改名"
UI.TEXT_1213729  = languageManagerInstance:getLocalString(1113257) --"该技能位有概率通过技能书习得技能"

UI.TEXT_1213730  = languageManagerInstance:getLocalString(1110070) --"物理防御"
UI.TEXT_1213731  = languageManagerInstance:getLocalString(1110071) --"魔法防御"
UI.TEXT_1213732  = languageManagerInstance:getLocalString(1110072) --"生命值"
UI.TEXT_1213733  = languageManagerInstance:getLocalString(1110073) --"格挡值"
UI.TEXT_1213734  = languageManagerInstance:getLocalString(1110074) --"格挡率"
UI.TEXT_1213735  = languageManagerInstance:getLocalString(1110075) --"魔法值"
UI.TEXT_1213736  = languageManagerInstance:getLocalString(1110076) --"物理穿透"
UI.TEXT_1213737  = languageManagerInstance:getLocalString(1110077) --"魔法穿透"
UI.TEXT_1213738  = languageManagerInstance:getLocalString(1110078) --"暴击率"
UI.TEXT_1213739  = languageManagerInstance:getLocalString(1110079) --"闪避率"
UI.TEXT_1213740  = languageManagerInstance:getLocalString(1110080) --"火攻击"
UI.TEXT_1213741  = languageManagerInstance:getLocalString(1110081) --"水攻击"
UI.TEXT_1213742  = languageManagerInstance:getLocalString(1110082) --"木攻击"
UI.TEXT_1213743  = languageManagerInstance:getLocalString(1110083) --"光攻击"
UI.TEXT_1213744  = languageManagerInstance:getLocalString(1110084) --"暗攻击"
UI.TEXT_1213745  = languageManagerInstance:getLocalString(1110085) --"火防御"
UI.TEXT_1213746  = languageManagerInstance:getLocalString(1110086) --"水防御"
UI.TEXT_1213747  = languageManagerInstance:getLocalString(1110087) --"木防御"
UI.TEXT_1213748  = languageManagerInstance:getLocalString(1110088) --"光防御"
UI.TEXT_1213749  = languageManagerInstance:getLocalString(1110089) --"暗防御"
UI.TEXT_1213750  = languageManagerInstance:getLocalString(1110067) --"攻击间隔"
UI.TEXT_1213751  = languageManagerInstance:getLocalString(1110141) --"攻击力"
UI.TEXT_1213752  = languageManagerInstance:getLocalString(1110069) --"魔力"
UI.TEXT_1213753  = languageManagerInstance:getLocalString(1113270) --"使用成功"
UI.TEXT_1213754  = languageManagerInstance:getLocalString(1113274) --"主动技能仅最新的生效，确认要再次学习主动技能吗？"
UI.TEXT_1213755  = languageManagerInstance:getLocalString(1113275) --"超高资质"

UI.TEXT_1213781  = languageManagerInstance:getLocalString(1113277) --"图像设置"
UI.TEXT_1213782  = languageManagerInstance:getLocalString(1113278) --"预设"
UI.TEXT_1213783  = languageManagerInstance:getLocalString(1113279) --"流畅"
UI.TEXT_1213784  = languageManagerInstance:getLocalString(1113280) --"标准"
UI.TEXT_1213785  = languageManagerInstance:getLocalString(1113281) --"极致"
UI.TEXT_1213786  = languageManagerInstance:getLocalString(1113282) --"自定义"
UI.TEXT_1213787  = languageManagerInstance:getLocalString(1113283) --"天气效果"
UI.TEXT_1213788  = languageManagerInstance:getLocalString(1113284) --"NPC效果"
UI.TEXT_1213789  = languageManagerInstance:getLocalString(1113285) --"高帧率模式"
UI.TEXT_1213790  = languageManagerInstance:getLocalString(1113286) --"装饰物"
UI.TEXT_1213791  = languageManagerInstance:getLocalString(1113287) --"漂浮物"
UI.TEXT_1213792  = languageManagerInstance:getLocalString(1113288) --"魂器显示"
UI.TEXT_1213793  = languageManagerInstance:getLocalString(1113289) --"宠物显示"
UI.TEXT_1213794  = languageManagerInstance:getLocalString(1113290) --"同屏人数"
UI.TEXT_1213795  = languageManagerInstance:getLocalString(1113292) --"设置修改成功"
UI.TEXT_1213796  = languageManagerInstance:getLocalString(1113312) --"根据您的设备状况已为您的推荐画质设置\n【%s】"

--二阶技能相关
UI.TEXT_1213801 = languageManagerInstance:getLocalString(1113293) --"一阶技能"
UI.TEXT_1213802 = languageManagerInstance:getLocalString(1113294) --"二阶技能"
UI.TEXT_1213803 = languageManagerInstance:getLocalString(1113295) --"出战技能"
UI.TEXT_1213804 = languageManagerInstance:getLocalString(1113296) --"剑盾系加点:"
UI.TEXT_1213805 = languageManagerInstance:getLocalString(1113297) --"选择要出战的技能"
UI.TEXT_1213806 = languageManagerInstance:getLocalString(1113298) --"剑盾系加点："
UI.TEXT_1213807 = languageManagerInstance:getLocalString(1113299) --"大剑系加点："
UI.TEXT_1213808 = languageManagerInstance:getLocalString(1113300) --"法杖系加点："
UI.TEXT_1213809 = languageManagerInstance:getLocalString(1113301) --"需要剑盾系加点：%d"
UI.TEXT_1213810 = languageManagerInstance:getLocalString(1113302) --"需要大剑系加点：%d"
UI.TEXT_1213811 = languageManagerInstance:getLocalString(1113303) --"需要法杖系加点：%d"
UI.TEXT_1213812 = languageManagerInstance:getLocalString(1113304) --"需要%s技能等级：%d级"
UI.TEXT_1213813 = languageManagerInstance:getLocalString(1113305) --"二阶技能为专属武器限定"
UI.TEXT_1213814 = languageManagerInstance:getLocalString(1113306) --"或"
UI.TEXT_1213815 = languageManagerInstance:getLocalString(1113307) --"限制：无法与%s技能同时生效"
UI.TEXT_1213816 = languageManagerInstance:getLocalString(1113308) --"下一等级"
UI.TEXT_1213817 = languageManagerInstance:getLocalString(1113309) --"技能页%d"
UI.TEXT_1213818 = languageManagerInstance:getLocalString(1113310) --"%s技能不能与%s技能同时出战，是否替换？"
UI.TEXT_1213819 = languageManagerInstance:getLocalString(1113314) --"出战技能设置"
UI.TEXT_1213820 = languageManagerInstance:getLocalString(1113315)--"你被触手束缚了，快点点击逃命！"
UI.TEXT_1213821 = languageManagerInstance:getLocalString(1116118) --"与"

UI.TEXT_1213831 = languageManagerInstance:getLocalString(1113392) --"一月"
UI.TEXT_1213832 = languageManagerInstance:getLocalString(1113393) --"二月"
UI.TEXT_1213833 = languageManagerInstance:getLocalString(1113394) --"三月"
UI.TEXT_1213834 = languageManagerInstance:getLocalString(1113395) --"四月"
UI.TEXT_1213835 = languageManagerInstance:getLocalString(1113396) --"五月"
UI.TEXT_1213836 = languageManagerInstance:getLocalString(1113397) --"六月"
UI.TEXT_1213837 = languageManagerInstance:getLocalString(1113398) --"七月"
UI.TEXT_1213838 = languageManagerInstance:getLocalString(1113399) --"八月"
UI.TEXT_1213839 = languageManagerInstance:getLocalString(1113400) --"九月"
UI.TEXT_1213840 = languageManagerInstance:getLocalString(1113401) --"十月"
UI.TEXT_1213841 = languageManagerInstance:getLocalString(1113402) --"十一月"
UI.TEXT_1213842 = languageManagerInstance:getLocalString(1113403) --"十二月"
UI.TEXT_1213843 = languageManagerInstance:getLocalString(1113404) --"春节签到"
UI.TEXT_1213844 = languageManagerInstance:getLocalString(1113405) --"已领奖励"
UI.TEXT_1213845 = languageManagerInstance:getLocalString(1113406) --"补签奖励"
UI.TEXT_1213846 = languageManagerInstance:getLocalString(1113407) --"今日奖励"
UI.TEXT_1213847 = languageManagerInstance:getLocalString(1113408) --"签到可领"
UI.TEXT_1213848 = languageManagerInstance:getLocalString(1113409) --"宜"
UI.TEXT_1213849 = languageManagerInstance:getLocalString(1113410) --"忌"
UI.TEXT_1213850 = languageManagerInstance:getLocalString(1113411) --"已签"
UI.TEXT_1213851 = languageManagerInstance:getLocalString(1113412) --"补签"
UI.TEXT_1213852 = languageManagerInstance:getLocalString(1113413) --"签到"
UI.TEXT_1213853 = languageManagerInstance:getLocalString(1113414) --"待签到"
UI.TEXT_1213854 = languageManagerInstance:getLocalString(1113415) --"只能在洞窟外签到"
UI.TEXT_1213855 = languageManagerInstance:getLocalString(1113416) --"确认消耗钻石进行补签？"

UI.TEXT_1213860 = languageManagerInstance:getLocalString(1113477) --"修改公会名"
UI.TEXT_1213861 = languageManagerInstance:getLocalString(1113478) --"职位自定义"
UI.TEXT_1213862 = languageManagerInstance:getLocalString(1110571) --"会长"
UI.TEXT_1213863 = languageManagerInstance:getLocalString(1112903) --"副会长"
UI.TEXT_1213864 = languageManagerInstance:getLocalString(1110572) --"管理"
UI.TEXT_1213865 = languageManagerInstance:getLocalString(1110573) --"成员"
UI.TEXT_1213866 = languageManagerInstance:getLocalString(1113479) --"确认消耗水晶修改职级名称吗?"
UI.TEXT_1213867 = languageManagerInstance:getLocalString(1113480) --"%s最多有%d位"
UI.TEXT_1213868 = languageManagerInstance:getLocalString(1113481) --"修改成功"
UI.TEXT_1213869 = languageManagerInstance:getLocalString(1113482) --"售罄"
UI.TEXT_1213870 = languageManagerInstance:getLocalString(1113436) --"贡献商店"
UI.TEXT_1213871 = languageManagerInstance:getLocalString(1113437) --"随机商店"
UI.TEXT_1213872 = languageManagerInstance:getLocalString(1113438) --"水晶商店"
UI.TEXT_1213873 = languageManagerInstance:getLocalString(1113452) --"所有货物已售罄，请明天再来吧"
UI.TEXT_1213874 = languageManagerInstance:getLocalString(1113453) --"新的商品已进货，快去看看吧"
UI.TEXT_1213875 = languageManagerInstance:getLocalString(1113454) --"确定刷新公会随机商店吗？"
UI.TEXT_1213876 = languageManagerInstance:getLocalString(1113455) --"(仅会对未购买的商品进行重新刷新)"
UI.TEXT_1213877 = languageManagerInstance:getLocalString(1113456) --"*仅会长或副会长可以研发科技"
UI.TEXT_1213878 = languageManagerInstance:getLocalString(1113457) --"当前还能贡献%d"
UI.TEXT_1213879 = languageManagerInstance:getLocalString(1113458) --"贡献已到达最大额度"
UI.TEXT_1213880 = languageManagerInstance:getLocalString(1113459) --"出价人"
UI.TEXT_1213881 = languageManagerInstance:getLocalString(1113460) --"竞价"
UI.TEXT_1213882 = languageManagerInstance:getLocalString(1113461) --"一口价"
UI.TEXT_1213883 = languageManagerInstance:getLocalString(1113462) --"最高出价人"
UI.TEXT_1213884 = languageManagerInstance:getLocalString(1113463) --"当前价"
UI.TEXT_1213885 = languageManagerInstance:getLocalString(1113464) --"我的出价"
UI.TEXT_1213886 = languageManagerInstance:getLocalString(1113465) --"剩余出价时间: %s"
UI.TEXT_1213887 = languageManagerInstance:getLocalString(1113466) --"拍卖"
UI.TEXT_1213888 = languageManagerInstance:getLocalString(1113467) --"我的"
UI.TEXT_1213889 = languageManagerInstance:getLocalString(1113468) --"记录"
UI.TEXT_1213890 = languageManagerInstance:getLocalString(1113469) --"拍卖尚未开启"
UI.TEXT_1213891 = languageManagerInstance:getLocalString(1113470) --"拍卖已截止"
UI.TEXT_1213892 = languageManagerInstance:getLocalString(1113471) --"出价"
UI.TEXT_1213893 = languageManagerInstance:getLocalString(1113472) --"加价"
UI.TEXT_1213894 = languageManagerInstance:getLocalString(1113473) --"当前竞价:"
UI.TEXT_1213895 = languageManagerInstance:getLocalString(1113474) --"你的出价"
UI.TEXT_1213896 = languageManagerInstance:getLocalString(1113475) --"确定购买吗？"
UI.TEXT_1213897 = languageManagerInstance:getLocalString(1113476) --"货币不足"
UI.TEXT_1213898 = languageManagerInstance:getLocalString(1113485) --"持有水晶太少，不足以出价"
UI.TEXT_1213899 = languageManagerInstance:getLocalString(1113486) --"出价已达到上限，无法再加价"
UI.TEXT_1213900 = languageManagerInstance:getLocalString(1113313) --"-- 新年倒计时 --"
UI.TEXT_1213901 = languageManagerInstance:getLocalString(1113487) --"【%s】无人出价，最终流拍，系统以%d水晶回收"
UI.TEXT_1213902 = languageManagerInstance:getLocalString(1113488) --"【%s】被【%s】以%d水晶购得"
UI.TEXT_1213903 = languageManagerInstance:getLocalString(1113489) --"商品已售出"
UI.TEXT_1213904 = languageManagerInstance:getLocalString(1113490) --"价格已更新，请重新出价"
UI.TEXT_1213905 = languageManagerInstance:getLocalString(1113491) --"出价成功！"
UI.TEXT_1213906 = languageManagerInstance:getLocalString(1113492) --"货物已更新"
UI.TEXT_1213907 = languageManagerInstance:getLocalString(1113493) --"下次进货时间:"
UI.TEXT_1213908 = languageManagerInstance:getLocalString(1113494) --"你没有任何出价记录"
UI.TEXT_1213909 = languageManagerInstance:getLocalString(1113495) --"拍卖开启倒计时:%s"
UI.TEXT_1213910 = languageManagerInstance:getLocalString(1113496) --"本周没有拍卖商品"
UI.TEXT_1213911 = languageManagerInstance:getLocalString(1113497) --"输入价格不合法"
UI.TEXT_1213912 = languageManagerInstance:getLocalString(1113498) --"出价失败，拍卖已截止"
UI.TEXT_1213913 = languageManagerInstance:getLocalString(1113512) --"你错过了本场拍卖的入场时间"
UI.TEXT_1213914 = languageManagerInstance:getLocalString(1170282) --你不能参加本周的拍卖"
UI.TEXT_1213915 = languageManagerInstance:getLocalString(1170283) --"商人还需要准备%d天"
UI.TEXT_1213916 = languageManagerInstance:getLocalString(1170284) --"你不能参加本周的鉴定"

UI.TEXT_1213950 = languageManagerInstance:getLocalString(1113502) --"发布成功"
UI.TEXT_1213951 = languageManagerInstance:getLocalString(1113503) --"已发布"
UI.TEXT_1213952 = languageManagerInstance:getLocalString(1113504) --"鉴定"
UI.TEXT_1213954 = languageManagerInstance:getLocalString(1113505) --"本周进货进行中"
UI.TEXT_1213955 = languageManagerInstance:getLocalString(1113506) --"本周进货已截止"
UI.TEXT_1213956 = languageManagerInstance:getLocalString(1113507) --"本周已经进货完毕"
UI.TEXT_1213957 = languageManagerInstance:getLocalString(1113508) --"梦境等级不足"
UI.TEXT_1213958 = languageManagerInstance:getLocalString(1113509) --"连续点击被封印的栏位破除阴影封印"
UI.TEXT_1213959 = languageManagerInstance:getLocalString(1113510) --"仅会长可以鉴定宝物"
UI.TEXT_1213960 = languageManagerInstance:getLocalString(1113511) --"【%s】%s刚刚发布了令状 %s！"
UI.TEXT_1213961 = languageManagerInstance:getLocalString(1113543)--"%s天"
UI.TEXT_1213963 = languageManagerInstance:getLocalString(1113572)--"战斗角色人数不足"
UI.TEXT_1213964 = languageManagerInstance:getLocalString(1113573)--"己方"
UI.TEXT_1213965 = languageManagerInstance:getLocalString(1113574)--"敌方"
UI.TEXT_1213966 = languageManagerInstance:getLocalString(1113575)--"伤害"
UI.TEXT_1213967 = languageManagerInstance:getLocalString(1113576)--"治疗"
UI.TEXT_1213968 = languageManagerInstance:getLocalString(1113628)--"你被诅咒了！请小心使用技能！"

UI.TEXT_1314050 = languageManagerInstance:getLocalString(1170286)-- "出战宠物无法进行传承"
UI.TEXT_1314051 = languageManagerInstance:getLocalString(1170287)-- "百变怪无法进行传承"
UI.TEXT_1314052 = languageManagerInstance:getLocalString(1170288)-- "相同宠物无法进行传承"
UI.TEXT_1314053 = languageManagerInstance:getLocalString(1170289)-- "没有可用于传承的技能"
UI.TEXT_1314054 = languageManagerInstance:getLocalString(1170290)-- "宠物的技能数量不足"
UI.TEXT_1314055 = languageManagerInstance:getLocalString(1170291)-- "宠物技能槽数量不足"
UI.TEXT_1314056 = languageManagerInstance:getLocalString(1170292)-- "一次只能传承一只宠物的技能"
UI.TEXT_1314057 = languageManagerInstance:getLocalString(1170293)-- "没有选择要传承的宠物"
UI.TEXT_1314058 = languageManagerInstance:getLocalString(1113546)-- "传承"
UI.TEXT_1314059 = languageManagerInstance:getLocalString(1113545)-- "恭喜你！传承成功"
UI.TEXT_1314060 = languageManagerInstance:getLocalString(1113547)-- "传承后的技能"1113544
UI.TEXT_1314061 = languageManagerInstance:getLocalString(1113544)-- "确定要传承吗？"
UI.TEXT_1314062 = languageManagerInstance:getLocalString(1113626)-- "你将炼化%s只宠物"
UI.TEXT_1314063 = languageManagerInstance:getLocalString(1113627)-- "可获得"
UI.TEXT_1314064 = languageManagerInstance:getLocalString(1115687)-- "只能平级或向上传承"

UI.TEXT_1314100 = languageManagerInstance:getLocalString(1113555)-- "神秘宝藏"
UI.TEXT_1314101 = languageManagerInstance:getLocalString(1113556)-- "宝藏挖掘"
UI.TEXT_1314102 = languageManagerInstance:getLocalString(1113557)-- "守卫配置"
UI.TEXT_1314103 = languageManagerInstance:getLocalString(1113558)-- "我的阵容"
UI.TEXT_1314104 = languageManagerInstance:getLocalString(1113559)-- "阵容调整"
UI.TEXT_1314105 = languageManagerInstance:getLocalString(1113560)-- "召回"
UI.TEXT_1314106 = languageManagerInstance:getLocalString(1113561)-- "采集时间"
UI.TEXT_1314107 = languageManagerInstance:getLocalString(1113562)-- "累计金币"
UI.TEXT_1314108 = languageManagerInstance:getLocalString(1113563)-- "累计钻石"
UI.TEXT_1314109 = languageManagerInstance:getLocalString(1113564)-- "采集中…"
UI.TEXT_1314110 = languageManagerInstance:getLocalString(1113565)-- ""   采集结束
UI.TEXT_1314111 = languageManagerInstance:getLocalString(1113566)-- "神器收集"
UI.TEXT_1314112 = languageManagerInstance:getLocalString(1113567)-- "神器合成"
UI.TEXT_1314113 = languageManagerInstance:getLocalString(1113568)-- "防守战力"
UI.TEXT_1314114 = languageManagerInstance:getLocalString(1113569)-- "复仇"
UI.TEXT_1314115 = languageManagerInstance:getLocalString(1113570)-- "交战记录"
UI.TEXT_1314116 = languageManagerInstance:getLocalString(1113571)-- "【%s】战胜了你，抢走了【神器碎片】"
UI.TEXT_1314117 = languageManagerInstance:getLocalString(1113578)-- "战胜了"
UI.TEXT_1314118 = languageManagerInstance:getLocalString(1113579)-- "不自量力挑战"
UI.TEXT_1314119 = languageManagerInstance:getLocalString(1113580)-- "，抢走了【"
UI.TEXT_1314120 = languageManagerInstance:getLocalString(1113581)-- "，获得了【"
UI.TEXT_1314121 = languageManagerInstance:getLocalString(1113582)-- "神器碎片 %s】"
UI.TEXT_1314122 = languageManagerInstance:getLocalString(1113583)-- "，什么都没得到"
UI.TEXT_1314123 = languageManagerInstance:getLocalString(1113584)-- "，失败了"
UI.TEXT_1314124 = languageManagerInstance:getLocalString(1113585)-- "宝藏守卫"
UI.TEXT_1314125 = languageManagerInstance:getLocalString(1113586)-- "【%s】"
UI.TEXT_1314126 = languageManagerInstance:getLocalString(1113587)-- "神器碎片更新，挑战列表已刷新"  ---"目标已没有该神器碎片，挑战列表已刷新"
UI.TEXT_1314127 = languageManagerInstance:getLocalString(1113588)-- "今日合成碎片已达上限"
UI.TEXT_1314128 = languageManagerInstance:getLocalString(1113589)-- "上阵宠物数量不足"
UI.TEXT_1314129 = languageManagerInstance:getLocalString(1113590)-- "派遣超过一小时可召回"
UI.TEXT_1314130 = languageManagerInstance:getLocalString(1113591)-- "前往合成"
UI.TEXT_1314131 = languageManagerInstance:getLocalString(1113592)-- "好棒棒，碎片已经集齐，可以合成了耶"
UI.TEXT_1314132 = languageManagerInstance:getLocalString(1113593)-- "上阵位置已满"
UI.TEXT_1314133 = languageManagerInstance:getLocalString(1113594)-- "挑战成功"
UI.TEXT_1314134 = languageManagerInstance:getLocalString(1113595)-- "神器碎片数量不足"
UI.TEXT_1314135 = languageManagerInstance:getLocalString(1113600)-- "不能重复复仇"
UI.TEXT_1314136 = languageManagerInstance:getLocalString(1113601)-- "复仇时限已过"
UI.TEXT_1314137 = languageManagerInstance:getLocalString(1170081)-- "背包空间不足"
UI.TEXT_1314138 = languageManagerInstance:getLocalString(1113612)-- "对战目标已刷新"
UI.TEXT_1314139 = languageManagerInstance:getLocalString(1113613)-- "刷新冷却中"
UI.TEXT_1314140 = languageManagerInstance:getLocalString(1113614)-- "目标刷新失败"


-- hulu 活动副本
UI.TEXT_1324000 = languageManagerInstance:getLocalString(1111375)-- "大剑"
UI.TEXT_1324001 = languageManagerInstance:getLocalString(1111376)-- "剑盾"
UI.TEXT_1324002 = languageManagerInstance:getLocalString(1111377)-- "法杖"
UI.TEXT_1324003 = languageManagerInstance:getLocalString(1113602)-- "武器选择"


UI.TEXT_1324050 = languageManagerInstance:getLocalString(1113603)--"藏宝库"


-- 节日兑换活动
UI.TEXT_1324100 = languageManagerInstance:getLocalString(1113604)--"节日兑换"
UI.TEXT_1324101 = languageManagerInstance:getLocalString(1113605)--"%s后结束"
UI.TEXT_1324102 = languageManagerInstance:getLocalString(1113606)--"剩余%d次"
UI.TEXT_1324103 = languageManagerInstance:getLocalString(1113607)--"已换罄"
UI.TEXT_1324104 = languageManagerInstance:getLocalString(1113608)--"刷新就绪"
UI.TEXT_1324105 = languageManagerInstance:getLocalString(1113609)--"%s后刷新"

-- 宠物商店
UI.TEXT_1324200 = languageManagerInstance:getLocalString(1113625)--"灵魂粉尘数量不足，无法购买"
UI.TEXT_1324201 = languageManagerInstance:getLocalString(1113630)--"回收商店"
UI.TEXT_1324202 = languageManagerInstance:getLocalString(1113629)--"你没有宠物"

-- 梦境越阶挑战
UI.TEXT_1324300 = languageManagerInstance:getLocalString(1113634)--"梦境越阶挑战"
UI.TEXT_1324301 = languageManagerInstance:getLocalString(1113635)--"目标挑战等级"
UI.TEXT_1324302 = languageManagerInstance:getLocalString(1113636)--"越阶挑战时无法使用"
UI.TEXT_1324303 = languageManagerInstance:getLocalString(1113637)--"挑战进度%d/%d"
UI.TEXT_1324304 = languageManagerInstance:getLocalString(1113638)--"梦境等级提高"
UI.TEXT_1324305 = languageManagerInstance:getLocalString(1113639)--"梦境越阶挑战无法领"
UI.TEXT_1324306 = languageManagerInstance:getLocalString(1113640)--"当前不可进行越阶挑战"

-- 深渊扫荡
UI.TEXT_1324350 = languageManagerInstance:getLocalString(1113641)--"今日扫荡次数:%d/%d"
UI.TEXT_1324351 = languageManagerInstance:getLocalString(1113642)--"今日扫荡次数已达上限"
UI.TEXT_1324352 = languageManagerInstance:getLocalString(1113643)--"大秘境钥匙被已被锁定"
UI.TEXT_1324353 = languageManagerInstance:getLocalString(1113644)--"大秘境钥匙不足"
UI.TEXT_1324354 = languageManagerInstance:getLocalString(1113645)--"扫荡"
UI.TEXT_1324355 = languageManagerInstance:getLocalString(1113646)--"你将扫荡深渊%d层至%d层"
UI.TEXT_1324356 = languageManagerInstance:getLocalString(1113647)--"共计%d次"

-- 切服务器
UI.TEXT_1324360 = languageManagerInstance:getLocalString(1113687)--"所有服务器"
UI.TEXT_1324361 = languageManagerInstance:getLocalString(1113688)--"有角色服务器"
UI.TEXT_1324362 = languageManagerInstance:getLocalString(1113689)--"切换到服务器：%s,此操作生效需要重新加载游戏，是/否?"
UI.TEXT_1324363 = languageManagerInstance:getLocalString(1113692)--"你正在该服游戏中..."

-- -- 竞技场
-- UI.TEXT_1324400 = languageManagerInstance:getLocalString(1113693)--"挑战"
-- UI.TEXT_1324401 = languageManagerInstance:getLocalString(1113694)--"备战"
-- UI.TEXT_1324402 = languageManagerInstance:getLocalString(1110534) -- 排行榜
-- UI.TEXT_1324403 = languageManagerInstance:getLocalString(1113695)--"战斗记录"

-- UI.TEXT_1324404 = languageManagerInstance:getLocalString(1113696)--"赛季剩余时间:"
-- UI.TEXT_1324405 = languageManagerInstance:getLocalString(1113697)--"我的战绩"
-- UI.TEXT_1324406 = languageManagerInstance:getLocalString(1113698)--"积分"
-- UI.TEXT_1324407 = languageManagerInstance:getLocalString(1113699)--"赛季奖励"

-- 记忆翻牌
UI.TEXT_1324400 = languageManagerInstance:getLocalString(1113703)--"点击冷却中"
UI.TEXT_1324401 = languageManagerInstance:getLocalString(1113704)--"等待开始"
UI.TEXT_1324402 = languageManagerInstance:getLocalString(1113705)--"本次得分："
UI.TEXT_1324403 = languageManagerInstance:getLocalString(1113706)--"历史最高："

-- 遗物系统
UI.TEXT_1324450 = languageManagerInstance:getLocalString(1113713)--遗物
UI.TEXT_1324451 = languageManagerInstance:getLocalString(1170295)--请先选择装备栏处遗物
UI.TEXT_1324452 = languageManagerInstance:getLocalString(1170296)--确认对遗物进行强化？
UI.TEXT_1324453 = languageManagerInstance:getLocalString(1170297)--本次成功概率:%d%%
UI.TEXT_1324454 = languageManagerInstance:getLocalString(1170298)--请先卸下已装备的遗物
UI.TEXT_1324455 = languageManagerInstance:getLocalString(1170299)--强化次数已达上限
UI.TEXT_1324456 = languageManagerInstance:getLocalString(1170300)--强化等级已达上限
UI.TEXT_1324457 = languageManagerInstance:getLocalString(1170301)--%s数量不足
UI.TEXT_1324458 = languageManagerInstance:getLocalString(1110843)--"强化成功"
UI.TEXT_1324459 = languageManagerInstance:getLocalString(1170302)--"遗物已被锁定，请先解锁"
UI.TEXT_1324460 = languageManagerInstance:getLocalString(1116123) --"遗物强化"
UI.TEXT_1324461 = languageManagerInstance:getLocalString(1116124)--本次成功概率:
UI.TEXT_1324462 = languageManagerInstance:getLocalString(1116125)--%d%%


-- 商业活动
UI.TEXT_1324501 = languageManagerInstance:getLocalString(1113737)-- "福利活动"
UI.TEXT_1324502 = languageManagerInstance:getLocalString(1113726)-- "成长基金"
UI.TEXT_1324503 = languageManagerInstance:getLocalString(1113738)-- "10倍"
UI.TEXT_1324504 = languageManagerInstance:getLocalString(1113739)-- "返利"
UI.TEXT_1324505 = languageManagerInstance:getLocalString(1112023)-- "立即购买"
UI.TEXT_1324506 = languageManagerInstance:getLocalString(1113740)-- "达到%d级可以领取"
UI.TEXT_1324507 = languageManagerInstance:getLocalString(1113741)-- "未购买"
UI.TEXT_1324508 = languageManagerInstance:getLocalString(1113742)-- "未达成"
UI.TEXT_1324509 = languageManagerInstance:getLocalString(1113743)-- "已购买"
UI.TEXT_1324510 = languageManagerInstance:getLocalString(1113744)-- "%s元礼包"
UI.TEXT_1324511 = languageManagerInstance:getLocalString(1113745)-- "特惠礼包"
UI.TEXT_1324512 = languageManagerInstance:getLocalString(1113746)-- "立即充值"
UI.TEXT_1324513 = languageManagerInstance:getLocalString(1113747)-- "今日充值"
UI.TEXT_1324514 = languageManagerInstance:getLocalString(1113748)-- "任意金额"
UI.TEXT_1324515 = languageManagerInstance:getLocalString(1113749)-- "即可获得以下"
UI.TEXT_1324516 = languageManagerInstance:getLocalString(1113750)-- "超值大礼"
UI.TEXT_1324517 = languageManagerInstance:getLocalString(1113751)-- "今日充值任意金额即可获得以下超值大礼"
UI.TEXT_1324518 = languageManagerInstance:getLocalString(1113752)-- "超值礼包 每日限购"
UI.TEXT_1324519 = languageManagerInstance:getLocalString(1113753)-- "每种礼包每日限购1次"
UI.TEXT_1324520 = languageManagerInstance:getLocalString(1113754)-- "礼包每日刷新"
UI.TEXT_1324521 = languageManagerInstance:getLocalString(1113755)-- "超值优惠!"
UI.TEXT_1324522 = languageManagerInstance:getLocalString(1113756)-- "恭喜你！升到了"
UI.TEXT_1324523 = languageManagerInstance:getLocalString(1113757)-- "现在购买成长基金可立即领取"
UI.TEXT_1324524 = languageManagerInstance:getLocalString(1113758)-- "还等什么！快去购买吧！"
UI.TEXT_1324525 = languageManagerInstance:getLocalString(1113759)-- "大量水晶！"
UI.TEXT_1324526 = languageManagerInstance:getLocalString(1111518)-- "级"
UI.TEXT_1324527 = languageManagerInstance:getLocalString(1113760)-- "前往购买"
UI.TEXT_1324528 = languageManagerInstance:getLocalString(1113761)-- "残忍拒绝"
UI.TEXT_1324529 = languageManagerInstance:getLocalString(1113762)-- "活动期间，战力达标，即可领取丰厚奖励"
UI.TEXT_1324530 = languageManagerInstance:getLocalString(1113763)-- "活动时间：%s-%s"
UI.TEXT_1324531 = languageManagerInstance:getLocalString(1113764)-- "活动期间，宠物达标，即可领取丰厚奖励"
UI.TEXT_1324532 = languageManagerInstance:getLocalString(1113765)-- "活动期间，幻化达标，即可领取丰厚奖励"
UI.TEXT_1324533 = languageManagerInstance:getLocalString(1113766)-- "活动期间，成就达标，即可领取丰厚奖励"
UI.TEXT_1324534 = languageManagerInstance:getLocalString(1113767)-- "每个礼包每日限购1次"
UI.TEXT_1324535 = languageManagerInstance:getLocalString(1113768)-- "全服购买人数："
UI.TEXT_1324536 = languageManagerInstance:getLocalString(1113769)-- "人"
UI.TEXT_1324537 = languageManagerInstance:getLocalString(1113770)-- "当前等级：%d级"
UI.TEXT_1324538 = languageManagerInstance:getLocalString(1113844)-- "购买后立即获得"
UI.TEXT_1324539 = languageManagerInstance:getLocalString(1114607)-- "大量魂灯!"
UI.TEXT_1324540 = languageManagerInstance:getLocalString(1114609)-- "30倍!"
UI.TEXT_1324541 = languageManagerInstance:getLocalString(1114661)-- "装备%d星可以领取"
UI.TEXT_1324542 = languageManagerInstance:getLocalString(1114662)-- "当前等级：%d级"

-- 设置新旧场景转换
UI.TEXT_1325000 = languageManagerInstance:getLocalString(1113818)--"场景切换"
UI.TEXT_1325001 = languageManagerInstance:getLocalString(1113819)--"新版场景"
UI.TEXT_1325002 = languageManagerInstance:getLocalString(1113820)--"老版场景"
UI.TEXT_1325003 = languageManagerInstance:getLocalString(1113821)--"你确定要切换到%s版本的场景表现吗？"
UI.TEXT_1325004 = languageManagerInstance:getLocalString(1113822)--"未获得宠物"
UI.TEXT_1325005 = languageManagerInstance:getLocalString(1113829)--"将进入公会场景"
UI.TEXT_1325006 = languageManagerInstance:getLocalString(1113830)--"将进入家园"
UI.TEXT_1325007 = languageManagerInstance:getLocalString(1114677)--"将进入庄园"

-- 自动战斗
UI.TEXT_1325100 = languageManagerInstance:getLocalString(1113814)--"节能模式"
UI.TEXT_1325101 = languageManagerInstance:getLocalString(1113815)--"节能模式描述"
UI.TEXT_1325102 = languageManagerInstance:getLocalString(1113816)--"自动模式"
UI.TEXT_1325103 = languageManagerInstance:getLocalString(1113817)--"自动模式描述"
UI.TEXT_1325104 = languageManagerInstance:getLocalString(1113823)--"[%s]自动运行中"

-- 神迹祈福
UI.TEXT_1325204 = languageManagerInstance:getLocalString(1113865)--"免费祈祷"
UI.TEXT_1325205 = languageManagerInstance:getLocalString(1113866)--"没有更高等级了"
UI.TEXT_1325206 = languageManagerInstance:getLocalString(1113867)--"当前级"
UI.TEXT_1325207 = languageManagerInstance:getLocalString(1113868)--"您没有摇中奖励"
UI.TEXT_1325208 = languageManagerInstance:getLocalString(1113858)--"神迹祈福"

-- 一键合成宝石
UI.TEXT_1325301 = languageManagerInstance:getLocalString(1113870)--"参与合成的选项"
UI.TEXT_1325302 = languageManagerInstance:getLocalString(1113871)--"一键合成"
UI.TEXT_1325303 = languageManagerInstance:getLocalString(1113872)--"必须选择符文类型"
UI.TEXT_1325304 = languageManagerInstance:getLocalString(1113873)--"至少选择一个等级"
UI.TEXT_1325305 = languageManagerInstance:getLocalString(1113874)--"一键合成成功"

-- 大富翁
UI.TEXT_1325400 = languageManagerInstance:getLocalString(1113903)--"大富翁"
UI.TEXT_1325401 = languageManagerInstance:getLocalString(1113904)--"宝箱奖励预览"
UI.TEXT_1325402 = languageManagerInstance:getLocalString(1113905)--"奖励骰子"
UI.TEXT_1325403 = languageManagerInstance:getLocalString(1113906)--"今日次数用完"
UI.TEXT_1325404 = languageManagerInstance:getLocalString(1113907)--"领取宝箱奖励"
UI.TEXT_1325405 = languageManagerInstance:getLocalString(1113908)--"即将退出场景，在未刷新钱可多次进去该场景"
UI.TEXT_1325406 = languageManagerInstance:getLocalString(1113911)--"剩余次数"
UI.TEXT_1325407 = languageManagerInstance:getLocalString(1113912)--"免费次数"

-- 深红炼狱
UI.TEXT_1325500 = languageManagerInstance:getLocalString(1038489)--"深红炼狱"
UI.TEXT_1325501 = languageManagerInstance:getLocalString(1113933)--"深红炼狱%d层"
UI.TEXT_1325502 = languageManagerInstance:getLocalString(1150010)--"噩梦"
UI.TEXT_1325503 = languageManagerInstance:getLocalString(1113934)--"深红炼狱宝石"
-- UI.TEXT_1325504 = languageManagerInstance:getLocalString(1113935)--"[炼狱]"
UI.TEXT_1325505 = languageManagerInstance:getLocalString(1113936)--"（二选一）扭曲空间的描述说明"
UI.TEXT_1325506 = languageManagerInstance:getLocalString(1113937)--"（二选一）深红炼狱的描述说明"
UI.TEXT_1325507 = languageManagerInstance:getLocalString(1113938)--"探险队，深红炼狱的说明。 类似ID：1112441"
UI.TEXT_1325508 = languageManagerInstance:getLocalString(1113939)--"深红炼狱第一个场景的名字"
UI.TEXT_1325509 = languageManagerInstance:getLocalString(1113940)--"今日噩梦难度还有%d次，是否继续挑战？"
UI.TEXT_1325510 = languageManagerInstance:getLocalString(1150065)--"深红炼狱第二个场景的名字 埋骨森林"
UI.TEXT_1325511 = languageManagerInstance:getLocalString(1150067)--"深红炼狱第三个场景的名字 暗礁堡垒"
UI.TEXT_1325512 = languageManagerInstance:getLocalString(1114604)--"深红炼狱第四个场景的名字 光烁大殿"
UI.TEXT_1325513 = languageManagerInstance:getLocalString(1150070)--"深红炼狱第五个场景的名字 黑暗之源"


--活动分享
UI.TEXT_1325600 = languageManagerInstance:getLocalString(1122004)--"分享"
UI.TEXT_1325601 = languageManagerInstance:getLocalString(1113949)--"分享奖励回馈"
UI.TEXT_1325602 = languageManagerInstance:getLocalString(1113198)--"请到洞窟外进行此操作"

-- 佣兵系统
UI.TEXT_1325700 = languageManagerInstance:getLocalString(1113958)--"佣兵列表"
UI.TEXT_1325701 = languageManagerInstance:getLocalString(1113959)--"进入副本"
UI.TEXT_1325702 = languageManagerInstance:getLocalString(1113960)--"可雇佣次数:"
UI.TEXT_1325703 = languageManagerInstance:getLocalString(1113961)--"暂时没有佣兵可以雇佣"
UI.TEXT_1325704 = languageManagerInstance:getLocalString(1113962)--"请选择佣兵"
UI.TEXT_1325705 = languageManagerInstance:getLocalString(1113963)--"雇佣次数不足"
UI.TEXT_1325706 = languageManagerInstance:getLocalString(1113964)--"资源不足，不能进入战斗"
UI.TEXT_1325707 = languageManagerInstance:getLocalString(1113965)--"佣兵"
UI.TEXT_1325708 = languageManagerInstance:getLocalString(1113968)--"公会雇佣情况下，无法解锁新的进度"

--魂器补充
UI.TEXT_1325800 = languageManagerInstance:getLocalString(1170316)

-- 宠物装备
UI.TEXT_1325900 = languageManagerInstance:getLocalString(1114070)--"宠物装备"
UI.TEXT_1325901 = languageManagerInstance:getLocalString(1114071)--"饰品"
UI.TEXT_1325902 = languageManagerInstance:getLocalString(1114072)--"宠物星级不够"
UI.TEXT_1325903 = languageManagerInstance:getLocalString(1114073)--"宠物装备强化"
UI.TEXT_1325904 = languageManagerInstance:getLocalString(1114074)--"需要消耗材料"
UI.TEXT_1325905 = languageManagerInstance:getLocalString(1114075)--"强化后装备星级高于宠物星级，装备将不能被穿戴，是否进行强化？"
UI.TEXT_1325906 = languageManagerInstance:getLocalString(1114076)--"升级后获得"
UI.TEXT_1325907 = languageManagerInstance:getLocalString(1114077)--"升级后获得物品通过邮件发送"
UI.TEXT_1325908 = languageManagerInstance:getLocalString(1114078)--"升级后获得物品已经放入背包"
UI.TEXT_1325909 = languageManagerInstance:getLocalString(1114082)--"该装备已经最高等级，无法被强化"
UI.TEXT_1325910 = languageManagerInstance:getLocalString(1114084)--"宠物带有装备，需要先卸载装备"
UI.TEXT_1325911 = languageManagerInstance:getLocalString(1114085)--"装备于:"
UI.TEXT_1325912 = languageManagerInstance:getLocalString(1115664)--"强化后装备星级高于宠物星级,请将装备放入背包后再进行强化"

-- 订阅
UI.TEXT_1326000 = languageManagerInstance:getLocalString(1114088)--"每30天自动扣费，可随时取消"
UI.TEXT_1326001 = languageManagerInstance:getLocalString(1114089)--"恢复订阅状态，可随时取消"
UI.TEXT_1326002 = languageManagerInstance:getLocalString(1114090)--"下次扣费时间："
UI.TEXT_1326003 = languageManagerInstance:getLocalString(1170321)--"订单未到期，无法更换购买角色"
UI.TEXT_1326004 = languageManagerInstance:getLocalString(1170322)--"创建订单失败"
UI.TEXT_1326005 = languageManagerInstance:getLocalString(1114107)--"订阅月卡"


--骑乘按钮文字
UI.TEXT_1327001 = languageManagerInstance:getLocalString(1114081)--跟随
UI.TEXT_1327000 = languageManagerInstance:getLocalString(1114080)--骑乘
UI.TEXT_1327002 = languageManagerInstance:getLocalString(1114083)--战斗中无法更改骑乘状态


UI.TEXT_1114106 = languageManagerInstance:getLocalString(1114106)--本次商店刷新消耗水晶%s，需要继续刷新吗？

UI.TEXT_1170323 = languageManagerInstance:getLocalString(1170323)--含有非法字符，请重新输入

-- 幽灵深渊
UI.TEXT_1328000 = languageManagerInstance:getLocalString(1114226)--"幽灵深渊第%d层"
UI.TEXT_1328001 = languageManagerInstance:getLocalString(1114227)--"通关奖励"
UI.TEXT_1328002 = languageManagerInstance:getLocalString(1114228)--"关卡选择"
UI.TEXT_1328003 = languageManagerInstance:getLocalString(1114229)--"兑换商店"
UI.TEXT_1328004 = languageManagerInstance:getLocalString(1114230)--"推荐等级"
UI.TEXT_1328005 = languageManagerInstance:getLocalString(1114231)--"普通挑战"
UI.TEXT_1328006 = languageManagerInstance:getLocalString(1114232)--"双倍挑战"
UI.TEXT_1328007 = languageManagerInstance:getLocalString(1114233)--"进入深渊"
UI.TEXT_1328008 = languageManagerInstance:getLocalString(1114234)--"消耗挑战次数:"
UI.TEXT_1328009 = languageManagerInstance:getLocalString(1114235)--"奖励+80%"
UI.TEXT_1328010 = languageManagerInstance:getLocalString(1114236)--"挑战次数不足"
UI.TEXT_1328011 = languageManagerInstance:getLocalString(1114237)--"拥有材料"
UI.TEXT_1328012 = languageManagerInstance:getLocalString(1114238)--"选择想要兑换的材料"
UI.TEXT_1328013 = languageManagerInstance:getLocalString(1114239)--"材料价值"
UI.TEXT_1328014 = languageManagerInstance:getLocalString(1114240)--"幽灵深渊"
UI.TEXT_1328015 = languageManagerInstance:getLocalString(1114241)--"神像祈福"
UI.TEXT_1328016 = languageManagerInstance:getLocalString(1114242)--"图腾没有了反应"
UI.TEXT_1328017 = languageManagerInstance:getLocalString(1114243)--"开始祈福"
UI.TEXT_1328018 = languageManagerInstance:getLocalString(1114244)--"你将要兑换以下物品"
UI.TEXT_1328019 = languageManagerInstance:getLocalString(1114245)--"角落中存在着奇怪的雕像，去调查一下看看吧"
UI.TEXT_1328020 = languageManagerInstance:getLocalString(1114246)--"兑换成功"
UI.TEXT_1328021 = languageManagerInstance:getLocalString(1114556)--"选择要消耗的材料数量"


--按键设置
UI.TEXT_210000 = languageManagerInstance:getLocalString(1114116)
UI.TEXT_210001 = languageManagerInstance:getLocalString(1114117)
UI.TEXT_210002 = languageManagerInstance:getLocalString(1114118)
UI.TEXT_210003 = languageManagerInstance:getLocalString(1114119)
UI.TEXT_210004 = languageManagerInstance:getLocalString(1114120)
UI.TEXT_210005 = languageManagerInstance:getLocalString(1114121)
UI.TEXT_210006 = languageManagerInstance:getLocalString(1114122)
UI.TEXT_210007 = languageManagerInstance:getLocalString(1114123)
UI.TEXT_210008 = languageManagerInstance:getLocalString(1114124)
UI.TEXT_210009 = languageManagerInstance:getLocalString(1114125)
UI.TEXT_210010 = languageManagerInstance:getLocalString(1114126)
UI.TEXT_210011 = languageManagerInstance:getLocalString(1114127)
UI.TEXT_210012 = languageManagerInstance:getLocalString(1114128)
UI.TEXT_210013 = languageManagerInstance:getLocalString(1114129)
UI.TEXT_210014 = languageManagerInstance:getLocalString(1114130)
UI.TEXT_210015 = languageManagerInstance:getLocalString(1114131)
UI.TEXT_210016 = languageManagerInstance:getLocalString(1114132)
UI.TEXT_210017 = languageManagerInstance:getLocalString(1114133)
UI.TEXT_210018 = languageManagerInstance:getLocalString(1114134)
UI.TEXT_210019 = languageManagerInstance:getLocalString(1114135)
UI.TEXT_210020 = languageManagerInstance:getLocalString(1114136)
UI.TEXT_210021 = languageManagerInstance:getLocalString(1114137)
UI.TEXT_210022 = languageManagerInstance:getLocalString(1114138)
UI.TEXT_210023 = languageManagerInstance:getLocalString(1114139)
UI.TEXT_210024 = languageManagerInstance:getLocalString(1114140)

--错误提示
UI.TEXT_220000 = languageManagerInstance:getLocalString(1114222)--需要单人击杀精英Boss并成功回城

--兽栏
UI.TEXT_221000 = languageManagerInstance:getLocalString(1114570)--"解锁兽栏"
UI.TEXT_221001 = languageManagerInstance:getLocalString(1114571)--"升级兽栏"
UI.TEXT_221002 = languageManagerInstance:getLocalString(1114572)--"解锁兽栏需要花费%d%s"
UI.TEXT_221003 = languageManagerInstance:getLocalString(1114573)--"%s"
UI.TEXT_221004 = languageManagerInstance:getLocalString(1114574)--"升级兽栏需要消耗\n%s*%d\n%s*%d"
UI.TEXT_221005 = languageManagerInstance:getLocalString(1114575)--"未解锁"
UI.TEXT_221006 = languageManagerInstance:getLocalString(1114576)--"可以使用以下资源或使用水晶直接升级兽栏:"
UI.TEXT_221007 = languageManagerInstance:getLocalString(1114577)--"*%s (剩余%s)" 
UI.TEXT_221008 = languageManagerInstance:getLocalString(1114578)--"兽栏升级成功" 
UI.TEXT_221009 = languageManagerInstance:getLocalString(1114579)--"请升级兽栏"
UI.TEXT_221010 = languageManagerInstance:getLocalString(1114580)--"宠物出战中" 
UI.TEXT_221011 = languageManagerInstance:getLocalString(1114581)--"洞窟内无法进行此操作" 
UI.TEXT_221012 = languageManagerInstance:getLocalString(1114582)--"解锁需要等级达到%s" 
UI.TEXT_221013 = languageManagerInstance:getLocalString(1114583)--"请先解锁兽栏" 
UI.TEXT_221014 = languageManagerInstance:getLocalString(1114584)--"队长只能在属性页面更换" 
UI.TEXT_221015 = languageManagerInstance:getLocalString(1114594)--"直接解锁" 
UI.TEXT_221016 = languageManagerInstance:getLocalString(1114595)--兽栏  
UI.TEXT_221017 = languageManagerInstance:getLocalString(1114596)--确认使用%s水晶直接升级?
UI.TEXT_221018 = languageManagerInstance:getLocalString(1114598)--兽栏解锁成功
UI.TEXT_221019 = languageManagerInstance:getLocalString(1116535)--确认使用%s直接升级?
UI.TEXT_221020 = languageManagerInstance:getLocalString(1116536)--道具不足
UI.TEXT_221021 = languageManagerInstance:getLocalString(1116537)--道具升星

--宠物探险
UI.TEXT_221100 = languageManagerInstance:getLocalString(1114585)--开始冒险
UI.TEXT_221101 = languageManagerInstance:getLocalString(1114586)--冒险结束
UI.TEXT_221102 = languageManagerInstance:getLocalString(1114587)--冒险中
UI.TEXT_221103 = languageManagerInstance:getLocalString(1114588)--冒险剩余时间
UI.TEXT_221104 = languageManagerInstance:getLocalString(1114589)--完成冒险
UI.TEXT_221105 = languageManagerInstance:getLocalString(1114590)--选中宠物在宝藏挖掘中，不能进行冒险
UI.TEXT_221106 = languageManagerInstance:getLocalString(1114591)--宠物冒险背包
UI.TEXT_221107 = languageManagerInstance:getLocalString(1114592)--宠物冒险
UI.TEXT_221108 = languageManagerInstance:getLocalString(1114593)--选中宠物正在在冒险中，不能进行宝藏挖掘
UI.TEXT_221109 = languageManagerInstance:getLocalString(1111346)--可能掉落道具
UI.TEXT_221110 = languageManagerInstance:getLocalString(1114545)--宠物冒险在25级并获得宠物后解锁
UI.TEXT_221111 = languageManagerInstance:getLocalString(1114599)--宠物冒险中，不能进行此操作
UI.TEXT_221112 = languageManagerInstance:getLocalString(1114605)--宠物正在进行宝藏挖掘，不能进行此操作

--周年签到
UI.TEXT_221200 = languageManagerInstance:getLocalString(1114597)--周年签到


UI.TEXT_221201 = languageManagerInstance:getLocalString(1114639)--是否使用虎年回城特效或者UI
UI.TEXT_221202 = languageManagerInstance:getLocalString(1114743)--是否使用经验道具
UI.TEXT_221203 = languageManagerInstance:getLocalString(1114744)--到达最大等级，无法使用该道具



--审核次数文字相关
UI.TEXT_221300 = languageManagerInstance:getLocalString(1114601) --今日剩余：
UI.TEXT_221301 = languageManagerInstance:getLocalString(1114600) --理性娱乐，适度消费
UI.TEXT_221302 = languageManagerInstance:getLocalString(1111200) --抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。

--QQ大厅
UI.TEXT_221400 = languageManagerInstance:getLocalString(1114610)--"玩咖特权"--
UI.TEXT_221401 = languageManagerInstance:getLocalString(1114611)--"大玩咖"--
UI.TEXT_221402 = languageManagerInstance:getLocalString(1114612)--"超级大玩咖"--
UI.TEXT_221403 = languageManagerInstance:getLocalString(1114613)--"我的等级: %s"--
UI.TEXT_221404 = languageManagerInstance:getLocalString(1114614)--"我的咖值: %s"--
UI.TEXT_221405 = languageManagerInstance:getLocalString(1114615)--"绝版专属"--
UI.TEXT_221406 = languageManagerInstance:getLocalString(1114616)--"专属礼包"--
UI.TEXT_221407 = languageManagerInstance:getLocalString(1114617)--"专属客服"--
UI.TEXT_221408 = languageManagerInstance:getLocalString(1114618)--"充赠共享"--
UI.TEXT_221409 = languageManagerInstance:getLocalString(1114619)--"游券赠送"--
UI.TEXT_221410 = languageManagerInstance:getLocalString(1114620)--"充值加赠"--
UI.TEXT_221411 = languageManagerInstance:getLocalString(1114621)--"充值任意金额额外赠送%s"--
UI.TEXT_221412 = languageManagerInstance:getLocalString(1114622)--"绑定好友共享充值加赠%s"--
UI.TEXT_221413 = languageManagerInstance:getLocalString(1114623)--"100元以下游券任意赠送%s次"--
UI.TEXT_221414 = languageManagerInstance:getLocalString(1114624)--"立即解锁特权"--
UI.TEXT_221415 = languageManagerInstance:getLocalString(1114625)--"玩咖特权享受中..."--
UI.TEXT_221416 = languageManagerInstance:getLocalString(1114626)--"QQ游戏大厅专属特权"--
UI.TEXT_221417 = languageManagerInstance:getLocalString(1114627)--"新手礼包"--
UI.TEXT_221418 = languageManagerInstance:getLocalString(1114628)--"活跃礼包"--
UI.TEXT_221419 = languageManagerInstance:getLocalString(1114629)--"成长礼包"--
UI.TEXT_221420 = languageManagerInstance:getLocalString(1114630)--"角色达到%s级可领"--
UI.TEXT_221421 = languageManagerInstance:getLocalString(1114631)--"QQ游戏大厅用户尊享以下专属特权"--
UI.TEXT_221422 = languageManagerInstance:getLocalString(1114632)--"该特权将在正式发布后开放哦(游戏库-正式上线),敬请关注游戏状态"--咖特权
UI.TEXT_221423 = languageManagerInstance:getLocalString(1114633)--"充值特权共享"
UI.TEXT_221424 = languageManagerInstance:getLocalString(1114634)--"赠送游券"
UI.TEXT_221425 = languageManagerInstance:getLocalString(1114636)--"返利额外获得%s"
UI.TEXT_221426 = languageManagerInstance:getLocalString(1114637)--"前往"
UI.TEXT_221427 = languageManagerInstance:getLocalString(1114638)--"特权获取说明"

--Boss直达
UI.TEXT_221500 = languageManagerInstance:getLocalString(1114650)--"挑战BOSS"
UI.TEXT_221501 = languageManagerInstance:getLocalString(1114651)--"是否立即前往挑战BOSS"
UI.TEXT_221502 = languageManagerInstance:getLocalString(1170331)--"组队模式无法使用跳层"

--钓鱼
UI.TEXT_221600 = languageManagerInstance:getLocalString(1114670)--"工具箱"
UI.TEXT_221601 = languageManagerInstance:getLocalString(1114671)--"关闭"
UI.TEXT_221602 = languageManagerInstance:getLocalString(1114672)--"鱼竿"
UI.TEXT_221603 = languageManagerInstance:getLocalString(1114679)--"贪婪渔具商店"
UI.TEXT_221604 = languageManagerInstance:getLocalString(1114680)--"确定购买渔具么"
UI.TEXT_221605 = languageManagerInstance:getLocalString(1114681)--"无法装备鱼竿"
UI.TEXT_221606 = languageManagerInstance:getLocalString(1114682)--"工具箱只能装备渔具"
UI.TEXT_221607 = languageManagerInstance:getLocalString(1114685)--"等级不足"
UI.TEXT_221608 = languageManagerInstance:getLocalString(1114688)--"你已经拥有了这支鱼竿，确定要购买它吗？"
UI.TEXT_221609 = LanguageManager:getInstance():getLocalString(1115062) --"渔具"
UI.TEXT_221610 = LanguageManager:getInstance():getLocalString(1115063) --"星卡"
UI.TEXT_221611 = LanguageManager:getInstance():getLocalString(1115064) --"补给"
UI.TEXT_221612 = languageManagerInstance:getLocalString(1115065)--"确定购买星辰卡么"
UI.TEXT_221613 = languageManagerInstance:getLocalString(1115066)--"确定购买补给么"


UI.TEXT_221700 = languageManagerInstance:getLocalString(1114673) -- 在庄园中不能骑乘宠物
UI.TEXT_221701 = languageManagerInstance:getLocalString(1114674) -- 钓鱼需要先装备钓竿！
UI.TEXT_221702 = languageManagerInstance:getLocalString(1114675) -- 今天不能再钓鱼了！
UI.TEXT_221703 = languageManagerInstance:getLocalString(1114676) -- 剩余次数：
UI.TEXT_221704 = languageManagerInstance:getLocalString(1114678) -- 不能进入庄园的提示文字

--行商
UI.TEXT_221800 = languageManagerInstance:getLocalString(1114689) -- 背包里面没有旅行商人所需的物品
UI.TEXT_221801 = languageManagerInstance:getLocalString(1114690) -- 我这里有东西卖哦!(行商头顶说的话)
UI.TEXT_221802 = languageManagerInstance:getLocalString(1114691) -- 行商收购
UI.TEXT_221803 = languageManagerInstance:getLocalString(1114692) -- 拜访庄园
UI.TEXT_221804 = languageManagerInstance:getLocalString(1114693) -- 提示当前场景不能进入庄园
UI.TEXT_221805 = languageManagerInstance:getLocalString(1114694) -- 删除好友
UI.TEXT_221806 = languageManagerInstance:getLocalString(1114695) -- 今日收购:
UI.TEXT_221807 = languageManagerInstance:getLocalString(1114696) -- 售价:
UI.TEXT_221808 = languageManagerInstance:getLocalString(1115559) --"@@@@ 明日特价收购"
UI.TEXT_221809 = languageManagerInstance:getLocalString(1115560) --"@@@@ 明日零点生效"
UI.TEXT_221810 = languageManagerInstance:getLocalString(1115561) --"@@@@ 更换售卖材料"
UI.TEXT_221811 = languageManagerInstance:getLocalString(1115562) --"@@@@ 更换成功:%s 明日生效"
UI.TEXT_221812 = languageManagerInstance:getLocalString(1115556) -- 银
UI.TEXT_221813 = languageManagerInstance:getLocalString(1115557) -- 金
UI.TEXT_221814 = languageManagerInstance:getLocalString(1115558) -- 暗金

-- 船坞
UI.TEXT_221900 = languageManagerInstance:getLocalString(1114754) -- 出海
UI.TEXT_221901 = languageManagerInstance:getLocalString(1114755) -- 船坞升级
UI.TEXT_221902 = languageManagerInstance:getLocalString(1114756) -- 船只管理
UI.TEXT_221903 = languageManagerInstance:getLocalString(1114757) -- 推荐船员等级:%s
UI.TEXT_221904 = languageManagerInstance:getLocalString(1114758) -- 航线长度:%s
UI.TEXT_221905 = languageManagerInstance:getLocalString(1114759) -- 航行速度:%s
UI.TEXT_221906 = languageManagerInstance:getLocalString(1114760) -- 需要补给物资类型:%s
UI.TEXT_221907 = languageManagerInstance:getLocalString(1114761) -- 补给剩余:%s
UI.TEXT_221908 = languageManagerInstance:getLocalString(1114762) -- 补给消耗速度:%s
UI.TEXT_221909 = languageManagerInstance:getLocalString(1114763) -- 推荐船员等级:%s
UI.TEXT_221910 = languageManagerInstance:getLocalString(1114764) -- 船员配备
UI.TEXT_221911 = languageManagerInstance:getLocalString(1114765) -- 出海
UI.TEXT_221912 = languageManagerInstance:getLocalString(1114766) -- 升级所需材料
UI.TEXT_221913 = languageManagerInstance:getLocalString(1114767) -- 升到下一级所需
UI.TEXT_221914 = languageManagerInstance:getLocalString(1114768) -- 升级
UI.TEXT_221915 = languageManagerInstance:getLocalString(1115042) -- 航线
UI.TEXT_221916 = languageManagerInstance:getLocalString(1115043) -- 船员配置
UI.TEXT_221917 = languageManagerInstance:getLocalString(1115044) -- 添加航行补给
UI.TEXT_221918 = languageManagerInstance:getLocalString(1115045) -- 补给品不足需求的50%
UI.TEXT_221919 = languageManagerInstance:getLocalString(1115046) -- 船员不足
UI.TEXT_221920 = languageManagerInstance:getLocalString(1115047) -- 航海背包
UI.TEXT_221921 = languageManagerInstance:getLocalString(1115048) -- 船只管理
UI.TEXT_221922 = languageManagerInstance:getLocalString(1115049) -- 更换/购买船只
UI.TEXT_221923 = languageManagerInstance:getLocalString(1115050) -- 当前航程可掉落
UI.TEXT_221924 = languageManagerInstance:getLocalString(1115051) -- 每分钟补给消耗
UI.TEXT_221925 = languageManagerInstance:getLocalString(1115052) -- 航行剩余时间
UI.TEXT_221926 = languageManagerInstance:getLocalString(1115053) -- 货舱最大容量
UI.TEXT_221927 = languageManagerInstance:getLocalString(1115054) -- 船坞
UI.TEXT_221928 = languageManagerInstance:getLocalString(1115055) -- 船只展示
UI.TEXT_221929 = languageManagerInstance:getLocalString(1115067) -- 航海背包还未领取
UI.TEXT_221930 = languageManagerInstance:getLocalString(1115068) -- 航行还未结束
UI.TEXT_221931 = languageManagerInstance:getLocalString(1115069) -- 这只宠物已经很忙了,无法参与航行
UI.TEXT_221932 = languageManagerInstance:getLocalString(1115070) -- 宠物航行中
UI.TEXT_221933 = languageManagerInstance:getLocalString(1115074) -- 宠物忙碌中
UI.TEXT_221934 = languageManagerInstance:getLocalString(1115076) -- 船员已满
UI.TEXT_221935 = languageManagerInstance:getLocalString(1115083) -- +%s%%
UI.TEXT_221936 = languageManagerInstance:getLocalString(1115148) -- 航海日志
UI.TEXT_221937 = languageManagerInstance:getLocalString(1115260) -- 结束航海
UI.TEXT_221938 = languageManagerInstance:getLocalString(1115279) -- 是否中断航行？

-- QOOAPP
UI.TEXT_222000 = languageManagerInstance:getLocalString(1114746) -- QOOAPP
UI.TEXT_222001 = languageManagerInstance:getLocalString(1114790) -- 登录

-- 虚空秘境
UI.TEXT_222100 = languageManagerInstance:getLocalString(1114772) -- 虚空秘境
UI.TEXT_222101 = languageManagerInstance:getLocalString(1114789)--"（二选一）虚空秘境的描述说明"
UI.TEXT_222102 = languageManagerInstance:getLocalString(1114802)--"虚空秘境宝石"
UI.TEXT_222103 = languageManagerInstance:getLocalString(1150072)--"虚空秘境第一个场景的名字"
UI.TEXT_222104 = languageManagerInstance:getLocalString(1150074)--"虚空秘境第二个场景的名字 许愿湖"
-- UI.TEXT_222105 = languageManagerInstance:getLocalString(1114802)--"虚空秘境第三个场景的名字"
-- UI.TEXT_222106 = languageManagerInstance:getLocalString(1114802)--"虚空秘境第四个场景的名字"
-- UI.TEXT_222107 = languageManagerInstance:getLocalString(1114802)--"虚空秘境第五个场景的名字"
UI.TEXT_222110 = languageManagerInstance:getLocalString(1114811)--"秘境效果"
UI.TEXT_222111 = languageManagerInstance:getLocalString(1115086)--"虚空秘境%d层"



--易物台
UI.TEXT_222130 = languageManagerInstance:getLocalString(1114803)--"置换"
UI.TEXT_222131 = languageManagerInstance:getLocalString(1114804)--"置换成功"
UI.TEXT_222132 = languageManagerInstance:getLocalString(1114745)--"易物台"

--套装属性改造
UI.TEXT_222200 = languageManagerInstance:getLocalString(1114792) -- 重置
UI.TEXT_222201 = languageManagerInstance:getLocalString(1114793) -- 套装未解锁的提示内容
UI.TEXT_222202 = languageManagerInstance:getLocalString(1114794) -- 套装属性改造
UI.TEXT_222203 = languageManagerInstance:getLocalString(1114795) -- 套装属性
UI.TEXT_222204 = languageManagerInstance:getLocalString(1114797) -- 选择改造属性
UI.TEXT_222205 = languageManagerInstance:getLocalString(1114798) -- 你确定要关闭选择改造界面,关闭了默认放弃改造!
UI.TEXT_222206 = languageManagerInstance:getLocalString(1114799) -- 至少得选择一个套装属性
UI.TEXT_222207 = languageManagerInstance:getLocalString(1114800) -- 确定要重置套装属性?
UI.TEXT_222208 = languageManagerInstance:getLocalString(1114801) -- 改造道具不足
UI.TEXT_222209 = languageManagerInstance:getLocalString(1170102) --水晶不足

--删除角色界面
UI.TEXT_222300 = languageManagerInstance:getLocalString(1114812) --提示
UI.TEXT_222301 = languageManagerInstance:getLocalString(1114813) --立即删除
UI.TEXT_222302 = languageManagerInstance:getLocalString(1114814) --解除删除
UI.TEXT_222303 = languageManagerInstance:getLocalString(1114815) --无可删除账号
UI.TEXT_222304 = languageManagerInstance:getLocalString(1114816) --删除角色操作界面的提示: 该操作将立即删除该账号下的信息等等
UI.TEXT_222305 = languageManagerInstance:getLocalString(1114817) --账号删除中的操作界面的提示: 当前账号已被禁用,将在%s天之后永久删除角色等等
UI.TEXT_222306 = languageManagerInstance:getLocalString(1114818) --删除角色成功
UI.TEXT_222307 = languageManagerInstance:getLocalString(1114819) --角色删除中

-- 月度签到
UI.TEXT_222400 = languageManagerInstance:getLocalString(1114822) --签到天数不足
UI.TEXT_222401 = languageManagerInstance:getLocalString(1114823) --%s月签到
UI.TEXT_222402 = languageManagerInstance:getLocalString(1114824) --今日已签到
UI.TEXT_222403 = languageManagerInstance:getLocalString(1114825)--"补签需要花费%d水晶"
UI.TEXT_222404 = languageManagerInstance:getLocalString(1114870)--"补签剩余次数不足"
UI.TEXT_222405 = languageManagerInstance:getLocalString(1114871)--"剩余水晶补签次数:%s"
UI.TEXT_222406 = languageManagerInstance:getLocalString(1114872)--"使用补签券补签"
UI.TEXT_222407 = languageManagerInstance:getLocalString(1115330)--"星痕背包已满，无法领取"

-- IP归属地
UI.TEXT_222500 = languageManagerInstance:getLocalString(1114986)--"IP属地:%s"

-- 航海星图
UI.TEXT_222600 = languageManagerInstance:getLocalString(1115002) --星图
UI.TEXT_222601 = languageManagerInstance:getLocalString(1115003) --星辰卡片
UI.TEXT_222602 = languageManagerInstance:getLocalString(1115004) --星辰图鉴
UI.TEXT_222603 = languageManagerInstance:getLocalString(1115005) --镶嵌卡槽
UI.TEXT_222604 = languageManagerInstance:getLocalString(1115006) --庄园
UI.TEXT_222605 = languageManagerInstance:getLocalString(1115007) --星图
UI.TEXT_222606 = languageManagerInstance:getLocalString(1115008) --行商
UI.TEXT_222607 = languageManagerInstance:getLocalString(1115009) --船坞
UI.TEXT_222608 = languageManagerInstance:getLocalString(1115010) --餐桌
UI.TEXT_222609 = languageManagerInstance:getLocalString(1115011) --装备架
UI.TEXT_222610 = languageManagerInstance:getLocalString(1115012) --解锁
UI.TEXT_222611 = languageManagerInstance:getLocalString(1115013) --星辰卡片属性加成
UI.TEXT_222614 = languageManagerInstance:getLocalString(1115014) --解锁条件:
UI.TEXT_222615 = languageManagerInstance:getLocalString(1115015) --下级解锁:
UI.TEXT_222616 = languageManagerInstance:getLocalString(1115016) --航海币培养
UI.TEXT_222617 = languageManagerInstance:getLocalString(1115017) --航海钻石培养
UI.TEXT_222618 = languageManagerInstance:getLocalString(1115018) --航海币不足
UI.TEXT_222619 = languageManagerInstance:getLocalString(1115019) --航海钻石不足
UI.TEXT_222620 = languageManagerInstance:getLocalString(1115020) --星图等级已经满了!不能升级了!
UI.TEXT_222621 = languageManagerInstance:getLocalString(1115021) --不满足升级需求!
UI.TEXT_222622 = languageManagerInstance:getLocalString(1115022) --是否使用星辰卡道具!
UI.TEXT_222623 = languageManagerInstance:getLocalString(1115023) --卡组名称:
UI.TEXT_222624 = languageManagerInstance:getLocalString(1115024) --激活效果:
UI.TEXT_222625 = languageManagerInstance:getLocalString(1115025) --全部
UI.TEXT_222626 = languageManagerInstance:getLocalString(1115026) --镶嵌
UI.TEXT_222627 = languageManagerInstance:getLocalString(1115027) --未镶嵌
UI.TEXT_222628 = languageManagerInstance:getLocalString(1115028) --放置星辰卡
UI.TEXT_222629 = languageManagerInstance:getLocalString(1115029) --请选择需要镶嵌的星辰卡
UI.TEXT_222630 = languageManagerInstance:getLocalString(1115030) --点击+放入卡片
UI.TEXT_222631 = languageManagerInstance:getLocalString(1115031) --立即完成
UI.TEXT_222632 = languageManagerInstance:getLocalString(1115032) --升级卡片的槽位已满!
UI.TEXT_222633 = languageManagerInstance:getLocalString(1115033) --是否花费%d航海金币升级卡片?
UI.TEXT_222634 = languageManagerInstance:getLocalString(1115034) --航海金币不足
UI.TEXT_222635 = languageManagerInstance:getLocalString(1115035) --是否花费%d钻石立即完成?
UI.TEXT_222636 = languageManagerInstance:getLocalString(1115036) --卡片等级达到上限
UI.TEXT_222637 = languageManagerInstance:getLocalString(1115037) --书桌等级不足,不能提升卡片等级
UI.TEXT_222638 = languageManagerInstance:getLocalString(1115038) --获得星辰卡
UI.TEXT_222639 = languageManagerInstance:getLocalString(1115039) --恭喜获得航海币x%d
UI.TEXT_222640 = languageManagerInstance:getLocalString(1114990) --书桌

-- UI特效
UI.TEXT_222680 = languageManagerInstance:getLocalString(1111458) --默认
UI.TEXT_222681 = languageManagerInstance:getLocalString(1092493) --虎年回城特效
UI.TEXT_222682 = languageManagerInstance:getLocalString(1092494) --虎年摇杆装饰
UI.TEXT_222683 = languageManagerInstance:getLocalString(1115040) --海盗回城特效
UI.TEXT_222684 = languageManagerInstance:getLocalString(1115041) --海盗回城特效

-- 庄园外形
UI.TEXT_222710 = LanguageManager:getInstance():getLocalString(1115059) -- 外形管理
UI.TEXT_222711 = LanguageManager:getInstance():getLocalString(1115060) -- 管家
UI.TEXT_222712 = LanguageManager:getInstance():getLocalString(1115061) -- 使用中
UI.TEXT_222713 = LanguageManager:getInstance():getLocalString(1115072)--皮肤效果:%s
UI.TEXT_222714 = LanguageManager:getInstance():getLocalString(1115073)-- 解锁条件:%s
UI.TEXT_222715 = LanguageManager:getInstance():getLocalString(1115239)-- 庄园
UI.TEXT_222716 = LanguageManager:getInstance():getLocalString(1115240)-- 庄园外形
UI.TEXT_222717 = LanguageManager:getInstance():getLocalString(1115241)-- 是否花费xx钻石购买皮肤
UI.TEXT_222718 = LanguageManager:getInstance():getLocalString(1115242)-- 船只
UI.TEXT_222719 = LanguageManager:getInstance():getLocalString(1115243)-- 航行中无法更换船只
UI.TEXT_222720 = LanguageManager:getInstance():getLocalString(1115261)-- 庄园升级
UI.TEXT_222721 = LanguageManager:getInstance():getLocalString(1115262)-- %s*%d
UI.TEXT_222722 = LanguageManager:getInstance():getLocalString(1115263)-- 修建进度+%d
UI.TEXT_222723 = LanguageManager:getInstance():getLocalString(1115264)-- 庄园升级进度
UI.TEXT_222724 = LanguageManager:getInstance():getLocalString(1115265)-- 今日庄园修建任务(%d/%d)
UI.TEXT_222725 = LanguageManager:getInstance():getLocalString(1115266)-- %d/%d
UI.TEXT_222726 = LanguageManager:getInstance():getLocalString(1115267)-- 未满足升级前置条件
UI.TEXT_222727 = LanguageManager:getInstance():getLocalString(1115268)-- 已达到最大等级
UI.TEXT_222728 = LanguageManager:getInstance():getLocalString(1115269)-- 庄园已达到最大等级或建筑进度已满
UI.TEXT_222729 = LanguageManager:getInstance():getLocalString(1115270)-- 每个道具增加%d进度
UI.TEXT_222730 = LanguageManager:getInstance():getLocalString(1115271)-- 升级所需道具不足

-- 限时反斗乐
UI.TEXT_222750 = languageManagerInstance:getLocalString(1115056)--新反斗乐钥匙数量不足
UI.TEXT_222751 = languageManagerInstance:getLocalString(1111561)--限购次数
UI.TEXT_222752 = languageManagerInstance:getLocalString(1117208) --夏日反斗乐钥匙数量不足
UI.TEXT_222753 = languageManagerInstance:getLocalString(1117455) --2025年1月的反斗乐钥匙数量不足提示 (新春反斗钥匙不足)


-- 庄园幻化架
UI.TEXT_222800 = languageManagerInstance:getLocalString(1115194) --幻化架升级
UI.TEXT_222801 = languageManagerInstance:getLocalString(1115195) --幻化架
UI.TEXT_222802 = languageManagerInstance:getLocalString(1115196) --幻化架图鉴
UI.TEXT_222803 = languageManagerInstance:getLocalString(1115197) --幻化效果:
UI.TEXT_222804 = languageManagerInstance:getLocalString(1115198) --已激活
UI.TEXT_222805 = languageManagerInstance:getLocalString(1115199) --未激活
UI.TEXT_222806 = languageManagerInstance:getLocalString(1115200) --展示外形
UI.TEXT_222807 = languageManagerInstance:getLocalString(1115201) --将外形展示至幻化架
UI.TEXT_222808 = languageManagerInstance:getLocalString(1115202) --展示成功
UI.TEXT_222809 = languageManagerInstance:getLocalString(1115203) --至少需要激活一件装备才能展示
UI.TEXT_222810 = languageManagerInstance:getLocalString(1115204) --可激活


-- 庄园餐桌
UI.TEXT_222900 = languageManagerInstance:getLocalString(1115244) --餐桌
UI.TEXT_222901 = languageManagerInstance:getLocalString(1115245) --餐桌升级
UI.TEXT_222902 = languageManagerInstance:getLocalString(1115246) --外形管理
UI.TEXT_222903 = languageManagerInstance:getLocalString(1115247) --%s(%s/%s)
UI.TEXT_222904 = languageManagerInstance:getLocalString(1115248) --食用效果
UI.TEXT_222905 = languageManagerInstance:getLocalString(1115249) --食用
UI.TEXT_222906 = languageManagerInstance:getLocalString(1115250) --生效中
UI.TEXT_222907 = languageManagerInstance:getLocalString(1115251) --升级后解锁
UI.TEXT_222908 = languageManagerInstance:getLocalString(1115252) --食材不足
UI.TEXT_222909 = languageManagerInstance:getLocalString(1115253) --餐桌%d级解锁
UI.TEXT_222910 = languageManagerInstance:getLocalString(1115278) --已有同类型buff存在

-- 限时称号
UI.TEXT_223000 = languageManagerInstance:getLocalString(1115325) --剩余:%d天%d小时

-- 三阶技能
UI.TEXT_223100 = languageManagerInstance:getLocalString(1115406) --三阶技能
UI.TEXT_223101 = languageManagerInstance:getLocalString(1115407) --"三阶技能为专属武器限定"
UI.TEXT_223102 = languageManagerInstance:getLocalString(1115408)-- 是否花费xx水晶购买技能页

-- 周年庆预约
UI.TEXT_223200 = languageManagerInstance:getLocalString(1115337) --预约任务
UI.TEXT_223201 = languageManagerInstance:getLocalString(1115338) --"个人奖励"
UI.TEXT_223202 = languageManagerInstance:getLocalString(1115339) --"全服奖励"
UI.TEXT_223203 = languageManagerInstance:getLocalString(1115393) --"四周年预约活动"
UI.TEXT_223204 = languageManagerInstance:getLocalString(1115402) --"活动时间：%s"
UI.TEXT_223205 = languageManagerInstance:getLocalString(1115403) --"周年庆预约活动"
UI.TEXT_223206 = languageManagerInstance:getLocalString(1115404) --"进行中 %s"
UI.TEXT_223207 = languageManagerInstance:getLocalString(1115405) --"活动已结束"

-- 变身卡
UI.TEXT_223300 = languageManagerInstance:getLocalString(1115396) --"是否使用变身卡?"
UI.TEXT_223301 = languageManagerInstance:getLocalString(1115397) --"是否取消变身?"

-- 活动副本
UI.TEXT_223400 = languageManagerInstance:getLocalString(1115415) --"征讨异兽"
UI.TEXT_223401 = languageManagerInstance:getLocalString(1115416) --"每日通关奖励"
UI.TEXT_223402 = languageManagerInstance:getLocalString(1115417) --"得分:%s"
UI.TEXT_223403 = languageManagerInstance:getLocalString(1115418) --"恭喜通关"
UI.TEXT_223404 = languageManagerInstance:getLocalString(1115419) --"难度得分"
UI.TEXT_223405 = languageManagerInstance:getLocalString(1115420) --"时间得分"
UI.TEXT_223406 = languageManagerInstance:getLocalString(1115421) --"离开"
UI.TEXT_223407 = languageManagerInstance:getLocalString(1115422) --"清空词条"
UI.TEXT_223408 = languageManagerInstance:getLocalString(1115423)-- 活动时间: %s-%s
UI.TEXT_223409 = languageManagerInstance:getLocalString(1115424)-- 副本已耗时
UI.TEXT_223410 = languageManagerInstance:getLocalString(1115429)--"活动未开启"
UI.TEXT_223411 = languageManagerInstance:getLocalString(1115430)--"通过选择词条,挑战更高难度吧!"
UI.TEXT_223412 = languageManagerInstance:getLocalString(1115454)--"属性宝石"
UI.TEXT_223413 = languageManagerInstance:getLocalString(1115460)--"点击进入"
UI.TEXT_223414 = languageManagerInstance:getLocalString(1115461)--"试炼之地只会根据第一次进入副本选择的武器类型设定排行榜，是否以当前装备进入副本？"
UI.TEXT_223415 = languageManagerInstance:getLocalString(1115462)--"是否以当前装备进入副本？"
UI.TEXT_223416 = languageManagerInstance:getLocalString(1115463)--"必须装备%s才能进入"
UI.TEXT_223417 = languageManagerInstance:getLocalString(1115464)--"必须装备武器才能进入"
UI.TEXT_223418 = languageManagerInstance:getLocalString(1115465)--"当前副本只能装备%s"
UI.TEXT_223419 = languageManagerInstance:getLocalString(1115466)--"必须装备武器"


-- 活动副本排行榜
UI.TEXT_223500 = languageManagerInstance:getLocalString(1115375) -- "排行榜"
UI.TEXT_223501 = languageManagerInstance:getLocalString(1115376) -- "排名"
UI.TEXT_223502 = languageManagerInstance:getLocalString(1115377) -- "排名奖励"
UI.TEXT_223503 = languageManagerInstance:getLocalString(1115378) -- "参与奖励"
UI.TEXT_223504 = languageManagerInstance:getLocalString(1115379) -- "(%s-%s级)"
UI.TEXT_223505 = languageManagerInstance:getLocalString(1115380) -- "累积参与人数:"
UI.TEXT_223506 = languageManagerInstance:getLocalString(1115381) -- "该奖励已经领取过了"
UI.TEXT_223507 = languageManagerInstance:getLocalString(1115382) -- "%s-%s名"
UI.TEXT_223508 = languageManagerInstance:getLocalString(1115383) -- "难度词条"
UI.TEXT_223509 = languageManagerInstance:getLocalString(1115384) -- "难度得分"
UI.TEXT_223510 = languageManagerInstance:getLocalString(1115385) -- "通关时长"

-- 周年庆抽奖
UI.TEXT_223600 = languageManagerInstance:getLocalString(1115433) -- "锦鲤抽奖"
UI.TEXT_223601 = languageManagerInstance:getLocalString(1115434) -- "高级抽奖"
UI.TEXT_223602 = languageManagerInstance:getLocalString(1115435) -- "活动奖励"
UI.TEXT_223603 = languageManagerInstance:getLocalString(1115436) -- "立即参与"
UI.TEXT_223604 = languageManagerInstance:getLocalString(1115437) -- "立即领奖"
UI.TEXT_223605 = languageManagerInstance:getLocalString(1115438) -- "已报名"
UI.TEXT_223606 = languageManagerInstance:getLocalString(1115439) -- "查看详情"
UI.TEXT_223607 = languageManagerInstance:getLocalString(1115440) -- "锦鲤附体"
UI.TEXT_223608 = languageManagerInstance:getLocalString(1115441) -- "未中奖"
UI.TEXT_223609 = languageManagerInstance:getLocalString(1115442) -- "前往领取"
UI.TEXT_223610 = languageManagerInstance:getLocalString(1115443) -- "立即前往"
UI.TEXT_223611 = languageManagerInstance:getLocalString(1115444) -- "已报名成功，无需再次报名"
UI.TEXT_223612 = languageManagerInstance:getLocalString(1115445) -- "报名成功"
UI.TEXT_223613 = languageManagerInstance:getLocalString(1115446) -- "查看结果"
UI.TEXT_223614 = languageManagerInstance:getLocalString(1115447) -- "活动未开启"
UI.TEXT_223615 = languageManagerInstance:getLocalString(1115448) -- "活动已结束，奖励已发到邮件"
UI.TEXT_223616 = languageManagerInstance:getLocalString(1115449) -- "报名已截止"
UI.TEXT_223617 = languageManagerInstance:getLocalString(1115450) -- "报名时间:%s-%s"
UI.TEXT_223618 = languageManagerInstance:getLocalString(1115451) -- "礼包描述:购入礼包即可参与超绝坐骑抽奖活动"
UI.TEXT_223619 = languageManagerInstance:getLocalString(1115452) -- "抽奖礼包"
UI.TEXT_223620 = languageManagerInstance:getLocalString(1115453) -- "周年庆抽奖"
UI.TEXT_223621 = languageManagerInstance:getLocalString(1115456) -- "报名开启时间:%s"
UI.TEXT_223622 = languageManagerInstance:getLocalString(1115457) -- "中奖名单"
UI.TEXT_223623 = languageManagerInstance:getLocalString(1115458) -- "暂无数据，请稍后再试"

--前期优化
UI.TEXT_223700 = languageManagerInstance:getLocalString(1115431)--"更换了不同类型的武器,技能发生了变化!"
UI.TEXT_223701 = languageManagerInstance:getLocalString(1115432)--"36级前重置免费"
UI.TEXT_223702 = languageManagerInstance:getLocalString(1115477)-- "节日"
UI.TEXT_223703 = languageManagerInstance:getLocalString(1115478)-- "限时"
UI.TEXT_223704 = languageManagerInstance:getLocalString(1115479)-- "幻化"

-- 维京时代
UI.TEXT_223800 = languageManagerInstance:getLocalString(1115483) -- 维京时代
-- UI.TEXT_223801 = languageManagerInstance:getLocalString(1114789)--"（二选一）维京时代的描述说明"
UI.TEXT_223802 = languageManagerInstance:getLocalString(1115484)--"维京时代宝石"
UI.TEXT_223803 = languageManagerInstance:getLocalString(1115485)--"维京时代第一个场景的名字"
UI.TEXT_223804 = languageManagerInstance:getLocalString(1115486)--"维京时代第二个场景的名字"
-- UI.TEXT_222105 = languageManagerInstance:getLocalString(1114802)--"维京时代第三个场景的名字"
-- UI.TEXT_222106 = languageManagerInstance:getLocalString(1114802)--"维京时代第四个场景的名字"
-- UI.TEXT_222107 = languageManagerInstance:getLocalString(1114802)--"维京时代第五个场景的名字"
-- UI.TEXT_223810 = languageManagerInstance:getLocalString(1114811)--"秘境效果"
UI.TEXT_223811 = languageManagerInstance:getLocalString(1115487)--"维京时代%d层"
UI.TEXT_223812 = languageManagerInstance:getLocalString(1115543)--"此目标已选中"
UI.TEXT_223813 = languageManagerInstance:getLocalString(1115544)--"切换频繁，%d秒后可切换"
UI.TEXT_223814 = languageManagerInstance:getLocalString(1115545)--"切换频繁"
UI.TEXT_223815 = languageManagerInstance:getLocalString(1115546)--"切换目标成功"
UI.TEXT_223816 = languageManagerInstance:getLocalString(1115551)--"提示说明"
UI.TEXT_223817 = languageManagerInstance:getLocalString(1251340)--"提示说明内容"


--符文洞窟改动
UI.TEXT_223900 = languageManagerInstance:getLocalString(1113796) -- 符文洞窟
UI.TEXT_223901 = languageManagerInstance:getLocalString(1115493) -- "积分兑换"
UI.TEXT_223902 = languageManagerInstance:getLocalString(1115494) -- "已根据历史探索次数,自动补偿等级和积分币"
UI.TEXT_223903 = languageManagerInstance:getLocalString(1115495) -- "探索1次经验+"
UI.TEXT_223904 = languageManagerInstance:getLocalString(1115496) -- "预览下级产出"
UI.TEXT_223905 = languageManagerInstance:getLocalString(1115497) -- "下一级洞窟"
UI.TEXT_223906 = languageManagerInstance:getLocalString(1115498) -- "积分币不足"
UI.TEXT_223907 = languageManagerInstance:getLocalString(1115552) -- "道具兑换"
UI.TEXT_223908 = languageManagerInstance:getLocalString(1115553) -- "消耗:"

--金矿加速
UI.TEXT_223950 = languageManagerInstance:getLocalString(1115563) -- "消耗提示"
UI.TEXT_223951 = languageManagerInstance:getLocalString(1115564) --"激活加速需要消耗以下材料"

--资质加点
UI.TEXT_224000 = languageManagerInstance:getLocalString(1115571) -- "资质加点"
UI.TEXT_224001 = languageManagerInstance:getLocalString(1115572) --"消耗"
UI.TEXT_224002 = languageManagerInstance:getLocalString(1115573) --"重置点数"
UI.TEXT_224003 = languageManagerInstance:getLocalString(1115574) --"剩余资质点：%s"
UI.TEXT_224004 = languageManagerInstance:getLocalString(1115575) --"可用资质丹：%s"
UI.TEXT_224005 = languageManagerInstance:getLocalString(1115576) --"加点完成"
UI.TEXT_224006 = languageManagerInstance:getLocalString(1115577) --"重置完成"
UI.TEXT_224007 = languageManagerInstance:getLocalString(1115578) --"升星"
UI.TEXT_224008 = languageManagerInstance:getLocalString(1115580) --"已加满！" 
UI.TEXT_224009 = languageManagerInstance:getLocalString(1115581) --"可用资质点和资质丹不足" 
UI.TEXT_224010 = languageManagerInstance:getLocalString(1115583) --"重置道具不足" 
UI.TEXT_224011 = languageManagerInstance:getLocalString(1115584) --"资质丹详情" 
UI.TEXT_224012 = languageManagerInstance:getLocalString(1115585) --"可用资质丹：%s(可用/已用)" 
UI.TEXT_224013 = languageManagerInstance:getLocalString(1115586) --"各等级资质丹数量" 
UI.TEXT_224014 = languageManagerInstance:getLocalString(1115587) --"%s级：%s" 
UI.TEXT_224015 = languageManagerInstance:getLocalString(1115588) --"可升级" 
UI.TEXT_224016 = languageManagerInstance:getLocalString(1115589) --"未选择点数" 

--宠物装备养成
UI.TEXT_224100 = languageManagerInstance:getLocalString(1115624) -- "手动吞噬"
UI.TEXT_224101 = languageManagerInstance:getLocalString(1115625) -- "确定吞噬选中道具?"
UI.TEXT_224102 = languageManagerInstance:getLocalString(1115626) -- "没有宠物"
UI.TEXT_224103 = languageManagerInstance:getLocalString(1115627) -- "宝石仓库"
UI.TEXT_224104 = languageManagerInstance:getLocalString(1115628) -- "镶嵌"
UI.TEXT_224105 = languageManagerInstance:getLocalString(1115629) -- "吞噬"
UI.TEXT_224106 = languageManagerInstance:getLocalString(1115630) -- "背包宠物装备"
UI.TEXT_224107 = languageManagerInstance:getLocalString(1115631) -- "仓库宠物装备"
UI.TEXT_224108 = languageManagerInstance:getLocalString(1115632) -- "该宝石无法镶嵌"
UI.TEXT_224109 = languageManagerInstance:getLocalString(1115633) -- "开孔后镶嵌宝石"
UI.TEXT_224110 = languageManagerInstance:getLocalString(1115634) -- "已镶嵌同类型宝石"
UI.TEXT_224111 = languageManagerInstance:getLocalString(1115635) -- "经验宝石不能镶嵌"
UI.TEXT_224112 = languageManagerInstance:getLocalString(1115636) -- "请勾选要吞噬的宝石"
UI.TEXT_224113 = languageManagerInstance:getLocalString(1115637) -- "一键吞噬"
UI.TEXT_224114 = languageManagerInstance:getLocalString(1115638) -- "请先指定吞噬的目标"
UI.TEXT_224115 = languageManagerInstance:getLocalString(1115639) -- "经验宝石不能成为吞噬目标"
UI.TEXT_224116 = languageManagerInstance:getLocalString(1115640) -- "升级所需经验"
UI.TEXT_224117 = languageManagerInstance:getLocalString(1115641) -- "吞噬说明"
UI.TEXT_224118 = languageManagerInstance:getLocalString(1115642) -- "吞噬功能的说明,这就是吞噬功能的说明,反正说了也不知道在说什么,没办法"
UI.TEXT_224119 = languageManagerInstance:getLocalString(1115643) -- "吞噬后,宝石携带等级将超过人物等级,变为%d级.将会自动从 装备中卸除到宝石背包中!"
UI.TEXT_224120 = languageManagerInstance:getLocalString(1115644) -- "吞噬后,宝石等级达到上限,经验会溢出%d,并会损失掉!"
UI.TEXT_224121 = languageManagerInstance:getLocalString(1115645) -- "等级不足"
UI.TEXT_224122 = languageManagerInstance:getLocalString(1115646) -- "至少选择一种选项"
UI.TEXT_224123 = languageManagerInstance:getLocalString(1115647) -- "吞噬符石"
UI.TEXT_224124 = languageManagerInstance:getLocalString(1112089) --"白色" 
UI.TEXT_224125 = languageManagerInstance:getLocalString(1112090) --"蓝色" 
UI.TEXT_224126 = languageManagerInstance:getLocalString(1112091) --"金色" 
UI.TEXT_224127 = languageManagerInstance:getLocalString(1112092) --"暗金" 
UI.TEXT_224128 = languageManagerInstance:getLocalString(1112093) --"紫色" 
UI.TEXT_224129 = languageManagerInstance:getLocalString(1112094) --"红色"
UI.TEXT_224130 = languageManagerInstance:getLocalString(1115648) -- "请先放入鉴定的材料"
UI.TEXT_224131 = languageManagerInstance:getLocalString(1115649) -- "鉴定说明"
UI.TEXT_224132 = languageManagerInstance:getLocalString(1115650) -- "鉴定功能的说明,这就是鉴定功能的说明,反正说了也不知道在说什么,没办法"
UI.TEXT_224133 = languageManagerInstance:getLocalString(1115651) -- "背包"
UI.TEXT_224134 = languageManagerInstance:getLocalString(1115652) -- "仓库"
UI.TEXT_224135 = languageManagerInstance:getLocalString(1115653) -- "可提供%s宝石经验"
UI.TEXT_224136 = languageManagerInstance:getLocalString(1115654) -- "请先放入能够鉴定的材料"
UI.TEXT_224137 = languageManagerInstance:getLocalString(1115655) -- "请先开孔后再镶嵌"
UI.TEXT_224138 = languageManagerInstance:getLocalString(1115658) -- "改宝石已经满级了,不能再吞噬了!"
UI.TEXT_224139 = languageManagerInstance:getLocalString(1115663) -- "鉴定失败"
UI.TEXT_224140 = languageManagerInstance:getLocalString(1117494)-- "升阶"
UI.TEXT_224141 = languageManagerInstance:getLocalString(1117495)-- "魂玉升阶"
UI.TEXT_224142 = languageManagerInstance:getLocalString(1117496)-- "满级的红色魂玉可以通过升阶提升为白金魂玉，提升魂玉属性与等级上限。白金魂玉可以通过升阶获得额外的百分比属性增益。"
UI.TEXT_224143 = languageManagerInstance:getLocalString(1117497)-- "放入魂玉"
UI.TEXT_224144 = languageManagerInstance:getLocalString(1117498)-- "升阶预览"
UI.TEXT_224145 = languageManagerInstance:getLocalString(1117499)-- "该魂玉已达到最高阶级！"
UI.TEXT_224146 = languageManagerInstance:getLocalString(1117500)-- "只有满级红色魂玉或白金魂玉才可以进行魂玉升阶！"
UI.TEXT_224147 = languageManagerInstance:getLocalString(1117501)-- "%d数量不足"

--永冬裂缝
UI.TEXT_224200 = languageManagerInstance:getLocalString(1115618) --永冬裂缝
UI.TEXT_224201 = languageManagerInstance:getLocalString(1115619) --副本奖励
UI.TEXT_224202 = languageManagerInstance:getLocalString(1115620) --掉落展示
UI.TEXT_224203 = languageManagerInstance:getLocalString(1115621) --首通奖励
UI.TEXT_224204 = languageManagerInstance:getLocalString(1115622) --难度选择
UI.TEXT_224205 = languageManagerInstance:getLocalString(1115623) --挑战次数:%s
UI.TEXT_224206 = languageManagerInstance:getLocalString(1115656) --通关副本难度%s解锁
UI.TEXT_224207 = languageManagerInstance:getLocalString(1115657)--"永冬裂缝%d层"

--转生
UI.TEXT_224300 = languageManagerInstance:getLocalString(1115672) --转生
UI.TEXT_224301 = languageManagerInstance:getLocalString(1115673) --角色转生
UI.TEXT_224302 = languageManagerInstance:getLocalString(1115674) --%s阶突破说明
UI.TEXT_224303 = languageManagerInstance:getLocalString(1115675) --<%d转%d级>
UI.TEXT_224304 = languageManagerInstance:getLocalString(1115676) --角色还未转职
UI.TEXT_224306 = languageManagerInstance:getLocalString(1115685) --"等级上限：%d转%d级"
UI.TEXT_224307 = languageManagerInstance:getLocalString(1115684) --无突破道具
UI.TEXT_224308 = languageManagerInstance:getLocalString(1115682) --等级上限突破
UI.TEXT_224309 = languageManagerInstance:getLocalString(1115683) --突破
UI.TEXT_224310 = languageManagerInstance:getLocalString(1115692) --进阶成功
UI.TEXT_224311 = languageManagerInstance:getLocalString(1115894) --%d转.%d级
UI.TEXT_224312 = languageManagerInstance:getLocalString(1115895) --*%d
UI.TEXT_224313 = languageManagerInstance:getLocalString(1115896) --今日探索次数已用完
UI.TEXT_224314 = languageManagerInstance:getLocalString(1115897) --完成任务开启转生弹窗描述
UI.TEXT_224315 = languageManagerInstance:getLocalString(1115898) --请先领取泰坦之石，再来转生
UI.TEXT_224316 = languageManagerInstance:getLocalString(1115900)    --等级 %s

--泰坦之路
UI.TEXT_224400 = languageManagerInstance:getLocalString(1115678) --泰坦之路
UI.TEXT_224401 = languageManagerInstance:getLocalString(1115679) --泰坦之路（英雄）
UI.TEXT_224402 = languageManagerInstance:getLocalString(1115680)--"泰坦之路%d层"
UI.TEXT_224403 = languageManagerInstance:getLocalString(1115681) --等级达到%s级可挑战
UI.TEXT_224404 = languageManagerInstance:getLocalString(1115901) --模式选择
UI.TEXT_224405 = languageManagerInstance:getLocalString(1115902) --等级达到%s级才可进入！
UI.TEXT_224406 = languageManagerInstance:getLocalString(1116142) --通关泰坦之路后解锁

--宠物技能炼化
UI.TEXT_224500 = languageManagerInstance:getLocalString(1115904) --"特质技能不能进行炼化"

--水晶夺宝
UI.TEXT_224600 = languageManagerInstance:getLocalString(1115905) --"水晶夺宝"
UI.TEXT_224601 = languageManagerInstance:getLocalString(1115906) --"下次将在内圈抽取奖励"
UI.TEXT_224602 = languageManagerInstance:getLocalString(1115907) --"奖励已通过邮件发送！"
UI.TEXT_224604 = languageManagerInstance:getLocalString(1115908) --"夺宝商店"

--符文模具
UI.TEXT_224700 = languageManagerInstance:getLocalString(1116066) --模具锻造
UI.TEXT_224701 = languageManagerInstance:getLocalString(1116067) --锻造模具
UI.TEXT_224702 = languageManagerInstance:getLocalString(1116068) --镶嵌符石
UI.TEXT_224703 = languageManagerInstance:getLocalString(1116069) --符石类型不合，填充失败
UI.TEXT_224704 = languageManagerInstance:getLocalString(1116070) --碎片说明
UI.TEXT_224705 = languageManagerInstance:getLocalString(1116071) --(%s/%s)
UI.TEXT_224706 = languageManagerInstance:getLocalString(1116072) --使用模具
UI.TEXT_224707 = languageManagerInstance:getLocalString(1116073) --模具箱
UI.TEXT_224708 = languageManagerInstance:getLocalString(1116074) --模具列表
UI.TEXT_224709 = languageManagerInstance:getLocalString(1116075) --拖动到模具箱使用模具
UI.TEXT_224710 = languageManagerInstance:getLocalString(1116094) --激活条件:%s
UI.TEXT_224711 = languageManagerInstance:getLocalString(1116095) --镶满符石
UI.TEXT_224712 = languageManagerInstance:getLocalString(1116096) --所有符石等级大于%s
UI.TEXT_224713 = languageManagerInstance:getLocalString(1116097) --下级效果
UI.TEXT_224714 = languageManagerInstance:getLocalString(1116116) --模具属性加成
UI.TEXT_224715 = languageManagerInstance:getLocalString(1116117 ) --加成：

--洞窟探宝
UI.TEXT_224800 = languageManagerInstance:getLocalString(1116148) --洞窟探宝
UI.TEXT_224801 = languageManagerInstance:getLocalString(1116149) --刷新次数:%d
UI.TEXT_224802 = languageManagerInstance:getLocalString(1116150) --前往探宝
UI.TEXT_224803 = languageManagerInstance:getLocalString(1116151) --已进入洞窟，无法再刷新宝箱
UI.TEXT_224804 = languageManagerInstance:getLocalString(1116152) --今日无法再刷新
UI.TEXT_224805 = languageManagerInstance:getLocalString(1116153) --次数不足，无法刷新
UI.TEXT_224806 = languageManagerInstance:getLocalString(1116154) --进入后当天无法再刷新宝箱
UI.TEXT_224807 = languageManagerInstance:getLocalString(1116239) --钥匙不足
UI.TEXT_224808 = languageManagerInstance:getLocalString(1116240) --刷新道具不足

--限时累充活动
UI.TEXT_224900 = languageManagerInstance:getLocalString(1116267) --(%d元/%d元)

--干涸之泉
UI.TEXT_225000 = languageManagerInstance:getLocalString(1116318) --干涸之泉
UI.TEXT_225001 = languageManagerInstance:getLocalString(1116319) --"干涸之泉%d层"

--大航海事件
UI.TEXT_226000 = languageManagerInstance:getLocalString(1116473) --事件日志
UI.TEXT_226001 = languageManagerInstance:getLocalString(1116474) --"个人事件"
UI.TEXT_226002 = languageManagerInstance:getLocalString(1116475) --"公会事件"
UI.TEXT_226003 = languageManagerInstance:getLocalString(1116476) --"派遣事件"
UI.TEXT_226004 = languageManagerInstance:getLocalString(1116477) --"驱逐事件"
UI.TEXT_226005 = languageManagerInstance:getLocalString(1116478) --"占领事件"
UI.TEXT_226006 = languageManagerInstance:getLocalString(1116479) --"返航事件"
UI.TEXT_226007 = languageManagerInstance:getLocalString(1116480) --"BOSS事件"

--大航海
UI.TEXT_226100 = languageManagerInstance:getLocalString(1116352) --"购买补给"
UI.TEXT_226101 = languageManagerInstance:getLocalString(1116353) --"当前补给数量"
UI.TEXT_226102 = languageManagerInstance:getLocalString(1116354) --"补充补给品"
UI.TEXT_226103 = languageManagerInstance:getLocalString(1116355) --"所选船只补给"
UI.TEXT_226105 = languageManagerInstance:getLocalString(1116356) --"补给成功"
UI.TEXT_226106 = languageManagerInstance:getLocalString(1116357) --"补给不足"
UI.TEXT_226107 = languageManagerInstance:getLocalString(1116358) --"补给品数量"
UI.TEXT_226108 = languageManagerInstance:getLocalString(1116359) --"添加补给"
UI.TEXT_226109 = languageManagerInstance:getLocalString(1116360) --"在港口中"
UI.TEXT_226110 = languageManagerInstance:getLocalString(1116361) --"大航海出海中"
UI.TEXT_226111 = languageManagerInstance:getLocalString(1116362) --"航行完成等待占领"
UI.TEXT_226112 = languageManagerInstance:getLocalString(1116363) --"已占岛屿"
UI.TEXT_226113 = languageManagerInstance:getLocalString(1116364) --"设置船员成功"
UI.TEXT_226114 = languageManagerInstance:getLocalString(1116365) --"航行加速"
UI.TEXT_226115 = languageManagerInstance:getLocalString(1116366) --"一键完成"
UI.TEXT_226116 = languageManagerInstance:getLocalString(1116367) --"本次航行剩余%s小时%s分钟"
UI.TEXT_226117 = languageManagerInstance:getLocalString(1116368) --"驱逐"
UI.TEXT_226118 = languageManagerInstance:getLocalString(1116369) --"驱逐一次"
UI.TEXT_226119 = languageManagerInstance:getLocalString(1116370) --"驱逐五次"
UI.TEXT_226120 = languageManagerInstance:getLocalString(1116371) --"敌方阵容"
UI.TEXT_226121 = languageManagerInstance:getLocalString(1116372) --"我方阵容"
UI.TEXT_226122 = languageManagerInstance:getLocalString(1116373) --"岛屿公会/会长名字"
UI.TEXT_226123 = languageManagerInstance:getLocalString(1116374) --"科技总等级"
UI.TEXT_226124 = languageManagerInstance:getLocalString(1116375) --"公会人数"
UI.TEXT_226125 = languageManagerInstance:getLocalString(1116376) --"设置为敌对"
UI.TEXT_226126 = languageManagerInstance:getLocalString(1116377) --"未占领该岛屿,产量"
UI.TEXT_226127 = languageManagerInstance:getLocalString(1116378) --"基础产量"
UI.TEXT_226128 = languageManagerInstance:getLocalString(1116379) --"产量加成"
UI.TEXT_226129 = languageManagerInstance:getLocalString(1116380) --"产量减产"
UI.TEXT_226130 = languageManagerInstance:getLocalString(1116381) --"占领船只"
UI.TEXT_226131 = languageManagerInstance:getLocalString(1116382) --"标记敌对帮派"
UI.TEXT_226132 = languageManagerInstance:getLocalString(1116383) --"取消占领"
UI.TEXT_226133 = languageManagerInstance:getLocalString(1116384) --"占领"
UI.TEXT_226134 = languageManagerInstance:getLocalString(1116385) --"标记集中占领"
UI.TEXT_226135 = languageManagerInstance:getLocalString(1116386) --"更换占领岛屿"
UI.TEXT_226136 = languageManagerInstance:getLocalString(1116387) --"取消集中占领"
UI.TEXT_226137 = languageManagerInstance:getLocalString(1116388) --"已占领该岛屿,产量"
UI.TEXT_226138 = languageManagerInstance:getLocalString(1116389) --"驱逐结果"
UI.TEXT_226139 = languageManagerInstance:getLocalString(1116390) --"头像"
UI.TEXT_226140 = languageManagerInstance:getLocalString(1116391) --"产量"
UI.TEXT_226141 = languageManagerInstance:getLocalString(1116392) --"补给品-"
UI.TEXT_226142 = languageManagerInstance:getLocalString(1116393) --"剩余:"
UI.TEXT_226143 = languageManagerInstance:getLocalString(1116394) --"战斗胜利"
UI.TEXT_226144 = languageManagerInstance:getLocalString(1116395) --"战斗失败"
UI.TEXT_226145 = languageManagerInstance:getLocalString(1116397) --"船只编队"
UI.TEXT_226146 = languageManagerInstance:getLocalString(1116398) --"周任务"
UI.TEXT_226147 = languageManagerInstance:getLocalString(1116399) --"派遣船只"
UI.TEXT_226148 = languageManagerInstance:getLocalString(1116400) --"已派遣船只:"
UI.TEXT_226149 = languageManagerInstance:getLocalString(1116401) --"派遣"
UI.TEXT_226150 = languageManagerInstance:getLocalString(1116402) --"派遣成功"
UI.TEXT_226151 = languageManagerInstance:getLocalString(1116403) --"标记敌对"
UI.TEXT_226152 = languageManagerInstance:getLocalString(1116404) --"取消标记"
UI.TEXT_226153 = languageManagerInstance:getLocalString(1116405) --"本次航行剩余时间:"
UI.TEXT_226154 = languageManagerInstance:getLocalString(1116406) --"是否消耗钻石加速完成航行"
UI.TEXT_226155 = languageManagerInstance:getLocalString(1116407) --"占领奖励"
UI.TEXT_226156 = languageManagerInstance:getLocalString(1116408) --"当前总产量"
UI.TEXT_226157 = languageManagerInstance:getLocalString(1116409) --"已获得资源"
UI.TEXT_226158 = languageManagerInstance:getLocalString(1116410) --"每日任务"
UI.TEXT_226159 = languageManagerInstance:getLocalString(1116411) --"每周任务"
UI.TEXT_226160 = languageManagerInstance:getLocalString(1116464) --"敌对公会"
UI.TEXT_226161 = languageManagerInstance:getLocalString(1116499) --"碎片不足，无法购买"
UI.TEXT_226162 = languageManagerInstance:getLocalString(1116500) --"限购"
UI.TEXT_226163 = languageManagerInstance:getLocalString(1116501) --"船只补给已满，无法补给"
UI.TEXT_226164 = languageManagerInstance:getLocalString(1116502) --"未占领"
UI.TEXT_226165 = languageManagerInstance:getLocalString(1116503) --"已派遣船只前来占领"
UI.TEXT_226166 = languageManagerInstance:getLocalString(1116504) --"不满足派遣条件"
UI.TEXT_226167 = languageManagerInstance:getLocalString(1116505) --"不在公会中"
UI.TEXT_226168 = languageManagerInstance:getLocalString(1116506) --"只有占领岛屿后，才可驱逐"
UI.TEXT_226169 = languageManagerInstance:getLocalString(1116507) --"提示船员配置满了"
UI.TEXT_226170 = languageManagerInstance:getLocalString(1116508) --"非管理员，无法操作"
UI.TEXT_226171 = languageManagerInstance:getLocalString(1116509) --"标记成功"
UI.TEXT_226172 = languageManagerInstance:getLocalString(1116510) --"已取消"
UI.TEXT_226173 = languageManagerInstance:getLocalString(1116511) --"请先加入公会！"
UI.TEXT_226174 = languageManagerInstance:getLocalString(1116518) --"不能对同一岛屿多次派遣"
UI.TEXT_226175 = languageManagerInstance:getLocalString(1116519) --"补给不足，先去补给仓补充补给吧！"
UI.TEXT_226176 = languageManagerInstance:getLocalString(1116520) --"加速成功，已占领岛屿"
UI.TEXT_226177 = languageManagerInstance:getLocalString(1116521) --"船只补给为0，已返回港口"
UI.TEXT_226178 = languageManagerInstance:getLocalString(1116522) --"已成功将敌方船只驱逐回港！"
UI.TEXT_226179 = languageManagerInstance:getLocalString(1116523) --"派遣船只数量达到上限!"
UI.TEXT_226180 = languageManagerInstance:getLocalString(1116524) --"宠物正在大航海中，无法合成"
UI.TEXT_226181 = languageManagerInstance:getLocalString(1116525) --"正在被驱逐中，无法取消占领"
UI.TEXT_226182 = languageManagerInstance:getLocalString(1116527) --"派遣(占领中...)"
UI.TEXT_226183 = languageManagerInstance:getLocalString(1116528) --"该船只正在占领%s岛屿，是否取消占领，派遣至新岛屿?"
UI.TEXT_226184 = languageManagerInstance:getLocalString(1116529) --"大航海操作太频繁"
UI.TEXT_226185 = languageManagerInstance:getLocalString(1116546) --"未在港口的船只，不能变更宠物"
UI.TEXT_226186 = languageManagerInstance:getLocalString(1116695) --"设置失败"
UI.TEXT_226187 = languageManagerInstance:getLocalString(1117167) --"宠物总星数差距太大,若跳转失败,需要消耗%d个补给品"
UI.TEXT_226188 = languageManagerInstance:getLocalString(1117334) -- 未达到补给%d点的要求
UI.TEXT_226189 = languageManagerInstance:getLocalString(1117333) -- 补给限制

--大航海Boss
UI.TEXT_226200 = languageManagerInstance:getLocalString(1116481) --终极boss
UI.TEXT_226201 = languageManagerInstance:getLocalString(1116482) --"征讨异兽"
UI.TEXT_226202 = languageManagerInstance:getLocalString(1116483) --"累计伤害榜"
UI.TEXT_226203 = languageManagerInstance:getLocalString(1116484) --"累计伤害："
UI.TEXT_226204 = languageManagerInstance:getLocalString(1116485) --"BOSS事件"
UI.TEXT_226205 = languageManagerInstance:getLocalString(1116486) --"剩余次数:%s"
UI.TEXT_226206 = languageManagerInstance:getLocalString(1116487) --"加速"
UI.TEXT_226207 = languageManagerInstance:getLocalString(1116488) --"行驶至%s中..."
UI.TEXT_226208 = languageManagerInstance:getLocalString(1116489) --"无法加速，船只在港口中"
UI.TEXT_226209 = languageManagerInstance:getLocalString(1116490) --"Boss开启时间%s"
UI.TEXT_226210 = languageManagerInstance:getLocalString(1116491) --"Boss即将出现%s"
UI.TEXT_226211 = languageManagerInstance:getLocalString(1116492) --"丰收即将来临%s"
UI.TEXT_226212 = languageManagerInstance:getLocalString(1116493) --"不满足挑战boss条件"
UI.TEXT_226213 = languageManagerInstance:getLocalString(1116494) --"征讨boss次数不足"
UI.TEXT_226214 = languageManagerInstance:getLocalString(1116495) --"剩余%s"
UI.TEXT_226215 = languageManagerInstance:getLocalString(1116496) --"征讨"
UI.TEXT_226216 = languageManagerInstance:getLocalString(1116497) --出海口已经关闭，明天10点重新开放
UI.TEXT_226217 = languageManagerInstance:getLocalString(1116498) --补给品-%s
UI.TEXT_226218 = languageManagerInstance:getLocalString(1116516) --占领%s中
UI.TEXT_226219 = languageManagerInstance:getLocalString(1116517) --查看

--魂玉转换
UI.TEXT_226300 = languageManagerInstance:getLocalString(1116538) -- 魂玉转换
UI.TEXT_226301 = languageManagerInstance:getLocalString(1116539) -- "转换功能的说明,这就是转换功能的说明,反正说了也不知道在说什么,没办法"
UI.TEXT_226302 = languageManagerInstance:getLocalString(1116540) -- "选择魂石"
UI.TEXT_226303 = languageManagerInstance:getLocalString(1116541) -- "请选择一个魂石"
UI.TEXT_226304 = languageManagerInstance:getLocalString(1116542) -- "放入魂玉"
UI.TEXT_226305 = languageManagerInstance:getLocalString(1116543) --"上次转换的魂玉还没有选择"
UI.TEXT_226306 = languageManagerInstance:getLocalString(1116544) --"材料不足，无法转换"
UI.TEXT_226307 = languageManagerInstance:getLocalString(1116545) -- "经验宝石不能成为转换目标"

--经验副本
UI.TEXT_226400 = languageManagerInstance:getLocalString(1116674) --"历练之地"
UI.TEXT_226401 = languageManagerInstance:getLocalString(1116675) --"金币挑战"

--混沌虫洞
UI.TEXT_226500 = languageManagerInstance:getLocalString(1116713) --"混沌虫洞"
UI.TEXT_226501 = languageManagerInstance:getLocalString(1116714) --"混沌虫洞%d层"
UI.TEXT_226502 = languageManagerInstance:getLocalString(1117161) --"阶段%d"
UI.TEXT_226503 = languageManagerInstance:getLocalString(1117162) --"阶段选择"
UI.TEXT_226504 = languageManagerInstance:getLocalString(1117173) --"混沌虫洞%d阶段"


--装备改造
UI.TEXT_226600 = languageManagerInstance:getLocalString(1116681) --"装备正在改造中，无法放入"
UI.TEXT_226601 = languageManagerInstance:getLocalString(1116682) --"该装备无改造属性，无法放入"
UI.TEXT_226602 = languageManagerInstance:getLocalString(1116683) --"装备随机属性与改造属性相同，无法继承"
UI.TEXT_226603 = languageManagerInstance:getLocalString(1116684) --"已放入装备！"
UI.TEXT_226604 = languageManagerInstance:getLocalString(1116685) --"请放入改造装备"
UI.TEXT_226605 = languageManagerInstance:getLocalString(1116686) --"请放入继承装备"
UI.TEXT_226606 = languageManagerInstance:getLocalString(1116687) --"有未替换的继承属性，退出后不会保留，是否退出?"
UI.TEXT_226607 = languageManagerInstance:getLocalString(1116688) --"装备改造"
UI.TEXT_226608 = languageManagerInstance:getLocalString(1116689) --"改造继承"
UI.TEXT_226609 = languageManagerInstance:getLocalString(1116690) --"继承"
UI.TEXT_226610 = languageManagerInstance:getLocalString(1116691) --"请选择属性"
UI.TEXT_226611 = languageManagerInstance:getLocalString(1116693) --"继承成功"
UI.TEXT_226612 = languageManagerInstance:getLocalString(1116694) --"选择属性进行继承"

--大航海岛怪
UI.TEXT_226700 = languageManagerInstance:getLocalString(1116697) --"刷新岛怪"
UI.TEXT_226701 = languageManagerInstance:getLocalString(1116698) --"是否消耗水晶刷新所有岛屿中的岛怪?"
UI.TEXT_226702 = languageManagerInstance:getLocalString(1116699) --"(岛屿上还有岛怪未被清除)"
UI.TEXT_226703 = languageManagerInstance:getLocalString(1116700) --"限时任务"
UI.TEXT_226704 = languageManagerInstance:getLocalString(1116701) --"常驻商店"
UI.TEXT_226705 = languageManagerInstance:getLocalString(1116702) --"限时商店"
UI.TEXT_226706 = languageManagerInstance:getLocalString(1116703) --"岛怪"
UI.TEXT_226707 = languageManagerInstance:getLocalString(1116704) --"岛怪刷新失败"


--宠物皮肤
UI.TEXT_226800 = languageManagerInstance:getLocalString(1116708) --"皮肤已解锁，请打开宠物界面查看"
UI.TEXT_226801 = languageManagerInstance:getLocalString(1116709) --"皮肤已获得（重复解锁）"
UI.TEXT_226802 = languageManagerInstance:getLocalString(1116710) --"敬请期待"
UI.TEXT_226803 = languageManagerInstance:getLocalString(1116711) --"皮肤属性"

--大航海周年优化
UI.TEXT_226900 = languageManagerInstance:getLocalString(1116715) --"返航"
UI.TEXT_226901 = languageManagerInstance:getLocalString(1116716) --"岛屿伤害加成即将出现在%s"
UI.TEXT_226902 = languageManagerInstance:getLocalString(1116717) --"实际产量"
UI.TEXT_226903 = languageManagerInstance:getLocalString(1116718) --"帮派加成"
UI.TEXT_226904 = languageManagerInstance:getLocalString(1116719) --"未达到等级%d要求"
UI.TEXT_226905 = languageManagerInstance:getLocalString(1116720) --"未达到战力%d要求"
UI.TEXT_226906 = languageManagerInstance:getLocalString(1116721) --"战力不足"

--雕文
UI.TEXT_227000 = languageManagerInstance:getLocalString(1116818) --"已装备雕纹不能进行售卖"
UI.TEXT_227001 = languageManagerInstance:getLocalString(1116819) --"保存"
UI.TEXT_227002 = languageManagerInstance:getLocalString(1116820) --"请放入雕纹"
UI.TEXT_227003 = languageManagerInstance:getLocalString(1116821) --"请洗练"
UI.TEXT_227004 = languageManagerInstance:getLocalString(1116822) --"铭文不足"
UI.TEXT_227005 = languageManagerInstance:getLocalString(1116823) --"洗练结果均为提升，是否继续放弃?"
UI.TEXT_227006 = languageManagerInstance:getLocalString(1116824) --"雕纹属性已满"
UI.TEXT_227007 = languageManagerInstance:getLocalString(1116825) --"需要先放置装备"
UI.TEXT_227008 = languageManagerInstance:getLocalString(1116826) --"水晶洗练"
UI.TEXT_227009 = languageManagerInstance:getLocalString(1116827) --"已镶嵌雕纹"
UI.TEXT_227010 = languageManagerInstance:getLocalString(1116828) --"请放入装备"
UI.TEXT_227011 = languageManagerInstance:getLocalString(1116829) --"选中雕纹中有高品质的雕纹，\n是否确认分解？"
UI.TEXT_227012 = languageManagerInstance:getLocalString(1116830) --"选中雕纹中有洗练过的雕纹，\n是否确认分解？"
UI.TEXT_227013 = languageManagerInstance:getLocalString(1116831) --"镶嵌有雕纹的装备不能作为精炼材料"
UI.TEXT_227014 = languageManagerInstance:getLocalString(1116832) --"镶嵌有雕纹的装备不能转换"
UI.TEXT_227015 = languageManagerInstance:getLocalString(1116833) --"嵌有雕纹的装备不能被重铸"
UI.TEXT_227016 = languageManagerInstance:getLocalString(1116834) -- "有雕纹，不能强化"
UI.TEXT_227017 = languageManagerInstance:getLocalString(1116835) -- "洗练失败"
UI.TEXT_227018 = languageManagerInstance:getLocalString(1116864) -- "洗练消耗:"
UI.TEXT_227019 = languageManagerInstance:getLocalString(1116865) -- "洗练设置"
UI.TEXT_227020 = languageManagerInstance:getLocalString(1116855) -- "鱼竿不能镶嵌雕纹"
UI.TEXT_227021 = languageManagerInstance:getLocalString(1116866) -- "属性价值为正"
UI.TEXT_227022 = languageManagerInstance:getLocalString(1116867) -- "必须选择一个保存条件"
UI.TEXT_227023 = languageManagerInstance:getLocalString(1116868) -- "停止洗练"
UI.TEXT_227024 = languageManagerInstance:getLocalString(1116869) -- "所勾选的属性为正时保存洗练结果"
UI.TEXT_227025 = languageManagerInstance:getLocalString(1116870) -- "设置的次数洗练完后自动停止洗练"
UI.TEXT_227026 = languageManagerInstance:getLocalString(1116871) -- "开始洗练"
UI.TEXT_227027 = languageManagerInstance:getLocalString(1116872) -- "洗练结果"
UI.TEXT_227028 = languageManagerInstance:getLocalString(1116874) -- "洗练详情"
UI.TEXT_227029 = languageManagerInstance:getLocalString(1116875) -- "雕纹镶嵌"
UI.TEXT_227030 = languageManagerInstance:getLocalString(1116876) -- "雕纹洗练"
UI.TEXT_227031 = languageManagerInstance:getLocalString(1117335) -- "快速洗练"
UI.TEXT_227032 = languageManagerInstance:getLocalString(1170332) -- "快速洗练无法取消勾选属性"


--雕文铸造
UI.TEXT_227050 = languageManagerInstance:getLocalString(1116836) --"雕文铸造"
UI.TEXT_227051 = languageManagerInstance:getLocalString(1116837) --"镶嵌"
UI.TEXT_227052 = languageManagerInstance:getLocalString(1116838) --"继承"
UI.TEXT_227053 = languageManagerInstance:getLocalString(1116839) --"洗练"
UI.TEXT_227054 = languageManagerInstance:getLocalString(1116840) --"铸造"
UI.TEXT_227055 = languageManagerInstance:getLocalString(1116841) --"%d级"
UI.TEXT_227056 = languageManagerInstance:getLocalString(1116842) --"消耗材料"
UI.TEXT_227057 = languageManagerInstance:getLocalString(1116859) --"%s数量不足%d个"
UI.TEXT_227058 = languageManagerInstance:getLocalString(1116844) --"所选级别之和必须等于10级"
UI.TEXT_227059 = languageManagerInstance:getLocalString(1116845) --"铸造失败"
UI.TEXT_227060 = languageManagerInstance:getLocalString(1116846) --"之"
UI.TEXT_227061 = languageManagerInstance:getLocalString(1116847) --"请放入雕纹"
UI.TEXT_227062 = languageManagerInstance:getLocalString(1116848) --"请放入材料雕纹"
UI.TEXT_227063 = languageManagerInstance:getLocalString(1116849) --"选择属性进行继承"
UI.TEXT_227064 = languageManagerInstance:getLocalString(1116850) --"2星雕纹不可继承"
UI.TEXT_227065 = languageManagerInstance:getLocalString(1116851) --"请放入主雕文"
UI.TEXT_227066 = languageManagerInstance:getLocalString(1116852) --"%d星雕纹只能使用%d-%d星的雕纹进行继承"
UI.TEXT_227067 = languageManagerInstance:getLocalString(1116853) --"雕纹属性类型重复"
UI.TEXT_227068 = languageManagerInstance:getLocalString(1116854) --"雕纹背包已满"
UI.TEXT_227069 = languageManagerInstance:getLocalString(1116856) --"粉尘"
UI.TEXT_227070 = languageManagerInstance:getLocalString(1116857) --"碎块"
UI.TEXT_227071 = languageManagerInstance:getLocalString(1116858) --"晶体"
UI.TEXT_227072 = languageManagerInstance:getLocalString(1116879) --"剩余铸造次数:%d"
UI.TEXT_227073 = languageManagerInstance:getLocalString(1116880) --"铸造次数不足"

--试炼之地
UI.TEXT_227100 = languageManagerInstance:getLocalString(1116727) --"%d阶%d"

--虫洞深处
UI.TEXT_227200 = languageManagerInstance:getLocalString(1116891) --"虫洞深处"
UI.TEXT_227201 = languageManagerInstance:getLocalString(1116892)--"虫洞深处%d层"
UI.TEXT_227202 = languageManagerInstance:getLocalString(1116893)--"可能掉落奖励"
UI.TEXT_227203 = languageManagerInstance:getLocalString(1116894)--"本周已获取铭文：%d/%d"


--全服团购
UI.TEXT_227300 = "活动时间%s开启" --languageManagerInstance:getLocalString() --"活动时间%s开启"
UI.TEXT_227301 = "未开始" --languageManagerInstance:getLocalString() --"未开始"
UI.TEXT_227302 = "团购中" --languageManagerInstance:getLocalString() --"团购中"
UI.TEXT_227303 = "已结束" --languageManagerInstance:getLocalString() --"已结束"

--辅助星图
UI.TEXT_227400 = languageManagerInstance:getLocalString(1116881) --"战斗\n星图"
UI.TEXT_227401 = languageManagerInstance:getLocalString(1116882) --"辅助\n星图"
UI.TEXT_227402 = languageManagerInstance:getLocalString(1116883) --"战斗卡槽"
UI.TEXT_227403 = languageManagerInstance:getLocalString(1116884) --"辅助卡槽"

-- 紫升红
UI.TEXT_227500 = languageManagerInstance:getLocalString(1116898) --"装备升品"
UI.TEXT_227501 = languageManagerInstance:getLocalString(1116899) --"红装重置"
UI.TEXT_227502 = languageManagerInstance:getLocalString(1116900) --"碎片兑换"
UI.TEXT_227503 = languageManagerInstance:getLocalString(1116901) --"升级品质"
UI.TEXT_227504 = languageManagerInstance:getLocalString(1116902) --"请放入装备和原石"
UI.TEXT_227505 = languageManagerInstance:getLocalString(1116903) --"需放入与装备部位相同的原石"
UI.TEXT_227506 = languageManagerInstance:getLocalString(1116904) --"请放入原石"
UI.TEXT_227507 = languageManagerInstance:getLocalString(1116905) --"点击升品按钮升为红装"
UI.TEXT_227508 = languageManagerInstance:getLocalString(1116906) --"装备需要精炼满才能升红"
UI.TEXT_227509 = languageManagerInstance:getLocalString(1116969) --"原石无法被分解或售卖！"
UI.TEXT_227510 = languageManagerInstance:getLocalString(1117058) --"原石碎片不足"
UI.TEXT_227511 = languageManagerInstance:getLocalString(1117059) --"全部"
UI.TEXT_227512 = languageManagerInstance:getLocalString(1117060) --"部位筛选：%s"
UI.TEXT_227513 = languageManagerInstance:getLocalString(1117061) --"职业筛选：%s"
UI.TEXT_227514 = languageManagerInstance:getLocalString(1117062) --"星级筛选：%s"
UI.TEXT_227515 = languageManagerInstance:getLocalString(1117063) --"一星"
UI.TEXT_227516 = languageManagerInstance:getLocalString(1117064) --"二星"
UI.TEXT_227517 = languageManagerInstance:getLocalString(1117065) --"三星"
UI.TEXT_227518 = languageManagerInstance:getLocalString(1117174) --"重置装备"
UI.TEXT_227519 = languageManagerInstance:getLocalString(1117175) --"请放入装备"
UI.TEXT_227520 = languageManagerInstance:getLocalString(1117176) --"重置成功"
UI.TEXT_227521 = languageManagerInstance:getLocalString(1117177) --"点击重置"
UI.TEXT_227522 = languageManagerInstance:getLocalString(1117205) --"副本筛选：%s"
UI.TEXT_227523 = languageManagerInstance:getLocalString(1117206) --"置换碎片"



-- 拉力赛
UI.TEXT_227600 = languageManagerInstance:getLocalString(1117068) --"航海拉力赛"
UI.TEXT_227601 = languageManagerInstance:getLocalString(1117069) --"比赛日志"
UI.TEXT_227602 = languageManagerInstance:getLocalString(1117070) --"比赛投注"
UI.TEXT_227603 = languageManagerInstance:getLocalString(1117071) --"往期结果"
UI.TEXT_227604 = languageManagerInstance:getLocalString(1117072) --"我的投注"
UI.TEXT_227605 = languageManagerInstance:getLocalString(1117073) --"赔率：%s"
UI.TEXT_227606 = languageManagerInstance:getLocalString(1117074) --"投注"
UI.TEXT_227607 = languageManagerInstance:getLocalString(1117075) --"投注：%d"
UI.TEXT_227608 = languageManagerInstance:getLocalString(1117076) --"我的竞猜币"
UI.TEXT_227609 = languageManagerInstance:getLocalString(1117077) --"投注后可在比赛期间%s,合理使用技能帮助船只获胜"
UI.TEXT_227610 = languageManagerInstance:getLocalString(1117078) --"比赛开始倒计时：%s"
UI.TEXT_227611 = languageManagerInstance:getLocalString(1117079) --"拉力比赛投注中..."
UI.TEXT_227612 = languageManagerInstance:getLocalString(1117080) --"开始投注"
UI.TEXT_227613 = languageManagerInstance:getLocalString(1117081) --"是否离开洞窟返回城镇，然后前往港口投注?"
UI.TEXT_227614 = languageManagerInstance:getLocalString(1117082) --"竞猜币数量不足100，无法投注"
UI.TEXT_227615 = languageManagerInstance:getLocalString(1117083) --"投注成功"
UI.TEXT_227616 = languageManagerInstance:getLocalString(1117084) --"比赛正在进行中，无法投注"
UI.TEXT_227617 = languageManagerInstance:getLocalString(1117085) --"一场比赛只能投注一只船"
UI.TEXT_227618 = languageManagerInstance:getLocalString(1117086) --"比赛进行中..."
UI.TEXT_227619 = languageManagerInstance:getLocalString(1117087) --"休赛期..."
UI.TEXT_227620 = languageManagerInstance:getLocalString(1117088) --"比赛结束"
UI.TEXT_227621 = languageManagerInstance:getLocalString(1117089) --"第一名：%s"
UI.TEXT_227622 = languageManagerInstance:getLocalString(1117090) --"请选择技能目标"
UI.TEXT_227623 = languageManagerInstance:getLocalString(1117091) --"选择"
UI.TEXT_227624 = languageManagerInstance:getLocalString(1117092) --"已投注"
UI.TEXT_227625 = languageManagerInstance:getLocalString(1117093) --"拉力赛信息"
UI.TEXT_227626 = languageManagerInstance:getLocalString(1117094) --"消耗:"
UI.TEXT_227627 = languageManagerInstance:getLocalString(1117095) --"技能点%s(剩余%s)"
UI.TEXT_227628 = languageManagerInstance:getLocalString(1117096) --"次数已用完"
UI.TEXT_227629 = languageManagerInstance:getLocalString(1117097) --"使用道具"
UI.TEXT_227630 = languageManagerInstance:getLocalString(1117098) --"本场比赛无法再使用技能"
UI.TEXT_227631 = languageManagerInstance:getLocalString(1117099) --"你本厂比赛未投注，无法触发该功能"
UI.TEXT_227632 = languageManagerInstance:getLocalString(1117100) --"领取竞猜币成功"
UI.TEXT_227633 = languageManagerInstance:getLocalString(1117101) --"道具使用成功"
UI.TEXT_227634 = languageManagerInstance:getLocalString(1117102) --"拉力比赛游戏中..."
UI.TEXT_227635 = languageManagerInstance:getLocalString(1117103) --"%s海里/分"
UI.TEXT_227636 = languageManagerInstance:getLocalString(1117104) --"%s海里"
UI.TEXT_227637 = languageManagerInstance:getLocalString(1117105) --"已经达到最大投注量，无法继续投注"
UI.TEXT_227638 = languageManagerInstance:getLocalString(1117106) --"未在比赛时间，无法打开比赛页面"
UI.TEXT_227639 = languageManagerInstance:getLocalString(1117107) --"累计获胜"
UI.TEXT_227640 = languageManagerInstance:getLocalString(1117108) --"比赛正在修赛期，无法投注"
UI.TEXT_227641 = languageManagerInstance:getLocalString(1117109) --"奖池:"
UI.TEXT_227642 = languageManagerInstance:getLocalString(1117110) --"投注开始倒计时：%s"
UI.TEXT_227643 = languageManagerInstance:getLocalString(1117111) --"当前船以跑完，无法对其使用"
UI.TEXT_227644 = languageManagerInstance:getLocalString(1117112) --"自己投注的船未产生对应负面影响，不需要使用该道具"
UI.TEXT_227645 = languageManagerInstance:getLocalString(1117113) --"停止"
UI.TEXT_227646 = languageManagerInstance:getLocalString(1117114) --"反向"
UI.TEXT_227647 = languageManagerInstance:getLocalString(1117129) --"比赛未开始，无法使用道具"
UI.TEXT_227648 = languageManagerInstance:getLocalString(1117130) --"前往比赛"
UI.TEXT_227649 = languageManagerInstance:getLocalString(1117131) --"比赛未开始, 无法使用技能"

UI.TEXT_227700 = languageManagerInstance:getLocalString(1117116) --"星盘属性"
UI.TEXT_227701 = languageManagerInstance:getLocalString(1117117) --"生效中"
UI.TEXT_227702 = languageManagerInstance:getLocalString(1117118) --"星盘等级达到%d级解锁"
UI.TEXT_227703 = languageManagerInstance:getLocalString(1117119) --"出战中"
UI.TEXT_227704 = languageManagerInstance:getLocalString(1117120) --"道具解锁"
UI.TEXT_227705 = languageManagerInstance:getLocalString(1117121) --"%s解锁"
UI.TEXT_227706 = languageManagerInstance:getLocalString(1117122) --"通关混沌虫洞"
UI.TEXT_227707 = languageManagerInstance:getLocalString(1117123) --"水晶解锁"
UI.TEXT_227708 = languageManagerInstance:getLocalString(1117124) --"是否花费%s钻石解锁星盘"
UI.TEXT_227709 = languageManagerInstance:getLocalString(1117125) --"星盘已解锁"
UI.TEXT_227710 = languageManagerInstance:getLocalString(1117126) --"上阵星痕属性加成"
UI.TEXT_227711 = languageManagerInstance:getLocalString(1117127) --"生效星盘属性"
UI.TEXT_227712 = languageManagerInstance:getLocalString(1117128) --"星盘未解锁"

--航海商店优化相关文字
UI.TEXT_227800 = languageManagerInstance:getLocalString(1117163) --"请选择要兑换的数量"

-- 符文石链接
UI.TEXT_227900 = languageManagerInstance:getLocalString(1117178) -- "镶嵌在装备上,且等级不小于9级的符文石氪作为主符文石进行符文石链接."
UI.TEXT_227901 = languageManagerInstance:getLocalString(1117179) -- "副符文石类型必须与主符文石相同,且等级不小于9级但不能高于主符文等级."
UI.TEXT_227902 = languageManagerInstance:getLocalString(1117180) -- "连接后根据副符文等级,激活主符文的百分比属性."
UI.TEXT_227903 = languageManagerInstance:getLocalString(1117181) -- "连接符文"
UI.TEXT_227904 = languageManagerInstance:getLocalString(1117182) -- "断开连接"
UI.TEXT_227905 = languageManagerInstance:getLocalString(1117183) -- "连接后激活以下属性"
UI.TEXT_227906 = languageManagerInstance:getLocalString(1117184) -- "9级以上符文石可在符文石连接功能处,激活连接属性,解锁符文石百分比属性!"
UI.TEXT_227907 = languageManagerInstance:getLocalString(1117185) -- "取下副符文石会自动与主符文石断开连接,连接属性将不会生效,是否确定取下副符文石?"
UI.TEXT_227908 = languageManagerInstance:getLocalString(1117186) -- "符文连接成功"
UI.TEXT_227909 = languageManagerInstance:getLocalString(1117187) -- "请先断开符文连接"
UI.TEXT_227910 = languageManagerInstance:getLocalString(1117188) -- "符文成功断开连接"
UI.TEXT_227911 = languageManagerInstance:getLocalString(1117189) -- "需要断开符文连接才能被摘除"
UI.TEXT_227912 = languageManagerInstance:getLocalString(1117190) -- "兑换券已锁定，使用前需要解锁该物品"
UI.TEXT_227913 = languageManagerInstance:getLocalString(1117191) -- "摘除宝石,自动断开链接,是否继续?"

-- 符文分解
UI.TEXT_228000 = languageManagerInstance:getLocalString(1117194) -- 拆解符文
UI.TEXT_228001 = languageManagerInstance:getLocalString(1117193) -- 花费金币，可以将一颗10级以上的符文石拆解为5颗同类型次级符文石

-- 兽栏升星优化相关
UI.TEXT_228100 = languageManagerInstance:getLocalString(1117195) -- "升星"
UI.TEXT_228101 = languageManagerInstance:getLocalString(1117196) -- "或"
UI.TEXT_228102 = languageManagerInstance:getLocalString(1117197) -- "消耗资源或者道具提高兽栏星数"
UI.TEXT_228103 = languageManagerInstance:getLocalString(1117198) -- "升星需要%d个%s"
UI.TEXT_228104 = languageManagerInstance:getLocalString(1117199) -- "当前所需材料不足，是否消耗%d个水晶代替缺少的%d个%s"
UI.TEXT_228105 = languageManagerInstance:getLocalString(1117200) -- "和"

--星火活动相关
UI.TEXT_228200 = languageManagerInstance:getLocalString(1117215) -- "星火获取"
UI.TEXT_228201 = languageManagerInstance:getLocalString(1117216) -- "距离星火显现结束:"
UI.TEXT_228202 = languageManagerInstance:getLocalString(1117217) -- "恭喜获得"
UI.TEXT_228203 = languageManagerInstance:getLocalString(1117218) -- "限时奖励"
UI.TEXT_228204 = languageManagerInstance:getLocalString(1117219) -- "增幅"
UI.TEXT_228205 = languageManagerInstance:getLocalString(1117220) -- "增幅等级:"
UI.TEXT_228206 = languageManagerInstance:getLocalString(1117221) -- "(未点亮)"
UI.TEXT_228207 = languageManagerInstance:getLocalString(1117222) -- "星盘属性加成"
UI.TEXT_228208 = languageManagerInstance:getLocalString(1117223) -- "星盘增幅效果"
UI.TEXT_228209 = languageManagerInstance:getLocalString(1117224) -- "点亮星火"
UI.TEXT_228210 = languageManagerInstance:getLocalString(1117225) -- "星火不足，请等待星火显现活动获取"
UI.TEXT_228211 = languageManagerInstance:getLocalString(1117226) -- "星火不足，可以在占星中获得星火，是否前往？"
UI.TEXT_228212 = languageManagerInstance:getLocalString(1117227) -- "金币占星无法获得星火"

--航海优化相关
UI.TEXT_228300 = languageManagerInstance:getLocalString(1117262) -- "剩余补给不足%d，无法驱逐"
--宠物装备镶嵌了宝石后卖出提示
UI.TEXT_228301 = languageManagerInstance:getLocalString(1170333)--"嵌入魂玉的宠物装备无法被出售"

--纪念品
UI.TEXT_228400 = languageManagerInstance:getLocalString(1117422)--"纪念品"
UI.TEXT_228401 = languageManagerInstance:getLocalString(1117423)--"纪念品收集进度:%d/%d"
UI.TEXT_228402 = languageManagerInstance:getLocalString(1117424)--"已激活纪念品:%d/%d"
UI.TEXT_228403 = languageManagerInstance:getLocalString(1117425)--"未获得"
UI.TEXT_228404 = languageManagerInstance:getLocalString(1117426)--"等级:"
UI.TEXT_228405 = languageManagerInstance:getLocalString(1117427)--"获取时间:"
UI.TEXT_228406 = languageManagerInstance:getLocalString(1117428)--"激活效果"
UI.TEXT_228407 = languageManagerInstance:getLocalString(1117429)--"被动加成"
UI.TEXT_228408 = languageManagerInstance:getLocalString(1117430)--"(下一级)"
UI.TEXT_228409 = languageManagerInstance:getLocalString(1117431)--"激活"
UI.TEXT_228410 = languageManagerInstance:getLocalString(1117432)--"升级"
UI.TEXT_228411 = languageManagerInstance:getLocalString(1117433)--"花费"
UI.TEXT_228412 = languageManagerInstance:getLocalString(1117434)--"取消激活"
UI.TEXT_228413 = languageManagerInstance:getLocalString(1117435)--"激活需要消耗一定材料,请选择您的激活时间"
UI.TEXT_228414 = languageManagerInstance:getLocalString(1117436)--"是否取消激活纪念品,取消激活后材料不会返还"
UI.TEXT_228415 = languageManagerInstance:getLocalString(1117437)--"%s不足，无法激活"
UI.TEXT_228416 = languageManagerInstance:getLocalString(1117438)--"已激活纪念品数量已经达到上限"
UI.TEXT_228417 = languageManagerInstance:getLocalString(1117440)--"激活成功"
UI.TEXT_228418 = languageManagerInstance:getLocalString(1117439)--"%s不足，无法升级"
