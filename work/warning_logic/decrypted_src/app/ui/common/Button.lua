--[[
    UI - 按钮
]]--

require "app.ui.Component"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local Button = class("Button", UI.HWBtnComponent)
UI.Button = Button
local scheduler = cc.Director:getInstance():getScheduler()

-- 按钮的状态
UI.ButtonState = {
    NORMAL = 1,   -- 正常
    ACTIVE = 2,   -- 点击
    RELEASE = 3,  -- 释放
    DISABLE = 4   -- 不可用状态
}
ButtonState = UI.ButtonState

-- 按钮图片显示的基线
UI.ButtonBaseLine = {
    CENTER = 1,  -- 居中显示
    BOTTOM = 2,  -- 以底边为基线
    TOP = 3,     -- 以顶边为基线
    LEFT = 4,    -- 以左边为基线
    RIGHT = 5    -- 以右边为基线
}
ButtonBaseLine = UI.ButtonBaseLine

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 背包资源
local COM_RES_LIST = nil
-- 按钮中的子对象z序
local BUTTON_SPRITE_ZORDER = 1
local BUTTON_TITLE_ZORDER = 3

-- 构造函数
function Button:ctor(comType)
    local comType = comType or UIType.BUTTON
    Button.super.ctor(self, comType, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    -- 格子状态
    self._state = ButtonState.NORMAL
    -- 按钮图片
    self._sprite = nil
    -- 文字
    self._text = nil
    self._textOffset = cc.p(0, 0)
    -- 图片名字
    self._normal = nil
    self._active = nil
    self._disable = nil

    self._normalNode = nil
    self._activeNode = nil
    self._disableNode = nil

    self.originalScaleX = 1;
    self.originalScaleY = 1;
    self.zoomActionTag = 9527;
    -- 点击间隔
    self._interval = 0;
    self._lastTouchTime = 0;
    self._clickScale = false

    -- 显示基线
    self._baseline = UI.ButtonBaseLine.CENTER

    self:openClickScale();

    self.playAudio = true;
    self.audioID = "1503";
    self._delayTime = 0
    self._schedulerID = nil

    self.reflectButtonIcon = nil
    self.reflectButtonClickIcon = nil
    self.reflectButtonDisableIcon = nil
    self._textStr = ""
    self._languageId = -1
    self._fontSize = UI.FONT_SIZE_16PX
    self._fontColor = {r = 255, g = 255, b = 255}
    self._outlineColor = {r = 0, g = 0, b = 0}
    self._outlineSize = 0
    self._shadowColor = cc.c4b(0, 0, 0, 255)
    self._shadowOffset = cc.size(-1, -2)
    self._fontName = UI.FONT_STANDARD
    self._fontNameReflect = "UI.FONT_STANDARD"
    self._textWidth = 0
    self._showUnderLine = false

    self._keepActivated = false

    self.choiced = false
end

-- 析构函数
function Button:dtor()
    self._sprite = nil
    self._text = nil
    self._normal = nil
    self._active = nil
    self._disable = nil

    self._normalNode = nil
    self._activeNode = nil
    self._disableNode = nil
    self._delayTime = 0
    if self._schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self._schedulerID)
        self._schedulerID = nil
    end
    Button.super.dtor(self)
end

-- public:
-- 初始化
function Button:init(normal, active, disable, offset, bgDisplayScale)
    self._normal = normal
    self._active = active
    self._disable = disable
    self._textOffset = offset or cc.p(0, 0)
    self._bgDisplayScale = bgDisplayScale or 1

    Button.super.init(self)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, button, touchPosition)
        self:press()
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, button, touchPosition)
        self:onTouchMove(touchPosition)
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, button, touchPosition)
        if (not self._keepActivated) then
            self:release()
        end
    end)
    local function onTouch(self, button, touchPosition)   
        if self.clickCallback then
            self:clickCallback(touchPosition)
        end
        if self._delayTime ~=nil and self._delayTime ~= 0 then
            if self._schedulerID ~= nil then
                scheduler:unscheduleScriptEntry(self._schedulerID)
            end
            self._schedulerID = scheduler:scheduleScriptFunc(handler(self,self.delayCallback), self._delayTime, false)
        end
    end
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, button, touchPosition)
        if self._state ~= ButtonState.DISABLE then
            
            if self._interval > 0 then
                if os.time() - self._lastTouchTime >= self._interval then
                    self._lastTouchTime = os.time()
                    onTouch(self, button, touchPosition)
                end
            else
                onTouch(self, button, touchPosition)
            end
        end
    end)
