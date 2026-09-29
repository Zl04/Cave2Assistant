------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WishPoolTipView = class("WishPoolTipView", UI.HWBtnComponent)

require "app.utils.ToolsUtil"

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 430
local COM_HEIGHT = 290

function WishPoolTipView:ctor(data)
    WishPoolTipView.super.ctor(
    	self,
    	UI.Type.WISH_POOL_TIP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.wishType = data.wishType
    self.npcID = data.npcID
end

function WishPoolTipView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.wishpool", "WishPool", false)
    WishPoolTipView.super.init(self, ... )
end

function WishPoolTipView:dtor()
    self:sendWish()

    WishPoolTipView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.wishpool.WishPoolTipView")
end

function WishPoolTipView:onInitView()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box2.png")
    bg:setCapInsets(CCRectMake(190,96,5,5))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    self:addChild(bg)
    
    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_1213270,UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(25)
    bg:addChild(titleText)

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light2.png")
    line:setContentSize(375, 2)
    line:setAnchorPoint(cc.p(0, 0.5))
    line:setPosition(cc.p(24, 217))
    bg:addChild(line)

    -- 输入
    local libIDEdit = UI.EditBox:create(320, 61)
    local placeHolderTxtID = mvc.wishPoolModel:getRandTip()
    self.holderTxt = LanguageManager:getInstance():getLocalString(tonumber(placeHolderTxtID))
    local showHolderTxt = self.holderTxt
    if AvalonUtil:isUpLimiteStr(showHolderTxt, 290, 20) then
        showHolderTxt = AvalonUtil:getSubNameStrByLabel(showHolderTxt, 290, 20) .. "..."
    end
    libIDEdit:init(showHolderTxt, cc.EDITBOX_INPUT_MODE_SINGLELINE, "ui_activity_banner_mailbox.png", 21, 14)
    libIDEdit:leftUp(self:getContentSize().width / 2 - 164, 110)
    bg:addChild(libIDEdit)
    libIDEdit:setFontSize(20)
    libIDEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    libIDEdit:setPlaceholderFontSize(20)
    libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_155_155_155)
    libIDEdit:setChangeCallback(function()
        self:judeInputTextLength(self.libIDEdit:getText())
    end)
    self.libIDEdit = libIDEdit

    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    confirmButton:centerBottom(30)
    confirmButton:closeClickScale()
    confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.closePanel("WishPool", "WishPoolTip")
    end)
    bg:addChild(confirmButton)

    local text  = UI.Text:create()
    text:init(UI.TEXT_1170211, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    text:center()
    text:setName("text")
    confirmButton:addChild(text,100)
end

function WishPoolTipView:checkEditorText()
    local text = self.libIDEdit:getText()
    if not text or text == "" then
        text = self.holderTxt
    end

    local formatStr, mark = ToolsUtil:checkMaskword(text)
    if mark then
        UI.ScrollBar:createByText(UI.TEXT_1170415)
        self.libIDEdit:setText(formatStr)
        -- 即使有非法输入，替换完后仍然继续发送
        return true
    else
        local msg = self:judeInputTextLength(formatStr)
        self.libIDEdit:setText(msg)
    end
end

function WishPoolTipView:judeInputTextLength(message)
    local isHave = string.find(message, "\n")
    if isHave ~= nil then
        message = string.gsub(message, "\n", "")
        self.libIDEdit:setText(message)
        return message
    end

    if AvalonUtil:isUpLimiteStr(message, 435, 20) then
        message = AvalonUtil:getSubNameStrByLabel(message, 435, 20)
        self.libIDEdit:setText(message)
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return message
    end

    return message
end

function WishPoolTipView:sendWish()

    local func = function(text)
        self.libIDEdit:setText(text)
        self:checkEditorText()
        Net.NetGuildSystem:reqGuildWish(self.wishType, self.npcID, self.libIDEdit:getText())
    end

    local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
    gameWordDetectionManager:getInstance():textDetection(self.libIDEdit:getText(),func,function()
    end,PublicDefine.ChatChannelType.GUILD)
end

function WishPoolTipView:bindModel()

end

function WishPoolTipView:unbindModel()

end

return WishPoolTipView
