------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/03/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local PetReincarnationView = class("PetReincarnationView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_reincarnation_role.plist",
    "ui_package_skill.plist"
}

require "app.modules.petreincarnation.PetReincarnationInfoTableView"

local COM_WIDTH = 745
local COM_HEIGHT = 518
local winSize = cc.Director:getInstance():getWinSize()

function PetReincarnationView:ctor()
    PetReincarnationView.super.ctor(
        self,
        UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.curPet = MasterDataManager:getBagPetById(petID)

    self.reincarnationLevel = 110 -- 宠物转生所需等级
end

function PetReincarnationView:ctor(petID)
    PetReincarnationView.super.ctor(
        self,
        UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.petId = petID
    self.curPet = MasterDataManager:getBagPetById(petID)
    self.reincarnationLevel = 110 -- 宠物转生所需等级

end

function PetReincarnationView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.petreincarnation", "PetReincarnation", false)
    PetReincarnationView.super.init(self, ... )
end

function PetReincarnationView:dtor()
    PetReincarnationView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.petreincarnation.PetReincarnationView")
end


function PetReincarnationView:onInitView()
    -- 打印调用到此的堆栈信息  debug.traceback(里面是信息标题查找提示一个string);
    --print(debug.traceback("Stack trace111"))
    --print("PetReincarnationView----------> onInitView");

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(100, 50)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = UI.Image:create()
    bgImage:init("ui_reincarnation_role_bg.png")
    bgImage:center()
    self.contentLayout:addChild(bgImage)

    -- local bgTitleImage = UI.Image:create()
    -- bgTitleImage:init("ui_reincarnation_role_top.png")
    -- bgTitleImage:center(0, -260)
    -- self.contentLayout:addChild(bgTitleImage)

    -- 进阶后
    local advanceTitleImage = UI.Image:create()
    advanceTitleImage:init("ui_reincarnation_role_title.png")
    advanceTitleImage:center(0,-155)
    self.contentLayout:addChild(advanceTitleImage)
    self.advanceTitleImage = advanceTitleImage

    -- 进阶说明
    local result = UI.Text:create()
    local str = string.format(UI.TEXT_224301, tostring(self.curPet:getReincarntionLv() + 1))
    result:init(str, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_205_202_186)
    result:center(0,0)
    advanceTitleImage:addChild(result)
    self.resultTxt = result

    -- 宠物进阶动画界面
    local animationLayout = UI.Layout:create();
    animationLayout:init()
    animationLayout:setSize(COM_WIDTH - 200, COM_HEIGHT - 200)
    animationLayout:center(0, 0)
    -- contentLayout:enableDebugDraw()
    self.contentLayout:addChild(animationLayout)
    self.animationLayout = animationLayout
    self.animationLayout:setName("PetAnimation")


    -- 切换按钮
    local switchIcon  = UI.Image:create();
    switchIcon:init("ui_pets_show_btn_0.png");
    switchIcon:rightBottom(130, 74);
    switchIcon:setTouchEnable(true)
    self.contentLayout:addChild(switchIcon, 99)
    switchIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self:switchClick()
    end)
    self.switchIcon = switchIcon
    -- 显示信息
    self.isShowInfo = false
    self.advanceTitleImage:setVisible(self.isShowInfo)

    -- 火焰动画
    local leftFire = UI.Animation:create()
    leftFire:init("effect_ui_zhuansheng_fire.json", "effect_ui_zhuansheng_fire.atlas")
    leftFire:center(-300, 0)
    self.contentLayout:addChild(leftFire)
    leftFire:setAnimation("idle",true)

    local rightFire = UI.Animation:create()
    rightFire:init("effect_ui_zhuansheng_fire.json", "effect_ui_zhuansheng_fire.atlas")
    rightFire:center(300, 0)
    self.contentLayout:addChild(rightFire)
    rightFire:setAnimation("idle",true)

    ------------ 测试进阶后技能显示为滑动模式
    self:initPetAnimation()

    local bgTitleImage = UI.Image:create()
    bgTitleImage:init("ui_reincarnation_role_top.png")
    bgTitleImage:center(0, -260)
    self.contentLayout:addChild(bgTitleImage)

    self:infoTxtShow()
    self:showIsAllowReincarnation()
end

function PetReincarnationView:switchClick()
    if not self.isShowInfo then 
        self.isShowInfo = true
        self.advanceTitleImage:setVisible(self.isShowInfo)
        self.animationLayout:setVisible(not self.isShowInfo)
        self.switchIcon:setSpriteName("ui_pets_show_btn_1.png")
    else
        self.isShowInfo = false
        self.advanceTitleImage:setVisible(self.isShowInfo)
        self.animationLayout:setVisible(not self.isShowInfo)
        self.switchIcon:setSpriteName("ui_pets_show_btn_0.png")
    end
end

function PetReincarnationView:getPetAdvanceInfo()
    -- 根据宠物当前的转生等级获取对应表的信息
    local currentReincarntionLv = self.curPet:getReincarntionLv()
    local allConfigDatas = ConfigManager:getAllPetReincarnationData()
    local nowConfig = nil
    for k,v in pairs(allConfigDatas) do
        if v.petReiLv == currentReincarntionLv then
            nowConfig = allConfigDatas[k + 1]
        end
    end

    if not nowConfig then
        printError("PetReincarnationView:pet don't have petReiLv in profilePetReincarnation.")
    end

    return nowConfig
end

function PetReincarnationView:getChangeInfo()
    local nowConfig = self:getPetAdvanceInfo()
    if nowConfig == nil then
        return nil
    end

    self.nowConfig = nowConfig

    local desIdList = string.split(nowConfig.desId, ";")
    local detailConfigList = {}
    for k, v in pairs(desIdList) do
        local detailConfig = ConfigManager:getAllReincarnationDesDataByID(tonumber(v))

        local showString = {}
        showString.title = languageManagerInstance:getLocalString(detailConfig.title)
        showString.des = languageManagerInstance:getLocalString(detailConfig.des)
        showString.detailDes = nil
        if detailConfig.detailDes ~= 0 then
            showString.detailDes = languageManagerInstance:getLocalString(detailConfig.detailDes)
        end

        table.insert(detailConfigList, showString)
    end

    return detailConfigList
end

function PetReincarnationView:infoTxtShow()
    -- 注意！！！！！  后面的txt的内容都要改成 UI.TEXT_1213601这样的格式，适配各种语言系统  LanguageManager:getLocalString(self.data.des)
    -- 左侧文字信息显示
    self.otherAttrData = {}
    -- 横线以下的内容
    local showStrings = self:getChangeInfo()

    if showStrings == nil then
        return
    end

    local talbeNum = 0
    for k, v in ipairs(showStrings) do
        local data = {}
        data.isBack = (k % 2 == 1) -- 奇数有背景
        data.leftString = v.title
        data.rightString = v.des
        data.fontSize =  UI.FONT_SIZE_18PX
        data.color = UI.FONT_COLOR_45_44_48

        if v.detailDes then
            data.detailDes = v.detailDes
        end
        table.insert(self.otherAttrData, data)
        talbeNum = talbeNum + 1
    end


    local list = {}
    list.verticalNum = 1
    list.horizontalNum = talbeNum
    local PetReincarnationInfoTableView = UI.PetReincarnationInfoTableView:create()
    PetReincarnationInfoTableView:init(list)
    PetReincarnationInfoTableView:center(-33, -240)
    self.advanceTitleImage:addChild(PetReincarnationInfoTableView, 1)

    PetReincarnationInfoTableView:updateSkillList(self.otherAttrData)
    self.petReincarnationInfoTableView = PetReincarnationInfoTableView
end

function PetReincarnationView:showIsAllowReincarnation()
    -- 显示转生条件
    --local nowConfig = self:getPetAdvanceInfo()
    if tonumber(self.nowConfig.ItemNum) > 0 and self.petReincarnationInfoTableView then
        -- 有进阶需要的材料
        -- self.petReincarnationInfoTableView:expendMaterialsShow(self.nowConfig)

        -- 突破使用的材料
        local nowConfig = self.nowConfig
        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(nowConfig.ItemId))
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false
        goodsData:setNum(nowConfig.ItemNum)
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center(-65, 0)
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)
        goodsGrid:setScale(0.5)
        self.advanceButton:addChild(goodsGrid, 10)

        -- local select  = UI.Animation:create()
        -- select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
        -- select:center()
        -- select:setName("Select")
        -- select:setAnimation("start_square", false)
        -- select:addAnimation("loop_square", true)
        -- --select:hide()
        -- goodsGrid:addChild(select, 10)

    end
