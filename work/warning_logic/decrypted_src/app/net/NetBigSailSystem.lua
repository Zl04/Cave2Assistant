--[[
大航海网络消息处理
]]--

Net = Net or {}
local NetBigSailSystem = {}
Net.NetBigSailSystem = NetBigSailSystem

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local GameInPortManager = require("app.game.GameInPortManager")

local DEBUG = false

local BigSailItemType = {
    BigSailItemType_debris = 1,
    BigSailItemType_supply = 2,
    BigSailItemType_PortOutput = 3
}

local BigSailStoreType = {
    BigSailStoreType_Common = 1,
    BigSailStoreType_Activity = 2
}

-- CS SO 请求进入玩家港口
function NetBigSailSystem:reqEnterBigSailScene(enterPK)
    print("reqEnterBigSailScene-->: ", type(enterPK))
    local messageData = {
        pk = enterPK
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_ENTER_PORT_SCENE, messageData)
end

-- CS 航行起航
function NetBigSailSystem:reqSetSail(data)
    
    local messageData = {
        boatId = data.boatId,
        islandId = data.islandId
    }
    print("reqSetSail-->: ", data)
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_SET_SAIL, messageData)
end

-- CS 领取航行背包物品请求
function NetBigSailSystem:reqTakeSailGoods()
    
    local messageData = {
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_TAKE_SAIL_GOODS, messageData)
end

-- CS 请求设置船员
function NetBigSailSystem:reqSetBoatPets(data)
    
    local messageData = {
        boatid = data.boatId,
        petInstId = data.petId
    }
    print("reqSetBoatPets--->: ",data )
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_SET_BOAT_PETS_MESSAGE, messageData)
end

-- CS 请求设置船员补给
function NetBigSailSystem:reqSetBoatSupply(data)
    
    local messageData = {
        supplyAmount = data.supplyAmount,                      
        boatid = data.boatId
    }
    print("reqSetBoatSupply--->: ", messageData)
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_SET_BOAT_SUPPLY_MESSAGE, messageData)
end

-- CS 请求购买补给
function NetBigSailSystem:reqBuySupply(data)
    
    local messageData = {
        num = data.num
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_BUY_SUPPLY_MESSAGE, messageData)
end

-- CS 请求购买商品
function NetBigSailSystem:reqBuyStore(data)
    
    local messageData = {
        id = data.id,
        num = data.num,
        storeType = data.storeType,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_BUY_SAIL_STORE_MESSAGE, messageData)
end

-- CS 任务领奖
function NetBigSailSystem:reqGetTaskReward(data)
    
    local messageData = {
        id = data.id
    }
    print("reqGetTaskReward--->:", messageData)
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_GET_TASK_REWARD_MESSAGE, messageData)
end

-- CS 请求航行加速
function NetBigSailSystem:reqSpeedUp(data)
    
    local messageData = {
        boat = data.boatId,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_SPEED_UP_MESSAGE, messageData)
end

-- CS 请求取消占领
function NetBigSailSystem:reqCancelSail(data)
    
    local messageData = {
        boatid = data.boatId,
        islandid = data.landId
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_CANCEL_SAIL_MESSAGE, messageData)
end

-- CO 请求岛屿信息
function NetBigSailSystem:reqIslandInfo(data)
    
    local messageData = {
        id = data.landId,
    }
    print("reqIslandInfo-->: ", data)
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_ISLAND_INFO, messageData)
end

-- CO 请求驱逐某船只
function NetBigSailSystem:reqExpulsionBoat(data)
    local messageData = {
        islandid = data.islandid,
        otherPk = data.otherPk,
        num = data.num,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_EXPULSION_BOAT_MESSAGE, messageData)
end

-- CO 请求领取岛屿奖励
function NetBigSailSystem:reqGetOccupyReward(data)
    local messageData = {
        mypk = data.mypk,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_GET_OCCUPY_REWARD_MESSAGE, messageData)
end

-- CO boss战斗
function NetBigSailSystem:reqBossBattle(data)
    local messageData = {
        islandid = data.islandid,
        boatid = data.boatid,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_BOSS_BATTLE_MESSAGE, messageData)
end

-- CO 设置敌对工会
function NetBigSailSystem:reqSetEnemyGuild(data)
    local messageData = {
        islandid = data.islandid,
        guildid = data.guildid,
        isCancel = data.isCancel,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_SET_ENEMY_GUILD_MESSAGE, messageData)
end

