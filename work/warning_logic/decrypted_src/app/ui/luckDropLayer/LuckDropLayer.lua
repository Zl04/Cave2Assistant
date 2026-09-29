--[[Author:ydli
   Using:抽奖
   三阶段实现转盘旋转  当前速度curSpeed  三段函数的返回值 因变量 是  时间dt
    1、加速阶段 用手滑动屏幕离手后触发 在 1 秒 内         把curspeed  加速至 maxSpeed
    2、根据当前速度、减速度 计算出到速度为0 时的距离，
    3、判断速度为0时， 距离目标值还有多远 addNum， 加上步骤2 算出的距离得到最终距离，
    4、根据最终距离和最大速度 计算出 减速度
    5、根据 最大速度和  减速度 运算即可
    6、调试发现 减速过程中 如果有掉帧 会导致实际距离 比 第三步计算出的距离小， 所以得有一个最小速度的匀速调整
   ]]
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
require("app.ui.luckDropLayer.MoveChain")
require("app.datas.EquipIllusionDataManager")

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local LuckDropLayer = class("LuckDropLayer", UI.DoorWin)
UI.LuckDropLayer = LuckDropLayer or {}

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_luckdraw.plist",
}
local TimeOutLimte = 15 --转盘请求超时15秒

local TURN_TABLE_STATE = {
    BEGIN = 1,
    ACCELERATE = 2,
    CHECK = 3,
    DECELERATE = 4,
    ADJUST = 5,
    END = 6,
}
local MAX_SPEED_MODEL = {
    [1] = {floorLimit = 0, upLimite = 10, maxSpeed = 510},
    [2] = {floorLimit = 10, upLimite = 30, maxSpeed = 520},
    [3] = {floorLimit = 30, upLimite = 50, maxSpeed = 530},
    [4] = {floorLimit = 50, upLimite = 80, maxSpeed = 540},
    [5] = {floorLimit = 80, upLimite = 100, maxSpeed = 560},
    [6] = {floorLimit = 100, upLimite = 200, maxSpeed = 580},
    [7] = {floorLimit = 200, upLimite = 400, maxSpeed = 600},
    [8] = {floorLimit = 400, upLimite = 600, maxSpeed = 620},
    [9] = {floorLimit = 600, upLimite = 800, maxSpeed = 640},
    [10] = {floorLimit = 800, upLimite = 1000, maxSpeed = 660},
    [11] = {floorLimit = 1000, upLimite = 2000000000, maxSpeed = 680}
}

local TOUCH_SECONDS = 1 --  脱手后的加速 时间
local DECELERATED_SPEED = 10--默认减速度 每秒减少的角度 
local CHECK_SPEED = 0.1 --180 每zhen
local DISTANCE_SAPCE = 30
local VALID_TOUCH_POINT_LIMIT = 6
local TOTAL_ITEM_SIZE = 8
--构造函数(必备)
function LuckDropLayer:ctor(spriteID)
    -- print("----------LuckDropLayer:ctor()")
    --窗口大小
    LuckDropLayer.super.ctor(
    self,UIType.LUCKDROP,
    COM_RES_LIST,
    600,    
    winSize.height
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mRect = nil;               --判断区域框
    self.delayRefresh = false      --是否有延时刷新， 如果有 在转盘转完后刷新
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener();
    self:init();
    self._maxSpeed = 0
    self.turnTableState = TURN_TABLE_STATE.END
    self.direction = 1 -- 1表示正向顺时针 -1 表示反相逆时针
    --转盘 转动控制相关参数
    self._targetDistance = 0
    self._distance = 0
    self._curSpeed = 0
    self._rotateTime = 0
    self._realDecele = 0
    self.curDecelSpeed = 0
    self.lastDistance = nil
    -- 触摸相关参数
    self.touchPoints = {} --一次滑动所有的触发点
    self.bingoId = 0
    self.lastPlayAudioIndex = -1
    self.nodeCahe = self.nodeCahe or {}
    -- self.pointActionTime = 0
    self.blackSprites = self.blackSprites or {}
    self.bingoItems = {}
    self._showIndex = 0
    self._requestTime = 0 --请求后时间累积  用于处理超时
    self:refreshActivityData()
    --刷新文本
    -- self.remainUseCount = nil
    -- self.remainRefreshTime = nil
    -- self.useItemIcon = nil
    -- self.useItemNumber = nil
    Avalon.Scheduler:scheduleUpdate(self, self.update)

    self.lastCheckNumber = 0--用于检测撞帧
    -- self:enableDebugDraw()
end

--虚构函数,destroy时调用(必备)
function LuckDropLayer:dtor()
    LuckDropLayer.super.dtor(self)
    self:unRegisterListener();

    self._distance = 0
    self._curSpeed = 0
    self._rotateTime = 0
    self.lastDistance = nil
    -- 触摸相关参数
    self.touchPoints = {} --一次滑动所有的触发点

    self.bingoId = 0
    self.lastPlayAudioIndex = -1
    self.nodeCahe = {}
    self.bingoItems = {}
    self._showIndex = 0
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    EquipIllusionDataManager:setDelayNoticeOn(false)
end

-- 初始化(必备)
function LuckDropLayer:init()
    LuckDropLayer.super.init(self)
    if GameDataManager:getInstance():isOutForTurnTableData() then
        GameManager:reqTurnTableInfo()
    end
end

function LuckDropLayer:refreshActivityData()
    local oldActivity = self._activityData
    self._activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyWheel)
    if oldActivity and self._activityData == nil then
        GameManager:reqTurnTableInfo()
    end
    self.drops = nil
    if(self._activityData and self._activityData:isInEffect()) then
        local luckyData = self._activityData:getLuckyWheelData()
        if(luckyData and luckyData:getLuckWheelDataArr()) then
            self.drops = luckyData:getLuckWheelDataArr()
        end
    end

end

function LuckDropLayer:update(dt)
    self:refreshTime(dt)
    if not self:isRunning() then
        return
    end
    if self.isInBackGround then
        print("it is in backGround")
        return
    end
    local curFps =  60
    if dt > 0 then
        curFps = 1 / dt
    end
    if self.turnTableState == TURN_TABLE_STATE.BEGIN then
        self._requestTime = 0
        self.turnTableState = TURN_TABLE_STATE.ACCELERATE
        DISTANCE_SAPCE = math.random(10, 30)
    elseif self.turnTableState == TURN_TABLE_STATE.ACCELERATE then
        self._curSpeed = self._maxSpeed * self.direction / 60
        self.turnTableState = TURN_TABLE_STATE.CHECK
    elseif self.turnTableState == TURN_TABLE_STATE.CHECK and self.bingoId > 0 then
        local initDis = self._curSpeed * self._curSpeed / (2 * DECELERATED_SPEED / curFps)
        local remainDis = (initDis * self.direction + self._distance + self._curSpeed) % 360 
    
        local randomAngle = math.random(5, 360 / TOTAL_ITEM_SIZE / 4)
        if math.floor(randomAngle) % 2 == 1 then
            randomAngle = 360 / TOTAL_ITEM_SIZE - randomAngle
        end
        if self.direction == 1 then
            local targetAngle = 360 - (360 / TOTAL_ITEM_SIZE * self.bingoId - randomAngle)
            local addNum = targetAngle > remainDis and (targetAngle - remainDis) or (360 + targetAngle - remainDis)
            initDis = initDis + addNum
        else
            local targetAngle = 360 - (360 / TOTAL_ITEM_SIZE * self.bingoId - randomAngle)
            local addNum = targetAngle > remainDis and (360 - (targetAngle - remainDis)) or (remainDis - targetAngle)
            initDis = initDis + addNum
        end
        self._realDecele = self._curSpeed * self._curSpeed / (2 * initDis)
        self.turnTableState = TURN_TABLE_STATE.DECELERATE
        self._targetDistance = initDis * self.direction + self._distance + self._curSpeed
    elseif self.turnTableState == TURN_TABLE_STATE.DECELERATE then
        oldSpeed = self._curSpeed
        local okCallback = function()
            self.turnTableState = TURN_TABLE_STATE.ADJUST
        end
        --第一次调整目标  速度达到 6 以内， 路程达到360 到 720以内
        self:gotoTarget(6, 360, 720, 360, okCallback)
        self._curSpeed = self._curSpeed - self._realDecele * self.direction

        if self._curSpeed * oldSpeed <= 0 then--防止掉帧引起的反转
            self._curSpeed = oldSpeed
        end
        if false then
            local distanceNumber = math.abs(self._targetDistance - self._distance)
        end
    elseif self.turnTableState == TURN_TABLE_STATE.ADJUST then
        local distanceNumber = math.abs(self._targetDistance - self._distance)
        oldSpeed = self._curSpeed
        local distanceNumber = math.abs(self._targetDistance - self._distance) 
        if self._curSpeed > -1 * CHECK_SPEED and self._curSpeed < CHECK_SPEED then
        
        elseif distanceNumber < DISTANCE_SAPCE + 10 then
            self._realDecele = self._curSpeed * self._curSpeed / (2 * distanceNumber)
            self._curSpeed = self._curSpeed - self._realDecele * self.direction
        else
            self._realDecele = self._curSpeed * self._curSpeed / (2 * (distanceNumber - DISTANCE_SAPCE))
            self._curSpeed = self._curSpeed - self._realDecele * self.direction
        end

        if self._curSpeed * oldSpeed <= 0 then--防止掉帧引起的反转
            self._curSpeed = oldSpeed
        end
        if (self._targetDistance - (self._distance - self._curSpeed)) * (self._targetDistance - self._distance) <= 0 then
            self._distance = self._distance + self._curSpeed
            self._curSpeed = 0
            self._realDecele = 0
            self.curDecelSpeed = 0
            self.turnTableState = TURN_TABLE_STATE.END
            self:showRewardAction()
            self:refreshInfoView(true)
            self.lastPlayAudioIndex = -1
            self.bingoId = 0
            self._requestTime = 0
            self.currentLayout:endCacheMode()
            EquipIllusionDataManager:setDelayNoticeOn(false)
        end
    elseif self.turnTableState == TURN_TABLE_STATE.END then
       
    end
    if self.turnTableState ~= TURN_TABLE_STATE.END then
        self._requestTime = self._requestTime + dt
        if self._requestTime > TimeOutLimte and self.bingoId == 0 then
            self:requestTimeOut()
        end
    end
    self._distance = self._distance + self._curSpeed
    self:PlayRateActionAndMusic(self._distance, dt, self._curSpeed)
