-- TestPanel.lua
-- Author:zp
-- 2017年5月3日
-- Using:测试页面

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local TestPanel = class("TestPanel", UI.HWBtnComponent)
UI.TestPanel = TestPanel

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 背包资源
local COM_RES_LIST = {
    "ui_package_log.plist",
}

-- 图片名字
local TEST_PANEL_SPRITE = {
    BACKGROUND = "ui_log_banner_page_00.png",
    EDITE_NORMAL = "ui_goods_button_dustbin_0.png",
    BUTTON_END_NORMAL = "ui_goods_button_dustbin_0.png",
    BUTTON_END_ACTIVE = "ui_goods_button_dustbin_1.png",
}

-- 构造函数
function TestPanel:ctor()
    TestPanel.super.ctor(self, UIType.TEST_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

end

-- 析构函数
function TestPanel:dtor()
    TestPanel.super.dtor(self)
end

-- 初始化
function TestPanel:init()

    TestPanel.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

-- 初始化视图
function TestPanel:onInitView()
    local realLayoutWidth = winSize.width
    local designLayoutWidth = winSize.height
    local scale = realLayoutWidth / designLayoutWidth
    if (scale > 1.0) then scale = 1.0 end

    -- 背景图片
    local bg = cc.Sprite:create()
    bg:setSpriteFrame(TEST_PANEL_SPRITE.BACKGROUND)
    bg:setPosition(self._hw, self._hh)
    bg:setScale(scale)
    self:addChild(bg)

    if SceneManager:getInstance():isInCave() then
        local gotoTile = UI.Text:create()
        gotoTile:init("跳转：", nil, 40, nil)
        gotoTile:setPos(100,100)
        self:addChild(gotoTile)

        local gotoEdit = UI.EditBox:create(210,50)
        gotoEdit:init("请输入跳转楼层", cc.EDITBOX_INPUT_MODE_NUMERIC,TEST_PANEL_SPRITE.EDITE_NORMAL)
        gotoEdit:setPos(200, 100)
        self:addChild(gotoEdit)
        self.gotoLevelEdit = gotoEdit
    end

    -- 完成按钮
    local endBtn = UI.Button:create()
    endBtn:init(TEST_PANEL_SPRITE.BUTTON_END_NORMAL,
        TEST_PANEL_SPRITE.BUTTON_END_ACTIVE)
    endBtn:rightBottom(300,100)
    endBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickEnd)
    endBtn:setText("完成")
    endBtn:setFontSize(70)

    self:addChild(endBtn)
end

-- 更新视图
function TestPanel:onUpdateView()
    print(" TestPanel:onUpdateView  ")

end

-- 点击完成
function TestPanel:clickEnd()
    print("TestPanel:clickEnd ")

    if(self.gotoLevelEdit) then
        local gotoLevel = self.gotoLevelEdit:getText()
        print(" inputText=",gotoLevel)

        if(gotoLevel and gotoLevel ~= "") then
            local level = tonumber(gotoLevel)
            GameManager:testGoToLevel(level)
        end
    end


    self:close()
end