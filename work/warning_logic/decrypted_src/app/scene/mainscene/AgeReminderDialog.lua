-- AgeReminderDialog.lua
-- Author:lilinfeng
-- 2021年5月25日
-- Using:适龄描述

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local AgeReminderDialog = class("AgeReminderDialog", UI.DownShowWin)
UI.AgeReminderDialog = AgeReminderDialog

local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.NoticeModel")

-- private:
local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
    "ui_general_notice.plist"
}

-- 构造函数
function AgeReminderDialog:ctor(closeCallback)
    AgeReminderDialog.super.ctor(self, UIType.AGE_REMINDER, COM_RES_LIST, winSize.width, winSize.height)
    self:init(closeCallback)
    -- local curTime = os.time()
    -- cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.AgeReminderDialogLastShowTime, curTime)
end

-- 析构函数
function AgeReminderDialog:dtor()
    AgeReminderDialog.super.dtor(self)
end

-- 初始化
function AgeReminderDialog:init(closeCallback)
    self._closeCallback = closeCallback
    AgeReminderDialog.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:setCloseFinishCallBack(handler(self, function()
        if self._closeCallback then
            self:_closeCallback()
        end
    end))
end

-- 初始化视图
function AgeReminderDialog:onInitView()
    self.noticeModel = model.create("Notice")
    self.noticeModel.root:center()
    self:addChild(self.noticeModel.root)
    self:setSize(self.noticeModel.root._width - 80, self.noticeModel.root._height)
    self.bg = self.noticeModel.root

    local width = self.noticeModel.noticeContentTitle._width
    width = width + 70
    self.noticeModel.noticeContentTitleBg:setSize(width, self.noticeModel.noticeContentTitleBg._height)

    self.noticeModel.noticeTitle:setText( LanguageManager:getInstance():getLocalString(1114065))
    self.noticeModel.noticeContentTitleBg:setVisible(false)

end

-- 更新视图
function AgeReminderDialog:onUpdateView()
    if self._scrollView then
        self._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self._scrollView:setScrollBarWidth(5)
    end
end

--展示富文本 公告内容
function AgeReminderDialog:delayUpdateView()   
    -- local content = UI.RichText:create()
    local content = UI.Text:create()
    content:init(LanguageManager:getInstance():getLocalString(1114064), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    content:setWidth(600)

    local heightOffset = 15

    local contentLayer = self.noticeModel.contentLayer;
    local height = content:getContentSize().height
    if height < 320 then
        content:leftUp(10, heightOffset)
        contentLayer:addChild(content)
    else
        local upLayout = UI.Layout:create()
        upLayout:init()
        content:leftUp(10, heightOffset)
        upLayout:setSize(640, height + heightOffset)
        upLayout:addChild(content)

        local scrollView = UI.ScrollView:create()
        scrollView:setSize(contentLayer._width + 10, contentLayer._height)
        scrollView:init(0, 0, 0, 0)
        scrollView:addInnerNode(upLayout)
        contentLayer:addChild(scrollView)
        scrollView:setScrollBarEnabled(true)
        scrollView:setScrollBarWidth(5)
        scrollView:setCircleVisible(false)
        scrollView:setScrollBarPositionFromCornerForVertical(cc.p(1, 0))
        self._scrollView = scrollView
    end

    content:autoAdapt()
end

function AgeReminderDialog:showNotice()
    self:setOpeCallBack(handler(self, function()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if self.delayUpdateView then
                self:delayUpdateView()
            end
        end, 1)
    end))
    self:open();
end


