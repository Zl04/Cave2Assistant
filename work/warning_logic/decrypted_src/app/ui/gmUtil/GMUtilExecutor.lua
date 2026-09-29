--[[
    测试工具 执行模块 2017/11/30
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.game.GameManager"
require "app.game.GameClientMessageManager"
require "app.game.GameLoginManager"
require "app.net.NetInnerSystem"
require "app.net.NetRoleSystem"
require "app.datas.PublicDefine"
require "app.datas.RoleDataManager"
require "app.utils.ToolsUtil"
require "app.config.ConfigManager"
require "utils.FileManager"

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LatSim = require("app.ui.gmUtil.GMUtilLatencySimulator")
local MapHelper = require("app.mapkit.MapHelper")
local proto = require("utils.ProtobufUtil")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明, 素子
local GMUtilExecutor = UI.GMUtilExecutor or class("GMUtilExecutor")
UI.GMUtilExecutor = GMUtilExecutor
---------------------------------------
-- eo 模块初始化 --






-- 数据结构 --
---------------------------------------
-- 添加游戏元素的类型
UI.GMUtilExecutor.GM_ELEMENT_TYPE = {
    GOODS = 1,                  -- 物品
    MONSTER = 2,                -- 怪物
    GOTO_SCENE_LEVEL = 3,       -- 切换楼层 
    UNLOCK_CAVE_MODE_DIFFCULTY = 4, --解锁模式难度
    HERO_IS_GOD = 5,            --英雄是否无敌(不扣血)
    MONSTER_IS_GOD = 6,         --怪物是否无敌(不扣血)
    ALTER_HERO_ATTR = 7,        --修改玩家属性
    FUNCTION_UNLOCK = 8,        --功能解锁
    TRANSFER = 9,               --传送
    COM_TASK = 10,              -- 完成任务
    COM_ACHIEVEMENT = 11,       -- 完成成就
    DROP_TEST = 12,              -- 掉落测试
    HEROCAVE_EVENT = 13,        -- 英雄模式特殊事件修改 (只能在城镇中修改)
    DREAM_SET = 14,              -- 梦镜设置
    ENTER_WORLDBOSS = 15,       -- 世界BOSS
    COMPLATE_HERO_TARGETS = 16,  -- 完成所有玩家目标
    TOGGLE_HERO_GENERAL_ATTACK = 17; -- 切换禁用角色的普攻伤害
    PET_IS_GOD = 18; -- 宠物是否无敌(不扣血)
    MIRACLE_EXP = 19;                       -- 神迹槽经验值
}
---------------------------------------
-- eo 数据结构 --

-- 程序逻辑 --
---------------------------------------


-- 完成目标任务
function GMUtilExecutor:completeAllTargetActivities()
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementGoodsData", {})
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.COMPLATE_HERO_TARGETS, pk, data)
    return true
end

-- 打印人物数据
function GMUtilExecutor:printMasterProps(id)
    -- 如果有ID则只打印ID项
    if (id) then
        local name = PublicDefine.ATTR_TYPE_ID_KEY[id]
        local value = RoleDataManager:getMaster()[name]
        print( string.format("%20s : %s", name, value))
        return true
    end

    -- 根据指针排列键值
    for k,v in pairs(PublicDefine.ATTR_TYPE) do
        local name = k
        local value = RoleDataManager:getMaster()[k]
        print(string.format("%d, %20s : %s", v, name, value))
    end
    return true
end

-- 添加物品功能
function GMUtilExecutor:addGoods(templateID, num)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementGoodsData", {
        templateID = tonumber(templateID),
        num = tonumber(num)         
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.GOODS, pk, data)
    return true
end

-- 添加怪物功能
function GMUtilExecutor:addMonster(templateID, rareLv)
    if SceneManager:getInstance():isInTown() then return false end
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementMonsterData", {
        templateID = tonumber(templateID),
        rareLv = tonumber(rareLv)
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.MONSTER, pk, data)
    return true
end

-- 进入世界BOSS场景
function GMUtilExecutor:enterWorldBoss(sceneID)
    -- if not SceneManager:getInstance():isInTown() then return false end
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.EnterWorldBoss", {
        sceneID = tonumber(sceneID or 0)
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.ENTER_WORLDBOSS, pk, data)
    return true
end

function GMUtilExecutor:changeMiracleData(data)
    -- if not SceneManager:getInstance():isInTown() then return false end
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementMiracleExpData", data)
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.MIRACLE_EXP, pk, data)
    return true
end

function GMUtilExecutor:test()
    Net.NetGoodsSystem:useItemRequest(20050010, nil, RoleDataManager:getMaster():getSpriteID())
end

-- 传送
function GMUtilExecutor:blink(x, y)
    x = tonumber(x)
    y = tonumber(y)
    if (x == nil or y == nil) then return false end

    print("===============GMUtilExecutor:blink, 传送坐标", x, y)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementTransferData", {
        pk = pk,
        x = x,
        y = y
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.TRANSFER, pk, data)
    return true
