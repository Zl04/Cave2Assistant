 --[[
     这里处理和 public_define.proto 对应数据的预处理。
 ]]

local ProtobufUtil = require "utils.ProtobufUtil"

PublicDefine = PublicDefine or {}

local ATTR_TYPE_ID_KEY = {}
local DEBUG = false

function iniAttrType()
    for k,v in pairs(PublicDefine.ATTR_TYPE) do
        local id = ProtobufUtil:enum_id("PublicDefine.ATTR_TYPE", k)
        if(id and k) then 
            ATTR_TYPE_ID_KEY[id] = k
            -- 更新自己得数据
            PublicDefine.ATTR_TYPE[k] = id
        end
    end
end

function refreshValue(data,mesName)
    for k,v in pairs(data) do
        local id = ProtobufUtil:enum_id("PublicDefine."..mesName,k)
        data[k] = id
    end
end

function PublicDefine:initLocal()
    local EObjectType = {
        Null = 0;                       -- 无效值 必须是0
        Sprite = 1;                     -- 能添加到场景中的精灵接口
        Mover = 2;                      -- 能移动的精灵
        Fighter = 3;                    -- 能战斗的精灵
        Item = 4;                       -- 抽象道具类
        SpriteDetail = 5;               -- 精灵接口实现

        Hero = 10;                      -- 英雄
        Monster = 11;                   -- 怪物
        Pet	    = 12;                   -- 宠物
        

        FuncItem = 20;                  -- 功能道具        
        Equipment = 21;                 -- 装备           
        Material = 22;                  -- 材料           
        Task = 23;                      -- 任务
        VirtualItem = 24;               -- 虚拟道具，藏宝图碎片、金币、钻石等 
        GemStone = 25;                  -- 宝石
        StarPray = 26;                  -- 星痕
        Skill = 30;                     -- 技能           
        Buff = 31;                      -- 持续状态        
        Effect = 32;                    -- 效果           

        TriggerNPC = 40;                -- 触发类NPC
        Trap = 41;                      -- 陷阱,继承自 触发类NPC
        Target = 42;                    -- 目标
        CollectNPC =43;                 -- 采集类NPC 继承触发类NPC
        Primogem = 53;                  -- 原石

        Max = 99;                       -- 最大枚举值
    }


    local MAIL_REWARD_STATE = {
        MailRewardStat_New = 0;   --未领奖
        MailRewardStat_Rewarded = 1;  --已经领奖
    }

    local SCENE_TYPE = {
        INVALID = 0;
        TOWN = 1;
        CAVE = 2;      
        BOSS = 3; 
        SHOP = 4;
        BLACK_HOUSE = 5;
        TEST_SCENE = 6;
        GUILD = 7;
        SCENE_TYPE_ACTIVITY = 8;    -- 活动场景类型
        TOWN_CAVE = 9;              -- 英雄家园场景
        MANOR = 10;                 -- 庄园场景
        BIGSAILPORT = 11;           -- 大航海港口场景
    }

    -- 大秘境房间类型
    local DUNGEON_ROOM_TYPE = 
    {
        ROOM_RANDOM = 0;
        ROOM_MONSTER = 1;
        ROOM_ELITEMONSTER = 2;
        ROOM_TRIIGER = 3;
        ROOM_SHOP = 4;
        ROOM_POT = 5;
        ROOM_ROCKFALL = 6;
        ROOM_POISONSMOG = 7;
    }

    -- 传送门类型
    local TRANS_DOOR_TYPE =
    {
        INVALID_TRANS_DOOR = 0;
        NEXT_LEVEL = 1;
        CAVE_TO_TOWN = 2;
        ROOM_TO_ROOM = 3;
        GUILD_TO_TOWN = 4;
        TOWN_TO_GUILD = 5;
        BLACK_HOUSE_TO_TOWN = 6;
        TOWNCAVE_TO_TOWN = 7;
        TOWN_TO_TOWNCAVE = 8;
        TOWN_TO_MANOR = 9;
        MANOR_TO_TOWN = 10;
        TOWN_TO_BIGSAILPORT = 11;
        BIGSAILPORT_TO_TOWN = 12;
    }


    local TRIGGER_NPC_TYPE = {
        TRANS_DOOR = 1;
        BOX = 2;
        GOLD_BAG = 3;
        NORMAL_CHAMBER_ENTRANCE = 4;
        MECHANISM_CHAMBER_TRIGGER = 5;
        MECHANISM_CHAMBER_ENTRANCE = 6;
        FUNCTION_NPC = 7;
        RUNE = 8;                           -- 符文
        BOSS_FLOOR_GATE = 9;                -- BOSS层大门
        BOSS_SCENARIO_TRIGGER = 10;         -- BOSS剧情触发器
        FRAGMENT_OF_TREASURE_MAP = 11;      -- 藏宝图碎片
        TRAP = 12;                          -- 陷阱
        DUNGEON_ROOM_TRIGGER = 13;          -- 大秘境房间触发器
        DISAPPEAR_OBSTACLE = 14;            -- 可消失的障碍物
        PATROL_NPC = 15;                    -- 巡逻NPC
        NPC_TYPE_ACTOR = 16;                -- 演员类NPC
        TRANS_POINT = 17;                   -- 传送点
        QUICK_DOWN = 18;                    -- 快速下楼
        COLLECT = 19;                       -- 周年庆活动十字架
        FISH = 20;                         -- 钓鱼
        FRAGMENT_OF_MOLD = 21;              -- 模具NPC
        SAIL_PORT = 22;                     --大航海码头
    }

    local TRANS_POINT_TYPE = {
        TRANS_POINT_SYS_BIRTH = 1;                  -- 系统传送到入口
        TRANS_POINT_SYS_RAND = 2;                   -- 系统随机传送
        TRANS_POINT_ROLE_TRAP = 3;                  -- 玩家陷阱随机传送
        TRANS_POINT_ROLE_END = 4;                   -- 终点类型
    }

    -- BOSS剧情类型
    local BOSS_SCENARIO_TYPE = {
        OPENING = 1;    -- 开场
        ENDING = 2;     -- 收场
    }

    local GOODS_COST_TYPE = {
        GOLD = 1;       -- 黄金 
        GEM = 2;        -- 宝石
        GUILD_MEDAL = 3;-- 工会勋章
        TALENT = 4;     --  天赋石
        EXP = 5;        -- 经验
        GUILD_CONTRIB = 6; -- 公会贡献
        BATTLE_PASS_ICON = 7;--战斗通行证货币
        HORCRUX_COIN = 8;--魂器币
        SAIL_GOLD = 9; --航行币
        SAIL_DIAMOND = 10; --航行钻石
        GEM_BUY = 11; -- 符文洞窟积分币
        STAR_FIRE = 12; --星火
    }

    local HERO_SEX = {
        NOT_SET = 0;    --未设定
        MALE = 1;       -- 男
        FEMALE = 2;     --女
    }

    local SPRITE_STATUS = {
        UNAVALIABLE = 0;
        IDLE = 1;
        MOVE = 2;
        FIGHT = 6;
        IN_SCENE_TRANSITION = 7;
        DEAD = 8;
    }

    local CAVE_MODE = {
        MODE_INVALID = 0;    --
        MODE_NORMAL = 1;     -- 时光之门（普通模式）
        MODE_DUNGEON = 2;    -- 深渊模式
        MODE_STORY = 3;      -- 新手引导模式 
        MODE_HERO = 4;       -- 时光之门（英雄模式）
        MODE_DREAM = 5;      -- 梦境挑战模式
        MODE_WORLD_BOSS = 6; -- 世界Boss  模式
        MODE_GUILD_BOSS = 7;      -- 公会场景
        MODE_DESERT_EYES = 8;   --沙之眼 模式
        MODE_DISTORTED_SPACE = 9;   --扭曲空间
        MODE_ACT = 10;            -- 活动模式
        MODE_PET = 11;            --宠物对战
        MODE_INFERNO = 12;        -- 后扭曲模式
        MODE_GHOST_ABYSS = 13;    -- 幽灵深渊
        MODE_VOID_RIFT = 14;      -- 虚空秘境
        MODE_TRIAL_LAND = 15;            -- 试炼之地
        MODE_VIKING   = 16;       -- 维京时代
        MODE_EVER_WINTER_RIFT = 17;       -- 永冬裂缝
        MODE_TITAN_ROAD = 18;           -- 泰坦之路
        MODE_TITAN_ROAD_HERO = 19;      -- 泰坦之路（英雄）
        MODE_DRIED_SPRING = 20;         -- 干涸之泉
        MODE_TREATURE_HUNT = 21;        -- 洞窟夺宝
        MODE_EXP = 22;                  -- 经验副本
        MODE_CHAOS = 23;                -- 混沌虫洞
        MODE_WORMHOLE = 24;             -- 虫洞深处
        MODE_MAX = 25;                  -- 模式最大值   
    }

    local CAVE_DIFFICULTY = {
        DIFFICULTY_1 = 1;     --难度1
        DIFFICULTY_2 = 2;     --难度2
        DIFFICULTY_3 = 3;     --难度3
        MAX_CAVE_DIFFICULTY = 4;
    }

    -- 游戏模式（单人、组队,公会）
    local GAME_MODE = {
        MODE_SOLO = 1;
        MODE_TEAM = 2;
        MODE_GUILD = 3;
        MODE_ACTIVITY = 4;  --活动副本模式
        MODE_GROUP = 5;     -- 离散群里模式
        MODE_MERCENARY = 6; -- 雇佣模式
        MODE_MANOR = 7;     -- 庄园模式
        MODE_BIGSAILPORT = 8; -- 大航海港口模式
    }

    local ATTR_TYPE ={
        meaningless = 0;

        baseStart = 1;
        roleLV = 2;
        moveSpeed = 3;
        curLVExp = 4;
        curCoin = 5;
        curHp = 6;
        curMp = 7;
        luck = 8;
        enterCaveCoin = 9;  -- 进洞时金币
        boxCanBeUsedNum = 10;    
        warehouseCanBeUsedNum = 11;
        curDiamond = 12;
        refreshDay = 13;
        onceExploreDeadTimes = 14; -- 一次冒险的死亡次数,为复活花费钻石服务
        unlockBagTimes = 15;        -- 解锁背包的次数
        unlockWarehouseTimes = 16;  -- 解锁仓库的次数
        equipScore = 17;           -- 装备战力
        guildMedal = 18;           -- 公会勋章
        guildContrib = 19;         -- 个人公会贡献
        guildID = 20;              -- 所属公会ID
        guildTaskDailyFinishNum = 21; -- 公会任务每日领取数量
        rewardDungeonLevel = 22;    --  待奖励的大秘境关卡记录，组合字段，包含上次大秘境到达的层数和是否击杀BOSS
        achievementPoint = 23;     -- 成就点
        maxDungeonLevelAndMinTimeForSeason = 24;     --  大秘境赛季最大到达的楼层和到达该最大楼层的最短消耗时间的组合值，赛季结束后清零
        rescuedDungeonSurvivorCount = 25;         --  大秘境救助被困NPC数
        firstChargeStat = 26;      --  首充标识（含义PurchaseSystem.FirstChargeStat）
        monthCardDay = 27;         -- 月卡持续天数
        supplyReceiveDay = 28;     -- 补给领取天数
        heroCaveTaskDailyAcceptNum = 29; -- 英雄模式任务每日领取数量
        heroTitle= 30; -- 英雄装备称号
        nextConfineEnterCaveTime = 31;    -- 限制的下次进洞时间(未实名玩家有效)
        onlineTime = 32;                  -- 当日在线时长(每按配置时间刷新)
        joinGuildTime = 33;             -- 加入公会时间 --游戏元年的时间（秒）
        dailyTalentBook = 34;             -- 每日获得领悟之书数量
        dreamChip = 35;                 --  梦境碎片
        weeklyDreamChip = 36;           --  每周累计梦境碎片
        dailyLimitTaskAcceptNum = 37;   -- 每日限制任务每日领取数量
        horcruxCoin = 38;               -- 魂器币
        battlePassCoin =39;             --通行证货币
        loudSpeaker = 40;               --喇叭
        petHpPool = 41;		            -- 宠物血池
        monthSubscriptionEnd = 42;  -- 月卡订阅失效时间
        lifetimeCard = 43;          -- 是否终身卡用户
        lastLifetimeReward = 44;    -- 最近一次领取终身卡每日奖励的时间戳
        monthSubscriptionEndAutoRenew = 45;     -- 月卡订阅是否续订中
        monthSubscriptionClaimDay = 46; -- 月卡订阅领取时间
        baseEnd = 47;
        
        --  baseEnd = 49;

        attrStart = 50;
        hp = 51;
        mp = 52;
        atkMin = 53;
        atkMax = 54;
        atkSpd = 55;
        physicDef = 56;
        magicDef = 57;
        dodge = 58;
        magic = 59;
        atkFire = 60;
        atkWater = 61;
        atkWood = 62;
        atkLight = 63;
        atkDark = 64;
        defFire = 65;
        defWater = 66;
        defWood = 67;
        defLight = 68;
        defDark = 69;
        critical = 70;
        physicPenetrate = 71;
        magicPenetrate = 72;  
        magicAtkMin = 73;
        magicAtkMax = 74;
        block = 75;
        energy = 76;                        --  能量值 by Joeson at 2019/3/1
        anger = 77;                         --  怒气值 by Joeson at 2019/3/1
        horcruxEnergy = 78;                 --魂器能量值
        skillCritical = 79;                 -- 技能暴击率 add by joeson at 2019.8.22
        attrEnd = 80;
        --  attrEnd = 80;

        RateAttrStart = 85;
            --  复合元素类型 start
        cpxFire = 86;
        cpxWater = 87;
        cpxWood = 88;
        cpxLight = 89;
        cpxDark = 90; 
            --  复合元素类型 end
        HPRecoverRate = 91;
        MPRecoverRate = 92;
        CritDamageRate = 93;
        MagicDamageRate = 94;
        MagicReductionRate = 95;
        PhysicDamageRate = 96;
        PhysicReductionRate = 97;
        ElementDamageRate = 98;
        ElementReductionRate = 99;
        FireDamageRate = 100;
        FireReductionRate = 101;
        WaterDamageRate = 102;
        WaterReductionRate = 103;
        WoodDamageRate = 104;
        WoodReductionRate = 105;
        LightDamageRate = 106;
        LightReductionRate = 107;
        DarkDamageRate = 108;
        DarkReductionRate = 109;
        CoinRate = 110;        -- 获取金币比例
        ExpRate = 111;         -- 获取经验比例
        ItemHPRecoverRate = 112;      -- 道具恢复HP率
        ItemMPRecoverRate = 113;
        BeCriticalRate = 114;         -- 被暴击率
        HitRate = 115;                -- 命中率
        strengthenExtraRate = 116; -- 强化额外成功几率（万分比）
        goldenGoodsDiscountRate = 117;-- 金币商品折扣率（万分比）
        GeneralAtkDamageRate = 118;         --  普攻伤害改变比例（万分比）
        GeneralAtkHPRecoverRate = 119;      --  普攻回血比例 (万分比）
        TrapImmuneRate = 120;           -- 陷阱免伤几率 (万分比)
        BeControlReduceProb = 121;      -- 被控制(冰冻，眩晕)减免几率 (万分比)
        RuneHPRecoverRate = 122;      -- 符文恢复HP率(万分比)
        RuneMPRecoverRate = 123;      -- 符文恢复MP率(万分比)
        MushroomCostSec = 124;        -- 变身持续时间延长秒数
        BlackShopDiscountRate = 125;-- 黑店商品折扣率（万分比）
        ForgeDiscountRate = 126;-- 锻造消耗折扣率（万分比）

        RateAttrEnd = 127;

        StatusStart = 131;
        angerStatus = 132;          --  怒气状态 0表示关闭 by Joeson at 2019/3/20
        looks = 133;                --  外形 变形的ID(10001:异鼠,10002 :小石怪, 10003: 火山龟) 0为不变形
        delusion = 134;             --  幻境 DelusionType
        isReviveFree = 135;         --  复活是否免费 0 表示付费 1 表示免费
        isHideHelmet = 136;         --  是否隐藏头盔
        FirstReviveFree = 137;           -- 初次死亡免费
        energyStatus = 138;         --  能量状态 0表示关闭 by Joeson at 2019/3/1
        StatusEnd = 139;           -- 


        --  StatusEnd后的属性不会通知到客户端，仅服务器内部使用-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        LoseHPIncreaseAtkRate = 140;-- 损失生命转换成攻击比例(技能用)
        LoseHPIncreasePhysicDefRate = 141;-- 损失生命转换成防御比例(技能用)
        LoseHPIncreaseCriticalRate = 142;-- 损失生命转换成暴击(技能用)
        FirstEscapeScroll = 143;         -- 初次必出回城卷轴
        GeneralAtkMulti = 144;              --  本次普攻伤害倍数，计算完后消耗
        BossAIFlag = 154;                   -- 怪物组件标记


        MarblesFeverHoodle = 201;                       -- 反斗乐：弹珠
        MarblesFeverLuckyPoint = 202;                   -- 反斗乐：幸运值
        MarblesFeverDrawCount = 203;                    -- 反斗乐：今日抽取次数
        GhostAbyssUsedCount = 204;                      -- 幽灵深渊：已挑战次数
        StarPrayDailyUsedCount = 205;                      --占星当日使用次数
        SailGold = 206;                                 -- 庄园：远航金币
        SailDiamond = 207;                              -- 庄园：远航钻石
        LimitedMarblesFeverLuckyPoint = 208;            -- 限时反斗乐：幸运值
        LimitedMarblesFeverDrawCount = 209;             -- 限时反斗乐：今日抽取次数
        MaxFishingTime = 210;                           -- 每日钓鱼额外次数
        StarCardUpgradeSpeedPercent = 211;              -- 提升星辰卡升级速度百分比
        AnniversaryCoin = 212;                          -- 提升星辰卡升级速度百分比
        extraLooks = 213;                               -- 另外一个外形 :(
        GemBoughtCredit = 214;                          -- 符文洞窟积分币
        CrystalTreasureHuntDailyDrawCount = 215;        -- 水晶夺宝：今日抽取次数
        CrystalTreasureHuntTotalDrawCount = 216;        -- 水晶夺宝：累计抽取次数
        CrystalTreasureHuntLuckDraw       = 217;        -- 水晶夺宝：是否内圈抽奖
        CrystalTreasureHuntStageID        = 218;        -- 水晶夺宝 阶段奖励最大值
        TreatureHuntOpenItem              = 219;        -- 探宝钥匙
        DungeonExpFightNum                = 220;        -- 经验副本免费战斗次数
        Chaosfightnum                     = 221;        -- 混沌虫洞精英挑战次数
        Chaosfightextranum                = 222;        -- 混沌虫洞精英额外挑战次数
        Inscription                       = 223;        -- 铭文
        AnniversaryCoin2                   = 224;        -- 周年币2
        DailyGlyphComposeNum              = 225;        -- 铸造次数
        LimitedMarblesFeverLuckyPoint2    = 226;        -- 限时反斗乐：幸运值2
        WromholeWeekVirtualNum            = 228;        -- 浑沌虫洞周积累铭文个数
        UseStarPlate = 229;                             -- 当前使用星盘id
        UnlockStarPlateInfo = 230;                          -- 已解锁星盘(id左移)
        PrimogeDebris = 231;                            -- 原石碎片
        ExpCaveTimes = 232;                             -- 经验副本增加额外次数道具
        PrimogeDebris2 = 233;                           -- 原石碎片2
        StarFire       = 234;                           -- 星火
        CurVersionStarFire = 235;                       -- 当前活动星火
        PrimogeDebrisGreen = 236;                       --翠绿原石碎片
        SouvenirLevelUp = 237;                          --纪念品升级材料
        SouvenirLevelUp2 = 238;                         --纪念品升级材料2
        TrialLevelUp = 239;                             --试炼升级材料
        ExtraAttrEnd = 240;
    }

    local PetTalentType = {
        TLife      = 0;     --生命资质
        TPhysicAtk = 1;     --物攻资质
        TMagicAtk  = 2;     --法攻资质
        TPhysicDef = 3;     --物防资质
        TMagicDef  = 4;     --法防资质
        TElement   = 5;     --元素资质
        TResist    = 6;     --抗性资质
    }

    local PetType = {
        ATK = 1; --进攻型
        DEF = 2; --防御型
        BALENCE  = 3; --均衡型
        SPECIAL  = 4; --特殊型
    }
    
    local DelusionType = {
        DelusionType_None = 0;
        DelusionType_Rich = 1;  --发财
        DelusionType_Insane = 2; --疯狂
        DelusionType_Mental = 3; -- 精神错乱
    }

    --掉落的来源原因
    local DROP_REASON_TYPE = {
        DROP_REASON_NO_REASON = 1;
        DROP_REASON_MONSTER = 2;  --怪物掉落
        DROP_REASON_BOX = 3;      --宝箱掉落  包含(木箱子woodbox/金箱子goldbox/骨堆bone/罐子jar/金币袋bag)
        DROP_REASON_BLACK_MARKET = 4;  --黑市商人获取
        DROP_REASON_DIG = 5;        --挖墙掉落
        DROP_REASON_TEST_TOOLS = 6;  --测试工具
        DROP_REASON_PICK = 7; --玩家拾取
        DROP_REASON_TREASUREMAP =8;-- 藏宝图
        DROP_REASON_TASK = 9; --任务
        DROP_REASON_DECOMPOSE = 10;--分解
        DROP_REASON_FORGE = 11;--锻造
        DROP_REASON_LUCKYWHEEL = 12;                --转盘抽奖
        DROP_REASON_DUNGEON_REWARD = 13;    --大秘境完成的奖励
        DROP_REASON_SKILLEFFECT = 14;    --技能效果获得
        DROP_REASON_GOLDENPOINT = 15;    --点金
        DROP_REASON_INITNEWPLAYER = 16;    --初始化新角色
        DROP_REASON_CAVE_MARKET = 17;      -- 洞穴商人获得
        DROP_REASON_DUNGEON_SEASON_REWARD = 18; --大秘境赛季奖励
        DROP_REASON_ACHIEVEMENT_REWARD = 19;    --成就奖励
        DROP_REASON_MAIL = 20;                  -- 邮件获得
        DROP_REASON_ACTIVITY = 21;              -- 活动获得
        DROP_REASON_ACTIVITY_EXTRADROP = 22;    -- 活动额外掉落获得
        DROP_REASON_PURCHASE = 24;    -- 充值获得
        DROP_REASON_GEMSTONECOMPOSE = 25;  --宝石合成
        DROP_REASON_GEMSTONETRANSFORM = 26; --宝石转化
        DROP_REASON_GEMSTONEPICK = 27; --宝石摘取
        DROP_REASON_BUY = 28; --宝石购买
        DROP_REASON_FIRST_CHARGE = 29; --首次充值奖励
        DROP_REASON_GIFT = 30;         --礼物发奖
        DROP_REASON_RANDOMSHOP = 31;   --随机商店
        DROP_REASON_CHOOSEBAG = 32;   --随机礼包
        DROP_REASON_GEM_FACTORY_OUTPUT = 33;   --符文矿石  产出
        DROP_REASON_ACTIVITY_BOSS = 34;   --活动Boss 产出
        DROP_REASON_REMODELRETURN = 35;    --改造返还
        DROP_REASON_ANSWER = 36;    --答题
        DROP_REASON_DREAM = 37;     -- 梦境掉落
        DROP_REASON_UPGRADEDATA = 38;   --版本升级导致的
        DROP_REASON_EQUIP_CONVERT = 39;         --装备转化
        DROP_REASON_DREAMSHOP = 40;          --梦境商店
        DROP_REASON_TARGETREWARD = 41;          --目标奖励
        DROP_REASON_STARPRAY_DRAW = 42;         -- 星痕抽奖
        DROP_REASION_EXPEDITION = 43;            -- 探险 内挂
        DROP_REASION_EXPEDITION_QUICK = 44;            --探险 内挂 快速
        DROP_REASON_GUILD_BOX = 45;                 --工会宝箱
        DROP_REASON_WORLD_BOSS = 46;                --世界Boss 结算
        DROP_REASON_LUCKYLOTTERY = 47;                --幸运转盘抽奖
        DROP_REASON_GUILDSHOP = 48;                --公会商店
        DROP_REASON_GUILDBOSS = 49;             --工会Boss
        DROP_REASON_GUILDBOSS = 50;                 -- 工会Boss
        DROP_REASON_GUILDBOSS_LVUP = 51;            -- 工会BOSS升级
        DROP_REASON_DISTORTEDSPACE_EVENT = 52;  -- 扭曲空间开门事件
        DROP_REASON_EQUIP_SET_CHANGE = 53;          -- 套装转换
        DROP_REASION_MAZE = 54;           -- 洞窟迷阵
        DROP_REASON_BATTLEPASS = 55;            -- 通行证
        DROP_REASON_TUTOR = 56;            --  -- 导师系统
        DROP_REASON_FIRSTPASSREWARD = 57;             -- -- 首通奖励
        DROP_REASON_GUILD_WISH		= 58;			 --  -- 公会许愿池
        DROP_REASON_GREEDY = 59;             -- -- 贪婪抉择
        DROP_REASON_RAT = 60;            -- 异鼠必须死
        DROP_REASON_BIGCRACK = 61;      -- 大裂缝
        DROP_REASON_PET_REFINE = 62;    -- 宠物炼化
        DROP_REASON_FAST_BUY = 63;      -- 快速购买
        DROP_REASON_FESTIVAL_SIGN = 64;      -- 节日签到
        DROP_REASON_GUILD_AUCTION_ITEM = 65;        -- 公会拍卖品
        DROP_REASON_GUILD_AUCTION_REFUND = 66;      -- 公会拍卖金退还
        DROP_REASON_GUILD_AUCTION_PROFIT = 67;      -- 公会拍卖收益
        DROP_REASON_GUILDRANDOMSHOP = 68; --公会随机商店
        DROP_REASON_GUILDDIAMONDSHOP = 69; --公会水晶商店
        DROP_REASON_RANDOMBAG = 70;    -- 随机礼包
        DROP_REASON_DREAMVAULT = 71;   -- 梦境宝库
        DROP_REASON_PETTREASURE = 72;  -- 宠物宝藏收集
        DROP_REASON_EXCHANGESHOP = 73;  -- 兑换商店
        DROP_REASON_HULU = 74;         -- 葫芦娃掉落
        DROP_REASON_PUZZLE = 75;         -- 翻牌
        DROP_REASON_DEEPLINK = 76;      -- DeepLink
        DROP_REASON_DISTORTEDSPACE_SWEEP = 77;          -- 扭曲空间扫荡
        DROP_REASON_LEVELFUND = 78;                     -- 成长基金
        DROP_REASON_TARGETGROUP = 79;
        DROP_REASON_LOSTREALM = 80;                     -- 遗落迷境
}


    -- 删除物品的原因,方便打点记录
    local DELETE_GOODS_REASON_TYPE = {
        DELETE_GOODS_REASON_USE  = 1;  --使用
        DELETE_GOODS_REASON_GOLDENPOINT  = 2;--点金
        DELETE_GOODS_REASON_DESTROY  = 3;--摧毁
        DELETE_GOODS_REASON_SELL  = 4; --卖出
        DELETE_GOODS_REASON_STRENGTHEN  = 5; --强化
        DELETE_GOODS_REASON_DECOMPOSE  = 6; --分解
        DELETE_GOODS_REASON_FORGE  = 7; --锻造
        DELETE_GOODS_REASON_LUCKYWHEEL  = 8; --幸运转盘
        DELETE_GOODS_REASON_SUCCESS_RETURN_TOWN  = 9; --成功回城带出规则
        DELETE_GOODS_REASON_FULLBAG  = 10; --背包满的丢弃(倒计时结束或者玩家丢弃)
        DELETE_GOODS_REASON_RESET_SKILL  = 11; --重置技能
        DELETE_GOODS_REASON_ENTER_DUNGEON  = 12; --进大秘境消耗钥匙 
        DELETE_GOODS_REASON_ENCHANT  = 13;  --附魔
    }


    local ATTR_CHANGE_REASON_TYPE = {
        -- NOTYPE = 0;
        -- NORMAL = 1; --普通原因
        
        -- DAMAGE_TRUE = 10; --真实伤害
        -- DAMAGE_PHYSICAL = 11; --物理伤害
        -- DAMAGE_MAGIC = 12; --魔法伤害
        -- DAMAGE_ELEMENTAL = 13; --元素伤害
        -- DAMAGE_DIRECTSUBTRACTION = 14; --直接扣除生命伤害

        -- USE_ITEM = 20; --使用道具
        -- RESTORE = 21;--主动恢复
        -- RESTORE_AFTER_ATTACK = 22; --攻击后恢复
        -- RESTORE_AFTER_BATTLE = 23; --战斗结束后恢复

        -- DROP_MONSTER = 30;  --怪物掉落
        -- DROP_BOX = 31;      --宝箱掉落
        -- EQUIP_EQUIPMENT = 32; --装备穿戴
        -- LEVEL_UP = 33;

        -- EXCHANGE = 40;  -- 交易

        NOTYPE = 0;
        NORMAL = 1; --普通原因
        REVIVE = 2; --复活
        GM = 3;             -- GM改变
        DIG = 4;    --挖墙
        DAMAGE_TRUE = 10; --真实伤害
        DAMAGE_PHYSICAL = 11; --物理伤害
        DAMAGE_MAGIC = 12; --魔法伤害
        DAMAGE_ELEMENTAL = 13; --元素伤害
        DAMAGE_DIRECTSUBTRACTION = 14; --直接扣除生命伤害

        RESET_ATTR = 19; --重置属性,比如死亡回城和成功回城 HP和MP等都需要恢复
        USE_ITEM = 20; --使用道具
        RESTORE = 21;--主动恢复
        RESTORE_AFTER_ATTACK = 22; --攻击后恢复
        RESTORE_AFTER_BATTLE = 23; --战斗结束后恢复
        USE_SKILL = 24;             -- 使用技能
        USE_GENERAL_ATTACK = 25;    -- 使用普通攻击

        DROP_MONSTER = 30;  --怪物掉落
        DROP_BOX = 31;      --宝箱掉落
        EQUIP_EQUIPMENT = 32; --装备穿戴
        LEVEL_UP = 33;
        TASK_REWARD = 34;            --任务奖励
        TEST_TOOLS = 35;   --测试工具修改
        EXCHANGE = 40;  -- 交易
        EQUIP_STRENGTHEN = 41; --装备强化
        EQUIP_ROMODEL = 42;    --装备改造
        BLACK_MARKET_EXCHANGE = 43; --黑市交易
        TREASUREMAP = 44; --藏宝图
        EQUIP_FORGE = 45;-- 装备锻造
        FACE_LIFT = 46; --捏脸
        UNLOCK_BAG_SPACE = 47;--解锁背包

        UNLOCK_WAREHOUSE_SPACE = 48;--解锁仓库
        LUCKYWHEEL = 49; --转盘抽奖
        TRANS_ATTR = 50; --属性转换
        GUILD_CREATION = 51;                --创建公会
        GUILD_ICON_BOUGHT = 52;             --公会图标购买
        GUILD_TECH_CONTRIB = 53;            --贡献公会科技
        ACHIEVEMENT_AWARD = 54;             -- 成就奖励
        EDIT_NICKNAME = 55;
        MANUAL_REFRESH_BLACKMARKET = 56;    -- 手动刷新黑商
        BUY_CAT_FOOD = 57;                      -- 购买猫饭
        ACTIVITY_EXTRADROP = 58;                --额外掉落活动
        PURCHASE = 59;                --内购充值
        BEGINNER_WELFARE = 60;        --新人福利
        GEMSTONEINLAID = 61;        --宝石镶嵌
        GEMSTONEPICK = 62;        --宝石摘取
        GEMSTONEBUY = 63;        --宝石购买   
        FIRSTCHARGE = 64;        --首冲领奖   
        DAILYSUPPLY = 65;        --每日补给
        RANDOMSHOP = 66;   --随机商店
        RANDOMSHOP_REFRESH = 67; --手动刷新随机商店
        MAIL_REWARD = 68; --领取邮件
        GOLDEN_MINE_OUTPUT = 69;     --金矿产出
        GOLDEN_MINE_UPGRADELV = 70;		--金矿升级
        GOLDEN_MINE_COMPLETE_JOB = 71;	--金矿完成任务

        GEM_FACTORY_UPGRADELV = 72;   --符文矿石  完成升级
        TALENTUP = 73;               --天赋
        EXIT_GUILD = 74;             --退出公会
        JOIN_GUILD = 75;             --加入公会
        EQUIP_ILLUSION_BOUGHT = 76;     --装备幻化
        RENAME_GUILDNAME = 77;          -- 工会改名
        REASON_EQUIP_CONVERT = 78;       -- 装备转换
        DREAM_DROP = 79;                -- 梦境掉落
        DREAM_REFRESH = 80;             -- 梦境刷新
        EXTRA_RESTORE = 81;             -- 额外的恢复，如战斗中使用一个技能恢复HP，而又有BUFF监听恢复事件再进行恢复HP，此次恢复HP不能再触发该BUFF的效果，使用REASON来区别之 by Joeson at 2019/3/6
        DREAM_SHOP = 82;             --梦境商店
        DUNGEON_REWARD = 83;               --大秘境奖励
        REASON_EQUIP_RECAST = 84;           -- 装备重铸
        TASK_REFRESH = 85;              --任务刷新
        QUESTIONNAIRE = 86;             --问卷调查


        ALTER_REASON_USE_STAR_CARD = 153;               -- 使用星辰卡道具
    }

    local ATTR_CHANGE_STYLE = {
        NOSTYLE = 0;           
        CRIT = 1;           -- 暴击
        BLOCK = 2;          -- 格挡
        ABSORPTION = 4;     -- 吸收
    }

    -- 效果作用的原因类型
    local EFFECTED_REASON_TYPE = {
        ENOTYPE = 0;
        EDAMAGE_TRUE = 1; --真实伤害
        EDAMAGE_PHYSICAL = 2; --物理伤害
        EDAMAGE_MAGIC = 4; --魔法伤害
        EDAMAGE_ELEMENTAL = 8; --元素伤害
        EDAMAGE_DIRECTSUBTRACTION = 16; --直接扣除生命伤害
    }

    -- 增益减益类型
    local BUFFER_TYPE = {
        BUFFER_TYPE_BUFF = 1;       -- 增益
        BUFFER_TYPE_DEBUFF = 2;     -- 减益
    }

    local Goods = {
        id = 1,
        num = 2
    }

    local GOODS_RARE = {
        RARE_WHITE_1 = 1;
        RARE_BLUE_2 = 2;
        RARE_GOLDEN_3 = 3;
        RARE_DARKGOLDEN_4 = 4;
        RARE_DARKGOLDEN_BORDERS_5 = 5;
        RARE_DARKRED = 6;
        RARE_PLATINUM = 7;
    }

    local  GOODS_TYPE = {
        GOODS_EQUIPMENT = 1;        -- 装备
        GOODS_ITEM = 2;             -- 道具
        GOODS_MATERIAL = 3;         -- 材料
        GOODS_VIRTUALITEM = 4;      -- 虚拟物品
        GOODS_GEM_STONE = 5;        -- 宝石
        GOODS_STAR_PRAY = 6;        -- 星痕
        GOODS_RELIC = 7;            -- 遗物
        GOODS_PET_EQUIPMENT = 8;    -- 宠物装备
        GOODS_EQUIPMENT_CULL_FISH = 9;  -- 排除鱼竿的所有装备
        GOODS_PET_STONE = 10;        -- 宠物装备宝石
        GOODS_TREASURE = 11;        -- 宝物
        GOODS_GLYPH = 12;        -- 装备雕文
    }

    local PACKET_TYPE = {
        PACKET_BAG = 1;          -- 背包
        PACKET_WAREHOUSE = 2;    -- 仓库
        PACKET_EQUIPMENT = 3;    -- 英雄穿戴的装备栏
        PACKET_TEMPORARY = 4;    -- 临时背包(为背包满了服务)
        PACKET_STARPRAY = 5;     -- 星痕背包
        PACKET_STARPRAY_WEAR = 6;--星痕穿戴栏
        PACKET_EXPEDITION_NORMAL = 7;  --普通探险背包
        PACKET_EXPEDITION_QUICK  = 8;  --特殊探险背包
        PACKET_FIXED_BAG = 9;    -- 背包，不回档类型的
        PACKET_PET_BAG = 10;	 -- 宠物背包
        PACKET_RELIC_WEAR = 11;	 -- 遗物穿戴背包
        PACKET_PET_EQUIPMENT = 12;      -- 宠物装备穿戴栏
        PACKET_PET_ADVENTURE = 13;      -- 宠物探险背包
        PACKET_SAIL = 14;               -- 庄园：航行背包
        PACKET_PET_GEMSTONE = 15;          -- 宠物装备宝石背包
        PACKET_GLYPH = 16;          -- 雕文背包
    }

    local PACKET_SUB_TYPE = {
        PACKET_SUB_TYPE_1 = 1;           
        PACKET_SUB_TYPE_2 = 2;     
    }

    local BOX_TYPE = {
        BOX_POT = 1;        -- 陶罐
        BOX_BONE = 2;       -- 骨头堆
        BOX_WOOD = 3;       -- 木宝箱
        BOX_GOLD = 4;       -- 金宝箱
        BOX_SURVIVOR = 5;   -- 大秘境被困者
    }

    local EQUIPMENT_TYPE = {
        Helmet = 1;--头盔
        Chest = 2;--胸甲
        Shoulders = 3;--肩甲
        Gloves = 4;--手套
        Boots = 5;--鞋子
        Amulet = 6;--饰品（项链）
        Ring = 7;--戒指
        Weapon = 8;--武器
        Fish = 9; --渔具
        MAX_EQUIPMENT_TYPE = 10;
    }

    local PET_EQUIPMENT_TYPE = {
        PetWeapon = 1;                  -- 武器
        PetHelmet = 2;                  -- 头盔
        PetChest = 3;                   -- 衣服
        PetAmulet = 4;                  -- 饰品
    }

    local WEAPON_TYPE ={
        NONE = 0;
        SWORD_SHIELD = 1;   --剑盾
        GREAT_SWORD = 2;   --大剑
        MAGIC_STAFF = 3;   --法杖
        -- DUAL_BLADES = 4;  --双刀
        MAX = 4;
    }

    local ITEM_TYPE = {
        RestorePotion = 1;      -- 回复药剂
        IronPickaxe = 2;            -- 铁锹
        ForgetSkillPotion = 3;  -- 遗忘药剂
        Mushroom = 4;         -- 蘑菇
        EscapeScroll = 5;     -- 逃脱卷轴
        OpenMapShadowScroll = 6; --灵视卷轴
        TransferScroll = 7;       -- 传送卷轴
        FlyScroll = 8; -- 漂浮卷轴
        RunScroll = 9;      -- 疾跑卷轴
        MagicScroll = 10;    -- 法术卷轴
        DispelBuff = 11;     -- 驱散道具
        ChooseBag = 12;     -- X选Y道具礼包
        Firecrackers = 13;    -- 鞭炮
        LevelBag = 14;       -- 等级礼包
        ItemFunTrap = 15;          -- 陷阱
        ItemFunMark = 16;          -- 标记
        ItemFunExplore = 17;       -- 探测
        ItemUnlockBag = 18;         -- 解锁背包格子
        ItemUnlockWarehouse = 19;   -- 解锁仓库格子
        PetEgg = 20; --宠物蛋
        PetHPPotion = 21; --宠物回血药剂
        RandomBag = 22;   --真随机礼包
        HuluSkill = 23;   -- 葫芦娃技能
        BackTown = 24; -- 回城特效道具
        UIShape = 25; --部分UI外形
        AddExp = 26; --经验道具
        StarCard = 27; --星辰卡
        TransCard = 28; --变身卡
    }

    local MATERIAL_TYPE = {
        MaterialEnchanting = 1;      -- 附魔材料
        MaterialEquipmentScroll = 2; -- 装备图纸
        MaterialForgetSkill = 3;     -- 洗点需求材料
        MaterialEquipment = 4;       -- 锻造材料
        MaterialLottery = 5;         -- 抽奖券
        MaterialDungeonKey = 6;      -- 秘境钥匙
        MaterialOther = 7;           -- 通用类型的材料，不需要根据类型进行逻辑处理的材料(如刷新英雄特殊事件的材料，直接配置ID供程序使用)
        MaterialPetExp = 8;          --宠物经验丹
        MaterialPetWash = 9;         --宠物洗练丹
        MaterialPetTalent = 10;      --宠物资质丹
        MaterialPetSkill = 11;      --宠物技能书
        MaterialPetRevive = 12;      --宠物复活道具
        MaterialBarter = 13;        --易物台材料
        MaterialReincarnation = 14; --转生
        MaterialTreasure = 15; --宝藏材料
        MaterialPrimogem = 16; -- 原石
    }

    --虚拟道具类型
    local VIRTUAL_ITEM_TYPE = {
        VirtualItemTreasureMapDebris = 1;      -- 藏宝图碎片
        VirtualItemCoin = 2;      -- 金币
        VirtualItemDiamond = 3;   -- 钻石
        VirtualItemExp = 4;       -- 经验
        VirtualItemGuildMedal = 5;-- 公会勋章
        VirtualItemContrib = 6;   -- 个人贡献
        VirtualItemAchievementPoint = 7;   --成就点
        VirtualItemRandomDrop = 8;    --随机掉落包
        VirtualItemTitle = 9;    -- 称号
        VirtualItemEquipIllusion = 10;  --装备幻化ID
        VirtualItemDreamChip = 11;      -- 梦境碎片
        VirtualItemHorcruxCoin = 12;      -- 魂器币
        VirtualItemHeroSchemeCount = 13;            -- 英雄模式次数
        VirtualItemQuestionnaire = 14;              -- 问卷
        VirtualItemGuildBox = 15;                   -- 工会宝箱虚拟道具
        VirtualItemDreamChipNoRanking = 16;         -- 梦境碎片(不计入排行榜)
        VirtualItemBattlePass = 17;                 -- 通行证相关的虚拟道具类型
        VirtualItemBuff = 18;                       -- Buff
        VirtualItemLoudSpeaker = 19;                -- 喇叭
        VirtualItemEffect = 20;                     -- 效果
        VirtualItemDistortedSpaceFightNum = 21;     -- 扭曲空间次数
        VirtualItemFightNum = 22;                   -- 增加次数
        VirtualItemSkill = 23;                      -- 增加技能
        VirtualItemInfernoFightNum = 24;            -- 炼狱精英次数
        VirtualItemInfernoNightmareFightNum = 25;   -- 炼狱噩梦次数
        VirtualItemMarblesFeverHoodle = 26;         -- 反斗乐：弹珠
        VirtualItemMoldMapDebris = 42;              --模具碎片
        VirtualCrystalTreatureHuntInnter = 43;      -- 水晶夺宝:水晶
        VirtualTreatureHuntOpenItem = 44;           -- 探宝钥匙
        VirtualItemBigSailDebris = 45;           -- 大航海行动碎片
        VirtualItem_Chaosfightnum = 47;             --混沌虫洞精英次数
        VirtualItem_PetSkin = 49;                   --宠物皮肤
        VirtualItem_PrimogeDebris = 53;             --原石碎片
        VirtualItem_ExpCaveTimes = 54;                  -- 经验副本增加额外次数道具
        VirtualItem_StarPlate = 55;                 --星盘
        VirtualItem_PrimogeDebris2 = 56;                    --原石碎片2
        VirtualItem_StarFire = 57;                  --星火
        VirtualItem_Souvenir = 58;                 --纪念品
    }

    -- 宝石类型
    local GemStoneType ={
        GemStoneType_Red = 1;
        GemStoneType_Yellow = 2;
        GemStoneType_Blue = 3;
        GemStoneType_Colourful = 4;
    }

    -- 这里和  CONST_DEFINITION 变量对应
    local CONST_DEFINITION = {
        MAP_COORD_COVERT_DISTANCE = 1000;  --地图coord 值转换为距离
        MAP_INVALID_COORD = 65535;    --地图不合法的coord  
        MAP_SIDE_LENGTH_MAX = 110;    --地图最大边长
        PACKET_INVALID_INDEX = 65534;    --无效的背包位置
        PACKET_BOX_MAX_NUM = 85;  --背包最大格数
        PACKET_WAREHOUSE_MAX_NUM = 100;  --仓库最大格数
        SHORTCUT_BAR_NUM = 6;           --快捷栏数量
        MAX_TEAM_NUM = 2;               --组队人数
        MAX_MONSTER_RARE = 2;               --怪物精英等级   
        COUNTDOWN_CANCEL_MATCH = 30000;    --匹配确认的倒计时(毫秒)
        COUNTDOWN_KICK_MEMBER = 10000;     --踢人的倒计时
        COUNTDOWN_ENTER_NEXT_FLOOR = 10000; --下楼投票的倒计时
        GAME_EPOCH_YEAR = 2000;             -- 游戏时间元年 以2000-1-1 0:0:0这一刻做时间起点
        LEAVE_CAVE_TIME = 20000;             --离开洞窟倒计时
        RESURGENCE_TIME = 20000;            --复活时间
        COUNTDOWN_BAG_FULL_MS = 60000;      --背包满清理的倒计时
        
        CAVE_LEVEL_MIN = 1;
        CAVE_LEVEL_MAX = 100;
        BOSS_LEVEL_MIN = 1001;
        BOSS_LEVEL_MAX = 2000;
        SHOP_LEVEL_MIN = 2001;
        SHOP_LEVEL_MAX = 3000;

        SHORTCUT_EQUIP_MAX = 3;         -- 一键换装最大装备套数
        MAX_FRIENDS_NUM = 10;  --好友列表的最大个数

        AGREE_INVITE_JOIN_TEAM_TIME = 15000;  --邀请好友后倒计时
        HERO_MAX_MAIL_NUM = 100;         --角色最大邮件数量
        MAX_STORY_DATA_BYTE = 80;               -- 新手引导数据最大字节数
        GUILD_NOTICE_LENGTH_MAX = 500;      -- 公会公告长度限制
        TEAM_KICK_MEMBER_COUNT_COMMON = 3;          -- 普通洞窟队伍踢人次数
        TEAM_KICK_MEMBER_COUNT_HERO = 3;            -- 英雄模式踢人次数
        TEAM_KICK_MEMBER_COUNT_DUNGEON = 3;         -- 大秘境踢人次数限制
        SPRING_FESTIVAL_MAP_ID = 8001;              -- 新春副本地图ID
        EASTER_MAP_ID = 8002;                       -- 复活节地图ID
        MAX_GEM_FACTORY_EQUIP_NUM = 3;              -- 传输的最大材料个数
        MAZE_MAP_ID = 8101;                         -- 洞窟迷阵
        RAT_MAP_ID = 8102;                       -- 复活节地图ID
        BIG_CRACK_MAP_ID = 8103;                    -- 大裂缝地图ID
        HULU_MAP_ID = 8104;                         -- 葫芦娃起始地图
        PUZZLE_MAP_ID = 8108;                       -- 记忆翻牌地图ID
        LOST_REALM_MAP_ID = 8109;                   -- LostRealm遗落秘境-迷宫大富翁
        HULU_MAP_NUM = 4;                           -- 葫芦娃地图个数
        MAX_ANGER_VALUE = 10000;                    -- 怒气上限值
        MAX_ENERGY_VALUE = 10000;                   -- 能量上限值
        REWARD_DIAMOND_QUESTIONNAIRE = 50;          -- 问卷调查奖励钻石数量
        MAX_STARPRAY_BAG_NUM = 100;                  -- 星痕包裹最大数量
        MAX_STARPRAY_WEAR_NUM = 10;                 -- 星痕穿戴栏最大数量
        LAMP_RUN_SINGLE_TIME = 30;                  -- 单条跑马灯跑完的时间 单位秒
        MAX_PET_STAR_NUMB = 12;                     -- 宠物最大星数
        MAX_PETVERSUS_FIGHT_TIME = 90000;           -- 宠物对战时间（毫秒）
        MAX_PET_GEMSTONE_PACKET_NUM = 500;                -- 宠物装备宝石背包最大数量
    }

    local VALUE_TYPE = {
        Value = 1;  --普通值
        Rate = 2;   --比例属性
    }

    local TEAM_MEMBER_STATUS = {
        MEMBER_STATUS_DEFAULT = 0;
        MEMBER_STATUS_LOGINING = 1;--正在登陆
        MEMBER_STATUS_ONLINE = 2;--在线
        MEMBER_STATUS_OFFLINE = 3;--离线
    }

    local HERO_LOGIN_STATUS = {
        HERO_LOGIN_STATUS_DEFAULT = 0;
        HERO_LOGIN_STATUS_LOGINING = 1;--正在登陆
        HERO_LOGIN_STATUS_ONLINE = 2;--在线
        HERO_LOGIN_STATUS_OFFLINE = 3;--离线
    }

    local MonsterType = {
        InvalidMonstertype = 0;
        Normal = 1;     --普通怪
        LittleBoss = 2; --小boss
        Boss = 3;       --boss
        
    }

    local Camp = {
        None = 0;       -- 无阵营
        Blue = 1;       -- 蓝
        Red = 2;        -- 红
    }

    local MonsterSubType = {
        InvalidMonsterSubtype = 0;
        Trigger = 1; --触发怪
        Treasure = 2; --宝箱怪
        HitRat = 3; --异鼠必须死的怪
    }

    -- 技能目标类型
    local ESkillTargetType = {
        -- 战斗技能
        ESkillTargetType_Self     = 1;
        ESkillTargetType_Friend   = 2;
        ESkillTargetType_Target   = 4;
        -- 非战斗技能
        ESkillTargetType_Box      = 8;
        ESkillTargetType_Ground   = 16;
        ESkillTargetType_Wall     = 32;
        ESkillTargetType_Monster  = 64;
        ESkillTargetType_Master   = 128;               -- 主人
    }

    -- 任务目标类型
    local TaskTargetType ={
        Kill = 1;    --杀怪
        Golden = 2;  --点金
        Talk = 3;    --对话
        Explore = 4; --探索
        Share = 5;   --分享
        Collect = 6; --收集
        Achievement = 7; --成就
        Follow = 8; --关注
        Strengthen = 9; --强化
        Enchant = 10; --附魔
        Bind = 11; --绑定任务
        OpenUI = 12;  -- 打开界面
        StarPrayWear = 13;      -- 星痕镶嵌
        EverWinterPass = 14;    -- 永冬通过x层
        GemWear = 15;       -- 穿戴的装备上镶嵌了y个x级及以上符文
        DungeonPass = 16;   -- 深渊达到x层及以上
        RelicWear = 17;     -- 遗物穿戴中的y个遗物达到x级及以上
        KillMonster = 18;   -- 怪物	在x里击败y个怪物
    }

    local TaskType = {
        Plot = 2;  --剧情任务
        Daily = 3; --日常任务
        Guild = 4; --公会任务
        CaveHero = 5;--英雄模式任务
        Cycle  = 6;  -- 环任务
        LimitDaily  = 7;--限量日常任务
        DistortedSpace  = 8;--扭曲空间个人任务
        Inferno  = 9;       -- 深红炼狱个人任务
        VoidRift = 10;      -- 虚空秘境
        Viking  = 11;       -- 维京时代
        EverWinterRift = 12;  -- 永冬裂缝
        BigSailPort = 13;  --大航海港口任务(单独的任务规则,只是供客户端使用，服务器不会用到)
        Chaos = 14;  -- 混沌虫洞
        Wormhole = 15;              -- 虫洞深处
    }

    -- 目标系统类型
    local TargetType = {
        TargetType_Login = 1;--登录
        TargetType_MaxPoint = 2;--最大层数
        TargetType_BlackMargetCost = 3;--黑市消费
        TargetType_HeroLv = 4;--角色等级
        TargetType_StrengthLv = 5;--装备强化等级
        TargetType_EquipScore = 6;--装备星级
        TargetType_HomeLv = 7;--家园等级(TargetHomeLvType)
        TargetType_MonsterKill = 8;--怪物击杀
        TargetType_CoinCost = 9;--货币消耗(GOODS_COST_TYPE)
        TargetType_JoinGuild = 10;--加入公会
        TargetType_FriendNum = 11;--好友数量
        TargetType_EquipRare = 12;--装备品质
        TargetType_BoxNum = 13;--背包格子（PACKET_TYPE）
        TargetType_Function = 14;--功能操作(FUNCTION_TYPE)
        TargetType_UpgradeHorcrux = 15;         -- 指定魂器提升到指定等级 *
        TargetType_EnterCave = 16;              -- 进入洞窟 *
        TargetType_CombinePetFragments = 17;    -- 宠物神器合成次数 *
        TargetType_ExploreExpedition = 18;      -- 快速探险次数 *
        TargetType_RebornPet = 19;              -- 宠物重生操作次数 *
        TargetType_HeroEquipScore = 20;         -- 英雄装备星级 *
        TargetType_GuildWishCount = 21;         -- 公会许愿次数 *
        TargetType_EquipmentLevel = 22;         -- 装备等级 *
        TargetType_UnlockHorcrux = 23;          -- 解锁指定魂器 *
        TargetType_PetLevel = 24;               -- 指定宠物到达等级 *
        TargetType_PetStar = 25;                -- 指定宠物到达星级 *
        TargetType_OpenPetEgg = 26;             -- 打开宠物晶核 *
        TargetType_DefeatWorldBoss = 27;        -- 击败世界Boss *
        TargetType_SignIn = 28;                 -- 签到
        TargetType_Special = 99;--特供
        TargetType_FirstRecharge = 100;--首充跳转
    }

    local TaskStatus = {
        TaskStatus_Normal = 0;     -- 普通状态
        TaskStatus_IsFinish = 1;   -- 完成
        TaskStatus_IsReceived = 2; --已经领取
    }

    local DisableSituation = {
        InBattleStatus = 1;                 -- 战斗中
        NotInBattleStatus = 2;              -- 非战斗中
        InTown = 4;                         -- 城镇中
        InCaveNormal = 8;                   -- 洞内普通层
        InCaveShopFloor = 16;               -- 洞内商店层
        InCaveBossFloor = 32;               -- 洞内BOSS层
        InChamber = 64;                     -- 密室中
        InDungeon = 128;                    -- 大秘境
        InGuild = 256;                      -- 公会
        InDream = 512;                      -- 梦境场景
        InActivity = 1024;                  -- 活动场景(世界BOSS、后续扩展的其他活动副本优先考虑追加到该类型中)
        InGuildBoss = 2048;                 -- 工会boss
    }

    -- 技能使用条件，每种类型占一位，可按位组合
    local SkillUseCondition = {
        NoCondition = 0;
        HasBlocked = 1;         --格挡
        HasDodged = 2;          --闪避
        HasSkillCrited = 4;     --技能已暴击
        HasGeneralAtkCrited = 8;   -- 普通攻击已暴击
        AngerFull = 16;        -- 怒气值满
    }

    -- 技能相关标机，每种类型占一位，可按位组合
    local SkillRelatedFlag = {
        NoFlag = 0;
        NoCost = 1;                 -- 下一技能无消耗
        NoSpellTime = 2;            -- 下一技能瞬发
        GeneralAtkMustCrit = 4;     -- 下一次普通必定暴击
        Blocked = 8;                -- 已格挡
        Dodged = 16;                -- 已闪避
        SkillCrited = 32;           -- 技能已暴击
        GeneralAtkCrited = 64;      -- 普通攻击已暴击
        GhostSwordsmanStatus = 128; -- 鬼剑士状态
    }

    -- 战斗中的功能标记 每种类型占一位，可按位组合
    local FunctionFlag = {
        FunctionFlag_No = 0;               -- 无任何标记
        FunctionFlag_Parrying = 1;         -- 招架标记
        FunctionFlag_Silence = 2;          -- 沉默标记
        FunctionFlag_Seal = 4;             -- 封印标记
        FunctionFlag_Frozen = 8;           -- 冻结标记
        FunctionFlag_Transforming = 16;    -- 变身中标记
        FunctionFlag_Blind = 32;           -- 致盲
        FunctionFlag_Reverse = 64;         -- 迷惑
        FunctionFlag_Stun = 128;           -- 击晕
        FunctionFlag_NoneDebuff = 256;     -- 无法添加debuff
        FunctionFlag_NOUSEITEM = 512;      -- 无法使用物品
        FunctionFlag_Constraint = 1024;    -- 束缚状态标记
        FunctionFlag_Charm = 2048;         -- 魅惑标记
    }

    local RankType = {
        RankType_EquipMent = 1;      -- 装备榜
        RankType_Achievement = 2;    -- 成就榜
        RankType_Guild = 3;          -- 公会榜
        RankType_Dungeon = 4;        -- 大秘境
        RankType_Dream = 5;          -- 梦境榜
        RankType_Mentor = 6;         -- 导师榜
        RANKTYPE_BIGSAIL_OUTPUT = 7;         -- 大航海工会产出棒
        RANKTYPE_BIGSAIL_BOSS_DAMAGE = 8;    -- 大航海boss伤害
    }

    local GreedyEvent = {
        GreedyEvent_Down = 1;       ---- 下楼
        GreedyEvent_Return = 2;     ---- 回城
        GreedyEvent_Special = 3;    ---- 特殊回城
    }

    local GuildTitle = {
        GuildTitle_Leader = 1;      -- 会长
        GuildTitle_CoLeader = 3;    -- 管理
        GuildTitle_ViceLeader = 2;  -- 副会长
        GuildTitle_Member = 4;      -- 成员
    }

    local SkillVariationAffectType = {
        SkillVariationAffect_All = 0;   --对所有ID生效
        SkillVariationAffect_Search = 1; --对某个searchID技能生效
        SkillVariationAffect_Type = 2;  --对某类技能生效
    }

    local FixedItemIDs = {
        FixedItemIDs_UnlockBagItem = 20180010;
    }

    local SkillLvChangeType = {
        SkillLvChangeType_GroupID = 1; --对某个groupID技能生效
        SkillLvChangeType_WeaponType = 2;  --对某类技能生效
    }

    -- 公会拍卖行拍卖状态
    local GuildAuctionState =
    {
        GuildAuctionState_Initiator = 0;       -- 初始化阶段
        GuildAuctionState_StockUp = 1;         -- 进货阶段
        GuildAuctionState_Preparation = 2;     -- 准备阶段
        GuildAuctionState_WarmUp = 3;          -- 预热（通知）阶段
        GuildAuctionState_UnderAuction = 4;    -- 拍卖阶段
        GuildAuctionState_CutOff = 5;          -- 结算阶段
        GuildAuctionState_Closed = 6;          -- 关闭阶段
    }

    --xml 标签
    local ContentTagType = {
        font  = 1;
        i     = 2;
        b     = 3;
        del   = 4;
        u     = 5;
        small = 6;
        big   = 7;
        img   = 8;
        a     = 9;
        br    = 10;
        click = 11;
    }

    local ContentTagTypeKey = {
        font  = "font";
        i     = "i";
        b     = "b";
        del   = "del";
        u     = "u";
        small = "small";
        big   = "big";
        img   = "img";
        a     = "a";
        br    = "br";
        click = "click";
    }
    local VERSION_PLATFORM = {         --平台编号
        VERSION_PLATFORM_IOS = 1;      --IOS
        VERSION_PLATFORM_ANDROID = 2;  --安卓
        --...H5, WIN
    }


    local VERSION_TARGET = {--版本编号
        VERSION_TARGET_DEV = 0,
        VERSION_TARGET_GLOBAL = 1;  
        VERSION_TARGET_CN = 2;  
        VERSION_TARGET_CN_PRE = 3;
        VERSION_TARGET_QQ_HALL = 4;  
        VERSION_TARGET_QOOAPP = 5;
        VERSION_TARGET_QUICK = 6;
        --...东南亚版本,北美版本,越狱版本
    }
    -- 区(域)编号具体含义根据target变化,比如CN包下 1 代表默认的服务器(暂时也只有一个) GLOBAL代表美服
    local VERSION_ZONE = {
        VERSION_ZONE_REVIEW = 0;  --审核服务器
        VERSION_ZONE_US = 1;   --美服
        VERSION_ZONE_EUR = 2;  --欧服
        VERSION_ZONE_SA = 3;   --东南亚服
        VERSION_ZONE_JK = 4;   --日韩服
        --...区,为同个版本不同分区准备(比如东南亚服,美服,欧服,日韩服等)
    }
    --/渠道编号(决定客户端)
    local VERSION_CHANNEL = {
        VERSION_CHANNEL_DEV = 1,       --母包或者开发占位符
        VERSION_CHANNEL_APPSTORE = 2;  --苹果商店
        VERSION_CHANNEL_GOOGLEPLAY = 3;--GOOGLEPLAY
        VERSION_CHANNEL_YYB = 4;       --应用宝
        VERSION_CHANNEL_XINYUE = 5;    --腾讯心悦
        VERSION_CHANNEL_360 = 6;       --360
        VERSION_CHANNEL_BAIDU = 7;     --百度
        VERSION_CHANNEL_LEITING = 8,     --雷霆安卓官方
        VERSION_CHANNEL_UC = 9;             --UC
        VERSION_CHANNEL_DOWNJOY = 10;       --当乐
        VERSION_CHANNEL_XIAOMI = 11;        --小米
        VERSION_CHANNEL_WANDOUJIA = 12;     -- 豌豆荚
        VERSION_CHANNEL_ANZHI = 13;         --安智
        VERSION_CHANNEL_LENOVO = 14;        --联想
        VERSION_CHANNEL_OPPO = 15;          --OPPO
        VERSION_CHANNEL_GIONEE = 16;        --金立(网游版本)
        VERSION_CHANNEL_HUAWEI = 17;        --华为（国内）
        VERSION_CHANNEL_COOLPAD = 18;       --酷派
        VERSION_CHANNEL_VIVO   = 19;        --VIVO
        VERSION_CHANNEL_4399 = 20;          --4399
        VERSION_CHANNEL_MUZHIWAN  = 21;     --拇指玩
        VERSION_CHANNEL_MEIZU   = 22;       --魅族
        VERSION_CHANNEL_MIGU = 23;          --咪咕
        VERSION_CHANNEL_GUOPAN = 24;        --果盘
        VERSION_CHANNEL_YIWAN = 25;         --益玩
        VERSION_CHANNEL_LINYOU = 26;        --麟游
        VERSION_CHANNEL_DOUYU = 27;     --斗鱼
        VERSION_CHANNEL_YY = 28;            --yy
        VERSION_CHANNEL_MANGUO = 29;    --芒果
        VERSION_CHANNEL_IAPPAY = 30;    --爱贝
        VERSION_CHANNEL_WOW = 31;       --小沃
        VERSION_CHANNEL_YIDONGMM =32;   --移动MM
        VERSION_CHANNEL_YAODIAN = 33;   --遥点
        VERSION_CHANNEL_DIANHUN = 34;   --电魂
        VERSION_CHANNEL_YOUXIMAO = 35;  -- 游戏猫
        VERSION_CHANNEL_IQIYI = 36;     --爱奇艺
        VERSION_CHANNEL_SOUGOU = 37;    --搜狗
        VERSION_CHANNEL_SAMSUNG = 38;       --三星
        VERSION_CHANNEL_LESHI = 39;     --乐视
        VERSION_CHANNEL_KUAIFA = 40;    --快发
        VERSION_CHANNEL_SMARTISAN = 41;     --锤子
        VERSION_CHANNEL_NUBIA = 42;     --努比亚
        VERSION_CHANNEL_BILIBILI = 43;      --比利比利
        VERSION_CHANNEL_CATAPPULT = 44;
        VERSION_CHANNEL_AMAZON = 45;     --亚马逊渠道
        VERSION_CHANNEL_ONESTORE = 46;   --韩国onestore
        VERSION_CHANNEL_HUAWEI_GLOBAL = 47;   --华为（海外）
        VERSION_CHANNEL_RONGYAO = 48;   --荣耀
        VERSION_CHANNEL_DOUYIN = 1008; --抖音
        VERSION_CHANNEL_QOOAPP = 1003;   --qooapp
        VERSION_CHANNEL_HAOYOU = 1011;   --好游快爆
        VERSION_CHANNEL_XIAOQICHANGWEI = 1015;   --小七长尾
        VERSION_CHANNEL_QUICK = 1016;   --quick
        VERSION_CHANNEL_UNKNOWN = 99999; -- 未知
        --...
    }
    --账号编号
    local VERSION_ACCOUNT = {
        VERSION_ACCOUNT_GUEST = 1;     --游客
        VERSION_ACCOUNT_GAMECENTER = 2;--GAMECENTER
        VERSION_ACCOUNT_GOOGLEPLAY = 3;--GOOGLEPLAY
        VERSION_ACCOUNT_FB = 4;        --FACEBOOK
        VERSION_ACCOUNT_LEITING = 5;   --雷霆
        VERSION_ACCOUNT_360 = 6;       --360
        VERSION_ACCOUNT_BAIDU = 7;     --百度
        VERSION_ACCOUNT_WX = 8;        --微信
        VERSION_ACCOUNT_UC = 9;             --UC
        VERSION_ACCOUNT_DOWNJOY = 10;       --当乐
        VERSION_ACCOUNT_XIAOMI = 11;        --小米
        VERSION_ACCOUNT_WANDOUJIA = 12;     -- 豌豆荚
        VERSION_ACCOUNT_ANZHI = 13;         --安智
        VERSION_ACCOUNT_LENOVO = 14;        --联想
        VERSION_ACCOUNT_OPPO = 15;          --OPPO
        VERSION_ACCOUNT_GIONEE = 16;        --金立(网游版本)
        VERSION_ACCOUNT_HUAWEI = 17;        --华为
        VERSION_ACCOUNT_COOLPAD = 18;       --酷派
        VERSION_ACCOUNT_VIVO   = 19;        --VIVO
        VERSION_ACCOUNT_4399 = 20;          --4399
        VERSION_ACCOUNT_MUZHIWAN  = 21;     --拇指玩
        VERSION_ACCOUNT_MEIZU   = 22;       --魅族
        VERSION_ACCOUNT_MIGU = 23;          --咪咕
        VERSION_ACCOUNT_GUOPAN = 24;        --果盘
        VERSION_ACCOUNT_YIWAN = 25;         --益玩
        VERSION_ACCOUNT_LINYOU = 26;        --麟游
        VERSION_ACCOUNT_DOUYU = 27;     --斗鱼
        VERSION_ACCOUNT_YY = 28;            --yy
        VERSION_ACCOUNT_MANGUO = 29;    --芒果
        VERSION_ACCOUNT_IAPPAY = 30;    --爱贝
        VERSION_ACCOUNT_WOW = 31;       --小沃
        VERSION_ACCOUNT_YIDONGMM =32;   --移动MM
        VERSION_ACCOUNT_YAODIAN = 33;   --遥点
        VERSION_ACCOUNT_DIANHUN = 34;   --电魂
        VERSION_ACCOUNT_YOUXIMAO = 35;  -- 游戏猫
        VERSION_ACCOUNT_IQIYI = 36;     --爱奇艺
        VERSION_ACCOUNT_SOUGOU = 37;    --搜狗
        VERSION_ACCOUNT_SAMSUNG = 38;       --三星
        VERSION_ACCOUNT_LESHI = 39;     --乐视
        VERSION_ACCOUNT_KUAIFA = 40;    --快发
        VERSION_ACCOUNT_SMARTISAN = 41;     --锤子
        VERSION_ACCOUNT_NUBIA = 42;     --努比亚
        VERSION_ACCOUNT_BILIBILI = 43;      --比利比利
        VERSION_ACCOUNT_QQ = 44;        --QQ
        VERSION_ACCOUNT_APPLE = 102;        --apple
        VERSION_ACCOUNT_QOOAPP = 105;        --QOOAPP
        VERSION_ACCOUNT_QUICK = 106;        --quick

        VERSION_ACCOUNT_UNKNOWN = 99999; -- 未知
        --...
    }
    -- 支付渠道
    local PURCHASE_CHANNEL = {
        IOS_APPSTORE = 1; --ios App Store
        GOOGLEPLAY = 2 -- googleplay
    }
    -- 分享模块
    local SHARE_MODULE = {
        SHARE_MODULE_BATTLE_RESULT = 1, --回城结算
        SHARE_MODULE_SKILL = 2, -- 技能界面
        SHARE_MODULE_CREATE_GUILD = 3, --创建公会
        SHARE_MODULE_PLAYER_LOG = 4, -- 玩家日志(趣味数据)
        SHARE_MODULE_TREASURE = 5, --藏宝图
        SHARE_MODULE_EQUIPMENTS = 6, --装备 + 角色展示界面
        SHARE_MODULE_PET = 7, --宠物属性
        SHARE_MODULE_ACTIVITY = 8, --活动
    }

    -- 分享平台 
    local SHARE_CHANNEL = {
        SHARE_CHANNEL_FB = 1,  --FACEBOOK
        SHARE_CHANNEL_WX = 2,  --微信朋友圈
        SHARE_CHANNEL_WX_SESSION = 3, --微信会话
        SHARE_CHANNEL_QQ = 4,--QQ空间
        SHARE_CHANNEL_QQ_SESSION = 5,--QQ聊天窗口
        SHARE_CHANNEL_TWITTER = 6,--推特
        SHARE_CHANNEL_WEIBO = 7, -- 微博
    }

    -- 分享平台 
    local SHARE_CONTENT_TYPE = {
        TEXT = 1,  --文本
        IMAGE = 2,  --推按
    }
    -- 客户端接入网络方式
    local NetworkMode = {
        WIFI = 1, --WIFI
        WWAN = 2, --WWAN
    }
    local AdultType = {
        AdultType_Adult = 0;            -- 已认证已成年
        AdultType_Under_Age = 1;        -- 已认证未成年 
        AdultType_Unkown = 2;           -- 未认证
    }
        
    -- ui功能打开记录类型
    local FUNCTION_RECORD_TYPE = {
        EQUIPMENT_STRENGTHEN = 1,       -- 装备强化
        EQUIPMENT_REMODEL = 2,          -- 装备改造
        EQUIPMENT_DECOMPOSE = 2,       -- 装备分解
        EQUIPMENT_FORGE = 4,            -- 装备锻造
        GOLD_TOUCH = 5,                 --点金
        CAT_FOOD = 6,                   -- 猫饭
        ENCHANT  = 7,                   -- 附魔
        PET_EQUIPMENT_STRENGTHEN = 8,   -- 宠物装备强化
    }
    --  自定义 超链接 类型
    local TagClickType = {
        NickName  = 1; --玩家角色名字 连接
        ItemName  = 2; --道具名字连接
        InnerHref = 3; --内部超链接
        GuildName = 4; --公会名字
        PetName = 5; --宠物名字
    }

    --  自定义 超链接 类型 和 PB的枚举映射
    local TagClickTypeKey = {
        NickName  = "NickName"; --玩家角色名字 连接
        ItemName  = "ItemName"; --道具名字连接
        InnerHref = "InnerHref"; --内部超链接
        GuildName = "GuildName"; --公会名字
        PetName = "PetName"; --宠物名字
    }

    -- 排行榜界限
    local RankAmbit = 
    {
        RankAmbit_Top = 200, --top榜排名界限
        RankAmbit_Enter = 10000,  --入榜排名界限
    }

    --广告预埋地点(配置表使用)
    local AdsPlaceId = {
        CatFood = 1;  --猫饭
        TurnTableLuckDrop = 2;   --转盘抽奖
        GemLuckDrop = 3;   --符文抽奖
    }

    -- 广告预埋地点(服务器数据使用)
    local AdvertFuncType = {
        AdvertFuncType_CatFood = 0;         --猫饭
        AdvertFuncType_LuckyWheel = 1;      --幸运轮盘
        AdvertFuncType_GemStone_1   = 2;    --符文洞窟 12 hour
        AdvertFuncType_GemStone_2   = 3;    --符文洞窟 23 hour
        AdvertFuncType_GemStone_3   = 4;    --符文洞窟 36 hour
    }

    local UnlockFunctionType = {
        UnlockFunctionType_Guild = 1,      --公会
        UnlockFunctionType_FriendShip = 2, --好友
        UnlockFunctionType_StudySkill = 3, --学习技能
        UnlockFunctionType_Task = 4,       --任务
        UnlockFunctionType_Rangking = 5,   --排行榜
        UnlockFunctionType_Warehouse = 6,  --仓库
        UnlockFunctionType_Strengthen = 7, --装备强化
        UnlockFunctionType_Remodel = 8,    --装备改造
        UnlockFunctionType_Decompose = 9, --装备分解
        UnlockFunctionType_Forge = 10, --装备锻造
        UnlockFunctionType_Luckywheel = 11, --抽奖
        UnlockFunctionType_Catfood = 12, --猫饭
        UnlockFunctionType_Facelift = 13, --捏脸
        UnlockFunctionType_BlackMarket = 14, --黑市
        UnlockFunctionType_Mail = 15, --邮箱
        UnlockFunctionType_Dungeon = 16, --大秘境
        UnlockFunctionType_Pokedex = 17, --图鉴
        UnlockFunctionType_Achievement = 18;-- 成就
        UnlockFunctionType_Cave = 19, --洞窟
        UnlockFunctionType_Activity = 20;-- 运营活动
        UnlockFunctionType_Purchase = 21;-- 内购
        UnlockFunctionType_TreasureMap = 22, --藏宝图
        UnlockFunctionType_Team = 23; --组队
        UnlockFunctionType_GemSlot  = 24; -- 宝石镶嵌
        UnlockFunctionType_GemSynthesis  = 25; --宝石合成
        UnlockFunctionType_GemTransform  = 26; --宝石转换
        UnlockFunctionType_GemShopBuy  = 27; --宝石商店购买
        UnlockFunctionType_HeroCave    = 28;--英雄模式
        UnlockFunctionType_RandomShop = 29;--随机商店
        UnlockFunctionType_GemFactory = 30;     --家园系统中的 宝石工厂
        UnlockFunctionType_GoldenMine = 31;     --家园系统中的 金矿
        UnlockFunctionType_OccupationAdvanced = 32;  -- 技能进阶
        UnlockFunctionType_EquipmentIllusion  = 33;     --装备幻化
        UnlockFunctionType_RoleTalent = 34;     --人物天赋
        UnlockFunctionType_Dream = 35;  -- 梦境试验
        UnlockFunctionType_EquipConvert = 36;    --装备转换
        UnlockFunctionType_EquipRecast = 37;--装备重铸
        UnlockFunctionType_Horcrux = 38;    -- 魂器系统
        UnlockFunctionType_StarPray = 39;    -- 星痕
        UnlockFunctionType_Expedition = 40;    -- 探险队
        UnlockFunctionType_WorldBoss = 41;      -- 世界Boss
        UnlockFunctionType_GuildShop = 42;      -- 公会商店
        UnlockFunctionType_GuildBoss = 43;      -- 工会Boss
        UnlockFunctionType_DesertEye = 44;      -- 沙之眼
        UnlockFunctionType_DistortedSpace = 45; -- 扭曲空间 
        UnlockFunctionType_DailyAction = 46;   --日常活跃度 
        UnlockFunctionType_EquipLevelRemove = 47; --装备等级移除
        UnlockFunctionType_EquipRefine = 48;    -- 装备精炼
        UnlockFunctionType_BattlePass = 49;     -- 通行证
        UnlockFunctionType_EquipSuitTransform = 50; --装备套装转换
        UnlockFunctionType_Apprenticeship = 51;        --师徒系统
        UnlockFunctionType_Festival = 52;       -- 节日活动
        UnlockFunctionType_WorldChat = 53;   --世界聊天 
        UnlockFunctionType_SecondSkill = 54;  -- 二阶技能
        UnlockFunctionType_PrivateGuildShop = 55;  -- 公会个人商店
        UnlockFunctionType_PetTreasureCollection = 56;  --宠物宝藏收集
        UnlockFunctionType_FestivalExchangeShop = 57;  -- 节日活动兑换商店
        UnlockFunctionType_PetRecyclingShop = 58; --宠物回收商店
        UnlockFunctionType_Relic = 59;          --遗物系统
        UnlockFunctionType_LevelFund = 60;                  -- 成长基金
        UnlockFunctionType_TalentShow_Pet = 61;             -- 宠物达人
        UnlockFunctionType_TalentShow_Fashion = 62;         -- 幻化达人
        UnlockFunctionType_AutoFight = 63;-- 自动战斗
        UnlockFunctionType_PetDevelop = 64;                 -- 宠物培养
        UnlockFunctionType_MiraclePrayer = 65;              -- 神迹祈祷
        UnlockFunctionType_Inferno = 66;                    -- 深红炼狱 
        UnlockFunctionType_Mercenary = 67;                  -- 公会佣兵
        UnlockFunctionType_DailyFreeGift = 68;              -- 每日免费礼包
        UnlockFunctionType_PetStrengthen = 69;              -- 宠物装备强化
        UnlockFunctionType_MarblesFever = 70;               -- 反斗大转盘
        UnlockFunctionType_GhostAbyss = 71;                 -- 幽灵深渊
        UnlockFunctionType_PetAdventure = 72;               -- 宠物冒险
        UnlockFunctionType_BossDirect = 73;                 -- 宠物冒险
        UnlockFunctionType_Manor = 74;                      --庄园
        UnlockFunctionType_VoidRift = 75;                   -- 虚空秘境
        UnlockFunctionType_Manor_Suit_Transformation = 76;  -- 庄园套装改造
        UnlockFunctionType_ThirdRankSkill = 77;             -- 三阶技能
        UnlockFunctionType_Enchant = 78;                    -- 附魔
        UnlockFunctionType_Home = 79;                       -- 家园
        UnlockFunctionType_Viking = 80;                     -- 维京时代
        UnlockFunctionType_EverWinterRift = 81;             -- 永冬裂缝
        UnlockFunctionType_PetEquipmentUpgrade = 82;        -- 宠物装备养成
        UnlockFunctionType_IdentifyTreasureItem = 83;       -- 宝物鉴定
        UnlockFunctionType_TitanRoad = 84;                  -- 
        UnlockFunctionType_TitanRoadHero = 85;              -- 
        UnlockFunctionType_DriedSpring = 86;                -- 
        UnlockFunctionType_Reincarnation = 87;              -- 角色转生
        UnlockFunctionType_Mold = 88;                       -- 模具
        UnlockFunctionType_TREATURE_HUNT = 89;              -- 洞窟夺宝
        UnlockFunctionType_NAVIGATION_STORE = 90;           -- 大航海商人
        UnlockFunctionType_Exp = 91;                        -- 经验副本
        UnlockFunctionType_CHAOS = 92;                      -- 虫洞副本
        UnlockFunctionType_Glyph = 93;                      -- 雕纹
        UnlockFunctionType_Wromhole = 94;                   --虫洞深处
        UnlockFunctionType_EquipUpgrade = 95;               --紫升红
        UnlockFunctionType_Bet = 96;                        --拉力赛
        UnlockFunctionType_GemConnect = 97;                 --符文石连接
        UnlockFunctionType_GemDecompose = 98;               --符文石分解
        UnlockFunctionType_Souvenir = 99;                   --纪念品
        UnlockFunctionType_Invalid = 100;                    --有效打点 截止
        
        
        UnlockFunctionType_FightLog = 254;--战利品日志
        UnlockFunctionType_FunnyRecord = 255;--趣味数据
        
    }

    local FunctionUnlockConditionType = {
        FunctionUnlockConditionType_CheckPoint = 1, --系统解锁条件-关卡解锁
        FunctionUnlockConditionType_Lv = 2,         --系统解锁条件-等级解锁
        FunctionUnlockConditionType_Task = 3,       --系统解锁条件-任务解锁
        FunctionUnlockConditionType_Killing = 4,    --系统解锁条件-杀怪解锁
    }

    -- 内购标签页类型
    local PURCHASE_PRODUCT_TYPE = {
        PURCHASE_DIAMOND = 1;           -- 钻石
        PURCHASE_TREASURE = 2;          -- 宝箱
        PURCHASE_COIN = 3;              -- 金币
        PURCHASE_DLC = 4;               -- DLC
        PURCHASE_MONTH_CARD = 5;        -- 月卡
        PURCHASE_EXTRA_GIFT = 6;        -- 特惠礼包（首充）
        PURCHASE_ADV_GIFT = 7;          -- 进阶礼包
        TimePushTreasure = 8;           -- 每日超值礼包
        BattlePass = 9;                 -- 通行证
        LifeTimeMembership = 10;        -- 终生卡
        MonthlySubscription = 11;       -- 订阅卡
        SpecialOfferPack = 12;          -- 七日礼包
        LevelFund = 13;                 -- 成长基金
        PurchaseFestival = 14;          -- 节日
        PurchaseLimitTime = 15;         -- 限时
        PurchaseIllusion = 16;          -- 幻化

    }

    local BattlePassIndex = {
        BattlePassIndex_Noraml = 1; --普通
        BattlePassIndex_Luxury = 2; --豪华
        BattlePassIndex_LuxuryDiscount = 3; --豪华折扣
    }
    -- 限购类型
    local PurchaseLimitType = {
        PurchaseLimitType_Daily = 1;--每日限购
        PurchaseLimitType_Weekly = 2;  --每周限购
        PurchaseLimitType_Total = 3; --玩家角色限购
    }

    local PurchaseCurrencyType = {
        PurchaseCurrencyType_Real = 0;    --真实货币
        PurchaseCurrencyType_Diamond = 1;   --钻石
    }

    -- 购买限制类型
    local PurchaseConditionType = {
        PurchaseConditionType_Level = 1;--等级限制
        PurchaseConditionType_Cave = 2;  --洞窟限制
        PurchaseConditionType_EquipScore = 3;  --装备评分限制
        PurchaseConditionType_Dungeon = 4;  --大秘籍限制
        PurchaseConditionType_Achievement = 5;  --成就限制
        PurchaseConditionType_GuildContrib = 6;  --公会贡献限制 
        PurchaseConditionType_CreateTime = 7;  --创建角色时间
        PurchaseConditionType_Stage = 8;  --阶段条件
        PurchaseConditionType_StageTime = 9;  --阶段购买时间条件
        PurchaseConditionType_TimePushIndex = 10;  --限时推送礼包index条件
        PurchaseConditionType_ChargeAmount = 11;  --充值金额
        PurchaseConditionType_LastLogoff = 12;  --上次离线
        PurchaseConditionType_LastChargeTime = 13;  --上次充值时间
        PurchaseConditionType_SpecialOfferIndex = 14;       -- 特惠礼包购买条件
        PurchaseConditionType_PurchaseFirstIndex = 15;          -- 首充礼包购买条件
        PurchaseConditionType_HeroCave = 16;                    -- 英雄洞窟
        PurchaseConditionType_DesertEye = 17;                   -- 沙之眼
        PurchaseConditionType_DistortedSpace = 18;              -- 扭曲空间
        PurchaseConditionType_Inferno = 19;                     -- 炼狱
    }

    local ActivityType = {
        ActivityType_QuestCondition = 1;  -- 任务条件活动
        ActivityType_ExtraDrop = 2;       -- 额外掉落活动
        ActivityType_Discount = 3;        -- 打折活动
        ActivityType_LuckyWheel = 4;      -- 抽奖活动
        ActivityType_BlackMarket = 5;     -- 黑市活动
        ActivityType_MailBind = 6;        -- 邮箱绑定活动
        ActivityType_RandomShop = 7;      -- 随机商店活动
        ActivityType_QuestConditionGuild = 8;          -- 公会任务条件活动
        ActivityType_Addition = 9;        -- 增益活动
        ActivityType_Cave = 10;           -- 副本活动
        ActivityType_Exchange = 11;       -- 兑换活动
        ActivityType_Advert = 12;         --广告活动
        ActivityType_LuckyLottery = 13;   --幸运抽奖活动
        ActivityType_Festival = 14;       --节日活动
        ActivityType_HeroTarget = 15;   --特殊活动, 不显示, 老玩家回归
        ActivityType_ExchangeShop = 16;   -- 兑换商店
        ActivityType_Share = 17;          -- 分享活动
        ActivityType_AnniversaryLuckyDraw = 18      -- 周年庆抽奖
    }

    -- 任务活动条件类型
    local QuestConditionType = {
        QuestConditionType_Killing = 1;  --杀怪(目标ID 0为所有)模式+难度+ID
        QuestConditionType_KillingBoss = 2;--击杀BOSS ()
        QuestConditionType_NPCOper = 3;  --完成NPC操作(FUNCTION_TYPE) 
        QuestConditionType_NPCOperSuc = 4;  --成功完成NPC操作(FUNCTION_TYPE) 
        QuestConditionType_Collection = 5;  --完成收集 (目标ID 0为所有)
        QuestConditionType_CollectionCoin = 6;  --完成收集金币 
        QuestConditionType_LoginOut = 7;  --登录 (1 连续登录 2累计登录)
        QuestConditionType_DiamodCost = 8; --水晶消耗(1:累积消耗 2:黑市消耗水晶 3:料理消耗水晶 4:改造消耗水晶 5:黑市水晶消耗次数 6水晶宝箱)
        QuestConditionType_EnterCave = 9; --进洞探险(1.进入普通洞窟 2.进入大秘境 3组队进入大秘境 4 .进入英雄洞窟(单人+组队))
        QuestConditionType_LeaveCave = 10; --探险完成(1,单人普通成功2组队普通成功3.英雄洞窟成功（单人+组队） )
        QuestConditionType_ArrivalLevel = 11; --到达指定层数(模式难度层数复合字段)
        QuestConditionType_AchievementPoint = 12; --成就点数
        QuestConditionType_EquipScore = 13; --装备
        QuestConditionType_Guild = 14; --公会
        QuestConditionType_Rechage = 15; --充值(0累计充值 其他为充值金额次数)
        QuestConditionType_BoxBought = 16;  --购买宝箱次数
        QuestConditionType_GemStoneType = 17;  --获取特定类型符文(0.所有类型 1. 普通 2. 多彩)
        QuestConditionType_GemStoneLevel = 18;  --获取特定等级符文(相应等级)
        QuestConditionType_BuyMonthCard = 19;   -- 购买月卡次数
        QuestConditionType_Version = 20;    --版本号目标
        QuestConditionType_OpenBox = 21; -- 开箱子（PublicDefine::BOX_TYPE)
        QuestConditionType_LuckyLotter = 22;  -- 参加幸运抽奖活动
        QuestConditionType_DrawMarblesFever = 23;  -- 反斗乐
        QuestConditionType_SetSail = 24;                    -- （庄园）出海次数
        QuestConditionType_FinishSail = 25;                 -- （庄园）完成航海次数
        QuestConditionType_FinishFish = 26;                 -- （庄园）完成钓鱼次数
        QuestConditionType_UseRecipe = 27;                  -- （庄园）使用菜谱次数
        QuestConditionType_CashRecharge = 28;  		        -- 现金充值
    }

    local ActivityRunningStat = {
        ActivityRunningStat_Waiting = 1;  --等待中
        ActivityRunningStat_Showing = 2;  --展示
        ActivityRunningStat_Running = 3;  --进行中
        ActivityRunningStat_Ending = 4;   --结束
        ActivityRunningStat_Off = 5;      --下架
    }

    -- 打折类型
    local DiscountType = {
        DiscountType_CatFood = 1;   -- 猫饭
        DiscountType_Revive = 2;    -- 复活
        DiscountType_Facelift = 3;  -- 捏脸
    }

    local MailSubType = {
        MailSubType_Web  = 1;
        MailSubType_Scene = 2;
    }

    -- 公会拍卖定义数据
    local GuildAuctionConfig =
    {
        AddPrice = 50;                   -- 最低加价
        PreNoticeInterval = 900;         -- 拍卖预告时间间隔
        NoticeInterval = 3600;           -- 拍卖预告时间间隔
        MinLooterCount = 10;             -- 最小分赃人数限制
    }

    --跑马灯类型
    local RunLampType = {
        RunLampType_Web  = 1;
        RunLampType_Scene = 2;
        RunLampType_Local = 3;--客户端本地触发
    }

    local WebLogS3DelayType = {
        WebLogS3DelayType_Game = 1;   -- 游戏延迟
        WebLogS3DelayType_Pay = 2;    -- 支付延迟
        WebLogS3DelayType_CNPay = 3;  -- 国内支付延迟
    }

    local WebLogS3Type = {
        WebLogS3Type_Mailbanner = 1;    -- 邮件banner
        WebLogS3Type_TownNotice = 2;    -- 登陆弹窗推送界面
        WebLogS3Type_MailBinding = 3;   -- 打开邮箱绑定活动的UI
        WebLogS3Type_Setting = 4;       -- 设置
        WebLogS3Type_IapShop = 5;       -- 商城
        WebLogS3Type_Activity = 6;      -- 活动
        WebLogS3Type_SpecialGift = 7;   -- 特殊礼包
        WebLogS3Type_SevenDays = 8;     -- 7日目标
        WebLogS3Type_Dream = 9;     -- 梦境
        WebLogS3Type_BattlePass = 10;     -- 通行证
        WebLogS3Type_DeepLink = 11;     -- 记录deeplink跳转 
        WebLogS3Type_SevenGift = 12;     -- 7日礼包
    }

    local WebLogS3Type_Setting_Type = {
        WebLogS3Type_Setting_Type_Music = 1;    -- 音乐
        WebLogS3Type_Setting_Type_Sound = 2;  -- 音效
        WebLogS3Type_Setting_Type_Friend = 3; -- 队友聊天
        WebLogS3Type_Setting_Type_Microphone = 4; -- 麦克风开关
        WebLogS3Type_Setting_Type_Move = 5;    -- 移动方式
        WebLogS3Type_Setting_Type_Helmet = 6;  --头盔显示设置
        WebLogS3Type_Setting_Type_HighFrameRate = 7; --高帧率模式
        WebLogS3Type_Setting_Type_ShieldingChat = 8; -- 聊天
        WebLogS3Type_Setting_Type_PrivateChat = 9;     -- 私聊
        WebLogS3Type_Setting_Type_HideWall = 10;      -- 隐藏墙体
        WebLogS3Type_Setting_Type_ClickZone = 11;    -- 进去社区界面
        WebLogS3Type_Setting_Type_EnterFB = 12;      -- 进入FB界面
        WebLogS3Type_Setting_Type_RefusedApprentice = 13; -- 拒绝收徒
        WebLogS3Type_Setting_Type_Language = 14;      -- 切换语言
    }

    -- 来源类型
    local WebLogS3Type_Source_Type = {
        WebLogS3Type_Source_Type_None = 0;      -- 无意义的触发点
        WebLogS3Type_Source_Type_NPC = 1;       -- 地图NPC触发
        WebLogS3Type_Source_Type_MiniMap = 2;   -- 小地图
        WebLogS3Type_Source_Type_BigMap = 3;    -- 功能界面化
        WebLogS3Type_Source_Type_Bag = 4;       -- 背包,包含快捷栏背包
        WebLogS3Type_Source_Type_CurrencyPanel = 5; -- 快捷钻石，金币条
        WebLogS3Type_Source_Type_OpenFromUrl = 6;   -- 从URL打开
        WebLogS3Type_Source_Type_DiamondNotEnough = 7;   -- 钻石不够
        WebLogS3Type_Source_Type_DiamondNotEnoughRevive = 8;   -- 钻石不够(复活)
    }


    --web日志统计api接口类型
    local WebLogType = {
        WebLogType_MailBanner_Click  = 1;    --点击邮件banner
        WebLogType_TownNotice_Open = 2;      --打开登陆弹窗推送界面
        WebLogType_TownNotice_Redirect = 3;  --点击登陆弹窗推送跳转按钮
        WebLogType_MailBinding_Open = 4;	 --打开邮箱绑定活动的UI
        WebLogType_ConfigChange = 5;         --设置变更
        WebLogType_IapShop_Open = 6;              --打开商城
        WebLogType_IapShop_Close = 7;             --关闭商城
        WebLogType_IapShop_PageOp = 8;                --商城页面操作 对应WebLogType_IapShop_PageOp_Type
        WebLogType_IapShop_FirstPurchase = 9;     --商城 首冲
        WebLogType_Activity = 10;                 --活动
        WebLogType_AdsEvent = 11;                 --广告事件
        WebLogType_ExtraGift = 12;                --超值礼包
        WebLogType_AdvGift = 13;                  --进阶礼包
        WebLogType_LimitGift = 14;                --限时礼包
        WebLogType_SevenGift = 15;                --7日特惠礼包
    }
    -- 商城页面操作
    local WebLogType_IapShop_PageOp_Type = {
        WebLogType_IapShop_PageOp_Type_Open = 1;  -- 打开页面  WebLogType_IapShop_Page_Type
        WebLogType_IapShop_PageOp_Type_Detail = 2; -- 点击页面内item的详情查看
        WebLogType_IapShop_PageOp_Type_Buy = 3;  --点击页面内item的购买
        WebLogType_IapShop_PageOp_Type_Get = 4; --点击页面内item的领取
    }
    -- 页面类型
    local WebLogType_IapShop_Page_Type = {
        WebLogType_IapShop_Page_Type_Box = 1; -- 宝箱
        WebLogType_IapShop_Page_Type_MonthCard = 2; -- 月卡
    }

    -- web日志统计api接口类型 子类型 活动
    local WebLogType_Activity_Type = {
        WebLogType_Activity_Open = 1; --点击NPC
        WebLogType_Activity_Detail = 2; --点查看活动
    }
    -- 登陆日志步奏
    local LoginLogType = {
        Launch = 10;                             -- 启动app
        App_Update = 20 ;                         -- 强更(可能没有)
        Hotfix_Start = 30;                       -- 热更开始 
        Hotfix_Error = 40;                       -- 热更错误(可能没有)
        Hotfix_Success = 50;                     -- 热更流程完毕
        User_Agreement = 60;                     -- 用户协议操作(成功代表同意 失败代表不同意)
        Third_Login = 70;                        -- 开始第三方登录
        Third_Login_Result = 80;                 -- 第三方登录结果
        Req_LoginToGameServer = 90;              -- 请求登入游戏服
        Open_RoleCreateLayer = 100;              -- 没有角色,唤起创建角色页面(可能没有)
        RoleCreate_Result = 110;                 -- 角色创建结果(可能没有)
        Loading_Start = 120 ;                    -- 开始loading打开loading界面
        Loading_Server_LoadScene = 130;          -- 服务器通知加载场景
        Loading_Server_IntoScene = 140;          -- 服务器通知进入场景
        Loading_Client_IntoScene_Done = 150;     -- 客户端进入场景完毕
        EnterGameDone = 160;                     -- 客户端进入主城/洞窟(完整进入游戏)

    }
    -- 热更新错误类型
    local Hotfix_Error_Type = {
        Hotfix_Read_LocalFile = 1;              -- 读取本地列表文件
        Hotfix_Download_Manifest = 2;           -- 下载列表文件
        Hotfix_Parse_Manifest = 3;              -- 解析列表文件
        Hotfix_Download_Files = 4;              -- 热更下载资源状态失败会跟上下载失败的文件名字
    }
    -- 屏蔽聊天、显示头盔、移动方式、角色数值、语言 fps
    local WebLogConfigChangeType = {
        WebLogConfigChangeType_Chat = 1;
        WebLogConfigChangeType_Helmet = 2;
        WebLogConfigChangeType_MoveType = 3;
        WebLogConfigChangeType_Value = 4;
        WebLogConfigChangeType_Lan = 5;
        WebLogConfigChangeType_FPS = 6; 
    }

    --文本类型
    local ChatMsgContentTextType = {
        TYPE_XML= 1;   --xml
        TYPE_QUICK_ID = 2;       --快捷聊天ID
        TYPE_QUICK_TEXT = 3;       -- 快捷聊天文本
    }

    -- 聊天屏蔽
    local Config_Chat_Block = {
        Open = 1;   -- 打开屏蔽     
        Close = 2; -- 关闭屏蔽
    }
    -- 隐藏头盔
    local Config_Helmet_Hidden = {
        Hidden = 1;  -- 隐藏头盔
        Show = 2;    -- 显示头盔
    }
    local ContentFormatType = {
        ContentFormatType_Time  = 1;       --时间戳 时间绝对秒数 
        ContentFormatType_Number = 2;      --纯数字
        ContentFormatType_ItemId = 3;      --道具Id（获取道具名字）
        ContentFormatType_LocalLanguageId = 4; --本地多语言 （从本地profileLanguage.lua 获取）
        ContentFormatType_WebLanguageId = 5; --web多语言  从web 拉取
        ContentFormatType_Currency = 6; --货币（人民币、美元...）
        ContentFormatType_Text  = 7; --纯文本
        ContentFormatType_MonsterId = 8; --怪物Id（获取怪物名字）
        ContentFormatType_RoleName = 9; --人物名字
        ContentFormatType_GuildName = 10; --公会名字
        ContentFormatType_PetName = 11; --宠物名字
        ContentFormatType_LuckDrawPk = 12;  --周年庆抽奖获奖玩家信息
        ContentFormatType_BetBoatId = 13;  --拉力赛
    }

    local LoginStatus = {
        Success = 1;            --成功
        NeedForceUpdate = 2;    --需要强更
        NeedHotFix = 3;         --需要热更
        ServerMaintenance = 4;  --服务器维护中
        ReachMaxOnlineNum = 5;  --达到设置的最大在线人数
        AuthenticateFailed = 6; --第三方登陆验证失败
        ServerFlashMaintenance = 7; -- 服务器闪断维护中
        RoleAccountDeleting = 8; -- 角色删除中
    }

    local MailBindingSendMailStatus = {
        MailBindingSendMailStatus_Success = 1;            --成功
        MailBindingSendMailStatus_InValidEmail = 2;       --邮箱输入格式不对
        MailBindingSendMailStatus_SendCodeFailed = 3;     --未绑定正确邮箱（发送验证码到邮箱时失败）
        MailBindingSendMailStatus_ActionCoolDown = 4;     --验证码CD中(60s后才能再次发邮件)
    }

    --邮箱绑定活动验证-状态码
    local MailBindingVerifyStatus ={
        MailBindingVerifyStatus_Success = 1;            --成功
        MailBindingVerifyStatus_InValidCode = 2;         --无效的验证码（验证码不正确）
    }

    local SPECIAL_EVENT_TYPE = {
        -- 初始BUFF——填写BUFFID(楼层无意义)
        SPECIAL_EVENT_TYPE_BUFF = 1;
        -- 逃脱卷轴产量——填写总共产出几个(楼层无意义)
        SPECIAL_EVENT_TYPE_ESCAPE_SCROLL = 2;
        -- 词缀生成——填写怪物词缀表中的ID
        SPECIAL_EVENT_TYPE_AFFIX = 3;
        -- 陷阱生成——参数1填写level表对应陷阱最小数量、参数2填写对应陷阱最大数量
        SPECIAL_EVENT_TYPE_TRAP = 4;
        -- 怪物外观——参数1填写大类;怪物ID1,怪物ID2 参数2填写对应外观（1=普通怪、2=精英怪、3=小BOSS）
        SPECIAL_EVENT_TYPE_DEFORMATION = 5;
        -- 新增怪物 参数1填写新增怪物用;分隔 参数2填写指定层最小和最大普通怪物数量 参数3填写指定层最小和最大精英怪物数量 参数4配置普通怪物掉落 参数5配置精英怪物掉落
        SPECIAL_EVENT_TYPE_NEW_MONSTER = 6;
        -- 金币袋生成——参数1填写最小最大袋子掉落数 参数2填写袋子里最少最多的金币数
        SPECIAL_EVENT_TYPE_GOLD_BOX = 7;
        -- 精英怪数量调整——参数1填写最小最大数量
        SPECIAL_EVENT_TYPE_ELITE_MONSTER = 8;
        -- 符文生成——参数1填写符文编号，参数2填写最小最大数量
        SPECIAL_EVENT_TYPE_RUNE = 9;
        -- 小BOSS生成——参数1填写小BOSSID，参数2填写最小最大数量，参数3填写小BOSS掉落
        SPECIAL_EVENT_TYPE_LITTLE_BOSS = 10;    
    }

    local HeroCaveRefreshMode = {
        HeroCaveRefreshMode_Manual = 1;                 --手动刷新
        HeroCaveRefreshMode_Automatic = 2;              --自动刷新
    }

    local ChatChannelType = {
        ChatChannelType_Near = 1;      --附近频道
        ChatChannelType_Team = 2;      --队伍频道
        ChatChannelType_Guild = 3;    --公会频道
        ChatChannelType_Private = 4;    --私聊频道
        ChatChannelType_WorldChat = 5;    --世界频道
    }

    local BanChatType = {
        BanChatType_Ban = 1;    --禁言
        BanChatType_Isolated = 2;    --隔离
    }

    local GemstoneBoughtCostType = {
        GemstoneBoughtCostType_Free = 1,    --免费
        GemstoneBoughtCostType_Item = 2,    --物品
        GemstoneBoughtCostType_Diamond = 3,  --钻石
    }

    --主天赋类型
    local MainTalentType = {
        MainTalentType_Attack = 1,  -- 攻击
        MainTalentType_Defense = 2, -- 防御
        MainTalentType_Core = 3,    -- 核心
        MainTalentType_Assist = 4,  -- 辅助
        MainTalentType_Element = 5, -- 元素
    }

    --装备重铸 消耗类型
    local CostType =  {
        Cost_Diamond = 1;--钻石
        Cost_Coin = 2; --金币
        Cost_Material = 3; --材料
    }

    --[[
        描述：功能类型，这里不用和public_define 里面的定义关联了，由于protobuf 里面的枚举不支持 64 位数值导致。
        注意事项：这里由客户端和服务器分别维护。如果有修改值需要通知服务器同事处理  add by zp
    ]] 
    local FUNCTION_TYPE = {
        EXCHANGE_IN_CAVE = 1;               -- 洞内交易
        GOLD_TOUCH = 2;                     -- 点金
        ENCHANT = 3;                        -- 附魔
        EXCHANGE_IN_TOWN = 4;               -- 城镇交易
        BLACK_MARKET = 5;                  -- 黑市交易
        SELL_GOODS = 6;                    -- 卖物品
        MAILBOX = 7;                       -- 邮箱
        GENERAL_ENTRANCE = 8;             -- 普通入口
        SPECIFIC_ENTRANCE = 9;            -- 特殊入口
        TASK = 10;                         -- 任务
        ACHIEVEMENT = 11;                 -- 成就
        LEADERBOARD = 12;                 -- 排行榜
        WAREHOUSE = 13;                   -- 仓库
        GUILD_ENTRANCE = 14;              -- 公会入口
        SPEAKER = 15;                    -- 话痨（说话的NPC）
        EQUIPMENT_STRENGTHEN = 16;       -- 装备强化
        EQUIPMENT_REMODEL = 17;          -- 装备改造
        CAT_FOOD = 18;                  -- 猫饭
        EQUIPMENT_DECOMPOSE = 19;       -- 装备分解
        EQUIPMENT_FORGE = 20;           -- 装备锻造
        FACELIFT = 21;                 -- 捏脸
        LUCKYWHEEL_TURN = 22;          -- 转盘抽奖
        GUILD_TASK = 23;               -- 公会任务
        GUILD_TECH = 24;               -- 公会科技
        GUILD_MANAGER = 25;           -- 公会管理员
        GUILD_MARKET = 26;            -- 公会商人
        DUNGEON_SEASON_REWARD = 27;   -- 大秘境赛季奖励
        ACTIVITY = 28;               -- 运营活动
        GEMSTONE_INLAID = 29;        -- 宝石镶嵌
        GEMSTONE_COMPOSE = 30;       -- 宝石合成
        GEMSTONE_TRANSFORM = 31;    -- 宝石转化
        GEMSTONE_BUY = 32;          -- 宝石购买
        RANDOMSHOPUNLOCK = 33;      -- 随机商店
        CONST_DECORATION = 34;      -- 常驻显示类的NPC
        HOME_SYSTEM_MINE = 35;     -- 家园系统 金矿NPC
        HOME_SYSTEM_GEM  = 36;     -- 家园系统 符文石
        SKILL_ADVANCED = 37,       -- 进阶
        EQUIPMENT_ILLUSION = 38,  -- 幻化
        REMODEL_REPLACE = 39;       -- 改造替换
        FUNCTION_TYPE_DREAM = 40;  -- 梦境试验
        EQUIP_CONVERT = 41;       -- 装备转化
        FUNCITON_TYPE_DREAM_TASK = 42; -- 梦境试验挑战任务
        DREAMSHOP = 43;     -- 梦境商店
        EQUIP_RECAST = 44; --装备重铸
        FUNCTION_TYPE_STARPRAY_GET = 45;    --星痕抽奖
        FUNCTION_TYPE_STARPRAY_EQUIP = 46;    --星痕装配+ 吞噬
        FUNCTION_TYPE_EXPEDITION = 47;    -- 探险队
        FUNCTION_TYPE_GUILDSHOP = 48;    -- 公会商店
        FUNCTION_TYPE_GUILDBOSS = 49;    -- 公会BOSS
        DESERT_EYE = 50;                --沙之眼
        DISTORTED_SPACE = 51;           --扭曲空间
        EQUIP_LEVEL_REMOVE = 52;        -- 装备等级移除
        EQUIP_REFINE = 53;              -- 装备精炼
        EQUIP_SET_CHANGE = 54;          -- 装备套装转换
        APPRENTICESHIP = 55;           -- 师徒系统
        FUNCTION_TYPE_FESTIVAL = 56;    -- 节日活动
        FUNCTION_TYPE_WISHPOOL = 57;    -- 公会许愿池
        GUILD_WRIT = 58;      -- 公会令状
        GUILD_AUCTION_STOCK = 59; --拍卖进货
        GUILD_AUCTION_MAIN = 60; --拍卖主界面
        FUNCTION_TYPE_PETTREASURE = 61;        --宠物宝藏
        FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP = 62; --节日活动商店
        FUNCTION_TYPE_PETRECYCLINGSHOP = 63; --宠物回收商店
        FUNCTION_TYPE_PETDEVELOP = 64;              -- 宠物培养
        FUNCTION_TYPE_HOME = 65;                    -- 家园
        FUNCTION_INFERNO = 66;               -- 深红炼狱
        PET_EQUIPMENT_STRENGTHEN = 67;       -- 宠物装备强化
        FUNCTION_GHOST_ABYSS_TOTEM = 68;            -- 幽灵深渊：初始图腾
        FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM = 69;  -- 幽灵深渊：被激活图腾
        FUNCTION_GHOST_LEVELSELECT = 70;            -- 幽灵深渊：关卡选择
        FUNCTION_GHOST_SHOP = 71;                   -- 幽灵深渊：商店
        FUNCTION_PET_ADVENTURE = 72;                -- 宠物冒险
        FUNCTION_BOSS_PORTAL = 73;                  -- Boss直达
        FUNCTION_MANOR_PORTAL = 74;                 --庄园入口
        FUNCTION_FISH_SHOP = 75;                    -- 渔具商店
        FUNCTION_TRAVELING_BUSINESSMAN = 76;        -- 旅行商人
        FUNCTION_VOID_RIFT = 77;                    -- 虚空秘境
        FUNCTION_BARTER = 78;                       -- 易物台
        FUNCTION_SUIT_TRANSFORMATION = 79;          -- 套装改造
        FUNCTION_MANOR_HOUSEKEEPER = 80;            -- 庄园管家
        FUNCTION_MANOR_DESK = 81;                   -- 庄园书桌NPC
        FUNCTION_MANOR_BOAT = 82;                   -- 庄园远航NPC
        FUNCTION_MANOR_DININGTABLE = 83;            -- 庄园餐桌
        FUNCTION_MANOR_DRESS_UP_SHELF = 84;         -- 庄园装备架
        FUNCTION_TYPE_PET_POKEDEX = 85;             -- 宠物图鉴
        FUNCTION_VIKING = 86;                       -- 维京时代
        FUNCTION_EVER_WINTER = 87;                  -- 永冬裂缝
        FUNCTION_PET_STONE = 88;                    -- 宠物宝石
        FUNCTION_TREASURE_IDENTIFY = 89;            -- 宝藏鉴定
        FUNCTION_REINCARNATION = 90;                -- 角色转生
        FUNCTION_MOLDFORING = 91;                   -- 模具锻造
        FUNCTION_MOLDUSE    = 92;                   -- 模具使用
        FUNCTION_NAVIGATION = 93;                   --大航海码头
        FUNCTION_NAVIGATION_STORE = 94;             --大航海商人
        FUNCTION_NAVIGATION_TASK = 95;              --大航海任务
        FUNCTION_NAVIGATION_SUPPLY = 96;            --大航海码头
        FUNCTION_CHAOS = 97;                        --混沌虫洞
        FUNCTION_EQUIPMENT_INHERIT = 98;            --装备改造继承
        FUNCTION_GLYPH = 99;                        --雕纹
        FUNCTION_BET = 100;                         --拉力赛投注
        FUNCTION_WORMHOLE = 101;                    --虫洞深处
        FUNCTION_CHANGEPURPLE = 102;                --紫装升红
        FUNCTION_RALLYGAME = 103;                   --拉力赛战斗
        FUNCTION_GEMCONNECT = 104;                  --符文连接
        FUNCTION_GEMDECOMPOSE = 105;                --符文分解
    }
  
    local QuestionType = {
        QuestionType_Attr = 1,      --; --属性(对应target为ATTR_TYPE)
        QuestionType_Equipe = 2,      --; -- 装备(对应target为EQUIPMENT_TYPE)
        QuestionType_CaveLevel = 3,   --; -- 洞窟层数
        QuestionType_AchievementPoint = 4,   --; -- 成就点数
        QuestionType_Item = 5,        --; -- 道具(对应target为道具ID)
        QuestionType_Firend = 6,        --; -- 道具(对应target为道具ID)
        QuestionType_GuildMember = 7 ,       --; -- 道具(对应target为道具ID)
        QuestionType_Resource = 8,        --; -- 道具(对应target为道具ID)
    }

    --梦境任务状态
    local DreamTaskState = {
        State_UnRecieve = 0,  --未领取
        State_Recieved = 1,   --已领取
        State_Success = 2,    --成功完成
        State_Fail = 3,       --失败（未完成）
    }

    local DreamTaskType = {
        DreamTaskType_TIME = 1,  --时间挑战
        DreamTaskType_HP = 2,    --血量挑战
        DreamTaskType_HPKEEP = 3,    --血量维持挑战
        DreamTaskType_CONTROL = 4,    --控制挑战
        DreamTaskType_ITEMUSED = 5,    --道具使用挑战
    }

    local StarPrayDrawType = {
        StarPrayDrawType_Diamond = 1;               --钻石
        StarPrayDrawType_StarPrayCoin = 2;          --星痕币
        StarPrayDrawType_Coin = 3;          --星痕币
    }

    --幸运转盘相关
    local LuckyLotteryOptType = {
        LuckyLotteryOptType_Turn = 1;     --转盘
        LuckyLotteryOptType_Refresh = 2;  --刷新
        LuckyLotteryOptType_RewardLucky = 3; --领取幸运奖励
    }

    local LuckyLotteryCostType = {
        LuckyLotteryCostType_Free = 1;    --免费
        LuckyLotteryCostType_Item = 2;    --物品
        LuckyLotteryCostType_Diamond = 3; --钻石
    }

    local DistortedSpaceEventState = {    
        DistortedSpaceEventState_Closed = 1;        -- 关闭状态
        DistortedSpaceEventState_Doing = 2;         -- 进行状态
        DistortedSpaceEventState_Opened = 3;        -- 开启状态
    }

    local BattlePassAwardType = {
        BattlePassType_Normal = 1;  --普通通行证
        BattlePassType_Golden = 2;  --金色通行证
    }

    -- 公会令状ID
    local WritID = {
        WritID_WorldBoss = 1;   -- 世界Boss
        WritID_Expedtion = 2;   -- 探险队
        WritID_Dream = 3;       -- 梦境
        WritID_GuildBox = 4;    -- 公会宝箱
        WritID_GuildBoss = 5;   -- 公会Boss 
        WritID_GuildMedal = 6;  -- 公会勋章
    }

    -- 返回值
    local ErrNo = {
        ErrNo_Ok = 1;       -- OK
        ErrNo_SysErr = 2;   -- 系统错误
        ErrNo_ParaErr = 3;   -- 参数错误
        ErrNo_AlreadyStartCollect = 4;      -- 已开始采集
        ErrNo_ItemNotEnough = 45;           -- 消耗不足
        ErrNo_BagIsFull = 81;               -- 包裹已满
        ErrNo_LevelIsLow = 86;              -- 等级太低
        ErrNo_InFighting = 104;             -- 正在战斗
        ErrNo_SailTooOften = 105;           -- 大航海操作太频繁
        ErrNo_PetGemConversionNotEmpty = 403;           -- 魂玉转换未领取
        ErrNo_BigsailPetPowerNotEnough = 404; -- 大航海宠物上阵战力不足
        ErrNo_BigsailPetLevelNotEnough = 405; -- 大航海宠物上阵等级不足
        ErrNo_BigsailBoatPowerNotEnough = 406;-- 大航海船只派遣战力不足
    }

    -- 常用物品ID
    local ITEM_ID = {
        ITEM_ID_RETURN_TICKET = 20050010;               -- 回城券
        ITEM_ID_EXPEDITION_QUICK = 22070580 ;           -- 快速探险消耗道具
        ITEM_ID_SWEEP_DISTORTEDSPACE = 22070620;        -- 扫荡道具
        ITEM_ID_DRAW_MIRACLEPRAYER = 22050110;          -- 神迹祈祷消耗道具
        ITEM_ID_SWEEP_INFERNO = 22070660;               -- 深红炼狱扫荡道具
        ITEM_ID_SWEEP_VOIDRIFT = 22070622;              -- 虚空秘境扫荡道具
        ITEM_ID_MONTHLYSIGNIN_RESIGN = 22072040;        -- 月度签到补签道具
        ITEM_ID_SWEEP_VIKING = 22070623;                -- TEST 维京时代扫荡道具
    }

    -- festival数据key值
    local FunnyRecordType = {
        FunnyRecordType_TaskDone = 1;      --完成任务
        FunnyRecordType_SucBackTownDiff_1 = 2;   --安全回城（普通）
        FunnyRecordType_SucBackTownDiff_2 = 3;   --安全回城（噩梦）
        FunnyRecordType_SucBackTownDiff_3 = 4;   --安全回城（地狱）
        FunnyRecordType_GoldenTouch = 5;   --点金
        FunnyRecordType_DiscoverChamberDiff_1 = 6;    -- 发现密室（普通）
        FunnyRecordType_DiscoverChamberDiff_2 = 7;    -- 发现密室（噩梦）
        FunnyRecordType_DiscoverChamberDiff_3 = 8;    -- 发现密室（地狱）
        FunnyRecordType_StrengthenSuc = 9;          --强化成功
        FunnyRecordType_EnchantSuc = 10;       --附魔成功
        FunnyRecordType_LuckyWheelNum = 11;      --累计抽奖次数
        FunnyRecordType_CoinCost = 12;         --金币消耗
        FunnyRecordType_DeadNum = 13;         --死亡次数
        FunnyRecordType_CommonMonsterKillingOnCave = 14;  --普通模式击杀普通怪
        FunnyRecordType_EliteMonsteKillingOnCave = 15;    --普通模式击杀精英怪
        FunnyRecordType_LittleBossKillingOnCave = 16;           --普通模式击杀小BOSS
        FunnyRecordType_BossKillingOnCave = 17;           --普通模式击杀BOSS
        FunnyRecordType_CommonMonsterKillingOnDungeon = 18;  --秘境模式击杀普通怪
        FunnyRecordType_EliteMonsteKillingOnDungeon = 19;    --秘境模式击杀精英怪
        FunnyRecordType_LittleBossKillingOnDungeon = 20;           --秘境模式击杀小BOSS
        FunnyRecordType_BossKillingOnDungeon = 21;           --秘境模式击杀BOSS
        FunnyRecordType_OpenGoldenBox = 22;        --打开金箱子
        FunnyRecordType_OpenWoodinessBox = 23;     --打开木箱子
        FunnyRecordType_OpenPotBox = 24;          --打开陶罐
        FunnyRecordType_OpenBoneBox = 25;          --打开骨头堆
        FunnyRecordType_OpenBagBox = 26;           --打开钱袋
        FunnyRecordType_OpenRune = 27;             --打开符文
        FunnyRecordType_TriggerTrap = 28;         --触发陷阱
        FunnyRecordType_MonsterKillingOnCave = 29; --单次探险杀怪记录
        FunnyRecordType_CounterattackNum = 30;       --反击次数
        FunnyRecordType_CaveLevelDiff_1 = 31;     --洞窟记录(普通)
        FunnyRecordType_CaveLevelDiff_2 = 32;     --洞窟记录(噩梦)
        FunnyRecordType_CaveLevelDiff_3 = 33;     --洞窟记录(地狱)
        FunnyRecordType_DungeonLevel = 34;  --大秘境记录
        FunnyRecordType_EquipScore = 35;    --装备评分
        FunnyRecordType_DesertEye = 36;  --沙之眼记录
        FunnyRecordType_Praise = 37;  --赞
        FunnyRecordType_Criticize = 38;  --踩
        FunnyRecordType_Puzzle = 39;      -- 翻牌
    }

    local AreaProperty = {
        AreaProperty_Recommend = 1;                 -- 推荐分区
    }

    local AreaStatus = {
        AreaStatus_Normal = 0;                      -- 正常状态
        AreaStatus_Maintain = 1;                    -- 维护状态
    }

    local TradeActivityIDList = {
        TradeActivityFirstPay = 1000001;                -- 特惠礼包
        TradeActivityGrowFund = 1000002;                -- 成长基金
        TradeActivityDailyGiftBag = 1000003;            -- 每日超值礼包
        TradeActivityDailyPay = 1000004;                -- 每日充值奖励
        TradeActivityLimitGiftCompetition = 1000005;    -- 战力达人
        TradeActivityPetGiftCompetition = 1000006;      -- 骑宠达人
        TradeActivityfashionGiftCompetition = 1000007;  -- 时尚达人
        TradeActivityachieveGiftCompetition = 1000008;  -- 成就达人
        TradeActivityLottery = 1000009;                 -- 大转盘
        TradeActivityPrivilegeCard = 1000010;           -- 月卡终身卡
        TradeActivityGroupPay = 1000011;                -- 团购
        TradeActivityFightBack = 1000013;               -- 反斗大转盘
        TradeActivityQQGameFreshGiftPack = 1000014;     -- QQ大厅新手礼包
        TradeActivityQQGameActivGiftPack = 1000015;     -- QQ大厅活跃礼包
        TradeActivityQQGameGrowGiftPack = 1000016;      -- QQ大厅成长礼包
        TradeActivityQQGameMogulWeekGiftPack = 1000017; -- QQ大厅玩咖周礼包
        TradeActivityQQGameMogulPrivilege = 1000018;    -- QQ大厅玩咖特权礼包
        TradeActivityNewGrowFund = 1000019;             -- 新成长基金
        TradeActivityEquipmentStarFund = 1000020;       -- 装备星数(领悟之书)基金
        TradeActivityGrowFundII = 1000021;              -- 成长基金2
        TradeActivityComeback = 1000022;                -- 返场
        TradeActivityTimeLimitedFightBack = 1000023;    -- 限时反斗乐
        TradeActivityNewGrowFundTwo = 1000024;          -- 2阶新成长基金
        TradeActivityAppointmentTask = 1000125;         -- 预约任务
        TradeActivityAppointmentCoinReward = 1000126;   -- 个人奖励
        TradeActivityAppointmentServerReward = 1000127; -- 全服奖励
        TradeActivityCrystalTreature = 1000028;          -- 水晶夺宝
        TradeActivityGrowFund3 = 1000029;               --成长基金3
        TradeActivityStarFire = 1000031; --星火


        --- 暂时先这么写，服务器还没开始，这里用作客户端代码临时使用，最后使用服务器定义的字段
        --TradeActivityAllGroupBuying = 1000030;               --全服团购
    }

    local TimeLimitedTitle = {
        titleId = 1;                    -- 称号ID
        endTime = 2;                    -- 过期时间
    }

    local AlbumNotificationType = {
        AlbumNotificationPetUpdate = 1;                        -- 宠物获得或数据更新
        AlbumNotificationTargetUpdate = 2;                     -- 画册目标状态更新
    }

    local PetQualityType = {
        Blue = 1;
        Golden = 2;
        HiddenGold = 3;
        Violet = 4;
        Red = 5;
        Platinum = 6;
    }

    local SomethingType = {
        SomethingType_ReloadDirtyWords = 1;                     -- 重读敏感字库
    }

    local PlayerDecorateType = {
        PlayerDecorateType_Portal = 1;                          -- 回城特效
        PlayerDecorateType_UI = 2;                              -- UI 特效
    }

    local UseUIDecorateValue = {
        DecorateValue_Default = 0;
        DecorateValue_Tiger = 1; --虎年
        DecorateValue_Pirate = 2; --海盗
        DecorateValue_Max = 3; --最大值
    }

    local ManorBuildID = {
        BuildID_None = 0;                                       -- 无效值
        BuildID_Manor = 1;                                      -- 庄园
        BuildID_StarMap = 2;                                    -- 星图
        BuildID_TravelShop = 3;                                 -- 行商(Pedlery）
        BuildID_Dock = 4;                                       -- 船坞
        BuildID_Table = 5;                                      -- 餐桌
        BuildID_EquipmentRack = 6;                              -- 装备架
    }

    -- 商店类型
    local StoreType = {
        StoreType_PetDust = 1;                 -- 宠物回收商店
        StoreType_MarblesFever = 2;            -- 反斗乐商店
        StoreType_LimitedMarblesFever = 3;     -- 限时反斗乐商店
        StoreType_CrystalTreature = 4;     -- 水晶夺宝商店
        StoreType_Primoge = 5;                 -- 原石商店
    }

    -- 活动副本类型
    local ActivityModeCaveType = {
        TrialLand = 1001;                 -- 试炼之地
    }

    -- 活动副本排行榜类型
    local CustomRankType = {
        CustomRankType_TrialLand = 1;                   -- 试炼之地
    }

    -- 周年庆活动报名方式
    local AnniversaryLuckyDrawSignType = {
        AnniversaryLuckyDrawSign_WorldChat = 1;          -- 世界频道聊天
        AnniversaryLuckyDrawSign_Gift      = 2;          -- 礼包购买
    }

    local CurrencyPanelType = {
        Normal                  = 1; --一般的模式, 有金币和钻石
        RunesCave               = 2; --符文洞窟商店类型, 只有对应的积分币
    }

    local CommonShopType = {
        FishGear                = 1; --渔具商店
        RunesCave               = 2; --符文洞窟积分商店
    }

    -- 船只状态
    local BigSailBoatStatus = 
    {
        None = 0,
        BigSailBoating = 1, -- 大航海出海中
        BigSailBoatingWaitFinish = 2, -- 航行完成等待占领
        BigSailBoatingCaptured = 3,   -- 占领岛屿
    }

    -- 对战类型
    local BigsailBattleTypeEnum = 
    {
        BigsailBattleType_none = 0,
        BigsailBattleType_common = 1,
        BigsailBattleType_multi = 2,
        BigsailBattleType_boss = 3,
        BigsailBattleType_Monster = 4,
    }

    -- 雕文等级
    local GlyphType ={
        GlyphType_Blue = 2;
        GlyphType_Gold = 3;
        GlyphType_DarkGold = 4;
        GlyphType_Purple = 5;
    }

    -- 星图类型
    local StarMapMosaicType ={
        MosaicFight = 1,      -- 战斗
        MosaicAssist = 2,     -- 辅助
        MosaicMax = 3,
    }

    PublicDefine.EObjectType = EObjectType
    PublicDefine.CAVE_MODE = CAVE_MODE
    PublicDefine.CAVE_DIFFICULTY = CAVE_DIFFICULTY
    PublicDefine.GAME_MODE = GAME_MODE
    PublicDefine.SCENE_TYPE = SCENE_TYPE
    PublicDefine.DUNGEON_ROOM_TYPE = DUNGEON_ROOM_TYPE
    PublicDefine.TRANS_DOOR_TYPE = TRANS_DOOR_TYPE
    PublicDefine.TRIGGER_NPC_TYPE = TRIGGER_NPC_TYPE
    PublicDefine.TRANS_POINT_TYPE = TRANS_POINT_TYPE
    PublicDefine.BOSS_SCENARIO_TYPE = BOSS_SCENARIO_TYPE
    PublicDefine.GOODS_COST_TYPE = GOODS_COST_TYPE
    PublicDefine.FUNCTION_TYPE = FUNCTION_TYPE
    PublicDefine.ATTR_TYPE = ATTR_TYPE
    PublicDefine.ATTR_TYPE_ID_KEY = ATTR_TYPE_ID_KEY
    PublicDefine.CONST_DEFINITION = CONST_DEFINITION
    PublicDefine.HERO_SEX = HERO_SEX
    PublicDefine.SPRITE_STATUS = SPRITE_STATUS
    PublicDefine.ATTR_CHANGE_REASON_TYPE = ATTR_CHANGE_REASON_TYPE
    PublicDefine.ATTR_CHANGE_STYLE = ATTR_CHANGE_STYLE
    PublicDefine.EFFECTED_REASON_TYPE = EFFECTED_REASON_TYPE
    PublicDefine.BUFFER_TYPE = BUFFER_TYPE
    PublicDefine.DelusionType = DelusionType
    PublicDefine.GOODS_RARE = GOODS_RARE
    PublicDefine.GOODS_TYPE = GOODS_TYPE
    PublicDefine.PACKET_TYPE = PACKET_TYPE
    PublicDefine.PACKET_SUB_TYPE = PACKET_SUB_TYPE
    PublicDefine.BOX_TYPE = BOX_TYPE
    PublicDefine.EQUIPMENT_TYPE = EQUIPMENT_TYPE
    PublicDefine.PET_EQUIPMENT_TYPE = PET_EQUIPMENT_TYPE
    PublicDefine.WEAPON_TYPE = WEAPON_TYPE
    PublicDefine.ITEM_TYPE = ITEM_TYPE
    PublicDefine.MATERIAL_TYPE = MATERIAL_TYPE
    PublicDefine.VIRTUAL_ITEM_TYPE = VIRTUAL_ITEM_TYPE
    PublicDefine.GemStoneType = GemStoneType
    PublicDefine.VALUE_TYPE = VALUE_TYPE
    PublicDefine.TEAM_MEMBER_STATUS = TEAM_MEMBER_STATUS
    PublicDefine.HERO_LOGIN_STATUS = HERO_LOGIN_STATUS
    PublicDefine.MonsterType = MonsterType
    PublicDefine.Camp = Camp

    PublicDefine.MonsterSubType = MonsterSubType
    PublicDefine.TaskType = TaskType
    PublicDefine.TaskTargetType = TaskTargetType
    PublicDefine.ESkillTargetType = ESkillTargetType
    PublicDefine.TaskStatus = TaskStatus
    PublicDefine.TargetType = TargetType
    PublicDefine.DisableSituation = DisableSituation
    PublicDefine.SkillUseCondition = SkillUseCondition
    PublicDefine.SkillRelatedFlag = SkillRelatedFlag
    PublicDefine.LuckyWheelType = LuckyWheelType
    PublicDefine.FunctionFlag = FunctionFlag
    PublicDefine.RankType = RankType
    PublicDefine.GreedyEvent = GreedyEvent
    
    PublicDefine.GuildTitle = GuildTitle
    PublicDefine.ContentTagType = ContentTagType
    PublicDefine.ContentTagTypeKey = ContentTagTypeKey
    PublicDefine.TagClickType = TagClickType
    PublicDefine.TagClickTypeKey = TagClickTypeKey
    PublicDefine.SkillVariationAffectType = SkillVariationAffectType
    PublicDefine.SkillLvChangeType = SkillLvChangeType
    PublicDefine.GuildAuctionState = GuildAuctionState
    PublicDefine.FixedItemIDs = FixedItemIDs

    PublicDefine.VERSION_PLATFORM = VERSION_PLATFORM
    PublicDefine.VERSION_TARGET = VERSION_TARGET
    PublicDefine.VERSION_CHANNEL = VERSION_CHANNEL
    PublicDefine.VERSION_ZONE = VERSION_ZONE
    PublicDefine.VERSION_ACCOUNT = VERSION_ACCOUNT
    PublicDefine.PURCHASE_CHANNEL = PURCHASE_CHANNEL
    PublicDefine.RankAmbit = RankAmbit
    PublicDefine.DROP_REASON_TYPE = DROP_REASON_TYPE
    PublicDefine.DELETE_GOODS_REASON_TYPE = DELETE_GOODS_REASON_TYPE

    PublicDefine.SHARE_MODULE = SHARE_MODULE
    PublicDefine.SHARE_CHANNEL = SHARE_CHANNEL
    PublicDefine.SHARE_CONTENT_TYPE = SHARE_CONTENT_TYPE

    PublicDefine.UnlockFunctionType = UnlockFunctionType
    PublicDefine.FunctionUnlockConditionType = FunctionUnlockConditionType

    PublicDefine.PURCHASE_PRODUCT_TYPE = PURCHASE_PRODUCT_TYPE
    PublicDefine.BattlePassIndex = BattlePassIndex

    PublicDefine.PurchaseLimitType =  PurchaseLimitType
    PublicDefine.PurchaseConditionType = PurchaseConditionType
    PublicDefine.ActivityType =  ActivityType
    PublicDefine.QuestConditionType = QuestConditionType
    PublicDefine.DiscountType = DiscountType
    PublicDefine.NetworkMode = NetworkMode
    PublicDefine.FUNCTION_RECORD_TYPE = FUNCTION_RECORD_TYPE
    PublicDefine.ActivityRunningStat = ActivityRunningStat
    PublicDefine.RunLampType = RunLampType
    PublicDefine.MailSubType = MailSubType
    PublicDefine.WebLogS3DelayType = WebLogS3DelayType
    PublicDefine.WebLogS3Type = WebLogS3Type
    PublicDefine.WebLogS3Type_Setting_Type = WebLogS3Type_Setting_Type
    PublicDefine.WebLogS3Type_Source_Type = WebLogS3Type_Source_Type
    PublicDefine.WebLogType = WebLogType
    PublicDefine.WebLogType_IapShop_PageOp_Type = WebLogType_IapShop_PageOp_Type
    PublicDefine.WebLogType_IapShop_Page_Type = WebLogType_IapShop_Page_Type
    PublicDefine.WebLogType_Activity_Type = WebLogType_Activity_Type
    PublicDefine.WebLogConfigChangeType = WebLogConfigChangeType
    PublicDefine.Config_Chat_Block = Config_Chat_Block
    PublicDefine.Config_Helmet_Hidden = Config_Helmet_Hidden
    PublicDefine.ContentFormatType = ContentFormatType
    PublicDefine.LoginStatus = LoginStatus
    PublicDefine.MailBindingSendMailStatus = MailBindingSendMailStatus
    PublicDefine.MailBindingVerifyStatus = MailBindingVerifyStatus
    PublicDefine.ChatMsgContentTextType = ChatMsgContentTextType
    PublicDefine.LoginLogType = LoginLogType
    PublicDefine.Hotfix_Error_Type = Hotfix_Error_Type
    PublicDefine.SPECIAL_EVENT_TYPE = SPECIAL_EVENT_TYPE
    PublicDefine.PurchaseCurrencyType = PurchaseCurrencyType
    PublicDefine.HeroCaveRefreshMode = HeroCaveRefreshMode
    PublicDefine.ChatChannelType = ChatChannelType
    PublicDefine.BanChatType = BanChatType
    PublicDefine.GemstoneBoughtCostType = GemstoneBoughtCostType
    PublicDefine.AdultType = AdultType
    PublicDefine.MAIL_REWARD_STATE = MAIL_REWARD_STATE
    PublicDefine.MainTalentType = MainTalentType
    PublicDefine.QuestionType = QuestionType
    PublicDefine.DreamTaskState = DreamTaskState
    PublicDefine.DreamTaskType = DreamTaskType
    PublicDefine.CostType = CostType
    PublicDefine.StarPrayDrawType = StarPrayDrawType
    PublicDefine.AdsPlaceId = AdsPlaceId
    PublicDefine.AdvertFuncType = AdvertFuncType
    PublicDefine.LuckyLotteryOptType = LuckyLotteryOptType
    PublicDefine.LuckyLotteryCostType = LuckyLotteryCostType
    PublicDefine.DistortedSpaceEventState = DistortedSpaceEventState
    PublicDefine.BattlePassAwardType = BattlePassAwardType
    PublicDefine.PetTalentType = PetTalentType
    PublicDefine.PetType = PetType
    PublicDefine.WritID = WritID
    PublicDefine.ErrNo = ErrNo
    PublicDefine.GuildAuctionConfig = GuildAuctionConfig
    PublicDefine.ITEM_ID = ITEM_ID
    PublicDefine.FunnyRecordType = FunnyRecordType
    PublicDefine.AreaProperty = AreaProperty
    PublicDefine.AreaStatus = AreaStatus
    PublicDefine.TradeActivityIDList = TradeActivityIDList
    PublicDefine.AlbumNotificationType = AlbumNotificationType
    PublicDefine.PetQualityType = PetQualityType
    PublicDefine.SomethingType = SomethingType
    PublicDefine.PlayerDecorateType = PlayerDecorateType
    PublicDefine.UseUIDecorateValue = UseUIDecorateValue
    PublicDefine.ManorBuildID = ManorBuildID
    PublicDefine.StoreType = StoreType
    PublicDefine.TimeLimitedTitle = TimeLimitedTitle
    PublicDefine.ActivityModeCaveType = ActivityModeCaveType
    PublicDefine.CustomRankType = CustomRankType
    PublicDefine.RankListSendType = RankListSendType
    PublicDefine.AnniversaryLuckyDrawSignType = AnniversaryLuckyDrawSignType
    PublicDefine.CurrencyPanelType = CurrencyPanelType
    PublicDefine.CommonShopType = CommonShopType
    PublicDefine.BigSailBoatStatus = BigSailBoatStatus
    PublicDefine.GlyphType = GlyphType
    PublicDefine.StarMapMosaicType = StarMapMosaicType
end

function PublicDefine:init()
    iniAttrType()
    refreshValue(PublicDefine.EObjectType, "EObjectType")
    refreshValue(PublicDefine.ContentFormatType, "ContentFormatType")
    refreshValue(PublicDefine.CONST_DEFINITION,"CONST_DEFINITION")
    refreshValue(PublicDefine.SCENE_TYPE,"SCENE_TYPE")
    refreshValue(PublicDefine.DUNGEON_ROOM_TYPE, "DUNGEON_ROOM_TYPE")
    refreshValue(PublicDefine.TRANS_DOOR_TYPE, "TRANS_DOOR_TYPE")
    refreshValue(PublicDefine.CAVE_MODE,"CAVE_MODE")
    refreshValue(PublicDefine.CAVE_DIFFICULTY,"CAVE_DIFFICULTY")
    refreshValue(PublicDefine.GAME_MODE,"GAME_MODE")
    refreshValue(PublicDefine.TRIGGER_NPC_TYPE,"TRIGGER_NPC_TYPE")
    refreshValue(PublicDefine.TRANS_POINT_TYPE, "TRANS_POINT_TYPE")
    refreshValue(PublicDefine.BOSS_SCENARIO_TYPE,"BOSS_SCENARIO_TYPE")
    refreshValue(PublicDefine.FUNCTION_TYPE,"FUNCTION_TYPE")  -- 这里不用和public_define 里面的定义关联了，由于protobuf 里面的枚举不支持 64 位数值导致。
    refreshValue(PublicDefine.HERO_SEX,"HERO_SEX")
    refreshValue(PublicDefine.SPRITE_STATUS,"SPRITE_STATUS")
    refreshValue(PublicDefine.ATTR_CHANGE_REASON_TYPE,"ATTR_CHANGE_REASON_TYPE")
    refreshValue(PublicDefine.ATTR_CHANGE_STYLE,"ATTR_CHANGE_STYLE")
    refreshValue(PublicDefine.EFFECTED_REASON_TYPE,"EFFECTED_REASON_TYPE")
    refreshValue(PublicDefine.BUFFER_TYPE,"BUFFER_TYPE")
    refreshValue(PublicDefine.GOODS_RARE,"GOODS_RARE")
    refreshValue(PublicDefine.GOODS_TYPE,"GOODS_TYPE")
    refreshValue(PublicDefine.PACKET_TYPE,"PACKET_TYPE")
    refreshValue(PublicDefine.PACKET_SUB_TYPE,"PACKET_SUB_TYPE")
    refreshValue(PublicDefine.BOX_TYPE,"BOX_TYPE")
    refreshValue(PublicDefine.EQUIPMENT_TYPE,"EQUIPMENT_TYPE")
    refreshValue(PublicDefine.PET_EQUIPMENT_TYPE,"PET_EQUIPMENT_TYPE")
    refreshValue(PublicDefine.WEAPON_TYPE,"WEAPON_TYPE")
    refreshValue(PublicDefine.ITEM_TYPE,"ITEM_FUN_TYPE")
    refreshValue(PublicDefine.VALUE_TYPE,"VALUE_TYPE")
    refreshValue(PublicDefine.TEAM_MEMBER_STATUS,"TEAM_MEMBER_STATUS")
    refreshValue(PublicDefine.HERO_LOGIN_STATUS,"HERO_LOGIN_STATUS")
    refreshValue(PublicDefine.MonsterType,"MonsterType")
    refreshValue(PublicDefine.Camp,"Camp")

    refreshValue(PublicDefine.MonsterSubType,"MonsterSubType")
    refreshValue(PublicDefine.TaskType,"TaskType")
    refreshValue(PublicDefine.TaskTargetType, "TaskTargetType")
    refreshValue(PublicDefine.ESkillTargetType, "ESkillTargetType")
    refreshValue(PublicDefine.TaskStatus,"TaskStatus")
    refreshValue(PublicDefine.TargetType, "TargetType")
    refreshValue(PublicDefine.DisableSituation,"DisableSituation")
    refreshValue(PublicDefine.SkillUseCondition,"SkillUseCondition")
    refreshValue(PublicDefine.SkillRelatedFlag,"SkillRelatedFlag")
    refreshValue(PublicDefine.DelusionType,"DelusionType")

    refreshValue(PublicDefine.VIRTUAL_ITEM_TYPE,"VIRTUAL_ITEM_TYPE")
    refreshValue(PublicDefine.GemStoneType, "GemStoneType")
    refreshValue(PublicDefine.FunctionFlag,"FunctionFlag")
    refreshValue(PublicDefine.RankType,"RankType")
    refreshValue(PublicDefine.GreedyEvent,"GreedyEvent")
    
    refreshValue(PublicDefine.GuildTitle,"GuildTitle")
    refreshValue(PublicDefine.SkillVariationAffectType, "SkillVariationAffectType")

    refreshValue(PublicDefine.SkillLvChangeType, "SkillLvChangeType")
    refreshValue(PublicDefine.FixedItemIDs, "FixedItemIDs")
    refreshValue(PublicDefine.RankAmbit, "RankAmbit")

    refreshValue(PublicDefine.DROP_REASON_TYPE, "DROP_REASON_TYPE")
    refreshValue(PublicDefine.DELETE_GOODS_REASON_TYPE, "DELETE_GOODS_REASON_TYPE")

    refreshValue(PublicDefine.UnlockFunctionType, "UnlockFunctionType")
    refreshValue(PublicDefine.FunctionUnlockConditionType, "FunctionUnlockConditionType")
    refreshValue(PublicDefine.ActivityType, "ActivityType")
    refreshValue(PublicDefine.QuestConditionType, "QuestConditionType")
    refreshValue(PublicDefine.DiscountType, "DiscountType")
    refreshValue(PublicDefine.ActivityRunningStat, "ActivityRunningStat")
    refreshValue(PublicDefine.MailSubType, "MailSubType")
    refreshValue(PublicDefine.RunLampType, "RunLampType")
    refreshValue(PublicDefine.WebLogS3DelayType,"WebLogS3DelayType")
    refreshValue(PublicDefine.WebLogS3Type,"WebLogS3Type")
    refreshValue(PublicDefine.WebLogS3Type_Setting_Type,"WebLogS3Type_Setting_Type")
    refreshValue(PublicDefine.WebLogS3Type_Source_Type,"WebLogS3Type_Source_Type")
    refreshValue(PublicDefine.WebLogType,"WebLogType")
    refreshValue(PublicDefine.WebLogType_IapShop_PageOp_Type,"WebLogType_IapShop_PageOp_Type")
    refreshValue(PublicDefine.WebLogType_IapShop_Page_Type,"WebLogType_IapShop_Page_Type")
    refreshValue(PublicDefine.WebLogType_Activity_Type,"WebLogType_Activity_Type")    
    refreshValue(PublicDefine.ChatMsgContentTextType,"ChatMsgContentTextType")
    refreshValue(PublicDefine.SPECIAL_EVENT_TYPE, "SPECIAL_EVENT_TYPE")
    refreshValue(PublicDefine.HeroCaveRefreshMode, "HeroCaveRefreshMode")
    refreshValue(PublicDefine.ChatChannelType, "ChatChannelType")
    refreshValue(PublicDefine.BanChatType, "BanChatType")
    refreshValue(PublicDefine.GemstoneBoughtCostType, "GemstoneBoughtCostType")
    refreshValue(PublicDefine.MainTalentType, "MainTalentType")

    refreshValue(PublicDefine.QuestionType, "QuestionType")
    refreshValue(PublicDefine.DreamTaskState, "DreamTaskState")
    refreshValue(PublicDefine.DreamTaskType, "DreamTaskType")
    refreshValue(PublicDefine.CostType, "CostType")
    refreshValue(PublicDefine.AdsPlaceId, "AdsPlaceId")
    refreshValue(PublicDefine.AdvertFuncType, "AdvertFuncType")
    refreshValue(PublicDefine.PetTalentType, "PetTalentType")
    refreshValue(PublicDefine.ErrNo, "ErrNo")
    refreshValue(PublicDefine.ITEM_ID, "ITEM_ID")
    refreshValue(PublicDefine.FunnyRecordType, "FunnyRecordType")
    refreshValue(PublicDefine.TradeActivityIDList, "TradeActivityIDList")
end

PublicDefine:initLocal()