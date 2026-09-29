-- StarPrayPlateAttrLayer.lua
-- Author:ydli
-- 2019年04月25日
-- Using: 星痕插槽公用圆盘，能够预览和拖拽（装配、个人面板、人物详情共用）
--传入 人物数据、槽位背包数据 

UI = UI or {}
local StarPrayPlateAttrLayer = class("StarPrayPlateAttrLayer", UI.Component)
UI.StarPrayPlateAttrLayer = StarPrayPlateAttrLayer
local GameDataManager = require("app.game.GameDataManager")

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(566, 578)
-- 背包资源
local COM_RES_LIST = {
    -- "ui_town_starpray.plist",
}


function StarPrayPlateAttrLayer:ctor()
    StarPrayPlateAttrLayer.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    -- self.equipsGrid = {}
    -- self.isSelf = false
    -- self.lastShowStarRoleLevel = 0
    
end

function StarPrayPlateAttrLayer:dtor()
    StarPrayPlateAttrLayer.super.dtor(self)
    reload_script_file("app.modules.starpray.StarPrayPlateAttrLayer")
end

function StarPrayPlateAttrLayer:init(plateConfig, starData)
    self.plateConfig = plateConfig
    self.starData = starData

    StarPrayPlateAttrLayer.super.init(self)

    -- if self.isSelf then
    --     cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.ShowStarPrayLockNew..heroData:getPK(), heroData:getLevel()) 
    -- end
    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function StarPrayPlateAttrLayer:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

	local rootLayer = UI.Layout:create()
	rootLayer:init()
	rootLayer:setSize(layerSize.width, layerSize.height)
	rootLayer:center()
	self:addChild(rootLayer, 10)
	self.rootLayer = rootLayer
    -- rootLayer:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("ui_starmarks_bg_02.png")
    bg:center()
    rootLayer:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_227700, UI.FONT_STANDARD,UI.FONT_SIZE_24PX,UI.FONT_COLOR_172_165_158)
    title:centerUp(50)
    rootLayer:addChild(title,101)
 
    self:initAttrView()
end

function StarPrayPlateAttrLayer:onUpdateView()

end

function StarPrayPlateAttrLayer:initAttrView()
    local attrDesList = self.plateConfig.buffDes
    local arrtUnlockType = string.split(self.plateConfig.buffUnlockType, ";")
    -- local arrtUnlockNum = string.split(self.plateConfig.buffUnlockNum, ";")
    local attrUnlockDes = self.plateConfig.unlockDes
    local activeAttrGrade, totalLv, gradeList = mvc.starPrayModel:getPlateActiveAttrLevel(self.plateConfig)

    local attrListTableView = UI.TableView.new({}, 490, 410)
    attrListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    attrListTableView:center(0, 35)
    attrListTableView:setDelegate()
    -- attrListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    attrListTableView:init()
    attrListTableView:setBounceable(true);
    attrListTableView:onUpdateCellSize(function (table,idx)
        return 490, 115
    end);
    -- attrListTableView:enableDebugDraw()
    attrListTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        local unlockCondition = {}
        local param = {}
        if #arrtUnlockType > 0 then
            param.buffDes = attrDesList[index]
            param.attrUnlockDes = attrUnlockDes[index]
            param.iconName = self.plateConfig.icon2
            param.buffName = self.plateConfig.buffName[index]
            param.totalLv = totalLv
            param.gradeList = gradeList
            param.activeAttrGrade = activeAttrGrade
            param.grade = index
        end

        if not cell then
            xpcall(function()
                cell = self:createAttrCell(param)
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local attrCell = cell:getChildByName("attrCell")

            -- local isChecked = entryStateList[self.starData[index]] or false
            if attrCell and tolua.isnull(attrCell) then
                attrCell:removeFromParent()
                attrCell = nil
            end
            cell:removeFromParent()
            cell = self:createAttrCell(param)
        end

        return cell;
    end);
    
    attrListTableView:onUpdateCellNumbers(function ()
        return table.nums(attrDesList)
    end);


    self.rootLayer:addChild(attrListTableView, 1999)
    attrListTableView:reloadData(true)
end

function StarPrayPlateAttrLayer:createAttrCell(param)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(490, 115))
    local attrCell = mvc.starPrayPlateAttrCellView:create(param, self.starData)
    attrCell:init()
    attrCell:center()
    attrCell:setName("attrCell")
    cell:addChild(attrCell)

    return cell
end