--[[
	--ControlPadNormal.lua
	--Author:zp
	--2018年12月21日
	--Using:控制移动的面板(经典版)
]]--

require "utils.Scheduler"

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local ControlPadNormal = class("ControlPadNormal",UI.Component)
UI.ControlPadNormal = ControlPadNormal

local size = cc.Director:getInstance():getWinSize()

-- 控制面板无任何操作多久消失
local delayTime = 4
-- 控制面板消失时间
local ROCKER_NEW_FADE_OUT_TIME = 1
-- 控制面板弹出的时间
local ROCKER_NEW_FADE_IN_TIME = 0.2

-- 控制面板出现的位置
local posTouch = nil 
local ROCKER_NEW_OFFSET = 50 
local ROCKER_RADIUS = 80

local preTouchSkeleton = nil  -- 控制面板上次点击的方向
local newTouchSkeleton = nil  -- 控制面板本次点击的方向
local startTime = 0  --点击开始时间
local endTime = 0    --播放end动画时的时间

local marginLeft = 230     -- 控制面板距离屏幕左侧的距离
local marginRight = 160    -- 控制面板距离屏幕右侧的距离
local marginBottom = 80    -- 控制面板距离屏幕底部的距离
local OFFSET_X = 0
-- local idleOpacity = 100    -- 普通状态的透明度
-- local diaphaneityOpacity = 10  -- 透明状态的透明度
local idleOpacity = 255    -- 普通状态的透明度
local diaphaneityOpacity = 100  -- 透明状态的透明度
local diaphaneityWaitingTime = 3  --  进入透明状态等待的时间

-- SIZE
local  CONTROL_PAD_INIT_INFO = {
    X = 0,
    Y = 0,
    WIDTH = 240 + OFFSET_X,
    HEIGHT = 240
}

local  CONTROL_PAD_SMALL_INFO = {
    X = 0,
    Y = 0,
    WIDTH = 200 + OFFSET_X,
    HEIGHT = 200
}

local ROCKER_RADIUS_X = CONTROL_PAD_SMALL_INFO.WIDTH/2
local ROCKER_RADIUS_Y = CONTROL_PAD_SMALL_INFO.HEIGHT/2
local ROCKER_NEW_OFFSET_X = ROCKER_RADIUS_X/2
local ROCKER_NEW_OFFSET_Y = ROCKER_RADIUS_Y/2

local ROCKER_RADIUS = CONTROL_PAD_SMALL_INFO.WIDTH/2
local ROCKER_NEW_OFFSET = ROCKER_RADIUS/2 

-- 摇杆的左下角点
local LAYOUT_LEFT = 30 + 18
local LAYOUT_BOTTON = 30
local LAYOUT_MAX_LEFT = 210

-- 方向键的动画资源
local CONTROL_JSON=  "effect_ui_general_controlpad2.json"
local CONTROL_ATLAS = "effect_ui_general_controlpad2.atlas"

local CONTROL_JSON_TIGER =  "effect_ui_general_controlpad2_tiger.json"
local CONTROL_ATLAS_TIGER = "effect_ui_general_controlpad2_tiger.atlas"

local DEBUG = false

-- 构造函数
function ControlPadNormal:ctor(type)
    ControlPadNormal.super.ctor(self,UIType.CONTROLPAD,{
        {}
    },CONTROL_PAD_INIT_INFO.WIDTH,CONTROL_PAD_INIT_INFO.HEIGHT)

    preTouchSkeleton = nil
    newTouchSkeleton = nil

    local center = (size.width /2 - 552 * ToolsUtil:getAdaptationMinScale()/2 - Avalon.issUtil:getLeftMargin())/2 - CONTROL_PAD_SMALL_INFO.WIDTH/2
    local min = LAYOUT_LEFT
    -- print("ControlPadNormal ", size.width, ToolsUtil:getAdaptationMinScale(), center)
    if(center > min) then
        LAYOUT_LEFT = center
    end

    if(LAYOUT_LEFT > LAYOUT_MAX_LEFT) then 
        LAYOUT_LEFT = LAYOUT_MAX_LEFT
    end

    --优先级最高,只受到外界操作控制
    self._openFunction = true
    -- 是否隐藏
    self._isShield = false
    -- 恢复后触发一次移动, 该参数主要用于处理战斗等状态恢复后，需要等待玩家状态为idle 后才能移动
    self._triggerOneMove = false
    self._diaphaneityWaitingTime = 0

    self._samllTouchLayout = nil
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVERSE_CHANGE, self, self.reverseChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_HERO_CONFUSE, self, self.confuseChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLEAR_DIRCTION_AND_START_MOVE_CONTROL_PAD, self, self.resumeMove)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CONTROL_END, self, self.assertTouch)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
    
    Avalon.Scheduler:scheduleUpdate(self, self.statusChange)

    local masterData = GameDataManager:getInstance():getMaster()
    -- 是否反向操作
    -- self._reverse = masterData:haveFunctionFlag(PublicDefine.FunctionFlag.FunctionFlag_Reverse)
    -- self._confuse = masterData:isConfuse()

    -- 方向是否改变
    self._directionChange = false

    self._lastReverse = false;

    self._isTiger = false
    self._appendStr = ""
    self:initUseUIValue()

    -- if masterData then
    --     local eData = masterData:getGameUIEquippedDecorates()

    --     for k,v in pairs(eData) do
    --         if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
    --             if v.value == 1 then --虎年
    --                 self._isTiger = true
    --                 break
    --             end
    --         end
    --     end
    -- end

    self:leftBottom(0,0)
    -- self:enableDebugDraw()
end

-- 析构函数
function ControlPadNormal:dtor()
    -- print("ControlPadNormal:dtor ")
    self._samllTouchLayout = nil
    -- Avalon.Scheduler:unscheduleUpdateOnce(self, ControlPadNormal.setDisappear)
    ControlPadNormal.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVERSE_CHANGE, self, self.reverseChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_HERO_CONFUSE, self, self.confuseChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLEAR_DIRCTION_AND_START_MOVE_CONTROL_PAD, self, self.resumeMove)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CONTROL_END, self, self.assertTouch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
    
    Avalon.Scheduler:unscheduleUpdate(self, self.statusChange)
