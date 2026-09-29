------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetMainView = class("PetMainView", UI.HWBtnComponent)

require "app.modules.pet.PetMainTabCell"
require "app.modules.pet.PetInfoLayer"
require "app.modules.pet.PetPacketLayer"
require "app.modules.pet.PetBriefInfoView"
local SceneManager = require("app.game.SceneManager")

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_town_upgrade.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local ZOrder = 1
local BTN_CELL_W = 109
local BTN_CELL_H = 68

function PetMainView:ctor(data)
    PetMainView.super.ctor(
    	self,
    	UI.Type.PET_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.btnCellArr = {}
    self:bindModel()

    if data then
        self.inputTabIdx = data.tabIdx  -- 右边的tab index，取值范围:1-5
        self.inputInnerTabIdx = data.innerTabIdx  -- 选定右边的tab后，分页里面小tab idx(如果有的话)，取值范围:1-3
        self.inputPetID = data.petID  -- 指定的宠物id
    end

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_BRIEF_INFO, self, self.showPetBriefInfo)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_BRIEF_INFO, self, self.hidePetBriefInfo)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SHOW_RAISE_QUALITY_RET, self, self.showRaiseQualityResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTERUP, self, self.centerUpView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTER, self, self.centerView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_MAIN_TAB_INFO_SHOW, self, self.showPetInfo)
end

function PetMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetMainView.super.init(self, ... )
end

function PetMainView:dtor()
    PetMainView.super.dtor(self)
    self:unbindModel()
    self.btnCellArr = {}
    mvc.petModel:clearRanksList()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_BRIEF_INFO, self, self.showPetBriefInfo)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_BRIEF_INFO, self, self.hidePetBriefInfo)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SHOW_RAISE_QUALITY_RET, self, self.showRaiseQualityResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTERUP, self, self.centerUpView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTER, self, self.centerView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_MAIN_TAB_INFO_SHOW, self, self.showPetInfo)

    reload_script_file_mvc("app.modules.pet.PetMainView")
    reload_script_file("app.modules.pet.PetMainTabCell")
end

function PetMainView:onInitView()
    self:initPetListData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_bg_box2.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(-14);
    contentLayout:addChild(bgTitle, ZOrder);
    ZOrder = ZOrder + 1;

    local titleTxtLayout = UI.Layout:create();
    titleTxtLayout:init()
    titleTxtLayout:setSize(235, 50)
    titleTxtLayout:leftUp(350, -10)
    -- titleTxtLayout:enableDebugDraw()
    contentLayout:addChild(titleTxtLayout, ZOrder)
    ZOrder = ZOrder + 1;

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213601, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_150_150_150)
    titleTxt:center()
    titleTxtLayout:addChild(titleTxt)

    -- 内部背景图片
    local innerBG  = UI.Image:create();
    innerBG:init("ui_pets_paper.png");
    innerBG:leftUp(30, 44);
    contentLayout:addChild(innerBG, ZOrder);
    ZOrder = ZOrder + 1;
    self.innerBG = innerBG
    
    self:makeTabList()
    self:initPetInfoLayer(self.inputPetID)

    self:updateLeftPanel()

    local stoneEff = UI.Animation:create()
    stoneEff:init("effect_ui_town_pet_main_stone.json", "effect_ui_town_pet_main_stone.atlas", 1);
    stoneEff:leftBottom(-4, 6)
    stoneEff:setAnimation("idle", true)
    self.contentLayout:addChild(stoneEff, 100)

    self.inputTabIdx = nil
    self.inputInnerTabIdx = nil
    self.inputPetID = nil
end

function PetMainView:centerUpView()
    self:centerUp(20000)
end

function PetMainView:centerView()
    self:center()
end

function PetMainView:initPetListData()
    self.petList = MasterDataManager:getBagPets()
    if self.inputPetID then
        self.curPet = MasterDataManager:getBagPetById(self.inputPetID)
    else
        for k, v in ipairs(self.petList) do
            if v:isFight() then
                self.curPet = v
                break
            end
        end

        if not self.curPet then
            self.curPet = self.petList[1]
        end
    end
