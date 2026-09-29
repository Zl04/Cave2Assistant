------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/09/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local QuickSideBarView = class("QuickSideBarView", UI.BaseWin)

UI = UI or {}

UI.QuickSideBarView = QuickSideBarView

local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

require("app.datas.TeamDataManager")
require "app.modules.quicksidebar.QuickSideBarTaskCell"
require "app.modules.quicksidebar.QuickSideBarTeamCell"

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_common_icon_item.plist",
    "ui_common_information.plist",
    "ui_common_symbol.plist",
    "ui_general_task.plist",
    "ui_general_chat.plist",
}

local COM_WIDTH = 230
local COM_HEIGHT = 264
local winSize = cc.Director:getInstance():getWinSize()

function QuickSideBarView:openShow()
    self:open()
end

function QuickSideBarView:ctor()
    QuickSideBarView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    -- self:enableDebugDraw()
    self:setInterceptTouches(false)

    self:initData()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_QUICK_SIDE_BAR_OFFSET_UPDATE, self, self.quickSideBarOffsetUpdate)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_HIDE, self, self.hideSidebar)

    -- 显示队伍tab
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_FOCUS_ON_TEAM_TAB, self, self.focusOnTeamTab)

    -- 队伍集散或者自己退出队伍
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_DISMISS_TEAM, self, self.IAMOut)

    -- 添加buffinfo
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_ADD_BUFF_INFO, self, self.addHeroBuffInfo)

    -- 任务
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.refreshTaskList) 
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_REFRESH_ALL_TASK, self, self.refreshTaskList) 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.refreshTaskList)

    -- 队伍
    --有人加入队伍
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_JOIN, self, self.addHeadPanel)
    --有人退出队伍
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamHead)
    --技能选择对象
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SHOW_SKILL_TARGE, self, self.showSkillSelect)
    --指向性技能中断或者取消
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_CANCEL_SKILL, self, self.hideSkillSelect)
    -- 怪物攻击目标
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_MONSTER_ATTACK, self, self.updateMonsterTargetEffect)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 添加buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    -- 更新buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    -- 移除buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)
    --更改队伍在线状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)
    --切换装备
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, self.updateEquipIcon)
    --复活
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SHOW_HELP_REVIVE, self, self.showResurgenceState)
    --取消复活
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.hideResurgenceState)
    --复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.hideResurgenceState)
    --血量显示类型
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_HERO, self, self.onAddHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_HERO, self, self.onRemoveHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, self, self.showQuickChatTips)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ROLE_DUNGEON_SURVIVOR, self, self.refreshRescureCount)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_SHOW_HEAD_TIPS, self, self.addHeadTips)

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.onLeaveBattle)
end

function QuickSideBarView:init()
    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    QuickSideBarView.super.init(self)
end

function QuickSideBarView:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_QUICK_SIDE_BAR_OFFSET_UPDATE, self, self.quickSideBarOffsetUpdate)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_HIDE, self, self.hideSidebar)

    -- 显示队伍tab
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_FOCUS_ON_TEAM_TAB, self, self.focusOnTeamTab)

    -- 队伍集散或者自己退出队伍
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_DISMISS_TEAM, self, self.IAMOut)

    -- 添加buffinfo
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_ADD_BUFF_INFO, self, self.addHeroBuffInfo)

    -- 任务
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.refreshTaskList) 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_REFRESH_ALL_TASK, self, self.refreshTaskList) 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.refreshTaskList)

    -- 队伍
    --有人加入队伍
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_JOIN, self, self.addHeadPanel)
    --有人退出队伍
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamHead)
    --技能选择对象
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SHOW_SKILL_TARGE, self, self.showSkillSelect)
    --指向性技能中断或者取消
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_CANCEL_SKILL, self, self.hideSkillSelect)
    -- 怪物攻击目标
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_MONSTER_ATTACK, self, self.updateMonsterTargetEffect)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 添加buff操作，添加更新移除
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)
    --更改队伍在线状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)
    --切换装备
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, self.updateEquipIcon)
    --复活
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SHOW_HELP_REVIVE, self, self.showResurgenceState)
    --取消复活
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.hideResurgenceState)
    --复活完成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.hideResurgenceState)
    --血量显示类型
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_HERO, self, self.onAddHero)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_HERO, self, self.onRemoveHero)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, self, self.showQuickChatTips)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ROLE_DUNGEON_SURVIVOR, self, self.refreshRescureCount)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_SHOW_HEAD_TIPS, self, self.addHeadTips)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.onLeaveBattle)

    -- $$$$$$ 剥离声网sdk
    -- Avalon.VoiceChatManager:setSpkOnOffCallback(nil)
    -- Avalon.VoiceChatManager:setMicOnOffCallback(nil)

    QuickSideBarView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.quicksidebar.QuickSideBarView")
