--登录主界面scene
--主要结构:
--onInitView                    创建所有控件
--updateComponentsVisibility    根据SDK登录状态, 游戏登录状态, 热更状态 和 创角状态 来显示隐藏各个按钮


------------------------------ 初始化 --------------------------------
local gameLoginManager = require("app.game.GameLoginManager")
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local gmUtilExecutor = require("app.ui.gmUtil.GMUtilExecutor")

require("utils.HotfixManager")
require("utils.ObserverVariable")
require("utils.Scheduler")
require("utils.AvalonUtil")
require("utils.net.NetMessage")
require("utils.IrregularShapeScreenUtil")
require("app.utils.ShareUtil")
require("app.utils.ServerConfigUtil")
require("app.utils.ScreenRecordUtil")
require("app.utils.PushUtil")
require("app.datas.PublicDefine")
require("app.scene.mainscene.MainLayerServerList")
require("app.scene.mainscene.MainLayerBackground")
require("app.ui.HWBtnComponent")
require("app.ui.common.WinMgr.BaseWin")
require("app.ui.common.WinMgr.DoorWin")
require("app.ui.common.WinMgr.DoorWin")
require("app.ui.common.WinMgr.CenterWin")
require("app.ui.common.WinMgr.DownShowWin")
require("app.ui.common.SharePanel")
require("app.scene.mainscene.UserProtocolDialog")
require("app.scene.mainscene.AgeReminderDialog")
require("app.scene.mainscene.DeleteAccountRoleLayer")

require("app.ui.UIManager")

local MainLayer = class("MainLayer", UI.HWBtnComponent)
UI.MainLayer = MainLayer

local strMaxLen = 100

--登录界面资源
local RES_LIST = {
    "ui_common_information.plist",
    "ui_login_createRole.plist",
    "ui_general_notice.plist",
    "ui_login.plist",
    "ui_general_tips.plist"
}
local CONST_LOADING_RES = {
    {"effect_ui_loading_scene.json","effect_ui_loading_scene.atlas",1},
    {"effect_ui_loading_role01.json","effect_ui_loading_role01.atlas",1},
    {"effect_ui_loading_role02.json","effect_ui_loading_role02.atlas",1},
    {"effect_ui_loading_role03.json","effect_ui_loading_role03.atlas",1},
}
if AvalonUtil.isSmallMemoryDevice() then
    CONST_LOADING_RES = {}
end

-- 常量
local STARTGAME_BUTTON = "ui_login_button_box.png" -- 开始游戏按钮
local size = cc.Director:getInstance():getWinSize()
local SHARE_MODULE = PublicDefine.SHARE_MODULE
local VERSION_ACCOUNT = PublicDefine.VERSION_ACCOUNT
local MAX_PING_VALUE = 9999
local DELETE_BTN_VERSION_LIMIT = "3.9.1" --最低整包版本

--构造函数
function MainLayer:ctor()
    MainLayer.super.ctor(self, UIType.MAIN_LAYER, RES_LIST,size.width, size.height)
    self._clickLoginType        = nil;
    self._isSceneEntered        = false
    self.protocolReadStatus     = UI.UserProtocolDialog.READ_STATUS.NOT_READ
    self._deleteBtnShow         = false
    self.mDeleteRoleBtn         = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_NET_CONNECT_COMPLETE,self,self._listenerConnectComplete)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_NO_HERO, self, self._listenerLoginNoHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_ENTER_GAME, self, self._listenerEnterGame)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_VERIFY_RESULT, self, self._listenerLoginVerifyResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_RESET_LOGINBUTTON, self, self.resetLoginButton)
    Avalon.MessageCenter:bind(AvalonMessage.MC_READ_USER_PROTOCOL_COMPLEATE, self, self.onUpdateProtocolReadStatus)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_AUTO_LOGIN,self,self.autoLogin)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_REFRESH_AREAINFO,self,self.areaInfoReresh)
    ServerConfigUtil:clearServerListQueryData()
    -- 设置SDK登出不调用游戏登出, 直接在这个页面做处理
    SdkBox:getInstance():setToLogoutGameWhenSDKLogout(false)

    if LUA_VIRTUAL_RESTART then 
        Avalon.ResHelper:destroy();
        cc.Director:getInstance():restart()
    end
end

--析构函数
function MainLayer:dtor()
    MainLayer.super.dtor(self)
    Avalon.Scheduler:unscheduleUpdate(self, self.scheduleEnd)
    Avalon.Scheduler:unscheduleAllUpdateOnce()
    avalon.PingUtil:getInstance():stopLoop()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_NET_CONNECT_COMPLETE,self,self._listenerConnectComplete)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_NO_HERO, self, self._listenerLoginNoHero)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_ENTER_GAME, self, self._listenerEnterGame)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_VERIFY_RESULT, self, self._listenerLoginVerifyResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_RESET_LOGINBUTTON, self, self.resetLoginButton)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_READ_USER_PROTOCOL_COMPLEATE, self, self.onUpdateProtocolReadStatus)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_AUTO_LOGIN,self,self.autoLogin)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_REFRESH_AREAINFO,self,self.areaInfoReresh)
    if self.bgLayer then
        self.bgLayer:mute()
    end
    Avalon.AudioManager:stopAllSounds()

    -- 清理sdkbox回调
    SdkBox:getInstance():setToLogoutGameWhenSDKLogout(true)
    SdkBox:getInstance():onSdkLoginSuccess(nil)
    SdkBox:getInstance():onSdkLoginFail(nil)
    SdkBox:getInstance():onSdkLogoutSuccess(nil)
    SdkBox:getInstance():onSdkLogoutFail(nil)


    self:removeAllChildren(true)
end

-- 初始化
function MainLayer:init()
    MainLayer.super.init(self)
    Game.Manager:registerRichLinkClickCallBack()

    -- $$$$$$ 剥离声网sdk
    -- require "utils.VoiceChatManager"
    -- Avalon.VoiceChatManager:init()
    -- Avalon.VoiceChatManager:leaveChannel()

    -- 打开游戏打点 这一步有分歧,因为在游戏客户端初始化完毕的时候,客户端是还没拿到上报的地址的。。
    -- gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Launch)
end

------------------------------ 初始化 --------------------------------


























------------------------------ 表现 --------------------------------
-- 初始化视图
function MainLayer:onInitView()
    if LUA_VIRTUAL_RESTART then 
        return
    end

    -- 显示UI
    UI.UIManager:setShowMainUI(true)

    -- 清除免责声明状态
    GameManager:clearShowDisclaimer()

    -- 设置屏幕常亮
    cc.Device:setKeepScreenOn(true)

    -- 处理游戏中的本地消息推送, 目前为不推送, 并且清空气泡
    PushUtil:removeAllLocalNotifications()

    -- 处理录制中强制登出
    ScreenRecordUtil:getInstance():stopRecording(true) --如果有在录屏, 丢弃已经录制的视频

	-- 延迟1帧加载背景层
    performWithDelay(self, function()
        -- 背景层
        self.bgLayer = UI.MainLayerBackground:create()
        self.bgLayer:init()
        self.bgLayer:center()
        self:addChild(self.bgLayer, -4)
    end, 0)
    
    -- root节点
    self.uiLayer = cc.Layer:create();
    self.uiLayer:setContentSize(cc.size(size.width,size.height))
    self.uiLayer:setPosition(cc.p(0,0))
    self:addChild(self.uiLayer)

    -- 显示UUID码
    local UUID = UI.Text:create()
    UUID:init(AvalonUtil.getOpenUUID(), UI.FONT_STANDARD, UI.FONT_SIZE_26PX, {r = 255, g = 255, b = 255})
    UUID:center()
    UUID:hide()
    self.uiLayer:addChild(UUID)

    local function checkSecretCode()
        if (self._secretCode == "1100101010") then
            UUID:show()
        end
    end

    -- 左秘密按钮
    local btnL = UI.Button:create()
    btnL:init()
    btnL:setSize(150, 150)
    btnL:setSwallowTouches(false)
    btnL:leftBottom(0, 0)
    btnL:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (not self._secretCode) then self._secretCode = "" end
        self._secretCode = self._secretCode .. "1"
        checkSecretCode()
    end)
    self.uiLayer:addChild(btnL, 1000)
    
    -- 右秘密按钮
    local btnR = UI.Button:create()
    btnR:init()
    btnR:setSize(150, 150)
    btnR:setSwallowTouches(false)
    btnR:rightBottom(0, 0)
    btnR:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (not self._secretCode) then self._secretCode = "" end
        self._secretCode = self._secretCode .. "0"
        checkSecretCode()
    end)
    self.uiLayer:addChild(btnR, 1000)

    -- 检测热更新下载文件是否齐全
    self:checkHotFixFiles()

    -- 功能按钮初始化
    self:initFunctionButtons()
    self:hideFunctionButtons()

    -- 适龄提示
    self:initCountryButtons()
    self:hideCountryButtons()

    -- 测试相关初始化
    self:initTestAccountInput()
    self:hideTestAccountInput()

    -- 用户协议相关初始化
    self:initUserProtocol()
    self:hideUserProtocolButtons()

    -- 分享相关按钮初始化
    self:initShareLayer()
    self:hideShareLayer()

    -- 服务器选择列表初始化
    self:initServerSelector()
    self:hideServerSelector()

    -- SDK登录按钮初始化
    self:initSDKLoginButtons()
    self:hideSDKLoginButtons()

    -- 游戏登录按钮初始化
    self:initGameLoginButtons()
    self:hideGameLoginButtons()

    -- 初始化ICON和其他文字
    self:initStaticComponents()
    self:hideStaticComponents()


    -- local heroAnimation = UI.Animation:create()
    -- heroAnimation:init("role_hero_2.json", "role_hero.atlas", 1);
    -- heroAnimation:centerUp(500)
    -- self:addChild(heroAnimation, 999999)

    -- heroAnimation:setAnimation("idle_1",false)
    -- heroAnimation:addAnimation("attack_2_2",true)
    -- -- heroAnimation:setSize(6, 12)

    -- local boundSlotArr = {
    --     "mount_bottom",
    --     "mount_bottomdown",
    --     "mount_center",
    --     "mount_centerdown",
    --     "mount_effect",
    --     "mount_icon",
    -- }

    -- for k,v in ipairs(boundSlotArr) do 
    --     local compoAnimation = UI.Animation:create()
    --     compoAnimation:init("skill_silianji.json", "skill_silianji.atlas", 1);
    --     compoAnimation:setAnimation("release_skill", true)
    --     -- compoAnimation:setSize(6, 12)

    --     heroAnimation:addComponent(v, compoAnimation, false)
    -- end 


    -- local heroAnimation = UI.Animation:create()
    -- heroAnimation:init("role_monster_asclepius&court_scientist.json", "role_monster_asclepius&court_scientist.atlas", 1);
    -- heroAnimation:leftUp(0, 100)
    -- heroAnimation:setScale(0.3)
    -- heroAnimation:setAnimation("idle1", true)
    -- self:addChild(heroAnimation, 999999)


    -- local heroAnimation = UI.Animation:create()
    -- heroAnimation:init("effect_buff_underfire.json", "effect_buff_underfire.atlas", 1);
    -- heroAnimation:centerUp(700)
    -- heroAnimation:setAnimation("begin", false)
    -- heroAnimation:addAnimation("idle", false)
    -- heroAnimation:addAnimation("trigger", false)
    -- heroAnimation:addAnimation("end", false)
    -- self:addChild(heroAnimation, 999999)

    -- 测试多张纹理渲染
    -- local renderer = Renderer.HeroRenderer:create()
    -- -- renderer:init("role_hero_2.json", "role_hero.atlas", 1, 1, true, 0, 0, false, true)
    -- renderer:init("role_hero_1.json", "role_hero.atlas", 1, 1, true, 0, 0, false, true)
    -- renderer:setAttrAddNode(self._map)
    -- renderer:setHeroPK(pk)
    -- renderer:setPosition(500, 300)
    -- self:addChild(renderer._viewNode, 999999)
    
    -- require "app.datas.GoodsDataManager"
    -- local equipmentArr = {}
    -- -- 21082034, 21082064
    -- local equipmentIDArr = {21082064, 21070030, 21060160, 21050190, 21040050, 21030110, 21022044, 21010060}
    -- for _,equipmentID in ipairs(equipmentIDArr) do 
    --     local equipmentData = GoodsDataManager:createLocalGoodsData(equipmentID)
    --     table.insert(equipmentArr, equipmentData)
    -- end
    -- renderer:refreshEquip(equipmentArr)

    -- renderer._roleAnimation:setAnimation(0, "jiandun_shenshengguanghui", true)

    -- 检查流程:
    -- 1.检查扩展包
    -- 2.向服务器获取*沈河*状态, 可能: a.强更, b.热更, c.正常, d.超时
    -- 3.正常流程走登录, 热更或者强更后重启游戏, 超时提示点击确认后退出游戏
    -- 检查扩展包
    -- local expMgr = require("utils.ExpansionManager")
    -- expMgr:checkAndNoticeDownload(
    --     LanguageManager:getInstance():getLocalString(1111212),         -- "资源包丢失, 正在下载中. 请等待并在通知栏查看进度. 完成后请点击确认退出, 然后重新打开游戏",
    --     function() -- 不需要下载扩展包, 正常流程
    --         self:queryServerReviewConfig()
    --     end,
    --     function() -- 扩展包下载完成, 关闭游戏
    --         -- cc.Director:getInstance():endToLua()
    --         -- os.exit()
    --         require "app.utils.ToolsUtil"
    --         ToolsUtil:exitApp()
    --     end)
    self:queryServerReviewConfig()    

    -- 入场
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.ENTER_LOGIN, self, function() 
        if(not tolua.isnull(self)) then
            self._isSceneEntered = true
            self:checkUpdate()
            if(not tolua.isnull(self.bgLayer)) then
                self.bgLayer:setEnableMove(true)
            end
        end
    end)

    performWithDelay(self, function()
        self:preLoadLoadingSpines()
    end, 0.01)
    -- print("MainLayer isFromChangeArea", isFromChangeArea)
    if(isFromChangeArea) then 
        self:loginGame()
    end

    if(isFromChangeScene) then 
        self:loginGame()
    end
