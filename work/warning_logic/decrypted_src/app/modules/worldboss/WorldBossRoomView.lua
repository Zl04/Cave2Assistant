------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/05/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local scheduler = cc.Director:getInstance():getScheduler()
local WorldBossRoomView = class("WorldBossRoomView", UI.HWBtnComponent)

require "app.modules.worldboss.WorldBossRoomCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
    "ui_package_log.plist",
    "ui_playerstate_me_grade.plist",
}

local COM_WIDTH = 916
local COM_HEIGHT = 592
local layoutUtil
local ZOrder = 1
local List = Avalon.List


function WorldBossRoomView:ctor()
    WorldBossRoomView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self:bindModel()
    self.renderQueue = List:create();

    Avalon.Scheduler:scheduleUpdate(self, self.update)
    -- layoutUtil = UIUtil:createAutoUILayout("WorldBossRoomView","app.modules.worldboss.WorldBossPosConfig", false)
end

function WorldBossRoomView:dtor()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM)
    WorldBossRoomView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
    reload_script_file_mvc("app.modules.worldboss.WorldBossRoomView")
end

function WorldBossRoomView:initRoomData()
    local roomData = mvc.worldBossModel:getRoomData()
    local members = clone(roomData.members)
    self.dataList = {}
    self.roomNo = roomData.roomNo

    table.sort(members, function(a, b)
        if a.equipScore == b.equipScore then
            return a.pk > b.pk
        else
            return a.equipScore > b.equipScore
        end
    end)

    local myPK = RoleDataManager:getMaster():getPK()
    for k, v in ipairs(members) do
        local obj = {}
        obj.idx = k
        if v.pk == myPK then
            obj.pk = myPK
            obj.faceId = RoleDataManager:getMaster():getFaceDecodeID()
            obj.sex = RoleDataManager:getMaster():getSex()
            obj.nickName = RoleDataManager:getMaster():getNickName()
            obj.lv = RoleDataManager:getMaster():getLevel()
            obj.power = v.equipScore
            obj.userID = v.userID
            obj.rootLayer = self
            obj.isSelf = true
        else
            obj.pk = v.pk
            obj.faceId = v.faceDecodeID
            obj.sex = v.sex
            obj.nickName = v.name
            obj.lv = v.lv
            obj.power = v.equipScore
            obj.userID = v.userID
            obj.rootLayer = self
            obj.isSelf = false
        end

        self.dataList[k] = obj
    end

    local stateBox = mvc.worldBossModel:getStateBox()
    self.countDown = stateBox.countDown
end

function WorldBossRoomView:switchingRoom()
    self:updateRoomData()

    mvc.worldBossModel:resetSwitchRoomCD()
    self.refreshRoomInterval = mvc.worldBossModel:getSwitchRoomCD()
end

function WorldBossRoomView:updateRoomData()
    self:initRoomData()

    self.roomTipTxt:setText(string.format(UI.TEXT_1212653, self.roomNo))
    self.gridList:setData(self.dataList)
end

