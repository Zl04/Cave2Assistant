------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RuneMoldView = class("RuneMoldView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_rune_mold.plist",
    "ui_town_businessactivities.plist",
}
local FILE_NAME = "image/mold/"

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1024--winSize.width
local COM_HEIGHT = 560
local MOLD_BG_WIDTH = 781
local MOLD_BG_HEIGHT = 471
local MOLD_WIDTH = 520
local MOLD_HEIGHT = 370
local BTN_CELL_W = 120
local BTN_CELL_H = 95

function RuneMoldView:ctor()
    RuneMoldView.super.ctor(
    	self,
    	UI.Type.MOLD_FORGING,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.tableCellArr = {}
    self._loadPngResList = {} -- 管理png纹理资源
    self.forgingRuneList = {}
    self.characteristicArr = {}
    self.isRuneBagShow = false
    self.showForgingSucceedAnimation = false
    self._haveIndexList = {}
    self:bindModel()
end

function RuneMoldView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.runemold", "RuneMold", false)
    RuneMoldView.super.init(self, ... )
end

function RuneMoldView:dtor()
    RuneMoldView.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    local textureCache = cc.Director:getInstance():getTextureCache()
    for k, v in ipairs(self._loadPngResList) do
        textureCache:removeTextureForKey(v)
    end
    self._loadPngResList = {}
    self.forgingRuneList = {}
    self.characteristicArr = {}
    self.isRuneBagShow = false
    self.showForgingSucceedAnimation = false
    reload_script_file_mvc("app.modules.runemold.RuneMoldView")
end


function RuneMoldView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg, 30)
    self.bg = bg

    -- title
    local title  = UI.Image:create()
    title:init("ui_bg_title.png")
    title:centerUp(-10)
    contentLayout:addChild(title, 100)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224700, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
    titleText:centerUp(3)
    contentLayout:addChild(titleText, 101)

    -- light
    local decorate  = UI.Image:create()
    decorate:init("ui_mold_decorate.png")
    decorate:leftBottom(-20, 20)
    contentLayout:addChild(decorate, 30)

    self:initRightContent()
    self:makeTabList()
    self:tabCellClick(1)
end

