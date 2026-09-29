--[[--
数据模型RecastModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]
------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/07/19
--desc	: RecastModel
------------------------------------------------------------------------------

local RecastModel = class("RecastModel", mvc.GameModel)
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"

function RecastModel:initData()
    self.npcId = 1900548
end

function RecastModel:checkEquipTransformCost(targetEquipData)
    local setMarkData = ConfigManager:getEquipmentSetBySetMark(targetEquipData.equipSetMark)
    local datas = {}
    local coinCost = 0
    for i = 1, #setMarkData.changeCostGoodsID do
        local templeteId = setMarkData.changeCostGoodsID[i]
        local num = setMarkData.changeCostGoodsNum[i]
        local goodNumber, warehouseNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(templeteId, true, true)
        if goodNumber + warehouseNum < num then
            return false, templeteId
        end
    end
    return true
end
function RecastModel:setNpc(npc)
    self.npcId = npc
end
function RecastModel:getNpcId()
    return self.npcId
end

function RecastModel:getAllCostGoodsDatas(goodsDatas)
    local setMarkData = ConfigManager:getEquipmentSetBySetMark(goodsDatas.equipSetMark)
    local datas = {}
    local coinCost = 0
    for i = 1, #setMarkData.changeCostGoodsID do
        local templeteId = setMarkData.changeCostGoodsID[i]
        local num = setMarkData.changeCostGoodsNum[i]
        if templeteId ~= Game.ConstGoods.Coin then
            local equip = GoodsDataManager:createLocalGoodsData(templeteId)
            equip.curNum =  GameDataManager:getInstance():getGoodsDataNumForGoodsID(templeteId, true)
            equip.costNum =  num
            table.insert(datas, equip)
        else
            coinCost = num
        end
    end
    return datas, coinCost
end

function RecastModel:getAllEquipByEquipSet(equipData)
    local equipSetMark = equipData.equipSetMark
    local templateId = equipData.goodsID
    local equipDatas = {}
    local equips = ConfigManager:getAllEquipmentConfig()
    for _, equip in pairs(equips) do
        if type(equip) == "table" and equip.equipSetMark == equipSetMark and equip.ID ~= templateId then
            table.insert(equipDatas, Goods.EquipmentData:create(equip.ID))
        end
    end
    return equipDatas
end

function RecastModel:getSuitTransformUsedType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needRefineFunc = function(goodsData)
        if goodsData.refineNum > 0 then
            return false
        end
        if goodsData.isLock then
            return false
        end
        return  goodsData.equipSetMark>0 and goodsData._equipmentSet and (goodsData._equipmentSet.localSetData.changeTimes > goodsData.setChangeNum)
    end
    table.insert(usedTypeList, _usedType1)
    return usedTypeList
end

function RecastModel:getRefineTargetUsedType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needRefineFunc = function(goodsData)
        return self:checkEquipCanRefine(goodsData)
    end
    table.insert(usedTypeList, _usedType1)
    return usedTypeList
end

function RecastModel:getRefineMaterialUsedType(name)
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needRefineFunc = function(goodsData)
        if goodsData.isLock then
            return false
        end
        if goodsData.strengthenLevel > 0 then
            return false
        end

        if goodsData.refineNum > 0 then
            return false
        end

        return goodsData.name == name or goodsData.name == LanguageManager:getInstance():getLocalString(1092344)
    end

    
    table.insert(usedTypeList, _usedType1)
    return usedTypeList
end

function RecastModel:checkEquipRefineFit(targetData, materialData)
    if targetData and materialData then
        return targetData.name == materialData.name
    end
    return false
end

function RecastModel:checkEquipCanRefine(goodsData)
    if goodsData.equipRefineTime < 1 then
        return false
    end
    if goodsData.refineNum >= goodsData.equipRefineTime  then
        return false
    end

    return self:checkEquipHasSameName(goodsData)
end

function RecastModel:getEquipInPacakageType(goodsData)
    return goodsData:getBagType()
end

local PACKET_TYPE = PublicDefine.PACKET_TYPE

function RecastModel:checkEquipHasSameName(goodsData)
    local name = goodsData.name
    local entityId = goodsData:getEntityID()
    local master = RoleDataManager:getMaster()
    local wearbagData =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PublicDefine.PACKET_TYPE.PACKET_BAG,
        PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    )
    for k, v in pairs(wearbagData) do
        if (v.name == name or v.name == LanguageManager:getInstance():getLocalString(1092344)) 
            and v:getEntityID() ~= entityId
            and v.refineNum == 0
            and  (not v.isLock)
        then
            return true
        end
    end
    local goodsArr =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT,
        PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    )
    for k, v in pairs(goodsArr) do
        if (v.name == name or v.name == LanguageManager:getInstance():getLocalString(1092344)) 
            and v:getEntityID() ~= entityId 
            and v.refineNum == 0
            and  (not v.isLock)
        then
            return true
        end
    end


    local goodsArr =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE,
        PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    )
    for k, v in pairs(goodsArr) do
        if (v.name == name or v.name == LanguageManager:getInstance():getLocalString(1092344)) 
            and v:getEntityID() ~= entityId 
            and v.refineNum == 0
            and  (not v.isLock)
        then
            return true
        end
    end

    return false
end

function RecastModel:checkEquipHasGemStone(goodsData)
    local holeDatas = goodsData:getHoleDatas()
    for _, holeData in ipairs(holeDatas) do
        local gemStoneData = holeData:getGemStoneData()
        if (gemStoneData) then
            return true
        end
    end
end

return RecastModel