end

function ControlPadNormal:triggerDiaphaneity()
    if(self._diaphaneityWaitingTime > diaphaneityWaitingTime) then 
        self._diaphaneityWaitingTime = 0
        self:endDiaphaneityView()
    end
end

-- 打开遥感控制功能
function ControlPadNormal:openFunction(isShield)
    if DEBUG then
        print("ControlPadNormal:openFunction ", GameDataManager:getInstance():canUseControlMove(), isShield)
        print(debug.traceback())
    end

    self:triggerDiaphaneity()

    self._openFunction = true
    if(isShield) then 
        self._isShield = false
        self._preMoveDirection = nil 
        self._triggerOneMove = true
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
        if(GameDataManager:getInstance():canUseControlMove() == false) then
            if(GameDataManager:getInstance():canUseControl() == false) then
                self:setDisappear()
                return
            end
        end

        self:handleView()
    else  
        self._isShield = false
        self._preMoveDirection = nil 
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
        -- self._openFunction = true
        if(GameDataManager:getInstance():canUseControl() == false) then
            self:setDisappear()
            return
        end
        -- Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPadNormal.setDisappear,delayTime)
        self:handleView()
    end
end

-- 关闭该功能
function ControlPadNormal:closeFunction(isShield)
    if DEBUG then
        print("ControlPadNormal:closeFunction ", isShield)
        print(debug.traceback())
    end
    self._openFunction = false
    if(isShield) then 
        self._isShield = true
    else  
        self._isShield = false

        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
        GameManager:stopMoveHandler()
        -- Avalon.Scheduler:unscheduleUpdateOnce(self,ControlPadNormal.setDisappear)
        -- self._openFunction = false
        -- self:setDisappear()
        self:hideView()
    end
end

function ControlPadNormal:statusChange(dt)
    if(GameDataManager:getInstance():canUseControlMove() == false) then
        if(GameDataManager:getInstance():canUseControl() == false) then
            self:hideView()
        end
        return
    end


    if(MULTI_TOUCH_CONTROL_ID == nil and self._confuse == false and self._reverse == false and self._openFunction) then 
        local time = self._diaphaneityWaitingTime + dt 
         
        if(self._diaphaneityWaitingTime < diaphaneityWaitingTime and time >= diaphaneityWaitingTime) then 
            self:diaphaneityView()
        end
        self._diaphaneityWaitingTime = time
        return
    else 
        self._diaphaneityWaitingTime = 0
        self:handleView()
    end

 
    
    -- self:handleView()
end

function ControlPadNormal:confuseChange(isConfuse)
    if(self._confuse ~= isConfuse) then
        self._confuse = isConfuse
        self:triggerDiaphaneity()
        if(self._confuse) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111333))
        end
        self._directionChange = true
        if(DEBUG) then 
            print("ControlPadNormal:confuseChange  ", isConfuse, GameDataManager:getInstance():canUseControl(), self._reverse)
        end
        if(GameDataManager:getInstance():canUseControl() == false) then
            self._openFunction = self._confuse
        end 
        self:resetControl()

        self:handleRolation()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
    end 
end

function ControlPadNormal:resumeMove()
    -- print(" ControlPadNormal:resumeMove ", self._openFunction, GameDataManager:getInstance():canUseControlMove())
    if(self._openFunction) then 
        if(GameDataManager:getInstance():canUseControlMove()) then
            -- print(" ControlPadNormal:resumeMove 23", preTouchSkeleton, newTouchSkeleton)
            if(preTouchSkeleton) then 
                self._preMoveDirection = nil 
                -- 这里如果在一条直线上面走的时候，会出现newTouchSkeleton 被触发了，但是上次触发是非法
                if(newTouchSkeleton == nil) then 
                    newTouchSkeleton = preTouchSkeleton
                end
                self:moveRockerNew(preTouchSkeleton,newTouchSkeleton)
            end
        end
    end 
end

function ControlPadNormal:resetControl()
    newTouchSkeleton = nil
    preTouchSkeleton = nil
    self._preMoveDirection = nil
end

function ControlPadNormal:reverseChange(isReverse)
    if(self._reverse ~= isReverse) then
        self._reverse = isReverse
        self:triggerDiaphaneity()
        if(self._reverse) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111333))
        end
        if DEBUG then
            print("ControlPadNormal:reverseChange  ", isReverse, GameDataManager:getInstance():canUseControl(), self._confuse)
        end
        if(GameDataManager:getInstance():canUseControl() == false) then
            self._openFunction = self._reverse
        end
        self:resetControl()

        self._directionChange = true
        self:handleRolation()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
    end 
end

