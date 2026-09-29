
Avalon = Avalon or {}

local AWSLogUtil = {}
Avalon.AWSLogUtil = AWSLogUtil


function AWSLogUtil:sendAWSDelayInfo(delayTime, opttype)
    if(delayTime) then 
        local data = {}
        data.delayTime = delayTime
        data.opttype = opttype

        Net.Helper:sendAWSDelayInfo(data)
    else 
        print("AWSLogUtil:sendAWSDelayInfo  opttype must not be nil.")
    end    
end

--[[
    描述：http://aiki.avalongames.com/pages/viewpage.action?pageId=10487069 client_ui_currency 通用客户端点击事件
    opttype:
    opttype1:
    opttype2:
    opttype3:
    opttype_source:
]]
function AWSLogUtil:sendAWSClickInfo(opttype, opttype1, opttype2, opttype3, opttype_source)
    if(opttype) then 
        local data = {}
        data.opttype = opttype
        data.opttype1 = opttype1
        data.opttype2 = opttype2
        data.opttype3 = opttype3
        data.opttype_source = opttype_source

        Net.Helper:sendAWSClickInfo(data)
    else 
        print("AWSLogUtil:sendAWSClickInfo  opttype must not be nil.")
    end
end

--[[
    描述：http://aiki.avalongames.com/pages/viewpage.action?pageId=10487069  client_ad 广告相关日志
    opttype:
    opttype1:
    opttype2:
    opttype3:
]]
function AWSLogUtil:sendAWSAdInfo(opttype, opttype1, opttype2, opttype3)
    if(opttype) then 
        local data = {}
        data.opttype = opttype
        data.opttype1 = opttype1
        data.opttype2 = opttype2
        data.opttype3 = opttype3

        Net.Helper:sendAWSAdInfo(data)
    else 
        print("AWSLogUtil:sendAWSAdInfo  opttype must not be nil.")
    end
end

function AWSLogUtil:sendAWSLOGINInfo(data)
    Net.Helper:sendAWSLOGINInfo(data)
end