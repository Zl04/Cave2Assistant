------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetRefineView = class("PetRefineView", UI.BaseWin)

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

UI.PetRefineView = PetRefineView

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_town_gem.plist",
    "ui_common_btn.plist",
}

local TargetType = {
    EXP = 1,
    QUALITY = 2,
    SKILL = 3,
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

local FX_ITEMLIST_ITEMSELECT_JSON =  "effect_ui_gaming_itemselect.json"
local FX_ITEMLIST_ITEMSELECT_ATLAS = "effect_ui_gaming_itemselect.atlas"
local DUST_ID = 22070570

function PetRefineView:ctor()
    PetRefineView.super.ctor(
    	self,
    	UI.Type.PET_REFINE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REFINE_SELECT, self, self.refineSelect)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REFINE_OK, self, self.refineOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_CLEAR_REFINE_SELECT, self, self.clearOnceSelectPet)
end

function PetRefineView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetRefineView.super.init(self, ... )
end

function PetRefineView:dtor()
    self.netBlocking = false
    self.selectReserve = false --选择炼化保留宠物蛋

    PetRefineView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REFINE_SELECT, self, self.refineSelect)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REFINE_OK, self, self.refineOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_CLEAR_REFINE_SELECT, self, self.clearOnceSelectPet)

    reload_script_file_mvc("app.modules.pet.PetRefineView")
end

