--[[
    处理一次战斗的战场管理，这里处理角色站位以及朝向问题
]]

require "app.object.GameModel"
local SceneManager = require("app.game.SceneManager")
local computeDirection = Geome.computeDirection
local MachineManager = require("app.game.MachineManager")

Model = Model or {}

local BattleField = class("BattleField", Model.Base)
Model.BattleField = BattleField

local DEBUG = false

local BattleFieldPool = nil
function BattleField:create(reused, ...)
    if (reused) then
        if (not BattleFieldPool) then
            BattleFieldPool = Pool.Pool:create(BattleField)
        end
        return BattleFieldPool:applyObject()
    else
        return BattleField.new(...)
    end
end

-- public 
-- 构造函数
function BattleField:ctor()
    BattleField.super.ctor(self, Category.None, 0)
    -- 角色列表
    self._roleMap = {}
    -- 角色队列
    self._roleList = Avalon.List:create()

    -- 所有对象ID列表 只是用于判断是否在战场里面
    self._allSpriteIDMap = {}

    self._haveMaster = false
    self._monster = {}
    self._monsterAttackSpriteID = nil
    self._targetMonster = nil
end

-- 析构函数
function BattleField:dtor()
    BattleField.super.dtor(self)
    self._roleMap = nil
    self._roleList = nil
    self._allSpriteIDMap = nil

    self._monster = {}
    self._monsterAttackSpriteID = nil
    self._targetMonster = nil
end

-- 清理
function BattleField:clear()
    BattleField.super.clear(self)
    if self._roleMap then
        for k,v in pairs(self._roleMap) do
            self._roleMap[k] = nil
        end
    end 

    if self._roleList then
        self._roleList:clear()
    end

    if self._allSpriteIDMap then
        for k,v in pairs(self._allSpriteIDMap) do
            self._allSpriteIDMap[k] = nil
        end
    end

    self._haveMaster = false
    self._monster = {}
    self._monsterAttackSpriteID = nil
    self._targetMonster = nil
end

-- 是否可以回收
function BattleField:canRecover()
    for k,v in pairs(self._roleMap) do

        return false
    end

    return true
end

-- 判断是否为同一个战场
function BattleField:judgeSameBattleField(spriteID,targetSpriteID)
    if DEBUG then
        print("BattleField:judgeSameBattleField 1 ",spriteID,targetSpriteID)
    end
    if(spriteID == nil or targetSpriteID == nil) then
        return false
    end

    -- dump(self._allSpriteIDMap)

    local found = false
    if(self._roleMap[spriteID] or self._allSpriteIDMap[spriteID]) then
        found = true
    end

    if(found) then
        if(self._roleMap[targetSpriteID] or self._allSpriteIDMap[targetSpriteID]) then
            return true
        end
    end

    return false
end

function BattleField:judgeInBattleField(spriteID,targetSpriteID)
    if DEBUG then
        print("BattleField:judgeInBattleField 1 ",spriteID,targetSpriteID)
    end
    if spriteID then
        if self._roleMap[spriteID] then
            if DEBUG then
                print("BattleField:judgeSameBattleField 2 ",spriteID,targetSpriteID)
            end
            return true
        end

        if self._allSpriteIDMap[spriteID] then
            return true
        end
    end

    if targetSpriteID then
        if self._roleMap[targetSpriteID] then
            if DEBUG then
                print("BattleField:judgeSameBattleField 3 ",spriteID,targetSpriteID)
            end
            return true
        end

        if self._allSpriteIDMap[targetSpriteID] then
            return true
        end
    end

    return false
end

