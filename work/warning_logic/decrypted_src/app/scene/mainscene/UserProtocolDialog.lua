-- UserProtocolDialog.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡选择 

local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")
require "app.ui.common.Tab.TabList"
UI = UI or {}

local UserProtocolDialog = class("UserProtocolDialog", UI.DownShowWin)
UI.UserProtocolDialog = UserProtocolDialog

local model = require("app.uiExport.UserProtocolModel")


-- 资源列表(必备)
local COM_RES_LIST = {
    [1] = "ui_general_notice.plist",
    [2] = "ui_common_btn.plist"
}

local TAB_ID = {
    USER_PROTOCOL = 1,
    PRIVATE_PROTOCOL = 2
}

local STRING_KEY = {
    USER_PROTOCOL_CONTENT = 1,
    USER_PROTOCOL_VERSION = 2,
    PRIVATE_PROTOCOL_CONTENT = 3,
    READ_NOTICE = 4,
    PROTOCOL_NAME = 5,
    SAFE_NOTICE = 6,
}

local READ_STATUS = {
    NOT_READ = 0,
    READ_COMPLETE = 1
}

local scrollViewWidth = 0;
local scrollViewHeight = 0;
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

UI.UserProtocolDialog.READ_STATUS = READ_STATUS
UI.UserProtocolDialog.STRING_KEY = STRING_KEY

UI.UserProtocolDialog.UIType = {
    UserProtocol = 1,   --用户协议
    Disclaimer = 2,     --免责声明
}
--构造函数(必备)
function UserProtocolDialog:ctor(uiType)
	--窗口大小
    UserProtocolDialog.super.ctor(
    self,
    UIType.USER_PROTOCOL_DIALOG,
    COM_RES_LIST,
    winSize.width,	
    winSize.height
    )
    self.isShowPrivate = not SdkBox:getInstance():isSupportPrivacy()--如果sdk 支持，那就需要调用sdk的api展现， 这里就不需要展现
    self.uiType = uiType or UI.UserProtocolDialog.UIType.UserProtocol
    if self.uiType == UI.UserProtocolDialog.UIType.Disclaimer then
        self.disclaimerData = require("profiles.dataProfile.ProfileClientDisclaimer")
    end
    self.rootLayer = nil;           --root节点
    self.selectedProtocolId = TAB_ID.USER_PROTOCOL;

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
    self:center(0, -10)
end

--虚构函数,destroy时调用(必备)
function UserProtocolDialog:dtor()
    UserProtocolDialog.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function UserProtocolDialog:init()
    UserProtocolDialog.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function UserProtocolDialog:onInitView()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local versionTarget = SdkBox:getInstance():getVersionTarget()
    self.readStatus = cc.UserDefault:getInstance():getIntegerForKey(UserProtocolDialog.getReadStatusKey(), READ_STATUS.NOT_READ)
    --self.readStatus = 0

    self.noticeModel = model.create("Notice")
    self.noticeModel.root:center();
    self:addChild(self.noticeModel.root)

    self.noticeModel.buttonLayer:setVisible(true);
    
    self:initTitle();

    self:initUserButton();
    self:InitScrollView();
end

function UserProtocolDialog:initTitle()
    if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
        self:layoutTitleBg(not self.isShowPrivate)
        if self.isShowPrivate then
            self:initOutSeaTitle();
        end
    else
        self:layoutTitleBg(true)
        self.noticeModel.noticeTitle:setText(self.disclaimerData[1].language);
    end
end

function UserProtocolDialog:layoutTitleBg(show)
    self.noticeModel.noticeContentTitleBg:setVisible(show)
    if show then
        local width = self.noticeModel.noticeContentTitle._width
        width = width + 70
        self.noticeModel.noticeContentTitleBg:setSize(width, self.noticeModel.noticeContentTitleBg._height)
    end
end

-- 海外版标题
function UserProtocolDialog:initOutSeaTitle()
    
    local TAB_ICON = "ui_general_notice_but_label2.png"
    local TAB_SELECT_ICON = "ui_general_notice_but_label1.png"

    local buttonXPos = 130;
    local buttonYPos = 89

    local tabList = UI.TabList:create()
    tabList:init(-1, 210, 37)
    tabList:leftUp(buttonXPos, buttonYPos)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.HORIZONTAL, LayoutFloatType.FLOAT_LEFT)
    self.tabList = tabList
    local tab = UI.TabItem:create()
    tab:init(TAB_ICON, TAB_SELECT_ICON)
    tab:setChangeScale(false)
    tabList:addToTab(tab, TAB_ID.USER_PROTOCOL)

    local text = UI.Text:create()
    text:init(LanguageManager:getInstance():getLocalString(1111299), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    text:center()
    tab:addChild(text)

    tab = UI.TabItem:create()
    tab:init(TAB_ICON, TAB_SELECT_ICON)
    tab:setChangeScale(false)
    tabList:addToTab(tab, TAB_ID.PRIVATE_PROTOCOL)

    text = UI.Text:create()
    text:init(LanguageManager:getInstance():getLocalString(1111300), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    text:center()
    tab:addChild(text)

    self.noticeModel.root:addChild(tabList, 100)

end

function UserProtocolDialog:changedActivePanel(index)
    if self.tabList then
        self.tabList:showPanelByTabIndex(index)
    end
end


function UserProtocolDialog:initUserButton()

    self.agreeButton = self.noticeModel.okButton
    self.agreeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:agree(true)
    end)

    self.cancelButton = self.noticeModel.cancelButton
    self.cancelButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.buttonDisableClicked)
    self.cancelButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
            self:agree(false)
        else
            self:refuse()
        end
    end)

    self.confirmButton = self.noticeModel.confrimButton
    self.confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:closeDialog()
    end)
    if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
        self.agreeButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.buttonDisableClicked)
        self.agreeButton:setVisible(self.readStatus == READ_STATUS.NOT_READ)
        self.cancelButton:setVisible(self.readStatus == READ_STATUS.NOT_READ)
        self.confirmButton:setVisible(self.readStatus == READ_STATUS.READ_COMPLETE)
    else
        self.agreeButton:setVisible(true)
        self.cancelButton:setVisible(true)
        self.confirmButton:setVisible(false)
    end
