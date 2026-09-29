--[[
    NPC相关的网络消息处理
]]--

require "utils.MathUtil"
local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require("utils.ProtobufUtil")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

Net = Net or {}
local NetNPCSystem = {}
Net.NetNPCSystem = NetNPCSystem

local DEBUG = false

 --请求公会拍卖宝藏数据
function NetNPCSystem:reqGetAllTreasure(spriteID)
    local messageData = {}
    messageData.type = "GuildIdentifyTreasureType_Open"
    local data = ProtobufUtil:encode("NPCSystem.ReqGuildIdentifyTreasureMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_AUCTION_STOCK, spriteID)
end

 --请求公会拍卖鉴包
function NetNPCSystem:reqIndentifyTreasure(spriteID)
    local messageData = {}
    messageData.type = "GuildIdentifyTreasureType_Identify"
    local data = ProtobufUtil:encode("NPCSystem.ReqGuildIdentifyTreasureMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_AUCTION_STOCK, spriteID)
end

-- 请求购买公会商店商品
function NetNPCSystem:requestGuildShopBuy(buyID, buyNum, buyIdx, shopType, spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] requestGuildShopBuy buyID, buyNum", buyID, buyNum)
    end
    local messageData = {}
    messageData.buyID = buyID
    messageData.buyNum = buyNum
    messageData.buyIndex = buyIdx
    messageData.shopType = shopType

    local data = ProtobufUtil:encode("NPCSystem.ReqBuyGuildGoodsMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_MARKET, spriteID)
end

-- 请求公会随机商店刷新时间
function NetNPCSystem:requestGuildRandomShopRefreshTime()
    if DEBUG then
        print ("[Net.NetNPCSystem] requestGuildRandomShopRefreshTime")
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_GUILD_RANDOM_SHOP_REFRESH_TIME)
end

-- 请求宠物宝藏
function NetNPCSystem:requestPetTreasureInfo(spriteID)
    self:useFunctionRequest("", PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_PETTREASURE, spriteID)
end

-- 请求公会拍卖主页数据请求
function NetNPCSystem:requestGuildAuctionInfo(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] requestGuildAuctionInfo")
    end

    local messageData = {}
    messageData.type = "GuildAuctionOperateType_SyncData"
    messageData.dataVersion = 0
    messageData.bidIndex = 0
    messageData.auctionPoolId = 0
    messageData.currentPrice = 0
    messageData.bidPrice = 0

    local data = ProtobufUtil:encode("NPCSystem.ReqGuildAuctionMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_AUCTION_MAIN, spriteID)
end

-- 请求公会拍卖出价请求
function NetNPCSystem:requestGuildAuctionBuy(data, spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] requestGuildAuctionBuy")
    end

    local messageData = {}
    messageData.type = "GuildAuctionOperateType_BidPrice"
    messageData.dataVersion = data.dataVersion
    messageData.bidIndex = data.bidIndex
    messageData.auctionPoolId = data.auctionPoolId
    messageData.currentPrice = data.currentPrice
    messageData.bidPrice = data.bidPrice

    local data = ProtobufUtil:encode("NPCSystem.ReqGuildAuctionMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_AUCTION_MAIN, spriteID)
end

-- 请求公会拍卖记录请求
function NetNPCSystem:requestGuildAuctionLog(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] requestGuildAuctionLog")
    end

    local messageData = {}
    messageData.type = "GuildAuctionOperateType_CheckLog"
    messageData.dataVersion = 0
    messageData.bidIndex = 0
    messageData.auctionPoolId = 0
    messageData.currentPrice = 0
    messageData.bidPrice = 0

    local data = ProtobufUtil:encode("NPCSystem.ReqGuildAuctionMessage", messageData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_AUCTION_MAIN, spriteID)
end

 function NetNPCSystem:requestGhostAbyssBuff(opType, index, spriteID)
    print("----------------NetNPCSystem:trigerGhostAbyssBuff=", opType, index)
    local data = {}
    local message = {}
    message.opType = opType
    message.index = index
    
    local data = ProtobufUtil:encode("NPCSystem.GhostAbyssBuffOperationData", message)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM, spriteID)
 end

 -- 触发functiontype
function NetNPCSystem:triggerFunctionType(functionType, spriteID)
    print("----------------NetNPCSystem:triggerFunctionType=", functionType, spriteID)
    local data = ""
    
    self:useFunctionRequest(data, functionType, spriteID)
 end

-- 打开触发类NPC
function NetNPCSystem:openTriggerNpcRequest(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] openTriggerNpcRequest spriteID=",spriteID)
    end
    local messageData = {}
    messageData.spriteID = spriteID 
    
    Net.Helper:sendMessage(NetMessageType.NPC_TRIGGER_NPC, messageData)
end

-- 请求黑商信息
function NetNPCSystem:reqBlackMarket()
    if DEBUG then
        print ("[Net.NetNPCSystem] reqBlackMarket")
    end
    
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_BLACK_MARKET)
end

-- 请求随机商人信息
function NetNPCSystem:reqRandomShopMarket()
    if DEBUG then
        print ("[Net.NetNPCSystem] reqRandomShopMarket")
    end
    
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_RANDOMSHOP_MARKET)
end

-- 登陆游戏请求抽奖转盘信息
function NetNPCSystem:loadTurnTableInfo()
    if DEBUG then
        print ("------------[Net.NetNPCSystem] loadTurnTableInfo")
    end
    Net.Helper:sendMessage(NetMessageType.LOAD_NPC_TURNTABLE_INFO)
end

-- 打开界面请求抽奖转盘信息
function NetNPCSystem:reqTurnTableInfo()
    if DEBUG then
        print ("--------------------[Net.NetNPCSystem] reqTurnTableInfo")
    end
    
    Net.Helper:sendMessage(NetMessageType.NPC_TURNTABLE_INFO)
end

-- 使用功能请求
function NetNPCSystem:useFunctionRequest(data, functionType, spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] useFunctionRequest spriteID,functionType=",spriteID,functionType,data)
    end

    -- add by zp 判断检测客户端异常的处理
    -- if(spriteID == nil or spriteID == 0) then 
    --     printError("Use NPC Function must set spriteID.")
    -- end
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        spriteID = 0
    end

    local messageData = {}
    if(spriteID) then
        messageData.NPCSpriteID = spriteID 
    end
    messageData.functionType = functionType
    messageData.data = data

    Net.Helper:sendMessage(NetMessageType.NPC_USE_FUNCTION, messageData)
end

--点金请求
function NetNPCSystem:sendGoldPointing(goodsData,spriteID)
    local goldPointingData = {}
    goldPointingData.goodsID = {}

    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        goldPointingData.goodsID.templateID = 0
        goldPointingData.goodsID.isGolden = goodsData:getIsGolden()
        goldPointingData.goodsID.entityID = goodsData:getEntityID()
        goldPointingData.goodsPacketType = GameDataManager:getInstance():getGoodsPacketType(goodsData)
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE ) then
        goldPointingData.goodsID.templateID = goodsData:getGoodsID()
        goldPointingData.goodsID.isGolden = goodsData:getIsGolden()
        goldPointingData.goodsID.entityID = 0
        goldPointingData.goodsPacketType = PublicDefine.PACKET_TYPE.PACKET_BAG
    end
    
    if(DEBUG) then
        print("spriteID",spriteID)
        dump(goldPointingData)
    end

    local data = ProtobufUtil:encode("NPCSystem.GoldTouchMessage", goldPointingData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GOLD_TOUCH, spriteID)
end

--附魔请求
function NetNPCSystem:sendEnchantment(equipmentGoodsData,materialDatas,spriteID)
    local enchantmentData = {}
    enchantmentData.equipmentInstanceID = equipmentGoodsData:getEntityID()
    enchantmentData.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)

    enchantmentData.materialID = {}
    enchantmentData.materialPacket = {}

    for k,v in pairs(materialDatas) do
        local materialData = {}
        materialData.templateID = v:getGoodsID()
        materialData.isGolden = v:getIsGolden()
        materialData.entityID = 0
        table.insert(enchantmentData.materialID,materialData)
        table.insert(enchantmentData.materialPacket,v:getBagType())
    end
    if(DEBUG) then
        dump(enchantmentData)
    end
    local data = ProtobufUtil:encode("NPCSystem.EnchantMessage", enchantmentData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.ENCHANT, spriteID)
end

--改造请求
function NetNPCSystem:sendRemodel(equipmentGoodsData,attrType,spriteID)
    local remodelData = {}
    remodelData.equipmentInstanceID = equipmentGoodsData:getEntityID()
    remodelData.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)

    remodelData.remodelAttrType = attrType
    if(DEBUG) then
        dump(remodelData)
    end
    local data = ProtobufUtil:encode("NPCSystem.RemodelMessage", remodelData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.EQUIPMENT_REMODEL, spriteID)
end

--强化请求
function NetNPCSystem:sendStrengthen(equipmentGoodsData,materialGoodsData,costType,spriteID)
    local strengthenData = {}
    strengthenData.equipmentInstanceID = equipmentGoodsData:getEntityID()
    strengthenData.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)

    strengthenData.materialInstanceID = materialGoodsData:getEntityID()
    strengthenData.materialPacketType = GameDataManager:getInstance():getGoodsPacketType(materialGoodsData)
    strengthenData.costType = costType
    print("costType",costType)
    if(DEBUG) then
        dump(strengthenData)
    end
    local data = ProtobufUtil:encode("NPCSystem.StrengthenMessage", strengthenData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN, spriteID)
end

--装备分解请求 1、装备实例ID 2、装备包裹类型
function NetNPCSystem:sendResolve(equipmentGoodsList, spriteID)
    local equipmentDatas = {}
    for k, v in ipairs(equipmentGoodsList) do
        local data = {}
        data.equipmentInstanceID = v:getEntityID()
        data.equipmentInstanceID = data.equipmentInstanceID
        data.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(v)
        table.insert(equipmentDatas, data)
    end
    local msgData = {}
    msgData.decomposedEquipments = equipmentDatas
    -- dump(msgData, "----NetNPCSystem:sendResolve")
    local data = ProtobufUtil:encode("NPCSystem.EquipDecomposeMessage", msgData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.EQUIPMENT_DECOMPOSE, spriteID)
end

