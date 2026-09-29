--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-09-24 15:32:47
]]

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ChatQuickSwitchCellView = class("ChatQuickSwitchCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

function ChatQuickSwitchCellView:ctor(tableView)
    self._tableView = tableView
    ChatQuickSwitchCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0, 0
    )
end

function ChatQuickSwitchCellView:init( ... )
    ChatQuickSwitchCellView.super.init(self, ... )
end

function ChatQuickSwitchCellView:dtor()
    ChatQuickSwitchCellView.super.dtor(self)
    --reload_script_file_mvc("app.modules.apprenticeship.ChatQuickSwitchCellView")
end

function ChatQuickSwitchCellView:onInitView()
    -- 头像底图
    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:leftUp(0, 0)
    headBg:setScale(0.8)
    self:addChild(headBg)
    self.headBg = headBg
    self.headBg:setTouchEnable(true)
    self.headBg:setSwallowTouches(false)
    self.headBg:setTouchClipNode(self._tableView)
    self.headBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        local lastTouchTime = self._lastTouchTime or 0
        local timeNow = GameManager:getNormalServerTime()
        if (lastTouchTime + 1 > timeNow) then return end
        self._lastTouchTime = timeNow
        if (self._callback) then self._callback() end
    end)

    -- 选中框
    self.selectedFrame = UI.Image:create()
    self.selectedFrame:init("ui_chat_pitch.png")
    self.selectedFrame:center()
    self.selectedFrame:hide()
    self.headBg:addChild(self.selectedFrame, 100)

    -- 头像边框
    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap, 10)

    -- 等级背景图  
    local gradeBG = UI.Image:create()
    gradeBG:init("ui_information_headframe_grade.png")
    gradeBG:leftBottom(-10,-4)
    headBg:addChild(gradeBG, 100) 

    -- 等级
    local lvLabel = UI.Text:create()
    lvLabel:init("11",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_187_167_136)
    lvLabel:setSize(100, 50)
    lvLabel:center()
    lvLabel:setTextCenter()
    gradeBG:addChild(lvLabel,101)
    self.lvLabel = lvLabel

    -- 红点
    local redPoint = AvalonUtil.createRedPoint(headBg, 1, 1, 2000)
    redPoint:hide()
    self.redPoint = redPoint
end

function ChatQuickSwitchCellView:updateData(data)
    if (data and self._data ~= data) then
        self._data = data
        -- 更新头像
        if (self._data.sex and self._data.faceDecodeID) then
            self.headId = self._data.sex..self._data.faceDecodeID
            for k, v in ipairs(self._data.wearEquipId or {}) do
                self.headId = self.headId..v
            end
            Avalon.WidgetUtil:getHeadByData(self, self._data.sex, self._data.faceDecodeID, self._data.wearEquipId or {}, self, handler(self, function(obj, pic)
                if self.headBg and not tolua.isnull(self.headBg) then
                    self.headBg:removeChildByName("heorIcon", true)
                    pic:setPosition(38, 38)
                    pic:setName("heorIcon")
                    self.headBg:addChild(pic, 2)
                end
            end))
        end

        -- 更新等级
        if self._data.roleLV then
            self.lvLabel:setText(self._data.roleLV)
        end
        if Game.ChatManager:getInstance():isShowRedPoint(self._data.pk) then
            self.redPoint:show()
        end
    end
end

function ChatQuickSwitchCellView:updateSelected(b)
    self.selectedFrame:setVisible(b)
    if b then
        self.redPoint:hide()
        Game.ChatManager:getInstance():refreshRedPoint(self._data.pk)
    end
end

function ChatQuickSwitchCellView:updateCallback(cb)
    self._callback = cb
end

function ChatQuickSwitchCellView:showRedPoint(playerData)
    if self._data and playerData.pk == self._data.pk then
        if not self.selectedFrame:isVisible() then
            self.redPoint:show()
        end
        local newHeadId = (playerData.sex or 0)..(playerData.faceDecodeID or 0)
        for k, v in ipairs(playerData.wearEquipId or {}) do
            newHeadId = newHeadId..v
        end

        if newHeadId ~= self.headId then
            self.headId = newHeadId
            Avalon.WidgetUtil:getHeadByData(self, self._data.sex, self._data.faceDecodeID, self._data.wearEquipId or {}, self, handler(self, function(obj, pic)
                if self.headBg and not tolua.isnull(self.headBg) then
                    self.headBg:removeChildByName("heorIcon", true)
                    pic:setPosition(38, 38)
                    pic:setName("heorIcon")
                    self.headBg:addChild(pic, 2)
                end
            end))
        end
    end
end

function ChatQuickSwitchCellView:isRedpointVisible()
    return self.redPoint:isVisible()
end
return ChatQuickSwitchCellView