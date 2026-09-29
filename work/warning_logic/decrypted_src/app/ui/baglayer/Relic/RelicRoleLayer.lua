-- RelicRoleLayer.lua
-- by:hongyi.yan
-- time:2020.09.06
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local RelicRoleLayer = class("RelicRoleLayer", UI.HWBtnComponent)
UI.RelicRoleLayer = RelicRoleLayer

-- 关卡选择资源
local COM_RES_LIST = {}

local COM_WIDTH = 400
local COM_HEIGHT = 550
local LAYER_WIDTH = 410
local LAYER_HEIGHT = 410

local EQUIP_POS_INFO = {
    [1] = {
        posX = 1.5,
        posY = -155.5,
    },
    [2] = {
        posX = 150.5,
        posY = -47.5,
    },
    [3] = {
        posX = 94.5,
        posY = 127.5,
    },
    [4] = {
        posX = -89.5,
        posY = 127.5,
    },
    [5] = {
        posX = -147.5,
        posY = -47.5,
    },
}

local RESOURCE_ID_LIST = {
    22070600,   -- 时序之尘
    22070610,   -- 时序精华
    23020001,   -- 金币
}

function RelicRoleLayer:ctor()
    RelicRoleLayer.super.ctor(
    self,
    UIType.RELIC_ROLE_LAYER,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )

    -- 获取装备栏的遗物数据列表
    self.relicData = RelicDataManager:getRelicEqiupDataWithIndexOrder()
    -- 装备栏遗物物品GoodGrid列表
    self.equipsGrid = {}
    -- 装备栏格子列表（附着点击动效框和点击响应区,强化结果动效）
    self.ResponseRegion = {}
    -- 遗物等级框列表，便于刷新修改
    self.levelBgList = {}
    -- 当前选中的装备栏index
    self.selectEquipIndex = nil

    self:registerListener()
end

function RelicRoleLayer:dtor()
    RelicRoleLayer.super.dtor(self)

    self.equipsGrid = {}
    self.ResponseRegion = {}
    self.levelBgList = {}
    self.selectEquipIndex = nil

    self:unRegisterListener()

    reload_script_file("app.ui.baglayer.Relic.RelicRoleLayer")
end
-- 注册监听事件(可选)
function RelicRoleLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RELIC_EQUIP_SLOTDRAG, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateRelicSlot)
    Avalon.MessageCenter:bind(AvalonMessage.MC_RELIC_STRENGTH_RESULT, self, self.showStrengthResult)
end

-- 注销监听事件(可选)
function RelicRoleLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RELIC_EQUIP_SLOTDRAG, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateRelicSlot)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RELIC_STRENGTH_RESULT, self, self.showStrengthResult)
end


-- 初始化视图
function RelicRoleLayer:onInitView()
    -- self:enableDebugDraw()
    local heroData = GameDataManager:getInstance():getMaster()

    local bgImg = UI.Image:create()
    bgImg:init("ui_relic_bg.png")
    bgImg:center(0, 2)
    self:addChild(bgImg)

        --head
    local headBg = UI.Image:create()
    headBg:init("ui_playerstate_me_black_up.png")
    headBg:center(2, -30)
    self:addChild(headBg)

    -- 添加蒙版效果
    local headCap = UI.Image:create()
    headCap:init("ui_playerstate_me_black_01.png")
    headCap:center()
    headBg:addChild(headCap, 3)

    -- 等级背景图
    local gradeBg = UI.Image:create()
    gradeBg:init("ui_playerstate_me_grade.png")
    gradeBg:leftBottom(-10,-4)
    headBg:addChild(gradeBg, 100)

    -- 等级
    local lvLabel = UI.Text:create()
    lvLabel:init(heroData:getUIShowLv().."",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_187_167_136)
    lvLabel:setSize(100, 50)
    lvLabel:center()
    lvLabel:setTextCenter()
    gradeBg:addChild(lvLabel,101)

    local nameBg = UI.Image:create()
    nameBg:init("ui_starpray_playerstate_bar.png")
    nameBg:center(2, 26)
    self:addChild(nameBg)

    -- 角色名字
    local roleName = UI.Text:create()
    roleName:init(heroData:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_16PX,UI.FONT_COLOR_51_51_51)
    roleName:setSize(150, 24)
    roleName:setTextHorizontalCenter()
    roleName:centerBottom(10)
    nameBg:addChild(roleName, 101)

    -- 武器类型
    local equipmentType = UI.Image:create()
    equipmentType:init("icon-equip_small1_21080010_1.png")
    equipmentType:leftUp(58, 0)
    headBg:addChild(equipmentType, 200)
    self.equipmentType = equipmentType

    local equipType = GameDataManager:getInstance():getWearWeaponTypeForSpriteID(heroData.spriteID)
    if equipType == 0 then
        equipmentType:hide()
    else
        equipmentType:show()
        equipmentType:setSpriteName("icon-equip_small1_21080010_"..equipType..".png")
    end

    local rootLayer = UI.Layout:create()
	rootLayer:init()
    rootLayer:setSize(LAYER_WIDTH, LAYER_HEIGHT)
    -- rootLayer:enableDebugDraw()
	rootLayer:center(0, -30)
	self:addChild(rootLayer, 10)
	self.rootLayer = rootLayer

    -- 加载装备栏
    self:initRelicSlot()

    Avalon.WidgetUtil:getHead(self, heroData, heroData.wearEquipmentArr,self, handler(self,function(self,pic)
        if headBg and not tolua.isnull(headBg) then
            pic:setPosition(40, 38)
            headBg:addChild(pic, 2)
        end
    end))

    -- 强化成功概率
    local strengthPercent = UI.Text:create()
    strengthPercent:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX,UI.FONT_COLOR_18_191_42)
    strengthPercent:centerBottom(56)
    self:addChild(strengthPercent)
    self.strengthPercent = strengthPercent

    -- 强化提示按钮
    local promptButton = UI.Button:create()
    promptButton:init('ui_btn_yellow12_0.png', 'ui_btn_yellow12_1.png', 'ui_btn_yellow12_2.png')
    promptButton:centerBottom(10)
    promptButton:setText(UI.TEXT_110207)
    promptButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    promptButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1324451)
        return
    end)
    self:addChild(promptButton)
    self.promptButton = promptButton

    -- 强化按钮
    local executeButton = UI.Button:create()
    executeButton:init('ui_btn_mosaic2_0.png', 'ui_btn_mosaic2_1.png', 'ui_btn_mosaic2_2.png')
    executeButton:centerBottom(10)
    executeButton:hide()
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickIntensify)
    self:addChild(executeButton)
    self.executeButton = executeButton

    -- 刷新数据
    self:updateRelicSlot()
