--[[
    -- CaveBackGround.lua
    -- Author:ydli
    -- 2018年3月5日
    洞窟地图 背景漂浮物层级
    实现目的：显示地图下层的漂浮物体（包括 云朵、碎石，体块），并实现旋转 缩放 和 X，Y轴的移动
    实现步骤：初始化时
            1、随机产生 云朵（位置可以固定住）
            2、随机出漂浮物数量
            3、随机出漂浮物发射点（批量随机），（不止包含四个角点 还包含四条边线 但可以是大地图内）
            4、漂浮物数量分配给 每个发射点
            5、给每个发射点产生的漂浮物体 随机动画和动画对应的数值（可以是复合动画）
            初始化后：
            1、每秒刷新（或者多秒可配）
            2、补足漂浮物数量（即上限 减去 当前数量）
            3  随机出漂浮物发射点 （不止包含四个角点 还包含四条边线 但必须是大地图外）
            4、给每个发射点产生的漂浮物体 随机动画和动画对应的数值（可以是复合动画）
    风险点：1、随机次数比较多，能否一次随机出多个值
           2、图片精灵比较多：能否优化显示

]]
UI = UI or {}
local SuspendedSprite = require "app.battle.SuspendedSprite"
local CaveBackGround = class("CaveBackGround", UI.HWBtnComponent)
UI.CaveBackGround = CaveBackGround
local winSize = cc.Director:getInstance():getWinSize()
local COM_RES_LIST = {
    "ui_map_background.plist"
}

local cloudRes = {
    "map_background_1.png",
    "map_background_2.png",
    "map_background_3.png"
}

-- public:
-- 构造函数
function CaveBackGround:ctor()
    --窗口大小
    CaveBackGround.super.ctor(
    self,UIType.TOP_ACTIVITY_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CUSTOM_FLOAT_SWITCH, self, self.floatSwitch)
end

-- 销毁
function CaveBackGround:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CUSTOM_FLOAT_SWITCH, self, self.floatSwitch)

    CaveBackGround.super.dtor(self)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- 初始化
function CaveBackGround:init(map)
    self.blankTileNum = 0 --地图空白格子
    self.initGeneratePosList = {}  --初始化的发射器
    self.susSpriteCache = {}
    self.susSpriteCacheNumber = 0 --漂浮物数量
    self.susSpriteMaxKey = 0 -- 漂浮 hash数组 key

    self.cloudList = {}

    self._map = map--地图数据
    self._suspendedCfgList = self._map.mapData.suspendedCfgList --漂浮物配置表list
    local suspendedNumLimitArray = string.split(self._map.mapData.appearanceConfig.suspendedMatterNum, ",") --
    self._suspendedNumLimit = math.random(20, 30)--漂浮物 数量最大值
    
    self.mapWidth = self._map:getContentSize().width + winSize.width
    self.mapHeight = self._map:getContentSize().height + winSize.height
    self.tileSizeX = math.ceil(self.mapWidth / self._map.tileWidth)
    self.tileSizeY = math.ceil(self.mapHeight / self._map.tileHeight)

    local posX, posY = self._map:coordinateToPosition(self.tileSizeX, self.tileSizeY)
    print("posX, posY = ",posX, posY)

    local blankX = math.ceil(self._map:getContentSize().width / self._map.tileWidth / 2)
    local blankY = math.ceil(self._map:getContentSize().height / self._map.tileHeight / 2)
    self.blankTileNum = blankX > blankY and blankX or blankY
    print("------- self.blankTileNum = ",  self.blankTileNum, self.mapWidth, self.mapHeight, self._map.tileWidth, self._map.tileHeight, self._map.sizeX, self._map.sizeY)
    CaveBackGround.super.init(self)
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 0.25, false)
end

-- 模版函数：初始化组建的视图(必备)
function CaveBackGround:onInitView()
    print("------CaveBackGround:onInitView")
    -- local view = cc.LayerColor:create(cc.c4b(255,0,0,255))
    -- -- view:setContentSize(cc.size(self.mapWidth, self.mapHeight))
    -- view:setContentSize(self.mapWidth, self.mapHeight)
    -- view:setPosition(0,0)
    

    local view = UI.Layout:create()
    view:init()
    view:setSize(self.mapWidth, self.mapHeight)
    view:centerBottom(-120)
    self:addChild(view)
    self.rootLayer = view
    -- view:enableDebugDraw()
end

-- 模版函数：更新组建的视图(必备)
function CaveBackGround:onUpdateView()
    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        if self.delayUpdateView then
            self:delayUpdateView()
        end
    end, 1)
end

