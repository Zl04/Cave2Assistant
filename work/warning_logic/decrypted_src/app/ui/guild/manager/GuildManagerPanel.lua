-- GuildManagerPanel.lua
-- Author:zp
-- 2017年9月14日
-- Using:创建或加入公会

require "app.datas.GuildBoxDataManager"
require "app.ui.guild.manager.GuildMemberCell"
require "app.ui.guild.manager.JoinApplyManagerPanel"
require "app.ui.guild.createOrJoin.LoadingPanel"
require "app.ui.guild.manager.GuildNoticeCell"
require "app.ui.CommonBgLayer"
require "app.ui.common.EditBox"
require "app.ui.guild.manager.GuildRenameLayer"

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require "app.game.GameDataManager"
local SdkManager = require"app.game.SdkManager"
local SdkBox = require "utils.sdkbox.SdkBox"

local GuildTitle = PublicDefine.GuildTitle
local HERO_LOGIN_STATUS = PublicDefine.HERO_LOGIN_STATUS
local BOX_NUM_FULL_FONT_COLOR = {r = 80, g = 5, b = 5}
local BOX_NUM_NORMAL_FONT_COLOR = UI.FONT_COLOR_41_41_45

UI = UI or {}

local GuildManagerPanel = class("GuildManagerPanel", UI.DownShowWin)
UI.GuildManagerPanel = GuildManagerPanel

local winSize = cc.Director:getInstance():getWinSize()

local LAYOUT_DESIGN_WIDTH = 974
local LAYOUT_DESIGN_HEIGHT = 640
local FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM = 20
local FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_ACTV = 10
local FUNCTION_TAG_NEW_APPLY_REDPOINT_UP = 10
local TAB_ACTIVE_FONT_COLOR = {r = 220, g= 211, b = 147}

-- 公告最多的字数
local NOTICE_MAX_NUM = 500

UI.GUILD_MANGER_TYPE = {
    MAIN_INFO = 1,
    MANAGER = 2,
    GUILD_BOX= 3,
}

local SORT_TYPE = {
    LOGIN = 1,
    TITLE = 2,
    CONTRI = 3,
}

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_icon.plist",
    "ui_town_guild_general.plist",
    "ui_town_guild_management.plist",
    "ui_town_guild_giftbox.plist",
    "ui_general_share.plist",
    "ui_general_shopping.plist",
    "ui_town_guild_writ.plist",
}

local AUDIO_WAITING_TIME = 0.2
local SCORE_WAITING_LMT_TIME = 0.2
local CHANGE_NOTICE_TIME = 3
local CHANGE_ICON_TIME = 3

local SHARE_MODULE = PublicDefine.SHARE_MODULE

local winSize = cc.Director:getInstance():getWinSize()

--构造函数(必备)
function GuildManagerPanel:ctor(defaultTabIdx)
	--窗口大小
    GuildManagerPanel.super.ctor(
        self,UIType.GUILD_MANAGER_PANEL,
        COM_RES_LIST,
        winSize.width,	
        winSize.height
    )

    -- 排序的处理
    self.sortType = {1, 1, 1}
    self.originalSortType = {1, 1, 1}
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if globalUserData then
        self.sortType = globalUserData:getGuildSortType()
        self.originalSortType = globalUserData:getGuildSortType()
    end

    self.inDefaultTabIdx = defaultTabIdx
    self._choiceTabIndex = 0
    self.guildData = MasterDataManager:getGuildData()
    self:sortMemberData()
    if(self.guildData == nil) then
        self:close()
    end

    self.equipScore =  string.split(ConfigManager:getGuildEquipScore(), ";")
    for k,v in pairs(self.equipScore) do 
        self.equipScore[k] = tonumber(v)
    end

    self.guildListTableView = nil

    self.searchGuildList = nil
    self.lastMaxGuildID =0
    self.bucketIdx = nil
    self.bucketDis = nil
    self.audioTime = -1
    self.scoreLmt = -1
    self.changeNoticeTime = -1
    self.changeWaitingTime = -1

    self._preSendAudio = self.guildData.isOpenJoinAudit
    self._preJoinEquipScoreLmt = self.guildData.joinEquipScoreLmt

    self._requestJoinReqList = false

    self._searchEdit = nil

    self._waitingInput = false
    self._playTableCellAct = {}
    self._writInfoNodeArr = {}
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init()
end

function GuildManagerPanel:updateOncePerSecond()
    self:refreshGiantBoxCountDown()
end

function GuildManagerPanel:onEnter()
    GuildManagerPanel.super.onEnter(self)
    -- print("GuildManagerPanel:onEnter")
    self:registerListener()
    Avalon.Scheduler:scheduleUpdate(self, self.refreshTime)
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

function GuildManagerPanel:onExit()
    -- print("GuildManagerPanel:onExit")
    GuildManagerPanel.super.onExit(self)
    self:unRegisterListener()
    Avalon.Scheduler:unscheduleUpdate(self, self.refreshTime)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

--虚构函数,destroy时调用(必备)
function GuildManagerPanel:dtor()
    -- print("GuildManagerPanel:dtor")
    reload_script_file("app.ui.guild.manager.GuildManagerPanel")
    GuildManagerPanel.super.dtor(self)
    self._waitingInput = false

    if(self._noticeCell) then 
        self._noticeCell:release()
        self._noticeCell = nil 
    end
    self._playTableCellAct = {}
    -- 发送请求
    self:sendAudio()
    self:sendScoreLmt()

    local sortTypeChanged = false
    for k, v in ipairs(self.originalSortType) do
        if v ~= self.sortType[k] then
            sortTypeChanged = true
            break
        end
    end

    if not sortTypeChanged then
        return
    end

    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end
    globalUserData:setGuildSortType(self.sortType)

    Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
    self._writInfoNodeArr = {}
    
    -- reload_script_file("app.ui.guild.manager.GuildBoxCell")
    -- reload_script_file("app.datas.GuildBoxDataManager")
    -- reload_script_file("app.ui.guild.manager.GuildGiantBoxContentCell")
end

-- 刷新时间
function GuildManagerPanel:refreshTime(dt)
    -- if not tolua.isnull(self) then
        local oldAudioTime = self.audioTime
        local oldScoreLmt = self.scoreLmt
        self.audioTime = self.audioTime - dt
        self.scoreLmt =  self.scoreLmt - dt
        self.changeNoticeTime = self.changeNoticeTime - dt
        self.changeWaitingTime = self.changeWaitingTime - dt

        if(oldAudioTime > 0 and self.audioTime <=0) then
            self:sendAudio()
        end

        if(oldScoreLmt >0 and self.scoreLmt <= 0) then
            self:sendScoreLmt()
        end
        if(self.writWaitingTime == nil) then 
            self.writWaitingTime = 0
        end
        self.writWaitingTime = self.writWaitingTime + dt
        if(self.writWaitingTime > 1) then
            self.writWaitingTime = self.writWaitingTime - 1
            self:refreshWritInfo()
        end
    -- end
end

-- 初始化(必备)
function GuildManagerPanel:init()
    GuildManagerPanel.super.init(self)

    -- 排序规则   是否在线（在线排上面）→职位从高到底→本周贡献度从高到低→离线时长从近到远
    if(self.guildData) then
        -- self._playTableCellAct = {}
        Net.NetGuildSystem:reqGuild(self.guildData.version)
        Net.NetRankSystem:requestSpecifyRank(self.guildData.ID, PublicDefine.RankType.RankType_Guild)
    else
        assert(false,"GuildManagerPanel:init  not found guildData")
    end
end


-- 模版函数：初始化组建的视图(必备)
function GuildManagerPanel:onInitView()
    -- 页面总背景
    local bg = UI.CommonBgLayer:create(false, false)
    bg:center()
    self:addChild(bg)
    self.bg = bg

    -- 内容宿主
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    bg:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 皇冠头
    local bgTitle = UI.Image:create()
    bgTitle:init("ui_bg_banner_box_up.png")
    bgTitle:leftUp(974/2 - bgTitle:getContentSize().width/2, 3)
    self._contentLayout:addChild(bgTitle,200)
    
    -- 左边装饰物
    local decoLeft = UI.Image:create()
    decoLeft:init("ui_bg_flag_left.png")
    decoLeft:leftUp(221, 3)
    self._contentLayout:addChild(decoLeft)

    -- 右边装饰物
    local decoRight = UI.Image:create()
    decoRight:init("ui_bg_flag_right.png")
    decoRight:rightUp(221, 3)
    self._contentLayout:addChild(decoRight)

    -- 初始化普通成员界面和管理界面
    self:initMainLayout()
    self:initManagerLayout()
    self:initGuildBoxLayout()

    -- 分享区域宿主
    self.shareLayer = cc.Layer:create();
    self.shareLayer:setPosition((LAYOUT_DESIGN_WIDTH - winSize.width) / 2,(LAYOUT_DESIGN_HEIGHT - winSize.height) / 2)
    self.shareLayer:setContentSize(winSize)
    self:addChild(self.shareLayer,11)

    -- 标签点击遮挡
    local clickBlocker = UI.Layout:create()
    clickBlocker:init()
    clickBlocker:setSize(100, 270)
    clickBlocker:leftUp(912, 75)
    clickBlocker:setTouchEnable(true)
    clickBlocker:setSwallowTouches(true)
    self._contentLayout:addChild(clickBlocker, 10)

    -- 标签宿主
    local functionTabList = UI.TabList:create()
    functionTabList:init(2, nil, nil, true)
    functionTabList:leftUp(0, 30)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex, lastIndex)
        -- print(string.format("BagPanel onInitView: select function tab %d.", tabIndex))
        if (not self:choiceTabIndex(tabIndex)) then
            functionTabList:activeTab(lastIndex)
            local timestampToSeeable = GameManager:getNormalServerTime() + GuildBoxDataManager:getTimeDurationToSeeable()
            UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1112229)--[["%s后才能打开公会宝箱"]], AvalonUtil:getFullFormatTime(timestampToSeeable)))
        end
    end)
    functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    functionTabList:setReverseOrder(true)
    self._functionTabList = functionTabList
    clickBlocker:addChild(functionTabList, 10)

    -- 主页按钮
    local functionTab = UI.TabItem:create()
    functionTab:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    functionTab:setSize(109, 68)
    functionTab:alignLeft(true)
    functionTab:setSwallowTouches(true)
    functionTab:setChangeScale(false)
    functionTabList:addToTab(functionTab, UI.GUILD_MANGER_TYPE.MAIN_INFO)

    -- 主页文字
    self._mainTabText = UI.Text:create()
    self._mainTabText = UI.Text:create()
    self._mainTabText:init(LanguageManager:getInstance():getLocalString(1110553), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    self._mainTabText:center(-4, 0)
    functionTab:addChild(self._mainTabText)

    -- 管理按钮
    self._managerFunctionTab = UI.TabItem:create()
    self._managerFunctionTab:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    self._managerFunctionTab:setSize(109, 68)
    self._managerFunctionTab:alignLeft(true)
    self._managerFunctionTab:setSwallowTouches(true)
    self._managerFunctionTab:setChangeScale(false)
    self._newApplyStatus = AvalonUtil.createRedPoint(self._managerFunctionTab, FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
    self._newApplyStatus:setVisible(false)
    functionTabList:addToTab(self._managerFunctionTab, UI.GUILD_MANGER_TYPE.MANAGER)

    -- 管理文字
    self._managerTabText = UI.Text:create()
    self._managerTabText:init(LanguageManager:getInstance():getLocalString(1110554), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    self._managerTabText:center(-4, 0)
    self._managerFunctionTab:addChild(self._managerTabText)

    -- 宝箱按钮
    local functionTab = UI.TabItem:create()
    functionTab:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    functionTab:setSize(109, 68)
    functionTab:alignLeft(true)
    functionTab:setSwallowTouches(true)
    functionTab:setChangeScale(false)
    self._boxStatus = AvalonUtil.createRedPoint(functionTab, FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
    self._boxStatus:setVisible(GuildBoxDataManager:getNewBoxFlag())
    functionTabList:addToTab(functionTab, UI.GUILD_MANGER_TYPE.GUILD_BOX)
    
    -- 宝箱文字
    self._boxTabText = UI.Text:create()
    self._boxTabText = UI.Text:create()
    self._boxTabText:init(LanguageManager:getInstance():getLocalString(1110876)--[["宝箱"]], UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    self._boxTabText:center(-4, 0)
    functionTab:addChild(self._boxTabText)

    -- 刷新状态
    self:refreshHaveJoin()
    self:refreshTabItem()

    -- 加载动画效果
    self._loading = UI.WaitingLayer:createWaitingWithSize(winSize, self._contentLayout)
    self._loading:center()
    self._loading:setVisible(false)
    self:setCloseStartCallBack(function( )
        return self._waitingInput == false
    end)

    if self.inDefaultTabIdx then
        self:choiceTabIndex(self.inDefaultTabIdx)
    end
    self:onInitWritInfo()
end

function GuildManagerPanel:onInitWritInfo()
    -- body
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(120, 536)
    layout:leftBottom(-59, 30)
    self._contentLayout:addChild(layout, 100)

    local bg = UI.Image:create()
    bg:init("ui_guild_writ_banner_bg.png")
    bg:centerUp(16)
    layout:addChild(bg)

    local nowServerTime = GameManager:getNormalServerTime()
    local list = MasterDataManager:getGuildData():getWritList()
    for i = 1, #list do
        local data = list[i]
        local iconBg = UI.Image:create()
        iconBg:init("ui_guild_writ_banner_1.png")
        iconBg:rightUp(-14, (i - 1) * 90 + 9)
        layout:addChild(iconBg) 
        iconBg:setTouchEnable(true)
        iconBg:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
            self:showBufInfo(iconBg, data)
        end)
        iconBg:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
            if (not tolua.isnull(self.bufPanel)) then
                self.bufPanel:removeFromParent(true)
                self.bufPanel = nil
            end
        end)
        local icon = UI.Image:create()
        icon:init(data.iconPath)
        icon:center(-16)
        iconBg:addChild(icon)
        icon:setScale(0.5)

        local node = {}
        local isActive = data.actTime + data.duration > nowServerTime
        -- data.duration = nowServerTime - data.actTime +10
        if not isActive then
            iconBg:setSpriteName("ui_guild_writ_banner_0.png")
            iconBg:rightUp(-4, (i - 1) * 90 + 9)
            icon:center(-12)
            icon:setSpriteName(string.format("ui_guild_writ_metal_%d_0.png", data.ID))
        else
            icon:setSpriteName(string.format("ui_guild_writ_metal_%d_1.png", data.ID))

            local timeBg = UI.Image:create()
            timeBg:init("ui_guild_timebg.png")
            timeBg:centerBottom(0)
            timeBg:setScale(1/icon:getScale())
            icon:addChild(timeBg)

            local timeText = UI.Text:create()
            timeText:init(ToolsUtil:getTime(data.actTime + data.duration - nowServerTime), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
            timeBg:addChild(timeText)
            timeText:center(0,-1)
            -- timeText:setScale(1/icon:getScale())
            node.timeText = timeText
            node.timeBg = timeBg
        end

        
        node.iconBg = iconBg
        node.icon = icon
        node.data = data
        node.isActive = isActive
        table.insert(self._writInfoNodeArr, node)
    end
end

function GuildManagerPanel:refreshWritInfo()
    if(self._writInfoNodeArr) then 
        local nowServerTime = GameManager:getNormalServerTime()
        for k, node in ipairs(self._writInfoNodeArr) do 
            if(node.isActive) then 
                local lossTime = node.data.actTime + node.data.duration - nowServerTime
                if(lossTime <= 0) then
                    node.iconBg:setSpriteName("ui_guild_writ_banner_0.png")
                    node.iconBg:rightUp(-4, (k - 1) * 90 + 9)
                    node.icon:center(-12)
                    node.icon:setSpriteName(string.format("ui_guild_writ_metal_%d_0.png", node.data.ID))
                    node.isActive = false
                    if(node.timeBg and not tolua.isnull(node.timeBg)) then 
                        node.timeBg:setVisible(false)
                    end
                    if(node.timeText and not tolua.isnull(node.timeText)) then 
                        node.timeText:setText("")
                    end
                else
                    if(node.timeBg and not tolua.isnull(node.timeBg)) then 
                        node.timeBg:setVisible(true)
                    end
                    if(node.timeText and not tolua.isnull(node.timeText)) then 
                        local str = ToolsUtil:getTime(lossTime)
                        node.timeText:setText(str)
                    end
                end
            end
        end
    end
end

function GuildManagerPanel:showBufInfo(sender, data)
    local function showOutSizeTouchHandler(self, obj, touchPosition)
        if (not tolua.isnull(self.bufPanel)) then
            self.bufPanel:removeFromParent(true)
            self.bufPanel = nil
        end
    end

  -- 消息列表
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(275, 80)
    layout:leftUp(75, sender:getUp() + 97)
    self._contentLayout:addChild(layout, 200)
    layout:setTouchEnable(true)
    layout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, showOutSizeTouchHandler)
    self.bufPanel = layout

    local isActive = data.actTime + data.duration > GameManager:getNormalServerTime()
    local des = UI.Text:create()
    if isActive then
        des:init(string.format("%s:%s", data.name, data.description), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 193, g = 193, b = 193})
    else
        des:init(string.format("%s:%s(%s)", data.name, data.description, UI.TEXT_1212604), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 193, g = 193, b = 193})
    end
    des:centerUp(10)
    des:setWidth(240)
    des:autoAdapt()

    local bg =  UI.Image9:create()
    bg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(265, des:getContentSize().height + 20))
    bg:leftUp(10, 1)
    layout:addChild(bg)
    bg:addChild(des)

    local arrow =  UI.Image:create()
    arrow:init("ui_information_banner_background2.png")
    arrow:leftUp(1, 10)
    layout:addChild(arrow)
    arrow:setScaleX(-1)

