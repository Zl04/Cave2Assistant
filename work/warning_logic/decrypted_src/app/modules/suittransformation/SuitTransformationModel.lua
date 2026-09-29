--[[--
数据模型SuitTransformationModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/30
--desc	: SuitTransformationModel
------------------------------------------------------------------------------

local SuitTransformationModel = class("SuitTransformationModel",mvc.GameModel)
require "app.config.ConfigManager"
local GameDataManager = require("app.game.GameDataManager")

function SuitTransformationModel:initData()
	self._heroEquipSetData = {}
end

function SuitTransformationModel:updateSetData(data)
    if data == nil then
        return
    end
    
    local equipSetData = clone(data)
    for i = #equipSetData, 1,-1 do
        local setData = equipSetData[i]

        if self._heroEquipSetData[setData.equipSetId] then
            if setData.retrofitData and #setData.retrofitData > 0 then

                if not self._heroEquipSetData[setData.equipSetId].retrofitData then
                    self._heroEquipSetData[setData.equipSetId].retrofitData = {}
                end

                for k,v in pairs(setData.retrofitData) do
                    self._heroEquipSetData[setData.equipSetId].retrofitData[v.equipCount] = {}
                    self._heroEquipSetData[setData.equipSetId].retrofitData[v.equipCount].equipCount = v.equipCount
                    self._heroEquipSetData[setData.equipSetId].retrofitData[v.equipCount].setSkill = v.setSkill
                end
            end

            table.remove(equipSetData,i)
        end
    end

    if #equipSetData > 0 then
        for k,v in pairs(equipSetData) do
            self._heroEquipSetData[v.equipSetId] = {}
            self._heroEquipSetData[v.equipSetId].equipSetId = v.equipSetId

            if v.retrofitData and #v.retrofitData > 0 then
                self._heroEquipSetData[v.equipSetId].retrofitData = {}
                for _,n in pairs(v.retrofitData) do
                    self._heroEquipSetData[v.equipSetId].retrofitData[n.equipCount] = {}
                    self._heroEquipSetData[v.equipSetId].retrofitData[n.equipCount].equipCount = n.equipCount
                    self._heroEquipSetData[v.equipSetId].retrofitData[n.equipCount].setSkill = n.setSkill
                end
            end
        end
    end

    
    self:updateStarPrayEquipmentSet()

end

function SuitTransformationModel:updateStarPrayEquipmentSet()
    -- 刷新所有装备套装效果
    local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    for k,v in pairs(goodsArr) do
        if v.updateStarPrayEquipmentSet then
            v:updateStarPrayEquipmentSet()
        end
    end

    goodsArr = GameDataManager:getInstance():getWarehouseGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    for k,v in pairs(goodsArr) do
        if v.updateStarPrayEquipmentSet then
            v:updateStarPrayEquipmentSet()
        end
    end

    goodsArr = GameDataManager:getInstance():getWearEquipmentData()
    for k,v in pairs(goodsArr.wearEquipmentArr) do
        if v.updateStarPrayEquipmentSet then
            v:updateStarPrayEquipmentSet()
        end
    end
end

function SuitTransformationModel:resetRetrofitData(data)
    if data == nil then
        return
    end

    local equipSetId = data.equipSetId
    local equipCount = data.equipCount

    if self._heroEquipSetData[equipSetId] and self._heroEquipSetData[equipSetId].retrofitData[equipCount] then
        self._heroEquipSetData[equipSetId].retrofitData[equipCount] = nil
    end

    self:updateStarPrayEquipmentSet()
end

function SuitTransformationModel:retrofitData(data)
    if data == nil then
        return
    end

    local equipSetId = data.equipSetId
    local equipCount = data.equipCount
    local skillId = data.skillId

    if self._heroEquipSetData[equipSetId] and self._heroEquipSetData[equipSetId].retrofitData[equipCount] then
        self._heroEquipSetData[equipSetId].retrofitData[equipCount].setSkill = skillId
    end

    self:updateStarPrayEquipmentSet()
end

function SuitTransformationModel:getEquipmentSetDataBySetId(setId)
    local setData = nil

    -- print( "_heroEquipSetData ===== ", setId)
    -- dump(self._heroEquipSetData)

    if self._heroEquipSetData[setId] then
        setData = self._heroEquipSetData[setId]
    end

    return setData
end

function SuitTransformationModel:getEquipSetSkillArrBySetId(setId)
    local setSkillArr = {}
    local setMarkData = ConfigManager:getEquipmentSetBySetMark(setId)
    local chageSetData = self:getEquipmentSetDataBySetId(setId)
    local localSetData = nil
    if setMarkData then
        localSetData = clone(setMarkData)
    end

    if (localSetData) then
        localSetData.chageSetSkillIndex = {}
        for k,v in pairs(localSetData.equipSetSkillUnlock) do
            localSetData.chageSetSkillIndex[k] = false
        end
    end

    -- 处理改造后的套装属性配置
    if localSetData and chageSetData and table.nums(chageSetData) > 0 and chageSetData.retrofitData and table.nums(chageSetData.retrofitData) > 0 then
        for k,v in pairs(localSetData.equipSetSkillUnlock) do
            if chageSetData.retrofitData[v] then
                localSetData.equipSetSkill[k] = chageSetData.retrofitData[v].setSkill
                localSetData.chageSetSkillIndex[k] = true
            end
        end
    end

    -- 处理解析套装属性
    local index = 1
    if(localSetData) then
        for k,skillID in ipairs(localSetData.equipSetSkill) do
            local skillData = SkillDataManager:createSkillForSkillId(skillID)
            if(skillData) then
                setSkillArr[index] = skillData

                index = index + 1
            end
        end
    end

    local setDescriptionArr = {}
    if chageSetData and table.nums(chageSetData) > 0 then
        setDescriptionArr.isUnlock = true
    else
        setDescriptionArr.isUnlock = false
    end

    if table.nums(setSkillArr) > 0 then
        setDescriptionArr.setName = localSetData.equipSetName
        setDescriptionArr.setId = setId
        
        setDescriptionArr.activationArr = {}
        for k,skillData in ipairs(setSkillArr) do
            if(skillData) then
                local oneAttr = {}
                table.insert(oneAttr,skillData:getDescription())
                table.insert(oneAttr,string.format("%d",localSetData.equipSetSkillUnlock[k]))
                table.insert(oneAttr,localSetData.chageSetSkillIndex[k])
                table.insert(oneAttr,setId)
                table.insert(setDescriptionArr.activationArr,oneAttr)
            end
        end
    end

    return setDescriptionArr
end

function SuitTransformationModel:getSuitGroupByEquipmentType(eType)
    local setDescriptionArrGroup = {}

    local equipmentSetConf = ConfigManager:getAllEquipmentSetConfig()
    for k,v in pairs(equipmentSetConf) do
        if type(v) == "table" and v.ordinaryRetrofitSkill ~= "" and (eType == 0 or eType == v.sutType or v.sutType == 4) then
            local setDescriptionArr = self:getEquipSetSkillArrBySetId(v.equipSetMark)
            if table.nums(setDescriptionArr) > 0 then
                table.insert(setDescriptionArrGroup, setDescriptionArr)
            end
        end
    end

    if (#setDescriptionArrGroup > 1) then
        table.sort(setDescriptionArrGroup, function(a, b)
            return a.setId < b.setId
        end)
    end

    return setDescriptionArrGroup
end


return SuitTransformationModel