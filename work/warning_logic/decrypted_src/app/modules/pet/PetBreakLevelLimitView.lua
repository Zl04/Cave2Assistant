------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/03/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local PetBreakLevelLimitView = class("PetBreakLevelLimitView", UI.HWBtnComponent)
local SdkBox = require("utils.sdkbox.SdkBox")

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_general_shop.plist",
}

local COM_WIDTH = 482
local COM_HEIGHT = 380
local winSize = cc.Director:getInstance():getWinSize()

function PetBreakLevelLimitView:ctor()
    PetBreakLevelLimitView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetBreakLevelLimitView:ctor(petID)
    PetBreakLevelLimitView.super.ctor(
        self,
        UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.curPet = MasterDataManager:getBagPetById(petID)
    self.useNum = 0 -- 当前可使用的材料个数
    self.haveNum = 0 -- 当前拥有的材料个数
    self.nowLevelLimit = 0 -- 当前的等级上限
    self.maxLevelLimit = 0 -- 当前转生的最大等级上限
    self.curPillSelectNum = 1

    self:initTopShowData()
end

function PetBreakLevelLimitView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetBreakLevelLimitView.super.init(self, ... )
end

function PetBreakLevelLimitView:dtor()
    PetBreakLevelLimitView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.pet.PetBreakLevelLimitView")
end


function PetBreakLevelLimitView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    local title  = UI.Image:create()
    title:init("ui_setup_banner_box4.png")
    title:center(0, -165)
    self.contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224308, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0,0)
    title:addChild(titleText)

    -- 等级变化显示
    local levelLimitBanner = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box4.png")
    levelLimitBanner:setContentSize(300, 28)
    levelLimitBanner:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT / 2 + 120))
    self.contentLayout:addChild(levelLimitBanner)

    local nowLevelLimitShow = UI.Image:create()
    nowLevelLimitShow:init("ui_home_banner_lv.png")
    nowLevelLimitShow:center(-90,0)
    levelLimitBanner:addChild(nowLevelLimitShow)

    local nowText = cc.LabelAtlas:create(tostring(self.nowLevelLimit), "ui_home_unmber.png", 17, 23, 48)
    nowText:setAnchorPoint(cc.p(0.0, 0.5))
    nowText:setPosition(30,10)
    nowLevelLimitShow:addChild(nowText)

    local midShow = UI.Image:create()
    midShow:init("ui_information_arrow_2.png")
    midShow:center(0,0)
    midShow:setScale(0.5)
    levelLimitBanner:addChild(midShow)

    local afterLevelLimitShow = UI.Image:create()
    afterLevelLimitShow:init("ui_home_banner_lv.png")
    afterLevelLimitShow:center(55,0)
    levelLimitBanner:addChild(afterLevelLimitShow)

    local afterText = cc.LabelAtlas:create(tostring(self.nowLevelLimit + self.curPillSelectNum), "ui_home_unmber.png", 17, 23, 48)
    afterText:setAnchorPoint(cc.p(0.0, 0.5))
    afterText:setPosition(25,10)
    afterLevelLimitShow:addChild(afterText)
    self.afterText = afterText

    if self.curPet:getReincarntionLv() > 0 then
         -- 如果是国内CN 子渠道
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        if (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE ) then
            -- 国内版本
            local nowText2 = cc.LabelAtlas:create(tostring(self.curPet:getReincarntionLv()), "ui_home_unmber.png", 17, 23, 48)
            nowText2:setAnchorPoint(cc.p(0.0, 0.5))
            nowText2:setPosition(-50,11)
            nowLevelLimitShow:addChild(nowText2)

            local stringNum = string.format("ui_home_unmber_jie.png", self.curPet:getReincarntionLv())
            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init(stringNum)
            lvReincarntionImg:center(-32, -1)
            nowLevelLimitShow:addChild(lvReincarntionImg)
            nowLevelLimitShow:center(-80, 0)

            local nowText3 = cc.LabelAtlas:create(tostring(self.curPet:getReincarntionLv()), "ui_home_unmber.png", 17, 23, 48)
            nowText3:setAnchorPoint(cc.p(0.0, 0.5))
            nowText3:setPosition(-50,11)
            afterLevelLimitShow:addChild(nowText3)

            local stringNum = string.format("ui_home_unmber_jie.png", self.curPet:getReincarntionLv())
            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init(stringNum)
            lvReincarntionImg:center(-32, -1)
            afterLevelLimitShow:addChild(lvReincarntionImg)
            afterLevelLimitShow:center(90, 0)
        else
            -- 国际版本
            local stringNum = string.format("ui_home_unmber_t%d.png", self.curPet:getReincarntionLv())
            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init(stringNum)
            lvReincarntionImg:center(-32, -2)
            nowLevelLimitShow:addChild(lvReincarntionImg)

            local stringNum = string.format("ui_home_unmber_t%d.png", self.curPet:getReincarntionLv())
            local lvReincarntionImg = UI.Image:create()
            lvReincarntionImg:init(stringNum)
            lvReincarntionImg:center(-32, -2)
            afterLevelLimitShow:addChild(lvReincarntionImg)
            afterLevelLimitShow:center(85, 0)
        end
    end

    -- 突破使用的材料  22080010
    local goodsData = GoodsDataManager:createLocalGoodsData(self.goodsDataId)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsData:setNum(self.haveNum)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center(0, -60)
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    self.contentLayout:addChild(goodsGrid)

    local select  = UI.Animation:create()
    select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
    select:center()
    select:setName("Select")
    select:setAnimation("start_square", false)
    select:addAnimation("loop_square", true)
    --select:hide()
    goodsGrid:addChild(select, 10)

    self:initBar()
    self:initBtn()
