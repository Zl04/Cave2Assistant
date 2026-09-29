-- EquipForgeLayer.lua
-- Author:luozhiming
-- 2019.3.20

require "app.ui.UIDefine"
require "app.datas.EquipForgeDataManager"
require "app.ui.equipForge.EquipForgeBtnCell"
require "app.ui.equipForge.EquipForgeEquipCell"
require "app.ui.equipForge.EquipForgeSuccessLayer"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local EquipForgeLayer = class("EquipForgeLayer", UI.DownShowWin)
UI.EquipForgeLayer = EquipForgeLayer

local FORGE_TYPE = {
    ["UNLOCK"]=1,
    ["FORGE"]=2,
}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local VIEW_WIDTH = 870;
local VIEW_HEIGHT = 588;
local BTN_CELL_W = 82
local BTN_CELL_H = 60
local EQUIP_CELL_W = 290
local EQUIP_CELL_H = 66
local MAT_PANEL_W = 342

--资源列表(必备)
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_common_scale9image.plist",
    "ui_common_icon_equip",
    "ui_town_deformation.plist",
    "ui_town_blacksmith.plist",
    "ui_package_roleTalent.plist",
}

-- 标签信息
local TAB_DATA = {
    [1] = {             -- 全部标签
        iconFileName = "ui_deformation_all.png",
    },    
    [2] = {             -- 大剑标签
        iconFileName = "ui_deformation_weapon.png",
    },       
    [3] = {             -- 法杖标签
        iconFileName = "ui_deformation_staff.png",
    },
    [4] = {             -- 剑盾标签
        iconFileName = "ui_deformation_swordshield.png",
    },
    [5] = {             -- 头标签
        iconFileName = "ui_deformation_helm.png",
    },
    [6] = {             -- 胸标签
        iconFileName = "ui_deformation_armor.png",
    },
    [7] = {             -- 肩标签
        iconFileName = "ui_deformation_scapula.png",
    },
    [8] = {             -- 手标签
        iconFileName = "ui_deformation_globe.png",
    },
    [9] = {             -- 脚标签
        iconFileName = "ui_deformation_boot.png",
    },
    [10] = {             -- 项链标签
        iconFileName = "ui_deformation_amulet.png",
    },
    [11] = {             -- 戒指标签
        iconFileName = "ui_deformation_ring.png",
    },
}

local TEMP_CUR_LAYER = 10113

--构造函数(必备)
function EquipForgeLayer:ctor(npcSpriteID)
    EquipForgeLayer.super.ctor(
        self, 
        UIType.EQUIP_FORGE_LAYER,
        COM_RES_LIST,
        VIEW_WIDTH,
        VIEW_HEIGHT
    )

    self._npcSpriteID = npcSpriteID
    self._cachedPanels = {}
    self._callbackList = {}
    self.curTabIndex = -1
    self.lastTabIndex = 0
    self.curEquipIndex = -1
    self.lastEquipIndex = -1
    self.cellPlayUnlockEff = false
    self.newEquipTag = {}
    self.lockingFuncBtn = false
    self.lockRefreshEff = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:init()
    self:open()
end

--虚构函数, destroy时调用(必备)
function EquipForgeLayer:dtor()
    self.curTabIndex = -1
    self.lastTabIndex = 0
    self.curEquipIndex = -1
    self.lastEquipIndex = -1
    self.cellPlayUnlockEff = false

    EquipForgeDataManager:clearSortedList()
    self:cleanAllNewEquipTag()

    self.newEquipTag = {}

    EquipForgeLayer.super.dtor(self)
    self:unregisterListener()
    reload_script_file("app.ui.equipForge.EquipForgeLayer")
end

