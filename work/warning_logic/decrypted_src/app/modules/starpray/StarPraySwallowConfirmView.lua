------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPraySwallowConfirmView = class("StarPraySwallowConfirmView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 429
local COM_HEIGHT = 287
local layoutUU
function StarPraySwallowConfirmView:ctor()
    self._overflowExp = 0
    StarPraySwallowConfirmView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:center()
    layoutUU = UIUtil:createAutoUILayout("StarPraySwallowConfirmView","app.modules.starpray.StarPrayPosConfig", false)
end

function StarPraySwallowConfirmView:dtor()
    StarPraySwallowConfirmView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.starpray.StarPraySwallowConfirmView")
end


function StarPraySwallowConfirmView:onInitView()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg._width, bg._height)

    local splitbg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png")
    splitbg:setContentSize(369, 125)
    addChildAuto(layoutUU, self, splitbg, "swsc_split")

    local btn2 = UI.Button:create()
    btn2:init("ui_btn_yes1_1.png", "ui_btn_yes1_1.png", "ui_btn_yes1_1.png")
    btn2:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            mvc.send(mvc.events.StarPray_Swallow_Confirm, true)
        end
    )
    addChildAuto(layoutUU, self, btn2, "swsc_btn2")
    local btn1 = UI.Button:create()
    btn1:init("ui_btn_no1_0.png", "ui_btn_no1_0.png", "ui_btn_no1_0.png")
    btn1:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            mvc.send(mvc.events.StarPray_Swallow_Confirm, false)
        end
    )
    addChildAuto(layoutUU, self, btn1, "swsc_btn1")

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    local settings = mvc.starPrayModel:getSwllowSettingInfo()
    for _,idx in pairs(settings) do
        local i = tonumber(idx)
        local text = UIUtil:lang(1112088 + i)
        local boxLabel = UI.Text:create()
        boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI["FONT_COLOR_TITLE_RARE_"..i] or UI.FONT_COLOR_41_41_45)
        boxLabel:floatLeft(9)
        boxLabel:setOutline(UI.FONT_COLOR_BLACK)
        layout:addComponent(boxLabel)
    end
    addChildAuto(layoutUU, self, layout, "swsc_layout", "center")


    local boxStr = UIUtil:lang(1112376)

    mvc.send(mvc.events.StarPray_Swallow_Overflow)

    if self._overflowExp > 0 then
        boxStr = string.format(UI.TEXT_1212475,tostring(self._overflowExp))
    end


    local boxLabel = UI.Text:create()
    boxLabel:init(boxStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX,  UI.FONT_COLOR_41_41_45)
    boxLabel:setWidth(330)
    addChildAuto(layoutUU, self, boxLabel, "swsc_desc", "center")
end


function StarPraySwallowConfirmView:bindModel()

end


function StarPraySwallowConfirmView:unbindModel()

end





return StarPraySwallowConfirmView












