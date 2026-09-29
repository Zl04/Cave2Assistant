-- ConfirmRichDialog.lua
-- Author:hongyi.yan
-- 2020年6月10日
-- Using:确认对话框

UI = UI or {}

local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist"
}
local ConfirmRichDialog = class("ConfirmRichDialog", UI.HWBtnComponent)
UI.ConfirmRichDialog = ConfirmRichDialog

ConfirmType = {
    CONFIRM_ONLY = 1,
    OK_AND_CANCEL = 2,
    CANCEL_RED_OK_WHITE = 3, -- 取消红色, 确定白色
    CONFIRM_ONLY_RED = 4,    -- 仅有按钮，表现未红色       
}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

function ConfirmRichDialog:ctor()
    ConfirmRichDialog.super.ctor(self, UIType.CONFIRM_DIALOG, COM_RES_LIST, winSize.width, winSize.height)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSide)

    self.dialogType = ConfirmType.OK_AND_CANCEL
    self.isModelDialog = true;
end

function ConfirmRichDialog:dtor()
end

function ConfirmRichDialog:init(text, okCallback, cancelCallback, type, showNoMoreKey)
    self.dialogType = type or ConfirmType.OK_AND_CANCEL
    self.text = text or ""
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback
    self.tipsSize = cc.size(370, 260)
    self.showNoMoreKey = showNoMoreKey
    ConfirmRichDialog.super.init(self)
end

