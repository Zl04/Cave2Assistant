------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTrainView = class("PetTrainView", UI.BaseWin)

local GameDataManager = require("app.game.GameDataManager")

require "app.modules.pet.PetTrainSkillBookCell"
require "app.modules.pet.PetQualityLayer"
require "app.modules.pet.PetSkillLayer"
require "app.modules.pet.PetSkillBookInfoArea"
require "app.modules.pet.PetBuyRebornItem"
require "app.modules.pet.PetAddTalentPointLayer"

local SceneManager = require("app.game.SceneManager")

UI = UI or {}

UI.PetTrainView = PetTrainView

-- 资源
local COM_RES_LIST = {
    "ui_common_grid.plist",
    "ui_common_btn.plist",
    "ui_common_information.plist",
    "ui_gaming_choice.plist",
    "ui_common_scale9image.plist",
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetTrainView:ctor()
    PetTrainView.super.ctor(
    	self,
    	UI.Type.PET_TRAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REBORN_OK, self, self.rebornOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_RAISE_QUALITY_OK, self, self.raiseQualityOver)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.learnSkillOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_BUY_REBORNITEM_OK, self, self.buyOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_STOP_ONE_KEY_REBORN, self, self.stopOneKeyRebornFun)
end

function PetTrainView:init(petID, innerTabIdx, ... )
    self.curPet = MasterDataManager:getBagPetById(petID)
    self.innerTabIdx = innerTabIdx or 1

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetTrainView.super.init(self, ... )
end

function PetTrainView:dtor()
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.onekeyRebornSchedule)

    self.netBlocking = false

    PetTrainView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REBORN_OK, self, self.rebornOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_RAISE_QUALITY_OK, self, self.raiseQualityOver)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.learnSkillOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_BUY_REBORNITEM_OK, self, self.buyOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_STOP_ONE_KEY_REBORN, self, self.stopOneKeyRebornFun)

    reload_script_file_mvc("app.modules.pet.PetTrainView")
end

function PetTrainView:buyOver()
    -- self.rebornLayer:removeAllChildren()
    self:showReborn()
end

function PetTrainView:stopOneKeyRebornFun()
    self.stopOneKeyReborn = true
end

function PetTrainView:selectPetUpdate(petListIdx)
    self.curPet = MasterDataManager:getBagPets()[petListIdx]

    if self.curPet.isVariant then
        self:hideOneKeyOpt()
    else
        self:showOneKeyOpt()
    end

    if self.onekeying then
        self.onekeying = false
    end

    self.stopOneKeyReborn = true


    self:updateRebornConsumeShow()
    self:updateRebornBtnShow()
    self:updateHighQualityShow()

    -- if self.learnSkillLayer and self.learnSkillLayer:isVisible() then
    --     self.skillbookList:setData(self:getBookList())
    -- end

    -- self.raiseQualityLayer:removeAllChildren()
    performWithDelay(self, function()
        if self.raiseQualityLayer then
            self:showRaiseQuality()
        end

        if self.talentPointLayer then
            self:showAddTalentPoint()
        end
    end, 0)
end

function PetTrainView:rebornOver(data)
    if not self or tolua.isnull(self) then
        return
    end

    self.netBlocking = false

    if data.isVariant then
        -- 出现变异宠物，弹出宠物结算界面
        mvc.openPanel("Pet", "PetResultShow", {showType = 3, eggType = 1, id = self.curPet:getId()})

        if self.onekeying then
            self.onekeyReborn = false
            self.onekeying = false
            self:hideOneKeyOpt()
        end
    end

    UI.ScrollBar:createByText(UI.TEXT_1213658)

    -- self.rebornLayer:removeAllChildren()
    -- self.raiseQualityLayer:removeAllChildren()
    -- self.learnSkillLayer:removeAllChildren()

    performWithDelay(self, function()
        if self.rebornLayer then
            self:showReborn()
        end

        if self.raiseQualityLayer then
            self:showRaiseQuality()
        end

        if self.talentPointLayer then
            self:showAddTalentPoint()
        end
    end, 0)
end

function PetTrainView:raiseQualityOver(data)
    if not self or tolua.isnull(self) then
        return
    end

    self.netBlocking = false

    self:assembleQuality()

    local idx = 0
    for k, v in ipairs(self.qualityData) do
        if v.type == data.talentType then
            idx = k
            break
        end
    end

    local afterData = self.qualityData[idx]
    self.qualityAttrAfter = clone(afterData)
    self.qualityAttrAfter.effectAttr = self:getAllEffAttrStr(afterData.type)

    -- self.raiseQualityLayer:removeAllChildren()
    performWithDelay(self, function()
        self:showRaiseQuality()
    end, 0)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SHOW_RAISE_QUALITY_RET, self.qualityAttrBefore, self.qualityAttrAfter)

    local qualityLayer = self.rebornLayer:getChildByName("QualityLayer")
    if qualityLayer then
        -- self.rebornLayer:removeChildByName("QualityLayer")
        qualityLayer:show()
        qualityLayer:updateToShow(self.curPet:getId())
    else
        qualityLayer = UI.PetQualityLayer:create()
        qualityLayer:init(self.curPet:getId())
        qualityLayer:leftUp(20, 0)
        qualityLayer:setName("QualityLayer")
        self.rebornLayer:addChild(qualityLayer, 1);
    end

end

function PetTrainView:learnSkillOver()
    if not self or tolua.isnull(self) then
        return
    end

    self.netBlocking = false

    -- self.rebornLayer:removeAllChildren()
    -- self.learnSkillLayer:removeAllChildren()

    performWithDelay(self, function()
        if self.rebornLayer then
            self:showReborn()
        end

        if not self.talentPointLayer then
            self:showAddTalentPoint()
        end
        -- self:showLearnSkill()
    end, 0)
end

