------------------------------------------------------------------------------
--author: 
--date	: 2019/05/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityLotteryView = class("ActivityLotteryView", UI.HWBtnComponent)
require "app.modules.activitylottery.LotteryItem"
local GameDataManager = require("app.game.GameDataManager")
-- 资源
local COM_RES_LIST = {
    "ui_town_lottery.plist"
}

local maxNum = 50000

local TURN_STATUS = {
    BEGIN = 1,-- 开始阶段  可以点击按钮开始的状态
    ACCELERATE = 2, --加速阶段
    CONSTANT_SPEED = 3,  --匀速阶段
    TWICE_DECELERATE = 4,   --减速节点
    DECELERATE = 5,   --减速节点
    END = 6,    --结束 展示中奖、奖励界面
}

--速度相关的单位 全是 每秒跳动的格子数量
local INIT_SPEED = 10 --初始化速度
local ACE_SPEED = 16  --加速度
local MAX_SPEED  = 20 --最大速度
local TIME_OUT = 15 --转盘请求超时15秒
local posList = {{153, 332}, {228, 332}, {303, 332}, {377, 332},{451, 332}, {525, 332}, {599, 332}, {599, 258}, {599, 184}, {599, 110},
                {525, 110}, {451, 110}, {377, 110}, {303, 110}, {228, 110}, {153, 110}, {153, 184},{153, 258}}
local COM_WIDTH = 938
local COM_HEIGHT = 569
function ActivityLotteryView:ctor()
    ActivityLotteryView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    -- layoutUtil = UIUtil:createAutoUILayout("ActivityLotteryView","app.modules.activitylottery.ActivityLotteryPosConfig", false)
    self.itemList = {}
    self.trains = {} 
    self.rewardAct = {}
    self.index = 1
    self.changeTime = 0
    self.speed = INIT_SPEED
    self.aceSpeed = ACE_SPEED
    self.deSpeed = 0 -- 每秒跳动增加的格子 
    self.remainDis = 0
    self.turnStatus = TURN_STATUS.BEGIN
    self.bingoIndex = 0
    self.bingoRollId = nil
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBegan)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function ActivityLotteryView:dtor()
    ActivityLotteryView.super.dtor(self)
    self:unbindModel()
    self.turnStatus = TURN_STATUS.BEGIN
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file_mvc("app.modules.activitylottery.ActivityLotteryView")
end

