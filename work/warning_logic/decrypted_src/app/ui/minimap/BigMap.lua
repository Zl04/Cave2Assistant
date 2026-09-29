--[[
    大地图
]]

require "app.ui.Component"
require "app.ui.minimap.MapView"
require "app.ui.minimap.MapTownView"
require "app.ui.minimap.MapFunctionView"
require "app.ui.minimap.MapNpcCell"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local BigMap = class("BigMap", UI.CenterWin)
UI.BigMap = BigMap

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 1136
local COM_HEIGHT = 640
local COM_CLIPPING_NODE_WIDTH = 866
local COM_CLIPPING_NODE_HEIGH = 480
local COM_LAYER_TEXT_WIDTH = 120
local COM_LAYER_TEXT_HEIGHT = 30
local COM_MAP_NAME_TEXT_WIDTH = 400
local COM_MAP_NAME_TEXT_HEIGHT = 60
-- 资源
local COM_RES_LIST = {
    "ui_general_minimap.plist",
    "ui_general_minimap_icon.plist"
}
-- 图片名字
local SPRITE_BIG_MAP_BG = "ui_minimap_cavern_map_02.png"
local SPRITE_BIG_MAP_SIG_NORMAL = "ui_minimap_button_signal_0.png"
local SPRITE_BIG_MAP_SIG_ACTIVE = "ui_minimap_button_signal_1.png"
local SPRITE_BIG_MAP_SIG_DISABLE = "ui_minimap_button_signal_2.png"

-- 坐标
local SIG_BUTTON_LEFT = 7
local SIG_BUTTON_RIGHT = 38
local SIG_BUTTON_BOTTOM = 27
local LAYER_TEXT_LEFT = 48
local LAYER_TEXT_UP = 4
local MAP_NAME_TEXT_RIGHG = 15
local MAP_NAME_TEXT_BOTTOM = 30
local MAP_NAME_TEXT_UP = 2
local CLIPPING_NODE_LEFT = 51
local CLIPPING_NODE_UP = 39
local ANIMATION_BOTTOM_LEFT = 52
local ANIMATION_BOTTOM_UP = 40
local ANIMATION_TOP_LEFT = 16
local ANIMATION_TOP_UP = 10
-- 小地图视野范围
local SMALL_MAP_VISIBLE_RANGE = 7
local BIG_MAP_VISIBLE_RANGE = 7

-- 处理发送信号的处理器
local function onSendSignalHandler(self, button)
    if (self._mapView) then
        if (self._sendingAvailable) then
            local centerCoordX, centerCoordY = self._mapView:getMasterCoord()
            print(string.format("BigMap onSendSignalHandler: master coord: %f %f.", centerCoordX, centerCoordY))

            local spriteID = GameDataManager:getInstance():getMaster():getSpriteID()
            Net.NetRoleSystem:sendCoordSignal(spriteID)

            self._mapView:showCoordSignal(spriteID)
            -- Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SEND_SIGNAL, spriteID)

            self._sendingAvailable = false
            Avalon.Scheduler:scheduleUpdateOnce(self, function(self)
                print(string.format("BigMap onSendSignalHandler: you can sending again."))

                self._sendingAvailable = true
            end, 5)

            Avalon.AudioManager:playSound("1506")
        else
            UI.ScrollBar:createByText(UI.TEXT_111018)

            -- local tips = UI.Tips:createTips(UI.TEXT_111018,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
        end
    else
        assert(false)
    end
end

local function onCloseHandler(self)
    self:close()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil, nil, true)
end

-- 只移动地图内容，不改变地图缩放比例。地图边界处无法再向外滚动时，
-- 使用 ScrollView 的合法范围，避免把地图拖出可视区域。
local function centerMapOnMaster(self, coordX, coordY)
    if (not self._mapView or not self.mScrollView or coordX == nil or coordY == nil) then
        return
    end

    local relativePosX, relativePosY = self._mapView:getRelativePosition(coordX, coordY)
    local mapPosX, mapPosY = self._mapView:getPosition()
    local viewSize = self.mScrollView:getContentSize()
    local innerSize = self.mScrollView:getInnerContainerSize()

    local posX = viewSize.width / 2 - mapPosX - relativePosX
    local posY = viewSize.height / 2 - mapPosY - relativePosY
    local minPosX = math.min(0, viewSize.width - innerSize.width)
    local minPosY = math.min(0, viewSize.height - innerSize.height)
    posX = math.max(minPosX, math.min(0, posX))
    posY = math.max(minPosY, math.min(0, posY))
    self.mScrollView:setInnerContainerPosition(cc.p(posX, posY))
