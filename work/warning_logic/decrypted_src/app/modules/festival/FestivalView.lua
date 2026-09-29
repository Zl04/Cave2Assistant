------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FestivalView = class("FestivalView", UI.HWBtnComponent)
local ProtobufUtil = require "utils.ProtobufUtil"

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_town_festival.plist",
    "ui_town_festival_hitrat.plist",
    "ui_town_activity.plist"
}

local COM_WIDTH = 960
local COM_HEIGHT = 590
local layoutUU
local ZOrder = 1
local winSize = cc.Director:getInstance():getWinSize()

function FestivalView:ctor()
    FestivalView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("FestivalView","app.modules.festival.FestivalPosConfig", false)

    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.cancelMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.cdCancelMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.getRewardCallback)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
end

function FestivalView:dtor()
    FestivalView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.festival.FestivalView")

    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.cancelMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.cdCancelMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.getRewardCallback)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
end

function FestivalView:initData()
    self.tabIndex = 1
    self.oldTabIndex = 0
    self.effState = 0
    self.playingEff = false
    self.isGotGift = false
    self.isMatching = false

    -- 容错处理
    MasterDataManager:requestAllActivityWebLanguage(handler(self, self.refreshWebLanguageBack))
    Net.NetGuildSystem:reqActivityCount()

    local dataArr = MasterDataManager:getActivityDataArr()
    local actData = nil
    self.festivalData = nil
    for k, v in pairs(dataArr) do
        if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
            self.festivalData = v
            break
        end
    end

    if not self.festivalData then
        print("self.festivalData is nil")
        return
    end

    self.festivalList = self.festivalData:getFestivalData():getFestivalList()

    -- 当前tab所在页活动的配置
    self.curTabActData = self.festivalList[self.tabIndex]

    local roomData = mvc.festivalModel:getCurJoinData()
    if roomData.activityID and roomData.activityID > 0 and roomData.mapID == self.curTabActData.mapID and not roomData.roomID then
        self.isMatching = true
    else
        self.isMatching = false
    end
end

function FestivalView:updateCurData()
    self.curTabActData = self.festivalList[self.tabIndex]

    local config = ConfigManager:getAllFestivalData()
    for k, v in ipairs(config) do
        if v.mapid == self.curTabActData.mapID then
            self.curTabActCfg = v
            break
        end
    end

    local curJoinData = mvc.festivalModel:getCurJoinData()
    if curJoinData and (curJoinData.mapID == self.curTabActData.mapID) then
        self.isMatching = true
        if self.funcBtnText then
            self.funcBtnText:setText(UI.TEXT_1213022)
        end
    else
        self.isMatching = false
        if self.funcBtnText then
            self.funcBtnText:setText(UI.TEXT_1213016)
        end
    end

    -- 刷新界面
    performWithDelay(self, function()
        -- 开启时间
        if self.timeTxt then
            local timeStr, timeCount = self:getOpenTime()
            if self.timeTxt1 then
                self.timeTxt:setText(UI.TEXT_1213018)
                self.timeTxt1:setText(timeStr)
            else
                self.timeTxt:setText(UI.TEXT_1213018 .. timeStr)
            end
        end
        -- 老鼠小图
        if self.mouseImg then
            self.mouseImg:setSpriteName(self.curTabActCfg.minimap)
        end
        -- 玩法说明
        if self.descTxt then
            self.descTxt:setText(LanguageManager:getInstance():getLocalString(self.curTabActCfg.desc))
        end
        self.rightLayout:updateView()
        self.rightScorllView:scrollToTop()
        self.rightScorllView:updateView()
    end, 0.2)
end

function FestivalView:onInitView()
    self:initData()

    if not self.festivalData then
        self:close()
        return
    end

    self:updateCurData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:centerLeft(-20, 0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask, ZOrder)
    ZOrder = ZOrder + 1;

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_festival_bg.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self:rightBtnView()
    self:updateLeftPage()
    self:updateRightPage()
    self:updateFunBtn()
    self:updateTabList()
    self:updateTabBtnShow()

    self:playOpeningEff()
    self:updateExchangeShopBtn()
