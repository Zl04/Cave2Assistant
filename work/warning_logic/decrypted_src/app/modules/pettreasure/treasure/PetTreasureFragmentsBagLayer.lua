------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/30
--desc	: 神器碎片局部显示公用
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureFragmentsBagLayer = class("PetTreasureFragmentsBagLayer", UI.BaseWin)

local SceneManager = require("app.game.SceneManager")

local COM_WIDTH = 300
local COM_HEIGHT = 90

function PetTreasureFragmentsBagLayer:ctor()
    PetTreasureFragmentsBagLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasureFragmentsBagLayer:init(isRecord)
    self.isRecored = isRecord or false

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureFragmentsBagLayer.super.init(self)
end

function PetTreasureFragmentsBagLayer:dtor()
    PetTreasureFragmentsBagLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.treasure.PetTreasureFragmentsBagLayer")
end

function PetTreasureFragmentsBagLayer:onInitView()
    -- 是否显示当前收集挑战对应的碎片
    self.isShowCurCollectEff = false
    -- 碎片图片
    self.fragmentsBg = {}

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:updateLayer()
end

function PetTreasureFragmentsBagLayer:updateLayer()
    self:updateFragmentsBag()
end

function PetTreasureFragmentsBagLayer:updateFragmentsBag()
    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    local localFragmentsBag = mvc.petTreasureModel:readFragmentMessage()

    local fragmentsLayout = self.contentLayout

    for key = 1, #fragmentsBag do
        local fragmentBg = self.fragmentsBg[key]
        if not fragmentBg then
            fragmentBg = UI.Image:create()
            fragmentBg:init("ui_pettreasure_fragment_0.png")
            fragmentBg:leftBottom(38 * key - 30, 10)
            self.fragmentsBg[key] = fragmentBg
            fragmentsLayout:addChild(fragmentBg)
        end

        local fragmentIcon = fragmentBg:getChildByName("fragmentIcon")
        if not fragmentIcon then
            fragmentIcon = UI.Image:create()
            fragmentIcon:init("ui_pettreasure_fragment_"..key..".png")
            fragmentIcon:leftBottom(4, 12)
            fragmentIcon:setName("fragmentIcon")
            fragmentBg:addChild(fragmentIcon)
        end

        -- 根据本地记录展现碎片
        if localFragmentsBag[key] ~= 0 then
            fragmentIcon:show()
        else
            fragmentIcon:hide()
        end
    end

    self.showFragmentIndex = 1
    self:fragmentShowChange()

    self:updateFragmentFightBtn()
end

function PetTreasureFragmentsBagLayer:updateFragmentFightBtn()
    local fragmentsLayout = self.contentLayout
    local fragmentFightBtn = fragmentsLayout:getChildByName("fragmentFightBtn")
    if not fragmentFightBtn then
        local normal = self.isRecored and "ui_pettreasure_record_1.png" or "ui_pettreasure_record_0.png"
        local select = self.isRecored and "ui_pettreasure_record_0.png" or "ui_pettreasure_record_1.png"
        fragmentFightBtn = UI.Button:create()
        fragmentFightBtn:init(normal, select,"ui_pettreasure_record_0.png")
        fragmentFightBtn:rightBottom(0, 12)
        fragmentFightBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            mvc.send("PetTreasure_Switch_Challenge_Records_Layer")
        end)
        self.fragmentFightBtn = fragmentFightBtn
        fragmentsLayout:addChild(fragmentFightBtn)
    end
end

function PetTreasureFragmentsBagLayer:fragmentShowChange()
    if not self.fragmentEff then

        local fragmentEff = UI.Animation:create()
        fragmentEff:init("effect_ui_town_pettreasure_fragment.json", "effect_ui_town_pettreasure_fragment.atlas", 1);
        fragmentEff:leftBottom(60, 41)
        self.contentLayout:addChild(fragmentEff, 100)

        fragmentEff:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function()
            if not self or tolua.isnull(self) then
                return
            end

            local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()

            if self.showFragmentIndex <= #fragmentsBag then
                if self.isGetNewFragment then
                    mvc.petTreasureModel:writeFragmentMessage(self.showFragmentIndex, "1")
                else
                    mvc.petTreasureModel:writeFragmentMessage(self.showFragmentIndex, "0")
                end
                self.showFragmentIndex = self.showFragmentIndex + 1
                self:showChangeAnim()
            end
        end)

        self.fragmentEff = fragmentEff
    end

    -- 开始遍历碎片，进行效果展示
    self:showChangeAnim()
