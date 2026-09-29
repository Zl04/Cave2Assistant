------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/02/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.tips.PetGemSynthesisTips"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local PetGemStoneDevelopmentView = class("PetGemStoneDevelopmentView", UI.HWBtnComponent)
local ProtobufUtil = require("utils.ProtobufUtil")

require "app.modules.petgemstonedevelopment.PetGemStoneChoiseConvertView"

-- 资源
local COM_RES_LIST = {
    "ui_town_gem.plist",
    "ui_package_pets.plist",
    "ui_town_home.plist",
    "ui_common_symbol.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

local GEM_KUANG_NUM = 4

local PageType = {
    InlayGem = 1,
    Devour = 2,
    Convert = 3,
    Evolution = 4,
    Max = 5,
}

local GridType = {
    unlock = 1,
    equip = 2,
    gem = 3,
}

function PetGemStoneDevelopmentView:ctor()
    PetGemStoneDevelopmentView.super.ctor(
    	self,
    	UI.Type.PET_GEM_STONE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.closeIndex = 0
    self._pageTable = {}

    self.mGoodsData = nil;          --装备 或者宝石
    self.mGoodsGrid = nil;          --装备框
    self.holeArr = {}               -- 插槽数据
    self.holeGoodsGridArr = {}      -- 插槽里面的物品列表

    self._pageType = PageType.InlayGem
    self._isSelect = false
    self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE

    -- 是否有没有选择的魂玉转换
    self.isNotChoseStone = false
    self.choseStoneArr = {}
end

function PetGemStoneDevelopmentView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.petgemstonedevelopment", "PetGemStoneDevelopment", false)
    PetGemStoneDevelopmentView.super.init(self, ... )
end

function PetGemStoneDevelopmentView:dtor()
    PetGemStoneDevelopmentView.super.dtor(self)
    self:unbindModel()

    if self.mGoodsData and self.mGoodsData._changeNum < 0 then
        self.mGoodsData._changeNum = 0
    end

    reload_script_file_mvc("app.modules.petgemstonedevelopment.PetGemStoneDevelopmentView")
end

-- 模版函数：更新组建的视图(必备)
function PetGemStoneDevelopmentView:onUpdateView()
    mvc.petGemStoneDevelopmentPanel.ui:setDoorNode(self.leftLayer, self.rightLayer)-- self._bagGridList)
    -- self.ui:setDoorNode(self.leftLayer, self._bagGridList)
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281)) 
end


function PetGemStoneDevelopmentView:onInitView()

    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:leftBottom(-winSize.width, (winSize.height - leftSize.height) / 2)
    self:addChild(self.leftLayer,2)

    self.leftLayer:setTouchEnable(true)
    self.leftLayer:setInterceptTouches(false)
    self.leftLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self.closeIndex = 1
    end)

    self.rightLayer = UI.Layout:create();
    self.rightLayer:init()
    self.rightLayer:setSize(450, COM_HEIGHT)
    self.rightLayer:leftBottom(COM_WIDTH)
    self:addChild(self.rightLayer)


    --背景
    local picBg = UI.Image:create()
    picBg:init("ui_gem_bg.png")
    picBg:centerBottom(0)
    self.leftLayer:addChild(picBg)
    self.picBg = picBg

    local pageName = {
        [PageType.InlayGem] = UI.TEXT_224104,
        [PageType.Devour] = UI.TEXT_224105,
        [PageType.Convert] = UI.TEXT_1213036,
        [PageType.Evolution] = UI.TEXT_224140,
    }

    local index = 0
    for i = PageType.InlayGem, PageType.Max - 1 do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_home_retrofit_bookmark_normal.png', 'ui_home_retrofit_bookmark_normal.png', 'ui_home_retrofit_bookmark_checked.png')
        pageBtn:leftBottom(self.picBg:getContentSize().width - 38, self.picBg:getContentSize().height - 70 - index*65)
        pageBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 114, g = 109, b = 116})
        pageBtn:setText(pageName[i])
        pageBtn:setTextOffset(-8,0)
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    v:setFontColor({r = 220, g = 182, b = 80})
                else
                    v:enable()
                    v:setFontColor({r = 114, g = 109, b = 116})
                end
            end

        end)
        self.picBg:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._pageType then
            pageBtn:disable()
            pageBtn:setFontColor({r = 220, g = 182, b = 80})
        else
            pageBtn:enable()
            pageBtn:setFontColor({r = 114, g = 109, b = 116})
        end

        index = index + 1
    end

    self:updatePageView(self._pageType,true)

    -- 请求一次是否上次转换魂玉没有选择
    Net.NetPetSystem:petStoneChoseCacheRequest()

end

function PetGemStoneDevelopmentView:updatePageView(pageType, isForce)

    if (pageType == nil or pageType == self._pageType) and not isForce then
        return
    end
    
    self._pageType = pageType

    self:createLeftView()
    self:createRightView(self._defaultBagIndex)
end

function PetGemStoneDevelopmentView:initHole()
    self.holeArr = {}
    local this = self
    -- body
    for i=1,GEM_KUANG_NUM do 
        -- 创建一个插槽对象
        -- 背景
        local kuangBg = UI.Image:create()
        if(i == 1) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(90, 265 - 15)
        elseif (i==2) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(179, 265 - 15)
        elseif(i==3) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(90, 183 - 15)
            -- kuangBg:centerBottom(183)
        elseif(i==4) then 
            kuangBg:init("ui_gem_box_triangular.png")
            kuangBg:leftBottom(179, 183 - 15)
        end
        self.leftNode:addChild(kuangBg,20)

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
        goodsGrid.state = 2
        goodsGrid.posIndex = i
        

        local baoshiKuang = UI.Animation:create()
        baoshiKuang:init("effect_ui_town_gem_kuang_inlay_normal.json", "effect_ui_town_gem_kuang_inlay_normal.atlas")
        baoshiKuang:center()
        kuangBg:addChild(baoshiKuang, 5)
        kuangBg.posIndex = i

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
            end
        end)

        -- 实现一个更新的方法
        function kuangBg:refreshHole(holeData)
            self._holeData = holeData
            if(self.goodsGrid) then 
                self.goodsGrid:center()
                
                holeData.entityID = 0
                local gemStoneData = mvc.petGemStoneDevelopmentModel:createPetStoneData(holeData)
                if(gemStoneData) then 
                    self.goodsGrid:setVisible(true)
                    self.goodsGrid:setData(gemStoneData)
                    self.goodsGrid:updateView()
                    self.goodsGrid:hideNewIcon()
                end

                -- -- 刷新背景框
                local iconBgName = "ui_gem_petsgem.png"
                self.iconBg:setSpriteName(iconBgName)
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

        function kuangBg:getHoleData() 
            
            return self._holeData
        end
    end

    local desTxt = UI.Text:create()
    desTxt:init(UI.TEXT_224109, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 35,g = 24,b = 14})
    desTxt:centerBottom(140)
    self.leftNode:addChild(desTxt, 10)
end

function PetGemStoneDevelopmentView:refreshHole(showAnimationType,slotIndex)

    if showAnimationType == GridType.unlock then
        if self.mGoodsData then 
            local slotData = self.mGoodsData:getSlotsData() or {}
            local showIndex = #slotData
            self.holeArr[showIndex]:unlockAnimation()
            return
        end
    end

    for _,node in ipairs(self.holeArr) do 
        node:unlock()
    end

    if self.mGoodsData then 
        local grid = nil
        local slotData = self.mGoodsData:getSlotsData() or {}

        for i=1,GEM_KUANG_NUM do
            local sData = slotData[i]
            if sData then
                --解锁了
                self.holeArr[i]:setVisible(true)
                self.holeArr[i]:refreshHole(sData)
            else
                --可解锁
                if i == #slotData + 1 then
                    self.holeArr[i]:waitingUnlock(i)
                end
            end

            if slotIndex == i then
                grid = self.holeGoodsGridArr[i]
            end
        end

        if slotIndex ~= nil then
            self:runCancelReadyAnimtion(GridType.gem)
        end

        if showAnimationType == GridType.equip or showAnimationType == GridType.gem then
            self:runPutAnimtion(showAnimationType,nil,slotIndex)
        end
    end

    
