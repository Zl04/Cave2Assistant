-- FunctionPanel.lua
-- Author:zp
-- 2017年7月19日
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

local FunctionPanel = class("FunctionPanel", UI.HWBtnComponent)
UI.FunctionPanel = FunctionPanel

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    --  
}

local LAYOUT_DESIGN_WIDTH = 1024
local LAYOUT_FUNCTION_HEIGHT = 640

local LAYOUT_SCROLL_WIDTH = 170
local LAYOUT_SCROLL_HEIGHT = 570



local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end


function FunctionPanel:ctor()
    FunctionPanel.super.ctor(self, UIType.FUNCTION_NPC, COM_RES_LIST, winSize.width, winSize.height)
    self._btnList = {}
    self:registerListener()
    
end

function FunctionPanel:dtor()
    FunctionPanel.super.dtor(self)
    self:unRegisterListener()
    GameManager:funcBtnResumeNPCInformation(self._spriteID)
end

-- public:
-- 初始化
function FunctionPanel:init(spriteID, functionDataArr, x, y, informationLocation, closeCallback)
    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    self._spriteID = spriteID
    self._functionDataArr = functionDataArr
    -- 这里由于每个按钮的大小
    self._x = x + 5.5
    self._y = y
    self._btnList = {}
    self._informationLocation = informationLocation
    self._closeCallback = closeCallback

    FunctionPanel.super.init(self)

    GameManager:funcBtnPauseNPCInformation(self._spriteID)
end

