------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
local TradeActivityDailyPayView = class("TradeActivityDailyPayView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

local DAILY_PAY_ACTIVITY_ID = PublicDefine.TradeActivityIDList.TradeActivityDailyPay

function TradeActivityDailyPayView:ctor()
    TradeActivityDailyPayView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_DAILY_PAY,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    -- 领取状态
    self.getState = true

    self:bindModel()
end

function TradeActivityDailyPayView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityDailyPayView.super.init(self, ... )
end

function TradeActivityDailyPayView:dtor()
    TradeActivityDailyPayView.super.dtor(self)

    self.getState = true

    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityDailyPayView")
end

function TradeActivityDailyPayView:bindModel()
    mvc.tradeActivityModel:bind("_targetList", self, self.updateBuyBtn)
end


function TradeActivityDailyPayView:unbindModel()
    mvc.tradeActivityModel:unbind("_targetList", self, self.updateBuyBtn)
end


function TradeActivityDailyPayView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 右侧底图
    local innerBg = UI.Image:create()
    innerBg:init("ui_businessactivities_bg_02.png")
    innerBg:center()
    contentLayout:addChild(innerBg)

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_businessactivities_illustration_03.png")
    innerBG:center()
    -- innerBG:enableDebugDraw()
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    -- 标题
    local titleLayout = UI.Layout:create()
    titleLayout:init()
    titleLayout:enableAutoWidth()
    titleLayout:enableAutoHeight()
    titleLayout:centerUp(16)
    self.contentLayout:addChild(titleLayout)

    local leftLine = UI.Image:create()
    leftLine:init("ui_businessactivities_trennlinie.png")
    leftLine:floatLeft(0)
    leftLine:setRotation(180)
    titleLayout:addComponent(leftLine)

    local configData = ConfigManager:getTradeActivityDataByID(PublicDefine.TradeActivityIDList.TradeActivityDailyPay)

    local title = UI.Text:create()
    title:init(configData.name, UI.FONT_BOLD, UI.FONT_SIZE_48PX, UI.FONT_COLOR_255_255_255)
    title:floatLeft(6)
    -- title:enableDebugDraw()
    title:setSize(280, 88)
    title:setTextCenter()
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        title:setFontSize(UI.FONT_SIZE_30PX)
        title:setLineSpacing(-8)

        local titleShadow = UI.Text:create()
        titleShadow:init(configData.name, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_0_0_0)
        titleShadow:center(3, 3)
        titleShadow:setSize(280, 88)
        titleShadow:setTextCenter()
        titleShadow:setLineSpacing(-8)
        title:addChild(titleShadow, -10)
    else
        title:setFontSize(UI.FONT_SIZE_48PX)
        title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    end
    titleLayout:addComponent(title)

    local rightLine = UI.Image:create()
    rightLine:init("ui_businessactivities_trennlinie.png")
    rightLine:floatLeft(6)
    titleLayout:addComponent(rightLine)

    -- 左侧圆盘图
    local leftBg  = UI.Image:create()
    leftBg:init("ui_businessactivities_bg_04.png")
    leftBg:center(-130, 60)
    contentLayout:addChild(leftBg)

    self:updateAwardsLayer()

    -- 按钮
    local buyButton = UI.Button:create()
    buyButton:init('ui_businessactivities_btn_04.png', 'ui_businessactivities_btn_04.png', 'ui_businessactivities_btn_gray_04.png')
    buyButton:center(-19, 114)
    buyButton:setText(UI.TEXT_1324512)
    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
        local targetInfo = groupInfo[1]

        if targetInfo.stat == 2 then
            self:getAwards()
        else
            mvc.panelMonitor:hideTopPanel()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, true, 1, nil, 2)
        end
    end)
    leftBg:addChild(buyButton)
    self.buyButton = buyButton
    self:updateBuyBtn()

    -- 右侧图片
    local rightBg  = UI.Image:create()
    rightBg:init("ui_businessactivities_illustration_04.png")
    rightBg:centerRight(-30, 34)
    contentLayout:addChild(rightBg)

    self:updateDesc()

    -- 活动时间
    local activityTime = UI.Text:create()
    activityTime:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    activityTime:rightBottom(8, 6)
    contentLayout:addChild(activityTime)
end


function TradeActivityDailyPayView:updateDesc()
    -- 描述
    local descBg  = UI.Image:create()
    descBg:init("ui_businessactivities_up_02.png")
    descBg:center(0, -96)
    self.contentLayout:addChild(descBg)

    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        local richText = self:getDescRichText()
        richText:centerLeft(0)
        descBg:addChild(richText)
    else
        local descText = UI.Text:create()
        descText:init(UI.TEXT_1324517, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_255_255)
        descText:centerLeft(4)
        descText:setSize(652, 54)
        descText:setTextLeft()
        descText:setLineSpacing(-4)

        local titleShadow = UI.Text:create()
        titleShadow:init(UI.TEXT_1324517, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_0_0_0)
        titleShadow:centerLeft(6, 2)
        titleShadow:setSize(652, 54)
        titleShadow:setTextLeft()
        titleShadow:setLineSpacing(-4)

        descBg:addChild(titleShadow)
        descBg:addChild(descText)
    end
end


