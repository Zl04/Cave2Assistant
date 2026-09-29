------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/01/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SFSignView = class("SFSignView", UI.HWBtnComponent)

require "app.modules.sfsign.SFSignSVCell"

local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_festivalsign.plist",
    "ui_common_btn.plist",
    "ui_common_information.plist",
}

local monthMap = {
    UI.TEXT_1213831, UI.TEXT_1213832, UI.TEXT_1213833, UI.TEXT_1213834, UI.TEXT_1213835, UI.TEXT_1213836,
    UI.TEXT_1213837, UI.TEXT_1213838, UI.TEXT_1213839, UI.TEXT_1213840, UI.TEXT_1213841, UI.TEXT_1213842}

local COM_WIDTH = 988
local COM_HEIGHT = 564
local ZOrder = 1
local winSize = cc.Director:getInstance():getWinSize()

local rewardsPos = {
    {125},
    {86, 164},
    {46, 125, 204},
    {8, 86, 164, 242},
}

--[[
    1:异鼠表现
    2:牛年
    3:虎年
    4:蛇年
]]
local SFSkinType = 4

function SFSignView:ctor()
    SFSignView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(GameMessage.MC_UI_SFSIGN_CELL_CLICK, self, self.cellClick)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.signOver)

    self.checkDay = os.date("!*t", GameManager:getNowServerTime())

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

function SFSignView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.sfsign", "SFSign", false)
    SFSignView.super.init(self, ... )
end

function SFSignView:dtor()
    SFSignView.super.dtor(self)
    self:unbindModel()

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end

    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SFSIGN_CELL_CLICK, self, self.cellClick)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SFSIGN_SIGN_OK, self, self.signOver)

    reload_script_file_mvc("app.modules.sfsign.SFSignView")
end

function SFSignView:updateOncePerSecond()
    local curTime = os.date("!*t", GameManager:getNowServerTime())
    if (not tolua.isnull(self)) then 
        if (curTime.year > self.checkDay.year) or
            (curTime.year == self.checkDay.year and curTime.month > self.checkDay.month) or
            (curTime.year == self.checkDay.year and curTime.month == self.checkDay.month and curTime.day > self.checkDay.day) then
                if not self.reseted then
                    self.reseted = true
                    self:resetDay()
                end
        end
    end
end

function SFSignView:resetDay()
    self.cacheDayList = mvc.sFSignModel:getAllDays()
    self.cellList = {}
    self.cellIdx = 1

    self.scrollContent:removeAllChildren()

    self:initScrollView()

    performWithDelay(self, function()
        self.curDayCell:cellClick()
        self:updateAllDetails()
    end, 0)
end

function SFSignView:onInitView()
    self.cacheDayList = mvc.sFSignModel:getAllDays()
    self.cellList = {}
    self.cellIdx = 1
    self.reseted = false

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask, ZOrder)
    ZOrder = ZOrder + 1;

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_town_festivalsign_bg.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;

    self:initBGImage()
    self:initLeftPanel()
    self:initScrollView()
    self:initRewardPanel()
    if(SFSkinType == 1) then
        self:playRatEff1()
        self:playRatEff2()
    elseif SFSkinType == 2 then 
        self:playNiuEff()
    -- elseif SFSkinType == 3 then
    --     self:playTigerEff()
    end

    performWithDelay(self, function()
        self.curDayCell:cellClick()
        self:updateAllDetails()
    end, 0)
end