function WorldBossRoomView:onInitView()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_HIDE_MINI_ROOM)

    self:initRoomData()

    self.refreshRoomInterval = mvc.worldBossModel:getSwitchRoomCD()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_bg_box2.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;

    -- 背景底图
    local bg2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    bg2:setContentSize(866, 514)
    bg2:setCapInsets(CCRectMake(304, 141, 1, 1))
    bg2:setPosition(cc.p(COM_WIDTH / 2 + 4, COM_HEIGHT / 2 - 16))
    contentLayout:addChild(bg2, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(-8);
    contentLayout:addChild(bgTitle, ZOrder);
    ZOrder = ZOrder + 1;

    local titleTxtLayout = UI.Layout:create();
    titleTxtLayout:init()
    titleTxtLayout:setSize(235, 50)
    titleTxtLayout:leftUp(350, 0)
    contentLayout:addChild(titleTxtLayout, ZOrder)
    ZOrder = ZOrder + 1;

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1212645, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_170_170_170)
    titleTxt:center()
    titleTxtLayout:addChild(titleTxt)

    -- 最小化按钮
    local btn = UI.Button:create();
    btn:init("ui_boss_btn_maximization_0.png","ui_boss_btn_maximization_1.png","ui_boss_btn_maximization_0.png");
    btn:rightUp(-6, 10);
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:close()
    end)
    contentLayout:addChild(btn, ZOrder);
    ZOrder = ZOrder + 1;

    -- 倒计时显示
    local countDownLayout = UI.Layout:create()
    countDownLayout:init()
    countDownLayout:setSize(380, 50)
    countDownLayout:leftUp(0, 5)
    bg2:addChild(countDownLayout, ZOrder)
    ZOrder = ZOrder + 1;

    local reminderIcon  = UI.Image:create();
    reminderIcon:init("ui_information_reminder.png");
    reminderIcon:floatLeft(20);
    countDownLayout:addComponent(reminderIcon);

    local countDownTxt = UI.Text:create()
    countDownTxt:init(UI.TEXT_1212662, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    countDownTxt:floatLeft(5)
    countDownLayout:addComponent(countDownTxt)

    local countDownValue = UI.Text:create()
    countDownValue:init("00:00", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    countDownValue:floatLeft(5)
    countDownLayout:addComponent(countDownValue)
    self.countDownValue = countDownValue

    -- 装备间
    local roomTipTxt = UI.Text:create()
    roomTipTxt:init(string.format(UI.TEXT_1212653, self.roomNo), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    roomTipTxt:rightUp(20, 18)
    bg2:addChild(roomTipTxt)
    self.roomTipTxt = roomTipTxt

    local splitLine1 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine1:setContentSize(840, 2)
    splitLine1:setCapInsets(CCRectMake(20,1,1,1))
    splitLine1:setPosition(435, 468)
    bg2:addChild(splitLine1)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine2:setContentSize(840, 2)
    splitLine2:setCapInsets(CCRectMake(20,1,1,1))
    splitLine2:setPosition(435, 68)
    bg2:addChild(splitLine2)

    -- 两个按钮
    local btnsLayout = UI.Layout:create()
    btnsLayout:init()
    btnsLayout:setSize(864, 50)
    btnsLayout:centerBottom(10)
    bg2:addChild(btnsLayout, ZOrder)
    ZOrder = ZOrder + 1;

    -- 更换房间按钮
    local changeRoomBtn = UI.Button:create();
    changeRoomBtn:init("ui_btn_yellow16_0.png","ui_btn_yellow16_1.png","ui_btn_yellow16_0.png");
    changeRoomBtn:centerLeft(140);
    local coundDown = string.format(UI.TEXT_1212654, self.refreshRoomInterval)
    if self.refreshRoomInterval <= 0  then
        changeRoomBtn:setText(UI.TEXT_1212658)
    else
        changeRoomBtn:setText(coundDown)
    end
    changeRoomBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    changeRoomBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.refreshRoomInterval > 0 then
            UI.ScrollBar:createByText(UI.TEXT_1212655)
            return
        end

        Net.NetActivitySystem:requestWorldbossChangeRoom()
    end)
    btnsLayout:addChild(changeRoomBtn)
    self.changeRoomBtn = changeRoomBtn

    -- 放弃报名按钮
    local cancelBtn = UI.Button:create();
    cancelBtn:init("ui_btn_yellow16_0.png","ui_btn_yellow16_1.png","ui_btn_yellow16_0.png");
    cancelBtn:centerRight(140);
    cancelBtn:setText(UI.TEXT_1212656)
    cancelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212657,
            function()
                Net.NetActivitySystem:requestWorldbossQuitRoom()
                self:close()
            end
        )
    end)
    btnsLayout:addChild(cancelBtn)

    self:updateCellList(bg2)

    local listMark = UI.Image:create()
    listMark:init("ui_boss_paper_mack.png")
    listMark:centerBottom(68)
    bg2:addChild(listMark, 50)
    -- listMark:enableDebugDraw()

    self:addUIEffect(bg2)
