------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/09/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityGroupPayView = class("TradeActivityGroupPayView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_daily.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

function TradeActivityGroupPayView:ctor()
    TradeActivityGroupPayView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_GROUP_PAY,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function TradeActivityGroupPayView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityGroupPayView.super.init(self, ... )
end

function TradeActivityGroupPayView:dtor()
    TradeActivityGroupPayView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityGroupPayView")
end

function TradeActivityGroupPayView:bindModel()

end


function TradeActivityGroupPayView:unbindModel()

end


function TradeActivityGroupPayView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local topImg  = UI.Image:create()
    topImg:init("ui_businessactivities_illustration_06.png")
    topImg:rightUp(6, 0)
    self:addChild(topImg)

    local configData = ConfigManager:getTradeActivityDataByID(mvc.tradeActivityModel:getCurActivityID())

    -- 描述
    local desc = UI.Text:create()
    desc:init(configData.name, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_225_225_225)
    desc:setTextLeft()
    -- desc:enableDebugDraw()
    desc:leftUp(18, 90)
    topImg:addChild(desc)

    local prompt = UI.Text:create()
    prompt:init(UI.TEXT_1324534, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_69_227_154)
    prompt:setSize(310, 24)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        prompt:setFontSize(UI.FONT_SIZE_14PX)
        prompt:setLineSpacing(-5)
    end
    prompt:setTextLeftBottom()
    prompt:leftUp(18, 130)
    -- prompt:enableDebugDraw()
    topImg:addChild(prompt)

    local updatePrompt = UI.Text:create()
    updatePrompt:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_225_225_225)
    if LanguageManager:getInstance():getLanguage() ~= cc.LANGUAGE_CHINESE then
        updatePrompt:setFontSize(UI.FONT_SIZE_14PX)
        updatePrompt:setLineSpacing(-5)
    end
    updatePrompt:setTextCenter()
    -- updatePrompt:enableDebugDraw()
    updatePrompt:rightUp(16, 128)
    topImg:addChild(updatePrompt)
    self.updatePrompt = updatePrompt

    self:updateActivityTime()

    local downImg = UI.Image:create()
    downImg:init("ui_businessactivities_bg_05.png")
    downImg:centerBottom(-6)
    self:addChild(downImg)
    self.downImg = downImg

    self:createGroupInfo()
end

function TradeActivityGroupPayView:updateActivityTime()
    local timeStr = mvc.tradeActivityModel:getActivityOpeningStrByID(mvc.tradeActivityModel:getCurActivityID())
    if timeStr then
        self.updatePrompt:setText(timeStr)
    end
end

