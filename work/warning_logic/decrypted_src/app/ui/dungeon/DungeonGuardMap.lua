-- DungeonGuardMap.lua
-- Author:CMonk
-- 2018年12月27日
-- 备注: 目前效率为 On, 可以优化至 O1.

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local DungeonGuardMap = class("DungeonGuardMap", UI.HWBtnComponent)
UI.DungeonGuardMap = DungeonGuardMap

-- local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local LV_SELECT_WIDTH = 700
local LV_SELECT_HEIGHT = 580
local LV_SELECT_MAP_SECTION_WIDTH = 1404
local LV_SELECT_MAP_SECTION_HEIGHT = 558
local LV_SELECT_LV_PER_SECTION = 35
local LV_SELECT_LV_PER_ICON = 5
local SWEEP_GOOD_ID = 22060010

--资源列表(必备)
local COM_RES_LIST = {}

--构造函数(必备)
function DungeonGuardMap:ctor()
    DungeonGuardMap.super.ctor(self, 0, COM_RES_LIST, 0, 0)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_DUNGEON_SWEEP_NUM, self, self.updateSweepNum)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SHOW_DUNGEON_SWEEP_REWARD, self, self.showSweepReward)
end

-- 虚构函数, destroy时调用(必备)
function DungeonGuardMap:dtor()
    DungeonGuardMap.super.dtor(self)
    self.floorLevel = nil
    self._selectCallback = nil

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_DUNGEON_SWEEP_NUM, self, self.updateSweepNum)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SHOW_DUNGEON_SWEEP_REWARD, self, self.showSweepReward)
    reload_script_file("app.ui.dungeon.DungeonGuardMap")
end

