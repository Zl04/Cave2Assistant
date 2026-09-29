--[[
	--ControlPad.lua
	--Author:杜青辉
	--2017年04月01日 xx:xx
	--Using:控制移动的面板    
]]--

require "utils.Scheduler"

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local MachineManager = require("app.game.MachineManager")

UI = UI or {}
local ControlPad = class("ControlPad",UI.Component)
UI.ControlPad = ControlPad

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
local CONTROL_PAD_INIT_INFO = {
    X = 0,
    Y = 0,
    WIDTH = 240 + OFFSET_X,
    HEIGHT = 240
}

local CONTROL_PAD_SMALL_INFO = {
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
LAYOUT_LEFT = 0
local LAYOUT_BOTTON = 30
local LAYOUT_MAX_LEFT = 210

-- 方向键的动画资源
local CONTROL_JSON=  "effect_ui_general_controlpad.json"
local CONTROL_ATLAS = "effect_ui_general_controlpad.atlas"

local CONTROL_CONFUSE_JSON=  "effect_ui_general_controlpad_confuse.json"
local CONTROL_CONFUSE_ATLAS = "effect_ui_general_controlpad_confuse.atlas"

local DEBUG = false

-- local CONTROL_BUTTON_RADIUS = 142
local CONTROL_BUTTON_RADIUS = 100

local CONTROL_BUTTON_OLED_AREA = {
    x = 46,
    y = 16,
    width = 350,
    height = 350
}

local CONTROL_BUTTON_AREA = {
    x = 0,
    y = 0,
    width = size.width,
    height = size.height
}

local CONTROL_BUTTON_CENTER_AREA = {
    x = CONTROL_BUTTON_AREA.x + CONTROL_BUTTON_RADIUS,
    y = CONTROL_BUTTON_AREA.y + CONTROL_BUTTON_RADIUS,
    width = CONTROL_BUTTON_AREA.width - CONTROL_BUTTON_RADIUS*2,
    height = CONTROL_BUTTON_AREA.height - CONTROL_BUTTON_RADIUS*2
}

-- 可以触发的区域
local CONTROL_TRIGGER_AREA = {
    x = 0,
    y = 0,
    width = size.width,
    height = size.height
}

-- 构造函数
function ControlPad:ctor(type)
    ControlPad.super.ctor(self,UIType.CONTROLPAD,{
        {}
    }, CONTROL_BUTTON_RADIUS * 2, CONTROL_BUTTON_RADIUS * 2)

    preTouchSkeleton = nil
    newTouchSkeleton = nil
    MULTI_TOUCH_CONTROL_ID = nil
    if(MULTI_TOUCH_ID_ARR) then 
        for k,value in pairs(MULTI_TOUCH_ID_ARR) do 
            MULTI_TOUCH_ID_ARR[k] = false
        end
    end

    local center = (size.width /2 - 552 * ToolsUtil:getAdaptationMinScale()/2 - Avalon.issUtil:getLeftMargin())/2 - CONTROL_BUTTON_RADIUS
    local min = LAYOUT_LEFT
    -- print("ControlPad ", size.width, ToolsUtil:getAdaptationMinScale(), center)
    if(center > min) then
        LAYOUT_LEFT = center
    end

    if(LAYOUT_LEFT > LAYOUT_MAX_LEFT) then 
        LAYOUT_LEFT = LAYOUT_MAX_LEFT
    end

    -- CONTROL_BUTTON_AREA.x = LAYOUT_LEFT
    -- CONTROL_BUTTON_CENTER_AREA.x =  CONTROL_BUTTON_AREA.x + CONTROL_BUTTON_RADIUS
    -- CONTROL_TRIGGER_AREA.x = CONTROL_TRIGGER_AREA.x + LAYOUT_LEFT
    local centerX = CONTROL_BUTTON_OLED_AREA.x + CONTROL_BUTTON_RADIUS > LAYOUT_LEFT and (CONTROL_BUTTON_OLED_AREA.x + CONTROL_BUTTON_RADIUS) or LAYOUT_LEFT
    -- 摇杆的圆心坐标
    self._defaultCoord = {x = centerX, y = CONTROL_BUTTON_OLED_AREA.y + CONTROL_BUTTON_RADIUS}
    self._centerCoord = {x = self._defaultCoord.x, y = self._defaultCoord.y}

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
    -- 方向是否改变
    self._directionChange = false

    self._isTouchLongTime = false
    self._isTouchClick = false
    self._beginTouchPosition = nil

    self._lastReverse = false

    self._isTiger = false
    self._appendStr  = ""
    self:initUseUIValue()

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
    
    self:recoverPosition()
end

-- 析构函数
function ControlPad:dtor()
    -- print("ControlPad:dtor ")
    self._samllTouchLayout = nil
    -- Avalon.Scheduler:unscheduleUpdateOnce(self, ControlPad.setDisappear)
    ControlPad.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVERSE_CHANGE, self, self.reverseChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_HERO_CONFUSE, self, self.confuseChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLEAR_DIRCTION_AND_START_MOVE_CONTROL_PAD, self, self.resumeMove)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CONTROL_END, self, self.assertTouch)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
    
    Avalon.Scheduler:unscheduleUpdate(self, self.statusChange)
end

function ControlPad:triggerDiaphaneity()
    if(self._diaphaneityWaitingTime > diaphaneityWaitingTime) then 
        self._diaphaneityWaitingTime = 0
        self:endDiaphaneityView()
    end
