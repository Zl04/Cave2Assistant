--[[
    用Button简装一个CheckBox组件 2017/11/29
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.common.Button"

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local CheckBox = class("CheckBox", UI.Button)
UI.CheckBox = CheckBox

-- 勾选状态
UI.CheckBoxState = {
    CHECKED = 2,   -- 勾选
    UNCHECKED = 3,  -- 释放
}
CheckBoxState = UI.CheckBoxState

-- 私有变量
-- local DEBUG_DRAW = true
---------------------------------------
-- eo 模块初始化 --











-- 程序逻辑 --
---------------------------------------
function CheckBox:isChecked()
    return self._checkBoxState == UI.CheckBoxState.CHECKED
end

function CheckBox:setValue(b, isToDispatchEvents, isByTouch)
    if (isByTouch == nil) then isByTouch = false end
    if ((self:isChecked() and b) or (not self:isChecked() and not b)) then return end
    if (b) then
        self:check(isToDispatchEvents, isByTouch)
    else
        self:uncheck(isToDispatchEvents, isByTouch)
    end
end

function CheckBox:uncheck(isToDispatchEvents, isByTouch)
    if (isToDispatchEvents == nil) then isToDispatchEvents = true end
    self._checkBoxState = UI.CheckBoxState.UNCHECKED
    self:release()

    if (isToDispatchEvents) then
        self:dispatchEvent(UIEvent.CHECKBOX_UNCHECKED, self, isByTouch)
        self:dispatchEvent(UIEvent.CHECKBOX_STATUS_CHANGED, self, false, isByTouch)
    end
end

function CheckBox:check(isToDispatchEvents, isByTouch)
    if (isToDispatchEvents == nil) then isToDispatchEvents = true end
    self._checkBoxState = UI.CheckBoxState.CHECKED
    self:press()

    if (isToDispatchEvents) then
        self:dispatchEvent(UIEvent.CHECKBOX_CHECKED, self, isByTouch)
        self:dispatchEvent(UIEvent.CHECKBOX_STATUS_CHANGED, self, true, isByTouch)
    end
end
---------------------------------------
-- eo 程序逻辑 --








-- 生命周期 --
---------------------------------------
-- 构造函数
function CheckBox:ctor(...)
    CheckBox.super.ctor(self, ...)
    self:registerListener()
    self._checkBoxState = UI.CheckBoxState.UNCHECKED
end

-- 初始化
function CheckBox:init(normalBgName, activeBgName, diabledBgName, checkedPicName, bgDisplayScale)
    CheckBox.super.init(self, normalBgName, activeBgName, diabledBgName, nil, bgDisplayScale)

    if (checkedPicName) then
        local checkedPic = UI.Image:create()
        checkedPic:init(checkedPicName)
        checkedPic:center()
        self:setSelectedNode(checkedPic)
    end
end


-- 析构函数
function CheckBox:dtor(...)
    CheckBox.super.dtor(self, ...)
    self:unregisterListener()
end

-- 初始化视图
function CheckBox:onInitView(...)
    CheckBox.super.onInitView(self, ...)
end

-- 更新视图
function CheckBox:onUpdateView(...)
    CheckBox.super.onUpdateView(self, ...)
end
---------------------------------------
-- eo 生命周期 --








-- 事件处理 --
---------------------------------------

-- 注册监听事件
function CheckBox:registerListener()
    self:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if (self._checkBoxState == UI.CheckBoxState.CHECKED) then
            self:uncheck(nil, true)
        elseif (self._checkBoxState == UI.CheckBoxState.UNCHECKED) then
            self:check(nil, true)
        end
    end)
end


-- 注销监听事件
function CheckBox:unregisterListener()

end

---------------------------------------
-- eo 事件处理 --