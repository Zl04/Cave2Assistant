--[[
    游戏的客户端消息处理
]]--

local AudioUtil = require ("app.utils.AudioUtil")
local MapDefine = require "app.mapkit.MapDefine"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local SceneManager = require("app.game.SceneManager")
local MapHelper = require "app.mapkit.MapHelper"
local Manager = Game.Manager

local proto = require "utils.ProtobufUtil"

local PACKET_TYPE = PublicDefine.PACKET_TYPE
local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
local GOODS_TYPE = PublicDefine.GOODS_TYPE
local ITEM_TYPE = PublicDefine.ITEM_TYPE

function Manager:createHero(nickName, sex, faceDecodeID,hairSelectNum,eyeSelectNum,mouthSelectNum,skinSelectNum,sexSelectNum,tRandomNum,areaID)
    local gameLoginManager = require("app.game.GameLoginManager")
    local account = gameLoginManager:getInstance():getAccountId()
    -- if DEVELOPMENT_MODE then
    --     account = gameLoginManager:getInstance():getTestAccount()
    -- end
    Net.NetLoginSystem:createHero(account, nickName, sex, faceDecodeID,hairSelectNum,eyeSelectNum,mouthSelectNum,skinSelectNum,sexSelectNum,tRandomNum,areaID)
end

-- 使用技能
function Manager:useSkillHandler(skillData)
    -- --print("[Game Manager]: use skill ",skillData)
    -- --print("[Game Manager]: use skill ",skillData.skillData,skillData.targetSpriteID,skillData.coordX,skillData.coordY)
    -- --print("[Game Manager]: use skill ",skillData.skillData.ID)

    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initForTypeAndData(CommandType.BATTLE_USE_SKILL,skillData)
    MachineManager:getInstance():executeCommand(battleCMD)
end


-- 准备逃跑
function Manager:leaveBattleHandler()
    ----print(string.format("[Game Manager]: leaveBattleHandler "))

    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initForTypeAndData(CommandType.BATTLE_ESCAPE,nil)
    MachineManager:getInstance():executeCommand(battleCMD)
end

-- 开始移动
function Manager:startMoveHandler(direction)
    -- --print(string.format("[Game Manager]: startMoveHandler %d",direction))

    local generationCMD = Command.GenerationCommand:create(true)
    generationCMD:initForStartMove(direction)
    MachineManager:getInstance():executeCommand(generationCMD)
end

-- 停止移动
function Manager:stopMoveHandler()
    -- print("[Game Manager] stopMoveHandler")
    -- print(debug.traceback())

    local generationCMD = Command.GenerationCommand:create(true)
    generationCMD:initForStopMove()
    MachineManager:getInstance():executeCommand(generationCMD)
end

-- 锁定物品
function Manager:lockGoodsHandler(goodsData, packetType)
    local nowPacketType = GameDataManager:getInstance():getGoodsPacketTypeForPacketType(goodsData, packetType)
    local isLock = not goodsData:getIsLock()
    local petID = nil
    if(goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
        local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(goodsData:getEntityID())
        if(petRoleData) then
            nowPacketType = PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT
            petID = petRoleData:getId()
        end
    end

    Net.NetGoodsSystem:requestLockGoods(nowPacketType, goodsData, isLock, petID)
end

-- 丢弃物品 
function Manager:bagLostGoodsHandler(goodsArr, callback)
    --print("+++++++++[Game Manager] bagLostGoodsHandler ")
    
    local isNoticeSell = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), true)  
    local isHaveGold = false
    for k,goodsData in pairs(goodsArr) do 
        if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
            isHaveGold = true
            break
        end
    end
    --二次确认
    if isHaveGold and isNoticeSell then 
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212237, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self:_bagLostGoodsHandler(goodsArr)
            if callback then
                callback()
            end
        end, function(isSelect)
        end, nil, nil, true)
    else
        self:_bagLostGoodsHandler(goodsArr)
        if callback then
            callback()
        end
    end
end

function Manager:_bagLostGoodsHandler(goodsArr)
    -- 处理丢弃数据处理
    for k,goodsData in pairs(goodsArr) do 
        local key = goodsData:getGoodsID()..":"..tostring(goodsData:getIsGolden())
        -- 这里有一些和业务逻辑绑定的处理
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            key = goodsData:getEntityID()
        end
    end 
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetGoodsSystem:deletGoodsRequest(PACKET_TYPE.PACKET_BAG,goodsArr)
end

-- 卖掉物品
function Manager:sellGoodsHandler(goodsData, num, spriteID, callback)
    local isGlyphTitle = 0
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsData.goodsID)
    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        if goodsData.isEquiped then
            UI.ScrollBar:createByText(UI.TEXT_1213203)
            return
        end
    end
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        if goodsData.isEquiped then
            UI.ScrollBar:createByText(UI.TEXT_227000)
            if cancelCallback then
                cancelCallback()
            end
            return
        elseif goodsData:isRefined() then
            isGlyphTitle = 2
        end
    -- elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    -- and goodsData.materialType then
    --     if goodsData.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
    --         UI.ScrollBar:createByText(UI.TEXT_227509)
    --         if cancelCallback then
    --             cancelCallback()
    --         end
    --         return
    --     end
    end
    --print("============[Game Manager] sellGoodsHandler ")
    local isNoticeSell = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), true)  
    local isHaveGold = false
    if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 and
       goodsType ~= PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        isHaveGold = true
    elseif goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4 and
        goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        isGlyphTitle = 1
    end
    -- if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
    --     isHaveGold = true
    -- end
    --二次确认
    if isHaveGold and isNoticeSell then 
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212236, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self:_sellGoodsHandler(goodsData, num, spriteID)
            if callback then
                callback()
            end
        end, function(isSelect)
            
        end, nil, nil, true)
    elseif isGlyphTitle > 0 then
        local titleStr = (isGlyphTitle == 1) and UI.TEXT_227011 or UI.TEXT_227012
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(titleStr, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self:_sellGoodsArrHandler(goodsDataArr, spriteID)
            if callback then
                callback()
            end
        end, function(isSelect)
            if cancelCallback then
                cancelCallback()
            end
        end, nil, nil, true)
    else
        self:_sellGoodsHandler(goodsData, num, spriteID)
        if callback then
            callback()
        end
    end
