------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 宠物基础属性公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetInfoLayer = class("PetInfoLayer", UI.BaseWin)
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require"app.game.SdkManager"
local SdkBox = require("utils.sdkbox.SdkBox")
require "app.modules.pet.PetMainListCell"
require "app.modules.pet.EquipmentPetIcon"

UI = UI or {}

UI.PetInfoLayer = PetInfoLayer

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

local PET_EQUIPMENT_ICON = {
    [1]={bg = "ui_pets_iocnbox_1.png", type = PublicDefine.PET_EQUIPMENT_TYPE.PetWeapon},
    [2]={bg = "ui_pets_iocnbox_2.png", type = PublicDefine.PET_EQUIPMENT_TYPE.PetHelmet},
    [3]={bg = "ui_pets_iocnbox_3.png", type = PublicDefine.PET_EQUIPMENT_TYPE.PetChest},
    [4]={bg = "ui_pets_iocnbox_4.png", type = PublicDefine.PET_EQUIPMENT_TYPE.PetAmulet},
}

local PET_TYPE_TEXT = {
    UI.TEXT_1213629,
    UI.TEXT_1213630,
    UI.TEXT_1213631,
    UI.TEXT_1213632,
}

-- 动画资源
local ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE =  "effect_ui_gaming_itemselect.json"
local ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE = "effect_ui_gaming_itemselect.atlas"
-- 装备图标尺寸
local BAG_GRID_WIDTH = 60
local BAG_GRID_HEIGHT = 60

local COM_WIDTH = 420
local COM_HEIGHT = 510
local cellNumPerRow = 4

local SKIN_CELL_WIDTH = 190
local SKIN_CELL_HEIGHT = 178

function PetInfoLayer:ctor()
    PetInfoLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.wearEquipmentIconArr = {}

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_READY_FIGHT_OK, self, self.readyFightOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_RENAME_OK, self, self.refreshPetName)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_LEVELUP_OK, self, self.levelupOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REBORN_OK, self, self.rebornOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_RAISE_QUALITY_OK, self, self.raiseQualityOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.learnSkillOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_COMPOSE_OK, self, self.composeOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REFINE_OK, self, self.refineOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_WEAR_EQUIPMENT_RESULT, self, self.wearEquipmentResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DATA_REFRESH, self, self.petDataRefresh)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REINCARNATION__OK, self, self.reincarnationOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.changeSkinOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SKIN_ATTR_DES, self, self.showDesLayer)
end

function PetInfoLayer:init(rootLayer, petID, ... )
    self.rootLayer = rootLayer
    self.curPet = MasterDataManager:getBagPetById(petID)
    self.templateConfig = ConfigManager:getPetDataByID(self.curPet.templateID)

    self.isPetListShow = true

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetInfoLayer.super.init(self, ... )
end

function PetInfoLayer:dtor()
    PetInfoLayer.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_READY_FIGHT_OK, self, self.readyFightOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_RENAME_OK, self, self.refreshPetName)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_LEVELUP_OK, self, self.levelupOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REBORN_OK, self, self.rebornOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_RAISE_QUALITY_OK, self, self.raiseQualityOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.learnSkillOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_COMPOSE_OK, self, self.composeOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REFINE_OK, self, self.refineOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_WEAR_EQUIPMENT_RESULT, self, self.wearEquipmentResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DATA_REFRESH, self, self.petDataRefresh)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REINCARNATION__OK, self, self.reincarnationOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.changeSkinOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SKIN_ATTR_DES, self, self.showDesLayer)

    reload_script_file_mvc("app.modules.pet.PetInfoLayer")
end

function PetInfoLayer:updateLayer(petListIdx)
    if petListIdx and petListIdx > 0 then
        self.curPet = MasterDataManager:getBagPets()[petListIdx]
        self.templateConfig = ConfigManager:getPetDataByID(self.curPet.templateID)
    end

    if self.curPet.isVariant then
        self.typeIcon:setSpriteName("ui_pets_variation.png");
    else
        self.typeIcon:setSpriteName("ui_pets_ordinary.png");
    end

    self:refreshPetName()
    self:refreshPetWearEquipments()

    local icons = PET_TYPE_ICON[self.curPet.petType]
    self.petTypeBtn:setNormal(icons[1])
    self.petTypeBtn:setSelected(icons[2])
    self.petTypeBtn:setDisabled(icons[1])

    if self.petSkinBtn then
        self.petSkinBtn:setVisible(self.templateConfig.skinId and table.nums(self.templateConfig.skinId) > 0)
    end

    if self.petSkinDesBtn then
        self.petSkinDesBtn:setVisible(self.curPet.skinId and self.curPet.skinId > 0)
    end

    self:updateTips()
    self:updateStarShow()
    self:updateRidingAttribute(self:updateSpecial())
    self:updatePetAnimation()
    self:updateLevelShow()
    self:updatePowerShow()
    self:updateLightEffectAnimation()
