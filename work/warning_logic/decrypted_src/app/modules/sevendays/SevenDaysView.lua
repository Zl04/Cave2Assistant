------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/08/16
--desc	: 
-- 礼包   9999：是根据web配置的单独一类的活动类型过滤出的相关数据
-- 老玩家回归 5：是根据web配置的单独一类的活动类型过滤出的相关数据
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local SevenDaysView = class("SevenDaysView", UI.HWBtnComponent)

local SdkManager = require "app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
local SceneManager = require("app.game.SceneManager")

require "app.modules.sevendays.SevenDaysTabCell"
require "app.modules.sevendays.SevenDaysSignCell"
require "app.modules.sevendays.SevenDaysOpenCell"
require "app.modules.sevendays.SevenDaysCloseCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_sevendays.plist",
    "ui_package_log_funnyRecord.plist",
    -- "ui_town_catfood.plist",
    "ui_general_shopping.plist",
    "ui_town_guild_giftbox.plist",
}

local COM_WIDTH = 1000
local COM_HEIGHT = 600
local ZOrder = 1
local BTN_CELL_W = 109
local BTN_CELL_H = 68
local SIGN_CELL_W = 196

function SevenDaysView:ctor(types)
    self._planType = types.planType
    self._signInType = types.signInType
    SevenDaysView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._closeCallBack = types.callBack
    self.btnCellArr = {}
    self:bindModel()
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:bind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
    Avalon.MessageCenter:bind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, nil, nil, nil)

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

function SevenDaysView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.sevendays", "SevenDays", false)
    SevenDaysView.super.init(self, ... )
end

function SevenDaysView:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_NEW_DAY, self, self.refreshNewDay)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, self, self.getRewardResp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, self, self.targetPrgUpdate)
    Avalon.MessageCenter:unbind(GameMessage.MC_SDK_PURCHASE_SUCC, self,self.onPaySucc)
    Avalon.MessageCenter:unbind(GameMessage.MC_GET_ORDER_REQ, self,self.getOrder)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    print("SevenDaysView:dtor()")
    if(self._closeCallBack) then 
        self._closeCallBack()
        self._closeCallBack = nil
    end
    self.btnCellArr = {}
    SevenDaysView.super.dtor(self)
    self:unbindModel()
    
    -- reload_script_file_mvc("app.modules.sevendays.SevenDaysView")
    -- reload_script_file("app.modules.sevendays.SevenDaysView")
end

function SevenDaysView:formatData()
    mvc.sevenDaysModel:recalculateStageForGoal(self._signInType)

    self.stageArr = mvc.sevenDaysModel:getStageArr(self._planType)
    self.taskData = mvc.sevenDaysModel:getGoalData(self._planType)
    self.signData = mvc.sevenDaysModel:getGoalData(self._signInType)

    self.openTasks = {}
    self.lockedTasks = {}
    for k, v in ipairs(self.stageArr) do
        if v.isLocked then
            table.insert(self.lockedTasks, v)
        else
            table.insert(self.openTasks, v)
        end
    end
end

function SevenDaysView:onInitView()
    self.curTabIndex = -1
    self.lastTabIndex = 0

    self:formatData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 用户测试刷新
    -- local confirmBtn = UI.Button:create()
    -- confirmBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
    -- confirmBtn:centerUp(47)
    -- confirmBtn:setText(UI.TEXT_111035)
    -- confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     local masterData = RoleDataManager:getMaster()
    --     masterData.refreshDay = masterData.refreshDay + 1
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_REFRESH_NEW_DAY)
    -- end)
    -- contentLayout:addChild(confirmBtn, 10000)


    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_sevendays_bg_1.png");
    bg:centerLeft(-20);
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self._bg = bg

    -- titleImg
    local titleImg  = UI.Image:create();
    titleImg:init("ui_sevendays_title.png");
    titleImg:leftUp(246, 0)
    bg:addChild(titleImg, 10);

    -- titleTxt
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213109, UI.FONT_STANDARD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155)
    titleTxt:center()
    titleImg:addChild(titleTxt)
    self.titleTxt = titleTxt

    -- actTime
    local actTime = UI.Text:create()
    actTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    actTime:centerBottom(-30)
    titleImg:addChild(actTime)
    self.actTime = actTime

    self:initData()
    self:makeTabList()

    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self:initSignPanel()
        self:updateMainPanel()
    end, 0.1)

    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self:addUIEff()
    end, 0.2)

    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self:initTaskPanel()
        self:updateMainPanel()
    end, 0.5)

    self:refreshTitle()
end

