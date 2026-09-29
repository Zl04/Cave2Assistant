--[[Author:ydli
   Using:移动的链条 实现裁剪、接替移动
   ]]




UI = UI or {}

local MoveChain = class("MoveChain", UI.HWBtnComponent)
UI.MoveChain = MoveChain or {}

function MoveChain:ctor(spriteFrameName, height)
    MoveChain.super.ctor(self, 0, {}, 0, 0)
    self.spriteFrameName = spriteFrameName
    self.height = height
    self.spriteList = {}

    self:init()
end

--虚构函数,destroy时调用(必备)
function MoveChain:dtor()
    MoveChain.super.dtor(self)
end

-- 初始化(必备)
function MoveChain:init()
    MoveChain.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function MoveChain:onInitView()
    -- self:enableDebugDraw(UI.RED)
    local sprite = UI.Image:create()
    sprite:init(self.spriteFrameName)
    sprite:center()
    self:setSize(sprite:getContentSize().width, self.height)
    table.insert(self.spriteList, sprite)

    self.rootLater = UI.Layout:create()
    self.rootLater:init()
    self.rootLater:setSize(self:getContentSize().width , self.height)
    self.rootLater:leftBottom(0, 0)
    -- self.rootLater:rotate(90)
     -- self.rootLater:enableDebugDraw(UI.GREEN)

    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0,0,0,200))
    _ckipperSprite:setContentSize(self:getContentSize().width, self.height)
    local _clipper = cc.ClippingNode:create(_ckipperSprite)
    _clipper:setPosition(0, 0)
    self.clippingNode = _clipper
    self.clippingNode:addChild(self.rootLater)
    self.rootLater:addChild(sprite)
    self:addChild(_clipper)
    
    local size = math.ceil(self.height / sprite:getContentSize().height)
    for i = 1, size do
        local sprite = UI.Image:create()
        sprite:init(self.spriteFrameName)
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(0, 0)
        self.rootLater:addChild(sprite)
        table.insert(self.spriteList, sprite)
    end
    -- print("---MoveChain size----- = ", size)
    local beginY = sprite:getContentSize().height
    for k, v in ipairs(self.spriteList) do
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(0, beginY)
        beginY = beginY + v:getContentSize().height
    end
end

-- 模版函数：更新组建的视图(必备)
function MoveChain:onUpdateView()
    -- print("----------MoveChain:onUpdateView()")
    
end

function MoveChain:move(dis)
    -- print("----MoveChain:move(dis)---", dis)
    for k, v in ipairs(self.spriteList) do
        v:setPositionY(v:getPositionY() + dis)
    end
    if dis > 0 then
        local firstCell = self.spriteList[1]
        if firstCell:getPositionY() >= 0 then
            local lastCell = self.spriteList[#self.spriteList]
            lastCell:setPositionY(firstCell:getPositionY() - lastCell:getContentSize().height)
            table.remove(self.spriteList, #self.spriteList)
            table.insert(self.spriteList, 1, lastCell)
        end
    elseif dis < 0 then
       local lastCell = self.spriteList[#self.spriteList]
       if lastCell:getPositionY() + lastCell:getContentSize().height <= self.height then
            local firstCell = self.spriteList[1]
            firstCell:setPositionY(lastCell:getPositionY() + lastCell:getContentSize().height)
            table.remove(self.spriteList, 1)
            table.insert(self.spriteList, firstCell)
       end
    end
end
