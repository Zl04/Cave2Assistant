--[[--
控制器RecastController，view已经注入,可以通过mvc.recastProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: ping.zhengping.zhengping.zheng
-- date	: 2019/07/19
-- desc	:
------------------------------------------------------------------------------
local RecastController = class("RecastController", mvc.GameController)
local ProtobufUtil = require "utils.ProtobufUtil"

-- mvc.events.RecastRemoveLevel_Remove_Result 处理函数
function RecastController:noticeRecastRemoveLevelRemoveResult(notification)
    local data = notification.params[1]
    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.EquipErrorNo", data.err))
    if (not tolua.isnull(self.recastRemoveLevelView)) then
        self.recastRemoveLevelView:removeLevelResult(data)
    end
end

-- mvc.events.RecastRemoveLevel_Remove_Request 处理函数
function RecastController:noticeRecastRemoveLevelRemoveRequest(notification)
    local data = notification.params[1]
    if (data) then
        Net.NetNPCSystem:reqEquipRemoveLevel(data.spriteID, data.goodsData)
    end
end

-- mvc.events.RecastRefine_Refine_Request 处理函数
function RecastController:noticeRecastRefineRefineRequest(notification)
end

-- mvc.events.RecastRefine_Refine_Result 处理函数
function RecastController:noticeRecastRefineRefineResult(notification)
end

-- mvc.events.RecastRefine_ShowContent 处理函数
function RecastController:noticeRecastRefineShowContent(notification)
    self:showView(mvc.recastRefinePanel, mvc.recastBagContentView, nil, mvc.recastModel:getRefineTargetUsedType())
    self:showView(mvc.recastRefinePanel, mvc.recastRefineContentView)
    mvc.recastRefinePanel.ui:setDoorNode(self.recastRefineContentView, self.recastBagContentView, true)
    GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
end

-- mvc.events.Recast_Bag_Drag_Began 处理函数
function RecastController:noticeRecastBagDragBegan(notification)
    if self.recastRefineContentView then
        if not self.recastRefineContentView:getTargetGridData() then
            self.recastRefineContentView:updateGridAnimation("ToTarget")
        elseif not self.recastRefineContentView:getMaterialGridData() then
            self.recastRefineContentView:updateGridAnimation("ToMaterial")
        end
    elseif self.recastSuitTransformContentView then
        if not self.recastSuitTransformContentView:getTargetGridData() then
            self.recastSuitTransformContentView:updateGridAnimation("ToTarget")
        end
    end
end

-- mvc.events.Recast_Bag_Drag_Moved 处理函数
function RecastController:noticeRecastBagDragMoved(notification)
end

-- mvc.events.Recast_Bag_Drag_Ended 处理函数
function RecastController:noticeRecastBagDragEnded(notification, grid, touchPosition, isInBag)
    if self.recastRefineContentView then
        if isInBag then
            if not self.recastRefineContentView:getTargetGridData() then
                self.recastRefineContentView:updateGridAnimation("ToTargetCancel")
            elseif not self.recastRefineContentView:getMaterialGridData() then
                self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
            end
            return
        end
        local targetData = self.recastRefineContentView:getTargetGridData()
        local materialData = self.recastRefineContentView:getMaterialGridData()
        local inGridType = self.recastRefineContentView:checkTouchInGrid(touchPosition)
        local touchGridData = grid:getData()
        if inGridType == 1 or not targetData then
            if not mvc.recastModel:checkEquipHasSameName(touchGridData) then
                self.recastRefineContentView:updateGridAnimation("ToTargetCancel")
                UI.ScrollBar:createByText(UI.TEXT_1212465)
                return
            end

            if targetData then
                targetData._changeNum = 0
            end

            if not mvc.recastModel:checkEquipRefineFit(touchGridData, materialData) then
                if materialData then
                    materialData._changeNum = 0
                    self.recastRefineContentView:setMatrialGridData(nil)
                    self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                end
                GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213043)
                if targetData then
                    self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                end
            else
                GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213044)
            end
            touchGridData._changeNum = -1
            self.recastRefineContentView:setTargetGridData(touchGridData)
            if self.recastBagContentView then
                self.recastBagContentView:setUsedType(mvc.recastModel:getRefineMaterialUsedType(touchGridData.name))
            end
        elseif (inGridType == 2 or (not materialData)) then
            if mvc.recastModel:getEquipInPacakageType(touchGridData) == PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT then
                UI.ScrollBar:createByText(UI.TEXT_1213048)
                self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                return
            end

            if touchGridData:haveGemStone() then
                local showStr = UI.TEXT_1213049
                UI.ScrollBar:createByText(showStr)
                self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                return
            end

            if touchGridData:haveGlyph() then
                local showStr = UI.TEXT_227013
                UI.ScrollBar:createByText(showStr)
                self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                return
            end

            if materialData then
                materialData._changeNum = 0
            end
            touchGridData._changeNum = -1
            self.recastRefineContentView:setMatrialGridData(touchGridData)
            GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213044)
        end

        if self.recastBagContentView then
            self.recastBagContentView:bagRefresh()
        end
    elseif self.recastSuitTransformContentView then
        if isInBag then
            if not self.recastSuitTransformContentView:getTargetGridData() then
                self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
            end
            return
        end
        local touchGridData = grid:getData()

        if touchGridData:haveGemStone() then
            local showStr = UI.TEXT_1213050 
            UI.ScrollBar:createByText(showStr)
            self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
            return
        end

        if touchGridData:haveGlyph() then
            local showStr = UI.TEXT_227014
            UI.ScrollBar:createByText(showStr)
            self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
            return
        end


        local targetData = self.recastSuitTransformContentView:getTargetGridData()

        if self.recastSuitTransformContentView:checkTouchInGrid(touchPosition) or not targetData then
            if targetData then
                targetData._changeNum = 0
            end

            local costItems, coin = mvc.recastModel:getAllCostGoodsDatas(touchGridData)
            self.recastSuitTransformContentView:updateContentItems(
                mvc.recastModel:getAllEquipByEquipSet(touchGridData),
                costItems
            )
            self.recastSuitTransformContentView:updateSelectTarget(1)
            self.recastSuitTransformContentView:setTargetGridData(touchGridData)
            self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
            self.recastSuitTransformContentView:updateGridAnimation("ToTargetEnd")
            self.recastSuitTransformContentView:updateBtnState(true, coin)
            touchGridData._changeNum = -1
            
            if self.recastBagContentView then
                self.recastBagContentView:bagRefresh()
            end
            GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213047)
        end
    end