-- local count = 0
-- local totalDt = 0
function CaveBackGround:update(dt)
    -- count = count + 1
    -- totalDt = totalDt + dt
    -- if count < 2 then
    --     return
    -- end
    -- count = 0
    local changeNumber = 0
    if self.susSpriteMaxKey > 2100000000 then--key 值超出最大值从头计算
        self.susSpriteMaxKey = 1
    end
    for k, v in pairs(self.susSpriteCache) do
        --更新存在
        -- local isDestory = v:update(totalDt)
        local isDestory = v:update(dt)
        if isDestory then
            --更新存在
            self:removeSusSprite(k)
            v:destory()
            changeNumber = changeNumber + 1
        else
            --更新显示, 优化GPU 0.6ms
            v:fade(not self:checkIsObjOnMap(v))
        end
    end

    if changeNumber > 0 then
        self:generateSimpleSus(changeNumber)
    end

    -- 更新云朵存在
    for i,v in ipairs(self.cloudList) do
        if (self:checkIsObjOnMap(v) and not v.__OnMap) then
            v.__OnMap = true
            v:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function() v:setVisible(false) end)))
        elseif (v.__OnMap) then
            v.__OnMap = false
            v:setVisible(true)
            v:runAction(cc.FadeIn:create(0.5))
        end
    end
    -- totalDt = 0
end

function CaveBackGround:updateMapMove(offsetX, offsetY)
    if(self._cloudLayer) then 
        local bgfxPosX, bgfxPosY = self._cloudLayer:getPosition()
        self._cloudLayer:setPosition(bgfxPosX + offsetX * -0.5, bgfxPosY + offsetY * -0.5)
    end
end

function CaveBackGround:delayUpdateView()   
    self:generateCloundPosList()
    self:generateCloud()

    local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.FLOATS)
    if setting then
        self:generateInitSus()
    end
    self:generateSusPosList()
end

function CaveBackGround:generateCloundPosList()
    for i = 0, self.tileSizeX do
        for j = 0, self.tileSizeY do
            if (i <=  self.blankTileNum or i >= self.tileSizeX -  self.blankTileNum) or (j <=  self.blankTileNum or j >= self.tileSizeY -  self.blankTileNum) then
                if (i + j) % 10 == 0 then
                    table.insert(self.initGeneratePosList, {i, j})
                end
            end
        end
    end
    -- local tileSizeCenterX = self.tileSizeX / 2
    -- local tileSizeCenterY = self.tileSizeY / 2
    -- table.sort(self.initGeneratePosList, function(a, b)
    --     local disA = math.abs((a[1] - tileSizeCenterX) * (a[2] - tileSizeCenterY))
    --     local disB = math.abs((b[1] - tileSizeCenterX) * (b[2] - tileSizeCenterY))
    --     return  disA < disB
    -- end)
end

function CaveBackGround:generateSusPosList()
    self.initGeneratePosList = {}
    for i = 0, self.tileSizeX do
        for j = 0, self.tileSizeY do
            if (i <=  1 or j <= 1) then
                if (i + j) % 2 == 0 then
                    table.insert(self.initGeneratePosList, {i, j})
                end
            end
        end
    end
end

--产生云朵  地图边缘往内 三个地块位置 都是云朵产生点 
function CaveBackGround:generateCloud()
    print("------CaveBackGround:generateCloud")
    self._cloudLayer = cc.Node:create()
    self.rootLayer:addChild(self._cloudLayer)

    local modeSize =  self.blankTileNum * 2
    local modeNum = math.random(1, modeSize)
    local totalList = {}
    for k, v in ipairs(self.initGeneratePosList) do
        local localPosX = v[1] * self._map.tileWidth
        local localPosY = v[2] * self._map.tileHeight
        local worldPos = self.rootLayer:convertToWorldSpace(cc.p(localPosX, localPosY))
        if (not self._map:checkIsWorldPositionOnMap(worldPos.x, worldPos.y)) then --被地图挡住不显示, 优化GPU 0.6MS
            local index = k % #cloudRes + 1
            local cloud = cc.Sprite:create()
            -- print("----cloudRes[index] = ", index, cloudRes[index], v[1] * self._map.tileWidth, v[2] * self._map.tileHeight)
            cloud:initWithSpriteFrameName(cloudRes[index])
            cloud:setPosition(localPosX, localPosY)
            cloud:setScale(1.2)
            table.insert(self.cloudList, cloud)
            self._cloudLayer:addChild(cloud)

            if (v[1] + v[2]) % 4 == 0 then
                local time = (v[1] + v[2]) % 3 + 1
                local fadeInAction = cc.FadeTo:create(time, 255)
                local fadeOutAction = cc.FadeTo:create(time, 60)
                local scaleInAction = cc.ScaleTo:create(time, 1.2)
                local scaleOutAction = cc.ScaleTo:create(time, 1)
                local inAction = cc.Spawn:create(fadeInAction, scaleInAction)
                local outAction = cc.Spawn:create(fadeOutAction, scaleOutAction)
                local delayAction = cc.DelayTime:create(0.5)
                cloud:runAction(cc.RepeatForever:create(cc.Sequence:create(inAction, delayAction, outAction, delayAction)))
            end
        end
    end
