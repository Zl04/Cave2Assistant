------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetComposeView = class("PetComposeView", UI.BaseWin)

require "app.modules.pet.PetMainListCell"

UI = UI or {}

UI.PetComposeView = PetComposeView

-- 资源
local COM_RES_LIST = {
    "ui_town_gem.plist"
}

local materialBGPos = {
    {{155, 20}},
    {{115, 20}, {202, 20}},
    {{70, 20}, {155, 20}, {242, 20}},
    {{32, 20}, {115, 20}, {200, 20}, {290, 20}},
}

local materialSlotPos = {
    {{174, 301}},
    {{134, 301}, {221, 301}},
    {{89, 301}, {175, 301}, {261, 301}},
    {{51, 301}, {135, 301}, {219, 301}, {310, 301}},
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetComposeView:ctor()
    PetComposeView.super.ctor(
    	self,
    	UI.Type.PET_COMPOSE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_COMPOSE_OK, self, self.composeOver)
end

function PetComposeView:init(... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetComposeView.super.init(self, ... )
end

function PetComposeView:dtor()
    self.netBlocking = false

    PetComposeView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_COMPOSE_OK, self, self.composeOver)

    reload_script_file_mvc("app.modules.pet.PetComposeView")
end

function PetComposeView:composeOver(petId, materialIDs)
    self.netBlocking = false

    -- 炼化会销毁宠物，这里强制重置一下列表
    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SELECT_CELL_UPDATE, mvc.petModel:getFightPetIdx())

    self:playEff()

    self.materialCount = 0
end

function PetComposeView:onInitView()
    self.targetPetData = nil
    self.starEff = {}
    self.materialCount = 0
    self.materialTotalNum = 0
    self.playingEff = false

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, -10)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create();
    bg:init("ui_pets_merge_rightpage.png");
    bg:centerUp(20);
    self.contentLayout:addChild(bg);

    local bgEff = UI.Animation:create()
    bgEff:init("effect_ui_town_pet_target_bg.json", "effect_ui_town_pet_target_bg.atlas", 1);
    bgEff:leftUp(215, 168)
    self.contentLayout:addChild(bgEff)
    self.targetBGEff = bgEff

    local petNameTxt = UI.Text:create()
    petNameTxt:init(UI.TEXT_1213621, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    petNameTxt:setWidth(300)
    petNameTxt:setTextCenter()
    petNameTxt:autoAdapt()
    petNameTxt:leftUp(58, 22)
    self.contentLayout:addChild(petNameTxt)
    self.petNameTxt = petNameTxt

    local centerImg1  = UI.Image:create();
    centerImg1:init("ui_pets_round.png");
    centerImg1:centerUp(111);
    self.contentLayout:addChild(centerImg1, 10);

    -- 拖拽判定框
    local targetCheckLayer = UI.Layout:create();
    targetCheckLayer:init()
    targetCheckLayer:setSize(116, 116)
    targetCheckLayer:center()
    centerImg1:addChild(targetCheckLayer)
    self.targetCheckLayer = targetCheckLayer

    local centerImg2  = UI.Image:create();
    centerImg2:init("ui_gem_box_colorful.png");
    centerImg2:center();
    centerImg1:addChild(centerImg2);

    local centerImg3  = UI.Image:create();
    centerImg3:init("ui_pets_merge_box.png");
    centerImg3:center();
    centerImg1:addChild(centerImg3);
    self.centerImg = centerImg3

    local slotEff = UI.Animation:create()
    slotEff:init("effect_ui_town_pet_target_slot.json", "effect_ui_town_pet_target_slot.atlas", 1);
    slotEff:center()
    centerImg1:addChild(slotEff, 100)
    self.targetSlotEff = slotEff

    -- 材料拖拽判定框
    local materialLayout = UI.Layout:create();
    materialLayout:init()
    materialLayout:setSize(386, 108)
    materialLayout:centerBottom(110)
    self.contentLayout:addChild(materialLayout)
    self.materialCheckLayer = materialLayout

    -- 合成按钮
    local useBtn = UI.Button:create();
    useBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png");
    useBtn:centerBottom(60);
    useBtn:setText(UI.TEXT_1213622)
    useBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.playingEff then
            return
        end

        if not self.targetPet then
            UI.ScrollBar:createByText(UI.TEXT_1213623)
            return
        end

        if self.materialTotalNum == 0 then
            UI.ScrollBar:createByText(UI.TEXT_1213624)
            return
        end

        if self.materialCount == 0 or self.materialCount < self.materialTotalNum then
            UI.ScrollBar:createByText(UI.TEXT_1213625)
            return
        end

        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1213626,
            function()
                self:recordAttrComposeBefore()

                local petIDs = {}
                for i = 1, 4 do
                    local slot = self.contentLayout:getChildByName("MaterialSlot"..i)
                    if slot then
                        table.insert(petIDs, slot:getData().petID)
                    end
                end

                self:netLock()

                Net.NetPetSystem:compose(self.targetPetData:getId(), petIDs)
            end
        )
    end)
    self.contentLayout:addChild(useBtn)
