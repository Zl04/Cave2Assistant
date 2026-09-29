-- GoldPointingLayer.lua
-- Author:ODEI
-- 2017年6月7日
-- Using:点金 

require "app.ui.shoplayer.BagGoodsPanel"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local GoldPointingLayer = class("GoldPointingLayer", UI.DoorWin)
UI.GoldPointingLayer = GoldPointingLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local leftLayerWidth = 388
local leftLayerHeight = 620

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_gaming_goldpointing.plist",
}


--构造函数(必备)
function GoldPointingLayer:ctor(spriteID)
    --窗口大小
    GoldPointingLayer.super.ctor(
    self,UIType.GOLD_POINTING_LAYER,
    COM_RES_LIST,
    leftLayerWidth,    
    winSize.height
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mGoodsData = nil;          --装备
    self.mGoodsGrid = nil;          --装备框

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();

    self.mCanGoldPointing = true;       --是否能点金
end

--虚构函数,destroy时调用(必备)
function GoldPointingLayer:dtor()
    GoldPointingLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function GoldPointingLayer:init()
    GoldPointingLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function GoldPointingLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)

    self.leftLayer = UI.Component:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftLayerWidth, leftLayerHeight)
    self.leftLayer:centerLeft(0)
    self.rootLayer:addChild(self.leftLayer)

    --在这里填写界面
    self.picBg = UI.Image:create()
    self.picBg:init("ui_goldpointing_bg.png")
    self.picBg:leftBottom(0, 0)
    self.leftLayer:addChild(self.picBg)

    --点金btn
    self.mBtnGoldPointing = UI.Button:create()
    self.mBtnGoldPointing:init("ui_btn_stone2_0.png", "ui_btn_stone2_1.png", "ui_btn_stone2_2.png")
    self.mBtnGoldPointing:leftUp(99, 501)
    self.mBtnGoldPointing:addEventListener(UIEvent.BUTTON_CLICK,self,self.onGoldPointing)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnGoldPointing)
    self.picBg:addChild(self.mBtnGoldPointing)
    self.mBtnGoldPointing:disable()

    self.mTxtGoldPointing = UI.Text:create()
    self.mTxtGoldPointing:init(UI.TEXT_110202, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    self.mTxtGoldPointing:center(2, 0)
    self.mTxtGoldPointing:setFontColor(UI.FONT_COLOR_182_201_201)
    self.mBtnGoldPointing:addChild(self.mTxtGoldPointing, 100)


    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))

    self.mGoodsGrid:showInfoArea()

   
    self:createAttLayer();
    self:createSpineNode();

    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0  --"all"
    _usedType1.rare = 3
    table.insert(usedTypeList,_usedType1)

    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType2.type = PublicDefine.MATERIAL_TYPE.MaterialEnchanting
    _usedType2.rare = 3
    table.insert(usedTypeList,_usedType2)

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
        }
    )

    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList,2)
    self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
    local bagListW,bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW,280 - bagListH/2)
    
    self.statueSpine:addEventListener(UIEvent.ANIMATION_END, self, self.spineGoldPointingCallback)

    self.statueSpine:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "audio_action" then
                Avalon.AudioManager:playSound("1517")
            elseif event.eventData.name == "audio_prepare" then
                Avalon.AudioManager:playSound("1515")
            end
        end
    end)

    self:setDoorNode(self.leftLayer, bagList)

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111017))
end

function GoldPointingLayer:createAttLayer()
     --属性1
    self.mPropertyBg1 = UI.Component:create()
    self.mPropertyBg1:init()
    self.mPropertyBg1:setSize(181, 41);
    self.mPropertyBg1:leftUp(110, 368)
    self.picBg:addChild(self.mPropertyBg1, 10)
    self.mPropertyBg1:hide()

    local txtProperty1 = UI.Text:create()
    txtProperty1:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX,UI.FONT_COLOR_155_155_155)
    txtProperty1:center()
    txtProperty1:setName("TEXT_PROPERTY")
    self.mPropertyBg1:addChild(txtProperty1,100)

    --属性2
    self.mPropertyBg2 = UI.Component:create()
    self.mPropertyBg2:init()
    self.mPropertyBg2:setSize(181, 41)
    self.mPropertyBg2:leftUp(110, 419)
    self.picBg:addChild(self.mPropertyBg2, 10)
    self.mPropertyBg2:hide()

    local txtProperty2 = UI.Text:create()
    txtProperty2:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    txtProperty2:center()
    txtProperty2:setName("TEXT_PROPERTY")
    self.mPropertyBg2:addChild(txtProperty2,100)
end

function GoldPointingLayer:resetGoodsGridPos()
    self.mGoodsGrid:center()
end

