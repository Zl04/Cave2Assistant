------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/26
--desc	: 群怪战斗界面信息layer
------------------------------------------------------------------------------
require "app.ui.battlelayer.MonsterPanelCell"
require "app.ui.battlelayer.GroupBattleLogView"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}
local GroupMonsterPanel = class("GroupMonsterPanel",UI.HWBtnComponent)
UI.GroupMonsterPanel  = GroupMonsterPanel

local Scheduler = Avalon.Scheduler
local size = cc.Director:getInstance():getWinSize()

--怪物血条血量怪物血量
local font =  "Arial"
local SHOW_BUFFER_NUM = 10

local BUFF_ICON_WIDTH  = 24
local BUFF_BACK_WIDTH  = 720 + 60
local BUFF_ICON_SPACING = 5
local BUFF_BACK_HEIGHT = 590 

local CELL_WIDTH = 470+20
local CELL_HEIGHT = 85

-- 弹出详情页面的时间间隔
local TIME_SPACED = 0.2

local ZORDER_MONSTER_INFO_BG = 1
local ZORDER_MONSTER_PANEL_NAME = 12

-- 测试开关
local DEBUG = false

local MONSTER_PANEL_INIT_INFO = {
  X = 0,
  Y = 0,
  WIDTH = 470,
  HEIGHT = size.height
}

local MONSTER_PANEL_RES_LIST = {
    "ui_common_icon_effect.plist",
    "ui_town_guild_giftbox.plist",
    "ui_town_reincarnation.plist",
}

local BATTLE_CHANT_2 = "ui_gaming_battle_chant_2.png"
local BATTLE_CHANT_3 = "ui_gaming_battle_chant_3.png"

local MONSTER_PANEL_SPRITE_FRAME_MAP = {
    WEEKPOINT_VALUE = "symbol_monsterattribute_%s_0.png",
    M_ATK = "symbol_gaming_atk.png",
    M_DEF = "symbol_gaming_def.png",
    M_MDEF = "symbol_gaming_maggicdef.png",
    M_ASPD = "symbol_gaming_aspd.png",
    M_ATT_ATK =  "symbol_monsterattribute_%s_1.png",
    M_ATT_DEF =  "symbol_monsterattribute_%s_2.png",

    ESCAPE_SP_1 = "ui_gaming_battle_escape_1.png",
    ESCAPE_SP_3 = "ui_gaming_battle_escape_3.png",

    BLOOD_BAR_NEW_10 = "ui_battle_monsterhp_10.png",
    BLOOD_BAR_NEW_11 = "ui_battle_monsterhp_11.png",
    BLOOD_BAR_NEW_12 = "ui_battle_monsterhp_12.png",
    BLOOD_BAR_TITLE_ELITE = "ui_battle_monsterhp_00.png",

    MONSTER_INFO_BACK = "ui_reincarnation_fight_box.png",

    MONSTER_INFO_BACK2 = "ui_banner_gaming_battle_monsterinfo_back.png",

    ICON_EFFECT_TEST_0 = "effect_buff_0.png",
}

-- 构造函数
function GroupMonsterPanel:ctor()

    GroupMonsterPanel.super.ctor(self, UIType.MONSTER_PANEL, MONSTER_PANEL_RES_LIST, MONSTER_PANEL_INIT_INFO.WIDTH, MONSTER_PANEL_INIT_INFO.HEIGHT, true)

    self._data = nil
    -- -- 角色的名字
    -- self._roleName = nil 
    -- -- 角色血量
    -- self._monsterhp      = nil
    -- self._monsterhp_1    = nil
    -- self._monsterhp_0    = nil  -- 精英怪
    -- self._monsterhpNum   = nil 
    -- -- 头像
    -- self._avatarSp = nil 
    -- self._lastScale = 1 
    -- self._attactLayer = nil 
    -- self._propertyLayer = nil 
    -- self._bufftable = {} 
    -- self._debufftable = {}
    -- self._buffLayer = nil 
    self._monstername = nil
    -- self._weaknessSp = nil 
    -- self._isTouchLongTime = false
    -- self._buffInfoLayer = nil
    -- self._buffInfoBg = nil 
    
    -- 吟唱滑条，引导滑条
    self._chantTimer = nil 
    self._guideTimer = nil 

    -- 逃跑对象 
    self._escapeItem = nil
    self.energyNode = nil
    self.fullEnergy = nil
    self.info_back = nil
    
    self.switchBtnState = 0
    self.headList = {}

    self.lastSwitchTime = 0
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
        --开始吟唱
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_ACCUMULATE, self, self.addChantTimer)
        --技能使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.onSkillEndSingHandler)
        --技能中断
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_BREAK, self, self.onSkillBreakHandler)
    -- 怪物信息更新
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA,self,self.onUpdateRoleDataHandler)
    -- -- 添加buff
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.addBuffView)
    -- -- 更新buff
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.updateBuffView)
    -- -- 移除buff
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.removeBuffView)
    -- 使用技能
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_USE_SKILL, self, self.onUseSkill)
    -- 逃跑失败
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ESCAPE_FAILED, self, self.onEscapeFailed)
    -- 取消逃跑
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ESCAPE_CANCEL, self, self.onEscapeFailed)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_ENERGE_UPDATE, self, self.onHorcurxEnergeUpdate)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_TRIGGER_MONSTER, self, self.triggerMonsterRefresh)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_STATUS_CONSTRAINT,self,self.onShowEscape)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_DATA, self, self.onSwitchBattleChangeMonsterInfo)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME, self, self.setLastSwitchTime)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GROUP_MONSTER_DEAD_AND_CLEAR_DATA, self, self.removeDeadTarget)
end


    -- 初始化