end

function Button:clickCallback(touchPosition)
    if self.playAudio then
        Avalon.AudioManager:playSound(self.audioID)
    end
    self:dispatchEvent(UIEvent.BUTTON_CLICK, self, touchPosition)
end

function Button:delayCallback()
    if self._schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self._schedulerID)
    end
    if(self._delayFuncHandler) then
        self._delayFuncHandler()
    end
end

function Button:setTextOffset(x, y)
    self._textOffset = cc.p(x, y)
    if (self._text) and self._inited then
        self._text:center(x, y)
    end
end

-- 设置字体样式
function Button:setTextFont(fontName, fontSize, fontColor)
    if (self._text) then
        self._text:setFontName(fontName)
        self._text:setFontSize(fontSize)
        self._text:setFontColor(fontColor)
    end
end

function Button:setFontColor(fontColor)
    if (self._text) then
        self._text:setFontColor(fontColor)
    end
end

function Button:setTextWidth(width)
    if (self._text) then
        self._text:setWidth(width)
    end
end

function Button:getTextContentSize()
    if (self._text) then
        return self._text:getContentSize()
    end
    return nil
end

function Button:setFixLineWidth(width)
    if (self._text) then
        self._text:setFixLineWidth(width)
    end
end

-- 设置字体内容
function Button:setText(text)
    assert(type(text) == "string", "Button setText: text is invalid.")

    if (self._text) then
        self._text:setText(text)
    else
        assert(false)
    end
end

function Button:setTextById(id)
    local text = LanguageManager:getInstance():getLocalString(id)
    self:setText(text)
end


-- 获取字体内容
function Button:getText()
    if (self._text) then
        return self._text:getText(text)
    else
        return ""
    end
end

-- 设置字体大小
function Button:setFontSize(fontSize)
    if (self._text) then
        self._text:setFontSize(fontSize)
    end
end

-- 设置字体描边
function Button:setOutline(outlineColor, outlineSize)
    if (self._text) then
        self._outlineColor = outlineColor
        self._outlineSize = outlineSize
        self._text:setOutline(self._outlineColor, self._outlineSize)
    end
end

-- 设置字体阴影
function Button:setTextShadow(shadowColor, shadowOffset)
    if (self._text) then
        self._shadowColor = shadowColor
        self._shadowOffset = shadowOffset
        self._text:enableShadow(self._shadowColor, self._shadowOffset)
    end
end


-- 设置字体下划线
function Button:setUnderline(enable)
    if (self._text) then
        self._text:setUnderline(enable)
    end
end

function Button:onTouchMove(touchPosition)
    if self._state == ButtonState.ACTIVE then
        if not self._keepActivated and not self:checkTouchPosition(touchPosition) then
            self:release(false)
        end
    elseif self._state == ButtonState.NORMAL then
        if self:checkTouchPosition(touchPosition) then
            self:press(false)
        end
    end
end