-- 初始化(必备)
function EquipForgeLayer:init()
    EquipForgeLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function EquipForgeLayer:onInitView()
    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self._rootLayer:center()
    self:addChild(self._rootLayer)

    -- 背景
    self._bg = UI.Image:create()
    self._bg:init("ui_deformation_bg.png")
    self._bg:center()
    self._rootLayer:addChild(self._bg)

    local NPC = UI.Animation:create()
    NPC:init("effect_ui_town_blacksmith_new_forge_blacksmith.json", "effect_ui_town_blacksmith_new_forge_blacksmith.atlas", 1);
    NPC:leftBottom(80, 30)
    NPC:setAnimation("idle1", true)
    self._bg:addChild(NPC, 10)
    self.NPCAnimation = NPC

    -- 左侧panel
    local panel = UI.Layout:create();
    panel:init();
    panel:setSize(342, 500);
    panel:leftBottom(166, 43);
    -- panel:enableDebugDraw()
    self.leftPanel = panel;
    self._bg:addChild(self.leftPanel, 2)

    self:initLeftPanel()
    self:initRightPanel()

    self:cacheNewEquipTag()
end

function EquipForgeLayer:cacheNewEquipTag()
    local allEquips = EquipForgeDataManager:getEquipForgeListByType(1);
    for k, v in ipairs(allEquips) do
        if GameDataManager:getEquipForgeGroupID() >= v.unlockPoint then
            local new = EquipForgeDataManager:getForgeEquipIsNew(v.configID)
            if new then
                self.newEquipTag[v.configID] = true
            end
        end
    end
end

function EquipForgeLayer:cleanAllNewEquipTag()
    for configID, _ in pairs(self.newEquipTag) do
        EquipForgeDataManager:setForgeEquipIsNew(configID)
    end
end