function GroupMonsterPanel:init(data, targetList)
    -- print ("====GroupMonsterPanel:init====")
    self._data = data
    self.targetList = targetList
    self._attactLayer = cc.Layer:create()
    self._attactLayer:setCascadeOpacityEnabled(true)
    self._propertyLayer = cc.Layer:create()
    self._propertyLayer:setCascadeOpacityEnabled(true)
    GroupMonsterPanel.super.init(self,data)  
    -- self:addTouchEvents()
end

--析构函数
function GroupMonsterPanel:dtor()
    -- print("GroupMonsterPanel dtor:")
    -- reload_script_file("app.ui.battlelayer.GroupMonsterPanel")
    self._chantTimer = nil 
    self._guideTimer = nil 
    self._data = nil
    self._escapeItem = nil

    self.info_back = nil
    self.switchBtnState = 0

    self.headList = {}
    self.lastSwitchTime = 0

    GroupMonsterPanel.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    --开始吟唱
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_ACCUMULATE, self, self.addChantTimer)

    --技能使用
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.onSkillEndSingHandler)
    --技能中断
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_BREAK, self, self.onSkillBreakHandler)
    -- 怪物信息更新
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA,self,self.onUpdateRoleDataHandler)

    -- -- 添加buff操作，添加更新移除
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.addBuffView)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.updateBuffView)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.removeBuffView)
    -- 使用技能
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_USE_SKILL, self, self.onUseSkill)
    -- 逃跑失败
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ESCAPE_FAILED, self, self.onEscapeFailed)
    -- 取消逃跑
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ESCAPE_CANCEL, self, self.onEscapeFailed)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_ENERGE_UPDATE, self, self.onHorcurxEnergeUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_TRIGGER_MONSTER, self, self.triggerMonsterRefresh)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_STATUS_CONSTRAINT,self,self.onShowEscape)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_DATA, self, self.onSwitchBattleChangeMonsterInfo)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME, self, self.setLastSwitchTime)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GROUP_MONSTER_DEAD_AND_CLEAR_DATA, self, self.removeDeadTarget)

    reload_script_file("app.ui.battlelayer.GroupMonsterPanel")
end

function GroupMonsterPanel:onUpdateHeroDataHandler(heroData)
    if(heroData and heroData:getType() == RoleType.Hero and self._escapeItem) then
        if(heroData:isMasterHero()) then
            if(heroData:getIsDead()) then
                self._escapeItem:setEnabled(false)
            else
                self._escapeItem:setEnabled(true)
            end
        end
    end
end