end

function QuickSideBarView:onInitView()
    self.runActioning = false

    COM_WIDTH = 230
    COM_WIDTH = COM_WIDTH + Avalon.issUtil:getLeftMargin()

    self:initLayout()
    self:initTabs()
    self:initTaskList()
    self:initTeamMemList()
    self:initVoiceBtns()

    self:updateTabs()
    self:updateTeamList()
end

function QuickSideBarView:quickSideBarOffsetUpdate(isShow)
    if runActioning then
        return
    end

    local offsetX = 0
    if isShow then
        offsetX = self.switchBtnState == 0 and -COM_WIDTH or 0
    else
        offsetX = -1000
    end

    self:stopAllActions()
    self:runAction(cc.MoveTo:create(0.1, cc.p(offsetX, 220)))
end

function QuickSideBarView:noTeamMem()
    self.teamTab:setFontColor(UI.FONT_COLOR_40_40_45)
    self.teamTab:disable()
end

function QuickSideBarView:initData()
    self.tabIndex = 1
    if self:isShowTeamtab() then
        self.tabIndex = 2
    end

    self.teamHead = {}
    self.teamHeadList = {}
    self.teamListOffset = 0

    -- 任务数据
    local isInCave = SceneManager:getInstance():isInFightScene()
    self.taskListData = mvc.quickSideBarModel:sortTasks(isInCave)
end

function QuickSideBarView:isShowTeamtab()
    if mvc.quickSideBarModel:checkHasTeam()
        or TeamDataManager:hasMercenaryTeam() then
        return true
        end
    
    return false
end

function QuickSideBarView:initLayout()
    local bg = cc.LayerColor:create(cc.c4b(0,0,0,153))
    bg:setIgnoreAnchorPointForPosition(false)
    bg:setAnchorPoint(cc.p(0.5,0.5))
    bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(bg,1)
    self.contentLayer = bg

    local switchBtnClose = UI.Button:create()
    switchBtnClose:init("ui_task_button_conceal_0.png", "ui_task_button_conceal_1.png")
    local w, h = switchBtnClose:getSize()
    switchBtnClose:centerRight(-w)
    switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    self.contentLayer:addChild(switchBtnClose)
    switchBtnClose:closeClickScale()
    self.switchBtnClose = switchBtnClose
    self.switchBtnClose:hide()

    local switchBtnOpen = UI.Button:create()
    switchBtnOpen:init("ui_task_button_unfold_0.png", "ui_task_button_unfold_1.png")
    local w, h = switchBtnOpen:getSize()
    switchBtnOpen:centerRight(-w)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    self.contentLayer:addChild(switchBtnOpen)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    self.switchBtnOpen:hide()

    -- 展开或缩进
    local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local unfoldState = userData:getQuickSideBarUnfold()
    if unfoldState then
        self.switchBtnState = 1
    else
        self.switchBtnState = 0
        performWithDelay(self, function()
            self.runActioning = true

            self:runAction(cc.Sequence:create(
                cc.MoveTo:create(0, cc.p(-COM_WIDTH,220)),
                cc.CallFunc:create(function()
                    self.runActioning = false
                end))
            )
        end, 0)
    end

    self:updateSwitchBtnShow()
end

function QuickSideBarView:onLeaveBattle()
    self.isInBattle = false
    local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local unfoldState = userData:getQuickSideBarUnfold()
    if unfoldState then
        if self.switchBtnState == 0 then
            self.switchBtnState = 1
            self:stopAllActions()

            self.runActioning = true
            self:runAction(cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(0,220)),
                cc.CallFunc:create(function()
                    self.runActioning = false
                    self:updateSwitchBtnShow()
                end))
            )
        end
    else
        if self.switchBtnState == 1 then
            self.switchBtnState = 0
            self:stopAllActions()

            self.runActioning = true
            self:runAction(cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(-COM_WIDTH,220)),
                cc.CallFunc:create(function()
                    self.runActioning = false
                    self:updateSwitchBtnShow()
                end))
            )
        end
    end
