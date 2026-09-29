------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardUpgradeCellView = class("ManorStarMapCardUpgradeCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 420
local COM_HEIGHT = 116

function ManorStarMapCardUpgradeCellView:ctor(upData)
    ManorStarMapCardUpgradeCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._upData = upData
    self._remainTimeDt = 0
    self._isShowEffect = false
    Avalon.Scheduler:scheduleUpdate(self, self.update)
    

    -- -- 测试数据
    -- self._upData.cardId = 2030510
    -- self._upData.endTime = GameManager:getNormalServerTime() + 36000
    -- self._upData.slotId = 1
end

function ManorStarMapCardUpgradeCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardUpgradeCellView.super.init(self, ... )
end

function ManorStarMapCardUpgradeCellView:dtor()
    ManorStarMapCardUpgradeCellView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardUpgradeCellView")
end


function ManorStarMapCardUpgradeCellView:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local isUnlock = false
    local bgStr = "ui_starmap_list_1.png"
    if self._upData.slotId then
        isUnlock = true
    end

    if not isUnlock then
        bgStr = "ui_starmap_list_2.png"
    end

    self._bg = UI.Image:create()
    self._bg:init(bgStr)
    self._bg:center()
    self.contentLayout:addChild(self._bg)

    if isUnlock then

        if self._upData.cardId ~= 0 then
            local cardConfig = ConfigManager:getAllStarCardDataByID(self._upData.cardId)
            local cardData = clone(mvc.manorStarMapModel:getCardDataByCardId(self._upData.cardId))

            --有卡在升级
            local cardImg = UI.Image:create()
            cardImg:init(cardConfig.icon)
            cardImg:centerLeft(13,0)
            self._bg:addChild(cardImg)


            local levelBg = UI.Image:create()
            levelBg:init("ui_starmap_gradebg.png")
            levelBg:centerLeft(14,-19)
            self._bg:addChild(levelBg)

            local levelText = UI.Text:create()
            levelText:init(tostring(cardData.level), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 172, g = 166, b = 159})
            levelText:center()
            levelBg:addChild(levelText)

            local nameText = UI.Text:create()
            nameText:init(languageManagerInstance:getLocalString(cardConfig.name), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 172, g = 166, b = 159})
            nameText:leftBottom(109,84)
            self._bg:addChild(nameText)


            --属性
            local nextCardData = clone(cardData)
            if nextCardData.level < cardConfig.maxLevel then
                nextCardData.level = nextCardData.level + 1
            end
            local attrData = mvc.manorStarMapModel:getCardAttributesByCardData(cardData)
            local attrNextData = mvc.manorStarMapModel:getCardAttributesByCardData(nextCardData)

            for k,v in ipairs(attrData) do
                local nData = attrNextData[k]
                local nowValue,valueType = ToolsUtil:calculationAttrShowValue(v.attrType,v.value)
                local nowValue2,valueType2 = ToolsUtil:calculationAttrShowValue(nData.attrType,nData.value)

                if valueType == PublicDefine.VALUE_TYPE.Value then
                    local valueNum = tonumber(nowValue)
                    if valueNum > 99999 then 
                        valueNum = AvalonUtil:getSimpleNumber(valueNum, 4) 
                        nowValue = tostring(valueNum)
                    end
                end

                if valueType2 == PublicDefine.VALUE_TYPE.Value then
                    local valueNum = tonumber(nowValue2)
                    if valueNum > 99999 then 
                        valueNum = AvalonUtil:getSimpleNumber(valueNum, 4) 
                        nowValue2 = tostring(valueNum)
                    end
                end

                local attrLayout = UI.Layout:create()
                attrLayout:init()
                attrLayout:enableAutoWidth()
                attrLayout:leftBottom(113, 56 - (k - 1) * 25)
                self._bg:addChild(attrLayout)

                local attrIcon = UI.Image:create()
                attrIcon:init(v.icon)
                attrIcon:floatLeft(0)
                attrLayout:addComponent(attrIcon)

                local attrText = UI.Text:create()
                attrText:init(nowValue, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=40,b=42})
                attrText:floatLeft(5)
                attrLayout:addComponent(attrText)

                local attrText2 = UI.Text:create()
                attrText2:init("(" .. nowValue2 .. ")", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=25,g=87,b=76})
                attrText2:floatLeft(3)
                attrLayout:addComponent(attrText2)

            end

            --倒计时
            local endTime = self._upData.endTime - GameManager:getNormalServerTime()
            local timeStr = AvalonUtil:_getFullFormatTime(endTime, true)

            local remainTime = UI.Text:create()
            remainTime:init(timeStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=40,b=42})
            remainTime:centerBottom(72, 140)
            self._bg:addChild(remainTime)
            self._remainTime = remainTime

            --立即完成
            local accelerateBtn = UI.Button:create()
            accelerateBtn:init("ui_starmap_btn_2.png", "ui_starmap_btn_2.png", "ui_starmap_btn_2.png")
            accelerateBtn:centerBottom(22, 140)
            accelerateBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=40,b=42})
            accelerateBtn:setText(UI.TEXT_222631)
            self._bg:addChild(accelerateBtn)
            accelerateBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                local cost = 999
                local endTime = self._upData.endTime - GameManager:getNormalServerTime()
                local compStr = Config.General:getValueForKey("starCardCompleteConsumption")
                local compTable = string.split(compStr, ",")
                cost = math.ceil(endTime / tonumber(compTable[1]) ) *  tonumber(compTable[2])

                local upgradeTips = UI.Tips:createTips(string.format(UI.TEXT_222635, cost),
                    UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

                upgradeTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                    local diamond = RoleDataManager:getMaster():getDiamond()
                    if diamond < cost then
                        UI.ScrollBar:createByText(UI.TEXT_1110390)
                    else

                        self._upgradeFrame:setAnimation("begin", false)

                        local action = cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function() 
                            -- 向服务器发送立即完成消息
                            local cardId = self._upData.cardId
                            local slotId = self._upData.slotId
                            Net.NetManorSystem:reqStarCardUpgradeDirectly(slotId,cardId)
                        end))

                        self:runAction(action)
                    end
                end)

            end)

        else
            --没卡在升级
            local desText = UI.Text:create()
            desText:init(UI.TEXT_222630, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=44,b=41})
            desText:leftBottom(120,30)
            self._bg:addChild(desText)
        end
    else
        --未解锁
        local desText = UI.Text:create()
        desText:init(languageManagerInstance:getLocalString(self._upData.unlockDesc), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=44,b=41})
        desText:leftBottom(120,30)
        self._bg:addChild(desText)
    end


    self._upgradeFrame = UI.Animation:create()
    self._upgradeFrame:init("effect_ui_starmap_levelup_card.json", "effect_ui_starmap_levelup_card.atlas", 1);
    self._upgradeFrame:center(0,0)
    self.contentLayout:addChild(self._upgradeFrame)

end

function ManorStarMapCardUpgradeCellView:update(dt)

    self._remainTimeDt = self._remainTimeDt + dt
    if self._remainTimeDt >= 1 and self._remainTime then
        self._remainTimeDt = 0

        local endTime = self._upData.endTime - GameManager:getNormalServerTime()

        if not self._isShowEffect and endTime <= 2 then
            self._isShowEffect = true
            self._upgradeFrame:setAnimation("begin", false)
        end

        if endTime <= 0 then endTime = 0 end
        local timeStr = AvalonUtil:_getFullFormatTime(endTime, true)
        self._remainTime:setText(timeStr)
    end
end


function ManorStarMapCardUpgradeCellView:bindModel()

end


function ManorStarMapCardUpgradeCellView:unbindModel()

end





return ManorStarMapCardUpgradeCellView