end

function PetGemStoneDevelopmentView:updateGoodsData(equipmentData)
    self.mGoodsData = equipmentData

    if self.mGoodsGrid then
        self.mGoodsGrid:setData(self.mGoodsData)
    end
end

function PetGemStoneDevelopmentView:initDigSlot(parentNode, waitingUnlockIndex)
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
    local costItemNumPet = slotRare.costItemNumPet[waitingUnlockIndex]
    if(itemNum == nil and costItemNumPet == nil) then 
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
    wasDigTxt:init(tostring(waitingUnlockIndex - 1), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
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
    digUseTxt:init(tostring(costItemNumPet), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
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
        if(itemNum >= costItemNumPet) then 
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

            -- self.goodsGrid
            -- print("  self.goodsGrid===== ",self.mGoodsData)
            if self.mGoodsData then
                local equipId = self.mGoodsData:getEntityID()
                local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(equipId)
                local petId = 0
                if petRoleData then
                    petId = petRoleData:getPK()
                    -- petId = petRoleData:getPetInstId()
                end
                Net.NetPetSystem:digEquipmentSlot(tonumber(petId),equipId)
            end

            -- 
            -- Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, self.mGoodsData, waitingUnlockIndex, {0}, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Punch"))
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
    useNumTxt:init(tostring(costItemNumPet), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useNumTxt:leftUp(useIcon:getContentSize().width + 4, 36)
    btnLanguage:addChild(useNumTxt, 10)

    local startX = btnLanguage:getContentSize().width - useTxt:getContentSize().width - useIcon:getContentSize().width - useNumTxt:getContentSize().width
    startX = (startX - 8) / 2
    useTxt:centerLeft(startX)
    startX = startX + 4 + useTxt:getContentSize().width
    useIcon:centerLeft(startX)
    startX = startX + 4 + useIcon:getContentSize().width
    useNumTxt:centerLeft(startX)

    if(itemNum >= costItemNumPet) then 
        btnLanguage:enable()
    else 
        useNumTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        btnLanguage:disable()
    end
end

function PetGemStoneDevelopmentView:createLeftView()

    if self.mGoodsData then
        self.mGoodsData._changeNum = 0
    end

    self.mGoodsData = nil
    self.holeArr = {}
    if self.leftNode then
        self.leftNode:removeFromParent()
        self.leftNode = nil
    end
    self.leftNode = UI.Layout:create();
    self.leftNode:init()
    self.leftNode:setSize(leftSize.width, leftSize.height)
    self.leftNode:leftBottom(0,0)
    self.picBg:addChild(self.leftNode)

    if self._pageType == PageType.InlayGem then
        --镶嵌模块
        self:refreshInlayModule()

    elseif self._pageType == PageType.Devour then
        -- 吞噬模块
        self:refreshDevourModule()
    elseif self._pageType == PageType.Convert then
        -- 转换模块
        self:refreshConvertModule()
    elseif self._pageType == PageType.Evolution then
        -- 进化模块
        self:refreshEvolutionModule()
    end
    
end

function PetGemStoneDevelopmentView:refreshInlayModule()

    local upOffsetY = 155

    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    self.leftNode:addChild(shadown)

    local round = UI.Image:create()
    round:init("ui_gem_round.png")
    round:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    self.leftNode:addChild(round)

    
    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_pet_equipment.json", "effect_ui_town_pet_equipment.atlas")
    inlayAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("switch_begin_xiangqian", false, 0)
    inlayAnimation:addAnimation("switch_idle_xiangqian", false, 0)
    -- inlayAnimation:updateTime(0)
    self._inlayAnimation:setName("refreshInlayAnimation")

    inlayAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "switch_begin_xiangqian") then
            self:initHole()
        end
    end)

    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(kuangAnimation, 9)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_inlay_colour.json", "effect_ui_town_gem_kuang_inlay_colour.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)

    local kuangMoveAnimation = UI.Animation:create()
    kuangMoveAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    kuangMoveAnimation:center()
    kuangMoveAnimation:setAnimation("begin", false)
    kuangAnimation.kuangMoveAnimation = kuangMoveAnimation
    kuangAnimation:addChild(kuangMoveAnimation, 11)
    
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

end

function PetGemStoneDevelopmentView:onTouchBeganByGoodsGrid(grid,touchPosition)
    local goodsData = grid:getData()
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        self:runReadyAnimtion(GridType.equip)
    else
        self:runReadyAnimtion(GridType.gem, nil, grid)
    end
    return true
end

