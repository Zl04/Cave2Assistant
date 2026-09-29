-- SkillTips.lua
-- Using:魂器 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
local LanguageManager = require "app.game.LanguageManager"

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()

UI = UI or {}

local SkillTips = class("SkillTips", UI.HWBtnComponent)
UI.SkillTips = SkillTips
local layerSize = cc.size(295, 330)

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_package_skill.plist",
}


function SkillTips:ctor(skillData, lv, uiID)
    SkillTips.super.ctor(
    self,
    uiID,
    COM_RES_LIST,
    layerSize.width,
    layerSize.height
    )
    self.rootLayer = nil;           --root节点

   
    self:registerListener();

    -- self:enableDebugDraw()
    self.skillData = skillData

    self.lv = lv
end

function SkillTips:dtor()
    SkillTips.super.dtor(self)
    self:unRegisterListener();
	Avalon.MessageCenter:notice(GameMessage.MC_UI_COLSE_SKILL_TIP)
    reload_script_file("app.ui.baglayer.Horcurx.SkillTips")
end
-- 注册监听事件(可选)
function SkillTips:registerListener()
    -- 角色状态更新 
    -- Avalon.MessageCenter:bind(AvalonMessage., self, self.onUpdateRoleStateHandler)
end


-- 注销监听事件(可选)
function SkillTips:unRegisterListener()
end

-- 初始化视图
function SkillTips:onInitView()
	local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box2.png")
    bg:setCapInsets(CCRectMake(190,96,5,5))
    bg:setContentSize(layerSize.width, layerSize.height)
    bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(cc.p(layerSize.width / 2, layerSize.height / 2))

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self,function() self:removeFromParent() end)
    self:addChild(bg)
	self._picBg = bg
	self:creataSkillInfoNode()
	self:refreshSkillInfo()
    self:showLucencyLight()
end

function SkillTips:getSkillBoxSpriteName()
    if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        return "ui_skill_banner_skillbox.png"
    else 
        return "ui_skill_banner_skillbox_transfer_bg.png"
    end
end