-- 初始化(必备)
function DungeonGuardMap:init(maxLv)
    -- 限制的最高楼层
    self.maxLimitLevel = tonumber(ConfigManager:getGeneralForKey("maxDungeonLevel"))
    -- 兼容过高的层数
    maxLv = maxLv > self.maxLimitLevel and self.maxLimitLevel or maxLv
    -- 修复引擎显示在大于100万层以上的BUG
    LV_SELECT_MAP_SECTION_WIDTH = LV_SELECT_MAP_SECTION_WIDTH - math.floor(math.pow(maxLv / 35, 1/4) * 0.4)

    -- 获取上次达到层数信息来展现解锁
    local GameDataManager = require("app.game.GameDataManager")
    self._oldMaxLv = cc.UserDefault:getInstance():getIntegerForKey("DUNGEON_LV_MAX" .. GameDataManager:getInstance():getMasterPK(), 0)
    cc.UserDefault:getInstance():setIntegerForKey("DUNGEON_LV_MAX" .. GameDataManager:getInstance():getMasterPK(), maxLv)

    -- 初始化最大等级, 截掉最后不为5倍数的部分 + 1 (例 77 截为 76, 54 截 为 51, 等等)
    self._mapSections = {}
    local calcMaxLv = maxLv - 1
    self._lvSelectMaxLv = calcMaxLv - calcMaxLv % LV_SELECT_LV_PER_ICON + 1

    -- 记录真实到达的最高层
    local masterData = GameDataManager:getInstance():getMaster()
    local maxLevelData = masterData:getMaxLevelData(PublicDefine.CAVE_MODE.MODE_DUNGEON, 1)
    local floor = maxLevelData:getMaxLevel()
    self.realMaxLevel = (floor == nil or floor == 0) and 1 or floor

    DungeonGuardMap.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DungeonGuardMap:onInitView()
    -- 设置自身大小
    self:setSize(LV_SELECT_WIDTH, LV_SELECT_HEIGHT)
    self:setTouchEnable(true)

    -- 关卡选择背板
    local lvSelectBg = UI.Image9:create()
    lvSelectBg:init("ui_selectfloor_map_bigpaper.png", CCRectMake(0,0,20,20), cc.size(LV_SELECT_WIDTH, LV_SELECT_HEIGHT))
    lvSelectBg:leftBottom(0, 0)
    self:addChild(lvSelectBg)

    -- 上部标题背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_dungeon_title.png")
    titleBg:centerUp(13)
    lvSelectBg:addChild(titleBg, 1)

    -- 上部标题文字
    local titleText = UI.Text:create()
    titleText:init(LanguageManager:getInstance():getLocalString(1111573), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    titleText:center()
    titleBg:addChild(titleText)

    -- 上部分割线
    local topSplitter = UI.Image9:create()
    topSplitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(LV_SELECT_WIDTH, 1))
    topSplitter:centerUp(48)
    lvSelectBg:addChild(topSplitter)

    -- 中央滚动组件
    self._scrollView = UI.ScrollView:create()
    self._scrollView:init(0, 0, 0, 0)
    self._scrollView:setSize(LV_SELECT_WIDTH / 0.8, LV_SELECT_MAP_SECTION_HEIGHT) -- 美术后续要求修改上下缩小0.8, 宽度保持不变, 比例保持不变
    self._scrollView:center(0, -5)
    self._scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    self._scrollView:setBounceEnabled(true)
    self._scrollView:setMaxBound(190)
    self._scrollView:setScale(0.8) -- 美术后续要求修改上下缩小0.8, 宽度保持不变, 比例保持不变
    self._scrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self._scrollView, function(_, comp, percent, position)
        -- 滚动到一节地图过后再初始化楼层图标动画
        local currentX = -position.x + LV_SELECT_WIDTH
        local currentMapSectionIdx = math.ceil(currentX / LV_SELECT_MAP_SECTION_WIDTH)
        self:initMapSectionIfNotInited(currentMapSectionIdx - 1)
        self:initMapSectionIfNotInited(currentMapSectionIdx)
        self:initMapSectionIfNotInited(currentMapSectionIdx + 1)
        if (self._initDone) then
            self:setCloudStateForMapSection(currentMapSectionIdx - 1)
            self:setCloudStateForMapSection(currentMapSectionIdx)
            self:setCloudStateForMapSection(currentMapSectionIdx + 1)
            self:setIconStateForMapSection(currentMapSectionIdx - 1)
            self:setIconStateForMapSection(currentMapSectionIdx)
            self:setIconStateForMapSection(currentMapSectionIdx + 1)
        end
    end)
    lvSelectBg:addChild(self._scrollView)

    -- 限制一下视野, 免得滚动到最右边的时候一屏幕都是云
    local sectionBaseX = (math.ceil((self._lvSelectMaxLv + 0.1) / LV_SELECT_LV_PER_SECTION) - 1) * LV_SELECT_MAP_SECTION_WIDTH
    local sectionProgressX = math.min(((self._lvSelectMaxLv % LV_SELECT_LV_PER_SECTION / LV_SELECT_LV_PER_SECTION) + 0.4), 1.4) * LV_SELECT_MAP_SECTION_WIDTH
    local contentWidth = sectionBaseX + sectionProgressX

    -- 中央滚动布局
    self._scrollContentLayout = UI.Layout:create()
    self._scrollContentLayout:init()
    self._scrollContentLayout:setSize(contentWidth, LV_SELECT_MAP_SECTION_HEIGHT)
    self._scrollView:addInnerNode(self._scrollContentLayout)

    -- 填充中间的滚动图
    for i=0, math.ceil(self._lvSelectMaxLv / LV_SELECT_LV_PER_SECTION) + 1 do
        if (i > 0) then
            -- 初始化记录区块数据, 表现会在需要展现的时候延迟初始化
            local mapSectionEntry = {
                inited = false,
            }
            table.insert(self._mapSections, mapSectionEntry)
        else
            -- -1 填补一格最左拖动超出表现, 否则就是空的一片
            local mapSection = UI.Image:create()
            mapSection:init("ui_dungeon_banner_bg.png")
            mapSection:centerLeft(-1 * LV_SELECT_MAP_SECTION_WIDTH)
            self._scrollContentLayout:addChild(mapSection)
        end
    end

    -- 下部分割线
    local botSplitter = UI.Image9:create()
    botSplitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(LV_SELECT_WIDTH, 1))
    botSplitter:centerBottom(59)
    lvSelectBg:addChild(botSplitter)

    -- 下部文字
    local botText = UI.Text:create()
    botText:init(LanguageManager:getInstance():getLocalString(1111574), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    botText:setWidth(LV_SELECT_WIDTH - 80)
    botText:center(0, 257)
    self:addChild(botText)

    -- 关卡选择背板上的遮罩, 左
    local shadowL = UI.Image9:create()
    shadowL:init("ui_selectfloor_map_gradually_2.png", CCRectMake(0,0,80,476), cc.size(80, LV_SELECT_HEIGHT))
    shadowL:centerLeft(0)
    lvSelectBg:addChild(shadowL)

    -- 关卡选择背板上的遮罩, 右
    local shadowR = UI.Image9:create()
    shadowR:init("ui_selectfloor_map_gradually_2.png", CCRectMake(0,0,80,476), cc.size(80, LV_SELECT_HEIGHT))
    shadowR:setScaleX(-1)
    shadowR:centerRight(0)
    lvSelectBg:addChild(shadowR)

    -- 初始化后做默认选择最大楼层
    performWithDelay(self, function()
        self._scrollView:scrollToRight()
        local mapSectionIdx = math.ceil(self._lvSelectMaxLv / LV_SELECT_LV_PER_SECTION)
        self:initMapSectionIfNotInited(mapSectionIdx)
        self:setCloudStateForMapSection(mapSectionIdx)
        self:setIconStateForMapSection(mapSectionIdx, function(isUnlock) -- 设置状态完成回调传回是否是解锁事件
            self:setSelectedLv(self._lvSelectMaxLv, not isUnlock)
        end)
        self._initDone = true
    end, 0.34) --0.34刚刚好避过UI进入动画
end

function DungeonGuardMap:initMapSectionIfNotInited(idx)
    -- 最左溢出不做任何事情
    if (idx <= 0) then return end

    -- 最右溢出, 或者地图节不存在, 就不做任何事情
    local mapSectionEntry = self._mapSections[idx]
    if (not mapSectionEntry) then return end

    -- 已经初始化了, 不做任何事情
    if (mapSectionEntry.inited) then return end
    mapSectionEntry.inited = true

    -- 初始化中央滚动图
    local mapSection = UI.Image:create()
    mapSection:init("ui_dungeon_banner_bg.png")
    mapSection:centerLeft((idx - 1) * (LV_SELECT_MAP_SECTION_WIDTH)) -- i - 1 填补最左拖动
    self._scrollContentLayout:addChild(mapSection)
    mapSectionEntry.mapSection = mapSection

    -- 初始化图标
    if (not mapSectionEntry.icons) then mapSectionEntry.icons = {} end
    local sectionStartLv = (idx - 1) * LV_SELECT_LV_PER_SECTION
    local ICON_POS_IN_SECTION = {
        {x = -467, y = -120},
        {x = -345, y = 122},
        {x = -105, y = 44},
        {x = 32, y = -97},
        {x = 315, y = -155},
        {x = 209, y = 172},
        {x = 517, y = -88},
    }
    for i,v in ipairs(ICON_POS_IN_SECTION) do
        local curLv = sectionStartLv + (i - 1) * LV_SELECT_LV_PER_ICON + 1
        local icon = nil

        -- 未解锁图标
        icon = self:createIcon(v.x, v.y, "idle1")
        icon:setTouchEnable(true)
        icon:addEventListener(UIEvent.COMPONENT_CLICK, icon, function(icon)
            self:setSelectedLv(curLv)
        end)
        icon:setTouchEnable(false)
        icon:setSwallowTouches(false)
        icon:setTouchClipNode(self._touchClipNode)
        if curLv > self.maxLimitLevel - 5 + 1 then
            icon:hide()
        end
        
        -- 加入地图
        mapSectionEntry.mapSection:addChild(icon)
        table.insert(mapSectionEntry.icons, icon)

        -- 数字
        local number = self:getStyledNumberNode(curLv, icon._width - 50)
        number:center(1, -10)
        number:setName("number")
        number:hide()
        icon:addChild(number)

        -- 把图标存入列表
        if (not self._lvIcons) then self._lvIcons = {} end
        self._lvIcons[curLv] = icon
    end

    -- 初始化云
    if (not mapSectionEntry.clouds) then mapSectionEntry.clouds = {} end

    if self.realMaxLevel >= self.maxLimitLevel then
        return
    end

    local CLOUD_POS_IN_SECTION = {
        {x = -764, y = -200},
        {x = -525, y = 50},
        {x = -285, y = -47},
        {x = 0, y = 212},
        {x = 70, y = -205},
        {x = 325, y = 133},
    }
    for i,v in ipairs(CLOUD_POS_IN_SECTION) do
        local cloud = UI.Animation:create()
        cloud:init("effect_ui_town_stageselect_dungeon_cloud.json", "effect_ui_town_stageselect_dungeon_cloud.atlas")
        cloud:center(v.x, v.y)
        cloud:setName("cloud"..tostring(i))
        cloud:setAnimation("map" .. i .. "_idle", false)
        mapSectionEntry.mapSection:addChild(cloud)
        table.insert(mapSectionEntry.clouds, cloud)
    end
end

function DungeonGuardMap:setCloudStateForMapSection(idx)
    -- 最左溢出不做任何事情
    if (idx <= 0) then return end

    -- 最右溢出, 或者地图节不存在, 就不做任何事情
    local mapSectionEntry = self._mapSections[idx]
    if (not mapSectionEntry or not mapSectionEntry.clouds) then return end

    -- 计算地图节内指针位置
    local sectionStartLv = (idx - 1) * LV_SELECT_LV_PER_SECTION
    local sectionDeltaLv = self._lvSelectMaxLv - sectionStartLv

    for i,cloud in ipairs(mapSectionEntry.clouds) do
        if (sectionDeltaLv > (i - 3) * LV_SELECT_LV_PER_ICON) then
            if (cloud.__state ~= 1) then
                cloud.__state = 1
                cloud:setAnimation("map" .. i .. "_open", false)
            end
        else
            if (cloud.__state ~= 0) then
                cloud.__state = 0
                cloud:setAnimation("map" .. i .. "_idle", false)
            end
        end
    end
end

function DungeonGuardMap:setIconStateForMapSection(idx, cb)
    -- 最左溢出不做任何事情
    if (idx <= 0) then return end

    -- 最右溢出, 或者地图节不存在, 就不做任何事情
    local mapSectionEntry = self._mapSections[idx]
    if (not mapSectionEntry or not mapSectionEntry.icons) then return end

    local sectionStartLv = (idx - 1) * LV_SELECT_LV_PER_SECTION

    for i,icon in ipairs(mapSectionEntry.icons) do
        local number = icon:getChildByName("number")
        local function unlock()
            -- 已解锁图标
            icon:setAnimation("idle2", false)
            icon:setTouchEnable(true)

            -- 数字
            if (number) then number:show() end
        end

        local curLv = sectionStartLv + (i - 1) * LV_SELECT_LV_PER_ICON + 1
        local curLvDelta = self._lvSelectMaxLv - curLv
        local unlockMaxNum = 3 * LV_SELECT_LV_PER_ICON
        if (curLv > self._lvSelectMaxLv) then
            -- 1.未解锁
            if (icon.__state ~= 0) then
                icon.__state = 0
                -- 未解锁图标
                icon:setAnimation("idle1")
                icon:setTouchEnable(false)

                -- 数字
                if (number) then number:hide() end
            end
        elseif (self._oldMaxLv < self._lvSelectMaxLv and curLvDelta < math.min(self._lvSelectMaxLv - self._oldMaxLv, unlockMaxNum)) then
            -- 2.这次相对上次最大层数多走的大秘境层数 = 需要播放解锁动画的图标(最多unlockMaxNum个)
            if (icon.__state ~= 1) then
                icon.__state = 1

                performWithDelay(self, function()
                    icon:setAnimation("start1", false)
                    icon:addAnimation("showup", false)
                    icon:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
                        if event.animation == "showup" then
                            icon:setTouchEnable(true)
                            if (self._lvSelectMaxLv ~= curLv) then
                                unlock()
                            else
                                if (cb) then cb(true) end --如果是解锁事件, 回调传回true
                            end
                        end
                    end)
                end, (unlockMaxNum - curLvDelta) * 0.3 / LV_SELECT_LV_PER_ICON) -- unlockMaxNum - curLvDelta 永远不为负数, curLvDelta 小于 unlockMaxNum 才会进入此段
            end
        else
            -- 3.已解锁
            if (icon.__state ~= 1) then
                icon.__state = 1

                unlock()
                if (cb and self._lvSelectMaxLv == curLv) then cb(false) end --如果不是解锁事件, 回调传回false 
            end
        end
    end
