--[[--
数据模型BattlePassModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: BattlePassModel
------------------------------------------------------------------------------

local BattlePassModel = class("BattlePassModel",mvc.GameModel)

function BattlePassModel:initData()
	self.seasonId = 0  --赛季ID
	self.level = 0	   --当前通行证等级
	self.curExp = 0	   --当前通行证等级的经验
	self.curTotalExp = 1 --当前等级的总经验
	self.unlockGoldPass = false --是否解锁了金色通行证
	self.normalPassReward = {}  --普通通行证奖励
	self.goldPassReward = {}    --金色通行证奖励
	self.shopData = {}    --兑换商店的数据
	self.boughtType = {}  --通行证已购买类型 对应PublicDDefine.BattlePassIndex 中的值
	self.startTime = 0;
	self.endTime = 0;
end

function BattlePassModel:refreshBattlePassData(data)
	print("----refreshBattlePassData----")
	-- local data = {}
	-- data.seasonId = 1
	-- data.lv = 10
	-- data.curLvExp = 100
	-- data.isGoldenActivate = false
 --    data.normalGotLv = {}
 --    data.goldenGotLv = {}
	function generateRewardList(strData, level, haveGotList, isUnLock)
		local rewardList = {}
		haveGotList = haveGotList or {}
		local tempList = {}
		for k, v in ipairs(haveGotList) do
			tempList[v] = true
		end
		haveGotList = tempList
		local list = string.split(strData, ";")
	    for k, v in ipairs(list) do
	    	local rewardData = {}
	     	local params = string.split(v, ",")
	     	local itemId = checkint(params[1])
	     	local number = checkint(params[2])
	    	if #params >= 2 and itemId ~= 0 and number ~= 0 then	
	    		rewardData.itemId = itemId
	    		rewardData.num = number
	    		rewardData.isReward = haveGotList[k] == nil and false or haveGotList[k]
	    		if isUnLock then
		    		if k > level then
		    			rewardData.isFinish = false
		    		else
		    			rewardData.isFinish = true
		    		end
		    	else
		    		rewardData.isFinish = false
		    	end
	    	end
	    	table.insert(rewardList, rewardData)
	    end
	    return rewardList
	end
	self.seasonId = data.season
	self.level = data.lv
	self.curExp = data.curLvExp
	self.unlockGoldPass = data.isGoldenActivate
	local cfgData = NewConfig.BattlePassReward:getDataById(self.seasonId)
    self.normalPassReward = generateRewardList(cfgData.ordinaryContent, data.lv, data.normalGotLv, true)
    self.goldPassReward = generateRewardList(cfgData.goldenContent, data.lv, data.goldenGotLv, self.unlockGoldPass)
    self.curTotalExp = cfgData.battlePassExp
    self.boughtType = data.boughtType
    self:refreshShopData(self.seasonId, data.buyInfo)
    self:setForce("PassRewardData")

    self.startTime = data.startTm * SECONDS_ONE_DAY + GameManager:getEPOCHTime()
    
    local pastTime = 0
    for i = 1, self.seasonId - 1 do
    	local iCfgData = NewConfig.BattlePassReward:getDataById(i)
    	pastTime = pastTime + iCfgData.duration
    end
    self.startTime = self.startTime + pastTime * SECONDS_ONE_DAY
	self.endTime = self.startTime + cfgData.duration * SECONDS_ONE_DAY - SECONDS_ONE_DAY
end

function BattlePassModel:refreshShopData(seasonId, buyRecord)
	self.shopData = {}

	print("   seasonId ===== ",seasonId)
	print("buyRecord ==== ")
	dump(buyRecord,nil,10)
	local allList = NewConfig.BattlePassShop:getAllDatas()
	local curSeasonList = {}
	for k, v in ipairs(allList) do
		if v.quarterID == seasonId then
			table.insert(curSeasonList, v)
		end
	end

	for k, v in ipairs(curSeasonList) do
		local data = clone(v)
		data.buyNum = 0
		for k2, v2 in ipairs(buyRecord) do
			if v2.id == v.ID then
				data.buyNum = v2.buyNum
			end
		end
		data.isChange = false
		table.insert(self.shopData, data)
	end
end

function BattlePassModel:getNormalBattlePassData()
	return self.normalPassReward 
end

function BattlePassModel:getGoldBattlePassData()
	return self.goldPassReward 
end

function BattlePassModel:getBattlePassLvAndExp()
	return self.level, self.curExp, self.curTotalExp
end

function BattlePassModel:getBattlePassSeasonId()
	return self.seasonId
end

function BattlePassModel:getAllRwardItem(awardType)
	local itemList = {}
	if awardType == PublicDefine.BattlePassAwardType.BattlePassType_Normal then
		for k, v in ipairs(self.normalPassReward) do
			if v.isFinish and not v.isReward then
				if itemList[v.itemId] == nil then
					itemList[v.itemId] = v.num
				else
					itemList[v.itemId] = itemList[v.itemId] + v.num
				end
			end
		end
	elseif awardType == PublicDefine.BattlePassAwardType.BattlePassType_Golden then
		for k, v in ipairs(self.goldPassReward) do
			if v.isFinish and not v.isReward then
				if itemList[v.itemId] == nil then
					itemList[v.itemId] = v.num
				else
					itemList[v.itemId] = itemList[v.itemId] + v.num
				end
			end
		end
	end

	return itemList
end

function BattlePassModel:getRwardItemByLevel(awardType, level)
	local itemList = {}
	if awardType == PublicDefine.BattlePassAwardType.BattlePassType_Normal then
		for k, v in ipairs(self.normalPassReward) do
			if v.isFinish and not v.isReward and level == k then
				return v.itemId, v.num
			end
		end
	elseif awardType == PublicDefine.BattlePassAwardType.BattlePassType_Golden then
		for k, v in ipairs(self.goldPassReward) do
			if v.isFinish and not v.isReward and level == k then
				return v.itemId, v.num
			end
		end
	end
end

function BattlePassModel:isHaveRward()
	local itemList = {}
	for k, v in ipairs(self.normalPassReward) do
		if v.isFinish and not v.isReward then
			if itemList[v.itemId] == nil then
				itemList[v.itemId] = v.num
			else
				itemList[v.itemId] = itemList[v.itemId] + v.num
			end
		end
	end
	for k, v in ipairs(self.goldPassReward) do
		if v.isFinish and not v.isReward then
			if itemList[v.itemId] == nil then
				itemList[v.itemId] = v.num
			else
				itemList[v.itemId] = itemList[v.itemId] + v.num
			end
		end
	end
	if table.nums(itemList) > 0 then
		return true
	end
	return false
end

function BattlePassModel:isUnlockGoldPass()
	return self.unlockGoldPass
end

function BattlePassModel:getShopDatas()
	return self.shopData
end

function BattlePassModel:getShopDataById(id)
	for k, v in ipairs(self.shopData) do
		if v.ID == id then
			return v
		end
	end
end

function BattlePassModel:refreshBattlePassShopData(buyInfo)  
	for k, v in ipairs(buyInfo) do
		for k2, v2 in ipairs(self.shopData) do
			if v.id == v2.ID and v2.buyNum ~= v.buyNum then
				v2.buyNum = v.buyNum
				v2.isChange = true
				break;
			end
		end
	end
	self:setForce("PassShopData")
end

function BattlePassModel:refreshBattlePassIcon()
	self:setForce("BattlePassIcon")
end

function BattlePassModel:getIapDataByType(iType)
	local list = self:getIapDatas()
	for k, v in ipairs(list) do
		if v.stage == iType then
			return v
		end
	end
-- data = {}
-- data.price  = 100
-- data.isBought = false
-- return data
end

function BattlePassModel:isBoughtIap(iType)
	for k, v in ipairs(self.boughtType) do
		if iType == v then
			return true
		end
	end
	if iType == PublicDefine.BattlePassIndex.BattlePassIndex_Noraml or iType == PublicDefine.BattlePassIndex.BattlePassIndex_LuxuryDiscount then
		iType = PublicDefine.BattlePassIndex.BattlePassIndex_Luxury
	end
	for k, v in ipairs(self.boughtType) do
		if iType == v then
			return true
		end
	end
	return false
end

function BattlePassModel:getIapDatas()
	local SdkManager = require"app.game.SdkManager"
	local iapDatas = SdkManager:getInstance():getIapDatas()
	local dataList = {}
	local luxuryData = {}
	for k, v in pairs(iapDatas) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.BattlePass then
        	v.goods = {}
            table.insert(dataList, v)
            if v.stage == PublicDefine.BattlePassIndex.BattlePassIndex_Luxury then
            	luxuryData = v
            end
        end
    end
    local cfgData = NewConfig.BattlePassReward:getDataById(self.seasonId)
    if cfgData then
    	for k, v in ipairs(dataList) do
    		if v.stage == PublicDefine.BattlePassIndex.BattlePassIndex_Noraml then
    			self:generateIapDataGoods(v, cfgData.goldenPassGift, (cfgData.goldenPassPrice or 0) * 100)
    		elseif v.stage == PublicDefine.BattlePassIndex.BattlePassIndex_Luxury then
    			self:generateIapDataGoods(v, cfgData.deluxePassGift, (cfgData.deluxePassPrice or 0) * 100)
    		elseif v.stage == PublicDefine.BattlePassIndex.BattlePassIndex_LuxuryDiscount then
    			self:generateIapDataGoods(v, string.gsub(cfgData.deluxePassGift, cfgData.goldenPassGift, ""), luxuryData.price)
    		end
    		v.isBought = self:isBoughtIap(v.stage)
    	end
    end
    return dataList
end

function BattlePassModel:generateIapDataGoods(iapData, goodsStr, origPrice)
	if goodsStr == nil or goodsStr == "" then
		return
	end
	local strList = string.split(goodsStr, ";")
	for k, v in ipairs(strList) do
		local itemStr = string.split(v, ",")
		if #itemStr >= 2 then
			local data = {}
			data.itemId = checkint(itemStr[1])
			data.num = checkint(itemStr[2])
			table.insert(iapData.goods, data)
		end
	end
	iapData.origPrice = origPrice
end

function BattlePassModel:getBattlePassSeasonTime()
	return self.startTime, self.endTime 
end

function BattlePassModel:isMaxLevel()
	if self.level == 0 then
		return false
	end
	local normalSize = #self.normalPassReward 
    local goldSize =  #self.goldPassReward
    local maxSize = normalSize > goldSize and normalSize or goldSize
	if self.level >= maxSize then
		return true
	end
	return false
end


return BattlePassModel