------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/2/2
--desc	: 宠物学习技能面板
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkillLearnLayer = class("PetSkillLearnLayer", UI.BaseWin)

require "app.ui.baglayer.Horcurx.SkillTips"
require "app.modules.petreincarnation.PetSkillTableView"

UI = UI or {}

UI.PetSkillLearnLayer = PetSkillLearnLayer

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetSkillLearnLayer:ctor()
    PetSkillLearnLayer.super.ctor(
    	self,
    	UI.Type.PET_LEARN_SKILL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.tableviewSize = {width = 380, height = 163}
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)
end

-- isOther用来判断是否是别人的宠物
-- 如果为true 第一个参数传的是别人的宠物数据，如果为false 第一个参数传的是自己的宠物ID
function PetSkillLearnLayer:init(petID, inputInnerTabIdx, isOther, offsetY, ... )
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        if petID then
            self.curPet = MasterDataManager:getBagPetById(petID)
        else
            self.curPet = nil
        end
    end
    self.offsetY = offsetY or 0

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSkillLearnLayer.super.init(self, ... )
end

function PetSkillLearnLayer:dtor()
    PetSkillLearnLayer.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.updateLayer)

    reload_script_file_mvc("app.modules.pet.PetSkillLearnLayer")
end

function PetSkillLearnLayer:onInitView()
    self.skillObjs = {}
    self.curSelectIdx = 0
    self.lastSelectIdx = 0

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local skillLayout = UI.Layout:create();
    skillLayout:init()
    skillLayout:setSize(COM_WIDTH, COM_HEIGHT)
    skillLayout:center()
    -- skillLayout:enableDebugDraw()
    contentLayout:addChild(skillLayout)
    self.skillLayout = skillLayout

    self:updateLayer()
    self:showLearnSkill()
end

function PetSkillLearnLayer:updateToShow(petID, isOther, offsetY, ... )
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = petID
    else
        if petID then
            self.curPet = MasterDataManager:getBagPetById(petID)
        else
            self.curPet = nil
        end
    end
    self.offsetY = offsetY or 0

    self:updateLayer()
end

function PetSkillLearnLayer:updateLayer(petListIdx)
    if petListIdx and petListIdx > 0 then
        self.curPet = MasterDataManager:getBagPets()[petListIdx]
    end

    self.skillLayout:removeAllChildren()
    self.skillObjs = {}

    performWithDelay(self, function()
        -- 技能
        self:assembleSkill()

        for k, v in ipairs(self.skillData) do
            local oneSkill = self:addOneSkill(v)
            --self.skillLayout:addChild(oneSkill)

            table.insert(self.skillObjs, oneSkill)
        end


        local petId = nil
        if self.curPet then
           petId = self.curPet:getId()
           local reincarntionLv = self.curPet:getReincarntionLv()
            if reincarntionLv > 0 or self.curPet.petquality == PublicDefine.PetQualityType.Platinum then
                local tableViewBg = UI.Image:create()
                tableViewBg:init("ui_pets_optimization_bg_2.png")
                tableViewBg:center(0, -160)
                self.skillLayout:addChild(tableViewBg, 1)

                local tableViewBottom = UI.Image:create()
                tableViewBottom:init("ui_pets_optimization_up.png")
                tableViewBottom:center(0, -96)
                self.skillLayout:addChild(tableViewBottom, 3)

                self.tableviewSize.height = 130
            end
        end

        local PetSkillTableView = UI.PetSkillTableView:create()
        PetSkillTableView:init(petId)
        PetSkillTableView:leftUp(30, -400)
        self.skillLayout:addChild(PetSkillTableView, 2)
        PetSkillTableView:setTableViewSize(self.tableviewSize)
        PetSkillTableView:updateSkillList(self.skillData)
        self.PetSkillTableView = PetSkillTableView

    end, 0)
end

