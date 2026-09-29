--[[
    战斗中的行为
]]

require "app.action.Action"

Action = Action or {}

local BattleAction = class("BattleAction", Action.Base)
Action.BattleAction = BattleAction

-- private:
-- 构造函数
function BattleAction:ctor(actionType, battleMachine)
    assert(type(actionType) == "number", "BattleAction constructor: action type is invalid.")
    
    BattleAction.super.ctor(self, actionType)

    if battleMachine then
        self._battleMachine = battleMachine
        self._battleModel = battleMachine:getModel()
    end
end

-- 析构函数
function BattleAction:dtor()
    self._battleMachine = nil
    self._battleModel = nil

    BattleAction.super.dtor(self)
end

-- 清理相关数据
function BattleAction:clear()
    BattleAction.super.clear(self)

    self._battleMachine = nil
    self._battleModel = nil
end

-- 设置战斗引擎对象
function BattleAction:setBattleMachine(battleMachine)
    if battleMachine then
        self._battleMachine = battleMachine
        self._battleModel = battleMachine:getModel()
    end
end

-- public:
-- 添加渲染命令
function BattleAction:pushRendererCommand(rendererCommand)
    assert(type(rendererCommand) == "table" and rendererCommand.__cname == "RendererCommand", "BattleAction pushRendererCommand: renderer command is invalid.")
    if self._battleMachine then
        self._battleMachine:pushCommand(rendererCommand)
    else
        assert(false, "BattleAction:pushRendererCommand   self._battleMachine  is nil")
    end
end

-- 添加音效命令
function BattleAction:pushPlayerCommand(playerCommand)
    assert(type(playerCommand) == "table" and rendererCommand.__cname == "PlayerCommand", "BattleAction pushPlayerCommand: renderer command is invalid.")
    if self._battleMachine then
        self._battleMachine:pushCommand(playerCommand)
    else
        assert(false, "BattleAction:pushPlayerCommand   self._battleMachine  is nil")
    end
end

function BattleAction:update(dt)
     BattleAction.super.update(self, dt)
end