end

function PetInfoLayer:readyFightOver()
    self:resetPetList()
end

function PetInfoLayer:levelupOver()
    self:updateStarShow()
    self:updateLevelShow()
    self:updatePowerShow()
    self:resetPetList()
end

function PetInfoLayer:learnSkillOver()
    self:updatePowerShow()
end

function PetInfoLayer:raiseQualityOver()
    self:updatePowerShow()
end

function PetInfoLayer:rebornOver(data)
    self:updatePowerShow()

    if data.isVariant then
        if self.curPet.isVariant then
            self.typeIcon:setSpriteName("ui_pets_variation.png");
        else
            self.typeIcon:setSpriteName("ui_pets_ordinary.png");
        end

        self:updatePetAnimation()

        self:resetPetList()

        -- local listObj = self.gridList:getGridList()
        -- listObj[self.curPetListIdx]:cellClick()
    end
end

function PetInfoLayer:composeOver()
    self:updatePowerShow()

    self:resetPetList(true)
end

function PetInfoLayer:refineOver()
    self:resetPetList(true)
end

function PetInfoLayer:reincarnationOver()
    self:updateStarShow()
    self:updateLevelShow()
    self:updatePowerShow()
    self:resetPetList(true)
end

function PetInfoLayer:resetPetList(resetSelectSlot)
    if resetSelectSlot then
        self.curPetListIdx = 1
    end

    local petData = {}
    petData.petsArr = MasterDataManager:getBagPets()
    petData.packetMinShowGridNum = 20
    self.petList:setData(petData)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 1)

    -- if self.selectPetIndex then
    --     printInfo(self.selectPetIndex)
    --     local grid = self.petList:getGridByPetIndex(self.selectPetIndex)
    --     if grid then
    --         grid:showSelect()
    --     end
    -- end
end

function PetInfoLayer:onInitView()

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
    bg:centerUp(56);
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
    -- petNameBg:enableDebugDraw()
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

    -- 改名
    local renameBtn = UI.Button:create();
    renameBtn:init("ui_pets_rename_0.png","ui_pets_rename_1.png","ui_pets_rename_0.png");
    renameBtn:rightUp(15, 17);
    renameBtn:closeClickScale()
    renameBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- -- 暂时屏蔽CN的改名功能
        -- if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
        --     UI.ScrollBar:createByTextID(1113615)
        -- else
        --     mvc.openPanel("Pet", "PetRename", self.curPet:getId())
        -- end
        mvc.openPanel("Pet", "PetRename", self.curPet:getId())
    end)
    self.contentLayout:addChild(renameBtn)

    -- TODOTODO 2021.6.02日 特殊屏蔽改名界面(国内)
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            renameBtn:setVisible(false)
        end
    end

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
    local preY = self:updateSpecial()

    -- 骑宠骑乘属性
    self:updateRidingAttribute(preY)

    -- 宠物动画
    self:updatePetAnimation()

    -- 星级
    self:updateStarShow()

    -- 底光
    local lightDownEff = UI.Animation:create()
    lightDownEff:init("effect_ui_town_pet_show_down.json", "effect_ui_town_pet_show_down.atlas", 1);
    lightDownEff:centerUp(242)
    -- lightDownEff:setAnimation("idle", true)
    self.contentLayout:addChild(lightDownEff)
    self.lightDownEff = lightDownEff

    -- 上光
    local lightUpEff = UI.Animation:create()
    lightUpEff:init("effect_ui_town_pet_show_up.json", "effect_ui_town_pet_show_up.atlas", 1);
    lightUpEff:centerUp(246)
    -- lightUpEff:setAnimation("idle", true)
    self.contentLayout:addChild(lightUpEff)
    self.lightUpEff = lightUpEff

    local animationName = self:getLightEffectAnimationName()
    lightDownEff:setAnimation(animationName, true)
    lightUpEff:setAnimation(animationName, true)

    -- 等级
    self:updateLevelShow()

    -- 战力
    self:updatePowerShow()

    -- 初始化装备
    self:initPetWearEquipment()

    local petData = {}
    petData.petsArr = MasterDataManager:getBagPets()
    petData.packetMinShowGridNum = 8

    local petListBg = UI.Image:create()
    petListBg:init("ui_pets_petbag.png")
    petListBg:leftBottom(10, 16)
    self.contentLayout:addChild(petListBg)
    
    local petList = UI.PetList:create(4)
    self.petList = petList
    petList:init(petData, 186)
    petList:leftBottom(33, -2)
    petList:updateCanDrag(false)
    petList:setCallbackForGridClick(self, self.cellClickCallback)
    self.contentLayout:addChild(petList)
    petList:showMask()
    -- self.contentLayout:enableDebugDraw()

    local petSkinDesBtn = UI.Button:create();
    petSkinDesBtn:init("ui_pets_skin_btn_attribute1.png","ui_pets_skin_btn_attribute2.png","ui_pets_skin_btn_attribute1.png")
    petSkinDesBtn:centerRight(15, 30)
    petSkinDesBtn:closeClickScale()
    self.contentLayout:addChild(petSkinDesBtn)
    petSkinDesBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        if self.curPet.skinId and self.curPet.skinId > 0 then
            local skinConfig = ConfigManager:getPetSkinByID(self.curPet.skinId)
            local specialTxt = languageManagerInstance:getLocalString(skinConfig.attributeDes)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, specialTxt)
        end
    end)
    petSkinDesBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    self.petSkinDesBtn = petSkinDesBtn
    petSkinDesBtn:setVisible(self.curPet.skinId and self.curPet.skinId > 0)

    local petSkinBtn = UI.Button:create();
    petSkinBtn:init("ui_pets_skin_btn_sk1.png","ui_pets_skin_btn_sk2.png","ui_pets_skin_btn_sk1.png")
    petSkinBtn:centerLeft(30, 15)
    petSkinBtn:closeClickScale()
    self.contentLayout:addChild(petSkinBtn)
    petSkinBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        if self.isPetListShow  then
            self:onPetSkinShow(petSkinBtn)
        else
            self:onPetListShow()
        end
        
    end)
    self.petSkinBtn = petSkinBtn
    petSkinBtn:setVisible(self.templateConfig.skinId and table.nums(self.templateConfig.skinId) > 0)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 1)

    self:addPetSkinList(self.curPet)
