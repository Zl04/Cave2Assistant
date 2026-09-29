-- FriendsLayer.lua
-- Author:ydli
-- 2017年09月26日
-- Using:好友列表界面
UI = UI or {}
local FriendsLayer = class("FriendsLayer", UI.DoorWin)
UI.FriendsLayer = FriendsLayer

require ("app.ui.social.friends.FriendMemberCell")
local GameDataManager = require("app.game.GameDataManager")
local model = require("app.uiExport.Friend")

local scheduler=cc.Director:getInstance():getScheduler()
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local size = cc.size(310, winSize.height)

-- 此页面在2个地方使用, INFO = 好友界面, TEAM = 组队下洞邀请
local SHOW_MODEL = {
    INFO    = 1,
    TEAM = 2,
}
UI.FRIEND_LAYER_SHOW_MODEL = SHOW_MODEL

-- 组队邀请有两个列表, 可以从好友和公会邀请
local SHOW_DATA_TYPE = {
    FRIEND = 1,
    GUILD = 2
}
UI.SHOW_DATA_TYPE = SHOW_DATA_TYPE

-- 好友界面可能有3个模式
local INFO_MODE = {
    NORMAL = 1,
    DEL_MODE = 2,
    BLOCK_LIST_MODE = 3,
}
UI.FRIEND_INFO_MODE = INFO_MODE

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_friends.plist",
}

----表情界面
--构造函数(必备)
function FriendsLayer:ctor(spriteID, showModel)
    FriendsLayer.super.ctor(
    self,UIType.FRIEND_MAIN,
    COM_RES_LIST,
    size.width,    
    winSize.height
    )

    GameDataManager:getInstance():clearAllInvitation()
    self.showDataType = SHOW_DATA_TYPE.FRIEND;
    self.showModel = showModel or SHOW_MODEL.INFO
    self.rootLayer = nil 
    self.currentSelectedData = {}
    self.inviteData = {}
    self.tableCells = {}
    self.delSelectCells = {}
    self.infoMode = INFO_MODE.NORMAL
    self.confirmTips = nil
    self:init() 
    if self.showModel ==  SHOW_MODEL.INFO then
        self:setTouchEnable(true)
        self:setInterceptTouches(true);
    end
    self:registerListener()
    self.clippingRect = nil
    self.isCd = false
    self.schedulerID = 0
    self.inviteSchedulerID = 0;
    self.requireGuildData = false
end

--虚构函数,destroy时调用(必备)
function FriendsLayer:dtor()
    self.currentSelectedData = {}
    self.inviteData = {}
    self.tableCells = {}
    self.delSelectCells = {}
    Game.FriendManager:getInstance():clearAllNewFlag()
    FriendsLayer.super.dtor(self)
    self:unRegisterListener()
    self.isCd = false
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end

    if self.inviteSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.inviteSchedulerID)
        self.inviteSchedulerID = 0
    end
end

-- 初始化(必备)
function FriendsLayer:init()
    FriendsLayer.super.init(self)

    -- 更新好友数据
    if(GameManager:getNowServerTime() - Game.FriendManager:getInstance():getLastReqFriendTime() >= REQUEST_CD_TIME) then
        GameManager:getFriendList(GameDataManager:getInstance():getMasterPK(), Game.FriendManager:getInstance():getUpdateTimestamp())
        local waitingLayer = UI.WaitingLayer:showWaitingWithSize(cc.size(self.rootLayer._width, self.rootLayer._height), self.rootLayer)
        Game.FriendManager:getInstance():setLastReqFriendTime(GameManager:getNowServerTime())
    else
        self:refreshMainLayer(1)
    end

    -- 如果是组队邀请模式, 检查邀请
    if self.showModel ==  SHOW_MODEL.TEAM then
        self.inviteSchedulerID = scheduler:scheduleScriptFunc(handler(self,self.schedulerTimeOut),1,false)
    end
end


