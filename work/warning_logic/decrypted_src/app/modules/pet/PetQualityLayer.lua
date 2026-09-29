------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 宠物资质属性公用面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetQualityLayer = class("PetQualityLayer", UI.BaseWin)

UI = UI or {}

UI.PetQualityLayer = PetQualityLayer

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
}

local COM_WIDTH = 400
local COM_HEIGHT = 172

function PetQualityLayer:ctor()
    PetQualityLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)
end

-- isOther用来判断是否是别人的宠物
-- 如果为true 第一个参数传的是别人的宠物数据，如果为false 第一个参数传的是自己的宠物ID
function PetQualityLayer:init(petID, isOther, tipRevert, colors, ... )
    self.colors = {}
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        self.curPet = MasterDataManager:getBagPetById(petID)
    end
    self.tipRevert = tipRevert
    self.colors.name = (colors and colors.name) and colors.name or UI.FONT_COLOR_41_41_45
    self.colors.prg = (colors and colors.prg) and colors.prg or UI.FONT_COLOR_209_209_209
    self.colors.expPlus = (colors and colors.expPlus) and colors.expPlus or UI.FONT_COLOR_255_186_65

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetQualityLayer.super.init(self, ... )
end

function PetQualityLayer:dtor()
    PetQualityLayer.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)

    reload_script_file_mvc("app.modules.pet.PetQualityLayer")
end

function PetQualityLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:leftUp(-18, 0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:updateLayer()
end

function PetQualityLayer:updateToShow(petID, isOther, tipRevert, colors, ... )
    self.colors = {}
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        self.curPet = MasterDataManager:getBagPetById(petID)
    end
    self.tipRevert = tipRevert
    self.colors.name = (colors and colors.name) and colors.name or UI.FONT_COLOR_41_41_45
    self.colors.prg = (colors and colors.prg) and colors.prg or UI.FONT_COLOR_209_209_209
    self.colors.expPlus = (colors and colors.expPlus) and colors.expPlus or UI.FONT_COLOR_255_186_65

    self:updateLayer()
end

function PetQualityLayer:updateLayer(petListIdx)
    if petListIdx and petListIdx > 0 then
        self.curPet = MasterDataManager:getBagPets()[petListIdx]
    end

    self.contentLayout:removeAllChildren()

    self:assembleQuality()

    for k, v in ipairs(self.qualityData) do
        local oneAttr = self:composeQualityLayer(v)
        self.contentLayout:addChild(oneAttr)
    end
end

function PetQualityLayer:assembleQuality()
    self.qualityData = {}

    local names = {UI.TEXT_1213633, UI.TEXT_1213634, UI.TEXT_1213635, UI.TEXT_1213636, UI.TEXT_1213637, UI.TEXT_1213638, UI.TEXT_1213639}
    local icons = {
        "ui_icon_talent_1.png", "ui_icon_talent_3.png", "ui_icon_talent_2.png", "ui_icon_talent_4.png",
        "ui_icon_talent_5.png", "ui_icon_talent_6.png", "ui_icon_talent_0.png",
    }
    local xArr = {0, 200, 0, 200, 0, 200, 0}
    local yArr = {4, 4, 46, 46, 88, 88, 130}
    local prgs = {}
    local prgTxts = {}
    local plus = {}

    local cfg = mvc.petModel:getTalentConfig(self.curPet.templateID, self.curPet.isVariant)
    local valMax = {}
    table.insert(valMax, cfg.talent_atk[2])
    table.insert(valMax, cfg.talent_physicDef[2])
    table.insert(valMax, cfg.talent_magicAtk[2])
    table.insert(valMax, cfg.talent_magicDef[2])
    table.insert(valMax, cfg.talent_element[2])
    table.insert(valMax, cfg.talent_elementDef[2])
    table.insert(valMax, cfg.talent_hp[2])

    local curVal = {}
    local type = PublicDefine.PetTalentType
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TElement))
    table.insert(curVal, self.curPet:getTalentByType(type.TResist))
    table.insert(curVal, self.curPet:getTalentByType(type.TLife))

    local plusVal = {}
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TElement))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TResist))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TLife))

    local plusLen = {}
    for k, v in ipairs(plusVal) do
        table.insert(plusLen, v/valMax[k]*116)
    end

    for k, v in ipairs(valMax) do
        table.insert(prgs, curVal[k]/v)
        table.insert(prgTxts, string.format("%d/%d", curVal[k], v))
        table.insert(plus, plusVal[k])
    end

    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    local starLv, canLvUpNum = self.curPet:getStarLv()
    local growID, initID
    if self.curPet.isVariant then
        growID = petCfg.growID[2]
        initID = petCfg.initID[2]
    else
        growID = petCfg.growID[1]
        initID = petCfg.initID[1]
    end
    local growCfg = ConfigManager:getPetGrowAttrByID(growID)
    local attrCfg = ConfigManager:getPetInitAttrByID(initID)
    local growList = {}
    local attrList = {}

    -- 资质系数
    printInfo("pet talentParam : "..table.nums(growCfg))
    local totalTalentParam = 0
    for index = 0, table.nums(growCfg) do
        if growCfg["talentParam_"..index] then
            totalTalentParam = totalTalentParam < index and index or totalTalentParam
            table.insert(growList, growCfg["talentParam_"..index])
        end
    end

    -- table.insert(growList, growCfg.talentParam_0)
    -- table.insert(growList, growCfg.talentParam_1)
    -- table.insert(growList, growCfg.talentParam_2)
    -- table.insert(growList, growCfg.talentParam_3)
    -- table.insert(growList, growCfg.talentParam_4)
    -- table.insert(growList, growCfg.talentParam_5)
    -- table.insert(growList, growCfg.talentParam_6)
    -- table.insert(growList, growCfg.talentParam_7)
    -- table.insert(growList, growCfg.talentParam_8)
    -- table.insert(growList, growCfg.talentParam_9)
    -- table.insert(growList, growCfg.talentParam_10)

    table.insert(attrList, attrCfg.init_atk[2])
    table.insert(attrList, attrCfg.init_physicDef[2])
    table.insert(attrList, attrCfg.init_magicAtk[2])
    table.insert(attrList, attrCfg.init_magicDef[2])
    table.insert(attrList, attrCfg.init_atkFire[2])
    table.insert(attrList, attrCfg.init_defFire[2])
    table.insert(attrList, attrCfg.init_hp[2])

    local grow = growList[starLv + 1]
    local grows = {}

    table.insert(grows, grow[2])
    table.insert(grows, grow[4])
    table.insert(grows, grow[3])
    table.insert(grows, grow[5])
    table.insert(grows, grow[6])
    table.insert(grows, grow[7])
    table.insert(grows, grow[1])

    for k, v in ipairs(names) do
        local oneAttr = {}
        oneAttr.idx = k
        oneAttr.name = v
        oneAttr.icon = icons[k]
        oneAttr.x = xArr[k]
        oneAttr.y = yArr[k]
        oneAttr.prg = prgs[k]
        oneAttr.prgTxt = prgTxts[k]
        oneAttr.plus = plus[k]
        oneAttr.plusLen = plusLen[k]
        oneAttr.curVal = curVal[k]
        oneAttr.grow = grows[k]
        oneAttr.attrConst = attrList[k]

        table.insert(self.qualityData, oneAttr)
    end
