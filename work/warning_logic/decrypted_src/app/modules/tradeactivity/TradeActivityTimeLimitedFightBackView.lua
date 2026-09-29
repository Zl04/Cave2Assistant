------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/19
--desc	: 
------------------------------------------------------------------------------

require "app.datas.RoleDataManager"
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityTimeLimitedFightBackView = class("TradeActivityTimeLimitedFightBackView", UI.HWBtnComponent)
local SceneManager = require("app.game.SceneManager")
local SdkBox = require("utils.sdkbox.SdkBox")

-- 资源
local COM_RES_LIST = {
    "ui_town_businessactivities_turntable.plist"
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

--速度相关的单位 全是 每秒跳动的格子数量
local INIT_SPEED = 10 --初始化速度
local ACE_SPEED = 16  --加速度
local MAX_SPEED  = 20 --最大速度
local TIME_OUT = 15 --转盘请求超时15秒 153, 332
local posList = {{20, 284 - 27}, {84, 284 - 27}, {148, 284 - 27}, {212, 284 - 27},{276, 284 - 27}, {340, 284 - 27}, {404, 284 - 27}, {404, 208 - 20}, {404, 132 - 20}, {404, 56 - 13},
                {340, 56 - 13}, {276, 56 - 13}, {212, 56 - 13}, {148, 56 - 13}, {84, 56 - 13}, {20, 56 - 13}, {20, 132 - 20},{20, 208 - 20}}

function TradeActivityTimeLimitedFightBackView:ctor()
    TradeActivityTimeLimitedFightBackView.super.ctor(
    	self,
    	UI.Type.LIMITED_FIGHT_BACK,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.itemList = {}
    self.trains = {} 
    self.rewardAct = {}
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

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function TradeActivityTimeLimitedFightBackView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityTimeLimitedFightBackView.super.init(self, ... )
end

function TradeActivityTimeLimitedFightBackView:dtor()
    TradeActivityTimeLimitedFightBackView.super.dtor(self)
    self:unbindModel()
    self:setTurnStatus(TURN_STATUS.BEGIN)

    if self.bgHost then
        self.bgHost:removeFromParent()
    end

    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityTimeLimitedFightBackView")
end


function TradeActivityTimeLimitedFightBackView:onInitView()
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
    innerImg:init("ui_turntable_bg_05.png")
    innerImg:center(-7, 2)
    -- leftImg:enableDebugDraw()
    contentLayout:addChild(innerImg)
    local bg = innerImg
    self.bg = innerImg

    -- local light = UI.Animation:create()
    -- light:init("effect_ui_businessactivities_shedeng.json", "effect_ui_businessactivities_shedeng.atlas", 1);
    -- light:leftBottom(250, 10)
    -- bg:addChild(light,999)
    -- light:setAnimation("idle1", true)
    -- self.light = light

    local rocker =  UI.Animation:create()
    rocker:init("effect_ui_lottery_drawbar.json", "effect_ui_lottery_drawbar.atlas", 1);
    rocker:rightBottom(100 + 15, 258 - 26)
    bg:addChild(rocker, 100)
    rocker:setAnimation("idle", false)
    self.rocker = rocker

    
    local numberBackImg = UI.Image:create()
    numberBackImg:init("ui_turntable_labelbg.png")
    numberBackImg:leftBottom(9,333)
    bg:addChild(numberBackImg, 100)

    -- 次数限制
    local text = UI.Text:create()
    text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    text:centerLeft(12, 0)
    numberBackImg:addChild(text, 100)
    self._numberText = text

    -- -- 抽奖卷
    -- local itemImage = UI.Image:create()
    -- itemImage:init("symbol_gaming_207036.png")
    -- itemImage:center(86, -236)
    -- bg:addChild(itemImage)
    -- self._itemImage = itemImage
    -- itemImage:hide()

    -- -- 弹珠数量
    -- self._itemNum = UI.NumberText:create(0, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    -- self._itemNum:setTextLeft()
    -- self._itemNum:leftBottom(450, 444)
    -- bg:addChild(self._itemNum, 4)
    -- self._itemNum:hide()

    -- 弹珠
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_marbles.png")
    diamondImage:leftBottom(548, 456 - 22)
    bg:addChild(diamondImage)

    -- 弹珠数量
    self._diamond = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    self._diamond:setTextLeft()
    self._diamond:leftBottom(576, 456 - 22)
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
    shopButton:leftBottom(642, 454 - 22)
    bg:addChild(shopButton)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
        shopButton:show()
    else
        shopButton:hide()
    end

    -- --当前可抽取次数
    -- local remainText = UI.Text:create()
    -- remainText:init(UI.TEXT_1212439, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_153_153_153)
    -- remainText:setSize(150, 30)
    -- -- remainText:enableDebugDraw()
    -- remainText:setTextCenter()
    -- remainText:center(238, -156)
    -- bg:addChild(remainText)

    -- local remainNumber = UI.Image:create()
    -- remainNumber:init("ui_lottery_num_0.png")
    -- remainNumber:rightBottom(36, 319)
    -- self.remainNumber = remainNumber
    -- bg:addChild(remainNumber)

    --抽取1次按钮
    local oneTimesBtn = UI.Button:create()
    oneTimesBtn:init("ui_btn_yellow15_0.png", "ui_btn_yellow15_1.png", "ui_btn_yellow15_2.png")
    oneTimesBtn:rightBottom(30 + 14, 102 - 20)
    bg:addChild(oneTimesBtn)
    oneTimesBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
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
    oneCostNode:leftBottom(10, 0)
    oneTimesBtn:addChild(oneCostNode, 10)
    self.oneCostNode = oneCostNode

    local oneCostIcon = UI.Image:create()
    oneCostIcon:init("symbol_gaming_marbles.png")
    oneCostIcon:center()
    oneCostNode:addChild(oneCostIcon, 10)
    self.oneCostIcon = oneCostIcon

    local oneCostNumber = UI.Text:create()
    oneCostNumber:init("1", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    oneCostNumber:leftBottom(70 ,2)
    oneTimesBtn:addChild(oneCostNumber, 10)
    self.oneCostNumber = oneCostNumber

    --抽取次数文字
    local oneText = UI.Text:create()
    oneText:init(string.format(UI.TEXT_1212437, 1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    oneText:centerUp(1)
    oneTimesBtn:addChild(oneText, 10)
    self.oneText = oneText

    -- local remainTime = UI.Text:create()
    -- remainTime:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    -- remainTime:rightBottom(30, 156)
    -- bg:addChild(remainTime, 10)
    -- self.remainTime = remainTime

    --抽取10次按钮
    local moreTimeBtn = UI.Button:create()
    moreTimeBtn:init("ui_btn_yellow15_0.png", "ui_btn_yellow15_1.png", "ui_btn_yellow15_2.png")
    moreTimeBtn:rightBottom(30 + 14, 44 - 20)
    bg:addChild(moreTimeBtn)
    moreTimeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
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
    moreCostNode:leftBottom(10, 0)
    moreTimeBtn:addChild(moreCostNode, 10)
    self.moreCostNode = moreCostNode

    local moreCostIcon = UI.Image:create()
    moreCostIcon:init("symbol_gaming_marbles.png")
    moreCostIcon:center()
    moreCostNode:addChild(moreCostIcon, 10)
    self.moreCostIcon = moreCostIcon

    local moreCostNumber = UI.Text:create()
    moreCostNumber:init("10", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    moreCostNumber:leftBottom(70, 2)
    moreTimeBtn:addChild(moreCostNumber, 10)
    self.moreCostNumber = moreCostNumber

    local moreText = UI.Text:create()
    moreText:init(string.format(UI.TEXT_1212437, 10), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    moreText:centerUp(1)
    moreTimeBtn:addChild(moreText, 10)
    self.moreText = moreText

    -- local actEndTime =  UI.Text:create()
    -- actEndTime:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
    -- actEndTime:leftBottom(500, 3)
    -- -- actEndTime:enableDebugDraw()
    -- bg:addChild(actEndTime, 10)
    -- self.actEndTime = actEndTime

    -- local refresTip =  UI.Text:create()
    -- refresTip:init(UI.TEXT_1212447, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    -- refresTip:leftBottom(368, 374)
    -- bg:addChild(refresTip, 10)
    -- self.refresTip = refresTip

    --幸运模块
    local luckBg =  UI.Image:create()
    luckBg:init("ui_turntable_progress_01.png")
    luckBg:leftBottom(90 + 3, 133 - 18)
    bg:addChild(luckBg)

    local luckPro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_turntable_progress_02.png"))
    luckPro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    luckPro:setMidpoint(cc.p(0, 0))
    luckPro:setBarChangeRate(cc.p(1, 0))
    luckPro:setPercentage(0)
    luckPro:setPosition(113, 44)
    luckBg:addChild(luckPro)
    self.luckPro = luckPro

    local luckValue = UI.Text:create()
    luckValue:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    luckValue:leftBottom(100 + 3, 203 - 18)
    bg:addChild(luckValue, 10)
    self.luckValue = luckValue

    local desIcon = UI.Image:create()
    desIcon:init("ui_turntable_icon_lucky.png")
    desIcon:leftBottom(90 + 3,103 - 18)
    bg:addChild(desIcon)

    local desText = UI.Text:create()
	desText:init(LanguageManager:getInstance():getLocalString(1114093),UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
	desText:leftBottom(90 + 30 + 3,106 - 18)
	bg:addChild(desText)

    
    local luckBtn = UI.Button:create()
    luckBtn:init("ui_turntable_treasure.png", "ui_turntable_treasure.png", "ui_turntable_treasure.png")
    luckBtn:rightBottom(280, 136)
    bg:addChild(luckBtn)
    luckBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        --打开反斗商店界面
        self:openFightBackShop()
    end)
    self.luckBtn = luckBtn
    luckBtn:setOpacity(0)

    local luckAnimation = UI.Animation:create()
    luckAnimation:init("effect_ui_businessactivities_baoxiang.json", "effect_ui_businessactivities_baoxiang.atlas", 1)
    luckAnimation:setAnimation("idle1",true)
    luckAnimation:rightBottom(280 + 50 + 24, 136 + 53 - 20)
    bg:addChild(luckAnimation)



 
    local luckTips = UI.Text:create()
    luckTips:init(LanguageManager:getInstance():getLocalString(1112373), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    luckTips:leftBottom(100 + 3, 235 - 18)
    bg:addChild(luckTips, 100)
    self.luckTips = luckTips


    local timeDes = mvc.tradeActivityModel:getActivityOpeningStrByID(PublicDefine.TradeActivityIDList.TradeActivityTimeLimitedFightBack)
    local timeText = UI.Text:create()
    timeText:init(timeDes, UI.FONT_BOLD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_225_225_225)
    timeText:centerBottom(350, 236)
    bg:addChild(timeText, 10)

    --特效
    local birdSp = UI.Animation:create()
    birdSp:init("effect_ui_businessactivities_turntable_bird.json", "effect_ui_businessactivities_turntable_bird.atlas", 1)
    birdSp:centerUp(58,-112)
    birdSp:setAnimation("idle", true)
    bg:addChild(birdSp, 999)

    local lightSp = UI.Animation:create()
    lightSp:init("effect_ui_businessactivities_turntable_light.json", "effect_ui_businessactivities_turntable_light.atlas", 1)
    lightSp:centerUp(40,0)
    lightSp:setAnimation("idle", true)
    bg:addChild(lightSp, 100)
    

    -- local btnRefresh = UI.Button:create()
    -- btnRefresh:init("ui_btn_refresh_0.png", "ui_btn_refresh_1.png", "ui_btn_refresh_2.png")
    -- btnRefresh:leftBottom(340, 374)
    -- bg:addChild(btnRefresh)
    -- btnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     if not (SceneManager:getInstance():isNotInFightScene()) then
    --         UI.ScrollBar:createByText(UI.TEXT_1213665)
    --         return
    --     end

    --     self:refreshClick()
    -- end)

    self:refreshView()

    self:addTouchEvents()
    
end

function TradeActivityTimeLimitedFightBackView:addTouchEvents()

    self.bgHost = cc.Layer:create()
    local scene = cc.Director:getInstance():getRunningScene()
    scene:addChild(self.bgHost,99999999)
    self.bgHost:setTouchEnabled(true)


    local function onTouchBegan(touch, event)  
        return true
    end

    local function onTouchEnded(touch, event)
        if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END and self.setTurnStatus then
            self:setTurnStatus(TURN_STATUS.END)
            Avalon.Scheduler:scheduleUpdateOnce(self, function()  
                if not tolua.isnull(self) then
                    self:stopRun()
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

function TradeActivityTimeLimitedFightBackView:openFightBackShop()
    mvc.openPanel("FightBackShop", "FightBackShop",PublicDefine.StoreType.StoreType_LimitedMarblesFever)
end

function TradeActivityTimeLimitedFightBackView:refreshView()
    if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
        return
    end
    local master = RoleDataManager:getMaster()

    if (not master) then
        return
    end

    local haveNum = master:getMarblesFeverHoodle() or 0
    --更新弹珠数量
    self._diamond:setText(haveNum)

    local list = ConfigManager:getAllLimitedMarblesFever()
    self:createItems(list)

    if haveNum >= 10 then
        self.moreCostNumber:setFontColor(UI.FONT_COLOR_WHITE)
    else
        self.moreCostNumber:setFontColor(UI.FONT_COLOR_RED)
    end

    if haveNum >= 1 then
        self.oneCostNumber:setFontColor(UI.FONT_COLOR_WHITE)
    else
        self.oneCostNumber:setFontColor(UI.FONT_COLOR_RED)
    end
    
    
    --luck
    local curLuck = master:getLimitedMarblesFeverLuckyPoint() or 0
    local maxLuck = ConfigManager:getMarblesLimitedFeverLuckyPoint()

    self.luckValue:setText(string.format("%d/%d", curLuck, maxLuck))
    
    local percent = math.floor(curLuck / maxLuck  * 100)
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
        v:setAnimation("win_end", false)
    end
    self.rewardAct = {}
    
    -- self:refreshTime(1)
end

-- function TradeActivityTimeLimitedFightBackView:refreshTime(dt)
--     local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
--     if activityData == nil then
--         return
--     end
--     local lotteryData = activityData:getLotteryData()
--     if lotteryData == nil then
--         return
--     end
--     local time = lotteryData:getRemianRefreshTime()
--     local endTime = activityData:getEndTime() + GameManager:getEPOCHTime() - GameManager:getNowServerTime()

--     self.remainTimeDt = self.remainTimeDt or 0
--     self.remainTimeDt = self.remainTimeDt + dt
--     if self.remainTimeDt >= 1 then
--         if time > 0 then
--             local timeText = AvalonUtil:_getFullFormatTime(time, true)
--             self.remainTime:show()
--             self.remainTime:setText(timeText)
--             self.remainTimeDt = 0
--             self.remainTime:rightBottom(100 - self.remainTime:getContentSize().width / 2, self.remainTime:getBottom())
--         else
--             self.oneCostNumber:setText(UI.TEXT_1212438)
--             self.oneCostNumber:centerBottom(2)
--             self.oneCostNode:hide()
--             self.remainTime:hide()
--         end
--         local timeText = AvalonUtil:_getFullFormatTime(endTime, true)
--         self.actEndTime:setText(string.format(UI.TEXT_1212442, timeText))
--     end

-- end

function TradeActivityTimeLimitedFightBackView:createItems(list)
    for k, v in ipairs(self.itemList) do
        v:removeFromParent()
    end
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
            lotteryItem:setScale(0.8)
            self.bg:addChild(lotteryItem, 10)
            lotteryItem:leftBottom(pos[1] + 3, pos[2] - 18)
            table.insert(self.itemList, lotteryItem)
        end
    end
end

function TradeActivityTimeLimitedFightBackView:update(dt)
    local curFps = GameManager:getFps()
    if self.turnStatus == TURN_STATUS.BEGIN then
        return
    elseif self.turnStatus == TURN_STATUS.END then
        return
    elseif self.turnStatus == TURN_STATUS.ACCELERATE then
        -- print("----self.turnStatus----", self.turnStatus)
        self.speed = self.speed + self.aceSpeed / curFps
        if self.speed >= MAX_SPEED then
            self:setTurnStatus(TURN_STATUS.CONSTANT_SPEED)
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
            self:setTurnStatus(TURN_STATUS.DECELERATE)
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

function TradeActivityTimeLimitedFightBackView:playAction(index)
    Avalon.AudioManager:playSound("1507", false)
    if #self.trains == 0 then
        for i = 1, 5 do
            local blink =  UI.Animation:create()
            blink:init("effect_ui_lottery_kuang1.json", "effect_ui_lottery_kuang1.atlas", 1)
            blink:center()
            blink:setScale(0.8)
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

function TradeActivityTimeLimitedFightBackView:_playAction(blink, level, index)
    index = index % #posList
    index = index == 0 and #posList or index

    local pos = posList[index]
    -- blink:leftBottom(pos[1] + 26, pos[2] + 2)
    blink:leftBottom(pos[1] + 20, pos[2] + 5)
    local actName = "idle"..level
    blink:setAnimation(actName, false)
    blink:show()
end

function TradeActivityTimeLimitedFightBackView:stopRun()
    for k, v in ipairs(self.trains) do
        v:hide()
    end
    self.changeTime = 0
    self.speed = INIT_SPEED
    self.aceSpeed = ACE_SPEED
    self.deSpeed = 0 -- 每秒跳动增加的格子 
    self:setTurnStatus(TURN_STATUS.BEGIN)
    self.bingoIndex = 0
    self.runningTime = 0
    self.remainDis = 0
    self.tIndex = 0
    -- self.light:setAnimation("idle1", true)
    self:refreshView()
end

--多个奖励时的第二 以及之后的奖励
function TradeActivityTimeLimitedFightBackView:twiceTurnCheck(preBingoId)
    self.bingoIndex = 0
    self.tIndex = self.tIndex + 1
    print("-----1  ", preBingoId, self.bingoIndex)
    -- for i = 1, #self.bingoRollId do
    --     if preBingoId == self.bingoRollId[i] + 1 then
    --         if self.bingoRollId[i + 1] then
    --             self.bingoIndex = self.bingoRollId[i + 1] + 1
    --         end
    --     end
    -- end
    if self.bingoRollId[self.tIndex + 1] then
        self.bingoIndex = self.bingoRollId[self.tIndex + 1]
    end
    
    print("-----1  self.bingoIndex = ", self.bingoIndex)
    if self.bingoIndex ~= 0 then
        self:setTurnStatus(TURN_STATUS.END)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                for k, v in ipairs(self.trains) do
                    v:hide()
                end
                self:playRewardAct(preBingoId)
                -- self.itemList[preBingoId]:setIsGray()
            end
        end, 0.4) 
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                self.index = self.index + 1
                self:setTurnStatus(TURN_STATUS.DECELERATE)
                self.runningTime = 0
                self.speed = MAX_SPEED
                local dis = (self.bingoIndex - self.index) % #posList + #posList
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
            end
        end, 0.4) 
        self:showTurnReward()
    end
end

function TradeActivityTimeLimitedFightBackView:showTurnReward()
    Avalon.AudioManager:playSound("1507", false)
    if self.bingoRollId == nil then
        print("------showTurnReward----", self.bingoRollId)
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

            -- for i = 1, #self.bingoRollId do
            --     local index = self.bingoRollId[i]
            --     self:playRewardAct(index)
            -- end
        end
    end, 0.5)

    self.rewardLock = true
    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
        if not tolua.isnull(self) then
            local list = {}--lotteryData:getTurnReward(self.bingoRollId)

            for id,gData in ipairs(self.bingoRollId) do
                local conf = ConfigManager:getLimitedMarblesFeverByID(gData)
                local goodsData = GoodsDataManager:createLocalGoodsData(conf.goodsID)
                local goodsNum = conf.goodsNum
                goodsData:setIsGolden(true)
                goodsData:setNum(goodsNum)
                table.insert(list,goodsData)
            end
            
            local str = UI.TEXT_111030
            print("self.sendByMail ===== ",self.sendByMail)
            if(self.sendByMail) then 
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

function TradeActivityTimeLimitedFightBackView:playRewardAct(index)
    index = index % #posList
    index = index == 0 and #posList or index
    local pos = posList[index]
    local node = UI.Animation:create()
    node:init("effect_ui_lottery_win.json", "effect_ui_lottery_win.atlas", 1)
    node:center()
    node:setScale(0.8)
    -- node:leftBottom(pos[1] + 26, pos[2] + 2)
    node:leftBottom(pos[1] + 20, pos[2] + 5)
    self:addChild(node, 10)
    node:setAnimation("win_begin", false)
    node:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "win_begin") then
            sender:addAnimation("win_idle", true)
        elseif (event.animation == "win_end") then
            sender:destroy()
        end
    end)
    -- print("  caocaocaoc   ==== ",#self.rewardAct)
    table.insert(self.rewardAct, node)
end

function TradeActivityTimeLimitedFightBackView:turnClick(isSingle)

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

    local useNum = 1
    local cost = 1
    local haveNum = master:getMarblesFeverHoodle() or 0
    if not isSingle then
        useNum = 10
        cost = 10
    end
    if(self:getRefreshNum() + useNum >= maxNum) then 
        UI.ScrollBar:createByTextID(1113622)
        return
    end

    if haveNum < useNum then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170319))
        return
    end
    
    if isSingle then
        self.rocker:setAnimation("begin1", false)
    else
        self.rocker:setAnimation("begin2", false)
    end
    -- self.light:setAnimation("idle2", true)
    Avalon.AudioManager:playSound("1554", false)

    self.runningTime = 0
    self:setTurnStatus(TURN_STATUS.ACCELERATE)
    for k, v in ipairs(self.trains) do
        v:show()
    end
    -- for k, v in ipairs(self.rewardAct) do
    --     v:addAnimation("win_end", false)
    -- end
    -- self.rewardAct = {}

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    if isSingle then
        Net.NetPlaySystem:requestLimitedMarblesFeverDraw(1)
    else
        Net.NetPlaySystem:requestLimitedMarblesFeverDraw(2)
    end

    self.touchListener:setSwallowTouches(true)

end

-- 获取刷新的次数
function TradeActivityTimeLimitedFightBackView:getRefreshNum()
    local master = RoleDataManager:getMaster()
    if (master) then
        return master:getLimitedMarblesFeverDrawCount() or 0
    end

    return 0
end

function TradeActivityTimeLimitedFightBackView:netCallBack(data)
    -- local ProtobufUtil = require "utils.ProtobufUtil"
    -- -- print("----TradeActivityTimeLimitedFightBackView:netCallBack--", data)
    -- if data.result ~= ProtobufUtil:enum_id("ActivitySystem.LuckyLotteryResult", "LuckyLotteryResult_Succeed") then
    --     if data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn then
    --         self:stopRun()
    --     end
    --     return
    -- end
    -- self:addRefreshNum(#data.rollId)

    -- if data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Turn then
    --     self.bingoIndex = data.rollId[1] + 1
    --     self.bingoRollId = data.rollId
    --     self.sendByMail = data.sendByMail
    -- elseif data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_Refresh then
    --     UI.ScrollBar:createByText(UI.TEXT_1212610)
    --     self:refreshView()
    -- elseif data.optType == PublicDefine.LuckyLotteryOptType.LuckyLotteryOptType_RewardLucky then
    --     self:refreshView()
    --     local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
    --     if activityData == nil then
    --         print("---netCallBack RewardLucky activityData is null")
    --         return
    --     end
    --     local lotteryData = activityData:getLotteryData()
    --     if lotteryData == nil then
    --         print("---netCallBack RewardLucky lotteryData is null")
    --         return        
    --     end
    --     local list = lotteryData:getRewardFromLuckBox(data.rollId)
    --     local str = UI.TEXT_111030
    --     if(data.sendByMail == 1) then 
    --         str = LanguageManager:getInstance():getLocalString(1111068)
    --     end

    --     Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)  
    -- end

    print( " data.sendToMail ===== ",data.sendToMail)
    self.bingoIndex = data.awards[1]
    self.bingoRollId = data.awards
    self.sendByMail = data.sendToMail

    -- local list = {}

    -- local itemID = 0
    -- local goodsData = GoodsDataManager:createLocalGoodsData(itemID)
    -- table.insert(list,goodsData)

    -- local str = UI.TEXT_111030
    -- if(data.sendByMail == 1) then 
    --     str = LanguageManager:getInstance():getLocalString(1111068)
    -- end

    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, list, nil, str, nil)  
end

function TradeActivityTimeLimitedFightBackView:setTurnStatus(status)
    self.turnStatus = status

    if self.touchListener then
        if self.turnStatus ~= TURN_STATUS.BEGIN and self.turnStatus ~= TURN_STATUS.END then
            self.touchListener:setSwallowTouches(true)
        else
            self.touchListener:setSwallowTouches(false)
        end
    end
end

function TradeActivityTimeLimitedFightBackView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_FIGHT_BACK_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
end


function TradeActivityTimeLimitedFightBackView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_FIGHT_BACK_RESULT, self, self.netCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshView)
end





return TradeActivityTimeLimitedFightBackView

























