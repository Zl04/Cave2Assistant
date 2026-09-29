--[[
    测试工具
]]

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local proto = require "utils.ProtobufUtil"
require "app.datas.PublicDefine"
require("app.ui.test.DropDownList")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}
local TestUtilLayer = class("TestUtilLayer", UI.HWBtnComponent)
UI.TestUtilLayer = TestUtilLayer

local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
     "ui_package_log.plist",
     "ui_package.plist",
     
}
-- 图片名字
local TEST_PANEL_SPRITE = {
    BACKGROUND_CONTENT = "ui_package_banner_context.png",
    EDITE_NORMAL = "ui_btn_button1_1.png",
    BUTTON_END_NORMAL = "ui_btn_button_commonly_0.png",
    BUTTON_END_ACTIVE = "ui_btn_button_commonly_1.png"
}
-- 添加游戏元素的类型
local GM_ELEMENT_TYPE = {
	GOODS = 1,			    -- 物品
	MONSTER = 2,      	    -- 怪物
    GOTO_SCENE_LEVEL = 3,    -- 切换楼层 
    UNLOCK_CAVE_MODE_DIFFCULTY = 4, --解锁模式难度
    HERO_IS_GOD = 5,            --英雄是否无敌(不扣血)
    MONSTER_IS_GOD = 6,         --怪物是否无敌(不扣血)
    ALTER_HERO_ATTR = 7,        --修改玩家属性
    FUNCTION_UNLOCK = 8,        --功能解锁
    TRANSFER = 9;                           -- 英雄当前场景传送
    COM_TASK = 10;                          -- 完成任务
    COM_ACHIEVEMENT = 11;                   -- 完成成就
    DROP_TEST = 12;                         -- 掉落测试
    HEROCAVE_EVENT = 13;                    -- 英雄模式特殊事件修改 (只能在城镇中修改)
    DREAM_SET = 14;                         -- 梦镜设置
    ENTER_WORLDBOSS = 15;                   -- 进入世界Boss副本
    COMPLATE_HERO_TARGETS = 16;             -- 完成所有玩家目标
    TOGGLE_HERO_GENERAL_ATTACK = 17;        -- 切换禁用角色的普攻伤害
    PET_IS_GOD = 18;                        -- 宠物是否无敌(不扣血)
    MIRACLE_EXP = 19;                       -- 神迹槽经验值
}

-- 添加物品功能
local function addGoods(self, templateID, num)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementGoodsData", {
        templateID = tonumber(templateID),
        num = tonumber(num)
    })
    GameManager:addMapElement(GM_ELEMENT_TYPE.GOODS, pk, data)
end

-- 添加怪物功能
local function addMonster(self, templateID, rareLv)
    local pk = GameDataManager:getInstance():getMasterPK()
    local data = proto:encode("GMSystem.ElementMonsterData", {
        templateID = tonumber(templateID),
        rareLv = tonumber(rareLv)
    })
    GameManager:addMapElement(GM_ELEMENT_TYPE.MONSTER, pk, data)
end

-- 切换楼层
local function gotoLevel(self, level, mapAffixIDAndLvs, mapAffixNum, eliteAffixIDAndLvs, eliteAffixNum)
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
    GameManager:addMapElement(GM_ELEMENT_TYPE.GOTO_SCENE_LEVEL, pk, message)
end

function TestUtilLayer:ctor()
    TestUtilLayer.super.ctor(self, UIType.TEST_UTIL_LAYER, COM_RES_LIST, 1024, 640)

    self._currentSectionHeight = 0
    self._layout = nil
end

function TestUtilLayer:init()
    TestUtilLayer.super.init(self)
end

