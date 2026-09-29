------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityCrystalCaptureView = class("TradeActivityCrystalCaptureView", UI.HWBtnComponent)
local SceneManager = require("app.game.SceneManager")
local SdkBox = require("utils.sdkbox.SdkBox")
require "app.modules.tradeactivity.tradeActivityCommon.TradeLotteryItem"
-- 资源
local COM_RES_LIST = {
    "ui_town_businessactivities_turntable.plist",
    "ui_town_daily.plist",
    "ui_town_businessactivities_treasure.plist",
    "ui_welfare_monthly_sign.plist",
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

local maxNum = 50000

local TURN_STATUS = {
    BEGIN = 1,-- 开始阶段  可以点击按钮开始的状态
    ACCELERATE = 2, --加速阶段
    CONSTANT_SPEED = 3,  --匀速阶段
    TWICE_DECELERATE = 4,   --减速节点
    DECELERATE = 5,   --减速节点
    END = 6,    --结束 展示中奖、奖励界面
}

local clickBtnCostNumTop = 1 -- 上方按钮，转动次数
local clickBtnCostNumBottom = 10 -- 下方按钮，转动次数
local rotateMaxShowNum = 5 -- 转动时，显示的最大格子数

--速度相关的单位 全是 每秒跳动的格子数量
local INIT_SPEED = 10 --初始化速度
local ACE_SPEED = 16  --加速度
local MAX_SPEED  = 20 --最大速度
local TIME_OUT = 15 --转盘请求超时15秒 153, 332
local posList = {
                -- 外圈
                {10, 357 - 8}, {94, 357 - 8}, {178, 357 - 8}, {600, 357 - 8},{684, 357 - 8}, {768, 357 - 8}, 
                {768, 272 - 8}, {768, 187 - 8},{768, 102 - 8}, 
                {768, 17 - 8}, {684, 17 - 8}, {600, 17 - 8},{178, 17 - 8},{94, 17 - 8},{10, 17 - 8},
                {10, 102 - 8},{10, 187 - 8},{10, 272 - 8},
                -- 内圈,140 为内圈圆半径
                {-36 + 140 * 0, -39 + 140 * 1},    {-36 + 140 * 0.707, -39 + 140 * 0.707},       {-36 + 140 * 1, -39 + 140 * 0},    {-36 + 140 * 0.707, -39 + 140 * (-0.707)},
                {-36 + 140 * 0, -39 + 140 * (-1)}, {-36 + 140 * (-0.707), -39 + 140 * (-0.707)}, {-36 + 140 * (-1), -39 + 140 * 0}, {-36 + 140 * (-0.707), -39 + 140 * 0.707}
                }
local outsideNum = 18 -- 外圈最大标识下标
local insideNum = 26 -- 内圈最大标识下标

function TradeActivityCrystalCaptureView:ctor()
    TradeActivityCrystalCaptureView.super.ctor(
    	self,
    	UI.Type.CRYSTAL_CAPTURE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.itemList = {}
    self.innerTrains = {} 
    self.outTrains = {}
    self.rewardAct = {}
    self._stageIcons = {}
    self.index = 1
    self.changeTime = 0
    self.speed = INIT_SPEED
    self.aceSpeed = ACE_SPEED
    self.deSpeed = 0 -- 每秒跳动增加的格子 
    self.remainDis = 0
    self.bingoIndex = 0
    self.tIndex = 0
    self.bingoRollId = nil
    self:setTurnStatus(TURN_STATUS.BEGIN)

    --self.crystalCostNum = 1
    -- 获取每转一次需要消耗的材料和数量。
    local crystalLootConsumption = ConfigManager:getCrystalLootConsumption()
    local crystalConfig = string.split(crystalLootConsumption, ";")[1]
    self.crystalCostNum = tonumber((string.split(crystalConfig, ","))[2])
    self.beginRotateIndex = 1
    self.isInsideTrack = false -- 起始转动是否在内圈开始
    self.preIndex = 1 -- 在外圈每次转动记录转动到的位置
    self.isChange = false -- 本次是否是内外圈切换
    self.isInsideTrack = (RoleDataManager:getMaster():getCrystalTreasureHuntLuckDraw() > 0)

    --- 测试
    -- self.index = 19
    --self.isInsideTrack = true -- 起始转动是否在内圈开始
    -- self.preIndex = 1 -- 在外圈每次转动记录转动到的位置
    --print("isInsideTrack-->: ", RoleDataManager:getMaster():getCrystalTreasureHuntLuckDraw())
    --self.isInsideTrack = (RoleDataManager:getMaster():getCrystalTreasureHuntLuckDraw() > 0)

    if self.isInsideTrack then
        self.index = 19
    end

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function TradeActivityCrystalCaptureView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityCrystalCaptureView.super.init(self, ... )
end

function TradeActivityCrystalCaptureView:dtor()
    TradeActivityCrystalCaptureView.super.dtor(self)
    self:unbindModel()
    self:setTurnStatus(TURN_STATUS.BEGIN)

    if self.bgHost then
        self.bgHost:removeFromParent()
    end

    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    --reload_script_file_mvc("app.modules.tradeactivity.TradeActivityCrystalCaptureView")
end


function TradeActivityCrystalCaptureView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerImg  = UI.Image:create()
    innerImg:init("ui_treasure_bg.png")
    innerImg:center(100, 50)
    contentLayout:addChild(innerImg,2)
    local bg = innerImg
    self.bg = innerImg

    local innerImg2  = UI.Image:create()
    innerImg2:init("ui_treasure_title.png")
    innerImg2:center(120, -168)
    contentLayout:addChild(innerImg2,11)

    -- 外圈中奖赛道图片
    local outWinningImg  = UI.Image:create()
    outWinningImg:init("ui_treasure_paper_1.png")
    outWinningImg:center(120, 100)
    contentLayout:addChild(outWinningImg, 2)
    self.outWinningImg = outWinningImg

    -- 内圈中奖赛道图片
    local innerWinningImg  = UI.Image:create()
    innerWinningImg:init("ui_treasure_paper_up.png")
    innerWinningImg:center(120, 100)
    contentLayout:addChild(innerWinningImg, 3)
    innerWinningImg:setVisible(false)
    self.innerWinningImg = innerWinningImg
    if self.isInsideTrack then
        -- 开始进入有内圈奖励
        innerWinningImg:setVisible(true)
    end

    -- 内圈中奖彩带
    local innerColourBarImg  = UI.Image:create()
    innerColourBarImg:init("ui_treasure_lamprack.png")
    innerColourBarImg:center(120, 100)
    contentLayout:addChild(innerColourBarImg, 3)

    -- 内圈相应动画
    local innerAnimation = UI.Animation:create()
    innerAnimation:init("effect_ui_crystal_treasure_neiquan.json", "effect_ui_crystal_treasure_neiquan.atlas", 1);
    innerAnimation:center(120, 92)
    self.contentLayout:addChild(innerAnimation, 10)
    innerAnimation:setAnimation("idle2", true)
    self.innerAnimation = innerAnimation

    -- 创建中奖图标
    local list = ConfigManager:getAllCrystalTreasureData()
    self:createItems(list)

    self:initAnimation()

    -- local light = UI.Animation:create()
    -- light:init("effect_ui_package_return_gift.json", "effect_ui_package_return_gift.atlas", 1);
    -- light:leftBottom(30, 480)
    -- bg:addChild(light,10)
    -- light:setAnimation("idle", true)
    -- self.light = light

    -- 活动时间
    local tradeActivityConfig = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature)
    -- 根据配置决定开启和关闭时间
    local startDate = GameManager:getClientDateByConfigTimeStr(tradeActivityConfig.startTime, "%Y.%m.%d")
    local endDate = GameManager:getClientDateByConfigTimeStr(tradeActivityConfig.endTime, "%Y.%m.%d")
    local dateStr = string.format(UI.TEXT_1324530, startDate, endDate)
    local activityTimeTitle = UI.Text:create()
    activityTimeTitle:init(dateStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 215, g = 211, b = 207})
    activityTimeTitle:leftBottom(-250, -18)
    innerImg2:addChild(activityTimeTitle, 2)

    -- 水晶夺宝标题UI.TEXT_224600
    local crystalTitle = UI.Text:create()
    crystalTitle:init(UI.TEXT_224600, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 215, g = 211, b = 207})
    crystalTitle:leftBottom(88, 25)
    crystalTitle:useDefaultShadowOnlyStype(cc.c4b(73, 59, 121, 255))
    innerImg2:addChild(crystalTitle, 2)

    -- 弹珠
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:leftBottom(685, 475)
    bg:addChild(diamondImage)

    -- 弹珠数量
    self._diamond = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_213_19, 10)
    self._diamond:setTextLeft()
    self._diamond:leftBottom(710, 475)
    bg:addChild(self._diamond, 4)

    -- 钻石按钮
    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- GLOBAL特殊处理调整标签页1
        local target = SdkBox:getInstance():getVersionTarget()
        local platform = SdkBox:getInstance():getVersionPlatform()
        if target == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 1, self.parentWin,
                PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_CurrencyPanel)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 2, self.parentWin,
                PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_CurrencyPanel)
        end
    end)
    shopButton:leftBottom(800, 475)
    bg:addChild(shopButton)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
        shopButton:show()
    else
        shopButton:hide()
    end

    --抽取1次按钮
    local oneTimesBtn = UI.Button:create()
    oneTimesBtn:init("ui_treasure_btn.png", "ui_treasure_btn.png", "ui_treasure_btn.png")
    oneTimesBtn:center(-210, 300)
    bg:addChild(oneTimesBtn, 10)
    oneTimesBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        if not mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) then
            UI.ScrollBar:createByText(UI.TEXT_223207)
            return
        end

        self:turnClick(true)
    end)
    oneTimesBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1170105)
    end)
    self.oneTimeBtn = oneTimesBtn

    local oneCostNode = UI.Layout:create()
    oneCostNode:init()
    oneCostNode:setSize(28, 28)
    oneCostNode:leftBottom(10, 5)
    oneTimesBtn:addChild(oneCostNode, 10)
    self.oneCostNode = oneCostNode

    local oneCostIcon = UI.Image:create()
    oneCostIcon:init("symbol_gaming_diamond.png")
    oneCostIcon:center(15,-5)
    oneCostNode:addChild(oneCostIcon, 10)
    self.oneCostIcon = oneCostIcon

    local oneCostNumber = UI.Text:create()
    oneCostNumber:init(tostring(self.crystalCostNum * clickBtnCostNumTop), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    oneCostNumber:leftBottom(55,10)
    oneTimesBtn:addChild(oneCostNumber, 10)
    self.oneCostNumber = oneCostNumber

    --抽取次数文字
    local oneText = UI.Text:create()
    oneText:init(string.format(UI.TEXT_1212437, 1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    oneText:center(37, 0)
    oneTimesBtn:addChild(oneText, 10)
    self.oneText = oneText

    --抽取10次按钮
    local moreTimeBtn = UI.Button:create()
    moreTimeBtn:init("ui_treasure_btn.png", "ui_treasure_btn.png", "ui_treasure_btn.png")
    moreTimeBtn:center(-180 + 440, 300)
    bg:addChild(moreTimeBtn)
    moreTimeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        if not mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) then
            UI.ScrollBar:createByText(UI.TEXT_223207)
            return
        end

        self:turnClick(false)
    end)
    moreTimeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1170105)
    end)
    self.moreTimeBtn = moreTimeBtn

    local moreCostNode = UI.Layout:create()
    moreCostNode:init()
    moreCostNode:setSize(28, 28)
    moreCostNode:leftBottom(10, 5)
    moreTimeBtn:addChild(moreCostNode, 10)
    self.moreCostNode = moreCostNode

    local moreCostIcon = UI.Image:create()
    moreCostIcon:init("symbol_gaming_diamond.png")
    moreCostIcon:center(15,-5)
    moreCostNode:addChild(moreCostIcon, 10)
    self.moreCostIcon = moreCostIcon

    local moreCostNumber = UI.Text:create()
    moreCostNumber:init(tostring(self.crystalCostNum * clickBtnCostNumBottom), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    moreCostNumber:leftBottom(55,10)
    moreTimeBtn:addChild(moreCostNumber, 10)
    self.moreCostNumber = moreCostNumber

    local moreText = UI.Text:create()
    moreText:init(string.format(UI.TEXT_1212437, 10), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    moreText:center(35, 0)
    moreTimeBtn:addChild(moreText, 10)
    self.moreText = moreText

    -- local luckBtnBack2 = UI.Image:create()
    -- luckBtnBack2:init("ui_turntable_treasure.png")
    -- luckBtnBack2:center(0, 0)
    -- self.innerAnimation:addChild(luckBtnBack2)

    local luckBtn = UI.Button:create()
    luckBtn:init("ui_treasure_btn_2.png", "ui_treasure_btn_2.png", "ui_treasure_btn_2.png")
    luckBtn:center(0, 65)
    luckBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 39, g = 39, b = 45})
    luckBtn:setText(UI.TEXT_1328003)
    self.innerAnimation:addChild(luckBtn)
    luckBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        --打开水晶夺宝商店界面
        self:openCrystalCaptureShop()
    end)
    self.luckBtn = luckBtn
    --luckBtn:setOpacity(0)

    local luckAnimation = UI.Animation:create()
    luckAnimation:init("effect_ui_businessactivities_baoxiang.json", "effect_ui_businessactivities_baoxiang.atlas", 1)
    luckAnimation:setAnimation("idle1",true)
    luckAnimation:rightBottom(280 + 50, 136 + 53)
    --bg:addChild(luckAnimation)


    -- self:refreshView()

    self:addTouchEvents()

    -- 进度条
    self._progressBar = UI.ProgressTimer:create()
    self._progressBar:init("ui_treasure_progressbarbg.png", "ui_treasure_progressbar.png", "ui_treasure_progressbar.png")
    self._progressBar:leftBottom(950, -30)

    -- 从下往上开始，x轴不变
    self._progressBar:setBarChangeRate(cc.p(0, 1))

    bg:addChild(self._progressBar)

    -- 活跃度
    self._activityPointText = UI.Text:create()
    self._activityPointText:init("60", UI.FONT_BOLD, UI.FONT_SIZE_25PX, {r = 242,  g = 195,  b = 84})
    self._activityPointText:center(0, 233)
    --self._activityPointText:leftBottom(12, 8)
    self._progressBar:addChild(self._activityPointText, 9)

    -- 解析阶段点数
    local stageConfigStrArrs = ConfigManager:getAllStageRewards()
    local stagePointArr = {}
    for i,v in pairs(stageConfigStrArrs) do
        table.insert(stagePointArr, tonumber(v.drawTimes))
    end

    ------- test --------------
    --self.testProgress = 3
    ------- test --------------

    -- local iconConfigs = {}
    -- for i=1,#stagePointArr do
    --     table.insert(iconConfigs, {num = stagePointArr[i] or i *10, x = 0, y = -10})
    -- end

    -- self._stageIcons = {}
    -- self._stageBgs = {}
    -- self._stageStars = {}
    -- self._stageNewBgs = {}
    -- local startX = -360
    -- local progressLength = 725
    -- local progressHeight = 521
    -- local oneWidth = progressLength/ #iconConfigs
    -- local oneHeight = progressHeight/ #iconConfigs
    -- local maxNum = stagePointArr[(#iconConfigs)]
    -- local startY = 300
    -- for i=1,#iconConfigs do
    --     local stageConfig = iconConfigs[i]
    --     --local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", i), string.format("ui_daily_box_%s_2.png", i), stageConfig.num, stageConfig.x, stageConfig.y, i)
    --     -- local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", 3), string.format("ui_daily_box_%s_2.png", 3), stageConfig.num, stageConfig.x, stageConfig.y, i)
    --     --stageBg:center((startX + oneWidth * i), startY)
    --     --stageBg:center(58, startY - progressHeight * (stageConfig.num / maxNum))
    --     --self._progressBar:addChild(stageBg, 10)
    --     -- table.insert(self._stageIcons, stageIcon)
    --     -- table.insert(self._stageBgs, stageBg)
    --     -- table.insert(self._stageStars, stageStar)
    --     -- table.insert(self._stageNewBgs, stageNewbg)
    -- end

    -- 进度条粒子动画
    local progressAni =  UI.Animation:create()
    progressAni:init("effect_ui_crystal_treasure_lizi.json", "effect_ui_crystal_treasure_lizi.atlas", 1);
    progressAni:center(0, 260)
    progressAni:setAnimation("idle", true)
    self.progressAni = progressAni
    self.progressAni:setVisible(false)
    self._progressBar:addChild(progressAni, 10)

    -- 关闭活动按钮
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_treasure_close.png", "ui_treasure_close.png", "ui_treasure_close.png")
    closeBtn:leftBottom(900, 510)
    bg:addChild(closeBtn)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("TradeActivity", "TradeActivityCrystalCapture")
    end)
    self.closeBtn = closeBtn
    self:refreshTrack()

    ----------------
    self:initStageTableList()

    self:refreshView()
end

function TradeActivityCrystalCaptureView:initStageTableList()
    local stageConfigStrArrs = ConfigManager:getAllStageRewards()
    --print("stagePointArr--->: ",  stageConfigStrArrs)
    self._CellList = {}
    local RES_LIST = {}
    self._tableView = UI.TableView.new(RES_LIST, 150, 100 * 5)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:init()
    self._tableView:leftBottom(-15, 20)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:setScrollBarEnabled(true)
    self._tableView:onUpdateCellSize(function (table,idx)
        return 150, 100 * (#stageConfigStrArrs);
    end)
    
    self._tableView:onUpdateCells(function (tableView, idx)
        local cell = tableView:dequeueCell();
        if(cell == nil) then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:init()

                -- 解析阶段点数
                local stagePointArr = {}
                for i,v in pairs(stageConfigStrArrs) do
                    table.insert(stagePointArr, tonumber(v.drawTimes))
                end

                local iconConfigs = {}
                for i=1,#stagePointArr do
                    table.insert(iconConfigs, {num = stagePointArr[i], x = 0, y = -10})
                end

                self._stageIcons = {}
                self._stageBgs = {}
                self._stageStars = {}
                self._stageNewBgs = {}
                local startX = -360
                local progressLength = 725
                local progressHeight = 521
                local oneWidth = progressLength/ #iconConfigs
                local oneHeight = progressHeight/ #iconConfigs
                local maxNum = stagePointArr[(#iconConfigs)]
                local startY = 60
                for i=1,#iconConfigs do
                    local stageConfig = iconConfigs[i]

                    local picIndex = i
                    if i > 5 then
                        picIndex = 5
                    end
                    local strPic = string.format("ui_daily_box_%s_1.png", picIndex)
                    local strPic2 = string.format("ui_daily_box_%s_2.png", picIndex)

                    local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(strPic, strPic2, stageConfig.num, stageConfig.x, stageConfig.y, i)
                    -- local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", 3), string.format("ui_daily_box_%s_2.png", 3), stageConfig.num, stageConfig.x, stageConfig.y, i)
                    --stageBg:center((startX + oneWidth * i), startY)
                    --stageBg:center(58, startY - progressHeight * (stageConfig.num / maxNum))
                    --self._progressBar:addChild(stageBg, 10)
                    table.insert(self._stageIcons, stageIcon)
                    table.insert(self._stageBgs, stageBg)
                    table.insert(self._stageStars, stageStar)
                    table.insert(self._stageNewBgs, stageNewbg)
                    stageBg:center(75, - i * 100 + startY)
                    local listCell = stageBg
                    cell:addChild(listCell)
                end
                -- local listCell = stageBg
                -- print("listCell-->: ", idx, listCell)
                -- cell:addChild(listCell)
                -- if(self._enableToDoubleClick) then 
                --     listCell:enableToDoubleClick()
                -- else 
                --     listCell:disableToDoubleClick()
                -- end
                -- if(self._showChoiceStatus) then 
                --     listCell:showChoiceStatus()
                -- else 
                --     listCell:hideChoiceStatus()
                -- end

                -- listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_BEGAN, self, onPetsGridDragBeganHandler)
                -- listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_MOVED, self, onPetsGridDragMovedHandler)
                -- listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DRAG_ENDED, self, onPetsGridDragEndedandler)
                -- listCell:addEventListener(UIEvent.LIST_VIEW_GRID_CLICK, self, onPetsGridClickHandler)
                -- listCell:addEventListener(UIEvent.LIST_VIEW_GRID_DOUBLE_CLICK, self, onPetsGridDoubleClickHandler)
            end,
            function(e) 
                printError("------------------------PetList:tableCellAtIndex-----------------error")
            end, 1);
        else
            -- local listCell = cell:getChildByName("cell")
            -- if(listCell) then
            --     listCell:setDeleteChoiceArr(self.deleteChoiceArr)
            --     if(self._enableToDoubleClick) then 
            --         listCell:enableToDoubleClick()
            --     else
            --         listCell:disableToDoubleClick()
            --     end
            --     if(self._showChoiceStatus) then 
            --         listCell:showChoiceStatus()
            --     else
            --         listCell:hideChoiceStatus()
            --     end
            --     listCell:reloadData(nowData, idx * self._columnCount + 1, minShowGridNum)
            -- end
        end

        self._CellList[idx] = cell

        return cell;
    end);
    self._tableView:onUpdateCellNumbers(function ()
        -- local minNum = self._petsData.packetMinShowGridNum
        -- local totalNum = #self._petsData.petsArr
        -- if minNum > totalNum then
        --     return math.ceil(minNum / self._columnCount)
        -- else
        --     return math.ceil(#self._petsData.petsArr / self._columnCount)
        -- end

        return 1
    end)

    self._tableView:onTableCellTouched(function(tableView, cell)
        -- printInfo("PetsList  onTableCellTouched")
    end)

    self._tableView:center(650, 130)
    self.contentLayout:addChild(self._tableView, 20)
    --self:addChild(self._tableView)
    self._tableView:reloadData()
    self._tableView:scrollToBottom()

    -- -- 格子蒙层
    -- local bgUpImage = UI.Image:create()
    -- bgUpImage:init("ui_pets_list_mask.png")
    -- bgUpImage:leftBottom(-17, 106 - GRID_WIDTH)
    -- -- bgUpImage:enableDebugDraw()
    -- bgUpImage:hide()
    -- self:addChild(bgUpImage)
    -- self._bgUpImage = bgUpImage
    -- if(self._bgUpImageShow) then 
    --     bgUpImage:show()
    -- end
end

function TradeActivityCrystalCaptureView:refreshView()
    if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
        return
    end
    local master = RoleDataManager:getMaster()

    if (not master) then
        return
    end

    local haveNum = master:getCrystalTreasureHuntNum() or 0
    --local haveNum = master:getCrystal() or 0

    --更新弹珠数量
    self._diamond:setText(haveNum)

    if haveNum >= clickBtnCostNumBottom * self.crystalCostNum then
        self.moreCostNumber:setFontColor(UI.FONT_COLOR_BLACK)
    else
        self.moreCostNumber:setFontColor(UI.FONT_COLOR_RED)
    end

    if haveNum >= clickBtnCostNumTop * self.crystalCostNum then
        self.oneCostNumber:setFontColor(UI.FONT_COLOR_BLACK)
    else
        self.oneCostNumber:setFontColor(UI.FONT_COLOR_RED)
    end

    for k, v in ipairs(self.rewardAct) do
        v:setAnimation("win_end", false)
    end
    self.rewardAct = {}
    
end

function TradeActivityCrystalCaptureView:addTouchEvents()

    self.bgHost = cc.Layer:create()
    local scene = cc.Director:getInstance():getRunningScene()
    scene:addChild(self.bgHost,99999999)
    self.bgHost:setTouchEnabled(true)


    local function onTouchBegan(touch, event)  
        return true
    end

    local function onTouchEnded(touch, event)
        if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END and self.setTurnStatus and #self.bingoRollId > 1 then
            -- 这里不能提前停止，因为现在结束转动后会显示当前的转到哪个位置了
            -- 突然停掉会显得很突兀
            -- 十连抽才可以突然停止
            self:setTurnStatus(TURN_STATUS.END)
            Avalon.Scheduler:scheduleUpdateOnce(self, function()  
                if not tolua.isnull(self) then
                    self:stopRun()
                    self.bingoIndex = 0
                    self.isChange = true -- 本次是否是内外圈切换
                    self.bingoIndex = self.bingoRollId[#self.bingoRollId]
                    -- 判断本次是否会进入内圈
                    local goodsData = self.itemList[self.bingoIndex]:getGoodsData()

                    if self.bingoIndex > outsideNum then
                        -- 最后一次在内圈
                        -- 本次是在外圈转动
                        self.bingoIndex = self.bingoRollId[#self.bingoRollId - 1]
                        self.preIndex = self.bingoIndex
                        self.isInsideTrack = false -- 起始转动是否在内圈开始
                        self.index = self.preIndex
                        self.innerAnimation:setAnimation("end1", false)
                        self.innerWinningImg:setVisible(false)
                    else
                        if goodsData and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and goodsData.getVirtualType then 
                            -- 奖励下次抽奖从内圈开始
                            if goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualCrystalTreatureHuntInnter then
                                self.isInsideTrack = true -- 起始转动是否在内圈开始
                                self.index = outsideNum + 1
                                self.preIndex = self.bingoRollId[#self.bingoRollId]
                                self.innerWinningImg:setVisible(true)
                            else
                                -- 本次是在外圈转动
                                self.bingoIndex = self.bingoRollId[#self.bingoRollId]
                                self.preIndex = self.bingoIndex
                                self.isInsideTrack = false -- 起始转动是否在内圈开始
                                self.index = self.preIndex
                                self.innerAnimation:setAnimation("end1", false)
                                self.innerWinningImg:setVisible(false)
                            end
                        else
                            -- 本次是在外圈转动
                            self.bingoIndex = self.bingoRollId[#self.bingoRollId]
                            self.preIndex = self.bingoIndex
                            self.isInsideTrack = false -- 起始转动是否在内圈开始
                            self.index = self.preIndex
                            self.innerAnimation:setAnimation("end1", false)
                            self.innerWinningImg:setVisible(false)
                        end
                    end

                    if self.isInsideTrack then
                        self.lampAnimation:setAnimation("idle2", false)
                    else
                        self.lampAnimation:restore()
                        self.lampAnimation:setAnimation("idle1", true)
                    end
                    self:refreshTrack()
                end
            end, 0.4) 
            self:showTurnReward()
        end
    end

    --注册点击监听
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED )

    local eventDispatcher = self:getEventDispatcher()
    
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self.bgHost)
    listener:setSwallowTouches(false)

    self.touchListener = listener
end

function TradeActivityCrystalCaptureView:initAnimation()
    for i=1,8 do
        local test = self.innerAnimation:getNodeForSlot("mount_icon"..i)
        local qwe = cc.p(test:getPosition())
        posList[18 + i] = {qwe.x - 36, qwe.y - 30}
    end

    -- 灯光彩带动画
    local light =  UI.Animation:create()
    light:init("effect_ui_crystal_treasure_light.json", "effect_ui_crystal_treasure_light.atlas", 1);
    light:center(120, 92)
    self.contentLayout:addChild(light, 10)
    self.light = light
    self.light:setAnimation("idle2", true)
    -- 转动光圈动画
    if #self.innerTrains == 0 then
        for i = 1, 8 do
            local blink =  UI.Animation:create()
            blink:init("effect_ui_crystal_treasure_kuang.json", "effect_ui_crystal_treasure_kuang.atlas", 1)
            self.innerAnimation:addComponent("mount_icon"..(i), blink)
            blink:setName("kuang"..i)
            blink:leftBottom(-2, 2)
            blink:setScale(1.0)
            blink:hide()
            local actName = "idle1"
            blink:setAnimation(actName, false)
            --self.innerAnimation:addChild(blink, 11)
            table.insert(self.innerTrains, blink)
        end
    end
    if #self.outTrains == 0 then
        for i = 1, 5 do
            local blink =  UI.Animation:create()
            blink:init("effect_ui_crystal_treasure_kuang.json", "effect_ui_crystal_treasure_kuang.atlas", 1)
            blink:leftBottom(posList[1][1] + 36, posList[1][2] + 36)
            blink:setScale(1.0)
            blink:hide()
            local actName = "idle"..i
            blink:setAnimation(actName, false)
            self.outWinningImg:addChild(blink, 11)
            table.insert(self.outTrains, blink)
        end
    end

    -- 路灯动画
    local lampAnimation = UI.Animation:create()
    lampAnimation:init("effect_ui_crystal_treasure_ludeng.json", "effect_ui_crystal_treasure_ludeng.atlas", 1);
    lampAnimation:center(120, 92)
    self.contentLayout:addChild(lampAnimation, 12)
    lampAnimation:setAnimation("idle1", true)
    self.lampAnimation = lampAnimation

    if self.isInsideTrack then
        self.lampAnimation:setAnimation("idle2", false)
    end

    self.innerAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "begin1") then
            self.innerAnimation:setAnimation("idle1", true)
            for i=1,8 do
                local test = self.innerAnimation:getNodeForSlot("mount_icon"..i)
                local qwe = cc.p(test:getPosition())
                posList[18 + i] = {qwe.x - 36, qwe.y - 30}
                print("initAnimation-->: ", cc.p(test:getPosition()))
            end
        end
    end)
end

function TradeActivityCrystalCaptureView:setTurnStatus(status)
    self.turnStatus = status

    if self.touchListener then
        if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
            self.touchListener:setSwallowTouches(true)
        else
            self.touchListener:setSwallowTouches(false)
        end
    end
end

function TradeActivityCrystalCaptureView:lotteryStartAnimation()
-- 抽奖时的动画 
    if self.isInsideTrack then
        self.light:setAnimation("begin2", false)
        self.innerAnimation:setAnimation("idle1", false)
    else
        self.light:setAnimation("begin1", false)
    end
end

function TradeActivityCrystalCaptureView:lotteryEndAnimation()
-- 抽奖结束的动画 
    if self.isInsideTrack then
        self.light:setAnimation("begin3", false)
        self.light:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
            if (event.animation == "begin3") then
                self.innerAnimation:setAnimation("begin1", false)
            end
        end)
        self.light:addAnimation("idle2", true)
    else
        self.light:setAnimation("idle", false)
        self.innerAnimation:addAnimation("idle2",  true)
        self.light:addAnimation("idle2", true)
    end
end

function TradeActivityCrystalCaptureView:createItems(list)
    for k, v in ipairs(self.itemList) do
        v:removeFromParent()
    end
    --print("createItems--->: ", list)
    self.itemList = {}
    for k ,v in ipairs(list) do
        local pos = posList[k]
        if pos then
            local itemData = {}
            -- [[itemID, itemNum, isDraw, lotteryType]]
            itemData.itemID = v.goodsID
            itemData.itemNum = v.goodsNum
            itemData.isDraw = false
            itemData.lotteryType = v.lottery
            local lotteryItem = UI.TradeLotteryItem:create(itemData)
            lotteryItem:setTag(k)
            lotteryItem:setScale(1.0)
            --self.bg:addChild(lotteryItem, 10)
            if k > outsideNum then
                self.innerAnimation:addComponent("mount_icon"..(k-18), lotteryItem)
                lotteryItem:setName("lotteryItem"..k)
                lotteryItem:leftBottom(- 36,  - 30)
            else
                self.outWinningImg:addChild(lotteryItem, 10)
                lotteryItem:leftBottom(pos[1], pos[2])
            end 
            --lotteryItem:leftBottom(pos[1], pos[2])
            table.insert(self.itemList, lotteryItem)
        end
    end
end

-- 获取刷新的次数
function TradeActivityCrystalCaptureView:getRefreshNum()
    local master = RoleDataManager:getMaster()
    if (master) then
        return master:getCrystalTreasureHuntTotalDrawCount() or 0
        --return master:getMarblesFeverDrawCount() or 0
    end

    return 0
end

function TradeActivityCrystalCaptureView:turnClick(isSingle)

    if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
        self:setTurnStatus(TURN_STATUS.END)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                self:stopRun()
            end
        end, 0.4) 
        self:showTurnReward()
    end

    if self.rewardLock then
        print("---turnClick self._rewardLock = ", self.rewardLock)
        return
    end
    if self.turnStatus ~= TURN_STATUS.BEGIN then
        print("---turnClick self.turnStatus = ", self.turnStatus)
        return
    end

    
    local master = RoleDataManager:getMaster()
    if (not master) then
        return
    end

    local useNum = clickBtnCostNumTop * self.crystalCostNum
    --local cost = 1
    local haveNum = master:getCrystalTreasureHuntNum() or 0
    --local haveNum = master:getCrystal() or 0
    if not isSingle then
        useNum = clickBtnCostNumBottom * self.crystalCostNum
        --cost = 10
    end

    -- 抽取次数达到上限提示
    -- if(self:getRefreshNum() + useNum >= maxNum) then 
    --     UI.ScrollBar:createByTextID(1113622)
    --     return
    -- end
    if haveNum < useNum then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(UI.TEXT_222209))
        return
    end
    
    -- if isSingle then
    --     self.rocker:setAnimation("begin1", false)
    -- else
    --     self.rocker:setAnimation("begin2", false)
    -- end
    --self.light:setAnimation("idle2", true)
    Avalon.AudioManager:playSound("1554", false)

    self.runningTime = 0
    self:setTurnStatus(TURN_STATUS.ACCELERATE)

    self:refreshTrack()
    -- for k, v in ipairs(self.trains) do
    --     v:show()
    -- end
    -- for k, v in ipairs(self.rewardAct) do
    --     v:addAnimation("win_end", false)
    -- end
    -- self.rewardAct = {}

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    if isSingle then
        Net.NetPlaySystem:requestCrystalCaptureDraw(1)
    else
        Net.NetPlaySystem:requestCrystalCaptureDraw(2)
    end

    self.touchListener:setSwallowTouches(true)

    self:lotteryStartAnimation()
