local proto = require "utils.ProtobufUtil"

local pb = {}

-- 打包使用方式展现
function pb.packFunction()
    --第一种打包方式

    local addressbook = {
        name = "第一种方案", -- 这里“name”  和消息 Person 的 name 字段是一一对应的
        id = 10,
        phone = {
        { number = "87654321", type = "WORK" }
        },
    }

    -- 打包 Person 消息
    local person = proto:encode("tutorial.Person", addressbook)


    --第二种打包方式
    local phone = proto:pack("tutorial.Person.PhoneNumber number","87654321")  -- pack a PhoneNumber package.
    local person = proto:pack("tutorial.Person name id phone","第二种方式",10,{phone}) -- phone list is a repeated field


end

--解包使用方式展现
function pb.unPackFunction()
    local addressbook = {
        name = "第一种方案", -- 这里“name”  和消息 Person 的 name 字段是一一对应的
        id = 10,
        phone = {
        { number = "87654321", type = "WORK" }
        },
    }

    -- 打包 Person 消息
    local person = proto:encode("tutorial.Person", addressbook)
    
    --第一种解包方式
    local dePerson = proto:decode("tutorial.Person",person)

    -- use pb.unpack to unpack package
    local name, id, phone_package = proto:unpack("tutorial.Person name id phone", person)
    local number = proto:unpack("tutorial.Person.PhoneNumber number",unpack(phone_package[1])) -- unpack return message with { buffer, length }

    print("number="..number)
end

function pb.sendToServerMes(id)
    -- 组装消息
   local addressbook = {
        name = "lua Alice", -- 这里“name”  和消息 Person 的 name 字段是一一对应的
        id = 0,
        email = "lua email",
        phone = {
        { number = "1301234567",type = "WORK" },
        { number = "87654321", type = "WORK" }
        },
        atm = {
        aa = 232434343;
        cc = "34343rerereeeeeee";
        }
    }

    -- 打包 Person 消息
    local person = proto:encode("tutorial.Person", addressbook)

    -- 打包 testToServer 消息
    local mes = proto:pack("tutorial.testToServer id mes person ",id,"cient to server",person)

    avalon.NetManager:getInstance():send(1,1,1, mes)
end



function pb.handleServerBackMes(tab)
    local data = protobuf:decode("tutorial.testToServer",tab['data'])

    local id = data['id']
    -- print("handleServerBackMes  dir="..tab['dir'].."  sec="..tab['sec'].." no="..tab['no'].."  id="..id.."  phone number="..data['person']['phone'][1]['number'])
    id = id + 1

    local mn = data['person']

    local person = proto:encode("tutorial.Person", mn)

    local mes = proto:pack("tutorial.testToServer id mes person",id,data['mes'], person)
    
    avalon.NetManager:getInstance():send(1,1,1, mes)
end




function pb.testEnum()
    local addressbook = {
        name = "lua Alice",
        id = 0,
        email = "lua email",
        phone = {
        { number = "1301234567",type = "WORK" },
        { number = "87654321", type = "WORK" }
        },
        atm = {
        aa = 232434343;
        cc = "34343rerereeeeeee";
        }
    }

    local person = proto:encode("tutorial.Person", addressbook)
    local mes = proto:pack("tutorial.testToServer id mes person ",id,"cient to server",person)

    --测试枚举效果
    local perDecode = proto:decode("tutorial.Person", person)

    -- 对于枚举字段类型输出
    print("enum type="..type(perDecode["phone"][1]["type"]))
    print("enum type value="..perDecode["phone"][1]["type"])

    -- 这里实例把枚举类型转换为对应的数值
    local typeId = proto:enum_id("tutorial.Person.PhoneType",perDecode["phone"][1]["type"])
    print("enum type="..typeId)
    print("enum type value="..typeId)
end

-- 测试读取文件中数据来解析
function pb.testReadFile()
    local writePath = cc.FileUtils:getInstance():getWritablePath();

    local cppPath = writePath.."cppaddressbook.txt";
    print("cppPath="..cppPath)
    data = bsReadFile(cppPath)
    decode = proto:decode("tutorial.Person", data)
    print(decode.name)
    print(decode.id)
    print(decode.email)

    print("cpp test="..decode.test[1])
end

function pb.testSaveFile()
    local addressbookExt = {
        name = "lua Alice",
        id = 1234434345,
        email = "lua email",
        phone = {
        { number = "1301234567" },
        { number = "87654321", type = "WORK" }
        },
        atm = {
        aa = 232434343;
        cc = "34343rerereeeeeee";
        },
    }

    --继承写入数据
    local packMes = proto:pack("tutorial.Person name id ",addressbookExt['name'],addressbookExt['id'])
    -- protobuf.pack("tutorial.Ext.test",987654)

    local encodeMes = proto:encode("tutorial.Person",addressbookExt)
    if packMes == encodeMes then
        print("pack encode is equal")
    else
        print("pack encode not equal")
    end

    local writePath = cc.FileUtils:getInstance():getWritablePath()
    --把编码的数据写入文件，在c++ 层读取出来解析
    local luaPath = writePath.."luaaddressbook.txt";
    file = io.open(luaPath, "w");
    assert(file);
    file:write(encodeMes);
    file:close();

    print("packMes="..packMes)
    print("encodeMes="..encodeMes)
end

return pb