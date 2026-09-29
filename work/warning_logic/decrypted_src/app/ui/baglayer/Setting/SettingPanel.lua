-- -- SettingPanel.lua
-- -- Author:zp
-- -- 2017年5月2日
-- -- Using:设置界面
-- local GameDataManager = require("app.game.GameDataManager")
-- local SceneManager = require("app.game.SceneManager")
-- local LanguageManager = require("app.game.LanguageManager")
-- local SdkBox = require("utils.sdkbox.SdkBox")
-- local ProtobufUtil = require("utils.ProtobufUtil")
-- local SdkManager = require("app.game.SdkManager")
-- local bit = require("bit")

-- require "app.utils.ScreenRecordUtil"
-- require "app.utils.ServerConfigUtil"
-- require "app.ui.common.ControlSwitch"
-- require "app.ui.guild.createOrJoin.LoadingPanel"
-- require "app.ui.baglayer.Setting.BindAccount"
-- require "app.ui.UIManager"

-- UI = UI or {}

-- local SettingPanel = class("SettingPanel", UI.HWBtnComponent)
-- UI.SettingPanel = SettingPanel

-- -- private:
-- local winSize = cc.Director:getInstance():getWinSize()
-- local DEBUG = false
-- local DEBUG_DRAW = false

-- -- 尺寸
-- local COM_WIDTH = 1024
-- local COM_HEIGHT = 568
-- -- 背包资源
-- local COM_RES_LIST = {  
--     "ui_package_setup.plist", 
-- }

-- -- 图片名字
-- local SETTING_PANEL_SPRITE = {
--     BUTTON_BACKTOWN_NORMAL = "ui_btn_yellow5_0.png",
--     BUTTON_BACKTOWN_ACTIVE = "ui_btn_yellow5_1.png",
--     BUTTON_BACKTOWN_DISABLE = "ui_btn_yellow5_2.png"
-- }

-- local startHeight = 478
-- local switchBtnStartY = 30
-- local startX1 = 725
-- local startX2 = 290
-- local switchBtnStartX2 = startX2
-- local labelBlank = 30
-- local buttonYOffset = 2;
-- local itemOffset = cc.p(startX2 - startX1, 82)

-- -- 构造函数
-- function SettingPanel:ctor()
--     SettingPanel.super.ctor(self, UIType.BAG_SETTING_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    
    
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SELECT_SERVER_SUCCESS,self,self.onSelectServerSuccess)
--     Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SETTING_CHANGE_TOWNCHANNEL,self,self.onChangeTownChannel)
    
--     self._changeTownChannelTime = AvalonUtil:getCurrentTime()

--     -- 
--     self._moveLabel = nil
    
-- end

-- -- 析构函数
-- function SettingPanel:dtor()
--     -- print("SettingPanel:dtor")
--     SettingPanel.super.dtor(self)
    
--     self._moveLabel = nil
--     Avalon.Scheduler:unscheduleUpdate(self, self._scheduleEnd)
    
    
--     Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SELECT_SERVER_SUCCESS,self,self.onSelectServerSuccess)
--     Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SETTING_CHANGE_TOWNCHANNEL,self,self.onChangeTownChannel)

--     -- 关闭设置界面时发出操作方式更新消息
--     Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)

--     Avalon.AudioManager:saveMusicVolume()
--     Avalon.AudioManager:saveSoundsVolume()

--     UI.UIManager:setUIRestoreButtonCallback(nil)
-- end

-- -- 初始化
-- function SettingPanel:init(logData)
--     self._logData = logData

--     SettingPanel.super.init(self)
-- end


-- -- 初始化视图
-- function SettingPanel:onInitView()
--     --音乐, 音效

--     local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
--     bg:setContentSize(942, 534)
--     bg:setCapInsets(CCRectMake(0, 0, 303, 217))
--     bg:setPosition(cc.p(488, 275))
--     self:addChild(bg)
--     self.bg = bg

--     local detailedScrollView = UI.ScrollView:create()
--     detailedScrollView:setSize(870, 400)
--     detailedScrollView:init(0, 0, 0, 0)
--     detailedScrollView:leftUp(20, 30)
--     bg:addChild(detailedScrollView)

--     self.content = UI.Component:create();
--     self.content:init();
--     self.content:setSize(detailedScrollView._width, 500)

--     local buttonOffset = cc.p(0, buttonYOffset)
--     local nodeOffset = cc.p(2, 3)
--     local nodeOffset2 = cc.p(0, -4)
--     local titleYOffset1 = 5
--     local titleYOffset2 = 0
--     local titleYOffset3 = 1
--     local index = 3

--     local nodeOffset = cc.p(1, 1)
--     self:createShowHelmet(self:calculateSwitchBtnPosByIndex(1), nodeOffset)

--     -- 帧率模式
--     self:createFrameModel(self:calculateSwitchBtnPosByIndex(2), nodeOffset)

--     self:createHideWall(self:calculateSwitchBtnPosByIndex(3), nodeOffset)

--     local isIos = (device.platform == "ios")
--     -- isIos = true
--     -- 录屏组件
--     if (isIos) then
--         index = 5
        
