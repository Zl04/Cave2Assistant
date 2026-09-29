--[[
	公共TableView
	by yueyingsong
]]

require "app.ui.Component"

UI = UI or {}
local TableView = class("TableView",UI.HWBtnComponent)

UI.TableView = TableView


function TableView:ctor(resList, width, height, isEnableScrollCallback)
	TableView.super.ctor(self, UIType.SCROLL_VIEW, resList, width or 0, height or 0)
	self.oldContentSize = cc.size(0, 0)
    
    self._direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
    self._bounceable = true;
    -- self._touchEnable = true
    self._verticalFillOrder = cc.TABLEVIEW_FILL_TOPDOWN
    self._delegate = nil;

    self._updateCellCallback = nil;
    self._updateNumberCellsCallback = nil;
    self._updateCellsSizeCallback = nil;
    self._scrollBeganCallback = nil;
    self._scorllEndedCallback = nil;
    self._scrollInScrollCallback = nil;
    self._lastScrollTime = 0;
    self._lastScrollIndex = 0;
    self._curentScrollIndex = 100
    self._delayEnd = 1;
    self._isEnableScrollCallback = isEnableScrollCallback
    

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end
-- 析构函数
function TableView:dtor()
    TableView.super.dtor(self)
    -- print("TableView 析够")
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end
function TableView:update(dt)
    if self._isScrolling then
        if self._curentScrollIndex == self._lastScrollIndex then
            self._lastScrollTime = self._lastScrollTime + dt
            if self._lastScrollTime >= self._delayEnd then
                if self._scorllEndedCallback then
                    self._scorllEndedCallback(self._tableView)
                end
                self._isScrolling = false;
                self._lastScrollIndex = 0;
                self._lastScrollTime = 0
                self._curentScrollIndex = 100
            end
        else
            self._curentScrollIndex = self._lastScrollIndex
        end
    end
end
-- 设置滚动模式
function TableView:setScrollType(scrollType)
    assert(type(scrollType) == "number", "TableView setScrollType: scroll type is invalid.")

    self._scrollType = scrollType
end
-- public:
-- 初始化
function TableView:init(leftPadding, rightPadding, upPadding, bottomPadding)
    if (leftPadding) then assert(type(leftPadding) == "number", "TableView init: left padding is invalid.") end
    if (rightPadding) then assert(type(rightPadding) == "number", "TableView init: right padding is invalid.") end
    if (upPadding) then assert(type(upPadding) == "number", "TableView init: up padding is invalid.") end
    if (bottomPadding) then assert(type(bottomPadding) == "number", "TableView init: bottom padding is invalid.") end

    self._leftPadding = leftPadding or 0
    self._rightPadding = rightPadding or 0
    self._upPadding = upPadding or 0
    self._bottomPadding = bottomPadding or 0

    TableView.super.init(self)

end