function EquipForgeLayer:initLeftPanel()
    self:initMaterialPanel()

    -- 左边背景上的眼睛
    local eyes = UI.Animation:create()
    eyes:init("effect_ui_town_deformation_huanhua_yanjingbg.json", "effect_ui_town_deformation_huanhua_yanjingbg.atlas", 1);
    eyes:leftBottom(360, 310)
    eyes:setAnimation("idle", true)
    self._bg:addChild(eyes)

    -- 标题:锻造
    local title = UI.Text:create()
    title:init(UI.TEXT_1110396, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
    title:center(35, -264)
    self._bg:addChild(title)

    -- 装备名字
    local equipName = UI.Text:create()
    equipName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    equipName:centerBottom(450)
    equipName:hide()
    self.leftPanel:addChild(equipName)
    self.curEquipName = equipName

    -- 角色站点平台
    local standingGround = UI.Image:create()
    standingGround:init("ui_character_hero_table.png")
    standingGround:centerBottom(-15)
    standingGround:setScale(0.9)
    self.leftPanel:addChild(standingGround, 1)

    -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create(false)
    self._roleAnimation:init(RoleDataManager:getMaster())
    self._roleAnimation:setScaleX(-1 * self._roleAnimation:getScaleX())
    self._roleAnimation:centerBottom(200)
    self._roleAnimation:showBlink(true)
    performWithDelay(self, function()
        self._roleAnimation:showHelmet(true)
    end, 0)
    self.leftPanel:addChild(self._roleAnimation, 3)
end

function EquipForgeLayer:initMaterialPanel()
    local panel = UI.Layout:create();
    panel:init();
    panel:setSize(MAT_PANEL_W, 202);
    panel:centerBottom(0);
    panel:setName("panel")
    -- panel:enableDebugDraw()
    self.leftPanel:addChild(panel, 2)
    self.materialPanel = panel

    -- 所需材料
    local titleName = UI.Text:create()
    titleName:init(UI.TEXT_1212365, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_192_192_192)
    titleName:centerUp(10)
    titleName:hide()
    titleName:setName("titleName")
    panel:addChild(titleName, 10)

    -- 按钮
    local btn = UI.Button:create();
    btn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png");
    btn:centerBottom(5);
    btn:closeClickScale()
    btn:hide()
    btn:setName("funcBtn")
    panel:addChild(btn)
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:doEquipForge()
    end)
    btn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self,function(self)
        UI.ScrollBar:createByText(UI.TEXT_1212360)
    end)

    local btnLayout = UI.Layout:create();
    btnLayout:init();
    btnLayout:enableAutoWidth()
    btnLayout:enableAutoHeight()
    local w = btn:getContentSize().width
    local h = btn:getContentSize().height
    btnLayout:center();
    btnLayout:setName("innerLayout")
    btn:addChild(btnLayout, 2)

    -- 按钮上的字
    local txt = UI.Text:create()
    txt:init(UI.TEXT_1212363, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    txt:floatLeft(0)
    txt:setName("btnTxt")
    btnLayout:addComponent(txt)

    local consumeIcon = UI.Image:create()
    consumeIcon:init("symbol_gaming_diamond.png")
    consumeIcon:floatLeft(20)
    consumeIcon:setName("consumeIcon")
    btnLayout:addComponent(consumeIcon)

    local consumetxt = UI.Text:create()
    consumetxt:init("x0", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    consumetxt:floatLeft(5)
    consumetxt:setName("consumeTxt")
    btnLayout:addComponent(consumetxt)

    -- 在右侧列表中选择想要锻造的装备
    local tipTxt = UI.Text:create()
    tipTxt:init(UI.TEXT_1212361, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    -- tipTxt:setWidth(140);
    tipTxt:setLineSpacing(-4);
    tipTxt:centerBottom(60)
    tipTxt:setTextCenter()
    tipTxt:autoAdapt()
    tipTxt:setName("tipTxt")
    panel:addChild(tipTxt)
end

function EquipForgeLayer:updateMaterialSlot(playUnlockEff)
    if self.curEquipIndex < 0 then
        return
    end

    self.curForgeMaterialEnough = true

    -- 角色头顶的装备名字
    local curEquip = self.curTabEquipData[self.curEquipIndex+1]
    local dataCfg = curEquip.config
    local curGoodsData = GoodsDataManager:createLocalGoodsData(dataCfg.id);
    self.curEquipName:show()
    self.curEquipName:setText(curGoodsData:getName())

    -- slots
    self.materialSlots = {}
    local tmpLayout = self.materialPanel:getChildByName("autoLayout")
    if tmpLayout then
        self.materialPanel:removeChildByName("autoLayout")
    end

    local tmpLayout2 = self.materialPanel:getChildByName("talentLayout")
    if tmpLayout2 then
        self.materialPanel:removeChildByName("talentLayout")
    end

    local autoLayout = UI.Layout:create();
    autoLayout:init();
    autoLayout:enableAutoWidth()
    autoLayout:enableAutoHeight()
    autoLayout:centerUp(20);
    autoLayout:setScale(0.8)
    autoLayout:setName("autoLayout")
    -- autoLayout:enableDebugDraw()
    self.materialPanel:addChild(autoLayout, 1)

    local discountPercent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.ForgeDiscountRate)

    local slotLayoutW = math.floor(MAT_PANEL_W/#dataCfg.material)
    for k, v in ipairs(dataCfg.material) do
        local slotLayout = UI.Layout:create();
        slotLayout:init();
        slotLayout:setSize(slotLayoutW, 120);
        slotLayout:floatLeft(0)
        autoLayout:addComponent(slotLayout)

        -- 独有背景
        local bg1 = UI.Image:create()
        bg1:init("ui_blacksmith_forging_dwon.png")
        -- bg1:centerUp(10)
        bg1:center()
        slotLayout:addChild(bg1)

        local matID = v.id
        local matNum = v.num
        -- 锻造天赋对材料需求量有打折效果，需要进行判断
        if discountPercent > 0 then
            matNum = math.ceil(matNum * (RATIO_NUMBER - discountPercent) / RATIO_NUMBER)
        end
        local goodsData = GoodsDataManager:createLocalGoodsData(matID);
        if goodsData then
            local goodsGrid = UI.GoodsGrid:create()
            goodsGrid:init(goodsData)
            -- goodsGrid:setScale(0.55)
            goodsGrid:setTouchClipNode(slotLayout)
            -- goodsGrid:centerUp(5)
            goodsGrid:center()
            goodsData:setIsNew(false)
            goodsGrid:showInfoArea(false, false)
            goodsGrid:setName("goodsSlot")
            slotLayout:addChild(goodsGrid)

            local unlockList = EquipForgeDataManager:getForgeUnlockList()
            if not unlockList[dataCfg.configID] or playUnlockEff then
                local lockEff = UI.Animation:create()
                lockEff:init("effect_ui_common_unlock.json", "effect_ui_common_unlock.atlas", 1);
                lockEff:leftUp(20, 38)
                if playUnlockEff then
                    lockEff:setAnimation("unlock", false)
                else
                    lockEff:setAnimation("idle", true)
                end
                slotLayout:addChild(lockEff, 10)
            end

            local prg = UI.Text:create()
            prg:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_36_181_118)
            prg:centerBottom()
            prg:setName("prg")
            local goodsNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(matID)
            prg:setText(goodsNum .. "/" .. matNum)
            if goodsNum < matNum then
                prg:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)

                self.curForgeMaterialEnough = false
            else
                prg:setFontColor(UI.FONT_COLOR_36_181_118)
            end
            slotLayout:addChild(prg)

            -- 物品名字
            -- local name = UI.Text:create()
            -- name:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_194_194_194)
            -- local goodsName = goodsData:getName()
            -- name:centerUp(90)
            -- name:setName("itemname")
            -- if LanguageManager:isChineseLanguage() then
            --     name:setText(goodsName)
            --     name:setWidth(60)
            --     name:setTextHorizontalCenter()
            -- else
            --     local showTxt = AvalonUtil:getSubNameStrByLabel(goodsName, 40, 14, true)
            --     name:setText(showTxt)
            -- end
            -- name:autoAdapt()
            -- slotLayout:addChild(name)
        end

        self.materialSlots[k] = slotLayout
    end

    -- 隐藏tip
    self.leftPanel:getChildByName("panel"):getChildByName("tipTxt"):hide()
    self.leftPanel:getChildByName("panel"):getChildByName("titleName"):show()

    -- 更新消耗的显示
    local unlockCfg = dataCfg.unlockConsume
    local forgeCfg = dataCfg.forgeConsume
    local funcBtn = self.materialPanel:getChildByName("funcBtn")
    local innerLayout = funcBtn:getChildByName("innerLayout")
    local btnTxt = innerLayout:getChildByName("btnTxt")
    local consumeIcon = innerLayout:getChildByName("consumeIcon")
    local consumeTxt = innerLayout:getChildByName("consumeTxt")
    local unlockList = EquipForgeDataManager:getForgeUnlockList()

    self.curForgeConsumeData = {}
    if unlockList[dataCfg.configID] then
        -- 锻造
        btnTxt:setText(UI.TEXT_1110396)

        -- 更新解锁/锻造功能按钮状态
        funcBtn:show()
        if not self.curForgeMaterialEnough then
            funcBtn:disable()
        else
            funcBtn:enable()
        end

        if forgeCfg.type == 1 then
            consumeIcon:setSpriteName("symbol_gaming_money.png")
        else
            consumeIcon:setSpriteName("symbol_gaming_diamond.png")
        end

        local showNum = AvalonUtil:getCommaNumber(forgeCfg.price)
        consumeTxt:setText(showNum)

        self.curForgeType = FORGE_TYPE.FORGE
        self.curForgeConsumeData.type = forgeCfg.type
        self.curForgeConsumeData.price = forgeCfg.price

        if discountPercent > 0 then
            local talentLayout = UI.Layout:create()
            talentLayout:init()
            talentLayout:centerBottom(30)
            talentLayout:enableAutoWidth()
            talentLayout:enableAutoHeight()
            talentLayout:setName("talentLayout")
            -- talentLayout:enableDebugDraw()
            self.materialPanel:addChild(talentLayout)
        
            local talentIcon = UI.Image:create()
            talentIcon:init("ui_icon_auxiliary_sub_5.png")
            talentIcon:setScale(0.4)
            talentIcon:leftUp(0, 0)
            talentIcon:floatLeft(0)
            talentLayout:addComponent(talentIcon)
        
            local txt = UI.Text:create()
            txt:init(UI.TEXT_1212367, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_192_192_192)
            txt:floatLeft(-20)
            talentLayout:addComponent(txt)
        
            local txt2 = UI.Text:create()
            txt2:init(math.ceil(discountPercent/100).."%", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
            txt2:floatLeft(0)
            talentLayout:addComponent(txt2)
        end
    else
        -- 解锁
        btnTxt:setText(UI.TEXT_1212363)

        funcBtn:show()
        funcBtn:enable()

        local tipTxt = self.leftPanel:getChildByName("panel"):getChildByName("tipTxt")
        tipTxt:show()
        tipTxt:setText(UI.TEXT_1212362)

        if unlockCfg.type == 1 then
            consumeIcon:setSpriteName("symbol_gaming_money.png")
        else
            consumeIcon:setSpriteName("symbol_gaming_diamond.png")
        end
        local showNum = AvalonUtil:getCommaNumber(unlockCfg.price)
        consumeTxt:setText(showNum)

        self.curForgeType = FORGE_TYPE.UNLOCK
        self.curForgeConsumeData.type = unlockCfg.type
        self.curForgeConsumeData.price = unlockCfg.price

        for k, v in ipairs(self.materialSlots) do
            v:getChildByName("prg"):hide()
            -- v:getChildByName("itemname"):hide()
        end
    end

    if self.curForgeConsumeData.type == 1 then
        if self.curForgeConsumeData.price > GameDataManager:getInstance():getCurCoin() then
            consumeTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            consumeTxt:setFontColor(UI.FONT_COLOR_50_50_44)
        end
    elseif self.curForgeConsumeData.type == 2 then
        if not Avalon.MathUtil:checkDiamonEnough(self.curForgeConsumeData.price, GameDataManager:getInstance():getDiamond()) then
            consumeTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            consumeTxt:setFontColor(UI.FONT_COLOR_50_50_44)
        end
    end

    innerLayout:updateView()
end

function EquipForgeLayer:initTabListData()
    self.btnData = {}
    for k, v in ipairs(TAB_DATA) do
        local data = {}
        data.icon = v.iconFileName
        data.select = false

        self.btnData[k] = data
    end

    self.btnData[1].select = true
    self.curTabIndex = 0
end

function EquipForgeLayer:makeTabList()
    self._tableView = UI.TableView.new({}, BTN_CELL_W, 464);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:leftUp(835, 74)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(true);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.EquipForgeBtnCell.new();
            cell:init(self.btnData[idx+1]);
        end,
        function(e) 
            printError("------------------------EquipForgeLayer:tableCellAtIndex-----------------error")
        end, 1);

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

        self:initEquipListData()
        self:resetPanel()
        self._equipList:reloadData(true)
        self:updateMaterialSlot()
        self:addQualityEffBG()
        self:trialEquip()
    end);

    self._bg:addChild(self._tableView);
    self._tableView:reloadData(true);
