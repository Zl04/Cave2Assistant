------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/11/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphRefinedItemView = class("GlyphRefinedItemView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

UI.GlyphRefinedItemView = GlyphRefinedItemView

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_general_shop.plist",
    "ui_common_symbol.plist",
    "ui_town_glyphs.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

local winSize = cc.Director:getInstance():getWinSize()

function GlyphRefinedItemView:ctor(data)
    GlyphRefinedItemView.super.ctor(
    	self,
    	UI.Type.GLYPHS_REFINED_MANYTIMES,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.useNum = 100 -- 当前的可以补充的最大上限
    self.curPillSelectNum = 1
    self.isPay = data.isPay and true or false
    self.glyphData = data.glyphData
    self.costEverTime = {}

    local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
    local configConsume = nil
    if self.isPay then
        self.constConfig = string.split(costConfig.glyphPayRefinedConsume, ";")
        for k,v in pairs(self.constConfig) do
            local final = string.split(v, ",")
            table.insert(self.costEverTime, final[2])
        end
    else
        self.constConfig = {costConfig.glyphCommonRefinedConsume}
        local final = string.split(costConfig.glyphCommonRefinedConsume, ",")
        table.insert(self.costEverTime, final[2])
    end

    -- 设置每次消耗材料数量
    local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
    local configConsume = nil
    if self.isPay then
        configConsume = costConfig.glyphPayRefinedConsume
    else
        configConsume = costConfig.glyphCommonRefinedConsume
    end
    local final = string.split(configConsume, ",")

    self._sellText = {}
    self.attrBtnList = {}

    self:setUseNum()
    self:bindModel()
end

function GlyphRefinedItemView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.glyphs", "Glyphs", false)
    GlyphRefinedItemView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:removeFromParent()
    end)
end

function GlyphRefinedItemView:dtor()
    GlyphRefinedItemView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.glyphs.GlyphRefinedItemView")
end


function GlyphRefinedItemView:onInitView()
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

    local bgImage  = UI.Image:create()
    bgImage:init("ui_glyphs_paper1.png")
    bgImage:center(0, 0)
    self.contentLayout:addChild(bgImage)

    -- local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_glyphs_paper1.png")
    -- bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    -- bgImage:setCapInsets(CCRectMake(684/2, 456/2, 1, 1))
    -- bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    -- self.contentLayout:addChild(bgImage)

    -- UNSUCCESS_TAB 缺少ui.text12312
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_227019, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 43, g = 43, b = 47})
    titleText:centerUp(51)
    self.contentLayout:addChild(titleText)

    -- 勾选描述
    local choseText = UI.Text:create()
    choseText:init(UI.TEXT_227024, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 43, g = 43, b = 47})
    choseText:centerUp(90)
    self.contentLayout:addChild(choseText)

    -- 设置次数描述
    local timesText = UI.Text:create()
    timesText:init(UI.TEXT_227025, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 43, g = 43, b = 47})
    timesText:center(0,18)
    self.contentLayout:addChild(timesText)

    self:initBar()
    self:initBtn()
end