end

function LuckDropLayer:requestTimeOut()
    self.turnTableState = TURN_TABLE_STATE.END
    self._distance = self._distance + self._curSpeed
    self._curSpeed = 0
    self._realDecele = 0
    self.curDecelSpeed = 0
    self.turnTableState = TURN_TABLE_STATE.END
    self.lastPlayAudioIndex = -1
    self.bingoId = 0
    self._requestTime = 0
    self:refreshInfoView(true)
    UI.ScrollBar:createByText(UI.TEXT_1212028)
end

--[[ 通过补偿圈数  把速度和距离控制在期望范围内
curFps ： 当前贞率
speedTarget ： 目标速度
downDisTarget：下限距离
upDisTarget：上限距离,
disAdd：补偿的距离 
okCallback：成功回调 
failCallback：失败回调
]]
function LuckDropLayer:gotoTarget(speedTarget, downDisTarget, upDisTarget, disAdd, okCallback, failCallback)
    -- print("---------LuckDropLayer:gotoTarget", distanceNumber, curFps, speedTarget, downDisTarget, upDisTarget, disAdd)
    local distanceNumber = math.abs(self._targetDistance - self._distance)
    if (self._curSpeed < speedTarget and self._curSpeed > -speedTarget) and (distanceNumber < upDisTarget and distanceNumber > downDisTarget) then--防止掉帧引起的反转
        okCallback()
    elseif (self._curSpeed < speedTarget and self._curSpeed > -speedTarget) or (distanceNumber < upDisTarget and distanceNumber > downDisTarget) then
        if not (self._curSpeed < speedTarget and self._curSpeed > -speedTarget) then --不满足速度 延长距离 稀释速度
             if distanceNumber < upDisTarget then -- 加一圈
                local newTarget = distanceNumber + disAdd
                self._realDecele = self._curSpeed * self._curSpeed / (2 * newTarget)
                self._targetDistance = self._targetDistance + disAdd * self.direction
                distanceNumber = distanceNumber + disAdd
            elseif distanceNumber > downDisTarget then -- 减一圈
                local newTarget = distanceNumber - disAdd
                self._realDecele = self._curSpeed * self._curSpeed / (2 * newTarget)
                self._targetDistance =  self._targetDistance - disAdd * self.direction
                distanceNumber = distanceNumber - disAdd
            end
        else--不满足距离
            if distanceNumber < downDisTarget then -- 加一圈
                local newTarget = distanceNumber + disAdd
                self._realDecele = self._curSpeed * self._curSpeed / (2 * newTarget)
                self._targetDistance = self._targetDistance + disAdd * self.direction
                distanceNumber = distanceNumber + disAdd
            elseif distanceNumber > upDisTarget then
                local newTarget = distanceNumber - disAdd
                self._realDecele = self._curSpeed * self._curSpeed / (2 * newTarget)
                self._targetDistance = self._targetDistance - disAdd * self.direction
                distanceNumber = distanceNumber - disAdd
            end
        end
        -- print("-----self._targetDistance -------self._distance-----------", self._targetDistance, self._distance)
    end
end

function LuckDropLayer:PlayRateActionAndMusic(distance, dt, speed)
    if self.turnTable ~= nil then
        self.turnTable:rotate(distance)
        self.gearLU1:rotate(distance * -1)
        self.gearLU2:rotate(distance * 1.25)
        self.gearRU:rotate(distance * -1)
        self.gearLD:rotate(distance / 4)
        self.gearRD:rotate(distance / 8 * -1)
        self.chainPanelL:move(speed / 10)
        self.chainPanelR:move(speed / -10)

        local curAngle = distance % (360 / TOTAL_ITEM_SIZE)
        local target = distance - curAngle 
        if distance > 0 and curAngle > 360 / TOTAL_ITEM_SIZE / 2 then
            target = target + 360 / TOTAL_ITEM_SIZE
        elseif distance < 0 and curAngle > 360 / TOTAL_ITEM_SIZE / 2 then
            target = target + 360 / TOTAL_ITEM_SIZE
        end
        distance = distance + self.direction * 4
        local curCheckNumber = math.abs(self._curSpeed)
        local checkNumber = self.lastCheckNumber > curCheckNumber and self.lastCheckNumber or curCheckNumber
        checkNumber = checkNumber
        -- print("distance="..distance.." target = "..target.." and direction = "..self.direction.." and check = "..checkNumber)
        -- print("math.abs(target - curAngle) = "..math.abs(target - curAngle).." and checkNumber = "..math.abs(checkNumber) / 2)
        if math.abs(target - distance) <= checkNumber / 2 or (self.lastDistance ~= nil and math.abs(target - self.lastDistance) <= checkNumber)then
        	local curPlayAudioIndex = math.abs(target / (360 / TOTAL_ITEM_SIZE))
            -- print("--------- curPlayAudioIndex = "..curPlayAudioIndex)
        	if self.lastPlayAudioIndex ~= curPlayAudioIndex then
                Avalon.AudioManager:playSound("1507")
                self.lastPlayAudioIndex = curPlayAudioIndex
                self.pointer:stopAllActions()
                local pointActionTime, angle = self:getPointActionTImeBySpeed(self._curSpeed)--(1 - self._curSpeed / 40) / 3--self.pointActionTime == 0 and 0.3 or self.pointActionTime
                -- print("self.pointActionTime  = "..pointActionTime)
                local sequence = cc.Sequence:create(cc.RotateTo:create(pointActionTime, - angle * self.direction), cc.RotateTo:create(pointActionTime, 0), cc.CallFunc:create(function()
                   self.lastPlayAudioIndex = -1
                end))
                self.pointer:runAction(sequence)
            end
            self.lastDistance = nil
        else
            self.lastDistance = distance
        end
        self.lastCheckNumber = curCheckNumber
    end
end


