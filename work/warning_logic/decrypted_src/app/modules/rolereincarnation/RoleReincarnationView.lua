------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/03/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RoleReincarnationView = class("RoleReincarnationView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_reincarnation_role.plist",
}

local COM_WIDTH = 745
local COM_HEIGHT = 518
local CELL_WIDTH = 464
local CELL_HEIGHT = 36

function RoleReincarnationView:ctor()
    RoleReincarnationView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.openStat = 0
    self:bindModel()
end

function RoleReincarnationView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.rolereincarnation", "RoleReincarnation", false)
    RoleReincarnationView.super.init(self, ... )
end

function RoleReincarnationView:dtor()
    RoleReincarnationView.super.dtor(self)
    self.openStat = 0
    self:unbindModel()
    reload_script_file_mvc("app.modules.rolereincarnation.RoleReincarnationView")
end


function RoleReincarnationView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 50)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_reincarnation_role_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 背景图片
    local topBg  = UI.Image:create()
    topBg:init("ui_reincarnation_role_top.png")
    topBg:centerUp(-90)
    bg:addChild(topBg)

    local switchIcon  = UI.Image:create();
    switchIcon:init("ui_pets_show_btn_0.png");
    switchIcon:rightBottom(120, 74);
    switchIcon:setTouchEnable(true)
    contentLayout:addChild(switchIcon, 99)
    switchIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:switchClick()
    end)
    -- switchIcon:hide()
    self.switchIcon = switchIcon

    self:initRoleLayout()
    self:initDetailLayout()
end

function RoleReincarnationView:initRoleLayout()
    -- 内容面板
    local roleContentLayout = UI.Layout:create();
    roleContentLayout:init()
    roleContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    roleContentLayout:center()
    self.contentLayout:addChild(roleContentLayout)
    self.roleContentLayout = roleContentLayout

    local bottomBg = UI.Image:create()
    bottomBg:init("ui_reincarnation_role_base.png")
    bottomBg:centerBottom(160)
    roleContentLayout:addChild(bottomBg)

    -- 角色 
    local heroData = RoleDataManager:getMaster()
    local roleAnimation = UI.RoleAnimation:create()
    roleAnimation:init(heroData)
    roleAnimation:centerUp(190)
    -- roleAnimation:setScaleX(-1 * roleAnimation:getScaleX())
    roleContentLayout:addChild(roleAnimation, 300)
    self.roleAnimation = roleAnimation

    local flagLeft = UI.Animation:create()
    flagLeft:init("effect_ui_zhuansheng_fire.json", "effect_ui_zhuansheng_fire.atlas", 1);
    flagLeft:leftBottom(60, 250)
    roleContentLayout:addChild(flagLeft)
    flagLeft:setAnimation("end", true)
    self.flagLeft = flagLeft

    local flagRight = UI.Animation:create()
    flagRight:init("effect_ui_zhuansheng_fire.json", "effect_ui_zhuansheng_fire.atlas", 1);
    flagRight:rightBottom(60, 250)
    roleContentLayout:addChild(flagRight)
    flagRight:setAnimation("end", true)
    self.flagRight = flagRight

    local lightAni = UI.Animation:create()
    lightAni:init("effect_ui_zhuansheng_lighting.json", "effect_ui_zhuansheng_lighting.atlas", 1);
    lightAni:centerUp(190)
    roleContentLayout:addChild(lightAni)
    lightAni:setAnimation("end", true)
    self.lightAni = lightAni

    local twinkle = UI.Animation:create()
    twinkle:init("effect_ui_zhuansheng_hero.json", "effect_ui_zhuansheng_hero.atlas", 1);
    twinkle:centerUp(340)
    roleContentLayout:addChild(twinkle, 301)
    twinkle:setAnimation("begin", true)
    self.twinkle = twinkle

    twinkle:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "event_lighting" then
                self.lightAni:setAnimation("begin", false)
                self.lightAni:addAnimation("idle", true)
                self.flagLeft:setAnimation("begin", false)
                self.flagLeft:addAnimation("idle", true)
                self.flagRight:setAnimation("begin", false)
                self.flagRight:addAnimation("idle", true)
            end
        end
    end)

    -- twinkle:addEventListener(UIEvent.ANIMATION_END,self,function(this, event)
    --     local endPos = string.find(event.animation, "trigger")
    --     if (endPos ~= nil) then
    --         self.lightAni:setAnimation("begin", false)
    --         self.lightAni:addAnimation("idle", true)
    --         self.flagLeft:setAnimation("begin", false)
    --         self.flagLeft:addAnimation("idle", true)
    --         self.flagRight:setAnimation("begin", false)
    --         self.flagRight:addAnimation("idle", true)
    --     end
    -- end)

    local reincarnationBtn = UI.Button:create() 
    reincarnationBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    reincarnationBtn:centerBottom(80)
    reincarnationBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    reincarnationBtn:setText(UI.TEXT_224300)
    roleContentLayout:addChild(reincarnationBtn)
    reincarnationBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        local master = RoleDataManager:getMaster()
        local reincarnationLv = master:getReincarntionLv()
        local config = ConfigManager:getAllRoleReincarnationDataByID(reincarnationLv+1)
        local isCompleted = TaskDataManager:checkTaskIsCompleteByID(config.value)
        if not isCompleted then
            UI.ScrollBar:createByText(UI.TEXT_224315)
            return
        end
        -- self:updateRoleLayout(true)
        if config then
            Net.NetRoleSystem:reqRoleReincarnation(config.roleReiLv)
        end
        -- mvc.send("RoleReincarnation_Req_Role_Reincarnation")
    end)
    reincarnationBtn:hide()
    self.reincarnationBtn = reincarnationBtn

    local levelText = UI.Text:create()
    levelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_236_184_72)
    levelText:centerBottom(80)
    roleContentLayout:addChild(levelText)
    levelText:hide()
    self.levelText = levelText

    self:updateRoleLayout()
