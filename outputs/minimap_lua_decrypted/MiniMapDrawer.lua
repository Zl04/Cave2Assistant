--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-07-10 22:27:06
]]

require "app.ui.UIDefine"

UI = UI or {}
local MiniMapDrawer = class("MiniMapDrawer", UI.HWBtnComponent)
UI.MiniMapDrawer = MiniMapDrawer

local SceneManager = require("app.game.SceneManager")

local COM_RES_LIST = {
    -- "ui_town_maincity.plist",
}

local COMPONENT_WIDTH = 90
local COMPONENT_HEIGHT = 67
local EXPAND_BOTTON_LEFT_SHRUNK = -30
local EXPAND_BOTTON_LEFT_EXPANDED = -30

function MiniMapDrawer:ctor()
    MiniMapDrawer.super.ctor(
        self, 603,
        COM_RES_LIST,
        COMPONENT_WIDTH,
        COMPONENT_HEIGHT
    )
    self:init()
end

-- 析构
function MiniMapDrawer:dtor()
    MiniMapDrawer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function MiniMapDrawer:init()
    self._isExpanded = SETTING_OPEN_MINIMAP_DRAWER == nil and true or false
    MiniMapDrawer.super.init(self)
    self:registerListener()

    self._sortTagTable = {}
    local orderString = ConfigManager:getGeneralForKey("miniMapWeight")
    local orderStringArr = orderString:split(";")
    for i,v in ipairs(orderStringArr) do
        local orderEntry = v:split(",")
        self._sortTagTable[orderEntry[1]] = orderEntry[2]
    end
end


