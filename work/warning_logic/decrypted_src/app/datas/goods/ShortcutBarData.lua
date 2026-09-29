
--[[
    快捷栏数据
]]
local GameDataManager = require("app.game.GameDataManager")
local ShortcutBarData = class("ShortcutBarData")  

local PACKET_TYPE = PublicDefine.PACKET_TYPE

Goods = Goods or {}

Goods.ShortcutBarData = ShortcutBarData

function ShortcutBarData:ctor()
    self.index = -1
    self.templateID = 0
    self._skillGroupID = nil
    self._shortcutData = nil
end

function ShortcutBarData:initNetData(index,templateID)
    self._skillGroupID = nil
    self.index = index
    self.templateID = templateID
    self._shortcutData = nil

    -- 根据ID 生成一个数据对象
    if self:isSkill() then
        -- 创建一个技能数据对象
        self._shortcutData = SkillDataManager:createSkillForSkillId(self.templateID)
        if(self._shortcutData) then
            self._skillGroupID = SkillDataManager:getSkillGroupIDBySKillID(templateID)
        else 
            self.templateID = 0
        end
        self:refresh()
    elseif self:isItem() then
        -- 创建一个道具数据对象
        self._shortcutData = GoodsDataManager:createLocalGoodsData(self.templateID)
        self:refresh(true)
    end
end

-- 清理数据
function ShortcutBarData:clear()
    -- self.index = -1
    self.templateID = 0
    self._skillGroupID = nil
    self._shortcutData = nil
end

function ShortcutBarData:refresh(onlyItem)
    if(onlyItem == nil) then
        onlyItem = false
    end

    -- 根据类型刷新拥有数量
    if (self:isItem()) then
        -- 获取道具数量
        local num = GameDataManager:getInstance():getGoodsDataNum(PACKET_TYPE.PACKET_BAG,self.templateID,true)
        if self._shortcutData then
            self._shortcutData:setNum(num)
        end
    end
    
    if(onlyItem == false and self:isSkill()) then
        -- 判断技能是否还存在
        local skillID, lv , skillList  = SkillDataManager:getSkillIDBySkillGropuID(self._skillGroupID)
        local skillData
        if skillID then
            skillData = SkillDataManager:getSkillDataForSkillID(skillID, false)
        end
        if (skillID == nil or skillData == nil ) then
            local found = false
            if(skillList) then
                -- 处理查找是否有这个
                local assistArr = SkillDataManager:getMasterLearnSkillList()
                -- print("ShortcutBarData:refresh ",self.index)
                -- dump(assistArr)
                for _,sID in pairs(skillList) do
                    for _,skillData in pairs(assistArr) do
                        if(skillData:getSkillID() == sID) then
                            found = true
                            self._shortcutData = SkillDataManager:createSkillForSkillId(sID)
                            if(self._shortcutData) then 
                                self.templateID = sID
                            end
                            break;
                        end
                    end
                end
            end
            -- print("ShortcutBarData:refresh ",found)
            if(found == false) then
                -- 删掉数据
                GameManager:shortcutBarDelete(self.index)
            end
        else
            self._shortcutData = SkillDataManager:createSkillForSkillId(skillID)
            if(self._shortcutData) then
                self.templateID = skillID
            end
        end
    end
end

function ShortcutBarData:getId()
    return self.templateID
end

function ShortcutBarData:getIndex()
    return self.index
end

function ShortcutBarData:getSkillGroupID()
    return self._skillGroupID
end

-- 获取数据
function ShortcutBarData:getData()
    return self._shortcutData
end

-- 判断是否为道具
function ShortcutBarData:isItem()
    if self.templateID < 30000000 and self.templateID > 20000000 then
        return true
    end

    return false
end

function ShortcutBarData:isSkill()
    if self.templateID > 30000000 then
        return true
    end

    return false
end

-- 判断是否为null 的处理
function ShortcutBarData:isNull()
    if self._shortcutData then
        return false
    else 
        return true
    end
end 

-- 获取物品名字
function ShortcutBarData:getName()
    -- return self.name
    if self._shortcutData then
        return self._shortcutData:getName()
    else
        return ""
    end
end

-- 获取icon 名字
function ShortcutBarData:getIconName()
   if self._shortcutData then
        return self._shortcutData:getIconName()
    else
        return nil
    end
end

-- 获取物品描述
function ShortcutBarData:getDescription()
   if self._shortcutData then
        return self._shortcutData:getDescription()
    else
        return 0
    end
end

-- 获取物品描述
function ShortcutBarData:geteffecDescription()
   if self._shortcutData then
        return self._shortcutData:geteffecDescription()
    else
        return 0
    end
end

-- 获取物品数量
function ShortcutBarData:getNum()
    if self:isItem() then
        return self._shortcutData:getNum()
    else
        return 0
    end
end
