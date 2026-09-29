------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GhostabyssShopView = class("GhostabyssShopView", UI.HWBtnComponent)

require("app.modules.cave.GhostabyssShopCell")

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_town_ghostabyss.plist",
    "ui_package_pets.plist",
}

local COM_WIDTH = 915
local COM_HEIGHT = 590

function GhostabyssShopView:ctor()
    GhostabyssShopView.super.ctor(
    	self,
    	UI.Type.GHOSTABYSS_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.alsoNeedNum = 0
    mvc.caveModel:clearGhostabyssShopHaveDatasChoiceNum()
    self:bindModel()
end

function GhostabyssShopView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    GhostabyssShopView.super.init(self, ... )
end

function GhostabyssShopView:dtor()
    GhostabyssShopView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.GhostabyssShopView")
end


function GhostabyssShopView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_bg_box2.png")
    bg:center()
    self:addChild(bg, 1)

    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg)

    -- 标题
    local title = UI.Text:create()
    title:init(UI.TEXT_1328003, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_170_170_170)
    title:center()
    titleBg:addChild(title)

    -- 内部背景图片
    local innerBG  = UI.Image:create();
    innerBG:init("ui_pets_paper.png");
    innerBG:leftUp(30, 44 + 5);
    self:addChild(innerBG, 3);
    self.innerBG = innerBG

    self:initLeft()
    self:initRight()
    
    self:refreshExp()
end