function SFSignView:initBGImage()
    local titleImg  = UI.Image:create();
    titleImg:init("ui_town_festivalsign_title.png");
    titleImg:centerUp(-26);
    self.contentLayout:addChild(titleImg, ZOrder);

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1213843, UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_255_222_171)
    titleText:setWidth(400)
    titleText:setTextCenter()
    titleText:autoAdapt()
    titleText:centerUp(20)
    titleImg:addChild(titleText)


    local innerLayout = UI.Layout:create();
    innerLayout:init()
    innerLayout:setSize(732, 408)
    innerLayout:center(0, 0)
    self.contentLayout:addChild(innerLayout, ZOrder)


    local leftPanel  = UI.Image:create();
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        leftPanel:init("ui_town_festivalsign_calendar_global.png");
    else
        leftPanel:init("ui_town_festivalsign_calendar.png");
    end
    leftPanel:leftBottom(0, 0);
    innerLayout:addChild(leftPanel, 200);
    self.leftPanel = leftPanel


    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:setSize(#self.cacheDayList*80, 150)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(440, 150)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:rightUp(0, 20)
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, function()
        self.movingBegin = true
        self.initPos = 0
    end)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, function(self, percent, currentPostion)
        if self.movingBegin and self.initPos == 0 then
            self.initPos = currentPostion
        end
    
        if math.abs(currentPostion - self.initPos) > 0.03 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SFSIGN_SCROLLING)
        end
    end)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self, function()
        self.movingBegin = false
        self.initPos = 0
    end)
    scrollView:addEventListener(UIEvent.SCROLL_VIEW_AUTOSCROLL_ENDED, self, function()
        self.movingBegin = false
        self.initPos = 0
    end)

    scrollView:addInnerNode(scrollContent)
    innerLayout:addChild(scrollView, 200)
    scrollView:scrollToLeft()
    self.scrollView = scrollView
    self.scrollContent = scrollContent

    local mask  = UI.Image:create();
    mask:init("ui_town_festivalsign_mask.png");
    mask:rightUp(0, 14);
    innerLayout:addChild(mask, 201);

    if(SFSkinType == 1) then
        local ratpos1 = {0, 160, -130}
        local ratpos2 = {0, -140, 10}
        local rand = math.random(1, 3)
        local rat1 = UI.Animation:create()
        rat1:init("effect_ui_twon_qiandao_rat.json", "effect_ui_twon_qiandao_rat.atlas", 1);
        rat1:rightUp(210+ratpos1[rand], 20)
        innerLayout:addChild(rat1, 199)
        self.rat1 = rat1

        local rat2 = UI.Animation:create()
        rat2:init("effect_ui_twon_qiandao_rat.json", "effect_ui_twon_qiandao_rat.atlas", 1);
        if rand == 1 then
            rat2:setScaleX(-1)
        end
        rat2:rightUp(370+ratpos2[rand], 20)
        innerLayout:addChild(rat2, 199)
        self.rat2 = rat2

        local ratHead1 = UI.Animation:create()
        ratHead1:init("effect_ui_twon_qiandao_rathead.json", "effect_ui_twon_qiandao_rathead.atlas", 1);
        ratHead1:rightUp(210+ratpos1[rand], 20)
        innerLayout:addChild(ratHead1, 201)
        self.ratHead1 = ratHead1

        local ratHead2 = UI.Animation:create()
        ratHead2:init("effect_ui_twon_qiandao_rathead.json", "effect_ui_twon_qiandao_rathead.atlas", 1);
        if rand == 1 then
            ratHead2:setScaleX(-1)
        end
        ratHead2:rightUp(370+ratpos2[rand], 20)
        innerLayout:addChild(ratHead2, 201)
        self.ratHead2 = ratHead2

        self.rat1:setAnimation("idle", false)
        self.ratHead1:setAnimation("idle", false)
        self.rat2:setAnimation("idle2", false)
        self.ratHead2:setAnimation("idle2", false)
    elseif SFSkinType == 2 then
        self.niuIndex = 0
        local leftNiu = UI.Animation:create()
        leftNiu:init("effect_ui_town_qiandao_xiaoniu.json", "effect_ui_town_qiandao_xiaoniu.atlas", 1);
        leftNiu:rightUp(570, 36)
        innerLayout:addChild(leftNiu, 199)
        self.leftNiu = leftNiu

        local rightNiu = UI.Animation:create()
        rightNiu:init("effect_ui_town_qiandao_niu.json", "effect_ui_town_qiandao_niu.atlas", 1);
        rightNiu:rightUp(160, 36)
        innerLayout:addChild(rightNiu, 199)
        self.rightNiu = rightNiu

        leftNiu:setAnimation("idle1_qiu", true)
        rightNiu:setAnimation("idle1", true)
    elseif SFSkinType == 3 then
        -- local upTiger = UI.Animation:create()
        -- upTiger:init("effect_ui_twon_qiandao_pillow02.json", "effect_ui_twon_qiandao_pillow02.atlas", 1);
        -- upTiger:rightUp(0, 36)
        -- innerLayout:addChild(upTiger, 199)
        -- self.upTiger = upTiger

        -- local downTiger = UI.Animation:create()
        -- downTiger:init("effect_ui_twon_qiandao_pillow01.json", "effect_ui_twon_qiandao_pillow01.atlas", 1);
        -- downTiger:leftBottom(0, -10)
        -- innerLayout:addChild(downTiger, 201)
        -- self.downTiger = downTiger

        local long = UI.Animation:create()
        long:init("effect_ui_twon_qiandao_dragon.json", "effect_ui_twon_qiandao_dragon.atlas", 1);
        long:rightUp(300, 30)
        innerLayout:addChild(long, 199)
        self.long = long
        long:setAnimation("idle", true)

        -- self.upTiger:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
        --     if event.animation == "idle" then
        --         self.upTiger:hide()
        --         self.downTiger:show()
        --         self.downTiger:setAnimation("idle", false)
        --     end
        -- end)

        -- self.downTiger:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
        --     if event.animation == "idle" then
        --         self.upTiger:show()
        --         self.upTiger:setAnimation("idle", false)
        --         self.downTiger:hide()
        --     end
        -- end)

        -- self.upTiger:setAnimation("idle", false)
        -- self.upTiger:show()
        -- self.downTiger:hide()
        -- self.downTiger:setScaleX(-1)

        self.fireworksAnimation = UI.Animation:create()
        self.fireworksAnimation:init("effect_ui_town_festival_fireworks2021.json", "effect_ui_town_festival_fireworks2021.atlas", 1);
        self.fireworksAnimation:centerUp(0, 0)
        innerLayout:addChild(self.fireworksAnimation, 9999)
        self.fireworksAnimation:hide()

        self.fireworksAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event)
            if event.animation == "idle" then
                self.fireworksAnimation:hide()
            end
        end)

    elseif SFSkinType == 4 then

        local sheNian = UI.Animation:create()
        sheNian:init("effect_ui_twon_qiandao_snake.json", "effect_ui_twon_qiandao_snake.atlas", 1);
        sheNian:center()
        innerLayout:addChild(sheNian, 199)
        sheNian:setAnimation("idle", true)
    end

    local rewardBG  = UI.Image:create();
    rewardBG:init("ui_town_festivalsign_reward_bg.png");
    rewardBG:rightBottom(0, 0);
    innerLayout:addChild(rewardBG);
    self.rewardPanel = rewardBG

    local rewardTitleImg  = UI.Image:create();
    rewardTitleImg:init("ui_town_festivalsign_reward_title.png");
    rewardTitleImg:centerUp(20);
    rewardBG:addChild(rewardTitleImg);

    local rewardTitle = UI.Text:create()
    rewardTitle:init("", UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    rewardTitle:setWidth(200)
    rewardTitle:setTextCenter()
    rewardTitle:autoAdapt()
    rewardTitle:center()
    -- rewardTitle:enableDebugDraw()
    rewardTitleImg:addChild(rewardTitle)
    self.rewardTitle = rewardTitle
end

function SFSignView:initLeftPanel()
    local month = UI.Text:create()
    month:init("", UI.FONT_STANDARD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_41_41_45)
    month:setWidth(100)
    month:setTextCenter()
    month:autoAdapt()
    month:leftUp(84, 54)
    self.leftPanel:addChild(month)
    self.monthText = month

    local day = UI.Text:create()
    day:init("", UI.FONT_BOLD, UI.FONT_SIZE_90PX, UI.FONT_COLOR_41_41_45)
    day:setWidth(200)
    day:setTextCenter()
    day:autoAdapt()
    day:leftUp(36, 110)
    self.leftPanel:addChild(day)
    self.dayText = day

    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        return
    end

    local textOne = UI.Text:create()
    textOne:init(UI.TEXT_1213848, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    textOne:setWidth(58)
    textOne:setTextCenter()
    textOne:autoAdapt()
    textOne:leftBottom(18, 126)
    self.leftPanel:addChild(textOne)

    local textTwo = UI.Text:create()
    textTwo:init(UI.TEXT_1213849, UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    textTwo:setWidth(58)
    textTwo:setTextCenter()
    textTwo:autoAdapt()
    textTwo:rightBottom(30, 126)
    self.leftPanel:addChild(textTwo)

    local textLeftLayout = UI.Layout:create();
    textLeftLayout:init()
    textLeftLayout:setSize(56, 68)
    textLeftLayout:leftBottom(19, 46)
    self.leftPanel:addChild(textLeftLayout)

    local textLeft = UI.Text:create()
    textLeft:init("", UI.FONT_BOLD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_41_41_45)
    textLeft:setWidth(58)
    textLeft:setTextCenter()
    textLeft:autoAdapt()
    textLeft:center()
    textLeft:setLineSpacing(6)
    textLeftLayout:addChild(textLeft)
    self.textLeft = textLeft

    local textUp = UI.Text:create()
    textUp:init("", UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    textUp:setWidth(106)
    textUp:setTextCenter()
    textUp:autoAdapt()
    textUp:leftBottom(84, 90)
    self.leftPanel:addChild(textUp)
    self.textUp = textUp

    local textDown = UI.Text:create()
    textDown:init("", UI.FONT_BOLD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_41_41_45)
    textDown:setWidth(114)
    textDown:setTextCenter()
    textDown:autoAdapt()
    textDown:leftBottom(80, 32)
    textDown:setLineSpacing(-4)
    self.leftPanel:addChild(textDown)
    self.textDown = textDown

    local textRightLayout = UI.Layout:create();
    textRightLayout:init()
    textRightLayout:setSize(56, 68)
    textRightLayout:rightBottom(28, 46)
    self.leftPanel:addChild(textRightLayout)

    local textRight = UI.Text:create()
    textRight:init("", UI.FONT_BOLD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_41_41_45)
    textRight:setWidth(58)
    textRight:setTextCenter()
    textRight:autoAdapt()
    textRight:center()
    textRight:setLineSpacing(6)
    textRightLayout:addChild(textRight)
    self.textRight = textRight
end

function SFSignView:initScrollView()
    -- 定位到今天
    local todayDate = os.date("!*t", GameManager:getNowServerTime())

    for k, v in ipairs(self.cacheDayList) do
        local cell = UI.SFSignSVCell:create()
        cell:init(v)
        cell:leftUp(80*(k-1)+40, 75)
        self.scrollContent:addChild(cell, 1)
        cell:setTouchClipNode(self.scrollView)

        table.insert(self.cellList, cell)

        if v.date.year == todayDate.year and
            v.date.month == todayDate.month and
            v.date.day == todayDate.day then
            self.cellIdx = k
        end
    end

    local percent = 0
    if self.cellIdx <= 3 then
        percent = 0
    elseif self.cellIdx > 3 and self.cellIdx < #self.cacheDayList - 3 then
        percent = (self.cellIdx-3.25)/(#self.cacheDayList-5.5)*100
    else
        percent = 100
    end

    performWithDelay(self, function()
        self.scrollView:scrollToPercentHorizontal(percent)
    end, 0)

    self.lastDay = self.cacheDayList[self.cellIdx]
    self.curDay = self.cacheDayList[self.cellIdx]
    self.lastDayCell = self.cellList[self.cellIdx]
    self.curDayCell = self.cellList[self.cellIdx]
end

function SFSignView:initRewardPanel()
    local rewardLayout = UI.Layout:create();
    rewardLayout:init()
    rewardLayout:setSize(318, 78)
    rewardLayout:centerUp(64)
    self.rewardPanel:addChild(rewardLayout)
    self.rewardLayout = rewardLayout

    local signBtn = UI.Button:create();
    signBtn:init("ui_btn_orange6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png");
    signBtn:centerBottom(20);
    signBtn:closeClickScale()
    signBtn:setText(UI.TEXT_1213852)
    signBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    signBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:gotoSign()
    end)
    self.rewardPanel:addChild(signBtn)
    self.signBtn = signBtn

    local costLayer = UI.Layout:create();
    costLayer:init()
    costLayer:enableAutoWidth()
    costLayer:enableAutoHeight()
    costLayer:center()
    signBtn:addChild(costLayer, 10)
    self.costLayer = costLayer

    local costImg  = UI.Image:create();
    costImg:init("symbol_gaming_diamond.png");
    costImg:floatLeft(0)
    costLayer:addComponent(costImg, 10)
    self.signCostImg = costImg

    local costTxt = UI.Text:create()
    costTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    costTxt:floatLeft(10)
    costLayer:addComponent(costTxt, 10)
    self.signCostText = costTxt
end

function SFSignView:updateRewardPanel()
    self.rewardLayout:removeAllChildren()

    for k, v in ipairs(self.curDay.cfg.rewardID) do
        local goodsData = GoodsDataManager:createLocalGoodsData(v)
        local rewardNum = self.curDay.cfg.rewardNum[k] or 1
        goodsData:setNum(rewardNum)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:centerLeft(rewardsPos[#self.curDay.cfg.rewardID][k])
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)

        self.rewardLayout:addChild(goodsGrid)
    end
end

function SFSignView:cellClick(idx)
    if idx == self.cellIdx then
        return
    end

    self.curDay = self.cacheDayList[idx]
    self.cellIdx = idx

    self.lastDayCell:clearSelect()

    self.lastDayCell = self.cellList[idx]

    local pageEff = self.leftPanel:getChildByName("PageEff")
    if not pageEff then
        pageEff = UI.Animation:create()
        if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
            pageEff:init("effect_ui_twon_qiandao_fanye_global.json", "effect_ui_twon_qiandao_fanye_global.atlas", 1);
        else
            pageEff:init("effect_ui_twon_qiandao_fanye.json", "effect_ui_twon_qiandao_fanye.atlas", 1);
        end
        pageEff:center()
        pageEff:setName("PageEff")
        self.leftPanel:addChild(pageEff, 100)

        pageEff:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
            if(event and event.eventData) then
                if event.eventData.name == "show" then
                    self:updateAllDetails()
                end
            end
        end)
    end

    pageEff:stopAllActions()
    pageEff:setAnimation("idle", false)
end

function SFSignView:updateAllDetails()
    -- leftpanel
    self.monthText:setText(monthMap[self.curDay.date.month])
    self.dayText:setText(tostring(self.curDay.date.day))

    if CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL then
        self.textLeft:setText(self.curDay.txtLeft)
        self.textRight:setText(self.curDay.txtRight)
        self.textUp:setText(self.curDay.txtUp)
        self.textDown:setText(self.curDay.txtDown)
    end

    self:updateRewardPanel()

    self:updateSignStateShow()
end

function SFSignView:updateSignStateShow()
    -- 1:过去已签，2:过去未签，3:今日已签，4:今日未签，5:未来
    if self.curDay.signState == 1 then
        self.rewardTitle:setText(UI.TEXT_1213844)
        self.signBtn:disable()
        self.signBtn:setText(UI.TEXT_1213850)
        self.costLayer:hide()
    elseif self.curDay.signState == 2 then
        self.rewardTitle:setText(UI.TEXT_1213845)
        self.signBtn:enable()
        self.signBtn:setText("")
        self.costLayer:show()

        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(self.curDay.cfg.resignCost[1]))
        self.signCostImg:setSpriteName(goodsData:getSmallIconName())
        self.signCostText:setText(tostring(self.curDay.cfg.resignCost[2]))
        self.costLayer:updateView()
    elseif self.curDay.signState == 3 then
        self.rewardTitle:setText(UI.TEXT_1213844)
        self.signBtn:setText(UI.TEXT_1213850)
        self.signBtn:disable()
        self.costLayer:hide()
    elseif self.curDay.signState == 4 then
        self.rewardTitle:setText(UI.TEXT_1213846)
        self.signBtn:setText(UI.TEXT_1213852)
        self.signBtn:enable()
        self.costLayer:hide()
    elseif self.curDay.signState == 5 then
        self.rewardTitle:setText(UI.TEXT_1213847)
        self.signBtn:setText(UI.TEXT_1213853)
        self.signBtn:disable()
        self.costLayer:hide()
    end
end

function SFSignView:gotoSign()
    if self.curDay.signState == 1 or self.curDay.signState == 3 or self.curDay.signState == 5 then
        return
    end

    local needBagNum = 0
    local needStarNum = 0
    for k, v in ipairs(self.curDay.cfg.rewardID) do
        local goodsData = GoodsDataManager:createLocalGoodsData(v)
        if goodsData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
            needBagNum = needBagNum + 1
        end
        if goodsData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
            needStarNum = needStarNum + 1
        end
    end

    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum < needBagNum then
        UI.ScrollBar:createByTextID(1111800)
        return
    end

    if not mvc.starPrayModel:isHaveFreePos(needStarNum) then
        UI.ScrollBar:createByText(languageManagerInstance:getLocalString(1170218))
        return
    end

    if self.curDay.signState == 2 then
        -- 补签
        if Avalon.MathUtil:checkDiamonEnough(tonumber(self.curDay.cfg.resignCost[2]), GameDataManager:getInstance():getDiamond()) then
            local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), true)
            if isNotice then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1213855, function(isSelect)
                    if isSelect then
                        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), false)  
                    end
                    Net.NetLogicSystem:requestSpringFestivalSign(1, self.curDay.cfg.ID)

                    if self.fireworksAnimation then
                        self.fireworksAnimation:show()
                        self.fireworksAnimation:setAnimation("idle", false)
                    end

                end, function(isSelect)
                end, nil, nil, true, tonumber(self.curDay.cfg.resignCost[2]))
            else
                Net.NetLogicSystem:requestSpringFestivalSign(1, self.curDay.cfg.ID)

                if self.fireworksAnimation then
                    self.fireworksAnimation:show()
                    self.fireworksAnimation:setAnimation("idle", false)
                end

            end
        else
            -- 钻石不足
            local tips = UI.TipsLayer:onDiamondNotEnough()
            if(tips) then 
                tips:setZOrder(UI_ZORDER.MAX)
            end
            tips:removeFromParent(false)
            UI.UIManager:getRootNode():addChild(tips)
        end
    else
        Net.NetLogicSystem:requestSpringFestivalSign(0, self.curDay.cfg.ID)

        if self.fireworksAnimation then
            self.fireworksAnimation:show()
            self.fireworksAnimation:setAnimation("idle", false)
        end

    end
