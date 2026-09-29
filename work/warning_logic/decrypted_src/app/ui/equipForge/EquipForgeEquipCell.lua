-- EquipForgeEquipCell.lua
-- Author:lzm
-- 2019年3月21日
-- Using:装备锻造 equip cell

UI = UI or {}

local GameDataManager = require("app.game.GameDataManager")

local EquipForgeEquipCell = class("EquipForgeEquipCell", UI.TableViewCell)
UI.EquipForgeEquipCell = EquipForgeEquipCell

local EQUIP_CELL_W = 290
local EQUIP_CELL_H = 66

function EquipForgeEquipCell:ctor()

end

function EquipForgeEquipCell:onEnter()
    EquipForgeEquipCell.super.onEnter(self);
end

function EquipForgeEquipCell:onExit()
    EquipForgeEquipCell.super.onExit(self);
end

function EquipForgeEquipCell:init(data, playUnlockEff)
    self._data = data;
    self.playUnlockEff = playUnlockEff
    self:onInitView();
end

function EquipForgeEquipCell:onInitView()
    self._cellLayout = cc.Layer:create();
    self._cellLayout:setPosition(cc.p(0,0));
    self._cellLayout:setContentSize(cc.size(EQUIP_CELL_W, EQUIP_CELL_H));
    self:addChild(self._cellLayout);

    self:initCellData();
end

function EquipForgeEquipCell:initCellData()
    local contentLayout = UI.Layout:create();
    contentLayout:init();
    contentLayout:setSize(EQUIP_CELL_W, EQUIP_CELL_H);
    contentLayout:center()
    self._cellLayout:addChild(contentLayout, 1)

    local unlockList = EquipForgeDataManager:getForgeUnlockList()
    if self.playUnlockEff or not unlockList[self._data.config.configID] then
        local lockEff = UI.Animation:create()
        lockEff:init("effect_ui_common_unlock.json", "effect_ui_common_unlock.atlas", 1);
        lockEff:leftUp(20, 18)
        if self.playUnlockEff then
            lockEff:setAnimation("unlock", false)
        else
            lockEff:setAnimation("idle", true)
        end
        self._cellLayout:addChild(lockEff, 2)
    end

    if self._data.select then
        local bg = UI.Image:create()
        bg:init("ui_deformation_information.png")
        bg:centerLeft(0)
        contentLayout:addChild(bg)
    end

    local layout1 = UI.Layout:create();
    layout1:init();
    layout1:setSize(70, EQUIP_CELL_H);
    layout1:centerLeft(0)
    contentLayout:addChild(layout1)

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:setScale(0.85)
    goodsGrid:setTouchClipNode(layout1)
    goodsGrid:center()
    local goodsData = GoodsDataManager:createLocalGoodsData(self._data.id);
    goodsData:setIsNew(false)
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(true, false)
    layout1:addChild(goodsGrid)

    local cornerShadow = UI.Image:create()
    cornerShadow:init("ui_deformation_angle.png")
    cornerShadow:rightBottom(5, 5)
    layout1:addChild(cornerShadow, 10)

    local iconFileName = "icon-equip_large_210" .. goodsData:getEquipmentType() .. "0010" .. (goodsData:getEquipmentType() == 8 and "_" .. goodsData:getWeaponType() or "") .. ".png"
    local tinyIcon = UI.Image:create()
    tinyIcon:init(iconFileName)
    tinyIcon:rightBottom(3, 2)
    layout1:addChild(tinyIcon, 11)

    local layout2 = UI.Layout:create();
    layout2:init();
    layout2:setSize(220, EQUIP_CELL_H);
    layout2:centerRight(0)
    contentLayout:addChild(layout2)

    -- new标签
    if self._data.new then
        local newIcon = UI.Image:create()
        newIcon:init("ui_information_banner_new2.png")
        -- newIcon:setImageRotation(-50)
        newIcon:rightUp(-5, -5)
        layout2:addChild(newIcon, 2)
    end

    -- 装备名字
    local name = UI.Text:create()
    name:init(goodsData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    name:centerUp(12)
    layout2:addChild(name)

    -- 等级需求
    local tipTxt = UI.Text:create()
    local playerLv = RoleDataManager:getMaster():getLevel()
    local equipLv = goodsData:getWearLV()
    -- local showLv = RoleDataManager:getUIShowLvByItemData(equipLv)
    local level, reinLv = RoleDataManager:getUIShowLvByItemData(equipLv)
    local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
    local showTxt = UI.TEXT_DES_LEVEL_NEED .. showLv
    local color = UI.FONT_COLOR_41_41_45
    if not goodsData:isAvailable(playerLv) then
        -- 穿戴等级不足
        color = UI.FONT_COLOR_80_5_5
    end
    tipTxt:init(showTxt, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, color)
    tipTxt:centerBottom(10)
    layout2:addChild(tipTxt)

    if not self._data.select then
        local splitLin = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        splitLin:setContentSize(269, 1)
        splitLin:setCapInsets(CCRectMake(20, 1, 1, 1))
        splitLin:setPosition(EQUIP_CELL_W/2, 0)
        contentLayout:addChild(splitLin, 3)
    end

    local canForge = true
    for m, matCfg in ipairs(self._data.config.material) do
        local matID = matCfg.id
        local matNum = matCfg.num
        -- 锻造天赋对材料需求量有打折效果，需要进行判断
        local percent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.ForgeDiscountRate)
        if percent > 0 then
            matNum = math.ceil(matNum * (RATIO_NUMBER - percent) / RATIO_NUMBER)
        end
        local goodsNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(matID)
        if goodsNum < matNum then
            canForge = false
            break
        end
    end

    if not canForge then
        contentLayout:setCascadeOpacityEnabled(true)
        contentLayout:setOpacity(102)
    end
end
