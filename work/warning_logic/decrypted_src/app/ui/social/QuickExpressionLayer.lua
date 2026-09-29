-- QuickExpressionLayer.lua
-- Author:ydli
-- 2017年08月30日
-- Using:快捷表情界面
-- change: 2018年06月25日 可以发送和编辑快捷文本
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local QuickExpressionLayer = class("QuickExpressionLayer", UI.HWBtnComponent)
UI.QuickExpressionLayer = QuickExpressionLayer
require("app.ui.social.QuickExpressionCell")
require "app.config.ConfigManager"
local ProtobufUtil = require("utils.ProtobufUtil")

local winSize = cc.Director:getInstance():getWinSize()
local height =  winSize.height - 320
height = height < 352 and 352 or height
local size = cc.size(422, height)
local textCellSize = cc.size(400, 60)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_expression.plist",
    "ui_general_chat.plist",
}
local fileName = "quickChat.ud"

----表情界面
--构造函数(必备)
function QuickExpressionLayer:ctor(spriteID)
    -- print("TipsLayer:ctor")
    --窗口大小
    QuickExpressionLayer.super.ctor(
    self,UIType.QUICK_EXPRESSION_LAYER,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self.showLanguageList = {}
    self.rootLayer = nil;           --root节点
    self.isShow = false
    self.expressionNodes = self.expressionNodes or {}
    self.textCells = self.textCells or {}
    self.selectIndex = 0
    self.selectTextIndex = 0
    self.lockClick = false
    self.isEditorMode = false
    self.schedulerID = 0
    self.autoMoveSchedulerID = 0
    self.isDrag = false
    self.isReadCache = false
    self:init();
    self:registerListener();
    self:setTouchEnable(true)
end

--虚构函数,destroy时调用(必备)
function QuickExpressionLayer:dtor()
    QuickExpressionLayer.super.dtor(self)
    self:unRegisterListener();
    self:endAutoScrollView()
end

-- 初始化(必备)
function QuickExpressionLayer:init()
    QuickExpressionLayer.super.init(self)
    self:setForceListenBackKey(true)
end


-- 模版函数：初始化组建的视图(必备)
function QuickExpressionLayer:onInitView()
    if not self.isReadCache then
        self:readNewFlagList()
    end
    local tempList = {}
    local quickChatCfgList = ConfigManager:getAllQuickChatData()
    for k, v in ipairs(quickChatCfgList) do
        table.insert(tempList, v.description)
    end
    --如果本地游存储用本地的，否者用配置表的
    if #self.showLanguageList < #tempList then
        for index = #self.showLanguageList, #tempList, 1 do
            table.insert(self.showLanguageList, tempList[index])
        end
    end
    -- self:enableDebugDraw()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
    bg:setCapInsets(CCRectMake(7,7,1,1))
    bg:setContentSize(size.width, size.height)
    bg:setAnchorPoint(0, 0)
    self:addChild(bg, 1)

    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(size.width - 14, size.height - 62)
    scrollView:leftUp(24, 8)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:setScrollBarEnabled(true)
    -- scrollView:enableDebugDraw()
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)

    self.scrollView = scrollView
    self:addChild(scrollView, 2)

    local layout = UI.TouchLayout:create()
    layout:init(0, 0, 0, 0)
    scrollView:addInnerNode(layout)

    local list = ConfigManager:getAllExpressionData()
    local cellsize = {width = 110, height = 75}
    local modeHeight = math.ceil(#list / 3)
    layout:setSize(size.width - 45, cellsize.height * modeHeight  + #self.showLanguageList * textCellSize.height)
    local emojiBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_translation_box3.png")
    emojiBg:setCapInsets(CCRectMake(1,1,1,1))
    emojiBg:setContentSize(size.width - 45, cellsize.height * modeHeight)
    emojiBg:setAnchorPoint(0, 0)
    emojiBg:setPosition(0, layout:getContentSize().height - emojiBg:getContentSize().height - 7)
    layout:addChild(emojiBg)

    for k, value in ipairs(list) do
        local expression = UI.Image:create()
        expression:init(value.icon)

        local kHeight = math.ceil(k / 3) - 1      
        local kWidth = k % 3
        kWidth = kWidth == 0 and 3 or kWidth
        expression:leftUp((kWidth - 1) * cellsize.width + 33, kHeight * cellsize.height + 3)
        emojiBg:addChild(expression)
        expression:setTag(value.ID)
        expression:setImageScaleX(-1)
        table.insert(self.expressionNodes, expression)
    end
    local beginUp = emojiBg:getContentSize().height + 8
    for k, v in ipairs(self.showLanguageList) do
        local textCell = UI.QuickExpressionCell:create(v)
        textCell:centerUp(beginUp + (k - 1) * textCellSize.height)
        layout:addChild(textCell)
        local data = {}
        data.posY = textCell:getPositionY()
        data.cell = textCell
        table.insert(self.textCells, data)
    end
    layout:addTouchEvents(self)
    self.layout = layout

    local capImage = UI.Image:create()
    capImage:init("ui_chat_mask_dwon.png")
    capImage:centerBottom(43)
    self:addChild(capImage, 20)

    local backBtn = UI.Button:create()
    backBtn:init("ui_btn_arrow_up_0.png", "ui_btn_arrow_up_1.png")
    backBtn:centerRight(-32)
    backBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self:showQucikLayer(false)
    end)
    backBtn:closeClickScale()
    self:addChild(backBtn, 20)
    backBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(-10, 0)),cc.MoveBy:create(0.5,cc.p(10,0))))) 
    backBtn:rotate(270)

    local editorBtn = UI.Button:create()
    editorBtn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    editorBtn:centerBottom(2)
    editorBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self:onselectMode(not self.isEditorMode)
    end)
    self:addChild(editorBtn, 20)
    self.editorBtn = editorBtn

    local editorLabel = UI.Text:create()
    editorLabel:init(UI.TEXT_1170338, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    editorLabel:center()
    editorBtn:addChild(editorLabel, 10)
    self.editorLabel = editorLabel

    local rightImg = UI.Image:create()
    rightImg:init("ui_chat_btn_yes.png")
    rightImg:center()
    self.editorBtn:addChild(rightImg, 10)
    rightImg:hide()
    self.rightImg = rightImg

    self.isShow = false
    self:leftBottom(1, -winSize.height)
    self:onselectMode(false)
end

function QuickExpressionLayer:onSelectedExpression(sender)
    sender:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.05), cc.ScaleTo:create(0.1, 1.0)))
    if self.lockClick then
        UI.ScrollBar:createByText(UI.TEXT_1170109)
        return
    end
    local id = sender:getTag()
    local list = ConfigManager:getAllExpressionData()
    for k, value in ipairs(list) do
        if id == value.ID then
            local framentbgSpine   = UI.Animation:create()
            framentbgSpine:init(value.spine..".json", value.spine..".atlas")
            framentbgSpine:setAnimation("idle",false)
            framentbgSpine:center()
            local spriteId = GameDataManager:getInstance():getMaster():getSpriteID()
            GameManager:addExpressionCommand(framentbgSpine, spriteId)
            self.lockClick = true
            framentbgSpine:addEventListener(UIEvent.ANIMATION_END,self,function()
                framentbgSpine:destroy()
                self.lockClick = false
            end)
            GameManager:sendExpression(id)
            Avalon.AudioManager:playSoundByConfig("26", value.ID)
            -- self:showQucikLayer(false)
            break
        end
    end
    self:onTouchDialogOutsizeHandler()