end
-- 预加载loading界面的资源
function MainLayer:preLoadLoadingSpines()
    for i,v in ipairs(CONST_LOADING_RES) do
        Avalon.ResHelper:loadSpine(v[1], v[2], v[3])
    end
end
-- 更新视图
function MainLayer:onUpdateView()   

end 

-- 更新动态按钮(登录相关按钮)
function MainLayer:updateComponentsVisibility(isInRoleCreation)
------------------------          角色创建          -----------------------------
    if (isInRoleCreation) then
        self:hideFunctionButtons()      -- 功能按钮组
        self:hideStaticComponents()     -- 静态组件
        self:hideShareLayer()           -- 分享按钮
        self:hideUserProtocolButtons()  -- 用户协议文本显示
        self:hideServerSelector()       -- 服务器列表相关按钮
        self:hideSDKLoginButtons()      -- SDK登录相关的按钮
        self:hideGameLoginButtons()     -- 游戏登录相关的按钮
        self:hideCountryButtons()
        return
    end

    -- 更新, SDK登录, 游戏登录状态中总是显示静态组件
    self:showStaticComponents()
    -- 更新, SDK登录, 游戏登录状态中总是显示功能按钮组
    self:showFunctionButtons()
    -- 更新, SDK登录, 游戏登录状态中总是显示客服按钮

    self:showCountryButtons()

    -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)
    if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
        if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
        or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
        -- or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
        then
            print("是雷霆 ")
            self.mCSButton:show()
        else
            print("不是雷霆 ")
            self.mCSButton:hide()
        end
    else
        self.mCSButton:show()
    end

    if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL ) then
        if self.mAgeReminderButton then
            self.mAgeReminderButton:hide()
        end
    else 
        if self.mAgeReminderButton then
            self.mAgeReminderButton:show()
        end
    end
    

------------------------           热更强更         -----------------------------
    if (self.updateStatus == 1 or self.updateStatus == 2) then
        -- 更新时的表现
        self.mAccSwitchBtn:hide()       -- GLOBAL账号切换按钮
        self.mACButton:hide()           -- CNSDK账号中心按钮
        self.mNoticeBtn:hide()          -- 公告按钮
        
        self:hideShareLayer()           -- 分享按钮
        self:hideUserProtocolButtons()  -- 用户协议文本显示
        self:hideServerSelector()       -- 服务器列表相关按钮
        self:hideSDKLoginButtons()      -- SDK登录相关的按钮
        self:hideGameLoginButtons()     -- 游戏登录相关的按钮

        if self.mDeleteRoleBtn then
            self.mDeleteRoleBtn:hide()      -- 删除角色按钮
        end

        return
    end

    -- SDK登录, 游戏登录状态中总是显示分享按钮
    self:showShareLayer()

------------------------        SDK登录/游戏登录      -----------------------------
    -- 登录游戏或登录SDK的表现
    local isLoginSDKMode = not ServerConfigUtil:isAbleToLoginGame()

    -- 右上角功能按钮
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (isLoginSDKMode) then
        self.mNoticeBtn:hide()
        if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
            -- CN 只有雷霆官方才有账号中心
            if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
            or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
            -- or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
            then
                self.mACButton:show()
            else
                self.mACButton:hide()
            end            
        else
            self.mAccSwitchBtn:hide()

            if self.mDeleteRoleBtn then
                self.mDeleteRoleBtn:hide()
            end
        end
        
        self:hideUserProtocolButtons()  -- 用户协议文本显示
        self:hideServerSelector()       -- 服务器列表相关按钮
        self:hideGameLoginButtons()     -- SDK登录相关的按钮
        self:showSDKLoginButtons()      -- 游戏登录相关的按钮
        self:showTestAccountInput()     -- 测试按钮相关
    else
        if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE) then
            -- CN 只有雷霆官方才有账号中心
            if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
            or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
            -- or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI 
            then
                self.mACButton:show()
            else
                self.mACButton:hide()
            end
        else
            self.mAccSwitchBtn:show()

            if self.mDeleteRoleBtn then
                self.mDeleteRoleBtn:show()
            end
        end
        
        self:showUserProtocolButtons()  -- 用户协议文本显示
        self:showServerSelector()       -- 服务器列表相关按钮
        self:showGameLoginButtons()     -- 游戏登录相关的按钮
        self:hideSDKLoginButtons()      -- SDK登录相关的按钮
        self:hideTestAccountInput()     -- 测试按钮相关
    end
end

function MainLayer:initStaticComponents()
    -- 静态部件层
    self.mStaticComponentLayer = UI.Component:create()
    self.mStaticComponentLayer:init()
    self.mStaticComponentLayer:leftBottom(0, 0)
    self.mStaticComponentLayer:setSize(size.width, size.height)
    self.uiLayer:addChild(self.mStaticComponentLayer)

    -- 版本号背景
    self.versionBg = UI.Image:create()
    self.versionBg:init("ui_login_banner_version.png")
    self.versionBg:leftUp(-300, 10)
    self.versionBg:enableIrregularShapeScreenAdjustment(true)
    self.mStaticComponentLayer:addChild(self.versionBg)

    -- 内测包加上Beta前缀作为区分
    local versionStr = Avalon.HotfixManager:getLocalVersion().."."..Avalon.HotfixManager:getLocalBuild()
    if CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
        versionStr = "Beta"..versionStr
    end
    -- 版本号
    local versionText = UI.Text:create()
    versionText:init(LanguageManager:getInstance():getLocalString(1111202) .. ":" .. versionStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_205_199_189)
    versionText:leftUp(310, 4)
    self.versionBg:addChild(versionText)

    if GameManager:getIsOpenArea() then
        -- 当前服务器信息
        self.areaNameBg = UI.Image9:create()
        self.areaNameBg:init("ui_login_banner_version.png", CCRectMake(11,1,527,31), cc.size(50, 32))
        self.areaNameBg:leftUp(0, 52)
        self.areaNameBg:enableIrregularShapeScreenAdjustment(true)
        self.areaNameBg:setVisible(false)
        self.mStaticComponentLayer:addChild(self.areaNameBg)

        -- 服务器名字
        local areaNameText = UI.Text:create()
        areaNameText:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_205_199_189)
        areaNameText:centerLeft(10)
        self.areaNameBg:addChild(areaNameText)
        self.areaNameText = areaNameText

        -- 切换按钮
        local areaButton = UI.Button:create() 
        areaButton:init("ui_login_btn_switch.png", "ui_login_btn_switch.png", "ui_login_btn_switch.png")
        areaButton:centerRight(-(self.areaNameBg:getContentSize().width + 20))
        -- areaButton:setVisible(false)
        self.areaNameBg:addChild(areaButton)
        areaButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            self:areaChangeClick()
        end)
        self.areaButton = areaButton
    end

    -- 工信部APP备案信息添加说明
    if (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET_DEVELOPMENT == CAVEOL_TARGET) then
        local filingsText = "蜀ICP备14005045号-4A"
        local filingsLabel = UI.Text:create()
        filingsLabel:init(filingsText, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_251_235_218, true)

        local button = UI.Button:create()
        button:init()
        button:setSize(filingsLabel._width, filingsLabel._height)
        button:setTextFont(UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_251_235_218)
        button:setText(filingsText)
        button:leftUp(0, 90)
        button:setUnderline(true)
        self.mStaticComponentLayer:addChild(button)
        button:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            GameManager:openUrl("https://beian.miit.gov.cn/#/Integrated/index")
        end)
    end

    -- 下方提示
    local strFootNote = LanguageManager:getInstance():getProtocolString(UI.UserProtocolDialog.STRING_KEY.SAFE_NOTICE, "")
    if strFootNote ~= nil and strFootNote ~= "" then
        -- 正义提示背景
        self.footNoteBg = UI.Image:create()
        self.footNoteBg:init("ui_login_banner_ash.png")
        self.footNoteBg:fill()
        self.footNoteBg:centerBottom(Avalon.issUtil:getBottomMargin())
        self.footNoteBg:setSize(size.width, 35)
        self.mStaticComponentLayer:addChild(self.footNoteBg)

        -- 正义提示
        local footNote = UI.Text:create()
        footNote:init(strFootNote, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_205_199_189)
        footNote:center()
        self.footNoteBg:addChild(footNote)
    end
end

function MainLayer:initGameLoginButtons()
    self.mGameLoginButtonList = {}

    self.mGameLoginButtonLayer = UI.Layout:create()
    self.mGameLoginButtonLayer:init()
    self.mGameLoginButtonLayer:leftBottom(0, 0)
    self.uiLayer:addChild(self.mGameLoginButtonLayer)

    -- -- 游戏登录模式
    self:addGenericEntryButton(
        self.mGameLoginButtonLayer,
        self.mGameLoginButtonList,
        function()
            if (self._loginButtonEnabled) then
                self:loginGame()
            end
        end)
end

function MainLayer:initSDKLoginButtons()
    self.mSDKLoginButtonList = {}

    self.mSDKLoginButtonLayer = UI.Layout:create()
    self.mSDKLoginButtonLayer:init()
    self.mSDKLoginButtonLayer:leftBottom(0, 0)
    self.uiLayer:addChild(self.mSDKLoginButtonLayer)

    -- SDK登录模式
    local function doSdkLogin(versionAccount) 
        if (self._loginButtonEnabled) then
            self:loginSDK(versionAccount)
        end
    end
    if (DEVELOPMENT_MODE) then
        -- 开发模式SDK登录
        local devSDKBtn = self:getSdkButton(
            STARTGAME_BUTTON, 
            nil, 
            "模拟SDK", 
            function() doSdkLogin(VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST) end)

        local btnW,btnH = devSDKBtn:getSize()
        devSDKBtn:leftBottom((size.width - 281)/2 + (281 - btnW)/2, 100 + Avalon.issUtil:getBottomMargin())
        self.mSDKLoginButtonLayer:addChild(devSDKBtn)
        table.insert(self.mSDKLoginButtonList, devSDKBtn)
    else
        -- 实际SDK登录
        local sdks = SdkBox:getInstance():getSupportLoginSdks()
        self:addSDKLoginButtons(
            self.mSDKLoginButtonLayer,
            self.mSDKLoginButtonList,
            sdks, 
            function(versionAccount) doSdkLogin(versionAccount) end)
    end
end


-- 根据传入的sdk列表添加一系列第三方SDK登录按钮
function MainLayer:addSDKLoginButtons(host, list, sdks, clickCallback)
    local count = table.nums(sdks)
    local wasGlobalIos = AvalonUtil:wasGlobalIos()

    for i, versionAccount in ipairs(sdks) do
        -- 渠道按钮
        local btnIcon = STARTGAME_BUTTON
        local btnText = ""
        local btnImageLeft, btnImageBottom = 10, 22
        local btnTextXOffset, btnTextYOffset = -5, 0
        if versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_FB then
            btnIcon = "ui_login_btn_facebook_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111453)
            if(wasGlobalIos) then 
                btnIcon = "ui_login_btn_ios_facebook.png"
            end
            btnImageLeft = 5
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_WX then
            btnIcon = "ui_login_btn_weixing_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111454)
            if(wasGlobalIos) then 
                printError("must be handle this account in global ios sign.")
            end
            btnTextXOffset = 5
            btnImageLeft = 2
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST then
            btnIcon = "ui_login_btn_youke_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111226)
            if(wasGlobalIos) then 
                btnIcon = "ui_login_btn_ios_guest.png"
            end
            btnImageLeft = 0
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_GAMECENTER then
            btnIcon = "ui_login_btn_gamecenter_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111455)
            if(wasGlobalIos) then 
                btnIcon = "ui_login_btn_ios_gamecenter.png"
            end
            btnTextXOffset = 15
            btnImageLeft = -2
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_LEITING then
            -- 
            local channel = SdkBox:getInstance():getVersionChannel()
            channel = checkint(channel)
            if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
            or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
            then
                btnIcon = "ui_login_btn_leiting_loading.png"
                btnText = LanguageManager:getInstance():getLocalString(1111456)
            elseif channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI then
                btnIcon = "ui_login_btn_bilibili_loading.png"
                btnText = LanguageManager:getInstance():getLocalString(1111593)
            else
                btnIcon = nil
                btnText = LanguageManager:getInstance():getLocalString(1111374)
            end
            if(wasGlobalIos) then 
                printError("must be handle this account in global ios sign.")
            end
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_GOOGLEPLAY then
            btnIcon = "ui_login_btn_google_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111457)
            btnTextXOffset = 10
            if(wasGlobalIos) then 
                printError("must be handle this account in global ios sign.")
            end
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_APPLE then
            btnIcon = "ui_login_btn_google_loading.png"
            btnText = LanguageManager:getInstance():getLocalString(1111457)
            if(wasGlobalIos) then 
                btnText = LanguageManager:getInstance():getLocalString(1113722)
                btnIcon = "ui_login_btn_ios_apple.png"
            end
            btnTextXOffset = 10
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_QOOAPP then
            btnIcon = ""
            btnText = UI.TEXT_222001
            if(wasGlobalIos) then 
                btnIcon = ""
            end
            btnImageLeft = 5
        elseif versionAccount == VERSION_ACCOUNT.VERSION_ACCOUNT_QUICK then
            btnIcon = ""
            btnText = UI.TEXT_222001
            if(wasGlobalIos) then 
                btnIcon = ""
            end
            btnImageLeft = 5
        end

        loginButton = nil
        if(wasGlobalIos) then
            btnImageLeft, btnImageBottom = 14, 8
            btnTextXOffset, btnTextYOffset = 10, 0
            loginButton = self:getIOSSdkButton(
            STARTGAME_BUTTON, 
            btnIcon, 
            btnText, 
            function () if (clickCallback) then clickCallback(versionAccount) end end,
            btnImageLeft, btnImageBottom,
            btnTextXOffset, btnTextYOffset)
        else
            loginButton = self:getSdkButton(
            STARTGAME_BUTTON, 
            btnIcon, 
            btnText, 
            function () if (clickCallback) then clickCallback(versionAccount) end end,
            btnImageLeft, btnImageBottom,
            btnTextXOffset, btnTextYOffset)
        end

        local btnW, btnH = loginButton:getSize()
        if(wasGlobalIos) then
            loginButton:leftBottom((size.width - (count * 241))/2 + (i - 1) * 241 + (241 - btnW)/2, 100)
        else
            loginButton:leftBottom((size.width - (count * 281))/2 + (i - 1) * 281 + (281 - btnW)/2, 100)
        end
        host:addChild(loginButton)
        table.insert(list, loginButton)
    end
