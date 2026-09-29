-- 地图
local MapDefine = require "app.mapkit.MapDefine"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local MapClickBlockUtil = require("app.utils.MapClickBlockUtil")

local Machine = Machine.ShareMachine
local LAST_TOUCH_COORDX,LAST_TOUCH_COORDY
local LAST_PATH = nil
local DEBUG = false

local function _GetMapPath(self, direction, state, beginCoordX, beginCoordY, coordX, coordY)
    local cx = math.floor(beginCoordX)
    local cy = math.floor(beginCoordY)

    if(cx ~= beginCoordX or cy ~= beginCoordY) then
        if state == FSMState.MOVE then
            if direction == DirectionType.NORTH then cy = cy + 1
            elseif direction == DirectionType.EAST then cx = cx + 1
            elseif direction == DirectionType.SOUTH then --[[ cy = cy - 1 ]]
            elseif direction == DirectionType.WEAST then --[[ cx = cx - 1 ]] end
        end  
    end
    if  beginCoordX == coordX and beginCoordY == coordY then
        return {}
    end
    return self._model:findMapPath(cx, cy, coordX, coordY)
end
-- 获取寻路路径
local function GetMapPath(self, coordX, coordY, target)
    local master = target == nil and self._model:getMaster() or target
    local tileData = self._model:getMapTileData(coordX, coordY)

    if (master and tileData) then
        local masterCoord = master:getCoord()
        return _GetMapPath(self, master:getDirection(), master:getState(), masterCoord.x, masterCoord.y, coordX, coordY)
    end
    return nil
end
-- 开发模式下暴露 GetMapPath方法
if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then Machine.GetMapPath = GetMapPath end