end
-- 模版函数：更新组建的视图(必备)
function GuildManagerPanel:onUpdateView()
    if (not self._afterFirstTime) then
        self._afterFirstTime = true
    else
        self._playTableCellAct = {}
    end
    self:refreshInviteButton()
end

-- 公会宝箱宿主层
function GuildManagerPanel:initGuildBoxLayout()
    self._guildBoxLayout = UI.Layout:create()
    self._guildBoxLayout:init()
    self._guildBoxLayout:setSize(852, 534)
    self._guildBoxLayout:leftBottom(63, 21)
    self._contentLayout:addChild(self._guildBoxLayout,21)

    -- 添加背景
    local bgPaper = UI.Image9:create()
    bgPaper:init("ui_bg_paper2.png", CCRectMake(302,140,2,2), cc.size(852, 534))
    bgPaper:centerBottom(0)
    self._guildBoxLayout:addChild(bgPaper)

    -- 公会宝箱内容初始化
    self:initGuildBoxContent()

    -- 初次更新
    self:refreshGuildBoxView()
end

-- 公会宝箱内容初始化
function GuildManagerPanel:initGuildBoxContent()
    -- 公会宝箱列表初始化
    self:initGuildBoxTable()

    -- 次数限制标签 rightUp 78, 7
    self._dropNumLabel = UI.Text:create()
    self._dropNumLabel:init(LanguageManager:getInstance():getLocalString(1112112)--[["今日已领取:"]], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._dropNumLabel:rightUp(78, 7)
    self._guildBoxLayout:addChild(self._dropNumLabel)

    -- 次数限制数量 leftUp 774, 7
    self._dropNumText = UI.Text:create()
    self._dropNumText:init("14/60", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.BOX_NUM_NORMAL_FONT_COLOR)
    self._dropNumText:leftUp(774, 7)
    self._guildBoxLayout:addChild(self._dropNumText)

    -- 次数限制上横线 leftUp 350, 37
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(480, 2))
    splitLine:leftUp(350, 37)
    self._guildBoxLayout:addChild(splitLine)

    -- 清空按钮 leftBottom 350, 23
    self._clearBtn = UI.Button:create()
    self._clearBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    self._clearBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._clearBtn:setText(LanguageManager:getInstance():getLocalString(1112113)--[["清空已领"]])
    self._clearBtn:leftBottom(369, 23)
    self._clearBtn:setInterval(1)
    self._guildBoxLayout:addChild(self._clearBtn)
    self._clearBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self, obj)
        if (GuildBoxDataManager:getDroppedSmallBoxNum() <= 0) then return end
        GuildBoxDataManager:requestToClearAllDroppedBox()
        self._guildBoxTableView:scrollToTop()
    end)

    -- 清空按钮标识
    local clearIcon = UI.Image:create()
    clearIcon:init("ui_btn_reduction_1.png")
    clearIcon:centerLeft(-19)
    clearIcon:setName("icon")
    self._clearBtn:addChild(clearIcon, 20)

    -- 领取按钮 leftBottom 569, 23
    self._getAllBtn = UI.Button:create()
    self._getAllBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    self._getAllBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._getAllBtn:setText(LanguageManager:getInstance():getLocalString(1112114)--[["全部领取"]])
    self._getAllBtn:leftBottom(619, 23)
    self._getAllBtn:setInterval(2)
    self._guildBoxLayout:addChild(self._getAllBtn)
    self._getAllBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self, obj)
        if (not GuildBoxDataManager:checkNotifyIsAbleToOpenBox()) then return end

        self._skipGiantBoxAnimationOnce = true
        self:playOpenSmallBoxGiantBoxAnimation()
        performWithDelay(self, function()
            GuildBoxDataManager:requestOpenBox()
        end, 1)
    end)

    -- 领取按钮标识
    local getAllIcon = UI.Image:create()
    getAllIcon:init("ui_main_button_shopping_1.png")
    getAllIcon:centerLeft(-19)
    getAllIcon:setName("icon")
    self._getAllBtn:addChild(getAllIcon, 20)

    -- 大宝箱背景
    local giantBoxBg = UI.Image:create()
    giantBoxBg:init("ui_guild_giftbag_paper_bg.png")
    giantBoxBg:leftBottom(6, 48)
    self._guildBoxLayout:addChild(giantBoxBg)

    -- 空白提示
    self._emptyText = UI.Text:create()
    self._emptyText:init(LanguageManager:getInstance():getLocalString(1112116)--[["无宝箱"]], UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    self._emptyText:center()
    giantBoxBg:addChild(self._emptyText)

    -- 大宝箱名字
    self._giantBoxName = UI.Text:create()
    self._giantBoxName:init(LanguageManager:getInstance():getLocalString(1110560), UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    self._giantBoxName:centerUp(40)
    giantBoxBg:addChild(self._giantBoxName)

    -- 宝箱外观排版
    self._giantBoxOutsideLookLayout = UI.Layout:create()
    self._giantBoxOutsideLookLayout:init()
    self._giantBoxOutsideLookLayout:setSize(giantBoxBg:getSize())
    giantBoxBg:addChild(self._giantBoxOutsideLookLayout)
    
    -- 大宝箱符文背景
    local giantBoxRunicBg = UI.Image:create()
    giantBoxRunicBg:init("ui_guild_giftbag_bg.png")
    giantBoxRunicBg:center(0, 34)
    self._giantBoxOutsideLookLayout:addChild(giantBoxRunicBg)

    -- 大宝箱圈圈 center 10, -18
    self._giantBoxProgressBar = UI.ProgressTimer:create()
    self._giantBoxProgressBar:init("ui_guild_giftbag_groove.png", nil, "ui_guild_giftbag_progressbar.png", UI.ProgressTimerType.RADIAL)
    self._giantBoxProgressBar:center(0, 39)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxProgressBar)
    
    -- 大圈圈效果动画
    self._giantBoxProgressEffect = UI.Animation:create()
    self._giantBoxProgressEffect:init("effect_ui_town_guild_guildgift_quan.json", "effect_ui_town_guild_guildgift_quan.atlas", 1)
    self._giantBoxProgressEffect:center(0, 38)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxProgressEffect)

    -- 大宝箱动画 center 10, -18
    self._giantBoxIcon = UI.Animation:create()
    self._giantBoxIcon:init("effect_ui_town_guild_guildgift_xiaochou_box.json", "effect_ui_town_guild_guildgift_xiaochou_box.atlas", 1)
    self._giantBoxIcon:center(-2, 34)
    self._giantBoxIcon:setSize(200, 200)
    self._giantBoxIcon:setAnimation("idle1", true)
    self._giantBoxIcon:setTouchEnable(true)
    self._giantBoxIcon:setSwallowTouches(true)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxIcon)
    self._giantBoxIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:showGiantBoxContent(true)
    end)

    -- 蓝宝石
    self._sapphire = UI.Animation:create()
    self._sapphire:init("effect_ui_town_guild_guildgift_stone.json", "effect_ui_town_guild_guildgift_stone.atlas", 1)
    self._sapphire:center(-2, -93)
    self._sapphire:setAnimation("idle", true)
    self._giantBoxOutsideLookLayout:addChild(self._sapphire)

    -- 大宝箱时间图标
    self._giantBoxTimeIcon = AvalonUtil.createClockAnimation()
    self._giantBoxTimeIcon:leftBottom(117, 25)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxTimeIcon)

    -- 大宝箱时间文字
    self._giantBoxTimeText = UI.Text:create()
    self._giantBoxTimeText:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._giantBoxTimeText:autoAdapt()
    self._giantBoxTimeText:leftBottom(144, 30)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxTimeText)

    -- 大宝箱进度区域 centerBottom -25
    self._giantBoxCountDownProgress = UI.ProgressTimer:create()
    self._giantBoxCountDownProgress:init("ui_information_banner_countdown_box.png", nil, "ui_information_banner_countdown.png")
    self._giantBoxCountDownProgress:centerBottom(20)
    self._giantBoxCountDownProgress:setPercent(0)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxCountDownProgress)

    -- 大宝箱进度文字
    self._giantBoxProgressText = UI.Text:create()
    self._giantBoxProgressText:init(string.format(LanguageManager:getInstance():getLocalString(1112234)--[["开箱进度:%s"]], "0/0"), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._giantBoxProgressText:centerBottom(-30)
    self._giantBoxOutsideLookLayout:addChild(self._giantBoxProgressText)

    -- 大宝箱内容排版
    self._giantBoxContentLayout = UI.Layout:create()
    self._giantBoxContentLayout:init()
    self._giantBoxContentLayout:setSize(giantBoxBg:getSize())
    self._giantBoxContentLayout:hide()
    self._giantBoxContentLayout:setTouchEnable(true)
    self._giantBoxContentLayout:setSwallowTouches(true)
    self._giantBoxContentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:showGiantBoxContent(false)
    end)
    self._giantBoxContentLayout:setForceListenBackKey(false)
    giantBoxBg:addChild(self._giantBoxContentLayout)

    -- 提示文字
    local dropNote = UI.Text:create()
    dropNote:init(LanguageManager:getInstance():getLocalString(1112242) --[[随机获得一件奖励]], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    dropNote:centerBottom(330)
    self._giantBoxContentLayout:addChild(dropNote)

    -- 分割线
    local splitter = UI.Image:create()
    splitter:init("ui_guild_giftbag_line.png")
    splitter:centerBottom(323)
    self._giantBoxContentLayout:addChild(splitter)

    -- 大宝箱内容列表
    self:initGiantBoxContentTable()

    -- 领取按钮
    self._getGiantBoxButton = UI.Button:create()
    self._getGiantBoxButton:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
    self._getGiantBoxButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._getGiantBoxButton:setText(LanguageManager:getInstance():getLocalString(1112117)--[["领取"]])
    self._getGiantBoxButton:centerBottom(-25)
    self._getGiantBoxButton:setInterval(1)
    self._giantBoxContentLayout:addChild(self._getGiantBoxButton)
    self._getGiantBoxButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if (self._lastReuqestOpenGiantBoxTime == nil or os.time() - self._lastReuqestOpenGiantBoxTime >= 1) then
            self._lastReuqestOpenGiantBoxTime = os.time()
            if (not GuildBoxDataManager:checkNotifyIsAbleToOpenBox(true)) then return end

            GuildBoxDataManager:requestOpenBox(-1) -- -1为大宝箱
        end
    end)
