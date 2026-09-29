--[[
    状态机行为：等待状态
]]--

require "app.action.BattleAction"
require "app.action.Action"
require "app.pool.Pool"

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE

Action = Action or {}

local WaitingStateAction = class("WaitingStateAction", Action.BattleAction)
Action.WaitingStateAction = WaitingStateAction

-- private:
-- 对象池
local WaitingStateActionPool = nil

-- public:
-- 创建对象
function WaitingStateAction:create(reused, ...)
    if (reused) then
        if (not WaitingStateActionPool) then
            WaitingStateActionPool = Pool.Pool:create(WaitingStateAction)
        end
        return WaitingStateActionPool:applyObject()
    else
        return WaitingStateAction.new(...)
    end
end

-- 构造函数
function WaitingStateAction:ctor()
    WaitingStateAction.super.ctor(self, ActionType.FSM_WAITING)
    
    
end

-- 模版函数：销毁
function WaitingStateAction:dtor()
    WaitingStateAction.super.dtor(self)

end

--[[
    初始化参数
    target:目标
    waitingType:等待类型  下楼，回城等类型
    data:等待数据，这里根据不同等待情况有不同的数据结构
    npcTarget: npc 目标
]]
function WaitingStateAction:init(target,waitingType, data, npcTarget)
    WaitingStateAction.super.init(self, target)
    
    self._npcTarget = npcTarget
    self._waitingType = waitingType
    self._data = data
end

-- 清理
function WaitingStateAction:clear()
    WaitingStateAction.super.clear(self)

    
end

-- 模版函数：action开始
function WaitingStateAction:onStart()
    local skipWaiting = false
    if(SceneManager:getInstance():isInDungeon() and TeamDataManager:hasTeam()) then 
        local npcData = self._npcTarget:getNpcData()
        local transdoorType = npcData:getTransdoorType()
        if(transdoorType == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM) then 
            skipWaiting = true
        end
    end

    -- 切换移动
    if(skipWaiting == false) then
        if (not self._target:switchState(FSMState.WAITING)) then

            return false
        end
    end

    -- 通知表现idle 
    local updateAnimationCommand = Command.RendererCommand:create(true)
    updateAnimationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.IDLE)
    self._battleMachine:pushCommand(updateAnimationCommand)
    
    GameManager:notifyRoleFSMChange(self._target:getData())

    -- 通知禁止UI操作处理
    if self._waitingType == WaitingType.WAITING_BACK_TOWN then
        local backTown = ConfigManager:getLocalForKey("backTown")
        local duration = AvalonUtil:getAnimationDuration(backTown.spine, backTown.animation)
        if(duration == 0) then 
            duration = 3.3
        end
        self:setEndTime(duration)

        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initUpdateAnimationCommand(self._target:getId(),CommandAnimationType.BACK_TOWN)
        self:pushRendererCommand(renderCommand)
    elseif self._waitingType == WaitingType.WAITING_NEXT_FLOOF then

    elseif self._waitingType == WaitingType.WAITING_BOSS_SCENARIO_TRIGGER then
    elseif self._waitingType == WaitingType.WAITING_NORMAL then
    elseif self._waitingType == WaitingType.WAITING_TRANSDOOR then
        local backTown = ConfigManager:getLocalForKey("transdoor")
        local duration = AvalonUtil:getAnimationDuration(backTown.spine, backTown.animation)
        if(duration == 0) then 
            duration = 1.5
        end

        self:setEndTime(duration)
    elseif self._waitingType == WaitingType.WAITING_TRANSPOINT then 
        local duration = 0
        if(duration == 0) then 
            duration = 1.5
        end
        local npcData = self._npcTarget:getNpcData()
        local transPointType = npcData:getTransPointType()
        if(transPointType == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then 
            duration = 9999999
        end

        self:setEndTime(duration)
    end

    return true
end

-- 模版函数：action结束
function WaitingStateAction:onEnd()
    if self._waitingType == WaitingType.WAITING_BACK_TOWN then
        -- 处理向服务器发送使用回城卷轴的请求
        GameDataManager:getInstance():setIsShowReward(true)

        Net.NetGoodsSystem:useItemRequest(
            self._data:getGoodsID(),
            self._data:getIsGolden(),
            self._npcTarget:getSpriteID()
        )
    elseif self._waitingType == WaitingType.WAITING_TRANSDOOR then
        if(self._npcTarget:getNpcData()) then 
            local npcData = self._npcTarget:getNpcData()
            local transdoorType = npcData:getTransdoorType()
            if(transdoorType == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_GUILD) then 
                Net.NetGuildSystem:reqEnterGuildScene()
                return 
            end

            if(transdoorType == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_MANOR) then 
                Net.NetManorSystem:reqEnterManorScene(RoleDataManager:getMasterPK())
                return 
            end

            if(transdoorType == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE) then 
                Net.NetRoleSystem:reqEnterHomeScene()
                return 
            end
        else

        end

        Net.NetNPCSystem:openTriggerNpcRequest(self._npcTarget:getSpriteID())
    elseif self._waitingType == WaitingType.WAITING_TRANSPOINT then
        local npcData = self._npcTarget:getNpcData()
        local transPointType = npcData:getTransPointType()
        if(transPointType == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then 
            Net.NetNPCSystem:openTriggerNpcRequest(self._npcTarget:getSpriteID())
        end
        -- Net.NetNPCSystem:openTriggerNpcRequest(self._npcTarget:getSpriteID())
    end
end

function WaitingStateAction:onFail()
    self:handleEnd()
end

function WaitingStateAction:onStop()
    self:handleEnd()
end

function WaitingStateAction:handleEnd()
    if(self._target and self._target:isMaster()) then
        if self._waitingType == WaitingType.WAITING_BACK_TOWN then
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initRoleRemoveBackTown(self._target:getId())
            self:pushRendererCommand(renderCommand)
        end
    end
end

-- 获取状态
function WaitingStateAction:getFSMState()
    return FSMState.WAITING
end

function WaitingStateAction:onUpdate(dt)
    return false
end