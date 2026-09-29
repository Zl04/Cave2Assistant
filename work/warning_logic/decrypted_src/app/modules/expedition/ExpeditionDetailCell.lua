------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local ExpeditionDetailCell = class("ExpeditionDetailCell", UI.HWBtnComponent)
UI.ExpeditionDetailCell = ExpeditionDetailCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 585
local COM_HEIGHT = 138

function ExpeditionDetailCell:ctor()
    ExpeditionDetailCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function ExpeditionDetailCell:init( ... )
    ExpeditionDetailCell.super.init(self, ... )
end

function ExpeditionDetailCell:dtor()
    ExpeditionDetailCell.super.dtor(self)
    reload_script_file("app.modules.expedition.ExpeditionDetailCell")
end

function ExpeditionDetailCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_explore_article_0.png")
    bg:center()
    self:addChild(bg)
    self.bg = bg 

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(173, 130)
    leftLayout:centerLeft(0)
    bg:addChild(leftLayout)

    local levelTitleText = UI.Text:create()
    levelTitleText:init("23", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    levelTitleText:centerUp(24 - levelTitleText:getContentSize().height/2)
    leftLayout:addChild(levelTitleText)
    self.choiceLevelText = levelTitleText

    -- 金币加成
    local cointLayout = UI.Layout:create()
    cointLayout:init()
    cointLayout:centerUp(59)
    cointLayout:setSize(0, 0)
    leftLayout:addChild(cointLayout)
    -- addChildAuto(layoutUtil, topLayout, cointLayout, "cointLayout", "center")

    local coinImage = UI.Image:create()
    coinImage:init("symbol_gaming_money.png")
    coinImage:centerLeft(0)
    coinImage:setScale(0.9)
    cointLayout:addChild(coinImage, 10)
    self.coinImage = coinImage

    local coinTitleText = UI.Text:create()
    coinTitleText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    coinTitleText:centerLeft(15)
    cointLayout:addChild(coinTitleText, 10)
    self.coinTitleText = coinTitleText

    local coinDesText = UI.Text:create()
    coinDesText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    coinDesText:centerLeft(15)
    cointLayout:addChild(coinDesText, 10)
    self.coinDesText = coinDesText

    local coinUpImage = UI.Image:create()
    coinUpImage:init("ui_information_arrow_up.png")
    coinUpImage:centerLeft(-5)
    cointLayout:addChild(coinUpImage)
    self.coinUpImage = coinUpImage

    -- 经验加成
    local expLayout = UI.Layout:create()
    expLayout:init()
    expLayout:centerUp(80)
    expLayout:setSize(0, 0)
    leftLayout:addChild(expLayout)
    -- addChildAuto(layoutUtil, topLayout, expLayout, "expLayout", "center")

    local expImage = UI.Image:create()
    expImage:init("symbol_gaming_xp.png")
    expImage:centerLeft(0)
    expImage:setScale(0.9)
    expLayout:addChild(expImage, 10)
    self.expImage = expImage

    local expTitleText = UI.Text:create()
    expTitleText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    expTitleText:centerLeft(15)
    expLayout:addChild(expTitleText, 10)
    self.expTitleText = expTitleText

    local expDesText = UI.Text:create()
    expDesText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    expDesText:centerLeft(15)
    expLayout:addChild(expDesText, 10)
    self.expDesText = expDesText

    local expUpImage = UI.Image:create()
    expUpImage:init("ui_information_arrow_up.png")
    expUpImage:centerLeft(-5)
    expLayout:addChild(expUpImage)
    expUpImage:setVisible(false)
    self.expUpImage = expUpImage

    -- 右边
    local tipsText = UI.Text:create()
    tipsText:init(LanguageManager:getInstance():getLocalString(1111346), UI.FONT_STANDARD,
        UI.FONT_SIZE_20PX,
        UI.FONT_COLOR_41_41_45)
    tipsText:rightUp(214 - tipsText:getContentSize().width/2, 24 - tipsText:getContentSize().height/2)
    self:addChild(tipsText)

    -- 蒙层
    local cellMaskImage = UI.Image:create()
    cellMaskImage:init("ui_explore_article_gradually0.png")
    cellMaskImage:rightBottom(50, 6)
    self:addChild(cellMaskImage, 10)
    self.cellMaskImage = cellMaskImage
    

    -- 探险中的标记
    local expeditionImage = UI.Image:create()
    expeditionImage:init("ui_explore_sword.png")
    expeditionImage:rightUp(-18 , -18)
    self:addChild(expeditionImage,15)
    expeditionImage:setVisible(false)
    self.expeditionImage = expeditionImage
end

function ExpeditionDetailCell:onUpdateView()

end

function ExpeditionDetailCell:updateData(data)
    local caveMode = math.floor(data.ID / 100000)
    local level = data.ID - caveMode * 100000
    local maxLevel = level
    local maxLevelData = RoleDataManager:getMaster():getMaxLevelData(caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    if(maxLevelData and maxLevel < maxLevelData:getMaxLevel()) then 
        maxLevel = maxLevelData:getMaxLevel()
    end
    -- print("ExpeditionDetailCell:updateData", data.ID, level, maxLevel)
    local expeditionData = data

    -- local gateConfig, index = self:getGateConfig(caveMode, level)

    local openExpeditionData = mvc.expeditionModel:getExpeditionConfigData(caveMode, mvc.expeditionModel:maxLevelCoverToCheckpoint(caveMode, maxLevel))
    local nowLevel = mvc.expeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(caveMode, mvc.expeditionModel:maxLevelCoverToCheckpoint(caveMode, level))
    -- print("nowLevel=", data.ID, nowLevel, caveMode, ToolsUtil:getShopLevelForCaveLevel(level))
    if mvc.expeditionModel:getExpeditionStatus() 
        and caveMode == mvc.expeditionModel:getExpeditionMode() 
        and level == mvc.expeditionModel:getExpeditionCaveLevel()  then 
        self.expeditionImage:setVisible(true)
        self.bg:setSpriteName("ui_explore_article_1.png")
        self.cellMaskImage:setSpriteName("ui_explore_article_gradually1.png")
        self:setOpacity(255)
    else
        if(openExpeditionData and openExpeditionData.ID >= expeditionData.ID) then 
            self.bg:setSpriteName("ui_explore_article_0.png")
            self.cellMaskImage:setSpriteName("ui_explore_article_gradually0.png")
            self.expeditionImage:setVisible(false)
            self:setOpacity(255)
        else 
            self.bg:setSpriteName("ui_explore_article_2.png")
            self.cellMaskImage:setSpriteName("ui_explore_article_gradually2.png")
            self.expeditionImage:setVisible(false)
            self:setOpacity(128)
        end
    end
    -- if (caveMode ~= PublicDefine.CAVE_MODE.MODE_HERO) then
        self.choiceLevelText:setText(string.format(UI.TEXT_110001, level))
    -- else
    --     self.choiceLevelText:setText(LanguageManager:getInstance():getLocalString(gateConfig.name))
    -- end
    -- 这里根据选择去当前能够探险的点
    
    if (expeditionData) then
        local rewardNode = self:getChildByName("RewardNode")
        if rewardNode then
            rewardNode:removeFromParent(true)
        end
        local winSize = cc.Director:getInstance():getWinSize()
        local rewardNode = UI.RewardPreViewUtil:create()
        rewardNode:setTouchClipNode(self.touchClipNode)
        rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
        rewardNode:init(nil, 4.5, 1, UI.ScrollType.HORIZONTAL, cc.size(0, 0), true, cc.size(-4, 0), false)
        rewardNode:rightBottom(52, 13)
        local rewardData = expeditionData.BoxDrop
        local idList = string.split(rewardData, ",")
        for k, v in pairs(idList) do
            rewardNode:addGoodsId(tonumber(v), 0)
        end
        rewardNode:showGoodsView()
        rewardNode:setName("RewardNode")
        self:addChild(rewardNode)
        -- rewardNode:setVisible(false)
        
        -- if not self.scheduling then
        --     self.scheduling = true
        --     Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
        --         self.scheduling = false
        --         local rewardNode = self:getChildByName("RewardNode")
        --         if rewardNode then
        --             rewardNode:setVisible(true)
        --         end
        --     end, 0.8)
        -- end

        -- 刷新当前的挂机产量
        local wasUp = false
        local expUp = false
        local coinUp = false

        local rewardArr = {0, 0}
        local cardFlag = false
        if (mvc.expeditionModel:getHaveMonthDay()) then
            local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
            rewardArr = string.split(expeditionCoinincome, ";")
            cardFlag = true
        end
        if (caveMode == mvc.expeditionModel:getSpeedMode() 
            and expeditionData.checkpoint - math.floor(expeditionData.checkpoint/100000) * 100000 == mvc.expeditionModel:getSpeedLevel()) then
            self.coinUpImage:setVisible(false)
            self.expUpImage:setVisible(false)
            wasUp = true

            if
                (mvc.expeditionModel:getSpeedType() ==
                    ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_exp"))
             then
                self.expUpImage:setVisible(true)
                expUp = true
            elseif
                (mvc.expeditionModel:getSpeedType() ==
                    ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_coin"))
             then
                self.coinUpImage:setVisible(true)
                coinUp = true
            end
        else
            self.coinUpImage:setVisible(false)
            self.expUpImage:setVisible(false)
        end

        local goldConfig = string.split(expeditionData.goldcoinincome, ",")
        local avaNum = (tonumber(goldConfig[1]) + tonumber(goldConfig[2])) / 2

        if (coinUp or cardFlag) then
            self.coinDesText:setFontColor(UI.FONT_COLOR_36_181_118)
            local addNum = 0
            if (coinUp) then
                addNum = addNum + tonumber(expeditionData.goldcoinratio)
            end
            if (cardFlag) then
                addNum = addNum + tonumber(rewardArr[1])
            end
            avaNum = avaNum * (1 + addNum / RATIO_NUMBER)
        else
            self.coinDesText:setFontColor(UI.FONT_COLOR_41_41_45)
        end

        self.coinDesText:setText(string.format("%d/%ds", avaNum, tonumber(goldConfig[3])))

        local expConfig = string.split(expeditionData.expcoinincome, ",")
        local avaExpNum = (tonumber(expConfig[1]) + tonumber(expConfig[2])) / 2
        if (expUp or cardFlag) then
            self.expDesText:setFontColor(UI.FONT_COLOR_36_181_118)
            local addNum = 0
            if (expUp) then
                addNum = addNum + tonumber(expeditionData.expcoinratio)
            end
            -- print("2", avaExpNum, addNum)
            if (cardFlag) then
                addNum = addNum + tonumber(rewardArr[2])
            end
            -- print("2", avaExpNum, addNum)
            avaExpNum = avaExpNum * (1 + addNum / RATIO_NUMBER)
        else
            self.expDesText:setFontColor(UI.FONT_COLOR_41_41_45)
        end
        self.expDesText:setText(string.format("%d/%ds", avaExpNum, tonumber(expConfig[3])))

        --
        local totalWidth =
            self.coinImage:getContentSize().width + self.coinDesText:getContentSize().width +
            self.coinTitleText:getContentSize().width +
            4
        local startX = -(totalWidth) / 2
        self.coinImage:centerLeft(startX)
        startX = startX + self.coinImage:getContentSize().width + 4
        self.coinTitleText:centerLeft(startX)
        startX = startX + self.coinTitleText:getContentSize().width + 2
        self.coinDesText:centerLeft(startX)
        self.coinUpImage:centerLeft(totalWidth / 2 + 5)

        local totalWidth =
            self.expImage:getContentSize().width + self.expDesText:getContentSize().width +
            self.expTitleText:getContentSize().width +
            4
        local startX = -(totalWidth) / 2
        self.expImage:centerLeft(startX)
        startX = startX + self.expImage:getContentSize().width + 2
        self.expTitleText:centerLeft(startX)
        startX = startX + self.expTitleText:getContentSize().width + 2
        self.expDesText:centerLeft(startX)
        self.expUpImage:centerLeft(totalWidth / 2 + 5)
    end
end












