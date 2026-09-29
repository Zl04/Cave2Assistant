-- BannerLayer.lua
-- Author:ydli
-- 2017年10月23日
-- Using:邮箱滑动banner 设计思路：初始化三个 banner，默认裁剪展示中间一个，左右滑动刷新 

UI = UI or {}
local BannerLayer = class("BannerLayer", UI.HWBtnComponent)
UI.BannerLayer = BannerLayer
require "app.ui.mail.BannerCursor"

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(660, 164)
local scheduler = cc.Director:getInstance():getScheduler()
-- 背包资源
local COM_RES_LIST = {
}
local DEFAULTINDEX = 1
function BannerLayer:ctor()
    BannerLayer.super.ctor(self, UIType.BANNER_LAYER, COM_RES_LIST, layerSize.width, layerSize.height)
    self.updateCellHandler = nil
    self.clickCellHandler = nil
    self.Index = DEFAULTINDEX
    self.sizeNumber = 1
    self.bannerNodes = {}
    self.selectLight = {}

    self.lastTouchPoint = nil
    self.beginTouchPoint = nil
    self.ActionLock = false
    self.schedulerID = nil
    self.touchMoveDis = 0 --手动滑动的距离
end

function BannerLayer:dtor()
    BannerLayer.super.dtor(self)
    -- self:setInterceptTouches(false)
    self:unRegisterListener()
    self.updateCellHandler = nil
    self.clickCellHandler = nil
    self.Index = DEFAULTINDEX
    self.sizeNumber = 1
    self.bannerNodes = {}

    self.lastTouchPoint = nil
    self.beginTouchPoint = nil
    self.ActionLock = false
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function BannerLayer:init(sizeNumber, cellWidth, cellHeight, updateCellHandler, clickCellHandler, bannerList)
    layerSize.width = cellWidth
    layerSize.height = cellHeight

    self.bannerList = bannerList
    self.sizeNumber = sizeNumber
    BannerLayer.super.init(self)
    self.updateCellHandler = updateCellHandler
    self.clickCellHandler = clickCellHandler
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.autoPageTurnCallback), 5, false)
end

function BannerLayer:onInitView()
    self.rootLayer = UI.TouchLayout:create()
    self.rootLayer:init(0, 0, 0, 0)
    self.rootLayer:setSize(layerSize.width * (self.sizeNumber * 2 + 1), layerSize.height)
    self.rootLayer:leftBottom(-layerSize.width * (self.sizeNumber + 1), 0)
    local beginPosX = (layerSize.width - self.sizeNumber * 44) / 2
    if self.sizeNumber > 1 then
        for i = 1, self.sizeNumber do 
            local onLight = UI.BannerCursor:create("ui_mailbox_schedule1.png", "ui_mailbox_schedule1.png", "ui_mailbox_schedule2.png")
            onLight:leftBottom(beginPosX + 44 * (i - 1), 10)
            self:addChild(onLight, 30)
            table.insert(self.selectLight, onLight)
        end
    end
    for i = 1, 3 do 
        local bannerNode = UI.Layout:create()
        bannerNode:init(0,0,0,0)
        bannerNode:setSize(layerSize.width, layerSize.height)
        bannerNode:leftBottom((i - 1 + self.sizeNumber) * layerSize.width, 0)
        self.rootLayer:addChild(bannerNode)
        table.insert(self.bannerNodes, bannerNode)
    end
    self.leftNode = self.bannerNodes[1]
    self.middleNode = self.bannerNodes[2]
    self.rightNode = self.bannerNodes[3]

    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0,0,0,200))
    _ckipperSprite:setContentSize(layerSize.width, layerSize.height)
    local _clipper = cc.ClippingNode:create(_ckipperSprite)
    _clipper:setPosition(0, 0)
    _clipper:setAlphaThreshold(1.0)

    _clipper:addChild(self.rootLayer)
    self.clipper = _clipper
    self:addChild(_clipper)
    self.rootLayer:addTouchEvents(self)

    local leftButton = UI.Button:create()
    leftButton:init("ui_btn_activity_0.png","ui_btn_activity_1.png","ui_btn_activity_0.png")
    leftButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:pageTurnCallback(false)
        local bannerData = self.bannerList[self.Index]
        local bannerID = 0
        if(bannerData) then 
            bannerID = bannerData.id
        end
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Mailbanner, 2, bannerID)
    end)
    leftButton:centerLeft(15)
    self:addChild(leftButton, 30)

    local rightButton = UI.Button:create()
    rightButton:init("ui_btn_activity_0.png","ui_btn_activity_1.png","ui_btn_activity_0.png")
    rightButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:pageTurnCallback(true)
        local bannerData = self.bannerList[self.Index]
        local bannerID = 0
        if(bannerData) then 
            bannerID = bannerData.id
        end
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Mailbanner, 2, bannerID)
    end)
    rightButton:setScaleX(-1)
    rightButton:centerRight(10)
    self:addChild(rightButton, 30)
