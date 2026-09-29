------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/30
--desc	: 采集左侧信息
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local tradeActivityGrowFundTips = class("tradeActivityGrowFundTips", UI.BaseWin)
UI = UI or {}
UI.tradeActivityGrowFundTips = tradeActivityGrowFundTips

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
    "ui_town_businessactivities.plist",
}

local COM_WIDTH = 440
local COM_HEIGHT = 540

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

function tradeActivityGrowFundTips:ctor(isAdvanced)
    self._isAdvanced = isAdvanced
    tradeActivityGrowFundTips.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self:setTouchEnable(true)
    self:setInterceptTouches(true)

end

function tradeActivityGrowFundTips:init()
    tradeActivityGrowFundTips.super.init(self)
end

function tradeActivityGrowFundTips:dtor()
    tradeActivityGrowFundTips.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.tradeactivity.tradeActivityCommon.tradeActivityGrowFundTips")
end

function tradeActivityGrowFundTips.show(isAdvanced)
    local dialog = tradeActivityGrowFundTips:create(isAdvanced)
    
    dialog:init()
    dialog:center()
    

    UI.UIManager:getRootNode():addChild(dialog, UI_ZORDER.TIPS)

    return dialog
end

function tradeActivityGrowFundTips:onInitView()
    self.tipsSize = cc.size(370, 260)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(self.tipsSize.width, self.tipsSize.height)
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
    ConfirmDialogBg:init("ui_setup_banner_box3.png")
    ConfirmDialogBg:center()
    ConfirmDialogBg:computePosition()
    ConfirmDialogBg:setName("ConfirmDialogBg")
    self.contentLayout:addChild(ConfirmDialogBg)
    self.ConfirmDialogBg = ConfirmDialogBg

    local okButton = UI.Button:create()
    okButton:init("ui_businessactivities_btn_06.png", "ui_businessactivities_btn_06.png")
    okButton._clickScale = false
    okButton._baseline = 1
    okButton:setReflectPos(258, 212)
    okButton:rightBottom(40, 20)
    okButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    okButton:setText(UI.TEXT_1324527)
    ConfirmDialogBg:addChild(okButton)
    okButton:setName("okButton")
    self.okButton = okButton

    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_businessactivities_btn_gray_06.png", "ui_businessactivities_btn_gray_06.png")
    cancelBtn._clickScale = false
    cancelBtn._baseline = 1
    cancelBtn:setReflectPos(55, 212)
    cancelBtn:leftBottom(40, 20)
    cancelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    cancelBtn:setText(UI.TEXT_1324528)
    ConfirmDialogBg:addChild(cancelBtn)
    cancelBtn:setName("cancelBtn")
    self.cancelBtn = cancelBtn

    local contentBg = UI.Layout:create()
    contentBg:init()
    contentBg:setSize(370, 127)
    contentBg:center()
    -- contentBg:enableDebugDraw()
    ConfirmDialogBg:addChild(contentBg)
    self.contentBg = contentBg

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:setReflectSize(370, 2)
    contentTopLine:centerUp(-20)
    contentBg:addChild(contentTopLine)
    contentTopLine:setName("contentTopLine")
    self.contentTopLine = contentTopLine

    local contentBottomLine = UI.Image9:create()
    contentBottomLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentBottomLine:setReflectSize(370, 2)
    contentBottomLine:centerBottom(0)
    contentBg:addChild(contentBottomLine)
    contentBottomLine:setName("contentBottomLine")
    self.contentBottomLine = contentBottomLine

    self:createRichText()


    self.cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.cancel)
    self.okButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.ok)

    -- 显示不再提示的选择框
    -- if self.showNoMoreKey then
    --     self.showSelectPanel = UI.Layout:create()
    --     self.showSelectPanel:init()
    --     self.showSelectPanel:setSize(200, 80)
    --     self.showSelectPanel:centerBottom(60)
    --     ConfirmDialogBg:addChild(self.showSelectPanel, 10)

    --     local choiceLogo = UI.Image:create()
    --     choiceLogo:init("ui_btn_choice_1.png")
    --     choiceLogo:center()
    --     choiceLogo:hide()
    --     self.choiceLogo = choiceLogo

    --     local choiceButton = UI.Button:create()
    --     choiceButton:init("ui_btn_choice_0.png","ui_btn_choice_0.png","ui_btn_choice_0.png")
    --     choiceButton:leftBottom(565, 10)
    --     choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --         self.choiceLogo:setVisible(not self.choiceLogo:isVisible())
    --     end)
    --     self.showSelectPanel:addChild(choiceButton)
    --     choiceButton:addChild(choiceLogo, 10)
    --     choiceButton:setScale(0.88)

    --     local text = UI.Text:create()
    --     text:init(UI.TEXT_1212210, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    --     text:center()
    --     self.showSelectPanel:addChild(text)
    --     local left = (self.showSelectPanel:getContentSize().width - choiceButton:getContentSize().width - text:getContentSize().width - 10) / 2
    --     choiceButton:centerLeft(left)
    --     text:centerLeft(left + choiceButton:getContentSize().width + 5)
    -- end
end

function tradeActivityGrowFundTips:createRichText()
    -- 创建富文本元素
    local richTextList = {}

    local des1 = UI.TEXT_1324523
    local des2 = UI.TEXT_1324525

    if self._isAdvanced == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund or 
    self._isAdvanced == PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo then
        des1 = UI.TEXT_1324523
        des2 = UI.TEXT_1324539
    end

    local elementText = UI.Text:create()
    elementText:init(des1, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    elementText:center()
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(des2, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_216_61_45)
    elementText:center()
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init("\n"..UI.TEXT_1324524, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    elementText:center()
    table.insert(richTextList, elementText)

    local richText = UI.imitateRichText:create(360)
    richText:init(richTextList, 360, 120, 20)
    -- richText:enableDebugDraw()
    richText:setTextCenter()
    richText:centerUp(4)
    self.contentBg:addChild(richText)
    self.text = richText


    -- 创建富文本元素
    local roleLevel = RoleDataManager:getMaster():getLevel()
    local richTextList = {}

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324522, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    elementText:center()
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(tostring(roleLevel), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_216_61_45)
    elementText:center()
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324526, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    elementText:center()
    table.insert(richTextList, elementText)

    local richText = UI.imitateRichText:create(360)
    richText:init(richTextList, 360, 30)
    -- richText:enableDebugDraw()
    richText:setTextCenter()
    richText:centerUp(18)
    self.ConfirmDialogBg:addChild(richText)
    self.titleText = richText
end

function tradeActivityGrowFundTips:getCancelButton()
    return self.cancelBtn
end

function tradeActivityGrowFundTips:cancel()
    local isVisible = false
    if self.choiceLogo then
        isVisible = self.choiceLogo:isVisible()
    end
    if self.cancelCallback then
        self.cancelCallback(isVisible)
    else
        self:dispatchEvent(UIEvent.DIALOG_CANCEL, self)
    end
    if self.closeDialog then
        self:closeDialog()
    end
end

function tradeActivityGrowFundTips:ok()
    local isVisible = false
    if self.choiceLogo then
        isVisible = self.choiceLogo:isVisible()
    end

    -- local viewName = mvc.tradeActivityModel:getActivityViewNameByID(self._isAdvanced)
    -- if (self._isAdvanced) then
    --     mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityNewGrowFund)
    -- else 
    --     mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityGrowFund)
    -- end
    mvc.openPanel("TradeActivity", "TradeActivityMain", self._isAdvanced)

    if self.showNoMoreKey and self.choiceLogo:isVisible() then
        cc.UserDefault:getInstance():setBoolForKey(tostring(self.showNoMoreKey), false)
    end

    if self.closeDialog then
        self:closeDialog()
    end
end

function tradeActivityGrowFundTips:closeDialog()
    self:removeFromParent()
end

function tradeActivityGrowFundTips:bindModel()

end

function tradeActivityGrowFundTips:unbindModel()

end

return tradeActivityGrowFundTips
