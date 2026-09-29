------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BuffTipView = class("BuffTipView", UI.HWBtnComponent)
local ZORDER_HERO_PANEL_BUFF = 100
-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
-- buff背景的宽高
local BUFF_BACK_WIDTH = 920
local BUFF_BACK_HEIGHT = 590
-- buff的宽度（正方形）
local BUFF_ICON_WIDTH = 24
-- buff之间的间隔
local BUFF_ICON_SPACING = 5
-- 组件的大小
local WIDTH = 270
local HEIGHT = 100

function BuffTipView:ctor(buffData)
    BuffTipView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.buffData = buffData
end

function BuffTipView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.common", "Common", false)
    BuffTipView.super.init(self, ... )
end

function BuffTipView:dtor()
    BuffTipView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.common.BuffTipView")
end


function BuffTipView:onInitView()

    self._bufftable = {}
    self._debufftable = {}

    -- buff详情弹出页面
    self._buffInfoLayer = cc.Layer:create()
    self._buffInfoBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))

    -- 方向符号
    local directionImage = cc.Sprite:createWithSpriteFrameName("ui_information_banner_background2.png")
    directionImage:setPosition(0, 0)
    directionImage:setRotation(180)
    self._buffInfoLayer:addChild(directionImage, 2)
    self._directionImage = directionImage

    self:addChild(self._buffInfoLayer, ZORDER_HERO_PANEL_BUFF)

    self._buffInfoLayer:addChild(self._buffInfoBg)
    self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + 95, -BUFF_BACK_HEIGHT / 2 + 70)
    
    local bufferDataList = self.buffData
    if not bufferDataList then
        local GameDataManager = require("app.game.GameDataManager")
        local master = GameDataManager:getInstance():getMaster()
        bufferDataList = SkillDataManager:getBufferDataListForSpriteID(master:getSpriteID())
    end
    
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            local _buff = {}
            _buff.bufferData = v
            _buff.bufferEntityID = v:getEntityID()
            _buff.bufferTargetID = v:getTargetSpriteID()

            if (_buff.bufferData:getICON()) then
                self:addBuffView(_buff)
            end
        end
    end

end


