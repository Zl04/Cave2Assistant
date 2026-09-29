------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/2/2
--desc	: 宠物资质加点
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAddTalentPointLayer = class("PetAddTalentPointLayer", UI.BaseWin)

local SceneManager = require("app.game.SceneManager")

require "app.ui.baglayer.Horcurx.SkillTips"
require "app.modules.pet.PetAddTalentPointDesTipsView"

UI = UI or {}

UI.PetAddTalentPointLayer = PetAddTalentPointLayer

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 426
local COM_HEIGHT = 436

local index2PetTalentType = {
    [1] = PublicDefine.PetTalentType.TPhysicAtk,
    [2] = PublicDefine.PetTalentType.TMagicAtk,
    [3] = PublicDefine.PetTalentType.TElement,
    [4] = PublicDefine.PetTalentType.TLife,
    [5] = PublicDefine.PetTalentType.TPhysicDef,
    [6] = PublicDefine.PetTalentType.TMagicDef,
    [7] = PublicDefine.PetTalentType.TResist
}

function PetAddTalentPointLayer:ctor(petID)
    PetAddTalentPointLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.curPet = MasterDataManager:getBagPetById(petID)
end

function PetAddTalentPointLayer:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetAddTalentPointLayer.super.init(self, ... )
end

function PetAddTalentPointLayer:dtor()
    PetAddTalentPointLayer.super.dtor(self)
    self:unbindModel()


    reload_script_file_mvc("app.modules.pet.PetAddTalentPointLayer")
end

function PetAddTalentPointLayer:onInitView()
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

    self:updateLayer()
    
end

function PetAddTalentPointLayer:updateToShow(petID, isOther, offsetY, ... )
    self.isOther = isOther or false
    if self.isOther then
        self.curPet = MasterDataManager:getBagPetById(petID)
    else
        if self.curPet then
            self.curPet = MasterDataManager:getBagPetById(petID)
        else
            self.curPet = nil
        end
    end
    -- self.offsetY = offsetY or 0

    self:updateLayer(petID)
end

function PetAddTalentPointLayer:updateLayer(petID)
    if self.curPet and petID and petID == self.curPet:getId() then
        self.curPet = MasterDataManager:getBagPetById(petID)
    end

    self:showRaiseQuality()
    -- performWithDelay(self, function()
    --     self:showRaiseQuality()
    -- end, 0.1)
end