-- 模版函数：初始化组建的视图(必备)
function FriendsLayer:onInitView()
    self:centerRight(0)

    self.friendModel = model.create("Friend")
    self.rootLayer = self.friendModel.root
    self.rootLayer:centerRight(0);
    self:addChild(self.rootLayer)

    -- 好友数量的layer
    self.firendNumberLayer = self.friendModel.firendNumberLayer
    self.firendNumberLayer:setVisible(false)

    -- 添加好友输入框的layer
    self.addFriendLayer = self.friendModel.addFriendLayer
    self.addFriendLayer:setVisible(false)

    -- 添加好友确认的layer
    self.inviteBg = self.friendModel.confirmLayer
    self.inviteBg:setVisible(false)

    -- 玩家自身信息的layer
    self.selfInfoLayer = self.friendModel.selfInfoLayer
    self.selfInfoLayer:setVisible(false)

    -- 组队邀请的标题
    self.teamInviteFriendLabel = self.friendModel.inviteFriendLabel
    self.teamInviteFriendLabel:setVisible(false)

    -- 组队工会与好友切换的按钮layer
    self.guildButtonLayer = self.friendModel.guildButtonLayer
    self.guildButtonLayer:setVisible(false)

    -- 组队邀请模式的公会和好友切换按钮
    self.guildButton = self.friendModel.guildButton
    self.friendButton = self.friendModel.friendButton

     -- 好友 列表
    local tableWidth = self.friendModel.listViewLayer._width
    local tableHeight =  self.friendModel.listViewLayer._height
    self.friendTableView = cc.TableView:create(cc.size(tableWidth, tableHeight))
    self.friendTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.friendTableView:setDelegate()
    self.friendTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.friendModel.listViewLayer:addChild(self.friendTableView, 20)
    self.friendTableView:initScrollBar()
    self.friendTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    self.friendTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.friendTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.friendTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.friendTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.friendTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.friendTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)

    self._noFriendTips = self.friendModel.notHaveFrindInfo

    -- 根据不同模式初始化界面
    if self.showModel == SHOW_MODEL.INFO then
        self:initInfoModel()
    elseif self.showModel == SHOW_MODEL.TEAM then
        self:initTeamModel()
    end

    self:setCloseStartCallBack(handler(self, self.beforeDoorClose))
    self:setDoorNode(nil, self, false)
end

function FriendsLayer:showLayer()
    self:open();
end

-- 模版函数：更新组建的视图(必备)
function FriendsLayer:onUpdateView()
    -- self.scrollView:setScrollBarWidth(5)
    -- self.friendTableView:reloadData()
end

function FriendsLayer:beforeDoorClose()
    return self.showModel == SHOW_MODEL.INFO
end

-- 注册监听事件(可选)
function FriendsLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER, self, self.refreshMainLayer)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_REFRESH_END, self, self.refreshGuildLayer)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_JOIN, self, self.addTeamRole)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamRole)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_DELETE_BATCH_FRIEND_CALLBACK, self, self.deleAllCallback)
end

-- 注销监听事件(可选)
function FriendsLayer:unRegisterListener()
        -- 好友列表
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER, self, self.refreshMainLayer)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_REFRESH_END, self, self.refreshGuildLayer)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_JOIN, self, self.addTeamRole)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamRole)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_DELETE_BATCH_FRIEND_CALLBACK, self, self.deleAllCallback)
end

--tableview 
function FriendsLayer:numberOfCellsInTableView(table)
    -- body
    local count = #self.currentSelectedData
    return count
end

function FriendsLayer:scrollViewDidScroll(view)
    -- body
end

function FriendsLayer:scrollViewDidZoom(view)
    -- body
end

function FriendsLayer:tableCellTouched(table,cell)
    -- body
end

function FriendsLayer:cellSizeForTable(table,idx)
    return 286, 95
end

function FriendsLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    local data = self.currentSelectedData[idx + 1];
    data.tableCellIndex = idx
    xpcall(function() 
        local status = Game.CELL_STATE.NORMAL
        if self.infoMode == INFO_MODE.DEL_MODE then
            if self.delSelectCells[data.PK] then
                status = Game.CELL_STATE.DEL_AND_SELECTED
            else
                status = Game.CELL_STATE.DEL_AND_NO_SELECT
            end
        end
        if cell == nil then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.FriendMemberCell:create(data, idx, self, status)
            pArchiveCell:setName("cell")
            pArchiveCell:leftBottom(0, 0)
            cell:addChild(pArchiveCell)
            table.insert(self.tableCells, pArchiveCell)
            pArchiveCell:setTag(data.PK)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(data, idx, status)
           
            for k, v in pairs(self.tableCells) do
                if obj == v then
                    table.remove(self.tableCells, k)
                end
            end
            table.insert(self.tableCells, obj)
            obj:setTag(data.PK)
        end
    end, 
    function(e) 
        printError("--------------------FriendsLayer:tableCellAtIndex---------------------error")
    end, 1) 

    return cell
