 -- ChatDialogLayer.lua
-- Author:ydli
-- 2017年09月11日
-- Using:对话框界面
UI = UI or {}
local ChatDialogLayer = class("ChatDialogLayer", UI.HWBtnComponent)
UI.ChatDialogLayer = ChatDialogLayer

require"app.ui.social.chat.DialogScrollView"
require"app.ui.social.chat.DialogLayout"
require"app.ui.social.chat.DialogTextCell"
require"app.ui.social.chat.DialogHeadTextCell"
local SdkBox = require("utils.sdkbox.SdkBox")

local size = cc.size(10, 10)
-- 资源列表(必备)
local COM_RES_LIST = {
}

local cellHeight = 16
local MESSAGE_LIMIT_COUNT = 300
local spaceHeight = 3
ChatDialogType = {
    QuickLayer = 1,
    MainLayer = 2
}
----表情界面
--构造函数(必备)
function ChatDialogLayer:ctor(chatChannelType, spriteID)
    --窗口大小
    ChatDialogLayer.super.ctor(
    self,UIType.CHAT_DIALOG_LAYER,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self._clearAll = true
    self._scrollWidth = 0
    self._scrollHeight = 0
    self._layout = nil
    self.scrollView = nil
    self._messageTextList = {} --所有消息的文本 实现tableview 功能
    self._msgFiltPkTextList = {} --被指定条件筛选后的消息的文本 （私聊消息只显示当前选中PK的）

    self._lastScrollPosY = nil --上一次的滑动百分比  用于计算方向
    self._unReadNumber = 0
    self._mainUILayer = nil
    self._isShowNewList = false
    self._isFullScreen = false
    self._chatChannelType = chatChannelType
end

--虚构函数,destroy时调用(必备)
function ChatDialogLayer:dtor()
    -- print("----------ChatDialogLayer dtor  1")
    -- ChatDialogLayer.super.dtor(self)
end

-- 初始化(必备)
function ChatDialogLayer:init(width, height, isShowNewList)
    -- print("------------------ChatDialogLayer:init width = "..width.."   /   height = "..height)
    self._scrollWidth = width
    self._scrollHeight = height
    self._isShowNewList = isShowNewList
    self:setSize(self._scrollWidth , self._scrollHeight)
    ChatDialogLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function ChatDialogLayer:onInitView()
    self._newMessageListBtn = UI.Layout:create()
    self._newMessageListBtn:init()
    self._newMessageListBtn:setSize(30, 30)
    self._newMessageListBtn:rightBottom(64, 0)
    self._newMessageListBtn:setTouchEnable(true)
    self._newMessageListBtn:addEventListener(UIEvent.COMPONENT_CLICK,self, function()
        self:clearAllChild()
        self:scrollToBottom()
    end)
    self:addChild(self._newMessageListBtn, 100)
    self._newMessageListBtn:hide()

    local bg =  cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_prompt.png")
    bg:setAnchorPoint(0, 0)
    bg:setContentSize(cc.size(30, 30))
    bg:setPosition(0, 0)
    self._newMessageListBtn:addChild(bg)
    bg:setName("BUTTON_BG")
       
          -- 进度提示文字
    local tip = UI.Text:create()
    tip:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_234_232_145)
    tip:center()
    tip:setName("SHOW_TIP")
    self._newMessageListBtn:addChild(tip)
    -- self:initDiaLogLayer()
end


-- 模版函数：更新组建的视图(必备)
function ChatDialogLayer:onUpdateView()
    if self.scrollView and self._chatChannelType ~= ChatChannelType.QUICK then
        self.scrollView:setScrollBarWidth(5)
        self.scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self.scrollView:setCircleVisible(false)
        -- self.scrollView:setScrollBarPositionFromCornerForVertical(cc.p(-10, 0))
        -- self.scrollView:enableDebugDraw()
    end
end

