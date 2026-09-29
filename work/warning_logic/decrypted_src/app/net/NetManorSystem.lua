--[[
    庄园网络消息处理
]]--

Net = Net or {}
local NetManorSystem = {}
Net.NetManorSystem = NetManorSystem

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local GameInManorManager = require("app.game.GameInManorManager")

local DEBUG = false

-- 请求(切换)进入庄园场景(CO OS）
function NetManorSystem:reqEnterManorScene(enterPK)

    local messageData = {
        ownerPk = enterPK,
    }
    Net.Helper:sendMessage(NetMessageType.MANOR_ENTER_MANOR_SCENE, messageData)
end

function NetManorSystem:reqFishingBegine(NPCSpriteID)

    local messageData = {
        NPCSpriteID = NPCSpriteID,
    }
    Net.Helper:sendMessage(NetMessageType.MANOR_ENTER_MANOR_FISH_REQ_STARTFISH, messageData)
end

function NetManorSystem:reqFishingResult(resultID,NPCSpriteID)

    local messageData = {
        resultID = resultID,
        NPCSpriteID = NPCSpriteID
    }
    Net.Helper:sendMessage(NetMessageType.MANOR_ENTER_MANOR_FISH_REQ_FISHRESULT, messageData)
end

function NetManorSystem:reqFishingShopBuy(goodsID, storeId)
    local messageData = {
        goodsID = goodsID,
        storeId = storeId,
    }
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_FISH_SHOP_BUY, messageData)
end

function NetManorSystem:reqSellGoodsForPeddler(saleID,saleCount)
    local messageData = {
        saleID = saleID,
        saleCount = saleCount
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_PEDLERY_REQ_SALE, messageData)
end

-- 船只替换
function NetManorSystem:reqChangeBoat(boatId)
    local messageData = {
        boatId = boatId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_CHANGE_BOAT, messageData)
end

-- 启航
function NetManorSystem:reqSetSail(sailId, petsIdList, supplyAmount)
    local messageData = {
        sailId = sailId,
        petInstId = petsIdList,
        supplyAmount = supplyAmount
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_SET_SAIL, messageData)
end

-- 领取航行背包物品请求
function NetManorSystem:reqTakeSailGoods()
    local messageData = {
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_TAKE_SAIL_GOODS, messageData)
end

-- 航行数据同步请求
function NetManorSystem:reqSyncSailData(lastTime)
    local messageData = {
        lastSailTime = lastTime
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_SYNC_SAIL_DATA, messageData)
end

-- 装备架展示请求
function NetManorSystem:reqIllusionShow(npcIndex,illusionId)
    local messageData = {
        npcIndex = npcIndex,
        illusionId = illusionId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_ILLUSION_SHOW_MESSAGE, messageData)
end

-- 请求激活（装备）幻化
function NetManorSystem:reqIllusionActivateEquip(illusionId,equipId)
    local messageData = {
        illusionId = illusionId,
        equipId = equipId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_ILLUSION_ACTIVATE_EQUIP_MESSAGE, messageData)
end

--星图培养请求
function NetManorSystem:reqStarAtlasCulture(cultureType,count)
--     enum StarAtlasCultureType
-- {
--     StarAtlasCultureType_Currency = 1;                      // 代币培养
--     StarAtlasCultureType_Item = 2;                          // 道具培养
-- }
    local messageData = {} 
    messageData.type = cultureType
    if cultureType == 2 then
        messageData.count = count
    end
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_STAR_ATLAS_CULTURE_MESSAGE, messageData)
end

--星图升级请求
function NetManorSystem:reqStarAtlasUpgrade()
    local messageData = {} 
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_STAR_ATLAS_UPGRADE_MESSAGE, messageData)
end

--星辰卡镶嵌请求
function NetManorSystem:reqStarAtlasEquipCard(slotId,cardId)
    local messageData = {} 
    messageData.slotId = slotId
    messageData.cardId = cardId
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_STAR_ATLAS_EQUIP_CARD_MESSAGE, messageData)
end

--星辰卡开始升级请求
function NetManorSystem:reqStarCardUpgrade(slotId,cardId)
    local messageData = {} 
    messageData.slotId = slotId
    messageData.cardId = cardId
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_STAR_CARD_START_UPGRADE_MESSAGE, messageData)
end

