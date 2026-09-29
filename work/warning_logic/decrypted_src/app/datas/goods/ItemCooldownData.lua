

GameData = GameData or {}

local  ItemCooldownData = class("ItemCooldownData")

GameData.ItemCooldownData = ItemCooldownData

function ItemCooldownData:ctor()

end

function ItemCooldownData:init(goodsID,curDuration)
    self.goodsID = goodsID
    self.curDuration = curDuration
    self.curServerTime = AvalonUtil:getCurrentTime()
end

-- 获取冷却的物品ID
function ItemCooldownData:getGoodsID()
    return self.goodsID
end

-- 获取剩余冷却时间(经过计算后得值)
function ItemCooldownData:getCooldownTime()
    local curDuration = AvalonUtil:getCurrentTime() - self.curDuration
    if curDuration < 0 then
        curDuration = 0
    end
    return curDuration
end


