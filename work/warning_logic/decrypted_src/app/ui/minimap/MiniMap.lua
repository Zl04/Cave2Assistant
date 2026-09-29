--[[
    小地图
]]

require "app.ui.Component"
require "app.ui.minimap.MapView"

local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"
local SceneManager = require("app.game.SceneManager")
local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}

local MiniMap = class("MiniMap", UI.HWBtnComponent)
UI.MiniMap = MiniMap

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 238
local COM_HEIGHT = 219
local COM_CLIPPING_NODE_WIDTH = 300
local COM_CLIPPING_NODE_HEIGHT = 300
local CONST_SCALE = 0.5 --保证 COM_CLIPPING_NODE_WIDTH * CONST_SCALE = 300 不用改代码
-- 坐标
local COM_CLIPPING_NODE_UP = 32
local COM_CLIPPING_NODE_RIGHT = 15
local COM_OPEN_IMAGE_RIGHT = -53
local COM_OPEN_IMAGE_BOTTOM = -18
-- 资源
local COM_RES_LIST = {
    "ui_general_minimap.plist",
    "ui_general_minimap_drawer.plist",
    "ui_selectlevel_checkPoint.plist",
    "ui_town_world_boss.plist",
    "ui_town_maincity.plist",
}
-- 图片名字
local SPRITE_MINI_MAP_BG_1 = "ui_minimap_bg_02.png"
local SPRITE_MINI_MAP_TOP_1 = "ui_minimap_bg_01.png"
local SPRITE_MINI_MAP_TOP_1_TIGER = "ui_minimap_bg_01_tiger.png"
-- 坐标信号动画
local ANIMATION_JSON_SIGNAL = "effect_ui_common_signal.json"
local ANIMATION_ATLAS_SIGNAL = "effect_ui_common_signal.atlas" 
local ANIMATION_NAME_SIGNAL_IDLE = "idle1"

local ANIMATION_JSON_SIGNAL_GENERAL = "effect_ui_general_minimap_signal.json"
local ANIMATION_ATLAS_SIGNAL_GENERAL = "effect_ui_general_minimap_signal.atlas" 

-- 小地图视野范围
local SMALL_MAP_VISIBLE_RANGE = 7

-- 直线方程
local function line(self, x1, y1, x2, y2)
    local a = y2 - y1
    local b = x1 - x2
    local c = x2 * y1 - x1 * y2
    return a, b, c
end
-- 计算连线和clippingnode的交点
local function computeJoinPoint(self, localPosX, localPosY)
    -- 必须在clippingnode范围外才会出现交点
    if (localPosX <= 0 or localPosX >= COM_CLIPPING_NODE_WIDTH or localPosY <= 0 or localPosY >= COM_CLIPPING_NODE_HEIGHT) then
        local jpPosX, jpPosY = 0, 0
        local centerPosX, centerPosY = COM_CLIPPING_NODE_WIDTH / 2, COM_CLIPPING_NODE_HEIGHT / 2
        local a, b, c = line(self, centerPosX, centerPosY, localPosX, localPosY)

        local offsetX, offsetY = localPosX - centerPosX, localPosY - centerPosY
        local ratio = offsetY / offsetX
        if (ratio >= -1 and ratio < 1) then
            if (offsetX < 0) then
                jpPosX = 10
                jpPosY = -1 * (a * jpPosX + c) / b
            else
                jpPosX = COM_CLIPPING_NODE_WIDTH - 10
                jpPosY = -1 * (a * jpPosX + c) / b
            end
        else
            if (offsetY > 0) then
                jpPosY = COM_CLIPPING_NODE_HEIGHT - 10
                jpPosX = -1 * (b * jpPosY + c) / a
            else
                jpPosY = 10
                jpPosX = -1 * (b * jpPosY + c) / a
            end
        end
        local angle = (-1 * math.atan2(offsetY, offsetX) * 180.0 / 3.1415926) - 180.0
        return true, jpPosX, jpPosY, angle
    end
    return false, 0, 0, 0
end

-- 更新小地图角色方向的肩头
local function updateRoleArrow(self, heroGrid, spriteID)
    local mapViewPosX, mapViewPosY = self._mapView:getPosition()
    -- local posX, posY = heroGrid:getRelativePosition()
    local coordX, coordY = heroGrid:getCoord()
    local posX, posY = self._mapView:getRelativePosition(coordX, coordY)
    local localPosX, localPosY = posX + mapViewPosX, posY + mapViewPosY

    local hasJP, jpPosX, jpPosY, rotation = computeJoinPoint(self, localPosX, localPosY)
end

-- 更新小地图角色方向的箭头
local function updateRoleArrows(self)
    if(DEBUG) then
        print("updateRoleArrows")
    end
    if (self._mapView) then
        local masterID = GameDataManager:getInstance():getMaster():getSpriteID()

        local mapViewPosX, mapViewPosY = self._mapView:getPosition()
        local heroGridMap = self._mapView:getHeroGridMap()
        for spriteID, heroGrid in pairs(heroGridMap) do
            local isMaster = (spriteID == masterID)
            if (not isMaster) then
                if(DEBUG) then
                    print("MiniMap updateRoleArrows: ", spriteID)
                end

                updateRoleArrow(self, heroGrid, spriteID)
            end
        end
    else
        assert(false)
    end
end

-- 角色位置改变的处理器
local function onRolePositionChangedHandler(self, coord, isMaster, spriteID)
    if (not self._showTeammateCoord) then return end

    if (isMaster) then
        updateRoleArrows(self)
    else
        if (self._mapView) then
            local heroGridMap = self._mapView:getHeroGridMap()
            if (heroGridMap[spriteID] == nil) then
                local arrowNode = self._heroArrowNodeMap[spriteID]
                if (arrowNode) then 
                    arrowNode:setVisible(false)
                end
            else
                local mapGrid = self._mapView:getMapGrid(coord.x, coord.y)
                if (mapGrid) then
                    updateRoleArrow(self, mapGrid, spriteID)
                else
                    -- for k=1,10 do 
                        print(string.format("[ERROR] onRolePositionChangedHandler  not found coord x:y=%d:%d", coord.x, coord.y))
                    -- end
                    -- assert(false, string.format("onRolePositionChangedHandler x:y=%d:%d", coord.x, coord.y))
                end
            end
        else
            assert(false)
        end
    end
end

-- 角色发送信号的处理器
local function onRoleSendSignalHandler(self, spriteID)
    local arrowNode = self._heroArrowNodeMap[spriteID]
    if (arrowNode and arrowNode:isVisible()) then 
        local showTimes = 0
        local animation = UI.Animation:create()
        if(SceneManager:getInstance():isInFightScene()) then
            animation:init(ANIMATION_JSON_SIGNAL, ANIMATION_ATLAS_SIGNAL, 1.0)
        else
            animation:init(ANIMATION_JSON_SIGNAL_GENERAL, ANIMATION_ATLAS_SIGNAL_GENERAL, 1.0)
        end
        animation:play(ANIMATION_NAME_SIGNAL_IDLE, true)
        animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(self)
            showTimes = showTimes + 1
            if (showTimes >= 3) then 
                animation:close()
            end
        end)
        animation:center(posX, posY)
        arrowNode:addChild(animation)
    elseif self._mapView then
        self._mapView:showCoordSignal(spriteID)
    end

    Avalon.AudioManager:playSound("1506")
end