end

-- 公会宝箱列表初始化
function GuildManagerPanel:initGuildBoxTable()
    -- 目标列表
    require "app.ui.guild.manager.GuildBoxCell"
    self._guildBoxTableView = UI.TableView:create({}, 500, 408)
    self._guildBoxTableView:leftBottom(345, 87)
    self._guildBoxTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._guildBoxTableView:setDelegate()
    self._guildBoxTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._guildBoxTableView:init()
    self._guildBoxTableView:setScrollBarEnabled(true)
    self._guildBoxTableView:setCircleVisible(false)
    self._guildBoxTableView:setScrollBarWidth(5)
    self._guildBoxTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    self._guildBoxTableView:onUpdateCellSize(function ()
        return UI.GuildBoxCell.CELL_WIDTH, UI.GuildBoxCell.CELL_HEIGHT
    end) 
    self._guildBoxTableView:onUpdateCells(function (tableview, idx)
        -- 创建单元
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.GuildBoxCell.new(self._guildBoxTableView)
        end

        -- 更新单元
        xpcall(function()
            local goalData = GuildBoxDataManager:getSmallBoxDataReversed()[luaIdx]
            if (goalData) then
                if (cell.reset) then cell:reset() end
                cell:setClickCallback(function(callbackID, extraData)
                    printInfo("SevenDayGoalLayer:cellClick, idx", luaIdx)
                    if (GuildBoxDataManager:isAbleToOpenBox()) then
                        if (callbackID == UI.GuildBoxCell.CB_OPENBOX) then
                            GuildBoxDataManager:requestOpenBox(luaIdx, true)
                        elseif (UI.GuildBoxCell.CB_OPENBOX_ANIMATION_DONE) then
                            local smallBoxIcon = extraData
                            if (smallBoxIcon) then
                                local iconCenterWorldPos = smallBoxIcon:convertToWorldSpace(cc.p(smallBoxIcon._hw, smallBoxIcon._hh))
                                self:playOpenSmallBoxAnimation(iconCenterWorldPos)
                            end
                        end
                    end
                end)
                cell:updateData(goalData)
            end
        end, 
        function(e) 
            printInfo("SevenDayGoalLayer:tableCellAtIndex, error")
        end, 1) 

        return cell
    end)
    self._guildBoxTableView:onUpdateCellNumbers(function()
        return GuildBoxDataManager:getSmallBoxDataNum()
    end)
    self._guildBoxLayout:addChild(self._guildBoxTableView)
    self._guildBoxTableView:reloadData()

    -- 滚动遮罩
    local mask = UI.Image:create()
    mask:init("ui_guild_mamagement_banner_paper_mask_3.png")
    mask:leftBottom(332, 85)
    self._guildBoxLayout:addChild(mask)

    -- 次数限制下横线 leftBottom 350, 85
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(480, 2))
    splitLine:leftBottom(350, 85)
    self._guildBoxLayout:addChild(splitLine)
end

-- 初始化大宝箱内容
function GuildManagerPanel:initGiantBoxContentTable()
     -- 目标列表
     require "app.ui.guild.manager.GuildGiantBoxContentCell"
     self._guildGiantBoxContentTable = UI.TableView:create({}, 258, 281)
     self._guildGiantBoxContentTable:centerBottom(36)
     self._guildGiantBoxContentTable:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
     self._guildGiantBoxContentTable:setDelegate()
     self._guildGiantBoxContentTable:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
     self._guildGiantBoxContentTable:init()
     self._guildGiantBoxContentTable:onUpdateCellSize(function ()
         return UI.GuildGiantBoxContentCell.CELL_WIDTH, UI.GuildGiantBoxContentCell.CELL_HEIGHT
     end) 
     self._guildGiantBoxContentTable:onUpdateCells(function (tableview, idx)
         -- 创建单元
         local luaIdx = idx + 1
         local cell = tableview:dequeueCell()
         if cell == nil then
             cell = UI.GuildGiantBoxContentCell.new(self._guildGiantBoxContentTable)
         end
 
         -- 更新单元
         xpcall(function()
             local goalData = GuildBoxDataManager:getGiantBoxContentItemArr()[luaIdx]
             if (goalData) then
                 if (cell.reset) then cell:reset() end
                 cell:setClickCallback(function(comp)
                     printInfo("GuildGiantBoxContentCell:cellClick, idx", luaIdx)
                 end)
                 cell:updateData(goalData)
             end
         end, 
         function(e) 
             printInfo("SevenDayGoalLayer:tableCellAtIndex, error")
         end, 1) 
 
         return cell
     end)
     self._guildGiantBoxContentTable:onUpdateCellNumbers(function()
         return #GuildBoxDataManager:getGiantBoxContentItemArr()
     end)
     self._giantBoxContentLayout:addChild(self._guildGiantBoxContentTable)
     self._guildGiantBoxContentTable:reloadData()
 
    -- 滚动遮罩
    local mask = UI.Image:create()
    mask:init("ui_guild_giftbag_mask.png")
    mask:centerBottom(36)
    self._giantBoxContentLayout:addChild(mask)
end

-- 播放开箱动画
function GuildManagerPanel:playOpenSmallBoxAnimation(fromWorldPos)
    -- 如果有坐标传入, 就播放拖尾动画, 否则只播放爆炸
    if (fromWorldPos) then
        -- 小宝箱点转换至本地坐标
        local localSmallBoxPos = self:convertToNodeSpace(fromWorldPos)

        -- 大宝箱点转换至本地坐标
        local giantIconCenter = self._giantBoxIcon:convertToWorldSpace(cc.p(self._giantBoxIcon._hw, self._giantBoxIcon._hh))
        local localGiantBoxPos = self:convertToNodeSpace(giantIconCenter)

        -- 直角点转换至本地坐标
        local localAnchorPoint = cc.p(localSmallBoxPos.x, localGiantBoxPos.y)

        -- 对边领边和角度
        local oppositeLegnth = localSmallBoxPos.y - localAnchorPoint.y
        local adjacentLegnth = localAnchorPoint.x - localGiantBoxPos.x
        local angleInRadiant = math.atan(oppositeLegnth / adjacentLegnth)
        local angle = 180 * angleInRadiant / math.pi
        local rotateAmount = 90 - angle - 45
        local scaleY = 1
        if (rotateAmount > 45) then
            scaleY = -1
            rotateAmount = rotateAmount - 90
        end

        -- 拉伸或缩短长度  
        local defaultMag = 1.3274857593876
        local targetMag = 1/math.cos(angleInRadiant)
        local scale = targetMag / defaultMag

        -- 宝箱拖尾飞行动画
        performWithDelay(self, function()
            local flyAnimation = UI.Animation:create()
            flyAnimation:init("effect_ui_town_guild_guildgift_tuowei.json", "effect_ui_town_guild_guildgift_tuowei.atlas", 1)
            flyAnimation:center(-2, 38)
            flyAnimation:rotate(rotateAmount)
            flyAnimation:setScaleY(scaleY * scale)
            flyAnimation:setScaleX(scale)
            flyAnimation:addAnimation("trigger1", false)
            self._giantBoxOutsideLookLayout:addChild(flyAnimation)
            flyAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
                local startPos = string.find(event.animation, "trigger1")
                if(startPos ~= nil) then
                    performWithDelay(self, function() 
                        flyAnimation:removeFromParent()
                    end, 0.01)
                end
            end)
        end, 0.1)
    end

    

    -- -- ICON动画
    -- if (not self._giantBoxEffectCounter) then
    --     self._giantBoxEffectCounter = 0
    -- end
    -- self._giantBoxEffectCounter = self._giantBoxEffectCounter + 1
    -- local function animationCompleteHandler()
    --     self._giantBoxEffectCounter = self._giantBoxEffectCounter - 1
    --     if (self._giantBoxEffectCounter == 0) then
    --         self:refreshGiantBoxAnimation()
    --     end
    --     flyAnimation:removeEventListener(UIEvent.ANIMATION_COMPLETE, self, animationCompleteHandler)
    -- end
    -- self._giantBoxIcon:setAnimation("idle2", false)
    -- flyAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, animationCompleteHandler)
end

-- 大宝箱金光炸裂动画
function GuildManagerPanel:playGiantBoxGoldenLight()
    -- 宝箱金光炸裂动画
    local flyAnimation = UI.Animation:create()
    flyAnimation:init("effect_ui_town_guild_guildgift_tuowei.json", "effect_ui_town_guild_guildgift_tuowei.atlas", 1)
    flyAnimation:center(-2, 38)
    flyAnimation:addAnimation("trigger2", false)
    self._giantBoxOutsideLookLayout:addChild(flyAnimation)
    flyAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
        local startPos = string.find(event.animation, "trigger2")
        if(startPos ~= nil) then
            performWithDelay(self, function() 
                flyAnimation:removeFromParent()
            end, 0.01)
        end
    end)
end

-- 大宝箱的小宝箱开箱动画
function GuildManagerPanel:playOpenSmallBoxGiantBoxAnimation()
    Avalon.AudioManager:playSoundDelay("1517", 70)
    self:playGiantBoxGoldenLight()
    self._giantBoxIcon:setAnimation("idle2", false)
    self:refreshGiantBoxAnimation(true)
end

-- 展示大宝箱内容
function GuildManagerPanel:showGiantBoxContent(b)
    self._isShowGiantBoxContent = b
    self:refreshGiantBoxView()
end

-- 更新公会宝箱按钮
function GuildManagerPanel:refreshGuildBoxButtons()
    -- 更新清除领取按钮
    local droppedBoxNum = GuildBoxDataManager:getDroppedSmallBoxNum()
    local clearIcon = self._clearBtn:getChildByName("icon")
    if (droppedBoxNum > 0) then
        self._clearBtn:enable()
        if (clearIcon) then clearIcon:setSpriteName("ui_btn_reduction_1.png") end
    else
        self._clearBtn:disable()
        if (clearIcon) then clearIcon:setSpriteName("ui_btn_reduction_0.png") end
    end

    -- 更新获取所有按钮
    local openableBoxNum = GuildBoxDataManager:getDroppableSmallBoxNum()
    local getAllIcon = self._getAllBtn:getChildByName("icon")
    if (openableBoxNum > 0) then
        self._getAllBtn:enable()
        if (getAllIcon) then getAllIcon:setSpriteName("ui_main_button_shopping_1.png") end
    else
        self._getAllBtn:disable()
        if (getAllIcon) then getAllIcon:setSpriteName("ui_main_button_shopping_0.png") end
    end
end