end

function TradeActivityCrystalCaptureView:refreshTrack()
    if self.isInsideTrack then
        local index = 1
        for k, v in ipairs(self.innerTrains) do
            if index > 1 then
                v:hide()
            else
                v:show()
                v:setAnimation("idle1", false)
            end
            index = index + 1
        end
        for k, v in ipairs(self.outTrains) do
            v:hide()
        end
    else
        for k, v in ipairs(self.outTrains) do
            v:show()
            if self.isChange then
                v:leftBottom(posList[self.preIndex][1] + 36, posList[self.preIndex][2] + 36)
            end
        end

        for k, v in ipairs(self.innerTrains) do
            v:hide()
        end
    end
end

function TradeActivityCrystalCaptureView:showTurnReward()
    Avalon.AudioManager:playSound("1507", false)
    if self.bingoRollId == nil then
        print("------showTurnReward----", self.bingoRollId)
        return
    end

    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            -- for k, v in ipairs(self.trains) do
            --     --v:hide()
            -- end

            for k, v in ipairs(self.rewardAct) do
                v:destroy()
            end
            self.rewardAct = {}
            self:lotteryEndAnimation()
        end
    end, 0.5)

    self.rewardLock = true
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            local list = {}--lotteryData:getTurnReward(self.bingoRollId)
            -- 提示下一次在内圈转动
            local nextIsInner = false

            for id,gData in ipairs(self.bingoRollId) do
                local conf = ConfigManager:getAllCrystalTreasureDataByID(gData)
                local goodsData = GoodsDataManager:createLocalGoodsData(conf.goodsID)
                local goodsNum = conf.goodsNum
                goodsData:setIsGolden(true)
                goodsData:setNum(goodsNum)

                if goodsData and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then 
                    -- 奖励下次抽奖从内圈开始
                    if goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualCrystalTreatureHuntInnter then
                        nextIsInner = true
                    else
                        table.insert(list,goodsData)
                    end
                else
                    table.insert(list,goodsData)
                end
            end
            
            local str = UI.TEXT_111030
            print("self.sendByMail ===== ",self.sendByMail)
            if(self.sendByMail) then 
                str = LanguageManager:getInstance():getLocalString(1111068)
            end
            self:updateStageView()
            self:refreshTrack()
            if nextIsInner and (#self.bingoRollId == 1) then
                -- 下次将在内圈抽取奖励 UI.TEXT_
                UI.ScrollBar:createByText(UI.TEXT_224601)
            else
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)
            end
        end
    end, 0.6)
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            self.rewardLock = false
        end
    end, 0.7)
