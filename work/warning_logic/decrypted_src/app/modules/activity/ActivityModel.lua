--[[--
数据模型ActivityModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
]]
local GameModel = require(mvc.PACKAGE_APP_CORE..".GameModel")

local LanguageManager = require("app.game.LanguageManager")

local ActivityModel = class("ActivityModel",GameModel)

function ActivityModel:onRegister()

end

function ActivityModel:initData()
    self._activityData = {}
    self._turnTableData = {}       --转盘数据
end

function ActivityModel:clear()
    self._turnTableData = {}       --转盘数据
    self._activityData = {}
    self:clearTurnTableData()
end

function ActivityModel:addActivityData(data)
    if(data and data.actList) then
        for k,v in pairs(data.actList) do 
            if(v) then
                local found = false
                local handleData = nil
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == v.id) then 
                        found = true
                        oldData:initNet(v)
                        handleData = oldData
                        print(string.format("ActivityModel:addActivityData repeate id=%d", oldData:getID()))
                    end
                end

                if(found == false) then
                    local activityData = Data.ActivityData:create()
                    activityData:initNet(v)

                    table.insert(self._activityData, activityData)

                    handleData = activityData
                end
            end 
        end

        -- 对活动排序
        table.sort(self._activityData, function(a, b)
            -- print("dddddddddddddd", a.techTotalLv, a.curMemberNum, a.joinEquipScoreLmt)
            -- 判断人数是否够
            if a:getSortID() == b:getSortID() then
                if(a:getID() > b:getID()) then
                    return true
                else
                    return false
                end
            elseif a:getSortID() > b:getSortID() then
                return true
            else 
                return false
            end
        end)

        -- self:requestAllActivityWebLanguage(handler(self, self.refreshActivityLanguageCallback))
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

function ActivityModel:delActivityData(data)
    if(data and data.delList) then
        local removeArr = {}
        for k,id in pairs(data.delList) do 
            if (id) then
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == id) then 
                        self:_handleClearLuckDataTrigger(oldData)
                        table.remove(self._activityData, _)
                        break
                    end
                end
            end 
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

function ActivityModel:updateActivityStatus(data) 
    if(data and data.updateList) then
        for k,statusData in pairs(data.updateList) do 
            if (statusData) then
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == statusData.id) then 
                        self:_handleClearLuckDataTrigger(oldData)
                        oldData:updateStatus(statusData.stat, statusData.isEnabled)
                        break
                    end
                end
            end 
        end
    end
end

-- 初始化活动统计数据
function ActivityModel:initActivityCountData(data)
    -- print("MasterDataManager:initActivityCountData", data)
    for k, activityData in ipairs(data.list) do 
        for _,oldData in pairs(self._activityData) do 
            if(oldData:getID() == activityData.id) then 
                oldData:initCount(activityData)
                break
            end
        end
    end 
end 



-- 后台请求所有公会web的多语言
function ActivityModel:backgroundRequestAllActivityWebLanguage()
    -- body
    self:requestAllActivityWebLanguage(handler(self, self.refreshActivityLanguageCallback))
end

-- 请求刷新
function ActivityModel:requestAllActivityWebLanguage(callBack)
    local keyList = {}
    for _,oldData in pairs(self._activityData) do 
        local keys = oldData:getKeyList()
        if(keys) then
            for k,v in pairs(keys) do 
                table.insert(keyList,v)
            end
        end
    end

    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, callBack))
end

function ActivityModel:refreshActivityLanguageCallback()
    print("ActivityModel:refreshActivityLanguageCallback")
    for _,oldData in pairs(self._activityData) do 
        oldData:updateLanguageKeyToStr()
    end
end

function ActivityModel:getActivityDataArr()
    local activityArr = {}

    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return activityArr
    end

    local haveBindEmail = true
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
        haveBindEmail = false
    end

    if(self._activityData) then
        for _, activityData in ipairs(self._activityData) do 
            if(activityData:getIsEnable() and 
                activityData:getStatus() >= PublicDefine.ActivityRunningStat.ActivityRunningStat_Showing and 
                activityData:getIsShow()) then
                if(haveBindEmail) then 
                    table.insert(activityArr, activityData)
                else 
                    -- 过滤掉绑定邮箱的活动
                    if activityData:getType() ~= PublicDefine.ActivityType.ActivityType_MailBind then
                        table.insert(activityArr, activityData)
                    end
                end
            end
        end
    end

    return activityArr
end

function ActivityModel:getActivityDataForType(activityType)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return nil
    end

    if(self._activityData) then
        for _,activityData in pairs(self._activityData) do 
            if(activityData:getType() == activityType and activityData:isInEffect()) then 
                return activityData
            end
        end
    end

    return nil
