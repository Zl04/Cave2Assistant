--[[
    根据需求实现一些方法
]]

local LanguageManager = require("app.game.LanguageManager")
require("app.datas.PublicDefine")
local bit = require "bit"

ToolsUtil = ToolsUtil or {}

--雷替提供的屏蔽字库文字
ToolsUtil.maskword = {}
ToolsUtil.meaninglessStr = {}
--[[
    拆分属性改变值
    reason:属性改变原因
    返回值为拆分出来的4个小属性值
]]
function ToolsUtil:splitAttrReason(reason)
    local value = reason

    local type = nil
    local typeTwo = nil
    local typeThree = nil
    local typeFour = nil

    type = bit.band(value,255)

    value = bit.rshift(value,8)
    typeTwo = bit.band(value,255)
    typeTwo = self:splitPositionForValue(typeTwo)
    
    value = bit.rshift(value,8)
    typeThree = bit.band(value,255)

    value = bit.rshift(value,8)
    typeFour = bit.band(value,255)

    return type,typeTwo,typeThree,typeFour
end

--[[
    组合属性改变原因
    type:
    typeTwo:
    typeThree:
    typeFour:

    返回值：为四个参数根据位运算得到的值
]]
function ToolsUtil:combinationReason(type,typeTwo,typeThree,typeFour)
    local value = 0

    if type then
        value = type
    end

    if typeTwo then
        value = value + bit.lshift(typeTwo,8)
    end

    if typeThree then
        value = value + bit.lshift(typeThree,16)
    end

    if typeFour then
        value = value + bit.lshift(typeFour,24)
    end

    return value
end

--isNotPo == true  表示不执行 math.pow
function ToolsUtil:splitFunctionType(extendValue, isNotPow)
    local functionTypeArr = {}
    local nowNumber = 0
    for i=1,64,1 do
        local type = extendValue % 2  
        extendValue = math.floor(extendValue/2)  
        if(nowNumber == 0) then 
            nowNumber = 1
        else  
            nowNumber = nowNumber * 2
        end
        if(type==1) then
            if isNotPow then
                table.insert(functionTypeArr, i)
            else
                table.insert(functionTypeArr, nowNumber)
            end
        end
        if(extendValue == 0) then
            break
        end
    end

    return functionTypeArr
end

-- 按位拆分字段，{key:key,key2:key2}
function ToolsUtil:splitPositionForValue(value)
    local positionArr = {}
    for i=1,32,1 do
        local type = bit.band(value,1)
        value = bit.rshift(value,1)
        if(type==1) then
            local data = math.pow(2, i-1)
            positionArr[data] = data
            -- table.insert(positionArr,math.pow(2, i-1))
        end
        if(value == 0) then
            break
        end
    end

    return positionArr
end

--根据属性类型获取相应名字
function ToolsUtil:getNameByAttrType(attrType)
    return ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrType])
end

