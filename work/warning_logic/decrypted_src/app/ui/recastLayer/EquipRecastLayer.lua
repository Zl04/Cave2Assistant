-- EquipRecastLayer.lua
-- Author:ydli
-- 2019年03月26日
-- Using:装备重铸

require "app.ui.shoplayer.BagGoodsPanel"

UI = UI or {}
local GameDataManager = require("app.game.GameDataManager")
local EquipRecastLayer = class("EquipRecastLayer", UI.DoorWin)
UI.EquipRecastLayer = EquipRecastLayer
local winSize = cc.Director:getInstance():getWinSize()
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_recasting.plist",
}

--构造函数(必备)
function EquipRecastLayer:ctor(spriteID)
    --窗口大小
    EquipRecastLayer.super.ctor(self, UIType.EQUIPMENT_RECAST, COM_RES_LIST, 352, winSize.height)
    self.spriteID = spriteID
    self.mGoodsGrid = nil;          --装备框
    self.mCanRecast = true;       --是否能重铸
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function EquipRecastLayer:dtor()
    EquipRecastLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function EquipRecastLayer:init()
    EquipRecastLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function EquipRecastLayer:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self:addChild(self.rootLayer)

    local leftLayer = UI.Layout:create()
    leftLayer:init()
    leftLayer:setSize(352, 595)
    leftLayer:centerLeft(0)
    self.rootLayer:addChild(leftLayer)
    self.leftLayer = leftLayer

    local bg = UI.Image:create()
    bg:init("ui_recasting_bg.png")
    bg:center()
    self.leftLayer:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_recasting_title.png")
    titleBg:centerUp(-30)
    self.leftLayer:addChild(titleBg, 10)

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_1212308, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    titleStr:centerBottom(11)
    titleBg:addChild(titleStr)
    self.titleStr = titleStr

    local scale = 225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

