
--[[
    英雄属性定义
]]
local MapDefine = require "app.mapkit.MapDefine"
require "app.datas.role.RoleData"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
local ATTR_TYPE = PublicDefine.ATTR_TYPE
local CAVE_MODE = PublicDefine.CAVE_MODE
local FunctionFlag = PublicDefine.FunctionFlag
local DelusionType = PublicDefine.DelusionType

-- local SkillUseCondition = PublicDefine.SkillUseCondition
-- local SkillRelatedFlag = PublicDefine.SkillRelatedFlag

local DEBUG = false

local HeroDataAttr = class("HeroDataAttr")

local ChangeType = {
    CHANGE_NORMAL = 1;    -- 普通比例
    CHANGE_EQUIPMENT = 2; -- 穿戴装备
    CHANGE_SKILL = 3;     -- 装备技能
}

function HeroDataAttr:ctor(attrType)
    -- TODO 添加的测试参数
    self._attrType = attrType

    self:reset()
end

function HeroDataAttr:changeValue(changeType,changeValue)
    -- 根据类型来处理是修改的类型
    self._changeValueArr[changeType] = self._changeValueArr[changeType] + changeValue
    self._changeAllValue = self._changeAllValue + changeValue
    if DEBUG then
        -- TODO 测试日志
        if self._attrType == ATTR_TYPE["atkSpd"] then
            -- print("HeroDataAttr:changeValue(changeType,changeValue)   wwwwwwwwwwwwwww  _changeAllValue=",self._attrType,changeType,changeValue,self._changeAllValue)
        end
    end
end

function HeroDataAttr:getAllPercent()
    return self._changeAllValue
end

-- 充值数据
function HeroDataAttr:reset()
    self._changeAllValue = 0
    -- 记录所有改变数值
    self._changeValueArr = {}

    -- 初始化值
    for k,v in pairs(ChangeType) do
        self._changeValueArr[v] = 0
    end
end


local HeroData = class("HeroData",Data.RoleData)

Data = Data or {}
Data.HeroData = HeroData  

-- 英雄移动速度默认值
-- local heroMoveSpeedDefault = 1000
local heroMoveSpeedDefault = 0


-- 构造函数(会自动调用)  
-- 外界构造时可以传任意参数XXX.new(...)  
function HeroData:ctor()
    HeroData.super.ctor(self, RoleType.Hero)
    -- 比例属性列表
    self._attrPercentArr = {}
    self.boxCanBeUsedNum = 0
    self.warehouseCanBeUsedNum = 0
    self.boxCanBeUsedNumItem = 0
    self.warehouseCanBeUsedNumItem = 0
    self.rescuedDungeonSurvivorCount = 0
    self.supplyReceiveDay = 0
    self.monthCardDay = 0
    -- 存档点列表
    self.checkpointArr = {}
    --
    self.caveIndexArr = {}
    -- 最大楼层
    self.maxLevelArr = {}
    -- 解锁状态
    self.unlockCaveArr = {}
    -- 已经购买的钻石商品ID 列表
    -- self.diamondProductPurchase = {}
    -- 已经购买过的钻石商品ID列表
    self.diamondRecords = {}
    self._isEscape = false
    self.advanceStat = 0
    self.horcruxExteriorId = 0
    self.infernoReviveNum = 0;
    self.voidRiftReviveNum = 0
    self.viKingReviveNum = 0

    self.portalEffect = 0
    
    self.reincarntionLv = 0

    self.starPatternLevel = 0 --当前装备星盘的等级增幅, 用于查看好友或者排行榜玩家使用.

    self:init({})
end  

-- 设置是否为主角
function HeroData:setMaster(masterFlag)
    self.isMaster = masterFlag
end

-- 获取角色唯一ID
function HeroData:getPK()
    -- print("HeroData:getPK",self.pk)
    return self.pk
end

-- 模版函数：
function HeroData:getId()
    -- 这里需要返回一个指定值
    
	return self.pk
end

-- 获取英雄英雄称号ID
function HeroData:getHeroTitleID()
    return self.heroTitle
end
-- 获取下次可以进入洞窟的时间
function HeroData:getNextConfineEnterCaveTime()
    return self.nextConfineEnterCaveTime
end
-- 获取当日在线总时长
function HeroData:getOnlineTime()
    return self.onlineTime
end

function HeroData:getJoinGuildTime()
    return self.joinGuildTime
end

-- 获取当前金币数量
function HeroData:getCurCoin()
    return self.curCoin
end

function HeroData:getDiamond()
    return self.curDiamond
end

function HeroData:getAreaID()
    return self.areaId
end

-- 模版函数：
function HeroData:isReachable()
    
    return true
end

function HeroData:canBeNodeOfPath()
    return true
end

function HeroData:canBeEndOfPath()
	return true
end

-- 获取性别
function HeroData:getSex()
    -- print("HeroData:getSex",self.sex)
    return self.sex
end

function HeroData:setSex(value)
    self.sex = value
    -- print("HeroData:setSex",value)

    self:conbinationLocalData()
end

-- 获取刷新天数
function HeroData:getRefreshDay()
    return self.refreshDay
end

-- 获取动画配置数据
function HeroData:getAnimationData()
    return self.skeleton, self.atlas, self.scale
end

-- 获取
function HeroData:getTownChannelID()
    return self.townChannelID
end

-- 设置等级
function HeroData:setLevel(roleLV)
    if self.roleLV == roleLV then
        return
    end
    self.roleLV = roleLV
    self:conbinationLocalData()
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, RoleDataManager:getCaptain())--RoleDataManager:getScreenFightPetData())
    -- local pets = RoleDataManager:getCaptain()
    local pets = MasterDataManager:getCaptainPet()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, pets)
end

-- 获取等级
function HeroData:getLevel()
    return self.roleLV
end

-- 设置当前经验
function HeroData:setCurLVExp(curLVExp)
    self.curLVExp = curLVExp
end

-- 设置昵称
function HeroData:setNickName(nickName)
    self.nickName = nickName
    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)
end

-- 获取名字
function HeroData:getNickName()
    -- add by zp CO-14453【改名】IOS玩家可以改名将名字换行竖名显示
    return ToolsUtil:replaceShowNickNameStr(self.nickName)
    -- return self.nickName
end

-- 攻击强度
function HeroData:getAttackStrength()
    return self.attackPower
end

-- 法术效果
function HeroData:getSpellEffect()
    return self.magicEffect
end

-- 坚韧
function HeroData:getTough()
    return self.toughness
end

function HeroData:setIsEscape(isEscape)
    self._isEscape = isEscape
end

function HeroData:getIsEscape()
    return self._isEscape
end

function HeroData:setEnterCaveCoin(coin)
    self.enterCaveCoin = coin
end

function HeroData:getEnterCaveCoin()
    return self.enterCaveCoin
end

function HeroData:setEnterCaveInscription(inscription)
    -- self.enterCaveInscription = inscription
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    globalUserData:setEnterCaveInscription(inscription)
end

function HeroData:getEnterCaveInscription()
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    return globalUserData:getEnterCaveInscription()
    -- return self.enterCaveInscription
end

function HeroData:getIsMaxLevel()
    -- local maxLevel = tonumber(ConfigManager:getGeneralForKey("heroMaxLevel"))
    local reincarntionLv = self.reincarntionLv or 0
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
    local maxLevel = config.roleLevelCap

    if(self.roleLV == maxLevel) then
        return true
    end

    return false
end

--
function HeroData:getCombatScore()
    -- -- 根据穿戴的所有装备获取数据
    -- local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(self.spriteID)

    -- local allEquipArr = wearData.wearEquipmentArr
    -- -- print("HeroData:getCombatScore() ")
    -- local combatScore = 0
    -- for k,equipmentData in ipairs(allEquipArr) do
    --     combatScore = combatScore + equipmentData:getCombatScore()
    --     -- print("HeroData:getCombatScore() num,total=" +equipmentData:getCombatScore(),combatScore)
    -- end

    -- return combatScore


    return self.equipScore
end

-- 获取穿戴重量
function HeroData:getWeight()
    -- 根据穿戴的所有装备获取数据
    local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(self.spriteID)

    local allEquipArr = wearData.wearEquipmentArr
    local weight = 0
    for k,equipmentData in ipairs(allEquipArr) do
        weight = weight + equipmentData:getWeight()
    end

    return weight
end

-- 获取负重
function HeroData:getWeightCapacity()
    -- 获取负重

    return self.weightCapacity
end

-- 获取所有得技能点
function HeroData:getTotalSkillPoints()
    return self.totalSkillPoints
end

-- 获取下次获取技能点数的等级, nil为不能再获取技能点了
function HeroData:getLevelToGetNextSkillPoint()
    local heroDataConfig = ConfigManager:getHeroConfig(self.sex, self.roleLV)
    if not heroDataConfig then return end
    local nowSkillPoints = heroDataConfig.totalSkillPoints

    local targetHeroDataConfig = heroDataConfig
    local targetLv = self.roleLV
    local targetTotalSkillPoints = nowSkillPoints
    while (targetHeroDataConfig and targetTotalSkillPoints == nowSkillPoints) do
        targetLv = targetLv + 1
        targetHeroDataConfig = ConfigManager:getHeroConfig(self.sex, targetLv)
        targetTotalSkillPoints = targetHeroDataConfig and targetHeroDataConfig.totalSkillPoints or 0
    end

    if (targetHeroDataConfig) then
        return targetLv, targetTotalSkillPoints
    else
        return nil
    end
end

-- 获取复活需要的钻石
function HeroData:getReviveUseDiamond()
    local increaseDiamond = tonumber(ConfigManager:getGeneralForKey("eachReviveIncreaseCostDiamond"))
    local maxReviveDiamond = tonumber(ConfigManager:getGeneralForKey("reviveCostDiamondMax"))

    local totalDiamond = increaseDiamond * (self.onceExploreDeadTimes + 1)
    if(totalDiamond > maxReviveDiamond) then
        totalDiamond = maxReviveDiamond
    end

    return totalDiamond
end

-- 模版函数：
function HeroData:getType()
	return RoleType.Hero
end

function HeroData:init(data)
    self.pk = data.pk or -1
    -- 判断是否为主角
    self.isMaster = data.isMaster or false

    self.spriteID = data.spriteID or -1
    --昵称
    self.nickName = data.nickName or ""
    -- 当前所在公会的名字
    self.guildName = data.guildName or ""
    --性别
    if data.sex == nil then
        self.sex = PublicDefine.HERO_SEX.MALE
    else
        self.sex = data.sex
    end
    --移动属性
    self.moveSpeed = data.moveSpeed or heroMoveSpeedDefault
    -- 脸型编码值
    self.faceDecodeID = data.faceDecodeID or 3010101
    -- 穿戴选中页码
    self.selectShortcutEquipPage = 1
    -- 公会ID
    self.guildID = 0
    -- 用户ID， 每次登陆都会变
    self.userID = 0
    -- 称号数据
    self.heroTitle = data.heroTitle or 0
    -- 下次可以进入洞窟的时间
    self.nextConfineEnterCaveTime = checkint(data.nextConfineEnterCaveTime)
    -- 当日已经在线时长(会根据配置表刷新) 服务器返回的毫秒
    self.onlineTime = 0
    self.joinGuildTime = 0
    self.dailyTalentBook = 0
    self.advanceStat = data.advanceStat or 0
    self.firstChargeStat = -1        --首充状态
    -- self.onlineTime = 275*60;
    self:clear()

    self.maxDungeonLevelAndMinTimeForSeason = data.maxDungeonLevelAndMinTimeForSeason or 0 --大秘境赛季最大到达的楼层和最短消耗时间,赛季结束后清零   
    self.hasReceivedDungeonSeasonReward = data.hasReceivedDungeonSeasonReward or false --是否领取大秘境赛季奖励;

    self.CrystalTreasureHuntDailyDrawCount = 0;                 -- 水晶夺宝：今日抽取次数
    self.CrystalTreasureHuntTotalDrawCount = 0;                 -- 水晶夺宝：累计抽取次数
    self.CrystalTreasureHuntLuckDraw = 0;                       -- 水晶夺宝：是否内圈抽奖
    self.CrystalTreasureHuntStageID = 0;                        -- 水晶夺宝：已领取阶段奖励

    self.DungeonExpFightNum = 0;                        -- 经验副本战斗次数
    self.Chaosfightnum      = 0                         -- 混沌虫洞精英挑战次数
    self.Chaosfightextranum = 0                         -- 混沌虫洞精英挑战额外增加次数

    self.Inscription = 0                                -- 铭文

    -- self.WromholeNum      = 0                           -- 虫洞深处挑战次数
    -- self.WromholeExtraNum = 0                           -- 虫洞深处额外挑战次数

    self.UseStarPlate = 0;                    --当前使用星盘id
    self.UnlockStarPlateInfo = 0;                 -- 已解锁星盘(id左移)

    self.enterCaveInscription = 0 --初始化进入洞窟时的铭文数量

    self:conbinationLocalData()
    self:refreshCurInitData()
    self:_AttributeConversion()