end

function Manager:_sellGoodsHandler(goodsData, num, spriteID)
    --("Manager:sellGoodsHandler  num,spriteID=",num, spriteID)
    -- 处理卖掉物品
    local sellGoodsArr = {}
    local sellEquipGoods = {}
    local sellWarehouse = {}
    local sellPetGoods = {}
    local sellGlyphGoods = {}
    local sellPrimogemGoods = {}
    sellPrimogemGoods.goodsID = {}

    -- 这里应该优化，把同一样物品合并成一个
    local buyGoods = {}
    buyGoods.num = num
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
        
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        buyGoods.templateID = 0
        buyGoods.isGolden = goodsData:getIsGolden()
        buyGoods.entityID = goodsData:getEntityID()
        if(GameDataManager:getInstance():judgeIsEquipmentData(buyGoods.entityID)) then
            table.insert(sellEquipGoods,buyGoods)
        else 
            table.insert(sellGoodsArr,buyGoods)
        end 
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
        -- goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE or 
        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        
        if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL and goodsData.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
            -- local decomposeGoods = {}
            -- decomposeGoods.goodsID = {}
            local sellGoods = {}
            sellGoods.templateID = goodsData:getGoodsID()
            sellGoods.num = goodsData:getNum()
            -- decomposeGoods.goodsID = sellGoods
            table.insert(sellPrimogemGoods.goodsID,sellGoods)
            -- sellPrimogemGoods = decomposeGoods
            -- table.insert(sellPrimogemGoods,decomposeGoods)
        else
            buyGoods.templateID = goodsData:getGoodsID()
            buyGoods.isGolden = goodsData:getIsGolden()
            buyGoods.entityID = 0
            table.insert(sellGoodsArr,buyGoods)
        end
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        buyGoods.entityID = goodsData:getEntityID()
        buyGoods.isGolden = goodsData:getIsGolden()
        buyGoods.templateID = 0
        table.insert(sellPetGoods,buyGoods)
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        buyGoods.entityID = goodsData:getEntityID()
        table.insert(sellGlyphGoods,buyGoods)
    end

    self:sendSellFunction(sellGoodsArr, sellEquipGoods, spriteID, nil, nil, sellWarehouse,sellPetGoods,sellGlyphGoods, sellPrimogemGoods)

end

function Manager:sellGoodsArrHandler(goodsDataArr, spriteID, callback, cancelCallback)
    --print("!!!!!!!!!!!Manager:sellGoodsArrHandler  spriteID=",spriteID)
    local isNoticeSell = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), true)  
    local isHaveGold = false
    local isGlyphTitle = 0
    for i=1,#goodsDataArr,1  do
        local goodsData = goodsDataArr[i]
        local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsData.goodsID)
        if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 and
           goodsType ~= PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            isHaveGold = true
        elseif goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4 and
            goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            isGlyphTitle = 1
        end

        -- if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
        --     isHaveGold = true
        -- end

        if(goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
            if goodsData.isEquiped then
                UI.ScrollBar:createByText(UI.TEXT_1213203)
                if cancelCallback then
                    cancelCallback()
                end
                return
            end
        end

        if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            if goodsData.isEquiped then
                UI.ScrollBar:createByText(UI.TEXT_227000)
                if cancelCallback then
                    cancelCallback()
                end
                return
            elseif goodsData:isRefined() then
                isGlyphTitle = 2
            end
        end

        -- if goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL and goodsData.materialType then
        --     if goodsData.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
        --         UI.ScrollBar:createByText(UI.TEXT_227509)
        --         if cancelCallback then
        --             cancelCallback()
        --         end
        --         return
        --     end
        -- end
    end
    --二次确认
    if isHaveGold and isNoticeSell then 
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212236, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self:_sellGoodsArrHandler(goodsDataArr, spriteID)
            if callback then
                callback()
            end
        end, function(isSelect)
            if cancelCallback then
                cancelCallback()
            end
        end, nil, nil, true)
    elseif isGlyphTitle > 0 then
        local titleStr = (isGlyphTitle == 1) and UI.TEXT_227011 or UI.TEXT_227012
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(titleStr, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeSellEquip..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self:_sellGoodsArrHandler(goodsDataArr, spriteID)
            if callback then
                callback()
            end
        end, function(isSelect)
            if cancelCallback then
                cancelCallback()
            end
        end, nil, nil, true)
    else
        self:_sellGoodsArrHandler(goodsDataArr, spriteID)
        if callback then
            callback()
        end
    end
end

