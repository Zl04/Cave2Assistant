------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

require "app.modules.dock.DockSeamanLayer"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockSailLayer = class("DockSailLayer", UI.HWBtnComponent)
local PetPacketLayer = require("app.modules.dock.DockPetPacketLayer")

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
    "ui_general_shopping.plist",
    "ui_town_expedition.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470
local BTN_CELL_W = 210
local BTN_CELL_H = 52
local RIGHT_COM_W = 680
local RIGHT_COM_H = 410

function DockSailLayer:bindModel()

end

function DockSailLayer:unbindModel()

end

function DockSailLayer:ctor()
    DockSailLayer.super.ctor(
    	self,
    	UI.Type.DOCK_SAIL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    -- self.activityID = activityID
    self.tableCellArr = {}

    self:bindModel()
end

function DockSailLayer:init( ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    DockSailLayer.super.init(self, ... )
    self.isEmbattling = false
end

function DockSailLayer:dtor()
    DockSailLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    self.isEmbattling = false
    reload_script_file_mvc("app.modules.dock.DockSailLayer")
end

function DockSailLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部活动附着点
    local innerContentLayout = UI.Layout:create()
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:centerRight(0)
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    rightContentLayout:rightUp(50, 75)
    -- rightContentLayout:enableDebugDraw()
    contentLayout:addChild(rightContentLayout, 100)
    self.rightContentLayout = rightContentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    -- 右侧外框
    local rightFrame  = UI.Image:create()
    rightFrame:init("ui_navigation_photoframe.png")
    rightFrame:center(1, 2)
    rightContentLayout:addChild(rightFrame, 300)

    --奖励道具
    local shareRewardPanel = UI.Layout:create()
    shareRewardPanel:init()
    shareRewardPanel:setSize(480, 80)
    shareRewardPanel:leftBottom(5, 0)
    rightContentLayout:addChild(shareRewardPanel, 310)
    -- shareRewardPanel:enableDebugDraw()
    self.shareRewardPanel = shareRewardPanel

    -- 背景图片
    local rewardBg  = UI.Image:create()
    rewardBg:init("ui_navigation_title.png")
    rewardBg:leftUp(-25, -32)
    shareRewardPanel:addChild(rewardBg)

    local rewardText = UI.Text:create()
    rewardText:init(UI.TEXT_221109, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    rewardText:leftUp(-10, -30)
    shareRewardPanel:addChild(rewardText)

    -- 装饰
    local decorate  = UI.Image:create()
    decorate:init("ui_navigation_decorate_left.png")
    decorate:leftBottom(-75, 10)
    contentLayout:addChild(decorate, 1000)

    -- 装饰
    local decorateRight  = UI.Image:create()
    decorateRight:init("ui_navigation_decorate_right.png")
    decorateRight:rightBottom(-85, 15)
    contentLayout:addChild(decorateRight, 1000)

    -- 资源补给
    local supplyBtn = UI.Button:create();
    supplyBtn:init("ui_navigation_btn_supply.png","ui_navigation_btn_supply.png","ui_navigation_btn_supply.png");
    supplyBtn:rightUp(10, 10)
    -- local coundDown = string.format(UI.TEXT_1213023, self.refreshRoomInterval)
    -- supplyBtn:setText(UI.TEXT_221910)
    supplyBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    supplyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:clickSupplyBtn()
    end)
    rightContentLayout:addChild(supplyBtn, 310)
    self.supplyBtn = supplyBtn

    -- 出海
    local launchOutBtn = UI.Button:create();
    launchOutBtn:init("ui_navigation_btn_1.png","ui_navigation_btn_1.png","ui_navigation_btn_1.png");
    launchOutBtn:leftBottom(500, 10)
    -- local coundDown = string.format(UI.TEXT_1213023, self.refreshRoomInterval)
    launchOutBtn:setText(UI.TEXT_221911)
    launchOutBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    launchOutBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:clickSailBtn()
    end)
    rightContentLayout:addChild(launchOutBtn, 310)
    self.launchOutBtn = launchOutBtn

    -- 进度条layout
    local prgContentLayout = UI.Layout:create()
    prgContentLayout:init()
    prgContentLayout:setSize(570, 16)
    prgContentLayout:centerBottom(30)
    -- prgContentLayout:enableDebugDraw()
    rightContentLayout:addChild(prgContentLayout, 100)
    self.prgContentLayout = prgContentLayout

    -- 底框
    local progressBg = UI.Image:create()
    progressBg:init("ui_navigation_bg_up.png")
    progressBg:center(-0.5,0)
    self.prgContentLayout:addChild(progressBg)
    

    -- 航海日志
    local sailLogbtn = UI.Button:create();
    sailLogbtn:init("ui_navigation_btn_log.png","ui_navigation_btn_log.png","ui_navigation_btn_log.png");
    sailLogbtn:rightUp(80, 10)
    sailLogbtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    sailLogbtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.showLogLayer)
    rightContentLayout:addChild(sailLogbtn, 310)
    self.sailLogbtn = sailLogbtn
    -- sailLogbtn:hide()

    -- 航海背包
    local bagBox = UI.Button:create()
    bagBox:init("ui_navigation_backpack.png", "ui_navigation_backpack.png")
    bagBox:rightBottom(-50, 82)
    bagBox:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOpenExplorBag)
    rightContentLayout:addChild(bagBox, 303)
    self.bagBox = bagBox
    -- bagBox:hide()

    -- 终止航程
    local finishSailBtn = UI.Button:create()
    finishSailBtn:init("ui_navigation_btn_finish.png", "ui_navigation_btn_finish.png")
    finishSailBtn:rightBottom(-35, 182)
    finishSailBtn:setText(UI.TEXT_221937)
    finishSailBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    finishSailBtn:setTextWidth(50)
    finishSailBtn:setTextOffset(5, 0)
    finishSailBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.stopSail)
    rightContentLayout:addChild(finishSailBtn, 303)
    self.finishSailBtn = finishSailBtn

    -- 动画内容面板
    local clipperInnerNode = UI.Layout:create()
    clipperInnerNode:init()
    clipperInnerNode:setSize(720, 412)
    clipperInnerNode:center()
    self.clipperInnerNode = clipperInnerNode

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(720, 412)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    rightContentLayout:addChild(clipper)
    -- clipper:setOpacityFilterTouch(false)
    -- clipper:enableDebugDraw()
    -- clipper:setAlphaThreshold(1)
    
    local mask = UI.Image:create()
    mask:init("ui_navigation_bg.png")
    mask:center()
    self.mask = mask
    clipperInnerNode:addChild(mask, 100)
    self.floatCloudCliper = clipper

    -- self:addDockerSpine()
    
    self:makeTabList()
    self:addSeamanEmbattling()
    self:initSailDetail()
    self:tabCellClick(1)