end

function HeroData:clear()
    --等级
    self.roleLV = 1

    self.curCoin = 0
    self.curLVExp = 0
    self.diamond = 0

    --当前生命值
    self.curHp = 0
    --生命值
    self.hp = 0
    --当前魔法值
    self.curMp = 0
    --魔法值
    self.mp = 0

    self.enterCaveCoin = 0
    -- 当前钻石
    self.curDiamond = 0
    -- 刷新天数
    self.refreshDay = 0
    -- 复活次数
    self.onceExploreDeadTimes = 0
    
    self.isExpeditionRun = false

    self.boxCanBeUsedNum = 0   
    self.warehouseCanBeUsedNum = 0
    self.unlockBagTimes = 0
    self.unlockWarehouseTimes = 0   
    self.unlockBagTimesItem = 0
    self.unlockWarehouseTimesItem = 0   
    self.maxDungeonLevelAndMinTimeForSeason = 0

    self.equipScore = 0
    self.guildMedal = 0            -- 公会勋章
    self.guildContrib = 0          -- 个人公会贡献
    self.guildID = 0               -- 所属公会ID
    self.guildTaskDailyFinishNum = -1   -- 公会任务每日完成数
    self.dailyLimitTaskAcceptNum = -1
    self.heroCaveTaskDailyAcceptNum = -1 --英雄模式日常完成数
    self.rewardDungeonLevel = 0    --待奖励的大秘境关卡记录，组合字段，包含上次大秘境到达的层数和是否击杀BOSS

    self.strengthenExtraRate = 0        --强化额外成功几率（万分比）
    self.goldenGoodsDiscountRate = 0    --金币商品折扣率（万分比）

    self:clearAllAttr()

    self.coordX = 0
    self.coordY = 0
    self.townChannelID = 0            -- 当前城镇频道ID
    self.dungeonLoftLevel = 0
    self.maxDungeonLevelAndMinTimeForSeason = 0 --大秘境赛季最大到达的楼层和最短消耗时间,赛季结束后清零   
    self.hasReceivedDungeonSeasonReward = false --是否领取大秘境赛季奖励;
    self.functionUnlockStat = nil   --系统解锁标志
    self.functionUnlockStatMap = {}

    self.residualEscapeTime = 0    -- 逃跑剩余时间
    self.starPrayPool = nil   --//星痕奖池索引

    self.horcruxTransformID = 0            --// ~=0:魂器变身中
    self.maxLevelData = {}  --最大楼层记录（不回档的）
    self.createTime = 0                --角色创建时间
    self.lastPurchaseTime = 0;         --上次充值时间
    self.lastOffLineTime = 0;          --上次离线时间
    self.heroCaveStageMaxLevel = {}    -- 
    self.titanHeroCaveStageMaxLevel = {}    -- 
    self.infernoReviveNum = 0;
    self.voidRiftReviveNum = 0
    self.viKingReviveNum = 0

    self.MarblesFeverHoodle = 0;                       -- 反斗乐：弹珠
    self.MarblesFeverLuckyPoint = 0;                   -- 反斗乐：幸运值
    self.MarblesFeverDrawCount = 0;                    -- 反斗乐：今日抽取次数

    self.LimitedMarblesFeverLuckyPoint = 0;         -- 限时反斗乐：幸运值
    self.LimitedMarblesFeverDrawCount = 0;          -- 限时反斗乐：已抽取次数


    self.reincarntionLv = 0;            -- 转生等级 
	self.CrystalTreasureHuntDailyDrawCount = 0;                 -- 水晶夺宝：今日抽取次数
    self.CrystalTreasureHuntTotalDrawCount = 0;                 -- 水晶夺宝：累计抽取次数
    self.CrystalTreasureHuntLuckDraw = 0;                       -- 水晶夺宝：是否内圈抽奖
    self.CrystalTreasureHuntStageID = 0;                        -- 水晶夺宝：已领取阶段奖励

    self.DungeonExpFightNum = 0
    self.Chaosfightnum = 0
    self.Chaosfightextranum = 0
    self.Inscription = 0        -- 铭文

    self.LimitedMarblesFeverLuckyPoint2 = 0;         -- 限时反斗乐：幸运值

    -- self.WromholeNum = 0                                -- 虫洞深处挑战次数
    -- self.WromholeExtraNum = 0                          -- 虫洞深处挑战额外增加次数

    self.enterCaveInscription = 0


    self.UseStarPlate = 0 --当前出战的星盘ID
    self.UnlockStarPlateInfo = 0 --当前解锁的星盘情况 以二进制表达
end

function HeroData:isHorcruxTransform()
    return self.horcruxTransformID ~= 0
end

function HeroData:clearAllAttr()
    -- -- --攻击力
    -- -- self.atk = data.atk or 0
    --最小攻击力 
    self.atkMin = 0
    --最大攻击力
    self.atkMax = 0
    -- --攻击速度
    self.atkSpd = 1000
    --防御
    self.physicDef = 0
    --魔法防御
    self.magicDef = 0
    --闪避等级
    self.dodge = 0
    --魔力
    self.magic = 0

    --火属性伤害
    self.atkFire = 0
    --水属性伤害
    self.atkWater = 0
    --木属性伤害
    self.atkWood = 0
    --光属性伤害
    self.atkLight = 0
    --暗属性伤害
    self.atkDark = 0

    --火属性防御力
    self.defFire = 0
    --水属性防御力
    self.defWater = 0
    --木属性防御力
    self.defWood = 0
    --光属性防御力
    self.defLight = 0
    --暗属性防御力
    self.defDark = 0

    --暴击等级
    self.critical = 0
    --防御穿透
    self.physicPenetrate = 0
    --魔法穿透
    self.magicPenetrate = 0
    --幸运
    self.luck = 0
    -- 成就点
    self.achievementPoint = 0
    --梦境碎片
    self.dreamChip = 0
    --魂器
    self.horcruxCoin = 0
    --航行币
    self.SailGold = 0
    --航海钻石
    self.SailDiamond = 0
    --符文洞窟积分币
    self.GemBoughtCredit = 0
    --每周累计梦境碎片
    self.weeklyDreamChip = 0
    --战斗通行证的货币
    self.battlePassCoin = 0
    --周年币
    self.AnniversaryCoin = 0
    --探宝钥匙
    self.TreatureHuntOpenItem = 0

    self.HPRecoverRate = 0;
    self.MPRecoverRate = 0;
    self.CritDamageRate = 0;
    self.MagicDamageRate = 0;
    self.MagicReductionRate = 0;
    self.PhysicDamageRate = 0;
    self.PhysicReductionRate = 0;
    self.ElementDamageRate = 0;
    self.ElementReductionRate = 0;
    self.FireDamageRate = 0;
    self.FireReductionRate = 0;
    self.WaterDamageRate = 0;
    self.WaterReductionRate = 0;
    self.WoodDamageRate = 0;
    self.WoodReductionRate = 0;
    self.LightDamageRate = 0;
    self.LightReductionRate = 0;
    self.DarkDamageRate = 0;
    self.DarkReductionRate = 0;

    self.block = 0

    self.functionFlag = 0
    self.looks = 0
    self.extraLooks = 0
    self.delusion = 0
    self.isReviveFree = 0     --复活是否免费 0 表示付费 1 表示免费
    self.FirstReviveFree = 0  -- 第一次复活
    self.horcruxTransformID = 0            --// ~=0:魂器变身中
    self.maxLevelData = {}  --最大楼层记录（不回档的）
    self.createTime = 0                --角色创建时间
    self.lastPurchaseTime = 0;         --上次充值时间
    self.lastOffLineTime = 0;          --上次离线时间
    self.heroCaveStageMaxLevel = {}
    self.titanHeroCaveStageMaxLevel = {}   
    self.petHpPool = 0

    self.MaxFishingTime = 0

    --周年币2
    self.AnniversaryCoin2 = 0

    self.DailyGlyphComposeNum = 0
    self.WromholeWeekVirtualNum = 0

    self.PrimogeDebris = 0
    self.PrimogeDebris2 = 0

    self.UseStarPlate = 0;                    --当前使用星盘id
    self.UnlockStarPlateInfo = 0;                 -- 已解锁星盘(id左移)

    self.PrimogeDebrisGreen = 0;
    self.SouvenirLevelUp = 0;
    self.SouvenirLevelUp2 = 0;

    self.TrialLevelUp = 0;


    self.ExpCaveTimes = 0
end

function HeroData:updateNormal(spriteID,coordX,coordY,townChannelID)
    if spriteID then
        self.spriteID = spriteID
    end
    if coordX then
        self.coordX = coordX
    end
    if coordY then
        self.coordY = coordY
    end
    if(townChannelID) then
        self.townChannelID = townChannelID
    end
end

-- 模板函数
function HeroData:refreshCurInitData()
    self.curHp = self.hp or 0
    self.curMp = self.mp or 0
end

function HeroData:conbinationLocalData()
    -- 检测是否操作了最大配置等级
    -- local maxLevel = tonumber(ConfigManager:getGeneralForKey("heroMaxLevel"))
    local reincarntionLv = self.reincarntionLv or 0 
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
    local maxLevel = config.roleLevelCap

    if self.roleLV > maxLevel then
        self.roleLV = maxLevel
    end

    local heroDataConfig = ConfigManager:getHeroConfig(self.sex,self.roleLV)
    if heroDataConfig then
        self:setLocalConfigData(heroDataConfig)
    -- else
    --     -- 处理对于等级超过配置问题
    --     local level = self.roleLV
    --     if level <= 0  then
    --         level = 1
    --     end

    --     local heroDataConfig = nil
    --     repeat 
    --         heroDataConfig = ConfigManager:getHeroConfig(self.sex,level)
    --         if heroDataConfig then
    --             self:setLocalConfigData(heroDataConfig)
    --         else
    --             level = level -1
    --             if level <= 0 then
    --                 break
    --             end
    --         end
    --     until heroDataConfig ~= nil
    end
    -- print("HeroData:conbinationLocalData",self.sex,self.skeleton, self.atlas, self.scale)
end

function HeroData:changeInit(data)
    if type(data) ~= "table" then
        return
    end

    -- print("  dadadadada ===== ",data)

    self:startUpdateAttr()
    for k,v in pairs(data) do 
        if type(v) ~= "table" then
            self[k] = v
        else 
            self[k] = v
            --TODO 处理table属性的处理
        end
    end
    -- print("self.onlineTime",self.onlineTime)
    --脸型初始化
    if self.faceDecodeID == nil or self.faceDecodeID == 0 then
        self.faceDecodeID = 3010101
    end
    -- 强制赋值
    self:endUpdateAttr()
    self:conbinationLocalData()
end

function HeroData:initCheckpoint(data)

    self.checkpointArr = {}
    self:updateAllCheckPoint(data)
end

function HeroData:updateAllCheckPoint(data)
    for k,checkPointData in ipairs(data) do
        self:updateCheckPoint(checkPointData)
    end
end

function HeroData:updateCheckPoint(checkPointData)
    local found = false
    for k,oldPointData in pairs(self.checkpointArr) do
        if (oldPointData:getMode() == checkPointData.caveMode and oldPointData:getDifficulty() == checkPointData.caveDifficulty) then
            oldPointData:initNet(checkPointData)
            found = true
            break
        end
    end
    if (found == false ) then
        -- 生成数据
        local checkData = Data.CheckpointData:create()
        checkData:initNet(checkPointData)

        table.insert(self.checkpointArr,checkData)
    end
end

function HeroData:unlockCheckPoint(caveMode, caveDifficulty)
    for k,oldPointData in pairs(self.checkpointArr) do
        if (oldPointData:getMode() == caveMode and oldPointData:getDifficulty() == caveDifficulty) then
            oldPointData:unlockCheckPoint()
            break
        end
    end
end

function HeroData:initCaveIndex(data)
    self.caveIndexArr = {}
    self:updateAllCaveIndex(data)
end

function HeroData:updateAllCaveIndex(data)
    for k,caveIndexData in ipairs(data) do
        self:updateCaveIndex(caveIndexData)
    end
    self._allCaveIndexArr = nil
end

function HeroData:updateCaveIndex(caveIndexData)
    local found = false
    for k,oldPointData in pairs(self.caveIndexArr) do
        if (oldPointData:getMode() == caveIndexData.caveMode and oldPointData:getDifficulty() == caveIndexData.caveDifficulty) then
            oldPointData:initNet(caveIndexData)
            found = true
            break
        end
    end
    if (found == false ) then
        -- 生成数据
        local checkData = Data.CaveIndexData:create()
        checkData:initNet(caveIndexData)

        table.insert(self.caveIndexArr,checkData)
    end
    self._allCaveIndexArr = nil