-- 刷新大宝箱表现
function GuildManagerPanel:refreshGiantBoxView()
    local giantBoxData = GuildBoxDataManager:getGiantBoxData()
    if (not giantBoxData) then
        self._giantBoxOutsideLookLayout:hide()
        self._giantBoxContentLayout:hide()
        self._emptyText:show()
        self._isShowGiantBoxContent = false
        return
    else
        if (self._isShowGiantBoxContent) then
            self._giantBoxOutsideLookLayout:hide()
            self._giantBoxOutsideLookLayout:leftBottom(-10000, -10000)
            self._giantBoxContentLayout:show()
            self._giantBoxContentLayout:leftBottom(0, 0)
            self._giantBoxContentLayout:setInterceptTouches(true)
            self._guildGiantBoxContentTable:reloadData()
        else
            self._giantBoxOutsideLookLayout:show()
            self._giantBoxOutsideLookLayout:leftBottom(0, 0)
            self._giantBoxContentLayout:hide()
            self._giantBoxContentLayout:leftBottom(-10000, -10000)
            self._giantBoxContentLayout:setInterceptTouches(false)
        end
        self._emptyText:hide()
    end

    -- 更新大宝箱进度
    local giantBoxProgress = GuildBoxDataManager:getGiantBoxProgressForDisplay()
    local giantBoxValue = giantBoxData.pointValue
    if (giantBoxProgress and giantBoxValue and giantBoxProgress) then
        -- 更新文字
        local progressText = string.format("%s/%s", giantBoxProgress, giantBoxValue)
        self._giantBoxProgressText:setText(string.format(LanguageManager:getInstance():getLocalString(1112234)--[["开箱进度:%s"]], progressText))

        -- 更新图片
        local percentValue = (giantBoxProgress / giantBoxValue) * 100
        if (percentValue > 100) then percentValue = 100 end
        if (percentValue < 0) then percentValue = 0 end
        local oldPercent = self._giantBoxProgressBar:getPercent()
        self._giantBoxProgressBar:setPercent(percentValue / 100)
        
        -- 更新进度动画
        if (giantBoxProgress >= giantBoxValue) then
            self._giantBoxProgressEffect:show()
            self._giantBoxProgressEffect:setTimeScale(1)
            self._giantBoxProgressEffect:setAnimation("trigger", false)
            self._giantBoxProgressEffect:addAnimation("idle", true)
        else
            self._giantBoxProgressEffect:hide()
            self._giantBoxProgressEffect:setTimeScale(0)
        end

        -- 更新大宝箱状态
        if (oldPercent ~= 0 and oldPercent < percentValue) then
            if (not self._skipGiantBoxAnimationOnce) then
                self:playOpenSmallBoxGiantBoxAnimation()
            else
                self._skipGiantBoxAnimationOnce = false
            end
        end

        -- 更新按钮状态
        if (giantBoxProgress >= giantBoxValue) then
            self._getGiantBoxButton:enable()
        else
            self._getGiantBoxButton:disable()
        end

        -- 更新大宝箱计时
        self:refreshGiantBoxCountDown()
    end

    -- 更新大宝箱名字
    local giantBoxName = giantBoxData.boxName
    if (giantBoxName) then
        local nameString = LanguageManager:getInstance():getLocalString(giantBoxName)
        self._giantBoxName:setText(nameString)
    end

    -- 更新大宝箱样子
    local giantBoxIconName = giantBoxData.icon
    if (giantBoxIconName and giantBoxIconName ~= "" and giantBoxIconName..".json" ~= self._giantBoxIcon._skeletonFile) then
        self._giantBoxIcon:setAnimationData(giantBoxIconName..".json", giantBoxIconName..".atlas", 1)
        self:refreshGiantBoxAnimation()
    end

    -- 刚开始第一次刷新
    if (not self._isFirstTimeRefreshGiantBoxAnimation) then
        self._isFirstTimeRefreshGiantBoxAnimation = true
        self:refreshGiantBoxAnimation()
    end
end

-- 更新大宝箱动画
function GuildManagerPanel:refreshGiantBoxAnimation(isAddAnimation)
    local giantBoxData = GuildBoxDataManager:getGiantBoxData()
    if (not giantBoxData) then return end

    local giantBoxProgress = GuildBoxDataManager:getGiantBoxProgressForDisplay()
    local giantBoxValue = giantBoxData.pointValue
    if (giantBoxProgress >= giantBoxValue) then
        if (isAddAnimation) then
            self._giantBoxIcon:addAnimation("idle2", true)
        else
            self._giantBoxIcon:setAnimation("idle2", true)
        end
    else
        if (isAddAnimation) then
            self._giantBoxIcon:addAnimation("idle1", true)
        else
            self._giantBoxIcon:setAnimation("idle1", true)
        end
    end
end

-- 刷新计时器
function GuildManagerPanel:refreshGiantBoxCountDown()
    local giantBoxData = GuildBoxDataManager:getGiantBoxData()
    if (giantBoxData and giantBoxData.expiration and giantBoxData.expiration > 0 and giantBoxData.timeLimit) then
        local timeNow = GameManager:getNormalServerTime()
        local timeDelta = giantBoxData.expiration - timeNow
        if (timeDelta < 0) then timeDelta = 0 end
        local progress = timeDelta / giantBoxData.timeLimit
        if (progress > 1) then progress = 1 end
        if (progress < 0) then progress = 0 end

        self._giantBoxCountDownProgress:show()
        self._giantBoxTimeText:show()
        self._giantBoxTimeIcon:show()
        self._giantBoxCountDownProgress:setPercent(progress)
        self._giantBoxTimeText:setText(AvalonUtil:_getFullFormatTime(timeDelta, true))
    else
        self._giantBoxCountDownProgress:hide()
        self._giantBoxTimeText:hide()
        self._giantBoxTimeIcon:hide()
    end
end

-- 刷新公会宝箱表现
function GuildManagerPanel:refreshGuildBoxView(isGiantBoxOpened)
    -- 大宝箱更新了
    if (isGiantBoxOpened) then
        self._isShowGiantBoxContent = false
    end

    -- 更新已领取数量
    local curDropNum = GuildBoxDataManager:getCurrentOpenedNumForDisplay()
    local limitDropNum = GuildBoxDataManager:getLimitOpenNum()
    if (curDropNum and limitDropNum and limitDropNum > 0) then
        -- 刷新数字
        self._dropNumLabel:show()
        self._dropNumText:show()
        self._dropNumText:setText(string.format("%s/%s", curDropNum, limitDropNum))

        -- 刷新颜色
        if (curDropNum >= limitDropNum) then
            self._dropNumText:setFontColor(BOX_NUM_FULL_FONT_COLOR)
        else
            self._dropNumText:setFontColor(BOX_NUM_NORMAL_FONT_COLOR)
        end
    else
        self._dropNumLabel:hide()
        self._dropNumText:hide()
    end

    -- 刷新大宝箱表现
    self:refreshGiantBoxView()

    -- 更新按钮状态
    self:refreshGuildBoxButtons()

    -- 更新红点显示
    if (self._boxStatus) then
        if (GuildBoxDataManager:getNewBoxFlag() and self._choiceTabIndex ~= UI.GUILD_MANGER_TYPE.GUILD_BOX) then
            self._boxStatus:setVisible(true)
        else
            self._boxStatus:setVisible(false)
        end
    end

    -- 更新宝箱数据列表
    self:refreshBoxList()
end

-- 更新宝箱数据列表
function GuildManagerPanel:refreshBoxList()
    -- 更新列表数据
    self._guildBoxTableView:reloadData()
end

-- 新箱子状态有变化
function GuildManagerPanel:onNewBoxStatusChanged(isArrive)
    if (isArrive) then
        self:requestNewBoxInfo()
    else
        self:refreshGuildBoxView()
    end
end

-- 重新拉去公会宝箱数据
function GuildManagerPanel:requestNewBoxInfo()
    GuildBoxDataManager:requestNewBoxInfo()
end

-- 管理成员宿主层
function GuildManagerPanel:initManagerLayout()
    self._managerLayout = UI.Layout:create()
    self._managerLayout:init()
    self._managerLayout:setSize(852, 534)
    self._managerLayout:leftBottom(63, 21)
    self._contentLayout:addChild(self._managerLayout,21)

    -- 添加下面的列表
    local bgPaper = UI.Image9:create()
    bgPaper:init("ui_bg_paper2.png", CCRectMake(302,140,2,2), cc.size(852, 534))
    bgPaper:centerBottom(0)
    self._managerLayout:addChild(bgPaper)

    -- local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", cc.rect(302,140,2,2))
    -- bottomBlackSide:setContentSize(cc.size(852, 534))  
    -- bottomBlackSide:setPosition(cc.p(420, 448/2))
    -- self._managerLayout:addChild(bottomBlackSide)

    -- 初始化管理设置
    self:initManagerSetting()
    -- 初始化管理成员信息
    self:initManagerCell()
end

-- 普通成员背景和宿主层
function GuildManagerPanel:initMainLayout()
    self._mainLayout = UI.Layout:create()
    self._mainLayout:init()
    self._mainLayout:setSize(854, 531)
    self._mainLayout:leftBottom(63, 23)
    self._contentLayout:addChild(self._mainLayout,21)

    -- 添加背景
    local bgBottom = UI.Image:create()
    bgBottom:init("ui_guild_mamagement_banner_paper.png")
    bgBottom:centerBottom(-3)
    self._mainLayout:addChild(bgBottom)

    -- 初始化成员功能面板
    self:initMainFunction()
    -- 初始化公会信息面板
    self:initMainGuildInfo()
    -- 初始化成员个人信息面板
    self:initMainCell()
end

-- 管理成员信息展示栏
function GuildManagerPanel:initManagerCell()
    -- 公会列表标题栏
    local listTitleImage = UI.Layout:create()
    listTitleImage:init()
    listTitleImage:setSize(840, 48)
    listTitleImage:centerUp(10)
    -- listTitleImage:enableDebugDraw()
    self._managerLayout:addChild(listTitleImage)

    -- 昵称以及职位
    local guildName = UI.Text:create()
    guildName:init(LanguageManager:getInstance():getLocalString(1110559), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildName:setTextHorizontalCenter()
    guildName:setSize(0, 0)
    guildName:centerLeft(180)
    listTitleImage:addChild(guildName, 10)

    -- 添加排序按钮
    local titleSortLayout = UI.Layout:create()
    titleSortLayout:init()
    titleSortLayout:setSize(156, 35)
    titleSortLayout:centerLeft(110)
    titleSortLayout:setTouchEnable(true)
    titleSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(titleSortLayout)

    titleSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.TITLE] == 1 then
            self.titleSortArrow1:setScaleY(1)
            self.titleSortArrow2:setScaleY(1)
        else
            self.titleSortArrow1:setScaleY(-1)
            self.titleSortArrow2:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.TITLE)
    end)

    local titleSortArrow1 = UI.Image:create()
    titleSortArrow1:init("ui_guild_sort_arrow.png")
    titleSortArrow1:centerLeft(180 + guildName:getContentSize().width/2 + 2)
    if self.sortType[SORT_TYPE.TITLE] == 1 then
        titleSortArrow1:setScaleY(-1)
    else
        titleSortArrow1:setScaleY(1)
    end
    listTitleImage:addChild(titleSortArrow1)
    self.titleSortArrow1 = titleSortArrow1

    -- 本周贡献
    local levelText = UI.Text:create()
    levelText:init(LanguageManager:getInstance():getLocalString(1110560), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    levelText:setTextHorizontalCenter()
    levelText:setSize(0, 0)
    levelText:centerLeft(377)
    levelText:enableDebugDraw()
    listTitleImage:addChild(levelText, 10)

    -- 添加排序按钮
    local contriSortLayout = UI.Layout:create()
    contriSortLayout:init()
    contriSortLayout:setSize(155, 35)
    contriSortLayout:centerLeft(310)
    contriSortLayout:setTouchEnable(true)
    contriSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(contriSortLayout)

    contriSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.CONTRI] == 1 then
            self.contriSortArrow1:setScaleY(1)
            self.contriSortArrow2:setScaleY(1)
        else
            self.contriSortArrow1:setScaleY(-1)
            self.contriSortArrow2:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.CONTRI)
    end)

    local contriSortArrow1 = UI.Image:create()
    contriSortArrow1:init("ui_guild_sort_arrow.png")
    contriSortArrow1:centerLeft(377 + levelText:getContentSize().width/2 + 2)
    if self.sortType[SORT_TYPE.CONTRI] == 1 then
        contriSortArrow1:setScaleY(-1)
    else
        contriSortArrow1:setScaleY(1)
    end
    listTitleImage:addChild(contriSortArrow1)
    self.contriSortArrow1 = contriSortArrow1

    -- 行商收购
    local curNumText = UI.Text:create()
    curNumText:init(UI.TEXT_221802, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    curNumText:setTextHorizontalCenter()
    curNumText:setSize(0, 0)
    curNumText:centerLeft(554)
    listTitleImage:addChild(curNumText, 10)
    self._memberStatus = curNumText

    -- 添加排序按钮
    local loginSortLayout = UI.Layout:create()
    loginSortLayout:init()
    loginSortLayout:setSize(110, 35)
    loginSortLayout:centerLeft(510)
    loginSortLayout:setTouchEnable(true)
    loginSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(loginSortLayout)
    loginSortLayout:hide()

    loginSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.LOGIN] == 1 then
            self.loginSortArrow1:setScaleY(1)
            self.loginSortArrow2:setScaleY(1)
        else
            self.loginSortArrow1:setScaleY(-1)
            self.loginSortArrow2:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.LOGIN)
    end)

    local loginSortArrow1 = UI.Image:create()
    loginSortArrow1:init("ui_guild_sort_arrow.png")
    loginSortArrow1:centerLeft(554 + curNumText:getContentSize().width/2 + 2)
    if self.sortType[SORT_TYPE.LOGIN] == 1 then
        loginSortArrow1:setScaleY(-1)
    else
        loginSortArrow1:setScaleY(1)
    end
    listTitleImage:addChild(loginSortArrow1)
    self.loginSortArrow1 = loginSortArrow1
    loginSortArrow1:hide()


    -- 职位调整
    local joinLimitText = UI.Text:create()
    joinLimitText:init(LanguageManager:getInstance():getLocalString(1110562), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    joinLimitText:setTextHorizontalCenter()
    joinLimitText:setSize(0, 0)
    joinLimitText:centerLeft(755)
    listTitleImage:addChild(joinLimitText, 10)
    self._joinLimitText = joinLimitText

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(823, 2))
    splitLine:centerBottom(1)
    listTitleImage:addChild(splitLine)

    -- 公会列表
    self.guildListManagerTableView = cc.TableView:create(cc.size(840, 375 - 5))
    self.guildListManagerTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.guildListManagerTableView:setPosition(cc.p(0, 95))
    self.guildListManagerTableView:setDelegate()
    self.guildListManagerTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._managerLayout:addChild(self.guildListManagerTableView, 20)
    self.guildListManagerTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableViewManager),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.guildListManagerTableView:registerScriptHandler(handler(self,self.scrollViewDidScrollManager),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.guildListManagerTableView:registerScriptHandler(handler(self,self.cellSizeForTableManager),cc.TABLECELL_SIZE_FOR_INDEX)
    self.guildListManagerTableView:registerScriptHandler(handler(self,self.tableCellAtIndexManager),cc.TABLECELL_SIZE_AT_INDEX)
    self.guildListManagerTableView:initScrollBar()
    self.guildListManagerTableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    -- self.guildListManagerTableView:hide()

    -- 下部遮挡
    local mask = UI.Image:create()
    mask:init("ui_guild_mamagement_banner_mask_2.png")
    mask:centerBottom(93)
    self._managerLayout:addChild(mask, 20)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(823, 2))
    splitLine:centerBottom(90)
    self._managerLayout:addChild(splitLine, 20)
