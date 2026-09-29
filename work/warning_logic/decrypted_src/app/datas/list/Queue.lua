-- Queue.lua
-- Author: ydli
-- 2017-09-11
--队列维护

local Queue = {}
function Queue.new()
    return { first = 0, last = -1 }
end

function Queue.push(Q, value)
    local last = Q.last + 1
    Q.last = last
    Q[last] = value
end

function Queue.pop(Q)
    -- if Q == nil then
    --  return
    -- end
    local first = Q.first
    if first > Q.last then 
        -- print("Q is empty")  
        return nil
    end
    local value = Q[first]
    Q[first] = nil
    Q.first = Q.first + 1
    return value
end

function Queue.size(Q)
    return Q.last - Q.first + 1
end

return Queue