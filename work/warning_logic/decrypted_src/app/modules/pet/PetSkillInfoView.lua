------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkillInfoView = class("PetSkillInfoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 315
local COM_HEIGHT = 365

function PetSkillInfoView:ctor()
    PetSkillInfoView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetSkillInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSkillInfoView.super.init(self, ... )
end

function PetSkillInfoView:dtor()
    PetSkillInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetSkillInfoView")
end


function PetSkillInfoView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    -- TODO:这里是一个技能ICON
    local skillBG  = UI.Image:create();
    skillBG:init("box_quality_0_3.png");
    skillBG:leftUp(20, 50);
    self.contentLayout:addChild(skillBG);

    local nameTxt = UI.Text:create()
    nameTxt:init("技能名字技能名字技能名字", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    nameTxt:setWidth(156)
    nameTxt:setTextLeft()
    nameTxt:autoAdapt()
    nameTxt:leftUp(120, 50)
    self.contentLayout:addChild(nameTxt)

    local typeTxt = UI.Text:create()
    typeTxt:init("(被动)", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    typeTxt:leftUp(120, 100)
    self.contentLayout:addChild(typeTxt)
end


function PetSkillInfoView:bindModel()

end


function PetSkillInfoView:unbindModel()

end





return PetSkillInfoView