end

function EquipForgeLayer:resetPanel()
    -- left panel
    self.curEquipName:hide() 

    -- 清除试穿的装备
    local weaponEquipmentData = nil
    local displayWearList = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    self._roleAnimation:updateRoleEquipment(displayWearList)
    if (displayWearList) then
        for i = 1, #displayWearList do
            local equipmentData = displayWearList[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end
    self._roleAnimation:showIDLEAnimation(weaponEquipmentData)

    local panel = self.leftPanel:getChildByName("panel")
    panel:getChildByName("titleName"):hide()
    panel:getChildByName("funcBtn"):hide()
    panel:getChildByName("tipTxt"):show()
    panel:getChildByName("tipTxt"):setText(UI.TEXT_1212361)
    local tmpEff = self.leftPanel:getChildByName("qualityEffBG")
    if tmpEff then
        self.leftPanel:removeChildByName("qualityEffBG")
    end

    if self.materialSlots then
        for k, v in ipairs(self.materialSlots) do
            v:hide()
        end
    end

    if #self.curTabEquipData == 0 then
        self.noEquipShow:show()
    else
        self.noEquipShow:hide()
    end
end

function EquipForgeLayer:initRightPanel()
    self:initTabListData()

    -- 货币组件
    self._currencyPanel = UI.CurrencyPanel:create()
    self._currencyPanel:rightUp(135, 81 - 14.5 --[[货币组件空白高度大小]])
    self._currencyPanel:setShowShopButton(true, 52)
    self._bg:addChild(self._currencyPanel, 100)

    self:makeTabList()

    -- 背景
    local bgPaper = UI.Image:create()
    bgPaper:init("ui_deformation_paper.png")
    bgPaper:leftBottom(511, 47)
    self._bg:addChild(bgPaper)
    self.equipBG = bgPaper

    local noEquipShow = UI.Text:create()
    noEquipShow:init(UI.TEXT_1212366, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_41_41_45)
    noEquipShow:center()
    noEquipShow:hide()
    self.equipBG:addChild(noEquipShow, 5)
    self.noEquipShow = noEquipShow

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(319, 2))
    splitLine:centerBottom(428)
    bgPaper:addChild(splitLine)

    -- 装备列表
    self:initEquipListData()