end

function PetBreakLevelLimitView:initBar()
    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:leftUp(108, 242)
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
            self.numPopTxt:setText("1")
            self.curPillSelectNum = 1
        else
            local realNum = math.floor(self:getPillShowNum() * curX/maxX)
            if realNum == 0 then
                realNum = 1
            end
            self.numPopTxt:setText(tostring(realNum))
            self.curPillSelectNum = realNum
        end

        self.numPrgBar:setPercent(curX/maxX)

        if self.curPillSelectNum ~= self.lastPillSelectNum then
            self:updateLvPrgBarShow()
            self.lastPillSelectNum = self.curPillSelectNum
        end
    end)
    numPrgBar:addChild(numPopPlus, 10);

    local numBG  = UI.Image:create();
    numBG:init("ui_shop_article_4.png");
    numBG:leftUp(-15, -60);
    numPopPlus:addChild(numBG);

    local numTxt = UI.Text:create()
    numTxt:init(tostring(1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    local numLeftTxt = UI.Text:create()
    numLeftTxt:init(tostring(1), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numLeftTxt:center(-maxX / 2 - 35,0)
    numPrgBar:addChild(numLeftTxt)

    local numRightTxt = UI.Text:create()
    numRightTxt:init(tostring(self.useNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numRightTxt:center(maxX / 2 + 35,0)
    numPrgBar:addChild(numRightTxt)
end

function PetBreakLevelLimitView:initBtn()
    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("Pet", "PetBreakLevelLimit")
    end)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认购买按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Net.NetPetSystem:petLvBreakRequest(tonumber(self.curPet:getId()), self.curPillSelectNum)
        mvc.closePanel("Pet", "PetBreakLevelLimit")
    end)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)
end

function PetBreakLevelLimitView:updateLvPrgBarShow()
    self.afterText:setString(tostring(self.nowLevelLimit + self.curPillSelectNum))
end

function PetBreakLevelLimitView:getPillShowNum()
    return self.useNum
end

function PetBreakLevelLimitView:initTopShowData()
    local nowConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
    local breakItemList = string.split(nowConfig.lvBreakthroughItemId, ",")
    self.goodsDataId = tonumber(breakItemList[1])
    -- 当前可使用的材料个数
    self.useNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(breakItemList[1]), true, true)
    self.haveNum = self.useNum
    --print("initTopShowData---->: ", tonumber(breakItemList[1]))
    ---------  测试暂时没有数据 ------
    --self.useNum = 16
    ---------------------------------

    local maxLvMit = nowConfig.maxLevel
    local curLvMit = self.curPet:getMaxLevelLimit()
    self.nowLevelLimit = curLvMit - nowConfig.value-- 当前的等级上限
    self.maxLevelLimit = maxLvMit - nowConfig.value-- 当前转生的最大等级上限

    if self.maxLevelLimit - self.nowLevelLimit < self.useNum then
        self.useNum = self.maxLevelLimit - self.nowLevelLimit
    end
end

function PetBreakLevelLimitView:bindModel()
end


function PetBreakLevelLimitView:unbindModel()
end



return PetBreakLevelLimitView
