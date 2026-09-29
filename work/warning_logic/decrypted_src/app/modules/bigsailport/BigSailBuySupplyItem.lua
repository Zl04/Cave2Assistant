--[[
    UI - 购买补给分配
]]--

UI = UI or {}

local BigSailBuySupplyItem = class("BigSailBuySupplyItem", UI.HWBtnComponent)
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
UI.BigSailBuySupplyItem = BigSailBuySupplyItem
local SdkBox = require("utils.sdkbox.SdkBox")

local SceneManager = require("app.game.SceneManager")

local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_general_shop.plist",
    "ui_common_symbol.plist",
}

---------------------
-- 没有完成的注释标记
-- UNSUCCESS_TAB
---------------------

local COM_WIDTH = 850
local COM_HEIGHT = 522
local CRYSTAL_COST = 1 -- 每个补给购买所需要的水晶数量
local winSize = cc.Director:getInstance():getWinSize()

function BigSailBuySupplyItem:ctor(data)
    BigSailBuySupplyItem.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.useNum = data.maxNum - data.nowNum -- 当前的可以补充的最大上限
    self.haveNum = data.nowNum -- 当前的补给数
    self.curPillSelectNum = 0
end

function BigSailBuySupplyItem:init()
    BigSailBuySupplyItem.super.init(self)
end

-- 析构函数
function BigSailBuySupplyItem:dtor()
    BigSailBuySupplyItem.super.dtor(self)
end

-- 初始化视图
function BigSailBuySupplyItem:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    local title  = UI.Image:create()
    title:init("ui_setup_banner_box4.png")
    title:center(0, -165)
    self.contentLayout:addChild(title)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local titleText = UI.Text:create()
    titleText:init("购买补给", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0,0)
    title:addChild(titleText)

    -- 等级变化显示
    local levelLimitBanner = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box4.png")
    levelLimitBanner:setContentSize(300, 28)
    levelLimitBanner:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT / 2 + 120))
    self.contentLayout:addChild(levelLimitBanner)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local nowSupplyText = UI.Text:create()
    nowSupplyText:init("当前补给数量:", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nowSupplyText:center(-90,0)
    levelLimitBanner:addChild(nowSupplyText)

    -- UNSUCCESS_TAB 缺少补给道具图片
    local nowSupplyPic = UI.Image:create()
    nowSupplyPic:init("ui_information_achievement.png")
    nowSupplyPic:center(-110,0)
    levelLimitBanner:addChild(nowSupplyPic)

    -- 当前的补给数量
    local nowSupplyNumShow = UI.Text:create()
    nowSupplyNumShow:init(tostring(self.haveNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nowSupplyNumShow:center(0,0)
    levelLimitBanner:addChild(nowSupplyNumShow)
    self.afterText = nowSupplyNumShow

    self:initBar()
    self:initBtn()
end

function BigSailBuySupplyItem:initBar()
    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:leftUp(108, 242)
    numPrgBar:setPercent(0)
    self.contentLayout:addChild(numPrgBar)
    self.numPrgBar = numPrgBar

    local maxX = numPrgBar:getContentSize().width

    local numPopPlus  = UI.Image:create();
    numPopPlus:init("ui_shop_article_3.png");
    local offsetX = numPopPlus:getContentSize().width/2
    numPopPlus:centerLeft(-offsetX);
    numPopPlus:setTouchEnable(true)
    numPopPlus:setSwallowTouches(true)
    self.numPopPlus = numPopPlus
    self.originOffsetX = offsetX
    numPopPlus:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, com, touchpos)
        local deltaX = touchpos.x-com:Local2Global().x

        if com:getPositionX()+deltaX <= -offsetX then
            com:setPosition(-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX >= maxX-offsetX then
            com:setPosition(maxX-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX > -offsetX and com:getPositionX()+deltaX < maxX-offsetX then
            com:setPosition(com:getPositionX()+deltaX, com:getPositionY())
        end

        local curX = com:getPositionX()+offsetX
        if curX == 0 then
            self.numPopTxt:setText("0")
            self.curPillSelectNum = 0
        else
            local realNum = math.floor(self:getPillShowNum() * curX/maxX)
            if realNum == 0 then
                realNum = 1
            end
            self.numPopTxt:setText(tostring(realNum))
            self.curPillSelectNum = realNum
        end

        self.numPrgBar:setPercent(curX/maxX)

        if self.curPillSelectNum ~= self.lastPillSelectNum then
            self:updateLvPrgBarShow()
            self.lastPillSelectNum = self.curPillSelectNum
        end
    end)
    numPrgBar:addChild(numPopPlus, 10);

    local numBG  = UI.Image:create();
    numBG:init("ui_shop_article_4.png");
    numBG:leftUp(-15, -60);
    numPopPlus:addChild(numBG);

    local numTxt = UI.Text:create()
    numTxt:init(tostring(0), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    -- 滑动左侧
    local numLeftTxt = UI.Text:create()
    numLeftTxt:init(tostring(0), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numLeftTxt:center(-maxX / 2 - 35,0)
    numPrgBar:addChild(numLeftTxt)

    -- 滑动右侧
    local numRightTxt = UI.Text:create()
    numRightTxt:init(tostring(self.useNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numRightTxt:center(maxX / 2 + 35,0)
    numPrgBar:addChild(numRightTxt)
end

function BigSailBuySupplyItem:initBtn()
    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:removeFromParent(self.bigSailPortSupplyView)
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- UNSUCCESS_TAB
        -- 这里要判断提示水晶不足的情况
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)

    -- 消耗的水晶
    local crystalPic  = UI.Image:create()
    crystalPic:init("symbol_gaming_diamond.png")
    crystalPic:center(-10, -30)
    yes:addChild(crystalPic)

    -- 消耗的水晶数量
    local crystalTitile  = UI.Text:create()
    crystalTitile:init("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    crystalTitile:center(10, -30)
    yes:addChild(crystalTitile)
    self.crystalTitileNum = crystalTitile
end

function BigSailBuySupplyItem:updateLvPrgBarShow()
    self.afterText:setText(tostring(self.haveNum + self.curPillSelectNum))
    self.crystalTitileNum:setText(tostring(self.curPillSelectNum * CRYSTAL_COST))
end

function BigSailBuySupplyItem:getPillShowNum()
    return self.useNum
end