end

-- 返回一个通用SDK登录按钮
function MainLayer:getSdkButton(bgFile, iconFile, text, callback, iconOffsetX, iconOffsetY, textOffsetX, textOffsetY)
    if (iconOffsetX == nil) then iconOffsetX = 10 end
    if (iconOffsetY == nil) then iconOffsetY = 22 end
    if (textOffsetX == nil) then textOffsetX = -5 end
    if (textOffsetY == nil) then textOffsetY = 0 end

    local loginButton = UI.Button:create() 
    loginButton:init("ui_login_btn_tourist_loading.png", "ui_login_btn_tourist_loading.png", "ui_login_btn_tourist_loading.png")
    loginButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_LOGIN_BUTTON_TEXT)
    loginButton:setTextOffset(textOffsetX, textOffsetY)
    loginButton:setText(text)
    loginButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        if (callback) then callback() end
    end)

    if (iconFile) then
        local buttonIcon = UI.Image:create()
        buttonIcon:init(iconFile)
        buttonIcon:leftBottom(iconOffsetX, iconOffsetY)
        loginButton:addChild(buttonIcon, 100)
    end
    return loginButton
end

function MainLayer:getIOSSdkButton(bgFile, iconFile, text, callback, iconOffsetX, iconOffsetY, textOffsetX, textOffsetY)
    if (iconOffsetX == nil) then iconOffsetX = 10 end
    if (iconOffsetY == nil) then iconOffsetY = 22 end
    if (textOffsetX == nil) then textOffsetX = -5 end
    if (textOffsetY == nil) then textOffsetY = 0 end

    local loginButton = UI.Button:create() 
    loginButton:init("ui_login_btn_tourist_loading_02.png", "ui_login_btn_tourist_loading_02.png", "ui_login_btn_tourist_loading_02.png")
    loginButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    loginButton:setTextOffset(textOffsetX, textOffsetY)
    loginButton:setText(text)
    -- loginButton:setFixLineWidth(150)
    loginButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        if (callback) then callback() end
    end)

    if (iconFile) then
        local buttonIcon = UI.Image:create()
        buttonIcon:init(iconFile)
        buttonIcon:leftBottom(iconOffsetX, iconOffsetY)
        loginButton:addChild(buttonIcon, 100)
    end
    return loginButton
end

-- 添加一个通用游戏登录按钮
function MainLayer:addGenericEntryButton(host, list, clickCallback, text)
    if (text == nil) then
        text = UI.TEXT_1170719
    end

    local loginButton = UI.Button:create() 
    loginButton:init(STARTGAME_BUTTON, STARTGAME_BUTTON, STARTGAME_BUTTON)
    loginButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_ENTER_GAME_BUTTON_TEXT)
    loginButton:setTextShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -4))
    loginButton:setTextOffset(0, -2)
    loginButton:setText(text)
    loginButton:setInterval(1)
    
    local decoration = UI.Image:create()
    decoration:init("ui_login_button_box_up.png")
    decoration:center()
    loginButton:addChild(decoration, 2)

    AvalonUtil.addBracketsAnimationToButton(loginButton, "effect_ui_login_createrole_button", 0, 2, true)

    loginButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        if (clickCallback) then clickCallback() end
    end )

    local btnW,btnH = loginButton:getSize()
    loginButton:leftBottom((size.width - 281)/2 + (281 - btnW)/2, 100 + Avalon.issUtil:getBottomMargin())
    host:addChild(loginButton)
    table.insert(list, loginButton)
end

--用户协议
function MainLayer:initUserProtocol()
    UI.UserProtocolDialog.checkVersionChanged()

    self.userProtocolLayer = UI.Component:create()
    self.userProtocolLayer:init()
    self.userProtocolLayer:leftBottom(0, 0)
    self.userProtocolLayer:setSize(size.width, size.height)
    self.uiLayer:addChild(self.userProtocolLayer)

    local node = UI.Component:create()
    node:init()
    node:setSize(10, 40)
    node:centerBottom(40 + Avalon.issUtil:getBottomMargin())
    -- if Avalon.issUtil:isIphoneX() then
    --     node:centerBottom(70)
    -- else
    --     node:centerBottom(50)
    -- end
    self.userProtocolLayer:addChild(node)

    local width = 0
    self.protocolReadStatus = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.ReadUserProtocol, UI.UserProtocolDialog.READ_STATUS.NOT_READ)

    self.agreeButton = UI.Button:create()
    self.agreeButton:init("ui_general_notice_round.png", "ui_general_notice_round.png", "ui_general_notice_round.png")
    self.agreeButton:centerLeft(0)
    node:addChild(self.agreeButton);
    self.agreeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local checkVisible = self.checkIcon:isVisible();
        if checkVisible then
            self.checkIcon:setVisible(false)
            UI.UserProtocolDialog.saveAllowStatus(false)
        else
            self.checkIcon:setVisible(true)
            UI.UserProtocolDialog.saveAllowStatus(true)
            -- UI.UserProtocolDialog.trySendRecord(true)
        end
    end)

    self.checkIcon = UI.Image:create()
    self.checkIcon:init("ui_general_notice_tick.png")
    self.checkIcon:center()
    self.agreeButton:addChild(self.checkIcon, 3)

    width = width + self.agreeButton._width + 5

    local readNoticeLabel = UI.Text:create()
    readNoticeLabel:init(LanguageManager:getInstance():getProtocolString(UI.UserProtocolDialog.STRING_KEY.READ_NOTICE, ""), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_142_153_155)
    readNoticeLabel:centerLeft(width)
    node:addChild(readNoticeLabel);

    width = width + readNoticeLabel._width + 5

    --只是用来计算长度，用来定义button的大小
    local strProtocolName = LanguageManager:getInstance():getProtocolString(UI.UserProtocolDialog.STRING_KEY.PROTOCOL_NAME, "")
    local protocolNameLabel = UI.Text:create()
    protocolNameLabel:init(strProtocolName, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_81_154_167, true)

    local button = UI.Button:create()
    button:init()
    button:setSize(protocolNameLabel._width, protocolNameLabel._height)
    button:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_81_154_167)
    button:setText(strProtocolName)
    button:centerLeft(width)
    button:setUnderline(true)
    node:addChild(button)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if SdkBox:getInstance():isSupportLicense() then
            SdkBox:getInstance():showSdkLicense()
        else
            self:showUserProtocolDilog()
        end
    end)

    width = width + button._width
    node:setSize(width, 40);
    node:setSize(width, 40);
    self.userProtocolNode = node;
    -- node:setVisible(UI.UserProtocolDialog.alreadySendUserProtocolRecord() or UI.UserProtocolDialog.getReadStatus())
end

function MainLayer:tryShowUserProtocolDilog()
    local show = false
    if SdkBox:getInstance():isSupportLicense() then
        if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
            --雷霆sdk 自己触发了弹框就不用 业务层弹出了
        else
            SdkBox:getInstance():showSdkLicense()
            show = true
        end
    elseif not UI.UserProtocolDialog.gaveAllowStatus() and not UI.UserProtocolDialog.getReadStatus() and  not UI.UserProtocolDialog.alreadySendUserProtocolRecord() then
        self:showUserProtocolDilog()
        show = true
    end
    return show
end

function MainLayer:showUserProtocolAllowCheckIcon()
    self.checkIcon:setVisible(UI.UserProtocolDialog.gaveAllowStatus())
end

function MainLayer:showUserProtocolDilog()
    local nodeName = "userProDialog"
    local node = self:getChildByName(nodeName)
    if node == nil then
        local userProDialog = UI.UserProtocolDialog:create();  
        userProDialog:setName(nodeName) 
        self:addChild(userProDialog, 100)
        userProDialog:showUserProtocolDialog();
    end
end

function MainLayer:onUpdateProtocolReadStatus(agree)
    self.protocolReadStatus = UI.UserProtocolDialog.READ_STATUS.READ_COMPLETE
    if agree then
        self.agreeProtocolStatus = true
        self.checkIcon:setVisible(true)
    end
    self.userProtocolNode:setVisible(true)

    -- 确认和取消后也显示登录提示
    self:getLoginNotice()
end