-- CO 显示占领岛屿工会信息 [随机]
function NetBigSailSystem:reqIslandAllGuilds(data)
    local messageData = {
        islandid = data.islandid,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_ISLAND_ALL_GUILDS_MESSAGE, messageData)
end

-- CS 请求事件数据
function NetBigSailSystem:reqEventData()
    
    local messageData = {
        type = 1,
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_EVENT_DATA_MESSAGE, messageData)
end

-- CO 请求事件数据
function NetBigSailSystem:reqGuildEventData()
    
    local messageData = {
        type = 2,
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_GUILD_EVENT_DATA_MESSAGE, messageData)
end

-- CO 请求所有岛屿基础信息
function NetBigSailSystem:reqAllIslandsBase()
    
    local messageData = {
    }
    
    local islandid = {}
    local baseData = mvc.bigSailPortModel:getBaseData()
    
    if not baseData then return end
    
    for k,v in pairs(baseData.useBoats) do
        if v.islandId > 0 and v.status == PublicDefine.BigSailBoatStatus.BigSailBoatingCaptured then
            table.insert(islandid, v.islandId)
        end
    end
    
    messageData.islandid = islandid
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_ALL_ISLANDS_BASE_MESSAGE, messageData)
end

-- CO 请求标记集中占领
function NetBigSailSystem:reqMarkOccupyIsland(data)
    
    local messageData = {
        islandid = data.islandid,
        isCancel = data.isCancel
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_MARK_OCCUPY_ISLAND_MESSAGE, messageData)
end

-- CO 请求船只详情
function NetBigSailSystem:reqBoatDetail(data)
    local messageData = {
        islandid = data.islandid,
        pk = data.pk
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_BOAT_DETAIL_MESSAGE, messageData)
end

-- CO 请求更改岛屿
function NetBigSailSystem:reqChangeIsland(data)
    local messageData = {
        fromIslandid = data.fromIslandid,
        toIslandid = data.toIslandid,
        boatid = data.boatid,
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_CHANGE_ISLAND_MESSAGE, messageData)
end

-- CS 请求更改岛屿(作用于正在航行的船只更换岛屿)
function NetBigSailSystem:reqChangeIslandRunning(data)
    local messageData = {
        fromIslandid = data.fromIslandid,
        toIslandid = data.toIslandid,
        boatid = data.boatid,
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_CHANGE_ISLAND_RUNNING_MESSAGE, messageData)
end

-- CS 请求刷新岛怪
function NetBigSailSystem:reqRefreshMonster(data)
    local messageData = {
    }
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_REFRESH_MONSTER_MESSAGE, messageData)
end

-- CS 请求驱逐岛怪
function NetBigSailSystem:reqExpulsionMonster(data)
    local messageData = {
        islandid = data.islandid, -- 岛屿id
        monsterid = data.monsterid, -- 驱逐的岛怪id
    }
    mvc.bigSailPortModel:setMonsterBattlePvpData(data.monsterid)
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_PORT_REQ_MONSTER_BATTLE_MESSAGE, messageData)
end

-- CS 竞猜基础信息
function NetBigSailSystem:reqBetBaseInfo(boatid)
    print("NetBigSailSystem:reqBetBaseInfo", boatid)
    if(boatid == nil) then
        boatid = 0
    end
    
    local messageData = {
        boatid = boatid,         -- 0表示所有船只信息
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_BASEINFO_MESSAGE, messageData)
end

-- CS 请求投注
function NetBigSailSystem:reqBet(data)
    print("NetBigSailSystem:reqBet", data)
    local messageData = {
        boatid = data.boatid,         -- 船ID
        betItemNum = data.betItemNum, -- 竞猜币
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_BET_MESSAGE, messageData)
end

-- 请求获取竞猜币
function NetBigSailSystem:reqBetGetItemNum(data)
    print("NetBigSailSystem:reqBetGetItemNum", data)
    local messageData = {
        id = data,
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_BET_GETITEMNUM_MESSAGE, messageData)
end

-- 请求查看往期结果
function NetBigSailSystem:reqBetLastResult()
    print("NetBigSailSystem:reqBetLastResult")
    local messageData = {
        
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_LASETBET_RESULT_MESSAGE, messageData)
end