function PetGemStoneDevelopmentView:onTouchEndedByGoodsGrid(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        -- 拖出去了
        if grid.state == 1 then

            if self._pageType == PageType.InlayGem then
                self.mGoodsData._changeNum = 0
                self._bagGridList:setUsedType(self:getInitUseType())
                self._bagGridList:refreshView()

                local bIndex = nil
                for i = 1,3 do
                    local pData = MasterDataManager:getFightPetBySiteId(i - 1)
                    if pData and self.mGoodsData then
                        local petData = MasterDataManager:getBagPetById(pData:getPetInstId())
                        if petData then
                            local wearEquipmentArr = petData:getWearEquipmentArr() or {}
                
                            for k,v in pairs(wearEquipmentArr) do
                                if v:getEntityID() == self.mGoodsData:getEntityID() then
                                    bIndex = i
                                    break
                                end
                            end
                        end
                    end

                    if bIndex then
                        break
                    end
                end

                if bIndex == 1 then
                    self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_ONE)
                elseif bIndex == 2 then
                    self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_TWO)
                elseif bIndex == 3 then
                    self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_THREE)
                else
                    self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
                end


                self.mGoodsData = nil
                self:refreshHole()
                self.mGoodsGrid:center()
                self.mGoodsGrid:setVisible(false)
                self:runCancelReadyAnimtion(GridType.equip);
            elseif self._pageType == PageType.Devour then
                self.mGoodsData._changeNum = 0
                self._bagGridList:setUsedType(self:getInitUseType())
                self._bagGridList:refreshView()
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
                self.mGoodsData = nil
                self.mGoodsGrid:center()
                self.mGoodsGrid:setVisible(false)
                self:runCancelReadyAnimtion(GridType.equip);

                self:refreshDevourModule()
            elseif self._pageType == PageType.Convert then
                self.mGoodsData._changeNum = 0
                self._bagGridList:setUsedType(self:getInitUseType())
                self._bagGridList:refreshView()
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
                self.mGoodsData = nil
                self.mGoodsGrid:center()
                self.mGoodsGrid:setVisible(false)
                self:runCancelReadyAnimtion(GridType.equip);

                self:refreshConvertModule()
            elseif self._pageType == PageType.Evolution then
                self.mGoodsData._changeNum = 0
                self._bagGridList:setUsedType(self:getInitUseType())
                self._bagGridList:refreshView()
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
                self.mGoodsData = nil
                self.mGoodsGrid:center()
                self.mGoodsGrid:setVisible(false)
                self:runCancelReadyAnimtion(GridType.equip);
                
                self:refreshEvolutionModule()
            end

            -- GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281))
        elseif grid.state == 2 then

            local freePacketNum = GameDataManager:getInstance():getFreePetGemStoneBoxNum()
            if(freePacketNum <= 0) then
                UI.ScrollBar:createByTextID(1110793)
            else
                -- 取掉镶嵌的宝石
                grid:hide()
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Avalon.AudioManager:playSound("1530")

                local equipId = self.mGoodsData:getEntityID()
                local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(equipId)
                local petId = 0
                if petRoleData then
                    petId = petRoleData:getPK()
                end

                local position = {}
                position.slotIndex = grid.posIndex and (grid.posIndex - 1) or 0
                position.gemId = goodsData:getEntityID()
                position.petId = petId
                position.equipId = equipId

                Net.NetPetSystem:takeDownEquipmentGemStone(position)

                self:runCancelReadyAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
            end
            -- local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
            -- if(freePacketNum <= 0) then
            --     UI.ScrollBar:createByTextID(1110793)
            -- else 
            --     -- 取掉镶嵌的宝石 
            --     grid:hide()
            --     UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            --     Avalon.AudioManager:playSound("1530")

            --     Net.NetNPCSystem:sendGemStoneInlay(self.spriteID, self.mGoodsData, grid.index, {goodsData:getGoodsID(), PublicDefine.PACKET_TYPE.PACKET_BAG}, ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Pcik"))
            --     self:runCancelReadyAnimtion(GridType.gem, goodsData:getGemStoneType(), grid)
            -- end 
        end
        self._bagGridList:refreshView()
        self:cancelDevour()
    else
        if grid.state == 1 then
            self:runPutAnimtion(GridType.equip)
        elseif grid.state == 2 then
            self:runPutAnimtion(GridType.gem,nil, grid)
        end
    end
end

-- 取消准备放入动画
function PetGemStoneDevelopmentView:runCancelReadyAnimtion(gType, gemStoneType, goodsGrid)
    if gType == GridType.equip then
        self._kuangAnimation:setAnimation("hint_idle_blue", false)
        self._kuangAnimation:setTimeScale(1)

        self._kuangAnimation.kuangMoveAnimation:setAnimation("end", false)
        self._kuangAnimation.kuangMoveAnimation:setTimeScale(1)
    else
        for _,holeNode in ipairs(self.holeArr) do 
            holeNode:dragEnd()
        end
        self._kuangAnimation.kuangMoveAnimation:setAnimation("end", false)
        self._kuangAnimation.kuangMoveAnimation:setTimeScale(1)

    end
end

-- 准备放入动画
function PetGemStoneDevelopmentView:runReadyAnimtion(gType, gemStoneType, goodsGrid)
    if gType == GridType.equip then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", false)
        self._kuangAnimation:setTimeScale(1)
    else
        -- local index = 1
        -- 判断是拖动到那个插槽了
        for _, holeNode in ipairs(self.holeArr) do
            holeNode:dragBegin()
        end

        if goodsGrid then
            -- 准备从装备框拿起动画
            self._kuangAnimation.kuangMoveAnimation:setAnimation("ready3", false)
            self._kuangAnimation.kuangMoveAnimation:setTimeScale(1)

            self._inlayAnimation:setAnimation("jianding_end_normal", false)
            self._inlayAnimation:setTimeScale(1)

        else
            -- 准备放入动画
            self._kuangAnimation.kuangMoveAnimation:setAnimation("ready1", false)
            self._kuangAnimation.kuangMoveAnimation:addAnimation("ready2", false)
            self._kuangAnimation.kuangMoveAnimation:setTimeScale(1)

            if self._inlayAnimation:getName() == "refreshInlayAnimation" then 
                self._inlayAnimation:setAnimation("xiangqian_begin_normal", false)
                self._inlayAnimation:addAnimation("xiangqian_idle_normal", false)
                self._inlayAnimation:setTimeScale(1)
            else
                self._inlayAnimation:setAnimation("jianding_begin_normal", false)
                self._inlayAnimation:addAnimation("jianding_idle_normal", false)
                self._inlayAnimation:setTimeScale(1)
            end
            -- self._inlayAnimation:setAnimation("jianding_begin_normal", false)
            -- self._inlayAnimation:addAnimation("jianding_idle_normal", false)
            -- self._inlayAnimation:setTimeScale(1)
        end
        -- self._inlayAnimation:setTimeScale(1)
        -- if (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Red) then
        --     self._inlayAnimation:setAnimation("hint_begin_normal", false)
        --     self._inlayAnimation:addAnimation("hint_idle_normal", true)
        -- elseif (gemStoneType == PublicDefine.GemStoneType.GemStoneType_Colourful) then
        --     self._inlayAnimation:setAnimation("hint_begin_colour", false)
        --     self._inlayAnimation:addAnimation("hint_idle_colour", true)
        -- end
    end
end

-- 放入动画
function PetGemStoneDevelopmentView:runPutAnimtion(gType, gemStoneType, slotIndex)
    if gType == GridType.equip then
        --[[self._kuangAnimation:setAnimation("enchase_yellow", false)
        self._kuangAnimation:setTimeScale(1)--]]
        self._kuangAnimation.successAnimation:setAnimation("hint_end", false)
        self._kuangAnimation:setTimeScale(1)
    else
        -- 判断是拖动到那个插槽了
        -- for _, holeNode in ipairs(self.holeArr) do
        --     if (holeNode:getHoleType() == gemStoneType and (goodsGrid == nil or goodsGrid == holeNode.goodsGrid)) then
        --         holeNode:dragEnd()
        --     end
        -- end
        for i, holeNode in ipairs(self.holeArr) do
            if i == slotIndex then
                holeNode:dragSuccess()
            end
        end
        self._kuangAnimation.kuangMoveAnimation:setAnimation("putin1", false)
        self._kuangAnimation.kuangMoveAnimation:addAnimation("putin2", false)
        self._kuangAnimation:setTimeScale(1)

        -- self._inlayAnimation:setAnimation("jianding_end_normal", false)
        -- self._inlayAnimation:setTimeScale(1)

        if self._inlayAnimation:getName() == "refreshInlayAnimation" then 
            self._inlayAnimation:setAnimation("xiangqian_end_normal", false)
            self._inlayAnimation:setTimeScale(1)
        else
            self._inlayAnimation:setAnimation("jianding_end_normal", false)
            self._inlayAnimation:setTimeScale(1)
        end

        --self._inlayAnimation:setAnimation("xiangqian_success_normal", false,1)
    end
end

function PetGemStoneDevelopmentView:refreshDevourModule(showAnimation)
    if self.leftNode then
        self.leftNode:removeAllChildren()
    end

    local bg = UI.Image:create()
    bg:init("ui_gem_paper.png")
    bg:centerUp(183)
    self.leftNode:addChild(bg)


    local upOffsetY = 155
    
    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    self.leftNode:addChild(shadown)

    local round = UI.Image:create()
    round:init("ui_gem_round.png")
    round:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    self.leftNode:addChild(round)

    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_pet_equipment.json", "effect_ui_town_pet_equipment.atlas")
    inlayAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("tunshi_idle", true, 0)
    
    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(kuangAnimation, 9)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)

    local kuangMoveAnimation = UI.Animation:create()
    kuangMoveAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    kuangMoveAnimation:center()
    kuangMoveAnimation:setAnimation("begin", false)
    kuangAnimation.kuangMoveAnimation = kuangMoveAnimation
    kuangAnimation:addChild(kuangMoveAnimation, 11)

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

    if self.mGoodsData then
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()
        self:runReadyAnimtion(GridType.equip)
    end


    --手动吞噬的提示文本
    local hdTxt = UI.Text:create()
    hdTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
    hdTxt:centerBottom(58)
    self.hdTxt = hdTxt
    bg:addChild(hdTxt, 10)

    --一键吞噬
    local quickBtn = UI.Button:create()
    quickBtn:init("ui_pets_equipment_btn.png", "ui_pets_equipment_btn.png", "ui_pets_equipment_btn.png")
    quickBtn:setText(UI.TEXT_224113)
    quickBtn:setTextFont(UI.FONT_BOLD,18,{r=214,g=174,b=78})
    quickBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        if not self.mGoodsData then
            UI.ScrollBar:createByText(UI.TEXT_224114)
            return
        end

        --弹出一键吞噬界面
        local tips = UI.PetGemSynthesisTips:create(function(param)
            --发送吞噬消息
            
            local deleteItemTable = self:getDeleteItemTableByParam(param)

            local resultParams = mvc.petGemStoneDevelopmentModel:analyzePhagocytosisResult(deleteItemTable,self.mGoodsData)
            if resultParams.tipsType == mvc.petGemStoneDevelopmentModel._tipsResult.levelExceed then
                local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_224119,resultParams.value), function()
                    Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
                end, function()
                    self:cancelDevour()
                end)
            elseif resultParams.tipsType == mvc.petGemStoneDevelopmentModel._tipsResult.expOverflow then
                local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_224120,resultParams.value), function()
                    Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
                end, function()
                    self:cancelDevour()
                end)
            else
                Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
            end


        end, function(param)
            local deleteItemTable = self:getDeleteItemTableByParam(param)
            local totalExp = mvc.petGemStoneDevelopmentModel:getExpByItemTable(deleteItemTable)
            if totalExp > 0 then
                self._addExpText:setText("+" .. tostring(totalExp))
            else
                self._addExpText:setText("")
            end
        end,function()
            self:cancelDevour()
        end)
        tips:init()
        tips:center()
        UI.UIManager:getRootNode():addChild(tips,UI_ZORDER.TIPS)
    end)
    quickBtn:centerBottom(85)
    self.leftNode:addChild(quickBtn)

    --手动吞噬
    local btnHeavyDevour = UI.Button:create()
    btnHeavyDevour:init("ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png")
    btnHeavyDevour:setText(UI.TEXT_224100)
    btnHeavyDevour:setTextFont(UI.FONT_BOLD,18,{r = 255, g = 255, b = 255})
    
    btnHeavyDevour:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        if not self.mGoodsData then
            UI.ScrollBar:createByText(UI.TEXT_224114)
            return
        end

        if not self._isSelect then
            self._isSelect = true
            btnHeavyDevour:setText(UI.TEXT_1170211)
            hdTxt:setText(UI.TEXT_224112)
        elseif self._isSelect then
            self._isSelect = false
            if #self._bagGridList._deleteItemTable == 0 then
                self._bagGridList:resetHandleStatus()
                btnHeavyDevour:setText(UI.TEXT_224100)
                hdTxt:setText("")
            end
        end

        self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
        if not self._isSelect then
            self._bagGridList:removeDisableByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE)
            self._bagGridList:removeDisableByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_TWO)
            self._bagGridList:removeDisableByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_THREE)
            -- self._bagGridList:removeDisableByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
            
        else
            self._bagGridList:disableTabByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE)
            self._bagGridList:disableTabByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_TWO)
            self._bagGridList:disableTabByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_THREE)
            -- self._bagGridList:hideTabByIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)

        end

        self._bagGridList:setMultiSelectOperation(self._isSelect,function(deleteItemTable)
            --发送吞噬的消息
            if self.mGoodsData then
                local resultParams = mvc.petGemStoneDevelopmentModel:analyzePhagocytosisResult(deleteItemTable,self.mGoodsData)
                if resultParams.tipsType == mvc.petGemStoneDevelopmentModel._tipsResult.levelExceed then
                    local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_224119,resultParams.value), function()
                        Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
                    end, function()
                        self:cancelDevour()
                    end)
                elseif resultParams.tipsType == mvc.petGemStoneDevelopmentModel._tipsResult.expOverflow then
                    local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_224120,resultParams.value), function()
                        Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
                    end, function()
                        self:cancelDevour()
                    end)
                else
                    Net.NetPetSystem:devourEquipmentGemStone(self.mGoodsData, deleteItemTable)
                end
            end
        end,function()
            self:cancelDevour()
        end)


    end)
    btnHeavyDevour:centerBottom(30)
    self.btnHeavyDevour = btnHeavyDevour
    self.leftNode:addChild(btnHeavyDevour)


    if self.mGoodsData then

        local lineImg = UI.Image:create()
        lineImg:init("ui_pets_equipment_line.png")
        lineImg:centerBottom(200)
        bg:addChild(lineImg)


        local desTxt = UI.Text:create()
        desTxt:init(UI.TEXT_224116, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41,g = 41,b = 45})
        desTxt:centerBottom(215)
        bg:addChild(desTxt, 10)



        local pBg = UI.Image:create()
        pBg:init("ui_pets_equipment_progressbg2.png")
        pBg:centerBottom(85)
        bg:addChild(pBg)

        --经验 
        local curExp, maxExp = self.mGoodsData:getExp()
        local proBG = cc.Sprite:createWithSpriteFrameName("ui_pets_equipment_progressbg.png")
        proBG:setPosition(bg:getContentSize().width / 2, 131)
        bg:addChild(proBG)

        self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_pets_equipment_progress.png"))
        self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        self._pro:setMidpoint(cc.p(0,0))
        self._pro:setBarChangeRate(cc.p(1,0))
        self._pro:setPosition(cc.p(proBG:getContentSize().width/2, proBG:getContentSize().height/2))
        proBG:addChild(self._pro,20)
        local percent = 100
        if maxExp ~= 0 then
            percent = curExp / maxExp 
            percent = percent > 1 and 1 or percent
        end
        self._pro:setPercentage(percent * 100)

        self.mTxtPro = UI.Text:create()
        if maxExp == curExp and curExp == 0 then
            self.mTxtPro:init("max", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        else
            self.mTxtPro:init(string.format("%d/%d", curExp, maxExp), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        end
        proBG:addChild(self.mTxtPro,100)
        self.mTxtPro:rightUp(2,-25)

        self._addExpText = UI.Text:create()
        self._addExpText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 30,g = 153,b = 100})
        self._addExpText:leftUp(2,-25)
        self._addExpText:useDefaultOutLineShadowStyle({r = 9,g = 32,b = 22})
        proBG:addChild(self._addExpText,100)
    else
        local lineImg = UI.Image:create()
        lineImg:init("ui_pets_equipment_line.png")
        lineImg:centerBottom(200)
        bg:addChild(lineImg)

        local desTxt = UI.Text:create()
        desTxt:init(UI.TEXT_224117, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
        desTxt:centerBottom(215)
        bg:addChild(desTxt, 10)

        local desTxt2 = UI.Text:create()
        desTxt2:init(UI.TEXT_224118, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
        desTxt2:leftUp(25,180)
        desTxt2:setSize(210,150)
        desTxt2:setTextLeftUp()
        bg:addChild(desTxt2, 10)
    end


    if showAnimation then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", true)
        self._kuangAnimation:setTimeScale(1)
    end
end

function PetGemStoneDevelopmentView:refreshConvertModule(showAnimation)
    if self.leftNode then
        self.leftNode:removeAllChildren()
    end

    local bg = UI.Image:create()
    bg:init("ui_gem_paper.png")
    bg:centerUp(183)
    self.leftNode:addChild(bg)


    local upOffsetY = 155
    
    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    self.leftNode:addChild(shadown)

    local round = UI.Image:create()
    round:init("ui_gem_round.png")
    round:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    self.leftNode:addChild(round)

    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_pet_equipment.json", "effect_ui_town_pet_equipment.atlas")
    inlayAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("tunshi_idle", true, 0)
    
    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(kuangAnimation, 9)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)

    local kuangMoveAnimation = UI.Animation:create()
    kuangMoveAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    kuangMoveAnimation:center()
    kuangMoveAnimation:setAnimation("begin", false)
    kuangAnimation.kuangMoveAnimation = kuangMoveAnimation
    kuangAnimation:addChild(kuangMoveAnimation, 11)

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

    if self.mGoodsData then
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()
        self:runReadyAnimtion(GridType.equip)
    end


    ----------
    --放入魂玉
    local costBtn = UI.Button:create()
    costBtn:init("ui_pets_equipment_btn.png", "ui_pets_equipment_btn.png", "ui_pets_equipment_btn.png")
    costBtn:setText(UI.TEXT_226304)
    costBtn:setTextFont(UI.FONT_BOLD,18,{r=214,g=174,b=78})
    costBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not self.mGoodsData then
            UI.ScrollBar:createByText(UI.TEXT_226302)
            return
        end

        local goodsData = self.mGoodsData
        local goodsId = goodsData:getGoodsID()
        local config = ConfigManager:getAllPetGemstoneConfig()[tonumber(goodsId)].conversionCost
        local conversionCost = string.split(config, ",")
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(conversionCost[1]), true)
        if goodNumber < tonumber(conversionCost[2]) then
            UI.ScrollBar:createByText(UI.TEXT_226306)
            return
        end

        local data = {}
        data.gemid = self.mGoodsData:getEntityID()
        Net.NetPetSystem:petStoneConvertRequest(data)
        --UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    end)
    costBtn:centerBottom(30)
    self.leftNode:addChild(costBtn)

    -- 转换消耗的材料及其数量
    if self.mGoodsData then
        local goodsData = self.mGoodsData
        local goodsId = goodsData:getGoodsID()
        local config = ConfigManager:getAllPetGemstoneConfig()[tonumber(goodsId)].conversionCost
        local conversionCost = string.split(config, ",")
        local goodsData2 = GoodsDataManager:createLocalGoodsData(tonumber(conversionCost[1]))

        local materialImg = UI.Image:create()
        --materialImg:init("symbol_gaming_diamond.png")
        materialImg:init(goodsData2:getSmallIconName())
        materialImg:center(-15, 0)
        costBtn:addChild(materialImg, 10)
        costBtn:setText("")
        print("materialImg")

        local materialCostTxt = UI.Text:create()
        materialCostTxt:init(conversionCost[2], UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 220,g = 182,b = 80})
        materialCostTxt:setTextLeft()
        materialCostTxt:leftBottom(35, 1)
        materialImg:addChild(materialCostTxt, 10)
    end
    ----------
    local lineImg = UI.Image:create()
    lineImg:init("ui_pets_equipment_line.png")
    lineImg:centerBottom(200)
    bg:addChild(lineImg)

    local desTxt = UI.Text:create()
    desTxt:init(UI.TEXT_226300, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
    desTxt:centerBottom(215)
    bg:addChild(desTxt, 10)

    local desTxt2 = UI.Text:create()
    desTxt2:init(UI.TEXT_226301, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
    desTxt2:leftUp(25,180)
    desTxt2:setSize(210,150)
    desTxt2:setTextLeftUp()
    bg:addChild(desTxt2, 10)


    if showAnimation then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", true)
        self._kuangAnimation:setTimeScale(1)
    end

    -- 判断是否有上次没有选择的魂玉，若有，则强制弹出让玩家选择一个魂玉
    if (not self.isNotChoseStone) then
        return
    end

    local petStoneTemplateArr = self.choseStoneArr
    print("petStoneTemplateArr--->: ", petStoneTemplateArr)


    if #petStoneTemplateArr <= 0 then
        return
    end
    print("petStoneTemplateArr--22->: ", petStoneTemplateArr)
    -- 上一次转换的魂玉没有选择，直接退出游戏，这次重新让他选择一个
    local awardsList = {}
    -- for k,v in pairs(petStoneTemplateArr) do
    --     local goodsData = nil
    --     goodsData = GoodsDataManager:createLocalGoodsData(v)
    --     if goodsData then
    --         goodsData:setNum(1) -- 因为是宝石，所以数量默认为1
    --         table.insert(awardsList,goodsData)
    --     end
    -- end
    awardsList = self.choseStoneArr
    self.leftLayer:removeChildByName("choiseConvert")
    local choseLayer = UI.PetGemStoneChoiseConvertView:create(awardsList)
    choseLayer:init()
    choseLayer:setName("choiseConvert")
    self.leftLayer:addChild(choseLayer)
end

function PetGemStoneDevelopmentView:refreshEvolutionModule(showAnimation)
    if self.leftNode then
        self.leftNode:removeAllChildren()
        self.btnEvolutionDevour = nil
    end

    local bg = UI.Image:create()
    bg:init("ui_gem_paper.png")
    bg:centerUp(183)
    self.leftNode:addChild(bg)


    local upOffsetY = 155
    
    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    self.leftNode:addChild(shadown)

    -- local round = UI.Image:create()
    -- round:init("ui_gem_round.png")
    -- round:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    -- self.leftNode:addChild(round)

    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_pet_equipment.json", "effect_ui_town_pet_equipment.atlas")
    inlayAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("tunshi_idle", true, 0)
    
    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(kuangAnimation, 9)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)

    local kuangMoveAnimation = UI.Animation:create()
    kuangMoveAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    kuangMoveAnimation:center()
    kuangMoveAnimation:setAnimation("begin", false)
    kuangAnimation.kuangMoveAnimation = kuangMoveAnimation
    kuangAnimation:addChild(kuangMoveAnimation, 11)

    -- 添加宝石框
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


    local btnEvolutionDevour = UI.Button:create()
    btnEvolutionDevour:init("ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png")
    btnEvolutionDevour:setText(UI.TEXT_224143)
    btnEvolutionDevour:setTextFont(UI.FONT_BOLD,18,{r = 255, g = 255, b = 255})
    
    btnEvolutionDevour:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not self.mGoodsData then
            return
        end


        if self.mGoodsData.upgradeCost and self.mGoodsData.upgradeCost ~= "" then
            local conversionCost = string.split(self.mGoodsData.upgradeCost, ";")

            local haveCost = true
            local gName = ""
            for k,v in ipairs(conversionCost) do
                local cost = string.split(v, ",")
                local gID = cost[1] and tonumber(cost[1])
                local num = cost[2] and tonumber(cost[2])
                
                local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(gID, true)
                if goodNumber < num then
                    haveCost = false
                    local goodsData = GoodsDataManager:createLocalGoodsData(gID)
                    if (goodsData) then
                        gName = goodsData.name
                    end
                    break
                end
            end

            if not haveCost then
                UI.ScrollBar:createByText(string.format(UI.TEXT_224147, gName))
                return
            end

            local equipId = 0
            local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(self.mGoodsData:getEquipmentID())
            -- print("    petRoleData ==== ", petRoleData)
            local petId = 0
            if petRoleData then
                petId = petRoleData:getPK()
                equipId = self.mGoodsData:getEquipmentID()
            end

            local position = {}
            print("self.mGoodsData:getSlotIndex() ==== ",self.mGoodsData:getSlotIndex())
            position.slotIndex = self.mGoodsData:getSlotIndex() - 1
            if position.slotIndex <= 0 then position.slotIndex = 0 end
            position.gemId = self.mGoodsData:getEntityID()
            position.petId = petId
            position.equipId = equipId
            Net.NetPetSystem:reqPetGemAwakeMessage(position)
            
        end

    end)
    btnEvolutionDevour:centerBottom(30)
    self.btnEvolutionDevour = btnEvolutionDevour
    self.leftNode:addChild(btnEvolutionDevour)

    if self.mGoodsData then
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()
        self:runReadyAnimtion(GridType.equip)


        local lineImg = UI.Image:create()
        lineImg:init("ui_pets_equipment_line.png")
        lineImg:centerBottom(200)
        bg:addChild(lineImg)

        local desTxt = UI.Text:create()
        desTxt:init(UI.TEXT_224141, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41,g = 41,b = 45})
        desTxt:centerBottom(215)
        bg:addChild(desTxt, 10)

        if (self.mGoodsData.upgradeItem ~= 0) then
            print("self.mGoodsData.upgradeItem ===== ",self.mGoodsData.upgradeItem)
            local goodsData = GoodsDataManager:createLocalGoodsData(self.mGoodsData.upgradeItem)
            if goodsData then
                local newGoodsGrid = UI.GoodsGrid:create()
                newGoodsGrid:centerBottom(70)

                if self.mGoodsData.goodsRare > PublicDefine.GOODS_RARE.RARE_DARKRED then
                    goodsData:initNetData(self.mGoodsData,1)
                    -- goodsData.level = self.mGoodsData.level
                    -- goodsData.exp = self.mGoodsData.exp
                end
            
                -- local goodsData = GoodsDataManager:createLocalGoodsData(self.mGoodsData.upgradeItem)
                -- goodsData:setNum(self.itemData[i].num)
                goodsData:setIsNew(false)
                goodsData.isHaveGet = false
                newGoodsGrid:init(goodsData)
                newGoodsGrid:showInfoArea(false, false)
                newGoodsGrid:setName("GoodsGrid")
                bg:addChild(newGoodsGrid, 10)


                local desTxt2 = UI.Text:create()
                desTxt2:init(LanguageManager:getInstance():getLocalString(goodsData.name), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41,g = 41,b = 45})
                desTxt2:centerBottom(160)
                bg:addChild(desTxt2, 10)

                if self.btnEvolutionDevour then
                    self.btnEvolutionDevour:setText("")

                    if self.mGoodsData.upgradeCost and self.mGoodsData.upgradeCost ~= "" then
                        local costLayout = UI.Layout:create()
                        costLayout:init()
                        costLayout:setSize(0, 150)
                        costLayout:center()
                        self.btnEvolutionDevour:addChild(costLayout, 10)
                        local conversionCost = string.split(self.mGoodsData.upgradeCost, ";")
                        if (#conversionCost == 1) then
                            costLayout:center(-30)
                        else
                            costLayout:center(-73)
                        end

                        for k,v in ipairs(conversionCost) do
                            local cost = string.split(v, ",")
                            local gID = cost[1] and tonumber(cost[1])
                            local num = cost[2] and tonumber(cost[2])
                            local materialImg = UI.Image:create()
                            local goodsData2 = GoodsDataManager:createLocalGoodsData(gID)
                            materialImg:init(goodsData2:getSmallIconName())
                            materialImg:floatLeft(5 + (k-1) * 20)
                            costLayout:addComponent(materialImg)

                            local haveCost = true
                            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(gID, true)
                            if goodNumber < num then
                                haveCost = false
                            end

                            local materialCostTxt = UI.Text:create()
                            if haveCost then
                                materialCostTxt:init(num, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 220,g = 182,b = 80})
                            else
                                materialCostTxt:init(num, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_RED)
                            end
                            materialCostTxt:floatLeft(5)
                            costLayout:addComponent(materialCostTxt)
                        end
                    end


                end
            end
        end
        

        

    else
        local lineImg = UI.Image:create()
        lineImg:init("ui_pets_equipment_line.png")
        lineImg:centerBottom(200)
        bg:addChild(lineImg)

        local desTxt = UI.Text:create()
        desTxt:init(UI.TEXT_224144, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
        desTxt:centerBottom(215)
        bg:addChild(desTxt, 10)

        local desTxt2 = UI.Text:create()
        desTxt2:init(UI.TEXT_224142, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
        desTxt2:leftUp(25,180)
        desTxt2:setSize(210,150)
        desTxt2:setTextLeftUp()
        bg:addChild(desTxt2, 10)
    end

    


    if showAnimation then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", true)
        self._kuangAnimation:setTimeScale(1)
    end

end


function PetGemStoneDevelopmentView:refreshStoneTriggerAnimation()
    -- body
    local upOffsetY = 155
    local leftEquipmentAnimation = UI.Animation:create()
    leftEquipmentAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    leftEquipmentAnimation:center()
    self._leftEquipmentAnimation = leftEquipmentAnimation
    leftEquipmentAnimation:setAnimation("trigger", false)
    leftEquipmentAnimation:setTimeScale(1)
    leftEquipmentAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(leftEquipmentAnimation, 11)

    self._inlayAnimation:addAnimation("jianding_trigger", false)
    self._inlayAnimation:setTimeScale(1)
    self._inlayAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "jianding_trigger") then
            local slotNode = self._kuangAnimation:getNodeForSlot("gem_kuang_da")
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

            if self.mGoodsData then
                print("self.mGoodsData num === ", self.mGoodsData:getNum())
                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()
                self:runReadyAnimtion()
            end

            --经验 
            local curExp, maxExp = self.mGoodsData:getExp()
            local percent = 100
            if maxExp ~= 0 then
                percent = curExp / maxExp 
                percent = percent > 1 and 1 or percent
            end
            self._pro:setPercentage(percent * 100)
            self.mTxtPro:setText(string.format("%d/%d", curExp, maxExp))
        end
    end)
