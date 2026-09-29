local protobuf = require "protobuf"


local ProtobufUtil = {}

--注册指定的文件
function ProtobufUtil:register(filePath)
    assert(filePath ~= nil, "[ERROR] ProtobufUtil:register filePath is nil")

    --第一种注册方式
    -- print("filePath="..filePath)
    local buffer ;
    if bsReadFile then
        buffer = bsReadFile(cc.FileUtils:getInstance():fullPathForFilename(filePath))
    else
        buffer = cc.FileUtils:getInstance():getDataFromFile(filePath)
    end
    -- print("buffer="..buffer)
    protobuf.register(buffer)

    --第二种注册方式
    -- protobuf.register_file(cc.FileUtils:getInstance():fullPathForFilename(filePath))
end

--注册指定列表的文件
function ProtobufUtil:registerFiles(filePathArr)
    if filePathArr ~= nil then
        for k,v in pairs(filePathArr) do 
            self:register(v)
        end
    end
end

--[[
    messageName:组装的消息名字 eg:tutorial.Person
    dataTable: 要打包的消息table   
]]
function ProtobufUtil:encode(messageName,dataTable)
    if ( messageName == nil or dataTable == nil ) then
        return nil
    end

    if protobuf.check(messageName) ==0 then
        return nil
    end

    local data = protobuf.encode(messageName, dataTable)

    return data
end

--[[
    messageName:组装的消息名字 eg:tutorial.Person
    data: 解析的消息  
]]
function ProtobufUtil:decode(messageName,data)
    if messageName == nil or data == nil then
        return nil
    end

    assert(protobuf.check(messageName) ~= 0, string.format("[ERROR] ProtobufUtil:decode messageName=%s is not found",messageName))

    local table, err = protobuf.decode(messageName, data)
    if table then
        -- 这里所有消息都把KEY给绑定起来
        protobuf.extract(table)
    else
        print("ProtobufUtil:decode err=",err, messageName, data)
    end

    return table
end

function ProtobufUtil:enum_id(enum_type, enum_name)
	return protobuf.enum_id(enum_type,enum_name)
end

function ProtobufUtil:unpack(pattern, buffer, length)

	return protobuf.unpack(pattern, buffer, length)
end

function ProtobufUtil:pack(pattern, ...)

	return protobuf.pack(pattern, ...)
end

function ProtobufUtil:check(typename , field)
    
    return protobuf.check(typename,field)
end

-- 判断是否赋值某个字段，这里只对于PB 传递的数值
function ProtobufUtil:checkFieldIsInit(tbl, field)
    if(tbl and field) then
        for k,v in pairs(tbl) do 
            if(k == field) then
                return true
            end
        end
    end

    return false
end

return ProtobufUtil