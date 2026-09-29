-- QuickExpressionCell.lua
-- Author:ydli
-- 2018年06月25日
-- Using:快捷表情可编辑文本cell
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local QuickExpressionCell = class("QuickExpressionCell", UI.Component)
UI.QuickExpressionCell = QuickExpressionCell

local winSize = cc.Director:getInstance():getWinSize()
local size = cc.size(376, 60 - 1)
local editorModeSize = cc.size(315, 60 - 1)
-- 资源列表(必备)
local COM_RES_LIST = {
}

--构造函数(必备)
function QuickExpressionCell:ctor(showText)
    -- print("TipsLayer:ctor")
    --窗口大小
    QuickExpressionCell.super.ctor(
    self, 0,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self._showText = showText
    self._isEnable = true
    self:init()
end

--虚构函数,destroy时调用(必备)
function QuickExpressionCell:dtor()
    QuickExpressionCell.super.dtor(self)
end

-- 初始化(必备)
function QuickExpressionCell:init()
    QuickExpressionCell.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function QuickExpressionCell:onInitView()
    -- self:enableDebugDraw()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_translation_box4.png")
    bg:setCapInsets(CCRectMake(1,1,1,1))
    bg:setContentSize(size.width, size.height)
    bg:setAnchorPoint(0, 0)
    self:addChild(bg, 1)
    self.scale9Bg = bg

    local textLabel = UI.Text:create()
    textLabel:init(self._showText, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_131_128_125)
    textLabel:center()
    bg:addChild(textLabel)
    self.textLabel = textLabel

    -- 分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark2.png")
    lineUpImage:setContentSize(size.width, 2)
    lineUpImage:setAnchorPoint(0, 0)
    lineUpImage:setPosition(cc.p(0, size.height))
    bg:addChild(lineUpImage)

    local editorBtn = UI.Button:create()
    editorBtn:init("ui_chat_button__edit_0.png", "ui_chat_button__edit_1.png")
    editorBtn:centerRight(5)
    editorBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self:showEditorBox()
    end)
    editorBtn:hide()
    self:addChild(editorBtn, 2)
    self.editorBtn = editorBtn
    self:refreshShowText(self._showText)
end

-- 模版函数：更新组建的视图(必备)
function QuickExpressionCell:onUpdateView()

end

function QuickExpressionCell:showEditorBox()
    if self.editorBox then
        self.textLabel:show()
        self.editorBox:removeFromParent()
        self.editorBox = nil
        return
    end
    self.textLabel:hide()
    local libIDEdit = cc.EditBox:create({width = editorModeSize.width, height = editorModeSize.height}, cc.Scale9Sprite:createWithSpriteFrameName("ui_information_placeholder.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_information_placeholder.png"), cc.Scale9Sprite:createWithSpriteFrameName("ui_information_placeholder.png"))

    libIDEdit:setFontSize(UI.FONT_SIZE_16PX)
    libIDEdit:setPlaceholderFontSize(UI.FONT_SIZE_16PX)
    if self._isEnable then
        libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_255_255_255)
        libIDEdit:setFontColor(UI.FONT_COLOR_255_255_255)
    else
        libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_131_128_125)
        libIDEdit:setFontColor(UI.FONT_COLOR_131_128_125)
    end
    libIDEdit:setText(self._showText)
    libIDEdit:setFontName(UI.FONT_STANDARD)
    libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    libIDEdit:setPosition(editorModeSize.width / 2, editorModeSize.height / 2)
    libIDEdit:registerScriptEditBoxHandler(handler(self, self.editboxEventHandler))
    libIDEdit:setHorizontalAlignment(UI.TextHAlignment.CENTER)
    self.scale9Bg:addChild(libIDEdit)
    self.editorBox = libIDEdit
    self.editorBox:openKeyboard()

end

function QuickExpressionCell:hideEditorBox()
    if self.editorBox then
        self.editorBox:removeFromParent()
        self.editorBox = nil
    end
end

