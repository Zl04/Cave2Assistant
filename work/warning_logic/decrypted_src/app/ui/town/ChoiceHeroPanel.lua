-- ChoiceHeroPanel.lua
-- Author:zp
-- 2017年8月21日
-- Using:城镇查看角色组件

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local ChoiceHeroPanel = class("ChoiceHeroPanel", UI.HWBtnComponent)
UI.ChoiceHeroPanel = ChoiceHeroPanel


-- 背景:正常，死亡，离线，变灰
local TEAMMATE_AVATAR_BLACK = "ui_playerstate_me_black_up.png"
local TEAMMATE_AVATAR_PET_BLACK = "ui_playerstate_pet_black_up.png"

-- 等级背景（通用）
local ROLE_GRADE_SP_1 = "ui_playerstate_me_grade.png"
local PET_GRADE_SP_1 = "ui_playerstate_pet_grade.png"

-- 蒙版背景
local ROLE_MASK_BLACK = "ui_playerstate_me_black_01.png"
local PET_MASK_BLACK = "ui_playerstate_pet_black.png"

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
}

-- 尺寸
local COM_WIDTH = 371
local COM_HEIGHT = 626

function ChoiceHeroPanel:ctor()
    ChoiceHeroPanel.super.ctor(self, UIType.CHOICE_HERO, COM_RES_LIST, 100, 100)

    self._iconButton = nil

end

function ChoiceHeroPanel:dtor()
    ChoiceHeroPanel.super.dtor(self)
    if(self._heroData) then
        GameManager:hideSelectHero(self._heroData:getSpriteID())
        self._heroData = nil
    end

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_CHOICE_HERO, self, self.onHideChoiceHeroHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_CHOICE_HERO, self, self.onShowChoiceHeroHandler)
end

-- public:
-- 初始化
function ChoiceHeroPanel:init(heroData)
    self._heroData = heroData

    ChoiceHeroPanel.super.init(self)
    -- self:setInterceptTouches(true)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_CHOICE_HERO, self, self.onHideChoiceHeroHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_CHOICE_HERO, self, self.onShowChoiceHeroHandler)
end

function ChoiceHeroPanel:onHideChoiceHeroHandler()
    if(self._iconButton) then
        self._iconButton:setVisible(false)
        self._iconButton:runAction(cc.FadeOut:create(0.2))
    end
end

function ChoiceHeroPanel:onShowChoiceHeroHandler()
    if(self._iconButton) then
        self._iconButton:setVisible(true)
        self._iconButton:runAction(cc.FadeIn:create(0.2))
    end
end

-- 模版函数：初始化组建的视图
function ChoiceHeroPanel:onInitView()
    -- 内容面板
    self:setTouchEnable(true)

    local iconButton = UI.Button:create()
    if self._heroData:getType() == RoleType.Pet then
        iconButton:init(TEAMMATE_AVATAR_PET_BLACK, TEAMMATE_AVATAR_PET_BLACK)
    else
        iconButton:init(TEAMMATE_AVATAR_BLACK, TEAMMATE_AVATAR_BLACK)
    end
    iconButton:centerUp(40)
    self:addChild(iconButton)
    self._iconButton = iconButton
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self._heroData:getType() == RoleType.Pet then
            Net.NetPetSystem:getPetDetail(self._heroData:getSpriteID())
        else
            local pHeadTips = UI.HeadTips:create(UIType.CHOICE_HERO)
            pHeadTips:setPos(77 + 30, -175)
            pHeadTips:init(self._heroData)
            self:addChild(pHeadTips, 100)
        end    
    end)

    iconButton:showLucencyLight(iconButton:getContentSize().width, iconButton:getContentSize().height)

    -- 添加蒙版效果
    self.circleImage = UI.Image:create()
    self.circleImage:init()
    self.circleImage:center()
    self._iconButton:addChild(self.circleImage, 3) 

    -- 等级背景图  
    self._grade_BG = UI.Image:create()
    self._grade_BG:init()
    self._grade_BG:leftBottom(-10,-4)
    self._iconButton:addChild(self._grade_BG, 100) 
    
    -- 等级
    local showLV = self._heroData:getUIShowLv()
    self._lvLabel = UI.Text:create()
    self._lvLabel:init(showLV.."",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_187_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:center()
    self._lvLabel:setTextCenter()
    self._grade_BG:addChild(self._lvLabel,101)

    -- 角色名字
    self._roleName = UI.Text:create()
    self._roleName:init(self._heroData:getNickName(), UI.SYS_FONT,UI.FONT_SIZE_16PX,UI.FONT_COLOR_255_235_216)
    self._roleName:setSize(150, 24)
    self._roleName:setTextHorizontalCenter()
    self._roleName:centerBottom(-25)
    self._iconButton:addChild(self._roleName, 101)

    if self._heroData:getType() == RoleType.Hero then    

        local roleinfoData = GameDataManager:getInstance():getRoleInfoDataForPK(self._heroData:getPK())
        if(roleinfoData) then
            Avalon.WidgetUtil:getHead(self, self._heroData, roleinfoData.wearEquipmentArr,self,handler(self,function(self,pic)
                if self._iconButton and not tolua.isnull(self._iconButton) then
                    -- pic:setPosition(63, 68)
                    pic:setPosition(40, 38)
                    self._iconButton:addChild(pic, 2) 
                end
            end))
        end

        self.circleImage:setSpriteName(ROLE_MASK_BLACK)
        self._grade_BG:setSpriteName(ROLE_GRADE_SP_1)

        -- 武器类型
        self._equipmentType = UI.Image:create()
        self._equipmentType:init("icon-equip_small1_21080010_1.png")
        self._equipmentType:leftUp(58, 0)
        self._iconButton:addChild(self._equipmentType, 200) 
        self:updateEquipIcon()

    elseif self._heroData:getType() == RoleType.Pet then

        self.circleImage:setSpriteName(PET_MASK_BLACK)
        self._grade_BG:setSpriteName(PET_GRADE_SP_1)

        local petPic = UI.Image:create()
        local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(self._heroData:getIcon())
        if spriteFrame ~= nil then
            petPic:init(self._heroData:getIcon())
        else
            petPic:init("ui_playerstate_pet_black_up.png")
        end
        petPic:center()

        local clipper = UI.ClippingNode:create()
        clipper:initWithSprite("ui_playerstate_pet_black_up.png",  0.01)
        clipper:center()
        clipper:addInnerNode(petPic)
        clipper:setName("petIcon")
        clipper:setOpacityFilterTouch(false)
        self._iconButton:addChild(clipper, 2) 

    else 
        self:close()
    end

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        print("ChoiceHeroPanel  COMPONENT_TOUCH_OUTSIDE")
        self:close()
    end)
end

--更新武器ICON
function ChoiceHeroPanel:updateEquipIcon()
    local heroData = RoleDataManager:getHeroDataForPK(self._heroData:getPK())
    if(heroData) then
        local equipType = GameDataManager:getInstance():getWearWeaponTypeForSpriteID(heroData.spriteID)
        if equipType == 0 then
            self._equipmentType:hide()
        else
            self._equipmentType:show()
            if equipType == 1 then
                self._equipmentType:setSpriteName("icon-equip_small1_21080010_"..equipType..".png")
                -- self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
            elseif equipType == 2 then
                self._equipmentType:setSpriteName("icon-equip_small1_21080010_"..equipType..".png")
                -- self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
            elseif equipType == 3 then
                self._equipmentType:setSpriteName("icon-equip_small1_21080010_"..equipType..".png")
                -- self._equipmentType:useShader(UI.COMPONENT_GRAY_SHADER)
            end
        end
    end
end