end

function PetGemStoneDevelopmentView:refreshConvertTriggerAnimation(goodsDataArr)
    -- body
    local upOffsetY = 155
    local leftEquipmentAnimation = UI.Animation:create()
    leftEquipmentAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas")
    leftEquipmentAnimation:center()
    self._leftEquipmentAnimation = leftEquipmentAnimation
    leftEquipmentAnimation:setAnimation("trigger", false)
    leftEquipmentAnimation:setTimeScale(1)
    leftEquipmentAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(leftEquipmentAnimation, 11)

    local goodsDataArrs = goodsDataArr
    self._inlayAnimation:addAnimation("jianding_trigger", false)
    self._inlayAnimation:setTimeScale(1)
    self._inlayAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "jianding_trigger") then
            local slotNode = self._kuangAnimation:getNodeForSlot("gem_kuang_da")
            slotNode:removeAllChildren()
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
            print("refreshConvertTriggerAnimation")
            if self.mGoodsData then
                print("self.mGoodsData num === ", self.mGoodsData:getNum())
                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()
                self:runReadyAnimtion()
            end

            self.leftLayer:removeChildByName("choiseConvert")

            local choseLayer = UI.PetGemStoneChoiseConvertView:create(goodsDataArrs)
            choseLayer:init()
            choseLayer:setName("choiseConvert")
            self.leftLayer:addChild(choseLayer)
            if (self._bagGridList) then
                self._bagGridList:resetHandleStatus()
                self._bagGridList._deleteItemTable = {}

                self._bagGridList:setUsedType(self:getInitUseType())
                self._bagGridList:refreshView()
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
            end

            -- 设置没有选择转换魂玉的状态
            self.isNotChoseStone = true
            self.choseStoneArr = goodsDataArrs

            UI.WaitingLayer:hideWaiting()
        end
    end)
