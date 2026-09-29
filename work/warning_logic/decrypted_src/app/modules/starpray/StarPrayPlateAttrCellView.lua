------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2024/01/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPrayPlateAttrCellView = class("StarPrayPlateAttrCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 482
local COM_HEIGHT = 105

function StarPrayPlateAttrCellView:ctor(data, specialShow)
    StarPrayPlateAttrCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.specialShow = specialShow
    self:bindModel()
end

function StarPrayPlateAttrCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.starpray", "StarPray", false)
    StarPrayPlateAttrCellView.super.init(self, ... )
end

function StarPrayPlateAttrCellView:dtor()
    StarPrayPlateAttrCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.starpray.StarPrayPlateAttrCellView")
end


function StarPrayPlateAttrCellView:onInitView()
    local contentLayout = UI.Layout:create()
	contentLayout:init()
	contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
	contentLayout:center()
	self:addChild(contentLayout)
	self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("ui_starmarks_list_01.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local buffName = languageManagerInstance:getLocalString(self.data.buffName)
    local name = UI.Text:create()
    name:init(buffName, UI.FONT_BOLD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_172_165_158)
    name:centerUp(5, -95)
    contentLayout:addChild(name)
    self.name = name
    
    local statusDes = UI.Text:create()
    statusDes:init(languageManagerInstance:getLocalString(self.data.attrUnlockDes), UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_77_5_5)
    statusDes:leftUp(230, 9)
    contentLayout:addChild(statusDes, 10)
    self.statusDes = statusDes

    local icon = UI.Image:create()
    icon:init(self.data.iconName.."_02.png")
    icon:centerLeft(0)
    bg:addChild(icon)
    self.icon = icon
    -- icon:setScale(0.8)

    local lvBg = UI.Image:create()
    lvBg:init("ui_starmarks_lvbg_02.png")
    lvBg:rightBottom(-7, -12)
    icon:addChild(lvBg)
    self.lvBg = lvBg
    lvBg:setScale(0.8)

    local lv = UI.Text:create()
    lv:init(tostring(self.data.grade), UI.FONT_BOLD,UI.FONT_SIZE_18PX,UI.FONT_COLOR_212_204_183)
    lv:center(0, -2)
    lvBg:addChild(lv)
    self.lv = lv

    self:addDesScrollView()
    self:updateAttrView()
end

function StarPrayPlateAttrCellView:updateAttrView()
    if self.data.activeAttrGrade == self.data.grade then
        if self.specialShow then
            self.lvBg:setSpriteName("ui_starmarks_lvbg.png")
            self.bg:setSpriteName("ui_starmarks_list_03.png")
            self.icon:setSpriteName(self.data.iconName..".png")
            self.statusDes:hide()
        else
            self.lvBg:setSpriteName("ui_starmarks_lvbg.png")
            self.bg:setSpriteName("ui_starmarks_list_02.png")
        end
        self.statusDes:setText(UI.TEXT_227701)
        self.statusDes:setFontColor(UI.FONT_COLOR_246_220_149)
    elseif self.data.activeAttrGrade < self.data.grade then
    -- elseif self.data.activeAttrGrade > self.data.grade then
    --     self.lvBg:setSpriteName("ui_starmarks_lvbg.png")
    --     self.bg:setSpriteName("ui_starmarks_list_03.png")
    --     self.statusDes:hide()
    end
end

function StarPrayPlateAttrCellView:addDesScrollView()
    local height = 55
    local width = 360
    local positionX = 50
    local positionY = 40
    local desStr = languageManagerInstance:getLocalString(self.data.buffDes)
    local desText = UI.Text:create()
    desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_26_26_26)
    desText:setWidth(width)
    desText:autoAdapt()

    if(desText:getContentSize().height <= height) then 
        desText:centerUp(positionY, positionX)
        self.contentLayout:addChild(desText, 99)
    else
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(width, desText:getContentSize().height)
        desText:centerUp(3)
        layout:addChild(desText)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(width, height)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(layout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:centerUp(positionY, positionX)

        self.contentLayout:addChild(detailedScrollView, 99)
    end
end

function StarPrayPlateAttrCellView:bindModel()

end


function StarPrayPlateAttrCellView:unbindModel()

end





return StarPrayPlateAttrCellView












