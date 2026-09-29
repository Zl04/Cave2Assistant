--[[
    DialogLayout.lua
    use：ydli
    UI - 放入scrollview 里面的容器，实现向上和向下扩展高度
]]--

require "app.ui.common.TouchLayout"

--------自定义 奖励内容  处理触摸事件
local DialogLayout = class("DialogLayout", UI.TouchLayout)
UI.DialogLayout = DialogLayout
local COM_LAYOUT_TYPE = UI.LayoutDefaultType 

function DialogLayout:ctor(scrollView, chatChannelType)
    --窗口大小
    self.super.ctor(self)
    self.scrollView = scrollView
    self.maxCellNumber = scrollView:getMaxCellSize()
    self.curCellNumber = 0
    self.cellList = {}
    self.freeCellList = {} --没有父节点的缓存， 等待被循环使用
    self._chatChannelType = chatChannelType
    local SdkBox = require("utils.sdkbox.SdkBox")
    if chatChannelType ~= ChatChannelType.QUICK then
        self:addTouchEvents(self)
    end
    self.openDisPatchSizeChange = true
end

function DialogLayout:dtor()
    --窗口大小
    self.super.dtor(self)
    self.curCellNumber = 0
    self.cellList = {}
    for k, v in ipairs(self.freeCellList) do
        v:release()
    end
    self.freeCellList = {} --没有父节点的缓存， 等待被循环使用
end