end

--产生初始化悬浮物 
function CaveBackGround:generateInitSus()
    -- dump(self._suspendedCfgList, "-----self._suspendedCfgList")
    if self._suspendedNumLimit <= 0 then
        return
    end
    local limitSize = self._suspendedNumLimit
    local mode = 1
    if limitSize < #self.initGeneratePosList then
        mode = math.ceil(#self.initGeneratePosList / limitSize)
    end 
    for i = 1, limitSize do
        local posIndex = 0
        if mode == 1 then
            posIndex = i % #self.initGeneratePosList + 1
        else
            posIndex = (i % #self.initGeneratePosList * mode) + 1 
            posIndex = posIndex > #self.initGeneratePosList and #self.initGeneratePosList or posIndex
        end
        local resIndex = i % #self._suspendedCfgList + 1
        self:createSusSprite(self._suspendedCfgList[resIndex], self.initGeneratePosList[posIndex])
    end
end

--产生运行过程中悬浮物（漂浮物初始化创建后 有销毁 就得有补充）
-- 
function CaveBackGround:generateSimpleSus(number)
    for i = 1, number do
        -- math.randomseed(tostring(AvalonUtil.getCurrentTime()):reverse():sub(1, 6) * i )
        local posIndex = math.random(1, #self.initGeneratePosList)
        -- local resIndex = posIndex % #self._suspendedCfgList + 1
        local resIndex = math.random(1, #self._suspendedCfgList)
        self:_createSusSprite(resIndex, self._suspendedCfgList[resIndex])
    end
end

function CaveBackGround:createSusSprite(suspendedCfgData, coordPos)
    -- print("---------------:createSusSprite()")
    if suspendedCfgData == nil then
        print("----error ----- CaveBackGround:createSusSprite suspendedCfgData is nil ")
        return
    end 

    self:_createSusSprite(0, suspendedCfgData, coordPos[1] * self._map.tileWidth, coordPos[2] * self._map.tileHeight)
end

function CaveBackGround:_createSusSprite(index, suspendedCfgData, posX, posY)
    local sprite = SuspendedSprite:create()
    sprite:initWithSpriteFrameName(suspendedCfgData.suspendedMatterName)
    local point = self.rootLayer:convertToWorldSpace(cc.p(0, 0))
    if posX == nil or posY == nil then
        if index % 2 == 1 then
            posX  = sprite:getContentSize().width * -1 - point.x
            posY = math.random(0, winSize.height)  - point.y
        else
            posX = math.random(0, winSize.width)  - point.x
            posY = -point.y
        end
    end
    sprite:setPosition(posX, posY)
    self.rootLayer:addChild(sprite)

    local totalDis = (self.mapWidth + self.mapHeight) / 2
    sprite:initParams(suspendedCfgData, totalDis)

    local fadeInAction = cc.FadeTo:create(0.5, 255)
    sprite:setOpacity(10)
    sprite:runAction(fadeInAction)
    sprite:setVisible(not self:checkIsObjOnMap(sprite))
    self:addSusSprite(sprite)
end

function CaveBackGround:addSusSprite(sprite)
    self.susSpriteCacheNumber = self.susSpriteCacheNumber + 1
    self.susSpriteMaxKey = self.susSpriteMaxKey + 1
    sprite:setTag(self.susSpriteMaxKey)
    -- print("---------------:addSusSprite() key = "..self.susSpriteMaxKey)
    -- self.susSpriteMaxKey = 1
    if self.susSpriteCache[self.susSpriteMaxKey] ~= nil then -- key  碰撞了 清除旧key 加入新的
        self.susSpriteCache[self.susSpriteMaxKey]:removeFromParent()
        self.susSpriteCacheNumber = self.susSpriteCacheNumber - 1
    end
    table.insert(self.susSpriteCache, self.susSpriteMaxKey, sprite)
end

function CaveBackGround:removeSusSprite(key)
    -- print("---------------removeSusSprite() key = "..key)
    self.susSpriteCacheNumber = self.susSpriteCacheNumber - 1
    if self.susSpriteCache[key] ~= nil then
        -- table.remove(self.susSpriteCache, key)
        self.susSpriteCache[key] = nil
    end
        

end

function CaveBackGround:floatSwitch(switchOn)
    if switchOn == nil then
        return
    end

    if switchOn then
        -- 显示
        if self.susSpriteCacheNumber == 0 then
            self:generateInitSus()
        end
    else
        -- 隐藏
        for k, v in pairs(self.susSpriteCache) do
            self:removeSusSprite(k)
            v:destory()
        end
    end
end


function CaveBackGround:checkIsObjOnMap(v)
    local localPosX, localPosY = v:getPosition()
    local worldPos = self.rootLayer:convertToWorldSpace(cc.p(localPosX, localPosY))
    local isOnMap = self._map:checkIsWorldPositionOnMap(worldPos.x, worldPos.y)
    return isOnMap
end