-- 模版函数：初始化组建的视图
function MiniMapDrawer:onInitView()
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:centerRight(0)
    self._rootLayer:setSize(COMPONENT_WIDTH, COMPONENT_HEIGHT)
    self:addChild(self._rootLayer)

    -- self._leftBg = UI.Image:create()
    -- self._leftBg:init("ui_minimap_drawer_1.png")
    -- self._leftBg:centerLeft(0)
    -- self._rootLayer:addChild(self._leftBg)

    -- 抽屉打开按钮
    self._expandBtn = UI.Button:create()
    self._expandBtn:init("ui_btn_arrow_up_0.png", "ui_btn_arrow_up_1.png", "ui_btn_arrow_up_2.png")
    self._expandBtn:centerLeft(-40)
    self._rootLayer:addChild(self._expandBtn, 10)
    self._expandBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self._isExpanded = self._isExpanded == nil and false or not self._isExpanded -- 第一次为空的时候设置为false, 否则相反
        SETTING_OPEN_MINIMAP_DRAWER = self._isExpanded
        self:setExpand(self._isExpanded)
    end)
    self._expandBtn:setScale(0.75)
    
    -- 抽屉按钮红点
    self._expandBtnRedPoint = AvalonUtil.createRedPoint(self._expandBtn, 0, 0)
    self._expandBtnRedPoint:hide()
    self._expandBtnRedPoint:setScale(1.3)

    -- -- 抽屉内容背景
    -- self._contentBg = UI.Image9:create()
    -- self._contentBg:init("ui_minimap_drawer_2.png", CCRectMake(0,0,1,1), cc.size(0, 0))
    -- self._contentBg:centerLeft(self._leftBg:getContentSize().width)
    -- self._rootLayer:addChild(self._contentBg)

    -- 按钮排版
    self._contentLayout = UI.Layout:create()
    self._contentLayout:init(0, -19, 0, 0)
    self._contentLayout:enableAutoWidth()
    self._contentLayout:enableAutoHeight()
    self._contentLayout:centerLeft(6)
    self:addChild(self._contentLayout)

    -- 纪念品
    self._souvenirBtn, self._souvenirBtnBg, self._souvenirRedPoint = self:createNormalBtn("ui_maincity_btn2_souvenir.png", "ui_maincity_btn2_souvenir_selected.png", nil, nil, nil, function()
        mvc.openPanel("Souvenir", "Souvenir")
    end)
    self._souvenirBtnBg.__sortTag = "souvenir"
    self._souvenirBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._souvenirBtnBg)


    -- 老玩家回归
    self._playerReturnBtn, self._playerReturnBtnBg, self._playerReturnRedPoint = self:createNormalBtn("ui_information_button_back_0.png", "ui_information_button_back_1.png", nil, nil, nil, function()
        -- Avalon.MessageCenter:notice(GameMessage.MC_SHOW_SEVEN_DAY)
        mvc.openPanel("SevenDays", "SevenDays", {planType = SEVEN_DAY_OLDBACK})
    end)
    self._playerReturnBtnBg.__sortTag = "guide"
    self._playerReturnBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._playerReturnBtnBg)

    -- 七日目标
    self._sevenDayGoalInfoBtn, self._sevenDayGoalInfoBtnBg, self._sevenDayGoalInfoRedPoint = self:createNormalBtn("ui_information_7day.png", "ui_information_7day.png", nil, nil, nil, function()
        -- Avalon.MessageCenter:notice(GameMessage.MC_SHOW_SEVEN_DAY)
        mvc.openPanel("SevenDays", "SevenDays", {planType = SEVEN_DAY_TASK, signInType = SEVEN_DAY_SIGN})
        -- mvc.openPanel("FestivalSign", "FestivalSign", {planType = FALL_FESTIVAL_TASK , signInType = FALL_FESTIVAL_SIGN})
    end)
    self._sevenDayGoalInfoBtnBg.__sortTag = "guide"
    self._sevenDayGoalInfoBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._sevenDayGoalInfoBtnBg)

    -- 双节签到
    self._festivalGoalInfoBtn, self._festivalGoalInfoBtnBg, self._festivalGoalInfoRedPoint = self:createNormalBtn("ui_maincity_btn_welfare.png", "ui_maincity_btn_welfare_selected.png", nil, nil, nil, function()
        mvc.openPanel("FestivalSign", "FestivalSign", {planType = FALL_FESTIVAL_TASK , signInType = FALL_FESTIVAL_SIGN})
        -- mvc.openPanel("FestivalSign", "FestivalSign", {signInType = ANNIVERSARY_SIGN})
    end)
    self._festivalGoalInfoBtnBg.__sortTag = "guide"
    self._festivalGoalInfoBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._festivalGoalInfoBtnBg)

    -- 周年签到
    self._anniversaryGoalInfoBtn, self._anniversaryGoalInfoBtnBg, self._anniversaryGoalInfoRedPoint = self:createNormalBtn("ui_maincity_btn_welfare.png", "ui_maincity_btn_welfare_selected.png", nil, nil, nil, function()
        -- Avalon.MessageCenter:notice(GameMessage.MC_SHOW_SEVEN_DAY)
        -- mvc.openPanel("SevenDays", "SevenDays", {planType = SEVEN_DAY_TASK, signInType = SEVEN_DAY_SIGN})
        mvc.openPanel("FestivalSign", "FestivalSign", {signInType = ANNIVERSARY_SIGN})
    end)
    self._anniversaryGoalInfoBtnBg.__sortTag = "guide"
    self._anniversaryGoalInfoBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._anniversaryGoalInfoBtnBg)

    -- 等级礼包
    self._levelBagInfoBtn, self._levelBagInfoBtnBg, self._levelBagInfoRedPoint = self:createNormalBtn("ui_information_button_levelbag_0.png", "ui_information_button_levelbag_1.png", nil, nil, nil, function()
        local GameDataManager = require("app.game.GameDataManager")
        if(GameDataManager:getInstance():getFreePacketBoxNum() > 0) then 
            Net.NetGoodsSystem:requestChooseGoodsGet()
        else
            local LanguageManager = require("app.game.LanguageManager")
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))
        end
    end)
    self._levelBagInfoBtnBg.__sortTag = "levelbag"
    self._levelBagInfoBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._levelBagInfoBtnBg)

    -- 大转盘（已纳入缤纷活动）
    -- self._luckLotteryInfoBtn, self._luckLotteryInfoBtnBg, self._luckLotteryInfoRedPoint = self:createNormalBtn("ui_information_button_lottery_0.png", "ui_information_button_lottery_1.png", nil, nil, nil, function()
    --     mvc.openPanel("ActivityLottery", "ActivityLottery")
    -- end)
    -- self._luckLotteryInfoBtnBg.__sortTag = "lottery"
    -- self._luckLotteryInfoBtnBg:floatRight(19)
    -- self._contentLayout:addComponent(self._luckLotteryInfoBtnBg)

    -- 缤纷活动
    self._tradeActivityBtn, self._tradeActivityBtnBg, self._tradeActivityRedPoint = self:createNormalBtn("ui_maincity_btn2_business.png", "ui_maincity_btn2_business_selected.png", nil, nil, nil, function()
        mvc.openPanel("TradeActivity", "TradeActivityMain")
    end)
    self._tradeActivityBtnBg.__sortTag = "tradeactivity"
    self._tradeActivityBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._tradeActivityBtnBg)

    -- 水晶夺宝
    if (not SceneManager:getInstance():isInStory() and mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature)) then
        self._tradeActivityCrystalBtn, self._tradeActivityCrystalBtnBg, self._tradeActivityCrystalRedPoint = self:createNormalBtn("ui_maincity_btn_treasure.png", "ui_maincity_btn_treasure_selected.png", nil, nil, nil, function()
            mvc.openPanel("TradeActivity", "TradeActivityCrystalCapture")
        end)
        self._tradeActivityCrystalBtnBg.__sortTag = "tradeactivity"
        self._tradeActivityCrystalBtnBg:floatRight(19)
        self._contentLayout:addComponent(self._tradeActivityCrystalBtnBg)
    end

    -- 经验副本
    self._tradeActivityExpBtn, self._tradeActivityExpBg, self._tradeActivityExpPoint = self:createNormalBtn("ui_maincity_btn_expdungeon.png", "ui_maincity_btn_expdungeon_selected.png", nil, nil, nil, function()
        -- 经验副本
        mvc.openPanel("DungeonExpFight", "DungeonExpFight")
    end)
    self._tradeActivityExpBg.__sortTag = "tradeactivity"
    self._tradeActivityExpBg:floatRight(19)
    self._contentLayout:addComponent(self._tradeActivityExpBg)
    
    -- 大航海
    self._tradeActivityBigSailBtn, self._tradeActivityBigSailBtnBg, self._tradeActivityBigSailRedPoint = self:createNormalBtn("ui_maincity_btn_navigation.png", "ui_maincity_btn_navigation_selected.png", nil, nil, nil, function()
        -- 判断是否在公会中
        local GameDataManager = require("app.game.GameDataManager")
        if GameDataManager:getInstance():getIsJoinGuild() then
            if SceneManager:getInstance():isInTownRelated() then
                Net.NetBigSailSystem:reqEnterBigSailScene(RoleDataManager:getMasterPK())
            else
                -- UI.ScrollBar:createByText(UI.TEXT_228500)
            end
        else
            UI.ScrollBar:createByText(UI.TEXT_226173)
        end
    end)
    self._tradeActivityBigSailBtnBg.__sortTag = "tradeactivity"
    self._tradeActivityBigSailBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._tradeActivityBigSailBtnBg)


    -- 首充礼包
    self._firstPayBtn, self._firstPayBtnBg, self._firstPayRedPoint = self:createNormalBtn("ui_maincity_btn2_gift.png", "ui_maincity_btn2_gift_selected.png", nil, nil, nil, function()
        mvc.openPanel("TradeActivity", "TradeActivityFirstPay")
    end)
    self._firstPayBtnBg.__sortTag = "firstpay"
    self._firstPayBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._firstPayBtnBg)

    -- 英雄模式事件信息
    self._specialEventInfoBtn, self._specialEventInfoBtnBg, self._specialEventInfoRedPoint = self:createNormalBtn("ui_information_button_event_0.png", "ui_information_button_event_1.png", nil, function()
        local posX, posY = self._specialEventInfoBtnBg:getPosition()
        local worldPos = self._contentLayout:convertToWorldSpace(cc.p(posX, posY))
        local targetPos = self._rootLayer:convertToNodeSpace(worldPos)
        local targetRight = self._rootLayer._width - targetPos.x + 20
        local targetTop = 57
        self:setShowHeroEventTips(true, targetRight, targetTop)
    end, function() 
        self:setShowHeroEventTips(false)
    end)
    self._specialEventInfoBtnBg.__sortTag = "event"
    self._specialEventInfoBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._specialEventInfoBtnBg)

    if mvc.sFSignModel:getOpenSFSign() then
        -- 春节签到
        self._SFSignBtn, self._SFSignBtnBg, self._SFSignRedPoint = self:createNormalBtn("ui_information_button_festivalsign_0.png", "ui_information_button_festivalsign_1.png", nil, nil, nil, function()
            if SceneManager:getInstance():isInFightScene() then
                UI.ScrollBar:createByText(UI.TEXT_1213854)
                return
            end

            mvc.openPanel("SFSign", "SFSign")
        end)
        self._SFSignBtnBg.__sortTag = "sfsign"
        self._SFSignBtnBg:floatRight(19)
        self._contentLayout:addComponent(self._SFSignBtnBg)
    end

    -- if mvc.festivalModel:getLostRealmStatus() then
        -- lostrealm
        self._lostRealmBtn, self._lostRealmBtnBg, self._lostRealmRedPoint = self:createNormalBtn("ui_maincity_btn2_monopoly.png", "ui_maincity_btn2_monopoly_selected.png", nil, nil, nil, function()
            local curTabActData = mvc.festivalModel:getLostRealmFestivalData()
            
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            local spriteID = 0
            if(machine) then
                local model = machine:getModel()
                if(model) then 
                    local enterModelArr = model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
                    if(enterModelArr and #enterModelArr > 0) then 
                        spriteID = enterModelArr[1]:getSpriteID()
                    end
                end
            end

            Net.NetRoleSystem:heroEnterCaveSceneRequest(
            PublicDefine.GAME_MODE.MODE_SOLO,
            PublicDefine.CAVE_MODE.MODE_ACT,
            PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
            PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID,
            spriteID, false, curTabActData.activityID)
        end)
        self._lostRealmBtnBg.__sortTag = "lostRealm"
        self._lostRealmBtnBg:floatRight(19)
        self._contentLayout:addComponent(self._lostRealmBtnBg)
    -- end

    --返场活动
    self._comebackActivityBtn, self._comebackActivityBtnBg, self._comebackActivityRedPoint = self:createNormalBtn("ui_maincity_btn2_limitedtimestore.png", "ui_maincity_btn2_limitedtimestore_selected.png", nil, nil, nil, function()
        mvc.openPanel("ComebackPackage", "ComebackPackage")
    end)
    self._comebackActivityBtnBg.__sortTag = "comebackactivity"
    self._comebackActivityBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._comebackActivityBtnBg)


    -- 邮件
    self._mailBtn, self._mailBtnBg, self._mailRedPoint = self:createNormalBtn("ui_information_button_letter_0.png", "ui_information_button_letter_1.png", nil, nil, nil, function()
        self:openFunction(PublicDefine.FUNCTION_TYPE.MAILBOX)
    end)
    self._mailBtnBg.__sortTag = "letter"
    self._mailBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._mailBtnBg)

    -- 月度签到
    self._monthlySignBtn, self._monthlySignBtnBg, self._monthlySignRedPoint = self:createNormalBtn("ui_maincity_btn2_everyday.png", "ui_maincity_btn2_everyday_selected.png", nil, nil, nil, function()
        mvc.openPanel("MonthlySign", "MonthlySign")
    end)
    self._monthlySignBtnBg.__sortTag = "sfsign"
    self._monthlySignBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._monthlySignBtnBg)

    -- 周年庆预约
    self._appointmentBtn, self._appointmentBtnBg, self._appointmentRedPoint = self:createNormalBtn("ui_maincity_btn2_reserve.png", "ui_maincity_btn2_reserve_selected.png", nil, nil, nil, function()
        mvc.send("AnniversaryAppointment_Open_Main_View")
    end)
    self._appointmentBtnBg.__sortTag = "sfsign"
    self._appointmentBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._appointmentBtnBg)

    -- 活动副本:试炼之地
    self._trialLandBtn, self._trialLandBtnBg, self._trialLandRedPoint = self:createNormalBtn("ui_maincity_btn2_trial.png", "ui_maincity_btn2_trial_selected.png", nil, nil, nil, function()
        mvc.send("ActivityModeCave_Request_Cave_Data")
    end)
    self._trialLandBtnBg.__sortTag = "sfsign"
    self._trialLandBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._trialLandBtnBg)

    -- 周年庆抽奖
    self._annivesaryLotteryBtn, self._annivesaryLotteryBtnBg, self._annivesaryLotteryRedPoint = self:createNormalBtn("ui_maincity_btn2_lottery.png", "ui_maincity_btn2_lottery_selected.png", nil, nil, nil, function()
        mvc.send("ActivityAnnivesary_Open_Main_View")
    end)
    self._annivesaryLotteryBtnBg.__sortTag = "sfsign"
    self._annivesaryLotteryBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._annivesaryLotteryBtnBg)

    -- taptap跳转
    self._tapLinkBtn, self._tapLinkBtnBg, self._tapLinkRedPoint = self:createNormalBtn("ui_maincity_btn_tap.png", "ui_maincity_btn_tap_selected.png", nil, nil, nil, function()
        local tNoticeList = ImageDownLoadUtil:getTapTNoticeInfo()
        if next(tNoticeList) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, tNoticeList) 
        end
    end)
    self._tapLinkBtnBg.__sortTag = "sfsign"
    self._tapLinkBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._tapLinkBtnBg)

    -- 洞窟探宝
    self._caveExploringBtn, self._caveExploringBtnBg, self._caveExploringRedPoint = self:createNormalBtn("ui_maincity_btn_cavetreasure.png", "ui_maincity_btn_cavetreasure_selected.png", nil, nil, nil, function()
        mvc.openPanel("CaveExploring", "CaveExploring")
    end)
    self._caveExploringBtnBg.__sortTag = "sfsign"
    self._caveExploringBtnBg:floatRight(19)
    self._contentLayout:addComponent(self._caveExploringBtnBg)
