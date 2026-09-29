--[[
  怪物详情界面。
  需求：长按怪物1秒出现怪物详情界面,松手立即移除
]]
UI = UI or {}
local MonsterBoxLayer = class("MonsterBoxLayer",UI.HWBtnComponent)
UI.MonsterBoxLayer = MonsterBoxLayer

local MonsterBoxLayerTable = {}

local MONSTER_BOX_INIT_INFO = {
  X = 0,
  Y = 0,
  WIDTH = 276,
  HEIGHT = 427
}

local MONSTER_BOX_RES_LIST = {
}

local MONSTER_BOX_SPRITE_FRAME_MAP = {
  M_BOX_BG = "ui_info_banner_monsterinfo.png",
  M_BOX_HEADBANNER_Elite = "icon_monsterhead_banner_elite.png",--精英怪头像边框
  M_BOX_HEADBANNER_Normal = "icon_monsterhead_banner_normal.png",--普通怪物头像边框
  M_BOX_BLOOD = "symbol_gaming_blood.png",--血量图标
  M_BOX_MONEY = "symbol_gaming_money.png",--黄金图标
  M_BOX_XP = "symbol_gaming_xp_cn.png",--经验图片 中文
  M_BOX_MATK = "symbol_gaming_maggicatk.png",
  M_BOX_ATK = "symbol_gaming_atk.png",--攻击力图标
  M_BOX_ASPD = "symbol_gaming_aspd.png",--攻击图标
  M_BOX_DEF = "symbol_gaming_def.png",--防御图标
  M_BOX_MDEF = "symbol_gaming_maggicdef.png",
  M_BOX_FIRE_1 = "symbol_monsterattribute_fire_1.png", -- 火攻击
  M_BOX_FIRE_2 = "symbol_monsterattribute_fire_2.png", -- 火防御
  M_BOX_WATER_1 = "symbol_monsterattribute_water_1.png", -- 水
  M_BOX_WATER_2 = "symbol_monsterattribute_water_2.png", -- 水
  M_BOX_WOOD_1 = "symbol_monsterattribute_wood_1.png", -- 木light
  M_BOX_WOOD_2 = "symbol_monsterattribute_wood_2.png", -- 木
  M_BOX_LIGHT_1 = "symbol_monsterattribute_light_1.png", -- 光
  M_BOX_LIGHT_2 = "symbol_monsterattribute_light_2.png", -- 光
  M_BOX_DARK_1 = "symbol_monsterattribute_dark_1.png", -- 暗
  M_BOX_DARK_2 = "symbol_monsterattribute_dark_2.png", -- 暗
  M_BOX_FIRE = "symbol_monsterattribute_fire_0.png"
}

local MONSTER_PANEL_SPRITE_FRAME_MAP = {
    WEEKPOINT_VALUE = "symbol_monsterattribute_%s_0.png",
    M_ATK = "symbol_gaming_atk.png",
    M_DEF = "symbol_gaming_def.png",
    M_MDEF = "symbol_gaming_maggicdef.png",
    M_ASPD = "symbol_gaming_aspd.png",
    M_ATT_ATK =  "symbol_monsterattribute_%s_1.png",
    M_ATT_DEF =  "symbol_monsterattribute_%s_2.png",

    ESCAPE_SP_1 = "ui_gaming_battle_escape_1.png",
    ESCAPE_SP_3 = "ui_gaming_battle_escape_3.png",
    MONSTER_INFO_BACK = "ui_banner_gaming_battle_monsterinfo_back.png",

    ICON_EFFECT_TEST_0 = "effect_buff_0.png",
}

local size = cc.Director:getInstance():getWinSize()

function MonsterBoxLayer:ctor()
    print("---------MonsterBoxLayer:ctor-----------")
    MonsterBoxLayer.super.ctor(self, UIType.MONSTER_BOX_LAYER, 
    MONSTER_BOX_RES_LIST,
    MONSTER_BOX_INIT_INFO.WIDTH,
    MONSTER_BOX_INIT_INFO.HEIGHT,
    true)

    self._monsterinfoBg = nil 
    self._data = nil

end

-- 初始化
function MonsterBoxLayer:init(data)
    self._data = data
    -- dump(data)
    MonsterBoxLayer.super.init(self, data)