end

--队伍上线下线
function FriendsLayer:updateOnLineState(pk, online)
    self:updateOnLineStateImp(pk, online, self.friendsData, SHOW_DATA_TYPE.FRIEND)
    self:updateOnLineStateImp(pk, online, self.guildMemberData, SHOW_DATA_TYPE.GUILD)
end

function FriendsLayer:updateOnLineStateImp(pk, online, list, listType)
    if list == nil then
        return
    end
    for k, v in pairs (list) do
        if v.PK == pk then
            v.loginStatus = online
            if listType == self.showDataType and v.tableCellIndex ~= nil then
                self.friendTableView:updateCellAtIndex(v.tableCellIndex)
            end
            break
        end
    end
end

function FriendsLayer:addTeamRole(data)
    self:addTeamRoleImp(data, self.friendsData, SHOW_DATA_TYPE.FRIEND)
    self:addTeamRoleImp(data, self.guildMemberData, SHOW_DATA_TYPE.GUILD)
end

function FriendsLayer:addTeamRoleImp(data, list, listType)
    if list == nil then
        return
    end
    for k, v in pairs(list) do
        if v.PK == data:getPK() then
            v.teammate = true
            if listType == self.showDataType and not tolua.isnull(self.friendTableView) and v.tableCellIndex ~= nil then
                self.friendTableView:updateCellAtIndex(v.tableCellIndex)
            end
            break
        end
    end
end

function FriendsLayer:removeTeamRole(pk)
    self:removeTeamRoleImp(pk, self.friendsData, SHOW_DATA_TYPE.FRIEND)
    self:removeTeamRoleImp(pk, self.guildMemberData, SHOW_DATA_TYPE.GUILD)
end

function FriendsLayer:removeTeamRoleImp(pk, list, listType)
    if list == nil then
        return
    end
    for k, v in pairs(list) do
        if v.PK == pk then
            v.teammate = false
            if listType == self.showDataType and not tolua.isnull(self.friendTableView) and v.tableCellIndex ~= nil then
                self.friendTableView:updateCellAtIndex(v.tableCellIndex)
            end
            break
        end
    end
end

-- 组队邀请模式, 定期刷新邀请时间
function FriendsLayer:schedulerTimeOut()
    if self.friendsData ~= nil then
        for k, v in pairs(self.friendsData) do
            if v.time ~= nil and v.time > 0 then
                v.time = v.time - 1
                if v.time <= 0 then
                    GameDataManager:getInstance():setInvitationTime(v.PK, nil)
                    self.friendTableView:updateCellAtIndex(k - 1)
                end
            end
        end
    end
    if self.guildMemberData ~= nil then
        for k, v in pairs(self.guildMemberData) do
            if v.time ~= nil and v.time > 0 then
                v.time = v.time - 1
                if v.time <= 0 then
                    GameDataManager:getInstance():setInvitationTime(v.PK, nil)
                    self.friendTableView:updateCellAtIndex(k - 1)
                end
            end
        end
    end
end









