-- 资质加点
function PetAddTalentPointLayer:showRaiseQuality()
    self.raiseCellSelectTab = {}
    self.curSelectQualityRaise = 1

    if not self.raiseQualityLayer then
        local raiseQualityLayer = UI.Layout:create();
        raiseQualityLayer:init()
        raiseQualityLayer:setSize(386, 436)
        raiseQualityLayer:centerBottom(0)
        self.contentLayout:addChild(raiseQualityLayer, 2)
        self.raiseQualityLayer = raiseQualityLayer
    end

    self:assembleQuality()

    for k, v in ipairs(self.qualityData) do
        self:composeQualityLayer(v)
    end

    -- if not self.qualityPillName then
    --     local pillName = UI.Text:create()
    --     pillName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    --     pillName:leftBottom(74, 40)
    --     pillName:setWidth(160)
    --     pillName:setTextLeft()
    --     pillName:autoAdapt()
    --     pillName:setLineSpacing(-6)
    --     self.raiseQualityLayer:addChild(pillName)
    --     self.qualityPillName = pillName
    -- end

    -- if not self.qualityPillDesc then
    --     local qualityDesc = UI.Text:create()
    --     qualityDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    --     qualityDesc:setWidth(160)
    --     qualityDesc:setTextLeft()
    --     qualityDesc:autoAdapt()
    --     qualityDesc:setLineSpacing(-6)
    --     qualityDesc:leftBottom(74, 6)
    --     self.raiseQualityLayer:addChild(qualityDesc)
    --     self.qualityPillDesc = qualityDesc
    -- end

    -- self:updateQualityPillShow()

    -- self:qualityRaiseCellClick(self.curSelectQualityRaise)
    -- local addPointConsumeItemId = 22072480
    -- local itemData = ConfigManager:getMaterialConfigByID(addPointConsumeItemId) --or ConfigManager:getVirtualItemConfigByID(addPointConsumeItemId)
    -- local curExtraTalent = self.curPet:getExtraTalentPoint(index2PetTalentType[data.idx]) --当前资质已加点数量
    local usedTalentPoint = self.curPet:getUsedTalentPoint()    --已使用资质点数量
    local usedTalentMaterialNum = self.curPet:getTalentPointItemUsed() --已使用资质丹数量
    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    -- local talentPointsMax = petCfg.talentPointsMax --资质加点上限
    local talentMaterialMax = mvc.petModel:getPetTalentMaterialMax(petCfg, self.curPet:getLevel()) --资质丹使用上限
    local totalTalentPointNum = mvc.petModel:getPetTalentPoint(petCfg, self.curPet:getLevel()) --当前等级资质点获得数量
    local leftTalentPointNum = totalTalentPointNum - usedTalentPoint --当前剩余资质点数量
    -- local leftTalentMaterialCanUseNum = talentMaterialMax - usedTalentMaterialNum --当前剩余可使用资质丹数量 = 资质丹使用上限-已使用资质丹数量
    -- local canAddTalentPointNum = talentPointsMax - curExtraTalent   --当前资质可加点数 = 资质加点上限-当前资质已加点数量

    local desX = -5
    local leftTalentPointDescView = self.raiseQualityLayer:getChildByName("leftTalentPointDesc")
    if leftTalentPointDescView then
        leftTalentPointDescView:removeFromParent(true)
        leftTalentPointDescView = nil
    end 
    if not leftTalentPointDescView then
        local leftTalentPointDesc = UI.Text:create()
        leftTalentPointDesc:init(string.format(UI.TEXT_224003,leftTalentPointNum), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_45_45_45)
        -- leftTalentPointDesc:setWidth(160)
        leftTalentPointDesc:setTextLeft()
        leftTalentPointDesc:autoAdapt()
        leftTalentPointDesc:setLineSpacing(-6)
        leftTalentPointDesc:leftBottom(desX, 45)
        leftTalentPointDesc:setName("leftTalentPointDesc")
        self.raiseQualityLayer:addChild(leftTalentPointDesc)
        self.leftTalentPointDesc = leftTalentPointDesc
    end

    local leftTalentMaterialCanUseDesView = self.raiseQualityLayer:getChildByName("leftTalentMaterialCanUseDes")
    if leftTalentMaterialCanUseDesView then
        leftTalentMaterialCanUseDesView:removeFromParent(true)
        leftTalentMaterialCanUseDesView = nil
    end 
    if not leftTalentMaterialCanUseDesView then
        local str = usedTalentMaterialNum.."/"..talentMaterialMax
        local leftTalentMaterialCanUseDes = UI.Text:create()
        leftTalentMaterialCanUseDes:init(string.format(UI.TEXT_224004, str), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_45_45_45)
        -- leftTalentMaterialCanUseDes:setWidth(180)
        leftTalentMaterialCanUseDes:setTextLeft()
        leftTalentMaterialCanUseDes:autoAdapt()
        leftTalentMaterialCanUseDes:setLineSpacing(-6)
        leftTalentMaterialCanUseDes:leftBottom(desX, 15)
        leftTalentMaterialCanUseDes:setName("leftTalentMaterialCanUseDes")
        self.raiseQualityLayer:addChild(leftTalentMaterialCanUseDes)
        self.qualityPillDesc = leftTalentMaterialCanUseDes

        local tipsBtn = self.raiseQualityLayer:getChildByName("tipsBtn")
        if tipsBtn then
            tipsBtn:removeFromParent(true)
            tipsBtn = nil
        end 
        if not tipsBtn or tolua.isnull(tipsBtn) then
            tipsBtn = UI.Button:create();
            tipsBtn:init("ui_shopping_banner_prompt.png","ui_shopping_banner_prompt.png","ui_shopping_banner_prompt.png");
            tipsBtn:leftBottom(desX+leftTalentMaterialCanUseDes:getContentSize().width+5, 17)
            tipsBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            tipsBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
                -- local talentPointsMax = petCfg.talentPointsMax --资质加点上限
                local talentMaterialMax = mvc.petModel:getPetTalentMaterialMax(petCfg, self.curPet:getLevel()) --资质丹使用上限
                local data = {}
                data.str = str
                local config = petCfg
                local petAddTalentPointDesTipsView = UI.PetAddTalentPointDesTipsView:create(data, config)
                petAddTalentPointDesTipsView:init()
                petAddTalentPointDesTipsView:centerLeft(-230, -30)
                self.contentLayout:addChild(petAddTalentPointDesTipsView, 500)
            end)
            tipsBtn:setName("tipsBtn")
            self.raiseQualityLayer:addChild(tipsBtn)
        end
    end
    
    local resetItemStr = ConfigManager:getGeneralForKey("talentPointsReset")
    local resetItemData = string.split(resetItemStr, ",")
    local itemId = tonumber(resetItemData[1])
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, itemId)

    -- 使用按钮
    local useBtn = self.raiseQualityLayer:getChildByName("useBtn")
    if useBtn then
        useBtn:removeFromParent(true)
        useBtn = nil
    end
    if not useBtn then
        useBtn = UI.Button:create();
        useBtn:init("ui_pets_optimization_btn.png","ui_pets_optimization_btn.png","ui_pets_optimization_btn.png");
        useBtn:rightBottom(0, 18);
        useBtn:setText(UI.TEXT_224002)
        useBtn:setTextOffset(-20, 0)
        useBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            -- if SceneManager:getInstance():isInFightScene() then
            --     UI.ScrollBar:createByText(UI.TEXT_1213665)
            --     return
            -- end

            if itemTotalNum == 0 then
                UI.ScrollBar:createByText(UI.TEXT_224010)
                return
            end

            if usedTalentPoint == 0 then
                return
            end

            Net.NetPetSystem:petResetTalentPoint(self.curPet:getId())
        end)
        useBtn:setName("useBtn")
        self.raiseQualityLayer:addChild(useBtn)

        

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:centerRight(-8)
        local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
        goodsData:setNum(0)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false
        goodsGrid:init(goodsData)
        if (num == 0) then
            goodsGrid:hideCountLabel()
        end
        goodsGrid:hideBG()
        goodsGrid:hideRare()
        goodsGrid:setScale(0.6)
        useBtn:addChild(goodsGrid, 300)

        local itemNum = UI.Text:create()
        itemNum:init(tostring(itemTotalNum), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_209_209_209)
        itemNum:centerRight(5, 10)
        useBtn:addChild(itemNum, 500)
    end
    
