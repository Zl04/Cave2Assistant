local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")

local SkillTest = {}


function SkillTest:testBuff()
    local entityIDAdd = 1

    local scheduler = cc.Director:getInstance():getScheduler()  
    local schedulerID = nil  
    schedulerID = scheduler:scheduleScriptFunc(function()  
        local master = MachineManager:getInstance():getMachine()._model:getMaster()

        local data = {
            buffID = 241801,
            entityID = entityIDAdd,
            targetSpriteID = master:getSpriteID(),
            curDuration = 4,
            overlayNum = 1
        }

        print("SkillTest:testBuff  add buffer  entityID=",entityIDAdd)
        local command = Command.ControlCommand:create(true)
        command:initForAddBuff(data, false)
        SceneManager:getInstance():pushCommand(command)

        if entityIDAdd >1 then
            local removeEntity = entityIDAdd - 1

            local removeData = {
                entityID = removeEntity,
                targetSpriteID = master:getSpriteID()
            }

            print("SkillTest:testBuff  remove buffer  entityID=",removeEntity)
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, removeData)
            SceneManager:getInstance():pushCommand(command)
        end

        entityIDAdd = entityIDAdd + 1
    end,3,false) 
end


function SkillTest:testEffect()
    local scheduler = cc.Director:getInstance():getScheduler()  
    local schedulerID = nil  
    schedulerID = scheduler:scheduleScriptFunc(function()  
        local master = MachineManager:getInstance():getMachine()._model:getMaster()

        local data = {
            effectID = 301009,
            targetSpriteID = master:getSpriteID()
        }

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ADD_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    end,3,false) 
end



return SkillTest