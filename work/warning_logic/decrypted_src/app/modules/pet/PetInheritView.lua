------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/14
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local PetInheritView = class("PetInheritView", UI.BaseWin)

local SceneManager = require("app.game.SceneManager")
require "app.modules.pet.PetMainListCell"

UI = UI or {}

UI.PetInheritView = PetInheritView

-- 资源
local COM_RES_LIST = {
    "ui_town_gem.plist"
}

local COM_WIDTH = 425
local COM_HEIGHT = 500
local PET_PUT_STATE = {
    EMPTY = 1,
    SINGLE = 2,
    DOUBLE = 3,
    OVER = 4,
}
local PET_TYPE = {
    CHILD = 1,
    PARENT = 2,
}

function PetInheritView:ctor()
    PetInheritView.super.ctor(
    	self,
    	UI.Type.PET_INHERIT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_INHERIT_OK, self, self.inheritOver)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PET_DRAG_PET_SLOT_BEGAIN, self, self.showPutInEff)
end

function PetInheritView:init(... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetInheritView.super.init(self, ... )
end

function PetInheritView:dtor()
    self.netBlocking = false

    PetInheritView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_INHERIT_OK, self, self.inheritOver)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PET_DRAG_PET_SLOT_BEGAIN, self, self.showPutInEff)

    reload_script_file_mvc("app.modules.pet.PetInheritView")
end

function PetInheritView:resetData()
    self.netBlocking = false
    self.playingEff = false
    self.inheritCost = 0
    self.childPetObj = nil
    self.parentPetObj = nil
    self.showPetObj = nil
    self.petPutState = PET_PUT_STATE.EMPTY
    self.inputPets = {}
end

