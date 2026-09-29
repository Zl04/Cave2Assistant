-- PetMainListCell.lua
-- Author:lzm

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local PetMainListCell = class("PetMainListCell", UI.ListGrid)

UI.PetMainListCell = PetMainListCell

local COM_WIDTH = 71
local COM_HEIGHT = 71

local COM_RES_LIST = {
    "ui_common_grid.plist",
    "ui_common_monsterhead.plist",
}

--构造函数(必备)
function PetMainListCell:ctor()
    PetMainListCell.super.ctor(self, RES_LIST, COM_WIDTH, COM_HEIGHT)
end

--虚构函数,destroy时调用(必备)
function PetMainListCell:dtor()
    PetMainListCell.super.dtor(self)
end

-- 初始化(必备)
function PetMainListCell:init(petID, hideStar, hideLv, isOther, petData, siteId)
    PetMainListCell.super.init(self)
    self:setTouchEnable(true)
    self:setSwallowTouches(false)

    self._data = {}

    if petID then
        self._data.petID = petID
    end

    if hideStar then
        self._data.hideStar = hideStar
    end

    if hideLv then
        self._data.hideLv = hideLv
    end

    if isOther then
        self._data.isOther = isOther
    end

    if petData then
        self._data.petData = petData
    end

    if siteId then
        self._data.siteId = siteId
    end
end

-- 模版函数：初始化组建的视图(必备)
function PetMainListCell:onInitView()
end

function PetMainListCell:getData()
    return self._data
end

