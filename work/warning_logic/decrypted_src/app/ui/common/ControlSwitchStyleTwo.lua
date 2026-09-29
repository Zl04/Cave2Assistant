--[[
    UI - 选择按钮
]]--

require "app.ui.Component"

UI = UI or {}

local ControlSwitchStyleTwo = class("ControlSwitchStyleTwo", UI.HWBtnComponent)
UI.ControlSwitchStyleTwo = ControlSwitchStyleTwo

local SceneManager = require("app.game.SceneManager")

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0

-- 内部使用, 点是否在目标外面
local function isGlobalPointWithinTargetBoundingBox(target, posX, posY)
    local parent = target:getParent() and target:getParent() or target
    local localPos = parent:convertToNodeSpace({x = posX, y = posY})
    local localBox = target:getBoundingBox()
    local minX, maxX = localBox.x, localBox.x + localBox.width
    local minY, maxY = localBox.y, localBox.y + localBox.height
    if (localPos.x < minX or 
        localPos.x > maxX or 
        localPos.y < minY or 
        localPos.y > maxY) 
    then
        return false
    end
    return true
end

-- 构造函数
function ControlSwitchStyleTwo:ctor()
    ControlSwitchStyleTwo.super.ctor(self, UIType.ControlSwitch, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._select = 1
    self.delayTime = nil
    self.playAudio = true;
    self.audioID = "140";
    self._touchClippedByScrollView = true
end

-- 析构函数
function ControlSwitchStyleTwo:dtor()
    -- print("-------------------ControlSwitchStyleTwo:dtor()")


    if self.delayEventAction and (not tolua.isnull(self.delayEventAction)) then
        self:stopAction(self.delayEventAction)
    end
    if self.mark == true and self.delayTime ~= nil then
        print("self.delayTime",self.delayTime)
        self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, self._select)
    end

    ControlSwitchStyleTwo.super.dtor(self)
end

-- public:
-- 初始化
function ControlSwitchStyleTwo:init(maskSprite, thumbSprite, textList, width, height)
    self.maskSprite = maskSprite
    self.thumbSprite = thumbSprite
    self.textList = textList
    self.width = width or 0
    self.height = height or 0

    assert(maskSprite,"ControlSwitchStyleTwo:maskSprite is null")
    assert(thumbSprite,"ControlSwitchStyleTwo:thumbSprite is null")
    for i = 1,#self.textList do
        assert(tolua.type(self.textList[i]) == "cc.Label","textList[%d] must is cc.Label",i);
    end


    ControlSwitchStyleTwo.super.init(self)

    self:setTouchEnable(true)
    self:setSwallowTouches(false)

end


