-- IndicateUILayer.lua
-- Author:ODEI
-- 2017年12月14日
-- Using:UI指示箭头
-- 修改:
--    2018年2月26 -- 增加样式: 指示圈 by CMonk

require("app.config.ConfigManager")
require("app.game.GameManager")
require("app.game.GameClientMessageManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local MachineManager = require("app.game.MachineManager")
local scheduler = cc.Director:getInstance():getScheduler()

UI = UI or {}

local IndicateUILayer = class("IndicateUILayer", UI.HWBtnComponent)
UI.IndicateUILayer = IndicateUILayer or {}

local winSize = cc.Director:getInstance():getWinSize()

local _WIDTH = winSize.width
local _HEIGHT = winSize.height

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function IndicateUILayer:ctor(target,expressionData,storyStepData, style, isPointingMapTile, isSwallowTouch)
    print("----------IndicateUILayer:ctor()",target,expressionData,storyStepData, isPointingMapTile)
    --窗口大小
    IndicateUILayer.super.ctor(
    self,UIType.INDICATE_UI_LAYER,
    COM_RES_LIST,
    0,    
    0
    )
    self.rootLayer = nil;           --root节点
    self._style = style;
    self._target = target
    self._isPointingMapTile = isPointingMapTile or false
    self.expressionData = expressionData
    self.storyStepData = storyStepData
    self:setTouchEnable(true);
    self:setInterceptTouches(true)
    if (isSwallowTouch ~= nil and tonumber(isSwallowTouch) ~= 1) then
        self:setSwallowTouches(false)
    end

    self._circle = nil
    self._blackBg = nil
    self._hostLayer = nil
    
    self.bClick = false

    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function IndicateUILayer:dtor()
    IndicateUILayer.super.dtor(self)
    self:unRegisterListener()
    self:finishStoryStep()
end

-- 初始化(必备)
function IndicateUILayer:init()
    IndicateUILayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function IndicateUILayer:onInitView()
    print("=========================IndicateUILayer:onInitView()")
    -- 检查目标, 如果目标不存在并且不是指向地砖就直接完成引导返回, 避免出错
    if (tolua.isnull(self._target) and not self._isPointingMapTile) then
        print("=========================IndicateUILayer:onInitView(), target not found!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        self:finishStoryStep()
        -- 这里任何东西都还没显示, 不走closeIndicator直接关闭
        self:close()
        return
    end

    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(_WIDTH,_HEIGHT))
    self.rootLayer:setPosition(cc.p(-_WIDTH/2,-_HEIGHT/2))
    self:addChild(self.rootLayer)
end

-- 模版函数：更新组建的视图(必备)
function IndicateUILayer:onUpdateView()
    if (self._style == nil or self._style == 1) then
        performWithDelay(self, handler(self,self.showCircle), 0.1)
    elseif (self._style == 2) then
        performWithDelay(self, handler(self,self.showArrow), 0.1)
    end
end

function IndicateUILayer:getTargetPosPoint()
    if (self._isPointingMapTile) then
        local view = MachineManager:getInstance():getMachine():getView()
        local map = view:getMap()

        local coordX, coordY = self.expressionData.x, self.expressionData.y
        local coordZ = view:getMapTileCoordZ(coordX, coordY)
        local sx, sy = map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, 0, 0)
        local pos = map:convertToWorldSpace(cc.p(sx,sy))
        return cc.p(pos.x + self.expressionData.posx, pos.y + self.expressionData.posy)
    else
        local worldPos = cc.p(0, 0)
        if (not tolua.isnull(self._target)) then
            local targetSize = self._target:getContentSize()
            local targetBoxHW, targetBoxHH = targetSize.width / 2, targetSize.height / 2
            worldPos = self._target:convertToWorldSpace(cc.p(targetBoxHW + self.expressionData.posx + Avalon.issUtil:getLeftMargin(), targetBoxHH + self.expressionData.posy))
        end
        local parent = self:getParent()
        local localPos = worldPos
        if (parent) then
            localPos = parent:convertToNodeSpace(worldPos)
        end
        localPos.x = localPos.x
        return localPos
    end
end

