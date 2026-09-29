--[[--
数据模型SouvenirModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/09
--desc	: SouvenirModel
--纪念品模型
------------------------------------------------------------------------------

local SouvenirModel = class("SouvenirModel",mvc.GameModel)

local GameDataManager = require("app.game.GameDataManager")

function SouvenirModel:initData()
	self.souvenirData = {}
    local profileSouvenirData = ConfigManager:getAllSouvenirData()

    for _, v in pairs(profileSouvenirData) do
        local data = clone(v)
        data.level = 1 --当前等级
        data.activationExpiredTime = 0 --激活过期时间
        data.getTime = 0 --获得时间
        data.fristRedDot = false --是否第一次打开纪念品(默认为不需要红点,当数据更新时，设置为需要红点)

        table.insert(self.souvenirData, data)
        -- self.souvenirData[v.ID] = v
        -- self.souvenirData[v.ID].level = 1 --当前等级
        -- self.souvenirData[v.ID].activationExpiredTime = 0 --激活过期时间
        -- self.souvenirData[v.ID].getTime = 0 --获得时间
        -- self.souvenirData[v.ID].fristRedDot = false --是否第一次打开纪念品(默认为不需要红点,当数据更新时，设置为需要红点)
    end
end

function SouvenirModel:openSouvenirDeleteRedDot(souvenidID)
    if not souvenidID then return end

    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local redDotData = globalUserData:getSouvenirRedDotData()
    local needSave = false
    if redDotData[souvenidID] then
        redDotData[souvenidID] = nil
        needSave = true
    end

    if globalUserData and needSave then
        globalUserData:setSouvenirRedDotData(redDotData)
        Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)

        return true
    end

    return false
end

function SouvenirModel:initNetData(data)
    if data and table.nums(data) > 0 then
        for _, v in pairs(data) do
            for _, m in pairs(self.souvenirData) do
                if v.souvenidID == m.ID then
                    m.level = v.level
                    if v.activationExpiredTime > 0 then
                        m.activationExpiredTime = v.activationExpiredTime + GameManager:getEPOCHTime()
                    end
                    if v.getTime > 0 then
                        m.getTime = v.getTime + GameManager:getEPOCHTime()
                    end
                end
            end
            -- if self.souvenirData[v.souvenidID] then
            --     self.souvenirData[v.souvenidID].level = v.level
            --     self.souvenirData[v.souvenidID].activationExpiredTime = v.activationExpiredTime
            --     self.souvenirData[v.souvenidID].getTime = v.getTime
            -- end
        end

        self:updateSouvenirDatas()
    end
end

function SouvenirModel:updateNetData(data)
    if data then
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        local redDotData = globalUserData and globalUserData:getSouvenirRedDotData() or {}
        local needSave = false
        for _, v in ipairs(self.souvenirData) do
            if v.ID == data.souvenidID then
                -- v.level = data.level
                -- v.activationExpiredTime = data.activationExpiredTime + GameManager:getEPOCHTime()

                if v.getTime == 0 and data.getTime > 0 then
                    needSave = true
                    if not redDotData[data.souvenidID] then
                        redDotData[data.souvenidID] = true
                    end
                end

                -- v.getTime = data.getTime + GameManager:getEPOCHTime()
            end
        end

        if globalUserData and needSave then
            globalUserData:setSouvenirRedDotData(redDotData)
            Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
        end

        if data.activationExpiredTime > 0 then
            data.activationExpiredTime = data.activationExpiredTime + GameManager:getEPOCHTime()
        end
        if data.getTime > 0 then
            data.getTime = data.getTime + GameManager:getEPOCHTime()
        end

        self:updateSouvenirDatas(data)
    end
end

function SouvenirModel:updateSouvenirDatas(updateData)

    --更新纪念品具体数据
    if self.souvenirData and table.nums(self.souvenirData) > 0 then
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        local redDotData = globalUserData and globalUserData:getSouvenirRedDotData() or {}
        -- print("redDotData ===== ", updateData and updateData.souvenidID)
        -- dump(redDotData,nil,10)
        for k, v in pairs(self.souvenirData) do
            if not updateData or v.ID == updateData.souvenidID then

                if updateData then
                    v.activationExpiredTime = updateData.activationExpiredTime
                    v.getTime = updateData.getTime
                    v.level = updateData.level
                end

                
                local endTime = v.activationExpiredTime - GameManager:getNowServerTime()
                -- print("  endTime ======= ", endTime, v.ID, v.activationExpiredTime, GameManager:getNowServerTime())
                if endTime > 0 then
                    v.isActivity = true
                else
                    v.isActivity = false
                end

                if v.getTime > 0 then
                    v.isGet = true
                else
                    v.isGet = false
                end

                local souvenirAttrId = v.ID * 1000 + v.level
                local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
                if profileSouvenirAttrData then
                    v.upgradeCost = profileSouvenirAttrData.upgradeCost
                    v.effect = profileSouvenirAttrData.effect
                    v.effectDes = profileSouvenirAttrData.effectDes
                    v.attr = profileSouvenirAttrData.attr
                    v.attrDes = profileSouvenirAttrData.attrDes
                end

                -- 更新第一次打开红点
                if redDotData[v.ID] then
                    v.fristRedDot = true
                else
                    v.fristRedDot = false
                end
            end
            
        end

        --排序
        table.sort(self.souvenirData, function(a, b)
            if a.isGet ~= b.isGet then
                return a.isGet -- true 会被视为比 false 更小
            end

            if a.isGet and b.isGet and a.isActivity ~= b.isActivity then
                return a.isActivity -- true 会被视为比 false 更小
            end
            -- 如果 isActivity 相同，根据 sort 排序 (小的在前)
            return a.sort < b.sort
        end)

    end


    -- print("   self.souvenirData =======    ")
    -- dump(self.souvenirData,nil,10)

end

function SouvenirModel:isRedData(souvenidID)
    local data = nil
    for _, v in pairs(self.souvenirData) do
        if v.ID == souvenidID then
            data = v
            break
        end
    end
    if data then
        if data.fristRedDot then
            return true
        end

        if data.isGet then
            local souvenirAttrId = data.ID * 1000 + data.level
            local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
            local profileSouvenirAttrData2 = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId + 1)
            if profileSouvenirAttrData and profileSouvenirAttrData2 then
                local upgradeCostStr = profileSouvenirAttrData.upgradeCost
                if upgradeCostStr and upgradeCostStr ~= "" then
                    local upgradeCost = string.split(upgradeCostStr, ",")
                    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(upgradeCost[1]), true)
                    if goodNumber >= tonumber(upgradeCost[2]) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function SouvenirModel:showRepeatGet(id)
    --重复获取
    local getData = ConfigManager:getSouvenirDataByID(id)
    if getData then
        local conversion = getData.conversion
        if conversion and conversion ~= "" then
            local conversionData = string.split(conversion, ";")
            local itemData = {}
            for _, v in pairs(conversionData) do

                if v and v ~= "" then
                    local conversionData2 = string.split(v, ",")
                    if table.nums(conversionData2) == 2 then
                        local goodId = tonumber(conversionData2[1])
                        local goodNum = tonumber(conversionData2[2])
                        
                        if goodId and goodNum then
                            local goodData = GoodsDataManager:createLocalGoodsData(goodId)
                            goodData:setIsNew(false)
                            goodData:setNum(goodNum)
                            table.insert(itemData, goodData)
                            
                        end
                    end
                end
            end

            if #itemData > 0 then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD,itemData)
            end
        end

    end
