------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockLogView = class("DockLogView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 346
local COM_HEIGHT = 445

function DockLogView:ctor(data)
    DockLogView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function DockLogView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.dock", "Dock", false)
    DockLogView.super.init(self, ... )
end

function DockLogView:dtor()
    DockLogView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.dock.DockLogView")
end


function DockLogView:onInitView()
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(323, 431)
    panel:center()
    self:addChild(panel, 100)
    self.infoPanel = panel

    local bg = UI.Image:create()
    bg:init("ui_navigation_paper.png")
    bg:center()
    panel:addChild(bg)

    local xAdd = 0
    local yAdd = 0
    local title = UI.Text:create()
    local titleStr = self.data.title or UI.TEXT_221936
    title:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    panel:addChild(title) 
    title:centerUp(20)

    -- local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    -- line:setContentSize(282, 2)
    -- line:setCapInsets(CCRectMake(20,1,1,1))
    -- line:setPosition(160+xAdd, 373+yAdd)
    -- panel:addChild(line)

    local desc = UI.Text:create()
    desc:init(LanguageManager:getInstance():getLocalString(self.data.tips), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    desc:setWidth(280)
    desc:autoAdapt()
    desc:centerUp(1)

    local height = desc:getContentSize().height
    height = height < 320 and 320 or height
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(280, height)
    if height > 320 then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(290, 320)
        scrollView:init()
        scrollView:leftUp(25+xAdd, 67+yAdd)
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)    
    else
        layout:leftUp(25+xAdd, 67+yAdd)
        panel:addChild(layout)
    end
    layout:addChild(desc)

    local touch = UI.Component:create()
    touch:init()
    touch:setSize(310,410)
    touch:center()
    panel:addChild(touch)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function DockLogView:bindModel()

end


function DockLogView:unbindModel()

end





return DockLogView












