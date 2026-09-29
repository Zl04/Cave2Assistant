--[[--
数据模型CrystalTreatureShopModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/23
--desc	: CrystalTreatureShopModel
------------------------------------------------------------------------------
require "app.datas.GoodsDataManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local CrystalTreatureShopModel = class("CrystalTreatureShopModel",mvc.GameModel)

function CrystalTreatureShopModel:initData()
	self.datas = {}
end

function CrystalTreatureShopModel:refreshShopData(storeType)
    self.datas = {}

    local conf = nil
    conf = ConfigManager:getAllCrystalTreasureShop()

    local isFightScene = false
    if not (SceneManager:getInstance():isNotInFightScene()) then
        --UI.ScrollBar:createByText(UI.TEXT_1213665)
        isFightScene = true
    end

    --local limitData =  GoodsDataManager:getStorePurchaseLimitData()
    local purchaseCount = 0

    for k, v in ipairs(conf) do
        local data = {}
        local requestedMaterial = v.requestedMaterial
        local contribNum = self:getContribNum(storeType, requestedMaterial)--GameDataManager:getInstance():getGoodsDataNumForGoodsID(requestedMaterial)
        local goodsData = GoodsDataManager:createLocalGoodsData(v.shopGoods)
        goodsData:setIsNew(false)
        goodsData:setNum(v.goodsNum)
        data.goodsData = goodsData
        data.consume = v.requestedNum
        data.ID = v.ID
        data.requestedMaterial = v.requestedMaterial
        local isPurchase = false
        -- if v.purchaseLimit then
        --     data.purchaseLimit = v.purchaseLimit

        --     if data.purchaseLimit > 0 then
        --         isPurchase = true
        --     end
        -- else
        --     data.purchaseLimit = 0
        -- end

        -- if limitData[data.ID] then
        --     purchaseCount = limitData[data.ID].purchaseCount
        -- end

        data.buyAble = true
        if isFightScene then
            data.buyAble = false
            data.reason = 1
        else
            local tempData = {}
            tempData.goodsID = v.shopGoods
            tempData.num = v.goodsNum
            tempData.isGolden = true
            local goodsArr = {tempData}
            if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then 
                -- if contribNum < v.requestedNum then
                --     data.buyAble = false
                --     data.reason = 2
                -- end
            else
                data.buyAble = false
                data.reason = 3
            end
        end

        -- -- 限购
        -- if isPurchase and data.purchaseLimit - purchaseCount <= 0 then
        --     data.buyAble = false
        --     data.reason = 4
        -- end

        table.insert(self.datas,data)
    end

    return self.datas
end

function CrystalTreatureShopModel:getContribNum(storeType, requestedMaterial)

    local goodsId = 22072520
    if requestedMaterial ~= nil and type(requestedMaterial) == "number" then
        goodsId = requestedMaterial
    else
        goodsId = 22072520
    end

    return GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsId)
end

return CrystalTreatureShopModel