function PetInheritView:onInitView()

    self:resetData()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, -30)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create()
    bg:init("ui_pets_inherit_bg.png")
    bg:centerUp(20)
    self.contentLayout:addChild(bg)

    local line  = UI.Image:create()
    line:init("ui_pets_inherit_arrow.png")
    line:centerUp(30)
    bg:addChild(line)

    -- 传递的对象
    local parentPetLayer = UI.Layout:create()
    parentPetLayer:init()
    parentPetLayer:setSize(80, 80)
    parentPetLayer:leftUp(54, 38)
    self.contentLayout:addChild(parentPetLayer)
    self.parentPetLayer = parentPetLayer

    -- 继承的对象
    local childPetLayer = UI.Layout:create()
    childPetLayer:init()
    childPetLayer:setSize(80, 80)
    childPetLayer:leftUp(289, 38)
    self.contentLayout:addChild(childPetLayer)
    self.childPetLayer = childPetLayer

    -- 展示结果的对象
    local resultPetLayer = UI.Layout:create()
    resultPetLayer:init()
    resultPetLayer:setSize(116, 116)
    -- resultPetLayer:enableDebugDraw()
    resultPetLayer:leftUp(152, 102)
    self.contentLayout:addChild(resultPetLayer)
    self.resultPetLayer = resultPetLayer

    local resultPetFrame  = UI.Image:create()
    resultPetFrame:init("ui_pets_round.png")
    resultPetFrame:center()
    resultPetLayer:addChild(resultPetFrame)

    local resultPetBg  = UI.Image:create()
    resultPetBg:init("ui_gem_box_colorful.png")
    resultPetBg:center()
    resultPetLayer:addChild(resultPetBg)

    local resultPetIcon  = UI.Image:create()
    resultPetIcon:init("ui_pets_merge_box.png")
    resultPetIcon:center()
    resultPetLayer:addChild(resultPetIcon)

    -- 拖拽判定框
    local targetCheckLayer = UI.Layout:create();
    targetCheckLayer:init()
    targetCheckLayer:setSize(380, 220)
    targetCheckLayer:centerUp(16)
    -- targetCheckLayer:enableDebugDraw()
    self.contentLayout:addChild(targetCheckLayer)
    self.targetCheckLayer = targetCheckLayer

    -- 技能展示
    local showSkillLayout = UI.Layout:create()
    showSkillLayout:init()
    showSkillLayout:setSize(386, 108)
    showSkillLayout:centerBottom(-20)
    self.contentLayout:addChild(showSkillLayout)
    self.showSkillLayout = showSkillLayout

    local skillPrompt = UI.Text:create()
    skillPrompt:init(UI.TEXT_1314060, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)
    skillPrompt:centerBottom(260)
    skillPrompt:setTextCenter()
    skillPrompt:autoAdapt()
    skillPrompt:setLineSpacing(-6)
    showSkillLayout:addChild(skillPrompt)

    local skillBG  = UI.Image:create();
    skillBG:init("ui_pets_skill_paper.png");
    skillBG:leftBottom(3, 92);
    skillBG:setScaleY(0.87)
    skillBG:setName("SkillBG")
    showSkillLayout:addChild(skillBG, 2);

    local tableviewSize = {width = 380, height = 150} 
    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:setTableViewSize(tableviewSize)
    skillLayer:init()
    skillLayer:leftBottom(0, 90)
    skillLayer:setName("SkillLayer")
    showSkillLayout:addChild(skillLayer, 3);

    -- 合成按钮
    local useBtn = UI.Button:create()
    useBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png")
    useBtn:centerBottom(34)
    useBtn:setText(UI.TEXT_1314058)
    useBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        if self.playingEff then
            return
        end

        if self.petPutState ~= PET_PUT_STATE.DOUBLE then
            UI.ScrollBar:createByText(UI.TEXT_1314057)
            return
        end

        if self.inheritCost > 0 then
            if Avalon.MathUtil:checkDiamonEnough(tonumber(self.inheritCost), GameDataManager:getInstance():getDiamond()) then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    UI.TEXT_1314061,
                    function()
                        self:lockNetInherit()

                        Net.NetPetSystem:inherit(self.parentPetObj:getId(), self.childPetObj:getId())
                    end
                )
            else
                -- 钻石不足
                local tips = UI.TipsLayer:onDiamondNotEnough()
                if(tips) then 
                    tips:setZOrder(UI_ZORDER.MAX)
                end
                tips:removeFromParent(false)
                UI.UIManager:getRootNode():addChild(tips)
            end
        else
            UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                UI.TEXT_1314061,
                function()
                    self:lockNetInherit()
                    -- self:inheritOver(self.parentPetObj:getId(), self.childPetObj:getId())
                    Net.NetPetSystem:inherit(self.parentPetObj:getId(), self.childPetObj:getId())
                end
            )
        end
    end)
    self.useBtn = useBtn
    self.contentLayout:addChild(useBtn)
end

function PetInheritView:lockNetInherit()
    self.netBlocking = true

    performWithDelay(self, function()
        if not self or tolua.isnull(self) then
            return
        end

        self.netBlocking = false
    end, 5)
end

function PetInheritView:inheritOver(parentID, petID)
    printInfo("server Response parentID : " .. parentID .."    childID : " .. petID)
    self.netBlocking = false
    self.playingEff = true

    self.showPetObj = MasterDataManager:getBagPetById(petID)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST)

    self.slotEff:setAnimation("begin", false)
end

function PetInheritView:updateViewShow()
    self:updateUseBtn()
    self:updateSkillLayer()
    self:clearPetShowIcon()
end