end

-- 大地图打开期间，主角每走完一格就拖动地图内容跟随主角。
local function onMapRolePositionChangedHandler(self, coord, isMaster)
    if (isMaster and coord) then
        centerMapOnMaster(self, coord.x, coord.y)
    end
end

-- 角色发送信号的处理器
local function onRoleSendSignalHandler(self, spriteID)
    if (self._mapView) then
        self._mapView:showCoordSignal(spriteID)

        Avalon.AudioManager:playSound("1506")
    else
        assert(false)
    end
end

-- 构造函数
function BigMap:ctor(targetID)
    -- print("BigMap:ctor")
    BigMap.super.ctor(self, UIType.BIG_MAP, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    -- 地图数据
    self._mapData = nil
    self._targetID = targetID
    -- 发送信号按钮
    self._sigButton = nil
    -- 显示层数
    self._layerText = nil
    -- 显示地图名字
    self._mapNameText = nil
    -- 地图视图
    self._mapView = nil
    -- 剪切节点
    self._clippingNode = nil
    -- 是否可以发送信号的标识
    self._sendingAvailable = true
    -- 连续发送信号的次数限制
    self._sendingCount = 0
    -- 是否显示队友
    self._showTeammate = true

    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_SEND_SIGNAL, self, onRoleSendSignalHandler)

    -- 主角死亡，复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TOWN_CLICK_ICON, self, self.clickTown)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BIGMAP_HIDE, self, self.hideView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BIGMAP_SHOW, self, self.showView)
end

-- 析构函数
function BigMap:dtor()
    -- print("BigMap:dtor")
    self._mapData = nil
    self._sigButton = nil
    self._layerText = nil
    self._mapNameText = nil
    self._mapView = nil
    self._clippingNode = nil

    BigMap.super.dtor(self)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MINI_MAP, UI_COMPONENT_VISIBLE_DURATION)
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_SEND_SIGNAL, self, onRoleSendSignalHandler)

    -- 主角死亡，复活完成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TOWN_CLICK_ICON, self, self.clickTown)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BIGMAP_HIDE, self, self.hideView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BIGMAP_SHOW, self, self.showView)
end

-- public:
-- 初始化
function BigMap:init(mapData)
    self._mapData = mapData

    BigMap.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        self:close()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil, nil, true)
    end)
end

