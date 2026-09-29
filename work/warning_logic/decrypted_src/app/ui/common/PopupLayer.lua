-- PopupLayer.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:横向拓展框

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local SdkManager = require "app.game.SdkManager"
require "app.ui.iapshop.IapShopMonthCardLayer"
require "app.ui.UIDefine"

UI = UI or {}
local PopupLayer = class("PopupLayer", UI.HWBtnComponent)
UI.PopupLayer = PopupLayer

local COM_RES_LIST = {
    "ui_town_maincity.plist"
}

local CELL_WIDTH = 55
local CELL_HEIGHT = 60
local EXTREA_WIDTH = 40
local EXTREA_SCALE = 5
local COMPONENT_WIDTH = 75 + 72
local COMPONENT_HEIGHT = 75
local unlockType = PublicDefine.UnlockFunctionType 

function PopupLayer:ctor(isInTown)
    self._isInTown = isInTown
    print("PopupLayer:ctor")
    PopupLayer.super.ctor(
        self, 603,
        COM_RES_LIST,
        COMPONENT_WIDTH,
        COMPONENT_HEIGHT
    )
    self.rootLayer = nil           --root节点
    self:init()
end

-- 析构
function PopupLayer:dtor()
    PopupLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function PopupLayer:init()
    PopupLayer.super.init(self)
    self:registerListener()
end


-- 模版函数：初始化组建的视图
function PopupLayer:onInitView()
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(COMPONENT_WIDTH, COMPONENT_HEIGHT)
    self:addChild(self.rootLayer)

    -- 录屏按钮
    self._screenRecordButton = self:createScreenRecordButton()
    self._screenRecordButton:rightBottom(-CELL_WIDTH, 0)
    self._screenRecordButton:setVisible(false)
    self.rootLayer:addChild(self._screenRecordButton)

    -- 好友按键
    self._friendButton = UI.Button:create()
    self._friendButton:init("ui_main_button_friends_0.png", "ui_main_button_friends_1.png", "ui_main_button_friends_0.png")
    self._friendButton:rightBottom(-CELL_WIDTH, 0)
    self._friendButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onFriends)
    self._friendButton:setVisible(false)
    self.rootLayer:addChild(self._friendButton)

    -- 好友小红点
    self._friendStatus = AvalonUtil.createRedPoint(self._friendButton, 5, 9, 101)

    -- 公会
    self._guildButton = UI.Button:create()
    self._guildButton:init("ui_main_button_guild_0.png", "ui_main_button_guild_1.png", "ui_main_button_guild_0.png")
    self._guildButton:rightBottom(-CELL_WIDTH, 0)
    self._guildButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onGuild)
    self._guildButton:setVisible(false)
    self.rootLayer:addChild(self._guildButton)

    -- 公会小红点
    self._guildStatus = AvalonUtil.createRedPoint(self._guildButton, 5, 9, 101)

    -- 内挂提示
    self._expeditionButton = UI.Button:create(UIType.EXPEDITION_BUTTON)
    self._expeditionButton:init("ui_main_button_explore_0.png", "ui_main_button_explore_1.png", "ui_main_button_explore_0.png")
    self._expeditionButton:rightBottom(-CELL_WIDTH, -4)
    self._expeditionButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onExpedition)
    self._expeditionButton:setVisible(false)
    self.rootLayer:addChild(self._expeditionButton)
    self._expeditionStatus = AvalonUtil.createRedPoint(self._expeditionButton, 5, 9, 101)
    
    --战斗通行证按钮
    local battlePassButton = UI.Button:create()
    battlePassButton:init("ui_main_button_passcheck_0.png","ui_main_button_passcheck_1.png", "ui_main_button_passcheck_0.png")
    battlePassButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.openPanel("BattlePass", "BattlePass")
    end)
    self.rootLayer:addChild(battlePassButton, UI_ZORDER.MAIN_UI + 1)
    self._battlePassButton = battlePassButton
    self._battlePassStatus = AvalonUtil.createRedPoint(self._battlePassButton, 5, 9, 101)

    -- 师徒
    require "app.modules.apprenticeship.ApprenticeshipLayer"
    self._apprenticeshipLayer = UI.ApprenticeshipLayer:create()
    self._apprenticeshipLayer:init()
    self._apprenticeshipLayer:rightBottom(-CELL_WIDTH, 0)
    self.rootLayer:addChild(self._apprenticeshipLayer)

    -- 纪念品
    self._souvenirButton = UI.Button:create(UIType.EXPEDITION_BUTTON)
    self._souvenirButton:init("ui_maincity_btn2_souvenir.png", "ui_maincity_btn2_souvenir_selected.png", "ui_maincity_btn2_souvenir.png")
    self._souvenirButton:rightBottom(-CELL_WIDTH, 0)
    self._souvenirButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.openPanel("Souvenir", "Souvenir")
    end)
    self._souvenirButton:setVisible(false)
    self.rootLayer:addChild(self._souvenirButton)
    self._souvenirStatus = AvalonUtil.createRedPoint(self._souvenirButton, 5, 9, 101)

    -- 神迹祈福
    -- mvc.openPanel("Miracle", "Miracle")
    self._miracleBtn = UI.Button:create(UIType.EXPEDITION_BUTTON)
    self._miracleBtn:init("ui_maincity_btn2_prayer.png", "ui_maincity_btn2_prayer_selected.png", "ui_maincity_btn2_prayer.png")
    self._miracleBtn:rightBottom(-CELL_WIDTH, -4)
    self._miracleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onMiracle)
    self._miracleBtn:setVisible(false)
    self.rootLayer:addChild(self._miracleBtn)
    self._miracleStatus = AvalonUtil.createRedPoint(self._miracleBtn, 5, 9, 101)

    -- 刷新显示
    if Game.FriendManager:getInstance():isNewFlagOfAll() then
        self:refreshNewFriendFlag(false)
    end
    self:refreshAllNewStatus()
    self:refreshBtnState()
