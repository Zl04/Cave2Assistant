require "app.ui.common.CheckBox"

UI = UI or {}
local SettingPanelBase = class("SettingPanelBase", UI.HWBtnComponent)
UI.SettingPanelBase = SettingPanelBase

function SettingPanelBase:createCheckBoxWithLabel(text, initialStateFunc, cb)
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:enableAutoWidth()
    boxLayout:enableAutoHeight()

    local boxItself = UI.CheckBox:create() 
    boxItself:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png")
    boxItself:floatLeft(0)
    boxItself:setValue(initialStateFunc and initialStateFunc(boxLayout) or false)
    boxItself:setName("boxItself")
    boxLayout:addComponent(boxItself)
    boxItself:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked, isByTouch)
        if (cb) then cb(isChecked, boxLayout, comp, isByTouch) end
    end)

    local boxLabel = UI.Text:create()
    boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    boxLabel:setWidth(240)
    boxLabel:setTextLeft()
    boxLabel:autoAdapt()
    boxLabel:setLineSpacing(-6)
    boxLabel:floatLeft(9)
    boxLayout:addComponent(boxLabel)

    return boxLayout
end