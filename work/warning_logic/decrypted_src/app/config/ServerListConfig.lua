--
-- Author: 岳溁松
-- Date: 2017-11-10 17:10:42
--
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local ServerList = {}
Config.ServerList = ServerList 

-- 缓存效果配置数据
local ServerListDataCache = nil

function ServerList:getAllServer()
    if (not ServerListDataCache) then
    -- 获取所有技能
        ServerListDataCache = require("profiles/dataProfile/ProfileClientServerList")
        -- 处理里面字段的替换
        for k,v in pairs(ServerListDataCache) do
            if (type(v) == "table") then
                -- 处理多语言转换
                v.name = LanguageManager:getInstance():getLocalString(v.name)
            end
        end
    end

    return ServerListDataCache
end


function ServerList:getServerListByTarget(target)
	local list = {}
	local all = self:getAllServer()

	for k, v in pairs( all ) do
		if (type(v) == "table") then
            if v.target == target then
                -- 如果在审核中 只添加ID为0的服务器
                if APP_INREVIEW then
                    if v.zoneID == 0 then
                        table.insert(list,v)
                    end
                else
                    if v.zoneID > 0 then
                        table.insert(list,v)
                    end
                end
				
			end
		end
	end
	return list
end

function ServerList:getServerName(ID)
    local list = {}
    local all = self:getAllServer()

    for k, v in pairs( all ) do
        if (type(v) == "table") then
            if v.ID == ID then
                return v.name
            end
        end
    end
    return nil
end

-- 清理
function ServerList:clear()
    reload_script_file("profiles/dataProfile/ProfileClientServerList")
    ServerListDataCache = nil
end