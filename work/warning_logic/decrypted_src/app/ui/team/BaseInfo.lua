--[[
    AUTHOR:ZIHANCHEN
    2017-5-03
    USING: 查看角色信息的底部区域信息 攻击强度、法力效果、坚韧
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
-- require "app.ui.common.ProgressTimer"

UI = UI or {}

local BaseInfo = class("BaseInfo", UI.HWBtnComponent)
UI.BaseInfo = BaseInfo

-- private:
local DEBUG = true
local DEBUG_DRAW = true


local TEXT_SPACE = 5

-- 进度条
local PROGRESS_LEFT = 22
local HP_PROGRESS_UP = 20
local MP_PROGRESS_UP = 50
local XP_PROGRESS_UP = 80
-- 分割线
local SPLIT_LINE_LEFT = 100
local HP_SPLIT_LINE_UP = 57
local MP_SPLIT_LINE_UP = 87
local XP_SPLIT_LINE_UP = 117
-- 进度条文本信息
local PROGRESS_TEXT_LEFT = 22
local HP_PROGRESS_TEXT_UP = 20
local MP_PROGRESS_TEXT_UP = 50
local XP_PROGRESS_TEXT_UP = 80
local PROGRESS_TEXT_WIDTH = 138
local PROGRESS_TEXT_HEIGHT = 25
-- 角色属性文本 攻击强度、韧性
local ROLE_ATTTRIBUTE_LEFT = 150
local ATTACK_STRENGTH_UP = 42
local MAGIC_EFFECT_UP = 70
local TENACITY_UP = 98
local ROLE_ATTTRIBUTE_WIDTH = 80
local ROLE_ATTTRIBUTE_HEIGHT = 25
-- 角色属性数值
local ROLE_ATTRIBUTE_VALUE_LEFT = 100
local ATTACK_STRENGTH_VALUE_UP = 56
local MAGIC_EFFECT_VALUE_UP = 28
local TENACITY_VALUE_UP = 0
local ROLE_ATTRIBUTE_VALUE_WIDTH = 100
local ROLE_ATTRIBUTE_VALUE_HEIGHT = 25

-- 构造函数
function BaseInfo:ctor()
    BaseInfo.super.ctor(self, UIType.BASE_INFO, nil, 483, 121)

    self._nickNameDes = nil
    self._booldTimer = nil 
    self._mpTimer = nil 
    self._xpTimer = nil  
    -- 值
    self._attackValue = nil 
    self._magicValue  = nil 
    self._tenacityValue = nil 
    -- 攻击强度等三个值
    self._attackStrength = 0
    self._tough   = 0
    self._spellEffect = 0 

    self._lastchange = 1
    self._basedata = nil 
end

-- 析构函数
function BaseInfo:dtor()
    self._nickNameDes = nil
    self._booldTimer = nil 
    self._mpTimer = nil 
    self._xpTimer = nil 
    self._attackValue = nil 
    self._magicValue  = nil 
    self._tenacityValue = nil 
    self._basedata = nil 

    BaseInfo.super.dtor(self)
end

-- public:
-- 初始化
function BaseInfo:init(data)
    self._basedata = data 
    BaseInfo.super.init(self, data)
end

-- 销毁
function BaseInfo:onDestroy()
end

-- 初始化视图
function BaseInfo:onInitView()
    local offsetX = 150
    -- 攻击强度
    local attackText = UI.Text:create()
    attackText:init(UI.TEXT_DES_ATTACK_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    attackText:setSize(100,25)
    attackText:leftBottom(offsetX, 75 - attackText:getContentSize().height / 2)
    self:addChild(attackText)
    -- 法术效果
    local magicText = UI.Text:create()
    magicText:init(UI.TEXT_DES_MAGIC_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    magicText:setSize(100,25)
    magicText:leftBottom(offsetX,45 - magicText:getContentSize().height / 2)
    self:addChild(magicText)

    -- 坚韧
    local enacityText = UI.Text:create()
    enacityText:init(UI.TEXT_DES_TENACITY_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    enacityText:setSize(100,25)
    enacityText:leftBottom(offsetX,15 - enacityText:getContentSize().height / 2)
    self:addChild(enacityText)

    -- 分割线
    for i = 1, 3 do
        local line = UI.Image:create()
        line:init("ui_character_line.png")
        line:centerBottom(30 * (i - 1))
        self:addChild(line)
    end

    
    local rightOffsetX = 100
    -- 攻击强度值
    self._attackValue = UI.Text:create()
    self._attackValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._attackValue:setTextLeft()
    self._attackValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._attackValue:centerLeft(rightOffsetX)
    attackText:addChild(self._attackValue)
    
    -- 法术强度值
    self._magicValue = UI.Text:create()
    self._magicValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._magicValue:setTextLeft()
    self._magicValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._magicValue:centerLeft(rightOffsetX)
    magicText:addChild(self._magicValue)

    -- 坚韧值
    self._tenacityValue = UI.Text:create()
    self._tenacityValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._tenacityValue:setTextLeft()
    self._tenacityValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._tenacityValue:centerLeft(rightOffsetX)
    enacityText:addChild(self._tenacityValue)
end

function BaseInfo:onUpdatePos()

    self._attackValue:updateView()
    self._magicValue:updateView()
    self._tenacityValue:updateView()
   
end
-- 设置角色数据和装备数据
function BaseInfo:setData(basedata)
    self._basedata = basedata
    -- dump(self._equipmentDataList)
end
-- 更新视图
function BaseInfo:onUpdateView()
    local data = self._basedata
    -- if data == nil then 
    --     data =  RoleDataManager:getMaster() 
    -- end
    if (not data) then return end
    if(data) then 
        local  a = string.format("%s",data:getAttackStrength())
        local  b = string.format("%s",data:getSpellEffect())
        local  c = string.format("%s",data:getTough()) 
        
        self._attackStrength = a
        self._spellEffect = b
        self._tough       = c
        
        -- self._attackValue:setText(self._attackValue:numformat(a))
        -- self._magicValue:setText(self._magicValue:numformat(b))
        -- self._tenacityValue:setText(self._tenacityValue:numformat(c))

        self._attackValue:setText(AvalonUtil:getSimpleNumber(tonumber(a), 4))
        self._magicValue:setText(AvalonUtil:getSimpleNumber(tonumber(b), 4))
        self._tenacityValue:setText(AvalonUtil:getSimpleNumber(tonumber(c), 4))

        -- -- -- 设置进度
        -- -- 最大血量
        -- local  hpMax = data.hp 
        -- -- 当前血量
        -- local  hpNum = data.curHp
        --   if  hpNum > hpMax then
        --       hpNum = hpMax
        -- elseif hpNum < 0 then
        --       hpNum = 0
        -- end

        -- -- 魔法值
        -- local  mpMax = data.mp 
        -- -- 当前血量
        -- local  mpNum = data.curMp
        -- if  mpNum > mpMax then
        --     mpNum = mpMax
        -- elseif mpNum < 0 then
        --     mpNum = 0
        -- end

        -- local  xpMax = data and data.expToNextLV  or 0 
        -- local  xpNum = data and data.curLVExp or 0 

        -- if  xpNum > xpMax then
        --   xpNum = xpMax
        -- elseif xpNum < 0 then
        --   xpNum = 0
        -- end

        -- local hp = ""
        -- local mp = ""
        -- local xp = ""
        -- -- 英雄血量显示方式
        -- local _showType = Game.Manager:getRoleInfoShowType() 
        -- if _showType == ShowType.PERCENT then

        --     local  HP  = math.floor(hpNum/hpMax*100)
        --     local  MP  = math.floor(mpNum/mpMax*100)
        --     local  XP  = math.floor(xpNum/xpMax*100)
        --     hp = HP.."%"
        --     mp = MP.."%"
        --     xp = XP.."%"

        -- elseif _showType == ShowType.VALUE then
        --     hp = "HP:"..hpNum.."/"..hpMax
        --     mp = "MP:"..mpNum.."/"..mpMax 
        --     xp = "XP:"..xpNum.."/"..xpMax 
        -- end

        -- -- self._hpLabel:setText(hp)
        -- -- self._mpLabel:setText(mp)
        -- -- self._xpLabel:setText(xp)

        -- local change = hpNum/hpMax 
        -- self._booldTimer:setPercent(change)
        -- -- self._booldTimer:setBarChange(self._lastchange,change,1000)
        -- self._mpTimer:setPercent(mpNum/mpMax)

        -- self._xpTimer:setPercent(xpNum/xpMax)
        
        -- local isFullLV = data:getIsMaxLevel() 
        -- if isFullLV then 
        --     self._xpTimer:setPercent(0)
        --     self._xpLabel:setText("MAX")
        -- end

        -- 不能满足当前
        self._lastchange = change
        self:onUpdatePos()
    end

end