function ActivityLotteryView:onInitView()
    local bg = UI.Image:create()
    bg:init('ui_lottery_bg.png')
    bg:center()
    self:addChild(bg)
    self.bg = bg

  -- 标题背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:leftUp(bg:getContentSize().width/2 - titleBg:getContentSize().width/2 - 8, -21)
    bg:addChild(titleBg, 10)

    local text = UI.Text:create()
    text:init(UI.TEXT_1212436, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
    text:centerLeft(56+117 - text:getContentSize().width/2)
    titleBg:addChild(text)

    local light = UI.Animation:create()
    light:init("effect_ui_lottery_light.json", "effect_ui_lottery_light.atlas", 1);
    light:leftBottom(418, 275)
    bg:addChild(light)
    light:setAnimation("idle", true)
    self.light = light

    local rocker =  UI.Animation:create()
    rocker:init("effect_ui_lottery_drawbar.json", "effect_ui_lottery_drawbar.atlas", 1);
    rocker:rightBottom(227.7, 285)
    bg:addChild(rocker, 100)
    rocker:setAnimation("idle", false)
    self.rocker = rocker

    -- 次数限制
    local text = UI.Text:create()
    text:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_32_32)
    text:leftUp(114, 50)
    bg:addChild(text, 100)
    self._numberText = text

    local box =  UI.Animation:create()
    box:init("effect_ui_lottery_box.json", "effect_ui_lottery_box.atlas", 1);
    box:leftBottom(88, 32)
    bg:addChild(box)
    box:setAnimation("idle", true)
    self.box = box

    -- 抽奖卷
    local itemImage = UI.Image:create()
    itemImage:init("symbol_gaming_207036.png")
    itemImage:center(62, -227)
    bg:addChild(itemImage)
    self._itemImage = itemImage
    itemImage:hide()

    -- 抽奖卷数量
    self._itemNum = UI.NumberText:create(0, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    self._itemNum:setTextLeft()
    self._itemNum:leftBottom(600, 500)
    bg:addChild(self._itemNum, 4)
    self._itemNum:hide()

    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:leftBottom(710, 500)
    bg:addChild(diamondImage)

    -- 钻石数量
    self._diamond = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    self._diamond:setTextLeft()
    self._diamond:leftBottom(740, 500)
    bg:addChild(self._diamond, 4)

    -- 钻石按钮
    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, nil, self.parentWin,
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_CurrencyPanel)
    end)
    shopButton:leftBottom(886, 498)
    bg:addChild(shopButton)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
        shopButton:show()
    else
        shopButton:hide()
    end

    local remainText = UI.Text:create()
    remainText:init(UI.TEXT_1212439, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_153_153_153)
    remainText:setSize(170, 50)
    -- remainText:enableDebugDraw()
    remainText:setTextCenter()
    remainText:center(310, -170)
    bg:addChild(remainText)

    local remainNumber = UI.Image:create()
    remainNumber:init("ui_lottery_num_0.png")
    remainNumber:rightBottom(126, 398)
    self.remainNumber = remainNumber
    bg:addChild(remainNumber)

    local oneTimesBtn = UI.Button:create()
    oneTimesBtn:init("ui_btn_yellow15_0.png", "ui_btn_yellow15_1.png", "ui_btn_yellow15_2.png")
    oneTimesBtn:rightBottom(148, 199)
    bg:addChild(oneTimesBtn)
    oneTimesBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:turnClick(true)
    end)
    oneTimesBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1170105)
    end)
    self.oneTimeBtn = oneTimesBtn

    local oneCostNode = UI.Layout:create()
    oneCostNode:init()
    oneCostNode:setSize(28, 28)
    oneCostNode:leftBottom(10, 0)
    oneTimesBtn:addChild(oneCostNode, 10)
    self.oneCostNode = oneCostNode

    local oneCostIcon = UI.Image:create()
    oneCostIcon:init("symbol_gaming_diamond.png")
    oneCostIcon:center()
    oneCostNode:addChild(oneCostIcon, 10)
    self.oneCostIcon = oneCostIcon

    local oneCostNumber = UI.Text:create()
    oneCostNumber:init("1", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    oneCostNumber:leftBottom(70 ,2)
    oneTimesBtn:addChild(oneCostNumber, 10)
    self.oneCostNumber = oneCostNumber

    local oneText = UI.Text:create()
    oneText:init(string.format(UI.TEXT_1212437, 1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    oneText:centerUp(1)
    oneTimesBtn:addChild(oneText, 10)
    self.oneText = oneText

    local remainTime = UI.Text:create()
    remainTime:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    remainTime:rightBottom(188, 178)
    bg:addChild(remainTime, 10)
    self.remainTime = remainTime

    local moreTimeBtn = UI.Button:create()
    moreTimeBtn:init("ui_btn_yellow15_0.png", "ui_btn_yellow15_1.png", "ui_btn_yellow15_2.png")
    moreTimeBtn:rightBottom(148, 121)
    bg:addChild(moreTimeBtn)
    moreTimeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:turnClick(false)
    end)
    moreTimeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1170105)
    end)
    self.moreTimeBtn = moreTimeBtn

    local moreCostNode = UI.Layout:create()
    moreCostNode:init()
    moreCostNode:setSize(28, 28)
    moreCostNode:leftBottom(10, 0)
    moreTimeBtn:addChild(moreCostNode, 10)
    self.moreCostNode = moreCostNode

    local moreCostIcon = UI.Image:create()
    moreCostIcon:init("symbol_gaming_diamond.png")
    moreCostIcon:center()
    moreCostNode:addChild(moreCostIcon, 10)
    self.moreCostIcon = moreCostIcon

    local moreCostNumber = UI.Text:create()
    moreCostNumber:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    moreCostNumber:leftBottom(70, 2)
    moreTimeBtn:addChild(moreCostNumber, 10)
    self.moreCostNumber = moreCostNumber

    local moreText = UI.Text:create()
    moreText:init(string.format(UI.TEXT_1212437, 0), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    moreText:centerUp(1)
    moreTimeBtn:addChild(moreText, 10)
    self.moreText = moreText

    local actEndTime =  UI.Text:create()
    actEndTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    actEndTime:center(345, 235)
    bg:addChild(actEndTime, 10)
    self.actEndTime = actEndTime

    local refresTip =  UI.Text:create()
    refresTip:init(UI.TEXT_1212447, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    refresTip:leftUp(176, 123)
    bg:addChild(refresTip, 10)
    self.refresTip = refresTip


    --幸运模块
    local luckBg =  UI.Image:create()
    luckBg:init("ui_lottery_progress_2.png")
    luckBg:leftBottom(240, 193)
    bg:addChild(luckBg)

    local luckPro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_lottery_progress_1.png"))
    luckPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    luckPro:setMidpoint(cc.p(0, 0))
    luckPro:setBarChangeRate(cc.p(1, 0))
    luckPro:setPercentage(0)
    luckPro:setPosition(120, 44)
    luckBg:addChild(luckPro)
    self.luckPro = luckPro

    local luckValue = UI.Text:create()
    luckValue:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    luckValue:leftUp(243, 285)
    bg:addChild(luckValue, 10)
    self.luckValue = luckValue

    local luckBtn = UI.Button:create()
    luckBtn:init("ui_lottery_treasure.png", "ui_lottery_treasure.png", "ui_lottery_treasure.png")
    luckBtn:rightBottom(452, 188)
    bg:addChild(luckBtn)
    luckBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:luckRewardClick()
    end)
    self.luckBtn = luckBtn
 
    local luckTips = UI.Text:create()
    luckTips:init(UI.TEXT_1212441, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    luckTips:leftUp(243, 254)
    bg:addChild(luckTips, 100)
    self.luckTips = luckTips

    local btnRefresh = UI.Button:create()
    btnRefresh:init("ui_btn_refresh_0.png", "ui_btn_refresh_1.png", "ui_btn_refresh_2.png")
    btnRefresh:leftBottom(143, 422)
    bg:addChild(btnRefresh)
    btnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:refreshClick()
    end)
 
    -- local btnClose = UI.Button:create()
    -- btnClose:init("ui_btn_team_close_0.png", "ui_btn_team_close_1.png", "ui_btn_team_close_0.png")
    -- btnClose:rightUp(104, 38)
    -- bg:addChild(btnClose)
    -- btnClose:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     self:closeClick()
    -- end)
    self:refreshView()