function MainLayer:checkUserProtocol()
    local canEnterGame = true
    if not self.checkIcon:isVisible() and self.userProtocolNode:isVisible() then
        canEnterGame = false;
        local des = LanguageManager:getInstance():getLocalString(1111304)
        local protocolName = AvalonUtil:serializeText(LanguageManager:getInstance():getLocalString(1111299), AvalonUtil:colorRGB2Str(UI.FONT_COLOR_226_180_69), UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
        local content = AvalonUtil:formartRichText(UI.FONT_COLOR_142_153_155, UI.FONT_SIZE_16PX, UI.FONT_STANDARD, des, protocolName)
        local bottomRichText = UI.RichText:create()
        local success = bottomRichText:init(content, 20, 20, true)
        bottomRichText:center(0, 3)

        local labelNeedWidth = bottomRichText._width + 40
        local minWidth = 408
        local bgHeight = 51
        local bgWidth = labelNeedWidth < minWidth and minWidth or labelNeedWidth
        local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_general_notice_black.png")
        bg:setCapInsets(CCRectMake(10,10,5,5))
        bg:setContentSize(bgWidth, bgHeight)
        bg:setPosition(300, 300)
        bg:addChild(bottomRichText);

        UI.ScrollBar:createWithNode(bg)
    end
    return canEnterGame
end
function MainLayer:checkHotFixFiles()
    local direction = Avalon.FileManager:getHotfixDirection()
    localManifest = {}
    remoteManifest = {}
    -- 
    local manifestUrl = cc.FileUtils:getInstance():fullPathForFilename("res/Resource/CaveOnline_project.manifest")
    if cc.FileUtils:getInstance():isFileExist(manifestUrl) then
        local fileContent = cc.FileUtils:getInstance():getStringFromFile(manifestUrl)
        if fileContent then
            localManifest = avalon.Util.decodeJSON(fileContent)
        end
    end
    local remoteManifestUrl = cc.FileUtils:getInstance():fullPathForFilename(direction.."project.manifest")
    printInfo("remoteManifestUrl",remoteManifestUrl)
    if cc.FileUtils:getInstance():isFileExist(remoteManifestUrl) then
        printInfo("远程文件存在")
        local fileContent = cc.FileUtils:getInstance():getStringFromFile(remoteManifestUrl)
        if fileContent then
            remoteManifest = avalon.Util.decodeJSON(fileContent)
        end
    end
    -- 对比差异文件
    local localAssets = localManifest.assets or {}
    local remoteAssets = remoteManifest.assets or {}
    printInfo("本地列表文件个数",table.nums(localAssets))
    printInfo("远程列表文件个数",table.nums(remoteAssets))
    local diffs = {}
    for k,v in pairs(remoteAssets) do
        if not localAssets[k] or localAssets[k].md5 ~= v.md5 then
            table.insert( diffs, k )
        end
    end
    printInfo("差异文件",#diffs)
    local needReupdate = false
    -- 判断差异文件是否存在
    for i,fileName in ipairs(diffs) do
        local fullName = direction..fileName
        if not cc.FileUtils:getInstance():isFileExist(fullName) then
            needReupdate = true
            break;
        end
    end
    if needReupdate then
        printInfo("需要重新热更新")
        if (device.platform == "ios" or device.platform == "android") then
            buglyReportLuaException(tostring("需要重新热更新"), "需要重新热更新",false)    
        end
        Avalon.FileManager:removeDirectory(direction)
        Avalon.FileManager:createDirectory(direction)
        
        local scheduler=cc.Director:getInstance():getScheduler()
        local mSchedulerID = scheduler:scheduleScriptFunc(function ()
            -- 防止线程回调问题
            Avalon.ResHelper:destroy();
            cc.Director:getInstance():restart()
        end,0.1,false)
    end
    -- dump(diffs,"本地差异文件")
end
-- 初始化功能按钮
function MainLayer:initFunctionButtons()
    -- 宿主层
    self.funcBtnLayer = UI.Component:create()
    self.funcBtnLayer:init()
    self.funcBtnLayer:leftBottom(0, 0)
    self.funcBtnLayer:setSize(size.width, size.height)
    self.uiLayer:addChild(self.funcBtnLayer)

    -- 右上角功能按钮组, 全部放在这个浮动布局里面, 隐藏掉的按钮会不占空间, 后面的按钮会自动补位, 实时更新.
    self.funcBtnLayout = UI.Layout:create()
    self.funcBtnLayout:init()
    self.funcBtnLayout:enableAutoHeight()
    self.funcBtnLayout:enableAutoWidth()
    self.funcBtnLayout:rightUp(20, 0)
    self.funcBtnLayout:enableIrregularShapeScreenAdjustment(true)
    self.funcBtnLayer:addChild(self.funcBtnLayout)
    
    -- 公告功能按钮
    self.mNoticeBtn = UI.Button:create()
    self.mNoticeBtn:init("ui_login_button_announcement_0.png","ui_login_button_announcement_1.png","ui_login_button_announcement_0.png")
    self.mNoticeBtn:floatUp(20)
    self.mNoticeBtn:openClickScale()
    self.mNoticeBtn:addEventListener(UI.Event.BUTTON_CLICK, self,self.onOpenNotice)
    self.mNoticeBtn:hide()
    self.funcBtnLayout:addComponent(self.mNoticeBtn)

    -- 客服功能按钮
    self.mCSButton = UI.Button:create()
    self.mCSButton:init("ui_login_button_service_0.png","ui_login_button_service_1.png","ui_login_button_service_0.png")
    self.mCSButton:floatUp(20)
    self.mCSButton:openClickScale()
    self.mCSButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.CSBtnClick)
    self.funcBtnLayout:addComponent(self.mCSButton)

    -- 账号功能按钮(雷霆)
    self.mACButton = UI.Button:create()
    self.mACButton:init("ui_login_button_usercenter_0.png","ui_login_button_usercenter_1.png","ui_login_button_usercenter_0.png")
    self.mACButton:floatUp(20)
    self.mACButton:openClickScale()
    self.mACButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if (self._isAcButtonDisabled) then return end
        SdkBox:getInstance():showAccountCenter()
    end)
    self.mACButton:hide()
    self.funcBtnLayout:addComponent(self.mACButton)

    -- 退出登录功能按钮(GLOBAL)
    self.mAccSwitchBtn = UI.Button:create()
    self.mAccSwitchBtn:init("ui_login_button_logout_0.png","ui_login_button_logout_1.png","ui_login_button_logout_0.png")
    self.mAccSwitchBtn:floatUp(20)
    self.mAccSwitchBtn:openClickScale()
    self.mAccSwitchBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:showComfirmLogoutSDK(LanguageManager:getInstance():getLocalString(1111335))
    end)
    self.mAccSwitchBtn:hide()
    self.funcBtnLayout:addComponent(self.mAccSwitchBtn)

    --论坛总入口
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        self.mForumBtn = UI.Button:create()
        self.mForumBtn:init("ui_login_button_home_0.png","ui_login_button_home_0.png","ui_login_button_home_0.png")
        self.mForumBtn:floatUp(20)
        self.mForumBtn:openClickScale()
        self.mForumBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
            self:openForumBtns()
        end)
        self.funcBtnLayout:addComponent(self.mForumBtn)
    end

    -- 隐私功能按钮
    self.mDiscButton = UI.Button:create()
    self.mDiscButton:init("ui_login_button_privacy_0.png","ui_login_button_privacy_1.png","ui_login_button_privacy_0.png")
    self.mDiscButton:floatUp(20)
    self.mDiscButton:openClickScale()
    self.mDiscButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.DiscBtnClick)
    self.funcBtnLayout:addComponent(self.mDiscButton)

    --@@@@ 删除账号入口
    if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) and device.platform == "ios" then
        if (AvalonUtil.checkTargetVersionCompar(AvalonUtil.getMyVersion(), DELETE_BTN_VERSION_LIMIT)) then 
            self._deleteBtnShow = true
        end

        if self._deleteBtnShow then
            self.mDeleteRoleBtn = UI.Button:create()
            self.mDeleteRoleBtn:init("ui_login_button_deleteaccount_0.png","ui_login_button_deleteaccount_1.png","ui_login_button_deleteaccount_0.png")
            self.mDeleteRoleBtn:floatUp(20)
            self.mDeleteRoleBtn:openClickScale()
            self.mDeleteRoleBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
                self:openDeleteRole()
            end)
            self.mDeleteRoleBtn:hide()
            self.funcBtnLayout:addComponent(self.mDeleteRoleBtn)
        end
    end

--     CO-23068
-- 登录界面增加账号转移入口
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)
    if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING then
        self.mAccountTransferBtn = UI.Button:create()
        self.mAccountTransferBtn:init("ui_login_button_transfer_1.png","ui_login_button_transfer_1.png","ui_login_button_transfer_1.png")
        self.mAccountTransferBtn:floatUp(20)
        self.mAccountTransferBtn:openClickScale()
        self.mAccountTransferBtn:addEventListener(UI.Event.BUTTON_CLICK, self,self.onOpenTransfer)
        self.mAccountTransferBtn:setText("账号转移")
        self.mAccountTransferBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 243, g = 215, b = 100})
        self.mAccountTransferBtn:setTextOffset(0,30)
        self.funcBtnLayout:addComponent(self.mAccountTransferBtn)
    end


end

function MainLayer:openDeleteRole()
    ServerConfigUtil:GlobelIOSQueryAreaListConfig(function(roleList)
        print("roleList ======== ")
        dump(roleList)

        -- mvc.openPanel("DeleteAccountRole", "DeleteAccountRole",1 ,roleList)

        local deleteAccountRoleLayer = UI.DeleteAccountRoleLayer:create(1 ,roleList)
        deleteAccountRoleLayer:center(0, -10)
        self:addChild(deleteAccountRoleLayer,UI_ZORDER.NOTICE)

        deleteAccountRoleLayer:setDeleteRoleCallBack(function()
            UI.ScrollBar:createByText(UI.TEXT_222306)
            SdkBox:getInstance():logout()
        end)

    end, function()
        -- 超时
        UI.ScrollBar:createByTextID(1113854)
    end)
end

function MainLayer:initCountryButtons()
    -- 宿主层
    self.countryBtnLayer = UI.Component:create()
    self.countryBtnLayer:init()
    self.countryBtnLayer:leftBottom(0, 0)
    self.countryBtnLayer:setSize(size.width, size.height)
    self.uiLayer:addChild(self.countryBtnLayer)

    self.countryBtnLayout = UI.Layout:create()
    self.countryBtnLayout:init()
    self.countryBtnLayout:enableAutoHeight()
    self.countryBtnLayout:enableAutoWidth()
    self.countryBtnLayout:leftBottom(30, 50)
    self.countryBtnLayout:enableIrregularShapeScreenAdjustment(true)
    self.countryBtnLayer:addChild(self.countryBtnLayout)

    --适龄提示
    self.mAgeReminderButton = UI.Button:create()
    self.mAgeReminderButton:init("ui_login_button_prompt_0.png","ui_login_button_prompt_1.png","ui_login_button_prompt_0.png")
    self.mAgeReminderButton:floatBottom(20)
    self.mAgeReminderButton:openClickScale()
    self.mAgeReminderButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        local ageReminderDialog = UI.AgeReminderDialog:create()
        ageReminderDialog:center(0, -10)
        self:addChild(ageReminderDialog,UI_ZORDER.NOTICE)
        ageReminderDialog:showNotice();
    end)
    self.countryBtnLayout:addComponent(self.mAgeReminderButton)

end

function MainLayer:openForumBtns()
    if self.mLocalForumBtnBg == nil  then
        self.mLocalForumBtnBg = cc.Sprite:createWithSpriteFrameName("ui_login_button_bg.png")
        self.mLocalForumBtnBg:setAnchorPoint(1, 0)
        self.mLocalForumBtnBg:setPosition(22, 0)
        self.mForumBtn:addChild(self.mLocalForumBtnBg, -2)
        self.mLocalForumBtnBg:setScaleX(0)
        self.mLocalForumBtnBg:hide()
    end
    if self.mFbForumBtn == nil  then
        self.mFbForumBtn = UI.Button:create()
        self.mFbForumBtn:init("ui_login_button_fb_0.png","ui_login_button_fb_1.png","ui_login_button_fb_0.png")
        self.mFbForumBtn:centerLeft(-10)
        self.mFbForumBtn:openClickScale()
        self.mFbForumBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
            GameManager:openUrl(ServerConfigUtil:getFbForumUrl())
        end)
        self.mLocalForumBtnBg:addChild(self.mFbForumBtn)
    end

    -- CO-14913 Global屏蔽论坛功能入口
    -- if self.mSelfForumBtn == nil  then
    --     self.mSelfForumBtn = UI.Button:create()
    --     self.mSelfForumBtn:init("ui_login_button_forum_0.png","ui_login_button_forum_1.png","ui_login_button_forum_0.png")
    --     self.mSelfForumBtn:centerLeft(-10)
    --     self.mSelfForumBtn:openClickScale()
    --     self.mSelfForumBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
    --         GameManager:openUrl(ServerConfigUtil:getSelfForumUrl())
    --     end)
    --     self.mLocalForumBtnBg:addChild(self.mSelfForumBtn)
    -- end

    local btnList = {}
    table.insert(btnList, self.mFbForumBtn)
    -- table.insert(btnList, self.mSelfForumBtn)
    for k, v in ipairs(btnList) do
        v:setPositionX(27 + 54 * (k - 1))
    end

    local size = #btnList
    if self.mLocalForumBtnBg:isVisible() then
        --隐藏
        local scaleInAction = cc.ScaleTo:create(size * 0.05, 0, 1)
        self.mLocalForumBtnBg:runAction(cc.Sequence:create(scaleInAction, cc.CallFunc:create(function() 
            self.mLocalForumBtnBg:hide() 
            self.mFbForumBtn:hide()
            -- self.mSelfForumBtn:hide()
        end)))
    else
        --出现
        self.mLocalForumBtnBg:show()
        self.mFbForumBtn:show()
        -- self.mSelfForumBtn:show()
        local scaleInAction = cc.ScaleTo:create(size * 0.05, 1, 1)
        self.mLocalForumBtnBg:runAction(scaleInAction)
    end
