-- FullScreenPanel.lua
-- Author:ODEI
-- 2017年7月21日
-- Using:全屏特效层 

require "app.datas.RoleDataManager"
require "app.datas.TeamDataManager"
require "app.ui.fullScreenLayer.CaveShadowLayer"
local SceneManager = require("app.game.SceneManager")
UI = UI or {}

local FullScreenPanel = class("FullScreenPanel", UI.HWBtnComponent)
UI.FullScreenPanel = FullScreenPanel

local DelusionType = PublicDefine.DelusionType
local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {

}


--构造函数(必备)
function FullScreenPanel:ctor(spriteID)
    --窗口大小
    FullScreenPanel.super.ctor(
        self, UIType.FULL_SCREEN,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )

    self:init()
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function FullScreenPanel:dtor()
    FullScreenPanel.super.dtor(self)
    self:unRegisterListener()
    self._fullSpine = nil
end

-- 初始化(必备)
function FullScreenPanel:init()
    FullScreenPanel.super.init(self)

    -- 用于添加战斗过程中的效果
    self._fullSpine = Avalon.Animation:create("effect_ui_gaming_full_screen_confuse.json", "effect_ui_gaming_full_screen_confuse.atlas", 1) 
    self._fullSpine:setPosition(cc.p(winSize.width/2, winSize.height/2))
    self._fullSpine:setScale(ToolsUtil:getAdaptationMaxScale())
    self:addChild(self._fullSpine)
    self._fullSpine:setVisible(false)

    -- self:refreshCaveShadow(true)
    if not SceneManager:getInstance():isInHitRat()
        and not SceneManager:getInstance():isInPuzzle() then
        self._caveShaodwLayer = UI.CaveShadowLayer:create()
        self:addChild(self._caveShaodwLayer)
    end
end

-- 模版函数：初始化组建的视图(必备)
function FullScreenPanel:onInitView()

    
end

-- 模版函数：更新组建的视图
function FullScreenPanel:onUpdateView()
    
end

function FullScreenPanel:onAddFullScreenHandler(data)
    if(data) then
        local animation = self:getChildByName(data[1])
        if(animation == nil) then
            local skeleton = data[1]..".json"
            local atlas = data[1]..".atlas"

            local animation = Avalon.Animation:create(skeleton, atlas, 1, nil, true)
            animation:setName(data[1])
            -- animation:setAnimation(0, "idle", true)
            animation:setPosition(cc.p(winSize.width/2, winSize.height/2))
            animation:setScale(ToolsUtil:getAdaptationMaxScale())
            local loop = true
            if(data[3]) then
                if(tonumber(data[3]) == 1) then
                    loop = true
                else 
                    loop = false
                end 
            end
            animation:setAnimation(0, "idle", loop)
            animation.plotData = data

            if(loop == false) then
                animation:registerSpineEventHandler(function(event)
                    local startPos = string.find(event.animation, "end")
                    if(event.animation == "idle") then 
                        animation:runAction(cc.RemoveSelf:create())
                    end
                end, sp.EventType.ANIMATION_END)
            end

            animation:registerSpineEventHandler(function (event)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- TODO 播放音效文件
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playSound(soundFilename)
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
            end, sp.EventType.ANIMATION_EVENT)

            self:addChild(animation, 1)
        end
    end
end

function FullScreenPanel:onRemoveFullScreenHandler(data)
    if(data) then
        local allChild = self:getChildren()
        if(allChild) then
            for k, child  in pairs(allChild) do  
                if(child.plotData and child.plotData[1] == data[1]) then
                    child:runAction(cc.RemoveSelf:create())
                end
            end
        end
    end
end

function FullScreenPanel:onAtomosphere(delusion)
    if (delusion == DelusionType.DelusionType_Rich or delusion == DelusionType.DelusionType_Insane) then
        self._delusionStatus = true
    else
        self._delusionStatus = false
    end

    self:_refreshFullSpine()
end


function FullScreenPanel:onSpecialEventDeformation(deformation)
    self._deformation = deformation

    self:_refreshFullSpine()

    -- if (delusion == DelusionType.DelusionType_Rich or delusion == DelusionType.DelusionType_Insane) then
    --     self._fullSpine:setAnimation(0, "shade", true)
    --     self._fullSpine:setVisible(true)
    -- else
    --     self._fullSpine:setVisible(false)
    -- end
end

function FullScreenPanel:onDangerousChange(flag) 
    if self._caveShaodwLayer then
        self._caveShaodwLayer:onDangerousChange(flag)
    end
end 

function FullScreenPanel:_refreshFullSpine()
    if (self._delusionStatus or self._deformation) then
        self._fullSpine:setAnimation(0, "shade", true)
        self._fullSpine:setVisible(true)
    else
        self._fullSpine:setVisible(false)
    end
end

-- 注册监听事件(可选)
function FullScreenPanel:registerListener()

    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_FULL_SCREEN_ADD, self, self.onAddFullScreenHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_FULL_SCREEN_REMOVE, self, self.onRemoveFullScreenHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FULL_ATOMOSPHERE, self, self.onAtomosphere)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FULL_SPECIAL_EVENT_DEFORMATION, self, self.onSpecialEventDeformation)
    

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ROLE_HP_DANGEROUS, self, self.onDangerousChange)
end

-- 注销监听事件(可选)
function FullScreenPanel:unRegisterListener()
    -- 添加全屏表现
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_FULL_SCREEN_ADD, self, self.onAddFullScreenHandler)
    -- 移除全屏表现
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_FULL_SCREEN_REMOVE, self, self.onRemoveFullScreenHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FULL_ATOMOSPHERE, self, self.onAtomosphere)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FULL_SPECIAL_EVENT_DEFORMATION, self, self.onSpecialEventDeformation)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ROLE_HP_DANGEROUS, self, self.onDangerousChange)
end
