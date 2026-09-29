-- RoleLevelUpAction.lua
-- Author:zp
-- 2017年4月19日
-- Using:角色升级表现逻辑

require "app.action.BattleAction"
require "app.action.Action"
require "app.pool.Pool"

Action = Action or {}

local RoleLevelUpAction = class("RoleLevelUpAction", Action.BattleAction)
Action.RoleLevelUpAction = RoleLevelUpAction

local DEBUG = false

-- private:
-- 对象池
local RoleLevelUpActionPool = nil

-- public:
-- 创建对象
function RoleLevelUpAction:create(reused, ...)
    if (reused) then
        if (not RoleLevelUpActionPool) then
            RoleLevelUpActionPool = Pool.Pool:create(RoleLevelUpAction)
        end
        return RoleLevelUpActionPool:applyObject()
    else
        return RoleLevelUpAction.new(...)
    end
end

-- 构造函数
function RoleLevelUpAction:ctor()
    RoleLevelUpAction.super.ctor(self, ActionType.FUNCTION_ROLE_LEVEL_UP)

    self._runTime = 0
    -- 保存所有得队列
    self._levelUpArr = {}
    self._levelUpAttrArr = {}
end

-- 模版函数：销毁
function RoleLevelUpAction:dtor()
    RoleLevelUpAction.super.dtor(self)
    self._runTime = 0
    self._levelUpArr = {}
    self._levelUpAttrArr = {}
end

function RoleLevelUpAction:init(target,startLevel,endLevel)
    RoleLevelUpAction.super.init(self)
    -- print("RoleLevelUpAction:init( ",target,startLevel,endLevel)
    self._target = target
    self._startLevel = startLevel
    self._endLevel = endLevel

    self._runTime = 0
    self._levelUpArr = {}
    self._levelUpAttrArr = {}
end

-- 清理
function RoleLevelUpAction:clear()
    RoleLevelUpAction.super.clear(self)

    self._runTime = 0
    self._levelUpArr = {}
    self._levelUpAttrArr = {}
end

-- 模版函数：action开始
function RoleLevelUpAction:onStart()
    -- TODO 处理添加角色处理
    -- print("RoleLevelUpAction:onStart ")
    if (self._startLevel < self._endLevel) then
        self:forceUpdate()

        local levelUpInterval = 0.5
        local attrInterval = 0.3
        -- 每次升级导致属性间的时间间隔
        local levelUpAttrInterval = 2.5

        local preConfig = ConfigManager:getHeroConfig(PublicDefine.HERO_SEX.MALE,self._startLevel) 
        local nowConfig = nil

        local upAttrArr = {"hp","mp","atkMin","atkMax","physicDef","magic","magicDef","totalSkillPoints"}
        local levelUpTime = 0
        local levelUpAttrTime = 0.3
        local levelUpNum = 0
        local levelUpAttrNum = 0

        for nowLv=self._startLevel+1,self._endLevel do 
            nowConfig = ConfigManager:getHeroConfig(PublicDefine.HERO_SEX.MALE,nowLv) 
            if not nowConfig then
                return
            end
            if (not (preConfig and nowConfig )) then
                assert(false,string.format("not found role startLevel=%d to endLevel=%d config",self._startLevel,self._endLevel))
            end

            -- 处理生成相关的指令
            local levelUp = {}
            levelUp.time = levelUpTime + levelUpInterval * levelUpNum
            table.insert(self._levelUpArr,levelUp)
            levelUpNum = levelUpNum + 1

            -- 处理所有属性
            local oneAttrData = {}
            oneAttrData.time = levelUpAttrTime
            oneAttrData.attrArr = {}
            for k,attrName in ipairs(upAttrArr) do
                local cha = nowConfig[attrName] - preConfig[attrName]
                if(cha > 0) then
                    -- 处理升级属性颜色计算
                    local color = self:makeAttrColor(attrName)
                    local outlineColor = self:makeAttrOutlineColor(attrName)

                    local levelUpAttr = {}
                    levelUpAttr.attrName = ToolsUtil:attrNameToLanguageString(attrName)
                    levelUpAttr.attrNum = cha
                    levelUpAttr.color = color
                    levelUpAttr.outlineColor = outlineColor
                    table.insert(oneAttrData.attrArr,levelUpAttr)
                end
            end

            table.insert(self._levelUpAttrArr,oneAttrData)
            levelUpAttrTime = levelUpAttrTime + levelUpAttrInterval

            preConfig = nowConfig
            nowConfig = nil
        end
    end
    
    return true
end

-- 模版函数：action结束
function RoleLevelUpAction:onEnd()
    -- TODO
end

function RoleLevelUpAction:onFail()
    -- TODO
end

function RoleLevelUpAction:onUpdate(dt)
    self._runTime = self._runTime + dt

    for k,v in ipairs(self._levelUpArr) do
        if(v.time <= self._runTime) then
            local rendererCMD = Command.RendererCommand:create()
            rendererCMD:initRoleLevelUp(self._target:getId())
            self._battleMachine:pushCommand(rendererCMD)

            table.remove(self._levelUpArr,k)
            break;
        end
    end

    for k,v in ipairs(self._levelUpAttrArr) do
        if(v.time <= self._runTime) then
            local rendererCMD = Command.RendererCommand:create()
            rendererCMD:initRoleLevelUpAttr(self._target:getId(),v.attrArr)
            self._battleMachine:pushCommand(rendererCMD)

            table.remove(self._levelUpAttrArr,k)
            break;
        end
    end

    if #self._levelUpArr == 0  and #self._levelUpAttrArr == 0 then
        return true
    end

    return false
end

function RoleLevelUpAction:makeAttrColor(attrName)
    local color = nil
    if attrName == "hp" then
        color = cc.c3b(223,255,194)
    elseif attrName == "mp" then
        color = cc.c3b(167,233,255)
    elseif attrName == "atkMin" then
        color = cc.c3b(255,220,146)
    elseif attrName == "atkMax" then
        color = cc.c3b(255,250,178)
    elseif attrName == "physicDef" then
        color = cc.c3b(255,201,157)
    elseif attrName == "magic" then
        color = cc.c3b(169,214,255)
    elseif attrName == "magicDef" then
        color = cc.c3b(176,178,255)
    elseif attrName == "totalSkillPoints" then
        color = cc.c3b(219,176,255)
    else
        assert(false,"RoleLevelUpAction:makeAttrColor  not handle attrName="..attrName)
    end

    return color
end

function RoleLevelUpAction:makeAttrOutlineColor(attrName)
    local color = nil
    if attrName == "hp" then
        color = cc.c3b(66,113,28)
    elseif attrName == "mp" then
        color = cc.c3b(34,96,116)
    elseif attrName == "atkMin" then
        color = cc.c3b(160,109,12)
    elseif attrName == "atkMax" then
        color = cc.c3b(141,103,0)
    elseif attrName == "physicDef" then
        color = cc.c3b(141,76,0)
    elseif attrName == "magic" then
        color = cc.c3b(60,80,129)
    elseif attrName == "magicDef" then
        color = cc.c3b(60,62,129)
    elseif attrName == "totalSkillPoints" then
        color = cc.c3b(109,51,123)
    else
        assert(false,"RoleLevelUpAction:makeAttrColor  not handle attrName="..attrName)
    end

    return color
end