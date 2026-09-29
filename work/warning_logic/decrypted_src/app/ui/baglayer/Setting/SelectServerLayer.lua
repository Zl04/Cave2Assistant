--
-- Author: yueyingsong
-- Date: 2017-11-13 15:34:09
-- 选择服务器


local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
require("app.ui.common.ControlSwitch")
require("app.utils.ServerConfigUtil")
UI = UI or {}

local SelectServerLayer = class("SelectServerLayer", UI.HWBtnComponent)
UI.SelectServerLayer = SelectServerLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸

-- 背包资源
local COM_RES_LIST = {
    "ui_package_setup.plist"
}


-- 构造函数
function SelectServerLayer:ctor()
    SelectServerLayer.super.ctor(self, UIType.SELECT_SERVER_LAYER, COM_RES_LIST, 525, 305)

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
end

-- 析构函数
function SelectServerLayer:dtor()
    print("SelectServerLayer:dtor")
    SelectServerLayer.super.dtor(self)

    self:unRegisterListener();
end

-- 初始化
function SelectServerLayer:init(logData)
    self._logData = logData
    SelectServerLayer.super.init(self)
end


-- 初始化视图
function SelectServerLayer:onInitView()
    print("SelectServerLayer:onInitView")
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(525, 305))
    self:addChild(self.rootLayer)


    local bg = cc.Sprite:create()
    bg:setSpriteFrame("ui_setup_banner_box.png")
    bg:setAnchorPoint(cc.p(0,0))
    bg:setPosition(0,0)
    self.rootLayer:addChild(bg)

    local supportLanguages = SdkBox:getInstance():getSupportLanguages()
    -- local serverCfg = ConfigManager:getServerListByTarget(CAVEOL_TARGET)
    local serverCfg = ServerConfigUtil:getServerList()
    local userData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    local curServerId = 0
    if userData then
    	curServerId = userData:getServerId()
    end
    -- supportLanguages = {0,1}
    -- dump(supportLanguages)
    table.sort(serverCfg,function(a,b)
        if a.id == curServerId then
            return true
        end

        if b.id == curServerId then
            return false
        end 
        return a.id < b.id
    end)

    local contentHeight = 280
    local size =  math.ceil(#serverCfg / 2)
    if size * 80 + 40 > contentHeight then
        contentHeight = size * 80 + 40
    end

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(480, contentHeight)

    for i = 1,#serverCfg do
        local btnLanguage = UI.Button:create()
        if curServerId == serverCfg[i].id then
            btnLanguage:init("ui_setup_button_language_1.png",
                "ui_setup_button_language_1.png")
        else
            btnLanguage:init("ui_setup_button_language_0.png",
                "ui_setup_button_language_1.png")
        end

        btnLanguage:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSelectLanguage)
        btnLanguage:setTag(serverCfg[i].id)
        btnLanguage._serverName = serverCfg[i].name

        local cellSize = 2
        local indexX = (i - 1) % cellSize
        local indexY = math.floor((i - 1) / cellSize)
        btnLanguage:leftUp(60 + indexX * 200, 40 + indexY * 80)
        contentLayout:addChild(btnLanguage)

        local textLanguage = UI.Text:create()
        textLanguage:init(serverCfg[i].name, UI.SYS_FONT, 20, UI.FONT_COLOR_41_41_45)
        textLanguage:setDimensions(163, 0)
        textLanguage:center()
        textLanguage:setTextCenter()
        btnLanguage:addChild(textLanguage,100)
    end

    local languageScrollView = UI.ScrollView:create()
    languageScrollView:setSize(490, 280)
    languageScrollView:init(0, 0, 0, 0)
    languageScrollView:center()
    languageScrollView:addInnerNode(contentLayout)
    self.rootLayer:addChild(languageScrollView)
end



-- 更新视图
function SelectServerLayer:onUpdateView()
end

-- 点击回到城镇
function SelectServerLayer:onSelectLanguage(obj)
    print("obj:getTag()",obj:getTag())
    
    local curServerId = ServerConfigUtil:getSavedCurrentCfgId()
    

    
    if obj:getTag() == curServerId then
        self:close()
        return
    end

    local pSelectLanguageTips = UI.Tips:createTips(UI.TEXT_111153,
        UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
    pSelectLanguageTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        local canChange = true
        canChange = mvc.worldBossModel:checkCanEnterOther()  -- 如果 worldboss 已报名，提醒一次
        canChange = mvc.festivalModel:checkCanEnterOther()  -- 节日活动已报名，提醒一次
        if canChange then
            ServerConfigUtil:setCurrentCfgById(obj:getTag())
            self:close()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SELECT_SERVER_SUCCESS,obj:getTag())
        else
            UI.ScrollBar:createByText(UI.TEXT_1212663)
        end
    end)

end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    self:close()
end

-- 注册监听事件(可选)
function SelectServerLayer:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end


-- 注销监听事件(可选)
function SelectServerLayer:unRegisterListener()
end


