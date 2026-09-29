-- MailInfoLayer.lua
-- Author:ydli
-- 2018年12月05日
-- Using:邮箱详情界面

UI = UI or {}
local MailInfoLayer = class("MailInfoLayer", UI.CenterWin)
UI.MailInfoLayer = MailInfoLayer

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(537, 372)
local SceneManager = require("app.game.SceneManager")

function MailInfoLayer:ctor(data)
    MailInfoLayer.super.ctor(self, 0, {}, layerSize.width, layerSize.height)
    self.data = data
    self.itemList = {}
    self:init()
    self:setNoticeShowMainUI(false)
    self:registerListener()
end

function MailInfoLayer:dtor()
    MailInfoLayer.super.dtor(self)
    self.itemList = {}
    self:unRegisterListener()
end

function MailInfoLayer:init()
    MailInfoLayer.super.init(self)
end

function MailInfoLayer:onInitView()
    self:showLucencyLight()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(layerSize.width, layerSize.height)
    contentLayout:center()
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加背景
    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    self._contentLayout:addChild(bg)
    self.bg = bg

    local remainTime = UI.Text:create()
    remainTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    remainTime:setTextLeft()
    remainTime:leftBottom(440, 30)
    self.bg:addChild(remainTime, 4)
    self.remainTime = remainTime

    local senderBg = UI.Image:create()
    senderBg:init("ui_tips_box_01.png")
    senderBg:centerUp(25, 30)
    bg:addChild(senderBg, 2)
    self.senderBg = senderBg

    local createTime = UI.Text:create()
    createTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    createTime:setTextLeft()
    createTime:rightUp(220,16)
    self.senderBg:addChild(createTime, 2)
    self.createTime = createTime
    -- createTime:enableDebugDraw()
    local createTimePosX = 10
    self.createTime:setText(string.format("(%s)", GameManager:getNowServerDate("%Y.%m.%d", self.data.createTime + GameManager:getEPOCHTime())))
    if self.data.title ~= nil and self.data.title ~= "" then
        local sender = UI.RichText:create()
        local isOk = sender:initForNetJson(self.data.title, 100, 0, true)            
        if isOk then
            sender:leftBottom(8, 4)
            self.senderBg:addChild(sender, 2)
            createTimePosX = sender:getContentSize().width + 16
            -- sender:enableDebugDraw()
        end
    end


    local cententLayout = UI.Layout:create()
    cententLayout:init()
    cententLayout:setSize(451, 227)
    cententLayout:centerUp(63)

    local cententHeight = 0
    if self.data.content ~= nil and self.data.content ~= "" then
        local textWidth = 451
        local content = UI.RichText:create()
        local isOk = content:initForNetJson(self.data.content, textWidth, 0, nil, 100)
        if isOk then
            content:centerUp(1)
            cententLayout:addChild(content)
        end
        cententHeight = content:getContentSize().height
    end
    self.createTime:leftBottom(createTimePosX, 5)

    local rewardLayer = self:generalRewardItem()
    if rewardLayer ~= nil then
        rewardLayer:centerBottom(0)
        cententLayout:addChild(rewardLayer)
        cententHeight = cententHeight + rewardLayer:getContentSize().height
    end
    if cententHeight + 40 > cententLayout:getContentSize().height then
        cententLayout:setSize(cententLayout:getContentSize().width, cententHeight + 40)
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(488, 227)
        detailedScrollView:leftUp(43, 63)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(cententLayout)
        bg:addChild(detailedScrollView)

        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)

        local cap = UI.Image:create()
        cap:init("ui_tips_gradually_01.png")
        cap:centerBottom(80)
        bg:addChild(cap, 20)
    else
        bg:addChild(cententLayout)
    end

    local cacceptButton = UI.Button:create()
    cacceptButton:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
    cacceptButton:centerBottom(20)
    cacceptButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:acceptAwardClick()
    end)
    cacceptButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    cacceptButton:setText(UI.TEXT_111035)
    self.bg:addChild(cacceptButton)
    self.cacceptButton = cacceptButton

    
    self.cacceptButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if not SceneManager:getInstance():isInTownOrInHome() then
            UI.ScrollBar:createByText(UI.TEXT_1212899)
        end
    end)
    self:refreshTime()
    self:refershSelectState(self.data.mailID)
end

function MailInfoLayer:onUpdateView()
 
end