end

-- 模版函数：更新组建的视图
function MiniMapDrawer:onUpdateView()
    local SceneManager = require("app.game.SceneManager")
    local buttonBgToShow = {}

    -- 老玩家回归
    if (mvc.sevenDaysModel:isOpenGoal(SEVEN_DAY_OLDBACK) and MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_HeroTarget)) then
        self._playerReturnBtnBg:show()
        table.insert(buttonBgToShow, self._playerReturnBtnBg)
        local taskFinStat = mvc.sevenDaysModel:getFinishStat(SEVEN_DAY_OLDBACK)
        local taskFinal = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_OLDBACK)
        if (taskFinStat or taskFinal) then
            self._playerReturnRedPoint:show()
        else
            self._playerReturnRedPoint:hide()
        end
    else
        self._playerReturnBtnBg:hide()
    end

    -- 七日目标
    if (mvc.sevenDaysModel:isOpenGoal(SEVEN_DAY_TASK)) then
        self._sevenDayGoalInfoBtnBg:show()
        table.insert(buttonBgToShow, self._sevenDayGoalInfoBtnBg)
        local signFinStat = mvc.sevenDaysModel:getSignFinishStateForGoal(SEVEN_DAY_SIGN)
        local signFinal = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_SIGN)
        local taskFinStat = mvc.sevenDaysModel:getFinishStat(SEVEN_DAY_TASK)
        local taskFinal = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_TASK)
        local giftBagReward = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_GIFT)
        if (signFinStat or signFinal or taskFinStat or taskFinal or giftBagReward) then
            self._sevenDayGoalInfoRedPoint:show()
        else
            self._sevenDayGoalInfoRedPoint:hide()
        end
    else
        self._sevenDayGoalInfoBtnBg:hide()
    end

    -- 双节签到
    if (mvc.festivalSignModel:isOpenGoal(FALL_FESTIVAL_TASK)) then
        self._festivalGoalInfoBtnBg:show()
        table.insert(buttonBgToShow, self._festivalGoalInfoBtnBg)
        local signFinStat = mvc.festivalSignModel:getSignFinishStateForGoal(FALL_FESTIVAL_SIGN)
        local signFinal = mvc.festivalSignModel:checkCanGetFinalReward(FALL_FESTIVAL_SIGN)
        local taskFinStat = mvc.festivalSignModel:getFinishStat(FALL_FESTIVAL_TASK)
        -- local taskFinal = mvc.festivalSignModel:checkCanGetFinalReward(SEVEN_DAY_TASK)
        -- local giftBagReward = mvc.festivalSignModel:checkCanGetFinalReward(SEVEN_DAY_GIFT)
        if (signFinStat or signFinal or taskFinStat) then
            self._festivalGoalInfoRedPoint:show()
        else
            self._festivalGoalInfoRedPoint:hide()
        end
    else
        self._festivalGoalInfoBtnBg:hide()
    end

    -- 月度签到
    if (mvc.monthlySignModel:isShowMonthlySignBtn()) then
        self._monthlySignBtnBg:show()
        table.insert(buttonBgToShow, self._monthlySignBtnBg)
        if (mvc.monthlySignModel:isShowMonthlySignRedPoint()) then
            self._monthlySignRedPoint:show()
        else
            self._monthlySignRedPoint:hide()
        end
    else
        self._monthlySignBtnBg:hide()
    end

    -- 周年庆预约
    if (mvc.anniversaryAppointmentModel:getActivityIsShow()) then
        self._appointmentBtnBg:show()
        table.insert(buttonBgToShow, self._appointmentBtnBg)
        if (mvc.anniversaryAppointmentModel:isShowRedPoint()) then
            self._appointmentRedPoint:show()
        else
            self._appointmentRedPoint:hide()
        end
    else
        self._appointmentBtnBg:hide()
    end

    -- 试炼之地
    if (mvc.activityModeCaveModel:getActivityIsOpening()) then
        self._trialLandBtnBg:show()
        table.insert(buttonBgToShow, self._trialLandBtnBg)
        if (mvc.activityModeCaveModel:isShowRedPoint()) then
            self._trialLandRedPoint:show()
        else
            self._trialLandRedPoint:hide()
        end
    else
        self._trialLandBtnBg:hide()
    end

    -- 周年庆抽奖
    if (mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowBtn()) then
        self._annivesaryLotteryBtnBg:show()
        table.insert(buttonBgToShow, self._annivesaryLotteryBtnBg)
        if (mvc.activityAnnivesaryLotteryModel:isShowRedPoint()) then
            self._annivesaryLotteryRedPoint:show()
        else
            self._annivesaryLotteryRedPoint:hide()
        end
    else
        self._annivesaryLotteryBtnBg:hide()
    end
    

    -- 周年签到
    if (mvc.festivalSignModel:isOpenGoal(ANNIVERSARY_SIGN)) then
        self._anniversaryGoalInfoBtnBg:show()
        table.insert(buttonBgToShow, self._anniversaryGoalInfoBtnBg)
        local signFinStat = mvc.festivalSignModel:getSignFinishStateForGoal(ANNIVERSARY_SIGN)
        if (signFinStat) then
            self._anniversaryGoalInfoRedPoint:show()
        else
            self._anniversaryGoalInfoRedPoint:hide()
        end
    else
        self._anniversaryGoalInfoBtnBg:hide()
    end

    --纪念品
    if (RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Souvenir)
        and not isInActivityCave ) then
        self._souvenirBtnBg:show()
        table.insert(buttonBgToShow, self._souvenirBtnBg)
        if mvc.souvenirModel:isShowRedPoint() then
            self._souvenirRedPoint:show()
        else
            self._souvenirRedPoint:hide()
        end
    else
        self._souvenirBtnBg:hide()
    end

    -- 洞窟探险
    if (true) then
        self._caveExploringBtnBg:show()
        table.insert(buttonBgToShow, self._caveExploringBtnBg)
        if (false) then
            self._caveExploringRedPoint:show()
        else
            self._caveExploringRedPoint:hide()
        end
    else
        self._caveExploringBtnBg:hide()
    end

    -- 缤纷活动
    if (mvc.tradeActivityModel:getTradeActivityBtnRedPointIsShow()) then
        self._tradeActivityRedPoint:show()
    else
        self._tradeActivityRedPoint:hide()
    end

    -- 特惠礼包（首充）
    if (mvc.tradeActivityModel:getTabRedPointIsShow(PublicDefine.TradeActivityIDList.TradeActivityFirstPay)) then
        self._firstPayRedPoint:show()
    else
        self._firstPayRedPoint:hide()
    end

    -- taptap跳转
    if (ImageDownLoadUtil:getTapTapBtnIsShow()) then
        self._tapLinkBtnBg:show()
        table.insert(buttonBgToShow, self._tapLinkBtnBg)
        if (false) then
            self._tapLinkRedPoint:show()
        else
            self._tapLinkRedPoint:hide()
        end
    else
        self._tapLinkBtnBg:hide()
    end

    -- 大航海
    if (mvc.bigSailPortModel:getPortBtnIsSHow()) then
        self._tradeActivityBigSailBtnBg:show()
        table.insert(buttonBgToShow, self._tradeActivityBigSailBtnBg)
        -- if (mvc.activityAnnivesaryLotteryModel:isShowRedPoint()) then
        --     self._annivesaryLotteryRedPoint:show()
        -- else
        --     self._annivesaryLotteryRedPoint:hide()
        -- end
    else
        self._tradeActivityBigSailBtnBg:hide()
    end

    -- 经验副本
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Exp) and (not SceneManager:getInstance():isInExp()) then
        self._tradeActivityExpBg:show()
        table.insert(buttonBgToShow, self._tradeActivityExpBg)
    else
        self._tradeActivityExpBg:hide()
    end


    -- 特殊活动(英雄模式事件)
    if (SceneManager:getInstance():isInHero()) then
        local GameMapManager = require("app.game.GameMapManager")
        local mapdData = GameMapManager:getInstance():getMapData()
        self._specialEventInfoBtnBg:hide()
        if(mapdData) then 
            local schemeIDS = mapdData:getHeroCaveSchemeIDS()
            if(schemeIDS and #schemeIDS > 0) then 
                self._specialEventInfoBtnBg:show()
                table.insert(buttonBgToShow, self._specialEventInfoBtnBg)
            else
                self._specialEventInfoBtnBg:hide()
            end 
        else
            self._specialEventInfoBtnBg:hide()
        end
    elseif SceneManager:getInstance():isInTitanHero() then
        local GameMapManager = require("app.game.GameMapManager")
        local mapdData = GameMapManager:getInstance():getMapData()
        self._specialEventInfoBtnBg:hide()
        if(mapdData) then 
            local schemeIDS = mapdData:getHeroCaveSchemeIDS()
            if(schemeIDS and #schemeIDS > 0) then 
                self._specialEventInfoBtnBg:show()
                table.insert(buttonBgToShow, self._specialEventInfoBtnBg)
            else
                self._specialEventInfoBtnBg:hide()
            end 
        else
            self._specialEventInfoBtnBg:hide()
        end
    else
        self._specialEventInfoBtnBg:hide()
    end

    -- 等级礼包领取
    if(not SceneManager:getInstance():isInFightScene()) then
        local checkGoodsID = tonumber(ConfigManager:getGeneralForKey("levelbag"))
        local cfg = Config.ConfigGoods:getChooseBagById(checkGoodsID)
        if(cfg) then 
            local haveNum = MasterDataManager:getGoodsUseNum(checkGoodsID)
            if(haveNum < cfg.rewardNum) then 
                self._levelBagInfoBtnBg:show()
                table.insert(buttonBgToShow, self._levelBagInfoBtnBg)
            else
                self._levelBagInfoBtnBg:hide()
            end
        else
            self._levelBagInfoBtnBg:hide()
        end
    else 
        self._levelBagInfoBtnBg:hide()
    end

    -- 幸运转盘（已纳入缤纷活动）
    -- if (SceneManager:getInstance():isInTown()) then
    --     local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    --     if activityData and activityData:getLotteryData():getLevelLimit() <= RoleDataManager:getMaster():getLevel() then   
    --         self._luckLotteryInfoBtnBg:show()
    --         table.insert(buttonBgToShow, self._luckLotteryInfoBtnBg)
    --     else
    --         self._luckLotteryInfoBtnBg:hide()
    --     end
    -- else
    --     self._luckLotteryInfoBtnBg:hide()
    -- end

    -- 水晶夺宝
    if (not SceneManager:getInstance():isInStory() and mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature)) then
        self._tradeActivityCrystalBtn:show()
        self._tradeActivityCrystalRedPoint:show()
        table.insert(buttonBgToShow, self._tradeActivityCrystalBtn)
    end

    -- 缤纷活动
    if (not SceneManager:getInstance():isInStory() and table.nums(mvc.tradeActivityModel:getOpenTradeActivityIdList()) > 0) then
        self._tradeActivityBtnBg:show()
        table.insert(buttonBgToShow, self._tradeActivityBtnBg)
    else
        self._tradeActivityBtnBg:hide()
    end

    -- 首充礼包
    if (SceneManager:getInstance():isNotInFightScene()) 
        and mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay) then
            self._firstPayBtnBg:show()
            table.insert(buttonBgToShow, self._firstPayBtnBg)
    else
        self._firstPayBtnBg:hide()
    end

    -- 邮件
    self._mailBtnBg:show()
    table.insert(buttonBgToShow, self._mailBtnBg)
    local unReadList = Game.MailManager:getInstance():getUnReadMailList()
    if #unReadList > 0 then   
        self._mailRedPoint:show()
    else
        self._mailRedPoint:hide()
    end

    if mvc.sFSignModel:getOpenSFSign() then
        -- 春节签到
        self._SFSignBtnBg:show()
        table.insert(buttonBgToShow, self._SFSignBtnBg)
        
        if mvc.sFSignModel:canSign() then
            self._SFSignRedPoint:show()
        else
            self._SFSignRedPoint:hide()
        end
    end

    if mvc.festivalModel:getLostRealmStatus() then
        -- 
        self._lostRealmBtnBg:show()
        table.insert(buttonBgToShow, self._lostRealmBtnBg)
        
        if mvc.festivalModel:getLostRealmResPointStatus() then
            self._lostRealmRedPoint:show()
        else
            self._lostRealmRedPoint:hide()
        end
    else
        self._lostRealmBtnBg:hide()
    end

    
    if mvc.comebackPackageModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityComeback) then
        local iapDatas = mvc.comebackPackageModel:getPackageData()
        if table.nums(iapDatas) > 0 then
            self._comebackActivityBtnBg:show()
        else 
            self._comebackActivityBtnBg:hide()
        end
    else
        self._comebackActivityBtnBg:hide()
    end

    -- 根据展开状态排列和展示按钮
    local numBtnToShow = #buttonBgToShow
    if (numBtnToShow > 1) then
        -- 根据配置排序
        table.sort(buttonBgToShow, function(a, b)
            if (a.__sortTag and not b.__sortTag) then
                return true
            elseif (not a.__sortTag and b.__sortTag) then
                return false
            end
            local orderA = self._sortTagTable[a.__sortTag]
            local orderB = self._sortTagTable[b.__sortTag]
            return orderA < orderB
        end)

        -- 按钮显示, 判断展开状态
        if (not self._isExpanded) then
            -- 隐藏除了第一个之外的所有按钮
            local isRedPointShown = false
            for i=numBtnToShow,2,-1 do
                -- 隐藏按钮
                local button = buttonBgToShow[i]
                button:hide()

                -- 检查红点
                local infoBtn = button:getChildByName("infoBtn")
                if (not isRedPointShown and infoBtn) then
                    local redPoint = infoBtn:getChildByName("redPoint")
                    if (redPoint and redPoint:isVisible()) then
                        isRedPointShown = true
                    end
                end
            end

            -- 缩进一点点展开按钮
            self._expandBtn:rotate(-90)
            self._expandBtnRedPoint:setVisible(isRedPointShown)
        else
            self._expandBtn:rotate(90)
            self._expandBtnRedPoint:setVisible(false)
            for k, v in ipairs(buttonBgToShow) do
                v:show()
            end
        end
    else
        -- 隐藏展开按钮
        self:setShowExpandButton(false)
    end

    -- 更新自己大小
    self._contentLayout:updateView()
    local width = self._contentLayout:getContentSize().width
    width = width <= 0 and width or width

    self:setSize(width + 110, self:getContentSize().height)
    self._rootLayer:setSize(self:getSize())
    -- self._contentBg:setSize(self._rootLayer:getSize() - self._leftBg:getContentSize().width, self:getContentSize().height)