-- 初始化视图
function TableView:onInitView()
    -- 滚动组件
    local viewW, viewH = self:getSize()
    local viewSize = cc.size(viewW, viewH)
    self._tableView = cc.TableView:create(viewSize)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(self._verticalFillOrder)
    self._tableView:setDirection(self._direction)
    self._tableView:setBounceable(self._bounceable)
    -- self._tableView:setTouchEnabled(self._touchEnable)
    -- self._tableView:setSwallowTouches(false)
    -- print("cell = UI.AchievementCell.new()   ", UI.AchievementCell.new())
    self._tableView:registerScriptHandler(handler(self,self.tableCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
    self._tableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    self._tableView:registerScriptHandler(handler(self,self.cellSizeForTable), cc.TABLECELL_SIZE_FOR_INDEX)
    if (self._isEnableScrollCallback) then
        self._tableView:registerScriptHandler(handler(self,self.scrollViewDidScroll), cc.SCROLLVIEW_SCRIPT_SCROLL)
    end
    self._tableView:registerScriptHandler(handler(self,self.tableCellTouched), cc.TABLECELL_TOUCHED)
    self._tableView:registerScriptHandler(handler(self,self.tableCellHighLight), cc.TABLECELL_HIGH_LIGHT)
    self._tableView:registerScriptHandler(handler(self,self.tableCellUnHighLight), cc.TABLECELL_UNHIGH_LIGHT)
    self._tableView:registerScriptHandler(handler(self,self.tableCellRecycle),cc.TABLECELL_WILL_RECYCLE)
    self:addChild(self._tableView)
    self:setScrollBarEnabled(false)

end
-- 正在滑动的监听
function TableView:onScroll(callback)
    self._scrollInScrollCallback = callback;
end
-- 开始滑动的监听
function TableView:onStartScroll(callback)
    self._scrollBeganCallback = callback;
end
-- 设置延迟滑动回调
function TableView:setDelayScrollEndCallback(e)
    self._delayEnd = e
end
-- 结束滑动的监听 延迟调用(self._delayEnd 控制)
function TableView:onEndScroll(callback)
    self._scorllEndedCallback = callback;
end
-- 更新所有条目
function TableView:onUpdateCells(callback)
    self._updateCellCallback = callback
end
-- 更新条目数量
function TableView:onUpdateCellNumbers(callback)
    self._updateNumberCellsCallback = callback
end
-- 更新条目大小
function TableView:onUpdateCellSize(callback)
    self._updateCellsSizeCallback = callback
end

function TableView:onTableCellTouched(callback)
    self._tableCellTouchedCallback = callback
end

function TableView:onTableCellHighLight(callback)
    self._tableCellHighLightCallback = callback
end

function TableView:onTableCellUnHighLight(callback)
    self._tableCellUnHighLightCallback = callback
end

function TableView:onTableCellRecycle(callback)
    self._tableCellRecycleCallback = callback
end



----------------------------------------[[私有方法start]]----------------------------------------
function TableView:cellSizeForTable(table,idx)
    if self._updateCellsSizeCallback then
        return self._updateCellsSizeCallback(table,idx)
    end
    return 0,0
end

function TableView:tableCellTouched(table,cell)
    if self._tableCellTouchedCallback then
        self._tableCellTouchedCallback(table, cell)
    end 
end

function TableView:tableCellHighLight(table,cell)
    if self._tableCellHighLightCallback then
        self._tableCellHighLightCallback(table, cell)
    end 
end

function TableView:tableCellUnHighLight(table,cell)
    if self._tableCellUnHighLightCallback then
        self._tableCellUnHighLightCallback(table, cell)
    end 
end

function TableView:tableCellRecycle(table,cell)
    if self._tableCellRecycleCallback then
        self._tableCellRecycleCallback(table, cell)
    end 
end

function TableView:scrollViewDidScroll()
    -- print("grids, width, height, withShape")
    local container = self._tableView:getContainer()
    local viewSize = self._tableView:getViewSize()
    local currentPostion = cc.p(container:getPositionX(),container:getPositionY())
    local containerSize = container:getContentSize()
    local innerNodeWidth, innerNodeHeight = containerSize.width,containerSize.height

    -- 计算滚动相关数据
    local posX, posY = 0.0, 0.0
    local percent = 0.0
    local direction = self._tableView:getDirection()
    if (direction == cc.SCROLLVIEW_DIRECTION_VERTICAL) then
        -- print("竖着")
        local visibleContentHeight = innerNodeHeight - viewSize.height 
        if (visibleContentHeight < 0) then visibleContentHeight = 0
        end
        posY = currentPostion.y
        if (posY > 0) then posY = 0
        elseif (math.abs(posY) > visibleContentHeight) then posY = visibleContentHeight
        end

        if (visibleContentHeight == 0) then percent = 0
        else percent = 1.0 - math.abs(posY) / visibleContentHeight
        end
    elseif (direction == cc.SCROLLVIEW_DIRECTION_HORIZONTAL) then
        -- print("横着")
        local visibleContentWidth = innerNodeWidth - viewSize.width 
        if (visibleContentWidth < 0) then visibleContentWidth = 0
        end
        posX = currentPostion.x
        if (posX > 0) then posX = 0
        elseif (math.abs(posX) > visibleContentWidth) then posX = visibleContentWidth
        end

        if (visibleContentWidth == 0) then 
            percent = 0
        else 
            percent = 1.0 - math.abs(posX) / visibleContentWidth
        end     
    end
    -- print("self._isScrolling ",self._isScrolling)
    if (not self._isScrolling) then  
        self._isScrolling = true
        if self._scrollBeganCallback then
            self._scrollBeganCallback(self._tableView);
        end
    else
        if self._scrollInScrollCallback then
            self._scrollInScrollCallback(self._tableView,percent)
        end
    end
    self._curentScrollIndex = self._curentScrollIndex + 1;
    -- self._lastScrollTime = os.time()
end
function TableView:numberOfCellsInTableView()
    if self._updateNumberCellsCallback then
        return self._updateNumberCellsCallback()
    end
    return 0
end
function TableView:tableCellAtIndex(table, idx)
    if self._updateCellCallback then
        return self._updateCellCallback(table, idx)
    end
    return table:dequeueCell();
end

----------------------------------------[[私有方法end]]----------------------------------------
-- 更新视图
function TableView:onUpdateView(data)
    -- 计算滚动视图的尺寸
    self._tableViewWidth = self._width - (self._leftPadding + self._rightPadding)
    self._tableViewHeight = self._height - (self._upPadding + self._bottomPadding)

    -- 设置滚动视图的位置和尺寸
    self._tableView:setPosition(self._leftPadding, self._bottomPadding)
    self._tableView:setViewSize(cc.size(self._tableViewWidth, self._tableViewHeight))

    -- 修复滚动控件的问题
    self._isScrolling = false
    -- self:dispatchEvent(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self)
    if self._scorllEndedCallback then
        self._scorllEndedCallback(self._tableView)
    end
end
function TableView:setDelegate(delegate)
    self._delegate = delegate
end
function TableView:setVerticalFillOrder(fillOrder)
     self._verticalFillOrder = fillOrder
end
function TableView:getVerticleFillOrder()
    return self._verticalFillOrder
end
function TableView:setDirection(direction)
    -- self._tableView:setDirection(direction)
    self._direction = direction
end
function TableView:getDirection()
    return self._direction
end
function TableView:setBounceable(enabled)
    -- self._tableView:setBounceable(enabled)
    self._bounceable = enabled
end
function TableView:getBounceable()
    return self._bounceable
end
-- function TableView:setTouchEnable(enabled)
--     -- self._tableView:setTouchEnabled(enabled)
--     self._touchEnable = enabled
-- end
--[[
	重新加载表格数据
	
	ignoreOffset:	是否忽略旧位置(默认:不忽略)
]]
function TableView:reloadData(ignoreOffset, isAction, actInitTime, actAddTime)
	if "boolean" ~= type(ignoreOffset) then
		ignoreOffset = false
	end

	local oldOffset = self._tableView:getContentOffset()
	if actInitTime ~= nil and actAddTime ~= nil then
	    self._tableView:reloadData(isAction, actInitTime, actAddTime)
    else
        self._tableView:reloadData(isAction)
    end
	
	if false == ignoreOffset and oldOffset.y <= 0 then
		if self.oldContentSize.height ~= self._tableView:getContentSize().height  then
		   
            oldOffset.y = oldOffset.y - (self._tableView:getContentSize().height - self.oldContentSize.height)
            oldOffset.x = oldOffset.x - (self._tableView:getContentSize().width - self.oldContentSize.width)
        end
        self._tableView:setContentOffset(oldOffset, false) 
        self:fixContentOffset()
	end
	
	self.oldContentSize = cc.size(self._tableView:getContentSize().width, self._tableView:getContentSize().height)
end

function TableView:removeCellAtIndexAndPlayAction(idx, actTimeMultiple)
    if actTimeMultiple ~= nil then
        self._tableView:removeCellAtIndexAndPlayAction(idx, actTimeMultiple)
    else
        self._tableView:removeCellAtIndexAndPlayAction(idx, actTimeMultiple)
    end
end

function TableView:isActionRunning()
    return self._tableView:isActionRunning()
end

function TableView:reload(ignoreOffset, isAction, actInitTime, actAddTime)
    self:reloadData(ignoreOffset, isAction, actInitTime, actAddTime)
    -- body
end
function TableView:scrollToTop()
	self._tableView:setContentOffset(cc.p(self._tableView:getContentOffset().x, 0 - (self._tableView:getContentSize().height - self._tableView:getViewSize().height)));
end

function TableView:scrollToBottom()
	-- print("self:getContentSize().height",self:getContentSize().height)
	if self._tableView:getContentSize().height >=  self._tableView:getViewSize().height then
		self._tableView:setContentOffset(cc.p(self._tableView:getContentOffset().x, 0));
	end
end

function TableView:scrollToLeft()
    print("scrollToLeft",self._tableView:getContentSize().width - self._tableView:getViewSize().width)
    self._tableView:setContentOffset(cc.p(0, self._tableView:getContentOffset().y));
end

-- 滑动到指定index的cell处，passNum是额外继续往后滑动的格子数，showMove为true则会动态滑动过去
function TableView:scrollToCell(index, passNum, showMove)
    local passNum = passNum or 0
    local scrollPos = self._tableView:getContentOffset()
    local cellSize = cc.size(0, 0)
    cellSize.width, cellSize.height = self:cellSizeForTable()
    local direction = self._tableView:getDirection()
    if direction == cc.SCROLLVIEW_DIRECTION_VERTICAL then
        -- 格子总数
        local totalNum = self:numberOfCellsInTableView()
        local scrollIndex = totalNum - index + 1 - passNum
        scrollPos.y = -((scrollIndex - 1) * cellSize.height)

        -- 额外滑动触底以后不再多余滑动
        local bottomScrollPos = 0
        scrollPos.y = scrollPos.y > bottomScrollPos and bottomScrollPos or scrollPos.y

        -- 滑动顶置的时候不再多余滑动
        local topScrollPos = 0 - (self._tableView:getContentSize().height - self._tableView:getViewSize().height)
        scrollPos.y = scrollPos.y < topScrollPos and topScrollPos or scrollPos.y
    else
        local scrollIndex = index
        scrollPos.x = -((scrollIndex - 1) * cellSize.width)

        -- 额外滑动触左以后不再多余滑动
        local leftScrollPos = 0
        scrollPos.x = scrollPos.x > leftScrollPos and leftScrollPos or scrollPos.x

        -- 滑动顶置的时候不再多余滑动
        local rightScrollPos = 0 - (self._tableView:getContentSize().width - self._tableView:getViewSize().width)
        scrollPos.x = scrollPos.x < rightScrollPos and rightScrollPos or scrollPos.x
    end
    self._tableView:setContentOffset(scrollPos, showMove)
end

function TableView:fixContentOffset()
    self._tableView:setContentOffset(self:getFixContentOffset(), false)
end

function TableView:getFixContentOffset()
    local _point = self._tableView:getContentOffset()
    -- top
    _point.y = math.max(self._tableView:getViewSize().height - self._tableView:getContentSize().height, _point.y)
    -- bottom
    _point.y = math.min(math.max(0, self._tableView:getViewSize().height - self._tableView:getContentSize().height), _point.y)

    -- print(">>1", _point.x, _point.y, self._tableView:getViewSize().width, self._tableView:getContentSize().width)
    -- left
    _point.x = math.max(self._tableView:getViewSize().width - math.max(self._tableView:getContentSize().width, self._tableView:getViewSize().width), _point.x)
    -- print(">>2", _point.x, _point.y, self._tableView:getViewSize().width, self._tableView:getContentSize().width)
    -- right
    _point.x = math.min(math.max(0, self._tableView:getViewSize().width - self._tableView:getContentSize().width), _point.x)
    -- print(">>3", _point.x, _point.y, self._tableView:getViewSize().width, self._tableView:getContentSize().width)
    return _point
end

function TableView:scrollRectToVisible( rect, duration )
	self:scrollRectToVisible_( rect, duration)
end

function TableView:scrollRectToCenter( rect, duration )
    return self:scrollRectToCenter_( rect, duration)
end

function TableView:scrollRectToTop( rect, duration )
    return self:scrollRectToTop_(rect, duration)
end


-- 滚动试图到最顶部
function TableView:scrollRectToTop_(rect, duration )
    if "number" ~= type(duration) then
        duration = .0
    end
    
    local x = rect.origin.x 
    local y = rect.origin.y 
    
    local dx = self._tableView:getViewSize().width - x
    local dy = self._tableView:getViewSize().height - y
    
    if dx >= 0 then
        dx = 0
    end

    if dy >= 0 then
        dy = 0
    end

    local _newOffset = ccp(dx ,dy)

    if duration <= .0 then
        self._tableView:setContentOffset(_newOffset)
    else
        self._tableView:setContentOffsetInDuration(_newOffset, duration)
    end

    self:fixContentOffset()
end

-- 
function TableView:scrollRectToCenter_( rect, duration )
    if "number" ~= type(duration) then
        duration = .0
    end
    
    local dx = rect.origin.x + rect.size.width / 2.0
    local dy = rect.origin.y + rect.size.height / 2.0

    local _newOffset = cc.p(0 - dx + self._tableView:getViewSize().width / 2.0, 0 - dy + self._tableView:getViewSize().height / 2.0)

    if duration <= .0 then
        self._tableView:setContentOffset(_newOffset)
    else
        self._tableView:setContentOffsetInDuration(_newOffset, duration);
    end

    self:fixContentOffset()
end

function TableView:setContentOffset(offset)
    offset.x = offset.x > 0 and 0 or offset.x
    offset.x = offset.x < (self._tableView:getViewSize().width - self._tableView:getContentSize().width) and (self._tableView:getViewSize().width - self._tableView:getContentSize().width) or offset.x
    self._tableView:setContentOffset(offset)
end

function TableView:getContentOffset()
    return self._tableView:getContentOffset()
end

function TableView:setContentOffsetInDuration(offset, duration)
    offset.x = offset.x > 0 and 0 or offset.x
    offset.x = offset.x < (self._tableView:getViewSize().width - self._tableView:getContentSize().width) and (self._tableView:getViewSize().width - self._tableView:getContentSize().width) or offset.x
    self._tableView:setContentOffsetInDuration(offset, duration)
end

--[[
    滚动视图以显示指定区域

    rect:       要显示的区域
    duration:   动画时长(默认不需要动画)
]]
function TableView:scrollRectToVisible_( rect, duration )
    if "number" ~= type(duration) then
        duration = .0
    end
    
    local _newOffset = self._tableView:getContentOffset()
    
    -- 竖向
    local _y1 = rect.origin.y          -- 下一边
    local _y2 = _y1 + rect.size.height -- 下二边
    
    if _y1 >= -_newOffset.y and _y2 <= -_newOffset.y + self._tableView:getViewSize().height then
        -- current visible.
    else
        local _uh = self._tableView:getContentSize().height - rect.origin.y - rect.size.height -- 上面余
        local _noy = - (self._tableView:getContentSize().height - self._tableView:getViewSize().height) + _uh
        
        _newOffset = cc.p(_newOffset.x, _noy)
    end
    
    -- 横向
    local _x1 = rect.origin.x               -- L
    local _x2 = _x1 + rect.size.width       -- R
    
    if _x1 >= -_newOffset.x and _x2 <= -_newOffset.x + self._tableView:getViewSize().width then
        -- current visible.
    else
        local _uw = self._tableView:getContentSize().width - rect.origin.x - rect.size.width -- 左边余
        local _nox = -(self._tableView:getContentSize().width - self._tableView:getViewSize().width) + _uw
        
        _newOffset = cc.p(_nox, _newOffset.y)
    end
    
    -- top
    _newOffset.y = math.max(self._tableView:getViewSize().height - self._tableView:getContentSize().height, _newOffset.y)
    -- bottom
    -- _newOffset.y = math.min(0, _newOffset.y)
    _newOffset.y = math.min(math.max(0, self._tableView:getViewSize().height - self._tableView:getContentSize().height), _newOffset.y)

    -- right
    _newOffset.x = math.max(self._tableView:getViewSize().width - self._tableView:getContentSize().width, _newOffset.x)
    -- left
    _newOffset.x = math.min(0, _newOffset.x)
    
    if duration <= .0 then
        self._tableView:setContentOffset(_newOffset)
    else
        self._tableView:setContentOffsetInDuration(_newOffset, duration);
    end
end

function TableView:getViewSize()
    return self._tableView:getViewSize()
end

function TableView:updateCellAtIndex(idx)
    self._tableView:updateCellAtIndex(idx)
end

function TableView:setScrollBarEnabled(enabled)
    self._tableView:setScrollBarEnabled(enabled)
end

function TableView:setScrollBarColor(color)
    self._tableView:setScrollBarColor(color)
end

function TableView:setScrollBarWidth(width)
    self._tableView:setScrollBarWidth(width)
end

function TableView:setCircleVisible(b)
    self._tableView:setCircleVisible(b)
end

function TableView:stopScrolling()
    self._tableView:stopScrolling()
end

function TableView:getInnerNodeSize()
    local container = self._tableView:getContainer()
    local containerSize = container:getContentSize()
    return containerSize.width, containerSize.height
end