------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2020/12/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MiraclePivotCellView = require ("app.modules.miracle.MiraclePivotCellView")

local winSize = cc.Director:getInstance():getWinSize()
local MiracleView = class("MiracleView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_prayer.plist"
}

-- local COM_WIDTH = 1061
local COM_HEIGHT = 592
local COM_WIDTH = 880
-- local COM_HEIGHT = 565

local oneDelayTime = 0.1
local minWaitingTime = 0.9
local startMoveTime = 0.5  -- 图标的移动时间

-- 调整时间
local speedAcceleration = 1.011
local intervalTime = 0.4
local maxSpeed = 1500
local basSpeed = 400
local oneDt = 0.029
-- 是否显示百分比
local isShowPercent = false

function MiracleView:ctor()
    MiracleView.super.ctor(
    	self,
    	UI.Type.MAIN_UI_MIRACLE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    -- self._oldData = clone(mvc.miracleModel:getAllMiracleSlotData())
    self.shenBeiHeight = 0
    self:bindModel()
    self:initPivotTime()
end

function MiracleView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.miracle", "Miracle", false)
    MiracleView.super.init(self, ... )
end

function MiracleView:dtor()
    MiracleView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.miracle.MiracleView")
end


function MiracleView:onInitView()
    -- 总背景
    local bg  = UI.Image:create();
    bg:init("ui_prayer_bg_01.png")
    bg:center()
    self:addChild(bg)
    
    -- 标题背景
    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg, 1000)

    -- 标题
    local title = UI.Text:create()
	title:init(UI.TEXT_1325208, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_187_181_175)
	title:center()
    titleBg:addChild(title)

    -- 背景纸
    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(864, 517)
    bgLayout:leftBottom(105,21)
    bg:addChild(bgLayout)
    -- bgLayout:enableDebugDraw()
    self.bgLayout = bgLayout

    -- 
    local rewardLayout = UI.Layout:create()
    rewardLayout:init()
    rewardLayout:setSize(winSize.width, winSize.height)
    rewardLayout:center()
    bg:addChild(rewardLayout, 1000)
    -- bgLayout:enableDebugDraw()
    self.rewardLayout = rewardLayout

    local maskUp  = UI.Image:create()
    maskUp:init("ui_prayer_slatebg_01.png")
    maskUp:centerUp(-20)
    bgLayout:addChild(maskUp, 2)

    local maskDown  = UI.Image:create()
    maskDown:init("ui_prayer_slatebg_03.png")
    maskDown:leftBottom(0,0)
    bgLayout:addChild(maskDown,2)

    local currencyPanel = UI.CurrencyPanel:create(UI.FONT_COLOR_190_190_190, true)
    currencyPanel:leftUp(109, -5)
    currencyPanel:setShowShopButton(true, 52)
    self.bgLayout:addChild(currencyPanel, 3)
    self.currencyPanel = currencyPanel

    -- 878*536
    self:initPrayerLevel()
    self:refreshPrayerLevel()
    self:initPivot()

    self:initRightLayout()
    self:refreshRightLayout()

    -- 处理装饰物
    local chushouAnimation = Avalon.Animation:create("effect_ui_town_prayer_chushou.json", "effect_ui_town_prayer_chushou.atlas", 1)
    chushouAnimation:setAnimation(0, "stand", true)
    chushouAnimation:setPosition(864/2, 517/2+15)
    self.bgLayout:addChild(chushouAnimation, 102)
    self.chushouAnimation = chushouAnimation
end

