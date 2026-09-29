-- ConfirmDialog.lua
-- Author:liujun
-- 2018年9月17日
-- Using:确认对话框

UI = UI or {}

local model = require("app.uiExport.ConfirmDialogModel")

local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist"
}
local ConfirmDialog = class("ConfirmDialog", UI.HWBtnComponent)
UI.ConfirmDialog = ConfirmDialog

ConfirmType = {
    CONFIRM_ONLY = 1,
    OK_AND_CANCEL = 2,
    CANCEL_RED_OK_WHITE = 3, -- 取消红色, 确定白色
    CONFIRM_ONLY_RED = 4,    -- 仅有按钮，表现未红色     
    OK_AND_CANCEL_WITH_TEXT = 5,    -- 按钮带字     
}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local INT_MAX = 2147483647;

function ConfirmDialog:ctor()
    ConfirmDialog.super.ctor(self, UIType.CONFIRM_DIALOG, COM_RES_LIST, winSize.width, winSize.height)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSide)

    self.dialogType = ConfirmType.OK_AND_CANCEL
    self.isModelDialog = true;
end

function ConfirmDialog:dtor()
end

function ConfirmDialog:init(text, okCallback, cancelCallback, forwardNode, type)
    self.dialogType = type or ConfirmType.OK_AND_CANCEL
    self.text = text or ""
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback;
    self.forwardNode = forwardNode;
    ConfirmDialog.super.init(self)
end

-- 初始化视图
function ConfirmDialog:onInitView()
    if self.dialogType == ConfirmType.OK_AND_CANCEL_WITH_TEXT then
        self.ConfirmDialogModel = model.create("ConfirmDialogBtnWithText")
    else
        self.ConfirmDialogModel = model.create("ConfirmDialog")
    end
    
    
    self.rootLayer = self.ConfirmDialogModel.root
    self.rootLayer:center()
    self:setSize(self.rootLayer._width, self.rootLayer._height);

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)
    if type(self.text) == "table" then
        local leaveHeight = 120

        local firstText = self.ConfirmDialogModel.contentLabel
        firstText:setText(self.text[1]);
        leaveHeight = leaveHeight - firstText:getContentSize().height
        
        local text1 = nil
        if self.text[2] then
            text1 = UI.Text:create()
            text1:init(self.text[2], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_102_0_0)
            text1:setWidth(330)
            text1:setTextCenter()
            firstText:getParent():addChild(text1)
            leaveHeight = leaveHeight - text1:getContentSize().height
        end
        
        local text2 = nil
        if self.text[3] then
            text2 = UI.Text:create()
            text2:init(self.text[3], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
            text2:setWidth(330)
            text2:setTextCenter()
            firstText:getParent():addChild(text2)
            leaveHeight = leaveHeight - text2:getContentSize().height
        end

        local up = leaveHeight / 2
        firstText:centerUp(up)
        up = up + firstText:getContentSize().height
        if text1 then
            text1:centerUp(up)
            up = up + text1:getContentSize().height
        end
        if text2 then
            text2:centerUp(up)
        end
    else
        self.ConfirmDialogModel.contentLabel:setText(self.text);
    end
    self:addChild(self.rootLayer)

    self.ConfirmDialogModel.cancelBtn:setVisible(self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE or self.dialogType == ConfirmType.OK_AND_CANCEL_WITH_TEXT);
    self.ConfirmDialogModel.okButton:setVisible(self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE or self.dialogType == ConfirmType.OK_AND_CANCEL_WITH_TEXT)
    if(self.dialogType == ConfirmType.CONFIRM_ONLY or self.dialogType == ConfirmType.CONFIRM_ONLY_RED) then 
        self.ConfirmDialogModel.confirmButton:setVisible(true)
    else 
        self.ConfirmDialogModel.confirmButton:setVisible(false)
    end

    if self.dialogType == ConfirmType.OK_AND_CANCEL or self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE or self.dialogType == ConfirmType.OK_AND_CANCEL_WITH_TEXT then
        self.ConfirmDialogModel.cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.cancel)
        self.ConfirmDialogModel.okButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.ok)
    elseif self.dialogType == ConfirmType.CONFIRM_ONLY then
        self.ConfirmDialogModel.confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.confirm)
    elseif self.dialogType == ConfirmType.CONFIRM_ONLY_RED then
        self.ConfirmDialogModel.confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.confirm)
    end
    if self.dialogType == ConfirmType.CANCEL_RED_OK_WHITE then
        self.ConfirmDialogModel.okButton:setNormal("ui_btn_yes1_0.png")
        self.ConfirmDialogModel.okButton:setSelected("ui_btn_yes1_2.png")

        self.ConfirmDialogModel.cancelBtn:setNormal("ui_btn_no1_1.png")
        self.ConfirmDialogModel.cancelBtn:setSelected("ui_btn_no1_2.png")
    elseif (self.dialogType == ConfirmType.CONFIRM_ONLY_RED) then 
        self.ConfirmDialogModel.confirmButton:setNormal("ui_btn_no1_1.png")
        self.ConfirmDialogModel.confirmButton:setSelected("ui_btn_no1_2.png")
    end 
end

function ConfirmDialog:getConfirmButton()
    return self.ConfirmDialogModel.confirmButton
end

function ConfirmDialog:getCancelButton()
    return self.ConfirmDialogModel.cancelBtn
end