end

function RelicRoleLayer:initRelicSlot()
    for k, v in ipairs(EQUIP_POS_INFO) do
        local node = self:createOneRelicSlot(k)
        node:center(v.posX, v.posY)
        self.rootLayer:addChild(node)
    end
end

function RelicRoleLayer:createOneRelicSlot(index)
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(81, 81)
    self.ResponseRegion[index] = bg

    local gridBg = UI.Layout:create()
    gridBg:init()
    gridBg:setSize(74, 74)
    gridBg:center()
    gridBg:setName("gridBg")
    gridBg:setTouchEnable(true)
    gridBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        -- 没有装备遗物的格子不会存在选中状态
        if not self.relicData[index] then
            return
        end

        self.selectEquipIndex = index
        self:showRoleEquipIndexAni(index)

        self:updateStrengthCost()
    end)
    bg:addChild(gridBg)

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init()
    goodsGrid:hide()
    goodsGrid:hideCountLabel()
    goodsGrid:hideNewIcon()
    goodsGrid:showInfoArea()
    goodsGrid:hideAllAnimation()
    goodsGrid:hideBG()
    goodsGrid:hideRare()
    goodsGrid:setDragOutAreaJudgeNode(goodsGrid)
    goodsGrid:setTouchEnable(true)
    goodsGrid:setSwallowTouches(false)
    goodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    goodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    goodsGrid:center()
    goodsGrid.index = index
    gridBg:addChild(goodsGrid)
    self.equipsGrid[index] = goodsGrid

    -- 等级
    local levelBg = UI.Image:create()
    levelBg:init("ui_relic_level_box.png")
    levelBg:rightUp(-8,0)
    bg:addChild(levelBg, 10)
    levelBg:hide()
    self.levelBgList[index] = levelBg

    local levelNum = UI.Text:create()
    levelNum:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX,UI.FONT_COLOR_255_255_255)
    levelNum:center(0,-2)
    levelNum:setName("levelNum")
    levelBg:addChild(levelNum)

    return bg
end