end

function PetComposeView:netLock()
    self.netBlocking = true

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end
    
        self.netBlocking = false
    end, 5)
end

function PetComposeView:recordAttrComposeBefore()
    local attr = {}
    local petData = self.targetPetData
    attr.hp = petData:getAttrByName("hp")
    attr.atkMax = petData:getAttrByName("atkMax")
    attr.physicDef = petData:getAttrByName("physicDef")
    attr.atkFire = petData:getAttrByName("atkFire")
    attr.atkWater = petData:getAttrByName("atkWater")
    attr.atkWood = petData:getAttrByName("atkWood")
    attr.atkLight = petData:getAttrByName("atkLight")
    attr.atkDark = petData:getAttrByName("atkDark")
    attr.atkSpd = petData:getAttrByName("atkSpd")
    attr.magic = petData:getAttrByName("magic")
    attr.magicDef = petData:getAttrByName("magicDef")
    attr.defFire = petData:getAttrByName("defFire")
    attr.defWater = petData:getAttrByName("defWater")
    attr.defWood = petData:getAttrByName("defWood")
    attr.defLight = petData:getAttrByName("defLight")
    attr.defDark = petData:getAttrByName("defDark")

    self.attrComposeBefore = attr
end

function PetComposeView:updateTypeIcon()
    local icon = self.contentLayout:getChildByName("TypeIcon")
    if icon then
        if self.targetPetData.isVariant then
            icon:setSpriteName("ui_pets_variation.png");
        else
            icon:setSpriteName("ui_pets_ordinary.png");
        end
    else
        local typeIcon  = UI.Image:create();
        if self.targetPetData.isVariant then
            typeIcon:init("ui_pets_variation.png");
        else
            typeIcon:init("ui_pets_ordinary.png");
        end
        typeIcon:leftUp(30, 10);
        typeIcon:setName("TypeIcon")
        self.contentLayout:addChild(typeIcon)
    end
end

function PetComposeView:updateStarShow()
    local starLayout = self.contentLayout:getChildByName("StarLayout")
    if starLayout then
        self.contentLayout:removeChildByName("StarLayout")
    end

    -- 星级
    --local starLv, canLvUpNum = self.targetPetData:getStarLv()
    --printInfo("starLv = " .. starLv .. " canLvUpNum = " .. canLvUpNum)
    local str1 = "symbol_character_hero_power.png"
    local str2 = "symbol_character_hero_power_0.png"
    local disStar = -2
    local disCan = -2
    local starLv, canLvUpNum = self.targetPetData:getStarLv()
    local nowReincarntionLv = self.targetPetData:getReincarntionLv()
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
        starLayout:leftUp(100, 52)
        starLayout:setName("StarLayout")
        self.contentLayout:addChild(starLayout, 2)

        local starAutoLayer = UI.Layout:create();
        starAutoLayer:init()
        starAutoLayer:center()
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
        -- starAutoLayer:enableDebugDraw()
        starLayout:addChild(starAutoLayer, 20)

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

            local starEff = UI.Animation:create()
            starEff:init("effect_ui_town_pet_star.json", "effect_ui_town_pet_star.atlas", 1);
            starEff:center()
            starEff:setName("StarEff")
            starEff:hide()
            starImg:addChild(starEff, 10)

            if i == 1 then
                self.lvupStarImg = starImg
            end
        end
    end