end

function TradeActivityCrystalCaptureView:stopRun()
    -- for k, v in ipairs(self.trains) do
    --     v:hide()
    -- end
    self.changeTime = 0
    self.speed = INIT_SPEED
    self.aceSpeed = ACE_SPEED
    self.deSpeed = 0 -- 每秒跳动增加的格子 
    self:setTurnStatus(TURN_STATUS.BEGIN)
    self.bingoIndex = 0
    self.runningTime = 0
    self.remainDis = 0
    self.tIndex = 0
    --self.light:setAnimation("idle1", true)
    self:refreshView()
end

--local test = 1

function TradeActivityCrystalCaptureView:netCallBack(data)
    print( " data.sendToMail ===== ",data)
    --self.bingoIndex = 16
    self.bingoIndex = data.awards[1]
    self.bingoRollId = data.awards
    self.sendByMail = data.sendToMail
    -- local list = {}

    -- if test == 1 then
    --     self.bingoIndex = 6
    -- else
    --     self.bingoIndex = 22
    -- end
    -- local awards = {19, 7, 6, 20, 15, 22, 15, 23, 1, 6}
    -- --local awards = {math.random(5,7)}
    -- self.bingoIndex = awards[1]
    -- self.bingoRollId = awards

    -- test = test + 1

    -- local itemID = 0
    -- local goodsData = GoodsDataManager:createLocalGoodsData(itemID)
    -- table.insert(list,goodsData)

    -- local str = UI.TEXT_111030
    -- if(data.sendByMail == 1) then 
    --     str = LanguageManager:getInstance():getLocalString(1111068)
    -- end

    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)  
