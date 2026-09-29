--[[
    用户数据
]]--

Avalon = Avalon or {}

local UserData = class("UserData")
Avalon.UserData = UserData

-- private:
-- 构造函数
function UserData:ctor(type)
    self._type = type
    self._id = AvalonUtil:generateUUID()
end

-- 析构函数
function UserData:dtor()
    
end

-- public:
-- 获取用户id
function UserData:getUUID()
    return self._id
end

-- 
function UserData:setUUID(uuid)
    self._id = uuid
end

-- 获取用户数据类型
function UserData:getType()
    return self._type
end

-- 将对象转换成数据
function UserData:getData()
    --print(string.format("UserData: convert UserData object (%s) to data", self._type))

    local data = {}
    for key, value in pairs(self) do
        local valueType = type(value)
        if (key ~= "class" and valueType ~= "function") then
            data[key] = value
        end
    end
    return data
end

-- 将数据转换成对象
function UserData:setData(data)
    --print(string.format("UserData: convert data to UserData object (%s)", self._type))

    if (data) then
        for key, value in pairs(data) do
            local valueType = type(value)
            if (key ~= "class" and valueType ~= "function") then
                self[key] = value
            end
        end
    else
        assert(false)
    end
end

function UserData:print()
    
end