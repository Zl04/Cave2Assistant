------------------------------------------------------------------------------
--author: 
--date	: 2019/07/31
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipReceiveView = class("ApprenticeshipReceiveView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_mentor.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipReceiveView:ctor()
    ApprenticeshipReceiveView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipReceiveView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipReceiveView.super.init(self, ... )
end

function ApprenticeshipReceiveView:dtor()
    ApprenticeshipReceiveView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipReceiveView")
end


function ApprenticeshipReceiveView:onInitView()
------程序生成区块开始 node_111105854_1565163119-------
    local node_111105854_1565163119 = UI.Image:create()
    node_111105854_1565163119:init('ui_bg_box1.png')
    node_111105854_1565163119.__uiComposerID = "111105854_1565163119"
    addChildAuto(self._layoutUU, self, node_111105854_1565163119, "layout_111105854_1565163119")
    mvc.apprenticeshipReceivePanel.ui:setSize(node_111105854_1565163119:getSize())
    mvc.apprenticeshipReceivePanel.ui:center()
    self:center()
------程序生成区块结束 node_111105854_1565163119-------
------程序生成区块开始 node_617069466_1565163455-------
    local node_617069466_1565163455 = UI.Image:create()
    node_617069466_1565163455:init('ui_bg_title.png')
    node_617069466_1565163455.__uiComposerID = "617069466_1565163455"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_617069466_1565163455, "layout_617069466_1565163455")
------程序生成区块结束 node_617069466_1565163455-------
------程序生成区块开始 node_2092446872_1565166475-------
    local node_2092446872_1565166475 = UI.Text:create()
    node_2092446872_1565166475:init(LanguageManager:getInstance():getLocalString(1112635) --[["师徒关系"]], UI.FONT_BOLD, 26, {r = 170, g = 170, b = 170})
    node_2092446872_1565166475.__uiComposerID = "2092446872_1565166475"
    addChildAuto(self._layoutUU, node_617069466_1565163455, node_2092446872_1565166475, "layout_2092446872_1565166475")
------程序生成区块结束 node_2092446872_1565166475-------
------程序生成区块开始 node_408672110_1565166821-------
    local node_408672110_1565166821 = UI.Image:create()
    node_408672110_1565166821:init('ui_mentor_bg_paper1.png')
    node_408672110_1565166821.__uiComposerID = "408672110_1565166821"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_408672110_1565166821, "layout_408672110_1565166821")
------程序生成区块结束 node_408672110_1565166821-------
------程序生成区块开始 node_1536985503_1565167090-------
    local node_1536985503_1565167090 = UI.Text:create()
    node_1536985503_1565167090:init(LanguageManager:getInstance():getLocalString(1112652) --[["申请列表"]], UI.FONT_BOLD, 20, {r = 41, g = 41, b = 45})
    node_1536985503_1565167090.__uiComposerID = "1536985503_1565167090"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_1536985503_1565167090, "layout_1536985503_1565167090")
------程序生成区块结束 node_1536985503_1565167090-------
------程序生成区块开始 node_477266523_1565167277-------
    local node_477266523_1565167277 = UI.Image9:create()
    node_477266523_1565167277:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(646, 2))
    node_477266523_1565167277.__uiComposerID = "477266523_1565167277"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_477266523_1565167277, "layout_477266523_1565167277")
------程序生成区块结束 node_477266523_1565167277-------
------程序生成区块开始 node_990470139_1565197209-------
    local node_990470139_1565197209 = UI.Text:create()
    node_990470139_1565197209:init(LanguageManager:getInstance():getLocalString(1112653) --[["暂无申请信息"]], UI.FONT_STANDARD, 20, {r = 41, g = 41, b = 45})
    node_990470139_1565197209.__uiComposerID = "990470139_1565197209"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_990470139_1565197209, "layout_990470139_1565197209")
    self._labelEmptyList = node_990470139_1565197209 -- 暴露名字至self
