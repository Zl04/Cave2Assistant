------------------------------------------------------------------------------
--author: zhiming.luo
--date  : 2019/11/07
--desc  : 通用展示界面:获得宠物、洗炼宠物、合成宠物
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetResultShowView = class("PetResultShowView", UI.HWBtnComponent)

require "app.modules.pet.PetShareView"

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_scale9image.plist",
    "ui_town_expedition.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local winSize = cc.Director:getInstance():getWinSize()

local RESULT_TYPE = {
    OPEN_EGG = 1,
    COMPOSE_EGG = 2,
    REBORN_EGG = 3,
}

function PetResultShowView:ctor(data)
    PetResultShowView.super.ctor(
        self,
        UI.Type.PET_RESULT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.showType = data.showType
    self.eggType = data.eggType
    self.petID = data.id
    self.changeData = data.change
    self.curPet = MasterDataManager:getBagPetById(data.id)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end

function PetResultShowView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetResultShowView.super.init(self, ... )
end

function PetResultShowView:dtor()
    PetResultShowView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)

    reload_script_file_mvc("app.modules.pet.PetResultShowView")
end

function PetResultShowView:onInitView()
    self.switchIdx = 1

    Avalon.AudioManager:playSound("1559")

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH,COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0,0,0,230));
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() return end)
    self:addChild(maskLayout, 0)

    local lightEff = UI.Animation:create()
    if self.curPet.isVariant then
        lightEff:init("effect_ui_town_pet_show_guang.json", "effect_ui_town_pet_show_guang.atlas", 1);
    else
        lightEff:init("effect_ui_common_settlement.json", "effect_ui_common_settlement.atlas", 1);
    end
    lightEff:centerUp(106)
    lightEff:hide()
    self.contentLayout:addChild(lightEff, 2)
    self.lightEff = lightEff

    local titleEff = UI.Animation:create()
    titleEff:init("effect_ui_town_pet_show_reward.json", "effect_ui_town_pet_show_reward.atlas", 1);
    titleEff:centerUp(106)
    self.contentLayout:addChild(titleEff, 3)
    self.titleEff = titleEff
    self.titleEff:hide()

    local showTitle = ""
    if self.showType == RESULT_TYPE.OPEN_EGG then
        if self.eggType == 3 then
            showTitle = self.curPet.isVariant and UI.TEXT_1213652 or UI.TEXT_1213653
        else
            showTitle = self.curPet.isVariant and UI.TEXT_1213654 or UI.TEXT_1213655
        end
    elseif self.showType == RESULT_TYPE.COMPOSE_EGG then
        showTitle = UI.TEXT_1213656
    elseif self.showType == RESULT_TYPE.REBORN_EGG then
        showTitle = UI.TEXT_1213657
    end

    local titleTxt = UI.Text:create()
    titleTxt:init(showTitle, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_224_115)
    titleTxt:setWidth(400)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:centerUp(-14)
    self.titleEff:addComponent("pet", titleTxt)

    local bgEff = UI.Animation:create()
    if self.curPet.isVariant then
        bgEff:init("effect_ui_town_pet_show_bianyi.json", "effect_ui_town_pet_show_bianyi.atlas", 1);
    else
        bgEff:init("effect_ui_town_pet_show_ordinary.json", "effect_ui_town_pet_show_ordinary.atlas", 1);
    end
    bgEff:centerUp(324)
    self.contentLayout:addChild(bgEff, 4)
    self.bgEff = bgEff

    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(590, 370)
    innerLayer:centerLeft(-302)
    self.bgEff:addComponent("guai", innerLayer)
    self.innerLayer = innerLayer

    self:initInfoLayer()

    local switchIcon  = UI.Image:create();
    switchIcon:init("ui_pets_show_btn_0.png");
    switchIcon:rightBottom(0, 4);
    switchIcon:setTouchEnable(true)
    self.innerLayer:addChild(switchIcon, 10)
    switchIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:switchClick()
    end)
    switchIcon:hide()
    self.switchIcon = switchIcon

    local okBtn = UI.Button:create();
    okBtn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_0.png");
    okBtn:centerBottom(-1000);
    okBtn:closeClickScale()
    okBtn:setText(UI.TEXT_1170211)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.closePanel("Pet", "PetResultShow")
    end)
    -- okBtn:hide()
    self.contentLayout:addChild(okBtn)
    self.okBtn = okBtn

    if self.showType == RESULT_TYPE.OPEN_EGG then
        self:openEggResultView()
    elseif self.showType == RESULT_TYPE.COMPOSE_EGG then
        self:composeResultView()
    elseif self.showType == RESULT_TYPE.REBORN_EGG then
        self:rebornResultView()
    end