function MiniMap:iapOpen()
    self._iapShopUIOpened = true
end

function MiniMap:iapClose()
    self._iapShopUIOpened = false
end

-- 构造函数
function MiniMap:ctor()
    MiniMap.super.ctor(self, UIType.MINI_MAP, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.isScheduling = nil
    -- 地图数据
    self._mapData = nil
    -- 背景图片
    self._bgSprite = nil    
    -- 地图视图
    self._mapView = nil
    -- 剪切节点
    self._clippingNode = nil
    -- 是否取消迷雾
    self._disableFog = false
    -- 是否显示玩家
    self._showTeammateCoord = false
    self.updateGiftIcon = false
    -- 指向玩家的箭头
    self._heroArrowNodeMap = {}
    if self.schedulerID == nil then
        self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 2, false)
    end

    --是否替换为虎年UI
    self.isTiger = false
    self._appendStr = ""

    Avalon.MessageCenter:bind(GameMessage.MC_ROLE_SEND_SIGNAL, self, onRoleSendSignalHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_SHOW_MINI_MAP, self, self.showMiniMap)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_HIDE_MINI_MAP, self, self.hideMiniMap)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.getGiftBoughtNum)
    -- Avalon.MessageCenter:bind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:bind(GameMessage.MC_PURCHASE_SUCCESS, self,self.getGiftBoughtNum)
    Avalon.MessageCenter:bind(GameMessage.MC_ADV_GIFT_DATA_UPDATE, self,self.getGiftBoughtNum)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_GUILD_TEAM_BUF, self,self.refreshInfoBtn)

    -- 内购
    Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshShopStatus)
    Avalon.MessageCenter:bind(GameMessage.MC_IPASHOP_OPEN, self, self.iapOpen)
    Avalon.MessageCenter:bind(GameMessage.MC_IPASHOP_CLOSE, self, self.iapClose)
    -- 领取月卡状态刷新
    Avalon.MessageCenter:bind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshShopStatus)
    Avalon.MessageCenter:bind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshShopStatus)

    Avalon.MessageCenter:bind(GameMessage.MC_UI_OPEN_BIG_MAP, self, self.openBigMap)

    if mvc.limitTimePackageModel then
        mvc.limitTimePackageModel:bind("treasureId",self, self.getGiftBoughtNum)
    end


    Avalon.MessageCenter:bind(AvalonMessage.MC_PICTURE_ALBUM, self, self.refreshInfoBtn)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end

-- 析构函数
function MiniMap:dtor()
    MiniMap.super.dtor(self)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    Avalon.MessageCenter:unbind(GameMessage.MC_ROLE_SEND_SIGNAL, self, onRoleSendSignalHandler)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SHOW_MINI_MAP, self, self.showMiniMap)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_HIDE_MINI_MAP, self, self.hideMiniMap)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_PRODUCTS, self,self.getGiftBoughtNum)
    -- Avalon.MessageCenter:unbind(GameMessage.MC_GET_BOUGHT_RESP, self, self.onGetBoughtResp)
    Avalon.MessageCenter:unbind(GameMessage.MC_PURCHASE_SUCCESS, self,self.getGiftBoughtNum)
    Avalon.MessageCenter:unbind(GameMessage.MC_ADV_GIFT_DATA_UPDATE, self,self.getGiftBoughtNum)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN, self, self.refreshInfoBtn) 
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GOODS_USE_INFO_CHANGE, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_FUNCTION_UNLOCK, self,self.refreshInfoBtn)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_GUILD_TEAM_BUF, self,self.refreshInfoBtn)

    -- 内购
    Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshShopStatus)
    Avalon.MessageCenter:unbind(GameMessage.MC_IPASHOP_OPEN, self, self.iapOpen)
    Avalon.MessageCenter:unbind(GameMessage.MC_IPASHOP_CLOSE, self, self.iapClose)
    -- 领取月卡状态刷新
    Avalon.MessageCenter:unbind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshShopStatus)
    Avalon.MessageCenter:unbind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshShopStatus)

    Avalon.MessageCenter:unbind(GameMessage.MC_UI_OPEN_BIG_MAP, self, self.openBigMap)

    if mvc.limitTimePackageModel then
        mvc.limitTimePackageModel:unbind("treasureId",self, self.getGiftBoughtNum)
    end

    Avalon.MessageCenter:unbind(GameMessage.MC_PICTURE_ALBUM, self, self.refreshInfoBtn)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end

-- public:
-- 初始化
function MiniMap:init(mapData)
    self._mapData = mapData

    MiniMap.super.init(self)

    self._clippingNode:setTouchEnable(true)
    self._clippingNode:addEventListener(UIEvent.COMPONENT_CLICK, self, self.openBigMap)
end

function MiniMap:openBigMap(targetID)
    Avalon.AudioManager:playSound("1503")
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_BIG_MAP, self._mapData,self._disableFog,self._mapView, targetID)
    self:hideMiniMap(UI_COMPONENT_VISIBLE_DURATION)
end

function MiniMap:update()
    if self.updateGiftIcon then
        -- 进阶礼包重置检查
        local masterData = RoleDataManager:getMaster()
        local advStageRefreshTime = masterData.stageRefreshTime

        local nowTime = GameManager:getNormalServerTime()
        if advStageRefreshTime <= nowTime then
            -- 如果已经跨过刷新时间，则需要重置进度
            local haveReset = RoleDataManager:getAdvGiftResetProgress()
            if not haveReset then
                RoleDataManager:setAdvGiftResetProgress()
                self:showAdvGiftEntry(0)
            end
        end
    end

    -- 检查是否有任何限时活动
    local isNowRunning = mvc.activityPointModel:isAnyLimitTimeActivityRunning()
    if (self._dailyActivityTimeLimitRunning ~= isNowRunning) then
        self._dailyActivityTimeLimitRunning = isNowRunning
        self:refreshInfoBtn()
    end
end