function PetTrainView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 顶部按钮条
    -- 背景图片
    local titleBG  = UI.Image:create();
    titleBG:init("ui_pets_cultivate_btn_0.png");
    titleBG:centerUp(10);
    contentLayout:addChild(titleBG, 1);

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
    select3:leftUp(275, 1);
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

        self.stopOneKeyReborn = true

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

        self.stopOneKeyReborn = true

        self:updateTabList(3)
    end)
    titleBG:addChild(touchLayer3)

    local tabTxt1 = UI.Text:create()
    tabTxt1:init(UI.TEXT_1213659, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
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
    tabTxt2:init(UI.TEXT_1213660, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
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
    tabTxt3:init(UI.TEXT_224000, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w3 = tabTxt3:getContentSize().width
    tabTxt3:setWidth(138)
    tabTxt3:setTextCenter()
    tabTxt3:autoAdapt()
    if w3 > 138 then
        tabTxt3:leftUp(274, 0)
    else
        tabTxt3:leftUp(274, 8)
    end
    tabTxt3:setLineSpacing(-6)
    titleBG:addChild(tabTxt3)

    self:makeTabList()
    self:updateTabList(self.innerTabIdx)

    self.innerTabIdx = nil


end

function PetTrainView:makeTabList()
    -- local rebornLayer = UI.Layout:create();
    -- rebornLayer:init()
    -- rebornLayer:setSize(386, 436)
    -- rebornLayer:centerBottom(0)
    -- -- rebornLayer:enableDebugDraw()
    -- self.contentLayout:addChild(rebornLayer, 2)
    -- self.rebornLayer = rebornLayer
    self.onekeyReborn = false
    self.onekeying = false
    -- self:showReborn()

    -- local raiseQualityLayer = UI.Layout:create();
    -- raiseQualityLayer:init()
    -- raiseQualityLayer:setSize(386, 436)
    -- raiseQualityLayer:centerBottom(2000)
    -- self.contentLayout:addChild(raiseQualityLayer, 2)
    -- self.raiseQualityLayer = raiseQualityLayer
    self.curSelectQualityRaise = 1
    -- self:showRaiseQuality()

    -- local learnSkillLayer = UI.Layout:create();
    -- learnSkillLayer:init()
    -- learnSkillLayer:setSize(386, 436)
    -- learnSkillLayer:centerBottom(2000)
    -- self.contentLayout:addChild(learnSkillLayer, 2)
    -- self.learnSkillLayer = learnSkillLayer

    self.tabData = {}
    self.curTabIndex = self.innerTabIdx
    self.lastTabIndex = self.innerTabIdx

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1213659
    tab1.select = self.innerTabIdx == 1
    tab1.showLayer = function()
        self.tabSelect1:show()
        if not self.rebornLayer then
            self:showReborn()
        end
        self.rebornLayer:show()
        --self.rebornLayer:centerBottom(0)
    end
    tab1.hideLayer = function()
        self.tabSelect1:hide()
        if self.rebornLayer then
            self.rebornLayer:hide()
            --self.rebornLayer:centerBottom(2000)
        end
    end

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_1213660
    tab2.select = self.innerTabIdx == 2
    tab2.showLayer = function()
        self.tabSelect2:show()
        if not self.raiseQualityLayer then
            self:showRaiseQuality()
        end
        self.raiseQualityLayer:show()
        --self.raiseQualityLayer:centerBottom(0)
    end
    tab2.hideLayer = function()
        self.tabSelect2:hide()
        if self.raiseQualityLayer then
            self.raiseQualityLayer:hide()
            --self.raiseQualityLayer:centerBottom(2000)
        end
    end

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_224000
    tab3.select = self.innerTabIdx == 3
    tab3.showLayer = function()
        self.tabSelect3:show()
        -- if not self.learnSkillLayer then
        --     self:showLearnSkill()
        -- end
        -- self.learnSkillLayer:show()
        -- self.learnSkillLayer:centerBottom(0)
        if not self.talentPointLayer then
            self:showAddTalentPoint()
        end
        self.talentPointLayer:show()
        
    end
    tab3.hideLayer = function()
        self.tabSelect3:hide()
        -- if self.learnSkillLayer then
        --     self.learnSkillLayer:hide()
        --     -- self.learnSkillLayer:centerBottom(2000)
        -- end
        if self.talentPointLayer then
            self.talentPointLayer:hide()
            -- self.learnSkillLayer:centerBottom(2000)
        end
    end

    table.insert(self.tabData, tab1)
    table.insert(self.tabData, tab2)
    table.insert(self.tabData, tab3)
end

function PetTrainView:updateTabList(idx)
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

function PetTrainView:netLock()
    self.netBlocking = true

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        self.netBlocking = false
    end, 5)
end

-- 洗练重生
function PetTrainView:showReborn()
    self.canReborn = false
    self.rebornPillID = 0

    if not self.rebornLayer then
        local rebornLayer = UI.Layout:create();
        rebornLayer:init()
        rebornLayer:setSize(386, 436)
        rebornLayer:centerBottom(0)
        -- rebornLayer:enableDebugDraw()
        self.contentLayout:addChild(rebornLayer, 2)
        self.rebornLayer = rebornLayer
    end

    -- 资质部分
    local qualityLayer = self.rebornLayer:getChildByName("QualityLayer")
    if qualityLayer then
        qualityLayer:setVisible(true)
        qualityLayer:updateToShow(self.curPet:getId())
    else
        qualityLayer = UI.PetQualityLayer:create()
        qualityLayer:init(self.curPet:getId())
        qualityLayer:leftUp(20, 0)
        qualityLayer:setName("QualityLayer")
        self.rebornLayer:addChild(qualityLayer, 1);
    end

    -- 技能
    local skillBG  = self.rebornLayer:getChildByName("SkillBG")
    if not skillBG then
        skillBG  = UI.Image:create();
        skillBG:init("ui_pets_skill_paper.png");
        skillBG:leftBottom(3, 92);
        skillBG:setScaleY(0.87)
        skillBG:setName("SkillBG")
        self.rebornLayer:addChild(skillBG, 2);
    end

    local skillLayer  = self.rebornLayer:getChildByName("SkillLayer")
    if not skillLayer then
        local tableviewSize = {width = 380, height = 153}
        skillLayer = UI.PetSkillLayer:create()
        skillLayer:setTableViewSize(tableviewSize)
        skillLayer:init(self.curPet:getId())
        skillLayer:leftBottom(0, 91)
        skillLayer:setName("SkillLayer")
        self.rebornLayer:addChild(skillLayer, 3);
    else
        skillLayer:updateToShow(self.curPet:getId())
    end

    local selectBG  = self.rebornLayer:getChildByName("SelectBG")
    if not selectBG then
        selectBG = UI.Image:create()
        selectBG:init("ui_btn_choice_0.png")
        selectBG:setScaleX(0.7)
        selectBG:setScaleY(0.7)
        selectBG:leftBottom(0, 70)
        selectBG:setTouchEnable(true)
        selectBG:setName("SelectBG")
        self.rebornLayer:addChild(selectBG, 4)
        selectBG:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, com, touchPosition)
            local pos = selectBG:convertToNodeSpace(touchPosition)
            local size = selectBG:getContentSize()
            local rect = cc.rect(0, 0, size.width, size.height)
            if cc.rectContainsPoint(rect, pos) then
                if self.onekeyReborn then
                    self.onekeyReborn = false
                    self.onekeySelect:hide()
                else
                    self.onekeyReborn = true
                    self.onekeySelect:show()
                end

                local btnTxt = self.onekeyReborn and UI.TEXT_1213662 or UI.TEXT_1213663
                local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
                if rebornBtn then
                    self.rebornBtnTxt:setText(btnTxt)
                end
            end
        end)
        self.onekeySelectBG = selectBG
    end

    if not self.onekeySelect then
        local select = UI.Image:create()
        select:init("ui_btn_choice_1.png")
        select:leftBottom(6, 76)
        if not self.onekeyReborn then
            select:hide()
        end
        self.rebornLayer:addChild(select, 5)
        self.onekeySelect = select
    end

    if not self.onekeyTip then
        local tips = UI.Text:create()
        tips:init(UI.TEXT_1213664, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        tips:leftBottom(40, 78)
        self.rebornLayer:addChild(tips, 4)
        self.onekeyTip = tips
    end

    self:updateRebornConsumeShow()

    self:updateRebornBtnShow()

    if self.curPet.isVariant then
        self:hideOneKeyOpt()
    else
        self:showOneKeyOpt()
    end

    if not self.highQualityImg then
        local highQualityImg = UI.Image:create()
        highQualityImg:init("ui_pets_rare_box.png")
        highQualityImg:rightBottom(6, 240)
        highQualityImg:rotate(-21)
        self.rebornLayer:addChild(highQualityImg, 5)
        self.highQualityImg = highQualityImg
    end
    self.highQualityImg:hide()
    
    local highQualityTxt = self.highQualityImg:getChildByName("HighQualityTxt")
    if not highQualityTxt then
        highQualityTxt = UI.Text:create()
        highQualityTxt:init(UI.TEXT_1213755, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_120_34_21)
        highQualityTxt:setWidth(100)
        highQualityTxt:setTextCenter()
        highQualityTxt:autoAdapt()
        highQualityTxt:center(2, -3)
        highQualityTxt:setLineSpacing(-6)
        highQualityTxt:setName("HighQualityTxt")
        self.highQualityImg:addChild(highQualityTxt)
    end

    self:updateHighQualityShow()
end

function PetTrainView:showOneKeyOpt()
    if not self.rebornLayer then
        return
    end

    if self.onekeyReborn then
        self.onekeySelect:show()
    else
        self.onekeySelect:hide()
    end
    self.onekeySelectBG:show()
    self.onekeyTip:show()
end

function PetTrainView:hideOneKeyOpt()
    if not self.rebornLayer then
        return
    end

    self.onekeySelect:hide()
    self.onekeySelectBG:hide()
    self.onekeyTip:hide()

    local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
    if rebornBtn then
        self.rebornBtnTxt:setText(UI.TEXT_1213663)
    end
end

function PetTrainView:checkCanOneKeyReborn()
    if SceneManager:getInstance():isInFightScene() then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return false
    end

    -- 检查标记位
    if not self.onekeyReborn then
        local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
        if rebornBtn then
            self.rebornBtnTxt:setText(UI.TEXT_1213663)
        end
        return false
    end

    -- 变异宠物无法连续洗炼
    if self.curPet.isVariant then
        print("self.curPet.isVariant")
        return false
    end

    -- 检查材料
    local pillID = mvc.petModel:getAllRebornPill()[1]
    local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(pillID, true, true)
    if pillNum <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1213666)
        return false
    end

    return true
