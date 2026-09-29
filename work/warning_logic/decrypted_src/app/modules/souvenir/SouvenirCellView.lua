------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SouvenirCellView = class("SouvenirCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 824
local COM_HEIGHT = 264
local MAX_NUM = 4



function SouvenirCellView:ctor()
    SouvenirCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._data = {}
    self._remainTimeDt = 0
    self._timeObjectList = {} -- 保存定时器List

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function SouvenirCellView:init(index, ...)
    self._index = index
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.souvenir", "Souvenir", false)
    SouvenirCellView.super.init(self, ... )
end

function SouvenirCellView:dtor()
    SouvenirCellView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file_mvc("app.modules.souvenir.SouvenirCellView")
end


function SouvenirCellView:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bIndex = (self._index - 1) * MAX_NUM + 1
    local eIndex = bIndex + MAX_NUM - 1
    for i = bIndex, eIndex do
        if mvc.souvenirModel.souvenirData[i] ~= nil then
            table.insert(self._data, mvc.souvenirModel.souvenirData[i])
        end
    end

    for k,v in ipairs(self._data) do
        local bgButton = UI.Button:create()
        bgButton:init("ui_souvenir_paper.png", "ui_souvenir_paper.png")
        bgButton:floatLeft(22)
        bgButton:closeClickScale()
        bgButton:setSwallowTouches(false)
        contentLayout:addComponent(bgButton)

        bgButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if v.isGet then
                mvc.openPanel("Souvenir", "SouvenirDetails", v)
                local needSave = mvc.souvenirModel:openSouvenirDeleteRedDot(v.ID)

                if needSave then
                    local tempData = clone(mvc.souvenirModel:getSouvenirDataByID(v.ID))
                    tempData.souvenidID = tempData.ID
                    mvc.souvenirModel:updateSouvenirDatas(tempData)
                    self:updateRedPoint(v,bgButton)
                    --通知更新界面
                    mvc.send("Souvenir_Resource_Change")
                end
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(v.obtainWay))
            end
        end)

        self:initSouvenirCellView(bgButton, v)
    end

end

function SouvenirCellView:initSouvenirCellView(bgButton, data)
    if not bgButton then return end

    local iconBg  = UI.Image:create()
    iconBg:init("ui_souvenir_box.png")
    iconBg:centerUp(5)
    bgButton:addChild(iconBg,999)

    local icon = UI.Image:create()
    icon:init(data.resName)
    icon:center()
    iconBg:addChild(icon)

    local name = UI.Text:create()
    name:init(LanguageManager:getInstance():getLocalString(data.name), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=41,g=41,b=45})
    name:centerBottom(54)
    bgButton:addChild(name,999)

    --测试数据
    -- data.isActivity = true
    -- data.isGet = true
    -- data.activationExpiredTime = GameManager:getNormalServerTime() + 66

    if data.isGet and data.isActivity then
        local endTime = data.activationExpiredTime - GameManager:getNowServerTime()
        if endTime <= 0 then endTime = 0 end

        local timeLayout = UI.Layout:create()
        timeLayout:init()
        timeLayout:centerBottom(12,-5)
        bgButton:addChild(timeLayout,999)

        local layoutWidth = 0
        local timeIcon = UI.Image:create()
        timeIcon:init("ui_information_clock_bg.png")
        timeIcon:floatLeft(3)
        timeLayout:addComponent(timeIcon)
        layoutWidth = layoutWidth + timeIcon:getContentSize().width + 3
        
        local timeStr = AvalonUtil:_getFullFormatTime(endTime, true)
        local timeText = UI.Text:create()
        timeText:init(timeStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
        timeText:floatLeft(3)
        timeLayout:addComponent(timeText)
        layoutWidth = layoutWidth + timeText:getContentSize().width + 3

        timeLayout:setSize(layoutWidth, 25)

        table.insert(self._timeObjectList, {endTime = data.activationExpiredTime, remainTime = timeText, timeIcon = timeIcon, timeLayout = timeLayout})

        local activeImg = UI.Image:create()
        activeImg:init("ui_souvenir_activation.png")
        activeImg:leftUp(-8,-15)
        bgButton:addChild(activeImg,999)

    end

    if data.isGet then
        local levelBg  = UI.Image:create()
        levelBg:init("ui_souvenir_lvbg.png")
        levelBg:centerBottom(-15)
        iconBg:addChild(levelBg)

        local levelText = UI.Text:create()
        levelText:init(mvc.souvenirModel:getLevelStrBySouvenirID(data.ID), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 230, g = 180, b = 73})
        levelText:center()
        levelBg:addChild(levelText)

        icon:setGray(false)
    else   
        icon:setGray(true)
        -- name:setText("??????")

        local desText = UI.Text:create()
        desText:init(UI.TEXT_228403, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
        desText:centerBottom(12)
        bgButton:addChild(desText,999)
    end

    self:updateRedPoint(data, bgButton)

end

function SouvenirCellView:updateRedPoint(data, bgButton)
    if not data or not bgButton then return end


    local isRedData = mvc.souvenirModel:isRedData(data.ID)
    local redPointImg = bgButton:getChildByName("redPointImg")
    -- print(" isRedData ===  ",isRedData)
    if isRedData then
        
        if not redPointImg then
            redPointImg = AvalonUtil.createRedPoint(bgButton, -2, -2, 999)
            redPointImg:setName("redPointImg")
        end

        redPointImg:show()

        -- if not self._redPointImg then
        --     self._redPointImg = AvalonUtil.createRedPoint(bgButton, -2, -2, 999)
        -- end
        -- self._redPointImg:show()
    else
        if redPointImg then
            redPointImg:hide()
        end
    end
end

function SouvenirCellView:update(dt)

    self._remainTimeDt = self._remainTimeDt + dt
    if self._remainTimeDt >= 1 then
        self._remainTimeDt = 0
        
        
        if table.nums(self._timeObjectList) > 0 then
            for k,v in pairs(self._timeObjectList) do
                if v.timeIcon and v.timeLayout and v.remainTime and v.endTime then
                    local endTime = v.endTime - GameManager:getNowServerTime()
                    if endTime <= 0 then endTime = 0 end
                    local timeStr = AvalonUtil:_getFullFormatTime(endTime, true)
                    v.remainTime:setText(timeStr)

                    local layoutWidth = v.timeIcon:getContentSize().width + 3 + v.remainTime:getContentSize().width + 3
                    v.timeLayout:setSize(layoutWidth, 25)
                end
            end
        end
    end
end


function SouvenirCellView:bindModel()

end


function SouvenirCellView:unbindModel()

end





return SouvenirCellView