end

function BannerLayer:onUpdateView()
    if self.updateCellHandler and self.sizeNumber > 0 then
        self.updateCellHandler(self.Index, self.middleNode, self.leftNode, self.rightNode)
        self:refreshLight(self.Index)
    end
end

-- 注册监听事件(可选)
function BannerLayer:registerListener()
end

function BannerLayer:onTouchDialogOutsizeHandler()

end

-- 注销监听事件(可选)
function BannerLayer:unRegisterListener()

end

function BannerLayer:onTouchBegan(touch, event)
    if self.ActionLock then
        return
    end
    local point  = self:convertToWorldSpace(cc.p(0,0))
    local size = self:getContentSize()
    local rect = cc.rect(point.x , point.y , size.width, size.height) 
    if cc.rectContainsPoint(rect, touch:getLocation()) then
        self.lastTouchPoint = touch:getLocation()
        self.beginTouchPoint = touch:getLocation()
    end
end

function BannerLayer:onTouchMoved(touch, event)
    if self.sizeNumber <= 1 then
        return
    end
    if self.ActionLock then
        return
    end
    local point = touch:getLocation()
    local worldPoint  = self:convertToWorldSpace(cc.p(0,0))
    local size = self:getContentSize()
    local rect = cc.rect(worldPoint.x , worldPoint.y , size.width, size.height) 
    if not cc.rectContainsPoint(rect, point) then
        return
    end
    if self.lastTouchPoint == nil or self.beginTouchPoint == nil then
        self.lastTouchPoint = point
        self.beginTouchPoint = point
        return
    end
    --滑动太长判断
    if math.abs(self.beginTouchPoint.x - point.x) >= layerSize.width then
        return 
    end
    local moveX = point.x - self.lastTouchPoint.x
    self.rootLayer:setPositionX(self.rootLayer:getPositionX() + moveX)
    self.lastTouchPoint = point
    self.touchMoveDis = self.touchMoveDis + moveX
end

function BannerLayer:onTouchEnded(touch, event)
    if self.ActionLock then
        return
    end
    if self.lastTouchPoint == nil or self.beginTouchPoint == nil then
        return
    end
    self:checkAllCell()

    local endTouchPoint = nil
    local worldPoint  = self:convertToWorldSpace(cc.p(0,0))
    local size = self:getContentSize()
    local rect = cc.rect(worldPoint.x , worldPoint.y , size.width, size.height) 
    if cc.rectContainsPoint(rect, touch:getLocation()) then
        endTouchPoint = touch:getLocation()
    end
    if endTouchPoint ~= nil and (endTouchPoint.x - self.beginTouchPoint.x)*(endTouchPoint.x - self.beginTouchPoint.x) + 
    (endTouchPoint.y - self.beginTouchPoint.y)*(endTouchPoint.y - self.beginTouchPoint.y) < 25 and self.clickCellHandler ~= nil then
        self.clickCellHandler(self.Index)
    end
    self.lastTouchPoint = nil
    self.beginTouchPoint = nil
    self.touchMoveDis = 0
end