end

function PetTrainView:updateHighQualityShow()
    if not self.rebornLayer then
        return
    end

    if mvc.petModel:isHightQuality(self.curPet:getId()) then
        self.highQualityImg:show()
    else
        self.highQualityImg:hide()
    end
end

function PetTrainView:beginOneKeyReborn()
    if not self:checkCanOneKeyReborn() then
        self.onekeying = false
        return
    end

    if self.stopOneKeyReborn then
        self.stopOneKeyReborn = false
        self.onekeying = false
        self.onekeyReborn = false
        self.onekeySelect:hide()
        local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
        if rebornBtn then
            self.rebornBtnTxt:setText(UI.TEXT_1213663)
        end
        return
    end

    local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
    if rebornBtn then
        self.rebornBtnTxt:setText(UI.TEXT_1213667)
    end

    self:netLock()

    local pillID = mvc.petModel:getAllRebornPill()[1]
    local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(pillID, true, true)
    local rebornCostCfg = self.curPet.rebornCost
    local costNum = rebornCostCfg[1]
    Net.NetPetSystem:reborn(self.curPet:getId(), pillID, costNum)
    self.onekeying = true

    Avalon.Scheduler:scheduleUpdateOnce(self, self.onekeyRebornSchedule, 2)
end

function PetTrainView:onekeyRebornSchedule()
    if not self or tolua.isnull(self) then
        return
    end

    if not self.onekeyReborn then
        self.onekeying = false
        return
    end

    self:beginOneKeyReborn()
end