function PetSkillLearnLayer:assembleSkill()
    self.skillData = {}

    local offsetX = 20
    local offsetY = 40
    local ids = {1, 2, 3, 4, 5, 6, 7, 8}
    -- local xArr = {26, 120, 210, 300, 26, 120, 210, 300}
    -- local yArr = {20, 20, 20, 20, 97, 97, 97, 97}

    if self.curPet then
        local ReincarntionLv = self.curPet:getReincarntionLv()
        if ReincarntionLv > 0 or self.curPet.petquality == PublicDefine.PetQualityType.Platinum then
            local detailConfig = ConfigManager:getAllPetReincarnationDataByID(ReincarntionLv)
            local addSkillNum = detailConfig.addSkillNum
            -- for i=1,addSkillNum do
            --     table.insert(ids, (#ids + i))
            -- end
            ids = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        end
    end

    for k, v in ipairs(ids) do
        local oneSkill = {}
        oneSkill.idx = k
        -- oneSkill.x = xArr[k]+offsetX
        -- oneSkill.y = yArr[k]+offsetY
        oneSkill.isLock = false
        oneSkill.isUnkown = false
        oneSkill.isGiftSkill = false
        oneSkill.skill = nil

        if not self.curPet then
            oneSkill.isUnkown = true
        else
            if k == 8 or k == 9 then
                -- 特质技能
                oneSkill.skill = k == 8 and self.curPet:getGiftedSkill() or self.curPet:getGiftedSkill2()
                if oneSkill.skill then
                    oneSkill.isGiftSkill = true
                else
                    oneSkill.isLock = true
                end
            else
                local cfgIdx = self.curPet.isVariant and 2 or 1
                oneSkill.isLock = oneSkill.idx > self.curPet.skillNum[cfgIdx]

                local allSkills = self.curPet:getAllSkills()
                oneSkill.skill = allSkills[k] or nil
            end
        end

        table.insert(self.skillData, oneSkill)
    end
end

function PetSkillLearnLayer:addOneSkill(data)
    local skillLayer = UI.Layout:create()
    skillLayer:init()
    skillLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)

    local skillBG  = UI.Image:create()
    -- 不知道的技能（宠物继承使用）
    if data.isUnkown then
        skillBG:init("ui_pets_skill_box_unkown.png")
        skillBG:center()
        skillLayer:addChild(skillBG)
        return skillLayer
    end

    -- 是否被锁住的技能格子（模版技能数量）
    if data.isLock then
        skillBG:init("ui_pets_skill_box_lock.png")
        skillBG:center()
        skillLayer:addChild(skillBG)
        return skillLayer
    end

    if not data.skill then
        skillBG:init("ui_pets_skill_box.png");
        skillBG:center();
        skillBG:setTouchEnable(true)
        skillBG:setSwallowTouches(true)
        skillBG:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, UI.TEXT_1213729)
        end)
        skillBG:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)
        skillLayer:addChild(skillBG);
        return skillLayer
    end

    local selectEff = UI.Animation:create()
    -- 特质技能有特殊点击动效
    if data.isGiftSkill then
        selectEff:init("effect_ui_town_pet_skill_slot3.json", "effect_ui_town_pet_skill_slot3.atlas", 1)
    else
        selectEff:init("effect_ui_town_pet_skill_slot1.json", "effect_ui_town_pet_skill_slot1.atlas", 1)
    end
    selectEff:leftBottom(30, 32)
    selectEff:hide()
    selectEff:setName("Select")
    skillLayer:addChild(selectEff, 100)
    if data.isGiftSkill then
        skillBG:init("ui_pets_skill_box_pvp.png")
        skillBG:setImageScale(0.8)
    else
        skillBG:init("ui_pets_skill_box.png")
    end
    skillBG:center();
    skillLayer:addChild(skillBG);
    skillLayer:setTouchEnable(true)
    skillLayer:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self)
        self:skillClick(data.idx)
    end)

    local skillIcon = UI.Image:create()
    local skillCfg = ConfigManager:getSkillConfigById(data.skill)
    skillIcon:init(skillCfg.iconID)
    skillIcon:setImageScale(0.8)
    skillIcon:center()
    skillLayer:addChild(skillIcon)

    local skillData = SkillDataManager:createSkillForSkillId(skillCfg.skillID)
    if skillData:isActive() and not data.isGiftSkill then
        local ring  = UI.Image:create();
        ring:init("ui_information_headframe_box2.png");
        ring:setScaleX(0.8)
        ring:setScaleY(0.8)
        ring:center();
        skillLayer:addChild(ring, 0);
    end

    return skillLayer
end



function PetSkillLearnLayer:skillClick(idx)
    -- TODO:广播点击消息

    local curSkillObj = self.skillObjs[idx]
    if not curSkillObj then
        return
    end

    local select = curSkillObj:getChildByName("Select")
    if not select then
        return
    end

    self.curSelectIdx = idx

    local curData = self.skillData[self.curSelectIdx]
    local skillData = Data.SkillData:create(curData.skill)
    -- print("PetSkillLearnLayer ", curData.skill)
    if(self.curPet and self.curPet.isFight and self.curPet:isFight()) then 
        local petData = MasterDataManager:getFightPetbyId(self.curPet.spriteID) or RoleDataManager:getFightPetbyId(self.curPet.spriteID)
        if petData then 
            if petData:getSiteId() == 0 then
                skillData:setIsPetActive(true)
            end
        end
        -- print("PetSkillLearnLayer 2", curData.skill)
    end

    local tip = UI.SkillTips:create(skillData, 3)
    local viewWidth, viewHeight = tip:getSize()
    tip:leftBottom(- (viewWidth + 28), -42 + self.offsetY)
    tip:init()
    self:addChild(tip, 1000)

    select:show()
    select:setAnimation("trigger", false)
    select:addAnimation("idle", true)

    if self.curSelectIdx~= self.lastSelectIdx and self.skillObjs[self.lastSelectIdx] then
        local lastSelect = self.skillObjs[self.lastSelectIdx]:getChildByName("Select")
        if lastSelect then
            lastSelect:hide()
        end
    end

    self.lastSelectIdx = self.curSelectIdx