end

function EquipForgeLayer:initEquipListData()
    self.curEquipIndex = -1
    self.lastEquipIndex = -1
    self.curTabEquipData = {}

    local equipList = EquipForgeDataManager:getEquipForgeListByType(self.curTabIndex+1);
    local listIdx = 1
    for k, v in ipairs(equipList) do
        if GameDataManager:getEquipForgeGroupID() >= v.unlockPoint then
            local data = {}
            data.idx = k
            data.id = v.id
            data.new = EquipForgeDataManager:getForgeEquipIsNew(v.configID)
            data.select = false
            data.config = v
            self.curTabEquipData[listIdx] = data

            listIdx = listIdx + 1
        end
    end

    -- 默认选中第一个
    if #self.curTabEquipData > 0 then
        self.curEquipIndex = 0
        self.lastEquipIndex = 0
        self.curTabEquipData[1].select = true
    end
end

function EquipForgeLayer:updateEquipListShow()
    self._equipList = UI.TableView.new({}, EQUIP_CELL_W+2, 408);
    self._equipList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._equipList:centerUp(50)
    self._equipList:setDelegate();
    self._equipList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._equipList:setBounceable(true);
    self._equipList:init();
    self._equipList:onUpdateCellSize(function (table,idx)
        return EQUIP_CELL_W, EQUIP_CELL_H;
    end);

    self._equipList:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.EquipForgeEquipCell.new();
            cell:init(self.curTabEquipData[idx+1], self.cellPlayUnlockEff);
            self.cellPlayUnlockEff = false
        end,
        function(e) 
            printError("------------------------_equipList:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    self._equipList:onUpdateCellNumbers(function ()
        return table.nums(self.curTabEquipData);
    end);

    self._equipList:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        if self.curEquipIndex == cell:getIdx() then
            return
        end

        self.curEquipIndex = cell:getIdx()

        EquipForgeDataManager:setForgeEquipIsNew(self.curTabEquipData[self.curEquipIndex+1].config.configID)
        self.curTabEquipData[self.curEquipIndex+1].new = false
        self.curTabEquipData[self.curEquipIndex+1].select = true
        self._equipList:updateCellAtIndex(self.curEquipIndex)

        if self.lastEquipIndex >= 0 then
            self.curTabEquipData[self.lastEquipIndex+1].select = false
            self._equipList:updateCellAtIndex(self.lastEquipIndex)
        end

        self.lastEquipIndex = self.curEquipIndex

        self:updateMaterialSlot()
        self:addQualityEffBG()
        self:trialEquip()
    end);

    self.equipBG:addChild(self._equipList);
    self._equipList:reloadData(true, true);
