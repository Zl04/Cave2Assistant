------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/09/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkinAttrDesView = class("PetSkinAttrDesView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 162
local COM_HEIGHT = 188

function PetSkinAttrDesView:ctor(data)
    PetSkinAttrDesView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function PetSkinAttrDesView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSkinAttrDesView.super.init(self, ... )
end

function PetSkinAttrDesView:dtor()
    PetSkinAttrDesView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetSkinAttrDesView")
end


function PetSkinAttrDesView:onInitView()
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(COM_WIDTH, COM_HEIGHT)
    panel:center()
    self:addChild(panel, 100)
    self.infoPanel = panel

    local bg = UI.Image:create()
    bg:init("ui_pets_skin_paper.png")
    bg:center()
    panel:addChild(bg)

    local xAdd = 0
    local yAdd = 0
    local title = UI.Text:create()
    title:init(UI.TEXT_226803, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_48_46_46)
    panel:addChild(title) 
    title:centerUp(20)

    local layoutHeight = COM_HEIGHT - 90
    local layoutWidth = COM_WIDTH - 40

    local desc = UI.Text:create()
    desc:init(self.data.tips, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_48_46_46)
    desc:setWidth(layoutWidth)
    desc:autoAdapt()
    desc:center()

    local height = desc:getContentSize().height
    -- height = height < 50 and 50 or height
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(layoutWidth, height)
    
    if height >= layoutHeight then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(layoutWidth, layoutHeight)
        scrollView:init()
        -- scrollView:leftUp(25+xAdd, 67+yAdd)
        scrollView:centerUp(60)
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)    
    else
        -- layout:leftUp(25+xAdd, 67+yAdd)
        layout:centerUp(60)
        panel:addChild(layout)
    end
    layout:addChild(desc)

    -- self:setTouchEnable(true)
    -- -- self:setInterceptTouches(true)
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
    --     self:close()
    -- end)
end


function PetSkinAttrDesView:bindModel()

end


function PetSkinAttrDesView:unbindModel()

end





return PetSkinAttrDesView