-- 初始化视图
function MiniMap:onInitView()

    -- local masterData = GameDataManager:getInstance():getMaster()
    -- if masterData then
    --     local eData = masterData:getGameUIEquippedDecorates()
    --     dump(eData)
    --     for k,v in pairs(eData) do
    --         if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
    --             if v.value == 1 then --虎年
    --                 self.isTiger = true
    --                 break
    --             end
    --         end
    --     end
    -- end

    self:initUseUIValue()

    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInTown() then
        CONST_SCALE = 1
        COM_CLIPPING_NODE_WIDTH = 169
        COM_CLIPPING_NODE_HEIGHT = 169
    elseif SceneManager:getInstance():isGuild() then 
        CONST_SCALE = 1
        COM_CLIPPING_NODE_WIDTH = 169 / CONST_SCALE
        COM_CLIPPING_NODE_HEIGHT = 169 / CONST_SCALE
    elseif SceneManager:getInstance():isHome() then 
        CONST_SCALE = 1
        COM_CLIPPING_NODE_WIDTH = 169 / CONST_SCALE
        COM_CLIPPING_NODE_HEIGHT = 169 / CONST_SCALE
    elseif SceneManager:getInstance():isManor() then
        CONST_SCALE = 1
        COM_CLIPPING_NODE_WIDTH = 169 / CONST_SCALE
        COM_CLIPPING_NODE_HEIGHT = 169 / CONST_SCALE
    else
        CONST_SCALE = 0.5
        COM_CLIPPING_NODE_WIDTH = 169 / CONST_SCALE
        COM_CLIPPING_NODE_HEIGHT = 169 / CONST_SCALE
    end

   -- 底部图片
    self._bgSprite = cc.Sprite:create()
    self._bgSprite:setSpriteFrame(SPRITE_MINI_MAP_BG_1)
    self._bgSprite:setAnchorPoint(0.5, 0)
    self._bgSprite:setPosition(self._hw + 22, self._height - (COM_CLIPPING_NODE_UP + COM_CLIPPING_NODE_HEIGHT * CONST_SCALE))
    self:addChild(self._bgSprite)

    -- 小地图遮挡形状
    local stencil = cc.Sprite:create()
    stencil:setSpriteFrame(SPRITE_MINI_MAP_BG_1)
    stencil:setScale(1 / CONST_SCALE)
    local bBox = stencil:getBoundingBox()
    local size = stencil:getContentSize()
    stencil:setPosition((size.width - bBox.width) / 2, (size.height - bBox.height) / 2)
    
    -- 小地图遮挡框架
    self._clippingNode = UI.ClippingNode:create()
    self._clippingNode:initWithNode(stencil, 0)
    self._clippingNode:center(25, 6)--Up(COM_CLIPPING_NODE_UP - COM_CLIPPING_NODE_HEIGHT / 4 - 10)
    self._clippingNode:setScale(CONST_SCALE)
    self:addChild(self._clippingNode)
    -- 上部图片
    local topImage = UI.Image:create()
    topImage:init(SPRITE_MINI_MAP_TOP_1)
    topImage:rightUp(0, 0)
    self:addChild(topImage, 5)
    self.topImage = topImage

    -- 标题
    local floorName = UI.Text:create()
    floorName:init(string.format(UI.TEXT_DES_MINI_MAP_LEVEL, self._mapData:getLevel()), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_153_153_153)
    floorName:center(-2, -82)
    topImage:addChild(floorName)
    floorName:setWidth(170)
    floorName:autoAdapt()
    floorName:setTextHorizontalCenter()
    self._levelText = floorName

    -- 任务
    self._functionInfoBtn, self._functionInfoRedPoint = self:createNormalBtn("ui_information_button_task_0.png", "ui_information_button_task_1.png", "ui_information_button_task_2.png", nil, nil, function()
        self:openFunction(PublicDefine.FUNCTION_TYPE.TASK)
    end, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112422))
    end)
    topImage:addChild(self._functionInfoBtn, 10)

    -- 日常活跃     
    self._dailyBtn, self._dailyRedPoint = self:createNormalBtn("ui_information_button_activation_0.png", "ui_information_button_activation_1.png", "ui_information_button_activation_2.png", nil, nil, function()
        mvc.openPanel("ActivityPoint", "ActivityPoint")
    end, function()
        if (not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DailyAction)) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170189))
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112422))
        end
    end)
    topImage:addChild(self._dailyBtn, 10)

    -- 活动
    self._rewardInfoBtn, self._rewardInfoRedPoint = self:createNormalBtn("ui_information_button_activity_0.png", "ui_information_button_activity_1.png", "ui_information_button_activity_2.png", nil, nil, function()
        self:openFunction(PublicDefine.FUNCTION_TYPE.ACTIVITY)
    end, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112422))
    end)
    topImage:addChild(self._rewardInfoBtn, 10)

    --首通奖励
    -- self._firstPassBtn, self._firstPassPoint = self:createNormalBtn("ui_information_button_firstclean_0.png", "ui_information_button_firstclean_1.png", "ui_information_button_firstclean_2.png", nil, nil, function()
    --     local maxLevelData = nil
    --     local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    --     local showLevel = GameDataManager:_getCaveLevel(self._mapData.caveMode, self._mapData.level)
    --     local maxLevel = 0
    --     if self._mapData.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
    --         local level = math.floor(showLevel / HERO_INTERVAL) * HERO_INTERVAL + 1
    --         maxLevelData = GameDataManager:getMaster():getMaxLevelData(self._mapData.caveMode, self._mapData.difficulty, level)
    --         maxLevel = math.floor(showLevel / HERO_INTERVAL) * HERO_INTERVAL + HERO_INTERVAL
    --     else
    --         maxLevelData = GameDataManager:getMaster():getMaxLevelData(self._mapData.caveMode, self._mapData.difficulty)
    --         maxLevel = math.floor(showLevel / SHOP_INTERVAL) * SHOP_INTERVAL + SHOP_INTERVAL
    --     end

    --     print("----self._mapData.level----",self._mapData.level , showLevel, maxLevel)
    --     if maxLevelData ~= nil then
    --         noBackMaxLevel = maxLevelData:getNoBackMaxLevel()
    --         showLevel = showLevel > noBackMaxLevel and showLevel or noBackMaxLevel
    --     end
    --     local curLevel = showLevel

    --     require "app.ui.town.FirstPassPanel"
    --     local firstPassPanel = UI.FirstPassPanel:create()
    --     firstPassPanel:init(self._mapData.caveMode, self._mapData.difficulty, maxLevel, curLevel)
    --     firstPassPanel:center()
    --     UI.UIManager:getRootNode():addChild(firstPassPanel, UI_ZORDER.ACTIVITY)
    -- end, function()
    --     UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112422))
    -- end)
    -- topImage:addChild(self._firstPassBtn, 10)

    -- 首通奖励
    self._guildBufBtn = self:createNormalBtn("ui_information_button_guildpower_0.png", "ui_information_button_guildpower_1.png", "ui_information_button_guildpower_1.png")
    topImage:addChild(self._guildBufBtn, 10)
    self._guildBufBtn:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        self:guildBufClick(self._guildBufBtn)
    end)
    self._guildBufBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        if (not tolua.isnull(self.bufPanel)) then
            self.bufPanel:removeFromParent(true)
            self.bufPanel = nil
        end
    end)

    local settingsBg = UI.Image:create()
    settingsBg:init("ui_minimap_banner_5.png")
    settingsBg:rightUp(0, 8)
    topImage:addChild(settingsBg, 8)
    self.settingsBg = settingsBg

    -- 设置按钮
    self._settingsButton = UI.Button:create(UI.Type.SETTINGS_BUTTON)
    self._settingsButton:init("ui_main_button_setup_0.png", "ui_main_button_setup_1.png", "ui_main_button_setup_0.png")
    self._settingsButton:rightUp(6, 8)
    self._settingsButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SETTINGS)
    end)
    self._settingsButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170189))
    end)
    topImage:addChild(self._settingsButton, 10)

    -- 内购按钮
    self._shopButton = UI.Button:create()
    self._shopButton:init("ui_function_icon_shopping_0.png","ui_function_icon_shopping_1.png","ui_function_icon_shopping_2.png")
    self._shopButton:rightUp(12, 172)
    self._shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, true, 1, nil, 
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
        self:resetNewIapBox()
        self:refreshShopStatus()
        -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_IapShop_Open,0,0,0,0)
    end)
    self._shopButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170189))
    end)
    topImage:addChild(self._shopButton, 10)

    local shopEff = self._shopButton:getChildByName("shopEff")
    if not shopEff or tolua.isnull(shopEff) then
        shopEff = UI.Animation:create()
        shopEff:init("effect_ui_town_shop_button.json","effect_ui_town_shop_button.atlas",1)
        shopEff:center(0, -2)
        shopEff:setName("shopEff")
        self._shopButton:addChild(shopEff, 10)
    end
    shopEff:setAnimation("idle1", true)

    -- 内购小红点
    self._shopStatus = AvalonUtil.createRedPoint(self._shopButton, -4, -4, 101)
    self._shopStatus:setName("redPoint")

    -- 第一次更新按钮
    -- self:refreshInfoBtn()
    self:updateTigerEffect()
    self:getGiftBoughtNum()

    -- 按钮抽屉
    require "app.ui.minimap.MiniMapDrawer"
    local drawer = UI.MiniMapDrawer:create()
    drawer:rightUp(85, -3)
    self:addChild(drawer, -1)

    
