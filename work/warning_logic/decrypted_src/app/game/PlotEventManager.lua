-- PlotEventManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:事件工厂
require("utils.reload")
local LoadingLayer = require "app.scene.loadingscene.LoadingLayer"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local PlotEventManager = class("PlotEventManager")
require "app.datas.plot.PlotEventData"
require "app.config.ConfigManager"
g_PlotEventManager = nil;

local DEBUG = false

function PlotEventManager:ctor()
	self.plotEventList = {}
end


function PlotEventManager:getInstance()
	if g_PlotEventManager == nil then
		g_PlotEventManager = PlotEventManager.new()
	end
	return g_PlotEventManager;
end


function PlotEventManager:purgeInstance()
	if g_PlotEventManager ~= nil then
		g_PlotEventManager = nil;
	end
end



function PlotEventManager:runEventByID(id)
	if(DEBUG) then
		print("PlotEventManager:runEventByID",id)
	end
	local pPlotEventConfig = ConfigManager:getPlotEventForPlotEventID(id)
	if pPlotEventConfig then

	    local pPlotEventData = Data.PlotEventData:create()
	    pPlotEventData:initNet(pPlotEventConfig)
	    self:runEvent(pPlotEventData)
	else
		assert(false,"PlotEventManager:runEventByID PlotEvent not found by "..id)
	end
end