function SevenDaysView:initData()
    self.sevenGiftBag = clone(mvc.sevenDaysModel:getSevenGiftBag())
    -- print("SevenDaysView:initData", #self.sevenGiftBag)
    for k,v in ipairs(self.sevenGiftBag) do 
        v.allDone = true
        v.disableMerge = true
    end

    self:handleLanguage()
end

function SevenDaysView:addUIEff()
    -- 左侧蜡烛
    local eff1 = UI.Animation:create()
    eff1:init("effect_ui_town_sevendays_candle.json", "effect_ui_town_sevendays_candle.atlas", 1);
    eff1:leftBottom(12, -5)
    self.contentLayout:addChild(eff1, 100)
    eff1:setAnimation("idle", true)

    -- 右侧笔
    local eff2 = UI.Animation:create()
    eff2:init("effect_ui_town_sevendays_pen.json", "effect_ui_town_sevendays_pen.atlas", 1);
    eff2:rightBottom(60, 0)
    self.contentLayout:addChild(eff2, 100)
    eff2:setAnimation("idle", true)
end

function SevenDaysView:makeTabList()
    -- 如果是web配置就不显示标签, 并且只显示计划
    self.btnData = {}
    if (not mvc.sevenDaysModel:isGoalFromWeb(self._planType)) then
        -- 显示签到
        local tab1 = {}
        tab1.goalIdx = self._signInType
        tab1.name = UI.TEXT_1213105
        tab1.select = true
        tab1.isSignInGoal = true

        -- 显示计划
        local tab2 = {}
        tab2.goalIdx = self._planType
        tab2.name = UI.TEXT_1213106
        tab2.select = false
        tab2.isSignInGoal = false

        table.insert(self.btnData, tab1)
        table.insert(self.btnData, tab2)

        if(self.sevenGiftBag and #self.sevenGiftBag > 0) then 
            -- 礼包
            local tab3 = {}
            tab3.goalIdx = SEVEN_DAY_GIFT
            tab3.name = UI.TEXT_1213118
            tab3.select = false
            tab3.isSignInGoal = false

            table.insert(self.btnData, tab3)
        end
    else
        -- 初始化到计划
        self.curTabIndex = 1
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W+10, 230);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-73, 60)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.SevenDaysTabCell.new();
            cell:init(self.btnData[idx+1]);
        end,
        function(e) 
            printError("------------------------SevenDaysView:tableCellAtIndex-----------------error")
        end, 1);
        self.btnCellArr[idx + 1] = cell
        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        -- 处理self.curTabIndex < 0
        if self.curTabIndex < 0 then
            self.curTabIndex = 0
        end

        if self.curTabIndex == cell:getIdx() then
            return
        end

        self.curTabIndex = cell:getIdx()
        self.btnData[self.curTabIndex+1].select = true
        self._tableView:updateCellAtIndex(self.curTabIndex)

        if self.lastTabIndex >= 0 then
            self.btnData[self.lastTabIndex+1].select = false
            self._tableView:updateCellAtIndex(self.lastTabIndex)
        end

        self.lastTabIndex = self.curTabIndex

        self:updateMainPanel()
        self:refreshTitle()
        if not tolua.isnull(self._detailView) then
            self._detailView:removeSelf()
        end
    end);

    if(GameManager:getIsGooglePlay()) then
        self._tableView:onTableCellHighLight(function(table, cell)
            -- print("onTableCellHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:hightLight()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(self.btnCellArr[endIndex]) then 
                            self.btnCellArr[endIndex]:unHightLight()
                        end
                    end
                end, 1)
            end
        end)

        self._tableView:onTableCellUnHighLight(function(table, cell)
            -- print("onTableCellUnHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:unHightLight()
            end
        end)
    end

    self.contentLayout:addChild(self._tableView, ZOrder);
    ZOrder = ZOrder + 1
    self._tableView:reloadData(true);
end

function SevenDaysView:initSignPanel()
    -- 签到
    local signLayout = UI.Layout:create();
    signLayout:init()
    signLayout:setSize(828, 504)
    signLayout:leftBottom(120, 10)
    self._bg:addChild(signLayout)
    self.signLayout = signLayout

    local rewardLayout = UI.Layout:create();
    rewardLayout:init()
    rewardLayout:setSize(283, 481)
    rewardLayout:leftBottom(-20, 57)
    self.signLayout:addChild(rewardLayout)

    local rewardBg = UI.Image:create()
    rewardBg:init("ui_sevendays_sign_reward_bg.png")
    rewardBg:center()
    rewardLayout:addChild(rewardBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1213120, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
    titleText:setWidth(281)
    titleText:setTextCenter()
    titleText:centerUp(58)
    rewardLayout:addChild(titleText, 100)

    local descText = UI.Text:create()
    descText:init(UI.TEXT_1213115, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
    descText:setWidth(281)
    descText:setTextCenter()
    descText:centerUp(68 +titleText:getContentSize().height)
    rewardLayout:addChild(descText, 100)

    -- 角色 
    local roleAnimation = UI.RoleAnimation:create()
    roleAnimation:init(RoleDataManager:getMaster())
    roleAnimation:centerBottom(101)
    roleAnimation:setScaleX(-1 * roleAnimation:getScaleX())
    rewardLayout:addChild(roleAnimation)
    self.roleAnimation = roleAnimation

    local equipmentDataArr = {}
    for k, v in ipairs(self.signData.finalReward) do
        local equipmentData = GoodsDataManager:createEquipmentForEquipmentID(v.id)
        if(equipmentData) then
            table.insert(equipmentDataArr, equipmentData)
        end
    end
    self.equipmentDataArr = equipmentDataArr
    roleAnimation:updateRoleEquipment(equipmentDataArr)
    self:createSignChoiceEquipType(rewardLayout)

    local roleClickLayout = UI.Layout:create()
    roleClickLayout:init()
    roleClickLayout:setSize(300,460)
    -- roleClickLayout:enableDebugDraw()
    roleClickLayout:centerBottom(25)
    roleClickLayout:setTouchEnable(true)
    roleClickLayout:addEventListener(UIEvent.COMPONENT_CLICK, self.roleAnimation, function()

        if(self.roleAnimation:getRoleRender() and self.roleAnimation:getRoleRender():getHeroAnimation()) then
            self.roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "attack_1_" .. self.roleAnimation._currentWeaponType,
                false
            )
            self.roleAnimation:getRoleRender():getHeroAnimation():addAnimation(
                0,
                "attackidle_" .. self.roleAnimation._currentWeaponType,
                true
            )
        end
    end)
    rewardLayout:addChild(roleClickLayout)


    local confirmBtn = UI.Button:create()
    confirmBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png")
    confirmBtn:centerBottom(47)
    confirmBtn:setText(UI.TEXT_111035)
    confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.isGetSignFinalReward then
            -- 正在领奖
            return
        end
        if self.signData.finalRewardState then
            -- 已经领过奖
            return
        end
        if not self.canGetSignFinalReward then
            UI.ScrollBar:createByText(UI.TEXT_1213102)
            return
        end

        self:getSignFinalReward()
    end)
    confirmBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if self.signData.finalRewardState then
            -- 已经领过奖
            UI.ScrollBar:createByText(UI.TEXT_1110721)
            return
        end
        UI.ScrollBar:createByText(UI.TEXT_1213102)
    end)
    rewardLayout:addChild(confirmBtn)
    self.signConfirmBtn = confirmBtn

    self:initSignList()
    self:updateSignTotalReward()
