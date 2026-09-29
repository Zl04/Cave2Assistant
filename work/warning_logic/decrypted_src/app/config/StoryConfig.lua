

Config = Config or {}


local StoryConfig = {}
Config.StoryConfig = StoryConfig 

-- 缓存效果配置数据
local StoryConfigDataCache = nil

function StoryConfig:getAllStoryConfig()
    -- 获取所有技能
    if (not StoryConfigDataCache) then
        local _StoryConfigDataCache = require("profiles/dataProfile/ProfileClientStory")
        StoryConfigDataCache = {}
        for k,v in pairs(_StoryConfigDataCache) do

            if type(v) == "table" and v.ID then
                local txtExpression = "return "..v.expression
                local fun = assert(loadstring(txtExpression))
                local expression = fun()
                v._expression = expression

                v._conditionList = {}
                for k1,v1 in pairs(v.condition) do
                    local txtCondition = "return "..v1
                    local fun = assert(loadstring(txtCondition))
                    local condition = fun()
                    table.insert(v._conditionList,condition)
                end

                v._notInTown = v.notInTown

                v._inStoryOnly = v.inStoryOnly

                 v._isOnMainUI = v.isOnMainUI
                
                v._conditionType = v.conditionType
                table.insert(StoryConfigDataCache,v)
            end
        end
        
        assert(type(StoryConfigDataCache) == "table", "[ERROR] StoryConfig getAllStoryConfig: could not get all the StoryConfig config.")
    end
    return clone(StoryConfigDataCache)
end



function StoryConfig:getStoryStepConfig(stepID)
    stepID = tonumber(stepID)
    -- 根据 id 获取配置文件
    local allStoryConfig = self:getAllStoryConfig()

    return clone(allStoryConfig[stepID])
end


-- 清理
function StoryConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientStory")
    StoryConfigDataCache = nil
end