end

function QuickSideBarView:initTabs()
    local taskBtn = UI.Button:create()
    taskBtn:init("ui_task_button_0.png","ui_task_button_1.png","ui_task_button_2.png")
    taskBtn:leftUp(0, 0)
    taskBtn:setText(UI.TEXT_1213230)
    taskBtn:setFontSize(UI.FONT_SIZE_20PX)
    taskBtn:setFontColor(UI.FONT_COLOR_40_40_45)
    taskBtn:closeClickScale()
    taskBtn:keepActivated(true)
    taskBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 1 then
            self:updateTabs()
            return
        end

        self.tabIndex = 1
        self:updateTabs()
    end)
    self.contentLayer:addChild(taskBtn, 100)
    self.taskTab = taskBtn

    local teamBtn = UI.Button:create()
    teamBtn:init("ui_task_button_0.png","ui_task_button_1.png","ui_task_button_2.png")
    teamBtn:leftUp(114, 0)
    if(TeamDataManager:hasMercenaryTeam()) then 
        teamBtn:setText(UI.TEXT_1325707)
    else
        teamBtn:setText(UI.TEXT_1170306)
    end
    teamBtn:setFontSize(UI.FONT_SIZE_20PX)
    teamBtn:setFontColor(UI.FONT_COLOR_40_40_45)
    teamBtn:closeClickScale()
    teamBtn:keepActivated(true)
    teamBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.tabIndex == 2 then
            self:updateTabs()
            return
        end

        self.tabIndex = 2
        self:updateTabs()
    end)

    teamBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
        end
    end)
    self.contentLayer:addChild(teamBtn, 100)
    self.teamTab = teamBtn
end

function QuickSideBarView:initVoiceBtns()
    -- 语音聊天发声开关
    local spkOnSpriteName = "ui_btn_ublic_1.png"
    local spkOffSpriteName = "ui_btn_ublic_2.png"
    self.speakerBtn = UI.Button:create()
    self.speakerBtn:setStatic(true)
    self.speakerBtn:init(spkOnSpriteName, spkOnSpriteName)
    self.speakerBtn:setInterval(1)
    self.speakerBtn:leftUp(240, 0)
    self.contentLayer:addChild(self.speakerBtn, 200)
    self.speakerBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if (not self.speakerBtn:isVisible()) then return end
        local newValue = not self.speakerBtn.__switchOn
        if (newValue) then
            self.speakerBtn:setNormal(spkOnSpriteName)
        else
            self.speakerBtn:setNormal(spkOffSpriteName)
        end
        self.speakerBtn.__switchOn = newValue
        Avalon.VoiceChatManager:setMuteSpeaker(not newValue, true)
        Avalon.VoiceChatManager:saveCurrentSettings()
    end)
    function setSpkBtnState(isOn)
        if (self.speakerBtn.__switchOn == isOn) then return end
        self.speakerBtn.__switchOn = isOn
        self.speakerBtn:setNormal(isOn and spkOnSpriteName or spkOffSpriteName)
        local oriW, oriH = self.speakerBtn:getSize()
        self.speakerBtn:setSize(oriW + 1, oriH + 1)
        self.speakerBtn:setSize(oriW, oriH)
    end
    setSpkBtnState(not Avalon.VoiceChatManager:isSpeakerMuted())
    Avalon.VoiceChatManager:setSpkOnOffCallback(setSpkBtnState)

    -- 语音聊天录音开关
    local micOnSpriteName = "ui_btn_private_1.png"
    local micOffSpriteName = "ui_btn_private_2.png"
    self.micBtn = UI.Button:create()
    self.micBtn:setStatic(true)
    self.micBtn:init(micOnSpriteName, micOnSpriteName)
    self.micBtn:setInterval(1)
    self.micBtn:leftUp(300, 0)
    self.contentLayer:addChild(self.micBtn, 200)
    self.micBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if (not self.micBtn:isVisible()) then return end
        local newValue = not self.micBtn.__switchOn
        if (newValue) then
            self.micBtn:setNormal(micOnSpriteName)
        else
            self.micBtn:setNormal(micOffSpriteName)
        end
        self.micBtn.__switchOn = newValue
        Avalon.VoiceChatManager:setMuteMic(not newValue, true)
        Avalon.VoiceChatManager:saveCurrentSettings()
    end)
    function setMicBtnState(isOn)
        if (self.micBtn.__switchOn == isOn) then return end
        self.micBtn.__switchOn = isOn
        self.micBtn:setNormal(isOn and micOnSpriteName or micOffSpriteName)
        local oriW, oriH = self.micBtn:getSize()
        self.micBtn:setSize(oriW + 1, oriH + 1)
        self.micBtn:setSize(oriW, oriH)
    end

    -- $$$$$$ 剥离声网sdk
    -- setMicBtnState(not Avalon.VoiceChatManager:isMicMuted())
    -- Avalon.VoiceChatManager:setMicOnOffCallback(setMicBtnState)

    -- local isMicMuted = Avalon.VoiceChatManager:isMicMuted()
    -- self.micBtn.__switchOn = not isMicMuted
    -- self.micBtn:setNormal(isMicMuted and micOffSpriteName or micOnSpriteName)