end

function PetReincarnationView:initPetAnimation()

    local backAnimation = UI.Animation:create()
    backAnimation:init("effect_ui_zhuansheng_lighting.json", "effect_ui_zhuansheng_lighting.atlas")
    backAnimation:center(-2, -40)
    self.animationLayout:addChild(backAnimation)
    backAnimation:setAnimation("trigger",false)
    self.backAnimation = backAnimation


    local bottomImg = UI.Image:create()
    bottomImg:init("ui_reincarnation_role_base.png")
    bottomImg:center(0,120)
    backAnimation:addChild(bottomImg)


    local layerScale = self.curPet:getLayerScale() * 1.3
    local spineName, jsonName, scale = self.curPet:getAnimationData()
    local petAnimation = UI.Animation:create()
    local spineOffset = string.split(self.curPet.spineoffset, ";")
    local offsetOne = self.curPet.isVariant and spineOffset[2] or spineOffset[1]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName, jsonName, scale, true)
    --petAnimation:centerUp(130 - offset[2])
    petAnimation:center(0,- offset[2])
    petAnimation:setAnimation("idle3", true)
    petAnimation:setScale(layerScale)
    petAnimation:setName("PetAnimation")
    bottomImg:addChild(petAnimation)

    local petAdvanceAnimation = UI.Animation:create()
    petAdvanceAnimation:init("effect_ui_zhuansheng_pet.json", "effect_ui_zhuansheng_pet.atlas")
    petAdvanceAnimation:center(0, 0)
    petAnimation:addChild(petAdvanceAnimation)
    petAdvanceAnimation:setAnimation("idle",false)
    self.petAdvanceAnimation = petAdvanceAnimation

    -- 进阶按钮
    local advanceButton = UI.Button:create()
    advanceButton:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    advanceButton:leftBottom(170,-15)
    advanceButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    advanceButton:setText(UI.TEXT_224300)
    advanceButton:closeClickScale()
    advanceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function ()
        local goodsNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(self.nowConfig.ItemId), true, true)
        local requireNum = tonumber(self.nowConfig.ItemNum)
        if goodsNum < requireNum then
            -- 材料数量不足
            UI.ScrollBar:createByText(UI.TEXT_1213611)
        else
            self:sendAdvanceRequest()
        end
        --self:showAnimation()
    end)
    self.animationLayout:addChild(advanceButton)
    self.advanceButton = advanceButton
