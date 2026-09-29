-- RelicMainLayer.lua
-- by:hongyi.yan
-- time:2020.09.06
require("utils.ObserverVariable")
require("app.config.ConfigManager")
require "app.ui.baglayer.Relic.RelicRoleLayer"
require "app.ui.baglayer.Relic.RelicBagLayer"
require "app.ui.baglayer.Relic.RelicDataManager"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()

UI = UI or {}

local RelicMainLayer = class("RelicMainLayer", UI.HWBtnComponent)
UI.RelicMainLayer = RelicMainLayer

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_starpray.plist",
    "ui_general_uishare.plist",
    "ui_bg_paper3.plist",
    "ui_common_btn.plist",
    "ui_common_goods.plist",
    "ui_package_relic.plist",
}

local COM_WIDTH = 978
local COM_HEIGHT = 555

-- 右上角展示的资源id列表
local RESOURCE_ID_LIST = {
    22070600,   -- 时序之尘
    22070610,   -- 时序精华
    23020001,   -- 金币
}

function RelicMainLayer:ctor()
    RelicMainLayer.super.ctor(
    self,
    UIType.RELIC_MAIN_VIEW,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )
    self.rootLayer = nil;           --root节点

    self:registerListener();

    -- self:enableDebugDraw()
end
local HORCURX_FUNCTION_TYPE = {
    LEVEL=1,HUAN_HUA=2, EVOLUTION=3
}

function RelicMainLayer:dtor()
    RelicMainLayer.super.dtor(self)
    self:unRegisterListener();

    reload_script_file("app.ui.baglayer.Relic.RelicMainLayer")
end
-- 注册监听事件(可选)
function RelicMainLayer:registerListener()
    -- 角色状态更新
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateDustNum)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.updateDustNum)
end


-- 注销监听事件(可选)
function RelicMainLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, self.updateDustNum)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.updateDustNum)
end

-- 初始化视图
function RelicMainLayer:onInitView()

    -- self:enableDebugDraw()

    -- 左侧人物
    local relicRoleLayer = UI.RelicRoleLayer:create()
    relicRoleLayer:init()
    relicRoleLayer:centerLeft(50)
    self:addChild(relicRoleLayer)
    self.relicRoleLayer = relicRoleLayer

    -- 右侧背包
    local relicBagLayer = UI.RelicBagLayer:create(
        self,
        368
    )
    relicBagLayer:init()
    relicBagLayer:centerRight(50)
    self:addChild(relicBagLayer)
    self.relicBagLayer = relicBagLayer

    self:createDustNum()
end

function RelicMainLayer:createDustNum()
    local PosX = {
        400,
        280,
        170
    }
    local posY = - 200

    self.goodsNumList = {}
    local pk = RoleDataManager:getMaster():getPK()

    for k, v in ipairs(RESOURCE_ID_LIST) do
        local num = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, v)
        if k == 3 then
            num = GameDataManager:getCurCoin()
        end
        local goodData = GoodsDataManager:createLocalGoodsData(v)

        local goodIcon = UI.Image:create()
        goodIcon:init(goodData:getSmallIconName())
        goodIcon:centerRight(PosX[k], posY)
        self:addChild(goodIcon)

        local goodNum  = UI.Text:create()
        goodNum:init(goodNum:numformat(string.format("%s", tostring(num))), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
        goodNum:setTextLeft()
        goodNum:centerLeft(k==3 and 26 or 32)
        goodIcon:addChild(goodNum)

        self.goodsNumList[v] = {}
        self.goodsNumList[v].Text = goodNum
        self.goodsNumList[v].num = num
    end
end

function RelicMainLayer:updateDustNum()
    performWithDelay(self, function()
        local pk = RoleDataManager:getMaster():getPK()
        for k, v in ipairs(RESOURCE_ID_LIST) do
            local num = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, v)
            if k == 3 then
                num = GameDataManager:getCurCoin()
            end
            local goodNum  = self.goodsNumList[v].Text

            if num ~= self.goodsNumList[v].num then
                local diffNum = num - self.goodsNumList[v].num
                self.goodsNumList[v].num = num
                goodNum:setText(goodNum:numformat(string.format("%s", tostring(num))))

                --  处理金币以及钻石表现
                local text = UI.Text:create()
                text:init("", UI.FONT_ARIAL)
                text:centerBottom(10)

                if(diffNum > 0) then
                    text:setFontColor(UI.FONT_COLOR_GREEN)
                    text:setText(string.format("+%d", diffNum))
                else
                    text:setFontColor(UI.FONT_COLOR_RED)
                    text:setText(string.format("-%d",math.abs(diffNum)))
                end

                goodNum:addChild(text)
                text:updateView()

                if(self._waitingNum == nil) then
                    self._waitingNum = 0
                end

                local delayTime = self._waitingNum * 0.5
                if(delayTime < 0) then
                    delayTime = 0
                end

                text:setVisible(false)
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    if(self and not tolua.isnull(self)) then
                        if not text or tolua.isnull(text) then
                            return
                        end
                        text:setVisible(true)
                        text:runAction(cc.Spawn:create(
                            cc.MoveBy:create(0.5,cc.p(0,20)),
                            cc.Sequence:create(cc.DelayTime:create(0.4),
                            cc.FadeOut:create(0.1),cc.RemoveSelf:create(), cc.CallFunc:create(function() 
                                self._waitingNum = self._waitingNum - 1
                            end))))
                    end
                end,delayTime)
            end
        end
    end, 0.3)
end

function RelicMainLayer:showRoleEquipIndexAni(equipIndex)
    self.relicRoleLayer:showRoleEquipIndexAni(equipIndex)
end

function RelicMainLayer:show()
    RelicMainLayer.super.show(self)
    self.relicRoleLayer:updateWeaponType()
end

function RelicMainLayer:showShareBtn(parentNode)
    --分享布局
    -- parentNode:showShareBtn(handler(self, self.createShareInfo), SHARE_MODULE.SHARE_MODULE_SKILL)
end

-- 更新视图
function RelicMainLayer:onUpdateView()
end