-- 初始化视图
function GroupMonsterPanel:onInitView()
    -- 任务快捷栏的检查
    if mvc.quickSideBarModel:checkHasTeam() then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_FOCUS_ON_TEAM_TAB)
    end

    self.fullEnergy = nil

    print("GroupMonsterPanel:initView")

    local name_back = UI.Image9:create()
    name_back:init(MONSTER_PANEL_SPRITE_FRAME_MAP.MONSTER_INFO_BACK2, nil, cc.size(150, 38))
    name_back:centerUp(30)
    self:addChild(name_back)

    -- 信息背景
    local info_back = UI.Image9:create()
    info_back:init(MONSTER_PANEL_SPRITE_FRAME_MAP.MONSTER_INFO_BACK, nil, cc.size(372, 168))
    info_back:centerUp(60)
    self:addChild(info_back)
    self.info_back = info_back

     -- 怪物名字 测试完成后打开
     local roteName  = self._data and self._data:getName() or "*未知*"
     local monstername = UI.Text:create()
     monstername:init(roteName, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
     monstername:centerUp(45- monstername:getContentSize().height/2)
     self._monstername = monstername
     self:addChild(monstername,ZORDER_MONSTER_PANEL_NAME)
    
    -- 吟唱进度
    self._chantTimer = UI.ProgressTimer:create()
    self._chantTimer:init(BATTLE_CHANT_2,nil,BATTLE_CHANT_3)
    self._chantTimer:centerBottom(186)
    self._chantTimer:hide()
    self:addChild(self._chantTimer)
    
    -- 引导
    self._guideTimer = UI.ProgressTimer:create()
    self._guideTimer:init(BATTLE_CHANT_2,nil,BATTLE_CHANT_3)
    self._guideTimer:hide()

    local guideY = 186
    self._guideTimer:centerBottom(guideY)
    self:addChild(self._guideTimer)

    --逃跑按钮 
    local escape_1 = cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.ESCAPE_SP_1) 
    local escape_2 = cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.ESCAPE_SP_1) 

    --菜单按钮  
    local escapeItem = cc.MenuItemImage:create()
    escapeItem:setNormalSpriteFrame(escape_1:getSpriteFrame())  
    escapeItem:setSelectedSpriteFrame(escape_2:getSpriteFrame())  
    escapeItem:setDisabledSpriteFrame(escape_2:getSpriteFrame())  
    -- 按钮的位置
    local px = self:getContentSize().width/2
    local py = self._hh/2
    py = 160
    local escapeMenu = cc.Menu:create(escapeItem)  
    escapeMenu:setPosition(cc.p(px,py))  
    self:addChild(escapeMenu,1) 
    self._escapeItem = escapeItem
    self._escapeX = px
    self._escapeY = py
    self.escapeMenu = escapeMenu
    --进度条图片
    escapeItem:registerScriptTapHandler(function(sender)
        self:onEscapeClick(sender, false)
    end)

    -- 逃跑文字
    local escapeLabel = UI.Text:create()
    escapeLabel:init(LanguageManager:getInstance():getLocalString(1110361),UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    escapeLabel:useDefaultShadowOnlyStype()
    self:addChild(escapeLabel,3)
    escapeLabel:leftBottom(px - escapeLabel:getContentSize().width /2, py - escapeLabel:getContentSize().height / 2)
    self.escapeLabel = escapeLabel

    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInStory() then
        escapeMenu:setVisible(false)
        escapeItem:setEnabled(false)
        escapeLabel:setVisible(false)
    end

    local heroData = GameDataManager:getInstance():getMaster()
    if heroData and heroData.residualEscapeTime and heroData.residualEscapeTime ~= 0 then 
        self:onEscapeClick(escapeItem, true)
    end

    local hasRead = cc.UserDefault:getInstance():getBoolForKey("battleDesHasRead",false)
    if not hasRead then
        -- 群怪切换目标说明
        local switchBattleDes = UI.Button:create();
        switchBattleDes:init()
        switchBattleDes:centerUp(55, 230)
        switchBattleDes:setSize(50, 50)
        switchBattleDes:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        switchBattleDes:addEventListener(UIEvent.BUTTON_CLICK, self, self.showLogLayer)
        self:addChild(switchBattleDes)

        local detailAnimation = UI.Animation:create()
        detailAnimation: init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
        detailAnimation:setAnimation("idle", true)
        detailAnimation:center()
        switchBattleDes:addChild(detailAnimation, 10)
    end

    self:initInfoView()
    self:onHorcurxEnergeUpdate()
end

-- function GroupMonsterPanel:update(dt)

-- end

function GroupMonsterPanel:initInfoView()
    self:addMonsterInfoView(self._data)
    -- self:createGroupInfoLayer()
    self:addSwitchBtn()
    self:updateSwitchBtnShow()
end

function GroupMonsterPanel:addMonsterInfoView(data)
    local pMonsterCell = UI.MonsterPanelCell:create()
    pMonsterCell:init(data) 
    pMonsterCell:centerUp(10)
    pMonsterCell:setName("MonsterPanel")
    self._pMonsterCell = pMonsterCell
    -- pMonsterCell:centerBottom(MONSTER_PANEL_BOTTOM)
    self:addChild(pMonsterCell,UI_ZORDER.MONSTER)

    self:addHeadLayer()
end

function GroupMonsterPanel:addSwitchBtn()
    local switchBtnClose = UI.Button:create()
    switchBtnClose:init("ui_reincarnation_fight_arrow.png", "ui_reincarnation_fight_arrow.png")
    -- local w, h = switchBtnClose:getSize()
    switchBtnClose:centerBottom(0)
    switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    self.info_back:addChild(switchBtnClose, 20)
    switchBtnClose:closeClickScale()
    self.switchBtnClose = switchBtnClose
    self.switchBtnClose:hide()
    -- switchBtnClose:rotate(180)

    local switchBtnOpen = UI.Button:create()
    switchBtnOpen:init("ui_reincarnation_fight_arrow.png", "ui_reincarnation_fight_arrow.png")
    -- local w, h = switchBtnOpen:getSize()
    switchBtnOpen:centerBottom(0)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    self.info_back:addChild(switchBtnOpen, 20)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    switchBtnOpen:rotate(180)
    self.switchBtnOpen:hide()
end

-- function GroupMonsterPanel:createGroupInfoLayer(layout)
--     local height = 89-CELL_HEIGHT+#self.targetList*CELL_HEIGHT
--     print("createGroupInfoLayer1:", height)
--     self.groupInfoTableView = UI.TableView.new({}, CELL_WIDTH, height)
--     self.groupInfoTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
--     self.groupInfoTableView:centerUp(35)
--     self.groupInfoTableView:enableDebugDraw()
--     self.groupInfoTableView:setDelegate()
--     self.groupInfoTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
--     self.groupInfoTableView:setBounceable(false)
--     self.groupInfoTableView:init()
--     self.groupInfoTableView:onUpdateCellSize(function (table,idx)
--         return CELL_WIDTH, CELL_HEIGHT
--     end)

--     self.groupInfoTableView:onUpdateCells(function (table, idx)
--         local cell = table:dequeueCell()
--         local index = idx + 1
--         if not cell then
--             xpcall(function()
--                 cell = self:createGroupInfoCell(index, self.targetList)
--             end,
--             function(e)
--                 printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
--             end, 1)
--         else
--             local monsterCell = cell:getChildByName("monsterCell")
--             if monsterCell and tolua.isnull(monsterCell) then
--                 monsterCell:removeFromParent()
--                 monsterCell = nil
--             end
--             cell = self:createGroupInfoCell(index, self.targetList)
--         end

--         return cell
--     end)

--     self.groupInfoTableView:onUpdateCellNumbers(function ()
--         return #self.targetList
--     end)

--     self:addChild(self.groupInfoTableView, 10)
--     self.groupInfoTableView:reloadData(true)
-- end

function GroupMonsterPanel:createGroupInfoLayerNew(data)
    -- 弹出页面
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(420, 108)
    contentLayout:centerUp(60)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    for k, v in pairs(self.targetList) do
        local data = v:getData()
        if data then
            data.targetID = self._data.spriteID
            local pMonsterCell = UI.MonsterPanelCell:create(true)
            pMonsterCell:init(data) 
            pMonsterCell:centerUp(-37+CELL_HEIGHT*(k-1))
            pMonsterCell:setName("monsterCell")
            self.contentLayout:addChild(pMonsterCell,UI_ZORDER.MONSTER-k)
            pMonsterCell:addHead()
        end
    end
end

-- function GroupMonsterPanel:createGroupInfoCell(index, data)
--     local cell = UI.TableViewCell:create()
--     cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

--     local pMonsterCell = UI.MonsterPanelCell:create()
--     pMonsterCell:init(data[index]:getData()) 
--     pMonsterCell:centerUp(-42)
--     pMonsterCell:setName("monsterCell")
--     self._pMonsterPanel = pMonsterCell
--     -- pMonsterCell:centerBottom(MONSTER_PANEL_BOTTOM)
--     cell:addChild(pMonsterCell,UI_ZORDER.MONSTER)

--     return cell
-- end

function GroupMonsterPanel:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        -- local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerBottom(0)

        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        -- local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerBottom(0)

        self.switchBtnClose:hide()
        self.switchBtnOpen:show()
    end
end

function GroupMonsterPanel:switchClick()
    if self.switchBtnState == 1 then
        self.switchBtnState = 0

        self:changeInfoBg(false)
        self:updateSwitchBtnShow()

    else 
        self.switchBtnState = 1
        self:changeInfoBg(true)
        self:updateSwitchBtnShow()
    end
    
end

function GroupMonsterPanel:changeInfoBg(open)
    if open then
        local height = 120-CELL_HEIGHT+#self.targetList*CELL_HEIGHT
        self.info_back:setSize(420, height)

        if self._pMonsterCell and not tolua.isnull(self._pMonsterCell) then
            self._pMonsterCell:removeFromParent(true)
            self._pMonsterCell = nil
        end

        if self.headLayout and not tolua.isnull(self.headLayout) then
            self.headLayout:removeFromParent(true)
            self.headLayout = nil
        end

        self:createGroupInfoLayerNew()
    else
        self.info_back:setSize(372, 168)

        if self.contentLayout and not tolua.isnull(self.contentLayout) then
            self.contentLayout:removeFromParent(true)
            self.contentLayout = nil
        end

        self:addMonsterInfoView(self._data)
    end
    
end

function GroupMonsterPanel:onSwitchBattleChangeMonsterInfo(data)
    self._data = data
    if self.switchBtnState == 0 and self._pMonsterCell and not tolua.isnull(self._pMonsterCell) then
        self._pMonsterCell:removeFromParent(true)
        self._pMonsterCell = nil
        -- self._data = data
        self:addMonsterInfoView(data)

        local roteName  = self._data and self._data:getName() or "*未知*"
        self._monstername:setText(roteName)

    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_TARGET, data:getSpriteID())
