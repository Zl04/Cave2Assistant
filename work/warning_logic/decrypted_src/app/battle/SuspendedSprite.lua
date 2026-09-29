--[[
    -- SuspendedSprite.lua
    -- Author:ydli
    -- 2018年3月5日
    漂浮物对象 缓存当前动画参数 自身动画逻辑处理
    移动 缩放 旋转
]]
UI = UI or {}

local SuspendedSprite = class("SuspendedSprite", cc.Sprite)
local winSize = cc.Director:getInstance():getWinSize()
local spacing = 0
local winRect = cc.rect(-spacing / 2, -spacing / 2, winSize.width + spacing, winSize.height + spacing) 
-- public:

function SuspendedSprite:init()
end

local DIRECTION = {
    UP = 1,
    DOWN = 2,
    LEFT = 3,
    RIGHT = 4,
}

--动画参数
function SuspendedSprite:initParams(cfgData, totalDis)
    self.isDestory = false
    self.generateTime = 0
    self.cfgData = cfgData
    self.curCoord = curCoord --用于计算 移动方向   往中间移动
    self.centerCoord = centerCoord
    self.moveDis = totalDis
    self.R = math.sqrt(self:getContentSize().height * self:getContentSize().height + self:getContentSize().width * self:getContentSize().width)
    self:generateActionParam()
    self:playAction()
end

-- return  isDestory
function SuspendedSprite:update(dt)
    self.generateTime = self.generateTime + dt
    if self.generateTime > self.detoryTime then
        return true
    end
    local point = self:convertToWorldSpace(cc.p(0, 0))
    if point.y > winSize.height * 1.5 or point.y < winSize.height * -0.5 or point.x > winSize.width * 1.5 or point.x < winSize.width * -0.5 then
        return true
    end
    -- self:calculateMoveData(dt)
    -- self:calculateScaleData(dt)
    -- self:calculateTurnData(dt)
    -- if self:isInView() then -- 处理状态
    --     self:playMoveAction()
    --     self:playScaleAction()
    --     self:playTurnAction()
    -- end
    return false
end

function SuspendedSprite:playAction()
    -- 创建移动动作
    local moveAmount = self.moveTime * self.moveSpeed * 0.5
    local moveAction = cc.MoveBy:create(self.moveTime, cc.p(moveAmount * self.moveVariantFactorX, moveAmount * self.moveVariantFactorY))
    if (self.isMoveCycle) then
        moveAction = cc.RepeatForever:create(cc.Sequence:create(moveAction, moveAction:reverse()))
    end

    -- 创建放大缩小动作
    local scaleAction = cc.ScaleTo:create(self.scaleTime, self.scaleFrom, self.scaleTo)
    if (self.isScaleCycle) then
        local scaleReverseAction = cc.ScaleTo:create(self.scaleTime, self.scaleTo, self.scaleFrom)
        scaleAction = cc.RepeatForever:create(cc.Sequence:create(scaleAction, scaleReverseAction))
    end

    -- 创建旋转动作
    local rotateAmount = self.turnSpeed * self.turnTime
    local rotateAction = cc.RotateBy:create(self.turnTime, rotateAmount)
    if (self.isTurnCycle) then
        rotateAction = cc.RepeatForever:create(cc.Sequence:create(rotateAction, rotateAction:reverse()))
    end

    -- 播放动作
    self:runAction(moveAction)
    self:runAction(scaleAction)
    self:runAction(rotateAction)
end

