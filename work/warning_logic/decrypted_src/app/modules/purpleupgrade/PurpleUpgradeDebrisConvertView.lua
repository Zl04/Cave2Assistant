------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/31
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeDebrisConvertView = class("PurpleUpgradeDebrisConvertView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local CELL_SIZE = 4 -- 每排可以容纳的单元数量

local COM_WIDTH = 920
local COM_HEIGHT = 580

local CELL_WIDTH = 182
local CELL_HEIGHT = 270

function PurpleUpgradeDebrisConvertView:ctor()
    PurpleUpgradeDebrisConvertView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PurpleUpgradeDebrisConvertView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeDebrisConvertView.super.init(self, ... )
end

function PurpleUpgradeDebrisConvertView:dtor()
    PurpleUpgradeDebrisConvertView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeDebrisConvertView")
end

function PurpleUpgradeDebrisConvertView:getShopConfig()
    local sConf = {}
    local config = ConfigManager:getAllStoneExchangeStoreData()

    for k,v in pairs(config) do
        if v.storeType == 2 then
            table.insert(sConf, v)
        end
    end

    return sConf
end

function PurpleUpgradeDebrisConvertView:onInitView()

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
    primogemFragImage:rightUp(126, 83)
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
    primogemFragImage2:rightUp(248, 83)
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


    local config = self:getShopConfig()
    self:createShopView(config)
end

function PurpleUpgradeDebrisConvertView:updateInfo()
    self._primogemFrag:setText(self._primogemFrag:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum())))
    self._primogemFrag:updateView()

    self._primogemFrag2:setText(self._primogemFrag2:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum2())))
    self._primogemFrag2:updateView()
end

function PurpleUpgradeDebrisConvertView:createShopView(shopList)
    if not shopList then 
        return 
    end
    -- 建商店界面
    local listLen = #shopList
    local preIndex = 4
    local fIndex = math.ceil(listLen / preIndex)

    if self._tableView then
        self._tableView:removeFromParent()
        self._tableView = nil
    end

    self._tableView = UI.TableView.new({}, 840, 360)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:centerUp(130)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return 840, 270;
    end)

    self._tableView:onUpdateCells(function (table, idx)
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
                cell = self:createOneCell(data,index,self._tableView)
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
            
            cell = self:createOneCell(data,index,self._tableView)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return fIndex;
    end)

    self.contentLayout:addChild(self._tableView)
    self._tableView:reloadData(true)

end

function PurpleUpgradeDebrisConvertView:createOneCell(data, index, scrollView)

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

function PurpleUpgradeDebrisConvertView:bindModel()

end


function PurpleUpgradeDebrisConvertView:unbindModel()

end





return PurpleUpgradeDebrisConvertView