function MailInfoLayer:generalRewardItem()
    if #self.data.goodsIDs == 0 and table.nums(self.data.InstEquips) == 0 and table.nums(self.data.InstPets) == 0 and table.nums(self.data.glyphs) == 0 then
        return
    end
    local rewardData = {}
    for k, v in ipairs(self.data.goodsIDs) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
        if goodData then
            goodData:setNum(v.num)
            goodData:setIsNew(false)
            goodData.isHaveGet = false
            table.insert(rewardData, goodData)
        end
    end
    
    for k, v in ipairs(self.data.InstEquips) do
        v.isHaveGet = true
        table.insert(rewardData, v)
    end

    -- add by zp 这里有点骚操作，很扯淡
    for k, v in ipairs(self.data.InstPets) do
        v.isPet = true
        table.insert(rewardData, v)
    end

    for k, v in ipairs(self.data.glyphs) do
        v.isHaveGet = true
        table.insert(rewardData, v)
    end

    local itemPadding = 73
    local itemHight = 68
    local size = #rewardData
    local rowNum = math.ceil(size / 5)
    local upLayout = UI.TouchLayout:create()
    upLayout:init(0, 0, 0, 0)
    upLayout:setSize(451, rowNum * itemHight + 20)
    upLayout:centerBottom(0)
    upLayout:addTouchEvents(self)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_tips_box_02.png")
    bg:setContentSize(upLayout:getContentSize().width, upLayout:getContentSize().height)
    bg:setPosition(upLayout:getContentSize().width / 2, upLayout:getContentSize().height / 2)
    upLayout:addChild(bg)

    local beginPosX = 45
    for i = 1, size do
        local goodData = rewardData[i]
        if goodData ~= nil then
            if(goodData) then
                -- add by zp 这里由于恢复宠物需要处理的东西
                local goodGrid = nil
                if(goodData.isPet) then
                    goodGrid = UI.Image:create()
                    goodGrid:init("box_quality_box_01.png")
                    goodGrid:center()

                    local iconImage = UI.Image:create()
                    iconImage:init(goodData:getIcon())
                    iconImage:center()
                    goodGrid:addChild(iconImage)
                else
                    goodGrid = UI.GoodsGrid:create()
                    goodGrid:init(goodData)
                    if goodData.isHaveGet then
                        goodGrid:showInfoArea(false, false)
                    else
                        goodGrid:showInfoArea(true, false)
                    end
                    goodGrid:hideFlagIcon()
                    goodGrid:hideBG()
                    goodGrid:setTouchEnable(false)
                    table.insert(self.itemList, goodGrid)
                    if self.data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_Rewarded then
                        goodGrid:updateCanUseState(false)
                    end
                end

                local index = (i % 5)
                index = index == 0 and 5 or index
                goodGrid:leftUp(beginPosX + itemPadding * (index - 1), 10 + math.floor((i - 1) / 5) * itemHight)
                upLayout:addChild(goodGrid)
            end
        end
    end
    return upLayout
end

function MailInfoLayer:refreshTime()
    local curTime = GameManager:getNowServerTime()
    local waitingTime = self.data.outTime + GameManager:getEPOCHTime() - curTime

    local hours = math.ceil(waitingTime / SECONDS_ONE_HOUR)
    if hours <= 1 then
        self.remainTime:setFontColor(UI.FONT_COLOR_181_32_32)
        self.remainTime:setText("<1"..UI.TEXT_111033)
        if self.bg:getChildByName("clockIcon") ~= nil then
            self.bg:removeChildByName("clockIcon")
        end
        if self.bg:getChildByName("clockAnim") == nil then
            local clockAnim = UI.Animation:create()
            clockAnim:init("effect_ui_package_task_banner_clock.json", "effect_ui_package_task_banner_clock.atlas")
            clockAnim:leftBottom(self.remainTime:getLeft() - clockAnim:getContentSize().width - 11, 38)
            clockAnim:setName("clockAnim")
            self.bg:addChild(clockAnim, 2)
            clockAnim:setAnimation("idle",true)
        end
    else
        local timeStr = ""
        if hours < 24 then
            timeStr = hours..UI.TEXT_111033
        else
            local day = math.ceil(waitingTime / SECONDS_ONE_DAY)
            timeStr = day..UI.TEXT_1170921 
        end

        if self.bg:getChildByName("clockAnim") ~= nil then
            self.bg:removeChildByName("clockAnim")
        end
        self.remainTime:setFontColor(UI.FONT_COLOR_41_41_45)
        self.remainTime:setText(timeStr)
        if self.bg:getChildByName("clockAnim") ~= nil then
            self.bg:removeChildByName("clockAnim")
        end
        if self.bg:getChildByName("clockIcon") == nil then
            local clockIcon = AvalonUtil.createClockAnimation()
            clockIcon:leftBottom(self.remainTime:getLeft() - clockIcon:getContentSize().width - 4, 25)
            self.bg:addChild(clockIcon)
            clockIcon:setName("clockIcon")            
        end
    end
end