function Manager:_sellGoodsArrHandler(goodsDataArr, spriteID)
    local sellGoodsArr = {}
    local sellEquipGoods = {}
    local sellWarehouse = {}
    local sellPetGoods = {}
    local sellGlyphGoods = {}
    local sellPrimogemGoods = {}
    sellPrimogemGoods.goodsID = {}

    for i=1,#goodsDataArr,1  do
        local goodsData = goodsDataArr[i]

        local buyGoods = {}
        buyGoods.num = goodsData:getNum()

        -- 这里应该优化，把同一样物品合并成一个
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
                table.insert(sellGoodsArr,buyGoods)
            end 
            table.insert(sellGoodsArr,buyGoods)
        elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
                goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
                -- goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE or 
                goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL and goodsData.materialType == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
                    -- local decomposeGoods = {}
                    -- decomposeGoods.goodsID = {}
                    local sellGoods = {}
                    sellGoods.templateID = goodsData:getGoodsID()
                    sellGoods.num = goodsData:getNum()
                    -- decomposeGoods.goodsID = sellGoods
                    table.insert(sellPrimogemGoods.goodsID,sellGoods)
                    -- sellPrimogemGoods = decomposeGoods
                    -- table.insert(sellPrimogemGoods,decomposeGoods)
                else
                    buyGoods.templateID = goodsData:getGoodsID()
                    buyGoods.isGolden = goodsData:getIsGolden()
                    buyGoods.entityID = 0
                    table.insert(sellGoodsArr,buyGoods)
                end
        elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
            buyGoods.entityID = goodsData:getEntityID()
            buyGoods.isGolden = goodsData:getIsGolden()
            buyGoods.templateID = 0
            table.insert(sellPetGoods,buyGoods)
        elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            local entityID = goodsData:getEntityID()
            table.insert(sellGlyphGoods, entityID)
        end
    end

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    self:sendSellFunction(sellGoodsArr, sellEquipGoods, spriteID, nil, nil, sellWarehouse,sellPetGoods, sellGlyphGoods, sellPrimogemGoods)
end

function Manager:bagBuyHandler(goodsData, num, spriteID)
    ----print(" Manager:bagBuyHandler num,spriteID,goodsNo=",num, spriteID, goodsData:getGoodsNo())
    local buyGoods = {}
    buyGoods.goodsNo = goodsData:getGoodsNo()
    buyGoods.goodsQuantity = num

    self:sendCaveShopFunction(buyGoods, spriteID)
end

function Manager:clearRepeateData(goodsArr)
    if(goodsArr) then 
        local haveEntityIDArr = {}
        for i=#goodsArr,1,-1 do 
            local data = goodsArr[i]
            if(data and data.entityID ~= 0) then 
                if(haveEntityIDArr[data.entityID]) then 
                    table.remove(goodsArr, i)
                else 
                    haveEntityIDArr[data.entityID] = data
                end
            end
        end
    end
end

function Manager:sendSellFunction(sellGoods, sellEquipGoods, spriteID, sellExpNormal, sellExpQuick, sellWarehouse,sellPetGoods, sellGlyphGoods, sellPrimogemGoods)
    -- repeated PublicDefine.GoodsID sellBagGoods = 1;       // 待售出的背包货物数据
    -- repeated PublicDefine.GoodsID sellEquipGoods = 2;       // 待售出的装备货物数据
    self:clearRepeateData(sellGoods)
    self:clearRepeateData(sellEquipGoods)
    self:clearRepeateData(sellExpNormal)
    self:clearRepeateData(sellExpQuick)
    self:clearRepeateData(sellWarehouse)
    self:clearRepeateData(sendSellFunction)
    
    local selllMes = {}
    selllMes.sellBagGoods = {}
    selllMes.sellEquipGoods = {}
    if(sellGoods) then
        selllMes.sellBagGoods = sellGoods
    end
    if(sellEquipGoods) then
        selllMes.sellEquipGoods = sellEquipGoods
    end
    if(sellExpNormal) then
        selllMes.sellExpNormal = sellExpNormal
    end
    if(sellExpQuick) then
        selllMes.sellExpQuick = sellExpQuick
    end
    if sellWarehouse then
        selllMes.sellWarehouse = sellWarehouse
    end
    if sellPetGoods then
        selllMes.sellPetGoods = sellPetGoods
    end
    -- 处理添加卖出或则丢弃数据处理
    --self:_addRepeateDataForSell(sellGoods)
    -- self:_addRepeateDataForSell(sellEquipGoods)
    -- printInfo("useFunction data is ：")
    printInfo(selllMes)
    if sellPrimogemGoods then
        if table.nums(sellPrimogemGoods) > 0 then
            -- 原石分解
            Net.NetNPCSystem:sendPrimoGemDecompose(sellPrimogemGoods)
        end
    end

    if sellGlyphGoods then
        if #sellGlyphGoods > 0 then
            -- 雕纹分解，服务器说要特殊走消息处理
            Net.NetNPCSystem:sendGlyphDecompose(sellGlyphGoods)
        else
            -- 处理添加卖出或则丢弃数据处理
            self:_addRepeateDataForSell(sellGoods)
            local data = proto:encode("NPCSystem.SellGoodsMessage", selllMes)
            Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.SELL_GOODS, spriteID)
        end
    else
        -- 处理添加卖出或则丢弃数据处理
        self:_addRepeateDataForSell(sellGoods)
        local data = proto:encode("NPCSystem.SellGoodsMessage", selllMes)
        Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.SELL_GOODS, spriteID)
    end
end

