------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/06/25
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPraySwallowSettingView = class("StarPraySwallowSettingView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {}

local COM_WIDTH = 537
local COM_HEIGHT = 372
local layoutUU
function StarPraySwallowSettingView:ctor()
    StarPraySwallowSettingView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self:center()
    layoutUU = UIUtil:createAutoUILayout("StarPraySwallowSettingView", "app.modules.starpray.StarPrayPosConfig", false)
end

function StarPraySwallowSettingView:dtor()
    StarPraySwallowSettingView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.starpray.StarPraySwallowSettingView")
end

function StarPraySwallowSettingView:createCheckBoxWithLabel(text, isSelect, color)
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:enableAutoWidth()
    boxLayout:enableAutoHeight()

    local boxItself = UI.CheckBox:create()
    boxItself:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png")
    boxItself:floatLeft(0)
    boxItself:setValue(isSelect)
    boxLayout:addComponent(boxItself)

    local boxLabel = UI.Text:create()
    boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_22PX, color or UI.FONT_COLOR_41_41_45)
    boxLabel:floatLeft(9)
    boxLayout:addComponent(boxLabel)

    return boxLayout, boxItself
end

function StarPraySwallowSettingView:onInitView()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg._width, bg._height)

    local splitbg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png")
    splitbg:setContentSize(451, 232)
    addChildAuto(layoutUU, self, splitbg, "setting_split")

    local btn2 = UI.Button:create()
    btn2:init("ui_btn_yes1_1.png", "ui_btn_yes1_1.png", "ui_btn_yes1_1.png")
    btn2:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            local selectTags = {}
            for _, checkBox in pairs(self.checkboxs) do
                if checkBox:isChecked() then
                    table.insert(selectTags, checkBox.tag)
                end
            end
            mvc.send(mvc.events.StarPray_Swllow_SETTING_OK, selectTags)
        end
    )
    addChildAuto(layoutUU, self, btn2, "setting_btn2")
    local btn1 = UI.Button:create()
    btn1:init("ui_btn_no1_0.png", "ui_btn_no1_0.png", "ui_btn_no1_0.png")
    btn1:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function(self)
            mvc.send(mvc.events.StarPray_Swllow_SETTING_Cancel)
        end
    )
    addChildAuto(layoutUU, self, btn1, "setting_btn1")

    self.checkboxs = {}
    local setttingInfo, max = mvc.starPrayModel:getSwllowSettingInfo()
    for i = 1, max do
        local isSelect = false
        for j = 1, #setttingInfo do
            if i == tonumber(setttingInfo[j]) then
                isSelect = true
                break
            end
        end

        local text = UIUtil:lang(1112088 + i)
        local layout, checkBox = self:createCheckBoxWithLabel(text, isSelect, UI["FONT_COLOR_TITLE_RARE_"..i])
        checkBox.tag = i
        table.insert(self.checkboxs, checkBox)
        addChildAuto(layoutUU, self, layout, "setting_layout" .. i)
    end

    local text = UIUtil:createAdaptTextComponent(
        UIUtil:lang(1112375),
        UI.FONT_BOLD,
        UI.FONT_SIZE_26PX,
        UI.FONT_COLOR_41_41_41,
        400
    )
    addChildAuto(layoutUU, self, text, "setting_title","center")


end

function StarPraySwallowSettingView:bindModel()
end

function StarPraySwallowSettingView:unbindModel()
end

return StarPraySwallowSettingView