end

function SevenDaysView:initSignList()
    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:setSize(547, 446)

    scrollContent:leftBottom(297, 56)
    self.signLayout:addChild(scrollContent)

    self.canGetSignFinalReward = mvc.sevenDaysModel:checkCanGetFinalReward(self._signInType)

    local beginOffset = math.floor(SIGN_CELL_W/2)
    if (self.signData.stageArr) then
        local startX = 0
        local onePaddingX = 136
        local onePaddingY = 229

        -- ui_sevendays_paper_sign_bg 添加背景
        local black = UI.Image:create()
        black:init("ui_sevendays_paper_sign_bg.png")
        black:centerUp(0)
        scrollContent:addChild(black)

        local black = UI.Image:create()
        black:init("ui_sevendays_paper_sign_bg.png")
        black:centerBottom(0)
        scrollContent:addChild(black)

        for k, v in ipairs(self.signData.stageArr) do
            -- local 
            -- reload_script_file("app.modules.sevendays.SevenDaysSignCell")
            -- print("stageArrstageArrstageArrstageArr=", v)
            local cell = UI.SevenDaysSignCell:create(self._signInType)
            cell:init(v)
            if(k<=4) then
                cell:leftUp(startX + (k-1)*onePaddingX, 0)
            else
                startX = onePaddingX/2
                cell:leftBottom(startX + (k-5)*onePaddingX, 0)
            end

            scrollContent:addChild(cell)
        end
    end
end

function SevenDaysView:initTaskPanel()
    -- 计划
    local taskLayout = UI.Layout:create();
    taskLayout:init()
    taskLayout:setSize(828, 504)
    taskLayout:leftBottom(120, 10)
    self._bg:addChild(taskLayout)
    self.taskLayout = taskLayout

    local rewardLayout = UI.Layout:create();
    rewardLayout:init()
    rewardLayout:setSize(223, 419)
    rewardLayout:rightUp(0, 0)
    self.taskLayout:addChild(rewardLayout)

    local black = UI.Image:create()
    black:init("ui_sevendays_plan_reward_bg.png")
    black:center()
    rewardLayout:addChild(black)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1213116, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    titleText:setWidth(220)
    titleText:setTextCenter()
    -- titleText:enableDebugDraw()
    titleText:centerUp(25)
    rewardLayout:addChild(titleText)

    local prgText = UI.Text:create()
    prgText:init(UI.TEXT_1213117, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
    prgText:setWidth(220)
    prgText:setTextCenter()
    -- prgText:enableDebugDraw()
    prgText:centerUp(30 + titleText:getContentSize().height)
    rewardLayout:addChild(prgText)

    -- 钢铁加鲁鲁
    local animLayout = UI.Layout:create()
    animLayout:init()
    animLayout:centerBottom(97)
    rewardLayout:addChild(animLayout)

    local petAnimation = Avalon.Animation:create("role_pet_iron_beast01.json", "role_pet_iron_beast01.atlas", 1)
    petAnimation:setAnimation(0, "idle1", true)
    animLayout:addChild(petAnimation)

    -- 领取按钮
    local rewardBtn = UI.Button:create();
    rewardBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    rewardBtn:centerBottom(-24);
    rewardBtn:setText(UI.TEXT_111035)
    rewardBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    rewardBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.isGetTaskFinalReward then
            -- 正在领奖
            return
        end
        if self.taskData.finalRewardState then
            -- 已经领过奖
            return
        end
        if not self.canGetTaskFinalReward then
            UI.ScrollBar:createByText(UI.TEXT_1213101)
            return
        end

        self:getTaskFinalReward()
    end)
    rewardBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if self.taskData.finalRewardState then
            UI.ScrollBar:createByText(UI.TEXT_1110721)
            -- 已经领过奖
            return
        end
        UI.ScrollBar:createByText(UI.TEXT_1213101)
    end)
    rewardLayout:addChild(rewardBtn)
    self.rewardBtn = rewardBtn

    if self.taskData.finalRewardState then
        rewardBtn:disable()
        rewardBtn:setText(UI.TEXT_1110721)
    elseif self.canGetTaskFinalReward then
        rewardBtn:setText(UI.TEXT_111035)
        rewardBtn:enable()
    else
        rewardBtn:disable()
    end

    self:initTaskList()
    self:updateTotalRewardPrg()
