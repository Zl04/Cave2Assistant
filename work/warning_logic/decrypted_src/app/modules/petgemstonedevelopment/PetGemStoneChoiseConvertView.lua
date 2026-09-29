------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/08/02
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetGemStoneChoiseConvertView = class("PetGemStoneChoiseConvertView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_package_pets.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

UI = UI or {}

UI.PetGemStoneChoiseConvertView = PetGemStoneChoiseConvertView

function PetGemStoneChoiseConvertView:ctor(goodsDataList, callback)
    PetGemStoneChoiseConvertView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    --print("PetGemStoneChoiseConvertView--->: ",goodsDataList )
    self.goodsDataList = goodsDataList
    self.callback = callback
    self:bindModel()
    self.allGridNode = {}
    self.choseGrid = nil
end

function PetGemStoneChoiseConvertView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.petgemstonedevelopment", "PetGemStoneDevelopment", false)
    PetGemStoneChoiseConvertView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        --mvc.closePanel("BigSailPort", "BigSailPortSpeedUp")
        --self:close()
    end)
end

function PetGemStoneChoiseConvertView:dtor()
    PetGemStoneChoiseConvertView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.petgemstonedevelopment.PetGemStoneChoiseConvertView")
end


function PetGemStoneChoiseConvertView:onInitView()
    self:center(COM_WIDTH / 2, 0)
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    --contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    --mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask)


    local bg  = UI.Image:create();
    bg:init("ui_pets_equipment_paper.png");
    bg:center(0,0)
    contentLayout:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_226302, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    title:center(0, -130)
    contentLayout:addChild(title)
    
    -- 各个魂石
    for k, goodData in pairs(self.goodsDataList) do
        goodData:setIsNew(false)
        goodData:setIsLock(false)
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:setTouchEnable(true)
        self.contentLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:center(k * 200 - 300,0)
        goodGrid:showInfoArea()

        local goodGridBtn = UI.Button:create()
        goodGridBtn:init()
        goodGridBtn:closeClickScale()
        goodGridBtn:center(0,0)
        goodGridBtn:setSwallowTouches(false)
        goodGridBtn:setSize(goodGrid:getSize(), goodGrid:getSize())
        goodGridBtn:addEventListener(UIEvent.BUTTON_CLICK, goodGrid, function(goodGrid)
            self:changeChoseGrid(goodGrid)
        end)
        goodGrid:addChild(goodGridBtn)
        goodGrid:hideIcon()

        table.insert(self.allGridNode, goodGrid)
    end  

    -- 确认按钮
    local yesBtn = UI.Button:create()
    yesBtn:init("ui_btn_yellow5_1.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_1.png")
    yesBtn:closeClickScale()
    yesBtn:center(0,140)
    yesBtn:setText(UI.TEXT_1170211)
    yesBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    yesBtn:setSwallowTouches(false)
    yesBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:sendChoseGrid()
    end)
    contentLayout:addChild(yesBtn)
end

function PetGemStoneChoiseConvertView:changeChoseGrid(goodGrid)
    for k,v in pairs(self.allGridNode) do
        if v == goodGrid then
            goodGrid:showSelect()
            self.choseGrid = goodGrid
        else
            v:hideSelect()
        end
    end
end

function PetGemStoneChoiseConvertView:sendChoseGrid()
    if not self.choseGrid then
        UI.ScrollBar:createByText(UI.TEXT_226303)
        return 
    end

    -- local mGoodsData = self.choseGrid:getData()
    -- local awardsList = {}
    -- table.insert(awardsList, mGoodsData)
    -- if #awardsList > 0 then
    --     Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
    -- end

    -- 发送确认的魂石的消息
    local gridData = self.choseGrid:getData()
    local dataMessage = {}
    dataMessage.gemid = gridData:getGoodsID()
    Net.NetPetSystem:petStoneChoseRequest(dataMessage)
    --UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    -- 这个是刷新消息给消息回调用的
    --mvc.petGemStoneDevelopmentController:refreshConvertTriggerAnimation(mGoodsData)

    self:close()
end


function PetGemStoneChoiseConvertView:bindModel()

end


function PetGemStoneChoiseConvertView:unbindModel()

end





return PetGemStoneChoiseConvertView












