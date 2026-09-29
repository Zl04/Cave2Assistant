-- StarPrayAddPlateAttrLayer.lua
-- Author:ydli
-- 2019年04月25日
-- Using: 星痕插槽公用圆盘，能够预览和拖拽（装配、个人面板、人物详情共用）
--传入 人物数据、槽位背包数据 

UI = UI or {}
local StarPrayAddPlateAttrLayer = class("StarPrayAddPlateAttrLayer", UI.Component)
UI.StarPrayAddPlateAttrLayer = StarPrayAddPlateAttrLayer
local GameDataManager = require("app.game.GameDataManager")

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(528, 540)
-- 背包资源
local COM_RES_LIST = {
    -- "ui_town_starpray.plist",
}

function StarPrayAddPlateAttrLayer:ctor()
    StarPrayAddPlateAttrLayer.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)

    self._attrTextTable = {}
end

function StarPrayAddPlateAttrLayer:dtor()
    StarPrayAddPlateAttrLayer.super.dtor(self)
    reload_script_file("app.modules.starpray.StarPrayAddPlateAttrLayer")
end

function StarPrayAddPlateAttrLayer:init(plateConfig, starData)
    self.plateConfig = plateConfig
    self.starData = starData

    StarPrayAddPlateAttrLayer.super.init(self)

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

function StarPrayAddPlateAttrLayer:onInitView()

	local rootLayer = UI.Layout:create()
	rootLayer:init()
	rootLayer:setSize(layerSize.width, layerSize.height)
	rootLayer:center()
	self:addChild(rootLayer, 10)
	self.rootLayer = rootLayer
    -- rootLayer:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("ui_starmarks_bg_03.png")
    bg:center()
    rootLayer:addChild(bg)

    local attrTitle = UI.Text:create()
    attrTitle:init(UI.TEXT_227710, UI.FONT_BOLD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_154_154_154)
    attrTitle:leftUp(25, 20)
    rootLayer:addChild(attrTitle,101)

    local platetitle = UI.Text:create()
    platetitle:init(UI.TEXT_227711, UI.FONT_BOLD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_154_154_154)
    platetitle:leftUp(25, 238)
    rootLayer:addChild(platetitle,101)
 
    self:createAttributesView()
    self:initActiveAttrView()
end

function StarPrayAddPlateAttrLayer:onUpdateView()

end

function StarPrayAddPlateAttrLayer:initAttrView()

end

function StarPrayAddPlateAttrLayer:refreshAttributesView()
    local attrData = mvc.starPrayModel:getStarPlateAttributes()
    for k,v in pairs(self._attrTextTable) do
        if attrData[k] then 

            local nowValue = ToolsUtil:calculationAttrShowValue(attrData[k].attrType,attrData[k].value)

            if v and v.setText then
                v:setText("+" .. nowValue)
            end
        end
    end
end

