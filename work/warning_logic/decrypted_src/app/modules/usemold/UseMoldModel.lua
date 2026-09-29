--[[--
数据模型UseMoldModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: UseMoldModel
------------------------------------------------------------------------------

local UseMoldModel = class("UseMoldModel",mvc.GameModel)

function UseMoldModel:initData()
	
end

function UseMoldModel:getUseMoldData()
	local moldConfig = ConfigManager:getAllMoldForgingData()
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local usedMoldData = {}
    for k, v in pairs(moldConfig) do
        local data = {} 
        data.config = v
        data.moldInfo = moldInfo[v.id]

        table.insert(usedMoldData, data)
    end
    table.sort(usedMoldData, function(a, b)
        if a.moldInfo and not b.moldInfo then
            if a.moldInfo.pos ~= 0 then
                return false
            else
                return true
            end
        elseif not a.moldInfo and b.moldInfo then
            if b.moldInfo.pos ~= 0 then
                return true
            else
                return false
            end
        elseif a.moldInfo and b.moldInfo then
            if a.moldInfo.pos == 0 and b.moldInfo.pos ~= 0 then
                return true
            elseif a.moldInfo.pos == 0 and b.moldInfo.pos == 0 then
                return a.moldInfo.configId > b.moldInfo.configId
            elseif a.moldInfo.pos ~= 0 and b.moldInfo.pos ~= 0 then
                return a.moldInfo.pos > b.moldInfo.pos
            end
        else
            return a.config.id > b.config.id
        end
    end)
    return usedMoldData
end

return UseMoldModel