function ControlPadNormal:handleRolation()
    if(self._confuse or self._reverse) then
        if(self._confuse) then
            local gameInCaveData = MasterDataManager:getSaveGameInCaveData()

            -- 这里随机一次顺序
            local directionArr = {}
            if(gameInCaveData) then
                directionArr = gameInCaveData:getConfuseDirection()
            end 
            if(directionArr and #directionArr == 0) then
                table.insert(directionArr, DirectionType.EAST)
                table.insert(directionArr, DirectionType.SOUTH)
                table.insert(directionArr, DirectionType.NORTH)
                table.insert(directionArr, DirectionType.WEAST)

                -- table.sort(directionArr,function (a,b)
                --     return math.random(1,10) < 5
                -- end)

                for i=1,7 do 
                    local startIndex = math.random(1, #directionArr)
                    local endIndex = math.random(1, #directionArr)
                    
                    if(startIndex ~= endIndex) then
                        local startValue = directionArr[startIndex]
                        directionArr[startIndex] = directionArr[endIndex]
                        directionArr[endIndex] = startValue
                    end
                end

                -- 这里如果为顺序的话，就在随便替换一个方向
                if (directionArr[1] == DirectionType.SOUTH 
                    and directionArr[2] == DirectionType.NORTH 
                    and directionArr[3] == DirectionType.EAST 
                    and directionArr[4] == DirectionType.WEAST ) then 

                    local startIndex = math.random(1, 4)
                    local endIndex = startIndex + 2
                    if(endIndex > 4) then
                        endIndex = endIndex - 4
                    end
                    
                    local willChange = directionArr[startIndex]
                    directionArr[startIndex] = directionArr[endIndex]
                    directionArr[endIndex] = willChange 
                end

                if(gameInCaveData) then
                    gameInCaveData:setConfuseDirection(directionArr)
                end
            end

            self.upSkeleton._direction = directionArr[1]
            self.downSkeleton._direction = directionArr[2]
            self.leftSkeleton._direction = directionArr[3]
            self.rightSkeleton._direction = directionArr[4]
        else
            local gameInCaveData = MasterDataManager:getSaveGameInCaveData()
            if(gameInCaveData) then
                gameInCaveData:clearConfuseDirection()
            end 

            self.upSkeleton._direction = DirectionType.SOUTH
            self.downSkeleton._direction = DirectionType.NORTH
            self.leftSkeleton._direction = DirectionType.EAST
            self.rightSkeleton._direction = DirectionType.WEAST
        end
    else 
        local gameInCaveData = MasterDataManager:getSaveGameInCaveData()
        if(gameInCaveData) then
            gameInCaveData:clearConfuseDirection()
        end 

        self.upSkeleton._direction = DirectionType.NORTH
        self.downSkeleton._direction = DirectionType.SOUTH
        self.leftSkeleton._direction = DirectionType.WEAST
        self.rightSkeleton._direction = DirectionType.EAST
    end

    -- -- 处理方向按钮的表现逻辑
    -- self:refreshRolation()

    if(GameManager:getIsTouchMoveType()) then
        -- TODO 处理停下来方向操作
        self:refreshRolation()
        return
    end
    if DEBUG then
        print("ControlPadNormal:reverseChange  is click isReverse", self._confuse, self._reverse)
    end
    if(self._confuse or self._reverse) then
        -- Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPadNormal.setDisappear,delayTime)
        self:handleView()
    else
        -- Avalon.Scheduler:unscheduleUpdateOnce(self,ControlPadNormal.setDisappear)
        -- self:setDisappear()
    end
end

-- 初始化
function ControlPadNormal:init(data)
    self:setContentSize(CONTROL_PAD_INIT_INFO.WIDTH, CONTROL_PAD_INIT_INFO.HEIGHT)
    self._direction = DirectionType.NONE
    self:addTouchEvents()  
    ControlPadNormal.super.init(self,data)
end

-- 触摸监听
function ControlPadNormal:addTouchEvents()

    local function onTouchBegan(touch, event)
        if DEBUG then
            print("ControlPadNormal:onTouchBegan1   ", GameDataManager:getInstance():canUseControlMove())
        end
        self._preMoveDirection = nil
        if(GameDataManager:getInstance():canUseControlMove() == false and self._isShield == false) then
            return false
        else 
            local posTouch = touch:getLocation()
            local isInSmallRect = false
            if self._touchBeginLayout then
                isInSmallRect = self._touchBeginLayout:checkTouchPosition(posTouch)
            end
            if (self._openFunction or self._isShield) and isInSmallRect then
                self:triggerDiaphaneity()
                if self.upSkeleton:isVisible()  then
                    if DEBUG then
                        print("ControlPadNormal:onTouchBegan4  ", self.upSkeleton:isVisible())
                    end
                    preTouchSkeleton = self:getTouchSkeleton(posTouch)
                end

                if preTouchSkeleton then
                    if DEBUG then
                        print("ControlPadNormal:onTouchBegan5  preTouchSkeleton is nil")
                    end
                    -- 点中控制按钮
                    self:startRockerNew(preTouchSkeleton)
                end
                -- 这里防止点击了没有移动，导致后面无法直接移动
                newTouchSkeleton = preTouchSkeleton

                return true 
            end
        end

        return false
    end

    local function onTouchMoved(touch, event)
        if DEBUG then
            print("ControlPadNormal:onTouchMoved")
        end
        posTouch = touch:getLocation()
        newTouchSkeleton = self:getTouchSkeleton(posTouch)
        -- print("-----------self._direction---------    =   "..self._direction)
        if(GameDataManager:getInstance():canUseControlMove() == false and self._isShield == false) then
            return false
        end
        if self._openFunction or self._isShield then
            -- 获取新的方向键
            -- posTouch = touch:getLocation()
            -- newTouchSkeleton = self:getTouchSkeleton(posTouch)
            if newTouchSkeleton then
                if preTouchSkeleton then 
                    self:moveRockerNew(preTouchSkeleton,newTouchSkeleton)
                else
                    self:startRockerNew(newTouchSkeleton)
                end

                preTouchSkeleton = newTouchSkeleton
                newTouchSkeleton = nil
            else
                -- 移动到控制面板外面
                self:endRockerNew(preTouchSkeleton, true)
                -- preTouchSkeleton = nil 
            end
        end
    end

    local function onTouchEnded(touch, event)
        if DEBUG then
            print("ControlPadNormal:onTouchEnded   ", GameDataManager:getInstance():canUseControlMove())
        end

        self:handleEndTouchMove()

        -- GameManager:stopMoveHandler()
        -- self._triggerOneMove = false
        -- if(GameDataManager:getInstance():canUseControlMove() == false and self._isShield == false) then
        --     self:endRockerNew(preTouchSkeleton, true)
        --     newTouchSkeleton = nil 
        --     preTouchSkeleton = nil 
        --     return false
        -- end

        -- -- 本次触摸结束
        -- if newTouchSkeleton or preTouchSkeleton then
        --     if(newTouchSkeleton == preTouchSkeleton) then  
        --         self:endRockerNew(newTouchSkeleton, true)
        --     elseif (preTouchSkeleton) then
        --         self:endRockerNew(preTouchSkeleton, true)
        --     elseif (newTouchSkeleton) then
        --         self:endRockerNew(newTouchSkeleton, true)
        --     end
        -- else
        --     if self:isVisible() then
        --         self:handleView()
        --     end
        -- end

        -- newTouchSkeleton = nil 
        -- preTouchSkeleton = nil 
    end

    local beginUseID = nil
    local function onTouchesBegan(touches, event)
        -- beginUseID = nil
        -- MULTI_TOUCH_CONTROL_ID = nil
        -- print("....multouch onTouchesBegan test........", touches)
        -- print("ControlPadNormal:--------------------- onTouchesBegan 1 id=", MULTI_TOUCH_CONTROL_ID, beginUseID)
        for _id, touch in pairs(touches) do 
            local id = touch:getId()
            if(id == beginUseID) then 
                beginUseID = nil
                MULTI_TOUCH_CONTROL_ID = nil
            end
            -- print("ControlPadNormal:--------------------- onTouchesBegan id=", id, beginUseID)
            if(MULTI_TOUCH_ID_ARR[id] ~= true and MULTI_TOUCH_CONTROL_ID == nil) then
                -- print("ControlPadNormal wwwwwwwwwwwwwwwwwwwww  id=", id)
                local use = onTouchBegan(touch, event)
                if(use) then 
                    -- print("ControlPadNormal wwwwwwwwwwwwwwwwwwwww use id=", id, self.__cname, self._mn)
                    beginUseID = id
                    MULTI_TOUCH_ID_ARR[id] = true
                    MULTI_TOUCH_CONTROL_ID = id
                    return
                end
            end
        end
    end

    local function onTouchesMoved(touches, event)
        -- print("....multouch onTouchesMoved test........", beginUseID)
        if(beginUseID) then
            -- print("....multouch onTouchesMoved test........", #touches)
            for _id, touch in pairs(touches) do 
                if touch:getId() == beginUseID then 
                    onTouchMoved(touch, event)
                end
            end
        end
    end

    local function onTouchesEnded(touches, event)
        -- if(beginUseID) then
            -- print("....multouch onTouchesEnded test........", touches)
            -- if(beginUseID) then 
            --     print("ControlPadNormal wwwwwwwwwwwwwwwwwwwww use end id=", beginUseID)
            -- end 

            for _id, touch in pairs(touches) do 
                -- if(beginUseID) then 
                --     onTouchEnded(touch, event)
                --     MULTI_TOUCH_CONTROL_ID = nil
                --     beginUseID = nil
                -- end
                -- print("ControlPadNormal onTouchesEnded wwwwwwwwwwwwwwwwwwwww  id=", touch:getId())
                -- print("ControlPadNormal:---------------------  use end trigger id=", touch:getId(), beginUseID)
                if touch:getId() == beginUseID then 
                    -- print("ControlPadNormal wwwwwwwwwwwwwwwwwwwww use end  handle id=", touch:getId())
                    onTouchEnded(touch, event)
                    MULTI_TOUCH_CONTROL_ID = nil
                    beginUseID = nil
                end
                MULTI_TOUCH_ID_ARR[touch:getId()] = false
            end
        -- end
    end

    -- 多点触摸
    local tochesListener = cc.EventListenerTouchAllAtOnce:create()
    tochesListener:registerScriptHandler(onTouchesBegan,cc.Handler.EVENT_TOUCHES_BEGAN )
    tochesListener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    tochesListener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
    tochesListener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_CANCELLED )
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(tochesListener, self)
end

function ControlPadNormal:assertTouch()
    MULTI_TOUCH_CONTROL_ID = nil
    beginUseID = nil
    for k,value in pairs(MULTI_TOUCH_ID_ARR) do 
        MULTI_TOUCH_ID_ARR[k] = false
    end
    
    self:handleEndTouchMove()
end

function ControlPadNormal:handleEndTouchMove()
    GameManager:stopMoveHandler()
    self._triggerOneMove = false
    if(GameDataManager:getInstance():canUseControl() == false and self._isShield == false) then
        self:endRockerNew(preTouchSkeleton, true)
        newTouchSkeleton = nil 
        preTouchSkeleton = nil 
        return false
    end

    -- 本次触摸结束
    if newTouchSkeleton or preTouchSkeleton then
        if(newTouchSkeleton == preTouchSkeleton) then  
            self:endRockerNew(newTouchSkeleton, true)
        elseif (preTouchSkeleton) then
            self:endRockerNew(preTouchSkeleton, true)
        elseif (newTouchSkeleton) then
            self:endRockerNew(newTouchSkeleton, true)
        end
    else
        if self:isVisible() then
            self:handleView()
        end
    end

    newTouchSkeleton = nil 
    preTouchSkeleton = nil 
end

-- 初始化视图
function ControlPadNormal:onInitView()
    -- print ("====ControlPadNormal:initView====")
    local samllTouchLayout = UI.Layout:create()
    samllTouchLayout:init()
    samllTouchLayout:setSize(CONTROL_PAD_SMALL_INFO.WIDTH, CONTROL_PAD_SMALL_INFO.HEIGHT)
    samllTouchLayout:leftBottom(LAYOUT_LEFT, LAYOUT_BOTTON)
    -- samllTouchLayout:enableDebugDraw(UI.RED)
    self:addChild(samllTouchLayout)
    self._samllTouchLayout = samllTouchLayout

    -- 添加背景图片
    local bg = UI.Image:create()
    bg:init("ui_information_controlpad_yuan.png")
    bg:center()
    self._samllTouchLayout:addChild(bg)
    self._bg = bg

    local touchBeginLayout = UI.Layout:create()
    touchBeginLayout:init()
    touchBeginLayout:setSize(CONTROL_PAD_INIT_INFO.WIDTH + LAYOUT_LEFT + Avalon.issUtil:getLeftMargin(), 
        CONTROL_PAD_INIT_INFO.HEIGHT + LAYOUT_BOTTON + Avalon.issUtil:getBottomMargin())
    touchBeginLayout:leftBottom(- Avalon.issUtil:getLeftMargin(), 
        -Avalon.issUtil:getBottomMargin())
    self:addChild(touchBeginLayout)
    self._touchBeginLayout = touchBeginLayout


    local fJson = CONTROL_JSON
    local fAtlas = CONTROL_ATLAS

    if self._isTiger then
        fJson = "effect_ui_general_controlpad2" .. self._appendStr .. ".json" --CONTROL_JSON_TIGER
        fAtlas = "effect_ui_general_controlpad2" .. self._appendStr .. ".atlas" -- CONTROL_ATLAS_TIGER
    end


    self.rightSkeleton = UI.Animation:create()
    self.rightSkeleton:init(fJson, fAtlas, 1)
    self.rightSkeleton._extend = "_sy"

    -- self.rightSkeleton:enableDebugDraw()
    self.leftSkeleton = UI.Animation:create()
    self.leftSkeleton:init(fJson, fAtlas, 1)
    self.leftSkeleton._extend = "_xz"

    self.downSkeleton = UI.Animation:create()
    self.downSkeleton:init(fJson, fAtlas, 1)
    self.downSkeleton._extend = "_xy"

    self.upSkeleton = UI.Animation:create()
    self.upSkeleton:init(fJson, fAtlas, 1)
    self.upSkeleton._extend = "_sz"
    -- self.upSkeleton:enableDebugDraw()

    -- self.rightSkeleton:setRotationSkewY(180)
    -- self.downSkeleton:setRotation(180)
    -- self.leftSkeleton:setRotationSkewX(180)

    samllTouchLayout:addChild(self.rightSkeleton)
    samllTouchLayout:addChild(self.downSkeleton)
    samllTouchLayout:addChild(self.leftSkeleton)
    samllTouchLayout:addChild(self.upSkeleton)

    local offset = ROCKER_NEW_OFFSET
    local offset2 = ROCKER_NEW_OFFSET + ROCKER_RADIUS

    self.rightSkeleton:setPosition(cc.p(offset2, offset2))
    self.leftSkeleton:setPosition(cc.p(offset, offset))
    self.upSkeleton:setPosition(cc.p(offset, offset2))
    self.downSkeleton:setPosition(cc.p(offset2, offset))

    local masterData = GameDataManager:getInstance():getMaster()
    local reverse = masterData:haveFunctionFlag(PublicDefine.FunctionFlag.FunctionFlag_Reverse)
    local confuse = masterData:isConfuse()
    if(reverse) then 
        self:reverseChange(reverse)
    else 
        self._reverse = false
    end
    if(confuse) then 
        self:confuseChange(confuse)
    else 
        self._confuse = false
    end

    self:setSkeletonIdel()
    self:handleRolation()

    if (device.platform == "mac") then
        local listener = cc.EventListenerKeyboard:create();
        listener:registerScriptHandler(function(keycode, evt)
            if keycode == 146 then
                GameManager:stopMoveHandler()
            elseif keycode == 124 then
                GameManager:stopMoveHandler()
            elseif keycode == 127 then
                GameManager:stopMoveHandler()
            elseif keycode == 142 then
                GameManager:stopMoveHandler()
            end
        end, cc.Handler.EVENT_KEYBOARD_RELEASED);
     
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self);

        local listener = cc.EventListenerKeyboard:create();
        listener:registerScriptHandler(function(keycode, evt)
            if keycode == 146 then
                GameManager:startMoveHandler(DirectionType.EAST)
            elseif keycode == 124 then
                GameManager:startMoveHandler(DirectionType.NORTH)
            elseif keycode == 127 then
                GameManager:startMoveHandler(DirectionType.SOUTH)
            elseif keycode == 142 then
                GameManager:startMoveHandler(DirectionType.WEAST)
            end
        end, cc.Handler.EVENT_KEYBOARD_PRESSED);
    
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self);
    end
