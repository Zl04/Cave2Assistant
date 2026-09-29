--[[
    通用命令
]]--

require "app.command.Command"
require "app.pool.Pool"

Command = Command or {}

local GenerationCommand = class("GenerationCommand", Command.Base)
Command.GenerationCommand = GenerationCommand

-- private:
-- 构造函数
function GenerationCommand:ctor()
    GenerationCommand.super.ctor(self, CommandCategory.GENERATION, CommandType.NONE)
end

-- 析构函数
function GenerationCommand:dtor()
    GenerationCommand.super.dtor(self)
end

-- public:
-- 创建对象
local GenerationCommandCommandPool = nil
function GenerationCommand:create(reused, ...)
    if (reused) then
        if (not GenerationCommandCommandPool) then
            GenerationCommandCommandPool = Pool.Pool:create(GenerationCommand)
        end
        return GenerationCommandCommandPool:applyObject()
    else
        return GenerationCommand.new(...)
    end
end

-- 清理
function GenerationCommand:clear()
    GenerationCommand.super.clear(self)

    self.type = CommandType.NONE
    self.touchPosition = nil
end

-- 初始化点击事件开始的命令
function GenerationCommand:initTouchBeganCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_BEGAN
    self.touchPosition = touchPosition
end

-- 初始化点击事件移动的命令
function GenerationCommand:initTouchMovedCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_MOVED
    self.touchPosition = touchPosition
end

-- 初始化点击事件取消的命令
function GenerationCommand:initTouchCancelCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_CANCEL
    self.touchPosition = touchPosition
end

-- 初始化点击事件结束的命令
function GenerationCommand:initTouchEndedCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_ENDED
    self.touchPosition = touchPosition
end

-- 初始化长按点击事件开始的命令
function GenerationCommand:initTouchLongTimeBeganCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_LONG_TIME_BEGAN
    self.touchPosition = touchPosition
end

-- 初始化长按点击事件结束的命令
function GenerationCommand:initTouchLongTimeEndedCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_LONG_TIME_ENDED
    self.touchPosition = touchPosition
end

-- 初始化事件点击命令
function GenerationCommand:initTouchClickCommand(touchPosition)
    self.type = CommandType.GENERATION_TOUCH_CLICK
    self.touchPosition = touchPosition
end

-- 初始化开始移动
function GenerationCommand:initForStartMove(direction)
    self.type = CommandType.GENERATION_START_MOVE
    self.direction = direction
end

-- 初始化停止移动
function GenerationCommand:initForStopMove()
    self.type = CommandType.GENERATION_STOP_MOVE
end

-- 更新地图中心点
function GenerationCommand:initForUpdateMapCenter(coord)
    self.type = CommandType.GENERATION_UPDATE_MAP_CENTER
    self.coord = coord
end

-- 处理层级
function GenerationCommand:initForRoleZorder(spriteID,endIdle,kickSpriteID)
    self.type = CommandType.GENERATION_ROLE_ZORDER

    self.spriteID = spriteID
    self.endIdle = endIdle
    self.kickSpriteID = kickSpriteID
end