end

function SouvenirModel:isShowRedPoint()

    for _, v in pairs(self.souvenirData) do
        if self:isRedData(v.ID) then
            return true
        end
    end

    return false
end

function SouvenirModel:havaSouvenirNum()
    local num = 0

    for _, v in pairs(self.souvenirData) do
        if v.isGet then
            num = num + 1
        end
    end
    
    return num
end

function SouvenirModel:havaSouvenirActivityNum()
    local num = 0

    for _, v in pairs(self.souvenirData) do
        if v.isActivity then
            num = num + 1
        end
    end
    
    return num
end

function SouvenirModel:getSouvenirDataByID(souvenidID)
    for _, v in pairs(self.souvenirData) do
        if v.ID == souvenidID then
            return v
        end
    end
    return nil
end

function SouvenirModel:getLevelStrBySouvenirID(souvenidID)
    local levelStr = ""
    for _, v in pairs(self.souvenirData) do
        if v.ID == souvenidID then
            if v.upgradeCost == "" then
                levelStr = "MAX"
            else
                levelStr = "Lv." .. v.level
            end
            break
        end
    end
    return levelStr
end

function SouvenirModel:activitIsFull()
    local activeNum = self:havaSouvenirActivityNum()
    local totaActivelNum = tonumber(ConfigManager:getGeneralForKey("souvenirEffectLim"))
    if activeNum >= totaActivelNum then
        return true
    end
    return false
end


return SouvenirModel