-- 初始化视图
function ConfirmRichDialog:onInitView()

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
    okButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    okButton._clickScale = false
    okButton._baseline = 1
    okButton:setReflectPos(258, 212)
    okButton:computePosition()
    ConfirmDialogBg:addChild(okButton)
    okButton:setName("okButton")
    self.okButton = okButton

    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no1_0.png", "ui_btn_no1_2.png", "ui_btn_no1_2.png", {x=0, y=0})
    cancelBtn._clickScale = false
    cancelBtn._baseline = 1
    cancelBtn:setReflectPos(55, 212)
    cancelBtn:computePosition()
    ConfirmDialogBg:addChild(cancelBtn)
    cancelBtn:setName("cancelBtn")
    self.cancelBtn = cancelBtn

    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    contentBg:setReflectPos(29, 35)
    contentBg:setReflectSize(370, 127)
    contentBg:computePosition()
    ConfirmDialogBg:addChild(contentBg)
    contentBg:setName("contentBg")
    self.contentBg = contentBg

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:setReflectSize(370, 2)
    contentTopLine:computePosition()
    contentBg:addChild(contentTopLine)
    contentTopLine:setName("contentTopLine")
    self.contentTopLine = contentTopLine

    if type(self.text) == "string" then 
        local contentLabel = UI.RichText:create()
        local success = contentLabel:init(self.text, 354, 120, false)
        if success then
            contentLabel:centerUp(4)
            contentLabel:enableDebugDraw()
            contentBg:addChild(contentLabel)
            contentLabel:setName("contentLabel")
            self.contentLabel = contentLabel
        end
    else
        self.contentLabel = self.text
        self.contentLabel:centerUp(4)
        contentBg:addChild(self.contentLabel)
        self.contentLabel:setName("contentLabel")
    end

    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png", {x=0, y=0})
    confirmButton._clickScale = false
    confirmButton._baseline = 1
    confirmButton:setReflectPos(0, 212)
    confirmButton:computePosition()
    ConfirmDialogBg:addChild(confirmButton)
    confirmButton:setName("confirmButton")
    self.confirmButton = confirmButton

    self.cancelBtn:setVisible(self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE);
    self.okButton:setVisible(self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE)
    if(self.dialogType == ConfirmType.CONFIRM_ONLY or self.dialogType == ConfirmType.CONFIRM_ONLY_RED) then 
        self.confirmButton:setVisible(true)
    else
        self.confirmButton:setVisible(false)
    end

    if self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE then
        self.cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.cancel)
        self.okButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.ok)
    elseif self.dialogType == ConfirmType.CONFIRM_ONLY then
        self.confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.confirm)
    elseif self.dialogType == ConfirmType.CONFIRM_ONLY_RED then
        self.confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.confirm)
    end
    if self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE then
        self.okButton:setNormal("ui_btn_yes1_0.png")
        self.okButton:setSelected("ui_btn_yes1_2.png")

        self.cancelBtn:setNormal("ui_btn_no1_1.png")
        self.cancelBtn:setSelected("ui_btn_no1_2.png")
    elseif (self.dialogType == ConfirmType.CONFIRM_ONLY_RED) then 
        self.confirmButton:setNormal("ui_btn_no1_1.png")
        self.confirmButton:setSelected("ui_btn_no1_2.png")
    end

    -- 显示不再提示的选择框
    if self.showNoMoreKey then
        self.showSelectPanel = UI.Layout:create()
        self.showSelectPanel:init()
        self.showSelectPanel:setSize(200, 80)
        self.showSelectPanel:centerBottom(60)
        ConfirmDialogBg:addChild(self.showSelectPanel, 10)

        local choiceLogo = UI.Image:create()
        choiceLogo:init("ui_btn_choice_1.png")
        choiceLogo:center()
        choiceLogo:hide()
        self.choiceLogo = choiceLogo

        local choiceButton = UI.Button:create()
        choiceButton:init("ui_btn_choice_0.png","ui_btn_choice_0.png","ui_btn_choice_0.png")
        choiceButton:leftBottom(565, 10)
        choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self.choiceLogo:setVisible(not self.choiceLogo:isVisible())
        end)
        self.showSelectPanel:addChild(choiceButton)
        choiceButton:addChild(choiceLogo, 10)
        choiceButton:setScale(0.88)

        local text = UI.Text:create()
        text:init(UI.TEXT_1212210, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        text:center()
        self.showSelectPanel:addChild(text)
        local left = (self.showSelectPanel:getContentSize().width - choiceButton:getContentSize().width - text:getContentSize().width - 10) / 2
        choiceButton:centerLeft(left)
        text:centerLeft(left + choiceButton:getContentSize().width + 5)
    end
end

function ConfirmRichDialog:getConfirmButton()
    return self.confirmButton
end

function ConfirmRichDialog:getCancelButton()
    return self.cancelBtn
end

function ConfirmRichDialog:getContentLabel()
    return self.contentLabel
end

function ConfirmRichDialog:onTouchOutSide()
    if not self.isModelDialog then
        self:dispatchEvent(UIEvent.DIALOG_OUT_SIDE, self)
        self:closeDialog()
    end
end

function ConfirmRichDialog:cancel()
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

function ConfirmRichDialog:ok()
    local isVisible = false
    if self.choiceLogo then
        isVisible = self.choiceLogo:isVisible()
    end
    if self.okCallback then
        self.okCallback(isVisible)
    else
        self:dispatchEvent(UIEvent.DIALOG_CONFIRM, self)
    end

    if self.showNoMoreKey and self.choiceLogo:isVisible() then
        cc.UserDefault:getInstance():setBoolForKey(tostring(self.showNoMoreKey), false)
    end

    if self.closeDialog then
        self:closeDialog()
    end
end

function ConfirmRichDialog:confirm()
    local isVisible = false
    if self.choiceLogo then
        isVisible = self.choiceLogo:isVisible()
    end
    if self.okCallback then
        self.okCallback(isVisible)
    else
        self:dispatchEvent(UIEvent.DIALOG_CONFIRM, self)
    end
    if self.closeDialog then
        self:closeDialog()
    end
end

function ConfirmRichDialog:closeDialog()
    self:removeFromParent()
end

function ConfirmRichDialog:setModelDialog(model)
    self.isModelDialog = model
end

-- text             ：显示文本
-- okCallback       ：ok按钮回调
-- cancelCallback   ：cancel按钮回调
-- showNoMoreKey    : 显示不再提示选择框，值为本地记录的key值
function ConfirmRichDialog.show(text, okCallback, cancelCallback, type, showNoMoreKey, autoAdd)
    local dialog = ConfirmRichDialog:create()
    dialog:init(text, okCallback, cancelCallback, type, showNoMoreKey)
    dialog:center()
    if autoAdd == nil or autoAdd == true then
        UI.UIManager:getRootNode():addChild(dialog, UI_ZORDER.TIPS)
    end

    return dialog
end