function TestUtilLayer:onInitView()
    local bgContent = UI.Image:create()
    bgContent:init(TEST_PANEL_SPRITE.BACKGROUND_CONTENT)
    bgContent:leftBottom(-15, 0)
    self:addChild(bgContent)

    local title = UI.Text:create()
    title:init("GM 测试工具", UI.ARIAL, 40, UI.FONT_COLOR_255_222_82)
    title:centerUp(0)
    self:addChild(title)

    local id = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify, "no account")
    local idText = UI.Text:create()
    idText:init(id, UI.ARIAL, 30, UI.FONT_COLOR_247_245_232)
    idText:leftUp(5, 10)
    self:addChild(idText)
    self._idText = idText

    local closeButton = UI.Button:create()
    closeButton:init()
    closeButton:setSize(50, 50)
    closeButton:setText("X")
    closeButton:setTextFont(UI.FONT_ARIAL, 50, UI.FONT_COLOR_RED)
    closeButton:rightUp(20, 5)
    closeButton:enableDebugDraw(UI.WHITE)
    closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(btn)
        self:close()
    end)
    self:addChild(closeButton)



    local closeButton = UI.Button:create()
    closeButton:init()
    closeButton:setSize(50, 50)
    closeButton:setText("关卡选择")
    closeButton:setTextFont(UI.FONT_ARIAL, 20, UI.FONT_COLOR_RED)
    closeButton:rightUp(120, 5)
    closeButton:enableDebugDraw(UI.WHITE)
    closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(btn)
        Avalon.MessageCenter:notice(GameMessage.MC_TOWN_SHOW_LEVEL_SELECT, 0, 1)
        self:close()
    end)
    self:addChild(closeButton)




    local closeButton = UI.Button:create()
    closeButton:init()
    closeButton:setSize(50, 50)
    closeButton:setText("输入框")
    closeButton:setTextFont(UI.FONT_ARIAL, 20, UI.FONT_COLOR_RED)
    closeButton:rightUp(220, 5)
    closeButton:enableDebugDraw(UI.WHITE)
    closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(btn)
        -- UI.Tips:createTips("兑换码",UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.EDITBOX)
        -- UI.LoadingPanel:show()
        self:close()

        
        UI.TipsLayer:createExchangeTipsTips()

    end)
    self:addChild(closeButton)

    
    local closeButton = UI.Button:create()
    closeButton:init()
    closeButton:setSize(50, 50)
    closeButton:setText("成就")
    closeButton:setTextFont(UI.FONT_ARIAL, 20, UI.FONT_COLOR_RED)
    closeButton:rightUp(320, 5)
    closeButton:enableDebugDraw(UI.WHITE)
    closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(btn)
        UI.UIManager.mActivityLayer.showAchievementLayer(UI.UIManager.mActivityLayer)
        self:close()
    end)
    self:addChild(closeButton)


    -- 运营获得入口
    local activityButton = UI.Button:create()
    activityButton:init()
    activityButton:setSize(50, 50)
    activityButton:setText("活动")
    activityButton:setTextFont(UI.FONT_ARIAL, 20, UI.FONT_COLOR_RED)
    activityButton:rightUp(420, 5)
    activityButton:enableDebugDraw(UI.WHITE)
    activityButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(btn)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_ACTIVITY_PANEL)
        self:close()
    end)
    self:addChild(activityButton)




    local scrollView = UI.ScrollView:create()
    scrollView:init(5, 5, 0, 0)
    scrollView:setSize(1024, 540)
    scrollView:leftUp(50, 70)
    self:addChild(scrollView)

    local layout = UI.Layout:create()
    layout:init(0, 0, 0, 0)
    -- layout:enableDebugDraw(UI.RED)
    scrollView:addInnerNode(layout)
    self._layout = layout
    

    self.validAttrList = self:getValidAttrList()
    -- dump(self.validAttrList, "self.validAttrList")
    self:addSection(self:createSection_floor())
    self:addSection(self:createSection_addExp())
    self:addSection(self:createSection_addCoin())
    self:addSection(self:createSection_addDiamond())
    self:addSection(self:createSection_addGoods())
    self:addSection(self:createChange_SelfMaxDefense())
    -- self:addSection(self:createChange_MonsterMaxDefense())
    self:addSection(self:createSection_addMonster())
    self:addSection(self:createSection_connect())
    self:addSection(self:createSection_account())
    self:addSection(self:createSection_Mode_diffculty())

    self:addSection(self:createChange_Attributtion())  
    self:addSection(self:createChange_AllLockFunc())    
    self:addSection(self:createTestShare()) 
    self:addSection(self:createTestPOST()) 
end