-- 请求使用技能
function NetBigSailSystem:reqUseSkill(data)
    print("NetBigSailSystem:reqUseSkill", data)
    local boatInfo = mvc.betModel:getBetBoatInfo(data.boatid)
    if(boatInfo ~= nil and boatInfo.BetBoatSailInfo ~= nil and boatInfo.BetBoatSailInfo.finishSailMs > 0) then
        UI.ScrollBar:createByText(UI.TEXT_227643)
        return
    end

    local messageData = {
        skillid = data.skillid,
        boatid = data.boatid
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_USEBETSKILL_MESSAGE, messageData)
end

-- 请求使用技能
function NetBigSailSystem:reqUseItem(data)
    print("NetBigSailSystem:reqUseItem", data)
    local boatInfo = mvc.betModel:getBetBoatInfo(data.boatid)
    if(boatInfo ~= nil and boatInfo.BetBoatSailInfo ~= nil and boatInfo.BetBoatSailInfo.finishSailMs > 0) then
        UI.ScrollBar:createByText(UI.TEXT_227643)
        return
    end

    local messageData = {
        itemid = data.itemid,
        num = data.num,
        boatid = data.boatid
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_USERBETITEM_MESSAGE, messageData)
end

-- 请求船的事件
function NetBigSailSystem:reqBoatEvents(data)
    print("NetBigSailSystem:reqBoatEvents", data)
    local messageData = {
        boatid = data.boatid
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_BET_BOATEVENTS_MESSAGE, messageData)
end

-- 请求查看个人往期结果
function NetBigSailSystem:reqMyLastbet()
    print("NetBigSailSystem:reqMyLastbet")
    local messageData = {
        
    }
    
    Net.Helper:sendMessage(NetMessageType.BIGSAIL_BET_REQ_MY_LASETBET_RESULT_MESSAGE, messageData)
end