end

-- 更新视图
function ControlPadNormal:updateView(data)
    ControlPadNormal.super.updateView(self, data)
  -- body
end

-- 更新控制面板延时消失时间
function ControlPadNormal:updateDelayTime()
--    Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPadNormal.setDisappear,delayTime)
end

-- 获取点击的方向
function ControlPadNormal:getTouchSkeleton(posTouch)
    -- body
    local size  = self:getContentSize()
    local startX = self:getPositionX() + Avalon.issUtil:getLeftMargin()
    local startY = self:getPositionY() + Avalon.issUtil:getBottomMargin()

    -- local rect = cc.rect(startX, startY, size.width, size.height)
    -- if cc.rectContainsPoint(rect, posTouch) then   
        -- -- 这里去掉中心点区域
        -- local chaX = self:getPositionX() + size.width / 2 - posTouch.x
        -- local chaY = self:getPositionY() + size.height / 2 - posTouch.y
        -- if(chaX * chaX + chaY * chaY < 400) then
        --     print("-----center---------")
        --     return nil
        -- end
        local worldPos = self._samllTouchLayout:convertToWorldSpace(cc.p(0, 0))

        startX = worldPos.x
        startY = worldPos.y
        if  posTouch.x > (startX + ROCKER_RADIUS + OFFSET_X / 2 )and  posTouch.y > (startY + ROCKER_RADIUS) then
            self._direction = self.rightSkeleton._direction
            return self.rightSkeleton
        elseif  posTouch.x > (startX + ROCKER_RADIUS + OFFSET_X / 2)  and  posTouch.y < (startY + ROCKER_RADIUS)  then
            self._direction = self.downSkeleton._direction
            return self.downSkeleton
        elseif  posTouch.x < (startX + ROCKER_RADIUS + OFFSET_X / 2) and  posTouch.y  > (startY + ROCKER_RADIUS)  then
            self._direction = self.upSkeleton._direction
            return self.upSkeleton
        else  
            self._direction = self.leftSkeleton._direction
            return  self.leftSkeleton
        end

    -- else
    --     return nil 
    -- end