end

function HeroData:getAllCaveIndexArr()
    local arr = {}
    if(self.caveIndexArr) then 
        for _, caveIndexData in ipairs(self.caveIndexArr) do 
            local indexArr = caveIndexData:getCaveIndexArr()
            if(indexArr) then 
                for k, v in pairs(indexArr) do 
                    arr[k] = v
                end
            end
        end
    end
    return arr
end

function HeroData:checkCaveIndex(sceneID)
    if(sceneID == nil) then 
        return false
    end

    if(self._allCaveIndexArr == nil) then 
        self._allCaveIndexArr = self:getAllCaveIndexArr()
    end

    if(self._allCaveIndexArr) then 
        -- 判断英雄模式是否解锁了，如果解锁了，所有英雄模式下的都默认解锁
       if(RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)) then 
            if(sceneID < 20000) then 
                return true
            end
        end 

        if(self._allCaveIndexArr[sceneID]) then 
            return true
        end
    end 

    return false
end

function HeroData:initProductPurchase(data)
    -- self.diamondProductPurchase = {}
    self.diamondRecords = {}
    -- for k,v in ipairs(data) do 
    --     table.insert(self.diamondProductPurchase, v)
    -- end
    for k,v in pairs(data) do
        table.insert(self.diamondRecords, v)
        

    end
end

function HeroData:setOnceExploreDeadTimes(onceExploreDeadTimes)
    self.onceExploreDeadTimes = onceExploreDeadTimes
end

function HeroData:getTitanHeroCaveStageMaxLevelForCheckPoint(checkPoint)
    local cp = (checkPoint - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN)/3 + 1
    if(self.titanHeroCaveStageMaxLevel[cp]) then
        return self.titanHeroCaveStageMaxLevel[cp]
    else 
        return 0
    end
end

function HeroData:updateAllTitanHeroCaveStageMaxLevel(data)
    if(data) then 
        self.titanHeroCaveStageMaxLevel = data
    end
end

function HeroData:updateTitanHeroCaveStageMaxLevel(level)
    if(level) then 
        local checkpoint = math.floor(level / HERO_INTERVAL) + 1
        self.titanHeroCaveStageMaxLevel[checkpoint] = level
    end
end

function HeroData:getHeroCaveStageMaxLevelForCheckPoint(checkPoint)
    local cp = (checkPoint - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN)/3 + 1
    if(self.heroCaveStageMaxLevel[cp]) then
        return self.heroCaveStageMaxLevel[cp]
    else 
        return 0
    end
end

function HeroData:updateAllHeroCaveStageMaxLevel(data)
    if(data) then 
        self.heroCaveStageMaxLevel = data
    end
end

function HeroData:updateHeroCaveStageMaxLevel(level)
    if(level) then 
        local checkpoint = math.floor(level / HERO_INTERVAL) + 1
        self.heroCaveStageMaxLevel[checkpoint] = level
    end
end

function HeroData:initMaxLevel(data, noBackData, heroMaxData)
    self.maxLevelArr = {}
    self:updateMaxLevel(data, noBackData)
    self:updateHeroMaxLevel(heroMaxData)
end

function HeroData:updateMaxLevel(data, noBackData)
    -- print("HeroData:updateMaxLevel", data)
    -- dump(data)
    for k,maxData in ipairs(data) do
        local found = false
        for k,oldPointData in pairs(self.maxLevelArr) do
            if (oldPointData:getMode() == maxData.caveMode and oldPointData:getDifficulty() == maxData.caveDifficulty) then
                oldPointData:initNet(maxData)
                found = true
                break
            end
        end
        if (found == false ) then
            -- 生成数据
            local maxLevelData = Data.MaxLevelData:create()
            maxLevelData:initNet(maxData)
            table.insert(self.maxLevelArr,maxLevelData)
        end
    end 

    for k,maxData in ipairs(noBackData) do
        local found = false
        for k,oldPointData in pairs(self.maxLevelArr) do
            if (oldPointData:getMode() == maxData.caveMode and oldPointData:getDifficulty() == maxData.caveDifficulty) then
                oldPointData:setNoBackMaxLevel(maxData.maxLevel)
                found = true
                break
            end
        end
        if (found == false ) then
            local maxLevelData = Data.MaxLevelData:create()
            maxLevelData:initNet(maxData)
            maxLevelData:setMaxLevel(0)
            table.insert(self.maxLevelArr,maxLevelData)
        end
    end 
end

function HeroData:updateHeroMaxLevel(data)
    -- print("---updateHeroMaxLevel----", data)
    for k, maxLevel in ipairs(data) do
        local levelId = (k - 1) * HERO_INTERVAL + 1
        local found = false
        for k,oldPointData in pairs(self.maxLevelArr) do
            if (oldPointData:getMode() == PublicDefine.CAVE_MODE.MODE_HERO and oldPointData:getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 and oldPointData:getLevelId() == levelId) then
                oldPointData:setNoBackMaxLevel(maxLevel)
                found = true
                break
            end
        end
        if (found == false ) then
            local data = {}
            data.caveMode = PublicDefine.CAVE_MODE.MODE_HERO
            data.caveDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
            data.maxLevel = maxLevel
            local maxLevelData = Data.MaxLevelData:create()
            maxLevelData:initNet(data)
            maxLevelData:setLevelId(levelId)
            table.insert(self.maxLevelArr,maxLevelData)
        end

        local titanFound = false
        for k,oldPointData in pairs(self.maxLevelArr) do
            if (oldPointData:getMode() == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO and oldPointData:getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 and oldPointData:getLevelId() == levelId) then
                oldPointData:setNoBackMaxLevel(maxLevel)
                titanFound = true
                break
            end
        end
        if (titanFound == false ) then
            local data = {}
            data.caveMode = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
            data.caveDifficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
            data.maxLevel = maxLevel
            local maxLevelData = Data.MaxLevelData:create()
            maxLevelData:initNet(data)
            maxLevelData:setLevelId(levelId)
            table.insert(self.maxLevelArr,maxLevelData)
        end
    end
end

function HeroData:initUnlockCave(data)
    -- print("HeroData:initUnlockCave data pre")
    -- -- dump(data)
    -- print("HeroData:initUnlockCave data end")

    self.unlockCaveArr = {}
    self:updateAllUnlockCave(data)
end

-- 获取日常获取书的处理，返回参数{是否屏蔽, 屏蔽的ID}
function HeroData:getBookDailyData()
    -- giftBookDailyLimit
    local giftBookDailyLimit = ConfigManager:getGeneralForKey("giftBookDailyLimit")
    if(giftBookDailyLimit) then 
        local dailyArr = string.split(giftBookDailyLimit, ";") --22070090;50
        local goodsID = tonumber(dailyArr[1])
        local goodsNum = tonumber(dailyArr[2])
        if(self.dailyTalentBook >= goodsNum) then 
            return true, goodsID
        end 
    end

    return false, 0
end

function HeroData:updateAllUnlockCave(data)
    for k,unlockData in ipairs(data) do
        local found = false
        for k,unlockCaveData in pairs(self.unlockCaveArr) do
            if (unlockCaveData:getMode() == unlockData.caveMode and unlockCaveData:getDifficulty() == unlockData.caveDifficulty) then
                unlockCaveData:initNet(unlockData)
                found = true
                break
            end
        end
        if (found == false ) then
            -- 生成数据
            local unlockCaveData = Data.UnlockCaveData:create()
            unlockCaveData:initNet(unlockData)

            table.insert(self.unlockCaveArr, unlockCaveData)
        end
    end 
end

-- 更新模式难度解锁
function HeroData:updateUnclokCave(caveMode, difficulty)
    for k,unlockCaveData in pairs(self.unlockCaveArr) do
        if (unlockCaveData:getMode() == caveMode and unlockCaveData:getDifficulty() == difficulty) then
            unlockCaveData:setIsUnlock(true)

            -- 这里只有普通模式会处理
            if(caveMode == CAVE_MODE.MODE_NORMAL) then
                -- 强制解锁存档点
                self:unlockCheckPoint(caveMode, difficulty)
            end
        end
    end
end

function HeroData:setExpeditonStatus(expeditionStatus)
    self.isExpeditionRun = expeditionStatus
end

function HeroData:getExpeditionStatus()
    return self.isExpeditionRun
end

function HeroData:setReincarntionLv(lv)
    self.reincarntionLv = lv
end

function HeroData:getReincarntionLv()
    return self.reincarntionLv
end

function HeroData:getIsReincarntion()
    return self.reincarntionLv and self.reincarntionLv > 0
end

function HeroData:getUIShowLv()
    local reincarntionLv = self.reincarntionLv == 0 and self.reincarntionLv or self.reincarntionLv-1
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
    local maxLevel = self.reincarntionLv == 0 and 0 or config.roleLevelCap
    local showLv = self.roleLV - maxLevel
    
    return showLv, self.reincarntionLv
end

-- 根据条件获取存储点数据
function HeroData:getCheckpointData(caveMode, caveDifficulty)
    for k,oldPointData in pairs(self.checkpointArr) do
        if (oldPointData:getMode() == caveMode and oldPointData:getDifficulty() == caveDifficulty) then
            return oldPointData
        end
    end

    return nil
end

-- 获取玩家是否达到特定存档点
-- 策划规定模式和难度均以高的大于低的
function HeroData:getCheckpointIsOver(levelNumber)
    for k,maxLevelData in pairs(self.maxLevelArr) do
        local curLevelNum = GameDataManager:_handleMaxLevelGetGroupID(maxLevelData:getMode(), maxLevelData:getDifficulty()) or 0
        if curLevelNum >= tonumber(levelNumber) then
            printInfo("getCheckpointIsOver : " .. curLevelNum .. " : " ..levelNumber)
            return true
        end
    end

    return false
end

-- 根据条件获取最大楼层
function HeroData:getMaxLevelData(caveMode, caveDifficulty, levelId) 
    levelId = levelId == nil and 0 or levelId
    for k,maxLevelData in pairs(self.maxLevelArr) do
        if (maxLevelData:getMode() == caveMode and maxLevelData:getDifficulty() == caveDifficulty and maxLevelData:getLevelId() == levelId) then
            return maxLevelData
        end
    end
    return nil
end

-- 获取解锁状态数据
function HeroData:getUnlockCaveData(caveMode, caveDifficulty)
    for k,unlockCaveData in pairs(self.unlockCaveArr) do
        if (unlockCaveData:getMode() == caveMode and unlockCaveData:getDifficulty() == caveDifficulty) then
            return unlockCaveData
        end
    end

    return nil
end

-- 清理最大等级
function HeroData:clearMaxLevelData(caveMode, caveDifficulty)
    for k,maxLevelData in pairs(self.maxLevelArr) do
        if (maxLevelData:getMode() == caveMode and maxLevelData:getDifficulty() == caveDifficulty) then
            maxLevelData:setMaxLevel(0)
            maxLevelData:setNoBackMaxLevel(0)
            maxLevelData:setLevelId(0)
        end
    end
end

function HeroData:setHorcruxExteriorId(horcruxExteriorId)
    if(self.horcruxExteriorId ~= horcruxExteriorId) then 
        self.horcruxExteriorId = horcruxExteriorId
        local titleCommand = Command.BattleCommand:create(true)
        titleCommand:initTriggerHorcruxExterior(self.spriteID, self.horcruxExteriorId)
        SceneManager:getInstance():pushCommand(titleCommand)
    end
end

function HeroData:getHorcruxExteriorId()
    return self.horcruxExteriorId
end

-- 处理repeate 属性字段
function HeroData:handleAttr(attr)
    -- 恢复比例数据
    if attr then
        -- print("------------- HeroData:handleAttr ----------------")
        -- dump(attr)
        self:startUpdateAttr()

        for k,v in pairs(attr) do
            self:initAttrChange(v)
        end

        self:endUpdateAttr()
    end
end