function PetTrainView:updateRebornConsumeShow()
    if not self.rebornLayer then
        return
    end

    self.canReborn = false
    self.rebornPillID = 0

    local rebornPills = mvc.petModel:getAllRebornPill()
    local rebornCostCfg = self.curPet.rebornCost
    local costNum = self.curPet.isVariant and rebornCostCfg[2] or rebornCostCfg[1]

    -- 洗炼丹
    local pillID = self.curPet.isVariant and rebornPills[2] or rebornPills[1]
    local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(pillID, true, true)
    if pillNum >= costNum then
        self.rebornPillID = pillID
        self.canReborn = true
    end

    self.rebornPillNum = costNum

    local goodsData = GoodsDataManager:createLocalGoodsData(pillID)

    -- 物品物品图标
    goodsData:setNum(pillNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false

    local pill = self.rebornLayer:getChildByName("RebornPill")
    if pill then
        -- self.rebornLayer:removeChildByName("RebornPill")
        pill:setData(goodsData)
        pill:onUpdateView()
    else
        pill = UI.GoodsGrid:create()
        pill:init(goodsData)
        self.rebornLayer:addChild(pill);
    end
    pill:leftBottom(0, 4)
    pill:showInfoArea(false, false)
    pill:setName("RebornPill")

    local txt = self.rebornLayer:getChildByName("ConsumeTxt")
    if txt then
        txt:setText(goodsData:getName())
    else
        local consumeTxt = UI.Text:create()
        consumeTxt:init(goodsData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        local w = consumeTxt:getContentSize().width
        if w > 160 then
            consumeTxt:leftBottom(74, 34)
        else
            consumeTxt:leftBottom(74, 42)
        end
        consumeTxt:setWidth(160)
        consumeTxt:setTextLeft()
        consumeTxt:autoAdapt()
        consumeTxt:setLineSpacing(-6)
        consumeTxt:setName("ConsumeTxt")
        self.rebornLayer:addChild(consumeTxt)
    end

    local num = self.rebornLayer:getChildByName("ConsumeNum")
    if num then
        if not self.canReborn then
            num:setText(UI.TEXT_1213668)
        else
            num:setText(string.format(UI.TEXT_1213669, costNum))
        end
    else
        local consumeNum = UI.Text:create()
        local showTxt = ""
        if not self.canReborn then
            showTxt = UI.TEXT_1213668
        else
            showTxt = string.format(UI.TEXT_1213669, costNum)
        end
        consumeNum:init(showTxt, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
        consumeNum:leftBottom(74, 6)
        consumeNum:setWidth(160)
        consumeNum:setTextLeft()
        consumeNum:autoAdapt()
        consumeNum:setLineSpacing(-6)
        consumeNum:setName("ConsumeNum")
        self.rebornLayer:addChild(consumeNum)
    end
end

function PetTrainView:updateRebornBtnShow()
    if not self.rebornLayer then
        return
    end
    
    local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
    if rebornBtn then
        rebornBtn:setTouchEnable(false)
        rebornBtn:setVisible(false)
        -- self.rebornLayer:removeChildByName("RebornBtn")
    end

    local addBtn = self.rebornLayer:getChildByName("AddBtn")
    if addBtn then
        addBtn:setTouchEnable(false)
        addBtn:setVisible(false)
        -- self.rebornLayer:removeChildByName("AddBtn")
    end

    if not self.canReborn then
        -- 更新加号
        if not addBtn then
            addBtn = UI.Button:create()
            addBtn:init("ui_btn_team_add_0.png","ui_btn_team_add_1.png","ui_btn_team_add_0.png");
            addBtn:rightBottom(0, 18);
            addBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                if SceneManager:getInstance():isInFightScene() then
                    UI.ScrollBar:createByText(UI.TEXT_1213665)
                    return
                end

                if not self.canReborn then
                    local winSize = cc.Director:getInstance():getWinSize()
                    local buyLayer = UI.PetBuyRebornItem:create()
                    buyLayer:init(self.curPet.isVariant)
                    buyLayer:center(-COM_WIDTH / 2, 0)
                    buyLayer:setName("buyLayer")
                    self:addChild(buyLayer, 10000)
                end
            end)
            addBtn:setName("AddBtn")
            self.rebornLayer:addChild(addBtn)
        end

        addBtn:setTouchEnable(true)
        addBtn:setVisible(true)
    else
        -- 洗炼按钮
        if not rebornBtn then
            rebornBtn = UI.Button:create();
            rebornBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png");
            rebornBtn:rightBottom(0, 18);

            rebornBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                if SceneManager:getInstance():isInFightScene() then
                    UI.ScrollBar:createByText(UI.TEXT_1213665)
                    return
                end
    
                if not self.canReborn then
                    local winSize = cc.Director:getInstance():getWinSize()
                    local buyLayer = UI.PetBuyRebornItem:create()
                    buyLayer:init(self.curPet.isVariant)
                    buyLayer:center(-COM_WIDTH / 2, 0)
                    self:addChild(buyLayer, 10000)
                    return
                end
    
                if self.onekeying then
                    self.onekeying = false
                    self.onekeyReborn = false
                    self.onekeySelect:hide()
    
                    local rebornBtn = self.rebornLayer:getChildByName("RebornBtn")
                    if rebornBtn then
                        if self.curPet.isVariant then
                            self.rebornBtnTxt:setText(UI.TEXT_1213662)
                        else
                            self.rebornBtnTxt:setText(UI.TEXT_1213663)
                        end
                    end
                    return
                end
    
                local itemData =  GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, self.rebornPillID, false, 0)
                if itemData:getIsLock() then
                    UI.ScrollBar:createByText(UI.TEXT_110030)
                    return
                end
    
                if self.onekeyReborn and not self.curPet.isVariant then
                    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                        UI.TEXT_1213670,
                        function()
                            self.stopOneKeyReborn = false
                            self:beginOneKeyReborn()
                        end
                    )
                else
                    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                        UI.TEXT_1213671,
                        function()
                            self:netLock()
    
                            Net.NetPetSystem:reborn(self.curPet:getId(), self.rebornPillID, self.rebornPillNum)
                        end
                    )
                end
            end)

            rebornBtn:setName("RebornBtn")
            self.rebornLayer:addChild(rebornBtn)
        end

        rebornBtn:setTouchEnable(true)
        rebornBtn:setVisible(true)

        local rebornBtnTxt = rebornBtn:getChildByName("RebornBtnTxt")
        if not rebornBtnTxt then
            rebornBtnTxt = UI.Text:create()
            rebornBtnTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
            rebornBtnTxt:center()
            rebornBtnTxt:setWidth(138)
            rebornBtnTxt:setTextCenter()
            rebornBtnTxt:autoAdapt()
            rebornBtnTxt:setLineSpacing(-6)

            rebornBtnTxt:setName("RebornBtnTxt")
            rebornBtn:addChild(rebornBtnTxt, 10)
        end
        self.rebornBtnTxt = rebornBtnTxt

        if not self.curPet.isVariant and self.onekeyReborn then
            if self.onekeying then
                rebornBtnTxt:setText(UI.TEXT_1213667)
            else
                rebornBtnTxt:setText(UI.TEXT_1213662)
            end
        else
            rebornBtnTxt:setText(UI.TEXT_1213663)
        end
    end
end

-- 资质加点
function PetTrainView:showAddTalentPoint()
    if not self.talentPointLayer then
        local talentPointLayer = UI.Layout:create();
        talentPointLayer:init()
        talentPointLayer:setSize(386, 436)
        talentPointLayer:centerBottom(0)
        -- talentPointLayer:enableDebugDraw()
        self.contentLayout:addChild(talentPointLayer, 2)
        self.talentPointLayer = talentPointLayer
    end

    -- 资质加点
    local talentPointView = self.talentPointLayer:getChildByName("talentPointView")
    if not talentPointView then
        talentPointView = UI.PetAddTalentPointLayer:create(self.curPet:getId())
        talentPointView:init() 
        talentPointView:leftUp(-20, 0)
        talentPointView:setName("talentPointView")
        self.talentPointLayer:addChild(talentPointView, 10);
    else
        talentPointView:updateToShow(self.curPet:getId())
    end
end

