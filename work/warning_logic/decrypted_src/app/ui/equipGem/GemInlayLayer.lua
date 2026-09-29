-- GemInlayLayer.lua
-- Author:zp
-- 2018年6月14日
-- Using:宝石镶嵌
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local GemInlayLayer = class("GemInlayLayer", UI.DoorWin)
UI.GemInlayLayer = GemInlayLayer
local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_gem.plist",
}

local GridType = {
    equip = 1,
    gem = 2
}

local GEM_KUANG_NUM = 5

--构造函数(必备)
function GemInlayLayer:ctor(spriteID)
    --窗口大小
    GemInlayLayer.super.ctor(
    self,UIType.EQUIP_GEM_INLAY,
    COM_RES_LIST,
    leftSize.width,    
    winSize.height
    )
    self.spriteID = spriteID
    self.mGoodsData = nil;          --装备
    self.mGoodsGrid = nil;          --装备框
    self.holeArr = {}               -- 插槽数据
    self.holeGoodsGridArr = {}      -- 插槽里面的物品列表

    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function GemInlayLayer:dtor()
    GemInlayLayer.super.dtor(self)
    self.mMaterialGoodsGrid = {}
    self:unRegisterListener()
end

-- 初始化(必备)
function GemInlayLayer:init()
    GemInlayLayer.super.init(self)
end

function GemInlayLayer:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    -- local _usedType2 = {}
    -- _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    -- _usedType2.type = 0
    -- table.insert(usedTypeList,_usedType2)

    return usedTypeList
end

function GemInlayLayer:getChoiceGemStone()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    _usedType2.type = 0
    local master = GameDataManager:getInstance():getMaster()
    if master then
        _usedType2.heroLevel = master:getLevel()
        _usedType2.needCheckEquiped = true
    end
    table.insert(usedTypeList,_usedType2)

    return usedTypeList
end

-- 模版函数：初始化组建的视图(必备)
function GemInlayLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:leftBottom(-winSize.width, (winSize.height - leftSize.height) / 2)
    self:addChild(self.leftLayer, 3)
    --self.leftLayer:setTouchEnable(true)
    
    --背景
    local picBg = UI.Image:create()
    picBg:init("ui_gem_bg.png")
    picBg:centerBottom(0)
    self.leftLayer:addChild(picBg)

    -- 底部背景
    local bottomBg = UI.Image:create()
    bottomBg:init("ui_gem_mosaic.png")
    bottomBg:centerBottom(0)
    picBg:addChild(bottomBg)

    local upOffsetY = 147 + 8

    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(picBg:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    picBg:addChild(shadown)

    local round = UI.Image:create()
    round:init("ui_gem_round.png")
    round:leftUp(picBg:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    picBg:addChild(round)

    -- 放物品的底板
    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_gem_di_inlay.json", "effect_ui_town_gem_di_inlay.atlas")
    inlayAnimation:centerUp(upOffsetY)
    picBg:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("hint_begin_colour", false)
    inlayAnimation:updateTime(0)
    inlayAnimation:setTimeScale(0)

    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    kuangAnimation:setTimeScale(0)
    self._inlayAnimation:addComponent("gem_kuang_da", kuangAnimation, true)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)

    -- 添加宝石镶嵌框
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center()
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid.state = 1
    self._kuangAnimation:addComponent("gem_kuang_da", self.mGoodsGrid, true)

    self:initHole(picBg)
    self:refreshHole()

    local userType = self:getInitUseType()

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(userType, true, false)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
            -- UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
            -- UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP
        }
    )
    bagList:setShowBagTagExt(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )
    
    bagList:init(self._spriteID, GameBagUIType.NORMAL, 3)
    bagList._bagGridList.haveGemStoneEquipArr = nil
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    self:addChild(bagList,2)
    bagList:setUseLock(true)
    self._runTime = 0.2
    local bagListW, bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW, (winSize.height - bagListH) / 2)


    self._inlayAnimation:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
            if(event and event.eventData 
                and event.eventData.name == "event_inlay_success_kuang_colour" 
                or event.eventData.name == "event_inlay_success_kuang_normal") then
                self._kuangAnimation.successAnimation:setAnimation("success_yellow", false)
            end
        end)
    self._bagGridList:changeBagDefaultIndex(self._bagGridList:getEquipBagIndex())