end

-- 完成所有任务
function GMUtilExecutor:forceCompleteQuests()
    print("===============GMUtilExecutor:forceCompleteQuests")
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementComTaskData", {
        pk = pk
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.COM_TASK, pk, data)
    return true
end

-- 完成成就
function GMUtilExecutor:forceCompleteAchievement(achieveId)
    achieveId = tonumber(achieveId)
    if (achieveId == nil) then return false end

    print("===============GMUtilExecutor:forceCompleteAchievement, 完成成就", achieveId)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementComAchievementData", {
        pk = pk,
        achievementID = achieveId
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.COM_ACHIEVEMENT, pk, data)
    return true
end

-- 掉落测试
function GMUtilExecutor:dropTest(itemId, itemNum)
    itemId= tonumber(itemId)
    itemNum = tonumber(itemNum)
    if (itemId == nil or itemNum == nil) then return false end
    if (itemId < 0 or itemNum > 200 or itemNum < 1) then return false end

    print("===============GMUtilExecutor:dropTest, 掉落测试", itemId, itemNum)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementDropTestData", {
        pk = pk,
        dropID = itemId,
        dropNum = itemNum
    })
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.DROP_TEST, pk, data)
    return true
end

-- 切换楼层
function GMUtilExecutor:gotoLevel(level, mapAffixIDAndLvs, mapAffixNum, eliteAffixIDAndLvs, eliteAffixNum)
    if (SceneManager:getInstance():isInTown()) then return false end
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = {
        lv = tonumber(level)
    }
    if (mapAffixIDAndLvs and mapAffixIDAndLvs ~= "" and
        mapAffixNum and mapAffixNum ~= "") then
        data.mapAffixIDAndLvs = mapAffixIDAndLvs
        data.mapAffixNum = tonumber(mapAffixNum)
    end
    if (eliteAffixIDAndLvs and eliteAffixIDAndLvs ~= "" and 
        eliteAffixNum and eliteAffixNum ~= "") then
        data.eliteAffixIDAndLvs = eliteAffixIDAndLvs
        data.eliteAffixNum = tonumber(eliteAffixNum)
    end
    local message = proto:encode("GMSystem.ElementGoToSceneLevelData", data)
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.GOTO_SCENE_LEVEL, pk, message)
    return true
end

-- 刷新英雄模式词缀
function GMUtilExecutor:refreshHeroMapProps(level, propArr)
    if(not SceneManager:getInstance():isInTown()) then return false end
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = {
        shopLv = tonumber(level),
        schemeIDs = propArr
    }
    local message = proto:encode("GMSystem.ElementHeroCaveEventData", data)
    GameManager:addMapElement(UI.GMUtilExecutor.GM_ELEMENT_TYPE.HEROCAVE_EVENT, pk, message)
    return true
end

-- 更改人物属性
function GMUtilExecutor:changeHeroAttr(attr, num)
    num = tonumber(num)
    GameManager:requestChangeAttribution(UI.GMUtilExecutor.GM_ELEMENT_TYPE.ALTER_HERO_ATTR, attr, num)
    return true
end

-- 所有攻击属性设置为9999
function GMUtilExecutor:atkMax()
    self:changeHeroAttr(PublicDefine.ATTR_TYPE.atkMin, 9999)
    self:changeHeroAttr(PublicDefine.ATTR_TYPE.atkMax, 9999)
    self:changeHeroAttr(PublicDefine.ATTR_TYPE.magicAtkMin, 9999)
    self:changeHeroAttr(PublicDefine.ATTR_TYPE.magicAtkMax, 9999)
    return true
end

-- 英雄无敌
function GMUtilExecutor:heroIsGod(b)
    -- if SceneManager:getInstance():isInTown() then return false end
    GameManager:requestHeroMaxDefense(UI.GMUtilExecutor.GM_ELEMENT_TYPE.HERO_IS_GOD, b)
    cc.UserDefault:getInstance():setBoolForKey("HeroIsGod", b)
    return true
end

-- 怪物无敌
function GMUtilExecutor:monsterIsGod(b)
    -- if SceneManager:getInstance():isInTown() then return false end
    GameManager:requestHeroMaxDefense(UI.GMUtilExecutor.GM_ELEMENT_TYPE.MONSTER_IS_GOD, b)
    cc.UserDefault:getInstance():setBoolForKey("MonsterIsGod", b)
    return true
end

-- 宠物无敌
function GMUtilExecutor:petIsGod(b)
    -- if SceneManager:getInstance():isInTown() then return false end
    GameManager:requestPetMaxDefense(UI.GMUtilExecutor.GM_ELEMENT_TYPE.PET_IS_GOD, b)
    cc.UserDefault:getInstance():setBoolForKey("PetIsGod", b)
    return true
end

