--[[
    渲染器
]]--

Renderer = Renderer or {}

local Base = class("RendererBase")
Renderer.Base = Base

-- private:
local RENDERER_INSTANCE_COUNT = 0

-- 构造函数
function Base:ctor()
    -- 地图坐标
    self._coord = {}
    -- 是否隐藏
    self._visible = true
    -- 可以从场景中移除的标志
    self._toRemove = false
    -- 视图节点
    self._viewNode = cc.Node:create()
    self._viewNode.setVisible = function (_,visible)
        self._visible = visible
        getmetatable(self._viewNode).setVisible(self._viewNode,visible)
    end
    if (self._viewNode) then
        self._viewNode:retain()
    else
       assert(false, "[ERROR] Renderer constructor: create view node failed.")
    end

    -- 计算id
    RENDERER_INSTANCE_COUNT = RENDERER_INSTANCE_COUNT + 1
    self._id = RENDERER_INSTANCE_COUNT

    -- print(string.format("Renderer constructor: create the renderer %s.", self))
end

-- 析构函数
function Base:dtor()
    if (self._viewNode) then
        if (self._viewNode:getParent()) then
            self._viewNode:removeFromParent()
        end
        self._viewNode:release()
    end

    -- print(string.format("Renderer destructor: destroy the renderer %s.", self))
end

-- public:
-- 销毁
function Base:destroy()
    self:dtor()
end

-- 是否可以安全移除
function Base:isToRemove()
    return self._toRemove
end

-- 可以安全移除了
function Base:remove()
    self._toRemove = true
end

-- 初始化
function Base:init()
   assert(false, "[ERROR] Renderer init: this method should be overrided by sub class.")
end

-- 获取id
function Base:getId()
    return self._id
end

-- 设置待机视图
function Base:idle()
   assert(false, "[ERROR] Renderer idle: this method should be overrided by sub class.")
end

-- 显示待机动画
function Base:showIDLE()
   assert(false, "[ERROR] Renderer showIDLE: this method should be overrided by sub class.")
end

-- 设置可见性
function Base:setVisible(visible)
    self._visible = visible
    self._viewNode:setVisible(visible)
end

-- 是否可见
function Base:isVisible()
    return self._visible
end

-- 设置地图坐标
function Base:setCoord(x, y)
    self._coord.x = x
    self._coord.y = y
end

-- 获取地图坐标
function Base:getCoord()
    return self._coord
end

-- 设置坐标
function Base:setPosition(posX, posY)
    self._viewNode:setPosition(posX, posY)
end

-- 获取坐标
function Base:getPosition()
    return self._viewNode:getPosition()
end

-- 设置z坐标
function Base:setZOrder(zOrder)
    self._viewNode:setLocalZOrder(zOrder)
end

-- 设置缩放值
function Base:setScale(scale)
    self._viewNode:setScale(scale)
end

function Base:scaleTo(scale)
    self._viewNode:stopAllActions()
    self._viewNode:runAction(cc.ScaleTo:create(0.1, scale))
end

-- 获取缩放值
function Base:getScale()
    return self._viewNode:getScale()
end

-- 设置旋转角度
function Base:setRotation(angle)
    self._viewNode:setRotation(angle)
end

-- 获取视图节点
function Base:getView()
    return self._viewNode
end

-- 添加子节点
function Base:addChild(childNode, zOrder, tag)
    if ((not zOrder) and (not tag)) then
        self._viewNode:addChild(childNode)
    elseif (zOrder and (not tag)) then
        self._viewNode:addChild(childNode, zOrder)
    else
        self._viewNode:addChild(childNode, zOrder, tag)
    end
end

-- 删除子节点
function Base:removeChild(child)
    self._viewNode:removeChild(childNode)
end

-- 删除子节点
function Base:removeChildByName(name)
    self._viewNode:removeChildByName(name)
end

-- 获取视图节点列表
function Base:getViewList()
    return nil
end

-- 渲染
function Base:draw(dt)
    if (not self._visible) then return end

    self:onDraw(dt)
end

-- 模版方法：绘制任务
function Base:onDraw(dt)
   assert(false, "[ERROR] Renderer onDraw: this method should be overrided by sub class.")
end

