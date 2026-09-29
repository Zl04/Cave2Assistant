------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/10/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MainCityFunctionChoiceCellView = class("MainCityFunctionChoiceCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 978
local COM_HEIGHT = 246

function MainCityFunctionChoiceCellView:ctor()
    MainCityFunctionChoiceCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function MainCityFunctionChoiceCellView:init( data, spriteID, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.maincity", "MainCity", false)
    self._data = data
    self._spriteID = spriteID
    MainCityFunctionChoiceCellView.super.init(self, ... )
end

function MainCityFunctionChoiceCellView:dtor()
    MainCityFunctionChoiceCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.maincity.MainCityFunctionChoiceCellView")
end


function MainCityFunctionChoiceCellView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_maincity_entrancebg.png")
    bg:center()
    self:addChild(bg)

    local oneFunctionChoiceData = self._data

    -- show title 
    local titleLayout = UI.Layout:create()
    titleLayout:init()
    titleLayout:leftUp(151,21)
    bg:addChild(titleLayout)
    titleLayout:enableDebugDraw()

    local functionText = UI.Text:create()
    functionText:init(oneFunctionChoiceData.title, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 176,g= 173,b = 246})
    if(functionText:getContentSize().width > 148) then
        functionText:setWidth(148)
    else
        functionText:setFixLineWidth(148)
    end
    functionText:setTextCenter()
    functionText:useDefaultShadowOnlyStype()
    functionText:setLineSpacing(-10)
    functionText:center()
    titleLayout:addChild(functionText)

    -- show function node
    local nodeLayout = UI.Layout:create()
    nodeLayout:init()
    nodeLayout:centerBottom(113)
    bg:addChild(nodeLayout)

    local functionArr = oneFunctionChoiceData.functionArr
    local oneWidth = 162
    local oneOffset = 18
    local funcNum = table.nums(functionArr)

    --tableview
    local tableview = UI.TableView.new({}, 692, 198)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableview:center(0, 10)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 170, 178;
    end);
    
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createOneFunction(functionArr[index], index)
            end,
            function(e)
                printError("------------------------DockSailLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createOneFunction(functionArr[index], index)
        end

        

        return cell;
    end);
    
    tableview:onTableCellTouched(function(table, cell)
        local index = cell:getIdx() + 1
        self:tabCellClick(cell, functionArr[index])
    end)

    tableview:onUpdateCellNumbers(function ()
        return table.nums(functionArr)
    end);

    if (GameManager:getIsGooglePlay()) then
        tableview:onTableCellHighLight(function(table, cell)
            -- print("onTableCellHighLight", cell:getIdx() + 1)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(cell)) then 
                cell:hightLight()

                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        if(cell) then 
                            cell:unHightLight()
                        end
                    end
                end, 1)
            end
        end)

        tableview:onTableCellUnHighLight(function(table, cell)
            local endIndex = cell:getIdx() + 1
            if(not tolua.isnull(cell)) then 
                cell:unHightLight()
            end
        end)
    end

    -- self.tableview = tableview
    nodeLayout:addChild(tableview, 100)
    tableview:reloadData(true)

    if funcNum > 4 then
        tableview:scrollToCell(1.5)
    end

    -- local startX =-(#functionArr * oneWidth + (#functionArr - 1) * oneOffset)/2
    -- for k, v in ipairs(functionArr) do 
    --     local node = self:createOneFunction(v, k)
    --     node:centerLeft(startX)
    --     nodeLayout:addChild(node)
    --     startX = startX + oneWidth + oneOffset
    -- end
end

function MainCityFunctionChoiceCellView:createOneFunction(oneFunctionData, index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(162, 178))

    local isUnLock = Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(oneFunctionData.functionType)
    local modf = index%2
    local bg = nil
    local press = nil
    if(not isUnLock) then 
        bg = "ui_maincity_entrance_gray.png"
    else
        bg = "ui_maincity_entrance_01.png"
        press = "ui_maincity_entrance_01_selected.png"
        if(modf == 1) then 
            bg = "ui_maincity_entrance_02.png"
            press = "ui_maincity_entrance_02_selected.png"
        end
    end

    local node = UI.Image:create()
    node:init(bg)
    -- node:setTouchEnable(true)
    node.normalName = bg
    node.pressName = press
    node:center()
    node:setName("node")
    cell:addChild(node)


    cell.hightLight = function()
        if(not tolua.isnull(node)) then 
            node:setSpriteName(node.pressName)
        end
    end

    cell.unHightLight = function()
        if(not tolua.isnull(node)) then 
            node:setSpriteName(node.normalName)
        end
    end

    local functionIconData = oneFunctionData.functionIconData
    if(functionIconData) then 
        -- 添加ICON
        local iconLayout = UI.Layout:create()
        iconLayout:init()
        iconLayout:centerUp(73)
        node:addChild(iconLayout)

        local icon = UI.Image:create()
        if(not isUnLock) then 
            icon:init("ui_maincity_lock.png")
            icon:center(2, -7)
        else
            icon:init(functionIconData.newIcon)
            icon:center()
        end
        
        iconLayout:addChild(icon)

        -- 添加名字
        local nameLayout = UI.Layout:create()
        nameLayout:init()
        nameLayout:centerBottom(54)
        node:addChild(nameLayout)

        local functionText = UI.Text:create()
        functionText:init(LanguageManager:getInstance():getLocalString(functionIconData.name), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_BLACK)
        functionText:center()
        if(functionText:getContentSize().width > 105) then
            functionText:setWidth(105)
        else
            functionText:setFixLineWidth(105)
        end
        functionText:setTextCenter()
        functionText:setLineSpacing(-10)
        nameLayout:addChild(functionText)
    end

    ToolsUtil:playNewActionInRedPoint(node, 1, 12, 12, 10, oneFunctionData.functionType)

    return cell
end

-- function MainCityFunctionChoiceCellView:hightLight(node)
--     if(not tolua.isnull(node)) then 
--         node:setSpriteName(node.pressName)
--     end
-- end

-- function MainCityFunctionChoiceCellView:unHightLight(node)
--     if(not tolua.isnull(node)) then 
--         node:setSpriteName(node.normalName)
--     end
-- end

function MainCityFunctionChoiceCellView:tabCellClick(cell, oneFunctionData)
    local node = cell:getChildByName("node")
    local isUnLock = Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(oneFunctionData.functionType)
    if(isUnLock) then
        if (oneFunctionData.functionType == PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_PETDEVELOP) then 
            local pet = MasterDataManager:getCaptainPet()
            if not pet then
                UI.ScrollBar:createByText(UI.TEXT_1325004)
                return
            end
        end
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local isActivateFuncSucc = machine:openUIByFunctionType(oneFunctionData.functionType)
        if(isActivateFuncSucc) then 
            -- 这里做一个屏蔽逻辑
            UI.WaitingLayer:showWaiting(true, nil, 0.25, 0.18)
        end
    else 
        -- print("functionType=", oneFunctionData.functionType, Game.FunctionUnlockManager:getInstance():npcTypeToLockType(oneFunctionData.functionType))
        local cfgData = ConfigManager:getFunctionUnlockCfgData(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(oneFunctionData.functionType))
        if cfgData then
            UI.ScrollBar:createByTextID(cfgData.unlockdes)
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, cfgData.unlockdes)
            return 
        end
        
        UI.ScrollBar:createByText(UI.TEXT_1170901)
    end
end

function MainCityFunctionChoiceCellView:bindModel()

end


function MainCityFunctionChoiceCellView:unbindModel()

end





return MainCityFunctionChoiceCellView