function PetRefineView:refineSelect(type, data, skillID)
    local petRetainCost = 0
    if self.selectImg then
        if self.selectReserve then
            self.selectImg:show()
        else
            self.selectImg:hide()
        end
    end

    if self.selectReserve then
        petRetainCost = self.centerPetData:getPetRetainCost()
    end

    self.curTargetSlotIdx = type

    local costLayout = self.contentLayout:getChildByName("RefineSkillCostLayer")
    if costLayout then
        self.contentLayout:removeChildByName("RefineSkillCostLayer")
    end
    self.useBtn:setText(UI.TEXT_1213644)

    self.resultGoodsList = data
    if self.curTargetSlotIdx == TargetType.EXP then
        -- 经验丹
        self.expPillOutputType = data or 0
    elseif self.curTargetSlotIdx == TargetType.QUALITY then
        local pill = self.contentLayout:getChildByName("QualityPill")
        if pill then
            self.contentLayout:removeChildByName("QualityPill")
        end

        self.qualityQuestionIcon:hide()

        -- 资质丹
        local qualityPillID = self.centerPetData.talentItem[1]
        local qualityPillNum = self.centerPetData.talentItem[2]
        local goodsData = GoodsDataManager:createLocalGoodsData(qualityPillID)
        goodsData:setNum(qualityPillNum)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:rightUp(61, 83)
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)
        goodsGrid:setName("QualityPill")
        self.contentLayout:addChild(goodsGrid)

        self.refineQualityID = qualityPillID
    elseif self.curTargetSlotIdx == TargetType.SKILL then
        -- 技能书
        -- 如果data=0，说明不能炼化成技能书，但是能产出金币

        self.refineSkillID = skillID
    
        if self.refineSkillID > 0 then
            local allBookIDs = mvc.petModel:getAllSkillBookID()
            local curBookData = allBookIDs[self.refineSkillID]
            local goodsData = GoodsDataManager:createLocalGoodsData(curBookData.id)
            self.skillIcon:setSpriteName(goodsData:getIconName())

            local refineSkillCostLayer = UI.Layout:create();
            refineSkillCostLayer:init()
            refineSkillCostLayer:enableAutoWidth()
            refineSkillCostLayer:enableAutoHeight()
            refineSkillCostLayer:centerBottom(30)
            refineSkillCostLayer:setName("RefineSkillCostLayer")
            self.contentLayout:addChild(refineSkillCostLayer)

            local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(curBookData.cost[1]))
            print("goodsData:getSmallIconName() === ",goodsData:getSmallIconName())
            local costImg  = UI.Image:create();
            costImg:init(goodsData:getSmallIconName());
            costImg:floatLeft(0)
            refineSkillCostLayer:addComponent(costImg, 10)
        
            local costTxt = UI.Text:create()
            costTxt:init(curBookData.cost[2] + petRetainCost, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            costTxt:floatLeft(10)
            refineSkillCostLayer:addComponent(costTxt, 10)
            self.refineSkillCost = curBookData.cost[2] + petRetainCost

            self.useBtn:setText("")
        else
            self.refineSkillID = 0
            self.skillIcon:setSpriteName("icon_gold.png")
        end
    end

    if (self.curTargetSlotIdx == TargetType.EXP or self.curTargetSlotIdx == TargetType.QUALITY) and petRetainCost > 0 then
        local refineSkillCostLayer = UI.Layout:create();
        refineSkillCostLayer:init()
        refineSkillCostLayer:enableAutoWidth()
        refineSkillCostLayer:enableAutoHeight()
        refineSkillCostLayer:centerBottom(30)
        refineSkillCostLayer:setName("RefineSkillCostLayer")
        self.contentLayout:addChild(refineSkillCostLayer)

        local costImg  = UI.Image:create();
        costImg:init("symbol_gaming_diamond.png");
        costImg:floatLeft(0)
        refineSkillCostLayer:addComponent(costImg, 10)
    
        local costTxt = UI.Text:create()
        costTxt:init(tostring(petRetainCost), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        costTxt:floatLeft(10)
        refineSkillCostLayer:addComponent(costTxt, 10)
        self.refineSkillCost = petRetainCost

        self.useBtn:setText("")
    end


    for i = 1, 3 do
        if self.curTargetSlotIdx == i then
            self["arrowSelect"..i]:show()

            self.selects[i]:show()
            self.selects[i]:setAnimation("start_square", false)
            self.selects[i]:addAnimation("loop_square", true)
        else
            self["arrowSelect"..i]:hide()

            self.selects[i]:setAnimation("end_square", false)
        end
    end

    local tips = {UI.TEXT_1213681, UI.TEXT_1213682, UI.TEXT_1213683}
    -- self.selectTipTxt:setText(UI.TEXT_111168..tips[self.curTargetSlotIdx])
    self.selectTipTxt:setText("")
    self.useBtn:enable()

    if self.centerPetData and self.centerPetData:getPetQuality() > 2 then
        self.bottomLayout:show()
    else
        self.bottomLayout:hide()
    end

    

end

function PetRefineView:refineOver(data, isMultiple)
    self.netBlocking = false

    self.refineAwards = {}
    for _, value in ipairs(data.awards) do
        local awarObj = GoodsDataManager:createLocalGoodsData(value.id)
        awarObj:setNum(value.num)
        if value.num > 0 then
            table.insert(self.refineAwards, awarObj)
        end
    end

    if isMultiple then
        -- 炼化会销毁宠物，这里强制重置一下列表
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REMOVE)
        self:showRefineAwards()

        self:resetData()
        self:resetView()
    else
        -- 炼化会销毁宠物，这里强制重置一下列表
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SELECT_CELL_UPDATE, mvc.petModel:getFightPetIdx())

        for i = 1, 3 do
            self.selects[i]:hide()
        end

        self:playEff()
    end
end


function PetRefineView:playEff()
    self.playingEff = true

    local slotEff = UI.Animation:create()
    slotEff:init("effect_ui_town_pet_source_slot.json", "effect_ui_town_pet_source_slot.atlas", 1);
    slotEff:center()
    self.targetSlots[self.curTargetSlotIdx]:addChild(slotEff, 100)

    self.centerSlotEff:setAnimation("trigger", false)
    self.centerBGEff:setAnimation("trigger", false)

    performWithDelay(self, function()
        slotEff:setAnimation("trigger", false)
        slotEff:addEventListener(UIEvent.ANIMATION_END,self,function()
            if not self or tolua.isnull(self) then
                return
            end

            self.playingEff = false

            local centerSlot = self.contentLayout:getChildByName("CenterPet")
            if centerSlot then
                self.contentLayout:removeChildByName("CenterPet")
            end

            self:showRefineAwards()

            self:resetData()
            self:resetView()
        end)
    end, 0.2)
