------------------------------------------------------------------------------
--author: junhao.denbg
--date	: 2021/11/3
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureAdventureLayer = class("PetTreasureAdventureLayer", UI.HWBtnComponent)

require "app.modules.pet.PetMainListCell"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local PetTreasureAdventureLevelSelect = require("app.modules.pettreasure.treasure.PetTreasureAdventureLevelSelect")
local PetTreasureEmbattleLayer = require("app.modules.pettreasure.treasure.PetTreasureEmbattleLayer")
local PetTreasureFragmentsBagLayer = require("app.modules.pettreasure.treasure.PetTreasureFragmentsBagLayer")

-- 资源
local COM_RES_LIST = {
    "ui_town_expedition.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local BTN_CELL_W = 109
local BTN_CELL_H = 68

local EMBATTLE_PET_POS = {
    HIGH = 1,
    MID = 2,
    LOW = 3,
}

function PetTreasureAdventureLayer:ctor()
    PetTreasureAdventureLayer.super.ctor(
    	self,
    	UI.Type.PET_ADVENTURE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.leftContentLayer = nil
    self.battleList = {}
    self.curLevel = nil
    self.levelRewardNode = nil
    self:bindModel()

end

function PetTreasureAdventureLayer:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureAdventureLayer.super.init(self, ... )
    self.curLevel = mvc.petTreasureModel:getPetAdvLevel()
    mvc.send("PetAdventure_REQ_Sync_PetAdv_Data")
end

function PetTreasureAdventureLayer:dtor()
    -- self.leftContentLayer = nil
    self.curLevel = nil
    self.levelRewardNode = nil
    self.battleList = {}
    PetTreasureAdventureLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureAdventureLayer")
end

function PetTreasureAdventureLayer:onInitView()
    -- self.battleList = clone(mvc.petTreasureModel:getPetAdvEmbattlePets())
    mvc.petTreasureModel:setPetAdvData()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部背景图片
    local innerBG  = UI.Image:create()
    innerBG:init("ui_petsadventure_bg.png")
    innerBG:leftUp(28, 16)
    contentLayout:addChild(innerBG)
    self.innerBG = innerBG

    local mapBlackBG = UI.Image:create()
    mapBlackBG:init("ui_petsadventure_bg_02.png")
    mapBlackBG:leftUp(28, -10)
    contentLayout:addChild(mapBlackBG)
    -- self.mapBlackBG = mapBlackBG

    local mapPurpleBG = UI.Image:create()
    mapPurpleBG:init("ui_petsadventure_up.png")
    mapPurpleBG:leftUp(28, -10)
    contentLayout:addChild(mapPurpleBG)
    self.mapPurpleBG = mapPurpleBG

    local bagBg = UI.Image:create()
    -- local bagBg = UI.Button:create()
    bagBg:init("ui_petsadventure_boxbg.png")
    bagBg:leftBottom(100, 5)
    self.bagBg = bagBg
    contentLayout:addChild(bagBg, 100)

    local bagBox = UI.Button:create()
    bagBox:init("ui_petsadventure_box.png", "ui_petsadventure_box.png")
    -- bagBox:leftBottom(100, 5)
    bagBox:center()
    bagBox:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOpenExplorBag)
    self.bagBg:addChild(bagBox, 103)

    -- self:updateTreasureInfo()
    self:updateLayer()
end

function PetTreasureAdventureLayer:updateLayer()

    -- 加载采集动效
    self:updateExploringEff()

    -- 加载左侧显示宝藏信息
    self:updateTreasureInfo()

    -- 加载右侧布阵情况 
    -- self:updateGuardinfo()

    -- 加载btn
    -- self:updateBtn()

end

function PetTreasureAdventureLayer:updatePetAdvMap()
    
end

function PetTreasureAdventureLayer:updateGuardinfo(gaurdData, level)
    -- local enemyData = clone(mvc.petTreasureModel:getGuardsData())
    local enemyData = gaurdData or clone(mvc.petTreasureModel:getPetAdvGuardCacheById(self:getSelectedLevel()))
    if not mvc.petTreasureModel:getExploreState() then
        mvc.petTreasureModel:clearAdvEmbattlePetsData()
    end
    -- 此处引用会改变到curEmbattlePetsData
    local selfData = clone(mvc.petTreasureModel:getPetAdvEmbattlePets())
    -- if mvc.petTreasureModel:getIsGathering() then
    --     selfData = clone(mvc.petTreasureModel:getWorkersData())
    -- end
    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if not embattleLayer then
        embattleLayer = PetTreasureEmbattleLayer:create()
        embattleLayer:init(enemyData, selfData, "PetTreasureAdventureLayer")
        embattleLayer:rightBottom(30, 120)
        embattleLayer:setName("embattleLayer")
        self.embattleLayer = embattleLayer
        self.contentLayout:addChild(embattleLayer, 200)
    else
        embattleLayer:updateLayer(enemyData, selfData, "PetTreasureAdventureLayer")
    end

    if mvc.petTreasureModel:getExploreState() then
        embattleLayer:setCanDragItem(false)
    else
        embattleLayer:setCanDragItem(true)
    end
    self:updateBtn()
end

function PetTreasureAdventureLayer:updateExploringEff()
    if not self.exploreEff then
        self.exploreEff = UI.Animation:create()
        self.exploreEff:init("effect_ui_petsadventure_boxlight.json", "effect_ui_petsadventure_boxlight.atlas", 1)
        -- self.exploreEff:leftBottom(100, 5)
        self.exploreEff:center()
        self.bagBg:addChild(self.exploreEff, 102)
    end

    if mvc.petTreasureModel:getExploreState() then
        self.exploreEff:setVisible(true)
        self.exploreEff:setAnimation("idle", true)
    else
        -- self.exploreEff:setAnimation("idle", true)
        self.exploreEff:setVisible(false)
    end
end

function PetTreasureAdventureLayer:updateTreasureInfo()
    local leftContentLayer = self.contentLayout:getChildByName("leftContentLayer")
    if not leftContentLayer then
        local levelLen = #ConfigManager:getAllPetAdvLevleSelectData()
        leftContentLayer = PetTreasureAdventureLevelSelect:create(levelLen)
        leftContentLayer:init()
        leftContentLayer:leftBottom(25, 50)
        -- leftContentLayer:enableDebugDraw()
        leftContentLayer:setName("leftContentLayer")
        self.contentLayout:addChild(leftContentLayer)
        -- self.leftContentLayer = leftContentLayer
    else
        leftContentLayer:updateLayer()
    end
end

function PetTreasureAdventureLayer:updateBtn()
    local changeWorkersBtn = self.contentLayout:getChildByName("changeWorkersBtn")
    if not changeWorkersBtn then
        changeWorkersBtn = UI.Button:create()
        changeWorkersBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        changeWorkersBtn:rightBottom(260, 40)
        changeWorkersBtn._text:setWidth(152)
        changeWorkersBtn._text:setTextCenter()
        changeWorkersBtn._text:setLineSpacing(-8)
        changeWorkersBtn:setText(UI.TEXT_1314104)
        changeWorkersBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        changeWorkersBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end
            if not self.isEmbattling then
                self.isEmbattling = true
                self:showPetTreasurePacket()
            else
                self.isEmbattling = false
                local packetLayer = self.contentLayout:getChildByName("packetLayer")
                if packetLayer then
                    packetLayer:removeFromParent(false)
                end
            end

            self:updateBtn()

            -- 开蛋测试
            -- mvc.openPanel("Pet", "PetResultShow", {showType = 1, eggType = 3, id = "4938803256"})
        end)
        changeWorkersBtn:setName("changeWorkersBtn")
        self.contentLayout:addChild(changeWorkersBtn)
    end

    local battleBtn = self.contentLayout:getChildByName("battleBtn")
    if not battleBtn then
        battleBtn = UI.Button:create()
        battleBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png")
        battleBtn:rightBottom(50, 40)
        battleBtn._text:setWidth(152)
        battleBtn._text:setTextCenter()
        battleBtn._text:setLineSpacing(-8)
        -- battleBtn:setText(UI.TEXT_1212081)
        battleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        battleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.battleBtnClicked)
        battleBtn:setName("battleBtn")
        self.contentLayout:addChild(battleBtn)
    end
    -- self:getSelectedLevel()
    local curLevel = self:getSelectedLevel() or self.curLevel
    if curLevel <= mvc.petTreasureModel:getPetAdvLevel() and mvc.petTreasureModel:getPetAdvLevel() ~= 0 then
        battleBtn:setText(UI.TEXT_221100)
    else
        battleBtn:setText(UI.TEXT_1212081)
    end

    local redPoint = battleBtn:getChildByName("redPoint")
    if not redPoint then
        redPoint = AvalonUtil.createRedPoint(battleBtn, 2, 2, 100)
        redPoint:setName("redPoint")
        redPoint:hide()
    end

    if mvc.petTreasureModel:getExploreState() then--and self.curLevel == mvc.petTreasureModel:getExploreLevel() then
        changeWorkersBtn:disable()
        changeWorkersBtn:setText(UI.TEXT_1314104)

        battleBtn:setText(UI.TEXT_221104)
        local redPoint = battleBtn:getChildByName("redPoint")
        -- local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))
        local remainTime = mvc.petTreasureModel:getExploreRemainTime()
        local rewardsArr = mvc.petTreasureModel:getGoodsArrLenth(PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE)
        if remainTime <= 0 or rewardsArr > 0 then
            redPoint:show()
        else
            redPoint:hide()
        end
    else
        -- battleBtn:setText(UI.TEXT_1212081)
        local redPoint = battleBtn:getChildByName("redPoint")
        redPoint:hide()

        changeWorkersBtn:enable()
        if self.isEmbattling then
            changeWorkersBtn:setText(UI.TEXT_1212272)
        else
            changeWorkersBtn:setText(UI.TEXT_1314104)
        end
    end