end

function PetInfoLayer:updateLightEffectAnimation()

    local animationName = self:getLightEffectAnimationName()
    if self.lightDownEff then
        self.lightDownEff:setAnimation(animationName, true)
    end

    if self.lightUpEff then
        self.lightUpEff:setAnimation(animationName, true)
    end
end

function PetInfoLayer:getLightEffectAnimationName()
    if not self.curPet then
        return "idle1"
    end
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
    return animationName
end

function PetInfoLayer:scrollPetList(cellNumPerRow, totalCount)
    if totalCount > 8 then
        local rowIdx = math.max(math.floor(self.curPetListIdx/cellNumPerRow)-1, 0)
        local totalRow = math.ceil(totalCount/cellNumPerRow)
        self.gridList:scrollToPercentVertical(math.min(rowIdx/(totalRow-2)*100), 100)
    else
        self.gridList:scrollToTop()
    end
end

function PetInfoLayer:updateTips()
    self.typeTxt = PET_TYPE_TEXT[self.curPet.petType]
end

function PetInfoLayer:initPetWearEquipment()
    local wearLayout = UI.Layout:create()
    wearLayout:init()
    wearLayout:setSize(315, 163)
    wearLayout:leftUp(53, 98)

    for k,v in ipairs(PET_EQUIPMENT_ICON) do 
        local equipPetIcon = UI.EquipmentPetIcon:create(self);
        equipPetIcon:setDragOutSizeJudegNode(self)
        equipPetIcon:init(v.bg, v.type)
        if(v.type == PublicDefine.PET_EQUIPMENT_TYPE.PetWeapon) then
            equipPetIcon:leftUp(5,5)
        elseif(v.type == PublicDefine.PET_EQUIPMENT_TYPE.PetHelmet) then
            equipPetIcon:rightUp(5,5)
        elseif(v.type == PublicDefine.PET_EQUIPMENT_TYPE.PetChest) then
            equipPetIcon:leftBottom(5,5)
        elseif(v.type == PublicDefine.PET_EQUIPMENT_TYPE.PetAmulet) then
            equipPetIcon:rightBottom(5,5)
        end
        table.insert(self.wearEquipmentIconArr, equipPetIcon)
        wearLayout:addChild(equipPetIcon)

        equipPetIcon:setTouchEnable(true)
        equipPetIcon:setClickAudioEnable(true)
        -- equipPetIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, equipmentIcon, touchPosition)
        --     if (equipmentIcon:getEquipmentData()) then
        --         self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, equipmentIcon, equipmentIcon:getIndex())
        --     else
        --         -- 通知点中没有装备的装备图标
        --         self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, nil, 0)
        --     end
        -- end)
    end

    self.contentLayout:addChild(wearLayout, 25)
    -- wearLayout:enableDebugDraw()
    -- self.contentLayout:enableDebugDraw()

    -- 装备图标激活的动画
    self._equipmentIconActiveAnimation = UI.Animation:create()
    self._equipmentIconActiveAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconActiveAnimation:setVisible(false)
    self._equipmentIconActiveAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    wearLayout:addChild(self._equipmentIconActiveAnimation, 20)

    -- 装备被选中的动画
    self._equipmentIconSelectedAnimation = UI.Animation:create()
    self._equipmentIconSelectedAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconSelectedAnimation:setVisible(false)
    self._equipmentIconSelectedAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    wearLayout:addChild(self._equipmentIconSelectedAnimation, 20)

    self:refreshPetWearEquipments()
