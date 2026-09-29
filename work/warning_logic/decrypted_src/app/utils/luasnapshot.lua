local snapshot = require "snapshot"
local luasnapshot = {}
local tmp = {}
local S1 = nil;
local S2 = nil;
function luasnapshot.mark()
    S1 = snapshot.snapshot()
end
function luasnapshot.dump()
    if not S1 then
        print("must call luasnapshot.mark() first")
        return;
    end
    S2 = snapshot.snapshot()
    local count = 0;
    for k,v in pairs(S2) do
        if S1[k] == nil then
            print("luasnapshot:",k,v)
            count = count + 1
        end
    end
    
    print("新增了 ",count,"个lua对象","一共有 ",table.nums(S2))
    S1 = nil;
    S2 = nil;
end
return luasnapshot