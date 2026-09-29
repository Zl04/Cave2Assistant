-- LevelSelect.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡难度选择 
require("utils.ObserverVariable")
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()
local LevelSelectDifficulty = class("LevelSelectDifficulty", UI.HWBtnComponent)
UI.LevelSelectDifficulty = LevelSelectDifficulty
local CELL_SIZE = cc.size(333, 499)

-- 关卡难度选择资源
local COM_RES_LIST = {
}

local SHOW_CAVE_MODE = {
    PublicDefine.CAVE_MODE.MODE_NORMAL,
    PublicDefine.CAVE_MODE.MODE_HERO,
}

local SHOW_CAVE_MODE_TITAN = {
    PublicDefine.CAVE_MODE.MODE_TITAN_ROAD,
    PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO,
}

local  bgSpineRes = {
    [SHOW_CAVE_MODE[1]] = "effect_ui_town_selectfloor_ordinary_bu",
    [SHOW_CAVE_MODE[2]] = "effect_ui_town_selectfloor_hero_bu",
    [SHOW_CAVE_MODE_TITAN[1]] = "effect_ui_town_selectfloor_titans_bu",
    [SHOW_CAVE_MODE_TITAN[2]] = "effect_ui_town_selectfloor_titans_hero_bu",
}

local  fontColorList  = {
    [SHOW_CAVE_MODE[1]] = {title = UI.FONT_COLOR_157_221_231, desc = UI.FONT_COLOR_116_173_221, param = UI.FONT_COLOR_69_153_223, point = cc.c3b(69, 153, 223)},
    [SHOW_CAVE_MODE[2]] = {title = UI.FONT_COLOR_247_172_53, desc = UI.FONT_COLOR_229_151_58, param = UI.FONT_COLOR_223_117_22, point = cc.c3b(223, 117, 22)},
    [SHOW_CAVE_MODE_TITAN[1]] = {title = UI.FONT_COLOR_157_221_231, desc = UI.FONT_COLOR_116_173_221, param = UI.FONT_COLOR_69_153_223, point = cc.c3b(69, 153, 223)},
    [SHOW_CAVE_MODE_TITAN[2]] = {title = UI.FONT_COLOR_247_172_53, desc = UI.FONT_COLOR_229_151_58, param = UI.FONT_COLOR_223_117_22, point = cc.c3b(223, 117, 22)},

}
local SHOW_CAVE_MODE_SIZE = #SHOW_CAVE_MODE

function LevelSelectDifficulty:ctor(selectCallback)
    LevelSelectDifficulty.super.ctor(
    self,UIType.LEVEL_SELECT_DIFFICULTY,
    COM_RES_LIST,
    winSize.width,  winSize.height
    -- 825,409
    )
    self.selectCallback = selectCallback
    self.rootLayer = nil;       --root节点
    self.desLabeList = {}
    self.btnDifficultyArray = {}
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener()
end


function LevelSelectDifficulty:dtor()
    self.desLabeList = {}
    self:unRegisterListener();
    LevelSelectDifficulty.super.dtor(self)
    reload_script_file("app.ui.town.levelSelect.LevelSelectDifficulty")
end

-- public:
-- 初始化
function LevelSelectDifficulty:init()
    LevelSelectDifficulty.super.init(self)
end


--难度相应事件
function LevelSelectDifficulty:onSelectDifficulty(sender)
    print("LevelSelectDifficulty:onSelectDifficulty",sender:getTag())
    -- LevelSelectUtil:getInstance():setDifficulty(sender:getTag())
    LevelSelectUtil:getInstance():setCaveMode(sender:getTag())
    Avalon.Scheduler:scheduleUpdateOnce(self, self.close, 0.2)
    if self.selectCallback then
        self.selectCallback(sender:getTag())
    end
end

