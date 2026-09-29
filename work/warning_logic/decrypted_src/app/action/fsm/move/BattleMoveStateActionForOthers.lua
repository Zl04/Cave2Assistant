-- --[[
--     状态机行为：战斗移动状态
--     这里最终统一按照方向来计算
-- ]]--

-- require "utils.MathUtil"
-- require "app.action.Action"
-- require "app.pool.Pool"
-- require "app.action.fsm.move.BattleMoveStateAction"
-- require "app.object.geometric.GeometricModel"

-- local MapDataManager = require "app.mapkit.model.MapDataManager"
-- local MachineManager = require("app.game.MachineManager")
-- local MapDefine = require "app.mapkit.MapDefine"

-- Action = Action or {}

-- local DEBUG = false

-- local BattleMoveStateActionForOthers = class("BattleMoveStateActionForOthers", Action.BattleMoveStateAction)
-- Action.BattleMoveStateActionForOthers = BattleMoveStateActionForOthers

-- local BattleMoveType = Action.BattleMoveType

-- local computeNormal = Geome.computeNormal
-- local computeDirection = Geome.computeDirection
-- local reverseDirection = Geome.reverseDirection

-- -- private:
-- -- 对象池
-- local BattleMoveStateActionForOthersPool = nil

-- -- public:
-- -- 创建对象
-- function BattleMoveStateActionForOthers:create(reused, ...)
--     if (reused) then
--         if (not BattleMoveStateActionForOthersPool) then
--             BattleMoveStateActionForOthersPool = Pool.Pool:create(BattleMoveStateActionForOthers)
--         end
--         return BattleMoveStateActionForOthersPool:applyObject()
--     else
--         return BattleMoveStateActionForOthers.new(...)
--     end
-- end

-- -- 构造函数
-- function BattleMoveStateActionForOthers:ctor()
--     BattleMoveStateActionForOthers.super.ctor(self, ActionType.FSM_BATTLE_MOVE)

--     self._target = nil
--     self._direction = nil
--     self._oldDirection = DirectionType.NONE 
--     self._battleMachine = nil

--     self._battleMoveType = BattleMoveType.DIRECTION_MOVE

--     self._currentCoord = nil
--     self._endTime = 0
--     self._speedX = 0
--     self._speedY = 0

--     self._data = nil

--     self._stop = false
--     self._reset = false

--     self._accumulationPosition = {x=0,y=0}