end

function PetRefineView:showRefineAwards()
    if self.refineAwards and #self.refineAwards > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, self.refineAwards, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
        self.refineAwards = {}
        UI.ScrollBar:createByText(UI.TEXT_1213645)
    end
end

function PetRefineView:resetView()
    local costLayout = self.contentLayout:getChildByName("RefineSkillCostLayer")
    if costLayout then
        self.contentLayout:removeChildByName("RefineSkillCostLayer")
    end
    self.useBtn:setText(UI.TEXT_1213644)

    -- 资质丹
    local pill = self.contentLayout:getChildByName("QualityPill")
    if pill then
        self.contentLayout:removeChildByName("QualityPill")
    end

    self.qualityQuestionIcon:show()

    -- 技能书
    self.skillIcon:setSpriteName("ui_pets_manual_unkown.png")

    self.arrowBg1:hide()
    self.arrowBg2:hide()
    self.arrowBg3:hide()

    self.arrowSelect1:hide()
    self.arrowSelect2:hide()
    self.arrowSelect3:hide()

    self.selectTipTxt:setText(UI.TEXT_1213685)
    self.useBtn:disable()

    if self.centerPetData and self.centerPetData:getPetQuality() >= 4 then
        self.selectReserve = true
    else 
        self.selectReserve = false
    end
    self.bottomLayout:hide()

    -- performWithDelay(self, function()
    --     self:updateGoldDust()
    -- end, 0.2)
end


-- 更新黄金粉尘
function PetRefineView:updateGoldDust()
    local pk = RoleDataManager:getMaster():getPK()
    local dustTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, DUST_ID)
    -- TODO
    self.goldNum:setText(self.goldNum:numformat(string.format("%s", tostring(GameDataManager:getCurCoin()))))
    self.goldNum:updateView()
    self.dustNum:setText(self.dustNum:numformat(string.format("%s", dustTotalNum)))
    self.dustNum:updateView()
end

function PetRefineView:resetData()
    self.centerPetData = nil
    self.curTargetSlotIdx = 0
    self.refineQualityID = -1
    self.refineSkillID = -1
    self.refineSkillCost = 0
    self.expPillOutputType = 0
end