function MiracleView:initPrayerLevel()
    local dataArr = ConfigManager:getAllMiracleAttributes()
    local attrLayout = UI.Layout:create()
    attrLayout:init()
    attrLayout:setSize(634, 120)
    attrLayout:leftBottom(0, 0)
    self.bgLayout:addChild(attrLayout, 30)

    local maskDown  = UI.Image:create()
    maskDown:init("ui_prayer_slatebg_02.png")
    maskDown:centerBottom(0)
    self.bgLayout:addChild(maskDown,30)

    local attrUpLayout = UI.Layout:create()
    attrUpLayout:init()
    attrUpLayout:setSize(634, 120)
    attrUpLayout:leftBottom(0, 0)
    self.bgLayout:addChild(attrUpLayout, 30)
    
    self.prayerNodeArr = {}
    if(dataArr) then 
        local oneWith = 116
        local startX = 22.5
        local startY = 16
        for k,data in ipairs(dataArr) do 
            local attrNode = UI.Layout:create()
            attrNode:init()
            attrLayout:addChild(attrNode)
            
            local kuang  = UI.Layout:create()
            kuang:init()
            kuang:setSize(100, 100)
            kuang:centerBottom(0)
            attrNode:addChild(kuang)

            local attrUpNode = UI.Layout:create()
            attrUpNode:init()
            attrUpLayout:addChild(attrUpNode)
            
            local kuangUp  = UI.Layout:create()
            kuangUp:init()
            kuangUp:setSize(100, 100)
            kuangUp:centerBottom(0)
            attrUpNode:addChild(kuangUp)

            -- 背景进度
            self.shenBeiHeight = 67
            local centerLayout = UI.Layout:create()
            centerLayout:init()
            centerLayout:center()
            -- centerLayout:setPosition(0,-self.shenBeiHeight)

            local progreBg  = UI.Image:create()
            progreBg:init(string.format("ui_prayer_level_0%d.png", data.ID))
            progreBg:center()
            centerLayout:addChild(progreBg)

            local shenbeiAnimation = Avalon.Animation:create("effect_ui_town_prayer_shengbei.json", "effect_ui_town_prayer_shengbei.atlas", 1)
            shenbeiAnimation:setAnimation(0, "green", false)
            shenbeiAnimation:setPosition(0, 34)
            centerLayout:addChild(shenbeiAnimation)

            local centerAnimation = Avalon.Animation:create("effect_ui_town_prayer_shengbei.json", "effect_ui_town_prayer_shengbei.atlas", 1)
            centerAnimation:setAnimation(0, "trigger_3", true)
            centerAnimation:setPosition(0, 0)
            centerLayout:addChild(centerAnimation)

            local _ckipperSprite = cc.Sprite:createWithSpriteFrameName("ui_prayer_filling_black.png")
            local _clipper = cc.ClippingNode:create(_ckipperSprite)
            _clipper:setPosition(kuang:getContentSize().width/2,kuang:getContentSize().height/2)
            _clipper:setAlphaThreshold(0.05)
            _clipper:addChild(centerLayout)
            kuang:addChild(_clipper)

            -- 等级
            local levelBg  = UI.Image:create()
            levelBg:init("ui_prayer_bg_grade.png")
            levelBg:leftUp(7, 6)
            kuangUp:addChild(levelBg,2)
            
            local levelLabel = UI.Text:create()
            levelLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 184, g = 184, b = 184})
            levelLabel:center()
            levelLabel:useDefaultShadowOnlyStype()
            levelBg:addChild(levelLabel)

            -- 进度数值
            local expBg  = UI.Image:create()
            expBg:init("ui_prayer_bg_exp.png")
            expBg:centerBottom(4)
            kuangUp:addChild(expBg, 2)

            local expLabel = UI.Text:create()
            expLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_167_136)
            expLabel:center(7)
            expBg:addChild(expLabel)

            -- 最下面的箭头
            local triangle  = UI.Image:create()
            triangle:init("ui_prayer_triangle.png")
            triangle:centerBottom(-12)
            kuangUp:addChild(triangle, 2)

            attrNode:leftBottom(startX + (k-1) * oneWith + kuang:getContentSize().width/2, startY)
            attrUpNode:leftBottom(startX + (k-1) * oneWith + kuang:getContentSize().width/2, startY)

            attrNode.data = data
            attrNode.levelLabel = levelLabel
            attrNode.shenbeiAnimation = shenbeiAnimation
            attrNode.centerLayout = centerLayout
            attrNode.expLabel = expLabel
            attrNode.kuangUp = kuangUp

            table.insert(self.prayerNodeArr, attrNode)

            local position = cc.p(startX + (k-1) * oneWith + kuang:getContentSize().width/2, startY + 100)

            kuang:setTouchEnable(true)
            kuang:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
                self:showPrayerInfo(attrNode.data, self.bgLayout, position)
            end)
            kuang:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
                self:closePrayerInfo()
            end)
        end
    end
end

function MiracleView:refreshPrayerLevel(endCallBack)
    local oldData = self._oldData
    self._oldData = clone(mvc.miracleModel:getAllMiracleSlotData())
    local delayTime = 0
    for k, node in pairs(self.prayerNodeArr) do 
        local oneUseTime = 0
        local ID = node.data.ID

        local oldSlotData = nil
        if(oldData) then
            for k,slot in ipairs(oldData) do 
                if(slot.slotId == ID) then 
                    oldSlotData = slot
                    break
                end
            end
        end
        
        local slotData = mvc.miracleModel:getMiracleSlotDataByID(ID)
        -- TODO test
        -- slotData = clone(slotData)
        -- slotData.level = slotData.level + 1
        if(slotData) then
            if(oldData) then 
                if(slotData.level > oldSlotData.level) then 
                    for level=oldSlotData.level+1,slotData.level, 1 do
                        self:handleDelay(self, oneUseTime, function()
                            self:_refreshLevelUpInfo(node, level, slotData.slotId)
                        end)
                        oneUseTime = oneUseTime + 10/32
                    end
                    oneUseTime = oneUseTime + 0.5
                    self:handleDelay(self, oneUseTime, function()
                        node.centerLayout:runAction(cc.Sequence:create(cc.MoveTo:create(0.001, cc.p(0, -self.shenBeiHeight))))
                    end)
                    oneUseTime = oneUseTime + 0.1
                end
            end

            if(oldData == nil 
                or (oldSlotData and (oldSlotData.level ~= slotData.level or oldSlotData.exp ~= slotData.exp))) then
                local miracleData = ConfigManager:getMiraclePrayerByID(slotData.level + 1)
                self:handleDelay(self, oneUseTime, function()
                    self:_refreshInfo(node, slotData, miracleData, oldData == nil)
                end)
            end
        end
        if(delayTime < oneUseTime) then 
            delayTime = oneUseTime
        end
    end

    if(endCallBack) then
        -- print("refreshPrayerLevel=", delayTime)
        self:handleDelay(self, delayTime, function()
            endCallBack()
        end)
    end
end

function MiracleView:_refreshLevelUpInfo(node, level, slotId)
    node.levelLabel:setText(tostring(level))
    if(node.levelUpAnimation == nil) then
        local levelUpAnimation = Avalon.Animation:create("effect_ui_town_prayer_shengbei.json", "effect_ui_town_prayer_shengbei.atlas", 1)
        levelUpAnimation:setAnimation(0, "green", false)
        levelUpAnimation:setPosition(node.kuangUp:getContentSize().width/2, node.kuangUp:getContentSize().height/2)
        node.kuangUp:addChild(levelUpAnimation)
        node.levelUpAnimation = levelUpAnimation
    end

    node.centerLayout:stopAllActions()
    node.centerLayout:runAction(cc.Sequence:create(cc.MoveTo:create(10/32, cc.p(0, 0))))
    node.levelUpAnimation:setAnimation(0, string.format("trigger_2_0%d", slotId), false)
