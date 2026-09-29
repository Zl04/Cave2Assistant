
UI = UI or {}
local CustomScrollBar = class("CustomScrollBar", UI.HWBtnComponent)
UI.CustomScrollBar = CustomScrollBar

-- 关卡选择资源
local COM_RES_LIST = {
    [1] = "ui_scrollview_bar.plist",
}

local BarPosType = {
    IN_SCROLL_VIEW = 0,
    OUT_SCROLL_VIEW = 1,
    MIDDLE_SCROLL_VIEW = 2
}

function CustomScrollBar:ctor(scrollView, barImage, posType)
    CustomScrollBar.super.ctor(
        self,UIType.RANKING_PRO_BAR,
        COM_RES_LIST,
        40,
        40
    )
    self.posType = posType or BarPosType.OUT_SCROLL_VIEW
    self._autoHideTime = 0.2
    self.isTouching = false
    self.touchOutSide = false
    self.scrollView = scrollView
    self.barImage = barImage;
    self:init();
    self.scrollView:addChild(self, 100)
    --self:enableDebugDraw()

end

function CustomScrollBar:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- 初始化
function CustomScrollBar:init()
    CustomScrollBar.super.init(self)
end

-- 模版函数：初始化组建的视图
function CustomScrollBar:onInitView()
 
    if self.barImage == nil then
        self.imageNode = self:createDefaultImage()
    else
        self.imageNode = UI.Image:create()
        self.imageNode:init(self.barImage)
    end
    self.imageNode:center()
    self:addChild(self.imageNode)
    self._barHeight = self.scrollView:getContentSize().height - self.imageNode._height
    self.imageNode:setOpacity(0)
    self.startY = (self.imageNode._height - self._height) / 2
    if self.posType == BarPosType.IN_SCROLL_VIEW then
        self:rightUp(-(self._width - self.imageNode._width) / 2, self.startY);
    elseif self.posType == BarPosType.OUT_SCROLL_VIEW then
        self:rightUp(-(self._width + self.imageNode._width) / 2, self.startY);
    elseif self.posType == BarPosType.MIDDLE_SCROLL_VIEW then
        self:rightUp(-self._width / 2, self.startY);
    end

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(_, __, touchPosition)
        self.pressPos = self.scrollView:convertToNodeSpace(touchPosition)
        self.isTouching = true
        self.imageNode:setOpacity(255)
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(_, __,touchPosition)
        local localPosition = self.scrollView:convertToNodeSpace(touchPosition)
        self:scrollToView(localPosition)
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(_, __,touchPosition)
        self.isTouching = false
        self._autoHideRemainingTime = self._autoHideTime
    end)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function CustomScrollBar:createDefaultImage()
    local node = UI.Component:create();
    node:init();

    local blank = 0;

    local bar = UI.Image:create();
    bar:init("ui_default_scrollBar.png")
    bar:leftUp(0, 0)
    node:addChild(bar)
    bar:setImageColor(cc.c3b(41, 41, 45))

    node:setSize(bar._width, bar._height)
    self.bar = bar
    --node:enableDebugDraw()
    return node
end

function CustomScrollBar:scrollToView(localPosition)
    if self.touchOutSide and (localPosition.y < 0 or localPosition.y > self._barHeight) then
        return
    end
    self.touchOutSide = false
    local delte = cc.pSub(localPosition, self.pressPos)
    self.pressPos = localPosition
    local currentYPos = self:getPositionY()
    currentYPos = currentYPos + delte.y
    if currentYPos < self.startY then
        currentYPos = self.startY
        self.touchOutSide = true
    elseif currentYPos > self._barHeight + self.startY then
        currentYPos = self._barHeight + self.startY
        self.touchOutSide = true
    end
    self:setPositionY(currentYPos)
    local per = (self._barHeight - currentYPos + self.startY) / self._barHeight * 100
    self.scrollView:scrollToPercentVertical(per, 0, false)
end

function CustomScrollBar:scrollBar(per)
    if self.isTouching then
        return
    end
    self._autoHideRemainingTime = self._autoHideTime
    local currentYPos = self._barHeight * (1 - per) + self.startY
    self:setPositionY(currentYPos)

end

function CustomScrollBar:update(deltaTime)
    self:processAutoHide(deltaTime);
end
    
function CustomScrollBar:processAutoHide(deltaTime)
    if self.isTouching then
        return;
    end
    if self._autoHideRemainingTime == nil or self._autoHideRemainingTime < 0 then
        return
    end

    self._autoHideRemainingTime = self._autoHideRemainingTime - deltaTime;
    local progress = self._autoHideRemainingTime < 0 and 0 or self._autoHideRemainingTime
    self.imageNode:setOpacity(255 * (progress / self._autoHideTime));
end

function CustomScrollBar:setScrollBarColor(color)
    if self.bar and color then
        self.bar:setImageColor(color)
    end
end