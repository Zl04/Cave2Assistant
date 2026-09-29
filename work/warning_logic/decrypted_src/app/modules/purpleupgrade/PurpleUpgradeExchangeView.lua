------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2024/01/04
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeExchangeView = class("PurpleUpgradeExchangeView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

require "app.modules.purpleupgrade.PurpleUpgradeExchangeCellView"

-- 资源
local COM_RES_LIST = {
}

local CELL_SIZE = 4 -- 每排可以容纳的单元数量

local COM_WIDTH = 920
local COM_HEIGHT = 580

local CELL_WIDTH = 182
local CELL_HEIGHT = 270

function PurpleUpgradeExchangeView:ctor()
    PurpleUpgradeExchangeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.cellLayoutList = {}

    self.tableCellArr = {}
    self.partFiletrState = 0 -- 0:全部 枚举值参考 PublicDefine.EQUIPMENT_TYPE
    self.jobFiletrState = 0 -- 0:全部 枚举值参考 PublicDefine.WEAPON_TYPE
    self.starFiletrState = 0 -- 0:全部 星级筛选 一星、二星、三星，默认勾选全部
    
    self:bindModel()
end

function PurpleUpgradeExchangeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeExchangeView.super.init(self, ... )
end

function PurpleUpgradeExchangeView:dtor()
    PurpleUpgradeExchangeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeExchangeView")
end


function PurpleUpgradeExchangeView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local line  = UI.Image:create()
    line:init("ui_rough_line2.png")
    line:centerUp(120)
    contentLayout:addChild(line)


    -- 原石碎片  
    local primogemFragGoodsID = 23530001--tonumber((string.split(configGlyph, ","))[1])
    local virtualData = GoodsDataManager:createVirtualData(primogemFragGoodsID)
    local primogemFragImage = UI.Image:create()
    primogemFragImage:init(virtualData:getSmallIconName())
    primogemFragImage:rightUp(75, 83)
    self.contentLayout:addChild(primogemFragImage, 4)
    self.primogemFragImage = primogemFragImage

    -- 原石碎片数量
    self._primogemFrag = UI.Text:create()
    self._primogemFrag:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._primogemFrag:setTextLeft()
    self._primogemFrag:centerLeft(primogemFragImage:getContentSize().width + 4)
    self.primogemFragImage:addChild(self._primogemFrag, 4)

    self._primogemFrag:setText(self._primogemFrag:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum())))
    self._primogemFrag:updateView()



    local primogemFragGoodsID2 = 23560001
    local virtualData2 = GoodsDataManager:createVirtualData(primogemFragGoodsID2)
    local primogemFragImage2 = UI.Image:create()
    primogemFragImage2:init(virtualData2:getSmallIconName())
    primogemFragImage2:rightUp(155, 83)
    self.contentLayout:addChild(primogemFragImage2, 4)
    self.primogemFragImage2 = primogemFragImage2

    -- 原石碎片数量
    self._primogemFrag2 = UI.Text:create()
    self._primogemFrag2:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._primogemFrag2:setTextLeft()
    self._primogemFrag2:centerLeft(primogemFragImage2:getContentSize().width + 4)
    self.primogemFragImage2:addChild(self._primogemFrag2, 4)

    self._primogemFrag2:setText(self._primogemFrag2:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum2())))
    self._primogemFrag2:updateView()



    -- self._scrollLayout = UI.Layout:create()
    -- self._scrollLayout:init()
    -- self._scrollLayout:enableDebugDraw()
    
    -- 滑动信息展示区域
    -- local scrollView = UI.ScrollView:create()
    -- scrollView:setSize(840, 360)
    -- scrollView:setScrollType(UI.ScrollType.VERTICAL)
    -- scrollView:init()
    -- scrollView:centerUp(130)
    -- scrollView:setScrollBarEnabled(true)
    -- scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    -- scrollView:setCircleVisible(false)
    -- scrollView:setScrollBarWidth(3)
    -- self.contentLayout:addChild(scrollView)
    -- self.scrollView = scrollView

    local config = self:getShopConfig()--ConfigManager:getAllStoneExchangeStoreData()
    self:createShopView(config)

    self:initTopInfo()
