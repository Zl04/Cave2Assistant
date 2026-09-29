--[[--
控制器BarterTableController，view已经注入,可以通过mvc.barterTableProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/05/25
-- desc	: 
------------------------------------------------------------------------------
local BarterTableController = class("BarterTableController", mvc.GameController)

-- mvc.events.Barter_Table_Request 处理函数
function BarterTableController:noticeBarterTableRequest(notification)

end



-- mvc.events.Barter_Table_Result 处理函数
function BarterTableController:noticeBarterTableResult(notification)
    if self.barterTableContentView then
        self.barterTableContentView:onExchangeSuccess()
    end
end



-- mvc.events.Barter_Table_ShowContent 处理函数
function BarterTableController:noticeBarterTableShowContent(notification)
    self:showView(mvc.barterTablePanel, mvc.barterTableBagContentView, nil, mvc.recastModel:getRefineTargetUsedType())
    self:showView(mvc.barterTablePanel, mvc.barterTableContentView)
    mvc.barterTablePanel.ui:setDoorNode(self.barterTableContentView, self.barterTableBagContentView, true)
    -- GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
end



-- mvc.events.Barter_Bag_Drag_Began 处理函数
function BarterTableController:noticeBarterBagDragBegan(notification)
    if self.barterTableContentView then
        if not self.barterTableContentView:getTargetGridData() then
            self.barterTableContentView:updateGridAnimation("ToTarget")
        end
    end
end



-- mvc.events.Barter_Bag_Drag_Moved 处理函数
function BarterTableController:noticeBarterBagDragMoved(notification)

end



-- mvc.events.Barter_Bag_Drag_Ended 处理函数
function BarterTableController:noticeBarterBagDragEnded(notification, grid, touchPosition, isInBag)
    if isInBag then
        if not self.barterTableContentView:getTargetGridData() then
            self.barterTableContentView:updateGridAnimation("ToTargetCancel")
        end
        return
    end
    -- local targetData = self.barterTableContentView:getTargetGridData()
    -- local materialData = self.barterTableContentView:getMaterialGridData()
    -- local inGridType = self.barterTableContentView:checkTouchInGrid(touchPosition)
    local touchGridData = grid:getData()
    if touchGridData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_110030)
        self.barterTableContentView:updateGridAnimation("ToTargetCancel")
        return
    end
    self.barterTableContentView:setTargetGridData(touchGridData)
    self.barterTableContentView:updateGridAnimation("ToTargetEnd")
    
    -- if inGridType == 1 or not targetData then
        
    -- end

    if self.barterTableBagContentView then
        self.barterTableBagContentView:bagRefresh()
    end
end



-- mvc.events.Barter_Grid_Drag_Out 处理函数
function BarterTableController:noticeBarterGridDragOut(notification, grid)
    if self.barterTableContentView then
        local bagData = grid:getData()
        if bagData then
            bagData._changeNum = 0
            self.barterTableContentView:setTargetGridData(nil)
            self.barterTableContentView:updateGridAnimation("ToTargetCancel")
            -- GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
        end
        
    end

    if self.barterTableBagContentView then
        self.barterTableBagContentView:bagRefresh()
    end
end



return BarterTableController