end

-- 根据传入的技能数据直接进行更新
function PetSkillLearnLayer:updateLayerByData(data)
    self.curPet = nil
    self.skillData = data

    self.skillLayout:removeAllChildren()
    self.skillObjs = {}

    performWithDelay(self, function()
        for k, v in ipairs(self.skillData) do
            local oneSkill = self:addOneSkill(v)
            --self.skillLayout:addChild(oneSkill)

            table.insert(self.skillObjs, oneSkill)
        end

        local petId = nil
        local reincarntionLv = self.curPet:getReincarntionLv()
        if #self.skillData > 8 then
            -- 技能数大于8代表是转生了的宠物
            local tableViewBg = UI.Image:create()
            tableViewBg:init("ui_pets_optimization_bg_2.png")
            tableViewBg:center(0, -160)
            self.skillLayout:addChild(tableViewBg, 1)

            local tableViewBottom = UI.Image:create()
            tableViewBottom:init("ui_pets_optimization_up.png")
            tableViewBottom:center(0, -96)
            self.skillLayout:addChild(tableViewBottom, 3)

            self.tableviewSize.height = 130
        end

        local PetSkillTableView = UI.PetSkillTableView:create()
        PetSkillTableView:init(petId)
        PetSkillTableView:leftUp(30, -395)
        self.skillLayout:addChild(PetSkillTableView, 1)
        PetSkillTableView:setTableViewSize(self.tableviewSize)
        PetSkillTableView:updateSkillList(self.skillData)
        self.PetSkillTableView = PetSkillTableView
    end, 0)
end