end

function PetQualityLayer:composeQualityLayer(data)
    local powerNum = math.floor((data.curVal + data.plus) * data.grow / 1000 + data.attrConst)
    local tipTxtList = {
        UI.TEXT_1213719, UI.TEXT_1213720, UI.TEXT_1213721, UI.TEXT_1213722,
        UI.TEXT_1213723, UI.TEXT_1213724, UI.TEXT_1213725,
    }

    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(160, 40)
    innerLayer:leftUp(data.x, data.y)
    innerLayer:setTouchEnable(true)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        local pos = innerLayer:convertToNodeSpace(touchPosition)
        local size = innerLayer:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local tipTxt = string.format(data.name..":"..tipTxtList[data.idx], powerNum)
        if cc.rectContainsPoint(rect, pos) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, self.tipRevert, tipTxt)
        end
    end)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)

    local iconImg = UI.Image:create()
    iconImg:init(data.icon)
    iconImg:centerLeft(0)
    innerLayer:addChild(iconImg)

    local prg = UI.ProgressTimer:create()
    prg:init("ui_pets_quality_progressbar_0.png", nil, "ui_pets_quality_progressbar_1.png")
    prg:centerLeft(32)
    prg:setPercent(data.prg)
    prg:setName("prg")
    innerLayer:addChild(prg)

    local prgText = UI.Text:create()
    prgText:init(data.prgTxt, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, self.colors.prg)
    prgText:center()
    prgText:setName("prgText")
    prg:addChild(prgText, 10)

    local prgTextShadow = UI.Text:create()
    prgTextShadow:init(data.prgTxt, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
    prgTextShadow:centerUp(1)
    prg:addChild(prgTextShadow, 9)

    if data.plus > 0 then
        local plusLayer = UI.Layout:create();
        plusLayer:init()
        plusLayer:leftBottom(prg:getContentSize().width + 35, 10)
        plusLayer:setSize(120, 20)
        innerLayer:addChild(plusLayer)

        local expPlusW = data.plusLen
        local expPlus = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_quality_progressbar_2.png")
        expPlus:setContentSize(expPlusW, 17)
        expPlus:setCapInsets(CCRectMake(0.5,8,0.1,0.1))
        expPlus:setPosition(expPlusW/2-4, 10)
        plusLayer:addChild(expPlus)

        local expPlusTxtShadow = UI.Text:create()
        expPlusTxtShadow:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
        expPlusTxtShadow:leftBottom(expPlusW-2, 1)
        plusLayer:addChild(expPlusTxtShadow)

        local expPlusTxt = UI.Text:create()
        expPlusTxt:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, self.colors.expPlus)
        expPlusTxt:leftBottom(expPlusW-2, 2)
        expPlusTxt:setName("expPlusTxt")
        plusLayer:addChild(expPlusTxt)
    end

    return innerLayer
end

function PetQualityLayer:bindModel()

end

function PetQualityLayer:unbindModel()

end

return PetQualityLayer
