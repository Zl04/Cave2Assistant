------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/28
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandInfoView = class("BigSailIslandInfoView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

require "app.modules.bigsailisland.BigSailIslandBoatTableCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_town_islanddisplay.plist",
    "ui_town_navigation.plist",
}

-- 岛屿占领标记状态
local ISLAND_SIGN_STATUS = {
    OCCUPY_SIGN = 1, -- 标记集中占领
    OCCUPY_EXCHANGE = 2, -- 更换占领岛屿
    OCCUPY_CANCEL = 3, -- 取消集中占领
}

-- 船只状态
local BigSailBoatStatus = 
{
    None = 0,
    BigSailBoating = 1, -- 大航海出海中
    BigSailBoatingWaitFinish = 2, -- 航行完成等待占领
    BigSailBoatingCaptured = 3,   -- 占领岛屿
}

UI = UI or {}
UI.BigSailIslandInfoView = BigSailIslandInfoView

local COM_WIDTH = 934
local COM_HEIGHT = 534
local winSize = cc.Director:getInstance():getWinSize()

function BigSailIslandInfoView:ctor(data)
    BigSailIslandInfoView.super.ctor(
    	self,
    	UI.Type.BIGSAIL_ISLAND_INFO,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data[1]
    self.guildSignStatus = 1 -- 公会占领状态
    self.yieldBgShowBool = false
    self:bindModel()

    self.myBoatId = nil -- 当前岛屿的上是否有自己的船只id
    self.verticalNum = 1 
    self.horizontalNum = 3
    --self.boatInfoData = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(self.data.landId)
    self.boatInfoData = {}
    --self.guildOccupyIslandId = mvc.bigSailIslandModel:getGuildOccupyIslandId() -- 获取公会标记占领岛屿
    print("BigSailIslandInfoView-->: ",self.boatInfoData)
end

function BigSailIslandInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandInfoView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        -- mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
        self:close()
    end)
end

function BigSailIslandInfoView:dtor()
    BigSailIslandInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandInfoView")
end

-- function BigSailIslandInfoView:close()
--     self.super:close()
-- end


function BigSailIslandInfoView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    --self:enableDebugDraw()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(-50,0)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create()
    bg:init("ui_greatnavigation_bg.png")
    bg:center(50, 0)
    self.contentLayout:addChild(bg)

    local bg2  = UI.Image:create()
    bg2:init("ui_greatnavigation_paper2.png")
    bg2:center(50, 0)
    self.contentLayout:addChild(bg2)

    local bg3  = UI.Image:create()
    bg3:init("ui_greatnavigation_top.png")
    bg3:center(50, -297)
    self.contentLayout:addChild(bg3)

    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(450, COM_HEIGHT)
    self.leftLayer:leftBottom(13, 0)
    self:addChild(self.leftLayer, 2)

    self.rightLayer = UI.Layout:create();
    self.rightLayer:init()
    self.rightLayer:setSize(450, COM_HEIGHT)
    self.rightLayer:leftBottom(COM_WIDTH - 90, 0)
    self:addChild(self.rightLayer, 2)

    self:createLeftLayer()
    self:createRightLayer()

    print("选中展示详情的岛屿的ID---》： ", self.data.landId)
end

function BigSailIslandInfoView:showExplainInfo(bufIcon)
    -- body
    local offsetX = 0
    local offsetY = 0
    if bufIcon.bonusType == 1 then
        offsetX = 0
        offsetY = 0
    elseif bufIcon.bonusType == 2 then
        offsetX = 0
        offsetY = 30
    elseif bufIcon.bonusType == 3 then
        offsetX = 25
        offsetY = 30
    elseif bufIcon.bonusType == 4 then
        offsetX = 55
        offsetY = 30
    elseif bufIcon.bonusType == 5 then
        offsetX = 0
        offsetY = 70
    end

    self.explainPic:setVisible(true)
    self.explainPic:center(-53 + offsetX,-205 + offsetY)
    -- bufIcon.bonusType = 3
    -- explainPic:center(230,-102)
    self.explainTxt:setText(languageManagerInstance:getLocalString(bufIcon.tagDes))
    --local iconName = bufIcon:getSpriteName()
end

function BigSailIslandInfoView:closeExplainInfo(bufIcon)
    -- body
    self.explainPic:setVisible(false)
end

function BigSailIslandInfoView:addBuffListener( bufIcon )
    -- body
    bufIcon:setTouchEnable(true)
    -- bufIcon:setSwallowTouches(true)
    -- bufIcon:setInterceptTouches(true)
    bufIcon:enableDebugDraw()
    bufIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(bufIcon)
        self:showExplainInfo(bufIcon)
    end)
    bufIcon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(bufIcon)
        self:showExplainInfo(bufIcon)
    end)
    bufIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(bufIcon)
        self:closeExplainInfo(bufIcon)
    end)