end

function PetInfoLayer:refreshPetWearEquipments()
    for k,v in ipairs(self.wearEquipmentIconArr) do 
        v:hideEquipmentGrid()
    end
    
    if(self.curPet) then 
        local wearArr = self.curPet:getWearEquipmentArr()
        print("PetInfoLayer:refreshPetWearEquipments", #wearArr)
        if(wearArr) then 
            for k, petEquipmentData in pairs(wearArr) do 
                petEquipmentData:setUseNum(0)
                local equipType = petEquipmentData:getEquipmentType()
                for _, equipmentIcon in pairs(self.wearEquipmentIconArr) do 
                    if(equipmentIcon:getIndex() == equipType) then 
                        -- print("PetInfoLayer:refreshPetWearEquipments 2=", #wearArr)
                        equipmentIcon:setData(petEquipmentData)
                        equipmentIcon:updateView()
                    end
                end
            end
        end
    end
end

function PetInfoLayer:updateStarShow()
    local starLayout = self.contentLayout:getChildByName("StarLayout")
    if starLayout then
        self.contentLayout:removeChildByName("StarLayout")
    end

    -- 星级
    local str1 = "symbol_character_hero_power.png"
    local str2 = "symbol_character_hero_power_0.png"
    local disStar = -2
    local disCan = -2
    local starLv, canLvUpNum = self.curPet:getStarLv()
    local nowReincarntionLv = self.curPet:getReincarntionLv()
    if nowReincarntionLv > 0 then
        local configDatas = ConfigManager:getAllPetReincarnationDataByID(nowReincarntionLv)
        starLv = starLv - tonumber(configDatas.deductStars)
        --canLvUpNum = canLvUpNum - tonumber(configDatas.deductStars)
        str1 = "ui_information_equip2.png" 
        str2 = "symbol_character_hero_power_0.png"
        disStar = -3
        disCan = 0
    end
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
        starLayout:addChild(starAutoLayer, 50)

        for i = 1, starLv do
            local starImg = UI.Image:create()
            starImg:init(str1)
            starImg:floatLeft(disStar)
            starAutoLayer:addComponent(starImg)
        end

        for i = 1, canLvUpNum do
            local starImg = UI.Image:create()
            starImg:init(str2)
            starImg:floatLeft(disCan)
            starAutoLayer:addComponent(starImg)
        end
    end
end

function PetInfoLayer:updatePetAnimation()
    local animation = self.contentLayout:getChildByName("PetAnimation")
    if animation and not tolua.isnull(animation) then
        animation:runAction(cc.RemoveSelf:create())
        -- self.contentLayout:removeChildByName("animation")
        animation = nil
    end

    local layerScale = self.curPet:getLayerScale()
    local spineName, jsonName, scale = self.curPet:getAnimationData()
    local petAnimation = UI.Animation:create()
    local spineOffset = string.split(self.curPet.spineoffset, ";")
    local offsetOne = self.curPet.isVariant and spineOffset[2] or spineOffset[1]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName, jsonName, scale, true)
    petAnimation:centerUp(240 - offset[2])
    petAnimation:setAnimation("idle3", true)
    petAnimation:setScale(layerScale)
    petAnimation:setName("PetAnimation")
    self.contentLayout:addChild(petAnimation, 10)
end

function PetInfoLayer:updateSpecial()
    local petSpecialBtn = self.contentLayout:getChildByName("petSpecialBtn")
    if petSpecialBtn then
        self.contentLayout:removeChildByName("petSpecialBtn")
    end

    local preY = 117
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
                petSpecialBtn:setName("petSpecialBtn")
                petSpecialBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, specialTxt)
                end)
                petSpecialBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
                end)
                self.contentLayout:addChild(petSpecialBtn)

                preY = 117 + (k - 1) * 50
            end
        end
    end

    preY = preY + 50
    return preY