end

-- 打开遥感控制功能
function ControlPad:openFunction(isShield)
    if DEBUG then
        print("ControlPad:openFunction ", GameDataManager:getInstance():canUseControlMove(), isShield)
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
        -- Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPad.setDisappear,delayTime)
        if self.handleView then
            self:handleView()
        end
    end
end

-- 关闭该功能
function ControlPad:closeFunction(isShield)
    if DEBUG then
        print("ControlPad:closeFunction ", isShield)
        print(debug.traceback())
    end
    self._openFunction = false
    if(isShield) then 
        self._isShield = true
    else  
        self._isShield = false

        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
        GameManager:stopMoveHandler()
        -- Avalon.Scheduler:unscheduleUpdateOnce(self,ControlPad.setDisappear)
        -- self._openFunction = false
        -- self:setDisappear()
        self:hideView()
    end
end

function ControlPad:refreshZOrder()
    if(self:checkFixPosition()) then
        self:setLocalZOrder(UI_ZORDER.QUICKCHAT + 1)
    else 
        self:setLocalZOrder(UI_ZORDER.CONTROLPAD)
    end
end

function ControlPad:statusChange(dt)
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

function ControlPad:confuseChange(isConfuse)
    if(self._confuse ~= isConfuse) then
        self._confuse = isConfuse
        self:triggerDiaphaneity()
        if(self._confuse) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111333))
        end
        self._directionChange = true
        if(DEBUG) then 
            print("ControlPad:confuseChange  ", isConfuse, GameDataManager:getInstance():canUseControl(), self._reverse)
        end
        if(GameDataManager:getInstance():canUseControl() == false) then
            self._openFunction = self._confuse
        end 
        self:resetControl()

        self:handleRolation()
        self:refreshAnimation()
        self:recoverPosition()
        self:refreshZOrder()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
    end 
end

function ControlPad:resumeMove()
    -- print(" ControlPad:resumeMove ", self._openFunction, GameDataManager:getInstance():canUseControlMove())
    if(self._openFunction) then 
        if(GameDataManager:getInstance():canUseControlMove()) then
            -- print(" ControlPad:resumeMove 23", preTouchSkeleton, newTouchSkeleton)
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

function ControlPad:resetControl()
    newTouchSkeleton = nil
    preTouchSkeleton = nil
    self._preMoveDirection = nil
end

function ControlPad:reverseChange(isReverse)
    if(self._reverse ~= isReverse) then
        self._reverse = isReverse
        self:triggerDiaphaneity()
        if(self._reverse) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111333))
        end
        if DEBUG then
            print("ControlPad:reverseChange  ", isReverse, GameDataManager:getInstance():canUseControl(), self._confuse)
        end
        if(GameDataManager:getInstance():canUseControl() == false) then
            self._openFunction = self._reverse
        end
        self:resetControl()

        self._directionChange = true
        self:handleRolation() 
        self:refreshAnimation()
        self:recoverPosition()
        self:refreshZOrder()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)
    end 
end

function ControlPad:handleRolation()
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
        self:refreshRolation()
        return
    end
    if DEBUG then
        print("ControlPad:reverseChange  is click isReverse", self._confuse, self._reverse)
    end
    if(self._confuse or self._reverse) then
        -- Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPad.setDisappear,delayTime)
        self:handleView()
    else
        -- Avalon.Scheduler:unscheduleUpdateOnce(self,ControlPad.setDisappear)
        -- self:setDisappear()
    end
end

-- 初始化
function ControlPad:init(data)
    self._direction = DirectionType.NONE
    self:addTouchEvents()  
    ControlPad.super.init(self,data)
end

