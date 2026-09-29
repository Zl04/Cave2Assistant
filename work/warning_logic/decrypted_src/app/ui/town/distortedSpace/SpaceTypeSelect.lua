-- SpaceTypeSelect.lua
-- Author:ping.zheng
-- 2021年1月29日
-- Using:扭曲空间以及后扭曲空间的切换界面


local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require "app.game.LanguageManager"

UI = UI or {}

local SpaceTypeSelect = class("SpaceTypeSelect", UI.HWBtnComponent)
UI.SpaceTypeSelect = SpaceTypeSelect

local winSize = cc.Director:getInstance():getWinSize()

-- 关卡难度选择资源
local COM_RES_LIST = {
    "ui_town_distortedSpace.plist",
    "ui_town_inferno.plist",
}

function SpaceTypeSelect:ctor(choiceCallBack)
    SpaceTypeSelect.super.ctor(
    self,UIType.MAIN_UI_DISTORTEDSPACE_TYPESELECT,
    COM_RES_LIST,
    winSize.width,
    winSize.height
    )
    self.choiceCallBack = choiceCallBack
    self:setTouchEnable(true)
    self.rootLayer = nil;       --root节点

    self:init();
    self:registerListener();
end


function SpaceTypeSelect:dtor()
    -- print(debug.traceback())
    self:unRegisterListener();
    SpaceTypeSelect.super.dtor(self)

    reload_script_file("app.ui.town.distortedSpace.SpaceTypeSelect")
end

function SpaceTypeSelect:close()
    SpaceTypeSelect.super.close(self)
end

-- public:
-- 初始化
function SpaceTypeSelect:init()
    SpaceTypeSelect.super.init(self)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        print("SpaceTypeSelect  COMPONENT_CLICK")
        self:close()
    end)
end

-- 模版函数：初始化组建的视图
function SpaceTypeSelect:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,150))
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1) 

    local UILayout = UI.Layout:create()
    UILayout:init()
    UILayout:setSize(1136, 640)
    UILayout:center()
    self:addChild(UILayout)

    local distortedSpaceData = {
        type = Game.DISTORTED_TYPE.NORMAL,
        nameID = UI.TEXT_1212803,
        desID = UI.TEXT_1325505
    }

    local infernoData = {
        type = Game.DISTORTED_TYPE.INFERNO,
        nameID = UI.TEXT_1325500,
        desID = UI.TEXT_1325506
    }

    local voidRiftData = {
        type = Game.DISTORTED_TYPE.VOIDRIFT,
        nameID = UI.TEXT_222100,
        desID = UI.TEXT_222101
    }

    local oneLayout = self:createOneType(distortedSpaceData)
    local twoLayout = self:createOneType(infernoData)
    local threeLayout = self:createOneType(voidRiftData)
    oneLayout:centerLeft(70)
    twoLayout:center()
    threeLayout:centerRight(70)
    UILayout:addChild(oneLayout)
    UILayout:addChild(twoLayout)
    UILayout:addChild(threeLayout)


    -- local catFoodBtn = UI.Button:create()
    -- catFoodBtn:init("ui_btn_catfood_0.png", "ui_btn_catfood_1.png", "ui_btn_catfood_0.png")
    -- catFoodBtn:center()
    -- catFoodBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
    --     print("catFoodBtn  BUTTON_CLICK")
    --     self:close()
    -- end)
    -- UILayout:addChild(catFoodBtn, 10)
end

-- 模版函数：更新组建的视图
function SpaceTypeSelect:onUpdateView()

end

