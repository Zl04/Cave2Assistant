------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaView = class("ArenaView", UI.HWBtnComponent)

local ArenaChallengeView = require "app.modules.arena.ArenaChallengeView"
local ArenaRankingView = require "app.modules.arena.ArenaRankingView"
local ArenaReportView = require "app.modules.arena.ArenaReportView"

local winSize = cc.Director:getInstance():getWinSize()
-- 资源
local COM_RES_LIST = {
    "ui_town_arena.plist",
}

local COM_WIDTH = 1136
local COM_HEIGHT = 640

-- 背包整体布局 --
---------------------------------------
-- 设计尺寸
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640
-- 模块功能tab选择控件
local LAYOUT_TAB_LIST_SPACE = 0
local LAYOUT_TAB_LIST_WIDTH = 157
local LAYOUT_TAB_LIST_HEIGHT = 65
-- 关闭按钮
local LAYOUT_CLOSE_BUTTON_LEFT = 115
local LAYOUT_CLOSE_BUTTON_UP = - 19
-- 模块功能区域高度
local LAYOUT_FUNCTION_HEIGHT = 568
---------------------------------------
-- 组件z序 --
---------------------
-- 布局跟节点
local BAG_ROOT_LAYOUT_ZORDER = 1
-- 功能模块面板
local BAG_FUNCTION_PANEL_ZORDER = 4
-- 关闭按钮
local BAG_COLOSE_BUTTON_ZORDER = 1
local SPINE_TAB_ITEM_BTM_SPACE = 15
local unlockType = PublicDefine.UnlockFunctionType 
---------------------

-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_arena_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_arena_title_back_icon"
-- 挑战
local MENU_CHALLENGE_SPINE_BG_NAME = "effect_ui_arena_title_challenge_bg"
local MENU_CHALLENGE_SPINE_ICON_NAME = "effect_ui_arena_title_challenge_icon"
-- 备战
local MENU_PREPARE_SPINE_BG_NAME = "effect_ui_arena_title_prepare_bg"
local MENU_PREPARE_SPINE_ICON_NAME = "effect_ui_arena_title_prepare_icon"
-- 排行
local MENU_RANKING_SPINE_BG_NAME = "effect_ui_arena_title_ranking_bg"
local MENU_RANKING_SPINE_ICON_NAME = "effect_ui_arena_title_ranking_icon"
-- 战斗记录
local MENU_REPORT_SPINE_BG_NAME = "effect_ui_arena_title_report_bg"
local MENU_REPORT_SPINE_ICON_NAME = "effect_ui_arena_title_report_icon"

-- 功能模块对应的tab索引 --
---------------------
local TAB_INDEX = {
    CHALLENGE = 1,    -- 挑战模块
    PREPARE = 2,   -- 技能模块
    RANKING = 3, -- 排行模块 
    REPORT = 4, -- 战斗历史记录
}

-- UI.BagPanel.TAB_INDEX = TAB_INDEX
UI = UI or {}
UI.ArenaPanel = UI.ArenaPanel or {}
UI.ArenaPanel.TAB_INDEX = TAB_INDEX
---------------------