-- 本地添加重复点击操作的相关数据逻辑处理
function Manager:_addRepeateDataForSell(sellGoods)
    if(sellGoods == nil) then 
        return 
    end

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
            num = num + repeatData[key]
        end
        MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA, key, num)
    end 
end 

-- 
function Manager:sendCaveShopFunction(buyGoods, spriteID)
    local exchangeInCave = {}

    if(buyGoods) then
        exchangeInCave.buyGoods = buyGoods
    end

    local data = proto:encode("NPCSystem.ExchangeInCaveMessage", exchangeInCave)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.EXCHANGE_IN_CAVE, spriteID)
end

-- boss直达
function Manager:sendCaveBossPortalFunction(spriteID)
    Net.NetNPCSystem:useFunctionRequest("", FUNCTION_TYPE.FUNCTION_BOSS_PORTAL, spriteID)
end

function Manager:trigerLuckyWheelFunction(type, spriteID, dropListId)
   -- --print("----------------Manager:trigerLuckyWheelFunction(")
    local data = {}
    local message = {}
    message.type = type
    if dropListId ~= nil then
        message.listID = dropListId
    end
    dump(message, "trigerLuckyWheelFunction message")
    local data = proto:encode("NPCSystem.LuckyWheelMessage", message)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.LUCKYWHEEL_TURN, spriteID)
end


function Manager:trigerEquipSetFunction(srcEquipInstID, desEquipTemplateID, npcId, packageType)
    -- --print("----------------Manager:trigerLuckyWheelFunction(")
    local data = {}
    local message = {}
    message.srcEquipInstID = srcEquipInstID
    message.desEquipTemplateID = desEquipTemplateID
    message.srcEquipPacketType = packageType
    local data = proto:encode("NPCSystem.EquipSetChangeData", message)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.EQUIP_SET_CHANGE, npcId)
 end

 -- 易物台
 function Manager:trigerBarterFunction(materialId, equipId, npcId)
    local data = {}
    local message = {}
    message.materialId = materialId
    message.equipId = equipId
    local data = proto:encode("NPCSystem.BarterOperationData", message)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.FUNCTION_BARTER, npcId)
 end


function Manager:getLuckDropTableInfo(spriteID)
    local exchangeInCave = {}

    if(buyGoods) then
        exchangeInCave.buyGoods = buyGoods
    end

    local data = proto:encode("NPCSystem.ExchangeInCaveMessage", exchangeInCave)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.EXCHANGE_IN_CAVE, spriteID)
end

function Manager:refreshBlackShop(spriteID)
    ----print(" Manager:refreshBlackShop spriteID=", spriteID)
    
    Net.NetNPCSystem:reqBlackMarket()
end

function Manager:refreshRandomShop(spriteID)
    -- --print(" Manager:refreshRandomShop spriteID=", spriteID)
    
    Net.NetNPCSystem:reqRandomShopMarket()
end

function Manager:reqTurnTableInfo()
    ----print(" Manager:reqTurnTableInfo spriteID=")
    
    Net.NetNPCSystem:reqTurnTableInfo()
end

function Manager:sendRandomShopFunction(blackShopData, num, spriteID)
    local exchangeBlackShop = {}
    if(blackShopData) then
        exchangeBlackShop.itemID = blackShopData:getGoodsID()
        exchangeBlackShop.costType = blackShopData:getCostType()
        exchangeBlackShop.num = num
    else 
        printError("Manager:sendRandomShopFunction  params is invalid.")
        return 
    end

    local data = proto:encode("NPCSystem.RamdomshopBuyMessage", exchangeBlackShop)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.RANDOMSHOPUNLOCK, spriteID)
end

function Manager:sendBlackShopFunction(blackShopData, spriteID)
    local exchangeBlackShop = {}
    
    if(blackShopData) then
        exchangeBlackShop.buyPos = blackShopData:getPos()
        exchangeBlackShop.buyGoodsID = blackShopData:getGoodsID()     
    end

    local data = proto:encode("NPCSystem.ExchangeBlackMarketMessage", exchangeBlackShop)
    Net.NetNPCSystem:useFunctionRequest(data, FUNCTION_TYPE.BLACK_MARKET, spriteID)
end

-- 处理NPC功能
function Manager:handleNPCFunctionType(spriteID, functionType, isMiniMap)
    -- print("Manager:handleNPCFunctionType ", spriteID, functionType)

    local battleCmd = Command.BattleCommand:create()
    battleCmd:initForHandleFunctionType(spriteID, functionType, isMiniMap)
    SceneManager:getInstance():pushCommand(battleCmd)
end

function Manager:shortcutBarAdd(data)
    ----print("Manager:shortcutBarAdd ")
    -- dump(data)
    if(data and data.ID and data.ID < 30000000) then 
        local goodsData = GoodsDataManager:createLocalGoodsData(data.ID)
        if(goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM and goodsData:getIsAutoAddBar() == false) then 
            return 
        end
    end

    local mesData = {}
    -- 清理重复的
    local shortcutBar = GameDataManager:getInstance():getShortcutBarData()
    for k,shortcutData in ipairs(shortcutBar) do
        if shortcutData:getId() == data.ID and shortcutData:getIndex() ~= data.index then
            GoodsDataManager:updateShortcutBar(shortcutData:getIndex(),0)
            table.insert(mesData,{index=shortcutData:getIndex(),templateID=0})
        end
    end
    GoodsDataManager:updateShortcutBar(data.index,data.ID)
    table.insert(mesData,{index=data.index,templateID=data.ID})
    -- 这里根据
    if mesData then
        if not SceneManager:getInstance():isUseLocalShortcutBar() then 
            -- dump(mesData)
            Net.NetGoodsSystem:shortcutsChangeRequest(mesData)
        end
    end

    local shortcutsData = GameDataManager:getInstance():getShortcutBarData()
    if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
        local dataArr = {}
        for k,v in pairs(shortcutsData) do
            table.insert(dataArr, {index= v:getIndex(), templateID=v:getId()})
        end
        -- 保存到临时数据
        local saveGoodsData = GoodsDataManager:getSaveGoodsData()
        if(saveGoodsData) then 
            saveGoodsData:setShortcutBarData(SceneManager:getInstance():getLocalShortcutBarIndex(), dataArr)
        end
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE,shortcutsData)
end