end

function ActivityLotteryView:luckRewardClick()
    -- body
    if self.turnStatus ~= TURN_STATUS.BEGIN then
        print("---refreshClick self.turnStatus = ", self.turnStatus)
        return
    end
    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        print("---refreshClick activityData is null")
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        print("---refreshClick lotteryData is null")
        return
    end
    local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
    if endTime <= 0 then
        UI.ScrollBar:createByTextID(1170230)
        return
    end 
    
    -- if GameDataManager:getInstance():getFreePacketBoxNum() < 1 then
    --     UI.ScrollBar:createByTextID(1170081)
    --     return
    -- end

    local curLuck, maxLuck = lotteryData:getLuckNum()
    if curLuck >= maxLuck then
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_RewardLucky)
    else
        UI.ScrollBar:createByText(UI.TEXT_1212445)
    end
end

function ActivityLotteryView:refreshClick()
    if self.turnStatus ~= TURN_STATUS.BEGIN then
        print("---refreshClick self.turnStatus = ", self.turnStatus)
        return
    end
    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        UI.TipsLayer:OutOfDateForTurnTable(UI.TEXT_1170926, function()
            self:closeClick()
        end)
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        print("---refreshClick lotteryData is null")
        return
    end
    local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
    if endTime <= 0 then
        UI.ScrollBar:createByTextID(1170230)
        return
    end 
    local count, cost = lotteryData:getRefreshCountAndCost()
    local text = UI.TEXT_1212444
    if lotteryData:getTurnTimes() <= 0 then
        cost = 0
        text = UI.TEXT_1212446
    end
    UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(text, function(isSelect)
        if GameDataManager:getInstance():getDiamond() < cost then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        if cost <= 0 then
            Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh, PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Free)
        else
            Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh)
        end
    end, function(isSelect)
    end, nil, nil, false, cost)