--创建技能信息
function SkillTips:creataSkillInfoNode()
    self.skillDesNode = cc.Node:create()
    self._picBg:addChild(self.skillDesNode)    


    local offsetX = 18
    local offsetY = 73
    self.mTxtSkillName = UI.Text:create()
    self.mTxtSkillName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- self.mTxtSkillName:leftBottom(24, 315)    
    self.mTxtSkillName:centerLeft(123-offsetX, -140)
    self.mTxtSkillName:setWidth(180)
    self.mTxtSkillName:setTextLeftUp()
    self.mTxtSkillName:setLineSpacing(-6)
    self.skillDesNode:addChild(self.mTxtSkillName)


    self.mPicSkillIconBG1 = cc.Sprite:createWithSpriteFrameName(self:getSkillBoxSpriteName())
    self.mPicSkillIconBG1:setPosition(55,266)
    self.skillDesNode:addChild(self.mPicSkillIconBG1)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(layerSize.width/2,314)
    self._picBg:addChild(lineUpImage,2)
    lineUpImage:setContentSize(layerSize.width - 30, 1.1)

   
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(layerSize.width - 30, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(layerSize.width/2,221)
    self._picBg:addChild(lineUpImage)



    self.mPicSkillIcon = cc.Sprite:create()
    self.mPicSkillIcon:setAnchorPoint(0.5, 0.5)
    self.mPicSkillIcon:setPosition(self.mPicSkillIconBG1:getContentSize().width / 2, self.mPicSkillIconBG1:getContentSize().height / 2)
    self.mPicSkillIconBG1:addChild(self.mPicSkillIcon)

    -- self.mTxtSkillLv = UI.Text:create()
    -- self.mTxtSkillLv:init("Lv.".. self.lv, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- self.skillDesNode:addChild(self.mTxtSkillLv)
    -- self.mTxtSkillLv:hide()

    -- self.mTxtSkillType = cc.Label:createWithTTF("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.mTxtSkillType = UI.Text:create()
    self.mTxtSkillType:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self.mTxtSkillType:leftBottom(123-offsetX,303-offsetY)
    self.mTxtSkillType:setTextLeft()
    self.skillDesNode:addChild(self.mTxtSkillType)
    -- self.mTxtSkillType:enableDebugDraw()

    -- 滚动视图
    local skillInfoScrollView = UI.ScrollView:create()
    skillInfoScrollView:init(0, 0, 0, 0)
    skillInfoScrollView:leftBottom(18, 84-offsetY)
    skillInfoScrollView:setSize(280, 203)
    skillInfoScrollView:setTouchEnable(true)
    self.skillDesNode:addChild(skillInfoScrollView, 10)
    skillInfoScrollView:setScrollBarEnabled(true)
    skillInfoScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    skillInfoScrollView:setScrollBarWidth(5)
    skillInfoScrollView:setCircleVisible(false)
    self.skillInfoScrollView = skillInfoScrollView
    -- skillInfoScrollView:enableDebugDraw()
    
    self.mScrollSkillInfo = UI.Layout:create()
    self.mScrollSkillInfo:init()
    self.mScrollSkillInfo:leftBottom(0, 0)
    skillInfoScrollView:addInnerNode(self.mScrollSkillInfo)
    -- self.mScrollSkillInfo:enableDebugDraw(UI.RED)
    
    -- self.mTxtSkillConsume = cc.Label:createWithTTF(UI.TEXT_111004, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    -- self.mTxtSkillConsume:setPosition(810,260)
    -- self.mTxtSkillConsume:setTextColor(UI.FONT_COLOR_41_41_45)
    -- self.mScrollSkillInfo:addChild(self.mTxtSkillConsume)
    -- self.mTxtSkillConsume:setAnchorPoint(0,1)

    -- 技能冷却
    self.mTxtSkillCD = cc.Label:createWithTTF(UI.TEXT_111006, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.mTxtSkillCD:setPosition(810,240)
    self.mTxtSkillCD:setTextColor(UI.FONT_COLOR_41_41_45)
    self.mScrollSkillInfo:addChild(self.mTxtSkillCD)
    self.mTxtSkillCD:setAnchorPoint(0,1)

    -- 吟唱时间/蓄力时间，瞬发
    self.mTxtPrepareCD = cc.Label:createWithTTF("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.mTxtPrepareCD:setPosition(810,240)
    self.mTxtPrepareCD:setTextColor(UI.FONT_COLOR_41_41_45)
    self.mScrollSkillInfo:addChild(self.mTxtPrepareCD)
    self.mTxtPrepareCD:setAnchorPoint(0,1)

    --UI.TEXT_111007
    self.mTxtSkillDes1 = cc.Label:createWithTTF("UI.TEXT_111007", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.mTxtSkillDes1:setPosition(810,220)
    self.mTxtSkillDes1:setTextColor(UI.FONT_COLOR_41_41_45)
    self.mScrollSkillInfo:addChild(self.mTxtSkillDes1)
    self.mTxtSkillDes1:setAnchorPoint(0,1)

    self.mTxtSkillDes = cc.Label:createWithTTF("SkillDes", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.mTxtSkillDes:setPosition(0,0)
    self.mTxtSkillDes:setTextColor(UI.FONT_COLOR_41_41_45)
    self.mScrollSkillInfo:addChild(self.mTxtSkillDes)
    self.mTxtSkillDes:setAnchorPoint(0,1)
    self.mTxtSkillDes:setWidth(235)

    self.mTxtOpenLevel = cc.Label:createWithTTF(string.format(UI.TEXT_111002,20), UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    self.mTxtOpenLevel:setPosition(32-offsetX, 272-offsetY)
    self.mTxtOpenLevel:setTextColor(UI.FONT_COLOR_80_5_5)
    self.skillDesNode:addChild(self.mTxtOpenLevel)
    self.mTxtOpenLevel:setAnchorPoint(0,0)
    --self.mTxtOpenLevel:setAlignment(align)

    self.mTxtNeedSkill = cc.Label:createWithTTF(string.format(UI.TEXT_111003,20), UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
    self.mTxtNeedSkill:setPosition(55 - 15-offsetX,255-offsetY)
    self.mTxtNeedSkill:setTextColor(UI.FONT_COLOR_107_83_59)
    self.mTxtNeedSkill:setAnchorPoint(0,0)
    self.skillDesNode:addChild(self.mTxtNeedSkill)
end




--刷新技能详细信息
function SkillTips:refreshSkillInfo()
    self.skillDesNode:setVisible(true)
    self.mTxtSkillName:setText(self.skillData.name)
    self.mPicSkillIcon:setSpriteFrame(self.skillData.iconID)


    self.mTxtOpenLevel:setVisible(false)
    self.mTxtNeedSkill:setVisible(false)


    self.mTxtSkillDes:setString(self.skillData.description)

    if self.skillData.type == SkillType.PASSIVE then
        self.mTxtSkillType:setText(UI.TEXT_110038)
        -- self.mTxtSkillConsume:setVisible(false)
        self.mTxtSkillCD:setVisible(false)
        self.mTxtPrepareCD:setVisible(false)

        self.mTxtSkillDes1:setPosition(810,260)
        self.mTxtSkillDes:setPosition(0,0)
    else
        self.mTxtSkillType:setText(UI.TEXT_110039)
        -- self.mTxtSkillConsume:setVisible(true)
        self.mTxtSkillCD:setVisible(true)
        self.mTxtPrepareCD:setVisible(true)

        -- if self.skillData.costType == 1 then
        --     self.mTxtSkillConsume:setString(UI.TEXT_111005 .. string.format("%d",self.skillData.cost))
        -- elseif self.skillData.costType == 3 then
        --     self.mTxtSkillConsume:setString(UI.TEXT_1213206 .. string.format("%d",self.skillData.cost))
        -- end

        self.mTxtSkillCD:setString(UI.TEXT_111006 .. string.format("%.1f",self.skillData:getCooldown()/1000))

        local prepareCD = ""
        if(self.skillData:getSkillType() == SkillType.PHYSICAL) then 
            if self.skillData:getPrepareTime() <= 0 then
                prepareCD = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
            else
                prepareCD = LanguageManager:getInstance():getLocalString(1111371)..string.format("%.1f", self.skillData:getPrepareTime())
            end
        elseif(self.skillData:getSkillType() == SkillType.HORCURX) then 
            if self.skillData:getPrepareTime() <= 0 then
                prepareCD = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
            else
                prepareCD = LanguageManager:getInstance():getLocalString(1111370)..string.format("%.1f", self.skillData:getPrepareTime())
            end
        end
        
        self.mTxtPrepareCD:setString(prepareCD)
        
    end

    -- 计算当前拥有总高度
    local height = 0
    if(self.mTxtSkillDes:isVisible()) then 
        height = height + self.mTxtSkillDes:getContentSize().height + 7
    end

    if(self.mTxtSkillDes1:isVisible()) then 
        height = height + self.mTxtSkillDes1:getContentSize().height
    end

    if(self.mTxtPrepareCD:isVisible()) then 
        height = height + self.mTxtPrepareCD:getContentSize().height
    end

    if(self.mTxtSkillCD:isVisible()) then 
        height = height + self.mTxtSkillCD:getContentSize().height
    end

    -- if(self.mTxtSkillConsume:isVisible()) then 
    --     height = height + self.mTxtSkillConsume:getContentSize().height
    -- end 

    -- 处理是否达到了文字限制高度
    local desScrollHeight = self.skillInfoScrollView:getContentSize().height
    if height < desScrollHeight then
        height = desScrollHeight;
    end
    
    self.mScrollSkillInfo:setSize(290, height)

    -- 根据排版设计位置
    height = height
    -- if self.mTxtSkillConsume:isVisible() then
    --     self.mTxtSkillConsume:setPosition(0, height)
    --     height = height - self.mTxtSkillConsume:getContentSize().height
    -- end

    if self.mTxtSkillCD:isVisible() then
        self.mTxtSkillCD:setPosition(0, height)
        height = height - self.mTxtSkillCD:getContentSize().height
    end

    if(self.mTxtPrepareCD:isVisible()) then 
        self.mTxtPrepareCD:setPosition(0, height)
        height = height - self.mTxtPrepareCD:getContentSize().height
    end

    if self.mTxtSkillDes1:isVisible() then
        self.mTxtSkillDes1:setPositionY(height)
        height = height - self.mTxtSkillDes1:getContentSize().height
    end
    
    if self.mTxtSkillDes:isVisible() then
        self.mTxtSkillDes:setPositionY(height - 7)
    end
    self.skillInfoScrollView:refresh()
    self.skillInfoScrollView:scrollToTop()
end
