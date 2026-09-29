--[[
    大门的渲染器
]]

require "app.renderer.Renderer"
local PlotManager = require("app.game.PlotManager")

Renderer = Renderer or {}
local GateNPCRenderer = class("GateNPCRenderer", Renderer.Base)
Renderer.GateNPCRenderer = GateNPCRenderer

-- private:
local DEBUG = true

-- 遍历次视图列表
local function traverseAnimationList(animationList, callback)
    if (animationList and callback) then
        for i, animation in pairs(animationList) do
            callback(animation)
        end
    end
end

-- private:
-- 构造函数
function GateNPCRenderer:ctor()
    GateNPCRenderer.super.ctor(self)

    self._viewList = {}
    -- 大门左边部分
    self._npcAnimationLeft = nil
    -- 大门右边部分
    self._npcAnimationRight = nil
    -- 大门方向（默认是向西边）
    self._npcDirection = DirectionType.WEAST
    -- 类型
    self._npcType = PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE
    -- 配置数据
    self._npcConfigData = nil
end

-- 析构函数
function GateNPCRenderer:dtor()
    GateNPCRenderer.super.dtor(self)

    if (self._npcAnimationLeft) then
        if (self._npcAnimationLeft:getParent()) then
            self._npcAnimationLeft:removeFromParent()
        else
            self._npcAnimationLeft:destroy()
        end
        self._npcAnimationLeft:release()
        self._npcAnimationLeft = nil
    end
    if (self._npcAnimationRight) then
        if (self._npcAnimationRight:getParent()) then
            self._npcAnimationRight:removeFromParent()
        else
            self._npcAnimationRight:destroy()
        end
        self._npcAnimationRight:release()
        self._npcAnimationRight = nil
    end
    self._npcConfigData = nil
end


function GateNPCRenderer:init(configData)
    if (DEBUG) then
        dump(configData)
    end

    self._npcConfigData = configData

    local spine = configData.spine
    if (spine) then
        local leftGateSkeleton = spine.."up.json"
        local leftGateAtlas = spine.."up.atlas"
        self._npcAnimationLeft = Avalon.Animation:create(leftGateSkeleton, leftGateAtlas, 1.0)
        self._npcAnimationLeft:retain()

        local rightGateSkeleton = spine.."down.json"
        local rightGateAtlas = spine.."down.atlas"
        self._npcAnimationRight = Avalon.Animation:create(rightGateSkeleton, rightGateAtlas, 1.0)
        self._npcAnimationRight:retain()

        self._viewList[1] = self._npcAnimationLeft
        self._viewList[2] = self._npcAnimationRight

        self._npcAnimationLeft:registerSpineEventHandler(function(event)
            if string.find(event.eventData.name, "plot_") ~= nil then
                local plotID = string.sub(event.eventData.name,6,-1)
                PlotManager:getInstance():runPlotByID(plotID)
            end
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- TODO 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                end

                local shakePos = string.find(event.eventData.name, "hitshake_")
                if(shakePos ~= nil) then
                    -- 播放抖动
                    local shake = string.sub(event.eventData.name,10,-1)
                    if(shake) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                    end
                end
            end
            if(event and event.eventData and event.eventData.name) then 
                if(event.eventData.name == "trigger_gate_dead_end") then 
                    Avalon.MessageCenter:notice(GameMessage.MC_RENDERER_PLOT_NOTICE, event.eventData.name)
                end
            end
        end,sp.EventType.ANIMATION_EVENT)

        self._npcAnimationRight:registerSpineEventHandler(function(event)
            if string.find(event.eventData.name, "plot_") ~= nil then
                local plotID = string.sub(event.eventData.name,6,-1)
                PlotManager:getInstance():runPlotByID(plotID)
            end
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- TODO 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                end

                local shakePos = string.find(event.eventData.name, "hitshake_")
                if(shakePos ~= nil) then
                    -- 播放抖动
                    local shake = string.sub(event.eventData.name,10,-1)
                    if(shake) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                    end
                end
            end

            if(event and event.eventData and event.eventData.name) then 
                if(event.eventData.name == "trigger_gate_dead_end") then 
                    Avalon.MessageCenter:notice(GameMessage.MC_RENDERER_PLOT_NOTICE, event.eventData.name)
                end
            end
        end,sp.EventType.ANIMATION_EVENT)

        self._npcAnimationLeft:registerSpineEventHandler(function(event)
            if event.animation == "trigger_eye" then
                Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 22)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100304)
            end
        end, sp.EventType.ANIMATION_COMPLETE)
        -- Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)

        self:idle()
    else
        assert(false)
    end
end

-- 关闭
function GateNPCRenderer:idle()
    self._npcAnimationLeft:setAnimation(0, "idle_lock", true)
    self._npcAnimationRight:setAnimation(0, "idle_lock", true)
end

-- 打开
function GateNPCRenderer:showOpenIt(recoverOpen)
    if(recoverOpen) then
        -- 处理boss 5的门处理逻辑
        local PlotManager = require("app.game.PlotManager")
        PlotManager:getInstance():runPlotByID(1050043)
        self._npcAnimationLeft:addAnimation(0, "end", true)
        self._npcAnimationRight:addAnimation(0, "end", true)
    else
        self._npcAnimationLeft:setAnimation(0, "open1", false)
        self._npcAnimationLeft:addAnimation(0, "end", true)
        self._npcAnimationRight:setAnimation(0, "open1", false)
        self._npcAnimationRight:addAnimation(0, "end", true)
    end

end

-- 获取视图
function GateNPCRenderer:getViewList()
    return self._viewList
end

-- 设置方向
function GateNPCRenderer:setDirection(direction)
    self._npcDirection = direction
end

-- 获取大门方向
function GateNPCRenderer:getDirection()
    return self._npcDirection
end

function GateNPCRenderer:onDraw(dt)

end
function GateNPCRenderer:setVisible( visible )
    GateNPCRenderer.super.setVisible(self,visible)

    if self._npcAnimationLeft then
        self._npcAnimationLeft:setVisible(visible)
    end
    if self._npcAnimationRight then
        self._npcAnimationRight:setVisible(visible)
    end
    
    -- print("GateNPCRenderer.setVisible",visible)
end

function GateNPCRenderer:runRoleAnimations(animations)
    if(animations) then 
        for k, v in ipairs(animations) do 
            -- print("GateNPCRenderer:runRoleAnimations", k, v[1], v[2])
            if(k == 1) then 
                if(self._npcAnimationLeft) then
                    self._npcAnimationLeft:setAnimation(0, v[1], v[2])
                end
                if(self._npcAnimationRight) then
                    self._npcAnimationRight:setAnimation(0, v[1], v[2])
                end
            else 
                if(self._npcAnimationLeft) then
                    self._npcAnimationLeft:addAnimation(0, v[1], v[2])
                end
                if(self._npcAnimationRight) then
                    self._npcAnimationRight:addAnimation(0, v[1], v[2])
                end
            end
        end
    end
end

function GateNPCRenderer:pause()
    GateNPCRenderer.super.pause(self)
    if(not tolua.isnull(self._npcAnimationLeft)) then 
        self._npcAnimationLeft:pause()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:pause()
    end
end

function GateNPCRenderer:resume()
    GateNPCRenderer.super.resume(self)
    if(not tolua.isnull(self._npcAnimationLeft)) then 
        self._npcAnimationLeft:resume()
    end
    if(not tolua.isnull(self._npcAnimationRight)) then 
        self._npcAnimationRight:resume()
    end
end