end

function UserProtocolDialog:createContentNode(type)
    local node = UI.Component:create()
    node:init();

    local blank = 0;
    local yPos = 0;

    for i = 0, 10, 1 do
        local strId = type;
        if i ~= 0 then
            strId = type * 100 + i
        end
        local str = LanguageManager:getInstance():getProtocolString(strId);
        if str ~= nil then
            local label = self:createLabel(str, i)
            label:leftUp(0, yPos);
            node:addChild(label)
            yPos = yPos + label._height + blank
        end
    end
    node:setSize(scrollViewWidth, yPos)
    return node;
end

function UserProtocolDialog:createLabel(str)
    local color = {r = 41,g = 41, b = 45}
    local label = UI.Text:create()
    label:init("", UI.FONT_ARIAL, UI.FONT_SIZE_18PX, color)
    label._label:setDimensions(scrollViewWidth, 0)
    label:setText(str)
    label:setTextLeftUp()
    local size = label._label:getContentSize()
    UI.Text.super.setSize(label, size.width, size.height)
    return label;
end

function UserProtocolDialog:InitScrollView()
    local contentLayer = self.noticeModel.contentLayer;
    scrollViewWidth = contentLayer._width
    scrollViewHeight = contentLayer._height

    if self.selectedProtocolId == TAB_ID.USER_PROTOCOL then
        if self.leftScrollView == nil then
            self.leftScrollView = UI.ScrollView:create()
            self.leftScrollView:setSize(scrollViewWidth, scrollViewHeight)
            self.leftScrollView:init(0, 0, 0, 0)
            --self.leftScrollView:center(0, -16)
            self.leftScrollView:createCustomScrollBar(nil, 1, UI.SLIDER_COLOR_Dark)
            contentLayer:addChild(self.leftScrollView)
            self.leftScrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, function (_, _1, pre)
                if self.isShowPrivate and pre == 1 and self.readStatus == READ_STATUS.NOT_READ then
                    self.agreeButton:enable()
                    self.cancelButton:enable()
                    self:updateReadeadComplete();
                end
            end)
            local node = nil;
            if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
                node = self:createContentNode(STRING_KEY.USER_PROTOCOL_CONTENT)
            else
                node = self:createLabel(self.disclaimerData[2].language);
            end
            self.leftScrollView:addInnerNode(node)
        end
    else
        if self.rightScrollView == nil then
            self.rightScrollView = UI.ScrollView:create()
            self.rightScrollView:setSize(scrollViewWidth, scrollViewHeight)
            self.rightScrollView:init(0, 0, 0, 0)
            --self.rightScrollView:center(0, -16)
            self.rightScrollView:createCustomScrollBar(nil, nil, UI.SLIDER_COLOR_Dark)
            contentLayer:addChild(self.rightScrollView)
            local node = self:createContentNode(STRING_KEY.PRIVATE_PROTOCOL_CONTENT)
            self.rightScrollView:addInnerNode(node)
            self.rightScrollView:updateView()
        end
    end

    if self.leftScrollView then
        self.leftScrollView:setVisible(self.selectedProtocolId == TAB_ID.USER_PROTOCOL)
    end
    if self.rightScrollView then
        self.rightScrollView:setVisible(self.selectedProtocolId == TAB_ID.PRIVATE_PROTOCOL)
    end
end

function UserProtocolDialog:updateReadeadComplete()
    if self.readStatus == READ_STATUS.NOT_READ then
        local currentVersion = LanguageManager:getInstance():getProtocolString(STRING_KEY.USER_PROTOCOL_VERSION)
        cc.UserDefault:getInstance():setIntegerForKey(UserProtocolDialog.getReadStatusKey(), READ_STATUS.READ_COMPLETE)
        cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.UserProtocolVersion, currentVersion)
        cc.UserDefault:getInstance():flush()
    end
end

function UserProtocolDialog:buttonDisableClicked()
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111305))
end