function GoldPointingLayer:createSpineNode()

    local xPos = 202
    local yPos = 203
    self.circleSpine1 = UI.Animation:create()
    self.circleSpine1:init("effect_ui_gaming_goldpointing_circle.json", "effect_ui_gaming_goldpointing_circle.atlas", 1);
    self.circleSpine1:leftUp(xPos, yPos)

    self.circleSpine2 = UI.Animation:create()
    self.circleSpine2:init("effect_ui_gaming_goldpointing_circle.json", "effect_ui_gaming_goldpointing_circle.atlas", 1);
    self.circleSpine2:leftUp(xPos, yPos)

    self.circleSpine3 = UI.Animation:create()
    self.circleSpine3:init("effect_ui_gaming_goldpointing_circle.json", "effect_ui_gaming_goldpointing_circle.atlas", 1);
    self.circleSpine3:leftUp(xPos, yPos)

    self.picBg:addChild(self.circleSpine3)
    self.picBg:addChild(self.circleSpine2)
    self.picBg:addChild(self.circleSpine1)

    xPos = 202
    yPos = 203
    self.iconSpine1 = UI.Animation:create()
    self.iconSpine1:init("effect_ui_gaming_goldpointing_icon.json", "effect_ui_gaming_goldpointing_icon.atlas", 1);
    self.iconSpine1:leftUp(xPos, yPos)
    self.picBg:addChild(self.iconSpine1)
    self:resetGoodsGridPos();
    self.iconSpine1:addChild(self.mGoodsGrid, 101)


    self.iconSpine2 = UI.Animation:create()
    self.iconSpine2:init("effect_ui_gaming_goldpointing_icon.json", "effect_ui_gaming_goldpointing_icon.atlas", 1);
    self.iconSpine2:leftUp(xPos, yPos)
    self.picBg:addChild(self.iconSpine2)

    xPos = 201
    yPos = 150
    self.statueSpine = UI.Animation:create()
    self.statueSpine:init("effect_ui_gaming_goldpointing_statue.json", "effect_ui_gaming_goldpointing_statue.atlas", 1);
    self.statueSpine:leftUp(xPos, yPos)
    self.picBg:addChild(self.statueSpine)
    
    self:resetSpineAnimation()
end

function GoldPointingLayer:resetSpineAnimation()
    self.statueSpine:removeEventListener(UIEvent.ANIMATION_END, self, self.spineGoldPointingCallback)
    self.circleSpine1:setAnimation("circle1", true)
    self.circleSpine2:setAnimation("circle2", true)
    self.circleSpine3:setAnimation("circle3", true)
    self.iconSpine1:setAnimation("begin", true)
    self.iconSpine2:hide()
    self.statueSpine:setAnimation("begin", true)
    self.mTxtGoldPointing:setFontColor(UI.FONT_COLOR_182_201_201)
end

function GoldPointingLayer:runReadyAnimtion(dragOut)
   
    self.iconSpine2:show()
    if dragOut then
        self.statueSpine:setAnimation("putin3", false)
        self.iconSpine2:setAnimation("putin2_up", false)
        self.circleSpine1:setAnimation("putin3_circle1", false)
    else
        self.statueSpine:setAnimation("ready1", false)
        self.iconSpine1:setAnimation("ready1", false)
        self.circleSpine1:setAnimation("circle1", true)
    end
    self.mTxtGoldPointing:setFontColor(UI.FONT_COLOR_182_201_201)
end

function GoldPointingLayer:runCancelReadyAnimtion()
    self.circleSpine1:setAnimation("circle1", true)
    self.iconSpine1:setAnimation("ready3", false)
    self.iconSpine2:hide()
    self.statueSpine:setAnimation("ready3", false)
end

function GoldPointingLayer:runPutAnimtion()
    self.circleSpine1:setAnimation("putin1_circle1", false)
    self.iconSpine1:setAnimation("putin1_down", false)
    self.iconSpine2:setAnimation("putin1_up", false)
    self.iconSpine2:show()
    self.statueSpine:setAnimation("putin1", false)
    self.mTxtGoldPointing:setFontColor(UI.FONT_COLOR_220_182_80)
end

function GoldPointingLayer:runExcuteAnimtion()
    self.circleSpine1:setAnimation("goldpoint_circle1", false)
    self.iconSpine1:setAnimation("goldpoint_down", false)
    self.iconSpine2:setAnimation("goldpoint_up", false)
    self.iconSpine2:show()
    self.statueSpine:setAnimation("goldppoint", false)
end

function GoldPointingLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    self:runReadyAnimtion()

    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true) 
    end
end

function GoldPointingLayer:bagDragMovedCallback(grid, touchPosition)
end

function GoldPointingLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if not isInBag then
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if freePacketNum <= 0 then
            UI.ScrollBar:createByTextID(1110793)
            self:runCancelReadyAnimtion()
        else
            local goodsData = grid:getData()

            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end
            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            self._bagGridList:refreshView()
            self:refreshGoodsGrid()

            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110422))
            self:runPutAnimtion();
        end
    else
        self:runCancelReadyAnimtion()
    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false) 
    end
end 


-- 模版函数：更新组建的视图(必备)
function GoldPointingLayer:onUpdateView()

end

