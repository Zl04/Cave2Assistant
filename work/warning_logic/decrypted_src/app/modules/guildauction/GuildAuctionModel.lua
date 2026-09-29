--[[--
数据模型GuildAuctionModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/03/02
--desc	: GuildAuctionModel
------------------------------------------------------------------------------

local GuildAuctionModel = class("GuildAuctionModel",mvc.GameModel)

function GuildAuctionModel:initData()
	self.dataVersion = 0
	self.gameWeek = 0
	self.auctionStatus = PublicDefine.GuildAuctionState.GuildAuctionState_Initiator
	self.closeTime = 0
	self.startTime = 0
	self.itemList = {}

	self.logData = {}
end

function GuildAuctionModel:getDataVersion()
	return self.dataVersion
end

function GuildAuctionModel:getItemList()
	return self.itemList
end

function GuildAuctionModel:getCloseTime()
	return self.closeTime - GameManager:getNormalServerTime()
end

function GuildAuctionModel:getCurStartTime()
	return self.startTime
end

function GuildAuctionModel:getLogData()
	return self.logData
end

function GuildAuctionModel:updateAuctionInfo(data)
	self.dataVersion = data.dataVersion
	self.gameWeek = data.gameWeek
	self.auctionStatus = data.auctionState
	self.closeTime = data.closeTime
	self.startTime = data.startTime
	self.itemList = {}

	for k, v in ipairs(data.itemList) do
		table.insert(self.itemList, self:assembleItemData(v))
	end
end

function GuildAuctionModel:assembleItemData(svrData)
	local cfgData = ConfigManager:getGuildAuctionItemDataByID(svrData.auctionPoolId)
	local itemData = {}
	itemData.idx = svrData.index
	itemData.poolId = svrData.auctionPoolId
	itemData.isSold = svrData.highestBidder.price == cfgData.maxPrice
	itemData.id = cfgData.item[1]
	itemData.num = cfgData.item[2]
	itemData.curPrice = math.max(cfgData.startPrice, svrData.highestBidder.price)
	itemData.bigBoss = svrData.highestBidder
	itemData.nickName = svrData.highestBidder.name
	itemData.isSelf = svrData.highestBidder.PK == RoleDataManager:getMaster():getPK()
	itemData.selfPrice = svrData.myPrice
	itemData.onePrice = cfgData.maxPrice
	itemData.startPrice = cfgData.startPrice

	return itemData
end

function GuildAuctionModel:updateAuctionItemData(data)

end

function GuildAuctionModel:initAuctionLog(logs)
	self.logData = {}

	for k, v in ipairs(logs) do
		local cfgData = ConfigManager:getGuildAuctionItemDataByID(v.poolID)
		local goodsData = GoodsDataManager:createLocalGoodsData(cfgData.item[1])

		local oneLog = {}
		oneLog.id = cfgData.item[1]
		oneLog.num = cfgData.item[2]
		oneLog.log = ""
		if v.winner.PK > 0 then
			oneLog.log = string.format(UI.TEXT_1213902, goodsData:getName(), v.winner.name, v.winner.price)
		else
			-- 流拍
			oneLog.log = string.format(UI.TEXT_1213901, goodsData:getName(), v.winner.price)
		end
		local tmpTime = v.time + GameManager:getEPOCHTime() - GameManager:get_timezone_offset()
		oneLog.date = os.date("%Y-%m-%d", tmpTime)
		oneLog.time = os.date("%X", tmpTime)

		table.insert(self.logData, oneLog)
	end
end

-- buyType: 1:竞价，2:一口价
-- 返回结果：
-- 0:可以购买
-- 1:自己的水晶不足以出价
-- 2:出价已达到上限，无法再加价
function GuildAuctionModel:checkCanBuyItem(buyType, itemData)
	local need = 0
	if buyType == 1 then
		if itemData.onePrice - itemData.curPrice >= 50 then
			-- 服务器数据“当前最高出价”，初始为0
			if itemData.bigBoss.price == 0 then
				need = itemData.startPrice
			else
				need = itemData.curPrice - itemData.selfPrice + 50
			end
		else
			return 2
		end
	elseif buyType == 2 then
		need = itemData.onePrice - itemData.selfPrice
	end

	local GameDataManager = require("app.game.GameDataManager")
	if not Avalon.MathUtil:checkDiamonEnough(need, GameDataManager:getInstance():getDiamond()) then
		return 1
	else
		return 0, need
	end
end

-- 由于客户端做显示，不需要服务器端细分的那么多状态
-- 所以按需重新组装一下
-- status:
-- 1:拍卖关闭
-- 2:拍卖预告
-- 3:拍卖开启
-- 4:拍卖公示，无法操作
function GuildAuctionModel:getClientCurStatus(status)
	local cfg = PublicDefine.GuildAuctionState
	if self.auctionStatus == "GuildAuctionState_Closed"
		or self.auctionStatus == "GuildAuctionState_StockUp"
		or self.auctionStatus == "GuildAuctionState_Preparation"
	then
		return 1
	elseif self.auctionStatus == "GuildAuctionState_WarmUp" then
		return 2
	elseif self.auctionStatus == "GuildAuctionState_UnderAuction" then
		return 3
	elseif self.auctionStatus == "GuildAuctionState_CutOff" then
		return 4
	end
end

function GuildAuctionModel:getSvrCurStatus()
	local cfg = PublicDefine.GuildAuctionState
	local ret = 0
    if self.auctionStatus == "GuildAuctionState_Initiator" then
		ret = cfg.GuildAuctionState_Initiator
	elseif self.auctionStatus == "GuildAuctionState_StockUp" then
		ret = cfg.GuildAuctionState_StockUp
	elseif self.auctionStatus == "GuildAuctionState_Preparation" then
		ret = cfg.GuildAuctionState_Preparation
	elseif self.auctionStatus == "GuildAuctionState_WarmUp" then
		ret = cfg.GuildAuctionState_WarmUp
	elseif self.auctionStatus == "GuildAuctionState_UnderAuction" then
		ret = cfg.GuildAuctionState_UnderAuction
	elseif self.auctionStatus == "GuildAuctionState_CutOff" then
		ret = cfg.GuildAuctionState_CutOff
	elseif self.auctionStatus == "GuildAuctionState_Closed" then
		ret = cfg.GuildAuctionState_Closed
	end
	return ret
end

function GuildAuctionModel:setCurStatus(str)
	self.auctionStatus = str
end

return GuildAuctionModel