end

function WorldBossRoomView:addUIEffect(rootNode)
    local leftEff = UI.Animation:create()
    leftEff:init("effect_ui_town_worldboss_a.json", "effect_ui_town_worldboss_a.atlas", 1);
    leftEff:leftBottom(-30, 10)
    rootNode:addChild(leftEff, 100)
    leftEff:setAnimation("idle", true)

    local rightEff = UI.Animation:create()
    rightEff:init("effect_ui_town_worldboss_b.json", "effect_ui_town_worldboss_b.atlas", 1);
    rightEff:rightBottom(-15, 5)
    rootNode:addChild(rightEff, 100)
    rightEff:setAnimation("idle", true)
end

function WorldBossRoomView:updateCellList(rootNode)
    local gridList = UI.GridList:create()

    gridList:init(UI.WorldBossRoomCell, 5, 3, 168, 180, 0, 0, 0)
    gridList:setData(self.dataList)
    gridList:setSize(864, 394)
    gridList:leftUp(-10, 50)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.roomCellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setScrollBarWidth(5)
    gridList:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    gridList:setCircleVisible(false)

    self.gridList = gridList

    rootNode:addChild(gridList, ZOrder)
    ZOrder = ZOrder + 1;
end

function WorldBossRoomView:roomCellClickCallback(grid, touchPosition)
    if self and not tolua.isnull(self) and self.lastGrid and not tolua.isnull(self.lastGrid) then
        self.lastGrid:clearSelect()
    end

    grid:cellClick()
    self.lastGrid = grid
end

-- 每帧截屏3个
function WorldBossRoomView:update(dt)
    if self.renderQueue == nil then
        return
    end

    local limite = 3
    local size = self.renderQueue:size()
    size = size > limite and limite or size
    if size > 0 then
        for i = 1, size do
            local renderCMD = self.renderQueue:pop_front();
            if renderCMD then 
                renderCMD.execute()
            end
        end
    end

    -- 刷新更换房间倒计时显示
    if self.refreshRoomInterval ~= nil then
        if self.refreshRoomInterval > 0 then
            if math.modf(self.refreshRoomInterval - dt) == math.modf(self.refreshRoomInterval)-1 then
                local coundDown = string.format(UI.TEXT_1212654, math.modf(self.refreshRoomInterval))
                self.changeRoomBtn:setText(coundDown)
            end
            self.refreshRoomInterval = self.refreshRoomInterval - dt
        else
            self.refreshRoomInterval = 0
            self.changeRoomBtn:setText(UI.TEXT_1212658)
        end
    end

    -- 状态倒计时
    if self.countDown ~= nil then
        if self.countDown > 0 then
            if math.modf(self.countDown - dt) == math.modf(self.countDown)-1 then
                self:formatCountDown()
            end
            self.countDown = self.countDown - dt
        else
            self.countDown = 0
            self.countDownValue:setText("")
        end
    end
end

function WorldBossRoomView:formatCountDown()
    local str = "00:00"
    local minute = math.modf(self.countDown/SECONDS_ONE_MINUTES)
    local seconds = math.modf(self.countDown%SECONDS_ONE_MINUTES)
    str = string.format("%02d:%02d", minute, seconds)
    self.countDownValue:setText(str)
end

--获取头像
function WorldBossRoomView:getHead(sex, faceDecodeID, callfunc, idx)
    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(faceDecodeID)

    local command = {
        execute = function ( ... )
            self:exportHead(heroData, callfunc);
        end,
        isExecute = false,
        idx = idx,
    }
    self.renderQueue:push_back(command)
end

function WorldBossRoomView:exportHead(headData, callfunc)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            callfunc(pic, headData.faceDecodeID)
        end
    end),true)
end

function WorldBossRoomView:close()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_WORLDBOSS_SHOW_MINI_ROOM)
    mvc.closePanel("WorldBoss", "WorldBossRoom")
end

function WorldBossRoomView:bindModel()

end


function WorldBossRoomView:unbindModel()

end





return WorldBossRoomView
