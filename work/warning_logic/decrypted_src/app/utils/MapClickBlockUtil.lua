
-- TODO 目前用这种效率比较低但是很可靠的渲染树搜索方法来实现
--      如果需要压榨效率的话可以改为使用开关状态跟踪来处理
require "app.ui.UIManager"

MapClickBlockUtil = MapClickBlockUtil or {}

function MapClickBlockUtil:isBlocked()
	if (self:isDialogBlocking() or self:isIndicatorBlocking()) then
		return true
	end
	return false
end

function MapClickBlockUtil:isDialogBlocking()
	if (not self:_getObjFromTopActivityLayerByName("pNpcDialog")) then
		return false
	end
	return true
end

function MapClickBlockUtil:isIndicatorBlocking()
	if (not self:_getObjFromTopActivityLayerByName("pIndicateUILayer")) then
		return false
	end
	return true
end

function MapClickBlockUtil:_getObjFromTopActivityLayerByName(name)
	local topActivityLayer = UI.UIManager.mTopActivityLayer
	if (not topActivityLayer or not topActivityLayer.rootLayer) then return nil end
	return topActivityLayer.rootLayer:getChildByName(name)
end

return MapClickBlockUtil
