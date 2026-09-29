------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/10/28
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveMainView = class("ActivityModeCaveMainView", UI.HWBtnComponent)

local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
    "ui_town_trial.plist"
}

function ActivityModeCaveMainView:ctor()
    ActivityModeCaveMainView.super.ctor(
    	self,
    	UI.Type.MAIN_UI_DISTORTEDSPACE_TYPESELECT,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )

    -- self:init();
    self:bindModel()
end

function ActivityModeCaveMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveMainView.super.init(self, ... )

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:close()
    end)
end

function ActivityModeCaveMainView:dtor()
    ActivityModeCaveMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveMainView")
end


function ActivityModeCaveMainView:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,150))
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1) 

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(winSize.width, winSize.height)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:addSelectCell()
end

function ActivityModeCaveMainView:addSelectCell()
    local modeData = ConfigManager:getAllTrialModelData()
    local len = #modeData
    --tableview
    local tableview = UI.TableView.new({}, 285*len, 465)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableview:center(0, 10)
    tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 285, 415;
    end);
    -- tableview:enableDebugDraw()
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createSelectCell(modeData[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local caveCell = cell:getChildByName("caveCell")
            if caveCell and tolua.isnull(caveCell) then
                caveCell:removeFromParent()
                caveCell = nil
            end
            cell:removeFromParent()
            cell = self:createSelectCell(modeData[index])
        end

        return cell;
    end);
    
    -- tableview:onTableCellTouched(function(table, cell)
    --     local index = cell:getIdx() + 1
    --     self:tabCellClick(cell, functionArr[index])
    -- end)

    tableview:onUpdateCellNumbers(function ()
        return table.nums(modeData)
    end);


    -- self.tableview = tableview
    self.contentLayout:addChild(tableview, 100)
    tableview:reloadData(true)
end

function ActivityModeCaveMainView:createSelectCell(config)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(285, 415))
    local allData = mvc.activityModeCaveModel:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand)
    local caveData = allData[config.ID]
    
    local caveCell = mvc.activityModeCaveSelectCellView:create(caveData, config)
    caveCell:init()
    caveCell:center()
    caveCell:setName("caveCell")
    cell:addChild(caveCell)

    return cell
end

function ActivityModeCaveMainView:close()
    mvc.closePanel("ActivityModeCave", "ActivityModeCaveMain")
end

function ActivityModeCaveMainView:bindModel()

end


function ActivityModeCaveMainView:unbindModel()

end





return ActivityModeCaveMainView