end

function BigSailIslandInfoView:createLeftLayer()
    -- -- 左侧界面刷新
    if self.leftLayer then
        self.leftLayer:removeAllChildren()
    end

    -- 获取配置表里的基本岛屿信息
    local config = ConfigManager:getIslandsByID(self.data.landId)

    -- 我的产量
    local myYieldShowBtn = UI.Button:create()
    myYieldShowBtn:init("ui_greatnavigation_production.png")
    myYieldShowBtn:center(-193, -223)
    -- myYieldShowBtn:setText("我的产量")
    -- myYieldShowBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    myYieldShowBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:isShowYieldBg()
    end)
    self.leftLayer:addChild(myYieldShowBtn, 2)

    local showYieldBg = UI.Image:create()
    showYieldBg:init("ui_greatnavigation_tips.png")
    showYieldBg:center(100,50)
    showYieldBg:setVisible(false)
    myYieldShowBtn:addChild(showYieldBg)
    self.showYieldBg = showYieldBg

    local showYieldTxt1 = UI.Text:create()
    showYieldTxt1:init(UI.TEXT_226126, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    showYieldTxt1:center(-60,4)
    showYieldBg:addChild(showYieldTxt1)
    self.showYieldTxt1 = showYieldTxt1

    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local seconds = config2[1].yieldCalculationInterval
    local showYieldNum = UI.Text:create()
    showYieldNum:init("0/"..tostring(seconds).."s", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    showYieldNum:center(100,4)
    showYieldNum:setTextRight()
    showYieldBg:addChild(showYieldNum)
    self.showYieldNum = showYieldNum

    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].islandItemId))
    local showYieldGoods = UI.Image:create()
    showYieldGoods:init(goodsData.miniIcon)
    showYieldGoods:centerLeft(-35,0)
    showYieldNum:addChild(showYieldGoods)

    ------------------------

    -- 岛屿名称
    local isLandNameTxt = UI.Text:create()
    isLandNameTxt:init(languageManagerInstance:getLocalString(tonumber(config.name)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    isLandNameTxt:center(-50,-225)
    self.leftLayer:addChild(isLandNameTxt)

    ------------------------
    local explainPic = UI.Image:create()
    explainPic:init("ui_greatnavigation_tips2.png")
    explainPic:center(-53,-205)
    explainPic:setVisible(false)
    self:addChild(explainPic, 10)
    self.explainPic = explainPic

    local explainTxt = UI.Text:create()
    explainTxt:init("UI.TEXT_226127", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    explainTxt:center(0,-3)
    explainPic:addChild(explainTxt)
    self.explainTxt = explainTxt
    ------------------------

    -- 基础产量
    local baseYieldTxt = UI.Text:create()
    baseYieldTxt:init(UI.TEXT_226127, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 54, g = 49, b = 48})
    baseYieldTxt:center(-180,-170)
    self.leftLayer:addChild(baseYieldTxt)

    local baseYieldNum = UI.Text:create()
    baseYieldNum:init(tostring(config.baseOutput).."/"..tostring(seconds).."s", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    baseYieldNum:center(-50,-170)
    self.leftLayer:addChild(baseYieldNum)
    self.baseYieldNum = baseYieldNum

    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].islandItemId))
    local baseYieldPic = UI.Image:create()
    baseYieldPic:init(goodsData.miniIcon)
    baseYieldPic:centerLeft(-33,0)
    baseYieldNum:addChild(baseYieldPic)
    baseYieldPic:setName("baseYieldPic")

    -- 预留buff标签位置
    local buffBaseYieldPic = UI.Button:create()
    buffBaseYieldPic:init("effect_buff_angerend.png")
    buffBaseYieldPic:center(82,0)
    buffBaseYieldPic:setVisible(false)
    buffBaseYieldPic:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
        self:showExplainInfo(buffBaseYieldPic)
    end)
    buffBaseYieldPic:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
        self:closeExplainInfo(buffBaseYieldPic)
    end)
    buffBaseYieldPic.tagDes = 1116340
    buffBaseYieldPic.bonusType = 1
    self.buffBaseYieldPic = buffBaseYieldPic
    baseYieldNum:addChild(buffBaseYieldPic) 

    -- local buffBaseYieldPic = UI.Image:create()
    -- buffBaseYieldPic:init("effect_buff_angerend.png")
    -- buffBaseYieldPic:centerLeft(106,0)
    -- baseYieldNum:addChild(buffBaseYieldPic) 
    -- buffBaseYieldPic:setVisible(true)
    -- self.buffBaseYieldPic = buffBaseYieldPic
    -- self:addBuffListener(buffBaseYieldPic)

    ------------------------

    -- 产量加成
    local yieldAdditionTxt = UI.Text:create()
    yieldAdditionTxt:init(UI.TEXT_226128, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 54, g = 49, b = 58})
    yieldAdditionTxt:center(-180,-135)
    self.leftLayer:addChild(yieldAdditionTxt)

    -- 预留buff标签位置
    local buffAddPic1 = UI.Button:create()
    buffAddPic1:init("effect_buff_angerend.png")
    buffAddPic1:center(33,-135)
    buffAddPic1:setName("buffAddPic1")
    buffAddPic1:setVisible(false)
    buffAddPic1:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
        self:showExplainInfo(buffAddPic1)
    end)
    buffAddPic1:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
        self:closeExplainInfo(buffAddPic1)
    end)
    buffAddPic1.tagDes = 1116340
    buffAddPic1.bonusType = 2
    self.buffAddPic1 = buffAddPic1
    self.leftLayer:addChild(buffAddPic1) 

    -- 预留buff标签位置
    local buffAddPic2 = UI.Button:create()
    buffAddPic2:init("effect_buff_angerend.png")
    buffAddPic2:center(60,-135)
    buffAddPic2:setName("buffAddPic2")
    buffAddPic2:setVisible(false)
    buffAddPic2:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
        self:showExplainInfo(buffAddPic2)
    end)
    buffAddPic2:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
        self:closeExplainInfo(buffAddPic2)
    end)
    buffAddPic2.tagDes = 1116340
    buffAddPic2.bonusType = 3
    self.buffAddPic2 = buffAddPic2
    self.leftLayer:addChild(buffAddPic2) 

    -- 预留buff标签位置
    local buffAddPic3 = UI.Button:create()
    buffAddPic3:init("effect_buff_angerend.png")
    buffAddPic3:center(87,-135)
    buffAddPic3:setName("buffAddPic3")
    buffAddPic3:setVisible(false)
    buffAddPic3:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
        self:showExplainInfo(buffAddPic3)
    end)
    buffAddPic3:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
        self:closeExplainInfo(buffAddPic3)
    end)
    buffAddPic3.tagDes = 1116340
    buffAddPic3.bonusType = 4
    self.buffAddPic3 = buffAddPic3
    self.leftLayer:addChild(buffAddPic3) 

    local yieldAdditionNum = UI.Text:create()
    yieldAdditionNum:init("+50%", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    yieldAdditionNum:center(-50,-135)
    self.leftLayer:addChild(yieldAdditionNum)
    self.yieldAdditionNum = yieldAdditionNum

    ------------------------

    -- 产量减产
    local yieldReductionTxt = UI.Text:create()
    yieldReductionTxt:init(UI.TEXT_226129, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 54, g = 49, b = 58})
    yieldReductionTxt:center(-180,-100)
    self.leftLayer:addChild(yieldReductionTxt)

    -- 预留buff标签位置
    local buffReductionPic = UI.Button:create()
    buffReductionPic:init("effect_buff_angerend.png")
    buffReductionPic:center(33,-100)
    buffReductionPic:setVisible(false)
    buffReductionPic:addEventListener(UIEvent.BUTTON_PRESS, self, function(self)
        self:showExplainInfo(buffReductionPic)
    end)
    buffReductionPic:addEventListener(UIEvent.BUTTON_RELEASE, self, function(self)
        self:closeExplainInfo(buffReductionPic)
    end)
    buffReductionPic.tagDes = 1116340
    buffReductionPic.bonusType = 5
    self.buffReductionPic = buffReductionPic
    self.leftLayer:addChild(buffReductionPic) 
    
    local yieldReductionNum = UI.Text:create()
    yieldReductionNum:init("-100%", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    yieldReductionNum:center(-50,-100)
    self.leftLayer:addChild(yieldReductionNum)
    self.yieldReductionNum = yieldReductionNum

    ------------------------

    
    -- 占领船只 (改成了上岛最低补给需求)
    local occupyBoatTxt = UI.Text:create()
    occupyBoatTxt:init(UI.TEXT_226189, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 54, g = 49, b = 58})
    occupyBoatTxt:center(-180,-65)
    self.leftLayer:addChild(occupyBoatTxt)

    --上岛需求最低补给
    local supplyLimit = ConfigManager:getIslandsByID(self.data.landId).supplyLimit
    local supplyLimitTxtNum = UI.Text:create()
    supplyLimitTxtNum:init(tostring(supplyLimit), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    supplyLimitTxtNum:center(-50,-65)
    self.leftLayer:addChild(supplyLimitTxtNum)
    -- self.occupyBoatTxtNum = occupyBoatTxtNum

    ------------------------

    -- 岛屿展示
    local islandShowPic = UI.Image:create()
    islandShowPic:init("ui_greatnavigation_islanddisplay1_1.png")
    islandShowPic:center(-52,41)
    self.islandShowPic = islandShowPic
    self.leftLayer:addChild(islandShowPic)

    ------------------------

    -- 标记集中占领岛屿
    local occupyStr = self:guildOccupyStatus()
    local occupySignBtn = UI.Button:create()
    occupySignBtn:init("ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png")
    occupySignBtn:center(-50, 170)
    occupySignBtn:setText(occupyStr)
    occupySignBtn:closeClickScale()
    occupySignBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    occupySignBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
            UI.ScrollBar:createByText(UI.TEXT_226170)
            return
        end

        local message = {}
        message.islandid = self.data.landId
        message.isCancel = false

        if self.guildSignStatus == ISLAND_SIGN_STATUS.OCCUPY_SIGN then
            Net.NetBigSailSystem:reqMarkOccupyIsland(message)
        elseif self.guildSignStatus == ISLAND_SIGN_STATUS.OCCUPY_EXCHANGE then
            Net.NetBigSailSystem:reqMarkOccupyIsland(message)
        else
            message.isCancel = true
            Net.NetBigSailSystem:reqMarkOccupyIsland(message)
        end
    end)
    self.leftLayer:addChild(occupySignBtn)
    self.occupySignBtn = occupySignBtn

    ------------------------

    -- 标记敌对帮派
    local signHostilityBtn = UI.Button:create()
    signHostilityBtn:init("ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png")
    signHostilityBtn:center(-50, 232)
    signHostilityBtn:setText(UI.TEXT_226131)
    signHostilityBtn:closeClickScale()
    signHostilityBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    signHostilityBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
            UI.ScrollBar:createByText(UI.TEXT_226170)
            return
        end

        -- 进入界面获取占领该岛屿的随机公会信息
        local message = {}
        message.islandid = self.data.landId
        Net.NetBigSailSystem:reqIslandAllGuilds(message)

        mvc.openPanel("BigSailIsland", "BigSailIslandHostilityGuild", data)
    end)
    self.leftLayer:addChild(signHostilityBtn)
    self.signHostilityBtn = signHostilityBtn



    ------------------------
    -- -- 临时功能按钮,挑战BOSS
    -- local bigBossBtn = UI.Button:create()
    -- bigBossBtn:init("ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png","ui_greatnavigation_btn_3.png")
    -- bigBossBtn:center(-50, 280)
    -- bigBossBtn:setText("挑战BOSS")
    -- bigBossBtn:closeClickScale()
    -- bigBossBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- bigBossBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --     -- local isAssociatedWithBoss1 = ConfigManager:getIslandsByID(self.data.landId).isAssociatedWithBoss
    --     -- if isAssociatedWithBoss1 == 0 then
    --     --     UI.ScrollBar:createByText("当前岛屿不是大岛屿")
    --     --     return 
    --     -- elseif not self.myBoatId then
    --     --     UI.ScrollBar:createByText("当前岛屿上没有自己的船只")
    --     --     return 
    --     -- end
    --     local message = {}
    --     message.islandid = self.data.landId
    --     message.boatid = self.myBoatId
    --     Net.NetBigSailSystem:reqBossBattle(message)
    --     -- mvc.openPanel("BigSailIsland", "BigSailIslandRank")
    -- end)
    -- self.leftLayer:addChild(bigBossBtn)