end

-- 模版函数：更新组建的视图
function PopupLayer:onUpdateView()
end

function PopupLayer:onExpedition()
    -- self._expeditionButton
    local data = nil
    if(SceneManager:getInstance():isInFightScene()) then 
        data = {}
        local GameMapManager = require("app.game.GameMapManager")
        data.mode = GameMapManager:getInstance():getModel()
        data.level = GameMapManager:getInstance():getLevel()
    end
    mvc.send("Open_Panel","Expedition", nil, data)
end

function PopupLayer:onMiracle()
    mvc.openPanel("Miracle", "Miracle")
end

--开启好友
function PopupLayer:onFriends()
    if self.run or self.bOpen == false then
        return
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FRIEND_MAIN)
    self._friendButton:removeChildByName("REDPOINT")
    -- self.btnOpenOrClose:removeChildByName("REDPOINT")

    Game.FunctionUnlockManager:getInstance():removeNewFlag(unlockType.UnlockFunctionType_FriendShip)
end

--开启公会
function PopupLayer:onGuild()
    if self.run or self.bOpen == false then
        return
    end
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER)
    else
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN)
    end
    Game.FunctionUnlockManager:getInstance():removeNewFlag(unlockType.UnlockFunctionType_Guild)
end

function PopupLayer:refreshNewFriendFlag(isDelete)
    self._friendNew = not isDelete
    self:refreshAllNewStatus()
end

function PopupLayer:addNewFlag(node)
    local redPoint = node:getChildByName("REDPOINT")
    if redPoint == nil then
        redPoint = AvalonUtil.createRedPoint(node, 5, 9, 20)
        redPoint:setName("REDPOINT")
    end
end

function PopupLayer:refreshAllNewStatus()
    local guildData = MasterDataManager:getGuildData()
    local guildNew = false
    if(guildData and GameDataManager:getInstance():getMasterIsManage()) then
        guildNew = guildData:getHasJoinReq()
    end

    require "app.datas.GuildBoxDataManager"
    self._guildStatus:setVisible(guildNew or GuildBoxDataManager:getNewBoxFlag())

    self._friendStatus:setVisible(self._friendNew)
end

function PopupLayer:refreshHaveApply()
    self:refreshAllNewStatus()
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function PopupLayer:refreshBtnState()
    self:refreshFunctionBtnState()
end