end

function TradeActivityCrystalCaptureView:update(dt)
    local curFps = GameManager:getFps()
    if self.turnStatus == TURN_STATUS.BEGIN then
        -- 开始转动，只显示一个起点
        self.beginRotateIndex = 1
        return
    elseif self.turnStatus == TURN_STATUS.END then
        -- self:playAction(self.index)
        return
    elseif self.turnStatus == TURN_STATUS.ACCELERATE then
        -- 加速阶段
        -- print("----self.turnStatus----", self.turnStatus)
        self.speed = self.speed + self.aceSpeed / curFps
        if self.speed >= MAX_SPEED then
            self:setTurnStatus(TURN_STATUS.CONSTANT_SPEED)
        end
    elseif self.turnStatus == TURN_STATUS.DECELERATE then
        -- print("----self.turnStatus----", self.turnStatus)
        -- local index = self.index % #posList
        -- 开始减速
        local time = self.remainDis / (self.speed / 2)
        if time > 0 then
            self.deSpeed = self.speed / time
            self.speed = self.speed - self.deSpeed / curFps
        end
        -- if self.speed > 0 and self.deSpeed / curFps <= 0.01 then--self.deSpeed / curFps 会低到很低 精度之外 所以特殊处理一下
        --     self.speed = MAX_SPEED / 10
        -- end
        -- print("1-----", self.speed, self.deSpeed / curFps, self.deSpeed, curFps)
        if self.remainDis == 0 then 
            -- print("----------------self.index = ", self.index % #posList, self.bingoIndex)
            self:twiceTurnCheck(self.bingoIndex)
        end
    elseif self.turnStatus == TURN_STATUS.CONSTANT_SPEED then
        -- 匀速阶段
        if self.bingoIndex ~= 0 then
            -- 收到消息，具体中间号数后开始减速
            local onceCircle = outsideNum
            if self.isInsideTrack then
                onceCircle = insideNum - outsideNum
            end

            self:setTurnStatus(TURN_STATUS.DECELERATE)
            local dis = (self.bingoIndex - self.index) % onceCircle + onceCircle * 2
            local time = dis / (self.speed / 2)
            self.deSpeed = self.speed / time
            self.remainDis = dis + 1
        end
    end

    if self.turnStatus ~= TURN_STATUS.BEGIN or self.turnStatus ~= TURN_STATUS.END then
        self.runningTime = self.runningTime + dt
        if self.runningTime > TIME_OUT and self.bingoIndex == 0 then
            self:stopRun()
            UI.ScrollBar:createByText(UI.TEXT_1212028)
            return
        end
    end

    self.changeTime = self.changeTime + dt
    if self.changeTime >= 1 / self.speed then
        if self.isInsideTrack then
            if self.index > insideNum then
                self.index = outsideNum + 1
            end
        else
            if self.index > outsideNum then
                self.index = 1
            end
        end

        self:playAction(self.index)

        local index = self.index % #posList
        index = index == 0 and #posList or index

        self.index = index + 1
        self.remainDis = self.remainDis - 1
        self.changeTime = 0

        self.beginRotateIndex = self.beginRotateIndex + 1
        if self.beginRotateIndex > rotateMaxShowNum then
            self.beginRotateIndex = rotateMaxShowNum
        end
    end
    -- print("-----self.turnStatus = ", self.turnStatus)
end

function TradeActivityCrystalCaptureView:playAction(index)
    Avalon.AudioManager:playSound("1507", false)
    local trains = nil
    if self.isInsideTrack then
        trains = self.innerTrains
    else
        trains = self.outTrains
    end
    local size = self.beginRotateIndex

    for k, v in ipairs(trains) do

        local rotateIndex = index - k + 1

        -- 判断是否在内圈转动
        if self.isInsideTrack then
            if rotateIndex <= (outsideNum) then
                rotateIndex = rotateIndex + (insideNum - outsideNum)
            end
            v = trains[rotateIndex - outsideNum]
        else
            if rotateIndex <= 0 then
                rotateIndex = rotateIndex + outsideNum
            end
        end

        if size > 0 then
            self:_playAction(v, k, rotateIndex)
        else
            v:hide()
        end
        size = size - 1
    end

    if self.isInsideTrack then
        local rotateIndex = index - outsideNum + 1
        self.lampAnimation:setAnimation(string.format("idle%d", rotateIndex), false)
    end
end

function TradeActivityCrystalCaptureView:_playAction(blink, level, index)
    index = index % #posList
    index = index == 0 and #posList or index

    local pos = posList[index]
    --blink:leftBottom(pos[1] + 36, pos[2] + 36)

    if not self.isInsideTrack then
        blink:leftBottom(pos[1] + 36, pos[2] + 36)
    end

    local actName = "idle"..level
    blink:setAnimation(actName, false)
    blink:show()
end

--多个奖励时的第二 以及之后的奖励
function TradeActivityCrystalCaptureView:twiceTurnCheck(preBingoId)
    self.bingoIndex = 0
    self.isChange = false -- 本次是否是内外圈切换
    self.tIndex = self.tIndex + 1
    local preIsInnerTrack = self.isInsideTrack
    print("-----1  ", preBingoId, self.bingoIndex)
    if self.bingoRollId[self.tIndex + 1] then
        self.bingoIndex = self.bingoRollId[self.tIndex + 1]
    end

    if self.isInsideTrack then
        -- 本次是在内圈转动,转动完毕后自动跳到外圈
        self.isInsideTrack = false -- 起始转动是否在内圈开始
        self.index = self.preIndex
        self.innerAnimation:setAnimation("end1", false)
        self.isChange = true
        self.innerWinningImg:setVisible(false)
    else
        -- 判断本次是否会进入内圈
        local goodsData = self.itemList[preBingoId]:getGoodsData()
        if goodsData and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then 
            -- 奖励下次抽奖从内圈开始
            if goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualCrystalTreatureHuntInnter then
                print("into Inside track!!!!!!!!!!!")
                self.isInsideTrack = true -- 起始转动是否在内圈开始
                self.preIndex = self.index
                self.index = outsideNum + 1
                self.isChange = true
                self.innerWinningImg:setVisible(true)
                self.lampAnimation:setAnimation("idle2", false)
            end
        end
    end
    
    print("-----1  self.bingoIndex = ", self.bingoIndex)
    if self.bingoIndex ~= 0 then
        self:setTurnStatus(TURN_STATUS.END)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                -- for k, v in ipairs(self.trains) do
                --     --v:hide()
                -- end
                self:playRewardAct(preBingoId, preIsInnerTrack)
                self:lotteryEndAnimation()
                self:refreshTrack()
                -- self.itemList[preBingoId]:setIsGray()
            end
        end, 0.4) 
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                --self.index = self.index + 1
                self:setTurnStatus(TURN_STATUS.DECELERATE)
                self.runningTime = 0
                self.speed = MAX_SPEED

                local onceCircle = outsideNum
                if self.isInsideTrack then
                    onceCircle = insideNum - outsideNum
                end
                local dis = (self.bingoIndex - self.index) % onceCircle + onceCircle

                --local dis = (self.bingoIndex - self.index) % #posList + #posList
                local time = dis / (self.speed / 2)
                self.deSpeed = self.speed / time
                self.remainDis = dis + 1
            end
        end, 1) 
    else
        self:setTurnStatus(TURN_STATUS.END)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                self:stopRun()
                if self.isInsideTrack then
                    self.lampAnimation:setAnimation("idle2", false)
                else
                    self.lampAnimation:restore()
                    self.lampAnimation:setAnimation("idle1", true)
                end
            end
        end, 0.4) 
        self:showTurnReward()
    end
