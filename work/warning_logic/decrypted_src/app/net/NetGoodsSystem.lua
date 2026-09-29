--[[
    物品相关的网络消息处理
]]--

require "utils.MathUtil"
Net = Net or {}
local NetGoodsSystem = {}
Net.NetGoodsSystem = NetGoodsSystem
local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

local Manager = Game.Manager
local DEBUG = false


local GOODS_TYPE = PublicDefine.GOODS_TYPE
local PACKET_TYPE = PublicDefine.PACKET_TYPE
local CONST_DEFINITION = PublicDefine.CONST_DEFINITION
local DELETE_GOODS_REASON_TYPE = PublicDefine.DELETE_GOODS_REASON_TYPE
local DROP_REASON_TYPE = PublicDefine.DROP_REASON_TYPE

local drapGoodsTable = {}
function NetGoodsSystem:reqUseChooseBag(itemID,chooseList)
     print("---reqUseChooseBag---", itemID)
    local messageData = {}
    messageData.itemID = itemID 
    messageData.chooseList = chooseList 
    Net.Helper:sendMessage(NetMessageType.GOODS_REQ_CHOOSE, messageData)
end
function NetGoodsSystem:beginUseItemRequest(templateID,isGolden,targetSpriteID,coordX,coordY)
    if DEBUG then
        print ("[Net.NetGoodsSystem] beginUseItemRequest templateID,isGolden,targetSpriteID,coordX,coordY=",templateID,isGolden,targetSpriteID,coordX,coordY)
    end
    local messageData = {}
    messageData.templateID = templateID 
    
    if isGolden then
        messageData.isGolden = isGolden 
    else
        messageData.isGolden = false
    end
    
    messageData.targetSpriteID = targetSpriteID 
    
    if coordX then
        messageData.coordX = coordX 
    end

    if coordY then
        messageData.coordY = coordY 
    end
    
    Net.Helper:sendMessage(NetMessageType.GOODS_BEGIN_USE_ITEM, messageData)
end

-- 请求使用道具
function NetGoodsSystem:useItemRequest(templateID,isGolden,targetSpriteID,coordX,coordY,useNum)
    if DEBUG then
        print ("[Net.NetGoodsSystem] useItemRequest templateID,isGolden,targetSpriteID,coordX,coordY=",templateID,isGolden,targetSpriteID,coordX,coordY)
    end
    local useNum = useNum or 1
    local messageData = {}
    messageData.templateID = templateID 
    
    if isGolden then
        messageData.isGolden = isGolden 
    else
        messageData.isGolden = false
    end
    
    messageData.targetSpriteID = targetSpriteID 
    
    if coordX then
        messageData.coordX = coordX 
    end

    if coordY then
        messageData.coordY = coordY 
    end

    messageData.useNum = useNum 
    
    Net.Helper:sendMessage(NetMessageType.GOODS_USE_ITEM, messageData)
end

-- 穿戴装备
function NetGoodsSystem:equipEquipmentRequest(entityID,index)
    if DEBUG then
        print ("[Net.NetGoodsSystem] equipEquipmentRequest entityID,index=",entityID,index)
    end

    local messageData = {}
    messageData.entityID = entityID
    messageData.index = index

    MasterDataManager:insertRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_BAG, entityID, 1)
    
    Net.Helper:sendMessage(NetMessageType.GOODS_BAG_EQUIP, messageData)
end

-- 卸载装备
function NetGoodsSystem:unEquipmentRequest(entityID)
    if DEBUG then
        print ("[Net.NetGoodsSystem] unEquipmentRequest entityID=",entityID)
    end

    local messageData = {}
    messageData.entityID = entityID

    -- 添加对于拖动物品的处理
    MasterDataManager:insertRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT, entityID, 1)
    
    Net.Helper:sendMessage(NetMessageType.GOODS_BAG_UN_EQUIP, messageData)
end

