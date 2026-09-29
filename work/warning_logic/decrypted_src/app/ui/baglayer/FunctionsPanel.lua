--[[
    UI - 背包
    修改：2017年04月12
    1.界面有三部分改为两部分
    2.血条位置调整
    3.导航栏调整

]]--

require "app.ui.Component"
require "app.ui.common.Tab.TabList"
require "app.ui.common.Animation"
require "app.ui.common.ScrollView"
require "app.ui.baglayer.Role.RolePanelNew"
require "app.ui.baglayer.Log.LogPanel"
-- require "app.ui.baglayer.Setting.SettingPanel"
require "app.ui.baglayer.SkillLayer.NewSkillLayer"
require "app.ui.baglayer.TaskLayer.TaskLayer"
require "app.ui.baglayer.TaskLayer.TaskLayerUI"
require "app.ui.common.Tab.SpineTabItem"
require "app.ui.baglayer.PictureAlbum.PictureAlbumLayerUI"
require "app.ui.baglayer.Talent.RoleTalentLayer"

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local FunctionsPanel = class("FunctionsPanel", UI.CenterWin)
UI.FunctionsPanel = FunctionsPanel

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 800
local COM_HEIGHT = 500
-- 背包资源
local COM_RES_LIST = {
}

-- 图片名字 --
---------------------------------------
-- 关闭按钮
local MENU_CLOSE_SPINE_BG_NAME = "effect_ui_package_title_back_bg"
local MENU_CLOSE_SPINE_ICON_NAME = "effect_ui_package_title_back_icon"
-- 角色
local MENU_ROLE_SPINE_BG_NAME = "effect_ui_package_title_role_bg"
local MENU_ROLE_SPINE_ICON_NAME = "effect_ui_package_title_role_icon"
-- 任务
local MENU_TASK_SPINE_BG_NAME = "effect_ui_package_title_task_bg"
local MENU_TASK_SPINE_ICON_NAME = "effect_ui_package_title_task_icon"
-- 技能
local MENU_SKILL_SPINE_BG_NAME = "effect_ui_package_title_skill_bg"
local MENU_SKILL_SPINE_ICON_NAME = "effect_ui_package_title_skill_icon"
-- 天赋
local MENU_TALENT_SPINE_BG_NAME = "effect_ui_package_title_log_bg"
local MENU_TALENT_SPINE_ICON_NAME = "effect_ui_package_title_talent_icon"
-- 日志
local MENU_LOG_SPINE_BG_NAME = "effect_ui_package_title_set_bg"
local MENU_LOG_SPINE_ICON_NAME = "effect_ui_package_title_log_icon"
--画册
local MENU_PICTURE_ALBUM_BG_NAME = "effect_ui_package_title_set_bg"
local MENU_PICTURE_ALBUM_ICON_NAME = "effect_ui_pets_picturealbum_icon"

---------------------------------------

-- 动画数据 --
---------------------------------------
--spine 动画name
local UNLOCK_SPINE_NAME = "effect_UI_2package_unlock"
---------------------------------------

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

-- 功能模块对应的tab索引 --
---------------------
local TAB_INDEX = {
    -- ROLE = 1,    -- 角色模块
    TASK = 1,    -- 任务模块
    -- SKILL = 1,   -- 技能模块
    -- TALENT = 3, -- 天赋模块 
    LOG = 2,     -- 日志模块
    PICTURE_ALBUM = 3, --画册模块
}
---------------------

