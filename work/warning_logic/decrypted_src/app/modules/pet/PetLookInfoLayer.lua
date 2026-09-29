------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/15
--desc	: 宠物基础属性公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetLookInfoLayer = class("PetLookInfoLayer", UI.BaseWin)

require "app.modules.pet.PetMainListCell"

UI = UI or {}

UI.PetLookInfoLayer = PetLookInfoLayer

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
}

local PET_TYPE_ICON = {
    [1]={"ui_pets_type_attack_0.png", "ui_pets_type_attack_1.png"},
    [2]={"ui_pets_type_defense_0.png", "ui_pets_type_defense_1.png"},
    [3]={"ui_pets_type_balanced_0.png", "ui_pets_type_balanced_1.png"},
    [4]={"ui_pets_type_special_0.png", "ui_pets_type_special_1.png"},
}

local PET_TYPE_TEXT = {
    UI.TEXT_1213629,
    UI.TEXT_1213630,
    UI.TEXT_1213631,
    UI.TEXT_1213632,
}

local COM_WIDTH = 420
local COM_HEIGHT = 510

function PetLookInfoLayer:ctor()
    PetLookInfoLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetLookInfoLayer:init(rootLayer, data, ... )
    self.rootLayer = rootLayer
    self.curPet = data

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetLookInfoLayer.super.init(self, ... )
end

function PetLookInfoLayer:dtor()
    PetLookInfoLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pet.PetLookInfoLayer")
end

function PetLookInfoLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create();
    bg:init("ui_pets_rune.png")
    bg:center();
    self.contentLayout:addChild(bg);

    local typeIcon  = UI.Image:create();
    if self.curPet.isVariant then
        typeIcon:init("ui_pets_variation.png");
    else
        typeIcon:init("ui_pets_ordinary.png");
    end
    typeIcon:leftUp(34, 11);
    self.contentLayout:addChild(typeIcon, 300)
    self.typeIcon = typeIcon

    local petNameBg = UI.Image:create()
    petNameBg:init("ui_pets_nametitle.png")
    petNameBg:centerUp(22)
    self.contentLayout:addChild(petNameBg, 200)

    local petNameTxt = UI.Text:create()
    petNameTxt:init(self.curPet:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    petNameTxt:setWidth(300)
    petNameTxt:setTextCenter()
    petNameTxt:autoAdapt()
    petNameTxt:center()
    petNameBg:addChild(petNameTxt)
    self.petNameTxt = petNameTxt

    -- 宠物类型
    local petTypeBtn = UI.Button:create();
    local icons = PET_TYPE_ICON[self.curPet.petType]
    self.typeTxt = PET_TYPE_TEXT[self.curPet.petType]
    petTypeBtn:init(icons[1],icons[2],icons[1]);
    petTypeBtn:rightUp(15, 67);
    petTypeBtn:closeClickScale()
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, self.typeTxt)
    end)
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    self.contentLayout:addChild(petTypeBtn)
    self.petTypeBtn = petTypeBtn

    -- 宠物特质
    self:updateSpecial()
    -- 星级
    self:updateStarShow()
   
    -- 底光
    local lightDownEff = UI.Animation:create()
    lightDownEff:init("effect_ui_town_pet_show_down.json", "effect_ui_town_pet_show_down.atlas", 1);
    lightDownEff:centerUp(242)
    -- lightDownEff:setAnimation("idle", true)
    self.contentLayout:addChild(lightDownEff)

    -- 宠物动画
    self:updatePetAnimation()

    -- 上光
    local lightUpEff = UI.Animation:create()
    lightUpEff:init("effect_ui_town_pet_show_up.json", "effect_ui_town_pet_show_up.atlas", 1);
    lightUpEff:centerUp(246)
    -- lightUpEff:setAnimation("idle", true)
    self.contentLayout:addChild(lightUpEff)

    local petQuality = self.curPet:getPetQuality()
    local animationName = "idle1"
    if petQuality == PublicDefine.PetQualityType.Blue then
        animationName = "idle1"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        animationName = "idle2"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        animationName = "idle3"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        animationName = "idle4"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        animationName = "idle5"
    end
    lightDownEff:setAnimation(animationName, true)
    lightUpEff:setAnimation(animationName, true)

    -- 等级
    self:updateLevelShow()

    -- 战力
    self:updatePowerShow()

    local pets = {}
    table.insert(pets, {petData = self.curPet, isOther = true})
    for i = 1, 7 do
        local empty = {}
        empty.emptySlot = true
        table.insert(pets, empty)
    end

    local gridList = UI.GridList:create()
    gridList:init(UI.PetMainListCell, 4, 1, 93, 93, 0, 0, 0)
    gridList:setData(pets)
    gridList:setSize(372, 186)
    gridList:leftBottom(8, 20)
    gridList:disableToDragGrid()
    gridList:setScrollBarEnabled(false)
    gridList:setCircleVisible(false)

    self.gridList = gridList
    self.contentLayout:addChild(gridList)

    local mask = UI.Image:create()
    mask:init("ui_pets_mask.png")
    mask:leftBottom(9, 16)
    self.contentLayout:addComponent(mask, 20)

    performWithDelay(self, function()
        if tolua.isnull(self) then
            return
        end

        local listObj = self.gridList:getGridList()
        listObj[1]:cellClick()
    end, 0.1)