end 

function GuildManagerPanel:sortLayoutClick(type)
    local thisSortType = self.sortType[type]
    if thisSortType == 1 then
        self.sortType[type] = 0
    else
        self.sortType[type] = 1
    end

    self:sortMemberData()

    self:refreshTableView()
end

-- 普通成员信息展示栏
function GuildManagerPanel:initMainCell()
    -- 公会列表标题栏
    local listTitleImage = UI.Layout:create()
    listTitleImage:init()
    listTitleImage:setSize(551, 48)
    listTitleImage:leftBottom(289, 478)
    self._mainLayout:addChild(listTitleImage, 10)

    -- 昵称以及职位
    local guildName = UI.Text:create()
    guildName:init(LanguageManager:getInstance():getLocalString(1110559), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildName:setTextHorizontalCenter()
    guildName:setSize(0, 0)
    guildName:centerLeft(88)
    listTitleImage:addChild(guildName, 10)
    guildName:enableDebugDraw(UI.RED)

    -- 添加排序按钮
    local titleSortLayout = UI.Layout:create()
    titleSortLayout:init()
    titleSortLayout:setSize(156, 35)
    titleSortLayout:centerLeft(110)
    titleSortLayout:setTouchEnable(true)
    titleSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(titleSortLayout)

    titleSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.TITLE] == 1 then
            self.titleSortArrow2:setScaleY(1)
            self.titleSortArrow1:setScaleY(1)
        else
            self.titleSortArrow2:setScaleY(-1)
            self.titleSortArrow1:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.TITLE)
    end)

    local titleSortArrow2 = UI.Image:create()
    titleSortArrow2:init("ui_guild_sort_arrow.png")
    titleSortArrow2:centerLeft(guildName:getLeft() + guildName:getContentSize().width/2 + 8)
    if self.sortType[SORT_TYPE.TITLE] == 1 then
        titleSortArrow2:setScaleY(-1)
    else
        titleSortArrow2:setScaleY(1)
    end
    listTitleImage:addChild(titleSortArrow2)
    self.titleSortArrow2 = titleSortArrow2

    -- 本周贡献
    local levelText = UI.Text:create()
    levelText:init(LanguageManager:getInstance():getLocalString(1110560), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    levelText:setTextHorizontalCenter()
    levelText:setSize(0, 0)
    levelText:centerLeft(320)
    listTitleImage:addChild(levelText, 10)

    -- 添加排序按钮
    local contriSortLayout = UI.Layout:create()
    contriSortLayout:init()
    contriSortLayout:setSize(155, 35)
    contriSortLayout:centerLeft(290)
    contriSortLayout:setTouchEnable(true)
    contriSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(contriSortLayout)

    contriSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.CONTRI] == 1 then
            self.contriSortArrow2:setScaleY(1)
            self.contriSortArrow1:setScaleY(1)
        else
            self.contriSortArrow2:setScaleY(-1)
            self.contriSortArrow1:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.CONTRI)
    end)

    local contriSortArrow2 = UI.Image:create()
    contriSortArrow2:init("ui_guild_sort_arrow.png")
    contriSortArrow2:centerLeft(levelText:getLeft() + levelText:getContentSize().width/2 + 8)
    if self.sortType[SORT_TYPE.CONTRI] == 1 then
        contriSortArrow2:setScaleY(-1)
    else
        contriSortArrow2:setScaleY(1)
    end
    listTitleImage:addChild(contriSortArrow2)
    self.contriSortArrow2 = contriSortArrow2

    -- 行商收购 
    local curNumText = UI.Text:create()
    curNumText:init(UI.TEXT_221802, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    curNumText:setTextHorizontalCenter()
    curNumText:setSize(0, 0)
    curNumText:centerLeft(480)
    listTitleImage:addChild(curNumText, 10)

    -- 添加排序按钮
    local loginSortLayout = UI.Layout:create()
    loginSortLayout:init()
    loginSortLayout:setSize(110, 35)
    loginSortLayout:centerLeft(450)
    loginSortLayout:setTouchEnable(true)
    loginSortLayout:setSwallowTouches(true)
    listTitleImage:addChild(loginSortLayout)
    loginSortLayout:hide()

    loginSortLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        if self.sortType[SORT_TYPE.LOGIN] == 1 then
            self.loginSortArrow2:setScaleY(1)
            self.loginSortArrow1:setScaleY(1)
        else
            self.loginSortArrow2:setScaleY(-1)
            self.loginSortArrow1:setScaleY(-1)
        end
        self:sortLayoutClick(SORT_TYPE.LOGIN)
    end)

    local loginSortArrow2 = UI.Image:create()
    loginSortArrow2:init("ui_guild_sort_arrow.png")
    loginSortArrow2:centerLeft(curNumText:getLeft() + curNumText:getContentSize().width/2 + 8)
    if self.sortType[SORT_TYPE.LOGIN] == 1 then
        loginSortArrow2:setScaleY(-1)
    else
        loginSortArrow2:setScaleY(1)
    end
    listTitleImage:addChild(loginSortArrow2)
    self.loginSortArrow2 = loginSortArrow2
    loginSortArrow2:hide()

    -- 公会列表
    self.guildListTableView = cc.TableView:create(cc.size(551,396))
    self.guildListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.guildListTableView:setPosition(cc.p(289, 81))
    self.guildListTableView:setDelegate()
    self.guildListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._mainLayout:addChild(self.guildListTableView, 20)
    self.guildListTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    -- self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    -- self.guildListTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.guildListTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.guildListTableView:initScrollBar()
    self.guildListTableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    -- self.guildListTableView:reloadData()
    -- self.guildListTableView:hide()

    -- 遮罩
    -- local bottomMask = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", cc.rect(302,140,2,2))
    -- bottomMask:setContentSize(cc.size(840, 448))  
    -- bottomMask:setPosition(cc.p(420, 448/2))
    -- self._managerLayout:addChild(bottomMask)

    local mask = UI.Image:create()
    mask:init("ui_guild_mamagement_banner_paper_mask.png")
    mask:leftBottom(289 + 3, 78)
    self._mainLayout:addChild(mask, 20)
    -- ui_guild_mamagement_banner_mask
end

-- 刷新标签页展示状态
function GuildManagerPanel:refreshTabItem()
    if(self._managerFunctionTab and not tolua.isnull(self._managerFunctionTab)) then 
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Member) then
            self._managerFunctionTab:setTouchEnable(false)
            self._managerFunctionTab:setVisible(false)
            self._managerTabText:setVisible(false)
        else
            self._managerFunctionTab:setTouchEnable(true)
            self._managerFunctionTab:setVisible(true)
            self._managerTabText:setVisible(true)
        end
        self._functionTabList:updateView()
    end
end

function GuildManagerPanel:makeVersionText(str)
    local tableStr = AvalonUtil.utf8tochars(str)

    local str = ""
    for k, v in pairs(tableStr) do 
        if(str == "") then
            str = v.char
        else 
            str = str .. "\n".. v.char
        end
    end

    return str
end

-- 关闭公会页面
function GuildManagerPanel:exitGuildManager()

    UI.WaitingLayer:hideWaiting()

    self:closeWin()
end

-- 选择标签
function GuildManagerPanel:choiceTabIndex(tabIndex)
    local isAbleToChange = true
    if (self._choiceTabIndex ~= tabIndex) then
        self._choiceTabIndex = tabIndex
        self._functionTabList:setDefaultIndex(tabIndex)
        self._newApplyStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
        self._boxStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
        self._mainTabText:setFontColor(UI.FONT_COLOR_47_50_55)
        self._managerTabText:setFontColor(UI.FONT_COLOR_47_50_55)
        self._boxTabText:setFontColor(UI.FONT_COLOR_47_50_55)
        if (tabIndex == UI.GUILD_MANGER_TYPE.MAIN_INFO) then
            -- 激活主页
            self._mainTabText:setFontColor(TAB_ACTIVE_FONT_COLOR)
            self._guildBoxLayout:setVisible(false)
            self._guildBoxLayout:leftBottom(-10000, -10000)
            self._managerLayout:setVisible(false)
            self._managerLayout:leftBottom(-10000, -10000)
            self._mainLayout:setVisible(true)
            self._mainLayout:leftBottom(63, 23)
        elseif (tabIndex == UI.GUILD_MANGER_TYPE.MANAGER) then
            -- 激活管理
            self._managerTabText:setFontColor(TAB_ACTIVE_FONT_COLOR)
            self._guildBoxLayout:setVisible(false)
            self._guildBoxLayout:leftBottom(-10000, -10000)
            self._mainLayout:setVisible(false)
            self._mainLayout:leftBottom(-10000, -10000)
            self._managerLayout:setVisible(true)
            self._managerLayout:leftBottom(63, 23)
            self._newApplyStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_ACTV, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
        elseif (tabIndex == UI.GUILD_MANGER_TYPE.GUILD_BOX) then
            -- 宝箱页面
            if (GuildBoxDataManager:isAbleToSee()) then
                self._boxTabText:setFontColor(TAB_ACTIVE_FONT_COLOR)
                self._mainLayout:setVisible(false)
                self._mainLayout:leftBottom(-10000, -10000)
                self._managerLayout:setVisible(false)
                self._managerLayout:leftBottom(-10000, -10000)
                self._guildBoxLayout:setVisible(true)
                self._guildBoxLayout:leftBottom(63, 23)
                self._boxStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_ACTV, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
                self:requestNewBoxInfo()
            else
                isAbleToChange = false
            end
        end

        if (isAbleToChange) then
            self:refreshHelpInfo(tabIndex)
            self:refreshTableView()
        end
    end

    return isAbleToChange
end

