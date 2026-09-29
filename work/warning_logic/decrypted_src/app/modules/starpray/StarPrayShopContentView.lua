------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/25
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPrayShopContentView = class("StarPrayShopContentView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_starpray.plist"
}

local layerSize = cc.size(560, 540)
local COM_WIDTH = 852
local COM_HEIGHT = 534
local planePos = {
    {x = -185, y = 230},
    {x = -50, y = 345},
    {x = 105, y = 200},
    {x = 293, y = 330},
    {x = 505, y = 215}
}
local slotNames = {
    {"starpray-stone-0"},
    {"starpray-stone-0", "starpray-stone-1"},
    {"starpray-stone-00", "starpray-stone-0", "starpray-stone-1"},
    {"starpray-stone-00", "starpray-stone-0", "starpray-stone-1", "starpray-stone-2"}
}
local attachNames = {
    "starpray-stone-01hui",
    "starpray-stone-02lan",
    "starpray-stone-03huang",
    "starpray-stone-04cheng",
    "starpray-stone-06zi"
}
local noAttachImage = "starpray-stone-00kong"
local layoutUU
local rewardList = {}
function StarPrayShopContentView:ctor(spriteId)
    StarPrayShopContentView.super.ctor(self, UI.Type.STAR_PRAY_SHOP_VIEW, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self.planeList = {}
    self.curIndex = (GameDataManager:getInstance():getMaster():getStarPrayPool() or 0) + 1
    self.spriteId = spriteId
    self.isGetResult = false
    self:setTouchEnable(true)
    -- self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBegan)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded)
    self:center(0, 20)
    self.lockCloseReward = false
    layoutUU = UIUtil:createAutoUILayout("StarPrayEquipView", "app.modules.starpray.StarPrayPosConfig", false)
end

function StarPrayShopContentView:dtor()
    StarPrayShopContentView.super.dtor(self)
    self:unbindModel()
    if self.prepareSound then
        Avalon.AudioManager:stopSound(self.prepareSound)
        self.prepareSound = nil
    end
    reload_script_file_mvc("app.modules.starpray.StarPrayShopContentView")
end