function ConfirmDialog:showSelectBtn()
    if self.showSelectPanel == nil then
        self.showSelectPanel = UI.Layout:create()
        self.showSelectPanel:init()
        self.showSelectPanel:setSize(200, 80)
        self.showSelectPanel:centerBottom(60)
        self:addChild(self.showSelectPanel, 10)

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

function ConfirmDialog:showDiamonCost(costNumber, isShowSelect, isRight)
    if not isRight then
        self.ConfirmDialogModel.contentLabel:center()
        self.ConfirmDialogModel.contentLabel:computePosition()
    end
    
    local costPanel =  UI.Layout:create()
    costPanel:init()

    local width = 0
    local costLabel = UI.Text:create()
    costLabel:init(UI.TEXT_1170025, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    width = width + costLabel:getContentSize().width

    local useItemIcon = UI.Image:create()
    useItemIcon:init("symbol_gaming_diamond.png")
    width = width + useItemIcon:getContentSize().width

    local costLabelNum = UI.Text:create()
    costLabelNum:init(costNumber.."", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    width = width + useItemIcon:getContentSize().width
    costPanel:setSize(width + 20, 30)

    costPanel:addChild(costLabel)
    costLabel:centerLeft(0)

    costPanel:addChild(useItemIcon)
    useItemIcon:centerLeft(costLabel:getContentSize().width + 10)

    costPanel:addChild(costLabelNum)
    costLabelNum:centerLeft(costLabel:getContentSize().width + useItemIcon:getContentSize().width + 20)
    if isShowSelect == true then
        costPanel:centerUp(95)
    else
        costPanel:centerUp(135)
    end
    if isRight then
        costPanel:leftUp(225, 150)
    end
    self.ConfirmDialogModel.contentBg:addChild(costPanel, 10)
end

function ConfirmDialog:onTouchOutSide()
    if not self.isModelDialog then
        self:dispatchEvent(UIEvent.DIALOG_OUT_SIDE, self)
        self:closeDialog()
    end
end

function ConfirmDialog:cancel()
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

function ConfirmDialog:ok()
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

function ConfirmDialog:confirm()
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

function ConfirmDialog:closeDialog()
    if not tolua.isnull(self.forwardNode) then
        self.forwardNode:setVisible(true)
        self.forwardNode:resume();
    end
    self:removeFromParent();
end

function ConfirmDialog:setModelDialog(model)
    self.isModelDialog = model
end

function ConfirmDialog:updateContent(text)
    if(text and not tolua.isnull(self)) then 
        self.text = text
        self.ConfirmDialogModel.contentLabel:setText(text);
    end
end

function ConfirmDialog:setContentFontName(fontName, fontsize)
    fontName = fontName or UI.SYS_FONT
    self.ConfirmDialogModel.contentLabel:setFontName(fontName)
    if fontsize ~= nil then
        self.ConfirmDialogModel.contentLabel:setFontSize(fontsize)
    end
    self.ConfirmDialogModel.contentLabel:setText(self.text)
end




-- text             ：显示文本
-- okCallback       ：ok按钮回调
-- cancelCallback   ：cancel按钮回调
-- forwardNode      ：可以隐藏前一级的node，在dialog关闭的时候会将其再次显示
function ConfirmDialog.show(text, okCallback, cancelCallback, forwardNode, type, autoAdd, isShowSelect, costDiamondNum)
    local dialog = ConfirmDialog:create();
    dialog:init(text, okCallback, cancelCallback, forwardNode, type);
    dialog:center();
    if autoAdd == nil or autoAdd == true then
        UI.UIManager:getRootNode():addChild(dialog, UI_ZORDER.TIPS)
    end

    if forwardNode then
        forwardNode:setVisible(false)
        forwardNode:pause();
    end
    if isShowSelect then
        dialog:showSelectBtn()
    end
    if costDiamondNum and tonumber(costDiamondNum) > 0 then
        dialog:showDiamonCost(costDiamondNum, isShowSelect)
    end
    return dialog;
end

function ConfirmDialog.showConfirmDialogCancelRedOkWhite(text, okCallback, cancelCallback, forwardNode, autoAdd, isShowSelect, costDiamondNum)
    return ConfirmDialog.show(text, okCallback, cancelCallback, forwardNode, ConfirmType.CANCEL_RED_OK_WHITE, autoAdd, isShowSelect, costDiamondNum)
end

function ConfirmDialog.showConfirmDialogCancelWhiteOkRed(text, okCallback, cancelCallback, forwardNode, autoAdd, isShowSelect, costDiamondNum)
    return ConfirmDialog.show(text, okCallback, cancelCallback, forwardNode, ConfirmType.OK_AND_CANCEL, autoAdd, isShowSelect, costDiamondNum)
end

function ConfirmDialog.showConfrimOnly(text, okCallback, cancelCallback, forwardNode, autoAdd)
    return ConfirmDialog.show(text, okCallback, cancelCallback, forwardNode, ConfirmType.CONFIRM_ONLY, autoAdd)
end

function ConfirmDialog.showConfrimOnlyShowRed(text, okCallback, cancelCallback, forwardNode, autoAdd)
    return ConfirmDialog.show(text, okCallback, cancelCallback, forwardNode, ConfirmType.CONFIRM_ONLY_RED, autoAdd)
end

function ConfirmDialog.showConfirmDialogCancelRedOkWhiteAndTexts(texts, okCallback, cancelCallback, forwardNode, autoAdd, isShowSelect, costDiamondNum)
    return ConfirmDialog.show(texts, okCallback, cancelCallback, forwardNode, ConfirmType.CANCEL_RED_OK_WHITE, autoAdd, isShowSelect, costDiamondNum)
end