end

function ActivityLotteryView:turnClick(isSingle)
    if self.rewardLock then
        print("---turnClick self._rewardLock = ", self.rewardLock)
        return
    end
    if self.turnStatus ~= TURN_STATUS.BEGIN then
        print("---turnClick self.turnStatus = ", self.turnStatus)
        return
    end
    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        UI.TipsLayer:OutOfDateForTurnTable(UI.TEXT_1170926, function()
            self:closeClick()
        end)
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        print("---turnClick lotteryData is null")
        return
    end
   
    if lotteryData:getTurnTimes() <= 0 then
        local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.LotteryRefreshCost..GameDataManager:getInstance():getMasterPK(), true) 
        if isNotice then
            UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212446, function(isSelect)
                if isSelect then
                    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.LotteryRefreshCost..GameDataManager:getInstance():getMasterPK(), false)  
               end
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh, PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Free)
            end, function(isSelect)
            end, nil, nil, true, 0)
        else
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh, PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Free)
        end
        return
    end

    local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
    if endTime <= 0 then
        UI.ScrollBar:createByTextID(1170230)
        return
    end 
    local useNum = 1
    if isSingle then
        -- if GameDataManager:getInstance():getFreePacketBoxNum() < 1 then
        --     UI.ScrollBar:createByTextID(1170081)
        --     return
        -- end
    else
        useNum = lotteryData:getTurnTimes()
        -- if GameDataManager:getInstance():getFreePacketBoxNum() < lotteryData:getTurnTimes() then
        --     UI.ScrollBar:createByTextID(1170081)
        --     return
        -- end
    end

    if(self:getRefreshNum() + useNum >= maxNum) then 
        UI.ScrollBar:createByTextID(1113622)
        return
    end

    local cost, costItemId = lotteryData:getTurnCost()
    local goodNumber = -1
    local useGoodsData = nil
    if costItemId ~= 0 and costItemId ~= nil then
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costItemId, true)
        useGoodsData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, costItemId, false, 0)
    end
    local costType = PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Diamond
    if isSingle then
        if lotteryData:getRemianRefreshTime() <= 0 then
            costType = PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Free
        elseif goodNumber >= 1 then
            costType = PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Item
        else
            if GameDataManager:getInstance():getDiamond() < cost then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
        end
    else
        if goodNumber >= lotteryData:getTurnTimes() then
            costType = PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Item
        else
            if GameDataManager:getInstance():getDiamond() < cost then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
        end
    end

    if(costType == PublicDefine.LuckyLotteryCostType.LuckyLotteryCostType_Item) then 
        if(useGoodsData) then
            if useGoodsData:getIsLock() then
                UI.ScrollBar:createByText(UI.TEXT_110030)
                return
            end
        end
    end

    if isSingle then
        self.rocker:setAnimation("begin1", false)
        self.box:setAnimation("begin1", true)
        self.light:setAnimation("begin1", true)
    else
        self.rocker:setAnimation("begin2", false)
        self.box:setAnimation("begin2", true)
        self.light:setAnimation("begin2", true)
    end
    Avalon.AudioManager:playSound("1554", false)

    self.runningTime = 0
    self.turnStatus = TURN_STATUS.ACCELERATE
    for k, v in ipairs(self.trains) do
        v:show()
    end
    for k, v in ipairs(self.rewardAct) do
        v:addAnimation("win_end", false)
    end
    self.rewardAct = {}

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    if isSingle then
        Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn, costType, 1)
    else
        Net.NetActivitySystem:requestLuckLottery(activityData:getID(), PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn, costType, lotteryData:getTurnTimes())
    end