function RuneMoldView:initRightContent()
    -- 内容面板
    local rightLayout = UI.Layout:create();
    rightLayout:init()
    rightLayout:setSize(MOLD_BG_WIDTH, MOLD_BG_HEIGHT)
    rightLayout:centerRight(65)
    self.bg:addChild(rightLayout, 30)
    self.rightLayout = rightLayout

    -- 背景图片
    local rightBg = UI.Image:create()
    rightBg:init("ui_mold_bg.png")
    rightBg:center()
    rightLayout:addChild(rightBg)
    rightBg:setTouchEnable(true)
    rightBg:setSwallowTouches(true)

    -- 背景图片
    local bottomPic = UI.Image:create()
    bottomPic:init("ui_mold_table.png")
    bottomPic:centerBottom(-10)
    rightLayout:addChild(bottomPic)

    local progressBg = UI.Image:create()
    progressBg:init("ui_mold_lable.png")
    progressBg:leftUp(0, 0)
    rightLayout:addChild(progressBg)

    local moldName = UI.Text:create()
    moldName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_218_196_94)
    moldName:leftUp(70, 15)
    rightLayout:addChild(moldName) 
    self.moldName = moldName

    local progressText = UI.Text:create()
    progressText:init("(0/8)", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_218_196_94)
    progressText:leftUp(70+moldName:getContentSize().width, 15)
    rightLayout:addChild(progressText) 
    self.progressText = progressText
    
    local forGingBtn = UI.Button:create();
    forGingBtn:init("ui_mold_btn_1.png","ui_mold_btn_1.png","ui_mold_btn_1.png");
    forGingBtn:center(0, -2)
    forGingBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    forGingBtn:setText(UI.TEXT_224701)
    forGingBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- mvc.send("Rune_Mold_On_Forging")
        Net.NetRoleSystem:reqMoldForging(self.btnData[self.curTabIndex].config.id)
    end)
    bottomPic:addChild(forGingBtn)
    self.forGingBtn = forGingBtn
    forGingBtn:hide()

    local addRuneBtn = UI.Button:create();
    addRuneBtn:init("ui_mold_btn_1.png","ui_mold_btn_1.png","ui_mold_btn_1.png");
    addRuneBtn:center(0, -2)
    addRuneBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    addRuneBtn:setText(UI.TEXT_224702)
    addRuneBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:showRuneBagView()
    end)
    bottomPic:addChild(addRuneBtn)
    self.addRuneBtn = addRuneBtn
    addRuneBtn:hide()

    local closeRuneBagBtn = UI.Button:create();
    closeRuneBagBtn:init("ui_mold_btn_1.png","ui_mold_btn_1.png","ui_mold_btn_1.png");
    closeRuneBagBtn:center(0, -2)
    closeRuneBagBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    closeRuneBagBtn:setText(UI.TEXT_221601)
    closeRuneBagBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:closeRuneBagView()
    end)
    bottomPic:addChild(closeRuneBagBtn)
    self.closeRuneBagBtn = closeRuneBagBtn
    closeRuneBagBtn:hide()

    local useBtn = UI.Button:create();
    useBtn:init("ui_mold_btn_2.png","ui_mold_btn_2.png","ui_mold_btn_2.png");
    useBtn:rightBottom(0, 50)
    useBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    useBtn:setText(UI.TEXT_224706)
    useBtn:setTextWidth(50)
    useBtn:setTextOffset(0, 0)
    useBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.openPanel("UseMold", "UseMold")
    end)
    rightLayout:addChild(useBtn)
    self.useBtn = useBtn
    useBtn:hide()
end

-- function RuneMoldView:addCharacteristicIcon()
    
-- end



function RuneMoldView:makeTabList()
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local moldConfig = ConfigManager:getAllMoldForgingData()
    self.btnData = {}
    for k, v in ipairs(moldConfig) do
        if v.is_hide ~= 1 then
            local tab = {}
            tab.config = v
            tab.name = languageManagerInstance:getLocalString(v.moldName)
            -- tab.viewName = languageManagerInstance:getLocalString(v.name)
            tab.select = false
            -- tab.rootLayer = self.innerContentLayout
            
            table.insert(self.btnData, tab)
        end
    end

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 410)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftUp(55, 80)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(index)
            end,
            function(e)
                printError("------------------------RuneMoldView:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createTabCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        local index = cell:getIdx() + 1
        self:tabCellClick(index, cell)
    end)

    self.bg:addChild(self._tableView, 20)
    self._tableView:reloadData(true)
end

function RuneMoldView:createTabCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(BTN_CELL_W, BTN_CELL_H))

    local image = UI.Image.create()
    image:init("ui_mold_lable_normal.png")
    image:center()
    image:setName("image")
    cell:addChild(image)

    local headImage = self.btnData[index].config.moldIcon
    local head = UI.Image.create()
    head:init(headImage)
    head:center(-13, 0)
    head:setName("head")
    image:addChild(head)


    local fragmentIDList = string.split(self.btnData[index].config.fragmentID, ";")
    local isNew, goodsData = mvc.runeMoldModel:ishaveNewMoldFragment(fragmentIDList)
    local offsetX = 90
    local redPoint = AvalonUtil.createRedPoint(cell, offsetX, 10, 100)
    redPoint:setName("redPoint")
    redPoint:setVisible(isNew)
    if isNew and goodsData then
        goodsData:setIsNew(false)
    end

    if self.curTabIndex ~= index then
        -- text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_mold_lable_normal.png")
        head:center(-13, 0)
    else
        -- text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_mold_lable_select.png")
        head:center(-16, 0)
    end


    self.tableCellArr[index] = cell
    return cell
