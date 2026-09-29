-- FontNameTestPanel.lua
-- Author:ydli
-- 2018年03月22日
-- Using:测试字体



UI = UI or {}

local FontNameTestPanel = class("FontNameTestPanel", UI.HWBtnComponent)
UI.FontNameTestPanel = FontNameTestPanel

-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

local COM_RES_LIST = {
}

local FONT_NAME_LIST = {
"PingFangSC-Regular",--"苹方-简 常规体"
"PingFangSC-Ultralight", --"苹方-简 极细体"
"PingFangSC-Light",--"苹方-简 细体"
"PingFangSC-Thin",--"苹方-简 纤细体"
"PingFangSC-Medium",--"苹方-简 中黑体"
"PingFangSC-Semibold",--"苹方-简 中粗体"
"Helvetica",
"AppleGothic",
"HiraKakuProN-W6",
"HiraKakuProN-W3",
"MarkerFelt-Thin",
"STHeitiK-Medium",
"STHeitiK-Light",
"TimesNewRomanPSMT",
"Helvetica-Oblique",
"Helvetica-BoldOblique",
"Helvetica-Bold",
"TimesNewRomanPS-BoldMT",
"TimesNewRomanPS-BoldItalicMT",
"TimesNewRomanPS-ItalicMT",
"Verdana-Bold",
"Verdana-BoldItalic",
"Verdana",
"Verdana-Italic",
"Georgia-Bold",
"Georgia",
"Georgia-BoldItalic",
"Georgia-Italic",
"ArialRoundedMTBold",
"TrebuchetMS-Italic",
"TrebuchetMS",
"Trebuchet-BoldItalic",
"TrebuchetMS-Bold",
"STHeitiTC-Light",
"STHeitiTC-Medium",
"GeezaPro-Bold",
"GeezaPro",
"Courier",
"Courier-BoldOblique",
"Courier-Oblique",
"Courier-Bold",
"ArialMT",
"Arial-BoldMT",
"Arial-BoldItalicMT",
"Arial-ItalicMT",
"STHeitiJ-Medium",
"STHeitiJ-Light",
"ArialHebrew",
"ArialHebrew-Bold",
"CourierNewPS-BoldMT",
"CourierNewPS-ItalicMT",
"CourierNewPS-BoldItalicMT",
"CourierNewPSMT",
"Thonburi-Bold",
"AmericanTypewriter",
"AmericanTypewriter-Bold",
"STHeitiSC-Medium",
"STHeitiSC-Light",
"HelveticaNeue",
"HelveticaNeue",
"HelveticaNeue-Bold",
"Zapfino",

"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"---android--",
"Roboto Thin",
"Roboto Light",
"Roboto Regular",
"Roboto Medium",
"Roboto Bold",
"Roboto Black",
"Roboto Thin Italic",
"Roboto Light Italic",
"Roboto Italic",
"Roboto Medium Italic",
"Roboto Bold Italic",
"Roboto Black Italic",

"Noto Thin",
"Noto Light",
"Noto Regular",
"Noto Medium",
"Noto Bold",
"Noto Black",
"Noto Thin Italic",
"Noto Light Italic",
"Noto Italic",
"Noto Medium Italic",
"Noto Bold Italic",
"Noto Black Italic",
}

-- 构造函数
function FontNameTestPanel:ctor()
    FontNameTestPanel.super.ctor(self, UIType.TEST_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

end

-- 析构函数
function FontNameTestPanel:dtor()
    FontNameTestPanel.super.dtor(self)
end

-- 初始化
function FontNameTestPanel:init()

    FontNameTestPanel.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

-- 初始化视图
function FontNameTestPanel:onInitView()
    self.rootLayer = cc.LayerColor:create(cc.c4b(128,128,128,255))
    self.rootLayer:setContentSize(COM_WIDTH, COM_HEIGHT)
    self.rootLayer:setPosition(0,0)
    self:addChild(self.rootLayer)
    self:enableDebugDraw()

    local cellHeight = 75
    local cellWidth = 300
    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(COM_WIDTH, COM_HEIGHT)
    scrollView:center()
    self:addChild(scrollView, 1)
    scrollView:setScrollBarEnabled(true)
    
    local childNumX = math.ceil(COM_WIDTH / cellWidth)
    local childNumY = math.ceil(#FONT_NAME_LIST / childNumX)

    local layout = UI.Layout:create()
    layout:init(0, 0, 0, 0)
    layout:setSize(COM_WIDTH, childNumY * cellHeight + 300)
    scrollView:addInnerNode(layout)

    for k, v in ipairs(FONT_NAME_LIST) do
        local posX = k % childNumX * cellWidth
        local posY = math.ceil(k / childNumX) * cellHeight

        local fontText = UI.Text:create()
        local showText = v
        if "---android--" ~= v then
             showText = showText .." : 中文阿哇隆??!!。。，，一二三四五六"
        end
        fontText:init(showText, v, UI.FONT_SIZE_18PX)
        fontText:setWidth(cellWidth - 20)
        fontText:setFontColor(UI.FONT_COLOR_WHITE)
        layout:addChild(fontText)
        fontText:setTextLeft()
        fontText:leftUp(posX, posY)--leftBottom(300, 549)
        fontText:autoAdapt()
        fontText:setLineSpacing(-10)
    end

    local closeText = UI.Text:create()
    closeText:init("  关  闭  ", UI.FONT_STANDARD, UI.FONT_SIZE_28PX)
    closeText:setFontColor(UI.FONT_COLOR_BLUE)
    closeText:rightUp(100, 100)--leftBottom(300, 549)
    self:addChild(closeText, 100000)

    closeText:setTouchEnable(true)
    closeText:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:clickEnd()
    end)
end

-- 更新视图
function FontNameTestPanel:onUpdateView()
    print(" FontNameTestPanel:onUpdateView  ")

end

-- 点击完成
function FontNameTestPanel:clickEnd()
    self:close()
end

function FontNameTestPanel:show()
    local testLayer = UI.FontNameTestPanel:create()
    testLayer:init()
    testLayer:center()
    cc.Director:getInstance():getRunningScene():addChild(testLayer,100000)
end


