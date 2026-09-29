local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local DropList = {}
Config.DropList = DropList 

local DROP_LIST_CACHE = nil

-- 根据任务ID获取任务数据
function DropList:getDropListByDropListId(dropListId)
    local allDropList = self:getAllDropList()
    local dropList = allDropList[dropListId]
    return dropList
end

--获取所有任务数据
function DropList:getAllDropList()
    if DROP_LIST_CACHE == nil then
        local dropList = require("profiles/commonProfile/ProfileDropList")
        DROP_LIST_CACHE = dropList
    end

    return DROP_LIST_CACHE
end

-- 清理
function DropList:clear()
	reload_script_file("profiles/commonProfile/ProfileDropList")
    DROP_LIST_CACHE = nil
end