end

function PetInfoLayer:updateRidingAttribute(preY)
    local petRidingAttributeBtn = self.contentLayout:getChildByName("petRidingAttributeBtn")
    if petRidingAttributeBtn then
        self.contentLayout:removeChildByName("petRidingAttributeBtn")
    end

    local petRoleAttribute = self.curPet:getPetRoleAttribute()

    if (petRoleAttribute == "") then
        return preY
    end

    -- PublicDefine.VALUE_TYPE.Value
        -- table.insert(oneAttr,string.format("%s", endStr))
        -- table.insert(oneAttr,string.format("%.2f%%",self:getRateValue()/100))
        -- local endStr, valueType = ToolsUtil:calculationAttrShowValue(self.attrType, self.endAttr)
        -- local languageStr = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[self.attrType])
    local textAttriList = string.split(petRoleAttribute,";")
    local textAttri = languageManagerInstance:getLocalString(1114079) .. "\n"
    for k, v in ipairs(textAttriList) do 
        local aText = string.split(v,",")
        local attriType,attriValue = tonumber(aText[1]),tonumber(aText[2])
        local languageStr = ToolsUtil:getNameByAttrType(attriType)
        textAttri = textAttri .. languageStr
        -- if attriShowType == PublicDefine.VALUE_TYPE.Value then
        --     textAttri = textAttri .. attriValue
        -- else
            textAttri = textAttri .. string.format("%.2f%%",attriValue/100)
        -- end

        if k < #textAttriList then
            textAttri = textAttri .. "\n"
        end
    end


    -- local textAttri = "攻击增加 100000 \n攻击增加 200000 \n撒子都加简爱家啊啊所多居爱爱姐 1000000%"--languageManagerInstance:getLocalString(buffData.description)
    local petRidingAttributeBtn = UI.Button:create()
    petRidingAttributeBtn:init("ui_pets_trait_0.png","ui_pets_trait_1.png","ui_pets_trait_0.png")
    petRidingAttributeBtn:rightUp(15, preY);
    petRidingAttributeBtn:closeClickScale()
    petRidingAttributeBtn:setName("petRidingAttributeBtn")
    petRidingAttributeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, textAttri)
    end)
    petRidingAttributeBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    self.contentLayout:addChild(petRidingAttributeBtn)

    local fy = preY or 117
    return fy + 50
end

function PetInfoLayer:updateLevelShow()
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
    lvImg:floatBottom(-1)
    lvLayout:addComponent(lvImg)

    -- if self.curPet:getReincarntionLv() > 0 then
    --     local lvInnerLayout1 = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    --     lvInnerLayout1:floatLeft(5)
    --     lvLayout:addComponent(lvInnerLayout1)
    --     local lvInnerLayout2 = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    --     lvInnerLayout2:floatLeft(15)
    --     lvLayout:addComponent(lvInnerLayout2)
    -- else
    --     local lvInnerLayout = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    --     lvInnerLayout:floatLeft(5)
    --     lvLayout:addComponent(lvInnerLayout)
    -- end

    local lvInnerLayout = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    lvInnerLayout:floatLeft(60)
    lvInnerLayout:setName("lvInnerLayout")
    lvLayout:addComponent(lvInnerLayout)

    lvLayout:centerUp(240, -20)

    if self.curPet:getReincarntionLv() > 0 then
        -- 如果是国内CN 子渠道
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
            local lvInnerLayout = lvLayout:getChildByName("lvInnerLayout")
            if lvInnerLayout then
                lvLayout:removeChildByName("lvInnerLayout")
            end

            local nowConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
            local showLevel = self.curPet:getLevel() - tonumber(nowConfig.value)
            local lvInnerLayout2 = AvalonUtil:getStyledNumberNode(showLevel)
            lvInnerLayout2:floatLeft(-40)
            lvInnerLayout2:setName("lvInnerLayout")
            lvLayout:addComponent(lvInnerLayout2)

            -- 国内版本
            local reincarntionLv = AvalonUtil:getStyledNumberNode(self.curPet:getReincarntionLv())
            reincarntionLv:center(-60, 1)
            lvLayout:addChild(reincarntionLv)

            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init("ui_home_unmber_jie.png")
            lvReincarntionImg:center(-32, 1)
            lvLayout:addChild(lvReincarntionImg)
            lvLayout:centerUp(240)
        else
            local lvInnerLayout = lvLayout:getChildByName("lvInnerLayout")
            if lvInnerLayout then
                lvLayout:removeChildByName("lvInnerLayout")
            end

            local nowConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
            local showLevel = self.curPet:getLevel() - tonumber(nowConfig.value)
            local lvInnerLayout2 = AvalonUtil:getStyledNumberNode(showLevel)
            lvInnerLayout2:floatLeft(-50)
            lvInnerLayout2:setName("lvInnerLayout")
            lvLayout:addComponent(lvInnerLayout2)

            -- 国际版本
            local stringNum = string.format("ui_home_unmber_t%d.png", self.curPet:getReincarntionLv())
            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init(stringNum)
            lvReincarntionImg:center(-32, 1)
            lvLayout:addChild(lvReincarntionImg)
            lvLayout:centerUp(240)
        end
    end
