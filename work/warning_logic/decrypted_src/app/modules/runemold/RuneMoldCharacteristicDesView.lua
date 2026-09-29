------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RuneMoldCharacteristicDesView = class("RuneMoldCharacteristicDesView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 312
local COM_HEIGHT = 329

function RuneMoldCharacteristicDesView:ctor(data)
    RuneMoldCharacteristicDesView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function RuneMoldCharacteristicDesView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.runemold", "RuneMold", false)
    RuneMoldCharacteristicDesView.super.init(self, ... )
end

function RuneMoldCharacteristicDesView:dtor()
    RuneMoldCharacteristicDesView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.runemold.RuneMoldCharacteristicDesView")
end


function RuneMoldCharacteristicDesView:onInitView()
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

    local layoutHeight = COM_HEIGHT - 250
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


    local line = UI.Image:create()
    line:init("ui_mold_line.png")
    line:center(0, 20)
    panel:addChild(line)
    self.line = line
    line:hide()

    local nextLevelTitle = UI.Text:create()
    nextLevelTitle:init(UI.TEXT_224713, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_48_46_46)
    nextLevelTitle:center(0, 5)
    panel:addChild(nextLevelTitle) 
    self.nextLevelTitle = nextLevelTitle
    nextLevelTitle:hide()

    local nextLevelDes = UI.Text:create()
    nextLevelDes:init(LanguageManager:getInstance():getLocalString(self.data.nextText), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_48_46_46)
    nextLevelDes:setWidth(200)
    nextLevelDes:autoAdapt()
    nextLevelDes:center()
    self.nextLevelDes = nextLevelDes
    nextLevelDes:hide()

    local height = nextLevelDes:getContentSize().height
    -- height = height < 50 and 50 or height
    local nextLevelLayout = UI.Layout:create()
    nextLevelLayout:init()
    nextLevelLayout:setSize(layoutWidth, height)
    -- nextLevelLayout:enableDebugDraw()
    self.nextLevelLayout = nextLevelLayout
    nextLevelLayout:hide()
    
    if height >= layoutHeight then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(layoutWidth, layoutHeight)
        scrollView:init()
        -- scrollView:leftUp(25+xAdd, 67+yAdd)
        scrollView:centerUp(195)
        scrollView:addInnerNode(nextLevelLayout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)
        -- self.scrollView = scrollView
    else
        -- layout:leftUp(25+xAdd, 67+yAdd)
        nextLevelLayout:centerUp(195)
        panel:addChild(nextLevelLayout)
    end
    nextLevelLayout:addChild(nextLevelDes)

    local unlockDes = UI.Text:create()
    unlockDes:init(UI.TEXT_224710, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_72_17_9)
    panel:addChild(unlockDes) 
    unlockDes:leftBottom(40, 20)
    self.unlockDes = unlockDes

    self:setTouchEnable(true)
    -- self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)

    self:updateDetailView()
end

function RuneMoldCharacteristicDesView:updateDetailView()
    if self.data.isActive and not self.data.isMaxLevel then
        self.nextLevelTitle:show()
        self.nextLevelDes:show()
        self.nextLevelLayout:show()
        self.line:show()
        -- self.unlockDes:show()
        local str = string.format(UI.TEXT_224712, self.data.activeLevel+1)
        self.unlockDes:setText(string.format(UI.TEXT_224710, str))
    elseif not self.data.isActive then
        self.unlockDes:setText(string.format(UI.TEXT_224710, UI.TEXT_224711))
    elseif self.data.isMaxLevel then
        self.unlockDes:hide()
    end
end 

function RuneMoldCharacteristicDesView:bindModel()

end


function RuneMoldCharacteristicDesView:unbindModel()

end





return RuneMoldCharacteristicDesView