end

function PetMainView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.type = "attr"
    tab1.name = UI.TEXT_1213602
    tab1.ui = "PetAttr"
    tab1.select = true
    tab1.rootLayer = self

    local tab2 = {}
    tab2.idx = 2
    tab2.type = "train"
    tab2.name = UI.TEXT_1213603
    tab2.ui = "PetTrain"
    tab2.select = false
    tab2.rootLayer = self

    local tab8 = {}
    tab8.idx = 3
    tab8.type = "skill"
    tab8.name = UI.TEXT_1213661
    tab8.ui = "PetSkill"
    tab8.select = false
    tab8.rootLayer = self

    local tab3 = {}
    tab3.idx = 4
    tab3.type = "compose"
    tab3.name = UI.TEXT_224007
    tab3.ui = "PetCompose"
    tab3.select = false
    tab3.rootLayer = self

    -- local tab3 = {}
    -- tab3.idx = 4
    -- tab3.type = "compose"
    -- tab3.name = UI.TEXT_1213604
    -- tab3.ui = "PetCompose"
    -- tab3.select = false
    -- tab3.rootLayer = self

    -- local tab4 = {}
    -- tab4.idx = 5
    -- tab4.type = "refine"
    -- tab4.name = UI.TEXT_1213605
    -- tab4.ui = "PetRefine"
    -- tab4.select = false
    -- tab4.rootLayer = self
    
    -- local tab6 = {}
    -- tab6.idx = 6
    -- tab6.type = "inherit"
    -- tab6.name = UI.TEXT_1314058
    -- tab6.ui = "PetInherit"
    -- tab6.select = false
    -- tab6.rootLayer = self

    local tab7 = {}
    tab7.idx = 7
    tab7.type = "Corral"
    tab7.name = UI.TEXT_221016
    tab7.ui = "PetSite"
    tab7.select = false
    tab7.rootLayer = self

    local tab5 = {}
    tab5.idx = 8
    tab5.type = "handbook"
    tab5.name = UI.TEXT_1213606
    tab5.ui = "PetHandbook"
    tab5.select = false
    tab5.rootLayer = self

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)
    table.insert(self.btnData, tab8)
    table.insert(self.btnData, tab3)
    -- table.insert(self.btnData, tab4)
    -- table.insert(self.btnData, tab6)
    table.insert(self.btnData, tab7)
    table.insert(self.btnData, tab5)
    
    if self.inputTabIdx then
        for k, v in ipairs(self.btnData) do
            if self.inputTabIdx == k then
                v.select = true
                if self.inputInnerTabIdx then
                    v.inputInnerTabIdx = self.inputInnerTabIdx
                end

                self.curTabIndex = k-1
                self.lastTabIndex = k-1
            else
                v.select = false
            end
        end
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 420);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-92, 60)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        if not cell then
            xpcall(function()
                cell = UI.PetMainTabCell.new();
                cell:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
                cell:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
                cell:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

                cell:init(self.btnData[idx+1], self.curPet:getId());
            end,
            function(e) 
                printError("------------------------PetMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            cell:reloadData()
            
        end
        self.btnCellArr[idx+1] = cell
        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        if self.curTabIndex == cell:getIdx() then
            return
        end

        self.curTabIndex = cell:getIdx()
        self.btnData[self.curTabIndex+1].select = true
        self._tableView:updateCellAtIndex(self.curTabIndex)

        if self.lastTabIndex >= 0 then
            self.btnData[self.lastTabIndex+1].select = false
            self._tableView:updateCellAtIndex(self.lastTabIndex)
        end

        self.lastTabIndex = self.curTabIndex

        self:updateLeftPanel()
    end);
    if(GameManager:getIsGooglePlay()) then
        self._tableView:onTableCellHighLight(function(table, cell)
            -- print("onTableCellHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:updateCellHightLihtShow()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(self.btnCellArr[endIndex] and self.btnData[endIndex].select ~= true) then 
                            self.btnCellArr[endIndex]:updateCellUnHightLihtShow()
                        end
                    end
                end, 1)
            end
        end)

        self._tableView:onTableCellUnHighLight(function(table, cell)
            -- print("onTableCellUnHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(self.btnCellArr[endIndex])) then 
                self.btnCellArr[endIndex]:updateCellUnHightLihtShow()
            end
        end)
    end

    self.contentLayout:addChild(self._tableView, ZOrder);
    ZOrder = ZOrder + 1
    self._tableView:reloadData(true);

end

function PetMainView:hasShowPetEquipment()
    if self.curTabIndex == 0 then
        local cell = self.btnCellArr[self.curTabIndex+1]
        if(cell and cell.hasShowPetEquipment) then 
            return cell:hasShowPetEquipment()
        end
    end

    return false
end

-- 判断是否处于战斗中
function PetMainView:isBattle()
    local heroData = RoleDataManager:getMaster()
    local state = heroData:getState()
    if FSMState.BATTLE == state then 
        return true
    end
    return false
end

-- 角色展示区域拖拽装备格子开始的处理器
local function onEquipmentGridDragBeganHandler(self, equipmentGrid)
    if (self._isDeleting) then 
        return false
    end

    if not self:hasShowPetEquipment() then 
        return false
    end

    -- 处于战斗中禁止更换装备
    if self:isBattle() then 
        return false
    end

    if (equipmentGrid) then
        if not tolua.isnull(self._selectedBagGrid) then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end

        local equipmentData = equipmentGrid:getData()
        if (equipmentData) then
            if (DEBUG) then
                print(string.format("RolePanel onEquipmentGridDragBeganHandler: equipment grid type %d.", equipmentData:getEquipmentType()))
            end

            self.infoLayer:hideEquipment(equipmentData)
        else
            assert(false)
        end
    else
        assert(false)
    end
    return true
end

-- 角色展示区域拖拽装备格子结束的处理器
local function onEquipmentGridDragEndedHandler(self, equipmentGrid, inSide, touchPosition)
    local equipmentData = equipmentGrid:getData()
    if (not inSide) then
        if(SceneManager:getInstance():isInDungeon() 
            or SceneManager:getInstance():isActCave()) then
            -- 提示大秘境无法穿戴装备
            UI.ScrollBar:createByText(UI.TEXT_1170933)
            self.infoLayer:showEquipment(equipmentData)
        elseif RoleDataManager:getMaster():isHorcruxTransform() then
            UI.ScrollBar:createByText(UI.TEXT_1213507)
            self.infoLayer:showEquipment(equipmentData)
        else
            local GameDataManager = require("app.game.GameDataManager")
            --print("onEquipmentGridDragEndedHandler", GameDataManager:getFreePacketBoxNum())
            if (not (GameDataManager:getFreePacketBoxNum() <= 0)) then
                --print("onEquipmentGridDragEndedHandler 2", GameDataManager:getFreePacketBoxNum())
                self.infoLayer:removeEquipment(equipmentData)
                self.infoLayer:updateView()

                -- self.infoLayer:showEquipment(equipmentData)
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))
                self.infoLayer:showEquipment(equipmentData)
            end
        end 
    else
        self.infoLayer:showEquipment(equipmentData)
    end
    -- self._bagGridList:hideMove()