--随机生成  动画参数
function SuspendedSprite:generateActionParam()
    -- ----------初始化 配置变量 由配置表生成-------------------
    self.detoryTime = 0 --销毁时间
    --位移动画 
    self.moveDir = 0 -- 移动方向
    self.moveSpeed = 0 --移动速度
    self.moveTime = 0 --移动时间
    self.isMoveCycle = false -- 是否循环运动 默认false
    --缩放动画
    self.scaleSpeed = 0 --速度
    self.scaleTime = 0 --时间
    self.isScaleCycle = false -- 是否循环缩放 默认false
    --旋转动画 （暂不考虑来回旋转）
    self.turnSpeed = 0 --速度
    self.turnTime = 0 --时间
    self.isTurnCycle = false -- 是否循环旋转 默认false

    -- ----------生成变量（运动过程过 回改变的值）-------------------
    self.lastMoveFlag = 0 --移动标记 标记是否要变向
    self.moveTotalX = 0 --累积移动X轴距离
    self.moveTotalY = 0 --累积移动Y轴距离
 
    self.lastScaleFlag = 0 --缩放标记 标记是否要变向
    self.scaleTotal = 0 --累积缩放量

    self.lastTurnFlag = 0 --旋转标记 标记是否要变向
    self.turnTotal = 0 --累积旋转量
    -----------------赋值给  配置变量 ----------------------
    local percent = 100
    local seedsNum = math.random(1, percent)
    local seedsPercent = math.random(1, percent) / 100
    -- self.detoryTime = self:getRandomNum(seedsPercent, self.cfgData.suspendedMatterDestroyTime) / 1000
    self.moveDir = self:getMoveDir(seedsNum)
    self.moveSpeed = self:getRandomNum(seedsPercent, self.cfgData.moveSpeed) 
    self.moveTime  = self:getRandomNum(seedsPercent, self.cfgData.moveTime) / 1000
    local moveVariant = (seedsNum % 41 - 20) / 100
    self.moveVariantFactorX = 1 + moveVariant
    self.moveVariantFactorY = 1 - moveVariant
    self.detoryTime = self.moveDis / self.moveSpeed 

    local scaleTo = self:getRandomNum(seedsPercent, self.cfgData.scalingRatio) 
    local scaleFrom = scaleTo
    if scaleTo == 1 then
       scaleFrom = 1
    else
        scaleFrom = (scaleTo - 1) < 0 and (1 - scaleTo) or (scaleTo - 1)
    end
    self.scaleTime = self:getRandomNum(seedsPercent, self.cfgData.scalingTime) / 1000
    self.scaleSpeed = (scaleTo - scaleFrom) / self.scaleTime
    self:setScale(scaleFrom)

    --test
    self.scaleFrom = scaleFrom
    self.scaleTo = scaleTo


    self.turnSpeed = self:getRandomNum(seedsPercent, self.cfgData.flipSpeed) 
    self.turnSpeed = self.turnSpeed / 10
    self.turnTime  = self:getRandomNum(seedsPercent, self.cfgData.flipTime) / 1000

    -- if seedsNum % 2 == 0 then
    --     self.isMoveCycle = true
    -- end
    if seedsNum % 3 == 0 then
        self.isScaleCycle = true
    end
    if seedsNum % 5 == 0 then
        self.isTurnCycle = true
    end
end

--是否 在 可见区域
function SuspendedSprite:isInView()
    local point = self:convertToWorldSpace(cc.p(0, 0))
    local selfOldRect = cc.rect(point.x - self.R, point.y - self.R, self.R * 2, self.R * 2) 
    local selfNewRect = cc.rect(point.x - self.R + self.moveTotalX, point.y - self.R + self.moveTotalY, self.R * 2, self.R * 2) 
    local flagOld = cc.rectIntersectsRect(winRect, selfOldRect)
    local flagNew = cc.rectIntersectsRect(winRect, selfNewRect)
    return flagOld or flagNew
    -- return true
end

function SuspendedSprite:getRandomNum(seedsPercent, limitStr)
    local limitStrs = string.split(limitStr, ",")
    local number = tonumber(limitStrs[1]) + (tonumber(limitStrs[2]) -  tonumber(limitStrs[1])) * seedsPercent
    return number
end

function SuspendedSprite:getMoveDir(seedsNum)
    local dirList  = {}
    -- if self.curCoord[1] > self.centerCoord[1] then
    --     table.insert(dirList, DIRECTION.LEFT)
    -- else
    --     table.insert(dirList, DIRECTION.RIGHT)
    -- end
    -- if self.curCoord[2] > self.centerCoord[2] then
    --     table.insert(dirList, DIRECTION.DOWN)
    -- else
    --     table.insert(dirList, DIRECTION.UP)
    -- end
    table.insert(dirList, DIRECTION.RIGHT)
    table.insert(dirList, DIRECTION.UP)
    if seedsNum % 2 == 0 then
        return dirList[1]
    else
        return dirList[2]
    end
end

-- function SuspendedSprite:calculateMoveData(dt)
--     if self.moveSpeed == 0 then
--         return
--     end
--     if not self.isMoveCycle and self.generateTime > self.moveTime then
--         return
--     end

--     if self.moveDir == DIRECTION.UP then
--         self.moveTotalY = self.moveTotalY + dt * self.moveSpeed
--     elseif self.moveDir == DIRECTION.DOWN then
--         self.moveTotalY = self.moveTotalY - dt * self.moveSpeed
--     elseif self.moveDir == DIRECTION.LEFT then
--         self.moveTotalX = self.moveTotalX - dt * self.moveSpeed
--     elseif self.moveDir == DIRECTION.RIGHT then
--         self.moveTotalX = self.moveTotalX + dt * self.moveSpeed
--     else
--         print("error moveDir !!!", self.moveDir)
--     end
-- end

-- function SuspendedSprite:calculateScaleData(dt)
--     if self.scaleSpeed == 0 then
--         return
--     end
--     if not self.isScaleCycle and self.generateTime > self.scaleTime then
--         return
--     end
--     self.scaleTotal = self.scaleTotal + dt * self.scaleSpeed
-- end

