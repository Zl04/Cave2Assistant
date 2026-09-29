--[[--
数据模型LimitTimePackageModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/07
--desc	: LimitTimePackageModel
------------------------------------------------------------------------------

local LimitTimePackageModel = class("LimitTimePackageModel",mvc.GameModel)

function LimitTimePackageModel:initData()
    -- self.webLangTab = {}
    self.iapDatas = {}
    self.treasureId = -1
    self.refreshDay = 0
    self.treasureIndex = -1

    self.iapProducts = {}
end

function LimitTimePackageModel:setIapDatas(iapDatas)

    for k, v in pairs(iapDatas) do
        if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.TimePushTreasure then
            local pushID = v.pushID
            if not self.iapDatas[pushID] then
                self.iapDatas[pushID] = {}
            end

            local products = {}
            for k, goods in pairs(v.products) do
                if goods.index then
                    if  not products[goods.index] then
                        products[goods.index] = {}
                    end
                    table.insert(products[goods.index], goods)
                end
            end
            self.iapDatas[pushID] = products
            self.iapProducts[pushID] = v
        end
    end

    self:setForce("iapDatas")

    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

function LimitTimePackageModel:getCurProductionInfo()
    return self.iapProducts[self.treasureId]
end

function LimitTimePackageModel:getCurProductionIndex()
    return self.treasureIndex
end

function LimitTimePackageModel:getShowInfo()
    if self.treasureId > 0 then
        if self.iapDatas[self.treasureId] then
            local res = self.iapDatas[self.treasureId][self.treasureIndex]
            if res then
                return res
            end
            return self.iapDatas[self.treasureId][0]
        end
    end
    return nil
end

function LimitTimePackageModel:setNetData(netDatas)
    print(netDatas)

    -- 限时礼包转移到缤纷活动，暂时屏蔽
    if netDatas then
        return
    end

    -- self:set("iapDatas",iapDatas)
    -- required uint64 pk  = 1;
    -- required uint32 curGrade = 2;    //当前档次
    -- required uint32 curStage = 3;    //当前阶段
    -- required uint32 treasureId = 4;    //礼包ID
    -- required uint32 treasureIndex = 5;    //礼包index
    -- required uint32 refreshDay = 6;    //刷新天
    -- repeated uint32 lastConsume = 7;    //最近周期的消费

    self:set("treasureId",netDatas.treasureId)
    self:set("refreshDay",netDatas.refreshDay)
    self:set("treasureIndex",netDatas.treasureIndex)
end

function LimitTimePackageModel:getRefreshDay()
    return self.refreshDay
end

-- function LimitTimePackageModel:loadLan()
--     local keyList = {}
--     SdkManager:getInstance():loadProductsLan( keyList, function(webLaunguageList)
--         for idx,lan in pairs(webLaunguageList) do
--             local p = json.decode(lan)
--             local str = ""
--             for i,v in ipairs(p) do
--                 str = str .. v.text
--             end
--             self.webLangTab[idx] = str
--         end
--         self:setForce("webLangTab")
--     end)
-- end

return LimitTimePackageModel