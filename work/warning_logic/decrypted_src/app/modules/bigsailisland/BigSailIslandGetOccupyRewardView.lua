------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandGetOccupyRewardView = class("BigSailIslandGetOccupyRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 558
local COM_HEIGHT = 393
local winSize = cc.Director:getInstance():getWinSize()

-- 船只状态
local BigSailBoatStatus = PublicDefine.BigSailBoatStatus

function BigSailIslandGetOccupyRewardView:ctor()
    BigSailIslandGetOccupyRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.islandsMapData = mvc.bigSailIslandModel:getMapShowData()
    self.portOutput = mvc.bigSailPortModel:getBaseData().outputNum
end

function BigSailIslandGetOccupyRewardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandGetOccupyRewardView.super.init(self, ... )
end

function BigSailIslandGetOccupyRewardView:dtor()
    BigSailIslandGetOccupyRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandGetOccupyRewardView")
end


function BigSailIslandGetOccupyRewardView:onInitView()
    self:center(0, 0)
    --self:enableDebugDraw()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0,0)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(COM_WIDTH / 2, COM_HEIGHT / 2)
    self.contentLayout:addChild(mask, 0)

    local bgImage = UI.Image:create()
    bgImage:init("ui_greatnavigation_paper_6.png")
    bgImage:center(0, 0)
    self.contentLayout:addChild(bgImage)

    -- 占领奖励
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226155, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 255, g = 217, b = 41})
    titleText:center(0, -140)
    self.contentLayout:addChild(titleText)

    -- 当前总产量
    local titleText1 = UI.Text:create()
    titleText1:init(UI.TEXT_226156..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    titleText1:center(-130, -40)
    self.contentLayout:addChild(titleText1)

    local config2 = ConfigManager:getAllNavigationShopData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
    local materialsImage = UI.Image:create()
    materialsImage:init(goodsData.miniIcon)
    materialsImage:center(100, 0)
    titleText1:addChild(materialsImage)

    local config2 = ConfigManager:getAllNavigationGeneralConfigData()
    local seconds = config2[1].yieldCalculationInterval
    local titleText3 = UI.Text:create()
    titleText3:init(tostring(self.islandsMapData.everyOutputNum).."/"..tostring(seconds).."s", UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    titleText3:center(160, 0)
    titleText1:addChild(titleText3)

    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local allOccupy = 0
    for k,v in pairs(baseInfo.useBoats) do
        if v.status == BigSailBoatStatus.BigSailBoatingCaptured then
            allOccupy = allOccupy + 1
        end
    end
    local titleText4 = UI.Text:create()
    titleText4:init("("..UI.TEXT_226112..":".." "..tostring(allOccupy)..")", UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    titleText4:center(280, 0)
    titleText1:addChild(titleText4)

    -- 已经获得资源
    local getText = UI.Text:create()
    getText:init(UI.TEXT_226157..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    getText:center(-130, 20)
    self.contentLayout:addChild(getText)

    local config2 = ConfigManager:getAllNavigationShopData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
    local materialsImage2 = UI.Image:create()
    materialsImage2:init(goodsData.miniIcon)
    materialsImage2:center(100, 0)
    getText:addChild(materialsImage2)

    local getText1 = UI.Text:create()
    getText1:init(tostring(self.islandsMapData.myOutputNum + self.portOutput), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    getText1:center(160, 0)
    getText:addChild(getText1)

    -- 领取 TEXT_111035
    -- UNSUCCESS_TAB 一键完成按钮
    local successBtn = UI.Button:create()
    successBtn:init("ui_greatnavigation_btn_3.png", "ui_greatnavigation_btn_3.png")
    successBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.islandsMapData.myOutputNum + self.portOutput <= 0 or tonumber(getText1:getText()) == 0 then
            UI.ScrollBar:createByText(UI.TEXT_1212923)
            return
        end

        UI.ScrollBar:createByText(UI.TEXT_1212026)
        local message = {}
        message.mypk = RoleDataManager:getMasterPK()
        Net.NetBigSailSystem:reqGetOccupyReward(message)
        getText1:setText(0)
    end)
    successBtn:setText(UI.TEXT_111035)
    successBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 57, g = 56, b = 56})
    successBtn:center(0, 120)
    successBtn:closeClickScale()


    self.contentLayout:addChild(successBtn)
end


function BigSailIslandGetOccupyRewardView:bindModel()

end


function BigSailIslandGetOccupyRewardView:unbindModel()

end





return BigSailIslandGetOccupyRewardView












