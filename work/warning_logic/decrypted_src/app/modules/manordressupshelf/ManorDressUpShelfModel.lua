--[[--
数据模型ManorDressUpShelfModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: ManorDressUpShelfModel
------------------------------------------------------------------------------

local ManorDressUpShelfModel = class("ManorDressUpShelfModel",mvc.GameModel)

function ManorDressUpShelfModel:initData()
	-- self._shelfData = {}

    self._showData = {}
    self._equipData = {}

    -- self:initTestData()
end


function ManorDressUpShelfModel:initTestData()
    -- self._shelfData[1] = {
    --     21015070,
    --     21025070,
    --     21035070,
    --     21045070,
    -- }

    self._equipData = {
        [1] = {
            illusionId = 1,
            activateState = 126,
        },
    }
end

function ManorDressUpShelfModel:setIllusionData(data)
--     message IllusionShowData
-- {
--     required uint32 npcIndex = 1;                           // NPC 索引号（1,2,3）
--     optional uint32 illusionId = 2;
--     repeated uint32 equipId = 3;                            // 展示的装备ID
-- }
    self._showData = data.showData

-- message IllusionEquipData
-- {
--     required uint32 illusionId = 1;                                 // 套装ID（对应ProfileIllusionRack.lua配置equipIllusionId字段）
--     optional uint32 activateState = 2;                              // 按（装备类型）位激活
-- }
    self._equipData = data.equipData
end

--返回展示的NPC索引号  如果为0 则该套装没有被展示
function ManorDressUpShelfModel:getShowSuitViewRetrunNpcIndexByIllusionId(profileID)
    local npcIndex = 0

    for k,v in pairs(self._showData) do
        if v.illusionId == profileID then
            npcIndex = v.npcIndex
            break
        end
    end

    return npcIndex
end


--获得指定ID已激活的装备ID
function ManorDressUpShelfModel:getActivateDataById(profileID)
    local pData = ConfigManager:getAllIllusionRackDataByID(profileID)
    local wearEquipArr = {}
    if pData then
        local equipIllusionDatas = string.split(pData.equipIllusionId, ";")
        for k,v in ipairs(equipIllusionDatas) do
            local elementValue = string.split(v, ",")
            local goodsID = tonumber(elementValue[1])
            local equipType = AvalonUtil.getEquipmentTypeFromID(goodsID)

            isActivate = false
            for m,n in pairs(self._equipData) do
                if n.illusionId == profileID and self:bitwiseForActivateStateValue(n.activateState, equipType) then
                    -- table.insert(equipIds, goodsID)
                    local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
                    if goodsData then
                        goodsData:setWearPosition(goodsData:getEquipmentType())
                        table.insert(wearEquipArr,goodsData)
                    end
                    break
                end
            end
        end
    end

    return wearEquipArr
end

function ManorDressUpShelfModel:checkActivateById(profileID)
    local pData = ConfigManager:getAllIllusionRackDataByID(profileID)
    local isActivate = false

    if pData then
        local equipIllusionDatas = string.split(pData.equipIllusionId, ";")
        for k,v in ipairs(equipIllusionDatas) do
            local elementValue = string.split(v, ",")
            local goodsID = tonumber(elementValue[1])
            local equipType = AvalonUtil.getEquipmentTypeFromID(goodsID)

            isActivate = false
            for m,n in pairs(self._equipData) do
                if n.illusionId == profileID and self:bitwiseForActivateStateValue(n.activateState, equipType) then
                    isActivate = true
                    break
                end
            end

            if not isActivate then
                break
            end
        end

    end

	return isActivate
end

function ManorDressUpShelfModel:bitwiseForActivateStateValue(value, equipType)
    local isActivate = false
    -- print("  vType========== ",bit.band(1, bit.rshift(value, equipType)) , value, equipType)
    if bit.band(1, bit.rshift(value, equipType)) > 0 then
        isActivate = true
    end
    return isActivate
end

--判断套装是否存在可激活但没有激活的装备
function ManorDressUpShelfModel:suitListShowRedPointById(profileID)
    local isShow = false
    local activateNum = 0
    local isAllActivate = false
    local contentList = {}
    local pData = ConfigManager:getAllIllusionRackDataByID(profileID)
    local LanguageManager = require("app.game.LanguageManager")
    if pData then


        local isActivate = false
        local equipIllusionDatas = string.split(pData.equipIllusionId, ";")
        for k,v in ipairs(equipIllusionDatas) do
            
            local elementValue = string.split(v, ",")
            local goodsID = tonumber(elementValue[1])
            local illusionID = tonumber(elementValue[2])
            local buildID = tonumber(elementValue[4])
            local needLevel = tonumber(elementValue[5])
            local equipType = AvalonUtil.getEquipmentTypeFromID(tonumber(goodsID))

            contentList[k] = {}
            contentList[k].state = 0 --无意义状态
            contentList[k].goodsID = goodsID
            contentList[k].illusionID = illusionID
            contentList[k].unlockDesc = LanguageManager:getInstance():getLocalString(pData.unlockDesc)
            contentList[k].getSource = LanguageManager:getInstance():getLocalString(pData.getSource)
            isActivate = false
            for m,n in pairs(self._equipData) do
                if n.illusionId == profileID and self:bitwiseForActivateStateValue(n.activateState, equipType) then
                    isActivate = true
                    contentList[k].state = 1 --已激活
                    activateNum = activateNum + 1
                    break
                end
            end

            if not isActivate then
                require "app.datas.EquipIllusionDataManager"
                local illusionData = EquipIllusionDataManager:getPossessingIllusionById(illusionID)

                local GameInManorManager = require "app.game.GameInManorManager"
                local isConditions = GameInManorManager:getInstance():checkBuildLevelIsConditions(buildID, needLevel)

                if illusionData and isConditions then
                    isShow = true
                    contentList[k].state = 2 -- 可激活
                    -- break
                elseif (illusionData and not isConditions) or (not illusionData and not isConditions) then
                    contentList[k].state = 3 -- 显示解锁条件(幻化架多少级解锁)
                elseif not illusionData and isConditions then
                    contentList[k].state = 4 -- 显示装备幻化来源
                end
            end
        end

        isAllActivate = #equipIllusionDatas == activateNum
    end

    return isShow, activateNum, isAllActivate, contentList
end



function ManorDressUpShelfModel:getShelfDataByIndex(shelfIndex)
    -- return self._shelfData[shelfIndex]
    local data = {}

    for k,v in pairs(self._showData) do
        if v.npcIndex == shelfIndex then
            table.insert(data, v.equipId)
        end
    end

    return data
end



return ManorDressUpShelfModel