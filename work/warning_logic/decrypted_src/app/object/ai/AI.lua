--[[
    角色的ai系统
]]--

require "app.battle.command.RoleCommand"

Role = Role or {}

local AI = class("RoleAI")
Role.AI = AI

-- public:
-- 构造函数
function AI:ctor()
    self._target = nil
end

-- 销毁
function AI:destroy()
    self._target = nil
end

-- 初始化
function AI:init(target)
    assert(target ~= nil, "[ERROR] AI:init target is nil.")
    self._target = target
end

-- 每次更新可能产生一个命令，交由引擎执行
function AI:update(dt)
    return nil
end