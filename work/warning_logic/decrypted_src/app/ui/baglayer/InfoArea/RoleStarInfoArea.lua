--[[
    UI - 
]]--

UI = UI or {}

local RoleStarInfoArea = class("RoleStarInfoArea", UI.HWBtnComponent)
UI.RoleStarInfoArea = RoleStarInfoArea
local COM_RES_LIST = {
    "ui_town_starpray.plist",
}

local layerSize = cc.size(431, 500)
function RoleStarInfoArea:ctor()
    RoleStarInfoArea.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self:setTouchEnable(true)
    self:registerListener()
end

function RoleStarInfoArea:init(starData)
    self.starData = starData
    RoleStarInfoArea.super.init(self)
end

-- 析构函数
function RoleStarInfoArea:dtor()
    RoleStarInfoArea.super.dtor(self)
end


-- 初始化视图
function RoleStarInfoArea:onInitView()
    print("RoleStarInfoArea onInitView:")
    self:showLucencyLight()
    -- local bg = UI.Image:create()
    -- bg:init("ui_starpray_paper.png")
    -- bg:centerUp(30)
    -- self:addChild(bg)

    -- local logo = UI.Image:create()
    -- logo:init("ui_starpray_bg.png")
    -- logo:centerUp(130)
    -- bg:addChild(logo)

    -- local title = UI.Text:create()
    -- title:init(UI.TEXT_1212327, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    -- title:centerUp(8)
    -- bg:addChild(title)

    --      -- 添加分割线
    -- local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    -- lineUpImage:setContentSize(370, 1)
    -- lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    -- lineUpImage:setPosition(cc.p(220, 444))
    -- bg:addChild(lineUpImage)

    local GameDataManager = require("app.game.GameDataManager")
    local heroData = GameDataManager:getInstance():getMaster()
    require("app.modules.starpray.StarPrayCircle")
    local layer = UI.StarPrayCircle:create(false)
    layer:init(heroData, self.starData)
    layer:centerUp(30)
    self:addChild(layer)
end

-- 更新视图
function RoleStarInfoArea:onUpdateView(data)
    print("RoleStarInfoArea onUpdateView:")
end


-- 注册监听事件(可选)
function RoleStarInfoArea:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

-- 点击外部区域的处理器(关闭)(可选)
function RoleStarInfoArea:onTouchOutSizeEvent()
    self:close()
end