function HeroData:attrChange(data)
    if DEBUG then
        -- dump(data)
    end

    if data.changeType ~= nil then
        local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY

        -- self[ATTR_TYPE_ID_KEY[data.changeType]] = self[ATTR_TYPE_ID_KEY[data.changeType]] + data.changeValue
        -- print("HeroData:attrChange ", data.changeType, data.resultValue)
        self[ATTR_TYPE_ID_KEY[data.changeType]] = data.resultValue
        -- if DEBUG then
        --     print("HeroData:attrChange(   %s=%d",ATTR_TYPE_ID_KEY[data.changeType],self[ATTR_TYPE_ID_KEY[data.changeType]])
        -- end

        -- 处理百分比的逻辑处理
        if data.changePercent ~= 0 then
            local ATTR_CHANGE_REASON_TYPE = PublicDefine.ATTR_CHANGE_REASON_TYPE

            local heroDataAttr = self._attrPercentArr[data.changeType]
            if heroDataAttr == nil then
                heroDataAttr = HeroDataAttr:create(data.changeType)
                self._attrPercentArr[data.changeType] = heroDataAttr
            end

            -- 解析原因
            local reasonTypeOne = ToolsUtil:splitAttrReason(data.changeReason)

            local changeType = ChangeType.CHANGE_NORMAL
            if reasonTypeOne == ATTR_CHANGE_REASON_TYPE.EQUIP_EQUIPMENT then
                changeType = ChangeType.CHANGE_EQUIPMENT
                
            -- TODO 添加其余的改变原因
            elseif reasonTypeOne == ATTR_CHANGE_REASON_TYPE.EQUIP_EQUIPMENT then
                changeType = ChangeType.CHANGE_EQUIPMENT
            end

            heroDataAttr:changeValue(changeType,data.changePercent)
        end

        -- 是否为需要刷新的背包消耗物品属性
        self:isRefreshBag(data)
    end
end

function HeroData:handleLooks(looksOld)
    print("HeroData now looks="..self.looks.."  oldlooks="..looksOld)
    -- -- 处理变形
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initHeroLooks(self.spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
    
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self.spriteID, self:getLooks())

    local petData = self:getCaptainPetData()
    if petData then
        petData:setLooks(var)
    end
end

function HeroData:handleDelusion(delusionOld)
    if (delusionOld ~= self.delusion and self:isMasterHero()) then
        Avalon.AudioManager:playSound("555")
        -- 处理幻境    
        if(delusionOld ~= DelusionType.DelusionType_None) then
            if(delusionOld == DelusionType.DelusionType_Rich or delusionOld == DelusionType.DelusionType_Insane) then
                local battleCMD = Command.BattleCommand:create(true)
                battleCMD:initItemDelusionRemove(self.spriteID, delusionOld)
                SceneManager:getInstance():pushCommand(battleCMD)

                -- 清理所有幻境缓存
                MasterDataManager:clearAllDeformation()
            elseif (delusionOld == DelusionType.DelusionType_Mental) then
                GameManager:stopMoveHandler()
                if(self:isMasterHero()) then
                    -- 移除该反转效果
                    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_HERO_CONFUSE, self:isConfuse())
                end
            end
        end

        if(self.delusion ~= DelusionType.DelusionType_None) then
            -- 这里如果在加载中就没有必要处理该逻辑，这样会导致一些表现没有同步到
            if SceneManager:getInstance():getIsInLoading() == false then
                if(self.delusion == DelusionType.DelusionType_Rich or self.delusion == DelusionType.DelusionType_Insane) then
                    local battleCMD = Command.BattleCommand:create(true)
                    battleCMD:initItemDelusionInit(self.spriteID, self.delusion)
                    SceneManager:getInstance():pushCommand(battleCMD)
                end
            end 
        end

        -- 发送相关的消息来控制氛围表现。
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FULL_ATOMOSPHERE, self.delusion)

        -- 触发环境氛围
        if (self.delusion == DelusionType.DelusionType_Mental) then
            GameManager:stopMoveHandler()
            if self:isMasterHero() then
                -- 移除该反转效果
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_HERO_CONFUSE, self:isConfuse())
            end 
        end
    end
end

function HeroData:changeGuildName(guildName) 
    self.guildName = guildName
    if(self.guildName == nil) then 
        self.guildName = ""
    end
end

function HeroData:changeGuildID(guildID) 
    self.guildID = guildID
end

function HeroData:getGuildID() 
    return self.guildID
end

function HeroData:getGuildName()
    if(self.guildName) then 
        return self.guildName
    end

    return ""
end

function HeroData:startUpdateAttr()
    self.userIDOld = self.userID
    self.oldLV = self.roleLV
    self.skillRelatedFlagOld = self.skillRelatedFlag
    self.functionFlagOld = self.functionFlag
    self.looksOld = self.looks
    self.extraLooksOld = self.extraLooks
    self.MaxFishingTimeOld = self.MaxFishingTime
    self.delusionOld = self.delusion
    self.guildMedalOld = self.guildMedal            -- 公会勋章
    self.guildContribOld = self.guildContrib          -- 个人公会贡献
    self.equipScoreOld = self.equipScore
    self.guildTaskDailyFinishNumOld = self.guildTaskDailyFinishNum
    self.dailyLimitTaskAcceptNumOld = self.dailyLimitTaskAcceptNum
    self.heroCaveTaskDailyAcceptNumOld = self.heroCaveTaskDailyAcceptNum
    self.isHideHelmetOld = self.isHideHelmet
    self.oldTotalSkillPoints = self.totalSkillPoints
    self.oldDailyTalentBook = self.dailyTalentBook
    self.horcruxExteriorIdOld = self.horcruxExteriorId

    self.oldAchievementPoint = self.achievementPoint
    self.blindOld = self:getIsBlind()
    self.curHpOld = self.curHp
    self.refreshDayOld = self.refreshDay
    self.isExpeditionRunOld = self.isExpeditionRun
    self.rescuedDungeonSurvivorCountOld = self.rescuedDungeonSurvivorCount
    self.oldFirstRecharge = self.firstChargeStat
    self.oldMonthCardDay = self.monthCardDay
    self.oldSupplyReceiveDay = self.supplyReceiveDay
    self.oldHeroTitle = self.heroTitle
    self.oldFunctionUnlockStat = self.functionUnlockStat
    self.oldDreamChip = self.dreamChip
    self.oldHorcruxCoin = self.horcruxCoin
    self.oldSailGold = self.SailGold
    self.oldSailDiamond = self.SailDiamond
    self.oldBattlePassCoin = self.battlePassCoin
    self.horcruxTransformIDOld = self.horcruxTransformID
    self.oldAnger = self.anger
    self.oldLoudSpeaker = self.loudSpeaker
    self.oldPetHpPool = self.petHpPool
    self.oldLifetimeCard = self.lifetimeCard
    self.oldLastLifetimeReward = self.lastLifetimeReward
    self.oldMonthSubscriptionEnd = self.monthSubscriptionEnd
    self.oldMonthSubscriptionEndAutoRenew = self.monthSubscriptionEndAutoRenew
    self.oldMonthSubscriptionClaimDay = self.monthSubscriptionClaimDay
    self.oldAnniversaryCoin = self.AnniversaryCoin
    self.oldGemBoughtCredit = self.GemBoughtCredit
    
    self.oldReincarntionLv = self.reincarntionLv
    self.oldCrystalTreasureHuntDailyDrawCount = self.CrystalTreasureHuntDailyDrawCount
    self.oldCrystalTreasureHuntTotalDrawCount = self.CrystalTreasureHuntTotalDrawCount
    self.oldCrystalTreasureHuntLuckDraw = self.CrystalTreasureHuntLuckDraw
    self.oldCrystalTreasureHuntStageID = self.CrystalTreasureHuntStageID

    self.oldDungeonExpFightNum = self.DungeonExpFightNum

    self.oldChaosfightnum = self.Chaosfightnum
    self.oldChaosfightextranum = self.Chaosfightextranum

    self.oldTreatureHuntOpenItem = self.TreatureHuntOpenItem

    self.oldAnniversaryCoin2 = self.AnniversaryCoin2

    self.oldInscription = self.Inscription

    self.oldDailyGlyphComposeNum = self.DailyGlyphComposeNum

    -- self.oldWromholeNum = self.WromholeNum
    -- self.oldWromholeExtraNum = self.WromholeExtraNum
    self.oldWromholeWeekVirtualNum = self.WromholeWeekVirtualNum

    self.oldPrimogeDebris = self.PrimogeDebris
    self.oldPrimogeDebris2 = self.PrimogeDebris2

    self.oldUseStarPlate = self.UseStarPlate
    self.oldUnlockStarPlate = self.UnlockStarPlateInfo

    self.oldExpCaveTimes = self.ExpCaveTimes

    self.oldDreamChip = self.dreamChip

    self.oldPrimogeDebrisGreen = self.PrimogeDebrisGreen
    self.oldSouvenirLevelUp = self.SouvenirLevelUp
    self.oldSouvenirLevelUp2 = self.SouvenirLevelUp2

    self.oldTrialLevelUp = self.TrialLevelUp
    
end

