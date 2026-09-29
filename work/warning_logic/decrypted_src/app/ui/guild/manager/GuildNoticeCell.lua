-- GuildNoticeCell.lua
-- Author:zp
-- 2018年7月12日
-- Using:公会公告 cell

local LanguageManager = require("app.game.LanguageManager")
local SdkManager = require"app.game.SdkManager"

-- 公告最多的字数
-- 这里要低于publicdefine里面定义的GUILD_NOTICE_LENGTH_MAX
-- 是为了适配不同输入法截断效果不一样
local NOTICE_MAX_NUM = 480

UI = UI or {}

local GuildNoticeCell = class("GuildNoticeCell",UI.TableViewCell)
UI.GuildNoticeCell = GuildNoticeCell

-- add by zp CO-8990 
local CHANGE_NOTICE_TIME = 30000
local CELL_WIDTH = 233
local CELL_HEIFHT_MIN = 160

function GuildNoticeCell:ctor()
    self._titleHeight = 0
    self.changeNoticeTime = -1
    self._touchBegin = false
end

function GuildNoticeCell:onEnter()
    GuildNoticeCell.super.onEnter(self)
end

function GuildNoticeCell:onExit()
    GuildNoticeCell.super.onExit(self)
    self._editEndCallback = nil
    self._touchBegin = false
end

function GuildNoticeCell:init(guildData, editEndCallback)
    self._guildData = guildData
    self._editEndCallback = editEndCallback

    if(self._data == nil) then 
        self._data = ""
    end

    self:onInitView()
end

function GuildNoticeCell:onInitView()
    local activityLayout = UI.Layout:create()
    activityLayout:init()
    activityLayout:setSize(CELL_WIDTH, CELL_HEIFHT_MIN)
    -- activityLayout:centerUp(0)
    self:addChild(activityLayout)
    self._activityLayout = activityLayout
    self._titleHeight = CELL_HEIFHT_MIN

    local noticeText = UI.Text:create()
    noticeText:init(self._guildData.notice, UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    noticeText:setWidth(CELL_WIDTH)
    noticeText:setTextCenter()
    -- noticeText:centerUp(0)
    -- noticeText:setText(self._guildData.notice)
    self._noticeEdit = noticeText
    self._activityLayout:addChild(noticeText)

    local editBoxSpace = 4
    local noticeEdit = cc.EditBox:create({width = CELL_WIDTH + editBoxSpace, height = CELL_HEIFHT_MIN + editBoxSpace}, "placeholder.png")
    noticeEdit:setFontSize(18)
    noticeEdit:setFontName(UI.FONT_ARIAL)
    noticeEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    noticeEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    noticeEdit:setPosition((CELL_WIDTH + editBoxSpace)/2, (CELL_HEIFHT_MIN + editBoxSpace)/2)
    noticeEdit:setFontColor(UI.FONT_COLOR_41_41_45)
    -- TODO 根据职位来判断这里显示的内容
    -- noticeEdit:setText(self._guildData.notice)
    noticeEdit:setMaxLength(NOTICE_MAX_NUM)
    noticeEdit:setVisible(false)
    noticeEdit:registerScriptEditBoxHandler(function(eventname,sender) 
        self:editboxHandle(eventname,sender)
    end)
    self._noticeEditBox = noticeEdit

    self._activityLayout:addChild(noticeEdit)

    self:updateDetail()
    self:handleTouchBegin(self._activityLayout)
end

function GuildNoticeCell:updateDetail()
    if(self._titleHeight < self._noticeEdit:getContentSize().height) then 
        self._titleHeight = self._noticeEdit:getContentSize().height
    end

    self._noticeEdit:setText(self._guildData.notice)
    -- self._noticeEditBox:setText(self._guildData.notice)

    self._activityLayout:setSize(CELL_WIDTH, self._titleHeight)
    -- self._activityLayout:centerUp(0)
    self._activityLayout:leftBottom(0, 0)
    self._activityLayout:refreshPosition()
end

function GuildNoticeCell:clickToEdit()
    if(AvalonUtil.getCurrentTime() - self.changeNoticeTime < CHANGE_NOTICE_TIME ) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110613))
        return false
    end

    -- print("GuildNoticeCell:clickToEdit") 
    if(self._noticeEdit and not tolua.isnull(self._noticeEdit)) then 
        self._noticeEdit:setVisible(false)
    end
    self._noticeEditBox:setText(self._guildData.notice)
    self._noticeEditBox:setVisible(true)
    self._noticeEditBox:openKeyboard()

    return true
end

function GuildNoticeCell:getWidht()
    -- body
    return CELL_WIDTH
end

function GuildNoticeCell:getHeight()

    return self._titleHeight
end

function GuildNoticeCell:getTouchBegin()
    return self._touchBegin
end

function GuildNoticeCell:clearTouchBegin()
    self._touchBegin = false
end

function GuildNoticeCell:editboxHandle(strEventName, sender)
    -- print("GuildNoticeCell:editboxHandle", strEventName, sender)

    if(strEventName == "began") then

    elseif (strEventName == "ended") then
        self._noticeEditBox:setVisible(false)
    elseif (strEventName == "return") then
        local inputText = self._noticeEditBox:getText()
        if(inputText) then
            local totalNum = AvalonUtil.GetUTFLenWithCount(inputText, NOTICE_MAX_NUM * 3)
            if(totalNum > NOTICE_MAX_NUM) then
                inputText = string.sub(inputText, 1, AvalonUtil.GetUTFLenWithCount(inputText, NOTICE_MAX_NUM))
            end
        end
        -- 过滤敏感字
        local mark = false
        inputText,mark = ToolsUtil:checkMaskword(inputText)
        if mark then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
        end

        self._guildData.notice = inputText
        -- self:refreshNoticeStatus()
        -- 请求表现
        self.changeNoticeTime = AvalonUtil.getCurrentTime()

        Net.NetGuildSystem:modifyNotice(RoleDataManager:getMasterPK(), inputText)
        self._noticeEdit:setText(inputText.."")
        self._noticeEdit:setVisible(true)
        self._noticeEditBox:setVisible(false)
        self._noticeEditBox:setText(inputText)
        -- AvalonUtil.closeKeyBoard(self._noticeEditBox)
        self:updateDetail()

        self._noticeEdit:stopAllActions()
        self._noticeEdit:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
            if(self._editEndCallback) then 
                self._editEndCallback()
            end
        end)))

    elseif (strEventName == "changed") then
        -- 输入内容改变时调用
        local inputText = self._noticeEditBox:getText()
        if(inputText) then
            local totalNum = AvalonUtil.GetUTFLenWithCount(inputText, NOTICE_MAX_NUM * 3)
            if(totalNum > NOTICE_MAX_NUM) then
                UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1110619), NOTICE_MAX_NUM))
                -- AvalonUtil.closeKeyBoard(self._noticeEditBox)
                -- self._noticeEditBox:setVisible(false)
            end
        end
    end
end

function GuildNoticeCell:handleTouchBegin(node)
    -- 点击开始
    local function onTouchBegan(touch, event)
        local touchPosition = touch:getLocation()
        local touched = node:checkTouch(touch)
        if (touched) then
            self._touchBegin = true
        else 
            self._touchBegin = false
        end
        print("GuildNoticeCell:handleTouchBegin", self._touchBegin)

        return false
    end
    -- 点击移动
    local function onTouchMoved(touch, event)
        
    end
    -- 点击结束
    local function onTouchEnded(touch, event)
        
    end

    -- 注册点击监听事件
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
end
