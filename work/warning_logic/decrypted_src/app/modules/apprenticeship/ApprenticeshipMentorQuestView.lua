------------------------------------------------------------------------------
--author: 
--date	: 2019/08/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorQuestView = class("ApprenticeshipMentorQuestView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipMentorQuestView:ctor(apprenticeIdx)
    self._apprenticeIdx = apprenticeIdx
    ApprenticeshipMentorQuestView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorQuestView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorQuestView.super.init(self, ... )
    self:center()
end

function ApprenticeshipMentorQuestView:dtor()
    ApprenticeshipMentorQuestView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorQuestView")
end


function ApprenticeshipMentorQuestView:onInitView()
------程序生成区块开始 node_1368294785_1565319536-------
    local node_1368294785_1565319536 = UI.Layout:create()
    node_1368294785_1565319536:init()
    node_1368294785_1565319536:setSize(671, 444)
    node_1368294785_1565319536.__uiComposerID = "1368294785_1565319536"
    addChildAuto(self._layoutUU, self, node_1368294785_1565319536, "layout_1368294785_1565319536")
------程序生成区块结束 node_1368294785_1565319536-------
------程序生成区块开始 node_1402122140_1565321025-------
    local width = 470
    local height = 333
    local cellWidth = 456
    local cellHeight = 94
    local node_1402122140_1565321025 = UI.TableView:create({}, width , height)
    node_1402122140_1565321025:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    node_1402122140_1565321025:setDelegate()
    node_1402122140_1565321025:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    node_1402122140_1565321025:setBounceable(true)
    node_1402122140_1565321025:init()
    node_1402122140_1565321025:onUpdateCellSize(function ()
        return cellWidth, cellHeight
    end)
    node_1402122140_1565321025:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
    
            local CellView = require "app.modules.apprenticeship.ApprenticeshipMentorQuestCellView"
            local cellView = CellView:create()
            cellView.__panel = self.__panel
            cellView:init()
            cellView:setSize(cellWidth, cellHeight)
            cellView:leftBottom(0, 0)
            cellView:setName("cellView")
            cell:addChild(cellView)
        end

        local cellView = cell:getChildByName("cellView")
        if (cellView) then
            cellView:updateData(mvc.apprenticeshipModel:mentorGetApprenticeQuestInfoByIndex(self._apprenticeIdx, luaIdx))
        end

        return cell
    end)
    node_1402122140_1565321025:onUpdateCellNumbers(function ()
        return mvc.apprenticeshipModel:mentorGetApprenticeQuestNumByIndex(self._apprenticeIdx)
    end)
    node_1402122140_1565321025:reloadData()
    node_1402122140_1565321025.__uiComposerID = "1402122140_1565321025"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_1402122140_1565321025, "layout_1402122140_1565321025")
    self._tableQuest = node_1402122140_1565321025 -- 暴露名字至self
------程序生成区块结束 node_1402122140_1565321025-------
------程序生成区块开始 node_774234708_1565321083-------
    local node_774234708_1565321083 = UI.Image9:create()
    node_774234708_1565321083:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(468, 2))
    node_774234708_1565321083.__uiComposerID = "774234708_1565321083"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_774234708_1565321083, "layout_774234708_1565321083")
------程序生成区块结束 node_774234708_1565321083-------
------程序生成区块开始 node_2036742381_1565321173-------
    local node_2036742381_1565321173 = UI.Image:create()
    node_2036742381_1565321173:init('ui_mentor_mack.png')
    node_2036742381_1565321173:setScaleX(0.95)
    node_2036742381_1565321173.__uiComposerID = "2036742381_1565321173"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_2036742381_1565321173, "layout_2036742381_1565321173")
------程序生成区块结束 node_2036742381_1565321173-------
------程序生成区块开始 node_1913727353_1565321236-------
    local node_1913727353_1565321236 = UI.Image:create()
    node_1913727353_1565321236:init('ui_information_reminder.png')
    node_1913727353_1565321236.__uiComposerID = "1913727353_1565321236"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_1913727353_1565321236, "layout_1913727353_1565321236")
------程序生成区块结束 node_1913727353_1565321236-------
------程序生成区块开始 node_189414352_1565321296-------
    local node_189414352_1565321296 = UI.Text:create()
    node_189414352_1565321296:init(LanguageManager:getInstance():getLocalString(1112648) --[["学员完成任务后你将获得奖励"]], UI.FONT_STANDARD, 16, {r = 80, g = 5, b = 5})
    node_189414352_1565321296:autoAdapt()
    node_189414352_1565321296.__uiComposerID = "189414352_1565321296"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_189414352_1565321296, "layout_189414352_1565321296")
------程序生成区块结束 node_189414352_1565321296-------
------程序生成区块开始 node_360886938_1565319643-------
    local node_360886938_1565319643 = UI.Text:create()
    node_360886938_1565319643:init(LanguageManager:getInstance():getLocalString(1112649) --[["冒险者协会今天安排了一些任务\n快安排你的学员完成这些任务"]], UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_360886938_1565319643:setWidth(350)
    node_360886938_1565319643:autoAdapt()
    node_360886938_1565319643.__uiComposerID = "360886938_1565319643"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_360886938_1565319643, "layout_360886938_1565319643")
------程序生成区块结束 node_360886938_1565319643-------
end

function ApprenticeshipMentorQuestView:onUpdateView()
    self:reloadTable()
end

function ApprenticeshipMentorQuestView:reloadTable()
    self._tableQuest:reloadData()
end

function ApprenticeshipMentorQuestView:bindModel()

end


function ApprenticeshipMentorQuestView:unbindModel()

end





return ApprenticeshipMentorQuestView