end

function PetLookInfoLayer:updateSpecial()
    local buffIDs = self.curPet.buffs
    if buffIDs then
        for k, v in ipairs(buffIDs) do
            local buffData = ConfigManager:getBufferConfigById(v)
            if buffData then
                local specialTxt = languageManagerInstance:getLocalString(buffData.description)
                local petSpecialBtn = UI.Button:create()
                petSpecialBtn:init("ui_pets_trait_0.png","ui_pets_trait_1.png","ui_pets_trait_0.png")
                petSpecialBtn:rightUp(15, 117 + (k - 1) * 50);
                petSpecialBtn:closeClickScale()
                petSpecialBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, specialTxt)
                end)
                petSpecialBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
                end)
                self.contentLayout:addChild(petSpecialBtn)
            end
        end
    end 
end

function PetLookInfoLayer:updateStarShow()
    local starLayout = self.contentLayout:getChildByName("StarLayout")
    if starLayout then
        self.contentLayout:removeChildByName("StarLayout")
    end

    -- 星级
    local starLv, canLvUpNum = self.curPet:getStarLv()
    if starLv > 0 or canLvUpNum > 0 then
        local starLayout = UI.Layout:create();
        starLayout:init()
        starLayout:setSize(220, 30)
        starLayout:leftUp(100, 55)
        starLayout:setName("StarLayout")
        self.contentLayout:addChild(starLayout, 100)

        local starBg = UI.Image:create()
        starBg:init("ui_pets_star_banner.png")
        starBg:center()
        starLayout:addChild(starBg)

        local starAutoLayer = UI.Layout:create();
        starAutoLayer:init()
        starAutoLayer:center()
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
        -- starAutoLayer:enableDebugDraw()
        starLayout:addChild(starAutoLayer, 20)

        for i = 1, starLv do
            local starImg = UI.Image:create()
            starImg:init("symbol_character_hero_power.png")
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)
        end

        for i = 1, canLvUpNum do
            local starImg = UI.Image:create()
            starImg:init("symbol_character_hero_power_0.png")
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)
        end
    end
end

function PetLookInfoLayer:updatePetAnimation()
    local petAnimation = self.contentLayout:getChildByName("PetAnimation")
    if petAnimation then
        self.contentLayout:removeChildByName("PetAnimation")
    end

    local layerScale = self.curPet:getLayerScale()
    local petAnimation = UI.Animation:create()
    local spineName, jsonName, scale = self.curPet:getAnimationData()
    local spineArr = string.split(self.curPet.spine, ";")
    local spineOffset = string.split(self.curPet.spineoffset, ";")
    local offsetOne = self.curPet.isVariant and spineOffset[2] or spineOffset[1]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName, jsonName, scale, true)
    petAnimation:centerUp(240 - offset[2])
    petAnimation:setAnimation("idle3", true)
    petAnimation:setScale(layerScale)
    petAnimation:setName("PetAnimation")
    self.contentLayout:addChild(petAnimation)
end

function PetLookInfoLayer:updateLevelShow()
    local levelLayout = self.contentLayout:getChildByName("LevelLayout")
    if levelLayout then
        self.contentLayout:removeChildByName("LevelLayout")
    end

    local lvLayout = UI.Layout:create();
    lvLayout:init()
    lvLayout:enableAutoWidth()
    lvLayout:enableAutoHeight()
    lvLayout:setName("LevelLayout")
    self.contentLayout:addChild(lvLayout, 20)

    local lvImg = UI.Image:create()
    lvImg:init("ui_home_banner_lv.png")
    lvImg:floatLeft(0)
    lvLayout:addComponent(lvImg)

    local lvInnerLayout = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    lvInnerLayout:floatLeft(5)
    lvLayout:addComponent(lvInnerLayout)

    lvLayout:centerUp(240)
end

function PetLookInfoLayer:updatePowerShow()
    local layout = self.contentLayout:getChildByName("PowerLayout")
    if layout then
        self.contentLayout:removeChildByName("PowerLayout")
    end

    local powerLayout = UI.Layout:create();
    powerLayout:init()
    powerLayout:enableAutoWidth()
    powerLayout:enableAutoHeight()
    powerLayout:setName("PowerLayout")
    self.contentLayout:addChild(powerLayout, 20)

    local powerBg = UI.Image:create()
    powerBg:init("ui_pets_power_banner.png")
    powerBg:center()
    powerLayout:addChild(powerBg)

    local starImg = UI.Image:create()
    starImg:init("ui_information_equip.png")
    starImg:floatLeft(0)
    powerLayout:addComponent(starImg)

    local power = self.curPet:getPower()
    local powerTxt = UI.Text:create()
    powerTxt:init(powerTxt:numformat(tostring(power)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    powerTxt:floatLeft(4)
    powerLayout:addComponent(powerTxt)

    powerLayout:centerUp(268)

end

function PetLookInfoLayer:bindModel()

end

function PetLookInfoLayer:unbindModel()

end

return PetLookInfoLayer
