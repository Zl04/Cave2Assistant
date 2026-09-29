------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/19
--desc	: UI - 购买补给分配 或 填充部分分配
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortSupplyItemView = class("BigSailPortSupplyItemView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

local SceneManager = require("app.game.SceneManager")

-- 资源
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

local COM_WIDTH = 852
local COM_HEIGHT = 534
local bigSailConfig = ConfigManager:getAllNavigationGeneralConfigData()[1]
local constNum = string.split(bigSailConfig.buySupplyConsume, ",")
local CRYSTAL_COST = constNum[2] -- 每个补给购买所需要的水晶数量
local CRYSTAL_GOODS_ID = constNum[1] -- 每个补给购买所需要的水晶数量
local winSize = cc.Director:getInstance():getWinSize()

local TYPE = {
    buy = "buy", -- 购买补给界面
    add = "add", -- 船只添加补给界面
}

function BigSailPortSupplyItemView:ctor(data)
    BigSailPortSupplyItemView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    print(debug.traceback("BigSailPortSupplyItemView"))
    self:bindModel()
    self.useNum = data.maxNum - data.nowNum -- 当前的可以补充的最大上限
    self.haveNum = data.nowNum -- 当前的补给数
    self.initMinNum = data.minNum -- 初始化滑动按钮左侧值
    self.curPillSelectNum = self.initMinNum
    self.type = data.type
    self.boatId = data.boatId
end

function BigSailPortSupplyItemView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortSupplyItemView.super.init(self, ... )
end

function BigSailPortSupplyItemView:dtor()
    BigSailPortSupplyItemView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortSupplyItemView")
end


function BigSailPortSupplyItemView:onInitView()
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

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box5.png")
    --bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    --bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    local title  = UI.Image:create()
    title:init("ui_setup_banner_box4.png")
    title:center(0, -140)
    self.contentLayout:addChild(title)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local str1 = ""
    if TYPE.add == self.type then
        str1 = UI.TEXT_226102
    else
        str1 = UI.TEXT_226100
    end
    local titleText = UI.Text:create()
    titleText:init(str1, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0,0)
    title:addChild(titleText)

    -- 等级变化显示
    local levelLimitBanner = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box4.png")
    levelLimitBanner:setContentSize(278, 28)
    levelLimitBanner:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT / 2 + 77))
    self.contentLayout:addChild(levelLimitBanner)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local str2 = ""
    if TYPE.add == self.type then
        str2 = UI.TEXT_226103
    else
        str2 = UI.TEXT_226101
    end
    local nowSupplyText = UI.Text:create()
    nowSupplyText:init(str2..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nowSupplyText:center(-55,0)
    levelLimitBanner:addChild(nowSupplyText)

    -- UNSUCCESS_TAB 缺少补给道具图片
    local goodsData = ConfigManager:getVirtualItemConfigByID(23460001)
    local nowSupplyPic = UI.Image:create()
    nowSupplyPic:init(goodsData.miniIcon)
    nowSupplyPic:center(68,0)
    levelLimitBanner:addChild(nowSupplyPic)

    -- 当前的补给数量
    local nowSupplyNumShow = UI.Text:create()
    nowSupplyNumShow:init(tostring(self.haveNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 239, g = 199, b = 81})
    nowSupplyNumShow:center(100,0)
    levelLimitBanner:addChild(nowSupplyNumShow)
    self.afterText = nowSupplyNumShow

    self:initBar()
    self:initBtn()
end

function BigSailPortSupplyItemView:initBar()
    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:center(0, 40)
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
            self.numPopTxt:setText(tostring(self.initMinNum))
            self.curPillSelectNum = self.initMinNum
        else
            local realNum = math.floor(self:getPillShowNum() * curX/maxX)
            if realNum == 0 then
                realNum = 0
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
    numTxt:init(tostring(self.initMinNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    -- 滑动左侧
    local numLeftTxt = UI.Text:create()
    numLeftTxt:init(tostring(self.initMinNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numLeftTxt:center(-maxX / 2 - 35,0)
    numPrgBar:addChild(numLeftTxt)

    -- 滑动右侧
    local numRightTxt = UI.Text:create()
    numRightTxt:init(tostring(self.useNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numRightTxt:center(maxX / 2 + 35,0)
    numPrgBar:addChild(numRightTxt)
end

function BigSailPortSupplyItemView:initBtn()
    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("BigSailPort", "BigSailPortSupplyItem")
    end)
    no:center(-100, 130)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- UNSUCCESS_TAB
        -- 这里要判断提示水晶不足的情况
        if TYPE.add == self.type then
            -- 设置船员补给
            if self.curPillSelectNum == 0 then
                UI.ScrollBar:createByText(UI.TEXT_226106)
                return 
            end
            local data = {}
            data.supplyAmount = self.curPillSelectNum 
            data.boatId = self.boatId
            Net.NetBigSailSystem:reqSetBoatSupply(data)
            mvc.closePanel("BigSailPort", "BigSailPortSupplyItem")
        else
            --self.curPillSelectNum = 100000000
            local goodNumber = 0
            if tonumber(CRYSTAL_GOODS_ID) == 23020001 then
                goodNumber = RoleDataManager:getMaster():getCurCoin()
            else
                goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(CRYSTAL_GOODS_ID), true)
            end
            if goodNumber < tonumber(self.curPillSelectNum) then
                if tonumber(CRYSTAL_GOODS_ID) == 23030001 then
                    UI.ScrollBar:createByText(UI.TEXT_222209)
                elseif tonumber(CRYSTAL_GOODS_ID) == 23020001 then
                    UI.ScrollBar:createByText(UI.TEXT_110210)
                else
                    UI.ScrollBar:createByText(UI.TEXT_110210)
                end
                return
            end
            -- 请求购买补给
            local data = {}
            data.num = self.curPillSelectNum 
            Net.NetBigSailSystem:reqBuySupply(data)
            mvc.closePanel("BigSailPort", "BigSailPortSupplyItem")
        end
    end)
    yes:center(110, 130)
    self.contentLayout:addChild(yes)

    -- 消耗的水晶
    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(CRYSTAL_GOODS_ID))
    local crystalPic  = UI.Image:create()
    crystalPic:init(goodsData.miniIcon)
    crystalPic:center(-10, -35)
    yes:addChild(crystalPic)


    -- 消耗的水晶数量
    local crystalTitile  = UI.Text:create()
    crystalTitile:init("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    crystalTitile:center(30, 0)
    crystalPic:addChild(crystalTitile)
    self.crystalTitileNum = crystalTitile

    if TYPE.add == self.type then
        crystalPic:setVisible(false)
    end
end

function BigSailPortSupplyItemView:updateLvPrgBarShow()
    self.afterText:setText(tostring(self.haveNum + self.curPillSelectNum))
    self.crystalTitileNum:setText(tostring(self.curPillSelectNum * CRYSTAL_COST))
end

function BigSailPortSupplyItemView:getPillShowNum()
    return self.useNum
end


function BigSailPortSupplyItemView:bindModel()
    
end

function BigSailPortSupplyItemView:unbindModel()
end

return BigSailPortSupplyItemView