--         self:createChatModel(self:calculateSwitchBtnPosByIndex(4), nodeOffset)
--         --显示UI
--         self:createHideUI(self:calculateSwitchBtnPosByIndex(6), nodeOffset)
--         -- 录像
--         self:createScreenRecorde(self:calculateSwitchBtnPosByIndex(5), nodeOffset)
--     else
--         index = 5
--         --屏蔽聊天
--         self:createChatModel(self:calculateSwitchBtnPosByIndex(4), nodeOffset)
--         --显示UI
--         self:createHideUI(self:calculateSwitchBtnPosByIndex(6), nodeOffset)
--     end

--     --音乐
--     self:createMusicControl(self:calculatePosByIndex(index))

--     --音效
--     index = index + 1
--     self:createSoundControl(self:calculatePosByIndex(index))

--     --语言
--     index = index + 1
--     self:createLanguageButton(index, buttonOffset, titleYOffset1)
    
--     --选择服务器
--     index = index + 1
--     self:createChooseServer(index, buttonOffset, titleYOffset1)

--     --用户协议
--     index = index + 1
--     self:createUserProtocolButton(index, buttonOffset, titleYOffset3)

--     --血量显示
--     index = index + 2
--     self:createLifeShowModel(index, nodeOffset, titleYOffset2)

--     index = index + 1
--     -- 操作方式
--     self:createMoveTypeModel(index, nodeOffset, titleYOffset2)
    
--     -- 切换频道
--     if SceneManager:getInstance():isInTown() then
--         index = index + 1
--         self:createSwitchChannel(index, cc.p(8, 0), titleYOffset2)
--     end

--     self.content:setSize(detailedScrollView._width, switchBtnStartY + math.ceil(index / 2) * itemOffset.y ) 

--     detailedScrollView:addInnerNode(self.content)

--     local mask = cc.Sprite:createWithSpriteFrameName("ui_4package_mask2.png")
--     mask:setAnchorPoint(cc.p(0.5, 0));
--     mask:setPosition(cc.p(bg:getContentSize().width / 2, 100))
--     bg:addChild(mask)

--     local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
--     splitLine:setContentSize(900, 2)
--     splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
--     splitLine:setPosition(cc.p(bg:getContentSize().width / 2, 100))
--     bg:addChild(splitLine)

--     --底部按钮区域
--     self:createBottomPanle()
    
--     SdkBox:getInstance():onSdkLogoutSuccess(handler(self,self.onSdkLogoutSuccess))
--     SdkBox:getInstance():onSdkLogoutFail(handler(self,self.onSdkLogoutFail))

--     -- 加载动画效果
--     local loadingPanel = UI.LoadingPanel:create()
--     loadingPanel:centerBottom(187+60)
--     self:addChild(loadingPanel, 100)
--     self._loading = loadingPanel
--     self._loading:setVisible(false)
-- end

-- function SettingPanel:createBottomStyleButton(parent, buttonIndex, str, blank)
--     local btn = UI.Button:create()
--     btn:init(SETTING_PANEL_SPRITE.BUTTON_BACKTOWN_NORMAL, SETTING_PANEL_SPRITE.BUTTON_BACKTOWN_ACTIVE, SETTING_PANEL_SPRITE.BUTTON_BACKTOWN_DISABLE)

--     local xPos = (buttonIndex - 1) * (btn:getContentSize().width + blank)

--     btn:leftUp(xPos, 0)

--     local text = UI.Text:create()
--     text:init(str, UI.FONT_BOLD)
--     text:setFontSize(UI.FONT_SIZE_18PX)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     text:center(0, 1)
--     btn:addChild(text, 100)
--     parent:addChild(btn)
--     return btn
-- end

-- function SettingPanel:createBottomPanle()
    
--     local index = 1
--     local blank = 20
--     local node = UI.Component:create();
--     node:init()

--     --退出登录
--     local btnLogout = self:createBottomStyleButton(node, index, UI.TEXT_111124, blank)
--     btnLogout:addEventListener(UIEvent.BUTTON_CLICK, self, self.onLogout)

--     local size = btnLogout:getContentSize();

--     --联系客服
--     index = index + 1
--     local btnCustomerService = self:createBottomStyleButton(node, index, UI.TEXT_1150026, blank)
--     btnCustomerService:addEventListener(UIEvent.BUTTON_CLICK, self, self.onCustomerService)

--     -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
--     local versionTarget = SdkBox:getInstance():getVersionTarget()
--     local channel = SdkBox:getInstance():getVersionChannel()
--     channel = checkint(channel)
--     if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
--         if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
--         or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
--         or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
--         then
--             btnCustomerService:show()
--         else
--             btnCustomerService:hide()
--             index = index - 1
--         end
--     else
--         btnCustomerService:show()
--     end

--     -- 绑定账号按钮
--     if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL --[[and SdkBox:getInstance():getVersionAccount() == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST]] then
--         index = index + 1
--         local bindAccountBtn = self:createBottomStyleButton(node, index, UI.TEXT_111157, blank)
--         bindAccountBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBindAccount)
--     end