-- 资质突破
function PetTrainView:showRaiseQuality()
    self.raiseCellSelectTab = {}

    if not self.raiseQualityLayer then
        local raiseQualityLayer = UI.Layout:create();
        raiseQualityLayer:init()
        raiseQualityLayer:setSize(386, 436)
        raiseQualityLayer:centerBottom(0)
        self.contentLayout:addChild(raiseQualityLayer, 2)
        self.raiseQualityLayer = raiseQualityLayer
    end

    self:assembleQuality()

    for k, v in ipairs(self.qualityData) do
        self:composeQualityLayer(v)
    end

    if not self.qualityPillName then
        local pillName = UI.Text:create()
        pillName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        pillName:leftBottom(74, 40)
        pillName:setWidth(160)
        pillName:setTextLeft()
        pillName:autoAdapt()
        pillName:setLineSpacing(-6)
        self.raiseQualityLayer:addChild(pillName)
        self.qualityPillName = pillName
    end

    if not self.qualityPillDesc then
        local qualityDesc = UI.Text:create()
        qualityDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
        qualityDesc:setWidth(160)
        qualityDesc:setTextLeft()
        qualityDesc:autoAdapt()
        qualityDesc:setLineSpacing(-6)
        qualityDesc:leftBottom(74, 6)
        self.raiseQualityLayer:addChild(qualityDesc)
        self.qualityPillDesc = qualityDesc
    end

    self:updateQualityPillShow()

    self:qualityRaiseCellClick(self.curSelectQualityRaise)

    -- 使用按钮
    local useBtn = self.raiseQualityLayer:getChildByName("useBtn")
    if not useBtn then
        useBtn = UI.Button:create();
        useBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png");
        useBtn:rightBottom(0, 18);
        useBtn:setText(UI.TEXT_1213672)
        useBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if SceneManager:getInstance():isInFightScene() then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            local curData = self.qualityData[self.curSelectQualityRaise]
            if curData.plus >= curData.pillMax then
                UI.ScrollBar:createByText(UI.TEXT_1213673)
                return
            end

            local itemData =  GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, self.curQualityPillID, false, 0)
            if itemData:getIsLock() then
                UI.ScrollBar:createByText(UI.TEXT_110030)
                return
            end

            local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(self.curQualityPillID, true, true)
            if pillNum <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1213674)
                return
            end

            self:recordQualityAttrBefore(curData)

            self:netLock()

            Net.NetPetSystem:raiseQuality(self.curPet:getId(), self.curQualityPillID)
        end)
        useBtn:setName("useBtn")
        self.raiseQualityLayer:addChild(useBtn)
    end
end

function PetTrainView:recordQualityAttrBefore(curData)
    self.qualityAttrBefore = clone(curData)
    self.qualityAttrBefore.effectAttr = self:getAllEffAttrStr(curData.type)
end