-- 根据属性类型计算属性显示值
function ToolsUtil:calculationAttrShowValue(attrType, value)
    local nowValue = value
    local valueType = PublicDefine.VALUE_TYPE.Value
    if PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "dodge" then 
        nowValue = string.format("%.2f%%", nowValue / tonumber(ConfigManager:getGeneralForKey("dodgeParameter"))*100)
        valueType = PublicDefine.VALUE_TYPE.Rate
    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "critical" then 
        nowValue = string.format("%.2f%%", nowValue / tonumber(ConfigManager:getGeneralForKey("criticalParameter"))*100)
        valueType = PublicDefine.VALUE_TYPE.Rate
    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "physicPenetrate" then 
        nowValue = string.format("%.2f%%", nowValue / tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter"))*100)
        valueType = PublicDefine.VALUE_TYPE.Rate
    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "magicPenetrate" then 
        nowValue = string.format("%.2f%%", nowValue / tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter"))*100)
        valueType = PublicDefine.VALUE_TYPE.Rate
    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "block" then 
        nowValue = string.format("%.2f%%", nowValue / tonumber(ConfigManager:getGeneralForKey("blockParameter"))*100)
        valueType = PublicDefine.VALUE_TYPE.Rate
    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "HPRecoverRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "MPRecoverRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "MagicDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "MagicReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "PhysicDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "PhysicReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "ElementDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "ElementReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "FireDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "FireReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "WaterDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "WaterReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "WoodDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "WoodReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "LightDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "LightReductionRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "DarkDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "CritDamageRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "DarkReductionRate" or
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "CoinRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "ExpRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "ItemHPRecoverRate" or 
        PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "ItemMPRecoverRate"  then 

        nowValue = string.format("%.2f%%", nowValue / 100)
        valueType = PublicDefine.VALUE_TYPE.Rate

    elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "atkSpd" then 
        nowValue = string.format("%.1f", nowValue / 1000)
        valueType = PublicDefine.VALUE_TYPE.Value
    end 

    -- 测试代码
    -- if(valueType == PublicDefine.VALUE_TYPE.Rate) then 
    --     nowValue = string.format("%d %s", value, nowValue)
    -- end

    return tostring(nowValue), valueType
end

-- 生成脸型编码ID
function ToolsUtil:makeFaceDecodeID(bodyID,hairID, eyeID, mouthID)
    
    return bodyID*1000000 + hairID * 10000 + eyeID * 100 + mouthID
end

-- 拆分脸型编码ID
function ToolsUtil:splitFaceDecodeID(faceDecodeID)
    local skin = math.modf(faceDecodeID/1000000)
    local num = math.modf(faceDecodeID%1000000)
    local hair = math.modf(num/10000)

    num = math.modf(num%10000)
    local eye = math.modf(num/100)

    num = math.modf(num%100)
    local mouth = num

    return skin, hair,eye, mouth
end


function ToolsUtil:getDungeonMaxLevel(maxLevel)
    local score = bit.band(tonumber(maxLevel),65535)

    local level = bit.rshift(maxLevel,16)

    local op1=bit._d2b(score)
    local r={}

    for i=17,32 do
        if op1[i]==1 then
            r[i]=0
        else
            r[i]=1
        end
    end
    return level, bit._b2d(r)
end

--转换时间
function ToolsUtil:getTime(_time)
    local second = _time%60
    local min = _time/60%60
    local hour = math.floor(_time/60/60)

    if hour == 0 then
        return string.format("%02d:%02d",min,second)
    else
        return string.format("%d:%02d:%02d",hour,min,second)
    end
end

function ToolsUtil:getCountData(seconds)
    local second = seconds%60
    local min = seconds/60%60
    local hour = math.floor(seconds/3600)

    if hour > 0 then
        if(min >0) then
            hour = hour + 1
        end

        if(hour >= 24) then
            local day = math.modf(hour/24)
            local nowHour = hour - day * 24
            if(nowHour == 0) then
                return string.format("%d%s",day, LanguageManager:getInstance():getLocalString(1111036))
            else 
                return string.format("%d%s %d%s",day, LanguageManager:getInstance():getLocalString(1111036), nowHour, LanguageManager:getInstance():getLocalString(1110163))
            end
        else 
            return string.format("%d%s", hour, LanguageManager:getInstance():getLocalString(1110163))
        end
    else
        if(second >0) then
            min = min + 1
        end
        if(min == 60) then
            return string.format("%d%s", 1, LanguageManager:getInstance():getLocalString(1110163))
        else
            return string.format("%d%s", min, LanguageManager:getInstance():getLocalString(1110164))
        end
    end
end

function ToolsUtil:getFullTime(seconds)
    local second = math.floor(seconds%60)
    local min = math.floor(seconds/60%60)
    local hour = math.floor(seconds/3600)
    -- print("ToolsUtil:getFullTime=",seconds, second, min, hour)

    if hour > 0 then
        if(min >0) then
            hour = hour + 1
        end

        if(hour >= 24) then
            local day = math.modf(hour/24)
            local nowHour = hour - day * 24
            if(nowHour == 0) then
                return string.format("%d%s",day, LanguageManager:getInstance():getLocalString(1111036))
            else 
                return string.format("%d%s %d%s",day, LanguageManager:getInstance():getLocalString(1111036), nowHour, LanguageManager:getInstance():getLocalString(1110163))
            end
        else 
            return string.format("%d%s", hour, LanguageManager:getInstance():getLocalString(1110163))
        end
    else
        if(min > 0) then
            if(second == 0) then 
                return string.format("%d%s", min, LanguageManager:getInstance():getLocalString(1110164))
            else 
                return string.format("%d%s%d%s", min, LanguageManager:getInstance():getLocalString(1110164), second, LanguageManager:getInstance():getLocalString(1111475))
            end
        else
            return string.format("%d%s", second, LanguageManager:getInstance():getLocalString(1111475))
        end
    end
end

--获取公会科技名称文字
function ToolsUtil:getGuildTechText(guildTechID)
    local guildTechConfig = ConfigManager:getGuildTechForID(guildTechID)
    if(guildTechConfig) then 
    -- local data = {UI.TEXT_110061,UI.TEXT_110062,UI.TEXT_110063}
        return guildTechConfig.name
    else
        return "" 
    end
end

function ToolsUtil:httpGetMaskword()

    -- print("httpGetMaskword   start")
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()

    if target == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
        return nil
    end

    local getMeaninglessMaskword = function()
        local url = "https://ltdl.leiting.com/public/se_nonsense.txt"
        local xhr = cc.XMLHttpRequest:new()
        xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
        xhr:open("GET", url)
        local function onCheckWord()
            print("xhr ===== ",xhr.readyState,xhr.status)
            if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
                
                --使用携程
                local co = coroutine.create(function ()
                    local data = Base64Decode(xhr.response)

                    local wordList = string.split(data, "\n")
                    ToolsUtil.meaninglessStr = {}
                    for k,v in ipairs(wordList) do
                        ToolsUtil.meaninglessStr[k] = {ID = k,  value = v}
                    end
                    ToolsUtil.meaninglessStr.size = #ToolsUtil.meaninglessStr
                    -- print("协程2 执行完毕")
                end)
                coroutine.resume(co)
                
            else
                print("httpGetMaskword error")
            end
        end
        xhr:registerScriptHandler(onCheckWord)
        xhr:send()
    end


    local url = "https://ltdl.leiting.com/public/se_sensitive.txt"

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", url)
    local function onCheckWord()
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            
            ToolsUtil.maskword = {}
            ToolsUtil.meaninglessStr = {}
            getMeaninglessMaskword()

            --[[
                由于符串太长. 导致Base64解密卡主线程.  思路是使用携程来解决这个问题:
                1.将字符流以4的倍数拆分为N份,这里拆分为10份. 通过10次计算分摊压力
                2.每份字符串解析后拼接字符串,在解析最后一份字符串时处理最终逻辑
            ]]
            local fIndex = 100
            local stringLen = #xhr.response
            local preIndex = math.floor(stringLen / 4 / fIndex)
            local localIndex = 1
            local fStr = ""
            local localIndexTable = {}
            local pIndexTable = {}
            
            for i = 1,fIndex do
                localIndexTable[i] = localIndex + (i-1) * preIndex * 4
                pIndexTable[i] = localIndexTable[i] + preIndex * 4 - 1
                if i == fIndex then
                    pIndexTable[i] = stringLen
                end
            end

            local co = coroutine.create(function ()
                
                for i = 1,fIndex - 1 do
                    local lStr = string.sub(xhr.response,localIndexTable[i],pIndexTable[i])
                    local data = Base64Decode(lStr)
                    fStr = fStr .. data

                    coroutine.yield()

                    if i == fIndex - 1 then
                        --最终字符串
                        local lastStr = string.sub(xhr.response,localIndexTable[i+1],pIndexTable[i+1])
                        local lastData = Base64Decode(lastStr)
                        fStr = fStr .. lastData

                        local wordList = string.split(fStr, "\n")

                        for k,v in ipairs(wordList) do
                            ToolsUtil.maskword[k] = {ID = k,  value = v}
                        end
                        ToolsUtil.maskword.size = #ToolsUtil.maskword

                        -- -- test 加入一个提示tips  方便QA测试, 正式环境屏蔽
                        -- UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK("敏感字库拉取完成")
                    end
                end
            end)

            for i = 1,fIndex do
                coroutine.resume(co)
            end

            
        else
            print("httpGetMaskword error")
        end
    end
    xhr:registerScriptHandler(onCheckWord)
    xhr:send()
end

--xml 格式关键字屏蔽
function ToolsUtil:checkMaskword(str)
    local maskWords = nil
    if (ToolsUtil.maskword and #ToolsUtil.maskword > 0) then
        maskWords = ToolsUtil.maskword
        -- print("maskWords size ====== ", #maskWords, maskWords[1].value)
    else
        maskWords = require("profiles/dataProfile/ProfileClientMaskedWord")
    end
    


    local strTemp = string.trim(str)
    -- add by zp 这里只有大陆版本才处理去掉空格来比对。
    local wasCN = false
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
        wasCN = true
    end
    if (wasCN) then
        strTemp = string.upper(strTemp)
        strTemp = string.gsub(strTemp," ","" )
        strTemp = string.gsub(strTemp,"&","" )

        if (#ToolsUtil.meaninglessStr > 0) then
            for k,v in ipairs(ToolsUtil.meaninglessStr) do
                
                local maskWord = string.gsub(v.value, "^[%s]*(.-)[%s]*$", "%1")--v.value
                if maskWord == "^" or maskWord == "~" or maskWord == "%" or maskWord == "(" or maskWord == ")"  or maskWord == "["  or maskWord == "]"
                    or maskWord == "$" or maskWord == "+" or maskWord == "." or maskWord == "?"  or maskWord == "\\" or maskWord == "{" or maskWord == "|" then
                    maskWord = "%"..maskWord
                end
                strTemp = string.gsub(strTemp,maskWord,"" )
            end
        end

    end
    -- local length = string.len(strTemp)
    local mark = false
    while true do
        for i = 1, maskWords.size do
            local maskWord = string.trim(maskWords[i].value)
            -- if maskWord == "^" or maskWord == "~" or maskWord == "%" or maskWord == "(" or maskWord == ")"  or maskWord == "["  or maskWord == "]"
            --  or maskWord == "$" or maskWord == "+" or maskWord == "." or maskWord == "?"  or maskWord == "\\" or maskWord == "{" or maskWord == "|" then
            --     maskWord = "%"..maskWord
            -- end
            -- print("maskWord ==123123= ",maskWord)
            if  maskWord ~= nil and maskWord ~= "" then
                local replaceStr = maskWords[i].rs
                if(replaceStr == nil) then
                    replaceStr = self:getReplaceWord(maskWord)
                    maskWords[i].rs = replaceStr
                end
                local num = 0
                -- print("  ---  old "..strTemp)
                if (wasCN) then
                    strTemp,num = string.gsub(strTemp, string.upper(maskWord), replaceStr)
                else
                    strTemp,num = string.gsub(strTemp, maskWord, replaceStr)
                end
                if num ~= 0 then
                    print("  ---  maskWord ="..maskWord.."  and i = "..i)
                    mark = true
                end
                -- print("  ---  new "..strTemp)
            end
        end
        break
    end

    -- print("str mark ===== ",str,strTemp,mark)
    if mark then
        return strTemp, mark
    else
        return str, mark
    end
end

function ToolsUtil:roleNameFilter(name)
    name = string.gsub(name," ","" )
    name = string.gsub(name,"[~!@#$%%^&*/\\_]","")
    return name
end

function ToolsUtil:getReplaceWord(Maskword)
    local number = self:getStrWidth(Maskword, 1)
    number = math.floor(number)
    if number < 1 then
        number = 1
    end
    -- print("---------mumber = "..number)
    local replaceStr = ""
    for k = 1, number do
        replaceStr = replaceStr.."*"
    end
    return replaceStr
end

function ToolsUtil:replaceShowNickNameStr(str)
    local nowStr = self:replaceNameStr(str)
    if AvalonUtil:isUpLimiteStr(nowStr, 145, 18) then
        nowStr = AvalonUtil:getSubNameStrByLabel(nowStr, 145, 18)
    end

    return nowStr
end

-- 替换名字的空格，只适用于玩家名字或工会名字等
function ToolsUtil:replaceNameStr(str)
    if(str and type(str) == "string") then 
        -- 替换多个空格
        local strlength = string.len(str)
        if(strlength < 100) then 
            local replaceNum = 0
            for i=1,strlength,1 do 
                str,replaceNum = string.gsub(str, "  ", " ")
                if(replaceNum <=0) then 
                    break
                end
            end
        else
            str = string.gsub(str, " ", "")
        end 
        -- 替换换行符
        str = self:filter_spec_chars(str)
        -- 替换前后空格
        str = string.gsub(str, "^%s*(.-)%s*$", "%1")

        return str
    end

    return ""
end 

function ToolsUtil:filter_spec_chars(s)
	if(not s) then
		return ""
    end
    local newStr = s
    local ss = {}
    xpcall(function()
        local k = 1
        while true do
            if k > #s then break end
            local c = string.byte(s,k)
            if not c then break end
            if c<192 then
                if (c>=32) then
                    table.insert(ss, string.char(c))
                end
                k = k + 1
            elseif c<224 then
                table.insert(ss, string.char(c,string.byte(s,k+1)))
                k = k + 2
            elseif c<240 then
                -- if c>=228 and c<=233 then
                --     local c1 = string.byte(s,k+1)
                --     local c2 = string.byte(s,k+2)
                --     if c1 and c2 then
                --         local a1,a2,a3,a4 = 128,191,128,191
                --         if c == 228 then a1 = 184
                --         elseif c == 233 then a2,a4 = 190,c1 ~= 190 and 191 or 165
                --         end
                --         if c1>=a1 and c1<=a2 and c2>=a3 and c2<=a4 then
                --             table.insert(ss, string.char(c,c1,c2))
                --         end
                --     end
                -- end
                table.insert(ss, string.char(c,string.byte(s,k+1),string.byte(s,k+2)))
                k = k + 3
            elseif c<248 then
                table.insert(ss, string.char(c,string.byte(s,k+1),string.byte(s,k+2),string.byte(s,k+3)))
                k = k + 4
            elseif c<252 then
                table.insert(ss, string.char(c,string.byte(s,k+1),string.byte(s,k+2),string.byte(s,k+3),string.byte(s,k+4)))
                k = k + 5
            elseif c<254 then
                table.insert(ss, string.char(c,string.byte(s,k+1),string.byte(s,k+2),string.byte(s,k+3),string.byte(s,k+4),string.byte(s,k+5)))
                k = k + 6
            end
        end

        newStr = table.concat(ss)
    end, 
    function(e) 
        newStr = table.concat(ss)
    end, 1)

    return newStr
end

-- 计算怪物类型
function ToolsUtil:calculationMonsterType(monsterID)
    if monsterID >= 51000000 and monsterID < 52000000 then
        typeNum = monsterID / 100000;
        typeNum = typeNum % 10
        typeNum, _ = math.modf(typeNum % 10)
    else
        local a,yu = math.modf(monsterID / 1000)
        typeNum = math.modf(yu * 10 / 1)
    end
    -- local a,yu = math.modf(monsterID / 1000)
    -- typeNum = math.modf(yu * 10 / 1)
    if(typeNum == 1) then
        return PublicDefine.MonsterType.Normal
    elseif typeNum == 2 then
        return PublicDefine.MonsterType.LittleBoss
    elseif typeNum == 3 then
        return PublicDefine.MonsterType.Boss
    else
        -- print("MonsterData:getMonsterType ",typeNum)
        assert(false, string.format("MonsterData:getMonsterType no handle typeNum=%d", typeNum))
    end
    return PublicDefine.MonsterType.Normal
end

function ToolsUtil:getHeroAtlas()
    -- if(AvalonUtil.getGlMaxTextureSize() < 4096) then 
    --     return "role_hero_old.atlas"
    -- else
        return "role_hero.atlas"
    -- end
end

function ToolsUtil:getStrWidth(str, fontSize)
    -- print("--------ChatManager:getStrWidth")
    local subStr = ""
    local width = 0
    local lenInByte =string.len(str)
    local i = 1
    while true do
        if i <= lenInByte then
            local byteCount = AvalonUtil:getCharByteCount(str, i)
            if byteCount == 1 then
                width = width + fontSize * 0.6
            else
                width = width + fontSize
            end
            i = i + byteCount
        else
            break
        end
    end
    return width
end

function ToolsUtil:getDiffcultyStr(diffculty)
    local diffcultyStr = ""

    if(diffculty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1) then 
        diffcultyStr = LanguageManager:getInstance():getLocalString(1110032)
    elseif (diffculty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2) then 
        diffcultyStr = LanguageManager:getInstance():getLocalString(1110033)
    elseif (diffculty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3) then 
        diffcultyStr = LanguageManager:getInstance():getLocalString(1110034)
    end

    return diffcultyStr
end

function ToolsUtil:getGoodsRareStr(goodsRare)
    local typeString = LanguageManager:getInstance():getLocalString(1111960) --"白色"
    if (goodsRare == PublicDefine.GOODS_RARE.RARE_WHITE_1) then
        -- typeString = LanguageManager:getInstance():getLocalString(1111960) --"白色"
    elseif (goodsRare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
        typeString = LanguageManager:getInstance():getLocalString(1111961) --"蓝色"
    elseif (goodsRare == PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then
        typeString = LanguageManager:getInstance():getLocalString(1111962) --"金色"
    elseif (goodsRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
        typeString = LanguageManager:getInstance():getLocalString(1111963) --"暗金"
    elseif (goodsRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5) then
        typeString = LanguageManager:getInstance():getLocalString(1111964) --"套装"
    elseif (goodsRare == PublicDefine.GOODS_RARE.RARE_DARKRED) then
        typeString = LanguageManager:getInstance():getLocalString(1113941) --"传说"
    end

    return typeString
end

function ToolsUtil:getModeStr(caveMode) 
    local modeStr = ""
    if(caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL) then
        modeStr = LanguageManager:getInstance():getLocalString(1110045)
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON) then
        modeStr = LanguageManager:getInstance():getLocalString(1110531)
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then
        modeStr = LanguageManager:getInstance():getLocalString(1111320)
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DREAM) then
        modeStr = LanguageManager:getInstance():getLocalString(1111724)
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS) then
        modeStr = LanguageManager:getInstance():getLocalString(1111724)
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_GUILD_BOSS) then
        modeStr = UI.TEXT_1212704
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then
        modeStr = UI.TEXT_1212801
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then
        modeStr = UI.TEXT_1212803  
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO) then
        modeStr = UI.TEXT_1325500  
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS) then
        modeStr = UI.TEXT_1328014
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then
        modeStr = UI.TEXT_222100
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_VIKING) then
        modeStr = UI.TEXT_223800
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then
        modeStr = UI.TEXT_224400
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
        modeStr = UI.TEXT_224401
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT) then
        modeStr = UI.TEXT_224800
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then
        modeStr = UI.TEXT_225000
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_EXP) then
        modeStr = UI.TEXT_224800
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS) then
        modeStr = UI.TEXT_226500
    end
    return modeStr
