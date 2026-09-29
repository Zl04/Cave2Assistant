------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2021/11/04
--desc	: 宠物探险关卡选择
------------------------------------------------------------------------------
require("app.ui.town.levelSelect.LevelSelectNormalBtn")
require("app.ui.town.SuperLevelSelect")
require("app.ui.UIManager")
require "app.datas.AnswerDataManager"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureAdventureLevelSelect = class("PetTreasureAdventureLevelSelect", UI.SuperLevelSelect)

-- 资源
local COM_RES_LIST = {
    -- "ui_package_pets.plist",
    -- "ui_common_information.plist",
    "ui_pet_treasure.plist",
    "ui_town_distortedSpace.plist",
}

local COM_WIDTH = 440
local COM_HEIGHT = 540

function PetTreasureAdventureLevelSelect:ctor(len)
    PetTreasureAdventureLevelSelect.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.layerType = nil
    self.selectedLevel = nil
    self.selectedIcon = nil
    self.data = {}
    self.data.curOpenLevel = mvc.petTreasureModel:getPetAdvLevel()+1 >= len and len or mvc.petTreasureModel:getPetAdvLevel()+1
    self.data.oldOpenLevel = self.data.curOpenLevel--mvc.petTreasureModel:getPetAdvLevel()--

    Avalon.Scheduler:scheduleUpdate(self, self.updateExploringTime)
end

function PetTreasureAdventureLevelSelect:init(layerType)
    self.layerType = layerType or Game.LevelSelectLayerType.Pet_Adventure
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureAdventureLevelSelect.super.init(self)
end

function PetTreasureAdventureLevelSelect:dtor()
    PetTreasureAdventureLevelSelect.super.dtor(self)
    self:unbindModel()
    self.selectedLevel = nil
    self.selectedIcon = nil
    self.layerType = nil
    self.data = {}
    Avalon.Scheduler:unscheduleUpdate(self, self.updateExploringTime)
    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureAdventureLevelSelect")

    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_up_02.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_heromap_2.png")
end

function PetTreasureAdventureLevelSelect:onInitView()
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

    self._scrollView, self._layout = self:createScrollView(self.layerType, 370, 405)
    local clipper = UI.ClippingNode:create()
    clipper:initWithFileName("image/levelSelect/ui_petsadventure_up_02.png", 0.01)
    clipper:addInnerNode(self._scrollView)
    -- clipper:rightBottom(40, 170)
    clipper:center()
    -- clipper:enableDebugDraw()
    self.contentLayout:addChild(clipper, 3)
    clipper:setOpacityFilterTouch(true)

    local mask = UI.Image:create()
    mask:init("ui_petsadventure_up_03.png")
    mask:center()
    clipper:addChild(mask, 100)
    -- self.floatCloudCliper = clipper

    self:updateLayer()
    local level = self.selectedIcon and self.selectedIcon:getTag() or self.data.curOpenLevel 
    mvc.send("PetAdventure_Handle_Level_Selected", level)
end

-- 模版函数：更新组建的视图
function PetTreasureAdventureLevelSelect:onUpdateView()
    PetTreasureAdventureLevelSelect.super.onUpdateView(self)
    -- self.data.curOpenLevel = mvc.petTreasureModel:getPetAdvLevel()+1 >= 8 and 8 or mvc.petTreasureModel:getPetAdvLevel()+1
    self:createLevelBtns(self.data.oldOpenLevel, self.data.curOpenLevel, self._scrollView, self._layout, handler(self, self.spineIconClickCallback), handler(self, self.spineIconAnimEndCallback), handler(self, self.spineIconAnimStartCallback))
    self.selectedIcon = self.defaultNomalSelectIcon
    -- self:updateLayer()
    self:refreshExpeditionStatus()
end

function PetTreasureAdventureLevelSelect:updateLayer()
    self:updateExploringTime()
    self:refreshExpeditionStatus()
end

-- function PetTreasureAdventureLevelSelect:updateLevel()
--     print("PetTreasureAdventureLevelSelectupdateLevel", self.data.oldOpenLevel, self.data.curOpenLevel)
--     self.data.oldOpenLevel = self.data.curOpenLevel
-- end

-- function PetTreasureAdventureLevelSelect:updateMapInfo()
--     self:createLevelBtns(self.data.oldOpenLevel, self.data.curOpenLevel, self._scrollView, self._layout, handler(self, self.spineIconClickCallback), handler(self, self.spineIconAnimEndCallback), handler(self, self.spineIconAnimStartCallback))
-- end

function PetTreasureAdventureLevelSelect:spineIconClickCallback(sender, _, touchPosition)
    -- printError("PetTreasureAdventureLevelSelectspineIconClickCallback")
    local spineIcon = sender
    if spineIcon.state == SpineIconStatus.haveUnLocked then  
        if self.selectedIcon ~= nil then
            self.selectedIcon:unLocked()
        end
        spineIcon:selected()
        self.selectedIcon = spineIcon
        -- self.selectedLevel = spineIcon:getTag()
        -- self:refreshInfoView(self.selectedIcon:getTag())
        mvc.send("PetAdventure_Handle_Level_Selected", self.selectedIcon:getTag())
    end
    -- 更新奖励显示
    self:updateGatherRewards(spineIcon:getTag())
    Avalon.AudioManager:playSound("1503")