--刷新功能按钮状态 如果未解锁则隐藏 并缩紧布局， 如果解锁播放解锁动画 如果新功能播放新功能动画
function PopupLayer:refreshFunctionBtnState()
    local btnListRight = {}
    local isInActivityCave = SceneManager:getInstance():isActivityCave()
    local isInFightScene = SceneManager:getInstance():isInFightScene()
    -- 公会按钮
    local unLockStateGuild = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_Guild)
    if unLockStateGuild and not isInActivityCave then
        self._guildButton:show()
        self:playBtnUnlockAction(self._guildButton, unlockType.UnlockFunctionType_Guild)
        table.insert(btnListRight, self._guildButton)
    else
        self._guildButton:hide()
    end

    -- 好友按钮
    local unLockStateFriend = RoleDataManager:isUnlockByFunctionType(unlockType.UnlockFunctionType_FriendShip)
    if unLockStateFriend and not isInActivityCave then
        self._friendButton:show()
        self:playBtnUnlockAction(self._friendButton, unlockType.UnlockFunctionType_FriendShip)
        table.insert(btnListRight, self._friendButton)
    else
        self._friendButton:hide()
    end

    -- 录屏按钮
    if (ScreenRecordUtil:getInstance():getRecorderOn()) then
        self._screenRecordButton:show()
        table.insert(btnListRight, self._screenRecordButton)
    else
        self._screenRecordButton:hide()
    end

    -- 探险队按钮
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION)
        and not isInActivityCave ) then
        self._expeditionButton:show()
        -- table.insert(btnListRight, self._expeditionButton)
        -- self._expeditionButton:leftBottom(10, 0)
        if(mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) or 
            mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK)) then 
            self._expeditionStatus:setVisible(true)
        else 
            self._expeditionStatus:setVisible(false)
        end
    else
        self._expeditionButton:hide()
    end

    -- if (RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Souvenir)
    --     and not isInActivityCave ) then
    --     self._souvenirButton:show()
    --     if mvc.souvenirModel:isShowRedPoint() then
    --         self._souvenirStatus:show()
    --     else
    --         self._souvenirStatus:hide()
    --     end
    -- else
    --     self._souvenirButton:hide()
    -- end
    self._souvenirButton:hide() --这里不再显示纪念品图标,移动至顶部按钮
    

    -- 通行证按钮
    local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_BattlePass)
    if isUnlock and not isInFightScene then
        self._battlePassButton:show()
        table.insert(btnListRight, self._battlePassButton)
        if mvc.battlePassModel:isHaveRward() then
            self._battlePassStatus:show()
        else
            self._battlePassStatus:hide()
        end
    else
        self._battlePassButton:hide()
    end

    if isInActivityCave then 
        self._apprenticeshipLayer:hide()
    else 
        self._apprenticeshipLayer:show()
    end

    -- 神迹
    if(isInFightScene or not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_MiraclePrayer)) then 
        self._miracleBtn:hide()
    else
        self._miracleBtn:show() 
        table.insert(btnListRight, self._miracleBtn)

         if mvc.miracleModel:getIsShowRedHot() then
            self._miracleStatus:show()
        else
            self._miracleStatus:hide()
        end
    end

    -- 右边竖排
    for k, v in ipairs(btnListRight) do
         v:leftBottom(62, CELL_HEIGHT * (k - 1))
    end

    -- 左边竖排
    local btnListLeft = {}

    -- 探险队
    if (self._expeditionButton:isVisible()) then
        table.insert(btnListLeft, self._expeditionButton)
    end

    -- 师徒按钮
    if (self._apprenticeshipLayer:isVisible()) then
        table.insert(btnListLeft, self._apprenticeshipLayer)
    end

    if (self._souvenirButton:isVisible()) then
        table.insert(btnListLeft, self._souvenirButton)
    end

    -- 左边竖排
    for i, v in ipairs(btnListLeft) do
        v:leftBottom(0, CELL_HEIGHT * (i - 1))
    end

    if SceneManager:getInstance():isInStory() then
        self._friendButton:hide()
        self._screenRecordButton:hide()
        self._expeditionButton:hide()
        self._apprenticeshipLayer:hide()
        self._souvenirButton:hide()
    end
    return btnListRight
end

function PopupLayer:playBtnUnlockAction(btn, functionType)
    if Game.FunctionUnlockManager:getInstance():isShowUnlockAction(functionType) then
        btn:show()
        btn:disable()
        btn:playUnlockAction(function()
            self:playUnlockActionCallback(btn, functionType)
            btn:enable()
            print("----PopupLayer:playUnlockActionCallback-----"..functionType)
        end)
    elseif Game.FunctionUnlockManager:getInstance():isShowNewAction(functionType) then
        btn:playNewAction(0.6)
    else
        btn:removeNewAction()
    end
end

function PopupLayer:playUnlockActionCallback(btn, functionType)
    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(functionType)
    btn:playNewAction(0.6)
end

function PopupLayer:masterDead()
    self:disableAllBtn()
end

function PopupLayer:masterRevive()
    self:enableAllBtn()
end

