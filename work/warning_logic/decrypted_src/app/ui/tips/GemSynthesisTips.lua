-- GemSynthesisTips.lua
-- Author:zp
-- 2020年12月17日
-- Using:宝石合成界面

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local GemSynthesisTips = class("GemSynthesisTips",UI.HWBtnComponent)
UI.GemSynthesisTips = GemSynthesisTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
    "ui_general_tips.plist",
}

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    self:close();
end

--  构造函数
function GemSynthesisTips:ctor()
    GemSynthesisTips.super.ctor(self,UIType.JOIN_GUILD_SUCCESS_TIPS,VOTE_SUCCEED_TIPS_PLIST, 538, 372)
    self._cancelCallFun = nil 
    self._okCallFun = nil 

    self.isGemStone = true            -- 合成符文石
    self.isGemCrystal = false          -- 合成符文水晶   
    self.gemLevelArr = {
        {isChecked = true, level = 1},
        {isChecked = true, level = 2},
        {isChecked = true, level = 3},
        {isChecked = true, level = 4},
        {isChecked = true, level = 5},
        {isChecked = true, level = 6},
        {isChecked = false, level = 7},
        {isChecked = false, level = 8},
        {isChecked = false, level = 9},
        {isChecked = false, level = 10},
        {isChecked = false, level = 11},
        {isChecked = false, level = 12},
    }   
end

--  析构函数 调用父类的方法
function GemSynthesisTips:dtor()
    GemSynthesisTips.super.dtor(self)
    -- print("GemSynthesisTips dtor", self._okCallFun)
    if(self._okCallFun) then
        self._okCallFun()
    end
    reload_script_file("app.ui.tips.GemSynthesisTips")
end

--  初始化函数  type:1 创建公会成功， 2 加入公会成功
function GemSynthesisTips:init(type)
    self._type = type
    GemSynthesisTips.super.init(self)
end

--  初始化界面函数
function GemSynthesisTips:onInitView()
    local winSize = cc.Director:getInstance():getWinSize()
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,120))
    blackBg:setContentSize(winSize.width*2, winSize.height*2)
    blackBg:setPosition(-winSize.width/2, -winSize.height/2)
    self:addChild(blackBg)

    Avalon.AudioManager:playSound("1536")
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

    local bg = UI.Image9:create()
    bg:init("ui_setup_banner_box2.png",{x=195,y=96,width=5,height=5})
    bg:setReflectSize(538, 372)
    bg:computePosition()
    bg:center()
    self:addChild(bg)

    -- 标题
    local luckValue = UI.Text:create()
    luckValue:init(UI.TEXT_1325301, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    luckValue:centerUp(20)
    bg:addChild(luckValue, 10)


    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    -- contentBg:setReflectPos(29, 35)
    contentBg:setReflectSize(448, 225)
    contentBg:computePosition()
    contentBg:center()
    bg:addChild(contentBg)

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:centerUp(0)
    contentTopLine:setReflectSize(451, 2)
    contentTopLine:computePosition()
    contentBg:addChild(contentTopLine)

    local contentCenterLine = UI.Image9:create()
    contentCenterLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentCenterLine:centerUp(56)
    contentCenterLine:setReflectSize(420, 2)
    contentCenterLine:computePosition()
    contentBg:addChild(contentCenterLine)

    local contentBottomLine = UI.Image9:create()
    contentBottomLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentBottomLine:centerBottom(0)
    contentBottomLine:setReflectSize(451, 2)
    contentBottomLine:computePosition()
    contentBg:addChild(contentBottomLine)

    -- 组织选项
    -- 符文类型
    local gemStone = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1091297), nil, function()
        return self.isGemStone
    end,
    function(isChecked, boxLayout, comp, isByTouch)
        self.isGemStone = isChecked
        self:refreshBtnState()
    end)

    local gemDiamond = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1091298), nil, function()
        return self.isGemCrystal
    end,
    function(isChecked, boxLayout, comp, isByTouch)
        self.isGemCrystal = isChecked
        self:refreshBtnState()
    end)
    gemStone:leftUp(44, 10)
    gemDiamond:leftUp(270, 10)
    contentBg:addChild(gemStone)
    contentBg:addChild(gemDiamond)

    -- 符文等级
    local startY = 67
    local startX = 44 - 10
    local oneX = 139 - 35
    local oneY = 50
    local lineNum = 4
    for k,data in ipairs(self.gemLevelArr) do 
        local levelNode = self:createCheckBoxWithLabel(data.level.." "..UI.TEXT_1324526, data, function(node)
            return node.data.isChecked
        end,
        function(isChecked, boxLayout, comp, isByTouch)
            boxLayout.data.isChecked = isChecked
            self:refreshBtnState()
        end)

        local indexY = math.floor((k - 1)/lineNum)
        local indexX = k - indexY *lineNum
        levelNode:leftUp(startX + (indexX -1) * oneX, startY + indexY  * oneY)
        contentBg:addChild(levelNode)
    end
    
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:removeFromParent()
    end)
    no:leftBottom(106, 20)
    bg:addChild(no, 100)

    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_0.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:clickSynthesis()
        self:removeFromParent()
    end)
    yes:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:disableClick()
    end)
    yes:rightBottom(106, 20)
    self.yesBtn = yes
    bg:addChild(yes, 100)
