--[[
    UI - 选择按钮
]]--

require "app.ui.Component"

UI = UI or {}

local ControlSwitch = class("ControlSwitch", UI.HWBtnComponent)
UI.ControlSwitch = ControlSwitch


-- private:
local DEBUG = false
local DEBUG_DRAW = true

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
function ControlSwitch:ctor()
    ControlSwitch.super.ctor(self, UIType.ControlSwitch, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._select = 1
    self.delayTime = nil
    self.playAudio = true;
    self.audioID = "140";
    self._touchClippedByScrollView = true
end

-- 析构函数
function ControlSwitch:dtor()
    -- print("-------------------ControlSwitch:dtor()")


    if self.delayEventAction and (not tolua.isnull(self.delayEventAction)) then
        self:stopAction(self.delayEventAction)
    end
    if self.mark == true and self.delayTime ~= nil then
        print("self.delayTime",self.delayTime)
        self:dispatchEvent(UIEvent.CONTROL_SWITCH_TOUCH, self._select, self._select)
    end

    ControlSwitch.super.dtor(self)
end

-- public:
-- 初始化
function ControlSwitch:init(maskSprite, thumbSprite, textList,width,height)
    self.maskSprite = maskSprite
    self.thumbSprite = thumbSprite
    self.textList = textList
    self.width = width or 0
    self.height = height or 0

    assert(maskSprite,"ControlSwitch:maskSprite is null")
    assert(thumbSprite,"ControlSwitch:thumbSprite is null")
    for i = 1,#self.textList do
        assert(tolua.type(self.textList[i]) == "cc.Label","textList[%d] must is cc.Label",i);
    end


    ControlSwitch.super.init(self)

    self:setTouchEnable(true)
    self:setSwallowTouches(false)

end




-- 初始化视图
function ControlSwitch:onInitView()

    local width = 0
    local height = 0
    if self.width == 0 or self.height == 0 then
        for i = 1,#self.textList do
            assert(tolua.type(self.textList[i]) == "cc.Label","textList[%d] must is cc.Label",i);
            if self.textList[i]:getContentSize().width > width then
                width = self.textList[i]:getContentSize().width
            end
            if self.textList[i]:getContentSize().height > height then
                height = self.textList[i]:getContentSize().height
            end 
        end
        width = width + 5
    else
        width = self.width/#self.textList
        height = self.height
    end


    if tolua.type(self.maskSprite) == "ccui.Scale9Sprite" then
        self.maskSprite:setContentSize(width * #self.textList,height)
    end
    self.maskSprite:setAnchorPoint(0,0)
    self:addChild(self.maskSprite,-1)


    for i = 1,#self.textList do
        self.textList[i]:setDimensions(width,height)
        self.textList[i]:setAlignment(cc.TEXT_ALIGNMENT_CENTER,cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
        self.textList[i]:setPosition(width * (i - 1) + width/2 , height/2)
        self:addChild(self.textList[i],10)
    end


    self.thumbSprite:setPosition(self.textList[self._select]:getPositionX(),self.textList[self._select]:getPositionY())
    self:addChild(self.thumbSprite,1)

    self:setSize(width * #self.textList,height)

end
-- 适配两个按钮的情况
function ControlSwitch:adapterTowButton()
    if #self.textList == 2 then
        local width = self.width / 3
        local height = self.height
        if not tolua.isnull(self.textList[1]) then
            self.textList[1]:setPosition(width * (1 - 1) + width/2 , height/2)
        end
        if not tolua.isnull(self.textList[2]) then
            self.textList[2]:setPosition(width * (3 - 1) + width/2 , height/2)
        end
       
    end
end
-- 更新视图
function ControlSwitch:onUpdateView()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded)
end


function ControlSwitch:onTouchEnded(obj,touchPosition)
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
function ControlSwitch:setValue(var)
    if var > #self.textList or var < 0 then
        var = #self.textList
    end 
    self._select = var
    if self.thumbSprite and (not tolua.isnull(self.thumbSprite)) then
        self.thumbSprite:setPosition(self.textList[self._select]:getPositionX(),self.textList[self._select]:getPositionY())
    end
end

function ControlSwitch:getValue()
    return self._select
end

-- 设置是否被滚动视图范围遮蔽
function ControlSwitch:setTouchClippedByScrollView(b)
    self._touchClippedByScrollView = b
end

-- 获取是否被滚动视图范围遮蔽
function ControlSwitch:isTouchClippedByScrollView()
    return self._touchClippedByScrollView
end

-- 延迟执行CONTROL_SWITCH_TOUCH事件 delayTime:延迟事件
function ControlSwitch:openDelayEvent(delayTime)
    self.delayTime = delayTime or UI.BUTTON_INTERVAL_TIME/1000
end

-- 是否被滚动视图遮蔽
function ControlSwitch:isWithinScrollViewBound(posX, posY)
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

