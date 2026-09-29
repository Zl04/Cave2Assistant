-- MailCell.lua
-- Author:ydli
-- 2017年10月24日
-- Using:邮件列表 cell

local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local MailCell = class("MailCell", UI.HWBtnComponent)
UI.MailCell = MailCell

local GameDataManager = require("app.game.GameDataManager")
local scheduler = cc.Director:getInstance():getScheduler()
local LanguageManager = require("app.game.LanguageManager")
require("app.ui.mail.MailInfoLayer")

local COM_RES_LIST = {
}
local layerSize = cc.size(650, 90) 
function MailCell:ctor(data, idx, tableView, cellState)
    MailCell.super.ctor(self, UIType.MAIL_CELL, COM_RES_LIST, layerSize.width, layerSize.height)
    self.rootLayer = nil          --root节点
    self.data = data
    self.tableView = tableView
    self.schedulerID = nil
    self.cellState = cellState
    self.cellIdx = idx
    self:init()
    self:registerListener()
end

function MailCell:dtor()
    MailCell.super.dtor(self)
    -- self:setInterceptTouches(false)
    self.rootLayer = nil          --root节点
    self.data = nil
    self.cellIdx = nil
    self.choiceLogo = nil
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    self:unRegisterListener()
end

-- public:
-- 初始化
function MailCell:init()
    MailCell.super.init(self)
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update),60,false)
end

function MailCell:update(dt)
    if self.refreshTime ~= nil then
        self:refreshTime()
    end
end

-- 模版函数：初始化组建的视图
function MailCell:onInitView()    
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(layerSize.width, layerSize.height)
    bg:center()
    self:addChild(bg)
    self.bg = bg
    -- bg:enableDebugDraw()
    -- --time
    local remainTime = UI.Text:create()
    remainTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_88_65_34)
    remainTime:setTextLeft()
    remainTime:leftUp(578, 8)
    self.bg:addChild(remainTime, 4)
    self.remainTime = remainTime

    local senderBg = UI.Image:create()
    senderBg:init("ui_mailbox_text.png")
    senderBg:leftUp(25, 4)
    self.bg:addChild(senderBg, 2)
    self.senderBg = senderBg

    local createTime = UI.Text:create()
    createTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_155_155_155)
    createTime:setTextLeft()
    createTime:rightUp(220,14)
    self.senderBg:addChild(createTime, 2)
    self.createTime = createTime

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(615, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setAnchorPoint(cc.p(0, 0))
    lineUpImage:setPosition(cc.p(20, 0))
    self.bg:addChild(lineUpImage)
    if self.cellState == Game.CELL_STATE.NOMAL then
        local rewardIcon = UI.Image:create()
        rewardIcon:init("ui_mailbox_icon_treasure.png")
        rewardIcon:leftBottom(565, 7)
        self.bg:addChild(rewardIcon, 10)
        self.rewardIcon = rewardIcon
    else
        local choiceLogo = UI.Image:create()
        choiceLogo:init("ui_btn_choice_1.png")
        choiceLogo:center()
        choiceLogo:hide()

        local choiceButton = UI.Button:create()
        choiceButton:init("ui_btn_choice_0.png","ui_btn_choice_0.png","ui_btn_choice_0.png")
        choiceButton:leftBottom(565, 10)
        choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            choiceLogo:setVisible(not choiceLogo:isVisible())
            if choiceLogo:isVisible() then
                Game.MailManager:getInstance():insertDelId(self.data.mailID)
            else
                Game.MailManager:getInstance():removeDelId(self.data.mailID)
            end
        end)
        self.bg:addChild(choiceButton)
        choiceButton:addChild(choiceLogo, 10)
        if self.cellState == Game.CELL_STATE.DEL_AND_NO_SELECT then
            choiceLogo:hide()
        elseif self.cellState == Game.CELL_STATE.DEL_AND_SELECTED then
            choiceLogo:show()
        end
        self.choiceLogo = choiceLogo
    end
    self:reload(self.data, self.cellIdx)
end

-- 模版函数：更新组建的视图
function MailCell:onUpdateView()
   
end

function MailCell:reload(data, idx)
    if(data) then
        self.data = data
    end
    self.cellIdx = idx
    self.createTime:setText(string.format("(%s)", GameManager:getNowServerDate("%Y.%m.%d", self.data.createTime + GameManager:getEPOCHTime())))
    local createTimePosX = 1
    if self.data.title ~= nil and self.data.title ~= "" then
        self.senderBg:removeChildByName("SENDER")
        local sender = UI.RichText:create()
        local isOk = sender:initForNetJson(self.data.title, 100, 0, true)            
        if isOk then
            sender:leftBottom(8, 4)
            sender:setName("SENDER")
            self.senderBg:addChild(sender, 2)
            createTimePosX = sender:getContentSize().width + 16
        end
    end
    if self.data.content ~= nil and self.data.content ~= "" then
        self.bg:removeChildByName("CONTENT")
        local content = self:createRichText(self.data)
        if content then
            content:leftUp(28, 42)
            self.bg:addChild(content)
            content:setName("CONTENT")
        end
    end

    local newAction = self.senderBg:getChildByName("NEW")
    if Game.MailManager:getInstance():isNewFlagByMailId(self.data.mailID) then
        if newAction == nil then
            newAction = ToolsUtil:playNewAction(self.senderBg)
            newAction:setName("NEW")
            newAction:rightUp(10, 10)
        end
        newAction:show()
    else
        if newAction then
            newAction:hide()
        end
    end

    self.createTime:leftBottom(createTimePosX, 5)
    self:refreshTime()
    self:refershSelectState(self.data.mailID)