function GhostabyssShopView:initLeft()
    local dataList = mvc.caveModel:getGhostabyssShopExchangeDatas()
    local data = {}
    data.haveMaterialArr = dataList

    local totalSize = #dataList
    local row,low = math.modf(totalSize/5)
    if(low > 0) then 
        totalSize = (row + 1) * 5
    end
    if(totalSize < 30) then 
        totalSize = 30
    end
    data.packetBoxBeUseNum = totalSize
    data.packetBoxMaxNum = totalSize


    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:centerLeft(17)
    leftLayout:setSize(388, 514)
    self.innerBG:addChild(leftLayout)

    -- 标题文字显示
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328012, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(23-titleText:getContentSize().height/2)
    leftLayout:addChild(titleText)

    local lineImage = UI.Image:create()
    lineImage:init("ui_ghostabyss_line_04.png")
    lineImage:centerUp(44)
    leftLayout:addChild(lineImage)
    

    -- 可兑换物品列表
    local bagList = UI.GoodsListNew:create(5, nil, nil, self._fliterType)
    self._bagGridList = bagList
    bagList:init(data, 260)
    bagList:setPos(-14, -4)
    bagList:hideBGImageCover()
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    -- bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    -- bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    -- bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    -- bagList:setDoubleClickAsDragEnd(true)
    leftLayout:addChild(bagList, 4)
    bagList:showAllGoods()

    -- 需求详细
    local desLayout = UI.Layout:create()
    desLayout:init()
    desLayout:setSize(388, 66)
    desLayout:centerBottom(114)
    leftLayout:addChild(desLayout)

    local progressDes = UI.Text:create()
    progressDes:init(UI.TEXT_1328012, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    progressDes:centerUp(17 - progressDes:getContentSize().height/2)
    desLayout:addChild(progressDes)

    local expProgressTimer =  UI.ProgressTimer:create()
    expProgressTimer:init("ui_ghostabyss_progressbarbg.png", nil, "ui_ghostabyss_progressbar.png")
    expProgressTimer:centerBottom(10)
    desLayout:addChild(expProgressTimer)
    self.expProgressTimer = expProgressTimer

    local progressText = UI.Text:create()
    progressText:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    progressText:center()
    expProgressTimer:addChild(progressText,10)
    self.progressText = progressText

    -- 兑换数据
    local handleLayout = UI.Layout:create()
    handleLayout:init()
    handleLayout:setSize(388, 103)
    handleLayout:centerBottom(9)
    leftLayout:addChild(handleLayout)

    local gridBg = UI.Image:create()
    gridBg:init("ui_ghostabyss_box_02.png")
    gridBg:centerLeft(24)
    handleLayout:addChild(gridBg)

    local goodGrid = UI.GoodsGrid:create()
    goodGrid:init(nil)
    goodGrid:hideFlagIcon()
    goodGrid:showInfoArea(true, false)
    -- goodGrid:setData(self.goodsDataList[idx + 1])
    goodGrid:updateView()
    goodGrid:setTouchClipNode(self.touchClipNode)
    goodGrid:setSwallowTouches(false)
    goodGrid:center()
    gridBg:addChild(goodGrid,10)
    self.goodGrid = goodGrid

    local numText = UI.Text:create()
    numText:init("X 0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    numText:centerLeft(113)
    handleLayout:addChild(numText)
    self.numText = numText

    -- 兑换按钮
    local exchangeButton = UI.Button:create()
    exchangeButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    exchangeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        -- 添加一个确定按钮
        self:clickExchange()
    end)
    exchangeButton:centerRight(20)
    exchangeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    exchangeButton:setText(UI.TEXT_1150011)
    handleLayout:addChild(exchangeButton)
    self.exchangeButton = exchangeButton
end

function GhostabyssShopView:initRight()
    self.haveGoodsDataList = {}
    self.alsoNeedNum = 0


    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:centerRight(0)
    rightLayout:setSize(403, 514)
    self.innerBG:addChild(rightLayout)

    -- 标题文字显示
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328011, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(23-titleText:getContentSize().height/2)
    rightLayout:addChild(titleText)

    local lineImage = UI.Image:create()
    lineImage:init("ui_ghostabyss_line_04.png")
    lineImage:centerUp(44)
    rightLayout:addChild(lineImage)

    -- 中间列表区域
    self._titleTableView = UI.TableView:create({}, 384, 450)
    self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._titleTableView:rightBottom(19, 12)
    self._titleTableView:setDelegate()
    self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._titleTableView:setBounceable(true)
    self._titleTableView:setOpacityModifyRGB(true)
    self._titleTableView:init()
    self._titleTableView:onUpdateCellSize(function (table,idx)
        return 385, 89
    end) 

    self._titleTableView:onUpdateCells(function (table, idx)
        -- print("self._titleTableView:onUpdateCells=", idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
            xpcall(function()
                local cellView = UI.GhostabyssShopCell:create()
                cellView:init(self.haveGoodsDataList[idx + 1], self.alsoNeedNum)
                cellView:setTouchClipNode(self._titleTableView)
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                reusedCell:addChild(cellView)
                cellView:updateData(self.haveGoodsDataList[idx + 1], self.alsoNeedNum)
            end,
            function(e) 
                printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
            end, 1);
        else 
            local cellView = reusedCell:getChildByName("cellView")
            if (cellView) then
                cellView:updateData(self.haveGoodsDataList[idx + 1], self.alsoNeedNum)
            end
        end

        return reusedCell
    end)

    self._titleTableView:onUpdateCellNumbers(function ()
        return #self.haveGoodsDataList
    end)

    self._titleTableView:onTableCellTouched(function(table, cell)

    end)
    -- 载入数据
    self._titleTableView:reloadData()
    self._titleTableView:fixContentOffset()
    rightLayout:addChild(self._titleTableView, 10)

    self:refreshHaveTable()
end

function GhostabyssShopView:refreshHaveTable()
    self.haveGoodsDataList = mvc.caveModel:getGhostabyssShopHaveDatas()
    self.alsoNeedNum = self:getAlsoNeedNum()

    if(self._titleTableView) then
        self._titleTableView:reloadData()
    end
end

function GhostabyssShopView:getAlsoNeedNum()
    if(self._selectedBagGrid) then
        local exchangeNum, lessPoint = self:getExchangeData()
        if(exchangeNum == 0) then 
            local goodsData = self._selectedBagGrid:getData()
            local needPoint = goodsData.needPoint

            return needPoint - lessPoint
        end
    end

    return 0
end

function GhostabyssShopView:clickExchange()
    local choiceGoodsData = self.goodGrid:getData()
    local exchangeNum, lessPoint = self:getExchangeData()

    local goodsArr = {}
    local data = {}
    data.goodsID = choiceGoodsData:getGoodsID()
    data.num = exchangeNum
    data.isGolden = true
    table.insert(goodsArr, data)

    local GameDataManager = require("app.game.GameDataManager")
    local isEnough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if (not isEnough) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170081) --[["背包空间不足"]])
        return false
    end

    local worldChatConfirm = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite("", function()
        local goodsID = choiceGoodsData:getGoodsID()
        local useMaterialsGoodsArr = {}
        if(self.haveGoodsDataList) then
            for _,goodsData in pairs(self.haveGoodsDataList) do 
                if(goodsData.choiceNum > 0) then
                    local oneGoods = {}
                    oneGoods.id = goodsData:getGoodsID()
                    oneGoods.num = goodsData.choiceNum
                    table.insert(useMaterialsGoodsArr, oneGoods)
                end
            end
        end
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:reqExchangeGhostAbyssGoods(goodsID, useMaterialsGoodsArr)
    end, nil, nil, nil, nil)

    
    local title = UI.Text:create()
    title:init(UI.TEXT_1328018, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(40)
    worldChatConfirm.rootLayer:addChild(title)

    --排版
    local cententLayout = UI.Layout:create()
    cententLayout:init()
    cententLayout:enableAutoWidth()
    cententLayout:enableAutoHeight()
    cententLayout:centerUp(70)
    worldChatConfirm.rootLayer:addChild(cententLayout)

    --图标
    local speakerIcon  = UI.Image:create()
    speakerIcon:init(choiceGoodsData:getIconName())
    speakerIcon:floatLeft(0)
    cententLayout:addComponent(speakerIcon)

    --替换数量
    local speakerTextLabel = UI.Text:create()
    speakerTextLabel:init("X "..exchangeNum, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    speakerTextLabel:floatLeft(2)
    cententLayout:addComponent(speakerTextLabel)
end

function GhostabyssShopView:bindModel()

end

function GhostabyssShopView:unbindModel()

end

function GhostabyssShopView:exchangeResponse(data)
    UI.WaitingLayer:hideWaiting()
    if data.result == PublicDefine.ErrNo.ErrNo_Ok then
        mvc.caveModel:clearGhostabyssShopHaveDatasChoiceNum()
        UI.ScrollBar:createByText(UI.TEXT_1328020)
    end
    self:refreshHaveTable()
    self:refreshChoiceGrid()
end

function GhostabyssShopView:bagClickCallback(bagGrid)
    if self._isDraging then 
        return 
    end

    if (DEBUG) then
        print(string.format("GhostabyssShopView:bagClickCallback: grid index:%d.", bagGrid:getIndex()))
    end
    if(self._selectedBagGrid) then 
        self._selectedBagGrid:hideSelect()
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        if goodsData then 
            bagGrid:showSelect()
        end
        self._selectedBagGrid = bagGrid
        mvc.caveModel:clearGhostabyssShopHaveDatasChoiceNum()
        self:refreshChoiceGrid()
    end
end

function GhostabyssShopView:refreshChoiceGrid()
    if(self._selectedBagGrid) then 
        local goodsData = self._selectedBagGrid:getData()
        self.expProgressTimer:setBarChange(0,0,0)
        self.progressText:setText("0/"..goodsData.needPoint)
        self.numText:setText("X 0")
        self.goodGrid:setData(goodsData)
        self.goodGrid:updateView()
        self.exchangeButton:disable()
    end

    self:refreshExp()
end

function GhostabyssShopView:refreshExp()
    if(self._selectedBagGrid) then 
        local goodsData = self._selectedBagGrid:getData()
        local needPoint = goodsData.needPoint

        local exchangeNum, lessPoint = self:getExchangeData()
        local percent = lessPoint/needPoint

        self.expProgressTimer:setBarChange(percent, percent, 0)
        self.expProgressTimer:setBarChangeAction(percent, percent, 600)
        self.progressText:setText(lessPoint.."/"..goodsData.needPoint)
        self.numText:setText("X "..exchangeNum)
        self.goodGrid:setData(goodsData)
        self.goodGrid:updateView()
        if(exchangeNum > 0) then
            self.exchangeButton:enable()
        else
            self.exchangeButton:disable()
        end
    else
        self.exchangeButton:disable()
    end

    self:refreshHaveTable()
end

function GhostabyssShopView:getExchangeData()
    local totalPoint = 0;
    if(self.haveGoodsDataList) then
        for _,goodsData in pairs(self.haveGoodsDataList) do 
            totalPoint = totalPoint + goodsData.choiceNum * goodsData.givePoint
        end
    end

    local exchangeNum = 0
    local lessPoint = 0

    if(self._selectedBagGrid) then 
        local goodsData = self._selectedBagGrid:getData()
        local needPoint = goodsData.needPoint

        exchangeNum =  math.floor(totalPoint / needPoint)
        lessPoint = totalPoint - exchangeNum * needPoint
    end

    -- 这里强制只能换1个
    if(exchangeNum > 1) then 
        exchangeNum = 1
    end

    return exchangeNum, lessPoint
end

return GhostabyssShopView