function StarPrayShopContentView:createSilverBtnInfos(img, num, clickFun, str, tag, goodsId)
    local com = UI.Component:create()
    com:init()
    com:setSize(50, 50)
    addChildAuto(layoutUU, self, com, "shop_SilverButton" .. tag, "center")
    --button
    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_0.png")
    executeButton:centerBottom(5)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, clickFun)
    executeButton:center()
    com:addChild(executeButton)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:center()
    -- 钻石图标
    local diamondIcon = UI.Image:create()
    diamondIcon:init(img)
    diamondIcon:floatLeft(1)
    layout:addComponent(diamondIcon)
    -- 花费文字
    -- local txtDiamondNum = UI.Text:create()
    -- txtDiamondNum:init(tostring(num), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- txtDiamondNum:floatLeft(5)
    -- layout:addComponent(txtDiamondNum)
    -- com:addChild(layout,1001)

    local txtDiamondNum = UI.GoodsCostText:create(tostring(num), goodsId, num, UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
    txtDiamondNum:floatLeft(5)
    layout:addComponent(txtDiamondNum)
    com:addChild(layout, 1001)

    --tips
    local panel = UI.Layout:create()
    panel:init()
    panel:enableAutoWidth()
    panel:center(0, 41)
    com:addChild(panel, 1001)

    local tipIcon = UI.Image:create()
    tipIcon:init("ui_information_reminder.png")
    tipIcon:floatLeft(1)
    panel:addComponent(tipIcon)

    local tips = UI.Text:create()
    tips:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_51_51)
    tips:floatLeft(3)
    tips:setWidth(240)
    tips:enableWrap(true)
    local size = tips:getContentSize()
    if size.height > 27 then
        tips:setLineSpacing(-9)
        tips:setFontSize(16)
        local size = tips:getContentSize()
        tips:setSize(250,size.height)
    end
    tips:setTextCenter()
    -- tips:enableDebugDraw()
    panel:addComponent(tips)
    tips:updateView()
    panel:enableAutoHeight()
    panel:updateView()
    return executeButton, txtDiamondNum, diamondIcon
end

function StarPrayShopContentView:refreshExp()
    local curExp, totalExp = mvc.starPrayModel:getShopExp()
    local percent = 0
    if totalExp == 0 then
        percent = 0
    else
        percent = curExp / totalExp
    end
    self.progress:setPercentage(percent * 100)
    self.expText:setText(curExp .. "/" .. totalExp)
    if curExp >= totalExp then
        if not self.lastExp or self.lastExp < totalExp then
            self.rewardAni:setAnimation("idle2", true)
            self.fullAni:setAnimation("begin", false)
            self.fullAni:addAnimation("end", false)
            self.fullAni:addAnimation("idle", true)
            self.fullAni:show()
        end
    else
        if self.lastExp and self.lastExp >= totalExp then
            self.rewardAni:setAnimation("idle1", true)
            self.fullAni:hide()
        end
    end

    if self.lastExp and self.lastExp < curExp then
        local plant = self.planeList[self.curIndex]
        self:playOpenSmallBoxAnimation(self.curIndex)
    end
    self.lastExp = curExp
end

function StarPrayShopContentView:updateRemainingTimesText()

    if self.remainingTimesText then
        if UI.TEXT_221300 == "" then
            self.remainingTimesText:setText("")
        else
            local masterData = RoleDataManager:getMaster()
            local useNum = masterData:getAstrologyUsedCount()
            local starPrayDailyMaxTime = tonumber(ConfigManager:getGeneralForKey("StarPrayDailyMaxTime")) or 999
            local fNum = starPrayDailyMaxTime - useNum
            if fNum < 0 then
                fNum = 0
            end
            self.remainingTimesText:setText(UI.TEXT_221300 .. fNum)
        end
    end

    if self.sparkCurrency then
        local masterData = RoleDataManager:getMaster()
        local useNum = masterData:getCurVersionStarFire()
        local list = string.split(ConfigManager:getGeneralForKey("starFireLim"), ",")
        if #list >= 2 then
            local maxNum = tonumber(list[2]) or 999
            self.sparkCurrency:setText(UI.TEXT_228200 .. "(" .. useNum .. "/" .. maxNum .. ")")
            if useNum >= maxNum then
                self.sparkCurrency:setFontColor({r=239,g=28,b=15})
            end
        end
    end

end

function StarPrayShopContentView:onInitView()
    -- local spr = cc.Sprite:create("xxxx.png")
    -- spr:setOpacity(150)
    -- spr:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    -- self:addChild(spr)

    -- 货币组件
    local currencyPanel = UI.CurrencyPanel:create(UI.FONT_COLOR_TITLE_RARE_3)
    currencyPanel:rightUp(135, 81 - 14.5 --[[货币组件空白高度大小]])
    currencyPanel:setShowShopButton(true, 52)
    addChildAuto(layoutUU, self, currencyPanel, "currencyShop", "leftBottom")

    -- 今日剩余
    local remainingTimesText = UI.Text:create()
    remainingTimesText:init(UI.TEXT_221300 .. "999", UI.FONT_STANDARD, 16, {r=233,g=233,b=233})
    -- remainingTimesText:leftUp(-235, 81)
    addChildAuto(layoutUU, self, remainingTimesText, "remainingTimesText", "leftBottom")
    self.remainingTimesText = remainingTimesText
    
    if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityStarFire) then
        --星火 
        self.sparkCurrency = UI.Text:create()
        self.sparkCurrency:init(UI.TEXT_228200 .. "(1/1)", UI.FONT_STANDARD, 20, {r=239,g=180,b=36})
        addChildAuto(layoutUU, self, self.sparkCurrency, "sparkCurrency", "leftUp")

        --星火活动剩余时间描述
        self.activeTimeDes = UI.Text:create()
        local timeStr = mvc.tradeActivityModel:getActivityRemainTimeByID(PublicDefine.TradeActivityIDList.TradeActivityStarFire)
        self.activeTimeDes:init(UI.TEXT_228201 .. timeStr, UI.FONT_STANDARD, 20, {r=239,g=180,b=36})
        addChildAuto(layoutUU, self, self.activeTimeDes, "activeTimeDes", "centerUp")
    end

    self:updateRemainingTimesText()


    local useItemId = tonumber(ConfigManager:getGeneralForKey("StarPrayID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local goodsData = GoodsDataManager:createLocalGoodsData(useItemId)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoHeight()
    layout:enableAutoWidth()
    local icon = UI.Image:create()
    icon:init(goodsData:getSmallIconName())
    icon:floatLeft(0)
    layout:addComponent(icon)

    local text = UI.Text:create()
    text:init(tostring(goodNumber), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_TITLE_RARE_3)
    text:floatLeft(0)
    layout:addComponent(text)
    addChildAuto(layoutUU, self, layout, "currencyShoplayout", "leftBottom")
    self.coinText = text
    --plane
    local list = mvc.starPrayModel:getRandomShopQualityData()
    local com = UI.Component:create()
    com:init()
    com:setSize(10, 10)
    com:center(-95, -120)
    self:addChild(com)
    self.planeCom = com
    for i = 1, 5 do
        local plane = self:createOnePlane(i, list[i])
        -- plane:leftBottom(planePos[i].x, planePos[i].y)
        com:addChild(plane)

        -- addChildAuto(layoutUU, self, plane, "shop_plane" .. i, "leftBottom")
        table.insert(self.planeList, plane)
    end
    -- local com1 = UI.Component:create()
    -- com1:init()
    -- com1:setSize(150,150)
    -- com1:enableDebugDraw()
    -- self:enableDebugDraw()
    -- com1:setPosition(-20,0)
    -- -- self:addChild(com1)
    --     addChildAuto(layoutUU, self, com1, "shop_plane1", "leftBottom")

    self.executeButton, self.txtDiamondNum, self.diamondIcon =
        self:createSilverBtnInfos(
        "symbol_gaming_diamond.png",
        0,
        self.onLuckDrawClick,
        UI.TEXT_1212470,
        "dia",
        Game.ConstGoods.Diamond
    )

    self.coinButton, self.txtSilvNum =
        self:createSilverBtnInfos(
        "symbol_gaming_money.png",
        0,
        self.onLuckDrawSilverClick,
        UI.TEXT_1212741,
        "sil",
        Game.ConstGoods.Coin
    )

    -- 增加金币占星每日次数上限
    local coinNumberText = UI.Text:create()
    local cNum = mvc.starPrayModel:getSilverBuyCount()
    local mNum = tonumber(ConfigManager:getGeneralForKey("StarPrayGoldDailyMaxTime"))
    -- local coinNumberStr = string.format(UI.TEXT_1212743, cNum, mNum)
    local coinNumberStr = ""
    if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityStarFire) then
        coinNumberStr = UI.TEXT_228212
    end
    coinNumberText:init(coinNumberStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_TITLE_RARE_1)
    coinNumberText:center(0,-40)
    if cNum >= mNum then
        coinNumberText:setFontColor(UI.FONT_COLOR_TITLE_RARE_6)
    end
    self.coinButton:addChild(coinNumberText)
    self.coinNumberText = coinNumberText


    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_0.png")
    executeButton:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            if self.rewardLayer then
                return
            end
            local bagData = mvc.starPrayModel:getStarPrayData()
            local num = tonumber(ConfigManager:getGeneralForKey("StarPrayRapidTime"))
            if bagData.packetBoxBeUseNum - #bagData.haveItemArr <  num then
                UI.ScrollBar:createByText(UI.TEXT_1212471)
                return
            end

            local useItemId = tonumber(ConfigManager:getGeneralForKey("StarPrayID"))
            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
            local costList = string.split(ConfigManager:getGeneralForKey("StarPrayPrice"), ";")
            local costStr = costList[self.curIndex] or costList[#costList]
            local cost = string.split(costStr, ",")

            local costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_Diamond
            if (goodNumber >= tonumber(cost[2])) then --虚拟币
                local goodNumberExclude = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true,nil, true)
                costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_StarPrayCoin
                if goodNumberExclude < tonumber(cost[2]) then
                    UI.ScrollBar:createByText(UIUtil:lang(1170121))
                    return
                end
            else
                if not Avalon.MathUtil:checkDiamonEnough(tonumber(cost[1]), GameDataManager:getInstance():getDiamond()) then
                    UI.TipsLayer:onDiamondNotEnough()
                    return
                end
            end
                

            Avalon.AudioManager:playSound("1549", false)

            UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(
                string.format(UI.TEXT_1213421, tostring(num)),
                function(isSelect)
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                    self:preTenClickAnimation()
                    mvc.send(mvc.events.StarPray_Shop_Ten_Click, self.spriteId)
                end,
                function(isSelect)
                end
            )
        end
    )
    executeButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    executeButton:setText(string.format(UI.TEXT_1213422, tostring(ConfigManager:getGeneralForKey("StarPrayRapidTime"))))
    executeButton:center()
    addChildAuto(layoutUU, self, executeButton, "shop_tenButton", "center")
    self.tenButton = executeButton
    --tips
    local com = UI.Component:create()
    com:init()
    com:setSize(10,10)
    addChildAuto(layoutUU, self, com, "shop_tenButton_layout", "center")
    
    --tips
    local tipLayout = UI.Layout:create()
    tipLayout:init()
    tipLayout:enableAutoWidth()
    tipLayout:enableAutoHeight()
    tipLayout:center(0, 0)
    com:addChild(tipLayout)   

    local tipIcon = UI.Image:create()
    tipIcon:init("ui_information_reminder.png")
    tipIcon:floatLeft(1)
    tipLayout:addComponent(tipIcon)

    local tips = UI.Text:create()
    tips:init(UI.TEXT_1213423, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_51_51)
    tips:floatLeft(3)
    tips:setWidth(240)
    tips:enableWrap(true)
    local size = tips:getContentSize()
    if size.height > 27 then
        tips:setFontSize(16)
        tips:setLineSpacing(-9)
        tips:updateView()
        local size = tips:getContentSize()
        tips:setSize(250,size.height)
    end
    tips:setTextCenter()
    tipLayout:addComponent(tips)
    -- local size = tips:getContentSize()
    -- tips:setSize(250,size.height)
    -- tips:enableDebugDraw()
     
    local progressBg = UI.Image:create()
    progressBg:init("ui_starpray_banner_countdown_box.png")
    addChildAuto(layoutUU, self, progressBg, "shop_progressBg")
    local percent = 0
    local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_starpray_banner_countdown.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(percent)
    addChildAuto(layoutUU, self, progress, "shop_progress")
    self.progress = progress

    local fullAni = UI.Animation:create()
    fullAni:init("effect_ui_starpray_full.json", "effect_ui_starpray_full.atlas", 1)
    fullAni:setAnimation("idle", true)
    local size = fullAni:getBoundingBox()
    fullAni:setSize(size.width, size.height)
    addChildAuto(layoutUU, self, fullAni, "shop_progress1")
    fullAni:hide()
    self.fullAni = fullAni

    local reward = UI.Animation:create()
    reward:init("effect_ui_starpray_giftbag.json", "effect_ui_starpray_giftbag.atlas", 1)
    reward:setAnimation("idle1", true)

    local size = reward:getBoundingBox()
    reward:setSize(size.width, size.height)
    addChildAuto(layoutUU, self, reward, "shop_rewardAni", "center")
    reward:setTouchEnable(true)
    reward:setSwallowTouches(false)
    reward:addEventListener(
        UIEvent.COMPONENT_CLICK,
        self,
        function()
            if self.framentbgSpineDown then
                return
            end
            self.oldCurIdx = self.curIndex
            mvc.send(mvc.events.StarPray_Shop_GetReward)
        end
    )
    self:autoChoicePlane(self.curIndex, true)
    self.rewardAni = reward

    local text = UI.Text:create()
    text:init(UI.TEXT_1212740, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_TITLE_RARE_3)
    addChildAuto(layoutUU, self, text, "shop_luckyText", "centerRight")

    local text = UI.Text:create()
    text:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_TITLE_RARE_3)
    addChildAuto(layoutUU, self, text, "shop_expText", "centerRight")
    self.expText = text
    -- Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.refreshExp, 1)

    self:refreshExp()