function BannerLayer:checkAllCell()
    if self.sizeNumber <= 1 then
        return
    end
    local oldIndex = self.Index
    local target = self.middleNode
    -- local posX = target:getPositionX() 
    local cellPoint = target:convertToWorldSpace(cc.p(0,0))
    local clipperPoint = self.clipper:convertToWorldSpace(cc.p(0,0))
    if cellPoint.x <= clipperPoint.x - layerSize.width / 5 then
        self.Index = self.Index + 1
    elseif cellPoint.x >= clipperPoint.x + layerSize.width / 5 then
        self.Index = self.Index - 1
    end

    self.Index = self.Index % self.sizeNumber
    if self.Index == 0 then
       self.Index = self.sizeNumber
    end

    if self.Index ~= oldIndex then
       local moveDis = cellPoint.x - clipperPoint.x
        if moveDis < 0 then
            moveDis = -layerSize.width - moveDis
        else
            moveDis = layerSize.width - moveDis
        end
        self:moveAllCell(moveDis, 0.1)
    else
        local moveDis = cellPoint.x - clipperPoint.x
        local moveBy = cc.EaseInOut:create(cc.MoveBy:create(0.1,cc.p(-moveDis, 0)), 1)
        self.rootLayer:runAction(cc.Sequence:create(moveBy,cc.CallFunc:create(function()
        end)))
    end
end

function BannerLayer:moveAllCell(moveDis, moveTime)
    local moveBy = cc.EaseInOut:create(cc.MoveBy:create(moveTime,cc.p(moveDis,0)), 1)
    self.ActionLock = true
    self.rootLayer:runAction(cc.Sequence:create(moveBy,cc.CallFunc:create(function()
        if DEFAULTINDEX == self.Index then
            self.rootLayer:leftBottom(-layerSize.width * (self.sizeNumber + 1), 0)
            for k, v in ipairs(self.bannerNodes) do
                v:leftBottom((k - 1 + self.sizeNumber) * layerSize.width, 0)
            end
            self.leftNode = self.bannerNodes[1]
            self.middleNode = self.bannerNodes[2]
            self.rightNode = self.bannerNodes[3]
            self.updateCellHandler(self.Index, self.middleNode, self.leftNode, self.rightNode)
            self:refreshLight(self.Index)
        else
            if moveDis < 0 then
                self.leftNode:leftBottom(self.rightNode:getLeft() + layerSize.width, self.leftNode:getBottom())
                local temp = self.leftNode
                self.leftNode = self.middleNode
                self.middleNode = self.rightNode
                self.rightNode = temp
                self.updateCellHandler(self.Index, self.middleNode, self.leftNode, self.rightNode)
                self:refreshLight(self.Index)
            else
                self.rightNode:leftBottom(self.leftNode:getLeft() - layerSize.width, self.rightNode:getBottom())
                local temp = self.rightNode
                self.rightNode = self.middleNode
                self.middleNode = self.leftNode
                self.leftNode = temp
                self.updateCellHandler(self.Index, self.middleNode, self.leftNode, self.rightNode)
                self:refreshLight(self.Index)
            end
        end
        self.ActionLock = false
    end)))
end

function BannerLayer:refreshLight(Index)
    if self.selectLight == nil or #self.selectLight == 0 then
        return
    end
    for k, v in ipairs(self.selectLight) do 
        if k == Index then
            v:runCursorAct()
        else
            v:removeCursorAct()
        end
    end
end

function BannerLayer:autoPageTurnCallback()
    self:pageTurnCallback(true)
end

function BannerLayer:pageTurnCallback(isReverse)
    -- dump(table.remove, "table.remove")
    if self.sizeNumber <= 1 then
        return
    end
    if self.ActionLock then
        return
    end
    local moveDis = 0 --判断当前如果 有偏移 要处理
    if isReverse then
        self.Index = self.Index + 1
        moveDis = layerSize.width * -1 - self.touchMoveDis
    else
        self.Index = self.Index - 1
        moveDis = layerSize.width - self.touchMoveDis
    end
    self.Index = self.Index % self.sizeNumber
    if self.Index == 0 then
       self.Index = self.sizeNumber
    end
    self:moveAllCell(moveDis, 0.15)
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.autoPageTurnCallback), 5, false)
    self.touchMoveDis = 0
end