end

-- 设置选取的关数(只有已解锁图标才注册了这个回调)
function DungeonGuardMap:setSelectedLv(lv, animated)
    local icon = self._lvIcons[lv]
    if (not icon) then
        return 
    end

    self:createSweepBtn(lv)

    -- 展现最高标识
    if self.maxLevelImg and not tolua.isnull(self.maxLevelImg) then
        self.maxLevelImg:removeFromParent()
    end
    if self.realMaxLevel >= self.maxLimitLevel and lv >= self.maxLimitLevel - 5 + 1 then
        self.maxLevelImg = UI.Image:create()
        self.maxLevelImg:init("ui_dungeon_top.png")
        self.maxLevelImg:center(-6, -74)
        self.maxLevelImg:setScale(1.3)
        icon:addChild(self.maxLevelImg, 10)
    end

    if (self._selectedIcon == icon) then
        icon:setAnimation("start3", false)
        return
    end
    if (animated == nil) then
        animated = true
    end

    -- 动画展现
    if (animated) then
        icon:setAnimation("start3", false)
        local number = icon:getChildByName("number")
        number:hide()
        if (self._selectedIcon) then
            self._selectedIcon:setAnimation("idle2")
            local prevNum = self._selectedIcon:getChildByName("number")
            prevNum:show()
        end
    end

    -- 更新参数
    self._selectedIcon = icon
    self.floorLevel = lv
    self:updateView()

    -- 回调选择
    if (self._selectCallback) then
        self._selectCallback(self.floorLevel)
    end