end

function PetComposeView:playSlotEff()
    local slot = self.contentLayout:getChildByName("MaterialSlot"..self.effIdx)
    local slotEff = slot:getChildByName("SlotEff")
    slotEff:setAnimation("trigger", false)

    if self.effIdx >= self.effCount then
        return
    end

    self.effIdx = self.effIdx + 1

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        self:playSlotEff()
    end, 0.2)
end

function PetComposeView:playEff()
    self.playingEff = true
    self.effCount = self.materialTotalNum
    self.effIdx = 1

    self:playSlotEff()

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        self.targetBGEff:setAnimation("trigger", false)
        self.targetSlotEff:setAnimation("trigger", false)
    end, self.effCount*0.2)

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        local eff = self.lvupStarImg:getChildByName("StarEff")
        eff:show()
        eff:setAnimation("trigger", false)
        eff:addEventListener(UIEvent.ANIMATION_END,self,function()
            if not self or tolua.isnull(self) then
                return
            end

            self.playingEff = false

            mvc.openPanel("Pet", "PetResultShow", {showType = 2, eggType = 1, id = self.targetPetData:getId(), change=self.attrComposeBefore})

            self.lvupStarImg:setSpriteName("symbol_character_hero_power.png")

            self.petNameTxt:setText(UI.TEXT_1213621)
            self.contentLayout:removeChildByName("TypeIcon")
            performWithDelay(self, function()
                if not self or tolua.isnull(self) then
                    return
                end

                self.contentLayout:removeChildByName("StarLayout")
                self.contentLayout:removeChildByName("TargetSlot")
                self.materialCheckLayer:removeAllChildren()

                self:clearAllMeterialSlots()

                Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST)
            end, 0)
            
        end)
    end, self.effCount*0.2+0.5)
end

function PetComposeView:clearAllMeterialSlots()
    for i = 1, 4 do
        local slot = self.contentLayout:getChildByName("MaterialSlot"..i)
        if slot then
            self.contentLayout:removeChildByName("MaterialSlot"..i)
        end
    end

    self.materialCount = 0
end

