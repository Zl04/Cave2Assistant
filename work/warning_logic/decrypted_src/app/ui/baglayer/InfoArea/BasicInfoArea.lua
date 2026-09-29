--[[
    UI - 角色背包基础信息
]]--

require "app.ui.Component"
require "app.ui.baglayer.InfoArea.AttributeDes"
require "app.ui.common.ProgressTimer"

UI = UI or {}

local BasicInfoArea = class("BasicInfoArea", UI.HWBtnComponent)
UI.BasicInfoArea = BasicInfoArea
local winSize = cc.Director:getInstance():getWinSize()
-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 进度条的背景
local SPRITE_PROGRESS_BG = "ui_role_progressbar_00.png"
-- 血条进度条
local SPRITE_PROGRESS_HP_1 = "ui_role_progressbar_blood_10.png"
-- 蓝条进度条
local SPRITE_PROGRESS_MP = "ui_role_progressbar_mp_10.png"
-- 经验进度条
local SPRITE_PROGRESS_XP = "ui_role_progressbar_ex_10.png"

-- 进度条
local PROGRESS_LEFT = 0
local HP_PROGRESS_UP = 20
local MP_PROGRESS_UP = 66
local XP_PROGRESS_UP = -418
local XP_PROGRESS_LEFT = -22
-- 分割线
local SPLIT_LINE_LEFT = 170
local HP_SPLIT_LINE_UP = 40
local MP_SPLIT_LINE_UP = 70
local XP_SPLIT_LINE_UP = 100
-- 进度条文本信息
local PROGRESS_TEXT_LEFT = 30 + 2 + 3
local HP_PROGRESS_TEXT_UP = 31 - 2
local MP_PROGRESS_TEXT_UP = 77 - 2
local XP_PROGRESS_TEXT_UP = -416 - 2
local XP_PROGRESS_TEXT_LEFT = -2
local PROGRESS_TEXT_WIDTH = 121
local PROGRESS_TEXT_HEIGHT = 25
-- 文本额外宽度
local TEXT_MORE_WIDTH = 100
-- 角色属性文本描述
local ROLE_ATTTRIBUTE_LEFT = 195
local ATTACK_STRENGTH_UP = 20 - 2
local MAGIC_EFFECT_UP = 49 - 2
local TENACITY_UP = 78 - 2
local ROLE_ATTTRIBUTE_WIDTH = 100
local ROLE_ATTTRIBUTE_HEIGHT = 25
-- 角色属性文本描述
local ROLE_ATTRIBUTE_VALUE_LEFT = 300
local ATTACK_STRENGTH_VALUE_UP = 21 - 2
local MAGIC_EFFECT_VALUE_UP = 50 - 2
local TENACITY_VALUE_UP = 77 - 2
local ROLE_ATTRIBUTE_VALUE_WIDTH = 100
local ROLE_ATTRIBUTE_VALUE_HEIGHT = 25

-- 构造函数
function BasicInfoArea:ctor()
    BasicInfoArea.super.ctor(self, UIType.BAG_BASIC_INFO_AREA, nil, 470, 121)

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
end

-- 析构函数
function BasicInfoArea:dtor()
    self._nickNameDes = nil
    self._booldTimer = nil 
    self._mpTimer = nil 
    self._xpTimer = nil 
    self._attackValue = nil 
    self._magicValue  = nil 
    self._tenacityValue = nil 

    BasicInfoArea.super.dtor(self)

        --血量显示类型
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UPDATE_BASIC_INFO, self, self.onUpdateView)
end

-- public:
-- 初始化
function BasicInfoArea:init(data)
    BasicInfoArea.super.init(self, data)
        --血量显示类型
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UPDATE_BASIC_INFO, self, self.onUpdateView)
end

-- 销毁
function BasicInfoArea:onDestroy()
end

