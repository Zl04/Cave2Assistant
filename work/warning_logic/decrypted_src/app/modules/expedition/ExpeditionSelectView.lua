------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/07/04
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ExpeditionSelectView = class("ExpeditionSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_expedition.plist"
}
local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 492
local COM_HEIGHT = 513
function ExpeditionSelectView:ctor(curSelectCaveMode,arg,arg1,arg2)
    ExpeditionSelectView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.curSelectCaveMode = curSelectCaveMode

    -- print("self.curSelectCaveMode", self.curSelectCaveMode)
    -- print("self.curSelectCaveMode", self.curSelectCaveMode)
    -- print("self.curSelectCaveMode", self.curSelectCaveMode)
    self:bindModel()
    self:center()
end

function ExpeditionSelectView:dtor()
    ExpeditionSelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.expedition.ExpeditionSelectView")
end

--param:{isSelect, pngName, deseTitle, descContent}
function ExpeditionSelectView:createOneItem(param,idx, isSelect)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(452, 124)

    local bg = UI.Image:create()
    if isSelect then
        bg:init("ui_explore_checkpoint_paper2.png")
    else
        bg:init("ui_explore_checkpoint_paper1.png")
    end
    bg:center()
    layout:addChild(bg)

    bg:setTouchEnable(true)
    bg:setSwallowTouches(false)
    bg:addEventListener(
        UIEvent.COMPONENT_CLICK,
        self,
        function()
            mvc.send(mvc.events.Expedition_Select_IDX, idx)
        end
    )

    local icon = UI.Image:create()
    icon:init(param[1])
    icon:centerLeft(50)
    layout:addChild(icon)

    if isSelect then
        local select = UI.Image:create()
        select:init("ui_explore_checkpoint_round.png")
        select:leftBottom(-7, 0)
        icon:addChild(select)
    end

    local text = UI.Text:create()
    text:init(param[2], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    text:leftUp(162, 20)
    layout:addChild(text)

    text = UI.Text:create()
    if isSelect then
        text:init(param[3], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_77_77_84)
    else
        text:init(param[3], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    end
    text:leftUp(162, 55)
    text:setSize(228, 60)
    layout:addChild(text)

    return layout
end
function ExpeditionSelectView:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,200))
    colorLayer:setPosition((COM_WIDTH - winSize.width) / 2, (COM_HEIGHT - winSize.height) / 2)
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1) 

    local img = UI.Image:create()
    img:init("ui_explore_checkpoint_paper3.png")
    img:center()
    self:addChild(img)
    self.bg = img
    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(COM_WIDTH - 24, 472)
    scrollView:centerUp(18)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:setScrollBarEnabled(true)
    -- scrollView:enableDebugDraw()
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    self.scrollView = scrollView
    self.bg:addChild(scrollView, 2)
    
    local img = UI.Image:create()
    img:init("ui_explore_checkpoint_gradually1.png")
    img:leftBottom(4,470)
    self.bg:addChild(img, 3)
   
    local img = UI.Image:create()
    img:init("ui_explore_checkpoint_gradually2.png")
    img:leftBottom(4,16)
    self.bg:addChild(img, 3)


    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoHeight()
    layout:enableAutoWidth()
    scrollView:addInnerNode(layout)

    local descInfos = {
        {
            "ui_explore_titan_hero.png",
            UIUtil:lang(1115679),
            UIUtil:lang(1116242),
            PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero
        },
        {
            "ui_explore_titan.png",
            UIUtil:lang(1115678),
            UIUtil:lang(1116241),
            PublicDefine.CAVE_MODE.MODE_TITAN_ROAD,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad
        },
        {
            "ui_explore_reincarnation.png",
            UIUtil:lang(1115483),
            UIUtil:lang(1115492),
            PublicDefine.CAVE_MODE.MODE_VIKING,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking
        },
        {
            "ui_explore_uncharted.png",
            UIUtil:lang(1114772),
            UIUtil:lang(1114809),
            PublicDefine.CAVE_MODE.MODE_VOID_RIFT,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift
        },
        {
            "ui_explore_inferno.png",
            UIUtil:lang(1150063),
            UIUtil:lang(1113938),
            PublicDefine.CAVE_MODE.MODE_INFERNO,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno
        },
        {
            "ui_explore_distortedSpace.png",
            UIUtil:lang(1112440),
            UIUtil:lang(1112441),
            PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace
        },
        {
            "ui_explore_eye.png",
            UIUtil:lang(1112437),
            UIUtil:lang(1112438),
            PublicDefine.CAVE_MODE.MODE_DESERT_EYES,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye
        },
        {
            "ui_explore_hero.png",
            UIUtil:lang(1112434	),
            UIUtil:lang(1112435),
            PublicDefine.CAVE_MODE.MODE_HERO,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave
        },
        {
            "ui_explore_ordinary.png",
            UIUtil:lang(1112392),
            UIUtil:lang(1112433),
            PublicDefine.CAVE_MODE.MODE_NORMAL,
        },
        {
            "ui_explore_dryspring.png",
            UIUtil:lang(1116318),
            UIUtil:lang(1112438),
            PublicDefine.CAVE_MODE.MODE_DRIED_SPRING,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring
        },
        {
            "ui_explore_chaos.png",
            UIUtil:lang(1116672),
            UIUtil:lang(1116860),
            PublicDefine.CAVE_MODE.MODE_CHAOS,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS
        },
    }
    for i = 1, #descInfos do
        if (not descInfos[i][5] or RoleDataManager:isUnlockByFunctionType(descInfos[i][5])) and ToolsUtil:getExpeditionLevel(descInfos[i][4]) > 0  then 
            if descInfos[i][4] == self.curSelectCaveMode then
                local com = self:createOneItem(descInfos[i],descInfos[i][4], true)
                com:floatUp(15)
                layout:addComponent(com)
                break
            end
        end
    end

    for i = 1, #descInfos do
        if (not descInfos[i][5] or RoleDataManager:isUnlockByFunctionType(descInfos[i][5])) and ToolsUtil:getExpeditionLevel(descInfos[i][4]) > 0  then 
            if descInfos[i][4] ~= self.curSelectCaveMode then
                local com = self:createOneItem(descInfos[i],descInfos[i][4], false)
                com:floatUp(15)
                layout:addComponent(com)
            end
        end
    end
end

function ExpeditionSelectView:bindModel()
end

function ExpeditionSelectView:unbindModel()
end

return ExpeditionSelectView
