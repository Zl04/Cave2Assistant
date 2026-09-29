--[[
    测试工具  下拉菜单单元 2017/11/27
    修改基础：    
		Author: yueyingsong
		Date: 2017-11-20 17:52:55
		Using : 内购钻石界面cell
    by CMonk
]]


-- 模块初始化 --
---------------------------------------
require "app.ui.common.Layout"
require "app.ui.common.TableView.TableViewCell"

UI = UI or {}

local GMUtilDropDownCell = class("GMUtilDropDownCell", UI.TableViewCell)
UI.GMUtilDropDownCell = GMUtilDropDownCell
---------------------------------------
-- eo 模块初始化 --













-- 程序逻辑 --
---------------------------------------
-- 设置标签文字
function GMUtilDropDownCell:setText(string)
	assert(type(string) == "string")
	self._label:setText(string)
end

-- 设置大小
function GMUtilDropDownCell:setSize(width, height)
	assert(type(width) == "number" and width > 0)
	assert(type(height) == "number" and height > 0)

	self:setContentSize(cc.size(width, height))
	self:onUpdateView()
end

-- 获取大小
function GMUtilDropDownCell:getSize()
	local size = self:getContentSize()
	return size.width, size.height
end

-- 设置点击回调
function GMUtilDropDownCell:addClickCallback(func)
	self._onClickCallback = func
end

-- 设置自自定义背景颜色
function GMUtilDropDownCell:setBgColor(ccColor)
	assert(ccColor ~= nil)
	self._bgColor = ccColor
	self:onUpdateView()
end

-- 设置使用高亮背景颜色
function GMUtilDropDownCell:setBgHighlighted()
	self:setBgColor(self._bgColorHighlighted)
end

-- 设置使用普通背景颜色
function GMUtilDropDownCell:setBgNormal()
	self:setBgColor(self._bgColorNormal)
end
---------------------------------------
-- eo 程序逻辑 --











-- 事件处理 --
---------------------------------------

---------------------------------------
-- eo 事件处理 --












-- 生命周期 --
---------------------------------------
function GMUtilDropDownCell:ctor()
	GMUtilDropDownCell.super.ctor(self)	
	
	-- 初始化变量
	self._onClickCallback = nil
	self._bgColorNormal = cc.c4b(255,248,220,255)
	self._bgColorHighlighted = cc.c4b(255,215,0,255)
	self._bgColor = self._bgColorNormal

	-- 子控件
	self._clickDetector = nil
	self._label = nil
	self._bg = nil
end

function GMUtilDropDownCell:dtor()
	GMUtilDropDownCell.super.dtor(self)
end

function GMUtilDropDownCell:init(width, height, text)
	-- 先设置布局相关参数
	if (type(width) == "number" and width > 0 and 
		type(height)  == "number" and height > 0) then
		self:setSize(width, height)
	end

	-- 初始化布局
	self:onInitView()

	-- 初始化文字标签
	self:setText(text and text or "")
end

function GMUtilDropDownCell:onInitView( ... )
	local width, height = self:getSize()

	-- 暂用一个丑陋的点击检测， FIXME：用UI.Component包装一个TableViewCell
	self._clickDetector = UI.Layout:create()
	self._clickDetector:init()
	self._clickDetector:setTouchEnable(true)
	self._clickDetector:setSwallowTouches(false)
	self._clickDetector:setEnableMinTouchSize(false)
	self._clickDetector:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
		if(self._onClickCallback)then
			self._onClickCallback(self)
		end
	end)
	self:addChild(self._clickDetector, 1)

	-- 子组件背景
	self._bg = cc.LayerColor:create(self._bgColor, width, height)
	self:addChild(self._bg, 2)
	self._bg:setGlobalZOrder(1)

    -- 子组件文字栏
	self._label = UI.Text.create()
	self._label:init(self._text, UI.FONT_ARIAL, height, UI.FONT_COLOR_42_31_1)
	self:addChild(self._label, 3) 
	self._label._label:setGlobalZOrder(10)
end

function GMUtilDropDownCell:onUpdateView( ... )
	-- 更新组件大小和状态
	local width, height = self:getSize()
	self._bg:setContentSize(cc.size(width, height))
	self._bg:setPosition(cc.size(0, 0))
	self._bg:setColor(self._bgColor)

	self._label:setFontSize(height - 1)
	self._label:center()

	self._clickDetector:setSize(width, height)
	self._clickDetector:centerBottom(0)
end
---------------------------------------
-- eo 生命周期 --



return GMUtilDropDownCell