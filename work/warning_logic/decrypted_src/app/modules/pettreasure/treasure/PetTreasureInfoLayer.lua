------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/30
--desc	: 采集左侧信息
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureInfoLayer = class("PetTreasureInfoLayer", UI.BaseWin)

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 440
local COM_HEIGHT = 540

function PetTreasureInfoLayer:ctor()
    PetTreasureInfoLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.Scheduler:scheduleUpdate(self, self.updateGatherTime)
end

function PetTreasureInfoLayer:init()

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureInfoLayer.super.init(self)
end

function PetTreasureInfoLayer:dtor()
    PetTreasureInfoLayer.super.dtor(self)
    self:unbindModel()

    Avalon.Scheduler:unscheduleUpdate(self, self.updateGatherTime)
    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureInfoLayer")
end

function PetTreasureInfoLayer:onInitView()
    local treasureLevel = mvc.petTreasureModel:getTreasureLevel()
    local configData = ConfigManager:getPetTreasureByID(treasureLevel)
    self.endUpdateNotice = false

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 宝藏图片
    local treasureIcon  = UI.Image:create()
    treasureIcon:init("ui_pettreasure_picture_"..configData.resPath..".png")
    treasureIcon:leftBottom(23, 70)
    contentLayout:addChild(treasureIcon)

    self:updateLayer()
    -- printInfo(GoodsDataManager:getSaveGoodsData(), false)
end

function PetTreasureInfoLayer:updateLayer()
    self:updateTreasureLevel()
    self:updateGatherTime()
    self:updateGuardPower()
end

-- 更新宝藏等级
function PetTreasureInfoLayer:updateTreasureLevel()
    local levelBg = self.contentLayout:getChildByName("levelBg")
    if not levelBg then
        levelBg  = UI.Image:create()
        levelBg:init("ui_pettreasure_level.png")
        levelBg:leftUp(10, 78)
        levelBg:setName("levelBg")
        self.contentLayout:addChild(levelBg)
    end

    if levelBg:getChildByName("levelRichText") then
        levelBg:getChildByName("levelRichText"):removeFromParent(false)
    end

    local richTextStr = AvalonUtil:serializeText(UI.TEXT_110040, {r = 209, g = 129, b = 70}, UI.FONT_SIZE_36PX, UI.FONT_ARIAL)
    richTextStr = richTextStr..AvalonUtil:serializeText(tostring(mvc.petTreasureModel:getTreasureLevel()), UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_36PX, UI.FONT_ARIAL)

    local richText = UI.RichText:create()
    local success = richText:init(richTextStr, nil, nil, true)
    if success then
        richText:center()
        richText:setName("levelRichText")
        levelBg:addChild(richText, 100)
    end
end

-- 更新倒计时
function PetTreasureInfoLayer:updateGatherTime()
    if not self.contentLayout or tolua.isnull(self.contentLayout) then
        return
    end

    if mvc.petTreasureModel:getIsGathering() then
        local remainTimeStr = mvc.petTreasureModel:getGatherRemainTime()
        local remainTimeBg = self.contentLayout:getChildByName("remianTimeBg")
        if not remainTimeBg then
            remainTimeBg = UI.Image:create()
            remainTimeBg:init("ui_pettreasure_collect_banner.png")
            remainTimeBg:centerBottom(166)
            remainTimeBg:setName("remianTimeBg")
            self.contentLayout:addChild(remainTimeBg, 100)
        end

        local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))
        local remainTime = PetTreasureMaxTime - (GameManager:getNormalServerTime() - mvc.petTreasureModel:getGatherStartTime())

        local gatherStatusTx = remainTimeBg:getChildByName("gatherStatusTx")
        if not gatherStatusTx then
            gatherStatusTx = UI.Text:create()
            gatherStatusTx:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_211_124)
            gatherStatusTx:centerBottom(22)
            gatherStatusTx:setName("gatherStatusTx")
            remainTimeBg:addChild(gatherStatusTx)
        end
        if remainTime <= 0 then
            gatherStatusTx:setText(UI.TEXT_1314110)
            if remainTime == 0 and not self.endUpdateNotice then
                self.endUpdateNotice = true
                mvc.send("PetTreasure_Update_Layer")
            end
        else
            gatherStatusTx:setText(UI.TEXT_1314109)
        end

        if not self.remainTimeText then
            self.remainTimeText = UI.Text:create()
            self.remainTimeText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_RED)
            self.remainTimeText:centerBottom(-1)
            remainTimeBg:addChild(self.remainTimeText)
        end

        if not self.contentLayout:getChildByName("remianTimeBg"):isVisible() then
            self.contentLayout:getChildByName("remianTimeBg"):show()
        end

        self.remainTimeText:setText(UI.TEXT_1314106.." : "..remainTimeStr)
    else
        if self.contentLayout:getChildByName("remianTimeBg") and self.contentLayout:getChildByName("remianTimeBg"):isVisible() then
            self.contentLayout:getChildByName("remianTimeBg"):hide()
        end
    end

    -- 更新奖励显示
    self:updateGatherRewards()