-- 拖动物品到包裹的请求
function NetGoodsSystem:dragGoodsToPacketRequest(fromPacketType,toPacketType,goodsData,num)
    if DEBUG then
        print ("[Game Manager] dragGoodsToPacketRequest ")
    end

    -- 防止快速点击造成误触
    UI.WaitingLayer:showWaiting(true, nil, 0.2, 0.2)

    local messageData = {}
    -- 组装请求数据
    messageData.toPacketType = toPacketType

    local key = goodsData:getGoodsID()..":"..tostring(goodsData:getIsGolden())
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
        or (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
        messageData.templateID = goodsData:getGoodsID()
        messageData.isGolden = goodsData:getIsGolden()
        messageData.entityID = goodsData:getEntityID()
        key = goodsData:getEntityID()
        if fromPacketType == PACKET_TYPE.PACKET_BAG then
            fromPacketType = GameDataManager:getInstance():getGoodsPacketType(goodsData)
        end
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        messageData.templateID = goodsData:getGoodsID()
        messageData.isGolden = goodsData:getIsGolden()
    end
    messageData.fromPacketType = fromPacketType
    messageData.num = num

    local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..fromPacketType
    local totalNum = num
    local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
    if(repeatData == nil) then
        repeatData = {}
    end
    if(repeatData[key]) then
        totalNum = repeatData[key] + totalNum
    end
    -- 添加对于拖动物品的处理
    MasterDataManager:insertRepeatHandleData(keyStr, key, totalNum)
    
    table.insert(drapGoodsTable, messageData)

    if(DEBUG) then
        dump(messageData)
    end 

    Net.Helper:sendMessage(NetMessageType.GOODS_DRAG_GOODS_TO_PACKET, messageData)
end

-- 新的拖动物品到包裹的请求
function NetGoodsSystem:newDragGoodsToPacketRequest(fromPacketType,toPacketType, goodsArr)
    -- if DEBUG then
        print ("NetGoodsSystem:newDragGoodsToPacketRequest", fromPacketType, toPacketType)
    -- end

    local messageData = {}
    -- 组装请求数据
    messageData.toPacketType = toPacketType
    messageData.fromPacketType = fromPacketType

    messageData.goodsIDs = {}
    if(goodsArr) then 
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
                or v:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                or v:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
                oneData.entityID = v:getEntityID()
                oneData.num = 1
            else
                oneData.templateID = v:getGoodsID()

                oneData.num = v:getNum()
            end
            oneData.isGolden = v:getIsGolden()
            
            table.insert(messageData.goodsIDs, oneData)

            local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..fromPacketType
            local totalNum = oneData.num
            local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
            if(repeatData == nil) then
                repeatData = {}
            end
            if(repeatData[key]) then
                totalNum = repeatData[key] + oneData.num
            end
            -- 添加对于拖动物品的处理
            MasterDataManager:insertRepeatHandleData(keyStr, key, totalNum)
        end
    end

    table.insert(drapGoodsTable, messageData)

    if(DEBUG) then
        dump(messageData)
    end 
    print ("NetGoodsSystem:newDragGoodsToPacketRequest messageData=", messageData)
    Net.Helper:sendMessage(NetMessageType.GOODS_REQ_NEW_DRAG_GOODS_TO_PACKET, messageData)
end

-- 删除物品的请求
function NetGoodsSystem:deletGoodsRequest(packetType,deleteGoodsArr)
    if DEBUG then
        print("[Net.NetGoodsSystem] deletGoodsRequest  packetType",packetType)
        for k,v in pairs(deleteGoodsArr) do
            if v:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                print ("[Net.NetGoodsSystem] deletGoodsRequest goodsID,num,entityID=",v:getGoodsID(),v:getNum(),v:getEntityID())
            else
                print ("[Net.NetGoodsSystem] deletGoodsRequest goodsID,num=",v:getGoodsID(),v:getNum())
            end
            
        end
    end

    local messageData = {}
    messageData.packetType = packetType

    local deleteData = {}
    for k,goodsData in ipairs(deleteGoodsArr) do
        local deleteGoodsData = {}
        if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
            deleteGoodsData.templateID = goodsData:getGoodsID()
            deleteGoodsData.entityID = goodsData:getEntityID()
            deleteGoodsData.num = 1
        elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
            goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
            goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
            goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            deleteGoodsData.templateID = goodsData:getGoodsID()
            deleteGoodsData.isGolden = goodsData:getIsGolden()
            deleteGoodsData.num = goodsData:getNum() + goodsData._changeNum - goodsData:getUseNum()
        end
        table.insert(deleteData,deleteGoodsData)
    end

    messageData.deleteData = deleteData
    
    Net.Helper:sendMessage(NetMessageType.GOODS_DELETE_GOODS_REQUEST, messageData)
end

-- 快捷栏改变请求  {{index:1,templateID:2}}
function NetGoodsSystem:shortcutsChangeRequest(shortcutsData)
    if DEBUG then
        for k,v in pairs(shortcutsData) do
            print ("[Net.NetGoodsSystem] shortcutsChangeRequest index,templateID=",v.index,v.templateID)
        end
    end

    local messageData = {}
    messageData.shortcutsData = shortcutsData
    
    Net.Helper:sendMessage(NetMessageType.GOODS_SHORTCUTS_CHANGE, messageData)
end

-- 请求锁定物品
function NetGoodsSystem:requestLockGoods(packetType, goodsData, isLock, petID)
    if DEBUG then
        print ("[Net.NetGoodsSystem] requestLockGoods packetType, goodsData, isLock=",packetType, goodsData, isLock)
    end
    local messageData = {}
    messageData.packetType = packetType

    if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC
    then
        messageData.templateID = goodsData:getGoodsID()
        messageData.entityID = goodsData:getEntityID()
        messageData.petId = petID
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
        messageData.templateID = goodsData:getGoodsID()
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        messageData.templateID = goodsData:getGoodsID()
        messageData.entityID = goodsData:getEntityID()
    end
    
    messageData.isLock = isLock

    Net.Helper:sendMessage(NetMessageType.GOODS_REQUEST_LOCK_GOODS, messageData)
end

-- 请求解锁背包格子
function NetGoodsSystem:requestUnlockBagSpace(packetType, itemID)
    if DEBUG then
        print ("[Net.NetGoodsSystem] requestUnlockBagSpace packetType=", packetType)
    end
    local messageData = {}
    messageData.packetType = packetType
    if(itemID) then
        messageData.itemID = itemID
    end

    Net.Helper:sendMessage(NetMessageType.GOODS_REQUEST_UNLOCK_BAG_SPACE, messageData)
end

-- 切换一键换装请求
function NetGoodsSystem:requestSelectShortcutEquip(index)
    if DEBUG then
        print ("[Net.NetGoodsSystem] requestSelectShortcutEquip index=", index)
    end
    local messageData = {}
    messageData.index = index

    Net.Helper:sendMessage(NetMessageType.GOODS_REQ_SELECT_SHORTCUT_EQUIP, messageData)
end

--删除背包满的list
function NetGoodsSystem:deleteGoodsFromFullBag(serialID)
    local messageData = {}
    messageData.serialID = serialID

    Net.Helper:sendMessage(NetMessageType.GOODS_DELETE_GOODS_FROM_FULL_BAG, messageData)
    
end

-- 请求幻化数据
function NetGoodsSystem:requestEquipIllusionInfo(spriteID)
    local messageData = {
        npcID = spriteID
    }
    Net.Helper:sendMessage(NetMessageType.GOODS_REQ_EQUIP_ILLUSION_INFO, messageData)
end


-- 请求装备幻化
function NetGoodsSystem:requestEquipIllusionWear(spriteID, equipInstanceID, illusionID)
    local messageData = {}
    messageData.equipInstanceID = equipInstanceID
    messageData.illusionID = illusionID
    messageData.npcID = spriteID

    Net.Helper:sendMessage(NetMessageType.GOODS_REQ_EQUIP_ILLUSION_WEAR, messageData)
end

-- 请求返回给服务器问卷调查结果
function NetGoodsSystem:requestFinishQuestion(itemID, isFinish)
    print("--------requestFinishQuestion-------", itemID, isFinish)
    local messageData = {}
    messageData.itemID = itemID
    messageData.isFinish = isFinish

    Net.Helper:sendMessage(NetMessageType.REQUEST_FINISH_QUESTION_NAIRE, messageData)
end


-- 请求返回给服务器问卷调查结果
function NetGoodsSystem:requestStarPrayLuckyDrop(npcid, costType)
    if(GameManager:getIsInNPCSpriteID2Zero()) then 
        npcid = 0
    end
    local messageData = {}
    messageData.npcid = npcid
    messageData.type = costType

    Net.Helper:sendMessage(NetMessageType.REQUEST_STAR_PRAY_LUCKY_DRAW, messageData)
end

-- 请求选择礼包
function NetGoodsSystem:requestChooseGoodsGet()
    -- print("NetGoodsSystem:requestChooseGoodsGet")
    Net.Helper:sendMessage(NetMessageType.GOODS_CHOOSE_GOODS_GET, nil)
end

-- 请求遗物分解
function NetGoodsSystem:requestRelicDecompose()
    local messageData = {}
    
    Net.Helper:sendMessage(NetMessageType.REQUEST_RELIC_DECOMPOSE, messageData)
end

-- 请求遗物强化
function NetGoodsSystem:requestRelicStrength(instID, extraIds, extraNums)
    local messageData = {}
    messageData.instID = instID
    if extraNums and extraNums[1] > 0 then
        messageData.extraIds = extraIds
        messageData.extraNums = extraNums
    end
    Net.Helper:sendMessage(NetMessageType.REQUEST_RELIC_STRENGTHEN, messageData)
end

-- 请求遗物穿戴
function NetGoodsSystem:requestRelicWear(instID, isWear)
    local messageData = {}
    messageData.instID = instID
    messageData.isOn = isWear
    Net.Helper:sendMessage(NetMessageType.REQUEST_RELIC_WEAR, messageData)
end

-- 请求套装属性重置
function NetGoodsSystem:requesResetRetrofit(setId, count)
    local messageData = {}
    messageData.equipSetId = setId
    messageData.equipCount = count
    Net.Helper:sendMessage(NetMessageType.GOODS_STARPRAY_REQ_RESET_RETROFIT_MESSAGE, messageData)
end

-- 请求套装属性改造
function NetGoodsSystem:requesEquipSetRetrofit(setId, count, isAdvanced)
    local messageData = {}
    messageData.equipSetId = setId
    messageData.equipCount = count
    messageData.isAdvanced = isAdvanced
    Net.Helper:sendMessage(NetMessageType.GOODS_STARPRAY_REQ_RETROFIT_EQUIP_SET_MESSAGE, messageData)
end

-- 请求选择改造的套装属性
function NetGoodsSystem:requesEquipSetConfirmRetrofit(setId, count, skillId)
    local messageData = {}
    messageData.equipSetId = setId
    messageData.equipCount = count
    messageData.skillId = skillId
    Net.Helper:sendMessage(NetMessageType.GOODS_STARPRAY_REQ_SELECT_RETROFIT_MESSAGE, messageData)
end

--宝物鉴定
function NetGoodsSystem:requesIdentifyTreasureItemMessage(treasureId)
    local messageData = {}
    messageData.treasureId = treasureId
    Net.Helper:sendMessage(NetMessageType.REQUEST_IDENTIFY_TREASURE_ITEM_MESSAGE, messageData)
end

--紫装升红
function NetGoodsSystem:requesPurUpgradeMessage(data)
    local messageData = {}
    messageData.entityID = data.entityID
    messageData.packetType = data.packetType
    messageData.consumeid = data.consumeid
    Net.Helper:sendMessage(NetMessageType.REQUEST_CHANGE_PURPLE_MESSAGE, messageData)
end

--紫装升红后重置
function NetGoodsSystem:requesResetPurpleMessage(data)
    local messageData = {}
    messageData.entityID = data.entityID
    messageData.packetType = data.packetType
    Net.Helper:sendMessage(NetMessageType.REQUEST_RESET_PURPLE_MESSAGE, messageData)
end

--请求符文石连接
function NetGoodsSystem:requesGemConnectMessage(data)
    local messageData = {}
    messageData.equipUid = data.equipUid
    messageData.holeIndex = data.holeIndex
    messageData.viceGemid = data.viceGemid

    Net.Helper:sendMessage(NetMessageType.REQUEST_GEM_CONNECT, messageData)
end

--请求断开连接
function NetGoodsSystem:requesGemDisConnectMessage(data)
    local messageData = {}
    messageData.equipUid = data.equipUid
    messageData.holeIndex = data.holeIndex

    Net.Helper:sendMessage(NetMessageType.REQUEST_GEM_DIS_CONNECT, messageData)
end

--请求符文分解
function NetGoodsSystem:requesGemDecomposeMessage(data)
    local messageData = {}
    messageData.gemid = data.gemid

    print("   requesGemDecomposeMessage data ===  ",messageData)

    Net.Helper:sendMessage(NetMessageType.REQUEST_GEM_DECOMPOSE, messageData)
end



-- 角色消息处理
function NetGoodsSystem:onGoodsMessageHandler(no, data)
    -- print(string.format("[Net.NetGoodsSystem] onGoodsMessageHandler no:%d.", no))

    -- if (DEBUG) then
        -- if data and type(data) == "table" then
        --     for k,v in pairs(data) do 
        --         if type(v) == "table" then
        --             print("[Net.NetGoodsSystem] onGoodsMessageHandler  k="..k.."  v=")
        --         end
        --     end
        -- end
    -- end

    -- 初始化包裹数据
    if (no == NetMessageType.GOODS_PACKET_GOODS_DATA.NO) then
        if DEBUG then
            print("[Net.NetGoodsSystem]  GOODS_PACKET_GOODS_DATA ",data.packetType)
            for k,v in pairs(data.goods) do
                print("GOODS_PACKET_GOODS_DATA index,goodsType=",v.index,v.templateID)
            end

            -- dump(data)
        end

        local pk = RoleDataManager:getMasterPK()  
        local packetType = data.packetType
        local packetSubType = data.packetSubType
        -- local 
        self:_handlePackGoods(data.goods, packetType, packetSubType, pk, 1)

        -- 更新红点提示信息数据(这里和出洞重置互动会有BUG, 并且不需要在这里刷新数据, 暂时弃用)
        -- require "app.utils.BagNotificationUtil"
        -- BagNotificationUtil:updateUpgradableItems()
    elseif (no == NetMessageType.GOODS_ACHIEVE_GOODS.NO) then
        if DEBUG then
            print("[Net.NetGoodsSystem]  GOODS_ACHIEVE_GOODS  packetType,sourceSpriteID,coordX,coordY=",data.packetType,data.sourceSpriteID,data.coordX,data.coordY)
            local v = data.goods
            print("GOODS_ACHIEVE_GOODS num,templateID,isGolden,isInCaveNewGet=",v.num,v.templateID,v.isGolden,v.isInCaveNewGet)
        end

        local pk = RoleDataManager:getMasterPK()  
        local packetType = data.packetType
        local packetSubType = nil 
        if(ProtobufUtil:checkFieldIsInit(data, "packetSubType")) then 
            packetSubType = data.packetSubType
        end
        local goodsData = self:_handlePackGood(pk,packetType, packetSubType,2,data.goods)
        if(goodsData) then
            GoodsDataManager:refreshIsNew(goodsData)
            MasterDataManager:addGoodsDataTrigger(goodsData)

            -- 处理宠物装备的逻辑
            if(packetType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT
                and data.petInstId ~= 0) then
                local rolePetData = MasterDataManager:getBagPetById(data.petInstId)
                if(rolePetData) then 
                    rolePetData:addWearEquipmentData(goodsData)
                end
            end
        end

        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()

        -- 判断是否为新增加的道具
        if goodsData then
            if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM then
                local totalNum = GoodsDataManager:getGoodsDataNum(pk,packetType,goodsData:getGoodsID(),true)
                if not goodsData:isUseInMaze() and goodsData:getNum() == totalNum then
                    -- 加入快捷栏
                    GoodsDataManager:insertShortcutBar(goodsData:getGoodsID())
                end
                if(goodsData:isUseInMaze()) then
                    GoodsDataManager:insertShortcutBarMaze(goodsData:getGoodsID())
                end
            end
        end
        if goodsData and data.sourceSpriteID and ( data.sourceSpriteID ~= 0 or ( data.coordX ~= CONST_DEFINITION.MAP_INVALID_COORD and data.coordY ~=CONST_DEFINITION.MAP_INVALID_COORD))then
            -- 发送获取表现指令
            local mesData = {}
            mesData.goodsData = goodsData
            mesData.sourceSpriteID = data.sourceSpriteID
            mesData.coordX = data.coordX
            mesData.coordY = data.coordY
            if (data.reason == DROP_REASON_TYPE.DROP_REASON_GREEDY) then
                mvc.greedySelectModel:setRewardGoodsData(goodsData)
            elseif (data.reason == DROP_REASON_TYPE.DROP_REASION_EXPEDITION 
                or data.reason == DROP_REASON_TYPE.DROP_REASION_EXPEDITION_QUICK
                or data.reason == DROP_REASON_TYPE.DROP_REASON_LOSTREALM) then
                -- 探险队获得物品不用弹掉落提示
            else
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_ACHIEVE_GOODS, mesData)
                SceneManager:getInstance():pushCommand(command)
            end
        end

        -- 处理系统消息打点
        if(goodsData and (data.reason == DROP_REASON_TYPE.DROP_REASON_MONSTER 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_DIG 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_BOX 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_BLACK_MARKET 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_RANDOMSHOP 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_LUCKYWHEEL 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_CAVE_MARKET
            or data.reason == DROP_REASON_TYPE.DROP_REASON_DREAMSHOP
            or data.reason == DROP_REASON_TYPE.DROP_REASON_LUCKYLOTTERY
            or data.reason == DROP_REASON_TYPE.DROP_REASION_MAZE
            or data.reason == DROP_REASON_TYPE.DROP_REASON_FESTIVAL_SIGN)) then
            local str = UI.TEXT_1170325
            if data.goods.num > 1 then
                str = str.." x"..data.goods.num
            end
            local linkStr = Game.ChatManager:getInstance():getItemLinkStr(goodsData)
            if linkStr then
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, str, you, linkStr)

                if(data.reason == DROP_REASON_TYPE.DROP_REASION_MAZE) then 
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1213010, goodsData:getName()))
                end
            end
        elseif (goodsData and (data.reason == DROP_REASON_TYPE.DROP_REASON_ACTIVITY_EXTRADROP)) then
            local textStr = LanguageManager:getInstance():getLocalString(1111069)
            textStr = PlaceholderUtil:formatName(textStr, goodsData:getGoodsID())
            textStr = string.format(textStr, goodsData:getNum())
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr)
        elseif  (goodsData and (data.reason == DROP_REASON_TYPE.DROP_REASON_GREEDY)) then
            local textStr = LanguageManager:getInstance():getLocalString(1112884)
            textStr = textStr .. " x" .. goodsData:getNum()
            local linkStr = Game.ChatManager:getInstance():getItemLinkStr(goodsData)
            if linkStr then
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr, you, linkStr)
            end
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_BAG_CHANGE)
        -- 更新红点提示信息数据
        require "app.utils.BagNotificationUtil"
        BagNotificationUtil:updateUpgradableItems()
    -- 处理了获取虚拟商品
    elseif (no == NetMessageType.GOODS_ACHIEVE_VIRTUAL_GOODS.NO) then
        if DEBUG then
            print("[Net.NetGoodsSystem]  GOODS_ACHIEVE_VIRTUAL_GOODS")
        end
        -- 处理了获取虚拟商品

        local goodsData = GoodsDataManager:handleChangeVirtualGoodsData(data.templateID, data.num)

        if goodsData and data.sourceSpriteID and ( data.sourceSpriteID ~= 0 or ( data.coordX ~= CONST_DEFINITION.MAP_INVALID_COORD and data.coordY ~=CONST_DEFINITION.MAP_INVALID_COORD))then
            local showGoodsData = clone(goodsData)
            showGoodsData:setNum(data.num)
            -- 发送获取表现指令
            local mesData = {}
            mesData.goodsData = showGoodsData
            mesData.sourceSpriteID = data.sourceSpriteID
            mesData.coordX = data.coordX
            mesData.coordY = data.coordY

            if (data.reason == DROP_REASON_TYPE.DROP_REASION_EXPEDITION 
                or data.reason == DROP_REASON_TYPE.DROP_REASION_EXPEDITION_QUICK
                or data.reason == DROP_REASON_TYPE.DROP_REASON_LOSTREALM ) then
                -- 探险队获得物品不用弹掉落提示
            else
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_ACHIEVE_GOODS, mesData)
                SceneManager:getInstance():pushCommand(command)
            end
            -- Game.ChatManager:getInstance():sendMsgLink(mesData)
        end
        MasterDataManager:addGoodsDataTrigger(goodsData)

        -- 处理系统消息打点
        if(goodsData and (data.reason == DROP_REASON_TYPE.DROP_REASON_MONSTER 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_DIG 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_BOX 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_BLACK_MARKET
            or data.reason == DROP_REASON_TYPE.DROP_REASON_RANDOMSHOP
            or data.reason == DROP_REASON_TYPE.DROP_REASON_LUCKYWHEEL 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_CAVE_MARKET
            or data.reason == DROP_REASON_TYPE.DROP_REASON_LUCKYLOTTERY)) then
            local linkStr = Game.ChatManager:getInstance():getItemLinkStr(goodsData)
            if linkStr then
                local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1170325, you, linkStr)
            end
        elseif (goodsData and data.reason == DROP_REASON_TYPE.DROP_REASON_ACTIVITY_EXTRADROP) then
            local textStr = LanguageManager:getInstance():getLocalString(1111069)
            textStr = PlaceholderUtil:formatName(textStr, goodsData:getGoodsID())
            textStr = string.format(textStr, goodsData:getNum())
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr)
        end
    elseif (no == NetMessageType.GOODS_DELETE_GOODS.NO) then
        if DEBUG then
            print("[Net.NetGoodsSystem]  GOODS_DELETE_GOODS  packetType=",data.packetType, data.reason)
        end
        -- 处理删除物品
        local pk = RoleDataManager:getMasterPK()  
        
        local packetType = data.packetType

        local deleteReason = data.reason 
        local use = false
        if(deleteReason ~= 0) then
            if(deleteReason == DELETE_GOODS_REASON_TYPE.DELETE_GOODS_REASON_USE) then
                use = true
            end
        end
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA)

        if(data.reason == DELETE_GOODS_REASON_TYPE.DELETE_GOODS_REASON_DESTROY) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, data)
        elseif (data.reason == DELETE_GOODS_REASON_TYPE.DELETE_GOODS_REASON_SELL) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT)
            UI.WaitingLayer:hideWaiting()
        end

        for k,deleteData in ipairs(data.deleteData) do
            if DEBUG then
                print("[Net.NetGoodsSystem]  GOODS_DELETE_GOODS  templateID,num=",deleteData.templateID,deleteData.entityID,deleteData.isGolden,deleteData.num)
            end

            local goodsID = deleteData.templateID
            local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

            local isChange = false
            if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT 
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
                GoodsDataManager:deleteEquipment(pk,packetType,goodsType,deleteData.entityID)
                isChange = true
            else
                -- 判断删除原因
                if(use) then 
                    local goodsArr = GoodsDataManager:getGoodsArrForPK(pk, packetType, goodsType, nil)
                    if(goodsArr) then
                        for k,v in pairs(goodsArr) do 
                            if(v:getGoodsID() == goodsID and v:getIsGolden() == deleteData.isGolden) then
                                local linkStr = Game.ChatManager:getInstance():getItemLinkStr(v)
                                if linkStr then
                                    local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
                                    Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1170601, you, linkStr)
                                    break
                                end
                            end
                        end
                    end

                    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM and goodsID) then 
                        local oneItem = GoodsDataManager:createLocalGoodsData(goodsID)
                        if(oneItem) then 
                            if(oneItem:getItemType() == PublicDefine.ITEM_TYPE.ItemFunExplore) then 
                                -- 处理扫描效果
                                local command = Command.ControlCommand:create(true)
                                command:initForTypeAndData(CommandType.CONTROL_MAZE_FUN_EXPLORE, oneItem)
                                SceneManager:getInstance():pushCommand(command)
                            end
                        end
                    end
                end
                isChange = GoodsDataManager:deleteMaterialOrItem(pk,packetType,goodsType,goodsID,deleteData.isGolden,deleteData.num)
                self:_addGoodsUpdate(packetType,goodsType,goodsID)
            end

            if isChange then
                self:_addGoodsChange(packetType,goodsType,isChange)
            end
        end

        -- 处理宠物装备移除
        if(data.packetType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT 
            and data.petInstId ~= 0) then
            local rolePetData = MasterDataManager:getBagPetById(data.petInstId)
            if(rolePetData) then 
                for k,deleteData in ipairs(data.deleteData) do
                    rolePetData:removeWearEquipmentDataFromInstID(deleteData.entityID)
                end
            end
        end

        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()
    -- 拖动物品到包裹
    elseif (no == NetMessageType.GOODS_DRAG_GOODS_TO_PACKET.NO) then
        if(DEBUG) then
            print("NetMessageType.GOODS_DRAG_GOODS_TO_PACKET")
            dump(data)
        end
        local pk = RoleDataManager:getMasterPK()  

        if DEBUG then
            for k,v in pairs(data) do
                print("GOODS_DRAG_GOODS_TO_PACKET  k,v=",k,v)
            end
        end

        local goodsID = data.templateID
        local goodsType
        -- if data.entityID == nil or data.entityID == 0 then
            -- print("NetMessageType.GOODS_DRAG_GOODS_TO_PACKET2222")
            goodsID = data.templateID
        -- else
        --     -- print("NetMessageType.GOODS_DRAG_GOODS_TO_PACKET1111")
        --     goodsID = data.entityID
        -- end
        goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

        local packetType = data.fromPacketType
        if DEBUG then
            print("GOODS_DRAG_GOODS_TO_PACKET  packetType,goodsType,goodsID=",packetType,goodsType,goodsID)
        end
        
        -- 先移除数据
        local oldIsLock = false
        local goodsData = nil

        local num = 1
        local key = ""
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC
        then
            if(packetType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT 
                and goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                goodsData = MasterDataManager:getEquipmentPetDataorWearEquipmentID(data.entityID)
            else
                goodsData = GoodsDataManager:deleteEquipment(pk,packetType,goodsType,data.entityID)
            end
            self:_addGoodsChange(packetType,goodsType,true)
            if(goodsData) then 
                oldIsLock = goodsData:getIsLock()
            end
            key = data.entityID
        else
            key = goodsID..":"..tostring(data.isGolden)
            num = data.num
            oldIsLock = GoodsDataManager:getItemOrMaterialLockStatus(pk, goodsID, goodsType)
            local isChange = GoodsDataManager:deleteMaterialOrItem(pk,packetType,goodsType,goodsID,data.isGolden,data.num)
            if isChange then
                self:_addGoodsChange(packetType,goodsType,true)
            end
            self:_addGoodsUpdate(packetType,goodsType,goodsID)
        end

        local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..data.fromPacketType
        local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
        if(repeatData == nil) then
            repeatData = {}
        end
        if(repeatData[key]) then
            repeatData[key] = repeatData[key] - num
            MasterDataManager:insertRepeatHandleData(keyStr, key, repeatData[key])
        end

        -- 移除本地缓存数据
        if(drapGoodsTable[1]) then
            local messageData = drapGoodsTable[1]
            if(messageData.fromPacketType == data.fromPacketType and messageData.toPacketType == data.toPacketType) then
                table.remove(drapGoodsTable, 1)
            end
        end

        -- 后加入数据
        local packetType = data.toPacketType
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            or  goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
            or  goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then

            if DEBUG then
                print("GOODS_DRAG_GOODS_TO_PACKET  add data =",packetType,goodsType,goodsData)
            end
            if goodsData then
                if packetType ~= PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT then
                    GoodsDataManager:addEquipmentDataForPK(pk,packetType,goodsData)
                end
                self:_addGoodsChange(packetType,goodsType,true)
            end
        else
            local goodsData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(pk,packetType,goodsType,goodsID,data.isGolden)

            -- 获取物品相关的
            local goodsStatusData = {}
            goodsStatusData.isGolden = data.isGolden
            goodsStatusData.isLock = oldIsLock

            -- 处理是否为新的标签
            if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_TEMPORARY and data.toPacketType == PublicDefine.PACKET_TYPE.PACKET_BAG) then
                -- 添加判断是否为洞穴里面
                if(SceneManager:getInstance():isInFightScene()) then
                    goodsStatusData.isInCaveNewGet = true
                end 
            end 

            local goodsData,update,change = GoodsDataManager:handleAddGoodsData(pk,packetType, nil, goodsType,goodsID,data.num,nil,goodsStatusData)
            if change then
                self:_addGoodsChange(packetType,goodsType,true)
            end
            self:_addGoodsUpdate(packetType,goodsType,goodsID)
        end

        -- 处理宠物装备穿戴/脱掉的消息
        if(data.petInstId ~= 0) then
            --print("DragGoodsToPacketMessage 1")
            local rolePetData = MasterDataManager:getBagPetById(data.petInstId)
            if(rolePetData) then 
                --print("DragGoodsToPacketMessage 2")
                if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT) then
                    --print("DragGoodsToPacketMessage 3")
                    rolePetData:removeWearEquipmentDataFromInstID(data.entityID)
                end
                if(data.toPacketType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT) then
                    --print("DragGoodsToPacketMessage 4")
                    rolePetData:addWearEquipmentData(goodsData)
                end
            end
        end

        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()
        -- 更新红点提示信息数据
        require "app.utils.BagNotificationUtil"
        BagNotificationUtil:updateUpgradableItems()
    -- 拖动物品到装备栏
    elseif (no == NetMessageType.GOODS_DRAG_EQUIPMENT_EQUIP.NO) then
        if(DEBUG) then
            print("GOODS_DRAG_EQUIPMENT_EQUIP  ",data.fromPacketType,data.index,data.equipEntityID,data.existEntityID)
        end
        local pk = RoleDataManager:getMasterPK()  

        -- 先取出数据
        local wearEquipmentData = GoodsDataManager:deleteEquipment(pk,data.fromPacketType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,data.equipEntityID)

        local unEquipOneData = GoodsDataManager:deleteEquipment(pk,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,data.existEntityID)


        --更换不同类型武器的装备更换提示技能发生变化 (等级小于等于30级时才提示)
        local heroData = RoleDataManager:getMaster()
        if wearEquipmentData and unEquipOneData and heroData and heroData:getLevel() <= 30 
            and wearEquipmentData:getEquipmentType() == PublicDefine.EQUIPMENT_TYPE.Weapon 
            and unEquipOneData:getEquipmentType() == PublicDefine.EQUIPMENT_TYPE.Weapon 
            and wearEquipmentData:getWeaponType() ~= unEquipOneData:getWeaponType() then

            UI.ScrollBar:createByText(UI.TEXT_223700)

        end



        local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..data.fromPacketType
        local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
        if(repeatData == nil) then
            repeatData = {}
        end
        local key = data.equipEntityID
        if(repeatData[key]) then
            repeatData[key] = repeatData[key] - 1
            MasterDataManager:insertRepeatHandleData(keyStr, key, repeatData[key])
        end

        -- 放入数据
        if wearEquipmentData then
            wearEquipmentData:setWearPosition(data.index)
            GoodsDataManager:addEquipmentDataForPK(pk,PACKET_TYPE.PACKET_EQUIPMENT,wearEquipmentData)    
        end
        if unEquipOneData then
            unEquipOneData:setWearPosition(0)
            GoodsDataManager:addEquipmentDataForPK(pk,data.fromPacketType,unEquipOneData)    
        end

        self:_addGoodsChange(PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,true)
        self:_addGoodsChange(data.fromPacketType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,true)

        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()
        -- 更新红点提示信息数据
        require "app.utils.BagNotificationUtil"
        BagNotificationUtil:updateUpgradableItems()
    elseif (no == NetMessageType.GOODS_ITEM_COOLDOWN.NO) then
        if DEBUG then
            print("[Net.NetGoodsSystem]  GOODS_ITEM_COOLDOWN  goodsID=",data.goodsID)
        end
        -- 物品冷却
        -- add by zp 这里由于协议修改，后面做该功能的同事做相关的具体逻辑处理
        -- GoodsDataManager:removeItemCooldownByGoodsID(data.goodsID)
    -- 处理道具冷却
    elseif (no == NetMessageType.GOODS_ITEM_COOLDOWN_STATUS.NO) then
        -- 处理道具冷却
        for k,v in pairs(data.itemCooldownStatus) do
            if DEBUG then
                print("GOODS_ITEM_COOLDOWN_STATUS  goodsID,curDuration=",v.goodsID,v.curDuration)
            end
            GoodsDataManager:handleItemCooldownData(v)
        end

        -- 发送道具冷却状态通知消息
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_ITEM_COOLDOWN_CHANEG)
    -- 快捷栏物品更新
    elseif (no == NetMessageType.GOODS_SHORTCUTS.NO) then
        -- 处理物品快捷栏数据更新
        if DEBUG then
            for k,v in pairs(data.shortcutsData) do
                print("GOODS_SHORTCUTS  index,templateID=",v.index,v.templateID)
            end
        end

        for k,v in pairs(data.shortcutsData) do
            GoodsDataManager:updateShortcutBar(v.index,v.templateID)
        end

        -- 发送通知消息
        local shortcutsData = GameDataManager:getInstance():getShortcutBarData()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE,shortcutsData)
    -- 同屏玩家穿戴装备
    elseif (no == NetMessageType.GOODS_SCREEN_EQUIP.NO) then
        if DEBUG then
            print("GOODS_SCREEN_EQUIP  index,spriteID,templateID=",data.index,data.spriteID,data.templateID,data.illusionID)
        end
        
        local goodsData = GoodsDataManager:createEquipmentForEquipmentID(data.templateID)
        if(goodsData) then
            goodsData:setWearPosition(data.index)
            goodsData:setIllusionID(data.illusionID)
            goodsData:setPrimogemID(data.primogemid)
            GoodsDataManager:addEquipEquipment(data.spriteID,goodsData)

            -- 发送英雄装备变动
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(data.spriteID)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

            -- 渲染层指令
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG, wearData)
            SceneManager:getInstance():pushCommand(command)
        end 
    -- 同屏玩家脱掉装备
    elseif (no == NetMessageType.GOODS_SCREEN_UN_EQUIP.NO) then
        if DEBUG then
            print("GOODS_SCREEN_UN_EQUIP  index,spriteID=",data.index,data.spriteID)
        end
        -- 处理穿戴移除
        GoodsDataManager:removeEquipEquipmentForIndex(data.spriteID,PACKET_TYPE.PACKET_EQUIPMENT,data.index) 

        -- 玩家穿戴改变
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(data.spriteID)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

        -- 渲染层指令
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG, wearData)
        SceneManager:getInstance():pushCommand(command)
    -- 开始使用道具
    elseif (no == NetMessageType.GOODS_BEGIN_USE_ITEM.NO) then
        if DEBUG then
            print("GOODS_BEGIN_USE_ITEM  ")
            dump(data)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_BEGIN_USE_ITEM, data)
        SceneManager:getInstance():pushCommand(command)

    -- 使用道具失败
    elseif (no == NetMessageType.GOODS_USE_ITEM_FAILED.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_USE_ITEM_FAILED, data)
        SceneManager:getInstance():pushCommand(command)
    -- 锁定物品返回值
    elseif (no == NetMessageType.GOODS_RESPONSE_LOCK_GOODS.NO) then
        if DEBUG then
            print("GOODS_RESPONSE_LOCK_GOODS  ",data.result, data.entityID, data.templateID, data.isLock)
            dump(data)
        end

        GoodsDataManager:handleGoodsLockChange(data)
    -- 解锁背包响应
    elseif (no == NetMessageType.GOODS_RESPONSE_UNLOCK_BAG_SPACE.NO) then
        -- 处理解锁背包响应

        RoleDataManager:handleResponseUnlockBagSpace(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_UNLOCK_RESPONSE)
    elseif (no == NetMessageType.GOODS_REP_SELECT_SHORTCUT_EQUIP.NO) then
        if DEBUG then
            print("GOODS_REP_SELECT_SHORTCUT_EQUIP  result, index=",data.result, data.index)
            dump(data)
        end
        -- 处理切换装备的逻辑处理
        RoleDataManager:handleResponseSelectShortcutEquip(data)
    --删除背包满的list
    elseif (no == NetMessageType.GOODS_DELETE_GOODS_FROM_FULL_BAG.NO) then
        if DEBUG then
            print("GOODS_DELETE_GOODS_FROM_FULL_BAG")
            dump(data)
        end
        MasterDataManager:removeFullBagData(data)
    -- 背包满的LIST存档 SC DS
    elseif (no == NetMessageType.GOODS_FULL_BAG_LIST_ARCHIVE.NO) then
        if DEBUG then
            print("GOODS_FULL_BAG_LIST_ARCHIVE")
            dump(data)
        end
        if data.fullBagData ~= nil then
            MasterDataManager:initFullBagData(data.fullBagData)
        end
    elseif (no == NetMessageType.GOODS_ADD_GOODS_TO_FULL_BAG.NO) then
        if DEBUG then
            print("GOODS_ADD_GOODS_TO_FULL_BAG")
            dump(data)
        end
        MasterDataManager:insertFullBagData(data.fullBagData)

    elseif (no == NetMessageType.GOODS_BROADCAST_ACHIEVE_GOODS.NO) then
        if DEBUG then
            print("GOODS_BROADCAST_ACHIEVE_GOODS")
            dump(data)
        end

        if(data.pk == RoleDataManager:getMasterPK()) then
            print("GOODS_BROADCAST_ACHIEVE_GOODS  notice self ")
            return
        end

        -- 处理系统消息打点
        if(not (data.reason == DROP_REASON_TYPE.DROP_REASON_MONSTER 
            or data.reason == DROP_REASON_TYPE.DROP_REASON_BOX ) ) then
            return
        end

        local chatMessageType = nil
        local nameLink = nil

        if(data.relation == "ERelation_team") then
            local teamData = TeamDataManager:getTeamDataForPK(data.pk)
            if(teamData) then
                chatMessageType = ChatMessageType.SYSTEM_TEAM_MEMBER
                nameLink = Game.ChatManager:getInstance():getNickNameLinkStr(chatMessageType, data.pk, 0, teamData:getNickName())
            end
        elseif (data.relation == "ERelation_guild") then
            local guildData = MasterDataManager:getGuildData()
            if(guildData) then
                local memberData = guildData:getMemberDataForPK(data.pk)
                if(memberData) then
                    chatMessageType = ChatMessageType.SYSTEM_GUILD_MEMBER
                    nameLink = MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType)
                else
                    print("GOODS_BROADCAST_ACHIEVE_GOODS  no found memeberdata pk=", data.pk)
                end
            else
                print("GOODS_BROADCAST_ACHIEVE_GOODS  no join guild  pk=", data.pk)
            end
        else

        end
        if(DEBUG) then 
            print("GOODS_BROADCAST_ACHIEVE_GOODS chatMessageType, nameLink=", chatMessageType, nameLink)
        end
        if(chatMessageType and nameLink) then
            
            local str = UI.TEXT_1110722
            local goodsData = GoodsDataManager:createLocalGoodsData(data.goods.templateID)
            goodsData:setNum(data.goods.num)
            if(goodsData) then
                if data.goods.num > 1 then
                    str = str.." x"..data.goods.num
                end
                local itemLink = Game.ChatManager:getInstance():getItemLinkStr(goodsData)
                if not itemLink then 
                    return
                end
                Game.ChatManager:getInstance():formartAndSendSystemMsg(chatMessageType, str, nameLink, itemLink)
            end
        end
    -- 请求穿装的反馈,注意只在有错误的时候反馈.
    elseif (no == NetMessageType.GOODS_RESPONSE_CODE_EQUIP.NO) then
        local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_BAG 
        local key = data.entityID
        MasterDataManager:removeRepeatHandleData(keyStr, key)

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_EQUIP_FAILED, data)
    -- 请求脱装的反馈,注意只在有错误的时候反馈.
    elseif (no == NetMessageType.GOODS_RESPONSE_CODE_UN_EQUIP.NO) then
        local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT 
        local key = data.entityID
        MasterDataManager:removeRepeatHandleData(keyStr, key)

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_UN_EQUIP_FAILED, data)
    elseif (no == NetMessageType.GOODS_RESPONSE_CODE_DRAG_GOODS_TO_PACKET.NO) then
        -- print(" NetMessageType.GOODS_RESPONSE_CODE_DRAG_GOODS_TO_PACKET.NO")
        -- dump(data)

        -- 移除本地缓存数据
        if(drapGoodsTable[1]) then
            local messageData = drapGoodsTable[1]
            if(messageData.fromPacketType == data.fromPacketType and messageData.toPacketType == data.toPacketType) then
                local key = messageData.templateID..":"..tostring(messageData.isGolden)
                if(messageData.entityID ~= nil and messageData.entityID ~= 0) then
                    key = messageData.entityID
                end

                local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..data.fromPacketType
                local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
                if(repeatData == nil) then
                    repeatData = {}
                end
                if(repeatData[key]) then
                    repeatData[key] = repeatData[key] - messageData.num
                    MasterDataManager:insertRepeatHandleData(keyStr, key, repeatData[key])
                end

                table.remove(drapGoodsTable, 1)
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_CODE_DRAG_GOODS_TO_PACKET, data)
    -- 主要做未知错误反馈处理.
    elseif (no == NetMessageType.GOODS_RESPONSE_SYSTEM_ERROR.NO) then
        if DEBUG then
            print("GOODS_RESPONSE_SYSTEM_ERROR")
            dump(data)
        end
        
        if(data.requestType == NetMessageType.GOODS_DELETE_GOODS_REQUEST.NO) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, data)
        end
    elseif (no == NetMessageType.GOODS_RES_CHOOSE.NO) then
        -- print("使用礼包返回")
        -- dump(data)
        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.result == ProtobufUtil:enum_id("GoodsSystem.ResponseChooseGoodsResultType", "ResponseChooseGoodsResultType_Suc")) then
            local rewardGoodsArr = {}
            for _,rewardData in pairs(data.rewards) do
                local goodsData = GoodsDataManager:createLocalGoodsData(rewardData.goodsID)
                if (goodsData) then
                    goodsData:setNum(rewardData.num)
                    goodsData:setIsGolden(true)
                    table.insert(rewardGoodsArr, goodsData)
                end
            end
            -- 如果没有 不提示
            if table.nums(rewardGoodsArr) <= 0 then
                return 
            end
            -- TODO 显示获取物品TIPS
            local rewardData = {}
            rewardData.goods = rewardGoodsArr

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.IAP_ON_PURCHASERESULT, rewardData)
            SceneManager:getInstance():pushCommand(command)
        -- 数量不正确
        elseif(data.result == ProtobufUtil:enum_id("GoodsSystem.ResponseChooseGoodsResultType", "ResponseChooseGoodsResultType_ErrorNum")) then
            UI.ScrollBar:createByText(UI.TEXT_111172)
        -- 背包已满
        elseif(data.result == ProtobufUtil:enum_id("GoodsSystem.ResponseChooseGoodsResultType", "ResponseChooseGoodsResultType_FullBag")) then
            UI.ScrollBar:createByText(UI.TEXT_111171)
        else
            UI.ScrollBar:createByText(UI.TEXT_1170002)
        end
    elseif (no == NetMessageType.GOODS_RES_EQUIP_ILLUSION_INFO.NO) then
        -- print(string.format("[Net.NetGoodsSystem] GOODS_RES_EQUIP_ILLUSION_INFO no:%d.", no), data)
        local illusionInfos = data.illusionInfos or {}
        
        require "app.datas.EquipIllusionDataManager"
        if(data.syncFlag == 0) then 
            EquipIllusionDataManager:initNet(illusionInfos, true)
        elseif(data.syncFlag == 1) then
            EquipIllusionDataManager:initNet(illusionInfos, false)
        elseif(data.syncFlag == 2) then 
            EquipIllusionDataManager:initNet(illusionInfos, false)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_EQUIP_ILLUSION_UPDATED)

            mvc.send("Manor_DressUp_Operation_Refresh", 1)
        end
    elseif (no == NetMessageType.GOODS_RES_EQUIP_ILLUSION_WEAR.NO) then
        -- print(string.format("[Net.NetGoodsSystem] GOODS_RES_EQUIP_ILLUSION_WEAR no:%d.", no), data)
        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.errorNo == "EquipIllusionResultType_OK") then
            -- 设置装备幻化
            local equipArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            for i,v in ipairs(equipArr) do
                if (v:getEntityID() == data.equipInstanceID) then
                    v:setIllusionID(data.illusionID)
                end
            end

            -- 设置购买状态
            require "app.datas.EquipIllusionDataManager"
            if (data.illusionID and data.illusionID ~= 0) then
                local equipIllusionData = EquipIllusionDataManager:getPossessingIllusionById(data.illusionID)
                if (equipIllusionData) then equipIllusionData:setIsBought(true) end
            end

            -- 通知
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT, true, data)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT, false)
        end
    elseif (no == NetMessageType.GOODS_NTF_NEW_EQUIP_ILLUSION.NO) then
        -- print(string.format("[Net.NetGoodsSystem] GOODS_NTF_NEW_EQUIP_ILLUSION no:%d.", no), data)
        require "app.datas.EquipIllusionDataManager"
        EquipIllusionDataManager:setIllusionIsNew(data.templateID, true)
        EquipIllusionDataManager:showNewEquipIllusionNotice(data.templateID)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_EQUIP_NEW_ILLUSION, data.templateID)
    elseif (no == NetMessageType.GOODS_PUSH_OPEN_BOX_GE_GOODS.NO) then
        -- 获得的物品
        if data.goodsID ~= nil and #data.goodsID ~= 0 then
            if(data.isFullBagByMail) then 
                UI.ScrollBar:createByText(UI.TEXT_1170856)
            end

            local itemData = {}
            local openGoodsData = nil
            if(data.openBoxTemplateID and data.openBoxTemplateID ~= 0) then 
                openGoodsData = GoodsDataManager:createLocalGoodsData(data.openBoxTemplateID)
            end
            for k, v in pairs(data.goodsID) do
                local goodsType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                if(v.templateID ~= 0) then
                    goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(v.templateID)
                end
                if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    local goodData = GoodsDataManager:getEquipmentForEntityID(v.entityID)
                    if goodData ~= nil then
                        table.insert(itemData, goodData)
                    end
                elseif(goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                    local goodData = RelicDataManager:getRelicForEntityID(v.entityID)
                    if goodData ~= nil then
                        table.insert(itemData, goodData)
                    end
                else
                    local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
                    if(goodData) then
                        goodData:setIsNew(false)
                        goodData:setNum(v.num)
                        table.insert(itemData, goodData)
                    end
                end
            end
            local titleStr = nil 
            if(openGoodsData) then 
                titleStr = string.format(LanguageManager:getInstance():getLocalString(1111737), openGoodsData:getName())
            end

            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, titleStr, nil, nil, true)
        end
    elseif (no == NetMessageType.NOTIFY_OPEN_QUESTION_NAIRE.NO) then
        local str = string.format(UI.TEXT_1212325, PublicDefine.CONST_DEFINITION.REWARD_DIAMOND_QUESTIONNAIRE)
        GameManager:showConfirmOpenWebView(str, data.itemID, Net.HttpSubDirection.LeiTingQuestionNaire)
    elseif (no == NetMessageType.RESPONSE_STAR_PRAY_LUCKY_DRAW.NO) then
        UI.WaitingLayer:hideWaiting() 
        if data.err == ProtobufUtil:enum_id("GoodsSystem.StarPrayError", "StarPrayError_OK") then
            mvc.starPrayModel:setLuckyDrawData(true, data)

            local goodData = GoodsDataManager:createLocalGoodsData(data.goodsData.templateID)
            local ProtobufUtil = require "utils.ProtobufUtil"
            local netData = ProtobufUtil:decode("GoodsSystem.StarPrayData", data.goodsData.goodsDataBytes)
            goodData:initNetData(netData)
            local linkStr = Game.ChatManager:getInstance():getItemLinkStr(goodData)
            if not linkStr then
                return
            end
            local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, UI.TEXT_1110722, you, linkStr)
            end, 2)
        else
            GameErrorManager:showError(data.err)
            mvc.starPrayModel:setLuckyDrawData(false)
        end
     elseif (no == NetMessageType.STAR_PRAY_TEN_DRAW_RES.NO) then
        -- StarPrayError_SysErr = 2;
        -- StarPrayError_ArgsErr = 217;          // 参数错误
        -- StarPrayError_BagFull = 218;          // 背包满
        if mvc.starPrayController then
            -- repeated GoodsData goodsData = 2;           // 获得道具     都是数组 位置对应
            -- repeated uint32 starPrayPools = 3;          // 奖励池
            -- repeated uint32 costID =4;                  // 消耗类型
            -- repeated uint32 costNum =5;     
            UI.WaitingLayer:hideWaiting() 
            mvc.starPrayModel:setStarFireNum(data.starFireNum)
            mvc.starPrayModel:setStarPrayPool(data.starPrayPools[#data.starPrayPools])
            mvc.starPrayController:onStarPrayTenShopResponse(data.err == 1
                , data.goodsData
                , data.starPrayPools
                , data.costID
                , data.costNum
            )
        end
     elseif (no == NetMessageType.RESPONSE_STAR_PRAY_WEAR.NO) then
        UI.WaitingLayer:hideWaiting() 
        local isSucc = data.err == ProtobufUtil:enum_id("GoodsSystem.StarPrayError", "StarPrayError_OK")
        if not isSucc then
            if data.err == ProtobufUtil:enum_id("GoodsSystem.StarPrayError", "StarPrayError_StarPlateLocked") then
                UI.ScrollBar:createByText(UI.TEXT_227712)
            else
                GameErrorManager:showError(data.err)
            end
            
        end
        if data.isOn then
            mvc.starPrayModel:updateStarPrayEquipIndex(data.instID,data.index, data.plateId)
        else
            mvc.starPrayModel:updateStarPrayEquipBelong(data.instID, data.plateId)
        end
        if mvc.starPrayController then
            mvc.starPrayController:onStarPrayEquipResponse(isSucc)
        end
    elseif (no == NetMessageType.RESPONSE_STAR_PRAY_SWALLOW.NO) then
        UI.WaitingLayer:hideWaiting() 
        local isSucc = data.err == ProtobufUtil:enum_id("GoodsSystem.StarPrayError", "StarPrayError_OK")
        if not isSucc then
            GameErrorManager:showError(data.err)
        else
            mvc.starPrayModel:updateStarPrayInfo(data.instid,data.lv, data.exp)
        end
        if mvc.starPrayController then
            mvc.starPrayController:onStarPraySwallowResponse(isSucc)
        end

    elseif (no == NetMessageType.RESPONSE_RELIC_DECOMPOSE.NO) then
        UI.WaitingLayer:hideWaiting()
        local isSucc = data.err == ProtobufUtil:enum_id("PublicDefine.ErrNo", "ErrNo_Ok")
        if not isSucc then
            UI.ScrollBar:createByText(UI.TEXT_1170002)
            printInfo("RESPONSE_RELIC_DECOMPOSE is error with code : "..data.err)
            return
        end

    elseif (no == NetMessageType.RESPONSE_RELIC_STRENGTHEN.NO) then
        local isSucc = data.err == ProtobufUtil:enum_id("PublicDefine.ErrNo", "ErrNo_Ok")
        if not isSucc then
            UI.ScrollBar:createByText(UI.TEXT_1170002)
            printInfo("RESPONSE_RELIC_STRENGTHEN is error with code : "..data.err)
            return
        end
        RelicDataManager:resRelicStrength(data.success)

    elseif (no == NetMessageType.RESPONSE_RELIC_WEAR.NO) then
        UI.WaitingLayer:hideWaiting()
        local isSucc = data.err == ProtobufUtil:enum_id("PublicDefine.ErrNo", "ErrNo_Ok")
        if not isSucc then
            UI.ScrollBar:createByText(UI.TEXT_1170002)
            printInfo("RESPONSE_RELIC_WEAR is error with code : "..data.err)
            return
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE)

    elseif (no == NetMessageType.RESPONSE_RELIC_INSTDATA.NO) then
        for index = 1, #data.relics do
            local goodsMesData = ProtobufUtil:decode("GoodsSystem.GoodsData", data.relics[index])
            local pk = RoleDataManager:getMasterPK()
            local packetType = goodsMesData.packet
            local packetSubType = goodsMesData.subPacket
            self:_handlePackGood(pk, packetType, packetSubType, 2, goodsMesData)
        end
        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()
    elseif (no == NetMessageType.RESPONSE_HERO_STORE_DATA.NO) then
        -- SC 同步商店数据 (反斗乐限购商店)
        GoodsDataManager:updateStorePurchaseLimitData(data.limitData)

    elseif (no == NetMessageType.GOODS_RESPONSE_NEW_DRAG_GOODS_TO_PACKET.NO) then
        local pk = RoleDataManager:getMasterPK()  

        -- for k,v in pairs(data) do
            print("GOODS_RESPONSE_NEW_DRAG_GOODS_TO_PACKET  k,v=", data)
        -- end

        --         required DragGoodsToPacketResult result = 3;
        -- optional uint32 fromPacketType = 1;
        -- optional uint32 toPacketType = 2;
        -- repeated PublicDefine.GoodsID goodsIDs = 4;
        local toPacketType = data.toPacketType
        local fromPacketType = data.fromPacketType

        for k, data in ipairs(data.goodsIDs) do 
            local goodsID = data.templateID
            local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
            if DEBUG then
                print("GOODS_DRAG_GOODS_TO_PACKET fromPacketType,goodsType,goodsID=",fromPacketType,goodsType,goodsID)
            end
            -- 先移除数据
            local oldIsLock = false
            local goodsData = nil
            local num = 1
            local key = ""
            if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC
            then
                goodsData = GoodsDataManager:deleteEquipment(pk,fromPacketType,goodsType,data.entityID)
                self:_addGoodsChange(fromPacketType, goodsType,true)
                if(goodsData) then 
                    oldIsLock = goodsData:getIsLock()
                end
                key = data.entityID
            else    
                key = goodsID..":"..tostring(data.isGolden)
                num = data.num
                oldIsLock = GoodsDataManager:getItemOrMaterialLockStatus(pk, goodsID, goodsType)
                local isChange = GoodsDataManager:deleteMaterialOrItem(pk,fromPacketType,goodsType,goodsID,data.isGolden,data.num)
                if isChange then
                    self:_addGoodsChange(fromPacketType, goodsType,true)
                end
                self:_addGoodsUpdate(fromPacketType, goodsType,goodsID)
            end

            local keyStr = RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..fromPacketType
            local repeatData = MasterDataManager:getRepeatHandleData(keyStr)
            if(repeatData == nil) then
                repeatData = {}
            end
            if(repeatData[key]) then
                repeatData[key] = repeatData[key] - num
                MasterDataManager:insertRepeatHandleData(keyStr, key, repeatData[key])
            end

            -- 后加入数据
            if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
                or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                if DEBUG then
                    print("GOODS_DRAG_GOODS_TO_PACKET  add data =",toPacketType,goodsType,goodsData)
                end
                if goodsData then
                    GoodsDataManager:addEquipmentDataForPK(pk,toPacketType,goodsData)
                    self:_addGoodsChange(toPacketType,goodsType,true)
                end
            else
                local goodsData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(pk,toPacketType,goodsType,goodsID,data.isGolden)
                -- 获取物品相关的
                local goodsStatusData = {}
                goodsStatusData.isGolden = data.isGolden
                goodsStatusData.isLock = oldIsLock

                -- 处理是否为新的标签
                if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_TEMPORARY and data.toPacketType == PublicDefine.PACKET_TYPE.PACKET_BAG) then
                    -- 添加判断是否为洞穴里面
                    if(SceneManager:getInstance():isInFightScene()) then
                        goodsStatusData.isInCaveNewGet = true
                    end 
                end 

                local goodsData,update,change = GoodsDataManager:handleAddGoodsData(pk,toPacketType, nil, goodsType,goodsID,data.num,nil,goodsStatusData)
                if change then
                    self:_addGoodsChange(toPacketType,goodsType,true)
                end
                self:_addGoodsUpdate(toPacketType,goodsType,goodsID)
            end
        end 

        -- 移除本地缓存数据
        if(drapGoodsTable[1]) then
            local messageData = drapGoodsTable[1]
            if(messageData.fromPacketType == fromPacketType and messageData.toPacketType == data.toPacketType) then
                table.remove(drapGoodsTable, 1)
            end
        end

        mvc.send(mvc.events.Expedition_Drag_Goods_Result, data)

        -- 发送改变消息
        self:_sendDataChange()
        -- 发送数量改变消息
        self:_sendDataUpdate()
    elseif (no == NetMessageType.GOODS_CHOOSE_GOODS_BOUGTH_INFO.NO) then
        if MasterDataManager:handleGoodsUseInfo(data) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GOODS_USE_INFO_CHANGE)
        end
    elseif (no == NetMessageType.GOODS_CHOOSE_GOODS_GET_RESULT.NO) then
        if MasterDataManager:handleGoodsUseInfo(data) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_GOODS_USE_INFO_CHANGE)
        end
        UI.WaitingLayer:hideWaiting()
        GameErrorManager:showError(data.result)
    elseif (no == NetMessageType.GOODS_RESPONSE_STARPRAY_NTF_INFO_MSG.NO) then
        mvc.starPrayModel:updateSilverBuyCount(data.goldDarwNum)
        mvc.starPrayModel:updateShopExp(data.luckyScore)
    elseif (no == NetMessageType.GOODS_STARPRAY_LUCKY_AWARD_RESPONSE.NO) then
        if data.err == 1 then
            mvc.starPrayModel:setRewardData(data)
        end
    elseif (no == NetMessageType.GOODS_STARPRAY_SYNC_HERO_GOODS_DATA_MESSAGE.NO) then
        -- 更新套装数据到客户端 (改造后的套装信息,  增量)
            print("  推送 套装数据到客户端  ======     ")
            dump(data)
            mvc.suitTransformationModel:updateSetData(data.equipSetData)
    elseif (no == NetMessageType.GOODS_STARPRAY_RESP_RESET_RETROFIT_MESSAGE.NO) then
        -- 重置套装属性返回的数据
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            print( "GOODS_STARPRAY_RESP_RESET_RETROFIT_MESSAGE =====data === ")
            dump(data)
            mvc.suitTransformationModel:resetRetrofitData(data)
            mvc.suitTransformationController:resetRetrofitDataUpdateLayer()
        else
            GameErrorManager:showError(data.result)
        end
        
    elseif (no == NetMessageType.GOODS_STARPRAY_RESP_RETROFIT_EQUIP_SET_MESSAGE.NO) then
        -- 套装属性改造结果
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            mvc.openPanel("SuitTransformation", "SuitTransformationSelectRetrofit", data)
            mvc.panelMonitor:showPanelByName("SuitTransformation")
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.GOODS_STARPRAY_RESP_SELECT_RETROFIT_MESSAGE.NO) then
        -- 选择套装属性结果
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            mvc.suitTransformationModel:retrofitData(data)
            mvc.suitTransformationController:resetRetrofitDataUpdateLayer()
            mvc.suitTransformationController:closeSelectLayer()
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.RESPONSE_IDENTIFY_TREASURE_ITEM_MESSAGE.NO) then
        --if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            --print("RESPONSE_IDENTIFY_TREASURE_ITEM_MESSAGE result is err : " .. data.result)
            --return
        --end
        print("  推送 数据到客户端  ======     ")
            dump(data)
        UI.WaitingLayer:hideWaiting()
        local awardsList = {}

        local goodsData = {}
        if data.templateId and data.result == PublicDefine.ErrNo.ErrNo_Ok then
            goodsData = GoodsDataManager:createLocalGoodsData(data.templateId)
            if goodsData then
                goodsData:setNum(data.count)
                table.insert(awardsList,goodsData)
            end
        end

        -- 鉴定结果，目前默认为成功
        local isIdentifySuccess = true
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            -- 不等于ok就是鉴定失败
            isIdentifySuccess = false
        end
        mvc.identifyTreasureItemController:refreshLeftView()
        mvc.identifyTreasureItemController:addGoodsData(goodsData, isIdentifySuccess)
        mvc.identifyTreasureItemController:refreshTriggerAnimation()

        --[[if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
        end--]]
    elseif (no == NetMessageType.RESPONSE_CHANGE_PURPLE_MESSAGE.NO) then
        -- 紫装升红
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.entityID)
            equipmentData:updateEquipByPrimogem(data.consumeid)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PURPLE_UPGRADE_SUCCESS, equipmentData)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.RESPONSE_RESET_PURPLE_MESSAGE.NO) then
        -- 紫装升红重置
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.entityID)
            equipmentData:resetEquipByPrimogem()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PURPLE_RESET_SUCCESS)
            UI.ScrollBar:createByText(UI.TEXT_227520)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.RESPONSE_GEM_CONNECT.NO) then
        -- 请求符文石连接结果
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then

            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipUid)
            if(equipmentData) then 
                for k,v in ipairs(equipmentData._holeDataArr) do
                    if k == data.holeIndex + 1 then
                        v.viceGemStoneID = data.viceGemid
                        if v.gemStoneData then
                            v.gemStoneData.viceGemStoneID = data.viceGemid
                        end
                        break
                    end
                end
            end

            UI.ScrollBar:createByText(UI.TEXT_227908)

            mvc.send(mvc.events.GemView_Refresh, false)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.RESPONSE_GEM_DIS_CONNECT.NO) then
        -- 请求断开连接结果
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then

            local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipUid)
            if(equipmentData) then 
                for k,v in ipairs(equipmentData._holeDataArr) do
                    if k == data.holeIndex + 1 then
                        v.viceGemStoneID = 0
                        if v.gemStoneData then
                            v.gemStoneData.viceGemStoneID = 0
                        end
                        break
                    end
                end
            end

            UI.ScrollBar:createByText(UI.TEXT_227910)

            mvc.send(mvc.events.GemView_Refresh, true)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.RESPONSE_GEM_DECOMPOSE.NO) then 
        -- 请求符文分解结果
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then

            local simpleGoodsID = data.goodsID

            mvc.send(mvc.events.GemDecomposeView_Refresh,simpleGoodsID)
        else
            GameErrorManager:showError(data.result)
        end
    else
        assert(false, string.format("[Net.NetGoodsSystem] onGoodsMessageHandler no %d is invaild.", no))
    end    
