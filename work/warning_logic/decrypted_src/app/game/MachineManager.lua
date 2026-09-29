-- MachineManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:引擎管理 


local MachineManager = class("MachineManager")
g_MachineManager = nil;

function MachineManager:ctor()
    self._machine = nil;       --当前引擎

end

function MachineManager:getInstance()
	if g_MachineManager == nil then
		g_MachineManager = MachineManager.new()
	end
	return g_MachineManager;
end

function MachineManager:purgeInstance()
	if g_MachineManager ~= nil then
		g_MachineManager = nil;
	end
end

function MachineManager:getMachine()
    return self._machine;
end

function MachineManager:setMachine(var)
    self._machine = var;
end

-- 设置action
function MachineManager:setAction(action)
    if (self._machine) then
        self._machine:setAction(action)
    else
        printError( "[ERROR] MachineManager setAction: no machine found.")
    end
end

-- 添加action
function MachineManager:addAction(action)
    if (self._machine) then
        self._machine:addAction(action)
    else
        printError( "[ERROR] MachineManager addAction: no machine found.")
    end
end

-- 添加模型
function MachineManager:addModel(model)
    if (self._machine) then
        self._machine:addModel(model)
    else
        printError( "[ERROR] MachineManager addModel: no machine found.")
    end
end

-- 删除模型
function MachineManager:removeModel(model)
    if (self._machine) then
        self._machine:removeModel(model)
    else
        printError( "[ERROR] MachineManager removeModel: no machine found.")
    end
end

-- 执行命令
function MachineManager:executeCommand(command)
    -- print("MachineManager:executeCommand")
    if (self._machine) then
        self._machine:executeCommand(command)
    else
        printError( "[ERROR] no machine found.")
    end
end

-- 发送点击事件开始的命令
function MachineManager:pushTouchBeganCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchBeganCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchBeganCommand: machine is nil.")
    end
end

-- 发送点击事件移动的命令
function MachineManager:pushTouchMovedCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchMovedCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchMovedCommand: machine is nil.")
    end
end

-- 发送点击事件取消的命令
function MachineManager:pushTouchCancelCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchCancelCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchMovedCommand: machine is nil.")
    end
end

-- 发送点击事件结束的命令
function MachineManager:pushTouchEndedCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchEndedCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchEndedCommand: machine is nil.")
    end
end

-- 发送长按点击事件开始的命令
function MachineManager:pushTouchLongTimeBeganCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchLongTimeBeganCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchLongTimeBeganCommand: machine is nil.")
    end
end

-- 发送长安点击事件结束的命令
function MachineManager:pushTouchLongTimeEndedCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchLongTimeEndedCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchLongTimeEndedCommand: machine is nil.")
    end
end

function MachineManager:pushTouchClickCommand(touchPosition)
    if (self._machine) then
        local command = Command.GenerationCommand:create(true)
        command:initTouchClickCommand(touchPosition)
        self._machine:pushCommand(command)
    else
        -- printError( "[ERROR] MachineManager pushTouchBeganCommand: machine is nil.")
    end
end

-- 发送移除模型的命令
function MachineManager:pushRemoveModelCommand(modelID, cleanView)
    if (self._machine) then
        local command = Command.BattleCommand:create(true)
        command:initForRemoveModel(modelID, cleanView)
        self._machine:pushCommand(command)
    else
        printError( "[ERROR] MachineManager pushRemoveModelCommand: machine is nil.")
    end
end

-- 发送更新位置的渲染命令
function MachineManager:pushPositionRendererCommand(target, coord, moveMap)
    if (self._machine) then
        if(target) then
            local positionCommand = Command.RendererCommand:create(true)
            positionCommand:initUpdatePositionCommand(target:getId(), coord, moveMap)
            self._machine:pushCommand(positionCommand)
        end
    else
        printError( "[ERROR] MachineManager pushPositionRendererCommand: machine is nil.")
    end
end