end

function MiniMapDrawer:refreshInfoBtn()
    self:updateView()
end

-- 注册监听事件
function MiniMapDrawer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_MINI_MAP_REFRESH_SPECIAL_EVENT, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshInfoBtn) 
end

-- 注销监听事件
function MiniMapDrawer:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_MINI_MAP_REFRESH_SPECIAL_EVENT, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshInfoBtn) 
end

-- 创建按钮
function MiniMapDrawer:createNormalBtn(spriteNormalName, spriteActiveName, spriteDisableName, touchCallback, releaseCallback, clickCallBack, disableClickCallback)
    -- 按钮背景
    local btnBg = UI.Layout:create()
    btnBg:init()
    btnBg:setSize(50, 67)
    -- 按钮
    local infoBtn = UI.Button:create()
    infoBtn:init(spriteNormalName, spriteActiveName, spriteDisableName)
    if (touchCallback) then
        infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, touchCallback)
    end
    if (releaseCallback) then
        infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, releaseCallback)
    end
    if(clickCallBack) then
        infoBtn:addEventListener(UIEvent.BUTTON_CLICK, self, clickCallBack)
    end
    if (disableClickCallback) then
        infoBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, disableClickCallback)
    end
    infoBtn:setTouchClipNode(self._contentLayout)
    infoBtn:center()
    infoBtn:setName("infoBtn")
    btnBg:addChild(infoBtn)

    -- 红点
    local redPoint = AvalonUtil.createRedPoint(infoBtn, 0, 5)
    redPoint:hide()

    return infoBtn, btnBg, redPoint
