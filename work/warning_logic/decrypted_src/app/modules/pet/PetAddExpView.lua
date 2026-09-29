------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAddExpView = class("PetAddExpView", UI.HWBtnComponent)
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

local AddMaxPreExp = 2000000000 --每次最多食用20亿经验的胡萝卜

function PetAddExpView:ctor(petID)
    PetAddExpView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.curPet = MasterDataManager:getBagPetById(petID)
end

function PetAddExpView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetAddExpView.super.init(self, ... )
end

function PetAddExpView:dtor()
    PetAddExpView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetAddExpView")
end

function PetAddExpView:onInitView()
    self.slots = {}
    self.pillsData = {}
    self.curSlotIdx = 0
    self.lastSlotIdx = 0
    self.curPillSelectNum = 1
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

    local lvTxt = UI.Text:create()
    lvTxt:init("Lv" .. tostring(self.curPet:getLevel()), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    lvTxt:leftUp(83, 32)
    self.contentLayout:addChild(lvTxt)

    local cfg = ConfigManager:getPetExpByID(self.curPet:getLevel())
    local expPrgBar = UI.ProgressTimer:create()
    expPrgBar:init("ui_pets_exp_progressbar_0.png", "ui_pets_exp_progressbar_1.png", "ui_pets_exp_progressbar_2.png")
    expPrgBar:leftUp(140, 38)
    expPrgBar:setPercent(self.curPet:getCurExp()/cfg.expToNextLV)
    expPrgBar:setChangePercent(0.9)
    self.contentLayout:addChild(expPrgBar)
    self.expPrgBar = expPrgBar
    self.curPrgValue = self.curPet:getCurExp()/cfg.expToNextLV

    local addExpTxt = UI.Text:create()
    addExpTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    addExpTxt:setWidth(196)
    addExpTxt:leftUp(140, 32)
    addExpTxt:setTextCenter()
    addExpTxt:autoAdapt()
    self.contentLayout:addChild(addExpTxt, 10)
    self.addExpTxt = addExpTxt

    local addLvTxt = UI.Text:create()
    addLvTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_191_115_25)
    addLvTxt:leftUp(350, 30)
    self.contentLayout:addChild(addLvTxt, 10)
    self.addLvTxt = addLvTxt

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(436, 1)
    line:setCapInsets(CCRectMake(1,0,1,1))
    line:setPosition(cc.p(242, 300))
    self.contentLayout:addChild(line)

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
        mvc.closePanel("Pet", "PetAddExp")
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local checkLv = mvc.petModel:getMaxLevelLimit()
        local addLv = self:getAddExpLv()
        if self.curPet:getLevel() + addLv > checkLv then
            UI.ScrollBar:createByText(UI.TEXT_1213610)
            return
        end

        local pillID = self.pillsData[self.curSlotIdx].id

        local itemData =  GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, pillID, false, 0)
        if itemData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            return
        end

        Net.NetPetSystem:levelup(self.curPet:getId(), pillID, self.curPillSelectNum)
        mvc.closePanel("Pet", "PetAddExp")
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)

    self:updateLvPrgBarShow()
    self:resetNumPrgBarShow()
end

function PetAddExpView:addPillSlots()
    local pills = mvc.petModel:getAllExpPill()
    local gridX = {124, 288}
    local gridY = {92, 92}

    for k, v in ipairs(pills) do
        local goodsData = GoodsDataManager:createLocalGoodsData(v.id)
        local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(v.id, true, true)
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
            self:updateLvPrgBarShow()
        end)

        table.insert(self.slots, goodsGrid)
        table.insert(self.pillsData, {id=v.id, num=pillNum, exp=v.exp})

        if pillNum > 0 and self.curSlotIdx == 0 then
            self.curSlotIdx = k
            self.lastSlotIdx = k
        end
    end

    self:updateSlotShow(self.curSlotIdx)
end