-- 根据选择的功能标签显示不同的功能面板
-- 创建一个表现书签效果的tab控件
-- 创建一个功能索引对于的功能面板
local function showPanelByTabIndex(self, tabIndex)

    print("tabIndex===>", tabIndex)
    print("tabIndex===>", tabIndex)
    print("tabIndex===>", tabIndex)
    if (self._tabIndex == tabIndex) then return end
    local lastTabIndex = self._activeTabIndex
    self._activeTabIndex = tabIndex

    self._functionTabList._compList[tabIndex]:active()
    
    local panel = self.PanelList[tabIndex]
    self:hideShareBtn()
    -- 角色功能面板
    if (tabIndex == TAB_INDEX.ROLE) then
        if panel ~= nil then
            self._activePanel = panel
        else
            local bagData = GameDataManager:getInstance():getPacketBoxData()
            self._activePanel = UI.RolePanel:create()
            self._activePanel:init(self._contentLayout,bagData, self)
        end
        self._contentLayout:getChildByName("BOARD"):hide()
    -- 日志功能面板
    elseif (tabIndex == TAB_INDEX.LOG) then
        if panel ~= nil then
            self._activePanel = panel
        else
            local logData = GameDataManager:getInstance():getRewardData()
            self._activePanel = UI.LogPanel:create()
            self._activePanel:init(logData)
        end
        self._contentLayout:getChildByName("BOARD"):show()
    -- 功能设置面板
    elseif (tabIndex == TAB_INDEX.TALENT) then
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.RoleTalentLayer:create()
            self._activePanel:init()
        end
        Game.FunctionUnlockManager:getInstance():removeNewFlag(unlockType.UnlockFunctionType_RoleTalent)
        self._contentLayout:getChildByName("BOARD"):show()
    -- 技能面板
    elseif (tabIndex == TAB_INDEX.SKILL) then
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.NewSkillLayer:create(self._contentLayout)
        end
        Game.FunctionUnlockManager:getInstance():removeNewFlag(unlockType.UnlockFunctionType_StudySkill)
        self._contentLayout:getChildByName("BOARD"):hide()
    -- 任务面板
    elseif (tabIndex == TAB_INDEX.TASK) then
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.TaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_BAG)
            self._activePanel:init()
        end
        self._contentLayout:getChildByName("BOARD"):show()
    -- 画册面板
    elseif (tabIndex == TAB_INDEX.PICTURE_ALBUM) then
        if panel ~= nil then
            self._activePanel = panel
        else
            self._activePanel = UI.PictureAlbumLayerUI:create(self._spriteID)
            self._activePanel:init()
        end
        self._contentLayout:getChildByName("BOARD"):show()
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
        self._activePanel:showShareBtn(self)
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

-- 构造函数
function FunctionsPanel:ctor(idx, spriteID)
    FunctionsPanel.super.ctor(self, UIType.MAIN_UI_FUNCTIPN_PANEL_TYPE, COM_RES_LIST, LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)

    self._data = nil
    self._curIdx = idx or TAB_INDEX.TASK
    self._spriteID = spriteID

    self._activePanel = nil
    self._activeTabIndex = 0

    self.PanelList = {}
    self:setInterceptTouches(true);
end

-- 析构函数
function FunctionsPanel:dtor()
    self._data = nil
    self._activePanel = nil

    FunctionsPanel.super.dtor(self)

    self:unRegisterListener();
    self.PanelList = {}
end
-- 
function FunctionsPanel:getSettingTabIdx()
    return TAB_INDEX.TALENT
end
-- public:
-- 初始化
function FunctionsPanel:init(bagData)
    self._data = bagData

    FunctionsPanel.super.init(self)

    self:setTouchEnable(true)
    self:registerListener();
end