end

--[[
    goods: 物品列表数据
    packetType:
    packetSubType: 背包小类型
    pk:
    handleType: 1 初始化， 2 获得
]]
function NetGoodsSystem:_handlePackGoods(goods, packetType, packetSubType, pk, handleType)
    local goodsArr = {}

    -- local 
    for k,v in pairs(goods) do
        local goodsData = self:_handlePackGood(pk, packetType, packetSubType, handleType, v)
        table.insert(goodsArr,goodsData)
    end

    -- 发送改变消息
    self:_sendDataChange()
    -- 发送数量改变消息
    self:_sendDataUpdate()

    -- -- 测试打印当前背包物品
    -- local bagData = GameDataManager:getInstance():getPacketBoxData()
    
    return goodsArr
end

-- 处理物品包数据处理
function NetGoodsSystem:handlePackGoodsData(v)
    local goodsID = v.templateID
    -- 把ID 转换为 goodsType
    local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

    local goodsData = nil
    local num = v.num
    local goodsStatusData = self:_makeGoodsStatusData(v)
    local goodsMesData = self:_handleGoodsMesData(goodsType, v)

    goodsData = GoodsDataManager:handleCreateGoodsData(goodsType,goodsID,num,goodsMesData,goodsStatusData)

    return goodsData
end

