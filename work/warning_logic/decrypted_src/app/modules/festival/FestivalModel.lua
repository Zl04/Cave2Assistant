--[[--
数据模型FestivalModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: FestivalModel
------------------------------------------------------------------------------
require "app.datas.activity.FestivalExchangeShopData"

local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")

local FestivalModel = class("FestivalModel",mvc.GameModel)

function FestivalModel:initData()
    self.needReOpen = false
    self.startTime = 0
    self.mazeHeroSimpleArr = {}
    self.curJoinData = {}
    self.mazeRewardFlag = nil

    -- 初始化节日兑换活动数据

    -- 遗物道具列表
    self.legacyDataArr = {}
    self.randomLegacyDataArr = {}

    -- hulu活动战斗技能
    self._nowChoiceWeaponType = 0
    self._nowChoiceExterior = 0
    -- 当前穿戴的装备列表
    self._nowWearEquipmentArr = {}
    self._configHuluSkillArr = nil
    -- 葫芦娃场景的爷爷被解救的状态
    self._wasRescue = false
    -- lostrealm 
    self._lostRealmCostArr = nil
    self._lostRealmFreeCount = nil
    self._lostRealmDiamondCount = nil
    self._lostRealmData = nil
end

function FestivalModel:clearLegacyData()
    self.legacyDataArr = {}
end
-- 清理葫芦活动数据
function FestivalModel:clearHuluData()
    self._nowWearEquipmentArr = {}
    self._configHuluSkillArr = nil
    self._nowChoiceWeaponType = 0
    self._nowChoiceExterior = 0
    self.legacyDataArr = {}
    self.randomLegacyDataArr = {}
    self._wasRescue = false
end

function FestivalModel:handleInitLegacy(data)
    self.legacyDataArr = {}
    if(data) then 
        for k,v in ipairs(data) do 
            table.insert(self.legacyDataArr, GoodsDataManager:createLocalGoodsData(tonumber(v)))
        end
    end
end

function FestivalModel:handleAddOneLegacy(ID)
    if(ID) then 
        table.insert(self.legacyDataArr, GoodsDataManager:createLocalGoodsData(ID))
    end
end

-- 获取遗物列表
function FestivalModel:getLegacyArr()
    return self.legacyDataArr
end

function FestivalModel:setRandomLegacy(randomLegacy)
    self.randomLegacyDataArr = {}
    if(randomLegacy) then 
        for k, v in ipairs(randomLegacy) do 
            table.insert(self.randomLegacyDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function FestivalModel:clearRandomLegacyArr()
    self.randomLegacyDataArr = {}
end

function FestivalModel:getRandomLegacyArr()
    return self.randomLegacyDataArr
end

function FestivalModel:clearMazeRewardFlag()
    self.mazeRewardFlag = nil
end

function FestivalModel:setStartCDTime(cdStart)
   self:set("startTime",cdStart)
end

function FestivalModel:handleHeroSimple(data)
    if(data) then 
        for k,v in ipairs(data) do 
            if(self.mazeHeroSimpleArr[v.pk] == nil) then 
                self.mazeHeroSimpleArr[v.pk] = v.name
            end
        end
    end
end

function FestivalModel:getMazeName(pk)
    if(self.mazeHeroSimpleArr[pk]) then 
        return self.mazeHeroSimpleArr[pk]
    end

    return ""
end

function FestivalModel:clearMazeName()
    self.mazeHeroSimpleArr = {}
end


function FestivalModel:getCurJoinData()
    return self.curJoinData
end

function FestivalModel:getSceneTime()
    local nowTime = GameManager:getNormalServerTime()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    -- local mazeFreezeTime = ConfigManager:getGeneralForKey("mazeFreezeTime")
    -- print("FestivalModel:getFightRemindCD", configData ~= nil, GameMapManager:getInstance():getLevel())
    local mazeFreezeTime = nil
    if(configData) then 
        mazeFreezeTime = configData.lifetime
    end
    local freezeTime = mazeFreezeTime or 600

    return self.startTime + freezeTime - nowTime
end

function FestivalModel:getFightRemindCD()
    local nowTime = GameManager:getNormalServerTime()
    -- local mazeFreezeTime = ConfigManager:getGeneralForKey("mazeFreezeTime") 
    -- print("FestivalModel:getFightRemindCD", GameMapManager:getInstance():getLevel())
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local mazeFreezeTime = nil
    if(configData) then 
        mazeFreezeTime = configData.freezetime
    end
    local freezeTime = mazeFreezeTime or 30

    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("现在时间:",GameManager:getNowServerDate(nil, nowTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))
    -- print("服务器通知副本开启时间:",GameManager:getNowServerDate(nil, self.startTime + GameManager:getEPOCHTime()))

    return self.startTime + freezeTime - nowTime
end

function FestivalModel:joinResp(activityID, mapID, result, extra)
    self.curJoinData.activityID = activityID
    self.curJoinData.mapID = mapID
    self.curJoinData.extra = extra --大裂谷的惩罚时间
end


function FestivalModel:cancleJoinResp()
    self.needReOpen = false
    self.curJoinData = {}

    if self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID then
        mvc.closePanel("Festival", "FestivalMazeTeam")
    elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.RAT_MAP_ID then
        mvc.closePanel("HitRat", "HitRatMatch")
    elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID then
        mvc.closePanel("BigCrack", "BigCrackReady")
    end
end

function FestivalModel:matchSucess(data)
    self.curJoinData.activityID = data.activityID
    self.curJoinData.mapID = data.mapID
    self.curJoinData.remainTime = data.remainTime
    self.curJoinData.roomID = data.roomID
    self.curJoinData.members = clone(data.members)

    if SceneManager:getInstance():isNotInFightScene() and not SceneManager:getInstance():getIsInLoading() then
        if self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID then
            -- 洞窟迷阵
            mvc.openPanel("Festival", "FestivalMazeTeam")
        elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.RAT_MAP_ID then
            -- 异鼠
            mvc.openPanel("HitRat", "HitRatMatch")
            --
        elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID then
            mvc.openPanel("BigCrack", "BigCrackReady")
        end
    else
        self.needReOpen = true
    end
end

function FestivalModel:checkNeedReOpenRoomView()
    if self.needReOpen then
        self.needReOpen = false

        if self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID then
            -- 洞窟迷阵
            mvc.openPanel("Festival", "FestivalMazeTeam")
        elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.RAT_MAP_ID then
            -- 异鼠
            mvc.openPanel("HitRat", "HitRatMatch")
        elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID then
            mvc.openPanel("BigCrack", "BigCrackReady")
        end
    end
end

function FestivalModel:CDCancelMatch(rematch)
    self.needReOpen = false

    if self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID then
        mvc.closePanel("Festival", "FestivalMazeTeam")
    elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.RAT_MAP_ID then
        mvc.closePanel("HitRat", "HitRatMatch")
    elseif self.curJoinData.mapID == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID then
        mvc.closePanel("BigCrack", "BigCrackReady")
    end

    if rematch then
        self.curJoinData.remainTime = nil
        self.curJoinData.roomID = nil
        self.curJoinData.members = nil
    else
        self.curJoinData = {}
    end
end

function FestivalModel:memberSureUpdate(pk)
    for _, member in ipairs(self.curJoinData.members) do
        if member.pk == pk then
            member.isSured = true
            break
        end
    end
end

function FestivalModel:roomMemberChange(leavePKs)
    local curMembers = {}
    for _, member in ipairs(self.curJoinData.members or {}) do
        local found = false
        for _, leavepk in ipairs(leavePKs) do
            if member.pk == leavepk then
                found = true
                break
            end
        end

        if not found then
            table.insert(curMembers, member)
        end
    end

    self.curJoinData.members = curMembers

    Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE)
end

function FestivalModel:checkCanEnterOther()
    return self.curJoinData.activityID == nil
end

function FestivalModel:setMazeRewardFlag(flag)
    self.mazeRewardFlag = true
end

function FestivalModel:getMazeRewardFlag()
    return self.mazeRewardFlag
end

function FestivalModel:getHuluConfigSkillIDArr(weaponType)
    weaponType = weaponType or self:getHuluChoiceWeaponType()
    if(self._configHuluSkillArr == nil) then
        self._configHuluSkillArr = {}
        local skillConfig = ConfigManager:getGeneralForKey("huluSkillList")
        if(skillConfig) then 
            local skillConfigArr = string.split(skillConfig, ";")
            for k, v in ipairs(skillConfigArr) do 
                local oneArr = string.split(v, ",")
                local skillArr = {}
                for k1,v1 in ipairs(oneArr) do 
                    if(k1 > 1) then 
                        table.insert(skillArr, SkillDataManager:createTempSkillGroupData(tonumber(v1), 1))
                    end
                end
                self._configHuluSkillArr[tonumber(oneArr[1])] = skillArr
            end
        end
    end

    return self._configHuluSkillArr[weaponType]
end

function FestivalModel:getHuluChoiceWeaponType()
    return self._nowChoiceWeaponType
end

function FestivalModel:getHuluExterior()
    return self._nowChoiceExterior
end

function FestivalModel:getHuluWearEquipmentArr()
    -- print("FestivalModel:getHuluWearEquipmentArr()", #self._nowWearEquipmentArr)
    return self._nowWearEquipmentArr
end

function FestivalModel:setHuluChoiceWeaponType(weaponType, exterior)
    self._nowWearEquipmentArr = {}
    self._nowChoiceWeaponType = weaponType
    self._nowChoiceExterior = exterior

    -- self._nowChoiceWeaponType = 2
    -- self._nowChoiceExterior = exterior

    -- 根据数据生成当前的表现
    local randomGenerater = Avalon.RandomGenerater:new(self._nowChoiceExterior)
    local configStr = ConfigManager:getGeneralForKey("huluEquipPool_"..self._nowChoiceWeaponType)
    if(configStr and configStr ~= 0) then 
        local configArr = string.split(configStr, ";")
        if(configArr) then  
            local oneStr = configArr[randomGenerater:random(1, #configArr)]
            local idArr = string.split(oneStr, ",")
            for k, goodsID in ipairs(idArr) do 
                local goodsID = tonumber(goodsID)
                if(goodsID) then 
                    table.insert(self._nowWearEquipmentArr, GoodsDataManager:createLocalGoodsData(goodsID))
                end
            end
        end
    end

    if(randomGenerater) then 
        randomGenerater:delete()
        randomGenerater = nil
    end
end

function FestivalModel:getWasRescue()
    if(SceneManager:getInstance():isInHuLu()) then 
        return self._wasRescue
    else
        return true
    end
end

function FestivalModel:setWasRescue(flag)
    self._wasRescue = flag
end


function FestivalModel:getLostRealmStatus()
    local functionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction({PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL})
    if #functionTypeArr == 0 then
        return false
    end

    local dataArr = MasterDataManager:getActivityDataArr()
    local found = false
    local activityData = nil 
    for k, v in pairs(dataArr) do
        if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
            activityData = v
            break
        end
    end
    if(activityData) then 
        if activityData:getFestivalData() and activityData:getFestivalData():getLostRealmStatus() then 
            if(not SceneManager:getInstance():isInFightScene()) then 
                return true
            end
        end
    end

    return false
end

function FestivalModel:getLostRealmResPointStatus()
    if(mvc.festivalModel:getLostRealmCost() == 0) then 
        return true
    end

    local lostRealmData = mvc.festivalModel:getLostRealmData()
    if(lostRealmData and mvc.festivalModel:getWasRunCirle() > #lostRealmData.claimedCycleReward) then 
        return true
    end

    return false
end

function FestivalModel:getLostRealmFestivalData()
    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_Festival)
    if(activityData) then 
        if activityData:getFestivalData() then 
            return activityData:getFestivalData():getLostRealmFestivalData()
        end
    end

    return nil
end

function FestivalModel:initLostRealmData(lostRealmData)
    self._lostRealmData = lostRealmData
end

function FestivalModel:getLostRealmData()
    return self._lostRealmData
end

function FestivalModel:getWasRunCirle()
    local lostRealmData = mvc.festivalModel:getLostRealmData()
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local quanNum = math.modf(lostRealmData.currentStep/oneCricleNum)

    return quanNum
end

--[[
    return: 处理的相关次数
]]
function FestivalModel:getLostRealmTotalCount()
    self:_initLostRealmConfig()
    if(self._lostRealmCostArr) then 
        return #self._lostRealmCostArr
    end

    return 0
end

function FestivalModel:getLostRealmFreeCount()
    self:_initLostRealmConfig()
    if(self._lostRealmCostArr) then 
        if(self._lostRealmFreeCount == nil) then
            self._lostRealmFreeCount = 0
            for k,v in ipairs(self._lostRealmCostArr) do
                if(v == 0) then 
                    self._lostRealmFreeCount = self._lostRealmFreeCount + 1
                end
            end
        end
    end

    return self._lostRealmFreeCount
end

function FestivalModel:getLostRealmDiamondCount()
    self:_initLostRealmConfig()
    if(self._lostRealmCostArr) then 
        if(self._lostRealmDiamondCount == nil) then
            self._lostRealmDiamondCount = 0
            for k,v in ipairs(self._lostRealmCostArr) do
                if(v > 0) then 
                    self._lostRealmDiamondCount = self._lostRealmDiamondCount + 1
                end
            end
        end
    end

    return 0
end

--[[
    return: 0 表示免费,nil 标识超过购买次数, >0 花费的钻石数量
]]
function FestivalModel:getLostRealmCost()
    self:_initLostRealmConfig()
    if(self._lostRealmCostArr) then 
        return self._lostRealmCostArr[self._lostRealmData.rollCount + 1]
    end

    return 0
end

function FestivalModel:_initLostRealmConfig()
    if(self._lostRealmCostArr == nil) then 
        local lostRealmCost = ConfigManager:getGeneralForKey("LostRealmCost")
        if(lostRealmCost) then 
            self._lostRealmCostArr = {}
            local strArr = string.split(lostRealmCost, ",")
            for k,v in ipairs(strArr) do 
                table.insert(self._lostRealmCostArr, tonumber(v))
            end
        end
    end
end

function FestivalModel:getLostRealmDataByCoord(coordX, coordY)
    local lostRealmArr = ConfigManager:getAllLostRealm()
    if(lostRealmArr) then 
        for k, oneData in ipairs(lostRealmArr) do 
            if(oneData.Location[1] == coordX and oneData.Location[2] == coordY) then 
                return oneData
            end
        end
    end

    return nil
end

function FestivalModel:calculationLostRealmID(currentStep)
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local endStep = math.fmod(currentStep + 1, oneCricleNum)
    if(endStep == 0) then 
        endStep = oneCricleNum
    end

    return endStep
end

function FestivalModel:calculationDisStep(nowID, endStep)
    local step = 0
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local endNum = mvc.festivalModel:calculationLostRealmID(endStep)
    if(endNum >= nowID) then 
        step = endNum - nowID
    else
        step = endNum + (oneCricleNum - nowID)
    end

    return step
end


return FestivalModel