
UI = UI or {}

local catfoodInfoArea = class("catfoodInfoArea", UI.HWBtnComponent)
UI.catfoodInfoArea = catfoodInfoArea
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()


local DEBUG = false
local DEBUG_DRAW = true
-- 尺寸
local width = 306
local height = 429

-- 背包资源
local BAG_EQUIPMENT_INFO_AREA_RES_LIST = {
    "ui_town_catfood.plist",
}

local SPRITE_GRID_RARE_1 = "box_quality_0_1.png"
local SPRITE_EQUIPMENT_ALL = "icon-equip_large_21010010.png"
local SPRITE_EQUIPMENT_NAME = "icon-equip_large_210%s0010.png"
local SPRITE_EQUIPMENT_WEAPON = "icon-equip_large_210%s0010_%s.png"

-- 背景1
local SPRITE_EQUIPMENT_AREA_BG_UP = "ui_iteminfo_role_banner_box2.png" 
-- 属性前面的点
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"


-- 构造函数
function catfoodInfoArea:ctor()
    self._data = nil 
    catfoodInfoArea.super.ctor(self, UIType.CATFOODINFO_UI, BAG_EQUIPMENT_INFO_AREA_RES_LIST, width, height)
end

-- 析构函数
function catfoodInfoArea:dtor()

    catfoodInfoArea.super.dtor(self)
end

-- public:
-- 初始化
function catfoodInfoArea:init(data)

    self._data = data 
    catfoodInfoArea.super.init(self, data)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

-- 销毁
function catfoodInfoArea:onDestroy()
end


-- 初始化视图
function catfoodInfoArea:onInitView(data)

    local data = self._data

    local goodsbg = UI.Image:create()
    goodsbg:init(SPRITE_EQUIPMENT_AREA_BG_UP)
    goodsbg:leftUp(-5,0)
    self:addChild(goodsbg)
    
    -- 物品图标背景底框
    local spriteBg1 =  UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:leftUp(35  , 80)
    spriteBg1:setSize(80, 80)
    self:addChild(spriteBg1) 

    -- 物品等级图框
    local spriteBg =  UI.Image:create()
    spriteBg:init()
    spriteBg:center()
    spriteBg1:addChild(spriteBg) 
    self._spriteBg = spriteBg
    
    -- 物品图标
    local iconSprite = UI.Image:create()
    iconSprite:init()
    iconSprite:center()
    self._spriteBg:addChild(iconSprite)
    self._iconSprite = iconSprite

    -- 猫饭道具名称
    self.goodsName  = UI.Text:create()
    self.goodsName:init()
    self.goodsName:centerUp(15)
    self.goodsName:setFontSize(18)
    self.goodsName:setFontColor(UI.FONT_COLOR_88_65_34)
    self.goodsName:setTextCenter()
    self:addChild(self.goodsName)
    -- self.goodsName:enableDebugDraw()
    -- 猫饭文字
    local catfoodText  = UI.Text:create()
    catfoodText:init(UI.TEXT_1170030 )
    catfoodText:leftUp(30  , 47)
    catfoodText:setFontSize(15)
    catfoodText:setFontColor(UI.FONT_COLOR_88_65_34)
    catfoodText:setTextCenter()
    self:addChild(catfoodText)

    -- 猫饭描述
    self.des  = UI.Text:create()
    self.des:init("",UI.FONT_DES)
    self.des:leftUp(35 , 310)
    self.des:setFontSize(15)
    self.des:setFontColor(UI.FONT_COLOR_140_43_27)
    self.des:setTextCenter()
    self:addChild(self.des)

    -- 描述签名带点的
    local point =  UI.Image:create()
    point:init("ui_iteminfo_icon_point_01.png")
    point:leftUp(30  , 186.5)
    self:addChild(point) 
    -- 猫饭详情描述
    self.effedes  = UI.Text:create()
    self.effedes:init()
    self.effedes:leftUp(38  , 180)
    self.effedes:setFontSize(15)
    self.effedes:setFontColor(UI.FONT_COLOR_88_65_34)
    self.effedes:setTextCenter()
    self:addChild(self.effedes)
    for k,v in pairs(data) do 
        if(k == "name") then 
            self.goodsName:setText(string.format(v))
        end 
        if(k == "goodsRare") then 
            self._spriteBg:setSpriteName(string.format("box_quality_0_%s.png",v))
        end 
        if(k == "icon") then 
            self._iconSprite:setSpriteName(string.format(v)) 
        end
        if(k == "description") then 
            if v ~= 0 then
                self.des:setText(languageManagerInstance:getLocalString(v))
            end
        end
        if(k == "effecDescription") then 
            if v ~= 0 then
                self.effedes:setText(languageManagerInstance:getLocalString(v))
            end
        end
    end 

end

-- 更新视图
function catfoodInfoArea:onUpdateView(data)
   
end