-- 初始化视图
function BigMap:onInitView()
    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(self._width, self._height)
    rootLayout:center()
    self:addChild(rootLayout, 100)
    rootLayout:setOpacity(0)
    self.rootLayout = rootLayout


    -- effect_ui_general_minimap
    local battleAnimation = UI.Animation:create()
    battleAnimation:init("effect_ui_general_minimap.json", "effect_ui_general_minimap.atlas")
    battleAnimation:center()
    if(SceneManager:getInstance():isInTown()) then
        battleAnimation:setAnimation("idle_town", false)
    elseif(SceneManager:getInstance():isGuild()) then
        battleAnimation:setAnimation("idle_guild", false)
    elseif(SceneManager:getInstance():isHome()) then
        battleAnimation:setAnimation("idle_home", false)
    elseif(SceneManager:getInstance():isManor()) then
        battleAnimation:setAnimation("idle_manor", false)
    elseif(SceneManager:getInstance():isPort()) then
        battleAnimation:setAnimation("idle_port", false)
    else
        battleAnimation:setAnimation("idle_cave", false)
    end
    battleAnimation:addEventListener(UIEvent.ANIMATION_END,self,function()

    end)
    self:addChild(battleAnimation)
    local action1 = cc.Sequence:create(cc.FadeIn:create(0.4), cc.CallFunc:create(function ()
        
    end))
    rootLayout:runAction(action1)

    -- battleAnimation:setOpacity(100)

    -- local bgSprite = cc.Sprite:create()
    -- bgSprite:setSpriteFrame(SPRITE_BIG_MAP_BG)
    -- bgSprite:setPosition(self._hw, self._hh)
    -- rootLayout:addChild(bgSprite)

    --创建技能表
    self.mScrollView = ccui.ScrollView:create()
    self.mScrollView:setBounceEnabled(true)
    self.mScrollView:setDirection(ccui.ScrollViewDir.both)
    self.mScrollView:setContentSize(cc.size(830,520))
    -- self.mScrollView:setContentSize(cc.size(1136,636))
    self.mScrollView:setPosition((COM_WIDTH-self.mScrollView:getContentSize().width)/2,(COM_HEIGHT-self.mScrollView:getContentSize().height)/2)
    rootLayout:addChild(self.mScrollView)
    self.mScrollView:setInnerContainerSize(cc.size(1357,600))
    self.mScrollView:setScrollBarEnabled(false)
    self.mScrollView:setSwallowTouches(false)

    if(SceneManager:getInstance():isInTown() 
        or SceneManager:getInstance():isGuild()
        or SceneManager:getInstance():isHome() 
        or SceneManager:getInstance():isManor()
        or SceneManager:getInstance():isPort()) then 
        self.mScrollView:setContentSize(cc.size(1136,636))
        self.mScrollView:setPosition(0,2)
        self.mScrollView:setInnerContainerSize(cc.size(1136,636))
        self.mScrollView:setTouchEnabled(false)
        -- self.mScrollView:stopAutoScroll()
        -- self.mScrollView:enableDebugDraw()
    else 
        local bgSprite = UI.Image:create()
        bgSprite:init("ui_minimap_cavern_map_01.png")
        bgSprite:center()
        -- bgSprite:enableDebugDraw()
        rootLayout:addChild(bgSprite)
    end

    -- 功能滑动列表
    if(SceneManager:getInstance():isNotInFightScene()) then
        local maskBgImage = UI.Image:create()
        maskBgImage:init("ui_minimap_mask_2.png")
        rootLayout:addChild(maskBgImage)

        self:initNpcTableView()

        local maskImage = UI.Image:create()
        if(SceneManager:getInstance():isInTown()) then
            maskImage:init("ui_minimap_town_mask.png")
        elseif SceneManager:getInstance():isGuild() then
            maskImage:init("ui_minimap_guild_mask.png")
        elseif SceneManager:getInstance():isHome() then
            maskImage:init("ui_minimap_guild_mask.png")
        elseif SceneManager:getInstance():isManor() then
            maskImage:init("ui_minimap_guild_mask.png")
        elseif SceneManager:getInstance():isPort() then
            maskImage:init("ui_minimap_guild_mask.png")
        end
        if(SceneManager:getInstance():isGuild()) then 
            maskImage:leftBottom(69, 63 + 10 + 75)
            maskBgImage:leftBottom(69, 63 + 10 + 75)
        else 
            maskImage:leftBottom(69, 62 + 75)
            maskBgImage:leftBottom(69, 62 + 75)
        end
        -- maskImage:enableDebugDraw()
        rootLayout:addChild(maskImage)
    end

    -- -- 装饰表现
    -- local leftDecoImage = UI.Image:create()
    -- leftDecoImage:init("ui_minimap_scroll_1.png")
    -- leftDecoImage:centerLeft(-10)
    -- -- maskImage:enableDebugDraw()
    -- rootLayout:addChild(leftDecoImage)
    
    -- local rightDecoImage = UI.Image:create()
    -- rightDecoImage:init("ui_minimap_scroll_2.png")
    -- rightDecoImage:centerRight(-39)
    -- rootLayout:addChild(rightDecoImage)

    -- local pencialImage = UI.Image:create()
    -- pencialImage:init("ui_minimap_pen.png")
    -- pencialImage:rightBottom(0, 56)
    -- rootLayout:addChild(pencialImage)

    self._sigButton = UI.Button:create()
    self._sigButton:init(SPRITE_BIG_MAP_SIG_NORMAL, SPRITE_BIG_MAP_SIG_ACTIVE, SPRITE_BIG_MAP_SIG_DISABLE)
    self._sigButton:leftBottom(99, 43)
    self._sigButton:addEventListener(UIEvent.BUTTON_CLICK, self, onSendSignalHandler)
    rootLayout:addChild(self._sigButton)

    -- 这里屏蔽玩家在非组队状态发送位置信号
    if(SceneManager:getInstance():isInFightScene() and TeamDataManager:hasTeam()) then 
        if(GameDataManager:getInstance():getMasterIsDead()) then
            self._sigButton:disable()
            self._sigButton:setVisible(true)
        end
    else 
        self._sigButton:disable()
        self._sigButton:setVisible(false)
    end

    local nameTitleImage = UI.Image:create()
    nameTitleImage:init("ui_minimap_title.png")
    nameTitleImage:centerUp(16)
    rootLayout:addChild(nameTitleImage)

    self._mapNameText = UI.Text:create()
    self._mapNameText:init("", UI.FONT_BOLD, UI.FONT_SIZE_24PX,UI.FONT_COLOR_41_41_45)
    self._mapNameText:setSize(COM_MAP_NAME_TEXT_WIDTH, COM_MAP_NAME_TEXT_HEIGHT)
    self._mapNameText:setTextCenter()
    -- self._mapNameText:enableDebugDraw()
    self._mapNameText:centerUp(71 - COM_MAP_NAME_TEXT_HEIGHT/2)
    nameTitleImage:addChild(self._mapNameText)

    -- 关闭按钮
    self._closeButton = UI.Button:create()
    self._closeButton:init("ui_btn_minimap_close_0.png", "ui_btn_minimap_close_1.png", "ui_btn_minimap_close_2.png")
    self._closeButton:rightUp(93, 54)
    self._closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCloseHandler)
    rootLayout:addChild(self._closeButton)