end

-- 传递回调函数名字
function GemSynthesisTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
end

-- 更新视图
function GemSynthesisTips:onUpdateView()

end

function GemSynthesisTips:disableClick()
    local enable = true
    if(not (self.isGemStone or self.isGemCrystal)) then 
        UI.ScrollBar:createByText(UI.TEXT_1325303)
        return false
    else
        local haveOne = false
        for k,v in ipairs(self.gemLevelArr) do
            if(v.isChecked) then 
                haveOne = true
                break
            end
        end
        if(not haveOne) then 
            UI.ScrollBar:createByText(UI.TEXT_1325304)
            return false
        end
    end

    return true
end

function GemSynthesisTips:clickSynthesis()
    if self:disableClick() then
        local levelArr = {} 
        for k,v in ipairs(self.gemLevelArr) do
            if(v.isChecked) then 
                table.insert(levelArr, v.level)
            end
        end
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetNPCSystem:reqQuickComposeGem(levelArr, self.isGemStone, self.isGemCrystal)
    end
end

function GemSynthesisTips:refreshBtnState()
    local enable = true
    if(not (self.isGemStone or self.isGemCrystal)) then 
        enable = false
    end
    if(enable) then
        local haveOne = false
        for k,v in ipairs(self.gemLevelArr) do
            if(v.isChecked) then 
                haveOne = true
                break
            end
        end
        if(not haveOne) then 
            enable = false
        end
    end
    if(self.yesBtn) then 
        if(enable) then
            self.yesBtn:enable()
        else
            self.yesBtn:disable()
        end
    end
end

function GemSynthesisTips:createCheckBoxWithLabel(text, data, initialStateFunc, cb)
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:enableAutoWidth()
    boxLayout:enableAutoHeight()
    boxLayout.data = data

    local boxItself = UI.CheckBox:create() 
    boxItself:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png")
    boxItself:floatLeft(0)
    boxItself:setValue(initialStateFunc and initialStateFunc(boxLayout) or false)
    boxItself:setName("boxItself")
    boxLayout:addComponent(boxItself)
    boxItself:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked, isByTouch)
        print("ddddddddddddddddddd")
        if (cb) then cb(isChecked, boxLayout, comp, isByTouch) end
    end)

    local boxLabel = UI.Text:create()
    boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    boxLabel:setWidth(240)
    boxLabel:setTextLeft()
    boxLabel:autoAdapt()
    boxLabel:setLineSpacing(-6)
    boxLabel:floatLeft(9)
    boxLayout:addComponent(boxLabel)

    return boxLayout
end