end

function MonsterBoxLayer:dtor()
--  print("---------dtor-----------")
   self._data = nil
   MonsterBoxLayer.super.dtor(self)
end

function MonsterBoxLayer:onInitView(data)
--  print("---------init-----------")
    self:showLucencyLight()
    AvalonUtil.runTipsAppearShowAnimation(self)

    --背景图片
    self._monsterinfoBg = UI.Image:create()
    self._monsterinfoBg:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_BG)
    self._monsterinfoBg:center()
    self:addChild(self._monsterinfoBg)
    local size = self._monsterinfoBg:getContentSize()

    --普通怪物头像边框
    local left = 20
   
    local monsterIconName = MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_HEADBANNER_Normal
    if(data:getMonsterRare() == 0) then 
        monsterIconName = MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_HEADBANNER_Normal
    elseif data:getMonsterRare() == 1 then 
        monsterIconName = MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_HEADBANNER_Elite
    end
    printInfo("wwwwwwwwwwwwwww", data:getMonsterRare(), monsterIconName)

    local monsterKuangImage = UI.Image:create()
    monsterKuangImage:init(monsterIconName)
    monsterKuangImage:leftUp(left, 14)
    self._monsterinfoBg:addChild(monsterKuangImage)

    local monsterIcon = AvalonUtil.getHeXieSpriteFrameName(data:getIcon() .. (".png"))
    -- print("-----monsterIcon",monsterIcon)
     -- 怪物头像
    local headImage = UI.Image:create()
    headImage:init(monsterIcon)
    headImage:center()
    monsterKuangImage:addChild(headImage)

    local leftMonsterName = 83
    -- 怪物名字
    local roteName  =  data and data:getName() or ""  
    -- roteName = "一天都佛东负担森开动就疯狂反动浪费狂三方东疯狂囧防控DFSDJFFSD"
    local  monstername = UI.Text:create()
    monstername:init("",UI.FONT_BOLD, UI.FONT_SIZE_18PX,UI.FONT_COLOR_41_41_45)
    monstername:setText(string.format("%s", roteName))
    monstername:leftUp(leftMonsterName, 24 - monstername:getContentSize().height/2)
    monstername:setWidth(186)

    local change = false
    if monstername:getContentSize().height >= 30 then
        change = true
    end
    monstername:setSize(186,45)
    monstername:setLineSpacing(-5)
    monstername:setTextLeftUp()
    monstername:autoAdapt()
    self._monsterinfoBg:addChild(monstername)

    local a = data:getAllAffixArr()
    -- dump(a)
    if a == nil or #a ==0 then
        monstername:leftUp(leftMonsterName, 50 - monstername:getContentSize().height/2)
    end

    local cell = 0
    local line = 0
    local startUp = 46
    if change then
        startUp = 66
    end

    for i=1, #a do 
        -- 精英怪物别名
        local monstername_Elite = cc.Label:createWithTTF(string.format("%s", a[i]:getAffixName()), UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_80_5_5)
        monstername_Elite:setTextColor(UI.FONT_COLOR_80_5_5)
        monstername_Elite:setFixLineWidth(88)

        local a,b = math.modf(i/2)
        if i>2 then 
            cell = 1
        end
        line = 0
        if(b ==0) then 
            line = 1
        end
        monstername_Elite:setPosition(leftMonsterName + line * 94 + monstername_Elite:getContentSize().width * monstername_Elite:getScale()/2, self:getContentSize().height - (startUp + cell * 19))
        self._monsterinfoBg:addChild(monstername_Elite)
    end
    
    -- 开始显示属性
    local attrFontSize = UI.FONT_SIZE_16PX
    local attrFontColor = UI.FONT_COLOR_41_41_45
    local leftOffsetX = 21
    local rightOffsetX = 164
    local offsetY = 107
    local startOffsetY = offsetY
    local iconValueOffset = 4
    -- 黄金图标 
    local spCoin = UI.Image:create()
    spCoin:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_MONEY)
    spCoin:leftUp(leftOffsetX, offsetY - spCoin:getContentSize().height/2)
    self._monsterinfoBg:addChild(spCoin)

    -- 黄金数值  
    local coin = data and data.dropCoin or 0
    local coinNum = UI.Text:create()
    coinNum:init("", UI.FONT_STANDARD, attrFontSize, attrFontColor)
    coinNum:setText(string.format("%s", coin))
    coinNum:centerLeft(spCoin:getContentSize().width + iconValueOffset)
    spCoin:addChild(coinNum)

    -- 经验图标
    local spXp = UI.Image:create()
    spXp:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_XP)
    spXp:leftUp(rightOffsetX, offsetY - spXp:getContentSize().height/2)
    self._monsterinfoBg:addChild(spXp)
    -- 经验数值   
    local xpNum = data and data.dropExp or 0
    local xp = UI.Text:create()
    xp:init(string.format("%s", xpNum), UI.FONT_STANDARD, attrFontSize, attrFontColor)
    xp:centerLeft(spXp:getContentSize().width + iconValueOffset)
    spXp:addChild(xp)
    
    offsetY = offsetY + 33
    --血量图标
    local  blood = UI.Image:create()
    blood:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_BLOOD)
    blood:leftUp(leftOffsetX, offsetY - spCoin:getContentSize().height/2)
    self._monsterinfoBg:addChild(blood)
    
    -- 血量数值   
    local hpnumSize = {width = 90,height = 20}
    local hpMax = data and data.hp or 0
    local hpNum = UI.Text:create()
    hpNum:init("", UI.FONT_STANDARD, attrFontSize, attrFontColor)
    hpNum:setText(string.format("%s", hpMax))
    hpNum:centerLeft(blood:getContentSize().width + iconValueOffset)
    blood:addChild(hpNum)
    offsetY = offsetY + 28

    if(data.atkMin == 0 ) then 
        -- 魔发攻击图标
        local  atk = UI.Image:create()
        atk:init("symbol_gaming_maggicatk.png")
        atk:leftUp(leftOffsetX, offsetY - atk:getContentSize().height/2) 
        self._monsterinfoBg:addChild(atk)
        -- 攻击数值
        local  minAct = data and data.magicAtkMin or 0 
        local  maxAct = data and data.magicAtkMax or 0 
        local  actNumStr = minAct.."-"..maxAct
        local  actNum = UI.Text:create()
        actNum:init(string.format("%s", actNumStr), UI.FONT_STANDARD, attrFontSize, attrFontColor)
        actNum:centerLeft(atk:getContentSize().width + iconValueOffset)
        atk:addChild(actNum)
        local maxWidth = 113
        if(actNum:getContentSize().width > maxWidth) then 
            actNum:setFixLineWidth(maxWidth)
        end
    end

    if(data.magicAtkMin == 0) then
        -- wu物理攻击图标
        local  atk = UI.Image:create()
        atk:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_ATK)
        atk:leftUp(leftOffsetX, offsetY - atk:getContentSize().height/2) 
        self._monsterinfoBg:addChild(atk)

        -- 攻击数值 
        local minAct = data and data.atkMin or 0 
        local maxAct = data and data.atkMax or 0 
        local actNumStr = minAct.."-"..maxAct

        local  actNum = UI.Text:create()
        actNum:init("", UI.FONT_STANDARD, attrFontSize, attrFontColor)
        actNum:setText(string.format("%s", actNumStr))
        actNum:centerLeft(atk:getContentSize().width + iconValueOffset)
        atk:addChild(actNum)
        local maxWidth = 113
        if(actNum:getContentSize().width > maxWidth) then 
            actNum:setFixLineWidth(maxWidth)
        end
    end

    -- 攻击速度图标
    local  aspd = UI.Image:create()
    aspd:init(MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_ASPD)
    aspd:leftUp(rightOffsetX, offsetY - aspd:getContentSize().height/2) 
    self._monsterinfoBg:addChild(aspd)

    -- 攻击速度数值 
    local  atkSpd = data and data.atkSpd or 0
    local  aspdNum = UI.Text:create()
    aspdNum:init("", UI.FONT_STANDARD, attrFontSize, attrFontColor)
    aspdNum:setText(string.format("%.1f", atkSpd/1000))
    aspdNum:centerLeft(aspd:getContentSize().width + 4)
    aspd:addChild(aspdNum)

    -- 左边属性
    offsetY = startOffsetY + 93
    local attrArr = {
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_DEF, data.physicDef or 0}, -- 物理防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_FIRE_1, data.atkFire or 0}, -- 火攻击图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_WATER_1, data.atkWater or 0}, -- 水攻击图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_WOOD_1, data.atkWood or 0}, -- 木攻击图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_LIGHT_1, data.atkLight or 0}, -- 光攻击图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_DARK_1, data.atkDark or 0}, -- 暗攻击图标
    }

    for _, attr in ipairs(attrArr) do  
        local oneLayout = self:createOneAttr(attr[1], string.format("%s", attr[2]), attrFontSize, attrFontColor)
        oneLayout:leftUp(leftOffsetX, offsetY - oneLayout:getContentSize().height/2)
        self._monsterinfoBg:addChild(oneLayout)

        offsetY = offsetY + 32
    end

    -- 右边属性
    offsetY = startOffsetY + 93
    local attrRightArr = {
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_MDEF, data.magicDef or 0}, -- 物理防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_FIRE_2, data.defFire or 0}, -- 火防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_WATER_2, data.defWater or 0}, -- 水防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_WOOD_2, data.defWood or 0}, -- 木防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_LIGHT_2, data.defLight or 0}, -- 光防御图标
        {MONSTER_BOX_SPRITE_FRAME_MAP.M_BOX_DARK_2, data.defDark or 0}, -- 暗防御图标
    }

    for _, attr in ipairs(attrRightArr) do  
        local oneLayout = self:createOneAttr(attr[1], string.format("%s", attr[2]), attrFontSize, attrFontColor)
        oneLayout:leftUp(rightOffsetX, offsetY - oneLayout:getContentSize().height/2)
        self._monsterinfoBg:addChild(oneLayout)

        offsetY = offsetY + 32
    end

    -- 弱点
    local weakness =  data.weaknessType
    local  weaknessText = nil
    if (weakness) then 
        --弱点
        weaknessText = UI.Text:create()
        weaknessText:init(UI.TEXT_DES_WEAK, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
        self._monsterinfoBg:addChild(weaknessText)
    end 

    --弱点图标
    local weaknessAtr = "fire"
    if weakness == 1 then
        weaknessAtr = "fire"
    elseif weakness == 2 then
        weaknessAtr = "water"
    elseif weakness == 3  then
        weaknessAtr = "wood"
    elseif weakness == 0 then
        weaknessAtr = ""
    elseif weakness == 4 then
        weaknessAtr = "light"
    elseif weakness == 5 then
        weaknessAtr = "dark"
    end

    local weaknessIcon = nil
    if weaknessText and weaknessAtr and weaknessAtr ~= "" then
        local fileName = string.format(MONSTER_PANEL_SPRITE_FRAME_MAP.WEEKPOINT_VALUE, weaknessAtr)
        weaknessIcon = UI.Image:create()
        weaknessIcon:init(fileName)
        weaknessIcon:centerLeft(weaknessText:getContentSize().width + 4)
        weaknessText:addChild(weaknessIcon)
    end
    if weaknessText then
        local offsetX = self._monsterinfoBg:getContentSize().width /2 - (weaknessText:getContentSize().width) /2
        if(weaknessIcon) then 
            offsetX = self._monsterinfoBg:getContentSize().width /2 - (weaknessText:getContentSize().width+ weaknessIcon:getContentSize().width + 4) /2
        end

        weaknessText:leftBottom(offsetX, 26 - weaknessText:getContentSize().height / 2)
    end
end

function MonsterBoxLayer:createOneAttr(iconName, strValue, fontSize, fontColor)
    local iconImage = UI.Image:create()
    iconImage:init(iconName)

    local attrText = UI.Text:create()
    attrText:init(strValue, UI.FONT_STANDARD, fontSize, fontColor)
    attrText:centerLeft(iconImage:getContentSize().width + 4)
    iconImage:addChild(attrText)

    return iconImage
end


function MonsterBoxLayer:removeMonster()
   self:removeFromParent()
end

function MonsterBoxLayer:addTouchEvents()
end

function MonsterBoxLayer:onUpdateView(data)
   
end