end

-- 装备详情的touch事件的处理
local function onEquipmentInfoAreaTouchHandler(self,obj,touchPosition)
     -- 更新装备对比区域数据
    if obj:getGoodsGrid() ~= nil and (not tolua.isnull(obj:getGoodsGrid()))  then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    -- self:updateBasicView()
    if(self._equipmentInfoArea and (not tolua.isnull(self._equipmentInfoArea))) then
        self._equipmentInfoArea:close()
    end
    self._selectedRoleGrid = nil
    self._equipmentInfoArea = nil
    if not tolua.isnull(self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

-- 角色展示区域装备格子被点击的处理器
local function onEquipmentGridClickHandler(self, equipmentGrid, equipmentPosition)
    print("onEquipmentGridClickHandler")
    -- 关闭装备详情面板
    if (self._equipmentInfoArea) then
        self._equipmentInfoArea:close()
        self._equipmentInfoArea = nil
    end

    if (equipmentGrid) then
        -- 点击同一装备两次
        if self._selectedRoleGrid == equipmentGrid then 
            return 
        end
        -- 点击角色身上的装备，关闭背包里装备的动画
        if not tolua.isnull(self._selectedBagGrid) then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end

        -- 装备详情
        local equipmentInfoArea =  UI.EquipmentPetInfoArea:create()
        equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        equipmentInfoArea:hideCompInfo()
        equipmentInfoArea:showStrength()
        if(SceneManager:getInstance():isInHuLu()) then
            equipmentInfoArea:closeLockFlag()
            equipmentInfoArea:setHideLink(true)
        end
        self:addChild(equipmentInfoArea, ZOrder + 100)
        self._equipmentInfoArea = equipmentInfoArea
        local goodsData = equipmentGrid:getEquipmentData()
        equipmentInfoArea:centerLeft(523 -60)

        self._equipmentInfoArea:setGoodsGrid(equipmentGrid)
        self._equipmentInfoArea:updateView(goodsData)
        -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onEquipmentInfoAreaTouchHandler)
        self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)

        self._selectedRoleGrid = equipmentGrid
    else
        -- assert(false)
        self:closeChoese()
    end
