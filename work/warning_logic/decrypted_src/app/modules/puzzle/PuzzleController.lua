--[[--
控制器PuzzleController，view已经注入,可以通过mvc.puzzleProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: hongyi.yan
-- date	: 2020/08/03
-- desc	: 
------------------------------------------------------------------------------
local PuzzleController = class("PuzzleController", mvc.GameController)
local ProtobufUtil = require("utils.ProtobufUtil")
local SceneManager = require("app.game.SceneManager")
local MapDefine = require "app.mapkit.MapDefine"
local MachineManager = require("app.game.MachineManager")

local MAP_STATE = {
    CLOSE = 1,
    OPEN = 2,
    OVER = 3,
}

-- mvc.events.Puzzle_Click_Item 处理函数
function PuzzleController:noticePuzzleClickItem(notification, coordX, coordY, touchPosition, tileData)

    if not tileData then
        printInfo("not tileData")
        return
    end
    -- 地块类型不正确
    if tileData:getTerrainType() ~= MapDefine.TerrainType.Ground then
        printInfo("not Ground")
        return
    end
    -- 不在规定范围内
    if coordX < 3 or coordX > 8 or coordY < 1 or coordY > 5 then
        printInfo("not inner")
        return
    end

    -- 获取地块信息
    local mapInfo = mvc.puzzleModel:getMapInfo(coordX, coordY)

    -- 地块上面没东西或是已经被打开
    if not mapInfo or mapInfo.state == MAP_STATE.OPEN or mapInfo.state == MAP_STATE.OVER then
        printInfo("not mapInfo or isOpen or isOver")
        return
    end

    -- 不能点击
    if mvc.puzzleModel:getLockClick() then
        UI.ScrollBar:createByText(UI.TEXT_1324400)
        return
    end

    mvc.puzzleModel:setLockClick(true)

    -- 开箱效果
    self:openBoxAnimation(mapInfo.boxSpriteID)

    -- 获取等待协对的怪物信息
    local otherMonsterInfo = mvc.puzzleModel:getOtherMonsterInfo()
    if otherMonsterInfo then
        local otherMapInfo = mvc.puzzleModel:getMapInfo(otherMonsterInfo.coordX, otherMonsterInfo.coordY)
        if otherMapInfo.monsterTemplateID == mapInfo.monsterTemplateID then
            self:successPaired(coordX, coordY)
        else
            self:failPaired(coordX, coordY)
        end
    else
        self:addOtherMonsterInfo(coordX, coordY)
    end
end



-- 箱子打开
function PuzzleController:openBoxAnimation(boxSpriteID)
    -- 箱子打开效果
    local data = {
        spriteID = boxSpriteID,
        animationNames = {{"open1", false}}
    }
    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_ROLE_ANIMATIONS_BY_SPRITEID, data)
    SceneManager:getInstance():pushCommand(command)
end



-- 添加怪物
function PuzzleController:createMonster(coordX, coordY)
    local mapInfo = mvc.puzzleModel:getMapInfo(coordX, coordY)
    -- 获取怪物模版
    local monsterTemplate = clone(mvc.puzzleModel:getMonsterTemplate())
    monsterTemplate.monsterID = mapInfo.monsterTemplateID
    monsterTemplate.spriteID = mapInfo.monsterSpriteID
    monsterTemplate.coordX = coordX
    monsterTemplate.coordY = coordY

    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_SCREENMONSTER, monsterTemplate)
    SceneManager:getInstance():pushCommand(command)
end