--刷新点金材料
function GoldPointingLayer:refreshGoodsGrid(showRed)
    if self.mGoodsGrid then
        if self.mGoodsData then
            self.mGoodsGrid:setData(self.mGoodsData)
            self.mGoodsGrid:updateView()
            self.mGoodsGrid:show()
            self:resetGoodsGridPos();
            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()

            self.mPropertyBg1:hide()
            self.mPropertyBg2:hide()

            if self.mGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                local randomArr = self.mGoodsData:getDetailDescription().randomArr
                for i = 1,#randomArr do
                    if i == 1 then
                        self.mPropertyBg1:show()
                        self.mPropertyBg1:getChildByName("TEXT_PROPERTY"):setText(randomArr[i][1]..randomArr[i][2])
                    else
                        self.mPropertyBg2:show()
                        self.mPropertyBg2:getChildByName("TEXT_PROPERTY"):setText(randomArr[i][1]..randomArr[i][2])
                    end
                end
                if showRed then                    
                    if #randomArr == 1 then
                        self._newSprite = AvalonUtil.createRedPoint(self.mPropertyBg1, 0, 0, zorder)
                    else
                        self._newSprite = AvalonUtil.createRedPoint(self.mPropertyBg2, 0, 0, zorder)
                    end     
                end
            end
            if self.mCanGoldPointing then 
                local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.NPC_GOLDEN)
                if(repeatData) then
                    self.mBtnGoldPointing:disable()
                else 
                    self.mBtnGoldPointing:enable()
                end
            else
                self.mBtnGoldPointing:disable()
            end
        else
            self.mBtnGoldPointing:disable()
            self.mGoodsGrid:hide()
            self.mPropertyBg1:hide()
            self.mPropertyBg2:hide()
        end
    end
end



function GoldPointingLayer:onTouchBeganByGoodsGrid(grid)
    if self.mCanGoldPointing == false then
        return false
    end

    self:runReadyAnimtion(true)

    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true) 
    end
    return true
end

function GoldPointingLayer:onTouchEndedByGoodsGrid(grid, inSide)

    if inSide then
        self:runPutAnimtion()
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        self.mGoodsData._changeNum = 0

        self.mGoodsData = nil
        self:refreshGoodsGrid()
        self._bagGridList:refreshView()
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111017))
        self:runCancelReadyAnimtion()
    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false) 
    end
end

--点金
function GoldPointingLayer:onGoldPointing()
    if self.mCanGoldPointing == false or self.mGoodsData == nil then
        return
    end

    local triggerNpc = GameDataManager:getInstance():getNPCData(self.spriteID)
    if triggerNpc == nil or triggerNpc:getIsOpen() then
        UI.ScrollBar:createByText(UI.TEXT_1150022)
        self.mCanGoldPointing = false
        self._bagGridList:updateCanDrag(false)
        self.mBtnGoldPointing:disable()
        return
    end

    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum <= 0 then
        UI.ScrollBar:createByTextID(1110793)
        return
    end
    self.mBtnGoldPointing:disable()
    if self.mGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
    else
        self.mGoodsData._changeNum = 0
    end

    if RoleBehaviorManager:goldPointNpcCheck() then
        printWarn("been blocked when using goldPoint npc function!")
        return
    end

    Net.NetNPCSystem:sendGoldPointing(self.mGoodsData,self.spriteID)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    MasterDataManager:setRepeatHandleData(RepeatHandleType.NPC_GOLDEN, true)

    self.mCanGoldPointing = false
    self._bagGridList:updateCanDrag(false)
end

--点金特效事件
function GoldPointingLayer:spineGoldPointingCallback(event,obj)
    if event.animation == "goldppoint" then
        if self.mGoodsData then
            local _goodsData;
            if self.mGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                _goodsData = self._bagGridList:getGoodsData(self.mGoodsData:getType(), self.mGoodsData:getEntityID(), self.mGoodsData:getIsGolden())
            else
                _goodsData = self._bagGridList:getGoodsData(self.mGoodsData:getType(), self.mGoodsData:getGoodsID(), true)
            end
            if _goodsData ~= nil then
                _goodsData._changeNum = -1
                self.mGoodsData = _goodsData;
                self:refreshGoodsGrid(true)
                self.mBtnGoldPointing:disable()
                self._bagGridList:refreshView()
            end

            local delayCallbackfunc = cc.CallFunc:create(function()
                    self:resetSpineAnimation()
                end
            )
            local delayAction = cc.DelayTime:create(0.01)
            self:runAction(cc.Sequence:create(delayAction, delayCallbackfunc))
        end
        GameManager:hideNPCInfomation(self.spriteID)
    end
end

--点金网络回调
function GoldPointingLayer:goldPointingCallBack(data)
    UI.WaitingLayer:hideWaiting()
    if data.result == "GoldTouchResultType_Succeed" then
        self:runExcuteAnimtion()
    else
        local ProtobufUtil = require "utils.ProtobufUtil"
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.GoldTouchResultType",data.result))
        self.mCanGoldPointing = true
        self._bagGridList:updateCanDrag(true)
    end
end

-- 注册监听事件(可选)
function GoldPointingLayer:registerListener()
    --监听窗口外关闭事件
    --点金结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GOLD_POINTING, self, self.goldPointingCallBack)
end


-- 注销监听事件(可选)
function GoldPointingLayer:unRegisterListener()
    --点金结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GOLD_POINTING, self, self.goldPointingCallBack)
end