end

function PetTreasureAdventureLayer:battleBtnClicked()
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    if mvc.petTreasureModel:getExploreState() then--and self.curLevel == mvc.petTreasureModel:getExploreLevel() then
        -- 背包至少要空出一个格子
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        local rewardsArr = mvc.petTreasureModel:getGoodsArrLenth(PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE)
        if freePacketNum < rewardsArr then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
            return
        end
        
        mvc.send("PetAdventure_Explore_Stop")
        return
    end

    -- 未探索状态下
    if not mvc.petTreasureModel:getExploreState() then
        -- 上阵宠物数量不足3个
        if mvc.petTreasureModel:getPetAdvPetsNum() < 3 then
            UI.ScrollBar:createByText(UI.TEXT_1314128)
            return
        end
    end

    -- -- 派遣状态下
    -- if mvc.petTreasureModel:getIsGathering() then
    --     local gatherPets = mvc.petTreasureModel:getWorkersData()
    --     local explorePets = mvc.petTreasureModel:getPetAdvEmbattlePets()
    --     for _, v in pairs(gatherPets) do
    --         for _, v2 in pairs(explorePets) do
    --             if v:getId() == v2:getId() then
    --                 UI.ScrollBar:createByText(UI.TEXT_221105)
    --                 return
    --             end
    --         end
    --     end
    -- end

    -- UI.WaitingLayer:showWaiting(true, nil, 5)
    if self:getSelectedLevel() <= mvc.petTreasureModel:getPetAdvLevel() then
        -- battleBtn:setText(UI.TEXT_221100)
        if not mvc.petTreasureModel:getExploreState() then  --非探险状态
            mvc.send("PetAdventure_Explore")
        end    
    else
        mvc.send("PetAdventure_Challenge")
    end
    