-- 初始化设置页面
function GuildManagerPanel:initManagerSetting()
    -- 添加了公会申请面板
    local joinSettingBg = UI.Layout:create()
    joinSettingBg:init()
    joinSettingBg:setSize(840, 74)
    joinSettingBg:centerBottom(5)
    self._managerLayout:addChild(joinSettingBg, 10)
    self._joinSettingContent = joinSettingBg

    -- 公会人数
    local nameIcon = UI.Image:create()
    nameIcon:init("ui_guild_icon_guilds.png")
    joinSettingBg:addChild(nameIcon, 10)

    local iconName = UI.Text:create()
    iconName:init(LanguageManager:getInstance():getLocalString(1110555), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    iconName:setTextLeft()
    iconName:centerLeft(nameIcon:getContentSize().width + 4)
    nameIcon:addChild(iconName, 10)
    nameIcon:leftBottom(116 - (nameIcon:getContentSize().width + iconName:getContentSize().width)/2 -2, 54 - nameIcon:getContentSize().height /2)

    local guildNumText = UI.Text:create()
    guildNumText:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildNumText:setTextHorizontalCenter()
    guildNumText:setSize(0, 0)
    guildNumText:leftBottom(116, 23)
    joinSettingBg:addChild(guildNumText, 10)
    self._guildNumText = guildNumText

    -- 申请审核
    local applyIcon = UI.Image:create()
    applyIcon:init("ui_guild_icon_audit.png")
    applyIcon:leftBottom(226-23+10, 54 - applyIcon:getContentSize().height /2)
    joinSettingBg:addChild(applyIcon, 10)

    local applyName = UI.Text:create()
    applyName:init(LanguageManager:getInstance():getLocalString(1110556), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    applyName:setTextLeft()
    applyName:centerLeft(applyIcon:getContentSize().width + 4)
    applyIcon:addChild(applyName, 10)

    applyIcon:leftBottom(289 - (applyIcon:getContentSize().width + applyName:getContentSize().width)/2 -2, 54 - applyIcon:getContentSize().height /2)

    -- 审核开关
    local switchButton = UI.SwitchButton:create()
    switchButton:init(self.guildData.isOpenJoinAudit, nil, "ui_information_progressbar_short_00.png", "ui_information_progressbar_01.png", "ui_information_progressbar_short_10.png", "ui_information_progressbar_02.png")
    joinSettingBg:addChild(switchButton, 1000)
    switchButton:leftBottom(289 - switchButton:getContentSize().width /2, 23 - switchButton:getContentSize().height/2)
    switchButton:setStateChangeCallBack(function(state)
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or 
           masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
            local master = RoleDataManager:getMaster()
            self.guildData.isOpenJoinAudit = not self.guildData.isOpenJoinAudit
            
            self.audioTime = AUDIO_WAITING_TIME
            self:refresAudit()
        end
    end)
    self._choiceSwitch = switchButton
    self:refresAudit()

    -- 分数限制
    local scoreIcon = UI.Image:create()
    scoreIcon:init("symbol_character_hero_power.png")
    scoreIcon:leftUp(438, 8)
    joinSettingBg:addChild(scoreIcon, 10)

    local scoreTitle = UI.Text:create()
    scoreTitle:init(LanguageManager:getInstance():getLocalString(1110557), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    scoreTitle:setTextLeft()
    scoreTitle:centerLeft(scoreIcon:getContentSize().width + 5)
    scoreIcon:addChild(scoreTitle)

    local scoreX = 561
    local scoreY = 54

    scoreIcon:leftBottom(scoreX - scoreTitle:getContentSize().width / 2 - scoreIcon:getContentSize().width/2 -3, scoreY - scoreIcon:getContentSize().height/2)
    -- scoreTitle:leftUp(scoreX - scoreIcon:getContentSize().width / 2 + scoreTitle:getContentSize().width / 2 + 3, scoreY)

    -- 选择装备分数
    local choiceBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_guild_mamagement_bar.png")
    choiceBg:setContentSize(178, 21)
    choiceBg:setCapInsets(CCRectMake(30,5,1,1))
    choiceBg:setPosition(cc.p(476 + choiceBg:getContentSize().width/2,  15 + choiceBg:getContentSize().height/2))
    joinSettingBg:addChild(choiceBg)

    local scoreTitle = UI.Text:create()
    scoreTitle:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_170_170_170)
    scoreTitle:setTextHorizontalCenter()
    scoreTitle:setSize(0, 0)
    scoreTitle:center()
    choiceBg:addChild(scoreTitle, 10)
    self._scoreLmtText = scoreTitle

    self:refreshScoreLmt()

    -- 左边点击
    local choiceScoreLeft = UI.Button:create()
    choiceScoreLeft:init("ui_guild_mamagement_arrow_button_0.png","ui_guild_mamagement_arrow_button_1.png","ui_guild_mamagement_arrow_button_3.png")
    choiceScoreLeft:centerLeft(-11)
    choiceScoreLeft:setTouchEnable(true)
    choiceScoreLeft:setScaleX(-1)
    choiceScoreLeft:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- 左边选择处理
        -- print("GuildManager click left")
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or 
            masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
            local oldScoreLmt = self.guildData.joinEquipScoreLmt
            self.guildData.joinEquipScoreLmt = self.guildData.joinEquipScoreLmt -1
            if(self.guildData.joinEquipScoreLmt <0) then
                self.guildData.joinEquipScoreLmt = 0
            end
            if(oldScoreLmt ~= self.guildData.joinEquipScoreLmt) then
                self.scoreLmt = SCORE_WAITING_LMT_TIME
            end
            self:refreshScoreLmt()
        end
    end)
    choiceBg:addChild(choiceScoreLeft, 10)
    self._choiceScoreLeft = choiceScoreLeft

    -- 右边点击
    local choiceScoreRight = UI.Button:create()
    choiceScoreRight:init("ui_guild_mamagement_arrow_button_0.png","ui_guild_mamagement_arrow_button_1.png","ui_guild_mamagement_arrow_button_3.png")
    choiceScoreRight:centerRight(-11)
    choiceScoreRight:setTouchEnable(true)
    choiceScoreRight:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- TODO 右边选择处理
        -- print("GuildManager click right")
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or
            masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
            local oldScoreLmt = self.guildData.joinEquipScoreLmt

            self.guildData.joinEquipScoreLmt = self.guildData.joinEquipScoreLmt +1
            if(self.guildData.joinEquipScoreLmt >= #self.equipScore) then
                self.guildData.joinEquipScoreLmt = #self.equipScore - 1
            end
            
            if(oldScoreLmt ~= self.guildData.joinEquipScoreLmt) then
                self.scoreLmt = SCORE_WAITING_LMT_TIME
            end

            self:refreshScoreLmt()
        end
    end)
    choiceBg:addChild(choiceScoreRight, 10)
    -- choiceScoreRight:setScaleX(-1)
    self._choiceScoreRight = choiceScoreRight
    self:refreshScoreLmt()

    -- 申请按钮列表
    local joinApplyButton = UI.Button:create()
    joinApplyButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png", "ui_shopping_button_0.png")
    
    joinApplyButton:rightUp(62, 16)
    joinSettingBg:addChild(joinApplyButton)
    joinApplyButton:setTouchEnable(true)
    joinApplyButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- print("GuildManager click join apply")

        self._requestJoinReqList = true
        Net.NetGuildSystem:reqJoinReqList()
        -- 添加请求loading 效果
        if(self._loading and not tolua.isnull(self._loading)) then 
            self._loading:setVisible(true)
        end
        self._joinApplyButton:disable()
    end)
    self._joinApplyButton = joinApplyButton

    -- 提示有红色的按钮
    self._haveStatus = AvalonUtil.createRedPoint(joinApplyButton, 0, 0, 10)

    self:refreshHaveJoin()
    self:refreshGuildNum()
end

