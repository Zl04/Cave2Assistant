-- SettingsLayer.lua
-- Author:CMonk
-- 2018年12月10日

require "app.ui.common.CheckBox"
require "app.ui.common.Slider"
require "app.ui.common.ControlSwitchStyleTwo"
require "app.ui.UIDefine"
require "app.ui.settingsLayer.GameSettingsPanel"
require "app.ui.settingsLayer.DisplaySettingsPanel"
require "app.ui.settingsLayer.HomeSettingsPanel"
require "app.ui.settingsLayer.CustomHQPanel"
local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}
local SettingsLayer = class("SettingsLayer", UI.CenterWin)
UI.SettingsLayer = SettingsLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local CONTENT_ZORDER = 1

--资源列表(必备)
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_package_setup.plist",
    "ui_common_scale9image.plist",
}

-- 标签信息
local TAB_DATA = {
    [1] = {             -- 游戏设置标签
        index = 1,
        tabUIType = UI.Type.SETTINGS_BASIC_TAB,
        text = LanguageManager:getInstance():getLocalString(1111468), --"游戏设置"
        isToDisplayFunc = function(self, thisData) return true end,
        getNewContentLayout = function(self, thisData)
            local content = UI.GameSettingsPanel:create()
            content:init(self._bg:getSize())
            return content 
        end,
    },    
    [2] = {             -- 显示设置标签
        index = 2,
        tabUIType = UI.Type.SETTINGS_ADVANCED_TAB,
        text = LanguageManager:getInstance():getLocalString(1111469), --"显示设置"
        isToDisplayFunc = function(self, thisData) return UI.DisplaySettingsPanel:getShowComponentCount() > 0 end,
        getNewContentLayout = function(self, thisData)
            local content = UI.DisplaySettingsPanel:create()
            content:init(self._bg:getSize())
            return content
        end,
    },       
    [3] = {             -- 图像设置标签
        index = 3,
        tabUIType = UI.Type.SETTINGS_HQ_TAB,
        text = UI.TEXT_1213781, --"图像设置"
        isToDisplayFunc = function(self, thisData) return true end,
        getNewContentLayout = function(self, thisData)
            local content = UI.CustomHQPanel:create()
            content:init(self._bg:getSize())
            return content
        end,
    },
    [4] = {             -- 社区标签
        index = 4,
        tabUIType = UI.Type.SETTINGS_COMMUNITY_TAB,
        text = LanguageManager:getInstance():getLocalString(1111612), --"社区"
        isToDisplayFunc = function(self, thisData) return UI.HomeSettingsPanel:getShowComponentCount() > 0 end,
        getNewContentLayout = function(self, thisData)
            local content = UI.HomeSettingsPanel:create()
            content:init(self._bg:getSize())
            return content
        end,
    },      
}


--构造函数(必备)
function SettingsLayer:ctor()
    SettingsLayer.super.ctor(
        self, 
        UIType.SETTINGS_BASIC_PANEL,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0
    )
    self._cachedPanels = {}
    self._callbackList = {}
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:init()
    self:open()
end


--虚构函数, destroy时调用(必备)
function SettingsLayer:dtor()
    SettingsLayer.super.dtor(self)
    self:unregisterListener()
    -- reload_script_file("app.ui.settingsLayer.SettingsLayer")
end

-- 初始化(必备)
function SettingsLayer:init()
    SettingsLayer.super.init(self)

    -- 设置默认显示页面
    self:showContentPanelByIndex(1)
end