function StarPrayAddPlateAttrLayer:createAttributesView()
    local CELL_WIDTH = 480
    local CELL_HEIGHT = 28

    self._attributesLayout = UI.Layout:create()
    self._attributesLayout:init()
    self._attributesLayout:setSize(CELL_WIDTH, 204)
    self._attributesLayout:centerUp(40)
    self.rootLayer:addChild(self._attributesLayout)
    -- self._attributesLayout:enableDebugDraw()

    local attriBg = UI.Image:create()
    attriBg:init("ui_starmap_banner_bg_2.png")
    attriBg:leftBottom(0,0)
    self._attributesLayout:addChild(attriBg)

    local bannerUp = UI.Image:create()
    bannerUp:init("ui_starmap_banner_up.png")
    bannerUp:leftBottom(0,10)
    self._attributesLayout:addChild(bannerUp,100)

    local attrData = mvc.starPrayModel:getStarPlateAttributes()
    self._attrTextTable = {}

    local tableView = UI.TableView:create({}, CELL_WIDTH, 170)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,15)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    -- tableView:enableDebugDraw()
    tableView:onUpdateCellSize(function (tableview, idx)
        return CELL_WIDTH,CELL_HEIGHT
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local attrLayout = UI.Layout:create()
                attrLayout:init()
                attrLayout:setSize(CELL_WIDTH,CELL_HEIGHT)
                attrLayout:leftBottom(0,-2)
                -- if index == 1 then
                --     attrLayout:enableDebugDraw()
                -- end
                

                -- local attrBg = UI.Image:create()
                -- attrBg:init("ui_starmap_banner_bg_3.png")
                -- attrBg:leftBottom(0,0)
                -- attrLayout:addChild(attrBg)

                -- if luaIdx%2 ~= 0 then
                --     attrBg:setOpacity(0)
                -- end

                attrData = mvc.starPrayModel:getStarPlateAttributes()

                local attrIndex = luaIdx*2 - 1
                local aData = attrData[attrIndex]
                local aData2 = attrData[attrIndex + 1]

                if aData then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData.icon)
                    attrIcon:centerLeft(8)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData.attrName, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
                    desText:centerLeft(36)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData.value, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=26,g=77,b=67})
                    attrText:centerRight(269)
                    attrLayout:addChild(attrText)

                    self._attrTextTable[attrIndex] = attrText
                    -- attrLayout:enableDebugDraw()
                end

                if aData2 then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData2.icon)
                    attrIcon:centerLeft(240)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData2.attrName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
                    desText:centerLeft(267)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData2.value, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=26,g=77,b=67})
                    attrText:centerRight(28)
                    attrLayout:addChild(attrText)

                    self._attrTextTable[attrIndex + 1] = attrText
                end


                cell:addChild(attrLayout)
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return #attrData / 2
    end)
    attriBg:addChild(tableView)
    tableView:reloadData()


end

function StarPrayAddPlateAttrLayer:initActiveAttrView()
    local showActiveAttr = {}
    local allStarPlateConfig = ConfigManager:getAllStarPlateData()
    for k, v in pairs(allStarPlateConfig) do 
        local attrDesList = v.buffDes
        local arrtUnlockType = string.split(v.buffUnlockType, ";")
        local attrUnlockDes = v.unlockDes

        local activeAttrGrade, totalLv, gradeList = mvc.starPrayModel:getPlateActiveAttrLevel(v)
        if activeAttrGrade > 0 then
            local param = {}
            if #attrDesList > 0 then
                param.buffDes = attrDesList[activeAttrGrade]
                param.attrUnlockDes = attrUnlockDes[activeAttrGrade]
                param.iconName = v.icon2
                param.buffName = v.buffName[activeAttrGrade]
                param.totalLv = totalLv
                param.gradeList = gradeList
                param.activeAttrGrade = activeAttrGrade
                param.grade = activeAttrGrade
            end
            table.insert(showActiveAttr, param)
        end
    end

    local attrListTableView = UI.TableView.new({}, 490, 210)
    attrListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    attrListTableView:centerBottom(35)
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

        if not cell then
            xpcall(function()
                cell = self:createAttrCell(showActiveAttr[index])
            end,
            function(e)
                printError("------------------------StarPrayAddPlateAttrLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local attrCell = cell:getChildByName("attrCell")

            -- local isChecked = entryStateList[self.starData[index]] or false
            if attrCell and tolua.isnull(attrCell) then
                attrCell:removeFromParent()
                attrCell = nil
            end
            cell:removeFromParent()
            cell = self:createAttrCell(showActiveAttr[index])
        end

        return cell;
    end);
    
    attrListTableView:onUpdateCellNumbers(function ()
        return table.nums(showActiveAttr)
    end);


    self.rootLayer:addChild(attrListTableView, 1999)
    attrListTableView:reloadData(true)
end

function StarPrayAddPlateAttrLayer:createAttrCell(param)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(490, 115))
    local attrCell = mvc.starPrayPlateAttrCellView:create(param, true)
    attrCell:init()
    attrCell:center()
    attrCell:setName("attrCell")
    cell:addChild(attrCell)

    return cell
end