end

function TradeActivityCrystalCaptureView:playRewardAct(index, isInner)
    index = index % #posList
    index = index == 0 and #posList or index
    local pos = posList[index]
    local node = UI.Animation:create()
    node:init("effect_ui_lottery_win.json", "effect_ui_lottery_win.atlas", 1)
    node:center()
    node:setScale(1.0)
    node:leftBottom(pos[1] + 36, pos[2] + 36)
    --self:addChild(node, 10)
    node:setAnimation("win_begin", false)
    node:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "win_begin") then
            sender:addAnimation("win_idle", true)
        elseif (event.animation == "win_end") then
            sender:destroy()
        end
    end)
    table.insert(self.rewardAct, node)


    if isInner then
        --self.innerAnimation:addChild(node, 11)
        self.innerAnimation:addComponent("mount_icon"..(index-18), node)
        node:setName("lotteryItem"..index)
        node:leftBottom(-2 , 2)
    else
        self.outWinningImg:addChild(node, 11)
    end
end

function TradeActivityCrystalCaptureView:openCrystalCaptureShop()
    -- local qwe = {title = 1114092, keyStr = "symbol_gaming_antifightingkey.png", 
    -- requestedMaterial = 22050120, storeType = PublicDefine.StoreType.StoreType_CrystalTreature}
    local storeType = PublicDefine.StoreType.StoreType_CrystalTreature
    mvc.openPanel("CrystalTreatureShop", "CrystalTreatureShop", storeType)
