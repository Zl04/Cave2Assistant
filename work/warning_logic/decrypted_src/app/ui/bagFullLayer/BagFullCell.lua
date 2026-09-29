-- BagFullCell.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:背包满cell
UI = UI or {}
local BagFullCell = class("BagFullCell", UI.HWBtnComponent)
UI.BagFullCell = BagFullCell

local PACKET_TYPE = PublicDefine.PACKET_TYPE 

local COM_RES_LIST = {
}

local _WIDTH = 163
local _HEIGHT = 190

function BagFullCell:ctor(data,idx)
    -- print("BagFullCell:ctor")
    BagFullCell.super.ctor(
        self,UIType.BAG_FULL_CELL,
        COM_RES_LIST,
        _WIDTH,
        _HEIGHT
    )

    -- self:setTouchEnable(true);
    -- self:setInterceptTouches(false);

    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx = idx
    self:init();
end

function BagFullCell:dtor()
    -- print("BagFullCell:dtor")
    BagFullCell.super.dtor(self)
    self:unRegisterListener();
end

-- public:
-- 初始化
function BagFullCell:init()
    BagFullCell.super.init(self)
end


-- 模版函数：初始化组建的视图
function BagFullCell:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0, _HEIGHT))
    self.rootLayer:setContentSize(cc.size(_WIDTH,_HEIGHT))
    self:addChild(self.rootLayer,100)

    self:reload(self.data,self.idx)

    self:registerListener();
end