end

function GemInlayLayer:initHole(picBg)
    local this = self
    -- body
    for i=1,GEM_KUANG_NUM do 
        -- 创建一个插槽对象
        -- 背景
        local kuangBg = UI.Image:create()
        if(i == 1) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(90, 265)
        elseif (i==2) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(179, 265)
        elseif(i==3) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(90, 183)
            -- kuangBg:centerBottom(183)
        elseif(i==4) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(179, 183)
            -- kuangBg:centerBottom(183)
        elseif(i==5) then 
            kuangBg:init("ui_gem_box_colorful.png")
            kuangBg:centerBottom(118 - kuangBg:getContentSize().height/2)
        end
        picBg:addChild(kuangBg)

        local iconBg = UI.Image:create()
        iconBg:init("ui_gem_unlock_02.png")
        iconBg:center()
        kuangBg:addChild(iconBg)

        -- 图标
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init()
        goodsGrid:center()
        goodsGrid:hide()
        goodsGrid:hideCountLabel()
        goodsGrid:hideNewIcon()
        goodsGrid:setTouchEnable(true)
        goodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
        goodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
        goodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))

        goodsGrid:showInfoArea();
        goodsGrid:hideBG()
        kuangBg:addChild(goodsGrid, 100)
        goodsGrid:center()
        --goodsGrid:hideRare()
        -- goodsGrid:setScale(0.7)
        goodsGrid.state = 2
        

        local baoshiKuang = UI.Animation:create()
        if(i == GEM_KUANG_NUM) then 
            baoshiKuang:init("effect_ui_town_gem_kuang_inlay_colour.json", "effect_ui_town_gem_kuang_inlay_colour.atlas")
        else
            baoshiKuang:init("effect_ui_town_gem_kuang_inlay_normal.json", "effect_ui_town_gem_kuang_inlay_normal.atlas")
        end
        baoshiKuang:center()
        kuangBg:addChild(baoshiKuang, 5)

        table.insert(self.holeGoodsGridArr, goodsGrid)
        table.insert(self.holeArr, kuangBg)

        kuangBg.iconBg = iconBg
        kuangBg.goodsGrid = goodsGrid
        kuangBg.baoshiKuang = baoshiKuang
        kuangBg.choiceAnimation = choiceAnimation

        -- 
        kuangBg:setTouchEnable(true)
        kuangBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
            -- 处理打孔解锁的处理
            -- print("kuangBg._waitingUnlock",kuangBg._waitingUnlockIndex, kuangBg._notUnlock)
            if(kuangBg._waitingUnlock) then 

                self:initDigSlot(kuangBg, kuangBg._waitingUnlockIndex)
            elseif kuangBg._notUnlock then
                -- print("kuangBg._notUnlock",kuangBg._notUnlock)
                -- 提示当前装备无法解锁该孔位
                UI.ScrollBar:createByTextID(1113942)
            end
        end)

        -- 实现一个更新的方法
        function kuangBg:refreshHole(holeData)
            self._holeData = holeData
            if(holeData)then
                self.goodsGrid.index = holeData:getIndex()
            end
            if(self.goodsGrid) then 
                self.goodsGrid:center()
                local gemStoneData = clone(holeData:getGemStoneData())
                if(gemStoneData) then 
                    self.goodsGrid:setVisible(true)
                    gemStoneData.canUseState = true
                    self.goodsGrid:setData(gemStoneData)
                    self.goodsGrid:updateView()
                    self.goodsGrid:hideNewIcon()
                    if self.goodsGrid.gemStoneEquipImg then
                        self.goodsGrid.gemStoneEquipImg:hide()
                    end
                else 
                    self.goodsGrid:setVisible(false)
                end

                -- 刷新背景框
                local iconBgName = "ui_gem_triangular.png"
                if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then 
                    iconBgName = "ui_gem_triangular.png"
                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Yellow) then 
                    iconBgName = "ui_gem_triangular.png"
                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Blue) then 
                    iconBgName = "ui_gem_triangular.png"
                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
                    spriteFrameName = "ui_gem_box_colorful.png"
                    iconBgName = "ui_gem_colorful.png"
                end
                -- print("dddd  spriteFrameName=", spriteFrameName)
                self.iconBg:setSpriteName(iconBgName)
                if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
                    self:centerBottom(118 - self:getContentSize().height/2)
                end
            end
        end

        function kuangBg:dragBegin()
            -- kuangBg.choiceAnimation:setVisible(true)
            -- if(self.baoshiKuang and self._holeData and self._holeData:getGemStoneData() == nil) then 
            if(self.baoshiKuang and self._holeData) then 
                self.baoshiKuang:setVisible(true)
                self.baoshiKuang:setAnimation("hint_begin", false)
                self.baoshiKuang:setAnimation("hint_idle", true)
            end
        end

        function kuangBg:dragEnd()
            -- if(self.baoshiKuang and self._holeData and self._holeData:getGemStoneData() == nil) then 
            if(self.baoshiKuang and self._holeData) then 
                self.baoshiKuang:setVisible(true)
                self.baoshiKuang:setAnimation("hint_end", false)
            end
        end

        function kuangBg:dragSuccess()
            if(self.baoshiKuang) then 
                self.baoshiKuang:setVisible(true)
                self.baoshiKuang:setAnimation("success", false)
            end
        end

        function kuangBg:showChoice()
            -- kuangBg.choiceAnimation:setVisible(true)
        end
        function kuangBg:hideChoice()
            -- kuangBg.choiceAnimation:setVisible(false)
        end
        function kuangBg:unlock()
            self.iconBg:setVisible(true)
            self._waitingUnlock = false
            self._notUnlock = false
            self._holeData = nil
            self.iconBg:setSpriteName("ui_gem_unlock_02.png")
            self.goodsGrid:setVisible(false)
            if(not tolua.isnull(self._inlayAnimation)) then 
                self._inlayAnimation:setVisible(false)
            end
        end
        function kuangBg:getHoleType()
            if(self._holeData) then 
                return self._holeData:getHoleType()
            end 

            return nil 
        end
        function kuangBg:getIndex() 
            if(self._holeData) then 
                return self._holeData:getIndex()
            end 

            return -1
        end

        function kuangBg:unlockAnimation()
            if(not tolua.isnull(self._inlayAnimation)) then 
                kuangBg._waitingUnlock = false
                self._inlayAnimation:setVisible(true)
                self._inlayAnimation:setAnimation("unlock", false)
            end
        end

        function kuangBg:waitingUnlock(index)
            self._waitingUnlockIndex = index
            self._waitingUnlock = true
            -- 添加可以解锁的表现
            self.iconBg:setSpriteName("ui_gem_unlock_02.png")
            self.iconBg:setVisible(false)
            if(not tolua.isnull(self._inlayAnimation)) then 
                self._inlayAnimation:removeFromParent()
                self._inlayAnimation = nil
            end

            if(self._inlayAnimation == nil) then 
                local inlayAnimation = UI.Animation:create()
                inlayAnimation:init("effect_ui_town_gem_unlock.json", "effect_ui_town_gem_unlock.atlas")
                inlayAnimation:center()
                self:addChild(inlayAnimation, 9)
                self._inlayAnimation = inlayAnimation

                -- 
                inlayAnimation:addEventListener(UIEvent.ANIMATION_END,self,function(sender,event)
                    if(event)then
                        if(event.animation == "unlock") then
                            if(not tolua.isnull(this)) then 
                                this:refreshHole()
                            end
                        end
                    end
                end)
            end
            self._inlayAnimation:setVisible(true)
            self._inlayAnimation:setAnimation("idle", true)
        end

        function kuangBg:notUnlock()
            self.iconBg:setSpriteName("ui_gem_x.png")
            self._notUnlock = true
        end

        function kuangBg:getHoleData() 
            
            return self._holeData
        end
    end
