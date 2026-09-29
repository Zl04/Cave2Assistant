------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FestivalMazeTeamView = class("FestivalMazeTeamView", UI.HWBtnComponent)

require "app.modules.festival.FestivalMazeTeamCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_festival.plist",
    "ui_common_btn.plist",
    "ui_bg_paper3.plist",
    "ui_common_scale9image.plist",
    "ui_town_world_boss.plist",
    "ui_common_symbol.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 1060
local COM_HEIGHT = 590
local layoutUU
local winSize = cc.Director:getInstance():getWinSize()
local List = Avalon.List

function FestivalMazeTeamView:ctor()
    FestivalMazeTeamView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.renderQueue = List:create();
    Avalon.Scheduler:scheduleUpdate(self, self.update)
    -- layoutUU = UIUtil:createAutoUILayout("FestivalMazeTeamView","app.modules.festival.FestivalPosConfig", false)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE, self, self.updateRoomData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
end

function FestivalMazeTeamView:dtor()
    FestivalMazeTeamView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE, self, self.updateRoomData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
    reload_script_file_mvc("app.modules.festival.FestivalMazeTeamView")
end

function FestivalMazeTeamView:initRoomData()
    self.dataList = {}
    local roomData = mvc.festivalModel:getCurJoinData()
    local members = clone(roomData.members)

    self.myPK = RoleDataManager:getMaster():getPK()
    for k, v in ipairs(members) do
        local obj = {}
        obj.idx = k
        if v.pk == self.myPK then
            obj.pk = self.myPK
            obj.faceId = RoleDataManager:getMaster():getFaceDecodeID()
            obj.sex = RoleDataManager:getMaster():getSex()
            obj.nickName = RoleDataManager:getMaster():getNickName()
            obj.lv = RoleDataManager:getMaster():getLevel()
            obj.isSelf = true
        else
            obj.pk = v.pk
            obj.faceId = v.faceDecodeID
            obj.sex = v.sex
            obj.nickName = v.name
            obj.lv = v.lv
            obj.isSelf = false
        end

        obj.power = v.equipScore
        obj.userID = v.userID
        obj.rootLayer = self
        obj.isSured = v.isSured

        self.dataList[k] = obj
    end
end

function FestivalMazeTeamView:onInitView()
    self:center()
    self:initRoomData()

    local roomData = mvc.festivalModel:getCurJoinData()
    self.refreshRoomInterval = roomData.remainTime or 0

    -- 总背景
    local bg  = UI.Image:create();
    bg:init("ui_bg_box2.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg:getSize())

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    bg:addChild(mask)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:enableDebugDraw()
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() return end)
    bg:addChild(maskLayout)

    -- 标题背景
    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg)

    -- 标题
    local title = UI.Text:create()
	title:init(UI.TEXT_1213005, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_187_181_175)
	title:center()
    titleBg:addChild(title)
    
    -- 背景纸
    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(864, 517)
    bgLayout:leftBottom(105,21)
    self:addChild(bgLayout)

    -- 装饰
    local decorate1  = UI.Image:create();
    decorate1:init("ui_festival_maze_fg_1.png")
    decorate1:leftUp(-44, -30)
    bgLayout:addChild(decorate1, 10)

    local decorate2  = UI.Image:create();
    decorate2:init("ui_festival_maze_fg_3.png")
    decorate2:leftBottom(-110, -30)
    bgLayout:addChild(decorate2, 10)

    local decorate3  = UI.Image:create();
    decorate3:init("ui_festival_maze_fg_2.png")
    decorate3:rightUp(-30, -34)
    bgLayout:addChild(decorate3, 10)

    local decorate4  = UI.Image:create();
    decorate4:init("ui_festival_maze_fg_4.png")
    decorate4:rightBottom(-104, -36)
    bgLayout:addChild(decorate4, 10)

    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(864, 517)
    centerBg:setCapInsets(CCRectMake(304,141,1,1))
    centerBg:setPosition(cc.p(centerBg:getContentSize().width/2, centerBg:getContentSize().height/2))
    bgLayout:addChild(centerBg)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine2:setContentSize(840, 2)
    splitLine2:setCapInsets(CCRectMake(20,1,1,1))
    splitLine2:setPosition(435, 97)
    bgLayout:addChild(splitLine2)

    -- 两个按钮
    local btnsLayout = UI.Layout:create()
    btnsLayout:init()
    btnsLayout:setSize(864, 50)
    btnsLayout:centerBottom(29)
    bgLayout:addChild(btnsLayout)

    -- 准备
    local prepareBtn = UI.Button:create();
    prepareBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    prepareBtn:centerLeft(140);
    local coundDown = string.format(UI.TEXT_1213023, self.refreshRoomInterval)
    if self.refreshRoomInterval <= 0  then
        prepareBtn:setText(UI.TEXT_110011)
    else
        prepareBtn:setText(coundDown)
    end

    prepareBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    prepareBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetActivitySystem:requestSureMacth()
    end)
    btnsLayout:addChild(prepareBtn)
    self.prepareBtn = prepareBtn

    -- 放弃按钮
    local cancelBtn = UI.Button:create();
    cancelBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    cancelBtn:centerRight(140);
    cancelBtn:setText(UI.TEXT_1213006)
    cancelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212657,
            function()
                Net.NetActivitySystem:requestCancleMacth(true)
            end
        )
    end)
    btnsLayout:addChild(cancelBtn)
    self.cancelBtn = cancelBtn

    self:updateCellList(bgLayout)