end

-- 清理所有活动的进度
function ActivityModel:clearAllCount()
    for _,activityData in pairs(self._activityData) do 
        activityData:clearCount()
    end
end

function ActivityModel:getDiscountData(discountType)
    local discountDatas = nil
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return discountDatas
    end

    for _,activityData in pairs(self._activityData) do 
        if( activityData:isInEffect() and activityData:getType() == PublicDefine.ActivityType.ActivityType_Discount) then 
            discountDatas = {}
            local discountDataArr = activityData:getDiscountData()
            if(discountDataArr) then
                for k,v in pairs(discountDataArr) do 
                    if(v:getType() == discountType) then
                        table.insert(discountDatas, v)
                    end
                end
            end
            break
        end
    end
    return discountDatas
end


function ActivityModel:_handleClearLuckDataTrigger(oldData)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return nil
    end
    if(oldData:getType() == PublicDefine.ActivityType.ActivityType_LuckyWheel) then 
        self:clearTurnTableData()
    end
end

-- 更新活动的计数信息
function ActivityModel:updateActivityCount(data)
    -- print("MasterDataManager:updateActivityCount", data)
    local update = false
    local updateActivityData = nil
    for _,oldData in pairs(self._activityData) do 
        if(oldData:getID() == data.id) then 
            -- print("MasterDataManager:updateActivityCount")
            oldData:updateCount(data)
            update = true
            updateActivityData = oldData
            break
        end
    end

    if(update) then 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end

    return updateActivityData
end

function ActivityModel:handleReceiveReward(data)
    -- print("MasterDataManager:handleReceiveReward", data)
    local update = false
    for _,oldData in pairs(self._activityData) do 
        if(oldData:getID() == data.id) then 
            oldData:handleUpdateReward(data)
            update = true
            break
        end
    end

    if(update) then 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end
end

-- 处理公会的数据
function ActivityModel:handleActivityGuildCount(data)
    -- print("ActivityModel:handleActivityGuildCount", data)
    local guildData = self:getGuildData()
    if(guildData == nil or guildData:getID() ~= data.guildID) then 
        return 
    end
    
    if(data.countList) then 
        local update = false
        for key,updateData in pairs(data.countList) do 
            for _,oldData in pairs(self._activityData) do 
                if(oldData:getID() == updateData.activityID) then 
                    oldData:handleGuildAccountInfo(updateData)
                    update = true
                    break
                end
            end
        end
        if(update) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        end
    end
end

function ActivityModel:handleClearActivityGuildCount()
    if(self._activityData) then 
        local update = false
        for _,oldData in pairs(self._activityData) do 
            if(oldData:getType() == PublicDefine.ActivityType.ActivityType_QuestConditionGuild) then 
                oldData:handleClearGuildAccountInfo()
                update = true
                break
            end
        end
        
        if(update) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        end
    end
end

function ActivityModel:addGoodsDataTrigger(goodsData)
    if(goodsData == nil) then 
        return 
    end
    if(self._activityData) then 
        local update = false
        for _,oldData in pairs(self._activityData) do 
            if(oldData:getType() == PublicDefine.ActivityType.ActivityType_Exchange) then 
                oldData:addGoodsDataTriggerSystemMes(goodsData)
            end
        end
    end
end


function ActivityModel:getTurnTableData()
    return self._turnTableData
end

function ActivityModel:setTurnTableData(dropListId, hasBuyNum, leftTurnNum, hasTurnNum, generateTime)
    self._turnTableData.dropListId = dropListId or 0
    self._turnTableData.hasBuyNum = hasBuyNum or 0
    self._turnTableData.leftTurnNum = leftTurnNum or 0
    self._turnTableData.generateTime = generateTime or 0
    self._turnTableData.hasTurnNum = hasTurnNum or 0
end

function ActivityModel:clearTurnTableData()
    self._turnTableData.dropListId = 0
    self._turnTableData.hasBuyNum = 0
    self._turnTableData.leftTurnNum = 0
    self._turnTableData.generateTime = 0
    self._turnTableData.hasTurnNum = 0
end

function ActivityModel:isHaveFreeCountInTurnTable()
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN)) then 
        return false
    end
    local activityData = self:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyWheel)
    if(activityData and activityData:isInEffect()) then 
        return false
    end
    if self._turnTableData.hasTurnNum == nil then
        return false
    end
    if self._turnTableData.hasTurnNum == 0 and self._turnTableData.leftTurnNum > 0 then
        return true
    end
    return false
end


return ActivityModel