function RelicRoleLayer:clickIntensify()
    -- 未选择装备
    if not self.selectEquipIndex then
        UI.ScrollBar:createByText(UI.TEXT_1324451)
        return
    end

    -- 不在城镇或公会中
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    local relicData = self.relicData[self.selectEquipIndex]
    local strengthConfig = ConfigManager:getRelicLevelConfigByID(relicData:getLevel())

    if relicData and relicData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_1324459)
        return
    end

    -- 强化次数已达上限
    if relicData:isMaxLevelCnt() then
        UI.ScrollBar:createByText(UI.TEXT_1324455)
        return
    end

    -- 强化已达上限
    if relicData:isMaxLevel() then
        UI.ScrollBar:createByText(UI.TEXT_1324456)
        return
    end

    -- 消耗品足够
    if self.costGoods then
        local isNotEnoughGoodId = nil
        local pk = RoleDataManager:getMaster():getPK()
        for k,v in pairs(self.costGoods) do
            local num = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, k)
            if k == RESOURCE_ID_LIST[3] then
                num = GameDataManager:getCurCoin()
            else
                local MaterialData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(
                    pk,
                    PublicDefine.PACKET_TYPE.PACKET_BAG,
                    GoodsDataManager:getGoodsTypeForGoodsID(k),
                    k,
                    false
                )

                if MaterialData and MaterialData:getIsLock() then
                    UI.ScrollBar:createByText(UI.TEXT_1212614)
                    return
                end
            end

            if num < v then
                isNotEnoughGoodId = k
                break
            end
        end

        if isNotEnoughGoodId then
            local goodData = GoodsDataManager:createLocalGoodsData(isNotEnoughGoodId)
            UI.ScrollBar:createByText(string.format(UI.TEXT_1324457, goodData:getName()))
            return
        end
    end

    mvc.openPanel("Relic", "RelicIntensify", relicData)

    -- local cardTips =
    --     UI.ConfirmDialog.show(
    --     "",
    --     function()
    --         RelicDataManager:reqRelicStrength(relicData)
    --     end,
    --     function()
    --     end
    -- )

    -- local prompt = UI.Text:create()
    -- prompt:init(UI.TEXT_1324452, UI.FONT_STANDARD, UI.FONT_SIZE_20PX,UI.FONT_COLOR_51_51_51)
    -- prompt:setSize(350, 50)
    -- prompt:setTextCenter()
    -- prompt:centerUp(10)
    -- cardTips.ConfirmDialogModel.contentBg:addChild(prompt)

    -- local des = UI.Text:create()
    -- des:init(string.format(UI.TEXT_1324453, strengthConfig.successRate), UI.FONT_STANDARD, UI.FONT_SIZE_18PX,UI.FONT_COLOR_51_51_51)
    -- des:setSize(350, 50)
    -- des:setTextCenter()
    -- des:centerUp(62)
    -- cardTips.ConfirmDialogModel.contentBg:addChild(des)
end

function RelicRoleLayer:onTouchBeganByGoodsGrid(grid, inside, touchPosition)
    if not grid then
        return false
    end
    if self._isDraging then
        return false
    end

    self._isDraging = true

    local relicEquipIndex = grid:getData():getRelicType()
    self.levelBgList[relicEquipIndex]:hide()

    return true
end

function RelicRoleLayer:onTouchEndedByGoodsGrid(grid, inside, touchPosition)
    if not grid then
        return
    end
    if not self._isDraging then
        return
    end
    self._isDraging = false

    local relicEquipIndex = grid:getData():getRelicType()
    self.levelBgList[relicEquipIndex]:show()

    Avalon.MessageCenter:notice(GameMessage.MC_RELIC_BAG_SLOTDRAG, grid, touchPosition, false)
end

function RelicRoleLayer:setRelicData(relicData)
    self.relicData = relicData
    for k, grid in pairs(self.equipsGrid) do
        if self.relicData[k] then
            grid:setData(self.relicData[k])
            grid:updateView()
            grid:show()
            grid:hideNewIcon()
            grid._gemLevelText:hide()
            self.levelBgList[k]:show()
            self.levelBgList[k]:getChildByName("levelNum"):setText(UI.TEXT_110040..self.relicData[k]:getLevel())
        else
            grid:hide()
            grid:reset()
            self.levelBgList[k]:hide()
        end
    end
end

function RelicRoleLayer:updateRelicSlot()
    local relicData = RelicDataManager:getRelicEqiupDataWithIndexOrder()
    self:setRelicData(relicData)

    -- 判断选中
    if not self.selectEquipIndex or not self.relicData[self.selectEquipIndex] then
        self.selectEquipIndex = nil
    end

    self:updateStrengthCost()
end

function RelicRoleLayer:slotDragEnd(grid, touchPosition)
    if not grid then
        return
    end

    local type = grid:getData():getRelicType()

    -- 不在城镇或公会中
    if not (SceneManager:getInstance():isNotInFightScene()) then
        UI.ScrollBar:createByText(UI.TEXT_1213665)
        return
    end

    -- 装备栏已存在遗物
    if self.relicData[type] then
        UI.ScrollBar:createByText(UI.TEXT_1324454)
        return
    end

    self:showRoleEquipIndexAni(self.selectEquipIndex)

    local pos = self.rootLayer:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self.rootLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        self:addRelicEquip(grid:getData():getEntityID())
    end
end

function RelicRoleLayer:addRelicEquip(entityID)
    if not entityID then
        return
    end

    UI.WaitingLayer:showWaiting(true, nil, 5)
    Net.NetGoodsSystem:requestRelicWear(entityID, true)
end