function HeroData:endUpdateAttr()
    -- 处理发送相关的消息
    -- 处理参数异常情况异常情况
    if(self.atkSpd < ATK_SPEED_MIN) then 
        self.atkSpd = ATK_SPEED_MIN
    end

    if(self.userIDOld ~= self.userID) then
        Game.ChatManager:getInstance():refreshPersonalUserID({pk=self.pk, userID=self.userID, nickName = self.nickName})
    end

    if (self.oldLV ~= self.roleLV) then
        self:conbinationLocalData()
    end

    -- if (self.oldReincarntionLv ~= self.reincarntionLv) then
    --     self:conbinationLocalData()
    -- end

    if(self.oldFunctionUnlockStat ~= self.functionUnlockStat) then 
        self:initFunctionUnlockMap()
    end

    if(self.oldAnger ~= self.anger) then 
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ROLE_ANGER_CHANGED, self.anger)
    end
    if(self.oldLoudSpeaker ~= self.loudSpeaker) then 
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ROLE_HORN_NUMBER, self.anger)
    end
    if(self.horcruxExteriorIdOld ~= self.horcruxExteriorId) then 
        local titleCommand = Command.BattleCommand:create(true)
        titleCommand:initTriggerHorcruxExterior(self.spriteID, self.horcruxExteriorId)
        SceneManager:getInstance():pushCommand(titleCommand)
    end

    if (self.horcruxTransformIDOld ~= self.horcruxTransformID) then
        
        if not self:isHorcruxTransform() then
            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
                local titleCommand = Command.BattleCommand:create(true)
                titleCommand:initTriggerHorcruxExterior(self.spriteID, self.horcruxExteriorId)
                SceneManager:getInstance():pushCommand(titleCommand)
            end, 1)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_HORCURX_TRANS_CHANGED, self.horcruxExteriorId)
    end

    if (self.oldHeroTitle ~= self.heroTitle) then
        local titleCommand = Command.BattleCommand:create(true)
        titleCommand:initForRoleTitle(self.spriteID)
        SceneManager:getInstance():pushCommand(titleCommand)
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_TITLE_CHANGE, self.heroTitle, self:getPK(), self:isMasterHero())
    end

    -- print("self.extraLooks ===== ",self.extraLooks, self.extraLooksOld, self.looks, self.looksOld, self:getPK())
    if(self.looksOld ~= self.looks or self.extraLooksOld ~= self.extraLooks) then
        if UI.UIManager.mMainUILayer and (not tolua.isnull(UI.UIManager.mMainUILayer)) then
            UI.UIManager.mMainUILayer:refreshTransBuffBtn()
        end
        self:handleLooks(self.looksOld)
    end

    local triggerTask = true
    if(triggerTask and self.guildTaskDailyFinishNum ~= self.guildTaskDailyFinishNumOld and self.guildTaskDailyFinishNumOld ~= -1) then
        TaskDataManager:triggerAcceptTask()
        triggerTask = false
    end

    if(triggerTask and self.dailyLimitTaskAcceptNum ~= self.dailyLimitTaskAcceptNumOld and self.dailyLimitTaskAcceptNumOld ~= -1) then
        TaskDataManager:triggerAcceptTask()
        triggerTask = false
    end

    if(triggerTask and self.heroCaveTaskDailyAcceptNum ~= self.heroCaveTaskDailyAcceptNumOld and self.heroCaveTaskDailyAcceptNumOld ~= -1 ) then
        TaskDataManager:triggerAcceptTask()
        triggerTask = false
    end

    if(self.oldDailyTalentBook ~= self.dailyTalentBook) then
        local limit = self:getBookDailyData()
        if(limit == true or self.dailyTalentBook == 0) then 
            Avalon.MessageCenter:notice(AvalonMessage.MC_TASK_REFRESH_ALL_TASK)
        end
    end

    --公会勋章
    if(self.guildMedalOld ~= self.guildMedal) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self.guildMedalOld, self.guildMedal)
    end

    --个人公会贡献
    if(self.guildContribOld ~= self.guildContrib) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self.guildContribOld, self.guildContrib)
    end
    -- print("HeroData  delusion ", self.delusionOld, self.delusion,self.guildMedal,self.guildContrib)
    if (self.delusionOld ~= self.delusion) then
        -- by CMonk, 机器人运行优化, 可以直接删除, 为了方便批量删除就不做前置空格了
        if (Auto and Auto.Robot and Auto.Robot:on()) then else
        -- eo CMonk
        self:handleDelusion(self.delusionOld)
        -- by CMonk, 机器人运行优化, 可以直接删除
        end
        -- eo CMonk
    end

    if(self.equipScoreOld ~= self.equipScore) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_UPDATE_EQUIPMENT_SCORE, self.equipScore)
    end
    -- 之前改变宠物状态的老逻辑，暂时弃用
    -- local pet = RoleDataManager:getScreenFightPetData()
    -- if pet then
    --     pet.functionFlag = self.functionFlag
    --     pet:handleFunctionFlag(self.functionFlagOld)
    -- end
    self:handleFunctionFlag(self.functionFlagOld)

    -- 处理刷新技能是否能够使用的状态
    if(self.skillRelatedFlagOld ~= self.skillRelatedFlag) then
        self:handleSkillRelatedFlag(self.skillRelatedFlagOld)
    end

    if(self.oldAchievementPoint ~= self.achievementPoint) then
       Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ACHIEVEMENT_POINT_UPDATE) 
    end

    if (self.oldDreamChip ~= self.dreamChip) then
       Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DREAM_CHIP_UPDATE) 
    end

    if self.oldPrimogeDebrisGreen ~= self.PrimogeDebrisGreen or 
        self.oldSouvenirLevelUp ~= self.SouvenirLevelUp or 
        self.oldSouvenirLevelUp2 ~= self.SouvenirLevelUp2 or
        self.oldTrialLevelUp ~= self.TrialLevelUp or
        self.oldDreamChip ~= self.dreamChip then

            mvc.send("Souvenir_Resource_Change")
    end


    if (self.oldHorcruxCoin ~= self.horcruxCoin) then
       -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DREAM_CHIP_UPDATE) 
    end

    if (self.oldSailGold ~= self.SailGold) then
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SAIL_GOLD_UPDATE) 
    end

    if (self.oldTreatureHuntOpenItem ~= self.TreatureHuntOpenItem) then
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SAIL_GOLD_UPDATE) 
    end

    if (self.oldAnniversaryCoin ~= self.AnniversaryCoin) then
        mvc.send("AnniversaryAppointment_Refresh_Coin_Number")
    end

    if (self.oldAnniversaryCoin2 ~= self.AnniversaryCoin2) then
        mvc.send("AnniversaryAppointment_Refresh_Coin_Number")
    end

    if (self.oldDailyGlyphComposeNum ~= self.DailyGlyphComposeNum) then
        mvc.send("Glyphs_Refresh_Casting_Num")
    end
    
    -- if (self.oldGemBoughtCredit ~= self.GemBoughtCredit) then
        --通知 符文洞窟积分币 发生变化 在_controlRoleAttrChange 方法中已经通知了
    -- end

    if (self.oldPrimogeDebris ~= self.PrimogeDebris) then
        mvc.send("PrimogemShop_Refresh_Info")
    end

    if (self.oldPrimogeDebris2 ~= self.PrimogeDebris2) then
        mvc.send("PrimogemShop_Refresh_Info")
    end
    

    if (self.oldUseStarPlate ~= self.UseStarPlate) then
        mvc.send("StarPray_Change_Plate", self.UseStarPlate)
    end

    if (self.oldUnlockStarPlate ~= self.UnlockStarPlateInfo) then
        mvc.send("StarPray_Change_Plate", nil, true)
    end
    

    if (self.oldBattlePassCoin ~= self.battlePassCoin) then
        mvc.battlePassModel:refreshBattlePassIcon()
    end

    if self:isMasterHero() then 
        if(self.blindOld ~= self:getIsBlind() ) then
            -- 发送致盲消息
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BLIND_CHANGE, self:getIsBlind())
        end
        -- 更新角色的最大装备分数
        MasterDataManager:updateMaxEquipScore(self.equipScore)

        -- 处理濒死的消息的处理
        local dangerous = self.hp * ConfigManager:getDangerousHPPercent() / PERCENT_NUMBER
        if(self.curHp < dangerous) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ROLE_HP_DANGEROUS, true)
        elseif(self.curHp >= dangerous) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ROLE_HP_DANGEROUS, false)
        end

        -- 这里判断刷新天变动了，刷新先关的数据
        if(self.refreshDayOld ~= self.refreshDay) then
            local oldWeek = GameManager:calculationGameWeekForDay(self.refreshDayOld)
            local newWeed = GameManager:calculationGameWeekForDay(self.refreshDay)
            MasterDataManager:triggerNewDay(self.refreshDay)
            mvc.mercenaryModel:triggerNewDay(self.refreshDay)

            -- print("wwww=", GameManager:calculationGameWeekForDay(self.refreshDay), 
            -- GameManager:calculationGameWeekForDay(self.refreshDay+4), 
            -- GameManager:calculationGameWeekForDay(self.refreshDay+5))

            -- print("HeroData endUpdateAttr ", self.refreshDayOld, self.refreshDay, oldWeek, newWeed)
            if oldWeek < newWeed then 
                -- 触发数据刷新
                local masterData = MasterDataManager:getGuildData()
                if(masterData) then 
                    -- print("HeroData endUpdateAttr 2", masterData:getVersion())
                    -- masterData:changeVersion(masterData:getVersion() - 1)
                    masterData:changeVersion(0)
                end

                MasterDataManager:triggerNewWeek()
            end
        end

        if self.oldFirstRecharge ~= self.firstChargeStat then
            Avalon.MessageCenter:notice(AvalonMessage.MC_FIRST_RECHARGE_STATUS_CHANGED)
            local LanguageManager = require("app.game.LanguageManager")
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111330))
        end

        if  self.oldMonthCardDay ~= self.monthCardDay or 
            self.oldSupplyReceiveDay ~= self.supplyReceiveDay or 
            self.refreshDayOld ~= self.refreshDay or 
            self.oldLifetimeCard ~= self.lifetimeCard or
            self.oldLastLifetimeReward ~= self.lastLifetimeReward or
            self.oldMonthSubscriptionEnd ~= self.monthSubscriptionEnd or
            self.oldMonthSubscriptionEndAutoRenew ~= self.monthSubscriptionEndAutoRenew or
            self.oldMonthSubscriptionClaimDay ~= self.monthSubscriptionClaimDay
        then
            Avalon.MessageCenter:notice(AvalonMessage.MC_REFRESH_NEW_DAY)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SUPPLY_STATUS_REFRESH)
            Avalon.MessageCenter:notice(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH)
        end
    end
    -- print("Hero rescuedDungeonSurvivorCount=", self.rescuedDungeonSurvivorCount, self:getPK(), self:getSpriteID())
    if self.rescuedDungeonSurvivorCountOld ~= self.rescuedDungeonSurvivorCount then 
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ROLE_DUNGEON_SURVIVOR, self:getPK(), self.rescuedDungeonSurvivorCount)
    end

    if(self.isExpeditionRunOld ~= self.isExpeditionRun) then 
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine and machine._model) then
            local master = machine._model:getRoleBySpriteID(self:getSpriteID())
            if(master) then 
                local SceneManager = require("app.game.SceneManager")
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initExpeditionUpdate(master:getId(), self.isExpeditionRun)
                SceneManager:getInstance():pushCommand(renderCommand)     
            end
        end
    end 

    -- print("@@@@@@@@@@@@@@@@@@@@@@@@@@",self.isHideHelmetOld , self.isHideHelmet)
    if(self.isHideHelmetOld ~= self.isHideHelmet) then 
        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initIsHideHelmet(self.spriteID, self:getIsHideHelmet())
        SceneManager:getInstance():pushCommand(battleCMD)

        -- print("@@@@@@@@@@@@@@@@@@@@@@@@@@")
        if self:isMasterHero() then 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_IS_HIDE_HELMET_UPDATE, self:getIsHideHelmet())
        end
    end

    -- 处理转换获取
    self:_AttributeConversion()

    -- print("---------self.totalSkillPoints = "..self.totalSkillPoints)
    -- print("---------self.oldTotalSkillPoints = "..self.oldTotalSkillPoints)
    if self.oldTotalSkillPoints ~= self.totalSkillPoints then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT)
    end

    if self.oldPetHpPool ~= self.petHpPool then

        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, RoleDataManager:getScreenFightPetData())
        local pets = RoleDataManager:getCaptain()
        -- local pets = MasterDataManager:getCaptainPet()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, pets)
    end

    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)

    --如果月卡时间发生变化,需要更新任务数据
    if self.oldMonthCardDay ~= self.monthCardDay then
        TaskDataManager:triggerAcceptTask()
    end
end

function HeroData:initAttrChange(data)
    -- 处理基础值
    if data.resultValue ~= 0 then
        local attrKey = ATTR_TYPE_ID_KEY[data.attrType]
        -- print("HeroData:initAttrChange", attrKey, data.attrType)
        if(attrKey) then
            self[attrKey] = data.resultValue
        else 
            printError(string.format("not found attrType = %s.",data.attrType))
        end
    end

    -- 处理百分比
    if data.rateAttrTotalValue ~=0 then
        local heroDataAttr = self._attrPercentArr[data.attrType]
        if heroDataAttr == nil then
            heroDataAttr = HeroDataAttr:create(data.attrType)
            self._attrPercentArr[data.attrType] = heroDataAttr
        else 
            heroDataAttr:reset()
        end

        local changeType = ChangeType.CHANGE_NORMAL
        heroDataAttr:changeValue(changeType,data.rateAttrTotalValue)
    end
end

--[[
    试穿服装
    tryEquipmentData:试穿的装备
    unEquipArr:试穿后需要脱掉的装备
    allEquipArr:尝试穿上后的装备列表

    返回值：试穿后数据对象（是一个全新的数据对象）
]]
function HeroData:tryEquipment(tryEquipmentData,unEquipArr,allEquipArr)
    -- dump(self)
    -- if DEBUG then
    --     print("HeroData:tryEquipment pre  =",self:getAttackStrength(),self:getSpellEffect(),self:getTough())
    -- end

    -- if DEBUG then
    --     print("HeroData:tryEquipment  pre hero attrbute start")
    --     self:print()
    --     print("HeroData:tryEquipment  pre hero attrbute end")
    -- end

    local copyHeroData = clone(self)
    if not tryEquipmentData then
        return nil
    else
        if unEquipArr then
            for k,equipmentData in ipairs(unEquipArr) do
                copyHeroData:_unEquipEquipment(equipmentData)
            end
        end

        copyHeroData:_equipEquipment(tryEquipmentData)

        -- 判断是否为穿戴装备，如果是穿戴装备才需要单独计算基础攻击速度
        if tryEquipmentData:isWeapon() then
            local weaponArr = {}
            table.insert(weaponArr,tryEquipmentData)

            if #weaponArr > 0 then
                copyHeroData:_calculationNewSpd(weaponArr)
            end
        end
    end

    copyHeroData:_AttributeConversion()
    -- if DEBUG then
    --     print("HeroData:tryEquipment end  =",self:getAttackStrength(),self:getSpellEffect(),self:getTough())
    --     print("HeroData:tryEquipment new  =",copyHeroData:getAttackStrength(),copyHeroData:getSpellEffect(),copyHeroData:getTough())
    -- end

    local backTable = {}
    backTable.attackPower = copyHeroData:getAttackStrength()
    backTable.magicEffect = copyHeroData:getSpellEffect()
    backTable.toughness = copyHeroData:getTough()
    backTable.unEquipArr = unEquipArr
    backTable.tryEquipmentData = tryEquipmentData

    --copyHeroData:print()
    --print(string.format("attackPower=%.2f, magicEffect=%.2f, toughness=%.2f", backTable.attackPower, backTable.magicEffect, backTable.toughness))

    return backTable
end

function HeroData:print()
    print("----------------------HeroData start---------------------------")
    -- TODO 按照某一个规则来打印
    print("",self.hp,self.dodge,self.block,self.blockValue,self.critical)
    print("",self.atkMin ,self.atkMax , self.CritDamageRate , self.PhysicDamageRate , self.physicPenetrate)
    print("",self.atkSpd ,self.mp , self.magic , self.magicPenetrate , self.MagicDamageRate)
    print("",self.ElementReductionRate ,self.PhysicReductionRate , self.physicDef , self.MagicReductionRate , self.magicDef)
    print("",self.atkFire,self.atkWater,self.atkWood,self.atkLight,self.atkDark)
    print("",self.defFire,self.defWater,self.defWood,self.defLight,self.defDark)
    print("",self.FireDamageRate, self.WaterReductionRate,self.WoodReductionRate,self.LightReductionRate,self.DarkReductionRate)
    print("",self.WaterDamageRate,self.WoodDamageRate,self.LightDamageRate,self.DarkDamageRate,self.ElementDamageRate)

    -- dump(self)
    print("----------------------HeroData   end---------------------------")