function TestUtilLayer:getValidAttrList(validType)
    local attrAllList = GameManager:getAttrList()
    local validList = {}
    for key, value in ipairs(attrAllList) do
        if value.type == PublicDefine.ATTR_TYPE.atkMin then
            value.name = "攻击力"
        end
        if value.type == PublicDefine.ATTR_TYPE.magicAtkMin then
            value.name = "魔法攻击力"
        end
        if (value.type ~= PublicDefine.ATTR_TYPE.atkMax and value.type ~= PublicDefine.ATTR_TYPE.roleLV and value.type ~= PublicDefine.ATTR_TYPE.curCoin 
            and value.type ~= PublicDefine.ATTR_TYPE.magicAtkMax) then
            table.insert(validList, value)
        end
    end
    return validList
end

function TestUtilLayer:addSection(sectionLayout)
    if (sectionLayout) then
        sectionLayout:leftUp(0, self._currentSectionHeight)
        sectionLayout:enableDebugDraw(UI.WHITE)
        sectionLayout:setPadding(5, 0, 0, 0)
        self._layout:addComponent(sectionLayout)
    
        local width, height = sectionLayout:getSize()
        self._currentSectionHeight = self._currentSectionHeight + height
        self._layout:setSize(winSize.width - 60, self._currentSectionHeight)
    end
end