function PetComposeView:updateMaterialSlotShow()
    self.materialCheckLayer:removeAllChildren()

    if self.materialTotalNum == 0 then
        local tipTxt = UI.Text:create()
        tipTxt:init(UI.TEXT_1213627, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        tipTxt:setWidth(300)
        tipTxt:setTextCenter()
        tipTxt:autoAdapt()
        tipTxt:center()
        self.materialCheckLayer:addChild(tipTxt)

        return
    end

    local offset = 15
    for i = 1, self.materialTotalNum do
        local bg = UI.Image:create()
        bg:init("box_quality_box_01.png")
        local x = materialBGPos[self.materialTotalNum][i][1]
        local y = materialBGPos[self.materialTotalNum][i][2]
        bg:leftUp(x, y)
        self.materialCheckLayer:addChild(bg)
    end
end

function PetComposeView:slotDragEnd(petID, x, y)
    if self.playingEff then
        return
    end

    if not self:isVisible() then
        return
    end

    local petData = MasterDataManager:getBagPetById(petID)
    if(petData) then 
        local arr = petData:getWearEquipmentArr()
        if(arr and #arr > 0) then
            UI.ScrollBar:createByText(UI.TEXT_1325910)
            return 
        end
    end
    local fpet = MasterDataManager:getFightPetbyId(petID)
    if fpet then
        UI.ScrollBar:createByText(UI.TEXT_221010)
        return 
    end

    -- if MasterDataManager:isAllowPetChange(petID) then
    --     UI.ScrollBar:createByText(UI.TEXT_226180)
    --     return
    -- end

    local fpets = mvc.petTreasureModel:getPetAdvEmbattlePets()
    for k, fpet in pairs(fpets) do
        if fpet.getSpriteID and fpet:getSpriteID() == petID then
            UI.ScrollBar:createByText(UI.TEXT_221111)
            return 
        end
    end 

    if mvc.dockModel:checkPetIsSailing(petID) then
        UI.ScrollBar:createByText(UI.TEXT_221932)
        return
    end
    

    -- target check
    local pos = self.targetCheckLayer:convertToNodeSpace(cc.p(x, y))
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        self:clearAllMeterialSlots()

        self:addTargetPet(petID)

        self.petNameTxt:setText(self.targetPetData:getNickName())
        self:updateTypeIcon()
        self:updateStarShow()
        self:updateMaterialSlotShow()

        performWithDelay(self, function()
            if not self or tolua.isnull(self) then
                return
            end

            local pet = MasterDataManager:getBagPetById(petID)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST, pet.templateID, {petID})
        end, 0)
    end

    -- material check
    local pos = self.materialCheckLayer:convertToNodeSpace(cc.p(x, y))
    local size = self.materialCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        if self.materialCount >= self.materialTotalNum then
            return
        end

        if MasterDataManager:isAllowPetChange(petID) then
            UI.ScrollBar:createByText(UI.TEXT_226180)
            return
        end

        local petData = MasterDataManager:getBagPetById(petID)
        if petData:isFight() then
            UI.ScrollBar:createByText(UI.TEXT_1213628)
            return
        end

        if not self:addMaterialPet(petID) then
            return
        end

        self.materialCount = self.materialCount + 1

        performWithDelay(self, function()
            if not self or tolua.isnull(self) then
                return
            end

            local petIDs = {}
            for i = 1, 4 do
                local slot = self.contentLayout:getChildByName("MaterialSlot"..i)
                if slot then
                    table.insert(petIDs, slot:getData().petID)
                end
            end
            table.insert(petIDs, self.targetPetData:getId())

            local pet = MasterDataManager:getBagPetById(petID)
            local templateID = pet.templateID
            if tonumber(ConfigManager:getGeneralForKey("PetCommonID")) == pet.templateID then
                templateID = self.targetPetData.templateID
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST, templateID, petIDs)
        end, 0)
    end
end

function PetComposeView:addTargetPet(petID)
    self.targetPetData = MasterDataManager:getBagPetById(petID)
    self.materialTotalNum = 0

    local starLv, canLvUpNum = self.targetPetData:getStarLv()
    if canLvUpNum > 0 then
        local nowReincarntionLv = self.targetPetData:getReincarntionLv()
        local configDatas = ConfigManager:getAllPetReincarnationDataByID(nowReincarntionLv)
        local conditions = string.split(configDatas.combineLimit, ";")
        local con = string.split(conditions[starLv+1], ",")
        self.materialTotalNum = tonumber(con[2])

        -- local conditions = string.split(self.targetPetData.combineLimit, ";")
        -- local con = string.split(conditions[starLv+1], ",")
        -- self.materialTotalNum = tonumber(con[2])
    end

    local targetSlot = self.contentLayout:getChildByName("TargetSlot")
    if targetSlot then
        self.contentLayout:removeChildByName("TargetSlot")
    end

    local targetPet = UI.PetMainListCell:create()
    targetPet:init(petID)
    targetPet:leftUp(177, 131)
    targetPet:setName("TargetSlot")
    self.contentLayout:addChild(targetPet, 100)
    self.targetPet = targetPet

    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onTargetPetTouchMove)
    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTargetPetTouchEnd)
end

function PetComposeView:onTargetPetTouchMove(com, touchPosition)
    if self.playingEff then
        return
    end

    com:setZOrder(101)

    local pos = self.contentLayout:convertToNodeSpace(touchPosition)
    local size = com:getContentSize()
    local x = pos.x - size.width/2
    local y = pos.y - size.height/2
    com:setPosition(cc.p(x, y))
end

