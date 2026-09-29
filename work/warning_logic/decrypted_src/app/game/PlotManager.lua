-- PlotManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:事件工厂
require("utils.reload")
local LoadingLayer = require "app.scene.loadingscene.LoadingLayer"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local PlotEventManager = require("app.game.PlotEventManager")

local PlotManager = class("PlotManager")
require "app.datas.plot.PlotData"
require "app.config.ConfigManager"
g_PlotManager = nil;

local scheduler = cc.Director:getInstance():getScheduler()
local DEBUG = false

function PlotManager:ctor()
	self.plotEventList = {}
	self.schedulerID = 0
end


function PlotManager:getInstance()
	if g_PlotManager == nil then
		g_PlotManager = PlotManager.new()
		g_PlotManager:init()
	end
	return g_PlotManager;
end


function PlotManager:purgeInstance()
	if g_PlotManager ~= nil then
		g_PlotManager = nil;
	end
end

function PlotManager:init()
	if(DEBUG) then
		print("PlotManager:init")
	end
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update),0,false)


    self.plotDataList = {}
end



function PlotManager:runPlotByID(id)
	if(DEBUG) then
		print("PlotManager:runPlotByID ", id)
	end

	id = tonumber(id)
	-- add by zp 由于CO-9375任务添加该段代码
	if(id == 1050031 or id == 1050024) then 
		local SceneManager = require("app.game.SceneManager")
		if(SceneManager:getInstance():isWorldBossCave()) then 
			return 
		end
	end
	
	local pPlotConfig = ConfigManager:getPlotConfigForPlotID(id)
	if pPlotConfig then
	    local pPlotData = Data.PlotData:create()
	    pPlotData:initNet(pPlotConfig)
	    self:runPlot(pPlotData)
	else
		assert(false,"PlotManager:runPlotByID Plot not found by "..id)
	end
end

function PlotManager:runPlot(plotData)
	if(DEBUG) then
		print("PlotManager:runEvent",plotData:getID())
	end

	table.insert(self.plotDataList,plotData)
    self.plotData = plotData:getPlot()
    
    if self.schedulerID == 0 then
    	self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update),0,false)
    end
end

function PlotManager:update(dt)
	if self.plotDataList ~= nil and #self.plotDataList > 0 then
		
		for j = #self.plotDataList,1,-1 do
			local count = 0
			local plotData = self.plotDataList[j]
			if plotData then
				for k,plotEventList in pairs (plotData:getPlot()) do
					if plotData:getPlotTime() <= k and plotData:getPlotTime() + dt*1000 > k then
						for i = 1,#plotEventList do
							PlotEventManager:getInstance():runEventByID(plotEventList[i])
						end
						plotData[k] = nil
					else
						if plotEventList ~= nil then
							count = count + 1
						end
					end
				end

				if count <= 0 then
					Avalon.MessageCenter:notice(AvalonMessage.MC_FINISH_PLOT, plotData:getID())
					table.remove(self.plotDataList,j)
					plotData = nil

					if #self.plotDataList <= 0 then
						if self.schedulerID ~= 0 then
							scheduler:unscheduleScriptEntry(self.schedulerID)
							self.schedulerID = 0
						end
					end
				else
					plotData:setPlotTime(plotData:getPlotTime() + dt * 1000)
				end
			end
		end
	end
end


return PlotManager;