-- 触摸监听
function ControlPad:addTouchEvents()
    local function onTouchBegan(touch, event)
        if DEBUG then
            print("ControlPad:onTouchBegan1   ", GameDataManager:getInstance():canUseControlMove())
        end
        self._preMoveDirection = nil
        self._toucheBeganPosition = nil
        self._touchMovePosition = nil
        self._isTouchLongTime = false
        if(GameDataManager:getInstance():canUseControlMove() == false and self._isShield == false) then
            -- return false
        else
            --先判断是否在摇杆的当前区域，如果没有在当前区域，就会在touchMove 里面添加触发开始移动
            local isInSmallRect = false
            local posTouch = touch:getLocation()
            isInSmallRect = self:checkTouchPosition(posTouch)

            if(self:checkTouchIsInRect(CONTROL_TRIGGER_AREA, posTouch)) then
                self._toucheBeganPosition = posTouch
            end

            if(self:checkFixPosition()) then 
                if(self._openFunction or self._isShield) and isInSmallRect then

                    self:triggerStart(posTouch, posTouch)
                    return true
                end 

                -- return false
            end
        end
        self._isInControlPad = false

        local touchPosition = touch:getLocation()
        -- if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
        --     if(UI.ChatQuickLayer:getInstance():checkTouchPosition(touchPosition)) then 
        --         return true
        --     end
        -- end
        self._isTouchClick = true
        self._beginTouchPosition = touchPosition
        -- print(string.format("TouchLayer onTouchBegan: touch position %f %f.", touchPosition.x, touchPosition.y))

        MachineManager:getInstance():pushTouchBeganCommand(touchPosition)
        Avalon.Scheduler:scheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler, 0.5, touchPosition)
        Avalon.Scheduler:scheduleUpdateOnce(self, self.onTouchRemoveClickHandler, 0.2, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_COMMENT_END, COMMENT_END_NOTICE_TYPE.TOUCH_SCREEN)
        return true
    end

    local function onTouchMoved(touch, event)
        if DEBUG then
            print("ControlPad:onTouchMoved", self._isInControlPad)
        end
        local touchPosition = touch:getLocation()
        self._touchMovePosition = touchPosition
        if(self._isInControlPad) then
            if(GameDataManager:getInstance():canUseControlMove() == false and self._isShield == false) then
                return false
            end
            if self._openFunction or self._isShield then

                self:triggerMove(touchPosition)
                return true
            end
        else 
            -- 这里需要处理是否有拖动的操作，如果有拖动操作就判定为启用摇杆操作
            if(self._toucheBeganPosition and self:checkFixPosition() == false) then 
                -- 判断是否移动到了换出摇杆的距离
                local offsetX = touchPosition.x - self._toucheBeganPosition.x 
                local offsetY = touchPosition.y - self._toucheBeganPosition.y 
                -- print("ControlPad:onTouchMoved =", offsetX, offsetY, self._toucheBeganPosition.x , self._toucheBeganPosition.y)
                if(offsetX * offsetX + offsetY * offsetY > 64) then 
                    self:triggerStart(self._toucheBeganPosition, touchPosition)
                    -- 取消点击的表现
                    MachineManager:getInstance():pushTouchCancelCommand(touchPosition)

                    if (self._isTouchLongTime) then
                        self:onTouchLongTimeEndedHandler(touchPosition)
                    else
                        Avalon.Scheduler:unscheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler)
                    end
                    return true
                end
            end
            
            -- if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
            --     if(UI.ChatQuickLayer:getInstance():checkTouchPosition(touchPosition)) then 
            --         return false
            --     end
            -- end

            MachineManager:getInstance():pushTouchMovedCommand(touchPosition)
        end
    end

    local function onTouchEnded(touch, event)
        if DEBUG then
            print("ControlPad:onTouchEnded   ", GameDataManager:getInstance():canUseControlMove())
        end
        if(not self:checkFixPosition()) then 
            self:hideView()
        end
        local touchPosition = touch:getLocation()
        if(self._isInControlPad) then 
            if (self._isTouchLongTime) then
                self:onTouchLongTimeEndedHandler(touchPosition)
            else
                Avalon.Scheduler:unscheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler)
            end
            self._isInControlPad = false
            self:triggerEnd()
        else 
            self._isInControlPad = false

            -- if UI.ChatQuickLayer and UI.ChatQuickLayer:isInit() then
            --     if(UI.ChatQuickLayer:getInstance():checkTouchPosition(touchPosition)) then 
            --         return false
            --     end
            -- end

            MachineManager:getInstance():pushTouchEndedCommand(touchPosition)
            
            if(self._isTouchClick) then
                -- print("ddddddddddddd", self._beginTouchPosition, touchPosition)
                local offsetX = self._beginTouchPosition.x - touchPosition.x 
                local offsetY = self._beginTouchPosition.y - touchPosition.y
                if(offsetX * offsetX + offsetY * offsetY < 100) then
                    -- 触发点击事件
                    MachineManager:getInstance():pushTouchClickCommand(touchPosition)
                end
            end

            if (self._isTouchLongTime) then
                self:onTouchLongTimeEndedHandler(touchPosition)
            else
                Avalon.Scheduler:unscheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler)
            end
        end

        -- self:recoverPosition()
    end

    local beginUseID = nil
    local function onTouchesBegan(touches, event)
        -- beginUseID = nil
        -- MULTI_TOUCH_CONTROL_ID = nil
        -- print("....multouch onTouchesBegan test........", touches)
        -- print("ControlPad:--------------------- onTouchesBegan 1 id=", MULTI_TOUCH_CONTROL_ID, beginUseID)
        for _id, touch in pairs(touches) do 
            local id = touch:getId()
            if(id == beginUseID) then 
                beginUseID = nil
                MULTI_TOUCH_CONTROL_ID = nil
            end
            -- print("ControlPad:--------------------- onTouchesBegan id=", id, beginUseID)
            if(MULTI_TOUCH_ID_ARR[id] ~= true and MULTI_TOUCH_CONTROL_ID == nil) then
                -- print("ControlPad wwwwwwwwwwwwwwwwwwwww  id=", id)
                local use = onTouchBegan(touch, event)
                if(use) then 
                    -- print("ControlPad wwwwwwwwwwwwwwwwwwwww use id=", id, self.__cname, self._mn)
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
            --     print("ControlPad wwwwwwwwwwwwwwwwwwwww use end id=", beginUseID)
            -- end 

            for _id, touch in pairs(touches) do 
                -- if(beginUseID) then 
                --     onTouchEnded(touch, event)
                --     MULTI_TOUCH_CONTROL_ID = nil
                --     beginUseID = nil
                -- end
                -- print("ControlPad onTouchesEnded wwwwwwwwwwwwwwwwwwwww  id=", touch:getId())
                -- print("ControlPad:---------------------  use end trigger id=", touch:getId(), beginUseID)
                if touch:getId() == beginUseID then 
                    -- print("ControlPad wwwwwwwwwwwwwwwwwwwww use end  handle id=", touch:getId())
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

function ControlPad:getNowControlRect()

end