end

-- 更新视图
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
function BigMap:onUpdateView()
    -- 创建地图
    if (self._mapData) then
        -- reload_script_file("app.ui.minimap.MapView")
        -- reload_script_file("app.ui.minimap.MapTownView")
        if(SceneManager:getInstance():isInTown()) then
            self._mapView = UI.MapTownView:create(2, self.functionNpcDataArr, self._targetID)
        elseif(SceneManager:getInstance():isGuild()) then
            self._mapView = UI.MapTownView:create(2, self.functionNpcDataArr, self._targetID)
        elseif(SceneManager:getInstance():isHome()) then
            self._mapView = UI.MapTownView:create(2, self.functionNpcDataArr, self._targetID)
        elseif (SceneManager:getInstance():isManor()) then
            self._mapView = UI.MapTownView:create(2, self.functionNpcDataArr, self._targetID)
        elseif (SceneManager:getInstance():isPort()) then
            self._mapView = UI.MapTownView:create(2, self.functionNpcDataArr, self._targetID)
        else
            self._mapView = UI.MapView:create(2)
        end
        self._mapView:init(self._mapData, BIG_MAP_VISIBLE_RANGE)
        self._mapView:center()
        
        self._mapView:enablePerspective()
        -- 关闭 MapView 自身的定位，统一由外层 ScrollView 拖拽地图跟随主角。
        self._mapView:disableCenterByMaster()
        self._mapView:addEventListener(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, self, onMapRolePositionChangedHandler)
        print("self._renderMapGrid=", self._renderMapGrid)
        if (self._renderMapGrid) then
            self._mapView:enableRenderMapGridTexture()
            -- self._mapView:updateView()
        end
        -- self._mapView:enableDebugDraw()

        self._disableFog = self._mapData.ISeeDeadPeople

        if (self._disableFog) then
            self._mapView:disableFog()
        end
        self._mapView:setTeammateShow(self._showTeammate)
        self.mScrollView:addChild(self._mapView)
        if self._renderMapGrid then
            self.mScrollView:setInnerContainerSize(cc.size(1136, 638 -10))
            -- self.mScrollView:setInnerContainerSize(cc.size(self._mapView._mySprite:getContentSize().width,self._mapView._mySprite:getContentSize().height -10))
            self.mScrollView:setBounceEnabled(false)
            self.mScrollView:setInertiaScrollEnabled(false)
            -- self.mScrollView:setInnerContainerPosition(cc.p(-self._mapView._mySprite:getContentSize().width/2 + self.mScrollView:getContentSize().width/2,
            --     -self._mapView._mySprite:getContentSize().height/2 + self.mScrollView:getContentSize().height/2))
            self.mScrollView:setInnerContainerPosition(cc.p(0, 0))
            if(SceneManager:getInstance():isGuild()) then 
                -- self.mScrollView:setInnerContainerPosition(cc.p(-270, 64))
                self.mScrollView:setInnerContainerPosition(cc.p(-270, 84))
            elseif(SceneManager:getInstance():isHome()) then 
                -- self.mScrollView:setInnerContainerPosition(cc.p(-270, 84))
                self.mScrollView:setInnerContainerPosition(cc.p(-287, -3))
            elseif (SceneManager:getInstance():isManor()) then
                -- self.mScrollView:setInnerContainerPosition(cc.p(-300 - 50, 222 - 20))
                self.mScrollView:setInnerContainerPosition(cc.p(-328, 268))
            elseif (SceneManager:getInstance():isPort()) then
                self.mScrollView:setInnerContainerPosition(cc.p(-270, 84))
            end
        else
            self.mScrollView:setInnerContainerSize(cc.size(self._mapView._width,self._mapView._height))
            -- 先完成 MapView 的布局，再按主角坐标设置 ScrollView 的拖拽位置。
            self._mapView:center()
            local masterPosX, masterPosY = self._mapView:getMasterCoord()
            centerMapOnMaster(self, masterPosX, masterPosY)
        end

        local mapNameStr = languageManagerInstance:getLocalString(self._mapData:getTitle())
        local sceneType = self._mapData.sceneType
        if (sceneType == PublicDefine.SCENE_TYPE.CAVE) then
            local level = self._mapData:getLevel()
            if(SceneManager:getInstance():isInHero()) then 
                -- level = math.mod(level, HERO_INTERVAL) 
                --CO-17606 【深渊】深渊扫荡功能异常
                level = level % HERO_INTERVAL
                if(level == 0) then
                    level = HERO_INTERVAL
                end
            elseif SceneManager:getInstance():isInTrialLand() then
                level = level % 10
                if(level == 0) then
                    level = 10
                end
            elseif SceneManager:getInstance():isInTitanHero() then
                level = level % HERO_INTERVAL
                if(level == 0) then
                    level = HERO_INTERVAL
                end
            elseif SceneManager:getInstance():isInEverWinter() then
                level = math.ceil(level % 10)
            elseif SceneManager:getInstance():isInWormhole() then
                level = math.ceil(level % 10)
            end

            local levelStr = string.format(UI.TEXT_DES_MINI_MAP_LEVEL, level)
            local textStr = string.format("%s: %s", mapNameStr, levelStr)
            self._mapNameText:setText(textStr)
        else
            self._mapNameText:setText(mapNameStr)
        end
    end