end

function EquipForgeLayer:addQualityEffBG()
    if self.curEquipIndex < 0 then
        return
    end

    local colorMap = {
        [3] = "idle_yellow",
        [4] = "idle_orange",
        [5] = "idle_purple",
        [6] = "idle_red",
    }

    local equipID = self.curTabEquipData[self.curEquipIndex+1].config.id
    local goodsData = GoodsDataManager:createLocalGoodsData(equipID);
    local quality = goodsData:getGoodsRare()
    local animationName = colorMap[quality]
    if not animationName then
        return
    end

    local tmpEff = self.leftPanel:getChildByName("qualityEffBG")
    if tmpEff then
        self.leftPanel:removeChildByName("qualityEffBG")
    end

    local qualityEffBG = UI.Animation:create()
    qualityEffBG:init("effect_ui_town_blacksmith_new_forge_zhujue.json", "effect_ui_town_blacksmith_new_forge_zhujue.atlas", 1);
    qualityEffBG:centerBottom(190)
    qualityEffBG:setAnimation(animationName, false)
    qualityEffBG:setName("qualityEffBG")
    self.leftPanel:addChild(qualityEffBG, 2)
    self.qualityEffBG = qualityEffBG
end

function EquipForgeLayer:updateQualityEff()
    local colorMap = {
        [3] = "trigger_yellow",
        [4] = "trigger_orange",
        [5] = "trigger_purple",
        [6] = "trigger_red",
    }

    local config = EquipForgeDataManager:getEquipForgeConfigByID(self.svrRetCurData.scrollID);
    local goodsData = GoodsDataManager:createLocalGoodsData(config.name);
    local quality = goodsData:getGoodsRare()
    local animationName = colorMap[quality]
    if not animationName then
        return
    end

    local tmpEff = self.leftPanel:getChildByName("qualityEff")
    if tmpEff then
        self.leftPanel:removeChildByName("qualityEff")
    end

    local qualityEff = UI.Animation:create()
    qualityEff:init("effect_ui_town_blacksmith_new_forge_zhujue.json", "effect_ui_town_blacksmith_new_forge_zhujue.atlas", 1);
    qualityEff:centerBottom(190)
    qualityEff:setAnimation(animationName, false)
    qualityEff:setName("qualityEff")
    self.leftPanel:addChild(qualityEff, 20)
    qualityEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
        if self and not tolua.isnull(self) then
            local tmpEffBG = self.leftPanel:getChildByName("qualityEffBG")
            if tmpEffBG then
                tmpEffBG:show()
            end

            self.lockRefreshEff = false

            local tipLayer = UI.EquipForgeSuccessLayer:create()
            tipLayer:center();
            tipLayer:init(self.svrRetCurData.entryID)
            tipLayer:setName("EquipForgeSuccessLayer")
            self._rootLayer:addChild(tipLayer, UI_ZORDER.ACTIVITY);
            tipLayer:openShow();
            tipLayer:setGoBackWin(self);

            self.lockingFuncBtn = false

            EquipForgeDataManager:clearSortedList()
            self:initEquipListData()
            self._equipList:reloadData(true);
            self:updateMaterialSlot()
            self:addQualityEffBG()
            self:trialEquip()
        end
    end)
