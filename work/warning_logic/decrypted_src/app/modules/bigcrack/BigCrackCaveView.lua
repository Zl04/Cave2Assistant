------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigCrackCaveView = class("BigCrackCaveView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

-- 资源
local COM_RES_LIST = {
    "ui_gaming_battle.plist",
    "ui_general_task.plist",
    "ui_town_bigcrack.plist",
    
}

local winSize = cc.Director:getInstance():getWinSize()
local SCROLLCONTENT_WIDTH = 230

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
function BigCrackCaveView:ctor()
    local margin = Avalon.issUtil:getLeftMargin()
    BigCrackCaveView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH - 2 * margin, COM_HEIGHT)
    self:bindModel()
    self:center()
    -- self:enableDebugDraw()
    self.mCampNode = {}

end

function BigCrackCaveView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigcrack", "BigCrack", false)
    BigCrackCaveView.super.init(self, ...)
end

function BigCrackCaveView:dtor()
    BigCrackCaveView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigcrack.BigCrackCaveView")
end

function BigCrackCaveView:hideCollection()
    if self.collectPgs then
        self.collectPgs:removeFromParent()
        self.collectPgs = nil
        return true
    end
    return false
end

function BigCrackCaveView:doCollectFailure()
    if self.collectPgs then
        self.timer:stopAllActions()

        -- local drawText = UI.Text:create()
        -- drawText:init(UI.TEXT_1213443, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
        -- drawText:center()
        -- drawText:center(0, 25)
        -- self.collectPgs:addChild(drawText)
        self.collectDesTxt:setText(UI.TEXT_1213444)
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, 
            function () 
                if tolua.isnull(self) then
                    return
                end
                self:hideCollection()
            end
        , 3)
    end
end