-- 根据选择的功能标签显示不同的功能面板
-- 创建一个表现书签效果的tab控件
-- 创建一个功能索引对于的功能面板
local function showPanelByTabIndex(self, tabIndex, isInit)
    if (self._tabIndex == tabIndex) then return end
    local lastTabIndex = self._activeTabIndex
    self._activeTabIndex = tabIndex

    self._functionTabList._compList[tabIndex]:active()
    
    local panel = self.PanelList[tabIndex]
    self:hideShareBtn()
    -- 挑战功能面板
    if (tabIndex == TAB_INDEX.CHALLENGE) then
        -- local delayAction = cc.DelayTime:create(0.1)
        -- delayAction:setTag(DELAY_CLEAR_BAG_NOTIFICATION_ACTION_TAG)
        -- self:runAction(cc.Sequence:create(delayAction, cc.CallFunc:create(function()
        --     -- 更新红点提示信息数据
        --     -- require "app.utils.BagNotificationUtil"
        --     -- BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_GIFTBAG)
        --     -- BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_UPGRADABLE_EQUIP)
        --     -- BagNotificationUtil:updateUpgradableItems()
        -- end)))

        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = ArenaChallengeView:create()
            self._activePanel:init(self._contentLayout, nil, self)
        end
        self._contentLayout:getChildByName("BOARD"):show()
    -- 备战功能面板
    elseif (tabIndex == TAB_INDEX.PREPARE) then
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.NewSkillLayer:create(self._contentLayout)
        end
        self._contentLayout:getChildByName("BOARD"):show()
    -- 排行榜面板
    elseif (tabIndex == TAB_INDEX.RANKING) then
        if panel ~= nil then
            self._activePanel = panel
        else
            reload_script_file_mvc("app.modules.arena.ArenaRankingView")
            self._activePanel = ArenaRankingView:create()
            self._activePanel:init()
        end

        self._contentLayout:getChildByName("BOARD"):show()
    -- 战斗记录面板
    elseif (tabIndex == TAB_INDEX.REPORT) then
        -- self:stopActionByTag(DELAY_CLEAR_BAG_NOTIFICATION_ACTION_TAG)
        -- require "app.utils.BagNotificationUtil"
        -- BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_SKILLPOINT, true)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS)

        -- if panel ~= nil then
        --     self._activePanel = panel
        -- else
        --     self._activePanel = UI.NewSkillLayer:create(self._contentLayout)
        -- end
        -- Game.FunctionUnlockManager:getInstance():removeNewFlag(unlockType.UnlockFunctionType_StudySkill)
        -- self._contentLayout:getChildByName("BOARD"):hide()
    else
        assert(false)
    end

    if (self._activePanel) then
        self._activePanel:leftBottom(79, 18)
        -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
        self._activePanel:show()
        if panel == nil then
            self._contentLayout:addChild(self._activePanel, 5)
        end
        -- self._activePanel:showShareBtn(self)
    end
    self.PanelList[tabIndex] = self._activePanel
    for k, v in pairs(self.PanelList) do
        if k ~= tabIndex then
            -- 这里必须调用 show() 函数来显示，在子页面重载该接口实现业务逻辑
            v:hide()
            v:leftBottom(-winSize.width, -winSize.height)
        end
    end
    self:refreshTabState()
end


function ArenaView:ctor()
    ArenaView.super.ctor(
    	self,
    	UI.Type.ARENA_VIEW,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._data = nil
    self._curIdx = idx or TAB_INDEX.CHALLENGE

    self._activePanel = nil
    self._activeTabIndex = 0

    self.PanelList = {}
    self:setInterceptTouches(true);

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLOSE_ROLE_PANEL, self, self.closeWin)
end

function ArenaView:init(bagData, ...)
    self._data = bagData
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaView.super.init(self, bagData, ... )

    self:setTouchEnable(true)
end

function ArenaView:dtor()
    ArenaView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.arena.ArenaView")

    self._data = nil
    self._activePanel = nil
    self.PanelList = {}

    BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_GIFTBAG)
    BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_UPGRADABLE_EQUIP)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLOSE_ROLE_PANEL, self, self.closeWin)    
end


function ArenaView:onInitView()
   -- 创建大背景（根据分辨率适配）
    self._contentLayout = self:createBg()

    -- 创建关闭按钮
    local closeButton = UI.SpineTabItem:create()
    closeButton:init(
        MENU_CLOSE_SPINE_BG_NAME, 
        MENU_CLOSE_SPINE_ICON_NAME,
        nil,
        nil
    )
    closeButton:setSize(120, 52)
    closeButton:addEventListener(UIEvent.TAB_CLICK, self, function(self)
        mvc.closePanel("Arena", "Arena")
    end)
    self._contentLayout:addChild(closeButton, 15)
    closeButton:rightUp(95, -8)
    closeButton:onActive()
    closeButton:setSingle(true)

    -- 创建功能便签
    local functionTabList = UI.TabList:create()
    functionTabList:init(
        LAYOUT_TAB_LIST_SPACE
    )
    functionTabList:leftUp(110, -7)
    -- functionTabList:enableDebugDraw()
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
        -- print(string.format("BagPanel onInitView: select function tab %d.", tabIndex))
        showPanelByTabIndex(self, tabIndex)
    end)
    functionTabList:setDefaultIndex(nil)
    self._contentLayout:addChild(functionTabList, 15)
    self._functionTabList = functionTabList
    -- 挑战
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ARENA_CHALLENGE, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_CHALLENGE_SPINE_BG_NAME, 
        MENU_CHALLENGE_SPINE_ICON_NAME,
        UI.TEXT_1324400,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.CHALLENGE)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
    -- 备战
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ARENA_PREPARE, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_PREPARE_SPINE_BG_NAME,
        MENU_PREPARE_SPINE_ICON_NAME,
        UI.TEXT_1324401,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.PREPARE)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH - 6, LAYOUT_TAB_LIST_HEIGHT)
    -- 排行
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ARENA_RANKING, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_RANKING_SPINE_BG_NAME,
        MENU_RANKING_SPINE_ICON_NAME, 
        UI.TEXT_1324402,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.RANKING)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 4, LAYOUT_TAB_LIST_HEIGHT)

    -- 战斗记录
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ARENA_REPORT, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_REPORT_SPINE_BG_NAME, 
        MENU_REPORT_SPINE_ICON_NAME,
        UI.TEXT_1324403,
        UI.FONT_BOLD,
        {width=118}
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.REPORT)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 26, LAYOUT_TAB_LIST_HEIGHT)

    -- 装饰
    local leftImage = UI.Image:create()
    leftImage:init("ui_arena_foreground_1.png")
    leftImage:leftUp(-leftImage:getContentSize().width, 12)
    self._contentLayout:addChild(leftImage)

    local rightImage = UI.Image:create()
    rightImage:init("ui_arena_foreground_2.png")
    rightImage:rightUp(-rightImage:getContentSize().width, 0)
    self._contentLayout:addChild(rightImage)
