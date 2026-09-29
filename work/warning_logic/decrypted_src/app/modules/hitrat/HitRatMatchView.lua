------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/14
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatMatchView = class("HitRatMatchView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_festival.plist",
    "ui_town_festival_hitrat.plist",
    "ui_general_tips.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 800
local COM_HEIGHT = 500

function HitRatMatchView:ctor()
    HitRatMatchView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE, self, self.updateRoomData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_DELAY_SHOW_HERO_DETAIL, self, self.updateEnemyDataShow)
end

function HitRatMatchView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatMatchView.super.init(self, ... )
end

function HitRatMatchView:dtor()
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    HitRatMatchView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE, self, self.updateRoomData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_DELAY_SHOW_HERO_DETAIL, self, self.updateEnemyDataShow)

    reload_script_file_mvc("app.modules.hitrat.HitRatMatchView")
end

function HitRatMatchView:onInitView()
    self.allReadyNum = 0

    -- 再次调用，消除顶条
    performWithDelay(self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_TEAM_RESPONSE_MATCH)
    end, 0.1)

    local roomData = mvc.festivalModel:getCurJoinData()
    self.remainTimeTotal = roomData.remainTime
    self.refreshRoomInterval = roomData.remainTime or 0

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 0.1, false)

    self:initRoomData()

    if not self.enemyData or not self.myselfData then
        mvc.closePanel("HitRat", "HitRatMatch")
        return
    end
    -- 先去请求一次对手信息
    GameManager:heroDetailRequest(self.enemyData.pk, self.enemyData.userID, false)

    -- 总背景
    local bg  = UI.Image:create();
    bg:init("ui_hitrat_decoration.png")
    bg:center()
    self.contentLayer = bg
    self:addChild(bg, 1)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:enableDebugDraw()
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() return end)
    self:addChild(maskLayout, 0)

    -- 标题
    local nameLayout = UI.Layout:create()
    nameLayout:init()
    nameLayout:setSize(235, 60)
    nameLayout:leftUp(350,0)
    -- nameLayout:enableDebugDraw()
    self.contentLayer:addChild(nameLayout)

    local title = UI.Text:create()
	title:init(UI.TEXT_1213330, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_155_155_155)
	title:center()
    nameLayout:addChild(title)

    local leftRoleAnimation = UI.RoleAnimation:create(false)
    leftRoleAnimation:init(RoleDataManager:getMaster())
    leftRoleAnimation:setScaleX(-0.6 * leftRoleAnimation:getScaleX())
    leftRoleAnimation:setScaleY(0.6 * leftRoleAnimation:getScaleY())
    leftRoleAnimation:leftUp(150, 120)
    leftRoleAnimation:showBlink(true)
    performWithDelay(self, function()
        leftRoleAnimation:showHelmet(true)
    end, 0)
    self.contentLayer:addChild(leftRoleAnimation, 9)

    -- 中间门的动画
    local vsEff = UI.Animation:create()
    vsEff:init("effect_ui_hitrat.json", "effect_ui_hitrat.atlas", 1);
    vsEff:center()
    self.contentLayer:addChild(vsEff)
    vsEff:setAnimation("begin", false)
    vsEff:updateTime(100)
    self.vsEff = vsEff

    local decorate1  = UI.Image:create();
    decorate1:init("ui_hitrat_left.png")
    decorate1:leftUp(114, 202)
    self.contentLayer:addChild(decorate1, 10)

    -- 左玩家名字
    local playerLayout1 = UI.Layout:create()
    playerLayout1:init()
    playerLayout1:setSize(150, 40)
    playerLayout1:leftUp(20,18)
    decorate1:addChild(playerLayout1)

    local playerName1 = UI.Text:create()
    playerName1:init(self.myselfData.nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_196_196)
    playerName1:center()
    -- playerName1:enableDebugDraw()
    playerLayout1:addChild(playerName1)
    if playerName1:getContentSize().width > 150 then
        playerName1:setFontSize(UI.FONT_SIZE_16PX)
    end
    self.myName = playerName1

    local playerReady1 = UI.Text:create()
    playerReady1:init(self.myselfData.isSured and UI.TEXT_1213331 or UI.TEXT_1213332, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_145_145)
    playerReady1:centerBottom(-16)
    -- playerReady1:enableDebugDraw()
    playerLayout1:addChild(playerReady1)
    self.myselfReady = playerReady1

    local decorate2  = UI.Image:create();
    decorate2:init("ui_hitrat_right.png")
    decorate2:rightUp(120, 258)
    self.contentLayer:addChild(decorate2, 10)

    -- 左老鼠
    local rat1 = UI.Animation:create()
    rat1:init("effect_ui_gaming_hitrat_battleui_girl.json", "effect_ui_gaming_hitrat_battleui_girl.atlas", 1);
    rat1:leftUp(130, 340)
    self.contentLayer:addChild(rat1)
    rat1:setAnimation("idle", true)

    -- 右玩家名字
    local playerLayout2 = UI.Layout:create()
    playerLayout2:init()
    playerLayout2:setSize(150, 40)
    playerLayout2:leftUp(16,16)
    -- playerLayout2:enableDebugDraw()
    decorate2:addChild(playerLayout2)

    local playerName2 = UI.Text:create()
    playerName2:init(self.enemyData.nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_214_251_255)
    playerName2:center()
    -- playerName2:enableDebugDraw()
    playerLayout2:addChild(playerName2)
    if playerName2:getContentSize().width > 150 then
        playerName2:setFontSize(UI.FONT_SIZE_16PX)
    end
    self.enemyName = playerName2

    local playerReady2 = UI.Text:create()
    playerReady2:init(self.enemyData.isSured and UI.TEXT_1213331 or UI.TEXT_1213332, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_151_212_255)
    playerReady2:centerBottom(-16)
    -- playerReady2:enableDebugDraw()
    playerLayout2:addChild(playerReady2)
    self.enemyReady = playerReady2

    -- 右老鼠
    local rat2 = UI.Animation:create()
    rat2:init("effect_ui_gaming_hitrat_battleui_boy.json", "effect_ui_gaming_hitrat_battleui_boy.atlas", 1);
    rat2:rightBottom(114, 78)
    self.contentLayer:addChild(rat2)
    rat2:setAnimation("idle", true)

    -- 倒计时和按钮
    local downLayout = UI.Layout:create()
    downLayout:init()
    downLayout:setSize(256, 120)
    downLayout:leftBottom(330, 10)
    -- downLayout:enableDebugDraw()
    self.contentLayer:addChild(downLayout)

    -- 倒计时条
    local prg = UI.ProgressTimer:create()
    prg:init("ui_hitrat_schedule_01.png", nil, "ui_hitrat_schedule_02.png")
    prg:centerUp(22)
    prg:setPercent(1)
    downLayout:addChild(prg)
    self.prgBar = prg

    local playSoonTxt = UI.Text:create()
    playSoonTxt:init(UI.TEXT_1213333, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_151_212_255)
    playSoonTxt:centerUp(18)
    self.playSoonTxt = playSoonTxt
    -- playSoonTxt:enableDebugDraw()
    downLayout:addChild(playSoonTxt)
    self.playSoonTxt:hide()

    -- 进度文字
    local prgTxt = UI.Text:create()
	prgTxt:init("30s", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_247_202)
    prgTxt:centerUp(16)
    self.prgTxt = prgTxt
    downLayout:addChild(prgTxt, 2)

    -- 准备
    local prepareBtn = UI.Button:create();
    prepareBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    prepareBtn:centerBottom(28);
    prepareBtn:setText(UI.TEXT_110011)
    prepareBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    prepareBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self.vsEff:setAnimation("begin", false)
        self.vsEff:addAnimation("idle", true)

        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetActivitySystem:requestSureMacth()
    end)
    downLayout:addChild(prepareBtn)
    self.prepareBtn = prepareBtn