end

function MiniMap:guildBufClick(sender)
    local sameGuildNum,sameGuildId, buffId = TeamDataManager:getSameGuildBuf() 
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(283, 154)
    layout:rightUp(210, sender:getUp())
    self.topImage:addChild(layout, 200)
    self.bufPanel = layout

    local bg =  UI.Image9:create()
    bg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(273, 154))
    bg:rightUp(10, 0)
    layout:addChild(bg)

    local arrow =  UI.Image:create()
    arrow:init("ui_information_banner_background2.png")
    arrow:rightUp(1, 10)
    layout:addChild(arrow)

    local title = UI.Text:create()
    title:init(UI.TEXT_1170720, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
    title:leftUp(18, 18)
    layout:addChild(title)

    local line = UI.Image9:create()
    line:init("ui_scale9image_banner_line_light3.png", CCRectMake(0,0,20,20), cc.size(238, 1))
    line:leftUp(18, 40)
    layout:addChild(line)
    local height = 20
    if buffId ~= 0 and buffId ~= nil then
        local bufferData = SkillDataManager:createBufferData(buffId)
        local desc = UI.Text:create()
        desc:init(bufferData.description, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
        desc:setWidth(245)
        desc:autoAdapt()
        desc:leftUp(18, 55)
        layout:addChild(desc)
        height = height + desc:getContentSize().height
    end
    bg:setSize(273, 55 + height)
end

-- 刷新内购红点
function MiniMap:refreshShopStatus()
    if self._shopStatus then
        local hasNewIapBox = self:hasNewIapBox() 
        local hasNewIapBox2 = SdkManager:getInstance():haveNewIapBox()
        local isInStory = SceneManager:getInstance():isInStory()
        local showStatus = not isInStory and (hasNewIapBox or hasNewIapBox2)
        self._shopStatus:setVisible(showStatus)

        local shopEff = self._shopButton:getChildByName("shopEff")
        local action = showStatus and "idle2" or "idle1"
        shopEff:setAnimation(action, true)
    end
end

function MiniMap:hasNewIapBox()
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    local hasNew = globalUserData:hasNewIapBox()
    return hasNew
end

function MiniMap:resetNewIapBox()
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    globalUserData:markNewIapBox()
    Avalon.UserDataManager:saveDataToFile(globalUserData:getType())
end

-- 注释了之前的礼包获取数量方法，这里直接走新的每日超值礼包逻辑，创建按钮（注释方法在下面）
function MiniMap:getGiftBoughtNum()
    self:addGiftLayout()
end

-- function MiniMap:getGiftBoughtNum()
--     if (self._iapShopUIOpened) then return end
    
--     if (self.giftLayout) then
--         self.giftLayout:removeFromParent()
--         self.giftLayout = nil
--     end

--     self:refreshGiftData()

--     local types = {}
--     local needs = {}
--     if self.firstPayGiftList then
--         for k, v in pairs(self.firstPayGiftList) do
--             table.insert(needs, v.productID)
--             types[tostring(v.productID)]= PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_EXTRA_GIFT
--         end
--     end

--     local productInfo = mvc.limitTimePackageModel:getCurProductionInfo()
--     if productInfo then
--         table.insert(needs, productInfo.productID)
--         types[tostring(productInfo.productID)]= PublicDefine.PURCHASE_PRODUCT_TYPE.TimePushTreasure
--     end

--     if table.nums(types) == 0 then
--         -- 超值礼包和限时礼包都没有配置
--         self:onGetBoughtRequst(true)
--         return
--     end

--     local boughts = SdkManager:getInstance():getBoughts()
--     if boughts == nil then
--         SdkManager:getInstance():reqBoughtNum(needs,types)
--     else
--         local find = false
--         for i, v in ipairs(needs) do
--             find = false
--             for i1,v1 in ipairs(boughts) do
--                 if v == v1.productID then
--                     find = true
--                     break
--                 end
--             end
--             if not find then
--                 SdkManager:getInstance():reqBoughtNum(needs,types)
--                 break
--             end
--         end
--         if find then
--             self:onGetBoughtRequst(true)
--         else
--             self:showDisabledLimitEntry()
--         end
--     end
-- end

-- function MiniMap:onGetBoughtResp()
--     self:onGetBoughtRequst(false)
-- end

-- function MiniMap:onGetBoughtRequst(request)
--     if not SceneManager:getInstance():isInTown() then
--         self:showDisabledLimitEntry()
--         return
--     end

--     self.giftType = 0
--     self:refreshGiftData()

--     if not self.firstPayGiftList then
--         -- 没有配置超值礼包
--         if self:checkEnterLimitPackage() then
--             self:showLimitPackageEntry(false)
--         else
--             self:checkAdvGiftProgress()
--         end
--     else
--         -- check time
--         local continueTime = self.firstPayGiftList[1].existTime
--         local masterData = RoleDataManager:getMaster()
--         local createTime = masterData.createTime
--         local nowTime = GameManager:getNormalServerTime()
--         if createTime + continueTime <= nowTime then
--             -- 超值礼包超过了有效期，显示进阶礼包
--             if self:checkEnterLimitPackage() then
--                 self:showLimitPackageEntry(false)
--             else
--                 self:checkAdvGiftProgress()
--             end
--         else
--             local boughts = SdkManager:getInstance():getBoughts()
--             if not boughts then
--                 -- 显示超值礼包
--                 self:showfirstPayGiftListEntry(false)
--                 return
--             end

--             local find = false
--             for i1, v1 in ipairs(boughts.boughtNum) do
--                 if v1.productID == self.firstPayGiftList[1].productID and v1.boughtNum >= self.firstPayGiftList[1].limitedNum then
--                     -- 已购买过超值礼包了，显示进阶礼包
--                     if self:checkEnterLimitPackage(boughts) then
--                         self:showLimitPackageEntry(false)
--                     else
--                         self:checkAdvGiftProgress()
--                     end
--                     find = true
--                     break
--                 end
--             end

--             if not find then
--                 -- 显示超值礼包
--                 local giftData = SdkManager:getInstance():getIapDatas()
--                 for k, v in pairs(giftData) do
--                     if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.PURCHASE_EXTRA_GIFT then
--                         return self:showfirstPayGiftListEntry(false)
--                     end
--                 end

--                 self:showDisabledLimitEntry()
--             end
--         end
--     end
-- end

-- function MiniMap:showDisabledLimitEntry()
--     self:addGiftLayout()

--     self.btnSpine = UI.Button:create()
--     self.btnSpine:init("ui_information_button_giftbag_08.png", "ui_information_button_giftbag_08.png", "ui_information_button_giftbag_08.png")
--     self.btnSpine:setSwallowTouches(false)
--     self.btnSpine:center(-5, -5)
--     self.btnSpine:disable()
--     self.giftLayout:addChild(self.btnSpine, 1)
-- end

-- function MiniMap:checkEnterLimitPackage()
--     local boughts = SdkManager:getInstance():getBoughts()
--     if not boughts then
--         return false
--     end

--     local productInfo = mvc.limitTimePackageModel:getCurProductionInfo()
--     if not productInfo then
--         return false
--     end

--     for i1, v1 in ipairs(boughts.boughtNum) do
--         if v1.productID == productInfo.productID and v1.boughtNum >= productInfo.limitedNum then
--             return false
--         end
--     end
--     return true
-- end


-- function MiniMap:showLimitPackageEntry(request)
--     self:addGiftLayout()

--     local btnSpine = UI.Button:create()
--     btnSpine:init("ui_information_button_giftbag_00.png", "ui_information_button_giftbag_00.png", "ui_information_button_giftbag_08.png")
--     btnSpine:setSwallowTouches(false)
--     btnSpine:center()
--     self.btnSpine = btnSpine
--     self.giftLayout:addChild(btnSpine, 1)

--     if not self.showLimitAnimation then
--         AvalonUtil.playShakeAct(self.btnSpine, true)
--     else
--         self.btnSpine:stopAllActions()
--         self.btnSpine:setScale(1)
--     end
--     local curRefreshDay = RoleDataManager:getMaster():getRefreshDay()
--     self.targetTime = mvc.limitTimePackageModel:getRefreshDay() * 24 * 3600
--     local text = UI.Text:create()
--     text:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX)
--     text:center(0,34)
--     self.giftLayout:addChild(text, 1)
--     self.cdText = text
--     self.giftType = 3

--     if(request) then
--         if not self.isScheduling then
--             self:scheduleUpdateTime()
--         end
--     end
-- end

-- function MiniMap:scheduleUpdateTime()
--     if tolua.isnull(self) or tolua.isnull(self.cdText) then
--         return
--     end

--     local nowTime = GameManager:getNormalServerTime()
--     local remind = self.targetTime - nowTime
--     if remind > 0 then
--         Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
--         self.isScheduling = true
--         local showText = AvalonUtil:_getFullFormatTime(remind, true, true,false) 
--         self.cdText:setText(showText)
--     else
--         self.isScheduling = false
--         self.cdText:setText("")
--         self:getGiftBoughtNum()
--     end
-- end

-- function MiniMap:checkAdvGiftProgress()
--     if not self.advGift or #self.advGift == 0 then
--         self:showDisabledLimitEntry()
--         return
--     end

--     local masterData = RoleDataManager:getMaster()
--     local createTime = masterData.createTime
--     local advStageRefreshTime = masterData.stageRefreshTime
--     local advStage = 0
--     for k, v in ipairs(self.advGift) do
--         if v.stage == masterData.stage then
--             advStage = k
--             break
--         end
--     end

--     local advStageRefreshTime = masterData.stageRefreshTime

--     local nowTime = GameManager:getNormalServerTime()
--     if advStageRefreshTime <= nowTime then
--         -- 如果已经跨过刷新时间，则需要重置进度
--         RoleDataManager:setAdvGiftResetProgress()
--         advStage = 0
--     end

--     -- 如果进阶礼包购买完毕，则没有入口
--     if advStage >= #self.advGift then
--         for i = 0, #self.advGift-1 do
--             cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.AdvGiftNew .. i .. GameDataManager:getInstance():getMasterPK(), true)
--         end
--         self:showDisabledLimitEntry()
--         return
--     end

