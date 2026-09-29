------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAttrView = class("PetAttrView", UI.BaseWin)

require "app.modules.pet.PetQualityLayer"
require "app.modules.pet.PetSkillLayer"
require "app.modules.pet.PetShareView"
require "app.config.ConfigManager"

local GameDataManager = require("app.game.GameDataManager")
local winSize = cc.Director:getInstance():getWinSize()

UI = UI or {}

UI.PetAttrView = PetAttrView

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
    "ui_package_pets_share.plist",
    "ui_town_reincarnation_role.plist",
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetAttrView:ctor()
    PetAttrView.super.ctor(
    	self,
    	UI.Type.PET_ATTR,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_LEVELUP_OK, self, self.levelupOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_READY_FIGHT_OK, self, self.readyFightOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_WEAR_EQUIPMENT_RESULT, self, self.wearEquipmentResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_BREAKLEVELUP_OK, self, self.breakSuccess)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REINCARNATION__OK, self, self.reincarnationOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.changeSkinOver)
end

function PetAttrView:init(petID, innerTabIdx, ... )
    self.curPet = MasterDataManager:getBagPetById(petID)
    
    self.innerTabIdx = innerTabIdx

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetAttrView.super.init(self, ... )
end

function PetAttrView:dtor()
    self.netBlocking = false

    PetAttrView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_LEVELUP_OK, self, self.levelupOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_READY_FIGHT_OK, self, self.readyFightOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_WEAR_EQUIPMENT_RESULT, self, self.wearEquipmentResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_BREAKLEVELUP_OK, self, self.breakSuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REINCARNATION__OK, self, self.reincarnationOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_CHANGE_SKIN_OK, self, self.changeSkinOver)

    reload_script_file_mvc("app.modules.pet.PetAttrView")
end

function PetAttrView:readyFightOver()
    self.netBlocking = false

    self:updateButtonState()
end