end

-- 开始移动
function ControlPadNormal:startRockerNew(skeleton)
    -- add by zp 修改为出现了就可以点击操作的处理
    -- if skeleton and self._actionEnd then
    if skeleton then
        startTime = AvalonUtil.getCurrentTime() 
        if(DEBUG) then
            print("===startTime",startTime, self._preMoveDirection, self._direction)
        end
        if not skeleton._inloop then
            skeleton:setAnimation(self:getClickAnimationName(skeleton), true)
            -- skeleton:setOpacity(255)
        end
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_START_MOVE,self._direction)
        -- print("ControlPadNormal:startRockerNew", self._direction, self._preMoveDirection)
        if(self._direction ~= self._preMoveDirection) then
            if(GameDataManager:getInstance():canUseControlMove())then 
                self._preMoveDirection = self._direction
                self._triggerOneMove = false

                GameManager:startMoveHandler(self._direction)
            end 
        end
        skeleton._inloop = true
    end
end

-- 停止移动的处理
function ControlPadNormal:endRockerNew(skeleton, stop)
    -- body
    if skeleton then
        skeleton._inloop = false
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_STOP_MOVE)
        if(stop) then
            self._preMoveDirection = -1
            GameManager:stopMoveHandler()
        end

        endTime = AvalonUtil.getCurrentTime()
        -- print("===endTime",endTime)
        -- TODO 优化当前的逻辑

        skeleton:setAnimation(self:getIdleAnimationName(skeleton), false)
        -- skeleton:setOpacity(idleOpacity)
    end