end

function BigSailIslandInfoView:createRightLayer()
    -- -- 右侧界面刷新
    if self.rightLayer then
        self.rightLayer:removeAllChildren()
    end

    

    -- 顶部文字说明
    local topBoatTxt = UI.Text:create()
    topBoatTxt:init(UI.TEXT_226130, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 59, g = 57, b = 59})
    topBoatTxt:center(-610, -237)
    self._topBoatTxt = topBoatTxt;
    self.rightLayer:addChild(topBoatTxt)

    local topSupplyTxt = UI.Text:create()
    topSupplyTxt:init(UI.TEXT_221611, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 59, g = 57, b = 59})
    topSupplyTxt:center(-350, -237)
    self.rightLayer:addChild(topSupplyTxt)

    local topExpelTxt = UI.Text:create()
    topExpelTxt:init(UI.TEXT_226117, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 59, g = 57, b = 59})
    topExpelTxt:center(-220, -237)
    self.rightLayer:addChild(topExpelTxt)
    ------------------------
    --[[self.boatInfoData = {}
    table.insert(self.boatInfoData , {boat = 23290001, rolename = "咩咩咩的高良君", guildName = "咩咩咩的高良君", suppluCount = 12, pk = 17826827})
    table.insert(self.boatInfoData , {boat = 23290002, rolename = "咩咩", guildName = "贪婪洞窟分窟", suppluCount = 12, pk = 178262827})
    table.insert(self.boatInfoData , {boat = 23290003, rolename = "咩咩咩的高良君", guildName = "贪婪洞窟分窟", suppluCount = 12, pk = 178236827})
    table.insert(self.boatInfoData , {boat = 23290004, rolename = "咩咩咩的高良君", guildName = "贪", suppluCount = 12, pk = 178268427})
    table.insert(self.boatInfoData , {boat = 23290005, rolename = "咩咩咩的高良君", guildName = "贪婪洞窟分窟", suppluCount = 12, pk = 178265827})--]]
    -- 占领船只列表
    local gridListWidth = 541
    local gridListHeight = 385
    local gridList = UI.GridList:create()
    gridList:init(UI.BigSailIslandBoatTableCell, self.verticalNum, self.horizontalNum, 541, 92, 0, 9, 0)
    gridList:setSize(gridListWidth, gridListHeight)
    gridList:center(-430, -12)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.cellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setCircleVisible(false)
    self.bookList = gridList
    self.rightLayer:addChild(self.bookList)
    --print("self.boatInfoData--->: ", self.boatInfoData)
    -- self.bookList:setData(self.boatInfoData)
    ------------------------
    -- 分割遮罩
    local maskDivisionPic = UI.Image:create()
    maskDivisionPic:init("ui_greatnavigation_up.png")
    maskDivisionPic:center(-415 , 170)
    self.rightLayer:addChild(maskDivisionPic)
    ------------------------
    -- 个人占领
    local isOccpy = false
    local boatId = 23290001
    local rolename = ""
    local myGuildName1 = ""
    local suppluCount = 0
    local pk = RoleDataManager:getMaster():getPK()
    if type(self.boatInfoData) == "table" then
        -- for k,v in pairs(self.boatInfoData) do
        --     if v.pk == pk then 
        --         isOccpy = true
        --         boatId = v.boat
        --         rolename = v.rolename
        --         myGuildName1 = v.guildname
        --         suppluCount = v.supplycount
        --     end
        -- end
    end

    local shapeConfig = ConfigManager:getAllBoatData()
    local strBoat = ""
    for k,v in pairs(shapeConfig) do
        if v.ID == boatId then
            local iconList = string.split(v.icon, ";") 
            strBoat = iconList[1]
        end
    end

    -- 个人信息显示
    local personInfoTxt = UI.Text:create()
    personInfoTxt:init(UI.TEXT_226164, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 59, g = 57, b = 59})
    personInfoTxt:center(-570, 225)
    personInfoTxt:setTextLeftUp()
    personInfoTxt:setVisible(false)
    self.rightLayer:addChild(personInfoTxt)
    self.personInfoTxt = personInfoTxt

    local boatBtn = UI.Button:create()
    boatBtn:init(strBoat,strBoat,strBoat)
    boatBtn:center(-625, 225)
    boatBtn:closeClickScale()
    --boatBtn:setScale(0.6)
    boatBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    end)
    self.rightLayer:addChild(boatBtn)
    boatBtn:setVisible(isOccpy)
    self.myBoatBtn = boatBtn

    -- 用户名称
    local userName = UI.Text:create()
    userName:init(rolename, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    userName:center(-485, 215)
    userName:setTextLeftUp()
    self.rightLayer:addChild(userName)
    userName:setVisible(isOccpy)
    self.myUserName = userName

    -- 分割线
    local partingLine = UI.Image:create()
    partingLine:init("ui_greatnavigation_line.png")
    partingLine:center(-485, 230)
    self.rightLayer:addChild(partingLine)
    partingLine:setVisible(isOccpy)
    self.partingLine = partingLine

    -- 公会名称
    local guildName = UI.Text:create()
    guildName:init(myGuildName1, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    guildName:center(-485, 245)
    guildName:setTextLeftUp()
    self.rightLayer:addChild(guildName)
    guildName:setVisible(isOccpy)
    self.myGuildName = guildName

    -- 补给
    local supplyPic = UI.Image:create()
    supplyPic:init("ui_greatnavigation_supply.png")
    supplyPic:center(-353, 230)
    self.rightLayer:addChild(supplyPic)
    supplyPic:setVisible(isOccpy)
    self.mySupplyPic = supplyPic

    local supplyNum = UI.Text:create()
    supplyNum:init(tostring(suppluCount), UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 212, g = 177, b = 72})
    supplyNum:center(20, 0)
    supplyPic:addChild(supplyNum)
    supplyNum:setName("supplyNum")

    -- 取消占领/占领
    local iscan = self:myIsCanOccupyIsland()
    local str = iscan and UI.TEXT_226133 or UI.TEXT_226132
    local occupyBtn = UI.Button:create()
    occupyBtn:init("ui_greatnavigation_btn_2.png","ui_greatnavigation_btn_2.png","ui_greatnavigation_btn_2.png")
    occupyBtn:center(-220, 230)
    occupyBtn:setText(str)
    occupyBtn:closeClickScale()
    occupyBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    occupyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- 是否可以占领岛屿
        local isCanOccupyIsland = true
        local boatId = 0
        isCanOccupyIsland , boatId = self:myIsCanOccupyIsland()

        -- 超过时间关闭界面
        if mvc.bigSailPortModel:getIsPortClose() then
            mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
            UI.ScrollBar:createByText(UI.TEXT_226216)
            return
        end

        if isCanOccupyIsland then
            local message = {}
            message.islandid = self.data.landId
            mvc.openPanel("BigSailIsland", "BigSailIslandDispatch",message)
        else
            if boatId ~= 0 then
                local message = {}
                message.boatId = boatId
                message.landId = self.data.landId
                Net.NetBigSailSystem:reqCancelSail(message)
            end
        end
    end)
    occupyBtn:setVisible(false)
    self.rightLayer:addChild(occupyBtn)
    self.occupyBtn = occupyBtn