function SpaceTypeSelect:createOneType(data)
    local bgLayout = UI.Layout:create()
    bgLayout:init()
    -- bgLayout:enableDebugDraw()
    bgLayout:setSize(290, 470)

    local jsonName = "effect_ui_town_selectfloor_inferno_purple.json"
    local atlasName = "effect_ui_town_selectfloor_inferno_purple.atlas"
    if(data.type == Game.DISTORTED_TYPE.INFERNO) then 
        -- jsonName = "effect_ui_town_selectfloor_inferno_red.json"
        -- atlasName = "effect_ui_town_selectfloor_inferno_red.atlas"
        -- jsonName = "effect_ui_town_selectfloor_inferno_green.json"
        -- atlasName = "effect_ui_town_selectfloor_inferno_green.atlas"
        -- jsonName = "effect_ui_town_selectfloor_inferno_blue.json"
        -- atlasName = "effect_ui_town_selectfloor_inferno_blue.atlas"
        -- jsonName = "effect_ui_town_selectfloor_inferno_light.json"
        -- atlasName = "effect_ui_town_selectfloor_inferno_light.atlas"
        jsonName = "effect_ui_town_selectfloor_inferno_shadow.json"
        atlasName = "effect_ui_town_selectfloor_inferno_shadow.atlas"
    elseif (data.type == Game.DISTORTED_TYPE.VOIDRIFT) then 
        jsonName = "effect_ui_town_selectfloor_inferno_lake.json"
        atlasName = "effect_ui_town_selectfloor_inferno_lake.atlas"
    end

    local bgAnimation = UI.Animation:create()
    bgAnimation:init(jsonName, atlasName)
    bgAnimation:setAnimation("begin", false)
    bgAnimation:addAnimation("idle1", true)
    if(data.type == Game.DISTORTED_TYPE.INFERNO) then 
        bgAnimation:center(14,-7)
    else
        -- bgAnimation:center()
        bgAnimation:center(-10,-8)
    end
    bgLayout:addChild(bgAnimation)

    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:setSize(210, 308)
    centerLayout:centerUp(79)
    -- centerLayout:enableDebugDraw()
    bgLayout:addChild(centerLayout)

    -- local nameBg = UI.Image:create()
    -- local bgSpriteName = ""
    -- if(data.type == Game.DISTORTED_TYPE.INFERNO) then 
    --     -- bgSpriteName = "ui_inferno_select_namebg_red.png"
    --     -- bgSpriteName = "ui_inferno_select_namebg_green.png"
    --     -- bgSpriteName = "ui_inferno_select_namebg_blue.png"
    -- elseif(data.type == Game.DISTORTED_TYPE.VOIDRIFT) then 
    --     -- bgSpriteName = ""
    --     -- nameBg:hide()
    -- end
    -- nameBg:init(bgSpriteName)
    -- nameBg:centerUp(84)
    -- nameBg:enableDebugDraw()
    -- centerLayout:addChild(nameBg)

    local nameStr = data.nameID
    local nameText = UI.Text:create()
    -- if(data.type == Game.DISTORTED_TYPE.INFERNO) then
    --     nameText:init(nameStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_198_193_215)
    --     nameText:center(-11, 13)
    -- else
    --     nameText:init(nameStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    --     nameText:center(0, 3)
    -- end
    nameText:init(nameStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_198_193_215)
    nameText:center(-10, -56)
    
    nameText:autoAdapt()
    -- nameText:enableDebugDraw()
    centerLayout:addChild(nameText)

    local height = 156
    local desStr = data.desID
    local desText = UI.Text:create()
    if(data.type == Game.DISTORTED_TYPE.INFERNO) then
        desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_44_72)
    elseif(data.type == Game.DISTORTED_TYPE.VOIDRIFT) then
        desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    else
        desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_174_221)
    end
    
    -- desText:enableDebugDraw()
    desText:setWidth(134)
    desText:autoAdapt()

    if(desText:getContentSize().height <= height) then 
        desText:centerUp(139)
        centerLayout:addChild(desText)
    else
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(134, desText:getContentSize().height)
        desText:centerUp(3)
        layout:addChild(desText)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(134, 139)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(layout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:centerUp(139)

        centerLayout:addChild(detailedScrollView)
    end

    bgLayout:setTouchEnable(true)
    bgLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        bgAnimation:setAnimation("click", false)
        -- local lastSelect = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeDistoreMode..GameDataManager:getInstance():getMasterPK(), 0)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeDistoreMode..GameDataManager:getInstance():getMasterPK(), data.type)
        cc.UserDefault:getInstance():flush()
        self:choiceType(data.type)
    end)

    return bgLayout
end

function SpaceTypeSelect:choiceType(type)
    print("SpaceTypeSelect:choiceType", type)
    if(self.choiceCallBack) then 
        self.choiceCallBack(type)
    end
    if(not tolua.isnull(self)) then
        self:close()
    end
end

-- 注册监听事件
function SpaceTypeSelect:registerListener()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_SEARCH_MATCH, self, self._close)

end


-- 注销监听事件
function SpaceTypeSelect:unRegisterListener()

end


function SpaceTypeSelect:openShow()

end