-- 模版函数：初始化组建的视图(必备)
function LuckDropLayer:onInitView()
    -- print("----------LuckDropLayer:onInitView()")
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width,winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)

    self.leftLayer = UI.Layout:create()--cc.LayerColor:create(cc.c4b(0,0,0,255))
    self.leftLayer:init()
    self.leftLayer:leftBottom(20, winSize.height)
    self.leftLayer:setSize(518,632)
    self.rootLayer:addChild(self.leftLayer,2)
    -- self.leftLayer:enableDebugDraw(UI.RED)
    
    local bg = UI.Image:create()
    bg:init("ui_luckdraw_bg.png")
    bg:center()
    self.leftLayer:addChild(bg, 2)
   
    --齿轮层
    local gearLU1 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun1.png")
    self.leftLayer:addChild(gearLU1, 5)
    gearLU1:setPosition(111,568)
    self:creatBackSprite(gearLU1, "ui_luckdraw_chilun1.png")

    local nailLU1 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun1_1.png")
    self.leftLayer:addChild(nailLU1, 5)
    nailLU1:setPosition(111,570)
    self:creatBackSprite(nailLU1, "ui_luckdraw_chilun1_1.png")

    local gearLU2 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun2.png")
    self.leftLayer:addChild(gearLU2, 5)
    gearLU2:setPosition(50,506)
    self:creatBackSprite(gearLU2, "ui_luckdraw_chilun2.png")

    local gearRU = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun5.png")
    self.leftLayer:addChild(gearRU, 1)
    gearRU:setPosition(310,574)
    self:creatBackSprite(gearRU, "ui_luckdraw_chilun5.png")

    local gearLD = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun3.png")
    self.leftLayer:addChild(gearLD, 5)
    gearLD:setPosition(94,201)
    self:creatBackSprite(gearLD, "ui_luckdraw_chilun3.png")

    local gearRD = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_chilun4.png")
    self.leftLayer:addChild(gearRD, 5)
    gearRD:setPosition(455,216)
    self:creatBackSprite(gearRD, "ui_luckdraw_chilun4.png")
    ---
    local rotaryTableBg1 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_wood_shadow2.png")
    rotaryTableBg1:setAnchorPoint(0,0)
    self.leftLayer:addChild(rotaryTableBg1, 10)
    rotaryTableBg1:setPosition(11,100)
     
    self.gearLU1 = gearLU1
    self.gearLU2 = gearLU2
    self.gearRU = gearRU
    self.gearLD = gearLD
    self.gearRD = gearRD

     ----链条

    local chainPanelL = UI.MoveChain:create("ui_luckdraw_shuolian.png", 150)
    self.leftLayer:addChild(chainPanelL, 11)
    chainPanelL:leftBottom(85, 111)
    chainPanelL:setAnchorPoint(0, 0)
    chainPanelL:rotate(340)
    self.chainPanelL = chainPanelL

    local chainPanelR = UI.MoveChain:create("ui_luckdraw_shuolian.png", 150)
    self.leftLayer:addChild(chainPanelR, 11)
    chainPanelR:leftBottom(405, 111)
    chainPanelR:setAnchorPoint(0, 0)
    chainPanelR:rotate(18)
    self.chainPanelR = chainPanelR

     ---
    local rotaryTableBg2 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_wood_shadow1.png")
    self.leftLayer:addChild(rotaryTableBg2, 15)
    rotaryTableBg2:setPosition(35, 111)
    rotaryTableBg2:setAnchorPoint(0, 0)
    
    local rotaryTableBg3 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_wood.png")
    self.leftLayer:addChild(rotaryTableBg3, 15)
    rotaryTableBg3:setPosition(11, 111)
    rotaryTableBg3:setAnchorPoint(0, 0)
    self:creatBackSprite(rotaryTableBg3, "ui_luckdraw_wood.png")

    local rotaryTableBg3 = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_wood.png")
    self.leftLayer:addChild(rotaryTableBg3, 15)
    rotaryTableBg3:setPosition(11, 111)
    rotaryTableBg3:setAnchorPoint(0, 0)
    self:creatBackSprite(rotaryTableBg3, "ui_luckdraw_wood.png")


    self.turnTable = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_zhuan.png")
    self.leftLayer:addChild(self.turnTable, 15)
    self.turnTable:setPosition(258, 358)
    self:creatBackSprite(self.turnTable, "ui_luckdraw_zhuan.png", 10)
    -- self.turnTable:getTexture():setAntiAliasTexParameters();

    -- 木钉子
    local fixedNail = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_yuan2.png")
    self.leftLayer:addChild(fixedNail, 15)
    fixedNail:setPosition(258, 358)  
    self:creatBackSprite(fixedNail, "ui_luckdraw_yuan2.png")
    -- fixedNail:getTexture():setAntiAliasTexParameters();

    local rotateNail = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_yuan1.png")
    self.turnTable:addChild(rotateNail)
    rotateNail:setPosition(self.turnTable:getContentSize().width / 2, self.turnTable:getContentSize().height / 2)
    self:creatBackSprite(rotateNail, "ui_luckdraw_yuan1.png")
    -- rotateNail:getTexture():setAntiAliasTexParameters();

    --指针
    self.pointer = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_zhizhen.png")
    self.leftLayer:addChild(self.pointer, 15)
    self.pointer:setPosition(259, 590)
    self.pointer:setAnchorPoint(0.5, 0.72)
    self:creatBackSprite(self.pointer, "ui_luckdraw_zhizhen.png")
    
    local pointerNail = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_dingzi.png")
    self.leftLayer:addChild(pointerNail, 15)
    pointerNail:setPosition(259, 594)
    self:creatBackSprite(pointerNail, "ui_luckdraw_dingzi.png")
  
    local rightBg = cc.Sprite:createWithSpriteFrameName("ui_luckdraw_yellow.png")
    self.leftLayer:addChild(rightBg, 15)
    rightBg:setPosition(395,560)
    rightBg:rotate(34)
    -- self:creatBackSprite(rightBg, "ui_luckdraw_yellow.png", 10)


    self.remainUseCount = UI.Text:create()
    self.remainUseCount:init("aaaaaa",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    rightBg:addChild(self.remainUseCount)
    self.remainUseCount:centerBottom(33)

    local clockIcon =  UI.Image:create()
    clockIcon:init("ui_information_clock_bg.png")
    clockIcon:centerLeft(60)
    rightBg:addChild(clockIcon)
    clockIcon:setName("clockIcon")
            
    local clockPoint = cc.Sprite:create()
    clockPoint:initWithSpriteFrameName("ui_information_clock_point.png")
    clockPoint:setAnchorPoint(0.3, 0.3)
    clockPoint:setPosition(clockIcon:getContentSize().width / 2, clockIcon:getContentSize().height / 2 + 1)
    clockIcon:addChild(clockPoint)
    self.clockIcon = clockIcon

    local ralateAction = cc.RotateBy:create(60, 360)
    local endAction = cc.RepeatForever:create(ralateAction)
    clockPoint:runAction(endAction)

    self.remainRefreshTime = UI.Text:create()
    self.remainRefreshTime:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_50_50_44)
    rightBg:addChild(self.remainRefreshTime, 10)
    self.remainRefreshTime:centerBottom(15)
    
    local moneyBg = UI.Image:create()
    moneyBg:init("ui_luckdraw_board.png")
    moneyBg:leftBottom(69, 85)
    self.leftLayer:addChild(moneyBg,15)
    -- self:creatBackSprite(moneyBg, "ui_luckdraw_board.png", 10)

    require("app.ui.common.CurrencyPanel")
    local currentLayout = UI.CurrencyPanel:create()
    currentLayout:centerUp(1.5)
    currentLayout:setParentWin(self)
    moneyBg:addChild(currentLayout)
    self.currentLayout = currentLayout

    self.mBtnBuy = UI.Button:create()
    self.mBtnBuy:init("ui_btn_stone1_0.png","ui_btn_stone1_1.png","ui_btn_stone1_2.png")
    self.mBtnBuy:leftBottom(127, 35)
    self.mBtnBuy:addEventListener(UIEvent.BUTTON_CLICK,self,self.onBuyClick)
    self.leftLayer:addChild(self.mBtnBuy, 20)
    self.mBtnBuy:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.buttonDisableClicked)

-- self.mBtnBuy:enableDebugDraw(UI.RED)
    local btnTips = UI.Text:create()
    btnTips:init(UI.TEXT_1170103,UI.FONT_BOLD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_220_182_80)
    self.mBtnBuy:addChild(btnTips, 100)
    btnTips:centerLeft(30)
    self.btnTips = btnTips
    AvalonUtil.addBracketsAnimationToButton(self.mBtnBuy)
    -- btnTips:enableDebugDraw()

    self.useItemIcon = UI.Image:create()
    self.useItemIcon:init("symbol_gaming_diamond.png")
    self.mBtnBuy:addChild(self.useItemIcon, 100)
    self.useItemIcon:centerLeft(156)

    self.useItemNumber = UI.Text:create()
    self.useItemNumber:init("",UI.FONT_BOLD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_220_182_80)
    self.mBtnBuy:addChild(self.useItemNumber, 120)
    self.useItemNumber:leftBottom(180, 7)

    self:initItem(self.turnTable)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBegan)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onTouchMove)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTouchEnded)

    self:setCloseStartCallBack(handler(self, self.beforCloseEvent))
    -- self:enableDebugDraw()