end

function DockSailLayer:addDockerSpine()
    if self.dockerAnime then
        return
    end
    local dockerAnime = UI.Animation:create()
    dockerAnime:init("effect_ui_navigation_dock.json", "effect_ui_navigation_dock.atlas", 1);
    dockerAnime:center(-30, 40)
    self.clipperInnerNode:addChild(dockerAnime, 101)
    dockerAnime:setAnimation("idle", true)
    self.dockerAnime = dockerAnime

    local shipNode = dockerAnime:getNodeForSlot("ship", true) 
    local boatConfig = mvc.dockModel:getCurBoatConfig()
    local dockShipAnime = UI.Animation:create()
    dockShipAnime:init("effect_ui_navigation_dock_ship.json", "effect_ui_navigation_dock_ship.atlas", 1);
    dockShipAnime:center(0, 0)
    shipNode:addChild(dockShipAnime)
    dockShipAnime:setAnimation(boatConfig.skin, true)
    -- dockShipAnime._spine:setSkin(boatConfig.skin)

    local dockWaveAnime = UI.Animation:create()
    dockWaveAnime:init("effect_ui_navigation_dock_layer1.json", "effect_ui_navigation_dock.atlas", 1);
    dockWaveAnime:center(0, 40)
    self.clipperInnerNode:addChild(dockWaveAnime, 102)
    dockWaveAnime:setAnimation("idle", true)
    self.dockWaveAnime = dockWaveAnime
end


function DockSailLayer:addSailingSpine()
    if self.sailAnime or self.waveAnime then
        return
    end
    local config = self.btnData[self.curTabIndex].config
    local spineList = string.split(config.nauticalAnimation, ";")

    local sailAnime = UI.Animation:create()
    sailAnime:init(spineList[2]..".json", spineList[2]..".atlas", 1);
    sailAnime:center(0, -40)
    self.clipperInnerNode:addChild(sailAnime, 105)
    sailAnime:setAnimation("idle", true)
    self.sailAnime = sailAnime

    local sailNode = sailAnime:getNodeForSlot("ship", true) 
    local boatConfig = mvc.dockModel:getCurBoatConfig()

    local shipAnime = UI.Animation:create()
    shipAnime:init("effect_ui_navigation_ship.json", "effect_ui_navigation_ship.atlas", 1);
    shipAnime:center(0, 0)
    sailNode:addChild(shipAnime, 10)
    shipAnime:setAnimation("idle", true)
    shipAnime._spine:setSkin(boatConfig.skin)
    self.shipAnime = shipAnime

    local waveAnime = UI.Animation:create()
    waveAnime:init(spineList[1]..".json", spineList[1]..".atlas", 1);
    waveAnime:center(0, -40)
    self.clipperInnerNode:addChild(waveAnime, 106)
    waveAnime:setAnimation("idle", true)
    self.waveAnime = waveAnime
