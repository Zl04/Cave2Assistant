------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/30
--desc	: 宠物简要信息：名字、类型、资质、技能
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetBriefInfoView = class("PetBriefInfoView", UI.HWBtnComponent)

require "app.modules.pet.PetQualityLayer"
require "app.modules.pet.PetSkillLayer"

UI = UI or {}

UI.PetBriefInfoView = PetBriefInfoView

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_town_sevendays.plist",
}

local COM_WIDTH = 408
local COM_HEIGHT = 458

function PetBriefInfoView:ctor()
    PetBriefInfoView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:setInterceptTouches(false)
    self:setTouchEnable(true)
end

function PetBriefInfoView:init(petID, tipRevert, ... )
    self.curPet = MasterDataManager:getBagPetById(petID)
    self.tipRevert = tipRevert

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetBriefInfoView.super.init(self, ... )
end

function PetBriefInfoView:dtor()
    PetBriefInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetBriefInfoView")
end


function PetBriefInfoView:onInitView()
    self:showLucencyLight()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_sevendays_bg_paper_2.png")
    bg:setContentSize(404, 454)
    bg:setCapInsets(CCRectMake(202,227,1,1))
    bg:setPosition(404/2+2, 227)
    self.contentLayout:addChild(bg)

    local nameBG  = UI.Image:create();
    nameBG:init("ui_information_nametitle.png");
    nameBG:centerUp(24)
    self.contentLayout:addChild(nameBG);

    local typeIcon  = UI.Image:create();
    if self.curPet.isVariant then
        typeIcon:init("ui_pets_variation.png");
    else
        typeIcon:init("ui_pets_ordinary.png");
    end
    typeIcon:centerLeft(-18);
    self.typeIcon = typeIcon
    nameBG:addChild(typeIcon)

    local titleTxt = UI.Text:create()
    titleTxt:init(self.curPet:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    titleTxt:setWidth(300)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:center()
    self.titleTxt = titleTxt
    nameBG:addChild(titleTxt)

    -- 资质部分
    local qualityLayer = UI.PetQualityLayer:create()
    qualityLayer:init(self.curPet:getId(), false, self.tipRevert)
    qualityLayer:leftUp(30, 70)
    self.qualityLayer = qualityLayer
    self.contentLayout:addChild(qualityLayer, 1);

    -- 技能
    local skillBG  = UI.Image:create();
    skillBG:init("ui_pets_skill_paper.png");
    skillBG:centerBottom(20);
    self.contentLayout:addChild(skillBG, 2);

    local lvTxt = UI.Text:create()
    lvTxt:init("Lv " .. tostring(self.curPet:getLevel()), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    lvTxt:rightUp(0, -30)
    self.lvTxt = lvTxt
    skillBG:addChild(lvTxt)

    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:init(self.curPet:getId())
    skillLayer:leftUp(0, 0)
    self.skillLayer = skillLayer
    skillBG:addChild(skillLayer, 1);
end

function PetBriefInfoView:updateToShow(petID, tipRevert)
    self.curPet = MasterDataManager:getBagPetById(petID)
    self.tipRevert = tipRevert

    if self.curPet.isVariant then
        self.typeIcon:setSpriteName("ui_pets_variation.png")
    else
        self.typeIcon:setSpriteName("ui_pets_ordinary.png")
    end

    self.titleTxt:setText(self.curPet:getNickName())
    self.lvTxt:setText("Lv " .. tostring(self.curPet:getLevel()))

    self.qualityLayer:updateToShow(self.curPet:getId(), false, self.tipRevert)
    self.skillLayer:updateToShow(self.curPet:getId())
end

function PetBriefInfoView:bindModel()

end

function PetBriefInfoView:unbindModel()

end

return PetBriefInfoView
