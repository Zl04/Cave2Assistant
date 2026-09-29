-- ActivityPanelCell.lua
-- Author:zp
-- 2017年12月19日
-- Using:运营活动cell

require ("app.ui.activity.ActivityDetailNode")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local ActivityPanelCell = class("ActivityPanelCell",UI.TableViewCell)
UI.ActivityPanelCell = ActivityPanelCell

function ActivityPanelCell:ctor()

end

function ActivityPanelCell:onEnter()
    ActivityPanelCell.super.onEnter(self)
    
end

function ActivityPanelCell:onExit()
    ActivityPanelCell.super.onExit(self)
    print("GuildManagerPanel:onExit")
    
end

function ActivityPanelCell:dtor()
    ActivityPanelCell.super.dtor(self)
end

function ActivityPanelCell:init(data)
    self._data = data

    self:onInitView()
end

function ActivityPanelCell:onInitView()
    local activityDetailNode = UI.ActivityDetailNode:create()
    activityDetailNode:init(self._data)
    local width, height = activityDetailNode:getSize()
    activityDetailNode:leftBottom(0, 0)
    self:addChild(activityDetailNode)

    self._activityDetailNode = activityDetailNode
end

function ActivityPanelCell:onUpdateView(data)
    if(self._activityDetailNode and data) then
        self._activityDetailNode:updateView(data)
    end
end