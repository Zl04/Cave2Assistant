-- CaveActivityDSP.lua
-- Author:zp
-- 2019年1月8日
-- Using:活动副本的DSP

local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"
require "app.ui.iapshop.IapShopMonthCardLayer"
require "app.ui.UIDefine"
require "app.ui.mainUi.CaveActivityDSPCell"

UI = UI or {}
local CaveActivityDSP = class("CaveActivityDSP", UI.HWBtnComponent)
UI.CaveActivityDSP = CaveActivityDSP

local COM_RES_LIST = {
    "ui_town_activity.plist",
}

local COMPONENT_WIDTH = 325
local COMPONENT_HEIGHT = 252

function CaveActivityDSP:ctor()
    CaveActivityDSP.super.ctor(
        self, 603,
        COM_RES_LIST,
        COMPONENT_WIDTH,
        COMPONENT_HEIGHT
    )
    self.rootLayer = nil           --root节点
    self._isHide = false
    self.dspDataArr = {}

    self:init()
end

-- 析构
function CaveActivityDSP:dtor()
    CaveActivityDSP.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function CaveActivityDSP:init()
    CaveActivityDSP.super.init(self)
    self:registerListener()
end


-- 模版函数：初始化组建的视图
function CaveActivityDSP:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_activity_ranking_bg.png")
    bg:center()
    self:addChild(bg)
    
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(COMPONENT_WIDTH, COMPONENT_HEIGHT)
    self:addChild(self.rootLayer)

    

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1212085, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    titleText:centerUp(24- titleText:getContentSize().height/2)
    self:addChild(titleText)
    self.titleText = titleText

    local leftIcon = UI.Image:create()
    leftIcon:init("ui_public_banner_pattern.png")
    leftIcon:centerLeft(- leftIcon:getContentSize().width - 10)
    titleText:addChild(leftIcon)

    local rightIcon = UI.Image:create()
    rightIcon:init("ui_public_banner_pattern.png")
    rightIcon:centerRight(- rightIcon:getContentSize().width - 10)
    titleText:addChild(rightIcon)

    -- -- 
    -- local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light2.png")
    -- line:setContentSize(317, 1)
    -- line:setAnchorPoint(cc.p(0, 0.5))
    -- line:setPosition(cc.p(14, 204))
    -- self:addChild(line)

    -- 显示列表
    self._tableView = UI.TableView.new({}, 278, 166)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftUp(15, 49)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)

        return 278,31
    end) 

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        if(cell == nil) then 
            xpcall(function()
                cell = UI.CaveActivityDSPCell.new()
                cell:init(self.dspDataArr[idx + 1], self._tableView)
            end, 
            function(e) 
                printError("------------------------ActivityPanel:tableCellAtIndex-----------------error")
            end, 1) 
        else 
            cell:reloadData(self.dspDataArr[idx + 1])
        end
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        if(self.dspDataArr) then 
            return table.nums(self.dspDataArr) 
        end

        return 0
    end)
    self._tableView:onTableCellTouched(function(table, cell)
        
    end)
    self.rootLayer:addChild(self._tableView, 20)

    -- 底部显示自己的属性值
    local masterCell = UI.CaveActivityDSPCell.new()
    masterCell:init()
    masterCell:sethideLine()
    masterCell:setPosition(15, 19 - 15.5)
    self:addChild(masterCell, 21)
    self._masterCell = masterCell

    self:refreshDSP(self.dspDataArr)


    self.moreInfoBtn = UI.Button:create()
    self.moreInfoBtn:init("ui_btn_arrow_up_0.png", "ui_btn_arrow_up_1.png")
    self.moreInfoBtn:centerRight(-50)
    self.moreInfoBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onOpenQuickChatClick)
    self:addChild(self.moreInfoBtn, 20)
    self.moreInfoBtn:closeClickScale()
    self.moreInfoBtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(-10,0)),cc.MoveBy:create(0.5,cc.p(10,0))))) 
    self.moreInfoBtn:rotate(270)
end

-- 模版函数：更新组建的视图
function CaveActivityDSP:onUpdateView()

end

function CaveActivityDSP:onOpenQuickChatClick()
    self._isHide = not self._isHide
    if(self._isHide) then 
        self.moreInfoBtn:rotate(90)

        self:stopAllActions()
        self:runAction(
            cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(-COMPONENT_WIDTH,self:getPositionY()))
                )
            )
    else 
        self:stopAllActions()
        self:runAction(
            cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(0,self:getPositionY()))
                )
            )

        self.moreInfoBtn:rotate(270)
    end
end

function CaveActivityDSP:refreshDSP(data)
    if(data) then 
        self.dspDataArr = data
        if(self._tableView) then
            self._tableView:reloadData()
        end
        local dspData = self:getMasterDSPData()
        mvc.worldBossModel:setMyHurtRank(dspData)
        if(self._masterCell and dspData) then 
            self._masterCell:reloadData(dspData)
        end
    end
end

function CaveActivityDSP:getMasterDSPData()
    local masterData = nil
    if(self.dspDataArr) then 
        for k,dspData in ipairs(self.dspDataArr) do 
            if(dspData:getIsMaster()) then 
                masterData = dspData
                break
            end
        end
    end

    return masterData
end

-- 注册监听事件
function CaveActivityDSP:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_REFRESH_DSP, self, self.refreshDSP)
end

-- 注销监听事件
function CaveActivityDSP:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_REFRESH_DSP, self, self.refreshDSP)
end