end

function HitRatMatchView:initRoomData()
    self.myselfData = nil
    self.enemyData = nil

    local roomData = mvc.festivalModel:getCurJoinData()
    local members = clone(roomData.members)

    self.myPK = RoleDataManager:getMaster():getPK()
    for k, v in ipairs(members) do
        local obj = {}
        obj.idx = k
        obj.power = v.equipScore
        obj.userID = v.userID
        obj.rootLayer = self
        obj.isSured = v.isSured
        if v.pk == self.myPK then
            obj.pk = self.myPK
            obj.faceId = RoleDataManager:getMaster():getFaceDecodeID()
            obj.sex = RoleDataManager:getMaster():getSex()
            obj.nickName = RoleDataManager:getMaster():getNickName()
            obj.lv = RoleDataManager:getMaster():getLevel()
            obj.isSelf = true

            self.myselfData = obj
        else
            obj.pk = v.pk
            obj.faceId = v.faceDecodeID
            obj.sex = v.sex
            obj.nickName = v.name
            obj.lv = v.lv
            obj.isSelf = false

            self.enemyData = obj
        end
    end
end

function HitRatMatchView:updateEnemyDataShow(roleData)
    local rightRoleAnimation = UI.RoleAnimation:create(false)
    rightRoleAnimation:init(roleData.heroData)
    -- 这里要强制刷新一下，保证内部的roleRender创建成功
    rightRoleAnimation:updateView()

    local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
    local weaponEquipmentData = nil
    if roleData.wearEquipmentArr then
        for i = 1, #roleData.wearEquipmentArr do
            local equipmentData = roleData.wearEquipmentArr[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == EQUIPMENT_TYPE.Weapon) then
                weaponEquipmentData = equipmentData
            end
        end

        rightRoleAnimation:updateRoleEquipment(roleData.wearEquipmentArr)
        rightRoleAnimation:showIDLEAnimation(weaponEquipmentData)
    end

    rightRoleAnimation:setScaleX(0.6 * rightRoleAnimation:getScaleX())
    rightRoleAnimation:setScaleY(0.6 * rightRoleAnimation:getScaleX())
    rightRoleAnimation:rightUp(150, 178)
    rightRoleAnimation:showBlink(true)
    performWithDelay(self, function()
        rightRoleAnimation:showHelmet(true)
    end, 0)
    self.contentLayer:addChild(rightRoleAnimation, 9)
