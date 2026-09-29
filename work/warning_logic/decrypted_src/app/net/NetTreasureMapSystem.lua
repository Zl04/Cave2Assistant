-- NetTreasureMapSystem.lua
-- Author: zp
-- 

require "utils.MathUtil"
Net = Net or {}
local NetTreasureMapSystem = {}
Net.NetTreasureMapSystem = NetTreasureMapSystem
local ProtobufUtil = require("utils.ProtobufUtil")
require("app.datas.MasterDataManager")
local DEBUG = false

-- 领取藏宝图奖励
function NetTreasureMapSystem:receiveTreasureReward(treasureID, spriteID)
    print(string.format("[Net.NetTreasureMapSystem] receiveTreasureReward treasureID=%d, spriteID=%d.", treasureID, spriteID))
    local treasureData = {}
    treasureData.treasureID = treasureID
    treasureData.spriteID = spriteID

    Net.Helper:sendMessage(NetMessageType.TREASUREMAP_RECEIVE_TREASURE_REWARD, treasureData)
end

-- team消息处理
function NetTreasureMapSystem:onTreasureMapMessageHandler(no, data)
    -- print(string.format("[Net.NetTreasureMapSystem] onTreasureMapMessageHandler no:%d.", no))

    -- if (DEBUG) then
    --     if data and type(data) == "table" then
    --         for k,v in pairs(data) do 
    --             if type(v) == "table" then
    --                 print("[Net.NetTreasureMapSystem] onTreasureMapMessageHandler  k="..k.."  v=")
    --             end
    --         end
    --     end
    -- end

    -- 英雄已领奖励的藏宝图数据
    if (no == NetMessageType.TREASUREMAP_REWARDED_TREASURE_MAP.NO) then
        if DEBUG then
            print("[Net.NetTreasureMapSystem]  TREASUREMAP_REWARDED_TREASURE_MAP ")
        end
        dump(data)
        MasterDataManager:handleInitRreasureData(data)

    -- 英雄已收集的碎片数据
    elseif (no == NetMessageType.TREASUREMAP_COLLECTED_FRAGMENT.NO) then
        if DEBUG then
            print("[Net.NetTreasureMapSystem]  TREASUREMAP_COLLECTED_FRAGMENT ")
        end
        if data.CollectedFragments then
            for i = 1,#data.CollectedFragments do
                GoodsDataManager:handleInitVirtualGoodsData(data.CollectedFragments[i],1)
            end
        end

    -- 领取藏宝图奖励返回结果
    elseif (no == NetMessageType.TREASUREMAP_RECEIVE_TREASURE_REWARD_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem TREASUREMAP_RECEIVE_TREASURE_REWARD_RESULT ")
            dump(data)
        end

        MasterDataManager:handleTreasureReceiveResultData(data)
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_TREASURE_RECIVE_REWARD_RESULT)
    else
        assert(false, string.format("[Net.NetTreasureMapSystem] onTreasureMapMessageHandler no %d is invaild.", no))
    end    
end