-- 英雄无伤害
function GMUtilExecutor:heroIsNewBie(b)
    -- if SceneManager:getInstance():isInTown() then return false end
    GameManager:requestHeroIsNewBie(UI.GMUtilExecutor.GM_ELEMENT_TYPE.TOGGLE_HERO_GENERAL_ATTACK, b)
    cc.UserDefault:getInstance():setBoolForKey("PetIsNewBie", b)
    return true
end

-- 登出游戏
function GMUtilExecutor:logoutGame()
    g_GameLoginManager:loginOutGame()
end

-- -- 改服务器(停止维护)
-- function GMUtilExecutor:switchServer(ip, port, account)
--     assert(type(ip) == "string" or ip == nil)
--     assert(type(port) == "string" or type(port) == "number" or port == nil)
--     assert(type(account) == "string" or account == nil)
--     local helper = require("app.ui.gmUtil.GMUtilHelper")
--     ip = ip or helper:getDefaultServerIP()
--     port = port and tonumber(port) or tonumber(helper:getDefaultServerPort())
--     if (account) then cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, account) end

--     g_GameLoginManager:loginOutGame()
--     Game.Manager:clearScene()
--     Net.NetInnerSystem:connect(Net.MAIN_SERVER, ip, port)
--     return true
-- end

-- 增加经验
function GMUtilExecutor:addExp(num)
    self:addGoods(23040000, tonumber(num))
    return true
end

-- 增加金币
function GMUtilExecutor:addGold(num)
    self:addGoods(23020000, tonumber(num))
    return true
end

-- 增加钻石
function GMUtilExecutor:addDiamond(num)
    self:addGoods(23030000, tonumber(num))
    return true
end

-- 打开关卡选择页面
function GMUtilExecutor:showPageLevelSelect()
    Avalon.MessageCenter:notice(GameMessage.MC_TOWN_SHOW_LEVEL_SELECT, 0, 1)
    return true
end

-- 打开兑换码页面
function GMUtilExecutor:showPageCodeInput()
    UI.TipsLayer:createExchangeTipsTips()
    return true
end

-- 打开成就页面
function GMUtilExecutor:showPageAchievement()
    UI.UIManager.mActivityLayer.showAchievementLayer(UI.UIManager.mActivityLayer)
    return true
end

-- 打开老版本GM工具
function GMUtilExecutor:showLegacyGMUtil()
    UI.UIManager:addTestComponent()
    return true
end

-- 解锁模式和难度
function GMUtilExecutor:unlockModeDiff(modeType, diffType)
    GameManager:requestSelectModeAndDiffcult(UI.GMUtilExecutor.GM_ELEMENT_TYPE.UNLOCK_CAVE_MODE_DIFFCULTY, modeType, diffType)
    return true
end

-- 功能解锁
function GMUtilExecutor:unlockAllFunctions()
    GameManager:requestHeroMaxDefense(UI.GMUtilExecutor.GM_ELEMENT_TYPE.FUNCTION_UNLOCK)
    return true
end

-- 测试分享
function GMUtilExecutor:testShare()
    Net.NetRoleSystem.netShare(1)
    return true
end

-- 测试POST
function GMUtilExecutor:testPost()
    -- local paramTable = {
    --     iap_id = "1001",
    --     num = 1,
    --     account_id = "1003",
    --     player_key = "1004",
    --     channel = 1,
    -- }
    -- local request_func = "request_order"

    local paramTable = {
        id = "13",
        transaction_id = "1005",
        receipt_data = "1003",
         
    }
    local request_func = "request_check"
    local paramJson = json.encode(paramTable)
    local session_start = 10164
    
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    local httpurl = string.format("http://192.168.1.201:8000/%s?params=%s&XDEBUG_SESSION_START=%d",request_func,string.urlencode(paramJson),session_start)
    print("open ",httpurl)
    xhr:open("GET", httpurl)
    
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    -- xhr:setRequestHeader("Authorization", "Bearer")
    local function onReadyStateChanged()
        print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            print(xhr.response)  
            local data = json.decode(xhr.response)          
            dump(data)
        else
            
            print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
        xhr:unregisterScriptHandler()
    end
    xhr:registerScriptHandler(onReadyStateChanged)
    -- local sendParam = json.encode(paramTable)
    -- print("sendParam"..sendParam)
    xhr:send()
    return true
end

-- 收包延迟模拟
function GMUtilExecutor:setRecvDelayOn(isOn, delayBase, delayDelta)
    assert(type(isOn) == "boolean")
    self:setRecvDelay(delayBase, delayDelta)
    LatSim:setRecvOn(isOn)
    return true
end

-- 收包延迟数
function GMUtilExecutor:setRecvDelay(delayBase, delayDelta)
    if (delayBase and delayBase ~= "") then LatSim:setRecvDelayBase(tonumber(delayBase)) end
    if (delayDelta and delayDelta ~= "") then LatSim:setRecvDelayDelta(tonumber(delayDelta)) end
    return true
end