function PetInheritView:updateUseBtn()
    local costLayer = self.useBtn:getChildByName("costLayer")
    if costLayer then
        self.useBtn:removeChildByName("costLayer")
    end

    if self.inheritCost > 0 then
        costLayer = UI.Layout:create();
        costLayer:init()
        costLayer:enableAutoWidth()
        costLayer:enableAutoHeight()
        costLayer:center()
        costLayer:setName("costLayer")
        self.useBtn:addChild(costLayer, 100)

        local costImg  = UI.Image:create();
        costImg:init("symbol_gaming_diamond.png");
        costImg:floatLeft(0)
        costLayer:addComponent(costImg, 10)

        local costTxt = UI.Text:create()
        costTxt:init(tostring(self.inheritCost), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        costTxt:floatLeft(10)
        costLayer:addComponent(costTxt, 10)

        self.useBtn:setText("")
    else
        self.useBtn:setText(UI.TEXT_1314058)
    end
end

function PetInheritView:slotDragEnd(petID, x, y)
    local putInEff = self.contentLayout:getChildByName("putInEff")
    if putInEff then
        self.contentLayout:removeChildByName("putInEff")
    end

    if self.playingEff then
        return
    end

    if not self:isVisible() then
        return
    end

    local pos = self.targetCheckLayer:convertToNodeSpace(cc.p(x, y))
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        self:addPetShowIcon(petID)
    end
end

-- 根据现在的petPutState进行清理
function PetInheritView:clearPetShowIcon()
    if self.petPutState == PET_PUT_STATE.EMPTY then
        if self.contentLayout:getChildByName("childShowIcon") then
            self.contentLayout:removeChildByName("childShowIcon")
        end

        if self.contentLayout:getChildByName("parentShowIcon") then
            self.contentLayout:removeChildByName("parentShowIcon")
        end

        if self.contentLayout:getChildByName("overShowIcon") then
            self.contentLayout:removeChildByName("overShowIcon")
        end

    elseif self.petPutState == PET_PUT_STATE.SINGLE then
        if self.contentLayout:getChildByName("parentShowIcon") then
            self.contentLayout:removeChildByName("parentShowIcon")
        end

    elseif self.petPutState == PET_PUT_STATE.OVER then
        if self.contentLayout:getChildByName("childShowIcon") then
            self.contentLayout:removeChildByName("childShowIcon")
        end

        if self.contentLayout:getChildByName("parentShowIcon") then
            self.contentLayout:removeChildByName("parentShowIcon")
        end
    end
end

function PetInheritView:addPetShowIconCheck(petID)
    local petData = MasterDataManager:getBagPetById(petID)

    -- 出战宠物无法进行
    if petData:isFight() then
        UI.ScrollBar:createByText(UI.TEXT_1314050)
        return false
    end
    
    if MasterDataManager:isAllowPetChange(petID) then
        UI.ScrollBar:createByText(UI.TEXT_226180)
        return
    end


    -- 百变宠不能用于炼化
    if tonumber(ConfigManager:getGeneralForKey("PetCommonID")) == petData.templateID then
        UI.ScrollBar:createByText(UI.TEXT_1314051)
        return false
    end

    if self.childPetObj then
        -- 相同宠物不能继承
        if self.childPetObj:getId() == petID then
            UI.ScrollBar:createByText(UI.TEXT_1314052)
            return false
        end

        local parentSkills = petData:getAllSkills()
        local childSkills = self.childPetObj:getAllSkills()
        -- 传递宠物无技能时不能进行
        if #parentSkills <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_1314053)
            return false
        end

        -- 父宠物的当前技能个数，不能大于子宠物的可用技能栏数
        if #parentSkills > self.childPetObj:getNormalSkillSlotNum() then
            UI.ScrollBar:createByText(UI.TEXT_1314055)
            return false
        end
    end

    local parentPetObj = nil
    if self.petPutState == PET_PUT_STATE.SINGLE then
        parentPetObj = MasterDataManager:getBagPetById(petID)
    end

    if self.childPetObj and parentPetObj then
        -- 只能平级或向上传承
        local ReincarntionLvChild = self.childPetObj:getReincarntionLv()
        local ReincarntionLvParent = parentPetObj:getReincarntionLv()
        if ReincarntionLvParent > ReincarntionLvChild then
            --UI.ScrollBar:createByText("只能平级或向上传承")
            UI.ScrollBar:createByText(UI.TEXT_1314064)
            return false
        end
    end

    return true
end

function PetInheritView:addPetShowIcon(petID)

    local petData = MasterDataManager:getBagPetById(petID)

    local isPass = self:addPetShowIconCheck(petID)
    if not isPass then
        return
    end

    if self.petPutState == PET_PUT_STATE.EMPTY or self.petPutState == PET_PUT_STATE.OVER then
        self.childPetObj = petData
        self.inputPets[1] = petData:getId()
        self.petPutState = PET_PUT_STATE.SINGLE

        self:addPetShowIconByType(petID, PET_TYPE.CHILD)
    elseif self.petPutState == PET_PUT_STATE.SINGLE then
        self.parentPetObj = petData
        self.inputPets[2] = petData:getId()
        self.petPutState = PET_PUT_STATE.DOUBLE
        self.inheritCost = math.max(self.childPetObj:getInheritCost(), self.parentPetObj:getInheritCost())

        self:addPetShowIconByType(petID, PET_TYPE.PARENT)
    elseif self.petPutState == PET_PUT_STATE.DOUBLE then
        UI.ScrollBar:createByText(UI.TEXT_1314056)
        return
    end

    self:updateUseBtn()
    self:updateSkillLayer()
end

function PetInheritView:addPetShowIconByType(petID, stype)
    local name = stype == PET_TYPE.CHILD and "childShowIcon" or "parentShowIcon"
    local pos = stype == PET_TYPE.CHILD and cc.p(291, 43) or cc.p(56, 43)
    -- printInfo("name ==== ".. name)

    local SlotNode = self.contentLayout:getChildByName(name)
    if SlotNode then
        self.contentLayout:removeChildByName(name)
    end

    local petIconCell = UI.PetMainListCell:create()
    petIconCell:init(petID)
    petIconCell:leftUp(pos.x, pos.y)
    petIconCell:setName(name)
    self.contentLayout:addChild(petIconCell, 100)

    petIconCell:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
    petIconCell:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onPetIconTouchEnd)

    if not self.slotEff then
        local slotEff = UI.Animation:create()
        slotEff:init("effect_ui_town_pet_jicheng.json", "effect_ui_town_pet_jicheng.atlas", 1);
        slotEff:leftUp(206, 136)
        self.contentLayout:addChild(slotEff, 300)

        slotEff:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function()
            if not self or tolua.isnull(self) then
                return
            end

            self.playingEff = false
            -- 策划要求结果不显示
            -- local showPetId = self.showPetObj:getId()
            self:resetData()
            -- self.showPetObj = MasterDataManager:getBagPetById(showPetId)
            -- self.petPutState = PET_PUT_STATE.OVER
            self.petPutState = PET_PUT_STATE.EMPTY
            self:updateViewShow()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REMOVE, self.inputPets)
            UI.ScrollBar:createByText(UI.TEXT_1314059)
        end)

        self.slotEff = slotEff
    end

    local overShowIcon = self.contentLayout:getChildByName("overShowIcon")
    if stype == PET_TYPE.CHILD then
        if overShowIcon then
            self.contentLayout:removeChildByName("overShowIcon")
        end

        overShowIcon = UI.PetMainListCell:create()
        overShowIcon:init(petID)
        overShowIcon:leftUp(175, 123)
        overShowIcon:setName("overShowIcon")
        self.contentLayout:addChild(overShowIcon, 200)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN, self.inputPets)