function LevelSelectDifficulty:createDifficultyObj(difficulty)
    print("LevelSelectDifficulty:createDifficultyObj",difficulty)
    local btnDifficulty = UI.Button:create()
    btnDifficulty:init()
    btnDifficulty:setSize(CELL_SIZE.width, CELL_SIZE.height)
    local _x = (btnDifficulty:getContentSize().width + 10)*(difficulty -1)
    btnDifficulty:leftBottom(_x, 0);
    btnDifficulty:setTag(difficulty)    
    -- btnDifficulty:enableDebugDraw(UI.RED)
    local txtDifficulty = UI.Text:create()
    txtDifficulty:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, fontColorList[difficulty].title)
    txtDifficulty:centerUp(98)
    txtDifficulty:setName("txtDifficulty")
    btnDifficulty:addChild(txtDifficulty, 100)

    local txtDes1 = UI.Text:create()
    txtDes1:init(UI.TEXT_DES_TASK, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, fontColorList[difficulty].desc)
    txtDes1:setTextHorizontalCenter()
    txtDes1:centerUp(138)
    txtDes1:setName("txtDes1")
    txtDes1:setLineSpacing(-2)
    txtDes1:setWidth(200)
    btnDifficulty:addChild(txtDes1,5)

    local des2 = ""
    if difficulty == PublicDefine.CAVE_MODE.MODE_NORMAL then
        txtDifficulty:setText(UI.TEXT_110101)
        txtDes1:setText(UI.TEXT_110005)
        des2 = UI.TEXT_110008
    elseif difficulty == PublicDefine.CAVE_MODE.MODE_HERO then
        txtDifficulty:setText(UI.TEXT_1170945)
        txtDes1:setText(UI.TEXT_110006)
        des2 = UI.TEXT_110009
    elseif difficulty == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        txtDifficulty:setText(UI.TEXT_224400)
        txtDes1:setText(UI.TEXT_110006)
        des2 = UI.TEXT_110008
    elseif difficulty == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        txtDifficulty:setText(UI.TEXT_224401)
        txtDes1:setText(UI.TEXT_110006)
        des2 = UI.TEXT_110009
    end

    local height = txtDes1:getUp() + txtDes1:getContentSize().height + 20
    local desList = string.split(des2,"#icon")
    btnDifficulty.txtDesList = {}
    for i = 2,#(desList) do
        local picDes = cc.Sprite:createWithSpriteFrameName("ui_selectfloor_hero_diamond.png");
        picDes:setPosition(73, btnDifficulty:getContentSize().height - height - 11)
        btnDifficulty:addChild(picDes,7)
        picDes:setColor(fontColorList[difficulty].point)

        local txtDes2 = UI.Text:create()
        txtDes2:init(desList[i], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, fontColorList[difficulty].param)
        txtDes2:setTextLeft()
        txtDes2:leftUp(85, height)
        txtDes2:setName("txtDes2")
        txtDes2:setLineSpacing(-4)
        txtDes2:setWidth(180)
        btnDifficulty:addChild(txtDes2, 6)
        -- txtDes2:enableDebugDraw(UI.RED)
        txtDes2:autoAdapt()

        height = height + txtDes2:getContentSize().height
        if self.desLabeList[difficulty] == nil then
            self.desLabeList[difficulty] = {}
        end
        table.insert(self.desLabeList[difficulty], picDes)
        table.insert(self.desLabeList[difficulty], txtDes2)
    end


    btnDifficulty:setTouchEnable(true)
    btnDifficulty:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
         if difficulty == PublicDefine.CAVE_MODE.MODE_HERO then
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
            if unLockHeroMode then
                self:onSelectDifficulty(btnDifficulty)
            end
        elseif difficulty == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
            if unLockHeroMode then
                self:onSelectDifficulty(btnDifficulty)
            end
        else
            self:onSelectDifficulty(btnDifficulty)
        end
    end)
    btnDifficulty:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        if difficulty == PublicDefine.CAVE_MODE.MODE_HERO then
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
            if unLockHeroMode then
                self:setSelectState(btnDifficulty:getTag(), LevelSelectUtil:getInstance().mCaveMode)
            else
                UI.ScrollBar:createByText(UI.TEXT_1170949)
            end
        elseif difficulty == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
            if unLockHeroMode then
                self:setSelectState(btnDifficulty:getTag(), LevelSelectUtil:getInstance().mCaveMode)
            else
                UI.ScrollBar:createByText(UI.TEXT_224406)
            end
        else
            self:setSelectState(btnDifficulty:getTag(), LevelSelectUtil:getInstance().mCaveMode)
        end
    end)

    btnDifficulty:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        if LevelSelectUtil:getInstance().mCaveMode ~= btnDifficulty:getTag() and btnDifficulty:getChildByName("selectSpine") ~= nil then
            local tmpNode = btnDifficulty:getChildByName("selectSpine")
            if tmpNode then
                tmpNode:hide()
            end
        end
    end)

    local bgAnimation = UI.Animation:create()
    bgAnimation:init(string.format("%s.json", bgSpineRes[difficulty]), string.format("%s.atlas", bgSpineRes[difficulty]), 1);
    bgAnimation:setAnimation("idle1", true)
    bgAnimation:centerUp(100)
    btnDifficulty:addChild(bgAnimation, 1)
    bgAnimation:setName("bgAnimation")
    bgAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,self.spineIconPlayCallback)

    if difficulty == PublicDefine.CAVE_MODE.MODE_HERO then
        local lockTips = UI.Text:create()
        lockTips:init(UI.TEXT_1170949, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_165_46_40)
        lockTips:setSize(220, 75)
        lockTips:centerBottom(-65)
        lockTips:setTextCenter()
        lockTips:rotate(-2)
        self.lockTips = lockTips
        bgAnimation:addComponent("lock_tip", lockTips, true)
    end

    if difficulty == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        local lockTips = UI.Text:create()
        lockTips:init(UI.TEXT_224406, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_165_46_40)
        lockTips:setSize(220, 75)
        lockTips:centerBottom(-65)
        lockTips:setTextCenter()
        lockTips:rotate(-2)
        self.lockTips = lockTips
        bgAnimation:addComponent("lock_tip", lockTips, true)
    end
    self.rootLayer:addChild(btnDifficulty)
    self.btnDifficultyArray[difficulty] = btnDifficulty
    return btnDifficulty