end

function TradeActivityCrystalCaptureView:onUpdateView()
    self:updateStageView()
end

function TradeActivityCrystalCaptureView:updateStageView()
    -- 更新进度条
    -- 解析阶段点数
    local stageConfigStrArrs = ConfigManager:getAllStageRewards()
    local stagePointArr = {}
    for i,v in pairs(stageConfigStrArrs) do
        table.insert(stagePointArr, tonumber(v.drawTimes))
    end

    local iconConfigs = {}
    for i=1,#stagePointArr do
        table.insert(iconConfigs, {num = stagePointArr[i] or i *10, x = 0, y = -10})
    end


    -- 当前的抽取次数
    local totalPoint = self:getRefreshNum()

    ------- test --------------
    -- self.testProgress = self.testProgress + 10
    -- totalPoint = self.testProgress
    --totalPoint = 50
    ------- test --------------

    -- 这里以每隔20来做进度显示，后续不为20一段的全部按照数据转换为20来计算
    local stagePointArr = ConfigManager:getAllStageRewards()
    local maxPoint = stagePointArr[(#stagePointArr)].drawTimes
    --local maxPoint = stagePointArr[3]

    local progressPoint = totalPoint
    local progress = progressPoint / maxPoint

    if (progress > 1) then progress = 1 end
    if (progress < 0) then progress = 0 end
    self._progressBar:setPercent(progress)

    -- 更新进度条动画
    print("progress___>: ", progress)
    if progress >= 0.99 then
        self.progressAni:setVisible(false)
    elseif progress >= 0.1 then
        local progressHeight = 521
        local aniStartY = progressHeight / 2
        self.progressAni:setVisible(true)
        self.progressAni:center(0, aniStartY - progressHeight * progress - 2 * (1 - progress) + 2 * progress)
    end

    -- 更新活跃度数字
    self._activityPointText:setText(tostring(totalPoint))
    if totalPoint > 999 then
        self._activityPointText:setFontSize(UI.FONT_SIZE_18PX)
    end

    -- 更新按钮状态
    local stagePointArr = ConfigManager:getAllStageRewards()
    local progressIdx = 0
    for i=1,#stagePointArr do
        local num = stagePointArr[i].drawTimes
        if totalPoint >= num then
            progressIdx = i
        end
    end

    --print("")
    --local progressIdx = mvc.activityPointModel:getProgressStage()
    local master = RoleDataManager:getMaster()
    local stage = master:getCrystalTreasureHuntStageID()
    for i=1,#self._stageIcons do
        local icon = self._stageIcons[i]
        local newLabelBg = self._stageNewBgs[i]
        if (icon and newLabelBg) then
            -- 设置按钮状态
            if (i <= progressIdx) then
                icon:enable()
                -- if (i <= stage) then
                --     newLabelBg:show()
                -- else
                --     newLabelBg:hide()
                -- end
                --newLabelBg:show()
                newLabelBg:getChildByName("newLabel2"):setVisible(true)
            else
                icon:disable()
                newLabelBg:getChildByName("newLabel2"):setVisible(false)
            end

            -- -- 设置红点状态
            -- local currentStage = stage
            -- local star = self._stageStars[i]
            -- if (star and i == currentStage + 1 and i <= progressIdx) then
            --     star:show()
            -- else
            --     star:hide()
            -- end
        end
    end
end

function TradeActivityCrystalCaptureView:showCrystalCaptureItemByIndex(idx, title, btnStr)
    -- 展现获得物品
    local rewardInfoArr = ConfigManager:getAllStageRewards()
    if (rewardInfoArr and #rewardInfoArr > 0) then
        rewardInfoArr = rewardInfoArr[idx]
        local dropDisplayDataArr = {}
        --for i,v in pairs(rewardInfoArr) do
            local dummyItem = GoodsDataManager:createLocalGoodsData(rewardInfoArr.shopGoods)
            if(dummyItem) then
                dummyItem:setNum(rewardInfoArr.goodsNum)
                table.insert(dropDisplayDataArr, dummyItem)
            end
        --end

        if (#dropDisplayDataArr > 0) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr)  
        end
    end
end

function TradeActivityCrystalCaptureView:createStageIcon(normalIconName, greyIconName, num, xOffset, yOffset, idx)
    -- 背景
    local bg  = UI.Image:create()
    bg:init("ui_treasure_bg_2.png")

    -- 按钮
    local iconButton  = UI.Button:create()
    iconButton:init(normalIconName, normalIconName, greyIconName)
    iconButton:center(xOffset, yOffset)
    iconButton:setInterval(1)
    bg:addChild(iconButton)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local master = RoleDataManager:getMaster()
        local currentStage = master:getCrystalTreasureHuntStageID()
        -- 阶段到达时，由服务器自动通过邮件的方式发放
        self:showCrystalCaptureItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
        if (idx <= currentStage) then
            UI.ScrollBar:createByText(UI.TEXT_224602 --[["奖励已通过邮件发送！"]])
        end
    end)
    iconButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:showCrystalCaptureItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
        --mvc.activityPointController:showItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
    end)

    -- 新标签背景
    local newLabelBg  = UI.Image:create()
    newLabelBg:init("ui_treasure_bg_3.png")
    newLabelBg:center(-3, 23)
    bg:addChild(newLabelBg)
    
    -- 新标签文字
    -- local newLabel = UI.Text:create()
    -- newLabel:init(LanguageManager:getInstance():getLocalString(1112426)--[["已领取"]], UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 249,  g = 190,  b = 86})
    -- newLabel:center(-15, -45)
    -- newLabel:rotate(-18)
    -- newLabel:setName("newLabel")
    -- newLabelBg:addChild(newLabel)

    -- 数字
    local numLabel = UI.Text:create()
    numLabel:init(tostring(num), UI.FONT_BOLD, 18, {r = 234,  g = 201,  b = 124})
    numLabel:center(-3, 22)
    bg:addChild(numLabel)

    -- 红点
    local starPoint = UI.Animation:create()
    starPoint:init("effect_ui_package_return_gift.json", "effect_ui_package_return_gift.atlas", 1)
    starPoint:setAnimation("idle", true)
    starPoint:center(30, -45)
    starPoint:hide()
    bg:addChild(starPoint)

    -- 已领取图片
    local newLabelBg2  = UI.Image:create()
    newLabelBg2:init("ui_monthlysign_received.png")
    newLabelBg2:center(18, -45)
    newLabelBg2:setName("newLabel2")
    newLabelBg2:setVisible(false)
    newLabelBg:addChild(newLabelBg2)

    return bg, iconButton, starPoint, newLabelBg
end

-- function TradeActivityCrystalCaptureView:refreshStageShow(data)
--     -- 刷新阶段奖励界面
--     if (data.result == PublicDefine.ErrNo.ErrNo_Ok) then 
--         local master = RoleDataManager:getMaster()
--         master:setStage(data.id)
--         self:updateStageView()

--         -- 展现获得物品
--         self:showCrystalCaptureItemByIndex(data.id, LanguageManager:getInstance():getLocalString(1112117) --[["领取"]])
--     else
--         UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118) --[["系统错误"]])
--     end
-- end

function TradeActivityCrystalCaptureView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_CRYSTAL_CAPTURE_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    --Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_CRYSTAL_CAPTURE_RRWARD, self, self.refreshStageShow)
end


function TradeActivityCrystalCaptureView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_CRYSTAL_CAPTURE_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    --Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_CRYSTAL_CAPTURE_RRWARD, self, self.refreshStageShow)
end





return TradeActivityCrystalCaptureView












