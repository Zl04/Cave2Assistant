------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/04
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandBoatInfoView = class("BigSailIslandBoatInfoView", UI.HWBtnComponent)
require "app.modules.bigsailport.BigSailSeamanLayer"

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 400
local COM_HEIGHT = 500

function BigSailIslandBoatInfoView:ctor(data)
    BigSailIslandBoatInfoView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.data = data
    print("BigSailIslandBoatInfoView--->: ", data)
end

function BigSailIslandBoatInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandBoatInfoView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        mvc.closePanel("BigSailIsland", "BigSailIslandBoatInfo")
        --self:close()
    end)
end

function BigSailIslandBoatInfoView:dtor()
    BigSailIslandBoatInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandBoatInfoView")
end


function BigSailIslandBoatInfoView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    self:addChild(contentLayout, 5)
    self.contentLayout = contentLayout

    self:center(260, 0)
    --self:enableDebugDraw()

    -- 效果描述面板
    local effectLayout = UI.Layout:create()
    effectLayout:init()
    effectLayout:setSize(345, 70)
    effectLayout:centerBottom(135)
    contentLayout:addChild(effectLayout, 5)
    self.effectLayout = effectLayout

    -- 解锁条件面板
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:setSize(335, 100)
    unlockLayout:centerBottom(15)
    contentLayout:addChild(unlockLayout, 5)
    self.unlockLayout = unlockLayout

    local bg = UI.Image.create()
    bg:init("ui_navigation_popups_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local frame = UI.Image.create()
    frame:init("ui_navigation_floorbg_2.png")
    frame:centerUp(65)
    contentLayout:addChild(frame, 10)

    local decorate = UI.Image.create()
    decorate:init("ui_navigation_floorbg_up.png")
    decorate:rightBottom(12, 10)
    frame:addChild(decorate)
    self.frame = frame

    local image = UI.Image.create()
    image:init("")
    image:rightBottom(-7, 10)
    frame:addChild(image)
    self.image = image

    local name = UI.Text:create()
    name:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    name:centerUp(25)
    contentLayout:addChild(name)
    self.name = name

    ----------------------------------------
    local skinConfig = ConfigManager:getVirtualItemConfigByID(tonumber(self.data.ID))
    local iconList = string.split(self.data.icon, ";") 
    self.image:setSpriteName(iconList[2])
    self.name:setText(skinConfig.name)

    -- local unlockDesList = string.split(self.data.unlockDesc, ",")
    -- for k ,v in pairs(unlockDesList) do
    --     local unlockDesStr = string.format(UI.TEXT_222714, languageManagerInstance:getLocalString(tonumber(v))) 
    --     local unlockDes = UI.Text:create()
    --     unlockDes:init(unlockDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    --     unlockDes:setSize(250, 25)
    --     unlockDes:setTextLeft()
    --     unlockDes:center(20, 35*(k-1)-30)
    --     unlockDes:setFixLineWidth(265)
    --     self.unlockLayout:addChild(unlockDes)
    -- end

    local effectDesList = string.split(self.data.effectDesc, ",")
    for k ,v in pairs(effectDesList) do
        local image = UI.Image.create()
        image:init("ui_navigation_square.png")
        image:center(-110, 30*(k-1)-20)
        self.effectLayout:addChild(image)

        local effectDesStr = string.format(UI.TEXT_222713, languageManagerInstance:getLocalString(tonumber(v))) 
        local effectDes = UI.Text:create()
        effectDes:init(effectDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        effectDes:setSize(250, 25)
        effectDes:setTextLeft()
        effectDes:center(35, 30*(k-1)-20)
        self.effectLayout:addChild(effectDes)
    end

    local animeName = self.data.spine
    if animeName and animeName ~="" then
        local previewAnime = UI.Animation:create()
        previewAnime:init(animeName..".json", animeName..".atlas", 1);
        previewAnime:center(-100, 60)
        self.frame:addChild(previewAnime, 101)
        previewAnime:setAnimation("idle3", true)
        previewAnime:setScale(0.7)
    end

    self:addSeamanEmbattling()
end

function BigSailIslandBoatInfoView:addSeamanEmbattling()
    if self.petsLayout then
        self.contentLayout:removeChildByName("petsLayout")
    end

    -- 宠物船员面板
    local petsLayout = UI.Layout:create()
    petsLayout:init()
    petsLayout:setSize(335, 100)
    petsLayout:centerBottom(15)
    self.contentLayout:addChild(petsLayout, 5)
    petsLayout:setName("petsLayout")
    self.petsLayout = petsLayout

     -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_greatnavigation_petsbox2.png")
    bg:center()
    self.petsLayout:addChild(bg)

    -- local bgPic1 = UI.Image:create()
    -- bgPic1:init("ui_greatnavigation_petsbox_add.png")
    -- bgPic1:center(-103, -1)
    -- self.petsLayout:addChild(bgPic1)

    -- local bgPic2 = UI.Image:create()
    -- bgPic2:init("ui_greatnavigation_petsbox_add.png")
    -- bgPic2:center(1, -1)
    -- self.petsLayout:addChild(bgPic2)

    -- local bgPic3 = UI.Image:create()
    -- bgPic3:init("ui_greatnavigation_petsbox_add.png")
    -- bgPic3:center(105, -1)
    -- self.petsLayout:addChild(bgPic3)

    for k,v in pairs(self.data.pets) do
        local config = ConfigManager:getPetDataByID(v.petTempleteId)
        local iconStr = ""
        local strs = string.split(config.icon, ";")
        if v.skinid and v.skinid ~= 0 then
            local skinConfig = ConfigManager:getPetSkinByID(v.skinid)
            iconStr = skinConfig.skinIcon
        elseif v.isvariant then
            iconStr = strs[2]
        else
            iconStr = strs[1]
        end
        local image = UI.Image.create()
        image:init((iconStr..".png"))
        image:center(-210 + k * 105, -3)
        petsLayout:addChild(image)
        print(iconStr)
    end
end


function BigSailIslandBoatInfoView:bindModel()

end


function BigSailIslandBoatInfoView:unbindModel()

end





return BigSailIslandBoatInfoView