--星辰卡直接升级完成请求
function NetManorSystem:reqStarCardUpgradeDirectly(slotId,cardId)
    local messageData = {} 
    messageData.slotId = slotId
    messageData.cardId = cardId
    Net.Helper:sendMessage(NetMessageType.MANOR_TYPE_REQ_STAR_CARD_UPGRADE_DIRECTLY_MESSAGE, messageData)
end

-- 请求更改建筑NPC外形
function NetManorSystem:reqChangeBuildFacade(buildId,facadeId)
    local messageData = {} 
    messageData.buildId = buildId
    messageData.facadeId = facadeId
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_CHANGE_BUILD_FACADE, messageData)
end

-- 启航
function NetManorSystem:reqSyncSailLog(lastTime)
    local messageData = {
        lastTime = lastTime
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_SYNC_SAIL_LOG, messageData)
end

-- 请求消耗升级材料
function NetManorSystem:requestAddMaterial(buildId, data)
    local messageData = {
        buildId = buildId,
        material = data
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_PUT_IN_BUILD_MATERIAL, messageData)
end

-- 请求建筑升级
function NetManorSystem:requestBuildUpgrade(buildId)
    local messageData = {
        buildId = buildId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_UPGRADE_BUILD, messageData)
end

-- 庄园每日任务
function NetManorSystem:reqCommitMannorTarget(materialId)
    local messageData = {
        materialId = materialId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_COMMIT_MANOR_MATERIAL, messageData)
end

-- 提升庄园等级
function NetManorSystem:reqUpgradeMannorLevel()
    local messageData = {
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_UPGRADE_MANOR, messageData)
end

-- 道具提升庄园经验
function NetManorSystem:reqAddMannorEXP(itemCount)
    local messageData = {
        itemCount = itemCount
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_ADD_MANOR_EXP, messageData)
end

-- 餐桌请求进食
function NetManorSystem:requestUseRecipe(recipeId)
    local messageData = {
        recipeId = recipeId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_USE_RECIPE, messageData)
end

-- 请求更改庄园外形
function NetManorSystem:reqChangeMannorFacade(facadeId)
    local messageData = {} 
    messageData.facadeId = facadeId
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_CHANGE_MANNOR_FACADE, messageData)
end

-- 请求购买庄园外形
function NetManorSystem:reqBuyMannorFacade(facadeId)
    local messageData = {} 
    messageData.facadeId = facadeId
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_BUY_MANNOR_FACADE, messageData)
end

-- 请求购买建筑外形
function NetManorSystem:reqBuyBuildFacade(facadeId)
    local messageData = {} 
    messageData.facadeId = facadeId
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_BUY_BUILD_FACADE, messageData)
end

-- 请求购买船只外形
function NetManorSystem:reqBuyBoatFacade(facadeId)
    local messageData = {} 
    messageData.boatId = facadeId
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_BUY_BOAT_FACADE, messageData)
end

-- 终止启航
function NetManorSystem:reqStopSail(sailId)
    local messageData = {
        sailId = sailId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_STOP_SAIL, messageData)
end

-- 行商选择材料
function NetManorSystem:reqChoosePedleryMaterial(materialId)
    local messageData = {
        materialId = materialId
    } 
    Net.Helper:sendMessage(NetMessageType.MANOR_REQ_CHOOSE_PEDLERY_MATERIAL, messageData)
end

-- 庄园消息处理 (消息放在roleSystem 里面处理)
function NetManorSystem:onManorMessageHandler(no, data)
    printInfo("Net.NetManorSystem:onManorMessageHandler :no, data:",no)

--    -- 创建庄园成功返回
--     if (no == NetMessageType.MANOR_ENTER_MANOR_SCENE.NO) then

