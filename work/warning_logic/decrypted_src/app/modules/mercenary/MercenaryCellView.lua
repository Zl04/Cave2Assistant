------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/04/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MercenaryCellView = class("MercenaryCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 476
local COM_HEIGHT = 106

function MercenaryCellView:ctor(mercenaryView)
    MercenaryCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._mercenaryView = mercenaryView
    self.skillIconArr = {}
    self:bindModel()
    self:init();
end

function MercenaryCellView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.mercenary", "Mercenary", false)
    MercenaryCellView.super.init(self, ... )
end

function MercenaryCellView:dtor()
    MercenaryCellView.super.dtor(self)
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.mercenary.MercenaryCellView")
    reload_script_file("app.modules.mercenary.MercenaryCellView")
    -- print("MercenaryCellView:dtor")
end

function MercenaryCellView:onInitView()
    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:center()
    rootLayout:setSize(COM_WIDTH, COM_HEIGHT)
    -- rootLayout:enableDebugDraw()
    self:addChild(rootLayout)
    self._rootLayout = rootLayout

    local bgImage = UI.Image:create()
    bgImage:init("ui_mercenary_floor.png")
    bgImage:center()
    rootLayout:addChild(bgImage)

    -- 头像
    local headLayout = UI.Layout:create()
    headLayout:init()
    headLayout:centerLeft(58)
    rootLayout:addChild(headLayout)

    local headBg = UI.Image:create()
    headBg:init("ui_playerstate_me_black_down01.png")
    headBg:center()
    headLayout:addChild(headBg)
    headBg:setTouchEnable(true)
    headBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        -- 获取详情
        if(self._data and self._data.baseData) then
            Net.NetRoleSystem:heroDetailRequest(self._data.baseData.pk, nil,nil,nil,nil, true)
        end
    end)
    self._headBg = headBg

    local kuangImage = UI.Image:create()
    kuangImage:init("ui_playerstate_me_black_03.png")
    kuangImage:center()
    headBg:addChild(kuangImage, 2)
    self.kuangImage = kuangImage
    

    self._waitingHeadImage = UI.Image:create()
    self._waitingHeadImage:init("ui_playerstate_teammate_wait.png")
    self._waitingHeadImage:center()
    headBg:addChild(self._waitingHeadImage)

    -- 等级背景图
    local levelBg = UI.Image:create()
    levelBg:init("ui_playerstate_pet_grade.png")
    levelBg:leftBottom(0, 6)
    headBg:addChild(levelBg, 5)
    self._levelBg = levelBg

    -- 等级
    self._lvLabel = UI.Text:create()
    self._lvLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:centerLeft(-36)
    self._lvLabel:setTextCenter()
    levelBg:addChild(self._lvLabel, 10)

    -- 武器类型
    self._equipmentType = UI.Image:create()
    self._equipmentType:init("icon-equip_small1_21080010_1.png")
    self._equipmentType:leftUp(61, 8)
    headBg:addChild(self._equipmentType, 10)


    -- 玩家名字
    self._roleName = UI.Text:create()
    self._roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_44)
    self._roleName:leftUp(108, 9)
    rootLayout:addChild(self._roleName)

    -- 星级分数图标
    self._equipmentStarIcon = UI.Image:create()
    self._equipmentStarIcon:init("symbol_character_hero_power.png")
    self._equipmentStarIcon:leftUp(274, 11)
    self:addChild(self._equipmentStarIcon)

    -- 星级分数文本
    self._equipmetScore = UI.Text:create()
    self._equipmetScore:init("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_211_124)
    self._equipmetScore:centerLeft(25)
    self._equipmentStarIcon:addChild(self._equipmetScore)

    -- 技能图标列表

    -- 选择按钮
    local choiceButton  = UI.Button:create()
    choiceButton:init("ui_mercenary_btn_selected.png", "ui_mercenary_btn_selected.png", "ui_mercenary_btn_selected.png")
    choiceButton:centerRight(10)
    choiceButton:setInterval(1)
    self._choiceButton = choiceButton
    choiceButton:setVisible(false)
    choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self._mercenaryView:choiceMercenaryData(self._data)
    end)
    choiceButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1170105)
    end)
    rootLayout:addChild(choiceButton, 100)

    self._choiceFlag = UI.Image:create()
    self._choiceFlag:init("ui_mercenary_selected.png")
    self._choiceFlag:center()
    rootLayout:addChild(self._choiceFlag, 100)
    self._choiceFlag:setVisible(false)

    self:reload(self._data)
end

