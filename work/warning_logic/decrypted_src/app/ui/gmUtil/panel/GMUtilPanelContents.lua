
--[[
    测试工具, 内容组件  2017/11/30
        -- 所有GM工具显示内容都在这里
        -- 都是以GM工具中的一行为基础单位来排版的
    by CMonk
]]

local executor = require("app.ui.gmUtil.GMUtilExecutor")
local helper = require("app.ui.gmUtil.GMUtilHelper")
local gmConfig = require("app.ui.gmUtil.GMUtilConfig")

-- 模块初始化 --
---------------------------------------
-- 引用UI命名空间
UI = UI or {}

-- 素子
local GMUtilPanelContents = UI.GMUtilPanelContents or {}
UI.GMUtilPanelContents = GMUtilPanelContents

---------------------------------------
-- eo 模块初始化 --











-- 分隔符
GMUtilPanelContents.seperatorSectionFunc = function ()
    return helper:getSeparatorRow()
end



-- 空格
GMUtilPanelContents.spaceSectionFunc = function ()
    return helper:getAutoLayout(nil, 45)
end










-- 楼层跳转区块 --
GMUtilPanelContents.floorJumpSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("切换楼层"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 楼层输入框
    local lvInput = helper:getInput("输入要前往的楼层", 250, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, lvInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 常用楼层下拉
    local data = {{name = "测试层", id = 50000}}
    local textData = helper:getListOfField(data, "name")
    local mapDropDown = helper:getDropDown("常用楼层▼", 160, textData)
    mapDropDown:setOnSelectionChanged(function(obj, idx) lvInput:setText(data[idx].id) end)
    helper:addSectionLeft(interactiveRow, mapDropDown, 10)


    -- 互动行2
    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10, -1)

    local mapParams = helper:getInput("地图词缀库ID和等级", 250, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow2, mapParams, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local mapParamsNum = helper:getInput("量", 50, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow2, mapParamsNum, 10)

    local mobParams = helper:getInput("怪物词缀库ID和等级", 250, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow2, mobParams, 20)

    local mobParamsNum = helper:getInput("量", 50, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow2, mobParamsNum, 10)

    --跳转按钮
    helper:addSectionRight(interactiveRow, helper:getButton("菠萝菠萝蜜!!", 200, function() 
        -- 参数检查
        if (not helper:checkInWild()) then return end
        local lv = lvInput:getText()
        local mapP = mapParams:getText()
        local mapPN = mapParamsNum:getText()
        local mobP = mobParams:getText()
        local mobPN = mobParamsNum:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (executor:gotoLevel(lv, mapP, mapPN, mobP, mobPN)) then 
            helper:noteLVJ() helper:closeGMUtil(self) else helper:noteUKN() end
        
    end))



    return newRowLayout
end

-- 世界BOSS --
GMUtilPanelContents.worldBossSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("世界BOSS"))

    -- 互动行3
    local interactiveRow3 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow3, 10, -1)

    local sceneIDInput = helper:getInput("场景ID", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow3, sceneIDInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加按钮
    helper:addSectionLeft(interactiveRow3, helper:getButton("worldboss 入口", 250, function() 
        local sceneID = sceneIDInput:getText()
        if (executor:enterWorldBoss(tonumber(sceneID))) then 
            helper:noteDEF()  else helper:noteUKN() end
    end), 20)

    return newRowLayout
end











-- 英雄模式词缀区块 --
GMUtilPanelContents.heroPropRefreshSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("英雄模式词缀"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 楼层输入框
    local lvInput = helper:getInput("地图选择", 250, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, lvInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 常用楼层下拉
    local data = {
        {name = "2001", id = 2001},
        {name = "2004", id = 2004},
        {name = "2007", id = 2007},
        {name = "2010", id = 2010},
        {name = "2013", id = 2013},
    }
    local textData = helper:getListOfField(data, "name")
    local mapDropDown = helper:getDropDown("常用楼层▼", 160, textData)
    mapDropDown:setOnSelectionChanged(function(obj, idx) lvInput:setText(data[idx].id) end)
    helper:addSectionLeft(interactiveRow, mapDropDown, 10)


    -- 互动行2
    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10, -1)

    local mapParam1 = helper:getInput("第一个词缀ID", 250, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow2, mapParam1, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local mapParam2 = helper:getInput("第二个词缀ID", 250, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow2, mapParam2, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local mapParam3 = helper:getInput("第三个词缀ID", 250, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow2, mapParam3, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    --跳转按钮
    helper:addSectionRight(interactiveRow, helper:getButton("英雄词缀大便变(手误)", 320, function() 
        -- 参数检查
        if (not helper:checkInTown()) then return end
        local lv = lvInput:getText()
        local mapParamNum1 = tonumber(mapParam1:getText())
        local mapParamNum2 = tonumber(mapParam2:getText())
        local mapParamNum3 = tonumber(mapParam3:getText())
        if (not lv or lv == "" or (mapParamNum1 == nil and mapParamNum2 == nil and mapParamNum3 == nil)) then helper:noteICO() return end

        local paramArr = {}
        if (mapParamNum1 ~= nil) then table.insert(paramArr, mapParamNum1) end
        if (mapParamNum2 ~= nil) then table.insert(paramArr, mapParamNum2) end
        if (mapParamNum3 ~= nil) then table.insert(paramArr, mapParamNum3) end

        -- 执行和成功失败提示
        if (executor:refreshHeroMapProps(lv, paramArr)) then 
            helper:noteHMP() helper:closeGMUtil(self) else helper:noteUKN() end
        
    end))

    return newRowLayout
end











-- 怪物生成区块 --
GMUtilPanelContents.monsterGenSectionFunc = function (self)
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("生成怪物"))

    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- ID输入
    local idInput = helper:getInput("怪物ID", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, idInput, 20)

    -- 常用怪物下拉
    local mData = {{name = "异鼠", id = 10201101}, {name = "业火", id = 10201103}}
    local mText = helper:getListOfField(mData, "name")
    local mDropDown = helper:getDropDown("常用怪物▲", 160, mText, gmConfig.DIRECTION.UP)
    mDropDown:setOnSelectionChanged(function(obj, idx) idInput:setText(mData[idx].id) end) 
    helper:addSectionLeft(interactiveRow, mDropDown, 10)

    -- 数量稀有度
    local rarityInput = helper:getInput("稀有度", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, rarityInput, 50)

    -- 常用稀有度下拉数据
    local eData = {{name = "普通", id = 0}, {name = "精英", id = 1}}
    local eText = helper:getListOfField(eData, "name")
    local rarityDropDown = helper:getDropDown("稀有度▲", 130, eText, gmConfig.DIRECTION.UP)
    rarityDropDown:setOnSelectionChanged(function(obj, idx) rarityInput:setText(eData[idx].id) end)
    helper:addSectionLeft(interactiveRow, rarityDropDown, 10)

    -- 召唤按钮
    helper:addSectionRight(interactiveRow, helper:getButton("大王叫我来巡山", 230, function()
        if (not helper:checkInWild()) then return end
        -- 参数检查
        local id = idInput:getText()
        local amount = rarityInput:getText()
        if (not id or id == "" or not amount or amount == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (executor:addMonster(id, amount)) then
            helper:noteMGE() helper:closeGMUtil(self) else helper:noteUKN() end
    end))

    return newRowLayout
end













-- 传送区块 --
GMUtilPanelContents.blinkSectionFunc = function (self)
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("传送"))

    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    helper:addSectionLeft(interactiveRow, helper:getLabel(
        "目的地坐标:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- x输入
    local xInput = helper:getInput("X", 50, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, xInput, 20)

    -- y输入
    local yInput = helper:getInput("Y", 50, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, yInput, 50)

    -- 召唤按钮
    helper:addSectionRight(interactiveRow, helper:getButton("传送", 100, function()
        if (not helper:checkInWild()) then return end
        -- 参数检查
        local x = xInput:getText()
        local y = yInput:getText()
        if (not x or x == "" or not y or y == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (executor:blink(x, y)) then
            helper:noteBCO() helper:closeGMUtil(self) else helper:noteUKN() end
    end))

    return newRowLayout
end










--  梦境区块 --
GMUtilPanelContents.dreamSectionFunc = function (self)
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("梦境"))

    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    helper:addSectionLeft(interactiveRow, helper:getLabel(
        "设置梦境进度:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- Boss序号输入
    local bossIdxInput = helper:getInput("Boss序号", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, bossIdxInput, 20)

    -- 梦境等级输入
    local dreamLvInput = helper:getInput("梦境等级", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, dreamLvInput, 50)

    -- 设置按钮
    helper:addSectionRight(interactiveRow, helper:getButton("设置梦境", 150, function()
        -- 参数检查
        local bossIdx = bossIdxInput:getText()
        local dreamLv = dreamLvInput:getText()
        if (not bossIdx or bossIdx == "" or not dreamLv or dreamLv == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (executor:setDreamProgress(bossIdx, dreamLv)) then
            helper:noteDSS() helper:closeGMUtil(self) else helper:noteUKN() end
    end))

    return newRowLayout
end












-- 地图显示区块 --
GMUtilPanelContents.mapDisplayTitleSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("显示(修建中)"))
    return newRowLayout
end










-- 地图显示区块 --
GMUtilPanelContents.mapDisplaySectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 地图坐标行
    local mapRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, mapRow)
    -- 地图坐标标签
    helper:addSectionLeft(mapRow, helper:getLabel(
        "地图坐标 (切换地图后生效)",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 地图坐标开关
    local mapSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
        -- 参宿配置
        local b = false
        if (num == 1) then b = false elseif (num == 2) then b = true end

        -- 执行和提示
        if (executor:setShowCordinates(b) ) then
            -- 执行成功, 根据开关显示提示
            if (b) then helper:noteMDI() else helper:noteMDH() end 
            -- 提示是否要重新登录刷新实现
            helper:showConfirmCancel("是否重新登录刷新地图?", function()
                helper:closeGMUtil()
                executor:logoutGame()
            end)
        else
            -- 执行失败, 显示失败提示并且回滚开关
            helper:noteUKN() obj:setValue(oldNum) 
        end
    end)
    helper:addSectionRight(mapRow, mapSwitch)
    mapSwitch:setValue(helper:getShowCordinates() and 2 or 1)

    -- 入口行
    local entRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, entRow)
    -- 入口标签
    helper:addSectionLeft(entRow, helper:getLabel(
        "密室入口， 点金台， 附魔台， 下层入口等 (修建中)",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 入口开关
    helper:addSectionRight(entRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
        helper:noteCON()
        if (num == 1) then
            -- TODO: 添加动作
        elseif(num == 2) then
            -- TODO: 添加动作
        end
    end))


    -- -- 入口行
    -- local entRow = helper:getAutoHeightLayout()
    -- helper:addSectionUp(newRowLayout, entRow)
    -- -- 入口标签
    -- helper:addSectionLeft(entRow, helper:getLabel(
    --     "密室入口， 点金台， 附魔台， 下层入口等 (修建中)",
    --     gmConfig.LAYOUT_H_MEDIUM_30
    -- ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- -- 入口开关
    -- helper:addSectionRight(entRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
    --     helper:noteCON()
    --     if (num == 1) then
    --         -- TODO: 添加动作
    --     elseif(num == 2) then
    --         -- TODO: 添加动作
    --     end
    -- end))


    -- 精英怪位置行
    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, eliteRow)
    -- 精英怪位置标签
    helper:addSectionLeft(eliteRow, helper:getLabel(
        "精英怪位置 (修建中)",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 精英怪位置开关
    helper:addSectionRight(eliteRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
        helper:noteCON()
        if (num == 1) then
            -- TODO: 添加动作
        elseif(num == 2) then
            -- TODO: 添加动作
        end
    end))


    
    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, eliteRow)
    helper:addSectionLeft(eliteRow, helper:getLabel(
        "选关卡云朵下标显示、技能坐标显示",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    helper:addSectionRight(eliteRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
        helper:noteDEF()
        if (num == 1) then
            UI.ShowCloud = false
        elseif(num == 2) then
            -- TODO: 添加动作
            UI.ShowCloud = true
        end
    end))
    
    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, eliteRow)
    helper:addSectionLeft(eliteRow, helper:getLabel(
        "本地解锁所有图鉴",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    helper:addSectionRight(eliteRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num)
        helper:noteDEF()
        if (num == 1) then
            UI.ShowArch = false
        elseif(num == 2) then
            UI.ShowArch = true
        end
    end))

    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, eliteRow)
    helper:addSectionLeft(eliteRow, helper:getLabel(
        "待机自动掉线",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    local isOpen = cc.UserDefault:getInstance():getBoolForKey("isAutoDropLine", true)
    local default = isOpen == true and 2 or 1
    helper:addSectionRight(eliteRow, helper:getSwitch({"关", "开"}, 130, default, function(obj, num)
        helper:noteDEF()
        if (num == 1) then
            cc.UserDefault:getInstance():setBoolForKey("isAutoDropLine", false)
        elseif(num == 2) then
            cc.UserDefault:getInstance():setBoolForKey("isAutoDropLine", true)
        end
    end))


    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, eliteRow)
    helper:addSectionLeft(eliteRow, helper:getLabel(
        cc.FileUtils:getInstance():getWritablePath(),
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
   
    return newRowLayout
end











-- 属性变化区块 --
GMUtilPanelContents.attrSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("属性变化"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 属性下拉
    local pData = helper:getValidAttrList()
    local pText = helper:getListOfField(pData, "name")
    local pDropDown = helper:getDropDown("属性▼", 170, pText, nil, 14)
    helper:addSectionLeft(interactiveRow, pDropDown, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 数值输入框
    local numInput = helper:getInput("支持负数", 170, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactiveRow, numInput, 10)

    -- 增加按钮
    helper:addSectionRight(interactiveRow, helper:getButton(
    	"我要成为海贼王的男人(?)", 
    	370, 
    	function() 
    		local idx = pDropDown:getSelectedIndex()
    		local amount = numInput:getText()
    		if (idx == 0 or not amount or amount == "") then helper:noteICO() return end

    		if (executor:changeHeroAttr(pData[idx].type, amount)) then
    			helper:noteCAT() else helper:noteUKN() end
    	end))


    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10, -1)

    -- 增加按钮
    helper:addSectionLeft(interactiveRow2, helper:getButton("满攻", 100, function()
    	executor:atkMax()
    	helper:closeGMUtil()
    end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    helper:addSectionLeft(interactiveRow2, helper:getButton("重置新手引导", 210, function()
        executor:resetGuideProgress()
        -- helper:closeGMUtil()
    end), 10)

    helper:addSectionLeft(interactiveRow2, helper:getButton("完成新手引导", 210, function()
        executor:setGuideProgressAllFinished(true)
        -- helper:closeGMUtil()
    end), 10)

    helper:addSectionLeft(interactiveRow2, helper:getButton("暂时完成引导(重登恢复)", 340, function()
    	executor:setGuideProgressAllFinished()
        -- helper:closeGMUtil()
    end), 10)

    return newRowLayout
end











-- 人物数据高级区块 --
GMUtilPanelContents.printMasterPropsSectionFunc = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("高级功能"))

    -- 第一互交行
    local interactionRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow, 10)

    -- 属性ID输入
    local idInput = helper:getInput("输入属性ID", 200, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow, idInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 数量输入
    local numInput = helper:getInput("输入数量", 200, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow, numInput, 20)

    -- 添加按钮
    helper:addSectionLeft(interactionRow, helper:getButton("偷窥数据", 200, function()
        local id = tonumber(idInput:getText())

        -- if (not id) then helper:noteICO() return end

        if (UI.GMUtilExecutor:printMasterProps(id)) then 
            helper:noteDEF() else helper:noteUKN() end
    end), 10)

    -- 添加按钮
    helper:addSectionLeft(interactionRow, helper:getButton("篡改数据", 200, function() 
        local id = tonumber(idInput:getText())
        local number = tonumber(numInput:getText())

        if (not id or not number) then helper:noteICO() return end

        if (UI.GMUtilExecutor:changeHeroAttr(id, number)) then 
            helper:noteDEF() else helper:noteUKN() end
    end), 10)

    return newRowLayout
end











-- 无敌, CD区块 --
GMUtilPanelContents.heroAndSkillStatusSectionFunc = function ()
   	local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("无敌无CD"))

    -- 互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 英雄无敌行
    local mapRow = helper:getAutoHeightLayout()
    helper:addSectionUp(interactiveRow, mapRow)
    -- 英雄无敌标签
    helper:addSectionLeft(mapRow, helper:getLabel(
        "英雄无敌",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 英雄无敌开关
    local heroIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- if (not helper:checkInWild()) then obj:setValue(oldNum) return end
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:heroIsGod(b)) then 
            if (b) then helper:noteHIN() else helper:noteHNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local heroIsGod = cc.UserDefault:getInstance():getBoolForKey("HeroIsGod", false)
    heroIsGodSwitch:setValue(heroIsGod and 2 or 1)
    helper:addSectionRight(mapRow, heroIsGodSwitch)


    -- 怪物无敌行
    local entRow = helper:getAutoHeightLayout()
    helper:addSectionUp(interactiveRow, entRow)
    -- 怪物无敌标签
    helper:addSectionLeft(entRow, helper:getLabel(
        "怪物无敌",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 怪物无敌开关
    local monsterIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:monsterIsGod(b)) then 
            if (b) then helper:noteMIN() else helper:noteMNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local monsterIsGod = cc.UserDefault:getInstance():getBoolForKey("MonsterIsGod", false)
    heroIsGodSwitch:setValue(monsterIsGod and 2 or 1)
    helper:addSectionRight(entRow, monsterIsGodSwitch)



    -- 宠物无敌行
    local mapRow = helper:getAutoHeightLayout()
    helper:addSectionUp(interactiveRow, mapRow)
    helper:addSectionLeft(mapRow, helper:getLabel(
        "宠物无敌",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    local heroIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- if (not helper:checkInWild()) then obj:setValue(oldNum) return end
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:petIsGod(b)) then 
            if (b) then helper:noteHIN() else helper:noteHNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local heroIsGod = cc.UserDefault:getInstance():getBoolForKey("PetIsGod", false)
    heroIsGodSwitch:setValue(heroIsGod and 2 or 1)
    helper:addSectionRight(mapRow, heroIsGodSwitch)


    -- 宠物无敌行
    local mapRow = helper:getAutoHeightLayout()
    helper:addSectionUp(interactiveRow, mapRow)
    helper:addSectionLeft(mapRow, helper:getLabel(
        "英雄无伤害",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    local heroIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- if (not helper:checkInWild()) then obj:setValue(oldNum) return end
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:heroIsNewBie(b)) then 
            if (b) then helper:noteHIN() else helper:noteHNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local heroIsGod = cc.UserDefault:getInstance():getBoolForKey("PetIsNewBie", false)
    heroIsGodSwitch:setValue(heroIsGod and 2 or 1)
    helper:addSectionRight(mapRow, heroIsGodSwitch)


    -- 英雄技能CD行
    local eliteRow = helper:getAutoHeightLayout()
    helper:addSectionUp(interactiveRow, eliteRow)
    -- 英雄技能CD标签
    helper:addSectionLeft(eliteRow, helper:getLabel(
        "英雄技能无CD(修)",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 英雄节能CD开关
    helper:addSectionRight(eliteRow, helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- 修建中
        helper:noteCON()           
        obj:setValue(oldNum)
        return
        

        -- -- 处理参数
        -- local b = true
        -- if (num == 1) then b = true elseif(num == 2) then b = false end
        -- TODO: 添加动作
    end))

    return newRowLayout
end












-- 成就区块 --
GMUtilPanelContents.achievementSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("效果(修建中)"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 添加输入框
    local qInput = helper:getInput("输入要获得的EffectID, 多个用;隔开", 400, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, qInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("阿门", 200, function() 
        -- 参数检查
        local lv = qInput:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 建设中提示
        helper:noteCON()
        
    end))


    -- 添加互动行2
    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10)

    -- 添加输入框
    local qInput = helper:getInput("输入要获得的BuffID, 多个用;隔开", 400, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow2, qInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow2, helper:getButton("奶我一口!", 200, function() 
        -- 参数检查
        local lv = qInput:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 建设中提示
        helper:noteCON()
        
    end))

    -- 主角buff 全家福
    local interactiveRow3 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow3, 10)

    -- 添加输入框
    local qInput3 = helper:getInput("输入要添加的角色PK，默认给添加主角", 400, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow3, qInput3, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow3, helper:getButton("buff全家桶", 200, function() 
        -- 参数检查
        local lv = qInput3:getText()
        print("buff全家桶  lv=", lv)
        if (not lv or lv == "") then 
            UI.GMUtilExecutor:testAddAllBuffer(nil)
        else
            UI.GMUtilExecutor:testAddAllBuffer(tonumber(lv)) 
        end
    end))

    return newRowLayout
end










-- 货币经验钻石区块标题 --
GMUtilPanelContents.currenciesAndExpTitleSectionFunc = function ()
	-- 标签
	local newRowLayout = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, helper:getTitleRow("金币, 经验, 钻石"))
	return newRowLayout
end

-- 金币区块
GMUtilPanelContents.goldSectionFunc = function ()
	-- 标签
	local newRowLayout = helper:getAutoHeightLayout()

	-- 用户互交行
	local interactiveRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactiveRow)

	helper:addSectionLeft(interactiveRow, helper:getLabel(
        "添加金币",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- 输入
	local input = helper:getInput("金币数量", 130, cc.EDITBOX_INPUT_MODE_NUMERIC)
	input:setText("990000")
	helper:addSectionLeft(interactiveRow, input, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- -- +99W便捷按钮
	-- helper:addSectionLeft(interactiveRow, helper:getButton("+99W", 100, function() 
	-- 	local number= tonumber(input:getText())
	-- 	number = (number or 0) + 990000
	-- 	input:setText(number)
	-- end), 10)

	-- 增加按钮
	helper:addSectionLeft(interactiveRow, helper:getButton("增加金币", 150, function()
		-- 参数检查
		local amount = input:getText()
		if (not amount or amount == "") then helper:noteICO() return end

		-- 执行和成功失败提示
		if (UI.GMUtilExecutor:addGold(amount)) then 
			helper:noteINC() else helper:noteUKN() end
	end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 减少按钮
    helper:addSectionLeft(interactiveRow, helper:getButton("减少金币", 150, function()
        -- 参数检查
        local amount = input:getText()
        if (not amount or amount == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:addGold(-tonumber(amount))) then 
            helper:noteDEC() else helper:noteUKN() end
    end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	return newRowLayout
end













-- 钻石区块
GMUtilPanelContents.diamondSectionFunc = function ()
	-- 标签
	local newRowLayout = helper:getAutoHeightLayout()

	-- 用户互交行
	local interactiveRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactiveRow)

	helper:addSectionLeft(interactiveRow, helper:getLabel(
        "添加钻石",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- 输入
	local input = helper:getInput("钻石数量", 130, cc.EDITBOX_INPUT_MODE_NUMERIC)
	input:setText("990000")
	helper:addSectionLeft(interactiveRow, input, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- -- +99W便捷按钮
	-- helper:addSectionLeft(interactiveRow, helper:getButton("+99W", 100, function() 
	-- 	local number= tonumber(input:getText())
	-- 	number = (number or 0) + 990000
	-- 	input:setText(number)
	-- end), 10)

	-- 增加按钮
	helper:addSectionLeft(interactiveRow, helper:getButton("增加钻石", 150, function()
		-- 参数检查
		local amount = input:getText()
		if (not amount or amount == "") then helper:noteICO() return end

		-- 执行和成功失败提示
		if (UI.GMUtilExecutor:addDiamond(amount)) then 
			helper:noteINC() else helper:noteUKN() end
	end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 减少按钮
    helper:addSectionLeft(interactiveRow, helper:getButton("减少钻石", 150, function()
        -- 参数检查
        local amount = input:getText()
        if (not amount or amount == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:addDiamond(-tonumber(amount))) then 
            helper:noteDEC() else helper:noteUKN() end
    end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	return newRowLayout
end













-- 经验区块
GMUtilPanelContents.expSectionFunc = function ()
	-- 标签
	local newRowLayout = helper:getAutoHeightLayout()

	-- 用户互交行
	local interactiveRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactiveRow)

	helper:addSectionLeft(interactiveRow, helper:getLabel(
        "添加经验",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- 输入
	local input = helper:getInput("经验数量", 130, cc.EDITBOX_INPUT_MODE_NUMERIC)
	input:setText("1000")
	helper:addSectionLeft(interactiveRow, input, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- -- +1Q便捷按钮
	-- helper:addSectionLeft(interactiveRow, helper:getButton("+1Q", 75, function() 
	-- 	local number= tonumber(input:getText())
	-- 	number = (number or 0) + 1000
	-- 	input:setText(number)
	-- end), 10)

	-- -- 减少按钮
	-- helper:addSectionRight(interactiveRow, helper:getButton("-拿走!", 110, function()
	-- 	-- 参数检查
	-- 	local amount = input:getText()
	-- 	if (not amount or amount == "") then helper:noteICO() return end

	-- 	-- 执行和成功失败提示
	-- 	if (UI.GMUtilExecutor:addExp(-tonumber(amount))) then 
	-- 		helper:noteDEC() else helper:noteUKN() end
	-- end))

	-- 增加按钮
	helper:addSectionLeft(interactiveRow, helper:getButton("增加经验", 150, function()
		-- 参数检查
		local amount = input:getText()
		if (not amount or amount == "") then helper:noteICO() return end

		-- 执行和成功失败提示
		if (UI.GMUtilExecutor:addExp(amount)) then 
			helper:noteINC() else helper:noteUKN() end
	end), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
	return newRowLayout
end









-- 装备道具材料标题区块 --
GMUtilPanelContents.itemsTitleSectionFunc = function()
    local newRowLayout = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, helper:getTitleRow("道具, 装备, 材料"))
	return newRowLayout
end


-- 装备道具材料区块 --
GMUtilPanelContents.itemsSectionFunc = function ()
	local newRowLayout = helper:getAutoHeightLayout()

	-- 添加道具标签
    helper:addSectionLeft(newRowLayout, helper:getLabel(
        "添加道具",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- ID输入
	local idInput = helper:getInput("道具ID", 130, cc.EDITBOX_INPUT_MODE_NUMERIC)
	idInput:setText("20050010")
	helper:addSectionLeft(newRowLayout, idInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- 常用道具下拉数据
	local itemData = {
        {name = "打孔凿", id = 22050090},
        {name = "回城卷轴", id = 20050010},
        {name = "灵视卷轴", id = 20060010},
        {name = "红药7", id = 20010070},
        {name = "蓝药7", id = 20010140},
        {name = "铁镐", id = 20020010},
        {name = "蘑菇", id = 20040010},
        {name = "疾跑卷轴", id = 20090010},
        {name = "短剑", id = 21080020},
        {name = "木质长剑", id = 21080210},
        {name = "学徒杖", id = 21080400},
        {name = "大秘境钥匙", id = 22060010},
        {name = "洗点材料", id = 22030010},
        {name = "奖券", id = 22050010},
        {name = "钥匙1", id = 22060010},
        {name = "驱散道具", id = 20110010},
        {name = "时光卷轴", id = 22070010},
        {name = "领悟之书", id = 22070090},
        {name = "鞭炮", id = 20130010},
        {name = "安定药剂", id = 20110020},
        {name = "公会勋章", id = 23050001},
    }
	local itemText = helper:getListOfField(itemData, "name")
	local itemDropDown = helper:getDropDown("常用道具▲", 160, itemText, gmConfig.DIRECTION.UP, 9)
	helper:addSectionLeft(newRowLayout, itemDropDown, 10)

	-- 下拉菜单回调设置, 需要用到 ID输入 
	itemDropDown:setOnSelectionChanged(function(obj, idx) idInput:setText(itemData[idx].id) end)

	-- 数量输入
	local amountInput = helper:getInput("数量", 70, cc.EDITBOX_INPUT_MODE_NUMERIC)
	amountInput:setText("1")
	helper:addSectionLeft(newRowLayout, amountInput, 30)

	-- 常用数量下拉数据
	local amountText = {10,100,500}
	local amountDropDown = helper:getDropDown("数量▼", 100, amountText)
	amountDropDown:setOnSelectionChanged(function(obj, idx) amountInput:setText(amountText[idx]) end)
	helper:addSectionLeft(newRowLayout, amountDropDown, 10)

	-- 添加按钮
	helper:addSectionRight(newRowLayout, helper:getButton("生成道具", 150, function()
		-- 参数检查
		local id = idInput:getText()
		local amount = amountInput:getText()
		if (not id or id == "" or not amount or amount == "") then helper:noteICO() return end

		-- 执行和成功失败提示
		if (UI.GMUtilExecutor:addGoods(id, amount)) then 
			helper:noteIGE() else helper:noteUKN() end
	end))

	return newRowLayout, 100
end

-- 装备道具材料区块 --
GMUtilPanelContents.allItemsSectionFunc = function ()
    local contentLayout = helper:getAutoHeightLayout()

    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(contentLayout, newRowLayout)

	-- -- 添加按钮
	-- helper:addSectionLeft(newRowLayout, helper:getButton("所有装备", 150, function()
    --     print("添加所有装备")
    --     local allCfg = Config.ConfigGoods:getAllEquipmentConfig()
    --     local ids = {}
    --     for i,v in pairs(allCfg) do
    --         if type(v) == "table" then
    --             table.insert( ids, v.ID )
    --         end
    --     end
        
    --     helper:getScheduler(ids)
       
	-- end))

    helper:addSectionLeft(newRowLayout, helper:getButton("所有材料", 150, function()
        print("添加所有材料")
        local allCfg = Config.ConfigGoods:getAllMaterialConfig()
        local ids = {}
        for i,v in pairs(allCfg) do
            if type(v) == "table" then
                table.insert( ids, v.ID )
            end
        end
        
        helper:getScheduler(ids)
    end))
    
    helper:addSectionLeft(newRowLayout, helper:getButton("所有多彩", 150, function()
        print("添加所有多彩")
        local allCfg = Config.ConfigGoods:getAllGemStoneConfig()
        local ids = {}
        for i,v in pairs(allCfg) do
            if type(v) == "table" then
                if v.ID >= 24040000 then
                    table.insert( ids, v.ID )
                end
                
            end
        end
        
        helper:getScheduler(ids)
    end))
    local allStoneCfg = Config.ConfigGoods:getAllGemStoneConfig()
    local data = {}
    local maxLv = 0;
    for k,v in pairs(allStoneCfg) do
        if type(v) == "table" then
            if v.gemstoneLV > maxLv then
                maxLv = v.gemstoneLV
            end
        end
    end
    for i=1,maxLv do
        table.insert( data, {name = tostring(i),lv = i} )
    end
    local textData = helper:getListOfField(data, "name")
    local uiDropDown = helper:getDropDown("等级▲", 100, textData, gmConfig.DIRECTION.UP)
    helper:addSectionLeft(newRowLayout, uiDropDown, 10)
    
    helper:addSectionLeft(newRowLayout, helper:getButton("所有普通宝石", 200, function()
        print("添加所有普通宝石")
        -- 参数检查
        local idx = uiDropDown:getSelectedIndex()
        if (not idx or idx == 0) then  return end
        local lv = checkint(data[idx].lv)
        local allCfg = Config.ConfigGoods:getAllGemStoneConfig()
        local ids = {}
        for i,v in pairs(allCfg) do
            if type(v) == "table" then
                if v.ID < 24040000 and v.gemstoneLV == lv then
                    table.insert( ids, v.ID )
                end
                
            end
        end
        
        helper:getScheduler(ids)
    end))
    
    local data = {
        {name = "1", type = 1},
        {name = "2", type = 2},
        {name = "3", type = 3},
        {name = "4", type = 4},
        {name = "5", type = 5},
        
    }
    local textData = helper:getListOfField(data, "name")
    local uiDropDown = helper:getDropDown("品质▲", 100, textData, gmConfig.DIRECTION.UP)

    --跳转按钮
    helper:addSectionRight(newRowLayout, helper:getButton("所有装备", 150, function() 
        -- -- 参数检查
        local idx = uiDropDown:getSelectedIndex()
        if (not idx or idx == 0) then  return end
        local eType = checkint(data[idx].type)
        local allCfg = Config.ConfigGoods:getAllEquipmentConfig()
        local ids = {}
        for i,v in pairs(allCfg) do
            if type(v) == "table" then
                if v.goodsRare == eType then
                    table.insert( ids, v.ID )
                end
                
            end
        end
        
        helper:getScheduler(ids)
    end), 10)
    helper:addSectionRight(newRowLayout, uiDropDown, 10)




    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(contentLayout, newRowLayout)


    helper:addSectionLeft(newRowLayout, helper:getButton("所有占星", 150, function()
        print("添加所有占星")

        local ids = {}
        local starPrayConfigs = Config.Manager:getAllStarPray()
        for k,config in pairs(starPrayConfigs) do
            if (k ~= "size") then
                table.insert(ids, config.ID)
            end
        end

        helper:getScheduler(ids)
    end))

    helper:addSectionLeft(newRowLayout, helper:getButton("所有幻化", 150, function()
        print("添加所有幻化")

        local ids = {}
        local starPrayConfigs = Config.Manager:getAllEquipIllusions()
        for k,config in pairs(starPrayConfigs) do
            if (k ~= "size") then
                table.insert(ids, config.ID)
            end
        end

        helper:getScheduler(ids)
    end))

	return contentLayout, 100
end











-- 一键操作标题区块 --
GMUtilPanelContents.oneTouchOperationSectionFunc = function()
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("一键操作"))
    return newRowLayout
end


-- 一键操作区块 --
GMUtilPanelContents.oneTouchSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    --开包按钮
    helper:addSectionRight(newRowLayout, helper:getButton("一键开包", 150, function() 
        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:unlockBag(45)) then 
            helper:noteDEF() else helper:noteUKN() end
    end), 10)

    --清空按钮
    helper:addSectionRight(newRowLayout, helper:getButton("一键清空背包", 250, function() 
        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:clearBag()) then 
            helper:noteDEF() else helper:noteUKN() end
    end), 10)

    --赛亚人按钮
    helper:addSectionRight(newRowLayout, helper:getButton("一键赛亚人", 200, function() 
        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:saiyanMode()) then 
            helper:noteDEF() else helper:noteUKN() end
    end), 10)

    return newRowLayout
end















-- 掉落测试标题区块 --
GMUtilPanelContents.dropTestTitleSectionFunc = function()
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("掉落测试"))
    return newRowLayout
end


-- 掉落测试区块 --
GMUtilPanelContents.dropTestSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加道具标签
    helper:addSectionLeft(newRowLayout, helper:getLabel(
        "掉落包ID和数量(最多200)",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- ID输入
    local idInput = helper:getInput("ID", 90, cc.EDITBOX_INPUT_MODE_NUMERIC)
    idInput:setText("10001")
    helper:addSectionLeft(newRowLayout, idInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 数量输入
    local amountInput = helper:getInput("数量", 70, cc.EDITBOX_INPUT_MODE_NUMERIC)
    amountInput:setText("1")
    helper:addSectionLeft(newRowLayout, amountInput, 30)

    -- 常用数量下拉数据
    local amountText = {10,100,200}
    local amountDropDown = helper:getDropDown("数量▲", 100, amountText, gmConfig.DIRECTION.UP)
    amountDropDown:setOnSelectionChanged(function(obj, idx) amountInput:setText(amountText[idx]) end)
    helper:addSectionLeft(newRowLayout, amountDropDown, 10)

    -- 添加按钮
    helper:addSectionRight(newRowLayout, helper:getButton("掉落测试", 150, function()
        if (not helper:checkInWild()) then return end

        -- 参数检查
        local id = idInput:getText()
        local amount = amountInput:getText()
        if (not id or id == "" or not amount or amount == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:dropTest(id, amount)) then 
            helper:noteDDT() else helper:noteUKN() end
    end))

    return newRowLayout, 101
end















-- 功能解锁标题区块 --
GMUtilPanelContents.systemUnlockTitleSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("系统解锁"))

    return newRowLayout
end











-- 功能解锁区块 --
GMUtilPanelContents.systemUnlockSectionFunc = function ()
    -- 添加互动行
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加注释
    helper:addSectionLeft(newRowLayout, helper:getLabel(
        "点击按钮后， 解锁全部系统",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(newRowLayout, helper:getButton("解锁功能", 150, function() 
        -- 建设中提示
        if (UI.GMUtilExecutor:unlockAllFunctions()) then 
            helper:noteFUL() else helper:noteUKN() end
    end))

    -- 添加提交按钮
    helper:addSectionRight(newRowLayout, helper:getButton("清除提示", 150, function() 
        -- 建设中提示
        if (UI.GMUtilExecutor:clearUnlockDisplayQueue()) then 
            helper:noteCUF() else helper:noteUKN() end
    end))

    return newRowLayout
end













-- 模式和难度区块 --
GMUtilPanelContents.modeAndDifficultySectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("解锁模式和难度"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 添加模式下拉
    local mData = helper:getModeDataList()
    local mText = helper:getListOfField(mData, "name")
    local mDropDown = helper:getDropDown("选择模式▲", 160, mText, gmConfig.DIRECTION.UP)
    helper:addSectionLeft(interactiveRow, mDropDown, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加难度下拉
    local dData = helper:getDiffDataList()
    local dText = helper:getListOfField(dData, "name")
    local dDropDown = helper:getDropDown("选择难度▲", 160, dText, gmConfig.DIRECTION.UP)
    helper:addSectionLeft(interactiveRow, dDropDown, 10)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("虐我!!!", 200, function() 
        local mIdx = mDropDown:getSelectedIndex() or 0
        local dIdx = dDropDown:getSelectedIndex() or 0
        if (mIdx == 0 or dIdx == 0) then helper:noteICO() return end


        -- 执行和成功失败提示
        if (UI.GMUtilExecutor:unlockModeDiff(mData[mIdx].modeType, dData[dIdx].diffType)) then 
            helper:noteMDU() else helper:noteUKN() end
    end))

    return newRowLayout
end














-- 任务完成区块 --
GMUtilPanelContents.questCompleteSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("任务/成就 一键完成"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 添加注释
    helper:addSectionLeft(interactiveRow, helper:getLabel(
        "点击后完成所有任务",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("完成所有任务", 200, function() 
        if (UI.GMUtilExecutor:forceCompleteQuests()) then 
            helper:noteQCO(); helper:closeGMUtil() else helper:noteUKN() end
    end))

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("完成所有目标", 200, function() 
        if (UI.GMUtilExecutor:completeAllTargetActivities()) then 
            helper:noteQCO(); helper:closeGMUtil() else helper:noteUKN() end
    end))


    -- 添加互动行
    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10)

    -- 添加注释
    helper:addSectionLeft(interactiveRow2, helper:getLabel(
        "输入成就ID:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加输入框
    local qInput = helper:getInput("成就ID", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow2, qInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow2, helper:getButton("完成指定成就", 200, function() 
        -- 参数检查
        local achieveId = qInput:getText()
        if (not achieveId or achieveId == "") then helper:noteICO() return end

        if (UI.GMUtilExecutor:forceCompleteAchievement(achieveId)) then 
            helper:noteQCO() else helper:noteUKN() end
        
    end))

    return newRowLayout
end













-- 任务区块 --
GMUtilPanelContents.questAchievementCollectionSectionFunc = function ()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("任务, 成就, 图鉴(修建中)"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)

    -- 添加输入框
    local qInput = helper:getInput("输入要获得的任务ID，多个用；隔开", 400, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, qInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 任务状态开关
    local sSwitch = helper:getSwitch({"未完", "完成"}, 150, 1)

    helper:addSectionLeft(interactiveRow, sSwitch, 10)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("给我工作", 200, function() 
        -- 参数检查
        local lv = qInput:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 建设中提示
        helper:noteCON()
        
    end))


    -- 添加互动行
    local interactiveRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow2, 10)

    -- 添加输入框
    local qInput = helper:getInput("输入要解锁的成就ID，多个用；隔开", 400, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow2, qInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow2, helper:getButton("满满一兜成就", 200, function() 
        -- 参数检查
        local lv = qInput:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 建设中提示
        helper:noteCON()
        
    end))


    -- 添加互动行
    local interactiveRow3 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow3, 10)

    -- 添加注释
    helper:addSectionLeft(interactiveRow3, helper:getLabel(
        "点击按钮后， 解锁全部图鉴内容。",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 添加提交按钮
    helper:addSectionRight(interactiveRow3, helper:getButton("老板我要本子", 200, function() 
        -- 建设中提示
        -- helper:noteCON()
        
        UI.ShowArch = true
    end))

    return newRowLayout
end













-- 账号显示区块 --
GMUtilPanelContents.accountSectionFunc = function()
	local id = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify, "no account")
	local newRowLayout = helper:getAutoHeightLayout()
	
	helper:addSectionUp(newRowLayout, helper:getLabel(
        "ID ： " .. id,
        gmConfig.LAYOUT_H_SMALL_PLUS_25
    ))
	return newRowLayout
end


-- 一些功能属性 --
GMUtilPanelContents.functionAttrContent = function()
    local newRowLayout = helper:getAutoHeightLayout()

    -- 添加标题行
    helper:addSectionUp(newRowLayout, helper:getTitleRow("系统功能属性(修建中)"))

    -- 添加互动行
    local interactiveRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactiveRow)
    -- required uint32 slotId = 2;                 // 神迹槽 ID
    -- optional uint32 level = 3;                  // 设置等级
    -- optional int32 exp = 4;                     // 设置经验值
    -- 添加输入框
    local idInput = helper:getInput("神迹ID", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, idInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local levelInput = helper:getInput("神迹等级", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, levelInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local expInput = helper:getInput("神迹经验", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactiveRow, expInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)


    -- 添加提交按钮
    helper:addSectionRight(interactiveRow, helper:getButton("修改神迹属性", 200, function() 
        local data = {}
        local text = idInput:getText()
        if (not text or text == "") then UI.ScrollBar:createByText("输入正确的神迹ID") return end
        data.slotId = tonumber(text)

        local text = levelInput:getText()
        if not (not text or text == "") then
            data.level = tonumber(text)
        end

        local text = expInput:getText()
        if not (not text or text == "") then
            data.exp = tonumber(text)
        end

        print("神迹属性修改参数 data=", data)
        UI.GMUtilExecutor:changeMiracleData(data)
    end))

    return newRowLayout
end













-- 延迟模拟区块 --
GMUtilPanelContents.latencySimSectionFunc = function()
	-- 标题
	local newRowLayout = helper:getAutoHeightLayout()
    -- 下面要往标题行加东西, 故取名暂存
    local title = helper:getTitleRow("网络延迟模拟")
	helper:addSectionUp(newRowLayout, title)
    -- 总开关标签
    helper:addSectionRight(title, helper:getLabel(
        "总开关",
        gmConfig.LAYOUT_H_SMALL_20, nil, nil, nil, nil, 10
    ), 30)
    -- 发包打印标签
    helper:addSectionRight(title, helper:getLabel(
        "内容打印",
        gmConfig.LAYOUT_H_SMALL_20, nil, nil, nil, nil, 10
    ), 40)


	-- 第一互交行
	local interactionRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactionRow, nil, 1)

	helper:addSectionLeft(interactionRow, helper:getLabel(
        "收包:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)


	-- 现在接收包延迟
	local recvDelayBase, recvDelayDelta = helper:getRecvDelays()
	
	-- 基础延迟输入
    local rbInput = helper:getInput("基础值", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    if (recvDelayBase and recvDelayBase ~= 0) then rbInput:setText(recvDelayBase) end
    helper:addSectionLeft(interactionRow, rbInput, 10)
    -- 基础延迟下拉
    local rbText = {0, 200, 300, 400, 500, 1000, 2000, 5000, 10000}
    local rbDropDown = helper:getDropDown("基础▼", 110, rbText, gmConfig.DIRECTION.DOWN)
    rbDropDown:setOnSelectionChanged(function(obj, idx) 
    	UI.GMUtilExecutor:setRecvDelay(rbText[idx])
    	rbInput:setText(rbText[idx]) 
    end) 
    helper:addSectionLeft(interactionRow, rbDropDown, 10)

    -- 延迟浮动输入
    local rdInput = helper:getInput("浮动值", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    if (recvDelayDelta and recvDelayDelta ~= 0) then rdInput:setText(recvDelayDelta) end
    helper:addSectionLeft(interactionRow, rdInput, 10)
    -- 延迟浮动下拉
    local rdText = {0, 200, 300, 400, 500, 1000, 2000, 5000, 10000}
    local rdDropDown = helper:getDropDown("浮动▼", 110, rdText, gmConfig.DIRECTION.DOWN)
    rdDropDown:setOnSelectionChanged(function(obj, idx) 
    	UI.GMUtilExecutor:setRecvDelay(nil, rdText[idx])
    	rdInput:setText(rdText[idx]) 
    end) 
    helper:addSectionLeft(interactionRow, rdDropDown, 10)

    local rdSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- 参数配置
        local base = rbInput:getText()
        local delta = rdInput:getText()
        local b = false
        if (num == 1) then b = false elseif (num == 2) then b = true end

        -- 执行和提示
        if (UI.GMUtilExecutor:setRecvDelayOn(b, base, delta) ) then
        	if (b) then helper:noteDON() else helper:noteDOF() end else 
        	helper:noteUKN() obj:setValue(oldNum) end
    end)
    rdSwitch:setValue(helper:isRecvDelayOn() and 2 or 1)
    helper:addSectionRight(interactionRow, rdSwitch)

    -- 收包打印包内容开关
    local rcSwitch = helper:getSwitch({"隐藏", "打印"}, 110, 1, function(obj, num, oldNum)
        -- 处理参数
        local b = false
        if (num == 1) then b = false elseif (num == 2) then b = true end
        -- 执行和提示
        if (UI.GMUtilExecutor:setShowRecvContent(b) ) then
            if (b) then helper:noteSPC() else helper:noteHPC() end else 
            helper:noteUKN() obj:setValue(oldNum) end
    end, gmConfig.LAYOUT_SWITCH_HEIGHT - 20, gmConfig.LAYOUT_SWITCH_HEIGHT - 25)

    rcSwitch:setValue(helper:isShowRecvCon() and 2 or 1)
    helper:addSectionRight(interactionRow, rcSwitch, 10)


    -- 第二互交行
    local interactionRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow2, nil, 0)

    helper:addSectionLeft(interactionRow2, helper:getLabel(
        "发包:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)


    -- 现在发送包延迟
    local sendDelayBase, sendDelayDelta = helper:getSendDelays()
    
    -- 基础延迟输入
    local sbInput = helper:getInput("基础值", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    if (sendDelayBase and sendDelayBase ~= 0) then sbInput:setText(sendDelayBase) end
    helper:addSectionLeft(interactionRow2, sbInput, 10)
    -- 基础延迟下拉
    local sbText = {0, 200, 300, 400, 500, 1000, 2000, 5000, 10000}
    local sbDropDown = helper:getDropDown("基础▼", 110, sbText, gmConfig.DIRECTION.DOWN)
    sbDropDown:setOnSelectionChanged(function(obj, idx) 
        UI.GMUtilExecutor:setSendDelay(sbText[idx])
        sbInput:setText(sbText[idx]) 
    end) 
    helper:addSectionLeft(interactionRow2, sbDropDown, 10)

    -- 延迟浮动输入
    local sdInput = helper:getInput("浮动值", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    if (sendDelayDelta and sendDelayDelta ~= 0) then sdInput:setText(sendDelayDelta) end
    helper:addSectionLeft(interactionRow2, sdInput, 10)
    -- 延迟浮动下拉
    local sdText = {0, 200, 300, 400, 500, 1000, 2000, 5000, 10000}
    local sdDropDown = helper:getDropDown("浮动▼", 110, sdText, gmConfig.DIRECTION.DOWN)
    sdDropDown:setOnSelectionChanged(function(obj, idx) 
        UI.GMUtilExecutor:setSendDelay(nil, sdText[idx])
        sdInput:setText(sdText[idx]) 
    end) 
    helper:addSectionLeft(interactionRow2, sdDropDown, 10)

    -- 发送延迟总开关
    local sdSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- 参数配置
        local base = sbInput:getText()
        local delta = sdInput:getText()
        local b = false
        if (num == 1) then b = false elseif (num == 2) then b = true end

        -- 执行和提示
        if (UI.GMUtilExecutor:setSendDelayOn(b, base, delta) ) then
            if (b) then helper:noteDON() else helper:noteDOF() end else 
            helper:noteUKN() obj:setValue(oldNum) end
    end)
    sdSwitch:setValue(helper:isSendDelayOn() and 2 or 1)
    helper:addSectionRight(interactionRow2, sdSwitch)

    -- 发送打印包内容开关
    local scSwitch = helper:getSwitch({"隐藏", "打印"}, 110, 1, function(obj, num, oldNum)
        -- 参数处理
        local b = false
        if (num == 1) then b = false elseif (num == 2) then b = true end
        -- 执行和提示
        if (UI.GMUtilExecutor:setShowSendContent(b) ) then
            if (b) then helper:noteSPC() else helper:noteHPC() end else 
            helper:noteUKN() obj:setValue(oldNum) end
    end, gmConfig.LAYOUT_SWITCH_HEIGHT - 20, gmConfig.LAYOUT_SWITCH_HEIGHT - 25)
    scSwitch:setValue(helper:isShowSendCon() and 2 or 1)
    helper:addSectionRight(interactionRow2, scSwitch, 10)

	return newRowLayout, 100 --z 100 修复下拉菜单, 让其出现在最顶层
end













-- 服务器账号切换区块 --
GMUtilPanelContents.serverChangeSectionFunc = function()
	-- 标题
	local newRowLayout = helper:getAutoHeightLayout()
    GMUtilPanelContents._reconIP = GMUtilPanelContents._reconIP or helper:getDefaultServerIP()
    GMUtilPanelContents._reconPort = GMUtilPanelContents._reconPort or helper:getDefaultServerPort()
	helper:addSectionUp(newRowLayout, helper:getTitleRow(
		"服务器和账号(现在:".. 
        GMUtilPanelContents._reconIP .. ":" .. 
        tostring(GMUtilPanelContents._reconPort) ..")"))

	-- 第一互交行
	local interactionRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactionRow)

	-- IP输入
    local ipInput = helper:getInput("IP地址", 200, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow, ipInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    ipInput:setText(helper:getDefaultServerIP())

    -- 端口
    local pInput = helper:getInput("端口", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(interactionRow, pInput, 20)
    pInput:setText(helper:getDefaultServerPort())

    -- 服务器切换按钮
    helper:addSectionRight(interactionRow, helper:getButton("世界大跳转!", 200, function() 
        -- 参数检查
        local ip = ipInput:getText()
        local port = pInput:getText()
        GMUtilPanelContents._reconIP = ip
        GMUtilPanelContents._reconPort = tonumber(port)
        if (not ip or ip == "" or not port or port == "") then helper:noteICO() return end

        -- 切换服务器
        helper:closeGMUtil()
       	if (UI.GMUtilExecutor:switchServer(ip, port)) then 
       		helper:noteSSW() else helper:noteUKN() end
    end))


	-- 第二互交行
	local interactionRow2 = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, interactionRow2, 10)
    
    -- 添加账号输入
    local accInput = helper:getInput("输入账号", 200, cc.EDITBOX_INPUT_MODE_NUMERIC)
    accInput:setText(helper:getCurrentAccount())
    helper:addSectionLeft(interactionRow2, accInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 跳转按钮(添加到第一行)
    helper:addSectionRight(interactionRow2, helper:getButton("变身~~!", 200, function() 
        -- 参数检查
        local account = accInput:getText()
        if (not account or account == "") then helper:noteICO() return end
        local ip = GMUtilPanelContents._reconIP or helper:getDefaultServerIP()
        local port = GMUtilPanelContents._reconPort or tonumber(helper:getDefaultServerPort())

        -- 切换账号
        helper:closeGMUtil()
        if (UI.GMUtilExecutor:switchServer(ip, port, account)) then 
            helper:noteSAC() else helper:noteUKN() end
    end))

	return newRowLayout
end






-- 商店跳转测试 --
GMUtilPanelContents.jumpShopSectionFunc = function()
    -- 下拉
    local rbText = {{"小米", "com.appStore.mi", "com.avalon.caveonline.mi", "http://xiaomi.com"}, 
        {"华为", "com.huawei.appmarket", "com.avalon.caveonline.cn.huawei", "https://appstore.huawei.com/app/C100242851"},
        {"魅族", "com.appStore.meizu", "com.avalon.caveonline.meizu", "http://meizu.com"},
        {"九游UC", "com.appStore.uc", "com.avalon.caveonline.uc", "http://uc.com"},
        {"4399", "com.appStore.4399", "com.avalon.caveonline.4399", "http://4399.com"}}


    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    -- 下面要往标题行加东西,
    local title = helper:getTitleRow("应用商店跳转")
    helper:addSectionUp(newRowLayout, title)

    -- 第一行下拉框  确定按钮
    local interactionRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow, nil, 1)

    local showText = {}
    for k, v in ipairs(rbText) do
        table.insert(showText, v[1])
    end
    local rbDropDown = helper:getDropDown("点击选择渠道▼", 300, showText, gmConfig.DIRECTION.DOWN)
    helper:addSectionLeft(interactionRow, rbDropDown, 10)


    -- 第二行商店包名、游戏应用包名
    local interactionRow2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow2, nil, 0)
    helper:addSectionLeft(interactionRow2, helper:getLabel(
        "商店包名:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local shopName = helper:getInput("", 320, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow2, shopName, 10)

    local interactionRow3 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow3, nil, 0)
    helper:addSectionLeft(interactionRow3, helper:getLabel(
        "应用包名:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local gameName = helper:getInput("", 320, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow3, gameName, 10)


    --第三行 http地址
    local interactionRow4 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow4, nil, 0)
    helper:addSectionLeft(interactionRow4, helper:getLabel(
        "备用跳转URL:",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local urlName = helper:getInput("", 600, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(interactionRow4, urlName, 10)

    rbDropDown:setOnSelectionChanged(function(obj, idx) 
        shopName:setText(rbText[idx][2]) 
        gameName:setText(rbText[idx][3]) 
        urlName:setText(rbText[idx][4]) 
    end) 

   -- 添加按钮
    helper:addSectionLeft(interactionRow, helper:getButton(" ～找渠道分钱～ ", 250, function() 
        local SdkBox = require("utils.sdkbox.SdkBox")
        SdkBox:getInstance():jumpToAppStoreByGameName(urlName:getText(), shopName:getText(), gameName:getText())
    end), 310)

    return newRowLayout, 100 --z 100 修复下拉菜单, 让其出现在最顶层
end













-- 缓存清理区块 --
GMUtilPanelContents.cacheCleanSectionFunc = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("文件清理"))

    -- 第一互交行
    local interactionRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, interactionRow)

    -- 添加按钮
    helper:addSectionRight(interactionRow, helper:getButton("缓存清理", 200, function() 
        if (UI.GMUtilExecutor:clearLocalCache()) then 
            helper:noteDEF() else helper:noteUKN() end
    end))

    return newRowLayout
end












-- -- 掉落测试 --
-- GMUtilPanelContents.dropTestSectionFunction = function()
--     -- 标题
--     local newRowLayout = helper:getAutoHeightLayout()
--     helper:addSectionUp(newRowLayout, helper:getTitleRow("测试掉落"))

--     -- 第一互交行
--     local interactionRow = helper:getAutoHeightLayout()
--     helper:addSectionUp(newRowLayout, interactionRow)

--     -- 楼层跳转标签
--     helper:addSectionLeft(interactionRow, helper:getLabel(
--         "输入道具ID和数量: ",
--         gmConfig.LAYOUT_H_MEDIUM_30
--     ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

--     -- 道具ID输入
--     local itemIdInput = helper:getInput("道具ID", 150, cc.EDITBOX_INPUT_MODE_NUMERIC)
--     helper:addSectionLeft(interactionRow, itemIdInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

--     -- 道具数量输入
--     local itemNumInput = helper:getInput("道具数量", 100, cc.EDITBOX_INPUT_MODE_NUMERIC)
--     helper:addSectionLeft(interactionRow, itemNumInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

--     -- 添加按钮
--     helper:addSectionRight(interactionRow, helper:getButton("掉落测试", 200, function() 
--         local id = itemIdInput:getText()
--         local num = itemNumInput:getText()
--         if (not id or id == "" or not num or num == "") then helper:noteICO() return end

--         if (UI.GMUtilExecutor:dropTest(id, num)) then 
--             helper:noteDDT() else helper:noteUKN() end
--     end))

--     return newRowLayout
-- end







    -- -- 标题
    -- local newRowLayout = helper:getAutoHeightLayout()

    -- ----------- 楼层 ------------
    -- local newRow = helper:getAutoHeightLayout()
    -- helper:addSectionUp(newRowLayout, newRow)

    -- -- 楼层跳转标签
    -- helper:addSectionLeft(newRow, helper:getLabel(
    --     "楼层跳转",
    --     gmConfig.LAYOUT_H_MEDIUM_30
    -- ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- -- 楼层输入框
    -- local lvInput = helper:getInput("输入要前往的楼层", 250, cc.EDITBOX_INPUT_MODE_NUMERIC)
    -- helper:addSectionLeft(newRow, lvInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- -- 常用楼层下拉
    -- local data = {{name = "测试层", id = 50000}}
    -- local textData = helper:getListOfField(data, "name")
    -- local mapDropDown = helper:getDropDown("常用楼层▼", 160, textData)
    -- mapDropDown:setOnSelectionChanged(function(obj, idx) lvInput:setText(data[idx].id) end)
    -- helper:addSectionLeft(newRow, mapDropDown, 10)

    -- --跳转按钮
    -- helper:addSectionRight(newRow, helper:getButton("楼层跳转", 150, function() 
    --     -- 参数检查
    --     if (not helper:checkInWild()) then return end
    --     local lv = lvInput:getText()
    --     if (not lv or lv == "") then helper:noteICO() return end

    --     -- 执行和成功失败提示
    --     if (executor:gotoLevel(lv)) then 
    --         helper:noteLVJ() helper:closeGMUtil(self) else helper:noteUKN() end
    -- end))



-- 隐藏UI区块 --
GMUtilPanelContents.uiManagementSectionFunction = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("UI管理"))

    -- 再添加一行
    local row2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, row2, 10)

    -- 添加按钮
    helper:addSectionRight(row2, helper:getButton("隐藏测试UI", 200, function() 
        if (UI.GMUtilExecutor:setShowTestUI(false)) then 
            helper:noteDEF()
            helper:showConfirmCancel("是否现在登出重新加载UI状态喵?(点击左上角<<看不见的按钮>>可以重新显示所有UI喵.)", function()
                helper:closeGMUtil()
                executor:logoutGame()
            end)
        else 
            helper:noteUKN()
        end
    end), 10)


    local hideMainUI = cc.UserDefault:getInstance():getBoolForKey("HideMainUI", false)
    -- 英雄无敌开关
    local turnoff = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- if (not helper:checkInWild()) then obj:setValue(oldNum) return end
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end
        cc.UserDefault:getInstance():setBoolForKey("HideMainUI", b)
    end)
    turnoff:setValue(hideMainUI and 2 or 1)
    helper:addSectionRight(row2, turnoff, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
    -- 英雄无敌标签
    helper:addSectionRight(row2, helper:getLabel("隐藏常驻UI",gmConfig.LAYOUT_H_MEDIUM_30,120), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD + 5)


    -- 添加打开界面下拉行
    local newRow = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, newRow, 10)

    -- UI界面NoticeID下拉
    local data = {
        {name = "黑商", id = AvalonMessage.MC_ROLE_SHOW_BLACK_SHOP},
        {name = "随机商店", id = AvalonMessage.MC_ROLE_SHOW_RANDOM_SHOP},
        {name = "强化", id = AvalonMessage.MC_UI_SHOW_STRENGTHEN},
        {name = "改造", id = AvalonMessage.MC_UI_SHOW_REMOULD},
        {name = "分解", id = AvalonMessage.MC_UI_SHOW_RESOLVE},
        {name = "锻造", id = AvalonMessage.MC_UI_SHOW_FORGE},
        {name = "洞窟点金", id = AvalonMessage.MC_BATTLE_IN_CAVE_GOLDPOINTING},
        {name = "洞穴附魔", id = AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT},
        {name = "捏脸", id = AvalonMessage.MC_UI_SHOW_BEAUTYSALON},
        {name = "猫饭", id = AvalonMessage.MC_UI_SHOW_CATFOOD},
        {name = "仓库", id = AvalonMessage.MC_UI_SHOW_WAREHOUSE},
        {name = "抽奖", id = AvalonMessage.MC_UI_SHOW_LUCKDROP},
        {name = "背包", id = AvalonMessage.MC_UI_SHOW_BAG},
        {name = "内购", id = AvalonMessage.MC_UI_SHOW_IAPSHOP},
        {name = "大秘境", id = AvalonMessage.MC_UI_SHOW_ENDLESS_SPACE},
        {name = "排行榜", id = AvalonMessage.MC_UI_SHOW_RANKING},
        {name = "工会科技", id = AvalonMessage.MC_UI_SHOW_GUILD_TECH},
        {name = "好友", id = AvalonMessage.MC_UI_FRIEND_MAIN},
        {name = "工会任务", id = AvalonMessage.MC_UI_SHOW_GUILD_TASK},
        {name = "宝石合成", id = AvalonMessage.MC_UI_GEM_SYNTHESIS},
        {name = "宝石购买", id = AvalonMessage.MC_UI_GEM_BUY},
        {name = "宝石转换", id = AvalonMessage.MC_UI_GEM_TRANSFORM},
        {name = "邮箱", id = AvalonMessage.MC_TASK_SHOW_MAILLAYER},
        {name = "藏宝图", id = AvalonMessage.MC_UI_SHOW_BAG},
        {name = "大秘境结算", id = AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_LAYER},
        {name = "活动列表", id = AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL},
        {name = "组队界面", id = AvalonMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,params = 1},
        {name = "洞窟商店", id = AvalonMessage.MC_BATTLE_IN_CAVE_SHOP},
        {name = "金矿", id = AvalonMessage.MC_UI_HOME_GOLDEN_MINE_SHOW_UI},
        {name = "符文工房", id = AvalonMessage.MC_UI_HOME_GEM_FACTORY_SHOW_UI},
        {name = "梦境试验", id = AvalonMessage.MC_UI_SHOW_DREAM_CHALLENGE},
        {name = "公会商店", id = "公会商店"}
    }
    local textData = helper:getListOfField(data, "name")
    local uiDropDown = helper:getDropDown("选择UI界面▲", 200, textData, gmConfig.DIRECTION.UP)

    --跳转按钮
    helper:addSectionRight(newRow, helper:getButton("打开界面UI", 200, function() 
        -- 参数检查
        local idx = uiDropDown:getSelectedIndex()
        if (not idx or idx == 0) then helper:noteICO() return end
        local GameMapManager = require("app.game.GameMapManager")
        local oldlevel = GameMapManager:getInstance():getMapData().level
        
        if checkint(data[idx].id) == AvalonMessage.MC_BATTLE_IN_CAVE_SHOP then
            GameMapManager:getInstance():getMapData().level = 2001
            
        end
        
        -- 执行和成功失败提示
        if (executor:openUI(data[idx].id,data[idx].params)) then 
            helper:noteOUI() helper:closeGMUtil(self) else helper:noteUKN() end

        GameMapManager:getInstance():getMapData().level = oldlevel
    end), 10)
    helper:addSectionRight(newRow, uiDropDown, 10)


    return newRowLayout
end













-- 其他区块标题 -- 
GMUtilPanelContents.miscTitleSectionFunc = function()
	-- 标题
	local newRowLayout = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, helper:getTitleRow("杂项"))

	return newRowLayout
end














-- 其他区块 -- 
GMUtilPanelContents.miscSectionFunc = function()
    local wrap = helper:getAutoHeightLayout()

	local row1 = helper:getAutoHeightLayout()
    helper:addSectionUp(wrap, row1)


    -- 添加按钮
    helper:addSectionRight(row1, helper:getButton("分享测试", 200, function() 
        if (UI.GMUtilExecutor:testShare()) then 
        	helper:noteDEF() else helper:noteUKN() end
    end))

    -- -- 添加按钮
    -- helper:addSectionRight(row1, helper:getButton("POST测试", 200, function() 
    --    	if (UI.GMUtilExecutor:testPost()) then 
    --     	helper:noteDEF() else helper:noteUKN() end
    -- end), 10)

    -- -- 添加按钮
    -- helper:addSectionRight(row1, helper:getButton("TEST", 200, function() 
    --     UI.GMUtilExecutor:test()
    -- end), 10)
    -- UI界面NoticeID下拉
    -- local AdultType = {
    --     AdultType_Adult = 0;            -- 已认证已成年
    --     AdultType_Under_Age = 1;        -- 已认证未成年 
    --     AdultType_Unkown = 2;           -- 未认证
    -- }
    local data = {
        {name = "未认证", type = PublicDefine.AdultType.AdultType_Unkown},
        {name = "已认证未成年", type = PublicDefine.AdultType.AdultType_Under_Age},
        {name = "已认证已成年", type = PublicDefine.AdultType.AdultType_Adult},
        
    }
    local textData = helper:getListOfField(data, "name")
    local uiDropDown = helper:getDropDown("选择认证状态▲", 200, textData, gmConfig.DIRECTION.UP)

    --跳转按钮
    helper:addSectionRight(row1, helper:getButton("更新认证状态", 200, function() 
        -- -- 参数检查
        local idx = uiDropDown:getSelectedIndex()
        if (not idx or idx == 0) then  return end
        local status = checkint(data[idx].type)
        -- print("data[idx]",data[idx].type)
        -- local GameMapManager = require("app.game.GameMapManager")
        -- local oldlevel = GameMapManager:getInstance():getMapData().level
        
        -- if checkint(data[idx].id) == AvalonMessage.MC_BATTLE_IN_CAVE_SHOP then
        --     GameMapManager:getInstance():getMapData().level = 2001
            
        -- end
        
        -- -- 执行和成功失败提示
        -- if (executor:notice(data[idx].id,data[idx].params)) then 
        --     helper:noteOUI() helper:closeGMUtil(self) else helper:noteUKN() end

        -- GameMapManager:getInstance():getMapData().level = oldlevel
        Net.NetRoleSystem:reqUpdateAdultType(status)
        print("更新实名认证状态",status)
    end), 10)
    helper:addSectionRight(row1, uiDropDown, 10)

    -- 打印textureCahe信息
    helper:addSectionRight(row1, helper:getButton("打印缓存", 200, function() 
        print(cc.Director:getInstance():getTextureCache():getCachedTextureInfo())
        -- print(cc.TextureCache:getInstance():getCachedTextureInfo())
    end))

    local row2 = helper:getAutoHeightLayout()
    helper:addSectionUp(wrap, row2)


    helper:addSectionLeft(row2, helper:getLabel(
        "数据包: ",gmConfig.LAYOUT_H_MEDIUM_30))

    helper:addSectionLeft(row2, helper:getButton("打印", 100, function() 
        Net.showLog = true
    end))
    helper:addSectionLeft(row2, helper:getButton("关闭", 100, function() 
        Net.showLog = false
    end))
	return wrap
end












-- 仿老排版简化地图跳转 -- 
GMUtilPanelContents.simpleFloorJumpSectionFunc = function()
	-- 标题
	local newRowLayout = helper:getAutoHeightLayout()

	----------- 楼层 ------------
	local newRow = helper:getAutoHeightLayout()
	helper:addSectionUp(newRowLayout, newRow)

    -- 楼层跳转标签
    helper:addSectionLeft(newRow, helper:getLabel(
        "楼层跳转",
        gmConfig.LAYOUT_H_MEDIUM_30
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

	-- 楼层输入框
    local lvInput = helper:getInput("输入要前往的楼层", 250, cc.EDITBOX_INPUT_MODE_NUMERIC)
    helper:addSectionLeft(newRow, lvInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 常用楼层下拉
    local data = {{name = "测试层", id = 50000}}
    local textData = helper:getListOfField(data, "name")
    local mapDropDown = helper:getDropDown("常用楼层▼", 160, textData)
    mapDropDown:setOnSelectionChanged(function(obj, idx) lvInput:setText(data[idx].id) end)
    helper:addSectionLeft(newRow, mapDropDown, 10)

    --跳转按钮
    helper:addSectionRight(newRow, helper:getButton("楼层跳转", 150, function() 
        -- 参数检查
        if (not helper:checkInWild()) then return end
        local lv = lvInput:getText()
        if (not lv or lv == "") then helper:noteICO() return end

        -- 执行和成功失败提示
        if (executor:gotoLevel(lv)) then 
            helper:noteLVJ() helper:closeGMUtil(self) else helper:noteUKN() end
    end))

	return newRowLayout
end












-- 仿老版简化属性变化区块 --
GMUtilPanelContents.simpleAttrSectionFunc = function ()
	local newRowLayout = helper:getAutoHeightLayout()

    -- 英雄无敌标签
    helper:addSectionLeft(newRowLayout, helper:getLabel(
        "英雄无敌",
        gmConfig.LAYOUT_H_MEDIUM_30,
        120
    ), gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD + 5)
    -- 英雄无敌开关
    local heroIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- if (not helper:checkInWild()) then obj:setValue(oldNum) return end
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:heroIsGod(b)) then 
            if (b) then helper:noteHIN() else helper:noteHNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local heroIsGod = cc.UserDefault:getInstance():getBoolForKey("HeroIsGod", false)
    heroIsGodSwitch:setValue(heroIsGod and 2 or 1)
    helper:addSectionLeft(newRowLayout, heroIsGodSwitch, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 怪物无敌标签
    helper:addSectionLeft(newRowLayout, helper:getLabel(
        "怪物无敌",
        gmConfig.LAYOUT_H_MEDIUM_30,
        120
    ), 80)
    -- 怪物无敌开关
    local heroIsGodSwitch = helper:getSwitch({"关", "开"}, 130, 1, function(obj, num, oldNum)
        -- 处理参数
        local b = true
        if (num == 1) then b = false elseif(num == 2) then b = true end

        -- 执行和提示
        if (executor:monsterIsGod(b)) then 
            if (b) then helper:noteMIN() else helper:noteMNI() end
        else
            obj:setValue(oldNum)
            helper:noteUKN()
        end
    end)
    local monsterIsGod = cc.UserDefault:getInstance():getBoolForKey("MonsterIsGod", false)
    heroIsGodSwitch:setValue(monsterIsGod and 2 or 1)
    helper:addSectionLeft(newRowLayout, heroIsGodSwitch, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- 增加按钮
    helper:addSectionLeft(newRowLayout, helper:getButton("增加攻击力", 160, function()
    	executor:atkMax()
    end), 60)

    return newRowLayout
end


local function showFontTextCell(text, fontName, width)
    local bg = UI.Layout:create()
    bg:init()
    print("----text---- = ", text, fontName, width)
    local title = UI.Text:create()
    title:init(string.format("检查字体 %s 有没有这些字：", fontName), UI.FONT_STANDARD, 20, UI.FONT_COLOR_219_35_45)
    title:leftUp(10, 5)
    bg:addChild(title)
   
    local showText = UI.Text:create()
    showText:init(text, fontName, 14, UI.FONT_COLOR_41_41_45)
    showText:setWidth(width - 50)
    showText:leftUp(20, 35)
    showText:autoAdapt()
    bg:addChild(showText)

    bg:setSize(width, showText:getContentSize().height + 30)
    return bg
end

local function showFontText(text)
    local rootLayer = cc.LayerColor:create(cc.c4b(255,255,255,250))
    local winSize = cc.Director:getInstance():getWinSize()
    rootLayer:setContentSize(winSize.width - 30, winSize.height - 30)
    rootLayer:setPosition((winSize.width - rootLayer:getContentSize().width) / 2, (winSize.height - rootLayer:getContentSize().height) / 2)
    cc.Director:getInstance():getRunningScene():addChild(rootLayer,100000);
    
    local array = {UI.FONT_BOLD, UI.FONT_STANDARD, UI.FONT_DES, UI.FONT_TITLE}
    local up = 10
    for k, v in ipairs(array) do
        local fontBg = showFontTextCell(text, v, rootLayer:getContentSize().width)
        rootLayer:addChild(fontBg)
        fontBg:leftUp(0, up)
        up = up + fontBg:getContentSize().height + 15
    end

    local button = helper:getButton("关闭", 160, function() 
        rootLayer:removeFromParent()
    end)
    button:rightUp(1, 0)
    rootLayer:addChild(button)
end


-- 检查文字显示是否正常 -- 
GMUtilPanelContents.checkFontTextShow = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("文字显示检查"))
    
     local row2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, row2, 10)

    local textInput = helper:getInput("输入检查文本 或者 多语言ID", 600, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(row2, textInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
   
    helper:addSectionRight(row2, helper:getButton("检查~~!", 200, function() 
        local text = textInput:getText()
        local languageId = tonumber(text)
        if languageId then
            local LanguageManager = require("app.game.LanguageManager")
            text = LanguageManager:getInstance():getLocalString(languageId)
        end
        showFontText(text)
    end))
    return newRowLayout
end

-- 检查Poco组件的可经过路线检查 -- 
GMUtilPanelContents.checkFontTextShow = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("POCO checkCoordReachable"))
    
     local row2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, row2, 10)

    local xInput = helper:getInput("X", 50, cc.EDITBOX_INPUT_MODE_NUMBER)
    helper:addSectionLeft(row2, xInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local yInput = helper:getInput("y", 50, cc.EDITBOX_INPUT_MODE_NUMBER)
    helper:addSectionLeft(row2, yInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local result = helper:getLabel(
        "结果: ",
        gmConfig.LAYOUT_H_MEDIUM_30)
    helper:addSectionLeft(row2, result, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
   
    helper:addSectionRight(row2, helper:getButton("检查~~!", 200, function() 
        local xText = xInput:getText()
        local yText = yInput:getText()

        local COHelper = require("poco.poco.CaveOnlineHelper")
        local testResult = COHelper:checkCoordReachable(tonumber(xText), tonumber(yText))
        result:setText("结果: " .. tostring(testResult))
    end))
    return newRowLayout
end

-- 检查Poco组件的可经过路线检查 -- 
GMUtilPanelContents.animationTestSection = function()
    -- 标题
    local newRowLayout = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, helper:getTitleRow("动画性能测试"))
    
     local row2 = helper:getAutoHeightLayout()
    helper:addSectionUp(newRowLayout, row2, 10)

    local jsonInput = helper:getInput("Json名字(不含.json,多个以;隔开)", 230, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(row2, jsonInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    local atlasInput = helper:getInput("Atlas名字（基本不用配置）", 230, cc.EDITBOX_INPUT_MODE_ANY)
    helper:addSectionLeft(row2, atlasInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- local aniInput = helper:getInput("动画名", 90, cc.EDITBOX_INPUT_MODE_ANY)
    -- helper:addSectionLeft(row2, aniInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)

    -- local amountInput = helper:getInput("数量(默认100)", 170, cc.EDITBOX_INPUT_MODE_NUMBER)
    -- helper:addSectionLeft(row2, amountInput, gmConfig.LAYOUT_INTERACTIVE_LEFT_PAD)
   
    helper:addSectionRight(row2, helper:getButton("测试", 100, function() 
        local atlasText = atlasInput:getText()
        local jsonText = jsonInput:getText()
        -- local aniText = aniInput:getText()
        -- local amountText = amountInput:getText()

        if atlasText == "" then atlasText = nil end
        if jsonText == "" then jsonText = nil end
        -- if aniText == "" then aniText = nil end
        -- if amountText == "" then amountText = nil end

        -- if (not atlasText or not aniText) then
        --     helper:noteICO()
        --     return
        -- end

        if(executor:batchTestAnimationPerformance({jsonName = jsonText, atlasName = atlasText})) then 
            helper:noteLVJ() helper:closeGMUtil() else helper:noteUKN()
        end

        -- if (executor:testAnimationPerformance(atlasText, jsonText, aniText, tonumber(amountText))) then 
        --     helper:noteLVJ() helper:closeGMUtil() else helper:noteUKN() end
        -- end))
    end))
    return newRowLayout
end




return GMUtilPanelContents