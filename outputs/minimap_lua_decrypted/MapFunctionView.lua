-- MapFunctionView.lua
-- Author:zp
-- 2019年6月25日
-- Using:地图功能按钮

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

local MapFunctionView = class("MapFunctionView", UI.HWBtnComponent)
UI.MapFunctionView = MapFunctionView

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    --  
}

local LAYOUT_DESIGN_WIDTH = 1024
local LAYOUT_FUNCTION_HEIGHT = 640

local LAYOUT_SCROLL_WIDTH = 170
local LAYOUT_SCROLL_HEIGHT = 570

function MapFunctionView:ctor()
    MapFunctionView.super.ctor(self, UIType.FUNCTION_MAP, COM_RES_LIST, 533, 211)
    self._btnList = {}
    self:registerListener()
end

function MapFunctionView:dtor()
    MapFunctionView.super.dtor(self)
    self:unRegisterListener()
    GameManager:funcBtnResumeNPCInformation(self._spriteID)
end

-- public:
-- 初始化
function MapFunctionView:init(spriteID, functionDataArr, name, icon, informationLocation, closeCallback)
    self:setInterceptTouches(false)
    self:setTouchEnable(true)

    self._spriteID = spriteID
    self._functionDataArr = functionDataArr
    self._name = name
    self._icon = icon
    -- 这里由于每个按钮的大小
    self._btnList = {}
    self._informationLocation = informationLocation
    self._closeCallback = closeCallback

    MapFunctionView.super.init(self)

    GameManager:funcBtnPauseNPCInformation(self._spriteID)
end

-- 模版函数：初始化组建的视图
function MapFunctionView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_minimap_town_function.png")
    bg:center()
    self:addChild(bg)

    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(365 + 80, 69)
    -- rootLayout:enableDebugDraw()
    rootLayout:leftBottom(46 - 40, 81)
    self:addChild(rootLayout)

    local iconWidth = 70
    local oneWidth = rootLayout:getContentSize().width / #self._functionDataArr
    local startX = (oneWidth - iconWidth) /2
    if(#self._functionDataArr == 3) then 
        oneWidth = 100
        startX = 51 + 40
    elseif(#self._functionDataArr == 2) then 
        oneWidth = 120
        startX = 94 + 40
    end

    local this = self
    local btnArr = {}
    for k,data in pairs(self._functionDataArr) do 
        local btnMove = UI.Button:create()
        btnMove:init(data.icon,data.icon)
        btnMove:leftBottom(startX + oneWidth * (k - 1) , 0)
        btnMove:addEventListener(UIEvent.BUTTON_CLICK, data, function(data)
            GameManager:handleNPCFunctionType(self._spriteID, data.ID, true)
            
            -- this:exitPanel(btnArr)
            local funcType = Game.FunctionUnlockManager:npcTypeToLockType(data.ID)
            Game.FunctionUnlockManager:getInstance():removeNewFlag(funcType)
        end)

        rootLayout:addChild(btnMove)
        btnMove._funcType = data.ID
        table.insert(btnArr, btnMove)
    end
    self._btnList = btnArr

    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        print("MapFunctionView onTouchEnded")
        -- self:close()
        Avalon.AudioManager:playSound("1502")
        this:exitPanel(btnArr)
    end)
    self:refreshBtnState()

    Avalon.AudioManager:playSound("1501")

    -- 添加图标名字
    local iconImage = UI.Image:create()
    iconImage:init(self._icon)
    iconImage:setScale(0.6)
    iconImage:leftBottom(61 - iconImage:getContentSize().width/2, 58 - iconImage:getContentSize().height/2)
    self:addChild(iconImage)

    local iconText = UI.Text:create()
    iconText:init(self._name, UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    iconText:leftBottom(85, 58 - iconText:getContentSize().height/2)
    self:addChild(iconText)
end


function MapFunctionView:exitPanel(btnArr)
    local num = 0
    for k, btn in ipairs(btnArr) do
        if(num == 0) then
            local callFun = cc.CallFunc:create(function()
                if (self._closeCallback) then self._closeCallback() end
                self:close()
            end)

            btn:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.15,0), cc.FadeOut:create(0.15)), callFun))
        else 
            btn:runAction(cc.Spawn:create(cc.ScaleTo:create(0.15,0), cc.FadeOut:create(0.15)))
        end

        num = num + 1
    end
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function MapFunctionView:refreshBtnState()
    local unlockType = PublicDefine.UnlockFunctionType 
    for k, v in pairs(self._btnList) do
        local funcType = Game.FunctionUnlockManager:npcTypeToLockType(v._funcType)
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(funcType) then
            ToolsUtil:playNewAction(v, 0.7, v:getContentSize().width/2, 0)
        else
            if funcType == PublicDefine.UnlockFunctionType.UnlockFunctionType_Forge then
                -- 装备锻造按钮的特殊判断，策划需求如此
                -- 当玩家有新解锁的锻造装备时，需要显示New
                local showNew = EquipForgeDataManager:hasNewEquipForge()
                if showNew then
                    ToolsUtil:playNewAction(v, 0.7, v:getContentSize().width/2, 0)
                end
            else
                ToolsUtil:removeNewAction(v)
            end
        end
    end
end

-- 注册监听事件(可选)
function MapFunctionView:registerListener()
    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)

end

-- 注销监听事件(可选)
function MapFunctionView:unRegisterListener()
        --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)
end