function GlyphRefinedItemView:initBar()
    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_glyphs_bg_3.png", nil, "ui_glyphs_bg_3.png")
    numPrgBar:center(0, 108)
    numPrgBar:setPercent(0)
    self.contentLayout:addChild(numPrgBar)
    self.numPrgBar = numPrgBar

    local maxX = numPrgBar:getContentSize().width

    local numPopPlus  = UI.Image:create();
    numPopPlus:init("ui_glyphs_btn_add.png");
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
            self.numPopTxt:setText("1")
            self.curPillSelectNum = 1
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

    local color = {r = 43, g = 43, b = 47}

    local numBG  = UI.Image:create();
    numBG:init("ui_glyphs_btn_6.png");
    numBG:center(0, -numPopPlus:getContentSize().height);
    numPopPlus:addChild(numBG);

    local numTxt = UI.Text:create()
    numTxt:init(tostring(1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, color)
    numTxt:centerUp(0)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    -- 滑动左侧
    local numLeftTxt = UI.Text:create()
    numLeftTxt:init(tostring(1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, color)
    numLeftTxt:center(-maxX / 2 - 35,0)
    numPrgBar:addChild(numLeftTxt)

    -- 滑动右侧
    local numRightTxt = UI.Text:create()
    numRightTxt:init(tostring(self.useNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, color)
    numRightTxt:center(maxX / 2 + 35,0)
    numPrgBar:addChild(numRightTxt)
end

function GlyphRefinedItemView:initBtn()
    -- -- 取消按钮
    -- local no = UI.Button:create()
    -- no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    -- no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     self:removeFromParent()
    -- end)
    -- no:leftBottom(51, 32)
    -- self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_glyphs_btn_5.png", "ui_glyphs_btn_5.png", "ui_glyphs_btn_5.png")
    yes:setText(UI.TEXT_227026)
    yes:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 43, g = 43, b = 47})
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- UNSUCCESS_TAB
        -- 这里要判断提示水晶不足的情况
        if self:isAllowBegin() then
            local selcetAttr = {}
            for k,btn in pairs(self.attrBtnList) do
                if btn.select then
                    table.insert(selcetAttr, btn.attrType)
                end
            end

            local data = {}
            data.times = self.curPillSelectNum
            data.isPay = self.isPay
            data.selcetAttr = selcetAttr
            data.valueSelect = self.btnValue.select
            data.isQuick = self.quitBtn.select
            Avalon.MessageCenter:notice(GameMessage.MC_NPC_GLYPH_REFINED_MANY_TIMES, data)
            self:removeFromParent()
        end
    end)
    yes:center(0, 185)
    self.contentLayout:addChild(yes)

    --------------------------------------------
    for k,v in pairs(self.constConfig) do
        -- 背景底图
        local offsetX = (#self.constConfig > 1) and -15 + (k - 1) * 100 or 30
        local sellIcon = UI.Layout:create()
        sellIcon:init()
        sellIcon:setSize(300, 28)
        sellIcon:center(offsetX, -45)
        yes:addChild(sellIcon)

        -- 消耗的材料
        local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
        local configConsume = nil
        if self.isPay then
            configConsume = costConfig.glyphPayRefinedConsume
        else
            configConsume = costConfig.glyphCommonRefinedConsume
        end
        local final = string.split(v, ",")

        -- 消耗变化
        local goodsData2 = GoodsDataManager:createLocalGoodsData(tonumber(final[1]))
        local sellIcon1 = UI.Image:create()
        sellIcon1:init(goodsData2:getSmallIconName())
        sellIcon1:center(-50,0)
        sellIcon:addChild(sellIcon1)

        -- 消耗的数量
        local sellText = UI.Text:create()
        sellText:init(tostring(final[2]),UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 240, g = 201, b = 68})
        sellText:centerLeft(35,0)
        sellIcon1:addChild(sellText)
        table.insert(self._sellText, sellText)
    end
    -- -- 当前持有铭文的数量
    -- local allHaveNums = self.isPay and GameDataManager:getInstance():getDiamond() or GameDataManager:getInstance():getInscription()
    -- local sellText2 = UI.Text:create()
    -- sellText2:init("0",UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 240, g = 201, b = 68})
    -- sellText2:centerRight(70, -205)
    -- sellText2:setTextRight()
    -- sellText2:setText(sellText2:numformat(string.format("%d",allHaveNums)))
    -- self.contentLayout:addChild(sellText2)

    -- local sellIcon2 = UI.Image:create()
    -- sellIcon2:init(goodsData2:getSmallIconName())
    -- sellIcon2:centerLeft(-30)
    -- sellText2:addChild(sellIcon2)
    --------------------------------------------
    -- 保存洗练结果按钮
    self.attrBtnList = {}
    local normalDetailArr = self.glyphData:getNormalDetailDescription()
    if normalDetailArr then
        for k, data in pairs(normalDetailArr) do
            -- UI.FONT_COLOR_41_41_45
            local btn = UI.Button:create()
            btn:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png")
            btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                if self.quitBtn and not self.quitBtn.select then
                    print("getNormalDetailDescription--->: ", btn.select)
                    if btn.select then
                        btn.select = false
                        btn:getChildByName("checkBtn"):setVisible(false)
                    else
                        btn.select = true
                        btn:getChildByName("checkBtn"):setVisible(true)
                    end
                else
                    UI.ScrollBar:createByText(UI.TEXT_227032)
                end

            end)
            btn:center(-410 + k * 150,-115)
            btn:closeClickScale()
            btn.select = false -- 默认没有选中
            btn.attrType = data[3]
            self.contentLayout:addChild(btn)

            local checkBtn = UI.Image:create()
            checkBtn:init("ui_btn_choice_1.png")
            checkBtn:setVisible(false)
            checkBtn:setName("checkBtn")
            checkBtn:center(0, 0)
            btn:addChild(checkBtn, 11)

            local baseText = UI.Text:create()
            baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            baseText:centerLeft(45,0)
            btn:addChild(baseText, 10)

            table.insert(self.attrBtnList, btn)
        end

        -- 属性价值为正
        local btn = UI.Button:create()
        btn:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png")
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if self.quitBtn and not self.quitBtn.select then
                if btn.select then
                    btn.select = false
                    btn:getChildByName("checkBtn"):setVisible(false)
                else
                    btn.select = true
                    btn:getChildByName("checkBtn"):setVisible(true)
                end
            else
                UI.ScrollBar:createByText(UI.TEXT_227032)
            end
        end)
        btn:center(-260,-65)
        btn:closeClickScale()
        btn.select = true -- 默认没有选中
        self.btnValue = btn
        self.contentLayout:addChild(btn)

        local checkBtn = UI.Image:create()
        checkBtn:init("ui_btn_choice_1.png")
        checkBtn:setVisible(true)
        checkBtn:setName("checkBtn")
        checkBtn:center(0, 0)
        btn:addChild(checkBtn, 11)

        local baseText = UI.Text:create()
        baseText:init(UI.TEXT_227021, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 43, g = 43, b = 47})
        baseText:centerLeft(45,0)
        btn:addChild(baseText, 10)

        --快速洗练

        self.quitBtn = UI.Button:create()
        self.quitBtn:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png")
        self.quitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if self.quitBtn.select then
                self.quitBtn.select = false
                self.quitBtn:getChildByName("checkBtn"):setVisible(false)
            else
                self.quitBtn.select = true
                self.quitBtn:getChildByName("checkBtn"):setVisible(true)
            end

            self:updateSelectBtnState()

        end)
        self.quitBtn:center(-260,-15)
        self.quitBtn:closeClickScale()
        self.contentLayout:addChild(self.quitBtn)

        local checkBtn = UI.Image:create()
        checkBtn:init("ui_btn_choice_1.png")
        checkBtn:setVisible(false)
        checkBtn:setName("checkBtn")
        checkBtn:center(0, 0)
        self.quitBtn:addChild(checkBtn, 11)

        local baseText = UI.Text:create()
        baseText:init(UI.TEXT_227031, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 43, g = 43, b = 47})
        baseText:centerLeft(45,0)
        self.quitBtn:addChild(baseText, 10)

    end
