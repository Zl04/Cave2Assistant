------------------------------------------------------------------------------
--author: ting.guan
--date	: 2019/11/02
--desc	: 宠物分享界面
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetShareView = class("PetShareView", UI.HWBtnComponent)

require "app.modules.pet.PetQualityLayer"
require "app.modules.pet.PetSkillLayer"

UI = UI or {}
UI.PetShareView = PetShareView

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
    "ui_general_big_number.plist",
    "ui_package_pets_share.plist",
}

local COM_WIDTH = 640
local COM_HEIGHT = 1000

function PetShareView:ctor()
    PetShareView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetShareView:init(data, platform, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    self.curPet = data
    self.platform = platform
    PetShareView.super.init(self, ... )
end

function PetShareView:dtor()
    PetShareView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetShareView")
    
end

function PetShareView:onInitView()
    --self:enableDebugDraw()
    print("PetShareView")

    local ZOrder = 0

    -- 整体宿主
    local screenhostHost = UI.Component:create()
    screenhostHost:init()
    screenhostHost:setSize(640, 1200)
    screenhostHost:leftBottom(0, 0)
    cc.Director:getInstance():getRunningScene():addChild(screenhostHost, -1)
    
    -- 背景图片1
    local shareBg1 = UI.Image:create()
    shareBg1:init("ui_pets_share_bg_2.png") 
    shareBg1:center()
    screenhostHost:addChild(shareBg1)
    self.shareBg = shareBg1
    ZOrder = ZOrder + 1

    -- 背景图片2
    local shareBg2 = UI.Image:create()
    shareBg2:init("ui_pets_share_bg.png") 
    shareBg2:centerUp(55)
    self.shareBg:addChild(shareBg2, ZOrder)
    ZOrder = ZOrder + 1

    -- 宠物名字
    local nameLayout = UI.Layout:create()
    nameLayout:init()
    nameLayout:setSize(554, 74)
    nameLayout:centerUp(55)
    self.shareBg:addChild(nameLayout, ZOrder)
    ZOrder = ZOrder + 1

    local petName = UI.Text:create()
    petName:init(self.curPet:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_40PX, UI.FONT_COLOR_255_204_0)
    petName:center()
    petName:setWidth(415)
    petName:setTextCenter()
    petName:autoAdapt()
    nameLayout:addChild(petName)

    -- 星级
    local starLv, canLvUpNum = self.curPet:getStarLv()
    if starLv > 0 or canLvUpNum > 0 then

        local starAutoLayer = UI.Layout:create();
        starAutoLayer:init()
        starAutoLayer:centerUp(138)
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
        self.shareBg:addChild(starAutoLayer, ZOrder)

        for i = 1, starLv do
            local starImg = UI.Image:create()
            starImg:init("ui_pets_bigstar_1.png")
            starImg:floatLeft(5)
            starAutoLayer:addComponent(starImg)
        end

        for i = 1, canLvUpNum do
            local starImg = UI.Image:create()
            starImg:init("ui_pets_share_bigstar_0.png")
            starImg:floatLeft(5)
            starAutoLayer:addComponent(starImg)
        end
    end

    -- 宠物
    local petAnimation = UI.Animation:create()
    local spineArr = string.split(self.curPet.spine, ";")
    local spineName, jsonName, scale = self.curPet:getAnimationData()
    local spineOffset = string.split(self.curPet.spineoffset, ";")
    local offsetOne = self.curPet.isVariant and spineOffset[2] or spineOffset[1]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName, jsonName, scale)
    petAnimation:centerUp(350 - offset[2])
    petAnimation:setAnimation("idle3", true)
    self.shareBg:addChild(petAnimation, ZOrder)
    ZOrder = ZOrder + 1

    -- 底光
    local lightDownEff = UI.Animation:create()
    lightDownEff:init("effect_ui_town_pet_show_down.json", "effect_ui_town_pet_show_down.atlas", 1);
    lightDownEff:centerUp(355)
    -- lightDownEff:setAnimation("idle", true)
    self.shareBg:addChild(lightDownEff)

    -- 上光
    local lightUpEff = UI.Animation:create()
    lightUpEff:init("effect_ui_town_pet_show_up.json", "effect_ui_town_pet_show_up.atlas", 1);
    lightUpEff:centerUp(359)
    -- lightUpEff:setAnimation("idle", true)
    self.shareBg:addChild(lightUpEff)

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
    local lvLayout = UI.Layout:create();
    lvLayout:init()
    lvLayout:enableAutoWidth()
    lvLayout:enableAutoHeight()
    lvLayout:centerUp(343)
    self.shareBg:addChild(lvLayout, ZOrder)
    ZOrder = ZOrder + 1

    local lvImg = UI.Image:create()
    lvImg:init("ui_home_banner_lv.png")
    lvImg:floatLeft(0)
    lvLayout:addComponent(lvImg)

    local lvNum = AvalonUtil:getStyledNumberNode(self.curPet:getLevel())
    lvNum:floatLeft(5)
    lvLayout:addComponent(lvNum)

    -- 战力
    local powerLayout = UI.Layout:create()
    powerLayout:init()
    powerLayout:enableAutoWidth()
    powerLayout:enableAutoHeight()
    powerLayout:centerUp(385)
    self.shareBg:addChild(powerLayout, ZOrder)
    ZOrder = ZOrder + 1

    local powerImg = UI.Image:create()
    powerImg:init("ui_information_equip.png")
    powerImg:floatLeft(0)
    powerLayout:addComponent(powerImg)

    local power = self.curPet:getPower()
    local powerLv = UI.Text:create()
    powerLv:init(powerLv:numformat(tostring(power)), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_211_124)
    powerLv:floatLeft(4)
    powerLayout:addComponent(powerLv)

    local colors = {
        name = UI.FONT_COLOR_194_194_194,
        prg = UI.FONT_COLOR_210_210_210, 
        expPlus = UI.FONT_COLOR_255_187_89,
    }

    -- 资质
    local qualityLayer = UI.PetQualityLayer:create()
    qualityLayer:init(self.curPet:getId(), false, false, colors)
    qualityLayer:leftUp(150, 453)
    self.shareBg:addChild(qualityLayer, ZOrder)
    ZOrder = ZOrder + 1

    -- 技能
    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:init(self.curPet:getId())
    skillLayer:centerUp(658)
    self.shareBg:addChild(skillLayer, ZOrder)
    ZOrder = ZOrder + 1

    -- 超高资质
    if mvc.petModel:isHightQuality(self.curPet:getId()) then
        local highQualityImg = UI.Image:create()
        highQualityImg:init("ui_pets_rare_box.png")
        highQualityImg:rightBottom(115, 548)
        highQualityImg:rotate(-21)
        self.shareBg:addChild(highQualityImg, 1000)
    
        local highQualityTxt = UI.Text:create()
        highQualityTxt:init(UI.TEXT_1213755, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_120_34_21)
        highQualityTxt:setWidth(100)
        highQualityTxt:setTextCenter()
        highQualityTxt:autoAdapt()
        highQualityTxt:center(2, -3)
        highQualityTxt:setLineSpacing(-6)
        highQualityImg:addChild(highQualityTxt)
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_PET, self.platform)

    -- 分享
    performWithDelay(self, function()
        SdkBox:getInstance():createImage(shareBg1,"share.png",function(path)
            SdkBox:getInstance():share({
                channel = self.platform,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                -- stype = Avalon.WXScene.WXSceneTimeline
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = path,
            })
            if screenhostHost and not tolua.isnull(screenhostHost) then
                screenhostHost:setVisible(false)
                screenhostHost:runAction(cc.RemoveSelf:create())
            end
        end)
    end, 0.05)
    
end


function PetShareView:bindModel()

end


function PetShareView:unbindModel()

end





return PetShareView