end
-- 显示调试登录按钮
function MainLayer:initTestAccountInput()
    self.testUILayer = UI.Component:create(nil, nil, size.width, size.height)
    self.testUILayer:init()
    self.uiLayer:addChild(self.testUILayer, 100)
    
    local gmUtilExecutor = require("app.ui.gmUtil.GMUtilExecutor")
    if  DEVELOPMENT_MODE and 
        (device.platform == "mac" or device.platform == "windows" or device.platform == "ios" or device.platform == "android") and 
        gmUtilExecutor:getShowTestUI(false)
    then
        -- 显示账号输入
        local identify = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify,"")
        if(identify == "") then
            identify = string.format("%d:%d", AvalonUtil.getCurrentTime(), math.random(100000,10000000))
            cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, identify)
            cc.UserDefault:getInstance():flush()
        end
        
        local libIDEdit = cc.EditBox:create({width = 300, height = 40}, cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"),cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"),cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"))
        libIDEdit:setFontSize(22)
        libIDEdit:setPlaceHolder("请输入随机一段数字作为账号")
        libIDEdit:setPlaceholderFontSize(18)
        libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
        libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
        libIDEdit:setPosition(size.width / 2, 20)
        libIDEdit:setText(identify)
        libIDEdit:setAnchorPoint(0, 1)
        libIDEdit:setPosition(size.width - 420, size.height - 50)
        self.testUILayer:addChild(libIDEdit)

        gameLoginManager:getInstance():setAccountId(identify)

        libIDEdit:registerScriptEditBoxHandler(function (eventType)
            if eventType == "began" then
            elseif eventType == "ended" then
            elseif eventType == "changed" then
                -- local message = self:judeInputTextLength()
            elseif eventType == "return" then
                identify = libIDEdit:getText() or ""
                libIDEdit:setText(identify)
                gameLoginManager:getInstance():setAccountId(identify)
                cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, identify)
                cc.UserDefault:getInstance():flush()
            end
        end)

        -- 显示 DeviceID
        local deviceIdText = cc.EditBox:create({width = 400, height = 40}, cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"),cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"),cc.Scale9Sprite:createWithSpriteFrameName("ui_editor_nine_box_1.png"))
        deviceIdText:setFontSize(22)
        deviceIdText:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
        deviceIdText:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
        deviceIdText:setPosition(size.width -420, size.height - 10)
        deviceIdText:setAnchorPoint(0, 1)
        deviceIdText:setText("DeviceID: " .. AvalonUtil.getDeviceID())
        self.testUILayer:addChild(deviceIdText)

        -- DEV强制服务器IP
        local adultTypeText = UI.EditBox:create(150, 30)
        adultTypeText:init("防沉迷模式", cc.EDITBOX_INPUT_MODE_NUMBER, "ui_editor_nine_box_1.png", 5, 5)
        adultTypeText:rightBottom(50, 90)
        adultTypeText:setReturnCallback(function(text)
            require "app.utils.AntiAddictionUtil"
            AntiAddictionUtil:setAntiAddictionOverride(text)
        end)
        self.testUILayer:addChild(adultTypeText)

        -- DEV强制服务器IP
        local ipText = UI.EditBox:create(150, 30)
        ipText:init("服务器IP", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        ipText:rightBottom(50, 50)
        ipText:setReturnCallback(function(text)
            ServerConfigUtil:setServerIPOverride(text)
        end)
        ipText:setText(ServerConfigUtil:getServerIPOverride())
        self.testUILayer:addChild(ipText)

        -- DEV强制服务器端口
        local portText = UI.EditBox:create(150, 30)
        portText:init("服务器端口", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        portText:rightBottom(50, 10)
        portText:setReturnCallback(function(text)
            ServerConfigUtil:setServerPortOverride(text)
        end)
        portText:setText(ServerConfigUtil:getServerPortOverride())
        self.testUILayer:addChild(portText)


        -- Json名字
        local jsonInput = UI.EditBox:create(430, 30)
        jsonInput:init("Json名字(不含.json,多个以;隔开)", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        jsonInput:rightBottom(50, 290)
        self.testUILayer:addChild(jsonInput)

        -- Atlas名字
        local atlasInput = UI.EditBox:create(430, 30)
        atlasInput:init("Atlas名字(如果不同)", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        atlasInput:rightBottom(50, 250)
        self.testUILayer:addChild(atlasInput)

        -- -- 动画名
        -- local aniInput = UI.EditBox:create(90, 30)
        -- aniInput:init("动画名", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        -- aniInput:rightBottom(50, 210)
        -- self.testUILayer:addChild(aniInput)

        -- -- 数量
        -- local amountInput = UI.EditBox:create(170, 30)
        -- amountInput:init("数量(默认100)", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        -- amountInput:rightBottom(50, 170)
        -- self.testUILayer:addChild(amountInput)

        -- 测试按钮

        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(100, 30)
        testButton:enableDebugDraw()
        testButton:setText("开始测试")
        testButton:rightBottom(50, 210)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local atlasText = atlasInput:getText()
            local jsonText = jsonInput:getText()
            -- local aniText = aniInput:getText()
            -- local amountText = amountInput:getText()
    
            if atlasText == "" then atlasText = nil end
            if jsonText == "" then jsonText = nil end
            -- if aniText == "" then aniText = nil end
            -- if amountText == "" then amountText = nil end
    
            if (not jsonText) then
                UI.ScrollBar:createByText("json名字没有填好")
                return
            end
            local arr = string.split(jsonText, ";")
            local atArr = {}
            if(atlasText) then 
                atArr = string.split(atlasText, ";")
            end
            local jsonArr = {}
            if(arr and #arr > 0) then 
                for k, v in ipairs(arr) do 
                    local oneData = {}
                    oneData.jsonName = v
                    if(atArr[k] and atArr[k] ~= "") then 
                        oneData.atlasName = atArr[k]
                    end
                    table.insert(jsonArr, oneData)
                end
            end
    
            local executor = require("app.ui.gmUtil.GMUtilExecutor")
            executor:batchTestAnimationPerformance(jsonArr)
            -- executor:testAnimationPerformance(atlasText, jsonText, aniText, tonumber(amountText))
        end)
        self.testUILayer:addChild(testButton, 1000)

        -- 添加全部测试动画处理
        local startY = 330
        local noticeText = UI.Text:create()
        noticeText:init("（开发人员使用）点击\"批量测试之前\"需要在tools.lua \n里面执行命令:lua tools.lua makeJsonArrFromPath", 
            UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_GREEN)
        noticeText:rightBottom(50, startY + 40)
        self.testUILayer:addChild(noticeText, 10000)

        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(200, 30)
        testButton:enableDebugDraw()
        testButton:setText("批量测试（开发使用）")
        testButton:rightBottom(50, startY)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local executor = require("app.ui.gmUtil.GMUtilExecutor")
            executor:batchAllAnimation()
        end)
        self.testUILayer:addChild(testButton, 1000)

        -- 测试多语言
        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(100, 30)
        testButton:enableDebugDraw()
        testButton:setText("测试多语言")
        testButton:rightBottom(50, 168)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            require ("res/ResourceCN/ProfileLanguage")
            require ("res/ResourceCNTRA/ProfileLanguage")
            require ("res/ResourceEN/ProfileLanguage")
            require ("res/ResourceKR/ProfileLanguage")
            require ("res/ResourceRU/ProfileLanguage")
            require ("res/ResourceTH/ProfileLanguage")
        end)
        self.testUILayer:addChild(testButton, 1000)

        -- 测试主角动画效率
        local startY = 420

        local noticeText = UI.Text:create()
        noticeText:init("（开发人员使用）点击\"开始测试主角\"需要在tools.lua \n里面执行命令:lua tools.lua makeJsonArrFromPath", 
            UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_GREEN)
        noticeText:rightBottom(50, startY + 80)
        self.testUILayer:addChild(noticeText, 10000)

        local wearEquipInput = UI.EditBox:create(430, 30)
        wearEquipInput:init("需要添加的装备，以;隔开", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        wearEquipInput:rightBottom(50, startY + 40)
        self.testUILayer:addChild(wearEquipInput)

        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(200, 30)
        testButton:enableDebugDraw()
        testButton:setText("开始测试主角")
        testButton:rightBottom(50, startY)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local wearEquipText = wearEquipInput:getText()
            if wearEquipText == "" then wearEquipText = nil end
            local wearArr = {}
            if(wearEquipText) then 
                wearArr = string.split(wearEquipText, ";")
            end
            local equipmentArr = {}
            require "app.datas.GoodsDataManager"
            require "app.datas.SkillDataManager"
            for k, v in ipairs(wearArr) do 
                local equipmentData = GoodsDataManager:createEquipmentForEquipmentID(tonumber(v))

                table.insert(equipmentArr, equipmentData)
            end

            local executor = require("app.ui.gmUtil.GMUtilExecutor")
            executor:batchHeroAnimation(equipmentArr)
        end)
        self.testUILayer:addChild(testButton, 1000)

        -- 处理接管需求
        local startY = 210
        local channelInput = UI.EditBox:create(430, 30)
        channelInput:init("账号：渠道_用户名 eg:1_hu_0422", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        channelInput:leftBottom(50, startY + 80)
        self.testUILayer:addChild(channelInput)
        if(GLOBAL_TEST_CHANNEL_STR) then 
            channelInput:setText(GLOBAL_TEST_CHANNEL_STR)
        end

        local debugKeyInput = UI.EditBox:create(430, 30)
        debugKeyInput:init("debugkey:有运营在后台添加接管的时候设置的值", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        debugKeyInput:leftBottom(50, startY + 40)
        self.testUILayer:addChild(debugKeyInput)
        if(GLOBAL_TEST_CHANNEL_DEBUG_KEY_STR) then 
            debugKeyInput:setText(GLOBAL_TEST_CHANNEL_DEBUG_KEY_STR)
        end

        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(200, 30)
        testButton:enableDebugDraw()
        testButton:setText("开始接管")
        testButton:leftBottom(50 + 230, startY)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local channelText = channelInput:getText()
            local debugKeyText = debugKeyInput:getText()
            if channelText == "" then channelText = nil end
            if debugKeyText == "" then debugKeyText = nil end
            
            GLOBAL_TEST_CHANNEL_STR = channelText
            GLOBAL_TEST_CHANNEL_DEBUG_KEY_STR = debugKeyText
        end)
        self.testUILayer:addChild(testButton, 1000)


        -- 区服切换
        local ServerList = {
            {key = "内网主干" ,value = "http://cave2-all-trunk-cs-verchk-0000.avalongames.com:4002"},
            {key = "内网beta" ,value = "http://cave2-all-beta-cs-verchk-0000.avalongames.com:4002"},
            {key = "内网official" ,value = "http://cave2-all-all-cs-verchk-0000.avalongames.com:4002"},
            {key = "外网测试Beta" ,value = "http://cave2-all-sz-beta-verchk-0000.avalongames.cn"},
            {key = "外网测试Trunk" ,value = "http://cave2-all-sz-trunk-verchk-0001.avalongames.cn"},
            {key = "外网测试TAG" ,value = "http://cave2-all-hk-tag-verchk-0000.avalongames.cn"},
            {key = "外网测试Global" ,value = "http://cave2-all-hk-cs-verchk-0000.avalongames.cn"},
            {key = "外网测试CN" ,value = "http://cave2-all-hk-cntest-verchk-0000.avalongames.cn"},
            {key = "预发布Global" ,value = "http://cave2-all-global-pre-verchk-0001.avalongames.com"},
            {key = "预发布CN_正式" ,value = "http://caveaccesstyzs.leiting.com"},
            {key = "内测专区" ,value = "http://caveaccessxf.leiting.com"},
            {key = "正式服Global" ,value = "http://cave2-all-global-zs-verchk-0000.avalongames.com"},
            {key = "正式服CN" ,value = "http://caveaccess.leiting.com"},
            {key = "正式服CN_BILIBILI" ,value = "http://caveaccessbb.leiting.com"},
            {key = "预发布Beta" ,value = "http://caveaccessty.leiting.com"},
            {key = "迁移测试服" ,value = "http://cave2-all-global-zs-verchk-0001.avalongames.com"},
        }

        local getServerForKey = function(key) 
            for k, v in pairs(ServerList) do 
                if(v.key == key) then 
                    return v
                end
            end
            return nil
        end

        local getServerForValue = function(value) 
            for k, v in pairs(ServerList) do 
                if(v.value == value) then 
                    return v
                end
            end
            return nil
        end

        local startY = 330
        local testServerConfigUrl = cc.UserDefault:getInstance():getStringForKey("TEST_SERVER_CONFIG_URL", "")

        -- local testServerInput = UI.EditBox:create(430, 30)
        -- testServerInput:init("请输入要连接的区服", cc.EDITBOX_INPUT_MODE_ANY, "ui_editor_nine_box_1.png", 5, 5)
        -- testServerInput:leftBottom(50, startY + 30)
        -- testServerInput:setText(testServerConfigUrl)
        -- self.testUILayer:addChild(testServerInput)


        -- 服务器列表
        local serverListHost = UI.Layout:create()
        serverListHost:init()
        serverListHost:leftBottom(50, startY + 30)
        self.testUILayer:addChild(serverListHost)
        self.serverListHost = serverListHost


        local serverListBg = cc.LayerColor:create(cc.c4b(255,255,255,20))
        serverListBg:setContentSize(200, 220)
        serverListHost:addChild(serverListBg)
        self.serverListBg = serverListBg

        -- 创建中心区域
        local upLayout = UI.Layout:create()
        upLayout:init()
        upLayout:centerUp(0)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:setSize(200, 210)
        detailedScrollView:init(0, 0, 0, 0)
        detailedScrollView:leftBottom(10, 10)
        detailedScrollView:addInnerNode(upLayout)
        serverListHost:addChild(detailedScrollView)
        self.detailedScrollView = detailedScrollView

        -- 服务器按钮
        local serverButton = UI.ButtonS9:create(230, 30)
        serverButton:init("", "ui_login_banner_server_1.png", "ui_login_banner_server_1.png")
        serverButton:leftBottom(50, startY + 0)
        serverButton:setOnClicked(function()
            self:showServerList(not self.serverListHost:isVisible())
        end)
        self.testUILayer:addChild(serverButton)
        self.serverButton = serverButton


        -- 按钮上面的箭头
        local serverArrow = UI.Image:create();
        serverArrow:init("ui_login_button_triangle.png")
        serverArrow:centerRight(0)
        serverButton:addChild(serverArrow,1)
        self.serverArrow = serverArrow
        

        local curServerColor = nil;

        local curServer = UI.Text:create();
        curServer:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX)
        curServer:centerLeft(10)
        serverButton:addChild(curServer,2)

        local serverConfig = getServerForValue(SERVER_CONFIG_URL)
        if(serverConfig) then 
            curServer:setText(serverConfig.key)
        end

        local function localSetCurrentServerLabel(zoneId, manualSelect)            
            self:showServerList(false)
            curServer:setText(zoneId)
        end

        local serverNames = {}
        for i, cfg in pairs(ServerList) do
            -- 一行的运载行
            local entry = UI.Layout:create()
            entry:init()
            entry:setSize(200, 30)
            entry:leftBottom(5,(i - 1) * 30)
            entry:setAnchorPoint(0.5, 0.5)
            entry:setTouchEnable(true)
            entry:setSwallowTouches(false);
            entry:setEnableMinTouchSize(false)
            upLayout:addComponent(entry)
            entry:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
                if (self.disableClick == true) then return end
                localSetCurrentServerLabel(cfg.key)                
            end )
            entry:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self,function ()
                -- entry:scaleTo(1.1,0)
            end )
            entry:addEventListener(UI.Event.COMPONENT_DRAG_ENDED, self,function ()
                -- entry:scaleTo(1,0)
            end )

            -- 一行的左边, 服务器名字
            local serverNameString = tostring(cfg.key) or UI.TEXT_111138
            local serverName = UI.Text:create()
            serverName:init(serverNameString, UI.SYS_FONT, UI.FONT_SIZE_16PX)
            serverName:leftBottom(0, 0)
            entry:addComponent(serverName)
            table.insert(serverNames,serverName)
        end
        upLayout:setSize(146, table.nums(ServerList) * 30);
        detailedScrollView:scrollToBottom()
        self:showServerList(false)


        local testButton = UI.Button:create()
        testButton:init()
        testButton:setSize(200, 30)
        testButton:enableDebugDraw()
        testButton:setText("区服切换")
        testButton:leftBottom(50 + 230, startY)
        testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local nameKey = curServer:getText()
            local serverConfig = getServerForKey(nameKey)
            if(serverConfig == nil) then 
                return
            end
            local testServerText = serverConfig.value
            if testServerText == "" then testServerText = nil end
            local foundServer = nil
            if(testServerText) then
                testServerText = string.gsub(testServerText, "\n", "")
                for k, v in pairs(ServerList) do 
                    if(testServerText == v.value) then 
                        foundServer = v
                        break
                    end
                end
            end

            if(testServerText == nil or (not foundServer)) then
                cc.UserDefault:getInstance():setStringForKey("TEST_SERVER_CONFIG_URL", "")
                require "app.ui.common.Dialog.ScrollBar" 
                UI.ScrollBar:createByText("清空了修改服务器切换")
            else 
                cc.UserDefault:getInstance():setStringForKey("TEST_SERVER_CONFIG_URL", testServerText)
                UI.ScrollBar:createByText("选择了:".. foundServer.key.."  区服，请重启程序！")
            end
        end)
        self.testUILayer:addChild(testButton, 1000)
    end
    
end

function MainLayer:showServerList(isShow, isAnimated)
    if (isAnimated == nil) then isAnimated = true end

    local function setListVisible(isVisible)
        self.serverListHost:setVisible(isVisible)
        self.disableClick = not isVisible
    end
    self.serverListHost:stopAllActions()
    if (isShow) then
        if (isAnimated) then 
            self.serverListHost:runAction(cc.EaseSineOut:create(cc.ScaleTo:create(0.2, 1, 1)))
        end
        setListVisible(true)
    else
        if (isAnimated) then
            self.serverListHost:runAction(cc.Sequence:create(
                cc.ScaleTo:create(0.05, 1, 0),
                cc.CallFunc:create(function() setListVisible(false) end)))
        else
            setListVisible(false)
        end
    end

    if (not self.serverArrow) then return end
    self.serverArrow:setImageScaleY(ifelse(isShow,-1 , 1))
end

function MainLayer:initShareLayer()
end

function MainLayer:initServerSelector()
    self.mServerSelectorLayer = UI.Component:create()
    self.mServerSelectorLayer:init()
    self.mServerSelectorLayer:leftBottom(0, 0)
    self.mServerSelectorLayer:setSize(size.width, size.height)
    self.uiLayer:addChild(self.mServerSelectorLayer, 10)

    self.mServerSelector = UI.MainLayerServerList:create()
    self.mServerSelector:init()
    self.mServerSelector:leftBottom(0, 37)
    self.mServerSelector:enableIrregularShapeScreenAdjustment(true)
    self.mServerSelectorLayer:addChild(self.mServerSelector)
end

-- 显示登录界面
function MainLayer:showLoading(delayCancel)
    self:setLoginButtonEnabled(false)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_OTHER, 99999)

    if checkint(delayCancel) > 0 then
        Avalon.Scheduler:unscheduleUpdate(self, self.scheduleEnd)
        Avalon.Scheduler:scheduleUpdateOnce(self, self.scheduleEnd, delayCancel)
    end