function PetMainListCell:onUpdateView()
    if not self._data then
        return
    end

    local petData
    if self._data.isOther then
        petData = self._data.petData
    else
        petData = MasterDataManager:getBagPetById(self._data.petID)
    end

    local content = self:getChildByName("Content")
    if content then
        self:removeChildByName("Content")
    end

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    cellLayout:setName("Content")
    --cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local bg = UI.Image:create()
    bg:init("box_quality_box_01.png")
    bg:center()
    self.cellLayout:addChild(bg)

    if self._data.emptySlot then
        return
    end

    local star = 0
    if not self._data.hideStar then
        star = petData:getStarLv()
    end

    -- local bgImg = "box_quality_0_1.png"
    -- if star == 0 or star == 1 then
    --     bgImg = "box_quality_0_1.png"
    -- elseif star == 2 or star == 3 then
    --     bgImg = "box_quality_0_2.png"
    -- elseif star == 4 or star == 5 then
    --     bgImg = "box_quality_0_3.png"
    -- elseif star == 6 or star == 7 then
    --     bgImg = "box_quality_0_4.png"
    -- elseif star == 8 or star == 9 then
    --     bgImg = "box_quality_0_5.png"
    -- end

    local petQuality = petData:getPetQuality()
    local bgImg = "box_quality_1_2.png"
    local abovePetImg = "box_quality_4_2.png"
    if petQuality == PublicDefine.PetQualityType.Blue then
        bgImg = "box_quality_1_2.png"
        abovePetImg = "box_quality_4_2.png"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        bgImg = "box_quality_1_3.png"
        abovePetImg = "box_quality_4_3.png"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        bgImg = "box_quality_1_4.png"
        abovePetImg = "box_quality_4_4.png"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        bgImg = "box_quality_1_5.png"
        abovePetImg = "box_quality_4_5.png"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        bgImg = "box_quality_1_6.png"
        abovePetImg = "box_quality_4_6.png"
    elseif petQuality == PublicDefine.PetQualityType.Platinum then
        bgImg = "box_quality_1_7.png"
        abovePetImg = "box_quality_4_7.png"
    end



    local qualityBG = UI.Image:create()
    qualityBG:init(bgImg);
    qualityBG:center();
    self.cellLayout:addChild(qualityBG)
    self.qualityBG = qualityBG

    local petIcon = UI.Image:create()
    petIcon:init(petData:getIcon())
    petIcon:center();
    self.cellLayout:addChild(petIcon)

    local abovePetBG = UI.Image:create()
    abovePetBG:init(abovePetImg);
    abovePetBG:center();
    self.cellLayout:addChild(abovePetBG)

    if petQuality == PublicDefine.PetQualityType.Platinum then
        local platinumEff = UI.Animation:create()
        platinumEff:init("effect_ui_common_box_quality_platinum.json", "effect_ui_common_box_quality_platinum.atlas")
        platinumEff:center()
        platinumEff:setAnimation("idle", true)
        abovePetBG:addChild(platinumEff, 99)
    end

    if self._data.select then
        self:cellClick()
    else
        self:clearSelect()
    end

    if petData and petData:isFight() and petData.siteId ~= 0 then
        local fightBoader = UI.Image:create()
        fightBoader:init("ui_pets_fight.png");
        fightBoader:center();
        self.cellLayout:addChild(fightBoader)
    end

    if not self._data.hideLv then
        local lvLayout = UI.Layout:create();
        lvLayout:init()
        lvLayout:setSize(50, 20)
        self.cellLayout:addChild(lvLayout, 20)

        local lvImg = UI.Image:create()
        lvImg:init("ui_home_banner_lv.png")
        lvImg:centerLeft(0)
        lvLayout:addChild(lvImg)
        local configDatas = petData:getNowReincarnationConfig()
        local lv = petData:getLevel() - configDatas.value
        local lvInnerLayout = AvalonUtil:getStyledNumberNode(lv)
        lvInnerLayout:centerLeft(25)
        lvLayout:addChild(lvInnerLayout)

        lvLayout:leftUp(-12, -5)
        lvLayout:setScaleX(0.6)
        lvLayout:setScaleY(0.6)
    end

    if petData and petData:isFight() then
        local battleAnimation = UI.Animation:create()
        -- dump(petData, "petData")
        -- print("petData.siteId:", petData:getSiteId())
        local fightPetData = RoleDataManager:getFightPetbyId(petData.spriteID)
        if fightPetData and fightPetData:getSiteId() and fightPetData:getSiteId() ~= 0 then
            battleAnimation:init("effect_ui_town_guild_guildfuben_fighting01.json", "effect_ui_town_guild_guildfuben_fighting01.atlas")
        else
            battleAnimation:init("effect_ui_town_guild_guildfuben_fighting.json", "effect_ui_town_guild_guildfuben_fighting.atlas")
        end
        
        battleAnimation:rightUp(12, 12)
        battleAnimation:setAnimation("idle", true)
        battleAnimation:setScaleX(0.7)
        battleAnimation:setScaleY(0.7)
        self.cellLayout:addChild(battleAnimation, 10)
    end

    if not self._data.hideStar then
        local starTxt = UI.Text:create()
        starTxt:init(tostring(star), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_230_210_190)
        starTxt:rightBottom(5, 2)
        self.cellLayout:addComponent(starTxt)

        local txtW = starTxt:getContentSize().width
        local starImg = UI.Image:create()
        starImg:init("ui_pets_box_star.png")
        starImg:rightBottom(txtW+5, 4)
        self.cellLayout:addComponent(starImg)
    end
end

function PetMainListCell:updateStarShow()
end

function PetMainListCell:cellClick()
    if not self.select then
        self.select = UI.Animation:create()
        self.select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
        self.select:center()
        self.cellLayout:addChild(self.select, 0)
    end

    self.select:show()
    self.select:setAnimation("start_square", false)
    self.select:addAnimation("loop_square", true)

    self._data.select = true
end

function PetMainListCell:isClickShowInfo()
    return true
end

function PetMainListCell:clearSelect()
    if not self.select then
        return
    end

    self.select:setAnimation("end_square", false)

    self._data.select = false
end

-- 克隆
function PetMainListCell:createDraggedView()
    if self._data.emptySlot then
        return
    end

    return self:createCloneObj()
end