function MercenaryCellView:reload(data, choicePK)
    if(data) then 
        self._data = data
        self._choicePK = choicePK
        -- print("MercenaryCellView:reload", data, self._choicePK)

        local mercenaryBaseData = data.baseData
        if(mercenaryBaseData == nil) then 
            return
        end
    -- required uint64                 pk = 1;                 // 佣兵玩家PK
    -- required string                 name = 2;               // 名字
    -- required uint32                 level = 3;              // 等级
    -- required uint32                 job = 4;                // 职业
    -- required uint32                 faceDecodeId = 5;       // 头像
    -- repeated MercenaryEquipData     equips = 6;             // 装备ID（用于显示玩家形象）
    -- repeated uint32                 skills = 7;             // 技能列表
    -- optional uint32                 sex = 8;
    -- optional uint32                 looks = 9;              // 外观
        local job = mercenaryBaseData.job
        if job == 0 or job == nil then
            self._equipmentType:hide()
        else
            self._equipmentType:show()
            self._equipmentType:setSpriteName("icon-equip_small1_21080010_" .. job .. ".png")
        end
        local showLV = RoleDataManager:getUIShowLvByOtherData(mercenaryBaseData.level, mercenaryBaseData.reincarnationLevel)
        self._roleName:setText(mercenaryBaseData.name)
        self._lvLabel:setText(showLV)
        self._equipmetScore:setText(AvalonUtil:getSimpleNumber(mercenaryBaseData.equipScore, 5))
        -- self._equipmetScore:setText(AvalonUtil:getSimpleNumber(923444455, 5))

        if mercenaryBaseData.reincarnationLevel > 0 then
            local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(mercenaryBaseData.reincarnationLevel)
            self.kuangImage:setSpriteName(headFrame)
            self._levelBg:setSpriteName(levelFrame)
        end
        self:refreshChoiceStatus()

        -- 先把所有的技能图标给隐藏
        if(self.skillIconArr) then 
            for k,skillIcon in ipairs(self.skillIconArr) do 
                skillIcon:setVisible(false)
            end
        end
        -- 根据情况显示技能图标
        local skillX = 60
        for k,skillGroupID in ipairs(mercenaryBaseData.skillGroups) do 
            if(k>5) then
                break
            end
            local master = RoleDataManager:getMaster()
            -- local mode = master:getIsReincarntion() and SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION or RoleDataManager:getMasterSkillTreeModel()
            local mode = RoleDataManager:getReincarntionSkillModeByOtherReinLv(mercenaryBaseData.reincarnationLevel)
            local skillTree = ConfigManager:getSkillTreeConfigById(mode, skillGroupID)
            if(skillTree and skillTree.skillIDList and #skillTree.skillIDList > 0) then 
                local skillID = skillTree.skillIDList[1]
                local skillConfig = ConfigManager:getSkillConfigById(skillID)
                if(skillConfig) then
                    local skillImage = nil
                    if(not self.skillIconArr[k]) then 
                        skillImage = UI.Image:create()
                        skillImage:setScale(0.6)
                        skillImage:init("ui_btn_gaming_battleskill_01.png")
                        skillImage:leftBottom(88 + skillX*(k - 1), -13)
                        skillImage:setVisible(false)
                        -- skillImage:enableDebugDraw()

                        local skillIconImage = UI.Image:create()
                        skillIconImage:init("ui_btn_gaming_battleskill_01.png")
                        skillIconImage:center()
                        skillImage:addChild(skillIconImage)
                        skillImage.skillIconImage = skillIconImage

                        -- 
                        self._rootLayout:addChild(skillImage)
                        self.skillIconArr[k] = skillImage
                    else
                        skillImage = self.skillIconArr[k]
                    end
                    -- print("skillConfig.iconID=", skillConfig.iconID)
                    if(skillConfig.iconID and skillConfig.iconID ~= "") then
                        skillImage.skillIconImage:setSpriteName(skillConfig.iconID)
                        skillImage:setVisible(true)
                    else
                        
                    end
                end
            end
        end

        if(data.wearEquipmentArr == nil) then
            data.wearEquipmentArr = {}
            for k,v in ipairs(mercenaryBaseData.equips) do 
                local goodsData = GoodsDataManager:createEquipmentForEquipmentID(v.id)
                if(goodsData) then 
                    goodsData:setWearPosition(v.index)
                    goodsData:setIllusionID(v.illusion)
                    table.insert(data.wearEquipmentArr, goodsData)
                end
            end
        end

        self._waitingHeadImage:setVisible(true)
        local heroData = Data.HeroData:create()
        heroData:setSex(mercenaryBaseData.sex)
        heroData:setFaceDecodeID(mercenaryBaseData.faceDecodeId)
        heroData:setLooks(mercenaryBaseData.looks)
        Avalon.WidgetUtil:getHead(
            UI.UIManager:getRootNode(),
            heroData,
            data.wearEquipmentArr,
            self,
            handler(
                self,
                function(self, pic)
                    if self and not tolua.isnull(self) then
                        self._waitingHeadImage:setVisible(false)
                        self._headBg:removeChildByName("heorIcon", true)
                        pic:setPosition(46, 46)
                        pic:setName("heorIcon")
                        self._headBg:addChild(pic, 1)
                    end
                end
            ),
            true
        )
    end
end

function MercenaryCellView:refreshChoiceStatus()
    if(self._data) then 
        if(self._data.baseData.pk == self._choicePK) then 
            self._choiceFlag:setVisible(true)
            self._choiceButton:setVisible(false)
        else
            self._choiceFlag:setVisible(false)
            self._choiceButton:setVisible(true)
        end
    end
end

function MercenaryCellView:bindModel()

end


function MercenaryCellView:unbindModel()

end

return MercenaryCellView
