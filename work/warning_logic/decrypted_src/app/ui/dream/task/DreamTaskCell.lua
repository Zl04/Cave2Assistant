-- DreamTaskCell.lua
-- Author:ydli
-- 2019年3月08日
-- Using:梦境任务界面cell

local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local DreamTaskCell = class("DreamTaskCell", UI.HWBtnComponent)
UI.DreamTaskCell = DreamTaskCell

local size = cc.size(411, 99)
local COM_RES_LIST = {
}

function DreamTaskCell:ctor(index, data)
    DreamTaskCell.super.ctor(self, 0, COM_RES_LIST, size.width, size.height)
    self.index = index 
    self.data = data
    self.cfgData = ConfigManager:getDreamTaskById(data.challengeID) or {}
    self:registerListener()
    self:init(self.data)
end

function DreamTaskCell:dtor()
    DreamTaskCell.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function DreamTaskCell:init(data)
    DreamTaskCell.super.init(self)
    local titleBg = UI.Image:create()
    titleBg:init("ui_dreamword_task_line.png")
    titleBg:leftUp(20, 3)
    self:addChild(titleBg)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(390, 1)
    lineUpImage:setAnchorPoint(0, 0)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(20, 0))
    self:addChild(lineUpImage)

    local icon = UI.Image:create()
    icon:init(string.format("ui_dreamword_icon_%d.png", self.index))
    icon:centerLeft(7)
    titleBg:addChild(icon)

    local name = UI.Text:create()
    name:init(self.cfgData.taskName, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_153_153_153)
    name:centerLeft(54)
    titleBg:addChild(name)

    local content = UI.Text:create()
    content:init(self.cfgData.taskDesc, UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_51_51_51)
    content:leftUp(40, 43)
    content:setSize(245, 54)
    content:setTextLeft()
    self:addChild(content)
    content:setLineSpacing(-6)
    
    --title status
    local node = self:showState(data)
    node:centerRight(0)
    self:addChild(node)
end

-- 模版函数：初始化组建的视图
function DreamTaskCell:onInitView()    

end

-- 模版函数：更新组建的视图
function DreamTaskCell:onUpdateView()

end

-- 注册监听事件(可选)
function DreamTaskCell:registerListener()
end

-- 注销监听事件(可选)
function DreamTaskCell:unRegisterListener()

end

function DreamTaskCell:showState(data)
    data = data or {}
    local bgName = ""
    local str = ""
    local fontColor = ""
    if data.stat == PublicDefine.DreamTaskState.State_Success then--成功
        bgName = "ui_information_banner_receive.png"
        str = UI.TEXT_1212267
        fontColor = UI.FONT_COLOR_15_85_71
    elseif data.stat == PublicDefine.DreamTaskState.State_Fail then--失败
        bgName = "ui_information_banner_unfinished1.png"
        str = UI.TEXT_1212268
        fontColor = UI.FONT_COLOR_80_5_5
    else--未领任务
        bgName = "ui_information_banner_unGet.png"
        str = UI.TEXT_1212266
        fontColor = UI.FONT_COLOR_249_220_103
    end

    local bg = UI.Image:create()
    bg:init(bgName)
    local name = UI.Text:create()
    name:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, fontColor)
    name:center()
    name:rotate(-9)
    bg:addChild(name)
    return bg
end
