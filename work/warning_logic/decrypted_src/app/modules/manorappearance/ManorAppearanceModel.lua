--[[--
数据模型ManorAppearanceModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/21
--desc	: ManorAppearanceModel
------------------------------------------------------------------------------

local ManorAppearanceModel = class("ManorAppearanceModel",mvc.GameModel)

function ManorAppearanceModel:initData()
	self.unLockFacades = {}
    self.finishedTargetData = {}
    self.mannorLevel = 0
    self.mannorEXP = 0
end

function ManorAppearanceModel:checkFacadeIsUnlock(config, buildData)
    if config.isDefaultSkin == 1 then
        return true
    end
	local isUnlock = false
    if buildData.facades and table.nums(buildData.facades) > 0 then
        for k, v in pairs(buildData.facades) do
            if v == config.ID then
                isUnlock = true
                break
            end
        end
    end

    if not isUnlock then
        isUnlock = self.unLockFacades[config.ID] or false
    end

    return isUnlock
end

function ManorAppearanceModel:getFacaConfigByType(facaType)
    local shapeData = {}
    local shapeConfig = ConfigManager:getAllOtherShapeData()
    if facaType then
        for k, v in pairs(shapeConfig) do
            if v.type == facaType then
                table.insert(shapeData, v)
            end
        end
    else
        for k, v in pairs(shapeConfig) do
            table.insert(shapeData, v)
        end
    end
    return shapeData
end

function ManorAppearanceModel:setUnlockFacades(facadeid)
    self.unLockFacades[facadeid] = true
end

function ManorAppearanceModel:getMannorDailyTargetFinishNum(targets)
    local num = 0
    for _, v in pairs(targets) do
        if v.isFinished then
            num = num+1
        end
    end
    return num
end

-- function ManorAppearanceModel:checkTargetIsFinished(target)
--     local finished = false
--     if target.isFinished then
--         finished = true
--     end

--     if not finished then
--         if self.finishedTargetData[target.materialId] then
--             finished = self.finishedTargetData[target.materialId].isFinished or false
--         end
--     end

--     return finished
-- end

-- function ManorAppearanceModel:setFinishedTargetData(data)
--     self.finishedTargetData[materialId] = data
-- end

-- function ManorAppearanceModel:setMannorLevel(level)
--     self.mannorLevel = level
-- end

-- function ManorAppearanceModel:setMannorEXP(exp)
--     self.mannorEXP = exp
-- end

-- function ManorAppearanceModel:getMannorLevelAndEXP()
--     return self.mannorLevel, self.mannorEXP
-- end

return ManorAppearanceModel