function BagFullCell:createView()
    self.rootLayer:removeAllChildren()
    local picBG = cc.Sprite:createWithSpriteFrameName("ui_info_banner_iteminfo2.png")
    picBG:setAnchorPoint(cc.p(0,0))
    picBG:setPosition(0,0)
    self.rootLayer:addChild(picBG)

    --掉落物品名称
    local itemName = UI.Text:create()
    itemName:init("123",UI.FONT_STANDARD,UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    itemName:setSize(150, 35)
    itemName:setLineSpacing(-6)
    itemName:setTextCenter()
    itemName:setWidth(150)
    itemName:centerUp(20- itemName:getContentSize().height/2)
    -- itemName:enableDebugDraw()
    self._itemName = itemName
    self.rootLayer:addChild(itemName)

    --物品
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:centerBottom(72)
    self.mGoodsGrid:hideNewIcon()
    self.rootLayer:addChild(self.mGoodsGrid)
    self.mGoodsGrid:setScale(0.75)

    -- -- 星星图标
    -- local picStar = cc.Sprite:createWithSpriteFrameName("symbol_character_hero_power.png")
    -- picStar:setAnchorPoint(cc.p(0,0))
    -- picStar:setPosition(60,62)
    -- self.rootLayer:addChild(picStar)
    -- self._picStar = picStar

    -- -- 装备等级分数
    -- local txtStar = UI.Text:create()
    -- txtStar:init("12333",UI.FONT_STANDARD,UI.FONT_SIZE_18PX)
    -- txtStar:leftBottom(70,60)
    -- txtStar:setTextCenter()
    -- txtStar:setFontColor(UI.FONT_COLOR_63_51_33)
    -- self.rootLayer:addChild(txtStar)
    -- self._txtStar = txtStar

    -- 添加星数
    local picStar = UI.Image:create()
    picStar:init("symbol_character_hero_power.png")
    picStar:centerLeft(50)
    self.rootLayer:addChild(picStar)
    self._picStar = picStar

    -- 星级分数文本
    self._txtStar = UI.Text:create()
    self._txtStar:init("1", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._txtStar:centerLeft(picStar:getContentSize().width + 4)
    picStar:addChild(self._txtStar)

    -- 进度条背景
    local picProBG = cc.Sprite:createWithSpriteFrameName("ui_info_progressbar_00.png")
    picProBG:setPosition(81,45)
    self.rootLayer:addChild(picProBG)
    self._picProBG = picProBG

    self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_info_progressbar_10.png"))
    self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._pro:setMidpoint(cc.p(0,0))
    self._pro:setBarChangeRate(cc.p(1,0))
    self._pro:setPosition(cc.p(self._picProBG:getContentSize().width/2,self._picProBG:getContentSize().height/2))
    self._pro:setPercentage(100)
    self._picProBG:addChild(self._pro,20)

    -- 回收按钮
    local btnGain = UI.Button:create()
    btnGain:init("ui_info_button1_0.png","ui_info_button1_1.png","ui_info_button1_0.png")
    btnGain:leftBottom(5,8)
    btnGain:addEventListener(UIEvent.BUTTON_CLICK,self,self.onGain)
    self.rootLayer:addChild(btnGain)

    local txtGain = UI.Text:create()
    txtGain:init(UI.TEXT_110035,UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    txtGain:center()
    txtGain:setName("txt")
    btnGain:addChild(txtGain,100)

    -- 放弃按钮
    local btnDiscard = UI.Button:create()
    btnDiscard:init("ui_info_button2_0.png","ui_info_button2_1.png","ui_info_button2_0.png")
    btnDiscard:rightBottom(5,8)
    btnDiscard:addEventListener(UIEvent.BUTTON_CLICK,self,self.onDiscard)
    self.rootLayer:addChild(btnDiscard)

    local txtDiscard = UI.Text:create()
    txtDiscard:init(UI.TEXT_110036,UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    txtDiscard:center()
    txtDiscard:setName("txt")
    btnDiscard:addChild(txtDiscard,100)
end

--丢弃
function BagFullCell:onDiscard()
    Net.NetGoodsSystem:deleteGoodsFromFullBag(self.data.serialID)
end

--回收
function BagFullCell:onGain()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
end

-- 模版函数：更新组建的视图
function BagFullCell:onUpdateView()
end


function BagFullCell:reload(data,idx)
    self.data = data;
    self.idx = idx

    self:createView()

    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(data.templateID)
    self._pro:stopAllActions()

    local oldData = GoodsDataManager:getGoodsData(PACKET_TYPE.PACKET_TEMPORARY,data.templateID,data.isGolden,data.entityID)
    if(oldData) then
        local goodsData = clone(oldData)
        goodsData:setNum(data.num)
        goodsData:setIsNew(false)

        local  name = AvalonUtil:getSubNameStr(goodsData:getName(), 140, UI.FONT_SIZE_16PX, true)
        self._itemName:setText(name)
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            self._picStar:setVisible(true)
            self._txtStar:setVisible(true)
            self._txtStar:setText(tostring(goodsData:getCombatScore()))
        else
            self._picStar:setVisible(false)
            self._txtStar:setVisible(false)
        end

        self.mGoodsGrid:setData(goodsData)
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:updateView()
    end

    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        self.mGoodsGrid:centerBottom(73)
        self._picProBG:setPosition(81,45)
    else
        self.mGoodsGrid:centerBottom(64)
        self._picProBG:setPosition(81,50)
    end

    if idx == 0 then
        self._picProBG:setVisible(true)
        self._pro:setPercentage(data.time/(PublicDefine.CONST_DEFINITION.COUNTDOWN_BAG_FULL_MS/1000) * 100)
        self._pro:runAction(cc.ProgressTo:create(data.time,0))
    else
        self._picProBG:setVisible(false)
    end

    self._picStar:leftBottom(self:getContentSize().width / 2 - (self._picStar:getContentSize().width + self._txtStar:getContentSize().width + 4)/2, 64- self._picStar:getContentSize().height / 2)
end

function BagFullCell:stopFullBagTimeOut()
    -- print("BagFullCell:stopFullBagTimeOut")
    if self._pro and (not tolua.isnull(self._pro)) then
        self._pro:stopAllActions()
    end
end

function BagFullCell:resumeFullBagTimeOut()
    -- print("BagFullCell:resumeFullBagTimeOut")
    if self._pro and (not tolua.isnull(self._pro)) then
        self._pro:stopAllActions()
    end
    if self and self.reload then
        self:reload(self.data,self.idx)
    end
end


-- 注册监听事件(可选)
function BagFullCell:registerListener()

    --进入战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.stopFullBagTimeOut)
    --退出战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.resumeFullBagTimeOut)

    --显示复活界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE, self, self.stopFullBagTimeOut)
    --复活成功
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.resumeFullBagTimeOut)

    --进入答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, self, self.stopFullBagTimeOut)
    --退出答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, self, self.resumeFullBagTimeOut)
end


-- 注销监听事件(可选)
function BagFullCell:unRegisterListener()

    --进入战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.stopFullBagTimeOut)
    --退出战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.resumeFullBagTimeOut)

    --显示复活界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE, self, self.stopFullBagTimeOut)
    --复活成功
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.resumeFullBagTimeOut)

    --进入答题
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, self, self.stopFullBagTimeOut)
    --退出答题
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, self, self.resumeFullBagTimeOut)
end