end

function QuickSideBarView:onUpdateView()
    -- if(TeamDataManager:hasMercenaryTeam()) then
    --     --关闭语音设置
    --     Avalon.VoiceChatManager:closeVoiceSettings()
    --     --佣兵模式不显示语音控件
    --     self.speakerBtn:setVisible(false)
    --     self.micBtn:setVisible(false)
    -- else 
    --     self.speakerBtn:setVisible(Avalon.VoiceChatManager:isToShowVoiceChatButtons())
    --     self.micBtn:setVisible(Avalon.VoiceChatManager:isToShowVoiceChatButtons())
    -- end

    --关闭语音设置
    -- $$$$$$ 剥离声网sdk
    -- Avalon.VoiceChatManager:closeVoiceSettings()
    --关闭语音按钮
    self.speakerBtn:setVisible(false)
    self.micBtn:setVisible(false)
end

function QuickSideBarView:initTaskList()
    if(self._tableView == nil and #self.taskListData > 0) then
        local taskCell = UI.QuickSideBarTaskCell.create()
        taskCell:init(self.taskListData[1])
        -- taskCell:retain()
        taskCell:leftBottom(-1000, 1000)
        self:addChild(taskCell)


        self._cellHeightArr = {}
        self._cellArr = {}
        self._tableView = UI.TableView.new({},COM_WIDTH, 210)
        self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        -- self._tableView:centerBottom(5)
        self._tableView:setDelegate()
        self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self._tableView:setBounceable(true) 
        self._tableView:init()
        self._tableView:onUpdateCellSize(function (table,idx)
            -- print("_tableView:onUpdateCells", idx)
            local width = COM_WIDTH
            local height = 20
            taskCell:updateTaskProgress(self.taskListData[idx + 1], true)
            height = taskCell:getHeight()
            return width,height
        end) 

        self._tableView:onUpdateCells(function (table, idx)
            -- print("QuickSideBarView:onUpdateCells table ,idx", table, idx)
            local cell = table:dequeueCell()
            -- cell = nil
            if(cell == nil) then
                xpcall(function()
                    cell = cc.TableViewCell:new()
                    local taskCell = UI.QuickSideBarTaskCell.create()
                    taskCell:init(self.taskListData[idx + 1])
                    taskCell:setName("cell")
                    taskCell:leftBottom(0, 0)
                    -- pArchiveCell:leftUp(0, 0)
                    cell:addChild(taskCell)
                end, 
                function(e) 
                    printError("------------------------ActivityPanel:tableCellAtIndex-----------------error", e)
                end, 1) 
            else
                local obj = cell:getChildByName("cell");
                obj:updateTaskProgress(self.taskListData[idx + 1])
                obj:updateView()
            end
            local obj = cell:getChildByName("cell");
            self._cellArr[idx] = cell
            
            return cell
        end)
        self._tableView:onUpdateCellNumbers(function ()
            -- print("QuickSideBarView table.nums(self.taskListData) =", table.nums(self.taskListData) )
            return table.nums(self.taskListData) 
        end)
        self._tableView:onTableCellTouched(function(table, cell)
            local obj = cell:getChildByName("cell");
            if(not tolua.isnull(obj)) then
                obj:clickHandler()
            end
        end)

        self.contentLayer:addChild(self._tableView)
    end
    if(self._tableView) then
        self._tableView:reloadData()
    end
end

function QuickSideBarView:refreshTaskList()
    if not self.contentLayer then
        return
    end

    local isInCave = SceneManager:getInstance():isInFightScene()
    self.taskListData = mvc.quickSideBarModel:sortTasks(isInCave)

    self:initTaskList()
    self:updateTabs()
end

function QuickSideBarView:initTeamMemList()
    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:setSize(270, 0)
    scrollContent:leftUp(0, 40)
    self.teamMemContent = scrollContent

    -- local scrollView = UI.ScrollView:create()
    -- scrollView:setSize(COM_WIDTH, 210)
    -- scrollView:setScrollType(UI.ScrollType.VERTICAL)
    -- scrollView:init(0, 0, 0, 0)
    -- scrollView:leftUp(0, 40)
    -- scrollView:setScrollBarEnabled(false)
    -- scrollView:setCircleVisible(false)
    -- scrollView:setName("TeamList")
    -- scrollView:enableDebugDraw()
    self.contentLayer:addChild(scrollContent)
    -- self.teamList = scrollView

    -- scrollView:addInnerNode(scrollContent)
    -- scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, self.onScrollViewScrollBeginCallback)
    -- scrollView:disableScrolling()