end

function StarPrayShopContentView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshCost)
    mvc.starPrayModel:bind("luckyDrawData", self, self.luckDrawCallback)
    mvc.starPrayModel:bind("shopReward", self, self.showShopReward)

    mvc.starPrayModel:bind("curSilverBuyCount", self, self.refreshSilCost)
    mvc.starPrayModel:bind("curShopExp", self, self.refreshExp)
end

function StarPrayShopContentView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshCost)
    mvc.starPrayModel:unbind("luckyDrawData", self, self.luckDrawCallback)
    mvc.starPrayModel:unbind("shopReward", self, self.showShopReward)
    mvc.starPrayModel:unbind("curSilverBuyCount", self, self.refreshSilCost)
    mvc.starPrayModel:unbind("curShopExp", self, self.refreshExp)
end

function StarPrayShopContentView:updateStarPrayCoin()
    local useItemId = tonumber(ConfigManager:getGeneralForKey("StarPrayID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    self.coinText:setText(tostring(goodNumber))
end

function StarPrayShopContentView:createOnePlane(index, qualityDatas)
    local masterData = RoleDataManager:getMaster()
    if masterData:getIsReincarntion() then
        table.insert(attachNames, "starpray-stone-05hong")
    end
    local plane = UI.Animation:create()
    plane:init(
        string.format("effect_ui_starpray_planet%.2d.json", index),
        string.format("effect_ui_starpray_planet%.2d.atlas", index),
        1
    )
    plane:setAnimation("idle", false)
    local size = plane:getBoundingBox()
    plane:setSize(size.width, size.height)
    plane:setSize(size.width, size.height)
    plane:setTag(index)

    local list = 1
    local _slotNames = slotNames[#qualityDatas] or slotNames[#slotNames]
    for k, slotName in ipairs(_slotNames) do
        local attachName = noAttachImage
        if qualityDatas[k] ~= nil then
            attachName = attachNames[qualityDatas[k]]
        end
        plane:setAttachment(slotName, attachName)
    end
    return plane
end

function StarPrayShopContentView:showRewardTip(sender)
    if self.planeInfo then
        self.planeInfo:removeFromParent()
    end
    local info = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
    info:setCapInsets(CCRectMake(7, 7, 1, 1))
    sender:getParent():addChild(info, 200)
    info:setContentSize(200, 60)
    info:setPosition(sender:getContentSize().width / 2, -20)

    local richTextStr =
        AvalonUtil:serializeText(UIUtil:lang(1112500), UI.FONT_COLOR_153_153_153, DEFALAULT_FONT_SIZE, UI.FONT_TITLE)

    local richText = UI.RichText:create()
    local success = richText:init(richTextStr, nil, nil, true)
    if success then
        richText:centerUp(3)
        info:setContentSize(richText:getContentSize().width + 15, 30)
        local pos = sender:convertToWorldSpace(cc.p(0, 0))

        info:setPosition(sender:getPositionX() - info:getContentSize().width / 2, sender:getPositionY() + 120)
        info:addChild(richText)
    end
    self.planeInfo = info
end

function StarPrayShopContentView:showPlaneInfo(sender, rect)
    if self.planeInfo then
        self.planeInfo:removeFromParent()
    end
    local info = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
    info:setCapInsets(CCRectMake(7, 7, 1, 1))
    self:addChild(info, 200)
    info:setContentSize(200, 60)
    info:setPosition(rect.x, rect.y - 20)

    local list = mvc.starPrayModel:getRandomShopQualityData()
    local richText = AvalonUtil.getQulityRichTexts(list[sender:getTag()], DEFALAULT_FONT_SIZE, UI.FONT_TITLE)
    local content =
        AvalonUtil:formartRichText(
        UI.FONT_COLOR_153_153_153,
        DEFALAULT_FONT_SIZE,
        UI.FONT_TITLE,
        UI.TEXT_1212524,
        richText
    )
    local richText = UI.RichText:create()
    local success = richText:init(content, nil, nil, true)
    if success then
        richText:centerUp(7)
        info:setContentSize(richText:getContentSize().width + 15, 60)
        if rect.x < COM_WIDTH / 2 then
            info:setPosition(rect.x + rect.width / 2 + info:getContentSize().width / 2, rect.y + rect.height)
        else
            info:setPosition(rect.x - rect.width / 2, rect.y + 120)
        end
        info:addChild(richText)
    end

    local coinPrayStr = string.format(UI.TEXT_1212525, mvc.starPrayModel:getSilverBuyCount())
    local richTextStr =
        AvalonUtil:serializeText(coinPrayStr, UI.FONT_COLOR_153_153_153, DEFALAULT_FONT_SIZE, UI.FONT_TITLE)

    local richText = UI.RichText:create()
    local success = richText:init(richTextStr, nil, nil, true)
    if success then
        richText:centerUp(28)
        info:addChild(richText, 100)
    end

    self.planeInfo = info
end

function StarPrayShopContentView:hidePlaneInfo()
    if self.planeInfo then
        self.planeInfo:removeFromParent()
        self.planeInfo = nil
    end
end

function StarPrayShopContentView:autoChoicePlane(index, isFirst)
    for k, plane in ipairs(self.planeList) do
        if k == index then
            plane:setAnimation("select", true)
            if self.prepareSound then
                Avalon.AudioManager:stopSound(self.prepareSound)
            end
            self.prepareSound = Avalon.AudioManager:playSound("1548", true)
        else
            plane:addAnimation("idle", false)
            if isFirst then
                plane:playTransFormGray(0, true)
            end
        end
    end
    self:refreshCost()
    self:refreshSilCost()
    self.executeButton:enable()
    self.coinButton:enable()
end

function StarPrayShopContentView:showTenResultCaiDai(idx)
    local planeIdx = rewardList[idx]
    if planeIdx and self.planeList[planeIdx + 1] then
        local caidai = UI.Animation:create()
        caidai:init("effect_ui_starpray_ribbon_single.json", "effect_ui_starpray_ribbon_single.atlas", 1)
        caidai:setAnimation("begin", false)
        caidai:addEventListener(
            UIEvent.ANIMATION_COMPLETE,
            self,
            function(sender, event)
                caidai:runAction(cc.RemoveSelf:create())
            end
        )
        self.planeList[planeIdx + 1]:addComponent("effect01", caidai)
    else
        self:playCaiDaiOver()
        return
    end
    Avalon.AudioManager:playSound("1553", false)

    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(
        self,
        function()
            if tolua.isnull(self) then
                return
            end
            self:showTenResultCaiDai(idx + 1)
        end,
        0.2
    )
end

function StarPrayShopContentView:doTenDrawResult(isSucc, goodsData, starPrayPools, costID, costNum)
    if not isSucc then
        self:tenSelectFinished()
        return
    end

    for i = 1, #costID do
        if costID[i] == 22050100 then
            self:showStarPrayCoinCostAni(costNum[i])
        end
    end
    local master = GameDataManager:getInstance():getMaster()
    master:setStarPrayPool(starPrayPools[#starPrayPools])
    local oldIdx = self.curIndex - 1
    self.curIndex = starPrayPools[#starPrayPools] + 1
    starPrayPools[#starPrayPools] = nil
    table.insert(starPrayPools, 1, oldIdx)
    rewardList = starPrayPools
    self.tenRewards = {}

    for _, data in ipairs(goodsData) do
        table.insert(self.tenRewards, {id = data.templateID, num = data.num})
    end
    self:tenDrawResult()

    self:updateStarPrayCoin()
end

function StarPrayShopContentView:tenDrawResult()
    -- rewardList = {1,2,3,1,4}
    --播放彩带
    self:showTenResultCaiDai(1)
end

function StarPrayShopContentView:tenSelectFinished()
    if self.planeList then
        for k, plane in ipairs(self.planeList) do
            if k ~= self.curIndex then
                plane:playTransFormGray(1, true)
            end
        end
    
        self:autoChoicePlane(self.curIndex)
        if self.touchLayer then
            self.touchLayer:removeFromParent()
            self.touchLayer = nil
        end
    end
end

function StarPrayShopContentView:playCaiDaiOver()
    --这里是10连抽结果，获得奖励的地方

    self:showReward()

    -- local rewards = self.tenRewards
    -- local itemData = {}
    -- for k, v in pairs(rewards) do
    --     local goodData = GoodsDataManager:createLocalGoodsData(v.id)
    --     if (goodData) then
    --         goodData:setIsNew(false)
    --         goodData:setNum(v.num)
    --         table.insert(itemData, goodData)
    --     end
    -- end
    -- local titleStr = nil
    -- Avalon.MessageCenter:notice(
    --     GameMessage.MC_UI_COMMON_REWARD,
    --     itemData,
    --     function()
    --         self:tenSelectFinished()
    --     end,
    --     titleStr,
    --     nil,
    --     nil,
    --     true
    -- )
end

function StarPrayShopContentView:preTenClickAnimation()
    local winSize = cc.Director:getInstance():getWinSize()
    local touchLayer = UI.Component:create()
    touchLayer:init()
    touchLayer:setSize(winSize.width + 400, winSize.height + 400)
    touchLayer:setTouchEnable(true)
    touchLayer:setSwallowTouches(true)
    for k, plane in ipairs(self.planeList) do
        plane:playTransFormGray(0.5, false)
        plane:setAnimation("select", true)
    end
    touchLayer:enableDebugDraw()
    touchLayer:center()
    self:addChild(touchLayer, 100010)
    self.touchLayer = touchLayer
end

function StarPrayShopContentView:runLuckDraw(index)
    for k, plane in ipairs(self.planeList) do
        if k == index then
            plane:setAnimation("luckydraw", true)
            Avalon.AudioManager:playSound("1553", false)
            Avalon.AudioManager:playSound("1549", false)
        else
            plane:setAnimation("idle", false)
        end
    end
end

function StarPrayShopContentView:randomPlane(oldIndex, curIndex)
    local time = 0
    if oldIndex == curIndex then
        time = 0.5
    else
        for k, plane in ipairs(self.planeList) do
            if k == curIndex then
                Avalon.Scheduler:scheduleUpdateOnce(
                    self,
                    function()
                        if not tolua.isnull(self) then
                            plane:playTransFormGray(1, false)
                            Avalon.AudioManager:playSound("1551", false)
                        end
                    end,
                    0.6
                )
            elseif k == oldIndex then
                plane:playTransFormGray(1, true)
                Avalon.AudioManager:playSound("1551", false)
            end
        end
        -- time = 1.6
        time = 0.6
    end

    Avalon.Scheduler:scheduleUpdateOnce(
        self,
        function()
            if not tolua.isnull(self) then
                self:autoChoicePlane(self.curIndex)
            end
        end,
        time
    )
end

function StarPrayShopContentView:onLuckDrawSilverClick()
    if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212471)
        return
    end
    if self.rewardLayer then
        return
    end

    local cNum = mvc.starPrayModel:getSilverBuyCount()
    local mNum = tonumber(ConfigManager:getGeneralForKey("StarPrayGoldDailyMaxTime"))
    if cNum >= mNum then
        UI.ScrollBar:createByText(UI.TEXT_1212744)
        return
    end

    self.tenButton:disable()
    self.tenButton:enable(2)
    local costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_Coin

    local cost = mvc.starPrayModel:getShopCostSilver(self.curIndex)
    local curCoin = GameDataManager:getGoodsDataNumForGoodsID(Game.ConstGoods.Coin)
    if not Avalon.MathUtil:checkDiamonEnough(cost, curCoin) then
        UI.ScrollBar:createByText(UI.TEXT_1110389)
        return
    end
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetGoodsSystem:requestStarPrayLuckyDrop(self.spriteId, costType)
end

function StarPrayShopContentView:onLuckDrawClick()
    if self.isGetResult or self.rewardLayer then
        return
    end
    self.tenButton:disable()
    self.tenButton:enable(2)

    if RoleBehaviorManager:starPrayCheck() then
        printError("blocked when use star pray function !")
        return
    end

    if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212471)
        return
    end
    local useItemId = tonumber(ConfigManager:getGeneralForKey("StarPrayID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local costList = string.split(ConfigManager:getGeneralForKey("StarPrayPrice"), ";")
    local costStr = costList[self.curIndex] or costList[#costList]
    local cost = string.split(costStr, ",")

    local costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_Diamond
    if (goodNumber >= tonumber(cost[2])) then --虚拟币
        local goodNumberExclude = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true,nil, true)
        costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_StarPrayCoin
        if goodNumberExclude < tonumber(cost[2]) then
            UI.ScrollBar:createByText(UIUtil:lang(1170121))
            return
        end
    else
        costType = PublicDefine.StarPrayDrawType.StarPrayDrawType_Diamond
        if not Avalon.MathUtil:checkDiamonEnough(tonumber(cost[1]), GameDataManager:getInstance():getDiamond()) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
        local isShow =
            cc.UserDefault:getInstance():getBoolForKey(
            UserDefaultKeyWord.StarPrayShopCost .. GameDataManager:getInstance():getMasterPK(),
            true
        )
        if isShow then
            UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                UI.TEXT_1212608,
                function(isSelect)
                    if isSelect then
                        cc.UserDefault:getInstance():setBoolForKey(
                            UserDefaultKeyWord.StarPrayShopCost .. GameDataManager:getInstance():getMasterPK(),
                            false
                        )
                    end
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                    Net.NetGoodsSystem:requestStarPrayLuckyDrop(self.spriteId, costType)
                    self:runLuckDraw(self.curIndex)
                end,
                function(isSelect)
                end,
                nil,
                nil,
                true,
                tonumber(cost[1])
            )
            return
        end
    end
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetGoodsSystem:requestStarPrayLuckyDrop(self.spriteId, costType)
    self:runLuckDraw(self.curIndex)
end

function StarPrayShopContentView:refreshSilCost()
    local cost = mvc.starPrayModel:getShopCostSilver(self.curIndex)
    self.txtSilvNum:updateCost(cost, tostring(cost))

    if self.coinNumberText then
        local cNum = mvc.starPrayModel:getSilverBuyCount()
        local mNum = tonumber(ConfigManager:getGeneralForKey("StarPrayGoldDailyMaxTime"))
        -- local coinNumberStr = string.format(UI.TEXT_1212743, cNum, mNum)
        local coinNumberStr = ""
        if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityStarFire) then
            coinNumberStr = UI.TEXT_228212
        end
        self.coinNumberText:setText(coinNumberStr)
        if cNum >= mNum then
            self.coinNumberText:setFontColor(UI.FONT_COLOR_TITLE_RARE_6)
        else
            self.coinNumberText:setFontColor(UI.FONT_COLOR_TITLE_RARE_1)
        end
    end
end

function StarPrayShopContentView:refreshCost()
    if self.isGetResult or self.lockCloseReward then
        return
    end
    local useItemId = tonumber(ConfigManager:getGeneralForKey("StarPrayID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local costList = string.split(ConfigManager:getGeneralForKey("StarPrayPrice"), ";")
    local costStr = costList[self.curIndex] or costList[#costList]
    local cost = string.split(costStr, ",")

    if (goodNumber >= tonumber(cost[2])) then
        local goodsData = GoodsDataManager:createLocalGoodsData(useItemId)
        self.diamondIcon:setSpriteName(goodsData:getSmallIconName())
        self.txtDiamondNum.costGoodsTemplateId = useItemId
        self.txtDiamondNum:updateCost(tonumber(cost[2]), cost[2])
    else
        self.diamondIcon:setSpriteName("symbol_gaming_diamond.png")
        self.txtDiamondNum.costGoodsTemplateId = Game.ConstGoods.Diamond
        self.txtDiamondNum:updateCost(tonumber(cost[1]), cost[1])
    end

    --这里顺便刷新剩余次数
    self:updateRemainingTimesText()
end

function StarPrayShopContentView:showStarPrayCoinCostAni(num)
    if (self._waitingNum2 == nil) then
        self._waitingNum2 = 0
    end

    local delayTime = self._waitingNum2 * 0.5
    if (delayTime < 0) then
        delayTime = 0
    end

    -- 处理金币以及钻石表现
    local text = UI.Text:create()
    text:init("", UI.FONT_BOLD)
    -- text:centerBottom(10)
    text:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    text:setText("-" .. tostring(num))
    text:updateView()
    text:setVisible(false)
    text:leftBottom(478, 484)
    self:addChild(text)
    -- addChildAuto(layoutUU, self, text, "maxPos")
    Avalon.Scheduler:scheduleUpdateOnce(
        self,
        function()
            if (self and not tolua.isnull(self)) then
                text:setVisible(true)
                text:runAction(
                    cc.Spawn:create(
                        cc.MoveBy:create(0.5, cc.p(0, 20)),
                        cc.Sequence:create(
                            cc.DelayTime:create(0.4),
                            cc.FadeOut:create(0.1),
                            cc.RemoveSelf:create(),
                            cc.CallFunc:create(
                                function()
                                    self._waitingNum2 = self._waitingNum2 - 1
                                end
                            )
                        )
                    )
                )
            end
        end,
        delayTime
    )
    self._waitingNum2 = self._waitingNum2 + 1
end

function StarPrayShopContentView:luckDrawCallback()
    if self.rewardLayer then
        return
    end

    if self.showExpTuowei then
        self.needShowReward = self.luckDrawCallback
        return
    end
    local data = mvc.starPrayModel:getLuckyDrawData()
    if data.isSuccess then
        self.isGetResult = true
        self.oldIndex = self.curIndex
        self.curIndex = data.curIndex
        for k, plane in ipairs(self.planeList) do
            plane:setAnimation("idle", false)
        end
        self.isGetResult = false
        self:showReward()
        
    else
        self:autoChoicePlane(self.curIndex)
    end
end

function StarPrayShopContentView:showShopReward(isRefreshPlant)
    if self.showExpTuowei then
        self.needShowReward = self.showShopReward
        return
    end
    self:showReward(true)
end
local winSize = cc.Director:getInstance():getWinSize()

function StarPrayShopContentView:showRewardGoodsListView(parentNode,goodsListData)
    if not goodsListData or #goodsListData == 0 then
        return
    end

    local node1 = UI.Layout.create()
    node1:init()
    parentNode:addChild(node1)

    local node2 = UI.Layout.create()
    node2:init()
    parentNode:addChild(node2)

    if #goodsListData == 1 then
        node1:center(0, -90)
    else
        node1:center(-285, -132)
        node2:center(-285, -42)
    end

    for k,v in ipairs(goodsListData) do
        local goodNode = UI.Layout.create()
        goodNode:init()
        goodNode:setSize(90, 90)

        local goodData = GoodsDataManager:createLocalGoodsData(v.id)
        goodData:setIsNew(false)

        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:center()
        goodGrid:showInfoArea(true, false)

        goodNode:addChild(goodGrid)

        if #goodsListData == 1 then
            goodNode:center()
            node1:addChild(goodNode)
        else
            goodNode:floatLeft(20)
            if k <= 5 then
                node1:addComponent(goodNode)
            else
                node2:addComponent(goodNode)
            end
        end
    end

end


function StarPrayShopContentView:showReward(isRefreshPlant)

    --单抽表现在这里
    self.lockCloseReward = false

    Avalon.AudioManager:playSound("1550", false)
    if self.rewardLayer then
        self.rewardLayer:removeFromParent()
        self.mask:removeFromParent()
    end
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)
    self.mask = mask

    self:updateStarPrayCoin()

    self.rewardLayer = UI.Layout.create()
    self.rewardLayer:init()
    self.rewardLayer:center()
    self.rewardLayer:setSize(winSize.width, winSize.height)

    self.rewardLayer:setScale(0.1)
    self.rewardLayer:runAction(cc.EaseOut:create(cc.ScaleTo:create(0.15, 1), 1))

    self:addChild(self.rewardLayer, 10)
    
    local goodsListData = {}
    local data = mvc.starPrayModel:getLuckyDrawData()
    if data.goodsData then
        table.insert(goodsListData, {id = data.goodsData.templateID})
    elseif self.tenRewards and #self.tenRewards > 0 then
        goodsListData = self.tenRewards
    end

    if table.nums(goodsListData) >= 10 then
        --播放特效 effect_ui_town_xingpan_achieve
        local achieveSpine = UI.Animation:create()
        achieveSpine:init("effect_ui_town_xingpan_achieve.json", "effect_ui_town_xingpan_achieve.atlas")
        achieveSpine:setAnimation("idle", false)
        achieveSpine:center(0, -88)
        self.rewardLayer:addChild(achieveSpine)
    end

    self:showRewardGoodsListView(self.rewardLayer, goodsListData)

    local titleImg = UI.Image:create()
    titleImg:init("ui_starmarks_line.png")
    titleImg:center(0, -212)
    self.rewardLayer:addChild(titleImg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_228202, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 245, g = 211, b = 111})
    titleText:center(0, -212)
    self.rewardLayer:addChild(titleText)

    if mvc.starPrayModel.starFireNum and mvc.starPrayModel.starFireNum > 0 then

        local titleImg2 = UI.Image:create()
        titleImg2:init("ui_starmarks_line.png")
        titleImg2:center(0, 38)
        self.rewardLayer:addChild(titleImg2)

        local titleText2 = UI.Text:create()
        titleText2:init(UI.TEXT_228203, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 245, g = 211, b = 111})
        titleText2:center(0, 38)
        self.rewardLayer:addChild(titleText2)

        local goodNode = UI.Layout.create()
        goodNode:init()
        goodNode:setSize(90, 90)

        local goodData = GoodsDataManager:createLocalGoodsData(23570001)
        goodData:setNum(mvc.starPrayModel.starFireNum)
        goodData:setIsNew(false)

        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:center(0,110)
        goodGrid:showInfoArea(true, false)

        self.rewardLayer:addChild(goodGrid)
    end



    self:refreshCost()
    self:refreshSilCost()
    self.executeButton:enable()
    self.coinButton:enable()
    mvc.starPrayModel:clearRewardData()
    self.tenRewards = {}

    self:tenSelectFinished()
    
    self.oldIndex = self.oldIndex == nil and self.curIndex or self.oldIndex
    self:randomPlane(self.oldIndex, self.curIndex)

    -- local goodData = GoodsDataManager:createLocalGoodsData(data.goodsData.templateID)

    -- local ProtobufUtil = require "utils.ProtobufUtil"
    -- local netData = ProtobufUtil:decode("GoodsSystem.StarPrayData", data.goodsData.goodsDataBytes)
    -- goodData:initNetData(netData)
    -- goodData:setIsNew(false)

    -- local name = UI.Text:create()
    -- name:init(goodData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.ITEM_QUALITY_FONT_COLOR[goodData:getGoodsRare()])
    -- name:centerUp(-54)
    -- self.rewardLayer:addChild(name, 100)
    -- name:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))

    -- local panel = self:createStars(goodData:getGoodsRare())
    -- panel:centerUp(-33)
    -- self.rewardLayer:addChild(panel, 100)


    -- local goodGrid = UI.GoodsGrid:create()
    -- goodGrid:init(goodData)
    -- goodGrid:center()
    
    -- self.goodGrid = goodGrid
    -- local framentbgSpineDown = UI.Animation:create()
    -- framentbgSpineDown:init("effect_ui_starpray_top_down.json", "effect_ui_starpray_top_down.atlas")
    -- framentbgSpineDown:setAnimation("begin", false)
    -- framentbgSpineDown:center()
    -- self.framentbgSpineDown = framentbgSpineDown

    -- if isRefreshPlant then
    --     self.framentbgSpineDown = nil
    -- end

    -- local framentbgSpineUp = UI.Animation:create()
    -- framentbgSpineUp:init("effect_ui_starpray_top_up.json", "effect_ui_starpray_top_up.atlas")
    -- framentbgSpineUp:setAnimation("begin", false)
    -- framentbgSpineUp:center()
    -- self.framentbgSpineUp = framentbgSpineUp

    -- local flowerSpine = UI.Animation:create()
    -- flowerSpine:init("effect_ui_starpray_ribbon.json", "effect_ui_starpray_ribbon.atlas")
    -- flowerSpine:setAnimation("begin", false)
    -- flowerSpine:centerUp(200)
    -- self.flowerSpine = flowerSpine

    -- self.rewardLayer:addChild(framentbgSpineDown, 1)
    -- self.rewardLayer:addChild(framentbgSpineUp, 10)
    -- self.rewardLayer:addChild(flowerSpine, 10)
    -- self.rewardLayer:addChild(goodGrid, 5)
    -- self.rewardLayer:centerUp(layerSize.height / 5)
    -- self:addChild(self.rewardLayer, 10)
    -- self.lockCloseReward = true
    -- framentbgSpineDown:addEventListener(
    --     UIEvent.ANIMATION_COMPLETE,
    --     self,
    --     function(_, event, sender)
    --         if (event.animation == "begin") then
    --             self.lockCloseReward = false
    --             framentbgSpineDown:setAnimation("loop", true)
    --         elseif (event.animation == "end") then
    --             self.lockCloseReward = false
    --             self.framentbgSpineDown:destroy()
    --             self.framentbgSpineUp:destroy()
    --             self.flowerSpine:destroy()
    --             self.rewardLayer:runAction(cc.RemoveSelf:create())
    --             self.rewardLayer = nil
    --             self.mask:removeFromParent()
    --             self.mask = nil
    --             self.framentbgSpineDown = nil
    --             self.framentbgSpineUp = nil
    --             self.oldIndex = self.oldIndex == nil and self.curIndex or self.oldIndex
    --             self:randomPlane(self.oldIndex, self.curIndex)
    --             self:hideSwallowAllTouch()
    --         end
    --     end
    -- )
end

function StarPrayShopContentView:createStars(number)
    -- body
    local layout = UI.Layout:create()
    layout:init()

    local list = {}
    for i = 1, number do
        local star = UI.Image:create()
        star:init("ui_starpray_star_0.png")
        star:setScale(0.8)
        table.insert(list, star)
    end
    local width = 40 * #list + 32

    layout:setSize(width, 50)
    for k, v in ipairs(list) do
        v:centerLeft(14 + (k - 1) * 40)
        layout:addChild(v, 100)
    end
    return layout
end
local plantRect = {
    cc.rect(-14, 302, 155, 155),
    cc.rect(154, 183, 155, 155),
    cc.rect(334, 292, 155, 155),
    cc.rect(536, 185, 155, 155),
    cc.rect(727, 271, 155, 155)
}
function StarPrayShopContentView:onTouchBegan(grid, touchPosition)
    if self.rewardLayer ~= nil then
        if self.rewardLayer:checkTouchPosition(touchPosition) and self.goodGrid then
            self.goodsGridInfo = self.goodGrid:onShowInfoAreaHandler(false)
            self.goodsGridInfo:centerLeft(100)
            return
        end
        if self.framentbgSpineDown == nil then
            self.rewardLayer:removeSelf()
            self.rewardLayer = nil
            self.mask:removeFromParent()
            self.mask = nil

            self.goodGrid = nil
            return
        elseif not self.lockCloseReward then
            self.lockCloseReward = true
            -- self.framentbgSpineDown:setAnimation("end", false)
            -- self.framentbgSpineUp:setAnimation("end", false)
            self.rewardLayer:runAction(cc.ScaleTo:create(0.15, 0))
            return
        end
    else
        if self.rewardAni:checkTouchPosition(touchPosition) then
            self:showRewardTip(self.rewardAni)
            return
        end
        local localPosition = self:convertToNodeSpace(touchPosition)

        for i = 1, #plantRect do
            if cc.rectContainsPoint(plantRect[i], localPosition) then
                self:showPlaneInfo(self.planeList[i], plantRect[i])
                return
            end
        end
    end
end

function StarPrayShopContentView:onTouchEnded(grid, touchPosition)
    self:hidePlaneInfo()
    if self.rewardLayer ~= nil then
        return
    end
end

function StarPrayShopContentView:doSwallowAllTouch()
    self.executeButton:disable()
    self.coinButton:disable()
end

function StarPrayShopContentView:hideSwallowAllTouch()
end

function StarPrayShopContentView:playOpenSmallBoxAnimation(idx)
    self:doSwallowAllTouch()
    self.needShowReward = nil
    self.showExpTuowei = true
    local flyAnimation = UI.Animation:create()
    flyAnimation:init("effect_ui_starpray_tuowei.json", "effect_ui_starpray_tuowei.atlas", 1)
    flyAnimation:center(95, 113)
    self.planeCom:addChild(flyAnimation)
    flyAnimation:addEventListener(
        UIEvent.ANIMATION_COMPLETE,
        self,
        function(sender, event)
            flyAnimation:runAction(cc.RemoveSelf:create())
            self.showExpTuowei = false
            if self.needShowReward then
                self.needShowReward(self)
            end
        end
    )
    flyAnimation:addAnimation("trigger" .. idx, false)
end

return StarPrayShopContentView
