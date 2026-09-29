------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MannorUpgradeLayer = class("MannorUpgradeLayer", UI.HWBtnComponent)
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470
local BTN_CELL_W = 210
local BTN_CELL_H = 52
local RIGHT_COM_W = 410
local RIGHT_COM_H = 420

local CELL_WIDTH = 384
local CELL_HEIGHT = 80
local TABLE_WIDTH = 384
local TABLE_HEIGHT = 390

function MannorUpgradeLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function MannorUpgradeLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function MannorUpgradeLayer:ctor(buildId)
    MannorUpgradeLayer.super.ctor(
    	self,
    	UI.Type.MANOR_UPGRADE_VIEW,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.buildId = buildId
    self.tableCellArr = {}
    self.buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.buildId)
    self.targets = {}
    self:bindModel()
end

function MannorUpgradeLayer:init( ... )
    MannorUpgradeLayer.super.init(self, ... )
    self.isEmbattling = false
    -- self.buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.buildId)
    self.targets = self.buildData.targets
end

function MannorUpgradeLayer:dtor()
    MannorUpgradeLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    self.isEmbattling = false
    self.buildData = {}
    self.targets = {}
    reload_script_file_mvc("app.modules.manorappearance.MannorUpgradeLayer")
end

function MannorUpgradeLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_navigation_paperbg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 左侧内容面板
    local leftContentLayout = UI.Layout:create()
    leftContentLayout:init()
    leftContentLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    leftContentLayout:leftUp(35, 80)
    self.contentLayout:addChild(leftContentLayout)
    self.leftContentLayout = leftContentLayout

    local leftTitle = UI.Text:create()
    leftTitle:init(UI.TEXT_221913, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    leftTitle:centerUp(-14)
    self.leftContentLayout:addChild(leftTitle)
    self.leftTitle = leftTitle

    -- 背景图片
    local leftTitleLine  = UI.Image:create()
    leftTitleLine:init("ui_navigation_line_2.png")
    leftTitleLine:centerUp(15)
    self.leftContentLayout:addChild(leftTitleLine)

    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    rightContentLayout:rightUp(35, 80)
    self.contentLayout:addChild(rightContentLayout)
    self.rightContentLayout = rightContentLayout

    -- 升级按钮
    local upgradeBtn = UI.Button:create();
    upgradeBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    upgradeBtn:centerBottom(0, 0)
    -- upgradeBtn:setText(UI.TEXT_221914)
    -- upgradeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    upgradeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onClickUpgrade)
    leftContentLayout:addChild(upgradeBtn, 300)
    self.upgradeBtn = upgradeBtn

    local oneCostNode = UI.Layout:create()
    oneCostNode:init()
    oneCostNode:setSize(28, 28)
    oneCostNode:centerLeft(20, 0)
    upgradeBtn:addChild(oneCostNode, 10)
    self.oneCostNode = oneCostNode
    -- oneCostNode:enableDebugDraw()

    local oneCostIcon = UI.Image:create()
    oneCostIcon:init("")
    oneCostIcon:center()
    oneCostNode:addChild(oneCostIcon, 10)
    self.oneCostIcon = oneCostIcon

    local oneCostNumber = UI.Text:create()
    oneCostNumber:init("10", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    oneCostNumber:center(oneCostIcon:getContentSize().width+25, 5)
    oneCostNode:addChild(oneCostNumber, 300)
    self.oneCostNumber = oneCostNumber

    local oneText = UI.Text:create()
    oneText:init(UI.TEXT_221914, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    oneText:centerLeft(100, 0)
    upgradeBtn:addChild(oneText, 10)
    self.oneText = oneText

    local rightTitle = UI.Text:create()
    rightTitle:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightTitle:centerUp(-14)
    self.rightContentLayout:addChild(rightTitle)
    self.rightTitle = rightTitle

    -- 背景图片
    local rightTitleLine  = UI.Image:create()
    rightTitleLine:init("ui_navigation_line_2.png")
    rightTitleLine:centerUp(15)
    self.rightContentLayout:addChild(rightTitleLine)

    -- performWithDelay(self, function() 
    --     self:initSailDetail()
    --     self:initConditionLayer()
    --     self:updateUpgradeView()
    -- end, 0.01)
    self:initSailDetail()
    self:initConditionLayer()
    self:updateUpgradeView()
end

function MannorUpgradeLayer:tabCellClick(index)
    if not index then
        return
    end

    local clickIndex = index

    if self.curTabIndex == clickIndex then
        return
    end

    self.curTabIndex = clickIndex
    self.btnData[self.curTabIndex].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex - 1)

    -- 如果没有self.btnData[self.lastTabIndex]可能是活动关闭页签消失了，自动跳转
    -- if self.lastTabIndex > 0 and self.btnData[self.lastTabIndex] then
    --     self.btnData[self.lastTabIndex].select = false
    --     self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    -- end

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex, index)


    self.lastTabIndex = self.curTabIndex
    self:updateSailLayer(index)