--[[
    加入一个角色
    role:当前角色
    targetSpriteID: 目标场景ID
]]
function BattleField:addRole(role,targetSpriteID,isEnter, isSwitch)
    if  not role then

        return false
    end
    if DEBUG then
        print("BattleField:addRole 2222222222222222222  ", role:getSpriteID(), targetSpriteID, isEnter)
    end
    if(targetSpriteID) then
        self._allSpriteIDMap[targetSpriteID] = targetSpriteID
    end
    self._allSpriteIDMap[role:getSpriteID()] = role:getSpriteID()

    if self._roleMap[role:getSpriteID()] and self._targetMonster and not isEnter and not isSwitch then
        -- 处理刷新在前面加入战场的时候有些角色还没有开始运行战斗action 导致位置不对的BUG。
        self:_allocationStation(role,false)

        -- 处理恢复血条的表现逻辑
        if role:getType() == RoleType.Monster then
            if (self:judgeSameBattleField(role:getSpriteID(), RoleDataManager:getMasterSpriteID()) == false) and self._monster[role:getSpriteID()] then
                local roleData = role:getData()
                local battleModel = MachineManager:getInstance():getMachine():getModel()
                local sprite = battleModel._roleMap[targetSpriteID]
                if(roleData and sprite ~= nil and sprite:getType() == RoleType.Hero) then
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initShowMonsterBlood(role:getId(), roleData:getCurHp(), roleData:getHp())
                    SceneManager:getInstance():pushCommand(renderCommand)
                end
            end
        end
        return false
    else
        if isSwitch then
            self:_allocationStation(role,false)
        end

        role.stationNum = nil
        role.stationDirection = nil

        -- 添加角色数据
        self._roleList:push_back(role)
        self._roleMap[role:getSpriteID()] = role

        if DEBUG then
            print("BattleField:addRole 4  ",role:getSpriteID(),role:isMaster(),role:getType(),self:getId())
        end
        if role:getType() == RoleType.Hero then
            if role:isMaster() then
                self._haveMaster = true
            end
        end
        if role:getType() == RoleType.Monster then
            if isEnter then
                self._targetMonster = role
            end
            -- self._monster = role
            self._monster[role:getSpriteID()] = role
            self._monsterAttackSpriteID = targetSpriteID

            -- 判断是否和主角一个战场，不是就添加显示怪物血条
            if(self:judgeSameBattleField(role:getSpriteID(), RoleDataManager:getMasterSpriteID()) == false) then
                local roleData = self._monster[role:getSpriteID()]:getData()--self._targetMonster:getData()
                local battleModel = MachineManager:getInstance():getMachine():getModel()
                local sprite = battleModel._roleMap[targetSpriteID]
                if(roleData and sprite ~= nil and sprite:getType() == RoleType.Hero) then
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initShowMonsterBlood(role:getId(), roleData:getCurHp(), roleData:getHp())
                    SceneManager:getInstance():pushCommand(renderCommand)
                end
            end
        else
            -- 是否需要移除怪物血条显示
            if(self._targetMonster) then
                if(self:judgeSameBattleField(self._targetMonster:getSpriteID(), RoleDataManager:getMasterSpriteID())) then
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initRemoveMonsterBlood(self._targetMonster:getId())
                    SceneManager:getInstance():pushCommand(renderCommand)
                end
            end
        end

        if DEBUG then
            print("BattleField:addRole 5  ",self._haveMaster,self._targetMonster)
        end

        -- 重新分配编号
        self:_allocationStation(role,false)

        return true
    end
end

-- 移除一个角色
function BattleField:removeRole(role)
    if  not role then

        return false
    end
    if DEBUG then
        print("BattleField:removeRole 2222222222222222222  ", role:getSpriteID())
    end
    self._allSpriteIDMap[role:getSpriteID()] = nil

    if self._roleMap[role:getSpriteID()] then
        if self._roleList then
            self._roleList:remove(role)
        end

        self._roleMap[role:getSpriteID()] = nil

        if role:getType() == RoleType.Hero then
            if role:isMaster() then
                self._haveMaster = false
            end
        end

        if role:getType() == RoleType.Monster then
            if(self._monster and self._monster[role:getSpriteID()]) then 
                -- 移除显示怪物血条
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initRemoveMonsterBlood(self._monster[role:getSpriteID()]:getId())
                SceneManager:getInstance():pushCommand(renderCommand)
            end

            -- self._monster = nil
            self._monster[role:getSpriteID()] = nil
            self._monsterAttackSpriteID = nil
        else
            if(self._monster[role:getSpriteID()]) then
                local userNum = 0
                local battleModel = MachineManager:getInstance():getMachine():getModel()
                for _,v in pairs(self._allSpriteIDMap) do
                    local sprite = battleModel._roleMap[v]
                    if sprite and sprite:getType() == RoleType.Hero then
                        userNum = userNum + 1
                    end
                end
                -- 处理自己一个人离开战斗会闪一下血条BUG
                if(userNum >=2) then
                    if(self:judgeSameBattleField(self._monster[role:getSpriteID()]:getSpriteID(), RoleDataManager:getMasterSpriteID()) == false) then
                        local roleData = self._monster[role:getSpriteID()]:getData()
                        if(roleData) then
                            local renderCommand = Command.RendererCommand:create(true)
                            renderCommand:initShowMonsterBlood(self._monster[role:getSpriteID()]:getId(), roleData:getCurHp(), roleData:getHp())
                            SceneManager:getInstance():pushCommand(renderCommand)
                        end
                    end
                elseif userNum == 1 then 
                    if(self._monster[role:getSpriteID()]) then 
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initRemoveMonsterBlood(self._monster[role:getSpriteID()]:getId())
                        SceneManager:getInstance():pushCommand(renderCommand)
                    end
                end 
            end
        end

        -- 重新分配编号
        self:_allocationStation(role,true)

        role.stationNum = nil
        role.stationDirection = nil

        return true
    else
        assert(false)
        return false
    end