end

function PurpleUpgradeExchangeView:getShopConfig()
    local sConf = {}
    local config = ConfigManager:getAllStoneExchangeStoreData()

    for k,v in pairs(config) do
        if v.storeType == 1 then
            table.insert(sConf, v)
        end
    end

    return sConf
end

function PurpleUpgradeExchangeView:initTopInfo()
    local partFilterBtn = UI.Button:create() 
    partFilterBtn:init("ui_rough_label1.png", "ui_rough_label2.png", "ui_rough_label1.png")
    partFilterBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    partFilterBtn:leftUp(70,75)
    partFilterBtn:setText(string.format(UI.TEXT_227522, UI.TEXT_227511))
    partFilterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local data = {}
        -- data.type = 1
        data.filterState = self.partFiletrState
        data.filterType = {
            [0] = UI.TEXT_227511,
            -- [PublicDefine.EQUIPMENT_TYPE.Helmet] = languageManagerInstance:getLocalString(1111378),
            -- [PublicDefine.EQUIPMENT_TYPE.Chest] = languageManagerInstance:getLocalString(1111380),
            -- [PublicDefine.EQUIPMENT_TYPE.Shoulders] = languageManagerInstance:getLocalString(1111379),
            -- [PublicDefine.EQUIPMENT_TYPE.Gloves] = languageManagerInstance:getLocalString(1111381),
            -- [PublicDefine.EQUIPMENT_TYPE.Boots] = languageManagerInstance:getLocalString(1111382),
            -- [PublicDefine.EQUIPMENT_TYPE.Amulet] = languageManagerInstance:getLocalString(1111383),
            -- [PublicDefine.EQUIPMENT_TYPE.Ring] = languageManagerInstance:getLocalString(1111384),
            -- [PublicDefine.EQUIPMENT_TYPE.Weapon] = languageManagerInstance:getLocalString(1111536),
        }

        local levelConfig = ConfigManager:getAllWormholeDeepData()
        for k, v in ipairs(levelConfig) do
            data.filterType[v.copyLv] = languageManagerInstance:getLocalString(v.name)
        end


        data.callBack = function (filterState)
            self.partFiletrState = filterState
            self.partFilterBtn:setText(string.format(UI.TEXT_227522, data.filterType[filterState]))--("筛选部位:"..filterState)
            self:filterShopList("part", filterState)
            self:onTouchSelectOutsizeHandler(partFilterBtn)
        end
        self:showSelectContent(data, partFilterBtn)
    end)
    self.contentLayout:addChild(partFilterBtn)
    self.partFilterBtn = partFilterBtn

    local jobFilterBtn = UI.Button:create() 
    jobFilterBtn:init("ui_rough_label1.png", "ui_rough_label2.png", "ui_rough_label1.png")
    jobFilterBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    jobFilterBtn:leftUp(300,75)
    jobFilterBtn:setText(string.format(UI.TEXT_227513, UI.TEXT_227511))
    jobFilterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local data = {}
        -- data.type = 1
        data.filterState = self.jobFiletrState
        data.filterType = {
            [0] = UI.TEXT_227511,
            [PublicDefine.WEAPON_TYPE.SWORD_SHIELD] = languageManagerInstance:getLocalString(1111376),
            [PublicDefine.WEAPON_TYPE.GREAT_SWORD] = languageManagerInstance:getLocalString(1111375),
            [PublicDefine.WEAPON_TYPE.MAGIC_STAFF] = languageManagerInstance:getLocalString(1111377),
        }
        data.callBack = function (filterState)
            self.jobFiletrState = filterState
            self.jobFilterBtn:setText(string.format(UI.TEXT_227513, data.filterType[filterState]))
            self:filterShopList("job", filterState)
            self:onTouchSelectOutsizeHandler(jobFilterBtn)
        end
        self:showSelectContent(data, jobFilterBtn)
    end)
    self.contentLayout:addChild(jobFilterBtn)
    self.jobFilterBtn = jobFilterBtn

    local starFilterBtn = UI.Button:create() 
    starFilterBtn:init("ui_rough_label1.png", "ui_rough_label2.png", "ui_rough_label1.png")
    starFilterBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    starFilterBtn:leftUp(530,75)
    starFilterBtn:setText(string.format(UI.TEXT_227514, UI.TEXT_227511))
    starFilterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local data = {}
        -- data.type = 1
        data.filterState = self.starFiletrState
        data.filterType = {
            [0] = UI.TEXT_227511,
            [1] = UI.TEXT_227515,
            [2] = UI.TEXT_227516,
            [3] = UI.TEXT_227517,
        }
        data.callBack = function (filterState)
            self.starFiletrState = filterState
            self.starFilterBtn:setText(string.format(UI.TEXT_227514, data.filterType[filterState]))
            self:filterShopList("star", filterState)
            self:onTouchSelectOutsizeHandler(starFilterBtn)
        end

        self:showSelectContent(data, starFilterBtn)
    end)
    self.contentLayout:addChild(starFilterBtn)
    self.starFilterBtn = starFilterBtn