end

-- 获取下一个模式,如果不是在主线里面就会返回nil,
function ToolsUtil:getNextCaveMode(caveMode)
    if(caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL) then
        return PublicDefine.CAVE_MODE.MODE_DESERT_EYES
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then
        return PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then
        return PublicDefine.CAVE_MODE.MODE_INFERNO
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO) then
        return PublicDefine.CAVE_MODE.MODE_VOID_RIFT
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then
        return PublicDefine.CAVE_MODE.MODE_DESERT_EYES
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then
        return PublicDefine.CAVE_MODE.MODE_VIKING
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_VIKING) then
        return PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then
        return PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
        return PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then
        return PublicDefine.CAVE_MODE.MODE_CHAOS
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS) then
        return PublicDefine.CAVE_MODE.MODE_CHAOS
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_EXP) then
        return PublicDefine.CAVE_MODE.MODE_EXP
    end

    return nil
end

-- 获取最大适配缩放比例
function ToolsUtil:getAdaptationMaxScaleForBg(bgWidth, bgHeight)
    bgWidth = bgWidth or CONFIG_SCREEN_WIDTH
    bgHeight = bgHeight or CONFIG_SCREEN_HEIGHT

    local framesize = cc.Director:getInstance():getWinSize()
    local autoscale = "FIXED_WIDTH"

    if framesize.width / framesize.height >= bgWidth / bgHeight then
        autoscale = "FIXED_WIDTH"
    else
        autoscale = "FIXED_HEIGHT"
    end
    local scale = 1
    if autoscale == "FIXED_WIDTH" then
        scale = framesize.width / bgWidth
        -- print("缩放比例  ",scale ,"裁剪 ",framesize.height - framesize.height * scale)
    elseif autoscale == "FIXED_HEIGHT" then
        scale = framesize.height / bgHeight
        -- print("缩放比例  ",scale ,"裁剪 ",framesize.width - framesize.width * scale)
    end

    return scale