function Manager:shortcutBarDelete(data)
    --print("Manager:shortcutBarDelete")
    -- dump(data)
    -- 格式：index  
    local mesData = {{index=data,templateID=0}}
    if(not SceneManager:getInstance():isUseLocalShortcutBar()) then 
        if mesData then
            Net.NetGoodsSystem:shortcutsChangeRequest(mesData)
        end
    end

    GoodsDataManager:updateShortcutBar(data,0)
    local shortcutsData = GameDataManager:getInstance():getShortcutBarData()
    Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE,shortcutsData)
end


function Manager:shortcutBarSwitch(data)
    --print("Manager:shortcutBarSwitch")
    -- dump(data)
    -- {oneIndex:1,twoIndex}
    local shortcutBar = GameDataManager:getInstance():getShortcutBarData()

    local oneTemplateID = shortcutBar[data.oneIndex]:getId()
    local twoTemplateID = shortcutBar[data.twoIndex]:getId()
    if(not SceneManager:getInstance():isUseLocalShortcutBar()) then 
        local mesData = {{index=data.oneIndex,templateID=twoTemplateID},{index=data.twoIndex,templateID=oneTemplateID}}
        if mesData then
            Net.NetGoodsSystem:shortcutsChangeRequest(mesData)
        end
    end

    GoodsDataManager:updateShortcutBar(data.oneIndex,twoTemplateID)
    GoodsDataManager:updateShortcutBar(data.twoIndex,oneTemplateID)
    local shortcutsData = GameDataManager:getInstance():getShortcutBarData()
    Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE,shortcutsData)
end


function Manager:enableMovingHandler(clearControlDirectAndStartMove)
    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():enableRoleMoving()
    end

    -- 处理是否清理摇杆的方向，并触发开始移动
    if(clearControlDirectAndStartMove) then 
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLEAR_DIRCTION_AND_START_MOVE_CONTROL_PAD)
        end, 1)
    end
end

function Manager:disableMovingHandler()
    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():disableRoleMoving()
        self:stopMoveHandler()
    end
end

-- 点击物品
function Manager:bagClickGoodsHandler(goodsData)
    -- 处理是否为新得标志
    if (goodsData and goodsData:getCategory() == Category.GOODS) then
        GoodsDataManager:setGoodsDataNew(goodsData,false)
    end
end

