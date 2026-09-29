
local MathUtil = {}
Avalon.MathUtil = MathUtil

-- 获取数值的整数（四舍五入）
function MathUtil:getInt(number)
    return math.floor(number+0.5)
end

-- 检测钻石是是否足够
function MathUtil:checkDiamonEnough(cost, haveDiamond)
    if(cost == 0) then 
        return true
    end

    if(cost <= haveDiamond) then 
        return true
    end

    return false
end

-- 检测是否足够 
function MathUtil:checkEnough(cost, hasNum)
    if(cost == 0) then 
        return true
    end

    if(cost <= hasNum) then 
        return true
    end

    return false
end