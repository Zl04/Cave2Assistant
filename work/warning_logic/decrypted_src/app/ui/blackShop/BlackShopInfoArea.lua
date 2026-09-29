--[[
    UI - 黑市背包中的道具详情界面
]]--


UI = UI or {}

local BlackShopInfoArea = class("BlackShopInfoArea", UI.HWBtnComponent)
UI.BlackShopInfoArea = BlackShopInfoArea


-- private:
local DEBUG = false
local DEBUG_DRAW = true
-- 背包资源
local BAG_EQUIPMENT_INFO_AREA_RES_LIST = {
    
}

-- local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_ALL = "icon-equip_large_21010010.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

local LEFT_SPACE = 18
-- 构造函数
function BlackShopInfoArea:ctor()
    BlackShopInfoArea.super.ctor(self, UIType.BLACK_SHOP_INFO_AREA, BAG_EQUIPMENT_INFO_AREA_RES_LIST, 324, 279)
    
    -- 装备名字
    self._goodsName = nil 
    self._spriteBg = nil 
    -- 图标
    self._iconSprite = nil 
end

-- 析构函数
function BlackShopInfoArea:dtor()

    -- 装备名字
    self._goodsName = nil 
    self._spriteBg = nil 
    -- 图标
    self._iconSprite = nil 


    BlackShopInfoArea.super.dtor(self)
    
end

-- public:
-- 初始化
function BlackShopInfoArea:init(proptype,data)
    self._proptype = proptype 
    self._goodsData = data

    BlackShopInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
end

-- 点击超链接的处理
local function onActiveChatHandler(self)
    print("====聊天超链接===")
end
  
-- 初始化视图
function BlackShopInfoArea:onInitView()
    self:showLucencyLight()
    -- 面板背景
    local bg = UI.Image:create()
    bg:init("ui_iteminfo_role_banner_box3.png" )
    bg:centerUp(0)
    self:addChild(bg)

    -- 名称
    local  goodsName  = UI.Text:create()
    goodsName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:leftUp(100, 12)
    goodsName:setWidth(200)
    goodsName:setLineSpacing(-5)
    self:addChild(goodsName)
    self._goodsName = goodsName

     -- 装备评分
    local score = UI.Image:create()
    score:init("symbol_character_hero_power.png")
    self:addChild(score)
    self.scoreIcon = score
    
    local goodsScore = UI.Text:create()
    goodsScore:init("???", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    goodsScore:centerLeft(score:getContentSize().width + 4)
    score:addChild(goodsScore)
    self._goodsScore = goodsScore

    -- score:leftUp(205 - score:getContentSize().width / 2 - goodsScore:getContentSize().width / 2 , 60)
    score:leftUp(100, 60)

    -- 武器类型图标
    local equipmentType = UI.Image:create()
    equipmentType:init()
    equipmentType:rightUp(76, 107)
    equipmentType:setScale(0.8)
    self:addChild(equipmentType) 
    self._equipmentType = equipmentType

    local left = LEFT_SPACE
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(LEFT_SPACE - 4, 13)
    -- spriteBg1:setSize(GRID_SIZE_WIDTH * 0.6, GRID_SIZE_HEIGHT* 0.6)
    spriteBg1:setScale(0.9)
    self:addChild(spriteBg1) 
    -- 物品图标背景
    local spriteBg =  UI.Image:create()
    spriteBg:init(SPRITE_GRID_RARE_1)
    spriteBg:center()
    spriteBg1:addChild(spriteBg) 
    self._spriteBg = spriteBg
    -- 物品图标
    local iconSprite =  UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    spriteBg:addChild(iconSprite) 
    self._iconSprite = iconSprite

    local lineX = 162
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(281, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(lineX, 279 - 93))
    bg:addChild(lineUpImage, 4)

    -- 物品图标右边的三个问号
    for i = 1,3 do 
        local rightMark  = UI.Text:create()
        rightMark:init(UI.TEXT_1110392, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        rightMark:leftUp(LEFT_SPACE,20*(i - 1)+120)
        self:addChild(rightMark)
    end 

    local lineCenterImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineCenterImage:setContentSize(281, 1)
    lineCenterImage:setCapInsets(CCRectMake(1,0,1,1))
    lineCenterImage:setPosition(cc.p(lineX, 279 - 93 - 99))
    -- lineCenterImage:setPosition(cc.p(lineX, 279 - 93))
    bg:addChild(lineCenterImage, 4)

    -- 物品图标下面边的三个问号
    for i = 1,3 do 
        local  bottomMark  = UI.Text:create()
        bottomMark:init(UI.TEXT_1110393, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        bottomMark:leftUp(LEFT_SPACE,20*(i - 1)+ 200)
        self:addChild(bottomMark)
    end 
end


function BlackShopInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function BlackShopInfoArea:getGoodsGrid()
    return self._goodsGrid
end

-- 更新视图
function BlackShopInfoArea:onUpdateView(data)

end
function BlackShopInfoArea:setIconSprite(sprite)
    self._iconSprite:setSpriteName(sprite)
    -- local iconSize = self._iconSprite:getContentSize()
    -- self._iconSprite:setScale(
    --     GRID_SIZE_WIDTH / iconSize.width,
    --     GRID_SIZE_HEIGHT/ iconSize.height
    -- )
end 

function BlackShopInfoArea:setIconName(name)
    print("BlackShopInfoArea:setIconName ", name)
    self._goodsName:setText(name)
    self._goodsName:autoAdapt()
    local up = 33 - self._goodsName:getContentSize().height / 2
    up = up > 0 and up or 0

    -- self.scoreIcon:leftUp(self.scoreIcon:getLeft(), 75)
    --self.scoreIcon:leftUp(self.scoreIcon:getLeft(), self._goodsName:getUp() + self._goodsName:getContentSize().height - 8)
end 




