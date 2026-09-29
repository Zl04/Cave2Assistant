--[[--
控制器PetTreasureController，view已经注入,可以通过mvc.petTreasureProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/04/26
-- desc	: 
------------------------------------------------------------------------------
local PetTreasureController = class("PetTreasureController", mvc.GameController)

-- mvc.events.PetTreasure_Send_Gather_Pets 处理函数
function PetTreasureController:noticePetTreasureSendGatherPets(notification)
    local pets = {}
    local curEmbattlePets = mvc.petTreasureModel:getcurEmbattlePetsData()
    for _, value in ipairs(curEmbattlePets) do
        table.insert(pets, value:getId())
    end

    local pk = RoleDataManager:getMaster():getPK()

    Net.NetPetSystem:petTreasureGather(pets, pk)
end

-- mvc.events.PetTreasure_Handle_Gather_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleGatherPets(notification, data)
    printInfo("PetTreasure_Handle_Gather_Pets")
    local pets = data.petId
    -- 记录回调打开的界面
    mvc.petTreasureModel:setFromLayer("PetTreasureGatherLayer")

    if self.PetTreasureGatherLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
        -- 关闭布阵界面
        self.PetTreasureGatherLayer.isEmbattling = false
        local packetLayer = self.PetTreasureGatherLayer.contentLayout:getChildByName("packetLayer")
        if packetLayer then
            packetLayer:removeFromParent(false)
        end

        local embattleLayer = self.PetTreasureGatherLayer.contentLayout:getChildByName("embattleLayer")
        if embattleLayer then
            embattleLayer:setUpdateSign(2)
        end
    end
end


-- mvc.events.PetTreasure_Send_Gather_Data 处理函数
function PetTreasureController:noticePetTreasureSendGatherData(notification, npcId)
    local npcId = npcId
    if npcId and type(npcId) == "number" then
        mvc.petTreasureModel:setNPCID(npcId)
    else
        npcId = mvc.petTreasureModel:getNPCID()
    end

    -- 请求刷新数据
    Net.NetNPCSystem:requestPetTreasureInfo(npcId)
end


-- mvc.events.PetTreasure_Handle_Gather_Data 处理函数
function PetTreasureController:noticePetTreasureHandleGatherData(notification, data)
    printInfo("PetTreasure_Handle_Gather_Data")
    mvc.petTreasureModel:handleGatherPetsData(data)
    mvc.send("PetTreasure_Update_Layer")
end


-- mvc.events.PetTreasure_Open_Main_view 处理函数
function PetTreasureController:noticePetTreasureOpenMainview(notification, npcId, layerName)
    -- 请求刷新数据
    mvc.send("PetTreasure_Send_Gather_Data", npcId)

    -- 重置一下碎片战斗状态
    mvc.petTreasureModel:setIsFragmentBattling(false)

    mvc.openPanel("PetTreasure", "PetTreasureMain")

    local pageIndex = 1
    if layerName == "PetTreasureGatherLayer" then
        pageIndex = 1
    elseif layerName == "PetTreasureChallengerLayer" then
        pageIndex = 2
    elseif layerName == "PetTreasureFragmentCompoundLayer" then
        pageIndex = 3
    elseif layerName == "PetTreasureAdventureLayer" then
        pageIndex = 4
    elseif layerName == "PetTreasureChallengeRecordsLayer" then
        pageIndex = 1
    end
    mvc.send("PetTreasure_Click_Tab", pageIndex)

    if layerName == "PetTreasureChallengeRecordsLayer" then
        mvc.send("PetTreasure_Switch_Challenge_Records_Layer")
    end
end


-- mvc.events.PetTreasure_Send_Callback_Gather_Pets 处理函数
function PetTreasureController:noticePetTreasureSendCallbackGatherPets(notification)
    local pk = RoleDataManager:getMaster():getPK()
    Net.NetPetSystem:petTreasureCallback(pk)
end


-- mvc.events.PetTreasure_Handle_Callback_Gather_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleCallbackGatherPets(notification, data)
    printInfo("PetTreasure_Handle_Callback_Gather_Pets")

    if data.result ~= "RecallPets_Suc" then
        print("PET_TREASURE_RESPONSE_CALLBACK_MESSAGE result is err == ".. data.result)

        if data.result == "RecallPets_BagSpaceNotEnough" then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
        end
        return
    end

    mvc.petTreasureModel:handleCallbackPetsData(data)
    mvc.petTreasureModel:clearcurEmbattlePetsData()
    mvc.petTreasureModel:clearWorkersData()

    if self.PetTreasureGatherLayer then
        local embattleLayer = self.PetTreasureGatherLayer.contentLayout:getChildByName("embattleLayer")
        if embattleLayer then
            embattleLayer.updateSign = 3
        end

        local awards = data.reward
        local awardsList = {}
        for _, value in ipairs(awards) do
            local awarObj = GoodsDataManager:createLocalGoodsData(value.ID)
            awarObj:setNum(value.num)
            if value.num > 0 then
                table.insert(awardsList, awarObj)
            end
        end
        if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
        end

        UI.WaitingLayer:hideWaiting()
    end
end

-- mvc.events.PetTreasure_Send_Fragment_Compound_Pets 处理函数
function PetTreasureController:noticePetTreasureSendFragmentCompoundPets(notification)
    Net.NetPetSystem:petTreasureCombineFragment()
end



-- mvc.events.PetTreasure_Handle_Fragment_Compound_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleFragmentCompoundPets(notification, data)
    printInfo("PetTreasure_Handle_Fragment_Compound_Pets")
    if data.result ~= "PetTreasureResult_Ok" then
        if data.result == "PetTreasureResult_Combine_HasClaimed" then
            mvc.petTreasureModel:setFragmentCompoundTime(data.nextTime)
            UI.ScrollBar:createByText(UI.TEXT_1314127)
        end

        if data.result == "PetTreasureResult_Combine_BagIsFull" then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
        end

        UI.WaitingLayer:hideWaiting()

        return
    end

    mvc.petTreasureModel:setFragmentCompoundTime(data.nextTime)

    if self.PetTreasureFragmentCompoundLayer and not tolua.isnull(self.PetTreasureFragmentCompoundLayer) then
        self.PetTreasureFragmentCompoundLayer:showCompoundEff()
    else
        UI.WaitingLayer:hideWaiting()
    end
end


-- mvc.events.PetTreasure_Click_Tab 处理函数
function PetTreasureController:noticePetTreasureClickTab(notification, clickIndex)
    -- 清空布阵
    mvc.petTreasureModel:clearcurEmbattlePetsData()

    if not self.petTreasureMainView then
        return
    end

    if clickIndex == 4 then
        local cfgData = ConfigManager:getFunctionUnlockCfgData(PublicDefine.UnlockFunctionType.UnlockFunctionType_PetAdventure)
        if cfgData then
            local heroData = RoleDataManager:getMaster()
            if heroData:getLevel() < cfgData.value[1] or not MasterDataManager:getCaptainPet() then--RoleDataManager:getCaptain() then
                UI.ScrollBar:createByText(UI.TEXT_221110)
                return
            end
        end
    end 

    self.petTreasureMainView.curTabIndex = clickIndex
    self.petTreasureMainView.btnData[self.petTreasureMainView.curTabIndex].select = true
    self.petTreasureMainView._tableView:updateCellAtIndex(self.petTreasureMainView.curTabIndex - 1)

    if self.petTreasureMainView.lastTabIndex > 0 then
        if self.petTreasureMainView.lastTabIndex == clickIndex then
            return
        end
        self.petTreasureMainView.btnData[self.petTreasureMainView.lastTabIndex].select = false
        self.petTreasureMainView._tableView:updateCellAtIndex(self.petTreasureMainView.lastTabIndex - 1)
    end

    local nowPageId = self.petTreasureMainView.curTabIndex
    local lastPageId = self.petTreasureMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "PetTreasureGatherLayer"
    elseif nowPageId == 2 then
        name = "PetTreasureChallengerLayer"
    elseif nowPageId == 3 then
        name = "PetTreasureFragmentCompoundLayer"
    elseif nowPageId == 4 then
        name = "PetTreasureAdventureLayer"
    end
    mvc.send("PetTreasure_Show_Layer", name, self.petTreasureMainView)

    if lastPageId == 1 and self.PetTreasureGatherLayer and not tolua.isnull(self.PetTreasureGatherLayer) then
        self.PetTreasureGatherLayer:removeFromParent(false)
        self.PetTreasureGatherLayer = nil
    elseif lastPageId == 2 and self.PetTreasureChallengerLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
        self.PetTreasureChallengerLayer:removeFromParent(false)
        self.PetTreasureChallengerLayer = nil
    elseif lastPageId == 3 and self.PetTreasureFragmentCompoundLayer and not tolua.isnull(self.PetTreasureFragmentCompoundLayer) then
        self.PetTreasureFragmentCompoundLayer:removeFromParent(false)
        self.PetTreasureFragmentCompoundLayer = nil
    elseif lastPageId == 4 and self.PetTreasureAdventureLayer and not tolua.isnull(self.PetTreasureAdventureLayer) then
        self.PetTreasureAdventureLayer:removeFromParent(false)
        self.PetTreasureAdventureLayer = nil
    end

    if self.PetTreasureChallengeRecordsLayer and not tolua.isnull(self.PetTreasureChallengeRecordsLayer) then
        self.PetTreasureChallengeRecordsLayer:removeFromParent(false)
        self.PetTreasureChallengeRecordsLayer = nil
    end

    self.petTreasureMainView.lastTabIndex = self.petTreasureMainView.curTabIndex
end

-- mvc.events.PetTreasure_Show_Layer 处理函数
function PetTreasureController:noticePetTreasureShowLayer(notification, name, parent)

    local layer
    if name == "PetTreasureGatherLayer" then
        local PetPacketLayer = require "app.modules.pettreasure.treasure.PetTreasureGatherLayer"
        self.PetTreasureGatherLayer = PetPacketLayer:create()
        layer = self.PetTreasureGatherLayer

    elseif name == "PetTreasureChallengerLayer" then
        mvc.send("PetTreasure_Send_Battle_Info_Pets")

        local PetTreasureChallengerLayer = require "app.modules.pettreasure.treasure.PetTreasureChallengerLayer"
        self.PetTreasureChallengerLayer = PetTreasureChallengerLayer:create()
        layer = self.PetTreasureChallengerLayer

    elseif name == "PetTreasureFragmentCompoundLayer" then
        local PetTreasureFragmentCompoundLayer = require "app.modules.pettreasure.treasure.PetTreasureFragmentCompoundLayer"
        self.PetTreasureFragmentCompoundLayer = PetTreasureFragmentCompoundLayer:create()
        layer = self.PetTreasureFragmentCompoundLayer

    elseif name == "PetTreasureChallengeRecordsLayer" then
        mvc.send("PetTreasure_Send_Battle_Record_Pets")

        local PetTreasureChallengeRecordsLayer = require "app.modules.pettreasure.treasure.PetTreasureChallengeRecordsLayer"
        self.PetTreasureChallengeRecordsLayer = PetTreasureChallengeRecordsLayer:create()
        layer = self.PetTreasureChallengeRecordsLayer

    elseif name == "RecyclingShopGoodsLayer" then
        local RecyclingShopGoodsLayer = require "app.modules.pettreasure.recyclingshop.RecyclingShopGoodsLayer"
        self.RecyclingShopGoodsLayer = RecyclingShopGoodsLayer:create()
        layer = self.RecyclingShopGoodsLayer

    elseif name == "PetTreasureAdventureLayer" then
        local PetTreasureAdventureLayer = require "app.modules.pettreasure.treasure.PetTreasureAdventureLayer"
        self.PetTreasureAdventureLayer = PetTreasureAdventureLayer:create()
        layer = self.PetTreasureAdventureLayer
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end

-- mvc.events.PetTreasure_Update_Layer 处理函数
function PetTreasureController:noticePetTreasureUpdateLayer(notification)
    if self.petTreasureMainView and not tolua.isnull(self.petTreasureMainView) then
        -- 刷新页签状态
        for index = 1, 3 do
            self.petTreasureMainView._tableView:updateCellAtIndex(index - 1)
        end
    else
        return
    end

    if self.PetTreasureGatherLayer and not tolua.isnull(self.PetTreasureGatherLayer) then
        self.PetTreasureGatherLayer:updateLayer()
    end

    if self.PetTreasureChallengerLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
        local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
        local curFragmentId = mvc.petTreasureModel:getCurCollectFragmentIndex()
        if curFragmentId == 0 or fragmentsBag[curFragmentId] == 1 then
            mvc.send("PetTreasure_Send_Battle_Info_Pets")
        else
            self.PetTreasureChallengerLayer:updateLayer()
        end
    end

    if self.PetTreasureFragmentCompoundLayer and not tolua.isnull(self.PetTreasureFragmentCompoundLayer) then
        self.PetTreasureFragmentCompoundLayer:updateLayer()
    end

    if self.PetTreasureChallengeRecordsLayer and not tolua.isnull(self.PetTreasureChallengeRecordsLayer) then
        self.PetTreasureChallengeRecordsLayer:updateLayer()
    end
end

-- mvc.events.PetTreasure_Self_Embattle_Item_Touch 处理函数
function PetTreasureController:noticePetTreasureSelfEmbattleItemTouch(notification, stype, data)
    local cell = data.cell
    local touchPosition = data.touchPosition
    local parent

    if data.eventName == "PetTreasureGatherLayer" then
        parent = self.PetTreasureGatherLayer

    elseif data.eventName == "PetTreasureChallengerLayer" then
        parent = self.PetTreasureChallengerLayer

    elseif data.eventName == "PetTreasureChallengeRecordsLayer" then
        parent = self.PetTreasureChallengeRecordsLayer

    elseif data.eventName == "PetTreasureAdventureLayer" then
        parent = self.PetTreasureAdventureLayer

    else
        printInfo("not parent")
        return
    end

    if stype == UIEvent.COMPONENT_TOUCH_MOVED then
        local cellData = cell:getData()
        local petData = cellData.petData

        local replicaIcon = parent:getChildByName("replicaIcon")
        if not replicaIcon then
            replicaIcon = UI.PetMainListCell:create()
            replicaIcon:init(nil, true, true, true, petData)
            replicaIcon:setName("replicaIcon")
            parent:addChild(replicaIcon, 2000)
        end

        local pos = parent:convertToNodeSpace(touchPosition)
        local size = replicaIcon:getContentSize()
        local x = pos.x - size.width/2
        local y = pos.y - size.height/2
        replicaIcon:setPosition(cc.p(x, y))

    elseif stype == UIEvent.COMPONENT_TOUCH_ENDED then
        local packetLayer = parent.contentLayout:getChildByName("packetLayer")
        if packetLayer then
            local petArr = mvc.petTreasureModel:getPacketPets(data.eventName)  
            packetLayer:updateByData(petArr)
        end

        local replicaIcon = parent:getChildByName("replicaIcon")
        if replicaIcon then
            parent:removeChildByName("replicaIcon")
        end

    end

end

-- mvc.events.PetTreasure_Packet_Item_Touch 处理函数
function PetTreasureController:noticePetTreasurePacketItemTouch(notification, stype, data)
    if stype == "GridDragEnded" then
        local petData = data.cell:getData()
        -- 出战标识关闭
        petData:setReadyFight(false)

        if data.eventName == "PetTreasureGatherLayer" then
            self.PetTreasureGatherLayer:slotDragEnd(petData, data.touchPosition)

        elseif data.eventName == "PetTreasureChallengerLayer" then
            self.PetTreasureChallengerLayer:slotDragEnd(petData, data.touchPosition)

        elseif data.eventName == "PetTreasureChallengeRecordsLayer" then
            self.PetTreasureChallengeRecordsLayer:slotDragEnd(petData, data.touchPosition)

        elseif data.eventName == "PetTreasureAdventureLayer" then
            self.PetTreasureAdventureLayer:slotDragEnd(petData, data.touchPosition)
        end
    end
end


-- mvc.events.PetTreasure_Handle_Fragments_update 处理函数
function PetTreasureController:noticePetTreasureHandleFragmentsupdate(notification)
    printInfo("PetTreasure_Handle_Fragments_update")
    -- 接收服务器推送的碎片刷新消息，在界面打开情况下进行数据刷新
    if self.petTreasureMainView and not tolua.isnull(self.petTreasureMainView) then
        -- 请求刷新数据
        mvc.send("PetTreasure_Send_Gather_Data")
    end
end



-- mvc.events.PetTreasure_Send_Battle_Info_Pets 处理函数
function PetTreasureController:noticePetTreasureSendBattleInfoPets(notification, isRefresh)
    local pk = RoleDataManager:getMaster():getPK()
    Net.NetPetSystem:petTreasureChallengeInfo(pk, isRefresh)
end

-- mvc.events.PetTreasure_Handle_Battle_Info_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleBattleInfoPets(notification, data)
    printInfo("PetTreasure_Handle_Battle_Info_Pets")
    if data.result ~= "PetTreasureResult_Ok" then
        UI.ScrollBar:createByText(UI.TEXT_1314140)
        return
    end

    if data and data.currentFragmentId then
        mvc.petTreasureModel.curCollectFragmentIndex = data.currentFragmentId
    end

    if data and data.challenger then
        mvc.petTreasureModel:setFragmentsBattleList(data.challenger)
    else
        mvc.petTreasureModel:setFragmentsBattleList({})
    end

    if self.PetTreasureChallengerLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
        self.PetTreasureChallengerLayer:updateLayer()
    end

    UI.WaitingLayer:hideWaiting()
end

-- mvc.events.PetTreasure_Send_Battle_Pets 处理函数
function PetTreasureController:noticePetTreasureSendBattlePets(notification, index)
    -- 战斗中，延迟展示碎片获取的特效
    mvc.petTreasureModel:setIsFragmentBattling(true)

    local curFragmentId = mvc.petTreasureModel:getCurCollectFragmentIndex()
    local index = index
    local petsId = {}
    local pets = mvc.petTreasureModel:getcurEmbattlePetsData()
    for i = 1, 3 do
        petsId[i] = pets[i]:getId()
    end

    -- 记录出战宠物
    mvc.petTreasureModel:setBattlePets(petsId)

    Net.NetPetSystem:petTreasureSendFragmentChallenge(curFragmentId, index, petsId)
end

-- mvc.events.PetTreasure_Handle_Battle_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleBattlePets(notification, data)
    printInfo("PetTreasure_Handle_Battle_Pets")
    if data.result ~= "PetTreasureResult_Ok" then
        mvc.petTreasureModel:setIsFragmentBattling(false)
        if data.result == "PetTreasureResult_Challenge_TargetHasNoFragment" then
            UI.ScrollBar:createByText(UI.TEXT_1314126)
        end

        if self.PetTreasureChallengerLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
            self.PetTreasureChallengerLayer:backFromEmbattle()
            -- 拉取新数据进行刷新
            mvc.send("PetTreasure_Send_Battle_Info_Pets")
            UI.WaitingLayer:hideWaiting()
        end

        return
    end

    mvc.petTreasureModel:setFromLayer("PetTreasureChallengerLayer")

    if self.petTreasureMainView and not tolua.isnull(self.petTreasureMainView) then
        mvc.closePanel("PetTreasure", "PetTreasureMain")
    end

    UI.WaitingLayer:hideWaiting()
end

-- mvc.events.PetTreasure_Switch_Challenge_Records_Layer 处理函数
function PetTreasureController:noticePetTreasureSwitchChallengeRecordsLayer(notification)
    if self.PetTreasureChallengeRecordsLayer and not tolua.isnull(self.PetTreasureChallengeRecordsLayer) then
        self.PetTreasureChallengeRecordsLayer:removeFromParent(false)
        self.PetTreasureChallengeRecordsLayer = nil
    else
        mvc.send("PetTreasure_Show_Layer", "PetTreasureChallengeRecordsLayer", self.petTreasureMainView)
    end
end



-- mvc.events.PetTreasure_Send_Battle_Record_Pets 处理函数
function PetTreasureController:noticePetTreasureSendBattleRecordPets(notification)
    local version = mvc.petTreasureModel:getBattleRecordVersion()
    Net.NetPetSystem:petTreasureChallengeRecords(version)
end


-- mvc.events.PetTreasure_Handle_Battle_Record_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleBattleRecordPets(notification, data)
    printInfo("PetTreasure_Handle_Battle_Record_Pets")
    if data.logs then
        mvc.petTreasureModel:setBattleRecord(data.logs)
    end
    mvc.petTreasureModel:setBattleRecordVersion(data.version)

    if self.PetTreasureChallengeRecordsLayer and not tolua.isnull(self.PetTreasureChallengeRecordsLayer) then
        self.PetTreasureChallengeRecordsLayer:updateLayer()
    end
end



-- mvc.events.PetTreasure_Send_Battle_Revenge_Pets 处理函数
function PetTreasureController:noticePetTreasureSendBattleRevengePets(notification, index)
    mvc.petTreasureModel:setIsFragmentBattling(true)
    local index = index
    local petsId = {}
    local pets = mvc.petTreasureModel:getcurEmbattlePetsData()
    for i = 1, 3 do
        petsId[i] = pets[i]:getId()
    end

    -- 记录出战宠物
    mvc.petTreasureModel:setBattlePets(petsId)

    Net.NetPetSystem:petTreasureChallengeRevenge(index, petsId)
end



-- mvc.events.PetTreasure_Handle_Battle_Revenge_Pets 处理函数
function PetTreasureController:noticePetTreasureHandleBattleRevengePets(notification, data)
    printInfo("PetTreasure_Handle_Battle_Revenge_Pets")
    if data.result ~= "PetTreasureResult_Ok" then
        printInfo(data)
        mvc.petTreasureModel:setIsFragmentBattling(false)
        if data.result == "PetTreasureResult_Revenge_HaveRevenged" then
            UI.ScrollBar:createByText(UI.TEXT_1314135)
        end

        if self.PetTreasureChallengeRecordsLayer and not tolua.isnull(self.PetTreasureChallengeRecordsLayer) then
            self.PetTreasureChallengeRecordsLayer:backFromEmbattle()
            mvc.send("PetTreasure_Send_Battle_Record_Pets")
            UI.WaitingLayer:hideWaiting()
        end

        return
    end

    mvc.petTreasureModel:setFromLayer("PetTreasureChallengeRecordsLayer")

    if self.petTreasureMainView and not tolua.isnull(self.petTreasureMainView) then
        mvc.closePanel("PetTreasure", "PetTreasureMain")
    end

    UI.WaitingLayer:hideWaiting()
end


-- mvc.events.PetTreasure_Handle_Open_origin_Layer 处理函数
function PetTreasureController:noticePetTreasureHandleOpenoriginLayer(notification)
    printInfo("PetTreasure_Handle_Open_origin_Layer")
    local fromLayer = mvc.petTreasureModel:getFromLayer()
    if fromLayer ~= nil and fromLayer ~= "" then
        printWarn("fromLayer ==== " .. fromLayer)
        mvc.send("PetTreasure_Open_Main_view", nil, fromLayer)
    end
    mvc.petTreasureModel:setFromLayer(nil)
end




-- mvc.events.PetTreasure_Open_RecyclingShop_view 处理函数
function PetTreasureController:noticePetTreasureOpenRecyclingShopview(notification, npcId, layerName)
    -- 请求刷新数据
    -- mvc.send("PetTreasure_Send_Gather_Data", npcId)
    local pet = MasterDataManager:getCaptainPet()
    if not pet then
       UI.ScrollBar:createByText(UI.TEXT_1325004 )
       return
    end
    mvc.openPanel("PetTreasure", "PetRecyclingShop")

    if self.petRecyclingShopView then
        self.petRecyclingShopView.innerContentLayout:removeAllChildren()
        mvc.send("PetTreasure_Show_Layer", layerName, self.petRecyclingShopView)
    end

    -- 目前仅一个物资兑换不涉及页签，暂时屏蔽
    -- local pageIndex = 1
    -- if layerName == "RecyclingShopGoodsLayer" then
    --     pageIndex = 1
    -- end
    -- mvc.send("PetTreasure_RecyclingShop_Click_Tab", pageIndex)

end



-- mvc.events.PetTreasure_RecyclingShop_Click_Tab 处理函数
function PetTreasureController:noticePetTreasureRecyclingShopClickTab(notification, clickIndex)
    if not self.petRecyclingShopView then
        return
    end

    self.petRecyclingShopView.curTabIndex = clickIndex
    self.petRecyclingShopView.btnData[self.petRecyclingShopView.curTabIndex].select = true
    self.petRecyclingShopView._tableView:updateCellAtIndex(self.petRecyclingShopView.curTabIndex - 1)

    if self.petRecyclingShopView.lastTabIndex > 0 then
        self.petRecyclingShopView.btnData[self.petRecyclingShopView.lastTabIndex].select = false
        self.petRecyclingShopView._tableView:updateCellAtIndex(self.petRecyclingShopView.lastTabIndex - 1)
    end

    local nowPageId = self.petRecyclingShopView.curTabIndex
    local lastPageId = self.petRecyclingShopView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "RecyclingShopGoodsLayer"
    end
    mvc.send("PetTreasure_Show_Layer", name, self.petRecyclingShopView)

    if lastPageId == 1 and self.RecyclingShopGoodsLayer and not tolua.isnull(self.RecyclingShopGoodsLayer) then
        self.RecyclingShopGoodsLayer:removeFromParent(false)
        self.RecyclingShopGoodsLayer = nil
    end

    self.petRecyclingShopView.lastTabIndex = self.petRecyclingShopView.curTabIndex
end



-- mvc.events.PetTreasure_RecyclingShop_Send_GoodsRecycle 处理函数
function PetTreasureController:noticePetTreasureRecyclingShopSendGoodsRecycle(notification, storeType, goodsIndex)
    Net.NetRoleSystem:sendStoreBuyGoodsMessage(storeType, goodsIndex)
end



-- mvc.events.PetTreasure_RecyclingShop_Handle_GoodsRecycle 处理函数
function PetTreasureController:noticePetTreasureRecyclingShopHandleGoodsRecycle(notification, data)
    printInfo("PetTreasure_RecyclingShop_Handle_GoodsRecycle")

    if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
        print("ROLE_REQ_STORE_BUY_GOODS result is err == ".. data.result)

        UI.WaitingLayer:hideWaiting()
        return
    end

    if data.storeType == 2 then
        return
    end

    if self.RecyclingShopGoodsLayer then

        local awards = data.awards
        local awardsList = {}
        for _, value in ipairs(awards) do
            local awarObj = GoodsDataManager:createLocalGoodsData(value.id)
            awarObj:setNum(value.num)
            if value.num > 0 then
                table.insert(awardsList, awarObj)
            end
        end
        if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
        end

        if self.petRecyclingShopView then
            self.petRecyclingShopView:updateDustNum()
        end
        self.RecyclingShopGoodsLayer:updateLayer()

        UI.WaitingLayer:hideWaiting()
    end
end



-- mvc.events.PetAdventure_Challenge 处理函数
function PetTreasureController:noticePetAdventureChallenge(notification)
    local selectLevel = self.PetTreasureAdventureLayer:getSelectedLevel()
    local pets = mvc.petTreasureModel:getPetAdvEmbattlePets()
    local petId = {}
    for k, v in pairs(pets) do
        if v.getId then
            petId[k] = v:getId()
        end
    end
    Net.NetPetSystem:petAdventureChallenge(selectLevel, petId)
end



-- mvc.events.PetAdventure_Handle_Challenge_Callback 处理函数
function PetTreasureController:noticePetAdventureHandleChallengeCallback(notification, data)
    printInfo("PetAdventure_Handle_Challenge_Callback")
    -- local pets = data.petId
    -- 记录回调打开的界面
    mvc.petTreasureModel:setFromLayer("PetTreasureAdventureLayer")

    if self.PetTreasureAdventureLayer and not tolua.isnull(self.PetTreasureChallengerLayer) then
        -- 关闭布阵界面
        self.PetTreasureAdventureLayer.isEmbattling = false
        local packetLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("packetLayer")
        if packetLayer then
            packetLayer:removeFromParent(false)
        end

        local embattleLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("embattleLayer")
        if embattleLayer then
            embattleLayer:setUpdateSign(2)
        end
    end

end



-- mvc.events.PetAdventure_Explore 处理函数
function PetTreasureController:noticePetAdventureExplore(notification)
    local selectLevel = self.PetTreasureAdventureLayer:getSelectedLevel()
    local pets = mvc.petTreasureModel:getPetAdvEmbattlePets()
    local petId = {}
    for k, v in pairs(pets) do
        if v.getId then
            petId[k] = v:getId()
        end
    end
    Net.NetPetSystem:petAdventureExplor(selectLevel, petId)
end



-- mvc.events.PetAdventure_Handle_Explore_Callback 处理函数
function PetTreasureController:noticePetAdventureHandleExploreCallback(notification, data)
    -- local petAdvData =  mvc.petTreasureModel:getPetAdvData()
    -- dump(petAdvData,"petAdvData")
    -- mvc.petTreasureModel:setExploreLevel(data.level)
    -- mvc.petTreasureModel:setExploringPets(data.petsId)
    self.PetTreasureAdventureLayer:updateExploringEff()
    self.PetTreasureAdventureLayer:updateBtn()
    local packetLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:removeFromParent(false)
    end
    local embattleLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("embattleLayer")
    if embattleLayer then
        embattleLayer:setCanDragItem(false)
    end
    
    local leftContentLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("leftContentLayer")
    leftContentLayer:refreshExpeditionStatus()
end



-- mvc.events.PetAdventure_Explore_Stop 处理函数
function PetTreasureController:noticePetAdventureExploreStop(notification)
    Net.NetPetSystem:petAdventureStopExplor()
end



-- mvc.events.PetAdventure_Handle_Explore_Stop_Callback 处理函数
function PetTreasureController:noticePetAdventureHandleExploreStopCallback(notification)
    self.PetTreasureAdventureLayer:updateExploringEff()
    self.PetTreasureAdventureLayer:updateBtn()
    local embattleLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("embattleLayer")
    if embattleLayer then
        embattleLayer:setCanDragItem(true)
    end
    UI.ScrollBar:createByText(UI.TEXT_1212026)
end



-- mvc.events.PetAdventure_Handle_Level_Selected 处理函数
function PetTreasureController:noticePetAdventureHandleLevelSelected(notification, level)
    self.PetTreasureAdventureLayer:setCurLevel(level)
    local reqGaurdData = {}
    -- 获取本地缓存守卫数据
    reqGaurdData = mvc.petTreasureModel:getPetAdvGuardCacheById(level)
    if reqGaurdData and next(reqGaurdData) then
        self.PetTreasureAdventureLayer:updateGuardinfo(reqGaurdData)
    else
        local gaurdData = {}
        --缓存无守卫数据则向服务器请求
        local gaurdConf = mvc.petTreasureModel:getAdvGuardsDataById(level)
        local gaurdIds = string.split(gaurdConf.guardPetID, ";")
        local gaurdlvs = string.split(gaurdConf.guardPetLv, ";")
        if gaurdConf then
            for k, v in pairs(gaurdIds) do
                local data = {}
                data.robotId = tonumber(v)
                data.level = tonumber(gaurdlvs[k])
                table.insert(gaurdData, data)
            end
        end
        Net.NetPetSystem:petAdventureReqGuardData(gaurdData, tonumber(level))
    end
    
end



-- mvc.events.PetAdventure_Handle_Level_Guard_Data_REQ_Callback 处理函数
function PetTreasureController:noticePetAdventureHandleLevelGuardDataREQCallback(notification, data)
    mvc.petTreasureModel:setPetAdvGuardCache(data)
    mvc.send("PetAdventure_Handle_Updata_Embattle_Layer", data.extra)
end



-- mvc.events.PetAdventure_Handle_Updata_Embattle_Layer 处理函数
function PetTreasureController:noticePetAdventureHandleUpdataEmbattleLayer(notification, level)
    print("PetAdventure_Handle_Updata_Embattle_Layer")
    local guard = mvc.petTreasureModel:getPetAdvGuardCacheById(level)
    if guard then
        self.PetTreasureAdventureLayer:updateGuardinfo(guard)
    end
end



-- mvc.events.PetAdventure_Update_Explor_Layer 处理函数
function PetTreasureController:noticePetAdventureUpdateExplorLayer(notification)
    if self.PetTreasureAdventureLayer and self.PetTreasureAdventureLayer.contentLayout then
        local leftContentLayer = self.PetTreasureAdventureLayer.contentLayout:getChildByName("leftContentLayer")
        if leftContentLayer then
            -- leftContentLayer:updateLevel()
            leftContentLayer:updateLayer()
        end
    end
    
    
end



-- mvc.events.PetAdventure_REQ_Sync_PetAdv_Data 处理函数
function PetTreasureController:noticePetAdventureREQSyncPetAdvData(notification)
    local lastChangeTime = mvc.petTreasureModel:getLastChangeTime()
    Net.NetPetSystem:petAdventureReqPetAdvData(lastChangeTime)
end



-- mvc.events.PetAdventure_REQ_Explore_Rewards 处理函数
function PetTreasureController:noticePetAdventureREQExploreRewards(notification)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    local data = notification.params[1]

    Net.NetNPCSystem:reqExpeditionReward(data.packetType, data.goodsArr)

end



-- mvc.events.PetAdventure_Handle_Explore_Rewards_Callback 处理函数
function PetTreasureController:noticePetAdventureHandleExploreRewardsCallback(notification)
    local data = notification.params[1]
    UI.WaitingLayer:hideWaiting()
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.RspExpedition_result", data.result))

    if(data.result == "RspExpedition_OK") then
        if(mvc.expeditionModel:getBagHaveGoodsForPacketType(data.fromPacketType) 
            and GameDataManager:getInstance():getFreePacketBoxNum()<=0) then 
            UI.ScrollBar:createByText(UI.TEXT_1212592)
        else 
            UI.ScrollBar:createByText(UI.TEXT_1212026)
        end
    end

    if(self.expeditionView) then 
        self.expeditionView:bagDataUpdate()
    end
end


-- mvc.events.PetAdventure_Handle_Adventure_Show_Drop_List 处理函数
function PetTreasureController:noticePetAdventureHandleAdventureShowDropList(notification, level)
    if self.PetTreasureAdventureLayer.levelRewardNode then
        self.PetTreasureAdventureLayer.levelRewardNode:removeFromParent()
    end
    local levelConf = mvc.petTreasureModel:getAdvGuardsDataById(level)
    local rewardBg = UI.Image:create()
    rewardBg:init("ui_petsadventure_bg_05.png")
    rewardBg:leftUp(200, 170)
    self.PetTreasureAdventureLayer.contentLayout:addChild(rewardBg, 303)
    self.PetTreasureAdventureLayer.levelRewardNode = rewardBg

    local text = UI.Text:create()
    text:init(UI.TEXT_221109, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_205_117_89)
    text:setWidth(150)
    text:setTextCenter()
    text:autoAdapt()
    text:centerUp(5)
    rewardBg:addChild(text)
    local rewardData = levelConf.boxDrop
    local idList = string.split(rewardData, ";")
    local len = #idList > 0 and #idList or 0
    local rewardNode = UI.RewardPreViewUtil:create()
    
    rewardNode:init(nil, len, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(12, 0))
    local width = rewardBg:getContentSize().width/2
    rewardNode:leftBottom(width-(len)*46, 5)
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    for k, v in pairs(idList) do 
        local goodsId = checkint(v)
        if goodsId ~= 0 then
            rewardNode:addGoodsId(goodsId, 0)
        end
    end
    rewardNode:showGoodsView()
    rewardBg:addChild(rewardNode)
    

    rewardBg:setTouchEnable(true)
    rewardBg:setInterceptTouches(true)
    rewardBg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, rewardBg, function()
        if self.PetTreasureAdventureLayer.levelRewardNode then
            self.PetTreasureAdventureLayer.levelRewardNode:hide()
        end
    end)
end



return PetTreasureController