end 

function LuckDropLayer:refreshAdsStatus()
    self.btnTips:setText(UI.TEXT_1170103)
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
    if adsData and adsData.isOpen and (adsData.gotNum < adsData.maxNum) then
        if self.adsBtn == nil then
            local button = AvalonUtil.createPlayAdsButton(function()
                local orderId = AvalonUtil.getCurrentTime()
                GameManager:sendAdsLog(PublicDefine.AdsPlaceId.TurnTableLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel, orderId, 5)
                local maxTime = adsData == nil and 0 or adsData.maxNum
                local textList =  {UI.TEXT_1212423, string.format(UI.TEXT_1212424, maxTime or 0)}
                UI.ConfirmDialog.showConfirmDialogCancelRedOkWhiteAndTexts(textList, function(isSelect)
                    GameManager:sendAdsLog(PublicDefine.AdsPlaceId.TurnTableLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel, orderId, 6)
                    GameManager:playAds(PublicDefine.AdsPlaceId.TurnTableLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel, orderId)
                end, function(isSelect)
                    GameManager:sendAdsLog(PublicDefine.AdsPlaceId.TurnTableLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel, orderId, 7)
                end, nil, nil, false)
            end, UI.TEXT_1212932)
            self.leftLayer:addChild(button, 20)
            button:rightUp(-22, 495)
            self.adsBtn = button
        else
            self.adsBtn:show()
        end
        if adsData and (adsData.gotNum > adsData.usedNum) then
            self.useItemIcon:useShader(UI.COMPONENT_NORMAL_SHADER)
            self.btnTips:setFontColor(UI.FONT_COLOR_220_182_80)   
            self.btnTips:setText(UI.TEXT_1172032)
            self.btnTips:center()
            self.useItemNumber:setVisible(false)
            self.useItemIcon:setVisible(false)
            self.mBtnBuy:disable()
            for i = 1, #self.blackSprites do
                self.blackSprites[i]:hide()
            end
            self.turnTableState = TURN_TABLE_STATE.END
        end
        GameManager:loadAds(PublicDefine.AdsPlaceId.TurnTableLuckDrop, PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
    else
        if self.adsBtn then
            self.adsBtn:hide()
        end
        if adsData and adsData.isOpen and (adsData.gotNum <= adsData.maxNum) and (adsData.gotNum > adsData.usedNum) then
            self.useItemIcon:useShader(UI.COMPONENT_NORMAL_SHADER)
            self.btnTips:setFontColor(UI.FONT_COLOR_220_182_80)   
            self.btnTips:setText(UI.TEXT_1172032)
            self.btnTips:center()
            self.useItemNumber:setVisible(false)
            self.useItemIcon:setVisible(false)
            self.mBtnBuy:disable()
            for i = 1, #self.blackSprites do
                self.blackSprites[i]:hide()
            end
            self.turnTableState = TURN_TABLE_STATE.END
        end
    end
end

function LuckDropLayer:creatBackSprite(realSprite, backSpritePng, zorder)
    zorder = zorder or 1
    local backSprite = cc.Sprite:createWithSpriteFrameName(backSpritePng)
    realSprite:addChild(backSprite, zorder)
    backSprite:setPosition(realSprite:getContentSize().width / 2,realSprite:getContentSize().height / 2)
    AvalonUtil.useColorShader(backSprite, cc.vec4(20/255, 16/255, 20/255, 0.36))
    self.blackSprites = self.blackSprites or {}
    table.insert(self.blackSprites, backSprite)
end

-- 模版函数：更新组建的视图(必备)
function LuckDropLayer:onUpdateView()
    -- print("----------LuckDropLayer:onUpdateView()")
    self:setDoorNode(self.leftLayer)

    self:refreshActivityData()
    self:refreshDropItemView()
    self:refreshInfoView(true)
    self._distance =  self._distance +  360 / TOTAL_ITEM_SIZE / 2
    self:PlayRateActionAndMusic( self._distance, 0, 0)
end

function LuckDropLayer:onTouchBegan(grid,touchPosition)
    self.touchPoints = {}
    -- print("LuckDropLayer:onTouchBegan")
    if self.rewardLayer ~= nil then
        -- if self.rewardLayer:checkTouchPosition(touchPosition) and self.goodGrid then
            -- self.goodsGridInfo = self.goodGrid:onShowInfoAreaHandler(false)
            -- self.goodsGridInfo:centerLeft(415)
        if self.framentbgSpineDown == nil then
            self.rewardLayer:removeSelf()
            self.rewardLayer = nil
            self.goodGrid = nil
        else
          --end 动画
            local level = self.framentbgSpineDown:getTag()
            local idleDownAnimName = string.format("end%d_down", level)
            local idleUpAnimName = string.format("end%d_up", level)
            self.framentbgSpineDown:setAnimation(idleDownAnimName, false)
            self.framentbgSpineUp:setAnimation(idleUpAnimName, false)
        end
        return
    end
    if self:isRunning() then
        return
    end
    self.beginTouchPosition = touchPosition
    for k, value in ipairs(self.bingoItems) do
        if value ~= nil and not tolua.isnull(value) and value:checkTouchPosition(touchPosition) then
            self._showIndex = k
            break
        end
    end
-- self:trigerOverAndPlay()
    self:addTouchPoint(touchPosition)
end

function LuckDropLayer:onTouchEnded(grid,touchPosition)
    -- print("LuckDropLayer:onTouchEnded self._showIndex  = "..self._showIndex )
    if self:isRunning() then
        return
    end

    if self.rewardLayer ~= nil then
        if self.rewardLayer:checkTouchPosition(touchPosition) and self.goodsGridInfo and not tolua.isnull(self.goodsGridInfo) then
            self.goodsGridInfo:removeFromParent(true)
            self.goodsGridInfo = nil
        end
        return
    end

    if AvalonUtil:isSensitiveTouch(self.beginTouchPosition, touchPosition) then
        for k, value in ipairs(self.bingoItems) do
            if  value ~= nil and not tolua.isnull(value) and value:checkTouchPosition(touchPosition) and self._showIndex == k then
                self._showIndex = 0
                local goodData = value:getData()
                if  goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
                    -- 虚拟物品详情界面
                    if(goodData:getCanBeView()) then 
                        local pInfoArea = UI.PropInfoArea:create(true)
                        pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
                        local x,y = goodGrid:getPosition()
                        local worldPos = goodGrid:convertToWorldSpace(cc.p(x,0))
                        pInfoArea:centerLeft(worldPos.x + goodGrid:getSize()+ 20)

                        pInfoArea:setVisible(true)
                        pInfoArea:updateView(goodData)
                        pInfoArea:setHideLink(true)
                        pInfoArea:closeLockFlag()
                        pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self,obj,touchPosition)
                            self._virtualItemInfo = nil
                            pInfoArea:close();
                        end)

                        self._virtualItemInfo = pInfoArea
                        UI.UIManager:addToRootNode(pInfoArea,UI_ZORDER.EQUIPMENTINFO)
                    end
                else   
                    value:onShowInfoAreaHandler(true)
                end
                break
            end
        end
        return
    end 

    if #self.touchPoints < 2 then
        return
    end
    if self:judgeToUse() == false then
        return
    end
    self:trigerOverAndPlay()
    self.touchPoints = {}
end

function LuckDropLayer:judgeToUse()
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
    if adsData and adsData.isOpen and adsData.gotNum > adsData.usedNum and (adsData.usedNum < adsData.maxNum) then
        return true
    end
    if(self._activityData) then
        if self._activityData:getLuckyWheelData():judgeToUse() == false then
            return false
        end
    else 
        local turnTableData = GameDataManager:getInstance():getTurnTableData()
        if turnTableData.leftTurnNum <= 0 then
            return false
        end
    end 

    return true
end

