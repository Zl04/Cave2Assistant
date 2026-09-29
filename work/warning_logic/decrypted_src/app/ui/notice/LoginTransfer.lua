-- LoginTransfer.lua
-- Author:linfeng.li
-- 2025年4月22日
-- Using:登陆界面账号转移跳转界面

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local LoginTransfer = class("LoginTransfer", UI.DownShowWin)
UI.LoginTransfer = LoginTransfer

-- private:
local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
    "ui_general_notice.plist",
    "ui_common_btn.plist"
}

local content = "雷霆账号转移通知\n\n亲爱的冒险家：\n《贪婪洞窟2》手游（包括安卓和苹果系统）运营主体将于2025年5月31日由深圳雷霆信息技术有限公司（以下简称“雷霆”）变更为成都阿哇龙科技有限公司（以下简称“阿哇龙”），为保证冒险家们能够继续体验《贪婪洞窟2》手游，我们已于2025年4月14日正式开通账号转移通道，方便玩家将已有的游戏账号转移至新的运营主体下。\n\n转移说明\n① 账号转移只针对使用雷霆账号登录游戏的用户，包括：雷霆官方包、官方内测专区、TapTap、好有快爆、iOS用户；\n② 账号转移只是游戏运营商账号的更换，用户原有的游戏数据会平移继承，不会有任何丢失；\n③ 使用其他安卓应用商店下载的用户无需进行账号转移；\n④ 目前为账号转移关系绑定时期，游戏正式账号转移将于5月14日进行，5月14日游戏开服后，将必须使用阿哇龙账号登录游戏。"

-- 构造函数
function LoginTransfer:ctor()
    LoginTransfer.super.ctor(self, UIType.LOGIN_NOTICE, COM_RES_LIST, winSize.width, winSize.height)
    self:init()
end

-- 析构函数
function LoginTransfer:dtor()
    LoginTransfer.super.dtor(self)
end

-- 初始化
function LoginTransfer:init()
	self._content = content
    LoginTransfer.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

-- 初始化视图
function LoginTransfer:onInitView()

    local bg = UI.Image:create()
    bg:init("ui_general_notice_box.png")
    bg:center()
    self:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init("账号转移",UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r=170,g=170,b=170})
    titleText:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    titleText:setReflectPos(-7, 12)
    titleText:computePosition()
    bg:addChild(titleText)

    local noticeContentTitleBg = UI.Image9:create()
    noticeContentTitleBg:init("ui_general_notice_progressbar_lookup.png",{x=100,y=23,width=20,height=20})
    noticeContentTitleBg:setLayoutType(UI.LayoutDefaultType.CENTER_UP)
    noticeContentTitleBg:setReflectPos(-7, 86)
    noticeContentTitleBg:setReflectSize(177, 23)
    noticeContentTitleBg:computePosition()
    bg:addChild(noticeContentTitleBg)

    local contentLayer = UI.Component:create()
    contentLayer:init()
    contentLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentLayer:setReflectPos(140, 125)
    contentLayer:setReflectSize(623, 330)
    contentLayer:computePosition()
    bg:addChild(contentLayer)


    local goBtn = UI.Button:create()
    goBtn:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    goBtn:centerBottom(52,150)
    goBtn:setText("前往转移")
    goBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    goBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.goTransfer)
    bg:addChild(goBtn)

    local goBtn = UI.Button:create()
    goBtn:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    goBtn:centerBottom(52,-150)
    goBtn:setText("取消")
    goBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_41_41_45)
    goBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self:closeWin()
    end)
    bg:addChild(goBtn)

    self.contentLayer = contentLayer
end

-- 更新视图
function LoginTransfer:onUpdateView()
    if self._scrollView then
        self._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        self._scrollView:setScrollBarWidth(5)
    end
end

--内容
function LoginTransfer:delayUpdateView()   
    local content = UI.Text:create()
    
    content:init(self._content,UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    content:setWidth(600)
    content:autoAdapt()

    local icon = UI.Image:create()
    icon:init("ui_general_notice_icon.png")
    local heightOffset = 15

    local contentLayer = self.contentLayer;
    local height = content:getContentSize().height
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
end


function LoginTransfer:showTransfer()
    self:setOpeCallBack(handler(self, function()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if self.delayUpdateView then
                self:delayUpdateView()
            end
        end, 1)
    end))
    self:open();
end

function LoginTransfer:goTransfer()
    cc.Application:getInstance():openURL("https://actscp01.leiting.com/myzr/act/202501/transfer/?game=caveonline#/")
end