-- 初始化视图
function FunctionsPanel:onInitView()
    -- 创建大背景（根据分辨率适配）
    self._contentLayout = self:createBg()
    -- local scaleX = winSize.width / LAYOUT_DESIGN_WIDTH
    -- local scaleY = winSize.height / (LAYOUT_DESIGN_HEIGHT + 45)
    -- local scale = scaleX > scaleY and scaleY or scaleX
    -- if (scale > 1.0) then scale = 1.0 end
    -- self._contentLayout:setScale(scale)
 
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
        self:closeWin()
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
        -- print(string.format("FunctionsPanel onInitView: select function tab %d.", tabIndex))
        showPanelByTabIndex(self, tabIndex)
    end)
    functionTabList:setDefaultIndex(nil)
    self._contentLayout:addChild(functionTabList, 15)
    self._functionTabList = functionTabList
    -- -- 角色
    -- local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_ROLE, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_ROLE_SPINE_BG_NAME, 
    --     MENU_ROLE_SPINE_ICON_NAME,
    --     UI.TEXT_DES_ROLE,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.ROLE)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH, LAYOUT_TAB_LIST_HEIGHT)
    -- -- 任务
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_TASK, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_TASK_SPINE_BG_NAME, 
        MENU_TASK_SPINE_ICON_NAME,
        UI.TEXT_DES_TASK,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.TASK)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 3, LAYOUT_TAB_LIST_HEIGHT)
    --技能
    -- local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_SKILL, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_SKILL_SPINE_BG_NAME,
    --     MENU_SKILL_SPINE_ICON_NAME,
    --     UI.TEXT_DES_SKILL,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.SKILL)
    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH - 6, LAYOUT_TAB_LIST_HEIGHT)
    -- 天赋
    -- local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_TALENT, SPINE_TAB_ITEM_BTM_SPACE)
    -- functionTab.onDisableClick = handler(self, self.tagDisableClick)
    -- functionTab:init(
    --     MENU_TALENT_SPINE_BG_NAME,
    --     MENU_TALENT_SPINE_ICON_NAME, 
    --     UI.TEXT_DES_TALENT ,
    --     UI.FONT_BOLD
    -- )
    -- functionTabList:addToTab(functionTab, TAB_INDEX.TALENT)

    -- functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 4, LAYOUT_TAB_LIST_HEIGHT)
    -- 日志
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_ITEM_LOG, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_LOG_SPINE_BG_NAME, 
        MENU_LOG_SPINE_ICON_NAME,
        UI.TEXT_DES_LOG,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.LOG)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 26, LAYOUT_TAB_LIST_HEIGHT)

    --画册
    local functionTab = UI.SpineTabItem:create(UIType.FUNCTION_TAB_PICTURE_ALBUM, SPINE_TAB_ITEM_BTM_SPACE)
    functionTab.onDisableClick = handler(self, self.tagDisableClick)
    functionTab:init(
        MENU_PICTURE_ALBUM_BG_NAME, 
        MENU_PICTURE_ALBUM_ICON_NAME,
        UI.TEXT_PICTURE_ALBUM,
        UI.FONT_BOLD
    )
    functionTabList:addToTab(functionTab, TAB_INDEX.PICTURE_ALBUM)
    functionTab:setSize(LAYOUT_TAB_LIST_WIDTH + 26, LAYOUT_TAB_LIST_HEIGHT)
end

-- 更新视图
function FunctionsPanel:onUpdateView()
    showPanelByTabIndex(self, self._curIdx)
    self:refreshRedPoint()
    self:open();
end

function FunctionsPanel:createBg()
    -- self:addChild(_backgroudImage,99999)

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

-- 禁用使用道具
function FunctionsPanel:disableToUseGoods()
    self._bagGridList:disable()
end

-- 跟新基础数据
function FunctionsPanel:updateBasicInfoView(data)
    if (data) then
        if (self._activeTabIndex == TAB_INDEX.ROLE) then
            self._activePanel:updateBasicInfoView(data)
        end
    end
end


-- 角色状态改变 ODEI
function FunctionsPanel:onUpdateRoleStateHandler(roleData)
    -- TODO add by zp
    local spriteID = roleData:getSpriteID()
    if RoleDataManager:getMasterSpriteID() == spriteID then
        -- 判断死亡
        if (roleData:getIsDead()) then
            self:disableToUseGoods()
        end
    end
end

-- 英雄面板的更新
function FunctionsPanel:onUpdateHeroDataHandler(roleData)
    local spriteID = roleData:getSpriteID()

    if RoleDataManager:getMasterSpriteID() == spriteID then
        self:updateBasicInfoView(roleData)
    end
end

-- 注册监听事件(可选)
function FunctionsPanel:registerListener()
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    -- 红点
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)
end


