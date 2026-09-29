--[[
    游戏引擎系统：数据模型
]]--

Machine = Machine or {}

local Model = class("MachineModel")
Machine.Model = Model

-- public:
-- 构造函数
function Model:ctor()
    printError("[ERROR] Model constructor method should be overrided.")
end

-- 销毁
function Model:destroy()
    printError("[ERROR] Model destroy method should be overrided.")
end

-- 初始化
function Model:init()
    printError("[ERROR] Model init method should be overrided.")
end

-- 清理
function Model:clear()
    printError("[ERROR] Model clear method should be overrided.")
end

-- 添加模型
function Model:addModel(model)
    printError("[ERROR] Model addModel method should be overrided.")
end

-- 删除模型
function Model:removeModel(model)
    printError("[ERROR] Model removeModel method should be overrided.")
end