-- 楼层跳转功能
function TestUtilLayer:createSection_floor()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(960, 180)

    local gotoTile = UI.Text:create()
    gotoTile:init("楼层跳转：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    gotoTile:leftUp(0, 15)
    layout:addComponent(gotoTile)

    local gotoEdit = UI.EditBox:create(190, 40)
    gotoEdit:init("输入楼层ID", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    gotoEdit:leftUp(150, 10)
    layout:addComponent(gotoEdit)

    local des1 = UI.Text:create()
    des1:init("地图词缀库参数：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    des1:leftUp(0, 75)
    layout:addComponent(des1)
    local libIDEdit = UI.EditBox:create(500, 40)
    libIDEdit:init("输入词缀库ID和等级", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    libIDEdit:leftUp(250, 70)
    layout:addComponent(libIDEdit)
    local libIDCountEdit = UI.EditBox:create(190, 40)
    libIDCountEdit:init("输入词缀数量", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    libIDCountEdit:leftUp(760, 70)
    layout:addComponent(libIDCountEdit)

    local des2 = UI.Text:create()
    des2:init("精英词缀库参数：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    des2:leftUp(0, 135)
    layout:addComponent(des2)
    local idEdit = UI.EditBox:create(500, 40)
    idEdit:init("输入词缀库ID和等级", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    idEdit:leftUp(250, 130)
    layout:addComponent(idEdit)
    local idCountEdit = UI.EditBox:create(190, 40)
    idCountEdit:init("输入词缀数量", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    idCountEdit:leftUp(760, 130)
    layout:addComponent(idCountEdit)

    local endBtn = UI.Button:create()
    endBtn:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    endBtn:leftUp(600, 10)
    endBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- if SceneManager:getInstance():isInCave() then
        --     local gotoLevel = gotoEdit:getText()
        --     if (gotoLevel and gotoLevel ~= "") then
        --         local level = tonumber(gotoLevel)
        --         GameManager:testGoToLevel(level)
        --     end
        -- end 
        gotoLevel(self, 
            gotoEdit:getText(),
            libIDEdit:getText(),
            libIDCountEdit:getText(),
            idEdit:getText(),
            idCountEdit:getText()
        )

        self:close()
    end)
    endBtn:setText("完成")
    endBtn:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(endBtn)

    return layout
end

-- 经验
function TestUtilLayer:createSection_addExp()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local title = UI.Text:create()
    title:init("添加经验：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    title:floatLeft(0)
    layout:addComponent(title)

    local editBox = UI.EditBox:create(200, 40)
    editBox:init("请输入经验值", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox:floatLeft(0)
    editBox:setText(1000)
    layout:addComponent(editBox)

    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:floatLeft(0)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        addGoods(self, 23040000, editBox:getText())

        self:close()
    end)
    requestButton:setText("增加")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

-- 金币
function TestUtilLayer:createSection_addCoin()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local title = UI.Text:create()
    title:init("添加金币：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    title:floatLeft(0)
    layout:addComponent(title)

    local editBox = UI.EditBox:create(200, 40)
    editBox:init("请输入金币数量", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox:floatLeft(0)
    editBox:setText(999999)
    layout:addComponent(editBox)

    local increaseButton = UI.Button:create()
    increaseButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    increaseButton:floatLeft(0)
    increaseButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local number = editBox:getText()
        if (number and number ~= "") then
            addGoods(self, 23020000, number)

            self:close()
        end
    end)
    increaseButton:setText("增加")
    increaseButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(increaseButton)

    local decreaseButton = UI.Button:create()
    decreaseButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    decreaseButton:floatLeft(20)
    decreaseButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
       local number = editBox:getText()
        if (number and number ~= "") then
            addGoods(self, 23020000, -1 * tonumber(number))

            self:close()
        end
    end)
    decreaseButton:setText("减少")
    decreaseButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(decreaseButton)

    return layout
end

-- 钻石
function TestUtilLayer:createSection_addDiamond()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local title = UI.Text:create()
    title:init("添加钻石：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    title:floatLeft(0)
    layout:addComponent(title)

    local editBox = UI.EditBox:create(200, 40)
    editBox:init("请输入钻石数量", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox:floatLeft(0)
    editBox:setText(999999)
    layout:addComponent(editBox)

    local increaseButton = UI.Button:create()
    increaseButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    increaseButton:floatLeft(0)
    increaseButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        addGoods(self, 23030000, editBox:getText())

        self:close()
    end)
    increaseButton:setText("增加")
    increaseButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(increaseButton)

    local decreaseButton = UI.Button:create()
    decreaseButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    decreaseButton:floatLeft(20)
    decreaseButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
       local number = editBox:getText()
        if (number and number ~= "") then
            addGoods(self, 23030000, -1 * tonumber(number))

            self:close()
        end
    end)
    decreaseButton:setText("减少")
    decreaseButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(decreaseButton)

    return layout
end

-- 物品
function TestUtilLayer:createSection_addGoods()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 120)

    local title = UI.Text:create()
    title:init("添加物品（道具 装备 材料）：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    title:leftUp(0, 15)
    layout:addComponent(title)

    local editBox_1 = UI.EditBox:create(240, 40)
    editBox_1:init("请输入物品模版ID", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox_1:leftUp(400, 10)
    editBox_1:setText(20050010)
    layout:addComponent(editBox_1)

    local editBox_2 = UI.EditBox:create(200, 40)
    editBox_2:init("请输入物品数量", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox_2:leftUp(650, 10)
    editBox_2:setText(1)
    layout:addComponent(editBox_2)

    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(0, 60)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        addGoods(self, editBox_1:getText(), editBox_2:getText())

        self:close()
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

-- 精英怪
function TestUtilLayer:createSection_addMonster()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 120)

    local title = UI.Text:create()
    title:init("怪物生成：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    title:leftUp(0, 15)
    layout:addComponent(title)

    local editBox_1 = UI.EditBox:create(240, 40)
    editBox_1:init("请输入怪物模版ID", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox_1:leftUp(150, 10)
    layout:addComponent(editBox_1)
    local editBox_3 = UI.EditBox:create(240, 40)
    editBox_3:init("请输入怪物稀有度", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    editBox_3:leftUp(400, 10)
    layout:addComponent(editBox_3)

    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(0, 60)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        addMonster(self, editBox_1:getText(), editBox_3:getText())

        self:close()
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

-- 切换网络连接
function TestUtilLayer:createSection_connect()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local IPText = UI.Text:create()
    IPText:init("切换服务器：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    IPText:leftUp(0, 15)
    layout:addComponent(IPText)

    local IPEditBox = UI.EditBox:create(200, 40)
    local gameLoginManager = require("app.game.GameLoginManager")
    IPEditBox:init(gameLoginManager:getInstance():getServerUrl(), cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    IPEditBox:leftUp(180, 10)
    layout:addComponent(IPEditBox)
    local portEditBox = UI.EditBox:create(200, 40)
    portEditBox:init(tostring(AVALON_LOGIN_PORT), cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    portEditBox:leftUp(400, 10)
    layout:addComponent(portEditBox)

    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(650, 5)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local ip = IPEditBox:getText()
        if (ip == "") then
            ip = IPEditBox:getPlaceHolder()
        end
        local port = portEditBox:getText()
        if (port == "") then
            port = portEditBox:getPlaceHolder()
        end
        if (ip and port) then
            port = tonumber(port)
            Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
            Net.NetInnerSystem:reconnect(Net.MAIN_SERVER, ip, port)
        end
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

-- 切换账号
function TestUtilLayer:createSection_account()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local IDText = UI.Text:create()
    IDText:init("切换账号：", UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    IDText:leftUp(0, 15)
    layout:addComponent(IDText)

    local IDEditBox = UI.EditBox:create(220, 40)
    IDEditBox:init("输入游戏账号ID", cc.EDITBOX_INPUT_MODE_NUMERIC, TEST_PANEL_SPRITE.EDITE_NORMAL)
    IDEditBox:leftUp(180, 10)
    layout:addComponent(IDEditBox)

    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(650, 5)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local id = IDEditBox:getText()
        if (id and id ~= "") then
            -- 加上test_前缀作为测试账号标识
            cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, "test_"..id)
        end
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end 

-- 跳转难度
function TestUtilLayer:createSection_Mode_diffculty()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)
    local size = cc.size(300, 60)
    local modeList = UI.DropDownList:create()
    local modeDataList = {}
    for k, v in pairs (PublicDefine.CAVE_MODE) do
        local data = {}
        data.name = ToolsUtil:getModeName(v)
        data.modeType = v
        table.insert(modeDataList, data)
    end
    table.sort(modeDataList, function(a, b)
        return a.modeType < b.modeType
    end)
    modeList:init(UI.TEXT_1170106, size, 1, #modeDataList)
    for k, v in ipairs(modeDataList) do
        modeList:addLabel(k, v.name)
    end
    layout:addComponent(modeList)
    modeList:centerLeft(10)

    local diffcultList = UI.DropDownList:create()
    local diffDataList = {}
    for k, v in pairs(PublicDefine.CAVE_DIFFICULTY) do
        local data = {}
        data.name = ToolsUtil:getDiffcultName(v)
        data.diffType = v
        table.insert(diffDataList, data)
    end
    table.sort(diffDataList, function(a, b)
        return a.diffType < b.diffType
    end)
    diffcultList:init(UI.TEXT_1170107, size, 1, #diffDataList)
    for k, v in ipairs(diffDataList) do
        diffcultList:addLabel(k, v.name)
    end
    layout:addComponent(diffcultList)
    diffcultList:centerLeft(310)


    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(650, 5)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local modeIndex = modeList:getSelectedIndex() or 0
        local diffcultIndex = diffcultList:getSelectedIndex() or 0
        if modeIndex == 0 or diffcultIndex == 0 then 
            return
        end 
        local modeType = modeDataList[modeIndex].modeType
        local diffcultType = diffDataList[diffcultIndex].diffType
        print("modeType  = "..modeType.."    and  diffcultType   =  "..diffcultType)
        GameManager:requestSelectModeAndDiffcult(GM_ELEMENT_TYPE.UNLOCK_CAVE_MODE_DIFFCULTY, modeType, diffcultType)
        self:close()
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

--修改四维属性
function TestUtilLayer:createChange_Attributtion()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)
    local size = cc.size(180, 60)
    local attrList = UI.DropDownList:create()
    attrList:init("点击选择属性", size, 1, #self.validAttrList)
    for k, v in ipairs(self.validAttrList)  do
        attrList:addLabel(k, v.name)
    end
    -- attrList:addLabel(1, "HP值")
    -- attrList:addLabel(2, "MP值")
    -- attrList:addLabel(3, "攻击力")
    layout:addComponent(attrList)
    attrList:centerLeft(10)
    -- attrList:enableDebugDraw()

    local IDEditBox = UI.EditBox:create(400, 40)
    IDEditBox:init("输入变化的属性值， 支持负数", cc.EDITBOX_INPUT_MODE_ANY, TEST_PANEL_SPRITE.EDITE_NORMAL)
    IDEditBox:leftUp(220, 10)
    layout:addComponent(IDEditBox)


    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftUp(650, 5)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local index = attrList:getSelectedIndex() or 0
        if index == 0 then 
            return
        end 
        local number = IDEditBox:getText()
        local attrType = self.validAttrList[index].type or 0
        print("attrType  = "..attrType.."    and  number   =  "..number)
        
        if (number and number ~= "") then
            local value = tonumber(number)
            if value == nil then
                return
            end
            local pk = GameDataManager:getInstance():getMasterPK()
            if attrType == PublicDefine.ATTR_TYPE.atkMin then
                GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.atkMin, value)
                GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.atkMax, value)
            elseif attrType == PublicDefine.ATTR_TYPE.magicAtkMin then
                GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.magicAtkMin, value)
                GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.magicAtkMax, value)
            else 
                GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, attrType, value)      
            end
            self:close()
        end
    end)
    requestButton:setText("完成")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)
    return layout
end

--英雄无敌
function TestUtilLayer:createChange_SelfMaxDefense()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local selftitle = UI.Text:create()
    selftitle:init("英雄无敌", UI.FONT_ARIAL, 30)
    selftitle:setFontColor(cc.c4b(255,248,220,255))
    layout:addChild(selftitle, 1)
    selftitle:leftUp(12, 5)

    local btnSelfTurnOn = UI.Button:create()
    btnSelfTurnOn:init("ui_gm_button_turnOn.png","ui_gm_button_turnOn.png","ui_gm_button_turnOn.png")
    btnSelfTurnOn:leftBottom(170, 5)
    btnSelfTurnOn:setScale(0.7)
    layout:addChild(btnSelfTurnOn, 20)

    local btnSelfTurnOff = UI.Button:create()
    btnSelfTurnOff:init("ui_gm_button_turnOff.png","ui_gm_button_turnOff.png","ui_gm_button_turnOff.png")
    btnSelfTurnOff:leftBottom(170, 5)
    btnSelfTurnOff:setScale(0.7)
    layout:addChild(btnSelfTurnOff, 20)
    

    btnSelfTurnOn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        if SceneManager:getInstance():isInTown() then
            return
        end
        GameManager:requestHeroMaxDefense(GM_ELEMENT_TYPE.HERO_IS_GOD, false)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.HeroIsGod, 0)
        btnSelfTurnOn:hide()
        btnSelfTurnOff:show()
    end)

    btnSelfTurnOff:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        if SceneManager:getInstance():isInTown() then
            return
        end
        GameManager:requestHeroMaxDefense(GM_ELEMENT_TYPE.HERO_IS_GOD, true)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.HeroIsGod, 1)
        btnSelfTurnOn:show()
        btnSelfTurnOff:hide()
    end)
    local isGod = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.HeroIsGod) or 0
    if isGod == 1 then
        btnSelfTurnOn:show()
        btnSelfTurnOff:hide()
    else
        btnSelfTurnOn:hide()
        btnSelfTurnOff:show()   
    end
    if SceneManager:getInstance():isInTown() then
        btnSelfTurnOn:hide()
        btnSelfTurnOff:show() 
    end


    local titleMonster = UI.Text:create()
    titleMonster:init("怪物无敌", UI.FONT_ARIAL, 30)
    titleMonster:setFontColor(cc.c4b(255,248,220,255))
    layout:addChild(titleMonster, 1)
    titleMonster:leftUp(312, 5)

    -- local tip = UI.Text:create()
    -- tip:init("开启后，怪物不会损失生命值。仅当关闭按钮，重启游戏后失效，不受切换楼层，离开洞窟影响。",UI.FONT_STANDARD,UI.FONT_SIZE_18PX)
    -- tip:setFontColor(UI.FONT_COLOR_234_222_190)
    -- layout:addChild(tip, 1)
    -- tip:leftBottom(0, 40)
    -- tip:setWidth(600)

    local btnMonsterTurnOn = UI.Button:create()
    btnMonsterTurnOn:init("ui_gm_button_turnOn.png","ui_gm_button_turnOn.png","ui_gm_button_turnOn.png")
    btnMonsterTurnOn:leftBottom(470, 5)
    btnMonsterTurnOn:setScale(0.7)
    layout:addChild(btnMonsterTurnOn, 20)

    local btnMonsterTurnOff = UI.Button:create()
    btnMonsterTurnOff:init("ui_gm_button_turnOff.png","ui_gm_button_turnOff.png","ui_gm_button_turnOff.png")
    btnMonsterTurnOff:leftBottom(470, 5)
    btnMonsterTurnOff:setScale(0.7)
    layout:addChild(btnMonsterTurnOff, 20)
    
    btnMonsterTurnOn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        if SceneManager:getInstance():isInTown() then
            return
        end
        btnMonsterTurnOn:hide()
        btnMonsterTurnOff:show()
        GameManager:requestMonsterMaxDefense(GM_ELEMENT_TYPE.MONSTER_IS_GOD, false)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.MonsterIsGod, 0)
    end)

    btnMonsterTurnOff:addEventListener(UIEvent.BUTTON_CLICK,self, function( )
        if SceneManager:getInstance():isInTown() then
            return
        end
        btnMonsterTurnOn:show()
        btnMonsterTurnOff:hide()
        GameManager:requestMonsterMaxDefense(GM_ELEMENT_TYPE.MONSTER_IS_GOD, true)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.MonsterIsGod, 1)
    end)
    local isGod = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.MonsterIsGod, 0)
    if isGod == 1 then
        btnMonsterTurnOn:show()
        btnMonsterTurnOff:hide()
    else
        btnMonsterTurnOn:hide()
        btnMonsterTurnOff:show()   
    end
    if SceneManager:getInstance():isInTown() then
        btnMonsterTurnOn:hide()
        btnMonsterTurnOff:show() 
    end



    local requestButton = UI.Button:create()
    requestButton:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    requestButton:leftBottom(600, 5)
    requestButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.atkMin, 9999)
        GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.atkMax, 9999)
        GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.magicAtkMin, 9999)
        GameManager:requestChangeAttribution(GM_ELEMENT_TYPE.ALTER_HERO_ATTR, PublicDefine.ATTR_TYPE.magicAtkMax, 9999)
        self:close()
    end)
    requestButton:setText("增加攻击力")
    requestButton:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    layout:addComponent(requestButton)

    return layout