end

-- 判断里面是否有玩家
function BattleField:haveMaster()

    return self._haveMaster
end

-- 获取当前攻击怪物
function BattleField:getTargetMonster()

    return self._targetMonster
end

-- 获取怪物
function BattleField:getMonster()

    return self._monster
end

-- 分配位置
function BattleField:_allocationStation(role,removeFlag)
    if not role then
        return
    end
    if DEBUG then
        print("BattleField:_allocationStation 1  ",role:getSpriteID(),removeFlag)
    end
    if removeFlag then
        if role:getType() == RoleType.Hero then
            local monster = self:getTargetMonster()
            if DEBUG then
                print("BattleField:_allocationStation 2  ")
            end
            if monster then
                if DEBUG then
                    if not monster:getCoord() then
                        print("BattleField:_allocationStation  ",monster:getCoord(),monster:getType(),monster._geometric)
                        for k,v in pairs(monster) do
                            print("BattleField:_allocationStation  k,v=",k,v)
                        end
                    end
                end

                -- 更新这个位置的角色位置
                local direction = self:_computeDirection(role,monster)
                if DEBUG then
                    print("BattleField:_allocationStation  computeDirection ",role:getCoord().x,role:getCoord().y,monster:getCoord().x,monster:getCoord().y,direction)
                end
                role.stationDirection = direction
                
                if DEBUG then
                    print("BattleField:_allocationStation 3  ",role.stationDirection)
                end

                self:_refreshStation(direction,true)
            end
        else
            if DEBUG then
                print("BattleField:_allocationStation 4  ")
            end

            -- 全部更新位置
            self:_refreshAllStation()
        end
    else
        -- 判断类型
        if role:getType() == RoleType.Monster then
            if DEBUG then
                print("BattleField:_allocationStation 5  ")
            end

            -- 全部更新位置
            self:_refreshAllStation()
        elseif role:getType() == RoleType.Hero then
            local monster = self:getTargetMonster()
            if DEBUG then
                print("BattleField:_allocationStation 6  ",monster)
            end
            if monster then
                if DEBUG then
                    if not monster:getCoord() then
                        print("BattleField:_allocationStation  error",monster:getCoord(),monster:getType(),monster._geometric)
                        for k,v in pairs(monster) do
                            print("BattleField:_allocationStation error  k,v=",k,v)
                        end
                    end
                end
                -- 更新这个位置的角色位置
                local direction = self:_computeDirection(role,monster)
                if DEBUG then
                    print("BattleField:_allocationStation  computeDirection ",role:getCoord().x,role:getCoord().y,monster:getCoord().x,monster:getCoord().y,direction)
                end
                role.stationDirection = direction
                
                self:_refreshStation(direction,true)
            end
        end
    end
end

