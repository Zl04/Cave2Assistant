UI = UI or {}

require "app.datas.GoodsDataManager"
local RewardPreViewUtil = class("RewardPreViewUtil", UI.HWBtnComponent)
UI.RewardPreViewUtil = RewardPreViewUtil

RewardPreViewUtil.TipPosType = {
    left = 1,
    right = 2,
    up = 3,
    bottom = 4,
    center = 5,
    both = 6
}

local COM_RES_LIST = {
    "ui_town_petschallenge.plist",
}

function RewardPreViewUtil:ctor()
    --窗口大小
    RewardPreViewUtil.super.ctor(self, -1, {}, 0, 0)
    self:centerRight(0)
    self.posType = RewardPreViewUtil.TipPosType.both
    self.leftOffset = cc.p(0, 0)
    self.rightOffset = cc.p(0, 0)
end

--虚构函数,destroy时调用(必备)
function RewardPreViewUtil:dtor()
    RewardPreViewUtil.super.dtor(self)
    reload_script_file_mvc("app.utils.RewardPreViewUtil")
end

-- 初始化(必备)
function RewardPreViewUtil:init(dataList, column, maxFixRow, direction, sizeOffset, isRemoveDuplicates, paddingOffset, swallowTouches, notSort)
    self.direction = direction or UI.ScrollType.VERTICAL
    self.isRemoveDuplicates = isRemoveDuplicates
    self.sizeOffset = sizeOffset or cc.size(0, 0)
    self.paddingOffset = paddingOffset or cc.size(0, 0)
    self.goodsDataList = {}
    self:addGoodsDataList(dataList);
    self.column = column or 1
    self.maxFixRow = maxFixRow or 2
    self.swallowTouches = swallowTouches == nil and true or false
    -- self.bounceable = true
    -- self.touchEnabled = true
    self.notSort = notSort
    RewardPreViewUtil.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function RewardPreViewUtil:onInitView()
    if #self.goodsDataList > 0 then
        self:showGoodsView()
    end
end