end

function MiracleView:_refreshInfo(node, slotData, miracleData, isInit)
    local level = slotData.level
    local nowExp = slotData.exp
    node.levelLabel:setText(tostring(level))
    if(miracleData) then
        local newPercent = nowExp/miracleData.exp
        local start = - self.shenBeiHeight
        start = start + self.shenBeiHeight * newPercent
        if(start > 0) then 
            start = 0
        end
        node.centerLayout:stopAllActions()
        node.centerLayout:runAction(cc.MoveTo:create(0.3, cc.p(0, start)))
        if(not isInit) then
            node.shenbeiAnimation:setAnimation(0, string.format("trigger_1_0%d",slotData.slotId), false)
        end
        if isShowPercent == true then
            node.expLabel:setText(string.format("%d%%", math.min(math.floor(nowExp/miracleData.exp*100), 100)))
        else
            node.expLabel:setText(string.format("%d/%d", nowExp,miracleData.exp))
        end
    else
        node.expLabel:setText("Max/Max")
    end
end

function MiracleView:initPivot()
    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:setSize(583, 402)
    centerLayout:leftUp(0, 16)
    self.bgLayout:addChild(centerLayout)

    self._pivotArr = {}
    local oneWith = 116
    for i=1,5,1 do
        local cellView = MiraclePivotCellView:create()
        cellView:init(self.moveDisArr)
        cellView:centerLeft((i - 1) * oneWith)
        cellView.index = i

        centerLayout:addChild(cellView,3)
        table.insert(self._pivotArr, cellView)
    end

    -- 添加轮框
    -- 
    local xuanzhongAnimation = Avalon.Animation:create("effect_ui_town_prayer_xuanzhong.json", "effect_ui_town_prayer_xuanzhong.atlas", 1)
    xuanzhongAnimation:setAnimation(0, "idle", true)
    xuanzhongAnimation:setPosition(centerLayout:getContentSize().width/2-3, centerLayout:getContentSize().height/2)
    centerLayout:addChild(xuanzhongAnimation)
    xuanzhongAnimation:setVisible(false)
    self.xuanzhongAnimation = xuanzhongAnimation
end

function MiracleView:initRightLayout()
    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(190, 535)
    rightLayout:rightBottom(43, 0)
    self.bgLayout:addChild(rightLayout, 100)
    local offsetY = 14
    local diaoshuAnimation = Avalon.Animation:create("effect_ui_town_prayer_diaosu.json", "effect_ui_town_prayer_diaosu.atlas", 1)
    diaoshuAnimation:setAnimation(0, "stand", true)
    diaoshuAnimation:setPosition(190/2, 535/2 + offsetY)
    rightLayout:addChild(diaoshuAnimation)
    self.diaoshuAnimation = diaoshuAnimation

    --道具数量
    local itemLayout = UI.Layout:create()
    itemLayout:init()
    itemLayout:centerBottom(89+ offsetY)
    rightLayout:addChild(itemLayout,10)

    local itemBg = UI.Image:create()
    itemBg:init("ui_prayer_bg_03.png")
    itemBg:center()
    itemLayout:addChild(itemBg)
    
    local goodsData = GoodsDataManager:createLocalGoodsData(PublicDefine.ITEM_ID.ITEM_ID_DRAW_MIRACLEPRAYER)
    self._miracleGoodsData = goodsData
    if(goodsData) then 
        local itemImage = UI.Image:create()
        itemImage:init(goodsData:getSmallIconName())
        itemImage:center()
        itemLayout:addChild(itemImage)
        self.itemHaveImage = itemImage

        local itemNum  = UI.Text:create()
        itemNum:init("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)    
        itemNum:centerLeft(55)
        itemLayout:addChild(itemNum, 10) 
        self.itemHaveNum = itemNum
    end

    -- 按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_50_50_44)
    btn:setText("")
    btn:centerBottom(15 + offsetY)
    btn:setInterval(1)
    rightLayout:addChild(btn, 100)
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self, obj)
        self:onPrayerClick()
    end)
    self.prayerBtn = btn

    local itemImage = UI.Image:create()
    itemImage:init("symbol_gaming_diamond.png")
    itemImage:centerLeft(0)
    btn:addChild(itemImage, 100)
    self.itemImage = itemImage

    local itemNum  = UI.Text:create()
    itemNum:init("0", UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_50_50_44)    
    itemNum:centerLeft(55)
    btn:addChild(itemNum, 10) 
    self.itemNum = itemNum

    local prayerNumText  = UI.Text:create()
    prayerNumText:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)    
    prayerNumText:centerBottom(4)
    rightLayout:addChild(prayerNumText, 10) 
    self.prayerNumText = prayerNumText
end