end

-- 获取最大适配缩放比例
function ToolsUtil:getAdaptationMaxScale()
    local framesize = cc.Director:getInstance():getWinSize()
    local autoscale = "FIXED_WIDTH"

    if framesize.width / framesize.height >= CONFIG_SCREEN_WIDTH / CONFIG_SCREEN_HEIGHT then
        autoscale = "FIXED_WIDTH"
    else
        autoscale = "FIXED_HEIGHT"
    end
    local scale = 1
    if autoscale == "FIXED_WIDTH" then
        scale = framesize.width / CONFIG_SCREEN_WIDTH
        print("缩放比例  ",scale ,"裁剪 ",framesize.height - framesize.height * scale)

    elseif autoscale == "FIXED_HEIGHT" then
        scale = framesize.height / CONFIG_SCREEN_HEIGHT
        print("缩放比例  ",scale ,"裁剪 ",framesize.width - framesize.width * scale)
    end

    return scale
end

-- 获取最小适配缩放比例
function ToolsUtil:getAdaptationMinScale()
    local framesize = cc.Director:getInstance():getWinSize()
    local autoscale = "FIXED_WIDTH"

    if framesize.width / framesize.height >= CONFIG_SCREEN_WIDTH / CONFIG_SCREEN_HEIGHT then
        autoscale = "FIXED_HEIGHT"
    else
        autoscale = "FIXED_WIDTH"
    end
    local scale = 1
    if autoscale == "FIXED_WIDTH" then
        scale = framesize.width / CONFIG_SCREEN_WIDTH
        print("缩放比例  ",scale ,"裁剪 ",framesize.height - framesize.height * scale)

    elseif autoscale == "FIXED_HEIGHT" then
        scale = framesize.height / CONFIG_SCREEN_HEIGHT
        print("缩放比例  ",scale ,"裁剪 ",framesize.width - framesize.width * scale)
    end

    return scale
end