end

-- 更新采集奖励显示
function PetTreasureInfoLayer:updateGatherRewards()
    if mvc.petTreasureModel:getIsGathering() then
        local rewards = mvc.petTreasureModel:getGatherRewards()
        if not self.rewardTextList then
            self.rewardTextList = {}
        end

        for key, value in ipairs(rewards) do
            local award = GoodsDataManager:createLocalGoodsData(value.ID)
            award:setNum(value.num)
            if not self.rewardTextList[key] then
                self.rewardTextList[key] = UI.Image:create()
                self.rewardTextList[key]:init("ui_pettreasure_harvest_banner.png")
                self.rewardTextList[key]:centerBottom(24.2 * key + 58)
                self.contentLayout:addChild(self.rewardTextList[key], 100)

                local rewardImg = self.rewardTextList[key]:getChildByName("rewardImg")
                if not rewardImg then
                    rewardImg = UI.Image:create()
                    rewardImg:init(award:getIconName())
                    rewardImg:centerLeft(-24)
                    rewardImg:setScale(0.4)
                    rewardImg:setName("rewardImg")
                    self.rewardTextList[key]:addChild(rewardImg)
                end

                local rewardText = self.rewardTextList[key]:getChildByName("rewardText")
                if not rewardText then
                    rewardText = UI.Text:create()
                    rewardText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_150_150_150)
                    rewardText:centerLeft(64)
                    rewardText:setName("rewardText")
                    self.rewardTextList[key]:addChild(rewardText)
                end
            end
            self.rewardTextList[key]:show()

            if self.rewardTextList[key].goodsID ~= value.ID then
                self.rewardTextList[key]:getChildByName("rewardImg"):setSpriteName(award:getIconName())
            end
            self.rewardTextList[key]:getChildByName("rewardText"):setText(award:getNum())

            self.rewardTextList[key].goodsID = value.ID
        end

        if #self.rewardTextList > #rewards then
            for index = #self.rewardTextList - #rewards, #self.rewardTextList do
                self.rewardTextList[index]:hide()
            end
        end
    else
        if self.rewardTextList then
            for key, value in pairs(self.rewardTextList) do
                value:hide()
            end
        end
    end
end

-- 更新守卫总战斗力
function PetTreasureInfoLayer:updateGuardPower()
    if mvc.petTreasureModel:getIsGathering() then
        if self.treasureTotalPowerBg then
            self.treasureTotalPowerBg:hide()
        end
    else
        local power = mvc.petTreasureModel:getGuardsTotalPower()

        if not self.treasureTotalPowerBg then
            self.treasureTotalPowerBg = UI.Image:create()
            self.treasureTotalPowerBg:init("ui_pettreasure_powerbanner.png")
            self.treasureTotalPowerBg:leftBottom(116, 110)
            self.contentLayout:addChild(self.treasureTotalPowerBg, 100)
        end

        self.treasureTotalPowerBg:show()

        if self.treasureTotalPowerBg:getChildByName("treasureTotalPowerText") then
            self.treasureTotalPowerBg:getChildByName("treasureTotalPowerText"):removeFromParent(false)
        end

        local Str = AvalonUtil:serializeText(UI.TEXT_1314113..":", {r = 209, g = 129, b = 70}, UI.FONT_SIZE_18PX, UI.FONT_BOLD)
        Str = Str .. AvalonUtil:serializeText(tostring(power), UI.FONT_COLOR_255_255_255, UI.FONT_SIZE_18PX, UI.FONT_BOLD)

        local richText = UI.RichText:create()
        local success = richText:init(Str, nil, nil, true)
        if success then
            richText:center()
            richText:setName("treasureTotalPowerText")
            self.treasureTotalPowerBg:addChild(richText, 100)
        end
    end
end

function PetTreasureInfoLayer:bindModel()

end

function PetTreasureInfoLayer:unbindModel()

end

return PetTreasureInfoLayer