end

function LevelSelectDifficulty:spineIconPlayCallback(event,obj)
    if event.animation == "unlock" then
        self:setOpenState()
        self:setSelectState(LevelSelectUtil:getInstance().mCaveMode)
    end
end

--设置难度开放状态
function LevelSelectDifficulty:setOpenState()
    print("LevelSelectDifficulty:setOpenState")
    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    local isShowUnlock = Game.FunctionUnlockManager:getInstance():isShowUnlockAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    local showMode = SHOW_CAVE_MODE
    if LevelSelectUtil:getInstance().mLayerType == Game.LevelSelectLayerType.Titan_Road then
        showMode = SHOW_CAVE_MODE_TITAN
        isShowUnlock = Game.FunctionUnlockManager:getInstance():isShowUnlockAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
        unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
    end
    for k, v  in ipairs(showMode) do
        local btnDifficulty = self.btnDifficultyArray[v]
        print("LevelSelectDifficulty:setOpenState", unLockHeroMode, isShowUnlock)
        if v == PublicDefine.CAVE_MODE.MODE_HERO and ((unLockHeroMode and isShowUnlock) or not unLockHeroMode) then
            local bgAnimation = btnDifficulty:getChildByName("bgAnimation")
            if bgAnimation then
                if not unLockHeroMode then
                    bgAnimation:setAnimation("lock_idle1",true)
                elseif isShowUnlock then
                    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
                    bgAnimation:setAnimation("unlock",false)
                    bgAnimation:addAnimation("idle1",true)
                    Avalon.AudioManager:playSound("1535")
                end
                btnDifficulty:getChildByName("txtDifficulty"):setOpacity(75)
                btnDifficulty:getChildByName("txtDes1"):setOpacity(75)
                for k, v in ipairs(self.desLabeList[v]) do
                    v:setOpacity(75)
                end
            end

            btnDifficulty:getChildByName("txtDifficulty"):setFontColor(UI.FONT_COLOR_132_124_100)
        elseif v == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO and ((unLockHeroMode and isShowUnlock) or not unLockHeroMode) then
            local bgAnimation = btnDifficulty:getChildByName("bgAnimation")
            if bgAnimation then
                if not unLockHeroMode then
                    bgAnimation:setAnimation("lock_idle1",true)
                elseif isShowUnlock then
                    Game.FunctionUnlockManager:getInstance():removeUnlcokActFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
                    bgAnimation:setAnimation("unlock",false)
                    bgAnimation:addAnimation("idle1",true)
                    Avalon.AudioManager:playSound("1535")
                end
                btnDifficulty:getChildByName("txtDifficulty"):setOpacity(75)
                btnDifficulty:getChildByName("txtDes1"):setOpacity(75)
                for k, v in ipairs(self.desLabeList[v]) do
                    v:setOpacity(75)
                end
            end

            btnDifficulty:getChildByName("txtDifficulty"):setFontColor(UI.FONT_COLOR_132_124_100)
        else
            btnDifficulty:getChildByName("txtDifficulty"):setFontColor(fontColorList[v].title)
            btnDifficulty:getChildByName("bgAnimation"):setAnimation("idle1", true)
        
            if v == PublicDefine.CAVE_MODE.MODE_NORMAL then
            elseif v == PublicDefine.CAVE_MODE.MODE_HERO or v == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                self.lockTips:hide()
            end
            btnDifficulty:getChildByName("txtDifficulty"):setOpacity(255)
            btnDifficulty:getChildByName("txtDes1"):setOpacity(255)
            for k, v in ipairs(self.desLabeList[v]) do
                v:setOpacity(255)
            end
        end
    end