function PetAddExpView:updateSlotShow(idx)
    local targetSlot = self.slots[idx]
    local pillData = self.pillsData[idx]

    self.curSlotIdx = idx

    if self.curSlotIdx ~= self.lastSlotIdx then
        self.curPillSelectNum = 1
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

function PetAddExpView:resetNumPrgBarShow()
    self.numPrgBar:setPercent(0)
    self.numPopTxt:setText("1")
    self.numPopPlus:setPositionX(-self.originOffsetX)
    self.numMaxTxt:setText(tostring(self:getPillShowNum()))
end

function PetAddExpView:updateLvPrgBarShow()
    local curPill = self.pillsData[self.curSlotIdx]

    self.addExpTxt:setText("+" .. self.curPillSelectNum * curPill.exp)

    local addLv, percent = self:getAddExpLv()
    
    if addLv >= 1 then
        self.addLvTxt:setText("+" .. addLv)

        self.expPrgBar:setSpriteName("ui_pets_exp_progressbar_0.png", nil, "ui_pets_exp_progressbar_1.png")

        self.expPrgBar:setPercent(0)
    else
        self.expPrgBar:setSpriteName("ui_pets_exp_progressbar_0.png", "ui_pets_exp_progressbar_1.png", "ui_pets_exp_progressbar_2.png")

        self.expPrgBar:setPercent(self.curPrgValue)
    end
    self.expPrgBar:setChangePercent(percent)
end

function PetAddExpView:getAddExpLv()
    local curPill = self.pillsData[self.curSlotIdx]
    local curAddExp = self.curPillSelectNum * curPill.exp
    local totalAddLv = 0
    local beginIdx = self.curPet:getLevel()

    local checkLv = mvc.petModel:getMaxLevelLimit()

    local endIdx = math.min(self.curPet.maxLV, checkLv)
    local curCfgTotalExp = 0
    local percent = 0
    for i = beginIdx, endIdx do
        local cfg = ConfigManager:getPetExpByID(i)
        if self.curPet:getCurExp() + curAddExp > curCfgTotalExp then
            totalAddLv = totalAddLv + 1
            curCfgTotalExp = curCfgTotalExp + cfg.expToNextLV
            percent = 1
        else
            percent = (self.curPet:getCurExp()+curAddExp-(curCfgTotalExp-cfg.expToNextLV))/cfg.expToNextLV
            break
        end
    end

    -- 减1是因为初始等级为1，但经验是0
    totalAddLv = totalAddLv - 1

    return totalAddLv, percent
end

function PetAddExpView:getPillShowNum()
    local curPill = self.pillsData[self.curSlotIdx]
    local totalExp = mvc.petModel:getCurPetMaxExp(self.curPet:getId())
    local deltaExp = totalExp - self.curPet:getCurTotalExp()
    local expPillNum = math.ceil(deltaExp/curPill.exp)
    local canUseNum = math.min(expPillNum, curPill.num)

    local checkLv = mvc.petModel:getMaxLevelLimit()

    local canLvUpMax = checkLv--RoleDataManager:getMaster():getLevel()
    local petCurLv = self.curPet:getLevel()
    local canLvUpTotalExp = 0

    for i = petCurLv, canLvUpMax do
        local cfg = ConfigManager:getPetExpByID(i)
        canLvUpTotalExp = canLvUpTotalExp + cfg.expToNextLV
    end

    if canLvUpTotalExp > AddMaxPreExp then
        canLvUpTotalExp = AddMaxPreExp
    end

    canLvUpTotalExp = canLvUpTotalExp - 1
    local pCount = canUseNum
    if curPill.exp * curPill.num > canLvUpTotalExp then
        -- 计算最大可用数量
        for i = 1, curPill.num do
            pCount = i
            if curPill.exp > canLvUpTotalExp then
                break
            else
                canLvUpTotalExp = canLvUpTotalExp - curPill.exp
            end
        end
    end

    local showNum = math.min(canUseNum, pCount)
    return showNum
end

function PetAddExpView:bindModel()

end

function PetAddExpView:unbindModel()

end

return PetAddExpView