end

function DockSailLayer:changeSailSatus(idx)
    local index = idx or self.curTabIndex
    local sailStatus = mvc.dockModel:getSailingStatus()
    local isSailing = sailStatus[index] or false
    local config = self.btnData[index].config

    local isLock = mvc.dockModel:getSailIsLock(config)
    if isLock then
        self.launchOutBtn:setText(UI.TEXT_222610)
    else
        self.launchOutBtn:setText(UI.TEXT_221911)
    end

    local couldTake = mvc.dockModel:getSailBagHaveItemCouldTake(PublicDefine.PACKET_TYPE.PACKET_SAIL)
    

    if isSailing then
        self:addSailingSpine()
        self.mask:setSpriteName(config.nauticalPicture)
        if self.dockerAnime then
            self.dockerAnime:removeFromParent()
            self.dockerAnime = nil
            self.dockWaveAnime:removeFromParent()
            self.dockWaveAnime = nil  
        end
        if self.seamanSideBar then
            self.seamanSideBar:hide()
        end
        self.supplyBtn:hide()
        self.shareRewardPanel:hide()
        self.launchOutBtn:hide()
        self:initSailProgress()
        self.bagBox:show()
        if self.sailingLayout then
            self.dockLayout:hide()
            self.sailingLayout:show()
        end
        self.finishSailBtn:show()
        self:updateSailDetail(index)
        self:updateSailProgress()
    else
        self.bagBox:setVisible(couldTake)
        self:addDockerSpine()
        self:updateDockDetail(index)
        if self.sailAnime then
            self.sailAnime:removeFromParent()
            self.sailAnime = nil
        end
        if self.waveAnime then
            self.waveAnime:removeFromParent()
            self.waveAnime = nil
        end
        self.finishSailBtn:hide()
        self.supplyBtn:show()
        self.shareRewardPanel:show()
        self.launchOutBtn:show()
        -- if not couldTake then
        --     self.seamanSideBar:show()
        -- end
        self.seamanSideBar:setVisible(not couldTake)
        if self.dockLayout then
            self.dockLayout:show()
            self.sailingLayout:hide()
        end
        local progressBar = self.prgContentLayout:getChildByName("progressBar")
        if progressBar then
            progressBar:removeFromParent()
            progressBar = nil
        end
    end
end

-- 挂上任务快捷栏
function DockSailLayer:addSeamanEmbattling()
    -- if not mvc.dockModel:needShow() then
    --     return
    -- end

    local seamanSideBar = UI.DockSeamanLayer:create()
    seamanSideBar:init()
    seamanSideBar:center(510, 70)
    self.clipperInnerNode:addChild(seamanSideBar, 300)
    self.seamanSideBar = seamanSideBar
end

function DockSailLayer:makeTabList()
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local sailConfig = mvc.dockModel:getAllSailConfig()
    self.btnData = {}
    for k, v in ipairs(sailConfig) do
        local tab = {}
        tab.config = v
        tab.name = languageManagerInstance:getLocalString(v.name)
        tab.viewName = languageManagerInstance:getLocalString(v.name)
        tab.select = false
        tab.rootLayer = self.innerContentLayout

        table.insert(self.btnData, tab)
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 410)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftUp(-12, 60)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(index)
            end,
            function(e)
                printError("------------------------DockSailLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createTabCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        self:tabCellClick(cell:getIdx() + 1)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function DockSailLayer:createTabCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(206, 46))

    local image = UI.Image.create()
    image:init("ui_navigation_lable_normal.png")
    image:centerBottom(0)
    image:setName("image")
    cell:addChild(image)

    local text = UI.Text:create()
    text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    text:center(0, 4)
    text:setWidth(107)
    text:setTextCenter()
    text:setLineSpacing(-6)
    text:setName("cellText")
    cell:addChild(text)

    local lock = UI.Image.create()
    lock:init("ui_information_lock.png")
    lock:rightUp(47, 10)
    lock:setName("lock")
    cell:addChild(lock)
    -- local conditionValue = tonumber(self.btnData[index].config.conditionValue)
    -- print("conditionValue:", conditionValue, buildData.level)
    local isLock = mvc.dockModel:getSailIsLock(self.btnData[index].config)
    lock:setVisible(isLock)

    if self.curTabIndex ~= index then
        -- text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_navigation_lable_normal.png")
    else
        -- text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_navigation_lable_checked.png")
    end


    self.tableCellArr[index] = cell
    return cell
end

function DockSailLayer:tabCellClick(index)
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

    if self.lastTabIndex > 0 and self.btnData[self.lastTabIndex] then
        self.btnData[self.lastTabIndex].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    end

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex, index)


    self.lastTabIndex = self.curTabIndex
    mvc.dockModel:setTabIndex(self.curTabIndex)
    self:updateSailLayer(index)
end

