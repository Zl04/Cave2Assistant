--[[--
数据模型SettingModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/21
--desc	: SettingModel
------------------------------------------------------------------------------

require "app.datas.common.AreaServerData"

local SettingModel = class("SettingModel",mvc.GameModel)

function SettingModel:initData()
    self._areaServerList = nil
    
    -- 测试数据
    self._areaServerList = {}
    self._preferAreaId = 0

    -- for i=1,10,1 do 
    --     local testData = {
    --         areaId = i,
    --         targetAreaId = i,
    --         areaName = "zone"..i,
    --         property = 1,
    --         status = 2
    --     }
    --     local areaServerData = Data.AreaServerData:create(testData)
    --     if(i==2) then
    --         areaServerData:setHeroInfo(1122, "nickName" .. i, i)
    --     end
    --     table.insert(self._areaServerList, areaServerData)
    -- end
end

--释放
function SettingModel:dispose()
	self._areaServerList = nil
end

function SettingModel:handleAreaListData(data)
    self._areaServerList = {}
    self._preferAreaId = data.preferAreaId

    for k,v in ipairs(data.areas) do 
        local areaServerData = Data.AreaServerData:create(v)
        table.insert(self._areaServerList, areaServerData)
    end

    for k,v in ipairs(data.heroes) do 
        for _,areaServerData in ipairs(self._areaServerList) do 
            if(areaServerData:getAreaID() == v.areaId) then 
                areaServerData:setHeroInfo(v.pk, v.nickname, v.level)
                break
            end
        end
    end

    -- 触发获取多语言
    local keyList = {}
    for k,v in ipairs(self._areaServerList) do 
        if(v:getLangId()) then
            table.insert(keyList, v:getLangId())
        end
    end

    local LanguageManager = require("app.game.LanguageManager")
    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, function()
        for k,v in ipairs(self._areaServerList) do 
            if(v:getLangId()) then 
                local areaNameJson = LanguageManager:getInstance():getLanguageWebStrForKey(v:getLangId())
                if(areaNameJson) then 
                    xpcall(function()
                        local jsonArr = json.decode(areaNameJson)
                        if(#jsonArr>=1) then 
                            v:setAreaName(json.decode(areaNameJson)[1].text or "")
                        end
                    end, 
                    function(e) 

                    end, 1)
                end
            end
        end
    end))
end

function SettingModel:_refreshWebLanguage(dataMap, params)

end

function SettingModel:getPreferAreaID()
    return self._preferAreaId
end

function SettingModel:getNowAreaData()
    local areaID = nil
    local masterData = RoleDataManager:getMaster()
    if(masterData) then 
        areaID = masterData:getAreaID()
    end

    for _,areaServerData in ipairs(self._areaServerList) do 
        if(areaServerData:getAreaID() == areaID) then 
            return areaServerData
        end
    end

    return nil
end

function SettingModel:getAreaListData()
    return self._areaServerList
end

function SettingModel:getAreaListDataForHaveRole()
    local serverList = {}
    if(self._areaServerList) then 
        for k, v in pairs(self._areaServerList) do 
            if(v:getIsRole()) then 
                table.insert(serverList, v)
            end
        end
    end
    -- 把有等级高的放到前面
    table.sort(serverList, function(a, b)
        if(a:getLv() == b:getLv()) then 
            if(a:getAreaID() > b:getAreaID()) then 
                return true
            else
                return false 
            end
        elseif(a:getLv() > b:getLv()) then 
            return true
        else
            return false
        end
    end)
    
    return serverList
end

return SettingModel