-- 添加buff页面
function BuffTipView:addBuffView(data)
    local buffer = data.bufferData

    if buffer then
        -- 添加buffer，格式：{bufferData (table), bufferEntityID {number}, bufferTargetID (number)}
        if buffer:getICON() then --关闭测试时打开
            local sp2 = cc.Sprite:createWithSpriteFrameName(buffer:getICON()) --关闭测试时打开

            local buffTimer2 = nil
            if buffer.duration ~= -1 then
                buffTimer2 = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("effect_buff_0.png"))
                buffTimer2:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                buffTimer2:setPercentage(
                    1.0 * (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                )

                -- 持续时间
                local action2 = cc.ProgressTo:create(buffer:getDuration(), 100)

                buffTimer2:runAction(action2)

                buffTimer2:setPosition(cc.p(sp2:getContentSize().width / 2, sp2:getContentSize().height / 2))
                sp2:addChild(buffTimer2)
            end

            -- buffer 名称
            local buffName = cc.Label:createWithTTF("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
            self._buffInfoLayer:addChild(buffName)
            buffName:setWidth(112)
            buffName:setString(buffer.name)
            -- 描述文字
            local buffDescribe = cc.Label:createWithTTF("持续时间3S", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
            buffDescribe:setWidth(200)
            buffDescribe:setString(buffer.description)
            -- buffDescribe:setString("fsdhj fowei rewj fioewjf eiows fhjei owhrfi ohfiods fhsd fsdf sdf")
            self._buffInfoLayer:addChild(buffDescribe)

            local datatable = {
                sprite2 = sp2,
                ID = data.bufferEntityID,
                data = data,
                Timer = buffTimer,
                Timer2 = buffTimer2,
                name = buffName,
                describe = buffDescribe
            }

            if buffer:isGood() then
                table.insert(self._bufftable, datatable)
            else
                table.insert(self._debufftable, datatable)
            end

            if (buffer:getIsAddNew()) then
                buffer:setAddNew(false)
            end

            self._buffInfoLayer:addChild(sp2)
            self:showBuffInfo()
        end
    end
end


-- buff详情页面
function BuffTipView:showBuffInfo()
    print("---- BuffTipView:showBuffInfo()-------")
    -- body
    self._buffInfoLayer:setVisible(true)
    self._buffInfoBg:setVisible(true)
    -- 恢复背景原来大小
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))

    local point = self:convertToWorldSpace(self:getAnchorPointInPoints())

    -- 默认显示buff 和 debuff
    local buffTpye = 2
    -- 初始y的值
    local py = 0
    local num = 0
    for id, buff in pairs(self._bufftable) do
        if buff.sprite2 ~= nil then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)
            -- 默认的x坐标
            local px = -BUFF_BACK_WIDTH / 2 + BUFF_ICON_WIDTH + BUFF_ICON_SPACING
            buff.sprite2:setPosition(cc.p(px, BUFF_BACK_HEIGHT / 2 - BUFF_ICON_WIDTH - py - height / 2))
            buff.name:setPosition(
                cc.p(px + BUFF_ICON_WIDTH * 2 + buff.name:getContentSize().width / 2 - 30, buff.sprite2:getPositionY())
            )
            buff.describe:setPosition(
                cc.p(
                    BUFF_ICON_WIDTH * 3 / 2 + buff.name:getPositionX() + buff.name:getContentSize().width / 2 + 120,
                    buff.sprite2:getPositionY()
                )
            )

            py = py + height + 10
            num = num + 1
        end
    end

    -- buff这列的高度
    local buffHeight = py + BUFF_ICON_WIDTH
    -- 计算buff的个数
    if num > 5 then
        num = 5
    end

    -- 若存在buff的时候，debuff 的x坐标
    -- local  px =  BUFF_ICON_WIDTH + BUFF_ICON_SPACING - 30

    -- 不存在buff
    -- if py == 0  then
    -- debuff 的x坐标
    buffTpye = 1
    px = -BUFF_BACK_WIDTH / 2 + BUFF_ICON_WIDTH + BUFF_ICON_SPACING
    -- end

    -- 初始y的值
    -- local  py = 0

    local debuffnum = 0
    for id, buff in pairs(self._debufftable) do
        if buff.sprite2 ~= nil then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)

            buff.sprite2:setPosition(cc.p(px, BUFF_BACK_HEIGHT / 2 - BUFF_ICON_WIDTH - py - height / 2))
            buff.name:setPosition(
                cc.p(px + BUFF_ICON_WIDTH * 2 + buff.name:getContentSize().width / 2 - 30, buff.sprite2:getPositionY())
            )
            buff.describe:setPosition(
                cc.p(
                    BUFF_ICON_WIDTH * 3 / 2 + buff.name:getPositionX() + buff.name:getContentSize().width / 2 + 120,
                    buff.sprite2:getPositionY()
                )
            )

            py = py + height + 10
            debuffnum = debuffnum + 1
        end
    end
    -- 计算debuff的个数
    if debuffnum > 5 then
        debuffnum = 5
    end

    if num < debuffnum then
        num = debuffnum
    end

    -- debuff这列的高度
    local debuffHeight = py + BUFF_ICON_WIDTH

    -- 如果减益buff不存在
    if py == 0 then
        -- 如果没有增益buff
        if buffTpye == 1 then
            buffTpye = 0
        elseif buffTpye == 2 then
            buffTpye = 1
        end
    end

    if buffTpye == 0 then
        self._buffInfoBg:setVisible(false)
    elseif buffTpye == 1 then
        self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH / 2, self._buffInfoBg:getContentSize().height))
        self._buffInfoBg:setPositionX(-BUFF_BACK_WIDTH / 4)
    else
        self._buffInfoBg:setPositionX(0)
    end

    -- 取增益和减益最高的
    if buffHeight > debuffHeight then
        py = buffHeight
    else
        py = debuffHeight
    end

    -- self._buffInfoBg:setContentSize(cc.size(self._buffInfoBg:getContentSize().width, self._buffInfoBg:getContentSize().height * py/ BUFF_BACK_HEIGHT))
    self._buffInfoBg:setContentSize(cc.size(self._buffInfoBg:getContentSize().width, py - BUFF_ICON_WIDTH))
    self._buffInfoBg:setPositionY((BUFF_BACK_HEIGHT - py) / 2 - 5)
    self._directionImage:setPosition(
        -BUFF_BACK_WIDTH / 2 - 3,
        self._buffInfoBg:getPositionY() + self._buffInfoBg:getContentSize().height / 2 - 30
    )

    --  x  方向的偏移量
    local px = (BUFF_ICON_WIDTH + 2) * num
    if self._type == UIType.TEAMMATESTATUS then
        self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + px, -BUFF_BACK_HEIGHT / 2 + 220)
    else
        self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + px, -BUFF_BACK_HEIGHT / 2 + 70)
    end

end

function BuffTipView:bindModel()

end


function BuffTipView:unbindModel()

end





return BuffTipView












