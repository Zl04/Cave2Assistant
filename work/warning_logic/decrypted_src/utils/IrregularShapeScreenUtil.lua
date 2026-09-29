require "app.ui.UIDefine"

Avalon = Avalon or {}

local irregularShapeScreenUtil = {}
Avalon.irregularShapeScreenUtil = irregularShapeScreenUtil
Avalon.issUtil = irregularShapeScreenUtil

local safeRect = cc.Director:getInstance():getSafeAreaRect()

local autoAdjustmentList = {}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

function irregularShapeScreenUtil:updateSafeRect()
	safeRect = cc.Director:getInstance():getSafeAreaRect()
end

function irregularShapeScreenUtil:isIphoneX()
	local iphoneX = false
	-- local safeRect = cc.Director:getInstance():getSafeAreaRect()
	if (CONFIG_ACTUAL_WIDTH == 2436 and CONFIG_ACTUAL_HEIGHT == 1125 and safeRect.x ~= 0) then -- 水果X特殊处理
		iphoneX = true
	end
	return iphoneX;
end

--长宽比类似 Iphonex的
function irregularShapeScreenUtil:isLikeIphoneX()
	local iphoneX = false
	-- local safeRect = cc.Director:getInstance():getSafeAreaRect()
	if (CONFIG_ACTUAL_WIDTH / CONFIG_ACTUAL_HEIGHT >= 2436 / 1125) then -- 水果X特殊处理
		iphoneX = true
	end
	return iphoneX;
end

function irregularShapeScreenUtil:getSafeAreaRect()
	-- local safeRect = cc.Director:getInstance():getSafeAreaRect()
	local tmpSafeRect = {}
	tmpSafeRect.x = safeRect.x
	tmpSafeRect.y = safeRect.y
	tmpSafeRect.width = safeRect.width
	tmpSafeRect.height = safeRect.height
	if (CONFIG_ACTUAL_WIDTH == 2436 and CONFIG_ACTUAL_HEIGHT == 1125 and safeRect.x ~= 0) then -- 水果X特殊处理
		local xOffset = 15
		local bottomOffset = 25
		tmpSafeRect.width = tmpSafeRect.width + xOffset * 2
		tmpSafeRect.x = tmpSafeRect.x - xOffset
		tmpSafeRect.height = self:getVisibleRect().height - bottomOffset
		tmpSafeRect.y = bottomOffset
	end

	-- local safeRect = {width = 1246, height = 570, x = 70, y = 35}
	return tmpSafeRect
	-- return self:getVisibleRect()
end

function irregularShapeScreenUtil:getVisibleRect()
	local size = cc.Director:getInstance():getVisibleSize()
	local origin = cc.Director:getInstance():getVisibleOrigin()
	local rect = {
		x = origin.x,
		y = origin.y,
		width = size.width,
		height = size.height
	}
	return rect
end

function irregularShapeScreenUtil:getRightEdgeXForNode(node, isIssAdjusted)
	if (isIssAdjusted == nil) then isIssAdjusted = true end
	local parent = node:getParent()
	if (parent) then
		-- 如果有父节点, 用父节点做转换
		local worldRightEdgeX = winSize.width
		if (isIssAdjusted) then 
			worldRightEdgeX = winSize.width - self:getRightMargin() 
		end
		return parent:convertToNodeSpace(cc.p(worldRightEdgeX, 0)).x
	else
		-- 如果没有父节点, 把窗口大小作为父节点大小
		if (isIssAdjusted) then 
			return winSize.width
		else
			return winSize.width - self:getRightMargin()
		end
	end
end

