--[[
    在lua端的统一update，主要用于非ccnode的lua对象的update
]]--

Avalon = Avalon or {}

local Scheduler = {}
Avalon.Scheduler = Scheduler

-- private:
local updateHandler = nil
local handlers = {}
local onceHandlers = {}
local currentDT = 0
local frameHandlers = {} --帧事件
local onceMinFrameHandlers = {}

--[[私有方法]]--
local _func = nil
local _target = nil
local _dt = 0
local _params = nil
local function executeHandler()
    _func(_target, _dt)
end
local function executeOnceHandler()
    _func(_target, _params)
end
local function update(dt)
    -- 这里驱动数据层的数据更新处理
    if(SkillDataManager) then
        SkillDataManager:update(dt)
    end
    local GameDataManager = require("app.game.GameDataManager")
    GameDataManager:getInstance():update(dt)

    local i = 1
    local count = #handlers
    for i = 1, count do
        local handler = handlers[i]
        -- local target = handler[1]
        -- local func = handler[2]
        -- func(target, dt)
        if handler then
            _target = handler[1]
            _func = handler[2]
            _dt = dt
            executeHandler()
        end
        -- local status, msg = xpcall(executeHandler, __G__TRACKBACK__)
        -- if not status then
        --     print("-------------- update crash ---------------")
        --     print(msg)
        --     print("-------------------------------------------")

        --     -- 记录崩溃日志信息
        --     Avalon.Log:record(msg)
        --     -- 销毁
        --     destroyModules()
        -- end
    end

    i = 1
    count = #onceHandlers
    if (count >= 1) then
        repeat 
            local handler = onceHandlers[i]
            handler[4] = handler[4] + dt

            if (handler[4] >= handler[3]) then
                local target = handler[1]
                local func = handler[2]
                -- func(target, handler[5])

                _target = handler[1]
                _func = handler[2]
                _params = handler[5]
                table.remove(onceHandlers, i)
                executeOnceHandler()
                -- local status, msg = xpcall(executeOnceHandler, __G__TRACKBACK__)
                -- if not status then
                --     print("-------------- update once crash ---------------")
                --     print(msg)
                --     print("-------------------------------------------")

                --     -- 记录崩溃日志信息
                --     Avalon.Log:record(msg)
                --     -- 销毁
                --     destroyModules()
                -- end
                count = count - 1

                -- print("update once ", i, #onceHandlers, count, handler, handler[4], handler[5])
            else
                i = i + 1
            end
        until (i > count)
    end

    i = 1
    count = #frameHandlers
    if (count >= 1) then
        repeat 
            local handler = frameHandlers[i]
            handler[4] = handler[4] + 1

            if (handler[4] > handler[3]) then
                local target = handler[1]
                local func = handler[2]
                _target = handler[1]
                _func = handler[2]
                _params = handler[5]
                table.remove(frameHandlers, i)
                executeOnceHandler()
                count = count - 1
            else
                i = i + 1
            end
        until (i > count)
    end

    i = 1
    count = #onceMinFrameHandlers
    if (count >= 1) then
        repeat 
            local handler = onceMinFrameHandlers[i]
            handler[5] = handler[5] + dt
            handler[6] = handler[6] + 1

            if (handler[5] > handler[3] and handler[6] >= handler[4]) then
                local target = handler[1]
                local func = handler[2]
                _target = handler[1]
                _func = handler[2]
                _params = handler[7]
                table.remove(onceMinFrameHandlers, i)
                executeOnceHandler()

                count = count - 1
            else
                i = i + 1
            end
        until (i > count)
    end

    currentDT = dt
end

--[[公有方法]]--
-- 初始化
function Scheduler:init()
    if(updateHandler == nil)  then 
        local scheduler = cc.Director:getInstance():getScheduler()
        updateHandler = scheduler:scheduleScriptFunc(update, 0.0, false)
    end

    print("Scheduler: init scheduler.")
end

-- 销毁
function Scheduler:destroy()
    if (updateHandler) then
        local scheduler = cc.Director:getInstance():getScheduler()
        scheduler:unscheduleScriptEntry(updateHandler)
        updateHandler = nil
    end

    handlers = {}
    onceHandlers = {}
    frameHandlers = {}
    onceMinFrameHandlers = {}

    print("Scheduler: destroy scheduler.")
end

-- 清理
function Scheduler:clear()
    if (inited) then
        for i = 1, #handlers do
            handlers[i] = nil
        end
        for i = 1, #onceHandlers do
            onceHandlers[i] = nil
        end

        for i = 1, #frameHandlers do
            frameHandlers[i] = nil
        end

        for i = 1, #onceMinFrameHandlers do
            onceMinFrameHandlers[i] = nil
        end

        inited = false
    end
end

-- 是否已经注册
function Scheduler:hasScheduled(target, func)
    for i = 1, #handlers do
        local handler = handlers[i]
        if (handler[1] == target and
            handler[2] == func) then
            return i
        end
    end
    return 0
end

-- 注册更新
function Scheduler:scheduleUpdate(target, func)
    assert(type(func) == "function", "[ERROR] Scheduler scheduleUpdate: func is nil")

    if (self:hasScheduled(target, func) == 0) then
        local handler = {
            [1] = target,
            [2] = func
        }
        table.insert(handlers, handler)
    else
        -- print("[WARNING] Scheduler scheduleUpdate: the handler has been scheduled.")
    end
end

-- 是否已经注册了一次更新的计时器
function Scheduler:hasScheduledUpdateOnce(target, func)
    for i = 1, #onceHandlers do
        local handler = onceHandlers[i]
        if (handler[1] == target and
            handler[2] == func) then
            return i
        end
    end
    return 0
end

-- 
function Scheduler:hasScheduledUpdateOnceMinFrame(target, func)
    for i = 1, #onceMinFrameHandlers do
        local handler = onceMinFrameHandlers[i]
        if (handler[1] == target and
            handler[2] == func) then
            return i
        end
    end
    return 0
end

-- 是否已经注册了一次更新的计时器
function Scheduler:hasScheduledUpdateOnceFrameEvent(target, func)
    for i = 1, #frameHandlers do
        local handler = frameHandlers[i]
        if (handler[1] == target and
            handler[2] == func) then
            return i
        end
    end
    return 0
end

-- 注册更新一次
function Scheduler:scheduleUpdateOnce(target, func, delay, ...)
    if(type(func) ~= "function" or type(delay) ~= "number") then 
        print("Scheduler:scheduleUpdateOnce delay=", delay)
        printError("Scheduler:scheduleUpdateOnce params is invalid.")
        return
    end

    if (self:hasScheduledUpdateOnce(target, func) == 0) then
        local handler = {
            [1] = target,
            [2] = func,
            [3] = delay,
            [4] = 0,
            [5] = {...}
        }
        table.insert(onceHandlers, handler)
    else
        -- print("[WARNING] Scheduler scheduleUpdateOnce: the handler has been scheduled.")
    end
end

-- 循环更新 更新一次
function Scheduler:scheduleUpdateOnceWithOutCheck(target, func, delay, ...)
    if(type(func) ~= "function" or type(delay) ~= "number") then 
        print("Scheduler:scheduleUpdateOnce delay=", delay)
        printError("Scheduler:scheduleUpdateOnce params is invalid.")
        return
    end

    local handler = {
        [1] = target,
        [2] = func,
        [3] = delay,
        [4] = 0,
        [5] = {...}
    }
    table.insert(onceHandlers, handler)
end


-- 注册更新一次
function Scheduler:scheduleUpdateOnceAndMinFrame(target, func, delay, minFrame, ...)
    if(type(func) ~= "function" or type(delay) ~= "number" or type(minFrame) ~= "number") then 
        print("Scheduler:scheduleUpdateOnceAndMinFrame delay, minFrame=", delay, minFrame)
        printError("Scheduler:scheduleUpdateOnceAndMinFrame params is invalid.")
        return
    end

    if (self:hasScheduledUpdateOnceMinFrame(target, func) == 0) then
        local handler = {
            [1] = target,
            [2] = func,
            [3] = delay,
            [4] = minFrame,
            [5] = 0,
            [6] = 0,
            [7] = {...}
        }
        table.insert(onceMinFrameHandlers, handler)
    else
        -- print("[WARNING] Scheduler scheduleUpdateOnce: the handler has been scheduled.")
    end
end

-- 注册更新一次 帧事件
function Scheduler:scheduleUpdateOnceByFrameEvent(target, func, targetFrame, ...)
    assert(type(func) == "function", "[ERROR] Scheduler scheduleUpdateOnceFrameEvent: func is nil")
    if(type(func) ~= "function" or type(targetFrame) ~= "number") then 
        print("Scheduler:scheduleUpdateOnceByFrameEvent delay=", targetFrame)
        printError("Scheduler:scheduleUpdateOnceByFrameEvent params is invalid.")
        return
    end
    if (self:hasScheduledUpdateOnceFrameEvent(target, func) == 0) then
        local handler = {
            [1] = target,
            [2] = func,
            [3] = targetFrame,
            [4] = 0,
            [5] = {...}
        }
        table.insert(frameHandlers, handler)
    else
        -- print("[WARNING] Scheduler scheduleUpdateOnceFrameEvent: the handler has been scheduled.")
    end
end

-- 取消注册更新
function Scheduler:unscheduleUpdate(target, func)
    local index = self:hasScheduled(target, func)
    if (index ~= 0) then
        table.remove(handlers, index);
    else
        -- print("[WARNING] Scheduler scheduleUpdate: the handler no found.")
    end
end

-- 取消注册更新一次
function Scheduler:unscheduleUpdateOnce(target, func)
    local index = self:hasScheduledUpdateOnce(target, func)
    if (index ~= 0) then
        table.remove(onceHandlers, index)
    else
        -- print("[WARNING] Scheduler unscheduleUpdateOnce: hander for update once on found.")
    end
end

-- 取消注册所有更新一次
function Scheduler:unscheduleAllUpdateOnce()
    onceHandlers = {}
end

-- 重新设置定时器延迟
function Scheduler:setDelayForUpdateOnce(target, func, delay, ...)
    local found = false

    for i = 1, #onceHandlers do
        local handler = onceHandlers[i]
        if (handler[1] == target and
            handler[2] == func) then
            handler[3] = delay
            handler[4] = 0
            handler[5] = {...}

            found = true
            break;
        end
    end
    if (not found) then
        self:scheduleUpdateOnce(target, func, delay, ...)
    end
end

-- 获取当前桢的间隔
function Scheduler:getDT()
    return currentDT
end