-- 处理雕纹包数据处理
function NetGoodsSystem:handleMailPackGlyphsData(v)
    local goodsID = v.entityID
    -- 把ID 转换为 goodsType
    local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
    -- v.goodsDataBytes = v
    v.isGolden = false
    v.isLock = false
    v.isInCaveNewGet = false
    v.index = 1
    
    local goodsData = nil
    local num = 1
    local goodsStatusData = self:_makeGoodsStatusData(v)
    local goodsMesData = v--elf:_handleGoodsMesData(goodsType, v)

    goodsData = GoodsDataManager:handleCreateGoodsData(goodsType,goodsID,num,goodsMesData,goodsStatusData)

    return goodsData
end

-- 生成物品状态数据
function NetGoodsSystem:_makeGoodsStatusData(v)
    local goodsStatusData = {}
    goodsStatusData.isGolden = v.isGolden
    goodsStatusData.isLock = v.isLock
    goodsStatusData.index = v.index
    goodsStatusData.isInCaveNewGet = v.isInCaveNewGet

    return goodsStatusData
end

function NetGoodsSystem:_handleGoodsMesData(goodsType, v)
    local goodsMesData = nil

    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentData",v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.StarPrayData",v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.RelicData", v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",v.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentGlyphData",v.goodsDataBytes)
    end

    return goodsMesData