end

-- 方向更改
function ControlPadNormal:moveRockerNew(oldskeleton,newskeleton)
    if oldskeleton and newskeleton then
        if  oldskeleton == newskeleton then
            -- 继续移动，不做任何处理
            self:startRockerNew(newskeleton)
        else
            -- 改变方向
            self:endRockerNew(oldskeleton, false)
            self:startRockerNew(newskeleton)
        end
    end
end

-- 刷新显示坐标
function ControlPadNormal:refreshRolation()
    local skeletonArr = {}

    local direction = self.rightSkeleton._direction
    -- print("ControlPadNormal:rightSkeleton ", direction)
    if(direction == DirectionType.EAST) then
        self.rightSkeleton:setRotation(0)
    elseif (direction == DirectionType.SOUTH) then
        self.rightSkeleton:setRotation(90)
    elseif (direction == DirectionType.WEAST) then
        self.rightSkeleton:setRotation(180)
    elseif (direction == DirectionType.NORTH) then
        self.rightSkeleton:setRotation(-90)
    end 


    local direction = self.downSkeleton._direction
    -- print("ControlPadNormal:downSkeleton ", direction)
    if(direction == DirectionType.EAST) then
        self.downSkeleton:setRotation(-90)
    elseif (direction == DirectionType.SOUTH) then
        self.downSkeleton:setRotation(0)
    elseif (direction == DirectionType.WEAST) then
        self.downSkeleton:setRotation(90)
    elseif (direction == DirectionType.NORTH) then
        self.downSkeleton:setRotation(180)
    end 

    local direction = self.leftSkeleton._direction
    -- print("ControlPadNormal:leftSkeleton ", direction)
    if(direction == DirectionType.EAST) then
        self.leftSkeleton:setRotation(180)
    elseif (direction == DirectionType.SOUTH) then
        self.leftSkeleton:setRotation(-90)
    elseif (direction == DirectionType.WEAST) then
        self.leftSkeleton:setRotation(0)
    elseif (direction == DirectionType.NORTH) then
        self.leftSkeleton:setRotation(90)
    end 

    local direction = self.upSkeleton._direction
    -- print("ControlPadNormal:leftSkeleton ", direction)
    if(direction == DirectionType.EAST) then
        self.upSkeleton:setRotation(90)
    elseif (direction == DirectionType.SOUTH) then
        self.upSkeleton:setRotation(180)
    elseif (direction == DirectionType.WEAST) then
        self.upSkeleton:setRotation(-90)
    elseif (direction == DirectionType.NORTH) then
        self.upSkeleton:setRotation(0)
    end 


    -- table.insert(skeletonArr, self.upSkeleton)
    -- table.insert(skeletonArr, self.rightSkeleton)
    -- table.insert(skeletonArr, self.downSkeleton)
    -- table.insert(skeletonArr, self.leftSkeleton)

    -- -- print("ControlPadNormal:refreshRolation  start")
    -- for k,skeleton in pairs(skeletonArr) do 
    --     skeleton:setRotationSkewY(0)
    --     skeleton:setRotationSkewX(0)
    --     skeleton:setRotation(0)

    --     local direction = skeleton._direction
    --     -- print("ControlPadNormal:refreshRolation ", direction)
    --     if(direction == DirectionType.EAST) then
    --         skeleton:setRotationSkewY(180)
    --     elseif (direction == DirectionType.SOUTH) then
    --         skeleton:setRotation(180)
    --     elseif (direction == DirectionType.NORTH) then
    --         skeleton:setRotation(0)
    --     elseif (direction == DirectionType.WEAST) then
    --         skeleton:setRotationSkewX(180)
    --     end 
    -- end
end