function PlotEventManager:runEvent(plotEventData)
	if(DEBUG) then
		print("PlotEventManager:runEvent",plotEventData:getType())
	end
	--抖动
	if plotEventData:getType() == 1 then

		Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, tonumber(plotEventData:getParam()[1]), tonumber(plotEventData:getParam()[2])/1000.0)
	--屏幕移动
	elseif plotEventData:getType() == 2 then
		local centerCoordX = tonumber(plotEventData:getParam()[1] or 0)
		local centerCoordY = tonumber(plotEventData:getParam()[2] or 0)
		local _time = tonumber(plotEventData:getParam()[3]/1000.0 or 1)

		if (AvalonUtil:moveCameraToCoord(centerCoordX, centerCoordY, _time, plotEventData.plotEventDataID)) then -- true = 移动成功
			plotEventData.actionID = plotEventData.plotEventDataID
		end
	--屏幕回归
	elseif plotEventData:getType() == 3 then
		local _time = tonumber(plotEventData:getParam()[1]/1000.0 or 1)

		-- 回归主角
		if (AvalonUtil:moveCameraToMaster(_time)) then -- true = 移动成功
			plotEventData.actionID = plotEventData.plotEventDataID
		end

	--屏蔽层
	elseif plotEventData:getType() == 4 then
		local scene = cc.Director:getInstance():getRunningScene()
		if tonumber(plotEventData:getParam()[1]) == 1 then
			local pShieldingLayer = scene:getChildByName("shieldingLayerByPlotEvent")
			if not pShieldingLayer then
		        require("app.ui.shieldingLayer.ShieldingLayer")
		        pShieldingLayer = UI.ShieldingLayer:create(100000)
		        pShieldingLayer:center()
		        pShieldingLayer:setName("shieldingLayerByPlotEvent")
		        cc.Director:getInstance():getRunningScene():addChild(pShieldingLayer,10000);
			end
			pShieldingLayer:setSwallowTouches(true);
		else
			local pShieldingLayer = scene:getChildByName("shieldingLayerByPlotEvent")
			if pShieldingLayer then
		        pShieldingLayer:setSwallowTouches(false);
			end
		end
	--显示隐藏主UI
	elseif plotEventData:getType() == 5 then
		if tonumber(plotEventData:getParam()[1]) == 1 then
			Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,nil, tonumber(plotEventData:getParam()[2]/1000.0))
		else
			Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER,nil, tonumber(plotEventData:getParam()[2]/1000.0))
		end
	--宽屏
	elseif plotEventData:getType() == 6 then
		local scene = cc.Director:getInstance():getRunningScene()
		if tonumber(plotEventData:getParam()[1]) == 1 then
			local pWideScreenLayer = scene:getChildByName("WideScreenLayer")
			if not pWideScreenLayer then
	            require("app.ui.wideScreenLayer.WideScreenLayer")
	            pWideScreenLayer = UI.WideScreenLayer:create(tonumber(plotEventData:getParam()[2]))
	            cc.Director:getInstance():getRunningScene():addChild(pWideScreenLayer,200000);
			end
			pWideScreenLayer:showWideScreenLayer(tonumber(plotEventData:getParam()[2]/1000.0));
		else
			local pWideScreenLayer = scene:getChildByName("WideScreenLayer")
			if pWideScreenLayer then
		        pWideScreenLayer:hideWideScreenLayer(tonumber(plotEventData:getParam()[2]/1000.0));
			end
		end
	--场景spine动画
	elseif plotEventData:getType() == 7 then
		if(MachineManager:getInstance():getMachine() 
			and MachineManager:getInstance():getMachine()._view
			and MachineManager:getInstance():getMachine()._view._map 
			and MachineManager:getInstance():getMachine()._view._map.getDecoration) then
				
			local _map = MachineManager:getInstance():getMachine()._view._map
			local _decoration = _map:getDecoration(plotEventData:getParam()[1],
				tonumber(plotEventData:getParam()[2]),tonumber(plotEventData:getParam()[3]))

			if _decoration then
				if tonumber(plotEventData:getParam()[5]) == 1 then
					_decoration:runAnim(plotEventData:getParam()[4],true)
				else
					_decoration:runAnim(plotEventData:getParam()[4],false)
				end
				-- print("plotEventData:getParam()[4]=", plotEventData:getID(), plotEventData:getParam()[4])
				if((plotEventData:getID() == 8000739 
					or plotEventData:getID() == 8000740
					or plotEventData:getID() == 8000741
					or plotEventData:getID() == 8000742) and _decoration:getNode()) then 
					if(plotEventData:getParam()[4] == "loop") then 
						local progressLayout = _decoration:getNode():getChildByName("progressLayout")
						if(progressLayout) then
							progressLayout:removeFromParent()
						end

						Avalon.ResHelper:loadPlistSync("ui_effect_countdown.plist")
						local progressLayout = UI.Layout:create()
						progressLayout:init()
						progressLayout:center()
						progressLayout:setName("progressLayout")
						_decoration:getNode():addChild(progressLayout)

						local progressTimer =  UI.ProgressTimer:create()
						progressTimer:init("effect_ui_general_countdown_boss_shaper_skill3_2.png", "effect_ui_general_countdown_boss_shaper_skill3_2.png", "effect_ui_general_countdown_boss_shaper_skill3_1.png", UI.ProgressTimerType.RADIAL)
						progressLayout:addChild(progressTimer,999) 
						progressLayout:setScaleX(-1)
						progressTimer:center()
						progressTimer:setBarChangeAction(1, 0, 8300)
					end
				elseif((plotEventData:getID() == 8000743 
					or plotEventData:getID() == 8000744
					or plotEventData:getID() == 8000745
					or plotEventData:getID() == 8000746) and _decoration:getNode()) then  
					if(plotEventData:getParam()[4] == "trigger" or plotEventData:getParam()[4] == "end") then  
						local progressLayout = _decoration:getNode():getChildByName("progressLayout")
						if(progressLayout) then
							progressLayout:removeFromParent()
						end
					end
				end

				-- _decoration:setLocalZOrder(_decoration:getLocalZOrder() + 4999)

				if(plotEventData:getParam()[6] and plotEventData:getParam()[6] ~= "") then
					local offsetOrder = tonumber(plotEventData:getParam()[6])
					if(offsetOrder) then
						_decoration:changeZOrder(offsetOrder)
					end
				end
			end
		end
    --角色动画
    elseif plotEventData:getType() == 8 then
    	local _Machine = MachineManager:getInstance():getMachine()
		if _Machine then
			-- 这里可能切换了场景导致当前的machine 已经，这里应该修改为通过消息的方式来处理该问题
			if(_Machine._plotRoleRunAnimation) then
				_Machine:_plotRoleRunAnimation(tonumber(plotEventData:getParam()[1]),tonumber(plotEventData:getParam()[2]))
			end
		end
	--停止晃动
    elseif plotEventData:getType() == 9 then
		Avalon.MessageCenter:notice(GameMessage.MC_PLOT_STOP_SHACK)
	--特殊事件
    elseif plotEventData:getType() == 10 then
		Avalon.MessageCenter:notice(tonumber(plotEventData:getParam()[1]),plotEventData:getParam()[2],plotEventData:getParam()[3],plotEventData:getParam()[4],plotEventData:getParam()[5])

	-- 触发全屏表现
	elseif plotEventData:getType() == 11 then
		-- print("11     ", plotEventData:getParam()[4])
		if(plotEventData:getParam()[4] == "1") then
			Avalon.MessageCenter:notice(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_ADD,plotEventData:getParam())
		else 
			Avalon.MessageCenter:notice(AvalonMessage.MC_PLOT_FULL_SCREEN_ADD,plotEventData:getParam())
		end
	-- 移除全屏表现
	elseif plotEventData:getType() == 12 then
		-- print("12     ", plotEventData:getParam()[4])
		if(plotEventData:getParam()[4] == "1") then
			Avalon.MessageCenter:notice(AvalonMessage.MC_PLOT_TOP_FULL_SCREEN_REMOVE,plotEventData:getParam())
		else 
			Avalon.MessageCenter:notice(AvalonMessage.MC_PLOT_FULL_SCREEN_REMOVE,plotEventData:getParam())
		end
	-- 播放音效
	elseif plotEventData:getType() == 13 then
		Avalon.AudioManager:playSoundByConfigID(plotEventData:getParam()[1])
	else
		assert(false,"PlotEventManager:runEvent not found eventType by "..plotEventData:getType())
	end
end


return PlotEventManager;