end

function SevenDaysView:initTaskList()
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(600, 448)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(0, 0)
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)
    scrollView:setName("taskSV")
    self.taskSV = scrollView
    
    scrollView:addInnerNode(scrollContent)
    self.taskLayout:addChild(scrollView)
    scrollView:scrollToLeft()

    self.canGetTaskFinalReward = mvc.sevenDaysModel:checkCanGetFinalReward(self._planType)

    local totalW = 0
    local cellW1 = 540
    local cellW2 = 196
    local bottomOffset = 230
    local beginOffset = 5
    for k, v in ipairs(self.openTasks) do
        -- reload_script_file("app.modules.sevendays.SevenDaysOpenCell") 
        local cell = UI.SevenDaysOpenCell:create(self._planType)
        cell:init(v)
        cell:leftBottom(beginOffset + cellW1/2, bottomOffset)
        scrollContent:addChild(cell)
        beginOffset = beginOffset+cellW1
        totalW = totalW+cellW1
    end

    beginOffset = beginOffset + cellW2/2
    for k, v in ipairs(self.lockedTasks) do
        -- reload_script_file("app.modules.sevendays.SevenDaysCloseCell") 
        local cell = UI.SevenDaysCloseCell:create(self._planType)
        cell:init(v)
        cell:leftBottom(beginOffset, bottomOffset)
        scrollContent:addChild(cell)
        beginOffset = beginOffset+cellW2
        totalW = totalW+cellW2
    end
    local width = totalW + 10
    if (width < 0) then
        width = 0
    end
    scrollContent:setSize(width, 450)

    local shadow = UI.Image:create()
    shadow:init("ui_sevendays_shade_1.png")
    shadow:leftUp(570, 10)
    -- shadow:enableDebugDraw()
    self.taskLayout:addChild(shadow, 10)
end