end

function PetResultShowView:openEggResultView()
    local openEggEff = UI.Animation:create()
    openEggEff:init("effect_ui_town_pet_show_hatch.json", "effect_ui_town_pet_show_hatch.atlas", 1);
    openEggEff:center()
    openEggEff:setAnimation("egg"..self.eggType, false)
    self.contentLayout:addChild(openEggEff)
    openEggEff:addEventListener(UIEvent.ANIMATION_END,self,function()
        Avalon.AudioManager:playSound("1558")
        self.switchIcon:show()
        self.nameBg:show()
        self.openEggEff:hide()
        self.okBtn:centerBottom(4)
        self.petAnimation:show()
        self.titleEff:show()
        self.lightEff:show()
        self.lightEff:setAnimation("idle", true)
        self.titleEff:setAnimation("idle", true)
        self.bgEff:setAnimation("trigger", false)
    end)
    self.openEggEff = openEggEff

    self:initQualityLayer()
end

function PetResultShowView:composeResultView()
    self:initAttrLayer()

    -- 星级
    -- local starLv, canLvUpNum = self.curPet:getStarLv()
    -- if starLv > 0 or canLvUpNum > 0 then
    --     local starLayout = UI.Layout:create();
    --     starLayout:init()
    --     starLayout:setSize(220, 30)
    --     starLayout:centerBottom(30)
    --     starLayout:setName("StarLayout")
    --     self.infoLayer:addChild(starLayout, 2)

    --     local starBG = UI.Image:create()
    --     starBG:init("ui_pets_bigstar_banner_variation.png")
    --     starBG:center()
    --     starLayout:addChild(starBG)

    --     local starAutoLayer = UI.Layout:create();
    --     starAutoLayer:init()
    --     starAutoLayer:center()
    --     starAutoLayer:enableAutoWidth()
    --     starAutoLayer:enableAutoHeight()
    --     -- starAutoLayer:enableDebugDraw()
    --     starLayout:addChild(starAutoLayer, 20)

    --     for i = 1, starLv do
    --         local starImg = UI.Image:create()
    --         starImg:init("symbol_character_hero_power.png")
    --         starImg:floatLeft(-2)
    --         starAutoLayer:addComponent(starImg)
    --     end

    --     for i = 1, canLvUpNum do
    --         local starImg = UI.Image:create()
    --         starImg:init("symbol_character_hero_power_0.png")
    --         starImg:floatLeft(-2)
    --         starAutoLayer:addComponent(starImg)
    --     end
    -- end



    local str1 = "symbol_character_hero_power.png"
    local str2 = "symbol_character_hero_power_0.png"
    local disStar = -2
    local disCan = -2
    local starLv, canLvUpNum = self.curPet:getStarLv()
    local nowReincarntionLv = self.curPet:getReincarntionLv()
    if nowReincarntionLv > 0 then
        local configDatas = ConfigManager:getAllPetReincarnationDataByID(nowReincarntionLv)
        starLv = starLv - tonumber(configDatas.deductStars)
        str1 = "ui_information_equip2.png" 
        str2 = "symbol_character_hero_power_0.png"
        disStar = -3
        disCan = 0
    end

    if starLv > 0 or canLvUpNum > 0 then
        local starLayout = UI.Layout:create();
        starLayout:init()
        starLayout:setSize(220, 30)
        starLayout:centerBottom(30)
        starLayout:setName("StarLayout")
        self.infoLayer:addChild(starLayout, 2)

        local starBG = UI.Image:create()
        starBG:init("ui_pets_bigstar_banner_variation.png")
        starBG:center()
        starLayout:addChild(starBG)

        local starAutoLayer = UI.Layout:create();
        starAutoLayer:init()
        starAutoLayer:center()
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
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

        end
    end




    Avalon.AudioManager:playSound("1558")
    self.switchIcon:show()
    self.nameBg:show()
    self.okBtn:centerBottom(4)
    self.petAnimation:show()
    self.titleEff:show()
    self.lightEff:show()
    self.lightEff:setAnimation("idle", true)
    self.titleEff:setAnimation("idle", true)
    self.bgEff:setAnimation("trigger", false)
end