end

function ActivityLotteryView:netCallBack(data)
    local ProtobufUtil = require "utils.ProtobufUtil"
    -- print("----ActivityLotteryView:netCallBack--", data)
    if data.result ~= ProtobufUtil:enum_id("ActivitySystem.LuckyLotteryResult", "LuckyLotteryResult_Succeed") then
        if data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn then
            self:stopRun()
        end
        return 
    end
    self:addRefreshNum(#data.rollId)

    if data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn then
        self.bingoIndex = data.rollId[1] + 1
        self.bingoRollId = data.rollId
        self.sendByMail = data.sendByMail
    elseif data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh then
        UI.ScrollBar:createByText(UI.TEXT_1212610)
        self:refreshView()
    elseif data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_RewardLucky then
        self:refreshView()
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
        if activityData == nil then
            print("---netCallBack RewardLucky activityData is null")
            return
        end
        local lotteryData = activityData:getLotteryData()
        if lotteryData == nil then
            print("---netCallBack RewardLucky lotteryData is null")
            return        
        end
        local list = lotteryData:getRewardFromLuckBox(data.rollId)
        local str = UI.TEXT_111030
        if(data.sendByMail == 1) then 
            str = LanguageManager:getInstance():getLocalString(1111068)
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)  
    end
end

function ActivityLotteryView:createItems(list)
    for k, v in ipairs(self.itemList) do
        v:removeFromParent()
    end
    self.itemList = {}
    for k ,v in ipairs(list) do
        local pos = posList[k]
        if pos then
            local lotteryItem = UI.LotteryItem:create(v)
            lotteryItem:setTag(k)
            self.bg:addChild(lotteryItem, 10)
            lotteryItem:leftBottom(pos[1], pos[2])
            table.insert(self.itemList, lotteryItem)
        end
    end
end

function ActivityLotteryView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_REFRESH, self, self.refreshView)
end

function ActivityLotteryView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_LUCKY_LOTTERY_REFRESH, self, self.refreshView)
end

function ActivityLotteryView:playAction(index)
    Avalon.AudioManager:playSound("1507", false)
    if #self.trains == 0 then
        for i = 1, 5 do
            local blink =  UI.Animation:create()
            blink:init("effect_ui_lottery_kuang1.json", "effect_ui_lottery_kuang1.atlas", 1)
            blink:center()
            blink:hide()
            self:addChild(blink, 10)
            table.insert(self.trains, blink)
        end        
    end
    local size = 5
    for k, v in ipairs(self.trains) do
        if size > 0 then
            self:_playAction(v, k, index - k + 1)
        else
            v:hide()
        end
        size = size - 1
    end
end

function ActivityLotteryView:_playAction(blink, level, index)
    index = index % #posList
    index = index == 0 and #posList or index
    local pos = posList[index]
    blink:leftBottom(pos[1] - 15, pos[2] + 34)
    local actName = "idle"..level
    blink:setAnimation(actName, false)
    blink:show()
end

function ActivityLotteryView:playRewardAct(index)
    index = index % #posList
    index = index == 0 and #posList or index
    local pos = posList[index]
    local node = UI.Animation:create()
    node:init("effect_ui_lottery_win.json", "effect_ui_lottery_win.atlas", 1)
    node:center()
    node:leftBottom(pos[1] - 15, pos[2] + 34)
    self:addChild(node, 10)
    node:setAnimation("win_begin", false)
    node:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "win_begin") then
            sender:addAnimation("win_idle", true)
        elseif (event.animation == "win_end") then
            sender:destroy()
        end
    end)
    table.insert(self.rewardAct, node)