-- 点击
function Button:press(needDispatchEvent)
    -- print("Button:press")
    if needDispatchEvent == nil then
        needDispatchEvent = true
    end
    if (self._state == ButtonState.NORMAL) then
        self._state = ButtonState.ACTIVE

        if (self._sprite) then
            if (self._active) then
                self._sprite:setSpriteFrame(self._active)

                local spriteSize = self._sprite:getContentSize()
                if self._isRefreshSize then
                    self:setSize(spriteSize.width, spriteSize.height)
                    self._sprite:setPosition(self._hw, self._hh)
                else
                    local baseline = self._baseline
                    local offsetX, offsetY = 0, 0
                    if (baseline == UI.ButtonBaseLine.BOTTOM) then
                        offsetY = (spriteSize.height - self._height) / 2
                    elseif (baseline == UI.ButtonBaseLine.TOP) then
                        offsetY = (self._height - spriteSize.height) / 2
                    elseif (baseline == UI.ButtonBaseLine.LEFT) then
                        offsetX = (spriteSize.width - self._width) / 2
                    elseif (baseline == UI.ButtonBaseLine.RIGHT) then 
                        offsetX = (self._width - spriteSize.height) / 2
                    else
                        offsetX = 0
                        offsetY = 0
                    end
                    self._sprite:setPosition(self._hw + offsetX, self._hh + offsetY)
                end
            end
        end

        if(self._normalNode) then
            self._normalNode:setVisible(false)
        end

        if(self._activeNode) then
            self._activeNode:setVisible(true)
        end

        if(self._disableNode) then
            self._disableNode:setVisible(false)
        end

        if self._clickScale then

            local action = self:getActionByTag(self.zoomActionTag)
            if action then
                self:stopAction(action)
            else
                self.originalScaleX = self:getScaleX()
                self.originalScaleY = self:getScaleY()
            end

            local zoomAction = cc.ScaleTo:create(0.1,self.originalScaleX * 1.1,self.originalScaleY * 1.1)
            zoomAction:setTag(self.zoomActionTag)
            self:runAction(zoomAction)
        end
        if needDispatchEvent then
            self:dispatchEvent(UIEvent.BUTTON_PRESS, self)
        end
    else
        if needDispatchEvent then
            self:dispatchEvent(UIEvent.BUTTON_ERROR, "Button is not avaliable.")
        end
    end
    if self._state == ButtonState.DISABLE then
        if needDispatchEvent then
            Avalon.AudioManager:playSound(self.clickAudioID)
            self:dispatchEvent(UIEvent.BUTTON_DISABLE_PRESS, self)
        end
    end 
end

-- 释放
function Button:release(needDispatchEvent)
    if needDispatchEvent == nil then
        needDispatchEvent = true
    end
    if (self._state == ButtonState.ACTIVE) then
        self._state = ButtonState.NORMAL

        if (self._sprite) then
            if (self._normal) then
                self._sprite:setSpriteFrame(self._normal)
                if self._isRefreshSize then
                    self:setSize(self._sprite:getContentSize().width, self._sprite:getContentSize().height)
                    self._sprite:setPosition(self._hw, self._hh)
                end
                self._sprite:setPosition(self._hw, self._hh)
            end
        end

        if(self._normalNode) then
            self._normalNode:setVisible(true)
        end

        if(self._activeNode) then
            self._activeNode:setVisible(false)
        end

        if(self._disableNode) then
            self._disableNode:setVisible(false)
        end

        if self._clickScale then
            local zoomAction = cc.ScaleTo:create(0.1,self.originalScaleX,self.originalScaleY)
            zoomAction:setTag(self.zoomActionTag)
            self:runAction(zoomAction)
        end
        if needDispatchEvent then
            self:dispatchEvent(UIEvent.BUTTON_RELEASE, self)
        end
    else
        if needDispatchEvent then
            self:dispatchEvent(UIEvent.BUTTON_ERROR, "Button is not actived.")
        end
    end
end