--     end

    if (no == NetMessageType.MANOR_ENTER_SCENE.NO) then
        ServerConfigUtil:saveAreaData()

        -- 上报游戏服通知进入场景
        NetHelper.setAnalysisEnable(false)
        local gameLoginManager = require("app.game.GameLoginManager")
        gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Server_IntoScene)
        gameLoginManager:getInstance():setAreaID(nil)

        GameManager:openCountDownSwitch()

        if(SceneManager:getInstance():isInDungeon()) then
            if(not SceneManager:getInstance():isInBlackHouse()) then 
                TaskDataManager:handleSaveMaxLevel() 
            end
        else
            TaskDataManager:handleSaveMaxLevel() 
        end 
        --城镇公告
        ImageDownLoadUtil:getTownNoticeFromWeb()

        -- 处理恢复本地的快捷栏数据
        if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
            local saveGoodsData = GoodsDataManager:getSaveGoodsData()
            if(saveGoodsData) then 
                local dataArr = saveGoodsData:getShortcutBarData(SceneManager:getInstance():getLocalShortcutBarIndex())
                if(dataArr) then 
                    for k,v in pairs(dataArr) do
                        GoodsDataManager:updateLocalShortcutBar(v.index,v.templateID)
                    end
                end
            end
        end
        local areaList = mvc.settingModel:getAreaListData()
        if(areaList and #areaList <=0) then
            mvc.send(mvc.events.Setting_Area_Server_ReqAreaList)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ENTER_SCENE, nil)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.MANOR_ENTER_MANOR_FISH_RES_STARTFISH.NO) then
        --开始钓鱼回执
        Avalon.MessageCenter:notice(AvalonMessage.MC_CLOSE_FISHING_BEGINE)
    elseif (no == NetMessageType.MANOR_ENTER_MANOR_FISH_RES_FISHRESULT.NO) then
        --钓鱼结果回执
        if data.resCode == PublicDefine.ErrNo.ErrNo_Ok then
            GameInManorManager:getInstance():updateFishingTime(data.fishingTime)

            local awardsList = {}
            for _, awards in ipairs(data.awards) do
                local awarObj = GoodsDataManager:createLocalGoodsData(awards.id)
                awarObj:setNum(awards.num)
                if awarObj:getNum() > 0 then
                    table.insert(awardsList, awarObj)
                end
            end
        
            if #awardsList > 0 then
                local scene = cc.Director:getInstance():getRunningScene()
                scene:runAction(cc.Sequence:create(cc.DelayTime:create(1),cc.CallFunc:create(function()
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
                end)))
            end

            if data.fishResult >= 2 then
                local masterData = RoleDataManager:getMaster()
                local heroSpriteId = masterData:getSpriteID()
                GameInManorManager:getInstance():showHarvestEffect(heroSpriteId, data.fishResult)
            end
        end
    elseif (no == NetMessageType.MANOR_ENTER_MANOR_SYNC_MANOR_PERSON_DATA_MESSAGE.NO) then
        -- 同步庄园个人数据到客户端
        GameInManorManager:getInstance():updateFishingTime(data.fishingTime)
        GameInManorManager:getInstance():updateBuildsData(data.builds)
        GameInManorManager:getInstance():updateMannorBaseData(data.baseData)
    elseif (no == NetMessageType.MANOR_TYPE_SYNC_BUILD_DATA_MESSAGE.NO) then
        --同步建筑数据（增量更新，全量数据在刚上线时 Type_SyncManorPersonDataMessage） 
        GameInManorManager:getInstance():updateBuildsData(data.builds)
    elseif (no == NetMessageType.MANOR_ENTER_MANOR_SYNC_MANOR_SOCIAL_DATA_MESSAGE.NO) then
        -- 同步庄园通用数据到客户端
        -- print("MANOR_ENTER_MANOR_SYNC_MANOR_SOCIAL_DATA_MESSAGE ======= ")
        -- dump(data)
        GameInManorManager:getInstance():setOwnerPk(data.ownerPk)
        GameInManorManager:getInstance():updateManorSceneCommonData(data.ownerPk, data.data)
        GameInManorManager:getInstance():updateCurEnteredBuildsData(data.data.commonData.levelData)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW)
    elseif (no == NetMessageType.MANOR_ENTER_MANOR_SCENE_RESOULT.NO) then
        -- 进入玩家庄园结果 Client
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print(" 进入庄园失败  : ", data.result)
        end
    elseif (no == NetMessageType.MANOR_RSP_FISH_SHOP_BUY.NO) then
        -- 渔具商店购买回复
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send("Fishing_Shop_Buy_Result_Handler", data)
        else
            local textStr = LanguageManager:getInstance():getLocalString(1111101)
            UI.ScrollBar:createByText(textStr)
        end
    elseif (no == NetMessageType.MANOR_TYPE_PEDLERY_UPDATE.NO) then
        -- OC 更新行商信息给客户端 
        -- print("行商 数据:    ")
        -- dump(data)
        GameInManorManager:getInstance():updatePurchaseItems(data)
    elseif (no == NetMessageType.MANOR_TYPE_PEDLERY_RES_SALE.NO) then
        if data.resCode == PublicDefine.ErrNo.ErrNo_Ok then
            local awardsList = {}
            
            local awarObj = GoodsDataManager:createLocalGoodsData(data.giveID)
            awarObj:setNum(data.giveCount)
            if awarObj:getNum() > 0 then
                table.insert(awardsList, awarObj)
            end
        
            if #awardsList > 0 then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
            end
        end
    elseif (no == NetMessageType.MANOR_RESP_CHANGE_BOAT.NO) then
        -- 船只替换响应
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send(mvc.events.Dock_Resp_Change_Boat, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW)
        end
    elseif (no == NetMessageType.MANOR_RESP_SET_SAIL.NO) then
        -- 启航响应
        -- dump(data, "MANOR_RESP_SET_SAIL")
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send(mvc.events.Dock_Resp_Set_Sail, data)
        elseif data.result == PublicDefine.ErrNo.ErrNo_ParaErr then
            UI.ScrollBar:createByText(UI.TEXT_221933)
        end
    elseif (no == NetMessageType.MANOR_RESP_TAKE_SAIL_GOODS.NO) then
        -- 领取航行背包物品返回
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send(mvc.events.Dock_Take_Sail_Goods)
        end
    elseif (no == NetMessageType.MANOR_SYNC_SAIL_DATA.NO) then
        -- 航海数据同步
        mvc.send(mvc.events.Dock_Sync_Sail_Data, data)

        
    elseif (no == NetMessageType.MANOR_TYPE_SYNC_ILLUSION_DATA_MESSAGE.NO) then
        -- 同步庄园幻化数据
        mvc.manorDressUpShelfModel:setIllusionData(data.data)

    elseif (no == NetMessageType.MANOR_TYPE_RESP_ILLUSION_ACTIVATE_EQUIP_MESSAGE.NO) then
        --激活（装备）幻化返回
        -- print("data =============== ")
        -- dump(data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send("Manor_DressUp_Operation_Refresh", 1)
        end
    elseif (no == NetMessageType.MANOR_TYPE_RESP_ILLUSION_SHOW_MESSAGE.NO) then
        --幻化展示请求返回
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send("Manor_DressUp_Operation_Refresh", 1)
            UI.ScrollBar:createByText(UI.TEXT_222808)
            -- GameInManorManager:getInstance():updateRackNPCEquip(data.npcIndex)
            GameInManorManager:getInstance():updateRackNPCEquip(1)
            GameInManorManager:getInstance():updateRackNPCEquip(2)
            GameInManorManager:getInstance():updateRackNPCEquip(3)
        end
    elseif (no == NetMessageType.MANOR_TYPE_SYNC_STAR_ATLAS_DATA_MESSAGE.NO) then
        -- 星图数据同步
        -- print("111111111111111111")
        -- dump(data)
        mvc.manorStarMapModel:updateStarMapData(data.data)

        if mvc.manorStarMapController then
            mvc.manorStarMapController:respRefreshCardUpgradeLayout()
            mvc.manorStarMapController:respRefreshAboutEquipCardLayout()
        end

    elseif (no == NetMessageType.MANOR_TYPE__NOTIFY_STAR_CARD_UNLOCKED_MESSAGE.NO) then
        -- SC 通知星辰卡解锁 (同步)
        mvc.manorStarMapModel:updateStarCardData(data.cardId)
    elseif (no == NetMessageType.MANOR_TYPE_RESP_STAR_ATLAS_CULTURE_MESSAGE.NO) then
        --星图培养返回
        -- print("22222222222222222222")
        -- dump(data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.manorStarMapController:respRefreshBuildStarMapView(data.gainedExp)
        end
    elseif (no == NetMessageType.MANOR_TYPE_RESP_STAR_ATLAS_UPGRADE_MESSAGE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.manorStarMapController:respRefreshBuildStarMapView()
            mvc.manorStarMapController:respRefreshCardLayout()
        end
    elseif (no == NetMessageType.MANOR_TYPE_RESP_STAR_ATLAS_EQUIP_CARD_MESSAGE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.manorStarMapController:respRefreshAboutEquipCardLayout(data.cardId)
        end
    elseif (no == NetMessageType.MANOR_TYPE_RESP_STAR_CARD_START_UPGRADE_MESSAGE.NO or 
            no == NetMessageType.MANOR_TYPE_RESP_STAR_CARD_UPGRADE_DIRECTLY_MESSAGE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.manorStarMapController:respRefreshCardUpgradeLayout()
        end
    elseif (no == NetMessageType.MANOR_RESP_CHANGE_BUILD_FACADE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.send(mvc.events.Manor_Appearance_Resp_Change_Build_Facade, data)
        end
    elseif (no == NetMessageType.MANOR_SYNC_SAIL_LOG.NO) then
        mvc.dockModel:setSailLogData(data)
    elseif (no == NetMessageType.MANOR_RSP_PUT_IN_BUILD_MATERIAL.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 投喂材料成功
            -- mvc.send(mvc.events.Update_Dock_Upgrade_Progress)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW)
        end
    elseif (no == NetMessageType.MANOR_RSP_UPGRADE_BUILD.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 升级建筑回执
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW)
        end
    elseif (no == NetMessageType.MANOR_RSP_USE_RECIPE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 餐桌进食返回
            mvc.send(mvc.events.Table_Refresh_View)
        end
    elseif (no == NetMessageType.MANOR_RESP_CHANGE_MANNOR_FACADE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 更改庄园外形
            mvc.send(mvc.events.Manor_Appearance_Resp_Change_Mannor_Facade, data)
        end
    elseif (no == NetMessageType.MANOR_RESP_BUY_MANNOR_FACADE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 购买庄园外形
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_GET_NEW_FACA_LAYER_VIEW)
        end 
    elseif (no == NetMessageType.MANOR_RESP_COMMIT_MANOR_MATERIAL.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- mvc.manorAppearanceModel:setFinishedTargetData(data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW)
        end 
        
    elseif (no == NetMessageType.MANOR_RESP_UPGRADE_MANOR.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- mvc.manorAppearanceModel:setMannorLevel(data.level)
            -- mvc.manorAppearanceModel:setMannorEXP(data.exp)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW)
        end 
    elseif (no == NetMessageType.MANOR_RESP_ADD_MANOR_EXP.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- mvc.manorAppearanceModel:setMannorEXP(data.exp)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW)
        end 
    elseif (no == NetMessageType.MANOR_NOTIFY_GET_MANNOR_FACADE.NO) then
        mvc.send(mvc.events.Manor_Appearance_Resp_Refresh_Mannor_Facade, data)
    elseif (no == NetMessageType.MANOR_RESP_BUY_BUILD_FACADE.NO) then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 购买建筑外形
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW)
        end 
    elseif (no == NetMessageType.MANOR_RESP_BUY_BOAT_FACADE.NO) then
        -- if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            
        -- end 
    elseif (no == NetMessageType.MANOR_NOTIFY_GOT_NEW_BOAT.NO) then
        mvc.dockModel:setUnlockFacade(data.boats)
        -- 购买船只
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW)
    elseif (no == NetMessageType.MANOR_RESP_STOP_SAIL.NO) then
    elseif (no == NetMessageType.MANOR_RESP_CHOOSE_PEDLERY_MATERIAL.NO) then
        print(" MANOR_RESP_CHOOSE_PEDLERY_MATERIAL ====  ",data)
        -- SC 行商选择材料
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            GameInManorManager:getInstance():updateRaderMaterialId(data.materialId)

            --材料航线更改成功  弹提示  并刷新界面
            mvc.manorPedleryMaterialController:reloadChoosePedleryMaterial(data.materialId)
        end
    elseif (no == NetMessageType.MANOR_SYNC_PEDLERY_MATERIAL_DATA.NO) then
        -- SC 行商同步材料信息
        print(" MANOR_SYNC_PEDLERY_MATERIAL_DATA ===   ",data)
        GameInManorManager:getInstance():updatePedleryMaterialData(data.data)
    end
end