function LuckDropLayer:onTouchMove(grid,touchPosition)
    -- print("LuckDropLayer:onTouchMove")
    if self:isRunning() then
        return
    end

    if self.rewardLayer ~= nil then
        return
    end

    touchPosition = self:addTouchPoint(touchPosition)
    if #self.touchPoints < 2 then
        return
    end

    if self:judgeToUse() == false then
        return
    end

    local oldCompareAngle = self.touchPoints[#self.touchPoints - 1].angle
    local nowCompareAngle = touchPosition.angle 
    if  oldCompareAngle * nowCompareAngle >= 0 then
        if nowCompareAngle > oldCompareAngle then
            self.direction = 1
        else
            self.direction = -1
        end
    else
       if math.abs(nowCompareAngle) < 90 then
            if nowCompareAngle - oldCompareAngle >= 0 then
                self.direction = 1
            else
                self.direction = -1
            end
       else
           if nowCompareAngle - oldCompareAngle >= 0 then
                self.direction = -1
            else
                self.direction = 1
            end
       end
    end
    
    local speed = touchPosition.angle - self.touchPoints[#self.touchPoints - 1].angle
    self._curSpeed = speed < 0 and (speed + 360) or speed

    if self._curSpeed > 300 then
        self._curSpeed = 360 - self._curSpeed
    end
    self._curSpeed = self._curSpeed * self.direction
    self._distance = self._distance + self._curSpeed
    -- print("touch move : self._distance = "..self._distance.." and self._curSpeed = "..self._curSpeed)
    self.turnTable:rotate(self._distance)
    self:PlayRateActionAndMusic(self._distance, 0, self._curSpeed)
end

--[[ 滑动结束 根据滑动屏幕的速度 决定初始加速度
     取得最后顺时针针滑动的点 且不大于十个 
]]
function LuckDropLayer:trigerOverAndPlay()
    -- print("----------------- LuckDropLayer:trigerOverAndPlay ")
	local validTouchPoints, dis = self:judgeDirection()
    local trigerSpeed = 0
    if #self.touchPoints >= 2 then
    	local beginTouchPoint = validTouchPoints[#validTouchPoints]
    	local endTouchPoint = validTouchPoints[1]
        local disX = endTouchPoint.x - beginTouchPoint.x
        local disY = endTouchPoint.y - beginTouchPoint.y
        if endTouchPoint.time ~= beginTouchPoint.time then
            trigerSpeed = math.sqrt(disX * disX + disY * disY) / (endTouchPoint.time - beginTouchPoint.time)
        else
            trigerSpeed = math.sqrt(disX * disX + disY * disY) / 1
        end
    end

    -- print("LuckDropLayer:trigerOverAndPlay    trigerSpeed = "..trigerSpeed)
    self._maxSpeed = 0
    for k,v in pairs(MAX_SPEED_MODEL) do
        if trigerSpeed >= v.floorLimit and trigerSpeed < v.upLimite then
            local speedScale = 1
            dis = math.abs(dis)
            if dis < 100 then
                speedScale = dis / 100
            end
            self._maxSpeed = v.maxSpeed * speedScale
            -- print("----self._maxSpeed--- = "..self._maxSpeed)
            self._rotateTime = 0
            break
        end
    end 
    if self._maxSpeed * self._maxSpeed / (2 * DECELERATED_SPEED ) < 720 then
        validTouchPoints = {}
        self.touchPoints = {}
        -- print("----too slow and --- self._maxSpeed = "..self._maxSpeed)
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111389))
        return 
    end
    local isCanTriger = self:onTrigerClick()
    -- print("LuckDropLayer:trigerOverAndPlay    isCanTriger = ", isCanTriger)
    validTouchPoints = {}
    self.touchPoints = {}
    if not isCanTriger then
       return
    end
    self.turnTableState = TURN_TABLE_STATE.BEGIN

    -- self.bingoId = math.random(1,TOTAL_ITEM_SIZE)
    -- print("----------------bingoId = " .. self.bingoId)
end

function LuckDropLayer:judgeDirection()
    --只取最后两个象限的点
    local areaTouchPoints = {}
    local areaList = {}
    for k, v in ipairs(self.touchPoints) do
        local have = false
        for k2, v2 in ipairs(areaList) do
            if v.area == v2 then
                have = true
            end
        end
        local size = #areaList
        if size >= 2 and not have then
            break
        elseif not have then
            table.insert(areaList, v.area)
        end
        table.insert(areaTouchPoints, v)
    end
    
    if #areaList == 2 and areaList[1] * areaList[2] == QUADRANT_AREA.AREA_3 * QUADRANT_AREA.AREA_4 then
        for k, v in ipairs(areaTouchPoints) do
            if v.area == QUADRANT_AREA.AREA_3  then
                v.angle = v.angle + 360
            end
        end
    end

    local size = #areaTouchPoints
    -- print("-----------------LuckDropLayer:judgeDirection---------------size = -"..size)
    -- dump(areaTouchPoints)
    local flagPoint = areaTouchPoints[size]
    local positiveDirectionPoints = {}
    local count = 0
    for i = size, 1, -1 do
        count = count + 1
        if count > VALID_TOUCH_POINT_LIMIT  then
            break;
        end
        local curTouchPoint = areaTouchPoints[i]
        if curTouchPoint.angle <= flagPoint.angle then
            table.insert(positiveDirectionPoints, curTouchPoint)
            flagPoint = curTouchPoint
        end
    end
    
    local reverseDirectionPoints = {}
    count = 0
    for i = size, 1, -1 do
        count = count + 1
        if count > VALID_TOUCH_POINT_LIMIT then
            break;
        end
        local curTouchPoint = areaTouchPoints[i]
        if  curTouchPoint.angle >= flagPoint.angle then
            table.insert(reverseDirectionPoints, curTouchPoint)
            flagPoint = curTouchPoint
        end
    end
   -- dump(positiveDirectionPoints, "---positiveDirectionPoints--")
   -- dump(reverseDirectionPoints, "---reverseDirectionPoints--")
    if #positiveDirectionPoints >= #reverseDirectionPoints then
        self.direction = 1
        return positiveDirectionPoints, self.touchPoints[#self.touchPoints].angle - self.touchPoints[1].angle 
    else
        self.direction = -1
        return reverseDirectionPoints, self.touchPoints[#self.touchPoints].angle - self.touchPoints[1].angle 
    end
end

function LuckDropLayer:addTouchPoint(touchPosition)
    local pos = self.turnTable:convertToWorldSpace(cc.p(self.turnTable:getContentSize().width / 2, self.turnTable:getContentSize().height / 2))
    touchPosition.angle,  touchPosition.area = AvalonUtil:pointToAngle(pos, touchPosition)
    touchPosition.time = os.time()
    table.insert(self.touchPoints, touchPosition)
    return touchPosition
end


function LuckDropLayer:beforCloseEvent(tips, touchPosition)
    if self.rewardLayer ~= nil then
        self.rewardLayer:removeSelf()
        self.rewardLayer = nil
        self.goodGrid = nil
        self.framentbgSpineDown = nil
        self.framentbgSpineUp = nil
        if self.delayRefresh then
            self.delayRefresh = false
            self:refreshDropItemView()
            self:refreshInfoView(true)
        end

        -- 第一次拿到奖励过后, 弹出推送授权申请
        require("app.utils.PushUtil")
        if (not PushUtil:isAuthenticated()) then
            PushUtil:requestNotiAuthWithLotteryDialog()
        end
        return false
    end
    if self:isRunning() then
        return false
    end
end

function LuckDropLayer:activityRefresh()
    self:refreshActivityData()
    if self.turnTableState ~= TURN_TABLE_STATE.END then
        self.delayRefresh = true
    else
        self:refreshDropItemView()
        self:refreshInfoView(true)
    end
end
-- 刷新钻石显示
function LuckDropLayer:onCurrencyChangeHandler()
    self:refreshInfoView(false)
end
-- 注册监听事件(可选)
function LuckDropLayer:registerListener()
    --监听窗口外关闭事件
    -- -- 结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshInfoView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TRIGER_TURNTABLE, self, self.trigerCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_LUCKDROP_REFRESH, self, self.getInfoCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityRefresh)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GAME_ENTER_BACKGROUND, self, function()
        self.isInBackGround = true
        -- print("it is _ENTER_BACKGROUND in LuckDropLayer")
    end)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GAME_ENTER_PROGROUND, self, function()
         Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            self.isInBackGround = false
        end, 1)
        -- self.isInBackGround = false
        -- print("it is _ENTER_pro    GROUND in LuckDropLayer")
    end)
end


-- 注销监听事件(可选)
function LuckDropLayer:unRegisterListener()
    --结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS, self, self.refreshInfoView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TRIGER_TURNTABLE, self, self.trigerCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_LUCKDROP_REFRESH, self, self.getInfoCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.activityRefresh)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:unbindForName(AvalonMessage.MC_GAME_ENTER_BACKGROUND)
    Avalon.MessageCenter:unbindForName(AvalonMessage.MC_GAME_ENTER_PROGROUN)