function PetAttrView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 顶部按钮条
    -- 背景图片
    local titleBG  = UI.Image:create();
    titleBG:init("ui_pets_attribute_btn_0.png");
    titleBG:centerUp(10);
    contentLayout:addChild(titleBG);

    local select1  = UI.Image:create();
    select1:init("ui_pets_cultivate_btn_1.png");
    select1:leftUp(1, 1);
    titleBG:addChild(select1);
    select1:hide()
    self.tabSelect1 = select1

    local select2  = UI.Image:create();
    select2:init("ui_pets_cultivate_btn_1.png");
    select2:leftUp(138, 1);
    titleBG:addChild(select2);
    select2:hide()
    self.tabSelect2 = select2

    local select3  = UI.Image:create();
    select3:init("ui_pets_cultivate_btn_1.png");
    select3:leftUp(274, 1);
    titleBG:addChild(select3);
    select3:hide()
    self.tabSelect3 = select3

    local touchLayer1 = UI.Layout:create();
    touchLayer1:init()
    touchLayer1:setSize(136, 38)
    touchLayer1:leftUp(0, 0)
    touchLayer1:setTouchEnable(true)
    touchLayer1:setSwallowTouches(true)
    touchLayer1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 1 then
            return
        end

        self:updateTabList(1)
    end)
    titleBG:addChild(touchLayer1)

    local touchLayer2 = UI.Layout:create();
    touchLayer2:init()
    touchLayer2:setSize(136, 38)
    touchLayer2:leftUp(138, 0)
    touchLayer2:setTouchEnable(true)
    touchLayer2:setSwallowTouches(true)
    touchLayer2:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 2 then
            return
        end

        self:updateTabList(2)
    end)
    titleBG:addChild(touchLayer2)

    local touchLayer3 = UI.Layout:create();
    touchLayer3:init()
    touchLayer3:setSize(136, 38)
    touchLayer3:leftUp(276, 0)
    touchLayer3:setTouchEnable(true)
    touchLayer3:setSwallowTouches(true)
    touchLayer3:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 3 then
            return
        end

        self:updateTabList(3)
    end)
    titleBG:addChild(touchLayer3)

    local tabTxt1 = UI.Text:create()
    tabTxt1:init(UI.TEXT_1213612, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w1 = tabTxt1:getContentSize().width
    tabTxt1:setWidth(138)
    tabTxt1:setTextCenter()
    tabTxt1:autoAdapt()
    if w1 > 138 then
        tabTxt1:leftUp(0, 0)
    else
        tabTxt1:leftUp(0, 8)
    end
    tabTxt1:setLineSpacing(-6)
    titleBG:addChild(tabTxt1)

    local tabTxt2 = UI.Text:create()
    tabTxt2:init(UI.TEXT_1213613, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w2 = tabTxt2:getContentSize().width
    tabTxt2:setWidth(138)
    tabTxt2:setTextCenter()
    tabTxt2:autoAdapt()
    if w2 > 138 then
        tabTxt2:leftUp(138, 0)
    else
        tabTxt2:leftUp(138, 8)
    end
    tabTxt2:setLineSpacing(-6)
    titleBG:addChild(tabTxt2)

    local tabTxt3 = UI.Text:create()
    tabTxt3:init(UI.TEXT_1325900, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w3 = tabTxt3:getContentSize().width
    tabTxt3:setWidth(138)
    tabTxt3:setTextCenter()
    tabTxt3:autoAdapt()
    if w3 > 138 then
        tabTxt3:leftUp(276, 0)
    else
        tabTxt3:leftUp(276, 8)
    end
    tabTxt3:setLineSpacing(-6)
    titleBG:addChild(tabTxt3)
    
    local onlineBtn = UI.Button:create();
    onlineBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_0.png");
    onlineBtn:centerBottom(20);
    onlineBtn:closeClickScale()
    onlineBtn:setText(UI.TEXT_1213614)
    onlineBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    onlineBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.curPet:isFight() then
            UI.ScrollBar:createByText(UI.TEXT_1213615)
            return
        end

        if mvc.dockModel:checkPetIsSailing(self.curPet:getId()) then
            UI.ScrollBar:createByText(UI.TEXT_221932)
            return
        end

        if RoleBehaviorManager:checkMasterIsInBattle() then
            UI.ScrollBar:createByText(UI.TEXT_1213616)
            return
        end

        self.netBlocking = true
        performWithDelay(self, function()
            if not self or tolua.isnull(self) then
                return
            end

            self.netBlocking = false
        end, 5)

        Net.NetPetSystem:readyToFight(self.curPet:getId())
    end)
    contentLayout:addChild(onlineBtn)
    self._onlineBtn = onlineBtn

    --如果该宠物为可骑乘的宠物时 
    local rideBtn = UI.Button:create();
    rideBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png");
    rideBtn:centerBottom(20);
    rideBtn:closeClickScale()
    rideBtn:setText(UI.TEXT_1327000)
    rideBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    rideBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)

        if RoleBehaviorManager:checkMasterIsInBattle() then
            UI.ScrollBar:createByText(UI.TEXT_1327002)
            return
        end

        if not self.netBlocking then
            self.netBlocking = true
            performWithDelay(self, function()
                if not self or tolua.isnull(self) then
                    return
                end

                self.netBlocking = false
            end, 1)

            -- local petRoleAttribute = self.curPet:getPetRoleAttribute()
            local canRide = self.curPet:canRide()
            -- if petRoleAttribute ~= "" then
            if canRide then
                local isRide = MasterDataManager:getPetRidingState()--self.curPet:isRide()

                if not isRide then

                    local SceneManager = require("app.game.SceneManager")
                    if SceneManager:getInstance():isManor() then

                        UI.ScrollBar:createByText(UI.TEXT_221700)
                        return
                    end

                    print("   发送骑乘消息")
                    Net.NetPetSystem:readyToRide(self.curPet:getId())
                else
                    print("   发送下骑乘消息")
                    Net.NetPetSystem:readyToFollow(self.curPet:getId())
                end
            end
        end
    end)
    contentLayout:addChild(rideBtn)
    self._rideBtn = rideBtn



    self:makeTabList()
    self:updateTabList()
    self:showShareBtn()

    self:updateButtonState()
end

function PetAttrView:updateButtonState()
    
    local petRoleAttribute = self.curPet:getPetRoleAttribute()
    local canRide = self.curPet:canRide()
    -- if petRoleAttribute ~= "" then
    if canRide then
        self._rideBtn:show()
        self._onlineBtn:show()
        self._onlineBtn:centerBottom(20,-100)
        self._rideBtn:centerBottom(20,85)

        local isRide = MasterDataManager:getPetRidingState()--self.curPet:isRide()
        if not isRide then
            self._rideBtn:setText(UI.TEXT_1327000)
        else
            self._rideBtn:setText(UI.TEXT_1327001)
        end

        -- local captain = RoleDataManager:getCaptain()
        local captain = MasterDataManager:getCaptainPet()
        if not self.curPet:isFight() or tonumber(self.curPet:getId()) ~= tonumber(captain.petInstId) then
            self._rideBtn:disable()
            self._rideBtn:setText(UI.TEXT_1327000)
        else
            self._rideBtn:enable()
        end

    else
        self._rideBtn:hide()
        self._onlineBtn:show()
        self._onlineBtn:centerBottom(20)
    end
