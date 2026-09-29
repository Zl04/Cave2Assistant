--[[--
数据模型ManorStarMapModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/27
--desc	: ManorStarMapModel
------------------------------------------------------------------------------

local ManorStarMapModel = class("ManorStarMapModel",mvc.GameModel)

function ManorStarMapModel:initData()
    -- 金币培养次数
    self._cultureCountByGold = 0
    -- 所有星辰卡数据
	self._starCardData = {}
    -- 星曹数据
    self._starAtlasSlotData = {}
    -- 升级卡槽数据
    self._starCardUpgradeData = {}


    -- -- 初始化测试数据
    -- self:initTestData()
end

function ManorStarMapModel:getCultureCountByGold()
    return self._cultureCountByGold
end

function ManorStarMapModel:initTestData()
    self._cultureCountByGold = 2

    self._starCardData = {
        [1010120] = {
            cardId = 1010120,
            level = 13,
            slotId = 1,
            cardPage = 1,

        },
        [1010130] = {
            cardId = 1010130,
            level = 11,
            slotId = 2,
            cardPage = 1,
        },
        [1010220] = {
            cardId = 1010220,
            level = 12,
            slotId = 3,
            cardPage = 1,
        },
        [1010230] = {
            cardId = 1010230,
            level = 14,
            slotId = 4,
            cardPage = 1,
        },
        [1010420] = {
            cardId = 1010420,
            level = 2,
            slotId = 0,
            cardPage = 0,
        },
        [1010430] = {
            cardId = 1010430,
            level = 2,
            slotId = 6,
            cardPage = 1,
        },
        [2030510] = {
            cardId = 2030510,
            level = 17,
            slotId = 5,
            cardPage = 1,
        },
    }

    self._starAtlasSlotData = {
        {
            slotId = 1,
            starCardId = 1010120,
        },
        {
            slotId = 2,
            starCardId = 2030510,
        },
        {
            slotId = 3,
            starCardId = 1010130,
        },
        {
            slotId = 4,
            starCardId = 1010230,
        }
    }


    -- self._starCardUpgradeData = {}
    
end

function ManorStarMapModel:getCardDataByCardId(cardId)
    if not cardId then
        return nil
    end

    return self._starCardData[cardId]
end

function ManorStarMapModel:getCardUpgradeDataBySlotId(slotId)
    if not slotId then
        return nil
    end

    return self._starCardUpgradeData[slotId]
end

function ManorStarMapModel:updateStarMapData(data)
    if data.cultureCountByGold ~= nil then
        self._cultureCountByGold = data.cultureCountByGold
    end

    if data.cards ~= nil then
        for k,v in pairs(data.cards) do
            local cData = v
            cData.slotId = 0
            cData.cardPage = 0
            self._starCardData[v.cardId] = cData
        end
    end

    if data.slots ~= nil then
        for k,v in pairs(data.slots) do
            self._starAtlasSlotData[v.slotId] = v
            if self._starCardData[v.starCardId] then
                self._starCardData[v.starCardId].slotId = v.slotId
                local sConf = ConfigManager:getAllCardSlotDataByID(v.slotId)
                self._starCardData[v.starCardId].cardPage = sConf.CardPage
            end
        end
    end

    if data.upgrades ~= nil then
        for k,v in pairs(data.upgrades) do
            self._starCardUpgradeData[v.slotId] = v
        end
    end

    -- print("self._starCardData =========== ")

    -- dump(self._starCardData)

    -- required uint32 cultureCountByGold = 1;                 // 金币培养次数
    -- repeated StarAtlasSlotData slots = 2;                   // 星槽数据
    -- repeated StarCardData cards = 3;                        // 星辰卡
    -- repeated StarCardUpgradeData upgrades = 4;              // 星辰卡升级槽
end

function ManorStarMapModel:updateStarCardData(cardId)

    if not self._starCardData[cardId] then
        -- 展示获得卡牌的界面
        mvc.openPanel("ManorStarMap", "ManorStarMapGetCard",cardId)
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_BAG_PANEL)
    end

    self._starCardData[cardId] = {
        cardId = cardId,
        level = 1,
        slotId = 0,
        cardPage = 0,
    }
    

end

function ManorStarMapModel:getCardPageConfigModelByPageId(page, mosaicType)
    local data = {}
    local cardConfig = ConfigManager:getAllCardSlotData()

    for k,v in pairs(cardConfig) do
        if v.CardPage == page and mosaicType == v.mosaicType then
            local _v = clone(v)
            _v.cardId = 0
            _v.level = 0
            _v.mosaicType = 0
            for m,n in pairs(self._starAtlasSlotData) do
                -- local sData = ConfigManager:getAllCardSlotDataByID(n.slotId)
                if v.ID == n.slotId then

                    local cardData = self._starCardData[n.starCardId]

                    if cardData then
                        _v.cardId = cardData.cardId
                        _v.level = cardData.level
                    else
                        print("卡牌ID错误  : ",n.starCardId)
                    end
                end
            end
            _v.mosaicType = mosaicType
            table.insert(data,_v)
        end
    end

    if #data > 1 then
        table.sort(data, function(a, b)
            return a.ID < b.ID
        end)
    end

    return data
end

--获取星辰卡片背包中的卡牌数据
function ManorStarMapModel:getStarMapBoxCardData()
    local data = {}

    for k,v in pairs(self._starCardData) do
        local inSide = false
        for m,n in pairs(self._starCardUpgradeData) do
            if n.cardId == v.cardId then
                inSide = true
                break
            end
        end

        if not inSide then
            table.insert(data,v)
        end
    end

    return data
end

--检测升级槽是否满了
function ManorStarMapModel:checkUpgradeCardSlotIsFull()
    local isFull = true

    for k,v in pairs(self._starCardUpgradeData) do
        if v.cardId == 0 then
            isFull = false
            break
        end
    end

    return isFull
end

--获得升级槽空闲的槽位
function ManorStarMapModel:getIdleSlotId()
    local slotId = -1

    for k,v in pairs(self._starCardUpgradeData) do
        if v.cardId == 0 then
            if slotId == -1 then
                slotId = v.slotId
            else
                slotId = slotId > v.slotId and v.slotId or slotId
            end
        end
    end

    return slotId
end


function ManorStarMapModel:getAllCardAttributes()
    local attrData = {
        [PublicDefine.ATTR_TYPE.hp] = {attrType = PublicDefine.ATTR_TYPE.hp, icon = "symbol_gaming_blood.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.hp)},
        [PublicDefine.ATTR_TYPE.magic] = {attrType = PublicDefine.ATTR_TYPE.magic, icon = "symbol_gaming_maggicatk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magic)},
        [PublicDefine.ATTR_TYPE.atkMin] = {attrType = PublicDefine.ATTR_TYPE.atkMin, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMin)},
        [PublicDefine.ATTR_TYPE.atkMax] = {attrType = PublicDefine.ATTR_TYPE.atkMax, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMax)},
        [PublicDefine.ATTR_TYPE.physicDef] = {attrType = PublicDefine.ATTR_TYPE.physicDef, icon = "symbol_gaming_def.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.physicDef)},
        [PublicDefine.ATTR_TYPE.magicDef] = {attrType = PublicDefine.ATTR_TYPE.magicDef, icon = "symbol_gaming_maggicdef.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magicDef)},
        [PublicDefine.ATTR_TYPE.atkFire] = {attrType = PublicDefine.ATTR_TYPE.atkFire, icon = "symbol_monsterattribute_fire_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkFire)},
        [PublicDefine.ATTR_TYPE.defFire] = {attrType = PublicDefine.ATTR_TYPE.defFire, icon = "symbol_monsterattribute_fire_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defFire)},
        [PublicDefine.ATTR_TYPE.atkWater] = {attrType = PublicDefine.ATTR_TYPE.atkWater, icon = "symbol_monsterattribute_water_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWater)},
        [PublicDefine.ATTR_TYPE.defWater] = {attrType = PublicDefine.ATTR_TYPE.defWater, icon = "symbol_monsterattribute_water_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWater)},
        [PublicDefine.ATTR_TYPE.atkWood] = {attrType = PublicDefine.ATTR_TYPE.atkWood, icon = "symbol_monsterattribute_wood_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWood)},
        [PublicDefine.ATTR_TYPE.defWood] = {attrType = PublicDefine.ATTR_TYPE.defWood, icon = "symbol_monsterattribute_wood_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWood)},
        [PublicDefine.ATTR_TYPE.atkLight] = {attrType = PublicDefine.ATTR_TYPE.atkLight, icon = "symbol_monsterattribute_light_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkLight)},
        [PublicDefine.ATTR_TYPE.defLight] = {attrType = PublicDefine.ATTR_TYPE.defLight, icon = "symbol_monsterattribute_light_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defLight)},
        [PublicDefine.ATTR_TYPE.atkDark] = {attrType = PublicDefine.ATTR_TYPE.atkDark, icon = "symbol_monsterattribute_dark_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkDark)},
        [PublicDefine.ATTR_TYPE.defDark] = {attrType = PublicDefine.ATTR_TYPE.defDark, icon = "symbol_monsterattribute_dark_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defDark)},
    }

    --计算卡片的属性
    for k,v in pairs(self._starAtlasSlotData) do
        if v.starCardId ~= 0 then
            local cardConfig = ConfigManager:getAllStarCardDataByID(v.starCardId)
            local level = self._starCardData[v.starCardId].level

            local attributeTable = string.split(cardConfig.attributeType, ",")
            local overTable = string.split(cardConfig.attributeValue, ";")
            local valueTable = string.split(overTable[level], ",")

            for index,attrType in pairs(attributeTable) do
                if attrData[tonumber(attrType)] then
                    attrData[tonumber(attrType)].value = attrData[tonumber(attrType)].value + tonumber(valueTable[index])
                end
            end
        end
    end

    local data = {}
    local sortTable = {
        PublicDefine.ATTR_TYPE.hp,
        PublicDefine.ATTR_TYPE.magic,
        PublicDefine.ATTR_TYPE.atkMin,
        PublicDefine.ATTR_TYPE.atkMax,
        PublicDefine.ATTR_TYPE.physicDef,
        PublicDefine.ATTR_TYPE.magicDef,
        PublicDefine.ATTR_TYPE.atkFire,
        PublicDefine.ATTR_TYPE.defFire,
        PublicDefine.ATTR_TYPE.atkWater,
        PublicDefine.ATTR_TYPE.defWater,
        PublicDefine.ATTR_TYPE.atkWood,
        PublicDefine.ATTR_TYPE.defWood,
        PublicDefine.ATTR_TYPE.atkLight,
        PublicDefine.ATTR_TYPE.defLight,
        PublicDefine.ATTR_TYPE.atkDark,
        PublicDefine.ATTR_TYPE.defDark
    }

    for k,v in ipairs(sortTable) do
        table.insert(data,attrData[v])
    end

    return data
end

function ManorStarMapModel:getCardAttributesByCardData(cardData)

    if not cardData then
        return nil
    end

    local aData = {}

    local attrData = {
        [PublicDefine.ATTR_TYPE.hp] = {attrType = PublicDefine.ATTR_TYPE.hp, icon = "symbol_gaming_blood.png", value = 0},
        [PublicDefine.ATTR_TYPE.magic] = {attrType = PublicDefine.ATTR_TYPE.magic, icon = "symbol_gaming_maggicatk.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkMin] = {attrType = PublicDefine.ATTR_TYPE.atkMin, icon = "symbol_gaming_atk.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkMax] = {attrType = PublicDefine.ATTR_TYPE.atkMax, icon = "symbol_gaming_atk.png", value = 0},
        [PublicDefine.ATTR_TYPE.physicDef] = {attrType = PublicDefine.ATTR_TYPE.physicDef, icon = "symbol_gaming_def.png", value = 0},
        [PublicDefine.ATTR_TYPE.magicDef] = {attrType = PublicDefine.ATTR_TYPE.magicDef, icon = "symbol_gaming_maggicdef.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkFire] = {attrType = PublicDefine.ATTR_TYPE.atkFire, icon = "symbol_monsterattribute_fire_1.png", value = 0},
        [PublicDefine.ATTR_TYPE.defFire] = {attrType = PublicDefine.ATTR_TYPE.defFire, icon = "symbol_monsterattribute_fire_2.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkWater] = {attrType = PublicDefine.ATTR_TYPE.atkWater, icon = "symbol_monsterattribute_water_1.png", value = 0},
        [PublicDefine.ATTR_TYPE.defWater] = {attrType = PublicDefine.ATTR_TYPE.defWater, icon = "symbol_monsterattribute_water_2.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkWood] = {attrType = PublicDefine.ATTR_TYPE.atkWood, icon = "symbol_monsterattribute_wood_1.png", value = 0},
        [PublicDefine.ATTR_TYPE.defWood] = {attrType = PublicDefine.ATTR_TYPE.defWood, icon = "symbol_monsterattribute_wood_2.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkLight] = {attrType = PublicDefine.ATTR_TYPE.atkLight, icon = "symbol_monsterattribute_light_1.png", value = 0},
        [PublicDefine.ATTR_TYPE.defLight] = {attrType = PublicDefine.ATTR_TYPE.defLight, icon = "symbol_monsterattribute_light_2.png", value = 0},
        [PublicDefine.ATTR_TYPE.atkDark] = {attrType = PublicDefine.ATTR_TYPE.atkDark, icon = "symbol_monsterattribute_dark_1.png", value = 0},
        [PublicDefine.ATTR_TYPE.defDark] = {attrType = PublicDefine.ATTR_TYPE.defDark, icon = "symbol_monsterattribute_dark_2.png", value = 0},

        --全元素攻击 (用于显示)
        [81] = {attrType = 81, icon = "symbol_monsterattribute_all_1.png", value = 0},
        --全元素防御 (用于显示)
        [82] = {attrType = 82, icon = "symbol_monsterattribute_all_2.png", value = 0},
    }

    local cardConfig = ConfigManager:getAllStarCardDataByID(cardData.cardId)
    local level = cardData.level

    local attributeTable = string.split(cardConfig.showType, ",")
    local overTable = string.split(cardConfig.showValue, ";")
    local valueTable = string.split(overTable[level], ",")


    for index,attrType in pairs(attributeTable) do
        if attrData[tonumber(attrType)] and not aData[tonumber(attrType)] then
            aData[tonumber(attrType)] = attrData[tonumber(attrType)]
        end

        if aData[tonumber(attrType)] then
            aData[tonumber(attrType)].value = aData[tonumber(attrType)].value + tonumber(valueTable[index])
        end
    end

    local data = {}
    local sortTable = {
        PublicDefine.ATTR_TYPE.hp,
        PublicDefine.ATTR_TYPE.magic,
        PublicDefine.ATTR_TYPE.atkMin,
        PublicDefine.ATTR_TYPE.atkMax,
        PublicDefine.ATTR_TYPE.physicDef,
        PublicDefine.ATTR_TYPE.magicDef,
        PublicDefine.ATTR_TYPE.atkFire,
        PublicDefine.ATTR_TYPE.defFire,
        PublicDefine.ATTR_TYPE.atkWater,
        PublicDefine.ATTR_TYPE.defWater,
        PublicDefine.ATTR_TYPE.atkWood,
        PublicDefine.ATTR_TYPE.defWood,
        PublicDefine.ATTR_TYPE.atkLight,
        PublicDefine.ATTR_TYPE.defLight,
        PublicDefine.ATTR_TYPE.atkDark,
        PublicDefine.ATTR_TYPE.defDark,
        81,
        82
    }

    for k,v in ipairs(sortTable) do
        if aData[v] then
            table.insert(data,aData[v])
        end
    end

    return data
end


return ManorStarMapModel