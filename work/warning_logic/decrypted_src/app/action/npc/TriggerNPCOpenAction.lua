--[[
    状态机行为：打开触发
]]--

require "app.action.Action"
require "app.pool.Pool"
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")

Action = Action or {}

local TriggerNPCOpenAction = class("TriggerNPCOpenAction", Action.Base)
Action.TriggerNPCOpenAction = TriggerNPCOpenAction

-- private:
-- 对象池
local TriggerNPCOpenActionPool = nil

-- public:
-- 创建对象
function TriggerNPCOpenAction:create(reused, ...)
    if (reused) then
        if (not TriggerNPCOpenActionPool) then
            TriggerNPCOpenActionPool = Pool.Pool:create(TriggerNPCOpenAction)
        end
        return TriggerNPCOpenActionPool:applyObject()
    else
        return TriggerNPCOpenAction.new(...)
    end
end

-- 构造函数
function TriggerNPCOpenAction:ctor()
    TriggerNPCOpenAction.super.ctor(self, ActionType.NPC_TRIGGER_OPEN)
    
    self._coord = Geome.Coord:create(0, 0, 0)
    self._battleMachine = nil
end

-- 模版函数：销毁
function TriggerNPCOpenAction:dtor()
    TriggerNPCOpenAction.super.dtor(self)

    self._battleMachine = nil
end

-- 初始化
function TriggerNPCOpenAction:init(target, battleMachine,recoverOpen)
    TriggerNPCOpenAction.super.init(self, target)

    self._battleMachine = battleMachine
    self._recoverOpen = recoverOpen
end

-- 清理
function TriggerNPCOpenAction:clear()
    TriggerNPCOpenAction.super.clear(self)

    self._battleMachine = nil
end

-- 模版函数：action开始
function TriggerNPCOpenAction:onStart()
    -- 切换状态
    -- print("TriggerNPCOpenAction:switchState  OPEN:",TriggerNPCState.OPEN);
    if (not self._target:switchState(TriggerNPCState.OPEN)) then
        return false
    end
    -- 触发一次
    self._target:trigger()

    if(self._target:getIsOpen()) then 
        local openItCommand = Command.RendererCommand:create()
        openItCommand:initOpenItCommand(self._target:getId(),self._recoverOpen)
        SceneManager:getInstance():pushCommand(openItCommand)
    end
    
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_OPEN_NPC, self._target:getData())

    -- 添加密室门打开的抖动效果
    if(self._target:getType() == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or self._target:getType() == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then 
        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 5, 2)
    end

    -- 根据陷阱特性做了调整
    if self._target:getRemoveAfterTrigger() and self._target:getType() ~= PublicDefine.TRIGGER_NPC_TYPE.TRAP then
        MachineManager:getInstance():pushRemoveModelCommand(self._target:getId(), false)
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, self._target:getData()) 
    end

    return true
end

-- 模版函数：action结束
function TriggerNPCOpenAction:onEnd()
    -- 
end

function TriggerNPCOpenAction:onFail()
    -- 
end