end

function PetAttrView:selectPetUpdate(listIdx)
    local selectPet = MasterDataManager:getBagPets()[listIdx]
    if not selectPet then
        return
    end
    self.curPet = selectPet

    self.baseAttrLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showBaseAttr()

        self:updateTabList()
    end, 0)

    --更新出战或骑乘按钮状态和位置
    self:updateButtonState()
end

function PetAttrView:levelupOver()
    self.baseAttrLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showBaseAttr()

        self:updateTabList()
    end, 0)
end

function PetAttrView:reincarnationOver()
    self:refreshPetBagData()
    self.baseAttrLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showBaseAttr()

        self:updateTabList()
    end, 0)
end

function PetAttrView:changeSkinOver()
    -- self:refreshPetBagData()
    self.baseAttrLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showBaseAttr()

        -- self:updateTabList()
    end, 0)
end

-- 分享按钮
function PetAttrView:showShareBtn()
        
    local shareBg = UI.Image:create()
    shareBg:init("ui_pets_sharebg.png")
    shareBg:rightBottom(-73, -30)
    self:addChild(shareBg, 999)

    local shareBtn = UI.SharePanel:create(handler(self, self.shareClick), PublicDefine.SHARE_MODULE.SHARE_MODULE_PET, true)
    shareBtn:rightBottom(-80, -30)
    self:addChild(shareBtn, 1000)

end

function PetAttrView:shareClick(platform)

    local share = UI.PetShareView:create()
    share:init(self.curPet, platform)
    self:addChild(share)
    
end

function PetAttrView:makeTabList()
    local baseAttrLayer = UI.Layout:create();
    baseAttrLayer:init()
    baseAttrLayer:setSize(386, 436)
    baseAttrLayer:centerBottom(0)
    -- baseAttrLayer:enableDebugDraw()
    self.contentLayout:addChild(baseAttrLayer, 2)
    self.baseAttrLayer = baseAttrLayer
    self:showBaseAttr()

    local skillAttrLayer = UI.Layout:create();
    skillAttrLayer:init()
    skillAttrLayer:setSize(386, 436)
    skillAttrLayer:centerBottom(2000)
    self.contentLayout:addChild(skillAttrLayer, 2)
    self.skillAttrLayer = skillAttrLayer
    self:showSkillQuality()

    local equipmentLayer = UI.Layout:create();
    equipmentLayer:init()
    equipmentLayer:setSize(386, 436)
    equipmentLayer:centerBottom(2000)
    self.contentLayout:addChild(equipmentLayer, 2)
    self.equipmentLayer = equipmentLayer
    self:showEquipmentBag()

    self.tabData = {}
    self.curTabIndex = 1
    self.lastTabIndex = 1

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1213612
    tab1.select = true
    tab1.showLayer = function()
        self.tabSelect1:show()
        self.baseAttrLayer:centerBottom(0)
    end
    tab1.hideLayer = function()
        self.tabSelect1:hide()
        self.baseAttrLayer:centerBottom(2000)
    end

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_1213613
    tab2.select = false
    tab2.showLayer = function()
        self.tabSelect2:show()
        self.skillAttrLayer:centerBottom(0)
    end
    tab2.hideLayer = function()
        self.tabSelect2:hide()
        self.skillAttrLayer:centerBottom(2000)
    end

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_1325900
    tab3.select = false
    tab3.showLayer = function()
        self.tabSelect3:show()
        self.equipmentLayer:centerBottom(0)
    end
    tab3.hideLayer = function()
        self.tabSelect3:hide()
        self.equipmentLayer:centerBottom(2000)
    end

    table.insert(self.tabData, tab1)
    table.insert(self.tabData, tab2)
    table.insert(self.tabData, tab3)
end

function PetAttrView:hasShowPetEquipment()
    if(self.curTabIndex == 3) then 
        return true
    end

    return false
end