end

function HeroData:_calculationNewSpd(weaponArr)
    local attrName = "atkSpd"
    local atkSpdType = ATTR_TYPE["atkSpd"]
    -- if DEBUG then
    --     print("HeroData:_calculationNewSpd ",#weaponArr)
    -- end

    -- 计算本地攻击速度
    local localAtkSpd  = 0
    if weaponArr and #weaponArr > 0 then
        localAtkSpd = weaponArr[1]:getAtkSpd()
        useSkillSpd = false
    end
    -- 如果没有装备就用技能来计算
    if useSkillSpd then
        print("HeroData:_calculationNewSpd")
        local normalSkill = SkillDataManager:getNormalSkillForPK(self.pk)
        if normalSkill then
            localAtkSpd = normalSkill.castDuration
         else
            localAtkSpd = 1000
         end
    end

    self[attrName] = localAtkSpd
    -- if DEBUG then
    --     print("HeroData:_calculationNewSpd attrName,localAtkSpd=",attrName,localAtkSpd)
    -- end

    -- 计算最终的值
    local heroAttr = self._attrPercentArr[atkSpdType]
    local rateValue = 0
    if heroAttr then
        rateValue = heroAttr:getAllPercent()
    end
    -- if DEBUG then
    --     print("attrName",localAtkSpd)
    --     print("attrName",attrName)
    --     print("attrName",self[attrName])
    --     print("attrName",rateValue)
    -- end

    self[attrName] = self[attrName]* (1+rateValue/10000)
    if DEBUG then
        print("HeroData:_calculationNewSpd attrName,rateValue=",attrName,rateValue)
    end
end

-- 计算脱掉一件装备导致的属性改变
function HeroData:_unEquipEquipment(equipmentData)
    -- if (DEBUG) then
    --     print("------------------------------HeroData:_unEquipEquipment  end ------------------------------")
    -- end
    local allEquipmentAttr = equipmentData:getAllAttr()

    local atkSpdType = ATTR_TYPE["atkSpd"]
    for k,equipmentAttr in ipairs(allEquipmentAttr) do
        local attrName = ATTR_TYPE_ID_KEY[equipmentAttr:getAttrType()]
        if(self[attrName]) then
            -- if (DEBUG) then
            --     print("------ _unEquipEquipment=",equipmentAttr:getAttrType(),attrName,equipmentAttr:getBaseValue(),equipmentAttr:getRateValue())
            -- end

            -- 先计算原来得基础值，然后再计算添加比例后得值
            local heroAttr = self._attrPercentArr[equipmentAttr:getAttrType()]
            if heroAttr then
                self[attrName] = self[attrName]/((10000 + heroAttr:getAllPercent())/10000)
            end

            -- 计算添加相关比例值
            if equipmentAttr:getRateValue() ~= 0 then
                if not heroAttr then
                    heroAttr = HeroDataAttr:create(equipmentAttr:getAttrType())
                    self._attrPercentArr[equipmentAttr:getAttrType()] = heroAttr
                end

                heroAttr:changeValue(ChangeType.CHANGE_NORMAL,-equipmentAttr:getRateValue())
            end

            -- 计算最终的值
            local rateValue = 0
            if heroAttr then
                rateValue = heroAttr:getAllPercent()
            end
            if atkSpdType == equipmentAttr:getAttrType() then
                self[attrName] =(self[attrName]) * (1+rateValue/10000)
            else
                self[attrName] =(self[attrName] - equipmentAttr:getBaseValue()) * (1+rateValue/10000)
            end
        end
    end
    -- if (DEBUG) then
    --     print("------------------------------HeroData:_unEquipEquipment  end ------------------------------")
    -- end
end

function HeroData:_equipEquipment(equipmentData)
    -- if (DEBUG) then
    --     print("------------------------------HeroData:_equipEquipment equipmentData print  start ------------------------------")
    --     equipmentData:print()
    --     print("------------------------------HeroData:_equipEquipment equipmentData print  end ------------------------------")
    -- end
    local allEquipmentAttr = equipmentData:getAllAttr()

    local atkSpdType = ATTR_TYPE["atkSpd"]
    for k,equipmentAttr in ipairs(allEquipmentAttr) do
        local attrName = ATTR_TYPE_ID_KEY[equipmentAttr:getAttrType()]
        if(self[attrName]) then 
            -- 先计算原来得基础值，然后再计算添加比例后得值
            local heroAttr = self._attrPercentArr[equipmentAttr:getAttrType()]
            if heroAttr then
                self[attrName] = self[attrName]/((10000 + heroAttr:getAllPercent())/10000)
            end

            -- 计算添加相关比例值
            if equipmentAttr:getRateValue() ~= 0 then
                if not heroAttr then
                    heroAttr = HeroDataAttr:create(equipmentAttr:getAttrType())
                    self._attrPercentArr[equipmentAttr:getAttrType()] = heroAttr
                end

                heroAttr:changeValue(ChangeType.CHANGE_NORMAL,equipmentAttr:getRateValue())
            end
            -- 计算最终的值
            local rateValue = 0
            if heroAttr then
                rateValue = heroAttr:getAllPercent()
            end
            -- if DEBUG then
            --     print("------ _equipEquipment attrName,baseValue,rateValue,allRateValue=",attrName,equipmentAttr:getBaseValue(),equipmentAttr:getRateValue(),rateValue)
            -- end
            if atkSpdType == equipmentAttr:getAttrType() then
                self[attrName] =(self[attrName]) * (1+rateValue/10000)
            else
                -- print("attrName", attrName, self[attrName], equipmentAttr:getBaseValue(), rateValue)
                self[attrName] =(self[attrName] + equipmentAttr:getBaseValue()) * (1+rateValue/10000)
            end
        end
    end
    -- if DEBUG then
    --     print("------------------------------HeroData:_equipEquipment  end ------------------------------")
    -- end
end

-- 计算出主要属性用于界面展现
function HeroData:_AttributeConversion()
    -- TODO 根据当前盗贼穿戴的装备来计算当前攻击速度
    if DEBUG then
        self:print()
    end

    -- 这里取约定比例值 ，配置为 10000
    local COMMON_PERCERT = RATIO_NUMBER

    -- TODO 这里需要优化读取
    local spdActionParameter = tonumber(ConfigManager:getGeneralForKey("spdActionParameter"))         --速度调整系数，暂取600
    local criticalParameter = tonumber(ConfigManager:getGeneralForKey("criticalParameter"))          --暴击等级换算成暴击率的系数，暂取7000
    local physicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter"))   --物理穿透换算成物理穿透率的系数，暂取7000
    local dodgeParameter = tonumber(ConfigManager:getGeneralForKey("dodgeParameter"))             --闪避等级换算成闪避率的系数，暂取7000
    local dodgeActionParameter = tonumber(ConfigManager:getGeneralForKey("dodgeActionParameter"))       --一个参数，用来调整闪避的作用，暂取7000
    local blockParameter = tonumber(ConfigManager:getGeneralForKey("blockParameter"))             --格挡等级换算成格挡率的系数，暂取7000
    local mpActionParameter = tonumber(ConfigManager:getGeneralForKey("mpActionParameter"))          --一个参数，用于调整魔法值的作用，暂取值40
    local magicActionParameter = tonumber(ConfigManager:getGeneralForKey("magicActionParameter"))       --一个参数，用于调整中魔力的作用，暂取值3
    local magicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter"))    --魔法穿透换算成魔法穿透率的系数，暂取值7000

    -- 攻击强度
        -- （（ 火元素攻击*（10000+火元素伤害比例）+ 水元素攻击*（10000+水元素伤害比例）+ 木元素攻击*（10000+木元素伤害比例）
        --     + 光元素攻击*（10000+光元素伤害比例）+ 暗元素攻击*（10000+暗元素伤害比例））
        --     *（10000+所有元素伤害比例）/10000/10000 
        --     +（
        --     3*（最小攻击+最大攻击）*（10000+暴击伤害比例）*暴击等级/4/criticalParameter
        --     +（最小攻击+最大攻击）*10000/2
        --        ）
        --     *（10000+物理伤害比例）/10000/10000 
        --     +（最大攻击力+最小攻击力）*(10000+物理伤害比例）/(2*10000-物理穿透等级*10000/physicPenetrateParameter)/2
        --     )/攻击速度
    
    -- self.atkMin = 104
    -- self.atkSpd = 1000
    -- self.atkMax = 272
    -- self.magic = 89
    -- self.physicDef = 128
    -- self.magicDef = 100
    -- self.block = 791
    -- self.magicPenetrate = 282
    -- self.atkFire = 6
    -- self.atkWater = 4
    -- self.atkWood = 10
    -- self.atkLight = 12
    -- self.atkDark = 12
    -- self.hitRate = 10000

    -- self.FireDamageRate = 0
    -- self.WaterDamageRate = 0
    -- self.WoodDamageRate = 0
    -- self.LightDamageRate = 0
    -- self.DarkDamageRate = 0

    -- self.ElementDamageRate = -420
    -- self.PhysicDamageRate = -420
    -- self.critical = 0
    -- self.physicPenetrate = 0

    local preAttr = (
        math.floor ((self.atkFire * (COMMON_PERCERT + self.FireDamageRate) 
        + self.atkWater * (COMMON_PERCERT + self.WaterDamageRate)
        + self.atkWood * (COMMON_PERCERT + self.WoodDamageRate)  
        + self.atkLight * (COMMON_PERCERT + self.LightDamageRate)  
        + self.atkDark * (COMMON_PERCERT + self.DarkDamageRate)) 
        * (COMMON_PERCERT + self.ElementDamageRate) / (COMMON_PERCERT *COMMON_PERCERT))
        + ( 
            math.floor(3 * (self.atkMin + self.atkMax) * self.critical /(4 * criticalParameter))
            + math.floor((self.atkMin + self.atkMax)* COMMON_PERCERT / 2)
        ) * (COMMON_PERCERT + self.PhysicDamageRate)/ (COMMON_PERCERT*COMMON_PERCERT )
        + math.floor((self.atkMin + self.atkMax) * (COMMON_PERCERT + self.PhysicDamageRate)/ ((2*COMMON_PERCERT - self.physicPenetrate* COMMON_PERCERT/physicPenetrateParameter ) * 2)))

    -- if(DEBUG) then
    --     print("attrOne, attrTwo, attrThree , endAttr=", attrOne, attrTwo, attrThree, (attrOne + attrTwo + attrThree) * 1000 / self.atkSpd)
    -- end

    self.attackStrength =  preAttr
    -- self.attackStrength =  preAttr * 1000 / (self.atkSpd)

    -- 法术效果
    -- （ 魔法值/mpActionParameter +魔力*magicActionParameter 
    -- + magicActionParameter*10000*魔力/(2*10000-魔法穿透*10000/magicPenetrateParameter)）*（10000+魔法伤害比例）/10000
    self.spellEffect = math.floor((self.mp/mpActionParameter + self.magic * magicActionParameter 
        + magicActionParameter*self.magic * COMMON_PERCERT/(2*COMMON_PERCERT-self.magicPenetrate*COMMON_PERCERT/magicPenetrateParameter))) * (COMMON_PERCERT + self.MagicDamageRate) /COMMON_PERCERT

    -- 坚韧
    -- 生命值+（（10000+所有元素减伤比例）*（ 
    --         火元素防御*（10000+火元素减伤比例）+ 水元素防御*（10000+水元素减伤比例）+木元素防御*（10000+木元素减伤比例）
    --         +光元素防御*（10000+光元素减伤比例）+暗元素防御*（10000+暗元素减伤比例）
    --     ）/10000/10000
    --     +（物理减伤比例+10000）*物理防御/10000/2 
    --     +（魔法减伤比例+10000）*魔法防御/10000/2 
    --     + 闪避等级* dodgeActionParameter/dodgeParameter
    --     + 格挡值* dodgeActionParameter/blockParameter 

    self.tough = self.hp + math.floor((COMMON_PERCERT + self.ElementReductionRate)
                * (self.defFire * (COMMON_PERCERT + self.FireDamageRate) 
                + self.defWater * (COMMON_PERCERT + self.WaterReductionRate)
                + self.defWood * (COMMON_PERCERT + self.WoodReductionRate)
                + self.defLight * (COMMON_PERCERT + self.LightReductionRate)
                + self.defDark * (COMMON_PERCERT + self.DarkReductionRate)
                )/(COMMON_PERCERT*COMMON_PERCERT))
                + math.floor((self.PhysicReductionRate + COMMON_PERCERT) * self.physicDef /(2 * COMMON_PERCERT))
                + math.floor((COMMON_PERCERT + self.MagicReductionRate) * self.magicDef / (2 * COMMON_PERCERT))
                + math.floor(self.dodge*dodgeActionParameter/dodgeParameter)
                + math.floor(self.block*dodgeActionParameter/blockParameter)


    -- 四舍五入
    self.attackPower = math.floor(self.attackStrength)
    self.magicEffect = math.floor(self.spellEffect)
    self.toughness = math.floor(self.tough)

    if DEBUG then
        print("HeroData:_AttributeConversion =",self.attackPower,self.magicEffect,self.toughness)
    end

    -- if(self.attackPower > 50000 or self.magicEffect > 50000 or self.toughness > 50000) then 
    --     print("HeroData:_AttributeConversion =",self.attackPower,self.magicEffect,self.toughness)
    --     print("spdActionParameter, criticalParameter, physicPenetrateParameter, dodgeParameter, dodgeActionParameter=",spdActionParameter, criticalParameter, physicPenetrateParameter, dodgeParameter, dodgeActionParameter)
    --     print("blockParameter, mpActionParameter, magicActionParameter, magicPenetrateParameter=", blockParameter, mpActionParameter, magicActionParameter, magicPenetrateParameter)
    --     self:print()
    --     printError("Role attr is Error.")
    -- end
end

-- 获取攻击时长
function HeroData:getAttackDuration()
    return self.atkSpd / 1000
end

-- 是否是主角
function HeroData:isMasterHero()
    return self.isMaster
end

-- 是否月卡订阅中
function HeroData:isMonthSubscriptionEndAutoRenew()
    if(self.monthSubscriptionEndAutoRenew ~= nil) then 
        if(self.monthSubscriptionEndAutoRenew ~= 0) then 
            return true
        end
    end

    return false
end

-- 设置转职数值
function HeroData:setAdvanceStat(advanceStat)
    self.advanceStat = advanceStat
end

-- 获取转职数值
function HeroData:getAdvanceStat()
    return self.advanceStat
end

function HeroData:judgeHpPercertToUseSkill(percent)
    -- body
    if(percent == 0 or percent == nil) then
        return true
    end

    if(self.curHp < (percent / RATIO_NUMBER  * self.hp)) then
        return true 
    end

    return false
end

-- 判断是否可以移动
function HeroData:judegeToMove()
    if(self:getIsFrozen() or self:getIsStun() or self:getIsConstraint()) then
        return false
    end

    if ( self:getState() == FSMState.MOVE or self:getState() == FSMState.IDLE ) and self:getIsDead() == false then
        return true
    end

    return false
end

--判断是否要强制打断骑乘ing动画







function HeroData:getIsBlind()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Blind) == false) then
        return false
    else
        return true
    end
