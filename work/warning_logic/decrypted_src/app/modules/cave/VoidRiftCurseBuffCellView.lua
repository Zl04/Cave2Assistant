------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/06/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local VoidRiftCurseBuffCellView = class("VoidRiftCurseBuffCellView", UI.HWBtnComponent)

UI = UI or {}
UI.VoidRiftCurseBuffCellView = VoidRiftCurseBuffCellView
-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 68
local COM_HEIGHT = 68

function VoidRiftCurseBuffCellView:ctor()
    VoidRiftCurseBuffCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._infoArea = nil
    self.viewContent = nil
    self:bindModel()
end

function VoidRiftCurseBuffCellView:init( data, viewContent )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    self.data = data
    self.viewContent = viewContent
    VoidRiftCurseBuffCellView.super.init(self )
end

function VoidRiftCurseBuffCellView:dtor()
    VoidRiftCurseBuffCellView.super.dtor(self)
    self._infoArea = nil
    self.viewContent = nil
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.VoidRiftCurseBuffCellView")
end


function VoidRiftCurseBuffCellView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local iconBg = UI.Image:create()
    iconBg:init("ui_btn_uncharted_debuff_bg.png")
    iconBg:center()
    cellLayout:addChild(iconBg, 100)

    local icon = UI.Image:create()
    icon:init(self.data.icon..".png")  
    icon:center()
    cellLayout:addChild(icon, 101)

end

function VoidRiftCurseBuffCellView:showInfo()
    if self.viewContent:getChildByName("infoBg") then 
        self.viewContent:removeChildByName("infoBg")
    end

    local infoBg = UI.Image:create()
    infoBg:init("ui_uncharted_bg_2.png")
    infoBg:leftUp(120, 10)
    self.viewContent:addChild(infoBg, 400)
    infoBg:setName("infoBg")
    self._infoArea = infoBg

    local textTile = UI.Text:create()
    -- text:init(UI.TEXT_221109, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_205_117_89)
    textTile:init(languageManagerInstance:getLocalString(self.data.name), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_136_172_191)
    textTile:setSize(80, 20)
    textTile:setTextCenter()
    textTile:autoAdapt()
    textTile:centerUp(5)
    infoBg:addChild(textTile)
    -- textTile:enableDebugDraw()

    local line = UI.Image:create()
    line:init("ui_uncharted_line.png")
    line:centerUp(27)
    infoBg:addChild(line)

    local icon = UI.Image:create()
    icon:init(self.data.icon..".png")
    icon:centerLeft(0)
    infoBg:addChild(icon)

    local text = UI.Text:create()
    -- text:init(UI.TEXT_221109, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_205_117_89)
    text:init(languageManagerInstance:getLocalString(self.data.des), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_136_172_191)
    text:setSize(200, 80)
    text:setTextLeft()
    text:autoAdapt()
    text:center(15, 10)
    infoBg:addChild(text)
    -- text:enableDebugDraw()

    infoBg:setTouchEnable(true)
    infoBg:setInterceptTouches(true)
    infoBg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, infoBg, function()
        if self._infoArea then
            self._infoArea:hide()
        end
    end)
end

function VoidRiftCurseBuffCellView:bindModel()

end


function VoidRiftCurseBuffCellView:unbindModel()

end





return VoidRiftCurseBuffCellView