end

function PetGemStoneDevelopmentView:choseConvertEndRefresh2(goodsData)
    local slotNode = self._kuangAnimation:getNodeForSlot("gem_kuang_da")
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


    local awardsList = {}
    table.insert(awardsList, goodsData)
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
    end


    if (self._bagGridList) then
        self._bagGridList:resetHandleStatus()
        self._bagGridList._deleteItemTable = {}

        self._bagGridList:setUsedType(self:getInitUseType())
        self._bagGridList:refreshView()
    end

    UI.WaitingLayer:hideWaiting()

    self:createLeftView()
end

function PetGemStoneDevelopmentView:choseConvertEndRefresh(goodsData)
    local slotNode = self._kuangAnimation:getNodeForSlot("gem_kuang_da")
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

    if self.mGoodsData then
        print("self.mGoodsData num === ", self.mGoodsData:getNum())
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()
        self:runReadyAnimtion()

        local mGoodsData = self.mGoodsGrid:getData()
        local awardsList = {}
        table.insert(awardsList, mGoodsData)
        if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
        end
    end

    local awardsList = {}
    table.insert(awardsList, goodsData)
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
    end


    if (self._bagGridList) then
        self._bagGridList:resetHandleStatus()
        self._bagGridList._deleteItemTable = {}

        self._bagGridList:setUsedType(self:getInitUseType())
        self._bagGridList:refreshView()
        self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
    end

    -- 设置选择了转换魂玉的状态
    self.isNotChoseStone = false
    self.choseStoneArr = {}