end

-- 隐藏登录界面
function MainLayer:hideLoading()
    self:setLoginButtonEnabled(true)
    UI.WaitingLayer:hideWaiting()
    Avalon.Scheduler:unscheduleUpdate(self, self.scheduleEnd)
end

-- 倒计时结束
function MainLayer:scheduleEnd()
    self:setLoginButtonEnabled(true)
    UI.WaitingLayer:hideWaiting()
end

-- 设置登录按钮是否可用
function MainLayer:setLoginButtonEnabled(b)
    if (self and not tolua.isnull(self)) then
        self._loginButtonEnabled = b
    end
end

-- 弹出登出SDK提示框
function MainLayer:showComfirmLogoutSDK(text)
    UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(text, function()
        SdkBox:getInstance():logout()
    end)
end

-- 出场动画
function MainLayer:animateOut(callback)
    if (tolua.isnull(self.bgLayer)) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_LOGIN, self, callback)
    else
        self.bgLayer:centerCamera(true, true, function()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_LOGIN, self, callback)
        end)
    end
end

function MainLayer:moveXY00ObjOutOfScreen(obj)
    obj:leftBottom(size.width, size.height)
end

function MainLayer:moveXY00ObjBackTo00(obj)
    obj:leftBottom(0, 0)
end

function MainLayer:removeServerSelector()
    self.mServerSelectorLayer:removeFromParent()
end

function MainLayer:hideServerSelector()
    self:moveXY00ObjOutOfScreen(self.mServerSelectorLayer)
    self.mServerSelectorLayer:hide()
end

function MainLayer:showServerSelector()
    self:moveXY00ObjBackTo00(self.mServerSelectorLayer)
    self.mServerSelectorLayer:show()
end

function MainLayer:hideTestAccountInput()
    self:moveXY00ObjOutOfScreen(self.testUILayer)
    self.testUILayer:hide()
end

function MainLayer:showTestAccountInput()
    self:moveXY00ObjBackTo00(self.testUILayer)
    self.testUILayer:show()
end

function MainLayer:hideSDKLoginButtons()
    self:moveXY00ObjOutOfScreen(self.mSDKLoginButtonLayer)
    self.mSDKLoginButtonLayer:hide()
end

function MainLayer:showSDKLoginButtons()
    self:moveXY00ObjBackTo00(self.mSDKLoginButtonLayer)
    self:hideAreaInfo()
    ServerConfigUtil:clearCacheSaveAreaServer()
    self.mSDKLoginButtonLayer:show()
end

function MainLayer:hideGameLoginButtons()
    self:moveXY00ObjOutOfScreen(self.mGameLoginButtonLayer)
    self.mGameLoginButtonLayer:hide()
end

function MainLayer:showGameLoginButtons()
    self:moveXY00ObjBackTo00(self.mGameLoginButtonLayer)
    self.mGameLoginButtonLayer:show()
    self:autoLogin()
end

function MainLayer:hideUserProtocolButtons()
    self:moveXY00ObjOutOfScreen(self.userProtocolLayer)
    self.userProtocolLayer:hide()
end

function MainLayer:showUserProtocolButtons()
    self:moveXY00ObjBackTo00(self.userProtocolLayer)
    self.userProtocolLayer:show()
end


function MainLayer:hideShareLayer()
    -- self:moveXY00ObjOutOfScreen(self.shareLayer)
    -- self.shareLayer:hide()
end

function MainLayer:showShareLayer()
    -- self:moveXY00ObjBackTo00(self.shareLayer)
    -- self.shareLayer:show()
end

function MainLayer:hideStaticComponents()
    self:moveXY00ObjOutOfScreen(self.mStaticComponentLayer)
    self.mStaticComponentLayer:hide()
end

function MainLayer:showStaticComponents()
    self:moveXY00ObjBackTo00(self.mStaticComponentLayer)
    self.mStaticComponentLayer:show()
end

function MainLayer:hideFunctionButtons()
    self:moveXY00ObjOutOfScreen(self.funcBtnLayer)
    self.funcBtnLayer:hide()
end

function MainLayer:showFunctionButtons()
    self:moveXY00ObjBackTo00(self.funcBtnLayer)
    self.funcBtnLayer:show()
end

function MainLayer:hideCountryButtons()
    self:moveXY00ObjOutOfScreen(self.countryBtnLayer)
    self.countryBtnLayer:hide()
end

function MainLayer:showCountryButtons()
    self:moveXY00ObjBackTo00(self.countryBtnLayer)
    self.countryBtnLayer:show()
end

------------------------------ eo 表现 --------------------------------



































------------------------------ 登录 --------------------------------
-- 向WEB获取*沈河*状态
function MainLayer:queryServerReviewConfig()
    print("  222222222222222 ")
    -- 获取服务器列表
    self:showLoading()
    ServerConfigUtil:queryServerReviewConfig(
        function(data) -- 强更
            if not tolua.isnull(self) then
                self:hideLoading() 
                self:checkUpdate(1) -- 1 = 强更, 需要设置状态因为可能现在过场动画还未结束, 结束后会使用此状态再次调用checkUpdate
            end
        end,
        function(data) -- 热更
            if not tolua.isnull(self) then
                self:hideLoading()
                self:checkUpdate(2) -- 2 = 热更, 需要设置状态因为可能现在过场动画还未结束, 结束后会使用此状态再次调用checkUpdate
            end
        end,
        function(data) -- 成功获取
            if not tolua.isnull(self) then
                self:hideLoading()
                self:onReadyToLoginSDK()
            end
        end,
        function() -- 超时
            if not tolua.isnull(self) then
                self:hideLoading()
                self:queryServerTimeout(function()  -- 重试回调
                    self:queryServerReviewConfig()
                end)
            end
        end, function(data) -- 未知状态
            if not tolua.isnull(self) then
                self:hideLoading()
                self:checkSdkLoginStatusCode(data and data.loginStatus or 0,data)
            end
        end)
end

-- 向WEB获取服务器列表
function MainLayer:queryServerListConfig()
    print("  111111111111111111111 ")
    self:showLoading()
    SdkBox:getInstance():setUserActionAvailable(false)
    ServerConfigUtil:queryServerListConfig(
        function()          -- 强更
            -- 目前不应该发生
            SdkBox:getInstance():setUserActionAvailable(true)
        end, function()     -- 热更
            -- 目前不应该发生
            SdkBox:getInstance():setUserActionAvailable(true)
        end, function(data) -- 成功
            if not tolua.isnull(self) then
                self:hideLoading()
                SdkBox:getInstance():setUserActionAvailable(true)
                self:onReadyToLoginGame()
            end
        end, function()     -- 超时
            if not tolua.isnull(self) then
                self:hideLoading()
                SdkBox:getInstance():setUserActionAvailable(true)
                self:queryServerTimeout(function()  -- 重试回调
                    self:queryServerListConfig()
                end)
            end
        end, function(data) -- 未知状态
            if not tolua.isnull(self) then
                self:hideLoading()
                SdkBox:getInstance():setUserActionAvailable(true)
                self:checkSdkLoginStatusCode(data and data.loginStatus or 0,data)
            end
        end)
end

-- 向Web服务器请求超时
function MainLayer:queryServerTimeout(retryCallback)
    -- TOOD 判断网络状态
    local timeoutTips = UI.Tips:createTips(
        LanguageManager:getInstance():getLocalString(1110249) .. ".",
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL,
        UI.TipsButtonType.TEXT_BUTTON
    )
    timeoutTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        if (retryCallback) then retryCallback() end
    end)
    timeoutTips:addEventListener(UIEvent.DIALOG_CANCEL, self, function()
        -- cc.Director:getInstance():endToLua()
        -- os.exit()
        require "app.utils.ToolsUtil"
        ToolsUtil:exitApp()
    end)
    -- todo 需要额外多加入一些参数
    printError("queryServerReviewConfig error")
end

-- 检查热更或者强更, 1 = 强更, 2 = 热更
-- 会在Web返回后和场景进入后调用
function MainLayer:checkUpdate(updateStatus)
    print("==========MainLayer:checkUpdate", ServerConfigUtil:gotReviewResponse(), updateStatus)
    local projectId = ServerConfigUtil:getProjectId()
    if (projectId == "cave_online_all_internal" or projectId == "cave_online_beta_internal" or
        projectId == "cave_online_trunk_internal") and CONFIG_HOTFIX == false then  --CO-内网测试(beta)  CO-内网测试(主干) CO-内网测试(official)   
        return
    end
    if (updateStatus) then
        self.updateStatus = updateStatus
    end
    if (self._isSceneEntered and ServerConfigUtil:gotReviewResponse()) then
        if (self.updateStatus == 1) then
            self:updateComponentsVisibility()
            self:forceUpdate()
        elseif (self.updateStatus == 2) then
            self:updateComponentsVisibility()
            self:checkHotFix()
        end
    end
end

-- 强更
function MainLayer:forceUpdate()
    local forceUpdateTips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111203),
    UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
    forceUpdateTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        -- 上报进入强更
        local params = {}
        -- params.remoteVersion = ServerConfigUtil:getHotFixVersion()
        params.remoteBuild = ServerConfigUtil:getForceUpdateBuild()
        gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.App_Update,1,params,1)
        SdkBox:getInstance():jumpToAppStore(ServerConfigUtil:getForceUpdateUrl(), ServerConfigUtil:getWebConfiguredBundleId())
        -- cc.Director:getInstance():endToLua()
        -- os.exit()
        require "app.utils.ToolsUtil"
        ToolsUtil:exitApp()
    end)
end