-- 发包延模拟
function GMUtilExecutor:setSendDelayOn(isOn, delayBase, delayDelta)
    assert(type(isOn) == "boolean")
    self:setSendDelay(delayBase, delayDelta)
    LatSim:setSendOn(isOn)
    return true
end

-- 发包延迟数
function GMUtilExecutor:setSendDelay(delayBase, delayDelta)
    if (delayBase and delayBase ~= "") then LatSim:setSendDelayBase(tonumber(delayBase)) end
    if (delayDelta and delayDelta ~= "") then LatSim:setSendDelayDelta(tonumber(delayDelta)) end
    return true
end

-- 显示收包
function GMUtilExecutor:setShowRecvContent(b)
   LatSim:setShowRecvContent(b) 
   return true
end

-- 显示发包
function GMUtilExecutor:setShowSendContent(b)
    LatSim:setShowSendContent(b)
    return true
end

-- 地图显示坐标
function GMUtilExecutor:setShowCordinates(b)
    MapHelper.showDebugCoordinates = b
    MapHelper.showDebugBoundingBox = b
    -- MapHelper.showDebugZOrders = b
    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.GMUtilShowCord, b);
    return true
end

-- 清除本地缓存
function GMUtilExecutor:clearLocalCache()
    Avalon.FileManager:removeDirectory(Avalon.FileManager:getUserDataDirection())
    Avalon.FileManager:createDirectory(Avalon.FileManager:getUserDataDirection())
    Avalon.FileManager:removeDirectory(Avalon.FileManager:getHotfixDirection())
    Avalon.FileManager:createDirectory(Avalon.FileManager:getHotfixDirection())
    return true
end

-- 一键隐藏所有UI
function GMUtilExecutor:setShowAllUI(isShow)
    self:setShowTestUI(isShow)
    self:setShowUI(isShow)
    return true
end

-- 隐藏测试UI
function GMUtilExecutor:setShowTestUI(isShow)
    cc.UserDefault:getInstance():setBoolForKey("GMUTIL_SHOWTESTUI", isShow)
    cc.Director:getInstance():setDisplayStats(isShow)
    if (isShow == false) then self:addUIRestoreButton() end
    return true
end

function GMUtilExecutor:getShowTestUI(addRestoreButton)
    local isShow = cc.UserDefault:getInstance():getBoolForKey("GMUTIL_SHOWTESTUI", CONFIG_SHOW_DEBUG_PANEL)
    if (not isShow and (addRestoreButton == nil or addRestoreButton == true)) then self:addUIRestoreButton() end
    cc.Director:getInstance():setDisplayStats(isShow)
    return isShow
    -- return true
end

-- 隐藏界面UI
function GMUtilExecutor:setShowUI(isShow)
    -- cc.UserDefault:getInstance():setBoolForKey("GMUTIL_SHOWUI", isShow)
    -- if (isShow) then
        -- UI.UIManager.mMainUILayer:show()
    -- else
        -- UI.UIManager.mMainUILayer:hide()
        -- self:addUIRestoreButton()
    -- end
    UI.UIManager:setShowMainUI(isShow)
    return true
end

-- UI回复按钮, 结合上面两个使用
function GMUtilExecutor:addUIRestoreButton()
    local buttonTag = 998
    local button = UI.UIManager:getRootNode():getChildByTag(buttonTag)
    if (not button) then
        button = UI.Component:create()
        button:init()
        -- button:enableDebugDraw()
        button:leftUp(90, 0)
        button:setSize(100, 100)
        button:setTouchEnable(true)
        button:setTag(buttonTag)
        button:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
            if (not self:getShowTestUI()) then
                local helper = require("app.ui.gmUtil.GMUtilHelper")
                helper:showConfirmCancel("是否重新登录加载UI状态喵?(手动切换场景也可以喵)", function()
                    self:logoutGame()
                end)
            end
            self:setShowUI(true)
            self:setShowTestUI(true)
            button:runAction(cc.RemoveSelf:create())
            button = nil
        end)
        UI.UIManager:addToRootNode(button, 100000)
    end
end

-- 打开某个界面
function GMUtilExecutor:openUI(ID, ...)
    if (ID == "公会商店") then
        mvc.send("Open_Panel","GuildShop")
        return true
    end

    Avalon.MessageCenter:notice(noticeNum, ...)
    return true
end

-- 调用notice
function GMUtilExecutor:notice(noticeNum, ...)
    Avalon.MessageCenter:notice(noticeNum, ...)
    return true
end

-- 解锁背包
function GMUtilExecutor:unlockBag(x)
    x = x or 1
    for i=1,x do
        Net.NetGoodsSystem:requestUnlockBagSpace(PublicDefine.PACKET_TYPE.PACKET_BAG)
    end
    return true
end