-- 使用道具
function Manager:useItem(goodsData, isQuickBar, coordX, coordY)
    -- print(string.format("[Game Manager] onUseItemHandler: goods id:%d.", goodsData:getGoodsID()))

    -- if GameDataManager:getInstance():checkInDisableSituation(goodsData:getDisableSituation()) then 
    --     return
    -- end

    if (not isQuickBar) and goodsData and (goodsData:getItemType() == PublicDefine.ITEM_TYPE.BackTown or goodsData:getItemType() == PublicDefine.ITEM_TYPE.UIShape) then
        local tips = UI.Tips:createTips(UI.TEXT_221201,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) --AvalonUtil.getIdentifier()
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            local master = GameDataManager:getInstance():getMaster()
            AudioUtil:playUseItemSound(goodsData:getGoodsID())
            Net.NetGoodsSystem:useItemRequest(
                goodsData:getGoodsID(),
                goodsData:getIsGolden(),
                master:getSpriteID()
            )
        end)
        return
    end

    if (not isQuickBar) and goodsData and (goodsData:getItemType() == PublicDefine.ITEM_TYPE.AddExp) then
        local tips = UI.Tips:createTips(string.format(UI.TEXT_221202, goodsData._localConfig.extendValue1),UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            local master = GameDataManager:getInstance():getMaster()
            AudioUtil:playUseItemSound(goodsData:getGoodsID())
            Net.NetGoodsSystem:useItemRequest(
                goodsData:getGoodsID(),
                goodsData:getIsGolden(),
                master:getSpriteID()
            )
        end)
        return
    end

    -- print( "goodsData:getItemType() ===== ",goodsData:getItemType() ,PublicDefine.ITEM_TYPE.StarCard)

    if (not isQuickBar) and goodsData and (goodsData:getItemType() == PublicDefine.ITEM_TYPE.StarCard) then
        local tips = UI.Tips:createTips(UI.TEXT_222622,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            local master = GameDataManager:getInstance():getMaster()
            AudioUtil:playUseItemSound(goodsData:getGoodsID())
            Net.NetGoodsSystem:useItemRequest(
                goodsData:getGoodsID(),
                goodsData:getIsGolden(),
                master:getSpriteID()
            )
        end)
        return
    end

    if (not isQuickBar) and goodsData and (goodsData:getItemType() == PublicDefine.ITEM_TYPE.TransCard) then
        local tips = UI.Tips:createTips(UI.TEXT_223300,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            local master = GameDataManager:getInstance():getMaster()
            AudioUtil:playUseItemSound(goodsData:getGoodsID())
            Net.NetGoodsSystem:useItemRequest(
                goodsData:getGoodsID(),
                goodsData:getIsGolden(),
                master:getSpriteID()
            )
        end)
        return
    end

    if(RoleBehaviorManager:useItemCheck() == false) then 
        return
    end

    if goodsData:getCategory() == Category.GOODS 
        and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        if(isQuickBar) then
            goodsData = GoodsDataManager:getUseGoodsDataForTemplateID(goodsData:getGoodsID(), goodsData:getGoodsType())
        end
        if goodsData then
            local itemType = goodsData:getItemType()
            -- 使用铁锹
            if (itemType == PublicDefine.ITEM_TYPE.IronPickaxe
                or itemType == PublicDefine.ITEM_TYPE.ItemFunTrap
                or itemType == PublicDefine.ITEM_TYPE.ItemFunMark) then
                Net.NetGoodsSystem:useItemRequest(
                    goodsData:getGoodsID(),
                    goodsData:getIsGolden(),
                    0,
                    coordX, coordY
                )

                -- 这里添加多余坐标触发保存
                local coord = {}
                coord.x = coordX
                coord.y = coordY
                coord.z = 0

                local battleCmd = Command.BattleCommand:create()
                battleCmd:initForAddTriggerData(nil,coord)
                SceneManager:getInstance():pushCommand(battleCmd)
            -- 处理使用鞭炮
            -- elseif (itemType == PublicDefine.ITEM_TYPE.Firecrackers) then
            elseif (goodsData:hasTargetType(PublicDefine.ESkillTargetType.ESkillTargetType_Monster)) then 
                local machine = MachineManager:getInstance():getMachine()
                local master = GameDataManager:getInstance():getMaster()
                if(machine and machine._model and master) then 
                    -- 判断是否在战斗中
                    local battleField = machine._model:getBattleFieldBySpriteID(master:getSpriteID(),nil)
                    if battleField then
                        local targetSpriteID = nil
                        local monster = battleField:getTargetMonster()
                        if monster then
                            targetSpriteID = monster:getSpriteID()
                        end

                        -- AudioUtil:playUseItemSound(goodsData:getGoodsID())
                        Net.NetGoodsSystem:useItemRequest(
                            goodsData:getGoodsID(),
                            goodsData:getIsGolden(),
                            targetSpriteID
                        )
                    end
                end 
            else
                local master = GameDataManager:getInstance():getMaster()
                -- 处理一些物品使用音效
                AudioUtil:playUseItemSound(goodsData:getGoodsID())
                Net.NetGoodsSystem:useItemRequest(
                    goodsData:getGoodsID(),
                    goodsData:getIsGolden(),
                    master:getSpriteID()
                )
            end
        end
    else
        assert(false," Manager:onUseItemHandler goodsData is not goods")
    end
end

-- 使用回城卷轴回城
function Manager:useTownScroll(goodsData)
    if(goodsData == nil) then
        goodsData = GameDataManager:getInstance():getEscapeScroll();
    end
    if(goodsData ~= nil) then
        if GameDataManager:getInstance():checkInDisableSituation(goodsData:getDisableSituation()) then 
            return
        end

        if(RoleBehaviorManager:useItemCheck() == false) then 
            return
        end

        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initForTypeAndData(CommandType.BATTLE_ROLE_BACK_TOWN, goodsData)
        SceneManager:getInstance():pushCommand(battleCMD)
    else
        return
    end
end


-- 使用回城卷轴回城失败弹出tips
function Manager:useTownScrollFailTips()
    local escapeScroll = GameDataManager:getInstance():getEscapeScroll();
    if(escapeScroll ~= nil) then
        self:useTownScroll(escapeScroll)
    else
        local tips = UI.Tips:createTips(UI.TEXT_110024,UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL) --AvalonUtil.getIdentifier()
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            --GameManager:giveUpBackTown()
        end)
    end
end

function Manager:useAssistSkillForNormal(skillData, targetSpriteID) 
    --print("Manager:useAssistSkillForNormal",targetSpriteID)
    if(skillData) then
        --print("Manager:useAssistSkillForNormal  skillid=",skillData:getSkillID())

        local params = {}
        params.targetSpriteID = targetSpriteID
        -- GameManager:disableMovingHandler()
        -- TODO 发送一个使用技能的指令
        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initUseAssistSkil(RoleDataManager:getMasterSpriteID(), skillData, params)
        SceneManager:getInstance():pushCommand(battleCMD)
    else 
        assert(false)
    end
end

-- 使用辅助技能
function Manager:useAssistSkill(skillData, coordX, coordY)
    if (skillData) then
        local skillID = skillData:getSkillID()
        --print(string.format("Manager useSkill: skill id:%d, coord:(%f,%f).", skillData:getId(), coordX, coordY))

        local params = {}
        params.targetSpriteID = 0
        params.coordX = coordX
        params.coordY = coordY
        -- GameManager:disableMovingHandler()
        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initUseAssistSkil(RoleDataManager:getMasterSpriteID(), skillData, params)
        SceneManager:getInstance():pushCommand(battleCMD)
    else
        assert(false)
    end
end

