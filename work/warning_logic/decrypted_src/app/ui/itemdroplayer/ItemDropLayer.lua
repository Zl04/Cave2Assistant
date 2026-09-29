--[[
	宝箱掉落界面
	Create by ZihanChen-MAC on 2017-1-5 15:00
]]

UI = UI or {}
local ItemDropLayer = class("ItemDropLayer",UI.HWBtnComponent)
UI.ItemDropLayer = ItemDropLayer



-- SIZE
local MONSTER_BOX_INIT_INFO = {
  X = 0,
  Y = 0,
  WIDTH = 237,
  HEIGHT = 84
}

local ITEMDROP_RES_LIST = {
}

local ITEMDROP_RES_PNG = {
  ITEMDROP_RES_BG = "ui_info_banner_iteminfo.png",--掉落框背景图片（大）
  ITEMDROP_RES_XX = "symbol_character_hero_power.png",--掉落物品等级图标
  ITEMDROP_RES_BOX = "box_quality_0_1.png",--掉落物品框（小）
}

-- 屏幕大小
local winSize = cc.Director:getInstance():getWinSize()
-- 构造函数 必须继承
function ItemDropLayer:ctor(type)
    ItemDropLayer.super.ctor(
      self,UIType.ITEMDROPINFO, 
      ITEMDROP_RES_LIST, 
      MONSTER_BOX_INIT_INFO.WIDTH, 
      MONSTER_BOX_INIT_INFO.HEIGHT,
      true --是否同步加载
    )

    self._data = nil

    self._itemName = nil 
    self._itemBg = nil 
    self._itemIcon = nil 
    self._itemLv_Num = nil 
    self._itemDropBigBg = nil 
    self._time = nil 
end

-- 析构函数 必须继承
function ItemDropLayer:dtor()
    self._data = nil
    self._itemName = nil 
    self._itemBg = nil 
    self._itemIcon = nil 
    self._itemLv_Num = nil 
    self._itemDropBigBg = nil 
    self._time = nil 
    ItemDropLayer.super.dtor(self)
end

function ItemDropLayer:init(time,data)
  self._time = time 
  self._data = data
  ItemDropLayer.super.init(self)
end


-- onInitView 必须继承 ，只初始化视图，onUpdataView：更新数据来驱动视图显示
function ItemDropLayer:onInitView(data)
    local data = self._data
   	--背景图片
    local itemDropBigBg = UI.Image:create()
    itemDropBigBg:init(ITEMDROP_RES_PNG.ITEMDROP_RES_BG)
    itemDropBigBg:center()
    self._itemDropBigBg = itemDropBigBg
    self:addChild(itemDropBigBg)

    --掉落物品名称
    local itemName = UI.Text:create()
    itemName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    itemName:leftUp(80 + 5, 5)
    itemName:setSize(151, 40)
    itemName:setTextLeft()
    itemName:setLineSpacing(-5)
    self._itemName = itemName
    self._itemDropBigBg:addChild(itemName)

    -- 掉落物品背景框
    local itemBg =  UI.Image:create()
    itemBg:init()
    itemBg:centerLeft(5)
    self._itemBg = itemBg
    self._itemDropBigBg:addChild(itemBg) 

    -- 掉落物品ICON
    local itemIcon =  UI.Image:create()
    itemIcon:init()
    itemIcon:center()
    self._itemIcon = itemIcon
    self._itemBg:addChild(itemIcon) 

    -- 装备等级分数
    -- 装备分数图标
    local qualityIcon = UI.Image:create()
    qualityIcon:init(ITEMDROP_RES_PNG.ITEMDROP_RES_XX)
    self._itemDropBigBg:addChild(qualityIcon)
    self._qualityIcon = qualityIcon

    -- 装备分数
    local itemLv_Num = UI.Text:create()
    itemLv_Num:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    itemLv_Num:centerLeft(qualityIcon:getContentSize().width + 4)
    qualityIcon:addChild(itemLv_Num)
    self._itemLv_Num = itemLv_Num

    qualityIcon:leftBottom(85 + 151/2 -(self._qualityIcon:getContentSize().width + self._itemLv_Num:getContentSize().width + 4)/2, 24-self._qualityIcon:getContentSize().height/2, 24-qualityIcon:getContentSize().height/2)

    self._countLabel = UI.Text:create()
    self._countLabel:init(string.format("%s", 0), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    -- self._countLabel:useDefaultShadowOnlyStype()
    self._itemIcon:addChild(self._countLabel, 20)
    self._countLabel:leftBottom(14, 7)
    self._countLabel:setSize(60,25)
    self._countLabel:setTextRight()
    self._countLabel:setVisible(false)
end

function ItemDropLayer:onUpdateView(data)
    if (data) then self._data = data
    end
    data = self._data
    print("------------data.getGoodsType",data:getGoodsType(),data:getGoodsRare())
    local rare = data:getGoodsRare()
    local isEquimpmentType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    if isEquimpmentType then
      -- 混沌虫洞装备特殊处理
      if self._data.createLevel and self._data.createLevel > 0 then
          -- rare = rare + 1
            rare = self._data.randomGoodsRare + 6
          -- rare = self._data.randomGoodsRare + 6
      end
  end
    -- 掉落物品背景图片
    self._itemBg:setSpriteName(string.format("box_quality_%s_%s.png",data:getGoodsGroupType(), rare))
    if(data:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or data:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
      --掉落物品装备等级图标 星星
      self._qualityIcon:setVisible(true)
      -- 装备等级分数
      local scroe = data:getCombatScore()
      self._itemLv_Num:setText(string.format("%s", scroe))

      self._qualityIcon:leftBottom(85 + 151/2 -(self._qualityIcon:getContentSize().width + self._itemLv_Num:getContentSize().width + 4)/2, 24-self._qualityIcon:getContentSize().height/2)
    else 
        self._qualityIcon:setVisible(false)
    end
    --掉落物品名称
    -- self._itemName:setText(string.format("%s", data:getName()))
    local name = AvalonUtil:getSubNameStr(data:getName(), 120, 18, true)
    self._countLabel:setVisible(false)

    if data:getNum() > 1 then
        if data:getNum() > 1000000 then
          self._countLabel:setText(string.format("%s", AvalonUtil:getSimpleNumber(data:getNum(),4)))
        else
          self._countLabel:setText(string.format("%d", data:getNum()))
        end
        self._countLabel:setVisible(true)
    elseif data:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
        if data:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemCoin or data:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond then
            self._countLabel:setText(string.format("%d", data:getNum()))
            self._countLabel:setVisible(true)
        end
    end
    self._itemName:setText(name)
    self._itemName:autoAdapt()
    self._itemIcon:setSpriteName(string.format("%s",data:getIconName()))
    self:onShowItem()
end
function ItemDropLayer:onShowItem() 
  -- local data = self._data
  self._itemDropBigBg:setPosition(220, 0)
  -- local time = 0
  print("---延迟时间---",self._time )

  self._itemDropBigBg:runAction(
    cc.Sequence:create(
      cc.DelayTime:create(self._time/2 ),
      cc.MoveTo:create(0.2, cc.p(0, 0)),
      cc.DelayTime:create(1),
      cc.MoveTo:create(0.2, cc.p(220, 0)),
      cc.CallFunc:create(function()
         self:removeSelf()
      end)
    ))
end 