--装备锻造请求 1、图纸ID
function NetNPCSystem:sendForge(equipmentGoodsData, spriteID)
    local forgeData = {}
    
    -- local  scrollID = {}
    forgeData.scrollID = {}
    forgeData.scrollID.templateID = equipmentGoodsData:getGoodsID()
    forgeData.scrollID.isGolden = equipmentGoodsData:getIsGolden()
    -- forgeData.entityID = 0
    -- resolveData.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)
    if(DEBUG) then
        dump(forgeData)
    end

    local data = ProtobufUtil:encode("NPCSystem.EquipForgeMessage", forgeData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.EQUIPMENT_FORGE, spriteID)
end


--捏脸请求
function NetNPCSystem:sendFacelift(faceId,spriteID)
    print("NetNPCSystem:sendFacelift()",faceId,spriteID)
    local faceLiftData = {}
    
    faceLiftData.faceId = faceId

    if(DEBUG) then
        dump(faceLiftData)
    end

    local data = ProtobufUtil:encode("NPCSystem.FaceLiftMessage", faceLiftData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.FACELIFT, spriteID)
end
--猫饭请求 传猫饭模板ID即可
function NetNPCSystem:sendcatFood(goosId, spriteID)
    print("NetNPCSystem:猫饭",goosId)
    local catfoodData = {}
    
    catfoodData.catFoodID = goosId
    if(DEBUG) then
        dump(catfoodData)
    end
    local data = ProtobufUtil:encode("NPCSystem.CatFoodMessage", catfoodData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.CAT_FOOD, spriteID)
end

--学习科技请求
function NetNPCSystem:sendGuildTech(guildID,techId, contributeNum,spriteID)
    if(DEBUG) then
        print("NetNPCSystem:sendGuildTech()",guildID,techId,contributeNum,spriteID)
    end
    local guildTechData = {}
    
    guildTechData.guildID = guildID
    guildTechData.techId = techId
    guildTechData.contributeNum = contributeNum

    if(DEBUG) then
        dump(guildTechData)
    end
    local data = ProtobufUtil:encode("NPCSystem.ContributeGuildTechMessage", guildTechData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GUILD_TECH, spriteID)

    -- 处理记录数据
    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_LEARN_TECH)
    if(repeatData == nil) then
        repeatData = 0
    end
    repeatData = tonumber(repeatData) + contributeNum
    MasterDataManager:setRepeatHandleData(RepeatHandleType.GUILD_LEARN_TECH,repeatData)
end

--领取成就奖励
function NetNPCSystem:sendAchievementReward(achievementId,awardStat,spriteID)
    if(DEBUG) then
        print("NetNPCSystem:sendAchievementReward()", achievementId, awardStat, spriteID)
    end
    local achievementData = {}
    
    achievementData.achievementId = achievementId
    achievementData.awardStat = awardStat
    if(DEBUG) then
        dump(achievementData)
    end
    local data = ProtobufUtil:encode("NPCSystem.AchievementAwardMessage", achievementData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.ACHIEVEMENT, spriteID)
end

-- 刷新黑商数据
function NetNPCSystem:ManualRefreshBlackMarket(NPCSpriteID)
    if(DEBUG) then
        print("NetNPCSystem:ManualRefreshBlackMarket NPCSpriteID=", NPCSpriteID)
    end
    local achievementData = {}
    achievementData.NPCSpriteID = NPCSpriteID

    Net.Helper:sendMessage(NetMessageType.NPC_MANUAL_REFRESH_BLACK_MARKET, achievementData)
end

-- 刷新随机商店数据
function NetNPCSystem:ManualRefreshRandomShopMarket(NPCSpriteID)
    if(DEBUG) then
        print("NetNPCSystem:ManualRefreshRandomShopMarket NPCSpriteID=", NPCSpriteID)
    end
    local achievementData = {}
    achievementData.NPCSpriteID = NPCSpriteID

    Net.Helper:sendMessage(NetMessageType.NPC_MANUAL_REFRESH_RANDOMSHOP_MARKET, achievementData)
end

--宝石合成
function NetNPCSystem:sendGemSynthesis(mainGemId, gemIds, spriteID, 
    equipmentInstanceID, equipmentPacketType, equipmentHoleIndex)
    print("------NetNPCSystem:sendGemSynthesis()---")
    local synthesisData = {}
    synthesisData.composeTempID = {tempID = mainGemId:getId(),packetType= mainGemId:getBagType()}
    local res = {}
    for i = 1, #gemIds do
        table.insert(res, {tempID = gemIds[i]:getId(),packetType= gemIds[i]:getBagType()})
    end
    synthesisData.gemstoneTempID = res

    -- required uint32 tempID = 1;
    -- required uint32 packetType = 2;

    -- required GemStoneItemData composeTempID = 1;                 // 合成宝石ID;
    -- repeated GemStoneItemData gemstoneTempID = 2;

    if equipmentInstanceID then
        synthesisData.equipmentInstanceID = equipmentInstanceID
        synthesisData.equipmentPacketType = equipmentPacketType
        synthesisData.equipmentHoleIndex = equipmentHoleIndex
    end
    -- if(DEBUG) then
        -- dump(synthesisData)
    -- end
    local data = ProtobufUtil:encode("NPCSystem.NewGemstoneComposeMessage", synthesisData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GEMSTONE_COMPOSE, spriteID)
end

--宝石镶嵌
function NetNPCSystem:sendGemStoneInlay(spriteID, equipmentGoodsData, equipmentHoleIndex, gemstoneTempID, optType)
    local remodelData = {}
    remodelData.equipmentInstanceID = equipmentGoodsData:getEntityID()
    remodelData.equipmentPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)
    remodelData.equipmentHoleIndex = equipmentHoleIndex - 1
    remodelData.gemstoneTempID = {tempID = gemstoneTempID[1], packetType= gemstoneTempID[2] or PublicDefine.PACKET_TYPE.PACKET_BAG}
    remodelData.optType = optType
    print(remodelData)
    local data = ProtobufUtil:encode("NPCSystem.NewEquipGemstoneInlaidMessage", remodelData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GEMSTONE_INLAID, spriteID)
end

--宝石购买
function NetNPCSystem:sendGemShopBuy(productId,spriteID, useType, isTen)
    print("------NetNPCSystem:sendGemShopBuy()---")
    local pbData = {}
    pbData.productID = productId
    pbData.costType = useType
    pbData.isTenSeries = isTen
    dump(pbData)
    local data = ProtobufUtil:encode("NPCSystem.GemstoneBuyMessage", pbData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GEMSTONE_BUY, spriteID)
end

--宝石转化
function NetNPCSystem:sendGemTransForm(templateId,spriteID, packageType )
    print("------NetNPCSystem:sendGemTransForm()---")
    local pbData = {}
    pbData.gemstoneTempID = {tempID = templateId, packetType= packageType or PublicDefine.PACKET_TYPE.PACKET_BAG}
    local data = ProtobufUtil:encode("NPCSystem.NewGemstoneTransformMessage", pbData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.GEMSTONE_TRANSFORM, spriteID)
end



-- 请求金矿信息
function NetNPCSystem:reqGoldenMineInfo(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGoldenMineInfo")
    end

    local goldenMineDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsReqGoldenMineGetInfo")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGoldenMineWrapMessage", goldenMineDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_MINE, spriteID)
end

-- 请求金矿升级
function NetNPCSystem:reqGoldenMineLvUp(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGoldenMineLvUp")
    end

    local goldenMineDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsReqGoldenMineUpgradeLv")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGoldenMineWrapMessage", goldenMineDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_MINE, spriteID)
end

-- 请求金矿产出
function NetNPCSystem:reqGoldenMineOutput(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGoldenMineOutput")
    end

    local goldenMineDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsReqGoldenMineGetOutput")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGoldenMineWrapMessage", goldenMineDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_MINE, spriteID)
end

-- 请求金矿加速
function NetNPCSystem:reqGoldenMineBoost(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGoldenMineBoost")
    end

    local goldenMineDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsReqGoldenMineCompleteJob")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGoldenMineWrapMessage", goldenMineDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_MINE, spriteID)
end

-- 请求工坊信息
function NetNPCSystem:reqGemFactoryInfo(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGemFactoryInfo")
    end

    local GemFactoryDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsReqGemFactoryGetInfo")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGemFactoryWrapMessage", GemFactoryDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_GEM, spriteID)
end

-- 请求工坊升级
function NetNPCSystem:reqGemFactoryLvUp(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGemFactoryLvUp")
    end

    local GemFactoryDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsReqGemFactoryUpgradeLv")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGemFactoryWrapMessage", GemFactoryDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_GEM, spriteID)
end

-- 请求工坊产出
function NetNPCSystem:reqGemFactoryOutput(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGemFactoryOutput")
    end

    local GemFactoryDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsReqGemFactoryGetOutput")
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGemFactoryWrapMessage", GemFactoryDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_GEM, spriteID)
end

-- 请求工坊加速
function NetNPCSystem:reqGemFactoryBoost(spriteID, itemList)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqGemFactoryBoost")
    end

    local GemFactoryDatas = {
        subMsgNo = ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsReqGemFactoryCompleteJob"),
        reqCompleteJob = { instanceIDs = itemList }
    }

    local data = ProtobufUtil:encode("NPCSystem.CsReqGemFactoryWrapMessage", GemFactoryDatas)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.HOME_SYSTEM_GEM, spriteID)
end

-- 请求进阶
function NetNPCSystem:reqSkillAdvanced(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqSkillAdvanced", spriteID)
    end

    local data = ProtobufUtil:encode("NPCSystem.SkillAdvancedMessage", {})
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED, spriteID)
end

--  改造二次确认请求
function NetNPCSystem:reqSureRemould(equipmentGoodsData,attrType,spriteID, iscancle)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqSureRemould", spriteID)
    end
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        spriteID = 0
    end
    local remodelData = {}
    remodelData.equipInstanceID = equipmentGoodsData:getEntityID()
    remodelData.equipPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)

    remodelData.remodelAttrType = attrType
    remodelData.npcID = spriteID
    remodelData.isCanle = iscancle
    Net.Helper:sendMessage(NetMessageType.NPC_SURE_REQUEST_REMODEL_RESULT, remodelData)
end

function NetNPCSystem:reqConveretEquip(equipmentGoodsData,convertType,spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqConveretEquip", spriteID)
    end
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        spriteID = 0
    end
    local remodelData = {}
    remodelData.equipInsID = equipmentGoodsData:getEntityID()
    remodelData.equipPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)
    remodelData.npcID = spriteID
    remodelData.convertType = convertType
    print(remodelData)

    Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_CONVERT_EQUIP_RES, remodelData)