function RewardPreViewUtil:addGoodsId(id, count, isChaos)
    local data = GoodsDataManager:createLocalGoodsData(id)
    local masterData = RoleDataManager:getMaster()
    local roleLv = masterData:getLevel()
    if (data) then
        if isChaos then
            data.goodsRare = data.randomGoodsRare
            data.equipRequireLV = roleLv

            local levelLimiteList = string.split(data.equipRequireLvIntervals, ";")
            if #levelLimiteList > 3 then
                local lvStrList = levelLimiteList[#levelLimiteList - 2]
                local levelMMLimite = string.split(lvStrList, ",")

                local minLevel = tonumber(levelMMLimite[1])
                local maxLevel = tonumber(levelMMLimite[2])

                if data.equipRequireLV < minLevel then
                    data.equipRequireLV = minLevel
                elseif data.equipRequireLV > maxLevel then
                    data.equipRequireLV = maxLevel
                end

            end
        end
        self:addGoodsData(data, count)
    end
end

-- function RewardPreViewUtil:setBounceable(b)
--     self.bounceable = b
--     if self._titleTableView then
--         self._titleTableView:setBounceable(self.bounceable)
--     end
-- end

-- function RewardPreViewUtil:setTouchEnabled(b)
--     self.touchEnabled = b
--     if self._titleTableView then
--         self._titleTableView:setTouchEnabled(self.touchEnabled)
--     end
-- end

function RewardPreViewUtil:addGoodsData(data, count)
    local goodsCount = count or 0
    data:setNum(count)
    data:setIsNew(false)
    table.insert(self.goodsDataList, data)
end

function RewardPreViewUtil:addGoodsDataList(dataList)
    if dataList then
        for k, v in pairs(dataList) do
            self:addGoodsData(v)
        end
    end
end

function RewardPreViewUtil:cleanData()
    self.goodsDataList = {}
end

--[[排序规则 1:武器在前 2：品质最高到底 ]]
function RewardPreViewUtil:sortData()
    table.sort( self.goodsDataList, function( a, b )
        if a.isTeam and not b.isTeam then
            return true
        end
        if not a.isTeam and b.isTeam then
            return false
        end
        
        if a.goodsRare == b.goodsRare then
            return a:getGoodsType() < b:getGoodsType()
        else 
            return a.goodsRare > b.goodsRare
        end
    end)
end

--去重
function RewardPreViewUtil:removeDuplicates()
    local temp = {}
    for k, v in ipairs(self.goodsDataList) do
        local isHave = false
        for k2, v2 in ipairs(temp) do
            if v2:getGoodsID() == v:getGoodsID() then
                isHave = true
                break
            end
        end
        if not isHave then
            table.insert(temp, v) 
        end
    end
    self.goodsDataList = temp
end


function RewardPreViewUtil:showGoodsView()
    self.allGridNode = {}
    self:removeAllChildren();
    if self.isRemoveDuplicates then
        self:removeDuplicates()
    end
    if not self.notSort then
        self:sortData()
    end
    local itemPaddingX = 80 + self.paddingOffset.width
    local itemPaddingY = 80 + self.paddingOffset.height
    local size = table.nums(self.goodsDataList)
    local direction = self.direction
    -- if size < self.maxFixRow * self.column and direction == UI.ScrollType.HORIZONTAL then
    --     direction = UI.ScrollType.VERTICAL
    -- end

    local row = self.maxFixRow
    local nodeHeight = 0
    local nodeWidth = 0

    local upLayout = UI.TouchLayout:create()
    upLayout:init(0, 0, 0, 0)
    upLayout:addTouchEvents(self)
    --upLayout:enableDebugDraw()

    if direction == UI.ScrollType.VERTICAL then
        local width = 0
        row = math.ceil(size / self.column)
        if row > 1 then
            width = self.column * itemPaddingX
        else
            width = size % self.column
            width = (width == 0) and self.column or width
            width = width * itemPaddingY
        end
        local height = row * itemPaddingY

        nodeWidth = width
        nodeHeight = height
        if row > self.maxFixRow then
            nodeHeight = self.maxFixRow * itemPaddingY
        end
        upLayout:setSize(width, height)
        --upLayout:centerUp(0)
    else
        local width = math.ceil(size / self.maxFixRow) * itemPaddingX
        local height = self.maxFixRow * itemPaddingY
        nodeHeight = height
        nodeWidth = self.column * itemPaddingX
        upLayout:setSize(width, height)

        if math.ceil(size / self.maxFixRow) > self.column then
            nodeWidth = nodeWidth - self.paddingOffset.width
            nodeHeight = nodeHeight
        end
    end

    self:setSize(nodeWidth, nodeHeight)

    local beginPosX = -8
    local index = 1
    local xPos = 0

    if row > self.maxFixRow or direction == UI.ScrollType.HORIZONTAL then
        self._titleTableView = UI.TableView:create({}, nodeWidth, nodeHeight, true)
        self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
        self._titleTableView:leftUp(0, 0)
        self._titleTableView:setDelegate()
        self._titleTableView:setBounceable(true)
        -- self._titleTableView:setTouchEnable(self.touchEnabled)
        self._titleTableView:setOpacityModifyRGB(true)
        self._titleTableView:init()
        self._titleTableView:onUpdateCellSize(function (table,idx)
            return itemPaddingX, itemPaddingY
        end)

        self._titleTableView:onUpdateCells(function (table, idx)
            -- 获取缓存的格子, 如果没有, 就新建
            local reusedCell = table:dequeueCell()
            if (not reusedCell) then
                reusedCell = UI.TableViewCell:create()
                xpcall(function()
                    local goodGrid = UI.GoodsGrid:create()
                    goodGrid:init(goodData)
                    goodGrid:leftBottom((itemPaddingX- goodGrid:getContentSize().width)/2, (itemPaddingY - goodGrid:getContentSize().height)/2)
                    goodGrid:hideFlagIcon()
                    goodGrid:showInfoArea(true, false)
                    reusedCell:addChild(goodGrid)
                    goodGrid:setName("cellView")
                    goodGrid:setData(self.goodsDataList[idx + 1])
                    goodGrid:updateView()
                    goodGrid:setTouchClipNode(self.touchClipNode)
                    goodGrid:setSwallowTouches(false)

                    if self.goodsDataList[idx + 1] and self.goodsDataList[idx + 1].isTeam then
                        local teamSign  = UI.Image:create()
                        teamSign:init("ui_petschallenge_btn_label.png")
                        teamSign:rightUp(-3, -3)
                        teamSign:setName("teamSign")
                        goodGrid:addChild(teamSign, 30)
                        -- goodGrid:enableDebugDraw()
                    end
                end,
                function(e) 
                    printError("------------------------RewardPreViewUtil:tableCellAtIndex-----------------error", e)
                end, 1);
            else 
                local cellView = reusedCell:getChildByName("cellView")
                if (cellView) then
                    local teamSign = cellView:getChildByName("teamSign")
                    if teamSign then
                        teamSign:removeFromParent(true)
                        teamSign = nil
                    end
                    if self.goodsDataList[idx + 1] and self.goodsDataList[idx + 1].isTeam then
                        local teamSign  = UI.Image:create()
                        teamSign:init("ui_petschallenge_btn_label.png")
                        teamSign:rightUp(-3, -3)
                        teamSign:setName("teamSign")
                        cellView:addChild(teamSign, 30)
                    end
                    cellView:setData(self.goodsDataList[idx + 1])
                    cellView:updateView()
                end
            end

            return reusedCell
        end)

        self._titleTableView:onUpdateCellNumbers(function ()
            return #self.goodsDataList
        end)

        self._titleTableView:onTableCellTouched(function(table, cell)
            
        end)
        -- 载入数据
        self._titleTableView:reloadData()
        self._titleTableView:fixContentOffset()
        self._titleTableView:setTouchClipNode(self.touchClipNode)
        self:addChild(self._titleTableView, 0)
    else
        upLayout:centerUp(0)
        self:addChild(upLayout)
    end
    --upLayout:enableDebugDraw()
end

function RewardPreViewUtil:setTipOffset(leftOffset, rightOffset)
    self.leftOffset = leftOffset or cc.p(0, 0)
    self.rightOffset = rightOffset or cc.p(0, 0)
end

function RewardPreViewUtil:setShowTipPosType(type)
    self.posType = type
end

function RewardPreViewUtil:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
            self.selectIndex = k
            break
        end
    end
end

function RewardPreViewUtil:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end

    if not self:checkTouch(touch) then
        return;
    end
    --Avalon.AudioManager:playSound("1503")

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local pInfoArea = value:onShowInfoAreaHandler(true)
            if pInfoArea then
                if self.posType == RewardPreViewUtil.TipPosType.left then
                    pInfoArea:centerLeft(self.leftOffset.x - pInfoArea:getContentSize().width)
                elseif self.posType == RewardPreViewUtil.TipPosType.right then
                    pInfoArea:centerRight(self.rightOffset.x - pInfoArea:getContentSize().width)
                elseif self.posType == RewardPreViewUtil.TipPosType.up then
                    pInfoArea:center()
                elseif self.posType == RewardPreViewUtil.TipPosType.bottom then
                    pInfoArea:center()
                elseif self.posType == RewardPreViewUtil.TipPosType.center then
                    pInfoArea:center()
                else
                    local mode = self.selectIndex % self.column
                    mode = mode == 0 and self.column or mode
                    if mode < self.column / 2 then
                        pInfoArea:centerRight(self.rightOffset.x - pInfoArea:getContentSize().width)
                    else
                        pInfoArea:centerLeft(self.leftOffset.x - pInfoArea:getContentSize().width)
                    end
                end
            end
            break
        end
    end
end

return RewardPreViewUtil