end

function FestivalMazeTeamView:updateCellList(rootNode)
    local gridList = UI.GridList:create()
    gridList:init(UI.FestivalMazeTeamCell, 5, 2, 165, 175, 0, 0, 0)
    gridList:setData(self.dataList)
    gridList:setSize(830, 350)
    gridList:leftUp(4, 40)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.roomCellClickCallback)
    gridList:setScrollBarEnabled(false)
    gridList:setCircleVisible(false)

    self.gridList = gridList

    rootNode:addChild(gridList)
end

function FestivalMazeTeamView:roomCellClickCallback(grid, touchPosition)
    if self and not tolua.isnull(self) and self.lastGrid and not tolua.isnull(self.lastGrid) then
        self.lastGrid:clearSelect()
    end

    grid:cellClick()
    self.lastGrid = grid
end

function FestivalMazeTeamView:updateRoomData()
    self:initRoomData()

    self.gridList:setData(self.dataList)
end

function FestivalMazeTeamView:onSureMatchResp(result, pk)
    if self.myPK == pk then
        self.prepareBtn:setText(UI.TEXT_1213024)
        self.prepareBtn:disable()
        self.refreshRoomInterval = 0
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DONG_KU_MI_ZHEN_READY, pk)

    self:checkQuitState()
end

-- 房间所有人都准备好之后，就隐藏退出按钮
function FestivalMazeTeamView:checkQuitState()
    local roomData = mvc.festivalModel:getCurJoinData()
    local suredMem = 0
    for k, v in ipairs(roomData.members) do
        if v.isSured then
            suredMem = suredMem+1
        end
    end

    if suredMem == #roomData.members then
        self.cancelBtn:disable()
    end
end

function FestivalMazeTeamView:canelMatch(data)
    if tolua.isnull(self) then
        return
    end

    self:close()
end

-- 每帧截屏3个
function FestivalMazeTeamView:update(dt)
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
                local coundDown = string.format(UI.TEXT_1213023, math.modf(self.refreshRoomInterval))
                self.prepareBtn:setText(coundDown)
            end
            self.refreshRoomInterval = self.refreshRoomInterval - dt
        else
            self.refreshRoomInterval = 0
            self.prepareBtn:setText(UI.TEXT_110011)
        end
    end
end

function FestivalMazeTeamView:formatCountDown()
    local str = "00:00"
    local minute = math.modf(self.countDown/SECONDS_ONE_MINUTES)
    local seconds = math.modf(self.countDown%SECONDS_ONE_MINUTES)
    str = string.format("%02d:%02d", minute, seconds)
    self.countDownValue:setText(str)
end

--获取头像
function FestivalMazeTeamView:getHead(sex, faceDecodeID, callfunc, idx)
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

function FestivalMazeTeamView:exportHead(headData, callfunc)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            callfunc(pic, headData.faceDecodeID)
        end
    end),true)
end

function FestivalMazeTeamView:close()
    mvc.closePanel("Festival", "FestivalMazeTeam")
end

function FestivalMazeTeamView:bindModel()

end

function FestivalMazeTeamView:unbindModel()

end

return FestivalMazeTeamView
