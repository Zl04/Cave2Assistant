--[[
-- RoleTalentCell.lua
-- Author:ydli
-- 2018年1月2日
-- Using:人物天赋界面
]]

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local RoleTalentCell = class("RoleTalentCell", UI.HWBtnComponent)
UI.RoleTalentCell = RoleTalentCell
local LanguageManager = require("app.game.LanguageManager")

local LAYER_SIZE = cc.size(652, 74)

-- 构造函数
function RoleTalentCell:ctor(tableview)
    RoleTalentCell.super.ctor(self, 0, {}, LAYER_SIZE.width, LAYER_SIZE.height)
    self.tableview = tableview
end

--析构函数
function RoleTalentCell:dtor()
    RoleTalentCell.super.dtor(self)
end

-- 初始化
function RoleTalentCell:init(data)
    RoleTalentCell.super.init(self)
    self.data = data
end

-- 初始化视图
function RoleTalentCell:onInitView()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_tips_box_02.png")
    bg:setContentSize(610, 63)
    bg:setPosition(350, 37)
    self:addChild(bg)

    --icon
    local icon = UI.Image:create() 
    icon:init("ui_skill_icon_30100101.png")
    icon:centerLeft(5)
    self:addChild(icon)
    self.icon = icon

    --name
    local name = UI.Text:create()
    name:init("----", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    name:leftBottom(100, 35)
    self:addChild(name)
    -- name:enableDebugDraw()
    self.name = name
    --desc
    
    local desc = UI.Text:create()
    desc:init("----", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    desc:leftBottom(265, 35)
    -- desc:enableDebugDraw()
    self:addChild(desc)
    self.desc = desc

    --progressbg
    local progressbg = UI.Image:create()
    progressbg:init("ui_activity_banner_countdown_box.png")
    progressbg:leftBottom(66, 18)
    self:addChild(progressbg)
    progressbg:setScaleX(0.84)

    --progress
    local  progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_activity_banner_countdown.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(0)
    progress:setAnchorPoint(0, 0)
    progress:setPosition(1, 1)
    progressbg:addChild(progress)
    progress:setScaleX(0.9995)
    self.progress = progress
    --level
    local level = UI.Text:create()
    level:init("lv1", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    level:leftBottom(470, 35)
    level:setDimensions(85, 20)
    level:setTextCenter()
    self:addChild(level)
    self.level = level

    --exp
    local exp = UI.Text:create()
    exp:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    exp:leftBottom(470, 14)
    exp:setDimensions(85, 20)
    exp:setTextCenter()
    self:addChild(exp)
    self.exp = exp

    local maxLogo = UI.Image:create()
    maxLogo:init("ui_talent_max.png")
    maxLogo:centerLeft(570)
    self:addChild(maxLogo)
    self.maxLogo = maxLogo

    --addbutton
    local addbutton = UI.Button:create()
    addbutton:init("ui_btn_add_0.png","ui_btn_add_1.png","ui_btn_add_2.png")
    addbutton:centerLeft(580)
    addbutton:addEventListener(UIEvent.BUTTON_CLICK,self, self.onAddClick)
    addbutton:setTouchClipNode(self.tableview)
    self:addChild(addbutton, 10)
    self.addbutton = addbutton

    --gradeUp button
    local gradeUpBtn = UI.Button:create()
    gradeUpBtn:init("ui_btn_chat_0.png", "ui_btn_chat_1.png","ui_btn_chat_2.png")
    gradeUpBtn:centerLeft(555)
    gradeUpBtn:addEventListener(UIEvent.BUTTON_CLICK,self, self.onUpgradeClick)
    self:addChild(gradeUpBtn)
    gradeUpBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    gradeUpBtn:setText(LanguageManager:getInstance():getLocalString(1111520))
    gradeUpBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1212100)
    end)
    gradeUpBtn:setTouchClipNode(self.tableview)
    self.gradeUpBtn = gradeUpBtn
end

-- 更新视图
function RoleTalentCell:onUpdateView()   
    self:refreshLayer()
end

function RoleTalentCell:refreshLayer()
    if self.data == nil then
        return
    end
    self.icon:setSpriteName(self.data.icon)
    self.icon:centerLeft(49 - self.icon:getContentSize().width / 2)
    self.name:setText(self.data.name)
    local scale = 150 / cc.Label:CalculateStringSize(self.name:getText(), UI.FONT_ARIAL, self.name:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.name:setScale(scale)
    self.name:leftBottom(100- (1 - scale) * self.name:getContentSize().width / 2, 35)

    local valueList = string.split(self.data.effectValue, ";")
    local value = 0
    if self.data.curLv > 0 then
        value = valueList[self.data.curLv] or valueList[#valueList]
    end

    if #self.data.effectID > 1 then  --特殊处理  有逗号二次分割
        value = string.split(value, ",")[1]
    end

    local attrType = self.data.effectID[1]
    if PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "BeCriticalRate" then 
        value = math.abs(checkint(value))
    end
    if self.data.valueType == 2 then
        if PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "dodge" then 
            value = checkint(value) / tonumber(ConfigManager:getGeneralForKey("dodgeParameter")) * 100
        elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "critical" then 
            value = checkint(value) / tonumber(ConfigManager:getGeneralForKey("criticalParameter")) * 100
        elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "physicPenetrate" then 
            value =  checkint(value) / tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter")) * 100
        elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "magicPenetrate" then 
            value = checkint(value) / tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter")) * 100
        elseif PublicDefine.ATTR_TYPE_ID_KEY[attrType] == "block" then 
            value = checkint(value) / tonumber(ConfigManager:getGeneralForKey("blockParameter")) * 100
        else
            value = checkint(value) / RATIO_NUMBER * 100
        end
    end
    local showText = string.format(self.data.desc, value)
    self.desc:setText(showText)
    local scale = 200 / cc.Label:CalculateStringSize(self.desc:getText(), UI.FONT_ARIAL, self.desc:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.desc:setScale(scale)
    self.desc:leftBottom(265 - (1 - scale) * self.desc:getContentSize().width / 2, 35)

    self.level:setText("Lv "..self.data.curLv.."/"..#self.data.itemNum)
    local targetNum = checkint(self.data.itemNum[self.data.curLv + 1] or self.data.itemNum[#self.data.itemNum])
    local percent = self.data.curAdd / targetNum * 100
    percent = percent > 100 and 100 or percent
    self.progress:setPercentage(percent)
    self.exp:setText(string.format("%d/%d", self.data.curAdd, targetNum))
    if self.data.curLv + 1 > #self.data.itemNum then
        self.addbutton:hide()
        self.gradeUpBtn:hide()
        self.maxLogo:show()
        self.progress:setPercentage(100)
        self.exp:setText(string.format("%d/%d", targetNum, targetNum))
    else
        self.maxLogo:hide()
        if self.data.curAdd >= targetNum then
            self.addbutton:hide()
            self.gradeUpBtn:show()
        else
            self.addbutton:show()
            self.gradeUpBtn:hide()
        end
    end
end

function RoleTalentCell:onUpgradeClick()  
    if RoleBehaviorManager:roleTalentCheck() then
        return
    end 
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_RoleTalent) then
        Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_RoleTalent)
        return 
    end
    Net.NetRoleSystem:requestUpgradeRoleTalent(self.data.ID)
end

function RoleTalentCell:onAddClick() 
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_RoleTalent) then
        Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_RoleTalent)
        return 
    end
    local SceneManager = require("app.game.SceneManager")
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        UI.ScrollBar:createByTextID(1111658)
        return 
    end

    local targetNum = self.data.itemNum[self.data.curLv + 1] or self.data.itemNum[#self.data.itemNum]
    local useNumber = targetNum - self.data.curAdd
    local needItemId = self.data.itemID[self.data.curLv + 1] or self.data.itemID[#self.data.itemID]
    local haveNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(checkint(needItemId), true)
    if haveNumber <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212098)
        return 
    end  

    useNumber = useNumber > haveNumber and haveNumber or useNumber
    UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
        if not tolua.isnull(self) and number > 0 then
            self:addTalent(needItemId, number)
        end
    end, nil, 1, PublicDefine.GOODS_COST_TYPE.TALENT, useNumber, false)
   
end

function RoleTalentCell:addTalent(itemId, number) 
    if not tolua.isnull(self) and number > 0 then
        if RoleBehaviorManager:roleTalentCheck() then
            return
        end
        if GameDataManager:getInstance():getGoodsDataNumForGoodsID(checkint(itemId), true) < number then
            UI.ScrollBar:createByText(UI.TEXT_1212098)
            return 
        end          
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:requestAddRoleTalent(self.data.ID, number)
    end
end