-- FightResult.lua
-- Author:ODEI
-- 2017年4月18日
-- Using:战斗结算数据 

require "app.datas.PublicDefine"

local GameDataManager = require("app.game.GameDataManager")


UI = UI or {}

local FightResultUtil = class("FightResultUtil")
UI.FightResultUtil = FightResultUtil



function FightResultUtil:getInstance()
    if g_FightResultUtil == nil then
        g_FightResultUtil = FightResultUtil.new()
    end
    return g_FightResultUtil;
end


function FightResultUtil:purgeInstance()
    if g_FightResultUtil ~= nil then
        g_FightResultUtil = nil;
    end
end

function FightResultUtil:ctor()
	self.mRowNum = 5;		--列数
    self.mData = {}
    self.mDungeonRewardData = nil  -- 直接记录服务器主动返回的值
    -- self.mBtnList = 
end

function FightResultUtil:initData()
    local data = GameDataManager:getInstance():getRewardData();

    self.mGold = data.rewardCoin or 0   --金币
    self.mData = {}
    self.mSellDataArr = {}   -- 自动卖掉的物品
    self.kickOutTownScroll = data.kickOutTownScroll

    self.mInscription = data.rewardInscription or 0   --铭文

    for i = 1,#data.equipmentArr do
        table.insert(self.mData,data.equipmentArr[i])
    end

    for i = 1,#data.itemArr do
        table.insert(self.mData,data.itemArr[i])
    end

    for i = 1,#data.materialArr do
        table.insert(self.mData,data.materialArr[i])
    end

    for i = 1,#data.gemStoneArr do
        table.insert(self.mData,data.gemStoneArr[i])
    end

    for i = 1,#data.treasureArr do
        table.insert(self.mData,data.treasureArr[i])
    end

    for i = 1,#data.petStoneArr do
        table.insert(self.mData,data.petStoneArr[i])
    end

    -- 添加自动卖掉的物品列表
    for i = 1,#data.autoSellEquipmentArr do
        table.insert(self.mSellDataArr,data.autoSellEquipmentArr[i])
    end

    for i = 1,#data.autoSellItemArr do
        table.insert(self.mSellDataArr,data.autoSellItemArr[i])
    end

    for i = 1,#data.autoSellMaterialArr do
        table.insert(self.mSellDataArr,data.autoSellMaterialArr[i])
    end

    for i = 1,#data.autoSellGemStoneArr do
        table.insert(self.mSellDataArr,data.autoSellGemStoneArr[i])
    end

    for i = 1,#data.autoSellTreasureArr do
        table.insert(self.mSellDataArr,data.autoSellTreasureArr[i])
    end

    -- self.mGold = 999999999999

end

function FightResultUtil:setDungeonBattleReward(data)
    self.mDungeonRewardData = data
end

function FightResultUtil:getDungeonBattleReward()
    return self.mDungeonRewardData
end

function FightResultUtil:clearDungeonBattleReward()
    self.mDungeonRewardData = nil
end


function FightResultUtil:setSweepReward(data)
    self.mSweepReward = data
end

function FightResultUtil:getSweepReward()
    return self.mSweepReward
end

function FightResultUtil:clearSweepReward()
    self.mSweepReward = nil
end

return FightResultUtil;