end

function PetInheritView:onPetIconTouchMove(com, touchPosition)
    local pos = self.contentLayout:convertToNodeSpace(touchPosition)
    local size = com:getContentSize()
    local x = pos.x - size.width/2
    local y = pos.y - size.height/2
    com:setPosition(cc.p(x, y))
end

function PetInheritView:onPetIconTouchEnd(com, touchPosition)

    local stype = com:getName() == "childShowIcon" and PET_TYPE.CHILD or PET_TYPE.PARENT

    local pos = stype == PET_TYPE.CHILD and self.childPetLayer:convertToNodeSpace(touchPosition) or self.parentPetLayer:convertToNodeSpace(touchPosition)
    local size = stype == PET_TYPE.CHILD and self.childPetLayer:getContentSize() or self.parentPetLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        if stype == PET_TYPE.CHILD then
            com:leftUp(291, 43)
        else
            com:leftUp(56, 43)
        end
    else
        if stype == PET_TYPE.CHILD then
            -- 继承者被拖回，直接清空所有
            self:resetData()
            self:updateViewShow()
        else
            -- 传递者被拖回，清空相关
            self.inheritCost = 0
            self.parentPetObj = nil
            self.inputPets[2] = nil
            self.petPutState = PET_PUT_STATE.SINGLE
            self:updateViewShow()
        end
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN, self.inputPets)
end