-- 对角色目标使用辅助技能
function Manager:useAssistSkillToRole(skillData, spriteID)
    local params = {}
    params.targetSpriteID = spriteID
    -- GameManager:disableMovingHandler()
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initUseAssistSkil(RoleDataManager:getMasterSpriteID(), skillData, params)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- 穿戴装备
function Manager:takeOnEquipment(goodsData, index)
    --print("[Game Manager] takeOnEquipment",goodsData:getEntityID(),goodsData:getGoodsID(),index)

    -- 穿戴装备
    Net.NetGoodsSystem:equipEquipmentRequest(goodsData:getEntityID(),index)
    -- goodsData:--print()
end

-- 卸下装备
function Manager:takeOffEquipment(goodsData)
    --print("[Game Manager] takeOffEquipment",goodsData:getEntityID(),goodsData:getGoodsID())
    
    -- 卸下装备
    Net.NetGoodsSystem:unEquipmentRequest(goodsData:getEntityID())
    -- goodsData:--print()
end

-- 放弃返回城镇
function Manager:giveUpBackTown()
    --print("[Game Manager] giveUpBackTown")
    -- 处理放弃存档回到城镇
    Net.NetRoleSystem:heroGiveUpSaveBackTown()
end

-- 请求英雄详情数据
function Manager:heroDetailRequest(pk, targetUserID, isShowImmediately)
    --print("[Game Manager] heroDetailRequest",pk, targetUserID)
    local userID = RoleDataManager:getMaster():getUserID()
    Net.NetRoleSystem:heroDetailRequest(pk, nil, userID, targetUserID, nil, nil, isShowImmediately)
end

-- 提交任务
function Manager:completeTastRequest(taskData)
    Net.NetTaskSystem:submitTaskRequest(taskData:getId())
end

-- boss 层跳过剧情
function Manager:bossSkipScenario(scenarioType)
    Net.NetRoleSystem:skipScenarioRequest(scenarioType)
end

-- 处理战斗帮助复活
function Manager:battleReviveHelp(targetSpriteID, diamondNum)
    local master = GameDataManager:getInstance():getMaster()
    if(master) then
        Net.NetRoleSystem:heroReviveRequest(master:getSpriteID(), targetSpriteID, diamondNum)
    end
end

-- 功能按钮对NPC消息的暂停
function Manager:funcBtnPauseNPCInformation(spriteID)
    ----print("Manager:funcBtnPauseNPCInformation ", spriteID)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initNPCFuncBtnInformationPause(spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- 功能按钮对NPC消息的恢复
function Manager:funcBtnResumeNPCInformation(spriteID)
    ----print("Manager:funcBtnResumeNPCInformation ", spriteID)

    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initNPCFuncBtnInformationResume(spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- 处理显示NPC气泡消息
function Manager:showNPCInfomation(spriteID, textStr)
    ----print("Manager:showNPCInfomation ", spriteID, textStr)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initNPCInfomationShow(spriteID, textStr)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- 隐藏NPC气泡消息
function Manager:hideNPCInfomation(spriteID)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initNPCInfomationHide(spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- 隐藏选择角色
function Manager:hideSelectHero(spriteID)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initSelectHeroHide(spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

-- npc 交互完成
function Manager:npcInteractionEnd(spriteID)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initNpcInteractionEnd(spriteID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

function Manager:triggerNppForTemplateID(templateID)
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initTriggerNpcForTemplateID(templateID)
    SceneManager:getInstance():pushCommand(battleCMD)
end

function Manager:triggerNppActivityCrying()
    local battleCMD = Command.BattleCommand:create(true)
    battleCMD:initTriggerNpcActivityCrying()
    SceneManager:getInstance():pushCommand(battleCMD)
end

function Manager:centerToMap()
    if not GameManager:getIsCenterByMaster() then
        return
    end
    if (MachineManager:getInstance():getMachine()) then
        local role = GameManager:getMasterRole()
        if(role) then
            if(role:getIsDead() == true ) then
                return 
            end

            local masterCoord = role:getCoord()
            local _map = MachineManager:getInstance():getMachine()._view._map
            local mapPosX, mapPosY = _map:coordinateToMapPosition(masterCoord.x, masterCoord.y)
            -- --print("Manager:centerToMap()",mapPosX, mapPosY, masterCoord.x, masterCoord.y)
            _map:stopAllActions()
            _map:screenCenterToCoord(masterCoord.x, masterCoord.y,true,0.2)
            -- _map:runAction(cc.ScaleTo:create(0.2,1))

            _map:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2,1),cc.CallFunc:create(function()
                _map:setScale(1)
            end)))
        end
    end
end

-- 判断是否在同一场战斗中
function Manager:judgeInSameBattleField(spriteID, targetSpriteID)
    ----print("Manager:judgeInSameBattleField",spriteID, targetSpriteID)
    if(SceneManager:getInstance():isInFightScene()) then
        local machine = MachineManager:getInstance():getMachine()
        if(machine) then
            return machine:judgeInSameBattleField(spriteID, targetSpriteID)
        end
    end

    return false
end

function Manager:showMapGrids(coordList)
    if (coordList) then
        local showMapGridsCommand = Command.RendererCommand:create()
        showMapGridsCommand:initShowMapGridCommand(coordList)
        SceneManager:getInstance():pushCommand(showMapGridsCommand)
    else
        assert(false)
    end
end

function Manager:hideMapGrids()
    local hideMapGridsCommand = Command.RendererCommand:create()
    hideMapGridsCommand:initHideMapGridCommand()
    SceneManager:getInstance():pushCommand(hideMapGridsCommand)
end

-- 测试跳转到某层楼
function Manager:testGoToLevel(level)
    ----print("[Game Manager] testGoToLevel level=",level)
    Net.NetRoleSystem:heroTestGoToLevel(level)
end

-- 发送添加游戏元素的消息
function Manager:addMapElement(elementType, pk, data)
    Net.NetGMSystem:addGameElementRequest(elementType, pk, data)
end

-- 选择穿戴切换
function Manager:requestSelectShortcutEquip(index)
    Net.NetGoodsSystem:requestSelectShortcutEquip(index)
end

--选择解锁关卡模式 和 难度
function Manager:requestSelectModeAndDiffcult(elementType, modeType, diffcultyType)
    ----print("--------------Manager:requestSelectModeAndDiffcult   modeType ="..modeType.."  and  diffcultyType = "..diffcultyType)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementUnlockCaveModeDiffcultyData", {
        caveMode = tonumber(modeType),
        caveDiffculty = tonumber(diffcultyType)
    })
    dump(data, "data")
    self:addMapElement(elementType, pk, data)
