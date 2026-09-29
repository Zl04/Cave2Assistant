-- ChoiceGuildIconPanel.lua
-- Author:zp
-- 2017年9月14日
-- Using: 用户选择公会图标

require("app.ui.guild.GuildIconCell")

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local ChoiceGuildIconPanel = class("ChoiceGuildIconPanel", UI.HWBtnComponent)
UI.ChoiceGuildIconPanel = ChoiceGuildIconPanel

local winSize = cc.Director:getInstance():getWinSize()

local LAYOUT_DESIGN_WIDTH = 799
local LAYOUT_DESIGN_HEIGHT = 144

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_icon.plist"
}

--构造函数(必备)
function ChoiceGuildIconPanel:ctor()
	--窗口大小
    ChoiceGuildIconPanel.super.ctor(
    self,UIType.CHOICE_GUILD_ICON_PANEL,
    COM_RES_LIST,
    LAYOUT_DESIGN_WIDTH,	
    LAYOUT_DESIGN_HEIGHT
    )

    self._iconDataList = nil

    self._icon = nil
    self._choiceIconID = nil
    self._guildNameEdit = nil

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function ChoiceGuildIconPanel:dtor()
    ChoiceGuildIconPanel.super.dtor(self)

    self._iconDataList = nil

    self:unRegisterListener();
end

-- 初始化(必备)
function ChoiceGuildIconPanel:init(iconList, choiceCallBack)
    self._iconDataList = iconList
    self._choiceCallBack = choiceCallBack

    ChoiceGuildIconPanel.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function ChoiceGuildIconPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加图标选择框
    local bgImage = UI.Image:create()
    bgImage:init("ui_guild_banner_box2.png")
    bgImage:center()
    self._contentLayout:addChild(bgImage)

    -- 公会图标列表
    self.guildListTableView = cc.TableView:create(cc.size(539,144))
    self.guildListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    self.guildListTableView:setPosition(cc.p(130, 0))
    self.guildListTableView:setDelegate()
    self.guildListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    -- self.guildListTableView:setHi
    self._contentLayout:addChild(self.guildListTableView)
    self.guildListTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.guildListTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)

    self.guildListTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)

    self._contentLayout:setTouchEnable(true)
    self._contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        print("CreateOrJoinPanel:onInitView self._contentLayout COMPONENT_TOUCH_OUTSIDE")
        -- 处理商店效果移除，并且恢复头像等
        self:close()

        -- self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
    end)
end

-- 模版函数：更新组建的视图(必备)
function ChoiceGuildIconPanel:onUpdateView()

end

function ChoiceGuildIconPanel:showWaiting()
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

-- 购买图标返回
function ChoiceGuildIconPanel:buyIconResponse(status, data)
    UI.WaitingLayer:hideWaiting()
end
    
-- 注册监听事件(可选)
function ChoiceGuildIconPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_BUY_GUILD_ICON, self, self.buyIconResponse)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function ChoiceGuildIconPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_BUY_GUILD_ICON, self, self.buyIconResponse)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end
function ChoiceGuildIconPanel:onCurrencyChangeHandler()
    self.guildListTableView:reloadData()
end

function ChoiceGuildIconPanel:numberOfCellsInTableView(table)
    if self._iconDataList then
        return #self._iconDataList
    else 
        return 0
    end
end

function ChoiceGuildIconPanel:scrollViewDidScroll(view)
   
end

function ChoiceGuildIconPanel:scrollViewDidZoom(view)
    print("ChoiceGuildIconPanel:scrollViewDidZoom")
end

function ChoiceGuildIconPanel:tableCellTouched(table, cell)
    print("ChoiceGuildIconPanel:tableCellTouched",cell:getIdx())

    -- 回调选中那个
    if(self._choiceCallBack) then
        -- 判断是否已经购买
        local iconData = self._iconDataList[cell:getIdx() + 1]
        if (tonumber(iconData.iconCost) ~= 0) then
            -- 弹出对话框提示花费购买图标
            local curDiamond = RoleDataManager:getMaster():getDiamond()
            if (Avalon.MathUtil:checkDiamonEnough(tonumber(iconData.iconCost), curDiamond)) then
                UI.TipsLayer:createBuyGuildIconTips(iconData, function()
                    -- 显示加载页面
                    self:showWaiting()

                    Net.NetGuildSystem:buyGuildIcon(RoleDataManager:getMasterPK(), iconData.iconID)
                end)
            else
                UI.TipsLayer:onDiamondNotEnough()
            end
        else
            self._choiceCallBack(iconData)  
            self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
        end
    end
end

function ChoiceGuildIconPanel:cellSizeForTable(table,idx)
    return 97,125
end

function ChoiceGuildIconPanel:tableCellAtIndex(tableView,idx)
    print("ChoiceGuildIconPanel:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()

            local pArchiveCell = UI.GuildIconCell:create(self._iconDataList[idx + 1],idx)
            pArchiveCell:setName("cell")
            pArchiveCell:leftUp(0, -125)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self._iconDataList[idx + 1],idx)
        end
    end, 
    function(e) 
        printError("--------------------ChoiceGuildIconPanel:tableCellAtIndex---------------------error")
    end, 1) 

    return cell;
end