end


function GroupMonsterPanel:setLastSwitchTime(time)
    self.lastSwitchTime = time
end

function GroupMonsterPanel:addHeadLayer()

    if self.headLayout and not tolua.isnull(self.headLayout) then
        self.headLayout:removeFromParent(true)
        self.headLayout = nil
    end

    local headLayout = UI.Layout:create()
    headLayout:init()
    headLayout:setSize(370, 50)
    headLayout:centerUp(110)
    self:addChild(headLayout)
    self.headLayout = headLayout
    local contentW = 85
    self.headList = {}
    for k, v in pairs(self.targetList) do
        if v:getData() then
            local headSwitchLayout = UI.Layout:create()
            headSwitchLayout:init()
            headSwitchLayout:setSize(52, 54)
            headSwitchLayout:centerLeft(15+(k-1)*contentW, 15)
            headLayout:addChild(headSwitchLayout)
            -- headSwitchLayout:enableDebugDraw()

            local monsterData = v:getData()
            local head = monsterData:getIcon()..".png"
            local monsterHead = UI.Image:create()
            monsterHead:init(head)
            -- monsterHead:centerLeft(5+(k-1)*contentW, 0)
            monsterHead:center(0, 0)
            headSwitchLayout:addChild(monsterHead)
            monsterHead:setScale(0.8)

            local monsterHeadBg = UI.Image:create()
            monsterHeadBg:init("ui_reincarnation_headbox.png")
            -- monsterHeadBg:centerLeft(15+(k-1)*contentW, 0)
            monsterHeadBg:center(-2, 0)
            headSwitchLayout:addChild(monsterHeadBg)
            monsterHeadBg:setTag(v:getSpriteID())
            -- monsterHeadBg.tag = v:getSpriteID()

            local battleSign = UI.Image:create()
            battleSign:init("ui_reincarnation_fight_fightting.png")
            battleSign:leftUp(-5, -5)
            battleSign:setName("battleSign")
            monsterHeadBg:addChild(battleSign)

            headSwitchLayout:setTouchEnable(true)
            headSwitchLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self)
                self:onSwitch(v)
            end)

            table.insert(self.headList, monsterHeadBg)
        end
        
    end
    self:updateHeadLayer()
end

function GroupMonsterPanel:updateHeadLayer()
    if self.switchBtnState == 0 then
        for k, v in pairs(self.headList) do
            local battleSign = v:getChildByName("battleSign")
            if battleSign then
                battleSign:setVisible(v:getTag() == self._data:getSpriteID())
            end
        end
    end
end

function GroupMonsterPanel:onSwitch(data)
    local spriteID = data:getSpriteID()
    if self._data.spriteID == spriteID then
        -- UI.ScrollBar:createByText(UI.TEXT_223812)
        return
    end

    if data:getIsDead() then
        -- UI.ScrollBar:createByText(UI.TEXT_223812)
        return
    end

    local str = ConfigManager:getGeneralForKey("switchAttackInterval")
    local switchAttackInterval = tonumber(str) / 1000
    local nowTime = GameManager:getNormalServerTime()
    print("onSwitch2323:", self.lastSwitchTime, nowTime,switchAttackInterval, nowTime - self.lastSwitchTime  )
    if self.lastSwitchTime > 0 then
        local nowTime = GameManager:getNormalServerTime()
        local remainTime = nowTime - self.lastSwitchTime 
        if remainTime <= switchAttackInterval then
            local tips = string.format(UI.TEXT_223813, switchAttackInterval)
            UI.ScrollBar:createByText(tips)
            return
        end
    end

    Net.NetRoleSystem:reqRoleSwitchBattleTartMessage(spriteID)