-- 恢复位置
function ControlPad:recoverPosition()
    self._centerCoord.x = self._defaultCoord.x + Avalon.issUtil:getLeftMargin()
    self._centerCoord.y = self._defaultCoord.y

    self:leftBottom(self._centerCoord.x - CONTROL_BUTTON_RADIUS - Avalon.issUtil:getLeftMargin(), self._centerCoord.y - CONTROL_BUTTON_RADIUS)
end

function ControlPad:checkFixPosition()
    if(self._reverse or self._confuse) then 
        return true
    end

    return false
end

function ControlPad:triggerStart(posTouch, nowPosition)
    -- 计算摇杆的位置
    local refreshPosition = true
    self._touchMovePosition = nowPosition
    if(self:checkFixPosition()) then 
        refreshPosition = false
        -- if(self:checkTouchPosition(posTouch) == false) then 
            
        -- end
    end
    if(refreshPosition) then 
        if(posTouch.y > CONTROL_BUTTON_CENTER_AREA.y + CONTROL_BUTTON_CENTER_AREA.height) then 
            if(CONTROL_BUTTON_CENTER_AREA.x > posTouch.x) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x 
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y + CONTROL_BUTTON_CENTER_AREA.height
            elseif (CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width < posTouch.x ) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y + CONTROL_BUTTON_CENTER_AREA.height
            else 
                self._centerCoord.x = posTouch.x
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y + CONTROL_BUTTON_CENTER_AREA.height
            end 
        elseif (posTouch.y < CONTROL_BUTTON_CENTER_AREA.y) then 
            if(CONTROL_BUTTON_CENTER_AREA.x > posTouch.x) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x 
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y
            elseif (CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width < posTouch.x ) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y 
            else 
                self._centerCoord.x = posTouch.x
                self._centerCoord.y = CONTROL_BUTTON_CENTER_AREA.y
            end 
        else 
            if(CONTROL_BUTTON_CENTER_AREA.x > posTouch.x) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x 
                self._centerCoord.y = posTouch.y
            elseif (CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width < posTouch.x ) then 
                self._centerCoord.x = CONTROL_BUTTON_CENTER_AREA.x + CONTROL_BUTTON_CENTER_AREA.width
                self._centerCoord.y = posTouch.y
            else 
                self._centerCoord.x = posTouch.x
                self._centerCoord.y = posTouch.y
            end 
        end
    end
    -- print("pre position=", posTouch.x, posTouch.y)
    -- print("now position=", nowPosition.x, nowPosition.y)
    -- print("center position=", self._centerCoord.x, self._centerCoord.y)

    self:leftBottom(self._centerCoord.x - CONTROL_BUTTON_RADIUS - Avalon.issUtil:getLeftMargin(), self._centerCoord.y - CONTROL_BUTTON_RADIUS)

    self:triggerDiaphaneity()
    if self._controlSkeleton:isVisible() then
        preTouchSkeleton = self:getTouchSkeleton(nowPosition)
    end

    if preTouchSkeleton then
        if DEBUG then
            print("ControlPad:onTouchBegan5  preTouchSkeleton is nil")
        end
        -- 点中控制按钮
        self:startRockerNew(preTouchSkeleton)
        self:refreshCirclePosition(preTouchSkeleton)
    end
    -- 这里防止点击了没有移动，导致后面无法直接移动
    newTouchSkeleton = preTouchSkeleton
    self._isInControlPad = true
end 

function ControlPad:triggerMove(posTouch)
    newTouchSkeleton = self:getTouchSkeleton(posTouch)
    -- 获取新的方向键
    if newTouchSkeleton then
        if preTouchSkeleton then 
            self:moveRockerNew(preTouchSkeleton,newTouchSkeleton)
            self:refreshCirclePosition(newTouchSkeleton)
        else
            self:startRockerNew(newTouchSkeleton)
        end

        preTouchSkeleton = newTouchSkeleton
        newTouchSkeleton = nil
    else
        -- 移动到控制面板外面
        self:endRockerNew(preTouchSkeleton, true)
    end
end

function ControlPad:triggerEnd(posTouch)
    self:handleEndTouchMove()
    self:refreshCirclePosition()
end

function ControlPad:checkTouchIsInRect(rect, touchPosition) 
    if(rect and touchPosition) then 
        if cc.rectContainsPoint(rect, touchPosition) then
            return true
        end
    end

    return false
end

function ControlPad:assertTouch()
    MULTI_TOUCH_CONTROL_ID = nil
    beginUseID = nil
    for k,value in pairs(MULTI_TOUCH_ID_ARR) do 
        MULTI_TOUCH_ID_ARR[k] = false
    end
    
    self:handleEndTouchMove()
end

function ControlPad:handleEndTouchMove()
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

    if(not self:checkFixPosition()) then 
        self:hideView()
    end

    newTouchSkeleton = nil 
    preTouchSkeleton = nil 
end