-- 热更新
function MainLayer:checkHotFix()
    local size = cc.Director:getInstance():getWinSize()

    -- 加载进度条背景
    local progressBg = UI.Image9:create()
    progressBg:init("ui_tips_banner_countdown_box.png", CCRectMake(0, 0, 244, 11), cc.size(643, 16))
    progressBg:centerBottom(116)
    self:addChild(progressBg)

    -- 加载进度条内容
    local progressTimer = UI.Image9:create()
    progressTimer:init("ui_tips_banner_countdown.png", CCRectMake(120,0,1,9), cc.size(642, 14))
    progressTimer:leftBottom(1, 1)
    progressBg:addChild(progressTimer)
    self._loadingbar = progressTimer

    local loadingText = UI.Text:create()
    loadingText:init(UI.TEXT_1201001, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_HOTFIX_PROGRESS_TEXT)
    loadingText:centerBottom(20)
    progressBg:addChild(loadingText)
    

    -- 热更新开始的打点
    local params = {}
    params.remoteVersion = ServerConfigUtil:getHotFixVersion()
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Start,0,params)

    local CODE = cc.EventAssetsManagerEx.EventCode
    Avalon.HotfixManager:setLocalManifestUrl(ServerConfigUtil:getHotFixManifestUrl())
    Avalon.HotfixManager:checkUpdate(
        function(percent, percentByFile,filename)   -- 过程中
            local maxSize =  Avalon.HotfixManager:getMaxSize()
            local sizemb = tonumber(string.format("%0.2f", maxSize/1024/1024))
            if not sizemb or sizemb <= 0 then sizemb = 0.01 end
            
            local curSize = maxSize/100 *percentByFile
            local cur_sizemb = tonumber(string.format("%0.2f", curSize/1024/1024))
            if not cur_sizemb or cur_sizemb <= 0 then cur_sizemb = 0.01 end
            
            -- UI.TEXT_1201007 = "正在更新%sMB/%sMB"
            -- print("percentByFile",percentByFile)
            loadingText:setText(string.format( UI.TEXT_1201007,cur_sizemb,sizemb))
            self._loadingbar:setSize(642 * math.floor(percentByFile)/100.0, 14)
        end,
        function(code)      -- 成功
            if code == CODE.UPDATE_FINISHED then
                loadingText:setText(UI.TEXT_1201008)
                local scheduler=cc.Director:getInstance():getScheduler()
                local mSchedulerID = scheduler:scheduleScriptFunc(function ()
                    -- 防止线程回调问题
                    Avalon.ResHelper:destroy();
                    cc.Director:getInstance():restart()
                end,1,false)
                local params = {}
                params.remoteVersion = ServerConfigUtil:getHotFixVersion()
                -- 上报热更新流程完成
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Success,0,params)
            elseif code == CODE.ALREADY_UP_TO_DATE then
                -- loadingText:setText(LanguageManager:getInstance():getLocalString())
                loadingText:setText(LanguageManager:getInstance():getLocalString(1111201))
            elseif code == CODE.NEW_VERSION_FOUND then
                loadingText:setText(UI.TEXT_1201005)
            end
        end,
        function(code,data)      -- 失败
            print("===============onError", code)
            local params = {}
            params.remoteVersion = ServerConfigUtil:getHotFixVersion()
            if code == CODE.ERROR_NO_LOCAL_MANIFEST then
                -- 上报读取本地文件失败
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Error
                ,PublicDefine.Hotfix_Error_Type.Hotfix_Read_LocalFile,params,0)
            elseif code == CODE.ERROR_DOWNLOAD_MANIFEST then
                -- 上报下载远程文件失败
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Error,
                PublicDefine.Hotfix_Error_Type.Hotfix_Download_Manifest,params,0)
            elseif code == CODE.ERROR_PARSE_MANIFEST then
                -- 上报解析远程文件失败
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Error,
                PublicDefine.Hotfix_Error_Type.Hotfix_Parse_Manifest,params,0)
            elseif code == CODE.UPDATE_FAILED then
                -- 上报下载资源文件失败
                params.failedFileName = data or "unknown"
                if data then
                    printError("hotUpdate-error", data)
                end
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Hotfix_Error,
                PublicDefine.Hotfix_Error_Type.Hotfix_Download_Files,params,0)
            end
        end)
end

-- 通过HTTPDNS将URL或者IP转化成IP,
function MainLayer:httpdnsGetIPAsync(url, callback, isInit)
    if (not url) then
        printWarn("MainLayer:httpdnsGetIPAsync, url为空")
        return
    else
        printInfo("MainLayer:httpdnsGetIPAsync, HTTPDNS请求", url)
    end

    -- global安卓屏蔽httpdns
    require "app.datas.PublicDefine"
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (device.platform == "android" and versionTarget ~= nil and versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then
        if callback then callback(url) end
        return
    end

    -- 使用httpdns
    local httpdns = avalon.HttpDNSUtil:getInstance()
    if (isInit) then httpdns:init({url}) end
    httpdns:beginQuery(url, function(ip)
        printInfo("MainLayer:httpdnsGetIPAsync, HTTPDNS获取到的IP ",ip)
        if callback then callback(ip) end
    end)
end

-- *沈河*服已返回数据, 可以登录SDK了, 初始化登录按钮
function MainLayer:onReadyToLoginSDK()
    -- 如果在审核中 屏蔽分享功能一整套
    -- 如果是国内CN 子渠道,不显示(暂时只有雷霆官方渠道显示)
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    local channel = SdkBox:getInstance():getVersionChannel()
    channel = checkint(channel)
    if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN then 
        if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
        or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK
        or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
        then
            CONFIG_SHARE = not ServerConfigUtil:isInReview()
            CONFIG_COMMENT = true
        else
            CONFIG_SHARE = false
            CONFIG_COMMENT = true
        end
    elseif versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE  then
        CONFIG_SHARE = false
        CONFIG_COMMENT = false
    else
        CONFIG_SHARE = not ServerConfigUtil:isInReview()
        CONFIG_COMMENT = true
    end

    -- 初始化sdkbox回调
    local sdkbox = SdkBox:getInstance()
    sdkbox:initPlugin({ url = ServerConfigUtil:getLoginVerifyUrl() })
    sdkbox:onSdkLoginSuccess(handler(self,self.onSdkLoginSuccess))
    sdkbox:onSdkLoginFail(handler(self,self.onSdkLoginFail))
    sdkbox:onSdkLogoutSuccess(function()
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111336))
        end, 0.01)
        ServerConfigUtil:clearServerListQueryData()
        -- self:resetLoginButton()
        -- self:updateComponentsVisibility()

        SdkBox:getInstance():setToLogoutGameWhenSDKLogout(true)
        self:removeFromParent()

    end)
    sdkbox:onSdkLogoutFail(function()
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111337))
        end, 0.01)
    end)

    -- 更新动态按钮(登录相关按钮)
    self:updateComponentsVisibility()
    
    -- 检查是否保存已经登录了的SDK
    local savedSDK = SdkBox:getInstance():readUserDataLoginType()
    if (savedSDK ~= 0) then
        self:loginSDK(savedSDK)
    end
end

-- 开始登录SDK
-- loginAccount只有在多种登录方式的时候才会有用, 否则使用Target默认登录方式
-- iOS Global: Facebook, Gamecenter, Guest <--需要传入loginAccount
-- iOS CN    : 雷霆
-- AND Global: GooglePlay
-- AND CN    : 雷霆接入多渠道
-- 安卓CN使用雷霆SDK时不适用此参数, 雷霆自己会接入其他账号DSK
function MainLayer:loginSDK(loginAccount)
    if (not ServerConfigUtil:gotValidData()) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110873))
        return 
    end
    printInfo("MainLayer:loginSDK, loginAccount: ", loginAccount)
    

    -- 雷霆SDK没有登录回调, 禁用登录按钮3秒后直接解除禁用
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE) then
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            SdkBox:getInstance():onUserActionListener() -- 因为雷霆SDK没有登录失败回调, 特殊处理, 超时后空回调一次清除禁用登录
        end, 3)
    else
        self:showLoading()
    end
    self._clickLoginType = loginAccount

    -- 上报唤起第三方登录
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Third_Login)
    
    -- 开始登录
    -- Game.Manager:initLoginModules()
    if (DEVELOPMENT_MODE) then
        local uuid = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify,"")
        SdkBox:getInstance():loginCustom({
            versionAccount = loginAccount,
            url = ServerConfigUtil:getLoginVerifyUrl(),
            uuid = uuid
        })
    else
        SdkBox:getInstance():loginCustom({
            versionAccount = loginAccount,
            url = ServerConfigUtil:getLoginVerifyUrl()
        })
    end
end

-- 可以登录游戏了, 更新界面为登录游戏的状态
function MainLayer:onReadyToLoginGame()
    -- 加载完成后设置账号管理可用(因为雷霆没有取消登录回调, 避免一些网络延迟高的时候会发生的误操作)
    self._isAcButtonDisabled = false

    -- 预加载spine资源
    self:loadLoadingSpine()

    -- 检查用户协议是否被同意
    self:showUserProtocolAllowCheckIcon()

    -- 更新动态按钮(登录相关按钮)
    self:updateComponentsVisibility()

    -- 预加载一次HttpDns
    self:httpdnsGetIPAsync(ServerConfigUtil:getGateHost(), nil, true)

    -- 初始化服务器列表选择器. 注意:这个模块里面会重建内容, 需要清除过后重建.
    self:removeServerSelector()
    self:initServerSelector()
    self.mServerSelector:initServerSelector(ServerConfigUtil:getServerList(), function(cfg) --手动选择回调
        self:getLoginNotice()
    end)

    -- 初始化登录模块
    Game.Manager:initLoginModules()

    -- 第一次自动弹出显示用户协议
    if (not self:tryShowUserProtocolDilog()) then
        -- 显示登录提示
        self:getLoginNotice()
    end
end

function MainLayer:autoLogin()
    if self.mGameLoginButtonLayer and self.mGameLoginButtonLayer:isVisible() and ServerConfigUtil:getCurrentCfg() ~= nil then
        local isDeepLink, str = SdkBox:getInstance():getDeepLinkParams()
        if isDeepLink then
            self:loginGame(true)
        end
    end
end

-- 执行登录游戏
function MainLayer:loginGame(isAuto)
    if isAuto ~= true and not self:checkUserProtocol() then
        return
    end

    -- add by zp 这里直接把防沉迷给去掉，直接采用服务器防沉迷 CO-12527 内测专区屏蔽掉老的防沉迷功能（客户端）
    -- -- 请求防沉迷
    -- ServerConfigUtil:queryAntiAddiction(function(isSucc, reason, msg)
        -- 向WEB请求账号ID
        self:showLoading()
        ServerConfigUtil:queryGameLogin(
            function(data)      -- 强更
                self:hideLoading() 
                self:checkUpdate(1) -- 1 = 强更, 需要设置状态因为可能现在过场动画还未结束, 结束后会使用此状态再次调用checkUpdate
            end, function(data) -- 热更
                self:hideLoading()
                self:checkUpdate(2) -- 2 = 热更, 需要设置状态因为可能现在过场动画还未结束, 结束后会使用此状态再次调用checkUpdate
            end, function(data) -- 成功
                self:hideLoading()

                -- 设置登录模块参数, 然后执行连接
                -- 处理测试账号, 如果是以test_打头的测试账号, 去掉五段式
                local accountId = data.accountId
                local testPlayerID = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify,"")
                if (testPlayerID:sub(1, 5):lower() == "test_") then
                    printInfo("MainLayer:loginGame(), 测试账号以test_开头, 裁剪五段式: ", accountId, testPlayerID)
                    accountId = testPlayerID
                end

                -- 设置登录参数
                gameLoginManager:getInstance():setAccountId(accountId)
                gameLoginManager:getInstance():setVersionChannel(SdkBox:getInstance():getVersionChannel())
                gameLoginManager:getInstance():setVersionAccount(SdkBox:getInstance():getVersionAccount())
                gameLoginManager:getInstance():setServerPort(ServerConfigUtil:getGatePort())
                gameLoginManager:getInstance():setServerId(ServerConfigUtil:getZoneId())
                gameLoginManager:getInstance():setServerName(ServerConfigUtil:getName())
                gameLoginManager:getInstance():setNickName(ServerConfigUtil:getNickName())

                -- 用户协议打点
                UI.UserProtocolDialog.trySendRecord(true)

                -- 连接游戏服务器
                self:tryConnectToGameServer()
            end, function(data) -- 超时
                self:hideLoading()
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110249))
            end, function(data) -- 未知状态
                self:hideLoading()
                self:checkSdkLoginStatusCode(data and data.loginStatus or 0, data)
            end)
    -- end)
end

-- 检查登录成功状态码并作出相应动作
function MainLayer:checkSdkLoginStatusCode(loginStatus,data)
    printInfo("MainLayer:checkSdkLoginStatusCode:", loginStatus)
    local loginStatusNum = tonumber(loginStatus)
    if (loginStatusNum == PublicDefine.LoginStatus.Success) then return true end

    -- 默认弹出提示(未知错误)
    local toastLanguageID = 1110382
    if (loginStatusNum == PublicDefine.LoginStatus.ServerMaintenance) then
        -- 服务器维护中
        toastLanguageID = nil
        local serverMainteTip = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111124), UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
        serverMainteTip:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            self:onOpenNotice()
        end)
    elseif (loginStatusNum == PublicDefine.LoginStatus.ReachMaxOnlineNum) then
        -- 达到人数上限
        toastLanguageID = nil
        UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111125), UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
    elseif (loginStatusNum == PublicDefine.LoginStatus.AuthenticateFailed) then
        -- 登录授权失败
        toastLanguageID = nil
        self:showComfirmLogoutSDK(LanguageManager:getInstance():getLocalString(1111126))
    elseif (loginStatusNum == PublicDefine.LoginStatus.NeedForceUpdate or loginStatusNum == PublicDefine.LoginStatus.NeedHotFix) then
        -- 需要强更或者热更
        toastLanguageID = nil
        self:queryServerReviewConfig()
    elseif (loginStatusNum == PublicDefine.LoginStatus.ServerFlashMaintenance) then
        -- 闪断更新提示
        toastLanguageID = nil
        UI.Tips:createTips(
            LanguageManager:getInstance():getLocalString(1110249), 
            UI.TipsType.CONFIRM, 
            UI.TipsUiType.NORMAL)
    elseif (loginStatusNum == PublicDefine.LoginStatus.RoleAccountDeleting) then
        -- 角色删除中
        toastLanguageID = nil
        -- UI.ScrollBar:createByText(UI.TEXT_222307)
        -- SdkBox:getInstance():logout()

        if data then
            local deleteAccountRoleLayer = UI.DeleteAccountRoleLayer:create(2 ,nil, data.now,data.minDeleteTime,data.maxDeleteTime,data.avalonLoginToken)
            deleteAccountRoleLayer:center(0, -10)
            self:addChild(deleteAccountRoleLayer,UI_ZORDER.NOTICE)
        end

    end

    if (toastLanguageID ~= nil) then
        -- 有滚动提示字符串就弹出
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(toastLanguageID))
    end
    return false
