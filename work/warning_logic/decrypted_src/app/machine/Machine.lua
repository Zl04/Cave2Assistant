--[[
    游戏引擎系统
]]--

require "app.command.Command"
require "app.action.ActionTrack"

Machine = Machine or {}

local Base = class("MachineBase")
Machine.Base = Base

-- private:
-- 清理command列表
function Base:_clearCommandList(commandList)
    if (commandList) then
        -- for i = 1, #commandList do
        for i = #commandList, 1, -1 do
            local command = commandList[i]
            command:destroy()
            commandList[i] = nil
        end
    end
end

-- public:
-- 构造函数
function Base:ctor()
    -- 数据模型
    self._model = nil
    -- 视图
    self._view = nil
    -- 音效
    self._audio = nil

    -- 暂停标志
    self._paused = false
    -- 逻辑命令列表
    self._commandList = nil
    self._commandListSize = 0
    -- 渲染命令列表
    self._rendererCommandList = nil
    self._rendererCommandListSize = 0
    -- 音效命令列表
    self._playerCommandList = nil
    self._playerCommandListSize = 0
    -- 所有action的执行轨道
    self._actionTrack = nil

    self._delayUnloadArr = {}

    Avalon.Scheduler:scheduleUpdate(self, Base.update)
end

-- 销毁 isSimple：是否保留model 和 view
function Base:destroy(isSimple)
    -- 把所有的消息都给执行完一遍，避免在切换场景的时候出现消息没有处理完成的情况
    self:update(0.01)

    self._actionTrack:destroy()
    self._actionTrack = nil
    if isSimple == true then
    else
        if (self._view) then 
            self._view:destroy()
            self._view = nil
        end

        if (self._model) then
            self._model:destroy()
            self._model = nil
        end
    end

    if (self._audio) then
        self._audio:destroy()
        self._audio = nil
    end

    self:_clearCommandList(self._commandList)
    self:_clearCommandList(self._rendererCommandList)
    self:_clearCommandList(self._playerCommandList)
    self._commandList = nil
    self._rendererCommandList = nil
    self._playerCommandList = nil

    Avalon.Scheduler:unscheduleUpdate(self, Base.update)

    -- 处理释放场景中没有释放的资源
    if(self._delayUnloadArr) then 
        for k, v in ipairs(self._delayUnloadArr) do 
            Avalon.ResHelper:unloadSpine(v.skeletonFile, v.atlasFile, v.scale)
        end
    end
    self._delayUnloadArr = {}
end

-- 初始化
function Base:init(machineModel, machineView, machineAudio)
    self._model = machineModel
    self._view = machineView
    self._audio = machineAudio

    self._commandList = {}
    self._rendererCommandList = {}
    self._playerCommandList = {}
    self._commandListSize = 0
    self._rendererCommandListSize = 0
    self._playerCommandListSize = 0

    self._actionTrack = Action.ActionTrack:create()
    self._actionTrack:init()
end

-- 清理：
function Base:clear()
    if (self._model) then
        self._model:clear()
    end
    if (self._view) then 
        self._view:clear()
    end
    if (self._audio) then
        self._audio:clear()
    end

    self._clearCommandList(self._commandList)
    self._clearCommandList(self._rendererCommandList)
    self._clearCommandList(self._playerCommandList)
    self._commandListSize = 0
    self._rendererCommandListSize = 0
    self._playerCommandListSize = 0
    
    if(self._actionTrack) then 
        self._actionTrack:clear()
    end
end

-- 添加模型
function Base:addModel(model)
    if (self._model) then
        self._model:addModel(model)
    end
    if (self._view) then
        self._view:addView(model)
    end
end

-- 删除模型
function Base:removeModel(model)
    if (self._model) then
        self._model:removeModel(model)
    end
    if (self._view) then
        self._view:removeView(model)
    end
end

-- 获取游戏模型
function Base:getModel()
    return self._model
end

-- 获取游戏界面
function Base:getView()
    return self._view
end

-- 添加命令
function Base:pushCommandList(commandList)
    if (commandList) then
        for i = 1, #commandList do
            local command = commandList[i]
            self:pushCommand(command)
        end
    end