function PetAttrView:updateTabList(idx)
    if idx then
        self.curTabIndex = idx

        if self.tabData[self.lastTabIndex] then
            self.tabData[self.lastTabIndex].select = false
        end

        self.tabData[self.curTabIndex].select = true
        self.lastTabIndex = self.curTabIndex
    end

    for _, v in ipairs(self.tabData) do
        if v.select then
            v.showLayer()
        else
            v.hideLayer()
        end
    end
end

function PetAttrView:showBaseAttr()
    local maxLvLayer = UI.Layout:create();
    maxLvLayer:init()
    maxLvLayer:setSize(374, 38)
    maxLvLayer:centerUp(-4)
    self.baseAttrLayer:addChild(maxLvLayer)

    local maxLvIcon  = UI.Image:create();
    maxLvIcon:init("symbol_pets_levelcap.png");
    maxLvIcon:floatLeft(15);
    maxLvLayer:addComponent(maxLvIcon);

    local levelMaxLimitStr = string.format(UI.TEXT_1213717, self.curPet.maxLV)
    if tonumber(self.curPet:getReincarntionLv()) > 0 then
        local reincarnationConfig = self:getReincarntionInfo()
        levelMaxLimitStr = string.format(UI.TEXT_224306, self.curPet:getReincarntionLv(), self.curPet:getMaxLevelLimit() - reincarnationConfig.value)
        --levelMaxLimitStr = string.format("等级上限：%d转%d级", self.curPet:getReincarntionLv(), self.curPet:getLevel() - reincarnationConfig.value)
    end
    local nameLevelTxt = UI.Text:create()
    nameLevelTxt:init(levelMaxLimitStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    --nameLevelTxt:init(string.format(UI.TEXT_1213717, self.curPet.maxLV), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    nameLevelTxt:floatLeft(5)
    maxLvLayer:addComponent(nameLevelTxt)

    local expLayer = UI.Layout:create();
    expLayer:init()
    expLayer:setSize(374, 38)
    expLayer:centerUp(25)
    -- expLayer:enableDebugDraw()
    self.baseAttrLayer:addChild(expLayer)

    local expIcon  = UI.Image:create();
    expIcon:init("symbol_gaming_xp_cn.png");
    expIcon:floatLeft(15);
    expLayer:addComponent(expIcon);

    local nameTxt = UI.Text:create()
    nameTxt:init(UI.TEXT_1213618, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    nameTxt:floatLeft(5)
    expLayer:addComponent(nameTxt)

    local expTxt = UI.Text:create()
    local expStr = ""
    local curLv = self.curPet:getLevel()
    if curLv >= tonumber(self.curPet.maxLV) then
        expStr = "MAX"
    else
        local cfg = ConfigManager:getPetExpByID(curLv)
        local curLvMaxExp = 0
        if cfg then
            curLvMaxExp = cfg.expToNextLV
        end
        expStr = string.format("%d/%d", self.curPet:getCurExp(), curLvMaxExp)
    end
    expTxt:init(expStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    expTxt:floatLeft(5)
    expLayer:addComponent(expTxt)

    local levelUpTip  = UI.Image:create();
    levelUpTip:init("ui_pets_optimization_bubble.png");
    levelUpTip:centerRight(-10, -35)
    expLayer:addChild(levelUpTip);
    -- self.levelUpTip = levelUpTip
    local roleLv = RoleDataManager:getMaster():getLevel()
    local petLv = self.curPet:getLevel()
    local limitLvStr = ConfigManager:getGeneralForKey("petLevelBreakthrough")
    local limitLvList = string.split(limitLvStr, ",")
    local limitLv = tonumber(limitLvList[1])
    if roleLv == limitLv and petLv == limitLv and petLv < self.curPet.maxLV then
        levelUpTip:setVisible(true)
    else
        levelUpTip:setVisible(false)
    end
    

    local levelUpTxt = UI.Text:create()
    levelUpTxt:init(UI.TEXT_224015, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    levelUpTxt:centerUp(2)
    levelUpTip:addChild(levelUpTxt)

    -- 宠物进阶提示
    if self:showReincarnationBtn() then
        local st1 = "ui_reincarnation_role_btn2.png"
        local st2 = "ui_reincarnation_role_btn2_select.png"
        local advanceButton = UI.Button:create()
        advanceButton:init(st1, st2)
        advanceButton:setText(UI.TEXT_224300)
        advanceButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        advanceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local reincarnationConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()) + 1)
            local stars = self.curPet:getStarLv()
            if stars >= reincarnationConfig.advancedStars then
                mvc.openPanel("PetReincarnation", "PetReincarnation", self.curPet:getId())
            else
                UI.ScrollBar:createByText(UI.TEXT_1325902)
            end
        end)
        advanceButton:centerRight(16)
        expLayer:addChild(advanceButton)
    else
        local addExpButton = UI.Button:create()
        addExpButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
        addExpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local pills = mvc.petModel:getAllExpPill()
            local totalNum = 0
            for k, v in ipairs(pills) do
                local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(v.id, true, true)
                totalNum = totalNum + pillNum
            end

            if totalNum == 0 then
                UI.ScrollBar:createByText(UI.TEXT_1213679)
                return
            end

            if self.curPet:getLevel() >= tonumber(self.curPet.maxLV) then
                UI.ScrollBar:createByText(UI.TEXT_1213619)
                return
            end

            local checkLv = mvc.petModel:getMaxLevelLimit()
            if self.curPet:getLevel() >= checkLv then
                UI.ScrollBar:createByText(UI.TEXT_1213620)
                return
            end

            mvc.openPanel("Pet", "PetAddExp", self.curPet:getId())
        end)
        addExpButton:centerRight(16)
        expLayer:addChild(addExpButton)
    end

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(364, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setPosition(364/2, 0)
    expLayer:addChild(splitLine, 10)

    -- 属性内容
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(386, 283)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(0, 67)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.BLACK)
    scrollView:setCircleVisible(false)
    scrollView:setName("AttrSV")
    -- scrollView:enableDebugDraw()

    scrollView:addInnerNode(scrollContent)
    self.baseAttrLayer:addChild(scrollView)
    scrollView:scrollToTop()

    self:assembleBaseAttr()
    for k, v in ipairs(self.attrData) do
        local oneBaseAttr = self:addOneBaseAttr(v)
        scrollContent:addChild(oneBaseAttr)
    end

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(364, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(364/2, 176))
    scrollContent:addChild(lineUpImage)

    for k, v in ipairs(self.otherAttrData) do
        local oneExtraAttr = self:addOneExtraAttr(v)
        scrollContent:addChild(oneExtraAttr)
    end

    scrollContent:setSize(386, 450)

    -- 显示是否可以突破等级上限
    if self:showBreakLevelBtn() then
        st1 = "ui_reincarnation_role_btn2.png"
        st2 = "ui_reincarnation_role_btn2_select.png"
        local breakLevelButton = UI.Button:create()
        breakLevelButton:init(st1, st2)
        breakLevelButton:closeClickScale()
        breakLevelButton:setText(UI.TEXT_224309)
        breakLevelButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        breakLevelButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            local nowConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
            local breakItemList = string.split(nowConfig.lvBreakthroughItemId, ",")
            local haveNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(breakItemList[1]), true, true)
            local useNum = tonumber(breakItemList[2])

            -- 策划还没配突破需要的材料，这里暂时注释
            -- 材料不足显示
            if haveNum < useNum then
                UI.ScrollBar:createByText(UI.TEXT_224307)
                return
            end

            mvc.openPanel("Pet", "PetBreakLevelLimit", self.curPet:getId())
        end)
        breakLevelButton:center(130, 0)
        nameLevelTxt:addChild(breakLevelButton)
    end
    -----------------------

    local mask  = UI.Image:create();
    mask:init("ui_pets_attribute_mask.png");
    mask:leftBottom(-1, 80);
    self.baseAttrLayer:addChild(mask);
