--[[
    行为辅助类：用于辅助行为的执行
]]--

require "app.pool.PoolObject"
require "app.pool.Pool"
require "utils.List"

Action = Action or {}

local ActionEntry = class("ActionEntry", Pool.PoolObject)
Action.ActionEntry = ActionEntry

-- private:
-- 对象池
local ActionEntryPool = nil

local DEBUG = false

-- public:
-- 创建对象
function ActionEntry:create(reused, ...)
    if (reused) then
        if (not ActionEntryPool) then
            ActionEntryPool = Pool.Pool:create(ActionEntry)
        end
        return ActionEntryPool:applyObject()
    else
        return ActionEntry.new(...)
    end
end

-- 构造函数
function ActionEntry:ctor()
    -- print("ActionEntry constructor.")

    self._list = Avalon.List:create()
end

-- 销毁
function ActionEntry:dtor()
    if(DEBUG) then
        print("ActionEntry destructor.")
    end

    self._list:destroy(function(item)
        item:destroy()
    end)
    self._list = nil
end

-- 初始化
function ActionEntry:init()
    if(DEBUG) then
        print("ActionEntry init.")
    end
end

-- 清理
function ActionEntry:clear()
    if(DEBUG) then
        print("ActionEntry clear.")
    end
    
    self._list:clear(function(item)
        item:destroy()
    end)
end

-- 获取执行的action
function ActionEntry:getAction()
    return self._list:head()
end

-- 添加action
function ActionEntry:pushAction(action)
    self._list:push_back(action)
end

-- 移除当前的action
function ActionEntry:popAction()
    return self._list:pop_front()
end

-- 获取尺寸
function ActionEntry:size()
    return self._list:size()
end

-- 获取最后一个action 
function ActionEntry:getLastAction()
    return self._list:tail();
end

--[[
    遍历里面所有ACTION
    target: 
    callBack: callBack(target, item) 回调函数
    isFromTail: nil ，false 从头开始遍历  true 反向遍历
]]
function ActionEntry:traverseActions(target,callBack,isFromTail)
    self._list:traverse(target,callBack,isFromTail)
end

-- 查找第一个满足条件的元素
function ActionEntry:findAction(callBack, isFromTail)
    return self._list:find(callBack, isFromTail)
end

-- 获取所有的action
function ActionEntry:getActionList()
    local actionList = {}
    local i = 1
    self._list:traverse(self, function(self, action)
        actionList[i] = action
        i = i + 1
    end)
    return actionList
end