end

function TestUtilLayer:createChange_AllLockFunc()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)

    local selftitle = UI.Text:create()
    selftitle:init("解锁所有功能", UI.FONT_ARIAL, 30)
    selftitle:setFontColor(cc.c4b(255,248,220,255))
    layout:addChild(selftitle, 1)
    selftitle:leftUp(12, 10)

    local btnSelfTurnOn = UI.Button:create()
    btnSelfTurnOn:init("ui_gm_button_turnOn.png","ui_gm_button_turnOn.png","ui_gm_button_turnOn.png")
    btnSelfTurnOn:leftBottom(190, 0)
    btnSelfTurnOn:setScale(0.7)
    layout:addChild(btnSelfTurnOn, 20)

    local btnSelfTurnOff = UI.Button:create()
    btnSelfTurnOff:init("ui_gm_button_turnOff.png","ui_gm_button_turnOff.png","ui_gm_button_turnOff.png")
    btnSelfTurnOff:leftBottom(190, 0)
    btnSelfTurnOff:setScale(0.7)
    layout:addChild(btnSelfTurnOff, 20)
    

    btnSelfTurnOn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        -- GameManager:requestHeroMaxDefense(GM_ELEMENT_TYPE.HERO_IS_GOD, false)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.UnLockAllFunc, 0)
        btnSelfTurnOn:hide()
        btnSelfTurnOff:show()
    end)

    btnSelfTurnOff:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        GameManager:requestHeroMaxDefense(GM_ELEMENT_TYPE.FUNCTION_UNLOCK)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.UnLockAllFunc, 1)
        btnSelfTurnOn:show()
        btnSelfTurnOff:hide()
    end)
    local isUnLock = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.UnLockAllFunc) or 0
    if isUnLock == 1 then
        btnSelfTurnOn:show()
        btnSelfTurnOff:hide()
    else
        btnSelfTurnOn:hide()
        btnSelfTurnOff:show()   
    end
    return layout
