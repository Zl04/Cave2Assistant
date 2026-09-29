--[[
    登录背景模块
]]

-- 模块初始化 --
---------------------------------------
-- 引用
-- local LanguageManager = require("app.game.LanguageManager")
-- require("app.utils.ServerConfigUtil")
require "app.ui.common.ClippingNode"

-- 引用UI命名空间
UI = UI or {}

-- 模块初始化
local MainLayerBackground = class("MainLayerBackground", UI.HWBtnComponent)
UI.MainLayerBackground = MainLayerBackground

-- 私有变量:
local size = cc.Director:getInstance():getWinSize()
local fixedWidthScale = size.width / CONFIG_SCREEN_WIDTH
-- 暂时这么处理水果X横向偏移
local fixedWidthOffset = (size.width - CONFIG_SCREEN_WIDTH) * 0.952
-- if (math.floor(size.width + 0.5) == 1386 and math.floor(size.height) == 640) then
--     fixedWidthOffset = 238
-- end
local DEBUG = true
local DEBUG_DRAW = true
local BG_ANIMATION_Z = -70
local BG_BGIMAGE_Z = -100
local BG_BGPARTS_Z = -50
local BG_FGPARTS_Z = -10
---------------------------------------
-- eo 模块初始化 --













-- 资源统合 --
---------------------------------------
local COM_RES_LIST = { }
---------------------------------------
-- eo 资源统合 --














function MainLayerBackground:ctor()
    MainLayerBackground.super.ctor(self, 0, COM_RES_LIST, size.width, size.height)
    self.bgLayer = nil
    self.fgLayer = nil
    self.enableMove = false
end

--析构函数  
function MainLayerBackground:dtor()
    MainLayerBackground.super.dtor(self)
    self:setDeviceMotionEnabled(false)
    self:mute()
    -- 清理内存
    local spriteNamesToRelease = {
        "ui_login_loginbg_01.png",
        "ui_login_loginbg_fg_01.png",
        "ui_login_loginbg_02.png",
        "ui_login_loginbg_fg_02.png",
        "ui_login_loginbg_03.png",
        "ui_login_loginbg_fg_03.png",
        "ui_login_loginbg_04.png",
        "ui_login_loginbg_fg_04.png",
    }
    local textureCache = cc.Director:getInstance():getTextureCache()
    for i,v in ipairs(spriteNamesToRelease) do
        textureCache:removeTextureForKey(v)
    end
end

-- 初始化
function MainLayerBackground:init(serverList, onManualSelect)
    MainLayerBackground.super.init(self)
end




