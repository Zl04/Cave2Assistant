------------------------------------------------------------------------------
--author: 
--date	: 2019/08/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorResultView = class("ApprenticeshipMentorResultView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipMentorResultView:ctor(apprenticeIdx)
    self._apprenticeIdx = apprenticeIdx
    ApprenticeshipMentorResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorResultView.super.init(self, ... )
    self:center()
end

function ApprenticeshipMentorResultView:dtor()
    ApprenticeshipMentorResultView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorResultView")
end


function ApprenticeshipMentorResultView:onInitView()
------程序生成区块开始 node_1368294785_1565319536-------
    local node_1368294785_1565319536 = UI.Layout:create()
    node_1368294785_1565319536:init()
    node_1368294785_1565319536:setSize(671, 444)
    node_1368294785_1565319536.__uiComposerID = "1368294785_1565319536"
    addChildAuto(self._layoutUU, self, node_1368294785_1565319536, "layout_1368294785_1565319536")
------程序生成区块结束 node_1368294785_1565319536-------
------程序生成区块开始 node_1078079589_1565329742-------
    local width = 470
    local height = 369
    local cellWidth = 456
    local cellHeight = 94
    local node_1078079589_1565329742 = UI.TableView:create({}, width , height)
    node_1078079589_1565329742:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    node_1078079589_1565329742:setDelegate()
    node_1078079589_1565329742:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    node_1078079589_1565329742:setBounceable(true)
    node_1078079589_1565329742:init()
    node_1078079589_1565329742:onUpdateCellSize(function ()
        return cellWidth, cellHeight
    end)
    node_1078079589_1565329742:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
    
            local CellView = require "app.modules.apprenticeship.ApprenticeshipMentorResultCellView"
            local cellView = CellView:create(self._apprenticeIdx)
            cellView.__panel = self.__panel
            cellView:init()
            cellView:setSize(cellWidth, cellHeight)
            cellView:leftBottom(0, 0)
            cellView:setName("cellView")
            cell:addChild(cellView)
        end

        local cellView = cell:getChildByName("cellView")
        if (cellView) then
            cellView:updateIndex(luaIdx)
            cellView:setCallback(function() 
                mvc.apprenticeshipController:mentorGetResultRewardByIndex(self._apprenticeIdx, luaIdx)
            end)
        end
        return cell
    end)
    node_1078079589_1565329742:onUpdateCellNumbers(function ()
        return mvc.apprenticeshipModel:mentorGetResultRewardCount()
    end)
    node_1078079589_1565329742:reloadData()
    node_1078079589_1565329742.__uiComposerID = "1078079589_1565329742"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_1078079589_1565329742, "layout_1078079589_1565329742")
    self._tableResult = node_1078079589_1565329742 -- 暴露名字至self
------程序生成区块结束 node_1078079589_1565329742-------
------程序生成区块开始 node_397793204_1565690847-------
    local node_397793204_1565690847 = UI.Image:create()
    node_397793204_1565690847:init('ui_mentor_mack.png')
    node_397793204_1565690847:setScaleX(0.95)
    node_397793204_1565690847.__uiComposerID = "397793204_1565690847"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_397793204_1565690847, "layout_397793204_1565690847")
------程序生成区块结束 node_397793204_1565690847-------
------程序生成区块开始 node_360886938_1565319643-------
    local node_360886938_1565319643 = UI.Text:create()
    node_360886938_1565319643:init(LanguageManager:getInstance():getLocalString(1112673) --[["你的学员已经出色的完成冒险者发布的任务\n他值得你的认可!"]], UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_360886938_1565319643:setWidth(350)
    node_360886938_1565319643:autoAdapt()
    node_360886938_1565319643.__uiComposerID = "360886938_1565319643"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_360886938_1565319643, "layout_360886938_1565319643")
------程序生成区块结束 node_360886938_1565319643-------
end

function ApprenticeshipMentorResultView:onUpdateView()
    self:reloadTable()
end

function ApprenticeshipMentorResultView:reloadTable()
    self._tableResult:reloadData()
end


function ApprenticeshipMentorResultView:bindModel()

end


function ApprenticeshipMentorResultView:unbindModel()

end





return ApprenticeshipMentorResultView