function MiracleView:refreshRightLayout()
    if(self._miracleGoodsData == nil) then return end

    local costNum = mvc.miracleModel:getPrayerCost()
    local itemNum = mvc.miracleModel:getItemPrayerNum()
    if(self.itemHaveImage and self.itemHaveNum) then 
        self.itemHaveNum:setText(string.format("%d", itemNum))
        local offset = 10
        local startX = - (self.itemHaveImage:getContentSize().width + self.itemHaveNum:getContentSize().width + offset)/2
        self.itemHaveImage:centerLeft(startX)
        self.itemHaveNum:centerLeft(startX + self.itemHaveImage:getContentSize().width + offset)
    end

    if(costNum == 0) then 
        self.prayerBtn:enable()
        self.prayerBtn:setText(UI.TEXT_1325204)

        self.itemImage:hide()
        self.itemNum:hide()
    else
        self.prayerBtn:setText("")
        self.itemImage:show()
        self.itemNum:show()

        local showNum = 1
        local iconName = self._miracleGoodsData:getSmallIconName()
        local isEnough = true
        if(itemNum > 0) then 
            showNum = 1
        elseif costNum ~= nil then
            showNum = costNum
            iconName = "symbol_gaming_diamond.png"
            local GameDataManager = require("app.game.GameDataManager")
            if(GameDataManager:getInstance():getDiamond() < showNum) then 
                isEnough = false
            end
        else
            showNum = 1
            isEnough = false
        end
        self.itemImage:setSpriteName(iconName)
        self.itemNum:setText(string.format("%d", showNum))
        local offset = 10
        local startX = self.prayerBtn:getContentSize().width/2 - (self.itemImage:getContentSize().width + self.itemNum:getContentSize().width + offset)/2
        self.itemImage:centerLeft(startX)
        self.itemNum:centerLeft(startX + self.itemImage:getContentSize().width + offset)
        if(isEnough) then 
            self.prayerBtn:enable()
            self.itemNum:setFontColor(UI.FONT_COLOR_50_50_44)
        else
            self.prayerBtn:disable()
            self.itemNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end

    if(self.prayerNumText) then 
        local drawCount = mvc.miracleModel:getTotalDrawCount()
        local totalNum = mvc.miracleModel:getPrayerTotalNum()
        if(drawCount == totalNum) then 
            self.prayerNumText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.prayerNumText:setFontColor(UI.FONT_COLOR_190_190_190)
        end
        self.prayerNumText:setText(string.format(LanguageManager:getInstance():getLocalString(1113869), totalNum - drawCount, totalNum))
    end
end

function MiracleView:onPrayerClick()
    local costNum = mvc.miracleModel:getPrayerCost()
    local itemNum = mvc.miracleModel:getItemPrayerNum()

    local usePrayGoods = false
    if(costNum == 0) then 
        usePrayGoods = false
    elseif itemNum > 0 then
        usePrayGoods = true
    elseif (costNum == nil) then
        return  
    end
    if(usePrayGoods) then 
        local itemData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.ITEM_ID.ITEM_ID_DRAW_MIRACLEPRAYER, false, 0)
        if itemData and itemData:getIsLock() then
            UI.ScrollBar:createByTextID(1170121)
            return
        end
    end

    Net.NetRoleSystem:reqMiraclePrayer(usePrayGoods)
    self.currencyPanel:beginCacheMode()
    self:startPivot()
    self.prayerBtn:disable()
end

function MiracleView:startPivot()
    self.wasStartEnd = false
    if(self.xuanzhongAnimation) then 
        self.xuanzhongAnimation:setVisible(false)
    end
    if(self._pivotArr) then 
        local totalDelay = 0
        self.startSoundID = Avalon.AudioManager:playSound(10069)
        for k, node in ipairs(self._pivotArr) do 
            self:handleDelay(self, totalDelay, function()
                node:start(function()
                    self:startCallback()
                end)
            end)
            totalDelay = totalDelay + oneDelayTime
        end
    end
    self.diaoshuAnimation:setAnimation(0, "begin", false)
    self.diaoshuAnimation:addAnimation(0, "idle", true)
    self.chushouAnimation:setAnimation(0, "begin", false)
    self.chushouAnimation:addAnimation(0, "idle", true)
    self._startPivotTime = AvalonUtil.getCurrentTime()
end

function MiracleView:startCallback()
    if(self.wasStartEnd ~= true) then
        -- print("MiracleView:startCallback", self.prayerData)
        self.wasStartEnd = true
        if(self.prayerData) then 
            self:endPivot(self.prayerData)
            self.prayerData = nil
        end
    end
end

function MiracleView:endPivot(data)
    -- print("MiracleView:endPivot", data)
    local useTime = (AvalonUtil.getCurrentTime() - self._startPivotTime) /1000
    local totalDelay = minWaitingTime - useTime
    if(self._pivotArr) then 
        local beginEnd =false
        for k, node in ipairs(self._pivotArr) do 
            local choiceID = data.iconIds[k]
            if(choiceID) then
                -- 这里切换结束动画
                local calTotal = totalDelay + oneDelayTime*4 - 1/3
                self:handleDelay(self, calTotal, function()
                    self.diaoshuAnimation:setAnimation(0, "end", false)
                    self.diaoshuAnimation:addAnimation(0, "stand", false)
                    self.chushouAnimation:setAnimation(0, "end", false)
                    self.chushouAnimation:addAnimation(0, "stand", false)
                end)

                self:handleDelay(self, totalDelay, function()
                    node:stop(choiceID, function()
                        if(beginEnd ~= true) then
                            beginEnd = true
                            self:handleDelay(self, totalDelay, function()
                                -- print("endPivot moveFunction")
                                if(self.xuanzhongAnimation) then 
                                    self.xuanzhongAnimation:setVisible(true)
                                end
                                self:moveFunction(data)
                            end)
                        end
                    end)
                end)
                totalDelay = totalDelay + oneDelayTime
            end
        end
    else
        Avalon.AudioManager:stopSound(self.startSoundID)
        self:endRefersh() 
    end
end

