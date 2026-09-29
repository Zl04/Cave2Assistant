--[[
    角色Zorder 管理
]]--

require "app.action.BattleAction"
require "app.action.Action"
require "app.pool.Pool"

Action = Action or {}

local RoleZorderAction = class("RoleZorderAction", Action.BattleAction)
Action.RoleZorderAction = RoleZorderAction

local DEBUG = false

-- private:
-- 对象池
local RoleZorderActionPool = nil

-- public:
-- 创建对象
function RoleZorderAction:create(reused, ...)
    if (reused) then
        if (not RoleZorderActionPool) then
            RoleZorderActionPool = Pool.Pool:create(RoleZorderAction)
        end
        return RoleZorderActionPool:applyObject()
    else
        return RoleZorderAction.new(...)
    end
end

-- 构造函数
function RoleZorderAction:ctor()
    RoleZorderAction.super.ctor(self, ActionType.FUNCTION_ROLE_ZOEDER)
end

-- 模版函数：销毁
function RoleZorderAction:dtor()
    RoleZorderAction.super.dtor(self)

end

function RoleZorderAction:init(preCoord,nowCoord,kickSpriteID)
    RoleZorderAction.super.init(self)
    
    self._preCoord = preCoord
    self._nowCoord = nowCoord
    self._kickSpriteID = kickSpriteID
end

-- 清理
function RoleZorderAction:clear()
    RoleZorderAction.super.clear(self)
end

-- 模版函数：action开始
function RoleZorderAction:onStart()
    -- TODO 处理添加角色处理
    if (self._preCoord) then
        if DEBUG then
            print("RoleZorderAction:onStart  self._preCoord.x, self._preCoord.y=",self._preCoord.x, self._preCoord.y)
        end
        local tileData = self._battleModel:getMapData():getTileDataAtCoord(self._preCoord.x, self._preCoord.y)
        if tileData then
            self:_handleOrder(tileData)
        end 
    end

    if (self._nowCoord) then
        if DEBUG then
            print("RoleZorderAction:onStart  self._nowCoord.x, self._nowCoord.y=",self._nowCoord.x, self._nowCoord.y)
        end
        local tileData = self._battleModel:getMapData():getTileDataAtCoord(self._nowCoord.x, self._nowCoord.y)
        if tileData then
            self:_handleOrder(tileData)
        end 
    end

    return true
end

-- 模版函数：action结束
function RoleZorderAction:onEnd()
    -- TODO
end

function RoleZorderAction:onFail()
    -- TODO
end

function RoleZorderAction:_handleOrder(tileData)
    if tileData then
        local allRoleData = {}
        for _, roleData in ipairs(tileData.roleDatas) do
            if roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Hero then
                if roleData:getSpriteID() ~= self._kickSpriteID and roleData:getState() ~= FSMState.BATTLE then
                    table.insert(allRoleData,roleData)
                end
            end
        end

        local offsetZ = 1
        local masterData = nil

        local totalRoleNum = #allRoleData
        for _, roleData in ipairs(allRoleData) do
            if roleData:isMasterHero() == true then
                masterData = roleData
            else
                local isShow = false
                if offsetZ >= totalRoleNum then
                    -- 显示名字
                    isShow = true
                end
                -- 更新渲染Z轴
                self:_pushRendererZorder(roleData.spriteID,offsetZ,isShow)
                
                offsetZ = offsetZ + 1
            end
        end
        if masterData ~= nil then
            -- 更新渲染Z轴
            self:_pushRendererZorder(masterData.spriteID,offsetZ,true)
        end
    end
end

-- 推送一条更新z轴渲染指令
function RoleZorderAction:_pushRendererZorder(spriteID,offsetZ,nameIsShow)
    if DEBUG then
        print("RoleZorderAction:_pushRendererZorder  spriteID,offsetZ,nameIsShow=",spriteID,offsetZ,nameIsShow)
    end
    local role = self._battleModel:getRoleBySpriteID(spriteID)
    if role then
        if DEBUG then
            print("RoleZorderAction:_pushRendererZorder  spriteID,x,y,offsetZ=",role:getSpriteID(),role:getCoord().x,role:getCoord().y,offsetZ)
        end
        local zorderCommand = Command.RendererCommand:create(true)
        zorderCommand:initUpdateZOrderCommand(role:getId(), role:getCoord(), offsetZ)
        self._battleMachine:pushCommand(zorderCommand)

        local nameCommand = Command.RendererCommand:create(true)
        nameCommand:initRoleName(role:getId(),role:getName(),nameIsShow,role:isMaster())
        self._battleMachine:pushCommand(nameCommand)
    end
end