-- TopFullScreenPanel.lua
-- Author:ODEI
-- 2018年2月9日
-- Using:顶层全屏特效层 

require "app.datas.RoleDataManager"
require "app.datas.TeamDataManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local TopFullScreenPanel = class("TopFullScreenPanel", UI.HWBtnComponent)
UI.TopFullScreenPanel = TopFullScreenPanel


local DelusionType = PublicDefine.DelusionType

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function TopFullScreenPanel:ctor(spriteID)
    --窗口大小
    TopFullScreenPanel.super.ctor(
        self, UIType.FULL_SCREEN,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )

    self._fullSpine = nil

    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function TopFullScreenPanel:dtor()
    TopFullScreenPanel.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function TopFullScreenPanel:init()
    TopFullScreenPanel.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function TopFullScreenPanel:onInitView()

end

-- 模版函数：更新组建的视图
function TopFullScreenPanel:onUpdateView()
    
end

function TopFullScreenPanel:onAddFullScreenHandler(data)
    if(data) then
        local animation = self:getChildByName(data[1])
        if(animation == nil) then
            local skeleton = data[1]..".json"
            local atlas = data[1]..".atlas"

            local animation = Avalon.Animation:create(skeleton, atlas, 1, nil, true);
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

function TopFullScreenPanel:onRemoveFullScreenHandler(data)
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

-- 注册监听事件(可选)
function TopFullScreenPanel:registerListener()

    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_ADD, self, self.onAddFullScreenHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_REMOVE, self, self.onRemoveFullScreenHandler)
end

-- 注销监听事件(可选)
function TopFullScreenPanel:unRegisterListener()
    -- 添加全屏表现
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_ADD, self, self.onAddFullScreenHandler)
    -- 移除全屏表现
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_REMOVE, self, self.onRemoveFullScreenHandler)
end