function MiracleView:endRefersh()
    self:refreshPrayerLevel(function()
        self:refreshRightLayout() 
    end)
    if(self.currencyPanel) then
        self.currencyPanel:endCacheMode()
    end

    if(self.rewardColorLayer) then
        self.rewardColorLayer:setVisible(false)
    end
    if(self.diaoshuAnimation) then
        self.diaoshuAnimation:setAnimation(0, "stand", false)
    end
    if(self.chushouAnimation) then 
        self.chushouAnimation:setAnimation(0, "stand", false)
    end
end

function MiracleView:handleOneShowData(data, isSingle, index, animationName, responseData)
    local showData = {}
    local positionArr = {}
    local slotNameArr = {}
    local indexArr = data.indexArr
    local playerIconData = ConfigManager:getMiraclePrayerIconByID(data.key)
    showData.iconName = playerIconData.icon
    showData.key = data.key
    -- print("handleOneShowData", data, isSingle, index, animationName)
    local offset = nil
    for k,v in ipairs(indexArr) do
        local pivotNode = self._pivotArr[v]
        if(pivotNode and not tolua.isnull(pivotNode)) then
            if(offset == nil) then 
                local widht, height = pivotNode:getSize()
                offset = {x=widht/2,y=height/2}
            end
            local widht, height = pivotNode:getPosition()
            local worldPosition = pivotNode:getParent():convertToWorldSpace(cc.p(widht + offset.x, height + offset.y))
            local position = self.rewardLayout:convertToNodeSpace(worldPosition)
            -- print("calculation=", v, widht, height, offset,worldPosition, position)
            table.insert(positionArr, position)
        end
    end

    -- 计算添加属性的值
    if(playerIconData.addexpto and #playerIconData.addexpto > 0 and playerIconData.addexpto[1] ~= 0) then 
        showData.endDataArr = {}
        for k,expID in ipairs(playerIconData.addexpto) do
            local endImageName = string.format("ui_prayer_filling_0%d.png", expID)
            -- local endImageName = playerIconData.icon
            -- local endImageName = "ui_prayer_filling_02.png"
            local prayerNode = self.prayerNodeArr[expID]
            if(prayerNode) then
                local x,y = prayerNode:getPosition()
                local worldPosition = prayerNode:getParent():convertToWorldSpace(cc.p(x, y + 56))
                local position = self.rewardLayout:convertToNodeSpace(worldPosition)

                local num = 1
                if responseData.slotExps then 
                    for k, v in ipairs(responseData.slotExps) do 
                        if(v.slotId == expID) then 
                            num = v.addExp
                        end
                    end
                end
                -- print("endImageName=",endImageName, position, num, data)
                local endData = {}
                endData.iconName = endImageName
                endData.position = position

                for k,addNum in ipairs(playerIconData.addexp) do
                    if(addNum == num) then 
                        if(k==1) then 
                            num = 0
                        elseif k==2 then 
                            num = 7
                        elseif k==3 then
                            num = 14
                        elseif k==4 then
                            num = 21
                        elseif k==5 then
                            num = 28
                        end
                        break
                    else
                        if(num > 28) then 
                            num = 28
                        end
                    end
                end
                

                endData.addExp = num
                table.insert(showData.endDataArr, endData)
            end
        end
    else
        showData.endDataArr = {}
        local endImageName = nil
        local endNode = nil
        if(playerIconData.ifCoin == 1) then 
            endImageName = "ui_prayer_filling_gold.png"
            endNode = self.currencyPanel:getGoldIcon()
        elseif playerIconData.ifCrystal == 1 then 
            endImageName = "ui_prayer_filling_diamond.png"
            endNode = self.currencyPanel:getDiamondIcon()
        end

        if(endNode and endImageName) then 
            local x,y = endNode:getPosition()
            local worldPosition = endNode:getParent():convertToWorldSpace(cc.p(x, y + 15))
            local position = self.rewardLayout:convertToNodeSpace(worldPosition)

            -- print("endImageName  22=",endImageName, position, num, data)
            local endData = {}
            endData.iconName = endImageName
            endData.position = position
            endData.addExp = 28
            table.insert(showData.endDataArr, endData)
        end
    end

    showData.positionArr = positionArr
    showData.slotNameArr = slotNameArr

    if(isSingle) then
        for k,v in ipairs(indexArr) do
            table.insert(slotNameArr, animationName.."bao_0"..k)
        end
    else
        if(index == 1) then 
            for k,v in ipairs(indexArr) do
                table.insert(slotNameArr, animationName.."bao_0"..k)
            end
        else
            for k,v in ipairs(indexArr) do
                table.insert(slotNameArr, animationName.."bao_0"..(k+2))
            end
        end 
    end

    return showData
end

function MiracleView:prayerResponse(data)
    if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
        -- print("prayerResponse=", data)
        -- {0,7,25,125,625}
        -- local testData = {iconIds = {1, 2, 3, 4, 5}, slotExps = {}}
        -- local testData = {iconIds = {1, 3, 5, 6, 6}, slotExps = {{addExp = 7, slotId = 1}, {addExp = 7, slotId = 2}, {addExp = 7, slotId = 3}, {addExp = 7, slotId = 4}, {addExp = 7, slotId = 5}}}
        -- local testData = {iconIds = {1, 1, 5, 6, 6}, slotExps = {{addExp = 7, slotId = 1}, {addExp = 7, slotId = 2}, {addExp = 7, slotId = 3}, {addExp = 7, slotId = 4}, {addExp = 7, slotId = 5}}}
        -- local testData = {iconIds = {1, 1, 1, 6, 6}, slotExps = {{addExp = 25, slotId = 1}, {addExp = 25, slotId = 2}, {addExp = 25, slotId = 3}, {addExp = 25, slotId = 4}, {addExp = 25, slotId = 5}}}
        -- local testData = {iconIds = {1, 1, 1, 5, 6}, slotExps = {{addExp = 25, slotId = 1}, {addExp = 25, slotId = 2}, {addExp = 25, slotId = 3}, {addExp = 25, slotId = 4}, {addExp = 25, slotId = 5}}}
        -- local testData = {iconIds = {1, 1, 1, 1, 6}, slotExps = {{addExp = 125, slotId = 1}, {addExp = 125, slotId = 2}, {addExp = 125, slotId = 3}, {addExp = 125, slotId = 4}, {addExp = 125, slotId = 5}}}
        -- local testData = {iconIds = {6, 6, 6, 6, 6}, slotExps = {{addExp = 625, slotId = 1}, {addExp = 625, slotId = 2}, {addExp = 625, slotId = 3}, {addExp = 625, slotId = 4}, {addExp = 625, slotId = 5}}}
        
        -- data.iconIds = testData.iconIds
        -- data.slotExps = testData.slotExps

        if(self.wasStartEnd == true)then
            self:endPivot(data)
        else
            self.prayerData = data
        end
    else
        -- 停止所有的旋转
        for k, node in ipairs(self._pivotArr) do 
            node:stop(k)
        end
        if(self.diaoshuAnimation) then
            self.diaoshuAnimation:setAnimation(0, "stand", false)
        end
        self.currencyPanel:endCacheMode()
        self:refreshPrayerLevel()
        self:refreshRightLayout()
    end
end

function MiracleView:handleDelay(node, delayTime, callBack) 
    if(node and delayTime and callBack) then
        local delayAction = cc.DelayTime:create(delayTime)
        node:runAction(cc.Sequence:create(delayAction, cc.CallFunc:create(function()
            if(callBack) then 
                callBack()
            end
        end)))
    end
end

function MiracleView:showPrayerInfo(data, attrLayout, position)
    if(self._compareLayout) then 
        self._compareLayout:removeFromParent(true)
        self._compareLayout = nil
    end

    attrID = data.ID
    local slotData = mvc.miracleModel:getMiracleSlotDataByID(attrID)

    local width = 205
    local height = 10
    local lineUp = 0
    local lineTop = 0

    local prayerArr = mvc.miracleModel:getPrayerAttr(attrID)

    local compareLayout = UI.Layout:create()
    compareLayout:init()
    compareLayout:setTouchEnable(true)
    compareLayout:setSize(205, 205)
    attrLayout:addChild(compareLayout, 1000)

    compareLayout:leftBottom(position.x - width/2, position.y)

    self._compareLayout = compareLayout
    -- 添加背景
    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg_black.png")
    bgImage:setContentSize(width, height)
    bgImage:setCapInsets(CCRectMake(14, 17, 4, 4))
    bgImage:setPosition(cc.p(102.5, 102.5))
    self._compareLayout:addChild(bgImage)

    local startX = 10
    local startY = 10
    local oneHeight = 22

    if isShowPercent == true then
        -- 当前经验累积值
        local nowExp = slotData.exp
        local waitingExp = nil
        local miracleData = ConfigManager:getMiraclePrayerByID(slotData.level + 1)
        if(miracleData) then
            waitingExp = miracleData.exp
        end
        local str = ""
        if(waitingExp == nil) then 
            str = "Max/Max"
        else
            str = nowExp.."/"..waitingExp
        end
        
        local text = UI.Text:create()
        text:init(UI.TEXT_1213618..": "..str, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_20_105_22)
        text:centerUp(startY)
        self._compareLayout:addChild(text)
        startY = startY + text:getContentSize().height
        lineTop = startY + 5
        startY = startY + 10
    end

    -- 当前等级
    local text = UI.Text:create()
    text:init(UI.TEXT_1325206, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_20_105_22)
    text:centerUp(startY)
    self._compareLayout:addChild(text)
    startY = startY + text:getContentSize().height
    startY = startY + 10

    for k,v in ipairs(prayerArr[1]) do 
        local node = self:createCompareOneValue(v.title, v.attrNum)
        node:leftUp(startX, startY)
        self._compareLayout:addChild(node)

        startY = startY + oneHeight
    end

    startY = startY + 10
    lineUp = startY

    -- 下一级
    local text = UI.Text:create()
    text:init(UI.TEXT_1213816, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_20_105_22)
    text:centerUp(startY + 10)
    self._compareLayout:addChild(text)
    startY = startY + text:getContentSize().height
    startY = startY + 10

    -- prayerArr[2] = nil
    if(prayerArr[2] and #prayerArr[2] > 0) then
        for k,v in ipairs(prayerArr[2]) do 
            local node = self:createCompareOneValue(v.title, v.attrNum)
            node:leftUp(startX, startY)
            self._compareLayout:addChild(node)

            startY = startY + oneHeight
        end
    else
        local text = UI.Text:create()
        text:init(UI.TEXT_1325205, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_RED)
        text:centerUp(startY + 10)
        self._compareLayout:addChild(text)
        startY = startY + text:getContentSize().height
    end

    height = startY + 10

    --
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(width -15, 1)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(width/2, height - lineUp))
    self._compareLayout:addChild(lineUpImage, 4)

    local lineTopImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineTopImage:setContentSize(width -15, 1)
    lineTopImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineTopImage:setPosition(cc.p(width/2, height - lineTop))
    self._compareLayout:addChild(lineTopImage, 4)

    compareLayout:setSize(width, height)
    bgImage:setContentSize(width, height)
    bgImage:setPosition(cc.p(width/2, height/2))
end

function MiracleView:closePrayerInfo()
    if(self._compareLayout) then 
        self._compareLayout:removeFromParent(true)
        self._compareLayout = nil
    end
end

function MiracleView:createCompareOneValue(name, value)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(182, 20)

    local nameTxt = UI.Text:create()
    nameTxt:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    nameTxt:centerLeft(2)
    layout:addChild(nameTxt)

    local valueTxt = UI.Text:create()
    valueTxt:init(tostring(value), UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    valueTxt:centerRight(20)
    valueTxt:setFixLineWidth(76)
    valueTxt:updateView()
    layout:addChild(valueTxt)

    return layout
end

function MiracleView:moveFunction(data)
    local totalNumArr = {}
    if data.iconIds then 
        for k, v in ipairs(data.iconIds) do 
            if(totalNumArr[v] == nil) then 
                totalNumArr[v] = {key = v, value = 0, indexArr={}}
            end
            totalNumArr[v].value = totalNumArr[v].value + 1
            table.insert(totalNumArr[v].indexArr, k)
        end
    end
    -- print("totalNumArr=", totalNumArr)
    local handleArr = {}
    for k, v in pairs(totalNumArr) do 
        if(v.value >=2) then 
            table.insert(handleArr, v)
        end
    end
    
    -- 对数据进行排序
    table.sort(handleArr, function(a, b)
        if(a.value < b.value) then 
            return true
        else
            if(a.key < b.key) then 
                return true 
            end
        end

        return false
    end)

    local animationName = nil
    local animationPre = nil
    if(#handleArr == 1) then 
        animationName = ""..handleArr[1].value
        animationPre = animationName
        if(handleArr[1].value == 5 and handleArr[1].key == 6) then 
            animationName = ""..handleArr[1].value.."_special"
        end
    elseif(#handleArr == 2) then
        if(handleArr[1].value <= handleArr[2].value) then
            animationName = handleArr[1].value .. "_"..handleArr[2].value
        else
            animationName = handleArr[2].value .. "_"..handleArr[1].value
        end
        animationPre = animationName
    else
        --  
        UI.ScrollBar:createByText(UI.TEXT_1325207)
        self:endRefersh()
        Avalon.AudioManager:playSound(10072)
        return 
    end

    -- print("animationName=", animationName)
    if(animationName) then
        self.showArr = {}

        if(self.rewardColorLayer == nil) then
            local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
            colorLayer:setAnchorPoint(cc.p(0.5,0.5))
            colorLayer:setPosition(-winSize.width, -winSize.height)
            colorLayer:setContentSize(winSize.width*2, winSize.height*2)
            self.rewardLayout:addChild(colorLayer,1000)
            self.rewardColorLayer = colorLayer
            colorLayer:setVisible(false)
        end

        if(self.rewardAnimation == nil) then
            local rewardAnimation = UI.Animation:create()
            rewardAnimation:init("effect_ui_town_prayer_laba.json", "effect_ui_town_prayer_laba.atlas", 1)
            rewardAnimation:center(-120,-30)
            rewardAnimation:updateTime(0.001)
            self.rewardLayout:addChild(rewardAnimation, 10000)
            self.rewardAnimation = rewardAnimation

            -- 这里监听时间，处理后续回调
            rewardAnimation:addEventListener(UIEvent.ANIMATION_EVENT,self,function(sender, event)
                -- print("UIEvent.ANIMATION_END")
                if (event and event.eventData) then
                    if event.eventData.name ~= "hecheng" then
                        return
                    end
                else
                   return 
                end
                
                local nowDelay = 0
                if(self.showArr) then 
                    nowDelay = startMoveTime
                    local maxTime = 0
                    for k, showData in ipairs(self.showArr) do
                        local startPosition = nil
                        if(showData.startImageArr) then
                            -- print("startPosition 0-000=", #showData.startImageArr)
                            for _,image in pairs(showData.startImageArr) do 
                                if(startPosition == nil) then
                                    -- local worldPosition = image:getParent():convertToWorldSpace(cc.p(image:getPosition()))
                                    local worldPosition = self.rewardAnimation:getParent():convertToWorldSpace(cc.p(self.rewardAnimation:getPosition()))
                                    startPosition = self.rewardLayout:convertToNodeSpace(worldPosition)
                                    -- print("startPosition  www=", worldPosition, startPosition)
                                end
                                image:release()
                                image:removeFromParent()
                            end
                            showData.startImageArr = nil
                        end
                        -- print("startPosition=", startPosition, showData.endDataArr)
                        if(startPosition and showData.endDataArr and #showData.endDataArr >0) then
                            local iconDelayTime = 0
                            local iconOneDelayTime = 0.03
                            Avalon.AudioManager:playSound(10071)
                            for _,endData in ipairs(showData.endDataArr) do 
                                -- print("end move remove start", endData.iconName, endData.addExp)
                                iconDelayTime = 0.5
                                local maxNum = endData.addExp
                                for i=1,maxNum,1 do 
                                    self:handleDelay(self, iconDelayTime, function()
                                        local iconImage = cc.Sprite:create()
                                        iconImage:setSpriteFrame(endData.iconName)
                                        iconImage:setAnchorPoint(cc.p(0.5, 0.5))
                                        iconImage:setScale(0.2)
                                        iconImage:setPosition(startPosition.x, startPosition.y)
                                        self.rewardLayout:addChild(iconImage, 100)

                                        local bezierConfig = {}
                                        local minX = 2
                                        local maxX = 50


                                        local control = cc.p((startPosition.x + endData.position.x)/2 + (- startPosition.x + endData.position.x)*1/5 - math.random(minX, maxX),(startPosition.y + endData.position.y)/2 + math.random(2, 30))
                                        table.insert(bezierConfig, control)
                                        table.insert(bezierConfig, cc.p(control.x - 1,control.y - 1))
                                        table.insert(bezierConfig, endData.position)
                                        local moveAction = cc.BezierTo:create(startMoveTime, bezierConfig)

                                        iconImage:runAction(cc.Sequence:create(cc.Spawn:create(moveAction, cc.Sequence:create(cc.ScaleTo:create(startMoveTime*3/4,0.55),cc.ScaleTo:create(startMoveTime/4,0.2))), cc.CallFunc:create(function()
                                            -- print("end move remove")
                                            iconImage:runAction(cc.RemoveSelf:create())
                                        end)))
                                    end)
                                    iconDelayTime = iconDelayTime + iconOneDelayTime
                                end
                                if(maxTime < iconDelayTime) then 
                                    maxTime = iconDelayTime
                                end
                            end
                            self.rewardColorLayer:setVisible(false)
                        else
                            nowDelay = 0.01
                        end
                    end
                    nowDelay = nowDelay + maxTime
                end
                -- print("nowDelay=", nowDelay)
                local time = nowDelay - startMoveTime
                if time <= 0 then 
                    time = 0.01
                end
                self:handleDelay(self, time, function()
                    self.rewardAnimation:setAnimation("setup", false)
                    
                end)
                self:handleDelay(self, time + 0.2, function()
                    self.rewardAnimation:setVisible(false)
                end)

                self:handleDelay(self, nowDelay, function()
                    self:endRefersh()
                end)
            end)
        end
        self.rewardAnimation:setToSetupPose()
        self.rewardAnimation:setAnimation(animationName, false)
        self.rewardAnimation:addAnimation("ball", true)
        self.rewardAnimation:updateTime(0.001)
        self.rewardAnimation:setVisible(true)
        self.rewardColorLayer:setVisible(true)

        -- print("setAnimation ", animationName)
        if(#handleArr and #handleArr > 0) then 
            if(#handleArr == 1) then 
                local showData = self:handleOneShowData(handleArr[1], true, 1, animationPre, data)
                table.insert(self.showArr, showData)
            elseif(#handleArr == 2) then
                local showOneData = self:handleOneShowData(handleArr[1], false, 1, animationPre, data)
                local showTwoData = self:handleOneShowData(handleArr[2], false, 2, animationPre, data)
                table.insert(self.showArr, showOneData)
                table.insert(self.showArr, showTwoData)
            end
            self.rewardAnimation:setTimeScale(0)

            local fristCallBack = false
            local startCallBack = function()
                if(fristCallBack == false) then
                    self.rewardAnimation:setTimeScale(1)
                    Avalon.AudioManager:playSound(10070)

                    fristCallBack = true
                    -- 把图标绑定到动画插槽里面去
                    for k, showData in ipairs(self.showArr) do 
                        for _,image in ipairs(showData.startImageArr) do 
                            image:removeFromParent(false)
                            image:setPosition(0,0)
                            -- print("remove and add to animation=", showData.slotNameArr[_], image)
                            self.rewardAnimation:addComponent(showData.slotNameArr[_], image)
                        end
                    end
                end
            end

            -- 创建图标飞的过程
            for k, showData in ipairs(self.showArr) do 
                showData.startImageArr = {}
                for _,position in ipairs(showData.positionArr) do 
                    local iconImage = cc.Sprite:create()
                    iconImage:setSpriteFrame(showData.iconName)
                    iconImage:setAnchorPoint(cc.p(0.5, 0.5))
                    iconImage:retain()
                    iconImage:setPosition(position.x - iconImage:getContentSize().width/2, position.y - iconImage:getContentSize().height/2)
                    self.rewardLayout:addChild(iconImage, 1000)

                    local slotNode = self.rewardAnimation:getNodeForSlot(showData.slotNameArr[_])
                    if(slotNode) then
                        local worldPosition = slotNode:getParent():convertToWorldSpace(cc.p(slotNode:getPosition()))
                        local endPosition = self.rewardLayout:convertToNodeSpace(worldPosition)

                        -- print("start move data=", position, endPosition)
                        iconImage:setPosition(position.x, position.y)
                        iconImage:runAction(cc.Sequence:create(cc.MoveTo:create(startMoveTime, endPosition), cc.CallFunc:create(startCallBack)))
                        table.insert(showData.startImageArr, iconImage)
                    else
                        -- print("no found slotName=", showData.slotNameArr[_]) 
                    end
                end
            end
        else
            self:endRefersh()
        end
    else
        self:endRefersh()
    end
end

function MiracleView:bindModel()

end

function MiracleView:unbindModel()

end

function MiracleView:initPivotTime()
    self.moveDisArr = {}
    local startK = 20
    local speed = speedAcceleration
    local acc = speedAcceleration - 1
    for k=1,1000,1 do 
        local nowSpeed = basSpeed * speed
        if(nowSpeed < maxSpeed) then 
            table.insert(self.moveDisArr, math.floor(nowSpeed * oneDt))
            if(k<startK) then
                speed = speed * (speedAcceleration)
            else
                speed = speed * (speedAcceleration + acc*3)
            end
        else
            -- print("k=",k)
            break 
        end
    end
end

return MiracleView