end

function PetReincarnationView:sendAdvanceRequest()
    --local configInfo = self:getPetAdvanceInfo()
    local configs = {}
    configs.id = tonumber(self.nowConfig.petReiLv)
    configs.petId = tonumber(self.curPet:getId())
    Net.NetPetSystem:petAdvanceRequest(configs)
end

function PetReincarnationView:showAnimation()
    self.advanceButton:disable()
    self.backAnimation:setAnimation("begin", false)
    self.backAnimation:addAnimation("idle", true)

    self.petAdvanceAnimation:setAnimation("trigger", false)
    self.petAdvanceAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "trigger") then
            self.advanceButton:setVisible(false)
            UI.ScrollBar:createByText(UI.TEXT_224310)

            self.advanceButton:removeAllChildren()
            -- 阶级显示
            local reincarnationConfig = ConfigManager:getAllPetReincarnationDataByID(tonumber(self.curPet:getReincarntionLv()))
            local result = UI.Text:create()
            local str = string.format(UI.TEXT_224303, self.curPet:getReincarntionLv(), self.curPet:getLevel() - reincarnationConfig.value)
            result:init(str, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_205_202_186)
            result:center(0,150)
            self.animationLayout:addChild(result)


            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REINCARNATION__OK)
        end
    end)
end

function PetReincarnationView:reincarnationRespond(data)
    -- 转生成功播放动画
    --print("reincarnationRespond----->: ", data)
    local nowPet = MasterDataManager:getBagPetById(data.petId)
    nowPet:setReincarntionLv(tonumber(data.reincarnationLevel))
    nowPet:setLevel(tonumber(self.nowConfig.initialLevel))
    nowPet:refreshMaxLevelLimit()
    nowPet:refreshSkillNum()
    self:showAnimation()
end

function PetReincarnationView:bindModel()

end


function PetReincarnationView:unbindModel()

end

function PetReincarnationView:showDetailLayer(data)
    local logLayer = mvc.dockLogView:create(data)
    logLayer:init()
    logLayer:center(345, 0)
    logLayer:setName("logLayer")
    self.contentLayout:addChild(logLayer, 500)
end


return PetReincarnationView