end

function PetMainView:initPetInfoLayer(petID)
    local curPetID = self.curPet:getId()
    if petID then
        curPetID = petID
    end

    local infoLayer = UI.PetInfoLayer:create()
    infoLayer:init(self.contentLayout, curPetID)
    infoLayer:leftUp(32, 50)
    infoLayer:setName("InfoLayer")
    infoLayer:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_BEGIN, self, onEquipmentGridDragBeganHandler)
    infoLayer:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_ENDED, self, onEquipmentGridDragEndedHandler)
    infoLayer:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, self, onEquipmentGridClickHandler)

    self.contentLayout:addChild(infoLayer, ZOrder);
    ZOrder = ZOrder + 1
    self.infoLayer = infoLayer
end

function PetMainView:initPetPacketLayer()
    local packetLayer = UI.PetPacketLayer:create()
    packetLayer:init(self.contentLayout)
    packetLayer:leftUp(32, 50)
    packetLayer:setName("packetLayer")

    self.contentLayout:addChild(packetLayer, ZOrder);
    ZOrder = ZOrder + 1
    self.packetLayer = packetLayer
end

function PetMainView:updateLeftPanel()
    print("self.curTabIndex ", self.curTabIndex )
    if self.curTabIndex == 0 or self.curTabIndex == 1 or self.curTabIndex == 2 then
        self.innerBG:show()
        self.infoLayer:leftUp(32, 50)
        if self.packetLayer then
            self.packetLayer:leftUp(32, 5000)
        end
    elseif self.curTabIndex == 3 or self.curTabIndex == 4 or self.curTabIndex == 5 or self.curTabIndex == 6 then
        self.innerBG:show()
        self.infoLayer:leftUp(32, 5000)
        if self.packetLayer then
            self.packetLayer:leftUp(32, 50)
        else
            self:initPetPacketLayer()
        end

    elseif self.curTabIndex == 7 or self.curTabIndex == 8 then
        self.innerBG:hide()
        self.infoLayer:leftUp(32, 5000)
        if self.packetLayer then
            self.packetLayer:leftUp(32, 5000)
        end
    end

    self:handlePacketSelectBtn()
end