-- 初始化视图
function ControlPad:onInitView()
    -- print ("====ControlPad:initView====")
    local samllTouchLayout = UI.Layout:create()
    samllTouchLayout:init()
    samllTouchLayout:setSize(CONTROL_PAD_SMALL_INFO.WIDTH, CONTROL_PAD_SMALL_INFO.HEIGHT)
    -- samllTouchLayout:leftBottom(LAYOUT_LEFT, LAYOUT_BOTTON)
    samllTouchLayout:center()
    -- samllTouchLayout:enableDebugDraw(UI.RED)
    self:addChild(samllTouchLayout)
    self._samllTouchLayout = samllTouchLayout

    local touchBeginLayout = UI.Layout:create()
    touchBeginLayout:init()
    touchBeginLayout:setSize(CONTROL_PAD_INIT_INFO.WIDTH + LAYOUT_LEFT + Avalon.issUtil:getLeftMargin(), 
        CONTROL_PAD_INIT_INFO.HEIGHT + LAYOUT_BOTTON + Avalon.issUtil:getBottomMargin())
    touchBeginLayout:leftBottom(- Avalon.issUtil:getLeftMargin(), 
        -Avalon.issUtil:getBottomMargin())
    touchBeginLayout:center()
    self:addChild(touchBeginLayout)
    self._touchBeginLayout = touchBeginLayout

    self._controlSkeleton = UI.Animation:create()
    if self._isTiger then
        -- self._controlSkeleton:init("effect_ui_general_controlpad_tiger.json", "effect_ui_general_controlpad_tiger.atlas", 1)
        local spStr = string.format("effect_ui_general_controlpad%s", self._appendStr)
        self._controlSkeleton:init(spStr .. ".json", spStr .. ".atlas", 1)
    else
        self._controlSkeleton:init(CONTROL_JSON, CONTROL_ATLAS, 1)
    end
    self._controlSkeleton:center()
    self:addChild(self._controlSkeleton)
    self._controlSkeleton:setAnimation("idle", true)

    -- 添加了小圆环
    local cricleImage = cc.Sprite:create()
    cricleImage:setSpriteFrame("ui_information_controlpad_confuse_circle.png")
    self._controlSkeleton:addChild(cricleImage, 100)
    self._cricleImage = cricleImage

    self.rightSkeleton = UI.Animation:create()
    self.rightSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.rightSkeleton._extend = "_ys"

    self.leftSkeleton = UI.Animation:create()
    self.leftSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.leftSkeleton._extend = "_zx"

    self.downSkeleton = UI.Animation:create()
    self.downSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.downSkeleton._extend = "_yx"

    self.upSkeleton = UI.Animation:create()
    self.upSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.upSkeleton._extend = "_zs"

    self._controlSkeleton:addComponent("confuse_1", self.rightSkeleton)
    self._controlSkeleton:addComponent("confuse_2", self.downSkeleton)
    self._controlSkeleton:addComponent("confuse_3", self.leftSkeleton)
    self._controlSkeleton:addComponent("confuse_4", self.upSkeleton)

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
    self:refreshAnimation()
    self:hideView()

    if (device.platform == "mac" or device.platform == "windows") then
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
            elseif keycode == cc.KeyCode.KEY_E then
                mvc.openPanel("GuildAuction", "GuildAuction")

                -- mvc.openPanel("StarPray", "StarPrayShop")
        --         if _MyTestView.caveActivityDsp then
        --             _MyTestView.caveActivityDsp:removeFromParent()
        --         end
        --         local WorldBossHurtRankView = require "app.modules.worldboss.WorldBossHurtRankView"
        -- local caveActivityDSP = WorldBossHurtRankView:create()
        -- caveActivityDSP:leftUp(0, 128)
        -- _MyTestView.chatPannel:addChild(caveActivityDSP)
        -- _MyTestView.caveActivityDsp = caveActivityDSP
        -- Net.NetRoleSystem:heroEnterCaveSceneRequest(PublicDefine.GAME_MODE.MODE_GROUP,
        --     PublicDefine.CAVE_MODE.MODE_WORLD_BOSS,nil,8003,0, 0)
        --     print("send....")
        --         print(PublicDefine.GAME_MODE.MODE_GROUP, PublicDefine.CAVE_MODE.MODE_WORLD_BOSS,nil,8003,0, 0)
            elseif keycode == cc.KeyCode.KEY_Q then
                -- mvc.send("Close_Panel","WorldBoss","WorldBossWinResult")
                mvc.closePanel("StarPray", "StarPrayShop")
            elseif keycode == cc.KeyCode.KEY_Y then
                __EDIT_ = not __EDIT_
            elseif keycode == cc.KeyCode.KEY_LEFT_ARROW then
                if adjustEditorModeSelectedNodePos then
                    adjustEditorModeSelectedNodePos(1)
                end
            elseif keycode == cc.KeyCode.KEY_RIGHT_ARROW then
                if adjustEditorModeSelectedNodePos then
                    adjustEditorModeSelectedNodePos(3)
                end
            elseif keycode == cc.KeyCode.KEY_UP_ARROW then
                if adjustEditorModeSelectedNodePos then
                    adjustEditorModeSelectedNodePos(2)
                end
            elseif keycode == cc.KeyCode.KEY_DOWN_ARROW then
                if adjustEditorModeSelectedNodePos then
                    adjustEditorModeSelectedNodePos(4)
                end
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
function ControlPad:updateView(data)
    ControlPad.super.updateView(self, data)
  -- body
end

-- 更新控制面板延时消失时间
function ControlPad:updateDelayTime()
--    Avalon.Scheduler:setDelayForUpdateOnce(self,ControlPad.setDisappear,delayTime)
end