end

function NetGoodsSystem:_handlePackGood(pk, packetType, packetSubType, handleType, v)
    local goodsID = v.templateID

    -- 把ID 转换为 goodsType
    local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

    local goodsData = nil
    local isUpdate = false
    local isChange = false

    local num = v.num

    local goodsStatusData = self:_makeGoodsStatusData(v)

    local goodsMesData = self:_handleGoodsMesData(goodsType, v)
    if handleType == 1 then
        goodsData = GoodsDataManager:handleInitGoodsData(pk,packetType, packetSubType,goodsType,goodsID,num,goodsMesData,goodsStatusData)
        self:_addGoodsChange(packetType,goodsType,true)
    elseif handleType == 2 then
        goodsData,isUpdate,isChange = GoodsDataManager:handleAddGoodsData(pk,packetType, packetSubType,goodsType,goodsID,num,goodsMesData,goodsStatusData)

        -- 记录改变的对象
        if isUpdate then
            self:_addGoodsUpdate(packetType,goodsType,goodsID)
        end

        self:_addGoodsChange(packetType,goodsType,isChange)
    end

    -- 刷新是否新标志
    if goodsData then
        if packetType == PACKET_TYPE.PACKET_BAG or packetType == PACKET_TYPE.PACKET_TEMPORARY then
            GoodsDataManager:refreshIsNew(goodsData)
        else
            GoodsDataManager:setGoodsDataNew(goodsData,false)
        end
        goodsData:setBytesData(v.goodsDataBytes)
    end

    -- if DEBUG then
    --     if goodsData then
    --         goodsData:print()
    --     else
    --         print("Net.NetGoodsSystem:_handlePackGoods  goodsData is null")
    --     end
    -- end

    return goodsData
