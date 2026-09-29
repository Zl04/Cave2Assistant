-- PetPVPEndLayer.lua
-- Author:ydli
-- 2020年4月27日
-- Using:宠物战斗结束界面
local winSize = cc.Director:getInstance():getWinSize()



UI = UI or {}

local PetPVPEndLayer = class("PetPVPEndLayer", UI.Component)
UI.PetPVPEndLayer = PetPVPEndLayer

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_pet_pvp.plist",
    "ui_town_greatnavigation.plist",
}

--构造函数(必备)
function PetPVPEndLayer:ctor(data)
    print("PetPVPEndLayer:ctor")

    --窗口大小
    PetPVPEndLayer.super.ctor(self,UIType.MAIN_UI_LAYER, COM_RES_LIST, winSize.width, winSize.height)
    self:init(data);
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function PetPVPEndLayer:dtor()
    PetPVPEndLayer.super.dtor(self)
    self:unRegisterListener();
    reload_script_file("app.ui.PetPVPEndLayer")
end

-- 初始化(必备)
function PetPVPEndLayer:init(data)
    self.isWin = data.isWin
    self.data = data
    self.pets = {}
    for k, v in ipairs(data.petStatistics) do
        local tempdata = {}
        tempdata.role = RoleDataManager:getRoleDataBySpriteID(v.spriteid, true)
        tempdata.attackHp = v.attackHp
        tempdata.recoverHp = v.recoverHp
        tempdata.staticCurHp = v.curHp
        tempdata.staticMaxHp = v.maxHp

        if v.petTempleteId then
            -- 走的是大航海的宠物战斗逻辑
            tempdata.bigSailPets = {}
            tempdata.bigSailPets.petTempleteId = v.petTempleteId
            tempdata.bigSailPets.isvariant = v.isvariant
        end

        table.insert(self.pets, tempdata)
    end

    local fightBigSailTimes = mvc.bigSailIslandModel:getExpelEndNum()
    if fightBigSailTimes > 0 then
        self.pets.otherSuppy = data.otherSuppy
        self.pets.mySupply = data.mySupply
    end

    PetPVPEndLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function PetPVPEndLayer:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,240))
    colorLayer:setPosition(0, 0)
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1) 

    local animation = UI.Animation:create()
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()
    if self.isWin then
        local spineName = isInport and "effect_ui_navigation_pet_duizhan_victory" or "effect_ui_town_pet_duizhan_victory"
        animation:init(spineName..".json", spineName..".atlas", 1);
    else
        local spineName = isInport and "effect_ui_navigation_pet_duizhan_fail" or "effect_ui_town_pet_duizhan_fail"
        animation:init(spineName..".json", spineName..".atlas", 1);
    end
    animation:center()
    if not mvc.bigSailPortModel:getEndPvpIsMonster() then
        animation:setAnimation("begin", false)
    else
        animation:setAnimation("begin2", false)
    end
    self:addChild(animation, 100)
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
        if not tolua.isnull(animation) then
            if (event.animation == "begin") then
                animation:addAnimation("idle", true)
            elseif (event.animation == "begin2") then
                animation:addAnimation("idle2", true)
            end
        end
    end)

    local title = UI.Text:create()
    if self.isWin then
        title:init(UI.TEXT_1213447, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, {r = 245, g = 223, b = 114})
    else
        title:init(UI.TEXT_1212268, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, {r = 190, g = 190, b = 190})
    end
    title:center()
    title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    animation:addComponent("box-victory", title, true)

    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(winSize.width, 390)
    panel:centerBottom(-195)
    if self.isWin then
        animation:addComponent("zhongdian", panel, true)
    else
        animation:addComponent("zhongxin", panel, true)
    end

    local subTitleBg1 = UI.Image:create()
    subTitleBg1:init("ui_general_pvp_titlebg_1.png")
    subTitleBg1:leftUp(winSize.width / 2 - 434, 46)
    panel:addChild(subTitleBg1)

    local subTitle1 = UI.Text:create()
    if self.isWin then
        subTitle1:init(UI.TEXT_1213964, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 140, g = 171, b = 233})
    else
        subTitle1:init(UI.TEXT_1213964, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 156, g = 156, b = 232})
    end
    subTitle1:center(0, -2)
    subTitleBg1:addChild(subTitle1, 10)

    local subTitleBg2 = UI.Image:create()
    subTitleBg2:init("ui_general_pvp_titlebg_2.png")
    subTitleBg2:leftUp(winSize.width / 2 + 180, 46)
    panel:addChild(subTitleBg2)

    local subTitle2 = UI.Text:create()
    if self.isWin then
        subTitle2:init(UI.TEXT_1213965, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 235, g = 121, b = 121})
    else
        subTitle2:init(UI.TEXT_1213965, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 235, g = 121, b = 121})
    end
    subTitle2:center(0, -2)
    subTitleBg2:addChild(subTitle2, 10)

    --detailpanel
    for i = 1, 3 do
        local headPanel = self:createDetail(true, self.pets[i])
        headPanel:leftUp((winSize.width / 2 - 175 * 3 - 25) + 175 * (i - 1), 90)
        panel:addChild(headPanel)
    end

    for i = 1, 3 do
        if self.pets[3 + i] then
            local headPanel = self:createDetail(false, self.pets[3 + i])
            headPanel:leftUp((winSize.width / 2 + 67) + 175 * (i - 1), 90)
            panel:addChild(headPanel)
        end
    end

    --attrName1
    local attrName1 = UI.Text:create()
    if self.isWin then
        attrName1:init(UI.TEXT_1213966, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 245, g = 223, b = 114})
    else
        attrName1:init(UI.TEXT_1213966, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 190, g = 190, b = 190})
    end

    
    attrName1:centerUp(281)
    panel:addChild(attrName1, 10)

    local attrName2 = UI.Text:create()
    if self.isWin then
        attrName2:init(UI.TEXT_1213967, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 245, g = 223, b = 114})
    else
        attrName2:init(UI.TEXT_1213967, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 190, g = 190, b = 190})
    end
    attrName2:centerUp(333)
    panel:addChild(attrName2, 10)

    ------
    local monsterPic = UI.Image:create()
    monsterPic:init("ui_greatnavigation_battlebg_all.png")
    monsterPic:center(3, 0)
    animation:addComponent("anniu", monsterPic, true)

    --btn and info
    local leaveBtn = UI.Button:create()
    leaveBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    leaveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local data = nil
        local SceneManager = require("app.game.SceneManager")
        local isInport = SceneManager:getInstance():isInPort()
        local len = table.nums(self.pets)
        if isInport and len >= 6 then
            -- 大航海驱逐界面提示
            local expelBaseData = mvc.bigSailIslandModel:getExpelSettleData()
            local myCostNum, enemyCostNum
            local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
            local winExpend = config.victorySupplyConsume -- 胜利消耗补给
            local failExpend = config.defaultSupplyConsume -- 失败消耗补给

            local myPower = expelBaseData.myPower -- 战斗开始前我方的战斗力
            local otherPower = expelBaseData.otherPower -- 战斗开始前敌人的战斗力

            local isRate,needNum,needNum2 = mvc.bigSailIslandModel:getConsumptionRate(otherPower,myPower)
            if isRate then
                failExpend = needNum
                winExpend = needNum2
            end

            if self.isWin then
                myCostNum, enemyCostNum = winExpend, failExpend
            else
                myCostNum, enemyCostNum = failExpend, winExpend 
            end
            -- print("self.pets111--->: ", self.pets)
            -- print("self.2222--->: ", expelBaseData)
            local mySupply = 0
            local enemySupply = 0
            if not mvc.bigSailPortModel:getEndPvpIsMonster() then
                mySupply = self.pets.mySupply and self.pets.mySupply or expelBaseData.mysupply - myCostNum
                enemySupply = self.pets.otherSuppy and self.pets.otherSuppy or (expelBaseData.othersuppy - enemyCostNum)
            else
                mySupply = 1
                enemySupply = 1
                --local data = {info = {islandid = 2, monsterids = {1, 2}}
                --mvc.bigSailPortModel:updateMonsterInfos(data)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
                mvc.bigSailPortModel:setEndPvpIsMonster(false)
            end
            -- 显示当补给剩余为0时，有提示
            data = {}
            data.mySupply = mySupply
            data.enemySupply = enemySupply
        end
        self:close()
        local SceneManager = require("app.game.SceneManager")
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_END_PET_PVP, data)
        SceneManager:getInstance():pushCommand(command)
    end)
    leaveBtn:center(3, 0)
    animation:addComponent("anniu", leaveBtn, true)

    local btnTips = UI.Text:create()
    btnTips:init(UI.TEXT_1213433, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btnTips:center()
    leaveBtn:addChild(btnTips, 10)

    ----------------------------------------------
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()
    local len = table.nums(self.pets)
    if isInport and len >= 6 then
        -- 在大航海的场景中的战斗结算界面
        local supplyPannel = UI.Layout:create()
        supplyPannel:init()
        supplyPannel:setSize(winSize.width, 125)
        supplyPannel:centerBottom(-120)
        panel:addChild(supplyPannel, 99)

        local height = self.isWin and 12 or 0
        local myTitle = UI.Text:create()
        myTitle:init(UI.TEXT_1213449, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45 )
        myTitle:leftUp(70, height)
        supplyPannel:addChild(myTitle, 10)

        local enemyTitle = UI.Text:create()
        enemyTitle:init(UI.TEXT_1213450, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45 )
        enemyTitle:rightUp(70, height)
        supplyPannel:addChild(enemyTitle, 10)

        local myCostBg = UI.Image.create()
        myCostBg:init("ui_greatnavigation_battlebg_blue.png")
        myCostBg:center(-320, 10)
        supplyPannel:addChild(myCostBg)

        local enemyCostBg = UI.Image.create()
        enemyCostBg:init("ui_greatnavigation_battlebg_red.png")
        enemyCostBg:center(320, 10)
        supplyPannel:addChild(enemyCostBg)
        -- getExpelBaseData
        -- local expelBaseData = mvc.bigSailIslandModel:getExpelSettleData()
        local expelBaseData = self.data
        local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
        local winExpend = config.victorySupplyConsume -- 胜利消耗补给
        local failExpend = config.defaultSupplyConsume -- 失败消耗补给

        local myPower = expelBaseData.myPower -- 战斗开始前我方的战斗力
        local otherPower = expelBaseData.otherPower -- 战斗开始前敌人的战斗力

        local isRate,needNum,needNum2 = mvc.bigSailIslandModel:getConsumptionRate(otherPower,myPower)
        if isRate then
            failExpend = needNum
            winExpend = needNum2
        end

        local myCostNum, enemyCostNum
        if self.isWin then
            myCostNum, enemyCostNum = winExpend, failExpend
        else
            myCostNum, enemyCostNum = failExpend, winExpend 
        end

        
        --print("self.pets.mySupply--->: ", self.pets.mySupply)
        if not mvc.bigSailPortModel:getEndPvpIsMonster() then
            local mySupplyCost = UI.Text:create()
            mySupplyCost:init(string.format(UI.TEXT_226217, myCostNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 156, g = 156, b = 232})
            mySupplyCost:centerLeft(20, 0)
            myCostBg:addChild(mySupplyCost, 10)

            local mySupplyLeft = UI.Text:create()
            mySupplyLeft:init(string.format(UI.TEXT_226142, myCostNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 156, g = 156, b = 232})
            mySupplyLeft:centerLeft(120, 0)
            myCostBg:addChild(mySupplyLeft, 10)

            local goodsData = GoodsDataManager:createLocalGoodsData(23460001)--GoodsDataManager:getVirtualGoodsDataByGoodsID(23460001)
            local supplyPic = UI.Image:create()
            supplyPic:init(goodsData.icon)
            supplyPic:centerLeft(150, 0)
            myCostBg:addChild(supplyPic)

            local supplyNum = self.pets.mySupply and self.pets.mySupply or (expelBaseData.mysupply - myCostNum)
            local mySupplyLeftNum = UI.Text:create()
            mySupplyLeftNum:init(tostring(supplyNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 156, g = 156, b = 232})
            mySupplyLeftNum:centerLeft(230, 0)
            myCostBg:addChild(mySupplyLeftNum, 10)

            local enemySupplyCost = UI.Text:create()
            enemySupplyCost:init(string.format(UI.TEXT_226217, enemyCostNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 235, g = 121, b = 121})
            enemySupplyCost:centerLeft(20, 0)
            enemyCostBg:addChild(enemySupplyCost, 10)

            local enemySupplyLeft = UI.Text:create()
            enemySupplyLeft:init(string.format(UI.TEXT_226142, enemyCostNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 235, g = 121, b = 121})
            enemySupplyLeft:centerLeft(120, 0)
            enemyCostBg:addChild(enemySupplyLeft, 10)

            local supplyPic = UI.Image:create()
            supplyPic:init(goodsData.icon)
            supplyPic:centerLeft(150, 0)
            enemyCostBg:addChild(supplyPic)

            local enemyNum = self.pets.otherSuppy and self.pets.otherSuppy or (expelBaseData.othersuppy - enemyCostNum)
            local enemySupplyLeftNum = UI.Text:create()
            enemySupplyLeftNum:init(tostring(enemyNum), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 235, g = 121, b = 121})
            enemySupplyLeftNum:centerLeft(230, 0)
            enemyCostBg:addChild(enemySupplyLeftNum, 10)
            monsterPic:setVisible(false)
        else
            myTitle:setVisible(false)
            enemyTitle:setVisible(false)
            myCostBg:setVisible(false)
            enemyCostBg:setVisible(false)
            monsterPic:setVisible(true)
            leaveBtn:center(3, 22)

            local monsterData = mvc.bigSailPortModel:getMonsterBattleData()
            local monsterConfig = ConfigManager:getIslandMonsterByID(monsterData.monsterid)

            local configActivity = ConfigManager:getAllNavigationGeneralConfigData()[1]
            local costNum = configActivity.activityfailSupConsumption
            if self.isWin then
                costNum = configActivity.activityVictSupConsumption
            end
            -- 消耗补给品
            local costSupplyNum = UI.Text:create()
            costSupplyNum:init(UI.TEXT_226141..tostring(costNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 224, g = 204, b = 104})
            costSupplyNum:centerLeft(180, -13)
            monsterPic:addChild(costSupplyNum)

            -- 剩余
            local mySupplyNum = UI.Text:create()
            mySupplyNum:init(UI.TEXT_226142, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 224, g = 204, b = 104})
            mySupplyNum:centerLeft(330, -13)
            monsterPic:addChild(mySupplyNum)

            local mySupplyNumBg = UI.Image.create()
            mySupplyNumBg:init("ui_greatnavigation_supply2.png")
            mySupplyNumBg:centerLeft(385, -13)
            monsterPic:addChild(mySupplyNumBg)

            local mySupplyNum2 = UI.Text:create()
            mySupplyNum2:init(tostring(monsterData.curSupply - costNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 224, g = 204, b = 104})
            mySupplyNum2:centerLeft(48, 0)
            mySupplyNum2:setTextLeft()
            mySupplyNumBg:addChild(mySupplyNum2)

            -- 岛怪币
            local goodsData = ConfigManager:getVirtualItemConfigByID(monsterConfig.itemId)
            local monsterCoinPic = UI.Image:create()
            monsterCoinPic:init(goodsData.miniIcon)
            monsterCoinPic:centerLeft(530, -13)
            monsterPic:addChild(monsterCoinPic)

            local monsterCoinNums = self.isWin and monsterConfig.itemNum or 0
            local monsterCoinTxt = UI.Text:create()
            monsterCoinTxt:init("+"..tostring(monsterCoinNums), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 224, g = 204, b = 104})
            monsterCoinTxt:centerLeft(40, 0)
            monsterCoinTxt:setTextLeft()
            monsterCoinPic:addChild(monsterCoinTxt)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST)
        end
    end