function PetMainView:showTip(x, y, isRevert, text)
    local pos = self:convertToNodeSpace(cc.p(x, y))

    -- 提示框
    local tipBG = self:getChildByName("TIP")
    if not tipBG then
        tipBG = UI.Image9:create()
        tipBG:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
        tipBG:setName("TIP")
        self:addChild(tipBG, 10000)
    end
    tipBG:leftBottom(pos.x, pos.y)
    tipBG:setVisible(true)

    local content = tipBG:getChildByName("tipContent")
    if not content then
        content = UI.Text:create()
        content:setName("tipContent")
        content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
        content:leftUp(10, 10)
        content:setTextLeft()
        tipBG:addChild(content)
    end
    content:setText(text)
    local textW = content:getContentSize().width
    local textH = content:getContentSize().height
    if textW > 210 then
        content:setWidth(210)
        content:autoAdapt()
        textH = content:getContentSize().height
        tipBG:setSize(220, textH+20)
    else
        tipBG:setSize(textW+20, textH+20)
    end

    local tipArrow  = tipBG:getChildByName("tipArrow")
    if not tipArrow then
        tipArrow = UI.Image:create();
        tipArrow:setName("tipArrow")
        tipArrow:init("ui_information_banner_background2.png")
        tipBG:addChild(tipArrow)
    end
    if isRevert then
        tipArrow:setScaleX(-1)
        tipArrow:centerLeft(-9)
    else
        tipArrow:centerRight(-9)
    end

    tipBG:updateView()
    local w = tipBG:getContentSize().width
    local h = tipBG:getContentSize().height
    if isRevert then
        tipBG:leftBottom(pos.x+60, pos.y-h/2)
    else
        tipBG:leftBottom(pos.x-w-60, pos.y-h/2)
    end
end

function PetMainView:hideTip()
    local tip = self:getChildByName("TIP")
    if tip then
        tip:setVisible(false)
        -- self:removeChildByName("TIP")
    end
end

function PetMainView:showPetBriefInfo(petID, leftShow, tipRevert)
    
    if self:getChildByName("BriefInfo") then
        local briefInfo = self:getChildByName("BriefInfo")
        if leftShow then
            briefInfo:leftBottom(58, 46)
        else
            briefInfo:rightBottom(58, 46)
        end
        briefInfo:updateToShow(petID, tipRevert)

        briefInfo:setVisible(true)
        return
    end

    local briefInfo = UI.PetBriefInfoView:create()
    briefInfo:init(petID, tipRevert)
    if leftShow then
        briefInfo:leftBottom(58, 46)
    else
        briefInfo:rightBottom(58, 46)
    end
    briefInfo:setName("BriefInfo")
    self:addChild(briefInfo, 1000);
    self.briefInfo = briefInfo

    briefInfo:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, touchPosition)
        -- if self.briefInfo and (not tolua.isnull(self.briefInfo)) then
        --     self.briefInfo:close()
        -- end
        -- self.briefInfo = nil

        self.briefInfo:setVisible(false)
    end)
end

function PetMainView:hidePetBriefInfo()
    local infoLayer = self:getChildByName("BriefInfo")
    if infoLayer then
        self.briefInfo:setVisible(false)
        --self:removeChildByName("BriefInfo")
    end
end