function SevenDaysView:initGiftBagPanel()
    -- 礼包
    local giftLayout = UI.Layout:create();
    giftLayout:init()
    giftLayout:setSize(828, 504)
    giftLayout:leftBottom(120, 10)
    self._bg:addChild(giftLayout)
    self.giftLayout = giftLayout

    -- 右上角底板
    local rightUpBg = UI.Image:create()
    rightUpBg:init("ui_sevendays_bg_giftbag.png")
    rightUpBg:leftBottom(0, 0)
    self.giftLayout:addChild(rightUpBg)

    -- 左边人
    local roleLayout = UI.Layout:create();
    roleLayout:init()
    roleLayout:leftBottom(200, 0)
    self.giftLayout:addChild(roleLayout,10)

    local fxNode = Avalon.Animation:create("effect_ui_town_sevendays_nun.json", "effect_ui_town_sevendays_nun.atlas", 1);
    fxNode:setAnimation(0, "idle", true)
    roleLayout:addChild(fxNode)
    
    -- 物品
    local rewardLayout = UI.Layout:create()
    rewardLayout:init()
    rewardLayout:rightBottom(247, 327)
    -- rewardLayout:setSize(100, 100)
    -- rewardLayout:enableDebugDraw()
    rightUpBg:addChild(rewardLayout)
    self.giftRewardLayout = rewardLayout

    local skeketon = "effect_ui_town_sevendays_gift"
    local fxNode = Avalon.Animation:create(skeketon..".json", skeketon..".atlas", 1);
    self.giftRewardLayout:addChild(fxNode)
    self.giftAnimation = fxNode

    local rewardClickLayout = UI.Layout:create()
    rewardClickLayout:init()
    rewardClickLayout:center()
    rewardClickLayout:setSize(260, 260)
    -- rewardClickLayout:enableDebugDraw()
    rewardLayout:addChild(rewardClickLayout)
    rewardClickLayout:setTouchEnable(true)
    rewardClickLayout:addEventListener(UIEvent.COMPONENT_CLICK, rewardClickLayout, function()
         self:onShowDetails(self.giftData)
    end)

    -- 打折信息    
    local saleLayout = UI.Layout:create()
    saleLayout:init()
    saleLayout:rightBottom(118, 205)
    rightUpBg:addChild(saleLayout)

    local saleText = UI.Text:create() --215 160 75
    saleText:init("0%"..UIUtil:lang(1112050), UI.FONT_BOLD, UI.FONT_SIZE_36PX, {r = 215, g = 160, b = 75})
    saleText:rotate(-26)
    saleText:center()
    -- saleText:enableDebugDraw()
    saleLayout:addChild(saleText)
    self.giftSaleText = saleText

    local payBtn = UI.Button:create()
    payBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    payBtn:rightBottom(146, 60)
    payBtn:closeClickScale()
    payBtn:setInterval(1)
    -- payBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- payBtn:setText(UI.TEXT_1212702)
    payBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onPayClick)
    payBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if(self.giftData and self.giftData.specialOfferIndex ~= MasterDataManager:getSpecialOfferIndex()) then
            UI.ScrollBar:createByText(UI.TEXT_1170104)
            return
        end
    end)
    rightUpBg:addChild(payBtn)
    self.giftBtn = payBtn

    -- 价钱排版
    self._priceLayout = UI.Layout:create()
    self._priceLayout:init()
    self._priceLayout:center()
    self._priceLayout:enableAutoHeight()
    self._priceLayout:enableAutoWidth()
    payBtn:addChild(self._priceLayout, 100)

    -- 货币标签
    self._currencyIcon = UI.Image:create();
    self._currencyIcon:init(UIUtil:getMoneyPng())
    self._currencyIcon:floatLeft(0)
    self._priceLayout:addComponent(self._currencyIcon)

    -- 价钱文字
    self._priceLabel = UI.Text:create()
    self._priceLabel:init("",UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._priceLabel:floatLeft(5)
    self._priceLayout:addComponent(self._priceLabel)


    -- 限购信息
    local limitText = UI.Text:create()
    limitText:init(UIUtil:lang(1111561)..": 1", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    limitText:centerBottom(50)
    -- limitText:enableDebugDraw()
    payBtn:addChild(limitText)
    self.limitText = limitText

    self:updateGiftBag()
end

function SevenDaysView:updateGiftBag()
    local giftData = self:getNowSevenGift()
    self.giftData = giftData
    if(giftData) then
        -- print("updateGiftBag", giftData.specialOfferIndex, MasterDataManager:getSpecialOfferIndex())
        if(giftData.specialOfferIndex ~= MasterDataManager:getSpecialOfferIndex()) then 
            self.giftBtn:disable()
            self.limitText:setText(UI.TEXT_1170104)
        else
            self.limitText:setText(UIUtil:lang(1111561)..": 1")
            self.giftBtn:enable()
        end

        local clientData = mvc.sevenDaysModel:getSevenGiftClientConfig(giftData.specialOfferIndex)
        --  print("updateGiftBag  2", giftData.specialOfferIndex, clientData)
        -- self.giftRewardLayout:removeAllChildren()
        if(clientData) then
            if(self.giftAnimation) then
                self.giftAnimation:setAnimation(0, "idle_0"..giftData.specialOfferIndex, true)
            end

            self.giftSaleText:setText(clientData.sale.."%")

            local priceString = SdkManager:getInstance():getPriceStringFromIapID(giftData.iapId)
            local channel = SdkBox:getInstance():getVersionChannel()
            channel = checkint(channel)
            if(priceString) then 
                -- 使用SKU信息
                self._currencyIcon:hide()
                self._priceLabel:setText(priceString)
                self._priceLabel:floatLeft(0)
            else
                self._currencyIcon:show()
                self._priceLabel:floatLeft(5)
                price = UIUtil:getMoneyPriceStr(giftData.price / 100)
                self._priceLabel:setText(tostring(price))
                self._currencyIcon:setSpriteName(UIUtil:getMoneyPng())
            end
            self._priceLayout:updateView()
        end
    else
        self.limitText:setText(UIUtil:lang(1111561)..": 1")
        self.giftBtn:disable()
    end
end

function SevenDaysView:updateMainPanel()
    if self.curTabIndex <= 0 then
        self:updateSignPanel()
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, 1, nil, nil)
        
        local startTime, endTime = mvc.sevenDaysModel:getActDuringTime(self._signInType)
        local showTime = string.format(UI.TEXT_1213099 .. " " .. startTime .. " - " .. endTime)
        self.actTime:setText(showTime)
    elseif self.curTabIndex == 1 then
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, 2, nil, nil)
        self:updateTaskPanel()
        local startTime, endTime = mvc.sevenDaysModel:getActDuringTime(self._planType)
        local showTime = string.format(UI.TEXT_1213099 .. " " .. startTime .. " - " .. endTime)
        self.actTime:setText(showTime)
    elseif self.curTabIndex == 2 then
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenDays, 3, nil, nil)
        self:updateGiftPanel()
        local startTime, endTime = mvc.sevenDaysModel:getActDuringTime(self._planType)
        local showTime = string.format(UI.TEXT_1213099 .. " " .. startTime .. " - " .. endTime)
        self.actTime:setText(showTime)
    end
end

function SevenDaysView:outLayoutAll()
    if self.taskLayout then
        self.taskLayout:leftBottom(120, 1000)
    end
    if self.signLayout then
        self.signLayout:leftBottom(120, 1000)
    end
    if self.giftLayout then
        self.giftLayout:leftBottom(120, 1000)
    end
end

function SevenDaysView:updateSignPanel()
    self:outLayoutAll()
    if self.signLayout then
        self.signLayout:leftBottom(120, 10)
    end
end

function SevenDaysView:updateTaskPanel()
    self:outLayoutAll()
    if self.taskLayout then
        self.taskLayout:leftBottom(120, 10)
    end
end

function SevenDaysView:updateGiftPanel()
    self:outLayoutAll()

    if(self.giftLayout == nil) then 
        self:initGiftBagPanel()
    end
    if self.giftLayout then
        self.giftLayout:leftBottom(120, 10)
    end
end

function SevenDaysView:getSignFinalReward()
    -- 检查背包格数
    local goodsArr = {}
    for k, v in ipairs(self.signData.finalReward) do
        local data = {}
        data.goodsID = v.id
        data.num = v.num
        data.isGolden = true
        table.insert(goodsArr, data)
    end

    -- 背包检查合格, 请求获取奖励; 不合格, 提示
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then
        self.isGetSignFinalReward = true
        Net.NetRoleSystem:requestGoalReward(self.signData.ID, 0, 0)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

