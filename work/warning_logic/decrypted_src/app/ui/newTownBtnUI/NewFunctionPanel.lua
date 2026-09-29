-- NewFunctionPanel.lua
-- Author:hongyi.yan
-- 2020年10月21日
-- Using:功能按钮

require "app.ui.common.ScrollView"
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"
require "app.ui.shoplayer.ShopGrid"
require "app.ui.shoplayer.BagGoodsPanel"

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local VIRTUAL_ITEM_TYPE = PublicDefine.VIRTUAL_ITEM_TYPE

local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local NewFunctionPanel = class("NewFunctionPanel", UI.HWBtnComponent)
UI.NewFunctionPanel = NewFunctionPanel

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    "ui_common_btn.plist"
}


function NewFunctionPanel:ctor()
    NewFunctionPanel.super.ctor(self, UIType.FUNCTION_NPC, COM_RES_LIST, winSize.width, winSize.height)
    self.btnCellList = {}
    self:registerListener()
    
end

function NewFunctionPanel:dtor()
    NewFunctionPanel.super.dtor(self)
    self.btnCellList = nil
    self:unRegisterListener()
end

-- public:
-- 初始化
function NewFunctionPanel:init(dataArr, btnPos, btnSize, closeCallback)
    -- 这里由于每个按钮的大小
    self.dataArr = dataArr
    self.btnPos = btnPos
    self.btnSize = btnSize
    self.btnCellList = {}
    self._closeCallback = closeCallback

    NewFunctionPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function NewFunctionPanel:onInitView()
    self.runActioning = true

    local btnListLayout = UI.Layout:create()
    btnListLayout:init()
    btnListLayout:setSize(208, 100)
    btnListLayout:setIgnoreAnchorPointForPosition(false)
    btnListLayout:setAnchorPoint(cc.p(0.5, 0))
    
    -- btnListLayout:enableDebugDraw()
    btnListLayout._enableAutoUpdatePos = false
    self:addChild(btnListLayout)
    self.btnListLayout = btnListLayout

    local layerBg = UI.Image.create()
    layerBg:init("ui_maincity_sectorbg.png")
    layerBg:center()
    self.btnListLayout:addChild(layerBg)

    -- 计算坐标
    local layoutPos = self:convertToNodeSpace(self.btnPos)
    layoutPos.x = layoutPos.x + self.btnSize.width/2
    layoutPos.y = layoutPos.y + self.btnSize.height
    btnListLayout:setPosition(layoutPos)
    btnListLayout:setScale(0)

    btnListLayout:setInterceptTouches(true)
    btnListLayout:setTouchEnable(true)

    btnListLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        print("NewFunctionPanel onTouchEnded")
        self:showCloseAction()
        Avalon.AudioManager:playSound("1502")
    end)

    for k, v in ipairs(self.dataArr) do
        local btnData = NewTownBtnUIDataManager:getTownBtnDataByOpenType(v)
        self:createBtnByData(k, btnData)
    end

    self:showOpenAction()
    Avalon.AudioManager:playSound("1501")
end

function NewFunctionPanel:createBtnByData(index, btnData)

    -- 动效按钮底图
    local animBtnBg = {
        "ui_maincity_btn2_conventional.png;ui_maincity_btn2_selected.png",
        "ui_maincity_btn2_conventional.png;ui_maincity_btn2_selected.png",
        "ui_maincity_btn_conventional.png;ui_maincity_btn_selected.png",
    }

    local btnPos = self:getBtnPos(index)

    local btn = UI.Button:create()
    btn:init("ui_main_button_explore_0.png", "ui_main_button_explore_1.png")
    -- 关闭封装组件相对位置更新，使用原生setPosition，涉及动作
    -- btn._enableAutoUpdatePos = false
    -- btn:setPosition(btnPos)
    btn:center(btnPos.x, btnPos.y)
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        NewTownBtnUIDataManager:callTownBtnClick(btnData.btnOpenType)
        self:close()
    end)

    self.btnListLayout:addChild(btn)

    -- 加入按钮列
    self.btnCellList[btnData.ID] = {}
    self.btnCellList[btnData.ID].btn = btn
    self.btnCellList[btnData.ID].isNewest = true

    local iconName = nil
    if btnData.btnIcon and btnData.btnIcon ~= "" then
        iconName = string.split(btnData.btnIcon, ";")
    elseif btnData.btnAnimName and btnData.btnAnimName ~= "" then
        iconName = string.split(animBtnBg[btnData.btnPosType], ";")

        local btnAnim = UI.Animation:create()
        btnAnim:init(btnData.btnAnimName..".json", btnData.btnAnimName..".atlas", 1)
        btnAnim:center()
        btnAnim:enableDebugDraw()
        btnAnim:setAnimation("idle1", true)
        btnAnim:setName("btnAnim")
        btn:addChild(btnAnim, 100)
    end
    -- 修改btn图片
    btn:setNormal(iconName[1])
    btn:setSelected(iconName[2])

    -- 按钮红点
    local redPoint = AvalonUtil.createRedPoint(btn, 2, 2, 100)
    redPoint:setName("redPoint")
    if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnData.btnOpenType) then
        redPoint:show()
    else
        redPoint:hide()
    end
end

-- 刷新按钮红点
function NewFunctionPanel:refreshBtnRedPoint()
    if not self.btnCellList or table.nums(self.btnCellList) <= 0 then
        return
    end

    for k, v in pairs(self.btnCellList) do
        local btnData = ConfigManager:getTownBtnDataByID(k)
        local btn = v.btn
        -- 按钮红点
        local redPoint = btn:getChildByName("redPoint")
        if redPoint and not tolua.isnull(redPoint) then
            if NewTownBtnUIDataManager:getTownBtnRedPointShow(btnData.btnOpenType) then
                redPoint:show()
            else
                redPoint:hide()
            end
        end
    end
end

function NewFunctionPanel:getBtnPos(index)
    local btnPosList = {}
    btnPosList[1] = {{x = 0, y = -20}}
    btnPosList[2] = {{x = -52, y = 2}, {x = 52, y = 2}}
    btnPosList[3] = {{x = -60, y = 8}, {x = 0, y = -20}, {x = 60, y = 8}}
    btnPosList[4] = {{x = -72, y = 22}, 
        {x = -28, y = -14}, 
        {x = 28, y = -14}, 
        {x = 72, y = 22}
    }

    local btnNum = table.nums(self.dataArr)

    return btnPosList[btnNum][index]
end

function NewFunctionPanel:showOpenAction()
    self.btnListLayout:runAction(cc.Sequence:create(
            cc.EaseSineIn:create(cc.ScaleTo:create(0.15, 1)),
            cc.CallFunc:create(function()
                self.runActioning = false
            end)
        ))
end

function NewFunctionPanel:showCloseAction()
    self.btnListLayout:runAction(cc.Sequence:create(
            cc.EaseSineOut:create(cc.ScaleTo:create(0.15, 0)),
            cc.CallFunc:create(function()
                self:close()
            end)
        ))
end

-- 注册监听事件(可选)
function NewFunctionPanel:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:bind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshBtnRedPoint)
end

-- 注销监听事件(可选)
function NewFunctionPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.refreshBtnRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_REFRESH_IAPSHOP_NEW_FLAG, self, self.refreshBtnRedPoint)
end