function irregularShapeScreenUtil:getLeftEdgeXForNode(node, isIssAdjusted)
	if (isIssAdjusted == nil) then isIssAdjusted = true end
	local parent = node:getParent()
	if (parent) then
		-- 如果有父节点, 用父节点做转换
		local worldLeftEdgeX = 0
		if (isIssAdjusted) then
			worldLeftEdgeX = self:getLeftMargin() 
		end
		return parent:convertToNodeSpace(cc.p(worldLeftEdgeX, 0)).x
	else
		-- 如果没有父节点, 把窗口大小作为父节点大小
		if (isIssAdjusted) then 
			return 0
		else
			return self:getLeftMargin()
		end
	end
end

function irregularShapeScreenUtil:getRightMargin()
	local rect = self:getSafeAreaRect()
	local rightMargin = self:getVisibleRect().width - (rect.x + rect.width)
	return self:gt0(rightMargin >= 0 and rightMargin or 0)
end

function irregularShapeScreenUtil:getLeftMargin()
	local deviceName = AvalonUtil.getDeviceName()
	-- 华为Nova4的特殊处理
	if self:getReturn0() then
		return 0
	end

	return self:gt0(self:getSafeAreaRect().x)
end

function irregularShapeScreenUtil:getBottomMargin()
	return self:gt0(self:getSafeAreaRect().y)
end

function irregularShapeScreenUtil:getTopMargin()
	local rect = self:getSafeAreaRect()
	return self:gt0(self:getVisibleRect().height - (rect.y + rect.height))
end

function irregularShapeScreenUtil:getWidthOffset()
	local deviceName = AvalonUtil.getDeviceName()
	-- 华为Nova4的特殊处理
	if self:getReturn0() then
		return 0
	end

	local rect = self:getSafeAreaRect()
	return self:gt0(self:getVisibleRect().width - rect.width)
end

function irregularShapeScreenUtil:getHeightOffset()
	local rect = self:getSafeAreaRect()
	return self:gt0(self:getVisibleRect().height - rect.height)
end

function irregularShapeScreenUtil:getCornerMargin()
	if (self:getLeftMargin() > 0) then
		return 20
	else
		return 0
	end
end

function irregularShapeScreenUtil:registerAutoAdjustment(target, side, useCornerMargin)
	if (useCornerMargin == nil) then useCornerMargin = false end

	self:registerAutoAdjustmentFunc(target, function(entry)
		if (side == "lt") then
			target:leftUp(
				entry.l + (useCornerMargin and self:getCornerMargin() or self:getLeftMargin()), 
				entry.t + (useCornerMargin and self:getCornerMargin() or self:getTopMargin())
			)
		elseif(side == "lb") then
			target:leftBottom(
				entry.l + (useCornerMargin and self:getCornerMargin() or self:getLeftMargin()), 
				entry.b + (useCornerMargin and self:getCornerMargin() or self:getBottomMargin())
			)
		elseif(side == "rt") then
			target:rightUp(
				entry.r + (useCornerMargin and self:getCornerMargin() or self:getRightMargin()), 
				entry.t + (useCornerMargin and self:getCornerMargin() or self:getTopMargin())
			)
		elseif(side == "rb") then
			target:rightBottom(
				entry.r + (useCornerMargin and self:getCornerMargin() or self:getRightMargin()), 
				entry.b + (useCornerMargin and self:getCornerMargin() or self:getBottomMargin())
			)
		elseif (side == "l-t") then
			target:leftUp(
				entry.l + (useCornerMargin and self:getCornerMargin() or self:getLeftMargin()), 
				entry.t
			)
		elseif(side == "l-b") then
			target:leftBottom(
				entry.l + (useCornerMargin and self:getCornerMargin() or self:getLeftMargin()), 
				entry.b
			)
		elseif(side == "r-t") then
			target:rightUp(
				entry.r + (useCornerMargin and self:getCornerMargin() or self:getRightMargin()), 
				entry.t
			)
		elseif(side == "r-b") then
			target:rightBottom(
				entry.r + (useCornerMargin and self:getCornerMargin() or self:getRightMargin()), 
				entry.b
			)
		elseif (side == "-lt") then
			target:leftUp(
				entry.l, 
				entry.t + (useCornerMargin and self:getCornerMargin() or self:getTopMargin())
			)
		elseif(side == "-lb") then
			target:leftBottom(
				entry.l, 
				entry.b + (useCornerMargin and self:getCornerMargin() or self:getBottomMargin())
			)
		elseif(side == "-rt") then
			target:rightUp(
				entry.r, 
				entry.t + (useCornerMargin and self:getCornerMargin() or self:getTopMargin())
			)
		elseif(side == "-rb") then
			target:rightBottom(
				entry.r, 
				entry.b + (useCornerMargin and self:getCornerMargin() or self:getBottomMargin())
			)
		end
	end)