function BattleField:_refreshAllStation()
    local monster = self:getTargetMonster()
    if monster then
        self._roleList:traverse(nil, function(target,v)
            if DEBUG then
                print("BattleField:_refreshAllStation 1",v:getSpriteID())
            end
            if v:getType() == RoleType.Hero then
                if DEBUG then
                    if not v:getCoord() then
                        print("BattleField:_refreshStation  error",v:getCoord(),v:getType(),v._geometric)
                        for k1,v1 in pairs(v) do
                            print("BattleField:_refreshStation error  k,v=",k1,v1)
                        end
                    end
                end

                local direction = self:_computeDirection(v,monster)
                v.stationDirection = direction
            end
        end)

        if DEBUG then
            print("BattleField:_refreshAllStation 2",self._roleList:size())
        end

        self:_refreshStation(DirectionType.WEAST,true)
        self:_refreshStation(DirectionType.NORTH,true)
        self:_refreshStation(DirectionType.EAST,true)
        self:_refreshStation(DirectionType.SOUTH,true)
    end
end

function BattleField:_refreshStation(direction,refreshAll)
    local stationArr = {}
    local noHandleRole = {}
    local master = nil
    if DEBUG then
        print("BattleField:_refreshStation 1  ",direction,refreshAll)
    end

    -- 按照玩家自己在最前方的位置
    local master = nil
    self._roleList:traverse(nil, function(target,v)
        if DEBUG then
            print("BattleField:_refreshStation 2  ",v:getSpriteID(),v.stationDirection)
        end
        if v:getType() == RoleType.Hero and v.stationDirection == direction then
            if DEBUG then
                print("BattleField:_refreshStation 3  ",v:getSpriteID(),v.stationDirection,v.stationNum)
            end
            if v:isMaster() then
                master = v
            else
                table.insert(noHandleRole,v)
            end
        end
    end)

    local keepStationNum = 0
    if master then
        keepStationNum = 1
        -- 这里需要区别一下怪物是否为boss 
        local monster = self:getTargetMonster()
        if(monster and monster:isBigBoss()) then
            if #noHandleRole > 0 then
                keepStationNum = 3
            end
        else
            if direction == DirectionType.NORTH or direction == DirectionType.EAST then
                if #noHandleRole > 0 then
                    keepStationNum = 2
                end
            end
        end
    end

    -- 如果需要不变换位置，需要在这里屏蔽变换位置处理逻辑
    if(SceneManager:getInstance():isActivityCave()) then
        if noHandleRole and #noHandleRole >0 then
            local noStation = {}
            local maxStationNum = 0
            for k,v in pairs(noHandleRole) do
                local i = #stationArr + 1
                if i == keepStationNum then
                    table.insert(stationArr, master)
                    master.stationNum = i
                    master = nil
                else 
                    table.insert(stationArr, v)
                    if(v.stationNum == nil) then 
                        table.insert(noStation, v)
                    end
                end
                if(v.stationNum and v.stationNum > maxStationNum) then 
                    maxStationNum = v.stationNum
                end
            end

            for k,v in pairs(noStation) do 
                v.stationNum = maxStationNum + 1
                maxStationNum = maxStationNum + 1
            end
        end
    else
        if noHandleRole and #noHandleRole >0 then
            for k,v in pairs(noHandleRole) do
                local i = #stationArr + 1
                if i == keepStationNum then
                    stationArr[i] = master
                    master.stationNum = i
                    master = nil
                end

                i = #stationArr + 1
                stationArr[i] = v
                v.stationNum = i
            end
        end
    end

    if master then
        stationArr[keepStationNum] = master
        master.stationNum = keepStationNum
    end
    
    if DEBUG then
        print("BattleField:_refreshStation 5   ",#stationArr,keepStationNum,master)
    end

    -- 通知更新位置,这里可以过滤部分位置
    for k,v in pairs(stationArr) do
        local data = {}

        local coord = v:getCoord()
        if DEBUG then
            if not coord then
                print("BattleField:_refreshStation  error",v:getCoord(),v:getType(),v._geometric)
                for k1,v1 in pairs(v) do
                    print("BattleField:_refreshStation error  k,v=",k1,v1)
                end
            end
        end
        data.role = v
        data.coord = self:_stationNumToCoord(v.stationDirection,v.stationNum,#stationArr,coord)
        data.attackTarget = self._targetMonster

        if DEBUG then
            print("BattleField:_refreshStation  spriteID,coord.x,coord.y=",v:getSpriteID(),data.coord.x,data.coord.y)
        end

        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initForTypeAndData(CommandType.BATTLE_HANDLE_STATION,data)
        SceneManager:getInstance():pushCommand(battleCMD)

        local pets = v.getFightPet ~= nil and v:getFightPet() or nil
        for _, pet in pairs(pets) do 
            if pet and pet:getRoleData() and not pet:getRoleData():getIsDead() then
                local data = {}
                data.role = pet
                local x, y = self:getPetCoord(pet, v.stationDirection,v.stationNum,coord)
                data.coord = {x = x, y = y}
                data.attackTarget = self._targetMonster
    
                local battleCMD = Command.BattleCommand:create(true)
                battleCMD:initForTypeAndData(CommandType.BATTLE_HANDLE_STATION,data)
                SceneManager:getInstance():pushCommand(battleCMD)
            end
        end
        
    end

    -- 处理怪物攻击对象处理
    if self._targetMonster and self._monsterAttackSpriteID then
        local target = self._roleMap[self._monsterAttackSpriteID] 
        if target then
            -- 发送一条攻击对象消息
            local data = {}
            data.role = self._targetMonster
            data.attackTarget = target

            if DEBUG then
                print("BattleField:_refreshStation  send monster coord")
            end

            local battleCMD = Command.BattleCommand:create(true)
            battleCMD:initForTypeAndData(CommandType.BATTLE_HANDLE_STATION,data)
            SceneManager:getInstance():pushCommand(battleCMD)
        end
    end
end

--[[优先级1、站怪物两遍 2、站主角后面 3、站主角同位置]]
function BattleField:getPetCoord(target, direction,stationNum,coord)
    local _getPetCoord = function(target, x, y) 
        local GameMapManager = require("app.game.GameMapManager")
        local mapData = GameMapManager:getInstance():getMapData()
        if mapData then
            local titleData = mapData:getTileDataAtCoord(x, y)
            if titleData and titleData:isReachable() then
                local MachineManager = require("app.game.MachineManager")
                local list = MachineManager:getInstance():getMachine():getMapPath(target, x, y)
                if list and #list > 0 then
                    return true
                end
            end
        end
        return false
    end

    local monster = self:getTargetMonster()
    
    if monster then
        if not monster:isBigBoss() then
            local monsterCoord = monster:getCoord()
            if direction == DirectionType.SOUTH or direction == DirectionType.NORTH then
                if _getPetCoord(target, monsterCoord.x + 1, monsterCoord.y) then
                    return monsterCoord.x + 1, monsterCoord.y
                end
                if _getPetCoord(target, monsterCoord.x - 1, monsterCoord.y) then
                    return monsterCoord.x - 1, monsterCoord.y
                end
            else
                if _getPetCoord(target, monsterCoord.x, monsterCoord.y + 1) then
                    return monsterCoord.x, monsterCoord.y + 1
                end
                if _getPetCoord(target, monsterCoord.x, monsterCoord.y - 1) then
                    return monsterCoord.x, monsterCoord.y - 1
                end
            end
        end
    end
    if direction == DirectionType.SOUTH then
        if _getPetCoord(target, coord.x, coord.y + 1) then
            return coord.x, coord.y + 1
        end
    elseif direction == DirectionType.NORTH then
        if _getPetCoord(target, coord.x, coord.y - 1) then
            return coord.x, coord.y - 1
        end
    elseif direction == DirectionType.EAST then
        if _getPetCoord(target, coord.x - 1, coord.y) then
            return coord.x - 1, coord.y
        end
    elseif direction == DirectionType.WEAST then 
        if _getPetCoord(target, coord.x + 1, coord.y) then
            return coord.x + 1, coord.y
        end
    end    
    return coord.x, coord.y
end


function BattleField:_stationNumToCoord(direction,stationNum,allNum,coord)
    local newCoord = {}
    -- print("_stationNumToCoord pre=", stationNum)
    stationNum = stationNum % 3
    if(stationNum == 0) then 
        stationNum = 3
    end
    -- print("_stationNumToCoord end=", stationNum)

    -- 这里需要区别一下怪物是否为boss 
    local monster = self:getTargetMonster()
    if monster and monster:isBigBoss() then
        -- 处理boss 怪物战斗位置
        local monsterCoord = monster:getCoord()
        local size = monster:getOccupySize()
        local width = size[1]
        local height = size[2]

        -- 更具怪物坐标计算玩家站位
        newCoord.x = Avalon.MathUtil:getInt(monsterCoord.x)
        newCoord.y = Avalon.MathUtil:getInt(monsterCoord.y)
        newCoord.z = monsterCoord.z

        if direction == DirectionType.SOUTH or direction == DirectionType.EAST then
            -- 左边
            if stationNum == 1 then
                newCoord.x = newCoord.x - 1 + 0.3
                newCoord.y = newCoord.y + height - 0.3 
            elseif stationNum == 2 then
                newCoord.x = newCoord.x 
                newCoord.y = newCoord.y + height
            elseif stationNum == 3 then
                newCoord.x = newCoord.x - 1 + 0.2
                newCoord.y = newCoord.y + height - 1 - 0.1
            else
                assert(false, string.format("BattleField:_stationNumToCoord  stationNum=%d no handle.",stationNum))
            end
        else
            -- 右边
            if stationNum == 1 then
                newCoord.x = newCoord.x + width - 0.4
                newCoord.y = newCoord.y - 1 + 0.4 
            elseif stationNum == 2 then
                newCoord.x = newCoord.x + width - 0.1
                newCoord.y = newCoord.y - 0.1
            elseif stationNum == 3 then
                newCoord.x = newCoord.x + width -1
                newCoord.y = newCoord.y -1
            else
                assert(false, string.format("BattleField:_stationNumToCoord  stationNum=%d no handle.",stationNum))
            end
        end
    else
        -- 处理普通怪物战斗位置
        newCoord.x = Avalon.MathUtil:getInt(coord.x)
        newCoord.y = Avalon.MathUtil:getInt(coord.y)
        newCoord.z = coord.z

        if direction == DirectionType.EAST then
            if stationNum == 1 then
                if allNum ==1 then
                    newCoord.x = newCoord.x + 0.35
                    newCoord.y = newCoord.y + 0.35
                else
                    newCoord.x = newCoord.x + 0.45
                    newCoord.y = newCoord.y + 0.45
                end

                newCoord.zOrderLess = -3
            elseif stationNum == 2 then
                newCoord.x = newCoord.x + 0.46
                newCoord.y = newCoord.y + 0.1
                newCoord.zOrderLess = -1
            elseif stationNum == 3 then
                newCoord.x = newCoord.x + 0.1
                newCoord.y = newCoord.y + 0.45
                newCoord.zOrderLess = -2
            elseif stationNum == 4 then
                newCoord.x = newCoord.x + 0.1
                newCoord.y = newCoord.y + 0.1
                newCoord.zOrderLess = 0
            end
        elseif direction == DirectionType.WEAST then  
            if stationNum == 1 then
                if allNum ==1 then
                    newCoord.x = newCoord.x - 0.35
                    newCoord.y = newCoord.y - 0.35
                else
                    newCoord.x = newCoord.x - 0.45
                    newCoord.y = newCoord.y - 0.45
                end

                newCoord.zOrderLess = 0
            elseif stationNum == 2 then
                newCoord.x = newCoord.x - 0.45
                newCoord.y = newCoord.y - 0.1
                newCoord.zOrderLess = -1
            elseif stationNum == 3 then
                newCoord.x = newCoord.x - 0.1
                newCoord.y = newCoord.y - 0.46
                newCoord.zOrderLess = -2
            elseif stationNum == 4 then
                newCoord.x = newCoord.x - 0.1
                newCoord.y = newCoord.y - 0.1
                newCoord.zOrderLess = -3
            end
        elseif direction == DirectionType.SOUTH then
            if stationNum == 1 then
                if allNum ==1 then
                    newCoord.x = newCoord.x - 0.35
                    newCoord.y = newCoord.y - 0.35
                else
                    newCoord.x = newCoord.x - 0.45
                    newCoord.y = newCoord.y - 0.45
                end

                newCoord.zOrderLess = 0
            elseif stationNum == 2 then
                newCoord.x = newCoord.x - 0.1
                newCoord.y = newCoord.y - 0.45
                newCoord.zOrderLess = -1
            elseif stationNum == 3 then
                newCoord.x = newCoord.x - 0.46
                newCoord.y = newCoord.y - 0.1
                newCoord.zOrderLess = -2
            elseif stationNum == 4 then
                newCoord.x = newCoord.x - 0.1
                newCoord.y = newCoord.y - 0.1
                newCoord.zOrderLess = -3
            end
        elseif direction == DirectionType.NORTH then
            if stationNum == 1 then
                if allNum ==1 then
                    newCoord.x = newCoord.x + 0.35
                    newCoord.y = newCoord.y + 0.35
                else
                    newCoord.x = newCoord.x + 0.45
                    newCoord.y = newCoord.y + 0.45
                end

                newCoord.zOrderLess = -3
            elseif stationNum == 2 then
                newCoord.x = newCoord.x + 0.1
                newCoord.y = newCoord.y + 0.46
                newCoord.zOrderLess = -1
            elseif stationNum == 3 then
                newCoord.x = newCoord.x + 0.45
                newCoord.y = newCoord.y + 0.1
                newCoord.zOrderLess = -2
            elseif stationNum == 4 then
                newCoord.x = newCoord.x + 0.1
                newCoord.y = newCoord.y + 0.1
                newCoord.zOrderLess = 0
            end
        end          
    end

    return newCoord
end

function BattleField:_computeDirection(role, monster)
    local directionType = self:_computeNormalDirection(role, monster)
    if DEBUG then 
        print("BattleField:_computeDirection ", directionType, monster:isBigBoss())
    end
    if(monster:isBigBoss()) then
        if(directionType == DirectionType.WEAST or directionType == DirectionType.NORTH ) then
            return DirectionType.WEAST
        else
            return DirectionType.EAST
        end
    else
        return directionType
    end
end

function BattleField:_computeNormalDirection(role, monster)
    local srcCoord = role:getCoord()
    local dstCoord = monster:getCoord()

    -- 后期需要优化该逻辑
    if(srcCoord == nil or dstCoord == nil) then
        return DirectionType.NONE
    end

    if DEBUG then 
        print("BattleField:_computeNormalDirection srcCoord=", srcCoord.x, srcCoord.y, srcCoord.z)
        print("BattleField:_computeNormalDirection dstCoord=", dstCoord.x, dstCoord.y, dstCoord.z)
    end

    local newSrcCoord = {}
    newSrcCoord.x = Avalon.MathUtil:getInt(srcCoord.x)
    newSrcCoord.y = Avalon.MathUtil:getInt(srcCoord.y)
    newSrcCoord.z = Avalon.MathUtil:getInt(srcCoord.z)

    local newDstCoord = {}
    newDstCoord.x = Avalon.MathUtil:getInt(dstCoord.x)
    newDstCoord.y = Avalon.MathUtil:getInt(dstCoord.y)
    newDstCoord.z = Avalon.MathUtil:getInt(dstCoord.z)

    if (newSrcCoord.x < newDstCoord.x) then
        return DirectionType.EAST
    else 
        if (newSrcCoord.y < newDstCoord.y) then
            return DirectionType.NORTH
        else
            local size = monster:getOccupySize()
            local width = size[1] or 1
            local height = size[2] or 1
            local offsetX = newSrcCoord.x - newDstCoord.x 
            local offsetY = newSrcCoord.y - newDstCoord.y

            if (offsetX == width) then
                return DirectionType.WEAST
            elseif (offsetY == height) then
                return DirectionType.SOUTH
            else
                -- assert(false)

                -- assert(false, string.format("srccoord=%d,%d   dstcoord=%d,%d   width,height=%d,%d", srcCoord.x, srcCoord.y, dstCoord.x, dstCoord.y,width,height))
            end
        end
    end

    return DirectionType.EAST
    -- local directionType = DirectionType.NONE
    -- if(newSrcCoord.x > newDstCoord.x and newSrcCoord.y > newDstCoord.y) then
    --     local occupySize = monster:getOccupySize()
    --     local width = occupySize[1]
    --     local height = occupySize[2]

    --     if (newSrcCoord.x >= newDstCoord.x + width) then
    --         return DirectionType.WEAST
    --     end

    --     if(newSrcCoord.y >= newDstCoord.y + height) then
    --         return DirectionType.SOUTH
    --     end
    -- end
    -- print("BattleField:_computeNormalDirection dd=")

    -- return computeDirection(newSrcCoord, newDstCoord)
end
