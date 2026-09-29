--[[--
数据模型BigSailIslandModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/28
--desc	: BigSailIslandModel
------------------------------------------------------------------------------

local BigSailIslandModel = class("BigSailIslandModel",mvc.GameModel)

function BigSailIslandModel:initData()
	-- 保存所有岛屿的船只信息
	self.boatsInfos = {}
	self:initAllIsland()
	self.isExpelMore = false -- 表示是否多次驱逐，需要本地记录，当前多次驱逐的结果信息
	self.ExpelNum = 0 -- 本次进行多次驱逐，一共打了几场仗
	self.expelData = {} -- 本地记录本次驱逐多次信息。
	self.expelBaseData = {} -- 多次驱逐的基础信息
	self.mapData = {}

	self.expelSettleData = {}
end

function BigSailIslandModel:setExpelInit(data)
	self.expelData = {} -- 清空本地信息
	self.expelBaseData = data
	self.isExpelMore = true
	self.ExpelNum = 0
end

function BigSailIslandModel:setExpelSettleData(data)
	self.expelSettleData = data
end

function BigSailIslandModel:getExpelSettleData()
	return self.expelSettleData
end

function BigSailIslandModel:setExpelEndNum(num)
	self.ExpelNum = num
end

function BigSailIslandModel:saveExpelInfo(dataInfo)
	if not self.isExpelMore then
		return
	end

	table.insert(self.expelData, dataInfo)
end

function BigSailIslandModel:getExpelEndNum()
	return self.ExpelNum
end

function BigSailIslandModel:getisExpelMore()
	return self.isExpelMore
end

function BigSailIslandModel:getExpelInfo()
		return self.expelData
end

function BigSailIslandModel:getExpelBaseData()
		return self.expelBaseData
end

function BigSailIslandModel:clearExpel()
	self.isExpelMore = false 
	self.ExpelNum = 0
	self.expelData = {}
	self.expelBaseData = {}
	self.expelSettleData = {}
end

function BigSailIslandModel:saveIsLandBoatsInfo(boatInfo)
	for k,v in pairs(boatInfo.infos) do
		--self.boatsInfos[v.id] = v
		if self.boatsInfos[v.id] then
			self.boatsInfos[v.id] = v
		else
			table.insert(self.boatsInfos, v.id, v)
		end
	end
	-- 刷新岛屿上的船只信息
	Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
end

function BigSailIslandModel:getIsLandBoatsInfoByLandId(isLandId)
	return self.boatsInfos[isLandId]
end

function BigSailIslandModel:changeEnemyGuild(data, isLandId)
	local boatInfo = self.boatsInfos[isLandId].enemyGuilds
	local enemys = {}
	for k,v in pairs(boatInfo) do
		enemys[k] = v
	end
	if boatInfo then
		if #boatInfo == 0 and (not data.isCancel) then
			table.insert(enemys, data.guildid)
		else
			if data.isCancel then
				for k,v2 in pairs(boatInfo) do
				    if v2 == data.guildid then
			        	-- 取消设置成敌对
			        	enemys[k] = nil
				    end
				end
			else
				table.insert(enemys, data.guildid)
			end
		end
	else
		return
	end
	self.boatsInfos[isLandId].enemyGuilds = enemys
end

function BigSailIslandModel:initAllIsland()
	local petShopData = ConfigManager:getAllIslandsData()
    for k,v in pairs(petShopData) do
    	table.insert(self.boatsInfos, k)
    end
end

function BigSailIslandModel:setMapShowData(data)
    self.mapData = data
end

function BigSailIslandModel:getMapShowData(data)
    return self.mapData
end

function BigSailIslandModel:getGuildOccupyIslandId()
    if self.mapData.markIslandid then
        return self.mapData.markIslandid
    else
        return nil
    end
end

function BigSailIslandModel:setGuildOccupyIslandId(islandId)
    self.mapData.markIslandid = islandId
end

function BigSailIslandModel:clearGetOccupyReward()
    if self.mapData.myOutputNum then
    	self.mapData.myOutputNum = 0
    end
end

function BigSailIslandModel:getBossOpenTime()
	local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local curWeekStartTime = mvc.bigSailPortModel:getCurWeekSartTime()
	
	local bossStartTime = curWeekStartTime + config.bossStartTime*3600
	-- local bossEndTime = curWeekStartTime + config.bossChallengeTime*3600

	return bossStartTime
end

function BigSailIslandModel:getBossShowTime()
	local config = ConfigManager:getNavigationGeneralConfigByID(1)
	local bossStartTime = self:getBossOpenTime()
	local bossShowTime = bossStartTime - config.bossShowTime*3600
	return bossShowTime
end

function BigSailIslandModel:getBossIsOpen()
	local isOpen = false
	local startTime = self:getBossOpenTime()
	local nowTime = GameManager:getNormalServerTime()
	if nowTime >= startTime then
		isOpen = true
	end
	return isOpen
end

function BigSailIslandModel:getBossRankIsPreWeek()
	local isPreWeek = true
	local startTime = self:getBossOpenTime()
	local nowTime = GameManager:getNormalServerTime()
	 
	if nowTime < startTime  then
		isPreWeek = true
	else
		isPreWeek = false
	end
	return isPreWeek
end

function BigSailIslandModel:getHarvestOpenTime()
	local nowTime = GameManager:getNormalServerTime()
	local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local curWeekStartTime = mvc.bigSailPortModel:getCurWeekSartTime()
	local curWeekEndTime = mvc.bigSailPortModel:getCurWeekSartTime() + SECONDS_ONE_WEEK

	local harvestStartTime = curWeekStartTime + config.harvestStartTime*3600
	
	if nowTime > harvestStartTime then
		local offsetTime = nowTime - harvestStartTime
		local period = math.ceil(offsetTime / (config.harvestIntervalTime*3600))
		harvestStartTime = harvestStartTime + (period * config.harvestIntervalTime * 3600)
	end

	local harvestShowTime = harvestStartTime - config.harvestShowTime*3600

	local harvestEndTime = curWeekEndTime - config.harvestEndTime*3600

	return harvestStartTime, harvestShowTime, harvestEndTime
end

function BigSailIslandModel:saveIslandPetsInfo(data)
	local isLandId = data.islandid
    for k2,v2 in pairs(self.boatsInfos[isLandId].info) do
    	self.boatsInfos[isLandId].info[k2].pets = {}
    	for k1,v1 in pairs(data.pets) do
    		if v2.pk == v1.pk then
            	table.insert(self.boatsInfos[isLandId].info[k2].pets, v1.pets)
            end
    	end
    end
end

function BigSailIslandModel:getStartMagnification(enemyAllStarts, myAllStarts)
	local enemyAllStarts = enemyAllStarts or 0
	local myAllStarts = myAllStarts or 0
    local magnificationNum = 0
    if myAllStarts ~= 0 then
        magnificationNum = enemyAllStarts / myAllStarts
    end
    return magnificationNum
end

function BigSailIslandModel:getConsumptionRate(enemyAllStarts,myAllStarts)
	local enemyAllStarts = enemyAllStarts or 0
	local myAllStarts = myAllStarts or 0
	local needRate = false
	
	local magnificationNum = self:getStartMagnification(enemyAllStarts, myAllStarts)
    local failureConsumption = ConfigManager:getAllNavigationGeneralConfigData()[1].failureConsumption2
    local strArry = string.split(failureConsumption, ";")

	local needNum = ConfigManager:getAllNavigationGeneralConfigData()[1].defaultSupplyConsume
	local needNum2 = needNum * 6
    
    for i = #strArry, 1, -1 do
        local mStr = strArry[i]
        local strs = string.split(mStr, ",")
        if magnificationNum >= tonumber(strs[1]) then
            needNum = tonumber(strs[2])
			needNum2 = tonumber(strs[3])
            needRate = true
            break
        end
    end

	return needRate, needNum, needNum2
end

return BigSailIslandModel