-- 注销监听事件(可选)
function FunctionsPanel:unRegisterListener()
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    -- 红点
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function FunctionsPanel:refreshTabState()
    local isShowNewActionFunc = handler(Game.FunctionUnlockManager:getInstance(), Game.FunctionUnlockManager:getInstance().isShowNewAction)
    for k, v in pairs(self._functionTabList._compList) do
        if k == TAB_INDEX.ROLE then
        
        elseif k == TAB_INDEX.TASK  then
            local unLockStateTreasure = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_TreasureMap)
            local unLockStateTask = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Task)
            local unLockStateAchi = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Achievement)

            if unLockStateTreasure and not unLockStateTask and not unLockStateAchi then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_TreasureMap)
            elseif not unLockStateTreasure and unLockStateTask and not unLockStateAchi then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_Task)
            elseif not unLockStateTreasure and not unLockStateTask and unLockStateAchi then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_Achievement)
            elseif not unLockStateTreasure and not unLockStateTask and not unLockStateAchi then
                 v:disable()
            else 
                if isShowNewActionFunc(unlockType.UnlockFunctionType_TreasureMap) or isShowNewActionFunc(unlockType.UnlockFunctionType_Task) or isShowNewActionFunc(unlockType.UnlockFunctionType_Achievement) then
                    v:playNewAction(0.8)
                else
                    v:removeNewAction()
                end
            end 

        elseif k == TAB_INDEX.SKILL  then
            local unLockStateSkill = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_StudySkill)
            if unLockStateSkill then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_StudySkill)
            else
                v:disable()
            end
        elseif k == TAB_INDEX.LOG  then 
            local unLockFightLog = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_FightLog)
            local unLockStateCollect = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Pokedex)
            local unLockFunnyRecord = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_FunnyRecord)

            if not unLockFightLog and not unLockStateCollect and not unLockFunnyRecord then
                v:disable()
            elseif unLockFightLog and not unLockStateCollect and not unLockFunnyRecord then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_FightLog)
            elseif not unLockFightLog and unLockStateCollect and not unLockFunnyRecord then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_Pokedex)
            elseif not unLockFightLog and not unLockStateCollect and unLockFunnyRecord then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_FunnyRecord)
            else
                if isShowNewActionFunc(unlockType.UnlockFunctionType_FightLog) or isShowNewActionFunc(unlockType.UnlockFunctionType_Pokedex)  or isShowNewActionFunc(unlockType.UnlockFunctionType_FunnyRecord) then
                    v:playNewAction(0.8)
                else
                    v:removeNewAction()
                end
            end
            
        elseif k == TAB_INDEX.TALENT  then
            local unLockStateTalent = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_RoleTalent)
            if unLockStateTalent then
                self:playTabItemAction(v, unlockType.UnlockFunctionType_RoleTalent)
            end
        end
    end
end

function FunctionsPanel:playTabItemAction(tabItem, functionType)
    if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
        tabItem:disable()
        tabItem:playUnlockAction(function()
            self:playUnlockActionCallback(tabItem, functionType)
        end)
    elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
        tabItem:playNewAction(0.8)
    else
        tabItem:removeNewAction()
    end
end

function FunctionsPanel:playUnlockActionCallback(tabItem, functionType)
    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(functionType)
    tabItem:playNewAction(0.8)
    tabItem:removeDisable()
end

function FunctionsPanel:tagDisableClick(targert)
    -- dump(targert:getIndex(), "---------targert:getIndex()")          
    if targert:getIndex() == TAB_INDEX.SKILL  then
        Game.FunctionUnlockManager:showLockTips(unlockType.UnlockFunctionType_StudySkill)
    else
        UI.ScrollBar:createByText(UI.TEXT_1170901)
    end
end

--刷新标签按钮  是否红点
function FunctionsPanel:refreshRedPoint()
    --任务
    local showRed = false
    if TaskDataManager:haveFinishTask(false) or MasterDataManager:hasOneAchevementComplete() or GoodsDataManager:isHavaNewTreasureFragment() then
        showRed = true
    end

    self:_refreshRedPoint(TAB_INDEX.TASK, showRed)

    local pRed = PictureAlbumManager:isRedDot()

    self:_refreshRedPoint(TAB_INDEX.PICTURE_ALBUM, pRed)

end

function FunctionsPanel:_refreshRedPoint(tabIndex, showRed)
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

function FunctionsPanel:showShareBtn(callback, shareType)
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

function FunctionsPanel:hideShareBtn()
    if self._sharePanel then
        self._sharePanel:hide()
    end
end