end

function BigSailIslandInfoView:guildOccupyStatus()
    -- 公会集中标记占领状态
    local str = UI.TEXT_226134
    if self.guildSignStatus == ISLAND_SIGN_STATUS.OCCUPY_SIGN then
        str = UI.TEXT_226134
    elseif self.guildSignStatus == ISLAND_SIGN_STATUS.OCCUPY_EXCHANGE then
        str = UI.TEXT_226135
    else
        str = UI.TEXT_226136
    end

    return str
end

function BigSailIslandInfoView:exchangeOccupyStatus()
    --print(debug.traceback("exchangeOccupyStatus"))
    -- 设置公会占领岛屿状态
    local guildOccupyIslandId = mvc.bigSailIslandModel:getGuildOccupyIslandId() -- 获取公会标记占领岛屿
    if guildOccupyIslandId == self.data.landId then
        self.guildSignStatus = ISLAND_SIGN_STATUS.OCCUPY_CANCEL
    elseif guildOccupyIslandId > 0 then
        self.guildSignStatus = ISLAND_SIGN_STATUS.OCCUPY_EXCHANGE
    else
        self.guildSignStatus = ISLAND_SIGN_STATUS.OCCUPY_SIGN
    end

    self.occupySignBtn:setText(self:guildOccupyStatus())