--     self._accelerateTime = 0  -- 加速时间
--     -- print("BattleMoveStateActionForOthers:ctor _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)

--     self._endIdle = true
-- end

-- -- 模版函数：销毁
-- function BattleMoveStateActionForOthers:dtor()
--     BattleMoveStateActionForOthers.super.dtor(self)
--     -- print("BattleMoveStateActionForOthers  onDestroy")
--     self._data = nil
--     self._direction = nil
--     self._oldDirection = DirectionType.NONE 
--     self._currentCoord = nil

--     self._stop = false
--     self._reset = false

--     self._accumulationPosition = {x=0,y=0}
--     self._accelerateTime = 0
--     self._endIdle = true
--     -- print("BattleMoveStateActionForOthers:onDestroy _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
-- end

-- -- 初始化
-- function BattleMoveStateActionForOthers:init(target, battleMachine, battleModel)
--     -- print("BattleMoveStateActionForOthers:init   ------")
--     BattleMoveStateActionForOthers.super.init(self, target, battleMachine, battleModel)

--     self._data = target:getData()
--     self._oldDirection = DirectionType.NONE

--     self._stop = false
--     self._reset = false

--     self._accelerateTime = 0
--     -- print("BattleMoveStateActionForOthers:init _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
-- end

-- --[[
--     设置按照方向移动
-- ]]
-- function BattleMoveStateActionForOthers:setDirectionMove(coord,direction,actionStartTime)
--     self._moveDataList = Avalon.List:create()
--     self._nowMoveData = nil

--     local moveData = {}
--     moveData.startCoord = coord
--     moveData.direction = direction
--     moveData.actionStartTime = actionStartTime

--     self._nowMoveData = moveData

-- end

-- function BattleMoveStateActionForOthers:addDiretionStartMove(coord,direction,actionStartTime)

--     local lastMoveData = nil
--     if self._moveDataList:size() > 0 then
--         lastMoveData = self._moveDataList:tail()
--     else
--         lastMoveData = self._nowMoveData
--     end
--     if lastMoveData then
--         lastMoveData.endCoord = coord

--         local moveData = {}
--         moveData.startCoord = coord
--         moveData.direction = direction
--         moveData.actionStartTime = actionStartTime
--         self._moveDataList:push_back(moveData)

--         -- 处理判断是否已经超过该点了，true 需要瞬移到该点然后执行
--         if self:isInvalidMove(lastMoveData.startCoord,lastMoveData.endCoord) then
--             self:handleInvalidMove()
--         end
--     else
--        assert(false, "BattleMoveStateActionForOthers:addDiretionStartMove 消息顺序有问题")
--     end



-- end

-- function BattleMoveStateActionForOthers:addDiretionStopMove(coord,actionStartTime)
--     local lastMoveData = nil
--     if self._moveDataList:size() > 0 then
--         lastMoveData = self._moveDataList:tail()
--     else
--         lastMoveData = self._nowMoveData
--     end
--     if lastMoveData then
--         lastMoveData.endCoord = coord
--         lastMoveData.actionEndTime = actionStartTime
--         if DEBUG then
--             print("BattleMoveStateActionForOthers:addDiretionStopMove 1")
--         end
--         -- 处理判断是否已经超过该点了，true 需要瞬移到该点然后执行
--         if self:isInvalidMove(lastMoveData.startCoord,lastMoveData.endCoord) then
--             if DEBUG then
--                 print("BattleMoveStateActionForOthers:addDiretionStopMove 2")
--             end
--             self:handleInvalidMove()
--         end
--     else
--        assert(false, "BattleMoveStateActionForOthers:addDiretionStopMove 消息顺序有问题")
--     end
-- end

-- -- 清理
-- function BattleMoveStateActionForOthers:clear()
--     BattleMoveStateActionForOthers.super.clear(self)

--     self._target = nil
--     self._data = nil
--     self._direction = nil
--     self._oldDirection = DirectionType.NONE 
--     self._battleMachine = nil

--     self._currentCoord = nil
--     self._endTime = 0
--     self._speedX = 0
--     self._speedY = 0

--     self._stop = false

--     self._accumulationPosition = {x=0,y=0}

--     self._accelerateTime = 0
--     self._endIdle = true
--     -- print("BattleMoveStateActionForOthers:clear _oldDirection,_direction,NONE",self._oldDirection,self._direction,DirectionType.NONE)
-- end

-- -- 模版函数：action开始
-- function BattleMoveStateActionForOthers:onStart()
--     local startCoord = self._nowMoveData.startCoord
--     self._direction = self._nowMoveData.direction
--     self._currentCoord = self._target:getCoord()

--     local positionCommand = Command.RendererCommand:create(true)
--     positionCommand:initUpdatePositionCommand(self._target:getId(), startCoord)
--     self._battleMachine:pushCommand(positionCommand)

--     self._target:setDirection(self._direction)
--     self._target:setCoord(startCoord.x,startCoord.y)


--     self._accelerateTime = (GameManager:getNowServerTimestamp() - self._nowMoveData.actionStartTime)/1000

--     if self:triggerNextDirection() == false  then
--         return false
--     end

--     -- 计算一个量化方向
--     local nextCoord = self:getNextCoord()
--     self.normal = computeNormal(self._currentCoord,nextCoord)

--     self:forceUpdate()

--     -- 切换移动
--     if (not self._target:switchState(FSMState.MOVE)) then

--         return false
--     end

--     GameManager:notifyRoleFSMChange(self._target:getData())

--     return true
-- end

-- -- 模版函数：action更新
-- function BattleMoveStateActionForOthers:onUpdate(dt)
--     local nowTime = AvalonUtil.getCurrentTime()
--     -- 计算加速处理
--     local accelerate = 0

--     if self._accelerateTime >0 then
--         accelerate = dt*2
--         if accelerate > self._accelerateTime then
--             accelerate = self._accelerateTime
--         end

--         self._accelerateTime = self._accelerateTime - accelerate
--     end


--     local totalDt = dt
    
--     local target = self._target
--     local speed = self:getSpeed()
--     repeat
--         -- 速度变动,这里需要考虑性能
--         self._speedX = speed * self.normal.x
--         self._speedY = speed * self.normal.y

--         -- 对于每帧时间做拆分计算，避免出现跳格BUG
--         local oneDt = totalDt
--         if totalDt > 0.2 then
--             oneDt = 0.2
--         end
--         totalDt = totalDt - oneDt

--         local localCoord = {x = 0,y=0}
--         localCoord.x = self._currentCoord.x
--         localCoord.y = self._currentCoord.y

--         local addX = self._speedX * oneDt
--         local addY = self._speedY * oneDt

--         localCoord.x = self._currentCoord.x + addX;
--         localCoord.y = self._currentCoord.y + addY;


--         self._accumulationPosition.x = self._accumulationPosition.x + addX
--         self._accumulationPosition.y = self._accumulationPosition.y + addY

--         -- 判断是否跨过了一格
--         local skipOneMap = false
--         local backTime = 0
--         -- 这里尽可能的不浪费时间
--         if self._accumulationPosition.x >=1  then
--             skipOneMap = true
--             self._accumulationPosition.x = self._accumulationPosition.x - 1
--             backTime = self._accumulationPosition.x / self._speedX
--         elseif self._accumulationPosition.x <= -1 then
--             skipOneMap = true
--             self._accumulationPosition.x = self._accumulationPosition.x + 1
--             backTime = self._accumulationPosition.x / self._speedX
--         elseif self._accumulationPosition.y >= 1  then
--             skipOneMap = true
--             self._accumulationPosition.y = self._accumulationPosition.y - 1
--             backTime = self._accumulationPosition.y / self._speedY
--         elseif self._accumulationPosition.y <= -1 then
--             skipOneMap = true
--             self._accumulationPosition.y = self._accumulationPosition.y + 1
--             backTime = self._accumulationPosition.y / self._speedY
--         end

--         -- print("------------- 1 ", skipOneMap)
--         -- print("------------- 3 ", addX, addY, self._accumulationPosition.x, self._accumulationPosition.y)

--         if skipOneMap then
--             localCoord.x = Avalon.MathUtil:getInt(localCoord.x)
--             localCoord.y = Avalon.MathUtil:getInt(localCoord.y)

--             totalDt = totalDt + backTime

--             self._accumulationPosition.x = 0
--             self._accumulationPosition.y = 0
--         end

--         -- print("------------- 2", oneDt, totalDt, backTime)

--         -- print("BattleMoveStateActionForOthers:onUpdate local x,y,speedX,speedY,dt=",localCoord.x,localCoord.y,self._speedX,self._speedY,dt)

--         -- if skipOneMap then
--         --     -- 先从地图移除对象，然后在修改位置后再添加对象
--         --     MapDataManager:getInstance():removeRole(self._battleMachine._model._mapData,Avalon.MathUtil:getInt(self._currentCoord.x),Avalon.MathUtil:getInt(self._currentCoord.y),self._target:getData())
--         -- end

--         target:setDirection(self._direction);
--         target:setCoord(localCoord.x, localCoord.y)

--         if skipOneMap then
--             -- 修改位置后添加到地图上面
--             MapDataManager:getInstance():addRole(self._battleMachine._model._mapData,Avalon.MathUtil:getInt(self._currentCoord.x),Avalon.MathUtil:getInt(self._currentCoord.y),self._target:getData())
--         end

--         local positionCommand = Command.RendererCommand:create(true)
--         positionCommand:initUpdatePositionCommand(self._target:getId(), localCoord)
--         self._battleMachine:pushCommand(positionCommand)

--         if skipOneMap then

--             if self:triggerNextDirection() == false then
--                 return true
--             end

--             -- 判断是否到最后一格了
--             if self:handlePreMoveNext() == false then
--                 return true
--             end
            
--         end

--     until totalDt <= 0

--     return false
-- end

-- -- 模板函数：停止action
-- function BattleMoveStateActionForOthers:stop()
--     -- 处理走完这一格
--     self._stop = true
-- end

-- -- 模版函数：action结束
-- function BattleMoveStateActionForOthers:onEnd()

--     -- self._target:idle()
-- end

-- function BattleMoveStateActionForOthers:onFail()
--     -- TODO 处理执行失败的处理
--     print("BattleMoveStateActionForOthers:onFail")
-- end

-- -- 判断某格子是否可通行
-- function BattleMoveStateActionForOthers:judgeReachable(coord)
--     -- local tileData = MapDataManager:getInstance():getTileDataAtCoord(self._battleMachine._model:getMapData(), coord.x, coord.y)

--     -- local reachable = MapDataManager:getInstance():isCoordReachable(self._battleMachine._model:getMapData(), coord.x, coord.y)
--     self._battleMachine._model:getMapData():isCoordReachable(coord.x, coord.y)

--     print("BattleMoveStateActionForOthers:judgeReachable coord.x,coord.y,reachable=",coord.x,coord.y,reachable)

--     return  reachable
-- end


-- function BattleMoveStateActionForOthers:getNextCoord()
--     local nextCoord = {}
--     nextCoord.x = Avalon.MathUtil:getInt(self._currentCoord.x)
--     nextCoord.y = Avalon.MathUtil:getInt(self._currentCoord.y)
--     print("BattleMoveStateActionForOthers:getNextCoord now coord.x,coord.y=",nextCoord.x,nextCoord.y)
--     if self._direction == DirectionType.NORTH then
--         nextCoord.y = nextCoord.y + 1
--     elseif self._direction == DirectionType.EAST then
--         nextCoord.x = nextCoord.x + 1
--     elseif self._direction == DirectionType.SOUTH then
--         nextCoord.y = nextCoord.y - 1
--     elseif self._direction == DirectionType.WEAST then
--         nextCoord.x = nextCoord.x - 1
--     end

--     -- TODO 用户保证客户端计算完整
--     if nextCoord.z == nil then
--         nextCoord.z = 0
--     end

--     print("BattleMoveStateActionForOthers:getNextCoord next coord.x,coord.y=",nextCoord.x,nextCoord.y)

--     return nextCoord
-- end

-- -- 判断是否为玩家
-- function BattleMoveStateActionForOthers:judageWasMaster()
--     return false
-- end

-- -- 获取移动速度
-- function BattleMoveStateActionForOthers:getSpeed()
--     local speed = 1000
--     if self._data and self._data.moveSpeed then
--         speed = self._data.moveSpeed
--     end
--     -- TODO 测试加速移动功能
--     speed = 4000
--     speed = speed/PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE

--     return speed
-- end

-- --[[
--     触发下一个方向
--     返回值：（返回值只用于判断是否需要退出移动）false 需要退出移动， true 不用退出移动
-- ]]
-- function BattleMoveStateActionForOthers:triggerNextDirection()
--     if self._nowMoveData then
--         local nowCoord = self._target:getCoord()
--         local endCoord = self._nowMoveData.endCoord
--         if endCoord then
--             if endCoord.x == nowCoord.x and endCoord.y == nowCoord.y then
--                 self._nowMoveData = self._moveDataList:pop_front()
--                 if self._nowMoveData then
--                     self._accumulationPosition.x = 0
--                     self._accumulationPosition.y = 0

--                     local startCoord = self._nowMoveData.startCoord
--                     self._direction = self._nowMoveData.direction

--                     self._target:setDirection(self._direction)
--                     self._target:setCoord(startCoord.x,startCoord.y)

--                     MachineManager:getInstance():pushDirectionRendererCommand(self._target, self._direction)
--                     -- MachineManager:getInstance():pushPositionRendererCommand(self._target, startCoord, false)
--                     self:pushPositionRendererCommand(self._target, startCoord, false)

--                     -- 计算一个量化方向
--                     local nextCoord = self:getNextCoord()
--                     self.normal = computeNormal(self._currentCoord,nextCoord)

--                     return true
--                 else
--                     self:complete()
--                 end
--             else
--                 return true
--             end
--         else
--             return true
--         end
--     else
--         self:complete()
--     end

--     return false
-- end

-- --[[
--     处理无效移动
-- ]]
-- function BattleMoveStateActionForOthers:handleInvalidMove()
--     if self._nowMoveData then
--         self._accumulationPosition.x = 0
--         self._accumulationPosition.y = 0

--         local endCoord = self._nowMoveData.endCoord
--         self._target:setCoord(endCoord.x,endCoord.y)
--         -- MachineManager:getInstance():pushPositionRendererCommand(self._target, endCoord, false)
--         self:pushPositionRendererCommand(self._target, endCoord, false)
--         if DEBUG then
--             print("BattleMoveStateActionForOthers:handleInvalidMove  1")
--         end
--         -- 触发下一个方向
--         self:triggerNextDirection()
--     else
--         self:complete()
--     end
-- end

-- -- 是否已经无效的移动了
-- function BattleMoveStateActionForOthers:isInvalidMove(startCoord,endCoord)
--     if DEBUG then
--         print("BattleMoveStateActionForOthers:isInvalidMove  1",startCoord,endCoord)
--     end
--     if not startCoord or not endCoord or not self._nowMoveData then
--         return false
--     end
--     if DEBUG then
--         print("BattleMoveStateActionForOthers:isInvalidMove  2",startCoord.x,startCoord.y,self._nowMoveData.startCoord.x,self._nowMoveData.startCoord.y)
--     end
--     if startCoord.x == self._nowMoveData.startCoord.x and startCoord.y == self._nowMoveData.startCoord.y then
--         local nowCoord = self._target:getCoord()
--         if DEBUG then
--             print("BattleMoveStateActionForOthers:isInvalidMove  3",nowCoord.x,nowCoord.y)
--         end

--         if self._direction == DirectionType.NORTH then
--             if endCoord.y < nowCoord.y then
--                 return true
--             end
--         elseif self._direction == DirectionType.EAST then
--             if endCoord.x < nowCoord.x then
--                 return true
--             end
--         elseif self._direction == DirectionType.SOUTH then
--             if endCoord.y > nowCoord.y then
--                 return true    
--             end
--         elseif self._direction == DirectionType.WEAST then
--             if endCoord.x > nowCoord.x then
--                 return true
--             end
--         end
--     end

--     return false
-- end

-- --[[
--     处理走下一格之前的逻辑处理
--     response: false 需要停止运行了，true 可以继续运行
-- ]] 
-- function BattleMoveStateActionForOthers:handlePreMoveNext()
--     print("BattleMoveStateActionForOthers:handlePreMoveNext start")
--     local nextCoord = self:getNextCoord()
--     -- local tileData = MapDataManager:getInstance():getTileDataAtCoord(self._battleMachine._model:getMapData(), nextCoord.x, nextCoord.y)
--     local tileData = self._battleMachine._model:getMapData():getTileDataAtCoord(nextCoord.x, nextCoord.y)
--     -- print("BattleMoveStateActionForOthers:handlePreMoveNext tileData=",tileData)

--     if tileData then
--         -- TODO 判断下一格是否可以移动过去以及是否有怪物是否需要进入战斗
--         if not tileData:isReachable() then
--             -- if self:judageWasMaster() then
--             --     -- TODO 判断是否为宝箱等需要触发的组件
                
--             -- else

--             -- end
--             -- print("BattleMoveStateActionForOthers:handlePreMoveNext no isReachable")
--         else
--             -- print("BattleMoveStateActionForOthers:handlePreMoveNext isReachable")
--             if tileData:canBeNodeOfPath() == false then
--                 print("BattleMoveStateActionForOthers:handlePreMoveNext canBeNodeOfPath is false  isMaster=",self:judageWasMaster())
--                 -- if self:judageWasMaster() then
--                 --     -- TODO 判断是否为怪物，地刺等需要触发
--                 --     if tileData.roleDatas then
--                 --         print("BattleMoveStateActionForOthers:handlePreMoveNext 1")
--                 --         for _, roleData in pairs(tileData.roleDatas) do
--                 --             print("BattleMoveStateActionForOthers:handlePreMoveNext 2 key,type,Monster=",_,roleData:getType(),roleData:getCategory(),RoleType.Monster)
--                 --             if not roleData:getType() then
--                 --                 for k,v in pairs(roleData) do
--                 --                     print("BattleMoveStateActionForOthers:handlePreMoveNext k,v=",k,v)
--                 --                 end 
--                 --             end
--                 --             if roleData:getType() == RoleType.Monster then
 
--                 --             elseif roleData:getType() == RoleType.Monster then

--                 --             end
--                 --         end
--                 --     end
--                 -- end
--             else
--                 return true
--             end
--         end
--     end

--     return false
-- end