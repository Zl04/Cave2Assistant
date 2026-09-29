-- WorldBossTopBar.lua
-- Author:lzm
-- 2019年5月31日
-- Using:开战提示
require("app.ui.UIManager")

UI = UI or {}

local WorldBossTopBar = class("WorldBossTopBar", UI.HWBtnComponent)
UI.WorldBossTopBar = WorldBossTopBar
local winSize = cc.Director:getInstance():getWinSize()

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_teammate.plist",
    "ui_general_shopping.plist",
}


function WorldBossTopBar:ctor()
    WorldBossTopBar.super.ctor(
    self,UIType.LEVEL_SELECT_READY,
    COM_RES_LIST,
    winSize.width,
    winSize.height
    )

    self.rootLayer = nil;           --root节点
    self:setTouchEnable(true);
    self:setSwallowTouches(false);
    self:registerListener();
    self:init();
end


function WorldBossTopBar:dtor()
    WorldBossTopBar.super.dtor(self)

    self:unRegisterListener();
end

-- public:
-- 初始化
function WorldBossTopBar:init()
    WorldBossTopBar.super.init(self)
end


-- 模版函数：初始化组建的视图
function WorldBossTopBar:onInitView()
    local stateBox = mvc.worldBossModel:getStateBox()
    local roomData = mvc.worldBossModel:getRoomData()
    if stateBox.stateType ~= 2 and stateBox.stateType ~= 4 then
        self:close()
        return
    end

    if not roomData.roomNo or roomData.roomNo == 0 then
        local bgLayout = UI.Layout:create();
        bgLayout:init()
        bgLayout:setSize(750, 33)
        bgLayout:centerUp(8)

        local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_line.png")
        bg:setContentSize(750, 33)
        bg:setCapInsets(CCRectMake(250,16,1,1))
        bg:setPosition(375, 0)
        bgLayout:addChild(bg)

        -- local bg = UI.Image:create()
        -- bg:init("ui_information_banner_line.png")
        -- bg:centerUp(8)
        self:addChild(bgLayout)
        self.bg = bgLayout
    
        local text = UI.Text:create()
        text:init(UI.TEXT_1212659, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
        text:center()
        bg:addChild(text)
    
        local btnClose = UI.Button:create()
        btnClose:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png", "ui_btn_button_cancel_2.png")
        btnClose:centerRight(5)
        btnClose:setName("close")
        bg:addChild(btnClose)
        btnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.closeMe)
        self.btnClose = btnClose
    end

    self:addWorldBossRoom()

    if roomData.roomNo and roomData.roomNo > 0 then
        self:showMiniRoomBtn()
    end
end

function WorldBossTopBar:showMiniRoomBtn()
    self.worldbossRoomLayout:centerUp(15)
    if self.bg then
        self.bg:hide()
    end
end

function WorldBossTopBar:hideMiniRoomBtn()
    self.worldbossRoomLayout:centerUp(-100)
end

function WorldBossTopBar:addWorldBossRoom()
    local function openWorldBossView()
        if mvc.worldBossModel:checkBattleAvailable() then
            local stateData = mvc.worldBossModel:getStateData()
            local roomData = mvc.worldBossModel:getRoomData()
            if roomData.roomNo or roomData.roomNo > 0 then
                mvc.openPanel("WorldBoss", "WorldBossRoom")
                self:hideMiniRoomBtn()
            end
        else
            UI.ScrollBar:createByText(UI.TEXT_1212646)
        end
    end

    local worldbossRoomLayout = UI.Layout:create()
    worldbossRoomLayout:init()
    worldbossRoomLayout:setTouchEnable(true)
    worldbossRoomLayout:setSize(210, 40)
    worldbossRoomLayout:centerUp(-100)
    worldbossRoomLayout:setName("worldbossRoomLayout")
    -- worldbossRoomLayout:hide()
    self.worldbossRoomLayout = worldbossRoomLayout
    self:addChild(worldbossRoomLayout)
    worldbossRoomLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        openWorldBossView()
    end)

    local maxImg = UI.Image:create()
    maxImg:init("ui_boss_minimize_paper.png")
    maxImg:centerLeft(-90)
    worldbossRoomLayout:addChild(maxImg)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1212661, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleTxt:centerUp(7)
    worldbossRoomLayout:addChild(titleTxt)

    local maxBtn = UI.Button:create();
    maxBtn:init("ui_boss_btn_minimize_0.png","ui_boss_btn_minimize_1.png","ui_boss_btn_minimize_0.png");
    maxBtn:rightBottom(-40, 2);
    maxBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        openWorldBossView()
    end)
    worldbossRoomLayout:addChild(maxBtn)
end

function WorldBossTopBar:closeMe()
    self:close()
end

-- 模版函数：更新组建的视图
function WorldBossTopBar:onUpdateView()

end


-- 注册监听事件
function WorldBossTopBar:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM, self, self.showMiniRoomBtn)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM, self, self.hideMiniRoomBtn)
    
end


-- 注销监听事件
function WorldBossTopBar:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM, self, self.showMiniRoomBtn)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM, self, self.hideMiniRoomBtn)
end