end

function QuickSideBarView:onScrollViewScrollBeginCallback()
    self.movingBegin = true
    self.initPos = 0
end

function QuickSideBarView:onScrollViewScrollingCallback(percent, currentPostion)
    if self.movingBegin and self.initPos == 0 then
        self.initPos = currentPostion
    end

    if math.abs(currentPostion - self.initPos) > 0.03 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_CELL_CANCEL_CLICK)
    end
end

function QuickSideBarView:onScrollViewScrollEndCallback()
    self.movingBegin = false
    self.initPos = 0
end

function QuickSideBarView:updateTeamList()
    if self:isShowTeamtab() then
        local teamData = TeamDataManager:getTeamData()
        for k , v in pairs(teamData) do
            if k ~= RoleDataManager:getMasterPK() then
                self:addTeamHand(v)
            end
        end
    else
        self:noTeamMem()
    end
end

function QuickSideBarView:updateTabs()
    if self.tabIndex == 1 then
        self.taskTab:press()
        self.teamTab:release()
        if(self._tableView) then
            self._tableView:leftUp(0, 40)
        end
        if self.teamMemContent then
            self.teamMemContent:leftUp(-COM_WIDTH-100, 40)
        end
    else
        self.taskTab:release()
        self.teamTab:enable()
        self.teamTab:press()

        if(self._tableView) then
            self._tableView:leftUp(-COM_WIDTH-100, 40)
        end
        if self.teamMemContent then
            self.teamMemContent:leftUp(0, 40)
        end
    end

    if self:isShowTeamtab() then
        self.teamTab:enable()
    else
        self:noTeamMem()
    end
end

function QuickSideBarView:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerRight(-w)
        self.contentLayer:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerRight(-w)
        self.contentLayer:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:hide()
        self.switchBtnOpen:show()
    end
end

function QuickSideBarView:hideSidebar()
    self.switchBtnState = 1
    self:switchClick()
end

function QuickSideBarView:switchClick()
    local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if self.switchBtnState == 1 then
        self.switchBtnState = 0

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(-COM_WIDTH,220)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )

        -- 仅当多人模式的战斗过程中不记录开关的状态
        if not (self:isShowTeamtab() and self.isInBattle) then
            userData:setQuickSideBarUnfold(false)
        end
    else
        self.switchBtnState = 1

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(0,220)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )

        -- 仅当多人模式的战斗过程中不记录开关的状态
        if not (self:isShowTeamtab() and self.isInBattle) then
            userData:setQuickSideBarUnfold(true)
        end
    end
end

function QuickSideBarView:IAMOut()
    -- 队伍解散或者退出队伍
    self.tabIndex = 1
    self:updateTabs()
end

function QuickSideBarView:focusOnTeamTab()
    self.isInBattle = true

    -- 多人模式进入战斗时，自动弹出，并切换到队伍
    if self.switchBtnState == 0 then
        self.switchBtnState = 1
        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(0,220)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )
    end

    self.tabIndex = 2
    self:updateTabs()
