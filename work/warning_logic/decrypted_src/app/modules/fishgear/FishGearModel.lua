--[[--
数据模型FishGearModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/13
--desc	: FishGearModel
------------------------------------------------------------------------------
require "app.config.ConfigManager"

local FishGearModel = class("FishGearModel",mvc.GameModel)

function FishGearModel:initData()
	self.shopConfig = ConfigManager:getAllFishShopData()
    self.buyGoodsNum = nil
end

function FishGearModel:getFishShopConfig()
    return self.shopConfig
end

function FishGearModel:setBuyGoodsNum(num)
    self.buyGoodsNum = num
end

function FishGearModel:getBuyGoodsNum()
    return self.buyGoodsNum
end

return FishGearModel