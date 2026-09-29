--
-- Author: ydli
-- Date: 2019-04-12 14:00:01
--[[
       传入 {"类名", "相对路径", "主键", {"多语言key1", "多语言key2"}}
       生成 1、缓存 2、init函数 3、getAllDatas函数 4、getDataById函数 5、多语言转换
       例:  {"SpecialEventConfig", "profiles/commonProfile/ProfileSpecialEvent", "ID", {name", "description"}}
       ....
]]--


local LanguageManager = require("app.game.LanguageManager")
NewConfig = NewConfig or {}
local ConfigGenerate = {}


function ConfigGenerate:generate(className, path, keyName, languageKeys)
    if NewConfig[className] == nil then
        local class = {}
        class.className = className
        class.path = path
        class.keyName = keyName
        class.languageKeys = languageKeys or {}

         --method：init
        class["init"] = function(self)
            local list = require(self.path)
            local cache = {}
            for k,v in pairs(list) do
                if (type(v) == "table") then
                    for k2, v2 in ipairs(self.languageKeys) do
                        v[v2] = LanguageManager:getInstance():getLocalString(v[v2])
                    end
                    table.insert(cache, v)
                end
            end
            self.cache = cache
        end

        --method：all
        class["getAllDatas"] = function(self)
            if self.cache == nil then
                self:init()
            end
            return self.cache
        end

        --method：one
        class["getDataById"] = function(self, id)
            if self.cache == nil then
                self:init()
            end
            local list = self.cache
            for k, v in ipairs(list) do
                if v[self.keyName] == id then
                    return v
                end
            end
        end

        --method: clear
        class["clear"] = function(self)
            reload_script_file(self.path)
            self.cache = nil
            NewConfig[self.className] = nil
        end

        NewConfig[className] = class
    end
end

return ConfigGenerate