end

-- 请求梦境商店信息
function NetNPCSystem:reqDreamShop()
    if DEBUG then
        print ("[Net.NetNPCSystem] reqDreamShop")
    end

    Net.Helper:sendMessage(NetMessageType.NPC_REQ_DREAM_SHOP)
end

-- 梦境商店购买商品请求信息
function NetNPCSystem:reqDreamShopBuy(_index, spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqDreamShopBuy" .. spriteID)
    end

    local encodeData = {};
    encodeData.index = _index
    local data = ProtobufUtil:encode("NPCSystem.DreamshopBuyMessage", encodeData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.DREAMSHOP, spriteID)
end

-- 装备锻造请求信息
function NetNPCSystem:reqEquipForge(scrollID, optType, spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqEquipForge: " .. scrollID .. ", " .. optType)
    end

    local encodeData = {}
    encodeData.scrollID = scrollID
    encodeData.optType = optType

    local data = ProtobufUtil:encode("NPCSystem.HeroForgeMessage", encodeData)
    self:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.EQUIPMENT_FORGE, spriteID)
end

-- 请求重铸装备
function NetNPCSystem:reqRecastEquip(spriteID, equipmentGoodsData, costType)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqRecastEquip", spriteID, packetType, equipInsID, costType)
    end
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        spriteID = 0
    end
    local params = {}
    params.equipInsID = equipmentGoodsData:getEntityID()
    params.type = costType
    params.npcID = spriteID
    params.equipPacketType = GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_RECAST_EQUIP, params)
end

function NetNPCSystem:reqStartExpedition(spriteID, model, level)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqStartExpedition", spriteID, model, level)
    end

    local data = {}
    data.caveMode = model
    data.caveLevel = mvc.expeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(model, level)
    -- print ("[Net.NetNPCSystem] reqStartExpedition 2=", data)

    Net.Helper:sendMessage(NetMessageType.NPC_REQ_START_EXPEDITION, data)
end

function NetNPCSystem:reqStopExpedition(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqStopExpedition", spriteID)
    end
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_STOP_EXPEDITION, nil)
end