-- 获取最终大奖
function SevenDaysView:getTaskFinalReward()
    -- 检查背包格数
    local goodsArr = {}
    for k, v in ipairs(self.taskData.finalReward) do
        local data = {}
        data.goodsID = v.id
        data.num = v.num
        data.isGolden = true
        table.insert(goodsArr, data)
    end

    -- 背包检查合格, 请求获取奖励; 不合格, 提示
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then
        self.isGetTaskFinalReward = true
        Net.NetRoleSystem:requestGoalReward(self.taskData.ID, 0, 0)
    else
        UI.ScrollBar:createByTextID(1170081)
    end
end

function SevenDaysView:getNowSevenGift()
    local giftBagArr = self.sevenGiftBag
    -- print("SevenDaysView:getNowSevenGift", #giftBagArr)
    if(giftBagArr) then 
        local specialOfferIndex = MasterDataManager:getSpecialOfferIndex()
        -- print("SevenDaysView:getNowSevenGift", specialOfferIndex)
        for k, v in ipairs(giftBagArr) do 
            if(v.specialOfferIndex == specialOfferIndex) then 
                return v
            end
        end

        -- 已近卖完获取最后一个
        local specialOfferIndex = specialOfferIndex - 1
        for k, v in ipairs(giftBagArr) do 
            if(v.specialOfferIndex == specialOfferIndex) then 
                return v
            end
        end
    end

    return nil
end

function SevenDaysView:onPaySucc()
    self:updateGiftBag()
end

function SevenDaysView:onPayClick()
    if(self.giftData and self.giftData.specialOfferIndex ~= MasterDataManager:getSpecialOfferIndex()) then
        UI.ScrollBar:createByText(UI.TEXT_1170104)
        return
    end
    -- 处理购买点击
    self:handlePayRequest(self.giftData, 1)
end

function SevenDaysView:onShowDetails(data)
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end
    self._detailView = UI.IapShopBoxDetails:create(nil, false)
    self._detailView:init()
    self._detailView:center()
    self._detailView:refreshData(data)
    if(data.specialOfferIndex ~= MasterDataManager:getSpecialOfferIndex()) then 
        self._detailView:hideAllBtn()
    end

    self._detailView:rightBottom(84,31)
    self._bg:addChild(self._detailView, 1001)

    
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenGift, 1, data.productID, nil)
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_SevenGift,
    --     data.productID,
    --     PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Detail,
    --     PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
end

function SevenDaysView:getRewardResp(data)
    self:formatData()

    if self.isGetSignFinalReward then
        self.isGetSignFinalReward = false

        -- self.signBoxEff:setAnimation("3", false)
        -- self.signBoxEff:addAnimation("4", true)

        self:popRewards(self.signData.finalReward)
    end

    if self.isGetTaskFinalReward then
        self.isGetTaskFinalReward = false

        -- self.taskBoxEff:setAnimation("3", false)
        -- self.taskBoxEff:addAnimation("4", true)

        self:popRewards(self.taskData.finalReward)
    end
    self:checkFinalRewardState()
    self:updateTotalRewardPrg()
    self:updateSignTotalReward()
    self._tableView:reloadData(true)
end

function SevenDaysView:updateTotalRewardPrg()
    if(self.rewardBtn) then
        local confirmBtn = self.rewardBtn
        if self.taskData.finalRewardState then
            confirmBtn:setText(UI.TEXT_1110721)
            confirmBtn:disable()
        elseif self.canGetTaskFinalReward then
            confirmBtn:enable()
        else
            confirmBtn:setText(UI.TEXT_111035)
            confirmBtn:disable()
        end
    end
end

function SevenDaysView:updateSignTotalReward()
    if(self.signConfirmBtn) then
        local confirmBtn = self.signConfirmBtn
        if self.isGetSignFinalReward then
            confirmBtn:disable()
            return
        end
        if self.signData.finalRewardState then
            confirmBtn:disable()
            return
        end
        if not self.canGetSignFinalReward then
            confirmBtn:disable()
            return
        end
        confirmBtn:enable()
    end
end

function SevenDaysView:popRewards(rewards)
    local itemData = {}
    for k, v in pairs(rewards) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.id)
        if(goodData) then
            goodData:setIsNew(false)
            goodData:setNum(v.num)
            table.insert(itemData, goodData)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, nil, nil, nil, true)
end

function SevenDaysView:updateOncePerSecond()
    if(not tolua.isnull(self)) then 
        self:formatData()
        self:checkFinalRewardState()
        self:updateSignTotalReward()

        -- 检查关闭时间
        self:checkTimeAutoClose()
    end
end

-- 根据时间自动关闭
function SevenDaysView:checkTimeAutoClose()
    if (self.taskData.closeTimeStamp) then
        require "app.game.GameManager"
        local timeNow = GameManager:getNormalServerTime()
        if (timeNow > self.taskData.closeTimeStamp) then
            -- self:close()
            mvc.closePanel("SevenDays", "SevenDays")
        end
    end
end

function SevenDaysView:checkFinalRewardState()
    self.canGetSignFinalReward = mvc.sevenDaysModel:checkCanGetFinalReward(self._signInType)
    self.canGetTaskFinalReward = mvc.sevenDaysModel:checkCanGetFinalReward(self._planType)

    if self.canGetSignFinalReward then
        -- self.signBoxEff:setAnimation("2", true)
    end

    if self.canGetTaskFinalReward then
        -- self.taskBoxEff:setAnimation("2", true)
    end