end

--设置难度选中状态
function LevelSelectDifficulty:setSelectState(difficulty,oldDifficulty)
    local btnDifficulty = self.btnDifficultyArray[difficulty]
    if btnDifficulty == nil then
        print("------difficulty-------oldDifficulty------", difficulty, oldDifficulty)
        return
    end
    local selectSpine = btnDifficulty:getChildByName("selectSpine")
    if selectSpine == nil then
        selectSpine = UI.Animation:create()
        selectSpine:init("effect_ui_town_selectfloor_bu_guang.json", "effect_ui_town_selectfloor_bu_guang.atlas", 1);
        selectSpine:play("idle",true)
        selectSpine:setName("selectSpine")
        selectSpine:setPos(btnDifficulty._hw + 6,btnDifficulty._hh - 125)
        btnDifficulty:addChild(selectSpine,-1)
    end
    selectSpine:setVisible(true)
end

-- 模版函数：初始化组建的视图
function LevelSelectDifficulty:onInitView()
    -- self:addColorBG()
    local bgLayer = cc.LayerColor:create(cc.c4b(0,0,0,160));
    bgLayer:setContentSize(cc.size(winSize.width,winSize.height))
    bgLayer:setPosition(cc.p(0,0))
    self:addChild(bgLayer)

    self.rootLayer = UI.Layout:create();
    self.rootLayer:init()
    self.rootLayer:setSize((CELL_SIZE.width + 10) * SHOW_CAVE_MODE_SIZE + 154, CELL_SIZE.height)
    self.rootLayer:center() 
    self.rootLayer:setTouchEnable(true)   
    self.rootLayer:setInterceptTouches(true);
    self:addChild(self.rootLayer)
    -- self.rootLayer:enableDebugDraw()

    local touchOutLayer = UI.Layout:create();
    touchOutLayer:init()
    touchOutLayer:setSize(190, CELL_SIZE.height)
    touchOutLayer:center() 
    touchOutLayer:setTouchEnable(true)   
    self.rootLayer:addChild(touchOutLayer)
    -- touchOutLayer:enableDebugDraw()
    touchOutLayer:addEventListener(UIEvent.COMPONENT_CLICK, touchOutLayer, function()
        Avalon.AudioManager:playSound("1503")
        self:close()
    end)

    local showMode = SHOW_CAVE_MODE
    if LevelSelectUtil:getInstance().mLayerType == Game.LevelSelectLayerType.Titan_Road then
        showMode = SHOW_CAVE_MODE_TITAN
    end

    for k, v in ipairs(showMode) do
        local node = self:createDifficultyObj(v)
        local _x = (node:getContentSize().width + 149)*(k -1)
        node:leftBottom(_x, 0);
    end

    self:setOpenState();
    self:setSelectState(LevelSelectUtil:getInstance().mCaveMode)
end

-- 模版函数：更新组建的视图
function LevelSelectDifficulty:onUpdateView()

end

-- 点击外部区域的处理器
function LevelSelectDifficulty:onTouchDialogOutsizeHandler(tips, touchPosition)
    Avalon.AudioManager:playSound("1503")
    self:close()
end

-- 注册监听事件
function LevelSelectDifficulty:registerListener()
        --监听窗口外关闭事件
    self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end


-- 注销监听事件
function LevelSelectDifficulty:unRegisterListener()
end