end

function PurpleUpgradeExchangeView:initGoodsShelves()

end

function PurpleUpgradeExchangeView:createOneCell(data, index, scrollView)

    -- -- 物品地板
    -- local index_x = index % CELL_SIZE
    -- local index_Y = math.ceil(index / CELL_SIZE)
    -- if index_x == 0 then
    --     index_x = CELL_SIZE
    -- end

    -- local cellLayout = UI.PurpleUpgradeExchangeCellView:create(data, scrollView)
    -- cellLayout:init()
    -- cellLayout:leftUp(20 + CELL_WIDTH * (index_x - 1) + 20 * (index_x - 1), 1+ CELL_HEIGHT * (index_Y - 1))
    -- self._scrollLayout:addChild(cellLayout)
    
    -- self.cellLayoutList[data.ID] = cellLayout

    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(840, 270))

    for k,v in ipairs(data) do
        if v then
            local cellLayout = UI.PurpleUpgradeExchangeCellView:create(v,scrollView)
            cellLayout:init()
            cellLayout:leftUp(20 + CELL_WIDTH * (k - 1) + 20 * (k - 1), 1)
            cell:addChild(cellLayout)
        end
    end


    return cell
end

function PurpleUpgradeExchangeView:showSelectContent(data, btn)
    if not self.selectRootNode then
        self.m_pSelectLvView = nil
        local bG = UI.Image:create()
        bG:init("ui_rough_paper.png")
        bG:center(0)
        self.contentLayout:addChild(bG, 1000)
        self.selectRootNode = bG
        self.selectRootNode:setTouchEnable(true)
        self.selectRootNode:setInterceptTouches(true)

        self.selectRootNode:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function() 
            self:onTouchSelectOutsizeHandler(btn)
        end)


        self:makeTabList(data, self.selectRootNode)

        btn:setBtnStatus(ButtonState.ACTIVE)
    else
        self:onTouchSelectOutsizeHandler(btn)
    end
end


function PurpleUpgradeExchangeView:onTouchSelectOutsizeHandler(btn)
    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        if self.selectRootNode then
            self.selectRootNode:removeFromParent()
            self.selectRootNode = nil
            btn:setBtnStatus(ButtonState.NORMAL)

        end
    end, 1)
end

function PurpleUpgradeExchangeView:updateInfo()
    self._primogemFrag:setText(self._primogemFrag:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum())))
    self._primogemFrag:updateView()

    self._primogemFrag2:setText(self._primogemFrag2:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum2())))
    self._primogemFrag2:updateView()
end

