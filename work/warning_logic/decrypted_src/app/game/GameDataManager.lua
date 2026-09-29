--[[
    出来所有数据的接口
]]--

local LanguageManager = require("app.game.LanguageManager")

local bit = require "bit"
local GameDataManager = class("GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")
local SdkBox = require("utils.sdkbox.SdkBox")

require "app.datas.battle.DspDamageData"
require "app.game.GameDefine"

g_GameDataManager = nil;

local THREE_DAY_TIME = SECONDS_ONE_DAY*3

local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local ITEM_TYPE = PublicDefine.ITEM_TYPE
local SCENE_TYPE = PublicDefine.SCENE_TYPE
local DisableSituation = PublicDefine.DisableSituation
local CAVE_MODE = PublicDefine.CAVE_MODE
local CAVE_DIFFICULTY = PublicDefine.CAVE_DIFFICULTY
local CONST_DEFINITION = PublicDefine.CONST_DEFINITION

local PACKET_TYPE = PublicDefine.PACKET_TYPE
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
local MATERIAL_TYPE = PublicDefine.MATERIAL_TYPE

local DEBUG = false

function GameDataManager:getInstance()
    if g_GameDataManager == nil then
        g_GameDataManager = GameDataManager.new()
    end
    return g_GameDataManager;
end


function GameDataManager:purgeInstance()
    if g_GameDataManager ~= nil then
        g_GameDataManager = nil;
    end
end

function GameDataManager:ctor()
    -- 全局玩家数据

    self._codeVersion = "0.0.0"
    self._resVersion = "0.0.0"
    self._lockedDungeonKeyId = 0
    -- 是否是新账号 1 为新账号 2为老账号
    self._isNewAccount = 2
    -- 是否被顶号登出(1:正常,2:顶号)
    self._isReplace = 1
    --  
    self._combatScoreRate = nil
    -- 用于屏蔽相关的操作
    self._isDisableSituation = false
    -- 登录游戏的提示语言，如果为nil 标识没有需要提示的，否者需要提示
    self._loginOutTipsText = nil

    self._networkMode = nil
    --刷新道具cd 时间 使用
    self._shortcutBagCdList = {}
    self._shortcutBarCdList = {}

    self._invitationArr = {}  -- 邀请信息
    -- 记录进阶技能导致的技能变化
    self._changeSkillData = nil
    -- 伤害列表
    self._damageArr = {}
    -- 处理活动数据奖励
    self._activityRankData = nil
    -- 副本活动，下一波怪物刷新时间
    self._nextBornTime = 0

    --广告数据
    self._advertData = {}
    self:init()
end
function GameDataManager:init()
end