function Base:showInfomation(textStr, talkDucation, informationLocation)
    -- print("Base:showInfomation ",textStr, talkDucation)
    if informationLocation == nil or #informationLocation == 0 then
        informationLocation = {}
        informationLocation[1] = 0
        informationLocation[2] = 120
    end
    self:hideInfomation(function()
        if(self._infomationNode == nil) then
            self._infomationNode = cc.Node:create()
            self._infomationNode:setContentSize(196,104)

            self._infomationNode:setAnchorPoint(cc.p(0.5, 0))
            self._infomationNode:setPosition(cc.p(0, informationLocation[2]))
            self._viewNode:addChild(self._infomationNode, 101)

            -- 添加背景框
            local bg = UI.Image:create(198,106)
            bg:init("ui_tips_ialogue.png")
            bg:centerBottom(0)
            bg:showLucencyLight()
            self._infomationNode:addChild(bg)

            local textLabel = UI.Text:create()
            textLabel:init(textStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            textLabel:setTextCenter()
            bg:addChild(textLabel)

            if textLabel:getContentSize().width > 180 then
                textLabel:setWidth(180)
                textLabel:autoAdapt()
                textLabel:center()
            else 
                textLabel:center()
            end

            -- 添加一个放大的处理
            self._infomationNode:setScale(0.1)
            local scaleToAction =cc.ScaleTo:create(0.1, 1)
            local fadeInAction = cc.FadeIn:create(0.1)
            local delayAction = cc.DelayTime:create(talkDucation/1000)

            local callFun = cc.CallFunc:create(function() 
                self:hideInfomation()
            end)

            self._infomationNode:runAction(cc.Sequence:create(cc.Spawn:create(scaleToAction,fadeInAction), delayAction, callFun))
        end
    end)
end

--行商头上的文字
function Base:showManorPeddlerInfomation(textStr, saleID, giveID, givePrice, informationLocation)
    if informationLocation == nil or #informationLocation == 0 then
        informationLocation = {}
        informationLocation[1] = 0
        informationLocation[2] = 120
    end

    if self._manorPeddlerInfomationNode ~= nil then
        self._manorPeddlerInfomationNode:removeFromParent()
        self._manorPeddlerInfomationNode = nil
    end
    local GameInManorManager = require "app.game.GameInManorManager"

    self._manorPeddlerInfomationNode = cc.Node:create()
    self._manorPeddlerInfomationNode:setContentSize(196,104)

    self._manorPeddlerInfomationNode:setAnchorPoint(cc.p(0.5, 0))
    self._manorPeddlerInfomationNode:setPosition(cc.p(0, informationLocation[2]))
    self._viewNode:addChild(self._manorPeddlerInfomationNode, 101)

    -- 添加背景框
    local bg = UI.Image9:create()
    bg:init("ui_tips_ialogue.png", CCRectMake(10,10,1,1), cc.size(198, 136))
    bg:centerBottom(0)
    -- bg:showLucencyLight()
    self._manorPeddlerInfomationNode:addChild(bg)

    local textLabel = UI.Text:create()
    textLabel:init(textStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    textLabel:setTextCenter()
    bg:addChild(textLabel)

    textLabel:centerUp(15)
    -- if textLabel:getContentSize().width > 180 then
    --     textLabel:setWidth(180)
    --     textLabel:autoAdapt()
    --     textLabel:center(0,-20)
    -- else 
        -- textLabel:center(0,-20)
    -- end

    local mLine = UI.Image:create()
    mLine:init("ui_manor_line.png")
    mLine:centerUp(38)
    bg:addChild(mLine)


    local peddlerBg = UI.Image:create()
    peddlerBg:init("ui_manor_peddler_bg_1.png")
    peddlerBg:centerBottom(6,0)
    bg:addChild(peddlerBg)

    -- local peddlerGoodsIcon = UI.Image:create()
    -- peddlerGoodsIcon:init("ui_manor_peddler_idle.png")
    -- peddlerGoodsIcon:center(-40)
    -- peddlerBg:addChild(peddlerGoodsIcon)

    -- local currencyIcon = UI.Image:create()
    -- currencyIcon:init("ui_manor_peddler_idle.png")
    -- currencyIcon:center()
    -- peddlerBg:addChild(currencyIcon)

    local currencyNumberText = UI.Text:create()
    currencyNumberText:init(AvalonUtil:getSimpleNumber(0, 4), UI.FONT_ARIAL, 16, {r=41,g=41,b=45})
    currencyNumberText:centerLeft(78.5 + 10)
    peddlerBg:addChild(currencyNumberText)


    local purchaseItem = GameInManorManager:getInstance():getPeddlerShopData()
    if purchaseItem ~= nil then
        peddlerBg:show()
        
        -- local goodData = GoodsDataManager:createLocalGoodsData(purchaseItem.saleID)
        -- peddlerGoodsIcon:setSpriteName(goodData:getSmallIconName())
        
        -- local goodData2 = GoodsDataManager:createLocalGoodsData(purchaseItem.giveID)
        -- currencyIcon:setSpriteName(goodData2:getSmallIconName())



        local peddlerGoodsIcon = UI.GoodsGrid:create()
        peddlerGoodsIcon:center(-40)
        self.peddlerGoodsIcon = peddlerGoodsIcon

        local goodData = GoodsDataManager:createLocalGoodsData(purchaseItem.saleID)
        self.peddlerGoodsIcon:init(goodData)
        self.peddlerGoodsIcon:hideBG()
        self.peddlerGoodsIcon:hideRare()
        -- self.peddlerGoodsIcon:hideNewIcon()
        self.peddlerGoodsIcon:hideCountLabel()
        self.peddlerGoodsIcon:showInfoArea(false, false)
        self.peddlerGoodsIcon:setTouchEnable(true)
        self.peddlerGoodsIcon:setSwallowTouches(false)
        self.peddlerGoodsIcon:setScale(0.65)
        self.peddlerGoodsIcon:runAction(
                    cc.Sequence:create(cc.DelayTime:create(0.1),
                    cc.CallFunc:create(function() 
                        self.peddlerGoodsIcon:hideNewIcon()
                    end)))
        peddlerBg:addChild(peddlerGoodsIcon)


        local currencyIcon = UI.GoodsGrid:create()
        currencyIcon:center()
        self.currencyIcon = currencyIcon
        
        local goodData2 = GoodsDataManager:createLocalGoodsData(purchaseItem.giveID)
        self.currencyIcon:init(goodData2)
        self.currencyIcon:hideBG()
        self.currencyIcon:hideRare()
        self.currencyIcon:hideNewIcon()
        self.currencyIcon:hideCountLabel()
        self.currencyIcon:showInfoArea(false, false)
        self.currencyIcon:setTouchEnable(true)
        self.currencyIcon:setSwallowTouches(false)
        self.currencyIcon:setScale(0.65)
        self.currencyIcon:runAction(
                    cc.Sequence:create(cc.DelayTime:create(0.1),
                    cc.CallFunc:create(function() 
                        self.currencyIcon:hideNewIcon()
                    end)))
        peddlerBg:addChild(currencyIcon)



        currencyNumberText:setText(AvalonUtil:getSimpleNumber(purchaseItem.givePrice, 4))

    else
        peddlerBg:hide()
    end


    --更换流浪商人售卖货物航线的入口
    local GameInManorManager = require "app.game.GameInManorManager"
    local pk = RoleDataManager:getMaster():getPK()
    local ownerPk = GameInManorManager:getInstance():getOwnerPk()
    if pk == ownerPk then
        --如果是自己的庄园才能操作
        local routeBtn = UI.Button:create()
        routeBtn:init('ui_manor_btn.png', 'ui_manor_btn.png', 'ui_manor_btn.png')
        routeBtn:centerUp(46)
        routeBtn:setText(UI.TEXT_221810)
        routeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
        bg:addChild(routeBtn)
        
        routeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            --打开航线界面
            -- route:setText("测试更换完毕")
            mvc.openPanel("ManorPedleryMaterial", "ManorPedleryMaterial")
        end)
    end

end

-- 隐藏NPC消息
function Base:hideInfomation(callback)
--  print("Base:hideInfomation ")
    if(self._infomationHide) then
        self._infomationNode:runAction(cc.RemoveSelf:create())
        self._infomationNode = nil
        self._infomationHide = false

        if(callback) then
            callback(self)
        end
    else
        if(self._infomationNode) then
            self._infomationHide = true

            local callFunIcon = cc.CallFunc:create(function() 
                if self._infomationNode then
                    self._infomationNode:runAction(cc.RemoveSelf:create())
                    self._infomationNode = nil
                    self._infomationHide = false
                    if(callback) then
                        callback(self)
                    end
                end
            end)

            local scaleToAction =cc.ScaleTo:create(0.1, 0)
            local fadeOutAction = cc.FadeOut:create(0.1)
            local delayAction = cc.DelayTime:create(0.2)

            self._infomationNode:runAction(cc.Sequence:create(cc.Spawn:create(scaleToAction,fadeOutAction), delayAction, callFunIcon))
        else
            if(callback) then
                callback(self)
            end
        end
    end
end

function Base:pause()
    self.isPause = true
    if(not tolua.isnull(self._infomationNode)) then
        self._infomationNode:pause()
    end
end

function Base:resume()
    self.isPause = false
    if(not tolua.isnull(self._infomationNode)) then
        self._infomationNode:resume()
    end
end

function Base:handleAddAnimation(animation)
    if(self.isPause) then
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
            if(not tolua.isnull(animation)) then
                animation:pause()
            end
        end, 2)
    end
end