end

function RuneMoldView:tabCellClick(index)
    if not index then
        return
    end

    local clickIndex = index

    if self.curTabIndex == clickIndex then
        return
    end

    self.curTabIndex = clickIndex
    self.btnData[self.curTabIndex].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex - 1)

    if self.lastTabIndex > 0 and self.btnData[self.lastTabIndex] then
        self.btnData[self.lastTabIndex].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    end

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex, index)
    local cell = self.tableCellArr[index]
    if cell and not tolua.isnull(cell) then
        local redPoint = cell:getChildByName("redPoint")
        if redPoint then
            redPoint:setVisible(false)
        end
    end

    self.lastTabIndex = self.curTabIndex
    -- mvc.dockModel:setTabIndex(self.curTabIndex)
    self:updateRightLayout(self.btnData[self.curTabIndex].config)

end

function RuneMoldView:updateRightLayout(data)
    if self.moldLayout then
        self.moldLayout:removeFromParent(true)
        self.moldLayout = nil
    end
    -- local fragmentIdData = mvc.runeMoldModel:getMoldfragmentData()
    local moldLayout = UI.Layout:create();
    moldLayout:init()
    moldLayout:setSize(MOLD_WIDTH, MOLD_HEIGHT)
    moldLayout:center()
    self.rightLayout:addChild(moldLayout)
    self.moldLayout = moldLayout

    local moldTouchLayout = UI.Layout:create();
    moldTouchLayout:init()
    moldTouchLayout:setSize(MOLD_WIDTH-160, MOLD_HEIGHT-60)
    moldTouchLayout:center()
    self.moldLayout:addChild(moldTouchLayout)
    self.moldTouchLayout = moldTouchLayout

    local unlock, haveNum, totalNum = mvc.runeMoldModel:checkMoldCanForging(data)
    
    local text = string.format(UI.TEXT_224705, haveNum, totalNum)
    self.progressText:setText(text)
    self.moldName:setText(languageManagerInstance:getLocalString(data.moldName))
    self.progressText:leftUp(70+self.moldName:getContentSize().width, 15)

    local moldInfo = mvc.runeMoldModel:getMoldInfo()

    if unlock and moldInfo[data.id] then
        self:initMoldShowView(moldLayout, data)
    else
        self:initFragmentView(moldLayout, data)
    end

    local animName = data.moldExterior1
    local moldSelectAnime = UI.Animation:create()
    moldSelectAnime:init(animName..".json", animName..".atlas", 1);
    moldSelectAnime:center()
    moldLayout:addChild(moldSelectAnime)
    -- moldSelectAnime:setAnimation("idle", false)
    self.moldSelectAnime = moldSelectAnime

    self:updateMoldStat(data, unlock)
end