end

function PetGemStoneDevelopmentView:cancelDevour()
    self._isSelect = false
    if not tolua.isnull(self.btnHeavyDevour) then
        self.btnHeavyDevour:setText(UI.TEXT_224100)
    end
    if not tolua.isnull(self.hdTxt) then
        self.hdTxt:setText("")
    end
    if not tolua.isnull(self._addExpText) then
        self._addExpText:setText("")
    end
    if not tolua.isnull(self._bagGridList) then
        self._bagGridList:resetHandleStatus()
        self._bagGridList._deleteItemTable = {}
    end
end

function PetGemStoneDevelopmentView:getDeleteItemTableByParam(param)
    local deleteItemTable = {}

    local master = RoleDataManager:getMaster()
    if (not master) then return {} end
    local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
    if stoneArr then
        for i = 1, #stoneArr do
            if (stoneArr[i]._changeNum == nil or stoneArr[i]._changeNum >= 0) 
            and self.mGoodsData ~= stoneArr[i]  
            and not stoneArr[i]:getIsLock() then

                for _,rare in ipairs(param) do
                    if stoneArr[i]:getGoodsRare() == rare then
                        table.insert(deleteItemTable,stoneArr[i])
                        break
                    end
                end
            end
        end

    end

    return deleteItemTable