function PetRefineView:onInitView()
    self.selects = {}
    self.targetSlots = {}

    self:resetData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, -50)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create();
    bg:init("ui_pets_conversion_bg.png");
    bg:centerUp(60);
    self.contentLayout:addChild(bg);

    -- -- 资源栏
    -- local resLayout = UI.Layout:create()
    -- resLayout:init()
    -- resLayout:setSize(380, 40)
    -- resLayout:centerUp(0)
    -- -- resLayout:enableDebugDraw()
    -- self.contentLayout:addChild(resLayout)

    -- -- 金币
    -- local goldImg = UI.Image:create()
    -- goldImg:init("symbol_gaming_money.png")
    -- goldImg:centerLeft(24)
    -- resLayout:addChild(goldImg)

    -- local goldNum = UI.Text:create()
    -- goldNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- goldNum:setTextLeft()
    -- goldNum:centerLeft(50)
    -- resLayout:addChild(goldNum)
    -- self.goldNum = goldNum

    -- -- 粉尘
    -- local dustImg = UI.Image:create()
    -- dustImg:init("symbol_gaming_souldust.png")
    -- dustImg:centerLeft(200)
    -- resLayout:addChild(dustImg)

    -- local dustNum = UI.Text:create()
    -- dustNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- dustNum:setTextLeft()
    -- dustNum:centerLeft(226)
    -- resLayout:addChild(dustNum)
    -- self.dustNum = dustNum

    -- self:updateGoldDust()

    -- 跳转商店按钮
    -- local shopButton = UI.Button:create()
    -- shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    -- shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, nil, nil, self.parentLayer,
    --     PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_Bag)
    -- end)
    -- shopButton:centerLeft(340)
    -- shopButton:setInterval(1)
    -- resLayout:addChild(shopButton)
    -- if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase)
    --     and not SceneManager:getInstance():isInStory()
    --  then
    --     shopButton:show()
    -- else
    --     shopButton:hide()
    -- end

    -- local lineImg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_50%black.png", cc.rect(0,0,1,1))
    -- lineImg:setContentSize(cc.size(380, 1))
    -- lineImg:setPosition(cc.p(190, 0))
    -- resLayout:addChild(lineImg, 1000)

    -- 跳转宠物回收商店按钮
    local skipBg = UI.Image:create()
    skipBg:init("ui_pets_conversion_skip_bg.png")
    skipBg:rightBottom(4, -8)
    bg:addChild(skipBg)

    local skipBtn = UI.Button:create()
    skipBtn:init("ui_pets_conversion_skip_0.png", "ui_pets_conversion_skip_1.png")
    skipBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        -- 跳转界面
        mvc.send("PetTreasure_Open_RecyclingShop_view", nil, "RecyclingShopGoodsLayer")

    end)
    skipBtn:leftBottom(15, 15)
    skipBg:addChild(skipBtn)

    -- 箭头
    local arrow1  = UI.Image:create();
    arrow1:init("ui_pets_conversion_arrow_0.png");
    arrow1:leftUp(148, 64);
    arrow1:rotate(120)
    arrow1:hide()
    bg:addChild(arrow1);
    self.arrowBg1 = arrow1

    local arrowSelect1  = UI.Image:create();
    arrowSelect1:init("ui_pets_conversion_arrow_1.png");
    arrowSelect1:leftUp(148, 64);
    arrowSelect1:rotate(120)
    bg:addChild(arrowSelect1);
    arrowSelect1:hide()
    self.arrowSelect1 = arrowSelect1

    local arrow2  = UI.Image:create();
    arrow2:init("ui_pets_conversion_arrow_0.png");
    arrow2:rightUp(150, 64);
    arrow2:rotate(-120)
    arrow2:hide()
    bg:addChild(arrow2);
    self.arrowBg2 = arrow2

    local arrowSelect2 = UI.Image:create();
    arrowSelect2:init("ui_pets_conversion_arrow_1.png");
    arrowSelect2:rightUp(150, 64);
    arrowSelect2:rotate(-120)
    bg:addChild(arrowSelect2);
    arrowSelect2:hide()
    self.arrowSelect2 = arrowSelect2

    local arrow3  = UI.Image:create();
    arrow3:init("ui_pets_conversion_arrow_0.png");
    arrow3:centerUp(136);
    arrow3:hide()
    bg:addChild(arrow3);
    self.arrowBg3 = arrow3

    local arrowSelect3  = UI.Image:create();
    arrowSelect3:init("ui_pets_conversion_arrow_1.png");
    arrowSelect3:centerUp(136);
    bg:addChild(arrowSelect3);
    arrowSelect3:hide()
    self.arrowSelect3 = arrowSelect3

    local bgEff = UI.Animation:create()
    bgEff:init("effect_ui_town_pet_target_bg2.json", "effect_ui_town_pet_target_bg2.atlas", 1);
    bgEff:leftUp(212, 196)
    self.contentLayout:addChild(bgEff)
    self.centerBGEff = bgEff

    local centerImg1  = UI.Image:create();
    centerImg1:init("ui_gem_box_colorful.png");
    centerImg1:centerUp(88);
    bg:addChild(centerImg1);

    local centerImg2  = UI.Image:create();
    centerImg2:init("ui_pets_merge_box.png");
    centerImg2:center();
    centerImg1:addChild(centerImg2);

    -- 拖拽判定框
    local targetCheckLayer = UI.Layout:create();
    targetCheckLayer:init()
    targetCheckLayer:setSize(116, 116)
    targetCheckLayer:center()
    -- targetCheckLayer:enableDebugDraw()
    centerImg1:addChild(targetCheckLayer)
    self.targetCheckLayer = targetCheckLayer

    -- 材料
    -- 经验丹
    local goodsData1 = GoodsDataManager:createLocalGoodsData(22080020)
    goodsData1:setIsNew(false)
    goodsData1.isHaveGet = false

    local goodsGrid1 = UI.GoodsGrid:create()
    goodsGrid1:leftUp(59, 83)
    goodsGrid1:init(goodsData1)
    goodsGrid1:showInfoArea(false, false)
    self.contentLayout:addChild(goodsGrid1)

    local select1  = UI.Animation:create()
    select1:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
    select1:leftUp(94, 118)
    self.contentLayout:addChild(select1, 10)

    local touchLayer1 = UI.Layout:create();
    touchLayer1:init()
    touchLayer1:setSize(116, 116)
    touchLayer1:leftUp(34, 60)
    touchLayer1:setTouchEnable(true)
    touchLayer1:setInterceptTouches(false)
    self.contentLayout:addChild(touchLayer1, 10)
    touchLayer1:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:targetSlotClick(1)
    end)

    -- 资质丹
    local select2  = UI.Animation:create()
    select2:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
    select2:rightUp(94, 118)
    self.contentLayout:addChild(select2, 10)

    local touchLayer2 = UI.Layout:create();
    touchLayer2:init()
    touchLayer2:setSize(116, 116)
    touchLayer2:rightUp(40, 60)
    touchLayer2:setTouchEnable(true)
    touchLayer2:setInterceptTouches(false)
    self.contentLayout:addChild(touchLayer2, 10)
    touchLayer2:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:targetSlotClick(2)
    end)

    -- 资质丹
    local qualityPillIcon = UI.Image:create()
    qualityPillIcon:init("ui_pets_manual_unkown.png");
    qualityPillIcon:center()
    touchLayer2:addChild(qualityPillIcon)
    self.qualityQuestionIcon = qualityPillIcon

    -- 技能书
    local select3  = UI.Animation:create()
    select3:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
    select3:leftBottom(212, 172)
    self.contentLayout:addChild(select3, 10)

    local touchLayer3 = UI.Layout:create();
    touchLayer3:init()
    touchLayer3:setSize(116, 116)
    touchLayer3:leftBottom(154, 115)
    touchLayer3:setTouchEnable(true)
    touchLayer3:setInterceptTouches(false)
    self.contentLayout:addChild(touchLayer3, 10)
    touchLayer3:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:targetSlotClick(3)
    end)

    local skillIcon = UI.Image:create()
    skillIcon:init("ui_pets_manual_unkown.png");
    skillIcon:center()
    touchLayer3:addChild(skillIcon)
    self.skillIcon = skillIcon

    table.insert(self.targetSlots, goodsGrid1)
    table.insert(self.targetSlots, qualityPillIcon)
    table.insert(self.targetSlots, skillIcon)

    table.insert(self.selects, select1)
    table.insert(self.selects, select2)
    table.insert(self.selects, select3)

    local selectTipTxt = UI.Text:create()
    selectTipTxt:init(UI.TEXT_1213685, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)
    selectTipTxt:centerBottom(70)
    selectTipTxt:setWidth(400)
    selectTipTxt:setTextCenter()
    selectTipTxt:autoAdapt()
    selectTipTxt:setLineSpacing(-6)
    self.contentLayout:addChild(selectTipTxt)
    self.selectTipTxt = selectTipTxt

    -- 炼化按钮
    local useBtn = UI.Button:create();
    useBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png");
    useBtn:centerBottom(20);
    useBtn:disable()
    useBtn:setText(UI.TEXT_1213644)
    useBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.playingEff then
            return
        end

        if not self.centerPetData then
            UI.ScrollBar:createByText(UI.TEXT_1213623)
            return
        end

        if self.curTargetSlotIdx == 0 then
            UI.ScrollBar:createByText(UI.TEXT_1213646)
            return
        end

        if self.curTargetSlotIdx == 2 and self.refineQualityID == -1 then
            UI.ScrollBar:createByText(UI.TEXT_1213647)
            return
        end

        if self.curTargetSlotIdx == 3 and self.refineSkillID == -1 then
            UI.ScrollBar:createByText(UI.TEXT_1213648)
            return
        end

        -- 判断背包是否够用 (特殊处理,检测背包是否足够)
        local awards = clone(self.resultGoodsList)
        if self.selectReserve then
            table.insert(awards,{goodsID = 20200001, num = 1, isGolden = false})
        end
        if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(awards) then
            UI.ScrollBar:createByTextID(1170081)
            return
        end
        
        local tipsDes = UI.TEXT_1213649
        if self.selectReserve then
            tipsDes = UI.TEXT_1213687
        end

        -- if self.curTargetSlotIdx == 3 then
        if self.selectReserve then
            if Avalon.MathUtil:checkDiamonEnough(tonumber(self.refineSkillCost), GameDataManager:getInstance():getDiamond()) then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    tipsDes,
                    function()
                        self:netLock()

                        if self.curTargetSlotIdx == TargetType.SKILL then
                            Net.NetPetSystem:refine(self.centerPetData:getId(), self.curTargetSlotIdx, self.refineSkillID,self.selectReserve)
                        else
                            Net.NetPetSystem:refine(self.centerPetData:getId(), self.curTargetSlotIdx,nil,self.selectReserve)
                        end
                    end
                )
            else
                -- 钻石不足
                local tips = UI.TipsLayer:onDiamondNotEnough()
                if(tips) then 
                    tips:setZOrder(UI_ZORDER.MAX)
                end
                tips:removeFromParent(false)
                UI.UIManager:getRootNode():addChild(tips)
            end
        else
            UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                tipsDes,
                function()
                    self:netLock()

                    if self.curTargetSlotIdx == TargetType.SKILL then
                        Net.NetPetSystem:refine(self.centerPetData:getId(), self.curTargetSlotIdx, self.refineSkillID,self.selectReserve)
                    else
                        Net.NetPetSystem:refine(self.centerPetData:getId(), self.curTargetSlotIdx,nil,self.selectReserve)
                    end
                end
            )
        end
    end)
    self.contentLayout:addChild(useBtn)
    self.useBtn = useBtn


    --选择保留宠物蛋选项
    local bottomLayout = UI.Layout:create();
    bottomLayout:init()
    bottomLayout:enableAutoWidth()
    bottomLayout:centerBottom(90)
    self.contentLayout:addChild(bottomLayout)
    self.bottomLayout = bottomLayout
    bottomLayout:hide()

    --选择框
    local sBg = UI.Button:create()
    sBg:init("ui_btn_choice_0.png", "ui_btn_choice_0.png")
    sBg:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self.selectReserve = not self.selectReserve
        self:refineSelect(self.curTargetSlotIdx, self.resultGoodsList, self.refineSkillID)
    end)
    sBg:floatLeft()
    bottomLayout:addComponent(sBg)

    --选择的GG
    local selectImg = UI.Image:create()
    selectImg:init("ui_btn_choice_1.png")
    selectImg:center()
    sBg:addChild(selectImg,9999)
    self.selectImg = selectImg
    if self.selectReserve then
        selectImg:show()
    else
        selectImg:hide()
    end

    --文字描述
    local sDes = UI.Text:create()
    sDes:init(UI.TEXT_1213686, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)
    sDes:floatLeft(5)
    bottomLayout:addComponent(sDes)