end

function PetAttrView:assembleBaseAttr()
    self.attrData = mvc.petModel:getAllBaseAttr(self.curPet)
    self.otherAttrData = {}

    -- 横线以下的内容
    self.criticalParameter = tonumber(ConfigManager:getGeneralForKey("criticalParameter"))          --暴击等级换算成暴击率的系数，暂取7000
    self.physicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter"))   --物理穿透换算成物理穿透率的系数，暂取7000
    self.dodgeParameter = tonumber(ConfigManager:getGeneralForKey("dodgeParameter"))             --闪避等级换算成闪避率的系数，暂取7000
    self.blockParameter = tonumber(ConfigManager:getGeneralForKey("blockParameter"))             --格挡等级换算成格挡率的系数，暂取7000
    self.magicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter"))

    local xArr1 = {6, 6, 6, 6, 6}
    local yArr1 = {278, 308, 338, 368, 398}
    local names = {UI.TEXT_DES_BLOAK_LEVEL, UI.TEXT_DES_PENETRATE,
        UI.TEXT_DES_MAGIC_PENETRATE, UI.TEXT_DES_DODGE, UI.TEXT_DES_CRITICAL}
    local tipTxt = {UI.TEXT_1213734, UI.TEXT_1213736, UI.TEXT_1213737, UI.TEXT_1213739, UI.TEXT_1213738,}
    local otherValues = {}
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("block"), self.blockParameter)) -- 格挡
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("physicPenetrate"), self.physicPenetrateParameter)) -- 物理穿透
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("magicPenetrate"), self.magicPenetrateParameter)) -- 魔法穿透
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("dodge"), self.dodgeParameter)) -- 闪避
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("critical"), self.criticalParameter)) -- 暴击

    for k, v in ipairs(names) do
        local oneAttr = {}
        oneAttr.x = xArr1[k]
        oneAttr.y = yArr1[k]
        oneAttr.name = v
        oneAttr.val = otherValues[k]
        oneAttr.tipTxt = tipTxt[k]

        table.insert(self.otherAttrData, oneAttr)
    end
