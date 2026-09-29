-- BetTopBar.lua
-- Author:ping.zheng
-- 2019年5月31日
-- Using:投注提示
require("app.ui.UIManager")

UI = UI or {}

local BetTopBar = class("BetTopBar", UI.HWBtnComponent)
UI.BetTopBar = BetTopBar
local winSize = cc.Director:getInstance():getWinSize()
local scheduler = cc.Director:getInstance():getScheduler()

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_teammate.plist",
    "ui_general_shopping.plist",
}


function BetTopBar:ctor(betBarType)
    BetTopBar.super.ctor(
    self,UIType.LEVEL_SELECT_READY,
    COM_RES_LIST,
    winSize.width,
    winSize.height
)

self.betBarType = betBarType
self.rootLayer = nil;           --root节点
self:setTouchEnable(true);
self:setSwallowTouches(false);
self:registerListener();
self:init();

mvc.betModel:setBetBarShowStatus(self.betBarType, true)
end


function BetTopBar:dtor()
    BetTopBar.super.dtor(self)
    mvc.betModel:setBetBarShowStatus(self.betBarType, false)
    self:unRegisterListener();

    reload_script_file("app.modules.bet.BetTopBar")
end

-- public:
-- 初始化
function BetTopBar:init()
    BetTopBar.super.init(self)
end

function BetTopBar:updateType(betBarType)
    mvc.betModel:setBetBarShowStatus(self.betBarType, false)
    self.betBarType = betBarType
    mvc.betModel:setBetBarShowStatus(self.betBarType, true)

    self:updateView()
end

-- 模版函数：初始化组建的视图
function BetTopBar:onInitView()
    local bgLayout = UI.Layout:create();
    bgLayout:init()
    bgLayout:setSize(750, 33)
    bgLayout:centerUp(8)
    
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_line.png")
    bg:setContentSize(750, 33)
    bg:setCapInsets(CCRectMake(250,16,1,1))
    bg:setPosition(375, 0)
    bgLayout:addChild(bg)
    
    self:addChild(bgLayout)
    self.bg = bgLayout
    
    local text = UI.Text:create()
    text:init(UI.TEXT_227611, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    text:center()
    bg:addChild(text)
    self._text = text


    -- local btnStart = UI.Button:create()
    -- btnStart:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png", "ui_btn_button_cancel_2.png")
    -- btnStart:centerRight(55)
    -- btnStart:setName("btnStart")
    -- btnStart:setText(UI.TEXT_227612)
    -- bg:addChild(btnStart)
    -- btnStart:addEventListener(UIEvent.BUTTON_CLICK,self,self.clickToBet)
    
    local btnClose = UI.Button:create()
    btnClose:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_1.png", "ui_btn_button_cancel_2.png")
    btnClose:centerRight(5)
    btnClose:setName("close")
    bg:addChild(btnClose)
    btnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.closeMe)
    self.btnClose = btnClose
    -- btnClose:setVisible(false)

    self:updateView()
end

function BetTopBar:update()
    print("BetTopBar:update")
end

function BetTopBar:clickToBet()
    print("BetTopBar:clickToBet")
    mvc.openPanel("Bet", "BetMain")

    -- if(SceneManager:getInstance():isInFightScene()) then 
    --     -- 返回城镇
    --     UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_227613, function(isSelect)
    --         Avalon.MessageCenter:notice(
    --             AvalonMessage.MC_UI_BACK_TOWN_UI,
    --             BACK_TOWN_TYPE.BACK_TOWN_TYPE_SETTING,
    --             function(closeWin)
    --                 if (not tolua.isnull(self)) then
    --                     if (closeWin) then
    --                         self:closeWin()
    --                     end
    --                 end
    --             end
    --         )
    --     end, function(isSelect)

    --     end, nil, nil, true)
    -- elseif ~SceneManager:getInstance():isPort() then
    --     -- 跳转到大航海场景
    --     local GameDataManager = require("app.game.GameDataManager")
    --     if GameDataManager:getInstance():getIsJoinGuild() then
    --         Net.NetBigSailSystem:reqEnterBigSailScene(RoleDataManager:getMasterPK())
    --     else
    --         UI.ScrollBar:createByText(UI.TEXT_226173)
    --     end
    -- else
    --     mvc.openPanel("Bet", "BetMain")
    -- end
end

function BetTopBar:closeMe()
    mvc.betModel:setBetBarStatus(self.betBarType, false)
    self:close()
end

-- 模版函数：更新组建的视图
function BetTopBar:onUpdateView()
    print("BetTopBar:onUpdateView ".. self.betBarType.. "  "..UI.BET_BAR_TYPE.BET)
    if(self.betBarType == UI.BET_BAR_TYPE.BET) then
        self._text:setText(UI.TEXT_227611)
    elseif (self.betBarType == UI.BET_BAR_TYPE.RALLY_GAME) then
        self._text:setText(UI.TEXT_227634)
    end
end


-- 注册监听事件
function BetTopBar:registerListener()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM, self, self.showMiniRoomBtn)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM, self, self.hideMiniRoomBtn)
    
    
end

-- 注销监听事件
function BetTopBar:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM, self, self.showMiniRoomBtn)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM, self, self.hideMiniRoomBtn)

    -- scheduler:unscheduleScriptEntry(self.schedulerID)
end