-- 模版函数：初始化组建的视图(必备)
function SettingsLayer:onInitView()
    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self._rootLayer:center()
    self:addChild(self._rootLayer)

    -- 背景
    self._bg = UI.Image:create()
    self._bg:init("ui_setup_bg.png")
    self._bg:center()
    self._rootLayer:addChild(self._bg)
    self:setSize(self._bg:getSize())

    -- 标题栏 背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_setup_title.png")
    titleBg:leftBottom(793, 514)
    self._bg:addChild(titleBg)

    -- 标题栏 文字
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_DES_SETTING, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_41_41_45)
    titleText:center(-35, -3)
    titleBg:addChild(titleText)

    -- 标签锚点
    local tabListLayout = UI.Layout:create()
    tabListLayout:init()
    tabListLayout:enableAutoHeight()
    tabListLayout:enableAutoWidth()
    tabListLayout:setTouchEnable(true)
    tabListLayout:leftBottom(108, 522)
    self._bg:addChild(tabListLayout)

    -- 标签内容
    self._tabList = {}
    for i,v in ipairs(self:getTabData()) do
        if (v.isToDisplayFunc(self, v)) then
            local tab = UI.Button:create(v.tabUIType)
            tab:init("ui_setup_mark_2.png", "ui_setup_mark_1.png", "ui_setup_mark_2.png")
            tab:floatLeft(-1)
            tab:closeClickScale()
            tab:setText(v.text)
            tab:setTag(i)
            tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            tab:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:showContentPanelByIndex(tab:getTag())
            end)

            -- 加入列表
            tabListLayout:addComponent(tab)
            table.insert(self._tabList, tab)
        end
    end

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(826, 2))
    splitLine:centerBottom(521)
    self._bg:addChild(splitLine)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(826, 2))
    splitLine:centerBottom(163)
    self._bg:addChild(splitLine)

    -- 第一排按钮布局
    local row1Layout = UI.Layout:create()
    row1Layout:init(-80, 0, 0, 0)
    row1Layout:enableAutoWidth()
    row1Layout:enableAutoHeight()
    row1Layout:centerBottom(106)
    self._bg:addChild(row1Layout)

    -- 绑定账号
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_111157)
    yellowButton:floatLeft(80)
    yellowButton:setVisible(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL)
    row1Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
    end)

    -- 个人信息收集清单
    if not SceneManager:getInstance():isInFightScene() then
        local yellowButton = UI.Button:create()
        yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
        yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        yellowButton:setText(UI.TEXT_1111300)
        yellowButton:floatLeft(80)
        row1Layout:addComponent(yellowButton)
        yellowButton:addEventListener(
            UIEvent.BUTTON_CLICK,
            self,
            function()
                if SdkBox:getInstance():isSupportPrivacyCollection() then
                    SdkBox:getInstance():showSdkPrivacyCollection()
                else
                    local userProDialog = UI.UserProtocolDialog:create()
                    self:getParent():addChild(userProDialog, 100000)
                    userProDialog:showUserProtocolDialog()
                end
            end
        )
        -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if
            (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or
                versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE)
         then
            if
                (channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING or
                    channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE)
             then
                yellowButton:show()
            else
                yellowButton:hide()
            end
        else
            yellowButton:hide()
        end
    end

    -- 联系客服
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_1150026)
    yellowButton:floatLeft(80)
    row1Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local heroData = RoleDataManager:getMaster()
        local gameLoginManager = require("app.game.GameLoginManager")
        local params = {}
        params.roleId = RoleDataManager:getMasterPK()
        params.roleName = heroData:getNickName()
        params.roleLevel = tostring(heroData:getLevel())
        params.zoneId = tostring(gameLoginManager:getInstance():getServerId())
        params.zoneName = tostring(gameLoginManager:getInstance():getServerId())
        if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
            SdkBox:getInstance():helper(params)
        elseif (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL ) then
            SdkBox:getInstance():helper(params)
        else --走浏览器 
            local SdkManager = require("app.game.SdkManager")
            SdkManager:getInstance():openCSWeb(params.roleId, params.roleName, params.roleLevel, params.zoneId)
        end 
    end)
    -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)
    if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or 
        versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) 
    then
        if (channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING or 
            channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE)
        then
            yellowButton:show()
        else
            yellowButton:hide()
        end
    else
        yellowButton:show()
    end

    -- 第三方SDK收集信息清单
    if not SceneManager:getInstance():isInFightScene() then
        local yellowButton = UI.Button:create()
        yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
        yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        yellowButton:setText(UI.TEXT_1111301)
        yellowButton:floatLeft(80)
        row1Layout:addComponent(yellowButton)
        yellowButton:addEventListener(
            UIEvent.BUTTON_CLICK,
            self,
            function()
                if SdkBox:getInstance():isSupportThirdpartyCollection() then
                    SdkBox:getInstance():showSdkThirdpartyCollection()
                else
                    local userProDialog = UI.UserProtocolDialog:create()
                    self:getParent():addChild(userProDialog, 100000)
                    userProDialog:showUserProtocolDialog()
                end
            end
        )
        -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if
            (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or
                versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE)
         then
            if
                (channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING or
                    channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE)
             then
                yellowButton:show()
            else
                yellowButton:hide()
            end
        else
            yellowButton:hide()
        end
    end

    -- 返回城镇
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_111031)
    yellowButton:floatLeft(80)
    --local SceneManager = require("app.game.SceneManager")
    yellowButton:setVisible(
        not SceneManager:getInstance():isInStory() and
            (SceneManager:getInstance():isInCave() or SceneManager:getInstance():isInDungeon() or
                SceneManager:getInstance():isInHero() or
                SceneManager:getInstance():isInDream() or
                SceneManager:getInstance():isWorldBossCave() or
                SceneManager:getInstance():isGuildBoss() or
                SceneManager:getInstance():isGhostAbyss() or
                SceneManager:getInstance():isDesertEyesCave() or
                SceneManager:getInstance():isDistortedSpaceCave() or
                SceneManager:getInstance():isInMaze() or
                SceneManager:getInstance():isInHitRat() or
                SceneManager:getInstance():isInEaster() or
                SceneManager:getInstance():isInHuLu() or
                SceneManager:getInstance():isInPuzzle() or
                SceneManager:getInstance():isInInferno() or
                SceneManager:getInstance():isInVoidRift() or 
                SceneManager:getInstance():isInTrialLand() or
                SceneManager:getInstance():isInViKing() or
                SceneManager:getInstance():isInEverWinter() or
                SceneManager:getInstance():isTitanRoad() or
                SceneManager:getInstance():isInTitanHero() or 
                SceneManager:getInstance():isDriedSpring() or
                SceneManager:getInstance():isInExp() or
                SceneManager:getInstance():isChaosWormHole() or
                SceneManager:getInstance():isInWormhole() )
    )
    row1Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BACK_TOWN_UI, BACK_TOWN_TYPE.BACK_TOWN_TYPE_SETTING, function(closeWin)
            if(not tolua.isnull(self)) then 
                if(closeWin) then 
                    self:closeWin()
                end
            end
        end)
    end)


    -- 第二排按钮布局
    local row2Layout = UI.Layout:create()
    row2Layout:init(-80, 0, 0, 0)
    row2Layout:enableAutoWidth()
    row2Layout:enableAutoHeight()
    row2Layout:centerBottom(49)
    self._bg:addChild(row2Layout)

    -- 用户协议
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_1111299)
    yellowButton:floatLeft(80)
    row2Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if SdkBox:getInstance():isSupportLicense() then
            SdkBox:getInstance():showSdkLicense()
        else
            local userProDialog = UI.UserProtocolDialog:create()
            self:getParent():addChild(userProDialog, 100000)
            userProDialog:showUserProtocolDialog()
        end
    end)


    -- 隐私声明协议
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(LanguageManager:getInstance():getLocalString(1111300))
    yellowButton:floatLeft(80)
    row2Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if SdkBox:getInstance():isSupportPrivacy() then
            SdkBox:getInstance():showSdkPrivacy()
        else
            local userProDialog = UI.UserProtocolDialog:create();   
            UI.UIManager:getRootNode():addChild(userProDialog, 100000)
            userProDialog:showUserProtocolDialog();
            userProDialog:changedActivePanel(2)
        end
    end)

    -- 退出登录
    local yellowButton = UI.Button:create() 
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_111124)
    yellowButton:floatLeft(80)
    row2Layout:addComponent(yellowButton)
    yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_111125, function()
            SdkBox:getInstance():logout()
        end)
    end)