end

function PetPVPEndLayer:createDetail(isSelf, data)
     local panel = UI.Layout:create()
    panel:init()
    panel:setSize(132, 132)

    local bg = UI.Image:create()
    if isSelf then
        bg:init("ui_general_pvp_pethead_box_1_0.png")
    else
        bg:init("ui_general_pvp_pethead_box_2_0.png")
    end
    bg:center()
    panel:addChild(bg)

    if data.role then
        local head = UI.Image:create()
        head:init(data.role:getIcon())
        head:leftBottom(24, 28)
        bg:addChild(head, 5)
        if data.staticCurHp <= 0 then 
            head:useShader(UI.COMPONENT_GRAY_SHADER)
        end
    else
        local str = ""
        if data.bigSailPets then
            local config = ConfigManager:getPetDataByID(data.bigSailPets.petTempleteId)
            local iconStr = ""
            local strs = string.split(config.icon, ";")
            if data.bigSailPets.isvariant then
                iconStr = strs[2]
            else
                iconStr = strs[1]
            end
            str = iconStr..".png"
        end
        local head = UI.Image:create()
        head:init(str)
        head:leftBottom(24, 28)
        bg:addChild(head, 5)
        if data.staticCurHp <= 0 then 
            head:useShader(UI.COMPONENT_GRAY_SHADER)
        end
    end

    local board = UI.Image:create()
    if isSelf then
        board:init("ui_general_pvp_pethead_box_1_1.png")
    else
        board:init("ui_general_pvp_pethead_box_2_1.png")
    end
    board:center()
    panel:addChild(board, 10)

    local boodBar = UI.ProgressTimer:create()
    if isSelf then
        boodBar:init("ui_general_pvp_blood_pet_0.png", nil, "ui_general_pvp_blood_pet_1_1.png")
    else
        boodBar:init("ui_general_pvp_blood_pet_0.png", nil, "ui_general_pvp_blood_pet_2_1.png")
    end
    boodBar:setAnchorPoint(0.5, 0.5)
    boodBar:centerUp(130)
    panel:addChild(boodBar)
    local percent = (data.staticCurHp or 0) / (data.staticMaxHp or 1)
    percent = percent > 1 and 1 or percent
    boodBar:setPercent(percent)

    local attackNumber = UI.NumberText:create(data.attackHp, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 140, g = 171, b = 233}, 10)
    if isSelf then
        if self.isWin then
            attackNumber:setFontColor({r = 140, g = 171, b = 233})
        else
            attackNumber:setFontColor({r = 156, g = 156, b = 232})
        end
    else
        attackNumber:setFontColor({r = 235, g = 121, b = 121})
    end
    attackNumber:setTextCenter()
    attackNumber:centerUp(190)
    panel:addChild(attackNumber, 4)

    local recoverNumber = UI.NumberText:create(data.recoverHp, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 140, g = 171, b = 233}, 10)
    if isSelf then
        if self.isWin then
            recoverNumber:setFontColor({r = 140, g = 171, b = 233})
        else
            recoverNumber:setFontColor({r = 156, g = 156, b = 232})
        end
    else
        recoverNumber:setFontColor({r = 235, g = 121, b = 121})
    end

    recoverNumber:setTextCenter()
    recoverNumber:setWidth(90)
    recoverNumber:centerUp(245)
    panel:addChild(recoverNumber, 4)

    return panel
end
-- 注册监听事件(可选)
function PetPVPEndLayer:showLayer(data)

end

-- 注册监听事件(可选)
function PetPVPEndLayer:registerListener()
    -- Avalon.MessageCenter:bind(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self, self.openControlPadTracking)
end

-- 注销监听事件(可选)
function PetPVPEndLayer:unRegisterListener()
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self, self.openControlPadTracking)
end