end

-- 根据情况显示碎片
function PetTreasureFragmentsBagLayer:showChangeAnim()
    self.curFragmentsContent = ""

    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    local localFragmentsBag = mvc.petTreasureModel:readFragmentMessage()
    local localFragmentValue = localFragmentsBag[self.showFragmentIndex]

    if self.showFragmentIndex == #fragmentsBag + 1 then
        if mvc.petTreasureModel:getFragmentsTotalNum() == #fragmentsBag then
            self.fragmentEff:leftBottom(120, 42)
            self.fragmentEff:setAnimation("end", true)
        else
            if self.isShowCurCollectEff then
                local index = mvc.petTreasureModel:getCurCollectFragmentIndex()
                self.fragmentEff:leftBottom(-16 + 38 * index, 41)
                self.fragmentEff:setAnimation("idle", true)
            end
        end

        self.showFragmentIndex = self.showFragmentIndex + 1
        return
    elseif self.showFragmentIndex > #fragmentsBag + 1 then
        return
    end

    local function fragmentIconChange()
        if not self.fragmentsBg then
            return
        end

        local fragmentsBg = self.fragmentsBg[self.showFragmentIndex]
        if not fragmentsBg then
            return
        end

        local fragmentIcon = fragmentsBg:getChildByName("fragmentIcon")
        if self.isGetNewFragment then
            fragmentIcon:show()
        else
            fragmentIcon:hide()
        end
    end
    -- 最新数据和本地不一致，用动效显示
    if fragmentsBag[self.showFragmentIndex] ~= localFragmentValue then
        --- 更新需要保存本地的数据
        for index = 1, #fragmentsBag do
            if index ~= 1 then
                self.curFragmentsContent = self.curFragmentsContent.."|||"
            end

            if index <= self.showFragmentIndex then
                self.curFragmentsContent = self.curFragmentsContent..fragmentsBag[index]
            else
                self.curFragmentsContent = self.curFragmentsContent..localFragmentsBag[index]
            end
        end

        if fragmentsBag[self.showFragmentIndex] > localFragmentValue then
            self.isGetNewFragment = true
            self.fragmentEff:leftBottom(-16 + 38 * self.showFragmentIndex, 41)
            self.fragmentEff:setAnimation("tigger_victory", false)
            
            Avalon.Scheduler:scheduleUpdateOnce(self, fragmentIconChange, 0.1)
        else
            self.isGetNewFragment = false
            self.fragmentEff:leftBottom(-16 + 38 * self.showFragmentIndex, 41)
            self.fragmentEff:setAnimation("tigger_defeat", false)

            Avalon.Scheduler:scheduleUpdateOnce(self, fragmentIconChange, 0.1)
        end
    -- 与本地一直说明没有改变，直接显示或隐藏
    else
        self.showFragmentIndex = self.showFragmentIndex + 1
        self:showChangeAnim()
    end
end

function PetTreasureFragmentsBagLayer:setIsShowCurCollectEff(value)
    local fragmentsBag = mvc.petTreasureModel:getFragmentsBag()
    self.isShowCurCollectEff = value

    if self.showFragmentIndex == #fragmentsBag + 2 then
        if mvc.petTreasureModel:getFragmentsTotalNum() == #fragmentsBag then
            self.fragmentEff:leftBottom(120, 42)
            self.fragmentEff:setAnimation("end", true)
        else
            if value then
                local index = mvc.petTreasureModel:getCurCollectFragmentIndex()
                self.fragmentEff:leftBottom(-16 + 38 * index, 41)
                self.fragmentEff:setAnimation("idle", true)
            end
        end
    end
end

function PetTreasureFragmentsBagLayer:bindModel()

end

function PetTreasureFragmentsBagLayer:unbindModel()

end

return PetTreasureFragmentsBagLayer
