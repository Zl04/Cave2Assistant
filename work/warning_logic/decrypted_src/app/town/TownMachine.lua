--[[
    游戏引擎系统
]]--

require "app.machine.Machine"
require "app.machine.Model"
require "app.machine.View"

-- 引擎的数据模型和视图
require "app.town.TownModel"
require "app.town.TownView"
require "app.town.TownNewModel"
require "app.town.TownNewView"

Town = Town or {}

local Machine = class("TownMachine", Machine.ShareMachine)
Town.Machine = Machine

require "app.town.TownMachineControlCmd"
require "app.town.TownMachineCommon"
require "app.town.TownMachineTownCmd"

local DEBUG = false

-- public:
-- 构造函数
function Machine:ctor()
    Machine.super.ctor(self)
end

-- 初始化
function Machine:init(viewNode)
    if(GameManager:getIsInNewScene()) then 
        local battleModel = Town.TownNewModel:create()
        battleModel:init()

        local battleView = nil
        if (viewNode) then
            battleView = Town.TownNewView:create()
            battleView:init(battleModel, viewNode)
        end
        Machine.super.init(self, battleModel, battleView)
    else
        local battleModel = Town.TownModel:create()
        battleModel:init()

        local battleView = nil
        if (viewNode) then
            battleView = Town.TownView:create()
            battleView:init(battleModel, viewNode)
        end
        Machine.super.init(self, battleModel, battleView)
    end
end

--[[
    mapType = Game.TOWN_MAP_TYPE
]]
function Machine:switchNewScene(mapType)
    if(GameManager:getIsInNewScene()) then 
        if(nil == self._sceneCache) then 
            self._sceneCache = {}
        end

        local viewNode = nil
        local oldData = nil
        local oldID = nil
        if(self._model) then 
            viewNode = self._view._viewNode
            self._view:setVisible(false)
            if self._model._mapData then 
                oldID = self._model._mapData.ID
                oldData = {
                    model = self._model,
                    view = self._view
                }
            end
        end
        local sceneData = self._sceneCache[mapType]
        if(sceneData) then
            local model = sceneData.model
            local view = sceneData.view

            if(view) then 
                view:setVisible(true)
            end
            self:initWithViewAndMode(view, model)
        else
            local battleModel = Town.TownNewModel:create()
            battleModel:init()

            local battleView = nil
            if (viewNode) then
                battleView = Town.TownNewView:create()
                battleView:init(battleModel, viewNode)
            end
            self:initWithViewAndMode(battleView, battleModel)
            self._sceneCache[mapType] = {
                    model = battleModel,
                    view = battleView
                }
            
            self:_loadMapScene(mapType)
            if(battleView) then
                battleView:setVisible(true)
            end
        end
        if(oldID and oldData) then
            self._sceneCache[oldID] = oldData
        end
    end
end

function Machine:initWithViewAndMode(view, mode)
    print("TownMachine : initWithViewAndMode")
    Machine.super.init(self, mode, view)
end
-- 点击坐标转换成地图坐标
function Machine:convertCoordToTouchPosition(mapCoord)
    local coordX = 0
    local coordY = 0
    if (self._view) then
        coordX, coordY = self._view:convertCoordToPosition(mapCoord)
    end
    return coordX, coordY
end

-- 模版函数：处理命令
function Machine:executeCommand(command)
    local commandCategory = command.category
    
    if (commandCategory == CommandCategory.CONTROL) then
        return self:onExecuteControlCommand(command)
    elseif (commandCategory == CommandCategory.BATTLE) then
        return self:onExecuteTownCommand(command)
    elseif (commandCategory == CommandCategory.GENERATION) then
        return self:_onExecuteGenerationCommand(command)
    else
       assert(false, string.format("[ERROR] Battle machine _onExecuteCommand: command category %d is invalid.", commandCategory))
    end

    return false
end

--处理加载场景消息
function Machine:_onShowMapCompleteHandler()
    print("Town Machine _onShowMapCompleteHandler: create map view complete.")

    local roleMap = self._model:getRoleMap()
    if (roleMap) then
        for id, role in pairs(roleMap) do
            self._view:addView(role)
        end
    end
end