function BigCrackCaveView:showCollection(time)
    if not time or time < 0 then
        return
    end
    if self.collectPgs then
        self.collectPgs:removeFromParent()
    end
    local pgsCom = UI.Component:create()
    pgsCom:init()
    pgsCom:setSize(10, 20)
    pgsCom:center(0, 100)
    -- pgsCom:enableDebugDraw()
    self:addChild(pgsCom)
    self.collectPgs = pgsCom

    local bg = UI.Image:create()
    bg:init("ui_bigcrack_collection02.png")
    bg:centerBottom(0)
    pgsCom:addChild(bg, 1)

    local drawText = UI.Text:create()
    drawText:init(UI.TEXT_1213443, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    drawText:center(0, 25)
    self.collectDesTxt = drawText
    self.collectPgs:addChild(drawText, 10)

    local escapeTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_bigcrack_collection01.png"))
    escapeTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    escapeTimer:setPercentage(0)
    escapeTimer:setPosition(cc.p(102,10))
    bg:addChild(escapeTimer, 2)
    self.timer = escapeTimer

    -- 进度条
    local to1 = cc.ProgressTo:create(time, 100)
    escapeTimer:setMidpoint(cc.p(0, 0))
    escapeTimer:setBarChangeRate(cc.p(1, 0))
    escapeTimer:runAction(
        cc.Sequence:create(
            to1,
            cc.CallFunc:create(function()
                self:hideCollection()
                mvc.send(mvc.events.COLLECT_END)
            end)
        )
    )
end


function BigCrackCaveView:clickCallback(data)
    print("click call back", data.pk)
end


function BigCrackCaveView:onActiveTabHandler(tabIndex, lastTabIndex, tabItem)
    tabItem:setFontColor(UI.FONT_COLOR_41_41_45, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
    local lastTabItem = self._tabList._compList[lastTabIndex]
    if lastTabItem then
        lastTabItem:setFontColor({r = 186,  g = 186,  b = 186}, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
    end

    self.scrollContent:removeChildren()
    self.scrollContent:clearComponentList()
    if tabIndex == 1 then
        self:showTeam()
    else
        self:showBoss()
    end
end

function BigCrackCaveView:showTeam()
    self:updateTeamList()
    -- self.scrollView:enableScrolling()
end

function BigCrackCaveView:showBoss()
    self.mCampNode = {}
    self:updateBossList()
    -- self.scrollView:scrollToTop()
    -- self.scrollView:disableScrolling()
end


function BigCrackCaveView:onInitView()
    local bg = cc.LayerColor:create(cc.c4b(0,0,0,153))
    bg:setIgnoreAnchorPointForPosition(false)
    bg:setAnchorPoint(cc.p(0.5,0.5))
    bg:setPosition(230 / 2, self:getContentSize().height / 2)
    bg:setContentSize(230, 264)
    self:addChild(bg,1)
    self.contentLayer = bg
    

    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:setSize(SCROLLCONTENT_WIDTH, 0)
    scrollContent:enableAutoHeight()
    scrollContent:leftUp(3, 40)
    self.scrollContent = scrollContent

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(SCROLLCONTENT_WIDTH, 210)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(0, 40)
    scrollView:setScrollBarEnabled(false)
    scrollView:setCircleVisible(false)
    self.contentLayer:addChild(scrollView)
    self.scrollView = scrollView

    scrollView:addInnerNode(scrollContent)


    -- tab控件
    local tabList = UI.TabList:create()
    tabList:init(3, 114, 64)
    tabList:leftUp(0, 0)
    tabList:setReverseOrder(true)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.HORIZONTAL, LayoutFloatType.FLOAT_RIGHT)
    for k, textStr in ipairs({UI.TEXT_1213435, UI.TEXT_1213436}) do
        local tab = UI.FunctionTabItem:create()
        tab:init(
            "ui_task_button_0.png",
            "ui_task_button_1.png",
            "ui_task_button_2.png",
            textStr,
            UI.FONT_BOLD,
            UI.FONT_SIZE_20PX
        )
        tab.disable=function(tab)
            tab.super.disable(tab)
        end
        tab._tabText:setMaxLineWidth(90)
        tab._tabText:setFixLineWidth(90)
        tabList:addToTab(tab, k)
        tab:setFontColor({r = 186,  g = 186,  b = 186}, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        tab.onDisableClick = function() 
            UI.ScrollBar:createByText(UIUtil:lang(1112891))
        end
    end
    tabList:setDefaultIndex(2)
    self._tabList = tabList

    self.contentLayer:addChild(tabList)

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
    local w1, h = switchBtnOpen:getSize()
    switchBtnOpen:centerRight(-w1)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    self.contentLayer:addChild(switchBtnOpen)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    self.switchBtnOpen:show()

     -- 展开或缩进
     local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
     local unfoldState = userData:getQuickSideBarUnfold()
     if unfoldState then
         self.switchBtnState = 1
     else
         self.switchBtnState = 0
     end
 
     self:updateSwitchBtnShow()
     local boss = mvc.bigCrackModel:getbossInfos(mvc.bigCrackModel:getCampId())
     
     if boss and boss.x and boss.y then
        require "app.command.ControlCommand"
        local data = {
            heroData = RoleDataManager:getMaster(),
            isShow = true,
            guideTitle = UI.TEXT_1213446,
            x = boss.x,
            y = boss.y
        }
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SET_GUIDE_POINTER, data)
        SceneManager:getInstance():pushCommand(command)
    end
end


function BigCrackCaveView:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerRight(-w)
        self.contentLayer:setPosition(230 / 2, self:getContentSize().height / 2)

        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerRight(-w)
        self.contentLayer:setPosition(-230 / 2, self:getContentSize().height / 2)

        self.switchBtnOpen:show()
        self.switchBtnClose:hide()
    end
end

function BigCrackCaveView:switchClick()
    local userData = Avalon.UserDataManager:readUserData(Avalon.USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if self.switchBtnState == 1 then
        self.switchBtnState = 0

        self.contentLayer:stopAllActions()
        self.contentLayer:runAction(cc.Sequence:create(
            cc.MoveBy:create(0.1, cc.p(-230,0)),
            cc.CallFunc:create(function()
                self:updateSwitchBtnShow()
            end))
        )

        -- 仅当多人模式的战斗过程中不记录开关的状态
        if not (mvc.quickSideBarModel:checkHasTeam() and self.isInBattle) then
            userData:setQuickSideBarUnfold(false)
        end
    else
        self.switchBtnState = 1

        self.contentLayer:stopAllActions()
        self.contentLayer:runAction(cc.Sequence:create(
            cc.MoveBy:create(0.1, cc.p(230,0)),
            cc.CallFunc:create(function()
                self:updateSwitchBtnShow()
            end))
        )

        -- 仅当多人模式的战斗过程中不记录开关的状态
        if not (mvc.quickSideBarModel:checkHasTeam() and self.isInBattle) then
            userData:setQuickSideBarUnfold(true)
        end
    end
end

function BigCrackCaveView:showGetBuffs(buffIcon)
    
    local animation = UI.Animation:create()
    animation:init("effect_ui_bigcrack_buff_icon.json", "effect_ui_bigcrack_buff_icon.atlas", 1)
    self:addChild(animation, 102)
    animation:setAnimation("idle", false)
    animation:center(-250, -150)

    local img = UI.Image:create()
    img:init(buffIcon)
    img:center()
    animation:addComponent("box-buff", img)

    animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
        animation:runAction(cc.RemoveSelf:create())
    end)
end

function BigCrackCaveView:createOneTeammate(teamRoleData)

    local com = UI.Component:create()
    com:init()
    com:setSize(SCROLLCONTENT_WIDTH - 10, 87)
    local cell = UI.QuickSideBarTeamCell.create()
    cell:init(teamRoleData, self)
    cell.heroHand:registerRoleHandler(self, nil, nil, self.clickCallback)
    -- cell.heroHand.onTouchLongTimeBeganHandler = function(self) 
    --     self._isTouchLongTime = true
    --     local data = teamRoleData
    --     local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(teamRoleData.pk)
    --     if bufferDataList then
    --         mvc.openPanel("Common", "BuffTip", bufferDataList)
    --     end
    -- end
    -- cell.heroHand.onTouchLongTimeEndedHandler = function(self) 
    --     self._isTouchLongTime = false
    --     mvc.closePanel("Common", "BuffTip")
    -- end
    cell:leftBottom(0,-2)
    com.cell = cell
    com:addChild(cell)
   return com
end

function BigCrackCaveView:updateBossList()

    local blueView = mvc.bigCrackBossCellView:create(PublicDefine.Camp.Blue, "ui_tast_btn_3.png")
    blueView:init()
    blueView:floatUp(6)
    local redView = mvc.bigCrackBossCellView:create(PublicDefine.Camp.Red, "ui_tast_btn_2.png")
    redView:init()
    redView:floatUp(5)
    if mvc.bigCrackModel:getCampId() == PublicDefine.Camp.Blue then
        self.scrollContent:addComponent(blueView)
        self.scrollContent:addComponent(redView)
    else
        self.scrollContent:addComponent(redView)
        self.scrollContent:addComponent(blueView)
    end

    self.scrollContent:updateView()
end

function BigCrackCaveView:updateTeamList()
    local camps = mvc.bigCrackModel:getCamps()
    for pk, teamRoleData in pairs(camps) do
        if RoleDataManager:getMasterPK() ~= pk then
            local node = self:createOneTeammate(teamRoleData)
            node:floatUp(-1)
            self.mCampNode[pk] = node.cell
            self.scrollContent:addComponent(node)
        end
    end
end

function BigCrackCaveView:updateMemberList()
    -- local camps = mvc.bigCrackModel:getCamps()
    for pk, cell in pairs(self.mCampNode) do
        cell:refreshView()
    end
end

-- 英雄面板的更新
function BigCrackCaveView:onUpdateHeroDataHandler(roleData)
    -- print("HeroHandLayer:onUpdateHeroDataHandler")
    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        if self.mCampNode[_pk] then
            self.mCampNode[_pk]:refreshView(roleData)
            self.mCampNode[_pk]:refreshRescure(roleData:getRescuedDungeonSurvivorCount())
        end
    end
end

-- 添加buff
function BigCrackCaveView:onAddRoleBuffHandler(data)
    -- print("HeroHandLayer:onAddRoleBuffHandler",data.bufferTargetID,data.bufferTargetID,data.bufferEntityID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if self.mCampNode[_pk] then
                self.mCampNode[_pk]:addBuffView(data)
            end
        end
    end
end


-- 角色buff页面的更新
function BigCrackCaveView:onUpdateRoleBuffHandler(data)
    -- print("HeroHandLayer:onUpdateRoleBuffHandle", data.bufferTargetID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if self.mCampNode[_pk] then
                self.mCampNode[_pk]:updateBuffView(data)
            end
        end
    end
end

-- 移除buff
function BigCrackCaveView:onRemoveRoleBuffHandler(data)
    -- print("HeroHandLayer:onRemoveRoleBuffHandler",data.bufferTargetID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if self.mCampNode[_pk] then
                self.mCampNode[_pk]:removeBuffView(data)
            end
        end
    end
end

function BigCrackCaveView:bindModel()
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)

    -- 添加buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    -- 更新buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    -- 移除buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)

    mvc.bigCrackModel:bind("camps", self, self.updateMemberList)
end

function BigCrackCaveView:unbindModel()
     -- 英雄主角信息 显示英雄自己
     Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
     -- 角色信息更新，其他的英雄
     Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
     Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
      -- 添加buff操作，添加更新移除
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)
    if mvc and mvc.bigCrackModel then
        mvc.bigCrackModel:unbind("camps", self, self.updateMemberList)
    end
end

return BigCrackCaveView