-- 获取点击的方向
function ControlPad:getTouchSkeleton(posTouch)
    -- body
    local size  = self:getContentSize()
    local startX = self:getPositionX() + Avalon.issUtil:getLeftMargin()
    local startY = self:getPositionY() + Avalon.issUtil:getBottomMargin()

    local worldPos = self:convertToWorldSpace(cc.p(0, 0))

    ROCKER_RADIUS = CONTROL_BUTTON_RADIUS * 2

    startX = worldPos.x
    startY = worldPos.y
    if  posTouch.x > (startX + ROCKER_RADIUS / 2) and  posTouch.y > (startY + ROCKER_RADIUS/2) then
        self._direction = self.rightSkeleton._direction
        return self.rightSkeleton
    elseif  posTouch.x > (startX + ROCKER_RADIUS / 2) and posTouch.y < (startY + ROCKER_RADIUS/2)  then
        self._direction = self.downSkeleton._direction
        return self.downSkeleton
    elseif  posTouch.x < (startX + ROCKER_RADIUS / 2) and posTouch.y  > (startY + ROCKER_RADIUS/2)  then
        self._direction = self.upSkeleton._direction
        return self.upSkeleton
    else  
        self._direction = self.leftSkeleton._direction
        return  self.leftSkeleton
    end
end

-- 开始移动
function ControlPad:startRockerNew(skeleton)
    -- add by zp 修改为出现了就可以点击操作的处理
    -- if skeleton and self._actionEnd then
    if skeleton then
        startTime = AvalonUtil.getCurrentTime() 
        if(DEBUG) then
            print("===startTime",startTime, self._preMoveDirection, self._direction, GameDataManager:getInstance():canUseControlMove())
        end
        if not skeleton._inloop then
            -- skeleton:setAnimation(self:getClickAnimationName(skeleton), true)
            self._controlSkeleton:setOpacity(255)
            self._controlSkeleton:setAnimation(self:getControlClickAnimationName(skeleton), true)
            
            self:refreshCircle(skeleton)
            self:refreshConfuseAnimation(skeleton, true)
        end

        if(self._direction ~= self._preMoveDirection) then
            -- print("===startTime  333",GameDataManager:getInstance():canUseControlMove())
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
function ControlPad:endRockerNew(skeleton, stop)
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
        -- 优化当前的逻辑
        self._controlSkeleton:setAnimation(self:getControlIdleAnimationName(), false)
        self:refreshCircle(nil, true)
        self:refreshConfuseAnimation(skeleton)
    end
end

-- 方向更改
function ControlPad:moveRockerNew(oldskeleton,newskeleton)
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

function ControlPad:refreshCircle(skeleton, isEnd)
    self._cricleImage:setSpriteFrame(self:getCricleImageName())
end

--[[
-- @param p1 A点 p2 B点  返回以A为比较点 B相对于A的夹角 范围为-180度到180度
]]
function ControlPad:getAngleByPos(p1,p2)
    local p = {}
    p.x = p2.x - p1.x
    p.y = p2.y - p1.y
           
    local r = math.atan2(p.y,p.x)*180/math.pi
    print("夹角[-180 - 180]:",r)
    return r
end

function ControlPad:refreshCirclePosition(skeleton)
    local point = cc.p(0,0)
    if self._touchMovePosition and skeleton then 
        local cricleRedis = 50

        local worldPos = self:convertToWorldSpace(cc.p(0, 0))
        local startX = worldPos.x + CONTROL_BUTTON_RADIUS
        local startY = worldPos.y + CONTROL_BUTTON_RADIUS

        local endX = self._touchMovePosition.x 
        local endY = self._touchMovePosition.y
        -- print("ControlPad:refreshCirclePosition x,y=", endX, endY, startX, startY)

        local chaX = endX - startX
        local chaY =  endY - startY
        local bian = math.sqrt(chaX * chaX + chaY * chaY)
        -- print("ControlPad:refreshCirclePosition x,y=", bian, chaX, chaY)
        if(bian <= cricleRedis) then 
            point = cc.p(chaX, chaY)
        else 
            local x = cricleRedis * math.abs(chaX)/ bian
            local y = cricleRedis * math.abs(chaY)/ bian
            
            if(chaX >= 0) then 
                if(chaY >= 0) then 
                    point = cc.p(x, y)
                else 
                    point = cc.p(x, -y)
                end
            else 
                if(chaY >= 0) then 
                    point = cc.p(-x, y)
                else 
                    point = cc.p(-x, -y)
                end
            end


            -- local angle = self:getAngleByPos(cc.p(startX, startY), self._touchMovePosition)
            -- point = cc.p(cricleRedis * math.sin(angle), cricleRedis * math.cos(angle))
            -- print("ControlPad:refreshCirclePosition x,y=", point.x, point.y)
        end

        self._cricleImage:setPosition(point.x, point.y)

        -- if(skeleton) then 
        --     if(skeleton == self.rightSkeleton) then
        --         point = cc.p(cricleRedis, cricleRedis)
        --     elseif (skeleton == self.downSkeleton) then
        --         point = cc.p(cricleRedis, -cricleRedis)
        --     elseif (skeleton == self.leftSkeleton) then
        --         point = cc.p(-cricleRedis, - cricleRedis)
        --     elseif (skeleton == self.upSkeleton) then
        --         point = cc.p(-cricleRedis, cricleRedis)
        --     end 
        -- end
        -- if(self._prePosition == nil or not (self._prePosition.x == point.x and self._prePosition.y == point.y)) then
        --     self._prePosition = point
        --     -- print("ControlPad:refreshCircle 1", point)
        --     -- print(debug.traceback())
        --     self._cricleImage:stopAllActions()
        --     self._cricleImage:runAction(cc.MoveTo:create(0.1, point))
        -- end
    else
        self._cricleImage:setPosition(0, 0) 
    end 
end 