end

-- 获取是否翻转
function HeroData:getIsReverse()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Reverse) == false) then
        if(self.delusion == DelusionType.DelusionType_Mental) then
            return true
        end

        return false
    else
        return true
    end
end

-- 判断是否迷惑
function HeroData:isConfuse()
    if(self.delusion == DelusionType.DelusionType_Mental) then
        return true
    end

    return false
end

-- 获取强化百分比
function HeroData:getStrengthenExtraRate()
    return self.strengthenExtraRate
end

-- 获取商品折扣
function HeroData:getGoldenGoodsDiscountRate()
    return self.goldenGoodsDiscountRate
end

-- 获取是否免费
function HeroData:getIsReviveFree()
    if(self.isReviveFree >= 1) then
        return true
    else
        return false
    end
end

-- 获取是否首次免费复活
function HeroData:getIsFirstFree()
    if(self.FirstReviveFree >= 1) then
        return true
    else
        return false
    end
end

-- 设置是否免费复活
function HeroData:setIsReviveFree(isReviveFree)
    self.isReviveFree = isReviveFree
end

-- 设置是否首次免费复活
function HeroData:setIsFirstFree(isFirstFree)
    self.FirstReviveFree = isFirstFree
end

function HeroData:setReviveServerDiamond(serverDiamond) 
    self._serverDiamond = serverDiamond
end 

-- 获取复活的钻石数量
function HeroData:getReviveEndDiamond()
    if(self:isMasterHero()) then
        if self:getIsReviveFree() or self:getIsFirstFree() then 
            return 0
        end
    end

    -- add by zp 由于CO-16217【元素炼狱】复活显示价格和噩梦模式实际消耗不符  做的临时处理，
    -- 后续在 CO-16221 优化-多人组队时，复活队友水晶的计算方式优化（客户端）做正确的处理
    if(mvc.caveModel:isInInfernoNightMare()) then 
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr[self:getInfernoReviveNum() + 1]) then 
                return tonumber(costArr[self:getInfernoReviveNum() + 1])
            end
        end
        return 100
    end

    if(mvc.caveModel:isInVoidRiftNightMare()) then 
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr[self:getVoidRiftReviveNum() + 1]) then 
                return tonumber(costArr[self:getVoidRiftReviveNum() + 1])
            end
        end
        return 100
    end

    if(mvc.viKingModel:isInViKingNightMare()) then 
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr[self:getViKingReviveNum() + 1]) then 
                return tonumber(costArr[self:getViKingReviveNum() + 1])
            end
        end
        return 100
    end

    if(self._serverDiamond) then 
        return self._serverDiamond
    end

    local need = self:getReviveUseDiamond()

    local discountDataArr = MasterDataManager:getDiscountData(PublicDefine.DiscountType.DiscountType_Revive)
    local isDiscount = false
    local discount = RATIO_NUMBER
    if(discountDataArr and #discountDataArr > 0) then
        local discountData = discountDataArr[1]
        if(discountData and discountData:judgeToEffect()) then 
            isDiscount = true
            discount = discountData:getDiscount()
        end
    end

    if(isDiscount) then
        need = math.floor(need * discount / RATIO_NUMBER)
    end

    return need
end

-- 设置脸型值
function HeroData:setFaceDecodeID(faceDecodeID)
    -- print("HeroData:setFaceDecodeID",faceDecodeID)
    self.faceDecodeID = faceDecodeID
end

-- 获取脸型值
function HeroData:getFaceDecodeID()
    -- print("HeroData:getFaceDecodeID",self.faceDecodeID)
    return self.faceDecodeID
end

-- 获取首充状态
function HeroData:getFirstChargeStat()
    return self.firstChargeStat
end

-- 获取月卡到期天
function HeroData:getMonthCardDay()
    return self.monthCardDay
end

-- 获取补给天数
function HeroData:getSupplyReceiveDay()
    return self.supplyReceiveDay
end

-- 获取订阅月卡领取的天数
function HeroData:getSubsMonthSupplyReceiveDay()
    return self.monthSubscriptionClaimDay
end

-- 设置选择穿戴装备页码
function HeroData:setSelectShortcutEquipPage(selectPage)
    self.selectShortcutEquipPage = selectPage
end

-- 获取选择穿戴页码
function HeroData:getSelectShortcutEquipPage()
    return self.selectShortcutEquipPage
end

-- 获取变形ID
function HeroData:getLooks()
    local looks = self.looks
    if looks == 0 then
        looks = self.extraLooks
    end

    return looks
    -- return self.looks
end

function HeroData:setLooks(var)
    self.looks = var

    print(" HeroData  setLookssetLookssetLooks  ",var)
    local petData = self:getCaptainPetData()
    if petData then
        petData:setLooks(var)
    end
    
end

--获取角色spine UI缩放比例
function HeroData:getUIScale()
    local sc = 1

    local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
	local arr = string.split(monsterIdRange, ",")

    local looks = self:getLooks()
    local hasEat = looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])
    if hasEat then
        sc = 0.5
    end

    return sc
end

function HeroData:getextraLooks()
    return self.extraLooks
end

function HeroData:setextraLooks(var)
    self.extraLooks = var
end

function HeroData:getMaxFishingTime()
    return self.MaxFishingTime
end


-- 获取幻境状态
function HeroData:getDelusion()
    return self.delusion
end

function HeroData:getUserID()
    return self.userID
end

--秘境层数
function HeroData:getDungeonLoftLevel()
    -- dump( self.rewardDungeonLevel, " -----self.rewardDungeonLevel")
    return self.rewardDungeonLevel or 0
end

function HeroData:isHasReceivedDungeonSeasonReward()
    return self.hasReceivedDungeonSeasonReward
end

function HeroData:setHasReceivedDungeonSeasonReward(hasReceivedDungeonSeasonReward)
    self.hasReceivedDungeonSeasonReward = hasReceivedDungeonSeasonReward
end
-- 获取成就点数
function HeroData:getAchievementPoint()
    return self.achievementPoint
end
--获得梦境碎片
function HeroData:getDreamChip()
    return self.dreamChip
end

--获得梦境碎片
function HeroData:getHorcruxCoin()
    return self.horcruxCoin
end

--航行币(用于星图建筑升级)
function HeroData:getSailGold()
    return self.SailGold
end

--航海钻石
function HeroData:getSailDiamond()
    return self.SailDiamond
end


--获得战斗通行证货币
function HeroData:getBattlePassCoin()
    return self.battlePassCoin
end

-- 获取幽林深渊
function HeroData:getGhostAbyssUsedCount()
    return self.GhostAbyssUsedCount
end

-- 获取占星每日次数限制
function HeroData:getAstrologyUsedCount()
    return self.StarPrayDailyUsedCount or 0
end

-- 星火的数量
function HeroData:getStarFireNum()
    return self.StarFire or 0
end

--当前活动获取的星火数量
function HeroData:getCurVersionStarFire()
    return self.CurVersionStarFire or 0
end

--翠绿原石碎片
function HeroData:getPrimogeDebrisGreen()
    return self.PrimogeDebrisGreen or 0
end

--纪念品升级材料
function HeroData:getSouvenirLevelUp()
    return self.SouvenirLevelUp or 0
end

function HeroData:getSouvenirLevelUp2()
    return self.SouvenirLevelUp2 or 0
end

function HeroData:getTrialLevelUp()
    return self.TrialLevelUp or 0
end


--周年币
function HeroData:getAnniversaryCoin()
    -- return self.AnniversaryCoin
    return self.AnniversaryCoin2
end

--符文洞窟积分币
function HeroData:getGemBoughtCredit()
    return self.GemBoughtCredit
end

--探宝钥匙(用于洞窟探宝)
function HeroData:getTreatureHuntOpenItem()
    return self.TreatureHuntOpenItem
end

--雕纹铸造次数
function HeroData:getGlyphComposeNum()
    return self.DailyGlyphComposeNum
end

--铭文：周获取数量
function HeroData:getWromholeWeekVirtualNum()
    return self.WromholeWeekVirtualNum
end

--  原石碎片
function HeroData:getPrimogeDebrisNum()
    return self.PrimogeDebris
end

--  熔岩原石碎片
function HeroData:getPrimogeDebrisNum2()
    return self.PrimogeDebris2
end

--  出战星盘
function HeroData:getUseStarPlate()
    return self.UseStarPlate
end

-- 已解锁星盘
function HeroData:getUnlockStarPlate()
    local unlockList = {}
    local starPlateList = ConfigManager:getAllStarPlateData()
    for k, v in pairs(starPlateList) do
        if bit.band(self.UnlockStarPlateInfo, bit.lshift(1, (v.id - 1))) > 0 then
            -- table.insert(unlockList, v.id)
            unlockList[v.id] = true
        end
    end

    return unlockList
end

--  经验副本额外次数
function HeroData:getExpCaveTimes()
    return self.ExpCaveTimes
end


function HeroData:setGameUIDecorates(decorates)
    -- print("decorates ===== ")
    -- dump(decorates)
    -- if not self.decorates then
    --     self.decorates = {
    --         [1] = {
    --             type = 1,
    --             value = 0
    --         },
    --         [2] = {
    --             type = 2,
    --             value = 0
    --         }
    --     }
    -- end

    -- for i = 1, #self.decorates do
    --     for k,v in pairs(decorates) do
    --         if (self.decorates[i].type == v.type) then
    --             self.decorates[i].value = v.value
    --         end
    --     end
    -- end

    if not self.decorates then
        self.decorates = {}
    end

    for k,v in pairs(decorates) do
        local use = false
        for m,n in pairs(self.decorates) do
            if n.type == v.type and n.value == v.value then
                use = true
                break
            end
        end

        if not use then
            table.insert(self.decorates, v)
        end
    end

    if #self.decorates > 1 then
        table.sort(self.decorates, function(a, b)
            return a.value < b.value
        end)
    end

end
-- 获取玩家选择的UI表现特效类型table
function HeroData:getGameUIDecorates()
    return self.decorates or {}
end

function HeroData:setGameUIEquippedDecorates(equippedDecorate)
    for k,v in pairs(equippedDecorate) do
        self:setGameUISpecifyEquippedDecorates(v.type,v.value)
    end
