------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/09/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkinCellView = class("PetSkinCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 180
local COM_HEIGHT = 178

function PetSkinCellView:ctor(skinID, petData)
    PetSkinCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.skinID = skinID
    self.petData = petData
    self:bindModel()
end

function PetSkinCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSkinCellView.super.init(self, ... )
end

function PetSkinCellView:dtor()
    PetSkinCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetSkinCellView")
end


function PetSkinCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_pets_skin_panel.png");
    bg:center();
    contentLayout:addChild(bg);
    
    self:initSkinCellView()
end

function PetSkinCellView:initSkinCellView()
    if self.skinID then
        local lightFrame = UI.Image:create();
        lightFrame:init("ui_pets_skin_box.png");
        lightFrame:center();
        self.contentLayout:addChild(lightFrame);
        lightFrame:hide()

        local skinConfig = ConfigManager:getPetSkinByID(self.skinID)
        local skinName = skinConfig.skinSpine

        local skinAnime = UI.Animation:create()
        skinAnime:init(skinName..".json", skinName..".atlas", 1, true);
        skinAnime:centerBottom(50)
        skinAnime:setAnimation("idle1", true)
        skinAnime:setScale(0.7)
        self.contentLayout:addChild(skinAnime)

        local isUnlock = MasterDataManager:checkPetSkinIsUnlock(self.skinID)

        local getDesLayout = UI.Layout:create();
        getDesLayout:init()
        getDesLayout:setSize(150, 20)
        getDesLayout:centerBottom(10)
        self.contentLayout:addChild(getDesLayout)
        self.getDesLayout = getDesLayout
        getDesLayout:setVisible(not isUnlock)

        local getDesBg = UI.Image:create();
        getDesBg:init("ui_pets_skin_bg_2.png");
        getDesBg:center();
        getDesLayout:addChild(getDesBg);

        local getDes = languageManagerInstance:getLocalString(skinConfig.unlockDes) 
        local getDesText = UI.Text:create()
        getDesText:init(getDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_199_199_199)
        getDesText:center()
        getDesLayout:addChild(getDesText)

        local useBtn = UI.Button:create();
        useBtn:init("ui_pets_skin_btn.png","ui_pets_skin_btn.png","ui_pets_skin_btn.png")
        useBtn:centerBottom(5)
        -- useBtn:closeClickScale()
        useBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        useBtn:setText(UI.TEXT_1213672)
        self.contentLayout:addChild(useBtn)
        useBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
            self:onPetUseSkin()
        end)
        self.useBtn = useBtn
        useBtn:setVisible(isUnlock)

        self.contentLayout:setTouchEnable(true)
        self.contentLayout:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            lightFrame:show()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SKIN_ATTR_DES,false, self.skinID)
        end)
        self.contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
            lightFrame:hide()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SKIN_ATTR_DES, true, self.skinID)
        end)
    else
        local getDesLayout = UI.Layout:create();
        getDesLayout:init()
        getDesLayout:setSize(148, 30)
        getDesLayout:center()
        self.contentLayout:addChild(getDesLayout)
        self.getDesLayout = getDesLayout
        getDesLayout:setVisible(not isUnlock)

        local getDesBg = UI.Image:create();
        getDesBg:init("ui_pets_skin_bg_1.png");
        getDesBg:center();
        getDesLayout:addChild(getDesBg);

        local getDesText = UI.Text:create()
        getDesText:init(UI.TEXT_226802, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_199_199_199)
        getDesText:center()
        getDesLayout:addChild(getDesText)
    end
    self:updateSkinCellView()
end

function PetSkinCellView:updateSkinCellView()
    if not self.skinID then
        return 
    end
    if self.petData and self.petData.skinId > 0 and self.petData.skinId == self.skinID then
        self.useBtn:setText(UI.TEXT_110012)
    elseif self.petData and self.petData.skinId == 0 then
        self.useBtn:setText(UI.TEXT_1213672)
    end
    
end

function PetSkinCellView:onPetUseSkin()
    local data = {}
    data.petId = self.petData.spriteID
    data.skinId = self.petData.skinId > 0 and 0 or self.skinID
    Net.NetPetSystem:petRequestChangeSkin(data)
end

function PetSkinCellView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.updateSkinCellView)
end


function PetSkinCellView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.updateSkinCellView)
end





return PetSkinCellView