--     -- 返回城镇按钮
--     if SceneManager:getInstance():isInCave() 
--         or SceneManager:getInstance():isInDungeon()
--         or SceneManager:getInstance():isInHero()
--         or SceneManager:getInstance():isInDream() 
--         -- or SceneManager:getInstance():isWorldBossCave() 
--         or SceneManager:getInstance():isGuildBoss()
--         or SceneManager:getInstance():isDesertEyesCave()
--         or SceneManager:getInstance():isDistortedSpaceCave()
--         or SceneManager:getInstance():isActCave()
--     then
--         index = index + 1
--         local btnBackTown = self:createBottomStyleButton(node, index, UI.TEXT_111031, blank)
--         btnBackTown:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickBackTown)
--     end

--     local width = index * size.width + (index - 1) * blank
--     node:setSize(width, size.height)
--     node:centerBottom(40)
--     self.bg:addChild(node)

-- end

-- function SettingPanel:calculatePosByIndex(index)
--     local startPos = cc.p(startX1, switchBtnStartY)
--     local row =  math.ceil(index / 2) - 1
--     local column = index % 2
--     column = column == 0 and 1 or column - 1
--     local pos = cc.p(startPos.x + column * itemOffset.x, startPos.y + row * itemOffset.y )
--     return pos
-- end

-- function SettingPanel:calculateSwitchBtnPosByIndex(index)
--     local startPos = cc.p(startX1, switchBtnStartY)
--     local row = 1
--     local column = index % 2
--     local posX =  604
--     if index == 2 then
--         posX = 35
--     elseif index == 3 then
--         posX = 320
--     elseif index == 4 then
--         startPos.y = startPos.y + itemOffset.y
--     elseif index == 5 then
--         posX = 35
--         startPos.y = startPos.y + itemOffset.y
--     elseif index == 6 then
--         posX = 320
--         startPos.y = startPos.y + itemOffset.y
--     end
--     local pos = cc.p(posX, startPos.y)
--     return pos
-- end

-- function SettingPanel:createItemNew(index, str, node, nodeOffset, titleYOffset, baseOffset)
--     titleYOffset = titleYOffset or 0    
--     baseOffset = baseOffset or cc.p(0, 0)
--     nodeOffset = nodeOffset or cc.p(0, 0)
--     local text = UI.Text:create()
--     text:init(str, UI.FONT_STANDARD)
--     text:setFontSize(18)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     if type(index) == "number" then
--         local pos = self:calculatePosByIndex(index)
--         text:rightUp(pos.x + baseOffset.x, pos.y + baseOffset.y)
--     else
--         text:rightUp(index.x + baseOffset.x, index.y + baseOffset.y)
--     end

--     self.content:addChild(text)
--     node:centerLeft(text._width + labelBlank + nodeOffset.x, nodeOffset.y)
--     text:addChild(node)
-- end

-- function SettingPanel:createItem(index, str, node, nodeOffset, titleYOffset)
--     titleYOffset = titleYOffset or 0    

--     nodeOffset = nodeOffset or cc.p(0, 0)
--     local text = UI.Text:create()
--     text:init(str, UI.FONT_STANDARD)
--     text:setFontSize(18)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     if type(index) == "number" then
--         local pos = self:calculatePosByIndex(index)
--         text:rightUp(pos.x, pos.y)
--     else
--         text:rightUp(index.x, index.y)
--     end

--     self.content:addChild(text)
--     node:centerLeft(text._width + labelBlank + nodeOffset.x, nodeOffset.y)
--     text:addChild(node)
-- end

-- function SettingPanel:createSwitch(pos, str, node, nodeOffset, titleYOffset)
--     nodeOffset = nodeOffset or cc.p(0, 0)
--     local text = UI.Text:create()
--     text:init(str, UI.FONT_STANDARD)
--     text:setFontSize(18)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     text:centerBottom(40)

--     node:rightUp(pos.x, pos.y)

--     self.content:addChild(node)
--     --node:centerLeft(text._width + labelBlank + nodeOffset.x, nodeOffset.y)
--     node:addChild(text)
-- end

-- function SettingPanel:createControlMoveTypeSwitchButton(text)
--     local textList = {}
--     for i = 1,#text do
--         local txtTitle = cc.Label:createWithTTF(text[i], UI.FONT_STANDARD, 18)
--         txtTitle:setTextColor(UI.FONT_COLOR_50_50_44)
--         table.insert(textList,txtTitle)
--     end

--     local maskSprite = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg.png")
--     maskSprite:setCapInsets(CCRectMake(1,0,1,1))
--     maskSprite:setContentSize(300, 27)
--     -- lineUpImage:setPosition(cc.p(lineX, 183))
--     -- local maskSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg.png")
--     local thumbSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_button_0.png")

--     local pControlSwitch = UI.ControlSwitch:create()
--     pControlSwitch:init(maskSprite, thumbSprite, textList, 300, maskSprite:getContentSize().height)
--     pControlSwitch:adapterTowButton()
--     return pControlSwitch
-- end

-- function SettingPanel:createControlSwitchButton(text)
--     local textList = {}
--     for i = 1,#text do
--         local txtTitle = cc.Label:createWithTTF(text[i], UI.FONT_STANDARD, 18)
--         txtTitle:setTextColor(UI.FONT_COLOR_50_50_44)
--         table.insert(textList,txtTitle)
--     end
--     local maskSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg.png")
--     local thumbSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_button_0.png")