end

--如果能在   showLanguageList 找到对应的字符串 则发送对应的id， 否则发送文本
function QuickExpressionLayer:onSelectedLanguage(sender)
    -- print("-----------QuickExpressionLayer:onSelected .. tag = "..sender:getTag())
    local sendText = sender._showText
    local quickChatCfgList = ConfigManager:getAllQuickChatData()
    local sendId = 0
    for k, v in ipairs(quickChatCfgList) do
        if v.description == sendText then
            sendId = k
            break
        end
    end

    if not TeamDataManager:hasTeam() or table.nums(TeamDataManager:getTeamData()) <= 1 then
        UI.ScrollBar:createByText(UI.TEXT_1170320)
        return
    end

    sendText,mark = ToolsUtil:checkMaskword(sendText)
    if mark then
        UI.ScrollBar:createByText(UI.TEXT_1170415)
        return
    end

    local isBan, banType, timeStr = Game.ChatManager:getInstance():isBanByChannelType(ChatChannelType.TEAM)
    if isBan and banType == PublicDefine.BanChatType.BanChatType_Ban then
        UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(string.format(UI.TEXT_1170418, timeStr))
        return
    end
    local isCd, time = self:isInCd()
    if isCd then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1170332, time))
        return
    end
        --todo send to server  and  cdTime
    local content = {}
    if sendId ~= 0 then
        content.textType = PublicDefine.ChatMsgContentTextType.TYPE_QUICK_ID
        content.textId = sendId
    else
        content.textType = PublicDefine.ChatMsgContentTextType.TYPE_QUICK_TEXT
        content.text = sendText
    end
    local pbBytes = ProtobufUtil:encode("ChatSystem.ContentMessage", content)   

    local sender = RoleDataManager:getMaster()
    local senderData = {}
    senderData.pk = sender:getPK()
    senderData.userID = sender:getUserID()
    senderData.nickName = sender:getNickName()

    local message = {}
    message.Speaker = senderData
    message.chatContent = pbBytes
    local messageBytes = ProtobufUtil:encode("ChatSystem.TeamChatMessage", message)
        
    local  data = {}
    data.pbBytes = messageBytes
    data.PBType = ChatChannelType.TEAM
    data.messageType = ChatMessageType.TEAM
    data.isSelf = true
    -- dump(data, "push data")
    Game.ChatManager:getInstance():push(data)
    if isBan and banType == PublicDefine.BanChatType.BanChatType_Isolated then
    else
        GameManager:sendChatMessage(ChatChannelType.TEAM, pbBytes)
    end
    self:onTouchDialogOutsizeHandler()
