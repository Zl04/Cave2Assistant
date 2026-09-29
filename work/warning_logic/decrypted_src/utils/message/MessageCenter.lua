--[[
    客户端消息中心：消息监听，消息分发
]]--

local MessageCenter = {}

local inited = false
local handlerMap = nil

-- [[ 公共接口 ]] --
-- 初始化
function MessageCenter:init()
    if (not inited) then
        handlerMap = {}

        inited = true
    else
        self:clear()
    end
end

-- 清理
function MessageCenter:clear()
    for index, handlers in pairs(handlerMap) do
        if (handlers) then
            for i = 1, #handlers do
                handlers[i] = nil
            end
        end
        handlerMap[index] = nil
    end
end

-- 监听消息
-- name:消息名字，在MessageDefine.lua中定义
-- target:处理器的目标对象
-- func:处理器
function MessageCenter:bind(name, target, func)
    if name == nil or target == nil or func == nil then
        return
    end

    local found = false
    local handlers = handlerMap[name]
    if (not handlers) then 
        handlers = {}
        handlerMap[name] = handlers
    else
        for i = 1, #handlers do
            local handler = handlers[i]
            if (handler and handler[1] == target) then
                found = true
                break
            end
        end
    end
    if (not found) then
        assert(target and func)

        local handler = {
            [1] = target,
            [2] = func
        }
        table.insert(handlers, handler)
    else
        print(string.format("[WARNING] MessageCenter bind: event name %d has been binded.", name))
    end
end

-- 取消监听
-- name:消息名字，在MessageDefine.lua中定义
-- target:处理器的目标对象
-- func:处理器
function MessageCenter:unbind(name, target, func)
    if name == nil or target == nil or func == nil then
        return
    end

    local found = false
    local handlers = handlerMap[name]
    if (handlers) then
        local count = #handlers
        for i = count, 1, -1 do
            local handler = handlers[i]
            -- 如果参数中传入func，那么只解绑单个处理器，否则解绑该对象上的所有处理器
            if (func) then
                if (handler[1] == target and
                    handler[2] == func) then
                    table.remove(handlers, i)
                    found = true
                    break
                end
            else
                if (handler[1] == target) then
                    table.remove(handlers, i)
                end
            end
        end
    end
    if handlers ~= nil and #handlers == 0 then
        table.remove(handlerMap, name)
    end
    if (not found) then
        -- print(string.format("[WARNING] MessageCenter remove: event name %d no found.", name))
    end
end

-- 取消某个对象上的所有处理器
function MessageCenter:unbindForTarget(target)
    for messageName, handlers in pairs(handlerMap) do
        if (handlers) then
            local count = #handlers
            for i = count, 1, -1 do
                local handler = handlers[i]
                if (handler[1] == target) then
                    table.remove(handlers, i)
                end
            end
        end
        if handlers ~= nil and #handlers == 0 then
            table.remove(handlerMap, messageName)
        end
    end
end

--解绑所有 name 映射的处理器
function MessageCenter:unbindForName(name)
    local handlers = handlerMap[name] or {}
    handlers = {}
    if handlers ~= nil and #handlers == 0 then
        table.remove(handlerMap, name)
    end
end

-- 分发消息
-- name:消息名字，在MessageDefine.lua中定义
-- data:发送的数据
function MessageCenter:notice(name, ...)
    local handlerFound = false
    local handlers = handlerMap[name]
    if (handlers and #handlers > 0) then
        for i = 1, #handlers do
            local handler = handlers[i]
            if(handler) then
                handlerFound = true
                local target = handler[1]
                local func = handler[2]
                func(target, ...)
            end
        end
    end
    return nil, handlerFound
end
function MessageCenter:dump()
    local maxnum = 0
    for name,handlers in pairs(handlerMap) do
        local num = 0
        if (handlers) then
            num = #handlers
        end
        maxnum = maxnum + num
        -- print(string.format( "MessageCenter [%s] have [%d] listeners",name,num ))
    end
    print(string.format( "MessageCenter total have %d listeners",maxnum ))
end
MessageCenter:init()

Avalon = Avalon or {}
Avalon.MessageCenter = MessageCenter