end

function PetAttrView:addOneBaseAttr(data)
    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(175, 32)
    innerLayer:leftUp(data.x, data.y)
    innerLayer:setTouchEnable(true)
    innerLayer:setInterceptTouches(false)
    innerLayer:setSwallowTouches(false)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        local pos = innerLayer:convertToNodeSpace(touchPosition)
        local size = innerLayer:getContentSize()
        local offsetIdxX = data.idx <= 8 and 0 or 1
        local offsetIdxY = data.idx % 8
        if offsetIdxY == 0 then
            offsetIdxY = 8
        end
        local rect = cc.rect(data.x-offsetIdxX*180, data.y-(offsetIdxY-1)*34, size.width, size.height)
        if cc.rectContainsPoint(rect, pos) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, self.tipRevert, data.tipTxt)
        end
    end)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)

    local attrIcon  = UI.Image:create();
    attrIcon:init(data.icon);
    attrIcon:centerLeft(15);
    innerLayer:addChild(attrIcon);

    local attrVal = UI.Text:create()
    attrVal:init(tostring(data.val), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    attrVal:centerLeft(48)
    innerLayer:addChild(attrVal)

    return innerLayer
end

function PetAttrView:addOneExtraAttr(data)
    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(370, 32)
    innerLayer:leftUp(data.x, data.y)

    local attrType = UI.Text:create()
    attrType:init(data.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_91_47_7)
    attrType:centerLeft(16)
    innerLayer:addChild(attrType)

    local attrVal = UI.Text:create()
    attrVal:init(tostring(data.val), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    attrVal:centerLeft(192)
    innerLayer:addChild(attrVal)

    return innerLayer
end

function PetAttrView:showSkillQuality()
    -- 资质部分
    local qualityLayer = UI.PetQualityLayer:create()
    qualityLayer:init(self.curPet:getId())
    qualityLayer:leftUp(20, 0)
    self.skillAttrLayer:addChild(qualityLayer, 1)

    -- 技能
    local skillBG  = UI.Image:create()
    skillBG:init("ui_pets_skill_paper.png")
    skillBG:leftBottom(3, 76)
    self.skillAttrLayer:addChild(skillBG, 2)

    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:init(self.curPet:getId())
    skillLayer:leftUp(0, 0)
    skillBG:addChild(skillLayer, 1)
end

function PetAttrView:wearEquipmentResult()
    self:refreshPetBagData()
    if(self.baseAttrLayer) then
        print("PetAttrView:wearEquipmentResult")
        self.baseAttrLayer:removeAllChildren()
        performWithDelay(self, function()
            self:showBaseAttr()

            self:updateTabList()
        end, 0.5)
    end
end

function PetAttrView:refreshPetBagData()
    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA)
    local dragRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_BAG)

    local data = {}
    data.havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(),PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    -- data.havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(),PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    for k,goodsData in pairs(data.havePetEquipmentArr) do
        goodsData:setUseNum(0)
        if(repeatData and repeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(repeatData[goodsData:getEntityID()])
        end

        if(dragRepeatData and dragRepeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(dragRepeatData[goodsData:getEntityID()])
        end
    end

    local use = #data.havePetEquipmentArr
    local maxNum = 50
    if(use > maxNum)then 
        maxNum = use
    end
    local row,low = math.modf(maxNum/5)
    if(low > 0) then 
        maxNum = (row + 1) * 5
    end
    -- print("refreshPetBagData", maxNum, use)
    data.packetBoxBeUseNum = maxNum
    data.packetBoxMaxNum = maxNum
    if(self._bagGridList) then
        self._bagGridList:setData(data, false)
        self._bagGridList:showAllGoods()
    end
    print("refreshPetBagData")
    self._bagData = data
end

function PetAttrView:showEquipmentBag()
    -- 
    self:refreshPetBagData()
    local bagList = UI.GoodsListNew:create(5)
    self._bagGridList = bagList
    bagList:init(self._bagData, 358)
    bagList:setPos(-20, -60)
    bagList:enableDoubleClick()
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:setCallbackForGridDoubleClick(self, self.bagGridDoubleClickHandler)
    -- bagList:setDoubleClickAsDragEnd(true)
    self.equipmentLayer:addChild(bagList, 4)
    bagList:showMask()
    bagList:hideBGImageCover()
    -- self.equipmentLayer:enableDebugDraw()
    -- bagList:enableDebugDraw()

    self:refreshPetBagData()
end

-- 关闭选中
function PetAttrView:closeChoese()
    if self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil 
    end
end

-- 装备详情的touch事件的处理
local function onInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    -- 更新装备对比区域数据
    if(not tolua.isnull(self._infoArea)) then
        self._infoArea:close()
        self._infoArea = nil
    end
    if (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

function PetAttrView:bagClickCallback(bagGrid)
    print("PetAttrView:bagClickCallback")
    if self._isDraging then 
        return 
    end
    if (DEBUG) then
        print(string.format("BagGoodsPanel:bagClickCallback: grid index:%d.", bagGrid:getIndex()))
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        if self._selectedBagGrid == bagGrid then 
            print("===关闭详情页面")
            self:closeChoese()
        else
            -- 把上次点击的关闭
            print("==不是上次点击的格子")
            if self._selectedBagGrid then 
                self._selectedBagGrid:hideSelect()
                self._selectedBagGrid = nil 
            end

            if  self._selectedRoleGrid then 
                self._roleShowArea:unselectEquipment()
                self._selectedRoleGrid = nil 
            end

            if goodsData then 
                if goodsData:getIsNew() then
                    -- 如果是新物品，发送消息
                    GameManager:bagClickGoodsHandler(goodsData)
                end
                bagGrid:showSelect()
                local leftX = -274-20
                local worldPos = self.contentLayout:convertToWorldSpace(cc.p(0,0))
                local rightX =  winSize.width - worldPos.x - 20

                -- 类型
                if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                    -- 装备详情
                    local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                    self._infoArea = equipmentInfoArea
                    local oldEquipmentData = nil
                    if(self.curPet) then 
                        oldEquipmentData = self.curPet:getWearEquipmentForEquipType(goodsData:getEquipmentType())
                    end
                    equipmentInfoArea:showCompInfo()
                    equipmentInfoArea:updateInfo(goodsData, oldEquipmentData, true)
                end 
                if self._infoArea then
                    local worldPos = bagGrid:convertToWorldSpace(cc.p(0,0))
                    if worldPos.x < winSize.width/2 then
                        self._infoArea:centerLeft(worldPos.x + bagGrid:getSize() + 20)
                    else
                        self._infoArea:centerLeft(worldPos.x - bagGrid:getSize() - 20)
                    end
                    self._infoArea:centerRight(rightX - 5)
                    UI.UIManager:addToRootNode(self._infoArea,UI_ZORDER.EQUIPMENTINFO)
                    self._infoArea:setGoodsGrid(bagGrid)
                    
                    self._infoArea:setVisible(true)
                    self._infoArea:updateView(goodsData)
                    self._infoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onInfoAreaTouchHandler)
                end
            end
            self._selectedBagGrid = bagGrid
        end
    end
end

function PetAttrView:changeInSideStatus(inSide)
    if(self._bagGridList) then 
        self._bagGridList:changeInSideStatus(inSide)
    end
end

function PetAttrView:bagDragBeganCallback(goodsGrid, touchPosition)
    self._isDraging = true
    if (self._targetForDragBegan and self._functionForDragBegan) then
        if(goodsGrid) then
            local bagGridData = goodsGrid:getData()
            if (bagGridData and bagGridData:getIsNew()) then
                GameManager:bagClickGoodsHandler(bagGridData)
            end
        end

        self._functionForDragBegan(self._targetForDragBegan, goodsGrid, touchPosition)
    end
end

function PetAttrView:bagDragMovedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragMovedCallback")
    if(self._enableDragStatus) then 
        local pos = self:convertToNodeSpace(touchPosition)
        local size = self:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)
        self:changeInSideStatus(not inSide)
    end

    if (self._targetForDragMoved and self._functionForDragMoved) then
        self._functionForDragMoved(self._targetForDragMoved, goodsGrid, touchPosition)
    end
end

function PetAttrView:bagDragEndedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragEndedCallback")
    if(self._deleteState) then
        return
    end
    self._isDraging = false
    if (self._targetForDragEnded and self._functionForDragEnded) then 
        Avalon.AudioManager:playSound("1505")
        self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition, self:isPositionInBag(touchPosition))
    end
