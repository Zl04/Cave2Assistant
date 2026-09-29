-- DebugLogLayerUtil.lua
-- Author:ODEI
-- 2017年4月18日
-- Using:系统日志输出控制器 



UI = UI or {}

local DebugLogLayerUtil = class("DebugLogLayerUtil")
UI.DebugLogLayerUtil = DebugLogLayerUtil



function DebugLogLayerUtil:getInstance()
    if g_DebugLogLayerUtil == nil then
        g_DebugLogLayerUtil = DebugLogLayerUtil.new()
    end
    return g_DebugLogLayerUtil;
end


function DebugLogLayerUtil:purgeInstance()
    if g_DebugLogLayerUtil ~= nil then
        g_DebugLogLayerUtil = nil;
    end
end

function DebugLogLayerUtil:ctor()
    self.mData = {}
    self.rootLayer = nil;

end

function DebugLogLayerUtil:addData(...)
    local tab = {...}
    local txt = ""
    for i = 1,#tab do
        if i == 1 then
            txt = tostring(tab[i])
        else
            txt = txt.."  "..tostring(tab[i])
        end
        
    end
    if #self.mData > 500 then
        table.remove(self.mData,#self.mData)
    end

    table.insert(self.mData,1,txt)
    return txt
end

function DebugLogLayerUtil:getData()

    return self.mData
end

return DebugLogLayerUtil;