-- 模版函数：初始化组建的视图
function FunctionPanel:onInitView()
    local scale = computeLayoutScale(winSize.width, LAYOUT_DESIGN_WIDTH)

    local runTime = self._runTime

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    -- contentLayout:setPos(0, LAYOUT_FUNCTION_HEIGHT/2)
    contentLayout:setSize(winSize.width, winSize.height)
    contentLayout:centerBottom(0)
    contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    local offsetX = 0
    local offsetY = self._informationLocation[2]

    local this = self
    local btnArr = {}
    for k,data in pairs(self._functionDataArr) do 
        local btnMove = UI.Button:create()
        btnMove:init(data.icon,data.icon)
        btnMove:leftBottom(self._x , self._y + offsetY - 60)
        btnMove:addEventListener(UIEvent.BUTTON_CLICK, data, function(data)
            print("FunctionPanel:clickFuntionBtn ")
            GameManager:handleNPCFunctionType(self._spriteID, data.ID, false)
            
            this:exitPanel(btnArr)
            local funcType = Game.FunctionUnlockManager:npcTypeToLockType(data.ID)
            Game.FunctionUnlockManager:getInstance():removeNewFlag(funcType)
        end)

        btnMove:setScale(0.1)
        btnMove:setOpacity(0)
        self:addChild(btnMove, 100)
        btnMove._funcType = data.ID
        table.insert(btnArr, btnMove)
    end
    self._btnList = btnArr
    local iconWidth = 80
    local spaceing = 12

    -- 处理坐标逻辑
    print("-----------------#btnArr size = "..#btnArr )
    if(#btnArr == 1) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            if(k == 1) then
                -- btn:leftBottom(self._x, self._y + offsetY)
                x = self._x - iconWidth / 2
                y = self._y + offsetY
            end
            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    elseif(#btnArr == 2) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            if(k == 1) then
                -- btn:leftBottom(self._x - iconWidth - spaceing/2 , self._y + offsetY)
                x = self._x - iconWidth - spaceing/2
                y = self._y + offsetY
            elseif (k == 2) then
                -- btn:leftBottom(self._x + spaceing/2, self._y + offsetY)
                x = self._x + spaceing/2
                y = self._y + offsetY
            end

            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    elseif (#btnArr == 3) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            if(k == 1) then
                -- btn:leftBottom(self._x - iconWidth * 1.5 - spaceing , self._y + offsetY - 60)
                x = self._x - iconWidth * 1.5 - spaceing
                y = self._y + offsetY - 60
                
            elseif (k == 2) then
                -- btn:leftBottom(self._x, self._y + offsetY)
                x = self._x - iconWidth / 2
                y = self._y + offsetY
            elseif (k == 3) then
                x = self._x + iconWidth * 0.5 + spaceing/2
                y = self._y + offsetY - 60
            end

            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    elseif (#btnArr == 4) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            if(k == 1) then
                -- btn:leftBottom(self._x - iconWidth *2 - spaceing*1.5 , self._y + offsetY - 60)
                x = self._x - iconWidth *2 - spaceing*1.5 
                y = self._y + offsetY - 60
            elseif (k == 2) then
                -- btn:leftBottom(self._x - iconWidth - spaceing/2, self._y + offsetY)
                x = self._x - iconWidth - spaceing/2
                y = self._y + offsetY
            elseif (k == 3) then
                -- btn:leftBottom(self._x + spaceing/2, self._y + offsetY)
                x = self._x + spaceing/2
                y = self._y + offsetY
            elseif (k == 4) then
                -- btn:leftBottom(self._x + iconWidth + spaceing*1.5, self._y + offsetY - 60)
                x = self._x + iconWidth + spaceing*1.5
                y = self._y + offsetY - 60
            end

            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    elseif (#btnArr == 5) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            local x = 0
            local y = 0
            if(k == 1) then
                x = self._x - iconWidth * 2 - spaceing
                y = self._y + offsetY - 140
            elseif (k == 2) then
                -- btn:leftBottom(self._x - iconWidth * 1.5 - spaceing , self._y + offsetY - 60)
                x = self._x - iconWidth * 1.5 - spaceing
                y = self._y + offsetY - 60
            elseif (k == 3) then
                -- btn:leftBottom(self._x, self._y + offsetY)
                x = self._x - iconWidth / 2
                y = self._y + offsetY
            elseif (k == 4) then
                x = self._x + iconWidth * 0.5 + spaceing/2
                y = self._y + offsetY - 60
            elseif (k == 5) then
                x = self._x + iconWidth * 1 + spaceing/2
                y = self._y + offsetY - 140
            end

            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    elseif (#btnArr == 6) then
        for k,btn in pairs(btnArr) do
            local x = 0
            local y = 0
            if(k == 1) then
                x = self._x - iconWidth * 2 - spaceing
                y = self._y + offsetY - 140
            elseif (k == 2) then
                -- btn:leftBottom(self._x - iconWidth * 1.5 - spaceing , self._y + offsetY - 60)
                x = self._x - iconWidth * 1.5 - spaceing
                y = self._y + offsetY - 60
            elseif (k == 3) then
                -- btn:leftBottom(self._x, self._y + offsetY)
                x = self._x - iconWidth / 2 - 50
                y = self._y + offsetY + 20
            elseif (k == 4) then
                x = self._x + 5
                y = self._y + offsetY + 20
            elseif (k == 5) then
                x = self._x + iconWidth * 0.5 + spaceing/2
                y = self._y + offsetY - 60
            elseif (k == 6) then
                x = self._x + iconWidth * 1 + spaceing/2
                y = self._y + offsetY - 140
            end

            btn:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.Spawn:create(cc.ScaleTo:create(0.1,1), cc.FadeIn:create(0.1), cc.MoveTo:create(0.1,cc.p(x, y)))))
        end
    end

    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        print("FunctionPanel onTouchBegan")
        return true
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        print("FunctionPanel onTouchEnded")
        -- self:close()
        Avalon.AudioManager:playSound("1502")
        this:exitPanel(btnArr)
    end)
    self:refreshBtnState()
    -- -- 点击开始
    -- local function onTouchBegan(touch, event)
    --     print("FunctionPanel onTouchBegan")
    --     return true
    -- end
    -- -- 点击移动
    -- local function onTouchMoved(touch, event)
        
    -- end
    -- -- 点击结束
    -- local function onTouchEnded(touch, event)
    --     print("FunctionPanel onTouchEnded")
    --     -- self:remove()
    -- end

    -- -- 注册点击监听事件
    -- local listener = cc.EventListenerTouchOneByOne:create()
    -- listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    -- listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    -- listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    -- listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)

    -- listener:setSwallowTouches(true)
    -- local eventDispatcher = self:getEventDispatcher()
    -- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    Avalon.AudioManager:playSound("1501")
end


function FunctionPanel:exitPanel(btnArr)
    local num = 0
    if(btnArr and #btnArr > 0) then 
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
    else 
        if (self._closeCallback) then self._closeCallback() end
        self:close()
    end
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function FunctionPanel:refreshBtnState()
    local unlockType = PublicDefine.UnlockFunctionType 
    for k, v in pairs(self._btnList) do
        local funcType = Game.FunctionUnlockManager:npcTypeToLockType(v._funcType)
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(funcType) then
            ToolsUtil:playNewAction(v, 0.7)
        else
            if funcType == PublicDefine.UnlockFunctionType.UnlockFunctionType_Forge then
                -- 装备锻造按钮的特殊判断，策划需求如此
                -- 当玩家有新解锁的锻造装备时，需要显示New
                local showNew = EquipForgeDataManager:hasNewEquipForge()
                if showNew then
                    ToolsUtil:playNewAction(v, 0.7)
                end
            else
                ToolsUtil:removeNewAction(v)
            end
        end
    end
end

-- 注册监听事件(可选)
function FunctionPanel:registerListener()
    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)

end

-- 注销监听事件(可选)
function FunctionPanel:unRegisterListener()
        --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshBtnState)
end