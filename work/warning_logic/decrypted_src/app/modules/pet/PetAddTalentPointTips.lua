------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/06
--desc	: 资质加点tips
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetAddTalentPointTips = class("PetAddTalentPointTips", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_shop.plist",
    "ui_shop_article_2.plist",
    "ui_package_pets.plist",
}

UI.PetAddTalentPointTips = PetAddTalentPointTips

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 380
local COM_HEIGHT = 320
-- local self.data.ID = 22070580

function PetAddTalentPointTips:ctor()
    PetAddTalentPointTips.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    -- self.curPet = MasterDataManager:getBagPetById(petID)
end

function PetAddTalentPointTips:init(data, okCallback, cancelCallback)

    self.okCallback = okCallback
    self.cancelCallback = cancelCallback
    self.data = data
    PetAddTalentPointTips.super.init(self)
end

function PetAddTalentPointTips:dtor()
    PetAddTalentPointTips.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetAddTalentPointTips")
end

function PetAddTalentPointTips:onInitView()
    self.curCardsSelectNum = 0
    self.lastCardsSelectNum = 0

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local maskBG  = UI.Layout:create()
    maskBG:init()
    maskBG:center()
    maskBG:setTouchEnable(true)
    maskBG:setSize(winSize.width * 2, winSize.height * 2)
    self:addChild(maskBG, 0)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_optimization_paper.png")
    bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    self:updateItemShow()

    local des = UI.Text:create()
    des:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_209_209_209)
    des:centerUp(5)
    self.contentLayout:addChild(des)
    self.des = des

    local offsetY = 20
    local numMin = UI.Text:create()
    numMin:init(tostring(self.curCardsSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMin:leftUp(28, 164+offsetY)
    self.contentLayout:addChild(numMin)
    self.numMinTxt = numMin

    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:centerUp(168+offsetY)
    numPrgBar:setPercent(0)
    self.contentLayout:addChild(numPrgBar)
    self.numPrgBar = numPrgBar

    local maxX = numPrgBar:getContentSize().width

    local numPopPlus  = UI.Image:create();
    numPopPlus:init("ui_shop_article_3.png");
    local offsetX = numPopPlus:getContentSize().width/2
    numPopPlus:centerLeft(-offsetX);
    numPopPlus:setTouchEnable(true)
    numPopPlus:setSwallowTouches(true)
    self.numPopPlus = numPopPlus
    self.originOffsetX = offsetX
    numPopPlus:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, com, touchpos)
        local deltaX = touchpos.x-com:Local2Global().x

        if com:getPositionX()+deltaX <= -offsetX then
            com:setPosition(-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX >= maxX-offsetX then
            com:setPosition(maxX-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX > -offsetX and com:getPositionX()+deltaX < maxX-offsetX then
            com:setPosition(com:getPositionX()+deltaX, com:getPositionY())
        end

        local curX = com:getPositionX()+offsetX
        if curX == 0 then
            self.numPopTxt:setText("0")
            self.curCardsSelectNum = 0
        else
            local realNum = math.floor(self:getPillShowNum() * curX/maxX)
            -- if realNum == 0 then
            --     realNum = 1
            -- end
            self.numPopTxt:setText(tostring(realNum))
            self.curCardsSelectNum = realNum
        end
        -- self.numPopTxt:setText(tostring(realNum))
        -- self.curCardsSelectNum = realNum

        self.numPrgBar:setPercent(curX/maxX)

        if self.curCardsSelectNum ~= self.lastCardsSelectNum then
            self.lastCardsSelectNum = self.curCardsSelectNum
        end

        -- 刷新界面属性
        -- self.curCardsSelectNum
        local extraData = self.data.extraData
        self:onPrgMove(self.curCardsSelectNum, extraData.grow, extraData.attrConst)
    end)
    numPrgBar:addChild(numPopPlus, 10)

    local numBG  = UI.Image:create()
    numBG:init("ui_shop_article_4.png")
    numBG:leftUp(-15, -50)
    numPopPlus:addChild(numBG)

    local numTxt = UI.Text:create()
    numTxt:init(tostring(self.curCardsSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    local numMax = UI.Text:create()
    numMax:init(tostring(self:getPillShowNum()), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMax:leftUp(320, 164+offsetY)
    self.contentLayout:addChild(numMax)
    self.numMaxTxt = numMax

    -- if self.data.maxLimitDes then
    --     local maxNumPrompt = UI.Text:create()
    --     maxNumPrompt:init(string.format(self.data.maxLimitDes, self.data.maxLimit), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_32_32)
    --     maxNumPrompt:centerBottom(90)
    --     self.contentLayout:addChild(maxNumPrompt)
    -- end
    
    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.cancelCallback then
            self.cancelCallback()
        end
        self:removeFromParent()
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.curCardsSelectNum == 0 then
            UI.ScrollBar:createByText(UI.TEXT_224016)
            return
        end
        if self.okCallback then
            self.okCallback(self.curCardsSelectNum)
        end
        self:removeFromParent()
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)

    local attrLayer = self:composeQualityLayer(self.data.extraData, 0)
    self.contentLayout:addChild(attrLayer)
end

function PetAddTalentPointTips:updateItemShow()

    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, self.data.ID)
    local itemData = GoodsDataManager:createLocalGoodsData(self.data.ID)
    itemData:setNum(tonumber(itemTotalNum)) -- ui_setup_banner_box4

    local itemLayout = UI.Layout:create();
    itemLayout:init()
    itemLayout:centerBottom(90, 10)--centerUp(70)
    itemLayout:setName("itemLayout")
    self.contentLayout:addChild(itemLayout, 99)
    -- itemLayout:enableDebugDraw()

    -- local ItemBg = UI.Image:create()
    -- ItemBg:init("ui_setup_banner_box4.png")
    -- ItemBg:center()
    -- itemLayout:addChild(ItemBg)

    local useDes = UI.Text:create()
    useDes:init(UI.TEXT_224001, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useDes:centerLeft(-75, 0)
    itemLayout:addChild(useDes)

    local itemIcon = UI.Image:create()
    itemIcon:init(self.data.miniIcon)
    itemIcon:centerLeft(0, 0)
    itemLayout:addChild(itemIcon)

    local itemNum = UI.Text:create()
    -- itemNum:init(tostring(itemData:getNum()), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    itemNum:init(tostring(0), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    itemNum:centerLeft(0, 0)
    itemLayout:addChild(itemNum)
    self.itemNum = itemNum

    local totalLength = itemIcon:getContentSize().width + itemNum:getContentSize().width + 6
    itemIcon:centerLeft(- totalLength / 2, 0)
    itemNum:centerLeft(- totalLength / 2 + itemIcon:getContentSize().width + 6, 0)
end

function PetAddTalentPointTips:getPillShowNum()
    -- local pk = RoleDataManager:getMaster():getPK()
    -- local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, self.data.ID)
    -- if tonumber(itemTotalNum) > tonumber(self.data.maxLimit) then
    --     return self.data.maxLimit
    -- else
    --     return tonumber(itemTotalNum)
    -- end
    return self.data.maxLimit
end

function PetAddTalentPointTips:show(data, okCallback, cancelCallback)
    local PetAddTalentPointTips = PetAddTalentPointTips:create()
    PetAddTalentPointTips:init(data, okCallback, cancelCallback)
    PetAddTalentPointTips:centerLeft(-180, -20)

    return PetAddTalentPointTips
end

function PetAddTalentPointTips:setDesText(text)
    self.des:setText(text)
end

function PetAddTalentPointTips:setMaxNumText(text)
    self.numMaxTxt:setText(text)
end

function PetAddTalentPointTips:setCurNum(num)
    self.curCardsSelectNum = num
end

function PetAddTalentPointTips:composeQualityLayer(data, beginOffset)
    local totalH = beginOffset

    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(120, 36)
    innerLayer:centerUp(65, -10)

    local iconImg = UI.Image:create()
    iconImg:init(data.icon)
    iconImg:centerLeft(0)
    innerLayer:addChild(iconImg)

    local prg = UI.ProgressTimer:create()
    prg:init("ui_pets_optimization_progressbg.png", nil, "ui_pets_optimization_progress.png")
    prg:centerLeft(32)
    prg:setPercent(self.data.curExtraTalent/self.data.talentPointsMax)--(data.prg)
    prg:setName("prg")
    innerLayer:addChild(prg)

    local prgDes = self.data.curExtraTalent.."/"..self.data.talentPointsMax
    local prgText = UI.Text:create()
    prgText:init(prgDes, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_209_209_209)
    prgText:center()
    prgText:setName("prgText")
    prg:addChild(prgText, 10)

    -- local prgTextShadow = UI.Text:create()
    -- prgTextShadow:init(prgDes, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
    -- prgTextShadow:centerUp(1)
    -- prg:addChild(prgTextShadow, 9)

    -- if data.plus > 0 then
    --     local plusLayer = UI.Layout:create();
    --     plusLayer:init()
    --     plusLayer:leftBottom(prg:getContentSize().width + 34, 8)
    --     plusLayer:setSize(120, 20)
    --     innerLayer:addChild(plusLayer)

    --     -- local expPlusW = data.plusLen
    --     -- local expPlus = cc.Scale9Sprite:createWithSpriteFrameName("ui_pets_quality_progressbar_2.png")
    --     -- expPlus:setContentSize(expPlusW, 18)
    --     -- expPlus:setCapInsets(CCRectMake(0.5,8,0.1,0.1))
    --     -- expPlus:setPosition(expPlusW/2-2, 10)
    --     -- plusLayer:addChild(expPlus)

    --     -- local expPlusTxtShadow = UI.Text:create()
    --     -- expPlusTxtShadow:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_BLACK)
    --     -- expPlusTxtShadow:leftBottom(expPlusW, 1)
    --     -- plusLayer:addChild(expPlusTxtShadow)

    --     local expPlusTxt = UI.Text:create()
    --     expPlusTxt:init("+"..data.plus, UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_255_186_65)
    --     expPlusTxt:leftBottom(expPlusW, 2)
    --     expPlusTxt:setName("expPlusTxt")
    --     plusLayer:addChild(expPlusTxt)
    -- end
    local plusLayer = UI.Layout:create();
    plusLayer:init()
    plusLayer:leftBottom(prg:getContentSize().width + 34, 8)
    plusLayer:setSize(120, 20)
    innerLayer:addChild(plusLayer)

    local expPlusTxt = UI.Text:create()
    expPlusTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_173_232_70)
    expPlusTxt:leftBottom(expPlusW, 2)
    expPlusTxt:setName("expPlusTxt")
    plusLayer:addChild(expPlusTxt)
    self.expPlusTxt = expPlusTxt
    self.expPlusTxt:setVisible(false)
    -- plusLayer:hide()

    totalH = totalH + 40
    local offsetY = {40, 66, 92, 118, 144}
    
    for k, v in ipairs(data.effectAttr) do    
        local attrVal = UI.Text:create()
        attrVal:init(v.str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        -- attrVal:leftUp(48, offsetY[k])
        attrVal:centerUp(offsetY[k], 30);
        innerLayer:addChild(attrVal)
        self.attrVal = attrVal

        local attrIcon  = UI.Image:create();
        attrIcon:init(v.icon);
        attrIcon:leftUp(-30, 0);
        -- attrIcon:centerUp(offsetY[k], 0);
        attrVal:addChild(attrIcon);

        if data.type == PublicDefine.PetTalentType.TElement or data.type == PublicDefine.PetTalentType.TResist then
            -- attrIcon:leftUp(3, offsetY[k]-8);
            -- attrIcon:centerUp(offsetY[k]-8, 0);
            attrIcon:leftUp(-30, -8);
            attrIcon:setScale(0.9)
        end

        -- local attrPlusTxt = UI.Text:create()
        -- attrPlusTxt:init("++", UI.FONT_STANDARD, UI.FONT_SIZE_12PX, UI.FONT_COLOR_255_186_65)
        -- attrPlusTxt:leftUp(48+attrVal:getContentSize().width, offsetY[k])
        -- attrPlusTxt:setName("attrPlusTxt")
        -- innerLayer:addChild(attrPlusTxt)
        -- self.attrPlusTxt = attrPlusTxt

        totalH = totalH + 30
    end

    return innerLayer, totalH
end

function PetAddTalentPointTips:onPrgMove(talentValue, talentFactors, addConst)
    self.expPlusTxt:setVisible(talentValue>0)
    self.expPlusTxt:setText("+"..talentValue)
    
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, self.data.ID)
    local leftTalentPointNum = self.data.leftTalentPointNum
    local numText = 0
    if itemTotalNum > 0 then
        numText = talentValue <= leftTalentPointNum and 0 or (talentValue - leftTalentPointNum)
    end
    
    self.itemNum:setText(numText)

    local curPet = MasterDataManager:getBagPetById(self.data.petID)
    local extraData = self.data.extraData

    local talent = curPet:getTalentByType(extraData.type) 
    local extraTalent = curPet:getExtraTalentByType(extraData.type)
    local extraTalentPoint = curPet:getExtraTalentPoint(extraData.type)
    local totalTalentValue = talent+extraTalent+talentValue+extraTalentPoint

    local level = self.data.level
    local stars = self.data.stars
    local effectAttr = self:getAllEffAttrStr(curPet, extraData.type, totalTalentValue, extraData, level, stars)--mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1)
    for k, v in ipairs(effectAttr) do
        self.attrVal:setText(v.str)
    end
    -- self.attrVal:setText(effectAttr.str)
end

function PetAddTalentPointTips:getAllEffAttrStr(curPet, qualityType, totalTalentValue, extraData, level, stars)
    local ATTR = PublicDefine.ATTR_TYPE
    local effectAttr = curPet:getAttrByTalent(qualityType)
    local attrs = {}
    for k, v in ipairs(effectAttr) do
        local oneAttr = {}
        if v == ATTR.hp then
            -- oneAttr.icon = "symbol_gaming_blood.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet:getHp())
        elseif v == ATTR.atkMin then
            -- oneAttr.icon = "symbol_gaming_atk.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, (1 - 0.05)))--tostring(self.curPet.atkMin)
        elseif v == ATTR.atkMax then
            attrs[#attrs].str = attrs[#attrs].str .. "-" .. tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, (1 + 0.05)))--self.curPet.atkMax
        elseif v == ATTR.magic then
            -- oneAttr.icon = "symbol_gaming_maggicatk.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet.magic)
        elseif v == ATTR.physicDef then
            -- oneAttr.icon = "symbol_gaming_def.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet.physicDef)
        elseif v == ATTR.magicDef then
            -- oneAttr.icon = "symbol_gaming_maggicdef.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet.magicDef)
        elseif v == ATTR.atkFire then
            -- oneAttr.icon = "symbol_monsterattribute_fire_1.png"
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet.atkFire)
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
            oneAttr.str = tostring(mvc.petModel:computeLevelInStage(extraData.type, level, stars, totalTalentValue, extraData.initAttrMode, extraData.growAttrMode, 1))--tostring(self.curPet.defFire)
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

function PetAddTalentPointTips:bindModel()

end

function PetAddTalentPointTips:unbindModel()

end

return PetAddTalentPointTips