end

function GroupMonsterPanel:onHorcurxEnergeUpdate(data)

end


local pngs ={"ui_gaming_monste_energy_00.png", "ui_gaming_monste_energy_10.png", "ui_gaming_monste_energy_max_2.png"}
--怪物能量条
function GroupMonsterPanel:updateMonsterEnergyView()
    local percent = (self._data.energy or 0)/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE

    if percent <= 0 then
        if self.energyNode then
            self.energyNode:removeFromParent()
            self.energyNode = nil
            self.fullEnergy = nil
        end
        return
    end

    if not self.energyNode then
            -- 怪物血条背景
        self.energyNode = cc.Sprite:createWithSpriteFrameName(pngs[1])
        local px =  self:getContentSize().width / 2  - 12 
        local py =  self:getContentSize().height - 83 - self.energyNode:getContentSize().height/2
        self.energyNode:setAnchorPoint(cc.p(1,0.5))
        self.energyNode:setPosition(cc.p(px,py))
        self:addChild(self.energyNode,1)

        local width = self.energyNode:getContentSize().width
        local height = self.energyNode:getContentSize().height

        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(pngs[2]))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)  
        progress:setMidpoint(cc.p(0,0))  
        progress:setBarChangeRate(cc.p(1, 0))  
        progress:setPosition(cc.p(width/2, height / 2))  
        self.energyNode:addChild(progress)  
        self.energyProgress = progress
    end
    self.energyProgress:setPercentage(percent*100)
    if percent >= 1 then
        if not self.fullEnergy then
            self.fullEnergy = UI.Image:create()
            self.fullEnergy:init(pngs[3])
            self.fullEnergy:center()
            self.energyNode:addChild(self.fullEnergy,3)
        end
    else
        if self.fullEnergy then
            self.fullEnergy:removeFromParent()
            self.fullEnergy = nil
        end
    end
end

-- 更新视图:
-- function GroupMonsterPanel:onUpdateView(data)
--     -- print("GroupMonsterPanel:updateView")
--     if (data) then 
--         self._data = data
--     end
--     data = self._data

--     if data then 
--         local hpNum = data and data.curHp or 0
--         if hpNum < 0 then
--             hpNum = 0
--         end 

--         local hpMax = data and data.hp or 1

--         -- 判断是否为公会副本模式
--         local guildBoss = SceneManager:getInstance():isGuildBoss() 
--         if(guildBoss) then 
--             local curHp = hpNum
--             local maxHp = hpMax
--             local guildBossPool = ConfigManager:getGuildBossPoolByID(data:getId())

--             local multiHP = {1500,2388}
--             if(guildBossPool) then 
--                 multiHP = guildBossPool.multiHP
--             end

--             self.boxImage:setVisible(true)
--             self.hpLayerText:setVisible(true)
--             local mulHpArr,index, indexHp = ToolsUtil:calculationMulHp(curHp, maxHp, multiHP)
--             -- print("progressBg, progress, reward  1=", index, indexHp)
--             local progressBg, progress, reward , progressPercent = self:_getHPSpriteName(index, mulHpArr)
--             -- print("progressBg, progress, reward, progressPercent=", progressBg, progress, reward, progressPercent)
--             if(self.preSpriteName ~= reward) then
--                 print("self.preSpriteName=", self.preSpriteName, reward)
--                 self.preSpriteName = reward
--                 self.boxImage:setSpriteName(reward)
--                 self.boxImage:stopAllActions()
--                 self.boxImage:setScale(0.9)
--                 self.boxImage:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.3), cc.ScaleTo:create(0.5, 0.6)))
--             end 
            
