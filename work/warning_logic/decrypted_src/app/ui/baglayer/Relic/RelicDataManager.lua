-- RelicDataManager.lua
RelicDataManager = RelicDataManager or {}
require "app.datas.SkillDataManager"
local GameDataManager = require("app.game.GameDataManager")

local PACKET_TYPE = PublicDefine.PACKET_TYPE

function RelicDataManager:init()
	require "app.config.ConfigManager"
end

function RelicDataManager:getRelicBagData()

	-- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
    local bagData = {}
    bagData.packetType = PACKET_TYPE.PACKET_BAG
    bagData.heroData = master

    -- 背包信息
    bagData.haveEquipmentArr = {}
    bagData.haveMaterialArr = {}
    bagData.haveGemStoneArr = {}
    bagData.haveItemArr = {}
    bagData.haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(), PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_RELIC)
    table.sort(
        bagData.haveRelicArr,
        function(a, b)
            if a:getLevel() == b:getLevel() then
                return a:getId() < b:getId()
            else
                return a:getLevel() > b:getLevel()
            end
        end
    )

    local relicGridNum = math.ceil(#bagData.haveRelicArr/5) * 5
    -- 背包能够使用的格子数
    bagData.packetBoxBeUseNum = relicGridNum > 30 and relicGridNum or 30
    -- 背包最大格子数
    bagData.packetBoxMaxNum = relicGridNum > 30 and relicGridNum or 30
    -- 获取背包解锁次数
    bagData.unlockBagTimes = 0

    self.bagData = bagData
    return bagData
end

function RelicDataManager:getRelicEqiupDataWithIndexOrder()
    local equipDatas = self:getRelicEqiupData()
    local relicDatas = {}
    if equipDatas then
        for k, v in ipairs(equipDatas) do
            relicDatas[v:getRelicType()] = v
        end
    end
    return relicDatas
end

--获取遗物装备
function RelicDataManager:getRelicEqiupData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end
    return GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_RELIC_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_RELIC
    )
end

-- 根据实例ID获取遗物对象
function RelicDataManager:getRelicForEntityID(entityID)
    if entityID == nil or entityID == 0 then
        return
    end
    local pk = RoleDataManager:getMasterPK()

    -- 查找背包数据
    local relicArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_RELIC,nil)
    if(relicArr) then
        for k,relic in ipairs(relicArr) do
           if(relic:getEntityID() == entityID) then
                return relic
           end
        end
    end

    -- 查找穿戴的物品
    relicArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_RELIC_WEAR,PublicDefine.GOODS_TYPE.GOODS_RELIC, nil)
    if(relicArr) then
        for k,relic in ipairs(relicArr) do
           if(relic:getEntityID() == entityID) then
                return relic
           end
        end
    end

    -- 查找仓库的物品
    relicArr = GoodsDataManager:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_RELIC, nil)
    if(relicArr) then
        for k,relic in ipairs(relicArr) do
           if(relic:getEntityID() == entityID) then
                return relic
           end
        end
    end
    return nil
end

-- 强化遗物
function RelicDataManager:reqRelicStrength(relicData, extraIds, extraNums)
    UI.WaitingLayer:showWaiting(true, nil, 5)

    self.strengthRelicID = relicData:getEntityID()

    Net.NetGoodsSystem:requestRelicStrength(relicData:getEntityID(), extraIds, extraNums)
end

-- 强化返回处理
function RelicDataManager:resRelicStrength(isSuccess)
    if not self.strengthRelicID then
        return
    end

    local relicData = self:getRelicForEntityID(self.strengthRelicID)
    local relicType = relicData:getRelicType()
    relicData:doLevelUpResult(isSuccess)

    self.strengthRelicID = nil

    if isSuccess then
        UI.ScrollBar:createByText(UI.TEXT_1324458)
    else
        UI.ScrollBar:createByText(UI.TEXT_1212029)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_RELIC_STRENGTH_RESULT, isSuccess, relicType)
end

-- 获取遗物当前等级强化配置
function RelicDataManager:getRelicCurLevelConfig(relicData)
    local pillsConfig = ConfigManager:getGeneralForKey("relicStrengthenMaterial")
    local pillsList = string.split(pillsConfig, ";")
    local curLevelPillsConfigList = {}
    local relicLv = relicData:getLevel()
    for k, v in pairs(pillsList) do
        local list = string.split(v, ",")
        local lv = tonumber(list[2])
        if lv == relicLv then
            table.insert(curLevelPillsConfigList, list)
        end
    end
    return curLevelPillsConfigList
end

RelicDataManager:init()