function DockSailLayer:updateTabList()
    local sailConfig = mvc.dockModel:getAllSailConfig()

    self.btnData = {}
    for k, v in ipairs(sailConfig) do

        local tab = {}
        tab.activityID = v
        tab.select = false
        tab.rootLayer = self.innerContentLayout

        table.insert(self.btnData, tab)
    end

    self._tableView:reloadData(true)
end

function DockSailLayer:initSailDetail()
    local sailStatus = mvc.dockModel:getSailingStatus()
    local isSailing = sailStatus[idx] or false
    -- 明细面板
    local detailLayout = UI.Layout:create()
    detailLayout:init()
    detailLayout:setSize(200, 124)
    detailLayout:leftUp(0, 10)
    detailLayout:setName("detailLayout")
    self.detailLayout = detailLayout
    self.rightContentLayout:addChild(detailLayout)

    -- 背景图片
    -- local sailDetailBg = UI.Image:create()
    -- sailDetailBg:init("ui_navigation_popups.png")
    -- sailDetailBg:center()
    -- detailLayout:addChild(sailDetailBg)
    local width = isSailing and 180 or 124
    local sailDetailBg = UI.Image9:create()
    sailDetailBg:init("ui_navigation_popups.png", nil, cc.size(200, width))
    sailDetailBg:center()
    detailLayout:addChild(sailDetailBg)
    self.sailDetailBg = sailDetailBg

    local sailingLayout = UI.Layout:create()
    sailingLayout:init()
    sailingLayout:setSize(200, 124)
    sailingLayout:leftUp(0, 10)
    sailingLayout:setName("sailingLayout")
    detailLayout:addChild(sailingLayout)
    self.sailingLayout = sailingLayout

    local dockLayout = UI.Layout:create()
    dockLayout:init()
    dockLayout:setSize(200, 124)
    dockLayout:leftUp(0, 10)
    dockLayout:setName("dockLayout")
    detailLayout:addChild(dockLayout)
    self.dockLayout = dockLayout

    local offsetX = 15
    local offsetY = 0
    local dockRatio = 0
    local sailRatio = 0

    local recommendLv = UI.Text:create()
    recommendLv:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    recommendLv:leftUp(offsetX, offsetY+dockRatio*25)
    recommendLv:setName("recommendLv")
    dockLayout:addChild(recommendLv)
    dockRatio = dockRatio+1

    local sailLenth = UI.Text:create()
    sailLenth:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    sailLenth:leftUp(offsetX, offsetY+dockRatio*25)
    sailLenth:setName("sailLenth")
    dockLayout:addChild(sailLenth)
    dockRatio = dockRatio+1

    local speed = UI.Text:create()
    speed:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    speed:leftUp(offsetX, offsetY+dockRatio*25)
    speed:setName("speed")
    dockLayout:addChild(speed)

    local width = speed:getContentSize().width
    local speedGainText = UI.Text:create()
    speedGainText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_128_201_36)
    speedGainText:leftUp(offsetX+width, offsetY+dockRatio*25)
    speedGainText:setName("speedGainText")
    dockLayout:addChild(speedGainText)
    dockRatio = dockRatio+1

    local speed = UI.Text:create()
    speed:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    speed:leftUp(offsetX, offsetY+sailRatio*25)
    speed:setName("speed")
    sailingLayout:addChild(speed)

    local width = speed:getContentSize().width
    local speedGainText = UI.Text:create()
    speedGainText:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_128_201_36)
    speedGainText:leftUp(offsetX+width, offsetY+sailRatio*25)
    speedGainText:setName("speedGainText")
    sailingLayout:addChild(speedGainText)
    sailRatio = sailRatio+1

    local supplyName = UI.Text:create()
    supplyName:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    supplyName:leftUp(offsetX, offsetY+dockRatio*25)
    supplyName:setName("supplyName")
    dockLayout:addChild(supplyName)
    dockRatio = dockRatio+1

    -- 补给剩余
    local surplusSupply = UI.Text:create()
    surplusSupply:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    surplusSupply:leftUp(offsetX, offsetY+dockRatio*25)
    surplusSupply:setName("surplusSupply")
    dockLayout:addChild(surplusSupply)
    dockRatio = dockRatio+1

    -- 补给消耗速度
    local burnRate = UI.Text:create()
    burnRate:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    burnRate:leftUp(offsetX, offsetY+dockRatio*25)
    burnRate:setName("burnRate")
    dockLayout:addChild(burnRate)
    dockRatio = dockRatio+1

    -- 航行剩余时长
    local sailTimeLeft = UI.Text:create()
    sailTimeLeft:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    sailTimeLeft:leftUp(offsetX, offsetY+sailRatio*25)
    sailTimeLeft:setName("sailTimeLeft")
    sailingLayout:addChild(sailTimeLeft)
    sailRatio = sailRatio+1

    -- 航行中补给剩余
    local supplyLeft = UI.Text:create()
    supplyLeft:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    supplyLeft:leftUp(offsetX, offsetY+sailRatio*25)
    supplyLeft:setName("supplyLeft")
    sailingLayout:addChild(supplyLeft)
    sailRatio = sailRatio+1

    -- 补给消耗速度
    local sailBurnRate= UI.Text:create()
    sailBurnRate:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    sailBurnRate:leftUp(offsetX, offsetY+sailRatio*25)
    sailBurnRate:setName("sailBurnRate")
    sailingLayout:addChild(sailBurnRate)
    sailRatio = sailRatio+1