end

function ActivityLotteryView:refreshView()
    if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
        return
    end
    self._diamond:setText(GameDataManager:getInstance():getDiamond())

    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        return
    end
    local list = lotteryData:getDropList()
    self:createItems(list)
    local turnTime = lotteryData:getTurnTimes() > 9 and 9 or lotteryData:getTurnTimes()
    self.remainNumber:setSpriteName(string.format("ui_lottery_num_%d.png", turnTime))

    local cost, costItemId = lotteryData:getTurnCost()
    local goodNumber = -1
    if costItemId ~= 0 and costItemId ~= nil then
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costItemId, true)
        local setSpriteName = GoodsDataManager:createLocalGoodsData(costItemId):getSmallIconName()
        self._itemNum:setText(goodNumber)
        self._itemNum:show()
        self._itemImage:show()
        self._itemImage:setSpriteName(setSpriteName) 
        self._itemImage:setScale(22/self._itemImage:getContentSize().width)
    end

    self.oneCostNumber:setFontColor(UI.FONT_COLOR_WHITE)
    self.oneCostNode:show()
    self.oneCostIcon:setScale(1)
    self.oneText:setText(string.format(UI.TEXT_1212437, 1))
    if lotteryData:getRemianRefreshTime() <= 0 then
        self.oneCostNumber:setText(UI.TEXT_1212438)
        self.oneCostNode:hide()
    elseif goodNumber >= 1 then
        self.oneCostIcon:setSpriteName(GoodsDataManager:createLocalGoodsData(costItemId):getSmallIconName()) 
        self.oneCostIcon:setScale(28/self.oneCostIcon:getContentSize().width)
        self.oneCostNumber:setText("1")
    else
        self.oneCostIcon:setSpriteName("symbol_gaming_diamond.png")
        if cost > GameDataManager:getInstance():getDiamond() then
            self.oneCostNumber:setFontColor(UI.FONT_COLOR_RED)
        end
        self.oneCostNumber:setText(cost)
    end

    self.moreCostIcon:setScale(1)
    self.moreCostNumber:setFontColor(UI.FONT_COLOR_WHITE)
    local count = lotteryData:getTurnTimes()
    cost = cost * count
    if goodNumber >= count then
        self.moreCostIcon:setSpriteName(GoodsDataManager:createLocalGoodsData(costItemId):getSmallIconName()) 
        self.moreCostIcon:setScale(28/self.moreCostIcon:getContentSize().width)
        self.moreCostNumber:setText(count)
    else
        self.moreCostIcon:setSpriteName("symbol_gaming_diamond.png")
        if cost > GameDataManager:getInstance():getDiamond() then
            self.moreCostNumber:setFontColor(UI.FONT_COLOR_RED)
        end
        self.moreCostNumber:setText(cost)
    end
    self.moreText:setText(string.format(UI.TEXT_1212437, count))

    if lotteryData:getTurnTimes() <= 0 then
        self.moreCostIcon:setScale(1)
        self.moreCostNumber:setText(0)
        self.moreCostIcon:setSpriteName("symbol_gaming_diamond.png")
        self.moreText:setText(UI.TEXT_1212611)
        
        self.oneCostIcon:setScale(1)
        self.oneCostNumber:setText(0)
        self.oneCostIcon:setSpriteName("symbol_gaming_diamond.png")
        self.oneText:setText(UI.TEXT_1212611)
        self.oneCostNode:show()
    end

    local left = (self.oneCostNode:getParent():getContentSize().width - self.oneCostNode:getContentSize().width - self.oneCostNumber:getContentSize().width - 16) / 2
    self.oneCostNode:leftBottom(left, self.oneCostNode:getBottom())
    self.oneCostNumber:leftBottom(left + self.oneCostNode:getContentSize().width + 8, self.oneCostNumber:getBottom())
    if lotteryData:getTurnTimes() <= 0 then
        
    elseif lotteryData:getRemianRefreshTime() <= 0 then
        self.oneCostNumber:centerBottom(2)
    end

    local left = (self.moreCostNode:getParent():getContentSize().width - self.moreCostNode:getContentSize().width - self.moreCostNumber:getContentSize().width - 16) / 2
    self.moreCostNode:leftBottom(left, self.moreCostNode:getBottom())
    self.moreCostNumber:leftBottom(left + self.moreCostNode:getContentSize().width + 8, self.moreCostNumber:getBottom())
    --luck
    local curLuck, maxLuck = lotteryData:getLuckNum()
    self.luckValue:setText(string.format("%d/%d", curLuck, maxLuck))
    
    local percent = math.floor(curLuck / maxLuck * 15) * 100 / 15
    self.luckPro:setPercentage(percent)
    if percent >= 100 then
        AvalonUtil.playShakeAct(self.luckBtn, true)
    else
        self.luckBtn:stopAllActions()
    end

    if(self._numberText) then 
        self._numberText:setText(string.format(LanguageManager:getInstance():getLocalString(1113620), self:getRefreshNum()))
    end

    for k, v in ipairs(self.rewardAct) do
        v:destroy()
    end
    self.rewardAct = {}
    self:refreshTime(1)
