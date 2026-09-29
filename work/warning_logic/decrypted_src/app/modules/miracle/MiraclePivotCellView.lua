------------------------------------------------------------------------------
--author: ping.zhengping
--date	: 2020/12/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MiraclePivotCellView = class("MiraclePivotCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 112
local COM_HEIGHT = 402

-- local maxSpeed = 1500
-- local basSpeed = 400
-- local oneDt = 0.029
-- local speedAcceleration = 1.028
-- local speedAcceleration = 1.011
-- local intervalTime = 0.4

function MiraclePivotCellView:ctor()
    MiraclePivotCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.isRunning = false
    self.isStoping = false
    self._nowSpeed = 0
    self._speedMoveDis = 0

    -- self.moveDisArr = {}
    -- local startK = 20
    -- local speed = speedAcceleration
    -- local acc = speedAcceleration - 1
    -- for k=1,1000,1 do 
    --     local nowSpeed = basSpeed * speed
    --     if(nowSpeed < maxSpeed) then 
    --         table.insert(self.moveDisArr, math.floor(nowSpeed * oneDt))
    --         if(k<startK) then
    --             speed = speed * (speedAcceleration)
    --         else
    --             speed = speed * (speedAcceleration + acc*3)
    --         end
    --     else
    --         print("k=",k)
    --         break 
    --     end
    -- end

end

function MiraclePivotCellView:init(moveDisArr, ... )
    self.moveDisArr = moveDisArr
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.miracle", "Miracle", false)
    MiraclePivotCellView.super.init(self, data, ... )
end

function MiraclePivotCellView:dtor()
    MiraclePivotCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.miracle.MiraclePivotCellView")
end


function MiraclePivotCellView:onInitView()
    local prayerIconArr = ConfigManager:getAllMiraclePrayerIcon()
    local oneHeight = 108
    local totalHeight = oneHeight * #prayerIconArr
    local halfHeight = totalHeight/2

    self.totalHeight = totalHeight
    self.halfHeight = halfHeight
    self.oneHeight = oneHeight

    -- self:enableDebugDraw()

    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:center()
    -- self:addChild(centerLayout)

    local _ckipperSprite = cc.Sprite:createWithSpriteFrameName("ui_prayer_black.png")
    local _clipper = cc.ClippingNode:create(_ckipperSprite)
    _clipper:setPosition(COM_WIDTH/2,COM_HEIGHT/2)
    _clipper:setAlphaThreshold(0.05)
    _clipper:addChild(centerLayout,20)

    self:addChild(_clipper)

    if(self.paomaAnimation == nil) then
        local paomaAnimation = Avalon.Animation:create("effect_ui_town_prayer_paoma.json", "effect_ui_town_prayer_paoma.atlas", 1)
        paomaAnimation:setAnimation(0, "idle", true)
        paomaAnimation:setPosition(0, 0)
        centerLayout:addChild(paomaAnimation,2)
        paomaAnimation:setVisible(false)
        self.paomaAnimation = paomaAnimation
    end

    local startY = -2*oneHeight
    self._nodeArr = {}
    prayerIconArr = ToolsUtil:tableRandom(prayerIconArr)

    for k,v in ipairs(prayerIconArr) do 
        local oneNode = UI.Layout:create()
        oneNode:init()
        oneNode:centerBottom(startY)
        centerLayout:addChild(oneNode)
        oneNode.data = v

        local kuang = UI.Image:create()
        kuang:init("ui_prayer_box.png")
        kuang:center()
        oneNode:addChild(kuang)

        local icon = UI.Image:create()
        icon:init(v.icon)
        icon:center()
        kuang:addChild(icon)

        startY = startY + oneHeight
        table.insert(self._nodeArr, oneNode)
    end
end

function MiraclePivotCellView:start(startEndCallBack)
    self.isRunning = true
    self._nowSpeed = 0
    self._speedTck = 0
    self._speedMoveDis = 0
    -- self._basSpeed = basSpeed
    self._startEndCallBack = startEndCallBack
end

function MiraclePivotCellView:stop(stopID, stopEndCallBack)
    self.isStoping = true
    self._stopEndCallBack = stopEndCallBack
    local startY = 0
    for k, node in ipairs(self._nodeArr) do
        if(node.data.ID == stopID) then 
            break
        else
            startY = startY - self.oneHeight
        end
    end
    startY = startY + self._speedMoveDis

    for k, node in ipairs(self._nodeArr) do
        startY = self:calculationBottomY(startY)
        node:centerBottom(startY)
        startY = startY + self.oneHeight
    end
end

function MiraclePivotCellView:calculationBottomY(bottom)
    while (bottom < -self.halfHeight) do
        bottom = bottom + self.totalHeight
    end
    while (bottom > self.halfHeight) do
        bottom = bottom - self.totalHeight
    end

    return bottom
end

function MiraclePivotCellView:update(dt)
    if(self.isRunning) then 
        if(self.isStoping) then
            if(self._speedTck == math.floor(#self.moveDisArr*2/3)) then
                self.paomaAnimation:setVisible(false)
            end
            for k, node in ipairs(self._nodeArr) do 
                local bottom = node:getBottom()
                bottom = bottom - self._nowSpeed
                bottom = self:calculationBottomY(bottom)
                node:centerBottom(bottom)
            end
            self._speedMoveDis = self._speedMoveDis - self._nowSpeed
            self._speedTck = self._speedTck - 1
            if(self.moveDisArr[self._speedTck]) then
                self._nowSpeed = self.moveDisArr[self._speedTck]
            end
            if(self._speedTck == 0) then
                self.isRunning = false
                self.isStoping = false
                if(self._stopEndCallBack) then 
                    self:_stopEndCallBack()
                end
            end
        else
            if(self._speedTck == math.floor(#self.moveDisArr/3)) then
                self.paomaAnimation:setVisible(true)
            end
            if(self.moveDisArr[self._speedTck + 1] ~= nil) then
                self._speedTck = self._speedTck + 1
                self._nowSpeed = self.moveDisArr[self._speedTck]
                self._speedMoveDis = self._speedMoveDis + self._nowSpeed
            else
                if(self._startEndCallBack) then
                    self:_startEndCallBack() 
                end
            end
            for k, node in ipairs(self._nodeArr) do 
                local bottom = node:getBottom()
                bottom = bottom - self._nowSpeed
                bottom = self:calculationBottomY(bottom)
                node:centerBottom(bottom)
            end
        end
    end
end

function MiraclePivotCellView:bindModel()
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end


function MiraclePivotCellView:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end


function MiraclePivotCellView:handleDelay(node, delayTime, callBack) 
    if(node and delayTime and callBack) then
        local delayAction = cc.DelayTime:create(delayTime)
        node:runAction(cc.Sequence:create(delayAction, cc.CallFunc:create(function()
            if(callBack) then 
                callBack()
            end
        end)))
    end
end


return MiraclePivotCellView