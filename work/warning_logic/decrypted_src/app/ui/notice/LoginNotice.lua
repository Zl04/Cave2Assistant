-- LoginNotice.lua
-- Author:ydli
-- 2018年2月8日
-- Using:登陆界面公告

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local LoginNotice = class("LoginNotice", UI.DownShowWin)
UI.LoginNotice = LoginNotice

local model = require("app.uiExport.NoticeModel")

-- private:
local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
    "ui_general_notice.plist"
}

-- 构造函数
function LoginNotice:ctor(content, bottom, closeCallback)
    LoginNotice.super.ctor(self, UIType.LOGIN_NOTICE, COM_RES_LIST, winSize.width, winSize.height)
    self:init(content, bottom, closeCallback)
    local curTime = os.time()
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LoginNoticeLastShowTime, curTime)
end

-- 析构函数
function LoginNotice:dtor()
    LoginNotice.super.dtor(self)
end

-- 初始化
function LoginNotice:init(content, bottom, closeCallback)
	self._content = content
    self._bottom = bottom
    self._closeCallback = closeCallback
    LoginNotice.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:setCloseFinishCallBack(handler(self, function()
            if self._closeCallback then
                self:_closeCallback()
            end
        end))
end

-- 初始化视图
function LoginNotice:onInitView()
    self.noticeModel = model.create("Notice")
    self.noticeModel.root:center()
    self:addChild(self.noticeModel.root)
    self:setSize(self.noticeModel.root._width - 80, self.noticeModel.root._height)
    self.bg = self.noticeModel.root

    local width = self.noticeModel.noticeContentTitle._width
    width = width + 70
    self.noticeModel.noticeContentTitleBg:setSize(width, self.noticeModel.noticeContentTitleBg._height)


    local bottomTexts = self._bottom
    local showBottomText = json.encode(bottomTexts)
    local bottomRichText = UI.RichText:create()
    local success = bottomRichText:initForNetJson(showBottomText, 20, 20, true)
    if success then
        bottomRichText:rightBottom(137, 72)
        self.bg:addChild(bottomRichText, 10)
    end
-- bottomRichText:enableDebugDraw()
end

-- 更新视图
function LoginNotice:onUpdateView()
    if self._scrollView then
        self._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self._scrollView:setScrollBarWidth(5)
    end
end

--展示富文本 公告内容
function LoginNotice:delayUpdateView()   
    local content = UI.RichText:create()
    local success = content:initForNetJson(json.encode(self._content), 600, 30)
    -- content:enableDebugDraw(UI.RED)
    if success then
        local icon = UI.Image:create()
        icon:init("ui_general_notice_icon.png")
        local heightOffset = 15

        local contentLayer = self.noticeModel.contentLayer;
        local height = content:getRichTextHeight()
        if height < 320 then
        	content:leftUp(30, heightOffset)
            contentLayer:addChild(content)
            content:addChild(icon)
            icon:leftUp(-icon._width - 3, 1)
        else
        	local upLayout = UI.Layout:create()
            upLayout:init()
            content:leftUp(25, heightOffset)
            upLayout:setSize(640, height + heightOffset)
            upLayout:addChild(content)
            upLayout:addChild(icon)
            icon:leftUp(0, heightOffset + 1)

            local scrollView = UI.ScrollView:create()
            scrollView:setSize(contentLayer._width + 10, contentLayer._height)
            scrollView:init(0, 0, 0, 0)
            scrollView:addInnerNode(upLayout)
            -- scrollView:scrollToTop()
            contentLayer:addChild(scrollView)
            scrollView:setScrollBarEnabled(true)
            scrollView:setScrollBarWidth(5)
            scrollView:setCircleVisible(false)
            scrollView:setScrollBarPositionFromCornerForVertical(cc.p(1, 0))
            self._scrollView = scrollView
            -- scrollView:enableDebugDraw()
        end
    end 
end

function LoginNotice:showNotice()
    self:setOpeCallBack(handler(self, function()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if self.delayUpdateView then
                self:delayUpdateView()
            end
        end, 1)
    end))
    self:open();
end