function RelicRoleLayer:updateStrengthCost()

    if self.selectEquipIndex then

        self.costGoods = {}
        local relicData = self.relicData[self.selectEquipIndex]
        local strengthConfig = ConfigManager:getRelicLevelConfigByID(relicData:getLevel())

        local costList = string.split(strengthConfig.materialRequest, ";")

        local goldInfo = string.split(costList[2], ",")
        local goldData = GoodsDataManager:createLocalGoodsData(tonumber(goldInfo[1]))
        self.costGoods[tonumber(goldInfo[1])] = tonumber(goldInfo[2])

        local specialInfo = string.split(costList[1], ",")
        local specialData = GoodsDataManager:createLocalGoodsData(tonumber(specialInfo[1]))
        self.costGoods[tonumber(specialInfo[1])] = tonumber(specialInfo[2])

        -- 消耗显示
        if not self.buttonLayer then
            local buttonLayer = UI.Layout:create()
            buttonLayer:init()
            buttonLayer:setSize(244, 50)
            buttonLayer:center()
            self.executeButton:addChild(buttonLayer, 10)
            self.buttonLayer = buttonLayer

            local goldImg = UI.Image:create()
            goldImg:init(goldData:getSmallIconName())
            goldImg:centerLeft(38)
            self.buttonLayer:addChild(goldImg)
            self.goldImg = goldImg

            local goldText = UI.Text:create()
            goldText:init("x"..goldInfo[2], UI.FONT_STANDARD, UI.FONT_SIZE_20PX,UI.FONT_COLOR_51_51_51)
            goldText:centerLeft(38 + goldImg:getContentSize().width + 2)
            self.buttonLayer:addChild(goldText)
            self.goldText = goldText

            local specialImg = UI.Image:create()
            specialImg:init(specialData:getSmallIconName())
            specialImg:centerRight(18)
            self.buttonLayer:addChild(specialImg)
            self.specialImg = specialImg
        end

        self.goldImg:setSpriteName(goldData:getSmallIconName())
        self.goldText:setText("x"..goldInfo[2])
        self.specialImg:setSpriteName(specialData:getSmallIconName())
        self.strengthPercent:setText(string.format(UI.TEXT_1324453, strengthConfig.successRate))

        self.promptButton:hide()
        self.executeButton:show()
    else
        self.costGoods = nil

        self.promptButton:show()
        self.executeButton:hide()
        self.strengthPercent:setText("")

        -- 移除上一个选中效果
        if self._selectItem then
            self._selectItem:removeFromParent(false)
            self._selectItem = nil
        end
    end
end

function RelicRoleLayer:showRoleEquipIndexAni(equipIndex)
    -- 移除上一个选中效果
    if self._selectItem then
        self._selectItem:removeFromParent(false)
        self._selectItem = nil
    end

    if not equipIndex then
        return
    end

    local bg = self.ResponseRegion[equipIndex]

    self._selectItem  = UI.Animation:create()
    self._selectItem:init("effect_ui_package_title_yiwu_itemselect.json", "effect_ui_package_title_yiwu_itemselect.atlas")
    self._selectItem:center()
    bg:addChild(self._selectItem)

    self._selectItem:show()
    self._selectItem:setAnimation("start_circle", false)
    self._selectItem:addAnimation("loop_circle", true)
end

function RelicRoleLayer:updateWeaponType()
    local heroData = GameDataManager:getInstance():getMaster()
    -- 刷新武器类型
    local equipType = GameDataManager:getInstance():getWearWeaponTypeForSpriteID(heroData.spriteID)
    if equipType == 0 then
        self.equipmentType:hide()
    else
        self.equipmentType:show()
        self.equipmentType:setSpriteName("icon-equip_small1_21080010_"..equipType..".png")
    end
end

-- 更新视图
function RelicRoleLayer:showStrengthResult(isSuccess, relicType)

    if self._resultAni and not tolua.isnull(self._resultAni) then
        self._resultAni:removeFromParent(false)
    end

    self._resultAni  = UI.Animation:create()
    self._resultAni:init("effect_ui_package_yiwu_qianghua.json", "effect_ui_package_yiwu_qianghua.atlas")
    self._resultAni:center()
    self.ResponseRegion[relicType]:addChild(self._resultAni)
    self._resultAni:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
        UI.WaitingLayer:hideWaiting()

        if not self or tolua.isnull(self) then
            return
        end

        

        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE)

        self._resultAni:runAction(cc.RemoveSelf:create())
    end)

    if isSuccess then
        self._resultAni:setAnimation("success", false)
        Avalon.AudioManager:playSound("10068")
    else
        self._resultAni:setAnimation("defeat", false)
        Avalon.AudioManager:playSound("10067")
    end
end

-- 更新视图
function RelicRoleLayer:onUpdateView()
    -- 用于刷新遗物状态，隐藏部分功能显示
    self:updateRelicSlot()
end