-- 设置控制面板Idel状态
function ControlPadNormal:setSkeletonIdel(callback)
    if(DEBUG) then
        print("ControlPadNormal:setSkeletonIdel()  ", self._openFunction)
    end

    self._actionEnd = false
    self._preMoveDirection = nil

    self.rightSkeleton:setVisible(true)
    self.downSkeleton:setVisible(true)
    self.upSkeleton:setVisible(true)
    self.leftSkeleton:setVisible(true)

    self.rightSkeleton:clearTrack(0)
    self.downSkeleton:clearTrack(0)
    self.upSkeleton:clearTrack(0)
    self.leftSkeleton:clearTrack(0)

    self.rightSkeleton:setAnimation(self:getIdleAnimationName(self.rightSkeleton), false)
    self.downSkeleton:setAnimation(self:getIdleAnimationName(self.downSkeleton), false)
    self.upSkeleton:setAnimation(self:getIdleAnimationName(self.upSkeleton), false)
    self.leftSkeleton:setAnimation(self:getIdleAnimationName(self.leftSkeleton), false)

    self.rightSkeleton._inloop = false
    self.downSkeleton._inloop = false
    self.upSkeleton._inloop = false
    self.leftSkeleton._inloop = false

    self.rightSkeleton:setPosition(cc.p(ROCKER_RADIUS,ROCKER_RADIUS))
    self.leftSkeleton:setPosition(cc.p(ROCKER_RADIUS,ROCKER_RADIUS))
    self.upSkeleton:setPosition(cc.p(ROCKER_RADIUS,ROCKER_RADIUS))
    self.downSkeleton:setPosition(cc.p(ROCKER_RADIUS,ROCKER_RADIUS))

    local offset = ROCKER_NEW_OFFSET
    local offset2 = ROCKER_NEW_OFFSET + ROCKER_RADIUS

    self.rightSkeleton:stopAllActions()
    self.rightSkeleton:setOpacity(0)
    self.downSkeleton:stopAllActions()
    self.downSkeleton:setOpacity(0)
    self.upSkeleton:stopAllActions()
    self.upSkeleton:setOpacity(0)
    self.leftSkeleton:stopAllActions()
    self.leftSkeleton:setOpacity(0)
    if(self._bg) then 
        self._bg:setOpacity(255)
    end

    -- self._centerImage:stopAllActions()
    -- self._centerImage:setOpacity(0)

    if(self._bg) then 
        local upAction = cc.Sequence:create(cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, 255), cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, idleOpacity))
        self._bg:runAction(upAction)
    end

    local  upAction = cc.Sequence:create(cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, 255), cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, idleOpacity))
    self.rightSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, 255), cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, idleOpacity))
    self.downSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, 255), cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, idleOpacity))
    self.upSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, 255), cc.FadeTo:create(ROCKER_NEW_FADE_IN_TIME, idleOpacity), cc.CallFunc:create(function()
        self._actionEnd = true
        if callback then callback() end
        local skeletonArr = {}
        table.insert(skeletonArr, self.upSkeleton)
        table.insert(skeletonArr, self.rightSkeleton)
        table.insert(skeletonArr, self.downSkeleton)
        table.insert(skeletonArr, self.leftSkeleton)
        for k, v in ipairs(skeletonArr) do
            if v._inloop then
                v:setOpacity(255)
            end
        end
        if(self._bg) then 
            self._bg:setOpacity(255)
        end
    end))
    self.leftSkeleton:runAction(upAction)

    -- local  upAction = cc.Sequence:create(cc.FadeIn:create(ROCKER_NEW_FADE_IN_TIME))
    -- self._centerImage:runAction(upAction)

    if(self._bg) then 
        self._bg:runAction(cc.Sequence:create(cc.ScaleTo:create(0.0001, 0.2),cc.ScaleTo:create(0.2, 1)))
    end

    self.rightSkeleton:runAction(cc.Sequence:create(cc.ScaleTo:create(0.0001, 0.2),
    cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(offset2 + OFFSET_X, offset2)),cc.ScaleTo:create(0.2, 1))))
    self.leftSkeleton:runAction(cc.Sequence:create(cc.ScaleTo:create(0.0001, 0.2),
    cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(offset, offset)),cc.ScaleTo:create(0.2, 1))))
    self.upSkeleton:runAction(cc.Sequence:create(cc.ScaleTo:create(0.0001, 0.2),
    cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(offset, offset2)),cc.ScaleTo:create(0.2, 1))))
    self.downSkeleton:runAction(cc.Sequence:create(cc.ScaleTo:create(0.0001,0.2),
    cc.Spawn:create(cc.MoveTo:create(0.2, cc.p(offset2 + OFFSET_X, offset)),cc.ScaleTo:create(0.2, 1))))
end

-- 控制面板消失
function ControlPadNormal:setDisappear(callback)
    if(DEBUG) then
        print("ControlPadNormal:setDisappear()  ", self._openFunction)
        print(debug.traceback())
    end

    self:hideView()
end

function ControlPadNormal:getIdleAnimationName(skeleton)
    if(skeleton) then 
        return string.format("idle%s", skeleton._extend)
    end

    return "idle"
end

function ControlPadNormal:getClickAnimationName(skeleton)
    if(skeleton) then 
        return string.format("click%s", skeleton._extend)
    end

    return "click"
end

-- 控制面板弹出
function ControlPadNormal:handleView()
    if self._openFunction then
        if(self._directionChange) then
            self._directionChange = false
            -- 重新收回来在打开
            self:setDisappear(function()
                if self._openFunction then
                    self:setSkeletonIdel()

                    self:refreshRolation()
                end
            end)
        else 
            self:showView()
        end

        if(MULTI_TOUCH_CONTROL_ID) then 
            --  这里把回调里面的触发移动给去掉了，这里处理为点击就开始移动
            if(self._triggerOneMove) then 
                if newTouchSkeleton == nil then 
                    newTouchSkeleton = preTouchSkeleton
                end
            end

            self:moveRockerNew(preTouchSkeleton,newTouchSkeleton)
        end
    end
end

function ControlPadNormal:showView(callback)
    self:_resetAction()
    if(self._bg) then 
        local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
        self._bg:runAction(upAction)
    end

    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.rightSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.downSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.upSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.leftSkeleton:runAction(upAction)

    self:refreshRolation()

    if(callback) then
        callback()
    end
end

function ControlPadNormal:hideView(callback)
    if(DEBUG) then
        print("ControlPadNormal:hideView()  ", self._openFunction)
    end
    self:_resetAction()

    if(self._bg) then 
        local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, 0))
        self._bg:runAction(upAction)
    end

    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, 0))
    self.rightSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, 0))
    self.downSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, 0))
    self.upSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(0.25, 0))
    self.leftSkeleton:runAction(upAction)
