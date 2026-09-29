--[[
    池对象：具备对象池的回收和重用功能
]]--

require "app.pool.Pool"

Pool = Pool or {}

local PoolObject = class("PoolObject")
Pool.PoolObject = PoolObject

-- public:
-- 构造函数
function PoolObject:ctor()
    self._pool = nil
    self._reused = false
end

-- 模版方法：析构函数
function PoolObject:dtor()
   printError("[ERROR] PoolObject dtor: this method should be overrided by sub class.")
end

-- 销毁
function PoolObject:destroy()
    if (self._reused) then
        self._pool:returnObject(self)
    else
        self._pool = nil
        self:dtor()
    end
end

-- 初始化
function PoolObject:init()
    printError("[ERROR] PoolObject init: this method should be overrided by sub class.")
end

-- 清理
function PoolObject:clear()
    printError("[ERROR] PoolObject clear: this method should be overrided by sub class.")
end

-- 设置标志
function PoolObject:reuse(pool, reused)
    self._pool = pool
    self._reused = reused
end