function PetResultShowView:rebornResultView()
    self:initQualityLayer()

    Avalon.AudioManager:playSound("1558")
    self.switchIcon:show()
    self.nameBg:show()
    self.okBtn:centerBottom(4)
    self.petAnimation:show()
    self.titleEff:show()
    self.lightEff:show()
    self.lightEff:setAnimation("idle", true)
    self.titleEff:setAnimation("idle", true)
    self.bgEff:setAnimation("trigger", false)

    if mvc.petModel:isHightQuality(self.petID) then
        local highQualityImg = UI.Image:create()
        highQualityImg:init("ui_pets_rare_box.png")
        highQualityImg:rightBottom(80, 160)
        highQualityImg:rotate(-21)
        self.qualityLayer:addChild(highQualityImg, 5)

        local highQualityTxt = UI.Text:create()
        highQualityTxt:init(UI.TEXT_1213755, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_120_34_21)
        highQualityTxt:setWidth(100)
        highQualityTxt:setTextCenter()
        highQualityTxt:autoAdapt()
        highQualityTxt:center(2, -3)
        highQualityTxt:setLineSpacing(-6)
        highQualityImg:addChild(highQualityTxt)
    end
end

function PetResultShowView:initInfoLayer()
    -- 基本信息
    local infoLayer = UI.Layout:create();
    infoLayer:init()
    infoLayer:setSize(590, 370)
    infoLayer:center()
    self.innerLayer:addChild(infoLayer);
    self.infoLayer = infoLayer

    local nameBg  = UI.Image:create();
    nameBg:init("ui_information_nametitle_2.png");
    nameBg:centerUp(44);
    self.infoLayer:addChild(nameBg, 100);
    nameBg:hide()
    self.nameBg = nameBg

    local nameTxt = UI.Text:create()
    nameTxt:init(self.curPet:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    nameTxt:setWidth(300)
    nameTxt:setTextCenter()
    nameTxt:autoAdapt()
    nameTxt:center()
    nameBg:addChild(nameTxt)

    local typeIcon  = UI.Image:create();
    if self.curPet.isVariant then
        typeIcon:init("ui_pets_variation.png");
    else
        typeIcon:init("ui_pets_ordinary.png");
    end
    typeIcon:centerLeft(0);
    nameBg:addChild(typeIcon)

    -- 宠物动画
    local spineName, jsonName, scale = self.curPet:getAnimationData()
    local petAnimation = UI.Animation:create()
    local spineOffset = string.split(self.curPet.eggoffset, ";")
    local offsetOne = self.curPet.isVariant and spineOffset[2] or spineOffset[1]
    local offset = string.split(offsetOne, ",")
    local scaleArr = string.split(self.curPet.eggscale, ";")
    local scale = self.curPet.isVariant and scaleArr[2] or scaleArr[1]
    petAnimation:init(spineName, jsonName, 1, true)
    petAnimation:centerUp(200 - offset[2])
    petAnimation:setScale(tonumber(scale))
    petAnimation:setAnimation("idle3", true)
    self.infoLayer:addChild(petAnimation)
    petAnimation:hide()
    self.petAnimation = petAnimation


    performWithDelay(self, function()
        self:showShareBtn()
    end, 2)
end

function PetResultShowView:initAttrLayer()
    -- 基础属性
    local attrLayer = UI.Layout:create();
    attrLayer:init()
    attrLayer:setSize(422, 280)
    attrLayer:centerUp(2000)
    -- attrLayer:enableDebugDraw()
    self.innerLayer:addChild(attrLayer);
    self.attrLayer = attrLayer

    -- 背景
    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_black20%.png")
    bgImage:setContentSize(414, 340)
    bgImage:setCapInsets(CCRectMake(5, 5, 1, 1))
    bgImage:setPosition(cc.p(210, 140))
    self.attrLayer:addChild(bgImage)

    local xArr = {
        6, 6, 6, 6, 6, 6, 6, 6, 
        240, 240, 240, 240, 240, 240, 240, 240}

    local attrData = mvc.petModel:getAllBaseAttr(self.curPet, xArr, self.changeData)
    for k, v in ipairs(attrData) do
        local oneBaseAttr = self:addOneBaseAttr(v)
        self.attrLayer:addChild(oneBaseAttr)
    end
end

function PetResultShowView:addOneBaseAttr(data)
    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(178, 32)
    innerLayer:leftUp(data.x, data.y)

    local attrIcon  = UI.Image:create();
    attrIcon:init(data.icon);
    attrIcon:centerLeft(15);
    innerLayer:addChild(attrIcon);

    local attrVal = UI.Text:create()
    attrVal:init(tostring(data.val), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    attrVal:centerLeft(48)
    innerLayer:addChild(attrVal)

    if data.change then
        local w1 = attrVal:getContentSize().width
        local plusVal = UI.Text:create()
        plusVal:init("(" .. data.change .. ")", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_70_179_117)
        plusVal:centerLeft(48+w1+10)
        innerLayer:addChild(plusVal)

        local w2 = plusVal:getContentSize().width
        local plusIcon  = UI.Image:create();
        plusIcon:init("ui_explore_arrow.png");
        plusIcon:centerLeft(48+w1+10+w2+5);
        innerLayer:addChild(plusIcon);
    end

    return innerLayer
end

function PetResultShowView:initQualityLayer()
    -- 资质界面
    local quaLayer = UI.Layout:create();
    quaLayer:init()
    quaLayer:setSize(590, 370)
    quaLayer:centerUp(2000)
    self.innerLayer:addChild(quaLayer);
    self.qualityLayer = quaLayer

    -- 背景
    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_black20%.png")
    bgImage:setContentSize(414, 340)
    bgImage:setCapInsets(CCRectMake(5, 5, 1, 1))
    bgImage:setPosition(cc.p(300, 185))
    self.qualityLayer:addChild(bgImage)

    -- 资质部分
    local qualityLayer = UI.PetQualityLayer:create()
    qualityLayer:init(self.petID, false, false, {name = UI.FONT_COLOR_255_164_104})
    qualityLayer:leftUp(140, 20)
    self.qualityLayer:addChild(qualityLayer, 1);

    -- 技能部分
    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:init(self.petID)
    skillLayer:centerBottom(6)
    self.qualityLayer:addChild(skillLayer, 1);
end

function PetResultShowView:switchClick()
    if self.switchIdx == 1 then
        self.switchIdx = 2
        self.switchIcon:setSpriteName("ui_pets_show_btn_1.png")

        self.infoLayer:centerUp(2000)

        if self.showType == RESULT_TYPE.OPEN_EGG then
            self.qualityLayer:center()
        elseif self.showType == RESULT_TYPE.COMPOSE_EGG then
            self.attrLayer:center()
        elseif self.showType == RESULT_TYPE.REBORN_EGG then
            self.qualityLayer:center()
        end
    else
        self.switchIdx = 1
        self.switchIcon:setSpriteName("ui_pets_show_btn_0.png")

        self.infoLayer:center()

        if self.showType == RESULT_TYPE.OPEN_EGG then
            self.qualityLayer:centerUp(2000)
        elseif self.showType == RESULT_TYPE.COMPOSE_EGG then
            self.attrLayer:centerUp(2000)
        elseif self.showType == RESULT_TYPE.REBORN_EGG then
            self.qualityLayer:centerUp(2000)
        end
    end
end

function PetResultShowView:showTip(x, y, isRevert, text)
    local pos = self:convertToNodeSpace(cc.p(x, y))

    -- 提示框
    local tipBG = UI.Image9:create()
    tipBG:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
    tipBG:leftBottom(pos.x, pos.y)
    tipBG:setName("TIP")
    self:addChild(tipBG, 10000)

    local content = UI.Text:create()
    content:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
    content:leftUp(10, 10)
    content:setTextLeft()
    local textW = content:getContentSize().width
    local textH = content:getContentSize().height
    if textW > 210 then
        content:setWidth(210)
        content:autoAdapt()
        textH = content:getContentSize().height
        tipBG:setSize(220, textH+20)
    else
        tipBG:setSize(textW+20, textH+20)
    end
    tipBG:addChild(content)

    local tipArrow  = UI.Image:create();
    tipArrow:init("ui_information_banner_background2.png");
    if isRevert then
        tipArrow:setScaleX(-1)
        tipArrow:centerLeft(-9)
    else
        tipArrow:centerRight(-9)
    end
    tipBG:addChild(tipArrow)

    tipBG:updateView()
    local w = tipBG:getContentSize().width
    local h = tipBG:getContentSize().height
    if isRevert then
        tipBG:leftBottom(pos.x+60, pos.y-h/2)
    else
        tipBG:leftBottom(pos.x-w-60, pos.y-h/2)
    end
end

function PetResultShowView:hideTip()
    local tip = self:getChildByName("TIP")
    if tip then
        self:removeChildByName("TIP")
    end
end

function PetResultShowView:showShareBtn()

    local shareBtn = UI.SharePanel:create(handler(self, self.shareClick), PublicDefine.SHARE_MODULE.SHARE_MODULE_PET, false)
    shareBtn:rightBottom(-(winSize.width/2 - COM_WIDTH/2 - 70), -(winSize.height/2 - COM_HEIGHT/2))
    self:addChild(shareBtn, 1000)

end

function PetResultShowView:shareClick(platform)

    local share = UI.PetShareView:create()
    share:init(self.curPet, platform)
    self:addChild(share)

end

function PetResultShowView:bindModel()

end

function PetResultShowView:unbindModel()

end

return PetResultShowView