end

function BigMap:initNpcTableView()
    -- 获取地图上面的所有数据
    self.functionNpcDataArr = {}
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    local modelArr = {}
    if(machine and machine._model) then 
        modelArr = machine._model:getAllFunctionNpcArr()
    end
    for k,v in ipairs(modelArr) do 
        local data = v:getData()
        local found = false 
        for _,npcData in ipairs(self.functionNpcDataArr) do 
            if(npcData:getId() == data:getId()) then 
                found = true
                break
            end
        end
        if(found == false) then
            local iconMap = ConfigManager:getIconMapByID(data:getId())
            if(iconMap) then
                data.iconMap = iconMap
                table.insert(self.functionNpcDataArr, data)
            else
                print(" iconmap is nil  10425058 "..data:getId())
            end
        end
    end

    -- print("functionNpcDataArr num=", #self.functionNpcDataArr)
    local npcTableView = UI.TableView.new({}, 151, 389);
    npcTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    npcTableView:leftBottom(69, 142)
    npcTableView:setDelegate();
    npcTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    npcTableView:setBounceable(true);
    if(SceneManager:getInstance():isInTown()) then 
        npcTableView:init(0, 0, 0, 0);
    else 
        npcTableView:init(0, 0, 0, 0);
    end 
    -- npcTableView:enableDebugDraw()
    npcTableView:onUpdateCellSize(function (table,idx)
        return 151, 53;
    end);

    npcTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.MapNpcCell.new();
            cell:init(self.functionNpcDataArr[idx+1]);
        end,
        function(e) 
            printError("------------------------rewardListView1:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    npcTableView:onUpdateCellNumbers(function ()
        return #self.functionNpcDataArr + 1
    end);

    npcTableView:onTableCellTouched(function(table, cell)
        local index = cell:getIdx()
        local triggerNpcData = self.functionNpcDataArr[index + 1]
        if(triggerNpcData) then
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                local MachineManager = require("app.game.MachineManager")
                local machine = MachineManager:getInstance():getMachine()
                if(machine) then
                    machine:_pushOpenTriggerNpcCommand(triggerNpcData, true)
                end

                Avalon.AudioManager:playSound(1503)
            end, 0.01)
        end
    end);

    self.rootLayout:addChild(npcTableView);
    npcTableView:reloadData(true);

    self.npcTableView = npcTableView