end

function irregularShapeScreenUtil:registerAutoAdjustmentFunc(target, callback, callnow, autoUnregisterForcomponent)
	-- 检查是否存在相同项(同一目标, 同一方法), 有则不做任何事情
	if (nil ~= self:getEntry(target, callback)) then return end

	-- 处理参数
	if (callnow == nil) then callnow = true end
	if (autoUnregisterForcomponent == nil) then autoUnregisterForcomponent = true end

	-- 查找如果有已存在目标, 从列表中取原位置, 如果没有目标则从目标上获取位置
	local entry = self:getEntry(target)

	local x, y = 0, 0
	local t, r, b, l = 0, 0, 0, 0
	if (entry ~= nil) then
		x, y = entry.x, entry.y
		t, r, b, l = entry.t, entry.r, entry.b, entry.l
	else
		x, y = target:getPos()
		t, r, b, l = target:getUp(), target:getRight(), target:getBottom(), target:getLeft() 
	end

	-- 新建并添加项
	local entry = {
		target = target,
		callback = callback,
		x = x,
		y = y,
		t = t,
		r = r,
		b = b,
		l = l
	}
	table.insert(autoAdjustmentList, entry)

	-- 处理后续
	if (callnow and callback) then callback(entry) end
	if (autoUnregisterForcomponent) then
		target:addEventListener(UIEvent.EVENT_CLEANUP, target, function()
			self:unregisterAutoAdjustment(target)
		end)
	end
end

function irregularShapeScreenUtil:unregisterAutoAdjustment(target)
	for i = #autoAdjustmentList, 1, -1 do
        local v = autoAdjustmentList[i]
		if (v.target == target) then
			table.remove(autoAdjustmentList, i)
		end
	end
end

function irregularShapeScreenUtil:getEntry(target, callback)
	for i,v in ipairs(autoAdjustmentList) do
		if (v.target == target and (callback == nil or v.callback == callback)) then
			return v
		end
	end
	return nil
end

-- 大于0返回输入数值, 小于0就返回0
function irregularShapeScreenUtil:gt0(number)
	return number > 0 and number or 0
end

function irregularShapeScreenUtil:getReturn0()
	local deviceName = AvalonUtil.getDeviceName()
	-- 华为Nova4的特殊处理
	if deviceName == "VCE-AL00" 
		or deviceName == "V2002A" then
		if(deviceName == "V2002A" and self.sendBugInfo == nil) then
			self.sendBugInfo = true

			local size = cc.Director:getInstance():getVisibleSize()
			local origin = cc.Director:getInstance():getVisibleOrigin()
			
			local str = ""
			str = str .. string.format(" visibleSize width=%d, height=%d", size.width, size.height)
			str = str .. string.format(" VisibleOrigin x=%d, y=%d", origin.x, origin.y)
			str = str .. string.format(" safeRect x=%d, y=%d,width=%d, height=%d", safeRect.x, safeRect.y,safeRect.width, safeRect.height)
			str = str .. string.format(" winSize width=%d, height=%d", winSize.width, winSize.height)
			buglyReportLuaException("irregularShapeScreenUtil error adapter", str)
		end

		return true
	end

	return false
end

return irregularShapeScreenUtil