--显示主界面背景
function MainLayerBackground:onInitView()
    self:setScale(fixedWidthScale)

    self.bgLayer = cc.Layer:create();
    self.bgLayer:setPosition(0,0)
    self.bgLayer:setContentSize(size)
    -- self.bgLayer:setVisible(false)
    self:addChild(self.bgLayer,-5)

    self.fgLayer = cc.Layer:create();
    self.fgLayer:setPosition(0,0)
    self.fgLayer:setContentSize(size)
    -- self.fgLayer:setVisible(false)
    self:addChild(self.fgLayer,-4)


    -------------------布置背景------------------------
    -- 写死的背景切割宽度, 01 对应 1, 02 对应 2, 修正接缝
    local bgWidths = {1136, 1136, 1136, 1136}
    local bgWidth = 1136
    local seamCoverWidth = 1035
    local seamCoverHeight = 1110
    self._bgWidth = bgWidth
    local fullWidth = bgWidths[1] + bgWidths[2] + bgWidths[3] + bgWidths[4]
    local bgHeight = 1075
    self._bgHeight = bgHeight
    local fgBottom = -(bgHeight - size.height) 
    local fgTop = size.height + (bgHeight - size.height) 


    -- 前景秃鹫 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_crow.json", "loadingbg_crow.atlas", 1, true)
    ani:setScaleX(-1)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 600 - ani._hw, fgBottom + 280 - ani._hh)
    self.fgLayer:addChild(ani, BG_ANIMATION_Z + 1)
    -- local ani = UI.Animation:create()
    -- ani:init("loadingbg_crow.json", "loadingbg_crow.atlas", 1, true)
    -- ani:setScaleX(-1)
    -- ani:setAnimation("idle", true)
    -- ani:leftBottom(size.width/2 - 600 - ani._hw, fgBottom + 280 - ani._hh)
    -- self.fgLayer:addChild(ani, BG_ANIMATION_Z + 1)
    -- local ani = UI.Animation:create()
    -- ani:init("loadingbg_crow.json", "loadingbg_crow.atlas", 1, true)
    -- ani:setScaleX(-1)
    -- ani:setAnimation("idle", true)
    -- ani:leftBottom(size.width/2 - 600 - ani._hw, fgBottom + 280 - ani._hh)
    -- self.fgLayer:addChild(ani, BG_ANIMATION_Z + 1)

    -- 背景第左回转衔接分割 --
    local bgX = size.width/2 - bgWidths[4] - bgWidths[1] - bgWidths[2]
    local bg = cc.Sprite:create("ui_login_loginbg_04.png")
    local bgY = size.height/2 - bg:getContentSize().height/2
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX - fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX + fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)


    -- 背景第1分割 --
    local bgX = size.width/2 - bgWidths[1] - bgWidths[2]
    local bg = cc.Sprite:create("ui_login_loginbg_01.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX - fullWidth, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX + fullWidth, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)


    -- 背景第2分割 --
    local bgX = size.width/2 - bgWidths[2]
    local bg = cc.Sprite:create("ui_login_loginbg_02.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_02.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_02.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX - fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_02.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX + fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)


    -- 背景第3分割 --
    local bgX = size.width/2
    local bg = cc.Sprite:create("ui_login_loginbg_03.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_03.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_03.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX - fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_03.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX + fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)


    -- 背景第4分割 --
    local bgX = size.width/2 + bgWidths[3]
    local bg = cc.Sprite:create("ui_login_loginbg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX - fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_04.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX + fullWidth, fgBottom)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)


    -- 背景第右回转衔接分割 --
    local bgX = size.width/2 + bgWidths[3] + bgWidths[4]
    local bg = cc.Sprite:create("ui_login_loginbg_01.png")
    bg:setAnchorPoint(0,0)
    bg:setPosition(bgX, bgY)
    self.bgLayer:addChild(bg, BG_BGIMAGE_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX - fullWidth, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    local bg = cc.Sprite:create("ui_login_loginbg_fg_01.png")
    bg:setAnchorPoint(0,1)
    bg:setPosition(bgX + fullWidth, fgTop)
    self.fgLayer:addChild(bg, BG_FGPARTS_Z)
    ------------------------设备动作移动背景------------------------------
    -- 初始化设备动作检测

    -- 微动作元素相关
    self._microMovementList = {}

    -- 微动作元素相关
    self._microMovementX = 0
    self._microMovementY = 0
    self._microMovementList = {}

    -- 滚动元素相关
    -- local seamCoverXSpeedFactor = 2
    local seamCoverXSpeedFactor = (seamCoverWidth + bgWidth) / (bgWidth)
    local seamCoverYSpeedFactor = seamCoverHeight / bgHeight
    self._seamCoverXSpeedFactor = seamCoverXSpeedFactor
    self._seamCoverYSpeedFactor = seamCoverYSpeedFactor
    self._bgTouchX = 0
    self._bgTouchY = 0

    local isInitialized = false
    local isInitializing = false
    local initX = 70
    local initY = (bgHeight - size.height) / 2 * fixedWidthScale - 165
    self._initX = initX
    self._initY = initY

    self._bgLayerX = initX
    self._bgLayerY = initY

    self._bgLayerOldX = initX
    self._bgLayerOldY = initY

    self._isDeviceMotionAvailable = self:getDeviceMotionAvailable()

    local function limitBgLayerRange()
        if (self._bgLayerX > bgWidth * 2 + fixedWidthOffset / 2) then self._bgLayerX = self._bgLayerX - (4 * bgWidth)
        elseif (self._bgLayerX < -bgWidth * 2 + fixedWidthOffset / 2) then self._bgLayerX = self._bgLayerX + (4 * bgWidth) end
        if (self._bgLayerY > (bgHeight / 2 - size.height / 2) * fixedWidthScale) then self._bgLayerY = (bgHeight/2 - size.height/2) * fixedWidthScale
        elseif (self._bgLayerY < (size.height/2 - bgHeight/2) * fixedWidthScale)  then self._bgLayerY = (size.height/2 - bgHeight/2) * fixedWidthScale end
    end

    local function registerForMicroMovement(target, rangeX, rangeY, tag)
        if (rangeX == nil) then rangeX = 40 end
        if (rangeY == nil) then rangeY = 0 end
        local entry = {
            target = target,
            rangeX = rangeX,
            rangeY = rangeY,
            magX = 0,
            magY = 0,
            originalLeft = target:getLeft(), -- 下面动画都是用左下做原坐标
            originalBottom = target:getBottom(),
            tag = tag
        }
        table.insert(self._microMovementList, entry)
    end

    local function updateMicroMovement(magX, magY, tag, isOffset)
        if (isOffset == nil) then isOffset = true end
        for i,v in ipairs(self._microMovementList) do
            if (tag == nil or tag == v.tag) then
                if (isOffset) then
                    v.magX = v.magX + magX
                    v.magY = v.magY + magY
                else
                    v.magX = magX
                    -- v.magY = magY
                end
                if (v.magX > 1) then v.magX = 1 end
                if (v.magX < -1) then v.magX = -1 end
                if (v.magY > 1) then v.magY = 1 end
                if (v.magY < -1) then v.magY = -1 end
                local offsetX = v.magX * v.rangeX
                local offsetY = v.magY * v.rangeY

                --顺滑
                -- v.target:leftBottom(v.originalLeft + offsetX, v.originalBottom + offsetY)
                -- v.target:setPosition(v.originalLeft + offsetX, v.originalBottom + offsetY)
                -- v.target:stopAllActions()
                v.target:runAction(cc.MoveTo:create(0.02, cc.p(v.originalLeft + offsetX, v.originalBottom + offsetY)))
            end
        end
    end
    self._updateMicroMovement = updateMicroMovement

    -- 陀螺仪移动背景
    -- if (false) then
    if (self._isDeviceMotionAvailable) then
        print("DeviceMotion可用")
        local lastYaw = 0
        local lastPitch = 0
        performWithDelay(self,function()
            print("performWithDelay")
            self:registerScriptDeviceMotionHandler(function(roll,pitch,yaw,x,y,z,timestamp)
                -- 累计角度差计算背景X位置, 并且限制超出一边的时候转向另外一边, 形成360度一圈
                local deltaYaw = lastYaw == 0 and 0 or yaw - lastYaw
                lastYaw = yaw
                self._bgLayerX = self._bgLayerX + (bgWidth * 2 * deltaYaw / math.pi)

                -- 纵向
                local deltaPitch = lastPitch == 0 and 0 or pitch - lastPitch
                lastPitch = pitch
                self._bgLayerY = self._bgLayerY + deltaPitch * 900
                limitBgLayerRange()
                -- print(roll,pitch,yaw,x,y,z,_y)
            end)
        end,3)

        self:setDeviceMotionInterval(0.02)
        self:setDeviceMotionEnabled(true)
    end

    -- 触摸移动背景
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
    self._bgTouchOrigin = {x = 0, y = 0}
    self._bgLayerOrigin = {x = 0, y = 0}
    local lastPosBegan = nil
    local lastPosMove = nil
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, comp, pos)
        -- 检查位置范围避免多点触控导致鬼畜问题
        if (lastPosBegan ~= nil and math.abs(lastPosBegan.x - pos.x) > 100) then return end
        lastPosBegan = pos

        -- 记录初始点击位置
        self._bgTouchOrigin = pos
        self._bgLayerOrigin = {x = self._bgLayerX, y = self._bgLayerY}
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, comp, pos)
        -- 检查位置范围避免多点触控导致鬼畜问题
        if (lastPosMove ~= nil and math.abs(lastPosMove.x - pos.x) > 100) then return end
        lastPosMove = pos

        -- 横向偏移计算
        local bgOffsetX = (pos.x - self._bgTouchOrigin.x)
        self._bgLayerX = self._bgLayerOrigin.x + bgOffsetX

        -- 纵向偏移量计算(有设备动作的时候不使用触摸纵向调整)
        local bgOffsetY = (pos.y - self._bgTouchOrigin.y)
        self._bgLayerY = self._bgLayerOrigin.y + bgOffsetY
        limitBgLayerRange()
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, comp, pos)
        -- 放开后清空
        lastPosMove = nil
        lastPosBegan = nil
    end)



    schedule(self, function()
        -- 完成场景切换后进入初始化
        if (not self.enableMove) then return end

        -- 初始化完成后再使用陀螺仪
        if (not isInitialized) then
            -- 初始化中或者屏幕未移动, 保持不动
            if (isInitializing or self._bgLayerX == initX) then return end
            isInitializing = true
            self.bgLayer:runAction(cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(self._bgLayerX, self._bgLayerY)),
                cc.CallFunc:create(function() isInitialized = true end)))
            return
        end

        self.bgLayer:stopAllActions()
        self.fgLayer:stopAllActions()
        -- 顺滑
        local circleAroundTest = self._bgLayerOldX * self._bgLayerX -- 检测接缝(从正最大值跳到副最大值时, 正*负=负, 大约-4500x4500)
        if  (not (circleAroundTest < -1000000)) and -- 并且避免在跨过正中线时误检测(最小正数跳到最小负数时, 也会发生 正*负=负, 但是这个数字比较小, 目前定为-1000x1000)
            ((self._bgLayerOldX - self._bgLayerX) * (self._bgLayerOldX - self._bgLayerX) + (self._bgLayerOldY - self._bgLayerY) * (self._bgLayerOldY - self._bgLayerY) > 12)
        then 
            self.bgLayer:runAction(cc.MoveTo:create(0.05, cc.p(self._bgLayerX, self._bgLayerY)))
            self.fgLayer:runAction(cc.MoveTo:create(0.05, cc.p(self._bgLayerX * seamCoverXSpeedFactor, self._bgLayerY * seamCoverYSpeedFactor)))
        else
            self.bgLayer:setPosition(self._bgLayerX, self._bgLayerY)
            self.fgLayer:setPosition(self._bgLayerX * seamCoverXSpeedFactor, self._bgLayerY * seamCoverYSpeedFactor)
        end

        -- 微动作单次更新限制为正负1以内, 总大小也限制为正负1以内
        local magDeltaX = (self._bgLayerX - self._bgLayerOldX) / (bgWidth / 2)
        if (magDeltaX > 1) then magDeltaX = 1 end
        if (magDeltaX < -1) then magDeltaX = -1 end 
        local magDeltaY = (self._bgLayerY - self._bgLayerOldY) / (bgHeight / 2)
        if (magDeltaY > 1) then magDeltaY = 1 end
        if (magDeltaY < -1) then magDeltaY = -1 end 

        -- 换画面的时候重置微动作
        local resetOffset = 100
        local resetTag = nil
        local isOffset = true
        for i=-3, 3 do
            local seamX = bgWidth * i - bgWidth / 2
            if (seamX - resetOffset > self._bgLayerOldX and seamX - resetOffset < self._bgLayerX) then
                magDeltaX = -1
                resetTag = i * -1
                isOffset = false
                break
            elseif (seamX + resetOffset < self._bgLayerOldX and seamX + resetOffset > self._bgLayerX) then
                magDeltaX = 1
                resetTag = i * -1 + 1
                isOffset = false
                break
            end
        end
        updateMicroMovement(magDeltaX, magDeltaY, resetTag, isOffset)
        if (resetTag == 2) then updateMicroMovement(magDeltaX, magDeltaY, -2, isOffset) end
        if (resetTag == -2) then updateMicroMovement(magDeltaX, magDeltaY, 2, isOffset) end

        self._bgLayerOldX = self._bgLayerX
        self._bgLayerOldY = self._bgLayerY

        --吹风音效
        if (-1000 < self._bgLayerX and 1000 > self._bgLayerX) then 
            self:playWindEnvSound()
        else
            self:stopWindEnvSound()
        end
        
    end, 0.05)
    self.fgLayer:setPosition(self._bgLayerX * seamCoverXSpeedFactor, self._bgLayerY * seamCoverYSpeedFactor)
    self.bgLayer:setPosition(self._bgLayerX, self._bgLayerY)


    -------------------------背景动画处理方法----------------------------
    local function clearClickCounter(self, args)
        local targets = args[1]
        for i,v in ipairs(targets) do v.__clickCount = 0 end
    end

    local function playAnimation(targets, ani, returnAni, isEnd)
        if (not ani or not returnAni) then return end

        -- 所有动画都可能是列表, 用本地变量来帮助做检查
        local resAni = ani
        local resReturnAni = returnAni

        -- 循环对每个目标设定指定的动画
        for i,v in ipairs(targets) do
            -- 如果指定动画是个列表, 随机选择动画
            if (type(ani) == "table") then resAni = ani[math.random(1, #ani)] end
            if (type(returnAni) == "table") then resReturnAni = returnAni[math.random(1, #clickReturnAni)] end

            -- 动画播放
            if (resAni) then 
                v:setAnimation(resAni, false)
            end

            -- 播放动画后回到指定动画状态
            if (resReturnAni) then 
                v:addAnimation(resReturnAni)
                v.__isEnded = isEnd
            end

            -- 设置打点音效
            v._spine:registerSpineEventHandler(function (event)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- TODO 播放音效文件
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playSound(soundFilename)
                    end
                end
            end, sp.EventType.ANIMATION_EVENT)
        end
    end

    -- 为所有牵连动画添加点击和连点播放动画
    local function addClickPlayAnimation(clickAni, clickReturnAni, multiClickAni, multiClickReturnAni, isClickEnd, isMultiClickEnd, ...)
        local targets = {...}
        for i,target in ipairs(targets) do
            target.__animationStatus = {}
            target:setTouchEnable(true)
            target:addEventListener(UIEvent.COMPONENT_CLICK, target, function()
                -- 1秒内连点记录点击次数并在未点击1秒后清零
                if (Avalon.Scheduler:hasScheduledUpdateOnce(self, clearClickCounter) == 0) then
                    Avalon.Scheduler:setDelayForUpdateOnce(self, clearClickCounter, 1, targets)
                end

                -- 循环记录所有牵连动画的计算点击次数
                local multiClickCounted = false
                for i,v in ipairs(targets) do
                    -- 累计点击次数
                    v.__clickCount = (v.__clickCount or 0) + 1
                    -- 如果大于等于3次, 设置成功检测多次点击
                    if (v.__clickCount >= 3) then multiClickCounted = true end
                    -- 单次点击和多次点击动画播放条件条件: 
                    --      1. 单机动画没有已经在播放 并且 动画没有被标识为完毕
                    --      2. 多次点击被激活 并且 多击动画没有已经在播放 并且 没有被标识为完毕
                    -- 否则什么都不做直接返回 = 点击无效
                    if ((not (v.__animationStatus[clickAni] == "started") and not v.__isEnded) or 
                        (multiClickCounted and not (v.__animationStatus[multiClickAni] == "started") and not v.__isEnded))
                    then else
                        return 
                    end
                end

                -- 单点和连点对应处理
                if (not multiClickCounted) then
                    playAnimation(targets, clickAni, clickReturnAni, isClickEnd)
                else
                    playAnimation(targets, multiClickAni, multiClickReturnAni, isMultiClickEnd)
                end
            end)

            -- 注册动画开始回调
            target._spine:registerSpineEventHandler(function(event)
                target.__animationStatus[event.animation] = "started"
            end, 0)

            -- 注册动画结束回调
            target._spine:registerSpineEventHandler(function(event)
                target.__animationStatus[event.animation] = "ended"
            end, 1)
        end
    end

    local function addClickEffectArea(host, width, height, x, y, areaZ, displayZ, displayName, aniName, removeDelay)
        -- 设置点击检测区域
        local clickArea = UI.Component:create()
        clickArea:init()
        clickArea:setSize(width, height)
        clickArea:leftBottom(size.width/2 + x - clickArea._hw, size.height/2 + y - clickArea._hh)
        host:addChild(clickArea, areaZ)
        clickArea:setTouchEnable(true)
        clickArea:setSwallowTouches(false)
        clickArea:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, target, pos)
            -- 触发点击效果 --
            local localPos = host:convertToNodeSpace(pos)
            local clickEffect = UI.Animation:create()
            clickEffect:init(""..displayName..".json", ""..displayName..".atlas", 1)
            clickEffect:setAnimation(aniName, false)
            clickEffect:leftBottom(localPos.x, localPos.y)
            -- 设置打点音效
            clickEffect._spine:registerSpineEventHandler(function (event)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- TODO 播放音效文件
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playSound(soundFilename)
                    end
                end
            end, sp.EventType.ANIMATION_EVENT)
            host:addChild(clickEffect, displayZ)
            Avalon.Scheduler:scheduleUpdateOnce(clickEffect, function() host:removeChild(clickEffect) end, removeDelay)
        end)
    end

    local function addRandomTargetAnimation(ani, returnAni, interval, func, ...)
        local targets = {...}
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            target = targets[math.random(1, #targets)]
            playAnimation({target}, ani, returnAni)
            if (func) then func() end
            addRandomTargetAnimation(ani, returnAni, interval, func, unpack(targets))
        end, interval)
    end

    -------------------------背景动画----------------------------
    require "app.ui.common.Animation"

    -- LOGO 藤蔓 双份(在接缝上) --
    local ani1 = UI.Animation:create()
    ani1:init("loadingbg_logotengman.json", "loadingbg_logotengman.atlas", 1, true)
    ani1:setSize(700, 1400)
    ani1:setAnimation("idle", true)
    ani1:leftBottom(size.width/2 - 2330 - ani1._hw, size.height/2 - 320 - ani1._hh)
    self.bgLayer:addChild(ani1, BG_ANIMATION_Z)
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_logotengman.json", "loadingbg_logotengman.atlas", 1, true)
    ani2:setSize(700, 1400)
    ani2:setAnimation("idle", true)
    ani2:leftBottom(size.width/2 + 2215 - ani2._hw, size.height/2 - 320 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle", nil, nil, false, false, ani1, ani2)

    -- 宝箱 双份(在接缝上) --
    local ani1 = UI.Animation:create()
    ani1:init("loadingbg_baoxiang.json", "loadingbg_baoxiang.atlas", 1, true)
    ani1:setSize(300, 400)
    ani1:setAnimation("idle", true)
    ani1:leftBottom(size.width/2 - 2360 - ani1._hw, size.height/2 - 390 - ani1._hh)
    self.bgLayer:addChild(ani1, BG_ANIMATION_Z)
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_baoxiang.json", "loadingbg_baoxiang.atlas", 1, true)
    ani2:setSize(300, 400)
    ani2:setAnimation("idle", true)
    ani2:leftBottom(size.width/2 + 2185 - ani2._hw, size.height/2 - 390 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle", "trigger2", "end", false, true, ani1, ani2)

    -- 火把左 双份(在接缝上) --
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setScaleX(-1)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 2730, size.height/2 + 200)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z - 1)
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setScaleX(-1)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 + 1815, size.height/2 + 200)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z - 1)

    -- 火把右 双份(在接缝上) --
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 1780, size.height/2 + 200)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 + 2765, size.height/2 + 200)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)

    -- 水管 双份(在接缝上)--
    local ani = UI.Animation:create()
    ani:init("loadingbg_sewage_conduit.json", "loadingbg_sewage_conduit.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 1275, size.height/2 - 420)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z + 2)
    local ani = UI.Animation:create()
    ani:init("loadingbg_sewage_conduit.json", "loadingbg_sewage_conduit.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 + 3270, size.height/2 - 420)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z + 2)
    -- 添加爆泥点击特效 --
    addClickEffectArea(
        self.bgLayer,                       -- 宿主图层
        95, 150,                             -- 宽, 高
        -1360, 10,                          -- 坐标
        BG_FGPARTS_Z + 2, BG_FGPARTS_Z + 2, -- 检测层Z, 显示层Z
        "loadingbg_spot", "trigger1",       -- Spine特效名字, 动画名字
        2)                                  -- 延迟删除时间

    -- 泥潭 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_blood_tooth.json", "loadingbg_blood_tooth.atlas", 1.25, true)
    ani:setSize(150, 200)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 1490 - ani._hw, size.height/2 - 295 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger2", "idle", nil, nil, false, false, ani)
    -- 添加爆泥点击特效 --
    addClickEffectArea(
        self.bgLayer,                       -- 宿主图层
        620, 80,                            -- 宽, 高
        -1275, -315,                        -- 坐标
        BG_FGPARTS_Z + 2, BG_FGPARTS_Z + 2, -- 检测层Z, 显示层Z
        "loadingbg_spot", "trigger1",       -- Spine特效名字, 动画名字
        2)                                  -- 延迟删除时间

    -- 泥人 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_the_mud.json", "loadingbg_the_mud.atlas", 1, true)
    ani:setSize(250, 50)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 1200 - ani._hw, size.height/2 - 300 - ani._hh)
    self.bgLayer:addChild(ani, BG_FGPARTS_Z + 1)
    addClickPlayAnimation("trigger1", "end", nil, nil, true, false, ani)

    -- 蝙蝠3个 --
    local ani1 = UI.Animation:create()
    ani1:init("loadingbg_fire_bat.json", "loadingbg_fire_bat.atlas", 1, true)
    ani1:setSize(50, 50)
    ani1:setAnimation("idle", true)
    ani1:leftBottom(size.width/2 - 1510 - ani1._hw, size.height/2 + 535 - ani1._hh)
    self.bgLayer:addChild(ani1, BG_BGPARTS_Z + 1)
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_fire_bat.json", "loadingbg_fire_bat.atlas", 1, true)
    ani2:setScale(2.2)
    ani2:setSize(50, 50)
    ani2:setAnimation("idle", true)
    ani2:leftBottom(size.width/2 - 1440 - ani2._hw, size.height/2 + 520 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_BGPARTS_Z + 1)
    local ani3 = UI.Animation:create()
    ani3:init("loadingbg_fire_bat.json", "loadingbg_fire_bat.atlas", 1, true)
    ani2:setScale(1.8)
    ani3:setSize(50, 50)
    ani3:setAnimation("idle", true)
    ani3:leftBottom(size.width/2 - 1370 - ani3._hw, size.height/2 + 525 - ani3._hh)
    self.bgLayer:addChild(ani3, BG_BGPARTS_Z + 1)
    addClickPlayAnimation({"trigger1", "trigger2", "trigger3"}, "end", nil, nil, true, false, ani1, ani2, ani3)

    -- 月光宝盒 --
    local clickBoxOffsetX, clickBoxOffsetY = 130, -800
    local ani = UI.Animation:create()
    ani:init("loadingbg_left_beam.json", "loadingbg_left_beam.atlas", 1, true)
    ani:setSize(60, 80)
    ani:setAnimation("idle1", true)
    ani:setInnerOffset(clickBoxOffsetX, clickBoxOffsetY)
    ani:leftBottom(size.width/2 - 785 - ani._hw - clickBoxOffsetX, size.height/2 - 290 - ani._hh - clickBoxOffsetY)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", "trigger2", "end", false, true, ani)

    -- 皇冠骷髅头 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_skeleton_head.json", "loadingbg_skeleton_head.atlas", 1, true)
    ani:setSize(250, 250)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 666 - ani._hw, size.height/2 + 54 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle", nil, nil, false, false, ani)

    -- 蝙蝠2个 --
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_fire_bat.json", "loadingbg_fire_bat.atlas", 1, true)
    ani2:setScale(2.2)
    ani2:setSize(50, 50)
    ani2:setAnimation("idle", true)
    ani2:leftBottom(size.width/2 - 640 - ani2._hw, size.height/2 + 520 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_BGPARTS_Z + 1)
    local ani3 = UI.Animation:create()
    ani3:init("loadingbg_fire_bat.json", "loadingbg_fire_bat.atlas", 1, true)
    ani2:setScale(1.8)
    ani3:setSize(50, 50)
    ani3:setAnimation("idle", true)
    ani3:leftBottom(size.width/2 - 570 - ani3._hw, size.height/2 + 525 - ani3._hh)
    self.bgLayer:addChild(ani3, BG_BGPARTS_Z + 1)
    addClickPlayAnimation({"trigger1", "trigger2", "trigger3"}, "end", nil, nil, true, false, ani2, ani3)

    -- 火把左 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 422, size.height/2 + 190)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z - 1)

    -- 中央油灯 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_light.json", "loadingbg_light.atlas", 1, true)
    ani:setSize(100, 280)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 75 - ani._hw, size.height/2 + 474 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle", nil, nil, false, false, ani)

    -- 中央背景 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_scene.json", "loadingbg_scene.atlas", 1.5, true)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 - 60, size.height/2 - 270)
    self.bgLayer:addChild(ani, BG_BGIMAGE_Z - 3)

    -- 人物阴影 --
    local heroAni = UI.Animation:create()
    heroAni:init("loadingbg_hero.json", "loadingbg_hero.atlas", 1, true)
    heroAni:setAnimation("idle", true)
    heroAni:leftBottom(size.width/2 - 400, size.height/2 - 210)
    self.bgLayer:addChild(heroAni, BG_BGIMAGE_Z - 2)
    -- 循环播放英雄跑动动画
    addRandomTargetAnimation("trigger1", "idle", 15, function() 
        -- 判断英雄方向
        local direction
        if (heroAni:getScaleX() > 0) then direction = 1 else direction = -1 end
        -- 转变英雄动画方向
        heroAni:setScaleX(heroAni:getScaleX() * -1)
        -- 根据方向做位移, 位移完成后设置英雄跑动标签为否
        heroAni:runAction(cc.MoveBy:create(1, cc.p(700 * direction, 0)))
    end, heroAni)

    -- -- 中央花草 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_mid_tree.json", "loadingbg_mid_tree.atlas", 1, true)
    ani:setSize(600, 600)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 - 101 - ani._hw, size.height/2 + 25 - ani._hh)
    self.bgLayer:addChild(ani, BG_BGIMAGE_Z - 1)
    addClickPlayAnimation("trigger1", "idle1", nil, nil, false, false, ani)
    -- 添加点击花草英雄跑过动画
    ani:addEventListener(UIEvent.COMPONENT_CLICK, heroAni, function()
        -- 如果英雄在跑动则不做任何事情
        if (heroAni.__isRunning) then return end
        -- 判断英雄方向
        local direction
        if (heroAni:getScaleX() > 0) then direction = 1 else direction = -1 end
        -- 循环播放英雄跑动动画
        playAnimation({heroAni}, "trigger1", "idle")
        -- 转变英雄动画方向
        heroAni:setScaleX(heroAni:getScaleX() * -1)
        -- 根据方向做位移, 位移完成后设置英雄跑动标签为否
        heroAni:runAction(cc.Sequence:create(
            cc.MoveBy:create(1, cc.p(700 * direction, 0)), 
            cc.CallFunc:create(function() heroAni.__isRunning = false end)))
        -- 设置英雄跑动标签为是
        heroAni.__isRunning = true
    end)

    -- 中央倒挂人物 --
    local ani1 = UI.Animation:create()
    ani1:init("loadingbg_mid_acanthuridae.json", "loadingbg_mid_acanthuridae.atlas", 1, true)
    ani1:setAnimation("idle1", true)
    ani1:leftBottom(size.width/2 - 330 - ani1._hw, size.height/2 - 60 - ani1._hh)
    self.bgLayer:addChild(ani1, BG_BGIMAGE_Z - 1)
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_mid_acanthuridae.json", "loadingbg_mid_acanthuridae.atlas", 1, true)
    ani2:setAnimation("idle1", true)
    ani2:leftBottom(size.width/2 - 130 - ani2._hw, size.height/2 + 100 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_BGIMAGE_Z - 1)
    -- local ani3 = UI.Animation:create()
    -- ani3:init("loadingbg_mid_acanthuridae.json", "loadingbg_mid_acanthuridae.atlas", 1, true)
    -- ani3:setAnimation("idle1", true)
    -- ani3:leftBottom(size.width/2 + 60 - ani3._hw, size.height/2 - 15 - ani3._hh)
    -- self.bgLayer:addChild(ani3, BG_BGIMAGE_Z - 1)
    addRandomTargetAnimation("trigger1", "idle1", 6, nil, ani1, ani2)

    -- 火把左 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire.json", "loadingbg_fire.atlas", 1, true)
    ani:setAnimation("idle", true)
    ani:setScaleX(-1)
    ani:leftBottom(size.width/2 + 270, size.height/2 + 190)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z - 1)

    -- 水晶1 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_mid_crystal01.json", "loadingbg_mid_crystal01.atlas", 1, true)
    ani:setSize(80, 120)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 + 405 - ani._hw, size.height/2 - 275 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", "trigger2", "end", false, true, ani)

    -- 水晶2 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_mid_crystal02.json", "loadingbg_mid_crystal02.atlas", 1, true)
    ani:setSize(80, 120)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 + 845 - ani._hw, size.height/2 - 328 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", "trigger2", "end", false, true, ani)

    -- 水晶4 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_mid_crystal04.json", "loadingbg_mid_crystal04.atlas", 1, true)
    ani:setSize(80, 120)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 + 377 - ani._hw, size.height/2 - 5 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", "trigger2", "end", false, true, ani)

    -- 水晶5 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_mid_crystal05.json", "loadingbg_mid_crystal05.atlas", 1, true)
    ani:setSize(80, 120)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 - 440 - ani._hw, size.height/2 - 155 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", "trigger2", "end", false, true, ani)

    -- 皇冠骷髅头 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_woodcard.json", "loadingbg_woodcard.atlas", 1, true)
    ani:setSize(300, 450)
    ani:setAnimation("idle", true)
    ani:leftBottom(size.width/2 + 605 - ani._hw, size.height/2 + 230 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "end", nil, nil, true, false, ani)

    -- 蜘蛛网 --
    local ani = UI.Animation:create()
    ani:init("loadingbg_fire_spider.json", "loadingbg_fire_spider.atlas", 1.7, true)
    ani:setSize(300, 300)
    ani:setAnimation("idle1", true)
    ani:leftBottom(size.width/2 + 730 - ani._hw, size.height/2 + 485 - ani._hh)
    self.bgLayer:addChild(ani, BG_ANIMATION_Z)
    addClickPlayAnimation("trigger1", "idle1", nil, nil, false, false, ani)

    -- 水晶藤蔓 双份(在接缝上) --
    local ani1 = UI.Animation:create()
    ani1:init("loadingbg_right_tengman.json", "loadingbg_right_tengman.atlas", 1, true)
    ani1:setSize(900, 1100)
    ani1:setAnimation("idle1", true)
    ani1:leftBottom(size.width/2 - 3150 - ani1._hw, size.height/2 - 350 - ani1._hh)
    self.bgLayer:addChild(ani1, BG_ANIMATION_Z - 1)
    local ani2 = UI.Animation:create()
    ani2:init("loadingbg_right_tengman.json", "loadingbg_right_tengman.atlas", 1, true)
    ani2:setSize(900, 1100)
    ani2:setAnimation("idle1", true)
    ani2:leftBottom(size.width/2 + 1395 - ani2._hw, size.height/2 - 350 - ani2._hh)
    self.bgLayer:addChild(ani2, BG_ANIMATION_Z - 1)
    addClickPlayAnimation("trigger1", "idle1", nil, nil, false, false, ani1, ani2)

    self:playWaterDropEnvSound()
    self:playWindEnvSound()