function PetMainListCell:createCloneObj()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    --cellLayout:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("box_quality_box_01.png")
    bg:center()
    cellLayout:addChild(bg)

    local petData
    if self._data.isOther then
        petData = self._data.petData
    else
        petData = MasterDataManager:getBagPetById(self._data.petID)
    end
    local star = 0
    if not self._data.hideStar then
        star = petData:getStarLv()
    end

    -- local bgImg = "box_quality_0_1.png"
    -- if star == 0 or star == 1 then
    --     bgImg = "box_quality_0_1.png"
    -- elseif star == 2 or star == 3 then
    --     bgImg = "box_quality_0_2.png"
    -- elseif star == 4 or star == 5 then
    --     bgImg = "box_quality_0_3.png"
    -- elseif star == 6 or star == 7 then
    --     bgImg = "box_quality_0_4.png"
    -- elseif star == 8 or star == 9 then
    --     bgImg = "box_quality_0_5.png"
    -- end

    local petQuality = petData:getPetQuality()
    local bgImg = "box_quality_1_2.png"
    local abovePetImg = "box_quality_4_2.png"
    if petQuality == PublicDefine.PetQualityType.Blue then
        bgImg = "box_quality_1_2.png"
        abovePetImg = "box_quality_4_2.png"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        bgImg = "box_quality_1_3.png"
        abovePetImg = "box_quality_4_3.png"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        bgImg = "box_quality_1_4.png"
        abovePetImg = "box_quality_4_4.png"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        bgImg = "box_quality_1_5.png"
        abovePetImg = "box_quality_4_5.png"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        bgImg = "box_quality_1_6.png"
        abovePetImg = "box_quality_4_6.png"
    elseif petQuality == PublicDefine.PetQualityType.Platinum then
        bgImg = "box_quality_1_7.png"
        abovePetImg = "box_quality_4_7.png"
    end

    local qualityBG = UI.Image:create()
    qualityBG:init(bgImg);
    qualityBG:center();
    cellLayout:addChild(qualityBG)

    local petIcon = UI.Image:create()
    if self._data.showQuestion then
        -- 未拥有则显示问号
        petIcon:init("ui_pets_manual_unkown.png");
    else
        petIcon:init(petData:getIcon());
    end
    petIcon:center();
    cellLayout:addChild(petIcon)

    local abovePetBG = UI.Image:create()
    abovePetBG:init(abovePetImg);
    abovePetBG:center();
    cellLayout:addChild(abovePetBG)

    if petQuality == PublicDefine.PetQualityType.Platinum then
        local platinumEff = UI.Animation:create()
        platinumEff:init("effect_ui_common_box_quality_platinum.json", "effect_ui_common_box_quality_platinum.atlas")
        platinumEff:center()
        platinumEff:setAnimation("idle", true)
        abovePetBG:addChild(platinumEff, 99)
    end

    if not self._data.hideLv then
        local lvLayout = UI.Layout:create();
        lvLayout:init()
        lvLayout:setSize(50, 20)
        self.cellLayout:addChild(lvLayout, 20)

        local lvImg = UI.Image:create()
        lvImg:init("ui_home_banner_lv.png")
        lvImg:centerLeft(0)
        lvLayout:addChild(lvImg)

        local configDatas = petData:getNowReincarnationConfig()
        local lv = petData:getLevel() - configDatas.value
        local lvInnerLayout = AvalonUtil:getStyledNumberNode(lv)
        lvInnerLayout:centerLeft(25)
        lvLayout:addChild(lvInnerLayout)

        lvLayout:leftUp(-12, -5)
        lvLayout:setScaleX(0.6)
        lvLayout:setScaleY(0.6)
    end

    if not self._data.hideStar then
        local starTxt = UI.Text:create()
        starTxt:init(tostring(star), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_250_211_124)
        starTxt:rightBottom(5, 2)
        cellLayout:addComponent(starTxt)

        local txtW = starTxt:getContentSize().width
        local starImg = UI.Image:create()
        starImg:setScaleX(0.6)
        starImg:setScaleY(0.6)
        starImg:init("ui_information_equip.png")
        starImg:rightBottom(txtW+3, 2)
        cellLayout:addComponent(starImg)
    end

    return cellLayout
end
