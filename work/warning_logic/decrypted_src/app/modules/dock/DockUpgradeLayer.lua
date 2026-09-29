------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockUpgradeLayer = class("DockUpgradeLayer", UI.HWBtnComponent)
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
local TABLE_HEIGHT = 280

function DockUpgradeLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function DockUpgradeLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function DockUpgradeLayer:ctor(buildId, uiType)
    DockUpgradeLayer.super.ctor(
    	self,
    	uiType,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.buildId = buildId
    self.tableCellArr = {}
    self.buildData = {}
    self:bindModel()
end

function DockUpgradeLayer:init( ... )
    DockUpgradeLayer.super.init(self, ... )
    self.isEmbattling = false
    self.buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.buildId)
end

function DockUpgradeLayer:dtor()
    DockUpgradeLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    self.isEmbattling = false
    self.buildData = {}
    self.buildId = nil
    reload_script_file_mvc("app.modules.dock.DockUpgradeLayer")
end

function DockUpgradeLayer:onInitView()

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
    upgradeBtn:setText(UI.TEXT_221914)
    upgradeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    upgradeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onClickUpgrade)
    rightContentLayout:addChild(upgradeBtn)
    self.upgradeBtn = upgradeBtn

    local rightTitle = UI.Text:create()
    rightTitle:init(UI.TEXT_221912, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightTitle:centerUp(-14)
    self.rightContentLayout:addChild(rightTitle)

    -- 背景图片
    local rightTitleLine  = UI.Image:create()
    rightTitleLine:init("ui_navigation_line_2.png")
    rightTitleLine:centerUp(15)
    self.rightContentLayout:addChild(rightTitleLine)

    performWithDelay(self, function() 
        self:initSailDetail()
        self:initConditionLayer()
        self:updateUpgradeView()
    end, 0.01)
    
end

function DockUpgradeLayer:tabCellClick(index)
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


function DockUpgradeLayer:initSailDetail()
    self.dockConfig = GameInManorManager:getInstance():getBuildUpDataByLevel(self.buildId, self.buildData.level)
    self:createUpgradeLayer()

end

function DockUpgradeLayer:initConditionLayer()
    local line  = UI.Image:create()
    line:init("ui_navigation_line_3.png")
    line:centerUp(215)
    self.leftContentLayout:addChild(line)

    local unlockTitle = UI.Text:create()
    unlockTitle:init(UI.TEXT_222907, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    unlockTitle:centerUp(212)
    self.leftContentLayout:addChild(unlockTitle)

    -- 内容面板
    local conditionLayout = UI.Layout:create()
    conditionLayout:init()
    conditionLayout:setSize(384, 170)
    conditionLayout:centerUp(30)
    self.leftContentLayout:addChild(conditionLayout)
    self.conditionLayout = conditionLayout

    -- 内容面板
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:setSize(384, 170)
    unlockLayout:centerUp(250)
    self.leftContentLayout:addChild(unlockLayout)
    self.unlockLayout = unlockLayout

    -- 背景图片
    local conditionBg  = UI.Image:create()
    conditionBg:init("ui_navigation_paperbg_2.png")
    conditionBg:center()
    conditionLayout:addChild(conditionBg)

    -- 背景图片
    local unlockBg  = UI.Image:create()
    unlockBg:init("ui_navigation_paperbg_2.png")
    unlockBg:center()
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

    local conditionsTxt = UI.Text:create()
    conditionsTxt:init("" , UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    conditionsTxt:setWidth(365)
    conditionsTxt:autoAdapt()
    conditionsTxt:centerUp(10)
    conditionsTxt:setTextCenter()
    conditionLayout:addChild(conditionsTxt)
    self.conditionsTxt = conditionsTxt
end

function DockUpgradeLayer:createUpgradeLayer()
    local materialID = self.dockConfig.toNextLevelMaterialID
    local idList = string.split(materialID, ";")

    self._upgradeTableView = UI.TableView.new({}, TABLE_WIDTH, TABLE_HEIGHT)
    self._upgradeTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._upgradeTableView:center(0, -50)
    self._upgradeTableView:setDelegate()
    self._upgradeTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._upgradeTableView:setBounceable(true)
    self._upgradeTableView:init()
    self._upgradeTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT+10
    end)

    self._upgradeTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createUpgradeCell(index)
            end,
            function(e)
                printError("------------------------DockUpgradeLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("image")
            if image and tolua.isnull(image) then
                image:removeFromParent()
                image = nil
            end
            cell = self:createUpgradeCell(index)
        end

        return cell
    end)

    self._upgradeTableView:onUpdateCellNumbers(function ()
        return table.nums(idList)
    end)

    self.rightContentLayout:addChild(self._upgradeTableView, 100)
    self._upgradeTableView:reloadData(true)
end

function DockUpgradeLayer:createUpgradeCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))
    
    local materialID = self.dockConfig.toNextLevelMaterialID
    local idList = string.split(materialID, ";")
    if table.nums(idList) < 2 then
        return cell
    end
    local image = UI.Image.create()
    image:init("ui_navigation_list_03.png")
    image:center()
    image:setName("image")
    cell:addChild(image)

    local numList = string.split(self.dockConfig.toNextLevelMaterialNum, ";")
    local needNum = tonumber(numList[index])
    local id = tonumber(idList[index])
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, id)
    local buildMaterialData = GameInManorManager:getInstance():getPackedBuildMaterialData(self.buildData)

    local goodData = GoodsDataManager:createLocalGoodsData(id)
    goodData:setIsNew(false)
    -- goodData:setNum(itemTotalNum)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center()
    goodsGrid:init(goodsData)
    goodsGrid:centerLeft(15)
    goodsGrid:showInfoArea(true, false)
    cell:addChild(goodsGrid)

    -- local percent = itemTotalNum/needNum
    local prg = UI.ProgressTimer:create()
    prg:init("ui_navigation_progressbarbg.png", "ui_navigation_progressbar.png", "ui_navigation_progressbar.png")
    prg:center(10, 10)

    local curNum = buildMaterialData[id] or 0
    prg:setPercent(curNum/needNum)
    cell:addChild(prg)
    self.prg = prg

    local color = tonumber(curNum) < tonumber(needNum) and UI.FONT_COLOR_94_37_37 or UI.FONT_COLOR_101_206_54
    local proDes = AvalonUtil:serializeText(string.format("/%s", needNum), AvalonUtil:colorRGB2Str(UI.FONT_COLOR_41_41_45), UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
    local proNum = AvalonUtil:serializeText(tostring(curNum), AvalonUtil:colorRGB2Str(color), UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
    local richText = UI.RichText:create()
    local success = richText:init(proNum..proDes, 120, 20, false)
    richText:center(-27, -10)
    cell:addChild(richText) 

    local addBtn = UI.Button:create()
    addBtn:init('ui_navigation_icon_add.png', 'ui_navigation_icon_add.png', 'ui_navigation_icon_add.png')
    addBtn:centerRight(12)
    addBtn:closeClickScale()
    addBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local itemData = ConfigManager:getMaterialConfigByID(id) or ConfigManager:getVirtualItemConfigByID(id)
        itemData.maxLimit = tonumber(needNum)-curNum
        -- itemData.maxLimitDes = 
        require "app.ui.tips.ItemBatchCostTips"
        local materialCostLayer = UI.ItemBatchCostTips:show(itemData, function (num)
            self:onComfirmed(id, num)
        end)
        self.contentLayout:addChild(materialCostLayer, 300)
    end)

    addBtn:setName("addBtn")
    image:addChild(addBtn)
    addBtn:setVisible(curNum < needNum)

    return cell
end

function DockUpgradeLayer:updateProgress()
    self._upgradeTableView:reloadData(true)
end

function DockUpgradeLayer:updateUpgradeView()
    self.buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.buildId)
    self.dockConfig = GameInManorManager:getInstance():getBuildUpDataByLevel(self.buildId, self.buildData.level)
    self.conditionsTxt:setText(languageManagerInstance:getLocalString(self.dockConfig.unlockConditions))
    self.unlockTxt:setText(languageManagerInstance:getLocalString(self.dockConfig.unlockContent))
    if self.dockConfig.toNextLevelMaterialID == "" then
        self.upgradeBtn:setVisible(false)
    end
    
    self:updateProgress()
