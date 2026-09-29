--[[--
数据模型PetGemStoneDevelopmentModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/02/09
--desc	: PetGemStoneDevelopmentModel
------------------------------------------------------------------------------
require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local PetGemStoneDevelopmentModel = class("PetGemStoneDevelopmentModel",mvc.GameModel)

function PetGemStoneDevelopmentModel:initData()
    --吞噬前,需要提示的类型
    self._tipsResult = {
        invalid = 0,
        levelExceed = 1, --吞噬后,宝石等级会超过玩家等级
        expOverflow = 2, --吞噬后,经验溢出
    }
	
end

function PetGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(equipId)
    local equipmentData = nil

    for i=0,2 do
        local pData = MasterDataManager:getFightPetBySiteId(i)
        if pData then
            local petData = MasterDataManager:getBagPetById(pData:getPetInstId())
            if petData then
                local arr = petData:getWearEquipmentArr() or {}
                for k,v in pairs(arr) do
                    print("   v:getEntityID() ====  ",  v:getEntityID(), equipId)
                    if equipId == v:getEntityID() then
                        equipmentData = v
                        break
                    end
                end
            end
        end
    end

    return equipmentData
end

function PetGemStoneDevelopmentModel:createPetStoneData(netData,equipId,slotIndex)
    local gemStone = nil
    if netData and netData.gemId ~= 0 then
        gemStone = Goods.PetStoneData:create(netData.gemId,slotIndex)
        gemStone:initNetData(netData,nil,nil,nil,nil,equipId)
    end

    return gemStone
end

function PetGemStoneDevelopmentModel:getExpByItemTable(itemTable)
    local totalExp = 0
    local itemTable = itemTable or {}

    for k,v in pairs(itemTable) do
        local exp = v:howMuchExp()
        totalExp = totalExp + exp
    end

    return totalExp
end

function PetGemStoneDevelopmentModel:analyzePhagocytosisResult(itemTable,goodsData)
    local resultParams = {}
    resultParams.tipsType = self._tipsResult.invalid
    resultParams.value = 0

    local totalExp = self:getExpByItemTable(itemTable)
    local distanceMaxExp = goodsData:getDistanceMaxExp() --距离满经验,还差多少

    if totalExp > distanceMaxExp then
        resultParams.tipsType = self._tipsResult.expOverflow
        resultParams.value = totalExp - distanceMaxExp
    else
        local budgetLevel = goodsData:budgetNeedLevel(totalExp)
        local heroData = RoleDataManager:getMaster()
        local heroLevel = heroData:getLevel()

        if heroLevel < budgetLevel then
            resultParams.tipsType = self._tipsResult.levelExceed
            resultParams.value = budgetLevel
        end
    end

    -- print("resultParams ==== ",resultParams, mvc.petGemStoneDevelopmentModel._tipsResult.levelExceed)
    return resultParams
end


return PetGemStoneDevelopmentModel