end

function PetRefineView:netLock()
    self.netBlocking = true

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        self.netBlocking = false
    end, 5)
end

function PetRefineView:targetSlotClick(idx)
    if self.playingEff then
        return
    end

    if not self.centerPetData then
        UI.ScrollBar:createByText(UI.TEXT_1213623)
        return
    end

    mvc.openPanel("Pet", "PetRefineSelect", {idx=idx, id=self.centerPetData:getId()})
end

function PetRefineView:slotDragEnd(petID, x, y)
    if self.playingEff then
        return
    end

    if not self:isVisible() then
        return
    end

    local petData = MasterDataManager:getBagPetById(petID)
    if(petData) then 
        local arr = petData:getWearEquipmentArr()
        if(arr and #arr > 0) then
            UI.ScrollBar:createByText(UI.TEXT_1325910)
            return 
        end
    end

    local pos = self.targetCheckLayer:convertToNodeSpace(cc.p(x, y))
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        self:addCenterPet(petID)
    end
end

function PetRefineView:addCenterPet(petID)
    local petData = MasterDataManager:getBagPetById(petID)
    if petData:isFight() then
        UI.ScrollBar:createByText(UI.TEXT_1213650)
        return
    end

    if MasterDataManager:isAllowPetChange(petID) then
        UI.ScrollBar:createByText(UI.TEXT_226180)
        return
    end

    local fpets = mvc.petTreasureModel:getPetAdvEmbattlePets()
    for k, fpet in pairs(fpets) do
        if fpet.getSpriteID and fpet:getSpriteID() == petID then
            UI.ScrollBar:createByText(UI.TEXT_221111)
            return 
        end
    end 

    if mvc.dockModel:checkPetIsSailing(petID) then
        UI.ScrollBar:createByText(UI.TEXT_221932)
        return
    end

    -- 百变宠不能用于炼化
    if tonumber(ConfigManager:getGeneralForKey("PetCommonID")) == petData.templateID then
        UI.ScrollBar:createByText(UI.TEXT_1213651)
        return
    end

    self.centerPetData = petData
    
    if self.centerPetData and self.centerPetData:getPetQuality() >= 4 then
        self.selectReserve = true
    else 
        self.selectReserve = false
    end

    local centerSlot = self.contentLayout:getChildByName("CenterPet")
    if centerSlot then
        self.contentLayout:removeChildByName("CenterPet")
    end

    local centerPet = UI.PetMainListCell:create()
    centerPet:init(petID)
    centerPet:leftUp(178, 161)
    centerPet:setName("CenterPet")
    self.contentLayout:addChild(centerPet, 100)

    centerPet:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onCenterPetTouchMove)
    centerPet:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onCenterPetTouchEnd)

    local centerSlotEff = UI.Animation:create()
    centerSlotEff:init("effect_ui_town_pet_target_slot.json", "effect_ui_town_pet_target_slot.atlas", 1);
    centerSlotEff:center()
    centerPet:addChild(centerSlotEff, 100)
    self.centerSlotEff = centerSlotEff

    for i = 1, 3 do
        self.selects[i]:hide()
    end

    self.curTargetSlotIdx = 0
    self.refineQualityID = -1
    self.refineSkillID = -1
    self.refineSkillCost = 0
    self.expPillOutputType = 0

    self:resetView()

    self.arrowBg1:show()
    self.arrowBg2:show()
    self.arrowBg3:show()