--     self:showAdvGiftEntry(advStage)
--     self.updateGiftIcon = true
-- end

-- function MiniMap:showfirstPayGiftListEntry(request)
--     self:addGiftLayout()

--     local btnSpine = UI.Button:create()
--     btnSpine:init("ui_information_button_giftbag_01.png", "ui_information_button_giftbag_01.png", "ui_information_button_giftbag_08.png")
--     btnSpine:setSwallowTouches(false)
--     btnSpine:center()
--     self.btnSpine = btnSpine
--     self.giftLayout:addChild(btnSpine, 1)

--     if MasterDataManager:getExtraGiftFlag() then
--         self.btnSpine:stopAllActions()
--         self.btnSpine:setScale(1)
--     else
--         AvalonUtil.playShakeAct(self.btnSpine, true)
--     end

--     local continueTime = self.firstPayGiftList[1].existTime
--     local masterData = RoleDataManager:getMaster()
--     local createTime = masterData.createTime
--     self.targetTime = createTime + continueTime
    
--     local text = UI.Text:create()
--     text:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX)
--     text:center(0,34)
--     self.giftLayout:addChild(text, 1)
--     self.cdText = text

--     if(request) then
--         if not self.isScheduling then
--             self:scheduleUpdateTime()
--         end
--     end
--     self.giftType = 1
-- end

-- function MiniMap:showAdvGiftEntry(advStage)
--     self:addGiftLayout(advStage)

--     local iconName = "ui_information_button_giftbag_0"..(advStage+1)..".png"
--     local btnSpine = UI.Button:create()
--     btnSpine:init(iconName, iconName, "ui_information_button_giftbag_08.png")
--     btnSpine:setSwallowTouches(false)
--     btnSpine:center()
--     self.btnSpine = btnSpine
--     self.giftLayout:addChild(btnSpine, 1)

--     local isNew = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.AdvGiftNew .. advStage .. GameDataManager:getInstance():getMasterPK(), true)
--     if isNew then
--         AvalonUtil.playShakeAct(self.btnSpine, true)
--     else
--         self.btnSpine:stopAllActions()
--         self.btnSpine:setScale(1)
--     end

--     self.giftType = 2
-- end

function MiniMap:addGiftLayout()
    if self.giftLayout then
        self.giftLayout:removeFromParent()
        self.giftLayout = nil
    end

    self.giftLayout = UI.Layout:create()
    self.giftLayout:init()
    self.giftLayout:setSize(50, 50)
    self.giftLayout:rightUp(45, 188)
    self.giftLayout:setTouchEnable(true)

    self.btnSpine = UI.Button:create()
    self.btnSpine:init("ui_information_button_giftbag_00.png", "ui_information_button_giftbag_00.png", "ui_information_button_giftbag_08.png")
    self.btnSpine:setSwallowTouches(false)
    self.btnSpine:center()
    self.giftLayout:addChild(self.btnSpine, 1)

    if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag) then
        self.btnSpine:enable()
        self.btnSpine:center()
        AvalonUtil.playShakeAct(self.btnSpine, true)
    else
        self.btnSpine:center(-5, -5)
        self.btnSpine:disable()
    end

    self.giftLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        self.btnSpine:setScale(1)
        if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag) then
            mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag)
        end
    end)
    self:addChild(self.giftLayout, 20)

    self:refreshInfoBtn()
end

-- 创建一个按钮
function MiniMap:createNormalBtn(spriteNormalName, spriteActiveName, spriteDisableName, touchCallback, releaseCallback, clickCallBack, disableClickCallback)
    -- 按键
    local infoBtn = UI.Button:create()
    infoBtn:init(spriteNormalName, spriteActiveName, spriteDisableName)
    -- infoBtn:leftUp(-35, 30)
    if (touchCallback) then
        infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, touchCallback)
    end
    if (releaseCallback) then
        infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, releaseCallback)
    end
    if(clickCallBack) then
        infoBtn:addEventListener(UIEvent.BUTTON_CLICK, self, clickCallBack)
    end
    if (disableClickCallback) then
        infoBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, disableClickCallback)
    end

    -- 红点
    local redPoint = AvalonUtil.createRedPoint(infoBtn)
    redPoint:hide()

    return infoBtn, redPoint
