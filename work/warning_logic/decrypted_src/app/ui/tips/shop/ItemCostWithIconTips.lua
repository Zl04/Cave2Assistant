--[[
    AUTHOR:junhao.deng
    2021-11-18
    USING: 材料消耗TIPS
]]

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local ItemCostWithIconTips = class("ItemCostWithIconTips", UI.ConfirmDialog)
UI.ItemCostWithIconTips = ItemCostWithIconTips

function ItemCostWithIconTips:ctor(addToTopLayer)
    ItemCostWithIconTips.super.ctor(self)
    self._addToTopLayer = addToTopLayer
    self:registerListener()
end

--  析构函数 调用父类的方法
function ItemCostWithIconTips:dtor()
    ItemCostWithIconTips.super.dtor(self)
end

--  初始化函数
function ItemCostWithIconTips:init(itemDatas, callback)
    self._itemDatas = itemDatas
    self._callBack = callback
    ItemCostWithIconTips.super.init(self, nil, nil, nil, nil, 5)
end

--  初始化界面函数
function ItemCostWithIconTips:onInitView()
    ItemCostWithIconTips.super.onInitView(self)
    self:changeBg()
    local GameDataManager = require("app.game.GameDataManager")
    self.text = UI.TEXT_221006
    self.ConfirmDialogModel.contentLabel:setText(self.text);
    self.ConfirmDialogModel.contentLabel:centerUp(17)
    local pk = RoleDataManager:getMaster():getPK()
    local textH = self.ConfirmDialogModel.contentLabel:getContentSize().height - 4
    for k, v in pairs(self._itemDatas.materialata) do
        local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, v.ID)
        if v.ID == 23030001 then
            itemTotalNum = GameDataManager:getInstance():getDiamond()
        end
        local itemNum = tonumber(itemTotalNum)

        local str = string.format(UI.TEXT_221007, v.num, itemNum)
        local titleText_1 = UI.Text:create()
        if tonumber(v.num) < itemNum then
            titleText_1:init(str,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        else
            titleText_1:init(str,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_RED)
        end
        
        titleText_1:centerUp(textH+k*25)
        self.ConfirmDialogModel.contentBg:addChild(titleText_1, 10)
            
        local crystal_Icon = UI.Image:create()
        crystal_Icon:init(v.miniIcon)
        crystal_Icon:leftUp(self.ConfirmDialogModel.contentBg:getContentSize().width / 2 - titleText_1:getContentSize().width / 2 - crystal_Icon:getContentSize().width, textH+k*25)
        self.ConfirmDialogModel.contentBg:addChild(crystal_Icon, 10)

        
    end
    self:showDiamonCost(self._itemDatas.crystal, false, true)
    self:addCostItemBtn(self._itemDatas.requireItemData, true)
end


-- 更新视图
function ItemCostWithIconTips:onUpdateView()

end

function ItemCostWithIconTips:changeBg()
    self.ConfirmDialogModel.ConfirmDialog:setSpriteName("ui_setup_banner_box3_2.png")
end

function ItemCostWithIconTips:addCostItemBtn(itemData, isShowSelect)
    local costPanel =  UI.Layout:create()
    costPanel:init()

    local width = 0
    local costLabel = UI.Text:create()
    costLabel:init(UI.TEXT_1170025, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    width = width + costLabel:getContentSize().width

    local iconName = itemData.itemData.miniIcon
    local useItemIcon = UI.Image:create()
    useItemIcon:init(iconName)
    width = width + useItemIcon:getContentSize().width

    local costLabelNum = UI.Text:create()
    costLabelNum:init(itemData.itemNum.."", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    width = width + useItemIcon:getContentSize().width
    costPanel:setSize(width + 20, 30)

    costPanel:addChild(costLabel)
    costLabel:centerLeft(0)

    costPanel:addChild(useItemIcon)
    useItemIcon:centerLeft(costLabel:getContentSize().width + 10)

    costPanel:addChild(costLabelNum)
    costLabelNum:centerLeft(costLabel:getContentSize().width + useItemIcon:getContentSize().width + 20)
    costPanel:centerBottom(39)

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    okButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    okButton:setText(UI.TEXT_221021)
    okButton._clickScale = false
    okButton:centerBottom(0)
    self.ConfirmDialogModel.root:addChild(okButton)
    okButton:setName("okButton")
    okButton:setScale(0.8)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onExtBtnClick)

    self.ConfirmDialogModel.root:addChild(costPanel, 10)
end

function ItemCostWithIconTips:onExtBtnClick()
    if self.extendCallback then
        self:extendCallback()
    end

    if self.closeDialog then
        self:closeDialog()
    end
end

-- 注册监听事件(可选)
function ItemCostWithIconTips:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

-- 点击外部区域的处理器(关闭)(可选)
function ItemCostWithIconTips:onTouchOutSizeEvent()
    self:close()
end

-- 传递回调函数名字
function ItemCostWithIconTips:callfunName(okCallFun,cancelCallFun, extendCallback)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
    self.extendCallback = extendCallback
end

function ItemCostWithIconTips:ok()
    -- self._callBack()
    ItemCostWithIconTips.super.ok(self)
end


