-- LevelSelect.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡难度选择 
require("utils.ObserverVariable")
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()
local SwitchCavePannel = class("SwitchCavePannel", UI.HWBtnComponent)
UI.SwitchCavePannel = SwitchCavePannel
local CELL_SIZE = cc.size(353, 310)

-- 关卡难度选择资源
local COM_RES_LIST = {
}

local SHOW_CAVE_MODE = {
    [Game.LevelSelectLayerType.Normal_Plot] = {
        text = UI.TEXT_110101,
        caveMode = PublicDefine.CAVE_MODE.MODE_NORMAL,
    },
    [Game.LevelSelectLayerType.Titan_Road] = {
        text = UI.TEXT_224400,
        caveMode = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD,
    },
}

local SHOW_DESERT_CAVE_MODE = {
    [Game.LevelSelectLayerType.Desert_Eye] = {
        text = UI.TEXT_1212801,
        caveMode = PublicDefine.CAVE_MODE.MODE_DESERT_EYES,
    },
    [Game.LevelSelectLayerType.Dried_Spring] = {
        text = UI.TEXT_225000,
        caveMode = PublicDefine.CAVE_MODE.MODE_DRIED_SPRING,
    },
}

-- local  bgSpineRes = {
--     [SHOW_CAVE_MODE[1]] = "effect_ui_town_selectfloor_ordinary_bu",
--     [SHOW_CAVE_MODE[2]] = "effect_ui_town_selectfloor_hero_bu",
-- }

-- local  fontColorList  = {
--     [SHOW_CAVE_MODE[1]] = {title = UI.FONT_COLOR_157_221_231, desc = UI.FONT_COLOR_116_173_221, param = UI.FONT_COLOR_69_153_223, point = cc.c3b(69, 153, 223)},
--     [SHOW_CAVE_MODE[2]] = {title = UI.FONT_COLOR_247_172_53, desc = UI.FONT_COLOR_229_151_58, param = UI.FONT_COLOR_223_117_22, point = cc.c3b(223, 117, 22)},

-- }
local SHOW_CAVE_MODE_SIZE = #SHOW_CAVE_MODE

function SwitchCavePannel:ctor(layerType)
    SwitchCavePannel.super.ctor(
    self,UIType.LEVEL_SELECT_DIFFICULTY,
    COM_RES_LIST,
    winSize.width,  winSize.height
    -- 825,409
    )
    -- self.selectCallback = selectCallback
    self.rootLayer = nil;       --root节点
    self._showingPanelIdx = layerType or nil
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener()
end


function SwitchCavePannel:dtor()
    self.desLabeList = {}
    self:unRegisterListener();
    SwitchCavePannel.super.dtor(self)
    reload_script_file("app.ui.town.levelSelect.SwitchCavePannel")
end

-- public:
-- 初始化
function SwitchCavePannel:init()
    SwitchCavePannel.super.init(self)
end


--难度相应事件
-- function SwitchCavePannel:onSelectDifficulty(sender)
--     print("SwitchCavePannel:onSelectDifficulty",sender:getTag())
--     -- LevelSelectUtil:getInstance():setDifficulty(sender:getTag())
--     LevelSelectUtil:getInstance():setCaveMode(sender:getTag())
--     Avalon.Scheduler:scheduleUpdateOnce(self, self.close, 0.2)
--     if self.selectCallback then
--         self.selectCallback(sender:getTag())
--     end
-- end

-- 模版函数：初始化组建的视图
function SwitchCavePannel:onInitView()
    -- self:addColorBG()
    local bgLayer = cc.LayerColor:create(cc.c4b(0,0,0,160));
    bgLayer:setContentSize(cc.size(winSize.width,winSize.height))
    bgLayer:setPosition(cc.p(0,0))
    self:addChild(bgLayer)

    self.rootLayer = UI.Layout:create();
    self.rootLayer:init()
    self.rootLayer:setSize(CELL_SIZE.width, CELL_SIZE.height)
    self.rootLayer:center() 
    self.rootLayer:setTouchEnable(true)   
    self.rootLayer:setInterceptTouches(true);
    self:addChild(self.rootLayer)
    -- self.rootLayer:enableDebugDraw()

    local bg = UI.Image:create()
    bg:init("ui_reincarnation_role_popups.png")
    bg:center()
    self.rootLayer:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_224404, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_212_202_198)
    title:centerUp(23)
    bg:addChild(title)

    self:initSwitchCaveBtn()
    -- self:setOpenState();
    -- self:setSelectState(LevelSelectUtil:getInstance().mCaveMode)