function RuneMoldView:initMoldShowView(moldLayout, data)
    self.forgingRuneList = {}

    local bgAnime = UI.Animation:create()
    local bgAnimeName = data.moldExterior3
    bgAnime:init(bgAnimeName..".json", bgAnimeName..".atlas", 1)
    bgAnime:center()
    moldLayout:addChild(bgAnime)

    local animName = data.moldExterior2--"effect_ui_town_mold_stone_sphinx"
    local moldAnime = UI.Animation:create()
    moldAnime:init(animName..".json", animName..".atlas", 1);
    moldAnime:center()
    moldLayout:addChild(moldAnime)
    -- moldAnime:setAnimation("idle", false)
    self.moldAnime = moldAnime
    local gemstoneTypeList = string.split(data.gemstoneType, ";")
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local gemstoneSymbolList = string.split(data.gemstoneExterior, ";")
    for k, v in pairs(gemstoneTypeList) do
        local fragNode = moldAnime:getNodeForSlot("fs"..k, true)
        if fragNode then
            local runeGrid = UI.GoodsGrid:create()
            runeGrid:init()
            -- runeGrid:center(-100, -30)
            runeGrid:center()
            runeGrid:hide()
            runeGrid:setScale(0.7)
            runeGrid:showInfoArea(false, false)

            local gridLayout = UI.Layout:create()
            gridLayout:init()
            gridLayout:setSize(70, 70)
            gridLayout:center(0, 0)
            fragNode:addChild(gridLayout)
            gridLayout:addChild(runeGrid, 100)
            gridLayout.grid = runeGrid
            gridLayout:setTouchEnable(true)
            gridLayout.index = k
            gridLayout.type = tonumber(v)
            -- table.insert(self.forgingRuneList, gridLayout)
            self.forgingRuneList[k] = gridLayout
            runeGrid:enableDrage()
            runeGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
            runeGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
            runeGrid:setDragOutAreaJudgeNode(gridLayout)

            local symbol = UI.Image.create()
            symbol:init("groove/"..gemstoneSymbolList[k])
            symbol:center(1, 4)
            symbol:setName("symbol")
            gridLayout:addChild(symbol)
            symbol:hide()
        end
    end

    local characteristicList = string.split(data.characteristicIcon, ";") 
    local startX = 60
    -- for k, v in pairs(characteristicList) do
    --     local characteristicIcon = UI.Image:create()
    --     characteristicIcon:init(v)
    --     characteristicIcon:rightUp(70-startX*k, -45)
    --     self.moldLayout:addChild(characteristicIcon, 99)
    --     characteristicIcon:hide()
    --     self.characteristicArr[k] = characteristicIcon
    -- end

    -- local activeIcon = UI.Image:create()
    -- activeIcon:init(data.activationIcon)
    -- activeIcon:rightUp(70-startX*2, -45)
    -- self.moldLayout:addChild(activeIcon, 99)
    -- activeIcon:hide()
    -- self.activeIcon = activeIcon

    local characteristicIcon = UI.Animation:create()
    characteristicIcon:init("effect_ui_town_mold_features.json", "effect_ui_town_mold_features.atlas", 1);
    characteristicIcon:rightUp(90-startX, -19)
    self.moldLayout:addChild(characteristicIcon)
    characteristicIcon._spine:setSkin(data.characteristicSpine)
    characteristicIcon:hide()
    self.characteristicIcon = characteristicIcon
    characteristicIcon:setAnimation("idle", false)

    local activeIcon = UI.Animation:create()
    activeIcon:init("effect_ui_town_mold_features.json", "effect_ui_town_mold_features.atlas", 1);
    activeIcon:rightUp(90-startX*2, -19)
    self.moldLayout:addChild(activeIcon)
    activeIcon._spine:setSkin(data.activationSpine)
    activeIcon:hide()
    self.activeIcon = activeIcon
    activeIcon:setAnimation("idle", false)


    if not moldInfo[data.id] then
        moldAnime:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
            if(event and event.eventData) then
                if event.eventData.name == "update_view" then
                    self:updateMoldStat(data, true)
                end
            end
        end)
    end
end