--             self._monsterhp_1:setSpriteName(progressBg, progress, progressPercent)
--             -- self.progressText:setText(string.format("%d/%d", indexHp, mulHpArr[index]))
--             hpNum = indexHp
--             hpMax = mulHpArr[index]
--             if(curHp == 0) then
--                 self.hpLayerText:setText("X ".."0")
--             else
--                 self.hpLayerText:setText("X "..(#mulHpArr-index + 1))
--             end
            
--             -- local oldPercent = self.progressTimer:getPercent()
--             -- local nowPercent = indexHp/ mulHpArr[index]
--             -- self.progressTimer:setBarChange(oldPercent, nowPercent, 1000)
--             -- self.progressTimer:setBarChangeAction(oldPercent, nowPercent, 1000)
--         else 
--             self.boxImage:setVisible(false)
--             self.hpLayerText:setVisible(false)
--         end
        
--         local hpNumStr = ""
--         -- 英雄血量显示方式
--         local _showType = Game.Manager:getRoleInfoShowType() 
--         if _showType == ShowType.PERCENT then
--             local  HP  = math.floor(hpNum/hpMax*100)

--             if HP == 0 and hpNum ~= 0 then
--                 HP = 1
--             end
--             hpNumStr = HP.."%"
--         elseif _showType == ShowType.VALUE then
--             hpNumStr = hpNum.."/"..hpMax
--         end

--         self._monsterhpNum:setText(hpNumStr)

--         -- 怪物血条
--         local scale = hpNum/hpMax

--         -- 设置真实的血量
--         -- if(self._lastScale < scale) then 
--         --     self._lastScale = 1
--         -- end

--         self._monsterhp_1:setBarChange(self._lastScale, scale, 0)
--         self._monsterhp_1:setBarChangeAction(self._lastScale, scale, 600)

--         -- 记录本次的血量
--         self._lastScale = scale
--     end

--     -- 通过MonsterData:getAllAffixArr()  获取词缀（MonsterAffixData）列表  ,在通过  MonsterAffixData:getAffixName() 获取词缀名
--     local arr = data:getAllAffixArr()
--     local text = ""
--     for i = 1, #arr do
--         -- arr[i]:getAffixName()
--         print("==",arr[i]:getAffixName())
--         if i <= 4 then 
--             text = string.format("%s %s", text, arr[i]:getAffixName())
--         end
--     end
--     self._buffAffix:setText(text)

--     local weakness = data and data.weaknessType or 0
--     if weakness == 1 then
--         weakness = "fire"
--     elseif weakness == 2 then
--         weakness = "water"
--     elseif weakness == 3  then
--         weakness = "wood"
--     elseif weakness == 0 then
--         weakness = ""
--     elseif weakness == 4 then
--         weakness = "light"
--     elseif weakness == 5 then
--         weakness = "dark"
--     end

--     if self._weaknessSp then
--         self._weaknessSp:removeFromParent()
--         self._weaknessSp = nil
--     end

--     if weakness ~= "" then
--         local fileName = string.format(MONSTER_PANEL_SPRITE_FRAME_MAP.WEEKPOINT_VALUE,weakness)
--         self._weaknessSp = UI.Image:create()
--         self._weaknessSp:init(fileName)
--     else
--         self._weaknessSp = UI.Text:create()
--         self._weaknessSp:init("--", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
--     end
--     self._weaknessSp:centerLeft(self._weak:getContentSize().width + 4)
--     self._weak:addChild(self._weaknessSp)
--     -- 更新血条
--     self:updateHpTitle()


--     self:updateMonsterEnergyView()
-- end

function GroupMonsterPanel:scheduleDesertEyesBossProgressCd()
    if tolua.isnull(self) 
        or (not self.desertEyesBossBuffCdText) 
        or tolua.isnull(self.desertEyesBossBuffCdText) 
    then
        return
    end

    if (not self.desertEyesBossBuffCdText.cd)
        or  self.desertEyesBossBuffCdText.cd <= 0 
    then
        self.desertEyesBossBuffCdText:removeFromParent()
        return
    end 

    if self.desertEyesBossBuffCdText.cd > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleDesertEyesBossProgressCd, 1)
    end
    self.desertEyesBossBuffCdText:setText(
        string.format(UIUtil:lang(1043480), self.desertEyesBossBuffCdText.cd)
    )
    self.desertEyesBossBuffCdText.cd = self.desertEyesBossBuffCdText.cd - 1
end

function GroupMonsterPanel:showDesertEyeBossProgress(buffer, isAdd)
    if not (SceneManager:getInstance():isDesertEyesCave() 
            or SceneManager:getInstance():isDistortedSpaceCave()
            or SceneManager:getInstance():isInInferno()
            or SceneManager:getInstance():isInVoidRift()
            or SceneManager:getInstance():isInViKing() 
            or SceneManager:getInstance():isTitanRoad()
            or SceneManager:getInstance():isDriedSpring()
            or SceneManager:getInstance():isChaosWormHole() ) then
        return
    end

    if SceneManager:getInstance():getSceneType() == PublicDefine.SCENE_TYPE.CAVE then
        return
    end

    if(self.desertEyesBossBuffLayer and isAdd == true) then
        self.desertEyesBossBuffLayer:removeFromParent()
        self.desertEyesBossBuffLayer = nil
    end


    if not self.desertEyesBossBuffLayer then
        self.desertEyesBossBuffLayer = UI.Component:create()
        self.desertEyesBossBuffLayer:init()
        self.desertEyesBossBuffLayer:setSize(10,10)
        self.desertEyesBossBuffLayer:centerUp(130)
        self:addChild(self.desertEyesBossBuffLayer)

        local shalou = UI.Animation:create()
        shalou:init("effect_ui_gaming_warning_shalou.json", "effect_ui_gaming_warning_shalou.atlas", 1, true)
        shalou:setAnimation("idle", true)
        if(SceneManager:getInstance():isDistortedSpaceCave()) then 
            shalou:setAnimation("idle2", true)
        end
        shalou:leftBottom(-145, 0)
        self.desertEyesBossBuffLayer:addChild(shalou,199)
        
        local progressBg = UI.Image:create()
        progressBg:init("ui_gaming_warning_00.png")
        progressBg:center(-4,5)
        self.desertEyesBossBuffLayer:addChild(progressBg)

        local percent = buffer:getDuration()
        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_gaming_warning_10.png"))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        progress:setMidpoint(cc.p(0, 0))
        progress:setBarChangeRate(cc.p(1, 0))
        progress:setPercentage(0)
        self.desertEyesBossBuffLayer:addChild(progress)
        local text = UI.Text:create()
        text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_220_211_203)
        text:center(0,5)
        text:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        self.desertEyesBossBuffLayer:addChild(text, 10)
        self.desertEyesBossBuffCdText = text
        self.desertEyesBossBuffCdText.cd = math.floor(percent)
        self:scheduleDesertEyesBossProgressCd()
        self._salouProgress = progress
        self.yujingAniCountDown = 0
    end

    local percent = buffer:getDuration()
    local progress = self._salouProgress
    progress:stopAllActions()

    local oldCd = self.desertEyesBossBuffCdText.cd or 0
    self.desertEyesBossBuffCdText.cd = math.floor(percent)
    if oldCd <=0 and self.desertEyesBossBuffCdText.cd > 0 then
        self:scheduleDesertEyesBossProgressCd()
    end

    local action = cc.ProgressTo:create(percent, 100) 
    progress:runAction(
        cc.Sequence:create(
            action, 
            cc.CallFunc:create(
                function() 
                    if(self.desertEyesBossBuffLayer) then
                        local yujing = UI.Animation:create()
                        yujing:init("effect_ui_gaming_warning_yujing.json", "effect_ui_gaming_warning_yujing.atlas", 1, true)
                        yujing:setAnimation("idle", true)
                        yujing:center(-4,6)
                        self.desertEyesBossBuffLayer:addChild(yujing)
                        yujing:addEventListener(UIEvent.ANIMATION_COMPLETE, self, 
                            function() 
                                if self.yujingAniCountDown > 5 then
                                    yujing:runAction(
                                        cc.CallFunc:create(
                                            function()
                                                self.desertEyesBossBuffLayer:removeFromParent()
                                                self.desertEyesBossBuffLayer = nil
                                            end
                                        )
                                    )
                                end
                                self.yujingAniCountDown = self.yujingAniCountDown + 1
                            end
                        ) 
                    end
                end
            )
        )
    )
end

-- 添加吟唱的滑条
function GroupMonsterPanel:addChantTimer(data, isMaster)
    if(not isMaster) then 
        return 
    end
    -- print("GroupMonsterPanel:addChantTimer", GameManager:getNowServerTimestamp())
    -- print(debug.traceback())
    if data and self._chantTimer then 
      
        local id = data.skillID
        local time = data.duration
        -- 延时时间
        local timeSpaced = GameManager:getNowServerTimestamp() - data.timeStamp
        local percent =  timeSpaced/time
        local leftTime = time - timeSpaced
        -- print("====chantTimer percent",percent)
        self._chantTimer:show()
        self._chantTimer:setBarChangeAction(percent,1,leftTime)
    end
end

-- 移除吟唱的滑条
function GroupMonsterPanel:hideChantTimer()
    -- print("GroupMonsterPanel:hideChantTimer", GameManager:getNowServerTimestamp())
    if self._chantTimer then 
        self._chantTimer:stopAllActions()
        self._chantTimer:hide()
    end
end

-- 添加引导的滑条
function GroupMonsterPanel:addGuideTimer(time)
    -- print("GroupMonsterPanel:addGuideTimer", GameManager:getNowServerTimestamp(), time)
    if time and self._guideTimer then 
        self._guideTimer:show()
        self._guideTimer:setBarChangeAction(1,0,time*1000)

        local function CallFucnCallback()
            self._guideTimer:hide()
        end
        if(self._guideTimer and self._guideTimer._truetimer) then
            local tag = 11101
            self._guideTimer._truetimer:stopAllActionsByTag(tag)
            local seqAction = cc.Sequence:create(cc.DelayTime:create(time),cc.CallFunc:create(CallFucnCallback))
            seqAction:setTag(tag)
            self._guideTimer._truetimer:runAction(seqAction)
        end
    end
end

-- 移除引导的滑条
function GroupMonsterPanel:hideGuideTimer()
    -- print("GroupMonsterPanel:hideGuideTimer", GameManager:getNowServerTimestamp())
    if self._guideTimer then 
        self._guideTimer:stopAllActions()
        self._guideTimer:hide()
    end
end

-- 技能使用
function GroupMonsterPanel:onSkillEndSingHandler(data, isMaster)
    if(not isMaster) then 
        return 
    end

    self:hideChantTimer()

    local hasGuide = data:hasGuide()
    local skillID = data:getId()
    self._guideID = skillID

    if hasGuide then
        -- print("====Has Guide")
        local time = data:getCastDuration()
        self:addGuideTimer(time)
    end
end


-- 技能被中断隐藏引导滑条
function GroupMonsterPanel:onSkillBreakHandler(skillID, skillState, isMaster)
    if(not isMaster) then 
        return 
    end

    -- if skillID and skillID == self._guideID then 
    --     self:hideGuideTimer()
    -- end
    self:hideChantTimer()
    self:hideGuideTimer()
end

--怪物，页面的更新
function GroupMonsterPanel:onUpdateRoleDataHandler(roleData)
    -- print("====GroupMonsterPanel:onUpdateRoleDataHandler==== roleData updateView", roleData.spriteID)
    -- 怪物
    if self._data.spriteID == roleData.spriteID then
        self:updateView(roleData)
    end
end

function GroupMonsterPanel:onUseSkill(data, isMaster)
    if(not isMaster) then 
        return
    end
    self:hideGuideTimer()
end

function GroupMonsterPanel:onEscapeClick(sender, isRecover)
    local heroData = GameDataManager:getInstance():getMaster()
    if(heroData and heroData:judgeEscape() == false) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170129))
        return
    end 

    local escapeTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.ESCAPE_SP_3))
    escapeTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    -- escapeTimer:setPercentage(0)
    escapeTimer:setVisible(false)
    self:addChild(escapeTimer,2)
    -- 按钮设置为不可用 
    if(self._escapeItem and not tolua.isnull(self._escapeItem)) then
        self._escapeItem:unregisterScriptTapHandler()
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_DISABLE_ITEM_PANEL)     -- 禁用快捷栏
    Avalon.MessageCenter:notice(GameMessage.MC_UI_DISABLE_SKILL_PANEL)    -- 禁用技能栏

    local time = ConfigManager:getGeneralEscapeTime()
    -- 进度条
    local to1 = cc.ProgressTo:create(time/1000, 0)
    escapeTimer:setVisible(true)
    escapeTimer:setPercentage(100)
    escapeTimer:setMidpoint(cc.p(0, 0))
    escapeTimer:setBarChangeRate(cc.p(1, 0))
    escapeTimer:setPosition(cc.p(self._escapeX, self._escapeY))
    escapeTimer:runAction(cc.Sequence:create(to1))

    Avalon.AudioManager:playSound("1503")

    self._escapeTimer = escapeTimer

    -- print(" GroupMonsterPanel:onEscapeClick=", isRecover, heroData.residualEscapeTime, time)
    if(isRecover and heroData.residualEscapeTime) then
        -- 恢复进度条
        escapeTimer:setPercentage(heroData.residualEscapeTime / time * 100)
    else 
        GameManager:leaveBattleHandler()
    end

    -- print("onEscapeClick")
    -- Avalon.Scheduler:scheduleUpdateOnce(self, function() 
    --     self:onEscapeFailed()
    -- end, 0.5)