end

-- 双击背包格子
function PetAttrView:bagGridDoubleClickHandler(bagGrid, touchPosition)
    -- 如果在删除状态，不能使用道具
    if (self._deleteState) then return end
    local goodsData = bagGrid:getData()
    local canUse = bagGrid:canUse()

    if (goodsData) then
        if CONFIG_DOUBLIE_CLICK and (goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            -- if (self._targetForDragEnded and self._functionForDragEnded) then 
            --     Avalon.AudioManager:playSound("1505")
            --     self._functionForDragEnded(self._targetForDragEnded, bagGrid, touchPosition, true)
            -- end
        end
    else
        if (DEBUG) then
            print(string.format("RolePanel bagGridDoubleClickHandler: no goods data found for index %d.", bagGrid:getIndex()))
        end
    end
end


function PetAttrView:isPositionInBag(touchPosition)
    local pos = self:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, self._width, self._height)
    local isInBag = cc.rectContainsPoint(rect, touchPosition)
    return isInBag;
end

-- 添加拖拽格子开始的处理回调函数
function PetAttrView:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function PetAttrView:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function PetAttrView:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end


function PetAttrView:getParames(value, valueParameter)
    local newValue = value or 0
    valueParameter = valueParameter or 0

    local str = ""
    if(newValue == 0) then
        str = string.format("0%%")
    else 
        local yu = (newValue * 100/valueParameter)
        -- 这里的效率不好
        local zero = tonumber(string.format("%.0f",yu))
        local one = tonumber(string.format("%.1f",yu))
        local two = tonumber(string.format("%.2f",yu))
        if(zero == one) then
            if(one == two) then
                str = zero
            else 
                str = two
            end
        else 
            if(one == two) then
                str = one
            else 
                str = two
            end
        end 

        str = string.format("%s%%", str)
    end

    return str