-- 启用
function Button:enable(delay)
    if (self._state == ButtonState.DISABLE) then
        local function doEnable()
            self._state = ButtonState.NORMAL
            self:dispatchEvent(UIEvent.BUTTON_ENABLE, self)

            if (self._sprite) then
                if (self._normal) then
                    self._sprite:setSpriteFrame(self._normal)
                    if self._isRefreshSize then
                        self:setSize(self._sprite:getContentSize().width, self._sprite:getContentSize().height)
                        self._sprite:setPosition(self._hw, self._hh)
                    end
                end
            end

            if(self._normalNode) then
                self._normalNode:setVisible(true)
            end

            if(self._activeNode) then
                self._activeNode:setVisible(false)
            end

            if(self._disableNode) then
                self._disableNode:setVisible(false)
            end
        end

        if (delay) then
            -- 只有在延迟过程中状态没被改动的情况下, 复位成可用
            -- 如果在等待过程中状态被改变, 就不再改变其状态
            local markButtonState = self._state
            performWithDelay(self, function()
                if (markButtonState == self._state) then
                    doEnable()
                end
            end, delay)
        else
            doEnable()
        end
    end
end

function Button:refreshClickSize(isRefresh)
    self._isRefreshSize = isRefresh
end

-- 禁用
function Button:disable()
    if (self._state ~= ButtonState.DISABLE) then
        local function doDisable()
            self._state = ButtonState.DISABLE
            self:dispatchEvent(UIEvent.BUTTON_DISABLE, self)

            if (self._sprite) then
                if (self._disable) then
                    self._sprite:setSpriteFrame(self._disable)
                    if self._isRefreshSize then
                        self:setSize(self._sprite:getContentSize().width, self._sprite:getContentSize().height)
                        self._sprite:setPosition(self._hw, self._hh)
                    end
                end
            end

            if(self._normalNode) then
                self._normalNode:setVisible(false)
            end

            if(self._activeNode) then
                self._activeNode:setVisible(false)
            end

            if(self._disableNode) then
                self._disableNode:setVisible(true)
            end
            if self._clickScale then
                local zoomAction = cc.ScaleTo:create(0.1,self.originalScaleX,self.originalScaleY)
                zoomAction:setTag(self.zoomActionTag)
                self:runAction(zoomAction)
            end
        end

        if (delay) then
            -- 只有在延迟过程中状态没被改动的情况下, 复位成可用
            -- 如果在等待过程中状态被改变, 就不再改变其状态
            local markButtonState = self._state
            performWithDelay(self, function()
                if (markButtonState == self._state) then
                    doDisable()
                end
            end, delay)
        else
            doDisable()
        end
    else
        self:dispatchEvent(UIEvent.BUTTON_ERROR, "Could not disable the button.")
    end
end

-- 设置图片展示的基线（底边）
function Button:setBottomBaseline()
    self._baseline = UI.ButtonBaseLine.BOTTOM
end

-- 设置图片展示的基线（顶边）
function Button:setTopBaseline()
    self._baseline = UI.ButtonBaseLine.TOP
end

-- 设置图片展示的基线（左边）
function Button:setLeftBaseline()
    self._baseline = UI.ButtonBaseLine.LEFT
end

-- 设置图片展示的基线（右边）
function Button:setRightBaseline()
    self._baseline = UI.ButtonBaseLine.RIGHT
end

-- 初始化视图
function Button:onInitView()
    -- 按钮图片
    local sprite = cc.Sprite:create()
    sprite:setScale(self._bgDisplayScale)
    if (self._normal) then
        sprite:initWithSpriteFrameName(self._normal)
        local spriteSize = sprite:getContentSize()
        self:setSize(spriteSize.width, spriteSize.height)
    end
    self:addChild(sprite, BUTTON_SPRITE_ZORDER)

    if(self._normalNode) then
        self._normalNode:setVisible(true)
    end

    if(self._activeNode) then
        self._activeNode:setVisible(false)
    end

    if(self._disableNode) then
        self._disableNode:setVisible(false)
    end

    -- 文字描述
    -- local label = cc.Label:createWithSystemFont("", UI.FONT_ARIAL, UI.FONT_SIZE_25PX)
    -- self:addChild(label, BUTTON_TITLE_ZORDER)
    local text = UI.Text:create()
    text:init("")
    self:addChild(text, BUTTON_TITLE_ZORDER)

    self._sprite = sprite
    self._text = text
end