function PetInheritView:updateSkillLayer()
    if not self.showSkillLayout then
        return
    end

    local skillData = self:getSkillShowData()
    local skillLayer = self.showSkillLayout:getChildByName("SkillLayer")
    skillLayer:updateLayerByData(skillData)
end

function PetInheritView:getSkillShowData()
    local skillData = {}
    local parentSkillData = {}
    local childSkillData = {}

    local idsParent = {1, 2, 3, 4, 5, 6, 7, 8}
    local idsChild = {1, 2, 3, 4, 5, 6, 7, 8}
    -- local xArr = {26, 120, 210, 300, 26, 120, 210, 300}
    -- local yArr = {20, 20, 20, 20, 97, 97, 97, 97}

    if self.parentPetObj then 
        local ReincarntionLvParent = self.parentPetObj:getReincarntionLv()
        if ReincarntionLvParent > 0 then
            -- local detailConfig = ConfigManager:getAllPetReincarnationDataByID(ReincarntionLvParent)
            -- local addSkillNum = detailConfig.addSkillNum
            -- for i=1,addSkillNum do
            --     table.insert(idsParent, (#idsParent + i))
            -- end
            idsParent = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        end
    end

    if self.childPetObj then
        local ReincarntionLvChild = self.childPetObj:getReincarntionLv()
        if ReincarntionLvChild > 0 then
            -- local detailConfig = ConfigManager:getAllPetReincarnationDataByID(ReincarntionLvChild)
            -- local addSkillNum = detailConfig.addSkillNum
            -- for i=1,addSkillNum do
            --     table.insert(idsChild, (#idsChild + i))
            -- end
            idsChild = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        end
    end

    if self.petPutState == PET_PUT_STATE.DOUBLE then
        -- 获取传递宠物技能展示数据
        for k, v in ipairs(idsParent) do
            local oneSkill = {}
            oneSkill.idx = k
            oneSkill.isLock = false
            oneSkill.isUnkown = false

            if not self.parentPetObj then
                oneSkill.isUnkown = true
            else
                local cfgIdx = self.parentPetObj.isVariant and 2 or 1
                oneSkill.isLock = oneSkill.idx > self.parentPetObj.skillNum[cfgIdx]

                local allSkills = self.parentPetObj:getAllSkills()
                oneSkill.skill = allSkills[k] and allSkills[k] or nil
            end

            table.insert(parentSkillData, oneSkill)
        end

        -- 获取继承宠物技能展示数据
        for k, v in ipairs(idsChild) do
            local oneSkill = {}
            oneSkill.idx = k
            oneSkill.isLock = false
            oneSkill.isUnkown = false

            if not self.childPetObj then
                oneSkill.isUnkown = true
            else
                local cfgIdx = self.childPetObj.isVariant and 2 or 1
                oneSkill.isLock = oneSkill.idx > self.childPetObj.skillNum[cfgIdx]

                local allSkills = self.childPetObj:getAllSkills()
                oneSkill.skill = allSkills[k] and allSkills[k] or nil
            end

            table.insert(childSkillData, oneSkill)
        end
    end

    local curSkillInfo = {}
    local firstUnkownIndex = 0
    for k, v in ipairs(idsChild) do
        local oneSkill = {}
        oneSkill.isLock = false
        oneSkill.isUnkown = false
        oneSkill.skill = nil

        if (k == 8 or k == 9) and (self.petPutState == PET_PUT_STATE.SINGLE or self.petPutState == PET_PUT_STATE.DOUBLE) then
            -- 特质技能
            oneSkill.skill = k == 8 and self.childPetObj:getGiftedSkill() or self.childPetObj:getGiftedSkill2()
            if oneSkill.skill then
                oneSkill.isGiftSkill = true
            else
                oneSkill.isLock = true
            end
        elseif self.petPutState == PET_PUT_STATE.EMPTY then
            oneSkill.isUnkown = true

        elseif self.petPutState == PET_PUT_STATE.SINGLE then
            local cfgIdx = self.childPetObj.isVariant and 2 or 1
            oneSkill.isLock = k > self.childPetObj.skillNum[cfgIdx]

            local allSkills = self.childPetObj:getAllSkills()
            oneSkill.skill = allSkills[k] and allSkills[k] or nil

        elseif self.petPutState == PET_PUT_STATE.DOUBLE then
            if k > #parentSkillData then
                oneSkill.skill = nil
                oneSkill.isLock = childSkillData[k].isLock
            else
                if parentSkillData[k].skill then
                    oneSkill.skill = parentSkillData[k].skill
                elseif parentSkillData[k].isLock then
                    oneSkill.skill = childSkillData[k].skill
                    oneSkill.isLock = childSkillData[k].isLock
                else
                    oneSkill.skill = nil
                    oneSkill.isLock = childSkillData[k].isLock
                end

            end
        elseif self.petPutState == PET_PUT_STATE.OVER then
            local cfgIdx = self.showPetObj.isVariant and 2 or 1
            oneSkill.isLock = k > self.showPetObj.skillNum[cfgIdx]

            local allSkills = self.showPetObj:getAllSkills()
            oneSkill.skill = allSkills[k] and allSkills[k] or nil
        end

        -- 获取首个为空的技能槽位
        if firstUnkownIndex == 0 and not oneSkill.isLock and not oneSkill.skill then
            firstUnkownIndex = k
        end

        -- 遇到有技能的直接插入到空白槽位之前
        if firstUnkownIndex ~= 0 and oneSkill.skill and k ~= 8 then
            table.insert(curSkillInfo, firstUnkownIndex, oneSkill)
            firstUnkownIndex = firstUnkownIndex + 1
        else
            table.insert(curSkillInfo, oneSkill)
        end
    end

    for k, value in ipairs(curSkillInfo) do
        value.idx = k
        -- value.x = xArr[k]
        -- value.y = yArr[k]

        table.insert(skillData, value)
    end

    return skillData
end

function PetInheritView:showPutInEff()

    if self.playingEff then
        return
    end

    if not self or tolua.isnull(self) or not self:isVisible() then
        return
    end

    if self.petPutState == PET_PUT_STATE.DOUBLE then
        return
    end

    local putInEff = self.contentLayout:getChildByName("putInEff")
    if putInEff then
        return
    end

    putInEff = UI.Animation:create()
    putInEff:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1);
    putInEff:setName("putInEff")
    self.contentLayout:addChild(putInEff)

    if self.petPutState == PET_PUT_STATE.EMPTY or self.petPutState == PET_PUT_STATE.OVER then
        putInEff:leftUp(330, 78)
    elseif self.petPutState == PET_PUT_STATE.SINGLE then
        putInEff:leftUp(96, 78)
    end

    putInEff:setAnimation("start_square", false)
end

function PetInheritView:bindModel()

end

function PetInheritView:unbindModel()

end

return PetInheritView