end

-- 设置显示扩展按钮
function MiniMapDrawer:setShowExpandButton(b)
    -- self._contentBg:setVisible(b)
    -- self._leftBg:setVisible(b)
    self._expandBtn:setVisible(b)
    self._expandBtn:setTouchEnable(b)
end

-- 设置扩展
function MiniMapDrawer:setExpand(b)
    if (b) then
        self._isExpanded = true
    else
        self._isExpanded = false
    end
    self:updateView()
end

-- 显示英雄模式事件提示框
function MiniMapDrawer:setShowHeroEventTips(b, x, y)
    -- 先清空之前的提示框
    if (self._infoNode) then 
        self._infoNode:removeFromParent()
        self._infoNode = nil
    end
    if (not b) then return end
    x = x or 0
    y = y or 0
    local width = 200

    -- 提示框排版
    self._infoNode = UI.Layout:create()
    self._infoNode:init()
    self._infoNode:setSize(width, 50)
    self._infoNode:setName("SHOW_TIP")
    self._infoNode:rightUp(x, y)
    self._rootLayer:addChild(self._infoNode)

    -- 提示框背景
    local infoNodeBg = UI.Image9:create()
    infoNodeBg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
    infoNodeBg:leftBottom(0, 0)
    self._infoNode:addChild(infoNodeBg)

    -- 提示框背景尖尖
    local infoNodeBgArrow = UI.Image:create()
    infoNodeBgArrow:init("ui_information_banner_background4.png")
    infoNodeBgArrow:rightUp(0, -4)
    infoNodeBg:addChild(infoNodeBgArrow)

    -- 提示框标题
    local up = 5
    local LanguageManager = require("app.game.LanguageManager")
    local text = LanguageManager:getInstance():getLocalString(1111340)
    local title = UI.Text:create()
    title:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
    title:setTextLeft()
    title:setWidth(width - 20)
    title:setSize(width - 20, title:getContentSize().height)
    title:leftUp(10, up)
    self._infoNode:addChild(title)
    up = up + title:getContentSize().height + 5

    -- 检查特殊事件数据
    local GameMapManager = require("app.game.GameMapManager")
    local mapdData = GameMapManager:getInstance():getMapData()
    if(mapdData) then 
        local schemeIDS = mapdData:getHeroCaveSchemeIDS()
        if(schemeIDS) then 
            for _,schemeID in ipairs(schemeIDS) do 
                local data = ConfigManager:getSpecialEventDataById(schemeID)
                if(data) then                     
                    local text = string.format("%s：%s", LanguageManager:getInstance():getLocalString(data.name), LanguageManager:getInstance():getLocalString(data.description))
                    local cell = self:createOneCell(text, false, width)
                    self._infoNode:addChild(cell)
                    cell:leftUp(0, up)
                    up = up + cell:getContentSize().height + 5
                end
            end
        end
    end 
    local height = up + 5
    self._infoNode:setSize(width, height)
    infoNodeBg:setSize(width, height)
