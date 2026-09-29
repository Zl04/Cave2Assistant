
local GameDataManager = require("app.game.GameDataManager")

local GoodsSystemTest = class("GoodsSystemTest")

function GoodsSystemTest:testConfig()
    require("app.config.ConfigManager")

    local equipmentConfig = ConfigManager:getGoodsByType(Config.PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,{id = 10010})

    for k,v in pairs(equipmentConfig) do
        if type(v) ~= "table" then
            print("equipmentConfig k="..k.." v="..v)
        else
            print("equipmentConfig k="..k.." v= is table")
        end
    end



end

-- 测试物品的增删改查
function GoodsSystemTest:testGoods()
    local master = RoleDataManager:getMaster()
    local pk = master:getPK()
    local PACKET_TYPE = PublicDefine.PACKET_TYPE
    -- 添加武器
    local packetType = PACKET_TYPE.PACKET_BAG
    local goodsMesData = {}

    goodsMesData.entityID = 1
    goodsMesData.strengthenLevel = 1

    for i=1,10 do
        local num = i/3
        if num ==1 then
            goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21070070,1,goodsMesData,false)
        elseif num ==2 then
            goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21080070,1,goodsMesData,false)
        else
            goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21010060,1,goodsMesData,false)
        end

        -- 21080070
        -- 21010060

        goodsMesData.entityID = goodsMesData.entityID +1
    end

    local addEquipData = true
    if addEquipData then
        packetType = PACKET_TYPE.PACKET_EQUIPMENT
        -- 单手武器
        local goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21070070,1,goodsMesData,false)
        goodsData:setWearPosition(goodsData:getEquipmentType())
        goodsMesData.entityID = goodsMesData.entityID +1

        -- -- 双手武器
        -- goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21080070,1,goodsMesData,false)
        -- goodsData:setWearPosition(EQUIPMENT_TYPE.OneHand)
        -- goodsMesData.entityID = goodsMesData.entityID +1
        
        -- 头盔
        goodsData = GoodsDataManager:handleAddGoodsData(pk,packetType,1,21010060,1,goodsMesData,false)
        goodsData:setWearPosition(goodsData:getEquipmentType())
        goodsMesData.entityID = goodsMesData.entityID +1
    end


    -- 添加道具
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,10,nil,false)
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,20,nil,true)
    -- 添加材料
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL,22010010,10,nil,false)
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL,22020010,20,nil,true)
    
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    GameDataManager:getInstance():getPacketBoxData()
    
    -- 添加道具
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,100,nil,false)
    GoodsDataManager:handleAddGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,200,nil,true)

    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    GameDataManager:getInstance():getPacketBoxData()

    -- 删除道具
    GoodsDataManager:handleUseGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,99,nil,false)
    GoodsDataManager:handleUseGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM,20010010,99,nil,true)

    goodsMesData.entityID =  goodsMesData.entityID - 1
    GoodsDataManager:handleUseGoodsData(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,21080070,1, goodsMesData,false)

    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    GoodsDataManager:sortGoods(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)

    print("---------------------------  delete data print  ")
    GameDataManager:getInstance():getPacketBoxData()
end


return GoodsSystemTest