end


function MannorUpgradeLayer:initSailDetail()
    self.dockConfig = ConfigManager:getAllMannorControlerDataByID(self.buildData.level)
    self:createUpgradeLayer()

end

function MannorUpgradeLayer:initConditionLayer()
    local line  = UI.Image:create()
    line:init("ui_navigation_line_3.png")
    line:centerUp(240)
    self.leftContentLayout:addChild(line)

    local unlockTitle = UI.Text:create()
    unlockTitle:init(UI.TEXT_222907, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    unlockTitle:centerUp(237)
    self.leftContentLayout:addChild(unlockTitle)

    -- 内容面板
    local conditionLayout = UI.Layout:create()
    conditionLayout:init()
    conditionLayout:setSize(384, 170)
    conditionLayout:centerUp(45)
    self.leftContentLayout:addChild(conditionLayout)
    self.conditionLayout = conditionLayout

    -- 内容面板
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:setSize(384, 170)
    unlockLayout:centerUp(270)
    self.leftContentLayout:addChild(unlockLayout)
    self.unlockLayout = unlockLayout

    -- 内容面板
    local progressLayout = UI.Layout:create()
    progressLayout:init()
    progressLayout:setSize(344, 25)
    progressLayout:centerUp(385)
    self.leftContentLayout:addChild(progressLayout)
    -- progressLayout:enableDebugDraw()
    self.progressLayout = progressLayout

    local maxLevelText = UI.Text:create()
    maxLevelText:init(UI.TEXT_222727, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_94_37_37)
    maxLevelText:centerUp(385)
    self.leftContentLayout:addChild(maxLevelText)
    self.maxLevelText = maxLevelText

    -- 庄园预览
    local mask = UI.Image:create()
    mask:init("ui_navigation_floorbg_2.png")
    mask:center()
    conditionLayout:addChild(mask, 10)

    local clipperInnerNode = UI.Layout:create()
    clipperInnerNode:init()
    clipperInnerNode:setSize(355, 200)
    clipperInnerNode:center()
    self.clipperInnerNode = clipperInnerNode

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(335, 195)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    mask:addChild(clipper)
    -- clipper:setOpacityFilterTouch(false)
    -- clipper:enableDebugDraw()
    -- clipper:setAlphaThreshold(1)
    
    

    local conditionBg  = UI.Image:create()
    conditionBg:init("")
    conditionBg:center()
    clipperInnerNode:addChild(conditionBg, 100)
    self.conditionBg = conditionBg

    -- 背景图片
    local unlockBg  = UI.Image:create()
    unlockBg:init("ui_manorupgrade_bg_1.png")
    unlockBg:centerUp(0)
    unlockLayout:addChild(unlockBg)

    -- local str = tonumber(v) == 0 and " " or languageManagerInstance:getLocalString(tonumber(v)) 
    local unlockTxt = UI.Text:create()
    unlockTxt:init("" , UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    unlockTxt:setWidth(365)
    unlockTxt:autoAdapt()
    unlockTxt:centerUp(10)
    unlockTxt:setTextCenter()
    unlockLayout:addChild(unlockTxt)
    self.unlockTxt = unlockTxt

    -- local conditionsTxt = UI.Text:create()
    -- conditionsTxt:init("" , UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    -- conditionsTxt:setWidth(365)
    -- conditionsTxt:autoAdapt()
    -- conditionsTxt:centerUp(10)
    -- conditionsTxt:setTextCenter()
    -- conditionLayout:addChild(conditionsTxt)
    -- self.conditionsTxt = conditionsTxt

    local progressTitle = UI.Text:create()
    progressTitle:init(UI.TEXT_222723 , UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    progressTitle:centerUp(-29)
    progressLayout:addChild(progressTitle)

    local progressTxt = UI.Text:create()
    progressTxt:init("" , UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    progressTxt:centerUp(0)
    progressLayout:addChild(progressTxt, 300)
    self.progressTxt = progressTxt

    local progress = UI.ProgressTimer:create()
    progress:init("ui_manorupgrade_schedulebg.png", "ui_manorupgrade_schedule.png", "ui_manorupgrade_schedule.png")
    progress:centerLeft(-15, 0)
    progressLayout:addChild(progress)
    self.progress = progress

    local addBtn = UI.Button:create()
    addBtn:init('ui_shopping_button_0.png', 'ui_shopping_button_1.png', 'ui_shopping_button_0.png')
    addBtn:center(185, 0)
    addBtn:closeClickScale()
    addBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.putMaterial)
    progressLayout:addChild(addBtn, 200)
end

function MannorUpgradeLayer:createUpgradeLayer()
    -- local materialID = self.dockConfig.toNextLevelMaterialID
    -- local idList = string.split(materialID, ";")
    -- self.targets

    self._upgradeTableView = UI.TableView.new({}, TABLE_WIDTH, TABLE_HEIGHT)
    self._upgradeTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._upgradeTableView:center(0, 10)
    self._upgradeTableView:setDelegate()
    self._upgradeTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._upgradeTableView:setBounceable(true)
    self._upgradeTableView:init()
    -- self._upgradeTableView:enableDebugDraw()
    self._upgradeTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT+10
    end)

    self._upgradeTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createUpgradeCell(self.targets[index])
            end,
            function(e)
                printError("------------------------MannorUpgradeLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("image")
            if image and tolua.isnull(image) then
                image:removeFromParent()
                image = nil
            end
            cell = self:createUpgradeCell(self.targets[index])
        end

        return cell
    end)

    self._upgradeTableView:onUpdateCellNumbers(function ()
        return table.nums(self.targets)
    end)

    self.rightContentLayout:addChild(self._upgradeTableView, 100)
    self._upgradeTableView:reloadData(true)
end

function MannorUpgradeLayer:createUpgradeCell(data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))
    
    local materialID = data.materialId
    -- local idList = string.split(materialID, ",")

    local image = UI.Image.create()
    image:init("ui_navigation_list_03.png")
    image:center()
    image:setName("image")
    cell:addChild(image)

    -- local numList = string.split(self.dockConfig.toNextLevelMaterialNum, ",")
    -- local needNum = numList[index]
    -- local id = tonumber(idList[index])
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, materialID)
    -- local buildMaterialData = GameInManorManager:getInstance():getPackedMannorMaterialData(self.buildData)

    local goodData = GoodsDataManager:createLocalGoodsData(materialID)
    goodData:setIsNew(false)
    -- goodData:setNum(itemTotalNum)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center()
    goodsGrid:init(goodsData)
    goodsGrid:centerLeft(15)
    goodsGrid:showInfoArea(true, false)
    cell:addChild(goodsGrid)

    local nameBg = UI.Image.create()
    nameBg:init("ui_manorupgrade_bg_2.png")
    nameBg:centerLeft(90, -5)
    cell:addChild(nameBg)

    local materialName = UI.Text:create()
    materialName:init(string.format(UI.TEXT_222721, languageManagerInstance:getLocalString(goodData.name), data.count) , UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    materialName:centerLeft(25, 0)
    nameBg:addChild(materialName)

    local expGetTxt = UI.Text:create()
    expGetTxt:init(string.format(UI.TEXT_222722, data.exp), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    expGetTxt:centerLeft(115, 7)
    cell:addChild(expGetTxt)

    local finishedImg = UI.Image.create()
    finishedImg:init("ui_manorupgrade_finish.png")
    finishedImg:centerRight(22, 0)
    cell:addChild(finishedImg)

    local commitBtn = UI.Button:create();
    commitBtn:init("ui_manorupgrade_btn_1.png","ui_manorupgrade_btn_1.png","ui_manorupgrade_btn_2.png");
    commitBtn:centerRight(22)
    commitBtn:setText(UI.TEXT_1212071)
    commitBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    commitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onCommitTarget(materialID)
    end)
    -- commitBtn:setScaleY(0.6)
    -- commitBtn:setScaleX(0.5)
    cell:addChild(commitBtn)
    commitBtn:disable()
    if itemTotalNum >= data.count and self.dockConfig.expToNextLV > self.buildData.exp then
        commitBtn:enable()
    end

    -- local isFinished = mvc.manorAppearanceModel:checkTargetIsFinished(data)
    commitBtn:setVisible(not data.isFinished)
    finishedImg:setVisible(data.isFinished)

    return cell
end

function MannorUpgradeLayer:updateProgress()
    self._upgradeTableView:reloadData(true)
end

function MannorUpgradeLayer:putMaterial()
    local allMannorConfig = ConfigManager:getAllMannorControlerData()

    local manorEXPMaterialList = string.split(ConfigManager:getGeneralForKey("manorEXPMaterial"), ",") 
    local id = tonumber(manorEXPMaterialList[1])
    local expNum = tonumber(manorEXPMaterialList[2])
    local itemData = ConfigManager:getVirtualItemConfigByID(id) or ConfigManager:getMaterialConfigByID(id) 
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, id)

    assert(self.dockConfig.expToNextLV < self.buildData.exp, ":MannorUpgradeLayerputMaterial invalid package exp num")

    local limit 
    local limit1, limit2 = math.modf((self.dockConfig.expToNextLV - self.buildData.exp)/expNum)
    if limit2 and limit2 > 0 then
        limit = limit1+1
    else
        limit = limit1
    end
    
    local maxLimitDesStr = string.format(UI.TEXT_222729, expNum)
    itemData.maxLimit = limit
    itemData.maxLimitDes = maxLimitDesStr
    require "app.ui.tips.ItemBatchCostTips"
    local materialCostLayer = UI.ItemBatchCostTips:show(itemData, function (num)
        self:onComfirmed(num)
    end)
    self.contentLayout:addChild(materialCostLayer, 300)
end

function MannorUpgradeLayer:updateUpgradeView()
    self.buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.buildId)
    self.targets = self.buildData.targets
    self.dockConfig = ConfigManager:getAllMannorControlerDataByID(self.buildData.level)
    if self.dockConfig.expToNextLV > 0 then
        self.maxLevelText:hide()
        local isCanUpgrade = self.buildData.exp >= self.dockConfig.expToNextLV
        self.progressLayout:setVisible(not isCanUpgrade)
        self.progress:setPercent(self.buildData.exp/self.dockConfig.expToNextLV)
        self.upgradeBtn:setVisible(isCanUpgrade)
        if isCanUpgrade then
            -- local manorEXPMaterialList = string.split(ConfigManager:getGeneralForKey("manorEXPMaterial"), ",")
            local id = self.dockConfig.raiseNeedID--tonumber(manorEXPMaterialList[1])
            local itemData = ConfigManager:getMaterialConfigByID(id) or ConfigManager:getVirtualItemConfigByID(id)
            self.oneCostIcon:setSpriteName(itemData.miniIcon)
            local pk = RoleDataManager:getMaster():getPK()
            -- local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, self.dockConfig.raiseNeedID)
            self.oneCostNumber:setText(self.dockConfig.raiseNeedNum)
        else
            local progressTxtStr = string.format(UI.TEXT_222725, self.buildData.exp, self.dockConfig.expToNextLV)
            self.progressTxt:setText(progressTxtStr)
        end
    else
        self.progressLayout:hide()
        self.upgradeBtn:hide()
        self.maxLevelText:show()
    end
    
    self.conditionBg:setSpriteName(self.dockConfig.manorShow..".png")
    local finishedTargetsNum = mvc.manorAppearanceModel:getMannorDailyTargetFinishNum(self.buildData.targets)
    local rightTitleStr = string.format(UI.TEXT_222724, finishedTargetsNum, table.nums(self.buildData.targets))
    self.rightTitle:setText(rightTitleStr)
    self.leftTitle:setText(languageManagerInstance:getLocalString(self.dockConfig.manorShowDesc))

    self.unlockTxt:setText(languageManagerInstance:getLocalString(self.dockConfig.unlockContent))

    

    self:updateProgress()
end

function MannorUpgradeLayer:onCommitTarget(materialID)
    if self.dockConfig.expToNextLV <= 0 or self.buildData.exp >= self.dockConfig.expToNextLV then
        UI.ScrollBar:createByText(UI.TEXT_222728)
        return
    end

    Net.NetManorSystem:reqCommitMannorTarget(materialID)
end

function MannorUpgradeLayer:onComfirmed(num)
    if num > 0 then
        Net.NetManorSystem:reqAddMannorEXP(num)
    end
end

function MannorUpgradeLayer:onClickUpgrade()
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, self.dockConfig.raiseNeedID)
    if itemTotalNum < self.dockConfig.raiseNeedNum then
        UI.ScrollBar:createByText(UI.TEXT_222730)
        return
    end

    Net.NetManorSystem:reqUpgradeMannorLevel()
end

return MannorUpgradeLayer