end

function DockSailLayer:updateSailLayer(index)
    local idx = index or self.curTabIndex
    local sailConfig = self.btnData[idx].config--ConfigManager:getAllSailDataByID(index)
    local rewardData = sailConfig.dropDisplay or ""

    if self.levelRewardNode then
        self.levelRewardNode:removeFromParent()
    end
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(nil, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(16, 0), nil, true)
    rewardNode:leftBottom(11, -4)
    local idList = string.split(rewardData, ",")
    for k, v in pairs(idList) do 
        local goodsId = checkint(v)
        if goodsId ~= 0 then
            rewardNode:addGoodsId(goodsId, 0)
        end
    end
    rewardNode:showGoodsView()
    self.shareRewardPanel:addChild(rewardNode)
    self.levelRewardNode = rewardNode
    
    self:changeSailSatus(idx)
    
    -- self:initSailProgress()
end

function DockSailLayer:updateDockDetail(index)
    -- local detailLayout = self.rightContentLayout:getChildByName("detailLayout")
    local idx = index or self.curTabIndex
    if self.dockLayout then
        self.sailDetailBg:setSize(280, 170)
        self.sailDetailBg:center(40, 23)
        local sailConfig = self.btnData[idx].config
        local itemData = ConfigManager:getMaterialConfigByID(tonumber(sailConfig.SuppliesID))
        local boatConfig = mvc.dockModel:getCurBoatConfig()
        local supplyAmount = mvc.dockModel:getSupplyAmountByID(sailConfig) or 0

        local speedGainsMap = mvc.dockModel:getSpeedAttrGains()
        local speedGain = 0
        for k, v in pairs(speedGainsMap) do
            speedGain = speedGain + v
        end
        local speedGainNum = boatConfig.speed*(speedGain/100)
        local recommendLv = self.dockLayout:getChildByName("recommendLv")
        local sailLenth = self.dockLayout:getChildByName("sailLenth")
        local speed = self.dockLayout:getChildByName("speed")
        local speedGainText = self.dockLayout:getChildByName("speedGainText")
        local supplyName = self.dockLayout:getChildByName("supplyName")
        local surplusSupply = self.dockLayout:getChildByName("surplusSupply")
        local burnRate = self.dockLayout:getChildByName("burnRate")
        recommendLv:setText(string.format(UI.TEXT_221903, sailConfig.recommendGrade))
        sailLenth:setText(string.format(UI.TEXT_221904, sailConfig.routeLength))
        speed:setText(string.format(UI.TEXT_221905, boatConfig.speed+speedGainNum))
        speedGainText:setText(string.format(string.format("(+%s)", speedGainNum)))
        supplyName:setText(string.format(UI.TEXT_221906, languageManagerInstance:getLocalString(itemData.name)))
        surplusSupply:setText(string.format(UI.TEXT_221907, supplyAmount))
        burnRate:setText(string.format(UI.TEXT_221924, sailConfig.supplyConsumptionSpeed))

        local width = speed:getContentSize().width
        speedGainText:leftUp(20+width, 2*25)
    end
end

function DockSailLayer:updateSailDetail(index)
    -- local detailLayout = self.rightContentLayout:getChildByName("detailLayout")
    local idx = index or self.curTabIndex
    if self.sailingLayout then
        self.sailDetailBg:setSize(230, 124)
        self.sailDetailBg:center(15, 0)
        local sailData = mvc.dockModel:getSailData()
        local sailConfig = self.btnData[idx].config
        -- local supplyAmount = mvc.dockModel:getSupplyAmountByID(sailConfig.ID) or 0
        local sailTime = mvc.dockModel:getSailRemainTime(self.btnData[idx].config)--(sailConfig.routeLength)
        local supplyLeftNum = sailData.supplyAmount/100

        -- local speedGainsMap = mvc.dockModel:getSpeedAttrGains()
        -- local speedGain = 0
        -- for k, v in pairs(speedGainsMap) do
        --     speedGain = speedGain + v
        -- end

        local speed = self.sailingLayout:getChildByName("speed")
        local speedGainText = self.sailingLayout:getChildByName("speedGainText")
        local supplyLeft = self.sailingLayout:getChildByName("supplyLeft")
        local sailTimeLeft = self.sailingLayout:getChildByName("sailTimeLeft")
        local sailBurnRate = self.sailingLayout:getChildByName("sailBurnRate")
        speed:setText(string.format(UI.TEXT_221905, sailData.speed/100))
        -- speedGainText:setText(string.format(string.format("(+%s)", speedGain)))
        sailTimeLeft:setText(string.format(UI.TEXT_221925, sailTime))
        supplyLeft:setText(string.format(UI.TEXT_221907, supplyLeftNum))
        sailBurnRate:setText(string.format(UI.TEXT_221924, sailData.supplyConsumeSpeed/100))

        -- local width = speed:getContentSize().width
        -- speedGainText:leftUp(20+width, 0)
    end
