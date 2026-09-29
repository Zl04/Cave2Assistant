--[[--
数据模型ManorDiningTableModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/22
--desc	: ManorDiningTableModel
------------------------------------------------------------------------------

local ManorDiningTableModel = class("ManorDiningTableModel",mvc.GameModel)

function ManorDiningTableModel:initData()
	self.recipeConfigData = nil

end


function ManorDiningTableModel:getRecipeItemNum(data)
    local pk = RoleDataManager:getMaster():getPK()
    local totalNum = 0
    -- local idList = string.split(data, ",")
    for _, v in pairs(data) do
        local num = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(v))
        totalNum = totalNum+num
    end
    return totalNum
end

function ManorDiningTableModel:checkBuffIsExist(buffId)
    local exist = false
    local heroData = RoleDataManager:getMaster()
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(heroData:getSpriteID())
    local buffData
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            print("checkBuffIsExist22:", v.buffID, buffId, v.buffID == buffId)
            if v.buffID == buffId then
                -- buffData = v
                exist = true
                break
            end
        end
    end
    -- if buffData then
    --     exist = true
    -- end
    return exist
end

function ManorDiningTableModel:checkSameBuffTypeIsExist(buffId)
    local exist = false
    local heroData = RoleDataManager:getMaster()
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(heroData:getSpriteID())
    local buffData
    local config = ConfigManager:getBufferConfigById(buffId)
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            if v.buffEffectType == config.buffEffectType and v.buffEffectTypeLV >= config.buffEffectTypeLV then
                -- buffData = v
                exist = true
                break
            end
        end
    end

    return exist
end

function ManorDiningTableModel:checkRecipeHasUnlock(recipeData)
    local GameInManorManager = require "app.game.GameInManorManager"
    local isLock = false
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(recipeData.unlockType)
    local conditionValue = recipeData.unlockLevel
    if conditionValue > buildData.level then
        isLock = true
    end 
    return isLock
end

function ManorDiningTableModel:getBuffID(data)
    local GameInManorManager = require "app.game.GameInManorManager"
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_Table)
    local buffList = string.split(data.buffId, ";")
    local skinList = string.split(data.skinId, ";")
    local skin2BuffMap = {}
    for k, v in ipairs(skinList) do
        skin2BuffMap[tonumber(v)] = tonumber(buffList[k])
    end
    return skin2BuffMap[buildData.facadeId] or nil
end

return ManorDiningTableModel