--[[
    UI - 英雄详细属性信息
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.Image"
require "app.ui.common.ImageText"
require "app.ui.common.TextValue"
require "app.ui.common.ScrollView"

UI = UI or {}

local DetailedInfoArea = class("DetailedInfoArea", UI.HWBtnComponent)
UI.DetailedInfoArea = DetailedInfoArea

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local width =  465
local height = 505

local TEXT_VALUE_WIDTH  = 235
local TEXT_VALUE_HEIGHT = 20

local IMAGE_TEXT_WIDTH  = 100
local IMAGE_TEXT_HEIGHT = 30

-- 背包资源
local BAG_BASIC_INFO_AREA_RES_LIST = {
}
--攻击力
local BASIC_INFO_AREA_ATK = "symbol_gaming_atk.png"
--攻速图标
local BASIC_INFO_AREA_ASPD = "symbol_gaming_aspd.png"
-- 物理防御
local BASIC_INFO_AREA_DEF = "symbol_gaming_def.png"
-- 魔法防御
local BASIC_INFO_AREA_DEF_MDEF = "symbol_gaming_maggicdef.png"
-- 属性攻击  
local BASIC_INFO_AREA_ATT_ATK = "symbol_monsterattribute_%s_1.png"
-- 属性防御
local BASIC_INFO_AREA_ATT_DEF = "symbol_monsterattribute_%s_2.png"

-- 详情背景
local DETAILED_INFO_AREA_PANEL_BG = "ui_role_banner_panel.png"
function DetailedInfoArea:ctor()

    DetailedInfoArea.super.ctor(self, UIType.DETAILED_INFO_AREA, BAG_BASIC_INFO_AREA_RES_LIST, width, height)

    self._data = nil 
    --攻击力
    self._atk = nil
    -- --攻击速度
    self._atkSpd = nil
    -- --防御
    self._physicDef = nil
    -- --魔法防御
    self._magicDef = nil
    --魔力
    self._magic = nil
    -- 格挡等级
    self._block  = nil 
    --防御穿透,护甲穿透
    self._penetrate = nil
    --魔法穿透
    self._magePenetrate = nil
    --闪避等级
    self._dodge = nil
    -- 暴击等级
    self._critical = nil
    -- -- 暴击伤害
    -- self._criticalDamage = nil 
    -- 生命回复
    -- self._hpRecover = nil
    -- --魔法回复
    -- self._mpRecover = nil
      --幸运
    self._luck = nil
    --火属性伤害
    self._atkFire = nil
    --水属性伤害
    self._atkWater = nil
    --木属性伤害
    self._atkWood = nil
    --光属性伤害
    self._atkLight = nil
    --暗属性伤害
    self._atkDark = nil

    --火属性防御力
    self._defFire = nil
    --水属性防御力
    self._defWater = nil
    --木属性防御力
    self._defWood = nil
    --光属性防御力
    self._defLight = nil
    --暗属性防御力
    self._defDark = nil
    self._arrow = nil 

    self._closeCallback = nil

    self.criticalParameter = tonumber(ConfigManager:getGeneralForKey("criticalParameter"))          --暴击等级换算成暴击率的系数，暂取7000
    self.physicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter"))   --物理穿透换算成物理穿透率的系数，暂取7000
    self.dodgeParameter = tonumber(ConfigManager:getGeneralForKey("dodgeParameter"))             --闪避等级换算成闪避率的系数，暂取7000
    self.dodgeActionParameter = tonumber(ConfigManager:getGeneralForKey("dodgeActionParameter"))       --一个参数，用来调整闪避的作用，暂取7000
    self.blockParameter = tonumber(ConfigManager:getGeneralForKey("blockParameter"))             --格挡等级换算成格挡率的系数，暂取7000
    self.mpActionParameter = tonumber(ConfigManager:getGeneralForKey("mpActionParameter"))          --一个参数，用于调整魔法值的作用，暂取值40
    self.magicActionParameter = tonumber(ConfigManager:getGeneralForKey("magicActionParameter"))       --一个参数，用于调整中魔力的作用，暂取值3
    self.magicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter"))  

end

-- 析构函数
function DetailedInfoArea:dtor()
    
    self._data = nil 

    --攻击力
    self._atk = nil
    -- --攻击速度
    self._atkSpd = nil
    -- --防御
    self._physicDef = nil
    -- --魔法防御
    self._magicDef = nil

    --火属性伤害
    self._atkFire = nil
    --水属性伤害
    self._atkWater = nil
    --木属性伤害
    self._atkWood = nil
    --光属性伤害
    self._atkLight = nil
    --暗属性伤害
    self._atkDark = nil

    --火属性防御力
    self._defFire = nil
    --水属性防御力
    self._defWater = nil
    --木属性防御力
    self._defWood = nil
    --光属性防御力
    self._defLight = nil
    --暗属性防御力
    self._defDark = nil

    --魔力
    self._magic = nil
    -- 格挡等级
    self._block  = nil 
  
    --防御穿透,护甲穿透
    self._penetrate = nil
    --魔法穿透
    self._magePenetrate = nil

    --闪避等级
    self._dodge = nil
    -- 暴击等级
    self._critical = nil
    -- -- 暴击伤害
    -- self._criticalDamage = nil 
    -- -- 生命回复
    -- self._hpRecover =nil
    -- --魔法回复
    -- self._mpRecover = nil
      --幸运
    self._luck = nil
    self._arrow = nil 

    if (self._closeCallback) then
        self._closeCallback()
    end
    self._closeCallback = nil
    DetailedInfoArea.super.dtor(self)
end
local function onActiveArrowHandler(self)
        local remove = cc.CallFunc:create(function() 
            -- if(self._detailedInfoArea) then 
            self:removeFromParent()
            -- self._detailedInfoArea = nil
            -- end 
          
        end)
        self:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-400,self:getPositionY())),remove))
        self._arrow:hide()