-- 初始化视图
function BasicInfoArea:onInitView()
    local roleShowBG = UI.Image:create()
    roleShowBG:init("ui_role_banner_large_up.png")
    -- local roleShowBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_role_banner_large_up")
    -- roleShowBG:setCapInsets(CCRectMake(5,5,450,84))
    -- roleShowBG:setContentSize(designAreaWidth, LAYOUT_FUNCTION_HEIGHT)
    -- roleShowBG:setPosition(designAreaWidth/2, LAYOUT_FUNCTION_HEIGHT/2)
    roleShowBG:center()
    self:addChild(roleShowBG)
    
    -- hp
    self._booldTimer = UI.ProgressTimer:create()
    self._booldTimer:init(SPRITE_PROGRESS_BG, nil, SPRITE_PROGRESS_HP_1)
    self._booldTimer:leftUp(PROGRESS_LEFT, HP_PROGRESS_UP)
    self:addChild(self._booldTimer)
    -- mp
    self._mpTimer = UI.ProgressTimer:create()
    self._mpTimer:init(SPRITE_PROGRESS_BG, nil, SPRITE_PROGRESS_MP)
    self._mpTimer:leftUp(PROGRESS_LEFT, MP_PROGRESS_UP)
    self:addChild(self._mpTimer)
    -- xp
    local xpBg = UI.Image:create()
    xpBg:init("ui_role_progressbar_ex_bg.png")
    xpBg:leftUp(XP_PROGRESS_LEFT, XP_PROGRESS_UP)
    self:addChild(xpBg)
    self._xpTimer = UI.ProgressTimer:create()
    self._xpTimer:init("ui_role_progressbar_ex_00.png", nil, SPRITE_PROGRESS_XP)
    self._xpTimer:centerLeft(0)
    xpBg:addChild(self._xpTimer)

    -- 生命值
    self._hpLabel = UI.Text:create()
    self._hpLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_227_214_172)
    self._hpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    self._hpLabel:leftUp(
        PROGRESS_TEXT_LEFT - TEXT_MORE_WIDTH/2,
        HP_PROGRESS_TEXT_UP
    )
    self._hpLabel:setSize(
        PROGRESS_TEXT_WIDTH + TEXT_MORE_WIDTH,
        PROGRESS_TEXT_HEIGHT
    )
    self._hpLabel:setTextCenter()
    self:addChild(self._hpLabel, 10)
    -- 魔法值
    self._mpLabel = UI.Text:create()
    self._mpLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_227_214_172)
    self._mpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    self._mpLabel:leftUp(
        PROGRESS_TEXT_LEFT - TEXT_MORE_WIDTH/2,
        MP_PROGRESS_TEXT_UP
    )
    self._mpLabel:setSize(
        PROGRESS_TEXT_WIDTH + TEXT_MORE_WIDTH,
        PROGRESS_TEXT_HEIGHT
    )
    self._mpLabel:setTextCenter()
    self:addChild(self._mpLabel, 10)
    -- 经验值
    local xpLayout = UI.Layout:create()
    xpLayout:init()
    xpLayout:setSize(PROGRESS_TEXT_WIDTH, PROGRESS_TEXT_HEIGHT)
    xpLayout:leftUp(
        XP_PROGRESS_TEXT_LEFT,
        XP_PROGRESS_TEXT_UP
    )
    self:addChild(xpLayout, 10)

    self._xpLabel = cc.Label:createWithTTF("",  UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    self._xpLabel:setTextColor(UI.FONT_COLOR_227_214_172)
    self._xpLabel:setFixLineWidth(PROGRESS_TEXT_WIDTH)
    self._xpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    xpLayout:addChild(self._xpLabel)
    self._xpLabel:setPosition(PROGRESS_TEXT_WIDTH/2, PROGRESS_TEXT_HEIGHT/2)
    self._xpLabel:setAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)

    -- 攻击强度
    local attackText = UI.Text:create()
    attackText:init(UI.TEXT_DES_ATTACK_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    attackText:setSize(
        ROLE_ATTTRIBUTE_WIDTH,
        ROLE_ATTTRIBUTE_HEIGHT    
    )
    attackText:leftUp(
        ROLE_ATTTRIBUTE_LEFT,
        ATTACK_STRENGTH_UP
    )
    attackText:setTextLeft()
    self:addChild(attackText)

    local lineOffsetY = 1
    -- 分割线
    local line = UI.Image:create()
    line:init("ui_character_line.png")
    line:leftUp(ROLE_ATTTRIBUTE_LEFT, ATTACK_STRENGTH_UP + attackText:getContentSize().height + lineOffsetY);
    self:addChild(line)

    -- 法术效果
    local magicText = UI.Text:create()
    magicText:init(UI.TEXT_DES_MAGIC_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    magicText:setSize(
        ROLE_ATTTRIBUTE_WIDTH,
        ROLE_ATTTRIBUTE_HEIGHT
    )
    magicText:leftUp(
        ROLE_ATTTRIBUTE_LEFT,
        MAGIC_EFFECT_UP
    )
    magicText:setTextLeft()
    self:addChild(magicText)

    -- 分割线
    local line = UI.Image:create()
    line:init("ui_character_line.png")
    line:leftUp(ROLE_ATTTRIBUTE_LEFT, MAGIC_EFFECT_UP + magicText:getContentSize().height + lineOffsetY);
    self:addChild(line)

    -- 坚韧
    local enacityText = UI.Text:create()
    enacityText:init(UI.TEXT_DES_TENACITY_STRENGTH, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    enacityText:setSize(
        ROLE_ATTTRIBUTE_WIDTH,
        ROLE_ATTTRIBUTE_HEIGHT
    )
    enacityText:leftUp(
        ROLE_ATTTRIBUTE_LEFT,
        TENACITY_UP
    )
    enacityText:setTextLeft()
    self:addChild(enacityText)

    -- 分割线
    local line = UI.Image:create()
    line:init("ui_character_line.png")
    line:leftUp(ROLE_ATTTRIBUTE_LEFT, TENACITY_UP + enacityText:getContentSize().height + lineOffsetY);
    self:addChild(line)
    
    -- 攻击强度值
    self._attackValue = UI.Text:create()
    self._attackValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._attackValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._attackValue:leftUp(
        ROLE_ATTRIBUTE_VALUE_LEFT,
        ATTACK_STRENGTH_VALUE_UP
    )
    self._attackValue:setTextLeft()
    self:addChild(self._attackValue)
    -- 法术强度值
    self._magicValue = UI.Text:create()
    self._magicValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._magicValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._magicValue:leftUp(
        ROLE_ATTRIBUTE_VALUE_LEFT,
        MAGIC_EFFECT_VALUE_UP
    )
    self._magicValue:setTextLeft()
    self:addChild(self._magicValue)
    -- 坚韧值
    self._tenacityValue = UI.Text:create()
    self._tenacityValue:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    self._tenacityValue:setSize(
        ROLE_ATTRIBUTE_VALUE_WIDTH,
        ROLE_ATTRIBUTE_VALUE_HEIGHT
    )
    self._tenacityValue:leftUp(
        ROLE_ATTRIBUTE_VALUE_LEFT,
        TENACITY_VALUE_UP
    )
    self._tenacityValue:setTextLeft()
    self:addChild(self._tenacityValue)

    -- 详情按钮
    local detailButton = UI.Button:create() 
    detailButton:init()
    detailButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showDetailedInfo)
    detailButton:setSize(50,50)
    detailButton:rightUp(-10, -11)
    self:addChild(detailButton)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    detailButton:addChild(detailAnimation, 10)


    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_EQUIP)) then 
            -- 详情按钮
        local starButton = UI.Button:create() 
        starButton:init()
        starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
        starButton:setSize(50,50)
        starButton:rightUp(-10, 36)
        self:addChild(starButton)

        local detailAnimation = UI.Animation:create()
        detailAnimation:init("effect_ui_package_role_starpray_hint_icon.json", "effect_ui_package_role_starpray_hint_icon.atlas")
        detailAnimation:setAnimation("idle", true)
        detailAnimation:center()
        starButton:addChild(detailAnimation, 10)
        self._starButton = starButton
    end
        
    self._detailButton = detailButton