end

function PetAddTalentPointLayer:assembleQuality()
    self.qualityData = {}

    local names = {UI.TEXT_1213633, UI.TEXT_1213635, UI.TEXT_1213637, UI.TEXT_1213639, UI.TEXT_1213634,  UI.TEXT_1213636,  UI.TEXT_1213638}
    local icons = {
        "ui_icon_talent_1.png", "ui_icon_talent_2.png", "ui_icon_talent_5.png", "ui_icon_talent_0.png",
        "ui_icon_talent_3.png", "ui_icon_talent_4.png", "ui_icon_talent_6.png", 
    }
    local qTypes = {}
    local prgs = {}
    local prgTxts = {}
    local plus = {}
    local pill = {}
    local pillMax = {}  -- 吃资质丹增量最大值

    local cfg = mvc.petModel:getTalentConfig(self.curPet.templateID, self.curPet.isVariant)
    local type = PublicDefine.PetTalentType
    -- 资质类型
    local cfgTypes = {}
    table.insert(cfgTypes, type.TPhysicAtk)
    table.insert(cfgTypes, type.TMagicAtk)
    table.insert(cfgTypes, type.TElement)
    table.insert(cfgTypes, type.TLife)
    table.insert(cfgTypes, type.TPhysicDef)
    table.insert(cfgTypes, type.TMagicDef)
    table.insert(cfgTypes, type.TResist)

    -- 初始资质最大值
    local valMax = {}
    table.insert(valMax, cfg.talent_atk[2])
    table.insert(valMax, cfg.talent_magicAtk[2])
    table.insert(valMax, cfg.talent_element[2])
    table.insert(valMax, cfg.talent_hp[2])
    table.insert(valMax, cfg.talent_physicDef[2])
    table.insert(valMax, cfg.talent_magicDef[2])
    table.insert(valMax, cfg.talent_elementDef[2])

    -- 当前资质
    local curVal = {}
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicAtk))
    table.insert(curVal, self.curPet:getTalentByType(type.TElement))
    table.insert(curVal, self.curPet:getTalentByType(type.TLife))
    table.insert(curVal, self.curPet:getTalentByType(type.TPhysicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TMagicDef))
    table.insert(curVal, self.curPet:getTalentByType(type.TResist))

    -- 额外增加资质(通过吃资质丹增加的)
    local plusVal = {}
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicAtk))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TElement))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TLife))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TPhysicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TMagicDef))
    table.insert(plusVal, self.curPet:getExtraTalentByType(type.TResist))

    local plusLen = {}
    for k, v in ipairs(plusVal) do
        table.insert(plusLen, v/valMax[k]*116)
    end

    -- 资质丹id
    local pillIDs = mvc.petModel:getAllQualityPillID()
    local pillVal = {}
    table.insert(pillVal, pillIDs[type.TPhysicAtk])
    table.insert(pillVal, pillIDs[type.TMagicAtk])
    table.insert(pillVal, pillIDs[type.TElement])
    table.insert(pillVal, pillIDs[type.TLife])
    table.insert(pillVal, pillIDs[type.TPhysicDef])
    table.insert(pillVal, pillIDs[type.TMagicDef])
    table.insert(pillVal, pillIDs[type.TResist])

    -- 额外增加资质最大值
    local pillMaxVal = {}
    table.insert(pillMaxVal, cfg.extra_atk)
    table.insert(pillMaxVal, cfg.extra_magicAtk)
    table.insert(pillMaxVal, cfg.extra_element)
    table.insert(pillMaxVal, cfg.extra_hp)
    table.insert(pillMaxVal, cfg.extra_physicDef)
    table.insert(pillMaxVal, cfg.extra_magicDef)
    table.insert(pillMaxVal, cfg.extra_elementDef)

    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    local starLv, canLvUpNum = self.curPet:getStarLv()
    local growID, initID
    if self.curPet.isVariant then
        growID = petCfg.growID[2]
        initID = petCfg.initID[2]
    else
        growID = petCfg.growID[1]
        initID = petCfg.initID[1]
    end
    local growCfg = ConfigManager:getPetGrowAttrByID(growID)
    local attrCfg = ConfigManager:getPetInitAttrByID(initID)
    local growList = {}
    local attrList = {}
    local grows = {}
    local attrTypeList = {}

    -- 资质系数
    printInfo("pet talentParam : "..table.nums(growCfg))
    local totalTalentParam = 0
    for index = 0, table.nums(growCfg) do
        if growCfg["talentParam_"..index] then
            totalTalentParam = totalTalentParam < index and index or totalTalentParam
            table.insert(growList, growCfg["talentParam_"..index])
        end
    end

    -- table.insert(growList, growCfg.talentParam_0)
    -- table.insert(growList, growCfg.talentParam_1)
    -- table.insert(growList, growCfg.talentParam_2)
    -- table.insert(growList, growCfg.talentParam_3)
    -- table.insert(growList, growCfg.talentParam_4)
    -- table.insert(growList, growCfg.talentParam_5)
    -- table.insert(growList, growCfg.talentParam_6)

    local grow = growList[starLv + 1]

    table.insert(grows, grow[2])
    table.insert(grows, grow[5])
    table.insert(grows, grow[6])
    table.insert(grows, grow[1])
    table.insert(grows, grow[4])
    table.insert(grows, grow[3])
    table.insert(grows, grow[7])

    -- 生长常数
    table.insert(attrList, attrCfg.init_atk[2])
    table.insert(attrList, attrCfg.init_magicAtk[2])
    table.insert(attrList, attrCfg.init_atkFire[2])
    table.insert(attrList, attrCfg.init_hp[2])
    table.insert(attrList, attrCfg.init_physicDef[2])
    table.insert(attrList, attrCfg.init_magicDef[2])
    table.insert(attrList, attrCfg.init_defFire[2])

    -- 生长常数
    table.insert(attrTypeList, attrCfg.init_atk)
    table.insert(attrTypeList, attrCfg.init_magicAtk)
    table.insert(attrTypeList, attrCfg.init_atkFire)
    table.insert(attrTypeList, attrCfg.init_hp)
    table.insert(attrTypeList, attrCfg.init_physicDef)
    table.insert(attrTypeList, attrCfg.init_magicDef)
    table.insert(attrTypeList, attrCfg.init_defFire)
    

    for k, v in ipairs(valMax) do
        table.insert(qTypes, cfgTypes[k])
        table.insert(prgs, curVal[k]/v)
        table.insert(prgTxts, string.format("%d/%d", curVal[k], v))
        table.insert(plus, plusVal[k])
        table.insert(pill, pillVal[k])
        table.insert(pillMax, pillMaxVal[k])
    end

    for k, v in ipairs(names) do
        local oneAttr = {}
        oneAttr.idx = k
        oneAttr.name = v
        oneAttr.icon = icons[k]
        oneAttr.type = qTypes[k]
        oneAttr.prg = prgs[k]
        oneAttr.prgTxt = prgTxts[k]
        oneAttr.plus = plus[k]
        oneAttr.plusLen = plusLen[k]
        oneAttr.pill = pill[k]
        oneAttr.pillMax = pillMax[k]
        oneAttr.curVal = curVal[k]
        oneAttr.grow = grows[k]
        oneAttr.attrConst = attrList[k]
        oneAttr.initAttrMode = attrTypeList[k]
        oneAttr.growAttrMode = growCfg

        table.insert(self.qualityData, oneAttr)
    end