end

function ControlPadNormal:endDiaphaneityView()
    if(DEBUG) then
        print("ControlPadNormal:endDiaphaneityView()  ", self._openFunction)
    end
    self:_resetAction()
    local time = 0.25

    if(self._bg) then 
        local upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
        self._bg:runAction(upAction)
    end

    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self.rightSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self.downSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self.upSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self.leftSkeleton:runAction(upAction)
end

function ControlPadNormal:diaphaneityView()
    if(DEBUG) then
        print("ControlPadNormal:diaphaneityView()  ", self._openFunction)
    end
    self:_resetAction()

    local time = 1

    if(self._bg) then 
        local upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
        self._bg:runAction(upAction)
    end

    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    self.rightSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    self.downSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    self.upSkeleton:runAction(upAction)
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    self.leftSkeleton:runAction(upAction)
end

function ControlPadNormal:_resetAction()
    -- self.rightSkeleton:stopAllActions()
    -- self.downSkeleton:stopAllActions()
    -- self.upSkeleton:stopAllActions()
    -- self.leftSkeleton:stopAllActions()
end

function ControlPadNormal:updateTigerEffect()

    if (GameManager:getIsInNewScene()) then
        return
    end
    if not self._samllTouchLayout then
        return
    end

    self:initUseUIValue()
    -- self._isTiger = false

    -- local masterData = GameDataManager:getInstance():getMaster()
    -- if masterData then
    --     local eData = masterData:getGameUIEquippedDecorates()

    --     for k,v in pairs(eData) do
    --         if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
    --             if v.value == 1 then --虎年
    --                 self._isTiger = true
    --                 break
    --             end
    --         end
    --     end
    -- end

    if (self.rightSkeleton) then
        self.rightSkeleton:removeFromParent()
        self.rightSkeleton = nil
    end

    if (self.leftSkeleton) then
        self.leftSkeleton:removeFromParent()
        self.leftSkeleton = nil
    end

    if (self.downSkeleton) then
        self.downSkeleton:removeFromParent()
        self.downSkeleton = nil
    end

    if (self.upSkeleton) then
        self.upSkeleton:removeFromParent()
        self.upSkeleton = nil
    end

    preTouchSkeleton = nil  -- 控制面板上次点击的方向
    newTouchSkeleton = nil

    local fJson = CONTROL_JSON
    local fAtlas = CONTROL_ATLAS

    if self._isTiger then
        -- fJson = CONTROL_JSON_TIGER
        -- fAtlas = CONTROL_ATLAS_TIGER
        fJson = "effect_ui_general_controlpad2" .. self._appendStr .. ".json" --CONTROL_JSON_TIGER
        fAtlas = "effect_ui_general_controlpad2" .. self._appendStr .. ".atlas" -- CONTROL_ATLAS_TIGER
    end


    self.rightSkeleton = UI.Animation:create()
    self.rightSkeleton:init(fJson, fAtlas, 1)
    self.rightSkeleton._extend = "_sy"

    -- self.rightSkeleton:enableDebugDraw()
    self.leftSkeleton = UI.Animation:create()
    self.leftSkeleton:init(fJson, fAtlas, 1)
    self.leftSkeleton._extend = "_xz"

    self.downSkeleton = UI.Animation:create()
    self.downSkeleton:init(fJson, fAtlas, 1)
    self.downSkeleton._extend = "_xy"

    self.upSkeleton = UI.Animation:create()
    self.upSkeleton:init(fJson, fAtlas, 1)
    self.upSkeleton._extend = "_sz"
    -- self.upSkeleton:enableDebugDraw()

    -- self.rightSkeleton:setRotationSkewY(180)
    -- self.downSkeleton:setRotation(180)
    -- self.leftSkeleton:setRotationSkewX(180)

    self._samllTouchLayout:addChild(self.rightSkeleton)
    self._samllTouchLayout:addChild(self.downSkeleton)
    self._samllTouchLayout:addChild(self.leftSkeleton)
    self._samllTouchLayout:addChild(self.upSkeleton)

    local offset = ROCKER_NEW_OFFSET
    local offset2 = ROCKER_NEW_OFFSET + ROCKER_RADIUS

    self.rightSkeleton:setPosition(cc.p(offset2, offset2))
    self.leftSkeleton:setPosition(cc.p(offset, offset))
    self.upSkeleton:setPosition(cc.p(offset, offset2))
    self.downSkeleton:setPosition(cc.p(offset2, offset))

    local masterData = GameDataManager:getInstance():getMaster()
    local reverse = masterData:haveFunctionFlag(PublicDefine.FunctionFlag.FunctionFlag_Reverse)
    local confuse = masterData:isConfuse()
    if(reverse) then 
        self:reverseChange(reverse)
    else 
        self._reverse = false
    end
    if(confuse) then 
        self:confuseChange(confuse)
    else 
        self._confuse = false
    end

    self:setSkeletonIdel()
    self:handleRolation()
end

function ControlPadNormal:isDecorateValue(dValue)
    local useValue = PublicDefine.UseUIDecorateValue.DecorateValue_Default
    local masterData = GameDataManager:getInstance():getMaster()
    if not masterData then
        return useValue
    end

    local eData = masterData:getGameUIEquippedDecorates()
    for k,v in pairs(eData) do
        if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
            if v.value == dValue then
                useValue = dValue
                break;
            end
        end
    end

    return useValue
end

function ControlPadNormal:initUseUIValue()
    self._isTiger = false
    self._appendStr = ""
    for i = PublicDefine.UseUIDecorateValue.DecorateValue_Tiger, PublicDefine.UseUIDecorateValue.DecorateValue_Max - 1, 1 do
        local useValue = self:isDecorateValue(i)
        if useValue ~= PublicDefine.UseUIDecorateValue.DecorateValue_Default then
            self._isTiger = true
            if useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger then
                self._appendStr = "_tiger"
            elseif useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate then
                self._appendStr = "_pirate"
            end
        end
    end
end