end

function ActivityLotteryView:refreshTime(dt)
    local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        return
    end
    local time = lotteryData:getRemianRefreshTime()
    local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()

    self.remainTimeDt = self.remainTimeDt or 0
    self.remainTimeDt = self.remainTimeDt + dt
    if self.remainTimeDt >= 1 then
        if time > 0 then
            local timeText = AvalonUtil:_getFullFormatTime(time, true)
            self.remainTime:show()
            self.remainTime:setText(timeText)
            self.remainTimeDt = 0
            self.remainTime:rightBottom(210 - self.remainTime:getContentSize().width / 2, self.remainTime:getBottom())
        else
            self.oneCostNumber:setText(UI.TEXT_1212438)
            self.oneCostNumber:centerBottom(2)
            self.oneCostNode:hide()
            self.remainTime:hide()
        end
        local timeText = AvalonUtil:_getFullFormatTime(endTime, true)
        self.actEndTime:setText(string.format(UI.TEXT_1212442, timeText))
    end

end

function ActivityLotteryView:update(dt)
    self:refreshTime(dt)
    local curFps = GameManager:getFps()
    if self.turnStatus == TURN_STATUS.BEGIN then
        return
    elseif self.turnStatus == TURN_STATUS.END then
        return
    elseif self.turnStatus == TURN_STATUS.ACCELERATE then
        -- print("----self.turnStatus----", self.turnStatus)
        self.speed = self.speed + self.aceSpeed / curFps
        if self.speed >= MAX_SPEED then
            self.turnStatus = TURN_STATUS.CONSTANT_SPEED
        end
    elseif self.turnStatus == TURN_STATUS.DECELERATE then
        -- print("----self.turnStatus----", self.turnStatus)
        -- local index = self.index % #posList
       
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
        if self.bingoIndex ~= 0 then
            self.turnStatus = TURN_STATUS.DECELERATE
            local dis = (self.bingoIndex - self.index) % #posList + #posList * 2
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
        self:playAction(self.index)
        self.index = self.index + 1
        self.remainDis = self.remainDis - 1
        self.changeTime = 0
    end
    -- print("-----self.turnStatus = ", self.turnStatus)
end