function ToolsUtil:attrNameToLanguageString(attrName)

    local languageID = 0
    if(attrName) then
        if(attrName == "atkMin") then 
            languageID = 1110066
        elseif (attrName == "atkSpd") then
            languageID = 1110067
        elseif (attrName == "atkMax") then
            languageID = 1110068
        elseif (attrName == "magic") then
            languageID = 1110069
        elseif (attrName == "physicDef") then
            languageID = 1110070
        elseif (attrName == "magicDef") then
            languageID = 1110071
        elseif (attrName == "hp") then
            languageID = 1110072
        elseif (attrName == "atk") then
            languageID = 1110141
        elseif (attrName == "blockValue") then
            languageID = 1110073
        elseif (attrName == "block") then
            languageID = 1110074
        elseif (attrName == "mp") then
            languageID = 1110075
        elseif (attrName == "physicPenetrate") then
            languageID = 1110076
        elseif (attrName == "magicPenetrate") then
            languageID = 1110077
        elseif (attrName == "critical") then
            languageID = 1110078
        elseif (attrName == "dodge") then
            languageID = 1110079
        elseif (attrName == "atkFire") then
            languageID = 1110080
        elseif (attrName == "atkWater") then
            languageID = 1110081
        elseif (attrName == "atkWood") then
            languageID = 1110082
        elseif (attrName == "atkLight") then
            languageID = 1110083
        elseif (attrName == "atkDark") then
            languageID = 1110084
        elseif (attrName == "defFire") then
            languageID = 1110085
        elseif (attrName == "defWater") then
            languageID = 1110086
        elseif (attrName == "defWood") then
            languageID = 1110087
        elseif (attrName == "defLight") then
            languageID = 1110088
        elseif (attrName == "defDark") then
            languageID = 1110089
        elseif (attrName == "luck") then
            languageID = 1110090
        elseif (attrName == "weightCapacity") then
            languageID = 1110091
        elseif (attrName == "weight") then
            languageID = 1110092
        elseif (attrName == "CritDamageRate") then
            languageID = 1110093
        elseif (attrName == "MagicDamageRate") then
            languageID = 1110094
        elseif (attrName == "magicDefRate") then
            languageID = 1110095
        elseif (attrName == "PhysicDamageRate") then
            languageID = 1110096
        elseif (attrName == "physicDefRate") then
            languageID = 1110097
        elseif (attrName == "ElementDamageRate") then
            languageID = 1110098
        elseif (attrName == "elementDefRate") then
            languageID = 1110099
        elseif (attrName == "HPRecoverRate") then
            languageID = 1110100
        elseif (attrName == "FireDamageRate") then
            languageID = 1110101
        elseif (attrName == "fireDefRate") then
            languageID = 1110102
        elseif (attrName == "WaterDamageRate") then
            languageID = 1110103
        elseif (attrName == "waterDefRate") then
            languageID = 1110104
        elseif (attrName == "WoodDamageRate") then
            languageID = 1110105
        elseif (attrName == "woodDefRate") then
            languageID = 1110106
        elseif (attrName == "LightDamageRate") then
            languageID = 1110107
        elseif (attrName == "lightDefRate") then
            languageID = 1110108
        elseif (attrName == "DarkDamageRate") then
            languageID = 1110109
        elseif (attrName == "darDefRate") then
            languageID = 1110110
        elseif (attrName == "ExpRate") then
            languageID = 1110111
        elseif (attrName == "CoinRate") then
            languageID = 1110112
        elseif (attrName == "secKillRate") then
            languageID = 1110113
        elseif (attrName == "healRate") then
            languageID = 1110114
        elseif (attrName == "spdRate") then
            languageID = 1110115
        elseif (attrName == "trueDamageRate") then
            languageID = 1110116
        elseif (attrName == "magicAtkMin") then
            languageID = 1110117
        elseif (attrName == "magicAtkMax") then
            languageID = 1110118
        elseif (attrName == "dropCoin") then
            languageID = 1110119
        elseif (attrName == "dropExp") then
            languageID = 1110120
        elseif (attrName == "weaknessType") then
            languageID = 1110121
        elseif (attrName == "curHp") then
            languageID = 1110122
        elseif (attrName == "curMp") then
            languageID = 1110123
        elseif (attrName == "totalSkillPoints") then
            languageID = 1110124
        elseif (attrName == "goodsRare") then
            languageID = 1110125
        elseif (attrName == "buyPrice") then
            languageID  = 1110126
        elseif (attrName == "sellPrice") then
            languageID = 1110127
        elseif (attrName == "equipRequireLV") then
            languageID = 1110128
        elseif (attrName == "roleLV") then
            languageID = 1110129
        elseif (attrName == "occupation") then
            languageID = 1110130
        elseif (attrName == "moveSpeed") then
            languageID = 1110131
        elseif (attrName == "expToNextLV") then
            languageID = 1110132
        elseif (attrName == "sex") then
            languageID = 1110133
        elseif (attrName == "MPRecoverRate") then
            languageID = 1110134
        elseif (attrName == "nickName") then
            languageID = 1110135
        elseif (attrName == "curExp") then
            languageID = 1110136
        elseif (attrName == "curSkillPoints") then
            languageID = 1110137
        elseif (attrName == "curCoin") then
            languageID = 1110138
        elseif (attrName == "equipLV") then
            languageID = 1110139
        elseif (attrName == "combatScore") then
            languageID = 1110140
        elseif (attrName == "guildMedal") then
            languageID = 1110623
        elseif (attrName == "guildContrib") then
            languageID = 1110622
        elseif (attrName == "achievementPoint") then
            languageID = 1110678
        elseif (attrName == "MagicReductionRate") then
            languageID = 1110095
        elseif (attrName == "PhysicReductionRate") then
            languageID = 1110097
        elseif (attrName == "ElementReductionRate") then
            languageID = 1110099
        elseif (attrName == "FireReductionRate") then
            languageID = 1110102
        elseif (attrName == "WoodReductionRate") then
            languageID = 1110106
        elseif (attrName == "LightReductionRate") then
            languageID = 1110108
        elseif (attrName == "DarkReductionRate") then
            languageID = 1110110
        elseif (attrName == "WaterReductionRate") then
            languageID = 1110104
        elseif (attrName == "ItemHPRecoverRate") then
            languageID = 1111248
        elseif (attrName == "ItemMPRecoverRate") then
            languageID = 1111249
        elseif (attrName == "BeCriticalRate") then
            languageID = 1111250
        elseif (attrName == "HitRate") then
            languageID = 1111251
        elseif (attrName == "strengthenExtraRate") then
            languageID = 1111252
        elseif (attrName == "goldenGoodsDiscountRate") then
            languageID = 1111253
        elseif (attrName == "GeneralAtkDamageRate") then
            languageID = 1111254
        elseif (attrName == "GeneralAtkHPRecoverRate") then
            languageID = 1111255
        else 
            -- assert(false, string.format("have no found attrName=%s  handle.", attrName))
        end
    end

    return LanguageManager:getInstance():getLocalString(languageID, true)
end


function ToolsUtil:getModeName(modeType)
    local languageID = 0
    if modeType == PublicDefine.CAVE_MODE.MODE_NORMAL then
        languageID = 1110499
    elseif modeType == PublicDefine.CAVE_MODE.MODE_DUNGEON then
        languageID = 1110500
    elseif modeType == PublicDefine.CAVE_MODE.MODE_DREAM then
        languageID = 1111723
    elseif modeType == PublicDefine.CAVE_MODE.MODE_HERO then
        languageID = 1111320
    elseif (modeType == PublicDefine.CAVE_MODE.MODE_WORLD_BOSS) then
        languageID = UI.TEXT_1212703
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then
        languageID = UI.TEXT_1212801
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then
        languageID = UI.TEXT_1212803
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_INFERNO) then
        languageID = UI.TEXT_1325500
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_GHOST_ABYSS) then
        modeStr = UI.TEXT_1328014  
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then
        languageID = UI.TEXT_222100
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_VIKING) then
        languageID = UI.TEXT_223800
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then
        languageID = UI.TEXT_224400
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
        languageID = UI.TEXT_224401
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT) then
        modeStr = UI.TEXT_224800
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then
        languageID = UI.TEXT_225000
    elseif (modeType == PublicDefine.CAVE_MODE.MODE_EXP) then
        modeStr = UI.TEXT_224800
    elseif(modeType == PublicDefine.CAVE_MODE.MODE_CHAOS) then
        languageID = UI.TEXT_226500
    else
        return ""
    end
    return LanguageManager:getInstance():getLocalString(languageID)
end

function ToolsUtil:getDiffcultName(diffcultType)
    local languageID = 0
    if diffcultType == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 then
        languageID = 1110032
    elseif diffcultType == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
        languageID = 1112451
    elseif diffcultType == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then
        languageID = 1110034
    else
        return ""
    end
    return LanguageManager:getInstance():getLocalString(languageID)
end

function ToolsUtil:playNewAction(compment, scale, right, up, zorder)
    if(tolua.isnull(compment)) then 
        return
    end
    local child = compment:getChildByName("NEW_ACTION")
    if child ~= nil then
        return
    end
    zorder = zorder or 110
    right = right or 0
    up = up or 0
    scale = scale or 1
    local spineName = "effect_ui_common_information_unlocknew"
    local action = UI.Animation:create()
    action:init(spineName..".json", spineName..".atlas")
    action:setScale(scale)
    action:rightUp(right, up)
    action:setAnimation("idle2",true)
    compment:addChild(action, zorder)
    action:setName("NEW_ACTION")
    return action
end

function ToolsUtil:playNewActionInRedPoint(compment, scale, right, up, zorder, redPointID)
    if(tolua.isnull(compment)) then 
        return
    end
    local child = compment:getChildByName("NEW_ACTION")
    if child ~= nil then
        return
    end
    print("ToolsUtil:playNewActionInRedPoint", redPointID)
    zorder = zorder or 110
    right = right or 0
    up = up or 0
    scale = scale or 1
    local spineName = "effect_ui_common_information_unlocknew"
    local action = UI.RedPointLayer:create()
    action:init(Game.RED_POINT_TYPE.NEW_ANIMATION, redPointID)
    action:setScale(scale)
    action:rightUp(right, up)
    compment:addChild(action, zorder)
    action:setName("NEW_ACTION")

    return action
end

function ToolsUtil:getPageSceneID(monsterData) 
    if(monsterData) then 
        if(monsterData.scenesID < 6 or monsterData.scenesID >=8) then 
            return monsterData.scenesID
        else 
            return monsterData.scenesID + 1
        end
    end 

    return 1
end


