local GameDataManager = require("app.game.GameDataManager")
RedPointManager = RedPointManager or {}

-- 定义小红点的ID
REDPOINT_ID = {
    -- 七日新的签到
    SEVENDAY_NEW_SIGN = 100000000,


    -- 以下为集合类小红点
    COLLECTION_SEVENDAY = 200000000,
}

--[[
    小红点关系，主要是解决集合类小红点， 应该考虑用配置文件来实现
]]
REDPOINT_PARENT_TREE = {}

--[[
    注册所有的小红点判断函数
]]
function RedPointManager:initRegister()
    -- 这里添加注册的所有函数
    self:_registerRedPoint(REDPOINT_ID.SEVENDAY_NEW_SIGN, function() return self:_checkNewSign(SEVEN_DAY_SIGN) end)
    self:_registerRedPoint(REDPOINT_ID.COLLECTION_SEVENDAY, function() return self._checkCollection(REDPOINT_ID.COLLECTION_SEVENDAY) end)
end

function RedPointManager:init()
    REDPOINT_PARENT_TREE[REDPOINT_ID.COLLECTION_SEVENDAY] = {REDPOINT_ID.SEVENDAY_NEW_SIGN}

    -- 根据新场景NPC相关初始化

    --[[
        单个数据示例
        {
            status = false,       -- 当前状态， true 标识显示小红点，false 不显示小红点
            checkFunction = nil,  -- 检测小红点状态函数
            preStatus = nil       -- 上一次状态， nil 标识没有刷新过
        }
    ]]
    self._redPointArr = {}
    -- 注册的事件
    self._eventHandlerMap = {}
end

function RedPointManager:registerRedPoint(ID, checkFunction)
    ID = tostring(ID)
    self:_registerRedPoint(ID, checkFunction)
end

function RedPointManager:registerCollectRedPoint(ID, collectArr)
    ID = tostring(ID)
    REDPOINT_PARENT_TREE[ID] = collectArr
    RedPointManager:registerRedPoint(ID, function()
        return self:_checkCollection(ID)
    end)
end

function RedPointManager:refreshAllRedPoint()
    -- 根据监听的事件来刷新所有红点
    if(self._eventHandlerMap) then 
        for ID, handlerList in pairs(self._eventHandlerMap) do 
            self:_refreshRedPointByID(ID)
        end
    end
end

function RedPointManager:refreshRedPointByID(ID)
    ID = tostring(ID)
    self:_refreshRedPointByID(ID)
    if(REDPOINT_PARENT_TREE[ID] == nil) then 
        for _k, collectArr in pairs(REDPOINT_PARENT_TREE) do 
            for k, v in ipairs(collectArr) do 
                if(tostring(v) == ID) then 
                    self:_checkCollection(_k)
                    break
                end
            end
        end
    end
end

function RedPointManager:triggerNewRedPointFlag(ID)
    ID = tostring(ID)
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(globalUserData) then
        globalUserData:getNewRedPointArr()[ID] = true
    end
    self:refreshRedPointByID(ID)
end

-- 清理触发小红点的标记
function RedPointManager:clearTriggerNewRedPointFlag(ID)
    ID = tostring(ID)
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(globalUserData) then
        globalUserData:getNewRedPointArr()[ID] = false
    end
    self:refreshRedPointByID(ID)
end

-- 添加事件监听器
function RedPointManager:addEventListener(ID, target, callback)
    ID = tostring(ID)
    assert(type(ID) == "string", "RedPointManager addEventListener: event name is invalid.")
    assert(type(target) == "table" or type(target) == "userdata", "RedPointManager addEventListener: target is invalid.")
    assert(type(callback) == "function", "RedPointManager addEventListener: callback is invalid.")
    
    local handler = {
        [1] = target,
        [2] = callback
    }
    local handlerList = self._eventHandlerMap[ID]
    if (not handlerList) then
        handlerList = {}
        self._eventHandlerMap[ID] = handlerList
    end

    table.insert(handlerList, handler)
    
    self:refreshRedPointByID(ID)
end