-- 突破结果展示
function PetMainView:showRaiseQualityResult(beforeData, afterData)
    local winSize = cc.Director:getInstance():getWinSize()

    -- 内容面板
    local resultLayout = UI.Layout:create();
    resultLayout:init()
    resultLayout:setSize(COM_WIDTH,COM_HEIGHT)
    resultLayout:center()
    resultLayout:setName("ResultLayout")
    self:addChild(resultLayout, 1000)

    local mask = cc.LayerColor:create(cc.c4b(0,0,0,128));
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    resultLayout:addChild(mask)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() return end)
    resultLayout:addChild(maskLayout, 0)

    -- 内部背景图片
    local innerBG  = UI.Image:create();
    innerBG:init("ui_upgrade_upgrade_paper_03.png");
    innerBG:leftUp(186, 54);
    resultLayout:addChild(innerBG);

    -- Title
    local titleBG  = UI.Image:create();
    titleBG:init("ui_upgrade_title_01.png");
    titleBG:centerUp(32);
    innerBG:addChild(titleBG)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213607, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    titleTxt:setWidth(300)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:centerUp(7)
    titleBG:addChild(titleTxt)

    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:leftUp(0, 0)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(310, 358)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:centerUp(78)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.BLACK)
    scrollView:setCircleVisible(false)

    scrollView:addInnerNode(scrollContent)
    innerBG:addChild(scrollView)
    scrollView:scrollToTop()

    local titleBG1  = UI.Image:create();
    titleBG1:init("ui_upgrade_decorate_after.png");
    titleBG1:leftUp(24, 20);
    scrollContent:addChild(titleBG1)

    local titleTxt1 = UI.Text:create()
    titleTxt1:init(UI.TEXT_1213608, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleTxt1:setWidth(300)
    titleTxt1:setTextCenter()
    titleTxt1:autoAdapt()
    titleTxt1:center()
    titleBG1:addChild(titleTxt1)

    local layer1, totalH1 = self:composeQualityLayer(afterData, 0)
    scrollContent:addChild(layer1)

    local arrow  = UI.Image:create();
    arrow:init("ui_information_arrow_up_02.png");
    arrow:centerUp(totalH1+55);
    scrollContent:addChild(arrow)

    local titleBG2  = UI.Image:create();
    titleBG2:init("ui_upgrade_decorate_before.png");
    titleBG2:leftUp(24, totalH1+100);
    scrollContent:addChild(titleBG2)

    local titleTxt2 = UI.Text:create()
    titleTxt2:init(UI.TEXT_1213609, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleTxt2:setWidth(300)
    titleTxt2:setTextCenter()
    titleTxt2:autoAdapt()
    titleTxt2:center()
    titleBG2:addChild(titleTxt2)

    local layer2, totalH2 = self:composeQualityLayer(beforeData, totalH1+80)
    scrollContent:addChild(layer2)

    scrollContent:setSize(310, totalH2+60)

    local okBtn = UI.Button:create();
    okBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png");
    okBtn:centerBottom(26);
    okBtn:closeClickScale()
    okBtn:setText(UI.TEXT_1170211)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local retLayer = self:getChildByName("ResultLayout")
        if retLayer then
            self:removeChildByName("ResultLayout")
        end
    end)
    innerBG:addChild(okBtn)
end

function PetMainView:composeQualityLayer(data, beginOffset)
    local totalH = beginOffset

    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(120, 36)
    innerLayer:leftUp(70, 60+beginOffset)

    local iconImg = UI.Image:create()
    iconImg:init(data.icon)
    iconImg:centerLeft(0)
    innerLayer:addChild(iconImg)

    local prg = UI.ProgressTimer:create()
    prg:init("ui_pets_quality_progressbar_0.png", nil, "ui_pets_quality_progressbar_1.png")
    prg:centerLeft(32)
    prg:setPercent(data.prg)
    prg:setName("prg")
    innerLayer:addChild(prg)

    local prgText = UI.Text:create()
    prgText:init(data.prgTxt, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_209_209_209)
    prgText:center()
    prgText:setName("prgText")
    prg:addChild(prgText, 10)

    local prgTextShadow = UI.Text:create()
    prgTextShadow:init(data.prgTxt, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
    prgTextShadow:centerUp(1)
    prg:addChild(prgTextShadow, 9)

    if data.plus > 0 then
        local plusLayer = UI.Layout:create();
        plusLayer:init()
        plusLayer:leftBottom(prg:getContentSize().width + 34, 8)
        plusLayer:setSize(120, 20)
        innerLayer:addChild(plusLayer)

        local expPlusW = data.plusLen
        local expPlus = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_quality_progressbar_2.png")
        expPlus:setContentSize(expPlusW, 18)
        expPlus:setCapInsets(CCRectMake(0.5,8,0.1,0.1))
        expPlus:setPosition(expPlusW/2-2, 10)
        plusLayer:addChild(expPlus)

        local expPlusTxtShadow = UI.Text:create()
        expPlusTxtShadow:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
        expPlusTxtShadow:leftBottom(expPlusW, 1)
        plusLayer:addChild(expPlusTxtShadow)

        local expPlusTxt = UI.Text:create()
        expPlusTxt:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_255_186_65)
        expPlusTxt:leftBottom(expPlusW, 2)
        expPlusTxt:setName("expPlusTxt")
        plusLayer:addChild(expPlusTxt)
    end

    totalH = totalH + 40

    local offsetY = {40, 66, 92, 118, 144}
    for k, v in ipairs(data.effectAttr) do
        local attrIcon  = UI.Image:create();
        attrIcon:init(v.icon);
        attrIcon:leftUp(0, offsetY[k]);
        innerLayer:addChild(attrIcon);
    
        local attrVal = UI.Text:create()
        attrVal:init(v.str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        attrVal:leftUp(48, offsetY[k])
        innerLayer:addChild(attrVal)

        totalH = totalH + 30
    end

    return innerLayer, totalH
end

function PetMainView:showPetInfo(petId)

    local infoLayer = self.contentLayout:getChildByName("InfoLayer")
    if infoLayer then
        self.contentLayout:removeChildByName("InfoLayer")
    end

    self:initPetInfoLayer(petId)

    for k, v in ipairs(self.petList) do
        if petId == v:getId() then
            self.curPetListIdx = k
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SELECT_CELL_UPDATE, self.curPetListIdx)

    self.curTabIndex = 0
    self.btnData[self.curTabIndex+1].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex)

    if self.lastTabIndex >= 0 then
        self.btnData[self.lastTabIndex+1].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex)
    end

    self.lastTabIndex = self.curTabIndex
    self:updateLeftPanel()
    