end

-- 更新视图
function ArenaView:onUpdateView()
    showPanelByTabIndex(self, self._curIdx)
    self:refreshRedPoint()
    -- self:open();
end

function ArenaView:createBg()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)

    local board = UI.Image:create()
    board:init("ui_4package_box_board.png")
    board:leftBottom(77, 16)
    contentLayout:addChild(board, 1)
    board:setName("BOARD")

    local upLine = UI.Image:create()
    upLine:init("ui_4package_box_up.png")
    upLine:centerUp(-42)
    contentLayout:addChild(upLine, 12)

    local bottomLine = UI.Image:create()
    bottomLine:init("ui_4package_box_down.png")
    bottomLine:leftBottom(15, 0)
    contentLayout:addChild(bottomLine, 12)

    local leftLine = UI.Image:create()
    leftLine:init("ui_4package_box_left.png")
    leftLine:leftBottom(14, 18)
    contentLayout:addChild(leftLine, 11)

    local rightLine = UI.Image:create()
    rightLine:init("ui_4package_box_right.png")
    rightLine:rightBottom(10, 18)
    contentLayout:addChild(rightLine, 4)
    -- contentLayout:enableDebugDraw()
    return contentLayout
end

function ArenaView:bindModel()

end


function ArenaView:unbindModel()

end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function ArenaView:refreshTabState()
    local isShowNewActionFunc = handler(Game.FunctionUnlockManager:getInstance(), Game.FunctionUnlockManager:getInstance().isShowNewAction)
    for k, v in pairs(self._functionTabList._compList) do
        if k == TAB_INDEX.CHALLENGE then
        
        elseif k == TAB_INDEX.PREPARE  then
            self:playTabItemAction(v)

            -- local unLockStateTreasure = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_TreasureMap)
            -- local unLockStateTask = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Task)
            -- local unLockStateAchi = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Achievement)

            -- if unLockStateTreasure and not unLockStateTask and not unLockStateAchi then
            --     self:playTabItemAction(v, unlockType.UnlockFunctionType_TreasureMap)
            -- elseif not unLockStateTreasure and unLockStateTask and not unLockStateAchi then
            --     self:playTabItemAction(v, unlockType.UnlockFunctionType_Task)
            -- elseif not unLockStateTreasure and not unLockStateTask and unLockStateAchi then
            --     self:playTabItemAction(v, unlockType.UnlockFunctionType_Achievement)
            -- elseif not unLockStateTreasure and not unLockStateTask and not unLockStateAchi then
            --      v:disable()
            -- else 
            --     if isShowNewActionFunc(unlockType.UnlockFunctionType_TreasureMap) or isShowNewActionFunc(unlockType.UnlockFunctionType_Task) or isShowNewActionFunc(unlockType.UnlockFunctionType_Achievement) then
            --         v:playNewAction(0.8)
            --     else
            --         v:removeNewAction()
            --     end
            -- end 

        elseif k == TAB_INDEX.RANKING  then
            self:playTabItemAction(v)

            -- local unLockStateSkill = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_StudySkill)
            -- local SceneManager = require("app.game.SceneManager")
            -- if(SceneManager:getInstance():isInHuLu()) then 
            --     if mvc.festivalModel:getHuluChoiceWeaponType() == PublicDefine.WEAPON_TYPE.NONE then 
            --         unLockStateSkill = false
            --     end
            -- end
            -- if unLockStateSkill then
            --     self:playTabItemAction(v, unlockType.UnlockFunctionType_StudySkill)
            -- else
            --     v:disable()
            -- end
        elseif k == TAB_INDEX.REPORT then
            self:playTabItemAction(v)

            -- local unLockHorcurx = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Horcrux)
            -- if not unLockHorcurx then
            --     v:disable()
            -- else
            --     self:playTabItemAction(v, unlockType.UnlockFunctionType_Horcrux)
            -- end
        end
    end