function ChatDialogLayer:insertMessageText(data)
    table.insert(self._messageTextList, data)
    if self._chatChannelType == ChatChannelType.PERSONAL then
        if data.messageType == ChatMessageType.SYSTEM then
            table.insert(self._msgFiltPkTextList, data)
            return true
        elseif self.filtPk ~= nil then
            if data.messageData ~= nil and (data.messageData.chatFrom.pk == self.filtPk or data.messageData.chatTo.pk == self.filtPk) then
                table.insert(self._msgFiltPkTextList, data)
                return true
            end
        end
    else
        -- table.insert(self._msgFiltPkTextList, data)
        return true
    end
end

function ChatDialogLayer:initDiaLogLayer()
    self._clearAll = false
    self:refreshFiltMsgListByPk()
    if self._layout then
        local isMax = self:checkIsMaxSize()
        if isMax then
            local size = #self._msgFiltPkTextList
            local height = size * (cellHeight + 20)
            height = height < self._scrollHeight and self._scrollHeight or height
            self._layout:setSizeWithForbid(self._scrollWidth, height, true)
            -- self._layout:setSize(self._scrollWidth, height)
        end
        self:scrollToBottom()
        return
    end
    if self.scrollView == nil then
        local scrollView = UI.DialogScrollView:create()
        scrollView:init(0, 0, 0, 0)
        scrollView:setSize(self._scrollWidth + 19, self._scrollHeight)
        scrollView:leftBottom(2, 2)
        self:addChild(scrollView)
        self.scrollView = scrollView

        self._layout = UI.DialogLayout:create(scrollView, self._chatChannelType)
        self._layout:init(0, 0, 0, 0)
        scrollView:addInnerNode(self._layout)

        self._layout:leftBottom(0, 0)
        self._layout:setFullScreen(self._isFullScreen)
        if self._chatChannelType ~= ChatChannelType.QUICK then
            scrollView:setScrollBarEnabled(true)
            scrollView:setBounceEnabled(true)
            self.scrollView:setScrollBarWidth(5)
            self.scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
            self.scrollView:setCircleVisible(false)
            scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, self.onScrollViewScrollBeginCallback)
            scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self, self.onScrollViewScrollEndedCallback)
            scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, self.onScrollViewScrollingCallback)  
            scrollView:addEventListener(UIEvent.SCROLL_VIEW_AUTOSCROLL_ENDED, self, self.onScrollViewAutoScrollCallback)   
            self.scrollView:addEventListener(UIEvent.COMPONENT_CLICK, self, self.hideAction)
        else
            scrollView:disableScrolling()
            scrollView:setSwallowTouches(false)
            scrollView:setScrollViewTouchEnabled(false)
        end
    end

    self:checkIsMaxSize()
    local size = #self._msgFiltPkTextList

    if size > 0 and not self._isFullScreen then
        local tempList = {}
        local time = self._msgFiltPkTextList[1].gTime
        local isShowLine = true
        for k, v in ipairs(self._msgFiltPkTextList) do
            local isInSame = AvalonUtil:isInSameDay(time, v.gTime)
            isShowLine = true
            if not isInSame then
                local data = {}
                data.gTime = time
                data.isSplitLine = true--显示时间 不需要分割线
                table.insert(tempList, data)
                time = v.gTime
                isShowLine = false--和时间 相邻的文本也不需要分割线
            end
            v.isShowLine = isShowLine
            table.insert(tempList, v)
        end
        self._msgFiltPkTextList = tempList
        size = #self._msgFiltPkTextList
        local data = {}
        data.gTime = self._msgFiltPkTextList[size].gTime
        data.isSplitLine = true --显示时间 不需要分割线
        self:insertMessageText(data)
    end

    local height = size * (cellHeight + 20)
    height = height < self._scrollHeight and self._scrollHeight or height

    local saveHeight = Game.ChatManager:getInstance():getChatDialogHeight(self._chatChannelType)
    if saveHeight ~= nil and saveHeight > height then
        self._layout:setSizeWithForbid(self._scrollWidth, saveHeight, true)
         -- self._layout:setSize(self._scrollWidth, saveHeight)
    else
        -- self._layout:setSize(self._scrollWidth, height)
        self._layout:setSizeWithForbid(self._scrollWidth, height, true)
    end

    -- self._layout:enableDebugDraw(UI.RED)

    self:scrollToBottom()
