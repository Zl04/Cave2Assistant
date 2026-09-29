------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local GroupBattleLogView = class("GroupBattleLogView", UI.HWBtnComponent)
UI.GroupBattleLogView  = GroupBattleLogView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 242
local COM_HEIGHT = 110

function GroupBattleLogView:ctor(data)
    GroupBattleLogView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function GroupBattleLogView:init(...)
    GroupBattleLogView.super.init(self, ... )
end

function GroupBattleLogView:dtor()
    GroupBattleLogView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.ui.battlelayer.GroupBattleLogView")
end


function GroupBattleLogView:onInitView()
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(242, 110)
    panel:center()
    self:addChild(panel, 100)
    self.infoPanel = panel

    local bg = UI.Image:create()
    bg:init(self.data.bg)--("ui_reincarnation_fight_box3.png")
    bg:center()
    panel:addChild(bg)

    local xAdd = 0
    local yAdd = 0
    local title = UI.Text:create()
    title:init(self.data.title, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_218_196_94)
    panel:addChild(title) 
    title:centerUp(5)

    local img1 = UI.Image:create()
    img1:init("ui_reincarnation_fight_block.png")
    img1:centerLeft(-15)
    title:addChild(img1)

    local img2 = UI.Image:create()
    img2:init("ui_reincarnation_fight_block.png")
    img2:centerRight(-15)
    title:addChild(img2)

    -- local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    -- line:setContentSize(282, 2)
    -- line:setCapInsets(CCRectMake(20,1,1,1))
    -- line:setPosition(160+xAdd, 373+yAdd)
    -- panel:addChild(line)

    local desc = UI.Text:create()
    desc:init(LanguageManager:getInstance():getLocalString(self.data.tips), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_219_214_192)
    desc:setWidth(200)
    desc:autoAdapt()
    desc:centerUp(30)

    local height = desc:getContentSize().height
    height = height < 50 and 50 or height
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(200, height)
    if height > 50 then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(200, 50)
        scrollView:init()
        -- scrollView:leftUp(25+xAdd, 67+yAdd)
        scrollView:centerUp(30)
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        panel:addChild(scrollView)    
        scrollView:enableDebugDraw()
    else
        -- layout:leftUp(25+xAdd, 67+yAdd)
        layout:centerUp(0)
        panel:addChild(layout)
    end
    layout:addChild(desc)

    local touch = UI.Component:create()
    touch:init()
    touch:setSize(200, 50)
    touch:center()
    panel:addChild(touch)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)

    local confirmBtn = UI.Button:create();
    confirmBtn:init("ui_reincarnation_btn2.png","ui_reincarnation_btn2.png","ui_reincarnation_btn2.png");
    confirmBtn:centerBottom(5)
    confirmBtn:setText(UI.TEXT_1170211)
    confirmBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_64_60_50)
    confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onClick)
    panel:addChild(confirmBtn, 310)
end

function GroupBattleLogView:onClick()
    cc.UserDefault:getInstance():setBoolForKey("battleDesHasRead", true)
    self:close()
end

function GroupBattleLogView:bindModel()

end


function GroupBattleLogView:unbindModel()

end





return GroupBattleLogView












