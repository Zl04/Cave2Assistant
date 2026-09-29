--[[
    对象池
]]--

Pool = Pool or {}

local DEBUG = false

-- 角色事件基类
local Base = class("PoolBase")
Pool.Pool = Base

-- 对象池默认尺寸
Pool.POOL_SIZE = 10

-- public:
-- 构造函数
function Base:ctor(Class, size)
    assert(type(Class) == "table", "[ERROR] Avalon Pool: Class is invalid.")
    assert(type(size) == "number" or size == nil, "[ERROR] Avalon Pool: size is invalid.")
    if ((not size) or (size == 0)) then
        size = Pool.POOL_SIZE
    end

    local objects = {}
    for i = 1, size do
        objects[i] = Class:create()
        objects[i]:reuse(self, true)
    end

    self._objects = objects
    self._Class = Class
    self._size = size
    self._capacity = size
end

-- 销毁
function Base:destroy()
    local objects = self._objects
    for i = 1, #objects do
        local object = objects[i]
        object:reuse(nil, false)
        object:destroy()
    end
    self._objects = nil
end

-- 重置尺寸
function Base:resize(size)
    local objects = self._objects
    local Class = self._Class
    local currentSize = self._size

    if (size > currentSize) then
        for i = currentSize + 1, size do
            objects[i] = Class:create()
            objects[i]:reuse(self, true)
        end
    else
        for i = size + 1, currentSize do
            objects[i]:reuse(nil, false)
            objects[i]:destroy()
            objects[i] = nil
        end
    end
    self._size = size
    self._capacity = self._capacity + size

    if (DEBUG) then
        print(string.format("Avalon Pool: resize pool. [size:%d capacity:%d]", self._size, self._capacity))
    end
end

-- 申请对象
function Base:applyObject()
    if (self._size == 0) then
        self:resize(Pool.POOL_SIZE)
    end

    local object = self._objects[self._size]
    self._objects[self._size] = nil
    self._size = self._size - 1

    if (DEBUG) then
        print(string.format("Avalon Pool: apply object. [size:%d capacity:%d object:%s]", self._size, self._capacity, object))
    end
    if(object) then 
        object.using = true
    end

    return object
end

-- 返还对象
function Base:returnObject(object)
    if(object) then
        if(object.using == true) then
            object.using = nil
            self._size = self._size + 1
            if (self._size > self._capacity) then
                printError(string.format("Avalon Pool: fail to return object. [size:%d capacity:%d object:%s]", self._size, self._capacity, object))
            end

            object:clear()
            self._objects[self._size] = object
        else
            printError("Base:returnObject this object was repeat returnObject.", object.category, object.type)
        end

        if (DEBUG) then
            print(string.format("Avalon Pool: return object. [size:%d capacity:%d object:%s]", self._size, self._capacity, object))
        end
    else 
        printError("Avalon Pool: returnObject params object is nil.")
    end 
end


