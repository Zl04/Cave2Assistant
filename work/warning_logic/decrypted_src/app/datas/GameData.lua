

GameData = GameData or {}

local  Base = class("DataBase")

GameData.Base = Base

GameData.InstanceCount = 0

function Base:ctor(category, type)
    -- print("Base:ctor  category, type=",category, type)
    GameData.InstanceCount = GameData.InstanceCount + 1
    self._id = GameData.InstanceCount
    self._category = category
    self._type = type
end

-- 获取数据的唯一ID
function Base:getInstanceID()
    return self._id
end

function Base:getId()
    assert(false, "[ERROR] GameData.Base:getId     this method should be overrided by sub class.")
end
-- 获取分类
function Base:getCategory()
    return self._category
end

-- 获取类型
function Base:getType()
    return self._type
end

-- 获取虚幻后的分类
function Base:getDeformationCategory()
    return self._category
end

-- 获取虚幻后的类型
function Base:getDeformationType()
    return self._type
end

-- 获取状态
function Base:getState()
    assert(false, "[ERROR] GameData.Base:getState     this method should be overrided by sub class.")
end

-- 设置状态
function Base:setState(state)
    assert(false, "[ERROR] GameData.Base:setState     this method should be overrided by sub class.")
end

-- 获取位置
function Base:getCoord()
    assert(false, "[ERROR] GameData.Base:getCoord     this method should be overrided by sub class.")
end

-- 设置位置
function Base:setCoord(coord)
    assert(false, "[ERROR] GameData.Base:setCoord     this method should be overrided by sub class.")
end

-- 设置方向 
function Base:setDirection(direction)
    assert(false, "[ERROR] GameData.Base:setDirection     this method should be overrided by sub class.")
end
-- 获取方向
function Base:getDirection()
    assert(false, "[ERROR] GameData.Base:getDirection     this method should be overrided by sub class.")
end

function Base:setLocalConfigData(localConfig)
    if(localConfig) then
        if (not self._localConfig) then
            local oldMetatable = getmetatable(self)
            local newMetatable = {}
            if oldMetatable then
                newMetatable.__index = function(table,key)
                    local oldValue = nil

                    local index = oldMetatable.__index
                    if index and type(index) == "function" then
                        oldValue = index(oldMetatable, key)
                    elseif index and type(index) == "table" then
                        oldValue = index[key]
                    end
                    if not oldValue then
                        if (table._localConfig) then
                            return table._localConfig[key]
                        end
                    end
                    return oldValue
                end
            else
                newMetatable.__index = function(table,key)
                    if (table._localConfig) then
                        return table._localConfig[key]
                    else 
                        return nil
                    end  
                end
            end

            setmetatable(self,newMetatable)
        end
    end

    self._localConfig = localConfig
end


