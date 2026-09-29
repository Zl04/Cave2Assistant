--[[--
数据模型NetworkEnvironmentTestingModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/04/02
--desc	: NetworkEnvironmentTestingModel
------------------------------------------------------------------------------

local NetworkEnvironmentTestingModel = class("NetworkEnvironmentTestingModel",mvc.GameModel)

local zoneIDList = {
    --test
    -- [1] = 6,
    [1] = 0,
    [2] = 2,
    [3] = 3,

    
}

local awsURL = {
    [1] = "https://cave2-all-us-zs-login-0001.avalongames.com",
    [2] = "https://cave2-all-eu-zs-login-0001.avalongames.com",
    [3] = "https://cave2-all-ap-zs-login-0001.avalongames.com"
}

local aliyunURL = {
    [1] = "https://quick-global.avalongames.com",
    [2] = "https://quick-global.avalongames.com",
    [3] = "https://quick-global.avalongames.com"
}

local awsServerKey = {
    [1] = "aws_us",
    [2] = "aws_eu",
    [3] = "aws_ap"
}

local aliyunServerKey = {
    [1] = "ali_us",
    [2] = "ali_eu",
    [3] = "ali_ap"
}

function NetworkEnvironmentTestingModel:initData()
    self._dataIndex = 0
    self._stePprogress = 0 -- 进度, 大于等于2时才能进入下一步
	self._networkIP = "" --公网IP
    self._awsDelayTime = 99999 -- aws web请求延时
    self._alyDelayTime = 99999 -- 阿里云 web请求延时
end

function NetworkEnvironmentTestingModel:testNetworkAction()
    local publicNetworkUrl = "http://icanhazip.com"
    self._dataIndex = self:getDataIndexOfZoneID()
    
    Net.Helper:sendNormalHttpGet(publicNetworkUrl, nil, function(networkIP)
        -- 解开JSON并设置获取到的数据
        -- local data = json.decode(response)
        print("publicNetworkUrl, 获得Web返回数据:", networkIP)
        self._networkIP = networkIP

        self:sendAWSURL()
        self:sendAliyunURL()

    end,function(readyState,status)
        print("publicNetworkUrl, 请求失败:")
                 -- 超过重试次数回调
    end, 2)
end

function NetworkEnvironmentTestingModel:getDataIndexOfZoneID()
    local index = 0
    local zoneID = ServerConfigUtil:getZoneId()

    print("    zoneIDzoneIDzoneID =======  ",zoneID)

    for i = 1, #zoneIDList do
        if(zoneID == zoneIDList[i]) then
            index = i
            break
        end
    end

    return index
end

function NetworkEnvironmentTestingModel:getAWSURL()
    local dataIndex = self._dataIndex
    local url = ""
    if awsURL[dataIndex] then
        url = awsURL[dataIndex]
    end
    return url
end

function NetworkEnvironmentTestingModel:getAliyunURL()
    local dataIndex = self._dataIndex
    local url = ""
    if aliyunURL[dataIndex] then
        url = aliyunURL[dataIndex]
    end
    return url
end

function NetworkEnvironmentTestingModel:getAWSServerKey()
    local dataIndex = self._dataIndex
    local serverKey = ""
    if awsServerKey[dataIndex] then
        serverKey = awsServerKey[dataIndex]
    end
    return serverKey
end

function NetworkEnvironmentTestingModel:getAliyunServerKey()
    local dataIndex = self._dataIndex
    local serverKey = ""
    if aliyunServerKey[dataIndex] then
        serverKey = aliyunServerKey[dataIndex]
    end
    return serverKey
end

function NetworkEnvironmentTestingModel:sendAWSURL()
    local url = self:getAWSURL()
    if url ~= "" then
        local beginTime = AvalonUtil.getCurrentTime()
        Net.Helper:sendNormalHttpGet(url, nil, function(networkIP)
            local endTime = AvalonUtil.getCurrentTime()
            self._awsDelayTime = endTime - beginTime -- web请求延时
            self._stePprogress = self._stePprogress + 1
            self:checkSteAndAction()
        end,function(readyState,status)
            print("sendAWSURL, 请求失败:")
            -- 超过重试次数回调
            self._stePprogress = self._stePprogress + 1
            self:checkSteAndAction()
        end, 2)
    else
        print("not find aws url   ServerConfigUtil:getZoneId() === ",ServerConfigUtil:getZoneId())
    end

end

function NetworkEnvironmentTestingModel:sendAliyunURL()
    local url = self:getAliyunURL()
    if url ~= "" then
        local beginTime = AvalonUtil.getCurrentTime()
        Net.Helper:sendNormalHttpGet(url, nil, function(networkIP)
            local endTime = AvalonUtil.getCurrentTime()
            self._alyDelayTime = endTime - beginTime -- web请求延时
            self._stePprogress = self._stePprogress + 1
            self:checkSteAndAction()
        end,function(readyState,status)
            print("sendAliyunURL, 请求失败:")
            -- 超过重试次数回调
            self._stePprogress = self._stePprogress + 1
            self:checkSteAndAction()
        end, 2)
    else
        print("not find aliyun url   ServerConfigUtil:getZoneId() === ",ServerConfigUtil:getZoneId())
    end

end

function NetworkEnvironmentTestingModel:checkSteAndAction()
    if self._stePprogress >= 2 then
        -- Net.NetLoginSystem:reqRecordNetInfoMessage(jsonStr)
        self:reqAWSNetInfoMessage()
        -- self:reqAliyunNetInfoMessage()
    end
end

function NetworkEnvironmentTestingModel:reqAWSNetInfoMessage()
    local dataList = {}
    local data = {}
    data.ServerKey = self:getAWSServerKey()
    if RoleDataManager:getMaster() then
        data.PK = RoleDataManager:getMaster():getPK()
    end
    data.ip = self._networkIP
    data.httpdelay = self._awsDelayTime
    data.clienttime = AvalonUtil.getCurrentTime()

    local data2 = {}
    data2.ServerKey = self:getAliyunServerKey()
    if RoleDataManager:getMaster() then
        data2.PK = RoleDataManager:getMaster():getPK()
    end
    data2.ip = self._networkIP
    data2.httpdelay = self._alyDelayTime
    data2.clienttime = AvalonUtil.getCurrentTime()

    table.insert(dataList,data)
    table.insert(dataList,data2)

    local jsonStr = json.encode(dataList)
    print(" 上报了 !!  jsonStr === ",jsonStr)
    Net.NetLoginSystem:reqRecordNetInfoMessage(jsonStr)
end

-- function NetworkEnvironmentTestingModel:reqAliyunNetInfoMessage()
--     local data = {}
--     data.ServerKey = self:getAliyunServerKey()
--     if RoleDataManager:getMaster() then
--         data.PK = RoleDataManager:getMaster():getPK()
--     end
--     data.ip = self._networkIP
--     data.httpdelay = self._alyDelayTime
--     data.clienttime = AvalonUtil.getCurrentTime()

--     local jsonStr = json.encode(data)
--     Net.NetLoginSystem:reqRecordNetInfoMessage(jsonStr)
-- end


return NetworkEnvironmentTestingModel