end

function BigSailIslandInfoView:setNowOccupyIsland(data)
    if data.isCancel then
        -- 取消标记当前岛屿
        UI.ScrollBar:createByText(UI.TEXT_226172)
        mvc.bigSailIslandModel:setGuildOccupyIslandId(0)
    else
        UI.ScrollBar:createByText(UI.TEXT_226171)
        mvc.bigSailIslandModel:setGuildOccupyIslandId(self.data.landId)
    end
    self:exchangeOccupyStatus()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_BIG_MAP)
end

function BigSailIslandInfoView:isShowYieldBg()
    if self.yieldBgShowBool then
        self.yieldBgShowBool = false
        self.showYieldBg:setVisible(self.yieldBgShowBool)
    else
        self.yieldBgShowBool = true
        self.showYieldBg:setVisible(self.yieldBgShowBool)
    end
end

function BigSailIslandInfoView:refreshBoatList(data)
    self.boatInfoData = mvc.bigSailIslandModel:getIsLandBoatsInfoByLandId(self.data.landId)
    --print("refreshBoatList==>: ", self.boatInfoData)
    -- 左侧
    --local YieldBonus = ConfigManager:getYieldBonusByID()
    local index = 1
    for k,v in pairs(self.boatInfoData.harvestid) do
        if v ~= 0 then
            local YieldBonus = ConfigManager:getYieldBonusByID(v)
            local buffIconstr = YieldBonus.showIcon
            if YieldBonus.bonusType < 4 and index < 4 then
                local button = self.leftLayer:getChildByName("buffAddPic"..index)
                button:setVisible(true)
                button:setNormal(buffIconstr)
                button.tagDes = YieldBonus.tagDes
                index = index + 1
            elseif YieldBonus.bonusType == 4 then 
                self.buffReductionPic:setVisible(true)
                self.buffReductionPic:setNormal(buffIconstr)
                self.buffReductionPic.tagDes = YieldBonus.tagDes
            else
                self.buffBaseYieldPic:setVisible(true)
                self.buffBaseYieldPic:setNormal(buffIconstr)
                self.buffBaseYieldPic.tagDes = YieldBonus.tagDes
            end
        end
    end

    if self.boatInfoData.outputNum  > 0 then
        self.showYieldTxt1:setText(UI.TEXT_226137)
        local config2 = ConfigManager:getAllNavigationGeneralConfigData()
        local seconds = config2[1].yieldCalculationInterval
        self.showYieldNum:setText(tostring(self.boatInfoData.outputNum).."/"..tostring(seconds).."s")
    end
    self.yieldAdditionNum:setText("+"..(tostring(tonumber(self.boatInfoData.addOutputRatio)/100)).."%")
    self.yieldReductionNum:setText("-"..(tostring(tonumber(self.boatInfoData.minusOutputRatio)/100)).."%")
    local boatMaxLimt = ConfigManager:getIslandsByID(self.data.landId).boatMax

    self._topBoatTxt:setText(UI.TEXT_226130 .. "(" .. tostring(self.boatInfoData.totalNum).."/"..tostring(boatMaxLimt) .. ")")
    -- self.occupyBoatTxtNum:setText(tostring(self.boatInfoData.totalNum).."/"..tostring(boatMaxLimt))

    self:exchangeOccupyStatus()

    -- 设置岛屿略图
    local config = ConfigManager:getIslandsByID(self.data.landId)
    local islandPic = config.showPicture
    self.islandShowPic:setSpriteName(islandPic)

    -- 右侧
    -- 个人占领
    local isOccpy = false
    local boatId = 23290001
    local rolename = ""
    local myGuildName1 = ""
    local suppluCount = 0
    local pk = RoleDataManager:getMaster():getPK()
    local status = 0
    
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if v.islandId == self.data.landId then
            status = v.status
        end
    end

    if type(self.boatInfoData) == "table" then
        for k,v in pairs(self.boatInfoData.info) do
            if v.pk == pk then 
                isOccpy = true
                boatId = v.boat
                rolename = v.rolename
                myGuildName1 = v.guildname
                suppluCount = v.supplycount
                --myPets = v.pets
                self.myBoatId = boatId
            end
        end
    end

    -- 这里要加入岛屿id，之后给驱逐界面使用
    for k1,v in pairs(self.boatInfoData.info) do
        self.boatInfoData.info[k1].isLandId = self.boatInfoData.id
        --self.boatInfoData.info[k].myPets = myPets
        self.boatInfoData.info[k1].isEnemy = false
        for k,v1 in pairs(self.boatInfoData.enemyGuilds) do
            if v1 == self.boatInfoData.info[k1].guildid then
                self.boatInfoData.info[k1].isEnemy = true
                break
            end
        end
    end

    -- 获取岛怪数据
    local islandMonsters = self:getIslandMonsterData()

    for k,v in pairs(self.boatInfoData.info) do
        print("islandMonsters--->: ", v)
        local boatData = {}
        boatData.pk = v.pk
        boatData.boat = v.boat
        boatData.guildname = v.guildname
        boatData.supplycount = v.supplycount
        boatData.guildid = v.guildid
        boatData.rolename = v.rolename
        boatData.isMonster = false
        boatData.isLandId = self.boatInfoData.id
        boatData.isEnemy = v.isEnemy
        table.insert(islandMonsters, boatData)
    end

    self.bookList:setData(islandMonsters)
    --self.bookList:setData(self.boatInfoData.info)
    self.occupyBtn:setVisible(true)

    local iscan = self:myIsCanOccupyIsland()
    if isOccpy then
        self.myBoatBtn:setVisible(isOccpy)
        -- local shapeConfig = ConfigManager:getAllBoatData()
        -- local strBoat = ""
        -- for k,v in pairs(shapeConfig) do
        --     if v.ID == boatId then
        --         local iconList = string.split(v.icon, ";") 
        --         strBoat = iconList[1]
        --     end
        -- end

        local shapeConfig = ConfigManager:getAllBoatData()
        local strBoat = "ui_greatnavigation_boat1.png"
        for k,v in pairs(shapeConfig) do
            if v.ID == boatId then
                strBoat = v.navigationShow
            end
        end


        self.myBoatBtn:setNormal(strBoat)
        self.myBoatBtn:setSelected(strBoat)
        self.myBoatBtn:setDisabled(strBoat)

        self.myUserName:setText(rolename)
        self.myUserName:setVisible(isOccpy)

        self.partingLine:setVisible(isOccpy)

        self.myGuildName:setText(myGuildName1)
        self.myGuildName:setVisible(isOccpy)
        self.personInfoTxt:setVisible(false)

        local str = iscan and UI.TEXT_226133 or UI.TEXT_226132
        self.occupyBtn:setText(str)
        self.mySupplyPic:getChildByName("supplyNum"):setText(tostring(suppluCount))
        self.mySupplyPic:setVisible(true)
    else
        local str = iscan and UI.TEXT_226133 or UI.TEXT_226132
        self.occupyBtn:setText(str)

        local str2 = PublicDefine.BigSailBoatStatus.None == status and UI.TEXT_226164 or UI.TEXT_226165
        self.personInfoTxt:setVisible(true)
        self.personInfoTxt:setText(str2)
        self.mySupplyPic:setVisible(false)

        --self.myBoatBtn:setDisabled(false)
        self.myUserName:setVisible(false)
        self.partingLine:setVisible(false)
        self.myGuildName:setVisible(false)
    end

    if data then
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            -- 取消占领
            UI.ScrollBar:createByText(UI.TEXT_226132)
            self:close()
            return
        end
    end


    -- 刷新完岛屿船只基本信息后，去单独获取船只上的宠物信息
    local data = {}
    data.islandid = self.boatInfoData.id
    data.pk = {}
    for k,v in pairs(self.boatInfoData.info) do
        table.insert(data.pk, v.pk)
    end
    Net.NetBigSailSystem:reqBoatDetail(data)