function TradeActivityGroupPayView:createGroupInfo()
    -- 购买人数
    local buyLayout = UI.Layout:create()
    buyLayout:init()
    buyLayout:leftUp(68, 36)
    buyLayout:enableAutoWidth()
    buyLayout:enableAutoHeight()
    -- buyLayout:enableDebugDraw()
    self.downImg:addChild(buyLayout)

    local desc = UI.Text:create()
    desc:init(UI.TEXT_1324535, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    desc:floatLeft(0)
    buyLayout:addComponent(desc)

    local priceText = UI.Text:create()
    priceText:init("68865", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_251_211_27)
    priceText:floatLeft(0)
    buyLayout:addComponent(priceText)

    -- 加载进度条内容
    local progressTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_businessactivities_schedule.png"))
    progressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progressTimer:setMidpoint(cc.p(0, 0))
    progressTimer:setBarChangeRate(cc.p(1, 0))
    progressTimer:setPercentage(0)
    progressTimer:setPosition(323, 236)
    self.downImg:addChild(progressTimer)
    self.progressTimer = progressTimer

    -- 要求人数
    local pos = {{x = -246, y = -50}, {x = 0, y = -50}, {x = 246, y = -50}}
    for k, v in ipairs(pos) do
        local needLayout = UI.Layout:create()
        needLayout:init()
        needLayout:center(v.x, v.y)
        needLayout:enableAutoWidth()
        needLayout:enableAutoHeight()
        -- needLayout:enableDebugDraw()
        self.downImg:addChild(needLayout)

        local desc = UI.Text:create()
        desc:init("1000", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_251_211_27)
        desc:floatLeft(0)
        needLayout:addComponent(desc)

        local priceText = UI.Text:create()
        priceText:init(UI.TEXT_1324536, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
        priceText:floatLeft(0)
        needLayout:addComponent(priceText)
    end

    -- 中间奖励
    local midBg = UI.Image:create()
    midBg:init("ui_businessactivities_label_04.png")
    midBg:center(0, -92)
    self.downImg:addChild(midBg)

    local midImg = UI.Button:create()
    midImg:init('ui_daily_box_1_1.png', 'ui_daily_box_1_1.png')
    midImg:center(0, -2)
    midImg:setScale(0.8)
    midImg:addEventListener(UIEvent.BUTTON_CLICK, self, function()

    end)
    midBg:addChild(midImg)

    local midRedStar = UI.Image:create()
    midRedStar:init("ui_information_equip.png")
    midRedStar:center(26, -26)
    midBg:addChild(midRedStar)
    self.midRedStar = midRedStar

    -- 最终奖励
    local endBg = UI.Image:create()
    endBg:init("ui_businessactivities_label_04.png")
    endBg:center(250, -92)
    self.downImg:addChild(endBg)

    local endImg = UI.Button:create()
    endImg:init('ui_daily_box_3_1.png', 'ui_daily_box_3_1.png')
    endImg:center(0, -1)
    endImg:setScale(0.8)
    endImg:addEventListener(UIEvent.BUTTON_CLICK, self, function()

    end)
    endBg:addChild(endImg)

    local endRedStar = UI.Image:create()
    endRedStar:init("ui_information_equip.png")
    endRedStar:center(26, -26)
    endBg:addChild(endRedStar)
    self.endRedStar = endRedStar

    -- 加载奖励
    self:updateAwardsLayer()

    -- 加载购买按钮
    local buyBtn = UI.Button:create()
    buyBtn:init('ui_businessactivities_btn_04.png', 'ui_businessactivities_btn_04.png', 'ui_businessactivities_btn_gray_04.png')
    buyBtn:centerBottom(20)
    buyBtn:setText("")
    buyBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        
    end)
    self.downImg:addChild(buyBtn)
    self.buyBtn = buyBtn

    self:updateBuyBtn()
end

function TradeActivityGroupPayView:updateBuyBtn()
    
end

function TradeActivityGroupPayView:updateAwardsLayer()
    local awardsStr = ConfigManager:getTradeActivityDataByID(mvc.tradeActivityModel:getCurActivityID()).reward
    local awards = string.split(awardsStr, ";")

    local layout = UI.Layout:create()
    layout:init()
    -- layout:enableDebugDraw()
    layout:setSize(500, 100)
    layout:center(0, 20)
    self.downImg:addChild(layout)

    local firstLayout = UI.Layout:create()
    firstLayout:init()
    firstLayout:enableAutoWidth()
    firstLayout:enableAutoHeight()
    firstLayout:center(0, 0)
    -- firstLayout:enableDebugDraw()
    layout:addChild(firstLayout)

    for index = 1, #awards do
        local awardInfo = string.split(awards[index], ",")
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(awardInfo[1]))
        if goodData then
            goodData:setNum(tonumber(awardInfo[2]))
            goodData:setIsNew(false)
            goodData.isHaveGet = false

            -- 创建边框
            local frameImg = UI.Image:create()
            frameImg:init("box_quality_box_03.png")
            if index == 1 then
                frameImg:floatLeft(0)
            else
                frameImg:floatLeft(6)
            end
            firstLayout:addComponent(frameImg)

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

        end
    end
end

return TradeActivityGroupPayView