end

function QuickExpressionLayer:isInCd()
    local curTime = os.time()
    local needCdTime = 3
    self.lastSendTime = self.lastSendTime or 0
    if self.lastSendTime + needCdTime > curTime then
        return true, self.lastSendTime + needCdTime - curTime 
    end
    self.lastSendTime = curTime
    return false, 0
end

-- 模版函数：更新组建的视图(必备)
function QuickExpressionLayer:onUpdateView()
    self.scrollView:setScrollBarWidth(5)
    for k, data in ipairs(self.textCells) do       
        data.posY = data.cell:getPositionY()
    end
end


-- 注册监听事件(可选)
function QuickExpressionLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_EXPRESSION, self, self.showQucikLayer)
end


-- 注销监听事件(可选)
function QuickExpressionLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_EXPRESSION, self, self.showQucikLayer)
end

function QuickExpressionLayer:showQucikLayer(isOpen)
    -- print("------------QuickExpressionLayer:showQucikLayer()")
    local endCallFunc = cc.CallFunc:create(function()  
        self:hide()
        if not self.isShow then
            self:onselectMode(false)
            self:refreshAllShowText()
            if self.isDrag then
                self:endAutoScrollView()
                self.scrollView:enableScrolling()
                local hightText = self.textCells[self.selectTextIndex].cell
                if hightText then
                    hightText:onNormal()
                end
                hightText:setPositionY(self.textCells[self.selectTextIndex].posY)
                self.hightTextorginPosY = 0
            end
            self.isDrag = false
            self.selectTextIndex = 0
        end
    end)
    if not isOpen then
        self.isShow = false
        local moveAction = cc.MoveTo:create(0.05, cc.p(-self:getContentSize().width - 100, 226))
        local easeAction = cc.EaseIn:create(moveAction, 1)
        self:runAction(cc.Sequence:create(easeAction, endCallFunc))
    else
        if self.isShow  then
            self.isShow = false
            Avalon.AudioManager:playSound("1502")
            local moveAction = cc.MoveTo:create(0.05, cc.p(-self:getContentSize().width - 100, 226))
            local easeAction = cc.EaseIn:create(moveAction, 1)
            self:runAction(easeAction)
            self:runAction(cc.Sequence:create(easeAction, endCallFunc)) 
        else
            self.isShow = true
            self:show()
            Avalon.AudioManager:playSound("1501")
            self:setPositionY(226)
            local moveAction = cc.MoveTo:create(0.05, cc.p(-3, 226))
            local easeAction = cc.EaseOut:create(moveAction, 1)
            self:runAction(easeAction)
        end
    end
    UI.ChatQuickLayer:getInstance():refreshQucikExpressBtn(self.isShow)

    for k, v in ipairs(self.textCells) do
        if TeamDataManager:hasTeam() then
            if TeamDataManager:getReadyState() then
                v.cell:onDisable()
            else
                v.cell:onEnable()
            end
        else
            v.cell:onDisable()
        end
    end