end

function PetAddTalentPointLayer:composeQualityLayer(data)
    local powerNum = math.floor((data.curVal + data.plus) * data.grow / 1000 + data.attrConst)
    local tipTxtList = {
        UI.TEXT_1213719, UI.TEXT_1213721, UI.TEXT_1213723, UI.TEXT_1213725, UI.TEXT_1213720, 
        UI.TEXT_1213722, UI.TEXT_1213724,
    }
    local offsetY = {0, 55, 105, 155, 205, 255, 305, 355}

    local innerLayer = self.raiseQualityLayer:getChildByName("InnerLayer_"..data.idx)
    if not innerLayer then
        innerLayer = UI.Layout:create();
        innerLayer:init()
        innerLayer:setSize(390, 50)
        innerLayer:setTouchEnable(true)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            local pos = innerLayer:convertToNodeSpace(touchPosition)
            local size = innerLayer:getContentSize()
            local rect = cc.rect(0, 0, size.width/2, size.height)
            local tipTxt = string.format(data.name..":"..tipTxtList[data.idx], powerNum)
            if cc.rectContainsPoint(rect, pos) then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, tipTxt)
            end
        end)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)
        innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)

        innerLayer:setName("InnerLayer_"..data.idx)
        self.raiseQualityLayer:addChild(innerLayer)
    end
    innerLayer:leftUp(0, (data.idx-1)*50)

    local bg = innerLayer:getChildByName("Bg")
    if bg then
        bg:hide()
    end
    if data.idx%2 == 1 then
        if not bg then
            local bg = UI.Image:create()
            bg:init("ui_pets_cultivate_qualityup.png")
            bg:center()
            bg:setName("Bg")
            innerLayer:addChild(bg)
        else
            bg:show()
        end
    end

    local iconImg = innerLayer:getChildByName("IconImg")
    if not iconImg then
        iconImg = UI.Image:create()
        iconImg:init(data.icon)
        iconImg:centerLeft(15)
        iconImg:setName("IconImg")
        innerLayer:addChild(iconImg)
    end

    local prg = innerLayer:getChildByName("Prg")
    if not prg then
        prg = UI.ProgressTimer:create()
        prg:init("ui_pets_quality_progressbar_0.png", nil, "ui_pets_quality_progressbar_1.png")
        prg:centerLeft(50)
        prg:setName("Prg")
        innerLayer:addChild(prg)
    end
    prg:setPercent(data.prg)

    local prgText = prg:getChildByName("PrgText")
    if not prgText then
        prgText = UI.Text:create()
        prgText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_209_209_209)
        prgText:center()
        prgText:setName("PrgText")
        prg:addChild(prgText, 10)
    end
    prgText:setText(data.prgTxt)

    local prgTextShadow = prg:getChildByName("PrgTextShadow")
    if not prgTextShadow then
        prgTextShadow = UI.Text:create()
        prgTextShadow:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
        prgTextShadow:centerUp(1)
        prgTextShadow:setName("PrgTextShadow")
        prg:addChild(prgTextShadow, 9)
    end
    prgTextShadow:setText(data.prgTxt)

    local talentPointPrg = innerLayer:getChildByName("talentPointPrg")
    if talentPointPrg then
        talentPointPrg:removeFromParent(true)
        talentPointPrg = nil
    end
    local curExtraTalent = self.curPet:getExtraTalentPoint(index2PetTalentType[data.idx]) --当前资质已加点数量
    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    local talentPointsMax = petCfg.talentPointsMax --资质加点上限
    if not talentPointPrg then
        local talentPointPrg = UI.ProgressTimer:create()
        talentPointPrg:init("ui_pets_optimization_progressbg.png", nil, "ui_pets_optimization_progress.png")
        talentPointPrg:centerLeft(100+prg:getContentSize().width)
        talentPointPrg:setPercent(curExtraTalent/talentPointsMax)--(data.prg)
        talentPointPrg:setName("talentPointPrg")
        innerLayer:addChild(talentPointPrg)

        local talentPointPrgDes = curExtraTalent.."/"..talentPointsMax
        local talentPointPrgText = UI.Text:create()
        talentPointPrgText:init(talentPointPrgDes, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_209_209_209)
        talentPointPrgText:center()
        talentPointPrgText:setName("talentPointPrgText")
        talentPointPrg:addChild(talentPointPrgText, 10)

        local talentPointPrgTextShadow = prg:getChildByName("talentPointPrgTextShadow")
        if not talentPointPrgTextShadow then
            talentPointPrgTextShadow = UI.Text:create()
            talentPointPrgTextShadow:init(talentPointPrgDes, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
            talentPointPrgTextShadow:centerUp(1)
            talentPointPrgTextShadow:setName("talentPointPrgTextShadow")
            talentPointPrg:addChild(talentPointPrgTextShadow, 9)
        end
        talentPointPrgTextShadow:setText(talentPointPrgDes)
    else
        talentPointPrg:setPercent(curExtraTalent/talentPointsMax)
    end

    -- local plusLayer = innerLayer:getChildByName("PlusLayer")
    -- if plusLayer then   
    --     plusLayer:hide()
    -- end
    -- if data.plus > 0 then
    --     if not plusLayer then
    --         plusLayer = UI.Layout:create();
    --         plusLayer:init()
    --         plusLayer:setSize(120, 20)
    --         plusLayer:setName("PlusLayer")
    --         innerLayer:addChild(plusLayer)
    --     else
    --         plusLayer:show()
    --     end
    --     plusLayer:leftBottom(prg:getContentSize().width+50, 14)

    --     local expPlusW = data.plusLen
    --     local expPlus = plusLayer:getChildByName("ExpPlus")
    --     local expPlusTxtShadow = plusLayer:getChildByName("ExpPlusTxtShadow")
    --     local expPlusTxt = plusLayer:getChildByName("expPlusTxt")

    --     if not expPlus then
    --         expPlus = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_quality_progressbar_2.png")
    --         expPlus:setCapInsets(CCRectMake(0.5,8,0.1,0.1))
    --         expPlus:setName("ExpPlus")
    --         plusLayer:addChild(expPlus)
    --     end
    --     expPlus:setContentSize(expPlusW, 17)
    --     expPlus:setPosition(expPlusW/2, 11)

    --     if not expPlusTxtShadow then
    --         expPlusTxtShadow = UI.Text:create()
    --         expPlusTxtShadow:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
    --         expPlusTxtShadow:setName("ExpPlusTxtShadow")
    --         plusLayer:addChild(expPlusTxtShadow)
    --     end
    --     expPlusTxtShadow:setText("+"..data.plus)
    --     expPlusTxtShadow:leftBottom(expPlusW+2, 1)

    --     if not expPlusTxt then
    --         expPlusTxt = UI.Text:create()
    --         expPlusTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_255_186_65)
    --         expPlusTxt:setName("expPlusTxt")
    --         plusLayer:addChild(expPlusTxt)
    --     end
    --     expPlusTxt:setText("+"..data.plus)
    --     expPlusTxt:leftBottom(expPlusW+2, 2)
    -- end

    -- local addBtn = UI.Button:create();
    -- addBtn:init("ui_pets_optimization_btn.png","ui_pets_optimization_btn.png","ui_pets_optimization_btn.png");
    -- addBtn:rightBottom(0, 18);
    -- addBtn:setText(UI.TEXT_224002)
    -- addBtn:setTextOffset(30, 0)
    -- addBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    -- addBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     if SceneManager:getInstance():isInFightScene() then
    --         UI.ScrollBar:createByText(UI.TEXT_1213665)
    --         return
    --     end

    --     -- Net.NetPetSystem:raiseQuality(self.curPet:getId(), self.curQualityPillID)
    --     Net.NetPetSystem:petResetTalentPoint(self.curPet:getId())
    -- end)

    local selectBG = innerLayer:getChildByName("SelectBG")
    if not selectBG then
        selectBG = UI.Image:create()
        selectBG:init("ui_btn_choice_0.png")
        selectBG:setScaleX(0.7)
        selectBG:setScaleY(0.7)
        selectBG:centerRight(16)
        selectBG:setName("SelectBG")
        innerLayer:addChild(selectBG)
        innerLayer:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, com, touchPosition)
            local pos = selectBG:convertToNodeSpace(touchPosition)
            local size = selectBG:getContentSize()
            local rect = cc.rect(0, 0, size.width, size.height)
            if cc.rectContainsPoint(rect, pos) then
                -- if self.curSelectQualityRaise == data.idx then
                --     return
                -- end
                self:clickAddBtn(data)
                -- self:qualityRaiseCellClick(data.idx)

            end
        end)
    end

    local add_pic = innerLayer:getChildByName("add_pic")
    if not add_pic then
        add_pic = UI.Image:create()
        add_pic:init("ui_pets_optimization_add.png")
        add_pic:center()
        add_pic:setName("add_pic")
        selectBG:addChild(add_pic)
    end

    -- local select = innerLayer:getChildByName("select")
    -- if not select then
    --     select = UI.Image:create()
    --     select:init("ui_btn_choice_1.png")
    --     select:centerRight(16)
    --     select:setName("select")
    --     innerLayer:addChild(select)
    -- end
    -- if not data.select then
    --     select:hide()
    -- else
    --     select:show()
    -- end
    -- table.insert(self.raiseCellSelectTab, select)