end


function NetGoodsSystem:_addGoodsChange(packetType,goodsType,isChange)
    if isChange then
        if not self.changeStatusArr then
            self.changeStatusArr = {}
        end

        local packetArr = self.changeStatusArr[packetType]
        if not packetArr then
            packetArr = {}
            self.changeStatusArr[packetType] = packetArr
        end

        packetArr[goodsType] = isChange
    end
end

function NetGoodsSystem:_addGoodsUpdate(packetType,goodsType,goodsID)
    if not self.updateGoodsDataArr then
        self.updateGoodsDataArr = {}
    end

    local packetArr = self.updateGoodsDataArr[packetType]
    if not packetArr then
        packetArr = {}
        self.updateGoodsDataArr[packetType] = packetArr
    end

    local goodsArr = packetArr[goodsType]
    if not goodsArr then
        goodsArr = {}
        packetArr[goodsType] = goodsArr
    end

    goodsArr[goodsID] = goodsID
end

function NetGoodsSystem:_removeGoodsUpdate(packetType,goodsType)
    if not self.updateGoodsDataArr then
        self.updateGoodsDataArr = {}
    end

    local packetArr = self.updateGoodsDataArr[packetType]
    if not packetArr then
        packetArr = {}
        self.updateGoodsDataArr[packetType] = packetArr
    end

    packetArr[goodsType] = nil