end

function PetInfoLayer:updatePowerShow()
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

function PetInfoLayer:cellClickCallback(grid, touchPosition)
    local girdIdx = grid:getIndex()
    if self.curPetListIdx == girdIdx then
        return
    end

    if not grid:isUsed() then
        return
    end

    self.curPetListIdx = girdIdx

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SELECT_CELL_UPDATE, self.curPetListIdx)
end

function PetInfoLayer:refreshPetName()
    self.petNameTxt:setText(self.curPet:getNickName())
end



function PetInfoLayer:bindModel()

end

function PetInfoLayer:unbindModel()

end

-- 根据装备类型获取装备图标
local function getEquipmentIconByType(self, equipmentType)
    if (self.wearEquipmentIconArr) then
        return self.wearEquipmentIconArr[equipmentType]
    end
    return nil
end

-- 根据装备类型获取装备图标
local function getEquipmentIconByData(self, equipmentData)
    for k,equipmentIcon in ipairs(self.wearEquipmentIconArr) do
        if (equipmentIcon:getEquipmentData() == equipmentData) then
            return equipmentIcon
        end
    end
    return nil
end

-- 选中装备图标
local function selectEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 记录选中的装备图标
        self._selectedIcon = equipmentIcon
        -- 显示选中装备图标的动画
        local posX, posY = equipmentIcon:getPos()
        self._equipmentIconSelectedAnimation:setAnimation(ANIMATION_SELECT_NAME_1)
        self._equipmentIconSelectedAnimation:addAnimation(ANIMATION_SELECT_NAME_2)
        self._equipmentIconSelectedAnimation:setPos(posX, posY)
        self._equipmentIconSelectedAnimation:show()
    else
        assert(false)
    end
end

-- 取消选中装备图标
local function unselectEquipmentIcon(self)
    if (self._selectedIcon) then
        -- 清理选中装备图标的记录
        self._selectedIcon = nil
        -- 隐藏选中的动画
        self._equipmentIconSelectedAnimation:hide()
    else
        assert(false)
    end
end

-- 穿戴装备的时候，显示格子被激活
local function activeEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 继续被激活的装备图标
        self._activeIcon = equipmentIcon
        -- 显示被激活的动画
        local posX, posY = self._activeIcon:getPos()
        
        self._equipmentIconActiveAnimation:play("wear_pos_notice")
        self._equipmentIconActiveAnimation:setVisible(true)
        self._equipmentIconActiveAnimation:setPos(posX, posY)
        --print("activeEquipmentIcon ", self.contentLayout:getScale(), self._equipmentIconActiveAnimation:getScale(), posX, posY)
    else
        assert(false)
    end
end

-- 格子激活被取消
local function deactiveEquipmentIcon(self)
    if (self._activeIcon) then
        -- 清理激活装备的记录
        self._activeIcon = nil
        -- 隐藏激活的动画
        self._equipmentIconActiveAnimation:hide()
    else
        -- assert(false)
    end
end

-- 显示装备图标
local function showEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 隐藏装备格子
        equipmentIcon:showEquipmentGrid()
        -- 如果隐藏的图标是激活的图标，隐藏动画
        if (self._activeIcon == equipmentIcon) then
            self._equipmentIconActiveAnimation:show()
        end
        -- 如果隐藏的图标是选中的图标，隐藏动画
        if (self._selectedIcon == equipmentIcon) then
            self._equipmentIconSelectedAnimation:show()
        end
    else
        assert(false)
    end
end