-- 普通成员功能阶段
function GuildManagerPanel:initMainFunction()
    self._requestJoinReqList = false
    if(self._loading and not tolua.isnull(self._loading)) then 
        self._loading:setVisible(false)
    end

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(551, 73)
    contentLayout:leftBottom(289, 0)
    self._mainLayout:addChild(contentLayout, 10)
    self._mainFunctionContent = contentLayout

    -- 排名
    local rankNameText = UI.Text:create()
    rankNameText:init(LanguageManager:getInstance():getLocalString(1110586), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    rankNameText:setTextHorizontalCenter()
    rankNameText:setSize(300, 25)
    rankNameText:setTextRight(0, -0.5)
    rankNameText:centerRight(441)
    self._mainFunctionContent:addChild(rankNameText, 10)

    local rankText = UI.Text:create()
    rankText:init(tostring(self.guildData.rank), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    rankText:setSize(244, 25)
    rankText:centerLeft(122, -0.5)
    rankText:setTextLeft()
    self._mainFunctionContent:addChild(rankText, 10)
    self._rankText = rankText
    self:refreshRankText()

    -- 退会按钮
    local exitGuildButton = UI.Button:create()
    exitGuildButton:init("ui_guild_button_start_0.png","ui_guild_button_start_1.png","ui_guild_button_start_2.png")
    exitGuildButton:centerRight(46, -2)
    exitGuildButton:setTouchEnable(true)
    exitGuildButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- 退出公会
        -- print("GuildManagerPanel click exit")
        local exitRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_EXIT)
        if(exitRepeatData) then return end
        
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_LEADER_TILE_TRANSFER)
        
        local haveTips = false 
        local tipsText = ""
        if((masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader) and repeatData == nil) then
            if(#self.guildData.members == 1) then  
                haveTips = true
                tipsText = LanguageManager:getInstance():getLocalString(1110624)
            else 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110579))
                -- Net.NetGuildSystem:quitGuild(RoleDataManager:getMasterPK())
            end
        else
            haveTips = true
            tipsText = LanguageManager:getInstance():getLocalString(1110570)
        end

        if(haveTips) then 
            require "app.ui.tips.ExitGuildTips"
            local exitGuildTips = UI.ExitGuildTips:create()
            exitGuildTips:init(tipsText)
            exitGuildTips:callfunName(function()
                self:handleExitGuild()
            end)  

            exitGuildTips:center();
            UI.UIManager:getRootNode():addChild(exitGuildTips, UI_ZORDER.TIPS)

            -- UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(tipsText, function()
            --     self:handleExitGuild()
            -- end)
        end
    end)
    self._mainFunctionContent:addChild(exitGuildButton, 10)
    self._extGuildButton = exitGuildButton

    local exitText = UI.Text:create()
    exitText:init(LanguageManager:getInstance():getLocalString(1110585), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    exitText:setTextHorizontalCenter()
    exitText:setSize(0, 0)
    exitText:center()
    exitGuildButton:addChild(exitText, 10)

end

-- 普通成员公会信息
function GuildManagerPanel:initMainGuildInfo()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(289, 522)
    contentLayout:leftUp(0,0)
    self._mainLayout:addChild(contentLayout, 1030)
    self._mainGuilInfo = contentLayout

    -- 公会日志按钮
    local logBtn = UI.Button:create()
    logBtn:init("ui_btn_guild_diary_0.png","ui_btn_guild_diary_1.png","ui_btn_guild_diary_0.png")
    logBtn:leftUp(226, 2)
    logBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local localX, localY = logBtn:getPosition()
        local btnWidth, btnHeight = logBtn:getSize()
        local worldPos = contentLayout:convertToWorldSpace(cc.p(localX, localY))
        worldPos.x = worldPos.x + btnWidth + 20
        worldPos.y = worldPos.y + btnHeight - 20
        mvc.openPanel("GuildLog", "GuildLog", worldPos)
    end)
    contentLayout:addChild(logBtn)

    -- 公会图标
    local iconBg = UI.Image:create()
    iconBg:init("ui_guild_headframe_big.png")
    iconBg:leftUp(138 - iconBg:getContentSize().width/2, 18)
    iconBg:setTouchEnable(true)
    contentLayout:addChild(iconBg)

    -- 公会icon
    local icon = UI.Image:create()
    icon:init(GameDataManager:getInstance():getGuildIconForIconID(self.guildData.iconID))
    icon:center()
    iconBg:addChild(icon)
    self._icon = icon
    iconBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        -- 处理选择公会图标
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        -- print("CreateGuild   COMPONENT_CLICK", masterTitle, PublicDefine.GuildTitle.GuildTitle_Leader, type(masterTitle), type(PublicDefine.GuildTitle.GuildTitle_Leader))
        if(masterTitle and (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader)) then
            -- print("CreateGuild   COMPONENT_CLICK 123")
            self:choiceGuildIcon()
        end
    end)


    -- 公会名字背景
    local guildNameBG = UI.Image:create()
    guildNameBG:init("ui_guild_mamagement_banner_name.png")
    guildNameBG:leftUp(40, 130)
    contentLayout:addChild(guildNameBG)

    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or
        masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
        -- 改名按钮
        local renameBtn = UI.Button:create()
        renameBtn:init("ui_guild_icon_name_modify_0.png","ui_guild_icon_modify_1.png","ui_guild_icon_name_modify_0.png")
        renameBtn:centerLeft(0)
        renameBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if self:getChildByName("GuildRenameLayer") ~= nil then
                self.removeChildByName("GuildRenameLayer")
            end

            -- -- 暂时屏蔽CN的改名功能
            -- if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
            --     UI.ScrollBar:createByTextID(1113615)
            -- else
            --     local guildRenameLayer = UI.GuildRenameLayer:create()
            --     guildRenameLayer:init()
            --     guildRenameLayer:center()
            --     guildRenameLayer:setName("GuildRenameLayer")
            --     self:addChild(guildRenameLayer, 999)
            -- end
            local guildRenameLayer = UI.GuildRenameLayer:create()
            guildRenameLayer:init()
            guildRenameLayer:center()
            guildRenameLayer:setName("GuildRenameLayer")
            self:addChild(guildRenameLayer, 999)
        end)
        guildNameBG:addChild(renameBtn)

        -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
        if SdkManager:responsePolicySwitch() then
            local target = SdkBox:getInstance():getVersionTarget()
            if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
                renameBtn:setVisible(false)
            end
        end
    end

    -- 显示公会名称
    local guildNameText = UI.Text:create()
    guildNameText:init(self.guildData.name, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildNameText:setSize(0, 0)
    guildNameText:setTextHorizontalCenter()
    guildNameText:centerLeft(100)
    guildNameBG:addChild(guildNameText)
    self._guildNameText = guildNameText

    -- 显示公会ID
    local guildIDText = UI.Text:create()
    guildIDText:init(string.format("ID:%d", self.guildData:getID()), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    guildIDText:setTextHorizontalCenter()
    guildIDText:setSize(0, 0)
    guildIDText:centerBottom(-10)
    guildNameBG:addChild(guildIDText, 10)


    local textStartX = 118
    local textStartY = 185
    local textOffsetY = 33
    local fixLineWidth = 100
    local xPos = 178

    -- 成员数量
    local guildNumTitle = self:layoutTabLabel(LanguageManager:getInstance():getLocalString(1110573), fixLineWidth, 327)
    contentLayout:addChild(guildNumTitle, 10)

    local guildNum = UI.Text:create()
    guildNum:init(string.format("%d/%d", 0,0), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    guildNum:setTextCenter()
    guildNum:setSize(148, 24)
    guildNum:leftUp(textStartX, textStartY)
    contentLayout:addChild(guildNum, 10)
    self._manGuildNumText = guildNum

    -- 公会等级
    local nowTextY = textStartY + textOffsetY * 1
    local guildLevelTitle = self:layoutTabLabel(LanguageManager:getInstance():getLocalString(1110520), fixLineWidth, 293)
    contentLayout:addChild(guildLevelTitle, 10)

    local guildLevel = UI.Text:create()
    guildLevel:init(tostring(self.guildData.techTotalLv), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    guildLevel:setTextCenter()
    guildLevel:setSize(148, 24)
    guildLevel:leftUp(textStartX, nowTextY)
    contentLayout:addChild(guildLevel, 10)
    self._guildLevel = guildLevel

    -- 贡献值
    local nowTextY = textStartY + textOffsetY * 2
    local contributionTitle = self:layoutTabLabel(LanguageManager:getInstance():getLocalString(1110550), fixLineWidth, 259)
    contentLayout:addChild(contributionTitle, 10)

    local contributionIcon = UI.Image:create()
    contributionIcon:init("symbol_guild_tech_icon_medal.png")
    contributionIcon:leftUp(textStartX - 5, nowTextY + 13 - contributionIcon:getContentSize().height/2)
    contentLayout:addChild(contributionIcon)

    local contributionNum = UI.Text:create()
    contributionNum:init(self.guildData.contib.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    contributionNum:setTextCenter()
    contributionNum:setSize(148, 24)
    -- contributionNum:setOutline(UI.FONT_COLOR_56_38_27)
    contributionNum:leftUp(textStartX, nowTextY)
    contentLayout:addChild(contributionNum, 10)
    self.guildContibText = contributionNum

    -- 公告
    local contributionTitle = UI.Text:create()
    contributionTitle:init(LanguageManager:getInstance():getLocalString(1110587), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    contributionTitle:setTextHorizontalCenter()
    contributionTitle:setSize(112, 31)
    contributionTitle:centerUp(298)
    contentLayout:addChild(contributionTitle, 10)

    -- 修改公会公告按钮
    if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
        local updateNoticBtn = UI.Button:create()
        updateNoticBtn:init("ui_guild_icon_notice_modify_0.png","ui_guild_icon_notice_modify_1.png","ui_guild_icon_notice_modify_0.png")
        updateNoticBtn:leftUp(10, 294)
        updateNoticBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self._noticeCell:clearTouchBegin()
            local flag = self._noticeCell:clickToEdit()
            if(flag == true) then 
                self:clickToEdit()
            end
        end)
        contentLayout:addChild(updateNoticBtn)

        -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
        if SdkManager:responsePolicySwitch() then
            local target = SdkBox:getInstance():getVersionTarget()
            if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
                updateNoticBtn:setVisible(false)
            end
        end
    end

    -- 公告内容Cell
    if(self._noticeCell) then 
        self._noticeCell:release()
        self._noticeCell = nil 
    end
    self._noticeCell = UI.GuildNoticeCell:create()
    self._noticeCell:init(self.guildData, function ()
        -- body
        -- print("GuildManagerPanel  edit end.")
        self._tableView:reloadData()
        self:refreshGuildNotice()
    end)
    self._noticeCell:retain()

    -- 公告列表(只有一个Cell)
    self._tableView = UI.TableView.new({},233,131)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(25, 60)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        local width = self._noticeCell:getWidht()
        local height = self._noticeCell:getHeight()
        -- print("onUpdateCellSize", width, height)
        return width,height
    end) 
    self._tableView:onUpdateCells(function (table, idx)

        return self._noticeCell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        return 1
    end)
    -- self._tableView:onTableCellTouched(function(table, cell)
    --     -- print("onTableCellTouched=", cell:getTouchBegin())
    --     local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    --     if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
    --         if(cell:getTouchBegin()) then
    --             -- self:refreshNoticeStatus()
    --             cell:clearTouchBegin()
    --             local flag = cell:clickToEdit()
    --             if(flag == true) then 
    --                 self:clickToEdit()
    --             end
    --         end
    --     end 
    -- end)
    contentLayout:addChild(self._tableView,11)
    self._tableView:reloadData(false, true)

    -- 没有公告的表现
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    local noNoticeStr = ""
    if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
        noNoticeStr = LanguageManager:getInstance():getLocalString(1110676)
    else
        noNoticeStr = LanguageManager:getInstance():getLocalString(1110608)
    end
    local noticeNoText = UI.Text:create()
    noticeNoText:init(noNoticeStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    noticeNoText:setTextHorizontalCenter()
    noticeNoText:setWidth(220)
    noticeNoText:autoAdapt()
    noticeNoText:centerBottom(140 - noticeNoText:getContentSize().height / 2)
    contentLayout:addChild(noticeNoText, 10)
    self._noticeNoText = noticeNoText

    -- 招募按钮
    local inviteButton = UI.Button:create()
    inviteButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    inviteButton:setText(LanguageManager:getInstance():getLocalString(1112988) --[["招募"]])
    inviteButton:setTextFont(UI.FONT_BOLD, 20, {r = 42, g = 41, b = 45})
    inviteButton:centerBottom(4)
    contentLayout:addChild(inviteButton)
    self._inviteButton = inviteButton
    self._inviteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self, obj)
        UI.TipsLayer:createGuildRecruitInput(function(text)

            local func = function(dText)
                require "app.datas.MasterDataManager"
                local roleHeadData = MasterDataManager:getMasterHeadData()
                Net.NetGuildSystem:requestPostRecruitment(dText, roleHeadData)
            end

            local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
            gameWordDetectionManager:getInstance():textDetection(text,func,function()
            end,PublicDefine.ChatChannelType.GUILD)
        end)
    end)
    
    -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
    if SdkManager:responsePolicySwitch() then
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            self._inviteButton:setVisible(false)
        end
    end

    self:refreshGuildNotice()

    self:refreshMainGuildMemberNum()
end

function GuildManagerPanel:layoutTabLabel(str, fixLineWidth, yPos)
    local label = cc.Label:createWithTTF(str, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    label:setTextColor(UI.FONT_COLOR_41_41_45)
    label._enableAutoUpdatePos = false
    label:setFixLineWidth(fixLineWidth)
    label:setAnchorPoint(0, 0.5)
    label:setPosition(20, yPos)
    return label;
end

function GuildManagerPanel:sendAudio()
    if(self.guildData.isOpenJoinAudit ~= self._preSendAudio) then
        self._preSendAudio = self.guildData.isOpenJoinAudit

        Net.NetGuildSystem:modifyJoinAudit(RoleDataManager:getMasterPK(), self.guildData.isOpenJoinAudit)
    end
end

function GuildManagerPanel:sendScoreLmt()
    if(self.guildData.joinEquipScoreLmt ~= self._preJoinEquipScoreLmt) then
        self._preJoinEquipScoreLmt = self.guildData.joinEquipScoreLmt
        Net.NetGuildSystem:modifyJoinEquipScoreLMT(RoleDataManager:getMasterPK(), self.guildData.joinEquipScoreLmt)
    end
end

-- 处理退出公会
function GuildManagerPanel:handleExitGuild()
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    MasterDataManager:setRepeatHandleData(RepeatHandleType.GUILD_EXIT, true)
    
    Net.NetGuildSystem:quitGuild(RoleDataManager:getMasterPK())
    if(self._extGuildButton and tolua.isnull(self._extGuildButton)) then
        self._extGuildButton:disable()
    end

    if(self.guildListTableView and not tolua.isnull(self.guildListTableView)) then 
        self.guildListTableView:reloadData()
    end
end

function GuildManagerPanel:choiceGuildIcon()
    require("app.ui.guild.ChoiceGuildIconPanel")
    -- 处理选择公会图标
    local choiceGuildPanel = UI.ChoiceGuildIconPanel:create()

    local dataList = self:getIconList()
    if(dataList) then
        choiceGuildPanel:init(dataList, function(choiceIconData)
            if(choiceIconData and self and not tolua.isnull(self) and self._icon and not tolua.isnull(self._icon)) then
                -- print("GuildManagerPanel ", choiceIconData.iconID)
                -- dump(choiceIconData)
                if(self.changeWaitingTime <= 0) then
                    self.changeWaitingTime = CHANGE_ICON_TIME
                    self._icon:setSpriteName(choiceIconData.iconSpriteName)
                    Net.NetGuildSystem:modifyGuildIcon(RoleDataManager:getMasterPK(), choiceIconData.iconID)
                else 
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110613))
                end
            end
        end)
        choiceGuildPanel:leftUp(40, 74)
        self._mainGuilInfo:addChild(choiceGuildPanel, 10000)
    end
end

-- 刷新公会图标
function GuildManagerPanel:refreshGuildIcon()
    if(self and not tolua.isnull(self) and self._icon and not tolua.isnull(self._icon)) then
        local dataList = self:getIconList()
        local choiceID = self.guildData:getIconID()
        if(dataList and choiceID) then
            for _,data in pairs(dataList) do 
                if tonumber(choiceID) == tonumber(data.iconID) then
                    self._icon:setSpriteName(data.iconSpriteName)
                end
            end
        end
    end
end

function GuildManagerPanel:getIconList()
    local boughtIconID = self.guildData.boughtIconID
    
    local iconList = ConfigManager:getGuildIconList()
    -- 去掉需要收费的
    local dataList = {}
    for k, v in pairs(iconList) do
        local iconData = clone(v)
        for _,iconID in pairs(boughtIconID) do 
            if tonumber(iconData.iconID) == tonumber(iconID) then
                iconData.iconCost = 0
                break
            end
        end
        table.insert(dataList, iconData)
    end

    return dataList
end

function GuildManagerPanel:clickToEdit()
    -- print("GuildNoticeCell:clickToEdit") 
    if(self._noticeNoText and not tolua.isnull(self._noticeNoText)) then 
        self._noticeNoText:setVisible(false)
    end
end

function GuildManagerPanel:refresName()
    -- body
    if(self._guildNameText and not tolua.isnull(self._guildNameText)) then
        self._guildNameText:setText(self.guildData.name)
    end
end

function GuildManagerPanel:changeTitleNameOver(guildID)
    if self.guildData.ID == guildID then
        UI.ScrollBar:createByText(UI.TEXT_1213868)

        self:sortMemberData()

        self:refreshTableView()
    end
end

-- 刷新申请开关
function GuildManagerPanel:refresAudit()
    if(self._choiceSwitch and not tolua.isnull(self._choiceSwitch)) then
        -- 刷新可用状态
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or
        masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
        ) then
            self._choiceSwitch:enable()
        else
            self._choiceSwitch:disable()
        end

        -- 刷新开关状态
        self._choiceSwitch:setSwitchStatus(self.guildData.isOpenJoinAudit)
    end
end

-- 刷新战力限制
function GuildManagerPanel:refreshScoreLmt()
    if(self._scoreLmtText and not tolua.isnull(self._scoreLmtText)) then
        local nowLmt = self.guildData.joinEquipScoreLmt

        for k, v in pairs(self.equipScore) do 
            if(nowLmt == k-1) then
                if(nowLmt == 0) then
                    self._scoreLmtText:setText(LanguageManager:getInstance():getLocalString(1110608))
                else
                    self._scoreLmtText:setText(v.."+")
                end
            end
        end
    end

    -- 刷新状态
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
        if(self._choiceScoreLeft and not tolua.isnull(self._choiceScoreLeft)) then
            if(self.guildData.joinEquipScoreLmt == 0) then
                self._choiceScoreLeft:disable()
                self._choiceScoreLeft:setVisible(false)
            else
                self._choiceScoreLeft:enable()
                self._choiceScoreLeft:setVisible(true)
            end
        end

        if(self._choiceScoreRight and not tolua.isnull(self._choiceScoreRight)) then
            if(self.guildData.joinEquipScoreLmt >= #self.equipScore-1) then
                self._choiceScoreRight:disable()
                self._choiceScoreRight:setVisible(false)
            else
                self._choiceScoreRight:enable()
                self._choiceScoreRight:setVisible(true)
            end
        end
    else 
        if(self._choiceScoreLeft and not tolua.isnull(self._choiceScoreLeft)) then
            self._choiceScoreLeft:disable()
            self._choiceScoreLeft:setVisible(false)
        end

        if(self._choiceScoreRight and not tolua.isnull(self._choiceScoreRight)) then
            self._choiceScoreRight:disable()
            self._choiceScoreRight:setVisible(false)
        end
    end

    -- if(change) then
    --     -- 添加切换成功的描述文字
    --     local score = tonumber(GameDataManager:getInstance():getGuildEquipScoreForLmt(self.guildData.joinEquipScoreLmt))
    --     UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1110691), score))
    -- end
end

function GuildManagerPanel:refreshGuildLevel()
    if(self._guildLevel and not tolua.isnull(self._guildLevel)) then
        self._guildLevel:setText(self.guildData.techTotalLv)
    end
end