end

--道具显示 
function LuckDropLayer:initItem(parentNode, dropItemList)
    local isTest = true
    if dropItemList ~= nil then
        isTest = false
    end
    local size = 8
    for i = 1, size do
        local _node = cc.Node:create();
        _node:init()
        local _text = UI.Text:create()
        _text:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        _node:addChild(_text)
        _text:centerUp(40)
        _text:setText(i)
        _text:setName("TEXT")

        parentNode:addChild(_node)
        local _origin = {x = self.turnTable:getContentSize().width / 2, y = self.turnTable:getContentSize().height / 2}
        local _rotateAngle = 360 / size * (i - 1) + 360 / size / 2
        local _pos = AvalonUtil:angleToPoint(_origin, _rotateAngle, 154)
        _node:rotate(_rotateAngle)
        _node:setPosition(_pos)
        self.nodeCahe = self.nodeCahe or {}
        table.insert(self.nodeCahe, _node)
        -- print("------- i ="..i.."   and --------_rotateAngle = ".._rotateAngle.."  and postion = ".._pos.x .. " / ".._pos.y)
    end
end

function LuckDropLayer:buttonDisableClicked(sender)
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
    if adsData and adsData.isOpen and adsData.gotNum > adsData.usedNum and (adsData.usedNum < adsData.maxNum) then
        UI.ScrollBar:createByText(UI.TEXT_1172013)
        return
    end
    local turnTableData = GameDataManager:getInstance():getTurnTableData()
    if turnTableData.leftTurnNum <= 0 and self.turnTableState == TURN_TABLE_STATE.END then
        UI.ScrollBar:createByText(UI.TEXT_1170105)
        return 
    end
end