end

function GlyphRefinedItemView:updateSelectBtnState()
    local isQSelect = self.quitBtn.select
    if isQSelect then
        for k,btn in pairs(self.attrBtnList) do
            btn.select = true
            btn:getChildByName("checkBtn"):setVisible(true)
            btn:getChildByName("checkBtn"):setSpriteName("ui_btn_choice_2.png")
        end

        self.btnValue.select = true
        self.btnValue:getChildByName("checkBtn"):setVisible(true)
        self.btnValue:getChildByName("checkBtn"):setSpriteName("ui_btn_choice_2.png")
    else
        for k,btn in pairs(self.attrBtnList) do
            btn:getChildByName("checkBtn"):setSpriteName("ui_btn_choice_1.png")
        end
        self.btnValue:getChildByName("checkBtn"):setSpriteName("ui_btn_choice_1.png")
    end

end

function GlyphRefinedItemView:updateLvPrgBarShow()
    for k,sellText in pairs(self._sellText) do
        sellText:setText(tostring(self.curPillSelectNum * self.costEverTime[k]))
    end
end

function GlyphRefinedItemView:getPillShowNum()
    return self.useNum
end

function GlyphRefinedItemView:isAllowBegin()
    local isCanAuto = true
    -- 是否可以批量洗练
    if not self.btnValue then
        isCanAuto = false
        UI.ScrollBar:createByText(UI.TEXT_227022)
    else
        if not self.btnValue.select then
            local isSelcetAttr = false
            for k,btn in pairs(self.attrBtnList) do
                if btn.select then
                    isSelcetAttr = true
                end
            end
            if not isSelcetAttr then
                isCanAuto = false
                UI.ScrollBar:createByText(UI.TEXT_227022)
            end
        end
    end

    return isCanAuto
end

function GlyphRefinedItemView:setUseNum()
    -- 设置可以达到的最大上限洗练次数
    local minNum = nil
    for k,v in pairs(self.constConfig) do
        local config = string.split(v, ",")
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(config[1]), true)
        local Nums = math.floor(goodNumber / self.costEverTime[k])

        if not minNum then
            minNum = Nums
        elseif Nums < minNum then
            minNum = Nums
        end
    end

    if minNum <= 100 then
        self.useNum = minNum -- 当前的可以补充的最大上限
    else
        self.useNum = 100 -- 当前的可以补充的最大上限
    end
end

function GlyphRefinedItemView:bindModel()
end

function GlyphRefinedItemView:unbindModel()
end


return GlyphRefinedItemView












