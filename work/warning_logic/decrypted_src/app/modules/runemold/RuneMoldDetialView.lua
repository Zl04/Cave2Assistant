------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RuneMoldDetialView = class("RuneMoldDetialView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 312
local COM_HEIGHT = 329

function RuneMoldDetialView:ctor(data)
    RuneMoldDetialView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function RuneMoldDetialView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.runemold", "RuneMold", false)
    RuneMoldDetialView.super.init(self, ... )
end

function RuneMoldDetialView:dtor()
    RuneMoldDetialView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.runemold.RuneMoldDetialView")
end


function RuneMoldDetialView:onInitView()
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(COM_WIDTH, COM_HEIGHT)
    panel:center()
    self:addChild(panel, 100)
    self.infoPanel = panel

    local bg = UI.Image:create()
    bg:init(self.data.bg)
    bg:center()
    panel:addChild(bg)

    local xAdd = 0
    local yAdd = 0
    local title = UI.Text:create()
    title:init(self.data.title, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_154_154_154)
    panel:addChild(title) 
    title:centerUp(20)

    local desc = UI.Text:create()
    desc:init(LanguageManager:getInstance():getLocalString(self.data.tips), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_48_46_46)
    desc:setWidth(200)
    desc:autoAdapt()
    desc:center()

    local layoutHeight = COM_HEIGHT - 90
    local layoutWidth = COM_WIDTH - 80

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
        scrollView:centerUp(70)
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)    
    else
        -- layout:leftUp(25+xAdd, 67+yAdd)
        layout:centerUp(70)
        panel:addChild(layout)
    end
    layout:addChild(desc)

    self:setTouchEnable(true)
    -- self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end


function RuneMoldDetialView:bindModel()

end


function RuneMoldDetialView:unbindModel()

end





return RuneMoldDetialView












