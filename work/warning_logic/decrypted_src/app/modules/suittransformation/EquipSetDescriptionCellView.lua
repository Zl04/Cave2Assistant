------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/01
--desc	: 
------------------------------------------------------------------------------

require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require "app.game.SdkManager"

UI = UI or {}

local EquipSetDescriptionCellView = class("EquipSetDescriptionCellView", UI.HWBtnComponent)
UI.EquipSetDescriptionCellView = EquipSetDescriptionCellView

local CELL_WIDTH = 287
local CELL_HEIGHT = 64
EquipSetDescriptionCellView.CELL_WIDTH = CELL_WIDTH
EquipSetDescriptionCellView.CELL_HEIGHT = CELL_HEIGHT

function EquipSetDescriptionCellView:ctor(setDescriptionArr, parentTable)
    EquipSetDescriptionCellView.super.ctor(self)

    self._setDescriptionArr = setDescriptionArr
    self._parentTable = parentTable
    self._callback = nil

    self._selectIndex = 0

    --test
    -- self._setDescriptionArr.isUnlock = true

    Avalon.MessageCenter:bind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
end

function EquipSetDescriptionCellView:dtor()
    EquipSetDescriptionCellView.super.dtor(self)

    Avalon.MessageCenter:unbind(GameMessage.MC_ON_TIPS_CLOSE_BUTTON, self,self.onCloseDetails)
    reload_script_file("app.modules.suittransformation.EquipSetDescriptionCellView")
end

function EquipSetDescriptionCellView:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(CELL_WIDTH, CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    local jStr = ""
    if self._setDescriptionArr.isExpanded then
        jStr = "ui_btn_spread_0.png"
        self._rootLayer:setSize(CELL_WIDTH, CELL_HEIGHT + #self._setDescriptionArr.activationArr * CELL_HEIGHT)
    else
        jStr = "ui_btn_spread_3.png"
    end

    self.jtSp = UI.Image:create()
    self.jtSp:init(jStr)
    self.jtSp:leftUp(15,15)
    self._rootLayer:addChild(self.jtSp, 2)

    local setNameText = UI.Text:create()
    setNameText:init(self._setDescriptionArr.setName, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 64, g = 61, b = 56})
    setNameText:centerUp(18, 32)
    setNameText:setTextCenter()
    self._rootLayer:addChild(setNameText,3)

    --锁  
    self.lockSp = UI.Image:create()
    self.lockSp:init("ui_home_retrofit_lock.png")
    self.lockSp:centerRight(20)
    self._rootLayer:addChild(self.lockSp, 4)

    if self._setDescriptionArr.isUnlock then
        self.lockSp:hide()
    else
        self.lockSp:show()
        setNameText:centerUp(18, 20)
    end


    local bgBtn = UI.Button:create();
    bgBtn:init("ui_deformation_information.png","ui_deformation_information.png","ui_deformation_information.png")
    bgBtn:leftUp(0, 0)
    bgBtn:setTouchClipNode(self._parentTable)
    bgBtn:closeClickScale()
    self._rootLayer:addChild(bgBtn)
    bgBtn:setSwallowTouches(false)
    bgBtn:addEventListener(UIEvent.BUTTON_CLICK,self, self.bgBtnAction)
    self._bgBtn = bgBtn

    self:updateContentView()
end

function EquipSetDescriptionCellView:updateContentView()
    if not self._setDescriptionArr.isExpanded then
        return
    end 

    self._attrBtnList = {}
    self._attrLayout = {}

    for k,data in ipairs(self._setDescriptionArr.activationArr) do
        local attrLayout = UI.Layout:create()
        attrLayout:init()
        attrLayout:setSize(CELL_WIDTH, CELL_HEIGHT)
        attrLayout:leftUp(0, CELL_HEIGHT*k)
        self:addChild(attrLayout)

        local bgBtn = UI.Button:create();
        bgBtn:init("ui_home_retrofit_paper_checked_2.png","ui_home_retrofit_paper_checked_2.png","ui_home_retrofit_paper_checked_2.png")
        bgBtn:center()
        bgBtn:setTouchClipNode(self._parentTable)
        bgBtn:closeClickScale()
        attrLayout:addChild(bgBtn)
        bgBtn:setSwallowTouches(false)
        bgBtn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
            self._selectIndex = k
            self:updateAttrBtn()

            if self._callback then
                self._callback(1, self._setDescriptionArr.activationArr[k])
            end
        end)
        table.insert(self._attrBtnList, bgBtn)
        table.insert(self._attrLayout, attrLayout)

        if self._selectIndex == k then
            bgBtn:setOpacity(255)
        else
            bgBtn:setOpacity(0)
        end

        local point = UI.Image:create()
        point:init("ui_information_hero_diamond.png")
        point:setImageColor(UI.FONT_COLOR_41_41_45)
        point:leftUp(15, 15)
        attrLayout:addChild(point)

        local textLayout = UI.Layout:create()
        textLayout:init()
        textLayout:setSize(205, 45)
        textLayout:center(-5, -1)
        attrLayout:addChild(textLayout)

        -- 描述
        local baseText = UI.Text:create()
        baseText:init(
            string.format("%s", data[1]),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            {r = 60, g = 60, b = 65}
        )
        baseText:leftUp(1, 1)
        baseText:setTextLeftUp()
        textLayout:addChild(baseText)

        if (baseText._width > textLayout:getContentSize().width) then
            baseText:setWidth(textLayout:getContentSize().width)
            baseText:setSize(textLayout:getContentSize().width, textLayout:getContentSize().height, true)
        end

        -- 数值
        local baseValue = UI.Text:create()
        baseValue:init(
            string.format("[%s]", data[2]),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            {r = 60, g = 60, b = 65}
        )
        baseValue:setSize(30, 20)
        baseValue:rightUp(11, 10)
        attrLayout:addChild(baseValue)

        local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        lineUpImage:setContentSize(296, 1)
        lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
        lineUpImage:setPosition(cc.p(attrLayout:getContentSize().width / 2, 1))
        attrLayout:addChild(lineUpImage)

        if data[3] then
            --锤子
            local hammer = UI.Image:create()
            hammer:init("ui_home_retrofit_hammer.png")
            hammer:rightUp(22, 34)
            attrLayout:addChild(hammer)
        end

    end

