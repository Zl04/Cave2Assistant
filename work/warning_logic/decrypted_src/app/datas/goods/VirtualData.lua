
--[[
    道具属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local VirtualData = class("VirtualData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local GOODS_RARE = PublicDefine.GOODS_RARE
local ITEM_TYPE = PublicDefine.ITEM_TYPE

Goods = Goods or {}

Goods.VirtualData = VirtualData

function VirtualData:ctor(goodsID,num)
    VirtualData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM)
    self.goodsID = goodsID
    self.num = num or 1

     -- 初始化处理
    local localData = ConfigManager:getVirtualItemConfigByID(self.goodsID)
    if localData then
        self:initLocalData(localData)
    else
        assert(false, string.format("VirtualData:initNetData  %d no found local data ",self.goodsID))
    end
end 


function VirtualData:initLocalData(data)
    self:setLocalConfigData(data)
    -- TODO 数据截取

end

-- 获取虚拟物品类型
function VirtualData:getVirtualType()
    return self.type
end

function VirtualData:getIconName()
    return self.icon
    -- return "icon_010002.png"
end

-- 获取物品功能描述
function VirtualData:geteffecDescription()
    return LanguageManager:getInstance():getLocalString(self.effecDescription)
end

function VirtualData:conbinationLocalData()

end

-- 获取是否可以查看详情
function VirtualData:getCanBeView()
    print("VirtualData:getCanBeView", self.canBeView)
    if(self.canBeView == 1) then 
        return true
    end

    return false 
end