end

function PetRefineView:clearOnceSelectPet()
    self.skillIcon:setSpriteName("ui_pets_manual_unkown.png");
    local centerSlot = self.contentLayout:getChildByName("CenterPet")
    if centerSlot then
        self.contentLayout:removeChildByName("CenterPet")
    end
    self.centerPetData = nil

    for i = 1, 3 do
        self.selects[i]:hide()
    end

    self:resetData()
    self:resetView()
end

function PetRefineView:onCenterPetTouchMove(com, touchPosition)
    local pos = self.contentLayout:convertToNodeSpace(touchPosition)
    local size = com:getContentSize()
    local x = pos.x - size.width/2
    local y = pos.y - size.height/2
    com:setPosition(cc.p(x, y))
end

function PetRefineView:onCenterPetTouchEnd(com, touchPosition)
    local pos = self.targetCheckLayer:convertToNodeSpace(touchPosition)
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        com:leftUp(178, 161)
    else
        self.skillIcon:setSpriteName("ui_pets_manual_unkown.png");
        self.contentLayout:removeChildByName("CenterPet")
        self.centerPetData = nil

        for i = 1, 3 do
            self.selects[i]:hide()
        end

        self:resetData()
        self:resetView()
    end
end

function PetRefineView:updateToShow()
    self.skillIcon:setSpriteName("ui_pets_manual_unkown.png");
    self.contentLayout:removeChildByName("CenterPet")
    self.centerPetData = nil

    for i = 1, 3 do
        self.selects[i]:hide()
    end

    self:resetData()
    self:resetView()
end

function PetRefineView:bindModel()

end


function PetRefineView:unbindModel()

end

return PetRefineView
