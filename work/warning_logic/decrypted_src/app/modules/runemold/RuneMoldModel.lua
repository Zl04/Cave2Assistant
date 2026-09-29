--[[--
数据模型RuneMoldModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/20
--desc	: RuneMoldModel
------------------------------------------------------------------------------

local RuneMoldModel = class("RuneMoldModel",mvc.GameModel)

function RuneMoldModel:initData()
    self.moldInfo = {}
    self.fragmentIdData = {}
    self.moldFragData = {}
    self.lastMoldInfo = {}
end

function RuneMoldModel:initMoldNetData(data)
    self.fragmentIdData = data.fragmentId or {}
    -- self.moldInfo = data.info or {}
    if data.info and #data.info > 0 then
        self:initMoldInfo(data.info)
    end
end

function RuneMoldModel:initMoldInfo(data)
    self.lastMoldInfo = clone(self.moldInfo)
    for k, v in pairs(data) do
        if v.configId then
            self.moldInfo[v.configId] = v
        end
    end
end

function RuneMoldModel:getMoldfragmentData()
    return self.fragmentIdData
end

function RuneMoldModel:getMoldInfo()
    return self.moldInfo
end

function RuneMoldModel:getLastMoldInfo()
    return self.lastMoldInfo
end

-- function RuneMoldModel:initMoldFragData()
--     
-- end

function RuneMoldModel:checkMoldCanForging(data)
    -- if self.moldInfo[data.ID] then
    --     return true
    -- end

    local moldFragmentIDList = string.split(data.fragmentID, ";")
    local totalNum = #moldFragmentIDList
    local haveFragNum = 0
    for k, v in pairs(moldFragmentIDList) do
        v = tonumber(v)
        for k2, v2 in pairs(self.fragmentIdData) do
            if v == v2 then
                haveFragNum = haveFragNum + 1 
                break
            end
        end
    end
    return haveFragNum >= totalNum, haveFragNum, totalNum
end

function RuneMoldModel:ishaveNewMoldFragment(fragmentIDList)
    local isHave = false
    local data = nil
    for k, v in pairs(fragmentIDList) do
        local id = tonumber(v)
        local goodsData = GoodsDataManager:getVirtualGoodsDataByGoodsID(id)
        if goodsData and goodsData:getIsNew() then
            isHave = true
            data = goodsData
            break
        end
    end
    return isHave, data
end

function RuneMoldModel:checkFragmentIsGet(id)
    local isGet = false
    local haveList = self:getMoldfragmentData()--GoodsDataManager:getVirtualGoodsDataList()
    for k,v in pairs(haveList) do
        if(v == id) then
            isGet = true
            break
        end
    end 
    return isGet
end

function RuneMoldModel:getCharacteristicLevel(gemIds)
    local gemMinLv = 0--1
    for k, v in pairs(gemIds) do
        local gemData = GoodsDataManager:createLocalGoodsData(v.gemId)
        local stoneLv = gemData:getStoneLV()
        if gemMinLv == 0 then
            gemMinLv = stoneLv
        end
        
        if gemMinLv > stoneLv then
            gemMinLv = stoneLv
        end
    end
    return gemMinLv
end

function RuneMoldModel:getCharacteristicDesKeyByLevel(config, activeLevel)
    local left = 1
    local right = table.getn(config)
    local mid = math.ceil((left+right)/2)
    while left ~= mid do
        if tonumber(config[mid]) == activeLevel then
            break
        elseif tonumber(config[mid]) < activeLevel then
            left = mid + 1
        else
            right = mid - 1
        end
        mid = math.ceil((left+right)/2)
    end
    return mid, config[mid]
end



return RuneMoldModel