------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveChallengeView = class("ActivityModeCaveChallengeView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

local WEAPON_TYPE_NAME ={
    [PublicDefine.WEAPON_TYPE.SWORD_SHIELD] = UI.TEXT_1324001,   --剑盾
    [PublicDefine.WEAPON_TYPE.GREAT_SWORD] = UI.TEXT_1324000,    --大剑
    [PublicDefine.WEAPON_TYPE.MAGIC_STAFF] = UI.TEXT_1324002     --法杖
}

function ActivityModeCaveChallengeView:ctor(data, config)
    ActivityModeCaveChallengeView.super.ctor(
    	self,
    	UI.Type.MODE_CAVE_TRIAL_LAND,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.config = config
    self.entryCellList = {}
    self:bindModel()
end

function ActivityModeCaveChallengeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveChallengeView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

function ActivityModeCaveChallengeView:dtor()
    ActivityModeCaveChallengeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveChallengeView")
end


function ActivityModeCaveChallengeView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_trial_bg.png")
    bg:center()
    contentLayout:addChild(bg)


    -- 左侧内容面板
    local leftContentLayout = UI.Layout:create();
    leftContentLayout:init()
    leftContentLayout:setSize(247, 520)
    leftContentLayout:center(-350, 0)
    contentLayout:addChild(leftContentLayout)
    self.leftContentLayout = leftContentLayout

    -- 左侧内容面板
    local rightContentLayout = UI.Layout:create();
    rightContentLayout:init()
    rightContentLayout:setSize(694, 520)
    rightContentLayout:center(140, 0)
    contentLayout:addChild(rightContentLayout)
    self.rightContentLayout = rightContentLayout

    self:initLeftPanel()
    self:initrightPanel()
end

function ActivityModeCaveChallengeView:initLeftPanel()
    local leftBg = UI.Image:create()
    leftBg:init("ui_trial_flag.png")
    leftBg:center()
    self.leftContentLayout:addChild(leftBg)

    local head = UI.Image:create()
    head:init("ui_trial_flag_avatar.png")
    head:center(-5, -147)
    self.leftContentLayout:addChild(head)

    local naemBg = UI.Image:create()
    naemBg:init("ui_trial_namebg.png")
    naemBg:center(-10, -20)
    self.leftContentLayout:addChild(naemBg)

    local str = languageManagerInstance:getLocalString(self.config.bossName)
    local name = UI.Text:create()
    name:init(str, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    name:center(5, 0)
    naemBg:addChild(name)

    -- 挑战次数
    local maxCount = self.config.dailyChallenges
    local curFightCount = self.data.trialLand.challengeCount or 0
    local fightCount = UI.Text:create()
    local showTxt = (maxCount - curFightCount) .. "/" .. maxCount
    fightCount:init(UI.TEXT_1212647 .. showTxt, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    fightCount:centerBottom(109);
    self.leftContentLayout:addChild(fightCount)

    -- 按钮功能
    local challengeBtn = UI.Button:create()
    challengeBtn:init("ui_trial_btn_1.png","ui_trial_btn_1.png","ui_trial_btn_1.png");
    challengeBtn:centerBottom(59);
    challengeBtn:setText(UI.TEXT_223400)
    challengeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    challengeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:onClickChallengeBtn()
    end)
    self.leftContentLayout:addChild(challengeBtn)
    self.challengeBtn = challengeBtn

    self:addDesScrollView()
end

function ActivityModeCaveChallengeView:addDesScrollView()
    local height = 150
    local desStr = languageManagerInstance:getLocalString(self.config.modelDes)
    local desText = UI.Text:create()
    desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desText:setWidth(210)
    desText:autoAdapt()

    if(desText:getContentSize().height <= height) then 
        desText:centerUp(279)
        self.leftContentLayout:addChild(desText)
    else
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(210, desText:getContentSize().height)
        desText:centerUp(3)
        layout:addChild(desText)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(210, 124)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(layout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:centerUp(279)

        self.leftContentLayout:addChild(detailedScrollView)
    end
end

function ActivityModeCaveChallengeView:initrightPanel()
    local entryBg = UI.Image:create()
    entryBg:init("ui_trial_paper_2.png")
    entryBg:centerUp(15)
    self.rightContentLayout:addChild(entryBg)

    local entryListBg1 = UI.Image:create()
    entryListBg1:init("ui_trial_list_1_2.png")
    entryListBg1:centerUp(10, -228)
    entryBg:addChild(entryListBg1)
    self.entryListBg1 = entryListBg1

    local star = UI.Image:create()
    star:init("ui_trial_star.png")
    star:centerUp(12)
    entryListBg1:addChild(star)

    local entryListBg2 = UI.Image:create()
    entryListBg2:init("ui_trial_list_2_2.png")
    entryListBg2:centerUp(10, -2)
    entryBg:addChild(entryListBg2)
    self.entryListBg2 = entryListBg2

    local lenth = 2*11
    for k=1, 2 do
        local star = UI.Image:create()
        star:init("ui_trial_star.png")
        star:centerUp(12, -lenth/2+(k-1)*22)
        entryListBg2:addChild(star)
    end

    local entryListBg3 = UI.Image:create()
    entryListBg3:init("ui_trial_list_3_2.png")
    entryListBg3:centerUp(10, 224)
    entryBg:addChild(entryListBg3)
    self.entryListBg3 = entryListBg3

    local lenth2 = 3*11
    for k=1, 3 do
        local star = UI.Image:create()
        star:init("ui_trial_star.png")
        star:centerUp(12, -lenth2/2+(k-1)*22)
        entryListBg3:addChild(star)
    end

    local entryScoreBg = UI.Image:create()
    entryScoreBg:init("ui_trial_title.png")
    entryScoreBg:centerBottom(148)
    self.rightContentLayout:addChild(entryScoreBg, 999)

    -- 得分
    local score = UI.Text:create()
    score:init(string.format(UI.TEXT_223402, 0), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    score:center()
    entryScoreBg:addChild(score)
    self.score = score

    local entryDesBg = UI.Image:create()
    entryDesBg:init("ui_trial_paper_3.png")
    entryDesBg:centerBottom(-10)
    self.rightContentLayout:addChild(entryDesBg)

    -- 按钮功能
    local rankBtn = UI.Button:create()
    rankBtn:init("ui_trial_ranking.png","ui_trial_ranking.png","ui_trial_ranking.png");
    rankBtn:rightBottom(15, 145);
    -- rankBtn:closeClickScale()
    rankBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rankBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:openRankView()
    end)
    self.rightContentLayout:addChild(rankBtn)
    self.rankBtn = rankBtn

    local redPoint = AvalonUtil.createRedPoint(rankBtn, 2, 2, 100)
    redPoint:setName("redPoint")
    redPoint:hide()

    local helpDes = UI.Text:create()
    helpDes:init(UI.TEXT_223411, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    helpDes:centerBottom(58)
    self.rightContentLayout:addChild(helpDes)
    self.helpDes = helpDes

    -- 清空词条
    local clearEntryBtn = UI.Button:create()
    clearEntryBtn:init("ui_trial_btn_empty.png","ui_trial_btn_empty.png","ui_trial_btn_empty.png");
    clearEntryBtn:rightBottom(-2, -58);
    clearEntryBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    clearEntryBtn:setText(UI.TEXT_223407)
    clearEntryBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.activityModeCaveModel:clearSelctedEntryList()
        self:updateEntryState()
        mvc.send("ActivityModeCave_Refresh_EntryDes_View")
    end)
    self.rightContentLayout:addChild(clearEntryBtn)
    self.clearEntryBtn = clearEntryBtn

    -- self:addEnteryCell()
    self:addEnteryCellListView()
    self:addEnteryDesTableView()
    self:updateRankRedPoint()
end

function ActivityModeCaveChallengeView:addEnteryCellListView(config)
    self:addEnteryCellList1View(1)
    self:addEnteryCellList2View(2)
    self:addEnteryCellList3View(3)
end

function ActivityModeCaveChallengeView:addEnteryCellList1View()
    local entryConfigList = self:getEntryConfigListByDifficulty(1)
    -- dump(entryConfigList, "entryConfigList12")
    --entryList1tableview
    local entryList1tableview = UI.TableView.new({}, 220, 235)
    entryList1tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    entryList1tableview:center(2, 27)
    entryList1tableview:setDelegate()
    -- entryList1tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    entryList1tableview:init()
    entryList1tableview:setBounceable(true);
    entryList1tableview:onUpdateCellSize(function (table,idx)
        return 216, 52
    end);
    -- entryList1tableview:enableDebugDraw()
    entryList1tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createEntryCell(entryConfigList[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local entryCell = cell:getChildByName("entryCell")
            local entryStateList = mvc.activityModeCaveModel:getSelctedEntryStatList()
            local isChecked = entryStateList[entryConfigList[index].ID] or false
            if entryCell and tolua.isnull(entryCell) then
                entryCell:removeFromParent()
                entryCell = nil
            end
            cell:removeFromParent()
            cell = self:createEntryCell(entryConfigList[index], isChecked)
        end
        
        self.entryCellList[entryConfigList[index].ID] = cell
        return cell;
    end);
    
    entryList1tableview:onTableCellTouched(function(table, cell)
        -- local index = cell:getIdx() + 1
        self:tabCellClick(cell)
    end)

    entryList1tableview:onUpdateCellNumbers(function ()
        return table.nums(entryConfigList)
    end);


    self.entryListBg1:addChild(entryList1tableview, 1999)
    entryList1tableview:reloadData(true)
end

function ActivityModeCaveChallengeView:addEnteryCellList2View()
    local entryConfigList = self:getEntryConfigListByDifficulty(2)

    local entryList2tableview = UI.TableView.new({}, 220, 235)
    entryList2tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    entryList2tableview:center(2, 27)
    entryList2tableview:setDelegate()
    -- entryList2tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    entryList2tableview:init()
    entryList2tableview:setBounceable(true);
    entryList2tableview:onUpdateCellSize(function (table,idx)
        return 216, 52
    end);
    -- entryList2tableview:enableDebugDraw()
    entryList2tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createEntryCell(entryConfigList[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local entryCell = cell:getChildByName("entryCell")
            local entryStateList = mvc.activityModeCaveModel:getSelctedEntryStatList()
            local isChecked = entryStateList[entryConfigList[index].ID] or false
            if entryCell and tolua.isnull(entryCell) then
                entryCell:removeFromParent()
                entryCell = nil
            end
            cell:removeFromParent()
            cell = self:createEntryCell(entryConfigList[index], isChecked)
        end

        self.entryCellList[entryConfigList[index].ID] = cell
        return cell;
    end);
    
    entryList2tableview:onTableCellTouched(function(table, cell)
        -- local index = cell:getIdx() + 1
        self:tabCellClick(cell)
    end)

    entryList2tableview:onUpdateCellNumbers(function ()
        return table.nums(entryConfigList)
    end);


    self.entryListBg2:addChild(entryList2tableview, 1999)
    entryList2tableview:reloadData(true)
end

function ActivityModeCaveChallengeView:addEnteryCellList3View()
    local entryConfigList = self:getEntryConfigListByDifficulty(3)

    local entryList3tableview = UI.TableView.new({}, 220, 235)
    entryList3tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    entryList3tableview:center(2, 27)
    entryList3tableview:setDelegate()
    entryList3tableview:init()
    entryList3tableview:setBounceable(true);
    entryList3tableview:onUpdateCellSize(function (table,idx)
        return 216, 52
    end);
    -- entryList3tableview:enableDebugDraw()
    entryList3tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createEntryCell(entryConfigList[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local entryCell = cell:getChildByName("entryCell")
            local entryStateList = mvc.activityModeCaveModel:getSelctedEntryStatList()
            local isChecked = entryStateList[entryConfigList[index].ID] or false
            if entryCell and tolua.isnull(entryCell) then
                entryCell:removeFromParent()
                entryCell = nil
            end
            cell:removeFromParent()
            cell = self:createEntryCell(entryConfigList[index], isChecked)
        end

        self.entryCellList[entryConfigList[index].ID] = cell
        return cell;
    end);
    
    entryList3tableview:onTableCellTouched(function(table, cell)
        -- local index = cell:getIdx() + 1
        self:tabCellClick(cell)
    end)

    entryList3tableview:onUpdateCellNumbers(function ()
        return table.nums(entryConfigList)
    end);


    self.entryListBg3:addChild(entryList3tableview, 1999)
    entryList3tableview:reloadData(true)
end


function ActivityModeCaveChallengeView:createEntryCell(config, isChecked)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(216, 50))
    local entryCell = mvc.activityModeCaveEntryCellView:create(config, isChecked)
    entryCell:init()
    entryCell:center()
    entryCell:setName("entryCell")
    cell:addChild(entryCell)

    return cell
end

function ActivityModeCaveChallengeView:tabCellClick(cell)
    local entryCell = cell:getChildByName("entryCell")
    if entryCell and not tolua.isnull(entryCell) then
        entryCell:onClickEntry()
    end
    
end

function ActivityModeCaveChallengeView:getEntryConfigListByDifficulty(difficulty)
    local entryConfigList = {}
    for k, v in pairs(self.data.trialLand.effects) do
        local config = ConfigManager:getAllTrialEntryDataByID(v)
        if config.difficulty == difficulty then
            table.insert(entryConfigList, config)
        end
    end
    return entryConfigList
end

function ActivityModeCaveChallengeView:addEnteryCell()
    -- local modeCaveData = mvc.activityModeCaveModel:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand)
    local entryList = self.data.trialLand.effects
    local entryListX1 = 0
    local entryListX2 = 0
    local entryListX3 = 0
    local entryListY = 7
    local offsetX = 229
    for k, v in pairs(entryList) do
        local config = ConfigManager:getAllTrialEntryDataByID(v)
        local entryCell = mvc.activityModeCaveEntryCellView:create(config)
        entryCell:init()
        if config.difficulty == 1 then
            entryCell:centerLeft(entryListX1, entryListY)
            self.entryListBg1:addChild(entryCell)
            entryListX1 = entryListX1+offsetX
        elseif config.difficulty == 2 then
            entryCell:centerLeft(entryListX2, entryListY)
            self.entryListBg2:addChild(entryCell)
            entryListX2 = entryListX2+offsetX
        elseif config.difficulty == 3 then
            entryCell:centerLeft(entryListX3, entryListY)
            self.entryListBg3:addChild(entryCell)
            entryListX3 = entryListX3+offsetX
        end
        table.insert(self.entryCellList, entryCell)
    end
end

function ActivityModeCaveChallengeView:updateEntryState()
    if table.nums(self.entryCellList) > 0 then
        for k, v in pairs(self.entryCellList) do
            if v and not tolua.isnull(v) then
                local entryCell = v:getChildByName("entryCell")
                if entryCell then
                    entryCell:clearEntryState()
                end
            end
        end
    end
end

function ActivityModeCaveChallengeView:addEnteryDesTableView()
    local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
    --tableview
    local tableview = UI.TableView.new({}, 674, 130)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:centerBottom(10)
    tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 674, 36;
    end);
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        entryList = mvc.activityModeCaveModel:getSelctedEntryList()
        if not cell then
            xpcall(function()
                cell = self:createEntryDesCell(entryList[index], index)
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local desCell = cell:getChildByName("desCell")
            if desCell and tolua.isnull(desCell) then
                desCell:removeFromParent()
                desCell = nil
            end
            cell:removeFromParent()
            cell = self:createEntryDesCell(entryList[index], index)
        end

        return cell;
    end);
    
    -- tableview:onTableCellTouched(function(table, cell)
    --     local index = cell:getIdx() + 1
    --     self:tabCellClick(cell)
    -- end)

    tableview:onUpdateCellNumbers(function ()
        return table.nums(mvc.activityModeCaveModel:getSelctedEntryList())
    end);


    -- self.tableview = tableview
    self.rightContentLayout:addChild(tableview, 100)
    tableview:reloadData(true)
    self.tableview = tableview
    
end

function ActivityModeCaveChallengeView:createEntryDesCell(entryID, index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(674, 36))
    local config = ConfigManager:getAllTrialEntryDataByID(entryID)
    
    local desCell = mvc.activityModeCaveEntryDesCellView:create(config, index)
    desCell:init()
    desCell:center()
    desCell:setName("desCell")
    cell:addChild(desCell)

    return cell
end

function ActivityModeCaveChallengeView:updateEntryDesView()
    self.tableview:reloadData(true)
    self:updateScore()

    local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
    local isShow = #entryList == 0 and true or false
    self.helpDes:setVisible(isShow)
end

function ActivityModeCaveChallengeView:onClickChallengeBtn()
    local maxCount = self.config.dailyChallenges
    local curFightCount = self.data.trialLand.challengeCount or 0
    if curFightCount >= maxCount then
        UI.ScrollBar:createByText(UI.TEXT_1328010)
        return
    end
    
    local wearingWeaponType = GameDataManager:getInstance():getWearWeaponType()
    if self.data.trialLand.weaponType and self.data.trialLand.weaponType ~= PublicDefine.WEAPON_TYPE.NONE and wearingWeaponType == self.data.trialLand.weaponType then
        -- self:showEnterCave()
        mvc.activityModeCaveModel:clearTrialLandSettleData()
        local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
        Net.NetPlaySystem:requestEnterTrialLand(PublicDefine.ActivityModeCaveType.TrialLand, self.data.modeId, entryList)
        return
    elseif self.data.trialLand.weaponType and self.data.trialLand.weaponType ~= PublicDefine.WEAPON_TYPE.NONE and wearingWeaponType ~= self.data.trialLand.weaponType then
        local str = string.format(UI.TEXT_223416, WEAPON_TYPE_NAME[self.data.trialLand.weaponType])
        UI.ScrollBar:createByText(str)
        return
    elseif wearingWeaponType ==  PublicDefine.WEAPON_TYPE.NONE then
        UI.ScrollBar:createByText(UI.TEXT_223417)
        return
    end
    local tips = UI.Tips:createTips(
        UI.TEXT_223414,
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL
    )

    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        self:showEnterCave()
    end)

    -- mvc.activityModeCaveModel:clearTrialLandSettleData()
    -- local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
    -- Net.NetPlaySystem:requestEnterTrialLand(PublicDefine.ActivityModeCaveType.TrialLand, self.data.modeId, entryList)
end

function ActivityModeCaveChallengeView:showEnterCave()
    local wearingWeaponType = GameDataManager:getInstance():getWearWeaponType()

    local tips = UI.Tips:createTips(
        UI.TEXT_223415,
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL
    )

    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        mvc.activityModeCaveModel:clearTrialLandSettleData()
        local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
        Net.NetPlaySystem:requestEnterTrialLand(PublicDefine.ActivityModeCaveType.TrialLand, self.data.modeId, entryList)
    end)
end

function ActivityModeCaveChallengeView:openRankView()
    -- local rankView = mvc.activityModeCaveRankView:create()
    -- rankView:init()
    -- rankView:center()
    -- self.contentLayout:addChild(rankView, 999)
    mvc.openPanel("ActivityModeCaveLeaderboard", "ActivityModeCaveLeaderboard", self.data.modeId)
end

function ActivityModeCaveChallengeView:updateScore()
    local score = 0
    local entryList = mvc.activityModeCaveModel:getSelctedEntryList()
    for k, v in pairs(entryList) do
        local config = ConfigManager:getAllTrialEntryDataByID(v)
        score = config.score + score
    end
    
    self.score:setText(string.format(UI.TEXT_223402, score))
end

function ActivityModeCaveChallengeView:updateRankRedPoint()
    local redPoint = self.rankBtn:getChildByName("redPoint")
    if redPoint then
        redPoint:setVisible(mvc.activityModeCaveLeaderboardModel:needShowRedPoint(self.data.modeId))
    end
end

function ActivityModeCaveChallengeView:onTouchOutSizeEvent()
    mvc.activityModeCaveModel:clearSelctedEntryList()
    self:close()
end

function ActivityModeCaveChallengeView:bindModel()

end


function ActivityModeCaveChallengeView:unbindModel()

end





return ActivityModeCaveChallengeView