function PetComposeView:onTargetPetTouchEnd(com, touchPosition)
    com:setZOrder(100)

    local pos = self.targetCheckLayer:convertToNodeSpace(touchPosition)
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        com:leftUp(177, 131)
    else
        performWithDelay(self, function()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST)
        end, 0)

        self.contentLayout:removeChildByName("TargetSlot")
        self.targetPet = nil

        self.petNameTxt:setText(UI.TEXT_1213621)
        self.contentLayout:removeChildByName("StarLayout")
        self.contentLayout:removeChildByName("TypeIcon")
        self.materialCheckLayer:removeAllChildren()

        self:clearAllMeterialSlots()

        self.materialTotalNum = 0
    end
end

function PetComposeView:addMaterialPet(petID)
    local slotIdx = 0
    for i = 1, self.materialTotalNum do
        local mSlot = self.contentLayout:getChildByName("MaterialSlot"..i)
        if not mSlot then
            slotIdx = i
            break
        end
    end
    if slotIdx == 0 then
        return false
    end

    if MasterDataManager:isAllowPetChange(petID) then
        UI.ScrollBar:createByText(UI.TEXT_226180)
        return false
    end

    local materialSlot = self.contentLayout:getChildByName("MaterialSlot"..slotIdx)
    if materialSlot then
        self.contentLayout:removeChildByName("MaterialSlot"..slotIdx)
    end

    local materialSlot = UI.PetMainListCell:create()
    materialSlot.slotIdx = slotIdx
    materialSlot:init(petID)
    local x = materialSlotPos[self.materialTotalNum][slotIdx][1]
    local y = materialSlotPos[self.materialTotalNum][slotIdx][2]
    materialSlot:leftUp(x, y)
    materialSlot:setName("MaterialSlot"..slotIdx)
    self.contentLayout:addChild(materialSlot, 100)

    local slotEff = UI.Animation:create()
    slotEff:init("effect_ui_town_pet_source_slot.json", "effect_ui_town_pet_source_slot.atlas", 1);
    slotEff:center()
    slotEff:setName("SlotEff")
    materialSlot:addChild(slotEff, 100)

    materialSlot:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onMaterialPetTouchMove)
    materialSlot:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onMaterialPetTouchEnd)

    return true
end

function PetComposeView:onMaterialPetTouchMove(com, touchPosition)
    if self.playingEff then
        return
    end

    com:setZOrder(101)

    local pos = self.contentLayout:convertToNodeSpace(touchPosition)
    local size = com:getContentSize()
    local x = pos.x - size.width/2
    local y = pos.y - size.height/2
    com:setPosition(cc.p(x, y))
end

function PetComposeView:onMaterialPetTouchEnd(com, touchPosition)
    if not self:isVisible() then
        return
    end
    com:setZOrder(100)

    local pos = self.materialCheckLayer:convertToNodeSpace(touchPosition)
    local size = self.materialCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        local x = materialSlotPos[self.materialTotalNum][com.slotIdx][1]
        local y = materialSlotPos[self.materialTotalNum][com.slotIdx][2]
        com:leftUp(x, y)
    else
        local materialSlot = self.contentLayout:getChildByName("MaterialSlot"..com.slotIdx)
        local removePetID = materialSlot:getData().petID

        local petIDs = {}
        for i = 1, 4 do
            local slot = self.contentLayout:getChildByName("MaterialSlot"..i)
            if slot then
                local slotPetID = slot:getData().petID
                if slotPetID ~= removePetID then
                    table.insert(petIDs, slotPetID)
                end
            end
        end
        table.insert(petIDs, self.targetPetData:getId())

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST, self.targetPetData.templateID, petIDs)

        self.contentLayout:removeChildByName("MaterialSlot"..com.slotIdx)

        self.materialCount = math.max(self.materialCount - 1, 0)
    end
end

function PetComposeView:updateToShow()
    self.contentLayout:removeChildByName("TargetSlot")
    self.targetPet = nil

    self.petNameTxt:setText(UI.TEXT_1213621)
    self.contentLayout:removeChildByName("StarLayout")
    self.contentLayout:removeChildByName("TypeIcon")
    self.materialCheckLayer:removeAllChildren()

    self:clearAllMeterialSlots()

    self.materialTotalNum = 0
end

function PetComposeView:bindModel()

end

function PetComposeView:unbindModel()

end

return PetComposeView