end

--英雄无敌
function Manager:requestHeroMaxDefense(elementType, isMax)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementHeroIsGodData", {
        pk = pk,
        isGod = isMax
    })
    self:addMapElement(elementType, pk, data)
end

--怪物无敌
function Manager:requestMonsterMaxDefense(elementType, isMax)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementMonsterIsGodData", {
        pk = pk,
        isGod = isMax
    })
    self:addMapElement(elementType, pk, data)
end

--宠物无敌
function Manager:requestPetMaxDefense(elementType, isGod)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementPetIsGodData", {
        pk = pk,
        isGod = isGod
    })
    self:addMapElement(elementType, pk, data)
end

--英雄无伤
function Manager:requestHeroIsNewBie(elementType, isGeneral)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ToggleHeroGeneralAttack", {
        pk = pk,
        isGeneral = isGeneral
    })
    self:addMapElement(elementType, pk, data)
end



--修改基本属性
function Manager:requestChangeAttribution(elementType, type, value)
    local pk = GameDataManager:getInstance():getMasterPK()
    ----print("--------------value = "..value)
    local data = proto:encode("GMSystem.ElementAlterHeroAttrData", {
        attrType = type,
        pk = pk,
        increaseValue = value
    })
    self:addMapElement(elementType, pk, data)
end


--解锁所有功能
function Manager:unLockAllFunction(elementType)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementFunctionUnlockData", {
        pk = pk
    })
    self:addMapElement(elementType, pk, data)
end

--设置梦境进度
function Manager:setDreamProgress(elementType, bossIdx, dreamLv)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.DreamSet", {
        curBossIndex = bossIdx,
        dreamLv = dreamLv
    })
    self:addMapElement(elementType, pk, data)
end


--快捷表情
function Manager:sendExpression(expressionId)
    ----print("--------------sendExpression expressionId = "..expressionId)
    Net.NetRoleSystem:sendExpression(expressionId)
end

function Manager:sendChatMessage(channelType, message, reciverPk, reciverUserId, reciverName, type)
    Net.NetChatSystem:sendMessage(channelType, message, reciverPk, reciverUserId, reciverName, type)
end

function Manager:recieveDungeonBatlleRewardRequest()
    Net.NetRoleSystem:recieveDungeonBatlleRewardRequest()
end

--好友
function Manager:getFriendList(pk, updateTimestamp)
    Net.NetFriendSystem:getFriendList(pk, updateTimestamp)
end

function Manager:deleteFriend(pk, tagerPk)
    Net.NetFriendSystem:deleteFriend(pk, tagerPk)
end

function Manager:inviteFriend(pk, tagerPk)
    Net.NetFriendSystem:inviteFriend(pk, tagerPk)
end

function Manager:handleFriendInvition(pk, tagerPk, isAgree)
    Net.NetFriendSystem:handleFriendInvition(pk, tagerPk, isAgree)
end
-- -- 请求验证账号
-- function Manager:reqAccountVerify(channelNo,params)
--     Net.NetLoginSystem:reqAccountVerify(channelNo,params)
-- end
--请求大秘境赛季奖励
function Manager:reqDungeonSeasonReward(npcId)
    Net.NetRoleSystem:reqDungeonSeasonReward(npcId)
end
--领取邮件
function Manager:sendAcceptAward(list)
    local pk = RoleDataManager:getMaster():getPK()
    Net.NetMailSystem:sendAcceptAward(list, pk)
end

function Manager:deleteSelectListMail(list)
    local pk = RoleDataManager:getMaster():getPK()
    Net.NetMailSystem:deleteSelectListMail(list, pk)
end

-- 处理显示隐藏宠物
function Manager:handleHideOrShowPet(data)
    local battleCmd = Command.BattleCommand:create()
    battleCmd:initSettingHidePet(not data)
    SceneManager:getInstance():pushCommand(battleCmd)
end

-- 处理显示隐藏魂器
function Manager:handleHideOrShowHorcrux(data)
    local battleCmd = Command.BattleCommand:create()
    battleCmd:initSettingHideHorcrux(not data)
    SceneManager:getInstance():pushCommand(battleCmd)
end

-- 处理显示隐藏同屏人数
function Manager:handleHideOrShowPersonCount(data)
    local battleCmd = Command.BattleCommand:create()
    battleCmd:initPersonCount()
    SceneManager:getInstance():pushCommand(battleCmd)
end