end

-- 预加载一些动画资源
function MainLayer:loadLoadingSpine()
    -- if(gameLoginManager:getInstance():getIsLoadLoadingSpine() == false) then
    --     local function callback(texture)
    --         if not tolua.isnull(texture) then
    --             texture:retain()
    --         end
    --     end
    --     display.loadImage("effect_ui_loading_scene.pvr.ccz",callback)
    --     for i=1,3 do
    --         display.loadImage(string.format("effect_ui_loading_role0%d.pvr.ccz", i),callback)
    --     end
    -- end
end

-- 从web服务器获取登录公告
function MainLayer:getLoginNotice()
    self:setLoginButtonEnabled(false)
    local params = {}
    params.channel = SdkBox:getInstance():getVersionChannel()
    params.zone = checkint(ServerConfigUtil:getZoneId())
    params.languageType = LanguageManager:getInstance():getLanguage()
    params.clientVersion = AvalonUtil.getPackageVersion()

    Net.Helper:sendHttpMessage(Net.HttpSubDirection.LoginNotice,params,function(response)
        self:setLoginButtonEnabled(true)
        if (tolua.isnull(self)) then return end

        if tolua.isnull(self) then
            return
        end
        local data = json.decode(response)
        if data and data.isShow then
            if (self.mNoticeBtn) then self.mNoticeBtn:show() end
            self.contentText = data.content
            self.bottomText = data.bottom
            local curTime = os.time()
            if data.isOnce then --每日 弹出一次
                local lastShowTime = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LoginNoticeLastShowTime, 0)
                if math.ceil(lastShowTime / SECONDS_ONE_DAY) < math.ceil(curTime / SECONDS_ONE_DAY) then
                    self:showLoginNotice(data.content, data.bottom)
                end
            else --每日弹出多次
                self:showLoginNotice(data.content, data.bottom)
            end
        else
            self.mNoticeBtn:hide()
        end
    end, function(readyState, status)
        self:setLoginButtonEnabled(true)
        print("-------------MainLayer:getLoginNotice !!!! fail")
    end)
end

function MainLayer:showLoginNotice(content, bottom, closeCallback)
    -- print("---------MainLayer:LoginNotice ")
    local loginNotice = self:getChildByName("LoginNotice")
    if loginNotice == nil then
        require("app.ui.notice.LoginNotice")
        local tempContent = {}
        for k, v in ipairs(content) do
            if string.len(v.text) > strMaxLen then
                local list = AvalonUtil:splitByLength(v.text, strMaxLen)
                for k2, v2 in ipairs(list) do
                    local data = {}
                    data.text = v2
                    data.fontSize = v.fontSize
                    data.color = v.color
                    table.insert(tempContent, data)
                end
            else
                table.insert(tempContent, v)
            end
        end

        local tempBottom = {}
        for k, v in ipairs(bottom) do
            if string.len(v.text) > strMaxLen then
                local list = AvalonUtil:splitByLength(v.text, strMaxLen)
                for k2, v2 in ipairs(list) do
                    local data = {}
                    data.text = v2
                    data.fontSize = v.fontSize
                    data.color = v.color
                    table.insert(tempBottom, data)
                end
            else
                table.insert(tempBottom, v)
            end
        end

        local loginNotice = UI.LoginNotice:create(tempContent, tempBottom, closeCallback)
        loginNotice:center(0, -10)
        loginNotice:setName("LoginNotice")
        self:addChild(loginNotice,UI_ZORDER.NOTICE)
        loginNotice:showNotice();
    end
end

function MainLayer:onOpenNotice()
    if (not self.contentText or not self.bottomText) then return end
    self:showLoginNotice(self.contentText, self.bottomText)
end

function MainLayer:onOpenTransfer()

    local LoginTransfer = self:getChildByName("LoginTransfer")
    if LoginTransfer == nil then
        require("app.ui.notice.LoginTransfer")
        local loginTransfer = UI.LoginTransfer:create(tempContent, tempBottom, closeCallback)
        loginTransfer:center(0, -10)
        loginTransfer:setName("LoginTransfer")
        self:addChild(loginTransfer,UI_ZORDER.NOTICE)
        loginTransfer:showTransfer();
    end

end

function MainLayer:tryConnectToGameServer()
    -- 走httpdns的流程
    self:showLoading()
    self:httpdnsGetIPAsync(
        ServerConfigUtil:getGateHost(),
        function(ip)
            printInfo("MainLayer:tryConnectToGameServer httpdns", ServerConfigUtil:getGateHost(), ServerConfigUtil:getGatePort(), ip)
            if (ip) and not tolua.isnull(self) then
                self.ip = ip
                gameLoginManager:getInstance():setServerUrl(ip)
                self:hideLoading()
                self:setLoginButtonEnabled(false)
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    self:setLoginButtonEnabled(true)
                end, 2)
                self:animateOut( function()
                    Net.NetInnerSystem:connect(Net.MAIN_SERVER, self.ip, ServerConfigUtil:getGatePort())
                end)
            end
        end
    )
end


------------------------------ eo 登录 --------------------------------
























------------------------------ 事件 --------------------------------
--[[
    SDK登录验证成功
    {
    accountId:”xxx”,    //平台_版本_渠道_账号id
    channel:"",         //登录的渠道sdk 定义在PublicDefine.VERSION_CHANNEL
    loginStatus:"1"     //登录状态码 定义在PublicDefine.LoginStatus
    }
]]
function MainLayer:onSdkLoginSuccess(params)
    printInfo("MainLayer:onSdkLoginSuccess SDK请求成功返回: ", params)
    -- 激活,从打开页面调整到SDK登陆成功。用来过滤android未授权的玩家。
    gameLoginManager:getInstance():activity()
    self:hideLoading()

    -- 加载服务器列表之前屏蔽账号按钮(因为雷霆没有取消登录回调, 避免一些网络延迟高的时候会发生的误操作)
    self._isAcButtonDisabled = true

    -- 上报第三方登录成功
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Third_Login_Result, 0, nil, 1)
    
    -- 检查登录状态码
    if (not self:checkSdkLoginStatusCode(params and params.loginStatus or 0, params)) then 
        return 
    end

    -- 设置登录Token
    ServerConfigUtil:setAvalonLoginToken(params.avalonLoginToken)
    ServerConfigUtil:setNickName(params.nickName or params.nickname)
    ServerConfigUtil:setPlayerID(params.playerID)
    ServerConfigUtil:setSDKToken(params.sdkToken)

    -- 通知消息
    self:dispatchEvent(UI.Event.EVENT_THIRD_VERYFY_SUCCESS, params)

    -- 向WEB请求服务器列表
    self:queryServerListConfig()
end

-- SDK登录验证失败
function MainLayer:onSdkLoginFail(code,params)
    self:hideLoading()

    printInfo("MainLayer:onSdkLoginSuccess SDK请求失败返回: ", code, params)

    -- 上报第三方登录失败
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Third_Login_Result,0,nil,0)

    -- 如果是gamecenter 由于只能弹出一次登录界面 所以提示用户去外部登录
    if  code == Avalon.UserActionResultCode.kInitFail and
        self._clickLoginType == VERSION_ACCOUNT.VERSION_ACCOUNT_GAMECENTER
    then
        local tips = UI.Tips:createTips(UI.TEXT_111152,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
    end

    --通知消息
    self:dispatchEvent(UI.Event.EVENT_THIRD_VERYFY_FAILED,code,params)

    -- 更新屏幕按钮
    self:updateComponentsVisibility()
end

-- 连接完成开始验证
function MainLayer:_listenerConnectComplete()
    print("MainLayer:_listenerConnectComplete  ")
    -- -- 上报请求登录游戏服
    -- gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Req_LoginToGameServer)
    -- gameLoginManager:onVerify()
end

-- 验证完成
function MainLayer:_listenerLoginVerifyResult()
    self:hideLoading()
end

-- 账号无英雄, 新建英雄
function MainLayer:_listenerLoginNoHero(data)
    print("_listenerLoginNoHero")
    self:hideLoading()

    -- 更新界面组件状态, 传true表示在角色创建界面
    self:updateComponentsVisibility(true)

    -- 上报拉起创建角色界面
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Open_RoleCreateLayer)

    -- 接收到网络消息后提前创建角色选择页面并隐藏
    -- TODO: 给CreateRoleLayer添加一个提前加载资源方法, 提高速度
    require("app.ui.createRoleLayer.CreateRoleLayer")
    local pCreateRoleLayer = UI.CreateRoleLayer:create(teamType, data)
    pCreateRoleLayer:setName("CreateRoleLayer")
    self:addChild(pCreateRoleLayer,UI_ZORDER.ACTIVITY)
    pCreateRoleLayer:hide()

    -- 过场完成过后把已经加载好的角色创建页面显示出来
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_LOGIN_FINISH, self, function()
        -- 出场动画完成后渐入显示角色选择页面
        pCreateRoleLayer:show()
    end)
end
function MainLayer:resetLoginButton()
    self:updateComponentsVisibility()
    local createRoleLayer = self:getChildByName("CreateRoleLayer")
    if not tolua.isnull(createRoleLayer) then
        createRoleLayer:removeFromParent(true)
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
end
-- 进入游戏
function MainLayer:_listenerEnterGame()
    -- 上报进入loading界面
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Start)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR)
    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:getInstance():onSelectRole()
end

function MainLayer:CSBtnClick()
    -- body
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
        SdkBox:getInstance():helper({roleId="", roleName="", roleLevel="", zoneId="", zoneName=""})
    elseif(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL ) then
        SdkBox:getInstance():helper({roleId="nm_"..AvalonUtil.getOpenUUID(), roleName="匿名", roleLevel="", zoneId="", zoneName=""})
    else --走 浏览器 
        local SdkManager = require"app.game.SdkManager"
        SdkManager:getInstance():openCSWeb()
    end
end

function MainLayer:DiscBtnClick()
    if SdkBox:getInstance():isSupportPrivacy() then
        SdkBox:getInstance():showSdkPrivacy()
    else
        local userProDialog = UI.UserProtocolDialog:create();   
        UI.UIManager:getRootNode():addChild(userProDialog, 100000)
        userProDialog:showUserProtocolDialog();
        userProDialog:changedActivePanel(2)
    end
end

function MainLayer:areaInfoReresh()
    print("MainLayer:areaInfoReresh")
    if(not GameManager:getIsOpenArea()) then return end
    if(self.areaNameBg) then 
        print("MainLayer:areaInfoReresh 1")
        local areaName = ServerConfigUtil:getNowChoiceAreaName()
        if(areaName) then
            print("MainLayer:areaInfoReresh 2")
            self.areaNameText:setText(LanguageManager:getInstance():getLocalString(1113853)..":"..areaName)
            self.areaNameBg:setSize(self.areaNameText:getContentSize().width+ 25, 32)
            self.areaNameBg:setVisible(true)
        else
            self.areaNameBg:setVisible(false) 
        end
    end
end

function MainLayer:hideAreaInfo()
    print("MainLayer:hideAreaInfo")
    if(not GameManager:getIsOpenArea()) then return end
    if(self.areaNameBg) then 
        self.areaNameBg:setVisible(false) 
    end
end

function MainLayer:areaChangeClick()
    if(not GameManager:getIsOpenArea()) then return end
    local showView = function()
        reload_script_file("app.modules.setting.SettingAreaServerSelectView")
        local areaServerSelectView = require("app.modules.setting.SettingAreaServerSelectView")
        local view = areaServerSelectView:create(Game.AREA_TYPE.AREA_TYPE_MAINLAYER)
        view:init()
        view:center()

        view:setTouchEnable(true)
        view:setInterceptTouches(true)
        view:setSwallowTouches(true)
        view:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
            view:close()
        end)

        self:addChild(view, 1000000)     
    end

    if(ServerConfigUtil:getNowAreaServerData()) then 
        showView()
    else
        ServerConfigUtil:queryAreaListConfig(
            function()          -- 强更
                print("MainLayer:areaChangeClick force")
            end, function()     -- 热更
                print("MainLayer:areaChangeClick hot")
            end, function(data) -- 成功
                print("MainLayer:areaChangeClick success")
                showView()
            end, function()     -- 超时
                print("MainLayer:areaChangeClick timeout")
                self:areaInfoReresh()
                UI.ScrollBar:createByTextID(1113854)
            end, function(data) -- 未知状态
                print("MainLayer:areaChangeClick err")
                self:areaInfoReresh()
                UI.ScrollBar:createByTextID(1113854)
            end)
    end
    
end
------------------------------ eo 事件 --------------------------------