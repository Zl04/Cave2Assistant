--[[
    UI - 属性描述
]]--

require "app.ui.Component"

UI = UI or {}

local AttributeDes = class("AttributeDes", UI.HWBtnComponent)
UI.AttributeDes = AttributeDes

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 100
local COM_HEIGHT = 20
-- 背包资源
local COM_RES_LIST = {
    
}

-- 构造函数
function AttributeDes:ctor()
    AttributeDes.super.ctor(
        self, 
        UIType.ATTRIBUTE_DES, 
        COM_RES_LIST, 
        COM_WIDTH, 
        COM_HEIGHT
    )

    self._attriName = nil
    self._attriValue = nil
    self._attriLabel = nil
end

-- 析构函数
function AttributeDes:dtor()
    self._attriName = nil
    self._attriValue = nil
    self._attriLabel = nil

    AttributeDes.super.dtor(self)
end

-- public:
-- 初始化
function AttributeDes:init(attriName, attriValue)
    self._attriName = attriName or ""
    self._attriValue = attriValue or ""

    AttributeDes.super.init(self)
end

-- 初始化视图
function AttributeDes:onInitView()
    local attriNameLabel = cc.Label:createWithSystemFont(string.format("%s:%s", self._attriName, self._attriValue), UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
    attriNameLabel:setAnchorPoint(0, 0)
    self:addChild(attriNameLabel)

    self._attriLabel = attriNameLabel
end

-- 更新视图
function AttributeDes:onUpdateView(attriValue)
    self._attriLabel:setString(string.format("%s", attriValue))
end