function PetTrainView:getAllEffAttrStr(qualityType)
    local ATTR = PublicDefine.ATTR_TYPE
    local effectAttr = self.curPet:getAttrByTalent(qualityType)
    local attrs = {}
    for k, v in ipairs(effectAttr) do
        local oneAttr = {}
        if v == ATTR.hp then
            oneAttr.icon = "symbol_gaming_blood.png"
            oneAttr.str = tostring(self.curPet:getHp())
        elseif v == ATTR.atkMin then
            oneAttr.icon = "symbol_gaming_atk.png"
            oneAttr.str = tostring(self.curPet.atkMin)
        elseif v == ATTR.atkMax then
            attrs[#attrs].str = attrs[#attrs].str .. "-" .. self.curPet.atkMax
        elseif v == ATTR.magic then
            oneAttr.icon = "symbol_gaming_maggicatk.png"
            oneAttr.str = tostring(self.curPet.magic)
        elseif v == ATTR.physicDef then
            oneAttr.icon = "symbol_gaming_def.png"
            oneAttr.str = tostring(self.curPet.physicDef)
        elseif v == ATTR.magicDef then
            oneAttr.icon = "symbol_gaming_maggicdef.png"
            oneAttr.str = tostring(self.curPet.magicDef)
        elseif v == ATTR.atkFire then
            oneAttr.icon = "symbol_monsterattribute_fire_1.png"
            oneAttr.str = tostring(self.curPet.atkFire)
        elseif v == ATTR.atkWater then
            oneAttr.icon = "symbol_monsterattribute_water_1.png"
            oneAttr.str = tostring(self.curPet.atkWater)
        elseif v == ATTR.atkWood then
            oneAttr.icon = "symbol_monsterattribute_wood_1.png"
            oneAttr.str = tostring(self.curPet.atkWood)
        elseif v == ATTR.atkLight then
            oneAttr.icon = "symbol_monsterattribute_light_1.png"
            oneAttr.str = tostring(self.curPet.atkLight)
        elseif v == ATTR.atkDark then
            oneAttr.icon = "symbol_monsterattribute_dark_1.png"
            oneAttr.str = tostring(self.curPet.atkDark)
        elseif v == ATTR.defFire then
            oneAttr.icon = "symbol_monsterattribute_fire_2.png"
            oneAttr.str = tostring(self.curPet.defFire)
        elseif v == ATTR.defWater then
            oneAttr.icon = "symbol_monsterattribute_water_2.png"
            oneAttr.str = tostring(self.curPet.defWater)
        elseif v == ATTR.defWood then
            oneAttr.icon = "symbol_monsterattribute_wood_2.png"
            oneAttr.str = tostring(self.curPet.defWood)
        elseif v == ATTR.defLight then
            oneAttr.icon = "symbol_monsterattribute_light_2.png"
            oneAttr.str = tostring(self.curPet.defLight)
        elseif v == ATTR.defDark then
            oneAttr.icon = "symbol_monsterattribute_dark_2.png"
            oneAttr.str = tostring(self.curPet.defDark)
        end

        if v ~= ATTR.atkMax then
            table.insert(attrs, oneAttr)
        end
    end

    return attrs
end

function PetTrainView:assembleQuality()
    self.qualityData = {}

    local names = {UI.TEXT_1213633, UI.TEXT_1213635, UI.TEXT_1213637, UI.TEXT_1213639, UI.TEXT_1213634,  UI.TEXT_1213636,  UI.TEXT_1213638}
    local icons = {
        "ui_icon_talent_1.png", "ui_icon_talent_2.png", "ui_icon_talent_5.png", "ui_icon_talent_0.png",
        "ui_icon_talent_3.png", "ui_icon_talent_4.png", "ui_icon_talent_6.png", 
    }
    local qTypes = {}
    local prgs = {}
    local prgTxts = {}
    local plus = {}
    local pill = {}
    local pillMax = {}  -- 吃资质丹增量最大值

    local cfg = mvc.petModel:getTalentConfig(self.curPet.templateID, self.curPet.isVariant)
    local type = PublicDefine.PetTalentType
    -- 资质类型
    local cfgTypes = {}
    table.insert(cfgTypes, type.TPhysicAtk)
    table.insert(cfgTypes, type.TMagicAtk)
    table.insert(cfgTypes, type.TElement)
    table.insert(cfgTypes, type.TLife)
    table.insert(cfgTypes, type.TPhysicDef)
    table.insert(cfgTypes, type.TMagicDef)
    table.insert(cfgTypes, type.TResist)

    -- 初始资质最大值
    local valMax = {}
    table.insert(valMax, cfg.talent_atk[2])
    table.insert(valMax, cfg.talent_magicAtk[2])
    table.insert(valMax, cfg.talent_element[2])
    table.insert(valMax, cfg.talent_hp[2])
    table.insert(valMax, cfg.talent_physicDef[2])
    table.insert(valMax, cfg.talent_magicDef[2])
    table.insert(valMax, cfg.talent_elementDef[2])

    -- 当前资质
    local curVal = {}
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TElement))
    table.insert(curVal, self.curPet:getTalentByType(type.TLife))
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TResist))

    -- 额外增加资质(通过吃资质丹增加的)
    local plusVal = {}
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TElement))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TLife))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TResist))

    local plusLen = {}
    for k, v in ipairs(plusVal) do
        table.insert(plusLen, v/valMax[k]*116)
    end

    -- 资质丹id
    local pillIDs = mvc.petModel:getAllQualityPillID()
    local pillVal = {}
    table.insert(pillVal, pillIDs[type.TPhysicAtk])
    table.insert(pillVal, pillIDs[type.TMagicAtk])
    table.insert(pillVal, pillIDs[type.TElement])
    table.insert(pillVal, pillIDs[type.TLife])
    table.insert(pillVal, pillIDs[type.TPhysicDef])
    table.insert(pillVal, pillIDs[type.TMagicDef])
    table.insert(pillVal, pillIDs[type.TResist])

    -- 额外增加资质最大值
    local pillMaxVal = {}
    table.insert(pillMaxVal, cfg.extra_atk)
    table.insert(pillMaxVal, cfg.extra_magicAtk)
    table.insert(pillMaxVal, cfg.extra_element)
    table.insert(pillMaxVal, cfg.extra_hp)
    table.insert(pillMaxVal, cfg.extra_physicDef)
    table.insert(pillMaxVal, cfg.extra_magicDef)
    table.insert(pillMaxVal, cfg.extra_elementDef)

    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    local starLv, canLvUpNum = self.curPet:getStarLv()
    local growID, initID
    if self.curPet.isVariant then
        growID = petCfg.growID[2]
        initID = petCfg.initID[2]
    else
        growID = petCfg.growID[1]
        initID = petCfg.initID[1]
    end
    local growCfg = ConfigManager:getPetGrowAttrByID(growID)
    local attrCfg = ConfigManager:getPetInitAttrByID(initID)
    local growList = {}
    local attrList = {}
    local grows = {}

    -- 资质系数
    printInfo("pet talentParam : "..table.nums(growCfg))
    local totalTalentParam = 0
    for index = 0, table.nums(growCfg) do
        if growCfg["talentParam_"..index] then
            totalTalentParam = totalTalentParam < index and index or totalTalentParam
            table.insert(growList, growCfg["talentParam_"..index])
        end
    end

    -- table.insert(growList, growCfg.talentParam_0)
    -- table.insert(growList, growCfg.talentParam_1)
    -- table.insert(growList, growCfg.talentParam_2)
    -- table.insert(growList, growCfg.talentParam_3)
    -- table.insert(growList, growCfg.talentParam_4)
    -- table.insert(growList, growCfg.talentParam_5)
    -- table.insert(growList, growCfg.talentParam_6)

    local grow = growList[starLv + 1]

    table.insert(grows, grow[2])
    table.insert(grows, grow[5])
    table.insert(grows, grow[6])
    table.insert(grows, grow[1])
    table.insert(grows, grow[4])
    table.insert(grows, grow[3])
    table.insert(grows, grow[7])

    -- 生长常数
    table.insert(attrList, attrCfg.init_atk[2])
    table.insert(attrList, attrCfg.init_magicAtk[2])
    table.insert(attrList, attrCfg.init_atkFire[2])
    table.insert(attrList, attrCfg.init_hp[2])
    table.insert(attrList, attrCfg.init_physicDef[2])
    table.insert(attrList, attrCfg.init_magicDef[2])
    table.insert(attrList, attrCfg.init_defFire[2])
    

    for k, v in ipairs(valMax) do
        table.insert(qTypes, cfgTypes[k])
        table.insert(prgs, curVal[k]/v)
        table.insert(prgTxts, string.format("%d/%d", curVal[k], v))
        table.insert(plus, plusVal[k])
        table.insert(pill, pillVal[k])
        table.insert(pillMax, pillMaxVal[k])
    end

    for k, v in ipairs(names) do
        local oneAttr = {}
        oneAttr.idx = k
        oneAttr.name = v
        oneAttr.icon = icons[k]
        oneAttr.type = qTypes[k]
        oneAttr.prg = prgs[k]
        oneAttr.prgTxt = prgTxts[k]
        oneAttr.plus = plus[k]
        oneAttr.plusLen = plusLen[k]
        oneAttr.pill = pill[k]
        oneAttr.pillMax = pillMax[k]
        oneAttr.curVal = curVal[k]
        oneAttr.grow = grows[k]
        oneAttr.attrConst = attrList[k]

        table.insert(self.qualityData, oneAttr)
    end
end

