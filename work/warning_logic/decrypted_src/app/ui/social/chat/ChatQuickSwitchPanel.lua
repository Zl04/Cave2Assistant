--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-09-24 15:24:15
]]

UI = UI or {}
local ChatQuickSwitchPanel = class("ChatQuickSwitchPanel", UI.Component)
UI.ChatQuickSwitchPanel = ChatQuickSwitchPanel

require "app.ui.social.chat.ChatDialogLayer"
require "app.ui.common.CheckBox"
require "utils.VoiceChatManager"

local winSize = cc.Director:getInstance():getWinSize()
local ARR_WIDTH = 40
local ARR_OFFSET = 22
local CELL_WIDTH = 86
local CELL_HEIGHT = 70

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_chat.plist",
}

-- 暴露更新选中的方法 by PK
function ChatQuickSwitchPanel:setSelectedByPK(pk, isDoCallback)
    local ProtobufUtil = require "utils.ProtobufUtil"
    for i,v in ipairs(self._personalChatDataArr) do
        if (pk) then
            if ((ProtobufUtil:checkFieldIsInit(v, "pk") and v.pk == pk) or 
                (ProtobufUtil:checkFieldIsInit(v, "PK") and v.PK == pk)
            ) then
                self:setSeletedByData(v, isDoCallback)
                break
            end
        end
    end
end

-- 暴露更新选中的方法
function ChatQuickSwitchPanel:setSeletedByData(data, isDoCallback)
    self._selectedData = data
    self:udpateSeletedView()

    if (self._callback and isDoCallback) then
        self._callback(self._selectedData)
    end
end

-- 构造函数(必备)
function ChatQuickSwitchPanel:ctor()
    ChatQuickSwitchPanel.super.ctor(
    self,UIType.CHAT_QUICK_LAYER,
    COM_RES_LIST,
    0,
    0)

    self._personalChatDataArr = {}
    self._cellViewArr = {}
end

--虚构函数,destroy时调用(必备)
function ChatQuickSwitchPanel:dtor()
    ChatQuickSwitchPanel.super.dtor(self)
    -- reload_script_file("app.ui.social.chat.ChatQuickSwitchPanel")
end

-- 初始化(必备)
function ChatQuickSwitchPanel:init(width, callback)
    self._callback = callback
    self:setSize(width, CELL_HEIGHT)
    ChatQuickSwitchPanel.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function ChatQuickSwitchPanel:onInitView()
    -- 列表
    local width, height = self:getSize()
    local cellWidth = CELL_WIDTH
    local cellHeight = CELL_HEIGHT
    local scrollViewWidth = width - ARR_WIDTH * 2

    -- 滑动内容布局
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    self._scrollLayout:setSize(0, height)

    -- 滑动区域
    self._scrollView = UI.ScrollView:create()
    self._scrollView:init()
    self._scrollView:setSize(scrollViewWidth, height)
    self._scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    self._scrollView:setRestorePositiion(true)
    self._scrollView:leftUp(ARR_WIDTH, 0)
    self._scrollView:addInnerNode(self._scrollLayout)
    self:addChild(self._scrollView)    
    self._scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, function (_, _1, pre)
        self:updateArrBtnShowStat()
    end)

    -- 左边箭头
    local arrLeft = UI.Button:create()
    arrLeft:init("ui_comment_btn_arrow_0.png", "ui_comment_btn_arrow_1.png", "ui_comment_btn_arrow_0.png")
    arrLeft:setRotation(90)
    arrLeft:leftUp(0, ARR_OFFSET)
    self:addChild(arrLeft)
    arrLeft:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:moveTableOffset(-cellWidth)
    end)
    self._arrLeft = arrLeft

    -- 左边箭头红点(旋转了, 要移动下位置)
    local arrLeftRedpoint = AvalonUtil.createRedPoint(self._arrLeft, 33, 10)
    arrLeftRedpoint:hide()
    self._arrLeftRedpoint = arrLeftRedpoint

    -- 右边箭头
    local arrRight = UI.Button:create()
    arrRight:init("ui_comment_btn_arrow_0.png", "ui_comment_btn_arrow_1.png", "ui_comment_btn_arrow_0.png")
    arrRight:rightUp(0, ARR_OFFSET)
    arrRight:setRotation(270)
    self:addChild(arrRight)
    arrRight:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:moveTableOffset(cellWidth)
    end)
    self._arrRight = arrRight

    -- 右边箭头红点(旋转了, 要移动下位置)
    local arrLeftRedpoint = AvalonUtil.createRedPoint(self._arrRight, 0, 10)
    arrLeftRedpoint:hide()
    self._arrRightRedpoint = arrLeftRedpoint
end