-- 发送更新z序的渲染命令
function MachineManager:pushZOrderRendererCommand(target, coord, offset)
    if (self._machine) then
        if(target) then
            local zorderCommand = Command.RendererCommand:create(true)
            zorderCommand:initUpdateZOrderCommand(target:getId(), coord, offset)
            self._machine:pushCommand(zorderCommand)
        end
    else
        printError("[ERROR] MachineManager pushZOrderRendererCommand: machine is nil.")
    end
end

-- 发送更新方向的渲染命令
function MachineManager:pushDirectionRendererCommand(target, direction)
    if (self._machine) then
        if(target) then
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initUpdateDirectionCommand(target:getId(), direction)
            self._machine:pushCommand(directionCommand)
        end
    else
        printError("[ERROR] MachineManager pushDirectionRendererCommand: machine is nil.")
    end
end

-- 发送更新动画的渲染命令
function MachineManager:pushAnimationRendererCommand(target, animationType)
    if (self._machine) then
        if(target) then
            local animationCommand = Command.RendererCommand:create(true)
            animationCommand:initUpdateAnimationCommand(target:getId(), animationType)
            self._machine:pushCommand(animationCommand)
        end
    else
        printError("[ERROR] MachineManager pushAnimationRendererCommand: machine is nil.")
    end
end

-- 发送移动渲染命令
function MachineManager:pushMoveRendererCommmand(target)
    if (self._machine) then
        if(target) then
            local rendererCommand = Command.RendererCommand:create(true)
            rendererCommand:initUpdateAnimationCommand(target:getId(), CommandAnimationType.MOVE)
            self._machine:pushCommand(rendererCommand)
        end
    else
        printError("[ERROR] MachineManager pushMoveRendererCommmand: machine is nil.")
    end
end

-- 发送待机的渲染命令
function MachineManager:pushIDLERendererCommand(modelID)
    if (self._machine) then
        local rendererCommand = Command.RendererCommand:create(true)
        rendererCommand:initIDLEAnimationCommand(modelID)
        self._machine:pushCommand(rendererCommand)
    else
        printError("[ERROR] MachineManager pushIDLERendererCommand: machine is nil.")
    end
end

-- 发送普通攻击渲染命令
function MachineManager:pushAttackRendererCommand(modelID, skill, speedUp)
    if (self._machine) then
        local rendererCommand = Command.RendererCommand:create(true)
        -- rendererCommand:initUpdateAnimationCommand(target:getId(), CommandAnimationType.ATTACK, speedUp)
        rendererCommand:initNormalSkillCommand(modelID, skill, speedUp)
        self._machine:pushCommand(rendererCommand)
    else
        printError("[ERROR] MachineManager pushAttackRendererCommand: machine is nil.")
    end
end

function MachineManager:pushAddEffectRendererCommand(target, effect)
    if (self._machine) then
        -- 这里过滤了死亡后添加的表现
        if(target and target:getIsDead() == false) then
            local rendererCommand = Command.RendererCommand:create(true)
            rendererCommand:initAddEffectCommand(target:getId(), effect)
            self._machine:pushCommand(rendererCommand)
        end
    else
        printError( "[ERROR] MachineManager pushAddEffectRendererCommand: machine is nil.")
    end
end

function MachineManager:pushHorcruxShowOrHideCommand(target)
    if (self._machine and target) then
        local category = target:getCategory()
        if(category == Category.ROLE and target:getType() == RoleType.Hero) then 
            local norHorcruxID = 0
            if(target:getRoleData() and target:getRoleData().getHorcruxExteriorId) then 
                norHorcruxID = target:getRoleData():getHorcruxExteriorId()
            end
            local SceneManager = require("app.game.SceneManager")
            if(not GameManager:getCustomHQ(CUSTOM_HQ_TYPE.HORCRUX) and not target:isMaster()) then 
                norHorcruxID = 0
            end

            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initHorcruxExterior(target:getId(), norHorcruxID)
            self._machine:pushCommand(renderCommand)
        end
    else
        printError( "[ERROR] MachineManager pushAddEffectRendererCommand: machine is nil.")
    end
end


return MachineManager;