-- 配对成功
function PuzzleController:successPaired(coordX, coordY)
    local delayTime = 0
    local model = MachineManager:getInstance():getMachine():getModel()
    local mapInfo = mvc.puzzleModel:getMapInfo(coordX, coordY)
    local otherMonsterInfo = mvc.puzzleModel:getOtherMonsterInfo()
    local otherMapInfo = mvc.puzzleModel:getMapInfo(otherMonsterInfo.coordX, otherMonsterInfo.coordY)
    local battleView = MachineManager:getInstance():getMachine():getView()

    delayTime = delayTime + 0.4
    performWithDelay(self.PuzzleMatchLayer, function()
        self:createMonster(coordX, coordY)

        -- 怪物死亡
        for index = 1, 2 do
            local data = {
                spriteID = 0,
                murdererSpriteID = RoleDataManager:getMaster():getSpriteID(),
            }
            if index == 1 then
                data.spriteID = mapInfo.monsterSpriteID
            else
                data.spriteID = otherMapInfo.monsterSpriteID
            end
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_DIE, data)
            SceneManager:getInstance():pushCommand(command)
        end

        -- 加分特效
        for index = 1, 2 do
            local mapX = nil
            local mapY = nil
            if index == 1 then
                mapX = coordX
                mapY = coordY
            else
                mapX = otherMonsterInfo.coordX
                mapY = otherMonsterInfo.coordY
            end

            local battleView = MachineManager:getInstance():getMachine():getView()
            local addScoreAni = UI.Animation:create()
            addScoreAni:init("effect_ui_town_puzzle_2point.json", "effect_ui_town_puzzle_2point.atlas", 1)
            -- 自定义位置，关闭封装位置方法
            addScoreAni._enableAutoUpdatePos = false
            addScoreAni:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
                if not self or tolua.isnull(self) then
                    return
                end

                addScoreAni:removeSelf()
            end)

            local battleMap = battleView:getMap()
            local coordZ = battleView:getMapTileCoordZ(mapX, mapY)
            local sx, sy, sz = battleMap:coordinateToPosition(mapX, mapY, coordZ)
            addScoreAni:setPosition(sx, sy + sz + 130)
            local zOrder = battleView:getMapTileZOrder(mapX, mapY) + 1000
            addScoreAni:setZOrder(zOrder)
            -- 加入地图地块节点上
            battleMap:addNodeOnMap(addScoreAni)
            addScoreAni:setAnimation("idle", false)
        end

        -- 音效
        Avalon.AudioManager:playSound("556")
    end, delayTime)

    -- 修改状态
    mapInfo.state = MAP_STATE.OVER
    otherMapInfo.state = MAP_STATE.OVER

    -- 增加积分
    mvc.puzzleModel:addCurScoreNum()

    -- 增加匹配对数
    mvc.puzzleModel:addOverNum()

    -- 刷新积分显示
    self.PuzzleMatchLayer:updateScoreNum()

    if mvc.puzzleModel:getOverNum() * 2 == mvc.puzzleModel:getBoxTotalNum() then
        -- 一轮翻牌结束，重新加载第二轮
        delayTime = delayTime + 0.8
        performWithDelay(self.PuzzleMatchLayer, function()
            mvc.send(mvc.events.Puzzle_Create_List)
        end, delayTime)
    end

    delayTime = delayTime + 1
    performWithDelay(self.PuzzleMatchLayer, function()
        -- 清空待校对数据
        mvc.puzzleModel:setOtherMonsterInfo(nil)

        mvc.puzzleModel:setLockClick(false)
    end, delayTime)
end



-- 配对失败
function PuzzleController:failPaired(coordX, coordY)
    local delayTime = 0
    local model = MachineManager:getInstance():getMachine():getModel()
    local mapInfo = mvc.puzzleModel:getMapInfo(coordX, coordY)
    local otherMonsterInfo = mvc.puzzleModel:getOtherMonsterInfo()
    local otherMapInfo = mvc.puzzleModel:getMapInfo(otherMonsterInfo.coordX, otherMonsterInfo.coordY)
    local battleView = MachineManager:getInstance():getMachine():getView()

    delayTime = delayTime + 0.4
    performWithDelay(self.PuzzleMatchLayer, function()
        self:createMonster(coordX, coordY)

        -- 播放怪物idle2
        for index = 1, 2 do
            local data = {}
            if index == 1 then
                data.spriteID = mapInfo.monsterSpriteID
            else
                data.spriteID = otherMapInfo.monsterSpriteID
            end
            data.animationNames = {{"idle2", true}}

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_ANIMATIONS_BY_SPRITEID, data)
            SceneManager:getInstance():pushCommand(command)
        end

        -- 音效
        Avalon.AudioManager:playSound("1073")
    end, delayTime)

    delayTime = delayTime + 2
    performWithDelay(self.PuzzleMatchLayer, function()
        -- 怪物移除
        for index = 1, 2 do
            local role = nil
            if index == 1 then
                role = model:getRoleBySpriteID(mapInfo.monsterSpriteID)
            else
                role = model:getRoleBySpriteID(otherMapInfo.monsterSpriteID)
            end
            -- 停止所有的效果
            MachineManager:getInstance():getMachine()._actionTrack:clearActionForEntryId(role:getId())
            -- 移除所有buffer
            MachineManager:getInstance():getMachine():_clearAllBufferForRole(role)
            battleView:removeView(role)
            model:removeRole(role)
        end

        -- 播放盒子恢复
        for index = 1, 2 do
            local data = {}
            if index == 1 then
                data.spriteID = mapInfo.boxSpriteID
            else
                data.spriteID = otherMapInfo.boxSpriteID
            end
            data.animationNames = {{"close", false}, {"idle", true}}

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_ANIMATIONS_BY_SPRITEID, data)
            SceneManager:getInstance():pushCommand(command)
        end
    end, delayTime)

    -- 修改状态
    mapInfo.state = MAP_STATE.CLOSE
    otherMapInfo.state = MAP_STATE.CLOSE

    delayTime = delayTime + 0.4
    performWithDelay(self.PuzzleMatchLayer, function()
        -- 清空待校对数据
        mvc.puzzleModel:setOtherMonsterInfo(nil)

        mvc.puzzleModel:setLockClick(false)
    end, delayTime)
end



-- 添加校对数据
function PuzzleController:addOtherMonsterInfo(coordX, coordY)
    local delayTime = 0
    local model = MachineManager:getInstance():getMachine():getModel()
    local mapInfo = mvc.puzzleModel:getMapInfo(coordX, coordY)

    -- 添加怪物
    delayTime = delayTime + 0.4
    performWithDelay(self.PuzzleMatchLayer, function()
        self:createMonster(coordX, coordY)
    end, delayTime)

    -- 存入等待协对的怪物信息
    local data = {
        coordX = coordX,
        coordY = coordY
    }
    mvc.puzzleModel:setOtherMonsterInfo(data)

    -- 修改状态
    mapInfo.state = MAP_STATE.OPEN

    mvc.puzzleModel:setLockClick(false)
