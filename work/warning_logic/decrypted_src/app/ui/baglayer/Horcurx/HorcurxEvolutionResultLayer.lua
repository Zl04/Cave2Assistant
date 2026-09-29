-- HorcurxEvolutionResultLayer.lua
local LanguageManager = require "app.game.LanguageManager"
require "app.ui.baglayer.Horcurx.HorcurxDataManager"
local GameDataManager = require("app.game.GameDataManager")
require("utils.UIUtil")

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()

UI = UI or {}

local HorcurxEvolutionResultLayer = class("HorcurxEvolutionResultLayer", UI.HWBtnComponent)
UI.HorcurxEvolutionResultLayer = HorcurxEvolutionResultLayer

-- 关卡选择资源
local COM_RES_LIST = {
}
-- 关卡选择资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    -- "ui_common_scale9image.plist",
    -- "ui_common_btn.plist",
    -- "ui_common_symbol.plist",
    -- "ui_common_information.plist",
    -- "ui_common_icon_skill.plist",
    "ui_package_skill.plist",
}


function HorcurxEvolutionResultLayer:ctor()
    HorcurxEvolutionResultLayer.super.ctor(
    self,UIType.HORCURX_LAYER,
    COM_RES_LIST,
    winSize.width,
    winSize.height
    )
    self.rootLayer = nil;           --root节点
end


function HorcurxEvolutionResultLayer:dtor()
    HorcurxEvolutionResultLayer.super.dtor(self)

    reload_script_file("app.ui.baglayer.Horcurx.HorcurxEvolutionResultLayer")
end


function HorcurxEvolutionResultLayer:onInitView()
	self:showResultAnimation()
end



function HorcurxEvolutionResultLayer:showResultAnimation()
    local resultCom = self

    self.resultCom = resultCom

    local bgLayer = cc.LayerColor:create(cc.c4b(0,0,0,160));
    bgLayer:setContentSize(cc.size(winSize.width,winSize.height))
    bgLayer:setPosition(cc.p(0,0))
    resultCom:addChild(bgLayer)

    local com = UI.Component:create()
    com:init()
    com:centerBottom(0)
    bgLayer:addChild(com)


    local lv = HorcurxDataManager:getCurLevel()
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)
    local name = HorcurxDataManager:getHorcurxName(self.curEvolationLv)
    name = languageManagerInstance:getLocalString(name)
   
    local title = UI.Text:create()
    title:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_224_115 )
    title:setOutline(UI.FONT_COLOR_BLACK)
    title:centerBottom(240)
    com:addChild(title)


    local animation2 = UI.Animation:create()
    animation2:init("effect_ui_common_settlement.json", "effect_ui_common_settlement.atlas", 1);
    animation2:setAnimation("begin", false)
    animation2:setAnimation("idle", true)
    animation2:centerBottom(410)
    com:addChild(animation2)


    local animation2 = UI.Animation:create()
    animation2:init("effect_ui_horcruxes_evolution.json", "effect_ui_horcruxes_evolution.atlas", 1);
    animation2:setAnimation("idle1", true)
    animation2:centerBottom(640)
    com:addChild(animation2)

    local title = UI.Text:create()
    title:init(UI.TEXT_1212418, UI.FONT_STANDARD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_224_115 )
    title:centerBottom(625)
    com:addChild(title)

    
    local c = UI.Component:create()
    c:init()
    c:centerBottom(160)
    com:addChild(c)
    -- 确认按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onCloseAnimation)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btn:setText(UI.TEXT_1212094)
    btn:center(-140,0)
    c:addChild(btn)

    -- 启用按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onUse)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btn:setText(UI.TEXT_1212448)
    btn:center(140,0)
    c:addChild(btn)

        
 

    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv)
    local img = string.split(config.position, "_")
    local spineName = "effect_role_" .. img[1] .. "_cave_" ..img[2]
    if(spineName and spineName ~= "") then 
        local com1 = UI.Component:create()
        com1:init()
        com1:setSize(10,200)
        local _horcruxExteriorAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
        _horcruxExteriorAnimation:setAnimation(0, "idle2", false)
        _horcruxExteriorAnimation:addAnimation(0, "idle1", true)
        com1:addChild(_horcruxExteriorAnimation)
        com1:centerBottom(410)
        com:addChild(com1)
    end
end


function HorcurxEvolutionResultLayer:onUse()
    local lv = HorcurxDataManager:getCurLevel()
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)
    Net.NetRoleSystem:reqSetHorcurxIllusion(self.curEvolationLv)
    UI.ScrollBar:createByText(UI.TEXT_1212449)
    self:removeFromParent()
end

function HorcurxEvolutionResultLayer:onCloseAnimation()
    self:removeFromParent()
end