end

function PetGemStoneDevelopmentView:createRightView()

    self.rightLayer:removeAllChildren()

    local userType = self:getInitUseType()

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(userType, true, false)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    -- self.rightLayer:addChild(bagList,2)
    -- bagList:setUseLock(true)
    local bagListW, bagListH = bagList:getSize()
    -- bagList:leftBottom(winSize.width + bagListW, (winSize.height - bagListH) / 2)
    bagList:leftBottom(0 , (winSize.height - bagListH) / 2)


    -- self._bagGridList:changeBagDefaultIndex(self._defaultBagIndex)

    bagList:setTouchEnable(true)
    bagList:setInterceptTouches(false)
    bagList:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        if self.closeIndex == 1 then
            self.closeIndex = 0
            mvc.petGemStoneDevelopmentPanel.ui:onTouchOutSizeEvent();
        end
    end)

    bagList:setRefreshOutSideLabelViewCallback(function()
        self:updateBagName()
    end)

    bagList.updateDeleteCallback = function(bgSelf,deleteItemTable)
        if not tolua.isnull(self._addExpText) then
            local totalExp = mvc.petGemStoneDevelopmentModel:getExpByItemTable(deleteItemTable)
            self._addExpText:setText("+" .. tostring(totalExp))
        end
    end

    local nameBg = UI.Image:create()
    nameBg:init("ui_pets_equipment_namebg.png")
    nameBg:centerRight(220,-260)
    self.rightLayer:addChild(nameBg,999)

    local bagNameTxt = UI.Text:create()
    bagNameTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 202,g = 198,b = 155})
    bagNameTxt:centerLeft(49)
    nameBg:addChild(bagNameTxt, 10)
    self.bagNameTxt = bagNameTxt

    self:refreshBagPage()
end

function PetGemStoneDevelopmentView:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    -- 根据拖动的类型来判断如何处理后续逻辑
    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
        self:runReadyAnimtion(GridType.equip)
    elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
        --if self.mGoodsData ~= nil then 
            self:runReadyAnimtion(GridType.gem, goodsData:getGemStoneType())
        --end 
    end
end