end

function SFSignView:signOver(day)
    self.cacheDayList = mvc.sFSignModel:getAllDays()
    self.curDay = self.cacheDayList[self.cellIdx]

    self:updateSignStateShow()
    self:popRewards()
end

function SFSignView:popRewards()
    local itemData = {}
    for k, v in ipairs(self.curDay.cfg.rewardID) do
        local goodData = GoodsDataManager:createLocalGoodsData(v)
        if(goodData) then
            goodData:setIsNew(false)
            goodData:setNum(self.curDay.cfg.rewardNum[k])
            table.insert(itemData, goodData)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, nil, nil, nil, true)
end

function SFSignView:playRatEff1()
    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self.rat1:setAnimation("idle", false)
        self.ratHead1:setAnimation("idle", false)
        

        self:playRatEff1()
    end, math.random(6, 8))
end

function SFSignView:playRatEff2()
    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        self.rat2:setAnimation("idle2", false)
        self.ratHead2:setAnimation("idle2", false)

        self:playRatEff2()
    end, math.random(6, 12))
end

function SFSignView:playNiuEff()
    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end
        
        if math.fmod(self.niuIndex, 2) == 0 then
            self.leftNiu:setAnimation("dingqiu", false)
            self.leftNiu:addAnimation("idle1", true)

            self.rightNiu:setAnimation("jieqiu", false)
            self.rightNiu:addAnimation("idle1_qiu", true)
        else
            self.rightNiu:setAnimation("dingqiu", false)
            self.rightNiu:addAnimation("idle1", true)

            self.leftNiu:setAnimation("jieqiu", false)
            self.leftNiu:addAnimation("idle1_qiu", true)
        end

        self.niuIndex = self.niuIndex + 1
        self:playNiuEff()
    -- end, math.random(1, 3))
    end, math.random(6, 8))
end

function SFSignView:playTigerEff()
    

end

function SFSignView:bindModel()

end


function SFSignView:unbindModel()

end

return SFSignView