-- 获取移动
local function GetMoveClickEffectData(self, coordX, coordY)
    local hasTile = false
    local moveType = 2
    local viewVisible = true
    local moveCoordList = nil

    local tileData = self._model:getMapTileData(coordX, coordY)
    if (tileData) then
        moveCoordList = GetMapPath(self, coordX, coordY)
        if (moveCoordList and #moveCoordList > 1) then
            moveType = 1
        else
            if (tileData:getTerrainType() == MapDefine.TerrainType.Wall) then
                local leftRoad = false
                local rightRoad = false

                local leftTileData = self._model:getMapTileData(coordX - 1, coordY)
                local rightTileData = self._model:getMapTileData(coordX, coordY - 1)

                if leftTileData == nil or (leftTileData and leftTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then leftRoad = true end
                if rightTileData == nil or (rightTileData and rightTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then rightRoad = true end
                if leftRoad and rightRoad then moveType = 4
                elseif leftRoad then moveType = 5
                elseif rightRoad then moveType = 6
                else moveType = 3 end
            else
                -- TODO
            end
        end
        if viewVisible then
            local master = self._model:getMaster()
            local masterCoord = master:getCoord()
            local cx = math.floor(masterCoord.x)
            local cy = math.floor(masterCoord.y)

            local isHidden = self._view:isHiddenByWall(cx, cy, coordX, coordY)
            if isHidden then viewVisible = false end
        end
        hasTile = true
    end
    LAST_PATH = moveCoordList
    return hasTile, moveType, viewVisible, moveCoordList
end


-- 处理通用命令
function Machine:_onExecuteGenerationCommand(command)
    local commandType = command.type
    if(GameManager:getIsInNewScene()) then
        self:_handleNewGenerationCommand(command)
    else
        -- 处理点击事件命令
        if (commandType == CommandType.GENERATION_TOUCH_BEGAN or
            commandType == CommandType.GENERATION_TOUCH_MOVED or
            commandType == CommandType.GENERATION_TOUCH_ENDED or
            commandType == CommandType.GENERATION_TOUCH_CANCEL or
            commandType == CommandType.GENERATION_TOUCH_LONG_TIME_BEGAN or
            commandType == CommandType.GENERATION_TOUCH_LONG_TIME_ENDED) then
            local touchPosition = command.touchPosition
            if (touchPosition) then
                local coordX, coordY = self:convertTouchPositionToCoord(touchPosition)
                -- print(string.format("BattleMachine _onExecuteGenerationCommand: execute touch command, touch position: (%f,%f), map coord: (%f,%f).", touchPosition.x, touchPosition.y, coordX, coordY))

                if (commandType == CommandType.GENERATION_TOUCH_BEGAN) then
                    self:_onTouchMapTileBegan(coordX, coordY, command.touchPosition)
                elseif (commandType == CommandType.GENERATION_TOUCH_MOVED) then
                    self:_onTouchMapTileMoved(coordX, coordY)
                elseif (commandType == CommandType.GENERATION_TOUCH_ENDED) then
                    self:_onTouchMapTileEnded(coordX, coordY)
                elseif (commandType == CommandType.GENERATION_TOUCH_CANCEL) then
                    self:_onTouchMapTileCancel(coordX, coordY)
                elseif (commandType == CommandType.GENERATION_TOUCH_LONG_TIME_BEGAN) then
                    self:_onTouchMapTileLongTimeBegan(coordX, coordY)
                elseif (commandType == CommandType.GENERATION_TOUCH_LONG_TIME_ENDED) then
                    self:_onTouchMapTileLongTimeEnded(coordX, coordY)
                else
                printError("[ERROR] BattleMachine _onExecuteGenerationCommand: no touch type found.")
                end
            else
                printError("[ERROR] BattleMachine _onExecuteGenerationCommand: touch position is invalid.")
            end
        elseif (commandType == CommandType.GENERATION_TOUCH_CLICK) then
            local touchPosition = command.touchPosition
            if (touchPosition) then
                self:_onTouchMapTileClick(touchPosition)
            end
        elseif (commandType == CommandType.GENERATION_START_MOVE) then
            self:_battleStartMove(command.direction)
        elseif (commandType == CommandType.GENERATION_STOP_MOVE) then
            self:_battleStopMove()
        elseif (commandType == CommandType.GENERATION_ROLE_ZORDER) then
            if DEBUG then
                print("GENERATION_ROLE_ZORDER  spriteID,endIdle,kickSpriteID=",command.spriteID,command.endIdle,command.kickSpriteID)
            end

            self:_battleRoleZorder(command.spriteID, command.endIdle, command.kickSpriteID)
        else
            printError("BattleMachine _onExecuteGenerationCommand: command type is invalid.  commandType=", commandType)
        end
    end
end

function Machine:_judegeToMove(master)
    if(self._enableRoleMoving == false) then
        return false
    end

    -- 这里主要放置玩家在开始之前就能够走动的问题
    if SceneManager:getInstance():isInHitRat() then
        local len = mvc.hitRatModel:getFightRemindCD()
        if len > 0 then
            return false
        end
    elseif SceneManager:getInstance():isInBigCrack() then
        local len = mvc.bigCrackModel:getFightRemindCD()
        if len > 0 then
           return false
        end
    elseif SceneManager:getInstance():isInPuzzle() then
        -- 记忆翻牌屏蔽移动
        local len = mvc.puzzleModel:getFightRemindCD()
        if len > 0 then
           return false
        end
    end

    if master then
        return master:judegeToMove()
    end

    return false
end

function Machine:_judegeToUseClick()
    if (GameDataManager:getInstance():canUseClickMove() and self._enableRoleMoving) then
        return true
    else 
        return false
    end 
end

function Machine:_onTouchMapTileClick(touchPosition)
    self._cancelTouch = false

    local map = self._view:getMap()
    if(map) then
        local mapPosition = self._view._map:convertToNodeSpace(touchPosition)

        local patrolArr = self._model:getPatrolNpcArr()
        if(patrolArr) then
            for k,patrolNpc in pairs(patrolArr) do 
                local renderer = self._view:getRenderer(patrolNpc:getId())
                if(renderer and renderer.getSpine ~= nil) then
                    local spine = renderer:getSpine()
                    if(spine) then 
                        local spinePosition = spine:convertToNodeSpace(touchPosition)
                        local rect = spine:getBoudingBox("tapbox_1", false) 
                        if rect then
                            rect.x = -20
                            rect.y = -20
                            rect.height = 100
                            rect.width = 100
                        end
                        if(rect and spine and cc.rectContainsPoint(rect, spinePosition)) then 
                            -- 处理点击后的处理逻辑
                            if(patrolNpc:getNpcData():judgeNPCInfomationTrigger()) then
                                local chatRoom = patrolNpc:getNpcData():getChatRoom()
                                if(chatRoom) then 
                                    local chat = chatRoom[math.random(#chatRoom)]
                                    if(chat) then
                                        local renderCommand = Command.RendererCommand:create(true)
                                        renderCommand:initNPCInfomationShow(patrolNpc:getId(), LanguageManager:getInstance():getLocalString(tonumber(chat)), patrolNpc:getNpcData():getTalkDuration())
                                        SceneManager:getInstance():pushCommand(renderCommand)
                                        patrolNpc:getNpcData():setNPCInfomationTriggerTime()
                                    end 
                                end 
                            end
                            return
                        end 
                    end 
                end 
            end
        end

        if SceneManager:getInstance():isInHitRat() then
    -- if (tileData) then
    --         -- if (tileData:getTerrainType() == MapDefine.TerrainType.Wall) then
    --     end
            local coordX, coordY = self:convertTouchPositionToCoord(touchPosition)
            local tileData = self._model:getMapTileData(coordX, coordY)
            mvc.send(mvc.events.HIT_RAT_TILE_TOUCH,"click",  coordX, coordY, touchPosition, tileData)
        elseif SceneManager:getInstance():isInPuzzle() then
            local coordX, coordY = self:convertTouchPositionToCoord(touchPosition)
            local tileData = self._model:getMapTileData(coordX, coordY)
            mvc.send(mvc.events.Puzzle_Click_Item, coordX, coordY, touchPosition, tileData)
        else
            map:triggerClickMap(mapPosition)
        end
    end
end

-- 触发点击地块开始的功能
function Machine:_onTouchMapTileBegan(coordX, coordY, touchPosition)
    -- 预判是否点击到了巡逻NPC
    local patrolArr = self._model:getPatrolNpcArr()
    if(patrolArr) then
        local map = self._view:getMap()
        if(map) then
            local mapPosition = self._view._map:convertToNodeSpace(touchPosition)

            for k,patrolNpc in pairs(patrolArr) do 
                local renderer = self._view:getRenderer(patrolNpc:getId())
                if(renderer and renderer.getSpine ~= nil) then
                    local spine = renderer:getSpine()
                    if(spine) then 
                        local spinePosition = spine:convertToNodeSpace(touchPosition)
                        local rect = spine:getBoudingBox("tapbox_1", false)

                        if(rect and cc.rectContainsPoint(rect, spinePosition)) then 
                            -- 处理点击先关的逻辑
                            self._cancelTouch = true
                            return 
                        end 
                    end 
                end
            end
        end
    end

    -- if SceneManager:isInHitRat() then
    --     mvc.send(mvc.events.HIT_RAT_TILE_TOUCH,"begin",  coordX, coordY, touchPosition)
    -- end

    if (self:_judegeToUseClick()) then
        if (self._view) then
            LAST_TOUCH_COORDX,LAST_TOUCH_COORDY = coordX, coordY
            local master = self._model:getMaster()
            if self:_judegeToMove(master)  then
                local hasTile, moveType, viewVisible, moveList = GetMoveClickEffectData(self, coordX, coordY)
                if (hasTile) then
                    self:_clickViewMove(coordX, coordY, moveType, viewVisible)
                else
                    self:_removeClickView()
                end 
            else
                self:_removeClickView()
            end
        end
    end
end

-- 触发点击地块移动的功能
function Machine:_onTouchMapTileMoved(coordX, coordY)
    if(self._cancelTouch) then 
        return 
    end

    -- 如果一直在一个格子 不执行操作 确保在move时间中一个格子只寻路一次
    if LAST_TOUCH_COORDX== coordX and LAST_TOUCH_COORDY == coordY then
        return;
    else
        LAST_TOUCH_COORDX,LAST_TOUCH_COORDY = coordX, coordY
    end

    -- if SceneManager:isInHitRat() then
    --     mvc.send(mvc.events.HIT_RAT_TILE_TOUCH,"move",  coordX, coordY)
    -- end

    if (self:_judegeToUseClick()) then
        if (self._view) then
            local master = self._model:getMaster()
            if master and ( master:getState() == FSMState.MOVE or master:getState() == FSMState.IDLE ) and master:getIsDead() == false then
                local hasTile, moveType, viewVisible, moveList = GetMoveClickEffectData(self, coordX, coordY)
                if (hasTile) then
                    self:_clickViewMove(coordX, coordY, moveType, viewVisible)
                else
                    self:_removeClickView()
                end
            else
                self:_removeClickView()
            end
        end
    else 
        self:_removeClickView()
    end
end

-- 触发主角移动
function Machine:_triggerMove(target, coordX, coordY, moveStartTrigger, moveEndCallBack)
    local moveCoordList = GetMapPath(self, coordX, coordY, target)
    -- print("hero path ", moveCoordList)
    if (moveCoordList and #moveCoordList > 1) then
        self:_fsmClickMove(target, moveCoordList, 0, moveStartTrigger, moveEndCallBack)
    else 
        self:enableRoleMoving()
        if(moveEndCallBack) then 
            moveEndCallBack()
        end
    end
end

-- 触发主角移动(供外部使用)
function Machine:getMapPath(target, coordX, coordY)
    local moveCoordList = GetMapPath(self, coordX, coordY, target)
    return moveCoordList
end

-- 触发主角移动
function Machine:_triggerMasterMove(coordX, coordY, moveStartTrigger)
    self:_triggerMove(self._model:getMaster(), coordX, coordY, moveStartTrigger)  
end

function Machine:_onTouchMapTileCancel(coordX, coordY)
    self:_removeClickView()
end

-- 触发点击地块结束的功能
function Machine:_onTouchMapTileEnded(coordX, coordY)
    if(self._cancelTouch) then 
        self._cancelTouch = false
        return 
    end
    local mapTile = self._model:getMapTileData(coordX, coordY)
    if (mapTile) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_CLICK_MAP_TILE, coordX, coordY)
    end

    -- 获取是否点中了那个角色
    if(mapTile) then
        self:_handleClickHero(mapTile)
    end
    
    if self:_judegeToUseClick() then
        if (not self._clickMonster) then
            -- 处理点击移动
            local master = self._model:getMaster()
            if (master) then
                -- print("Machine:_onTouchMapTileEnded", master:getState(), FSMState.MOVE, FSMState.IDLE)
                -- dump(mapTile.roleDatas)
                if ( ( master:getState() == FSMState.MOVE or master:getState() == FSMState.IDLE ) and master:getIsDead() == false ) then
                    local state = master:getState()
                    if (state == FSMState.MOVE or state == FSMState.IDLE) then
                        -- 处理英雄移动
                        if (not MapClickBlockUtil:isBlocked()) then
                            self:_triggerMasterMove(coordX, coordY, true)
                        end
                    end
                end
            else
                printError("[ERROR] BattleMachine _onTouchMapTileEnded: no master found.")
            end
        end

        self:_clickViewShow()
    else 
        if(self._enableRoleMoving) then
            if (not self._clickMonster) then
                local master = RoleDataManager:getMaster()
                if(self:_judegeToMove(master)) then
                    if(master and master:getIsReverse()) then
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111334))
                    end
                end
            end 
        end
        self:_clickViewShow()
    end
end

-- 触发开始长按地块的功能
function Machine:_onTouchMapTileLongTimeBegan(coordX, coordY)
    local tileData = self._model:getMapTileData(coordX, coordY)

    if tileData then
        if(tileData.placeholderDatas) then
            for _,placeholderData in pairs(tileData.placeholderDatas) do
                if placeholderData:getTypeName() == PlaceholerTypeName.MONSTER then
                    local roleData = self._model:getRoleBySpriteID(placeholderData:getAssocialtedID())
                    if(roleData ~= nil) then
                        self:_handleMonsterLongClick(roleData:getRoleData())
                    end
                end
            end
        end

        if( tileData.roleDatas ) then
            for _, roleData in pairs(tileData.roleDatas) do
                if roleData:getDeformationCategory() == Category.ROLE and roleData:getDeformationType() == RoleType.Monster then
                    self:_handleMonsterLongClick(roleData)
                end
            end
        end 
    end
end

-- 触发结束长按地块的功能
function Machine:_onTouchMapTileLongTimeEnded(coordX, coordY)
    if (self._clickMonster) then
        self._clickMonster = false
        -- 发送移除怪物详情
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_MONSTER_DETAIL)
        self:_removeClickView()
    end
end

function Machine:_handleMonsterLongClick(roleData) 
    local monsterData = roleData
    if(roleData:isDeformation()) then
        monsterData = roleData:getDeformationData()
    end

    -- 处理触发怪没有触发之前不能查看详情
    if(monsterData:judgeNeedToTrigger()) then
        if(monsterData:getIsTrigger() == false) then
            return
        end
    end

    if monsterData then
        -- 拷贝一份新的数据，避免以前的数据对查看造成影响(非完全)
        local newMonsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(monsterData.monsterID, monsterData._model, monsterData._difficulty)
        if(newMonsterData) then 
            -- 这里要取最原始的地址，否者会出现问题
            newMonsterData:setCoordXY(roleData.coordX, roleData.coordY)
            newMonsterData:setMonsterRare(monsterData:getMonsterRare())
            newMonsterData:setTriggerNum(monsterData:getTriggerNum())

            self._clickMonster = true
            -- 根据角色个数刷新怪物数据
            local roleNum = GameDataManager:getInstance():getGameRoleNum()
            newMonsterData:refreshAttr(roleNum, true)

            newMonsterData._affixArr = clone(monsterData._affixArr)

            -- 触发怪物详情
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MONSTER_DETAIL, newMonsterData)
        end 
        self:_removeClickView()
    end
end

-- 处理点击角色
function Machine:_handleClickHero(titleData)
    -- if(titleData and (SceneManager:getInstance():isInTown() or SceneManager:getInstance():isInDungeon())) then
    if(titleData and 
        (SceneManager:getInstance():isNotInFightScene())) then
        local coordX = titleData:getX()
        local coordY = titleData:getY()

        -- 添加处理前面一格的需求
        local preTileData = self._model:getMapTileData(coordX-1, coordY-1)
        if(preTileData) then
            local roleDatas = preTileData.roleDatas
            if(#roleDatas > 0) then
                for i=#roleDatas, 1, -1 do
                    local roleData = roleDatas[i]
                    if(roleData and roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Hero) then
                        if(roleData:isMasterHero() == false) then
                            if(Avalon.MathUtil:getInt(roleData:getCoord().x) == coordX - 1 and Avalon.MathUtil:getInt(roleData:getCoord().y) == coordY - 1) then 
                                -- 触发选中角色
                                self:_handleChoiceHero(roleData)
                            end
                            return
                        end
                    end
                end
            end
        end

        local roleDatas = titleData.roleDatas
        if(#roleDatas > 0) then
            for i=#roleDatas, 1, -1 do
                local roleData = roleDatas[i]
                if(roleData and roleData:getCategory() == Category.ROLE) then
                    if roleData:getType() == RoleType.Hero then
                        if (roleData:isMasterHero() == false) then
                            if(Avalon.MathUtil:getInt(roleData:getCoord().x) == coordX and Avalon.MathUtil:getInt(roleData:getCoord().y) == coordY) then 
                                -- 触发选中角色  
                                self:_handleChoiceHero(roleData)
                                return
                            end
                        end
                    end
                end
            end
        end

        --拷贝执行的原因是为了保证如果一个格子里面即有人物也有宠物的时候 优先触发人物
        local roleDatas = titleData.roleDatas
        if(#roleDatas > 0) then
            for i=#roleDatas, 1, -1 do
                local roleData = roleDatas[i]
                if(roleData and roleData:getCategory() == Category.ROLE) then
                    if roleData:getType() == RoleType.Pet then
                        if(Avalon.MathUtil:getInt(roleData:getCoord().x) == coordX and Avalon.MathUtil:getInt(roleData:getCoord().y) == coordY) then 
                            self:_handleChoiceHero(roleData)
                            return
                        end
                    end
                end
            end
        end
    end
end

-- 处理选中角色
function Machine:_handleChoiceHero(heroData)
    if(heroData) then
        -- 更新地图的渲染命令
        local hero = self._model:getRoleBySpriteID(heroData:getSpriteID())
        if(hero) then
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initSelectHeroShow(hero:getId())
            self:pushCommand(renderCommand)
        end

        -- 向UI发送消息，显示相关的对象
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SHOW_CHOICE_HERO, heroData)
    end
end

local preClickX = nil
local preClickY = nil

function Machine:_removeClickView()
    preClickX = nil
    preClickY = nil
    if (self._view) then
        self._view:moveClickRemove()
    end
end

function Machine:_clickViewMove(coordX, coordY, moveType, viewVisible)
    if (self._view) then
        if not (coordX == preClickX and coordY == preClickY) then
            preClickX = coordX
            preClickY = coordY
            self._view:moveClick(coordX, coordY, moveType, viewVisible)
        end
    end
end

function Machine:_clickViewShow()
    preClickX = nil
    preClickY = nil
    if (self._view) then
        self._view:moveClickShow()
    end
end

-- 处理一个新的命令行
function Machine:_handleNewGenerationCommand(command)
    local commandType = command.type
    -- 处理点击事件命令
    if (commandType == CommandType.GENERATION_TOUCH_BEGAN or
        commandType == CommandType.GENERATION_TOUCH_MOVED or
        commandType == CommandType.GENERATION_TOUCH_ENDED or
        commandType == CommandType.GENERATION_TOUCH_CANCEL or
        commandType == CommandType.GENERATION_TOUCH_LONG_TIME_BEGAN or
        commandType == CommandType.GENERATION_TOUCH_LONG_TIME_ENDED) then
        local touchPosition = command.touchPosition
        if (touchPosition) then
            -- local coordX, coordY = self:convertTouchPositionToCoord(touchPosition)
            -- print(string.format("BattleMachine _onExecuteGenerationCommand: execute touch command, touch position: (%f,%f), map coord: (%f,%f).", touchPosition.x, touchPosition.y, coordX, coordY))

            if (commandType == CommandType.GENERATION_TOUCH_BEGAN) then
                self:_onNewTouchMapTileBegan(command.touchPosition)
            -- elseif (commandType == CommandType.GENERATION_TOUCH_MOVED) then
            --     self:_onTouchMapTileMoved(coordX, coordY)
            -- elseif (commandType == CommandType.GENERATION_TOUCH_ENDED) then
            --     self:_onTouchMapTileEnded(coordX, coordY)
            -- elseif (commandType == CommandType.GENERATION_TOUCH_CANCEL) then
            --     self:_onTouchMapTileCancel(coordX, coordY)
            -- elseif (commandType == CommandType.GENERATION_TOUCH_LONG_TIME_BEGAN) then
            --     self:_onTouchMapTileLongTimeBegan(coordX, coordY)
            -- elseif (commandType == CommandType.GENERATION_TOUCH_LONG_TIME_ENDED) then
            --     self:_onTouchMapTileLongTimeEnded(coordX, coordY)
            else
            -- printError("[ERROR] BattleMachine _onExecuteGenerationCommand: no touch type found.")
            end
        else
            printError("[ERROR] BattleMachine _onExecuteGenerationCommand: touch position is invalid.")
        end
    elseif (commandType == CommandType.GENERATION_TOUCH_CLICK) then
        local touchPosition = command.touchPosition
        if (touchPosition) then
            self:_onNewTouchMapTileClick(touchPosition)
        end
    -- elseif (commandType == CommandType.GENERATION_START_MOVE) then
    --     self:_battleStartMove(command.direction)
    -- elseif (commandType == CommandType.GENERATION_STOP_MOVE) then
    --     self:_battleStopMove()
    -- elseif (commandType == CommandType.GENERATION_ROLE_ZORDER) then
    --     if DEBUG then
    --         print("GENERATION_ROLE_ZORDER  spriteID,endIdle,kickSpriteID=",command.spriteID,command.endIdle,command.kickSpriteID)
    --     end

    --     self:_battleRoleZorder(command.spriteID, command.endIdle, command.kickSpriteID)
    else
        -- printError("BattleMachine _onExecuteGenerationCommand: command type is invalid.  commandType=", commandType)
    end
end

function Machine:_onNewTouchMapTileBegan(touchPosition)
    if(self._view) then 
        self._view:triggerOneTouchEffect(touchPosition)
    end

end

function Machine:_onNewTouchMapTileClick(touchPosition)
    if(self._model and self._view) then
        local npcModelArr = self._model:getAllFunctionNpcArr()
        table.sort(npcModelArr, function(a, b)
            local aNpcData = a:getData()
            local bNpcData = b:getData()
            if(aNpcData and bNpcData) then 
                if(aNpcData:getNpcIndex() == bNpcData:getNpcIndex()) then 
                    if(aNpcData:getId() < bNpcData:getId()) then 
                        return true
                    else
                        return false
                    end
                else
                    if(aNpcData:getNpcIndex() > bNpcData:getNpcIndex()) then 
                        return true
                    else
                        return false
                    end
                end
            else
                if(a:getId() < b:getId()) then 
                    return true
                else
                    return false
                end
            end

            return false
        end)

        local bgPosition = self._view._mapNode:coverToBgPositionForCenter(touchPosition)
        -- print("TownNewView  bgPosition=", bgPosition)
        for k, npcModel in ipairs(npcModelArr) do 
            if npcModel:getData() then 
                local touchCoordArr = npcModel:getData():getTouchRect()
                -- print("TownNewView  touchCoordArr=", touchCoordArr)
                if(touchCoordArr and #touchCoordArr == 4) then 
                    if(ToolsUtil:isPointInRect(bgPosition.x, bgPosition.y, touchCoordArr[1], touchCoordArr[2], touchCoordArr[3], touchCoordArr[4])) then 
                        -- print("TownNewView  click one=", npcModel:getSpriteID(), npcModel:getData():getSelectData())
                        self:_battleOpenNewSceneTriggerNpc(npcModel:getSpriteID())
                        break
                    end
                end
            end
        end
    end
end