function MailInfoLayer:acceptAwardClick()
    if not Game.MailManager:getInstance():isExistingMail(self.data.mailID) then
        UI.ScrollBar:createByTextID(1170087)
        return
    end

    if table.nums(self.data.goodsIDs) == 0 and table.nums(self.data.InstEquips) == 0 and table.nums(self.data.InstPets) == 0 and table.nums(self.data.glyphs) == 0 and self.data.hrefUrl ~= "" then
        GameManager:openUrl(self.data.hrefUrl, function(isClose)
            if isClose then
                if not tolua.isnull(self) then
                    self:closeCallback()
                end
                Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_MAIN_MAIL_LAYER)
            end
        end)
        return
    end

    local curTime = GameManager:getNowServerTime()
    local waitingTime = self.data.outTime + GameManager:getEPOCHTime() - curTime
    if waitingTime <= 0 then
        UI.ScrollBar:createByTextID(1170080)
        return
    end
    -- 判断背包是否满了
    local rewards = {}
    local addPetNum = 0
    local addGlyphsNum = 0
    for k, v in ipairs(self.data.goodsIDs) do
        local data = {}
        data.goodsID = v.templateID
        data.num = v.num
        data.isGolden = true
        table.insert(rewards, data)
    end

    for k, v in ipairs(self.data.InstEquips) do
        local reward = {}
        reward.goodsID = v:getId()
        reward.num = v:getNum()
        reward.isGolden = true
        table.insert(rewards, reward)
    end

    for k2, v2 in ipairs(self.data.InstPets) do
        addPetNum = addPetNum + 1
    end

    for k, v in ipairs(self.data.glyphs) do
        -- local reward = {}
        -- reward.goodsID = v:getId()
        -- reward.num = v:getNum()
        -- reward.isGolden = false
        -- table.insert(rewards, reward)
        addGlyphsNum = addGlyphsNum + 1
    end

    local GameDataManager = require("app.game.GameDataManager")
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(rewards)
    if not enough then
         UI.ScrollBar:createByTextID(1110793)
        return
    end

    local petCount = #MasterDataManager:getBagPets()
	if addPetNum > 0 and petCount + addPetNum >= PET_MAC_BAG then
		UI.ScrollBar:createByText(UI.TEXT_1213713)
		return
	end
    
    if addGlyphsNum > 0 and GameDataManager:getFreeGlyphsBoxNum() <= addGlyphsNum then
        UI.ScrollBar:createByText(UI.TEXT_227068)
        return 
    end

    if RoleBehaviorManager:mailNpcCheck() then
        printWarn(" been blocked when using mail npc function !")
        return
    end
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local list = {}
    table.insert(list, self.data.mailID)
    GameManager:sendAcceptAward(list)
end

function MailInfoLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, self, self.refershSelectState)
end

-- 注销监听事件(可选)
function MailInfoLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, self, self.refershSelectState)
end

function MailInfoLayer:refershSelectState(mailId)
    if self.data == nil then
        return
    end
    if mailId == self.data.mailID then
        if table.nums(self.data.goodsIDs) ~= 0 or table.nums(self.data.InstEquips) ~= 0 or table.nums(self.data.InstPets) ~= 0 or table.nums(self.data.glyphs) ~= 0 then
            self.cacceptButton:show()
            if self.data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_Rewarded then
                self.cacceptButton:disable()
                self.cacceptButton:setText(UI.TEXT_1110721)
            else
                self.cacceptButton:enable()
            end
        elseif self.data.hrefUrl ~= "" then
            self.cacceptButton:show()
            self.cacceptButton:setText(UI.TEXT_1170710)
        else
            self.cacceptButton:hide()
        end
    end


    if self.data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_Rewarded then
        for k, goodGrid in ipairs(self.itemList) do
            goodGrid:updateCanUseState(false)
        end
    end

    if not SceneManager:getInstance():isInTownOrInHome() then
        self.cacceptButton:disable()
    end
end


function MailInfoLayer:closeCallback()
    self:closeWin()    
end

function MailInfoLayer:openShow()
    self:open()
end

function MailInfoLayer:onTouchBegan(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    
    for k, value in ipairs(self.itemList) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            break
        end
    end
end

function MailInfoLayer:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.itemList) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            local info = value:onShowInfoAreaHandler(true)
            if info ~= nil then
                local point = self:convertToWorldSpace(cc.p(0, 0))
                local nodePoint = value:convertToWorldSpace(cc.p(0, 0))
                if nodePoint.x < winSize.width / 2 then
                    info:rightBottom(winSize.width - point.x - 45, info:getPositionY())
                else
                    info:leftBottom(point.x + self:getContentSize().width - 45, info:getPositionY())
                end
            end
            break
        end
    end
end


 