function PetGemStoneDevelopmentView:bagDragEndedCallback(grid, touchPosition, isInBag)
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
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end

            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            -- self._bagGridList:setUsedType(self:getChoiceGemStone())
            self._bagGridList:refreshView()

            self.mGoodsGrid:setData(self.mGoodsData)
            self.mGoodsGrid:setVisible(true)
            self.mGoodsGrid:show()
            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()
            self.mGoodsGrid:updateView()

            -- 切换背包的tab
            self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)

            self:refreshHole()
            self:runPutAnimtion(GridType.equip)
            -- GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111282))
        elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 

            if self._pageType == PageType.Devour then
                if goodsData:getIsExpType() then
                    UI.ScrollBar:createByText(UI.TEXT_224115)
                    return
                end

                if goodsData:isMaxLevel() then
                    UI.ScrollBar:createByText(UI.TEXT_224138)
                    return
                end

                if self.mGoodsData ~= nil then
                    self.mGoodsData._changeNum = 0
                end
    
                goodsData._changeNum = -1
                self.mGoodsData = goodsData
                self._bagGridList:refreshView()

                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()

                -- 切换背包的tab
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
                --self:runReadyAnimtion(GridType.equip)

                self:refreshDevourModule()
                self:runReadyAnimtion(GridType.equip)
                self:runPutAnimtion(GridType.gem)
                return
            elseif self._pageType == PageType.Convert then
                if goodsData:getIsExpType() then
                    UI.ScrollBar:createByText(UI.TEXT_226307)
                    return
                end

                -- if goodsData:isMaxLevel() then
                --     UI.ScrollBar:createByText(UI.TEXT_224138)
                --     return
                -- end

                if self.mGoodsData ~= nil then
                    self.mGoodsData._changeNum = 0
                end
    
                goodsData._changeNum = -1
                self.mGoodsData = goodsData
                self._bagGridList:refreshView()

                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()

                -- 切换背包的tab
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)

                self:refreshConvertModule()
                self:runReadyAnimtion(GridType.equip)
                self:runPutAnimtion(GridType.gem)
                return
            elseif self._pageType == PageType.Evolution then
                if goodsData:getIsExpType() then
                    UI.ScrollBar:createByText(UI.TEXT_224146)
                    return
                end

                local canNext,showMaxLevelTisp = goodsData:canEvolution()

                if showMaxLevelTisp then
                    UI.ScrollBar:createByText(UI.TEXT_224145)
                    return
                end

                if not canNext then
                    UI.ScrollBar:createByText(UI.TEXT_224146)
                    return
                end

                if self.mGoodsData ~= nil then
                    self.mGoodsData._changeNum = 0
                end
    
                goodsData._changeNum = -1
                self.mGoodsData = goodsData
                self._bagGridList:refreshView()

                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()

                self:refreshEvolutionModule()
                self:runReadyAnimtion(GridType.equip)
                self:runPutAnimtion(GridType.gem)
                return
            end

            if self.mGoodsData == nil then 
                -- if self._pageType == PageType.InlayGem then
                    -- 提示先拖动要镶嵌的装备
                    UI.ScrollBar:createByText(UI.TEXT_1201010)
                -- elseif self._pageType == PageType.Devour then

                    -- if goodsData:getIsExpType() then
                    --     UI.ScrollBar:createByText(UI.TEXT_224115)
                    --     return
                    -- end

                    -- if self.mGoodsData ~= nil then
                    --     self.mGoodsData._changeNum = 0
                    -- end
        
                    -- goodsData._changeNum = -1
                    -- self.mGoodsData = goodsData
                    -- self._bagGridList:refreshView()

                    -- self.mGoodsGrid:setData(self.mGoodsData)
                    -- self.mGoodsGrid:setVisible(true)
                    -- self.mGoodsGrid:show()
                    -- self.mGoodsGrid:hideCountLabel()
                    -- self.mGoodsGrid:hideNewIcon()
                    -- self.mGoodsGrid:hideBG()
                    -- self.mGoodsGrid:updateView()

                    -- -- 切换背包的tab
                    -- self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
                -- end
            else 
                

                local heroData = RoleDataManager:getMaster()
                local heroLevel = heroData:getLevel()
                local goodsLevel = goodsData:getRequireLevel()
                if goodsLevel == nil then 
                    -- 这种情况下为经验石，服务器没有设置经验石等级，因为经验石不能镶嵌
                    goodsLevel = 0
                end
                if heroLevel < goodsLevel then
                    UI.ScrollBar:createByText(UI.TEXT_224121)
                    return
                end

                if #self.holeArr == 0 then
                    UI.ScrollBar:createByText(UI.TEXT_224137)
                    return
                end

                self:runPutAnimtion(GridType.gem)

                for pIndex,holeNode in ipairs(self.holeArr) do 
                    holeNode:hideChoice()

                    local holeData = holeNode:getHoleData() 
                    local t = holeNode:convertToWorldSpace(cc.p(0,0))
                    local _rect = cc.rect(t.x,t.y,holeNode:getContentSize().width,holeNode:getContentSize().height)
                    if cc.rectContainsPoint(_rect, touchPosition) then
                        if self:alreadyInlaySameColorGem(goodsData, holeNode) then
                            UI.ScrollBar:createByText(UI.TEXT_224110)
                            if self.mGoodsData ~= nil then 
                                self:runCancelReadyAnimtion(GridType.gem)
                            end 
                            return
                        end

                        if goodsData:getIsExpType() then
                            UI.ScrollBar:createByText(UI.TEXT_224111)
                            if self.mGoodsData ~= nil then 
                                self:runCancelReadyAnimtion(GridType.gem)
                            end 
                            return
                        end

                        -- if RoleBehaviorManager:equipGemTownNpcCheck() then
                        --     printWarn(" been blocked when using gem npc inlay function !")
                        --     break
                        -- end
                        -- 在替换宝石的时候，需要判断是否有空格子
                        local targetHoleData = holeNode:getHoleData()
                        if targetHoleData then
                            local targetHoleGemData = mvc.petGemStoneDevelopmentModel:createPetStoneData(targetHoleData)
                            if(targetHoleGemData) then
                                local freePacketNum = GameDataManager:getInstance():getFreePetGemStoneBoxNum()
                                if(freePacketNum <= 0) then
                                    UI.ScrollBar:createByTextID(1110793)
                                    return 
                                end
                            end
                        end
                        
                        local equipId = self.mGoodsData:getEntityID()
                        local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(equipId)
                        local petId = 0
                        if petRoleData then
                            petId = petRoleData:getPK()
                        end
                        
                        local source = {}
                        local destination = {}
                        source.petId = 0
                        source.equipId = 0
                        source.gemId = goodsData:getEntityID()

                        destination.slotIndex = pIndex - 1
                        destination.petId = tonumber(petId)
                        destination.equipId = equipId or 0

                        Net.NetPetSystem:embedEquipmentGemStone(source,destination)
                        -- self:sendInlayMsg(self.mGoodsData, holeNode:getIndex(), {goodsData:getGoodsID(),goodsData:getBagType()})
                        
                        return
                    end
                end
                -- if self:alreadyInlaySameColorGem(goodsData, nil) then
                --     UI.ScrollBar:createByText(UI.TEXT_1212034)
                --     return
                -- end

                if goodsData:getIsExpType() then
                    UI.ScrollBar:createByText(UI.TEXT_224111)
                    if self.mGoodsData ~= nil then 
                        self:runCancelReadyAnimtion(GridType.gem)
                    end 
                    return
                end

                if self:alreadyInlaySameColorGem(goodsData) then
                    UI.ScrollBar:createByText(UI.TEXT_224110)
                    if self.mGoodsData ~= nil then 
                        self:runCancelReadyAnimtion(GridType.gem)
                    end 
                    return
                else
                    for pIndex, holeNode in ipairs(self.holeArr) do
                        local holeData = holeNode:getHoleData()
                        if holeData and holeData.gemId == 0 then
                            
                            local equipId = self.mGoodsData:getEntityID()
                            local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(equipId)
                            local petId = 0
                            if petRoleData then
                                petId = petRoleData:getPK()
                            end
                            
                            local source = {}
                            local destination = {}
                            source.petId = 0
                            source.equipId = 0
                            source.gemId = goodsData:getEntityID()

                            destination.slotIndex = pIndex - 1
                            destination.petId = tonumber(petId)
                            destination.equipId = equipId or 0

                            Net.NetPetSystem:embedEquipmentGemStone(source,destination)
                            
                            break
                        end
                    end
                end

            end
        end
    else 
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
            self:runCancelReadyAnimtion(GridType.equip)
        elseif(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
            --if self.mGoodsData ~= nil then 
                self:runCancelReadyAnimtion(GridType.gem)
            --end 
        end
    end
end 

function PetGemStoneDevelopmentView:alreadyInlaySameColorGem(data, targetHole)
    local inlay = false
    if targetHole then
        local targetHoleData = targetHole:getHoleData()
        if targetHoleData then

            local targetHoleGemData = mvc.petGemStoneDevelopmentModel:createPetStoneData(targetHoleData)
            if targetHoleGemData then
                print("data:getGemStoneType() 1 = ", targetHoleGemData.limitGroup, data.limitGroup)
            end
            if targetHoleGemData and targetHoleGemData.limitGroup == data.limitGroup then
                return inlay
            end
        end
    end
    for _, holeNode in ipairs(self.holeArr) do
        local holeData = holeNode:getHoleData()
        if holeData then
            local holeGemData = mvc.petGemStoneDevelopmentModel:createPetStoneData(holeData)
            if holeGemData and holeGemData.limitGroup == data.limitGroup then
                inlay = true
                break;
            end

        end
    end
    return inlay
end

function PetGemStoneDevelopmentView:refreshBagPage()
    if not self._bagGridList then
        return
    end

    self._bagGridList.isEvolution = false

    if self._pageType == PageType.InlayGem then
        self._bagGridList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
                -- UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
            }
        )
        self._bagGridList:setShowBagTagExt(
            {
                UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_ONE,
                UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_TWO,
                UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_THREE,
                UI.BagGoodsPanel.BAG_TYPE.PET_STONE,
                UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
            }
        )
        
        self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT
    elseif self._pageType == PageType.Devour or self._pageType == PageType.Evolution then
        if self._pageType == PageType.Evolution then
            self._bagGridList.isEvolution = true
        end
        
        self._bagGridList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
                UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
            }
        )
        self._bagGridList:setShowBagTagExt(
            {
                UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE,
                UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_TWO,
                UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_THREE,
                UI.BagGoodsPanel.BAG_TYPE.PET_STONE,
            }
        )

        self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE

        

    elseif self._pageType == PageType.Convert then
        self._bagGridList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
                UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
            }
        )
        self._bagGridList:setShowBagTagExt(
            {
                -- UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE,
                -- UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_TWO,
                -- UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_THREE,
                UI.BagGoodsPanel.BAG_TYPE.PET_STONE,
            }
        )

        self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.PET_STONE
    end


    self._bagGridList:init(nil, GameBagUIType.NORMAL, FLITER_TYPE.EQUIPMENT_ONLY_SHOW_PET)
    self._bagGridList:changeBagDefaultIndex(self._defaultBagIndex)

    self._bagGridList:setUsedType(self:getInitUseType())
    self._bagGridList:refreshView()

    self.rightLayer:addChild(self._bagGridList,2)
    -- self._bagGridList:refreshView()
end

function PetGemStoneDevelopmentView:updateBagName()
    if self.bagNameTxt and self._bagGridList then

        local bIndex = self._bagGridList:getBagIndex()

        if bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_ONE or bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_ONE then
            local petData = MasterDataManager:getFightPetBySiteId(0)
            if petData then
                self.bagNameTxt:setText(petData:getNickName())
            else
                self.bagNameTxt:setText(UI.TEXT_224102)
            end
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_TWO or bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_TWO then
            local petData = MasterDataManager:getFightPetBySiteId(1)
            if petData then
                self.bagNameTxt:setText(petData:getNickName())
            else
                self.bagNameTxt:setText(UI.TEXT_224102)
            end
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_SLOT_STONE_THREE or bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_EQUIPMENT_THREE then
            local petData = MasterDataManager:getFightPetBySiteId(2)
            if petData then
                self.bagNameTxt:setText(petData:getNickName())
            else
                self.bagNameTxt:setText(UI.TEXT_224102)
            end
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.PET_STONE then
            self.bagNameTxt:setText(UI.TEXT_224103)
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT then
            --背包里面的  宠物装备
            self.bagNameTxt:setText(UI.TEXT_224106)
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE then
            --仓库里面的  宠物装备
            self.bagNameTxt:setText(UI.TEXT_224107)
        end
    end
end

function PetGemStoneDevelopmentView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_PET_STONE
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function PetGemStoneDevelopmentView:saveConvertChoseData(data)
    -- 设置选择了转换魂玉的状态
    self.isNotChoseStone = true
    --self.choseStoneArr = data

    local awardsList = {}
    for k,v1 in pairs(data.gemids) do
        local goodsData = nil
        goodsData = GoodsDataManager:createLocalGoodsData(v1)
        if goodsData then
            goodsData:setNum(1) -- 因为是宝石，所以数量默认为1
            local netData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",data.goodsDataBytes)
            --local netData = {level = 1, exp = 0, entityID = 1383}
            goodsData:initNetData(netData)
            table.insert(awardsList, goodsData)
        end
    end

    self.choseStoneArr = awardsList
end

function PetGemStoneDevelopmentView:bindModel()

end


function PetGemStoneDevelopmentView:unbindModel()

end





return PetGemStoneDevelopmentView