function PetTrainView:composeQualityLayer(data)
    local powerNum = math.floor((data.curVal + data.plus) * data.grow / 1000 + data.attrConst)
    local tipTxtList = {
        UI.TEXT_1213719, UI.TEXT_1213721, UI.TEXT_1213723, UI.TEXT_1213725, UI.TEXT_1213720, 
        UI.TEXT_1213722, UI.TEXT_1213724,
    }
    local offsetY = {0, 55, 105, 155, 205, 255, 305, 355}

    local innerLayer = self.raiseQualityLayer:getChildByName("InnerLayer_"..data.idx)
    if not innerLayer then
        innerLayer = UI.Layout:create();
        innerLayer:init()
        innerLayer:setSize(390, 50)
        innerLayer:setTouchEnable(true)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            local pos = innerLayer:convertToNodeSpace(touchPosition)
            local size = innerLayer:getContentSize()
            local rect = cc.rect(0, 0, size.width/2, size.height)
            local tipTxt = string.format(data.name..":"..tipTxtList[data.idx], powerNum)
            if cc.rectContainsPoint(rect, pos) then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, tipTxt)
            end
        end)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)

        innerLayer:setName("InnerLayer_"..data.idx)
        self.raiseQualityLayer:addChild(innerLayer)
    end
    innerLayer:leftUp(0, (data.idx-1)*50)

    local bg = innerLayer:getChildByName("Bg")
    if bg then
        bg:hide()
    end
    if data.idx%2 == 1 then
        if not bg then
            local bg = UI.Image:create()
            bg:init("ui_pets_cultivate_qualityup.png")
            bg:center()
            bg:setName("Bg")
            innerLayer:addChild(bg)
        else
            bg:show()
        end
    end

    local iconImg = innerLayer:getChildByName("IconImg")
    if not iconImg then
        iconImg = UI.Image:create()
        iconImg:init(data.icon)
        iconImg:centerLeft(15)
        iconImg:setName("IconImg")
        innerLayer:addChild(iconImg)
    end

    local prg = innerLayer:getChildByName("Prg")
    if not prg then
        prg = UI.ProgressTimer:create()
        prg:init("ui_pets_quality_progressbar_0.png", nil, "ui_pets_quality_progressbar_1.png")
        prg:centerLeft(50)
        prg:setName("Prg")
        innerLayer:addChild(prg)
    end
    prg:setPercent(data.prg)

    local prgText = prg:getChildByName("PrgText")
    if not prgText then
        prgText = UI.Text:create()
        prgText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_209_209_209)
        prgText:center()
        prgText:setName("PrgText")
        prg:addChild(prgText, 10)
    end
    prgText:setText(data.prgTxt)

    local prgTextShadow = prg:getChildByName("PrgTextShadow")
    if not prgTextShadow then
        prgTextShadow = UI.Text:create()
        prgTextShadow:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
        prgTextShadow:centerUp(1)
        prgTextShadow:setName("PrgTextShadow")
        prg:addChild(prgTextShadow, 9)
    end
    prgTextShadow:setText(data.prgTxt)

    local plusLayer = innerLayer:getChildByName("PlusLayer")
    if plusLayer then   
        plusLayer:hide()
    end
    if data.plus > 0 then
        if not plusLayer then
            plusLayer = UI.Layout:create();
            plusLayer:init()
            plusLayer:setSize(120, 20)
            plusLayer:setName("PlusLayer")
            innerLayer:addChild(plusLayer)
        else
            plusLayer:show()
        end
        plusLayer:leftBottom(prg:getContentSize().width+50, 14)

        local expPlusW = data.plusLen
        local expPlus = plusLayer:getChildByName("ExpPlus")
        local expPlusTxtShadow = plusLayer:getChildByName("ExpPlusTxtShadow")
        local expPlusTxt = plusLayer:getChildByName("expPlusTxt")

        if not expPlus then
            expPlus = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_quality_progressbar_2.png")
            expPlus:setCapInsets(CCRectMake(0.5,8,0.1,0.1))
            expPlus:setName("ExpPlus")
            plusLayer:addChild(expPlus)
        end
        expPlus:setContentSize(expPlusW, 17)
        expPlus:setPosition(expPlusW/2, 11)

        if not expPlusTxtShadow then
            expPlusTxtShadow = UI.Text:create()
            expPlusTxtShadow:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
            expPlusTxtShadow:setName("ExpPlusTxtShadow")
            plusLayer:addChild(expPlusTxtShadow)
        end
        expPlusTxtShadow:setText("+"..data.plus)
        expPlusTxtShadow:leftBottom(expPlusW+2, 1)

        if not expPlusTxt then
            expPlusTxt = UI.Text:create()
            expPlusTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_255_186_65)
            expPlusTxt:setName("expPlusTxt")
            plusLayer:addChild(expPlusTxt)
        end
        expPlusTxt:setText("+"..data.plus)
        expPlusTxt:leftBottom(expPlusW+2, 2)
    end

    local selectBG = innerLayer:getChildByName("SelectBG")
    if not selectBG then
        selectBG = UI.Image:create()
        selectBG:init("ui_btn_choice_0.png")
        selectBG:setScaleX(0.7)
        selectBG:setScaleY(0.7)
        selectBG:centerRight(16)
        selectBG:setName("SelectBG")
        innerLayer:addChild(selectBG)
        innerLayer:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, com, touchPosition)
            local pos = selectBG:convertToNodeSpace(touchPosition)
            local size = selectBG:getContentSize()
            local rect = cc.rect(0, 0, size.width, size.height)
            if cc.rectContainsPoint(rect, pos) then
                if self.curSelectQualityRaise == data.idx then
                    return
                end

                self:qualityRaiseCellClick(data.idx)
            end
        end)
    end

    local select = innerLayer:getChildByName("select")
    if not select then
        select = UI.Image:create()
        select:init("ui_btn_choice_1.png")
        select:centerRight(16)
        select:setName("select")
        innerLayer:addChild(select)
    end
    if not data.select then
        select:hide()
    else
        select:show()
    end
    table.insert(self.raiseCellSelectTab, select)
end

function PetTrainView:qualityRaiseCellClick(idx)
    for k, v in ipairs(self.raiseCellSelectTab) do
        if k == idx then
            v:show()
            self.curSelectQualityRaise = idx

            self:updateQualityPillShow()
        else
            v:hide()
        end
    end
end