end

function QuickSideBarView:addTeamHand(data)
    if not self.teamMemContent then
        self:initTeamMemList()
    end

    if not self.teamHead then
        return
    end

    if self.teamHead[data:getPK()] == nil then
        local cell = UI.QuickSideBarTeamCell.create()
        cell:init(data, self)
        -- cell:setTouchClipNode(self.teamList)
        -- cell:enableDebugDraw()
        self.teamMemContent:addChild(cell)

        self.teamHead[data:getPK()] = cell
        table.insert(self.teamHeadList,cell)

        -- 更新英雄面板位置
        self:updateRolePanel()
    end

    self:updateTabs()
end

function QuickSideBarView:updateRolePanel()
    local teamListOffset = 0
    for _, cell in ipairs(self.teamHeadList) do
        cell:leftUp(4, teamListOffset)
        teamListOffset = teamListOffset + 94
    end
    self.teamMemContent:setSize(270, teamListOffset)
end

function QuickSideBarView:addHeroBuffInfo(infoLayer)
    if(not tolua.isnull(self) and not tolua.isnull(infoLayer)) then
        self:addChild(infoLayer, 100)
    end
end

--添加头像
function QuickSideBarView:addHeadPanel(data)
    if tolua.isnull(self) then
        return
    end

    if data:getPK() ~= RoleDataManager:getMasterPK() then
        self:addTeamHand(data)

        self.tabIndex = 2
        self:updateTabs()
    end
end

-- 移除队友
function QuickSideBarView:removeTeamHead(pk)
    if not self.teamHead then
        return
    end

    if pk and self.teamHead[pk] then
        for i = 1, #self.teamHeadList do
            if self.teamHeadList[i]:getPK() == pk then
                table.remove(self.teamHeadList, i)
                break
            end
        end

        self.teamHead[pk]:removeFromParent()
        self.teamHead[pk] = nil

        self:updateRolePanel()
    end
end

--显示技能待选
function QuickSideBarView:showSkillSelect(targetType)
    local bit = require "bit"
    local _targetType = bit.band(targetType,3)
    if bit.rshift(_targetType,1) == 1 then
        for id ,comp in pairs(self.teamHead) do
            if comp ~= nil then
                local heroData = RoleDataManager:getHeroDataForPK(id)
                if heroData and GameManager:judgeInSameBattleField(RoleDataManager:getMasterSpriteID(),heroData.spriteID) then
                    comp:ChoseRole()
                end
            end
        end
    end

    self.skillSelectState = true
end

--隐藏技能待选
function QuickSideBarView:hideSkillSelect()
    if not self.teamHead then
        return
    end

    for id, comp in pairs(self.teamHead) do
        if comp ~= nil and (not tolua.isnull(comp))  then
            comp:canelChoseRole()
        end
    end

    self.skillSelectState = false
end

--显示隐藏攻击目标特效
function QuickSideBarView:updateMonsterTargetEffect(spriteID)
    if(tolua.isnull(self)) then
        return 
    end

    if self._monsterTarget ~= spriteID then 
        local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID)
        if roleData then
            local _pk = roleData:getPK()

            if self.teamHead[self._monsterTarget] then
                self.teamHead[self._monsterTarget]:hideMonsterTarget()
            end

            if self.teamHead[_pk] then
                self.teamHead[_pk]:showMonsterTarget()
            end
            self._monsterTarget = _pk
        end
    end
end

-- 英雄面板的更新
function QuickSideBarView:onUpdateHeroDataHandler(roleData)
    if not self.teamHead then
        return
    end

    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        if roleData and self.teamHead[_pk] then
            self.teamHead[_pk]:refreshView(roleData)
            self.teamHead[_pk]:refreshRescure(roleData:getRescuedDungeonSurvivorCount())
        end
    end
end

-- 角色状态改变
function QuickSideBarView:onUpdateRoleStateHandler(roleData)
    if not self.teamHead then
        return
    end

    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        -- 其他队友 
        if roleData and self.teamHead[_pk] then
            self.teamHead[_pk]:updateState(roleData)

            local heroData = RoleDataManager:getHeroDataForPK(_pk)
            if self.skillSelectState == true then
                if heroData:getState() == FSMState.BATTLE then
                    if GameManager:judgeInSameBattleField(RoleDataManager:getMasterSpriteID(),heroData.spriteID) then
                        self.teamHead[_pk]:ChoseRole()
                    end
                end
            end
        end
    end
