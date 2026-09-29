--[[--
控制器RuneMoldController，view已经注入,可以通过mvc.runeMoldProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/04/20
-- desc	: 
------------------------------------------------------------------------------
local RuneMoldController = class("RuneMoldController", mvc.GameController)

-- mvc.events.Rune_Mold_ShowContent 处理函数
function RuneMoldController:noticeRuneMoldShowContent(notification)

end



-- mvc.events.Rune_Bag_Drag_Began 处理函数
function RuneMoldController:noticeRuneBagDragBegan(notification)
    -- if self.runeMoldView and not tolua.isnull(self.runeMoldView) then
    --     if not self.runeMoldView:getTargetGridData() then
    --         self.runeMoldView:updateGridAnimation("ToTarget")
    --     end
    -- end
end



-- mvc.events.Rune_Bag_Drag_Ended 处理函数
function RuneMoldController:noticeRuneBagDragEnded(notification, grid, touchPosition, isInBag)
    -- if isInBag then
    --     if not self.runeMoldView:getTargetGridData() then
    --         self.runeMoldView:updateGridAnimation("ToTargetCancel")
    --     end
    --     return
    -- end
    -- local targetData = self.runeMoldView:getTargetGridData()
    -- local materialData = self.runeMoldView:getMaterialGridData()
    -- local inGridType = self.runeMoldView:checkTouchInGrid(touchPosition)
    local touchGridData = grid:getData()
    if touchGridData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_110030)
        -- self.runeMoldView:updateGridAnimation("ToTargetCancel")
        return
    end
    -- self.runeMoldView:setTargetGridData(touchGridData)
    self.runeMoldView:onDragEnd(touchPosition, grid)
    
    -- if inGridType == 1 or not targetData then
        
    -- end

    if self.runeMoldBagContentView then
        self.runeMoldBagContentView:bagRefresh()
    end
end



-- mvc.events.Rune_Mold_Grid_Drag_Out 处理函数
function RuneMoldController:noticeRuneMoldGridDragOut(notification, grid)
    if self.runeMoldView and not tolua.isnull(self.runeMoldView) then
        local bagData = grid:getData()
        if bagData then
            bagData._changeNum = 0
            self.runeMoldView:setTargetGridData(nil)
            self.runeMoldView:updateGridAnimation("ToTargetCancel")
            -- GameManager:showNPCInfomation(mvc.recastModel:getNpcId(), UI.TEXT_1213045)
        end
        
    end

    if self.runeMoldBagContentView then
        self.runeMoldBagContentView:bagRefresh()
    end
end



-- mvc.events.Rune_Mold_On_Bag_Close 处理函数
function RuneMoldController:noticeRuneMoldOnBagClose(notification)
    if self.runeMoldView and not tolua.isnull(self.runeMoldView) then
        self.runeMoldView:onBagViewClose()
    end
end



-- mvc.events.Rune_Mold_On_Forging 处理函数
function RuneMoldController:noticeRuneMoldOnForging(notification, data)
    if self.runeMoldView and not tolua.isnull(self.runeMoldView) then
        self.runeMoldView:onForgingSucceed(data)
    end
end



-- mvc.events.Rune_Mold_On_Inlaid 处理函数
function RuneMoldController:noticeRuneMoldOnInlaid(notification, data)
    if self.runeMoldView and not tolua.isnull(self.runeMoldView) then
        self.runeMoldView:onInlaidSucceed(data)
    end
end



return RuneMoldController