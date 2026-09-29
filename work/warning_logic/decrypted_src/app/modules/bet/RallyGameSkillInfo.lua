------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2024/01/15
--desc	: 
------------------------------------------------------------------------------

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallyGameSkillInfo = class("RallyGameSkillInfo", UI.HWBtnComponent)
require "app.modules.bigsailisland.BigSailIslandInfoView"

UI = UI or {}

UI.RallyGameSkillInfo = RallyGameSkillInfo

-- 资源
local COM_RES_LIST = {
    "ui_town_rally.plist",
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 388
local COM_HEIGHT = 472

function RallyGameSkillInfo:bindModel()
    
end

function RallyGameSkillInfo:unbindModel()
    
end

function RallyGameSkillInfo:ctor(skillData)
    RallyGameSkillInfo.super.ctor(
    self,
    UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self._skillData = skillData
self.switchBtnState = nil
self.cellList = {}
self:bindModel()
end

function RallyGameSkillInfo:init( ... )
    RallyGameSkillInfo.super.init(self, ... )
    self.isEmbattling = false
end

function RallyGameSkillInfo:dtor()
    RallyGameSkillInfo.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file("app.modules.bet.RallyGameSkillInfo")
end

function RallyGameSkillInfo:onInitView()    
    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_rally_banner_box_2.png")
    bg:center()
    self:addChild(bg)
    
    bg:setTouchEnable(true)
    bg:setInterceptTouches(true)
    bg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        self:close()
    end)
    
    -- 图标
    local icon = UI.Image:create()
    -- icon:init("ui_skill_icon_30000201.png")
    icon:init(self._skillData:getIconName())
    icon:leftUp(35, 35)
    -- icon:enableDebugDraw()
    bg:addChild(icon)
    
    -- 文本信息
    local skillName = UI.Text:create()
    skillName:init(self._skillData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_47_50_55)
    skillName:leftUp(125, 45)
    bg:addChild(skillName)
    
    local skillTypeStr = ""
    if self._skillData.type == SkillType.PASSIVE then
        skillTypeStr = UI.TEXT_110038
    else
        skillTypeStr = UI.TEXT_110039
    end 
    
    local skillType = UI.Text:create()
    skillType:init(skillTypeStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_47_50_55)
    skillType:leftUp(125, 90)
    bg:addChild(skillType)
    
    local skillCool = UI.Text:create()
    skillCool:init(string.format(languageManagerInstance:getLocalString(1110228), self._skillData:getCooldown()), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_47_50_55)
    skillCool:rightUp(35, 90)
    bg:addChild(skillCool)
    
    local skillDesc = UI.Text:create()
    skillDesc:init(self._skillData:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    skillDesc:leftUp(46, 140)
    skillDesc:setWidth(277)
    skillDesc:autoAdapt()
    -- skillDesc:enableDebugDraw()
    bg:addChild(skillDesc)
    
    -- 消耗提示文本
    local costLayout = UI.Layout:create()
    costLayout:init()
    costLayout:enableAutoWidth()
    costLayout:setSize(0, 30)
    costLayout:centerBottom(98)
    bg:addChild(costLayout)
    
    local costStr = UI.TEXT_227626
    
    local usePointNum = mvc.betModel:getRallySkillPointNumForUseSkill()
    -- local useSkillMaxPoint = mvc.betModel:getRallyTotalUseSkillNum()
    
    -- local useSkillNum = mvc.betModel:getUseSkillNum()
    -- if(useSkillNum >= useSkillMaxPoint) then 
    --     local costText = UI.Text:create()
    --     costText:init(UI.TEXT_227628, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_47_50_55)
    --     costText:center()
    --     costLayout:addComponent(costText)
    -- else
    local useSkillPointNum = mvc.betModel:getUseSkillPointNum()
    -- print("ssssss", useSkillPointNum)
    if(useSkillPointNum < 3) then 
        costStr = UI.TEXT_227626.. string.format(UI.TEXT_227627,tostring(usePointNum),tostring(3- useSkillPointNum))
        
        local costText = UI.Text:create()
        costText:init(costStr, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_47_50_55)
        costText:center()
        costLayout:addComponent(costText)
        
        costLayout:setContentSize(costText:getContentSize().width, costLayout:getContentSize().height)
    else
        -- 使用金币
        costStr = UI.TEXT_227626
        
        local costText = UI.Text:create()
        costText:init(costStr, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_47_50_55)
        costText:floatLeft(0)
        costLayout:addComponent(costText)
        
        local useicon = UI.Image:create()
        useicon:init("symbol_gaming_money.png")
        useicon:floatLeft(5)
        costLayout:addComponent(useicon)
        
        local costNumText = UI.Text:create()
        local useCoin = mvc.betModel:getRallySkillBuyPrice()
        if(useCoin <= GameDataManager:getInstance():getCurCoin()) then
            costNumText:init(tostring(useCoin), UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_47_50_55)
        else
            costNumText:init(tostring(useCoin), UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.UI.FONT_COLOR_NOT_ENOUGH)
        end
        
        costNumText:floatLeft(5)
        costLayout:addComponent(costNumText)
        print("getRallySkillBuyPrice", tostring(useCoin), mvc.betModel:getRallySkillPointNumForUseSkill())
        
        costLayout:setContentSize(10 + costText:getContentSize().width + useicon:getContentSize().width + costNumText:getContentSize().width, costLayout:getContentSize().height)
    end
    -- end
    
    local userBtn = UI.Button:create()
    userBtn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png")
    userBtn:centerBottom(51)
    userBtn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
        print("使用技能")
        local skillID = self._skillData:getId()
        
        local racingEventData = mvc.betModel:getEventDataForSkillID(skillID)
        if(racingEventData == nil) then 
            print("racingEventData is nil  skillID=" .. skillID)
            return
        end
        
        if(mvc.betModel:getRallySkillBuyPrice() > GameDataManager:getInstance():getCurCoin()) then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end
        
        -- 判断是否需要选择目标
        if(racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.CHOICE_NO_BET) then 
            local data = {}
            data.useType = 1
            data.id = skillID
            
            mvc.openPanel("Bet", "RallySkillTargetChoice", data)
        else
            local boatID = 0
            if (racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.CHOICE_BET or 
            racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.RANDOM_BET) then 
                local boatInfo = mvc.betModel:getBetBoatInfo()
                if(boatInfo == nil) then 
                    print("没有找到投注船只信息")
                    UI.ScrollBar:createByText(UI.TEXT_227631)
                    return
                end

                boatID = boatInfo.boatid
            end

            local betBoatInfo = mvc.betModel:getBetInfo(boatID)
            if((betBoatInfo ~= nil and betBoatInfo.BetBoatSailInfo ~= nil and betBoatInfo.BetBoatSailInfo.finishSailMs > 0) or mvc.betModel:getInGameTime() < 0) then 
                UI.ScrollBar:createByText(UI.TEXT_227647)
                return
            end
            
            local data = {}
            data.boatid = boatID
            data.skillid = skillID
            
            Net.NetBigSailSystem:reqUseSkill(data)
        end
        
        self:close()
    end)
    bg:addChild(userBtn)
    -- if(useSkillNum >= useSkillMaxPoint) then 
    --     userBtn:setEnable(false)
    -- end
    
    userBtn:closeClickScale()
    self.userBtn = userBtn
    
    local btnText = UI.Text:create()
    btnText:init(UI.TEXT_1213707, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_47_50_55)
    btnText:center()
    userBtn:addChild(btnText,101)
end



return RallyGameSkillInfo