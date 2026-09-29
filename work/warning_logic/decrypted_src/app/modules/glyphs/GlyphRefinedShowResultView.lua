------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/11/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphRefinedShowResultView = class("GlyphRefinedShowResultView", UI.HWBtnComponent)

require "app.modules.glyphs.GlyphRefinedShowResultListView"

UI = UI or {}
UI.GlyphRefinedShowResultView = GlyphRefinedShowResultView

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 852
local COM_HEIGHT = 534

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist",
    "ui_town_glyphs.plist",
}

function GlyphRefinedShowResultView:ctor()
    GlyphRefinedShowResultView.super.ctor(self, UIType.CONFIRM_DIALOG, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSide)

    self:bindModel()
end

function GlyphRefinedShowResultView:init(text, okCallback, lastAttrDatas, lastIsGiveUp)
    self.text = text
    self.okCallback = okCallback
    self.lastAttrDatas = lastAttrDatas or {}
    self.lastIsGiveUp = lastIsGiveUp

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.glyphs", "Glyphs", false)
    GlyphRefinedShowResultView.super.init(self)
end

function GlyphRefinedShowResultView:dtor()
    GlyphRefinedShowResultView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.glyphs.GlyphRefinedShowResultView")
end


function GlyphRefinedShowResultView:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask, 0)

    local ConfirmDialogBg = UI.Image:create()
    ConfirmDialogBg:init("ui_glyphs_paper2.png")
    ConfirmDialogBg:center()
    ConfirmDialogBg:setName("ConfirmDialogBg")
    self.contentLayout:addChild(ConfirmDialogBg)
    self.ConfirmDialogBg = ConfirmDialogBg

    -- 洗练结果
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_227027, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 57, g = 55, b = 58})
    titleText:center(0,-130)
    self.contentLayout:addChild(titleText)

    local okButton = UI.Button:create()
    okButton:init("ui_glyphs_btn_4.png", "ui_glyphs_btn_4.png", "ui_glyphs_btn_4.png", {x=0, y=0})
    okButton:center(100,130)
    okButton:setName("okButton")
    okButton:setText(UI.TEXT_1170211)
    okButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 55, b = 58})
    okButton._clickScale = false
    ConfirmDialogBg:addChild(okButton)
    self.okButton = okButton
    self.okButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.ok)

    local detailsButton = UI.Button:create()
    detailsButton:init("ui_glyphs_btn_4.png", "ui_glyphs_btn_4.png", "ui_glyphs_btn_4.png", {x=0, y=0})
    detailsButton:center(-100,130)
    detailsButton:setName("detailsButton")
    detailsButton:setText(UI.TEXT_223606)
    detailsButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 55, b = 58})
    detailsButton._clickScale = false
    ConfirmDialogBg:addChild(detailsButton)
    self.detailsButton = detailsButton
    self.detailsButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.detailsCheck)

    if #self.lastAttrDatas <= 0 then
        okButton:center(0,130)
        detailsButton:hide()
    end


    if self.text then
        self.contentLabel = self.text
        self.contentLabel:center(0,-60)
        self.contentLayout:addChild(self.contentLabel)
        self.contentLabel:setName("contentLabel")
    end
end

function GlyphRefinedShowResultView:ok()
    if self.okCallback then
        self.okCallback(isVisible)
    end
    self:removeFromParent()
end

function GlyphRefinedShowResultView:detailsCheck()
    if self.lastAttrDatas then
        local ResultList = UI.GlyphRefinedShowResultListView:create(self.lastAttrDatas, self.lastIsGiveUp)
        ResultList:init()
        self.contentLayout:addChild(ResultList, 10)
    end

    --self:removeFromParent()
end

function GlyphRefinedShowResultView:onTouchOutSide()
end

function GlyphRefinedShowResultView:bindModel()
end

function GlyphRefinedShowResultView:unbindModel()
end

return GlyphRefinedShowResultView