end

function PetMainView:handlePacketSelectBtn()
    if self.packetLayer and not tolua.isnull(self.packetLayer) then
        if self.curTabIndex == 3 then
            self.packetLayer:showSelectBtn()
        else
            self.packetLayer:hideSelectBtn()
        end
    end
end


function PetMainView:bagDragBeganCallback(bagGrid, touchPosition)
    --print("PetMainView:bagDragBeganCallback")
    if(not tolua.isnull(bagGrid)) then
        bagGrid:hideSelect()
    end
    if (self._equipmentInfoArea) then
        self._equipmentInfoArea:close()
        self._equipmentInfoArea = nil
    end
    if (bagGrid) then
        local goodsData = bagGrid:getData()
        local goodsType = goodsData:getGoodsType()
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            self.infoLayer:activeEquipment(goodsData, touchPosition)
        end

        self._isDraging = true
    end
    -- self.dragSpine:setVisible(true)
    -- self._bagGridList:setSpineBgVisible(true)
end

function PetMainView:bagDragMovedCallback(grid, touchPosition)
    --print("PetMainView:bagDragMovedCallback")
    if (grid) then
        local goodsData = grid:getData()
        local goodsType = goodsData:getGoodsType()
        -- 只有装备才可以激活角色展示区
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            -- 拖到角色展示区
            local gridList = self.btnCellArr[self.curTabIndex+1]
            if(gridList) then 
                gridList:changeInSideStatus(self.infoLayer:checkTouchPosition(touchPosition))
            end
        end
    end
end

function PetMainView:bagDragEndedCallback(bagGrid, touchPosition)
    --print("PetMainView:bagDragEndedCallback")
    -- self._bagGridList:setSpineBgVisible(false)
    if(bagGrid == nil or tolua.isnull(bagGrid)) then
        return
    end

    if bagGrid then
        local goodsData = bagGrid:getData()
        -- 如果没有穿戴成功，放回背包
        if (not self.infoLayer:addEquipment(goodsData)) then
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                if self.infoLayer:checkTouchPosition(touchPosition) then
                    if self.equipNotUseReson then
                        UI.ScrollBar:createByText(self.equipNotUseReson)
                        self.equipNotUseReson = nil
                    else
                        UI.ScrollBar:createByText(UI.TEXT_1325902)
                    end
                end
            end
        else 
            goodsData:setUseNum(1)
            bagGrid:updateView()
        end
        self.infoLayer:deactiveEquipment()

        self._isDraging = false

        Avalon.AudioManager:playSound("1505")
    end
end

function PetMainView:bindModel()

end


function PetMainView:unbindModel()

end

return PetMainView