---- 普通好友模式 ---------------------
-- 初始化好友模式界面
function FriendsLayer:initInfoModel()
    print("FriendsLayer:initInfoModel")
    
    -- 设置显示界面
    self.firendNumberLayer:setVisible(true)
    self.selfInfoLayer:setVisible(true)

    -- 隐藏组队邀请模式的公会和好友列表切换按钮
    local delayCallbackfunc = cc.CallFunc:create(function()
            AvalonUtil.pauseNode(self.guildButtonLayer)
            self:showInputLayer(false)
        end
    )
    local delayAction = cc.DelayTime:create(0.1)
    self:runAction(cc.Sequence:create(delayAction, delayCallbackfunc))

    -- 打开添加好友界面的按钮
    self.openAddFriendBtn = self.friendModel.openAddFriendBtn
    self.openAddFriendBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showInputLayer(true)
    end)
    
    -- 好友数量标签
    self.friendNumber = self.friendModel.friendCountLabel
    self:refreshFriendNumber(0)    

    -- 初始化查找好友输入框layer
    local boxBgName = "ui_friends_banner_yellow.png"
    local libIDEdit = cc.EditBox:create({width = 175, height = 24}, cc.Scale9Sprite:createWithSpriteFrameName(boxBgName), cc.Scale9Sprite:createWithSpriteFrameName(boxBgName), cc.Scale9Sprite:createWithSpriteFrameName(boxBgName))
    libIDEdit:setFontSize(18)
    libIDEdit:setPlaceholderFont(UI.FONT_STANDARD, 14)
    libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_170_170_170)
    libIDEdit:setPlaceHolder(UI.TEXT_1170400)
    libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    libIDEdit:setPosition(self.friendModel.editBoxBg._width / 2, self.friendModel.editBoxBg._height / 2)
    libIDEdit:registerScriptEditBoxHandler(handler(self, self.editboxEventHandler))
    self.friendModel.editBoxBg:addChild(libIDEdit)
    self.libIDEdit = libIDEdit

    -- 添加按钮
    self.addBtn = self.friendModel.addFriendBtn
    self.addBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onAddClick)

    -- 关闭添加好友界面的按钮
    self.backBtn = self.friendModel.backBtn
    self.backBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showInputLayer(false)
    end)

    -- 初始化玩家pk
    local pk = GameDataManager:getInstance():getMasterPK()
    self.sId = self.friendModel.myIdLabel
    self.sId:setText(UI.TEXT_1170401..pk)

    -- 初始化确认添加好友
    self.inviteName = self.friendModel.confirmInfoLabel

    -- 拒绝
    self._refuseBtn = self.friendModel.cancelBtn
    self._refuseBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRefuseClick)

    -- 同意
    self._agreeBtn = self.friendModel.okbtn
    self._agreeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onAgreeClick)
    
    --删除模式切换
    self._modeDeleteBtn = self.friendModel.modeDeleteBtn
    self._modeDeleteBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self.infoMode = self.infoMode == INFO_MODE.DEL_MODE and INFO_MODE.NORMAL or INFO_MODE.DEL_MODE
        self.friendTableView:stopScrolling()
        self:refreshInfoModeData(true)
        self:refreshInfoMode()
    end)

    --黑名单列表
    self._modeBlockListBtn = self.friendModel.modeBlockListBtn
    self._modeBlockListBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self.infoMode = self.infoMode == INFO_MODE.BLOCK_LIST_MODE and INFO_MODE.NORMAL or INFO_MODE.BLOCK_LIST_MODE
        self.friendTableView:stopScrolling()
        self:refreshInfoModeData(true)
        self:refreshInfoMode()
    end)

    -- 删除好友确认
    self._delAllOkBtn = self.friendModel.delAllOkBtn
    self._delAllOkBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
         self:deleAllClick()
    end)
    self:refreshInfoMode()
end