end

function FestivalView:updateExchangeShopBtn()
    if self._exchangeBtn == nil then
        local exchangeButton = UI.Button:create()
        exchangeButton:init("ui_festival_btn_shop_0.png", "ui_festival_btn_shop_1.png", "ui_festival_btn_shop_0.png")
        exchangeButton:closeClickScale()
        exchangeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            mvc.openPanel("Festival", "FestivalExchangeShop")
        end)
        self.contentLayout:addChild(exchangeButton, 100)
        exchangeButton:leftBottom(-20, 100)
        self._exchangeBtn = exchangeButton
    end

    -- 判断是否需要显示交换按钮
    if MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop) then 
        self._exchangeBtn:setVisible(true)
    else
        self._exchangeBtn:setVisible(false)
    end
end

function FestivalView:addGiftEff()
    local eff = UI.Animation:create()
    eff:init("effect_ui_town_festival_liwu.json", "effect_ui_town_festival_liwu.atlas", 1);
    eff:center()
    eff:setName("GiftEff")
    self.contentLayout:addChild(eff, 102)
    eff:setAnimation("idle", true)
    eff:setTouchEnable(true)
    eff:addEventListener(UIEvent.COMPONENT_CLICK, self, self.checkGift)
    self.giftEff = eff
    self.giftEff:hide()

    local layoutText = UI.Layout:create();
    layoutText:init();
    layoutText:setSize(200, 40)
    -- layoutText:enableDebugDraw()
    layoutText:leftUp(-100, -20)
    self.giftEff:addComponent("lingqu", layoutText, true)

    local text = UI.Text:create()
    text:init(UI.TEXT_1213026, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_232_178)
    text:center()
    layoutText:addChild(text)

    self.isGotGift = self.festivalData:getFestivalData():isGotReward()
    if not self.isGotGift then
        self.giftEff:show()
    end
end

function FestivalView:checkGift()
    -- 判断背包是否满了
    local GameDataManager = require("app.game.GameDataManager")
    local freeNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if(freeNum <= 0) then 
        UI.ScrollBar:createByText(UI.TEXT_1212011)
        print("bag is full")
        return 
    end

    local moveBy = cc.MoveBy:create(0.3, cc.p(0,600))
    self.giftEff:runAction(cc.Sequence:create(moveBy,cc.CallFunc:create(function()
        Net.NetActivitySystem:requestActivityReward(self.curTabActData.activityID, self.curTabActData.mapID)
    end)))
end

function FestivalView:getRewardCallback(data)
    if(tolua.isnull(self)) then
        return
    end

    if data.id ~= self.curTabActData.activityID then
        print("activityID is wrong")
        return
    end

    if data.subId ~= self.curTabActData.mapID then
        print("mapID is wrong")
        return
    end

    if data.result ~= "ActivityRewardResult_Succeed" then 
        GameErrorManager:showError(ProtobufUtil:enum_id("ActivitySystem.ActivityRewardResultType", data.result))
        return
    end

    self.festivalData:getFestivalData():setGotReward()

    -- self.giftGotImg:show()
    self.isGotGift = true

    local rewards = self.festivalData:getFestivalData():getRewardsData()
    local itemData = {}
    for k, v in pairs(rewards) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.id)
        if(goodData) then
            goodData:setIsNew(false)
            goodData:setNum(v.num)
            table.insert(itemData, goodData)
        end
    end
    local titleStr = nil
    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, titleStr, nil, nil, true)
end

function FestivalView:getNowIsHulu()
    if(self.curTabActData and self.curTabActData.mapID == PublicDefine.CONST_DEFINITION.HULU_MAP_ID) then
        return true
    end
    return false
end

function FestivalView:getNowIsPuzzle()
    if(self.curTabActData and self.curTabActData.mapID == PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID) then
        return true
    end
    return false
end

function FestivalView:getNowIsLostRealm()
    -- print("getNowIsLostRealm",self.curTabActData)
    if(self.curTabActData and self.curTabActData.mapID == PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID) then
        return true
    end
    return false
