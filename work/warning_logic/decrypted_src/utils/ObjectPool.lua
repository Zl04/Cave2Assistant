--[[
    对象池子
]]

local ObjectPool = class("ObjectPool")

local DEBUG = false

-- 构造函数
-- @size 初始容量
-- @increasement 池子的增量
function ObjectPool:ctor(createObjectFunc, destroyObjectFunc, increasement, size)
    assert(type(createObjectFunc) == "function")
    assert(type(destroyObjectFunc) == "function")
    if (increasement) then assert(type(increasement) == "number") end
    if (size) then assert(type(size) == "number") end

    self._createObjectFunc = createObjectFunc
    self._destroyObjectFunc = destroyObjectFunc
    self._increasement = increasement or 10
    
    self._store = {}
    self._capacity = 0
    self._pool = {}
    self._size = 0

    size = size or 0
    if (size > 0) then
        self:createObject(size)
    end
end

-- 创建对象
function ObjectPool:createObject(size)
    assert(type(size) == "number")

    for i = 1, size do
        local object = self._createObjectFunc()
        if (object) then
            self._size = self._size + 1
            self._pool[self._size] = object

            self._capacity = self._capacity + 1
            self._store[self._capacity] = object

            if (DEBUG) then
                print(string.format("ObjectPool createObject: pool:%s capacity:%d size:%d. ", self, self._capacity, self._size))
            end
        end
    end
end

-- 获取一个对象
function ObjectPool:getObject()
    if (self._size == 0) then
        self:createObject(self._increasement)
    end

    if (self._size > 0) then
        local object = self._pool[self._size]
        self._size = self._size - 1
        return object
    else
        return nil
    end
end

-- 回收对象
function ObjectPool:returnObject(object)
    if (object) then
        self._size = self._size + 1
        self._pool[self._size] = object

        if (DEBUG) then
            print(string.format("ObjectPool returnObject: pool:%s capacity:%d size:%d. ", self, self._capacity, self._size))
        end
    end
end

-- 销毁对象池
function ObjectPool:destroy()
    for i = 1, self._capacity do
        local object = self._store[i]
        self._destroyObjectFunc(object)
    end

    self._pool = nil
    self._store = nil
end

return ObjectPool