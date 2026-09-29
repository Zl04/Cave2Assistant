--[[
    角色动画命令
]]--

require "app.command.Command"
require "app.pool.Pool"

Command = Command or {}

local PlayerCommand = class("PlayerCommand", Command.Base)
Command.PlayerCommand = PlayerCommand

-- private:
-- 对象池
local PlayerCommandPool = nil

-- public:
-- 创建对象
function PlayerCommand:create(reused, ...)
    if (reused) then
        if (not PlayerCommandPool) then
            PlayerCommandPool = Pool.Pool:create(PlayerCommand)
        end
        return PlayerCommandPool:applyObject()
    else
        return PlayerCommand.new(...)
    end
end

-- 构造函数
function PlayerCommand:ctor()
    PlayerCommand.super.ctor(self, CommandCategory.PLAYER, CommandType.NONE)

    -- 对象
    self.target = nil
    self.skill = nil
end

-- 销毁
function PlayerCommand:dtor()
    PlayerCommand.super.dtor(self)

    self.target = nil
    self.skill = nil
end

-- 清理
function PlayerCommand:clear()
    PlayerCommand.super.clear(self)

    self.target = nil
    self.type = CommandType.NONE
    self.skill = nil
end

-- 初始化播放角色普通攻击音效
function PlayerCommand:initNormalAttackCommand(role, skill)
    self.type = CommandType.PLAYER_NORMAL_ATTACK
    self.target = role
    self.skill = skill
end