end



-- mvc.events.Puzzle_Create_List 处理函数
function PuzzleController:noticePuzzleCreateList(notification, isLoad)

    -- 首次加载的处理
    if isLoad then
        -- 清空残留积分
        mvc.puzzleModel:clearCurScoreNum()
        -- 清空残留地块信息
        mvc.puzzleModel:clearMapInfo()
        -- 清空待校对数据
        mvc.puzzleModel:setOtherMonsterInfo(nil)
        -- 初始关闭屏蔽
        mvc.puzzleModel:setLockClick(false)
    end

    -- 清空残留的匹配对数
    mvc.puzzleModel:clearOverNum()
    -- 刷新选择出的怪物模版列表
    mvc.puzzleModel:setMonsterTemplateList()
    -- 获取选择的怪物列表
    local monsterTemplateList = mvc.puzzleModel:getMonsterTemplateList()
    -- 获取位置组
    local posList = mvc.puzzleModel:getMapTilePosList()
    -- 箱子数量
    local boxNum = mvc.puzzleModel:getBoxTotalNum()
    -- 客户端模拟起始spriteID(本场景除了主角无其它，直接翻倍作为起始位)
    local oriBoxSpriteID = 2 * tonumber(RoleDataManager:getMaster():getSpriteID())
    local oriMonsterSpriteID = 2 * tonumber(RoleDataManager:getMaster():getSpriteID()) + 1000

    -- 添加箱子
    for index = 1, boxNum do

        if not isLoad then
            -- 获取地块信息
            local mapInfo = mvc.puzzleModel:getMapInfo(posList[index].coordX, posList[index].coordY)
            -- 播放盒子恢复
            local data = {
                spriteID = mapInfo.boxSpriteID,
                animationNames = {{"close", false}, {"idle", true}}
            }
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_ANIMATIONS_BY_SPRITEID, data)
            SceneManager:getInstance():pushCommand(command)

            -- 存入地块信息
            mvc.puzzleModel:setMapInfo(
                posList[index].coordX,
                posList[index].coordY,
                mapInfo.boxSpriteID,
                mapInfo.boxTemplateID,
                mapInfo.monsterSpriteID,
                monsterTemplateList[index],
                MAP_STATE.CLOSE
            )
        else
            -- 获取箱子模版
            local boxTemplate = clone(mvc.puzzleModel:getBoxTemplate())
            -- 构建箱子数据
            boxTemplate.spriteID = oriBoxSpriteID + index
            boxTemplate.coordX = posList[index].coordX
            boxTemplate.coordY = posList[index].coordY

            -- 创建箱子
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SCREEN_TRIGGERNPC, boxTemplate)
            SceneManager:getInstance():pushCommand(command)

            -- 存入地块信息
            mvc.puzzleModel:setMapInfo(
                posList[index].coordX,
                posList[index].coordY,
                oriBoxSpriteID + index,
                boxTemplate.templateID,
                oriMonsterSpriteID + index,
                monsterTemplateList[index],
                MAP_STATE.CLOSE
            )
        end
    end
end



-- mvc.events.Puzzle_Send_Result_Message 处理函数
function PuzzleController:noticePuzzleSendResultMessage(notification)
    printInfo("mvc.events.Puzzle_Send_Result_Message")
    UI.WaitingLayer:showWaiting(true, nil, 5)

    local score = mvc.puzzleModel:getCurScoreNum()

    Net.NetPlaySystem:requestPuzzleResult(score)
end



-- mvc.events.Puzzle_Handle_Result_Message 处理函数
function PuzzleController:noticePuzzleHandleResultMessage(notification, data)
    printInfo("mvc.events.Puzzle_Handle_Result_Message")
    UI.WaitingLayer:hideWaiting()
    printInfo(data)
    if data.err ~= PublicDefine.ErrNo.ErrNo_Ok then
        UI.ScrollBar:createByText(UI.TEXT_1170020)
        SceneManager:getInstance():leaveWaiting()
        return
    elseif not ProtobufUtil:checkFieldIsInit(data, "score") or data.score == 0 then
        SceneManager:getInstance():leaveWaiting()
        return
    end

    mvc.openPanel("Puzzle" ,"PuzzleResult", data)
end



-- mvc.events.Puzzle_Show_ScoreNumBanner 处理函数
function PuzzleController:noticePuzzleShowScoreNumBanner(notification, parent)
    local PuzzleMatchLayer = require "app.modules.puzzle.PuzzleMatchLayer"
    self.PuzzleMatchLayer = PuzzleMatchLayer:create()
    self.PuzzleMatchLayer:init()
    self.PuzzleMatchLayer:rightBottom(0, 0)
    parent:addChild(self.PuzzleMatchLayer, UI_ZORDER.USE_SPADE_UI)
end



return PuzzleController