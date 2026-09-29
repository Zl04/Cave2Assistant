--[[
    游戏中对象：npc等
]]--

require "app.object.GameModel"

Model = Model or {}

local Npc = class("Npc", Model.Base)
Model.Npc = Npc

-- private:
-- 构造函数
function Npc:ctor(category, type)
    Npc.super.ctor(self, category, type)

    -- 角色数据
    self._npcData = nil
    -- 角色id
    self._spriteID = 0
end

-- 析构函数
function Npc:dtor()
    Npc.super.dtor(self)
    -- print("---------  Npc:dtor  ",self:getId())
    -- assert(false, "")
    self._npcData = nil
end

-- public:
-- 初始化
function Npc:init(data, fsm, geometric)
    Npc.super.init(self, fsm, geometric)
    -- print("---------  Npc:init  ",self:getId(),data)
    self._npcData = data
    -- 设置同步服务器spriteID
    if (data.spriteID) then
        self._spriteID = data.spriteID
    end

    -- 角色待机
    self:idle()
end

-- 清理
function Npc:clear()
    Npc.super.clear(self)
    -- print("---------  Npc:clear  ",self:getId())
    self._npcData = nil
    self._spriteID = 0
end

-- 设置为待机状态
function Npc:idle()
    local success = self:switchState(TriggerNPCState.IDLE)
    -- print("Npc:idle  ",success)
    if (success) then
        if (self._renderer) then 
            self._renderer:idle()
        end 
    end
end

-- 获取角色数据
function Npc:getData()
    return self._npcData
end

-- 获取角色数据
function Npc:getNpcData()
    -- print("---------  Npc:getNpcData  ",self:getId(),self._npcData)
    return self._npcData
end

-- 获取服务器同步的精灵ID
function Npc:getSpriteID()
    return self._spriteID
end

-- 开启
function Npc:open()
    self._npcData:open()
end

-- 触发
function Npc:trigger()
    if(self._npcData) then
        self._npcData:trigger()
    end
end

-- 打印信息
function Npc:print()
    local roleTypeName = "Npc"
    local type = self:getType()
    -- if (type == RoleType.Hero) then
    --     roleTypeName = "Hero"
    -- elseif (type == RoleType.Monster) then
    --     roleTypeName = "Monster"
    -- else
    --     assert(false)
    -- end

    -- print("------------------------")
    -- print(string.format("%s info:", roleTypeName))
    -- local coord = self:getCoord()
    -- print(string.format("id:%d  sprite id:%d  state:%d  coord:(%f,%f).", self:getId(), self:getSpriteID(), self:getState(), coord.x, coord.y))
    -- print("------------------------")
end