-- 初始化视图
function ControlSwitchStyleTwo:onInitView()
    local width, height = self:getSectionSize()
    self:setSize(width * #self.textList, height)

    -- 背景
    if tolua.type(self.maskSprite) == "ccui.Scale9Sprite" then
        self.maskSprite:setContentSize(width * #self.textList, height)
    end
    local maskSize = self.maskSprite:getContentSize()
    self.maskSprite:setAnchorPoint(0, 0)
    self.maskSprite:setPosition(width / 2, (self._height - maskSize.height) / 2)
    self:addChild(self.maskSprite, -1)

    -- 占位标签, 不可见做占位符使用
    for i = 1, #self.textList do
        local text = self.textList[i]
        text:setVisible(false)
        text:setDimensions(width, height)
        text:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
        text:setPosition(width * (i - 1) + width / 2, height/2)
        self:addChild(text, 10)
    end

    -- 中间按钮
    self.thumbSprite:setPosition(self.textList[self._select]:getPositionX(), height/2)
    self:addChild(self.thumbSprite, 1)

    -- 表现标签, 在条下头
    for i = 1, #self.textList do
        local srcText = self.textList[i]
        local label = UI.Text:create()
        label:init(srcText:getString(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        label:setDimensions(width, height)
        label:setTextAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
        local srcX, srcY = srcText:getPosition()
        label:leftBottom(srcX - label._width / 2, srcY - label._height / 2 - height - 7)
        self:addChild(label, 10)
    end
end

function ControlSwitchStyleTwo:getSectionSize()
    local width = 0
    local height = 0
    if self.width == 0 or self.height == 0 then
        for i = 1, #self.textList do
            assert(tolua.type(self.textList[i]) == "cc.Label","textList[%d] must is cc.Label",i);
            local currentText = self.textList[i]
            if currentText:getContentSize().width > width then
                width = currentText:getContentSize().width
            end
            if currentText:getContentSize().height > height then
                height = currentText:getContentSize().height
            end 
        end
    else
        width = self.width / (#self.textList - 1)
        height = self.height
    end
    return width, height
end

-- 更新视图
function ControlSwitchStyleTwo:onUpdateView()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded)
end


function ControlSwitchStyleTwo:onTouchEnded(obj,touchPosition)
    if SceneManager:getInstance():isInHitRat() then
        return
    end
    local localPosition = self:convertToNodeSpace(touchPosition)

    -- 检查是否结束在自己之外
    if ( not isGlobalPointWithinTargetBoundingBox(self, touchPosition.x, touchPosition.y)) then
        return
    end

    -- 检查是否被滚动视图遮蔽
    if (self._touchClippedByScrollView and 
        not self:isWithinScrollViewBound(touchPosition.x, touchPosition.y)) 
    then
        return
    end

    if #self.textList == 2 then
        local i = self._select + 1
        if i > 2 then
            i = 1
        end 
        self.thumbSprite:stopAllActions()
        self.thumbSprite:runAction(
            cc.Sequence:create(cc.MoveTo:create(0.2,
                cc.p(self.textList[i]:getPositionX(),self.textList[i]:getPositionY())),
                cc.CallFunc:create(function()
                    if i ~= self._select then
                        local oldSelect = self._select
                        self._select = i

                        if self.delayTime == nil or self.delayTime == 0 then
                            self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, oldSelect)
                        else
                            if self.delayEventAction and (not tolua.isnull(self.delayEventAction)) then
                                self:stopAction(self.delayEventAction)
                            end
                            self.mark = true
                            self.delayEventAction = performWithDelay(self, function()
                                self.mark = false
                                self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, oldSelect)
                            end, self.delayTime)
                        end
                    end
            end)))

    else

        for i = 1,#self.textList do
            local rect = cc.rect(self.textList[i]:getPositionX() - self.textList[i]:getContentSize().width/2,
                self.textList[i]:getPositionY() - self.textList[i]:getContentSize().height/2,
                self.textList[i]:getContentSize().width,
                self.textList[i]:getContentSize().height)

            if cc.rectContainsPoint(rect, localPosition) then
                self.thumbSprite:stopAllActions()
                self.thumbSprite:runAction(
                    cc.Sequence:create(cc.MoveTo:create(0.2,
                        cc.p(self.textList[i]:getPositionX(),self.textList[i]:getPositionY())),
                    cc.CallFunc:create(function()
                        if i ~= self._select then
                            self._select = i

                            if self.delayTime == nil or self.delayTime == 0 then
                                self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, oldSelect)
                            else
                                if self.delayEventAction and (not tolua.isnull(self.delayEventAction)) then
                                    self:stopAction(self.delayEventAction)
                                end
                                self.mark = true
                                self.delayEventAction = performWithDelay(self, function()
                                    self.mark = false
                                    self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, oldSelect)
                                end, self.delayTime)
                            end
                        end
                    end)))
                return
            end
        end
    end
end

--设置
function ControlSwitchStyleTwo:setValue(var)
    if var > #self.textList or var < 0 then
        var = #self.textList
    end 
    self._select = var
    if self.thumbSprite and (not tolua.isnull(self.thumbSprite)) then
        self.thumbSprite:setPosition(self.textList[self._select]:getPositionX(),self.textList[self._select]:getPositionY())
    end
end

function ControlSwitchStyleTwo:getValue()
    return self._select
end

-- 设置是否被滚动视图范围遮蔽
function ControlSwitchStyleTwo:setTouchClippedByScrollView(b)
    self._touchClippedByScrollView = b
end

-- 获取是否被滚动视图范围遮蔽
function ControlSwitchStyleTwo:isTouchClippedByScrollView()
    return self._touchClippedByScrollView
end

-- 延迟执行CONTROL_SWITCH_TOUCH事件 delayTime:延迟事件
function ControlSwitchStyleTwo:openDelayEvent(delayTime)
    self.delayTime = delayTime or UI.BUTTON_INTERVAL_TIME/1000
end

-- 是否被滚动视图遮蔽
function ControlSwitchStyleTwo:isWithinScrollViewBound(posX, posY)
    local parent = self:getParent()
    while (parent) do
        if (parent.getType and 
            parent:getType() == UIType.SCROLL_VIEW and 
            not isGlobalPointWithinTargetBoundingBox(parent, posX, posY)) 
        then
            return false
        end
        parent = parent:getParent()
    end
    return true
end