end

function BasicInfoArea:setDetailedBtnParent(node)
    self._detailedBtnParent = node
end

function BasicInfoArea:showDetailedInfo()
    local detailedInfoArea = UI.DetailedInfoArea:create()
    detailedInfoArea:init()
    local bgWorldPos = self._detailButton:convertToWorldSpace(cc.p(0,0))
    local left = 534
    local bottom = 20
    detailedInfoArea:leftBottom(left, bottom)

    AvalonUtil.runTipsAppearShowAnimation(detailedInfoArea)

    detailedInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        if(self._detailedInfoArea) then 
            self._detailedInfoArea:removeFromParent()
            self._detailedInfoArea = nil
        end 
    end)

    if not self._detailedBtnParent then
        UI.UIManager:addToRootNode(detailedInfoArea, UI_ZORDER.VIEW_ROLE_INFO)
    else
        self._detailedBtnParent:addChild(detailedInfoArea, 1000)
    end
    self._detailedInfoArea = detailedInfoArea
end

function BasicInfoArea:showStarInfo()
    require("app.ui.baglayer.InfoArea.RoleStarInfoArea")
    local starInfoArea = UI.RoleStarInfoArea:create()
    starInfoArea:init(mvc.starPrayModel:getStarPrayEqiupData())
    local bgWorldPos = self._starButton:convertToWorldSpace(cc.p(0,0))
    starInfoArea:centerRight(winSize.width - bgWorldPos.x - 15)
    AvalonUtil.runTipsAppearShowAnimation(starInfoArea)
    UI.UIManager:addToRootNode(starInfoArea, UI_ZORDER.VIEW_ROLE_INFO)
