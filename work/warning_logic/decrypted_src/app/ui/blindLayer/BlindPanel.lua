--[[
    处理致盲层级
]]--

require "app.ui.Component"
local MachineManager = require("app.game.MachineManager")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local DEBUG = false

UI = UI or {}

local BlindLayer = class("BlindLayer", UI.HWBtnComponent)
UI.BlindLayer = BlindLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler

-- 构造函数
function BlindLayer:ctor()
    BlindLayer.super.ctor(self, UIType.BLIND)

    self._isBlind = false
    self._blindAnimation = nil

    self._willRemoveBlind = false
    self._waitingNum = 0

    self._denseFlog = false
    self._serverBlind = false

    self._preBlind = false

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_BLIND_CHANGE_DENSE_FOG, self, self.denseFlogBlindChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_BLIND_CHANGE, self, self.blindChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_MOVE_HALF, self, self.moveHalf)

    Avalon.Scheduler:scheduleUpdate(self, self.delayRemove)
end

function BlindLayer:dtor()
    self._blindAnimation = nil
    
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_BLIND_CHANGE_DENSE_FOG, self, self.denseFlogBlindChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_BLIND_CHANGE, self, self.blindChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_MOVE_HALF, self, self.moveHalf)

    Avalon.Scheduler:unscheduleUpdate(self, self.delayRemove)
end

function BlindLayer:moveHalf()
    -- print("BlindLayer:moveHalf ")
    self._willRemoveBlind = true
    self._waitingNum = 0
end

function BlindLayer:delayRemove(dt)
    self._waitingNum = self._waitingNum + 1
    if(self._waitingNum >=2) then
        if(self._willRemoveBlind) then
            self:denseFlogBlindChange(false)
            self._willRemoveBlind = false
        end
    end
end

function BlindLayer:denseFlogBlindChange(isBlind)
    if DEBUG then
        print("BlindLayer:denseFlogBlindChange", isBlind, AvalonUtil.getCurrentTime())
    end
    self._denseFlog = isBlind

    if(isBlind) then
        self._willRemoveBlind = false
    end

    self:triggerBlind()
end

function BlindLayer:blindChange(isBlind)
    -- print("BlindLayer:blindChange", isBlind, AvalonUtil.getCurrentTime())
    self._serverBlind = isBlind

    self:triggerBlind()
    -- -- print("BlindLayer:blindChange ", isBlind, self._isBlind)
    -- -- print(debug.traceback())
    -- if(isBlind ~= self._isBlind) then
    --     -- 切换表现
    --     self:refresh(self._isBlind, isBlind)
    --     self._isBlind = isBlind
    -- end
    -- if(isBlind) then
    --     self._willRemoveBlind = false
    -- end
end

function BlindLayer:triggerBlind()
    local nowBlind = false
    if(self._serverBlind or self._denseFlog) then
        nowBlind = true
    else 
        nowBlind = false
    end

    self:refresh(self._preBlind, nowBlind)
end

-- public:
-- 初始化
function BlindLayer:init()
    if DEBUG then
        print("====BlindLayer:init====")
    end

    BlindLayer.super.init(self)
end

local animationInfo = {
    {"effect_role_npc_trap_fog_vision", "begin", "end","idle1"},
    {"role_npc_trap_fog_vision", "begin_hitrat", "end_hitrat","idle_hitrat"},
}

-- 初始化组件视图
function BlindLayer:initView(data)
    self._isBlind = GameDataManager:getInstance():getMaster():getIsBlind()
    self._serverBlind = self._isBlind

    self.animationInfos = animationInfo[1]
    if SceneManager:getInstance():isInHitRat() or SceneManager:getInstance():isInPuzzle() then
        self.animationInfos = animationInfo[2]
    end

    self._blindAnimation  = Avalon.Animation:create(self.animationInfos[1]..".json", self.animationInfos[1]..".atlas", 1);
    self._blindAnimation:setScaleY(1.1)
    self._blindAnimation:setVisible(false)
    self:addChild(self._blindAnimation )

    self:refresh(false, self._isBlind)

    self._blindAnimation:registerSpineEventHandler(function(event)
        if (event.animation == self.animationInfos[3]) then
            self._blindAnimation:setVisible(false)
        elseif (event.animation == self.animationInfos[2]) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_MAP_SET_IS_CAVE_SHADOW_SHOW, false)
        end
    end, sp.EventType.ANIMATION_END)

    -- CO-15671【地图】快速进出迷雾会使地图变亮
    self._blindAnimation:registerSpineEventHandler(function(event)
        if (event.animation == self.animationInfos[3]) then
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if not tolua.isnull(self) then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_MAP_SET_IS_CAVE_SHADOW_SHOW, true)
                end
            end, 0.1)
        end
    end, sp.EventType.ANIMATION_START)
end

-- 刷新表现
function BlindLayer:refresh(preStatus, nowStatus)
    if DEBUG then
        print("BlindLayer:refresh ", preStatus,nowStatus)
    end
    if(preStatus ~= nowStatus) then
        self._preBlind = nowStatus
        if(preStatus == false) then
            -- 开始播放
            self._blindAnimation:setAnimation(0, self.animationInfos[2],false)
            self._blindAnimation:addAnimation(0, self.animationInfos[4], true)
            self._blindAnimation:setVisible(true)
        else
            -- 消失效果播放
            self._blindAnimation:setAnimation(0, self.animationInfos[3],false)
        end
    end
end