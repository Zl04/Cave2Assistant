--[[
     一些逻辑控制命令
]]--

require "app.command.Command"
require "app.pool.Pool"

Command = Command or {}

local ControlCommand = class("ControlCommand", Command.Base)
Command.ControlCommand = ControlCommand

-- private:
-- 对象池
local ControlCommandPool = nil

-- public:
-- 创建对象
function ControlCommand:create(reused, ...)
    if (reused) then
        if (not ControlCommandPool) then
            ControlCommandPool = Pool.Pool:create(ControlCommand)
        end
        return ControlCommandPool:applyObject()
    else
        return ControlCommand.new(...)
    end
end

-- 构造函数
function ControlCommand:ctor()
    ControlCommand.super.ctor(self, CommandCategory.CONTROL, CommandType.NONE)

    -- 携带数据
    self.data = nil
end

-- 销毁
function ControlCommand:dtor()
    ControlCommand.super.dtor(self)

    self.data = nil
end

-- 清理
function ControlCommand:clear()
    ControlCommand.super.clear(self)

    self.data = nil
end

function ControlCommand:initForTypeAndData(type,data)
    self.type = type
    self.data = data
end

function ControlCommand:initForAddBuff(data, isRecover)
    self.type = CommandType.CONTROL_ADD_BUFFER

    self.data = data
    self.isRecover = isRecover
end