end

function MainLayerBackground:playWaterDropEnvSound()
    if (self._waterDropPlaying or self.isSoundOff) then return end
    self._waterDropPlaying = true
    self:playWaterDropEnvSoundRepeatedly()
end

function MainLayerBackground:playWaterDropEnvSoundRepeatedly()
    if (self._waterDropHandle) then Avalon.AudioManager:stopSound(self._waterDropHandle) end
    self._waterDropHandle = Avalon.AudioManager:playSound("1014")

    local delayPlayAction = cc.Sequence:create(
        cc.DelayTime:create(math.random(3, 12)), 
        cc.CallFunc:create(function()
            self:playWaterDropEnvSoundRepeatedly()
        end))
    delayPlayAction:setTag(11101)
    self:runAction(delayPlayAction)
end

function MainLayerBackground:stopWaterDropEnvSound()
    self:stopActionByTag(11101)
    if (self._waterDropHandle) then 
        Avalon.AudioManager:stopSound(self._waterDropHandle) 
        self._waterDropHandle = nil
    end
    self._waterDropPlaying = false
end




function MainLayerBackground:playWindEnvSound()
    if (self._windSoundHandle) then return end
    self._windSoundHandle = Avalon.AudioManager:playSound("1039", true)
end

function MainLayerBackground:stopWindEnvSound()
    if (self._windSoundHandle) then Avalon.AudioManager:stopSound(self._windSoundHandle) end
    self._windSoundHandle = nil