end 
-- public:
-- 初始化
function DetailedInfoArea:init(data)
    print("DetailedInfoArea init:")
    DetailedInfoArea.super.init(self, data)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, infoArea , touchPosition)
    --     self:close()
    --     self:getParent():setDetailInfoNull()
    -- end)
end

-- 销毁
function DetailedInfoArea:onDestroy()
    print("DetailedInfoArea onDestroy:")
end

-- 初始化视图
function DetailedInfoArea:onInitView()
    print("DetailedInfoArea onInitView:")
    self:showLucencyLight()
    local fontsize = UI.FONT_SIZE_16PX
    local font     = UI.FONT_STANDARD
    
    self._panlebg = UI.Image:create()
    self._panlebg:init(DETAILED_INFO_AREA_PANEL_BG)
    self._panlebg:center()
    self:addChild(self._panlebg)

    -- 创建中心区域

    local firstLeft = 30
    local IMAGE_RANK_LEFT = 242
    local startY = 12 + 5
    local oneCellHeight = 47
    local attrFixWidth = 100

    --攻击力
    self._atk = nil
    self._atk = UI.ImageText:create()
    self._atk:init(BASIC_INFO_AREA_ATK, UI.TEXT_1213751, font, fontsize)
    self._atk:leftUp(firstLeft, startY)
    self._atk:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atk:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atk)
    
    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atk._textSpace, 9)
    self._atk:addChild(num, 10)
    self._atk.num = num

    -- --攻击速度
    self._atkSpd = nil
    self._atkSpd = UI.ImageText:create()
    self._atkSpd:init(BASIC_INFO_AREA_ASPD, UI.TEXT_1213750, font, fontsize)
    self._atkSpd:leftUp(IMAGE_RANK_LEFT,startY)
    self._atkSpd:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atkSpd:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkSpd)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkSpd._textSpace, 9)
    self._atkSpd:addChild(num, 10)
    self._atkSpd.num = num

    -- --防御
    self._physicDef = nil
    self._physicDef = UI.ImageText:create()
    self._physicDef:init(BASIC_INFO_AREA_DEF, UI.TEXT_1213730, font, fontsize)
    self._physicDef:leftUp(firstLeft, startY  + oneCellHeight)
    self._physicDef:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._physicDef:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._physicDef)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._physicDef._textSpace, 9)
    self._physicDef:addChild(num, 10)
    self._physicDef.num = num

    -- --魔法防御
    self._magicDef = nil
    self._magicDef = UI.ImageText:create()
    self._magicDef:init(BASIC_INFO_AREA_DEF_MDEF, UI.TEXT_1213731, font, fontsize)
    self._magicDef:leftUp(IMAGE_RANK_LEFT, startY  + oneCellHeight)
    self._magicDef:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._magicDef:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._magicDef)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._magicDef._textSpace, 9)
    self._magicDef:addChild(num, 10)
    self._magicDef.num = num

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(420, 2)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(self._panlebg:getContentSize().width/2, self._panlebg:getContentSize().height - 116))
    self._panlebg:addChild(lineUpImage)


    -- 火属性开始的位置
    local IMAGE_ROW_UP    = 132 + 8
    -- 属性的高
    local IMAGE_ROW_HEIGHT = 45 
    --火属性伤害
    self._atkFire = nil
    self._atkFire = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_ATK,"fire", font, fontsize)
    self._atkFire:init(spritename, UI.TEXT_1213740, font, fontsize)
    self._atkFire:leftUp(firstLeft,IMAGE_ROW_UP-20)
    self._atkFire:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._magicDef:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkFire)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkFire._textSpace, 9)
    self._atkFire:addChild(num, 10)
    self._atkFire.num = num

    --水属性伤害
    self._atkWater = nil
    self._atkWater = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_ATK,"water", font, fontsize)
    self._atkWater:init(spritename, UI.TEXT_1213741, font, fontsize)
    self._atkWater:leftUp(firstLeft,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT -20)
    self._atkWater:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atkWater:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkWater)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkWater._textSpace, 9)
    self._atkWater:addChild(num, 10)
    self._atkWater.num = num

    --木属性伤害
    self._atkWood = nil
    self._atkWood = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_ATK,"wood", font, fontsize)
    self._atkWood:init(spritename, UI.TEXT_1213742, font, fontsize)
    self._atkWood:leftUp(firstLeft,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*2 -20)
    self._atkWood:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atkWood:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkWood)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkWood._textSpace, 9)
    self._atkWood:addChild(num, 10)
    self._atkWood.num = num

    --光属性伤害
    self._atkLight = nil
    self._atkLight = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_ATK,"light", font, fontsize)
    self._atkLight:init(spritename, UI.TEXT_1213743, font, fontsize)
    self._atkLight:leftUp(firstLeft,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*3 -20)
    self._atkLight:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atkLight:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkLight)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkLight._textSpace, 9)
    self._atkLight:addChild(num, 10)
    self._atkLight.num = num

    --暗属性伤害
    self._atkDark = nil
    self._atkDark = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_ATK,"dark", font, fontsize)
    self._atkDark:init(spritename, UI.TEXT_1213744, font, fontsize)
    self._atkDark:leftUp(firstLeft,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*4 -20)
    self._atkDark:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._atkDark:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._atkDark)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._atkDark._textSpace, 9)
    self._atkDark:addChild(num, 10)
    self._atkDark.num = num

    --火属性防御力
    self._defFire = nil
    self._defFire = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_DEF,"fire", font, fontsize)
    self._defFire:init(spritename, UI.TEXT_1213745, font, fontsize)
    self._defFire:leftUp(IMAGE_RANK_LEFT,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*0 -20)
    self._defFire:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._defFire:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._defFire)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._defFire._textSpace, 9)
    self._defFire:addChild(num, 10)
    self._defFire.num = num

    --水属性防御力
    self._defWater = nil
    self._defWater = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_DEF,"water", font, fontsize)
    self._defWater:init(spritename, UI.TEXT_1213746, font, fontsize)
    self._defWater:leftUp(IMAGE_RANK_LEFT,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*1 - 20)
    self._defWater:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._defWater:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._defWater)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._defWater._textSpace, 9)
    self._defWater:addChild(num, 10)
    self._defWater.num = num

    --木属性防御力
    self._defWood = nil
    self._defWood = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_DEF,"wood", font, fontsize)
    self._defWood:init(spritename, UI.TEXT_1213747, font, fontsize)
    self._defWood:leftUp(IMAGE_RANK_LEFT,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*2 - 20)
    self._defWood:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._defWood:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._defWood)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._defWood._textSpace, 9)
    self._defWood:addChild(num, 10)
    self._defWood.num = num

    --光属性防御力
    self._defLight = nil
    self._defLight = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_DEF,"light", font, fontsize)
    self._defLight:init(spritename, UI.TEXT_1213748, font, fontsize)
    self._defLight:leftUp(IMAGE_RANK_LEFT,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*3 - 20)
    self._defLight:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._defLight:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._defLight)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._defLight._textSpace, 9)
    self._defLight:addChild(num, 10)
    self._defLight.num = num

    --暗属性防御力
    self._defDark = nil
    self._defDark = UI.ImageText:create()
    local spritename = string.format(BASIC_INFO_AREA_ATT_DEF,"dark", font, fontsize)
    self._defDark:init(spritename, UI.TEXT_1213749, font, fontsize)
    self._defDark:leftUp(IMAGE_RANK_LEFT,IMAGE_ROW_UP + IMAGE_ROW_HEIGHT*4 - 20)
    self._defDark:setSize(IMAGE_TEXT_WIDTH, IMAGE_TEXT_HEIGHT)
    self._defDark:setTextFixLineWidth(attrFixWidth)
    self._panlebg:addChild(self._defDark)

    local num = UI.Text:create()
    num:init("", font, fontsize, UI.FONT_COLOR_41_41_45)
    num:centerLeft(self._defDark._textSpace, 9)
    self._defDark:addChild(num, 10)
    self._defDark.num = num

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(420, 2)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(self._panlebg:getContentSize().width/2, self._panlebg:getContentSize().height - 348))
    self._panlebg:addChild(lineUpImage)

    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(410, 210)
    -- upLayout:centerUp(0)

    local detailedScrollView = UI.ScrollView:create()
    detailedScrollView:setSize(410,170)
    detailedScrollView:init(2, 0, 4, 10)
    detailedScrollView:centerBottom(2)
    detailedScrollView:addInnerNode(upLayout)
    self:addChild(detailedScrollView)
    detailedScrollView:setScrollBarEnabled(true)
    detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    -- detailedScrollView:enableDebugDraw()
    self._detailedScrollView = detailedScrollView

    local offsetY = 4
    local secondLeft = 0
    local paddingHeight = 22
    --魔力
    self._magic = self:createTextValue(UI.TEXT_DES_MAGIC)
    self._magic:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._magic)
    offsetY = offsetY + paddingHeight

    --幸运
    self._luck = self:createTextValue(UI.TEXT_DES_LUCK)
    self._luck:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._luck)
    offsetY = offsetY + paddingHeight

    -- 格挡等级
    self._block = self:createTextValue(UI.TEXT_DES_BLOAK_LEVEL)
    self._block:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._block)
    offsetY = offsetY + paddingHeight

    --防御穿透,护甲穿透
    self._penetrate = self:createTextValue(UI.TEXT_DES_PENETRATE)
    self._penetrate:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._penetrate)
    offsetY = offsetY + paddingHeight

    -- 魔法穿透
    self._magePenetrate = self:createTextValue(UI.TEXT_DES_MAGIC_PENETRATE)
    self._magePenetrate:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._magePenetrate)
    offsetY = offsetY + paddingHeight

    --闪避等级
    self._dodge = self:createTextValue(UI.TEXT_DES_DODGE)
    self._dodge:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._dodge)
    offsetY = offsetY + paddingHeight
    -- self._dodge:enableDebugDraw()

    -- 暴击等级
    self._critical = self:createTextValue(UI.TEXT_DES_CRITICAL)
    self._critical:leftUp(secondLeft,offsetY)
    upLayout:addChild(self._critical)
    offsetY = offsetY + paddingHeight

    if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_ADVANCED) then
        -- add by zp 新增显示
        local LanguageManager = require("app.game.LanguageManager")
        self._fireEnergy = self:createTextValue(LanguageManager:getInstance():getLocalString(1111618)..":")
        self._fireEnergy:leftUp(secondLeft,offsetY)
        upLayout:addChild(self._fireEnergy)
        offsetY = offsetY + paddingHeight

        self._waterEnergy = self:createTextValue(LanguageManager:getInstance():getLocalString(1111619)..":")
        self._waterEnergy:leftUp(secondLeft,offsetY)
        upLayout:addChild(self._waterEnergy)
        offsetY = offsetY + paddingHeight

        self._woodEnergy = self:createTextValue(LanguageManager:getInstance():getLocalString(1111620)..":")
        self._woodEnergy:leftUp(secondLeft,offsetY)
        upLayout:addChild(self._woodEnergy)
        offsetY = offsetY + paddingHeight

        self._lightEnergy = self:createTextValue(LanguageManager:getInstance():getLocalString(1111621)..":")
        self._lightEnergy:leftUp(secondLeft,offsetY)
        upLayout:addChild(self._lightEnergy)
        offsetY = offsetY + paddingHeight

        self._darkEnergy = self:createTextValue(LanguageManager:getInstance():getLocalString(1111622)..":")
        self._darkEnergy:leftUp(secondLeft,offsetY)
        upLayout:addChild(self._darkEnergy)
        offsetY = offsetY + paddingHeight
    end

    if(offsetY > upLayout:getContentSize().height) then 
        upLayout:setSize(upLayout:getContentSize().width, offsetY)
    end
    
    -- 添加蒙层
    local mengImage = UI.Image:create()
    mengImage:init("ui_role_banner_panel_up.png")
    mengImage:centerBottom(-14)
    self:addChild(mengImage)
