-- LevelSelect.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:匹配中 
require("utils.ObserverVariable")
require("app.ui.town.levelSelect.LevelSelectDifficulty")
require("app.ui.town.levelSelect.LevelSelectTeam")
require("app.net.NetTeamSystem")
require("app.ui.UIManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

UI = UI or {}

local LevelSelectReady = class("LevelSelectReady", UI.HWBtnComponent)
UI.LevelSelectReady = LevelSelectReady
local winSize = cc.Director:getInstance():getWinSize()

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_teammate.plist",
}


function LevelSelectReady:ctor(fromType)
    LevelSelectReady.super.ctor(
    self,UIType.LEVEL_SELECT_READY,
    COM_RES_LIST,
    winSize.width,
    winSize.height
    )
    self.fromType = fromType
    self.rootLayer = nil;           --root节点
    self:setTouchEnable(true);
    self:setSwallowTouches(false);
    self:registerListener();
    self:init();
    TeamDataManager:setReadyState(true)
end


function LevelSelectReady:dtor()
    LevelSelectReady.super.dtor(self)

    self:unRegisterListener();
end

-- public:
-- 初始化
function LevelSelectReady:init()
    LevelSelectReady.super.init(self)
end


-- 模版函数：初始化组建的视图
function LevelSelectReady:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_information_banner_line.png")
    bg:centerUp(8)
    self:addChild(bg)

    local text = UI.Text:create()
    text:init(UI.TEXT_110013, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_215_185_155)
    text:center()
    bg:addChild(text)


    local btnClose = UI.Button:create()
    btnClose:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png", "ui_btn_button_cancel_2.png")
    btnClose:centerRight(36)
    btnClose:setName("close")
    bg:addChild(btnClose)
    btnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.onChanel)
    self.btnClose = btnClose
    -- btnClose:enableDebugDraw()
    -- if self.fromType == Game.TeamType.FromActivity  then
    --     text:setText(UI.TEXT_1212093)
    -- end
end

function LevelSelectReady:onChanel()
    if self.fromType == Game.TeamType.FromActivity  then
        Net.NetActivitySystem:requestCancleMacth()
    else
        Net.NetTeamSystem:requestCancelMatch()
    end
    self.btnClose:setVisible(false)
end

-- 模版函数：更新组建的视图
function LevelSelectReady:onUpdateView()

end

function LevelSelectReady:responseMatch()
    self:close()
end

-- 注册监听事件
function LevelSelectReady:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_RESPONSE_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_CLINE_NOTIFY_CANCEL_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.responseMatch)
end


-- 注销监听事件
function LevelSelectReady:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_RESPONSE_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_CLINE_NOTIFY_CANCEL_MATCH, self, self.responseMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.responseMatch)
end