end

-- 获取所有格子
function BigMap:getMapGridList()
    if (self._mapView) then
        return self._mapView:getMapGridList()
    end
    return nil
end

-- 获取地图
function BigMap:getMapView()
    return self._mapView
end

function BigMap:show()
    self._sigButton:setTouchEnable(true)
    self:setTouchEnable(true)
    self:open()
end

--
function BigMap:hide()
    BigMap.super.hide(self)

    self._sigButton:setTouchEnable(false)
    self:setTouchEnable(false)
end

-- 是否将地块渲染成整张纹理
function BigMap:enableRenderMapGridTexture()
    self._renderMapGrid = true
end

-- 是否有战争迷雾
function BigMap:disableFog()
    self._disableFog = true
end

function BigMap:getMapView()
    return self._mapView
end

function BigMap:showTeammate(visible)
    self._showTeammate = visible
end

function BigMap:masterDead()
    if(not tolua.isnull(self._sigButton)) then
        self._sigButton:disable()
    end
end

function BigMap:masterRevive()
    if(not tolua.isnull(self._sigButton)) then 
        self._sigButton:enable()
    end
end

function BigMap:clickTown(npcData, dataArr) 
    -- add by zp 处理界面的处理逻辑
    -- print("BigMap:clickTown", #dataArr)
    -- local npcData = data:getNpcData()
    if(dataArr and #dataArr > 0) then
        -- 计算坐标
        -- reload_script_file("app.ui.minimap.MapFunctionView")
        local roleSpriteName, elementSpriteName, hasRole, hasElement = UI.MapGrid:getIconName(npcData, true)
        local iconMap = ConfigManager:getIconMapByID(npcData:getId())
        local name = nil 
        if(iconMap) then 
            name = LanguageManager:getInstance():getLocalString(iconMap.name)
        end

        -- 测试单个表现逻辑
        -- local index = 0
        -- local arr = {}
        -- for k, v in ipairs(dataArr) do 
        --     if(index >=3) then 
        --         break
        --     end
        --     table.insert(arr, v)
        --     index = index + 1
        -- end
        -- dataArr = arr

        local mapFunctionView = UI.MapFunctionView:create()
        mapFunctionView:init(npcData:getSpriteID(), dataArr, name, elementSpriteName, nil, function()
            -- Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, functionPanel)
        end)
        local function infoOutSizeTouchHandler(self,obj,touchPosition)
            if(not tolua.isnull(mapFunctionView)) then
                mapFunctionView:close()
                mapFunctionView = nil
            end
        end
        mapFunctionView:center()
        mapFunctionView:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, infoOutSizeTouchHandler)
        self:addChild(mapFunctionView, 10000)
    end
end

function BigMap:hideView(isRemove)
    if(not tolua.isnull(self)) then 
        if isRemove then
            onCloseHandler(self)
        else
            self:setVisible(false)
        end
    end
end

function BigMap:showView()
    if(not tolua.isnull(self)) then 
        self:setVisible(true)
    end
end