end

-- 注册监听事件(可选)
function MailCell:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_RETFRESH_MAIL_LIST_CELL, self, self.refershCell)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, self, self.refershSelectState)
end

-- 注销监听事件(可选)
function MailCell:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_RETFRESH_MAIL_LIST_CELL, self, self.refershCell)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, self, self.refershSelectState)
end

function MailCell:refreshTime()
    local curTime = GameManager:getNowServerTime()
    local waitingTime = self.data.outTime + GameManager:getEPOCHTime() - curTime

    local hours = math.ceil(waitingTime / SECONDS_ONE_HOUR)
    if hours <= 1 then
        self.remainTime:setFontColor(UI.FONT_COLOR_181_32_32)
        self.remainTime:setText("<1"..UI.TEXT_111033)
        if self.bg:getChildByName("clockIcon") ~= nil then
            self.bg:removeChildByName("clockIcon")
        end
        if self.bg:getChildByName("clockAnim") == nil then
            local clockAnim = UI.Animation:create()
            clockAnim:init("effect_ui_package_task_banner_clock.json", "effect_ui_package_task_banner_clock.atlas")
            clockAnim:leftUp(self.remainTime:getLeft() - clockAnim:getContentSize().width - 11, 22)
            clockAnim:setName("clockAnim")
            self.bg:addChild(clockAnim, 2)
            clockAnim:setAnimation("idle",true)
        end
    else
        local timeStr = ""
        if hours < 24 then
            timeStr = hours..UI.TEXT_111033
        else
            local day = math.ceil(waitingTime / SECONDS_ONE_DAY)
            timeStr = day..UI.TEXT_1170921 
        end

        if self.bg:getChildByName("clockAnim") ~= nil then
            self.bg:removeChildByName("clockAnim")
        end
        self.remainTime:setFontColor(UI.FONT_COLOR_41_41_45)
        self.remainTime:setText(timeStr)
        if self.bg:getChildByName("clockAnim") ~= nil then
            self.bg:removeChildByName("clockAnim")
        end
        if self.bg:getChildByName("clockIcon") == nil then
            local clockIcon = AvalonUtil.createClockAnimation()
            clockIcon:leftUp(self.remainTime:getLeft() - clockIcon:getContentSize().width - 4, 4)
            self.bg:addChild(clockIcon)
            clockIcon:setName("clockIcon")            
        end
    end
end


function MailCell:refershCell(mailId, isRemove)
    if self.data == nil then
        return
    end
    self.parentLayer:setCanAcceptAward(true)
    if mailId == self.data.mailID and isRemove then
        -- print("----------mailId = "..mailId.."   and self.data.mailID = "..self.data.mailID)
        self.tableView:removeCellAtIndexAndPlayAction(self.cellIdx, 0.2)
    end
end

function MailCell:refershSelectState(mailId)
    if self.data == nil then
        return
    end
    if mailId == self.data.mailID then
        if self.cellState ~= Game.CELL_STATE.NOMAL then 
            self.choiceLogo:setVisible(Game.MailManager:getInstance():getOneMailDelSelected(self.data.mailID))
        end
        if self.data.rewardStat == PublicDefine.MAIL_REWARD_STATE.MailRewardStat_Rewarded then
            if self.rewardIcon then
                self.rewardIcon:hide()
            end
        else
            if self.rewardIcon then
                self.rewardIcon:show()
            end
        end
        if table.nums(self.data.goodsIDs) == 0 and table.nums(self.data.InstEquips) == 0 and table.nums(self.data.InstPets) == 0 and table.nums(self.data.glyphs) == 0 then
            if self.rewardIcon then
                self.rewardIcon:hide()
            end
        end
        local newAction = self.senderBg:getChildByName("NEW")
        if Game.MailManager:getInstance():isNewFlagByMailId(self.data.mailID) then
            if newAction == nil then
                newAction = ToolsUtil:playNewAction(self.senderBg)
                newAction:setName("NEW")
                newAction:rightUp(10, 10)
            end
            newAction:show()
        else
            if newAction then
                newAction:hide()
            end
        end
    end
end

function MailCell:showInfoLayer()
    local infoLayer = UI.MailInfoLayer:create(self.data)
    infoLayer:center()
    self.parentLayer:addChild(infoLayer, 10000)
    infoLayer:openShow()
    Game.MailManager:getInstance():removeNewFlag(self.data.mailID)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_RETFRESH_ONE_MAIL_INFO, self.data.mailID)
end

function MailCell:setParentLayer(parentLayer)
    self.parentLayer = parentLayer
end

function MailCell:createRichText(mailData)
    print("  mailData ======= ",mailData)
    local _richText = nil
    _richText = Game.MailManager:getInstance():getRichTextCache(mailData.mailID)
    if _richText and _richText:getParent() == nil then
    else
        _richText = UI.RichText:create()
        success = _richText:initForNetJsonWithSWidth(mailData.content, 451, 16, nil, 100, 800)
        if success == false then
            return
        end
        _richText:retain()
        Game.MailManager:getInstance():insertRichTextCache(mailData.mailID, _richText)
    end
    _richText:setName(mailData.mailID)
    return _richText
end

