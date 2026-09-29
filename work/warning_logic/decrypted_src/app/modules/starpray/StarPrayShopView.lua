------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local LayoutUtil = require "app.ui.UILayoutUtils"
local StarPrayShopView = class("StarPrayShopView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()
local StarPrayBagLayer = require("app.modules.starpray.StarPrayBagLayer")
-- 资源
local COM_RES_LIST = {
    "ui_town_starpray.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local LAYOUT_DESIGN_WIDTH = 1136
local LAYOUT_DESIGN_HEIGHT = 640
-- 图片名字
local SPRITE = {
    BUTTON_NORMAL = "ui_btn_gray2_0.png",
    BUTTON_ACTIVE = "ui_btn_gray2_1.png",
    BUTTON_DISABLE = "ui_btn_gray2_2.png",
}

local LAYOUT = {
    
    TAB_LIST_LEFT = 807,
    TAB_LIST_UP = 80,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64,
}
local layoutUU
function StarPrayShopView:ctor(param)
    StarPrayShopView.super.ctor(
    	 self,
    	 UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )
    self:bindModel();
    self.spriteId = param
    local npcId = param
    mvc.starPrayModel:setNpcId(npcId)
    layoutUU = UIUtil:createAutoUILayout("StarPrayEquipView","app.modules.starpray.StarPrayPosConfig", false)
end    
function StarPrayShopView:dtor()
    StarPrayShopView.super.dtor(self)
    self:unbindModel();
end

function StarPrayShopView:createBg()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)

    local board = UI.Image:create()
    board:init("ui_4package_box_board.png")
    board:leftBottom(77, 16)
    contentLayout:addChild(board, 1)

    -- local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    -- centerBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    -- centerBg:setCapInsets(CCRectMake(304, 141, 1, 1))
    -- centerBg:setPosition(cc.p(COM_WIDTH / 2+95, COM_HEIGHT / 2 +20))
    -- contentLayout:addChild(centerBg,2)

    local upLine = UI.Image:create()
    upLine:init("ui_4package_box_up2.png")
    upLine:centerUp(35)
    contentLayout:addChild(upLine, 12)

    local upLine = UI.Image:create()
    upLine:init("ui_bg_title.png")
    upLine:centerUp(20)
    contentLayout:addChild(upLine, 12)

    local text = UIUtil:createAdaptTextComponent(UI.TEXT_1212742,  UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155,200)
    text:center()
    upLine:addChild(text)

    local bottomLine = UI.Image:create()
    bottomLine:init("ui_4package_box_down.png")
    bottomLine:leftBottom(15, 0)
    contentLayout:addChild(bottomLine, 12)

    local leftLine = UI.Image:create()
    leftLine:init("ui_4package_box_left.png")
    leftLine:leftBottom(14, 18)
    contentLayout:addChild(leftLine, 11)

    local rightLine = UI.Image:create()
    rightLine:init("ui_4package_box_right.png")
    rightLine:rightBottom(10, 18)
    contentLayout:addChild(rightLine, 4)


    return contentLayout
end

-- 注册监听事件(可选)
function StarPrayShopView:bindModel()
end


-- 注销监听事件(可选)
function StarPrayShopView:unbindModel()

end

function StarPrayShopView:onInitView()
    self:createBg()
    self:center(0,0)
    
    mvc.send(mvc.events.StarPray_ShowShopView, self.spriteId)
end




return StarPrayShopView