-- 大航海消息处理 (消息放在roleSystem 里面处理)
function NetBigSailSystem:onBigSailMessageHandler(no, data)
    print("Net.NetBigSailSystem:onBigSailMessageHandler :no, data:",no)
    if (no == NetMessageType.BIGSAIL_ENTER_PORT_SCENE_RESOULT.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
        end
        
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
    elseif (no == NetMessageType.BIGSAIL_SYNC_PORT_SOCIAL_DATA.NO) then
        --同步港口社交数据到客户端
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            
        end
        --Avalon.MessageCenter:notice(AvalonMessage.)
    elseif (no == NetMessageType.BIGSAIL_SYNC_PORT_BASE_DATA.NO) then
        print("BIGSAIL_SYNC_PORT_BASE_DATA-->: ", data)
        --同步港口个人基础数据到客户端
        --local boatinfos = data.data.boatinfos
        -- -- boatinfos :{
        -- optional uint32 boatId = 1;
        -- optional uint32 status = 2;
        -- optional BigSailData data = 3;
        -- optional uint32 startTime = 2;                          // 航行开始时间
        -- optional uint32 lastTime = 3;                           // 上次航行计算时间
        -- repeated uint64 pets = 4;                               // 船员（宠物实例ID)
        -- optional uint32 speed = 5;                              // 当前速度（放大100倍）
        -- optional uint32 supplyAmount = 6;                       // 补给存量（放大100倍）
        -- optional uint32 supplyConsumeSpeed = 7;                 // 补给消耗速度（放大100倍）
        -- optional uint32 distance = 8;                           // 已航行距离（放大100倍）
        -- optional uint32 supplyExhaustTime = 10;                 // 补给耗尽时间
        -- }
        --Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_BASE_DATA, data)
        mvc.bigSailPortModel:saveBaseData(data.data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_SET_SAIL.NO) then
        -- 起航
        print("BIGSAIL_PORT_RESP_SET_SAIL-->: ",data.result)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            local data = "sail"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS)
            -- 刷新岛屿上的船只信息
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        end
        if data.result == PublicDefine.ErrNo.ErrNo_BigsailBoatPowerNotEnough then
            print("data.result == PublicDefine.ErrNo.ErrNo_BigsailBoatPowerNotEnough")
            UI.ScrollBar:createByText(UI.TEXT_226906)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_TAKE_SAIL_GOODS.NO) then
        --领取航行背包物品返回
    elseif (no == NetMessageType.BIGSAIL_PORT_SYNC_SAIL_DATA.NO) then
        -- 航海数据同步
        -- dump(data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_SET_BOAT_PETS_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_SET_BOAT_PETS_MESSAGE--->: ",data.result)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BASE_BOAT_INFO, data)
            local data = "setPetSuccess"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
        end
        if data.result == PublicDefine.ErrNo.ErrNo_BigsailPetLevelNotEnough then
            UI.ScrollBar:createByText(UI.TEXT_226904)
        elseif data.result == PublicDefine.ErrNo.ErrNo_BigsailPetPowerNotEnough then
            UI.ScrollBar:createByText(UI.TEXT_226905)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_SET_BOAT_SUPPLY_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_SET_BOAT_SUPPLY_MESSAGE-222-->: ",data.result)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            local data = "add"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_BUY_SUPPLY_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_BUY_SUPPLY_MESSAGE-333-->: ",data.result)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            local data = "buy"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_BUY_SAIL_STORE_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_BUY_SAIL_STORE_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailPortModel:saveStoreInfo(data)
            local config = nil
            if BigSailStoreType.BigSailStoreType_Common == data.storeType then
                config = ConfigManager:getNavigationShopByID(data.info.cfgId)
            elseif BigSailStoreType.BigSailStoreType_Activity == data.storeType then
                config = ConfigManager:getNavigationShopLimitTimeByID(data.info.cfgId)
            end
            
            local itemData = {}
            local goodData = GoodsDataManager:createLocalGoodsData(config.goodsID)
            local num = data.num or 1
            if(goodData) then
                goodData:setIsNew(false)
                goodData:setNum(config.goodsNum * num)
                table.insert(itemData, goodData)
            end
            local titleStr = UI.TEXT_111030 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, titleStr, nil)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_GET_TASK_REWARD_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_GET_TASK_REWARD_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_TASK_SHOW, data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTIFY_TASK_MESSAGE.NO) then
        print("BIGSAIL_PORT_NOTIFY_TASK_MESSAGE--->: ",data)
        mvc.bigSailPortModel:saveTaskInfo(data.infos)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_SPEED_UP_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_SPEED_UP_MESSAGE--->: ",data)
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTIFY_BOAT_INFO_MESSAGE.NO) then
        print("BIGSAIL_PORT_NOTIFY_BOAT_INFO_MESSAGE--->: ",data)
        mvc.bigSailPortModel:saveBoatInfo(data.info)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_CANCEL_SAIL_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_CANCEL_SAIL_MESSAGE--->: ",data)
        -- 在取消占领的同时正在被驱逐
        if data.result == PublicDefine.ErrNo.ErrNo_InFighting then
            UI.ScrollBar:createByText(UI.TEXT_226181)
        end
        
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 刷新岛屿上的船只信息
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST,data)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_MAP_BOAT, data.islandid)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_ISLANG_INFO.NO) then
        print("BIGSAIL_PORT_RESP_ISLANG_INFO--->: ",data)
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTIFY_ISLAND_INFO.NO) then
        print("BIGSAIL_PORT_NOTIFY_ISLAND_INFO--->: ",data)
        mvc.bigSailIslandModel:saveIsLandBoatsInfo(data)
        -- 刷新岛屿上的船只信息
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_EXPULSION_BOAT_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_EXPULSION_BOAT_MESSAGE--->: ",data)
        if data.num > 1 then
            -- 代表需要展示驱逐结果界面
            mvc.bigSailIslandModel:setExpelInit(data)
        else
            mvc.bigSailIslandModel:setExpelSettleData(data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTIFY_EXPULSION_BOAT_RESULT_MESSAGE.NO) then
        print("BIGSAIL_PORT_NOTIFY_EXPULSION_BOAT_RESULT_MESSAGE--->: ",data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_GET_OCCUPY_REWARD_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_GET_OCCUPY_REWARD_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailIslandModel:clearGetOccupyReward()
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_BOSS_BATTLE_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_BOSS_BATTLE_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailPortModel:changeBossFoughtNum()
            mvc.closePanel("BigSailIsland","BigSailIslandFightSelect")
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_BATTLE_END_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_BATTLE_END_MESSAGE--->: ",data)
        if data.battleType == 2 then
            -- 代表进行多次驱逐功能
            mvc.bigSailIslandModel:setExpelEndNum(data.num)
            
            -- 两个服务器之间发送消息先后到无法控制，所有两边都检测是否为最后一条战报消息
            local AllFightNums = mvc.bigSailIslandModel:getExpelEndNum()
            if AllFightNums > 0 then
                -- 总共战斗场次
                local nowAddFightNums = #mvc.bigSailIslandModel:getExpelInfo()
                if nowAddFightNums == AllFightNums then
                    --UI.WaitingLayer:hideWaiting()
                    -- 当前所有场次的数据都已经加载完毕
                    mvc.openPanel("BigSailIsland","BigSailIslandRankResult")
                end
            end
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_SET_ENEMY_GUILD_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_SET_ENEMY_GUILD_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            if data.isCancel then
                UI.ScrollBar:createByText(UI.TEXT_226172)
            else
                UI.ScrollBar:createByText(UI.TEXT_226171)
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_ENEMY_RANK, data)
            -- 刷新岛屿上的船只信息
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        else
            -- 设置敌对状态失败，重新刷新
            --Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_ENEMY_RANK, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SET_ENEMY_FAIL)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_ISLAND_ALL_GUILDS_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_ISLAND_ALL_GUILDS_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_ISLAND_GUILDS_LIST, data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_NTF_EVENT_DATA_MESSAGE.NO) then
        mvc.bigSailPortModel:updateEventData(data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_ALL_ISLANDS_BASE_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_ALL_ISLANDS_BASE_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailIslandModel:setMapShowData(data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_MARK_OCCUPY_ISLAND_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_MARK_OCCUPY_ISLAND_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_MARK_ISLAND,data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_BIG_MAP)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_NTF_GUILD_EVENT_DATA_MESSAGE.NO) then
        mvc.bigSailPortModel:updateEventData(data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RSP_EVENT_DATA_MESSAGE.NO) then
        mvc.bigSailPortModel:setEventData(data)
    elseif (no == NetMessageType.BIGSAIL_PORT_RSP_GUILD_EVENT_DATA_MESSAGE.NO) then
        mvc.bigSailPortModel:setEventData(data)
        -- elseif (no == NetMessageType.BIGSAIL_PORT_RESP_GET_OCCUPY_REWARD_MESSAGE.NO) then
        --     print("BIGSAIL_PORT_RESP_GET_OCCUPY_REWARD_MESSAGE--->: ",data)
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTYFY_ITEM_UPDATE_MESSAGE.NO) then
        print("BIGSAIL_PORT_NOTYFY_ITEM_UPDATE_MESSAGE--->: ",data)
        mvc.bigSailPortModel:setMaterialData(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_MATERAIL_DATA)
        -- if BigSailItemType.BigSailItemType_supply == data.itemType then
        --     local data1 = "buy"
        --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data1)
        -- end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_BOAT_DETAIL_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_BOAT_DETAIL_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailIslandModel:saveIslandPetsInfo(data)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_CHANGE_ISLAND_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_CHANGE_ISLAND_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_MAP_BOAT, data.fromIslandid)
            local data = "sail"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS)
            -- 刷新岛屿上的船只信息
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        end
        
        -- 在取消占领的同时正在被驱逐
        if data.result == PublicDefine.ErrNo.ErrNo_SailTooOften then
            UI.ScrollBar:createByText(UI.TEXT_226184)
            -- 失败了也要关闭派遣界面
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_CHANGE_ISLAND_RUNNING_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_CHANGE_ISLAND_RUNNING_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_MAP_BOAT, data.fromIslandid)
            local data = "sail"
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS)
            -- 刷新岛屿上的船只信息
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        end
        
        -- 在取消占领的同时正在被驱逐
        if data.result == PublicDefine.ErrNo.ErrNo_SailTooOften then
            UI.ScrollBar:createByText(UI.TEXT_226184)
            -- 失败了也要关闭派遣界面
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_REFRESH_MONSTER_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_REFRESH_MONSTER_MESSAGE--->: ",data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 刷新成功先清空所有岛怪信息，然后会收到BIGSAIL_PORT_NOTIFY_MONSTER_INFO_MESSAGE
            -- 新的岛怪信息.
            mvc.bigSailPortModel:clearMonsterInfos()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_MONSTER_FRESH_SUCCESS)
        else
            UI.ScrollBar:createByText(UI.TEXT_226707)
        end
    elseif (no == NetMessageType.BIGSAIL_PORT_NOTIFY_MONSTER_INFO_MESSAGE.NO) then
        print("BIGSAIL_PORT_NOTIFY_MONSTER_INFO_MESSAGE--->: ",data)
        mvc.bigSailPortModel:updateMonsterInfos(data)
        --Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP)
    elseif (no == NetMessageType.BIGSAIL_PORT_RESP_MONSTER_BATTLE_MESSAGE.NO) then
        print("BIGSAIL_PORT_RESP_MONSTER_BATTLE_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.bigSailPortModel:setEndPvpIsMonster(true)
            mvc.bigSailPortModel:saveMonsterBattleData(data)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_BASEINFO_MESSAGE.NO) then
        -- 请求拉力赛基础信息
        print("BIGSAIL_BET_RESP_BASEINFO_MESSAGE--->: ", data)
        mvc.betModel:UpdateBetBoatInfo(data.infos)
        mvc.betModel:UpdateBetBoatSailInfo(data.sailInfos)
        mvc.betModel:UpdateBetPoolNum(data.betPoolNum)
        -- mvc.betModel:UpdateBaseInfo(data.info)
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_BET_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_BET_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            UI.ScrollBar:createByText(UI.TEXT_227615)

            mvc.betModel:UpdateBetBoatInfoOne(data.boatid, data.betItemNum)

            Net.NetBigSailSystem:reqBetBaseInfo(0)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_GETITEMNUM_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_GETITEMNUM_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            UI.ScrollBar:createByText(UI.TEXT_227632)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_LASETBET_RESULT_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_LASETBET_RESULT_MESSAGE--->: ", data)
        mvc.betModel:UpdateLastInfo(data.info)
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_USEBETSKILL_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_USEBETSKILL_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.betModel:UpdateUseSkillResp(data)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_USERBETITEM_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_USERBETITEM_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- UI.ScrollBar:createByText(UI.TEXT_227633)

            mvc.betModel:UpdateUseItemResp(data)
        else
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_BET_BOATEVENTS_MESSAGE.NO) then
        -- 请求船只事件
        print("BIGSAIL_BET_RESP_BET_BOATEVENTS_MESSAGE--->: ", data)
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            mvc.betModel:UpdateBoatEvents(data.events)
        end
    elseif (no == NetMessageType.BIGSAIL_BET_NOTICE_BOATEVENTS_MESSAGE.NO) then
        -- 通知船只事件
        print("BIGSAIL_BET_NOTICE_BOATEVENTS_MESSAGE--->: ", data)
        mvc.betModel:UpdateBoatEvents(data.events)
    elseif (no == NetMessageType.BIGSAIL_BET_NOTICE_BASEINFO_MESSAGE.NO) then
        -- 通知基础信息变化
        print("BIGSAIL_BET_NOTICE_BASEINFO_MESSAGE--->: ", data)
        mvc.betModel:UpdateBetBoatInfo(data.info)
        -- mvc.betModel:UpdateBaseInfo(data.info)
    elseif (no == NetMessageType.BIGSAIL_BET_NOTICE_PERSIONINFO_MESSAGE.NO) then
        -- 通知个人信息变化
        print("BIGSAIL_BET_NOTICE_PERSIONINFO_MESSAGE--->: ", data)
        mvc.betModel:UpdateSkillInfo(data.betSkillinfo)
        
        local baseData = mvc.bigSailPortModel:getBaseData()
        if(baseData ~= nil) then 
            if(baseData.curBetId ~= data.curBetId) then 
                mvc.betModel:clearOldData()
            end
            
            baseData.betUseSkillPoint = data.betUseSkillPoint
            baseData.curBetId = data.curBetId
            baseData.dailyRewardBetId = data.dailyRewardBetId

            mvc.send("BetPersionInfo_Refresh")
        end
    elseif (no == NetMessageType.BIGSAIL_BET_NOTICE_BET_SAILINFO_MESSAGE.NO) then
        -- print("BIGSAIL_BET_NOTICE_BET_SAILINFO_MESSAGE--->: ", data)
        mvc.betModel:UpdateBetBoatSailInfo(data.info)
    elseif (no == NetMessageType.BIGSAIL_BET_RESP_MY_LASETBET_RESULT_MESSAGE.NO) then
        print("BIGSAIL_BET_RESP_MY_LASETBET_RESULT_MESSAGE--->: ", data)
        mvc.betModel:UpdateMyLastInfo(data.info)

    elseif (no == NetMessageType.BIGSAIL_BET_NOTICE_SETTLE_RESULT_MESSAGE.NO) then 
        print("BIGSAIL_BET_NOTICE_SETTLE_RESULT_MESSAGE--->: ", data)
        mvc.betModel:UpdateSettlegResult(data.info)
        
        -- 重新请求基础数据
        Net.NetBigSailSystem:reqBetBaseInfo(0)
        Net.NetBigSailSystem:reqBetLastResult()
        Net.NetBigSailSystem:reqMyLastbet()
    end
end