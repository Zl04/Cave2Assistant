-- TitleData.lua
-- Author: CMonk
-- 2018-9-11
-- 称号数据结构

require "app.datas.goods.VirtualData"
require "app.utils.PlaceholderUtil"
local LanguageManager = require("app.game.LanguageManager")

local TitleData = class("TitleData", Goods.VirtualData)

Data = Data or {}
Data.TitleData = TitleData

local GOODS_RARE = PublicDefine.GOODS_RARE

-- 构造函数
function TitleData:ctor(titleID, param,endTime)
	self._param = param
	self._endTime = endTime
    TitleData.super.ctor(self, titleID)
end

-- 设置参数
function TitleData:setParam(param)
	self._param = param
end

-- 返回称号ID
function TitleData:getTitleID()
    return self:getId()
end

function TitleData:getEndTime()
	return self._endTime
end

-- 返回称号名称
function TitleData:getTitleName()
	local name = self:getName()
	if(name == nil) then 
		name = ""
	end

	local funType = self:getTitleFunctionType()
	if (funType == 51 and self._param) then
		name = string.format(name, self._param)
	end

    return name
end

-- 返回称号解释
function TitleData:getTitleDescription()
    return self:geteffecDescription()
end

-- 返回称号颜色
function TitleData:getTitleColor()
	local color = UI.FONT_COLOR_WHITE
	local rare = self:getGoodsRare()
	if (not rare) then return color end

	if (rare == PublicDefine.GOODS_RARE.RARE_WHITE_1) then
		color = UI.FONT_COLOR_TITLE_RARE_1
	elseif (rare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
		color = UI.FONT_COLOR_TITLE_RARE_2
	elseif (rare == PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
		color = UI.FONT_COLOR_TITLE_RARE_3
	elseif (rare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
		color = UI.FONT_COLOR_TITLE_RARE_4
	elseif (rare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5) then
		color = UI.FONT_COLOR_TITLE_RARE_5
	elseif (rare == PublicDefine.GOODS_RARE.RARE_DARKRED) then
		color = UI.FONT_COLOR_TITLE_RARE_6
	end

    return color
end

-- 获取功能号
function TitleData:getTitleFunctionType()
	local funStr = self.value1:gsub("\"", "")
    return tonumber(funStr)
end