end

-- 模版函数：更新组建的视图(必备)
function SettingsLayer:onUpdateView()
end

-- 隐藏面板
function SettingsLayer:hidePanel(panelToHide)
    if (panelToHide.setPanelActive) then panelToHide:setPanelActive(false) end
    panelToHide:leftBottom(-winSize.width, -winSize.height)
end

-- 显示面板
function SettingsLayer:showPanel(panelToShow)
    if (panelToShow.setPanelActive) then panelToShow:setPanelActive(true) end
    panelToShow:center()
    panelToShow:updateView()
end

-- 获取或者新建一个面板, 总之搞一个面板进缓存并藏起来
function SettingsLayer:getOrBuildPanel(idx)
    local panel = self._cachedPanels[idx]
    if (panel == nil) then
        local currentData = self:getTabData()[idx]
        panel = currentData.getNewContentLayout(self, currentData)
        self._cachedPanels[idx] = panel
        self._bg:addChild(panel, CONTENT_ZORDER)
    end
    self:hidePanel(panel)
    return panel
end

-- 换一个面板展现
function SettingsLayer:showContentPanelByIndex(idx)
    -- 展现标签
    for i, w in ipairs(self._tabList) do
        if (w:getTag() ~= idx) then 
            w:release() 
        else
            w:press(false)
        end
    end

    -- 过滤相同标签点击逻辑
    if (self._showingPanelIdx == idx) then return end

    -- 隐藏现在显示的页面
    if (self._showingPanelIdx ~= nil) then
        self:hidePanel(self:getOrBuildPanel(self._showingPanelIdx))
    end
    
    -- 显示选择的页面
    local panelToShow = self:getOrBuildPanel(idx)
    self:showPanel(panelToShow)
    self._showingPanelIdx = idx
end




-- 获取TAB数据的方法
function SettingsLayer:getTabData()
    return TAB_DATA
end






-- 事件处理 --
---------------------------------------
-- 登出失败
function SettingsLayer:onSdkLogoutFail(params)
    
end

-- 登出成功
function SettingsLayer:onSdkLogoutSuccess(params)
    -- 切换场景之前调用destroy 以免切换场景之后异步释放造成的奇怪问题
    if self.close then
        self:close()
    end
end

function SettingsLayer:registerListener()
    SdkBox:getInstance():onSdkLogoutSuccess(handler(self,self.onSdkLogoutSuccess))
    SdkBox:getInstance():onSdkLogoutFail(handler(self,self.onSdkLogoutFail))
end

function SettingsLayer:unregisterListener()
    SdkBox:getInstance():onSdkLogoutSuccess(nil)
    SdkBox:getInstance():onSdkLogoutFail(nil)
end
---------------------------------------
-- eo 事件处理 --
