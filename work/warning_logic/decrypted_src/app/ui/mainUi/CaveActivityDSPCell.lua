-- CaveActivityDSPCell.lua
-- Author:zp
-- 2019年1月8日
-- Using:新春活动cell

require ("app.ui.activity.ActivityDetailNode")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local CaveActivityDSPCell = class("CaveActivityDSPCell",UI.TableViewCell)
UI.CaveActivityDSPCell = CaveActivityDSPCell

function CaveActivityDSPCell:ctor()
    self:setContentSize(cc.size(278, 31))
    self._goodsData = nil
    self.hideLine = false
end

function CaveActivityDSPCell:onEnter()
    CaveActivityDSPCell.super.onEnter(self)
    
end

function CaveActivityDSPCell:onExit()
    CaveActivityDSPCell.super.onExit(self)
end

function CaveActivityDSPCell:dtor()
    CaveActivityDSPCell.super.dtor(self)
end

function CaveActivityDSPCell:init(data)
    self._data = data

    self:onInitView()
end

function CaveActivityDSPCell:onInitView()
    local iconImage = UI.Image:create()
    iconImage:init("ui_activity_number_1.png")
    iconImage:centerLeft(7)
    self:addChild(iconImage)
    self._iconImage = iconImage

    local rankText = UI.Text:create()
    rankText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    rankText:centerLeft(11)
    self:addChild(rankText)
    self._rankText = rankText


    local titleText = UI.Text:create()
    titleText:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    titleText:centerLeft(47)
    self:addChild(titleText)
    self._titleText = titleText


    local contenText = UI.NumberText:create("11", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    contenText:setSize(90,35)
    contenText:setTextCenter()
    contenText:centerRight(5)
    self:addChild(contenText)
    self._contentText = contenText

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    line:setContentSize(278, 1)
    line:setAnchorPoint(cc.p(0, 0.5))
    line:setPosition(cc.p(0, 1))
    self:addChild(line)
    self._line = line

    self:refreView()
end

function CaveActivityDSPCell:sethideLine()
    self.hideLine = true
    if(self._line) then 
        self._line:setVisible(not self.hideLine)
    end
end

function CaveActivityDSPCell:reloadData(data) 
    if(data) then 
        self._data = data
        self:refreView()
    end 
end

function CaveActivityDSPCell:refreView()
    local rankStr = ""
    local nickName = ""
    local damageStr = ""
    local damage = -1
    local isMaster = false

    if(self._line) then 
        self._line:setVisible(not self.hideLine)
    end

    local rank = -1
    if(self._data) then 
        nickName = self._data:getNickName()
        damage = self._data:getDamage()
        isMaster = self._data:getIsMaster()
        rank = self._data:getRank()
        rankStr = string.format("%s", self._data:getRank())
    end
    if(damage >= 0) then 
        damageStr = tostring(damage)
    end

    if(rank >= 1 and rank < 4) then 
        self._rankText:hide()
        self._iconImage:show()
        self._iconImage:setSpriteName(string.format("ui_activity_number_%s.png", rank))
    else 
        self._iconImage:hide()
        self._rankText:show()
    end

    if(self._rankText) then 
        self._rankText:setText(rankStr)
        if(isMaster) then 
            self._rankText:setFontColor(UI.FONT_COLOR_248_157_76)
        else 
            self._rankText:setFontColor(UI.FONT_COLOR_194_194_194)
        end
    end

    if(self._titleText) then 
        self._titleText:setText(nickName)
        if(isMaster) then 
            self._titleText:setFontColor(UI.FONT_COLOR_248_157_76)
        else 
            self._titleText:setFontColor(UI.FONT_COLOR_194_194_194)
        end
    end

    if(self._contentText) then 
        self._contentText:setText(damageStr)
        if(isMaster) then 
            self._contentText:setFontColor(UI.FONT_COLOR_248_157_76)
        else 
            self._contentText:setFontColor(UI.FONT_COLOR_194_194_194)
        end
    end
end

function CaveActivityDSPCell:onUpdateView(data)
    
end