-- 更新列表数据
function FriendsLayer:refreshInfoModeData(isReloadData)
    if self.showModel == SHOW_MODEL.INFO or self.showDataType == SHOW_DATA_TYPE.FRIEND then
        self.blockData = Game.ChatManager:getInstance():getAllShieldPlayer()
        for i,v in ipairs(self.blockData) do
            if (v.PK == nil and v.pk ~= nil) then
                v.PK = v.pk
            end
        end
        self.friendsData = Game.FriendManager:getInstance():getFriendData()
        if (self.infoMode == INFO_MODE.BLOCK_LIST_MODE and #self.inviteData <= 0) then
            self.currentSelectedData = self.blockData
        else
            self.currentSelectedData = self.friendsData
        end
    end
    if (isReloadData) then
        self.friendTableView:reloadData()
    end
end

-- 刷新普通好友模式界面
function FriendsLayer:refreshMainLayer()
    print("FriendsLayer:refreshMainLayer")
    UI.WaitingLayer:hideWaiting()

    -- 刷新数据
    self.inviteData = Game.FriendManager:getInstance():getInviteData()
    self.friendsData = Game.FriendManager:getInstance():getFriendData()
    self:refreshInfoModeData()

    -- 标记队友
    for k, v in pairs(self.friendsData) do
        v.teammate = false
        if TeamDataManager:hasTeam() and TeamDataManager:getTeamDataForPK(v.PK) ~= nil  then
            v.teammate = true
        end
        v.time = nil
    end

    -- 刷新现在模式模式
    if self.showModel == SHOW_MODEL.INFO then
        self:refreshInfoMode()
    end

    -- 刷新无好友提示
    self:refreshNoFriendLabel()
end

-- 更新无好友提示
function FriendsLayer:refreshNoFriendLabel(isToReload)
    -- 设置现在展示的数据, 如果是普通好友列表模式和邀请模式的好友列表, 展示好友数据
    if (isToReload == nil) then isToReload = true end
    if self.showModel == SHOW_MODEL.INFO or self.showDataType == SHOW_DATA_TYPE.FRIEND then
        if (isToReload) then
            self.friendTableView:reloadData(false)
        end
        self:refreshFriendNumber(#self.currentSelectedData)
        if #self.currentSelectedData > 0 then
            self._noFriendTips:hide()
        else
            local LanguageManager = require "app.game.LanguageManager"
            self._noFriendTips:show()
            local noFriendStr
            if (self.infoMode == INFO_MODE.BLOCK_LIST_MODE) then
                self._noFriendTips:setText(LanguageManager:getInstance():getLocalString(1112854))
            else
                self._noFriendTips:setText(LanguageManager:getInstance():getLocalString(1111030))
            end
        end
    end
end

-- 刷新好友数量
function FriendsLayer:refreshFriendNumber(count)
    if self.friendNumber then
        self.friendNumber:setText(string.format("%d/%d", count, PublicDefine.CONST_DEFINITION.MAX_FRIENDS_NUM))
        self.friendModel.friendCountIcon:rightUp(self.friendNumber._width + 20, self.friendModel.friendCountIcon._posY)
    end
end

-- 刷新邀请界面
function FriendsLayer:refreshInviteLayer()
    if self.infoMode == INFO_MODE.DEL_MODE or self.infoMode == INFO_MODE.BLOCK_LIST_MODE then
        return
    end
    self._refuseBtn:enable()
    self._agreeBtn:enable()
    local size = cc.size(0, 0)
    if #self.inviteData > 0 then
        local data = self.inviteData[1]
        self.inviteName:setText(string.format(UI.TEXT_1170604, data.nickName))
        if not self.inviteBg:isVisible() then
            self.inviteBg:show()
        end
    else
        self._refuseBtn:disable()
        self._agreeBtn:disable()    
        self.inviteBg:hide()
    end
end

-- 刷新不同模式下的列表内容
function FriendsLayer:refreshInfoMode()
    self._modeBlockListBtn:show()

    if self.infoMode == INFO_MODE.BLOCK_LIST_MODE and #self.inviteData <= 0 then
        -- 清除其他模式
        self._delAllOkBtn:hide()
        self._modeDeleteBtn:hide()
        self.delSelectCells = {}
        self._modeDeleteBtn:setNormal("ui_friends_btn_delete_0.png")
        if self.confirmTips and not tolua.isnull(self.confirmTips) then
            self.confirmTips:removeFromParent()
            self.confirmTips = nil
        end

        -- 改变为黑名单删除模式
        self._modeBlockListBtn:show()
        self._modeBlockListBtn:setNormal("ui_friends_btn_0.png")
        for k, v in pairs(self.tableCells) do
            v:changeMode(self.infoMode)
        end
    else
        local inviteNum = #self.inviteData
        local friendNumber = #self.currentSelectedData
        if (inviteNum <= 0) then
            self._modeBlockListBtn:show()
            self._modeBlockListBtn:setNormal("ui_friends_btn_1.png")
        else
            self._modeBlockListBtn:hide()
        end
        if friendNumber > 2 and inviteNum <= 0 then
            self._modeDeleteBtn:show()
            if self.infoMode == INFO_MODE.DEL_MODE then
                self._modeBlockListBtn:hide()
                self._delAllOkBtn:show()
                self._delAllOkBtn:setNormal("ui_btn_yes1_0.png")
                self._modeDeleteBtn:setNormal("ui_friends_btn_delete_1.png")
            else
                self._delAllOkBtn:hide()
                self.delSelectCells = {}
                self._modeDeleteBtn:setNormal("ui_friends_btn_delete_0.png")
            end
            for k, v in pairs(self.tableCells) do
                v:changeMode(self.infoMode)
            end
        else
            self.infoMode = INFO_MODE.NORMAL
            self._delAllOkBtn:hide()
            self._modeDeleteBtn:hide()
            self.delSelectCells = {}
            self._modeDeleteBtn:setNormal("ui_friends_btn_delete_0.png")
            for k, v in pairs(self.tableCells) do
                v:changeMode(self.infoMode)
            end
            if self.confirmTips and not tolua.isnull(self.confirmTips) then
                self.confirmTips:removeFromParent()
                self.confirmTips = nil
            end
        end
    end

    -- 刷新无好友提示
    self:refreshNoFriendLabel(false)
    
    -- 刷新邀请同意栏
    self:refreshInviteLayer()
end

-- 显示或隐藏添加好友界面
function FriendsLayer:showInputLayer(show)
    if show then
        self.firendNumberLayer:setVisible(false)
        AvalonUtil.pauseNode(self.firendNumberLayer)
        self.addFriendLayer:setVisible(true)
        AvalonUtil.resumeNode(self.addFriendLayer)
    else
        self.firendNumberLayer:setVisible(true)
        AvalonUtil.resumeNode(self.firendNumberLayer)
        self.addFriendLayer:setVisible(false)
        AvalonUtil.pauseNode(self.addFriendLayer)
    end
end

-- 添加好友按钮回调
function FriendsLayer:onAddClick()
    local message = self.libIDEdit:getText() or ""
    message = string.trim(message)
    if message == "" then
        local LanguageManager = require "app.game.LanguageManager"
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111825))
        return
    end
    local id = checkint(message)
    if id == nil or id == 0 then
        UI.ScrollBar:createByText(UI.TEXT_1170415) 
        self.libIDEdit:setText("")
        return
    end 
    
    if id < 10000000 then--玩家pk至少8位， 且服务器承诺以后不会改
        UI.ScrollBar:createByText(UI.TEXT_1170420)
        return
    end

    if self.isCd then
        UI.ScrollBar:createByText(UI.TEXT_1170412)
        return
    end
    if RoleBehaviorManager:friendSysCheck() then
        printWarn(" been blocked when add friend !")
        return
    end
    local isSuccess = Game.FriendManager:getInstance():inviteFriend(id)
    if isSuccess then
        self.libIDEdit:setText("")
        self.isCd = true
        if self.schedulerID ~= 0 then
            scheduler:unscheduleScriptEntry(self.schedulerID)
            self.schedulerID = 0
        end
        self.schedulerID = scheduler:scheduleScriptFunc(function()
            self.isCd = false
        end, 1, false)
    end