end

-- 更新视图
function MiniMap:onUpdateView()
    -- 创建地图
    if (self._mapData) then
        local mapNameStr = languageManagerInstance:getLocalString(self._mapData:getTitle())
        local sceneType = self._mapData.sceneType
        if (sceneType == PublicDefine.SCENE_TYPE.CAVE ) then
            -- print("onUpdateView=", mapNameStr, self._mapData:getLevel())
            local level = self._mapData:getLevel()
            local SceneManager = require("app.game.SceneManager")
            if(SceneManager:getInstance():isInHero()) then 
                -- level = math.mod(level, HERO_INTERVAL) 
                --CO-17606 【深渊】深渊扫荡功能异常
                level = level % HERO_INTERVAL
                if(level == 0) then
                    level = HERO_INTERVAL
                end
                -- print("onUpdateView= 2", mapNameStr, level)
            elseif SceneManager:getInstance():isInTitanHero() then
                level = level % HERO_INTERVAL
                if(level == 0) then
                    level = HERO_INTERVAL
                end
            elseif SceneManager:getInstance():isInTrialLand() then
                level = level % 10
                if(level == 0) then
                    level = 10
                end
            elseif SceneManager:getInstance():isInEverWinter() then
                level = math.ceil(level % 10)
            elseif SceneManager:getInstance():isInWormhole() then
                level = math.ceil(level % 10)
            end
            
            local levelStr = string.format(UI.TEXT_DES_MINI_MAP_LEVEL, level)

            local textStr = string.format("%s:%s", mapNameStr, levelStr)
            self._levelText:setText(textStr)
        else
            self._levelText:setText(mapNameStr)
        end

        self._mapView = UI.MapView:create(1)
        self._mapView:init(self._mapData, SMALL_MAP_VISIBLE_RANGE)
        self._mapView:enablePerspective()
        self._mapView:setVisibleRangeForPerformance(5, 10)

        self._disableFog = self._mapData.ISeeDeadPeople

        if (self._disableFog) then 
            self._mapView:disableFog() 
        end
        if (self._renderMapGrid) then
            self._mapView:enableRenderMapGridTexture()
        end
        self._mapView:setTeammateShow(self._showTeammateCoord)
        self._mapView:addEventListener(UIEvent.MINI_MAP_ROLE_POSITION_CHANGED, self, onRolePositionChangedHandler)
        self._clippingNode:addInnerNode(self._mapView)
        -- self._mapView:setScale(0.5)

        -- 显示指向英雄的小箭头
        if (self._showTeammateCoord) then
            updateRoleArrows(self)
        end

        -- 显示调试信息
        -- if true then
        if (CONFIG_SHOW_DEBUG_PANEL) then
            require "app.ui.gmUtil.GMUtilExecutor"
            if (UI.GMUtilExecutor:getShowTestUI()) then
                local mapGridList = self._mapView:getMapGridList()
                if (mapGridList) then
                    local index = 0
                    for i, mapGrid in pairs(mapGridList) do
                        local mapGrid = mapGridList[i]
                        if (mapGrid and mapGrid:isTriggerNPC()) then
                            local infoStr = ""
                            local hasText = true

                            -- 入口
                            if (mapGrid:isSomeTriggerNPC(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
                                infoStr = string.format("入口在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 普通密室
                            elseif (mapGrid:isSomeTriggerNPC(PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE)) then
                                infoStr = string.format("普通密室在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 机关密室触发器
                            elseif (mapGrid:isSomeTriggerNPC(PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER)) then
                                infoStr = string.format("机关密室触发器在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 机关密室
                            elseif (mapGrid:isSomeTriggerNPC(PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE)) then
                                infoStr = string.format("机关密室在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 附魔台
                            elseif (mapGrid:isSomeFunctionNPC(FUNCTION_TYPE.ENCHANT)) then
                                infoStr = string.format("附魔台在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 点金台
                            elseif (mapGrid:isSomeFunctionNPC(FUNCTION_TYPE.GOLD_TOUCH)) then
                                infoStr = string.format("点金台在(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            -- 宠物怪
                            elseif (mapGrid:isMonsterPet()) then
                                infoStr = string.format("宠物怪(%d,%d)", mapGrid:getCoord())
                                index = index + 1
                            else
                                hasText = false
                            end
                            if (hasText) then
                                local text = UI.Text:create()
                                text:init(infoStr, UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
                                text:rightUp(0, 260 + 20 * index)
                                self:addChild(text)
                            end
                        end

                        if (mapGrid and mapGrid:isMonsterPet()) then
                            index = index + 1
                            local infoStr = string.format("宠物怪(%d,%d)", mapGrid:getCoord())
                            local text = UI.Text:create()
                            text:init(infoStr, UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
                            text:rightUp(0, 260 + 20 * index)
                            self:addChild(text)
                        end
                    end
                    if self._mapData.petMonsterLv then 
                        index = index + 1
                        local infoStr = string.format("宠物怪的楼层(%d)", tonumber(self._mapData.petMonsterLv))
                        local text = UI.Text:create()
                        text:init(infoStr, UI.FONT_ARIAL, UI.FONT_SIZE_14PX)
                        text:rightUp(0, 260 + 20 * index)
                        self:addChild(text)
                    end
                end
            end
        end
    end

    local miniMapWidth, miniMapHeight = self:getSize()
    self._showPosX, self._showPosY = self:getPosition()
    self._hidePosX, self._hidePosY = self._showPosX + miniMapWidth + 20 + Avalon.issUtil:getRightMargin(), self._showPosY
end

-- 取消战争迷雾
function MiniMap:disableFog()
    if (self._mapView) then
        self._mapView:disableFog()
    else
        self._disableFog = true
    end
end

-- 是否显示队友的位置信息
function MiniMap:showTeammateCoord()
    self._showTeammateCoord = true
end

-- 是否将地块渲染成整张纹理
function MiniMap:enableRenderMapGridTexture()
    self._renderMapGrid = true
end

-- 主界面上显示小地图
function MiniMap:showMiniMap(duration)
    duration = duration or 0
    self:stopAllActions()
    self:runAction(cc.MoveTo:create(duration,cc.p(self._showPosX or 0, self._showPosY or 0)))
end

-- 隐藏小地图
function MiniMap:hideMiniMap(duration)
    duration = duration or 0
    self:stopAllActions()
    self:runAction(cc.MoveTo:create(duration,cc.p((self._hidePosX or 0) + 350, self._hidePosY or 0)))
end

function MiniMap:refreshSpecialEventBtn()
    self:refreshInfoBtn()
end

function MiniMap:refreshInfoBtn()
    require "app.datas.RoleDataManager"
    -- 刷新内购
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
        self._shopButton:enable()
        self:playBtnUnlockAction(self._shopButton, PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase)
    else
        self._shopButton:disable()
    end

    local btnList = {}
    -- 日常活跃度
    if (RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DailyAction)) then
        self._dailyBtn:show()
        -- table.insert(btnList, self._dailyBtn)
        btnList["daily"] = self._dailyBtn
        if (mvc.activityPointModel:isAnyLimitTimeActivityRunning() or mvc.activityPointModel:getRewardNum() > 0) then
            self._dailyRedPoint:show()
        else
            self._dailyRedPoint:hide()
        end
       
    else
        self._dailyBtn:hide()
        self._dailyRedPoint:hide()
    end

    -- 任务
    self._functionInfoBtn:show()
    -- table.insert(btnList, self._functionInfoBtn)
    btnList["task"] = self._functionInfoBtn
    local achevementListNum = MasterDataManager:getAchevementAwardList()
    local taskListNum = TaskDataManager:getTaskHaveCompleteNum()
    local pRed = PictureAlbumManager:isRedDot()
    if taskListNum + achevementListNum > 0 or pRed then
        self._functionInfoRedPoint:show()
    else
        self._functionInfoRedPoint:hide()
    end

    --活动
    if ServerConfigUtil:isInReview() then
        self._rewardInfoBtn:hide()
    else
        self._rewardInfoBtn:show()
        -- table.insert(btnList, self._rewardInfoBtn)
        btnList["active"] = self._rewardInfoBtn
        local number = GameDataManager:getInstance():getNewActivityNum() + GameDataManager:getInstance():getActivityReceiveNum()
        if number > 0 then
            self._rewardInfoRedPoint:show()
        else
            self._rewardInfoRedPoint:hide()
        end
    end


    --首通奖励
    -- if (not SceneManager:getInstance():isShowFirstPassScene()) or not CONFIG_FIRST_PASS then
    --     self._firstPassBtn:hide()
    --     self._firstPassPoint:hide()
    -- else
    --     table.insert(btnList, self._firstPassBtn)
    -- end

    --公会组队buf
    local selfGuildId = 0
    local guildData = MasterDataManager:getGuildData()
    if guildData ~= nil then
        selfGuildId = guildData:getID()
    end
    local CAVE_MODE = PublicDefine.CAVE_MODE
    local caveMode = self._mapData.caveMode
    local sameGuildNum,sameGuildId, buffID = TeamDataManager:getSameGuildBuf() 
    if sameGuildNum <= 1 or sameGuildId ~= selfGuildId or (caveMode ~= CAVE_MODE.MODE_NORMAL and caveMode ~= CAVE_MODE.MODE_HERO
        and caveMode ~= CAVE_MODE.MODE_DESERT_EYES 
        and caveMode ~= CAVE_MODE.MODE_DISTORTED_SPACE
        and caveMode ~= CAVE_MODE.MODE_INFERNO
        and caveMode ~= CAVE_MODE.MODE_VOID_RIFT
        and caveMode ~= CAVE_MODE.MODE_VIKING
        and caveMode ~= CAVE_MODE.MODE_TITAN_ROAD
        and caveMode ~= CAVE_MODE.MODE_TITAN_ROAD_HERO
        and caveMode ~= CAVE_MODE.MODE_CHAOS) then
        self._guildBufBtn:hide()
    else
        if(TeamDataManager:hasMercenaryTeam()) then
            self._guildBufBtn:hide()
        else
            self._guildBufBtn:show()
        end
        -- table.insert(btnList, self._guildBufBtn)
        btnList["guildbuff"] = self._guildBufBtn
    end

    -- 内购红点刷新
    self:refreshShopStatus()

    -- 特殊场景限制
    if SceneManager:getInstance():isInStory() then
        self._rewardInfoBtn:hide()
        self._rewardInfoRedPoint:hide()
        self._functionInfoBtn:hide()
        self._functionInfoRedPoint:hide()
        self._dailyBtn:hide()
        self._dailyRedPoint:hide()
        self._shopButton:hide()
        self._shopStatus:hide()
        -- self._firstPassBtn:hide()
        -- self._firstPassPoint:hide()
        self._guildBufBtn:hide()
        btnList = {}
    end
    self:refreshBtnBg(btnList)
end

function MiniMap:refreshBtnBg(btnList)
    -- btnNumber = #btnList
    local bgParamList = {
        {tag = "daily", name = "ui_minimap_banner_3.png", x = 61, y = 73, ring = "ui_minimap_box_3.png", btnX = 187, btnY = 79},
        {tag = "task", name = "ui_minimap_banner_3.png", x = 60, y = 120, ring = "ui_minimap_box_3.png", btnX = 186, btnY = 123},
        {tag = "active", name = "ui_minimap_banner_3.png", x = 37, y = 165, ring = "ui_minimap_box_3.png", btnX = 162, btnY = 168},
        {tag = "guildbuff", name = "ui_minimap_banner_3.png", x = 1, y = 193, ring = "ui_minimap_box_3.png", btnX = 124, btnY = 196}
    }

    if self.isTiger then
        -- bgParamList = {
        --     {tag = "daily", name = "ui_minimap_banner_3_tiger.png", x = 61, y = 73, ring = "ui_minimap_box_3_tiger.png", btnX = 187, btnY = 79},
        --     {tag = "task", name = "ui_minimap_banner_3_tiger.png", x = 60, y = 120, ring = "ui_minimap_box_3_tiger.png", btnX = 186, btnY = 123},
        --     {tag = "active", name = "ui_minimap_banner_3_tiger.png", x = 37, y = 165, ring = "ui_minimap_box_3_tiger.png", btnX = 162, btnY = 168},
        --     {tag = "guildbuff", name = "ui_minimap_banner_3_tiger.png", x = 1, y = 193, ring = "ui_minimap_box_3_tiger.png", btnX = 124, btnY = 196}
        -- }
        bgParamList = {
            {tag = "daily", name = "ui_minimap_banner_3" .. self._appendStr .. ".png", x = 61, y = 73, ring = "ui_minimap_box_3" .. self._appendStr .. ".png", btnX = 187, btnY = 79},
            {tag = "task", name = "ui_minimap_banner_3" .. self._appendStr .. ".png", x = 60, y = 120, ring = "ui_minimap_box_3" .. self._appendStr .. ".png", btnX = 186, btnY = 123},
            {tag = "active", name = "ui_minimap_banner_3" .. self._appendStr .. ".png", x = 37, y = 165, ring = "ui_minimap_box_3" .. self._appendStr .. ".png", btnX = 162, btnY = 168},
            {tag = "guildbuff", name = "ui_minimap_banner_3" .. self._appendStr .. ".png", x = 1, y = 193, ring = "ui_minimap_box_3" .. self._appendStr .. ".png", btnX = 124, btnY = 196}
        }
    end


    for i = 1, #bgParamList do
        local param = bgParamList[i]
        local btn = btnList[param.tag]
        if btn and not self:getChildByName(param.tag) then
            local bg = UI.Image:create()
            bg:init(param.name)
            bg:rightUp(param.x, param.y)
            bg:setName(param.tag)
            self:addChild(bg, -10 + i)

            local ringImg = UI.Image:create()
            ringImg:init(param.ring)
            ringImg:centerLeft(-6)
            ringImg:setName(param.tag)
            bg:addChild(ringImg)

            btn:rightUp(param.btnX, param.btnY)
        elseif btn and self:getChildByName(param.tag) then
            local bg = self:getChildByName(param.tag)
            bg:setSpriteName(param.name)
            if bg:getChildByName(param.tag) then
                local ringImg = bg:getChildByName(param.tag)
                ringImg:setSpriteName(param.ring)
            end
        end
    end

    -- 如果没有guildbuff按钮显示，则用底框4
    if not btnList["guildbuff"] then
        local bg = UI.Image:create()
        if self.isTiger then
            -- bg:init("ui_minimap_banner_4_tiger.png")
            bg:init("ui_minimap_banner_4" .. self._appendStr .. ".png")
        else
            bg:init("ui_minimap_banner_4.png")
        end
        
        bg:rightUp(1, 196)
        self:addChild(bg, -10 + 4)
    end

    if self._shopButton:isVisible() and not self.topImage:getChildByName("shopBtnBg") then
        local bg = UI.Image:create()
        if self.isTiger then
            -- bg:init("ui_minimap_banner_1_tiger.png")
            bg:init("ui_minimap_banner_1" .. self._appendStr .. ".png")
        else
            bg:init("ui_minimap_banner_1.png")
        end
        bg:rightUp(0, 159)
        bg:setName("shopBtnBg")

        local ringImg = UI.Image:create()
        if self.isTiger then
            -- ringImg:init("ui_minimap_box_1_tiger.png")
            ringImg:init("ui_minimap_box_1" .. self._appendStr .. ".png")
        else
            ringImg:init("ui_minimap_box_1.png")
        end
        ringImg:centerLeft(-6)
        ringImg:setName("shopBtnBg")
        bg:addChild(ringImg)

        self.topImage:addChild(bg, 5)
    elseif self._shopButton:isVisible() and self:getChildByName("shopBtnBg") then
        local bg = self.topImage:getChildByName("shopBtnBg")
        if self.isTiger then
            -- bg:setSpriteName("ui_minimap_banner_1_tiger.png")
            bg:setSpriteName("ui_minimap_banner_1" .. self._appendStr .. ".png")
        else
            bg:setSpriteName("ui_minimap_banner_1.png")
        end
        if bg:getChildByName("shopBtnBg") then
            local ringImg = bg:getChildByName("shopBtnBg")
            if self.isTiger then
                -- ringImg:setSpriteName("ui_minimap_box_1_tiger.png")
                ringImg:setSpriteName("ui_minimap_box_1" .. self._appendStr .. ".png")
            else
                ringImg:setSpriteName("ui_minimap_box_1.png")
            end
        end
    end

    -- 与内购按钮同时出现
    if self._shopButton:isVisible() then
        if self.giftLayout and not tolua.isnull(self.giftLayout) then
            self.giftLayout:setVisible(true)
        end
        if not self.topImage:getChildByName("SingleBg") then
            local bg = UI.Image:create()
            if self.isTiger then
                -- bg:init("ui_minimap_banner_2_tiger.png")
                bg:init("ui_minimap_banner_2" .. self._appendStr .. ".png")
            else
                bg:init("ui_minimap_banner_2.png")
            end
            bg:rightUp(0, 187)
            bg:setName("SingleBg")
            self.topImage:addChild(bg, 1)

            local ringImg = UI.Image:create()
            if self.isTiger then
                -- ringImg:init("ui_minimap_box_2_tiger.png")
                ringImg:init("ui_minimap_box_2" .. self._appendStr .. ".png")
            else
                ringImg:init("ui_minimap_box_2.png")
            end
            ringImg:centerLeft(-6)
            ringImg:setName("SingleBg")
            bg:addChild(ringImg)
        elseif self:getChildByName("SingleBg") and self.isTiger then
            local bg = self.topImage:getChildByName("SingleBg")
            if self.isTiger then
                -- bg:setSpriteName("ui_minimap_banner_2_tiger.png")
                bg:setSpriteName("ui_minimap_banner_2" .. self._appendStr .. ".png")
            else
                bg:setSpriteName("ui_minimap_banner_2.png")
            end
            if bg:getChildByName("SingleBg") then
                local ringImg = bg:getChildByName("SingleBg")
                if self.isTiger then
                    -- ringImg:setSpriteName("ui_minimap_box_2_tiger.png")
                    ringImg:setSpriteName("ui_minimap_box_2" .. self._appendStr .. ".png")
                else
                    ringImg:setSpriteName("ui_minimap_box_2.png")
                end
            end
        end
    else
        if self.giftLayout and not tolua.isnull(self.giftLayout) then
            self.giftLayout:setVisible(false)
        end
    end
end

function MiniMap:playBtnUnlockAction(btn, functionType)
    if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
        btn:show()
        btn:disable()
        btn:playUnlockAction(function()
            self:playUnlockActionCallback(btn, functionType)
            btn:enable()
        end)
    elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
        btn:playNewAction(0.6)
    else
        btn:removeNewAction()
    end
end

function MiniMap:playUnlockActionCallback(btn, functionType)
    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(functionType)
    btn:playNewAction(0.6)
end

function MiniMap:openFunction(functionType)
    if (functionType == PublicDefine.FUNCTION_TYPE.TASK) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
    elseif (functionType == PublicDefine.FUNCTION_TYPE.ACTIVITY) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_ACTIVITY_PANEL, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
    elseif (functionType == PublicDefine.FUNCTION_TYPE.MAILBOX) then
        Avalon.MessageCenter:notice(GameMessage.MC_TASK_SHOW_MAILLAYER, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
    else
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local isActivateFuncSucc = machine:_openUIByFunctionType(functionType)
    end
end

function MiniMap:isDecorateValue(dValue)
    local useValue = PublicDefine.UseUIDecorateValue.DecorateValue_Default
    local masterData = GameDataManager:getInstance():getMaster()
    if not masterData then
        return useValue
    end

    local eData = masterData:getGameUIEquippedDecorates()
    for k,v in pairs(eData) do
        if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
            if v.value == dValue then
                useValue = dValue
                break;
            end
        end
    end

    return useValue
end

function MiniMap:initUseUIValue()
    self.isTiger = false
    self._appendStr = ""
    for i = PublicDefine.UseUIDecorateValue.DecorateValue_Tiger, PublicDefine.UseUIDecorateValue.DecorateValue_Max - 1, 1 do
        local useValue = self:isDecorateValue(i)
        if useValue ~= PublicDefine.UseUIDecorateValue.DecorateValue_Default then
            self.isTiger = true
            if useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger then
                self._appendStr = "_tiger"
            elseif useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate then
                self._appendStr = "_pirate"
            end
        end
    end
end

function MiniMap:updateTigerEffect()
    -- local masterData = GameDataManager:getInstance():getMaster()
    -- if not masterData then
    --     return 
    -- end

    -- self.isTiger = false

    -- local eData = masterData:getGameUIEquippedDecorates()
    -- for k,v in pairs(eData) do
    --     if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
    --         if v.value == 1 then --虎年
    --             self.isTiger = true
    --             break
    --         end
    --     end
    -- end

    self:initUseUIValue()

    if (self.isTiger) then
        if self.topImage then
            -- self.topImage:setSpriteName(SPRITE_MINI_MAP_TOP_1_TIGER)
            self.topImage:setSpriteName("ui_minimap_bg_01" .. self._appendStr .. ".png")
        end
        if self.settingsBg then
            -- self.settingsBg:setSpriteName("ui_minimap_banner_5_tiger.png")
            self.settingsBg:setSpriteName("ui_minimap_banner_5" .. self._appendStr .. ".png")
        end
    else
        if self.topImage then
            self.topImage:setSpriteName(SPRITE_MINI_MAP_TOP_1)
        end
        if self.settingsBg then
            self.settingsBg:setSpriteName("ui_minimap_banner_5.png")
        end
    end

    self:refreshInfoBtn()

end