end

function EquipSetDescriptionCellView:updateAttrBtn()
    for k,bgBtn in ipairs(self._attrBtnList) do
        if self._selectIndex == k then
            bgBtn:setOpacity(255)
        else
            bgBtn:setOpacity(0)
        end
    end
end

function EquipSetDescriptionCellView:bgBtnAction()

    if not self._setDescriptionArr.isUnlock then
        UI.ScrollBar:createByText(UI.TEXT_222201)
        return
    end


    if self._callback then
        if self._setDescriptionArr.isExpanded then
            self._setDescriptionArr.isExpanded = false
        else
            self._setDescriptionArr.isExpanded = true
        end
        self._callback(2, nil, self._setDescriptionArr.isExpanded)
    end
end

function EquipSetDescriptionCellView:updateSelectBg(selectIndex, showEffect)
    self._selectIndex = selectIndex

    if self._attrBtnList and #self._attrBtnList > 0 then
        for k,bgBtn in ipairs(self._attrBtnList) do
            if self._selectIndex == k then
                bgBtn:setOpacity(255)

                if showEffect then
                    local effectAnimation = UI.Animation:create()
                    effectAnimation:init("effect_ui_town_retrofit.json", "effect_ui_town_retrofit.atlas", 1)
                    effectAnimation:center()
                    effectAnimation:setAnimation("begin", false)
                    self._attrLayout[k]:addChild(effectAnimation,10)

                    effectAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
                        effectAnimation:runAction(cc.RemoveSelf:create())
                    end)

                    effectAnimation._spine:registerSpineEventHandler(function (event)
                        if(event and event.eventData and event.eventData.name) then
                            local startPos = string.find(event.eventData.name, "sound_")
                            if(startPos ~= nil) then
                                -- 播放音效文件
                                local soundFilename = string.sub(event.eventData.name,7,-1)
                                Avalon.AudioManager:playDynamicSound(soundFilename)
                            end
                        end
                    end, sp.EventType.ANIMATION_EVENT)

                    


                end
            else
                bgBtn:setOpacity(0)
            end
        end
    end
end

function EquipSetDescriptionCellView:updateData(data)
    self._setDescriptionArr = data
end

function EquipSetDescriptionCellView:updateCallback(cb)
    self._callback = cb
end