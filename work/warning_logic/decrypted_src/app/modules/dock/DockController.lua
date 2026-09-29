--[[--
控制器DockController，view已经注入,可以通过mvc.dockProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/05/06
-- desc	: 
------------------------------------------------------------------------------
local DockController = class("DockController", mvc.GameController)

-- mvc.events.Dock_Show_Layer 处理函数
function DockController:noticeDockShowLayer(notification, name, parent)
    local layer
    if name == "DockSailLayer" then
        local PetPacketLayer = require "app.modules.dock.DockSailLayer"
        self.DockSailLayer = PetPacketLayer:create()
        layer = self.DockSailLayer

    elseif name == "DockUpgradeLayer" then
        -- mvc.send("PetTreasure_Send_Battle_Info_Pets")

        local DockUpgradeLayer = require "app.modules.dock.DockUpgradeLayer"
        self.DockUpgradeLayer = DockUpgradeLayer:create(PublicDefine.ManorBuildID.BuildID_Dock, UI.Type.DOCK_UPGRADE_VIEW)
        layer = self.DockUpgradeLayer

    elseif name == "ManorWholeFacaLayer" then
        local ManorWholeFacaLayer = require "app.modules.manorappearance.ManorWholeFacaLayer"
        self.ManorWholeFacaLayer = ManorWholeFacaLayer:create("boat")
        layer = self.ManorWholeFacaLayer
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.Dock_Click_Tab 处理函数
function DockController:noticeDockClickTab(notification, clickIndex)
    if not self.dockMainView then
        return
    end

    self.dockMainView.curTabIndex = clickIndex
    self.dockMainView.btnData[self.dockMainView.curTabIndex].select = true
    self.dockMainView._tableView:updateCellAtIndex(self.dockMainView.curTabIndex - 1)

    if self.dockMainView.lastTabIndex > 0 then
        if self.dockMainView.lastTabIndex == clickIndex then
            return
        end
        self.dockMainView.btnData[self.dockMainView.lastTabIndex].select = false
        self.dockMainView._tableView:updateCellAtIndex(self.dockMainView.lastTabIndex - 1)
    end

    local nowPageId = self.dockMainView.curTabIndex
    local lastPageId = self.dockMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    local name = ""
    if nowPageId == 1 then
        name = "DockSailLayer"
    elseif nowPageId == 2 then
        name = "DockUpgradeLayer"
    elseif nowPageId == 3 then
        name = "ManorWholeFacaLayer"
    end
    mvc.send("Dock_Show_Layer", name, self.dockMainView)

    if lastPageId == 1 and self.DockSailLayer and not tolua.isnull(self.DockSailLayer) then
        self.DockSailLayer:removeFromParent(true)
        self.DockSailLayer = nil
    elseif lastPageId == 2 and self.DockUpgradeLayer and not tolua.isnull(self.DockUpgradeLayer) then
        self.DockUpgradeLayer:removeFromParent(true)
        self.DockUpgradeLayer = nil
    elseif lastPageId == 3 and self.ManorWholeFacaLayer and not tolua.isnull(self.ManorWholeFacaLayer) then
        self.ManorWholeFacaLayer:removeFromParent(true)
        self.ManorWholeFacaLayer = nil
    end

    self.dockMainView.lastTabIndex = self.dockMainView.curTabIndex
end



-- mvc.events.Dock_Open_Main_View 处理函数
function DockController:noticeDockOpenMainView(notification, layerName)
    local sailData = mvc.dockModel:getSailData()
    Net.NetManorSystem:reqSyncSailData(sailData.lastTime)

    print("Dock_Open_Main_View:", mvc.dockModel:isSailing())
    if mvc.dockModel:isSailing() then
        local sailLogData = mvc.dockModel:getSailLogData()
        dump(sailLogData, "sailLogData123", 5)
        Net.NetManorSystem:reqSyncSailLog(sailLogData.lastTime or 0)
    end
    
    mvc.openPanel("Dock", "DockMain")
    local pageIndex = 1
    if layerName == "DockSailLayer" then
        pageIndex = 1
    elseif layerName == "DockUpgradeLayer" then
        pageIndex = 2
    elseif layerName == "ManorWholeFacaLayer" then
        pageIndex = 3
    end

    mvc.send("Dock_Click_Tab", pageIndex)
end

-- 根据下标展现物品
function DockController:showItemByIndex(idx, title, btnStr)
    -- 展现获得物品
    local rewardInfoArr = mvc.activityPointModel:getRewardArrFromID(idx)
    if (rewardInfoArr and #rewardInfoArr > 0) then
        local dropDisplayDataArr = {}
        require "app.datas.GoodsDataManager"
        for i,v in ipairs(rewardInfoArr) do
            local dummyItem = GoodsDataManager:createLocalGoodsData(v.goodsID)
            if(dummyItem) then
                dummyItem:setNum(v.goodsNum)
                table.insert(dropDisplayDataArr, dummyItem)
            end
        end

        if (#dropDisplayDataArr > 0) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr)  
        end
    end
end


-- mvc.events.Dock_Packet_Item_Drag 处理函数
function DockController:noticeDockPacketItemDrag(notification, stype, data)
    if stype == "GridDragEnded" then
        local petData = data.cell:getData()
        -- 出战标识关闭
        petData:setReadyFight(false)

        self.DockSailLayer:slotDragEnd(petData, data.touchPosition)
        -- if data.eventName == "DockSailLayer" then
        --     self.DockSailLayer:slotDragEnd(petData, data.touchPosition)
        -- end
    end
end



-- mvc.events.Dock_Seaman_Drag_Move 处理函数
function DockController:noticeDockSeamanDragMove(notification, stype, data)
    local cell = data.cell
    local touchPosition = data.touchPosition
    local parent = self.DockSailLayer

    if stype == UIEvent.COMPONENT_TOUCH_MOVED then
        -- local cellData = cell:getData()
        -- local petData = cellData.petData

        -- local replicaIcon = parent:getChildByName("replicaIcon")
        -- if not replicaIcon then
        --     replicaIcon = UI.PetMainListCell:create()
        --     replicaIcon:init(nil, true, true, true, petData)
        --     replicaIcon:setName("replicaIcon")
        --     parent:addChild(replicaIcon, 2000)
        -- end

        -- local pos = parent:convertToNodeSpace(touchPosition)
        -- local size = replicaIcon:getContentSize()
        -- local x = pos.x - size.width/2
        -- local y = pos.y - size.height/2
        -- replicaIcon:setPosition(cc.p(x, y))

    elseif stype == UIEvent.COMPONENT_DOUBLE_CLICK then
        local packetLayer = parent.contentLayout:getChildByName("packetLayer")
        if packetLayer then
            local petArr = mvc.dockModel:getPacketPets(data.eventName)  
            packetLayer:updateByData(petArr)
        end

        -- local replicaIcon = parent:getChildByName("replicaIcon")
        -- if replicaIcon then
        --     parent:removeChildByName("replicaIcon")
        -- end

    end
end



-- mvc.events.Dock_Seaman_Drag_End 处理函数
function DockController:noticeDockSeamanDragEnd(notification)

end



-- mvc.events.Dock_Sync_Sail_Data 处理函数
function DockController:noticeDockSyncSailData(notification, data)
    mvc.dockModel:setDockData(data)
    mvc.dockModel:clearSailingStatus()
    if data.sailData and data.sailData.sailId ~= 0 then
        mvc.dockModel:setSailingStatus(data.sailData.sailId, true)
    end

    if data.boatData and data.boatData.boatId ~= 0 then
        mvc.dockModel:setBoatConfig(data.boatData.boatId)
    end

    if self.DockSailLayer and not tolua.isnull(self.DockSailLayer) then
        self.DockSailLayer:updateSailLayer()
    end
    
end



-- mvc.events.Dock_Resp_Change_Boat 处理函数
function DockController:noticeDockRespChangeBoat(notification, data)
    mvc.dockModel:setBoatConfig(data.boatId)
    mvc.dockModel:clearSupplyAmount()
    mvc.dockModel:clearEmbattlePets()
    mvc.dockModel:clearSpeedAttrGains()
    local GameInManorManager = require "app.game.GameInManorManager"
    local map = GameInManorManager:getInstance():getBuildID2FunctionMap()
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_Dock)
    local funtionID = map[PublicDefine.ManorBuildID.BuildID_Dock]
    local animeName = ""
    if buildData.facadeId and buildData.facadeId ~= 0 then
        local shapeConfig = ConfigManager:getAllOtherShapeDataByID(buildData.facadeId)
        animeName = shapeConfig.replaceResource
    end
    GameInManorManager:getInstance():changeNPCSpine(funtionID, animeName)
    -- if self.ManorWholeFacaLayer then
    --     self.ManorWholeFacaLayer:updateCells()
    -- end
    
end



-- mvc.events.Dock_Resp_Got_New_Boat 处理函数
function DockController:noticeDockRespGotNewBoat(notification)
    if self.ManorWholeFacaLayer then
        self.ManorWholeFacaLayer:updateCells()
    end
end



-- mvc.events.Dock_Resp_Set_Sail 处理函数
function DockController:noticeDockRespSetSail(notification, data)
    self.DockSailLayer:changeSailSatus()
end



-- mvc.events.Dock_Take_Sail_Goods 处理函数
function DockController:noticeDockTakeSailGoods(notification)
    self.DockSailLayer:bagRefresh()
    self.DockSailLayer:changeSailSatus()
    UI.ScrollBar:createByText(UI.TEXT_1212026)
end



-- mvc.events.Dock_Show_Pet_Packet 处理函数
function DockController:noticeDockShowPetPacket(notification)
    self.DockSailLayer:clickEmbattleBtn()
end



-- mvc.events.Dock_Pet_Packet_Double_Click 处理函数
function DockController:noticeDockPetPacketDoubleClick(notification, data)
    -- local petData = cell:getData()
    -- 出战标识关闭
    data:setReadyFight(false)
    self.DockSailLayer:doubleClickedEnd(data)
end



-- mvc.events.Update_Dock_Detail 处理函数
function DockController:noticeUpdateDockDetail(notification)
    self.DockSailLayer:updateDockDetail(self.DockSailLayer.curTabIndex)
end



-- mvc.events.Update_Dock_Upgrade_Progress 处理函数
function DockController:noticeUpdateDockUpgradeProgress(notification)
    if self.DockUpgradeLayer then
        self.DockUpgradeLayer:updateProgress()
    end
end



return DockController