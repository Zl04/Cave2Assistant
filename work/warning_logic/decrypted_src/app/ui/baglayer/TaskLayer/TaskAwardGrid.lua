--[[
    任务列表中奖励的物品格子
    AUTHOR:CZH
]]
UI = UI or {}
local TaskAwardGrid = class("TaskAwardGrid",UI.ListGrid)
UI.TaskAwardGrid = TaskAwardGrid

UI.TaskAwardGridType = {
    GOLD = 1,
    DIAMOND = 2,
    EXP = 3,
    GOODS = 4,
}
local TaskAwardGridType = UI.TaskAwardGridType

local size = cc.Director:getInstance():getWinSize()
local Grid_LIST = {
}
local  BG = "box_quality_0_1.png"       -- 格子背景图片
local  EXP = "icon_exp.png" -- 经验图片
local  AWARD_GLOD = "icon_gold.png"     -- 黄金图片
local  AWARD_DIAMOND = "icon_diamonds.png" -- 钻石图片
function TaskAwardGrid:ctor(type)

TaskAwardGrid.super.ctor(self, Grid_LIST,0,0,false)
    self._data = nil
    self._num = nil 
    self._type = nil 
    self._goldIcon = nil 
    self._diamondIcon = nil 
    self._expIcon = nil 


end

function TaskAwardGrid:dtor()
    self._num = nil 
    self._data = nil
    self._type = nil 
    TaskAwardGrid.super.dtor(self)
end

function TaskAwardGrid:init(data,type)
    -- if (data) then
    --     self:setData(data)
    -- end
    self._data = data
    self._type = type 
    TaskAwardGrid.super.init(self)
end


function TaskAwardGrid:onInitView(data)
    -- 格子背景
    local bg = cc.Sprite:create()
    bg:initWithSpriteFrameName(BG)
    self:addChild(bg)
    -- bg:setPosition(self._hw, self._hh)

    -- 格子里面的物品ICON
    local itemIcon = cc.Sprite:create()
    -- itemIcon:setPosition(self._hw, self._hh)
    self:addChild(itemIcon)
    
    -- 黄金数量
    local itemConut=  UI.Text:create()
    itemConut:init("")
    itemConut:setFontSize(15)
    itemConut:setFontColor(UI.FONT_COLOR_247_245_232)
    itemConut:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    itemConut:rightBottom(-30,-33)
    self:addChild(itemConut,999)
    -- 钻石数量
    local diamondConut=  UI.Text:create()
    diamondConut:init("")
    diamondConut:setFontSize(15)
    diamondConut:setFontColor(UI.FONT_COLOR_247_245_232)
    diamondConut:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    diamondConut:rightBottom(-30,-33)
    self:addChild(diamondConut,999)
    self._diamondConut = diamondConut

    -- 经验数量
    local expConut=  UI.Text:create()
    expConut:init("")
    expConut:setFontSize(15)
    expConut:setFontColor(UI.FONT_COLOR_247_245_232)
    expConut:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    expConut:rightBottom(-30,-33)
    self:addChild(expConut,999)
    self._expConut = expConut


    local goodsConut=  UI.Text:create()
    goodsConut:init("")
    goodsConut:setFontSize(15)
    goodsConut:setFontColor(UI.FONT_COLOR_247_245_232)
    goodsConut:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    goodsConut:rightBottom(-30,-33)

    self:addChild(goodsConut,999)
    self._goodsConut = goodsConut


    self._bg = bg 
    self._itemIcon = itemIcon
    self._itemConut = itemConut
    
    self._bg:setVisible(false)
    self._itemConut:setVisible(false)
    self._itemIcon:setVisible(false)
    self._diamondConut:setVisible(false)
    self._expConut:setVisible(false)
    self._goodsConut:setVisible(false)
 
end

function TaskAwardGrid:setData(data)
    if data then
        self._data = data
    end  
end

function TaskAwardGrid:getData( data )
    return self._data
end