function RuneMoldView:initFragmentView(moldLayout, data)
    local moldAnime = UI.Animation:create()
    local animName = data.moldExterior3
    moldAnime:init(animName..".json", animName..".atlas", 1);--(data.moldExterior1..".json", data.moldExterior1..".atlas", 1);
    moldAnime:center()
    moldLayout:addChild(moldAnime)
    -- moldAnime:setAnimation("idle", true)
    self.moldAnime = moldAnime

    self._haveIndexList = {}
    local fragmentIDList = string.split(data.fragmentID, ";")
    local haveFragmentNum = 0
    local totalNum = #fragmentIDList
    for k, v in pairs(fragmentIDList) do
        v = tonumber(v)
        local itemData = ConfigManager:getVirtualItemConfigByID(v)
        local imageName = FILE_NAME..itemData.value1
        table.insert(self._loadPngResList, imageName)

        local icon = UI.ImageButton:create()
        icon:init(imageName, 0, 0)
        icon:setTag("sp"..k)
        icon:setSwallowTouches(false)
        icon:setInterceptTouches(true)
        icon:addEventListener(UIEvent.IMAGE_BUTTON_CLICK, self, function()
            self:fragmentClicked(icon, data, k, v)
        end)
        icon:setOpacity(0)
        -- icon:addEventListener(UIEvent.IMAGE_BUTTON_CLICK_OUTSIDE, self, onTouchFragmentOutSide)
        local fragNode = moldAnime:getNodeForSlot("sp"..k, true)  

        local clippingNode = UI.ClippingNode:create()
        clippingNode:initWithFileName(imageName, 0.0)
        clippingNode:addInnerNode(icon)
        clippingNode:center()
        fragNode:addChild(clippingNode, 9999)
        -- icon:setClippingNode(clippingNode)
        local fragmentIdData = mvc.runeMoldModel:getMoldfragmentData()
        for k2,v2 in pairs(fragmentIdData) do 
            if(v2 == v) then
                icon:setOpacity(255)
                haveFragmentNum = haveFragmentNum + 1
                table.insert(self._haveIndexList, k)
                break
            end 
        end 
        -- clippingNode:enableDebugDraw()
    end
end

function RuneMoldView:fragmentClicked(sender, data, index, fragmentID)
    -- sender:setOpacity(0)
    if sender then
        local skin = sender:getTag()
        self.moldSelectAnime._spine:setSkin(skin)
        self.moldSelectAnime:setToSetupPose()

        local haveIcon = false
        for k,v in ipairs(self._haveIndexList) do
            if v == index then
                haveIcon = true
                break
            end
        end

        if haveIcon then
            self.moldSelectAnime:setAnimation("idle-top", true)
        else
            self.moldSelectAnime:setAnimation("idle-bottom", true)
        end

        -- show des
        local desConfig = sender:getOpacity() > 0 and data.fragmentDes2 or data.fragmentDes1
        local fragmentDesList = string.split(desConfig, ";")
        local titleConfig = sender:getOpacity() > 0 and data.fragmentTitle2 or data.fragmentTitle1
        local titleConfig = string.split(titleConfig, ";")

        local text = languageManagerInstance:getLocalString(tonumber(fragmentDesList[index]))
        local name = languageManagerInstance:getLocalString(tonumber(titleConfig[index]))

        local goodsData = GoodsDataManager:getVirtualGoodsDataByGoodsID(fragmentID)
        if goodsData and goodsData:getIsNew() then
            goodsData:setIsNew(false)
        end

        self:showDesLayer(name, text)
    end
end

function RuneMoldView:runeLayoutClicked(index)
    
    local data = self.btnData[self.curTabIndex].config
    -- show des
    local desConfig = data.gemstoneDes
    local fragmentDesList = string.split(desConfig, ";")
    local titleConfig = data.gemstoneTitle
    local titleConfig = string.split(titleConfig, ";")

    local text = languageManagerInstance:getLocalString(tonumber(fragmentDesList[index]))
    local name = languageManagerInstance:getLocalString(tonumber(titleConfig[index]))
    self:showDesLayer(name, text)
end