end

function ChatDialogLayer:checkIsMaxSize()
    local isMax = false
    local size = #self._messageTextList
    if size > MESSAGE_LIMIT_COUNT then
        for i = 1, size - MESSAGE_LIMIT_COUNT do
            table.remove(self._messageTextList, 1)
        end
        isMax = true
    end
    return isMax
end 

function ChatDialogLayer:showMessage(data, isSelf)
    local size = #self._msgFiltPkTextList
    local lastData = self._msgFiltPkTextList[size]
    if lastData ~= nil and lastData.isSplitLine ~= true and size >= 1 then
        data.isShowLine = true
    end
    local isDirty = self:insertMessageText(data)
    if  self._clearAll then
        return
    end
    print("---showMessage----_clearAll, isDirty, isSelf, isBottom", self._clearAll, isDirty, isSelf, self:isBottom(), self._layout)
    if isDirty then
        local isBottom = self:isBottom()
        if isSelf or isBottom or self._isFullScreen  then
            self:createMessage(#self._msgFiltPkTextList, data, false)
            if not isBottom then
                self:clearAllChild()
                self:scrollToBottom()
            else
                self:_scrollToBottom()
            end
        elseif self._layout ~= nil then
            self._unReadNumber = self._unReadNumber + 1
            self:refreshNewMessageNum()
        end
    end
end

function ChatDialogLayer:forceClear()
--   print("----ChatDialogLayer:forceClear()------")
    if(self._layout) then 
        local isMax = self:checkIsMaxSize()
        if isMax then
            local size = #self._msgFiltPkTextList
            local height = size * (cellHeight + 10)
            height = height < self._scrollHeight and self._scrollHeight or height
            self._layout:setSizeWithForbid(self._scrollWidth, height, true)
        end
    end 
    self:clearAllChild()
    self:scrollToBottom()
end


function ChatDialogLayer:createMessage(tag, data, isForward)
    if self._layout ~= nil then
        if data.isSplitLine then--展示分割线
            -- print("-----split line ------- data.gTime = "..data.gTime)
            local lineNode = UI.Text:create()
            local today = AvalonUtil.getCurrentTime()
            local showText = ""
            if AvalonUtil:isInSameDay(data.gTime , today) then
                showText = os.date("%H:%M", math.ceil(data.gTime / 1000))
            else
                showText = os.date("%Y-%m-%d", math.ceil(data.gTime / 1000))
            end
            lineNode:init(showText, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_92_92_92)
            lineNode:setTextCenter()
            lineNode:setSize(self._scrollWidth - 60, 60)
            self._layout:addChildByDirect(lineNode, isForward)
            lineNode:setTag(tag)
        else
            -- print("ChatDialogLayer:createMessage 1", self._chatChannelType)
            if(self._chatChannelType == ChatChannelType.GUILD_SELECT_FLOOR) then
                local pading = 7 
                local cell = self._layout:getFreeCellFromTop() 
                local content = data.content
                local fontColor = data.fontColor
                if cell then
                -- print("------循环利用 ===DialogTextCell== ")
                    cell:setTag(tag)
                    local contentText = cell:getChildByName("contentText")
                    contentText:setText(content)
                    contentText:setFontColor(fontColor)
                    cell:setSize(310, contentText:getContentSize().height + pading*2)
                    self._layout:addChildByDirect(cell, isForward)
                else
                    local success = false
                    local contentText = nil
                    local cell = nil
                    contentText = UI.Text:create()
                    contentText:init(content, UI.SYS_FONT, UI.FONT_SIZE_16PX, fontColor)
                    contentText:setTextLeft()
                    contentText:setWidth(285)
                    contentText:autoAdapt()
                    contentText:setName("contentText")

                    cell = UI.Layout:create()
                    cell:init()    
                    contentText:centerLeft(16)
                    cell:setSize(310, contentText:getContentSize().height + pading*2)
                    cell:addChild(contentText)
                    local picDes = UI.Image:create()
                    picDes:init("ui_checkpoint_banner_diamond.png")
                    picDes:leftUp(2, 4+pading)
                    picDes:setName("contentPic")
                    cell:addChild(picDes, 10)

                    cell:setTag(tag)
                    self._layout:addChildByDirect(cell, isForward)
                    return cell
                end
            else 
                local className, lType, width, left = self:getLayoutType(data)
                local cell = self._layout:getFreeCellByClassName(className) 
                if cell then
                -- print("------循环利用 ===DialogTextCell== ")
                    cell:setTag(tag)
                    cell:refreshView(self, self._chatChannelType, lType, data, width, cellHeight)
                    self._layout:addChildByDirect(cell, isForward, left)
                else
                    if className == "DialogTextCell" then
                        cell = UI.DialogTextCell:create()
                    elseif className == "DialogHeadTextCell" then
                        cell = UI.DialogHeadTextCell:create()
                    end
                    cell:setTag(tag)
                    cell:init()
                    cell:refreshView(self, self._chatChannelType, lType, data, width, cellHeight)
                    self._layout:addChildByDirect(cell, isForward, left)
                end
            end
        end
    end
end

-- CHAT_CELL_LAYOUT_TYPE = {
--     RichText = 1,      --排版1：富文本、隔离线      >>>> 出现在系统频道、其它频道的系统消息
--     LogoRichText = 2,  --排版2：频道标识、富文本、隔离线      >>>>  出现在快捷频道
--     HeadRichText = 3,  --排版3：头像、职位（可选）、名字、文本底框，富文本、翻译文本底框、翻译富文本、翻译按钮，有翻转效果     >>>> 世界、工会、队伍、附近、私聊频道
--     BtnRichText = 4,   --排版4：头像、职位（可选）、名字、文本底框，富文本、按钮（同意和拒绝）    >>>> 工会频道、队伍频道
--     Text = 5,
-- }
--获取布局类型 gamedefine.CHAT_CELL_LAYOUT_TYPE, 完全没有规律，穷举所有情况
--[[
    CHAT_CELL_LAYOUT_TYPE.RichText、LogoRichText    使用 DialogTextCell
    CHAT_CELL_LAYOUT_TYPE.HeadRichText、BtnRichText 使用 DialogHeadTextCell
]]
function ChatDialogLayer:getLayoutType(data)
    if self._chatChannelType == ChatChannelType.SYSTEM then
        return "DialogTextCell", CHAT_CELL_LAYOUT_TYPE.RichText, self._scrollWidth - 40
    elseif self._chatChannelType == ChatChannelType.QUICK then
        return "DialogTextCell", CHAT_CELL_LAYOUT_TYPE.LogoRichText, self._scrollWidth - 50
    elseif data.messageType == ChatMessageType.SYSTEM_GUILD_INVITE then
        return "DialogHeadTextCell", CHAT_CELL_LAYOUT_TYPE.BtnRichText, self._scrollWidth - 20
    else
        if data.messageType == ChatMessageType.SYSTEM_NOTICE or data.messageType == ChatMessageType.SYSTEM_TEAM or data.messageType == ChatMessageType.SYSTEM_GUILD 
            or data.messageType == ChatMessageType.SYSTEM_FRIEND or data.messageType == ChatMessageType.SYSTEM_TEAM_MEMBER or data.messageType == ChatMessageType.SYSTEM_GUILD_MEMBER 
            or data.messageType == ChatMessageType.SYSTEM_NEAR then
            return "DialogTextCell", CHAT_CELL_LAYOUT_TYPE.RichText, self._scrollWidth - 63, 16
        end
        return "DialogHeadTextCell", CHAT_CELL_LAYOUT_TYPE.HeadRichText, self._scrollWidth - 20
    end
      
end

function ChatDialogLayer:isBottom()
    if self.scrollView == nil then
        return false
    end
    local scrollY = self.scrollView:getScrollPosY()
    if scrollY >= (cellHeight + spaceHeight * 2) * -1 then
        return true
    end
    return false
end

function ChatDialogLayer:onScrollViewScrollBeginCallback()
    self:hideAction()
end

function ChatDialogLayer:onScrollViewScrollEndedCallback()
    
end

function ChatDialogLayer:onScrollViewAutoScrollCallback()
    -- print("----ChatDialogLayer:onScrollViewAutoScrollCallback()---- self._layout.openDisPatchSizeChange = ", self._layout.openDisPatchSizeChange)
    -- self:onScrollViewScrollingCallback()
end

function ChatDialogLayer:onScrollViewScrollingCallback()
    if self.scrollView and self._chatChannelType ~= ChatChannelType.QUICK then
        self.scrollView:setScrollBarWidth(5)
        self.scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self.scrollView:setCircleVisible(false)
    end
    if self._lastScrollPosY == nil then
        self._lastScrollPosY = self.scrollView:getScrollPosY()
        return 
    end
    local scrollY = self.scrollView:getScrollPosY()
    local isToUp = false
    if self._lastScrollPosY > scrollY  then
        isToUp = false
    else
        isToUp = true
    end
    local number = math.ceil(math.abs((self._lastScrollPosY - scrollY) / 30))
    self._lastScrollPosY = scrollY
    for i = 1, number do--优化 可能一个回调 已经滑动了  多个cell 的距离
        -- print("-----1-----"..AvalonUtil.getCurrentTime())
        local index = self._layout:isRefreshCell(isToUp, scrollY)
        -- print("-----2-----"..AvalonUtil.getCurrentTime())
        if index then
            self:createMessageByScrolling(isToUp, index)
            -- print("-----3-----"..AvalonUtil.getCurrentTime())
        else
            break
        end
    end
    self:refreshNewMessageNum()
    
end

function ChatDialogLayer:createMessageByScrolling(isToUp, index)
    if not self._layout.openDisPatchSizeChange then
        return
    end
    if isToUp then
        local textData = self._msgFiltPkTextList[index + 1]
        if textData then
            self:createMessage(index + 1, textData, false)
        end
    else
        local textData = self._msgFiltPkTextList[index - 1]
        if textData then
            self:createMessage(index - 1, textData, true)
        end
    end
end

function ChatDialogLayer:hideAction()
    -- print("-------ChatDialogLayer:    hideAction")
    if  self._mainUILayer ~= nil and  self._mainUILayer.hideAction ~= nil then
         self._mainUILayer:hideAction()
    end
end

function ChatDialogLayer:setMainUILayer(mainUILayer)
    self._mainUILayer = mainUILayer
end

function ChatDialogLayer:scrollToBottom()
    if self._layout == nil then
        return
    end
    local messageNumber = #self._msgFiltPkTextList
    local index = 0
    if messageNumber > self.scrollView:getMaxCellSize() then
        for index = messageNumber, messageNumber - self.scrollView:getMaxCellSize() + 1, -1 do
            -- print("----for-------index = "..index)
            local data = self._msgFiltPkTextList[index]
            -- print("----data--- = "..data)
            self:createMessage(index, data, true)
        end
    else
        for index, data in ipairs(self._msgFiltPkTextList) do
            self:createMessage(index, data, false)
            index = index + 1
        end
    end
    self:_scrollToBottom()
end

function ChatDialogLayer:_scrollToBottom()
    self.scrollView:stopScroll()
    self.scrollView:scrollToBottom()
    self._newMessageListBtn:hide()
end

function ChatDialogLayer:refreshNewMessageNum()
    if self._layout == nil or not self._isShowNewList then
        return
    end
    local size = #self._msgFiltPkTextList - self._layout:getLastShowMessageIndex(self.scrollView:getScrollPosY()) 
    -- print("-----self._unReadNumber----size- = ", self._unReadNumber, size)
    if self._unReadNumber > size then
        self._unReadNumber = size
    end
    local size = self._unReadNumber
    
    if size > 99 then
        self._newMessageListBtn:show()
        local bg = self._newMessageListBtn:getChildByName("BUTTON_BG")
        self._newMessageListBtn:setSize(40, 30)
        bg:setContentSize(cc.size(40, 30))
        local tips = self._newMessageListBtn:getChildByName("SHOW_TIP")
        tips:setText("99+")
    elseif size > 0 then
        self._newMessageListBtn:show()
        local tips = self._newMessageListBtn:getChildByName("SHOW_TIP")
        local bg = self._newMessageListBtn:getChildByName("BUTTON_BG")
        if size >= 10 then
            self._newMessageListBtn:setSize(35, 30)
            bg:setContentSize(cc.size(35, 30))
        else
            self._newMessageListBtn:setSize(30, 30)
            bg:setContentSize(cc.size(30, 30))
        end
        tips:setText(string.format("%d", size))

    else
        self._newMessageListBtn:hide()
    end
end

--显示的消息 是否是满屏
function ChatDialogLayer:setFullScreen(isFullScreen)
    self._isFullScreen = isFullScreen
end

function ChatDialogLayer:clearMessage()
    self._messageTextList = {}
    self._msgFiltPkTextList = self._messageTextList
end

function ChatDialogLayer:clearAllChild(isFlag)
    if self._layout then
        -- print("----clearAllChild()-----")
        self._layout:removeAllChild()
    end
    if isFlag then
        self._clearAll = true
    end
end

function ChatDialogLayer:addHeightByIndex(isToUp, height, tag)
    local motherNumber = self._layout:getContentSize().height - self._scrollHeight
    local addPercent = 0
    if motherNumber > height and motherNumber > 0 then
        addPercent = (height / (self._layout:getContentSize().height - self._scrollHeight)) * 100
    end
    self._layout:addHeightByIndex(isToUp, height, tag, addPercent)
end

function ChatDialogLayer:translateCallback(eventType, commonId, resultObject)
    self._layout:translateCallback(eventType, commonId, resultObject)
end

function ChatDialogLayer:checkTranslateMode()
    self._layout:checkTranslateMode()
end

--根据pk 筛选需要显示的消息
function ChatDialogLayer:setfiltPk(pk)
    if self.filtPk == pk then
        return false
    end
    self.filtPk = pk
    self:refreshFiltMsgListByPk()
    local height = #self._msgFiltPkTextList * (cellHeight + 20)
    if self._layout then
        self._layout:setSizeWithForbid(self._scrollWidth, height, true)
    end
    self:forceClear()
    return true
end

function ChatDialogLayer:refreshFiltMsgListByPk()
    if self._chatChannelType == ChatChannelType.PERSONAL then
        self._msgFiltPkTextList = {}
        if self.filtPk ~= nil then
            for k, data in ipairs(self._messageTextList) do
                if data.messageData == nil or data.messageType == ChatMessageType.SYSTEM then
                    table.insert(self._msgFiltPkTextList, data)
                elseif data.messageData.chatFrom.pk == self.filtPk or data.messageData.chatTo.pk == self.filtPk then
                    table.insert(self._msgFiltPkTextList, data)
                end
            end
        end
    else
        self._msgFiltPkTextList = self._messageTextList
    end
end