-- 移除事件监听器
function RedPointManager:removeEventListener(ID, target, callback)
    ID = tostring(ID)
    assert(type(ID) == "string", "RedPointManager removeEventListener: event name is invalid.")
    assert(type(target) == "table" or type(target) == "userdata", "RedPointManager removeEventListener: target is invalid.")
    assert(type(callback) == "function", "RedPointManager removeEventListener: callback is invalid.")

    local found = false
    local handlerList = self._eventHandlerMap[ID]
    if (handlerList) then
        for i = 1, #handlerList do
            local handler = handlerList[i]
            if (handler) then
                if (handler[1] == target and handler[2] == callback) then
                    table.remove(handlerList, i)
                    found = true
                    break
                end
            else 
                assert(false) 
            end
        end
    end
end

-- 移除事件监听器
function RedPointManager:removeEventListenerByName(ID)
    self._eventHandlerMap[ID] = nil
end

-- 移除所有事件监听器
function RedPointManager:removeAllEventListener()
    self._eventHandlerMap = {}
end

--[[
    注册一个小红点,本文件需要在开始的时候
    ID = REDPOINT_ID.SEVENDAY_NEW_SIGN
    checkFunction = function() ... end
]]
function RedPointManager:_registerRedPoint(ID, checkFunction)
    ID = tostring(ID)
    if(self._redPointArr == nil) then 
        self._redPointArr = {}
    end

    if(self._redPointArr[ID] == nil) then 
        local redPoint = {}
        redPoint.checkFunction = checkFunction

        local status = false
        if(checkFunction) then 
            status = checkFunction()
        end

        redPoint.status = status

        self._redPointArr[ID] = redPoint
    end
end


function RedPointManager:_refreshRedPointByID(ID)
    ID = tostring(ID)
    -- 根据监听的事件来刷新所有红点
    local redPoint = self._redPointArr[ID]
    if(redPoint) then 
        if(redPoint.checkFunction) then 
            redPoint.status = redPoint.checkFunction()
            if(redPoint.status) then
                local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
                if(globalUserData) then
                    if globalUserData:getNewRedPointArr()[ID] == true then 
                        redPoint.status = false
                    end
                end
            end
        end
        -- if(redPoint.status ~= redPoint.preStaus) then 
            redPoint.preStaus = redPoint.status

            local handlerList = self._eventHandlerMap[ID]
            if(handlerList) then
                for i = 1, #handlerList do
                    local handler = handlerList[i]
                    if(handler) then
                        if (handler and handler[2] and handler[1]) then
                            handler[2](handler[1], redPoint.status)
                        end
                    end
                end
            end
        -- end
    else
        printError("RedPointManager  ID=%d not register", ID) 
    end
end

----------------------------- 具体判断小红点的函数（每个游戏需要替换） 开始 ----------------------
function RedPointManager:_checkNewSign()
    return mvc.sevenDaysModel:getSevenRedStatus(SEVEN_DAY_SIGN)
end

function RedPointManager:_checkCollection(collectionID)
    -- 根据聚合条件判断对象
    local childrenArr = REDPOINT_PARENT_TREE[collectionID]
    if(childrenArr) then 
        local status = false
        for k,v in pairs(childrenArr) do 
            self:_refreshRedPointByID(v)

            local redPoint = self._redPointArr[tostring(v)]
            if(redPoint and redPoint.status) then 
                status = true
                break
            end
        end

        -- 处理回调
        local redPoint = self._redPointArr[collectionID]
        if(redPoint) then
            redPoint.preStaus = redPoint.status
            redPoint.status = status
            local handlerList = self._eventHandlerMap[collectionID]
            if(handlerList) then
                for i = 1, #handlerList do
                    local handler = handlerList[i]
                    if(handler) then
                        if (handler and handler[2] and handler[1]) then
                            handler[2](handler[1], redPoint.status)
                        end
                    end
                end
            end
        end

        return status
    end

    return false
end




----------------------------- 具体判断小红点的函数（每个游戏需要替换）结束 ----------------------


RedPointManager:init()