function TradeActivityDailyPayView:getDescRichText()
    -- 创建富文本元素
    local richTextList = {}

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324513, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_255_255)
    elementText:center()
    elementText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324514, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_252_185_0)
    elementText:center()
    elementText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324515, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_255_255)
    elementText:center()
    elementText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    table.insert(richTextList, elementText)

    local elementText = UI.Text:create()
    elementText:init(UI.TEXT_1324516, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_69_227_154)
    elementText:center()
    elementText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -3))
    table.insert(richTextList, elementText)

    local richText = UI.imitateRichText:create(360)
    richText:init(richTextList, 654, 36)
    richText:setTextLeft()

    return richText
end


function TradeActivityDailyPayView:updateAwardsLayer()

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    if not groupInfo[1].rewardid or table.nums(groupInfo[1].rewardid) <= 0 then
        return
    end

    local rewardid = groupInfo[1].rewardid
    local rewardnum = groupInfo[1].rewardnum

    local layout = UI.Layout:create()
    layout:init()
    -- layout:enableDebugDraw()
    layout:setSize(220, 180)
    layout:center(-150, 38)
    self.contentLayout:addChild(layout)

    -- 每三个奖励一个layout
    local firstLayout = nil
    local secondLaout = nil

    firstLayout = UI.Layout:create()
    firstLayout:init()
    firstLayout:enableAutoWidth()
    firstLayout:enableAutoHeight()
    -- firstLayout:enableDebugDraw()
    layout:addChild(firstLayout)

    -- 根据奖励数量决定位置
    if table.nums(rewardid) <= 2 then
        firstLayout:center(0, 0)
    else
        secondLaout = UI.Layout:create()
        secondLaout:init()
        secondLaout:enableAutoWidth()
        secondLaout:enableAutoHeight()
        -- secondLaout:enableDebugDraw()
        layout:addChild(secondLaout)

        firstLayout:center(0, -40)
        secondLaout:center(0, 40)
    end

    for index = 1, #rewardid do
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(rewardid[index]))
        if goodData then
            goodData:setNum(0)
            goodData:setIsNew(false)
            goodData.isHaveGet = false

            -- 创建边框
            local frameImg = UI.Image:create()
            frameImg:init("box_quality_box_03.png")
            if index == 1 or index == 3 then
                frameImg:floatLeft(0)
            else
                frameImg:floatLeft(6)
            end

            if index <= 2 then
                firstLayout:addComponent(frameImg)
            else
                secondLaout:addComponent(frameImg)
            end

            local rewardGrid = UI.GoodsGrid:create()
            rewardGrid:init(goodData)
            rewardGrid:hideNewIcon()
            rewardGrid:hideBG()
            rewardGrid:hideRare()
            rewardGrid:center()
            rewardGrid:setTouchEnable(true)
            rewardGrid:setSwallowTouches(false)
            rewardGrid:setTouchClipNode(frameImg)
            rewardGrid:showInfoArea(true, false)
            frameImg:addChild(rewardGrid)

            -- 创建数量文本
            local numText = UI.NumberText:create(tonumber(rewardnum[index]), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_227_214_172, 5)
            numText:rightBottom(4, 0)
            frameImg:addChild(numText)
        end
    end
end


function TradeActivityDailyPayView:updateBuyBtn()
    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    local targetInfo = groupInfo[1]

    if targetInfo.stat == 3 then
        self.buyButton:disable()
        self.buyButton:setText(UI.TEXT_1110721)
    elseif targetInfo.stat == 2 then
        self.buyButton:enable()
        self.buyButton:setText(UI.TEXT_111035)
    else
        self.buyButton:enable()
        self.buyButton:setText(UI.TEXT_1324512)
    end

    -- 刷新时如果从未领取状态转变为领取则展示领取框
    if not self.getState and targetInfo.stat == 3 then
        self:showGetAwards()
    end

    -- 刷新领取状态
    self.getState = targetInfo.stat == 3
end

function TradeActivityDailyPayView:showGetAwards()
    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    local targetInfo = groupInfo[1]
    if not targetInfo.rewardid or table.nums(targetInfo.rewardid) <= 0 then
        return
    end

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local awardsList = {}
    for index = 1, #rewardid do
        local awarObj = GoodsDataManager:createLocalGoodsData(rewardid[index])
        awarObj:setNum(rewardnum[index])
        if rewardnum[index] > 0 then
            table.insert(awardsList, awarObj)
        end
    end
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end
end

function TradeActivityDailyPayView:getAwards()
    local SceneManager = require("app.game.SceneManager")
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    local groupInfo = mvc.tradeActivityModel:getActivityTargetByID(mvc.tradeActivityModel:getCurActivityID())
    if not groupInfo or table.nums(groupInfo) <= 0 then
        return
    end

    local targetInfo = groupInfo[1]
    if not targetInfo.rewardid or table.nums(targetInfo.rewardid) <= 0 then
        return
    end

    local rewardid = targetInfo.rewardid
    local rewardnum = targetInfo.rewardnum
    local goodsArr = {}
    for index = 1, #rewardid do
        local data = {}
        data.goodsID = rewardid[index]
        data.num = rewardnum[index]
        data.isGolden = false
        table.insert(goodsArr, data)
    end

    -- 判断背包是否满了
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) then
        UI.ScrollBar:createByText(UI.TEXT_1212011)
        return
    end

    UI.WaitingLayer:showWaiting(true, nil, 5)
    Net.NetRoleSystem:sendActivityTargetGetAwards(targetInfo.sudId, targetInfo.groupId)
end

return TradeActivityDailyPayView