end

function PetTreasureAdventureLevelSelect:spineIconAnimEndCallback(sender, _, touchPosition)
    -- printError("spineIconAnimEndCallback")
    -- Avalon.AudioManager:playSound("1503")
    
        
    -- self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()    
    --     -- self.lockAllBtn = false      
    --     self:showOpenAnimation(self.data.oldOpenLevel, self.data.curOpenLevel)
    -- end)))
    self:showOpenAnimation(self.data.oldOpenLevel, self.data.curOpenLevel)
end

function PetTreasureAdventureLevelSelect:spineIconAnimStartCallback(sender, event, obj)
    -- printError("spineIconAnimStartCallback")
    if event.animation == "showup" then
        
        Avalon.AudioManager:playSoundDelay("1520", 350)
    end
end

-- 更新倒计时
function PetTreasureAdventureLevelSelect:updateExploringTime()
    if not self.contentLayout or tolua.isnull(self.contentLayout) then
        return
    end

    if mvc.petTreasureModel:getExploreState() then
        local remainTime, remainTimeStr = mvc.petTreasureModel:getExploreRemainTime()
        local remainTimeBg = self.contentLayout:getChildByName("remianTimeBg")
        if not remainTimeBg then
            remainTimeBg = UI.Image:create()
            remainTimeBg:init("ui_pettreasure_collect_banner.png")
            remainTimeBg:centerBottom(166)
            remainTimeBg:setName("remianTimeBg")
            self.contentLayout:addChild(remainTimeBg, 100)
        end

        local gatherStatusTx = remainTimeBg:getChildByName("gatherStatusTx")
        if not gatherStatusTx then
            gatherStatusTx = UI.Text:create()
            gatherStatusTx:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_211_124)
            gatherStatusTx:centerBottom(22)
            gatherStatusTx:setName("gatherStatusTx")
            remainTimeBg:addChild(gatherStatusTx)
        end
        if remainTime <= 0 then
            gatherStatusTx:setText(UI.TEXT_221101)
            if remainTime == 0 and not self.endUpdateNotice then
                self.endUpdateNotice = true
                -- mvc.send("PetAdventure_Update_Explor_Layer")
                Avalon.Scheduler:unscheduleUpdate(self, self.updateExploringTime)
            end
        else
            gatherStatusTx:setText(UI.TEXT_221102)
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

        self.remainTimeText:setText(UI.TEXT_221103.." : "..remainTimeStr)
    else
        if self.contentLayout:getChildByName("remianTimeBg") and self.contentLayout:getChildByName("remianTimeBg"):isVisible() then
            self.contentLayout:getChildByName("remianTimeBg"):hide()
        end
    end
end

-- 更新探索奖励显示
function PetTreasureAdventureLevelSelect:updateGatherRewards(level)
    -- local level = self.selectedIcon and self.selectedIcon:getTag() or self.data.curOpenLevel

    mvc.send("PetAdventure_Handle_Adventure_Show_Drop_List", level)
end

function PetTreasureAdventureLevelSelect:refreshExpeditionStatus()
    if (not tolua.isnull(self.warflag)) then
        self.warflag:removeFromParent()
        self.warflag = nil
    end

    if (not tolua.isnull(self.upLayout)) then
        self.upLayout:removeFromParent()
        self.upLayout = nil
    end
    local expeditionStatus = mvc.petTreasureModel:getExploreState()
    if not expeditionStatus then
        return
    end
    -- 找到对应的节点
    local warNode = nil
    
    local expeditionLevel = mvc.petTreasureModel:getExploreLevel()
    for k, node in pairs(self.levelBtnList) do
        if node:getTag() == expeditionLevel then
            warNode = node
        end
    end

    if (warNode) then
        local warflagAnimation = UI.Animation:create()
        warflagAnimation:init(
            "effect_ui_town_expedition_stageselect_hero_flag.json",
            "effect_ui_town_expedition_stageselect_hero_flag.atlas"
        )
        warflagAnimation:setInnerOffset(-2, -2)
        warflagAnimation:rightBottom(-10, 15)
        warflagAnimation:setAnimation("idle", true)
        warNode:addChild(warflagAnimation)

        self.warflag = warflagAnimation
    end
end



function PetTreasureAdventureLevelSelect:getSelectedLevel()
    -- printError("getSelectedLevel", self.selectedIcon:getTag())
    return self.selectedIcon:getTag()
end


function PetTreasureAdventureLevelSelect:bindModel()

end

function PetTreasureAdventureLevelSelect:unbindModel()

end

return PetTreasureAdventureLevelSelect
