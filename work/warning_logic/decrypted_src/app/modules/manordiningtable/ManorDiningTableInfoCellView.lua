------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/22
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDiningTableInfoCellView = class("ManorDiningTableInfoCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home.plist",
}

local COM_WIDTH = 838
local COM_HEIGHT = 143


function ManorDiningTableInfoCellView:ctor(data)
    ManorDiningTableInfoCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.canEat = true
    self:bindModel()
    Avalon.Scheduler:scheduleUpdate(self, self.updateTransformPgs)
end

function ManorDiningTableInfoCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordiningtable", "ManorDiningTable", false)
    ManorDiningTableInfoCellView.super.init(self, ... )
end

function ManorDiningTableInfoCellView:dtor()
    ManorDiningTableInfoCellView.super.dtor(self)
    self:unbindModel()
    self.data = {}
    Avalon.Scheduler:unscheduleUpdate(self, self.updateTransformPgs)
    reload_script_file_mvc("app.modules.manordiningtable.ManorDiningTableInfoCellView")
end


function ManorDiningTableInfoCellView:onInitView()
     -- 内容面板
     local contentLayout = UI.Layout:create()
     contentLayout:init()
     contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
     contentLayout:center()
     self:addChild(contentLayout)
     self.contentLayout = contentLayout
 
     -- 背景图片
     local centerBg  = UI.Image:create()
     centerBg:init("ui_cook_bg.png")
     centerBg:center()
     contentLayout:addChild(centerBg)

     local foodImg  = UI.Image:create()
     foodImg:init(self.data.icon)
     foodImg:centerLeft(18, 0)
     contentLayout:addChild(foodImg)
    --  self.foodImg = foodImg

    local foodName = UI.Text:create()
    foodName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_181_175_169)
    foodName:centerLeft(150, -23)
    foodName:setName("foodName")
    contentLayout:addChild(foodName)
    self.foodName = foodName

    local lockLayout = UI.Layout:create()
    lockLayout:init()
    lockLayout:setSize(180, 30)
    lockLayout:centerRight(50, -47)
    contentLayout:addChild(lockLayout)
    self.lockLayout = lockLayout
    -- lockLayout:enableDebugDraw()
    -- lockLayout:hide()

    local lockImage  = UI.Image:create()
    lockImage:init("ui_home_retrofit_lock.png")
    lockImage:centerLeft(0, 0)
    lockLayout:addChild(lockImage)

    local lockTxt = UI.Text:create()
    lockTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    lockTxt:centerLeft(33, 0)
    lockLayout:addChild(lockTxt)
    self.lockTxt = lockTxt

    -- 生效面板
    local effectLayout = UI.Layout:create()
    effectLayout:init()
    effectLayout:setSize(180, 30)
    effectLayout:centerRight(50, -47)
    contentLayout:addChild(effectLayout)
    self.effectLayout = effectLayout
    effectLayout:hide()

    local effectTxt = UI.Text:create()
    effectTxt:init(UI.TEXT_222904, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_181_175_169)
    effectTxt:centerLeft(420, -23)
    contentLayout:addChild(effectTxt)

    local effectTimeImg  = UI.Image:create()
    effectTimeImg:init("ui_information_clock_bg.png")
    effectTimeImg:centerLeft(0, 0)
    effectLayout:addChild(effectTimeImg)

    local effectTimeTxt = UI.Text:create()
    effectTimeTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    effectTimeTxt:centerLeft(30, 0)
    effectLayout:addChild(effectTimeTxt)
    self.effectTimeTxt = effectTimeTxt

    local effectImg  = UI.Image:create()
    effectImg:init("ui_cook_box.png")
    effectImg:centerLeft(125, 0)
    effectLayout:addChild(effectImg)

    local edibled  = UI.Text:create()
    edibled:init(UI.TEXT_222906, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_22_76_6)
    edibled:setAnchorPoint(0.5, 0.5)
    edibled:rotate(15)
    edibled:centerUp(20)
    effectImg:addChild(edibled, -1)

    -- 配方面板
    local recipeLayout = UI.Layout:create()
    recipeLayout:init()
    recipeLayout:setSize(180, 82)
    recipeLayout:centerLeft(139, 10)
    contentLayout:addChild(recipeLayout)
    self.recipeLayout = recipeLayout

    -- 效果面板
    local effectTxtLayout = UI.Layout:create()
    effectTxtLayout:init()
    effectTxtLayout:setSize(420, 80)
    effectTxtLayout:centerRight(20, 15)
    contentLayout:addChild(effectTxtLayout)
    self.effectTxtLayout = effectTxtLayout
    -- effectTxtLayout:enableDebugDraw()

    -- 食用
    local eatBtn = UI.Button:create();
    eatBtn:init("ui_cook_btn.png","ui_cook_btn.png","ui_cook_btn.png");
    eatBtn:centerRight(40, 20)
    -- local coundDown = string.format(UI.TEXT_1213023, self.refreshRoomInterval)
    eatBtn:setText(UI.TEXT_222905)
    eatBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    eatBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickEat)
    contentLayout:addChild(eatBtn, 100)
    self.eatBtn = eatBtn

    self:initRecipeView()
    self:initEffectTxtLayout()
    self:updateCellView()