function GameDataManager:update(dt)
    -- 触发活动副本怪物刷新
    if(SceneManager:getInstance():isActivityCave()) then 
        if(self._nextBornTime ~= 0 and self._nextBornTime <= GameManager:getNormalServerTime()) then 
            self._nextBornTime = 0
            local languageID = self:_getCaveNoticeLanguageID()
            if(languageID) then 
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(languageID))
            end
        end
    end

    -- 触发梦境排行的数据
    if(SceneManager:getInstance():isInTown()) then
        if(self._rankProjection == nil) then 
            self._rankProjection = 0
        end
        if(self._rankProjectionWaitingTime == nil) then 
            self._rankProjectionWaitingTime = math.random(15, 25)
        end
        self._rankProjection = self._rankProjection + dt 
        if(self._rankProjection > self._rankProjectionWaitingTime) then
            self._rankProjection = 0
            self._rankProjectionWaitingTime = math.random(15, 25)
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            if(machine and machine._model) then
                local actorArr = machine._model:getActorArr()
                if(actorArr) then 
                    local actor = actorArr[math.random(1, #actorArr)]
                    if(actor) then
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initDreamRankProjection(actor:getId())
                        SceneManager:getInstance():pushCommand(renderCommand)     
                    end
                end
            end
        end
    end

    -- 刷新快捷栏 和 快捷背包倒计时  时间
    if (not GameManager:getCountDownSwitch()) then
        local curTime = AvalonUtil.getCurrentTime()
        for k, v in pairs(self._shortcutBagCdList) do
            if v.targetCdTime > curTime then
                v.targetCdTime = v.targetCdTime + dt * 1000
            end
        end

        for k, v in pairs(self._shortcutBarCdList) do
            if v.targetCdTime > curTime then
                v.targetCdTime = v.targetCdTime + dt * 1000
            end
        end
    end
end

function GameDataManager:getDSPData()
    return self._damageArr
end 

function GameDataManager:handleDSPData(data) 
    self._damageArr = {}
    if(data.damageInfos and type(data.damageInfos) == "table") then 
        for _,v in ipairs(data.damageInfos) do 
            local foundDamage = nil 
            for k, damageData in ipairs(self._damageArr) do 
                if(damageData:getPK() == v.pk) then 
                    foundDamage = damageData
                    break
                end
            end

            if(foundDamage) then 
                foundDamage:updateData(v.damage)
            else 
                local isMaster = false
                local nickName = v.nickName
                if(self:getMasterPK() == v.pk) then 
                    isMaster = true
                end
                if(nickName == nil) then 
                    nickName = ""
                end

                local damageData = Data.DspDamageData:create()
                damageData:init(isMaster, nickName, v.pk)
                damageData:updateData(v.damage)
                table.insert(self._damageArr, damageData)
            end
        end

        -- 排序
        table.sort(self._damageArr, function(a, b) 
            if(a:getDamage() == b:getDamage()) then 
                if(a:getPK() > b:getPK()) then 
                    return true
                end

                return false
            end

            if(a:getDamage() > b:getDamage()) then 
                return true
            end

            return false
        end)

        -- 重置排名
        for k,v in ipairs(self._damageArr) do 
            v:setRank(k)
        end
    end

    return self._damageArr
end

function GameDataManager:getInvitationTime(PK)
    -- body
    if(PK) then
        if self._invitationArr[PK] then 
            return self._invitationArr[PK]
        end
        return 0
    else 
        return 0
    end
end

function GameDataManager:setInvitationTime(PK, time)
    -- body
    print("----------GameDataManager:setInvitationTime", PK, time)
    if(PK) then
        self._invitationArr[PK] = time
    end
end

function GameDataManager:clearAllInvitation()
    -- body
    self._invitationArr = {}
end


-- 获取存储的用户KEY  md5(account) .. pk
function GameDataManager:getSaveUserKey()
    local gameLoginManager = require("app.game.GameLoginManager")
    local account = nil
    if  (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        account = (gameLoginManager:getInstance():getAccountId() or "").."prj"..ServerConfigUtil:getProjectId().."zone"..(ServerConfigUtil:getZoneId() or "")
    else
        account = (gameLoginManager:getInstance():getAccountId() or "").."zone".. (ServerConfigUtil:getZoneId() or "")
    end
    local userKey = ""
    if(account) then
        userKey = AvalonUtil:MD5(account)
    end

    if(RoleDataManager:getMasterPK()) then
        userKey = userKey .. RoleDataManager:getMasterPK()
    end

    return userKey
end

-- 获取存储版本KEY key = versionPlatform .. versionTarget .. versionZone .. versionChannel .. languageManager
function GameDataManager:getSaveVersionKey()
    require("app.utils.ServerConfigUtil")
    local sdkbox = SdkBox:getInstance()
    sdkbox:init()
    return sdkbox:getVersionPlatform().."_"..sdkbox:getVersionTarget().."_"..ServerConfigUtil:getZoneId().."_"..sdkbox:getVersionChannel().."_"..LanguageManager:getInstance():getLanguage()
end

function GameDataManager:getSaveGlobalData()
    return Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
end
function GameDataManager:getOnlineTime()
    local master = self:getMaster()
    if master then
        return master:getOnlineTime()
    end
    return 0
end
function GameDataManager:getMasterPK()
    return RoleDataManager:getMasterPK()
end

function GameDataManager:getMasterUserID()
    return RoleDataManager:getMaster():getUserID()
end

function GameDataManager:getMaster()

    return RoleDataManager:getMaster()
end

-- 获取玩家是否已经死亡
function GameDataManager:getMasterIsDead()
    return RoleDataManager:getMaster():getIsDead()
end

-- 获取玩家移动速度
function GameDataManager:getMoveSpeed()
    return RoleDataManager:getMaster().moveSpeed
end

function GameDataManager:getPreNetworkMode()
    return self._networkMode
end

function GameDataManager:setNetworkMode(netWorkMode)
    self._networkMode = netWorkMode
end

function GameDataManager:getLoginOutTipsText()
    return self._loginOutTipsText
end

function GameDataManager:setLoginOutTipsText(tipsText)
    self._loginOutTipsText = tipsText
end



function GameDataManager:getTownBlackDialog()

    return self._townBlackDialog
end

function GameDataManager:setTownBlackDialog(type, bossID)
    if(self._townBlackDialog) then
        self._townBlackDialog = nil
    end

    local mapData = GameMapManager:getInstance():getMapData()
    local caveMode = mapData.caveMode
    local difficulty = mapData.difficulty

    if(type == BlackDialogEventType.PORTAL_TO_TOWN) then
        bossID = mapData.level
    end

    self._townBlackDialog = {}
    self._townBlackDialog.type = type 
    self._townBlackDialog.caveMode = caveMode
    self._townBlackDialog.caveDifficulty = difficulty
    self._townBlackDialog.level = bossID

end

function GameDataManager:clearTownBlackDialog()
    if(self._townBlackDialog) then
        self._townBlackDialog = nil
    end
end

function GameDataManager:getCombatScoreRate()
    if(self._combatScoreRate == nil) then
        local combatScoreRate = ConfigManager:getGeneralForKey("equipmentScore")
        if(combatScoreRate)  then
            local dataArr = string.split(combatScoreRate, ";")
            if(dataArr and #dataArr >=2) then
                local attrTypeArr = string.split(dataArr[1], ",")
                local valueArr = string.split(dataArr[2], ",")
                if(attrTypeArr and valueArr and #attrTypeArr == #valueArr) then 
                    self._combatScoreRate = {}
                    for i=1,#attrTypeArr do 
                        -- print("GameDataManager:getCombatScoreRate", attrTypeArr[i], valueArr[i])
                        self._combatScoreRate[tonumber(attrTypeArr[i])] = tonumber(valueArr[i])
                    end
                else
                    assert(false, "GenaralConfig  equipmentScore config is error.")
                end
            end
        end
    end 

    return self._combatScoreRate
end
    
-- 判断是否需要使用摇杆移动方式
function GameDataManager:canUseControlMove()
    local master = self:getMaster()
    if(master) then
        if(master:judegeToMove() == false) then
            return false
        end
    end

    -- 处理判断是否需要翻转
    if(GameManager:getIsTouchMoveType()) then

        return true
    end

    local master = self:getMaster()
    if(master and master:getIsReverse()) then
        return true
    end

    return false
end

-- 判断是否需要使用点击移动方式
function GameDataManager:canUseClickMove()
    -- 处理判断是否需要翻转
    if(GameManager:getIsClickMoveType() == false) then

        return false
    end

    local master = self:getMaster()
    if(master) then
        if(master:judegeToMove() == false) then
            return false
        end
    else 
        return false
    end

    local master = self:getMaster()
    if(master and master:getIsReverse()) then
        return false
    end

    if(GameManager:getMoveType() == MoveType.NORMAL) then 
        if MULTI_TOUCH_CONTROL_ID then 
            return false
        end
    end
    if(SceneManager:getInstance():isInLostRealm()) then 
        return false
    end

    return true
end

-- 是否使用摇杆
function GameDataManager:canUseControl()
    -- 处理判断是否需要翻转
    if(GameManager:getIsTouchMoveType()) then

        return true
    end

    local master = self:getMaster()
    if(master and master:getIsReverse()) then
        return true
    end

    return false
end

function GameDataManager:clearHeroDataForPK(pk)
    local heroData = RoleDataManager:getHeroDataForPK(pk)
    if(heroData) then
        local master = self:getMaster()
        if(master ~= heroData) then
            local spriteID = heroData:getSpriteID()
            print("GameDataManager:clearHeroDataForPK pk,spriteID=", pk, spriteID)

            TaskDataManager:clearDataForPKANDSpriteID(pk, spriteID)
            SkillDataManager:clearDataForPKANDSpriteID(pk, spriteID)
            GoodsDataManager:clearDataForPKANDSpriteID(pk, spriteID)
            RoleDataManager:clearDataForPKANDSpriteID(pk, spriteID)
        end
    else
        print("GameDataManager:clearHeroDataForPK no found heroData pk=", pk)
    end
end

--组队的时候 锁住对应的钥匙id
function GameDataManager:setLockDungeonKey(caveMode, loftLv)
    print("GameDataManager:setLockDungeonKey",caveMode, loftLv)
    if caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
        self._lockedDungeonKeyId = ConfigManager:getDungeonKeyByLoftLv(loftLv) or 0
    end
end

function GameDataManager:getLockDungeonKey()
    return self._lockedDungeonKeyId
end

function GameDataManager:removeLockDungeonKey()
    self._lockedDungeonKeyId = 0
end

-- 判断是否拥有指定等级的大秘境要是
function GameDataManager:judgeHaveDungeonKey(level)
    -- print("GameDataManager:judgeHaveDungeonKey")
    local masterPK = self:getMasterPK()
    local allMaterialArr = GoodsDataManager:getGoodsArrForPK(masterPK, PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_MATERIAL, nil)
    if(allMaterialArr) then 
        -- print("GameDataManager:judgeHaveDungeonKey111")
        for k,v in pairs(allMaterialArr) do 
            -- print("GameDataManager:judgeHaveDungeonKey222")
            if(v:getCategory() == Category.GOODS and v:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL and v:getMaterialType() == MATERIAL_TYPE.MaterialDungeonKey) then 
                -- print("GameDataManager:judgeHaveDungeonKey",v:getDungeonLevel(),level)
                if(tonumber(v:getDungeonLevel()) == level) then 
                    return true, v
                end
            end
        end
    end

    return false
end

-- 获取英雄类型
function GameDataManager:getHeroTypeForSpriteID(spriteID) 
    local goodsArr = GoodsDataManager:getGoodsArrForSpriteID(spriteID, PACKET_TYPE.PACKET_EQUIPMENT, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    
    if(goodsArr) then
        for k, equipmentData in pairs(goodsArr) do
            if(equipmentData:getEquipmentType() == EQUIPMENT_TYPE.Weapon) then
                return equipmentData:getWeaponType()
            end
        end
    end

    return 0
end

-- 获取是否加入公会
function GameDataManager:getIsJoinGuild()
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then
        return true
    end

    return false
end

-- 获取主角的权限
function GameDataManager:getMasterGuildTitle()
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then
        local title = guildData:getTitleForPK(self:getMasterPK())
        if(title == PublicDefine.GuildTitle.GuildTitle_Leader) then
            if(MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_LEADER_TILE_TRANSFER)) then 
                title = PublicDefine.GuildTitle.GuildTitle_ViceLeader
            end
        end

        -- 如果有退会操作只能行使普通成员权限
        local exitRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_EXIT)
        if(exitRepeatData) then
            title = PublicDefine.GuildTitle.GuildTitle_Member
        end

        return tonumber(title)
    end
    
    return nil
end

function GameDataManager:getMasterIsManage()
    local guildTitle = self:getMasterGuildTitle()
    if(guildTitle) then
        if(guildTitle ~= PublicDefine.GuildTitle.GuildTitle_Member) then
            return true
        end
    end

    return false
end

function GameDataManager:getGuildIconForIconID(iconID)
    local guildList = ConfigManager:getGuildIconList()
    for k, v in pairs(guildList) do
        if(tonumber(v.iconID) == tonumber(iconID)) then
            return v.iconSpriteName
        end
    end

    return nil
end

function GameDataManager:getGuildEquipScoreForLmt(lmt)
    local equipScore = string.split(ConfigManager:getGuildEquipScore(), ";")
    for k, v in pairs(equipScore) do 
        if(lmt == k-1) then
           return tonumber(v)
        end
    end

    return 0
end

-- 获取成员数量配置
function GameDataManager:getGuildMemberConfigForLevel(level)
    if(level) then
        local memberList = ConfigManager:getGuildMemberList()
        
        local lastMember = 0
        for k, v in pairs(memberList) do
            if(v and v.level and v.memberCap) then
                if(tonumber(v.level) > tonumber(level)) then
                    return lastMember
                else
                    lastMember = tonumber(v.memberCap)
                end
            else 
                print("GameDataManager:getGuildMemberConfigForLevel config has err", level)
            end
        end
        return lastMember
    else
        assert(false, "GameDataManager:getGuildMemberConfigForLevel  leve is nil")
        return 0
    end
end

function GameDataManager:getTitleStrForTitle(title)
    -- 优先查找职级名称自定义
    local guildData = MasterDataManager:getGuildData()
    local titleNames = guildData:getCustomTitles()
    for _, v in ipairs(titleNames) do
        if v.title == title then
            return v.titleName
        end
    end

    if(title == PublicDefine.GuildTitle.GuildTitle_Leader) then
        return LanguageManager:getInstance():getLocalString(1110571)
    elseif (title == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
        return LanguageManager:getInstance():getLocalString(1112903)
    elseif (title == PublicDefine.GuildTitle.GuildTitle_CoLeader) then
        return LanguageManager:getInstance():getLocalString(1110572)
    elseif (title == PublicDefine.GuildTitle.GuildTitle_Member) then
        return LanguageManager:getInstance():getLocalString(1110573)
    else 
        assert(false, string.format( "GameDataManager:getTitleStrForTitle title=%d", title))
    end

    return ""
end

function GameDataManager:getOffLineStrForTime(offlineTime)
    local offTime = GameManager:getNowServerTime() - offlineTime - GameManager:getEPOCHTime()

    if(offTime < THREE_DAY_TIME) then
        return LanguageManager:getInstance():getLocalString(1110578)
    else
        return string.format(LanguageManager:getInstance():getLocalString(1110612), 3)
    end
end

function GameDataManager:getFormatedTimeString(seconds)
    local secondsInMinutes = 60
    local secondsInHour = secondsInMinutes * 60
    local secondsInDay = 24 * secondsInHour

    if (seconds > secondsInDay) then
        local days = math.floor(seconds / secondsInDay)
        local remainingSeconds = seconds % secondsInDay
        local hours = math.ceil(remainingSeconds / secondsInHour)
        return tostring(days) .. LanguageManager:getInstance():getLocalString(1111036) .. tostring(hours) .. LanguageManager:getInstance():getLocalString(1110163)
    else
        local hours = math.floor(seconds / secondsInHour)
        local remainingSeconds = seconds % secondsInHour
        local minutes = math.ceil(remainingSeconds / secondsInMinutes)
        return tostring(hours) .. LanguageManager:getInstance():getLocalString(1110163) .. tostring(minutes) .. LanguageManager:getInstance():getLocalString(1110164)
    end
end

-- 计算商店金币价格折扣问题
function GameDataManager:calculationShopGoldPriceSale(buyPrice, costType)
    if buyPrice <= 0 then
        return buyPrice, false
    end
    local wasSale = false
    if (costType == GOODS_COST_TYPE.GOLD) then
        local masterData = GameDataManager:getInstance():getMaster()
        local decPercent = 0
        if(masterData) then
            local discount = masterData:getGoldenGoodsDiscountRate()
            if(discount > 0) then
                wasSale = true
                decPercent = decPercent + discount
            end
        end
        
        if SceneManager:getInstance():isInTown() then--城镇商店才会被天赋影响
            local talentPercent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.BlackShopDiscountRate)
            if talentPercent > 0 then
                wasSale = true
                decPercent = decPercent + talentPercent
            end
        end

        buyPrice = math.ceil(buyPrice * ((RATIO_NUMBER - decPercent) / RATIO_NUMBER))
        if(buyPrice < 1) then
            buyPrice = 1
        end
        return buyPrice, wasSale
    elseif (costType == GOODS_COST_TYPE.GEM) then
        local decPercent = 0
        if SceneManager:getInstance():isInTown() then--城镇商店才会被天赋影响
            local talentPercent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.BlackShopDiscountRate)
            if talentPercent > 0 then
                wasSale = true
                decPercent = decPercent + talentPercent
            end
        end

        buyPrice = math.ceil(buyPrice * ((RATIO_NUMBER - decPercent) / RATIO_NUMBER))
        if(buyPrice < 1) then
            buyPrice = 1
        end
        return buyPrice, wasSale
    else
        return buyPrice, wasSale
    end
end

-- 把层级转化为商店层 >> 2001
function GameDataManager:levelTransformShopLevel(caveModel, level)
    local maxLevel = level
    if(level >= CONST_DEFINITION.CAVE_LEVEL_MIN and level <= CONST_DEFINITION.CAVE_LEVEL_MAX) then
       
    elseif (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then
        if(SceneManager:getInstance():checkModeIsNewCave(caveModel)) then 
            maxLevel = (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_DISTORTED_SPACE_INTERVAL
        else 
            maxLevel = (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_INTERVAL
        end
    elseif (level >= CONST_DEFINITION.SHOP_LEVEL_MIN and level <= CONST_DEFINITION.SHOP_LEVEL_MAX) then
        return level
    end

    return CONST_DEFINITION.SHOP_LEVEL_MIN + math.modf((maxLevel-1) / SHOP_INTERVAL)
end

function GameDataManager:getHeroModelStageLevel(level)
    local stage = 0

    if(level >= CONST_DEFINITION.CAVE_LEVEL_MIN and level <= CONST_DEFINITION.CAVE_LEVEL_MAX) then
        stage = math.floor((level - 1) / HERO_INTERVAL) + 1
    elseif (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then
        stage = level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1
    elseif (level >= CONST_DEFINITION.SHOP_LEVEL_MIN and level <= CONST_DEFINITION.SHOP_LEVEL_MAX) then
        stage = math.floor((level - CONST_DEFINITION.SHOP_LEVEL_MIN) / 1) + 1
    end
    
    return stage
end

-->>>> 1, 11
function GameDataManager:_getCaveLevel(caveMode, level)
    -- add by zp 这里需要在外部判定不是在小黑屋
    if(caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON) then 
        return level
    end

    if(level >= CONST_DEFINITION.CAVE_LEVEL_MIN and level <= CONST_DEFINITION.CAVE_LEVEL_MAX) then
        return level
    elseif (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then
        if(SceneManager:getInstance():checkModeIsNewCave(caveMode)) then
            return (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_DISTORTED_SPACE_INTERVAL
        else
            return (level - CONST_DEFINITION.BOSS_LEVEL_MIN + 1)  * BOSS_INTERVAL
        end
    elseif (level >= CONST_DEFINITION.SHOP_LEVEL_MIN and level <= CONST_DEFINITION.SHOP_LEVEL_MAX) then
        -- add by zp 这里为了和服务器处理方式保持一致，只要进入第一个商店层，就把leve 强制设置成1
        -- return (level - CONST_DEFINITION.SHOP_LEVEL_MIN)  * SHOP_INTERVAL
        if(level == CONST_DEFINITION.SHOP_LEVEL_MIN) then 
            return 1
        end

        return (level - CONST_DEFINITION.SHOP_LEVEL_MIN)  * SHOP_INTERVAL
    end
    return 0
end

-- 添加了获取场景level 的问题
function GameDataManager:getSceneLevel()
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if(machine) then
        local model = machine:getModel()
        if(model) then 
            local mapData = model:getMapData()
            if(mapData) then 
                local number = mapData:getNumber()
                if(number ~= 0 and number) then 
                    return number 
                end
            end 
        end
    end

    return 1
end

-- 获取新活动的个数
function GameDataManager:getNewActivityNum()
    -- 添加统计逻辑
    local num = 0
    local activityArr = MasterDataManager:getActivityDataArrWithFilter({PublicDefine.ActivityType.ActivityType_Festival,PublicDefine.ActivityType.ActivityType_ExchangeShop})
    if(activityArr) then 
        for _, activitData in ipairs(activityArr) do 
            if(activitData:getIsNew()) then 
                num = num + 1
            end
        end
    end

    return num
end

-- 获取活动可领奖的个数
function GameDataManager:getActivityReceiveNum()
    -- 添加统计逻辑
    local num = 0
    local activityArr = MasterDataManager:getActivityDataArrWithFilter({PublicDefine.ActivityType.ActivityType_Festival, PublicDefine.ActivityType.ActivityType_ExchangeShop})
    if(activityArr) then 
        for _, activitData in ipairs(activityArr) do 
            if(activitData:getIsHaveAward()) then 
                num = num + 1
            end
        end
    end

    return num
end

-- 获取黑商的groupID
function GameDataManager:getBlackMarketGroupID()
    local heroData = RoleDataManager:getMaster()
    local groupID = 10101
    if(heroData) then 
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_CHAOS, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end
        
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DRIED_SPRING, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then 
            -- local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_TITAN_ROAD_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
            -- if(id) then 
            --     groupID = id
            --     return groupID
            -- end
            local maxLevelData = heroData:getMaxLevelData(CAVE_MODE.MODE_TITAN_ROAD_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(maxLevelData ) then 
                if (maxLevelData:getMaxLevel() > 0) then
                    return 190101;
                end
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_TITAN_ROAD, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_VIKING, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_VOID_RIFT, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_INFERNO, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DISTORTED_SPACE, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DESERT_EYES, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        local maxLevelData = heroData:getMaxLevelData(CAVE_MODE.MODE_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
        if(maxLevelData ) then 
            if (maxLevelData:getMaxLevel() >0) then
                return 40101;
            end
        end

        return self:getCommonGroupID()
    end

    return groupID
end

-- 获取锻造的groupID
function GameDataManager:getEquipForgeGroupID()
    local heroData = RoleDataManager:getMaster()
    local groupID = 10101
    if(heroData) then 
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_CHAOS, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DRIED_SPRING, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_TITAN_ROAD_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_TITAN_ROAD, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_VIKING, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_VOID_RIFT, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_INFERNO, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DISTORTED_SPACE, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then 
            local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_DESERT_EYES, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        return self:getCommonGroupID()
    end

    return groupID
end

-- 获取公共的组ID
function GameDataManager:getCommonGroupID()
    local heroData = RoleDataManager:getMaster()

    local groupID = 10101
    if(heroData) then
        -- 这里获取最大得难度等级
        -- 先判断英雄模式
        local id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
        if(id) then 
            groupID = id
            return groupID
        end

        id = self:_handleMaxLevelGetGroupID(CAVE_MODE.MODE_NORMAL, CAVE_DIFFICULTY.DIFFICULTY_1)
        if(id) then 
            groupID = id
            return groupID
        end

    end

    return groupID
end

-- 获取公共的组ID
function GameDataManager:getTaskGroupID()
    local heroData = RoleDataManager:getMaster()

    local groupID = 10101
    if(heroData) then
        -- if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Wromhole) then 
        --     local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_WORMHOLE, CAVE_DIFFICULTY.DIFFICULTY_1)
        --     if(id) then 
        --         groupID = id
        --         return groupID
        --     end
        -- end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_CHAOS, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_DRIED_SPRING, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then 
            return 190101
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_TITAN_ROAD, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_VIKING, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_VOID_RIFT, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_INFERNO, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_DISTORTED_SPACE, CAVE_DIFFICULTY.DIFFICULTY_3)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then 
            local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_DESERT_EYES, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(id) then 
                groupID = id
                return groupID
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then 

            return 40101
        end

        -- 这里获取最大得难度等级
        local id = self:_handleCheckPointGetGroupID(CAVE_MODE.MODE_NORMAL, CAVE_DIFFICULTY.DIFFICULTY_1)
        if(id) then 
            groupID = id
        end
    end

    return groupID
end

function GameDataManager:getMaxCheckPoint()
    local heroData = RoleDataManager:getMaster()

    if(heroData) then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_CHAOS, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end
        
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_DRIED_SPRING, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_TITAN_ROAD_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_TITAN_ROAD, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_VIKING, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_VOID_RIFT, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_INFERNO, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_DISTORTED_SPACE, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_DESERT_EYES, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then 
            local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_HERO, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                return checkPointData
            end
        end

        -- 这里获取最大得难度等级
        local checkPointData = heroData:getCheckpointData(CAVE_MODE.MODE_NORMAL, CAVE_DIFFICULTY.DIFFICULTY_1)
        if(checkPointData and checkPointData:getCheckpoint() >0) then
            return checkPointData
        end
    end

    return nil
end

function GameDataManager:_handleMaxLevelGetGroupID(caveMode, maxDifficulty)
    local heroData = RoleDataManager:getMaster()
    local groupID = 0
    if(heroData) then
        for i=maxDifficulty,1,-1 do
            local maxLevelData = heroData:getMaxLevelData(caveMode, i)
            if(maxLevelData and maxLevelData:getMaxLevel() >0) then
                local maxLevel = maxLevelData:getMaxLevel()
                -- add by zp CO-11020 客户端优化扭曲空间的进度算法
                if(SceneManager:getInstance():checkModeIsNewCave(caveMode)) then 
                    local nowGroupID = caveMode*10000 + i+ (math.floor((maxLevel - 1)/COMMOND_GROUP_INTERVAL) + 1) * 100
                    if(nowGroupID > groupID) then 
                        groupID = nowGroupID
                    end
                else 
                    groupID = caveMode*10000 + i* 100+ math.floor((maxLevel - 1)/COMMOND_GROUP_INTERVAL) + 1
                    break
                end
            end
        end
    end

    if(groupID == 0) then 
        groupID = nil
    end
    return groupID
end

function GameDataManager:_handleCheckPointGetGroupID(caveMode, maxDifficulty)
    local heroData = RoleDataManager:getMaster()
    local groupID = 0
    if(heroData) then
        for i=maxDifficulty,1,-1 do
            local checkPointData = heroData:getCheckpointData(caveMode, i)
            if(checkPointData and checkPointData:getCheckpoint() >0) then
                if(SceneManager:getInstance():checkModeIsNewCave(caveMode) and not SceneManager:getInstance():checkModeIsNewLimitCave(caveMode)) then--caveMode ~= PublicDefine.CAVE_MODE.MODE_TITAN_ROAD and caveMode ~= PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then 
                    local nowGroupID = caveMode*10000 + i + ((checkPointData:getCheckpoint() - CONST_DEFINITION.SHOP_LEVEL_MIN) + 1) * 100
                    if(nowGroupID > groupID) then 
                        groupID = nowGroupID
                    end
                elseif SceneManager:getInstance():checkModeIsNewLimitCave(caveMode) then
                    -- CO-20125【泰坦之路】任务刷出规则调整
                    -- 未通关的关卡任务不出现在日常任务列表 针对boss层为30层的倍数层并且会解锁下一个关卡特殊处理
                    local masterData = RoleDataManager:getMaster()
                    local maxLevelData = masterData:getMaxLevelData(caveMode, i)
                    local maxLevel = maxLevelData:getMaxLevel()
                    local unlockLevel = checkPointData:getCheckpoint() - CONST_DEFINITION.SHOP_LEVEL_MIN + 1
                    local nowLevel = math.modf(maxLevel / 10)
                    if maxLevel % 10 == 0 and unlockLevel == nowLevel + 1 and nowLevel % 3 == 0 then
                        unlockLevel = unlockLevel - 1
                    end

                    if unlockLevel == 0 then
                        -- 这里处理下，看了下配置表，这里的 unlockLevel 不应该有为 0 的情况
                        unlockLevel = 1
                    end

                    -- 进度对不上容错
                    if unlockLevel > 1 and maxLevel < (unlockLevel-1)*10 then
                        unlockLevel = unlockLevel - 1
                    end

                    groupID = caveMode*10000 + i + unlockLevel * 100
                else 
                    groupID = caveMode*10000 + i* 100+ (checkPointData:getCheckpoint() - CONST_DEFINITION.SHOP_LEVEL_MIN) + 1
                    break
                end
            end
        end
    end
    if(groupID == 0) then 
        groupID = nil
    end

    return groupID
end

function GameDataManager:getWillEnterCheckPoint()
    local level = GameMapManager:getInstance():getLevel()
    local caveModel = GameMapManager:getInstance():getModel()
    if(caveModel == PublicDefine.CAVE_MODE.MODE_NORMAL) then 
        if(level >= CONST_DEFINITION.CAVE_LEVEL_MIN and level <= CONST_DEFINITION.CAVE_LEVEL_MAX) then
            if level%30 ~= 0 and level%10 == 0 then 
                return true
            else
                return false
            end
        elseif (level >= CONST_DEFINITION.BOSS_LEVEL_MIN and level <= CONST_DEFINITION.BOSS_LEVEL_MAX) then
            return true
        elseif (level >= CONST_DEFINITION.SHOP_LEVEL_MIN and level <= CONST_DEFINITION.SHOP_LEVEL_MAX) then
            return false
        end
    else 
        return false
    end
end

function GameDataManager:willOpenNewNormalCheckPoint()
    if(self:getWillEnterCheckPoint() == false) then 
        return false
    end
    
    local mode = GameMapManager:getInstance():getModel()
    local difficulty = GameMapManager:getInstance():getDifficulty()
    local level = GameMapManager:getInstance():getLevel()
    local checkpoint = GameDataManager:getInstance():levelTransformShopLevel(mode, level)
    -- print("willOpenNewNormalCheckPoint  1", checkpoint)
    -- 判断是不是存档点
    if (GameDataManager:getInstance():judgeIsShop(checkpoint)) then
        local heroData = RoleDataManager:getMaster()

        local checkpointData = nil
        local changeCheckPoint = RoleDataManager:getChangeCheckPoint()
        if(changeCheckPoint and changeCheckPoint:getMode() == mode and changeCheckPoint:getDifficulty() == difficulty) then 
            checkpointData = changeCheckPoint
        else
            checkpointData = heroData:getCheckpointData(mode,difficulty)
        end
        -- print("willOpenNewNormalCheckPoint  2", checkpoint)
        if (checkpointData) then 
            -- print("willOpenNewNormalCheckPoint  3", checkpointData:getCheckpoint(), SceneManager:getInstance():isActivityCave())
            if(checkpointData:getCheckpoint() < checkpoint + 1
                and SceneManager:getInstance():isActivityCave() == false) then
                return true
            end
        end
    end

    return false
end

function GameDataManager:setDisableSituation(isDisable)
    local old = self._isDisableSituation
    self._isDisableSituation = isDisable
    if(old ~= self._isDisableSituation) then
        GameManager:notifyRoleFSMChange(self:getMaster())
    end
end

-- 检测是否禁用物品,并且返回提示的语言id
function GameDataManager:checkInDisableSituation(disableSituation)
    local situation = disableSituation

    if(self._isDisableSituation) then
        return true, 1170140   --当前状态下无法使用道具
    end

    local hero = GameManager:getMasterRole()
    if hero and hero:getRoleData():judgeToUseGoods() == false then
        return true, 1170140   --当前状态下无法使用道具
    end

    if(bit.band(situation, DisableSituation.InBattleStatus) ~= 0) then
        if(hero and hero:getState() == FSMState.BATTLE) then
            return true, 1170140
        end
    end
    if (bit.band(situation, DisableSituation.NotInBattleStatus) ~= 0) then
        if(hero and hero:getState() ~= FSMState.BATTLE) then
            return true
        end
    end 
    if (bit.band(situation, DisableSituation.InTown) ~= 0) then
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.TOWN) then
            return true, 1170116
        end
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.TOWN_CAVE) then
            return true, 1170116
        end
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.MANOR) then
            return true, 1170116
        end
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.BIGSAILPORT) then
            return true, 1170116
        end
    end
    if (bit.band(situation, DisableSituation.InCaveNormal) ~= 0) then
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.CAVE) then
            return true, 1170116
        end
    end
    if (bit.band(situation, DisableSituation.InCaveShopFloor) ~= 0) then
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.SHOP) then
            return true, 1170116
        end
    end
    if (bit.band(situation, DisableSituation.InCaveBossFloor) ~= 0) then
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.BOSS or 
            SceneManager:getInstance():isActivityCave()) then
            return true, 1170116
        end
    end
    if (bit.band(situation, DisableSituation.InChamber) ~= 0) then
        -- 判断是否在密室中
        if(GameMapManager:getInstance():getSceneType() == SCENE_TYPE.TOWN) then
            if(hero) then
                local mapData = self:getMapData()
                if(mapData) then
                    local coord = hero:getCoord()
                    if(coord) then
                        return mapData:isCoordInChamber(Avalon.MathUtil:getInt(coord.x),
                            Avalon.MathUtil:getInt(coord.y))
                    end
                end
            end
        end
    end
    --大秘境
    if (bit.band(situation, DisableSituation.InDungeon) ~= 0) then
        if(SceneManager:getInstance():isInDungeon()) then
            return true, 1170116
        end
    end

    -- 公会禁用
    if (bit.band(situation, DisableSituation.InGuild) ~= 0) then
        if(SceneManager:getInstance():isGuild()) then
            return true, 1170116
        end
    end

    -- 梦境禁用
    if (bit.band(situation, DisableSituation.InDream) ~= 0) then
        if(SceneManager:getInstance():isInDream()) then
            return true, 1170116
        end
    end

    -- 世界BOSS禁用
    if (bit.band(situation, DisableSituation.InActivity) ~= 0) then
        if(SceneManager:getInstance():isWorldBossCave()) then
            return true, 1170116
        end
    end

    -- 公会BOSS禁用
    if (bit.band(situation, DisableSituation.InGuildBoss) ~= 0) then
        if(SceneManager:getInstance():isGuildBoss()) then
            return true, 1170116
        end
    end

    return false
end

-- 获取游戏中角色数量
function GameDataManager:getGameRoleNum()
    if(TeamDataManager:hasTeam()) then
        -- TODO 这里目前就写成了固定值，如果后面有需求需要修改为动态数据
        return PublicDefine.CONST_DEFINITION.MAX_TEAM_NUM
        -- local teamDataList = TeamDataManager:getTeamData()
        
    else
        return 1
    end
end

-- 获取服务器代码版本
function GameDataManager:getServerCodeVersion()
    return self._codeVersion
end

-- 获取服务器资源版本
function GameDataManager:getServerResVersion()
    return self._resVersion
end

-- 处理服务器版本信息
function GameDataManager:handleServerVersion(data)
    if(data.codeVersion) then
        self._codeVersion = data.codeVersion
    end
    if(data.resVersion) then
        self._resVersion = data.resVersion
    end
    -- print("GameDataManager:handleServerVersion ", self._codeVersion, self._resVersion)
end



-- 获取昵称
function GameDataManager:makeNickName()
    local fristNum = math.random(1,60)
    local twoNum = math.random(61,78)
    local threeNum = math.random(79,138)

    fristNum = fristNum + 1140000
    twoNum = twoNum + 1140000
    threeNum = threeNum + 1140000

    return LanguageManager:getInstance():getLocalString(fristNum)..LanguageManager:getInstance():getLocalString(twoNum)..LanguageManager:getInstance():getLocalString(threeNum)
end

-- 获取刷新等待时间(秒)
function GameDataManager:getRefreshWaitingTime()
    local nowTime = GameManager:getNowServerTime()
    local masterData = self:getMaster()
    -- print("GameDataManager:getRefreshWaitingTime nowTime=", nowTime)
    if(masterData) then
        local refreshTime = GameManager:getEPOCHTime() +  (masterData:getRefreshDay() + 1 ) * SECONDS_ONE_DAY
        -- print("GameDataManager:getRefreshWaitingTime refreshTime, nowTime=",refreshTime, nowTime)
        if(refreshTime > nowTime) then
            return (refreshTime - nowTime)
        else
            return 0
        end
    else
        return 0
    end
end

-- 获取黑商刷新时间
function GameDataManager:getBlackShopRefreshWaitingTime()
    local nowTime = GameManager:getNowServerTime()
    local masterData = self:getMaster()
    local blackRefreshHour = MasterDataManager:getBlackMarketRefreshHour()
    -- print("GameDataManager:getBlackShopRefreshWaitingTime nowTime,blackRefreshHour=", nowTime, blackRefreshHour)
    -- blackRefreshHour = 159281
    local time = nowTime - GameManager:getEPOCHTime()
    local clientDay = math.modf(time/SECONDS_ONE_DAY)
    local clientHour = math.modf(time/SECONDS_ONE_HOUR)
    local clientSecond = time % SECONDS_ONE_HOUR

    local serverDay = math.modf(blackRefreshHour/24)
    local serverHour = blackRefreshHour

    if(clientDay > serverDay +1) then
        -- 有超过一天没有刷新了
        return 0
    end

    -- print("GameDataManager:getBlackShopRefreshWaitingTi  client=",clientDay, clientHour, clientSecond)
    -- print("GameDataManager:getBlackShopRefreshWaitingTi  client=",serverDay, serverHour, 0)
    -- print("GameDataManager:getBlackShopRefreshWaitingTime wwww nowTime,blackRefreshHour=", nowTime, blackRefreshHour)
    local refresTimeStr = ConfigManager:getBlackRefreshTime()
    local splitArr = string.split(refresTimeStr,";")

    local refreshTimeArr = {}
    for _,str in pairs(splitArr) do
        table.insert(refreshTimeArr, tonumber(str))
    end
    if(#refreshTimeArr == 0) then
        assert(false,"[ERROR] GameDataManager:getBlackShopRefreshWaitingTime  blackShop refresh config is error.")
    end

    if(clientDay > serverDay) then
        -- 跨天的逻辑处理
        -- local hour = math.modf(serverHour % 24)
        -- if(#refreshTimeArr > 0 and hour < refreshTimeArr[#refreshTimeArr]) then
        --     return 0
        -- end

        -- local hour = math.modf(clientHour % 24)
        -- if(refreshTimeArr[1] and hour > refreshTimeArr[1]) then
        --     return 0
        -- end

        -- for _, refreshHour in pairs(refreshTimeArr) do
        --     if(refreshHour > hour) then
        --         return (refreshHour - hour)* 3600 - clientSecond
        --     end
        -- end

        -- if(refreshTimeArr[1]) then
        --     return (refreshTimeArr[1] + 24 - hour)* 3600 -clientSecond
        -- end
        
        return 0
    end
    
    -- 处理在同一天
    local serverDayHour = math.modf(serverHour % 24)
    local clientDayHour = math.modf(clientHour % 24)

    -- 过滤没有在一个刷新区间内
    for _, refreshHour in pairs(refreshTimeArr) do
        if(refreshHour <= clientDayHour and refreshHour > serverDayHour) then
            return 0
        end
    end
    -- 在一个区间内
    for _, refreshHour in pairs(refreshTimeArr) do
        if(refreshHour > clientDayHour) then
            return (refreshHour - clientDayHour)* SECONDS_ONE_HOUR - clientSecond
        end
    end

    if(refreshTimeArr[1]) then
        return (refreshTimeArr[1] + 24 - clientDayHour)* SECONDS_ONE_HOUR -clientSecond
    end

    return 0
end

-- 获取黑商刷新时间
function GameDataManager:getRandomShopRefreshWaitingTime()
    local nowTime = GameManager:getNowServerTime()
    local masterData = self:getMaster()
    local blackRefreshHour = MasterDataManager:getRandomShopRefreshHour()
    -- print("GameDataManager:getBlackShopRefreshWaitingTime nowTime,blackRefreshHour=", nowTime, blackRefreshHour)
    -- blackRefreshHour = 159281
    local time = nowTime - GameManager:getEPOCHTime()
    local clientDay = math.modf(time/SECONDS_ONE_DAY)
    local clientHour = math.modf(time/SECONDS_ONE_HOUR)
    local clientSecond = time % SECONDS_ONE_HOUR

    local serverDay = math.modf(blackRefreshHour/24)
    local serverHour = blackRefreshHour

    if(clientDay > serverDay +1) then
        -- 有超过一天没有刷新了
        return 0
    end

    -- print("GameDataManager:getBlackShopRefreshWaitingTi  client=",clientDay, clientHour, clientSecond)
    -- print("GameDataManager:getBlackShopRefreshWaitingTi  client=",serverDay, serverHour, 0)
    -- print("GameDataManager:getBlackShopRefreshWaitingTime wwww nowTime,blackRefreshHour=", nowTime, blackRefreshHour)
    local refresTimeStr = ConfigManager:getBlackRefreshTime()
    local splitArr = string.split(refresTimeStr,";")

    local refreshTimeArr = {}
    for _,str in pairs(splitArr) do
        table.insert(refreshTimeArr, tonumber(str))
    end
    if(#refreshTimeArr == 0) then
        assert(false,"[ERROR] GameDataManager:getBlackShopRefreshWaitingTime  blackShop refresh config is error.")
    end

    if(clientDay > serverDay) then        
        return 0
    end
    
    -- 处理在同一天
    local serverDayHour = math.modf(serverHour % 24)
    local clientDayHour = math.modf(clientHour % 24)

    -- 过滤没有在一个刷新区间内
    for _, refreshHour in pairs(refreshTimeArr) do
        if(refreshHour <= clientDayHour and refreshHour > serverDayHour) then
            return 0
        end
    end
    -- 在一个区间内
    for _, refreshHour in pairs(refreshTimeArr) do
        if(refreshHour > clientDayHour) then
            return (refreshHour - clientDayHour)* SECONDS_ONE_HOUR - clientSecond
        end
    end

    if(refreshTimeArr[1]) then
        return (refreshTimeArr[1] + 24 - clientDayHour)* SECONDS_ONE_HOUR -clientSecond
    end

    return 0
end

-- 获取打开（表现动画）的存储点
function GameDataManager:getOpenCheckpointData(caveMode, caveDifficulty)
    local globalUserData = self:getSaveGlobalData()
    local checkPointData = nil
    if(globalUserData) then
        local checkPoint = globalUserData:getOpenCheckpointData(caveMode,caveDifficulty)
        if checkPoint == nil then
            return nil
        end
        checkPointData = Data.CheckpointData:create()
        checkPointData:init(caveMode,caveDifficulty,checkPoint)
    end

    return checkPointData
end

-- 打开（表现动画）设置存储点
function GameDataManager:openCheckpoint(caveMode, caveDifficulty, checkpoint)
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        globalUserData:setOpenCheckpointData(caveMode, caveDifficulty, checkpoint)
    end
end

-- 获取商店相关数据
function GameDataManager:getInCaveShopAllGoodsForLevel(level)
    return GoodsDataManager:getInCaveShopAllGoodsForLevel(GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty(), level)
end

-- 获取队友列表
function GameDataManager:getTeamArr()
    local allRole = {}
    local masterPK = self:getMasterPK()
    local allTeamData = TeamDataManager:getTeamData()

    for k,v in pairs(allTeamData) do
        if(v.pk ~= masterPK) then
            local heroData = RoleDataManager:getHeroDataForPK(v.pk)
            if(heroData) then
                table.insert(allRole,heroData)
            end
        end
    end

    return allRole
end

function GameDataManager:getCurCoin()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getCurCoin()
    end 

    return 0
end

function GameDataManager:getDiamond()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getDiamond()
    end 

    return 0
end

function GameDataManager:getInscription()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getInscriptionNum()
    end 

    return 0
end

function GameDataManager:getPrimogeDebrisNum()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getPrimogeDebrisNum()
    end 

    return 0
end

function GameDataManager:getPrimogeDebrisNum2()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getPrimogeDebrisNum2()
    end 

    return 0
end



function GameDataManager:getGuildMedal()
    local master = RoleDataManager:getMaster()
    if(master) then
        return master:getGuildMedal()
    end 

    return 0
end

function GameDataManager:getRoleTalentPoint()    
    local number = self:getGoodsDataNum(PACKET_TYPE.PACKET_BAG, ROLE_TALENT_STONE_GOODSID, true)
    return number
end

-- 获取背包最大得格子数
function GameDataManager:getPacketBoxMaxNum()

    -- return PublicDefine.CONST_DEFINITION.PACKET_BOX_MAX_NUM
    return tonumber(ConfigManager:getGeneralForKey("packetBoxMaxNum")) + 
        tonumber(ConfigManager:getGeneralForKey("itemUnlockPacketBoxSpace")) * tonumber(ConfigManager:getGeneralForKey("itemUnlockPacketBoxSpaceTimes"))
end

-- 获取仓库最大的背包
function GameDataManager:getPacketWarehouseMaxNum()

    -- return PublicDefine.CONST_DEFINITION.PACKET_WAREHOUSE_MAX_NUM
    return tonumber(ConfigManager:getGeneralForKey("packetWarehouseMaxNum"))
end

-- 获取总的技能点
function GameDataManager:getTotalSkillPoints()

    return RoleDataManager:getMaster():getTotalSkillPoints()
end

-- 获取下次获取技能点数的等级, nil为没有下一个技能点数了
function GameDataManager:getLevelToGetNextSkillPoint()
    return RoleDataManager:getMaster():getLevelToGetNextSkillPoint()
end

-- 获取穿戴的那套装备
function GameDataManager:getPacketType()
    -- TODO 根据角色属性来获取packet 类型

    return PACKET_TYPE.PACKET_EQUIPMENT
end

-- 获取任务列表
function GameDataManager:getTaskArr()
    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    local list = TaskDataManager:getNowTaskArr()
    local tempList = {}
     for _,taskData in ipairs(list) do
        if taskData:isHeroCave() then
            -- if(unLockHeroMode) then 
                table.insert(tempList, taskData)
            -- end 
        else
            table.insert(tempList, taskData)
        end
    end
    return tempList
end

-- 通过模板ID获取类型
function GameDataManager:templateIDToCategory(templateID)
     if templateID > 30000000 then
        return Category.SKILL
    elseif templateID < 30000000 and templateID > 20000000 then
        return Category.GOODS
    else
        assert(false,string.format("GameDataManager:templateIDToCategory  template=%d not handle.",templateID))
    end
end

function GameDataManager:isGoodsExisit(bagType, ids, goodsType)
    if not bagType or not ids then
        return true
    end
    local allItemArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(),bagType,goodsType)
    
    for i = 1, #ids do
        local compareId = ids[i]
        local isFind = false
        for _,goodsData in ipairs(allItemArr) do
            if goodsData:getGoodsID() == compareId then
                isFind = true
                break
            end
        end
        if not isFind then
            return false
        end
    end
    return true
end


-- 获取回城卷轴
function GameDataManager:getEscapeScroll()
    local allItemArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)

    local arr = {}
    for _,goodsData in ipairs(allItemArr) do
        if goodsData:getItemType() == ITEM_TYPE.EscapeScroll then
            table.insert(arr,goodsData)
        end
    end

    local choiceData = nil
    for _,goodsData in ipairs(arr) do
        choiceData = goodsData
        if (goodsData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
            return goodsData
        end
    end

    return choiceData
end

-- 获取回城卷轴
function GameDataManager:getUnlockBagItem()
    local allItemArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)

    local arr = {}
    for _,goodsData in ipairs(allItemArr) do
        if goodsData:getItemType() == ITEM_TYPE.ItemUnlockBag then
            table.insert(arr,goodsData)
        end
    end

    local choiceData = nil
    for _,goodsData in ipairs(arr) do
        choiceData = goodsData
        if (goodsData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
            return goodsData
        end
    end

    return choiceData
end

-- 获取遗忘技能材料数据
function GameDataManager:getForgetSkillNeedMateral()
    local goodsID = tonumber(ConfigManager:getGeneralForKey("forgetSkillMaterialID"))
    local allMaterialArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    
    local num = 0;
    for _,goodsData in ipairs(allMaterialArr) do
        -- if goodsData:getGoodsID() == goodsID and goodsData:getIsGolden() == true then
        if goodsData:getGoodsID() == goodsID then
            num = num + goodsData:getNum()
        end
    end

    local materialData = GoodsDataManager:createMaterialForMaterialID(goodsID)
    if(materialData) then
        materialData:setNum(num)
    end

    return materialData
end

-- 获取当前背包空闲数量
function GameDataManager:getFreePacketBoxNum()
    -- 背包能够使用的格子数
    local master = RoleDataManager:getMaster()
    local packetBoxBeUseNum = MasterDataManager:getAllBoxCanBeUseNum()

    -- 背包信息
    local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    local havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    local haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    local haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    local haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    local haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    local haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_TREASURE)

    return packetBoxBeUseNum - #haveEquipmentArr - #havePetEquipmentArr - #haveItemArr - #haveMaterialArr - #haveGemStoneArr - #haveRelicArr - #haveTreasureArr
end

-- 获取宠物宝石背包空闲数量
function GameDataManager:getFreePetGemStoneBoxNum()
    local master = RoleDataManager:getMaster()
    local havePetStoneNum = GoodsDataManager:getGoodsArrForPK(master:getPK(), PACKET_TYPE.PACKET_PET_GEMSTONE, PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
    local freeNum = PublicDefine.CONST_DEFINITION.MAX_PET_GEMSTONE_PACKET_NUM - #havePetStoneNum

    return freeNum
end

-- 获取雕纹背包空闲数量
function GameDataManager:getFreeGlyphsBoxNum()
    local master = RoleDataManager:getMaster()
    local haveGlyphsNum = GoodsDataManager:getGoodsArrForPK(master:getPK(), PACKET_TYPE.PACKET_GLYPH, PublicDefine.GOODS_TYPE.GOODS_GLYPH)
    local glyphsPacketMaxNum = tonumber(Config.General:getValueForKey("glyphInitialBag"))
    local freeNum = glyphsPacketMaxNum - #haveGlyphsNum

    return freeNum
end

--[[
    goodsArr :{{goodsID:1,num:1,isGolden:false},{goodsID:2,num:1,isGolden:true}}
]]
function GameDataManager:judgeEnoughPacketForGoodsArr(goodsArr)
    -- dump(goodsArr, "goodsArr")
    local master = RoleDataManager:getMaster()
    local packetBoxBeUseNum = MasterDataManager:getAllBoxCanBeUseNum()

    -- 背包信息
    local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    local havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    local haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    local haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    local haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    local haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    local haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    

    local freeNum = packetBoxBeUseNum - #haveEquipmentArr - #havePetEquipmentArr - #haveItemArr - #haveMaterialArr - #haveGemStoneArr - #haveRelicArr - #haveTreasureArr
    for k,goodsData in pairs(goodsArr) do
        local isGolden = goodsData.isGolden

        local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsData.goodsID)
        -- 虚拟物品不需要占格子
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then
            
        elseif(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            freeNum = freeNum - 1
        elseif(goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            freeNum = freeNum - 1
        elseif(goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
        elseif(goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
            
        elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
            freeNum = freeNum - 1
        else
            local maxNumOfStacks = 1
            local localData = GoodsDataManager:createLocalGoodsData(goodsData.goodsID)
            if(localData) then
                maxNumOfStacks = localData:getStackNum()
            end

            local num = goodsData.num
            if(goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
                for k, itemData in pairs(haveItemArr) do
                    if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                        num = num - (maxNumOfStacks - itemData:getNum())
                    end
                end
            end
            
            if(goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
                for k, itemData in pairs(haveMaterialArr) do
                    if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                        num = num - (maxNumOfStacks - itemData:getNum())
                    end
                end
            end

            if(goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then
                for k, itemData in pairs(haveTreasureArr) do
                    if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                        num = num - (maxNumOfStacks - itemData:getNum())
                    end
                end
            end

            if(goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                for k, itemData in pairs(haveGemStoneArr) do
                    if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                        num = num - (maxNumOfStacks - itemData:getNum())
                    end
                end
            end

            if(num >0) then
                freeNum = freeNum - math.modf(num / maxNumOfStacks)
                if(num % maxNumOfStacks ~= 0) then
                    freeNum = freeNum - 1
                end
            end
        end

        if(freeNum <0) then
            return false
        end
    end

    local haveStarPrayNum = GoodsDataManager:getGoodsArrForPK(master:getPK(), PACKET_TYPE.PACKET_STARPRAY, PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY)
    local freeNum = PublicDefine.CONST_DEFINITION.MAX_STARPRAY_BAG_NUM - #haveStarPrayNum

    for k,goodsData in pairs(goodsArr) do
        local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsData.goodsID)
        -- 虚拟物品不需要占格子            
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
            freeNum = freeNum - 1
        end
        if(freeNum < 0) then
            return false
        end
    end


    local havePetStoneNum = GoodsDataManager:getGoodsArrForPK(master:getPK(), PACKET_TYPE.PACKET_PET_GEMSTONE, PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
    local freeNum = PublicDefine.CONST_DEFINITION.MAX_PET_GEMSTONE_PACKET_NUM - #havePetStoneNum

    for k,goodsData in pairs(goodsArr) do
        local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsData.goodsID)
        -- 虚拟物品不需要占格子            
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
            freeNum = freeNum - 1
        end
        if(freeNum < 0) then
            return false
        end
    end

    return true
end




-- 判断是否有足够的格子
function GameDataManager:judgeEnoughPacket(goodsID, num, isGolden)
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then
        return true
    end

    local master = RoleDataManager:getMaster()
    local packetBoxBeUseNum = MasterDataManager:getAllBoxCanBeUseNum()

    -- 背包信息
    local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    local havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    local haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    local haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    local haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    local haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    local haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    

    local freeNum = packetBoxBeUseNum - #haveEquipmentArr - #havePetEquipmentArr - #haveItemArr - #haveMaterialArr - #haveGemStoneArr - #haveRelicArr - #haveTreasureArr
    if(freeNum >0) then
        return true
    end

    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        return false
    else
        local maxNumOfStacks = ConfigManager:getStackNumForTemplateID(goodsID)

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            for k, itemData in pairs(haveItemArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    num = num - (maxNumOfStacks - itemData:getNum())
                end
            end
        end
        
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
            for k, itemData in pairs(haveMaterialArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    num = num - (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then
            for k, itemData in pairs(haveTreasureArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    num = num - (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
            for k, itemData in pairs(haveGemStoneArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    num = num - (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        if(num >0) then
            freeNum = freeNum - math.modf(num / maxNumOfStacks)
            if(num % maxNumOfStacks ~= 0) then
                freeNum = freeNum - 1
            end
        end

        if(freeNum <0) then
            return false
        else
            return true
        end
    end

    return false
end


-- 获取添加物品的最大数量:-1为无限
function GameDataManager:getAddItemMaxNum(packetType,goodsID, isGolden)
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then
        return -1
    end

    local bagData = self:getPacketDataByPacketType(packetType)
    local petEquipNum = 0
    if(bagData.havePetEquipmentArr) then 
        petEquipNum = #bagData.havePetEquipmentArr
    end
    local freeNum = bagData.packetBoxBeUseNum - #bagData.haveEquipmentArr - petEquipNum - #bagData.haveItemArr - #bagData.haveMaterialArr - #bagData.haveGemStoneArr - #bagData.haveRelicArr
    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        return freeNum,freeNum
    else
        local maxNumOfStacks = ConfigManager:getStackNumForTemplateID(goodsID)
        local maxAddNum = 0
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            for k, itemData in pairs(bagData.haveItemArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    maxAddNum = maxAddNum + (maxNumOfStacks - itemData:getNum())
                end
            end
        end
        
        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
            for k, itemData in pairs(bagData.haveMaterialArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    maxAddNum = maxAddNum + (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then
            for k, itemData in pairs(bagData.haveTreasureArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    maxAddNum = maxAddNum + (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
            for k, itemData in pairs(bagData.haveGemStoneArr) do
                if itemData:getGoodsID() == goodsID and itemData:getIsGolden() == isGolden then
                    maxAddNum = maxAddNum + (maxNumOfStacks - itemData:getNum())
                end
            end
        end

        maxAddNum = maxAddNum + freeNum * maxNumOfStacks

        return maxAddNum,freeNum
    end

    return 0
end


--根据背包类型获取背包数据
function GameDataManager:getPacketDataByPacketType(packetType)
    if packetType == PACKET_TYPE.PACKET_BAG then
        return self:getPacketBoxData()
    elseif packetType == PACKET_TYPE.PACKET_WAREHOUSE then
        return self:getWearhouseData()
    end
end

-- 获取背包数据
function GameDataManager:getPacketBoxData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then return nil end

    -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
    local bagData = {}
    bagData.packetType = PACKET_TYPE.PACKET_BAG
    bagData.heroData = master
    
    -- 穿戴信息
    local packetType = self:getPacketType()    

    if(SceneManager:getInstance():isInHuLu()) then 
        GoodsDataManager:setPacketSubType(PublicDefine.PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)
        bagData.wearEquipmentArr = mvc.festivalModel:getHuluWearEquipmentArr()        
    else
        bagData.wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packetType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        bagData.wearPetEquipmentArr = MasterDataManager:getAllWearPetEquipment()
    end

    -- 背包能够使用的格子数
    bagData.packetBoxBeUseNum = MasterDataManager:getAllBoxCanBeUseNum()
    -- 背包最大格子数
    bagData.packetBoxMaxNum = self:getPacketBoxMaxNum()
    -- 获取背包解锁次数
    bagData.unlockBagTimes = MasterDataManager:getUnlockBagTimes()

    -- 背包信息
    bagData.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    bagData.havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    bagData.haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    bagData.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    bagData.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    bagData.haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    bagData.haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    bagData.haveGlyphArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_GLYPH,PublicDefine.GOODS_TYPE.GOODS_GLYPH)

    if DEBUG then
        print("GameDataManager:getPacketBoxData packetBoxBeUseNum,packetBoxMaxNum=",bagData.packetBoxBeUseNum,bagData.packetBoxMaxNum)
        print("GameDataManager:getPacketBoxData ",#bagData.haveEquipmentArr,#bagData.havePetEquipmentArr,#bagData.haveItemArr,#bagData.haveMaterialArr, #bagData.haveTreasureArr)

        self:_printBagData(bagData)
    end

    return bagData
end

-- 获取当前背包空闲数量
function GameDataManager:getWarehouseFreePacketBoxNum()
    -- 背包能够使用的格子数
    local wareData = self:getWearhouseData()

    return wareData.packetBoxBeUseNum 
        - #(wareData.haveEquipmentArr) 
        - #(wareData.haveItemArr) 
        - #(wareData.haveMaterialArr)
        - #(wareData.haveGemStoneArr)
        - #(wareData.haveRelicArr)
end

-- --获取宠物装备
-- function GameDataManager:getPetBagEquipmentData()
--     -- 玩家属性信息
--     local master = RoleDataManager:getMaster()
--     if (not master) then return nil end

--     -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
--     local bagData = {}
--     bagData.packetType = PACKET_TYPE.PACKET_WAREHOUSE
--     bagData.heroData = master
    
--     -- 背包能够使用的格子数
--     bagData.packetBoxBeUseNum = master:getWearhouseCanBeUseNum()
--     -- 背包最大格子数
--     bagData.packetBoxMaxNum = self:getPacketWarehouseMaxNum()
--     -- 获取背包解锁次数
--     bagData.unlockBagTimes = master:getUnlockWarehouseTimes()

--     -- 背包信息
--     bagData.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
--     bagData.havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
--     bagData.haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_ITEM)
--     bagData.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
--     bagData.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
--     bagData.haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_RELIC)

--     if DEBUG then
--         print("GameDataManager:getWearhouseData packetBoxBeUseNum,packetBoxMaxNum=",bagData.packetBoxBeUseNum,bagData.packetBoxMaxNum)
--         print("GameDataManager:getWearhouseData ",#bagData.haveEquipmentArr,#bagData.haveItemArr,#bagData.haveMaterialArr)
--     end

--     return bagData
-- end

--获取仓库数据
function GameDataManager:getWearhouseData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then return nil end

    -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
    local bagData = {}
    bagData.packetType = PACKET_TYPE.PACKET_WAREHOUSE
    bagData.heroData = master
    
    -- 背包能够使用的格子数
    bagData.packetBoxBeUseNum = master:getWearhouseCanBeUseNum()
    -- 背包最大格子数
    bagData.packetBoxMaxNum = self:getPacketWarehouseMaxNum()
    -- 获取背包解锁次数
    bagData.unlockBagTimes = master:getUnlockWarehouseTimes()

    -- 背包信息
    bagData.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    bagData.havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    bagData.haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    bagData.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    bagData.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    bagData.haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    bagData.haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    

    if DEBUG then
        print("GameDataManager:getWearhouseData packetBoxBeUseNum,packetBoxMaxNum=",bagData.packetBoxBeUseNum,bagData.packetBoxMaxNum)
        print("GameDataManager:getWearhouseData ",#bagData.haveEquipmentArr,#bagData.haveItemArr,#bagData.haveMaterialArr, #bagData.haveTreasureArr)
    end

    return bagData
end

-- 获取角色信息数据
function GameDataManager:getRoleInfoData(spriteID)
    local heroData = RoleDataManager:getRoleDataBySpriteID(spriteID)
    if (not heroData) then return nil end

    -- 组装背包数据，包括 玩家数据，穿戴装备
    local bagData = {}

    bagData.heroData = heroData
    
    -- 穿戴信息
    local packetType = self:getPacketType()    
    bagData.wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(spriteID,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    return bagData
end

-- 根据PK获取角色信息
function GameDataManager:getRoleInfoDataForPK(pk)
    local heroData = RoleDataManager:getHeroDataForPK(pk)

    if (not heroData) then return nil end

    -- 组装背包数据，包括 玩家数据，穿戴装备
    local bagData = {}
    bagData.heroData = heroData
    -- 穿戴信息
    local packetType = self:getPacketType()    
    bagData.wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(heroData:getSpriteID(),PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    return bagData
end

function GameDataManager:getActivityRankData()
    return self._activityRankData
end

function GameDataManager:clearActivityRankData()
    self._activityRankData = nil
end

function GameDataManager:setActivityRankData(data)
    self._activityRankData = {}
    self._activityRankData.rank = data.rank
    self._activityRankData.bagFull = data.bagFull

    -- 这里就不需要弹出结算提示了
    self:setIsShowReward(false)

    local goodsArr = {}
    if data.goodsIDs ~= nil and #data.goodsIDs ~= 0 then
        for k, v in pairs(data.goodsIDs) do
            local goodData = GoodsDataManager:getEquipmentForEntityID(v.entityID)
            if goodData ~= nil then
                table.insert(goodsArr, goodData)
            elseif v.templateID ~= 0 then
                local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
                if(goodData) then
                    goodData:setNum(v.num)
                    table.insert(goodsArr, goodData)
                end
            end
        end
    end

    self._activityRankData.goodsArr = goodsArr
end

function GameDataManager:handleUpdateMonsterData(data)
    if(data) then 
        if(self._nextBornTime > 0) then 
            if(self._nextBornTime ~= 0 and self._nextBornTime < data.nextBornTime - 5 and self._nextBornTime <= GameManager:getNormalServerTime() + 5) then
                self._nextBornTime = 0
                local languageID = self:_getCaveNoticeLanguageID()
                if(languageID) then 
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(languageID))
                end
            end
        end 

        self._nextBornTime = data.nextBornTime
    end
end

-- 获取奖励数据，用户结算以及日志
function GameDataManager:getRewardData()
    local master = RoleDataManager:getMaster()
    if (not master) then return nil end
    
    local isShowReward = self:getIsShowReward()
    -- print("GameDataManager:getRewardData",isShowReward)
    local rewardData = {}
    if isShowReward == false then
        -- 获得的金币，可以为负值
        rewardData.rewardCoin = master:getCurCoin() - master:getEnterCaveCoin()
        -- 获得的铭文，可以为负值
        rewardData.rewardInscription = master:getInscriptionNum() - master:getEnterCaveInscription()

        -- 获得相关的物品
        rewardData.equipmentArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        rewardData.itemArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_ITEM)
        rewardData.materialArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
        rewardData.gemStoneArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        rewardData.treasureArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_TREASURE)
        rewardData.petStoneArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
        

        rewardData.autoSellEquipmentArr = GoodsDataManager:getInCaveAutoSell(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        rewardData.autoSellItemArr = GoodsDataManager:getInCaveAutoSell(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_ITEM)
        rewardData.autoSellMaterialArr = GoodsDataManager:getInCaveAutoSell(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
        rewardData.autoSellGemStoneArr = GoodsDataManager:getInCaveAutoSell(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        rewardData.autoSellTreasureArr = GoodsDataManager:getInCaveAutoSell(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    else
        -- 根据保存的数据来做相关的逻辑处理
        rewardData = self:_getRewardDataFromSave()
    end

    return rewardData
end

function GameDataManager:getLostData()
    local master = RoleDataManager:getMaster()
    if (not master) then return nil end
    local lostData = {}

    -- 获得的金币，可以为负值
    lostData.rewardCoin = master:getCurCoin() - master:getEnterCaveCoin()
    lostData.rewardInscription = master:getInscriptionNum() - master:getEnterCaveInscription()
    lostData.goodsArr = {}

    -- 获得相关的物品
    local equipmentArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    local itemArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_ITEM)
    local materialArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    local gemStoneArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    local treasureArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    local petStoneArr = GoodsDataManager:getInCaveReward(master:getPK(),PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
    
    
    if(equipmentArr) then
        for _,goodsData in ipairs(equipmentArr) do 
            table.insert(lostData.goodsArr, goodsData)
        end
    end

    if(itemArr) then
        -- add by zp 根据规则过滤显示丢失掉的物品
        local fixItemIDArr = {}
        for k,v in pairs(PublicDefine.FixedItemIDs) do 
            fixItemIDArr[v] = v
        end

        for _,goodsData in ipairs(itemArr) do 
            local found = fixItemIDArr[goodsData:getId()] and true or false 
            if(not found) then 
                table.insert(lostData.goodsArr, goodsData)
            end
        end
    end

    if(materialArr) then
        for _,goodsData in ipairs(materialArr) do 
            table.insert(lostData.goodsArr, goodsData)
        end
    end

    if treasureArr then
        for _,goodsData in ipairs(treasureArr) do 
            table.insert(lostData.goodsArr, goodsData)
        end
    end

    if(gemStoneArr) then
        for _,goodsData in ipairs(gemStoneArr) do 
            table.insert(lostData.goodsArr, goodsData)
        end
    end

    if petStoneArr then
        for _,goodsData in ipairs(petStoneArr) do 
            table.insert(lostData.goodsArr, goodsData)
        end
    end

    return lostData
end

function GameDataManager:getIsShowReward()
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        return globalUserData:getIsShowReward()
    end

    return false
end

-- 获取该次成功回城是否为通关回城
function GameDataManager:getSuccessBackTownShowComment()
    if(self:getIsShowReward()) then
        return self:getIsGameComplete()
    end

    return false
end

-- 获取该次回城是否为使用回城卷轴回城
function GameDataManager:getEscapeScrollBackTownShowComment()
    if(self:getIsShowReward()) then
        return self:getEscapeScrollBackTown()
    end

    return false
end

function GameDataManager:setGuildBossBackTownTimeOut(flag)
    self.backTownFlag = flag
end

function GameDataManager:getGuildBossBackTownTimeOut()
    return self.backTownFlag
end

function GameDataManager:setGuildBossRewardData(data)
    if(data.pk == self:getMasterPK()) then 
        self.guildBossRewardData = {}

        for k,v in ipairs(data.goodsID) do
            if(data.goodsNum[k]) then 
                local goodsData = GoodsDataManager:createLocalGoodsData(v)
                if(goodsData) then 
                    goodsData:setNum(data.goodsNum[k])
                    goodsData:setIsNew(false)
                    table.insert(self.guildBossRewardData, goodsData)
                end
            end
        end
        local master = RoleDataManager:getMaster()
        self.guildBossRewardCoin = 0
        if(master) then
            self.guildBossRewardCoin = master:getCurCoin() - master:getEnterCaveCoin()
        end
    end
end

function GameDataManager:getGuildBossRewardData()
    return self.guildBossRewardData
end

function GameDataManager:getGuildBossCoin()
    if(self.guildBossRewardCoin) then
        return self.guildBossRewardCoin
    else 
        return 0
    end
end

function GameDataManager:clearGuildBossRewardData()
    self.guildBossRewardData = nil
    self.guildBossRewardCoin = 0
end

function GameDataManager:setIsFristSuccessBackTown()
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        globalUserData:fristSuccessBackTown()
    end
end

function GameDataManager:getIsFristSuccessBackTown()
    local globalUserData = self:getSaveGlobalData()
    local fristSuccess = false
    if(globalUserData) then
        fristSuccess = globalUserData:getFristSuccessBackTown()
    end

    if(fristSuccess == false) then 
        local heroData = RoleDataManager:getMaster()
        if(heroData) then
            local checkPoint = heroData:getCheckpointData(CAVE_MODE.MODE_NORMAL, CAVE_DIFFICULTY.DIFFICULTY_1)
            if(checkPoint and checkPoint:getCheckpoint() > 2001) then 
                fristSuccess = true 
            end
        end
    end

    return fristSuccess
end

function GameDataManager:setIsShowReward(flag, kickOutTownScroll)
    -- print("GameDataManager:setIsShowReward 1", flag)
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        local isShowReward = globalUserData:getIsShowReward()
        -- print("GameDataManager:setIsShowReward 2", flag, isShowReward)
        local rewardData = nil
        if(isShowReward ~= flag) then
            if(flag == true) then
                rewardData = self:_getForSaveRewardData()
            end

            if(rewardData and kickOutTownScroll) then 
                rewardData.kickOutTownScroll = kickOutTownScroll
            end

            if(flag) then
                isShowReward = flag
            else
                isShowReward = false
            end
            -- print("GameDataManager:setIsShowReward 3", flag, isShowReward)
            -- dump(rewardData)
            -- 保存状态
            globalUserData:setIsShowReward(isShowReward)
            globalUserData:setRewardData(rewardData)
        else 
            if(flag == true) then
                rewardData = globalUserData:getRewardData()
                if(rewardData and kickOutTownScroll) then 
                    rewardData.kickOutTownScroll = kickOutTownScroll
                end
            end
        end
        -- 存入本地
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType());
    end 
end

function GameDataManager:getIsGameComplete()
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        return globalUserData:getGameComplete()
    end

    return false
end

function GameDataManager:setIsGameComplete(gameComplete)
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        globalUserData:setGameComplete(gameComplete)
    end
end

function GameDataManager:getEscapeScrollBackTown()
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        return globalUserData:getEscapeScrollBackTown()
    end

    return false
end

function GameDataManager:setEscapeScrollBackTown(useScroll)
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        globalUserData:setEscapeScrollBackTown(useScroll)
    end
end

-- 获取背包的物品数据
function GameDataManager:getBagGoodsArrForType(goodsType)
    local PK = RoleDataManager:getMasterPK()
    return GoodsDataManager:getGoodsArrForPK(PK,PACKET_TYPE.PACKET_BAG,goodsType)
end

-- 获取仓库的物品数据
function GameDataManager:getWarehouseGoodsArrForType(goodsType)
    local PK = RoleDataManager:getMasterPK()
    return GoodsDataManager:getGoodsArrForPK(PK,PACKET_TYPE.PACKET_WAREHOUSE,goodsType)
end


-- 获取当前穿戴武器类型
function GameDataManager:getWearWeaponType()
    if(SceneManager:getInstance():isInHuLu()) then 
        return mvc.festivalModel:getHuluChoiceWeaponType()
    end
    local PK = RoleDataManager:getMasterPK()
    local packetType = self:getPacketType()

    local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(PK,packetType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    for _,equipmentData in pairs(wearEquipmentArr) do
        if(equipmentData:isWeapon()) then
            return equipmentData:getWeaponType()
        end
    end

    return 0
end

-- 根据spriteID获取穿戴武器类型
function GameDataManager:getWearWeaponTypeForSpriteID(spriteID)
    local wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(spriteID,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    for _,equipmentData in pairs(wearEquipmentArr) do
        if(equipmentData:isWeapon()) then
            return equipmentData:getWeaponType()
        end
    end

    return 0
end

-- 获取穿戴装备数据
function GameDataManager:getWearEquipmentData()
    local equipData = {}
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    local PK = RoleDataManager:getMasterPK()

    local packetType = self:getPacketType()    
    if(SceneManager:getInstance():isInHuLu()) then
        equipData.wearEquipmentArr = mvc.festivalModel:getHuluWearEquipmentArr()
    else
        -- 穿戴装备信息
        equipData.wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(PK,packetType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    end
    if master then
        equipData.spriteID = master:getSpriteID()
    end

    if DEBUG then
        for k,v in pairs(equipData.wearEquipmentArr) do
            print("GameDataManager:getWearEquipmentData ",k,v,v:getGoodsID())
        end
    end

    return equipData
end

-- 获取穿戴装备的头盔模版ID 用于头像
function GameDataManager:getWearHelmetTempId()
    local PK = RoleDataManager:getMasterPK()
    local packetType = self:getPacketType()   
    local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(PK,packetType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    for k, equipmentData in ipairs(wearEquipmentArr) do
        if(equipmentData:getEquipmentType() == EQUIPMENT_TYPE.Helmet) then
            return equipmentData:getGoodsID()
        end
    end
end

--获取穿戴装备数据  包括幻化数据
function GameDataManager:getWearTempId()
    local equipArr = self:getWearEquipmentData().wearEquipmentArr
    local idArr = {}
    for k, equipmentData in ipairs(equipArr) do 
        local illEquipID = ToolsUtil:getEquipmentIDForIllusionID(equipmentData:getIllusionID())
        if(illEquipID) then 
            table.insert(idArr, illEquipID)
        else 
            table.insert(idArr, equipmentData:getGoodsID())
        end
    end
    return idArr
end




-- 判断某个实例ID的装备是否是穿戴的装备
function GameDataManager:judgeIsEquipmentData(entityID)
   local wearData = self:getWearEquipmentData()
   if(wearData) then
        local equipmentArr = wearData.wearEquipmentArr
        if(equipmentArr) then
            for k,equipmentData in ipairs(equipmentArr) do 
                if(equipmentData:getEntityID() == entityID) then
                    return true
                end 
            end 
        end 
   end 

   return false
end

-- 获取穿戴套装激活数量
function GameDataManager:getWearSetActiveNum(equipSetID)
    local PK = RoleDataManager:getMasterPK()
    local packetType = self:getPacketType()    
    -- 穿戴装备信息
    local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(PK, packetType, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    local activeNum = self:calculationWearSetActiveNum(equipSetID, wearEquipmentArr)

    return activeNum
end

-- 计算穿戴激活套装数量
function GameDataManager:calculationWearSetActiveNum(equipSetID, wearEquipmentArr)
    local activeNum = 0
    for k,equipmentData in pairs(wearEquipmentArr) do
        if(equipmentData:getEquipSetID() == equipSetID) then
            activeNum = activeNum + 1
        end
    end

    return activeNum
end

-- 获取穿戴装备数据 根据PK
function GameDataManager:getWearEquipmentDataForPK(PK)
    local equipData = {}

    local heroData = RoleDataManager:getHeroDataForPK(PK)
    if(heroData) then
        equipData.spriteID = heroData:getSpriteID()

        if(SceneManager:getInstance():isInHuLu() and PK == RoleDataManager:getMasterPK()) then 
            bagData.wearEquipmentArr = mvc.festivalModel:getHuluWearEquipmentArr()        
        else
            equipData.wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(equipData.spriteID,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        end
    end

    return equipData
end

-- 获取穿戴装备数据 根据SpriteID
function GameDataManager:getWearEquipmentDataForSpriteID(spriteID)
    local equipData = {}
    equipData.spriteID = spriteID
    if(SceneManager:getInstance():isInHuLu()) then 
        local masterData = self:getMaster()
        if(masterData and spriteID == masterData:getSpriteID()) then 
            equipData.wearEquipmentArr = mvc.festivalModel:getHuluWearEquipmentArr()
        else
            equipData.wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(spriteID,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        end
    else
        equipData.wearEquipmentArr = GoodsDataManager:getGoodsArrForSpriteID(spriteID,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    end

    return equipData
end

-- 试穿装备
function GameDataManager:tryEquipment(tryEquipmentData) 
    local master = RoleDataManager:getMaster()

    if (tryEquipmentData and tryEquipmentData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        local wearEquipmentArr = self:getWearEquipmentData()

        local unWearArr = {}
        local equipmentType = tryEquipmentData:getEquipmentType()
        for _,equipmentData in ipairs(wearEquipmentArr.wearEquipmentArr) do
            if (equipmentData:getEquipmentType() == equipmentType) then
                table.insert(unWearArr,equipmentData)
            end
        end

        return master:tryEquipment(tryEquipmentData,unWearArr);
    else
        return nil
    end
end

-- 试穿装备
-- function GameDataManager:tryPetEquipment(petRoledata, tryEquipmentData) 
--     if (tryEquipmentData and tryEquipmentData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
--         local wearEquipmentArr = petRoledata:getWearEquipmentArr()

--         local unWearArr = {}
--         local equipmentType = tryEquipmentData:getEquipmentType()
--         for _,equipmentData in ipairs(wearEquipmentArr) do
--             if (equipmentData:getEquipmentType() == equipmentType) then
--                 table.insert(unWearArr,equipmentData)
--             end
--         end

--         return petRoledata:tryEquipment(tryEquipmentData,unWearArr);
--     else
--         return nil
--     end
-- end

--[[
    获取指定物品ID的数量
    goodsID:
    includeGolden: 是否包含点金
]]
function GameDataManager:getGoodsDataNumForGoodsID(goodsID, includeGolden, includeWarehouse, excludeLock)
    local PK = RoleDataManager:getMasterPK()    
    local heroData = RoleDataManager:getMaster()
    if goodsID == Game.ConstGoods.Coin then
        return heroData:getCurCoin(), 0
    elseif goodsID == Game.ConstGoods.Diamond then
        return heroData:getDiamond(), 0
    elseif goodsID == 23040001 then
        return heroData.curLVExp, 0
    elseif goodsID == 23470001 then
        return heroData:getInscriptionNum(), 0
    elseif goodsID == 23600001 then
        return heroData:getSouvenirLevelUp(), 0
    elseif goodsID == 23610001 then
        return heroData:getSouvenirLevelUp2(), 0
    elseif goodsID == 23590001 then
        return heroData:getPrimogeDebrisGreen(), 0
    elseif goodsID == 23620001 then
        return heroData:getTrialLevelUp(), 0
    end

    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

    local num = 0
    local function _getNum(goodsArr)
        local num = 0
        for k, goodsData in pairs(goodsArr) do
            if(goodsData:getId() == goodsID) 
                and (not excludeLock or (not goodsData:getIsLock()))
            then
                -- 这里有一些概念问题
                if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    if(includeGolden) then
                        num = num + 1
                    else
                        if(goodsData:getIsGolden() == false) then
                            num = num + 1
                        end
                    end
                else 
                    if(includeGolden) then
                        num = num + goodsData:getNum()
                    else
                        if(goodsData:getIsGolden() == false) then
                            num = num + goodsData:getNum()
                        end
                    end
                end
            end
        end
        return num
    end
    local goodsArr = GoodsDataManager:getGoodsArrForPK(PK, PACKET_TYPE.PACKET_BAG, goodsType)
    local num = _getNum(goodsArr)
    if includeWarehouse then
        goodsArr = GoodsDataManager:getGoodsArrForPK(PK, PACKET_TYPE.PACKET_WAREHOUSE, goodsType)
        return num, _getNum(goodsArr)
    end
    return num,0
end



--[[
    获取指定物品ID的数量
    goodsID:
    rarity: 物品质量
    exclusions: 不计算在内的物品
]]
function GameDataManager:getGoodsDataNumInRarityForGoodsID(goodsID, rarity, exclusions, idBound, isUseConfigRarity)
    exclusions = exclusions or {}
    local PK = RoleDataManager:getMasterPK()

    -- 内部方法检测是否在不计算物品以内
    local function isIncluded(num, numArray)
        for i,v in ipairs(numArray) do
            if (num == v) then return true end
        end
        return false
    end

    -- 内部方法检测是否在范围以内
    local function isInBound(num, bound)
        if (not bound) then return true end
        if (num >= bound[1] and num <= bound[2]) then return true end
        return false
    end
    
    -- 计算物品种类数量
    local function countNumForType(goodsID, goodsType, rarity, exclusions, idBound, isUseConfigRarity)
        local typeNum = 0
        local goodsArr = GoodsDataManager:getGoodsArrForPK(PK, PACKET_TYPE.PACKET_BAG, goodsType)
        for k, goodsData in pairs(goodsArr) do
            if((not isIncluded(goodsData:getId(), exclusions)) and
               (isInBound(goodsData:getId(), idBound)) and 
               (goodsID == nil or goodsData:getId() == goodsID)) then
                -- 根据参数获取游戏内稀有度(包括点金), 或配置稀有度(不包括点金)
                local goodsRarity = 0
                if (isUseConfigRarity == true) then
                    goodsRarity = goodsData:getGoodsConfigRare()
                else
                    goodsRarity = goodsData:getGoodsRare()
                end
                if (goodsRarity == 0) then print("=============GameDataManager:getGoodsDataNumInRarityForGoodsID, 获取配置稀有度信息错误!!!!!!!!") end

                if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    if(goodsRarity == rarity or rarity == nil) then
                        typeNum = typeNum + 1
                    end
                else 
                    if(goodsRarity == rarity or rarity == nil) then
                        typeNum = typeNum + goodsData:getNum()
                    end
                end
            end
        end
        return typeNum
    end

    local num = 0
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_ITEM, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_MATERIAL, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE, rarity, exclusions, idBound, isUseConfigRarity)
    num = num + countNumForType(goodsID, PublicDefine.GOODS_TYPE.GOODS_TREASURE, rarity, exclusions, idBound, isUseConfigRarity)
    
    return num
end

-- 获取快捷背包数据
function GameDataManager:getShortcutBagData()
    local PK = RoleDataManager:getMasterPK()
    local itemArr = GoodsDataManager:getGoodsArrForPK(PK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)

    local allItemArr = {}
    -- 合并相关数据
    local addGoodsData = nil
    local num = 0
    for k,goodsData in ipairs(itemArr) do
        if not addGoodsData then
            addGoodsData = Goods.ItemData:create(goodsData:getGoodsID())
            addGoodsData:initNetData(0,goodsData:getIsGolden(),goodsData:getIsLock())
            num = goodsData:getNum()
        else
            if addGoodsData:getGoodsID() ~= goodsData:getGoodsID() then
                addGoodsData:setNum(num)
                if addGoodsData:getIsAutoAddBar() then
                    table.insert(allItemArr,addGoodsData)
                end
                
                -- 拷贝一个数据
                addGoodsData = Goods.ItemData:create(goodsData:getGoodsID())
                addGoodsData:initNetData(0,goodsData:getIsGolden(),goodsData:getIsLock())
                num = goodsData:getNum()
            else
                num = num + goodsData:getNum()
            end
            -- if DEBUG then
            --     print("GameDataManager:getShortcutBagData  num,getNum=",num,goodsData:getNum())
            -- end
        end
    end
    if addGoodsData and addGoodsData:getIsAutoAddBar() then
        addGoodsData:setNum(num)
        table.insert(allItemArr,addGoodsData)
    end

    -- 对道具排序
    table.sort(allItemArr,function(a,b) 
        if a:getGoodsID() < b:getGoodsID() then
            return true
        end

        return false
    end)

    -- 添加辅助技能数据列表
    local skillArr = SkillDataManager:getMasterLearnAssistSkillList()
    -- if DEBUG then
    --     print("GameDataManager:getShortcutBagData skillArr num=",#skillArr)
    -- end
    local allArr = {}

    -- 添加辅助技能
    for k,skillData in ipairs(skillArr) do
        table.insert(allArr,skillData)
    end

    -- 添加道具
    for k,goodsData in ipairs(allItemArr) do
        table.insert(allArr,goodsData)
    end

    if DEBUG then
        for k,v in pairs(allArr) do
            print("GameDataManager:getShortcutBagData k,v,id,num=",k,v,v:getId(),v:getNum())
        end
    end

    for k, v in ipairs(allArr) do
        local data = {}
        data.targetCdTime = 0

        local oldData = self._shortcutBagCdList[v:getId()]
        if oldData then
            data.targetCdTime = oldData.targetCdTime
            v.targetCdTime = oldData.targetCdTime

            data.totalTime = oldData.totalTime
            v.totalTime = oldData.totalTime
        else 
            self._shortcutBagCdList[v:getId()] = data
        end
    end

    return allArr
end

-- 获取快捷背包数据
function GameDataManager:getShortcutBagMazeData()
    local addItemIDArr = {20150001, 20160001, 20170001}
    local allArr = {}
    for k, id in ipairs(addItemIDArr) do 
        local  addGoodsData = Goods.ItemData:create(id)
        addGoodsData:initNetData(999, false, false)
        table.insert(allArr,addGoodsData)
    end

    -- 对道具排序
    table.sort(allArr,function(a,b) 
        if a:getGoodsID() < b:getGoodsID() then
            return true
        end

        return false
    end)

    for k, v in ipairs(allArr) do
        local data = {}
        data.targetCdTime = 0

        local oldData = self._shortcutBagCdList[v:getId()]
        if oldData then
            data.targetCdTime = oldData.targetCdTime
            v.targetCdTime = oldData.targetCdTime

            data.totalTime = oldData.totalTime
            v.totalTime = oldData.totalTime
        else 
            self._shortcutBagCdList[v:getId()] = data
        end
    end

    return allArr
end

-- 获取快捷栏数据
function GameDataManager:getShortcutBarData()
    local shortcutBarArr = nil
    if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
        shortcutBarArr = GoodsDataManager:getShortcutBarLocal()
    else
        shortcutBarArr = GoodsDataManager:getShortcutBar()
    end
    

    -- if DEBUG then
    --     for k,v in ipairs(shortcutBarArr) do
    --         print("GameDataManager:getShortcutBarData ",v:getIndex(),v:getId())
    --     end
    -- end
    local tempList = {}
    for k, v in ipairs(shortcutBarArr) do
        local data = {}
        data.targetCdTime = 0
        tempList[v:getId()] = data

        local oldData = self._shortcutBarCdList[v:getId()]
        if oldData then
            data.targetCdTime = oldData.targetCdTime
            v.targetCdTime = oldData.targetCdTime

            data.totalTime = oldData.totalTime
            v.totalTime = oldData.totalTime
        else
            --和快捷背包的cd时间同步一下
            oldData = self._shortcutBagCdList[v:getId()]
            if oldData then
                data.targetCdTime = oldData.targetCdTime
                v.targetCdTime = oldData.targetCdTime

                data.totalTime = oldData.totalTime
                v.totalTime = oldData.totalTime
            end
        end
    end
    self._shortcutBarCdList = tempList
    return shortcutBarArr
end

-- 获取快捷栏数据
function GameDataManager:getMazeShortcutBarData()
    local shortcutBarArr = GoodsDataManager:getShortcutBarMaze()

    local tempList = {}
    for k, v in ipairs(shortcutBarArr) do
        local data = {}
        data.targetCdTime = 0
        tempList[v:getId()] = data

        local oldData = self._shortcutBarCdList[v:getId()]
        if oldData then
            data.targetCdTime = oldData.targetCdTime
            v.targetCdTime = oldData.targetCdTime

            data.totalTime = oldData.totalTime
            v.totalTime = oldData.totalTime
        else
            --和快捷背包的cd时间同步一下
            oldData = self._shortcutBagCdList[v:getId()]
            if oldData then
                data.targetCdTime = oldData.targetCdTime
                v.targetCdTime = oldData.targetCdTime

                data.totalTime = oldData.totalTime
                v.totalTime = oldData.totalTime
            end
        end
    end
    self._shortcutBarCdList = tempList
    return shortcutBarArr
end

-- 获取零时背包数据(未用)
function GameDataManager:getTemporaryData()
    local temporaryData = {}

    local pk = RoleDataManager:getMasterPK() 

    temporaryData.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    temporaryData.haveItemArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    temporaryData.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    temporaryData.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    temporaryData.haveRelicArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    temporaryData.haveTreasureArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_TEMPORARY,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    
    return temporaryData
end

-- 获取某个物品的数据
function GameDataManager:getGoodsDataNum(packetType,goodsID,includeGoldern)
    local pk = RoleDataManager:getMasterPK()  

    return GoodsDataManager:getGoodsDataNum(pk,packetType,goodsID,includeGoldern)
end

function GameDataManager:judgeIsShop(deep)
    if(deep >= CONST_DEFINITION.SHOP_LEVEL_MIN and deep < CONST_DEFINITION.SHOP_LEVEL_MAX) then
        return true
    end

    return false
end

function GameDataManager:getChangeSkillData()
    if(self._changeSkillData == nil) then 
        self._changeSkillData = {}
        local preSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_NORMAL, 1, nil, Game.SkillAdvanceType.AdvanceTypeOne)
        local nowSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_ADVANCED, 1, nil, Game.SkillAdvanceType.AdvanceTypeOne)

        local oneDiffrends = self:_handleSkillTree(preSkillTrees, nowSkillTrees)
        table.insert(self._changeSkillData, oneDiffrends)

        local preSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_NORMAL, 2, nil, Game.SkillAdvanceType.AdvanceTypeOne)
        local nowSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_ADVANCED, 2, nil,Game.SkillAdvanceType.AdvanceTypeOne)

        local oneDiffrends = self:_handleSkillTree(preSkillTrees, nowSkillTrees)
        table.insert(self._changeSkillData, oneDiffrends)

        local preSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_NORMAL, 3, nil, Game.SkillAdvanceType.AdvanceTypeOne)
        local nowSkillTrees = ConfigManager:getSkillTreeByType(SkillTreeModel.SKILL_TREE_MODEL_ADVANCED, 3, nil, Game.SkillAdvanceType.AdvanceTypeOne)

        local oneDiffrends = self:_handleSkillTree(preSkillTrees, nowSkillTrees)
        table.insert(self._changeSkillData, oneDiffrends)
    end

    return self._changeSkillData
end

function GameDataManager:_handleSkillTree(preSkillTrees, nowSkillTrees)
    local diffrentsArr = {}

    if(preSkillTrees and nowSkillTrees) then 
        -- 排序技能数
        table.sort(preSkillTrees, function(a, b) 
            if(a.storey == b.storey) then 
                if(a.skillGroupID < b.skillGroupID) then 
                    return true
                end

                return false
            end

            if(a.storey < b.storey) then 
                return true
            end

            return false
        end)

        for k,skillTree in pairs(preSkillTrees) do 
            if(skillTree.hidden == 0) then 
                for key, nowSkillTree in pairs(nowSkillTrees) do 
                    if(nowSkillTree.hidden == 0 and skillTree.skillGroupID == nowSkillTree.skillGroupID) then 
                        if(skillTree.skillIDList[1] ~= nowSkillTree.skillIDList[1]) then 
                            local oneAttr = {}
                            local preSkillData = SkillDataManager:createSkillForSkillId(skillTree.skillIDList[1])
                            local nowSkillData = SkillDataManager:createSkillForSkillId(nowSkillTree.skillIDList[1])

                            table.insert(oneAttr, preSkillData)
                            table.insert(oneAttr, nowSkillData)

                            table.insert(diffrentsArr, oneAttr)
                        end
                        break
                    end
                end
            end
        end 
    end

    return diffrentsArr
end

-- 打印背包数据
function GameDataManager:_printBagData(bagData)
    if bagData then
        print("GameDataManager:_printBagData test   packetBoxBeUseNum,packetBoxMaxNum=",bagData.packetBoxBeUseNum,bagData.packetBoxMaxNum)

        local equipNum = 0
        for k,v in pairs(bagData.haveEquipmentArr) do
            equipNum = equipNum + 1
        end

        local itemNum = 0
        for k,v in pairs(bagData.haveItemArr) do
            itemNum = itemNum + 1
        end

        local materialNum = 0
        for k,v in pairs(bagData.haveMaterialArr) do
            materialNum = materialNum + 1
        end

        local gemStoneNum = 0
        for k,v in pairs(bagData.haveGemStoneArr) do
            gemStoneNum = gemStoneNum + 1
        end

        local relicNum = 0
        for k,v in pairs(bagData.haveRelicArr) do
            relicNum = relicNum + 1
        end

        print("GameDataManager:_printBagData test   equipNum,itemNum,materialNum,gemStoneNum=",equipNum,itemNum,materialNum,gemStoneNum)

        for k,v in pairs(bagData.haveEquipmentArr) do
            print("GameDataManager:_printBagData test equipment  entityID,goodsID,num=",v:getEntityID(),v:getGoodsID(),v:getNum())
        end

        for k,v in pairs(bagData.haveItemArr) do
            print("GameDataManager:_printBagData test item  instanceID,goodsID,num,isGolden=",v:getInstanceID(),v:getGoodsID(),v:getNum(),v:getIsGolden(),v:getGoodsRare())
        end

        for k,v in pairs(bagData.haveMaterialArr) do
            print("GameDataManager:_printBagData test material  instanceID,goodsID,num,isGolden=",v:getInstanceID(),v:getGoodsID(),v:getNum(),v:getIsGolden())
        end
        for k,v in pairs(bagData.haveGemStoneArr) do
            print("GameDataManager:_printBagData test gemStone  instanceID,goodsID,num,isGolden=",v:getInstanceID(),v:getGoodsID(),v:getNum(),v:getIsGolden())
        end
        for k,v in pairs(bagData.haveRelicArr) do
            print("GameDataManager:_printBagData test relic  instanceID,goodsID,num,isGolden=",v:getInstanceID(),v:getGoodsID(),v:getNum(),v:getIsGolden())
        end
    end
end

-- 获取周围可以挖的墙
function GameDataManager:getDiggleWallCoordList(spriteID, radius, targetType)
    print("======GameDataManager:getDiggleWallCoordList")
    local GameInCaveManager = require("app.game.GameInCaveManager")
    local battleModel = GameInCaveManager:getInstance():getBattleModel()
    if (battleModel) then
        local role = battleModel:getRoleBySpriteID(spriteID)
        if (role) then
            local coord = role:getCoord()
            local coordX, coordY = 0, 0

            local state = role:getState()
            if (state == FSMState.IDLE or state == FSMState.WAITING) then
                coordX = Avalon.MathUtil:getInt(coord.x)
                coordY = Avalon.MathUtil:getInt(coord.y)
            elseif (state == FSMState.MOVE) then
                local direction = role:getDirection()
                if (direction == DirectionType.NORTH) then
                    coordX = coord.x
                    coordY = math.ceil(coord.y)
                elseif (direction == DirectionType.EAST) then
                    coordX = math.ceil(coord.x)
                    coordY = coord.y
                elseif (direction == DirectionType.SOUTH) then
                    coordX = coord.x
                    coordY = math.floor(coord.y)
                elseif (direction == DirectionType.WEAST) then
                    coordX = math.floor(coord.x)
                    coordY = coord.y
                else
                    assert(false)
                end
            else 
                assert(false)
            end
            
            return battleModel:getDiggableWallCoordList(coordX, coordY, radius, targetType)
        else
            assert(false)
        end
    end
    return nil
end

-- 获取周围可以到达的地块
function GameDataManager:getReachableCoordList(spriteID, radius)
    print("============GameDataManager:getReachableCoordList")
    local GameInCaveManager = require("app.game.GameInCaveManager")
    local battleModel = GameInCaveManager:getInstance():getBattleModel()
    if (battleModel) then
        local role = battleModel:getRoleBySpriteID(spriteID)
        if (role) then
            local coord = role:getCoord()
            local coordX, coordY = 0, 0

            local state = role:getState()
            if (state == FSMState.IDLE) then
                coordX = coord.x
                coordY = coord.y
            elseif (state == FSMState.MOVE) then
                local direction = role:getDirection()
                if (direction == DirectionType.NORTH) then
                    coordX = coord.x
                    coordY = math.ceil(coord.y)
                elseif (direction == DirectionType.EAST) then
                    coordX = math.ceil(coord.x)
                    coordY = coord.y
                elseif (direction == DirectionType.SOUTH) then
                    coordX = coord.x
                    coordY = math.floor(coord.y)
                elseif (direction == DirectionType.WEAST) then
                    coordX = math.floor(coord.x)
                    coordY = coord.y
                else
                    assert(false)
                end
            else 
                assert(false)
            end
            
            local mapData = battleModel:getMapData()
            if (mapData) then return mapData:getCoordinatesReachableInVisionRadius(coordX, coordY, radius)
            else assert(false)
            end
        else
            assert(false)
        end
    end
    return nil
end

-- 获取地图数据
function GameDataManager:getMapData()
    local GameInCaveManager = require("app.game.GameInCaveManager")
    local battleModel = GameInCaveManager:getInstance():getBattleModel()
    if (battleModel) then
        return battleModel:getMapData()
    else
        assert(false)
    end
end

-- private 
function GameDataManager:_getForSaveRewardData()
    local rewardData = self:getRewardData()

    local saveRewardData = {}

    saveRewardData.rewardCoin = rewardData.rewardCoin
    saveRewardData.rewardInscription = rewardData.rewardInscription

    -- 处理装备
    saveRewardData.equipmentArr = {}
    for _,equipmentData in ipairs(rewardData.equipmentArr) do
        table.insert(saveRewardData.equipmentArr,tostring(equipmentData:getEntityID()))
    end

    -- 处理道具
    saveRewardData.itemArr = {}
    for _,itemData in ipairs(rewardData.itemArr) do
        local num = saveRewardData.itemArr[tostring(itemData:getGoodsID())]
        if(num == nil) then
            num = itemData:getNum()
        else
            num = num+itemData:getNum()
        end

        saveRewardData.itemArr[tostring(itemData:getGoodsID())] = num
    end

    -- 处理材料
    saveRewardData.materialArr = {}
    for _,materialData in ipairs(rewardData.materialArr) do
        local num = saveRewardData.materialArr[tostring(materialData:getGoodsID())]
        if(num == nil) then
            num = materialData:getNum()
        else
            num = num+materialData:getNum()
        end

        saveRewardData.materialArr[tostring(materialData:getGoodsID())] = num
    end

    -- 处理宝石
    saveRewardData.gemStoneArr = {}
    for _,gemStoneData in ipairs(rewardData.gemStoneArr) do
        local num = saveRewardData.gemStoneArr[tostring(gemStoneData:getGoodsID())]
        if(num == nil) then
            num = gemStoneData:getNum()
        else
            num = num+gemStoneData:getNum()
        end

        saveRewardData.gemStoneArr[tostring(gemStoneData:getGoodsID())] = num
    end

    -- 处理宝物
    saveRewardData.treasureArr = {}
    for _,treasureData in ipairs(rewardData.treasureArr) do
        local num = saveRewardData.treasureArr[tostring(treasureData:getGoodsID())]
        if(num == nil) then
            num = treasureData:getNum()
        else
            num = num+treasureData:getNum()
        end

        saveRewardData.treasureArr[tostring(treasureData:getGoodsID())] = num
    end

    -- 处理宠物装备宝石
    saveRewardData.petStoneArr = {}
    for _,petStoneData in ipairs(rewardData.petStoneArr) do
        table.insert(saveRewardData.petStoneArr,tostring(petStoneData:getEntityID()))
    end

    ----------- 处理会自动卖掉的物品

    saveRewardData.autoSellEquipmentArr = {}
    for _,equipmentData in ipairs(rewardData.autoSellEquipmentArr) do
        table.insert(saveRewardData.autoSellEquipmentArr,
            { goodsID = tostring(equipmentData:getGoodsID()), seed = tostring(equipmentData:getSeed())})
    end

    -- 处理道具
    saveRewardData.autoSellItemArr = {}
    for _,itemData in ipairs(rewardData.autoSellItemArr) do
        local num = saveRewardData.autoSellItemArr[tostring(itemData:getGoodsID())]
        if(num == nil) then
            num = itemData:getNum()
        else
            num = num+itemData:getNum()
        end

        saveRewardData.autoSellItemArr[tostring(itemData:getGoodsID())] = num
    end

    -- 处理材料
    saveRewardData.autoSellMaterialArr = {}
    for _,materialData in ipairs(rewardData.autoSellMaterialArr) do
        local num = saveRewardData.autoSellMaterialArr[tostring(materialData:getGoodsID())]
        if(num == nil) then
            num = materialData:getNum()
        else
            num = num+materialData:getNum()
        end

        saveRewardData.autoSellMaterialArr[tostring(materialData:getGoodsID())] = num
    end

    -- 处理宝石
    saveRewardData.autoSellGemStoneArr = {}
    for _,gemStoneData in ipairs(rewardData.autoSellGemStoneArr) do
        local num = saveRewardData.autoSellGemStoneArr[tostring(gemStoneData:getGoodsID())]
        if(num == nil) then
            num = gemStoneData:getNum()
        else
            num = num+gemStoneData:getNum()
        end

        saveRewardData.autoSellGemStoneArr[tostring(gemStoneData:getGoodsID())] = num
    end
    
    -- 处理宝物
    saveRewardData.autoSellTreasureArr = {}
    for _,treasureData in ipairs(rewardData.autoSellTreasureArr) do
        local num = saveRewardData.autoSellTreasureArr[tostring(treasureData:getGoodsID())]
        if(num == nil) then
            num = treasureData:getNum()
        else
            num = num+treasureData:getNum()
        end

        saveRewardData.autoSellTreasureArr[tostring(treasureData:getGoodsID())] = num
    end
 
    return saveRewardData
end

function GameDataManager:_getRewardDataFromSave()
    local saveRewardData = nil
    local globalUserData = self:getSaveGlobalData()
    if(globalUserData) then
        saveRewardData = globalUserData:getRewardData()
    end

    local rewardData = {}

    rewardData.rewardCoin = saveRewardData.rewardCoin
    rewardData.kickOutTownScroll = saveRewardData.kickOutTownScroll
    rewardData.rewardInscription = saveRewardData.rewardInscription

    -- 处理装备
    rewardData.equipmentArr = {}
    local pk = self:getMasterPK()
    local packetType = PACKET_TYPE.PACKET_BAG
    local goodsType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    for _,entityID in pairs(saveRewardData.equipmentArr) do
        entityID = tonumber(entityID)
        local equipmentData = GoodsDataManager:getEquipmentDataForEntityID(pk,packetType,goodsType,entityID)
        if (equipmentData) then
            table.insert(rewardData.equipmentArr,equipmentData)
        else
            equipmentData = GoodsDataManager:getEquipmentDataForEntityID(pk,PACKET_TYPE.PACKET_EQUIPMENT,goodsType,entityID)

            if(equipmentData) then
                table.insert(rewardData.equipmentArr,equipmentData)
            end 
        end
    end

    -- 处理道具
    rewardData.itemArr = {}
    for goodsID,num in pairs(saveRewardData.itemArr) do
        local itemData =  GoodsDataManager:getGoodsData(packetType, tonumber(goodsID), true, 0)
        if(itemData) then
            itemData = clone(itemData)
            if (itemData) then
                itemData:setNum(num)

                table.insert(rewardData.itemArr,itemData)
            end
        end 
    end

    -- 处理材料
    rewardData.materialArr = {}
    for goodsID,num in pairs(saveRewardData.materialArr) do
        local itemData =  GoodsDataManager:getGoodsData(packetType, tonumber(goodsID), true, 0)
        if (itemData) then
            itemData = clone(itemData)
            itemData:setNum(num)

            table.insert(rewardData.materialArr,itemData)
        end
    end

    -- 处理宝石
    rewardData.gemStoneArr = {}
    for goodsID,num in pairs(saveRewardData.gemStoneArr) do
         local itemData =  GoodsDataManager:getGoodsData(packetType, tonumber(goodsID), true, 0)
        itemData = clone(itemData)
        if (itemData) then
            itemData:setNum(num)
            table.insert(rewardData.gemStoneArr,itemData)
        end
    end

    -- 处理宝物
    rewardData.treasureArr = {}
    for goodsID,num in pairs(saveRewardData.treasureArr) do
         local itemData =  GoodsDataManager:getGoodsData(packetType, tonumber(goodsID), true, 0)
        itemData = clone(itemData)
        if (itemData) then
            itemData:setNum(num)
            table.insert(rewardData.treasureArr,itemData)
        end
    end

    -- 处理宠物装备宝石
    rewardData.petStoneArr = {}
    local pk = self:getMasterPK()
    local packetType = PACKET_TYPE.PACKET_PET_GEMSTONE
    local goodsType = PublicDefine.GOODS_TYPE.GOODS_PET_STONE
    for _,entityID in pairs(saveRewardData.petStoneArr) do
        entityID = tonumber(entityID)
        local petStoneData = GoodsDataManager:getEquipmentDataForEntityID(pk,packetType,goodsType,entityID)
        if (petStoneData) then
            table.insert(rewardData.petStoneArr,petStoneData)
        else
            petStoneData = GoodsDataManager:getEquipmentDataForEntityID(pk,PACKET_TYPE.PACKET_PET_GEMSTONE,goodsType,entityID)

            if(petStoneData) then
                table.insert(rewardData.petStoneArr,petStoneData)
            end 
        end
    end

    ---------------- 处理自动卖掉的物品

    -- 处理装备
    rewardData.autoSellEquipmentArr = {}
    local pk = self:getMasterPK()
    local packetType = PACKET_TYPE.PACKET_BAG
    local goodsType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    if(saveRewardData.autoSellEquipmentArr) then
        for _,data in pairs(saveRewardData.autoSellEquipmentArr) do
            if(data.goodsID and data.seed) then
                local goodsID = tonumber(data.goodsID)
                local seed = tonumber(data.seed)

                local equipmentData = GoodsDataManager:createEquipmentForEquipmentID(goodsID)
                if(equipmentData) then 
                    equipmentData:setSeed(seed)
                    table.insert(rewardData.autoSellEquipmentArr,equipmentData)
                end
            end
        end
    end

    -- 处理道具
    rewardData.autoSellItemArr = {}
    if(saveRewardData.autoSellItemArr) then
        for goodsID,num in pairs(saveRewardData.autoSellItemArr) do
            local itemData = GoodsDataManager:createLocalGoodsData(tonumber(goodsID))
            if(itemData) then
                itemData:setNum(num)
                table.insert(rewardData.autoSellItemArr,itemData)
            end 
        end
    end

    -- 处理材料
    rewardData.autoSellMaterialArr = {}
    if(saveRewardData.autoSellMaterialArr) then
        for goodsID,num in pairs(saveRewardData.autoSellMaterialArr) do
            local itemData = GoodsDataManager:createLocalGoodsData(tonumber(goodsID))
            if (itemData) then
                itemData:setNum(num)

                table.insert(rewardData.autoSellMaterialArr,itemData)
            end
        end
    end

    -- 处理宝石
    rewardData.autoSellGemStoneArr = {}
    if(saveRewardData.autoSellGemStoneArr) then 
        for goodsID,num in pairs(saveRewardData.autoSellGemStoneArr) do
            local itemData = GoodsDataManager:createLocalGoodsData(tonumber(goodsID))
            if (itemData) then
                itemData:setNum(num)
                table.insert(rewardData.autoSellGemStoneArr,itemData)
            end
        end
    end

    -- 处理宝物
    rewardData.autoSellTreasureArr = {}
    if(saveRewardData.autoSellTreasureArr) then 
        for goodsID,num in pairs(saveRewardData.autoSellTreasureArr) do
            local itemData = GoodsDataManager:createLocalGoodsData(tonumber(goodsID))
            if (itemData) then
                itemData:setNum(num)
                table.insert(rewardData.autoSellTreasureArr,itemData)
            end
        end
    end

    return rewardData
end

-- 获取物品所在的背包位置
function GameDataManager:getGoodsPacketTypeForPacketType(goodsData, packetType)
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC)
    then

        return self:getGoodsPacketType(goodsData)
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
        if mvc.starPrayModel:isEquiped(goodsData) then
            return PACKET_TYPE.PACKET_STARPRAY_WEAR
        end
        return PACKET_TYPE.PACKET_STARPRAY
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        return PACKET_TYPE.PACKET_PET_GEMSTONE
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        return PACKET_TYPE.PACKET_GLYPH
    else
        if(packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            return packetType
        else
            return PACKET_TYPE.PACKET_BAG
        end
    end
end

--根据道具数据返回该道具所在背包位置
function GameDataManager:getGoodsPacketType(goodsData)
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        local goodsType = goodsData:getType()
        -- 多格装备的时候需要修改
        local packetType = self:getPacketType()    
        -- 穿戴装备信息
        local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(),packetType,goodsType)

        for i = 1, #wearEquipmentArr do
            local equipmentData = wearEquipmentArr[i]
            if(equipmentData) then
                if equipmentData:getEntityID() == goodsData:getEntityID() then
                    return packetType
                end
            end
        end

        -- 处理判断是否在仓库里面
        local temporaryEquipmentArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(), PACKET_TYPE.PACKET_WAREHOUSE, goodsType)
        for i = 1, #temporaryEquipmentArr do
            local equipmentData = temporaryEquipmentArr[i]
            if(equipmentData) then
                if equipmentData:getEntityID() == goodsData:getEntityID() then
                    return PACKET_TYPE.PACKET_WAREHOUSE
                end
            end
        end

        return PACKET_TYPE.PACKET_BAG
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
        local temporaryRelicArr = GoodsDataManager:getGoodsArrForPK(self:getMasterPK(), PACKET_TYPE.PACKET_WAREHOUSE, PublicDefine.GOODS_TYPE.GOODS_RELIC)
        for i = 1, #temporaryRelicArr do
            local relicData = temporaryRelicArr[i]
            if(relicData) then
                if relicData:getEntityID() == goodsData:getEntityID() then
                    return PACKET_TYPE.PACKET_WAREHOUSE
                end
            end
        end

        return PACKET_TYPE.PACKET_BAG
    else
        -- TODO 注意这里的数据处理

        return PACKET_TYPE.PACKET_BAG
    end
end

function GameDataManager:getLuckDropItemList(dropId)

end

function GameDataManager:getTurnTableData()
    return MasterDataManager:getTurnTableData()
end

function GameDataManager:isOutForTurnTableData()
    if self:getTurnTableData().dropListId == 0 then
        return true
    end
    local curTime = GameManager:getNowServerTime()
    local generateTime = self:getTurnTableData().generateTime or 0
    if generateTime == 0 then
        return true
    end
    local curDay = math.modf(curTime/SECONDS_ONE_DAY)
    local generateDay = math.modf(generateTime/SECONDS_ONE_DAY)
    local isOutOfDate = false
    if(curDay > generateDay) then
        -- 有超过一天没有刷新了
        isOutOfDate = true
    end
    return isOutOfDate
end

function GameDataManager:setTurnTableData(dropListId, hasBuyNum, leftTurnNum, hasTurnNum, generateTime)
    local turnTableData = self:getTurnTableData()
    MasterDataManager:setTurnTableData(dropListId, hasBuyNum, leftTurnNum, hasTurnNum, generateTime)
end

function GameDataManager:clearTurnTableData()
    MasterDataManager:clearTurnTableData()
end

--[[
    type            上传类型 定义在 SubmitExtraDataType
    roleId          角色id
    roleName        角色名字
    roleLevel       角色等级
    zoneId          服务器ID
    zoneName        服务器名字
    roleCTime       角色创建时间
    roleLevelMTime  角色信息变动时间(比如等级)
    guildId         公会ID
    guildName       公会名字
    coin            当前金币数量
    diamond         当前钻石数量
]]
function GameDataManager:submitExtraData(type)
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end
    local params = {
        type = tostring(type),
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
    }
    SdkBox:getInstance():submitExtraData(params)
end

-- 激活游戏
function GameDataManager:activity()
    -- 如果是第一次打开游戏  先激活
    local is_activity = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.is_activity, false)
    print("is_activity",is_activity)
    if  is_activity then
        return;
    end
    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.is_activity, true)

    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)

    local gameLoginManager = require("app.game.GameLoginManager")
    local params = {
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        extend = ext
    }
    -- dump(params,"激活客户端统计")
    SdkBox:getInstance():activity(params)
end

function GameDataManager:createAccountreport()
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end

    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)

    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        extend = ext
    }
    -- dump(params,"创建账号统计")
    SdkBox:getInstance():createAccountreport(params)
end
-- 创建角色
function GameDataManager:createRolereport()
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end

    local eventToken = ""
    local platform =  SdkBox:getInstance():getVersionPlatform()
    if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        eventToken = "hjs358"
    elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        eventToken = "2ztban"
    end 
    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)
    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        extend = ext,
        eventToken = eventToken
    }
    -- dump(params,"创建角色统计")
    SdkBox:getInstance():createRolereport(params)
end
-- 登陆统计
function GameDataManager:loginreport()
    require("app.utils.ServerConfigUtil")
    -- 如果是创建的新账号 先统计创建账号 和创建角色信息
    if self._isNewAccount == 1 then
        self:createAccountreport();
        self:createRolereport();
    end
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end
    
    local eventToken = ""
    local platform =  SdkBox:getInstance():getVersionPlatform()
    if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        eventToken = "susttg"
    elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        eventToken = "w99780"
    end
    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID(),
        projectId = ServerConfigUtil:getProjectId()
    }
    print("projectId:", ServerConfigUtil:getProjectId())
    dump("extParam1s:", extParams)
    ext = json.encode(extParams)
    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        onlineTime = "0",
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        loginType = "1",
        newAccount = tostring(self._isNewAccount),
        extend = ext,
        packageVersion = AvalonUtil.getPackageVersion(),
        localVersion = Avalon.HotfixManager:getLocalVersion(),
        eventToken = eventToken,
    }
    -- dump(params,"角色登陆统计")
    SdkBox:getInstance():loginreport(params)
end
function GameDataManager:logoutreport()
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end
    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID(),
        projectId = ServerConfigUtil:getProjectId()
    }
    print("projectId:", ServerConfigUtil:getProjectId())
    dump("extParam1s:", extParams)
    ext = json.encode(extParams)
    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        onlineTime = "0",
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        loginType = tostring(self._isReplace),
        newAccount = tostring(self._isNewAccount),
        extend = ext
    }
    -- dump(params,"角色登出统计")
    SdkBox:getInstance():logoutreport(params)
end
-- 支付之后数据上报
function GameDataManager:payReport(buyType,price,transactionIdentifier,iapID,buyNum,productID)
    if CONFIG_SHOW_DEBUG_PANEL then
        print("!!!!! forbiden payReport when it is debug mode")
        return
    end
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end

    local eventToken = ""
    local platform =  SdkBox:getInstance():getVersionPlatform()
    if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        eventToken = "zfrjyt"
    elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        eventToken = "ea6vd0"
    end

    local orderType = 0
    if (deviceTarget == cc.PLATFORM_OS_WINDOWS or deviceTarget == cc.PLATFORM_OS_MAC) then
        orderType = 2
    else
        orderType = 1
    end

    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)

    local params = {
        -- 第三方订单ID
        iapID = iapID,
        productID = productID,
        orderId = transactionIdentifier,
        orderType = orderType,
        productType = buyType,
        count = buyNum or 1,
        price = price,
        totalPrice = buyNum * price / 100,
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time() * 1000),
        onlineTime = "0",
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        loginType = tostring(self._isReplace),
        newAccount = tostring(self._isNewAccount),
        extend = 1,  -- 该字段在雷霆统计的时候作为了moneyType 来使用，相当于底层而言没有扩展字段
        extend2 = ext, -- 该字段用于处理前面的扩展字段传输
        eventToken = eventToken,
        platform = SdkBox:getInstance():getVersionPlatform()
    }

    -- dump(params,"角色登出统计")
    SdkBox:getInstance():pay(params)
    
end

function GameDataManager:finishCaveGuildReport()
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end

    local eventToken = ""
    local platform =  SdkBox:getInstance():getVersionPlatform()
    if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        eventToken = "gsfiig"
    elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        eventToken = "rhv20d"
    end
    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)
    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        onlineTime = "0",
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        loginType = tostring(self._isReplace),
        newAccount = tostring(self._isNewAccount),
        extend = ext,
        eventToken = eventToken
    }
    -- dump(params,"角色登出统计")
    SdkBox:getInstance():finishCaveGuild(params)
end

function GameDataManager:enterNormalShopCaveReport(shopLevel)
    print("-----------------enterNormalShopCaveReport ", shopLevel)
    local heroData = RoleDataManager:getMaster()
    local gameLoginManager = require("app.game.GameLoginManager")
    local guildData = MasterDataManager:getGuildData() or {}
    if not heroData or not guildData then return;end

    local eventToken = ""
    local platform =  SdkBox:getInstance():getVersionPlatform()
    if platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        local eventTokens = {[11] = "9dbzs7", [31] = "1mny6t", [91] = "l6j5e1"}
        eventToken = eventTokens[shopLevel]
    elseif platform == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        local eventTokens = {[11] = "ju20nt", [31] = "z5v6rd", [91] = "6jqlb7"}
        eventToken = eventTokens[shopLevel]
    end
    if eventToken == nil then
        print("---!!!!not find adjust eventToken when shopLevel is ", shopLevel)
        return
    end
    local ext = ""
    local extParams = {
        oaid = AvalonUtil.getOAID()
    }
    ext = json.encode(extParams)
    local params = {
        roleId = tostring(self:getMasterPK()),
        roleName = heroData:getNickName(),
        roleLevel = tostring(heroData:getLevel()),
        zoneId = tostring(gameLoginManager:getInstance():getServerId()),
        zoneName = tostring(gameLoginManager:getInstance():getServerId()),
        roleCTime = tostring(os.time() * 1000),
        roleLevelMTime = tostring(os.time() * 1000),
        guildId = tostring(guildData.ID or ""),
        guildName = tostring(guildData.name or "none"),
        coin = tostring(heroData:getCurCoin()),
        diamond = tostring(heroData:getDiamond()),
        account = tostring(self:getLogMonitorAccount()),
        logtime = tostring(os.time()*1000),
        onlineTime = "0",
        osVersion = AvalonUtil.getSystemVersion(),
        deviceName = AvalonUtil.getDeviceName(),
        idfa = AvalonUtil.getIDFA(),
        imei = AvalonUtil.getIMEI(),
        mac = AvalonUtil.getMAC(),
        loginType = tostring(self._isReplace),
        newAccount = tostring(self._isNewAccount),
        extend = ext,
        eventToken = eventToken,
        shopLevel = tostring(shopLevel)
    }
    -- dump(params,"角色登出统计")
    SdkBox:getInstance():EnterNormalShopCave(params)
end

function GameDataManager:getLogMonitorAccount()
    local gameLoginManager = require("app.game.GameLoginManager")
    local account = tostring(gameLoginManager:getInstance():getAccountId())
    if(CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE
        or CAVEOL_TARGET == CAVEOL_TARGET_CN
        or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then 
        local arr = string.split(account, "_")
        if(arr and #arr == 2) then 
            account = SdkBox:getSubChannel().. arr[2]
        end
    end
    print("getLogMonitorAccount", account)
    return account
end

-- 设置是否是新账号,创建角色就是新账号,否则就是老账号
function GameDataManager:setNewAccount()
    -- print("设置为新账号")
    self._isNewAccount = 1
end
function GameDataManager:setAccountReplace()
    self._isReplace = 2
end
--funnyServerDataes 为空 获取自己的趣味数据， 不为空获取 funnyServerDataes 对应玩家的数据
function GameDataManager:getFunnyRecords(funnyServerDataes)
    local funnyDataes = {}
    local funnyCfgDataes =  ConfigManager:getAllFunnyRecord()
    funnyServerDataes = funnyServerDataes or MasterDataManager:getFunnyRecord()
    for k, v in ipairs(funnyCfgDataes) do
        local data = {}
        data.id = v.id
        data.name = v.name
        data.icon = v.icon
        data.score = 0
        for typeKey, typeValue in ipairs(v.types) do
            data.score = data.score + (funnyServerDataes[typeValue] or 0)
        end
        table.insert(funnyDataes, data)
    end 
    table.sort(funnyDataes, function(a, b)
        return a.id < b.id
    end)
    return funnyDataes
end

function GameDataManager:getNPCData(spriteID)
    return RoleDataManager:getRoleDataBySpriteID(spriteID)
end

--[[targetCdTime: 目标时间搓 totalTime：总共cd的时间，用于计算百分比]]
function GameDataManager:setShcutBagCdList(templateId, addCdTime)
    local data = self._shortcutBagCdList[templateId]
    if data then
        data.targetCdTime = AvalonUtil.getCurrentTime() + addCdTime * 1000
        data.totalTime = addCdTime
    end
end

function GameDataManager:setShcutBarCdList(templateId, addCdTime)
    local data = self._shortcutBarCdList[templateId]
    if data then
        data.targetCdTime = AvalonUtil.getCurrentTime() + addCdTime * 1000
        data.totalTime = addCdTime
    end
end

function GameDataManager:getAllRoleTalents()
    local subTalentList = MasterDataManager:getRoleTalents()
    local mainTalentList = {}
    for k, v in pairs(subTalentList) do
        if self:checkMainTalentIdIsUnlock(v.type) then
            local mainData = mainTalentList[v.type]
            if mainData == nil then
                mainData = ConfigManager:getMainRoleTalentById(v.type)
                mainData.list = {}
                mainData.totalLv = 0
                mainTalentList[v.type] = mainData
            end
            table.insert(mainData.list, v)
            mainData.totalLv = mainData.totalLv + v.curLv
        end
    end
    return mainTalentList
end

function GameDataManager:getRoleTalentLimitLv(id)
    local subTalentList = MasterDataManager:getRoleTalents()
    local totalLv = 0
    local size = 0
    for k, v in pairs(subTalentList) do
        if v.type == id then
            totalLv = totalLv + v.curLv
            size = size + 1
        end
    end
    size = size == 0 and 1 or size
    local limitLv = math.floor(totalLv / size) + 2
    return limitLv
end

function GameDataManager:checkMainTalentIdIsUnlock(type)
    local isUnlock = false
    local masterData = RoleDataManager:getMaster()
    local reincarntionLv = masterData:getReincarntionLv()
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
    local mainTalentIdList = {}
    if config and config ~= {} then
        local mainTalentIdStr = string.split(config.mainTalentId, ";")
        for k, v in pairs(mainTalentIdStr) do
            mainTalentIdList[tonumber(v)] = true
        end
    end
    
    if mainTalentIdList[type] then
        isUnlock = true
    end
    return isUnlock
end

function GameDataManager:isActiveExtertnTalentSkill(mainTalentType)
    local subTalentList = MasterDataManager:getRoleTalents()
    local mainData = ConfigManager:getMainRoleTalentById(mainTalentType)
    if mainData == nil or subTalentList == nil then
        return false
    end
    local totalLv = 0
    for k, v in pairs(subTalentList) do
        if v.type == mainTalentType then
            totalLv = totalLv + v.curLv
        end
    end
    
    if totalLv >= mainData.skillActiveLV then
        return true
    end
    return false
end

function GameDataManager:refreshAllDreamData(netData)
    local cfgData = ConfigManager:getDreamConfigForLV(netData.lv)
    if cfgData == nil then--第一次找不到 默认是满级了
        cfgData = ConfigManager:getDreamConfigForLV(netData.lv - 1)
    end
    if cfgData == nil then
        return {}
    end
    for k, v in ipairs(netData.bossInfos) do
        v.dropNumber = cfgData.dreamPiece[k] or 0
    end
    return netData
end

function GameDataManager:_getCaveNoticeLanguageID()
    local level = GameMapManager:getInstance():getLevel()
    local languageID = nil
    if(level == PublicDefine.CONST_DEFINITION.SPRING_FESTIVAL_MAP_ID) then 
        languageID = 1111568
    elseif(level == PublicDefine.CONST_DEFINITION.EASTER_MAP_ID) then 
        languageID = 1111906
    end

    return languageID
end

--[[
    uint32 gotNum = 1;     //获取次数
    uint32 usedNum = 2;    //使用次数
    uint32 maxNum = 3;     //最大获取次数 
    bool isOpen = 4;     //是否开放广告 
]]
function GameDataManager:setAdvertData(netdata)
    self._advertData = netdata.data.infos
    local SdkBox = require("utils.sdkbox.SdkBox")
    local adsVersion = SdkBox:getInstance():getAdsVersion()
    --[[
        beta: 0.4.8 adsVersion = 1
        beta: 0.5.0 adsVersion = 2

        offcial: 1.6.7 adsVersion = 1
        offcial: 1.7.1 adsVersion = 2
        beta 048还用的老表，official 1.6.7用的新表， 老表就直接关闭广告功能
    ]]
 


    if CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
        if adsVersion < 2 then
            for k, v in ipairs(self._advertData) do
                v.isOpen = false
            end
        end
    elseif CAVEOL_TARGET == CAVEOL_TARGET_CN then
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
        and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
        and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK
        and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
        then
            for k, v in ipairs(self._advertData) do
                v.isOpen = false
            end
        end
    elseif CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        local adClose = false
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_AMAZON
            or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_ONESTORE
            or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_HUAWEI_GLOBAL then
            adClose = true
        end
        
        if adClose or adsVersion < 1 then
            for k, v in ipairs(self._advertData) do
                v.isOpen = false
            end
        end
    else 
        if adsVersion < 1 then
            for k, v in ipairs(self._advertData) do
                v.isOpen = false
            end
        end
    end
end

function GameDataManager:getAllAdvertData()
    return self._advertData
end
 
function GameDataManager:getAdvertDataBySerAdid(serAdid)
    if self._advertData[serAdid + 1] == nil then
        -- return {isOpen = true, gotNum = 3, usedNum = 3, maxNum = 6}
        return {}
    end
    return self._advertData[serAdid + 1]
end

function GameDataManager:isOpenAdsBySerAdid(serAdid)
    local data = self._advertData[serAdid]
    if data == nil then
        return false
    end
    return data.isOpen
end

function GameDataManager:setGuildRecruitMessage(msg)
    self._guildRecruitMessage = msg
end

function GameDataManager:getGuildRecruitMessage()
    return self._guildRecruitMessage
end

function GameDataManager:addGuildInvite(inviteData)
    if (not self._guildInviteTable) then
        self._guildInviteTable = {}
    end

    self._guildInviteTable[inviteData.guildID] = inviteData
end

function GameDataManager:markGuildInviteApplied(guildID)
    if (not self._guildInviteTable) then
        return
    end
    local inviteData = self._guildInviteTable[guildID]
    if (inviteData) then
        if (inviteData.applied) then
            inviteData = nil
            self._guildInviteTable[guildID] = nil
        else
            inviteData.applied = true
        end
    end
    return inviteData
end

function GameDataManager:removeAllAppliedGuildInvite()
    if (not self._guildInviteTable) then
        return
    end
    local isAnyRemoved = false
    for guildID,inviteData in pairs(self._guildInviteTable) do
        if (inviteData.applied) then
            self._guildInviteTable[guildID] = nil
            isAnyRemoved = true
        end 
    end
    return isAnyRemoved
end

function GameDataManager:goodsDataIsNeedUnlockPacket(goodsData)
    -- 判断空格子是否是独有的背包里面，需要解锁格子
    if goodsData then
        print("goodsDataIsNeedUnlockPacket====》：",goodsData.packetType)
        if goodsData.packetType == PublicDefine.PACKET_TYPE.PACKET_GLYPH then
            -- 雕纹背包需要解锁消耗水晶或道具
            return true
        end
    end

    return false
end

return GameDataManager
