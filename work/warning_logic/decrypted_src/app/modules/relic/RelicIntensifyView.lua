------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/05/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RelicIntensifyView = class("RelicIntensifyView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_shop.plist",
    "ui_shop_article_2.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 482
local COM_HEIGHT = 380

function RelicIntensifyView:ctor(relicData)
    RelicIntensifyView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.relicData = relicData
    self:bindModel()
end

function RelicIntensifyView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.relic", "Relic", false)
    RelicIntensifyView.super.init(self, ... )
end

function RelicIntensifyView:dtor()
    RelicIntensifyView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.relic.RelicIntensifyView")
end


function RelicIntensifyView:onInitView()
    self.slots = {}
    self.pillsData = {}
    self.curSlotIdx = 0
    self.lastSlotIdx = 0
    self.curPillSelectNum = 0
    self.lastPillSelectNum = 0

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    local title = UI.Text:create()
    title:init(UI.TEXT_1324460, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_44)
    title:centerUp(15)
    self.contentLayout:addChild(title)

    -- local strengthConfig = ConfigManager:getRelicLevelConfigByID(relicData:getLevel())

    -- local cfg = ConfigManager:getPetExpByID(self.curPet:getLevel())
    -- local expPrgBar = UI.ProgressTimer:create()
    -- expPrgBar:init("ui_pets_exp_progressbar_0.png", "ui_pets_exp_progressbar_1.png", "ui_pets_exp_progressbar_2.png")
    -- expPrgBar:leftUp(140, 38)
    -- expPrgBar:setPercent(self.curPet:getCurExp()/cfg.expToNextLV)
    -- expPrgBar:setChangePercent(0.9)
    -- self.contentLayout:addChild(expPrgBar)
    -- self.expPrgBar = expPrgBar
    -- self.curPrgValue = self.curPet:getCurExp()/cfg.expToNextLV

    -- local addExpTxt = UI.Text:create()
    -- addExpTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- addExpTxt:setWidth(196)
    -- addExpTxt:leftUp(140, 32)
    -- addExpTxt:setTextCenter()
    -- addExpTxt:autoAdapt()
    -- self.contentLayout:addChild(addExpTxt, 10)
    -- self.addExpTxt = addExpTxt

    -- local addLvTxt = UI.Text:create()
    -- addLvTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_191_115_25)
    -- addLvTxt:leftUp(350, 30)
    -- self.contentLayout:addChild(addLvTxt, 10)
    -- self.addLvTxt = addLvTxt

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(436, 1)
    line:setCapInsets(CCRectMake(1,0,1,1))
    line:setPosition(cc.p(242, 330))
    self.contentLayout:addChild(line)

    local startX = 155
    local rateDes = UI.Text:create()
    rateDes:init(UI.TEXT_1324461, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    rateDes:centerLeft(startX, -50)
    self.contentLayout:addChild(rateDes)
    
    local width = rateDes:getContentSize().width+5
    local rateNum = UI.Text:create()
    rateNum:init("60%", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    rateNum:centerLeft(startX+width, -50)
    self.contentLayout:addChild(rateNum)
    self.rateNum = rateNum

    self:addPillSlots()

    local numMin = UI.Text:create()
    numMin:init(tostring(self.curPillSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMin:leftUp(54, 236)
    self.contentLayout:addChild(numMin)
    self.numMinTxt = numMin

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
                realNum = 0
            end
            self.numPopTxt:setText(tostring(realNum))
            self.curPillSelectNum = realNum
        end

        self.numPrgBar:setPercent(curX/maxX)

        if self.curPillSelectNum ~= self.lastPillSelectNum then
            self:updateIntensifyView()
            self.lastPillSelectNum = self.curPillSelectNum
        end
    end)
    numPrgBar:addChild(numPopPlus, 10);

    local numBG  = UI.Image:create();
    numBG:init("ui_shop_article_4.png");
    numBG:leftUp(-15, -60);
    numPopPlus:addChild(numBG);

    local numTxt = UI.Text:create()
    numTxt:init(tostring(self.curPillSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    local numMax = UI.Text:create()
    numMax:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMax:leftUp(380, 236)
    self.contentLayout:addChild(numMax)
    self.numMaxTxt = numMax

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("Relic", "RelicIntensify")
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        local pillID = self.pillsData[self.curSlotIdx].id

        local itemData =  GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, pillID, false, 0)
        if itemData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            return
        end
        local curPill = self.pillsData[self.curSlotIdx]
        -- Net.NetPetSystem:levelup(self.curPet:getId(), pillID, self.curPillSelectNum)
        local extraIdsList = {}
        local extraNumsList = {}
        table.insert(extraIdsList, curPill.id)
        table.insert(extraNumsList, self.curPillSelectNum)
        RelicDataManager:reqRelicStrength(self.relicData, extraIdsList, extraNumsList)
        mvc.closePanel("Relic", "RelicIntensify")
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)

    self:updateIntensifyView()
    self:resetNumPrgBarShow()
end

function RelicIntensifyView:addPillSlots()
    local curLevelPillsConfigList = RelicDataManager:getRelicCurLevelConfig(self.relicData)

    local gridX = {200, 288}
    local gridY = {120, 92}

    for k, v in ipairs(curLevelPillsConfigList) do
        local materialID = tonumber(v[1])
        local goodsData = GoodsDataManager:createLocalGoodsData(materialID)
        local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(materialID, true, true)
        goodsData:setNum(pillNum)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:leftUp(gridX[k], gridY[k])
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)
        self.contentLayout:addChild(goodsGrid)

        local select  = UI.Animation:create()
        select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
        select:center()
        select:setName("Select")
        select:hide()
        goodsGrid:addChild(select, 10)

        local touchLayer = UI.Layout:create();
        touchLayer:init()
        touchLayer:setSize(86, 86)
        touchLayer:center()
        touchLayer:setTouchEnable(true)
        touchLayer:setInterceptTouches(false)
        goodsGrid:addChild(touchLayer)
        touchLayer:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
            local targetSlot = self.slots[k]
            local pillData = self.pillsData[k]
            if pillData.num == 0 then
                UI.ScrollBar:createByText(UI.TEXT_1213611)
                return
            end

            self:updateSlotShow(k)
            -- self:updateLvPrgBarShow()
        end)

        table.insert(self.slots, goodsGrid)
        table.insert(self.pillsData, {id=materialID, num=pillNum, rate = tonumber(v[3])})

        if self.curSlotIdx == 0 then
            self.curSlotIdx = k
            self.lastSlotIdx = k
        end
    end

    self:updateSlotShow(self.curSlotIdx)
end

function RelicIntensifyView:updateSlotShow(idx)
    local targetSlot = self.slots[idx]
    local pillData = self.pillsData[idx]

    self.curSlotIdx = idx

    if self.curSlotIdx ~= self.lastSlotIdx then
        self.curPillSelectNum = 0
        self.lastPillSelectNum = 0

        self:resetNumPrgBarShow()
    end

    local select = targetSlot:getChildByName("Select")
    select:show()
    select:setAnimation("start_square", false)
    select:addAnimation("loop_square", true)

    local lastSlot = self.slots[self.lastSlotIdx]
    if self.curSlotIdx ~= self.lastSlotIdx and lastSlot then
        local lastSelect = lastSlot:getChildByName("Select")
        lastSelect:hide()
    end

    self.lastSlotIdx = self.curSlotIdx
end

function RelicIntensifyView:resetNumPrgBarShow()
    self.numPrgBar:setPercent(0)
    self.numPopTxt:setText("0")
    self.numPopPlus:setPositionX(-self.originOffsetX)
    self.numMaxTxt:setText(tostring(self:getPillShowNum()))
end


function RelicIntensifyView:getPillShowNum()
    local curPill = self.pillsData[self.curSlotIdx]
    local maxNum = tonumber(ConfigManager:getGeneralForKey("relicStrengthenMaterialMax"))
    local showNum = curPill.num > maxNum and maxNum or curPill.num

    return showNum
end

function RelicIntensifyView:updateIntensifyView()
    local strengthConfig = ConfigManager:getRelicLevelConfigByID(self.relicData:getLevel())
    local curPill = self.pillsData[self.curSlotIdx]
    local curRate = self.curPillSelectNum * curPill.rate + strengthConfig.successRate
    local curRateStr = string.format(UI.TEXT_1324462, curRate)
    if curRate > strengthConfig.successRate then
        self.rateNum:setFontColor(UI.FONT_COLOR_38_123_7)
        self.rateNum:setText(curRateStr)
    else
        local rateStr = string.format(UI.TEXT_1324462, strengthConfig.successRate)
        self.rateNum:setFontColor(UI.FONT_COLOR_50_50_44)
        self.rateNum:setText(rateStr)
    end
    
end

function RelicIntensifyView:bindModel()

end


function RelicIntensifyView:unbindModel()

end





return RelicIntensifyView