end

function GemInlayLayer:initDigSlot(parentNode, waitingUnlockIndex)
    if(self.mGoodsData == nil) then 
        return 
    end

    -- 计算花费是否够用
    local slotRare = ConfigManager:getDigSlotForRare(self.mGoodsData:getGoodsRare())
    if(slotRare == nil) then
        print("配置不对") 
        return
    end

    local goodsData = GoodsDataManager:createLocalGoodsData(slotRare.itemID)
    if(goodsData == nil) then 
        return  
    end

    if(not tolua.isnull(self._layout)) then 
        self._layout:close()
        self._layout = nil
    end

    local itemNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(slotRare.itemID)
    local costItemNum = slotRare.costItemNum[self.mGoodsData:getPunchNum() + 1]
    if(itemNum == nil and costItemNum == nil) then 
        return 
    end

    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(260, 264)
    self.leftLayer:addChild(layout, 4)
    layout:setTouchEnable(true)
    layout:setInterceptTouches(true)
    layout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        layout:close();
    end)

    local bottom = parentNode:getBottom() - layout:getContentSize().height/2 + 40
    if(bottom < 10) then bottom = 10 end

    layout:leftBottom(347, bottom)
    self._layout = layout

    local bg = UI.Image:create()
    bg:init("ui_gem_tips.png")
    bg:center()
    layout:addChild(bg)

    -- 已经打孔次数
    local wasDigTitle = UI.Text:create()
    wasDigTitle:init(UI.TEXT_1212061, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    wasDigTitle:rightUp(bg:getContentSize().width/2, 36)
    layout:addChild(wasDigTitle)

    local wasDigTxt = UI.Text:create()
    wasDigTxt:init(tostring(self.mGoodsData:getPunchNum()), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    wasDigTxt:leftUp(bg:getContentSize().width/2 + 4, 36)
    layout:addChild(wasDigTxt)

    -- 打孔花费
    local digUseTitle = UI.Text:create()
    digUseTitle:init(UI.TEXT_1212062, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    digUseTitle:rightUp(bg:getContentSize().width/2, 82 - digUseTitle:getContentSize().height/2)
    layout:addChild(digUseTitle)

    local useIcon = UI.Image:create()
    useIcon:init(goodsData:getSmallIconName())
    useIcon:leftUp(bg:getContentSize().width/2 + 4, 82 - useIcon:getContentSize().height/2)
    layout:addChild(useIcon)

    local digUseTxt = UI.Text:create()
    digUseTxt:init(tostring(costItemNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    digUseTxt:centerLeft(useIcon:getContentSize().width + 4)
    useIcon:addChild(digUseTxt)

    -- 文件描述
    local des = UI.Text:create()
    des:init(string.format(UI.TEXT_1212063, goodsData:getName()), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    des:centerUp(155 - des:getContentSize().height/2)
    layout:addChild(des)
    des:setWidth(195)

    local callBack = function()
        Avalon.AudioManager:playSound("1538", false)
        layout:close()
        if(itemNum >= costItemNum) then 
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            -- print("kuangBg._waitingUnlock 2", self.spriteID, self.mGoodsData, kuangBg._waitingUnlockIndex, 0)
            Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, self.mGoodsData, waitingUnlockIndex, {0}, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Punch"))
        end
    end

    -- 添加按钮
    local btnLanguage = UI.Button:create()
    btnLanguage:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
    btnLanguage:addEventListener(UIEvent.BUTTON_CLICK, self, callBack)
    btnLanguage:centerBottom(10)
    layout:addChild(btnLanguage, 10)

    -- 添加按钮文本
    local useTxt = UI.Text:create()
    useTxt:init(UI.TEXT_1212062, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useTxt:centerLeft(bg:getContentSize().width/2)
    btnLanguage:addChild(useTxt, 10)

    local useIcon = UI.Image:create()
    useIcon:init(goodsData:getSmallIconName())
    useIcon:centerLeft(bg:getContentSize().width/2 + 4)
    btnLanguage:addChild(useIcon, 10)

    local useNumTxt = UI.Text:create()
    useNumTxt:init(tostring(costItemNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useNumTxt:leftUp(useIcon:getContentSize().width + 4, 36)
    btnLanguage:addChild(useNumTxt, 10)

    local startX = btnLanguage:getContentSize().width - useTxt:getContentSize().width - useIcon:getContentSize().width - useNumTxt:getContentSize().width
    startX = (startX - 8) / 2
    useTxt:centerLeft(startX)
    startX = startX + 4 + useTxt:getContentSize().width
    useIcon:centerLeft(startX)
    startX = startX + 4 + useIcon:getContentSize().width
    useNumTxt:centerLeft(startX)

    if(itemNum >= costItemNum) then 
        btnLanguage:enable()
    else 
        useNumTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        btnLanguage:disable()
    end
end

function GemInlayLayer:refreshHole()
    for _,node in ipairs(self.holeArr) do 
        node:unlock()
    end

    if(self.mGoodsData) then 
        local holeDataArr = self.mGoodsData:getHoleDatas()
        local unlock = self.mGoodsData:getIsUnlockColorHole()
        local index = 1
        local normalIndex = 1
        local normalNum = 2
        local haveColor = false
        for _,holeData in ipairs(holeDataArr) do 
            if(index <= #self.holeArr) then 
                -- 判断是否已经解锁了
                if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
                    local holeNode = self.holeArr[GEM_KUANG_NUM]
                    if(unlock) then 
                        haveColor = true
                        if(holeNode) then
                            holeNode:setVisible(true)
                            holeNode:refreshHole(holeData)
                        end
                    end
                else 
                    self.holeArr[normalIndex]:setVisible(true)
                    self.holeArr[normalIndex]:refreshHole(holeData)
                    normalNum = normalNum + 1
                    normalIndex = normalIndex + 1
                end
            end
            index = index + 1
        end

        -- 这里如果遇到了无法解锁的那个孔就跳到下一个孔位
        local configData = ConfigManager:getEquipmentConfigByID(self.mGoodsData:getId())
        local slot4Type = configData.slot4Type[1]
        if not slot4Type or slot4Type ~= 1  then--(self.mGoodsData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_DARKRED) then 
            self.holeArr[GEM_KUANG_NUM - 1]:notUnlock()
            print("RARE_DARKRED", normalNum, normalIndex)
            if(normalIndex == GEM_KUANG_NUM - 1) then
                normalNum = normalNum + 1
                normalIndex = normalIndex + 1
            end
        end

        -- 处理解锁
        if(normalIndex < GEM_KUANG_NUM) then 
            self.holeArr[normalIndex]:waitingUnlock(normalNum)
        end

        if(not haveColor) then
            -- 判断是否某些类型装备
            local equipmentType = self.mGoodsData:getEquipmentType()
            if(equipmentType == PublicDefine.EQUIPMENT_TYPE.Amulet
                or equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon
                or equipmentType == PublicDefine.EQUIPMENT_TYPE.Ring) then 
                local holeNode = self.holeArr[GEM_KUANG_NUM]
                if(holeNode) then 
                    holeNode:waitingUnlock(1)
                end
            end
        end
    end
end

function GemInlayLayer:resetSpineAnimation()
    
end

-- 准备放入动画
function GemInlayLayer:runReadyAnimtion(type, gemStoneType, goodsGrid)
    if GridType.equip == type then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", true)
        self._kuangAnimation:setTimeScale(1)
    else
        local index = 1
        -- 判断是拖动到那个插槽了
        for _, holeNode in ipairs(self.holeArr) do
            if (holeNode:getHoleType() == gemStoneType and (goodsGrid == nil or goodsGrid == holeNode.goodsGrid)) then
                holeNode:dragBegin()
            end
        end
        self._inlayAnimation:setTimeScale(1)
        if (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Red) then
            self._inlayAnimation:setAnimation("hint_begin_normal", false)
            self._inlayAnimation:addAnimation("hint_idle_normal", true)
        elseif (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Colourful) then
            self._inlayAnimation:setAnimation("hint_begin_colour", false)
            self._inlayAnimation:addAnimation("hint_idle_colour", true)
        end
    end
end

-- 取消准备放入动画
function GemInlayLayer:runCancelReadyAnimtion(type, gemStoneType, goodsGrid)
    if GridType.equip == type then
        self._kuangAnimation:setAnimation("hint_end_yellow", false)
        self._kuangAnimation:setTimeScale(1)
    else
        if(gemStoneType == PublicDefine.GemStoneType.GemStoneType_Red) then 
            self._inlayAnimation:setAnimation("hint_end_normal", false)
        elseif (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
            self._inlayAnimation:setAnimation("hint_end_colour", false)
        end

        for _,holeNode in ipairs(self.holeArr) do 
            if(holeNode:getHoleType() == gemStoneType and (goodsGrid == nil or goodsGrid == holeNode.goodsGrid)) then 
                holeNode:dragEnd()
            end 
        end
    end
end

-- 放入动画
function GemInlayLayer:runPutAnimtion(type, gemStoneType, goodsGrid)
    if GridType.equip == type then
        self._kuangAnimation:setAnimation("enchase_yellow", false)
        self._kuangAnimation:setTimeScale(1)
    else
        -- 判断是拖动到那个插槽了
        for _, holeNode in ipairs(self.holeArr) do
            if (holeNode:getHoleType() == gemStoneType and (goodsGrid == nil or goodsGrid == holeNode.goodsGrid)) then
                holeNode:dragEnd()
            end
        end

        if (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Red) then
            self._inlayAnimation:setAnimation("hint_end_normal", false)
        elseif (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Colourful) then
            self._inlayAnimation:setAnimation("hint_end_colour", false)
        end
    end
end

function GemInlayLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    -- 根据拖动的类型来判断如何处理后续逻辑
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
        self:runReadyAnimtion(GridType.equip)
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
        if self.mGoodsData ~= nil then 
            self:runReadyAnimtion(GridType.gem, goodsData:getGemStoneType())
        end 
    end
end

function GemInlayLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    if not isInBag then
        -- 根据拖动的类型来判断如何处理后续逻辑
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end

            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            self._bagGridList:setUsedType(self:getChoiceGemStone())
            self._bagGridList:refreshView()

            self.mGoodsGrid:setData(self.mGoodsData)
            self.mGoodsGrid:setVisible(true)
            self.mGoodsGrid:show()
            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()
            self.mGoodsGrid:updateView()

            -- 切换背包的tab
            self._bagGridList:changeBagIndex(self._bagGridList:getGemStoneBagIndex())

            self:refreshHole()
            self:runPutAnimtion(GridType.equip)
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111282))
        elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
            if self.mGoodsData == nil then 
                -- 提示先拖动要镶嵌的装备
                UI.ScrollBar:createByText(UI.TEXT_1201010)
            else 
                
                self:runPutAnimtion(GridType.gem, goodsData:getGemStoneType())

                for _,holeNode in ipairs(self.holeArr) do 
                    holeNode:hideChoice()

                    local holeData = holeNode:getHoleData() 
                    local t = holeNode:convertToWorldSpace(cc.p(0,0))
                    local _rect = cc.rect(t.x,t.y,holeNode:getContentSize().width,holeNode:getContentSize().height)
                    if cc.rectContainsPoint(_rect, touchPosition) then
                        if holeNode:getHoleType() == goodsData:getGemStoneType() then
                            if self:alreadyInlaySameColorGem(goodsData, holeNode) then
                                UI.ScrollBar:createByText(UI.TEXT_1212034)
                                return
                            end
                            if RoleBehaviorManager:equipGemTownNpcCheck() then
                                printWarn(" been blocked when using gem npc inlay function !")
                                break
                            end
                            
                            

                            -- 在替换宝石的时候，需要判断是否有空格子
                            local targetHoleData = holeNode:getHoleData()
                            if targetHoleData then
                                local targetHoleGemData = targetHoleData:getGemStoneData()
                                if(targetHoleGemData) then
                                    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
                                    if(freePacketNum <= 0) then
                                        UI.ScrollBar:createByTextID(1110793)
                                        return 
                                    end

                                    if targetHoleGemData.viceGemStoneID and targetHoleGemData.viceGemStoneID ~= 0 then
                                        UI.ScrollBar:createByText(UI.TEXT_227911)
                                        return
                                    end
                                end
                            end
                            self:sendInlayMsg(self.mGoodsData, holeNode:getIndex(), {goodsData:getGoodsID(),goodsData:getBagType()})
                        else 
                            if(holeData) then 
                                -- 符文颜色不匹配
                                local textStr = UI.TEXT_1201013
                                local formatStr = UI.TEXT_1201014
                                if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then 
                                    formatStr = UI.TEXT_1201014
                                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Yellow) then 
                                    formatStr = UI.TEXT_1201015
                                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Blue) then 
                                    formatStr = UI.TEXT_1201016
                                elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
                                    formatStr = UI.TEXT_1201017
                                end

                                UI.ScrollBar:createByText(string.format(textStr, formatStr))
                            end
                        end
                        return
                    end
                end
                if self:alreadyInlaySameColorGem(goodsData, nil) then
                    UI.ScrollBar:createByText(UI.TEXT_1212034)
                    return
                end

                for k, holeNode in ipairs(self.holeArr) do 
                    if holeNode:getHoleType() == goodsData:getGemStoneType() then
                        if holeNode:getHoleData() and holeNode:getHoleData().gemStoneID ~= 0 then
                        else
                            self:sendInlayMsg(self.mGoodsData, holeNode:getIndex(), {goodsData:getGoodsID(),goodsData:getBagType()})
                            return
                        end
                    end
                end
            end
        end
    else 
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
            self:runCancelReadyAnimtion(GridType.equip)
        elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
            if self.mGoodsData ~= nil then 
                self:runCancelReadyAnimtion(GridType.gem, goodsData:getGemStoneType())
            end 
        end
    end
end 

function GemInlayLayer:alreadyInlaySameColorGem(data, targetHole)
    local inlay = false
    if targetHole then
        local targetHoleData = targetHole:getHoleData()
        if targetHoleData then
            local targetHoleGemData = targetHoleData:getGemStoneData()
            if targetHoleGemData then
                print("data:getGemStoneType() 1 = ", targetHoleGemData.gemstoneType, data.gemstoneType)
            end
            if targetHoleGemData and targetHoleGemData.gemstoneType == data.gemstoneType then
                return inlay
            end
        end
    end
    for _, holeNode in ipairs(self.holeArr) do
        local holeData = holeNode:getHoleData()
        if holeData then
            local holeGemData = holeData:getGemStoneData()
            if holeGemData and holeGemData.gemstoneType == data.gemstoneType then
                inlay = true
                break;
            end

        end
    end
    return inlay
end

function GemInlayLayer:sendInlayMsg(equipmentGoodsData, equipmentHoleIndex, gemstoneTempID)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Avalon.AudioManager:playSound("1530")
    Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, equipmentGoodsData, equipmentHoleIndex, gemstoneTempID, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Inlaid"))
end

-- 模版函数：更新组建的视图(必备)
function GemInlayLayer:onUpdateView()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.STRENGTHEN)
    if saveData then
        self:reductionInfo(saveData)
    end
    self:setDoorNode(self.leftLayer, self._bagGridList)
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281)) 
end


--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function GemInlayLayer:updateGridState(isCanUse, isDelay)
end

--刷新改造按钮
function GemInlayLayer:updateBtnState()
    
end

function GemInlayLayer:onTouchBeganByGoodsGrid(grid,touchPosition)
    local goodsData = grid:getData()
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        self:runReadyAnimtion(GridType.equip)
    else
        self:runReadyAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
    end
    return true
end


function GemInlayLayer:onTouchEndedByGoodsGrid(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if(self.mGoodsData and self.holeArr) then
        local holeDataArr = self.mGoodsData:getUnLockHoleDatas()
        local index = 1
        for _,holeData in ipairs(holeDataArr) do 
            if(index <= #self.holeArr) then 
                local holeNode = self.holeArr[index]
                if(holeNode) then
                    holeNode:hideChoice()
                end
            end 
        end
    end

    local goodsData = grid:getData()
    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        -- 拖出去了
        if grid.state == 1 then
            self.mGoodsData._changeNum = 0
            self._bagGridList:setUsedType(self:getInitUseType())
            self._bagGridList:refreshView()
            self._bagGridList:changeBagIndex(self._bagGridList:getEquipBagIndex())
            self.mGoodsData = nil
            self:refreshHole()
            self.mGoodsGrid:center()
            self.mGoodsGrid:setVisible(false)
            self:runCancelReadyAnimtion(GridType.equip);
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281))
        elseif grid.state == 2 then
            local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()

            if(freePacketNum <= 0) then
                UI.ScrollBar:createByTextID(1110793)
            elseif goodsData and goodsData.viceGemStoneID and goodsData.viceGemStoneID ~= 0 then
                -- UI.ScrollBar:createByText(UI.TEXT_227911)
                UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_227913,function()
                    -- 取掉镶嵌的宝石 
                    grid:hide()
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                    Avalon.AudioManager:playSound("1530")

                    Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, self.mGoodsData, grid.index, {goodsData:getGoodsID(), PublicDefine.PACKET_TYPE.PACKET_BAG}, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Pcik"))
                    self:runCancelReadyAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
                end,function()
                    self:runPutAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
                end)

                -- if grid.state == 1 then
                --     self:runPutAnimtion(GridType.equip)
                -- elseif grid.state == 2 then
                --     self:runPutAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
                -- end
                return
            else 
                -- 取掉镶嵌的宝石 
                grid:hide()
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Avalon.AudioManager:playSound("1530")

                Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, self.mGoodsData, grid.index, {goodsData:getGoodsID(), PublicDefine.PACKET_TYPE.PACKET_BAG}, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Pcik"))
                self:runCancelReadyAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
            end 
        end
        self._bagGridList:refreshView()
    else
        if grid.state == 1 then
            self:runPutAnimtion(GridType.equip)
        elseif grid.state == 2 then
            self:runPutAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
        end
    end
end

-- 镶嵌网络回调
function GemInlayLayer:inlayCallBack(data)
    UI.WaitingLayer:hideWaiting()

    self._bagGridList:refreshView()
    if(data.result == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidResult", "EquipGemstoneInlaidResult_Succeed")) then 
        if(self.mGoodsData) then 
            if(data.optType == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Punch")) then 
                -- 播放打孔的动画
                local index = data.equipmentHoleIndex + 1
                local hole = nil
                if(index == 1) then 
                    hole = self.holeArr[GEM_KUANG_NUM]
                else 
                    hole = self.holeArr[index - 1]
                end

                if(hole) then 
                    hole:unlockAnimation()
                else 
                    self:refreshHole()
                end
            else 
                self:refreshHole()
                local animationName = nil 
                local gemAnimationName = nil
                local holeDatas = self.mGoodsData:getHoleDatas()
                local hole = self.holeArr[data.equipmentHoleIndex + 1]
                if(holeDatas and #holeDatas >= data.equipmentHoleIndex + 1) then 
                    local holeData = holeDatas[data.equipmentHoleIndex + 1] 
                    if(holeData) then 
                        if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Red) then 
                            animationName = "success_normal"
                            gemAnimationName = "begin_putong"
                            hole = self.holeArr[data.equipmentHoleIndex + 1]
                        elseif (holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then
                            animationName = "success_colour"
                            gemAnimationName = "begin_cai"
                            hole = self.holeArr[GEM_KUANG_NUM]
                        end 
                    end
                end

                if(data.optType == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType","EquipGemstoneInlaidType_Inlaid")) then 
                    print("animationName=", animationName)
                    if(animationName) then 
                        -- self._inlayAnimation:setToSetupPose()
                        self._inlayAnimation:setAnimation(animationName, false)
                    end
                    -- 添加一个宝石格子镶嵌的表现
                    if not tolua.isnull(hole) then 
                        UI.ScrollBar:createByText(UI.TEXT_1212031)
                        Avalon.AudioManager:playSound("1531")
                        hole:dragSuccess()
                    end
                else
                    UI.ScrollBar:createByText(UI.TEXT_1212032)
                end
            end
        else 
           self:refreshHole() 
        end
    else 
        self:refreshHole()
        -- 把该宝石给还回去
        GameErrorManager:showError(data.result)
    end
end

-- 注册监听事件(可选)
function GemInlayLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_INLAY, self, self.inlayCallBack)
    
end

-- 注销监听事件(可选)
function GemInlayLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_INLAY, self, self.inlayCallBack)

end