function RuneMoldView:characteristicClicked()
    
    local data = self.btnData[self.curTabIndex].config

    moldInfo = mvc.runeMoldModel:getMoldInfo()
    local moldRuneData = moldInfo[data.id]
    
    local gemstoneTypeList = string.split(data.gemstoneType, ";")
    local activeLevelList = string.split(data.effectiveLevel, ";")

    local activeLevel = 1
    local isActive = false
    local isMaxLevel = false
    if moldRuneData.gemIds and #moldRuneData.gemIds == #gemstoneTypeList then
        isActive = true
        activeLevel = mvc.runeMoldModel:getCharacteristicLevel(moldRuneData.gemIds)

    end
    local cruKey = mvc.runeMoldModel:getCharacteristicDesKeyByLevel(activeLevelList, activeLevel)
    -- show des
    local desConfig = data.characteristicDes
    local fragmentDesList = string.split(desConfig, ";")
    local titleConfig = data.characteristicTitle
    local titleConfig = string.split(titleConfig, ";")

    local text = languageManagerInstance:getLocalString(tonumber(fragmentDesList[cruKey]))
    local name = languageManagerInstance:getLocalString(tonumber(titleConfig[cruKey]))
    local nextText = ""
    if (cruKey) == table.getn(fragmentDesList) then
        isMaxLevel = true
    else
        nextText = languageManagerInstance:getLocalString(tonumber(fragmentDesList[cruKey+1]))
    end
    
    self:showCharacteristicDesLayer(name, text, isActive, nextText, cruKey, isMaxLevel)
end

function RuneMoldView:activeIconClick(index)
    
    local data = self.btnData[self.curTabIndex].config
    -- show des
    local desConfig = data.activationDes
    -- local fragmentDesList = string.split(desConfig, ";")
    local titleConfig = data.activationTitle
    -- local titleConfig = string.split(titleConfig, ";")

    local text = languageManagerInstance:getLocalString(tonumber(desConfig))
    local name = languageManagerInstance:getLocalString(tonumber(titleConfig))
    self:showDesLayer(name, text)
end

function RuneMoldView:showDesLayer(name, text)
    local logLayer = self:getChildByName("logLayer")
    if logLayer and not tolua.isnull(logLayer) then
        logLayer:close()
    end
    local data = {
        title = name,
        tips = text,
        bg = "ui_mold_paper_3.png"
    }
    local logLayer = mvc.runeMoldDetialView:create(data)
    logLayer:init()
    local width = logLayer:getContentSize().width/2
    logLayer:center(COM_WIDTH/2-width, 0)
    logLayer:setName("logLayer")
    self:addChild(logLayer, 500)
end

function RuneMoldView:showCharacteristicDesLayer(name, text, isActive, nextText, activeLevel, isMaxLevel)
    local logLayer = self:getChildByName("logLayer")
    if logLayer and not tolua.isnull(logLayer) then
        logLayer:close()
    end
    local data = {
        title = name,
        tips = text,
        nextText = nextText,
        bg = "ui_mold_paper_3.png",
        isActive = isActive,
        activeLevel = activeLevel,
        isMaxLevel = isMaxLevel
    }
    local logLayer = mvc.runeMoldCharacteristicDesView:create(data)
    logLayer:init()
    local width = logLayer:getContentSize().width/2
    logLayer:center(COM_WIDTH/2-width, 0)
    logLayer:setName("logLayer")
    self:addChild(logLayer, 500)
end

function RuneMoldView:showRuneBagView()
    local posX, posY = self.bg:getPosition()
    local baseTime = 0.1

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX-30, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            
        end)
    )
    self.bg:runAction(action)

    local posX, posY = self.rightLayout:getPosition()
    local baseTime = 0.1

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX-130, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            self.isRuneBagShow = true
            -- self.closeRuneBagBtn:show()
            -- self.addRuneBtn:hide()
        end)
    )
    self.rightLayout:runAction(action)
    
    local moldRuneBagView = mvc.runeMoldBagContentView:create()
    moldRuneBagView:init()
    moldRuneBagView:centerRight(-80, 0)
    moldRuneBagView:setName("moldRuneBagView")
    self.contentLayout:addChild(moldRuneBagView, 99)
    self.closeRuneBagBtn:show()
    self.addRuneBtn:hide()
end