end

function QuickExpressionLayer:refreshAllShowText()
    for k, v in ipairs(self.textCells) do
        local showText = self.showLanguageList[k]
        if showText then
            v.cell:refreshShowText(showText)
        end
    end
end

function QuickExpressionLayer:handleKeyBackUp()
    if (self.isShow) then
        self:showQucikLayer(false)
        return true
    else
        return false
    end
end

function QuickExpressionLayer:onTouchBegan(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    for k, value in ipairs(self.expressionNodes) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            value:setScale(1.03)
            return
        end
    end
  
    for k, value in ipairs(self.textCells) do
        if AvalonUtil:isRectContainsPoint(value.cell, location) then
            self.selectTextIndex = k
            value.cell.textLabel:setScale(1.03)
            if self.schedulerID ~= 0 then
                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
                self.schedulerID = 0
            end
            if self.isEditorMode then
                self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.showHightText), 1, false)
            end
            return
        end
    end

    -- if not AvalonUtil:isRectContainsPoint(self.scrollView, location) then
    --     self:onTouchDialogOutsizeHandler()
    -- end
end

function QuickExpressionLayer:onTouchMoved(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchMoved")
    if self.schedulerID ~= 0 then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
    if self.isDrag then
        local touchPosition = touch:getLocation()
        local localPosOnScrollView = self.scrollView:convertToNodeSpace(touchPosition)
        if localPosOnScrollView.y < -textCellSize.height then
            self:beginAutoScrollView(true, touchPosition)
        elseif localPosOnScrollView.y  > self.scrollView:getContentSize().height + 1 then
            self:beginAutoScrollView(false, touchPosition)
        else
            self:endAutoScrollView()
            self:changeHightTextPos(touchPosition)
        end
    end
end

function QuickExpressionLayer:onTouchEnded(touch, event)
    -- print("--------------------------QuickExpressionLayer onTouchEnded  self.selectTextIndex = "..self.selectTextIndex)
    if self.schedulerID ~= 0 then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
    for k, value in ipairs(self.expressionNodes) do
        value:setScale(1)
    end
  
    for k, value in ipairs(self.textCells) do
        value.cell.textLabel:setScale(1)
    end

    self:endAutoScrollView()
    local location = touch:getLocation()
    if not self.isDrag and not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    for k, value in ipairs(self.expressionNodes) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            self:onSelectedExpression(value)
            return
        end
    end

    self.beginTouchPosition = nil
    if self.isDrag then
        self.scrollView:enableScrolling()
        local hightText = self.textCells[self.selectTextIndex].cell
        if hightText then
            hightText:onNormal()
        end
        hightText:setPositionY(self.textCells[self.selectTextIndex].posY)
        self.hightTextorginPosY = 0
    end
    self.isDrag = false

    for k, value in ipairs(self.textCells) do
        if AvalonUtil:isRectContainsPoint(value.cell, location) and self.selectTextIndex == k and not self.isEditorMode then
            self:onSelectedLanguage(value.cell)
            break
        end
    end
    self.selectTextIndex = 0
end

-- 点击外部区域的处理器(关闭)(可选)
function QuickExpressionLayer:onTouchDialogOutsizeHandler()
    -- print("--------------------------QuickExpressionLayer onTouchDialogOutsizeHandler")
    self:showQucikLayer(false)
end

function QuickExpressionLayer:onselectMode(isEditorMode)
    if isEditorMode  then
        self.editorLabel:hide()
        for k, v in ipairs(self.textCells) do
            v.cell:onEditorMode(true)
        end
        self.rightImg:show()
    else
        self.editorLabel:show()
        for k, v in ipairs(self.textCells) do
            v.cell:onEditorMode(false)
        end
        self.rightImg:hide()
    end

    if self.isEditorMode then--获取改变后的文本list并刷新
        local tempList = {}
        for k, v in ipairs(self.textCells) do
            table.insert(tempList, v.cell._showText)
        end
        local isDiff = table.compare(self.showLanguageList, tempList)
        if isDiff then
            self.showLanguageList = clone(tempList)
            self:refreshAllShowText()
            self:writeNewFlagList()
        end
    else 
            
    end
    self.isEditorMode = isEditorMode 
end

function QuickExpressionLayer:showHightText()
    self.isDrag = true
    self.scrollView:disableScrolling()
    local hightText = self.textCells[self.selectTextIndex].cell
    if hightText then
        hightText:onSelected()
        self.hightTextorginPosY = hightText:getPositionY()
    end
end

function QuickExpressionLayer:changeHightTextPos(touchPosition)
    local localPosition = self.layout:convertToNodeSpace(touchPosition)
    local beginInnerTouchPosition = self.layout:convertToNodeSpace(self.beginTouchPosition)
    
    local hightText = self.textCells[self.selectTextIndex].cell
    local addDis = (localPosition.y - beginInnerTouchPosition.y)
    local lastPosY = hightText:getPositionY()
    hightText:setPositionY(self.hightTextorginPosY + addDis)
    local changeIndex = 0
    for k, v in ipairs(self.textCells) do
        local tagerPosY = v.posY
        if v.cell and (tagerPosY - hightText:getPositionY()) * (tagerPosY  - lastPosY) < 0 then
            changeIndex = k
            break
        end
    end

    if changeIndex == 0 then
        return
    end
    local increment = self.selectTextIndex < changeIndex and 1 or -1--选中块是在往下移动 ， 被交换的块往上移动
    for index = self.selectTextIndex, changeIndex, increment do
        local value = self.textCells[index]
        if index == changeIndex then
            value.cell = hightText
            self.selectTextIndex = index
        else
            value.cell = self.textCells[index + increment].cell
            value.cell:setPositionY(value.posY)
            local moveto = cc.MoveTo:create(0.1,cc.p(value.cell:getPositionX(), value.posY))
            value.cell:runAction(moveto)
        end
    end
end

function QuickExpressionLayer:beginAutoScrollView(isAutoScrollToDowm, touchPosition)
    self.isAutoScrollToDowm = isAutoScrollToDowm
    self.touchMovePosition = touchPosition
    if self.autoMoveSchedulerID == 0 then
        self.autoMoveSchedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.autoScrollView), 0, false)
    end
end

function QuickExpressionLayer:autoScrollView()
    local step = self.isAutoScrollToDowm and 2.4 or -2.4
    local percentVertical = self.scrollView:getScrolledPercentVertical()
    local target = percentVertical + step
    if target < 0 or target > 100 then
        return
    end
    self.scrollView:scrollToPercentVertical(target)
    self.beginTouchPosition.y = self.beginTouchPosition.y + (self.layout:getContentSize().height - self.scrollView:getContentSize().height) * step / 100
    self:changeHightTextPos(self.touchMovePosition)
end

function QuickExpressionLayer:endAutoScrollView()
    if self.autoMoveSchedulerID ~= 0 then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.autoMoveSchedulerID)
        self.autoMoveSchedulerID = 0
    end
end

--
function QuickExpressionLayer:writeNewFlagList()
    Avalon.FileManager:saveMapDataToLocal(self.showLanguageList, fileName, true)
end

function QuickExpressionLayer:readNewFlagList()
    self.isReadCache = true
    self.showLanguageList = Avalon.FileManager:readMapDataFromLocal(fileName, true)
    -- dump(self.mailNewCache, "-----MailManager:readNewFlagList()")
end
