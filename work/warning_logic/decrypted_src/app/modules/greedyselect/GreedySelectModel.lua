--[[--
数据模型GreedySelectModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/09/19
--desc	: GreedySelectModel
------------------------------------------------------------------------------

local GreedySelectModel = class("GreedySelectModel",mvc.GameModel)
local GameMapManager = require("app.game.GameMapManager")

function GreedySelectModel:initData()
    -- self.severGoodsIds = nil
    -- self.severEventIDs = nil

    self.severGoodsIds = {}
    self.severEventIDs = {}
    self.canGreedy = false
    self.allGreedySelectInfo = {}
    self.rewardGoodsData = nil
end

function GreedySelectModel:checkIsGreedySelecting()
    -- do
    --     return true
    -- end
    for k, v in pairs(self.allGreedySelectInfo) do
        if v and v > 0 then
            return true
        end
    end
    return false
end

function GreedySelectModel:getGreedySelectGoodsConfigByPk(pk)
    -- do
    --     return self:getGreedyGoodsConfig(100001)
    -- end
    local goodsId = self.allGreedySelectInfo[pk]
    if goodsId and goodsId > 0 then
        return self:getGreedyGoodsConfig(goodsId)
    end
end

function GreedySelectModel:clearAllGreedySelectInfo()
    self.allGreedySelectInfo = {}
    self:setForce("allGreedySelectInfo")
    mvc.closePanel("GreedySelect", "GreedySelect")
end

function GreedySelectModel:setGreedySelectInfo(pks, goodsIds)
    for i = 1, #pks do
        self.allGreedySelectInfo[pks[i]] = goodsIds[i]
    end
    self:setForce("allGreedySelectInfo")
end

function GreedySelectModel:getServerSelectInfo(idx)
    return self.severEventIDs[idx], self.severGoodsIds[idx]
end

function GreedySelectModel:checkIsNeedGreedySelect()
    return self.canGreedy
end

function GreedySelectModel:setCanGreedySelect(canGreedy)
    self.canGreedy = canGreedy
end

function GreedySelectModel:setGreedyInfo(goodsIDs, eventIDs)
    self:set("severGoodsIds", goodsIDs)
    self:set("severEventIDs", eventIDs)
end

function GreedySelectModel:checkOpenGreedySelectDataIsOk()
    if #self.severEventIDs > 0 and #self.severGoodsIds > 0 then
        return true
    end
    return false
end
function GreedySelectModel:clearGreedySelectData()
    self.severEventIDs = {}
    self.severGoodsIds = {}
end

function GreedySelectModel:setRewardGoodsData(rewardGoodsData)
    self.rewardGoodsData = rewardGoodsData
end

function GreedySelectModel:checkShowRewardGoodsView()
    if self.rewardGoodsData then
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GET_GOODS, self.rewardGoodsData)
        self.rewardGoodsData = nil
    end
end

function GreedySelectModel:getGreedyGoodsConfig(id)
    -- NewConfig.GreedyOption:getAllDatas()
    return NewConfig.GreedyGoods:getDataById(id)
end


return GreedySelectModel