function LuckDropLayer:onBuyClick(sender)
    Avalon.AudioManager:playSound("1503")
    --todo 条件判断 1、购买上限 2、购买货币是否足够 
    -- print("------------LuckDropLayer:onBuyClick()")
    if self.rewardLayer ~= nil then
        if self.framentbgSpineDown == nil then
            self.rewardLayer:removeSelf()
            self.rewardLayer = nil
            self.goodGrid = nil
            self.framentbgSpineDown = nil
            self.framentbgSpineUp = nil
        else
            --end 动画
            local level = self.framentbgSpineDown:getTag()
            local idleDownAnimName = string.format("end%d_down", level)
            local idleUpAnimName = string.format("end%d_up", level)
            self.framentbgSpineDown:setAnimation(idleDownAnimName, false)
            self.framentbgSpineUp:setAnimation(idleUpAnimName, false)
        end
    end
    if self:isRunning() then
        return
    end

    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
    if adsData and adsData.isOpen and adsData.gotNum > adsData.usedNum and (adsData.usedNum < adsData.maxNum) then

    else
        if(self._activityData) then
            local luckyData = self._activityData:getLuckyWheelData()
            if(luckyData) then 
                -- 使用次数
                local buyNum = luckyData:getBuyNum()
                local turnNum = luckyData:getLeftTurnNum()

                local haveNum = buyNum - turnNum
                local costArr = luckyData:getCostDiamond()
                local shengyuNum = luckyData:getRefreshNum() - turnNum

                if(shengyuNum <= 0) then
                    UI.ScrollBar:createByText(UI.TEXT_1170104)
                    return 
                end

                local useCost = 0
                if(#costArr < buyNum + 1) then
                    useCost = checkint(costArr[#costArr])
                else
                    useCost = checkint(costArr[buyNum + 1])
                end

                local isEnough = true
                if not Avalon.MathUtil:checkDiamonEnough(useCost, GameDataManager:getInstance():getDiamond()) then
                    isEnough = false
                end
                if isEnough == false then
                    UI.TipsLayer:onDiamondNotEnough()
                    return
                end
            end
        else 
            local turnTableData = GameDataManager:getInstance():getTurnTableData()
            local buyCountLimit = tonumber(ConfigManager:getGeneralForKey("buyLotteryTime"))
            if turnTableData.hasBuyNum >= buyCountLimit then
                UI.ScrollBar:createByText(UI.TEXT_1170104)
                return
            end
            local isUseDiamond, cost, icon, isEnough = self:getBuyTypeAndCost()
            if isUseDiamond and not isEnough then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
        end
    end
    if RoleBehaviorManager:turnTableNpcCheck() then
        printWarn(" been blocked when using turnTable npc function buy times!")
        return
    end
    UI.WaitingLayer:showWaiting(true, self:getParent())
    sender:disable()
    MasterDataManager:setRepeatHandleData(RepeatHandleType.TURN_TABLE_BUY, 1)
    GameManager:trigerLuckyWheelFunction("LuckyWheelType_Buy", self.spriteID)
end

function LuckDropLayer:onTrigerClick()
    --todo 条件判断 1、是否已经过期 2、背包是否已满 3、次数是否足够
    
    local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(PublicDefine.AdvertFuncType.AdvertFuncType_LuckyWheel)
     -- print("------------LuckDropLayer:onTrigerClick()", adsData)
    if adsData and adsData.isOpen and adsData.gotNum > adsData.usedNum and (adsData.usedNum < adsData.maxNum) then
    
    else
        if(self._activityData) then 
            -- TODO 处理相关的逻辑
            self:refreshActivityData()
            if(self._activityData == nil) then 
                -- 活动过期，请重新处理
                UI.TipsLayer:OutOfDateForTurnTable(UI.TEXT_1170926, function()
                    print("OutOfDateForTurnTable callback")
                    self:closeWin()
                end)
                return false
            else 
                if self._activityData:getLuckyWheelData():judgeToUse() == false then
                    return false
                end
            end 
        else 
            if GameDataManager:getInstance():isOutForTurnTableData() then
                GameDataManager:getInstance():clearTurnTableData()
                UI.TipsLayer:OutOfDateForTurnTable(UI.TEXT_1170100, function()
                    print("OutOfDateForTurnTable callback")
                    if not tolua.isnull(self) then
                        self:closeWin()
                    end
                end)
                return false
            end
            local turnTableData = GameDataManager:getInstance():getTurnTableData()
            if turnTableData.leftTurnNum <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1170105)
                return false
            end
        end
    end
    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum <= 0 then
        UI.ScrollBar:createByTextID(1110793)
        return false
    end

    -- 判断背包是否满了
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr({})
    if not enough then
        UI.UIManager.mTipsLayer:onBagIsFull()
        return false
    end

    if RoleBehaviorManager:turnTableNpcCheck() then
        printWarn(" been blocked when using turnTable npc function triger click!")
        return false
    end
    -- print("self.spriteID =" .. self.spriteID)
    -- dump(GameDataManager:getInstance():getTurnTableData(), "GameDataManager:getTurnTableData() = ")
    GameManager:trigerLuckyWheelFunction("LuckyWheelType_Turn", self.spriteID, GameDataManager:getInstance():getTurnTableData().dropListId)
    EquipIllusionDataManager:setDelayNoticeOn(true)
    return true
end

function LuckDropLayer:trigerCallBack(data)
    if data.result == "LuckyWheelResultType_Succeed" then
        if data.type == "LuckyWheelType_Buy" then
            self:refreshInfoView(true)
            UI.ScrollBar:createByText(UI.TEXT_1212019)
        elseif data.type == "LuckyWheelType_Turn" then
            self.currentLayout:beginCacheMode()
            local goodsId = data.goodsId
            local number = data.num
            local found = false

            local uId = data.goodsId.."_"..data.num
            for i = 1, #self.nodeCahe do
                if uId ==  self.nodeCahe[i]:getName() then
                    found = true
                    self.bingoId = i
                    break
                end
            end
        end
    elseif data.result == "LuckyWheelResultType_TimeOver" then
         UI.TipsLayer:OutOfDateForTurnTable(UI.TEXT_1170100, function()
            self:closeWin()
         end)
    else 
        local resultNum = ProtobufUtil:enum_id("NPCSystem.LuckyWheelResultType",data.result)
        UI.TipsLayer:OutOfDateForTurnTable(LanguageManager:getInstance():getLocalString(1170000+checkint(resultNum)), function()
            self:closeWin()
        end)
    end

    -- TODO add by zp 这里需要处理客户端数据和服务器不匹配的问题

    if data.type == "LuckyWheelType_Buy" then
        UI.WaitingLayer:hideWaiting()
    end
end

function LuckDropLayer:getInfoCallBack(data)
    if(not tolua.isnull(self._virtualItemInfo)) then
        self._virtualItemInfo:removeFromParent(true)
        self._virtualItemInfo = nil 
    end

    self:refreshDropItemView()
    self:refreshInfoView(true)
end

function LuckDropLayer:refreshDropItemView()
    local turnTableData = GameDataManager:getInstance():getTurnTableData()
    if turnTableData.dropListId ~= nil and turnTableData.dropListId ~= 0 then
        local dropList = ConfigManager:getDropListConfig(turnTableData.dropListId)
        dump(dropList, "dropList")

        local drops = nil
        if(self._activityData and self._activityData:isInEffect()) then
            local luckyData = self._activityData:getLuckyWheelData()
            if(luckyData and luckyData:getLuckWheelDataArr()) then
                drops = luckyData:getLuckWheelDataArr()
            end
        end

        for i = 1, #self.nodeCahe do
            local pondId =  dropList.pond[i]
            local pondData = ConfigManager:getPondById(pondId)
            local templateID = pondData.goods[1]
            local num = pondData.goodsNum[1]

            -- 处理活动的逻辑
            if(drops) then
                templateID = drops[i].id
                num = drops[i].num
            end

            local goodData = GoodsDataManager:createLocalGoodsData(templateID)
            goodData:setIsGolden(true)
            -- goodData:setIsNew(false)
            self.nodeCahe[i]:setName(templateID.."_"..num)

            local text = self.nodeCahe[i]:getChildByName("TEXT")
            text:hide()
            if goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                and goodData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                text:show()
                text:setText("x"..num)  
            end

            local goodGrid = nil
            if  goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
                goodGrid = UI.Image:create()
                goodGrid:init(goodData:getIconName())
                text:setFontSize(UI.FONT_SIZE_20PX)
            else
                -- 创建新的装备格子
                goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodData)
                goodGrid:setTouchEnable(false)


                -- goodGrid:setSwallowTouches(false)
                text:setFontSize(UI.FONT_SIZE_14PX)  
                goodGrid:setInfoArea(true, false)
                table.insert(self.bingoItems, goodGrid)
            end
            goodGrid:center()
            goodGrid:setName("GOOD")
            local oldGood = self.nodeCahe[i]:getChildByName("GOOD")
            if oldGood ~= nil then
                oldGood:removeSelf()
            end
            self.nodeCahe[i]:addChild(goodGrid)
            -- goodGrid:enableDebugDraw()
            if goodGrid.hideFlagIcon then
                goodGrid:hideFlagIcon()
            end
        end

    end
end

--isForceRefresh:是否强制刷新界面信息； 在转盘转动过程中、数据可能已经下发 但是为了不让提前知晓结果不能刷新 
function LuckDropLayer:refreshInfoView(isForceRefresh)
    -- print("---------LuckDropLayer:refreshInfoView()", isForceRefresh)
    self:refreshActivityData()
    if not isForceRefresh and self.turnTableState ~= TURN_TABLE_STATE.END then
        return
    end
    self.useItemIcon:useShader(UI.COMPONENT_NORMAL_SHADER)
    self.btnTips:setFontColor(UI.FONT_COLOR_220_182_80)   
    self.useItemNumber:setFontColor(UI.FONT_COLOR_220_182_80)  
    self.btnTips:centerLeft(30)
    self.useItemNumber:setVisible(true)
    self.useItemIcon:setVisible(true)
    if(self._activityData) then
        self.remainRefreshTime:setVisible(false)
        self.clockIcon:setVisible(false)
        local luckyData = self._activityData:getLuckyWheelData()
        if(luckyData) then 
            -- 恢复图标显示
            self.useItemIcon:setSpriteName("symbol_gaming_diamond.png")

            -- 使用次数
            local buyNum = luckyData:getBuyNum()
            local turnNum = luckyData:getLeftTurnNum()

            local haveNum = buyNum - turnNum
            local costArr = luckyData:getCostDiamond()
            local shengyuNum = luckyData:getRefreshNum() - turnNum

            self.remainUseCount:setText(string.format(UI.TEXT_1170101, shengyuNum))

            -- TODO 判断是否还有购买了还没有使用的次数
            if(haveNum > 0) then 
                -- 不用购买直接转
                for i = 1, #self.blackSprites do
                    self.blackSprites[i]:hide()
                end
                self.mBtnBuy:disable()
                self.useItemIcon:useShader(UI.COMPONENT_GRAY_SHADER)
                self.btnTips:setFontColor(UI.FONT_COLOR_182_201_201)  
                self.useItemNumber:setFontColor(UI.FONT_COLOR_182_201_201) 
                self.useItemIcon:setVisible(false)
                self.useItemNumber:setVisible(false)
                self.useItemNumber:setText("0")
                self.btnTips:center()
            else 
                for i = 1, #self.blackSprites do
                    self.blackSprites[i]:show()
                end

                if(shengyuNum >0) then
                    -- local useCost = costArr[buyNum + 1]
                    local useCost = 0
                    if(#costArr < buyNum + 1) then
                        useCost = checkint(costArr[#costArr])
                    else
                        useCost = checkint(costArr[buyNum + 1])
                    end

                    -- 根据购买了几次，使用了几次
                    self.mBtnBuy:enable()
                    self.useItemNumber:setText(tostring(useCost))

                    local isEnough = true
                    if not Avalon.MathUtil:checkDiamonEnough(useCost, GameDataManager:getInstance():getDiamond()) then
                        isEnough = false
                    end
                    if isEnough then
                        self.useItemNumber:setFontColor(UI.FONT_COLOR_220_182_80)
                    else
                        self.useItemNumber:setFontColor(UI.FONT_COLOR_RED)
                    end
                else 
                    self.mBtnBuy:disable()
                    self.useItemIcon:useShader(UI.COMPONENT_GRAY_SHADER)
                    self.btnTips:setFontColor(UI.FONT_COLOR_182_201_201)  
                    self.useItemNumber:setFontColor(UI.FONT_COLOR_182_201_201) 
                    self.useItemIcon:setVisible(false)
                    self.useItemNumber:setVisible(false)
                    self.useItemNumber:setText("0")
                    self.btnTips:center()
                end 
            end 
        end
    else 
        self.remainRefreshTime:setVisible(true)
        self.clockIcon:setVisible(true)
        local turnTableData = GameDataManager:getInstance():getTurnTableData()
        local trigerCountLimit = tonumber(ConfigManager:getGeneralForKey("ableLotteryTime"))
        self.remainUseCount:setText(string.format(UI.TEXT_1170101,trigerCountLimit - turnTableData.hasTurnNum))
        local isUsingDiamond, costNumber, icon, isEnough = self:getBuyTypeAndCost()
        self.useItemIcon:setSpriteName(icon)
        if isUsingDiamond then
            self.useItemIcon:centerLeft(156)
        else
            self.useItemIcon:centerLeft(145)
        end
        self.useItemNumber:setText(costNumber)
        if turnTableData.leftTurnNum <= 0 then
            for i = 1, #self.blackSprites do
                self.blackSprites[i]:show()
            end
        else
            for i = 1, #self.blackSprites do
                self.blackSprites[i]:hide()
            end
        end
        if turnTableData.leftTurnNum > 0 then
            self.mBtnBuy:disable()
            self.useItemIcon:useShader(UI.COMPONENT_GRAY_SHADER)
            self.btnTips:setFontColor(UI.FONT_COLOR_182_201_201)  
            self.useItemNumber:setFontColor(UI.FONT_COLOR_182_201_201) 
        else
            local buyCountLimit = tonumber(ConfigManager:getGeneralForKey("buyLotteryTime"))
            if turnTableData.hasBuyNum >=  buyCountLimit then
                self.mBtnBuy:disable()
                self.useItemIcon:useShader(UI.COMPONENT_GRAY_SHADER)
                self.btnTips:setFontColor(UI.FONT_COLOR_182_201_201)  
                self.useItemNumber:setFontColor(UI.FONT_COLOR_182_201_201) 
            else
                self.mBtnBuy:enable()
            end
        end
        if not isEnough then
            self.useItemNumber:setFontColor(UI.FONT_COLOR_RED)
        end
    end 
    self:refreshAdsStatus()
end

function LuckDropLayer:getBuyTypeAndCost()
    local isEnough = true
    local useDiamond = false
    local turnTableData = GameDataManager:getInstance():getTurnTableData()
    local useItemId = tonumber(ConfigManager:getGeneralForKey("lotteryID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local useItemCostList = ConfigManager:getGeneralForKey("lotteryPrice")
    local useItemCostArray = string.split(useItemCostList, ";")
    local useItemCost = useItemCostArray[#useItemCostArray]
    if turnTableData.hasBuyNum <  #useItemCostArray then
        useItemCost = useItemCostArray[turnTableData.hasBuyNum + 1]
    end
    local useItemCostNumber = tonumber(useItemCost)
    if (goodNumber < useItemCostNumber) then
         useDiamond = true
    else
        local icon = GoodsDataManager:createLocalGoodsData(useItemId):getSmallIconName()
        return useDiamond, useItemCostNumber, icon, isEnough
    end
    local diamondCostList = string.split(ConfigManager:getGeneralForKey("lotteryCrystal"), ";")
    local diamondCost = diamondCostList[#diamondCostList]
    if turnTableData.hasBuyNum < #diamondCostList then
        diamondCost = diamondCostList[turnTableData.hasBuyNum + 1]
    end
    local diamondCostNumber = tonumber(diamondCost)
    if not Avalon.MathUtil:checkDiamonEnough(diamondCostNumber, GameDataManager:getInstance():getDiamond()) then
        isEnough = false
    end
    return useDiamond, diamondCostNumber, "symbol_gaming_diamond.png", isEnough
end

function LuckDropLayer:isRunning()
    return self.turnTableState ~= TURN_TABLE_STATE.END
end

function LuckDropLayer:showRewardAction()
    local bingoNode = self.nodeCahe[self.bingoId]
    if bingoNode == nil then
        return
    end
    Avalon.AudioManager:playSound("1508")
    local goodNode = bingoNode:getChildByName("GOOD")
    local uId = string.split(bingoNode:getName(),"_") 
    -- local pos = goodNode:convertToWorldSpace(cc.p(0, 0))
    local goodsId = tonumber(uId[1])
    local number = tonumber(uId[2])

    self.rewardLayer = UI.Layout.create()
    self.rewardLayer:init()
    self.rewardLayer:setSize(90, 90)
    -- self.rewardLayer:enableDebugDraw(UI.RED)
    local goodData = GoodsDataManager:createLocalGoodsData(goodsId)
    goodData:setIsGolden(true)
    local goodGrid = nil
    if  goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then

        local _text = UI.Text:create()
        _text:init("X"..number,UI.FONT_STANDARD,UI.FONT_SIZE_16PX)
        _text:setFontColor(UI.FONT_COLOR_255_164_34)
        _text:setOutline(UI.FONT_COLOR_60_26_3)

        goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:hideBG()
        goodGrid:hideIcon()
        goodGrid:setTouchEnable(true)
        goodGrid:setSwallowTouches(false)

        _text:centerBottom(-24)
        goodGrid:center()
        goodGrid:addChild(_text, 3)
    else
        goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:hideBG()
        goodGrid:setTouchEnable(true)
        goodGrid:setSwallowTouches(false)
        goodGrid:center()
        self.goodGrid = goodGrid
    end
    goodGrid:setScale(0.1)
    goodGrid:runAction(cc.EaseOut:create(cc.ScaleTo:create(0.15,1), 1))
    local level = 3
    if goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM or goodData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        level = 3
    elseif goodData:getGoodsRare() > PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
        level = 1
    else
        level = 2
    end
    local beginDownAnimName = string.format("begin%d_down", level)
    local beginUpAnimName = string.format("begin%d_up", level)

    local framentbgSpineDown = UI.Animation:create()
    framentbgSpineDown:init("effect_ui_town_luckdrop.json", "effect_ui_town_luckdrop.atlas")
    framentbgSpineDown:setAnimation(beginDownAnimName,false)
    framentbgSpineDown:center()
    framentbgSpineDown:setTag(level)
    self.framentbgSpineDown = framentbgSpineDown

    local framentbgSpineUp = UI.Animation:create()
    framentbgSpineUp:init("effect_ui_town_luckdrop.json", "effect_ui_town_luckdrop.atlas")
    framentbgSpineUp:setAnimation(beginUpAnimName, false)
    framentbgSpineUp:center()
    self.framentbgSpineUp = framentbgSpineUp

    framentbgSpineDown:addComponent("item-node", goodGrid)

    self.rewardLayer:addChild(framentbgSpineDown, 1)
    self.rewardLayer:addChild(framentbgSpineUp, 1)
    -- self.rewardLayer:leftBottom(282, 270)
    self.rewardLayer:leftBottom(212, winSize.height / 2 - 6.5)
    self:addChild(self.rewardLayer, 10)
    if goodGrid.hideFlagIcon then
        goodGrid:hideFlagIcon()
    end

    framentbgSpineDown:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        local startPos = string.find(event.animation, "begin")
        if (startPos ~= nil) then
            local level = sender:getTag()
            local idleDownAnimName = string.format("idle%d_down", level)
            local idleUpAnimName = string.format("idle%d_up", level)
            framentbgSpineDown:setAnimation(idleDownAnimName,true)
            framentbgSpineUp:setAnimation(idleUpAnimName,true)
        else
            local startPos = string.find(event.animation, "end")
            if (startPos ~= nil) then
                self.framentbgSpineDown:destroy()
                self.framentbgSpineUp:destroy()
                self.rewardLayer:runAction(
                    cc.RemoveSelf:create()
                )
                self.rewardLayer = nil
                self.goodGrid = nil
                self.framentbgSpineDown = nil
                self.framentbgSpineUp = nil
            end
        end
    end)
end

-- 刷新显示
function LuckDropLayer:refreshTime(dt)
    if(self.remainRefreshTime and self.remainRefreshTime:isVisible()) then
                         -- print("--------------------refresWaitingTime 11111 = "..GameManager:getNowServerTime())

        local refresWaitingTime = GameManager:getNowServerTime() % (SECONDS_ONE_DAY)
         -- print("--------------------refresWaitingTime  = "..refresWaitingTime)

          -- print("--------------------del Time  = "..os.time() - GameManager:getNowServerTime())
        refresWaitingTime = 24 * 60 * 60 - refresWaitingTime
        if(refresWaitingTime > 0) then
            refresWaitingTime = refresWaitingTime - dt
        end
        local str = "00:00:00"
        if(refresWaitingTime > 0) then
            local hour = math.modf(refresWaitingTime / SECONDS_ONE_HOUR)
            local yu = refresWaitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(yu/60)
            yu = yu % 60
            local second = math.modf(yu/1)
            str = string.format("%d:%d:%d", hour, minute, second)
        end
        
        
        self.remainRefreshTime:setText(str)

        local left = (self.remainRefreshTime:getParent():getContentSize().width - self.remainRefreshTime:getContentSize().width - self.clockIcon:getContentSize().width) / 2 - 2
        self.clockIcon:leftBottom(left, 4)
        self.remainRefreshTime:leftBottom(left + self.clockIcon:getContentSize().width + 4, 10)
    end
end

function LuckDropLayer:getPointActionTImeBySpeed(speed)
    -- print("----------speed ="..speed)
    speed = math.abs(speed)
    local time = 1
    local angle = 50
    if speed >= 0 and speed < 0.2 then
        time = 1.0
        angle = 20
    elseif speed >= 0.2 and speed < 0.4 then
        time = 0.9
        angle = 22
    elseif speed >= 0.4 and speed < 0.6 then
        time = 0.8
        angle = 24
    elseif speed >= 0.6 and speed < 0.8 then
        time = 0.7
        angle = 26
    elseif speed >= 0.8 and speed < 1 then
        time = 0.6
        angle = 28
    elseif speed >= 1 and speed < 2 then
        time = 0.5
        angle = 30
    elseif speed >= 2 and speed < 3 then
        time = 0.4
        angle = 32
    elseif speed >= 3 and speed < 5 then
        time = 0.3
        angle = 34
    elseif speed >= 5 and speed < 10 then
        time = 0.2
        angle = 36
    elseif speed >= 10 and speed < 20 then
        time = 0.1
        angle = 38
    elseif speed >= 20 and speed < 30 then
        time = 0.08
        angle = 40
    elseif speed >= 30 and speed < 40 then
        time = 0.06
        angle = 42
    elseif speed >= 40 and speed < 50 then
        time = 0.04
        angle = 44
    elseif speed >= 50 and speed < 60 then
        time = 0.03
        angle = 46
    elseif speed >= 60 and speed < 70 then
        time = 0.02
        angle = 48
    elseif speed >= 70 then
        time = 0.01
        angle = 50
    else
        time = 1
        angle = 50 
    end
    return time / 3, angle + 5
end