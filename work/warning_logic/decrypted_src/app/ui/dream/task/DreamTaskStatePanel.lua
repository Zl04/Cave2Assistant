-- DreamTaskStatePanel.lua
-- Author:ydli
-- 2019年03月12日
-- Using:梦境任务在战斗场景的状态
UI = UI or {}
local DreamTaskStatePanel = class("DreamTaskStatePanel", UI.HWBtnComponent)
UI.DreamTaskStatePanel = DreamTaskStatePanel

local size = cc.size(244, 56)
-- 资源列表(必备)
local COM_RES_LIST = {
}
----表情界面
--构造函数(必备)
function DreamTaskStatePanel:ctor(netData)
    --窗口大小
    DreamTaskStatePanel.super.ctor(self, 0, COM_RES_LIST, size.width, size.height)
    local dreamData = MasterDataManager:getDreamData()
    self.taskData = ConfigManager:getDreamTaskById(netData.challengeID) or {}
end

--虚构函数,destroy时调用(必备)
function DreamTaskStatePanel:dtor()
    DreamTaskStatePanel.super.dtor(self)
end

-- 初始化(必备)
function DreamTaskStatePanel:init()
    DreamTaskStatePanel.super.init(self)
    local bgName = "ui_dreamword_task_line_yellow.png"
    local centent = self.taskData.taskDesc
    local left = 26
    local logoName = nil
    if self.taskData.stat == PublicDefine.DreamTaskState.State_Success then--成功
        bgName = "ui_dreamword_task_line_green.png"
        centent = UI.TEXT_1212250
        logoName = "ui_dreamword_task_line_yes.png"
        left = 60
    elseif self.taskData.stat == PublicDefine.DreamTaskState.State_Fail then--失败
        bgName = "ui_dreamword_task_line_red.png"
        centent = UI.TEXT_1212251
        logoName = "ui_dreamword_task_line_no.png"
        left = 60
    end
    local bg = UI.Image:create()
    bg:init(bgName)
    bg:center()
    self:addChild(bg)

    if logoName then
        local logo = UI.Image:create()
        logo:init(logoName)
        logo:centerLeft(23)
        bg:addChild(logo)
    end
   
    local title = UI.Text:create()
    title:init(centent, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    title:centerLeft(left)
    bg:addChild(title)
    title:setDimensions(240 - left, 50)
    title:setTextCenter()
    title:setLineSpacing(-3)
end

-- 模版函数：初始化组建的视图(必备)
function DreamTaskStatePanel:onInitView()
end

-- 模版函数：更新组建的视图(必备)
function DreamTaskStatePanel:onUpdateView()
end

function DreamTaskStatePanel:show()
    self:computePosition()
    local orginX = self:getPositionX()
    local moveOutAction = cc.MoveTo:create(0.01, cc.p(orginX + 350, self:getPositionY()))
    local moveInAction = cc.MoveTo:create(0.8, cc.p(orginX, self:getPositionY()))
    self:runAction(cc.Sequence:create(moveOutAction, cc.EaseSineOut:create(moveInAction)))
end