end

function ArenaView:playTabItemAction(tabItem, functionType)
    -- if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
    --     tabItem:disable()
    --     tabItem:playUnlockAction(function()
    --         self:playUnlockActionCallback(tabItem, functionType)
    --     end)
    -- elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
    --     tabItem:playNewAction(0.8)
    -- else
        tabItem:removeNewAction()
    -- end
end

function ArenaView:playUnlockActionCallback(tabItem, functionType)
    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(functionType)
    tabItem:playNewAction(0.8)
    tabItem:removeDisable()
end

function ArenaView:tagDisableClick(targert)
    -- print(targert:getIndex(), "tagDisableClick---------targert:getIndex()", TAB_INDEX.SKILL)          
    if targert:getIndex() == TAB_INDEX.SKILL  then
        local SceneManager = require("app.game.SceneManager")
        if(SceneManager:getInstance():isInHuLu()) then 
            if mvc.festivalModel:getHuluChoiceWeaponType() == PublicDefine.WEAPON_TYPE.NONE then 
                local LanguageManager = require("app.game.LanguageManager")
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113616))
                return
            end
        end
        Game.FunctionUnlockManager:showLockTips(unlockType.UnlockFunctionType_StudySkill)
    else
        UI.ScrollBar:createByText(UI.TEXT_1170901)
    end
end

--刷新标签按钮  是否红点
function ArenaView:refreshRedPoint()
    --技能
    local showRed = false
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInHuLu()) then 
        -- 这里根据是否装满五个技能来设置是否显示小红点
        if mvc.festivalModel:getHuluChoiceWeaponType() ~= PublicDefine.WEAPON_TYPE.NONE and not SkillDataManager:getIsFullChoiceBattleSkill(mvc.festivalModel:getHuluChoiceWeaponType()) then 
            showRed = true
        end
    else
        if SkillDataManager:getSkillStudyNum() > 0 then
            showRed = true
        end
    end
    self:_refreshRedPoint(TAB_INDEX.SKILL, showRed)

end

function ArenaView:_refreshRedPoint(tabIndex, showRed)
    local node = nil
    for k, v in pairs(self._functionTabList._compList) do
        if k == tabIndex  then
            node = v
        end
    end

    if node == nil then
        return
    end

    if showRed then
        node:showRedPoint()
    else
        node:removeRedPoint()
    end
end

function ArenaView:showShareBtn(callback, shareType)
    --分享布局
    if self._sharePanel == nil then
        local sharePanel = UI.SharePanel:create(callback, shareType, true)
        sharePanel:rightBottom(0, -10)
        self._contentLayout:addChild(sharePanel,1000)
        self._sharePanel = sharePanel
    else
        self._sharePanel:show()
        self._sharePanel:refreshParams(callback, shareType, true)
    end
end

function ArenaView:hideShareBtn()
    if self._sharePanel then
        self._sharePanel:hide()
        self._sharePanel:setAllBtnVisible(false)
    end
end


function ArenaView:refreshArenaData()
    if self._activeTabIndex == TAB_INDEX.CHALLENGE then 
        self._activePanel:refreshArenaData()
    end
end

function ArenaView:refreshEnemyData()
    if self._activeTabIndex == TAB_INDEX.CHALLENGE then 
        self._activePanel:refreshArenaEnemyData()
    end
end

function ArenaView:refreshLogsData()
    
end

function ArenaView:refreshRankData()
    
end

return ArenaView