end

-- 添加buff
function QuickSideBarView:onAddRoleBuffHandler(data)
    if not self.teamHead then
        return
    end

    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID)
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if data and self.teamHead[_pk] then
                self.teamHead[_pk]:addBuffView(data)
            end
        end
    end
end

-- 移除buff
function QuickSideBarView:onRemoveRoleBuffHandler(data)
    if not self.teamHead then
        return
    end

    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if data and self.teamHead[_pk] then
                self.teamHead[_pk]:removeBuffView(data)
            end
        end
    end
end

-- 角色buff页面的更新
function QuickSideBarView:onUpdateRoleBuffHandler(data)
    if not self.teamHead then
        return
    end

    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if data and self.teamHead[_pk] then
                self.teamHead[_pk]:updateBuffView(data)
            end
        end
    end
end

--刷新队伍在线状态
function QuickSideBarView:updateOnLineState(pk,online)
    if not self.teamHead then
        return
    end

    if self.teamHead[pk] then
        self.teamHead[pk]:updateOnLineState(online)
    end
end

--刷新武器图标
function QuickSideBarView:updateEquipIcon(data)
    if not self.teamHead then
        return
    end

    local roleData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if data and self.teamHead[_pk] then
                self.teamHead[_pk]:updateEquipIcon()
            end
        end
    end
end

--创建headTips
function QuickSideBarView:addHeadTips(pk, data)
    if not self.teamHead then
        return
    end

    if self.teamHead[pk] then
        local pHeadTips = UI.HeadTips:create(UIType.TEAMMATESTATUS)
        local _x,_y = self.teamHead[pk]:getPos()
        pHeadTips:setPos(_x + 115,_y + -180)
        pHeadTips:init(data)
        self:addChild(pHeadTips,99)
    end
end

--显示复活按钮
function QuickSideBarView:showResurgenceState(PK)
    if not self.teamHead then
        return
    end

    if self.teamHead[PK] then
        self.teamHead[PK]:showResurgence()
    end
end

--隐藏复活按钮
function QuickSideBarView:hideResurgenceState(roleData)
    if not self.teamHead then
        return
    end

    if roleData and self.teamHead[roleData:getPK()] then
        self.teamHead[roleData:getPK()]:onResurgenceCallBack()
    end
end

--刷新血量显示规则
function QuickSideBarView:refreshRoleInfoShowType()
    if not self.teamHead then
        return
    end

    for k,v in pairs(self.teamHead) do
        v:refreshRoleInfoShowType()
    end 
end

function QuickSideBarView:onAddHero(roleData)
    if not self.teamHead then
        return
    end

    if roleData and self.teamHead[roleData:getPK()] and roleData:getIsDead() and roleData:getState() ~= FSMState.BATTLE then
        self.teamHead[roleData:getPK()]:showResurgence()
    end
end

function QuickSideBarView:onRemoveHero(roleData)
    if not self.teamHead then
        return
    end

    if roleData and self.teamHead[roleData:getPK()] then
        self.teamHead[roleData:getPK()]:onResurgenceCallBack()
    end
end

function QuickSideBarView:onCurrencyChangeHandler()
    if not self.teamHead then
        return
    end

    for k, heroPanel in pairs(self.teamHead) do 
        heroPanel:refreshResurgence()
    end
end

function QuickSideBarView:showQuickChatTips(pk, text)
    if not self.teamHead then
        return
    end

    if self.teamHead[pk] then
        self.teamHead[pk]:showQuickChatTips(text) 
    end
end

function QuickSideBarView:refreshRescureCount(pk, count)
    if not self.teamHead then
        return
    end

    if self.teamHead[pk] then
        self.teamHead[pk]:refreshRescure(count)
    end
end

function QuickSideBarView:refreshActivity()
    if not self.teamHead then
        return
    end

    for id, comp in pairs(self.teamHead) do
        if comp ~= nil and (not tolua.isnull(comp))  then
            comp:refreshResurgence()
        end
    end
end

function QuickSideBarView:bindModel()

end

function QuickSideBarView:unbindModel()

end

return QuickSideBarView