-- 刷新是否有新标志状态
function GuildManagerPanel:refreshHaveJoin()
    if(self._requestJoinReqList) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110692))
        -- 隐藏加载框
        if(self._loading and not tolua.isnull(self._loading)) then 
            self._loading:setVisible(false)
        end
    end
    self._requestJoinReqList = false

    if(self._haveStatus and not tolua.isnull(self._haveStatus)) then
        self._haveStatus:setVisible(self.guildData.hasJoinReq)
    end
    if(self._joinApplyButton and not tolua.isnull(self._joinApplyButton)) then
        self._joinApplyButton:setVisible(self.guildData.hasJoinReq)
    end
    if(self._newApplyStatus and not tolua.isnull(self._newApplyStatus)) then
        self._newApplyStatus:setVisible(self.guildData.hasJoinReq)
    end
end

-- 刷新成员列表
function GuildManagerPanel:refreshMemberList()
    self:refreshMainGuildMemberNum()

    self:refreshGuildNum()
    self:sortMemberData()

    self:refreshTableView()
end

function GuildManagerPanel:refreshInviteButton()
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or 
        masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader
    ) then
        local totalNum = GameDataManager:getInstance():getGuildMemberConfigForLevel(self.guildData.techTotalLv)
        local curNum = self.guildData:getMemberNum()
        if (curNum >= totalNum) then
            self._inviteButton:hide()
        else
            self._inviteButton:show()
        end
    else
        self._inviteButton:hide()
    end

    -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
    if SdkManager:responsePolicySwitch() then
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            self._inviteButton:setVisible(false)
        end
    end
end

function GuildManagerPanel:refreshGuild()
    self:refreshGuildLevel()
    -- self:refreshGuildContib()
    self:refreshGuildTeamMedal()
end

function GuildManagerPanel:refreshTableView(flag)
    if(self._choiceTabIndex == UI.GUILD_MANGER_TYPE.MANAGER) then 
        if(self.guildListManagerTableView and not tolua.isnull(self.guildListManagerTableView)) then 
            if self._playTableCellAct[self._choiceTabIndex] == nil then
                if table.nums(self._playTableCellAct) == 0 then
                    self.guildListManagerTableView:reloadData(true, 0.18, Game.TableCellInitTime, Game.TableCellAddTime)
                else
                    self.guildListManagerTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
                end
                self._playTableCellAct[self._choiceTabIndex] = true
            else
                self.guildListManagerTableView:reloadData()
            end
        end
    else 
        if(self.guildListTableView and not tolua.isnull(self.guildListTableView)) then 
            if self._playTableCellAct[self._choiceTabIndex] == nil then
                if table.nums(self._playTableCellAct) == 0 then
                    self.guildListTableView:reloadData(true, 0.18, Game.TableCellInitTime, Game.TableCellAddTime)
                else
                    self.guildListTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
                end
                self._playTableCellAct[self._choiceTabIndex] = true
            else
                self.guildListTableView:reloadData()
            end
        end
    end
end

-- 
function GuildManagerPanel:reponseJoinList()
    -- 隐藏加载框
    if(self._loading and not tolua.isnull(self._loading)) then 
        self._loading:setVisible(false)
    end

    if(self._joinApplyButton and not tolua.isnull(self._joinApplyButton)) then
        self._joinApplyButton:enable()
        self._joinApplyButton:setVisible(self.guildData.hasJoinReq)
    end

    if(self._requestJoinReqList) then
        -- 处理是否弹出申请列表页面 
        if(#self.guildData.applyJoinList == 0) then 
            -- 申请玩家已加入其他公会，当前没有玩家入会申请
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110692))
        else 
            local applyPanel = UI.JoinApplyManagerPanel:create()
            applyPanel:leftBottom(495, 49)
            self._managerLayout:addChild(applyPanel, 10000)
        end
    end

    self._requestJoinReqList = false
end

-- 退出公会失败
function GuildManagerPanel:exitFails()
    UI.WaitingLayer:hideWaiting()
    if(self._extGuildButton and not tolua.isnull(self._extGuildButton)) then 
        self._extGuildButton:enable()
    end
end 

function GuildManagerPanel:sortMemberData()
    -- 对数据进行排序
    local master = RoleDataManager:getMaster()
    local equipScore = master:getCombatScore()
    local guildEquipScoreConfig =  string.split(ConfigManager:getGuildEquipScore(), ";")
    for k,v in pairs(guildEquipScoreConfig) do 
        guildEquipScoreConfig[k] = tonumber(v)
    end

    -- 是否在线（在线排上面）→职位从高到底→本周贡献度从高到低→离线时长从近到远
    table.sort(self.guildData.members, function(a, b)
        if(a.loginStatus ~= b.loginStatus) then
            if(a.loginStatus == HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE) then
                if self.sortType[SORT_TYPE.LOGIN] == 1 then
                    return true
                else
                    return false
                end
            else
                if self.sortType[SORT_TYPE.LOGIN] == 1 then
                    return false
                else
                    return true
                end
            end
        end

        if(a.title ~= b.title) then
            if(a.title < b.title) then
                if self.sortType[SORT_TYPE.TITLE] == 1 then
                    return true
                else
                    return false
                end
            else
                if self.sortType[SORT_TYPE.TITLE] == 1 then
                    return false
                else
                    return true
                end
            end
        end

        if(a.contib ~= b.contib) then
            if(a.contib > b.contib) then
                if self.sortType[SORT_TYPE.CONTRI] == 1 then
                    return true
                else
                    return false
                end
            else
                if self.sortType[SORT_TYPE.CONTRI] == 1 then
                    return false
                else
                    return true
                end
            end
        end

        if(a.offlineTime ~= b.offlineTime) then
            if(a.offlineTime > b.offlineTime) then
                return true
            else    
                return false
            end
        end

        return false
    end)
end

-- 刷新成员权限
function GuildManagerPanel:refreshMemberTitle()
    self:refreshTabItem()
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()

    if (self._choiceTabIndex == UI.GUILD_MANGER_TYPE.MANAGER and masterTitle == PublicDefine.GuildTitle.GuildTitle_Member) then
        self._functionTabList:activeTab(UI.GUILD_MANGER_TYPE.MAIN_INFO)
    end

    self:sortMemberData()

    self:refreshTableView()

    self:refreshInviteButton()

    self:refresAudit()

    self:refreshScoreLmt()
end

-- 刷新排行名词
function GuildManagerPanel:refreshRankText()
    if(self._rankText and not tolua.isnull(self._rankText)) then 
        local text = ""
        if(self.guildData:getRank() == 0) then
            text = LanguageManager:getInstance():getLocalString(1110620)
        else
            text = tostring(self.guildData:getRank())
        end

        self._rankText:setText(text)
    end
end

-- 刷新公会贡献度
-- function GuildManagerPanel:refreshGuildContib()
--     if(self.guildContibText and not tolua.isnull(self.guildContibText)) then 
--         self.guildContibText:setText(self.guildData.contib.."")
--     end
-- end

-- 更新新公会的公会贡献值
function GuildManagerPanel:refreshGuildTeamMedal()
    if(self.guildContibText and not tolua.isnull(self.guildContibText)) then 
        self.guildContibText:setText(self.guildData.contib.."")
    end
end

function GuildManagerPanel:refreshMainGuildMemberNum()
    local totalNum = GameDataManager:getInstance():getGuildMemberConfigForLevel(self.guildData.techTotalLv)
    if(self._manGuildNumText and not tolua.isnull(self._manGuildNumText)) then
        self._manGuildNumText:setText(string.format( "%d/%d", self.guildData:getMemberNum(), totalNum))
    end
end

function GuildManagerPanel:refreshGuildNum()
    local totalNum = GameDataManager:getInstance():getGuildMemberConfigForLevel(self.guildData.techTotalLv)
    if(self._guildNumText and not tolua.isnull(self._guildNumText)) then
        self._guildNumText:setText(string.format("%d/%d", self.guildData:getMemberNum(), totalNum))
    end
end

-- 刷新公告
function GuildManagerPanel:refreshGuildNotice()
    self:refreshNoticeStatus()
end

-- 刷新表现
function GuildManagerPanel:refreshNoticeStatus()
    if(self._noticeNoText and not tolua.isnull(self._noticeNoText)) then 
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
            if(self.guildData.notice and string.len(self.guildData.notice) > 0) then
                self._noticeNoText:setVisible(false)
            else
                self._noticeNoText:setVisible(true)
            end
        else 
            local inputTex = self.guildData.notice
            if(string.len(inputTex)>0) then
                self._noticeNoText:setVisible(false)
            else    
                self._noticeNoText:setVisible(true)
            end
        end
    end
    if (not tolua.isnull(self._noticeCell)) then
        self._noticeCell:updateDetail()
    end
end

-- 有人先更改, 不应用自己的分数修改
function GuildManagerPanel:scoreLimitEvent()
    self.scoreLmt = -1
    self._preJoinEquipScoreLmt = self.guildData.joinEquipScoreLmt
    self:refreshScoreLmt()
end

-- 有人先更改, 不应用自己的分数修改
function GuildManagerPanel:auditEvent()
    self.audioTime = -1
    self._preSendAudio = self.guildData.isOpenJoinAudit
    self:refresAudit()
end

-- 注册监听事件(可选)
function GuildManagerPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshHaveJoin)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshHaveJoin)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MODIFY_JOIN_AUDIT, self, self.auditEvent)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT, self, self.scoreLimitEvent)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MEMBER_DATE_UPDATE, self, self.refreshMemberList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MEMBER_CHANGE, self, self.refreshMemberList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.exitGuildManager)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MODITY_NOTICE, self, self.refreshGuildNotice)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MODITY_MEMBER_TITILE, self, self.refreshMemberTitle)
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_GUILD_RANK, self, self.refreshRankText)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_CONTIB_CHANGE, self, self.refreshGuildContib)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_INFO_UPDATE, self, self.refreshGuild)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_LOAD_GUILD_END, self, self.refreshGuild)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_MODITY_GUILD_ICON, self, self.refreshGuildIcon)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_JOIN_LIST_CHANGE, self, self.reponseJoinList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_EXIT_FAILS, self, self.exitFails)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_REFRESH_NAME, self, self.refresName)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.changeTitleNameOver)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW, self, self.refreshGuildBoxView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW, self, self.refreshGiantBoxView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.onNewBoxStatusChanged)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOX_LIST, self, self.refreshBoxList)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_CONTIB_CHANGE, self, self.refreshGuildTeamMedal)
    

end

-- 注销监听事件(可选)
function GuildManagerPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshHaveJoin)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshHaveJoin)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MODIFY_JOIN_AUDIT, self, self.auditEvent)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT, self, self.scoreLimitEvent)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MEMBER_DATE_UPDATE, self, self.refreshMemberList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MEMBER_CHANGE, self, self.refreshMemberList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.exitGuildManager)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MODITY_NOTICE, self, self.refreshGuildNotice)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MODITY_MEMBER_TITILE, self, self.refreshMemberTitle)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_GUILD_RANK, self, self.refreshRankText)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_CONTIB_CHANGE, self, self.refreshGuildContib)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_INFO_UPDATE, self, self.refreshGuild)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_LOAD_GUILD_END, self, self.refreshGuild)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_MODITY_GUILD_ICON, self, self.refreshGuildIcon)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_JOIN_LIST_CHANGE, self, self.reponseJoinList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_EXIT_FAILS, self, self.exitFails)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_REFRESH_NAME, self, self.refresName)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.changeTitleNameOver)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOXVIEW, self, self.refreshGuildBoxView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW, self, self.refreshGiantBoxView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.onNewBoxStatusChanged)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_UPDATE_BOX_LIST, self, self.refreshBoxList)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_CONTIB_CHANGE, self, self.refreshGuildTeamMedal)

end


function GuildManagerPanel:numberOfCellsInTableView(table)
    return #self.guildData.members
end


function GuildManagerPanel:scrollViewDidScroll(view)
    local offsetY = view:getContentOffset().y
    -- if offsetY > 0 then
    --     offsetY = 0;
    -- end

    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;
end

function GuildManagerPanel:cellSizeForTable(table,idx)
    return 551,88
end

function GuildManagerPanel:tableCellAtIndex(tableView,idx)
    -- print("GuildManagerPanel:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()      
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.GuildMemberCell:create(self.guildData.members[idx + 1], idx, self._choiceTabIndex)
            pArchiveCell:setName("cell")
            pArchiveCell:leftUp(276, -44)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.guildData.members[idx + 1], idx, self._choiceTabIndex)
        end
    end, 
    function(e) 
        printError("--------------------GuildManagerPanel:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

function GuildManagerPanel:numberOfCellsInTableViewManager(table)
    return #self.guildData.members
end

function GuildManagerPanel:scrollViewDidScrollManager(view)
    local offsetY = view:getContentOffset().y

    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;
end

function GuildManagerPanel:cellSizeForTableManager(table,idx)
    return 840,88
end

function GuildManagerPanel:tableCellAtIndexManager(tableView,idx)
    -- print("GuildManagerPanel:tableCellAtIndexManager",idx,self._choiceTabIndex)
    local cell = tableView:dequeueCell()
    xpcall(function()      
        cell = nil
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.GuildMemberCell:create(self.guildData.members[idx + 1], idx, self._choiceTabIndex, tableView)
            pArchiveCell:setName("cell")
            pArchiveCell:leftUp(420, -44)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.guildData.members[idx + 1], idx, self._choiceTabIndex)
        end
    end, 
    function(e) 
        printError("--------------------GuildManagerPanel:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

function GuildManagerPanel:openShow()
    self:open(self.bg)
end