end

-- 拒绝好友邀请回调
function FriendsLayer:onRefuseClick()
    -- body
    local data = self.inviteData[1]
    if data ~= nil then
        if RoleBehaviorManager:friendSysCheck() then
            printWarn(" been blocked when refuse friend invition!")
            return
        end
        self._refuseBtn:disable()
        self._agreeBtn:disable()
        GameManager:handleFriendInvition(GameDataManager:getInstance():getMasterPK(), data.PK, false)
    end
end

-- 同意好友邀请回调
function FriendsLayer:onAgreeClick()
    local data = self.inviteData[1]
    if data ~= nil then
        if RoleBehaviorManager:friendSysCheck() then
            printWarn(" been blocked when agree friend invition!")
            return
        end
        self._refuseBtn:disable()
        self._agreeBtn:disable()
        GameManager:handleFriendInvition(GameDataManager:getInstance():getMasterPK(), data.PK, true)
    end
end

-- 好友添加文字编辑回调
function FriendsLayer:editboxEventHandler(eventType)
    print("FriendsLayer:editboxEventHandler(eventType) .. "..eventType)
    if eventType == "began" then
    elseif eventType == "ended" then
    elseif eventType == "changed" then
        self.lastInputText = self:judeInputTextLength()
    elseif eventType == "return" then
    end
end

-- 帮助判断回车符的方法
function FriendsLayer:judeInputTextLength()
    local message = self.libIDEdit:getText() or ""
    local isHave = string.find(message, "\n")
    if isHave ~= nil then
        message = string.gsub(message, "\n", "")
        self.libIDEdit:setText(message)
        AvalonUtil.closeKeyBoard(self.libIDEdit)
        return
    end
end

-- 选择删除的人回调
function FriendsLayer:selectDelPlayer(pk, isSelect)
    if isSelect then
        self.delSelectCells[pk] = true
    else
        self.delSelectCells[pk] = nil
    end
    if table.nums(self.delSelectCells) > 0 then
        self._delAllOkBtn:setNormal("ui_btn_yes1_1.png")
    else
        self._delAllOkBtn:setNormal("ui_btn_yes1_0.png")
    end
end

