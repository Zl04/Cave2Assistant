--[[
    UI - 角色展示区域
]]--

require "app.ui.Component"
require "app.ui.common.TableView.TableView"
require "app.ui.common.TableView.TableViewCell"
require "app.datas.TitleDataManager"
require "app.datas.RoleDataManager"

local LanguageManager = require "app.game.LanguageManager"

UI = UI or {}

local TitleSelectLayer = class("TitleSelectLayer", UI.HWBtnComponent)
UI.TitleSelectLayer = TitleSelectLayer

-- 私有变量
local DEBUG = false
local DEBUG_DRAW = false



local COM_RES_LIST = {
    "ui_general_title.plist",
}

-- 构造函数
function TitleSelectLayer:ctor()
    TitleSelectLayer.super.ctor(self, nil, COM_RES_LIST)
    TitleDataManager:updateDisplayTitle()
    self._titleDataArray = TitleDataManager:getDisplayTitleArray()
    self._titleTableView = nil
    self._selectedTitleID = nil
    self._selectedCellIndex = 0
    self._cellSelectedHeight = nil
end

-- 析构函数
function TitleSelectLayer:dtor()
end


-- 公共:
-- 初始化
function TitleSelectLayer:init()
    TitleSelectLayer.super.init(self)
end

-- 初始化视图
function TitleSelectLayer:onInitView()
    printInfo("TitleSelectLayer:onInitView, 正在通过称号列表创建选择器, 称号数量: ", #self._titleDataArray)

    if (self._titleDataArray == nil) then self._titleDataArray = {} end

    local numCells = #self._titleDataArray + 1
    if (numCells < 7) then numCells = 7 end
    local bgTopOffset = 25
    local bgBottomOffset = 10
    local bgWidthOffset = 40
    local bgWidth = 306
    local listHeightMax = 424 - bgTopOffset - bgBottomOffset
    -- local listHeightMax = 100 - bgTopOffset - bgBottomOffset


    local listWidth = 306 - bgWidthOffset
    local cellPaddingTop = 5
    local cellPaddingBottom = 5 
    local cellHeight = 40 + 5 + 5
    local cellSelectedHeight = cellHeight
    -- 设置列表高度根据内容个数变化
    -- local listHeight = cellHeight * numCells
    -- if (listHeight > listHeightMax) then listHeight = listHeightMax end
    -- 目前默认设置列表高度为最大值
    local listHeight = listHeightMax


    -- 列表背景
    local listBg = UI.Image9:create()
    listBg:init("ui_scale9image_banner_title.png", CCRectMake(0,0,1,1), cc.size(bgWidth, listHeight + bgTopOffset + bgBottomOffset))
    listBg:centerUp(-30)
    listBg:setTouchEnable(true)
    listBg:setInterceptTouches(true)
    listBg:setSwallowTouches(true)
    -- listBg:setOpacity(230)
    listBg:setOpacity(0)
    listBg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        if (self._closeCallback) then self._closeCallback(self._selectedTitleID) end
        self:runAction(cc.Sequence:create(cc.FadeOut:create(0.1), cc.CallFunc:create(function() self:removeFromParent() end)))
    end)
    self:addChild(listBg)

    -- 称号列表本身
    self._titleTableView = UI.TableView:create({}, listWidth, listHeight)
    self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._titleTableView:centerUp(bgTopOffset)
    self._titleTableView:setDelegate()
    self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._titleTableView:setBounceable(true)
    self._titleTableView:setOpacityModifyRGB(true)
    self._titleTableView:init()
    self._titleTableView:onUpdateCellSize(function (table,idx)
        if (idx == self._selectedCellIndex --[[and idx ~= 0]]) then
            return listWidth, self._cellSelectedHeight
        else
            return listWidth, cellHeight
        end
    end) 

    self._titleTableView:onUpdateCells(function (table, idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if reusedCell then
            reusedCell:removeAllChildren()
            reusedCell:removeFromParent()
            reusedCell = nil
        end
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
        end

        -- 获取称号信息, idx = 0为卸下称号
        local titleText = "DEADBEEF"
        local endTimeText = ""
        local titleColor = UI.FONT_COLOR_WHITE
        local descriptionText = ""
        local isShowIcon = false
        if (idx == 0) then
            titleText = UI.TEXT_1172019 -- 无称号
            titleColor = UI.FONT_COLOR_155_155_155
            descriptionText = LanguageManager:getInstance():getLocalString(1111450)
        else
            local titleData = self._titleDataArray[idx]
            if (not titleData) then 
                titleText = ""
                -- printWarn("TitleSelectLayer:onInitView(), 称号数据错误, idx = ", idx)
            else
                titleText = "<" .. titleData:getTitleName() .. ">"
                titleColor = titleData:getTitleColor()
                descriptionText = titleData:getTitleDescription()
                isShowIcon = titleData:getTitleFunctionType() == 51

                if titleData:getEndTime() ~= nil then
                    local time = titleData:getEndTime() - GameManager:getNormalServerTime()
                    if time > 0 then
                        local day = math.floor(time / 86400)
                        time = time - day * 86400
                        local hour = math.floor(time / 3600)

                        endTimeText = string.format(UI.TEXT_223000,day,hour)
                    end
                    -- endTimeText = UI.TEXT_223000 .. GameManager:getClientDateByConfigTimeStr(titleData:getEndTime(), "%m.%d")
                end
            end
        end

        -- 新建或配置未选排版
        local unselectedLayout = reusedCell:getChildByName("unselectedLayout")
        if (not unselectedLayout) then
            unselectedLayout = UI.Layout:create()
            unselectedLayout:init()
            unselectedLayout:setName("unselectedLayout")
            unselectedLayout:leftUp(0, -cellHeight + cellPaddingBottom)
            unselectedLayout:setSize(listWidth, 0)
            -- unselectedLayout:enableAutoHeight()
            reusedCell:addChild(unselectedLayout)

            -- 名称
            local unselectedText = UI.Text:create()
            unselectedText:init(titleText, UI.FONT_BOLD, UI.FONT_SIZE_18PX, titleColor)
            unselectedText:setName("unselectedText")
            unselectedText:floatUp(4)
            unselectedText:setTextHorizontalCenter()
            unselectedLayout:addComponent(unselectedText)

            -- if endTimeText == "" then
            --     unselectedText:floatUp(4)
            -- end
            --截止日期
            -- if endTimeText ~= nil then
                local unselectedEndTimeText = UI.Text:create()
                unselectedEndTimeText:init(endTimeText, UI.FONT_BOLD, 10, {r = 102, g = 173, b = 28})
                unselectedEndTimeText:setName("unselectedEndTimeText")
                unselectedEndTimeText:floatUp(0)
                unselectedEndTimeText:setTextHorizontalCenter()
                unselectedLayout:addComponent(unselectedEndTimeText)

            -- end

            
        else
            local unselectedText = unselectedLayout:getChildByName("unselectedText")
            unselectedText:setText(titleText)
            unselectedText:setFontColor(titleColor)

            local unselectedEndTimeText = unselectedLayout:getChildByName("unselectedEndTimeText")
            if unselectedEndTimeText ~= nil and endTimeText ~= "" then
                unselectedEndTimeText:setText(endTimeText)
            end
        end

        -- 新建或配置已选排版
        local selectedLayout = reusedCell:getChildByName("selectedLayout")
        if (not selectedLayout) then
            selectedLayout = UI.Layout:create()
            selectedLayout:init()
            selectedLayout:setName("selectedLayout")
            selectedLayout:setSize(listWidth, 0)
            selectedLayout:enableAutoHeight()
            reusedCell:addChild(selectedLayout)

            -- 名称背景
            local selectedBg = UI.Image:create()
            selectedBg:init("ui_title_btn_1.png")
            selectedBg:setName("selectedBg")
            selectedBg:floatUp(0)
            selectedLayout:addComponent(selectedBg)

            -- 左边小点
            local dot = UI.Image:create()
            dot:init("ui_title_btn_2.png")
            dot:setName("dot")
            dot:centerLeft(-55)
            selectedBg:addChild(dot)

            -- 右边小点
            local dot = UI.Image:create()
            dot:init("ui_title_btn_2.png")
            dot:setName("dot")
            dot:centerRight(-55)
            selectedBg:addChild(dot)

            -- 名称布局
            local titleLayout = UI.Layout:create()
            titleLayout:init()
            titleLayout:setName("titleLayout")
            titleLayout:enableAutoWidth()
            titleLayout:enableAutoHeight()
            titleLayout:center()
            selectedBg:addChild(titleLayout)
            
            -- ICON
            local titleIcon = UI.Image:create()
            titleIcon:init("ui_information_mentor.png")
            titleIcon:setName("titleIcon")
            titleIcon:floatLeft(0)
            titleIcon:setVisible(isShowIcon)
            titleLayout:addComponent(titleIcon)

            -- 名称
            local selectedText = UI.Text:create()
            selectedText:init(titleText, UI.FONT_BOLD, UI.FONT_SIZE_18PX, titleColor)
            selectedText:setName("selectedText")
            selectedText:setTextHorizontalCenter()
            selectedText:floatLeft(0)
            titleLayout:addComponent(selectedText)
            -- selectedText:center()
            -- selectedBg:addChild(selectedText)

            --截止日期
            -- if endTimeText ~= nil then
                local selectedEndTimeText = UI.Text:create()
                selectedEndTimeText:init(endTimeText, UI.FONT_BOLD, UI.FONT_SIZE_12PX, {r = 102, g = 173, b = 28})
                selectedEndTimeText:setName("selectedEndTimeText")
                selectedEndTimeText:centerBottom(-4)
                selectedEndTimeText:setTextHorizontalCenter()
                selectedLayout:addChild(selectedEndTimeText)
            -- end
            

            -- 说明
            local selectedDescription = UI.Text:create()
            selectedDescription:init(descriptionText, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
            selectedDescription:setName("selectedDescription")
            selectedDescription:setWidth(listWidth)
            selectedDescription:setTextHorizontalCenter()
            selectedDescription:floatUp(2)
            selectedLayout:addComponent(selectedDescription)
            selectedDescription:autoAdapt()
            selectedLayout:updateView()
        else
            local selectedBg = selectedLayout:getChildByName("selectedBg")
            local titleLayout = selectedBg:getChildByName("titleLayout")
            local selectedText = titleLayout:getChildByName("selectedText")
            local titleIcon = titleLayout:getChildByName("titleIcon")
            local selectedEndTimeText = titleLayout:getChildByName("selectedEndTimeText")
            selectedText:setText(titleText)
            selectedText:setFontColor(titleColor)
            if selectedEndTimeText ~= nil and endTimeText ~= "" then
                selectedEndTimeText:setText(endTimeText)
            end
            local selectedDescription = selectedLayout:getChildByName("selectedDescription")
            selectedDescription:setText(descriptionText)
            selectedDescription:autoAdapt()
            titleIcon:setVisible(isShowIcon)
            titleLayout:updateView()
            selectedLayout:updateView()
        end
        local layoutWidth, layoutHeight = selectedLayout:getSize()
        layoutHeight = layoutHeight + cellPaddingTop + cellPaddingBottom
        selectedLayout:leftUp(0, -layoutHeight + cellPaddingBottom)

        -- 分割线
        local splitterWidth = listWidth
        local splitter = reusedCell:getChildByName("splitter")
        if (not splitter) then
            local splitter = UI.Image9:create()
            splitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(splitterWidth, 1))
            splitter:setName("splitter")
            splitter:leftBottom((listWidth - splitterWidth) / 2, 0)
            reusedCell:addChild(splitter)
        end
        

        -- 更新选中和未选中的排版显示和隐藏
        if (self._selectedCellIndex == idx--[[ and idx ~= 0]]) then
            selectedLayout:stopAllActions()
            selectedLayout:show()
            selectedLayout:setOpacity(127)
            selectedLayout:runAction(cc.FadeIn:create(0.2))
            unselectedLayout:hide()
        else
            unselectedLayout:show()
            selectedLayout:hide()

            -- 非选中时变暗
            local targetOpacity = 127
            local startOpacity = 127
            if (self._selectedCellIndex == nil) then
                startOpacity = 127
                targetOpacity = 255
            end
            if (self._lastSelectedCellIndex == idx) then
                startOpacity = 255
                targetOpacity = 127
            end
            unselectedLayout:stopAllActions()
            unselectedLayout:setOpacity(startOpacity)
            unselectedLayout:runAction(cc.FadeTo:create(0.2, targetOpacity))
        end

        -- 更新选中单元大小和整体大小
        if (self._selectedCellIndex == idx) then
            self._cellSelectedHeight = layoutHeight

            -- 更新整体大小
            -- if (self._selectedCellIndex == nil) then
            --     self._titleTableView:setSize(listWidth, listHeight)
            --     self._titleTableView:updateView()
            --     listBg:setSize(bgWidth, listHeight + bgTopOffset + bgBottomOffset)
            -- else
            --     local newListHeight = listHeight + self._cellSelectedHeight - cellHeight
            --     self._titleTableView:setSize(listWidth, newListHeight)
            --     self._titleTableView:updateView()
            --     listBg:setSize(bgWidth, newListHeight + bgTopOffset + bgBottomOffset)
            -- end
        end
        
        return reusedCell
    end)

    self._titleTableView:onUpdateCellNumbers(function ()
        return numCells
    end)

    self._titleTableView:onTableCellTouched(function(table, cell)
        local cellIdx = cell:getIdx()
        if (self._selectedCellIndex == cellIdx) then return end
        if (cellIdx > #self._titleDataArray) then return end

        -- 更新选中状态
        self._lastSelectedCellIndex = self._selectedCellIndex
        self._selectedCellIndex = cellIdx
        self._titleTableView:updateCellAtIndex(self._selectedCellIndex)

        -- 称号数据
        if (self._selectedCellIndex == 0) then
            printInfo("TitleSelectLayer 已选取称号名称: 无")
            self._selectedTitleID = 0
        else
            local titleData = self._titleDataArray[self._selectedCellIndex]
            if (titleData) then
                self._selectedTitleID = titleData:getTitleID()
                printInfo("TitleSelectLayer 已选取称号名称:", titleData:getTitleName(), self._selectedTitleID)
                if (self._selectCallback) then self._selectCallback(self._selectedTitleID) end
            end
        end

        -- 重新排版
        self._titleTableView:reload()

        -- 滚动到合适的地方
        local idxFromBot = numCells - self._selectedCellIndex
        self._titleTableView:scrollRectToVisible({origin = {x = 0, y = idxFromBot * cellHeight}, size = {width = 0, height = self._cellSelectedHeight}})
    end)

    -- 初始化选中单元大小
    local master = RoleDataManager:getMaster()
    if (master) then
        for idx, titleData in ipairs(self._titleDataArray) do
            if (titleData:getTitleID() == master:getHeroTitleID()) then
                self._selectedCellIndex = idx
                break
            end
        end
    end
    if (self._selectedCellIndex) then
        local tempCell = self._titleTableView:tableCellAtIndex(self._titleTableView._tableView, self._selectedCellIndex)
        local selectedLayout = tempCell:getChildByName("selectedLayout")
        local selectedlayoutWidth, selectedLayoutHeight = selectedLayout:getSize()
        self._cellSelectedHeight = selectedLayoutHeight + cellPaddingTop + cellPaddingBottom
    end

    -- 载入数据
    self._titleTableView:reload()
    self._titleTableView:fixContentOffset()
    listBg:addChild(self._titleTableView, 0)

    -- 渐入
    self:setOpacity(0)
    self:runAction(cc.FadeIn:create(0.1))
end

-- 更新视图
function TitleSelectLayer:onUpdateView()

end

-- 设置选取回调
function TitleSelectLayer:setSelectCallback(cb)
    self._selectCallback = cb
end

-- 设置关闭回调
function TitleSelectLayer:setCloseCallback(cb)
    self._closeCallback = cb
end