end

-- mvc.events.Recast_Refine_Grid_Drag_Out 处理函数
function RecastController:noticeRecastRefineGridDragOut(notification, isMaterial, grid)
    if self.recastRefineContentView then
        local bagData = grid:getData()
        bagData._changeNum = 0
        if not isMaterial then
            self.recastRefineContentView:setTargetGridData(nil)
            self.recastRefineContentView:updateGridAnimation("ToTargetCancel")
            GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
        else
            GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213043)
        end

        local materialData = self.recastRefineContentView:getMaterialGridData()
        if materialData then
            materialData._changeNum = 0
            self.recastRefineContentView:setMatrialGridData(nil)
            self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
        end
    end

    if self.recastBagContentView then
        if isMaterial then
            self.recastBagContentView:bagRefresh()
        else
            self.recastBagContentView:setUsedType(mvc.recastModel:getRefineTargetUsedType())
        end
    end
end

-- mvc.events.Recast_Do_Refine 处理函数
function RecastController:noticeRecastDoRefine(notification, targetGoodsData, materialGoodsData)
    local goodNumber = RoleDataManager:getMaster():getCurCoin()
    local costCoin = targetGoodsData.equipRefineCost[targetGoodsData.refineNum + 1] or 0
    if costCoin > goodNumber then
        UI.ScrollBar:createByText(UI.TEXT_110210)
        return
    end

    local remodelData = {}
    remodelData.instID = targetGoodsData:getEntityID()
    remodelData.materialInstID = materialGoodsData:getEntityID()
    remodelData.packetType = mvc.recastModel:getEquipInPacakageType(targetGoodsData)
    remodelData.materialPacketType = mvc.recastModel:getEquipInPacakageType(materialGoodsData)
    remodelData.npcid = 0
    Net.Helper:sendMessage(NetMessageType.NPC_EQUIP_REFINE_REQUEST, remodelData)
    self.targetGoodsData = targetGoodsData
end
function RecastController:succShowView(text, entityID, callback)
    Avalon.Scheduler:scheduleUpdateOnce(
        self,
        function()
            Avalon.AudioManager:playSound("1544")
        end,
        0.1
    )

    local goods = clone(GoodsDataManager:getEquipmentForEntityID(entityID))
    goods.canUseState = nil

    Avalon.Scheduler:scheduleUpdateOnce(
        self,
        function()
            local rewardGoodsArr = {}
            local goodData = goods
            table.insert(rewardGoodsArr, goodData)
            Avalon.MessageCenter:notice(
                GameMessage.MC_UI_COMMON_REWARD,
                rewardGoodsArr,
                function()
                    if callback then
                        callback()
                    end
                end,
                text,
                nil,
                nil,
                true,
                Game.RewardLayerOpenAction.Scale_Center
            )
        end,
        2
    )
    Avalon.Scheduler:scheduleUpdateOnce(
        self,
        function()
            Avalon.AudioManager:playSound("1517")
            -- else
            --     Avalon.AudioManager:playSound("1518")
            -- end
        end,
        1.3
    )