end

function DetailedInfoArea:createTextValue(name)
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(273, 20)
    local value1 = UI.Text:create()
    value1:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_91_47_7)
    value1:centerLeft(2)
    textLayout:addChild(value1)

    local value2 = UI.Text:create()
    value2:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    value2:centerLeft(238)
    textLayout:addChild(value2)

    textLayout.value1 = value1
    textLayout.value2 = value2
    textLayout.setText = function(self, text)
        self.value2:setText(text)
    end 

    return textLayout
end

-- 更新视图
function DetailedInfoArea:onUpdateView(data)
    print("DetailedInfoArea onUpdateView:")

    if data == nil then 
        data =  RoleDataManager:getMaster() 
    end
    if(not tolua.isnull(self._detailedScrollView)) then 
        self._detailedScrollView:setScrollBarWidth(3)
        self._detailedScrollView:setCircleVisible(false)
    end

    -- 攻击力
    local atk = data.atkMin.."-"..data.atkMax
    self._atk.num:setText(string.format("%s", atk))
    -- --攻击速度
    self._atkSpd.num:setText(string.format("%.1f", data.atkSpd/1000))
    -- --防御
    self._physicDef.num:setText(string.format("%s", data.physicDef))
    -- --魔法防御
    self._magicDef.num:setText(string.format("%s", data.magicDef))

    --火属性伤害
    self._atkFire.num:setText(string.format("%s", data.atkFire))
    --水属性伤害
    self._atkWater.num:setText(string.format("%s", data.atkWater))
    --木属性伤害
    self._atkWood.num:setText(string.format("%s", data.atkWood))
    --光属性伤害
    self._atkLight.num:setText(string.format("%s", data.atkLight))
    --暗属性伤害
    self._atkDark.num:setText(string.format("%s", data.atkDark))
  
    --火属性防御力
    self._defFire.num:setText(string.format("%s", data.defFire))
    --水属性防御力
    self._defWater.num:setText(string.format("%s", data.defWater))
    --木属性防御力
    self._defWood.num:setText(string.format("%s", data.defWood))
    --光属性防御力
    self._defLight.num:setText(string.format("%s", data.defLight))
    --暗属性防御力
    self._defDark.num:setText(string.format("%s", data.defDark))

    self._magic:setText(string.format("%s", data.magic))

    -- self._block:setText(string.format("%s",data.block))

    -- self._penetrate:setText(string.format("%s", data.physicPenetrate))
    -- self._magePenetrate:setText(string.format("%s", data.magicPenetrate))
    -- self._dodge:setText(string.format("%s", data.dodge))
    -- self._critical:setText(string.format("%s", data.critical))

    self._block:setText(self:getParames(data.block, self.blockParameter))
    self._penetrate:setText(self:getParames(data.physicPenetrate, self.physicPenetrateParameter))
    self._magePenetrate:setText(self:getParames(data.magicPenetrate, self.magicPenetrateParameter))
    self._dodge:setText(self:getParames(data.dodge, self.dodgeParameter))
    self._critical:setText(self:getParames(data.critical, self.criticalParameter))

    if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_ADVANCED) then
        if(not tolua.isnull(self._fireEnergy)) then
            self._fireEnergy:setText(self:getParames(data.cpxFire, RATIO_NUMBER))
        end
        if(not tolua.isnull(self._waterEnergy)) then
            self._waterEnergy:setText(self:getParames(data.cpxWater, RATIO_NUMBER))
        end
        if(not tolua.isnull(self._woodEnergy)) then
            self._woodEnergy:setText(self:getParames(data.cpxWood, RATIO_NUMBER))
        end
        if(not tolua.isnull(self._lightEnergy)) then
            self._lightEnergy:setText(self:getParames(data.cpxLight, RATIO_NUMBER))
        end
        if(not tolua.isnull(self._darkEnergy)) then
            self._darkEnergy:setText(self:getParames(data.cpxDark, RATIO_NUMBER))
        end
    end

    -- 测试计算结果
    -- self._block:setText(self:getParames(680, self.blockParameter))
    -- self._penetrate:setText(self:getParames(70, self.physicPenetrateParameter))
    -- self._magePenetrate:setText(self:getParames(770, self.magicPenetrateParameter))
    -- self._dodge:setText(self:getParames(1000, self.dodgeParameter))
    -- self._critical:setText(self:getParames(230, self.criticalParameter))

    -- self._critical:setText("1(2.01%)")
    

    -- self._criticalDamage:setText(string.format("%s", data.CritDamageRate))

    -- self._hpRecover:setText(string.format("%s", self._data.hpRecover))
    -- self._mpRecover:setText(string.format("%s", self._data.mpRecover))

    self._luck:setText(string.format("%s", data.luck))
    
    -- self._extGold:setText(string.format("%s", self._data.extGold))
    --攻击力
    self._atk:updateView()
    -- --攻击速度
    self._atkSpd:updateView()
    -- --防御
    self._physicDef:updateView()
    -- --魔法防御
    self._magicDef:updateView()

    --属性伤害
    self._atkFire:updateView()
    self._atkWater:updateView()
    self._atkWood:updateView()
    self._atkLight:updateView()
    self._atkDark:updateView()

    --属性防御力
    self._defFire:updateView()
    self._defWater:updateView()
    self._defWood:updateView()
    self._defLight:updateView()
    self._defDark:updateView()

    --魔力
    self._magic:updateView()
    self._block:updateView()

    --防御穿透,护甲穿透
    self._penetrate:updateView()
    --魔法穿透
    self._magePenetrate:updateView()
    --闪避等级
    self._dodge:updateView()
    -- 暴击等级
    self._critical:updateView()
    -- -- 暴击伤害
    -- self._criticalDamage:updateView()

    -- -- 生命回复
    -- self._hpRecover:updateView()
    -- --魔法回复
    -- self._mpRecover:updateView()
      --幸运
    self._luck:updateView()

    -- --额外经验
    -- self._extExp:updateView()
    -- --额外黄金
    -- self._extGold:updateView()

end

function DetailedInfoArea:getParames(value, valueParameter)
    local newValue = value or 0
    valueParameter = valueParameter or 0
    -- if(newValue > valueParameter) then
    --     newValue = valueParameter
    -- end

    local str = ""
    if(newValue == 0) then
        -- str = string.format("%s(0%%)",newValue)
        str = string.format("0%%")
    else 
        local yu = (newValue * 100/valueParameter)
        -- 这里的效率不好
        local zero = tonumber(string.format("%.0f",yu))
        local one = tonumber(string.format("%.1f",yu))
        local two = tonumber(string.format("%.2f",yu))
        if(zero == one) then
            if(one == two) then
                str = zero
            else 
                str = two
            end
        else 
            if(one == two) then
                str = one
            else 
                str = two
            end
        end 
        -- str = string.format("%s(%s%%)",newValue, str)
        str = string.format("%s%%", str)
    end
    -- local str = string.format("%s(%s%%)",newValue, (newValue * 100/valueParameter))
    -- print("DetailedInfoArea:getParames",str, newValue, valueParameter)
    return str
end 

function DetailedInfoArea:setCloseCallback(func)
    self._closeCallback = func
end