-- 隐藏装备图标
local function hideEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 隐藏装备格子
        equipmentIcon:hideEquipmentGrid()
        -- 如果隐藏的图标是激活的图标，隐藏动画
        if (self._activeIcon == equipmentIcon) then
            self._equipmentIconActiveAnimation:hide()
        end
        -- 如果隐藏的图标是选中的图标，隐藏动画
        if (self._selectedIcon == equipmentIcon) then
            self._equipmentIconSelectedAnimation:hide()
        end
    else
        assert(false)
    end
end

-- 将装备显示在装备图标上
local function addEquipmentToIcon(self, equipmentIcon, equipmentData)
    if (equipmentIcon and equipmentData) then
        equipmentData:setUseNum(0)
        equipmentIcon:hideEquipmentGrid()
        equipmentIcon:updateView(equipmentData)
    else
        assert(false)
    end
end

-- 显示被激活的图标效果
function PetInfoLayer:activeEquipment(goodsData, touchPosition)
    if (goodsData) then
        -- 检查是否可以穿戴
        if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            local equipmentType = goodsData:getEquipmentType()
            local equipmentIcon = getEquipmentIconByType(self, equipmentType)
            if (equipmentIcon) then activeEquipmentIcon(self, equipmentIcon)
            else assert(false)
            end
        end
    else
        assert(false)
    end
end

-- 恢复被激活的图标
function PetInfoLayer:deactiveEquipment()
    deactiveEquipmentIcon(self)
end

function PetInfoLayer:petDataRefresh()
    self:updatePowerShow()
end

function PetInfoLayer:wearEquipmentResult(data)
    -- 请求穿戴装备结果
    self:refreshPetWearEquipments()
    self:updatePowerShow()
end

-- 添加装备图标
function PetInfoLayer:addEquipment(equipmentData)
    -- 是否穿戴上装备
    local isTakeOn = false
    if (equipmentData) then
        --print("PetInfoLayer:addEquipment 1")
        if (self._activeIcon) then
            --print("PetInfoLayer:addEquipment 2")
            local position = self._activeIcon:getIndex()
            if (position ~= 0) then
                if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
                    -- 发送穿戴请求
                    local petLv = 0
                    local petEntityID = 0
                    if(self.curPet)then
                        petLv = self.curPet:getStarLv()
                        petEntityID = self.curPet:getId()
                    end

                    local isAvailable = equipmentData:isAvailable(petLv)
                    if isAvailable then
                        -- 处理穿戴逻辑
                        Net.NetPetSystem:wearPetEquipmentRequest(petEntityID, equipmentData:getEntityID(), true)
                        -- 添加装备到图标上
                        addEquipmentToIcon(self, self._activeIcon, equipmentData)
                        isTakeOn = true
                    end
                end 
            else
                assert(false)
            end
        end
    else
        assert(false)
    end
    return isTakeOn
end

-- 移除装备图标
function PetInfoLayer:removeEquipment(equipmentData)
    -- print("PetInfoLayer:removeEquipment")
    -- 是否脱下装备
    local isTakeOff = false
    if (equipmentData) then
        --print("PetInfoLayer:removeEquipment 1")
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then
            --print("PetInfoLayer:removeEquipment 2")
            local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
            if(freePacketNum > 0) then
                --print("PetInfoLayer:removeEquipment 3")
                if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
                    --print("PetInfoLayer:removeEquipment 4")
                    local petEntityID = getEntityID
                    if(self.curPet)then
                        petEntityID = self.curPet:getId()
                    end
                    -- 发送脱下装备的请求
                    Net.NetPetSystem:wearPetEquipmentRequest(petEntityID, equipmentData:getEntityID(), false)
                    -- 从装备图标上移除装备视图
                    -- equipmentIcon:clear()
                    equipmentIcon:setData(nil)
                    equipmentIcon:updateView()
                    equipmentData:setUseNum(1)

                    isTakeOff = true
                end 
            else 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))
            end
        else
            assert(false)
        end
    else
        assert(false)
    end
    return isTakeOff
end

-- 显示武器图标
function PetInfoLayer:showEquipment(equipmentData)
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then showEquipmentIcon(self, equipmentIcon)
        else assert(false)
        end
    else
        assert(false)
    end
end

-- 隐藏武器图标
function PetInfoLayer:hideEquipment(equipmentData)
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then hideEquipmentIcon(self, equipmentIcon)
        else assert(false)
        end
    else
        assert(false)
    end
end

-- 隐藏选中效果
function PetInfoLayer:unselectEquipment()
    unselectEquipmentIcon(self)
end