end

function BasicInfoArea:onUpdatePos()
    self._attackValue:updateView()
    self._magicValue:updateView()
    self._tenacityValue:updateView()
end

-- 更新视图
function BasicInfoArea:onUpdateView(data)
    if data == nil then 
        data =  RoleDataManager:getMaster() 
    end
    if (not data) then return end

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




    -- -- 设置进度
    -- 最大血量
    local  hpMax = data.hp or 0
    -- 当前血量
    local  hpNum = data.curHp or 0
      if  hpNum > hpMax then
          hpNum = hpMax
    elseif hpNum < 0 then
          hpNum = 0
    end

    -- 魔法值
    local  mpMax = data.mp or 0
    -- 当前血量
    local  mpNum = data.curMp or 0
    if  mpNum > mpMax then
        mpNum = mpMax
    elseif mpNum < 0 then
        mpNum = 0
    end

    local  xpMax = data and data.expToNextLV  or 0 
    local  xpNum = data and data.curLVExp or 0 

    if  xpNum > xpMax then
      xpNum = xpMax
    elseif xpNum < 0 then
      xpNum = 0
    end


    self.hpNum = hpNum
    self.hpMax = hpMax
    self.mpNum = mpNum
    self.mpMax = mpMax
    self.xpNum = xpNum
    self.xpMax = xpMax
    
    self:refreshRoleInfoShowType()
    local isFullLV = data:getIsMaxLevel() 
    if isFullLV then 
        self._xpTimer:setPercent(1)
        self._xpLabel:setString("MAX")
    end
    self:onUpdatePos()

end


function BasicInfoArea:refreshRoleInfoShowType()
    local hp = ""
    local mp = ""
    local xp = ""
    local _showType = Game.Manager:getRoleInfoShowType() 
    if _showType == ShowType.PERCENT then

        local  HP  = math.floor(self.hpNum/self.hpMax*100)
        local  MP  = math.floor(self.mpNum/self.mpMax*100)
        local  XP  = math.floor(self.xpNum/self.xpMax*100)

        if HP == 0 and self.hpNum ~= 0 then
            HP = 1
        end
        if MP == 0 and self.mpNum ~= 0 then
            MP = 1
        end
        if XP == 0 and self.xpNum ~= 0 then
            XP = 1
        end
        hp = HP.."%"
        mp = MP.."%"
        xp = XP.."%"

    elseif _showType == ShowType.VALUE then
        local showTempHpNum = self.hpNum
        local showTempHpMax = self.hpMax
        local showTempMpNum = self.mpNum
        local showTempMpMax = self.mpMax
        if showTempHpNum > 1000000 then
            showTempHpNum = AvalonUtil:getSimpleNumber(showTempHpNum, 5)
        end
        if showTempHpMax > 1000000 then
            showTempHpMax = AvalonUtil:getSimpleNumber(showTempHpMax, 5)
        end
        
        if showTempMpNum > 1000000 then
            showTempMpNum = AvalonUtil:getSimpleNumber(showTempMpNum, 5)
        end
        if showTempMpMax > 1000000 then
            showTempMpMax = AvalonUtil:getSimpleNumber(showTempMpMax, 5)
        end
        hp = showTempHpNum.."/"..showTempHpMax
        mp = showTempMpNum.."/"..showTempMpMax
        xp = self.xpNum.."/"..self.xpMax 
    end

    self._hpLabel:setText(hp)
    self._mpLabel:setText(mp)
    self._xpLabel:setString(xp)
    self._xpLabel:setFixLineWidth(PROGRESS_TEXT_WIDTH)

    local change = self.hpNum/self.hpMax 
    self._booldTimer:setPercent(change)
    self._mpTimer:setPercent(self.mpNum/self.mpMax)
    self._xpTimer:setPercent(self.xpNum/self.xpMax)
    self._lastchange = change
end