end

function DockSailLayer:clickEmbattleBtn()
    if not self.isEmbattling then
        self.isEmbattling = true
        self:showPetPacket()
    else
        self.isEmbattling = false
        local packetLayer = self.contentLayout:getChildByName("packetLayer")
        if packetLayer then
            packetLayer:removeFromParent(false)
        end
    end

end

function DockSailLayer:showPetPacket()
    
    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        packetLayer:show()
        local petArr = mvc.dockModel:getPacketPets()
        packetLayer:updateByData(petArr)
    else
        local petArr = mvc.dockModel:getPacketPets()
        local packetLayer = PetPacketLayer:create()
        packetLayer:init(petArr, "DockSailLayer")
        packetLayer:leftUp(0, 20)
        packetLayer:setName("packetLayer")
        self.contentLayout:addChild(packetLayer, 400)
    end
end

function DockSailLayer:clickSailBtn()
    local isLock = mvc.dockModel:getSailIsLock(self.btnData[self.curTabIndex].config)
    local couldTake = mvc.dockModel:getSailBagHaveItemCouldTake(PublicDefine.PACKET_TYPE.PACKET_SAIL)
    local isSailing = mvc.dockModel:isSailing()
    if isLock then
        local str = self.btnData[self.curTabIndex].config.noUnlockedDes
        UI.ScrollBar:createByText(languageManagerInstance:getLocalString(str))
    elseif couldTake then
        UI.ScrollBar:createByText(UI.TEXT_221929)
    elseif isSailing then
        UI.ScrollBar:createByText(UI.TEXT_221930)
    else
        local sailId = self.btnData[self.curTabIndex].config.ID
        local petsList = mvc.dockModel:getEmbattlePets()
        local boatConfig = mvc.dockModel:getCurBoatConfig()
        local petsIdList = {}
        for k, v in pairs(petsList) do
            table.insert(petsIdList, v:getSpriteID())
        end
        if table.nums(petsIdList) < boatConfig.cabinNum then
            UI.ScrollBar:createByText(UI.TEXT_221919)
            return
        end
        if self.isEmbattling then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH)
        end
        local supplyAmount = mvc.dockModel:getSupplyAmountByID(self.btnData[self.curTabIndex].config) or 0
        if supplyAmount < (tonumber(boatConfig.supplyMax)/2) then
            self:showSupplyTips(sailId, petsIdList, supplyAmount)
            return
        end

        Net.NetManorSystem:reqSetSail(sailId, petsIdList, supplyAmount)
    end
end


function DockSailLayer:clickSupplyBtn()
    if self.isEmbattling then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH)
    end
    local sailConfig = self.btnData[self.curTabIndex].config--ConfigManager:getAllSailDataByID(self.curTabIndex)
    local itemData = ConfigManager:getMaterialConfigByID(tonumber(sailConfig.SuppliesID)) or ConfigManager:getVirtualItemConfigByID(tonumber(sailConfig.SuppliesID))
    local boatConfig = mvc.dockModel:getCurBoatConfig()
    local supplyAmount = mvc.dockModel:getSupplyAmount()
    local num = supplyAmount[sailConfig.ID] or 0
    itemData.supplyAmount = num
    itemData.maxLimit = boatConfig.supplyMax
    itemData.maxLimitDes = UI.TEXT_221926
    require "app.ui.tips.ItemBatchCostTips"
    local addSuppplyLayer = UI.ItemBatchCostTips:show(itemData, function (num)
        -- self:_handleTipsQuick(num)
        mvc.dockModel:setSupplyAmount(sailConfig.ID, num)
        self:updateDockDetail(self.curTabIndex)
    end)
    addSuppplyLayer:setDesText(UI.TEXT_221917)

    -- 购买补给按钮
    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.openPanel("FishGear", "FishGearShop", 3)
    end)
    shopButton:rightUp(55, 53)
    addSuppplyLayer:addChild(shopButton, 100)

    -- addSuppplyLayer:setMaxNumText(boatConfig.supplyMax)
    self.contentLayout:addChild(addSuppplyLayer, 300)
end