end

function DungeonGuardMap:createSweepBtn(lv)

    -- 先移除前一个展示
    if self.sweepLayer and not tolua.isnull(self.sweepLayer) then
        self.sweepLayer:removeFromParent()
    end

    -- 判断当前是否展示扫荡按钮
    if self._lvSelectMaxLv ~= lv or lv == 1 then
        return
    end

    local parent = self._lvIcons[lv]

    local weekNum = GameManager:getNowCurWeekDay()
    local curDayLimit = ConfigManager:getGeneralForKey("dungeonDailyLimit")
    local curDayLimitList = string.split(curDayLimit, ";")
    local curDayLimitNum = 0
    for _, curStr in pairs(curDayLimitList) do
        local strList = string.split(curStr, ",")
        if tonumber(strList[1]) == weekNum then
            curDayLimitNum = tonumber(strList[2])
        end
    end

    local pk = RoleDataManager:getMaster():getPK()
    local sweepGoodObj = GoodsDataManager:createLocalGoodsData(SWEEP_GOOD_ID)
    local sweepGoodNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, SWEEP_GOOD_ID) or 99
    sweepGoodObj:setNum(sweepGoodNum)
    local sweepGoodData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(
        pk,
        PublicDefine.PACKET_TYPE.PACKET_BAG, 
        GoodsDataManager:getGoodsTypeForGoodsID(SWEEP_GOOD_ID), 
        SWEEP_GOOD_ID,
        false
    )

    local sweepDungeonCnt = curDayLimitNum - MasterDataManager:getSweepDungeonCnt()
    if sweepDungeonCnt < 0 then
        sweepDungeonCnt = 0
    end

    self.sweepLayer = UI.Layout:create()
    self.sweepLayer:init()
    self.sweepLayer:centerBottom(-56, -3)
    self.sweepLayer:setScale(1.3)
    self.sweepLayer:enableAutoWidth()
    self.sweepLayer:enableAutoHeight()
    parent:addChild(self.sweepLayer, -10)

    local groundBg = UI.Image:create()
    groundBg:init("ui_dungeon_clean_bg_2.png")
    groundBg:centerBottom(0, 2)
    self.sweepLayer:addChild(groundBg)

    local leftLine = UI.Image:create()
    leftLine:init("ui_dungeon_clean_bg_1.png")
    leftLine:center(-40, -64)
    self.sweepLayer:addChild(leftLine, -10)

    local rightLine = UI.Image:create()
    rightLine:init("ui_dungeon_clean_bg_1.png")
    rightLine:center(36, -64)
    rightLine:setRotationSkewX(180)
    self.sweepLayer:addChild(rightLine, -10)

    local btnBg = UI.Image:create()
    btnBg:init("ui_dungeon_clean_btn_box.png")
    btnBg:center(10, -36)
    self.sweepLayer:addChild(btnBg)

    local sweepbtn = UI.Button:create()
    sweepbtn:init("ui_dungeon_clean_btn_0.png","ui_dungeon_clean_btn_1.png","ui_dungeon_clean_btn_2.png")
    sweepbtn:leftBottom(8, 6)
    -- sweepbtn._text:setWidth(152)
    -- sweepbtn._text:setTextCenter()
    -- sweepbtn._text:setLineSpacing(-8)
    sweepbtn:setTextOffset(6, -1)
    sweepbtn:setText(UI.TEXT_1324354)
    sweepbtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    sweepbtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:clickSweepBtn(lv, sweepGoodObj, sweepDungeonCnt)
    end)
    sweepbtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function(self)
        if sweepDungeonCnt <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1324351)
            return
        end

        if sweepGoodData and sweepGoodData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_1324352)
            return
        end

        if sweepGoodNum <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1324353)
            return
        end
    end)
    btnBg:addChild(sweepbtn)
    if sweepDungeonCnt <= 0 or sweepGoodNum <= 0 or (sweepGoodData and sweepGoodData:getIsLock()) then
        sweepbtn:disable()
    end

    local iconBg = UI.Image:create()
    iconBg:init("ui_dungeon_clean_key_box.png")
    iconBg:leftBottom(-18, -4)
    btnBg:addChild(iconBg)

    local sweepIcon = UI.Image:create()
    sweepIcon:init(sweepGoodObj:getSmallIconName())
    sweepIcon:center()
    iconBg:addChild(sweepIcon, 10)

    local sweepNum = UI.Text:create()
    sweepNum:init(tostring(sweepGoodNum), UI.FONT_STANDARD, UI.FONT_SIZE_08PX, UI.FONT_COLOR_255_255_255)
    sweepNum:center(13, 10)
    iconBg:addChild(sweepNum, 20)

    local descStr = string.format(UI.TEXT_1324350.."%d/%d", sweepDungeonCnt, curDayLimitNum)
    local descText = UI.Text:create()
    descText:init(descStr, UI.FONT_STANDARD, UI.FONT_SIZE_10PX, UI.FONT_COLOR_255_255_255)
    descText:centerBottom(2)
    groundBg:addChild(descText)
    if sweepDungeonCnt == 0 then
        descText:setFontColor({r = 205, g = 56, b = 32})
    end