function ControlPad:refreshConfuseAnimation(skeleton, isStart)
    if(isStart) then 
        local skeletonArr = {}
        if(self.rightSkeleton) then
            table.insert(skeletonArr, self.rightSkeleton)
        end
        if(self.downSkeleton) then
            table.insert(skeletonArr, self.downSkeleton)
        end 
        if(self.leftSkeleton) then
            table.insert(skeletonArr, self.leftSkeleton)
        end
        if(self.upSkeleton) then
            table.insert(skeletonArr, self.upSkeleton)
        end

        for _,nowSkeleton in ipairs(skeletonArr) do 
            if(nowSkeleton == skeleton) then 
                -- print("refreshConfuseAnimation  click", self:getConfuseClickAnimationName())
                skeleton:setAnimation(self:getConfuseClickAnimationName(), true)
            else 
                -- print("refreshConfuseAnimation  no click", self:getConfuseClickAnimationName())
                nowSkeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
            end
        end
    else 
        skeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
    end
end

-- 刷新显示坐标
function ControlPad:refreshRolation()
    local skeletonArr = {}
    if(self.rightSkeleton) then
        table.insert(skeletonArr, self.rightSkeleton)
    end
    if(self.downSkeleton) then
        table.insert(skeletonArr, self.downSkeleton)
    end 
    if(self.leftSkeleton) then
        table.insert(skeletonArr, self.leftSkeleton)
    end
    if(self.upSkeleton) then
        table.insert(skeletonArr, self.upSkeleton)
    end

    for _,skeleton in ipairs(skeletonArr) do 
        local direction = skeleton._direction
        if(direction == DirectionType.EAST) then
            skeleton:setRotation(90)
        elseif (direction == DirectionType.SOUTH) then
            skeleton:setRotation(180)
        elseif (direction == DirectionType.WEAST) then
            skeleton:setRotation(-90)
        elseif (direction == DirectionType.NORTH) then
            skeleton:setRotation(0)
        end 
    end
end

-- 设置控制面板Idel状态
function ControlPad:setSkeletonIdel(callback)
    if(DEBUG) then
        print("ControlPad:setSkeletonIdel()  ", self._openFunction)
    end

    self._actionEnd = false
    self._preMoveDirection = nil

    self.rightSkeleton._inloop = false
    self.downSkeleton._inloop = false
    self.upSkeleton._inloop = false
    self.leftSkeleton._inloop = false
end

-- 控制面板消失
function ControlPad:setDisappear(callback)
    if(DEBUG) then
        print("ControlPad:setDisappear()  ", self._openFunction)
        print(debug.traceback())
    end

    self:hideView()
end


function ControlPad:getCricleImageName()
    if self._isTiger then
        local spStr = string.format("ui_information_controlpad_normal_circle%s.png", self._appendStr)
        -- return "ui_information_controlpad_normal_circle_tiger.png"
        return spStr
    else
        if(self._reverse or self._confuse) then 
            return "ui_information_controlpad_confuse_circle.png"
        else 
            return "ui_information_controlpad_normal_circle.png"
        end 
    end
end

function ControlPad:getControlClickAnimationName(skeleton)
    local animationName = ""
    if(skeleton) then 
        if(self._reverse or self._confuse) then 
            animationName = string.format("confuse_click%s", skeleton._extend)
        else 
            animationName = string.format("click%s", skeleton._extend)
        end 
    end

    return animationName
end

function ControlPad:getControlIdleAnimationName()
    local animationName = ""
    if(self._reverse or self._confuse) then 
        animationName = "confuse_idle2"
    else 
        animationName = "idle2"
    end 

    return animationName
end

function ControlPad:getControlNoHandleIdleAnimationName()
    local animationName = ""
    if(self._reverse or self._confuse) then 
        animationName = "confuse_idle"
    else 
        animationName = "idle"
    end 

    return animationName
end

function ControlPad:getConfuseClickAnimationName()
    return "confuse_click"
end

function ControlPad:getConfuseIdleAnimationName()
    return "confuse-idle2"
end

function ControlPad:getConfuseNoHandleAnimationName()
    return "confuse-idle"
end

function ControlPad:getIdleAnimationName(skeleton)
    if(skeleton) then 
        return string.format("idle%s", skeleton._extend)
    end

    return "idle"
end

function ControlPad:getClickAnimationName(skeleton)
    if(skeleton) then 
        return string.format("click%s", skeleton._extend)
    end

    return "click"
end

-- 控制面板弹出
function ControlPad:handleView()
    if(not self._isInControlPad and not self:checkFixPosition()) then 
        return false
    end

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

function ControlPad:showView(callback)
    self:_resetAction()
    self._controlSkeleton:setVisible(true)
    self._cricleImage:setVisible(true)
    -- self.rightSkeleton:setVisible(true)
    -- self.downSkeleton:setVisible(true)
    -- self.leftSkeleton:setVisible(true)
    -- self.upSkeleton:setVisible(true)

    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self._controlSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self._cricleImage:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.rightSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.downSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.leftSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(0.25, idleOpacity))
    self.upSkeleton:runAction(upAction)

    self:refreshRolation()
    if(callback) then
        callback()
    end
end