end
function HeroData:setGameUISpecifyEquippedDecorates(decorateType,decorateValue)
    if not self.equippedDecorate then
        self.equippedDecorate = {
            [1] = {
                type = 1,
                value = 0
            },
            [2] = {
                type = 2,
                value = 0
            }
        }
    end

    for i = 1, #self.equippedDecorate do
        if (self.equippedDecorate[i].type == decorateType) then
            self.equippedDecorate[i].value = decorateValue
        end
    end

end
-- 当前装备的UI装饰
function HeroData:getGameUIEquippedDecorates()
    return self.equippedDecorate or {}
end

function HeroData:getIsHideHelmet()
    if(self.isHideHelmet == 1 or self.isHideHelmet == true) then
        return true
    end

    return false
end

function HeroData:setInfernoReviveNum(infernoReviveNum)
    self.infernoReviveNum = infernoReviveNum
end

function HeroData:getInfernoReviveNum()
    return self.infernoReviveNum
end

function HeroData:setVoidRiftReviveNum(voidRiftReviveNum)
    self.voidRiftReviveNum = voidRiftReviveNum
end

function HeroData:setViKingReviveNum(viKingReviveNum)
    self.viKingReviveNum = viKingReviveNum
end

function HeroData:getVoidRiftReviveNum()
    return self.voidRiftReviveNum
end

function HeroData:getViKingReviveNum()
    return self.viKingReviveNum
end

function HeroData:setPortalEffect(portalEffect)
    self.portalEffect = portalEffect
end

function HeroData:getPortalEffect()
    return self.portalEffect or 0
end

-- 大秘境赛季最大到达的楼层和到达该最大楼层的最短消耗时间的组合值，赛季结束后清零
function HeroData:getMaxDungeonLevelAndMinTimeForSeason()
    return self.maxDungeonLevelAndMinTimeForSeason or 0
end

-- 获取解救人数
function HeroData:getRescuedDungeonSurvivorCount()
    return self.rescuedDungeonSurvivorCount
end

--系统解锁
function HeroData:initFunctionUnlockMap()
    if self.functionUnlockStat == nil then
        return
    end
    -- print(" self.functionUnlockStat ="..self.functionUnlockStat)
    --初始化
    for k, value in pairs(PublicDefine.UnlockFunctionType) do
        local cfgData = ConfigManager:getFunctionUnlockCfgData(value)
        if cfgData == nil then
            self.functionUnlockStatMap[value] = 1
        elseif cfgData.defaultType == 1 then--defaultType == 1 默认解锁
            self.functionUnlockStatMap[value] = 1
        else
            -- add by zp 这里由于不会存在已经解锁了在修复为未解锁，做一个强制限制
            if(self.functionUnlockStatMap[value] ~= 1) then 
                self.functionUnlockStatMap[value] = 0
            end
        end   
    end
    local maxBit = 32
    for k, v in ipairs(self.functionUnlockStat) do
        local funcArray = ToolsUtil:splitFunctionType(v, true)
        --赋值
        for key, value in ipairs(funcArray) do
            self.functionUnlockStatMap[value + maxBit * (k - 1)] = 1
        end
    end
    -- dump(self.functionUnlockStatMap, "-----self.functionUnlockStatMap")
end

function HeroData:getFunctionUnlockMap()
    if table.nums(self.functionUnlockStatMap) == 0 then
        self:initFunctionUnlockMap()
    end
    return self.functionUnlockStatMap
end

function HeroData:addFunctionUnlock(functionType)
    if table.nums(self.functionUnlockStatMap) == 0 then
        self:initFunctionUnlockMap()
    end
    self.functionUnlockStatMap[functionType] = 1
end

function HeroData:addFunctionLock(functionType)
    if table.nums(self.functionUnlockStatMap) == 0 then
        self:initFunctionUnlockMap()
    end
    self.functionUnlockStatMap[functionType] = 0
end

-- 获取已经购买的钻石商品ID 列表
function HeroData:getDiamondPurchased()
    return self.diamondRecords
end

--获取工会勋章数量
function HeroData:getGuildMedal()
    return self.guildMedal
end

function HeroData:setStarPrayPool(starPrayPool)
    self.starPrayPool = starPrayPool
end

function HeroData:getStarPrayPool()
    return self.starPrayPool
end

function HeroData:getGuildContrib()
    return self.guildContrib
end

function HeroData:getInCaveTime()
    return self.nextConfineEnterCaveTime
end

function HeroData:getMentorName()
    return self.tutorName
end

function HeroData:getLoudSpeakerNum()
    return self.loudSpeaker
end

function HeroData:getHeroCreateTime()
    return self.createTime
end

function HeroData:getMarblesFeverHoodle()
    -- 反斗乐：弹珠
    return self.MarblesFeverHoodle
end

function HeroData:getMarblesFeverLuckyPoint()
    -- 反斗乐：幸运值
    return self.MarblesFeverLuckyPoint
end

function HeroData:getMarblesFeverDrawCount()
    -- 反斗乐：今日抽取次数
    return self.MarblesFeverDrawCount
end      

function HeroData:getLimitedMarblesFeverLuckyPoint()
    -- 限时反斗乐：幸运值
    return self.LimitedMarblesFeverLuckyPoint2
    -- return self.LimitedMarblesFeverLuckyPoint
end

function HeroData:getLimitedMarblesFeverDrawCount()
    -- 限时反斗乐：今日抽取次数
    return self.LimitedMarblesFeverDrawCount
end    

-- function HeroData:getUseStarPlate()
--     --当前出战的星盘ID
--     return self.UseStarPlate
-- end

-- function HeroData:getUnlockStarPlate()
--     --当前解锁的星盘情况 以二进制表达
--     return self.UnlockStarPlateInfo
-- end

    

--创建角色到目前的天数
function HeroData:getCreateRoleTime()
    local time = GameManager:getNormalServerTime() - self.createTime
    if time <= 0 then
        return 0
    end
    time = time / SECONDS_ONE_DAY
    time = time - time%0.01
    return time
end

function HeroData:setLastPurchaseTime(lastPurchaseTime)
    self.lastPurchaseTime = lastPurchaseTime
end

--上次充值到目前的天数
function HeroData:getLastPurchaseTime()
    local time = GameManager:getNormalServerTime() - self.lastPurchaseTime
    if time <= 0 then
        return 0
    end
    time = time / SECONDS_ONE_DAY
    time = time - time%0.01
    return time
end

--上次离线到目前的天数
function HeroData:getLastOffLineTime()
    local time = GameManager:getNormalServerTime() - self.lastOffLineTime
    if time <= 0 then
        return 0
    end
    time = time / SECONDS_ONE_DAY
    time = time - time%0.01
    return time
end

function HeroData:getPetCurHpStorage()
    return self.petHpPool or 0
end

function HeroData:getPetHpStorage()
    return self.petHpStorage
end

function HeroData:getRevivePetCost()
    local costStr = ConfigManager:getGeneralForKey("PetReviveCost")
    local list = string.split(costStr, ";")
    local listP = string.split(list[1], ",")
    local itemId = checkint(listP[1])
    local itemNum = checkint(listP[2])
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(itemId, true)
    if goodNumber >= itemNum then
        local itemData =  GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, itemId, false, 0)
        if itemData:getIsLock() then
            return 0, checkint(string.split(list[2], ",")[2])
        end
        return itemId, itemNum
    end
    return 0, checkint(string.split(list[2], ",")[2])
end

function HeroData:isFirstSub()
    if (not self.monthSubscriptionEnd or self.monthSubscriptionEnd == 0) then
        return true
    end
    return false
end

function HeroData:getSubDaysLeft()
    if (not self.monthSubscriptionEnd) then return 0 end
    local timeNow = GameManager:getNormalServerTime()
    local timeLeftInSeconds = self.monthSubscriptionEnd - timeNow
    local timeLeftInDays = math.ceil(timeLeftInSeconds / 3600 / 24)
    return timeLeftInDays
end

-- 获取订阅的扣费时间
function HeroData:getSubDeductionDate()
    if (not self.monthSubscriptionEnd) then 
        return ""
    end
    local preDay = 1
    local SdkBox = require("utils.sdkbox.SdkBox")
    local platForm = SdkBox:getInstance():getVersionPlatform()
    if platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        preDay = 1
    elseif platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        preDay = 1
    end

    return GameManager:getNowServerDate("%Y.%m.%d", self.monthSubscriptionEnd + GameManager:getEPOCHTime() - preDay * SECONDS_ONE_DAY)
end

function HeroData:getIsLifeTimeMember()
    if (not self.lifetimeCard or self.lifetimeCard == 0) then return false end
    return true
end

function HeroData:getIsLifeTimeGiftReceivedToday()
    if (not self.lastLifetimeReward) then return false end
    local timeNow = GameManager:getNormalServerTime()
    local serverDate = os.date("!*t", timeNow)
    local lastRewardDate = os.date("!*t", self.lastLifetimeReward)
    local deltaToNextDay = (23 - lastRewardDate.hour) * 3600 + (59 - lastRewardDate.min) * 60 + lastRewardDate.sec + 10 --延迟10秒避免误差
    return timeNow < self.lastLifetimeReward + deltaToNextDay
end

-- 获取仓库拥有最大格子
function HeroData:getWearhouseCanBeUseNum()
    return self.warehouseCanBeUsedNum + self.warehouseCanBeUsedNumItem
end

function HeroData:getUnlockWarehouseTimes()
    return self.unlockWarehouseTimes
end

function HeroData:getUnlockWarehouseTimesItem()
    return self.unlockWarehouseTimesItem
end

function HeroData:setWarehouseCanBeUsedNum(num)
    self.warehouseCanBeUsedNum = num
end

function HeroData:setUnlcokWarehouseTimes(times)
    self.unlockWarehouseTimes = times
end

function HeroData:setWarehouseCanBeUsedNumItem(num)
    self.warehouseCanBeUsedNumItem = num
end

function HeroData:setUnlcokWarehouseTimesItem(times)
    self.unlockWarehouseTimesItem = times
end

function HeroData:getHpPercent()
    return math.floor(self.curHp/self.hp * 100)
end

function HeroData:isRide()
    local isRiding = false
    local petsMap = RoleDataManager:getAllScreenPetData()
    for k,v in pairs(petsMap) do
        local heroSpID = v:getMasterSpriteID()
        if self.spriteID == heroSpID then
            isRideing = v:isRide()
            break
        end
    end

    return isRideing
end

function HeroData:getFightPetData()
    local petData = nil
    local petsMap = RoleDataManager:getAllScreenPetData()
    for k,v in pairs(petsMap) do
        local heroSpID = v:getMasterSpriteID()
        if self.spriteID == heroSpID then
            petData = v
        end
    end
    return petData
end

function HeroData:getCaptainPetData()
    local petData = nil
    local petsMap = RoleDataManager:getAllScreenPetData()
    for k,v in pairs(petsMap) do
        local heroSpID = v:getMasterSpriteID()
        if self.spriteID == heroSpID and v.siteId == 0 then
            petData = v
        end
    end
    return petData
end

function HeroData:getCrystalTreasureHuntLuckDraw()
    -- 水晶夺宝:是否内圈抽奖
    return self.CrystalTreasureHuntLuckDraw
end

function HeroData:getCrystalTreasureHuntTotalDrawCount()
    -- 水晶夺宝:累计抽取次数
    return self.CrystalTreasureHuntTotalDrawCount
end 

function HeroData:getCrystalTreasureHuntDailyDrawCount()
    -- 水晶夺宝:今日抽取次数
    return self.CrystalTreasureHuntDailyDrawCount
end 

function HeroData:getCrystalTreasureHuntStageID()
    -- 水晶夺宝:已领取阶段奖励
    return self.CrystalTreasureHuntStageID
end

function HeroData:getCrystalTreasureHuntNum()
    -- 水晶夺宝抽奖可用的道具数量
    local crystalLootConsumption = ConfigManager:getCrystalLootConsumption()
    local crystalConfig = string.split(crystalLootConsumption, ";")[1]
    local crystalCostNum = tonumber((string.split(crystalConfig, ","))[1])
    local useNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(crystalCostNum, true, true)
    return useNum
end

-- 设置已领奖的阶段
function HeroData:setStage(stage)
    self.CrystalTreasureHuntStageID = stage
end

-- 经验副本战斗次数
function HeroData:getDungeonExpFightNum()
    return self.DungeonExpFightNum
end

function HeroData:getChaosfightnum()
    return self.Chaosfightnum - self.Chaosfightextranum
end

function HeroData:getInscriptionNum()
    return self.Inscription
end

function HeroData:isRefreshBag(data)
    if data.changeType == ATTR_TYPE.Inscription then
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CURRENCY_CHANGE)
    end
end

-- function HeroData:getWromholefightnum()
--     return self.WromholeNum - self.WromholeExtraNum
-- end