function DockSailLayer:initSailProgress()
    local sailConfig = ConfigManager:getAllSailDataByID(self.curTabIndex)
    local progressBar = self.prgContentLayout:getChildByName("progressBar")
    if progressBar then
        progressBar:removeFromParent()
        progressBar = nil
    end
    -- 进度条
    self._progressBar = UI.ProgressTimer:create()
    self._progressBar:init("ui_navigation_schedulebg.png", "ui_navigation_schedule.png", "ui_navigation_schedule.png")
    self._progressBar:center(0, 10)
    self._progressBar:setName("progressBar")
    self.prgContentLayout:addChild(self._progressBar)

    local locationList = string.split(sailConfig.chestLocation, ";")
    self._stageIcons = {}
    self._stageBgs = {}
    self._stageStars = {}
    self._stageNewBgs = {}
    local startX = 23
    local oneWidth = 570 / #locationList
    local startY = -20
    
    for k, v in pairs(locationList) do
        local percent = v/sailConfig.routeLength
        -- local boxImg = k == #locationList and "ui_navigation_schedulebox_2.png" or "ui_navigation_schedulebox_1.png"
        local isShowStarCard = k == #locationList
        local boxImg = "ui_navigation_scheduleflag.png"
        local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(boxImg, boxImg, v, 0, 0, k, isShowStarCard)
        -- local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", i), string.format("ui_daily_box_%s_2.png", i), stageConfig.num, stageConfig.x, stageConfig.y, i)
        local startX1 = math.floor(570*percent)
        stageBg:leftBottom(startX1, startY)
        stageBg:setScale(0.8)
        self._progressBar:addChild(stageBg, 100)
        -- table.insert(self._stageIcons, stageIcon)
        -- table.insert(self._stageBgs, stageBg)
        -- table.insert(self._stageStars, stageStar)
        -- table.insert(self._stageNewBgs, stageNewbg)
    end

end

function DockSailLayer:updateSailProgress()
    local sailData = mvc.dockModel:getSailData()
    local sailConfig = self.btnData[self.curTabIndex].config
    local routeLength = sailConfig.routeLength
    local distance = sailData.distance/100
    self._progressBar:setPercent(distance/routeLength)
end

function DockSailLayer:createStageIcon(normalIconName, greyIconName, num, xOffset, yOffset, idx, isShowStarCard)
    -- 背景
    local bg  = UI.Image:create()
    bg:init("ui_navigation_schedulebg_2.png")

    -- 按钮
    local iconButton  = UI.Button:create()
    iconButton:init(normalIconName, normalIconName, greyIconName)
    iconButton:center(xOffset, yOffset)
    iconButton:setInterval(1)
    bg:addChild(iconButton)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showItemByIndex(idx, UI.TEXT_221923, nil, isShowStarCard)
    end)
    -- iconButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
    --     self:showItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
    -- end)

    -- 红点
    -- local starPoint = UI.Animation:create()
    -- starPoint:init("effect_ui_package_return_gift.json", "effect_ui_package_return_gift.atlas", 1)
    -- starPoint:setAnimation("idle", true)
    -- starPoint:rightUp(10, 10)
    -- bg:addChild(starPoint)

    return bg, iconButton, starPoint, newLabelBg
end