-- 删除所有人回调
function FriendsLayer:deleAllClick()
    if table.nums(self.delSelectCells) <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212357)
        return
    end 
    if RoleBehaviorManager:friendSysCheck() then
        printWarn(" been blocked when delete all friend !")
        return
    end
    local tip = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212358, function()
        local list = {}
        for k, v in pairs(self.delSelectCells) do
            if Game.FriendManager:getInstance():isFriend(k) then
                table.insert(list, k)
            end
        end

        if #list > 0 then
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetFriendSystem:deleteBatchFriend(list)
        end
    end)
    tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
    self.confirmTips = tip
end

-- 删除全部网络回调
function FriendsLayer:deleAllCallback(pks)
    self.infoMode = INFO_MODE.NORMAL  
    self.delSelectCells = {}
    self:refreshMainLayer()
    -- body
end





































---- 组队邀请模式 ----------------------
-- 初始化组队邀请模式的好友/公会列表
function FriendsLayer:initTeamModel()
    -- 暂停普通好友列表模式的按钮
    local delayCallbackfunc = cc.CallFunc:create(function()
            AvalonUtil.pauseNode(self.inviteBg)
        end
    )
    local delayAction = cc.DelayTime:create(0.1)
    self:runAction(cc.Sequence:create(delayAction, delayCallbackfunc))

    -- 组队邀请提示标签
    print("FriendsLayer:initTeamModel")
    self.teamInviteFriendLabel:setText(UI.TEXT_1300001);
    self.teamInviteFriendLabel:setVisible(true)

    -- 展示切换公会和好友的布局和那妞
    self.guildButtonLayer:setVisible(true)
    self.friendButton:setBtnStatus(ButtonState.ACTIVE);
    self.friendButton:disable()
    self.guildButton:enable()
    self.guildButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:switchTeamAndGuild(true)
    end)
    self.friendButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:switchTeamAndGuild(false);
    end)

    -- 隐藏删除好友按钮和确认删除按钮
    self.friendModel.modeDeleteBtn:hide()
    self.friendModel.delAllOkBtn:hide()
end

-- 组队邀请模式下切换公会和好友列表
function FriendsLayer:switchTeamAndGuild(show)
    local data = nil
    if show then
        if MasterDataManager:getGuildData() == nil then
            UI.ScrollBar:createByText(UI.TEXT_1170321)
            return
        end
        self.showDataType = SHOW_DATA_TYPE.GUILD
        self.friendButton:setBtnStatus(ButtonState.NORMAL)
        self.guildButton:setBtnStatus(ButtonState.ACTIVE)
        self.friendButton:enable()
        self.guildButton:disable()
        if not self.requireGuildData then
            self.requireGuildData = true
            Net.NetGuildSystem:reqGuild(MasterDataManager:getGuildData().version)
        end
        data = self.guildMemberData
    else
        self.showDataType = SHOW_DATA_TYPE.FRIEND
        self.guildButton:setBtnStatus(ButtonState.NORMAL)
        self.friendButton:setBtnStatus(ButtonState.ACTIVE)
        self.friendButton:disable()
        self.guildButton:enable()
        data = self.friendsData
    end
    if data ~= nil and self.currentSelectedData ~= data then
        self.currentSelectedData = data
        self.friendTableView:reloadData()
    end
end

-- 更新组队邀请模式下公会列表内公会成员信息
-- 公会成员的字段，与好友的字段不一样，需要封装一下
function FriendsLayer:refreshGuildLayer()
    local datas = MasterDataManager:getGuildData():getMember()
    self.guildMemberData = {}
    for k, v in pairs(datas) do
        if v.PK ~= RoleDataManager:getMasterPK() then
            v.nickName = v.name
            v.roleLV = v.lv
            v.teammate = false
            if TeamDataManager:hasTeam() and TeamDataManager:getTeamDataForPK(v.PK) ~= nil then
                v.teammate = true
            end

            if self.friendsData then
                for k1, v1 in pairs(self.friendsData) do
                    if v1.PK == v.PK and v1.time ~= nil then
                        v.time = v1.time
                        break
                    end
                end
            end
            v.time = nil
            table.insert( self.guildMemberData, v)
        end
    end
    
    if self.showModel == SHOW_MODEL.TEAM and self.showDataType == SHOW_DATA_TYPE.GUILD then
        self.currentSelectedData = self.guildMemberData
        self.friendTableView:reloadData()
        self:refreshFriendNumber(#self.currentSelectedData)
        self._noFriendTips:hide()
    end
end