function RuneMoldView:closeRuneBagView()
    local moldRuneBagView = self.contentLayout:getChildByName("moldRuneBagView")
    if moldRuneBagView and not tolua.isnull(moldRuneBagView) then
        moldRuneBagView:close()
        -- mvc.send("Rune_Mold_On_Bag_Close")
    end
end



function RuneMoldView:onBagViewClose()
    local posX, posY = self.bg:getPosition()
    local baseTime = 0.1

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX+30, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            
        end)
    )
    self.bg:runAction(action)

    local posX, posY = self.rightLayout:getPosition()
    local baseTime = 0.1

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX+130, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            self.isRuneBagShow = false
            -- self.closeRuneBagBtn:hide()
            -- self.addRuneBtn:show()
        end)
    )
    self.rightLayout:runAction(action)
    self.closeRuneBagBtn:hide()
    self.addRuneBtn:show()
end

function RuneMoldView:onDragEnd(touchPosition, grid)
    local goodsData = grid:getData()
    local isAdd = false
    local isReplace = false
    local replaceKey = nil
    for k, v in pairs(self.forgingRuneList) do
        print("onDragEndsdsd: ", v.type,goodsData.gemstoneType, goodsData:getGemStoneType(),touchPosition, v:checkTouchPosition(touchPosition))
        

        if v.type == goodsData.gemstoneType then
            if not v.grid:getData() then
                isAdd = true
                local gemData = {
                    gemId = goodsData:getId(),
                    pos = k
                }
                Net.NetRoleSystem:reqMoldGemInlaid(self.btnData[self.curTabIndex].config.id, gemData, 1)
                break
            else
                local runeData = v.grid:getData()
                if runeData:getId() == goodsData:getId() then
                    return
                end

                if not isReplace  then
                    isReplace = true
                    replaceKey = k
                end
            end
        end 
    end

    if isReplace then
        isAdd = true
        local gemData = {
            gemId = goodsData:getId(),
            pos = replaceKey
        }
        Net.NetRoleSystem:reqMoldGemInlaid(self.btnData[self.curTabIndex].config.id, gemData, 1)
    end

    if not isAdd then
        UI.ScrollBar:createByText(UI.TEXT_224703)
    end
end

function RuneMoldView:updateMoldStat(data, unlock)
    -- local unlock = mvc.runeMoldModel:checkMoldCanForging(data)
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    if unlock then
        if moldInfo[data.id] then
            self.moldAnime:setAnimation("idle2", false)
            self.forGingBtn:hide()
            self.addRuneBtn:show()
            self.useBtn:show()
            for k, gridLayout in pairs(self.forgingRuneList) do
                gridLayout:setTouchEnable(true)
                gridLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
                    self:runeLayoutClicked(k)
                end)--self.runeLayoutClicked, k)

                local symbol = gridLayout:getChildByName("symbol")
                symbol:show()
                -- if symbol then
                -- end
            end

            local text = languageManagerInstance:getLocalString(tonumber(data.fragmentDes3))
            local name = languageManagerInstance:getLocalString(tonumber(data.fragmentTitle3))

            if self.moldTouchLayout then
                self.moldTouchLayout:setTouchEnable(true)
                self.moldTouchLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
                    self:showDesLayer(name, text)
                end)--self.showDesLayer, name, text)
            end

            local moldRuneData = moldInfo[data.id]
            if moldRuneData.gemIds and #moldRuneData.gemIds > 0 then
                for k, v in pairs(moldRuneData.gemIds) do
                    -- local goodsData = GoodsDataManager:createLocalGoodsData(v.gemId)
                    self:updateRuneGrid(v.gemId, v.pos)
                end
            end

            -- for k, icon in pairs(self.characteristicArr) do
            --     icon:show()
            --     icon:setTouchEnable(true)
            --     icon:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
            --         self:characteristicClicked(moldRuneData)
            --     end)
            -- end
            if self.characteristicIcon then
                self.characteristicIcon:show()
                self.characteristicIcon:setTouchEnable(true)
                self.characteristicIcon:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
                    self:characteristicClicked(moldRuneData)
                end)
            end

            if self.activeIcon then
                self.activeIcon:show()
                -- if self.showForgingSucceedAnimation then
                --     self.activeIcon:setAnimation("begin", false)
                --     self.activeIcon:addAnimation("idle", true)
                -- end
                self.activeIcon:setTouchEnable(true)
                self.activeIcon:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
                    self:activeIconClick()
                end)
            end
            
        else
            self.moldAnime:setAnimation("idle", false)
            self.forGingBtn:show()
            self.addRuneBtn:hide()
            self.useBtn:hide()
        end
    else
        -- self.moldAnime:setAnimation("idle", false)
        -- self.forGingBtn:show()
        self.addRuneBtn:hide()
        self.useBtn:hide()
        
    end 