function DialogLayout:_addHeight(isToUp, height)
    if self:getContentSize().height + height < 0 then
        return
    end
    if height == 0 then
       return
    end
     -- 左上角（默认）\左上\右上\中上
    if (self._layoutType == COM_LAYOUT_TYPE.DEFAULT or self._layoutType == COM_LAYOUT_TYPE.LEFT_UP or self._layoutType == COM_LAYOUT_TYPE.RIGHT_UP or self._layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
        if isToUp then
            self._up = self:getUp() - height
        else
            
        end
    -- 居中\中左\中右
    elseif (self._layoutType == COM_LAYOUT_TYPE.CENTER or self._layoutType == COM_LAYOUT_TYPE.CENTER_LEFT or self._layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then 
        
    -- 左下\右下\中下
    elseif (self._layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM or self._layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM or self._layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
        if isToUp then
            
        else
            self._bottom = self:getBottom() - height
        end
    else
    end
end

function DialogLayout:addHeight(isToUp, height)
    if height == 0 then
        return
    end
    self:_addHeight(isToUp, height)
    -- self:refreshPosition()
    self:moveAllChild(not isToUp, height)--已有子节点 保持不动
    self:setSizeWithForbid(self:getContentSize().width, self:getContentSize().height + height, true)
end

--大于或者小于index的 才移动
function DialogLayout:addHeightByIndex(isToUp, height, tag, addPercent)
    print("-----addHeightByIndex-", isToUp, height, tag)
    local isAddHeight = false
    local addPercent = 0
    if not isToUp then
        local child = self.cellList[self.curCellNumber]
        if child:getPositionY() + self.scrollView:getScrollPosY() <= 0 or self:getContentSize().height > self.scrollView:getContentSize().height then
            self:_addHeight(isToUp, height)
            isAddHeight = true
            local curCell = nil
            for k, v in ipairs(self.cellList) do
                if v:getTag() == tag then
                    curCell = v
                end
            end
            if curCell:getPositionY() + self.scrollView:getScrollPosY() < 0 and height > 0 then
                local sonNumber = (curCell:getPositionY() + self.scrollView:getScrollPosY()) * -1 + height
                local motherNumber = self:getContentSize().height - self.scrollView:getContentSize().height
                if motherNumber > 0 then
                    addPercent = sonNumber / motherNumber * 100
                end
            end
        end
    elseif isToUp then
        local child = self.cellList[1]
        if child:getPositionY() + child:getContentSize().height + self.scrollView:getScrollPosY() > self:getContentSize().height or self:getContentSize().height > self.scrollView:getContentSize().height then
            self:_addHeight(isToUp, height)
            isAddHeight = true
        end
    end
    print("----addHeightByIndex-----isAddHeight -= ", isAddHeight)
    if isAddHeight then
        self:moveChildByIndex(isToUp, height, tag)
    else
        self:moveChildByIndexWithNoAdd(isToUp, height, tag)
        self:refreshPosition()
    end
    if height ~= 0 and isAddHeight then
        self.scrollView:setBounceEnabled(false)
        local percent = self.scrollView:getScrolledPercentVertical()
        self:setSizeWithForbid(self:getContentSize().width, self:getContentSize().height + height, true)
        self.scrollView:scrollToPercentVertical(percent + addPercent)
        -- if addPercent ~= 0 then
            -- if isToUp then
            --     -- local tempPercent = percent + addPercent
            --     -- tempPercent = tempPercent > 100 and 100 or tempPercent
            --     self.scrollView:scrollToPercentVertical(percent + addPercent)
            -- else
            --     -- local tempPercent = percent - addPercent
            --     -- tempPercent = tempPercent < 0 and 0 or tempPercent
            --     self.scrollView:scrollToPercentVertical(percent + addPercent)
            -- end
        -- end
        self.scrollView:setBounceEnabled(true)
    end
end

function DialogLayout:moveAllChild(isToUp, height)
    local children = self:getChildren()
    for k , child in pairs(children) do
        -- 左上角（默认）\左上\右上\中上
        if (child._layoutType == COM_LAYOUT_TYPE.DEFAULT or child._layoutType == COM_LAYOUT_TYPE.LEFT_UP or child._layoutType == COM_LAYOUT_TYPE.RIGHT_UP or child._layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
            if isToUp then
                
            else
        	   child._up = child:getUp() + height
            end
            -- 居中\中左\中右
        elseif (child._layoutType == COM_LAYOUT_TYPE.CENTER or child._layoutType == COM_LAYOUT_TYPE.CENTER_LEFT or child._layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then 
        
        -- 左下\右下\中下
        elseif (child._layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
            if isToUp then
        	    child._bottom = child:getBottom() + height
            else
        	
            end
        else
        end
    end
end

function DialogLayout:moveChildByIndex(isToUp, height, tag)
    local index = nil
    for k, v in ipairs(self.cellList) do
        if v:getTag() == tag then
            index = k
        end
    end
    if index == nil then
        return
    end

    for curIndex, child in pairs(self.cellList) do     
        -- 左上角（默认）\左上\右上\中上
        if (child._layoutType == COM_LAYOUT_TYPE.DEFAULT or child._layoutType == COM_LAYOUT_TYPE.LEFT_UP or child._layoutType == COM_LAYOUT_TYPE.RIGHT_UP or child._layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
            if isToUp then
                if curIndex > index then
                    child._up = child:getUp() + height
                end
            else
                if curIndex > index then
                    child._up = child:getUp() + height
                end
            end
            -- 居中\中左\中右
        elseif (child._layoutType == COM_LAYOUT_TYPE.CENTER or child._layoutType == COM_LAYOUT_TYPE.CENTER_LEFT or child._layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then 
        
            -- 左下\右下\中下
        elseif (child._layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
            if isToUp then
                if curIndex < index then
                    child._bottom = child:getBottom() + height
                end
            else
                if curIndex < index then
                    child._bottom = child:getBottom() + height
                end
            end
        else
        end
    end
end

function DialogLayout:moveChildByIndexWithNoAdd(isToUp, height, tag)
    local index = nil
    for k, v in ipairs(self.cellList) do
        if v:getTag() == tag then
            index = k
        end
    end
    if index == nil then
        return
    end

    for curIndex, child in pairs(self.cellList) do     
        -- 左上角（默认）\左上\右上\中上
        if (child._layoutType == COM_LAYOUT_TYPE.DEFAULT or child._layoutType == COM_LAYOUT_TYPE.LEFT_UP or child._layoutType == COM_LAYOUT_TYPE.RIGHT_UP or child._layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
            if curIndex < index then
                child._up = child:getUp() - height
            end
            -- 居中\中左\中右
        elseif (child._layoutType == COM_LAYOUT_TYPE.CENTER or child._layoutType == COM_LAYOUT_TYPE.CENTER_LEFT or child._layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then 
        
            -- 左下\右下\中下
        elseif (child._layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM or child._layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
            if curIndex >= index then
                child._bottom = child:getBottom() - height
            end
        else
        end
    end
end

--isForward 是否插入在最前面
function DialogLayout:addChildByDirect(child, isForward, left)
    local bottom = 0
    local left = left == nil and 1 or left
    self:addChild(child)
    if self.curCellNumber == 0 then
        if isForward then
            child:leftBottom(left, bottom)
        else
            child:leftBottom(left, self:getContentSize().height - child:getContentSize().height + bottom)
        end
    elseif isForward then
    	local lastCell = self.cellList[1]
        child:leftBottom(left, lastCell:getBottom() + lastCell:getContentSize().height + bottom)
    else
        local lastCell = self.cellList[self.curCellNumber]
        child:leftBottom(left, lastCell:getBottom() - child:getContentSize().height + bottom)
    end
    self.curCellNumber = self.curCellNumber + 1
    if isForward then
    	table.insert(self.cellList, 1, child)
    else
        table.insert(self.cellList, child)
    end
    if self.curCellNumber > self.maxCellNumber then
        if isForward then
        	local node = self.cellList[self.curCellNumber]
        	local height = node:getContentSize().height
            if node.isDialogTextCell then
                node:retain()
                node:_removeFromParent(false)
                table.insert(self.freeCellList, node)
            else
                node:removeFromParent(false)
            end
            table.remove(self.cellList, self.curCellNumber)
            -- self:addHeight(false, -height)
        else
            local node = self.cellList[1]
            local height = node:getContentSize().height
            if node.isDialogTextCell then
                node:retain()
                node:_removeFromParent(false)
                table.insert(self.freeCellList, node)
            else
                node:removeFromParent(false)
            end
            table.remove(self.cellList, 1)
            -- self:addHeight(true, -height)
        end
        self.curCellNumber = self.curCellNumber - 1
    end

    if not isForward and child:getPositionY() < bottom then
        self:addHeight(false, bottom - child:getPositionY())
    elseif isForward then
    	-- self:addHeight(true, child:getContentSize().height)
        if child:getPositionY() + child:getContentSize().height > self:getContentSize().height then
            self:addHeight(true, child:getPositionY() + child:getContentSize().height - self:getContentSize().height)
        elseif child:getTag() == 1 and child:getPositionY() + child:getContentSize().height < self:getContentSize().height then--头部检测滑动框是否过高
            self:addHeight(true, child:getPositionY() + child:getContentSize().height - self:getContentSize().height)
        end
    end
end

--isToUp 滑动方向
--如果是向上滑动 判断底部被隐藏住的cell 是否大于1 否则返回
--向下同理
function DialogLayout:isRefreshCell(isToUp, scrollY) 
    -- print("----isRefreshCell-------", isToUp, scrollY)
    if self.curCellNumber < 2 then
        return
    end    
    if isToUp then
        --是否移除头部 cell
        -- print("------firstCell:getPositionY() + scrollY "..(firstCell:getPositionY() + scrollY))
        -- if firstCell:getPositionY() + scrollY > self.scrollView:getContentSize().height then
        --     return lastCell:getTag()
        -- end
        local lastCell = self.cellList[self.curCellNumber]
        local lastSecondCell = self.cellList[self.curCellNumber - 1]
        if lastSecondCell:getPositionY() + lastSecondCell:getContentSize().height + scrollY > 0 then
            return lastCell:getTag()
        end
    else
        --是否移除尾部 cell
        -- print("---lastCell:getPositionY() + scrollY + lastCell:getContentSize().height = "..(lastCell:getPositionY() + scrollY + lastCell:getContentSize().height))
        -- print("self:getPositionY() = "..self:getPositionY())
        local firstCell = self.cellList[1]
        local firstSecondCell = self.cellList[2]
        if firstSecondCell:getPositionY() + scrollY  < self.scrollView:getContentSize().height then
            return firstCell:getTag()
        end
    end
end

function DialogLayout:removeAllChild() 
    self.curCellNumber = 0
    for k, node in ipairs(self.cellList) do
        if node.isDialogTextCell then
            node:retain()
            node:_removeFromParent(false)
            table.insert(self.freeCellList, node)
        else
            node:removeFromParent(false)
        end
    end
    self.cellList = {}
end

function DialogLayout:getLastShowMessageIndex(scrollY) 
    for index = self.curCellNumber, 1, -1 do
        local cell = self.cellList[index]
        if cell:getPositionY() + scrollY + cell:getContentSize().height > 0 then
            return cell:getTag()
        end 
    end
    return 0
end

function DialogLayout:setFullScreen(isFullScreen)
    self._isFullScreen = isFullScreen
end

--触摸事件 -- （现在只有单点击翻译）
function DialogLayout:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    if not AvalonUtil:isRectContainsPoint(self.scrollView, location) then
        return
    end  
    for k, value in ipairs(self.cellList) do
        local node = value:getChildByName("TouchLayout")
        if node and AvalonUtil:isRectContainsPoint(node, location) then
            self.selectIndex = k
            break
        end
    end
end

function DialogLayout:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self.scrollView, location) then
        return
    end 

    for k, value in ipairs(self.cellList) do
        local node = value:getChildByName("TouchLayout")
        if node and AvalonUtil:isRectContainsPoint(node, location) and self.selectIndex == k then
            value:clickCallback(location)
            break
        end
    end
end

function DialogLayout:translateCallback(eventType, commonId, resultObject)
    if eventType == GOOGLE_TRANSLATE_EVENT.TRANSLATE_EVENT then
        Game.ChatManager:getInstance():insertTransFormStrTbCache(commonId, resultObject)
    end
    for k, node in ipairs(self.cellList) do
        if node.isDialogTextCell and node:getRichTextMd5KeyWithLanguageType() == commonId then
            node:translateCallback(eventType, resultObject, true)
            -- break
        end
    end
end

function DialogLayout:getFreeCellFromTop() 
    if #self.freeCellList < 0 then
        return
    end
    for k, v in pairs(self.freeCellList) do
        if v ~= nil then
            table.remove(self.freeCellList, k)
            return v
        end
    end        
end

function DialogLayout:getFreeCellByClassName(className) 
    if #self.freeCellList < 0 then
        return
    end
    for k, v in pairs(self.freeCellList) do
        if v ~= nil and v.getClassName and v:getClassName() == className then
            table.remove(self.freeCellList, k)
            return v
        end
    end        
end

function DialogLayout:setSizeWithForbid(width, height, isForbidDispatch)
    self.openDisPatchSizeChange = false
    self:setSize(width, height, true)
    self.scrollView._scrollView:setInnerContainerSize(self:getContentSize(), false)
    self.scrollView:updateView(nil, isForbidDispatch)
    self.openDisPatchSizeChange = true
end


function DialogLayout:setSize(width, height, isForbidDispatch)
    DialogLayout.super.setSize(self, width, height, isForbidDispatch)
    --todo 记录聊天窗口的高度 用于下次打开界面 马上就能创建最准确的界面大小
    if self._chatChannelType then
        Game.ChatManager:getInstance():saveChatDialogHeight(self._chatChannelType, height)
    end
end

function DialogLayout:checkTranslateMode()
    local isInTranslate = Game.ChatManager:getInstance().isInTranslateMode
    if isInTranslate then --切换到翻译模式
        for k, node in ipairs(self.cellList) do
            if node.isDialogTextCell then
                node:doTranslateMode()
            end
        end
    else
        for k, node in ipairs(self.cellList) do
            if node.isDialogTextCell then
                node:cancleTranslateMode()
            end
        end
    end
end