-- 学习技能
function PetSkillLearnLayer:showLearnSkill()

    -- if not self.learnSkillLayer then
    --     local learnSkillLayer = UI.Layout:create();
    --     learnSkillLayer:init()
    --     learnSkillLayer:setSize(386, 436)
    --     learnSkillLayer:centerBottom(0)
    --     self.contentLayout:addChild(learnSkillLayer, 2)
    --     self.learnSkillLayer = learnSkillLayer
    -- end

    -- 技能书
    local skillListLayer = self.contentLayout:getChildByName("SkillListLayer")
    if not skillListLayer then
        skillListLayer = UI.Layout:create();
        skillListLayer:init()
        skillListLayer:setSize(390, 268)
        skillListLayer:centerBottom(20)
        skillListLayer:setName("SkillListLayer")
        self.contentLayout:addChild(skillListLayer)
    end
    
    -- TIP
    local tipLayer = skillListLayer:getChildByName("TipLayer")
    if not tipLayer then
        tipLayer = UI.Layout:create();
        tipLayer:init()
        tipLayer:setSize(390, 30)
        tipLayer:centerUp(0)
        -- skillListLayer:enableDebugDraw()
        tipLayer:setName("TipLayer")
        skillListLayer:addChild(tipLayer)
    end

    local tipInnerLayout = tipLayer:getChildByName("TipInnerLayout")
    if not tipInnerLayout then
        tipInnerLayout = UI.Layout:create();
        tipInnerLayout:init()
        tipInnerLayout:center()
        tipInnerLayout:enableAutoWidth()
        tipInnerLayout:enableAutoHeight()
        tipInnerLayout:setName("TipInnerLayout")
        tipLayer:addChild(tipInnerLayout)

        local tipIcon  = UI.Image:create();
        tipIcon:init("ui_information_reminder.png");
        tipIcon:floatLeft(0);
        tipInnerLayout:setName("TipInnerLayout")
        tipInnerLayout:addComponent(tipIcon)

        local tipText = UI.Text:create()
        tipText:init(UI.TEXT_1213676, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
        tipText:floatLeft(4)
        tipText:setName("TipText")
        tipInnerLayout:addComponent(tipText)
        local w = tipText:getContentSize().width
        if w > 360 then
            tipText:setWidth(360)
            tipText:setTextCenter()
            tipText:autoAdapt()
            tipText:setLineSpacing(-6)
        end
        tipText:floatLeft(4)
    end

    -- Title
    local titleBG = skillListLayer:getChildByName("TitleBG")
    if not titleBG then
        titleBG  = UI.Image:create();
        titleBG:init("ui_choice_title_2.png");
        titleBG:centerUp(38);
        titleBG:setName("TitleBG")
        skillListLayer:addChild(titleBG)
    end

    local titleText = titleBG:getChildByName("TitleText")
    if not titleText then
        titleText = UI.Text:create()
        titleText:init(UI.TEXT_1213677, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_202_168_128)
        titleText:center()
        titleText:setName("TitleText")
        titleBG:addChild(titleText)
    end

    local listBG = skillListLayer:getChildByName("ListBG")
    if not listBG then
        listBG = UI.Image:create();
        listBG:init("ui_pets_skill_rightpage.png");
        listBG:centerBottom(0);
        listBG:setName("ListBG")
        skillListLayer:addChild(listBG)
    end

    -- 技能书列表
    if not self.skillbookList and tolua.isnull(self.skillbookList) then
        local gridList = UI.GridList:create()
        gridList:init(UI.PetTrainSkillBookCell, 5, 5, 76, 76, 0, 0, 0)
        gridList:setSize(380, 177)
        gridList:leftBottom(-11, 0)
        gridList:disableToDragGrid()
        gridList:setCallbackForGridClick(self, self.cellClickCallback)
        gridList:setScrollBarEnabled(false)
        gridList:setCircleVisible(false)
        self.skillbookList = gridList
        skillListLayer:addChild(self.skillbookList)
    end
    self.skillbookList:setData(self:getBookList())

    local mask = skillListLayer:getChildByName("Mask")
    if not mask then
        mask  = UI.Image:create()
        mask:init("ui_pets_mask_2.png")
        mask:centerBottom(0)
        mask:setName("Mask")
        skillListLayer:addChild(mask)
    end
end

function PetSkillLearnLayer:getBookList()
    local bookList = {}
    local allBooks = mvc.petModel:getAllSkillBooks()
    for k, v in ipairs(allBooks) do
        table.insert(bookList, v)
    end

    local emptyCount = math.max(0, 15 - #bookList)
    for i = 1, emptyCount do
        table.insert(bookList, {emptySlot = true})
    end

    return bookList
end

function PetSkillLearnLayer:cellClickCallback(grid)
    local bookData = grid:getData()
    if bookData.emptySlot then
        return
    end

    if self and not tolua.isnull(self) and self.lastGrid and not tolua.isnull(self.lastGrid) then
        self.lastGrid:clearSelect()
    end

    if (not tolua.isnull(self.materialInfo)) then
        self.materialInfo:close()
        self.materialInfo = nil
    end

    -- 技能书tips
    materialInfo = UI.PetSkillBookInfoArea:create()
    materialInfo:init(false, self.curPet:getId())
    materialInfo:leftBottom(-306, 26)
    self.contentLayout:addChild(materialInfo,9999)
    self.materialInfo = materialInfo
    materialInfo:setGoodsGrid(grid)
    materialInfo:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, grid, touchPosition)
        print("onMaterialInfoAreaTouchHandler")

        if grid:getGoodsGrid() ~= nil and not tolua.isnull(grid:getGoodsGrid()) then
            local point  = grid:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
            local rect = cc.rect(point.x , point.y , grid:getGoodsGrid()._width,grid:getGoodsGrid()._height) 
            if cc.rectContainsPoint(rect, touchPosition) then
                grid:setInterceptTouches(false)
            end
        end
    
        if self.materialInfo and (not tolua.isnull(self.materialInfo)) then
            self.materialInfo:close()
        end
        self.materialInfo = nil
    end)
    materialInfo:updateView(grid:getData())

    grid:cellClick()
    self.lastGrid = grid

end


function PetSkillLearnLayer:selectPetUpdate(petListIdx)
    self.curPet = MasterDataManager:getBagPets()[petListIdx]

    self:updateToShow(self.curPet:getId(), false, 195)

    performWithDelay(self, function()
        self:showLearnSkill()
    end, 0)
    -- if self.skillbookList then
    --     self.skillbookList:setData(self:getBookList())
    -- end
end

function PetSkillLearnLayer:updateSkillLearnLayer()

    self:updateToShow(self.curPet:getId(), false, 195)
    -- self:showLearnSkill()
    performWithDelay(self, function()
        self:showLearnSkill()
    end, 0)
    -- if self.skillbookList then
    --     self.skillbookList:setData(self:getBookList())
    -- end
end

-- 根据传入的技能数据直接进行更新
function PetSkillLearnLayer:setTableViewSize(tableviewSize)
    self.tableviewSize = tableviewSize
end

function PetSkillLearnLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.updateSkillLearnLayer)
end

function PetSkillLearnLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SELECT_CELL_UPDATE, self, self.selectPetUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_LEARN_SKILL_OK, self, self.updateSkillLearnLayer)
end

return PetSkillLearnLayer