--     local pControlSwitch = UI.ControlSwitch:create()
--     pControlSwitch:init(maskSprite, thumbSprite, textList, maskSprite:getContentSize().width, maskSprite:getContentSize().height)
--     pControlSwitch:adapterTowButton()
--     return pControlSwitch
-- end

-- function SettingPanel:createButtonText(parent, str, zOrder)
--     zOrder = zOrder or 100
--     local textLanguage = UI.Text:create()
--     textLanguage:init(str, UI.FONT_BOLD)
--     textLanguage:setFontSize(UI.FONT_SIZE_18PX)
--     textLanguage:setFontColor(UI.FONT_COLOR_50_50_44)
--     textLanguage:center(0, 1)
--     parent:addChild(textLanguage, zOrder)
-- end

-- function SettingPanel:createLanguageButton(index, nodeOffset, titleYOffset)
--     local btnLanguage = UI.Button:create()
--     btnLanguage:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png")
--     btnLanguage:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSelectLanguage)
--     self:createButtonText(btnLanguage, LanguageManager:getInstance():getLocalString(1220000 + LanguageManager:getInstance():getLanguage()), 100)
--     self:createItem(index, UI.TEXT_111119, btnLanguage, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createChooseServer(index, nodeOffset, titleYOffset)
--     local btnSelectServer = UI.Button:create()
--     btnSelectServer:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png")
--     btnSelectServer:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSelectServer)
--     self:createButtonText(btnSelectServer, ServerConfigUtil:getName() or UI.TEXT_111138, 100)
--     self:createItem(index, UI.TEXT_111138, btnSelectServer, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createShowHelmet(pos, nodeOffset, titleYOffset)

--     local pControlSwitchShowHelmet = UI.SwitchButton:create()
--     pControlSwitchShowHelmet:init(not RoleDataManager:getMaster():getIsHideHelmet(), "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitchShowHelmet:setStateChangeCallBack(function(open)
--         if not open then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Helmet,
--                 PublicDefine.Config_Helmet_Hidden.Show,
--                 PublicDefine.Config_Helmet_Hidden.Hidden
                
--             )
--             Net.NetRoleSystem:requestHideHelmet(true)
--             UI.ScrollBar:createByText(UI.TEXT_111129)
--         else
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Helmet,
--                 PublicDefine.Config_Helmet_Hidden.Hidden,
--                 PublicDefine.Config_Helmet_Hidden.Show
--             )

--             Net.NetRoleSystem:requestHideHelmet(false)
--             UI.ScrollBar:createByText(UI.TEXT_111130)
--         end
--     end)

--     self:createSwitch(pos, UI.TEXT_111115, pControlSwitchShowHelmet, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createScreenRecorde(index, nodeOffset, titleYOffset)
--     local pControlSwitch = UI.SwitchButton:create()
--     local oldNum = ScreenRecordUtil:getInstance():getRecorderOn()
--     pControlSwitch:init(oldNum, "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitch:setStateChangeCallBack(function(open)
--         ScreenRecordUtil:getInstance():setRecorderOn(open, function(isSucc, errorCode) 
--             if (not isSucc) then
--                 pControlSwitch:setSwitchStatus(oldNum)
--                 local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
--                 UI.ScrollBar:createByText(errorString)
--             end
--         end)
--     end)
--     self:createSwitch(index, LanguageManager:getInstance():getLocalString(1111246), pControlSwitch, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createLifeShowModel(index, nodeOffset, titleYOffset)
--     local text = {UI.TEXT_111121,UI.TEXT_111122,UI.TEXT_111123}
--     local pControlSwitch = self:createControlSwitchButton(text)
--     pControlSwitch:setValue(GameManager:getRoleInfoShowType())
--     pControlSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, self, function(obj,num)
        
--         if(num == 1) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
--                 GameManager:getRoleInfoShowType(),
--                 ShowType.NONE
--             )
--             GameManager:setRoleInfoShowType(ShowType.NONE)
--             UI.ScrollBar:createByText(UI.TEXT_111135)
--         elseif (num == 2) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
--                 GameManager:getRoleInfoShowType(),
--                 ShowType.PERCENT
--             )
--             GameManager:setRoleInfoShowType(ShowType.PERCENT)
--             UI.ScrollBar:createByText(UI.TEXT_111136)
--         elseif (num == 3) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
--                 GameManager:getRoleInfoShowType(),
--                 ShowType.VALUE
--             )
--             GameManager:setRoleInfoShowType(ShowType.VALUE)
--             UI.ScrollBar:createByText(UI.TEXT_111137)
--         else
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
--                 GameManager:getRoleInfoShowType(),
--                 ShowType.NONE
--             )
--             GameManager:setRoleInfoShowType(ShowType.NONE)
--         end
--     end)
--     self:createItem(index, UI.TEXT_111120, pControlSwitch, nodeOffset, titleYOffset)
-- end


