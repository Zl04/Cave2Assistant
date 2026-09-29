--[[
    状态机行为：死亡状态
]]--

require "app.action.BattleAction"
require "app.action.Action"
require "app.pool.Pool"

local MachineManager = require("app.game.MachineManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")

Action = Action or {}

local DeadStateAction = class("DeadStateAction", Action.BattleAction)
Action.DeadStateAction = DeadStateAction

-- private:
-- 对象池
local DeadStateActionPool = nil

-- public:
-- 创建对象
function DeadStateAction:create(reused, ...)
    if (reused) then
        if (not DeadStateActionPool) then
            DeadStateActionPool = Pool.Pool:create(DeadStateAction)
        end
        return DeadStateActionPool:applyObject()
    else
        return DeadStateAction.new(...)
    end
end


-- 构造函数
function DeadStateAction:ctor()
    DeadStateAction.super.ctor(self, ActionType.FSM_REVIVE)

end

-- 模版函数：销毁
function DeadStateAction:dtor()
    ReviveStateAction.super.dtor(self)
end

-- 初始化
function DeadStateAction:init(target)
    DeadStateAction.super.init(self, target)

    self._target = target
end

-- 清理
function DeadStateAction:clear()
    DeadStateAction.super.clear(self)
end

-- 模版函数：action开始
function DeadStateAction:onStart()
    -- print("DeadStateAction:onStart ")
    -- 切换状态
    if (not self._target:switchState(FSMState.DIE)) then

        return false
    end
    -- self:forceUpdate()
    if(self._target:getType() == RoleType.Pet) then
         self:setEndTime(1)
    else
        self:setEndTime(6)
    end

    return true
end

-- 模版函数：action结束
function DeadStateAction:onEnd()
    if(SceneManager:getInstance():isInDungeon() 
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGuildBoss()) then
        -- add by yys 自己失败才回城  队友不会
        if(self._target:getType() == RoleType.Pet) then
            if self._target:getMaster() and self._target:getData() and self._target:getMaster():isMaster() then
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SHOW_HELP_REVIVE, self._target:getData():getPK(), self._target:getType())
            end
        else
            if(self._target:isMaster()) then
                -- 发送失败回城
                if( RoleBehaviorManager:autoBackTownCheck("[DeadStateAction  in Dungeon to back town]") ) then 
                    GameManager:giveUpBackTown()
                end 
            end
        end
    elseif (SceneManager:getInstance():isInStory()) then
        -- 直接复活
        GameManager:battleReviveHelp(self._target:getSpriteID(), 0)
    else
        if(self._target:getType() == RoleType.Pet) then
            if self._target:getMaster() and self._target:getData() and self._target:getMaster():isMaster() then
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SHOW_HELP_REVIVE, self._target:getData():getPK(), self._target:getType())
            end
        else
            if(self._target:isMaster()) then
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE)
            else 
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SHOW_HELP_REVIVE, self._target:getData():getPK(), self._target:getType())
            end
        end
    end
end

function DeadStateAction:onFail()
   
    -- TODO
end

function DeadStateAction:onStop()
   
    -- TODO 处理停止逻辑
end

-- 获取状态
function DeadStateAction:getFSMState()
    return FSMState.DIE
end

-- 更新
function DeadStateAction:onUpdate(dt)

end