-- 模版函数：更新组建的视图(必备)
function ChatQuickSwitchPanel:onUpdateView()
    -- 刷新列表
    self:reloadDataAndView()

    -- 更新按钮
    if (#self._personalChatDataArr > 0 and not self._isInitCallbackDone) then
        self._isInitCallbackDone = true
        if (self._callback) then self._callback(self._selectedData) end
        self._scrollView:scrollToPercentHorizontal(0, 0)
    end
end

-- 更新列表展示
function ChatQuickSwitchPanel:reloadDataAndView()
    -- 更新数据
    local rawData = Game.ChatManager:getInstance():getAllChatPersonal()
    self._personalChatDataArr = {}
    for i,v in ipairs(rawData) do
        table.insert(self._personalChatDataArr, v)
    end
    table.sort(self._personalChatDataArr, function(a, b)
        return a.lastTalkTime > b.lastTalkTime
    end)

    -- 更新选中数据
    if (not self._selectedData) then
        self._selectedData = self._personalChatDataArr[1]
    end

    -- 更新展示
    for i,data in ipairs(self._personalChatDataArr) do
        local cellView = self._cellViewArr[i]
        if (not cellView) then
            local CellView = require "app.ui.social.chat.ChatQuickSwitchCellView"
            cellView = CellView:create(self._tableView)
            cellView:init()
            cellView:setSize(CELL_WIDTH, CELL_HEIGHT)
            self._scrollLayout:addChild(cellView)
            table.insert(self._cellViewArr, cellView)
        end

        -- 更新数据
        cellView:show()
        cellView:updateData(data)
        cellView:updateCallback(function()
            self._selectedData = data
            self:reloadDataAndView()
            if (self._callback) then self._callback(data) end
        end)
        cellView:leftBottom(CELL_WIDTH * (i - 1), 0)
    end

    -- 更新选中
    self:udpateSeletedView()

    -- 隐藏多余的展现
    for i=#self._personalChatDataArr + 1, #self._cellViewArr do
        local cellView = self._cellViewArr[i]
        if (cellView) then
            cellView:hide()
        end
    end

    -- 更新内容排版大小
    local width = CELL_WIDTH * #self._personalChatDataArr - 10
    width = width < 0 and  CELL_WIDTH or width
    self._scrollLayout:setSize(width, CELL_HEIGHT)
    self._scrollView:refresh()
    self:updateArrBtnShowStat()
end

-- 更新选中
function ChatQuickSwitchPanel:udpateSeletedView()
    for i,data in ipairs(self._personalChatDataArr) do
        local cellView = self._cellViewArr[i]
        if (self._selectedData == data) then
            cellView:updateSelected(true)
        else
            cellView:updateSelected(false)
        end
    end 
end

-- 更新左右箭头按钮显示
function ChatQuickSwitchPanel:updateArrBtnShowStat()
    if (not self._arrLeft or not self._arrRight) then return end

    -- 更新箭头显示
    local scrollPercent = self._scrollView:getScrollPercent()
    local contentLayoutW = self._scrollLayout:getSize()
    local scrollViewW = self._scrollView:getSize()
    if (contentLayoutW <= scrollViewW or scrollPercent >= 0.99) then
        self._arrLeft:hide()
    else
        self._arrLeft:show()
    end
    if (contentLayoutW <= scrollViewW or scrollPercent <= 0.01) then
        self._arrRight:hide()
    else
        self._arrRight:show()
    end

    -- 更新箭头红点
    if (contentLayoutW > scrollViewW) then
        -- 左箭头红点
        local scrollStartX = (1 - scrollPercent) * (contentLayoutW - scrollViewW) + 20
        local scrollStartIdx = math.floor(scrollStartX / CELL_WIDTH)
        if (scrollStartIdx > 1) then
            local isLeftRedpointShow = false
            for i=1,scrollStartIdx do
                local cellView = self._cellViewArr[i]
                local isRedpointShow = cellView and cellView:isVisible() and cellView:isRedpointVisible()
                if (isRedpointShow) then
                    isLeftRedpointShow = true
                    break
                end
            end
            self._arrLeftRedpoint:setVisible(isLeftRedpointShow)
        else
            self._arrLeftRedpoint:hide()
        end

        -- 右箭头红点
        local scrollEndX = scrollStartX + scrollViewW
        local scrollEndIdx = math.ceil(scrollEndX / CELL_WIDTH)
        if (scrollEndIdx <= #self._personalChatDataArr) then
            local isRightRedpointShow = false
            for i=scrollEndIdx,#self._personalChatDataArr do
                local cellView = self._cellViewArr[i]
                local isRedpointShow = cellView and cellView:isVisible() and cellView:isRedpointVisible()
                if (isRedpointShow) then
                    isRightRedpointShow = true
                    break
                end
            end
            self._arrRightRedpoint:setVisible(isRightRedpointShow)
        else
            self._arrRightRedpoint:hide()
        end
    end
end

-- 滑动多少像素
function ChatQuickSwitchPanel:moveTableOffset(amount)
    local offset = self._scrollView:getContentOffset()
    local innerSize = self._scrollView:getInnerSize()
    local outterW = self._scrollView:getSize()
    local totalScrollW = innerSize.width - outterW
    local targetScrollX = -(offset.x - amount)
    local targetScrollPercent100 = targetScrollX / totalScrollW * 100

    self._scrollView:scrollToPercentHorizontal(targetScrollPercent100, 0.1)
end

-- 注销监听事件(可选)
function ChatQuickSwitchPanel:refreshRedPoint(pk)
    for k, v in pairs(self._cellViewArr) do
        if v:isVisible() then
            v:showRedPoint(pk)
        end
    end
end

-- 注册监听事件(可选)
function ChatQuickSwitchPanel:registerListener()
    
end


-- 注销监听事件(可选)
function ChatQuickSwitchPanel:unRegisterListener()


end
    


-- 注销监听事件(可选)
function ChatQuickSwitchPanel:refreshRedPoint(playerData)
    for k, v in pairs(self._cellViewArr) do
        if v:isVisible() then
            v:showRedPoint(playerData)
        end
    end

end