-- 根据下标展现物品
function DockSailLayer:showItemByIndex(idx, title, btnStr, isShowStarCard)
    -- 展现获得物品
    local sailConfig = self.btnData[self.curTabIndex].config
    local rewardInfo = sailConfig.chestDropGoodsID
    local rewardInfoList = string.split(rewardInfo, ";")
    local rewardInfoArr = rewardInfoList[idx]
    rewardInfoArr = string.split(rewardInfoArr, ",")
    local numConfig = sailConfig.chestDropGoodsNum
    local numList = string.split(numConfig, ";")
    local numArr = numList[idx]
    numArr = string.split(numArr, ",")
    if (rewardInfoArr and #rewardInfoArr > 0) then
        local dropDisplayDataArr = {}
        require "app.datas.GoodsDataManager"
        for i,v in ipairs(rewardInfoArr) do
            local dummyItem = GoodsDataManager:createLocalGoodsData(tonumber(v))
            if(dummyItem) then
                dummyItem:setNum(numArr[i])
                table.insert(dropDisplayDataArr, dummyItem)
            end
        end

        if isShowStarCard then
            local starCardIDList = string.split(sailConfig.starCardID, ";")
            for _, v in pairs(starCardIDList) do
                local dummyItem = GoodsDataManager:createLocalGoodsData(tonumber(v))
                if(dummyItem) then
                    dummyItem:setNum(1)
                    table.insert(dropDisplayDataArr, dummyItem)
                end
            end
        end
        if (#dropDisplayDataArr > 0) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr)  
        end
    end
end

function DockSailLayer:slotDragEnd(petData, touchPosition)
    if self.seamanSideBar then
        self.seamanSideBar:slotDragEnd(petData, touchPosition)
    end

    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.dockModel:getPacketPets()
        packetLayer:updateByData(petArr)
    end
end

function DockSailLayer:doubleClickedEnd(petData)
    if self.seamanSideBar then
        self.seamanSideBar:doubleClickedEnd(petData)
    end

    local packetLayer = self.contentLayout:getChildByName("packetLayer")
    if packetLayer then
        local petArr = mvc.dockModel:getPacketPets()
        packetLayer:updateByData(petArr)
    end
end

function DockSailLayer:showSupplyTips(sailId, petsIdList, supplyAmount)
    local tips = UI.Tips:createTips(UI.TEXT_221918, UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
    tips:setContentFontName(UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    -- 确定和取消事件监听
    tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
        Net.NetManorSystem:reqSetSail(sailId, petsIdList, supplyAmount)
    end)
end

function DockSailLayer:onOpenExplorBag()
    if (not tolua.isnull(self.bagView)) then
        self.bagView:removeFromParent()
        self.bagView = nil
    end

    local data = mvc.expeditionModel:getGoodsArrForBag(PublicDefine.PACKET_TYPE.PACKET_SAIL)
    local expeditionBagView = require("app.modules.expedition.ExpeditionBagView")
    self.bagView = expeditionBagView:create()
    self.bagView:init(PublicDefine.PACKET_TYPE.PACKET_SAIL, data)
    self.bagView:leftUp(5, 20)
    self.contentLayout:addChild(self.bagView, 1000)

    -- 航海背包领取
    local receiveBtn = UI.Button:create();
    receiveBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    receiveBtn:centerBottom(40)
    receiveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    receiveBtn:setText(UI.TEXT_111035)
    receiveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local GameDataManager = require("app.game.GameDataManager")
        -- 背包至少要空出一个格子
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        local rewardsArr = mvc.petTreasureModel:getGoodsArrLenth(PublicDefine.PACKET_TYPE.PACKET_SAIL)
        if freePacketNum < rewardsArr then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
            return
        end
        Net.NetManorSystem:reqTakeSailGoods()
        -- local sailStatus = mvc.dockModel:getSailingStatus()
        -- local isSailing = sailStatus[self.curTabIndex] or false
        -- if isSailing then
        --     UI.ScrollBar:createByText(UI.TEXT_221930)
        -- else
        --     Net.NetManorSystem:reqTakeSailGoods()
        -- end
    end)
    self.bagView:addChild(receiveBtn)
end

function DockSailLayer:bagRefresh()
    if self.bagView and not tolua.isnull(self.bagView) then
        self.bagView:refreshView()
    end
end

function DockSailLayer:showLogLayer()
    local str = self:getLogContent()
    local data = {
        tips = str
    }
    local logLayer = mvc.dockLogView:create(data)
    logLayer:init()
    logLayer:center(5, 0)
    logLayer:setName("logLayer")
    self.contentLayout:addChild(logLayer, 500)
end

function DockSailLayer:getLogContent()
    local GameInManorManager = require "app.game.GameInManorManager"
    local sailEventType = GameInManorManager:getInstance():getEventTypeMap()
    local sailLogData = mvc.dockModel:getSailLogData()
    local tips = ""
    for k, v in pairs(sailLogData.logs) do
        local date = GameManager:getNowServerDate("%H:%M:%S", v.gameTime)
        local paramNum = #v.params
        local str = ""
        -- dump(v, "getLogContent")
        if not paramNum or paramNum == 0 then
            str = languageManagerInstance:getLocalString(v.langId)
        elseif paramNum == 1 then
            str = string.format(languageManagerInstance:getLocalString(v.langId), v.params[1], "") 
        elseif paramNum == 2 then
            local params1 = v.params[1]
            local params2 = v.params[2]
            if v.eventType == sailEventType.SailEventType_DropItem then
                local itemData = ConfigManager:getMaterialConfigByID(params1) or ConfigManager:getVirtualItemConfigByID(params1)
                local itemName = ""
                if itemData and itemData.name then
                    itemName = languageManagerInstance:getLocalString(itemData.name)
                end
                params1 = v.params[2]
                params2 = itemName
            end 
            str = string.format(languageManagerInstance:getLocalString(v.langId), params1, params2) 
        end
        tips = tips..date.."\n"..str.."\n\n"
    end

    return tips
end

function DockSailLayer:stopSail()
    local sailId = self.btnData[self.curTabIndex].config.ID
    local tips = UI.Tips:createTips(UI.TEXT_221938, UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
    -- tips:setContentFontName(UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    -- 确定和取消事件监听
    tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
        Net.NetManorSystem:reqStopSail(sailId)
    end)

    
end

function DockSailLayer:close()
    mvc.dockModel:clearSupplyAmount()
    DockSailLayer.super.close(self)
end


return DockSailLayer