function ToolsUtil:playUnlockAction(compment, callback, isLock, right, up, zorder, scale)
    --  print("---ToolsUtil:playUnlockAction-----callback = ", compment, callback, isLock, right, up, zorder, scale)
    if(tolua.isnull(compment)) then 
        return
    end
    local child = compment:getChildByName("LOCK_ACTION")
    if child ~= nil then
        return
    end
    zorder = zorder or 110
    right = right or 0
    up = up or 0
    scale = scale or 1
    local spineName = "effect_ui_general_lock"
    local action = UI.Animation:create()
    action:init(spineName..".json", spineName..".atlas")
    action:setScale(scale)
    action:rightUp(right, up)
    if isLock then
        action:setAnimation("idle",false)
    else
        action:setAnimation("trigger",false)
    end
    compment:addChild(action, zorder)
    action:setName("LOCK_ACTION")

    action:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
        if event.animation == "trigger" and callback then
            callback()
            action:destroy()
        end
    end)
    return action
end

function ToolsUtil:removeNewAction(compment)
    if(tolua.isnull(compment)) then 
        return
    end
    
    local child = compment:getChildByName("NEW_ACTION")
    if child ~= nil then
        compment:removeChildByName("NEW_ACTION")
    end
end

function ToolsUtil:registerMultiTouch(onTouchBegan, onTouchMoved, onTouchEnded, target)
    local beginUseID = nil
    local function onTouchesBegan(touches, event)
        -- beginUseID = nil
        -- print("....multouch registerMultiTouch onTouchesBegan test........", #touches,target.__cname, target._mn)
        local handled = false
        for _id, touch in pairs(touches) do 
            local id = touch:getId()

            if MULTI_TOUCH_CONTROL_ID ~= id then
                if(MULTI_TOUCH_ID_ARR[id] ~= true) then
                    -- print("wwwwwwwwwwwwwwwwwwwww  id=", id)
                    local use = onTouchBegan(touch, event)
                    if(use) then 
                        -- print("wwwwwwwwwwwwwwwwwwwww use id=", id, target.__cname, target._mn)
                        beginUseID = id
                        if target._swallowedTouch then 
                            MULTI_TOUCH_ID_ARR[id] = true
                        end

                        handled = true
                        return
                    end
                end
            end
        end
    end

    local function onTouchesMoved(touches, event)
        if(beginUseID) then
            -- print("....multouch onTouchesMoved test........", touches)
            for _id, touch in pairs(touches) do 
                if touch:getId() == beginUseID then 
                    onTouchMoved(touch, event)
                end
            end
        end
    end

    local function onTouchesEnded(touches, event)
        -- print("....multouch onTouchesEnded test........", touches)
        for _id, touch in pairs(touches) do 
            -- print("wwwwwwwwwwwwwwwwwwwww use end trigger id=", touch:getId())
            if touch:getId() == beginUseID then 
                -- print("wwwwwwwwwwwwwwwwwwwww use end id=", touch:getId())
                onTouchEnded(touch, event)
                beginUseID = nil
                -- MULTI_TOUCH_ID_ARR[touch:getId()] = false
            end
            
            -- 这里处理容错处理
            if(MULTI_TOUCH_CONTROL_ID == touch:getId()) then
                -- print("send message to handle controlpad.", MULTI_TOUCH_CONTROL_ID)
                MULTI_TOUCH_CONTROL_ID = nil
            end

            MULTI_TOUCH_ID_ARR[touch:getId()] = false
        end
    end

    -- 多点触摸
    local tochesListener = cc.EventListenerTouchAllAtOnce:create()
    tochesListener:registerScriptHandler(onTouchesBegan,cc.Handler.EVENT_TOUCHES_BEGAN )
    tochesListener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    tochesListener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
    tochesListener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_CANCELLED )
    local eventDispatcher = target:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(tochesListener, target)

    return tochesListener
end

function ToolsUtil:cardFrame(time)
    cc.Director:getInstance():setAnimationInterval(time)
    local num = 0
    local callBack = function()
        if(num == 1) then
            cc.Director:getInstance():setAnimationInterval(1/60)
            Avalon.Scheduler:unscheduleUpdate(self, callBack)
        end

        num = num + 1
    end
    Avalon.Scheduler:scheduleUpdate(self, callBack)
end

-- 获取属性优先级
function ToolsUtil:getAttrPriority()
    return {"hp","mp","atkMin","atkMax","magic","physicDef","magicDef","block","physicPenetrate",
    "magicPenetrate","critical","dodge","luck","atkFire","atkWater","atkWood","atkLight","atkDark","defFire","defWater","defWood","defLight","defDark"}
end