-- function SettingPanel:createMoveTypeModel(index, nodeOffset, titleYOffset)
--     local text = {UI.TEXT_1212036, UI.TEXT_111118, UI.TEXT_111117, LanguageManager:getInstance():getLocalString(1111562)}
--     local pControlSwitch = self:createControlMoveTypeSwitchButton(text)
--     pControlSwitch:setValue(GameManager:getMoveType())
--     pControlSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, self, function(obj,num)
--         if(num == 1) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
--                 GameManager:getMoveType(),
--                 MoveType.ALL
--             )
--             GameManager:setMoveType(MoveType.ALL)
--             UI.UIManager:setHideScreenSaveControlType(MoveType.ALL)
--             UI.ScrollBar:createByText(UI.TEXT_1212035)
--         elseif (num == 2) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
--                 GameManager:getMoveType(),
--                 MoveType.CLICK
--             )
--             GameManager:setMoveType(MoveType.CLICK)
--             UI.UIManager:setHideScreenSaveControlType(MoveType.CLICK)
--             UI.ScrollBar:createByText(UI.TEXT_111132)
--         elseif (num == 3) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
--                 GameManager:getMoveType(),
--                 MoveType.CONTROLLER
--             )
--             GameManager:setMoveType(MoveType.CONTROLLER)
--             UI.UIManager:setHideScreenSaveControlType(MoveType.CONTROLLER)
--             UI.ScrollBar:createByText(UI.TEXT_111131)
--         elseif (num == 4) then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
--                 GameManager:getMoveType(),
--                 MoveType.NORMAL
--             )
--             GameManager:setMoveType(MoveType.NORMAL)
--             UI.UIManager:setHideScreenSaveControlType(MoveType.CONTROLLER)
--             UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111563))
--         else
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
--                 GameManager:getMoveType(),
--                 MoveType.ALL
--             )
--             GameManager:setMoveType(MoveType.ALL)
--             UI.UIManager:setHideScreenSaveControlType(MoveType.ALL)
--         end
--     end)
--     self:createItemNew(index, UI.TEXT_111116, pControlSwitch, nodeOffset, titleYOffset, cc.p(74, 0))
-- end

-- function SettingPanel:createFrameModel(index, nodeOffset, titleYOffset)
--     local pControlSwitch = UI.SwitchButton:create()
--     pControlSwitch:init(GameManager:getFps() == 60, "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitch:setStateChangeCallBack(function(open)
--         if(not open) then
--             UI.ScrollBar:createByText(UI.TEXT_111160)
--             GameManager:setFps(30)
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_FPS,
--                 60,
--                 30
--             )
--         else
--             UI.ScrollBar:createByText(UI.TEXT_111160)
--             GameManager:setFps(60)
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_FPS,
--                 30,
--                 60
--             )
--         end
--     end)
--     self:createSwitch(index, UI.TEXT_111159, pControlSwitch, nodeOffset, titleYOffset)
-- end


-- function SettingPanel:createChatModel(index, nodeOffset, titleYOffset)

--     local pControlSwitch = UI.SwitchButton:create()
--     pControlSwitch:init(GameManager:getShieldChat(), "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitch:setStateChangeCallBack(function(open)
--         if not open then
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Chat,
--                 PublicDefine.Config_Chat_Block.Open,
--                 PublicDefine.Config_Chat_Block.Close
--             )
            
--             GameManager:setShieldChat(false)
--             UI.ScrollBar:createByText(UI.TEXT_111134)
--         else
--             SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--                 PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Chat,
--                 PublicDefine.Config_Chat_Block.Close,
--                 PublicDefine.Config_Chat_Block.Open
--             )
--             GameManager:setShieldChat(true)
--             UI.ScrollBar:createByText(UI.TEXT_111133)
--         end
--     end)
--     self:createSwitch(index, UI.TEXT_111112, pControlSwitch, nodeOffset, titleYOffset)
-- end
-- -- 隐藏墙体
-- function SettingPanel:createHideWall(index, nodeOffset, titleYOffset)
--     local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, AvalonUtil.getIdentifier())
--     local isHide = false
--     if globalUserData then
--         isHide = globalUserData:isHideWall()
--     end
--     local pControlSwitch = UI.SwitchButton:create()
--     pControlSwitch:init(isHide, "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitch:setStateChangeCallBack(function()
--         if globalUserData then
--             isHide = globalUserData:isHideWall()
--         end
--         if isHide then
--             if globalUserData then
--                 globalUserData:hideWall(not isHide)
--                 Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
--             end
--             UI.ScrollBar:createByText(UI.TEXT_111164)
--             return false
--         else
--             if globalUserData then
--                 globalUserData:hideWall(not isHide)
--                 Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
--             end
--             UI.ScrollBar:createByText(UI.TEXT_111165)
            
--             return true
--         end
        
--     end)
   