end

function NetGoodsSystem:_sendDataChange()
    if not self.changeStatusArr then
        return
    end

    local master = RoleDataManager:getMaster()
    local pk = RoleDataManager:getMasterPK()

    for packetType ,packetArr in pairs(self.changeStatusArr) do
        for goodsType,isChange in pairs(packetArr) do
            -- 对数据进行排序操作
            -- print("Net.NetGoodsSystem:_sendDataChange sort ",pk,packetType,goodsType)
            GoodsDataManager:sortGoods(pk,packetType,goodsType)

            -- 发送数据有条数变动
            if packetType == PACKET_TYPE.PACKET_BAG then
                -- if DEBUG then
                --     print("Net.NetGoodsSystem:_sendDataChange PACKET_BAG  packetType,v=",packetType,goodsType)
                -- end

                local goodsArr = GameDataManager:getInstance():getBagGoodsArrForType(goodsType)
                if goodsType== PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,goodsArr)
                elseif goodsType== PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,goodsArr)
                elseif goodsType== PublicDefine.GOODS_TYPE.GOODS_RELIC then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE,goodsArr)
                elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
                    GoodsDataManager:refreshShortcutBar(true)

                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE,goodsArr)
                    -- 发送快捷栏数据改变
                    Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_CHANGE)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)
                elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE,goodsArr)
                elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE,goodsArr)
                elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE,goodsArr)
                end
            elseif packetType == PACKET_TYPE.PACKET_WAREHOUSE  then
                -- 仓库改变
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WAREHOUSE_CHANGE,goodsType)
            elseif packetType == PACKET_TYPE.PACKET_STARPRAY  then
                -- 仓库改变
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_STAR_PRAY_CHANGE,goodsType)
            elseif packetType == PACKET_TYPE.PACKET_STARPRAY_WEAR  then
                -- 仓库改变
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_STAR_PRAY_WEAR_CHANGE,goodsType)
            elseif packetType == PACKET_TYPE.PACKET_EQUIPMENT  then
                -- 穿戴装备发生改变

                -- 给UI发送消息
                local wearData = GameDataManager:getInstance():getWearEquipmentData()
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
                
                -- 由于穿戴装备发生变化导致激活技能发生变化
                Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_CHANGE)
                Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)
                
                if DEBUG then
                    print("command:initForTypeAndData(CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG, wearData)",#wearData.wearEquipmentArr)
                end

                -- 渲染层指令
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG, wearData)
                SceneManager:getInstance():pushCommand(command)
            elseif packetType == PACKET_TYPE.PACKET_PET_EQUIPMENT  then
                local wearData = MasterDataManager:getAllWearPetEquipment()
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_PET_EQUIPMENT_CHANGE,wearData)
            elseif packetType == PACKET_TYPE.PACKET_TEMPORARY  then
                -- 临时背包数据发生改变

                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_ISFULL)
            elseif packetType == PACKET_TYPE.PACKET_GLYPH  then
                local goodsArr = GoodsDataManager:getGoodsArrForPK(pk, packetType,goodsType)
                if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GLYPH_CHANGE,goodsArr)
                end
            end

            self:_removeGoodsUpdate(packetType,goodsType)
        end
    end

    self.changeStatusArr = nil
