--[[
    用户数据 － 背包
]]--

require "utils.userdata.UserData"

Avalon = Avalon or {}

local BagUserData = class("BagUserData", Avalon.UserData)
Avalon.BagUserData = BagUserData

-- private:
-- 构造函数
function BagUserData:ctor()
    BagUserData.super.ctor(self, USER_DATA_TYPE.BAG)

    self.userID = 33333
    self.equipmentCount = 123
    self.name = "wujun"
    self.equipments = {
        ["key"] = "no1",
        ["v"] = "no2"
    }
end