function IndicateUILayer:showCircle()
    Game.Manager:stopMoveHandler()

    local scale = self.expressionData.scale and self.expressionData.scale/1000 or 1
    local opacity = 188 -- from 255
    
    local bgWidth = _WIDTH * 3
    local bgHeight = _HEIGHT * 3

    -- 制作运载层, 方便移动整个圈圈和背景
    local hostLayer = cc.Layer:create()
    self._hostLayer = hostLayer
    hostLayer:setContentSize(bgWidth, bgHeight)
    hostLayer:setAnchorPoint(0, 0)
    local pos = self:getTargetPosPoint()
    print("IndicateUILayer showing circle at", pos)
    hostLayer:setPosition(pos)

    self.rootLayer:addChild(hostLayer)

    -- 制作测试中心点
    -- local center =  cc.LayerColor:create(cc.c4b(255,0,0,255))
    -- center:setPosition(0, 0)
    -- center:setContentSize(5, 5)
    -- self._hostLayer:addChild(center, 100)

    -- 制作内部渐变圈圈 
    local innerClippingNode = cc.ClippingNode:create()
    self._innerClippingNode = innerClippingNode
    innerClippingNode:setPosition(cc.p(0, 0))
    self._hostLayer:addChild(innerClippingNode, 1)

    local circle = UI.Image:create()
    self._circle = circle;
    circle:init("ui_general_information_mask.png")
    circle:setOpacity(0)
    circle:setScale(scale)
    local rect = circle:getBoundingBox()
    local scaledHW, scaledHH = rect.width / 2, rect.height / 2
    circle:leftBottom(-circle._hw, -circle._hh)
    innerClippingNode:addChild(circle, 1)
    
    local offsetX, offsetY = 0, 0
    local innerStencil = self:drawCircle(offsetX, offsetY, scaledHW)
    innerClippingNode:setStencil(innerStencil)

    -- 制作外部半透明背景
    local outerClippingNode = cc.ClippingNode:create()
    outerClippingNode:setPosition(cc.p(0, 0))
    outerClippingNode:setInverted(true)
    self._hostLayer:addChild(outerClippingNode, 1)

    local outerStencil = self:drawCircle(offsetX, offsetY, scaledHW)
    outerClippingNode:setStencil(outerStencil)

    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,255))
    self._blackBg = blackBg
    blackBg:setContentSize(bgWidth, bgHeight)
    blackBg:setPosition(-bgWidth / 2, -bgHeight / 2)
    outerClippingNode:addChild(blackBg, 1)

    -- 添加呼吸效果
    local oriScale = circle:getScale();
    circle:runAction(cc.RepeatForever:create(cc.Sequence:create(
        cc.ScaleTo:create(0.5, oriScale * 1.2),
        cc.ScaleTo:create(0.5, oriScale + 0.05))))
    
    -- 添加渐入效果
    self:circleBgFadeIn(opacity)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onClickHandler)
    performWithDelay(self, function() 
        self.bClick = true
    end, 1)
end

function IndicateUILayer:circleBgFadeIn(opacity, callback)
    assert(self._blackBg)
    assert(self._circle)

    self._circle:setOpacity(0)
    self._blackBg:setOpacity(0)
    self._blackBg:runAction(cc.FadeTo:create(0.2, opacity))
    self._circle:runAction(cc.Sequence:create(
        cc.FadeTo:create(0.2, opacity),
        cc.CallFunc:create(function() 
            if (callback) then callback() end  
        end)))


    -- 整体缩进出现
    self._hostLayer:setScale(20)
    self._hostLayer:runAction(cc.Sequence:create(
        cc.EaseQuadraticActionInOut:create(cc.ScaleTo:create(0.7, 1)),
        cc.CallFunc:create(function()
            self:finishStoryStep()
        end)
    ))
end

function IndicateUILayer:circleBgFadeOut(callback)
    if (not self._blackBg and not self._circle) then
        if (callback) then callback() end
        return
    end

    self._blackBg:runAction(cc.FadeOut:create(0.2))
    self._circle:runAction(cc.Sequence:create(
        cc.FadeOut:create(0.2),
        cc.CallFunc:create(function() 
            if (callback) then callback() end  
        end)))
end

function IndicateUILayer:drawCircle(x, y, radius)
    local drawnCircle = cc.DrawNode:create()
    drawnCircle:drawSolidCircle(cc.p(x, y), radius, 0, 300, cc.c4b(0,0,0,255))
    drawnCircle:setAnchorPoint(cc.p(0, 0))
    drawnCircle:setPosition(cc.p(0, 0))
    return drawnCircle
end

function IndicateUILayer:showArrow()
    -- 检查目标, 如果目标不存在就直接完成引导返回, 避免出错
    if (not self._target and not self._isPointingMapTile) then
        self:finishStoryStep()
        return
    end
    
    self.bClick = true
    local worldPos = self:getTargetPosPoint()

    -- print("IndicateUILayer:onInitView",worldPos.x, worldPos.y)
    local _arrow = UI.Image:create()
    _arrow:init("ui_information_arrow.png")
    _arrow:leftBottom(worldPos.x, worldPos.y)
    self.rootLayer:addChild(_arrow)
    _arrow:setImageRotation(self.expressionData.rotate)

    _arrow:runAction(
        cc.RepeatForever:create(
            cc.Sequence:create(
                cc.MoveBy:create(0.7, cc.p(math.sin(math.rad(self.expressionData.rotate)) * 20,math.cos(math.rad(self.expressionData.rotate)) * 20)),
                cc.MoveBy:create(0.7, cc.p(-math.sin(math.rad(self.expressionData.rotate)) * 20,math.cos(math.rad(self.expressionData.rotate)) * -20)))))

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onClickHandler)
    self:finishStoryStep()
end


function IndicateUILayer:onClickHandler()
    -- print("IndicateUILayer:onClickHandler")
    if self.bClick then
        self.bClick = false
        self:closeIndicator()
    end
end

function IndicateUILayer:closeIndicator()
    if (self._style == nil or self._style == 1) then
        -- 渐出后关闭自己
        self:circleBgFadeOut(function() self:close() end)
    elseif (self._style == 2) then
        self:close();
    end
end

function IndicateUILayer:finishStoryStep()
    if self.storyStepData and self.storyStepFinished ~= true then
        self.storyStepFinished = true
        Avalon.MessageCenter:notice(AvalonMessage.MC_NOVICE_GUIDE_FINISH, self.storyStepData)
    end
end

-- 注册监听事件(可选)
function IndicateUILayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REMOVE_INDICATE_UI, self, self.closeIndicator)
end


-- 注销监听事件(可选)
function IndicateUILayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REMOVE_INDICATE_UI, self, self.closeIndicator)

end