end

function SwitchCavePannel:initSwitchCaveBtn()
    self._tabList = {}
    local tabLayout = UI.Layout:create();
    tabLayout:init()
    tabLayout:setSize(210, CELL_SIZE.height-180)
    tabLayout:centerUp(70) 
    self.rootLayer:addChild(tabLayout)

    local showCaveMode = self:isDesert() and SHOW_DESERT_CAVE_MODE or SHOW_CAVE_MODE
    for k, v in pairs(showCaveMode) do
        local tab = UI.Button:create()
        tab:init("ui_btn_screening_0.png", "ui_btn_screening_1.png", "ui_btn_screening_0.png")
        tab:floatBottom(20)
        tab:closeClickScale()
        tab:setText(v.text)
        tab:setTag(k)
        tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        tab:addEventListener(
            UIEvent.BUTTON_CLICK,
            self,
            function(self)
                self:showTabByIndex(tab:getTag(), v)
            end
        )

        -- 加入列表
        tabLayout:addComponent(tab)
        table.insert(self._tabList, tab)
    end

    self:updateTabList()
end

function SwitchCavePannel:showTabByIndex(idx, data)
    print("showTabByIndex:", self._showingPanelIdx, idx)
    -- 展现标签
    for i, w in ipairs(self._tabList) do
        if (w:getTag() ~= idx) then
            w:release()
        else
            w:press(false)
        end
    end

    -- 过滤相同标签点击逻辑
    if (self._showingPanelIdx == idx) then
        return
    end

    -- 显示选择的页面
    -- local panelToShow = self:getOrBuildPanel(idx)
    -- self:showPanel(panelToShow)
    if not self:isDesert() then
        LevelSelectUtil:getInstance():setCaveMode(data.caveMode)
        LevelSelectUtil:getInstance():setSwitchCaveLayerType(idx)
    else
        -- LevelSelectUtil:getInstance():setCaveMode(data.caveMode)
        LevelSelectUtil:getInstance():setSwitchDesertLayerType(idx)
    end
    
    self._showingPanelIdx = idx
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CAVE_SWITCH_CAVE_RESET_DATA, idx)
    self:close()
end

function SwitchCavePannel:updateTabList()
    local curSelectTab = self:isDesert() and LevelSelectUtil:getInstance():getSwitchDesertLayerType() or LevelSelectUtil:getInstance():getSwitchCaveLayerType()
    -- 展现标签
    for i, w in ipairs(self._tabList) do
        if (w:getTag() ~= curSelectTab) then
            w:release()
        else
            w:press(false)
        end
    end
end

-- 模版函数：更新组建的视图
function SwitchCavePannel:onUpdateView()

end

function SwitchCavePannel:isDesert()
    local isDesert = false
    if self._showingPanelIdx == Game.LevelSelectLayerType.Normal_Plot 
    or self._showingPanelIdx == Game.LevelSelectLayerType.Titan_Road then
        isDesert = false
    elseif self._showingPanelIdx == Game.LevelSelectLayerType.Desert_Eye
    or self._showingPanelIdx == Game.LevelSelectLayerType.Dried_Spring then
        isDesert = true 
    end 
    return isDesert
end

-- 点击外部区域的处理器
function SwitchCavePannel:onTouchDialogOutsizeHandler(tips, touchPosition)
    Avalon.AudioManager:playSound("1503")
    self:close()
end

-- 注册监听事件
function SwitchCavePannel:registerListener()
        --监听窗口外关闭事件
    self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end


-- 注销监听事件
function SwitchCavePannel:unRegisterListener()
end