---文本 begin
    local successPanel = UI.Layout:create()
    successPanel:init()
    successPanel:setSize(252, 35)
    successPanel:centerUp(224)
    -- successPanel:enableDebugDraw()
    bg:addChild(successPanel)
    self.successPanel = successPanel

    local successTips = UI.Text:create()
    successTips:init(UI.TEXT_1212328, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    successPanel:addChild(successTips)
    self.successTips = successTips

    local finishAttrTitle = UI.Text:create()
    finishAttrTitle:init(UI.TEXT_1212310, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    bg:addChild(finishAttrTitle)
    finishAttrTitle:centerUp(228)
    self.finishAttrTitle = finishAttrTitle

    local successRate = UI.Text:create()
    successRate:init("0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_102)
    successPanel:addChild(successRate)
    self.successRate = successRate
    local left = (self.successPanel:getContentSize().width - self.successTips:getContentSize().width - self.successRate:getContentSize().width - 12) / 2
    successTips:centerLeft(left)
    successRate:centerLeft(left + self.successTips:getContentSize().width + 12)

    local attrTitlePanel = UI.Layout:create()
    attrTitlePanel:init()
    attrTitlePanel:setSize(252, 35)
    attrTitlePanel:centerUp(263)
    -- attrTitlePanel:enableDebugDraw()
    bg:addChild(attrTitlePanel)
    self.attrTitlePanel = attrTitlePanel

    local attrTitle = UI.Text:create()
    attrTitle:init(UI.TEXT_1212310, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    attrTitle:setWidth(200)
    attrTitle:center()
    attrTitle:setTextCenter()
    attrTitlePanel:addChild(attrTitle)
    attrTitle:setLineSpacing(-8)
    -- attrTitle:enableDebugDraw()

    local pointL = UI.Image:create()
    pointL:init("ui_information_hero_diamond.png")
    pointL:centerLeft((attrTitlePanel:getContentSize().width - attrTitle:getContentSize().width) / 2 - 22)
    pointL:setImageColor(UI.FONT_COLOR_41_41_45)
    attrTitlePanel:addChild(pointL)

    local pointR = UI.Image:create()
    pointR:init("ui_information_hero_diamond.png")
    pointR:centerRight((attrTitlePanel:getContentSize().width - attrTitle:getContentSize().width) / 2 - 22)
    pointR:setImageColor(UI.FONT_COLOR_41_41_45)
    attrTitlePanel:addChild(pointR)
    
    local attrPanel = UI.Layout:create()
    attrPanel:init()
    attrPanel:setSize(270, 215)
    attrPanel:centerBottom(116)
    -- attrPanel:enableDebugDraw()
    bg:addChild(attrPanel)
    self.attrPanel = attrPanel

    local tips = UI.Text:create()
    tips:init(UI.TEXT_1212311, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    tips:setDimensions(252, 40)
    tips:setTextCenter()
    tips:setLineSpacing(-5)
    tips:centerBottom(72)
    bg:addChild(tips)
---文本 end

--spine
    self.recastAnimation = UI.Animation:create()
    self.recastAnimation:init("effect_ui_twon_recast_top.json", "effect_ui_twon_recast_top.atlas", 1);
    self.recastAnimation:centerUp(102)
    self.leftLayer:addChild(self.recastAnimation)
    self.recastAnimation:setAnimation("idle", false)

    self.iconAnimation = UI.Animation:create()
    self.iconAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.iconAnimation:centerUp(102)
    self.leftLayer:addChild(self.iconAnimation)

    self.lightAnimation = UI.Animation:create()
    self.lightAnimation:init("effect_ui_twon_recast_top_light.json", "effect_ui_twon_recast_top_light.atlas", 1);
    self.lightAnimation:centerUp(100)
    self.leftLayer:addChild(self.lightAnimation, 200)

    self.downAnimation = UI.Animation:create()
    self.downAnimation:init("effect_ui_twon_recast_down.json", "effect_ui_twon_recast_down.atlas", 1);
    self.downAnimation:centerBottom(39)
    self.leftLayer:addChild(self.downAnimation)
    self.downAnimation:setAnimation("idle", false)
--spine end

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:centerUp(68)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid));
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.leftLayer:addChild(self.mGoodsGrid, 100)

    --右边背包数据
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needRecast = true -- 是否需要筛选可以重铸的装备
    table.insert(usedTypeList, _usedType1)

    local bagList = UI.BagGoodsPanel:create(usedTypeList, false, false)
    bagList:setShowBagTagExt(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList, 5)
    local bagListW, bagListH = bagList:getSize()
    bagList:centerLeft(0)
    bagList:changeBagDefaultIndex(2)
    bagList:setUseLock(false)

    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_2.png")
    executeButton:centerBottom(6)
    self.leftLayer:addChild(executeButton, 10)
    executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButton:setText(UI.TEXT_1212314)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRecastClick)
    self.executeButton = executeButton

    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_money.png")
    executeButtonIcon:centerLeft(90)
    executeButton:addChild(executeButtonIcon, 10)
    self.executeButtonIcon = executeButtonIcon

    local executeButtonPrice = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51, 10)
    executeButtonPrice:centerLeft(130)
    executeButton:addChild(executeButtonPrice, 10)
    self.executeButtonPrice = executeButtonPrice

    self:setDoorNode(self.leftLayer, bagList)
    self:showInitAttr()
end

function EquipRecastLayer:onRecastClick()
    if not self.mCanRecast then
        return
    end
    if self.mGoodsData == nil then
        return
    end
     --检查角色  行为是否合法
    if RoleBehaviorManager:equipTownNpcCheck() then
        printWarn(" been blocked when using equipment npc recastData function !")
        return
    end
    
    local recastData = self.mGoodsData:getEquipRecastData()
    local maxCount = #recastData.cost
    if self.mGoodsData.recastNum >= maxCount then
        UI.ScrollBar:createByText(UI.TEXT_1212330)
        return
    end

    local cost = recastData.cost[self.mGoodsData.recastNum + 1] or recastData.cost[maxCount]
    if GameDataManager:getInstance():getCurCoin() < cost then
        UI.ScrollBar:createByText(UI.TEXT_1110389)
        return
    end
    local isNoticeRecast = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeRecast..GameDataManager:getInstance():getMasterPK(), true)  
    --二次确认
    if isNoticeRecast then
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212315, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeRecast..GameDataManager:getInstance():getMasterPK(), false)  
            end
            self.mCanRecast = false
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetNPCSystem:reqRecastEquip(self.spriteID, self.mGoodsData, PublicDefine.CostType.Cost_Coin) 
            self._bagGridList:updateCanDrag(false)
        end, function(isSelect)
            
        end, nil, nil, true)
        return
    end  
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetNPCSystem:reqRecastEquip(self.spriteID, self.mGoodsData, PublicDefine.CostType.Cost_Coin)
    self._bagGridList:updateCanDrag(false)
    self.mCanRecast = false