-- 根据装备类型获取当前穿戴的装备数据列表
function PetInfoLayer:getEquipmentData(equipmentType)
    assert(type(equipmentType) == "number", "RoleShowArea getEquipmentData: equipment type is invalid.")

    local equipmentDataList = {}
    local equipmentIcon = getEquipmentIconByType(self, equipmentType)
    if (equipmentIcon) then
        local equipmentData = equipmentIcon:getEquipmentData()
        if (equipmentData) then table.insert(equipmentDataList, equipmentData)
        end
    end
    return equipmentDataList
end

-- 显示宠物皮肤
function PetInfoLayer:addPetSkinList()
    self.skinListView = UI.TableView.new({}, 390, 180)
    self.skinListView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    -- self.skinListView:leftUp(20, 40)
    self.skinListView:centerBottom(15)
    self.skinListView:setDelegate()
    -- self.skinListView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.skinListView:setBounceable(true)
    self.skinListView:init()
    self.skinListView:onUpdateCellSize(function (table,idx)
        return SKIN_CELL_WIDTH, SKIN_CELL_HEIGHT
    end)
    -- self.skinListView:enableDebugDraw()

    self.skinListView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createSkinCell(self.templateConfig.skinId[index], self.curPet)
            end,
            function(e)
                printError("------------------------VoidRiftLevelSelectView:tableCellAtIndex-----------------error")
            end, 1)
        else
            if cell and not tolua.isnull(cell) then
                cell:removeFromParent(true)
                cell = nil
            end
            cell = self:createSkinCell(self.templateConfig.skinId[index], self.curPet)
        end

        return cell
    end)

    self.skinListView:onUpdateCellNumbers(function ()
        local len = table.nums(self.templateConfig.skinId) >= 2 and table.nums(self.templateConfig.skinId) or 2
        return len
    end)

    self.skinListView:onTableCellTouched(function(table, cell)
        -- local index = cell:getIdx() + 1
        -- local buffCell = cell:getChildByName("buffCell")
        -- if buffCell then
        --     buffCell:showInfo()
        -- end
    end)

    self.contentLayout:addChild(self.skinListView, 1000)
    self.skinListView:reloadData(true)

    -- self.skinListView:hide()
    self:onPetListShow()
end

function PetInfoLayer:createSkinCell(skinID, petData)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(SKIN_CELL_WIDTH, SKIN_CELL_HEIGHT))
    local skinCell = mvc.petSkinCellView:create(skinID, petData)
    skinCell:init()
    skinCell:center()
    cell:addChild(skinCell)

    return cell
end

-- 显示宠物列表
function PetInfoLayer:onPetListShow()
    self.isPetListShow = true
    -- self.petSkinDesBtn:setBtnStatus(ButtonState.ACTIVE)
    -- if self.petSkinBtn then
    --     self.petSkinBtn:setBtnStatus(ButtonState.NORMAL)
    -- end
    if self.petList then
        self.petList:show()
    end
    if self.skinListView then
        self.skinListView:hide()
    end
end

-- 显示宠物皮肤
function PetInfoLayer:onPetSkinShow(btn)
    self.isPetListShow = false
    btn:setBtnStatus(ButtonState.ACTIVE)
    -- if self.petSkinDesBtn then
    --     self.petSkinDesBtn:setBtnStatus(ButtonState.NORMAL)
    -- end
    if self.petList then
        self.petList:hide()
    end
    if self.skinListView then
        self.skinListView:reloadData(true)
        self.skinListView:show()
    end
end

function PetInfoLayer:changeSkinOver()
    self.curPet = MasterDataManager:getBagPetById(self.curPet.spriteID)
    self:updatePetAnimation()
    self:updatePowerShow()
    self:resetPetList()
    
    if self.petSkinBtn then
        self.petSkinBtn:setVisible(self.templateConfig.skinId and table.nums(self.templateConfig.skinId) > 0)
    end
    if self.petSkinDesBtn then
        self.petSkinDesBtn:setVisible(self.curPet.skinId and self.curPet.skinId > 0)
    end
end


function PetInfoLayer:showDesLayer(isClose, skinId)
    local logLayer = self:getChildByName("logLayer")
    if logLayer and not tolua.isnull(logLayer) and isClose then
        logLayer:close()
        return
    end
    local skinConfig = ConfigManager:getPetSkinByID(skinId)
    local specialTxt = languageManagerInstance:getLocalString(skinConfig.attributeDes)
    local data = {
        tips = specialTxt,
    }
    local logLayer = mvc.petSkinAttrDesView:create(data)
    logLayer:init()
    logLayer:leftBottom(-140, 100)
    logLayer:setName("logLayer")
    self:addChild(logLayer, 100)
end

return PetInfoLayer