end

function HitRatMatchView:updateRoomData()
    print("HitRatMatchView:updateRoomData ===")
end

function HitRatMatchView:onSureMatchResp(result, pk)
    if self.myPK == pk then
        self.myselfReady:setText(UI.TEXT_1213331)
        self.prepareBtn:disable()
        self.refreshRoomInterval = 0
    else
        self.enemyReady:setText(UI.TEXT_1213331)
    end

    self.allReadyNum = self.allReadyNum + 1
end

function HitRatMatchView:canelMatch(data)
    mvc.closePanel("HitRat", "HitRatMatch")
end

function HitRatMatchView:update(dt)
    -- 刷新更换房间倒计时显示
    if self.refreshRoomInterval ~= nil then
        if self.refreshRoomInterval > 0 then
            self.prgBar:setPercent((self.refreshRoomInterval-dt)/self.remainTimeTotal)
            if math.modf(self.refreshRoomInterval - dt) == math.modf(self.refreshRoomInterval)-1 then
                self.prgTxt:setText(math.floor(self.refreshRoomInterval).."s")
            end
            self.refreshRoomInterval = self.refreshRoomInterval - dt
        else
            self.refreshRoomInterval = 0
            self.prgBar:hide()
            self.prgTxt:hide()
            self.prepareBtn:disable()
            if self.allReadyNum >= 2 then
                self.playSoonTxt:show()
            end
        end
    end
end

function HitRatMatchView:bindModel()

end


function HitRatMatchView:unbindModel()

end

return HitRatMatchView
