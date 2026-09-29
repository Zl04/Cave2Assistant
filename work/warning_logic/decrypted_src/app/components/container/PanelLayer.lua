--[[--
   panel 层 只允许 存在一个 ui对象
   2020.10.19_hognyi.yan_panel层允许多个panel，每个panel有1个ui对象，只显示最上层panel，由panelMonitor管理
]]
local UILayer = import(".UILayer")
local PanelLayer = class("PanelLayer",UILayer)

local _single_view = nil

function PanelLayer:addView(view)
	-- if _single_view then
	-- 	if _single_view:isActive() then
	-- 		if not tolua.isnull(_single_view) then
	-- 			_single_view:close()
	-- 		end
	-- 	end
	-- 	_single_view = nil
	-- end
	-- _single_view = view

	PanelLayer.super.addView(self,view)
end

function PanelLayer:removeView(view)	
	PanelLayer.super.removeView(self,view)
	if _single_view == view then
		_single_view = nil
	end
end

function PanelLayer:remove()
	PanelLayer.super.remove(self)
	_single_view = nil
end

return PanelLayer