end

-- 添加命令
function Base:pushCommand(command)
    local category = command.category
    -- 渲染命令
    if (category == CommandCategory.RENDERER) then
        if (self._view) then
            self._rendererCommandListSize = self._rendererCommandListSize + 1
            self._rendererCommandList[self._rendererCommandListSize] = command
        else
            command:destroy()
        end
    -- 音效命令
    elseif (category == CommandCategory.PLAYER) then
        if (self._audio) then
            self._playerCommandListSize = self._playerCommandListSize + 1
            self._playerCommandList[self._playerCommandListSize] = command
        else
            command:destroy()
        end
    -- 逻辑命令
    else
        self._commandListSize = self._commandListSize + 1
        self._commandList[self._commandListSize] = command
    end
end

-- 执行命令
function Base:executeCommandList(commandList)
    if (commandList) then
        for i = 1, #commandList do
            local command = commandList[i]

            local category = command.category
            if(category == CommandCategory.RENDERER or category == CommandCategory.PLAYER) then
                self:pushCommand(command)
            else
                xpcall(function()
                    self:executeCommand(command)
                end,
                function(e)
                    print("[ERROR] Machine executeCommandList: command run error")
                    AvalonUtil:handleTRACKBACK(e)
                end, 1);
            end
        end
    end
end

-- 模版函数：处理命令
function Base:executeCommand(command)
    printError("[ERROR] Machine Base onExecuteCommand: this method should be overrided.")
    return false
end

-- 更新
function Base:update(dt)
    if (self._isPause) then return end

   -- 执行逻辑命令
    if (self._commandListSize > 0) then
        local i = 1
        repeat
            local command = self._commandList[i]
            self._commandList[i] = nil
            i = i + 1
            
            if (command) then
                xpcall(function()
                    self:executeCommand(command)
                    command:destroy()
                end,
                function(e) 
                    command:destroy()
                    print("[ERROR] Machine update: command run error")
                    AvalonUtil:handleTRACKBACK(e)
                end, 1);
            else
                printError(string.format("[ERROR] Machine update: command is nil. (index:%d size:%d %d)", i, #self._commandList, self._commandListSize))
            end

        until (i > self._commandListSize)
        self._commandListSize = 0
    end
    -- 执行action
    self._actionTrack:execute(dt)

    -- 执行渲染命令
    if (self._view) then
        if (self._rendererCommandListSize > 0) then
            commandList = self._rendererCommandList
            local i = 1
            repeat
                local command = commandList[i]
                commandList[i] = nil
                i = i + 1

                if (command) then
                    xpcall(function()
                        self._view:executeCommand(command)
                        command:destroy()
                    end,
                    function(e) 
                        command:destroy()
                        print("[ERROR] Machine update: command run error")
                        AvalonUtil:handleTRACKBACK(e)
                    end, 1);
                end

            until (i > self._rendererCommandListSize)
            self._rendererCommandListSize  = 0
        end
        -- 更新视图
        self._view:update(dt)
    end

    -- 执行音效命令
    if (self._audio) then
         if (self._playerCommandListSize > 0) then
            commandList = self._playerCommandList
            local i = 1
            repeat
                local command = commandList[i]
                commandList[i] = nil
                i = i + 1

                if (command) then
                    xpcall(function()
                        self._audio:executeCommand(command)
                        command:destroy()
                    end,
                    function(e) 
                        command:destroy()
                        print("[ERROR] Machine update: command run error")
                        AvalonUtil:handleTRACKBACK(e)
                    end, 1);
                end

            until (i > self._playerCommandListSize)
            self._playerCommandListSize  = 0
        end
    end
end

-- 暂停引擎
function Base:pause()
    self._isPause = true
end

-- 恢复引擎
function Base:resume()
    self._isPause = false
end

-- 删除模型
function Base:addDelayUnloadRes(skeletonFile, atlasFile, scale)
    local data = {skeletonFile = skeletonFile, atlasFile = atlasFile, scale = scale}
    table.insert(self._delayUnloadArr, data)
end