-- 清除包裹
function GMUtilExecutor:clearBag(goodsType)
    local masterPK = RoleDataManager:getMasterPK()
    if (not masterPK) then return end

    require "app.datas.GoodsDataManager"
    local bagArr = GoodsDataManager:getPackArrForPK(masterPK, PublicDefine.PACKET_TYPE.PACKET_BAG)
    if (goodsType) then
        Net.NetGoodsSystem:deletGoodsRequest(PublicDefine.PACKET_TYPE.PACKET_BAG, bagArr[goodsType])
    else
        for i,v in ipairs(bagArr) do
            Net.NetGoodsSystem:deletGoodsRequest(PublicDefine.PACKET_TYPE.PACKET_BAG, v)
        end
    end

    return true
 end

 -- 一键变成赛亚人
function GMUtilExecutor:saiyanMode()
    local delayAmount = 0
    -- 添加金钱
    self:playOnceWithDelay(function() self:addGold(100000000) end, delayAmount)

    -- 升级
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function() self:addExp(100000000) end, delayAmount)

    -- 添加钻石
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function() self:addDiamond(100000000) end, delayAmount)

    -- 解锁物品栏
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function() self:unlockBag(45) end, delayAmount)

    -- 生成装备
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function()
        local masterLv = RoleDataManager:getMaster():getLevel()
        for k,v in pairs(PublicDefine.EQUIPMENT_TYPE) do
            if (v ~= PublicDefine.EQUIPMENT_TYPE.MAX_EQUIPMENT_TYPE) then
                self:generateRandomEquipAboveLv(masterLv - 5, masterLv, v, 1)
            end
        end
    end, delayAmount)

    -- 解锁功能
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function()
        self:unlockAllFunctions()
    end, delayAmount)
    
    -- 清除解锁提示
    delayAmount = delayAmount + 1
    self:playOnceWithDelay(function()
        self:clearUnlockDisplayQueue()
    end, delayAmount)

    return true
end

function GMUtilExecutor:generateRandomEquipAboveLv(targetLvBottom, targetLvTop, targetEquipType, targetGoodsRare)
    targetLvBottom = targetLvBottom or 1
    targetLvTop = targetLvTop or RoleDataManager:getMaster():getLevel()
    local availEquipList = {}

    local allEquip = Config.Manager:getAllEquipmentConfig()
    for k,v in pairs(allEquip) do
        if (k ~= "size") then
            local equipType = math.modf(v.ID / 10000)
            equipType = equipType % 100
            if ((targetEquipType == equipType or targetEquipType == nil) and 
                v.equipRequireLV >= targetLvBottom and 
                v.equipRequireLV <= targetLvTop and 
                (v.goodsRare >= targetGoodsRare or targetGoodsRare == nil)) 
            then
                table.insert(availEquipList, v)
            end
        end
    end

    local equipNum = #availEquipList
    if (equipNum < 1) then return end

    local randIdx = math.random(1, equipNum)
    local randomGood = availEquipList[randIdx]
    if (not randomGood or not randomGood.ID) then return end
    self:addGoods(randomGood.ID, 1)

    return true
end

function GMUtilExecutor:clearUnlockDisplayQueue()
    require("app.datas.FunctionUnlockManager")
    Game.FunctionUnlockManager:getInstance():clearEventQueue()

    return true
end

function GMUtilExecutor:playOnceWithDelay(cb, delay)
    if (not cb) then return end
    if (self.playOnceWithDelayCounter == nil) then
        self.playOnceWithDelayCounter = 0
    end
    if (self.delayIDList == nil) then
        self.delayIDList = {}
    end
    self.playOnceWithDelayCounter = self.playOnceWithDelayCounter + 1

    local currentCounter = self.playOnceWithDelayCounter
    local delayID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
        if (cb) then cb() end
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.delayIDList[currentCounter])
    end, delay, false)

    self.delayIDList[currentCounter] = delayID
end

function GMUtilExecutor:resetGuideProgress()
    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():resetProgress()
    return true
end

function GMUtilExecutor:setGuideProgressAllFinished(setProgressAllFinished)
    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():setProgressAllFinished(setProgressAllFinished)
    return true
end

function GMUtilExecutor:setDreamProgress(bossIdx, dreamLv)
    bossIdx = tonumber(bossIdx)
    dreamLv = tonumber(dreamLv)
    GameManager:setDreamProgress(UI.GMUtilExecutor.GM_ELEMENT_TYPE.DREAM_SET, bossIdx, dreamLv)
    return true
end

function GMUtilExecutor:generateStarPrayItems()
    
end

function GMUtilExecutor:testAddAllBuffer(PK)
    print("GMUtilExecutor:testAddAllBuffer", PK)
    local buffConfig = require("profiles/commonProfile/ProfileBuff")
    if(buffConfig) then 
        if(PK == nil) then 
            PK = RoleDataManager:getMasterPK()
        end
        for k, v in pairs(buffConfig) do 
            if(type(v) == "table") then 
                self:testAddBufferByID(PK, v.ID)
            end
        end
    end
end