end

function ManorDiningTableInfoCellView:updateCellView()
    local name = languageManagerInstance:getLocalString(self.data.name) 
    self.foodName:setText(name)
    local buffID = mvc.manorDiningTableModel:getBuffID(self.data)
    local hasEat = mvc.manorDiningTableModel:checkBuffIsExist(buffID)
    print("checkBuffIsExist:", hasEat)
    if hasEat then
        self.effectLayout:show()
        self.eatBtn:hide()
        self:updateTransformPgs()
    else
        self.effectLayout:hide()
        self.eatBtn:enable()
    end


    local isLock = mvc.manorDiningTableModel:checkRecipeHasUnlock(self.data)
    self.lockLayout:setVisible(isLock)
    if isLock then
        self.eatBtn:hide()
        local lockStr = string.format(UI.TEXT_222909, self.data.unlockLevel)
        self.lockTxt:setText(lockStr)
    end
end

function ManorDiningTableInfoCellView:initRecipeView()
    if self.recipeLayout then
        self.recipeLayout:removeAllChildren()
    end
    local recipeMaterial = self.data.recipeMaterial
    local recipeList = string.split(recipeMaterial, ";")
    local recipeNumList = string.split(self.data.recipeMaterialNum, ";")
    local recipeDisplaylList = string.split(self.data.recipeDisplay, ",")
    for k, v in pairs(recipeList) do
        local idList = string.split(v, ",")
        -- local itemID = tonumber(idList[1])
        -- local itemData = ConfigManager:getMaterialConfigByID(itemID) or ConfigManager:getPropConfigByID(itemID)
        
        local itemName = languageManagerInstance:getLocalString(tonumber(recipeDisplaylList[k])) 
        local itemTotalNum = mvc.manorDiningTableModel:getRecipeItemNum(idList)
        local needNum = tonumber(recipeNumList[k])
        local color = itemTotalNum >= needNum and UI.FONT_COLOR_41_41_45 or UI.FONT_COLOR_130_15_15
        if itemTotalNum < needNum  then
            self.canEat = false
        end
        local str = string.format(itemName, itemTotalNum)
        local foodNum = UI.Text:create()
        foodNum:init(str, UI.FONT_BOLD, UI.FONT_SIZE_16PX, color)
        foodNum:centerUp(-10+20*k)
        self.recipeLayout:addChild(foodNum)
    end
end

function ManorDiningTableInfoCellView:initEffectTxtLayout()
    if self.effectTxtLayout then
        self.effectTxtLayout:removeAllChildren()
    end

    local description = self.data.description
    local descriptionList = string.split(description, ";")
    -- local recipeNumList = string.split(self.data.recipeMaterialNum, ";")
    
    for k, v in pairs(descriptionList) do
        local str = tonumber(v) == 0 and " " or languageManagerInstance:getLocalString(tonumber(v))
        local effectTxt = UI.Text:create()
        effectTxt:init(str, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        effectTxt:setWidth(230)
        effectTxt:autoAdapt()
        effectTxt:leftUp(10, -30+40*k)
        self.effectTxtLayout:addChild(effectTxt)
    end
end

function ManorDiningTableInfoCellView:updateTransformPgs()
    local heroData = RoleDataManager:getMaster()
   
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(heroData:getSpriteID())
    local buffData
    local buffID = mvc.manorDiningTableModel:getBuffID(self.data)
    -- local buffID = tonumber(self.data.buffId)
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            if v.buffID == buffID then
                buffData = v
            end
        end
    end
    -- if not buffData then
    --     Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.updateTransformPgs, 0.5)
    --     return
    -- end

    if buffData then
        local remind = buffData:getDuration() 
        local date = GameManager:getNowServerDate("%H:%M:%S", remind)
        -- print("remind:", remind, date)
        self.effectTimeTxt:setText(date)
    end
    
end

function ManorDiningTableInfoCellView:clickEat()
    if not self.canEat then
        UI.ScrollBar:createByText(UI.TEXT_222908)
        return 
    end
    local buffID = mvc.manorDiningTableModel:getBuffID(self.data)
    if mvc.manorDiningTableModel:checkSameBuffTypeIsExist(buffID) then
        UI.ScrollBar:createByText(UI.TEXT_222910)
        return 
    end
    Net.NetManorSystem:requestUseRecipe(self.data.ID)
end

function ManorDiningTableInfoCellView:bindModel()

end


function ManorDiningTableInfoCellView:unbindModel()

end





return ManorDiningTableInfoCellView