end

function PetTreasureAdventureLayer:showPetTreasurePacket()
    
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureAdventureLayer")
        packetLayer:updateByData(petArr)
    else
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureAdventureLayer")
        local packetLayer = PetPacketLayer:create()
        packetLayer:init(petArr, "PetTreasureAdventureLayer")
        packetLayer:leftUp(35, 43.5)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function PetTreasureAdventureLayer:slotDragEnd(petData, touchPosition)
    if mvc.petTreasureModel:getPetAdvPetsNum() >= 3 then
        UI.ScrollBar:createByText(UI.TEXT_1314132)
        return
    end

    local embattleLayer = self.contentLayout:getChildByName("embattleLayer")
    if embattleLayer then
        embattleLayer:petAdvSlotDragEnd(petData, touchPosition)
    end

    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.petTreasureModel:getPacketPets("PetTreasureAdventureLayer")
        packetLayer:updateByData(petArr)
    end
end

function PetTreasureAdventureLayer:onOpenExplorBag()
    -- Avalon.AudioManager:playSound("1503")
    if (not tolua.isnull(self.bagView)) then
        self.bagView:removeFromParent()
        self.bagView = nil
    end

    -- self.bagBg:setBtnStatus(ButtonState.ACTIVE)
    -- if (not self.fastBagBtn:isDisable()) then
    --     self.fastBagBtn:setBtnStatus(ButtonState.NORMAL)
    -- end

    local data = mvc.expeditionModel:getGoodsArrForBag(PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE)
    -- reload_script_file_mvc("app.modules.expedition.ExpeditionBagView")
    local expeditionBagView = require("app.modules.expedition.ExpeditionBagView")
    self.bagView = expeditionBagView:create()
    self.bagView:init(PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE, data)
    self.bagView:rightUp(5, 10)
    self.contentLayout:addChild(self.bagView, 1000)
end

function PetTreasureAdventureLayer:getPetAdvWorkList()
    return self.embattleLayer:getPetAdventureList()
end

function PetTreasureAdventureLayer:setCurLevel(levle)
    self.curLevel = levle
end

function PetTreasureAdventureLayer:getSelectedLevel()
    local leftContentLayer = self.contentLayout:getChildByName("leftContentLayer")
    if leftContentLayer then
        return leftContentLayer:getSelectedLevel()
    end
    return nil
end

function PetTreasureAdventureLayer:bindModel()

end

function PetTreasureAdventureLayer:unbindModel()

end

return PetTreasureAdventureLayer