function NetNPCSystem:reqCollectCancel(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqCollectCancel",spriteID)
    end

    local params = {}
    params.spriteID = spriteID
    Net.Helper:sendMessage(NetMessageType.NPC_COLLECT_CANCEL_REQ, params)
end

function NetNPCSystem:reqCollectStart(spriteID)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqCollectStart", spriteID)
    end

    local params = {}
    params.spriteID = spriteID
    Net.Helper:sendMessage(NetMessageType.NPC_COLLECT_START_REQ, params)
end

function NetNPCSystem:reqQuickExpedition(itemNum, model, level)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqQuickExpedition", itemNum, model, level)
    end

    local params = {}
    params.spriteID = 0
    params.diamond = 0
    params.itemNum = itemNum
    params.caveMode = model
    params.caveLevel = mvc.expeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(model, level)

    Net.Helper:sendMessage(NetMessageType.NPC_REQ_QUICK_EXPEDITION, params)
end

function NetNPCSystem:reqUpdateExpeditionLV(model, checkPoint)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqUpdateExpeditionLV", model, checkPoint)
    end
    -- if(mvc.expeditionModel:getExpeditionStatus()) then 
        local params = {}
        params.mode = model
        params.diffcult = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
        params.lv = mvc.expeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(model, checkPoint)

        Net.Helper:sendMessage(NetMessageType.NPC_MODIFY_EXPEDITION_LV, params)
    -- else 
    --     self:reqStartExpedition(nil, model, checkPoint)
    -- end
end

-- 请求新的分解
function NetNPCSystem:reqNeqNewDecomposeEquip(spriteID, packetType, goodsArr)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqNeqNewDecomposeEquip", spriteID, packetType, goodsArr)
    end

    local params = {}
    params.instIds = {}
    params.packetType = packetType
    if(goodsArr) then 
        for k,v in ipairs(goodsArr) do 
            if(v:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or v:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                table.insert(params.instIds, v:getEntityID())
            end
        end
    end

    Net.Helper:sendMessage(NetMessageType.NPC_REQ_NEW_DECOMPOSE_EQUIP, params)
end

-- 请求新的卖掉接口
function NetNPCSystem:reqNewSellGoods(packetType, goodsDataArr)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqNewSellGoods", spriteID)
    end

    self:_sellGoodsArrHandler(packetType, goodsDataArr)
end

function NetNPCSystem:_sellGoodsArrHandler(packetType, goodsDataArr)
    local sellBagGoods = {}
    local sellEquipGoods = {}
    local sellWarehouse = {}

    if(goodsDataArr) then
        for k,goodsData in ipairs(goodsDataArr) do 
            local buyGoods = {}
            buyGoods.num = goodsData:getNum()
            if(goodsData:getBagType() == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then
                buyGoods.entityID = 0
                buyGoods.templateID = 0
                if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
                    buyGoods.entityID = goodsData:getEntityID()
                else
                    buyGoods.templateID = goodsData:getGoodsID()
                end
                buyGoods.isGolden = goodsData:getIsGolden()
                table.insert(sellWarehouse,buyGoods)
            elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                buyGoods.templateID = 0
                buyGoods.isGolden = goodsData:getIsGolden()
                buyGoods.entityID = goodsData:getEntityID()
                if(GameDataManager:getInstance():judgeIsEquipmentData(buyGoods.entityID)) then
                    table.insert(sellEquipGoods,buyGoods)
                else 
                    table.insert(sellBagGoods,buyGoods)
                end 
                buyGoods.num = 1
            else
                
                buyGoods.templateID = goodsData:getGoodsID()
                buyGoods.isGolden = goodsData:getIsGolden()
                buyGoods.entityID = 0
                table.insert(sellBagGoods,buyGoods)
            end
        end
    end

	-- CO-8525 装备分解与出售的优化（客户端 把出售接口统一了。
    if(packetType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
        GameManager:sendSellFunction(nil, sellEquipGoods, 0, sellBagGoods, nil)
    elseif(packetType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then  
        GameManager:sendSellFunction(nil, sellEquipGoods, 0, nil, sellBagGoods)
    else 
        GameManager:sendSellFunction(sellBagGoods, sellEquipGoods, 0, nil, nil, sellWarehouse)
    end

    -- local params = {}
    -- params.sellBagGoods = sellBagGoods
    -- params.sellEquipGoods = sellEquipGoods
    -- params.packetType = packetType
    -- -- print("NetNPCSystem:_sellGoodsArrHandler(", params)
    -- Net.Helper:sendMessage(NetMessageType.NPC_REQ_NEW_SELL_GOODS, params)
end

function NetNPCSystem:reqQuickComposeGem(gemLevel, isGemStone, isGemCrystal)
    if DEBUG then
        print ("[Net.NetNPCSystem] reqQuickComposeGem", gemLevel, isGemStone, isGemCrystal)
    end

    local remodelData = {}
    remodelData.gemLevel = gemLevel
    remodelData.isGemStone = isGemStone
    remodelData.isGemCrystal = isGemCrystal

    Net.Helper:sendMessage(NetMessageType.NPC_REQ_QUICK_COMPOSE_GEM, remodelData)
end

function NetNPCSystem:reqExpeditionReward(packetType, goodsArr)
    local messageData = {}
    -- 组装请求数据
    messageData.fromPacketType = packetType

    messageData.goodsIDs = {}
    if(goodsArr and #goodsArr > 0) then 
        -- 把物品排序
        GoodsDataManager:handleGoodsSort(goodsArr)

        local num = GameDataManager:getInstance():getFreePacketBoxNum()
        for k,v in pairs(goodsArr) do
            if(num <= 0) then 
                break
            end
            num = num - 1
            local oneData = {}
            if v:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or v:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                oneData.entityID = v:getEntityID()
                oneData.num = 1
            else
                oneData.templateID = v:getGoodsID()

                oneData.num = v:getNum()
            end
            oneData.isGolden = v:getIsGolden()
            
            table.insert(messageData.goodsIDs, oneData)
        end
    end

    -- print("NetNPCSystem:_sellGoodsArrHandler(", messageData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_EXPEDITION_GET_AWARD, messageData)
end

function NetNPCSystem:reqEquipRemoveLevel(spriteID, goodsData)
    -- print("NetNPCSystem:reqEquipRemoveLevel")
    if(goodsData) then
        if(GameManager:getIsInNPCSpriteID2Zero()) then 
            spriteID = 0
        end
        local params = {}
        params.instID = goodsData:getEntityID()
        params.npcid = spriteID
        params.packetType = goodsData:getBagType()
        -- print("NetNPCSystem:reqEquipRemoveLevel 2", params)
        Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_EQUIP_LEVEL_REMOVE, params)
    end
end

-- 快捷购买请求
function NetNPCSystem:reqFastBuy(id, seq)
    if id == nil or seq == nil then
        print("reqFastBuy param is nil")
        return
    end

    local messageData = {}
    messageData.id = id
    messageData.seq = seq
    Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_FAST_BUY, messageData)
end

-- 购买梦境宝库请求
function NetNPCSystem:reqBuyDreamValut(id, index)
    local messageData = {}
    messageData.id = id
    messageData.buyIndex = index
    Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_BUY_DREANM_VALUT, messageData)
end

-- 购买梦境宝库请求
function NetNPCSystem:reqBuyDreamValut(id, index)
    local messageData = {}
    messageData.id = id
    messageData.buyIndex = index
    Net.Helper:sendMessage(NetMessageType.NPC_REQUEST_BUY_DREANM_VALUT, messageData)
end

--改造继承请求
function NetNPCSystem:sendRemodelInherit(data,spriteID)
    local inheritData = {}
    inheritData.remodelEquipInstID = data.leftData.remodelEquipInstID
    inheritData.remodelEquipPacket = GameDataManager:getInstance():getGoodsPacketType(data.leftData.GoodsData)
    inheritData.inheritEquipInstID = data.rightData.remodelEquipInstID
    inheritData.inheritEquipPacket = GameDataManager:getInstance():getGoodsPacketType(data.rightData.GoodsData)
    inheritData.inheritAttrType = data.inheritType.inheritAttrType

    if(DEBUG) then
        dump(inheritData)
    end
    print("sendRemodelInherit-->: ", inheritData)
    local data = ProtobufUtil:encode("NPCSystem.InheritMessage", inheritData)
    Net.NetNPCSystem:useFunctionRequest(data, PublicDefine.FUNCTION_TYPE.FUNCTION_EQUIPMENT_INHERIT, spriteID)
end

--请求替换改造继承数据
function NetNPCSystem:sendRemodelInheritReplace(data,spriteID)
    local inheritData = {}
    inheritData.equipInstanceID = data.equipInstanceID
    inheritData.equipPacketType = GameDataManager:getInstance():getGoodsPacketType(data.GoodsData)
    inheritData.npcID = spriteID


    if(DEBUG) then
        dump(inheritData)
    end
    Net.Helper:sendMessage(NetMessageType.NPC_REMODEL_REQ_INHERIT_REPLACE_RESULT, inheritData)
end

-- 请求雕纹锻造
function NetNPCSystem:reqComposeGlyphs(itemLevelList)
    local messageData = {}
    messageData.itemLevel = itemLevelList
    Net.Helper:sendMessage(NetMessageType.NPC_GLYPHS_COMPOSE_REQ, messageData)
end

-- 请求雕纹洗练
function NetNPCSystem:sendGlyphRefine(data)
    local refineData = {}
    refineData.refineType = data.refineType    -- 洗练类型
    refineData.glyphuid = data.glyphuid        -- 实例ID
    refineData.equipuid = data.equipuid        -- 装备上的雕文洗练，以装备的实例ID为主
    refineData.packetType = data.packetType    -- 装备所在的背包

    if(DEBUG) then
        dump(refineData)
    end
    print("sendGlyphRefine-->: ", refineData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_REFINE_MESSAGE, refineData)
end

-- 请求洗练确认
function NetNPCSystem:sendGlyphRefineConfirm(data)
    local refineConfirmData = {}
    refineConfirmData.glyphuid = data.glyphuid         -- 实例ID
    refineConfirmData.isGet = data.isGet               -- 替换或者放弃洗练结果
    refineConfirmData.equipuid = data.equipuid         -- 装备上的雕文洗练，以装备的实例ID为主
    refineConfirmData.packetType = data.packetType     -- 装备所在的背包

    if(DEBUG) then
        dump(refineConfirmData)
    end
    print("sendGlyphRefineConfirm-->: ", refineConfirmData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_REFINE_CONFIRM_MESSAGE, refineConfirmData)
end

--请求快速洗练
function NetNPCSystem:sendGlyphQuickRefineMessage(data)
    local refineData = {}
    refineData.refineType = data.refineType    -- 洗练类型
    refineData.glyphuid = data.glyphuid        -- 实例ID
    refineData.equipuid = data.equipuid        -- 装备上的雕文洗练，以装备的实例ID为主
    refineData.packetType = data.packetType    -- 装备所在的背包
    refineData.refineNum = data.refineNum       --洗练次数
    print("sendGlyphQuickRefineMessage-->: ", refineData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_QUICK_REFINE_MESSAGE, refineData)
end

-- 请求雕纹镶嵌
function NetNPCSystem:sendGlyphEquip(data)
    local messageData = {}
    messageData.glyphuid = data.glyphuid            -- 雕纹实例ID
    messageData.equipuid = data.equipuid            -- 装备实例ID
    messageData.packetType = data.packetType        -- 装备所在的背包

    if(DEBUG) then
        dump(messageData)
    end
    print("sendGlyphEquip-->: ", messageData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_EQUIP_MESSAGE, messageData)
end

-- 请求卸载雕纹
function NetNPCSystem:sendGlyphUnEquip(data)
    local messageData = {}
    messageData.equipuid = data.equipuid        -- 装备实例ID
    messageData.packetType = data.packetType        -- 装备所在的背包

    if(DEBUG) then
        dump(messageData)
    end
    print("sendGlyphUnEquip-->: ", messageData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_UNEQUIP_MESSAGE, messageData)
end

-- 雕纹分解消息
function NetNPCSystem:sendGlyphDecompose(data)
    local messageData = {}
    messageData.glyphuids = data       -- 分解雕纹id

    if(DEBUG) then
        dump(messageData)
    end
    print("sendGlyphDecompose-->: ", messageData)
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_GLYPH_DECOMPOSE_MESSAGE, messageData)
end

-- 雕纹继承
function NetNPCSystem:reqInheritGlyphs(mainGlyphuid, materialGlyphuid, lockAttrType, chooseAttrType)
    local messageData = {}
    messageData.mainGlyphuid = mainGlyphuid
    messageData.materialGlyphuid = materialGlyphuid
    messageData.lockAttrType = lockAttrType
    messageData.chooseAttrType = chooseAttrType
    Net.Helper:sendMessage(NetMessageType.NPC_GLYPHS_INHERIT_REQ, messageData)
end

-- 原石分解消息
function NetNPCSystem:sendPrimoGemDecompose(data)
    local messageData = {}
    messageData = data

    if(DEBUG) then
        dump(messageData)
    end
    
    Net.Helper:sendMessage(NetMessageType.NPC_REQ_PRIMOGEM_DECOMPOSE_MESSAGE, messageData)
end

function NetNPCSystem:onNPCMessageHandler(no, data)
    -- print(string.format("[Net.NetNPCSystem] onNPCMessageHandler no:%d.", no))
    if (DEBUG) then
        if data and type(data) == "table" then
            for k,v in pairs(data) do 
                if type(v) == "table" then
                    print("[Net.NetNPCSystem] onNPCMessageHandler  k="..k.."  v=")
                end
            end
        end
    end 
     
    if (no == NetMessageType.NPC_TRIGGER_NPC.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_TRIGGER_NPC ",data.spriteID)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_OPEN, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.NPC_TRIGGER_NPC_FAILED.NO) then 
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_TRIGGER_NPC_FAILS, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.NPC_TRIGGER_NPC_UNLOCK.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_TRIGGER_NPC_UNLOCK ",data.spriteID)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_TRIGGER_NPC_UNLOCK,data)
        SceneManager:getInstance():pushCommand(command)
    -- 金矿请求状态
    elseif (no == NetMessageType.NPC_RESPONSE_GOLDEN_MINE.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_RESPONSE_GOLDEN_MINE ")
            dump(data)
        end

        printInfo("收到金矿数据", data)
        if (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsRspGoldenMineGetInfo")) then
            --{subMsgNo = 10, rspGetInfo = {errorNo = "Succeed", goldenMineData = {beginCalTime = 598006693, lv = 6, output = 0, activeJobTime = 0}}}
            local rspGetInfo = data.rspGetInfo
            if(rspGetInfo and rspGetInfo.errorNo and rspGetInfo.errorNo == "Succeed") then 
                require "app.datas.HomeDataManager"
                HomeDataManager:initNetGoldenMine(rspGetInfo.goldenMineData)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_UPDATE)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111525)) --"获取金矿信息出错"                
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsRspGoldenMineUpgradeLv")) then
            --{subMsgNo = 12, rspUpgradLv = {errorNo = "Succeed"}}
            local rspUpgradLv = data.rspUpgradLv
            if (rspUpgradLv and rspUpgradLv.errorNo and rspUpgradLv.errorNo == "Succeed") then
                HomeDataManager:goldenMineLvUp()
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_LVUP)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111526)) --"金矿升级出错" 
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsRspGoldenMineGetOutput")) then
            --{subMsgNo = 14, rspGetOutput = {output = 40000}}
            local rspGetOutput = data.rspGetOutput
            if (rspGetOutput and rspGetOutput.output ~= nil) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_OUTPUT_RECEIVED)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111527)) --"收取金矿出错"
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GOLDEN_MINE_MESSAGE_TYPE", "Type_CsRspGoldenMineCompleteJob")) then
            --{subMsgNo = 16, rspCompleteJob = {errorNo = "Succeed"}}
            local rspCompleteJob = data.rspCompleteJob
            if (rspCompleteJob and rspCompleteJob.errorNo and rspCompleteJob.errorNo == "Succeed") then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_BOOST_START)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111528)) --"金矿加速出错" 
            end
        else
            -- 无效回复ID
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111529)) --"金矿系统错误"
        end
        -- 工坊请求状态
    elseif (no == NetMessageType.NPC_RESPONSE_GEM_FACTORY.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_RESPONSE_GEM_FACTORY ")
            dump(data)
        end

        printInfo("收到符文工坊数据", data)
        if (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsRspGemFactoryGetInfo")) then
            --{subMsgNo = 10, rspGetInfo = {errorNo = "GemFactoryErrorNo_Succeed", gemFactoryData = {equiprarity = {3, 3, 3}, lv = 1, activeJobTime = 0, beginCalTime = 598063585, output = 0, equipPart = {3, 1, 8}}}}
            local rspGetInfo = data.rspGetInfo
            if(rspGetInfo and rspGetInfo.errorNo and rspGetInfo.errorNo == "GemFactoryErrorNo_Succeed") then 
                require "app.datas.HomeDataManager"
                HomeDataManager:initNetRuneFactory(rspGetInfo.gemFactoryData)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GEM_FACTORY_UPDATE)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111530)) --"获取符文工坊信息出错"                
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsRspGemFactoryUpgradeLv")) then
            --{subMsgNo = 12, rspUpgradLv = {errorNo = "GemFactoryErrorNo_Succeed"}}
            local rspUpgradLv = data.rspUpgradLv
            if (rspUpgradLv and rspUpgradLv.errorNo and rspUpgradLv.errorNo == "GemFactoryErrorNo_Succeed") then
                HomeDataManager:runeFactoryLvUp()
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GEM_FACTORY_LVUP)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111531)) --"符文工坊升级出错" 
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsRspGemFactoryGetOutput")) then
            --{subMsgNo = 14, rspGetOutput = {errorNo = "GemFactoryErrorNo_Succeed", output = 0}}
            local rspGetOutput = data.rspGetOutput
            if (rspGetOutput and rspGetOutput.output ~= nil) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GEM_FACTORY_OUTPUT_RECEIVED, rspGetOutput.output)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111532)) --"收取符文工坊出错"
            end
        elseif (data.subMsgNo == ProtobufUtil:enum_id("NPCSystem.GEM_FACTORY_MESSAGE_TYPE", "Type_CsRspGemFactoryCompleteJob")) then
            --{subMsgNo = 16, rspCompleteJob = {errorNo = "GemFactoryErrorNo_Succeed"}}
            local rspCompleteJob = data.rspCompleteJob
            if (rspCompleteJob and rspCompleteJob.errorNo and rspCompleteJob.errorNo == "GemFactoryErrorNo_Succeed") then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_HOME_GEM_FACTORY_BOOST_START)
            else
                -- 报个错
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111533)) --"符文工坊加速出错" 
            end
        else
            -- 无效回复ID
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111534)) --"符文工坊系统错误"
        end
    -- 卖出物品状态
    elseif (no == NetMessageType.NPC_SELL_GOODS_RESULT.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_SELL_GOODS_RESULT ")
            dump(data)
        end
        -- 卖出物品的结果处理
        local sellGoods = data.sellBagGoods
        -- 处理添加卖出或则丢弃数据处理
        for k,sellData in pairs(sellGoods) do 
            local key = sellData.templateID..":"..tostring(sellData.isGolden)
            -- 这里有一些和业务逻辑绑定的处理
            if(sellData.entityID ~= 0) then
                key = sellData.entityID
            end
            local num = sellData.num
    
            local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA)
            if(repeatData == nil) then
                repeatData = {}
            end
    
            if(repeatData[key]) then
                repeatData[key] = repeatData[key] - num
                if(repeatData[key] < 0) then 
                    repeatData[key] = 0
                end
            end
            MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA, key, repeatData[key])
        end 

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, data)
    elseif (no == NetMessageType.NPC_USE_FUNCTION_RES.NO) then
        if data.functionType ==  PublicDefine.FUNCTION_TYPE.EQUIP_SET_CHANGE then
            if mvc.recastController then
                local goodsData = ProtobufUtil:decode("NPCSystem.EquipSetChangeResultData",data.resultData)
                mvc.recastController:updateEquipTransformResult(data, goodsData.desEquipInstID)
            end
        elseif data.functionType ==  PublicDefine.FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM then
            if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
                GameErrorManager:showError(data.result)
            else
                mvc.send(mvc.events.GhostabyssSelectResponse, data)
            end
        elseif data.functionType ==  PublicDefine.FUNCTION_TYPE.FUNCTION_BOSS_PORTAL then
            if(data.result == 5) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BOSS_DIRECT_UNLOCK)
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BOSS_DIRECT_CLOSEWIN)
        elseif data.functionType ==  PublicDefine.FUNCTION_TYPE.FUNCTION_BARTER then
            dump(data, "FUNCTION_BARTER")
            if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
                GameErrorManager:showError(data.result)
            else
                mvc.send(mvc.events.Barter_Table_Result, data)
            end
        end
    -- 购买物品成功
    elseif (no == NetMessageType.NPC_BUY_GOODS_SUCCEED.NO) then
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_BUY_GOODS_SUCCEED ")
        end
        
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY)
        if(repeatData[data.goodsNo]) then
            repeatData[data.goodsNo] = repeatData[data.goodsNo] - data.goodsQuantity
        end
        if(data.result == "BuyGoodsResult_Succeed") then 
            -- 购买物品成功
            RoleDataManager:handleCaveShopBuySuccessData(data)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.BuyGoodsResult", data.result))
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.BAG_CAVE_SHOP_BUY)
        end
        
        -- 发送商店数据改变消息
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CAVE_SHOP_DATA_CHANGE, data)
    -- 初始化功能NPC
    elseif (no == NetMessageType.NPC_FUNCTION_ARCHIVE.NO) then 
        -- 初始化功能NPC 数据
        if (DEBUG) then
            print("Net.NetNPCSystem:onNPCMessageHandler NPC_FUNCTION_ARCHIVE ")
        end
        -- dump(data)
        
        RoleDataManager:handleInitFunctionData(data)
    -- 点金结果消息
    elseif (no == NetMessageType.NPC_GOLD_TOUCH_RESULT.NO) then 
        -- 初始化功能NPC 数据
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_GOLD_TOUCH_RESULT ")
        end

        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.NPC_GOLDEN)

        if(data.result == "GoldTouchResultType_Succeed" and data.equipmentInstanceID ~=0) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
            if(equipmentData) then
                -- 添加一条属性
                equipmentData:handleAddOneRandomAttr(data.attr)
                equipmentData:setIsGolden(true)
                
                GoodsDataManager:sortGoods(RoleDataManager:getMasterPK(),PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                -- local wearData = GameDataManager:getInstance():getWearEquipmentData()
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_GOLD_TOUCH_RESULT  not found equipment  entityID=%d",ata.equipmentInstanceID))
            end
        end

        if(data.result == "GoldTouchResultType_Succeed") then
            RoleDataManager:handleCaveGoldTouchSuccess()

            -- 发送状态改变指令
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_NPC_GOLD_TOUCHED_REFRESH, data)
            SceneManager:getInstance():pushCommand(command)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GOLD_POINTING, data)
        
    elseif (no == NetMessageType.NPC_EQUIP_REFINE_RESPONSE.NO) then 
        if mvc.recastController then
            local goodsData = ProtobufUtil:decode("GoodsSystem.EquipmentData",data.good.goodsDataBytes)
            mvc.recastController:refineResult(data, goodsData.entityID)
        end
    -- 附魔结果消息
    elseif (no == NetMessageType.NPC_ENCHANT_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_ENCHANT_RESULT ")
        end

        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.NPC_ENCHANT)
        if(data.result == "EnchantResultType_Succeed" and data.equipmentInstanceID ~=0) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
            if(equipmentData) then
                -- 修改附魔属性
                equipmentData:handleAddOneRandomAttr(data.attr)
                
                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_ENCHANT_RESULT  not found equipment  entityID=%d",ata.equipmentInstanceID))
            end
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_ENCHANTMENT, data)
    -- 装备改造结果消息
    elseif (no == NetMessageType.NPC_REMODEL_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_REMODEL_RESULT ")
        end
        
        if(data.flag == "RemodelResultType_Succeed") then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
            if(equipmentData) then
                -- 修改附魔属性
                equipmentData:setTmpRemodelAttr(data.attr, true)
                equipmentData:transformAttrByType(data.remodelAttrType)
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL, data, false)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_REMODEL_RESULT  not found equipment  entityID=%d",ata.equipmentInstanceID))
            end
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RemodelResultType",data.flag))
            UI.WaitingLayer:hideWaiting()
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_FAIL)
        end
        if data.rebateNum > 0 then
            -- local giftList = string.split(ConfigManager:getGeneralForKey("Rehabilitationofdiamonds"), ",")
            -- local giftStr = giftList[data.rebateNum] or giftList[1]
            -- local giftId = checkint(string.split(giftStr, ";")[2])
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, Game.NpcDialog.RemouldEquip, function()
                UI.ScrollBar:createByText(UI.TEXT_1212213)
            end)
            -- Net.NetRoleSystem:giftRequst(giftId)
        end
    elseif (no == NetMessageType.NPC_SURE_REPONSE_REMODEL_RESULT.NO) then 
        if (DEBUG) then
            print("++++++++++++Net.NetNPCSystem NPC_SURE_REPONSE_REMODEL_RESULT ", data)
        end
        
        if(data.errorNo == "RemodelResultType_Succeed") then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipInstanceID)
            if(equipmentData) then
                -- 修改附魔属性
                if data.isCanle then
                    equipmentData:clearTmpRemodelAttr()
                else
                    equipmentData:replaceTmpRemodelAttr(data.remodelAttrType)
                end
                                
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL, data, true, data.isCanle)
                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_REMODEL_RESULT  not found equipment  entityID=%d",data.equipmentInstanceID))
            end
        else
            UI.WaitingLayer:hideWaiting()
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RemodelResultType", data.errorNo))
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_FAIL)
        end
    -- 装备强化结果消息
    elseif (no == NetMessageType.NPC_STRENGTHEN_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_STRENGTHEN_RESULT ")
            dump(data)
        end

        if(data.flag == "StrengthenResultType_Succeed") then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
            if(equipmentData) then
                -- 修改强化等级
                equipmentData:updateStrengthenLevel(data.equipmentLv)
                
                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_STRENGTHEN_RESULT  not found equipment  entityID=%d",data.equipmentInstanceID))
            end
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.STRENGTHEN)
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_STRENGTHEN, data)
    elseif (no == NetMessageType.NPC_TRAP_EFFECT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_TRAP_EFFECT ")
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TRAP_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    
    -- 处理购买结果
    elseif (no == NetMessageType.NPC_EXCHANGE_BLACK_MARKET_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_EXCHANGE_BLACK_MARKET_RESULT ")
            dump(data)
        end

        -- 处理清理数据
        MasterDataManager:removeRepeatHandleData(RepeatHandleType.BAG_BLACK_SHOP_BUY, data.pos)

        if(data and data.blackMarketGoods and ProtobufUtil:checkFieldIsInit(data, "blackMarketGoods")) then 
            MasterDataManager:refreshBlackMarketData(data.blackMarketGoods)
        end

        if(data.flag == "ExchangeBlackMarketResultType_Succeed") then
            MasterDataManager:handleBlackMarketBuy(data)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_BLACK_SHOP_EXCHANGE_RESULT, data)
        -- 发送物品改变
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_BLACK_SHOP_DATA_CHANGE, MasterDataManager:getBlackMarketData())
    -- 黑商信息
    elseif (no == NetMessageType.NPC_BLACK_MARKET.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_BLACK_MARKET ")
            print(data)
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.BAG_BLACK_SHOP_BUY)
        MasterDataManager:handleBlackMarketData(data)

    -- 处理购买结果
    elseif (no == NetMessageType.NPC_EXCHANGE_RANDOMSHOP_MARKET_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_EXCHANGE_RANDOMSHOP_MARKET_RESULT ")
            dump(data)
        end
        -- 处理清理数据
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_RANDOM_SHOP_BUY)
        if(repeatData) then 
            local key = string.format("%s:%s", data.itemID, data.costType)
            if(repeatData[key]) then
                repeatData[key] = repeatData[key] - data.num
            end
        end

        if(data.result == ProtobufUtil:enum_id("NPCSystem.RamdomshopBuyResult", "RamdomshopBuyResult_Succeed")) then
            MasterDataManager:handleRandomShopBuy(data)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_RANDOM_SHOP_EXCHANGE_RESULT, data)
        -- 发送物品改变
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_RANDOM_SHOP_DATA_CHANGE, MasterDataManager:getRandomShopData())
    -- 随机商店信息
    elseif (no == NetMessageType.NPC_RANDOMSHOP_MARKET.NO) then 
        -- if (DEBUG) then
            print("Net.NetNPCSystem NPC_RANDOMSHOP_MARKET ")
            dump(data)
        -- end
        
        MasterDataManager:handleRandomShopData(data)
    -- 装备分解结果消息
    elseif (no == NetMessageType.NPC_RESOLVE_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_RESOLVE_RESULT ")
            dump(data)
        end
        if(data.result == "DecomposeResultType_Succeed") then
              --有动画 所以延时提示
            -- Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                local showTexts = {}
                for k, v in ipairs(data.decomposeDatas) do
                    if(v.materialID > 0) then
                        local iconName = "..."
                        local materialData =GoodsDataManager:createLocalGoodsData(v.materialID)
                        if(materialData) then
                            iconName = materialData:getName()
                        end
                        local materialNum = v.materialNum
                        if showTexts[v.materialID] == nil then
                            local data = {}
                            data.iconName = iconName
                            data.materialNum = materialNum
                            showTexts[v.materialID] = data
                            data.goodsData = materialData
                        else
                            local data = showTexts[v.materialID]
                            data.materialNum = data.materialNum + materialNum
                            showTexts[v.materialID] = data
                        end
                    end
                end
                for k, v in pairs(showTexts) do
                    if(v.goodsData) then 
                        local str = UI.TEXT_1170325
                        if v.materialNum > 1 then
                            str = str.." x"..v.materialNum
                        end
                        local linkStr = Game.ChatManager:getInstance():getItemLinkStr(v.goodsData)
                        if not linkStr then
                            return
                        end
                        local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, str, you, linkStr)

                        -- local linkStr = Game.ChatManager:getInstance():getItemLinkStr(v.goodsData)
                        -- local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                        -- Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1170325, you, linkStr)
                    end
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1110401, v.iconName, v.materialNum))
                end
            -- end, 1.5)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.DecomposeResultType",data.result))
        end
        UI.WaitingLayer:hideWaiting()
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.RESOLVE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_RESOLVE,data)
         -- 装备分解结果消息
    elseif (no == NetMessageType.NPC_FORGE_RESULT.NO) then 

        if (DEBUG) then
            print("Net.NetNPCSystem NPC_FORGE_RESULT ")
            dump(data)
        end

        if data.result == "ForgeType_Succeed" then
            --有动画 所以延时提示
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                local goodsData = GoodsDataManager:createLocalGoodsData(data.equipTempID)
                local iconName = "..."
                if(goodsData) then
                    iconName = goodsData:getName()
                end

                UI.ScrollBar:createByText(string.format(UI.TEXT_110211, iconName))
            end, 3)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.ForgeResultType",data.result))
        end

        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.FORGE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_FORGE,data)

     -- 捏脸结果消息
    elseif (no == NetMessageType.NPC_FACELIFT_RESULT.NO) then 

        if (DEBUG) then
            print("Net.NetNPCSystem NPC_FORGE_RESULT ")
        end
        dump(data)

        if data.result == "FaceliftResultType_Succeed" then
            local heroData = RoleDataManager:getMaster()
            
            if(heroData) then
                heroData:setFaceDecodeID(data.faceId)
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_SCREEN_FACE_CHANGE, heroData)
                SceneManager:getInstance():pushCommand(command)
            end

            UI.ScrollBar:createByText(UI.TEXT_1150018)
        else
            -- GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.FaceliftResultType",data.result))
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.BEAUTYSALON)
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_CHANGE_FACE,data)
    -- 猫饭结果消息
    elseif (no == NetMessageType.NPC_CATFOOD_RESULT.NO) then 
        print("--------Net.NetNPCSystem NPC_CATFOOD_RESULT ")
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_CATFOOD_RESULT ")
            dump(data)
        end

        MasterDataManager:removeRepeatHandleData(RepeatHandleType.NPC_CAT_FOOD, data.catFoodID)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_CATFOOD, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.NPC_TURNTABL_RESULT.NO) then
        dump(data)     
        if data.result == "LuckyWheelResultType_Succeed" then
            if data.type == "LuckyWheelType_Buy" then
                local turnTableData = GameDataManager:getInstance():getTurnTableData()
                GameDataManager:getInstance():setTurnTableData(turnTableData.dropListId, turnTableData.hasBuyNum + 1, turnTableData.leftTurnNum + 1, turnTableData.hasTurnNum, turnTableData.generateTime)
                MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.TURN_TABLE_BUY)
            elseif data.type == "LuckyWheelType_Turn" then
                local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyWheel)
                if( not (activityData and activityData:isInEffect())) then 
                    local turnTableData = GameDataManager:getInstance():getTurnTableData()
                    if ProtobufUtil:checkFieldIsInit(data, "isUseAds") and data.isUseAds then
                    else
                        GameDataManager:getInstance():setTurnTableData(turnTableData.dropListId, turnTableData.hasBuyNum, turnTableData.leftTurnNum - 1, turnTableData.hasTurnNum + 1, turnTableData.generateTime)
                    end
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
                end
            end
        elseif data.result == "LuckyWheelResultType_TimeOver" then
             GameDataManager:getInstance():clearTurnTableData()
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.LuckyWheelResultType",data.result))
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_TRIGER_TURNTABLE,data)
    elseif (no == NetMessageType.NPC_TURNTABLE_INFO.NO) then
        local generateTime = GameManager:getNowServerTime()
        GameDataManager:getInstance():setTurnTableData(data.listID, data.hasBuyNum, data.leftTurnNum, data.hasTurnNum, generateTime)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_LUCKDROP_REFRESH,data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    elseif no == NetMessageType.NPC_CONTRIBUTE_GUILD_TECH_RESULT.NO then
        print("--------Net.NetNPCSystem NPC_CONTRIBUTE_GUILD_TECH_RESULT ",data.result, data.contributeNum)
        if data.result == "ContributeGuildTechResultType_ReachedMedalUseLimit" then
            if data.remainUseLimit == 0 then
                UI.ScrollBar:createByTextID(UI.TEXT_1213879)
            else
                UI.ScrollBar:createByTextID(string.format(UI.TEXT_1213878, data.remainUseLimit))
            end
        elseif data.result == "ContributeGuildTechResultType_NoPermit" then
            UI.ScrollBar:createByTextID(UI.TEXT_1213877)
        elseif(data.result ~= "ContributeGuildTechResultType_Succeed") then
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.ContributeGuildTechResultType",data.result))
        end
        
        if (data.result == "ContributeGuildTechResultType_Succeed") then
            local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_LEARN_TECH)
            if(repeatData) then 
                repeatData = tonumber(repeatData) - data.contributeNum
                MasterDataManager:setRepeatHandleData(RepeatHandleType.GUILD_LEARN_TECH,repeatData)
            end
        end

        -- Avalon.MessageCenter:notice(AvalonMessage.MC_DATA_GUILD_GUILD_TECH_RESULT)
        mvc.send(mvc.events.GuildTechOrSkill_GuildTechResult, data)
    elseif no == NetMessageType.NPC_ACHIEVEMENTAWARD_RESULT_MESSAGE.NO then
        print("NPC_ACHIEVEMENTAWARD_RESULT_MESSAGE",data.result)

        MasterDataManager:removeRepeatHandleData(RepeatHandleType.NPC_ACHIEVEMENT, data.achievementId)

        if(data.result ~= "AchievementAwardResultType_Succeed") then
             GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.AchievementAwardResultType",data.result))
        else
            -- 先更新数据
            MasterDataManager:refreshAchevementDataByResult(data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ACHIEVEMENT_RESULET,data)

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
            SceneManager:getInstance():pushCommand(command)
        end

    -- 响应手动刷新黑商消息 
    elseif no == NetMessageType.NPC_RESPONSE_MANUAL_REFRESH_BLACK_MARKET.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_RESPONSE_MANUAL_REFRESH_BLACK_MARKET.NO")
            dump(data)
        end
        GameErrorManager:showError(data.result)
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_BLACK_SHOP_ACTIVITY_REFRESH)

    -- 响应手动刷新随机商人消息 
    elseif no == NetMessageType.NPC_RESPONSE_MANUAL_REFRESH_RANDOMSHOP_MARKET.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_RESPONSE_MANUAL_REFRESH_RANDOMSHOP_MARKET.NO")
            dump(data)
        end
        GameErrorManager:showError(data.result)
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_RANDOM_SHOP_ACTIVITY_REFRESH)

    -- 移除陷阱
    elseif no == NetMessageType.NPC_TRAP_REMOVE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_TRAP_REMOVE.NO")
            dump(data)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTORL_TRAP_REMOVE, data)
        SceneManager:getInstance():pushCommand(command)
    --宝石合成
    elseif no == NetMessageType.NPC_GEM_SYNTHESIS_REPONSE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_GEM_SYNTHESIS_REPONSE.NO")
            dump(data)
        end
        local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
        if(equipmentData) then 
            equipmentData:resetHoleData(data.holes)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_SYNTHESIS, data)
        
    --宝石镶嵌
    elseif no == NetMessageType.NPC_GEM_INLAID_REPONSE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_GEM_INLAID_REPONSE.NO")
            dump(data)
        end
        -- 处理镶嵌的逻辑
        if(data.result == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidResult", "EquipGemstoneInlaidResult_Succeed")) then
            GoodsDataManager:handleInlayData(data)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_INLAY, data)
    --宝石购买
    elseif no == NetMessageType.NPC_GEM_SHOP_BUY_REPONSE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_GEM_SHOP_BUY_REPONSE.NO")
            dump(data)
        end

        if data.result == 191 then
            UI.ScrollBar:createByTextID(1113622)
        else
            MasterDataManager:refreshOneGemstoneShopRecord(data.gemstoneBoughtRecord,data.exp)
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_SHOP_BUY, data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    --宝石转换
    elseif no == NetMessageType.NPC_GEM_TRANSFORM_REPONSE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_GEM_TRANSFORM_REPONSE.NO")
            dump(data)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_TRANSFORM, data)
    -- 技能进阶
    elseif no == NetMessageType.NPC_RESPONSE_SKILL_ADVANCED.NO then
        if(DEBUG) then 
            print("NetMessageType.NPC_RESPONSE_SKILL_ADVANCED.NO", data)
            dump(data)
        end
        if(data.result == ProtobufUtil:enum_id("NPCSystem.SkillAdvancedReuslt", "SkillAdvancedReuslt_Ok")) then
            local master = RoleDataManager:getMaster()
            if(master) then
                master:setAdvanceStat(1)
                SkillDataManager:resetSkillTree()
                SkillDataManager:resetSkillTreeConfig()
            end
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SKILL_ADVANCED, data)
        SceneManager:getInstance():pushCommand(command)

        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_SKILL_ADVANCED, data)

    elseif no == NetMessageType.NPC_REQUEST_CONVERT_EQUIP_RSP.NO then
        print("NPC_REQUEST_CONVERT_EQUIP_RSPNPC_REQUEST_CONVERT_EQUIP_RSP")
        print(data)
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.CONVERT)
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_CONVERT, data)


    elseif no == NetMessageType.NPC_DREAM_SHOP.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_DREAM_SHOP.NO")
            dump(data)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_DREAM_SHOP, data)
    elseif no == NetMessageType.NPC_DREAM_SHOP_BUY.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_DREAM_SHOP_BUY.NO")
            dump(data)
        end

        local errStr = "";
        if data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_Unknow") then
            errStr = UI.TEXT_1110372
        elseif data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_NotEnoughBagSpace") then
            errStr = UI.TEXT_1212306
        elseif data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_NotEnoughItem") then
            errStr = UI.TEXT_1212307
        end

        data.errStr = errStr;
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_DREAM_SHOP_BUY, data)
    elseif no == NetMessageType.NPC_RES_EQUIP_FORGE.NO then
        if(DEBUG) then
            print("NetMessageType.NPC_RES_EQUIP_FORGE.NO")
            dump(data)
        end

        GameErrorManager:showError(data.result)

        if data.result == 1 then
            if data.optType == 1 then
                require "app.datas.EquipForgeDataManager"
                EquipForgeDataManager:updateForgeUnlockList(data.scrollID)
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_EQUIP_FORGE_UNLOCK, data)
    elseif no == NetMessageType.NPC_RSP_RECAST_EQUIP.NO then
        UI.WaitingLayer:hideWaiting() 
        if data.errorNo == "EquipRecastErrorNo_OK" then
            local goodsID = data.good.templateID
            local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
            local pk = RoleDataManager:getMasterPK()
            local packetType = data.equipPacketType
            if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                local equipmentData = ProtobufUtil:decode("GoodsSystem.EquipmentData",data.good.goodsDataBytes)
                if data.isSuccess then
                    GoodsDataManager:deleteEquipment(pk, packetType, goodsType, equipmentData.entityID)
                    Net.NetGoodsSystem:_handlePackGood(pk, packetType, nil, 2, data.good)
                    GoodsDataManager:sortGoods(pk, packetType, goodsType)
                end
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_EQUIP_RECAST, data, equipmentData.entityID)
            end
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.EquipRecastErrorNo", data.errorNo))
        end
    elseif no == NetMessageType.NPC_RES_UNLOCK_EQUIP_FORGE.NO then
        require "app.datas.EquipForgeDataManager"
        EquipForgeDataManager:initNet(data.unlockDrawing)

    elseif no == NetMessageType.NPC_EXPEDITION.NO then
        print("NPC_EXPEDITION", data)
        mvc.expeditionModel:updateExpeditionData(data.expeditionData)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
        mvc.send(mvc.events.Expedition_Data_Update, data)
    -- 返回开始探险
    elseif no == NetMessageType.NPC_RESPONSE_START_EXPEDITION.NO then
        --print("NPC_RESPONSE_START_EXPEDITION", data)
        if(ProtobufUtil:checkFieldIsInit(data, "expeditionData")) then
            mvc.expeditionModel:updateExpeditionData(data.expeditionData)
            mvc.send(mvc.events.Expedition_Data_Update, data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
        mvc.send(mvc.events.Expedition_Start_Norml_Result, data)
    -- 返回停止探险
    elseif no == NetMessageType.NPC_RESPONSE_STOP_EXPEDITION.NO then
        --print("NPC_RESPONSE_STOP_EXPEDITION", data)
        if(ProtobufUtil:checkFieldIsInit(data, "expeditionData")) then
            mvc.expeditionModel:updateExpeditionData(data.expeditionData)
        end 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
        mvc.send(mvc.events.Expedition_Stop_Norml_Result, data)
    -- 响应快速探险消息
    elseif no == NetMessageType.NPC_RESPONSE_QUICK_EXPEDITION.NO then
        --print("NPC_RESPONSE_QUICK_EXPEDITION", data)
        if(ProtobufUtil:checkFieldIsInit(data, "expeditionData")) then
            mvc.expeditionModel:updateExpeditionData(data.expeditionData)
            mvc.send(mvc.events.Expedition_Data_Update, data)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
        mvc.send(mvc.events.Expedition_Start_Quick_Result, data)
    -- SC 新分解接口
    elseif no == NetMessageType.NPC_RESPONSE_NEW_DECOMPOSE_EQUIP.NO then
        -- 
        --print("NPC_RESPONSE_NEW_DECOMPOSE_EQUIP", data)

        mvc.send(mvc.events.Expedition_Decompose_Result, data)

        --有动画 所以延时提示
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            local showTexts = {}
            for k, v in ipairs(data.decomposeDatas) do
                local iconName = "..."
                local materialData =GoodsDataManager:createLocalGoodsData(v.materialID)
                if(materialData) then
                    iconName = materialData:getName()
                end
                local materialNum = v.materialNum
                if showTexts[v.materialID] == nil then
                    local data = {}
                    data.iconName = iconName
                    data.materialNum = materialNum
                    showTexts[v.materialID] = data
                else
                        local data = showTexts[v.materialID]
                        data.materialNum = data.materialNum + materialNum
                        showTexts[v.materialID] = data
                end
            end
            for k, v in pairs(showTexts) do
                UI.ScrollBar:createByText(string.format(UI.TEXT_1110401, v.iconName, v.materialNum))
            end
        end, 0.2)


        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
    -- SC 新出售接口
    elseif no == NetMessageType.NPC_RESPONSE_NEW_SELL_GOODS.NO then
        --print("NPC_RESPONSE_NEW_SELL_GOODS", data)
        mvc.send(mvc.events.Expedition_Sell_Goods_Result, data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
    -- 领取奖励物品
    elseif no == NetMessageType.NPC_RESPONSE_EXPEDITION_GET_AWARD.NO then
        --print("NPC_RESPONSE_EXPEDITION_GET_AWARD", data)
        local goldNum = 0
        local expNum = 0
        if(data.result == "RspExpedition_OK") then
            if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
                goldNum = mvc.expeditionModel:getNormalCoin()
                expNum = mvc.expeditionModel:getNormalExp()
            elseif (data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
                goldNum = mvc.expeditionModel:getQuickCoin()
                expNum = mvc.expeditionModel:getQuickExp()
            end
        end 

        if(ProtobufUtil:checkFieldIsInit(data, "expeditionData")) then
            mvc.expeditionModel:updateExpeditionData(data.expeditionData)
            mvc.send(mvc.events.Expedition_Data_Update, data)
        end

        if(data.result == "RspExpedition_OK") then
            if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
                goldNum = goldNum - mvc.expeditionModel:getNormalCoin()
                expNum = expNum - mvc.expeditionModel:getNormalExp()
            elseif (data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
                goldNum = goldNum - mvc.expeditionModel:getQuickCoin()
                expNum = expNum - mvc.expeditionModel:getQuickExp()
            end
        end 

        if(goldNum > 0) then 
            UI.ScrollBar:createByText(string.format(UI.TEXT_1110401, LanguageManager:getInstance():getLocalString(1110725), goldNum))
        end
        if(expNum > 0) then 
            UI.ScrollBar:createByText(string.format(UI.TEXT_1110401, LanguageManager:getInstance():getLocalString(1111852), expNum))
        end

        mvc.send(mvc.events.Expedition_Get_Reward_Result, data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
    -- SC 新出售接口
    elseif no == NetMessageType.NPC_RESPONSE_GUILD_SHOP_BUY.NO then
        --print("NPC_RESPONSE_GUILD_SHOP_BUY", data)
        mvc.send(mvc.events.GuildShop_Npc_Response_Guild_Shop_Buy, data)
    elseif no == NetMessageType.NPC_RESPONSE_GUILD_RANDOM_SHOP_BUY.NO then
        -- if(data.result ~= 1) then
        --     print("NPC_RESPONSE_GUILD_RANDOM_SHOP_BUY result is err")
        --     return
        -- end 

        --print("NPC_RESPONSE_GUILD_RANDOM_SHOP_BUY", data)
        mvc.send(mvc.events.GuildShop_Npc_Response_Guild_Random_Shop_Buy, data)
    elseif no == NetMessageType.NPC_NOTICE_EXPEDITION_SCREEN_INFO.NO then
        -- print("NPC_NOTICE_EXPEDITION_SCREEN_INFO", data)
        RoleDataManager:handleScreenExpeditionInfo(data)
    elseif no == NetMessageType.NPC_RESPONSE_EQUIP_LEVEL_REMOVE.NO then
        -- print("NPC_RESPONSE_EQUIP_LEVEL_REMOVE", data)
        -- RoleDataManager:handleScreenExpeditionInfo(data)
        if(data.err == "EquipErrorNo_OK") then
            GoodsDataManager:handleEquipRemoveLevel(data.instID)
        end 
        mvc.send(mvc.events.RecastRemoveLevel_Remove_Result, data)
    elseif no == NetMessageType.NPC_TRIGGER_GREEDY_SELECT_RES.NO then
        mvc.greedySelectModel:setGreedyInfo(data.goodsID, data.eventID)

        if UI.UIManager.mMainUILayer and (not tolua.isnull(UI.UIManager.mMainUILayer)) then
            mvc.openPanel("GreedySelect","GreedySelect")
        end
    elseif no == NetMessageType.NPC_COLLECT_START_RES.NO then 
        if data.ret ~= "ErrNo_Ok" then
            mvc.send(mvc.events.COLLECT_START, nil, true)
        end
    elseif no == NetMessageType.NPC_COLLECT_COLLECT_RESULT_RES.NO then 
            mvc.send(mvc.events.COLLECT_RESULT, data)
    elseif no == NetMessageType.NPC_RSP_MODIFY_EXPEDITION_LV.NO then 
        -- print("NPC_RSP_MODIFY_EXPEDITION_LV=", data)
        mvc.expeditionModel:updateExpeditionLV(data)
        -- UI.ScrollBar:createByText(UI.TEXT_1213409)
        UI.ScrollBar:createByTextID(1113845)
        mvc.send(mvc.events.Expedition_Data_Update)
    elseif no == NetMessageType.NPC_RESPONSE_GUILD_RANDOM_SHOP_REFRESH_TIME.NO then 
        mvc.guildShopModel:updateLastRefreshTime(data)
    elseif no == NetMessageType.NPC_RESPONSE_FAST_BUY.NO then 
        if DEBUG then
            print("NPC_RESPONSE_QUICK_BUY data = ", data)
        end

        if data.result ~= "FastBuyResult_OK" then
            print("NPC_RESPONSE_QUICK_BUY result is err")
            return
        end
        UI.ScrollBar:createByTextID(1110688)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_BUY_REBORNITEM_OK)
    elseif no == NetMessageType.NPC_RESPONSE_BUY_DREANM_VALUT.NO then
        local errStr = ""
        if data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_Succeed") then
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_DREAM_VALUT_SHOP_BUY, data) 
        else
            if data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_Unknow") then
                errStr = UI.TEXT_1110372
            elseif data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_NotEnoughBagSpace") then
                errStr = UI.TEXT_1212306
            elseif data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_NotEnoughItem") then
                errStr = UI.TEXT_1212307
            elseif data.result == ProtobufUtil:enum_id("NPCSystem.DreamshopBuyResult", "DreamshopBuyResult_LevelNotEnough") then
                errStr = UI.TEXT_1213957
            end
            UI.ScrollBar:createByText(errStr)
        end
        UI.WaitingLayer:hideWaiting() 
    elseif no == NetMessageType.NPC_RSP_QUICK_COMPOSE_GEM.NO then
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            if(data.composeCount > 0) then
                UI.ScrollBar:createByTextID(UI.TEXT_1325305)
            else
                UI.ScrollBar:createByTextID(1112512)
            end
        else
            UI.ScrollBar:createByErrorID(data.result)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GEM_QUICK_SYNTHESIS, data)

    -- 装备改造继承结果消息
    elseif (no == NetMessageType.NPC_REMODEL_INHERIT_RESULT.NO) then 
        if (DEBUG) then
            print("Net.NetNPCSystem NPC_REMODEL_INHERIT_RESULT ")
        end
        print("NPC_REMODEL_INHERIT_RESULT--->: ", data)
        if(data.flag == "InheritResultType_Succeed") then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipmentInstanceID)
            if(equipmentData) then
                -- 修改附魔属性
                -- equipmentData:setTmpRemodelAttr(data.attr, true)
                equipmentData:transformAttrByType(data.inheritAttrType)
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_INHERIT, data)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_REMODEL_INHERIT_RESULT  not found equipment  entityID=%d",ata.equipmentInstanceID))
            end
        else
            print("NPC_REMODEL_INHERIT_RESULT  error")
            -- GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RemodelResultType",data.flag))
            -- UI.WaitingLayer:hideWaiting()
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_FAIL)
        end
    elseif (no == NetMessageType.NPC_REMODEL_RESP_INHERIT_REPLACE_RESULT.NO) then 
        if (DEBUG) then
            print("++++++++++++Net.NetNPCSystem  ", data)
        end
        print("NPC_REMODEL_RESP_INHERIT_REPLACE_RESULT--->: ", data)
        if(data.errorNo == "InheritResultType_Succeed") then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipInstanceID)
            if(equipmentData) then
                -- 修改附魔属性
                --equipmentData:replaceTmpRemodelAttr(data.inheritAttrType)
                                
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_INHERIT_REPLACE, data)
                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_REMODEL_RESULT  not found equipment  entityID=%d",data.equipmentInstanceID))
            end
        else
            -- UI.WaitingLayer:hideWaiting()
            -- GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.NPC_REMODEL_INHERIT_RESULT", data.errorNo))
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_REMODEL_FAIL)
        end
    elseif (no == NetMessageType.NPC_GLYPHS_COMPOSE_RSP.NO) then 
        dump(data, "NPC_GLYPHS_COMPOSE_RSPaa")
        if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            -- GameErrorManager:showError(data.result)
            UI.ScrollBar:createByText(UI.TEXT_227059)
        else
            mvc.send("Glyphs_On_Casting_Succeed_Show_Get", data)
        end
    elseif (no == NetMessageType.NPC_RESP_GLYPH_REFINE_MESSAGE.NO) then
        -- 雕纹洗练结果消息 
        print("NPC_RESP_GLYPH_REFINE_MESSAGE--->: ", data)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local glyphData = GoodsDataManager:getGlyphByEntityID(data.glyphuid)
            if(glyphData) then
                -- 临时洗练出来的属性
                glyphData:saveRefinedLastAttrData(data.data)
                local dataResult = {}
                dataResult.isRefined = true
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
            else
                -- 装备上的雕文进行的洗练
                local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipuid)
                if(equipmentData) then
                    local glyphsData = (equipmentData:getGlyphDatas())[1]:getGlyphData()
                    glyphsData:saveRefinedLastAttrData(data.data)
                    local dataResult = {}
                    dataResult.glyphsDataByEquipment = glyphsData
                    dataResult.isRefined = true
                    Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
                end
            end
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
            UI.ScrollBar:createByText(UI.TEXT_227017)
            print("NPC_RESP_GLYPH_REFINE_MESSAGE  error")
        end
    elseif (no == NetMessageType.NPC_RESP_GLYPH_REFINE_CONFIRM_MESSAGE.NO) then 
        -- 请求洗练确认结果
        if (DEBUG) then
        end
        print("NPC_RESP_GLYPH_REFINE_CONFIRM_MESSAGE--->: ", data)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local glyphData = GoodsDataManager:getGlyphByEntityID(data.glyphuid)
            if(glyphData) then
                -- 设置临时洗练出来的属性
                glyphData:saveRefinedConfirmResult(data,data.isGet)
                local dataResult = {} 
                dataResult.isGet = data.isGet
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
            else
                -- 装备上的雕文进行的设置
                local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipuid)
                if(equipmentData) then
                    local glyphsData = (equipmentData:getGlyphDatas())[1]:getGlyphData()
                    glyphsData:saveRefinedConfirmResult(data,data.isGet)
                    local dataResult = {}
                    dataResult.isGet = data.isGet
                    dataResult.glyphsDataByEquipment = glyphsData
                    Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
                end
            end
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
            UI.ScrollBar:createByText(UI.TEXT_227017)
            print("NPC_RESP_GLYPH_REFINE_CONFIRM_MESSAGE  error")
        end
    elseif (no == NetMessageType.NPC_RESP_GLYPH_QUICK_REFINE_MESSAGE.NO) then

        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local glyphData = GoodsDataManager:getGlyphByEntityID(data.glyphuid)
            if(glyphData) then
                -- 设置临时洗练出来的属性
                glyphData:saveRefinedConfirmResult(data,true)
                local dataResult = {} 
                dataResult.isQuick = true
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
            else
                -- 装备上的雕文进行的设置
                local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipuid)
                if(equipmentData) then
                    local glyphsData = (equipmentData:getGlyphDatas())[1]:getGlyphData()
                    glyphsData:saveRefinedConfirmResult(data,true)
                    local dataResult = {}
                    dataResult.isQuick = true
                    dataResult.glyphsDataByEquipment = glyphsData
                    Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_REFINED_REFRESH, dataResult)
                end
            end
        end

    elseif (no == NetMessageType.NPC_RESP_GLYPH_EQUIP_MESSAGE.NO) then
        -- 雕纹镶嵌结果消息 
        print("NPC_RESP_GLYPH_EQUIP_MESSAGE--->: ", data)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipuid)
            if(equipmentData) then
                -- 装备上镶嵌雕纹
                local glyphs = {}
                glyphs.glyphTemplateId = data.glyphTemplateid
                glyphs.glyphattrData = data.data.attrData
                glyphs.glyphlastRefineAttrData = data.data.lastRefineAttrData
                equipmentData:resetGlyphData(glyphs)
                local data = {}
                data.isEquip = true
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_EQUIP_REFRESH, data)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_RESP_GLYPH_EQUIP_MESSAGE  not found equipument  entityID=%d",data.equipuid))
            end
        else
            print("NPC_RESP_GLYPH_EQUIP_MESSAGE  error")
        end
    elseif (no == NetMessageType.NPC_RESP_GLYPH_UNEQUIP_MESSAGE.NO) then
        -- 卸载雕纹结果消息 
        print("NPC_RESP_GLYPH_UNEQUIP_MESSAGE--->: ", data)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipuid)
            if(equipmentData) then
                -- 装备上镶嵌雕纹
                local glyphs = {}
                glyphs.glyphattrData = {}
                equipmentData:resetGlyphData(glyphs)
                Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_GLYPH_EQUIP_REFRESH)
            else
                assert(false,string.format("Net.NetNPCSystem NPC_RESP_GLYPH_UNEQUIP_MESSAGE  not found equipument  entityID=%d",data.equipuid))
            end
        else
            print("NPC_RESP_GLYPH_UNEQUIP_MESSAGE  error")
        end

    elseif (no == NetMessageType.NPC_RESP_GLYPH_DECOMPOSE_MESSAGE.NO) then
        -- 卸载雕纹结果消息 
        print("NPC_RESP_GLYPH_DECOMPOSE_MESSAGE--->: ", data)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            UI.WaitingLayer:hideWaiting()
        else
            print("NPC_RESP_GLYPH_DECOMPOSE_MESSAGE  error")
        end
    elseif (no == NetMessageType.NPC_GLYPHS_INHERIT_RSP.NO) then
        -- 雕纹继承结果 
        -- dump(data.mainData, "NPC_GLYPHS_INHERIT_RSPs", 5)
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            UI.WaitingLayer:hideWaiting()
            mvc.send("Glyphs_On_Inherit_Succeed", data)
        else
            print("NPC_GLYPHS_INHERIT_RSP  error")
        end
    elseif (no == NetMessageType.NPC_RESP_PRIMOGEM_DECOMPOSE_MESSAGE.NO) then
        dump(data, "NPC_RESP_PRIMOGEM_DECOMPOSE_MESSAGEaa", 5)
        -- 原石分解
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            UI.WaitingLayer:hideWaiting()
            if data.goodsID then
                mvc.send("Primogem_On_Decompose_Succeed", data.goodsID)
            end
        else
            print("NPC_RESP_PRIMOGEM_DECOMPOSEME_SSAGE  error")
        end
    else
        assert(false, string.format("[Net.NetNPCSystem] onNPCMessageHandler no %d is invaild.", no))
    end
end