function GMUtilExecutor:testAddBufferByID(PK, buffID)
    print("GMUtilExecutor:testAddBufferByID", PK, buffID)
    local heroData = RoleDataManager:getHeroDataForPK(PK)
    if(heroData == nil) then 
        UI.ScrollBar:createByText("没有找到PK=%d的角色数据", PK)
        return 
    end
    if(testBuffEntityID == nil) then 
        testBuffEntityID = 10000000
    end
    testBuffEntityID = testBuffEntityID + 1

    local data = {
        buffID = buffID,
        entityID = testBuffEntityID,
        targetSpriteID = heroData:getSpriteID(),
        curDuration = 3000,
        overlayNum = 1,
        sourceSpriteID = heroData:getSpriteID()
    }

    local command = Command.ControlCommand:create(true)
    command:initForAddBuff(data, false)
    SceneManager:getInstance():pushCommand(command)
end

function GMUtilExecutor:batchHeroAnimation(wearEquipmentArr)
    -- 读取资源目录下面的所有json文件，并且能够找到对应atlas 的动画做性能测试
    allJsonArr = require("testHeroJson")
    print("batchHeroAnimation start run  num=", #allJsonArr)
    -- 由于有些动画有问题，这里删除有问题的，所以需要重新加入一遍
    local localArr = allJsonArr
    allJsonArr = {}
    for k, v in pairs(localArr) do 
        v.index = k
        table.insert(allJsonArr, v)
    end

    -- 开始组装需要使用的数据
    if(#allJsonArr > 0) then
        self:_runOneAnimationPerformance(1, true, wearEquipmentArr)
    else 
        for k=0,10 do
            print("no run test !!!!!!!")
        end
    end
end

function GMUtilExecutor:batchAllAnimation()
    -- 读取资源目录下面的所有json文件，并且能够找到对应atlas 的动画做性能测试
    allJsonArr = require("testJson")
    print("batchAllAnimation start run  num=", #allJsonArr)
    -- 由于有些动画有问题，这里删除有问题的，所以需要重新加入一遍
    local localArr = allJsonArr
    allJsonArr = {}
    for k, v in pairs(localArr) do 
        v.index = k
        table.insert(allJsonArr, v)
    end

    -- 开始组装需要使用的数据
    if(#allJsonArr > 0) then
        self:_runOneAnimationPerformance(1)
    else 
        for k=0,10 do
            print("no run test !!!!!!!")
        end
    end
end

--[[
    jsonArr: {{jsonName="jsonName", atlasName="可以没有，默认和jsonName一致"}....}
]]
function GMUtilExecutor:batchTestAnimationPerformance(jsonArr, isHero, wearEquipmentArr)
    -- 读取json 文件有哪些动画名字
    print("GMUtilExecutor:batchTestAnimationPerformance")
    -- local fileBase = "map2_bossfloor_di"
    allJsonArr = {}
    if(jsonArr) then 
        local index =1
        for k, v in pairs(jsonArr) do 
            local fileBase = v.jsonName
            local fileBaseAtlas = v.atlasName
            local jsonName = fileBase..".json"
            if(isHero) then 
                local animations = {

                }
                if userData and animations then
                    for k, v in pairs(animations) do 
                        -- 获取单个的动画信息
                        local oneTest = {}
                        oneTest.index = index
                        index = index + 1
                        oneTest.atlasName = fileBase
                        oneTest.jsonName = fileBase
                        if(fileBaseAtlas) then
                            oneTest.atlasName = fileBaseAtlas
                        end
                        oneTest.animationName = k
                        table.insert(allJsonArr, oneTest)
                    end
                end
            else
                local jsonString = Avalon.FileManager:readResDataFile(jsonName)
                print("jsonName=", jsonName)
                if (jsonString) then
                    local userData = nil
                    xpcall(function()
                        userData = json.decode(jsonString)
                    end, 
                    function(e) 
                        print(e)
                    end, 1) 
                    if userData and userData.animations then
                        for k, v in pairs(userData.animations) do 
                            -- 获取单个的动画信息
                            local oneTest = {}
                            oneTest.index = index
                            index = index + 1
                            oneTest.atlasName = fileBase
                            oneTest.jsonName = fileBase
                            if(fileBaseAtlas) then
                                oneTest.atlasName = fileBaseAtlas
                            end
                            oneTest.animationName = k
                            table.insert(allJsonArr, oneTest)
                        end
                    end
                end
            end
        end
    end

    -- 开始遍历执行相关的处理逻辑
    if(#allJsonArr > 0) then
        self:_runOneAnimationPerformance(1)
    else 
        for k=0,10 do
            print("no run test !!!!!!!")
        end
    end
end

function GMUtilExecutor:_runOneAnimationPerformance(index, isHero, wearEquipmentArr)
    local startTime = 0.1
    local getCollectTime = 5.1
    local nextTime = 5.3
    local data = allJsonArr[index]
    if(index== 1) then
        local date = os.date("%Y-%m-%d");
        self.runFileName = "spineRunTest."..date.."."..os.time()..".log"
        Avalon.FileManager:writeLogFile(self.runFileName, "local data = {}")
    end

    if(data) then
        self:testAnimationPerformance(data.atlasName, data.jsonName, data.animationName, 100, isHero, wearEquipmentArr)

        performWithDelay(cc.Director:getInstance():getRunningScene(),function()   
            if(avalon.Util.startCollect) then
                avalon.Util:startCollect()
            else 
                UI.ScrollBar:createByText("请打最新的包，如果还不行请联系客户端程序重新编译对应平台的版本")
            end
        end, startTime)

        performWithDelay(cc.Director:getInstance():getRunningScene(),function()  
            if(avalon.Util.getCollect) then
                local collectStr = avalon.Util:getCollect()
                if(collectStr and collectStr ~= "") then 
                    data.collectStr = collectStr
                    -- 把数据写入文件，避免每次重新运行
                    local str = nil
                    for k, v in pairs(data) do 
                        local valueStr = v 
                        if(k ~= "index") then 
                            valueStr = "\""..valueStr.."\""
                        end

                        if(str) then 
                            str = string.format("%s,%s = %s",str, k, valueStr)
                        else
                            str = string.format("%s = %s", k, valueStr)
                        end
                    end
                    Avalon.FileManager:writeLogFile(self.runFileName, string.format("\ndata[%s] = {%s}", data.index, str))
                end
            else 
                UI.ScrollBar:createByText("请打最新的包，如果还不行请联系客户端程序重新编译对应平台的版本")
            end
        end, getCollectTime)

        performWithDelay(cc.Director:getInstance():getRunningScene(),function()  
            self:_runOneAnimationPerformance(index + 1, isHero, wearEquipmentArr);
        end, nextTime)
    else 
        for k=0,10 do
            print("success!!!!!!!!!!!!!!!")
        end

        self:_makeEndTotal(allJsonArr)
    end
end

function GMUtilExecutor:testAnimationPerformance(atlasName, jsonName, animationName, amount, isHero, wearEquipmentArr)
    self._isNetAllow = false
    jsonName = jsonName or atlasName
    amount = amount or 100
    -- if(isHero) then 
    --     amount = 1
    -- end
    local rowNum = math.ceil(math.sqrt(amount))
    local winSize = cc.Director:getInstance():getWinSize()
    local showPadding = 50
    local showWidth = winSize.width - showPadding * 2
    local showHeight = winSize.height - showPadding * 2
    local vStep = showHeight / rowNum
    local hStep = showWidth / rowNum
    local showOffsetX = showPadding
    local showOffsetY = showPadding
    local dirIns = cc.Director:getInstance()
    local runningScene = dirIns:getRunningScene()
    runningScene:removeAllChildren()

    local count = 0
    for i=1,rowNum do
        for j=1,rowNum do
            count = count + 1

            if(isHero) then 
                require "app.renderer.HeroRenderer"
                local renderer = Renderer.HeroRenderer:create()
                local sex = 1
                if jsonName ~= "role_hero_1" then 
                    sex = 2
                end
                renderer:init(jsonName .. ".json", atlasName .. ".atlas", 1, sex, true, 0, 0, false, true)
                renderer:setHeroPK(10001)
                renderer:refreshEquip(wearEquipmentArr)
                self.renderer = renderer
                local flagRight = renderer:getView()
                flagRight:setPosition(showOffsetX + (j - 1) * hStep, showOffsetY + (i - 1) * vStep)
                runningScene:addChild(flagRight, 10000)
                renderer:getRoleAnimation():setAnimation(0, animationName, true)
            else
                local flagRight = UI.Animation:create()
                flagRight:init(jsonName .. ".json", atlasName .. ".atlas", 1);
                flagRight:leftBottom(showOffsetX + (j - 1) * hStep, showOffsetY + (i - 1) * vStep)
                runningScene:addChild(flagRight, 10000)
                flagRight:setAnimation(animationName, true)
            end
            if (count >= amount) then break end
        end
        if (count >= amount) then break end
    end

    local directorInst = cc.Director:getInstance()
    if (directorInst.setDrawcallDisplayFactor) then
        directorInst:setDrawcallDisplayFactor(amount)
    end
end

function GMUtilExecutor:_makeEndTotal(allJsonArr)
    if(allJsonArr == nil) then
        print("allJsonArr  数据为nil.")
        return  
    end
    local arr = allJsonArr
    allJsonArr = {}
    for k, v in pairs(arr) do 
        table.insert(allJsonArr, v)
    end

    -- 对数据进行一个排序
    for k,v in ipairs(allJsonArr) do 
        v.strArr = string.split(v.collectStr, ";")
    end

    table.sort(allJsonArr, function (a, b)
        if(a.strArr[2] ~= b.strArr[2]) then
            if(a.strArr[2] > b.strArr[2]) then 
                return true
            end
        elseif (a.strArr[1] ~= b.strArr[1]) then 
            if (a.strArr[1] > b.strArr[1]) then
                return true 
            end
        elseif (a.strArr[4] ~= b.strArr[4]) then
            if (a.strArr[4] > b.strArr[4]) then 
                return true 
            end
        elseif (a.strArr[3] ~= b.strArr[3]) then 
            if (a.strArr[3] > b.strArr[3]) then 
                return true 
            end
        else
            if(a.index < b.index) then 
                return true 
            else
                return false  
            end
        end

        return false
    end)

    local dirIns = cc.Director:getInstance()
    local runningScene = dirIns:getRunningScene()
    runningScene:removeAllChildren()

    local successNotice = "性能报告已经生成，可以打开和程序一起打开的黑色窗口（console）查找，建议拷贝出来在文本中查看"
    successNotice = successNotice.."或者到目录： ".. Avalon.FileManager:getLogDirection().." 下查找文件如：spineTest.日期.时间戳.log 的文件名字"
    local loadingText = UI.Text:create()
    loadingText:init(successNotice, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_HOTFIX_PROGRESS_TEXT)
    loadingText:center()
    loadingText:setWidth(600)
    runningScene:addChild(loadingText)

    local nowJsonName = nil
    local fileNameLength = 40
    local animationNameLength = 20
    local numLength = 10
    local buffStr = ""
    local formatStr = "%-"..fileNameLength.."."..fileNameLength.."s  %-"..animationNameLength.."."..animationNameLength.."s  %-"..numLength.."."..numLength.."s;%-"..numLength.."."..numLength.."s;%-"..numLength.."."..numLength.."s;%-"..numLength.."."..numLength.."s;"
    local str = string.format(formatStr, "fileName", "animationName", "maxCell", "totalCell", "maxVerts", "verts")
    print(str)
    buffStr = string.format("%s\n%s", buffStr, str)
    for k,v in ipairs(allJsonArr) do 
        -- if(nowJsonName ~= v.jsonName) then 
        --     nowJsonName = v.jsonName
        --     -- 打印标题信息
        --     print(string.format(":::%-20.20s   %-20.20s", v.jsonName, v.atlasName))
        -- end
        local strArr = v.strArr
        local str = string.format(formatStr, v.jsonName, v.animationName, strArr[1], strArr[2], strArr[3], strArr[4])
        print(str)
        buffStr = string.format("%s\n%s", buffStr, str)
    end

    local date = os.date("%Y-%m-%d");
    print("统计日志目录为=", Avalon.FileManager:getLogDirection())
    Avalon.FileManager:writeLogFile("spineTest."..date.."."..os.time()..".log", buffStr)
end

function GMUtilExecutor:isNetAllow()
    if (not CONFIG_SHOW_DEBUG_PANEL) then
        return true
    end
    if (self._isNetAllow == nil) then
        return true
    else
        return self._isNetAllow
    end 

end

---------------------------------------
-- eo 程序逻辑 --


-- 数据结构 --
---------------------------------------
---------------------------------------
-- eo 数据结构 --


-- 生命周期 --
---------------------------------------
---------------------------------------
-- eo 生命周期 --


-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --

function GMUtilExecutor:traversedir(path, cb)
    -- local lfs = require "lfs" 
	-- for file in lfs.dir(path) do
	-- 	if file ~= "." and file ~= ".." and file ~= ".DS_Store" then
	-- 		local f = path .. '/' .. file
	-- 		local attr = lfs.attributes(f)
	-- 		if attr.mode == "directory" then
	-- 			self:traversedir(f, cb)
	-- 			cb(f, true)
	-- 		else
	-- 			cb(f)
	-- 		end
	-- 	end
    -- end
    
    -- if not cc.FileUtils:getInstance():isAbsolutePath(path) then 
        -- path = cc.FileUtils:getInstance():fullPathForFilename(path)
    -- end
    local paths = {}
    cc.FileUtils:getInstance():listFilesAsync(path, function(pathArr)
        paths = pathArr
    end)
    for i, v in ipairs(paths) do 
        if i == 0 or i==1 or i == 2 then 
        else 
            if cc.FileUtils:getInstance():isDirectoryExist(v) then 
                self:traversedir(v, cb)
                cb(f, true)
            else 
                if cc.FileUtils:getInstance():isFileExist(v) then 
                    -- print("path =", v)
                    cb(f)
                end
            end
        end
    end
end

function GMUtilExecutor:pathinfo(path)
	local pos = string.len(path)
	local extpos = pos + 1
	while pos > 0 do
		local b = string.byte(path, pos)
		if b == 46 then -- 46 = char "."
			extpos = pos
		elseif b == 47 then -- 47 = char "/"
			break
		end
		pos = pos - 1
	end

	local dirname = string.sub(path, 1, pos)
	local filename = string.sub(path, pos + 1)
	extpos = extpos - pos
	local basename = string.sub(filename, 1, extpos - 1)
	local extname = string.sub(filename, extpos)
	return {
		dirname = dirname,
		filename = filename,
		basename = basename,
		extname = extname
	}
end


return GMUtilExecutor