end

function EquipForgeLayer:trialEquip()
    if self.curEquipIndex < 0 then
        return
    end

    local equipID = self.curTabEquipData[self.curEquipIndex+1].config.id
    local displayWearList = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    local trialEquipData = GoodsDataManager:createEquipmentForEquipmentID(equipID)
    for k, v in ipairs(displayWearList) do
        if v:getEquipmentType() == trialEquipData:getEquipmentType() then
            table.remove(displayWearList, k)
            break
        end
    end

    table.insert(displayWearList, trialEquipData)

    self._roleAnimation:updateRoleEquipment(displayWearList)

    local weaponEquipmentData = nil
    if (displayWearList) then
        for i = 1, #displayWearList do
            local equipmentData = displayWearList[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end
    self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
end

-- 模版函数：更新组建的视图(必备)
function EquipForgeLayer:onUpdateView()
    self:updateEquipListShow()
    self:updateMaterialSlot()
    self:addQualityEffBG()
    self:trialEquip()
end

function EquipForgeLayer:doEquipForge()
    if self.lockingFuncBtn then
        return
    end

    if self.curForgeType == 2 then
        -- 判断背包是否有空间
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if(freePacketNum <= 0) then
            UI.ScrollBar:createByText(UI.TEXT_1212011)
            return
        end
    end

    -- 判断货币消耗
    if self.curForgeConsumeData.type == 1 then
        -- 判断金币
        local coin = GameDataManager:getInstance():getCurCoin()
        if coin < tonumber(self.curForgeConsumeData.price) then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end
    else
        -- 判断钻石
        local diamond = GameDataManager:getInstance():getDiamond()
        if not Avalon.MathUtil:checkDiamonEnough(tonumber(self.curForgeConsumeData.price), diamond) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
    end

    local curEquip = self.curTabEquipData[self.curEquipIndex+1]
    local dataCfg = curEquip.config
    Net.NetNPCSystem:reqEquipForge(dataCfg.configID, self.curForgeType, self._npcSpriteID)

    self.lockingFuncBtn = true
end

-- 事件处理 --
---------------------------------------
function EquipForgeLayer:onForgeOver(data)
    if tonumber(data.result) ~= 1 then
        self.lockingFuncBtn = false
        self.lockRefreshEff = false
        return
    end

    self.svrRetCurData = data
    if data.optType == 1 then
        -- 解锁
        self.cellPlayUnlockEff = true
        self._equipList:updateCellAtIndex(self.curEquipIndex)

        self:updateMaterialSlot(true)

        self.lockingFuncBtn = false
    else
        -- 锻造
        self.lockRefreshEff = true
        self.NPCAnimation:setAnimation("idle2", false)
        self.NPCAnimation:addAnimation("idle1", true)
        performWithDelay(self, function()
            Avalon.AudioManager:playSound("1545")
        end, 0.8)
        self.NPCAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
            if self and not tolua.isnull(self) then
                if event.animation == "idle2" then
                    local tmpEffBG = self.leftPanel:getChildByName("qualityEffBG")
                    if tmpEffBG then
                        tmpEffBG:hide()
                    end
                    self:updateQualityEff()
                end
            end
        end)
    end
end

function EquipForgeLayer:onCurrencyChangeHandler()
    if self.svrRetCurData and self.svrRetCurData.optType == 1 then
        -- 解锁时不需要重新刷新列表
        return
    end

    if self.lockRefreshEff then
        return
    end

    EquipForgeDataManager:clearSortedList()
    self:initEquipListData()
    self._equipList:reloadData(true);
    self:updateMaterialSlot()
    self:addQualityEffBG()
    self:trialEquip()
end

function EquipForgeLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_NPC_EQUIP_FORGE_UNLOCK, self,self.onForgeOver)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function EquipForgeLayer:unregisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_NPC_EQUIP_FORGE_UNLOCK, self,self.onForgeOver)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end
---------------------------------------
-- eo 事件处理 --
