local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
local BattleTest = {}

local testType = 0    -- 0 标识关闭  1 标识单个顺序   2 多个随机
local testOneNum = 3  -- 1 秒钟出现得伤害个数



function BattleTest:testAttrChange(addNode)
    local function nextButtonCallback(tag, sender)
        if testType == 0 then
            testType = 1
            sender:setString("单个顺序")
        elseif testType == 1 then
            testType = 2
            sender:setString("多个随机")
        else
            testType = 0
            sender:setString("关闭")
        end
    end

    local nextButton = cc.MenuItemFont:create("点击切换测试模式!")
    nextButton:registerScriptTapHandler(nextButtonCallback)
    -- nextButton:setPosition(cc.p(VisibleRect:center().x,  VisibleRect:center().y - 40))
    
    local menu = cc.Menu:create(nextButton)
    menu:setPosition(cc.p(200,200))
    menu:setAnchorPoint(cc.p(0,0))
    addNode:addChild(menu,10000000)

    local scheduler = cc.Director:getInstance():getScheduler()  
    local schedulerID = nil  
    schedulerID = scheduler:scheduleScriptFunc(function()  
        
        if testType == 0 then
            return
        end

        -- 测试英雄
        local master = MachineManager:getInstance():getMachine()._model:getMaster()
        self:sendCmd(master)

        -- 测试怪物
        local battleField = MachineManager:getInstance():getMachine()._model:getBattleFieldBySpriteID(master:getSpriteID(),nil)
        if  battleField then
            local monster = battleField:getTargetMonster()
            if monster then
               self:sendCmd(monster)
            end
        end

    end,0.75,false) 
end

function BattleTest:sendCmd(role)
    local data = nil
    if testType == 1 then
        data = {
            spriteID = role:getSpriteID(),
            attrChange = self:randowmData(testOneNum)
        }
    elseif testType == 2 then
        data = {
            spriteID = role:getSpriteID(),
            attrChange = self:orderData()
        }
    end

    for k,v in pairs(data.attrChange) do
        data.attrChange[k].sourceSpriteID = role:getSpriteID()
        data.attrChange[k].resultValue = 100
    end


    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_ROLE_ATTR_CHANGE, data)
    SceneManager:getInstance():pushCommand(command)
end

function BattleTest:randowmData(dataNum)
    local ranData = {}
    local allData = self:makeAllData()
    local allNum = #allData
    repeat 
        local index = math.random(1,allNum)
        table.insert(ranData,allData[index])
    until #ranData > dataNum

    for k,v in pairs(ranData) do
        print("k,v=",k,v.changeValue,v.changeType,v.changeReason)
    end 

    return ranData
end

local nowIndex = 1
function BattleTest:orderData()
    local ranData = {}
    local allData = self:makeAllData()
    local allNum = #allData
    nowIndex = nowIndex + 1
    if nowIndex > allNum then
        nowIndex = 1
    end
    table.insert(ranData,allData[nowIndex])

    return ranData
end

function BattleTest:makeAllData()
    return  {
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_TRUE,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_PHYSICAL,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_MAGIC,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_ELEMENTAL,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_TRUE,PublicDefine.ATTR_CHANGE_STYLE.CRIT,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_PHYSICAL,PublicDefine.ATTR_CHANGE_STYLE.CRIT,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_MAGIC,PublicDefine.ATTR_CHANGE_STYLE.CRIT,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_ELEMENTAL,PublicDefine.ATTR_CHANGE_STYLE.BLOCK,nil,nil),  -- 10-23
    },
    {
        changeValue = -math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_ELEMENTAL,PublicDefine.ATTR_CHANGE_STYLE.ABSORPTION,nil,nil),  -- 10-23
    },
    {
        changeValue = math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.exp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.USE_ITEM,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curCoin, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.DAMAGE_ELEMENTAL,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curHp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.USE_ITEM,nil,nil,nil),  -- 10-23
    },
    {
        changeValue = math.random(5,220),
        changeType = PublicDefine.ATTR_TYPE.curMp, 
        changeReason = ToolsUtil:combinationReason(PublicDefine.ATTR_CHANGE_REASON_TYPE.USE_ITEM,nil,nil,nil),  -- 10-23
    }
}
end


return BattleTest