--     self:createSwitch(index, UI.TEXT_111163, pControlSwitch, nodeOffset, titleYOffset)
-- end
-- function SettingPanel:createHideUI(index, nodeOffset, titleYOffset)
--     local pControlSwitch = UI.SwitchButton:create()
--     pControlSwitch:init(UI.UIManager:checkIsShowMainUI(), "ui_setup_progressbar_box.png", "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
--     pControlSwitch:setBeforeStateChangeCallBack(function()
--         if UI.UIManager:checkIsShowMainUI() then
--             UI.ConfirmDialog.show(UI.TEXT_1212039, function()
--                 pControlSwitch:setSwitchStatus(false)
--                 UI.UIManager:setShowMainUI(false)
--                 UI.UIManager:setHideScreenSaveControlType(GameManager:getMoveType())
--                 GameManager:setMoveType(MoveType.CLICK, false)
--                 UI.ScrollBar:createByText(UI.TEXT_1212041)
--             end)
--             return false
--         else
--             UI.UIManager:setShowMainUI(true)
--             UI.ScrollBar:createByText(UI.TEXT_1212042)
--             return true
--         end
--     end)
--     UI.UIManager:setUIRestoreButtonCallback(function()
--         pControlSwitch:setSwitchStatus(true)
--         UI.ScrollBar:createByText(UI.TEXT_1212042)
--     end)
--     self:createSwitch(index, UI.TEXT_1212038, pControlSwitch, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createSwitchChannel(index, nodeOffset, titleYOffset)
--     local cha = -38
--     local size = {width = 213, height = 27}
--     --  切换频道输入框 ui_setup_progressbar_01
--     local node = UI.Component:create();
--     node:init()
--     node:setSize(size.width, size.height)

--     local bgMask = UI.Image9:create()
--     bgMask:init("ui_setup_button_switchbox.png", CCRectMake(0, 0, 50, 50))
--     bgMask:setReflectSize(224, 44)
--     bgMask:centerLeft(-5)
--     node:addChild(bgMask)
    

--     local changeTownChannelEdit = cc.EditBox:create(size, "ui_setup_control_bar_bg.png")
--     local maskSprite = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg.png")
--     maskSprite:setCapInsets(cc.rect(8,9,4,1));

--     -- changeTownChannelEdit:initWithSizeAndBackgroundSprite(size, maskSprite)
--     changeTownChannelEdit:setFontSize(18)
--     changeTownChannelEdit:setFontName(UI.FONT_STANDARD)
--     -- changeTownChannelEdit:setPlaceHolder(UI.TEXT_1170939)
--     changeTownChannelEdit:setInputMode(cc.EDITBOX_INPUT_MODE_DECIMAL)
--     changeTownChannelEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
--     changeTownChannelEdit:setPlaceholderFontSize(18)
--     changeTownChannelEdit:setAnchorPoint(0, 0)
--     changeTownChannelEdit:setFontColor(UI.FONT_COLOR_50_50_44)

--     local masterData = GameDataManager:getInstance():getMaster()
--     if(masterData) then
--         changeTownChannelEdit:setText(tostring(self:splitChannel(masterData:getTownChannelID())))
--     else 
--         changeTownChannelEdit:setText("")
--     end
--     changeTownChannelEdit:setMaxLength(10)
--     node:addChild(changeTownChannelEdit)

--     -- 切换按钮
--     local changeTownButton = UI.Button:create()
--     changeTownButton:init("ui_setup_button_switch_0.png", "ui_setup_button_switch_1.png")
--     changeTownButton:centerRight(0, -1)
--     changeTownButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
--         -- body
--         -- 处理请求切换
--         local text = self:mergeChannel(changeTownChannelEdit:getText())
--         if(text) then
--             if text == "" then 
--                 -- 输入格式不对
--                 local tips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111284), UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL) --AvalonUtil.getIdentifier()
--                 tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            
--                 end)
--             else 
--                 if(masterData) then
--                     if(tonumber(text) == masterData:getTownChannelID()) then
--                         --  你已经在该频道了
--                         UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170145))
--                         return 
--                     end
--                 end

--                 local currentTime = AvalonUtil:getCurrentTime()
--                 if(currentTime - self._changeTownChannelTime  > 2000) then
--                     self._changeTownChannelTime = currentTime

--                     UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
--                     Net.NetRoleSystem:requestChangeTownChannel(tonumber(text))
--                 else
--                     -- 切换太频繁，稍后再试
--                     UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111071))
--                 end
--             end
--         else 
--             UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111072))
--         end
--     end)
--     node:addChild(changeTownButton)
--     changeTownButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
--     changeTownButton:setText(UI.TEXT_111162)

--     changeTownChannelEdit:registerScriptEditBoxHandler(function(strEventName,sender) 
--         if(strEventName == "began") then

--         elseif (strEventName == "ended") then
    
--         elseif (strEventName == "return") then
--             local message = changeTownChannelEdit:getText() or ""
--             -- print("CreateGuild:editboxHandle  0", message, type(message))
--             local isHave = string.find(message, "\n")
--             if isHave ~= nil then
--                 message = string.gsub(message, "\n", "")
--             end
    
--             changeTownChannelEdit:setText(message)
--             changeTownChannelEdit:setPlaceHolder(UI.TEXT_1170939)
--         elseif (strEventName == "changed") then
--             local message = changeTownChannelEdit:getText() or ""
--             local isHave = string.find(message, "\n")
--             if isHave ~= nil then
--                 message = string.gsub(message, "\n", "")
--                 changeTownChannelEdit:setText(message)
--                 AvalonUtil.closeKeyBoard(changeTownChannelEdit)
--             end
--         end
--     end)
   
--     self:createItem(index, UI.TEXT_1170940, node, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:createUserProtocolButton(index, nodeOffset, titleYOffset)
--     local button = UI.Button:create()
--     button:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png")
--     button:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickUserProtocol)
--     self:createButtonText(button, UI.TEXT_1111299, 100)
--     self:createItem(index, UI.TEXT_1111299, button, nodeOffset, titleYOffset)
-- end