function PurpleUpgradeExchangeView:createShopView(shopList)
    if not shopList then 
        return 
    end
    -- 建商店界面
    local listLen = #shopList
    local preIndex = 4
    local fIndex = math.ceil(listLen / preIndex)

    if self._tableView2 then
        self._tableView2:removeFromParent()
        self._tableView2 = nil
    end

    self._tableView2 = UI.TableView.new({}, 840, 360)
    self._tableView2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView2:centerUp(130)
    self._tableView2:setDelegate()
    self._tableView2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView2:setBounceable(true)
    self._tableView2:init()
    self._tableView2:onUpdateCellSize(function (table,idx)
        return 840, 270;
    end)

    self._tableView2:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        local sIndex = (index - 1) * preIndex + 1
        local data = {
            [1] = shopList[sIndex],
            [2] = shopList[sIndex + 1],
            [3] = shopList[sIndex + 2],
            [4] = shopList[sIndex + 3]
        }
        
        if not cell then
            xpcall(function()
                cell = self:createOneCell(data,index,self._tableView2)
            end,
            function(e)
                printError("------------------------PurpleUpgradeExchangeView:tableCellAtIndex-----------------error")
            end, 1)
        else
            if cell and not tolua.isnull(cell) then
                cell:removeFromParent(true)
                cell:removeAllChildren()
                cell = nil
            end
            
            cell = self:createOneCell(data,index,self._tableView2)
        end

        return cell
    end)

    self._tableView2:onUpdateCellNumbers(function ()
        return fIndex;
    end)

    self.contentLayout:addChild(self._tableView2)
    self._tableView2:reloadData(true)

end

function PurpleUpgradeExchangeView:filterShopList(filterFunc, filterType)
    local config = self:getShopConfig()--ConfigManager:getAllStoneExchangeStoreData()
    self.shopList = {}
    for k, v in pairs(config) do
        local isShow = true
        local primoGemData = ConfigManager:getMaterialConfigByID(v.goodsID)
        if self.partFiletrState ~= 0 then
            if primoGemData.stageType ~= self.partFiletrState then
                isShow = false
            end
        end

        if self.jobFiletrState ~= 0 then
            if primoGemData.occupationType ~= self.jobFiletrState then
                isShow = false
            end
        end

        if self.starFiletrState ~= 0 then
            if primoGemData.starType ~= self.starFiletrState then
                isShow = false
            end
        end
        if isShow then
            table.insert(self.shopList, v)
        end
    end
    self:createShopView(self.shopList)
end

function PurpleUpgradeExchangeView:updateShopView()

end

function PurpleUpgradeExchangeView:makeTabList(data, node)
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local filterData = data.filterType
    self.btnData = {}
    -- for k, v in ipairs(filterData) do
    for i=0, table.nums(filterData)-1 do
        local tab = {}
        -- tab.config = v
        tab.name = filterData[i]--languageManagerInstance:getLocalString(v)
        tab.select = false

        table.insert(self.btnData, tab)
    end

    self._tableView = UI.TableView.new({}, 300, 280)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:center()
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return 300, 50;
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        -- local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(idx, data)
            end,
            function(e)
                printError("------------------------PurpleUpgradeExchangeView:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createTabCell(idx, data)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        self:tabCellClick(cell:getIdx(), data.callBack)
    end)

    node:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function PurpleUpgradeExchangeView:createTabCell(index, data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(300, 50))

    local image = UI.Image.create()
    image:init("ui_rough_label3.png")
    image:centerBottom(0)
    image:setName("image")
    cell:addChild(image)

    local text = UI.Text:create()
    text:init(self.btnData[index+1].name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    text:center(0, 4)
    text:setWidth(107)
    text:setTextCenter()
    text:setLineSpacing(-6)
    text:setName("cellText")
    cell:addChild(text)

    if data.filterState ~= index then
        -- text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_rough_label3.png")
    else
        -- text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_rough_label4.png")
    end


    -- self.tableCellArr[index] = cell
    return cell
end

function PurpleUpgradeExchangeView:tabCellClick(index, callBack)
    if not index then
        return
    end
    local clickIndex = index

    callBack(clickIndex)
end

-- function PurpleUpgradeExchangeView:updateTabList(data)
--     local filterData = data--mvc.dockModel:getAllfilterData()

--     self.btnData = {}
--     for k, v in ipairs(filterData) do

--         local tab = {}
--         tab.activityID = v
--         tab.select = false

--         table.insert(self.btnData, tab)
--     end

--     self._tableView:reloadData(true)
-- end

function PurpleUpgradeExchangeView:bindModel()

end


function PurpleUpgradeExchangeView:unbindModel()

end





return PurpleUpgradeExchangeView