function ActivityLotteryView:showTurnReward()
    Avalon.AudioManager:playSound("1507", false)
    if self.bingoRollId == nil then
        print("------showTurnReward----", self.bingoRollId)
        return
    end
     local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    if activityData == nil then
        return
    end
    local lotteryData = activityData:getLotteryData()
    if lotteryData == nil then
        return
    end
    
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            for k, v in ipairs(self.trains) do
                v:hide()
            end

            for k, v in ipairs(self.rewardAct) do
                v:destroy()
            end
            self.rewardAct = {}

            for i = 1, #self.bingoRollId do
                local index = self.bingoRollId[i]
                self:playRewardAct(index + 1)
            end
        end
    end, 0.5)

    self.rewardLock = true
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            local list = lotteryData:getTurnReward(self.bingoRollId)
            local str = UI.TEXT_111030
            if(self.sendByMail == 1) then 
                str = LanguageManager:getInstance():getLocalString(1111068)
            end

            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)
        end
    end, 0.6)
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            self.rewardLock = false
        end
    end, 0.7)
end

--多个奖励时的第二 以及之后的奖励
function ActivityLotteryView:twiceTurnCheck(preBingoId)
    self.bingoIndex = 0
    -- print("-----1  ", preBingoId, self.bingoIndex)
    for i = 1, #self.bingoRollId do
        if preBingoId == self.bingoRollId[i] + 1 then
            if self.bingoRollId[i + 1] then
                self.bingoIndex = self.bingoRollId[i + 1] + 1
            end
        end
    end
    -- print("-----1  self.bingoIndex = ", self.bingoIndex)
    if self.bingoIndex ~= 0 then
        self.turnStatus = TURN_STATUS.END
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                for k, v in ipairs(self.trains) do
                    v:hide()
                end
                self:playRewardAct(preBingoId)
                self.itemList[preBingoId]:setIsGray()
            end
        end, 0.4) 
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                self.index = self.index + 1
                self.turnStatus = TURN_STATUS.DECELERATE
                self.runningTime = 0
                self.speed = MAX_SPEED
                local dis = (self.bingoIndex - self.index) % #posList + #posList
                local time = dis / (self.speed / 2)
                self.deSpeed = self.speed / time
                self.remainDis = dis + 1
            end
        end, 1) 
    else
        self.turnStatus = TURN_STATUS.END
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                self:stopRun()
            end
        end, 0.4) 
        self:showTurnReward()
    end
end


function ActivityLotteryView:stopRun()
    for k, v in ipairs(self.trains) do
        v:hide()
    end
    self.changeTime = 0
    self.speed = INIT_SPEED
    self.aceSpeed = ACE_SPEED
    self.deSpeed = 0 -- 每秒跳动增加的格子 
    self.turnStatus = TURN_STATUS.BEGIN
    self.bingoIndex = 0
    self.runningTime = 0
    self.remainDis = 0
    self.box:setAnimation("idle", true)
    self.light:setAnimation("idle", true)
    self:refreshView()
end

function ActivityLotteryView:onTouchBegan(grid,touchPosition)
    
end

function ActivityLotteryView:onTouchEnded(grid,touchPosition)
    if not self.bg:checkTouchPosition(touchPosition) then
        self:closeClick()
    end
end

function ActivityLotteryView:closeClick()
    if self.turnStatus == TURN_STATUS.BEGIN or self.turnStatus == TURN_STATUS.END then
        mvc.closePanel("ActivityLottery", "ActivityLottery")
    end
end

-- 获取刷新的次数
function ActivityLotteryView:getRefreshNum()
    local globalData = GameDataManager:getInstance():getSaveGlobalData()
    if(globalData) then 
        local refreshDay = RoleDataManager:getMaster():getRefreshDay() 
        if(globalData:getLotteryRefreshDay() < refreshDay) then
            globalData:setLotteryRefreshDay(refreshDay)
            globalData:setLotteryRefreshNum(0)
            return 0
        end

        return globalData:getLotteryRefreshNum()
    end

    return 0
end

function ActivityLotteryView:addRefreshNum(addNum)
    local globalData = GameDataManager:getInstance():getSaveGlobalData()
    if(globalData) then 
        globalData:setLotteryRefreshNum(self:getRefreshNum() + addNum)
    end
end

return ActivityLotteryView












