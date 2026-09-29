--[[--
数据模型GuildInfoModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: 
--date	: 2019/10/08
--desc	: GuildInfoModel
------------------------------------------------------------------------------

local GuildInfoModel = class("GuildInfoModel",mvc.GameModel)

function GuildInfoModel:initData()
	self._data = {}
end

function GuildInfoModel:initDataNet(data)
    -- 转移存储PB数据
    for k,v in pairs(data) do
        if (k ~= "__index") then
            self._data[k] = v
        end
    end
end

function GuildInfoModel:resetData()
    self._data = {}
end

function GuildInfoModel:getData()
    -- required uint64 id = 1;
    -- required string name = 2;
    -- required string leaderName = 3;
    -- required uint32 curMemberNum = 4;
    -- required uint32 lv = 5;
    -- optional string notice = 6;
    -- required GuildRelationship rs = 7;
    -- required uint32 iconID = 8;
    return self._data
end

function GuildInfoModel:updateApplyStatus(isApplied)
    if (self._data and self._data.rs) then
        if (isApplied) then
            self._data.rs = "GuildRelationship_Apply"
        end
    end
end

function GuildInfoModel:getCurrentGuildID()
    return self._data.id
end

return GuildInfoModel