function PetTrainView:updateQualityPillShow()
    local curPill = self.qualityData[self.curSelectQualityRaise].pill
    self.curQualityPillID = curPill.id

    -- 资质丹
    local goodsData = GoodsDataManager:createLocalGoodsData(curPill.id)
    local pillNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(curPill.id, true, true)

    -- 物品物品图标
    goodsData:setNum(pillNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false

    self.qualityPillName:setText(goodsData:getName())
    self.qualityPillDesc:setText(string.format(UI.TEXT_1213675, tonumber(curPill.rang[1]), tonumber(curPill.rang[2])))

    local goodsGrid = self.raiseQualityLayer:getChildByName("QualityPill")
    if goodsGrid then
        -- self.raiseQualityLayer:removeChildByName("QualityPill")
        goodsGrid:setData(goodsData)
        goodsGrid:onUpdateView()
    else
        goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:setName("QualityPill")
        self.raiseQualityLayer:addChild(goodsGrid);
    end
    goodsGrid:showInfoArea(false, false)
    goodsGrid:leftBottom(0, 4)
end

-- 学习技能
function PetTrainView:showLearnSkill()

    if not self.learnSkillLayer then
        local learnSkillLayer = UI.Layout:create();
        learnSkillLayer:init()
        learnSkillLayer:setSize(386, 436)
        learnSkillLayer:centerBottom(0)
        self.contentLayout:addChild(learnSkillLayer, 2)
        self.learnSkillLayer = learnSkillLayer
    end

    -- 技能
    local skillLayer = self.learnSkillLayer:getChildByName("SkillLayer")
    if not skillLayer then
        skillLayer = UI.PetSkillLayer:create()
        skillLayer:init(self.curPet:getId(), false, -105) 
        skillLayer:leftUp(0, -16)
        skillLayer:setName("SkillLayer")
        self.learnSkillLayer:addChild(skillLayer, 10);
    else
        skillLayer:updateToShow(self.curPet:getId(), false, -105)
    end

    -- 技能书
    local skillListLayer = self.learnSkillLayer:getChildByName("SkillListLayer")
    if not skillListLayer then
        skillListLayer = UI.Layout:create();
        skillListLayer:init()
        skillListLayer:setSize(390, 268)
        skillListLayer:centerBottom(20)
        skillListLayer:setName("SkillListLayer")
        self.learnSkillLayer:addChild(skillListLayer)
    end

    -- TIP
    local tipLayer = skillListLayer:getChildByName("TipLayer")
    if not tipLayer then
        tipLayer = UI.Layout:create();
        tipLayer:init()
        tipLayer:setSize(390, 30)
        tipLayer:centerUp(0)
        -- skillListLayer:enableDebugDraw()
        tipLayer:setName("TipLayer")
        skillListLayer:addChild(tipLayer)
    end

    local tipInnerLayout = tipLayer:getChildByName("TipInnerLayout")
    if not tipInnerLayout then
        tipInnerLayout = UI.Layout:create();
        tipInnerLayout:init()
        tipInnerLayout:center()
        tipInnerLayout:enableAutoWidth()
        tipInnerLayout:enableAutoHeight()
        tipInnerLayout:setName("TipInnerLayout")
        tipLayer:addChild(tipInnerLayout)

        local tipIcon  = UI.Image:create();
        tipIcon:init("ui_information_reminder.png");
        tipIcon:floatLeft(0);
        tipInnerLayout:setName("TipInnerLayout")
        tipInnerLayout:addComponent(tipIcon)

        local tipText = UI.Text:create()
        tipText:init(UI.TEXT_1213676, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
        tipText:floatLeft(4)
        tipText:setName("TipText")
        tipInnerLayout:addComponent(tipText)
        local w = tipText:getContentSize().width
        if w > 360 then
            tipText:setWidth(360)
            tipText:setTextCenter()
            tipText:autoAdapt()
            tipText:setLineSpacing(-6)
        end
        tipText:floatLeft(4)
    end

    -- Title
    local titleBG = skillListLayer:getChildByName("TitleBG")
    if not titleBG then
        titleBG  = UI.Image:create();
        titleBG:init("ui_choice_title_2.png");
        titleBG:centerUp(38);
        titleBG:setName("TitleBG")
        skillListLayer:addChild(titleBG)
    end

    local titleText = titleBG:getChildByName("TitleText")
    if not titleText then
        titleText = UI.Text:create()
        titleText:init(UI.TEXT_1213677, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_202_168_128)
        titleText:center()
        titleText:setName("TitleText")
        titleBG:addChild(titleText)
    end

    local listBG = skillListLayer:getChildByName("ListBG")
    if not listBG then
        listBG = UI.Image:create();
        listBG:init("ui_pets_skill_rightpage.png");
        listBG:centerBottom(0);
        listBG:setName("ListBG")
        skillListLayer:addChild(listBG)
    end

    -- 技能书列表
    if not self.skillbookList then
        local gridList = UI.GridList:create()
        gridList:init(UI.PetTrainSkillBookCell, 5, 5, 76, 76, 0, 0, 0)
        gridList:setSize(380, 177)
        gridList:leftBottom(-11, 0)
        gridList:disableToDragGrid()
        gridList:setCallbackForGridClick(self, self.cellClickCallback)
        gridList:setScrollBarEnabled(false)
        gridList:setCircleVisible(false)
        self.skillbookList = gridList
        skillListLayer:addChild(self.skillbookList)
    end
    self.skillbookList:setData(self:getBookList())

    local mask = skillListLayer:getChildByName("Mask")
    if not mask then
        mask  = UI.Image:create()
        mask:init("ui_pets_mask_2.png")
        mask:centerBottom(0)
        mask:setName("Mask")
        skillListLayer:addChild(mask)
    end
end

function PetTrainView:getBookList()
    local bookList = {}
    local allBooks = mvc.petModel:getAllSkillBooks()
    for k, v in ipairs(allBooks) do
        table.insert(bookList, v)
    end

    local emptyCount = math.max(0, 15 - #bookList)
    for i = 1, emptyCount do
        table.insert(bookList, {emptySlot = true})
    end

    return bookList
end

function PetTrainView:cellClickCallback(grid)
    local bookData = grid:getData()
    if bookData.emptySlot then
        return
    end

    if self and not tolua.isnull(self) and self.lastGrid and not tolua.isnull(self.lastGrid) then
        self.lastGrid:clearSelect()
    end

    if (not tolua.isnull(self.materialInfo)) then
        self.materialInfo:close()
        self.materialInfo = nil
    end

    -- 技能书tips
    materialInfo = UI.PetSkillBookInfoArea:create()
    materialInfo:init(false, self.curPet:getId())
    materialInfo:leftBottom(-306, 26)
    self.contentLayout:addChild(materialInfo,9999)
    self.materialInfo = materialInfo
    materialInfo:setGoodsGrid(grid)
    materialInfo:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, grid, touchPosition)
        print("onMaterialInfoAreaTouchHandler")

        if grid:getGoodsGrid() ~= nil and not tolua.isnull(grid:getGoodsGrid()) then
            local point  = grid:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
            local rect = cc.rect(point.x , point.y , grid:getGoodsGrid()._width,grid:getGoodsGrid()._height) 
            if cc.rectContainsPoint(rect, touchPosition) then
                grid:setInterceptTouches(false)
            end
        end
    
        if self.materialInfo and (not tolua.isnull(self.materialInfo)) then
            self.materialInfo:close()
        end
        self.materialInfo = nil
    end)
    materialInfo:updateView(grid:getData())

    grid:cellClick()
    self.lastGrid = grid

end

function PetTrainView:bindModel()

end


function PetTrainView:unbindModel()

end

return PetTrainView