end

function RuneMoldView:updateRuneGrid(gemId, pos, isAdd)
    local goodsData = GoodsDataManager:createLocalGoodsData(gemId)
    local grid = self.forgingRuneList[pos].grid
        
    grid:setData(goodsData)
    grid:show()
    grid:hideCountLabel()
    grid:updateView()

    performWithDelay(self, function() 
        grid:hideRare()
        grid:hideBG()
        grid:hideFlagIcon()
        grid:hideGemLevel()
    end, 0.001)
    
end

function RuneMoldView:resetRuneGrid(gemId, pos)
    local grid = self.forgingRuneList[pos].grid
    grid:reset()
    grid:hide()
    grid:updateView()
end

function RuneMoldView:onForgingSucceed(data)
    if data.configId ~= self.btnData[self.curTabIndex].config.id then
        return
    end
    self.showForgingSucceedAnimation = true
    self:updateRightLayout(self.btnData[self.curTabIndex].config)
    self.moldAnime:setAnimation("trigger", false)

    if self.activeIcon and not tolua.isnull(self.activeIcon) then
        self.activeIcon:setAnimation("begin", false)
        self.activeIcon:addAnimation("idle", true)
    end
end

function RuneMoldView:onInlaidSucceed(data)
    local config = self.btnData[self.curTabIndex].config

    local gemData = data.gem
    if data.configId == config.id and data.opType == 1 then
        local moldInfo = mvc.runeMoldModel:getMoldInfo()
        local moldRuneData = moldInfo[data.configId]
        local gemstoneTypeList = string.split(config.gemstoneType, ";")
        local runeGrooveNum = table.getn(gemstoneTypeList)
        local runeUsedNum = table.getn(moldRuneData.gemIds)
        if runeUsedNum == runeGrooveNum then
            local lastMoldInfo = mvc.runeMoldModel:getLastMoldInfo()
            local lastMoldRuneData = lastMoldInfo[data.configId]
            if table.getn(lastMoldRuneData.gemIds) < runeGrooveNum then
                if self.characteristicIcon and not tolua.isnull(self.characteristicIcon) then
                    self.characteristicIcon:setAnimation("begin", false)
                    self.characteristicIcon:addAnimation("idle", true)
                end
            end
        end

        self:updateRuneGrid(gemData.gemId, gemData.pos)
    end

    if data.opType == 2 then
        self:resetRuneGrid(gemData.gemId, gemData.pos)
    end
end

function RuneMoldView:onTouchBeganByGoodsGrid()

end

function RuneMoldView:onTouchEndedByGoodsGrid(grid, inSide, touchPosition)
    local gridLayout = grid:getParent()
    local gridData = grid:getData()
    if not inSide then
        local gemData = {
            gemId = gridData:getId(),
            pos = gridLayout.index
        }
        Net.NetRoleSystem:reqMoldGemInlaid(self.btnData[self.curTabIndex].config.id, gemData, 2)
    end
end

function RuneMoldView:bindModel()

end


function RuneMoldView:unbindModel()

end





return RuneMoldView