end

function MainLayerBackground:centerCamera(isSoundOff, isResumeMoveAfter, callback)
    if (isResumeMoveAfter == nil) then isResumeMoveAfter = true end
    self.isSoundOff = isSoundOff or false

    self:setEnableMove(false)
    self.bgLayer:stopAllActions()
    self.fgLayer:stopAllActions()
    if (self.isSoundOff) then
        self:mute()
    end    

    local timeFactor = math.abs((self._bgLayerX - self._initX) / (self._bgWidth * 2))
    local moveDuration = 0.4 * timeFactor
    
    self._bgLayerX = self._initX
    self._bgLayerOldX = self._bgLayerX
    self._bgLayerY = self._initY
    self._bgLayerOldY = self._bgLayerY
    self._updateMicroMovement(0, 0, nil, false)
    self.bgLayer:runAction(cc.EaseQuadraticActionInOut:create(cc.MoveTo:create(moveDuration, cc.p(self._bgLayerX, self._bgLayerY))))
    self.fgLayer:runAction(cc.EaseQuadraticActionInOut:create(cc.MoveTo:create(moveDuration, cc.p(self._bgLayerX * self._seamCoverXSpeedFactor, self._bgLayerY * self._seamCoverYSpeedFactor))))

    performWithDelay(self, function()
        if (callback) then callback() end
    end, moveDuration + 0.1)

    performWithDelay(self, function() 
        if (isResumeMoveAfter) then self:setEnableMove(true) end
    end, moveDuration + 3)
end

function MainLayerBackground:setEnableMove(enableMove)
    self.enableMove = enableMove
end

function MainLayerBackground:mute()
    self:stopWindEnvSound()
    self:stopWaterDropEnvSound()
end