function UserProtocolDialog:agree(status)
    print("agree:", self.uiType)
    if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
        Avalon.MessageCenter:notice(GameMessage.MC_READ_USER_PROTOCOL_COMPLEATE, status)
        if (status == false) then
            UserProtocolDialog.trySendRecord(status)
        end
        UserProtocolDialog.saveAllowStatus(status)
        self:updateReadeadComplete()
    end
    self:closeDialog()
end

function UserProtocolDialog:refuse()
    print("refuse:", self.uiType)
    if self.uiType == UI.UserProtocolDialog.UIType.UserProtocol then
        self:closeDialog()
    else
        local confirmDialog = UI.ConfirmDialog.show(self.disclaimerData[3].language, function()
            -- ok
            SdkBox:getInstance():logout()
        end)
        confirmDialog:setLocalZOrder(100001)
    end
end


-- 模版函数：更新组建的视图(必备)
function UserProtocolDialog:onUpdateView()

end

function UserProtocolDialog:closeDialog( ... )
    self:closeWin()
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
end

-- 注册监听事件(可选)
function UserProtocolDialog:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end

-- 注销监听事件(可选)
function UserProtocolDialog:unRegisterListener()
end

function UserProtocolDialog:onActiveTabHandler(tabIndex, tabLastIndex)
    self.selectedProtocolId = tabIndex;
    self:InitScrollView();
end

function UserProtocolDialog.checkVersionChanged()
    local changed = true
    local readVersion = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.UserProtocolVersion, "")
    local currentVersion = LanguageManager:getInstance():getProtocolString(STRING_KEY.USER_PROTOCOL_VERSION)
    print("readVersion = ", readVersion, ", currentVersion = ", currentVersion);
    if readVersion == currentVersion then
        changed = false;
    end
    return changed
end

function UserProtocolDialog.trySendRecord(agreeUserProtocol)
    UserProtocolDialog.saveAllowStatus(agreeUserProtocol)
    local gameLoginManager = require("app.game.GameLoginManager")
    if agreeUserProtocol then
        if not UserProtocolDialog.alreadySendUserProtocolRecord() then
            gameLoginManager:getInstance():reportLoginStep(PublicDefine.LoginLogType.User_Agreement, 0, nil, 1, true)
            cc.UserDefault:getInstance():setIntegerForKey(UserProtocolDialog.getKey(), 1)
            cc.UserDefault:getInstance():flush()
        end
    else
        local account = ServerConfigUtil:getPlayerID()
        account = account or ""
        local keyStr = "notAgreeRecord" .. tostring(account)
        local key = cc.UserDefault:getInstance():getIntegerForKey(keyStr, 0)
        if key == 0 then
            gameLoginManager:getInstance():reportLoginStep(PublicDefine.LoginLogType.User_Agreement, 0, nil, 0, true)
            cc.UserDefault:getInstance():setIntegerForKey(keyStr, 1)
            cc.UserDefault:getInstance():flush()
        end
    end
end

function UserProtocolDialog.getKey()
    local currentVersion = LanguageManager:getInstance():getProtocolString(STRING_KEY.USER_PROTOCOL_VERSION)
    local account = ServerConfigUtil:getPlayerID()
    account = account or "";
    local key = UserDefaultKeyWord.alreadySendUserProtocolRecord .. tostring(account) .. tostring(currentVersion)
    return key
end

function UserProtocolDialog.getAllowKey()
    local currentVersion = LanguageManager:getInstance():getProtocolString(STRING_KEY.USER_PROTOCOL_VERSION)
    local account = ServerConfigUtil:getPlayerID()
    account = account or ""
    local key = UserDefaultKeyWord.AllowUserProtocolStatus .. tostring(account) .. tostring(currentVersion)
    return key
end

function UserProtocolDialog.getReadStatusKey()
    local currentVersion = LanguageManager:getInstance():getProtocolString(STRING_KEY.USER_PROTOCOL_VERSION)
    local account = ServerConfigUtil:getPlayerID()
    account = account or ""
    local key = UserDefaultKeyWord.ReadUserProtocol .. tostring(account) .. tostring(currentVersion)
    return key
end

function UserProtocolDialog.alreadySendUserProtocolRecord()
    local value = cc.UserDefault:getInstance():getIntegerForKey(UserProtocolDialog.getKey(), 0)
    local send = value == 1;
    return send
end

function UserProtocolDialog.saveAllowStatus(allow)
   cc.UserDefault:getInstance():setIntegerForKey(UserProtocolDialog.getAllowKey(), allow and 1 or 0)
   cc.UserDefault:getInstance():flush()
end

function UserProtocolDialog.gaveAllowStatus()
    local key = cc.UserDefault:getInstance():getIntegerForKey(UserProtocolDialog.getAllowKey(), 0)
    return key == 1;
end

function UserProtocolDialog.getReadStatus()
    local key = cc.UserDefault:getInstance():getIntegerForKey(UserProtocolDialog.getReadStatusKey(), READ_STATUS.NOT_READ)
    return key == 1
end

function UserProtocolDialog:showUserProtocolDialog()
    self:open(self.noticeModel.root, true)
end