end

function SevenDaysView:targetPrgUpdate()
    -- 签到界面的刷新，留给cell内部自己处理
    -- 这里仅处理七日计划的界面刷新，因为不能通过cell的内部处理
    self:formatData()

    self.taskLayout:removeChildByName("taskSV")
    self:initTaskList()
end

function SevenDaysView:refreshTitle()
    local goal = mvc.sevenDaysModel:getGoalData(self._planType)
    if (goal and goal.isFromWeb and goal.goalNameOverride) then
        self.titleTxt:setFontName(UI.SYS_FONT)
        self.titleTxt:setFontSize(UI.FONT_SIZE_26PX)
        self.titleTxt:setFontColor(UI.FONT_COLOR_155_155_155)
        self.titleTxt:setText(goal.goalNameOverride)
    else
        self.titleTxt:setFontName(UI.FONT_STANDARD)
        self.titleTxt:setFontSize(UI.FONT_SIZE_26PX)
        self.titleTxt:setFontColor(UI.FONT_COLOR_155_155_155)

        local btnData = self.btnData[self.curTabIndex+1]
        local str = UI.TEXT_1213109
        if(btnData and btnData.goalIdx == SEVEN_DAY_GIFT) then 
            str = UI.TEXT_1213119
        end

        self.titleTxt:setText(str)
    end
end

function SevenDaysView:bindModel()

end

function SevenDaysView:unbindModel()

end

function SevenDaysView:createSignChoiceEquipType(rewardLayout)
    self.equipTypeNodeArr = {}
    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.SWORD_SHIELD)
    rewardLayout:addChild(node)
    node:leftBottom(64, -29)
    table.insert(self.equipTypeNodeArr, node)

    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.GREAT_SWORD)
    rewardLayout:addChild(node)
    node:centerBottom(-29)
    table.insert(self.equipTypeNodeArr, node)

    local node = self:createSigneEquipOne(PublicDefine.WEAPON_TYPE.MAGIC_STAFF)
    rewardLayout:addChild(node)
    node:rightBottom(64, -29)
    table.insert(self.equipTypeNodeArr, node)

    -- 默认选中一个
    self:choiceEquipType(PublicDefine.WEAPON_TYPE.SWORD_SHIELD)
end

function SevenDaysView:handleHightLight(equipType, isShow)
    for k, v in ipairs(self.equipTypeNodeArr) do 
        local centerBg = v:getChildByName("weaponChoice")
        local weaponIcon = v:getChildByName("weaponIcon")
        if(v.equipType == equipType) then 
            if(isShow) then
                if(centerBg) then 
                    centerBg:show()
                end
                if(weaponIcon) then 
                    weaponIcon:setSpriteName(string.format("icon-equip_large_21080010_%d.png", v.equipType))
                end
            else
                if(self._choiceEquipType ~= equipType) then
                    if(centerBg) then 
                        centerBg:hide()
                    end
                    if(weaponIcon) then 
                        weaponIcon:setSpriteName(string.format("icon-equip_small1_21080010_%d.png", v.equipType))
                    end
                end
            end
            break
        end
    end
end

function SevenDaysView:choiceEquipType(equipType)
    self._choiceEquipType = equipType
    for k, v in ipairs(self.equipTypeNodeArr) do 
        local centerBg = v:getChildByName("weaponChoice")
        local weaponIcon = v:getChildByName("weaponIcon")
        if(v.equipType == equipType) then 
            if(centerBg) then 
                centerBg:show()
            end
            if(weaponIcon) then 
                weaponIcon:setSpriteName(string.format("icon-equip_large_21080010_%d.png", v.equipType))
            end
        else
            if(centerBg) then 
                centerBg:hide()
            end
            if(weaponIcon) then 
                weaponIcon:setSpriteName(string.format("icon-equip_small1_21080010_%d.png", v.equipType))
            end
        end
    end

    if(self.roleAnimation) then 
        local nowWearArr = {}
        local wearEquipmentArr = self.equipmentDataArr
        if (wearEquipmentArr) then
            for i = 1, #wearEquipmentArr do
                local equipmentData = wearEquipmentArr[i]
                local equipmentType = equipmentData:getEquipmentType()
                if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then 
                    if(equipmentData:getWeaponType() == equipType) then 
                        table.insert(nowWearArr, equipmentData)
                    end
                else
                    table.insert(nowWearArr, equipmentData)
                end
            end
        end

        self.roleAnimation:updateRoleEquipment(nowWearArr)
        if(self.roleAnimation:getRoleRender() and self.roleAnimation:getRoleRender():getHeroAnimation()) then
            self.roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "idle_town_" .. self.roleAnimation._currentWeaponType,
                true
            )
        end
    end
end