function TaskAwardGrid:onUpdateView(data)
    local data = self._data
    local type = self._type    
    if(data ~= nil ) then 
        if(type == TaskAwardGridType.GOLD ) then 
            print("---TaskAwardGridType.DIAMOND黄金--",data)
            local iconName = UI.Image:create()
            iconName:init(AWARD_GLOD)
            iconName:center()
            iconName:setPosition(self._hw, self._hh)
            self:addChild(iconName)
            self._goldIcon = iconName
            self._itemConut:setText(string.format("%s",data))
            self._itemConut:setVisible(true)
            self._bg:setPosition(self._hw, self._hh)
            self._bg:setVisible(true)
            self._diamondConut:setVisible(false)
            self._expConut:setVisible(false)
            self._goodsConut:setVisible(false)
        elseif (type == TaskAwardGridType.DIAMOND) then 
            print("---TaskAwardGridType.DIAMOND钻石--",data)
            local iconName = UI.Image:create()
            iconName:init(AWARD_DIAMOND)
            iconName:center()
            iconName:setPosition(self._hw, self._hh)
            self:addChild(iconName)
            self._diamondIcon = iconName
            self._diamondConut:setText(string.format("%s",data))
            self._diamondConut:setVisible(true)
            self._bg:setPosition(self._hw, self._hh)
            self._bg:setVisible(true)
            self._itemConut:setVisible(false)
            self._expConut:setVisible(false)
            self._goodsConut:setVisible(false)
        elseif (type == TaskAwardGridType.EXP) then
            print("---TaskAwardGridType.DIAMOND经验--",data)
            local iconName = UI.Image:create()
            iconName:init(EXP)
            iconName:center()
            iconName:setPosition(self._hw, self._hh)
            self:addChild(iconName)
            self._expIcon = iconName
            self._expConut:setText(string.format("%s",data))
            self._expConut:setVisible(true)
            self._bg:setPosition(self._hw, self._hh)
            self._bg:setVisible(true)
            self._itemConut:setVisible(false)
            self._diamondConut:setVisible(false)
            self._goodsConut:setVisible(false)
        elseif (type == TaskAwardGridType.GOODS) then
            -- print("-------TaskAwardGridType.GOODS-----------", #data)
            local iconName = data:getIconName()
            local count = data:getNum()
            self._itemIcon:setSpriteFrame(iconName)
            self._itemIcon:setVisible(true)
            self._itemIcon:setPosition(self._hw, self._hh)
        
            self._goodsConut:setText(string.format("%s",count))
            self._goodsConut:setVisible(true)
        
            self._bg:setPosition(self._hw, self._hh)
            self._bg:setVisible(true)

            self._itemConut:setVisible(false)
            self._diamondConut:setVisible(false)
            self._expConut:setVisible(false)
        end 
    end 
end

function TaskAwardGrid:DisableVisiable()
    self._itemConut:setVisible(false)
    self._diamondConut:setVisible(false)
    self._expConut:setVisible(false)
    self._bg:setVisible(false)
    self._itemIcon:setVisible(false)
    if(self._expIcon) then 
        self._expIcon:setVisible(false)
    end 
    if(self._goldIcon) then 
        self._goldIcon:setVisible(false)
    end
    if(self._diamondIcon) then 
        self._diamondIcon:setVisible(false)
    end
end 

function TaskAwardGrid:enableVisiable()
    self._itemConut:setVisible(true)
    self._diamondConut:setVisible(true)
    self._expConut:setVisible(true)
    self._bg:setVisible(true)
    self._itemIcon:setVisible(true)
    if(self._expIcon) then 
        self._expIcon:setVisible(true)
    end 
    if(self._goldIcon) then 
        self._goldIcon:setVisible(true)
    end
    if(self._diamondIcon) then 
        self._diamondIcon:setVisible(true)
    end
end 

function TaskAwardGrid:onUseShader(shader, shaderName)
    if(self._expIcon) then 
        self._expIcon:setGLProgramState(shader)
    end 
    if(self._goldIcon) then 
        self._goldIcon:setGLProgramState(shader)
    end
    if(self._diamondIcon) then 
        self._diamondIcon:setGLProgramState(shader)
    end
end