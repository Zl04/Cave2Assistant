--[[
    打开宝箱获得物品
]]--

require "app.action.Action"
local SceneManager = require("app.game.SceneManager")
Action = Action or {}

local GetGoodsAction = class("GetGoodsAction", Action.Base)
Action.GetGoodsAction = GetGoodsAction

local computeSpeedComp2 = Geome.computeSpeedComp2

-- private:
local DEBUG = false

-- 构造函数
function GetGoodsAction:ctor()
    GetGoodsAction.super.ctor(self, ActionType.AIRCRAFT_GETGOODS)

    self._flyTarget = nil
    self._flyToTarget = nil
    self._flyToMount = nil
end

-- 模版函数：销毁
function GetGoodsAction:dtor()
    GetGoodsAction.super.dtor(self)

    self._flyTarget = nil
    self._flyToTarget = nil
    self._flyToMount = nil
end

-- public:
-- 创建对象
local GetGoodsActionPool = nil
function GetGoodsAction:create(reused, ...)
    if (reused) then
        if (not GetGoodsActionPool) then
            GetGoodsActionPool = Pool.Pool:create(GetGoodsAction)
        end
        return GetGoodsActionPool:applyObject()
    else
        return GetGoodsAction.new(...)
    end
end

-- 初始化
function GetGoodsAction:init(target,isGoldenDark,openWithSelf,flyTarget, flyToTarget,flyToMount,startCoord)
    GetGoodsAction.super.init(self, target)

    self._isGoldenDark = isGoldenDark
    self._openWithSelf = openWithSelf
    self._flyTarget = flyTarget
    self._flyToTarget = flyToTarget
    self._flyToMount = flyToMount
    self._startCoord = startCoord
end

-- 清理
function GetGoodsAction:clear()
    GetGoodsAction.super.clear(self)

    self._flyTarget = nil
    self._flyToTarget = nil
    self._flyToMount = nil
    self._flyTime = 0
end

-- 模版函数：action开始
function GetGoodsAction:onStart()
    if DEBUG then
        if self._target then
            print(string.format("GetGoodsAction onStart: bullet (id:%d type:%d) is starting to fly.", self._target:getId(), self._target:getType()))
        end
    end

    local startCoord = Geome.Coord:create()
    if self._openWithSelf then
        if self._target then
            startCoord:setCoord(self._target:getCoord())
        else
            startCoord:setCoord(self._startCoord)
        end
    else
        startCoord:setCoord(self._flyToTarget:getCoord())
    end

    if DEBUG then
        print("GetGoodsAction:onStart   _openWithSelf=",self._openWithSelf)
    end

    -- 判断是否为需要打开操作的模型
    if self._target == nil or (self._target:getCategory() == Category.ROLE and self._target:getType() ==  RoleType.Monster) or 
        (self._target:getCategory() == Category.TRIGGER_NPC and self._target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_TREASURE_MAP) or
        (self._target:getCategory() == Category.TRIGGER_NPC and self._target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_MOLD) then
        -- 不需要打开操作（怪物）
        if self._flyTarget and self._flyToTarget then
            local getGoodsCommand = Command.RendererCommand:create(true)
            getGoodsCommand:initAddGoodsStateCommmand(self._flyTarget:getId(),self._openWithSelf, startCoord, self._flyToTarget:getId(), self._flyToMount, true)
            SceneManager:getInstance():pushCommand(getGoodsCommand)
        end
    else
        if(self._target:getCategory() == Category.TRIGGER_NPC and self._target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            
        else
            -- 需要打开操作(宝箱，钱袋等)
            if(self._flyTarget and self._flyToTarget) then
                local openItCommand = Command.RendererCommand:create()
                openItCommand:initGetDarkGoldenCommand(self._target:getId(),self._isGoldenDark,self._openWithSelf,self._flyTarget:getId(),startCoord,self._flyToTarget:getId(),self._flyToMount,self._flyTime)
                SceneManager:getInstance():pushCommand(openItCommand)
            end
        end
    end

    return true
end

-- action更新
function GetGoodsAction:onUpdate(dt)

    return true
end

-- 模版函数：action结束
function GetGoodsAction:onEnd()

end