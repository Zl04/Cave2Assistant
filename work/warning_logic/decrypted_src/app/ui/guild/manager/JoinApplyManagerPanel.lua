-- JoinApplyManagerPanel.lua
-- Author:zp
-- 2017年9月21日
-- Using:申请加入管理

require("app.ui.guild.manager.JoinApplyCell")

local LanguageManager = require("app.game.LanguageManager")

local GuildTitle = PublicDefine.GuildTitle

UI = UI or {}

local JoinApplyManagerPanel = class("JoinApplyManagerPanel", UI.HWBtnComponent)
UI.JoinApplyManagerPanel = JoinApplyManagerPanel

local winSize = cc.Director:getInstance():getWinSize()

local LAYOUT_DESIGN_WIDTH = 283
local LAYOUT_DESIGN_HEIGHT = 470

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_icon.plist",
    "ui_town_guild_general.plist",
    "ui_town_guild_management.plist",
}

--构造函数(必备)
function JoinApplyManagerPanel:ctor()
	--窗口大小
    JoinApplyManagerPanel.super.ctor(
    self,UIType.JOIN_APPLY_MANAGER_PANEL,
    COM_RES_LIST,
    LAYOUT_DESIGN_WIDTH,	
    LAYOUT_DESIGN_HEIGHT
    )
    self._choiceTabIndex = 0
    self.guildData = MasterDataManager:getGuildData()
    self.guildListTableView = nil

    self.searchGuildList = nil
    self.lastMaxGuildID =0
    self.bucketIdx = nil
    self.bucketDis = nil


    self._searchEdit = nil

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:setSwallowTouches(true);
    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function JoinApplyManagerPanel:dtor()
    JoinApplyManagerPanel.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function JoinApplyManagerPanel:init()
    JoinApplyManagerPanel.super.init(self)
    -- Avalon.Scheduler:scheduleUpdateOnce(self, function() 
    --     self:close()
    -- end, 0.1)
    -- self:requestJoinList()
end


-- 模版函数：初始化组建的视图(必备)
function JoinApplyManagerPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_guild_mamagement_banner_up.png")
    bg:center()
    contentLayout:addChild(bg)

  
    -- 申请列表
    self.guildListTableView = cc.TableView:create(cc.size(249 + 14,370))
    self.guildListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.guildListTableView:setPosition(cc.p(13, 90))
    self.guildListTableView:setDelegate()
    self.guildListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    bg:addChild(self.guildListTableView, 20)
    self.guildListTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.guildListTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.guildListTableView:initScrollBar()
    self.guildListTableView:setScrollBarColor(UI.SLIDER_COLOR_Light)

    -- 蒙层
    local mask = UI.Image:create()
    mask:init("ui_guild_mamagement_banner_mask.png")
    mask:centerBottom(90)
    bg:addChild(mask, 20)

    -- 全部拒绝按钮
    local callAllButton = UI.Button:create()
    callAllButton:init("ui_btn_yellow2_0.png","ui_btn_yellow2_1.png","ui_btn_yellow2_2.png")
    callAllButton:centerBottom(26)
    callAllButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 拒绝所有申请
        Net.NetGuildSystem:cancelAllReq()
    end)
    bg:addChild(callAllButton)

    local callAllText = UI.Text:create()
    callAllText:init(LanguageManager:getInstance():getLocalString(1110588), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    callAllText:center()
    callAllButton:addChild(callAllText, 10)
    
    self._contentLayout:setTouchEnable(true)
    self._contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)

        self:exitJoinApplyManager()
    end)

    self.guildListTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
end

-- 模版函数：更新组建的视图(必备)
function JoinApplyManagerPanel:onUpdateView()

end

-- 退出加入管理
function JoinApplyManagerPanel:exitJoinApplyManager()
    self:close()
    -- self.guildListTableView:setVisible(false)
    -- self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
end

function JoinApplyManagerPanel:requestJoinList()
    --权限
    local GameDataManager = require("app.game.GameDataManager")
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
        return
    end
    Net.NetGuildSystem:reqJoinReqList()
end

function JoinApplyManagerPanel:refreshJoinList()
    self.guildListTableView:reloadData()
end

-- 没有申请了
function JoinApplyManagerPanel:noJoinApply()
    self:exitJoinApplyManager()
end

-- 注册监听事件(可选)
function JoinApplyManagerPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_JOIN_LIST_CHANGE, self, self.refreshJoinList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.requestJoinList)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.noJoinApply) 
end

-- 注销监听事件(可选)
function JoinApplyManagerPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_JOIN_LIST_CHANGE, self, self.refreshJoinList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_HAVE_JOIN_REQ, self, self.requestJoinList)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_NO_JOIN_REQ, self, self.noJoinApply) 
end

function JoinApplyManagerPanel:numberOfCellsInTableView(table)
    if(self.guildData) then
        return #self.guildData.applyJoinList
    else
        return 0
    end
end

function JoinApplyManagerPanel:scrollViewDidScroll(view)
    
end

function JoinApplyManagerPanel:scrollViewDidZoom(view)
end

function JoinApplyManagerPanel:tableCellTouched(table,cell)

end

function JoinApplyManagerPanel:cellSizeForTable(table,idx)
    return 249,106
end

function JoinApplyManagerPanel:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    xpcall(function()      
        if nil == cell then
            cell = cc.TableViewCell:new()

            local pArchiveCell = UI.JoinApplyCell:create(self.guildData.applyJoinList[idx + 1],idx)
            pArchiveCell:setName("cell")
            pArchiveCell:leftUp(125, -53)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.guildData.applyJoinList[idx + 1], idx)
        end
    end, 
    function(e) 
        printError("--------------------JoinApplyManagerPanel:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

