--[[
    游戏引擎系统：视图
]]--

Machine = Machine or {}

local View = class("MachineView")
Machine.View = View

-- public:
-- 构造函数
function View:ctor()
    printError("[ERROR] View constructor method should be overrided.")
end

-- 销毁
function View:destroy()
    printError("[ERROR] View destroy method should be overrided.")
end

-- 初始化
function View:init()
    printError("[ERROR] View init method should be overrided.")
end

-- 清理
function View:clear()
    printError("[ERROR] View clear method should be overrided.")
end

-- 添加模型
function View:addView(model)
    printError("[ERROR] View addModel method should be overrided.")
end

-- 删除模型
function View:removeView(model)
    printError("[ERROR] View removeModel method should be overrided.")
end

-- 执行命令
function View:executeCommand(command)
    printError("[ERROR] View executeCommand method should be overrided.")
end

-- 绘制
function View:update(dt)
    printError("[ERROR] View update method should be overrided.")
end