--[[
    curHp:
    maxHp:
    multiHP:

    return {key:value = index:hp}, index
]]
function ToolsUtil:calculationMulHp(curHp, maxHp, multiHP)
    local mulHpArr = {}
    local nowIndex = 0
    local nowHaveHp = 0
    if(multiHP) then 
        local nowHp = maxHp
        local index = 1
        for i=1, 9999, 1 do 
            if(nowHp <= 0) then 
                break
            end
            local oneHp = 0
            if(index > #multiHP) then
                oneHp = multiHP[#multiHP]
            else
                oneHp = multiHP[index]
            end
            if(oneHp > nowHp) then
                oneHp = nowHp
            end
            table.insert(mulHpArr, oneHp)
            nowHp = nowHp - oneHp
            if(nowIndex == 0) then 
                if(nowHp <= curHp) then
                    nowIndex = index
                    nowHaveHp = curHp - nowHp
                end
            end

            index = index + 1
        end
    end

    return mulHpArr, nowIndex, nowHaveHp
end

function ToolsUtil:getWeakSpriteName(weaknessType)
    if weaknessType == 1 then
        return "symbol_monsterattribute_fire_0.png"
    elseif weaknessType == 2 then
        return "symbol_monsterattribute_water_0.png"
    elseif weaknessType == 3 then
        return "symbol_monsterattribute_wood_0.png"
    elseif weaknessType == 4 then
        return "symbol_monsterattribute_light_0.png"
    elseif weaknessType == 5 then
        return "symbol_monsterattribute_dark_0.png"
    end

    return ""
end

--楼层转换为商店层 1~10 -> 2001  11~20 -> 2002  21~30 -> 2003
function ToolsUtil:getShopLevelForCaveLevel(level)
    -- print("LevelSelectUtil:getBeginShopLevelForCaveLevel  LevelDefine.CAVE_MAX = ", LevelDefine.CAVE_MAX, )
	if level >= PublicDefine.CONST_DEFINITION.CAVE_LEVEL_MIN and level <= PublicDefine.CONST_DEFINITION.CAVE_LEVEL_MAX then
		local levelIndex = math.ceil(level / SHOP_INTERVAL) - 1
		return levelIndex + PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
	elseif level > 2000 then
		return level
	elseif level <= 10 then
		return 2001;
	elseif level >= PublicDefine.CONST_DEFINITION.BOSS_LEVEL_MIN then
		return level
	end

	return -1
end

--商店层转换为楼层 2001 -> 1  2002 -> 11  2003 -> 21
function ToolsUtil:getCaveLevelForShopLevel(level)
	-- print("LevelSelectUtil:getBeginCaveLevelForShopLevel"..level)
	if level >= PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN and level <= PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MAX then
		local levelIndex = level - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
		return levelIndex * SHOP_INTERVAL + 1
	end
	return -1
end

function ToolsUtil:triggerHandleMap8Moon(isBattle, isShow)
    local spineName = "map8_bossfloor_moon"
    local coordX = 14
    local coordY = 9
    local animationNames = {}
    if(isShow) then 
        if(isBattle) then
            animationNames = {{"idle_dead", false}, {"activated", true}}
        else 
            animationNames = {{"recover", false}, {"idle", true}}
        end
    else 
        animationNames = {{"idle_dead", false}}
    end
    -- print("ToolsUtil:triggerHandleMap8Moon", animationNames)
    Avalon.MessageCenter:notice(AvalonMessage.MC_DECORATION_HANDLE, spineName, coordX, coordY, animationNames)
end

function ToolsUtil:triggerHandleMap15Moon(isBattle, isShow)
    local spineName = "map15_bossfloor_moon"
    local coordX = 14
    local coordY = 9
    local animationNames = {}
    if(isShow) then 
        if(isBattle) then
            animationNames = {{"idle_dead", false}, {"activated", true}}
        else 
            animationNames = {{"recover", false}, {"idle", true}}
        end
    else 
        animationNames = {{"idle_dead", false}}
    end
    -- print("ToolsUtil:triggerHandleMap15Moon", animationNames)
    Avalon.MessageCenter:notice(AvalonMessage.MC_DECORATION_HANDLE, spineName, coordX, coordY, animationNames)
end

function ToolsUtil:getExpeditionLevel(caveMode)
    if(caveMode == PublicDefine.CAVE_MODE.MODE_HERO or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then 
        return 2018
    end

    local plotList = ConfigManager:getAllLevelSelectDataByType(caveMode)
    local isLockedLastBtn = false
    local fixPos = {}
    local fixPosTarget = nil
    local diffculty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    -- add by zp  注释掉  CO-10832【探险队】探险队按层开启（客户端）
    -- if(caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then 
    --     diffculty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2
    -- end

    local checkpointData = RoleDataManager:getCheckpointData(caveMode, diffculty)
    local maxNormalLevel = 0
    for  k, v in pairs(plotList) do
        if table.nums(v.includeLevel) > 0 then            
            for k2, v2 in ipairs(v.includeLevel) do
                local haveStep = false
                local shopLevel = ToolsUtil:getShopLevelForCaveLevel(tonumber(v2))
                -- print("cave normal  eee=",shopLevel)
                -- local expeditionConfigData = mvc.expeditionModel:getExpeditionConfigData(caveMode, shopLevel)
                -- if(checkpointData and expeditionConfigData and shopLevel <= checkpointData:getCheckpoint() and (expeditionConfigData.checkpoint <= checkpointData:getCheckpoint() 
                --     or (caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL and expeditionConfigData.checkpoint == -1 and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave))
                --     or (caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES and expeditionConfigData.checkpoint == -1 and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace)))) then
                --     if shopLevel > maxNormalLevel then 
                --         maxNormalLevel = shopLevel
                --     end
                -- end

                local expeditionConfigData = mvc.expeditionModel:getExpeditionConfigData(caveMode, shopLevel)
                -- print("getExpeditionLevel 1=", caveMode, shopLevel)
                if(expeditionConfigData and checkpointData and checkpointData:getCheckpoint() > 0) then
                    -- print("getExpeditionLevel 2=", expeditionConfigData.ID)
                    if shopLevel > maxNormalLevel then 
                        maxNormalLevel = shopLevel
                    end
                end
            end
        end 
    end

    return maxNormalLevel
end

function ToolsUtil:getSenceName(scene)
    if(scene == 1) then 
        return LanguageManager:getInstance():getLocalString(1150002)
    elseif (scene == 2) then 
        return LanguageManager:getInstance():getLocalString(1150003)
    elseif (scene == 3) then 
        return LanguageManager:getInstance():getLocalString(1150004)
    elseif (scene == 4) then 
        return LanguageManager:getInstance():getLocalString(1150005)
    elseif (scene == 5) then 
        return LanguageManager:getInstance():getLocalString(1150006)
    elseif (scene == 6) then 
        return LanguageManager:getInstance():getLocalString(1150032)
    -- elseif (scene == 7) then 
    --     return LanguageManager:getInstance():getLocalString(1150035)
    elseif (scene == 8) then 
        return LanguageManager:getInstance():getLocalString(1150035)
    elseif (scene == 9) then 
        return LanguageManager:getInstance():getLocalString(1150037)
    elseif (scene == 12) then 
        return LanguageManager:getInstance():getLocalString(1038489)
    elseif (scene == 18) then 
        return LanguageManager:getInstance():getLocalString(1038489)
    elseif (scene == 24) then 
        return LanguageManager:getInstance():getLocalString(1150080)
    elseif (scene == 25) then 
        return LanguageManager:getInstance():getLocalString(1150081)
    elseif (scene == 26) then 
        return LanguageManager:getInstance():getLocalString(1150082)
    elseif (scene == 27) then 
        return LanguageManager:getInstance():getLocalString(1150083)
    elseif (scene == 28) then 
        return LanguageManager:getInstance():getLocalString(1150084)
    elseif (scene == 29) then 
        return LanguageManager:getInstance():getLocalString(1150085)
    elseif (scene == 30) then 
        return LanguageManager:getInstance():getLocalString(1150080)
    elseif (scene == 31) then 
        return LanguageManager:getInstance():getLocalString(1150081)
    elseif (scene == 32) then 
        return LanguageManager:getInstance():getLocalString(1150082)
    elseif (scene == 33) then 
        return LanguageManager:getInstance():getLocalString(1150083)
    elseif (scene == 34) then 
        return LanguageManager:getInstance():getLocalString(1150084)
    elseif (scene == 35) then 
        return LanguageManager:getInstance():getLocalString(1150085)
    elseif (scene == 39) then 
        return LanguageManager:getInstance():getLocalString(1150096)
    elseif (scene == 40) then 
        return LanguageManager:getInstance():getLocalString(1150097)
    elseif (scene == 41) then 
        return LanguageManager:getInstance():getLocalString(1150098)
    elseif (scene == 42) then 
        return LanguageManager:getInstance():getLocalString(1150099)
    elseif (scene == 43) then 
        return LanguageManager:getInstance():getLocalString(1150106)
    elseif (scene == 44) then 
        return LanguageManager:getInstance():getLocalString(1150110)
    elseif (scene == 45) then 
        return LanguageManager:getInstance():getLocalString(1150112)
    elseif (scene == 46) then 
        return LanguageManager:getInstance():getLocalString(1150116)
    elseif (scene == 47) then 
        return LanguageManager:getInstance():getLocalString(1150118)
    elseif (scene == 48) then 
        return LanguageManager:getInstance():getLocalString(1150122)
    elseif (scene == 49) then 
        return LanguageManager:getInstance():getLocalString(1150124)
    elseif (scene == 50) then 
        return LanguageManager:getInstance():getLocalString(1150128)
    elseif (scene == 51) then 
        return LanguageManager:getInstance():getLocalString(1150130)
    end 

    return ""
end

-- 获取分解返还金币数值
function ToolsUtil:calculationSellCoin(goodsData)
    
    if(goodsData == nil or goodsData:getType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        if(goodsData) then  
            return goodsData:getSellPrice()
        else 
            return 0
        end
    end
    -- 计算分解返还
    local costs = Config.EquipStrengthenConfig:getEquipStrengthenCost(goodsData:getEquipLV())
    local cost = costs.coinCost or {}
    local sellPrice = goodsData:getBaseSellPrice()
    local backRate = RATIO_NUMBER
    local recovery = ConfigManager:getGeneralForKey("ReturnOnEquipmentRecovery")
    if recovery then 
        backRate = checkint(tonumber(recovery))
    end
    if(backRate > RATIO_NUMBER) then 
        backRate = RATIO_NUMBER
    end
    for i=1, goodsData:getStrengthenLeve(),1 do 
        sellPrice = sellPrice + ToolsUtil:calcalationStrengthCoin(cost, i, goodsData:getGoodsRare())*(backRate/RATIO_NUMBER)
    end

    return sellPrice
end

function ToolsUtil:calcalationStrengthCoin(cost, nextLevel, goodsRare)
    if(cost[nextLevel]) then
        return checkint(cost[nextLevel]) * goodsRare
    else 
        return 0
    end
end

--[[
    这里只处理装备ID
    equipmentIDArr： 装备的ID列表
]]
function ToolsUtil:handleNoMasterEquipmentIDArr(equipmentIDArr)
    if(equipmentIDArr) then 
        local idArr = {}
        for k,equipmentID in ipairs(equipmentIDArr) do 
            local illEquipID = self:getEquipmentIDForIllusionID(equipmentID)
            if(illEquipID) then 
                table.insert(idArr, illEquipID)
            else 
                table.insert(idArr, equipmentID)
            end
        end
    else 
        return {}
    end 
end

--[[
    这里仅仅用于幻化ID到装备ID的转换
    equipmentID 装备的ID
]]
function ToolsUtil:handleNoMasterEquipmentID(equipmentID)
    local illEquipID = self:getEquipmentIDForIllusionID(equipmentID)
    if(illEquipID) then 
        return illEquipID
    end

    return equipmentID
end

--[[
    这里仅仅用于幻化ID转换为其对应幻化的装备ID
]]
function ToolsUtil:getEquipmentIDForIllusionID(illusionID)
    local illusionConfig = ConfigManager:getEquipIllusionByID(illusionID)
    if(illusionConfig) then
        return illusionConfig.position
    end

    return nil
end

function ToolsUtil:getIsShieldPet()
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInHitRat() 
        or SceneManager:getInstance():isInPuzzle()
        or SceneManager:getInstance():isInMaze()
        or SceneManager:getInstance():isInHuLu()
        or SceneManager:getInstance():isInLostRealm()) then 
        return true
    end

    return false
end

function ToolsUtil:getSupportDynamicOrder()
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE  then
        local dynamicOrderVersion = "1.4.0"
        if(AvalonUtil.getMyVersion()>= dynamicOrderVersion)then 
            return true
        end
    else
        local dynamicOrderVersion = "2.4.0"
        if(AvalonUtil.getMyVersion()>= dynamicOrderVersion)then 
            return true
        end
    end

    return false
end

function ToolsUtil:exitApp()
    local SdkBox = require("utils.sdkbox.SdkBox")
    local state = SdkBox:getInstance():getExitGameState()
    -- print("---keyBackUp---GameState = ", state)
    if state == 1 then --直接弹出自己的窗口
        local onlyUseSdkExit = false
        if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL 
            and cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_ANDROID) then 
            if(AvalonUtil.getMyVersion()>= "2.5.1")then 
                onlyUseSdkExit = true
            end
        end
        if onlyUseSdkExit then
            local deviceName = AvalonUtil.getDeviceName()
            if(deviceName and string.find(string.lower(deviceName), "mi")) then
                cc.Director:getInstance():endToLua()
                os.exit()
            else
                cc.Director:getInstance():endToLua()
                SdkBox:getInstance():exit()
            end
        else
            SdkBox:getInstance():exit()
            cc.Director:getInstance():endToLua()
            os.exit()
        end
    else
        SdkBox:getInstance():exit()
    end
end


-- 获取技能的所属角色类型，这里如果需要彻底修改，需要把对应的技能属性改变信息修改到角色对象
function ToolsUtil:getRoleType(checkSkillID, isPetActive)
    local allSkillArr = nil
    if RoleDataManager and MasterDataManager and RoleDataManager:getCaptain() and MasterDataManager:getCaptainPet() then
        allSkillArr = {}
        local captain = RoleDataManager:getCaptain()
        local bagPetData = MasterDataManager:getBagPetById(captain.petInstId)
        local skillArr = bagPetData:getAllSkills()
        if(skillArr) then 
            for k,v in pairs(skillArr) do 
                table.insert(allSkillArr, tonumber(v))
            end
        end

        local giftedSkillID = MasterDataManager:getBagPetById(captain.petInstId):getGiftedSkill()
        if(giftedSkillID) then
            table.insert(allSkillArr, tonumber(giftedSkillID))
        end

        local giftedSkill2ID = MasterDataManager:getBagPetById(captain.petInstId):getGiftedSkill2()
        if(giftedSkill2ID) then
            table.insert(allSkillArr, tonumber(giftedSkill2ID))
        end
    end
    -- print("ToolsUtil:getRoleType", checkSkillID, isPetActive, allSkillArr)
    -- 这里宠物的特质技能以及
    if(allSkillArr) then 
        for k,v in pairs(allSkillArr) do 
            if(tonumber(v) == tonumber(checkSkillID)) then 
                if(isPetActive) then
                    return PublicDefine.EObjectType.Pet
                else
                    return PublicDefine.EObjectType.Null 
                end
            end
        end
    end

    return PublicDefine.EObjectType.Hero
end

-- 判断一个点是否在4个点（仅限凸四边形，凹四边形无法正确判断）的区域内
function ToolsUtil:isPointInRect(x, y, onePoint, twoPoint, threePoint, fourPoint)
    local A = onePoint;
    local B = twoPoint;
    local C = threePoint;
    local D = fourPoint;
    local a = (B.x - A.x)*(y - A.y) - (B.y - A.y)*(x - A.x)
    local b = (C.x - B.x)*(y - B.y) - (C.y - B.y)*(x - B.x)
    local c = (D.x - C.x)*(y - C.y) - (D.y - C.y)*(x - C.x)
    local d = (A.x - D.x)*(y - D.y) - (A.y - D.y)*(x - D.x)
    if((a > 0 and b > 0 and c > 0 and d > 0) or (a < 0 and b < 0 and c < 0 and d < 0)) then
        return true;
    end

    return false; 
end

-- 随机乱序table
function ToolsUtil:tableRandom(randomTable)
    if(randomTable) then
        local tmp, index
        for i=1, #randomTable-1 do
            index = math.random(i, #randomTable)
            if i ~= index then
                tmp = randomTable[index]
                randomTable[index] = randomTable[i]
                randomTable[i] = tmp
            end
        end
    end

    return randomTable
end

-- 处理获得物品展示
function ToolsUtil:showGetGoodsScrollbar(goodsDataArr)
    local showTexts = {}
    for k, v in ipairs(goodsDataArr) do
        local iconName = v:getName()
        local materialNum = v:getNum()
        if showTexts[v:getGoodsID()] == nil then
            local data = {}
            data.iconName = iconName
            data.materialNum = materialNum
            showTexts[v:getGoodsID()] = data
        else
            local data = showTexts[v.materialID]
            data.materialNum = data.materialNum + materialNum
            showTexts[v:getGoodsID()] = data
        end
    end
    for k, v in pairs(showTexts) do
        UI.ScrollBar:createByText(string.format(UI.TEXT_1110401, v.iconName, v.materialNum))
    end
end

-- 雕纹命名
function ToolsUtil:getGlyphsNameByAttr(attrType)
    local glyphsAttrConfig = ConfigManager:getGlyphAttributeByID(attrType)
    if not glyphsAttrConfig then
        glyphsAttrConfig = {}
        glyphsAttrConfig.name = ""
    end
    return glyphsAttrConfig.name and LanguageManager:getInstance():getLocalString(glyphsAttrConfig.name) or ""
end