-- 更新视图
function Button:onUpdateView()
    local posX, posY = self._width / 2, self._height/ 2
    self._sprite:setPosition(posX, posY)

    self._text:center(self._textOffset.x, self._textOffset.y)
end

--点击放大(默认不放大)
function Button:openClickScale()
    self._clickScale = true;
end

--取消点击放大
function Button:closeClickScale()
    self._clickScale = false;
end

function Button:setNormalNode(node, zorder)
    local zorder = zorder or 10
    self._normalNode = node
    self:addChild(self._normalNode,zorder)
end

function Button:setSelectedNode(node, zorder)
    local zorder = zorder or 10
    self._activeNode = node
    self:addChild(self._activeNode,zorder)
    self._activeNode:setVisible(false)
end

function Button:setDisabledNode(node, zorder)
    local zorder = zorder or 10
    self._disableNode = node
    self:addChild(self._disableNode,zorder)
    self._disableNode:setVisible(false)
end

function Button:getNormalNode()
    return self._normalNode
end

function Button:getSelectedNode()
    return self._activeNode
end

function Button:getDisabledNode()
    return self._disableNode
end

function Button:setBtnStatus(state)
    self._state = state
    local name = nil
    if self._state == ButtonState.NORMAL then
        name = self._normal;
    elseif self._state == ButtonState.ACTIVE then
        name = self._active
    elseif self._state == ButtonState.DISABLE then
        name = self._disable
    end

    if name then
        local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(name)
        if spriteFrame then
            self._sprite:setSpriteFrame(spriteFrame)
        end
    end
end

function Button:setNormal(var)
    self._normal = var
    if self._state == ButtonState.NORMAL then
        self._sprite:setSpriteFrame(self._normal)
    end
end



function Button:setSelected(var)
    self._active = var
    if self._state == ButtonState.ACTIVE then
        self._sprite:setSpriteFrame(self._active)
    end
end

function Button:setDisabled(var)
    self._disable = var
    if self._state == ButtonState.DISABLE then
        self._sprite:setSpriteFrame(self._disable)
    end
end

function Button:getSprite()
    return self._sprite;
end

function Button:setScaleY(scaleY)
    if(self._sprite) then
        self._sprite:setScaleY(scaleY)
    end
end

function Button:setScaleX(scaleX)
    if(self._sprite) then
        self._sprite:setScaleX(scaleX)
    end
end

-- 变灰
function Button:onUseShader(shader)
    if(self._sprite) then
        self._sprite:setGLProgramState(shader)
    end
end

--[[按钮延时响应  以最后一次点击事件为准 延时delayTime秒 响应 delayFuncHandler，
    且每次点击会即时响应 UIEvent.BUTTON_CLICK事件
]]
function Button:setDelay(delayTime, delayFuncHandler)
    self._delayTime = delayTime
    self._delayFuncHandler = delayFuncHandler
end

-- 设置按钮点击间隔时间
function Button:setInterval(interval)
    self._interval = interval
end

function Button:isDisable()
    if self._state == ButtonState.DISABLE then
        return true
    end
    return false
end

function Button:playUnlockAction(callback, right, up, zorder, scale)
    if self._lockAction ~= nil then
        self._lockAction:removeFromParent()
        self._lockAction = nil
    end
    self._lockAction = ToolsUtil:playUnlockAction(self, function()
        self._lockAction = nil
        if callback then
            callback()
        end
    end, false, 5, 5)
end

function Button:playNewAction(scale)
    if self._newAction ~= nil then
        self._newAction:removeFromParent()
        self._newAction = nil
    end
    self._newAction = ToolsUtil:playNewAction(self, scale, 9, 5)
    return self._newAction
end

function Button:removeNewAction()
    if self._newAction then
        self._newAction:destroy()
        self._newAction = nil
    end
end

function Button:setPlayAudio(b)
    self.playAudio = b
end

function Button:keepActivated(b)
    self._keepActivated = b
end

function Button:setChoiced(choiced)
    self.choiced = choiced
end

function Button:getChoiced()
    return self.choiced
end