function SevenDaysView:createSigneEquipOne(equipType)
    local node = UI.Image:create()
    node:init("ui_sevendays_sign_weapon_0.png")
    node.equipType = equipType
    node:setTouchEnable(true)

    -- 中间表现
    local centerBg = UI.Image:create()
    centerBg:init("ui_sevendays_sign_weapon_1.png")
    centerBg:hide()
    centerBg:setName("weaponChoice")
    centerBg:centerBottom(0)
    node:addChild(centerBg)

    local icon = UI.Image:create()
    icon:init(string.format("icon-equip_small1_21080010_%d.png", equipType))
    icon:show()
    icon:setName("weaponIcon")
    icon:center()
    node:addChild(icon)
    if(GameManager:getIsGooglePlay()) then
        node:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, node, function()
            self:handleHightLight(node.equipType, true)
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if(not tolua.isnull(self)) then
                    self:handleHightLight(node.equipType, false)
                end
            end, 1)
        end)

        node:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, node, function(self_, button, touchPosition)
            if not node:checkTouchPosition(touchPosition) then 
                self:handleHightLight(node.equipType, false)
            end
        end)

        node:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, node, function()
            self:handleHightLight(node.equipType, false)
        end)
    end
    node:addEventListener(UIEvent.COMPONENT_CLICK, node, function()
        self:choiceEquipType(node.equipType)
    end)

    return node
end

function SevenDaysView:handleLanguage()
    self:refreshWebLaunguageCallback({})        

    local curTime = GameManager:getNormalServerTime()
    -- 删除已经下架的 和已经售完 并且标示了隐藏的
    local size = table.nums(self.sevenGiftBag)
    for i= size,1, -1 do
        local item = self.sevenGiftBag[i]
        -- 时间到了下架的
        if (item.endTimeSec > 0 and item.endTimeSec < curTime) then
            print("从本地删除")
            table.remove(self.sevenGiftBag,i)
        end
        
    end
    
    local keyList = {}
    for i,v in ipairs(self.sevenGiftBag) do
        table.insert( keyList, v.nameID )
        table.insert( keyList, v.desID )
    end

    local lans = SdkManager:getInstance():getProductsLan()
    if lans and table.nums(lans) > 0 then
        local hasOneUpdate = false
        for i,v in ipairs(self.sevenGiftBag) do
            local findName = false
            local findDesc = false
            for idx,lan in pairs(lans) do
                if v.nameID == idx then
                    findName = true;
                end
                if v.desID == idx then
                    findDesc = true;
                end
                if findDesc and findName then
                    break;
                end
            end
            if not findDesc or not findName then
                hasOneUpdate = true ;
                break;
            end
        end
        if hasOneUpdate then
            SdkManager:getInstance():loadProductsLan( keyList, handler(self, self.refreshWebLaunguageCallback))
        else
            self:refreshWebLaunguageCallback(lans)
        end
        
    else
        -- dump(keyList)
        -- 获取苹果商店的信息
        SdkManager:getInstance():loadProductsLan(keyList, handler(self, self.refreshWebLaunguageCallback))
    end
end

function SevenDaysView:refreshWebLaunguageCallback(webLaunguageList)
    if not self.sevenGiftBag  then
        return
    end

    local infos = SdkManager:getInstance():getProducts()
    local myChannel = SdkBox:getInstance():getVersionChannel()

    printInfo("SevenDaysView:refreshWebLaunguageCallback, myChannel",myChannel)

    for i,v in ipairs(self.sevenGiftBag) do
        v.name = ""
        v.desc = ""
        v.iapId = ""
        for idx,lan in pairs(webLaunguageList) do
            if v.nameID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.name = str
            end
            if v.desID == idx then
                local p = json.decode(lan)
                local str = ""
                if(p) then
                    for i,v in ipairs(p) do
                        str = str .. v.text
                    end
                end
                v.desc = str
            end
        end
        for i,idAndChannel in ipairs(v.IAPList) do
            if checkint(idAndChannel.channelID) == myChannel then
                -- table.insert( iaps, idAndChannel.iapId)  

                v.iapId = idAndChannel.iapId
                break;      
            end
        end
    end

    UI.WaitingLayer:showWaiting(true, nil, 0)

    self:onGetLocalization()
end

function SevenDaysView:onGetLocalization()
    
    for i, d in ipairs(self.sevenGiftBag ) do
		-- 默认货币符号
		d.symbol = self:getCurrencySymbol()
	end
    
    -- self._loading:setVisible(false)
    UI.WaitingLayer:hideWaiting()
end

-- 获取货币符号
function SevenDaysView:getCurrencySymbol()
    local symbol = "￥"
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        symbol = "$"
    end
	return symbol
end

function SevenDaysView:getOrder(data,count)
    if not tolua.isnull(self._detailView) then
        self._detailView:removeSelf()
    end

    self:handlePayRequest(data, count)
end

function SevenDaysView:handlePayRequest(data, count)
    printInfo("SevenDaysView:getOrder")
    if data.currencyType == PublicDefine.PurchaseCurrencyType.PurchaseCurrencyType_Diamond then
        if not Avalon.MathUtil:checkDiamonEnough(count * data.price, GameDataManager:getInstance():getDiamond()) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170045))
            return;
        end
        
    end
    
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_TREASURE then
            printError("can not get order of box in other scene")
            return
        end
    end
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    SdkManager:getInstance():getOrder(data, count, 0)
    if data.label == PublicDefine.PURCHASE_PRODUCT_TYPE.SpecialOfferPack then
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_SevenGift, 2, data.productID, nil)
        -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_SevenGift,
        -- data.productID,
        -- PublicDefine.WebLogType_IapShop_PageOp_Type.WebLogType_IapShop_PageOp_Type_Buy,
        -- PublicDefine.WebLogType_IapShop_Page_Type.WebLogType_IapShop_Page_Type_Box,0)
    end
end

function SevenDaysView:refreshNewDay()
    if(self._tableView) then
        self._tableView:reloadData(true)
    end
end

return SevenDaysView