end

function PetAttrView:showReincarnationBtn()
    -- 宠物进阶提示
    print("宠物进阶提示---->: ",self.curPet:getReincarntionLv())
    local reincarnationConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()) + 1)
    local minReincarnationLv = 0
    if reincarnationConfig then
        minReincarnationLv = reincarnationConfig.value
    end
    if minReincarnationLv == self.curPet:getLevel() then
        return true
    end

    return false
end

function PetAttrView:showBreakLevelBtn()
    -- 获取宠物在ProfilePetReincarnation表中的信息
    local detailConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
    local maxLvMit = detailConfig.maxLevel
    local curLvMit = self.curPet:getMaxLevelLimit()

    if curLvMit >= maxLvMit then
        return false
    end

    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    if petCfg.is_CanBreakthrough ~= 1 then
        return false
    end

    return true
end

function PetAttrView:getReincarntionInfo()
    -- 获取宠物在ProfilePetReincarnation表中的信息
    local detailConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
    return detailConfig
end

function PetAttrView:breakSuccess(data)
    local nowPet = MasterDataManager:getBagPetById(data.petId)
    local nowLevelLimit = nowPet:getMaxLevelLimit()
    -- --  这里会在refreshData里自动更新到最新的宠物等级上限。
    -- print("PetAttrView:breakSuccess----->petId:  ", data.petId)
    -- print("PetAttrView:breakSuccess----->:  ", nowLevelLimit)
    self.baseAttrLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showBaseAttr()
        UI.ScrollBar:createByText(UI.TEXT_1213607.."!")
        --self:updateTabList()
    end, 0)
end

function PetAttrView:bindModel()

end

function PetAttrView:unbindModel()

end

return PetAttrView
