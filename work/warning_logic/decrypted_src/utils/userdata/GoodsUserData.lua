--[[
    用户数据 － 物品大类
]]--

require "utils.userdata.UserData"

Avalon = Avalon or {}

local GoodsUserData = class("GoodsUserData", Avalon.UserData)
Avalon.GoodsUserData = GoodsUserData

-- private:
-- 构造函数
function GoodsUserData:ctor()
    GoodsUserData.super.ctor(self, USER_DATA_TYPE.GOODS)

    self._newGoodsFlag = {}
    -- key:武器实例ID value:1
    self._newGoodsFlag.equipArr = {}
    -- key:物品模板ID value:1
    self._newGoodsFlag.goodsArr = {}
    -- 本地快捷栏信息
    self._shortcutBarArr = {}

    -- self.userID = 33333
    -- self.equipmentCount = 123
    -- self.name = "wujun"
    -- self.equipments = {
    --     ["key"] = "no1",
    --     ["v"] = "no2"
    -- }
end

-- 获取标志位
function GoodsUserData:getNewStatus(ID,goodsType)
    local flag = true
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        if self._newGoodsFlag.equipArr[tostring(ID)] ~= nil then
            flag = false
        end
    else
        if self._newGoodsFlag.goodsArr[tostring(ID)] ~= nil then
            flag = false
        end
    end
    
    -- print("GoodsUserData:getNewStatus  ID,goodsType,isNew=",ID,goodsType,flag)

    return flag
end

-- 设置标志位
function GoodsUserData:setDataNew(ID,goodsType,isNew)
    if isNew == false then
        -- print("GoodsUserData:setDataNew  ID,goodsType,isNew=",ID,goodsType,isNew)
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            self._newGoodsFlag.equipArr[tostring(ID)] = "1"
        else
            self._newGoodsFlag.goodsArr[tostring(ID)] = "1"
        end
    end
end

-- 清理装备标志
function GoodsUserData:clearEquipArr()
     self._newGoodsFlag.equipArr = {}
end 

function GoodsUserData:getShortcutBarData(index)
    if(self._shortcutBarArr[index] == nil) then 
        self._shortcutBarArr[index] = {} 
    end
    return self._shortcutBarArr[index]
end

function GoodsUserData:setShortcutBarData(index, data)
    index = tostring(index)
    self._shortcutBarArr[index] = data
end

function GoodsUserData:print()
    dump(self)
end