------程序生成区块结束 node_990470139_1565197209-------
------程序生成区块开始 node_1772827899_1565204222-------
    local width = 650
    local height = 370
    local cellWidth = 628
    local cellHeight = 92
    local node_1772827899_1565204222 = UI.TableView:create({}, width , height)
    node_1772827899_1565204222:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    node_1772827899_1565204222:setDelegate()
    node_1772827899_1565204222:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    node_1772827899_1565204222:setBounceable(true)
    node_1772827899_1565204222:init()
    node_1772827899_1565204222:onUpdateCellSize(function ()
        return cellWidth, cellHeight
    end)
    node_1772827899_1565204222:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
            local CellView = require "app.modules.apprenticeship.ApprenticeshipReceiveCellView"
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
            cellView:updateData(mvc.apprenticeshipModel:getApprenticeApplyByIndex(luaIdx))
            cellView:setCallback(function()
                mvc.apprenticeshipController:mentorAgree(luaIdx)
            end)
        end

        return cell
    end)
    node_1772827899_1565204222:onUpdateCellNumbers(function ()
        return mvc.apprenticeshipModel:getApprenticeApplyCount()
    end)
    node_1772827899_1565204222:reloadData()
    node_1772827899_1565204222.__uiComposerID = "1772827899_1565204222"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_1772827899_1565204222, "layout_1772827899_1565204222")
    self._tableReceive = node_1772827899_1565204222
------程序生成区块结束 node_1772827899_1565204222-------
------程序生成区块开始 node_762477004_1565257548-------
    local node_762477004_1565257548 = UI.Button:create()
    node_762477004_1565257548:init("ui_btn_reduction_0.png", "ui_btn_reduction_1.png", "ui_btn_reduction_0.png")
    node_762477004_1565257548.__uiComposerID = "762477004_1565257548"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_762477004_1565257548, "layout_762477004_1565257548")
    self._btnClear = node_762477004_1565257548 -- 暴露名字至self
    self._btnClear:setInterval(1)
    self._btnClear:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(LanguageManager:getInstance():getLocalString(1112654) --[["确定要清空列表?"]], function()
            mvc.apprenticeshipController:clearApplyList()
        end)
    end)
------程序生成区块结束 node_762477004_1565257548-------
------程序生成区块开始 node_758187989_1565257900-------
    local node_758187989_1565257900 = UI.Image:create()
    node_758187989_1565257900:init('ui_mentor_mack.png')
    node_758187989_1565257900:setScaleX(1.3)
    node_758187989_1565257900.__uiComposerID = "758187989_1565257900"
    addChildAuto(self._layoutUU, node_408672110_1565166821, node_758187989_1565257900, "layout_758187989_1565257900")
------程序生成区块结束 node_758187989_1565257900-------
------程序生成区块开始 node_1245138014_1565674571-------
    local node_1245138014_1565674571 = UI.Animation:create()
    node_1245138014_1565674571:init("effect_ui_general_mentor_lazhu.json", "effect_ui_general_mentor_lazhu.atlas", 1);
    node_1245138014_1565674571:setAnimation("idle", true)
    node_1245138014_1565674571.__uiComposerID = "1245138014_1565674571"
    addChildAuto(self._layoutUU, node_111105854_1565163119, node_1245138014_1565674571, "layout_1245138014_1565674571")
------程序生成区块结束 node_1245138014_1565674571-------
end

function ApprenticeshipReceiveView:onUpdateView()
    local applyNum = mvc.apprenticeshipModel:getApprenticeApplyCount()
    if (applyNum > 0) then
        self._labelEmptyList:hide()
    else
        self._labelEmptyList:show()
    end

    self._tableReceive:reloadData()
end

function ApprenticeshipReceiveView:bindModel()

end


function ApprenticeshipReceiveView:unbindModel()

end





return ApprenticeshipReceiveView