--创建视频录像按钮
function PopupLayer:createScreenRecordButton()
    --录屏按钮
    require "app.utils.ScreenRecordUtil"
    local offButton = "ui_button_videotape_0.png"
    local onButton = "ui_button_videotape_2.png"
    local initButton = ScreenRecordUtil:getInstance():getIsRecording() and onButton or offButton
    local screenRecordButton = UI.Button:create(UIType.SCREEN_RECORD_BUTTON)
    screenRecordButton:init(initButton, initButton, initButton)
    screenRecordButton:rightUp(10, 230)
    local function changeIcon(isOn)
        if (isOn) then
            screenRecordButton:setNormal(onButton)
            screenRecordButton:setSelected(onButton)
            screenRecordButton:setDisabled(onButton)
        else
            screenRecordButton:setNormal(offButton)
            screenRecordButton:setSelected(offButton)
            screenRecordButton:setDisabled(offButton)
        end
        screenRecordButton:disable()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            screenRecordButton:enable()
        end, 1)
    end

    -- 录屏按钮回调
    screenRecordButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if (ScreenRecordUtil:getInstance():getIsRecording()) then
            changeIcon(false)
            ScreenRecordUtil:getInstance():stopRecording(false, function()
                local LanguageManager = require("app.game.LanguageManager")
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111247)) --保存提示
            end)
        else
            changeIcon(true)
            ScreenRecordUtil:getInstance():startRecording(function() 
                -- 开始成功(XCode BUG导致在调试时不可靠)
            end, function(errorCode)
                -- 开始失败(XCode BUG导致在调试时不可靠)
                changeIcon(false)
                local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
                UI.ScrollBar:createByText(errorString)
            end, function(errorCode)
                -- 录制途中出现错误
                changeIcon(false)
                local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
                UI.ScrollBar:createByText(errorString)
            end)
        end
    end)

    -- 录屏总开关回调
    screenRecordButton:setVisible(false)
    if (ScreenRecordUtil:getInstance():getRecorderOn()) then
        screenRecordButton:setVisible(true)
    end
    ScreenRecordUtil:getInstance():setOnOffStatusChangeCallback(function(isOn) 
        -- if (isOn) then
        --     screenRecordButton:setVisible(true)
        -- else
        --     screenRecordButton:setVisible(false)
        -- end
        self:refreshBtnState()
    end)

    return screenRecordButton
end



function PopupLayer:disableAllBtn(delay)
    if(not tolua.isnull(self._screenRecordButton)) then
        self._screenRecordButton:disable(delay)
    end

    if(not tolua.isnull(self._guildButton)) then
        self._guildButton:disable(delay)
    end

    if(not tolua.isnull(self._friendButton)) then
        self._friendButton:disable(delay)
    end

    if(not tolua.isnull(self._expeditionButton)) then
        self._expeditionButton:disable(delay)
    end

    if(not tolua.isnull(self._souvenirButton)) then
        self._souvenirButton:disable(delay)
    end

    if(not tolua.isnull(self._apprenticeshipLayer)) then
        self._apprenticeshipLayer:disableAllBtns()
    end
end

function PopupLayer:enableAllBtn(delay)
    if(not tolua.isnull(self._screenRecordButton)) then
        self._screenRecordButton:enable(delay)
    end

    if(not tolua.isnull(self._guildButton)) then
        self._guildButton:enable(delay)
    end

    if(not tolua.isnull(self._friendButton)) then
        self._friendButton:enable(delay)
    end

    if(not tolua.isnull(self._expeditionButton)) then
        self._expeditionButton:enable(delay)
    end

    if(not tolua.isnull(self._souvenirButton)) then
        self._souvenirButton:enable(delay)
    end

    if(not tolua.isnull(self._apprenticeshipLayer)) then
        self._apprenticeshipLayer:enableAllBtns()
    end
end

-- 注册监听事件
function PopupLayer:registerListener()
    --添加好友红点
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, self, self.refreshNewFriendFlag)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshHaveApply)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshHaveApply)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.refreshHaveApply)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.refreshHaveApply)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.refreshAllNewStatus)
    
        --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)

    -- 主角死亡，复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)
    -- 内挂数据变动
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_EXPEDITION_BAG_CHANGE, self, self.refreshBtnState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT, self, self.refreshBtnState)
    mvc.battlePassModel:bind("PassRewardData", self, self.refreshBtnState)
end


-- 注销监听事件
function PopupLayer:unRegisterListener()
    --添加好友红点
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_NEW_FRIEND_FLAG, self, self.refreshNewFriendFlag)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.refreshHaveApply)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.refreshHaveApply)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_QUIT_GUILD, self, self.refreshHaveApply)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.refreshHaveApply)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BOX_NEW_BOX_CHANGED, self, self.refreshAllNewStatus)
    --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)
    -- 主角死亡，复活完成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)

    -- 内挂数据变动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_EXPEDITION_BAG_CHANGE, self, self.refreshBtnState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT, self, self.refreshBtnState)
    mvc.battlePassModel:unbind("PassRewardData", self, self.refreshBtnState)
end