end

function PetAddTalentPointLayer:qualityRaiseCellClick(idx)
    for k, v in ipairs(self.raiseCellSelectTab) do
        if k == idx then
            -- v:show()
            self.curSelectQualityRaise = idx

            -- self:updateQualityPillShow()
        else
            -- v:hide()
        end
    end
end

function PetAddTalentPointLayer:clickAddBtn(data)
    local addPointConsumeItemStr = ConfigManager:getGeneralForKey("petAddPointConsumeItemId")
    local addPointConsumeItemData = string.split(addPointConsumeItemStr, ",")
    local addPointConsumeItemId = tonumber(addPointConsumeItemData[1])

    -- local addPointConsumeItemId = 22072480
    local itemData = ConfigManager:getMaterialConfigByID(addPointConsumeItemId) --or ConfigManager:getVirtualItemConfigByID(addPointConsumeItemId)
    local curExtraTalent = self.curPet:getExtraTalentPoint(index2PetTalentType[data.idx]) --当前资质已加点数量
    local usedTalentPoint = self.curPet:getUsedTalentPoint()    --已使用资质点数量
    local usedTalentMaterialNum = self.curPet:getTalentPointItemUsed() --已使用资质丹数量
    local petCfg = ConfigManager:getPetDataByID(self.curPet.templateID)
    local talentPointsMax = petCfg.talentPointsMax --资质加点上限
    local talentMaterialMax = mvc.petModel:getPetTalentMaterialMax(petCfg, self.curPet:getLevel()) --资质丹使用上限
    local totalTalentPointNum = mvc.petModel:getPetTalentPoint(petCfg, self.curPet:getLevel()) --当前等级资质点获得数量
    local leftTalentPointNum = totalTalentPointNum - usedTalentPoint --当前剩余资质点数量
    local leftTalentMaterialCanUseNum = talentMaterialMax - usedTalentMaterialNum --当前剩余可使用资质丹数量 = 资质丹使用上限-已使用资质丹数量
    local canAddTalentPointNum = talentPointsMax - curExtraTalent   --当前资质可加点数 = 资质加点上限-当前资质已加点数量

    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, addPointConsumeItemId)
    local leftTalentMaterialNum = itemTotalNum >= leftTalentMaterialCanUseNum and leftTalentMaterialCanUseNum or itemTotalNum --当前背包剩余可使用资质丹数量

    local maxLimit = leftTalentPointNum+leftTalentMaterialNum --当前可加点数 = 当前剩余资质点数量+当前背包剩余可使用资质丹数量
    maxLimit = maxLimit >= canAddTalentPointNum and canAddTalentPointNum or maxLimit

    if canAddTalentPointNum == 0 then
        UI.ScrollBar:createByText(UI.TEXT_224008)
        return
    end

    if maxLimit == 0 then
        UI.ScrollBar:createByText(UI.TEXT_224009)
        return
    end

    local effectAttr = self:getAllEffAttrStr(data.type, data.icon) 
    data.effectAttr = effectAttr

    itemData.maxLimit = maxLimit
    itemData.maxLimitDes = UI.TEXT_221926
    itemData.extraData = data
    itemData.curExtraTalent = curExtraTalent
    itemData.talentPointsMax = talentPointsMax
    itemData.leftTalentPointNum = leftTalentPointNum
    itemData.level = self.curPet:getLevel()
    itemData.stars = self.curPet:getStarLv()
    itemData.petID = self.curPet:getId()
    
    require "app.modules.pet.PetAddTalentPointTips"
    local addTalentPointLayer = UI.PetAddTalentPointTips:show(itemData, function (num)
        -- self:_handleTipsQuick(num)
        -- mvc.dockModel:setSupplyAmount(sailConfig.ID, num)
        -- self:updateDockDetail(self.curTabIndex)
        if num == 0 then
            UI.ScrollBar:createByText(UI.TEXT_224016)
            return
        end
        Net.NetPetSystem:petUpTalentPoint(tonumber(self.curPet:getId()), num, data.type)
    end)
    -- addTalentPointLayer:centerLeft(-180)
    addTalentPointLayer:setDesText(UI.TEXT_224000)

    -- addTalentPointLayer:setMaxNumText(boatConfig.supplyMax)
    self.contentLayout:addChild(addTalentPointLayer, 300)
    -- self.contentLayout:enableDebugDraw()