end

function NetGoodsSystem:_sendDataUpdate()
    if not self.updateGoodsDataArr then
        return
    end

    for packetType ,packetArr in pairs(self.updateGoodsDataArr) do
        for goodsType,goodsArr in pairs(packetArr) do
            -- 发送数据有数值变动
            if packetType == PACKET_TYPE.PACKET_BAG then
                if DEBUG then
                    print("Net.NetGoodsSystem:_sendDataUpdate MC_GOODS_BAG_GOODSDATA_REFRESH ",goodsType,#goodsArr)
                end

                local sendItem = false
                if goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
                    sendItem = true
                end
                -- 刷洗快捷栏数据，这里可以优化刷新
                GoodsDataManager:refreshShortcutBar(true)
                -- 发送快捷栏数据改变
                Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)

                for k,goodsID in pairs(goodsArr) do
                    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH, goodsID)

                    if sendItem then
                        if DEBUG then
                            print("Net.NetGoodsSystem:_sendDataUpdate MC_SHORTCUT_BAG_REFRESH ", goodsID)
                        end
                        -- 发送道具数据改动
                        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_REFRESH, goodsID)
                    end
                end
            elseif packetType == PACKET_TYPE.PACKET_WAREHOUSE  then
                -- TODO

            elseif packetType == PACKET_TYPE.PACKET_EQUIPMENT  then
                -- TODO
                
            elseif packetType == PACKET_TYPE.PACKET_TEMPORARY  then
                -- TODO

            end
        end
    end

    self.updateGoodsDataArr = nil
end