end

function FestivalView:playOpeningEff()
    local eff = UI.Animation:create()
    eff:init("effect_ui_town_festival_fanshu.json", "effect_ui_town_festival_fanshu.atlas", 1);
    eff:center()
    eff:setName("BookEff")
    self.contentLayout:addChild(eff, 100)
    -- 这里想用多轨道来处理
    eff:setAnimation("begin_shu", false)
    self.effState = 1
    eff:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function()
        print("playTurnPage hide", AvalonUtil.getCurrentTime())
        if self.effState == 1 then
            self.leftLayout:show()
            self.rightLayout:show()
            self:addGiftEff()
        else
            if not self.isGotGift then
                self.giftEff:show()
            end
        end
        eff:hide()
        self.playingEff = false
    end)

    -- 初始化的其它效果
    local isHulu = self:getNowIsHulu()
    local playStatus = self:getIsHuluPlayStatus()
    local refreshStatus = self:getIsHuLuFreshStatus()
    if(isHulu) then
        local effGreen = UI.Animation:create()
        effGreen:init("effect_ui_town_festival_fanshu.json", "effect_ui_town_festival_fanshu.atlas", 1);
        effGreen:center()
        self.contentLayout:addChild(effGreen, 100)
        if(refreshStatus) then
            effGreen:setAnimation("begin_lv", false)
        else
            effGreen:setAnimation("begin_hong", false)
        end
        effGreen:addEventListener(UIEvent.ANIMATION_END,self,function()
            effGreen:runAction(
                cc.RemoveSelf:create()
            )
        end)
    end

    local effHuang = UI.Animation:create()
    effHuang:init("effect_ui_town_festival_fanshu.json", "effect_ui_town_festival_fanshu.atlas", 1);
    effHuang:center()
    self.contentLayout:addChild(effHuang, 100)
    if(isHulu) then 
        if(playStatus) then 
            effHuang:setAnimation("beigin_huang", false)
        else
            effHuang:setAnimation("beigin_hui", false)
        end
    else
        effHuang:setAnimation("beigin_huang", false)
    end
    effHuang:addEventListener(UIEvent.ANIMATION_END,self,function()
        effHuang:runAction(
            cc.RemoveSelf:create()
        )
    end)

    -- 书签等动画特效
    local btnEff = UI.Animation:create()
    btnEff:init("effect_ui_town_festival_shuqian.json", "effect_ui_town_festival_shuqian.atlas", 1);
    btnEff:rightBottom(28, 225)
    btnEff:setName("BtnEff")
    btnEff:hide()

    local text = UI.Text:create()
    text:init(UI.TEXT_1213016, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    text:centerUp(-18)
    text:rotate(-8)

    btnEff:addComponent("txt", text, true)
    self.contentLayout:addChild(btnEff, 101)
    btnEff:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function()
        self.funcBtn:show()
        self.funcBtnLine:show()
        btnEff:hide()
    end)

    local btnHuluEff = UI.Animation:create()
    btnHuluEff:init("effect_ui_town_festival_shuqian.json", "effect_ui_town_festival_shuqian.atlas", 1);
    btnHuluEff:rightBottom(28, 225)
    btnHuluEff:setName("btnHuluEff")
    if(isHulu) then 
        if(refreshStatus) then 
            btnHuluEff:setAnimation("huluwa_lv", false)
        else
            btnHuluEff:setAnimation("huluwa_hong", false)
        end
        btnHuluEff:updateTime(10)
        btnHuluEff:show()
    else
        btnHuluEff:updateTime(10)
        btnHuluEff:hide()
    end

    local huluContent = UI.Layout:create()
    huluContent:init()
    if Avalon.Animation:getSpineVersion() < 3060039 then
        huluContent:centerUp(-20)
        huluContent:rotate(-27)
    else
        huluContent:centerUp(-33)
        huluContent:rotate(-180 + 17)
    end
    huluContent:setSize(200, 50)
    self.huluContent = huluContent

    -- 倒计时处理逻辑
    local okContent = UI.Layout:create()
    okContent:init()
    okContent:center()
    okContent:setSize(0, 0)
    huluContent:addChild(okContent)
    self.okContent = okContent

    local okIcon = UI.Image:create()
    okIcon:init("ui_information_btn_yes.png")
    okIcon:centerLeft(0)
    okContent:addChild(okIcon)

    local okText = UI.Text:create()
    okText:init(UI.TEXT_1324104, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okContent:addChild(okText)

    local startX = (okIcon:getContentSize().width + okText:getContentSize().width + 4) /2
    okIcon:centerLeft(- startX)
    okText:centerLeft(- startX + okIcon:getContentSize().width + 4)

    -- 倒计时处理逻辑
    local timeContent = UI.Layout:create()
    timeContent:init()
    timeContent:center()
    timeContent:setSize(0, 0)
    huluContent:addChild(timeContent)
    self.timeContent = timeContent

    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:setAnchorPoint(0.5, 0.5)
    -- clockIcon:setScale(0.8)
    clockIcon:centerLeft(-clockIcon:getContentSize().width - 4)
    timeContent:addChild(clockIcon)
    self.clockIcon = clockIcon

    local huluText = UI.Text:create()
    huluText:init("fdsfsdfsdfsfff", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    huluText:center()
    timeContent:addChild(huluText)
    self.clockText = huluText
    self:refreshStatus()

    btnHuluEff:addComponent("huluwa_txt", huluContent, true)
    self.contentLayout:addChild(btnHuluEff, 100)
end

function FestivalView:updateLeftPage()
    local leftLayout = UI.Layout:create();
    leftLayout:init()
    leftLayout:setSize(410, 518)
    leftLayout:leftUp(50, 28)
    self.contentLayout:addChild(leftLayout, ZOrder)
    -- leftLayout:enableDebugDraw()
    ZOrder = ZOrder + 1;
    self.leftLayout = leftLayout
    self.leftLayout:hide()

    local BG_BIG = "ui_activity_banner_no_found_big.png"
    local BG_LITTLE = "ui_activity_banner_no_found_little.png"
    local bgSpriteName = BG_BIG
    if(self.festivalData.imgType == 0) then 
        bgSpriteName = BG_LITTLE
    end
    local activtyImage = UI.Image:create()
    activtyImage:init(bgSpriteName)
    ImageDownLoadUtil:downLoadImage(self.festivalData:getImageName(), activtyImage, function(imgName, localUrl)
        if(not tolua.isnull(activtyImage) and localUrl and localUrl ~= "") then
            activtyImage:setTexture(localUrl)
        end
    end)
    activtyImage:center()
    self.leftLayout:addChild(activtyImage)

    local mask  = UI.Image:create();
    mask:init("ui_festival_mask_1.png");
    mask:leftUp(-3, 1);
    leftLayout:addChild(mask);
    -- mask:enableDebugDraw()

    local txtBG  = UI.Image:create();
    txtBG:init("ui_festival_paper.png");
    txtBG:leftUp(-50, -24);
    leftLayout:addChild(txtBG);

    local titleTxt1 = UI.Text:create()
    local showText = UI.TEXT_1213114
    if self.festivalData.nameStr then
        local textList = json.decode(self.festivalData.nameStr)
        showText = textList[1].text
    end
    titleTxt1:init(showText, UI.SYS_FONT, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_54)
    titleTxt1:setSize(130, 50)
    titleTxt1:setTextCenter()
    titleTxt1:centerUp(65)
    -- titleTxt1:enableDebugDraw()
    txtBG:addChild(titleTxt1)

    local titleTxt2 = UI.Text:create()
    titleTxt2:init(UI.TEXT_1213017, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_54)
    titleTxt2:setSize(130, 40)
    titleTxt2:setTextCenter()
    titleTxt2:centerBottom(60)
    txtBG:addChild(titleTxt2)

    local startDate = GameManager:getNowServerDate("%m.%d", self.festivalData:getStartTime() + GameManager:getEPOCHTime())
    local endDate = GameManager:getNowServerDate("%m.%d", self.festivalData:getEndTime() + GameManager:getEPOCHTime())
    local titleTxt3 = UI.Text:create()
    titleTxt3:init(startDate .. "-" .. endDate, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_54)
    titleTxt3:setSize(130, 30)
    titleTxt3:setTextCenter()
    titleTxt3:centerBottom(30)
    txtBG:addChild(titleTxt3)

    local desc = UI.RichText:create()
    desc:initForNetJson(self.festivalData.decStr, 300, 100)
    desc:leftBottom(66, 40)
    mask:addChild(desc)
end

function FestivalView:updateRightPage()

    local rightLayout = UI.Layout:create();
    rightLayout:init()
    rightLayout:setSize(412, 0)
    rightLayout:enableAutoHeight()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(412, 470)
    scrollView:init()
    scrollView:rightUp(50, 28)
    scrollView:addInnerNode(rightLayout)
    scrollView:useDefaultScrollBar()
    self.contentLayout:addChild(scrollView,100)    
    self.rightScorllView = scrollView
    ZOrder = ZOrder + 1;
    self.rightLayout = rightLayout
    -- self.rightLayout:hide()
   
    local mouse  = UI.Image:create();
    mouse:init(self.curTabActCfg.minimap);
    mouse:floatUp(10);
    rightLayout:addComponent(mouse)
    self.mouseImg = mouse
    local mask  = UI.Image:create();
    mask:init("ui_festival_mask_2.png");
    mask:center()
    mouse:addChild(mask);
    

    local timeStr, timeCount = self:getOpenTime()
    local timeTxt = UI.Text:create()
    local timeTxt1 = nil
    if timeCount <= 2 then
        timeTxt:init(UI.TEXT_1213018 .. timeStr, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    else
        timeTxt:init(UI.TEXT_1213018, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)

        -- 具体时间换行显示
        timeTxt1 = UI.Text:create()
        timeTxt1:init(timeStr, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        timeTxt1:leftBottom(41, 10)
        mask:addChild(timeTxt1)
    end
    timeTxt:leftBottom(41, 26)
    mask:addChild(timeTxt)
    self.timeTxt = timeTxt
    self.timeTxt1 = timeTxt1

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213019, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- titleTxt:leftBottom(45, 190)
    titleTxt:floatUp(10)
    -- titleTxt:enableDebugDraw()
    rightLayout:addComponent(titleTxt)

    local descTxt = UI.Text:create()
    descTxt:init(LanguageManager:getInstance():getLocalString(self.curTabActCfg.desc), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    descTxt:setWidth(328)
    -- descTxt:leftBottom(45, 36)
    descTxt:floatUp(10)
    rightLayout:addComponent(descTxt)
    self.descTxt = descTxt

end

function FestivalView:rightBtnView()
    local btnLayout = UI.Layout:create();
    btnLayout:init()
    btnLayout:setSize(412, 518)
    btnLayout:rightUp(50, 28)
    self.contentLayout:addChild(btnLayout, 10001)

    local line  = UI.Image:create();
    line:init("ui_festival_line.png");
    line:rightBottom(-85, 74);
    btnLayout:addChild(line);
    self.funcBtnLine = line
    self.btnView = btnLayout
end

function FestivalView:getOpenTime()
    local timeList = self.festivalList[self.tabIndex].time
    local timeStr = ""
    for k, v in ipairs(timeList) do
        local beginTime = self:getTimeShow(v.startTm)
        local endTime = self:getTimeShow(v.endTm)
        timeStr = timeStr .. beginTime .. "-" .. endTime .. ", "
    end
    timeStr = string.sub(timeStr, 0, #timeStr-2)
    return timeStr, #timeList
end

-- 获取服务器到下次
function FestivalView:getOffsetTimeToNextTimeInDay(timeInDayInSeconds)
    local timeNow = GameManager:getNormalServerTime()
    local timeNowInDay = timeNow % SECONDS_ONE_DAY
    -- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = timeInDayInSeconds - timeNowInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + SECONDS_ONE_DAY
	return deltaToTargetNext
end

function FestivalView:getTimeShow(second)
    -- 获取本地时间
    local localDate = os.date("*t", os.time())
    local localTime = localDate.hour * 3600 + localDate.min * 60 + localDate.sec

    -- 计算开始时间
    local offsetOpenTime = self:getOffsetTimeToNextTimeInDay(second)
    local localOpenTime = (localTime + offsetOpenTime) % SECONDS_ONE_DAY

    local hour = math.floor(localOpenTime/3600)
    local min = math.floor((localOpenTime - hour*3600)/60)
    local showStr = string.format("%d:%02d", hour, min)
    return showStr
end

function FestivalView:updateFunBtn()
    local curJoinData = mvc.festivalModel:getCurJoinData()

    local funcBtn = UI.Button:create()
    funcBtn:init("ui_festival_btn_yellow_0.png","ui_festival_btn_yellow_1.png","ui_festival_btn_yellow_2.png")
    funcBtn:rightBottom(-58, 3)
    funcBtn:closeClickScale()
    funcBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.isMatching then
            if(self:getNowIsHulu()) or (self:getNowIsPuzzle()) or self:getNowIsLostRealm() then 
                return
            end
            self.funcBtnText:setText(UI.TEXT_1213016)
            self.isMatching = false
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetActivitySystem:requestCancleMacth()
        else
            self:checkCanJoin()
        end
    end)
    self.funcBtn = funcBtn
    self.btnView:addChild(funcBtn)

    local btnTxt = UI.Text:create()
    local isMatch = false
    local showText = UI.TEXT_1213016
    if curJoinData and (curJoinData.mapID == self.curTabActData.mapID) then
        showText = UI.TEXT_1213022
        self.isMatching = true
    end

    btnTxt:init(showText, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btnTxt:centerBottom(38)
    btnTxt:rotate(-10)
    funcBtn:addChild(btnTxt, 1)
    self.funcBtnText = btnTxt
end

-- 其他玩法匹配检查
function FestivalView:checkCanJoin()
    -- 检查活动开放时间
    if not self:checkOpenTime() then
        UI.ScrollBar:createByText(UI.TEXT_1213025)
        return
    end

    -- 检查等级
    if RoleDataManager:getMaster():getLevel() < 10 then
        UI.ScrollBar:createByText(UI.TEXT_1213020)
        return
    end

    -- 时光之门、沙之眼、扭曲空间、深渊
    if TeamDataManager:getReadyState() then
        UI.ScrollBar:createByText(UI.TEXT_1213021)
        return
    end

    -- 世界boss的判断
    if not mvc.worldBossModel:checkCanEnterOther() then
        UI.ScrollBar:createByText(UI.TEXT_1213021)
        return
    end

    -- 节日活动中的其他活动
    if not mvc.festivalModel:checkCanEnterOther() then
        UI.ScrollBar:createByText(UI.TEXT_1213021)
        return
    end

    -- 探险队
    -- if(mvc.expeditionModel:getExpeditionStatus()) then
    --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
    --         Net.NetNPCSystem:reqStopExpedition()
    --         self:joinBattle()
    --     end)
    -- else 
        self:joinBattle()
    -- end
end

function FestivalView:checkOpenTime()
    local curTime = os.date("!*t", GameManager:getNowServerTime())
    local curTimeStamp = curTime.hour*3600+curTime.min*60+curTime.sec
    local timeList = self.festivalList[self.tabIndex].time
    local isOpen = false
    for k, v in ipairs(timeList) do
        if curTimeStamp >= v.startTm and curTimeStamp <= v.endTm then
            isOpen = true
            break
        end
    end

    return isOpen
end

function FestivalView:joinBattle()
    self.isMatching = true

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    if(self:getNowIsHulu()) then 
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
        PublicDefine.CONST_DEFINITION.HULU_MAP_ID,
        spriteID, false, self.curTabActData.activityID)
    elseif (self:getNowIsPuzzle()) then
        mvc.puzzleModel:clearSceneRunTime()
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
        PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID,
        spriteID, false, self.curTabActData.activityID)
    elseif (self:getNowIsLostRealm()) then
        mvc.send(mvc.events.Festival_LostRealmRequest, self.curTabActData)
    else
        self.funcBtnText:setText(UI.TEXT_1213022)
        Net.NetActivitySystem:requestMacth(self.curTabActData.activityID, self.curTabActData.mapID)
    end
end

function FestivalView:resolveBtnTextLen()
    self.tabArr = {}
    for i = 1, #self.festivalList do
        table.insert(self.tabArr, self["tab"..i])
        if self["tab"..i]._text:getContentSize().width > 100 then
            self["tab"..i]:setTextOffset(10, 0)
            self["tab"..i]:setTextWidth(100)
        end
    end
end

function FestivalView:getActName(idx)
    local festivalData = self.festivalList[idx]

    local config = ConfigManager:getAllFestivalData()
    for k, v in ipairs(config) do
        if v.mapid == festivalData.mapID then
            return v.name
        end
    end
end

function FestivalView:updateTabList()
    local btnIdx = 1
    local btnLayout = UI.Layout:create();
    btnLayout:init()
    btnLayout:setSize(148, 278)
    btnLayout:rightUp(-132, 30)
    self.btnView:addChild(btnLayout, ZOrder)
    -- btnLayout:enableDebugDraw()
    ZOrder = ZOrder + 1;

    local posY = 60
    for index = 1, #self.festivalList do
        local tab = UI.Button:create()
        -- local resIndex = math.mod(index, 5)
        --CO-17606 【深渊】深渊扫荡功能异常
        local resIndex = index % 5
        resIndex = resIndex == 0 and 5 or resIndex
        tab:init("ui_festival_btn_"..resIndex.."_0.png","ui_festival_btn_"..resIndex.."_1.png","ui_festival_btn_"..resIndex.."_0.png")
        tab:leftUp(0, posY * (index - 1))
        tab:setText(LanguageManager:getInstance():getLocalString(self:getActName(index)))
        tab:setTextOffset(5, 0)
        tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_31_30_27)
        tab:closeClickScale()
        tab:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not self.playingEff then
                self.tabIndex = index
                self:updateCurData()
            end
            self:updateTabBtnShow()
        end)
        self["tab"..index] = tab
        btnLayout:addChild(tab)
    end

    self:resolveBtnTextLen()
end

function FestivalView:updateTabBtnShow()
    if self.oldTabIndex ~= 0 and not self.playingEff then
        if self.tabIndex > self.oldTabIndex then
            self:playTurnPage(true)
        elseif self.tabIndex < self.oldTabIndex then
            self:playTurnPage(false)
        end
    end

    for k, v in ipairs(self.tabArr) do
        if k == self.tabIndex then
            v:press(false)
            v._text:setFontColor(UI.FONT_COLOR_220_211_147)
        else
            v:release()
            v._text:setFontColor(UI.FONT_COLOR_31_30_27)
        end
    end

    self.oldTabIndex = self.tabIndex
end

function FestivalView:playTurnPage(left)
    self.playingEff = true
    self.funcBtn:hide()
    self.funcBtnLine:hide()
    if not self.isGotGift then
        self.giftEff:show()
    end

    local eff = self.contentLayout:getChildByName("BookEff")
    eff:show()
    print("playTurnPage show", AvalonUtil.getCurrentTime())
    eff:setToSetupPose()
    if left then
        self.effState = 2
        eff:setAnimation("fanye_z", false)
    else
        self.effState = 3
        eff:setAnimation("fanye_y", false)
    end

    local isHulu = self:getNowIsHulu()
    local playStatus = self:getIsHuluPlayStatus()
    local refreshStatus = self:getIsHuLuFreshStatus()

    local btnEff = self.contentLayout:getChildByName("BtnEff")
    btnEff:show()
    if(isHulu) then
        if(playStatus) then
            btnEff:setAnimation("idle", false)
        else
            btnEff:setAnimation("huluwa_hui", false)
        end
    else
        btnEff:setAnimation("idle", false)
    end

    local btnHuluEff = self.contentLayout:getChildByName("btnHuluEff")
    if(isHulu) then
        btnHuluEff:show()
        if(playStatus) then
            btnHuluEff:setAnimation("huluwa_lv", false)
        else
            btnHuluEff:setAnimation("huluwa_hong", false)
        end

        if(playStatus) then 
            self.funcBtn:enable()
        else 
            self.funcBtn:disable()
        end

        if(refreshStatus) then 
            self.okContent:show()
            self.timeContent:hide()
        else 
            self.okContent:hide()
            self.timeContent:show()
        end
        self.huluContent:setVisible(true)
    else
    	self.huluContent:setVisible(false)
        self.funcBtn:enable()
        btnHuluEff:hide()
    end
end

function FestivalView:cancelMatch()
    self.isMatching = false
    self.funcBtnText:setText(UI.TEXT_1213016)
end

function FestivalView:cdCancelMatch(data)
    self.isMatching = data.rematching
    if data.rematching then
        self.funcBtnText:setText(UI.TEXT_1213022)
    else
        self.funcBtnText:setText(UI.TEXT_1213016)
    end
end

function FestivalView:refreshWebLanguageBack()
    MasterDataManager:refreshActivityLanguageCallback()
end

function FestivalView:bindModel()
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function FestivalView:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function FestivalView:updateText()
	if(self.clockText) then 
		local endTime = self:getHuLuFreshTime()
		local timeStr = AvalonUtil:getNewFullFormatTime(endTime + GameManager:getNormalServerTime(), Game.TIME_LEVEL.TIME_LEVEL_HOUR)
        self.clockText:setText(string.format(UI.TEXT_1324105, timeStr))
        
        local startX = (self.clockIcon:getContentSize().width + self.clockText:getContentSize().width + 4) /2
        self.clockIcon:centerLeft(- startX)
        self.clockText:centerLeft(- startX + self.clockIcon:getContentSize().width + 4)
	end
end

function FestivalView:update(dt)
	if(self._totalTime == nil) then 
		self._totalTime = 0
	end
	if(self._totalTime > 60) then 
		self._totalTime = self._totalTime - 60
		self:refreshStatus()
	end
end

function FestivalView:refreshStatus()
    local isHulu = self:getNowIsHulu()
    local playStatus = self:getIsHuluPlayStatus()
    local refreshStatus = self:getIsHuLuFreshStatus()
    if(isHulu) then 
        if(playStatus) then 
            self.funcBtn:enable()
        else
            self.funcBtn:disable()
        end
        if(refreshStatus) then 
            self.okContent:setVisible(true)
            self.timeContent:setVisible(false)
        else 
            self.okContent:setVisible(false)
            self.timeContent:setVisible(true)
        end
    else 
        self.funcBtn:enable()
        self.timeContent:setVisible(false)
        self.okContent:setVisible(false)
        self.huluContent:setVisible(false)
    end
    self:updateText()
end

function FestivalView:getIsHuluPlayStatus()
    local festData = self.festivalData:getFestivalData()
    if(festData) then
        return festData:getIsHuluPlayStatus()
    end

    return false
end

function FestivalView:getIsHuLuFreshStatus()
    local festData = self.festivalData:getFestivalData()
    if(festData) then
        return festData:getIsHuLuFreshStatus()
    end

    return false
end

function FestivalView:getHuLuFreshTime()
    local festData = self.festivalData:getFestivalData()
    if(festData) then
        return festData:getHuLuFreshTime()
    end

    return 0
end

-- 进入洞穴反馈消息
function FestivalView:enterCaveResult(data)
    if(data and data.result ~= "EnterCaveSceneResult_Succeed") then 
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.EnterCaveSceneResult", data.result))
    end
    UI.WaitingLayer:hideWaiting()
end

return FestivalView