end
function RecastController:refineResult(data, entityID)
    if self.targetGoodsData and data.err == "EquipErrorNo_OK" then
        self.targetGoodsData.refineNum = self.targetGoodsData.refineNum + 1
    end
    if self.recastRefineContentView then
        self.recastRefineContentView:doRewardAnimation(data.err == "EquipErrorNo_OK", goodsData)
        if data.err == "EquipErrorNo_OK" then
            UI.ScrollBar:createByText(UI.TEXT_1213035)
            self:succShowView(
                UI.TEXT_1213035,
                entityID,
                function()
                    if not self.recastRefineContentView then
                        return
                    end
                    local data = self.recastRefineContentView:getTargetGridData()
                    if data then
                        data._changeNum = 0
                    end
                    self.recastRefineContentView:setMatrialGridData(nil)
                    self.recastRefineContentView:setTargetGridData(nil)
                    self.recastRefineContentView:updateGridAnimation("ToMaterialCancel")
                    self.recastRefineContentView:updateGridAnimation("ToTargetCancel")
                    if self.recastBagContentView then
                        self.recastBagContentView:setUsedType(mvc.recastModel:getRefineTargetUsedType())
                    end
                    GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
                end
            )
        else
            UI.ScrollBar:createByText(UI.TEXT_1213041)
            Avalon.Scheduler:scheduleUpdateOnce(
                self,
                function()
                    Avalon.AudioManager:playSound("1544")
                end,
                0.1
            )
            Avalon.Scheduler:scheduleUpdateOnce(
                self,
                function()
                    Avalon.AudioManager:playSound("1518")
                end,
                1.3
            )
        end
    end

end

-- mvc.events.Recast_Suit_Transform_Show 处理函数
function RecastController:noticeRecastSuitTransformShow(notification)
    self:showView(
        mvc.equipSuitTransformPanel,
        mvc.recastBagContentView,
        nil,
        mvc.recastModel:getSuitTransformUsedType()
    )
    self:showView(mvc.equipSuitTransformPanel, mvc.recastSuitTransformContentView)
    mvc.equipSuitTransformPanel.ui:setDoorNode(self.recastSuitTransformContentView, self.recastBagContentView, true)
    GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213046)
end

-- mvc.events.Recast_Suit_Transform_Drag_Out 处理函数
function RecastController:noticeRecastSuitTransformDragOut(notification, grid)
    if self.recastSuitTransformContentView then
        local bagData = grid:getData()
        bagData._changeNum = 0
        self.recastSuitTransformContentView:setTargetGridData(nil)
        self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
        self.recastSuitTransformContentView:updateBtnState(false)
        self.recastSuitTransformContentView:updateContentItems({}, {})
        GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213046)
    end

    if self.recastBagContentView then
        self.recastBagContentView:bagRefresh()
    end
end

-- mvc.events.Recast_Do_Suit_Transform 处理函数
function RecastController:noticeRecastDoSuitTransform(notification, sourceEquipData, targetEquipData)
    print("sen.", sourceEquipData:getEntityID(), targetEquipData.goodsID)
    local isOk, templateId = mvc.recastModel:checkEquipTransformCost(targetEquipData)
    if not isOk then
        if templateId == Game.ConstGoods.Coin then
            UI.ScrollBar:createByText(UI.TEXT_110210)

            return
        end
        UI.ScrollBar:createByText(UI.TEXT_1213040)
        return
    end
    -- local npcId = 1900548
    GameManager:trigerEquipSetFunction(
        sourceEquipData:getEntityID(),
        targetEquipData.goodsID,
        mvc.recastModel:getNpcId(),
        sourceEquipData:getBagType()
    )
end

-- mvc.events.Recast_Suit_Transform_Target_Select 处理函数
function RecastController:noticeRecastSuitTransformTargetSelect(notification, idx)
    self.recastSuitTransformContentView:updateSelectTarget(idx)
end

function RecastController:updateEquipTransformResult(data, entityID)
    if self.recastSuitTransformContentView then
        self.recastSuitTransformContentView:doRewardAnimation(data.result == 1)
        if data.result == 1 then
            UI.ScrollBar:createByText(UI.TEXT_1213039)
            self:succShowView(
                UI.TEXT_1213039,
                entityID,
                function()
                    if not self.recastSuitTransformContentView then
                        return
                    end
                    self.recastSuitTransformContentView:updateContentItems({}, {})
                    self.recastSuitTransformContentView:setTargetGridData(nil)
                    self.recastSuitTransformContentView:updateGridAnimation("ToTargetCancel")
                    GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213046)
                    self.recastSuitTransformContentView:updateBtnState(false)
                end
            )
        else
            UI.ScrollBar:createByText(UI.TEXT_1213042)
            Avalon.Scheduler:scheduleUpdateOnce(
                self,
                function()
                    Avalon.AudioManager:playSound("1544")
                end,
                0.1
            )
            Avalon.Scheduler:scheduleUpdateOnce(
                self,
                function()
                    Avalon.AudioManager:playSound("1518")
                end,
                1.3
            )
        end
    end
end

return RecastController