end

function RoleReincarnationView:initDetailLayout()
    -- 内容面板
    local detailContentLayout = UI.Layout:create();
    detailContentLayout:init()
    detailContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    detailContentLayout:center()
    self.contentLayout:addChild(detailContentLayout)
    self.detailContentLayout = detailContentLayout
    detailContentLayout:hide()

    local titleBg = UI.Image:create()
    titleBg:init("ui_reincarnation_role_title.png")
    titleBg:centerUp(85)
    detailContentLayout:addChild(titleBg)

    local master = RoleDataManager:getMaster()
    local reincarnationLv = master:getReincarntionLv()
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarnationLv+1)
    local showLv = config and config.roleReiLv or reincarnationLv
    local title = UI.Text:create()
    title:init(string.format(UI.TEXT_224301, showLv), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    title:center()
    titleBg:addChild(title)

    self:createDetailListView()
end

function RoleReincarnationView:createDetailListView()
    local master = RoleDataManager:getMaster()
    local reincarnationLv = master:getReincarntionLv()
    local config = ConfigManager:getAllRoleReincarnationDataByID(reincarnationLv+1) or ConfigManager:getAllRoleReincarnationDataByID(reincarnationLv)
    local desIdList = string.split(config.desId, ";")
    local detailConfigList = {}
    for k, v in pairs(desIdList) do
        local detailConfig = ConfigManager:getAllReincarnationDesDataByID(tonumber(v))
        table.insert(detailConfigList, detailConfig)
    end

    local detailListView = UI.TableView.new({}, 450, 250)
    detailListView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    detailListView:center(0, 10)
    -- detailListView:enableDebugDraw()
    detailListView:setDelegate()
    detailListView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    detailListView:setBounceable(true)
    detailListView:init()
    detailListView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    detailListView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createDetailCell(index,detailConfigList)
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local desCell = cell:getChildByName("desCell")
            if desCell and tolua.isnull(desCell) then
                desCell:removeFromParent()
                desCell = nil
            end
            cell = self:createDetailCell(index, detailConfigList)
        end

        return cell
    end)

    detailListView:onUpdateCellNumbers(function ()
        return table.nums(detailConfigList)
    end)

    self.detailContentLayout:addChild(detailListView, 100)
    detailListView:reloadData(true)
    self.detailListView = detailListView
end

function RoleReincarnationView:createDetailCell(index, data)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local desCell = mvc.roleReincarnationDetailCellView:create(data[index], index)
    desCell:init()
    desCell:center()
    desCell:setName("desCell")
    cell:addChild(desCell)

    return cell
end

function RoleReincarnationView:updateRoleLayout(isTrigger)
    if self.roleContentLayout and not tolua.isnull(self.roleContentLayout) then
        local master = RoleDataManager:getMaster()
        local isReincarntion = master:getIsReincarntion()
        if isReincarntion then
            local reincarntionLv = master:getReincarntionLv()
            local roleShowLv = master:getUIShowLv() == 0 and 1 or master:getUIShowLv() --此时角色等级还未更新 特殊处理
            local levelStr = string.format(UI.TEXT_224303, reincarntionLv, roleShowLv)
            self.levelText:setText(levelStr)    
        end
        if isTrigger then
            -- self.lightAni:setAnimation("begin", false)
            -- self.lightAni:addAnimation("idle", true)
            self.twinkle:setAnimation("trigger")
            self.twinkle:addAnimation("end")
            self.twinkle:addAnimation("idle", true)
            self.roleAnimation:showReincarnactionAnimation(0.23)
        elseif isReincarntion then
            self.lightAni:setAnimation("idle", true)
            self.twinkle:setAnimation("idle", true)
        end
        self.reincarnationBtn:setVisible(not isReincarntion)
        self.levelText:setVisible(isReincarntion)
    end
end

function RoleReincarnationView:switchClick()
    if self.openStat == 0 then
        self.openStat = 1
        self.roleContentLayout:hide()
        self.detailContentLayout:show()
    else
        self.openStat = 0
        self.roleContentLayout:show()
        self.detailContentLayout:hide()
    end 
end


function RoleReincarnationView:showDetailLayer(data)
    local logLayer = mvc.dockLogView:create(data)
    logLayer:init()
    logLayer:center(345, 0)
    logLayer:setName("logLayer")
    self.contentLayout:addChild(logLayer, 500)
end

function RoleReincarnationView:bindModel()

end


function RoleReincarnationView:unbindModel()

end





return RoleReincarnationView