-- function SettingPanel:valueChanged(pSender)
--     -- print(pSender:getValue())
--     if nil == pSender then
--         return
--     end
--     local pControl = pSender

--     if pControl:getTag() == 1 then
--         -- strFmt = string.format("Upper slider value = %.02f",pControl:getValue())
--         Avalon.AudioManager:setMusicVolume(pControl:getValue())
--     elseif pControl:getTag() == 2 then
--         strFmt = string.format("Lower slider value = %.02f", pControl:getValue())
--         Avalon.AudioManager:setSoundsVolume(pControl:getValue())
--     end
-- end


-- function SettingPanel:createMusicControl(pos)
    
--     --音乐
--     local text = UI.Text:create()
--     text:init(UI.TEXT_111110, UI.FONT_STANDARD)
--     text:setFontSize(18)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     text:rightUp(pos.x, pos.y)
--     self.content:addChild(text, 10)

--     local pMusicControlSlider = cc.ControlSlider:create(cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
--     pMusicControlSlider:setMinimumValue(0.0) 
--     pMusicControlSlider:setMaximumValue(1.0) 
--     pMusicControlSlider:setAnchorPoint(0, 0.5)
--     pMusicControlSlider:setPosition(cc.p(text._width + labelBlank, text._height / 2))
--     pMusicControlSlider:setValue(Avalon.AudioManager:getMusicVolume())
--     pMusicControlSlider:setTag(1)
--     text:addChild(pMusicControlSlider)
--     pMusicControlSlider:registerControlEventHandler(handler(self, self.valueChanged), cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

--     local picMusic = cc.Sprite:create()
--     picMusic:setSpriteFrame("ui_setup_icon_ound.png")
--     picMusic:setAnchorPoint(1, 0.5)
--     picMusic:setPosition(-10, text._height / 2)
--     text:addChild(picMusic)
  
-- end

-- function SettingPanel:createSoundControl(pos)
--       --音效   
--     local text = UI.Text:create()
--     text:init(UI.TEXT_111111, UI.FONT_STANDARD)
--     text:setFontSize(18)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     text:rightUp(pos.x, pos.y)
--     self.content:addChild(text)

--     local picSound = cc.Sprite:create()
--     picSound:setSpriteFrame("ui_setup_icon_musi.png")
--     picSound:setAnchorPoint(1, 0.5)
--     picSound:setPosition(-10, text._height / 2)
--     text:addChild(picSound)

--     local pSoundControlSlider = cc.ControlSlider:create(cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
--         cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
--     pSoundControlSlider:setMinimumValue(0.0) 
--     pSoundControlSlider:setMaximumValue(1.0) 
--     pSoundControlSlider:setAnchorPoint(0, 0.5)
--     pSoundControlSlider:setPosition(cc.p(text._width + labelBlank, text._height / 2))
--     pSoundControlSlider:setValue(Avalon.AudioManager:getSoundsVolume())
--     pSoundControlSlider:setTag(2)
--     text:addChild(pSoundControlSlider,100)
--     pSoundControlSlider:registerControlEventHandler(handler(self, self.valueChanged), cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

-- end

-- function SettingPanel:onBindAccount()
--     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
-- end

-- function SettingPanel:showThirdInfo()
--     print("============SettingPanel:showThirdInfo")
--     local gameLoginManager = require("app.game.GameLoginManager")
--     local versionAccount = gameLoginManager:getInstance():getVersionAccount()
--     if not versionAccount then return end
--     local btnBinding = UI.Button:create()
--     btnBinding:init(string.format("ui_setup_button_entrance_%d.png",versionAccount),
--         string.format("ui_setup_button_entrance_%d.png",versionAccount))
--     btnBinding:leftBottom(425, 120)
--     btnBinding:setTag(1)
--     btnBinding:disable()
--     self:addChild(btnBinding)

--     local nickName = gameLoginManager:getInstance():getNickName() or "nickName"
--     local text = UI.Text:create()
--     text:init(nickName, UI.FONT_ARIAL)
--     text:setFontSize(20)
--     text:setFontColor(UI.FONT_COLOR_41_41_45)
--     text:leftBottom(515, 140)
--     text:setTextCenter()
--     self:addChild(text)
-- end
-- -- 绑定账号成功 需要刷新页面
-- function SettingPanel:onBindSuccess()
--     self:_hideLoading()
--     for i, button in ipairs( self.bindButtons_ ) do
--         if not tolua.isnull(button) then
--             button:destroy()
--         end
--     end
--     self:showThirdInfo()
-- end

-- function SettingPanel:onChangeTownChannel(data)
--     GameErrorManager:showError(data.result)
--     UI.WaitingLayer:hideWaiting()
-- end




-- -- 显示登录界面
-- function SettingPanel:_showLoading(delayCancel)
--     self._loading:setVisible(true)
--     if(delayCancel == true) then
--         Avalon.Scheduler:scheduleUpdateOnce(self, self._scheduleEnd, 6.0)
--     end
-- end

-- -- 隐藏登录界面
-- function SettingPanel:_hideLoading()
--     self._loading:setVisible(false)
--     Avalon.Scheduler:unscheduleUpdate(self, self._scheduleEnd)
-- end

-- -- 倒计时结束
-- function SettingPanel:_scheduleEnd()
--     if not tolua.isnull(self._loading) then
--         self._loading:setVisible(false)
--     end
-- end

-- -- 登出失败
-- function SettingPanel:onSdkLogoutFail(params)
    
-- end
-- -- 登出成功
-- function SettingPanel:onSdkLogoutSuccess(params)
--     -- 切换场景之前调用destroy 以免切换场景之后异步释放造成的奇怪问题
--     if self.destroy then
--         self:destroy()
--     end
-- end
-- -- 选择服务器成功
-- function SettingPanel:onSelectServerSuccess(curServerId)
--     if self.destroy then
--         self:destroy()
--     end
--     local gameLoginManager = require("app.game.GameLoginManager")
--     gameLoginManager:getInstance():setServerId(curServerId)
--     gameLoginManager:getInstance():loginOutGame();
-- end

-- -- 点击显示用户协议
-- function SettingPanel:clickUserProtocol()
--     local userProDialog = UI.UserProtocolDialog:create()
--     self:getParent():addChild(userProDialog, 1000)
--     userProDialog:showUserProtocolDialog()
-- end

-- -- 点击回到城镇
-- function SettingPanel:clickBackTown()
--     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BACK_TOWN_UI, BACK_TOWN_TYPE.BACK_TOWN_TYPE_SETTING)
-- end

-- -- 点击移动
-- function SettingPanel:clickMove()
--     if(self._moveLabel) then
--         if(self._moveLabel:getText() == "摇杆移动") then
--             self._moveLabel:setText("点击移动")
--             GameManager:setMoveType(MoveType.CONTROLLER)
--         elseif (self._moveLabel:getText() == "点击移动") then
--             self._moveLabel:setText("摇杆移动")
--             GameManager:setMoveType(MoveType.CLICK)
--         else
--             self._moveLabel:setText("点击移动")
--             GameManager:setMoveType(MoveType.CONTROLLER)
--         end
--     end
-- end

-- -- 退出登录
-- function SettingPanel:onLogout()
--     UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_111125, function()
--         print("SettingPanel logout")
--         SdkBox:getInstance():logout()
--     end)

-- end


-- -- 联系客服
-- function SettingPanel:onCustomerService()
--     local heroData = RoleDataManager:getMaster()
--     local gameLoginManager = require("app.game.GameLoginManager")
--     local params = {}
--     params.roleId = RoleDataManager:getMasterPK()
--     params.roleName = heroData:getNickName()
--     params.roleLevel = tostring(heroData:getLevel())
--     params.zoneId = tostring(gameLoginManager:getInstance():getServerId())
--     params.zoneName = tostring(gameLoginManager:getInstance():getServerId())
--     if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
--         SdkBox:getInstance():helper(params)
--     elseif (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
--         SdkBox:getInstance():helper(params)
--     else --走 浏览器 
--         SdkManager:getInstance():openCSWeb(params.roleId, params.roleName, params.roleLevel, params.zoneId)
--     end 
-- end


-- -- 打开服务器选择列表
-- function SettingPanel:onSelectServer()
--     -- 如果只有1个以下服务器 不能选择
--     local serverCfg = ServerConfigUtil:getServerList()
--     local serverCout = table.nums(serverCfg)
--     if serverCout <= 1 then
--         printWarn("SettingPanel:onSelectServer serverCout = ", serverCout)
--         return
--     end
--     require("app.ui.baglayer.Setting.SelectServerLayer")
--     local pSelectServerLayer = UI.SelectServerLayer:create(NPCSpriteID)
--     pSelectServerLayer:center()
--     pSelectServerLayer:setName("SelectServerLayer")
--     self:addChild(pSelectServerLayer,UI_ZORDER.ACTIVITY);
-- end
-- -- 打开语言选择列表
-- function SettingPanel:onSelectLanguage()
--     require("app.ui.baglayer.Setting.SelectLanguageLayer")
--     local pSelectLanguageLayer = UI.SelectLanguageLayer:create(NPCSpriteID)
--     pSelectLanguageLayer:center(0, -30)
--     pSelectLanguageLayer:setName("SelectLanguageLayer")
--     self:addChild(pSelectLanguageLayer,UI_ZORDER.ACTIVITY);
-- end

-- -- 根据服务器给的渠道，展现给玩家
-- function SettingPanel:splitChannel(channel)
--     local copyID = bit.band(channel,4194303)
--     local ServerID = bit.rshift(channel,22)

--     return string.format("%d.%d", ServerID, copyID)
-- end

-- -- 根据输入，返回一个给服务器的渠道
-- function SettingPanel:mergeChannel(text)
--     if(text and text ~= "") then
--         local numberArr = string.split(text,".")
--         if(numberArr and #numberArr == 2 and numberArr[1] ~= "" and numberArr[2] ~= "") then 
--             local serverID = checkint(numberArr[1])
--             local copyID = checkint(numberArr[2])

--             return bit.lshift(serverID,22) + copyID
--         else 
--             -- 格式有误
--             return ""
--         end
--     else 
--         return nil
--     end
-- end


-- function SettingPanel:showShareBtn(parentNode)
--     --todo 分享界面 逻辑 参考skilllayer.lua
-- end