end

function BigSailIslandInfoView:showBoatInfo(pram)
    if type(self.boatInfoData) == "table" and self.boatInfoData.info then
        for k,v in pairs(self.boatInfoData.info) do
            if v.pk == pram.pk then
                pram.pets = v.pets
                mvc.openPanel("BigSailIsland", "BigSailIslandBoatInfo", pram)
                return
            end
        end
    end
end

function BigSailIslandInfoView:myIsCanOccupyIsland()
    -- 是否可以占领岛屿
    local isCanOccupyIsland = true
    local isLandId = self.data.landId
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local boatId = 0
    for k,v in pairs(baseInfo.useBoats) do
        if v.islandId == isLandId and (v.status ~= BigSailBoatStatus.None) then
            isCanOccupyIsland = false
            boatId = v.boatId
        end
    end

    return isCanOccupyIsland, boatId
end

function BigSailIslandInfoView:dispatchSuccess()
    mvc.closePanel("BigSailIsland", "BigSailIslandDispatch")
    self:close()
end

function BigSailIslandInfoView:cellClickCallback(bagGrid)
end

function BigSailIslandInfoView:getIslandMonsterData()
    local monstersData = {}
    local monsterData = mvc.bigSailPortModel:getIslandMonsterInfos()
    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if openMonster then
        if #monsterData > 0 then
            for k,v in pairs(monsterData) do
                if v.islandid == self.boatInfoData.id then
                    for k1,v2 in pairs(v.monsterids) do
                        local monsterConfig = ConfigManager:getIslandMonsterByID(v2)
                        local data = {}
                        data.pk = 0
                        data.boat = v2
                        data.guildname = 0
                        data.supplycount = monsterConfig.itemNum
                        data.guildid = 0
                        data.rolename = 0
                        data.isMonster = true
                        data.isLandId = self.boatInfoData.id
                        table.insert(monstersData, data)
                    end
                end
            end
        end
    end

    table.sort(monstersData, function(a, b)
        return a.boat > b.boat
    end)

    return monstersData
end

function BigSailIslandInfoView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS,self, self.dispatchSuccess)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST,self, self.refreshBoatList)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_SHOW_BOAT_INFO,self, self.showBoatInfo)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_MARK_ISLAND,self, self.setNowOccupyIsland)
end

function BigSailIslandInfoView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_SYNC_DISPATCH_SUCCESS,self, self.dispatchSuccess)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST,self, self.refreshBoatList)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_SHOW_BOAT_INFO,self, self.showBoatInfo)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_MARK_ISLAND,self, self.setNowOccupyIsland)
end

return BigSailIslandInfoView