-- function SuspendedSprite:calculateTurnData(dt)
--     if self.turnSpeed == 0 then
--         return
--     end
--     if not self.isTurnCycle and self.generateTime > self.turnTime then
--         return
--     end
--     self.turnTotal = self.turnTotal + dt * self.turnSpeed
-- end

-- function SuspendedSprite:playMoveAction()
--     -- print("-----self.moveTotalX, self.moveTotalY = ", self.moveTotalX, self.moveTotalY)
--     if self.moveTotalX == 0 and self.moveTotalY == 0 then
--         return
--     end
--     self:setPosition(self:getPositionX() + (self.moveTotalX + self.moveTotalY) * 0.5,  self:getPositionY() + (self.moveTotalX + self.moveTotalY) * 0.5) 
--     self.moveTotalX = 0 
--     self.moveTotalY = 0 
--     local curMoveFlag = math.ceil(self.generateTime / self.moveTime) % 2
--     if self.isMoveCycle and self.lastMoveFlag ~= curMoveFlag then
--        self.moveSpeed = self.moveSpeed * -1
--     end
--     self.lastMoveFlag = curMoveFlag
-- end
   
-- function SuspendedSprite:playScaleAction()
--     if self.scaleTotal == 0 then
--         return
--     end
--     self:setScale(self:getScale() + self.scaleTotal) 
--     -- if self:getScale() > 2 then 
--     --     print("--------------self:getScale() , self.scaleTime, self.scaleSpeed, self.scaleFrom, self.scaleTo = ", self:getScale(), self.scaleTime, self.scaleSpeed, self.scaleFrom, self.scaleTo)
--     -- end
--     self.scaleTotal = 0
--     local curScaleFlag = math.ceil(self.generateTime / self.scaleTime) % 2
--     if self.isScaleCycle and self.lastScaleFlag ~= curScaleFlag then
--        self.scaleSpeed = self.scaleSpeed * -1
--     end
--     self.lastScaleFlag = curScaleFlag
-- end

-- function SuspendedSprite:playTurnAction()
--     if self.turnTotal == 0 then
--         return
--     end
--     self:setRotation(self:getRotation() + self.turnTotal) 
--     self.turnTotal = 0
--     local curTurnFlag = math.ceil(self.generateTime / self.turnTime) % 2
--     if self.isTurnCycle and self.lastTurnFlag ~= curTurnFlag then
--        self.turnSpeed = self.turnSpeed * -1
--     end
--     self.lastTurnFlag = curTurnFlag
-- end

function SuspendedSprite:destory()
    -- local moveByDis = cc.p(0,0)
    -- local speedDir = self.moveSpeed < 0 and -1 or 1
    -- if self.moveDir == DIRECTION.UP then
    --     moveByDis = cc.p(0, winSize.height * speedDir)
    -- elseif self.moveDir == DIRECTION.DOWN then
    --     moveByDis = cc.p(0, -winSize.height * speedDir)
    -- elseif self.moveDir == DIRECTION.LEFT then
    --     moveByDis = cc.p(-winSize.width * speedDir, 0)
    -- elseif self.moveDir == DIRECTION.RIGHT then
    --     moveByDis = cc.p(winSize.width * speedDir, 0)
    -- else
    --     print("error moveDir !!!", self.moveDir)
    -- end
    -- moveByDis = cc.p((moveByDis.x + moveByDis.y) * 0.5, (moveByDis.x + moveByDis.y) * 0.5)
    -- -- local actTime = math.abs(moveByDis.x + moveByDis.y) / self.moveSpeed
    -- local actTime = 4
    -- local spawnAction = cc.Spawn:create(cc.FadeOut:create(actTime * 2), cc.MoveBy:create(actTime, moveByDis))
    -- self:runAction(cc.Sequence:create(spawnAction, cc.CallFunc:create(function()
    --     self:removeFromParent(true)
    -- end)))
    -- self.isDestory = true
    self:removeFromParent(true)
end

function SuspendedSprite:fade(isFadeIn)
    -- 不可视时要求淡出和可视时要求淡入 = 不做任何行为
    if ((isFadeIn and self:isVisible()) and 
        ((not isFadeIn) and (not self:isVisible()))) then
        return
    end

    if not tolua.isnull(self._fadeAction) then
        self:stopAction(self._fadeAction)
        self._fadeAction = nil
    end

    if (isFadeIn) then
        self:setVisible(true)
        self._fadeAction = cc.FadeIn:create(0.3)
    else
        self._fadeAction = cc.Sequence:create(cc.FadeOut:create(0.3), cc.CallFunc:create(function() self:setVisible(false) end))
    end
    self:runAction(self._fadeAction)
end

return SuspendedSprite