function ControlPad:refreshAnimation()
    self._controlSkeleton:setAnimation(self:getControlIdleAnimationName(), true)
    self:refreshCircle()

    -- 刷新方向是否显示
    if(self._confuse or self._reverse) then 
        self.rightSkeleton:setVisible(true)
        self.downSkeleton:setVisible(true)
        self.leftSkeleton:setVisible(true)
        self.upSkeleton:setVisible(true)
    else 
        self.rightSkeleton:setVisible(false)
        self.downSkeleton:setVisible(false)
        self.leftSkeleton:setVisible(false)
        self.upSkeleton:setVisible(false)
    end

    self.rightSkeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
    self.downSkeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
    self.leftSkeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
    self.upSkeleton:setAnimation(self:getConfuseIdleAnimationName(), true)
end

function ControlPad:hideView(callback)
    if(DEBUG) then
        print("ControlPad:hideView()  ", self._openFunction)
    end
    self:_resetAction()

    self._controlSkeleton:setVisible(false)
    self._cricleImage:setVisible(false)
    -- self.rightSkeleton:setVisible(false)
    -- self.downSkeleton:setVisible(false)
    -- self.leftSkeleton:setVisible(false)
    -- self.upSkeleton:setVisible(false)

    local time = 0.1

    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self._controlSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self._cricleImage:runAction(upAction)

    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self.rightSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self.downSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self.leftSkeleton:runAction(upAction)
    local upAction = cc.Sequence:create(cc.FadeTo:create(time, 0))
    self.upSkeleton:runAction(upAction)
end

function ControlPad:endDiaphaneityView()
    if(DEBUG) then
        print("ControlPad:endDiaphaneityView()  ", self._openFunction)
    end
    self:_resetAction()
    local time = 0.25
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self._controlSkeleton:runAction(upAction)
    self._controlSkeleton:setAnimation(self:getControlIdleAnimationName(), true)

    local upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self._cricleImage:runAction(upAction)
    self:refreshCircle()
end

function ControlPad:diaphaneityView()
    if(DEBUG) then
        print("ControlPad:diaphaneityView()  ", self._openFunction)
    end
    self:_resetAction()
    local time = 1
    -- local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, idleOpacity))
    self._controlSkeleton:runAction(upAction)
    self._controlSkeleton:setAnimation(self:getControlNoHandleIdleAnimationName(), true)

    local  upAction = cc.Sequence:create(cc.FadeTo:create(time, diaphaneityOpacity))
    self._cricleImage:runAction(upAction)
    self:refreshCircle()
end

function ControlPad:_resetAction()

end

-- 开始长按处理器
function ControlPad:onTouchLongTimeBeganHandler(touchPosition)
    self._isTouchLongTime = true

    MachineManager:getInstance():pushTouchLongTimeBeganCommand(touchPosition[1])
end

-- 结束长按的处理器
function ControlPad:onTouchLongTimeEndedHandler(touchPosition)
    self._isTouchLongTime = false

    MachineManager:getInstance():pushTouchLongTimeEndedCommand(touchPosition)
end

-- 取消点击事件
function ControlPad:onTouchRemoveClickHandler(touchPosition)
    self._isTouchClick = false
end

function ControlPad:updateTigerEffect()

    if (GameManager:getIsInNewScene()) then
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

    if (self._cricleImage) then
        self._cricleImage:removeFromParent()
        self._cricleImage = nil
    end

    if (self._controlSkeleton) then
        self._controlSkeleton:removeFromParent()
        self._controlSkeleton = nil
    end

    preTouchSkeleton = nil  -- 控制面板上次点击的方向
    newTouchSkeleton = nil

    self._controlSkeleton = UI.Animation:create()
    if self._isTiger then
        local spStr = string.format("effect_ui_general_controlpad%s", self._appendStr)
        -- self._controlSkeleton:init("effect_ui_general_controlpad_tiger.json", "effect_ui_general_controlpad_tiger.atlas", 1)
        self._controlSkeleton:init(spStr .. ".json", spStr .. ".atlas", 1)
    else
        self._controlSkeleton:init(CONTROL_JSON, CONTROL_ATLAS, 1)
    end
    self._controlSkeleton:center()
    self:addChild(self._controlSkeleton)
    self._controlSkeleton:setAnimation("idle", true)

    -- 添加了小圆环
    local cricleImage = cc.Sprite:create()
    cricleImage:setSpriteFrame("ui_information_controlpad_confuse_circle.png")
    self._controlSkeleton:addChild(cricleImage, 100)
    self._cricleImage = cricleImage

    self.rightSkeleton = UI.Animation:create()
    self.rightSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.rightSkeleton._extend = "_ys"

    self.leftSkeleton = UI.Animation:create()
    self.leftSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.leftSkeleton._extend = "_zx"

    self.downSkeleton = UI.Animation:create()
    self.downSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.downSkeleton._extend = "_yx"

    self.upSkeleton = UI.Animation:create()
    self.upSkeleton:init(CONTROL_CONFUSE_JSON, CONTROL_CONFUSE_ATLAS, 1)
    self.upSkeleton._extend = "_zs"

    self._controlSkeleton:addComponent("confuse_1", self.rightSkeleton)
    self._controlSkeleton:addComponent("confuse_2", self.downSkeleton)
    self._controlSkeleton:addComponent("confuse_3", self.leftSkeleton)
    self._controlSkeleton:addComponent("confuse_4", self.upSkeleton)

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
    self:refreshAnimation()
    
    if (device.platform ~= "mac" and device.platform ~= "windows")  then
        self:hideView()
    end

    self:refreshCircle()
end

function ControlPad:isDecorateValue(dValue)
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

function ControlPad:initUseUIValue()
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
