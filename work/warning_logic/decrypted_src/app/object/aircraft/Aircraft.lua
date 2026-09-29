--[[
    游戏中的飞行器
]]--

require "app.object.GameModel"

Model = Model or {}

local Aircraft = class("Aircraft", Model.Base)
Model.Aircraft = Aircraft

-- private:
-- 构造函数
function Aircraft:ctor(type)
    Aircraft.super.ctor(self, Category.AIRCRAFT, type)
end

-- 析构函数
function Aircraft:dtor()
    Aircraft.super.dtor(self)
end

-- public:
-- 初始化
function Aircraft:init(data, fsm, geometric)
    Aircraft.super.init(self, fsm, geometric)
end

-- 初始化视图
function Aircraft:initView(renderer)
    Aircraft.super.initView(self, renderer)
end

-- 清理
function Aircraft:clear()
    Aircraft.super.clear(self)
end

-- 获取数据
function Aircraft:getData()
    return nil
end