end

function DungeonGuardMap:updateSweepNum()
    self:createSweepBtn(self.floorLevel)
end

function DungeonGuardMap:showSweepReward(data)
    if data.result ~= "ReceiveDungeonRewardResult_Succeed" then
        UI.ScrollBar:createByText(UI.TEXT_1110372)
        return
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE, true)
    local AudioUtil = require ("app.utils.AudioUtil")
    AudioUtil:playVictorySound()
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, nil, UI.RewardType.REWARD_DUNGEON)
end

function DungeonGuardMap:clickSweepBtn(lv, sweepGoodObj, sweepDungeonCnt)
    -- 兼容达到最大层后的实际扫荡层数
    local realLv = self.realMaxLevel >= self.maxLimitLevel and self.maxLimitLevel or lv

    require "app.ui.common.Dialog.slidingNumDialog"
    local slidingNumDialog = UI.slidingNumDialog:showItemTile(sweepGoodObj, 1, sweepDungeonCnt, function (sweepNum)
        local cardTips =
        UI.ConfirmDialog.show(
        "",
        function()
            -- 检测赛季时间
            local seasonData = MasterDataManager:getCurrentSeasonData()
            if seasonData == nil or seasonData.open == false then
                UI.ScrollBar:createByText(UI.TEXT_110043)
                return
            end

            UI.WaitingLayer:showWaiting(true, nil, 5)
            Net.NetRoleSystem:sendSweepDungeonMessage(realLv, sweepNum)
        end,
        function()
        end)

        local descStr = string.format(UI.TEXT_1324355, realLv - 5, realLv - 1)
        local descText = UI.Text:create()
        descText:init(descStr, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        descText:setWidth(352)
        descText:setTextCenter()
        descText:setLineSpacing(-6)
        descText:centerBottom(76, 0)
        cardTips.ConfirmDialogModel.contentBg:addChild(descText, 10)

        local descConfirm = UI.Text:create()
        descConfirm:init(string.format(UI.TEXT_1324356, sweepNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        descText:setWidth(352)
        descText:setTextCenter()
        descText:setLineSpacing(-6)
        descConfirm:centerBottom(24, 0)
        cardTips.ConfirmDialogModel.contentBg:addChild(descConfirm, 10)
    end)

    UI.UIManager:getRootNode():addChild(slidingNumDialog, 10000)
end

-- 创建一个关数图标
function DungeonGuardMap:createIcon(centerX, centerY, defaultAni)
    local icon = UI.Animation:create()
    icon:init("effect_ui_town_stageselect_dungeon_icon.json", "effect_ui_town_stageselect_dungeon_icon.atlas")
    icon:setSize(100, 100)
    icon:center(centerX, centerY)
    icon:setAnimation(defaultAni)
    return icon
end

-- 获取一个节点, 上面运载了多位兼容的图片数字
function DungeonGuardMap:getStyledNumberNode(num, widthLimit)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()

    while (num ~= 0) do
        local digit = num % 10
        num = math.floor(num / 10)

        local styledDigit = UI.Image:create()
        styledDigit:init("ui_dungeon_number_" .. tostring(digit) .. ".png")
        styledDigit:floatRight(0)
        layout:addComponent(styledDigit)
    end

    local width, height = layout:getSize()
    if (widthLimit < 0 ) then widthLimit = 0 end
    if (width > widthLimit) then
        layout:setScale(widthLimit / width)
    end

    return layout
end

-- 选择关卡回调
function DungeonGuardMap:setSelectCallback(cb)
    self._selectCallback = cb
end

-- 播放进入动画
function DungeonGuardMap:playEnterAni()
    if (not self._selectedIcon) then return end

    self._selectedIcon:setAnimation("start2")
end