end

function GroupMonsterPanel:onEscapeFailed(data)
    if(self._escapeItem and not tolua.isnull(self._escapeItem)) then
        if(self._escapeTimer and not tolua.isnull(self._escapeTimer)) then
            self._escapeTimer:removeFromParent()
            self._escapeTimer = nil
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_ENABLE_ITEM_PANEL)     -- 启用快捷栏
        Avalon.MessageCenter:notice(GameMessage.MC_UI_ENABLE_SKILL_PANEL)    -- 启用技能栏

        self._escapeItem:registerScriptTapHandler(function(sender)
            self:onEscapeClick(sender, false)
        end)
    end
end

function GroupMonsterPanel:_getHPSpriteName(index, mulHpArr)
    local maxIndex = 4
    local progressBg = nil
    local progress = "ui_battle_monsterhp_12.png"
    local progressPercent = "ui_battle_monsterhp_11.png"
    local reward = "ui_guild_giftbag_icon_6.png"
    local mod = math.fmod(index, maxIndex + 1)
    if(mod == 0) then 
        mod = 1
    end
    print("GroupMonsterPanel:_getHPSpriteName", mod, index, #mulHpArr)
    progress = string.format("ui_battle_monsterhp_%d0.png", mod)
    progressPercent = string.format("ui_battle_monsterhp_%d1.png", mod)
    reward =  string.format("ui_guild_giftbag_icon_%d.png", 5+mod)
    if(index == #mulHpArr) then 
        progressBg = "ui_battle_monsterhp_12.png"
    else
        if(mod == maxIndex) then 
            progressBg = string.format("ui_battle_monsterhp_%d0.png", 1)
        else 
            progressBg = string.format("ui_battle_monsterhp_%d0.png", mod + 1)
        end
    end

    return progressBg, progress, reward, progressPercent
end

function GroupMonsterPanel:triggerMonsterRefresh(model)
    if(model and model:getRoleData() and model:getRoleData():getSpriteID() == self._data.spriteID) then 
        self.monstername:setText(model:getRoleData():getName())
    end
end

function GroupMonsterPanel:onShowEscape(isHide)
    if self.escapeMenu == nil then
        return
    end
    if isHide then
        self.escapeMenu:setVisible(false)
        self.escapeLabel:setVisible(false)
    else
        local SceneManager = require("app.game.SceneManager")
        if not SceneManager:getInstance():isInStory() then
            self.escapeMenu:setVisible(true)
            self.escapeLabel:setVisible(true)
        end
    end

    
end

function GroupMonsterPanel:scenePauseOrResume(isPause)
    print("---GroupMonsterPanel:scenePauseOrResume---", isPause)
    local timerArr = {}
    if(self._monsterhp_1) then 
        table.insert(timerArr, self._monsterhp_1)
    end
    if(self._chantTimer) then 
        table.insert(timerArr, self._chantTimer)
    end
    if(self._guideTimer) then 
        table.insert(timerArr, self._guideTimer)
    end
    if(self.energyProgress) then 
        table.insert(timerArr, self.energyProgress)
    end

    for k,v in ipairs(timerArr) do 
        if(not tolua.isnull(v)) then 
            if(isPause) then
                v:pause()
            else
                v:resume()
            end
        end
    end

    self.isPause = isPause
    if(self._debufftable) then 
        for k, v in pairs(self._debufftable) do 
            self:_hanelTimePauseOrResume(v.Timer, v.data, isPause)
            self:_hanelTimePauseOrResume(v.Timer2, v.data, isPause)
        end
    end

    if(self._bufftable) then 
        for k, v in pairs(self._bufftable) do 
            self:_hanelTimePauseOrResume(v.Timer, v.data, isPause)
            self:_hanelTimePauseOrResume(v.Timer2, v.data, isPause)
        end
    end
end

function GroupMonsterPanel:_hanelTimePauseOrResume(timer, data, isPause)
    if(not tolua.isnull(timer)) then 
        if(not tolua.isnull(timer)) then 
            if(isPause) then 
                timer:pause()
            else
                timer:resume()
            end
        end
    end
end

function GroupMonsterPanel:showLogLayer(text)
    local data = {
        title = UI.TEXT_223816,
        tips = UI.TEXT_223817,
        bg = "ui_reincarnation_fight_box3.png"
    }
    local logLayer = UI.GroupBattleLogView:create(data)
    logLayer:init()
    logLayer:centerUp(55, 380)
    logLayer:setName("logLayer")
    self:addChild(logLayer, 500)
end

function GroupMonsterPanel:removeDeadTarget(targetID)
    for k, v in pairs(self.targetList) do
        if v:getData() then
            if v.spriteID == targetID then
                table.remove(self.targetList, k)
            end
        end
        
    end
end