end

function EquipRecastLayer:showInitAttr()
    self.finishAttrTitle:hide()
    self.attrTitlePanel:hide()
    self.successPanel:hide()
    self.executeButtonIcon:hide()
    self.executeButtonPrice:hide()
    self.executeButton._text:show()
    self.titleStr:setText(UI.TEXT_1212308)
    local scale = 225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

    self.attrPanel:removeAllChildren()
    self.executeButton:disable()
    GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1212318)
end

function EquipRecastLayer:showTempAttr() 
    self.attrPanel:setContentSize(252, 180)
    self.attrPanel:removeAllChildren()
    if self.mGoodsData == nil then
        return
    end
    self.finishAttrTitle:hide()
    self.attrTitlePanel:show()
    self.successPanel:show()
    self.executeButtonIcon:show()
    self.executeButtonPrice:show()
    self.executeButton._text:hide()
    self.titleStr:setText(self.mGoodsData:getName())
    local scale = 225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

    local basicAttr = self.mGoodsData:getBasicAttrArea()
    local recastData = self.mGoodsData:getEquipRecastData()
    local posY = 0
    for k, v in ipairs(basicAttr) do
        local baseText = UI.Text:create()
        baseText:init(v.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        baseText:setSize(90,25)
        baseText:setTextLeft()
        baseText:leftUp(9, posY)
        self.attrPanel:addChild(baseText)
        
        local baseValue = UI.Text:create()
        baseValue:init(v.showText, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        baseValue:setTextLeft()
        baseValue:leftUp(113, posY)
        self.attrPanel:addChild(baseValue)
        posY = posY + 25
    end

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(254, 1)
    line:setCapInsets(CCRectMake(1,0,1,1))
    line:setPosition(cc.p(134, self.attrPanel:getContentSize().height - posY - 6))
    self.attrPanel:addChild(line)

    local attrNum = 0
    local goodRare = self.mGoodsData:getGoodsRare()
    if(goodRare == PublicDefine.GOODS_RARE.RARE_WHITE_1) then
        attrNum = 0
    elseif(goodRare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
        attrNum = 1
    elseif(goodRare == PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
        attrNum = 2
    elseif(goodRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
        attrNum = 3
    elseif(goodRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5) then
        attrNum = 4
    elseif(goodRare == PublicDefine.GOODS_RARE.RARE_DARKRED) then
        attrNum = 5
    else 
        attrNum = tonumber(goodRare) - 1
    end
    
    posY = posY + 15
    local parent = self.attrPanel
    if self.attrPanel:getContentSize().height < posY +  attrNum * 25 then
        local scrollView = UI.ScrollView:create()
        scrollView:setSize(272, self.attrPanel:getContentSize().height - posY + 3)
        scrollView:init()
        scrollView:leftUp(0, posY - 3)
        scrollView:setScrollBarEnabled(true)
        scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
        scrollView:setCircleVisible(false)
        scrollView:setScrollBarWidth(5)
        self.attrPanel:addChild(scrollView)
        -- scrollView:enableDebugDraw()

        parent = UI.Layout:create()
        parent:init()
        parent:setSize(252, attrNum * 25)
        scrollView:addInnerNode(parent)
        posY = -5
    end
    for i=1,attrNum do 
        local point = UI.Image:create()
        point:init("ui_iteminfo_icon_point_01.png")
        point:leftUp(8, posY + 7)
        parent:addChild(point)

        local baseValue = UI.Text:create()
        baseValue:init("???", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        baseValue:setTextLeft()
        baseValue:leftUp(20, posY)
        parent:addChild(baseValue)
        posY = posY + 25
    end
    local maxCount = #recastData.cost
    local curCount = self.mGoodsData.recastNum > maxCount and maxCount or self.mGoodsData.recastNum
    self.successRate:setText(string.format("%d/%d", curCount, maxCount))
    local left = (self.successPanel:getContentSize().width - self.successTips:getContentSize().width - self.successRate:getContentSize().width - 12) / 2
    self.successTips:centerLeft(left)
    self.successRate:centerLeft(left + self.successTips:getContentSize().width + 12)

    if curCount >= maxCount then
        self.successRate:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        self.executeButtonIcon:hide()
        self.executeButtonPrice:hide()
        self.executeButton._text:show()
        self.executeButton:setText(UI.TEXT_1212329)
    else
        local cost = recastData.cost[self.mGoodsData.recastNum + 1] or recastData.cost[maxCount]
        self.executeButtonIcon:show()
        self.executeButtonPrice:show()
        self.executeButton._text:hide()
        self.successRate:setFontColor(UI.FONT_COLOR_204_204_102)
        self.executeButtonPrice:setText(cost)
        local left = (200 - self.executeButtonPrice:getContentSize().width) / 2
        self.executeButtonIcon:centerLeft(left)
        self.executeButtonPrice:centerLeft(left + 35)
        if GameDataManager:getInstance():getCurCoin() < cost then
            self.executeButtonPrice:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.executeButtonPrice:setFontColor(UI.FONT_COLOR_51_51_51)
        end
    end
    self.executeButton:enable()
    GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1212319)
end

function EquipRecastLayer:showAllAttr() 
    self.attrPanel:removeAllChildren()
    self.attrPanel:setContentSize(252, 215)
    local attdata = self.mGoodsData:getDetailDescription()
    -- 基础属性，随机属性，附魔属性，套装属性，特殊属性
    local  baseArr      =  attdata.baseArr
    local  randomArr    =  attdata.randomArr
    local  enchanting   =  attdata.enchanting
    local  rateArr      =  attdata.rateArr  -- 比例属性
    local  equipmentArr =  attdata.equipmentArr
    local  specialArr   =  attdata.specialArr
    self.finishAttrTitle:show()
    self.attrTitlePanel:hide()
    self.successPanel:hide()
    self.executeButtonIcon:show()
    self.executeButtonPrice:show()
    self.executeButton._text:hide()
    self.titleStr:setText(self.mGoodsData:getName())
    local scale = 225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

    local posY = 0
    if baseArr then 
        for i,data in ipairs(baseArr) do 
            local baseText = UI.Text:create()
            baseText:init(data[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseText:setSize(70,25)
            baseText:leftUp(9, posY)
            baseText:setTextLeft()
            self.attrPanel:addChild(baseText)

            local baseValue = UI.Text:create()
            baseValue:init(data[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseValue:setTextLeft()
            baseValue:leftUp(93, posY)
            self.attrPanel:addChild(baseValue) 
            posY = posY + 25
        end
    end

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(254, 1)
    line:setCapInsets(CCRectMake(1,0,1,1))
    line:setPosition(cc.p(134, self.attrPanel:getContentSize().height - posY - 6))
    self.attrPanel:addChild(line)
    posY = posY + 12

 -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(272, self.attrPanel:getContentSize().height - posY - 5)
    scrollView:init()
    scrollView:leftUp(3, posY)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    self.attrPanel:addChild(scrollView)

    local totalHeight = 0
    local centerOffsetUp = 13.5
    local pointOffsetY = - 1

    local leftOffset = 8
    local pointBaseOffset = 3
    local pointBaseValueOffset = 13
    local attrWidth = 205

    if randomArr then 
        for i,data in ipairs(randomArr) do
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init("ui_iteminfo_icon_point_01.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            
            local baseText = UI.Text:create()
            baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseText:setTextLeft()
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            self._scrollLayout:addChild(baseText)

            local baseValue = UI.Text:create()
            baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
            self._scrollLayout:addChild(baseValue)

            if(baseText._width > attrWidth) then 
                baseText:setWidth(attrWidth)
                baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth,  textUp)
            end

            local hammer = UI.Image:create()
            hammer:init(HAMMER)
            hammer:leftUp(leftOffset + pointBaseValueOffset +baseText._width+baseValue._width + 3, centerUp - hammer:getContentSize().height/2)
            self._scrollLayout:addChild(hammer)
            hammer:setVisible(data[3])
            
            totalHeight = totalHeight + baseText:getContentSize().height
            k = i
        end
    end

    -- 附魔属性
    -- print("--附魔属性")
    -- dump(enchanting)
    if enchanting then 
        local centerUp = totalHeight + centerOffsetUp

        local point  = UI.Image:create()
        point:init("ui_iteminfo_icon_point_01.png")
        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
        self._scrollLayout:addChild(point)
        
        local  baseText  = UI.Text:create()
        baseText:init(enchanting[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_40_62_106)
        local textUp = centerUp - baseText:getContentSize().height/2
        baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        baseText:setTextLeft()
        self._scrollLayout:addChild(baseText)

        local  baseValue  = UI.Text:create()
        baseValue:init(enchanting[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_40_62_106)
        baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width ,  textUp)
        self._scrollLayout:addChild(baseValue)

        if(baseText._width > attrWidth) then 
            baseText:setWidth(attrWidth)
            baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

            baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth,  textUp)
        end

        totalHeight = totalHeight + baseText:getContentSize().height
        k = k+1
    end
    --  比例属性
    -- print("--比例属性")
    -- dump(rateArr)
    if rateArr then 
        for i,data in ipairs(rateArr) do
            local centerUp = totalHeight + centerOffsetUp
            local point  = UI.Image:create()
            point:init("ui_iteminfo_icon_point_01.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            local  baseText  = UI.Text:create()
            baseText:init(data[1], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            baseText:setTextLeft()
            self._scrollLayout:addChild(baseText)

            local  baseValue  = UI.Text:create()
            baseValue:init(data[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
            baseValue:leftUp(leftOffset + pointBaseValueOffset +baseText._width, textUp)
            self._scrollLayout:addChild(baseValue)

            if(baseText._width > attrWidth) then 
                baseText:setWidth(attrWidth)
                baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
            end

            totalHeight = totalHeight + baseText:getContentSize().height
            k = k+1
        end
    end
    
    -- 套装属性
    -- print("--套装属性")
    -- dump(equipmentArr)
    if equipmentArr then 
        local centerUp = totalHeight + centerOffsetUp

        local point  = UI.Image:create()
        point:init("ui_iteminfo_icon_point_02.png")
        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
        self._scrollLayout:addChild(point)
        
        local  equipmentName  = UI.Text:create()
        equipmentName:init(string.format("%s",equipmentArr.setName), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
        local textUp = centerUp - equipmentName:getContentSize().height/2
        equipmentName:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        self._scrollLayout:addChild(equipmentName)

        local  equipmentNum  = UI.Text:create()
        equipmentNum:init(string.format("%s",equipmentArr.activeStr), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
        equipmentNum:leftUp(leftOffset + pointBaseValueOffset + equipmentName._width, textUp)
        self._scrollLayout:addChild(equipmentNum)

        k = k + 1
        totalHeight = totalHeight + equipmentName:getContentSize().height

        for i = 1,#equipmentArr.activationArr do 
            local oneAttr = equipmentArr.activationArr[i]
            local centerUp = totalHeight + centerOffsetUp
            -- 标点
            local point  = UI.Image:create()
            point:init("ui_iteminfo_icon_point_02.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            -- 描述
            local  baseText  = UI.Text:create()
            baseText:init(string.format("%s",oneAttr[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            baseText:setTextLeftUp()
            self._scrollLayout:addChild(baseText) 

            -- 数值
            local  baseValue  = UI.Text:create()
            baseValue:init(string.format("[%s]",oneAttr[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
            baseValue:setSize(30,20)
            baseValue:setTextLeftUp()
            baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width,  textUp)

            self._scrollLayout:addChild(baseValue)

            -- 根据相关数据来计算激活个数
            if(baseText._width > attrWidth) then 
                baseText:setWidth(attrWidth)
                baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth,  textUp)
            end

            totalHeight = totalHeight + baseText:getContentSize().height
        end

        for i = 1,#equipmentArr.noActivationArr do 
            local oneAttr = equipmentArr.noActivationArr[i]
            local centerUp = totalHeight + centerOffsetUp
            -- 标点
            local point  = UI.Image:create()
            point:init("ui_iteminfo_icon_point_02.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            -- 描述
            local  baseText  = UI.Text:create()
            baseText:init(string.format("%s",oneAttr[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_102_102)
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            baseText:setTextLeftUp()
            self._scrollLayout:addChild(baseText) 

            -- 数值
            local  baseValue  = UI.Text:create()
            baseValue:init(string.format("[%s]",oneAttr[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_102_102)
            -- baseValue:setFontSize(15)
            -- baseValue:setFontColor(UI.FONT_COLOR_107_99_91)
            baseValue:setSize(30,20)
            baseValue:setTextLeftUp()
            baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width,  textUp)

            self._scrollLayout:addChild(baseValue)

            -- 根据相关数据来计算激活个数
            if(baseText._width > attrWidth) then 
                baseText:setWidth(attrWidth)
                baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
                baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)

                baseValue:leftUp(leftOffset + pointBaseValueOffset + attrWidth, textUp)
            end
            totalHeight = totalHeight + baseText:getContentSize().height
        end
    end

    -- 特殊属性
    -- print("--特殊属性")
    -- dump(specialArr)
    if specialArr then 
        for i,data in ipairs(specialArr) do
            local centerUp = totalHeight + centerOffsetUp

            local point  = UI.Image:create()
            point:init("ui_iteminfo_icon_point_01.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)

            local  baseText  = UI.Text:create()
            baseText:init(string.format("%s",data), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_42_103_85)
            baseText:setTextLeft()
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            baseText:setLineSpacing(-4)
            baseText:setWidth(245)
            baseText:setText(string.format("%s",data))
            self._scrollLayout:addChild(baseText)
            
            k = k+1

            totalHeight = totalHeight + baseText:getContentSize().height
        end
    end

    -- 添加宝石叠加的属性
    local gemNormalDesArr = {}
    local gemSpecialDesArr = {}
    local holeDatas = self.mGoodsData:getHoleDatas()
    for _,holeData in ipairs(holeDatas) do 
        local gemStoneData = holeData:getGemStoneData()
        if(gemStoneData) then 
            local arr = gemStoneData:getNormalDetailDescription()
            for k,v in ipairs(arr) do 
                table.insert(gemNormalDesArr, v)
            end

            local specialDes = gemStoneData:getSpecialDetailDescription()
            if(specialDes) then 
                table.insert(gemSpecialDesArr, specialDes)
            end
        end
    end

    if gemNormalDesArr then 
        for i,data in ipairs(gemNormalDesArr) do
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init("ui_iteminfo_icon_point_01.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            local baseText = UI.Text:create()
            baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
            baseText:setTextLeft()
            local textUp = centerUp - baseText:getContentSize().height/2
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
            if(baseText:getContentSize().width > attrWidth) then 
                baseText:setWidth(attrWidth)
                baseText:setText(string.format("%s",data[1]))
            end
            self._scrollLayout:addChild(baseText)

            local baseValue = UI.Text:create()
            baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
            baseValue:leftUp(leftOffset + pointBaseValueOffset + baseText._width, textUp)
            self._scrollLayout:addChild(baseValue)
            
            totalHeight = totalHeight + baseText:getContentSize().height
            k = k + 1
        end
    end

    if gemSpecialDesArr then 
        for i,specialDes in ipairs(gemSpecialDesArr) do
            local centerUp = totalHeight + centerOffsetUp

            local point = UI.Image:create()
            point:init("ui_iteminfo_icon_point_01.png")
            point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
            self._scrollLayout:addChild(point)
            
            local baseText = UI.Text:create()
            baseText:init(specialDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_85_49_114)
            baseText:setTextLeft()
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, centerUp - baseText:getContentSize().height/2)
            baseText:setWidth(attrWidth + 20)
            baseText:setText(specialDes)
            self._scrollLayout:addChild(baseText)
            
            totalHeight = totalHeight + baseText:getContentSize().height
            k =  k + 1
        end 
    end
    totalHeight = totalHeight < scrollView:getContentSize().height and scrollView:getContentSize().height or totalHeight
    self._scrollLayout:setSize(252, totalHeight)
end

function EquipRecastLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    
    self.iconAnimation:setAnimation("ready1", false)
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function EquipRecastLayer:bagDragMovedCallback(grid, touchPosition)

end

function EquipRecastLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    print("RemouldLayer:bagDragEndedCallback")
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        UI.ScrollBar:createByText(UI.TEXT_1212312)
        self.iconAnimation:setAnimation("ready3", false)
        return
    end

    if goodsData and (goodsData:haveGemStone()) then
        local showStr = UI.TEXT_1212313
        UI.ScrollBar:createByText(showStr)
        self.iconAnimation:setAnimation("ready3", false)
        return
    end 

    if goodsData and (goodsData:haveGlyph()) then
        local showStr = UI.TEXT_227015
        UI.ScrollBar:createByText(showStr)
        self.iconAnimation:setAnimation("ready3", false)
        return
    end

    if goodsData and goodsData:getEquipRecastData() == nil  then
        UI.ScrollBar:createByText(UI.TEXT_1212312)
        self.iconAnimation:setAnimation("ready3", false)
        return
    end
    
    
    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    if not isInBag then
        self.iconAnimation:setAnimation("putin1", false)
        local _randomArr = goodsData._randomArr
        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end
        self.mGoodsGrid:show()

        goodsData._changeNum = -1
        self.mGoodsData = goodsData
        self._bagGridList:refreshView()
        self:refreshGoodsGrid()
        self:showTempAttr()
        -- self:showAllAttr()

        if self.npcInfomationNum == 0 then
            self.npcInfomationNum = self.npcInfomationNum + 1
        end
    else
        self.iconAnimation:setAnimation("ready3", false)
    end
end 

-- 模版函数：更新组建的视图(必备)
function EquipRecastLayer:onUpdateView()
  
end

--刷新改造材料
function EquipRecastLayer:refreshGoodsGrid()
    if self.mGoodsData == nil then
        self.mGoodsGrid:hide()
        self:updateBtnState()
        return
    end
    self.mGoodsGrid:setData(self.mGoodsData)
    self.mGoodsGrid:updateView()
    self:updateBtnState()
end

function EquipRecastLayer:updateBtnState()
    -- body
end

function EquipRecastLayer:onTouchBeganByGoodsGrid(grid)
    if not self.mCanRecast then
        return false
    end
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    self.iconAnimation:setAnimation("ready1", false)
    return true
end

function EquipRecastLayer:onTouchEndedByGoodsGrid(grid, isInSide)
    if not self.mCanRecast then
        return
    end
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    if isInSide then
        self.mGoodsGrid:centerUp(68)
        self.mGoodsGrid:show()
        self.iconAnimation:setAnimation("putin1", false)
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()
        local goodsData = grid:getData()
        self.mGoodsData._changeNum = 0

        self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

        self.mGoodsData = nil
        self:refreshGoodsGrid()
        self._bagGridList:refreshView()
        self:showInitAttr()
        self.iconAnimation:setAnimation("ready3", false)
    end
end

function EquipRecastLayer:recastCallBack(data, entityID)
    local text = ""
    local actType = Game.RewardLayerOpenAction.Scale_Center
    local delayTime = 1
    Avalon.Scheduler:scheduleUpdateOnce(self, function ()
        Avalon.AudioManager:playSound("1544")
    end, 0.1)
    if data.isSuccess then
        text = UI.TEXT_1212316
        actType = Game.RewardLayerOpenAction.Scale_Center
        self.recastAnimation:setAnimation("success", false)
        self.lightAnimation:setAnimation("success", false)
        self.downAnimation:setAnimation("success", false)
        delayTime = 2
    else
        text = UI.TEXT_1212317
        actType = Game.RewardLayerOpenAction.Move_Top2Center_Slow
        self.recastAnimation:setAnimation("fail", false)
        self.lightAnimation:setAnimation("fail", false)
        self.downAnimation:setAnimation("fail", false)
        delayTime = 1.5
    end
    Avalon.Scheduler:scheduleUpdateOnce(self, function ()
        if tolua.isnull(self) then
            return
        end
        local rewardGoodsArr = {}
        local goodData = GoodsDataManager:getEquipmentForEntityID(entityID)
        table.insert(rewardGoodsArr, goodData)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, function()
            if not tolua.isnull(self) then
                self._bagGridList:updateCanDrag(true)
                self.mCanRecast = true
                self.mGoodsData._changeNum = 0
                self.mGoodsData = GoodsDataManager:getEquipmentForEntityID(entityID)
                self.mGoodsData._changeNum = -1
                self:refreshGoodsGrid()
                self._bagGridList:refreshView()
                -- self:showInitAttr()
                self:showTempAttr()
                -- self:showAllAttr() 
                self.entityID = nil
            end
        end, text, nil, nil, true, actType)
    end, delayTime)
    Avalon.Scheduler:scheduleUpdateOnce(self, function ()
        if data.isSuccess then
            Avalon.AudioManager:playSound("1517")
        else
            Avalon.AudioManager:playSound("1518")
        end
    end, 1.3)
end


-- 注册监听事件(可选)
function EquipRecastLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_EQUIP_RECAST, self, self.recastCallBack)
end

-- 注销监听事件(可选)
function EquipRecastLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_EQUIP_RECAST, self, self.recastCallBack)
end