end

function PetAddTalentPointLayer:getAllEffAttrStr(qualityType, typeIcon)
    local ATTR = PublicDefine.ATTR_TYPE
    local effectAttr = self.curPet:getAttrByTalent(qualityType)
    local attrs = {}
    for k, v in ipairs(effectAttr) do
        local oneAttr = {}
        if v == ATTR.hp then
            oneAttr.icon = "symbol_gaming_blood.png"
            oneAttr.str = tostring(self.curPet:getHp())
        elseif v == ATTR.atkMin then
            oneAttr.icon = "symbol_gaming_atk.png"
            oneAttr.str = tostring(self.curPet.atkMin)
        elseif v == ATTR.atkMax then
            attrs[#attrs].str = attrs[#attrs].str .. "-" .. self.curPet.atkMax
        elseif v == ATTR.magic then
            oneAttr.icon = "symbol_gaming_maggicatk.png"
            oneAttr.str = tostring(self.curPet.magic)
        elseif v == ATTR.physicDef then
            oneAttr.icon = "symbol_gaming_def.png"
            oneAttr.str = tostring(self.curPet.physicDef)
        elseif v == ATTR.magicDef then
            oneAttr.icon = "symbol_gaming_maggicdef.png"
            oneAttr.str = tostring(self.curPet.magicDef)
        elseif v == ATTR.atkFire then
            -- oneAttr.icon = "symbol_monsterattribute_fire_1.png"
            oneAttr.icon = typeIcon
            oneAttr.str = tostring(self.curPet.atkFire)
        -- elseif v == ATTR.atkWater then
        --     oneAttr.icon = "symbol_monsterattribute_water_1.png"
        --     oneAttr.str = tostring(self.curPet.atkWater)
        -- elseif v == ATTR.atkWood then
        --     oneAttr.icon = "symbol_monsterattribute_wood_1.png"
        --     oneAttr.str = tostring(self.curPet.atkWood)
        -- elseif v == ATTR.atkLight then
        --     oneAttr.icon = "symbol_monsterattribute_light_1.png"
        --     oneAttr.str = tostring(self.curPet.atkLight)
        -- elseif v == ATTR.atkDark then
        --     oneAttr.icon = "symbol_monsterattribute_dark_1.png"
        --     oneAttr.str = tostring(self.curPet.atkDark)
        elseif v == ATTR.defFire then
            -- oneAttr.icon = "symbol_monsterattribute_fire_2.png"
            oneAttr.icon = typeIcon
            oneAttr.str = tostring(self.curPet.defFire)
        -- elseif v == ATTR.defWater then
        --     oneAttr.icon = "symbol_monsterattribute_water_2.png"
        --     oneAttr.str = tostring(self.curPet.defWater)
        -- elseif v == ATTR.defWood then
        --     oneAttr.icon = "symbol_monsterattribute_wood_2.png"
        --     oneAttr.str = tostring(self.curPet.defWood)
        -- elseif v == ATTR.defLight then
        --     oneAttr.icon = "symbol_monsterattribute_light_2.png"
        --     oneAttr.str = tostring(self.curPet.defLight)
        -- elseif v == ATTR.defDark then
        --     oneAttr.icon = "symbol_monsterattribute_dark_2.png"
        --     oneAttr.str = tostring(self.curPet.defDark)
        end

        if v ~= ATTR.atkMax and table.nums(oneAttr) > 0 then
            table.insert(attrs, oneAttr)
        end
    end

    return attrs
end

function PetAddTalentPointLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_ON_TALENT_POINT_UPDATE, self, self.updateLayer)
end

function PetAddTalentPointLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_ON_TALENT_POINT_UPDATE, self, self.updateLayer)
end

return PetAddTalentPointLayer