end

function MiniMapDrawer:createOneCell(content, isRich, width)
    local textWidth = width - 20
    local layoutWidth = width

    local success = false
    local text = nil
    local cell = nil
    if isRich then
        text = UI.RichText:create()
        success = text:init(content, textWidth, UI.FONT_SIZE_14PX)
    elseif content ~= "" then
        success = true
        text = UI.Text:create()
        text:init(content, UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
        text:setTextLeft()
        text:setWidth(textWidth)
        text:autoAdapt()
        text:centerLeft(26)
    end
    if success then
        cell = UI.Layout:create()
        cell:init()    
        cell:setSize(layoutWidth, text:getContentSize().height)
        cell:addChild(text)
        
        local picDes = UI.Image:create()
        picDes:init("ui_checkpoint_banner_diamond.png")
        picDes:leftUp(12, 4)
        cell:addChild(picDes, 10)
    end
    return cell
end

function MiniMapDrawer:openFunction(functionType)
    if (functionType == PublicDefine.FUNCTION_TYPE.TASK) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
    elseif (functionType == PublicDefine.FUNCTION_TYPE.ACTIVITY) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_ACTIVITY_PANEL, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
    elseif (functionType == PublicDefine.FUNCTION_TYPE.MAILBOX) then
        Avalon.MessageCenter:notice(GameMessage.MC_TASK_SHOW_MAILLAYER, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
    else
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local isActivateFuncSucc = machine:openUIByFunctionType(functionType)
    end
end