end

function TestUtilLayer:createTestShare()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)


    local button = UI.Button:create()
    button:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    button:leftBottom(600, 5)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Net.NetRoleSystem.netShare(1)
    end)
    button:setText("测试分享")
    button:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    button:floatRight(0)
    layout:addComponent(button)

    return layout
end

function TestUtilLayer:createTestPOST()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(900, 60)


    local button = UI.Button:create()
    button:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL, TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    button:leftBottom(600, 5)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:testPost()
    end)
    button:setText("POST测试")
    button:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    button:floatRight(0)
    layout:addComponent(button)

    return layout
end

-- post测试
function TestUtilLayer:testPost()
    -- local paramTable = {
    --     iap_id = "100",
    --     num = "100",
    --     account_id = "100",
    --     player_key = "100",
    -- }
    -- local paramJson = json.encode(paramTable)
    -- local session_start = 15997
    
    -- local xhr = cc.XMLHttpRequest:new()
    -- xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    -- local httpurl = string.format("http://192.168.1.201:8000/applypay?params=%s&XDEBUG_SESSION_START=%d",string.urlencode(paramJson),session_start)
    -- print("open ",httpurl)
    -- xhr:open("GET", httpurl)
    
    -- xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    -- -- xhr:setRequestHeader("Authorization", "Bearer")
    -- local function onReadyStateChanged()
    --     print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
    --     if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
    --         print(xhr.response)  
    --         local data = json.decode(xhr.response)          
    --         dump(data)
    --     else
            
    --         print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
    --     end
    --     xhr:unregisterScriptHandler()
    -- end
    -- xhr:registerScriptHandler(onReadyStateChanged)
    -- -- local sendParam = json.encode(paramTable)
    -- -- print("sendParam"..sendParam)
    -- xhr:send()




    local data = {}
    -- 订单号
    data.order_id = "11111"
    -- 苹果订单号
    data.transaction_id = "111111"
    -- 苹果验证字符串
    data.receipt_data = Base64Encode("adadadad")
    
    local sortTable = AvalonUtil:sortParamByFirstChar(data)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr.."avalon_iap")


    local sendParam = json.encode(paramTable)
    print("sendParam",sendParam)

    local httpurl = "http://192.168.1.201:8000/request_check?XDEBUG_SESSION_START=11481"
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        print("request_check",xhr.readyState,xhr.status,xhr.response)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("response",xhr.response)
            local resp = json.decode(xhr.response)
            dump(resp,"验证服务器结果")
            local status = checkint(resp.status)
            local order_id = resp.order_id
            if status ==  1 then
                print("订单处理成功")
                -- 找到本地储存的订单  删掉
                local iap_status = resp.iap_status
                -- 验证成功待发货
                if iap_status == 1 then
                    UI.ScrollBar:createByText(UI.TEXT_1170833)
                    params.vstatus = 0
                else
                    if iap_status == 2 then
                        UI.ScrollBar:createByText(UI.TEXT_1170834)
                    elseif iap_status == 5 then
                        UI.ScrollBar:createByText(UI.TEXT_1170840)
                    end
                    -- 删除记录
                    self:removeOrderById(order_id)
                end
                -- 订单状态介绍
                -- 0: 还未付款.(WEB后台不可补单)
                -- 1: 验证成功待发货. (WEB后台可补单.理论上由客户端和充值服自动补单)
                -- 2: 验证失败.(WEB后台不可补单)
                -- 3: 发货成功. (WEB后台不可补单)
                -- 4: 发货成功(有争议). (WEB后台不可补单,需要查询日志单独通过邮箱发送)
                -- 5: 发货失败. (WEB后台可补单)
                
            else
                print("订单处理失败,不做轮询")
                -- 删除记录
                self:removeOrderById(order_id)
                local msg_code = resp.msg_code
                if msg_code == -1 then
                    UI.ScrollBar:createByText(UI.TEXT_1170834)
                elseif msg_code == 2 then
                    UI.ScrollBar:createByText(UI.TEXT_1170835)
                elseif msg_code == 3 then
                    UI.ScrollBar:createByText(UI.TEXT_1170836)
                elseif msg_code == 4 then
                    UI.ScrollBar:createByText(UI.TEXT_1170837)
                elseif msg_code == 5 then
                    UI.ScrollBar:createByText(UI.TEXT_1170838)
                elseif msg_code == 7 then
                    UI.ScrollBar:createByText(UI.TEXT_1170839)
                end
                -- 只处理这几个
                -- -1: 通用失败.
                -- 2: 使用过的(已经成功发货的)订单
                -- 3: 订单ID和收据ID不匹配.
                -- 4: 通过订单ID没有找到订单.
                -- 5: 到第三方验证订单失败.
                -- 7: 渠道不合法.
            
            end
            -- dump(resp)
        else
            print("请求验证订单号失败,需要再次请求")
            -- 失败 需要再次验证
            params.vstatus = 0
            UI.ScrollBar:createByText(UI.TEXT_1170841)
        end
        if params.vstatus == 0 then
            -- 如果关闭状态 开启
            if self.schedulerID == 0 then
                self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), POLLING_INTERVAL, false)
            end
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    
    xhr:send(sendParam)
end