end

function DockUpgradeLayer:onComfirmed(id, num)
    if num > 0 then
        local data = {}
        data.id = id
        data.count = num
        Net.NetManorSystem:requestAddMaterial(self.buildId, data)
    end
end

function DockUpgradeLayer:onClickUpgrade()
    local preBuildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.dockConfig.preType)
    -- if  preBuildData.level < tonumber(self.dockConfig.preNPCLV) then
    if not self:checkCanUpgrade() then
        UI.ScrollBar:createByText(UI.TEXT_222726)
        return
    end
    Net.NetManorSystem:requestBuildUpgrade(self.buildId)
end

function DockUpgradeLayer:checkCanUpgrade()
    local can = true
    local materialID = self.dockConfig.toNextLevelMaterialID
    local idList = string.split(materialID, ";")

    local numList = string.split(self.dockConfig.toNextLevelMaterialNum, ";")
    local buildMaterialData = GameInManorManager:getInstance():getPackedBuildMaterialData(self.buildData)

    local preBuildData = GameInManorManager:getInstance():getBuildDataByBuildId(self.dockConfig.preType)
    if  preBuildData.level < tonumber(self.dockConfig.preNPCLV) then
        can = false
    end
    if can then
        for k, v in pairs(numList) do
            local id = tonumber(idList[k])
            local curNum = buildMaterialData[id] or 0
            if curNum < tonumber(v) then
                can = false
                break
            end
        end
    end
    return can
end


return DockUpgradeLayer












