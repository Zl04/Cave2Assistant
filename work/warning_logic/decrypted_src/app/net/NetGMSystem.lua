--[[
    GM网络消息
]]

Net = Net or {}

local NetGMSystem = {}
Net.NetGMSystem = NetGMSystem

-- 请求：添加游戏元素
function NetGMSystem:addGameElementRequest(elementType, pk, data)
    print("------------NetGMSystem:addGameElementRequest")
    local messageData = {
        elementType = elementType,
        pk = pk,
        elementData = data
    }
    --dump(messageData, "messageData")
    Net.Helper:sendMessage(NetMessageType.GM_ADD_GAME_ELEMENT, messageData)
end

-- 处理器
function NetGMSystem:onGMMessageHandler(no, data)
    if (no == NetMessageType.GM_ADD_GAME_ELEMENT.NO) then
        print(string.format("NetGMSystem add element. [no:%d data:%s]", no, data))
    else
        print(string.format("[WARNING] NetGMSystem no handler for this message. [no:%d data:%s]", no, data))
    end
end