--是否 播放出现动画 待定？
function QuickExpressionCell:onEditorMode(isShow)
    if self.editorBtn:isVisible() == isShow then
        return
    end
    local text = nil
    if isShow then
        self.editorBtn:show()
        self.scale9Bg:setContentSize(size.width, size.height)
    else
        self.editorBtn:hide()
        self.scale9Bg:setContentSize(size.width, size.height)
        if  self.editorBox then
            text = self.editorBox:getText()
            self:hideEditorBox()
        end
        self.textLabel:show()
    end
    self.textLabel:center()
    if text then
        self:refreshShowText(text)
    end
end

function QuickExpressionCell:onSelected()
    self:setScale(1.1)
    self:setZOrder(100)
    self.editorBtn:hide()
end

function QuickExpressionCell:onNormal()
    self:setScale(1.0)
    self:setZOrder(1)
    self.editorBtn:show()
end

function QuickExpressionCell:onDisable()
    if self._isEnable then
        local contentSize = self.scale9Bg:getContentSize()
        local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_chat_translation_box3.png")
        self.scale9Bg:setSpriteFrame(spriteFrame, CCRectMake(1,1,1,1))
        self.scale9Bg:setContentSize(contentSize.width, contentSize.height)
        self._isEnable = false
        self.textLabel:setFontColor(UI.FONT_COLOR_131_128_125)
    end
end

function QuickExpressionCell:onEnable()
    if not self._isEnable then
        local contentSize = self.scale9Bg:getContentSize()
        local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("ui_chat_translation_box4.png")
        self.scale9Bg:setSpriteFrame(spriteFrame, CCRectMake(1,1,1,1))
        self.scale9Bg:setContentSize(contentSize.width, contentSize.height)
        self._isEnable = true
        self.textLabel:setFontColor(UI.FONT_COLOR_170_170_170)
    end
end

--根据文本长度 裁剪 超出的用省略号
function QuickExpressionCell:refreshShowText(showText)
    if self._showText == showText then
        return
    end
    self._showText = showText
    local showText = AvalonUtil:getSubNameStrByLabel(showText, self.scale9Bg:getContentSize().width - 106, UI.FONT_SIZE_16PX, true)
    self.textLabel:setText(showText)
end

function QuickExpressionCell:editboxEventHandler(eventType)
    print("QuickExpressionCell:editboxEventHandler(eventType) .. "..eventType)
    if eventType == "began" then
    elseif eventType == "ended" then
    elseif eventType == "changed" then
        self.lastMessage = self.lastMessage or self._showText
        local message = self.editorBox:getText() or ""
        local lastStrLen = string.len(self.lastMessage) 
        local curStrLen = string.len(message) 
        if curStrLen > lastStrLen and AvalonUtil:isUpLimiteStr(message, 400, UI.FONT_SIZE_16PX) then
            message = AvalonUtil:getSubNameStrByLabel(message, 400, UI.FONT_SIZE_16PX, false)
            self.editorBox:setText(message)
            UI.ScrollBar:createByText(UI.TEXT_1170311)
            AvalonUtil.closeKeyBoard(self.editorBox)
            return
        end
        self.lastMessage = message
    elseif eventType == "return" then
        -- self.editorBox = nil
        self:editTextCallback()

        self.textLabel:show()
        self.editorBtn:setTouchEnable(false)
        self.editorBox:hide()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if not tolua.isnull(self.editorBox) then
                self.editorBox:removeFromParent()
                self.editorBox = nil
            end
            if not tolua.isnull(self.editorBtn) then
                self.editorBtn:setTouchEnable(true)
            end
        end, 1)
    end
end

function QuickExpressionCell:editTextCallback(eventType)
    local message = self.editorBox:getText() or ""
    local mark = false
    message,mark = ToolsUtil:checkMaskword(message)
    if mark then
        UI.ScrollBar:createByText(UI.TEXT_1170415)
        return
    end

    if message == "" then
        UI.ScrollBar:createByText(UI.TEXT_1170309)
        return
    end
  
    if AvalonUtil:isUpLimiteStr(message, 400, UI.FONT_SIZE_16PX) then
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return 
    end

    self:refreshShowText(message)
end