--[[
    USING:藏宝图UI
    AHTUOR:CHENZIHAN
]]
require "app.config.ConfigManager"
require "app.ui.baglayer.TaskLayer.TaskAwardGrid"
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}
local TreasureMapLayer = class("TreasureMapLayer",UI.HWBtnComponent)
UI.TreasureMapLayer = TreasureMapLayer
local FILE_NAME = "image/fragment/"
-- 配置表中的藏宝图数据
local treasureMapData_C = ConfigManager:getTreasuremapConfigList()
local fragmentData_C = ConfigManager:getFragmentConfigList()
local size = cc.Director:getInstance():getWinSize()
local RES = {
   "ui_common_npcIcon.plist",
   "ui_general_uishare.plist",
}

local n = {}
-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534

local  BG_CONTENT = "ui_task_banner_content2.png"       -- 内容背景图
local  BG_THREAD = "ui_task_banner_easuremap.png"        -- 线索背景图
local  BG_QUESTION_MARK = "ui_task_banner_reward_up.png" -- 问号图
local  BOX1 = "ui_task_banner_reward_box_1.png"         -- 白色背景图

local FRAGMMENTBG_ATLAS = "effect_ui_package_task_treasuremap.atlas"
local FRAGMMENTBG_JSON = "effect_ui_package_task_treasuremap.json"
-- 领取奖励后的动画
local SEAL_JSON  = "effect_ui_common_stamp_rect_green.json"
local SEAL_ATLAS = "effect_ui_common_stamp_rect_green.atlas"


-- 任务列表滚动视图滚动开始的处理器
local function onTaskScrollViewScrollBeganHandler(self, scrollView)
    if (self._contentSlider) then
        self._contentSlider:show()
    end
end

-- 任务列表滚动视图滚动的处理器
local function onTaskScrollViewScrollingHandler(self, scrollView, percent)
    self._isScrolling = true
    if (self._contentSlider) then
        self._contentSlider:setPercent(percent)
    end
end

-- 任务列表滚动视图滚动结束的处理器
local function onTaskScrollViewScrollEndedHandler(self, scrollView)
    self._isScrolling = false
    if(self._contentSlider) then  
        self._contentSlider:hide()
    end 
end

local function onTouchFragmentOutSide(self,obj,position)
    local tag1 = 0
    local tag2 = 0
    if (self._lastclickFragment) then 
        tag1 = self._lastclickFragment:getTag() 
    end
    tag2 = obj:getTag()
    if(self._lastclickFragment and tag1 == tag2 ) then
        -- obj:setCanClick(true)
        -- self._lastclickFragment:removeSelectFragmentColcor()        
        -- self._lastclickFragment = nil    
    end   
end 

-- 点击碎片后的回调
local function onFragmentHandler(self,obj)
    if(self._lastclickFragment and self._lastclickFragment:getTag() == obj:getTag()) then
        return
    end
    local data = self._data
    for k,v in pairs(fragmentData_C) do 
        -- print("---------------- k = "..k)
        if(v.ID == obj:getTag()) then 
            if(self._lastclickFragment) then
                self._lastclickFragment:removeSelectFragmentColcor()
                self._lastclickFragment:removeNewFragmentColcor()
            end 
            local title = LanguageManager:getInstance():getLocalString(tonumber(v.value1))
            self._threadTitle:setText(string.format("%s",title))
            self._threadTitle:updateView()
            self._totalCount:setText("")
            local des = LanguageManager:getInstance():getLocalString(tonumber(v.value2))
            self._threadContent:setText(string.format("%s",des))
            self._threadContent:updateView()
            self:setBounceEnabled()
            obj:removeNewFragmentColcor()
            obj:addSelectFragmentColcor()

            obj:showTriggerEffect()
            self._lastclickFragment = obj
            obj:stopAllActions()
            obj:setOpacity(255)
            self._contentScrollView:scrollToTop()
        end 

    end 
    for k,v in pairs(data) do 
        if(k == obj:getTag()) then 
            GameManager:bagClickGoodsHandler(v) 
        end 
    end 

    for k2,v2 in pairs (self._newFragmentID) do 
        if( v2 == obj:getTag())then 
            if(v2 == self._preclickFragment) then 
                self._preclickFragment = nil
                return 
            else
                self._newFragmentID[k2] = nil
            end 
            self._preclickFragment = v2
        end     
    end         
    self._mainLayer:refreshTreasureRedPoint()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_TASK_POINT_RED_POINT)
end 

-- 点击碎片后的回调
local function onNoGerFragmentClick(self,obj)
    local data = self._data
    for k,v in pairs(fragmentData_C) do 
        -- print("---------------- k = "..k)
        if(v.ID == obj:getTag()) then 
            if(self._lastclickFragment) then
                self._lastclickFragment:removeSelectFragmentColcor()
                self._lastclickFragment:removeNewFragmentColcor()
            end 
            self._lastclickFragment = nil
            local strList = string.split(v.value5, ";")
            local str = ""
            if (#strList < 2 or strList[1] == strList[2]) then
                if checkint(strList[1]) >= 1010001 then
                    str = LanguageManager:getInstance():getLocalString(checkint(strList[1]))
                else
                    str = string.format("%s", strList[1])
                    str = string.format(UI.TEXT_1212323, str)
                end
            else
                str = string.format("%s-%s", strList[1], strList[2])
                str = string.format(UI.TEXT_1212323, str)
            end
            self._threadTitle:setText(str)
            self._threadTitle:updateView()

            self._totalCount:setText(string.format("%s/%s", #self.MapIDTable, #self.MapIDTable + #self.noHaveMapIDTable))
            self._threadContent:setText("")
            self._threadContent:updateView()
            self:setBounceEnabled()
            self._contentScrollView:scrollToTop()
            performWithDelay(UI.UIManager:getRootNode(), function()
                self._bgAnimation:setAnimation("trigger", false)
            end, 0.1)
        end 
    end 
end 

function TreasureMapLayer:createFragmentBG(MapID,treasureMap)
    if MapID == nil or #treasureMap == 0 then
        return
    end
    local images = {}

    local framentbgSpine  = UI.Animation:create()
    framentbgSpine:init(FRAGMMENTBG_JSON,FRAGMMENTBG_ATLAS)
    framentbgSpine:setAnimation("idle",true)
    framentbgSpine:leftBottom(444,195)
    framentbgSpine:setScaleX(1.017)
    self._topLayout:addChild(framentbgSpine)

    local bgAnimation = UI.Animation:create()
    bgAnimation:init("effect_ui_package_treasure_map_bglight.json", "effect_ui_package_treasure_map_bglight.atlas")
    bgAnimation:setAnimation("idle", false)
    bgAnimation:center(6)
    self._topLayout:addChild(bgAnimation, 10)
    self._bgAnimation = bgAnimation


    -- local data = self._data
    for k, v in pairs(fragmentData_C) do
        for k1,v1 in pairs(treasureMap) do 
            if(v.ID == v1 ) then 
                local spriteName = v.value3
                local subStr = string.sub(spriteName, 1, -6)
                local maskSpritName = FILE_NAME..subStr.."2.png"

                local posX, posY = self:onGetFragmentP(MapID,v.ID)
                -- print("-----posX, posY , ----maskSpritName",posX, posY, maskSpritName)
                local image = cc.Sprite:create(maskSpritName)
                -- image:initWithFile(maskSpritName)
                image:setAnchorPoint(0, 0)
                image:setPosition(posX, posY)
                table.insert(images, image)
                table.insert(self._loadPngResList, maskSpritName)
            end 
        end 

    end

    local topCap =  cc.Sprite:createWithSpriteFrameName("ui_task_banner_treasuremap_bg.png")
    bgAnimation:setScaleX(895 / topCap:getContentSize().width)
    bgAnimation:setScaleY(405 / topCap:getContentSize().height)
    topCap:setContentSize(895, 405)
    topCap:setAnchorPoint(0, 0)
    topCap:setPosition(-6, -6)
    -- topCap:setOpacity(0)
    -- bg:setScale(2)

    require "utils.WidgetUtil"
    local sprite = Avalon.WidgetUtil:minusAlpha(topCap, images)
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition(0, 0)
    self._topLayout:addChild(sprite)
end
-- 刷新点击右边箭头的UI
local function updateRight(self) 

end 
local  function StrToTable(self,str)
    if str == nil or type(str) ~= "string" then
        return
    end
    
    return loadstring("return " .. str)()
end

local function updateTreaMap(self)
    local size = #self._haveTreaMapIDTable
    local index = self._i % size
    index = index == 0 and size or index 
    for k,v in pairs(treasureMapData_C) do 
        if(v.ID == self._haveTreaMapIDTable[index]) then 
            local des = LanguageManager:getInstance():getLocalString(v.description)
            self._threadContent:setText(string.format("%s",des))
            self._contentScrollView:scrollToTop()
        end 
    end 

    if(#self:getCFragmentTable(self._haveTreaMapIDTable[index]) ~= 0) then 
        self:updateMapSTable(self._haveTreaMapIDTable[index])
    else
        self._i = 1
        self:updateMapSTable(self._haveTreaMapIDTable[1])
    end      
end 
-- 点击箭头的回调
local function onArrowHandler(self)
    self._topLayout:removeAllChildren(true)
    self._lastclickFragment = nil 
    updateTreaMap(self)
end 
-- 点击you边箭头后的回调
local function onRightArrowHandler(self)
    self._i  = self._i + 1
    onArrowHandler(self)
    print("------右边点击111---",self._i) 
end 

-- 点击zuo边箭头后的回调
local function onLeftArrowHandler(self)
    self._i  = self._i - 1
    onArrowHandler(self)
    print("------左边点击---",self._i)
end 


function TreasureMapLayer:ctor()
    TreasureMapLayer.super.ctor(self,UIType.TREASUREMAP_UI, RES,COM_WIDTH,COM_HEIGHT)
    self._data = nil
    self._threadTitle = nil -- 线索标题
    self._threadContent = nil -- 线索内容
    self._threadUI = nil -- 线索UI
    self._npcManBg = nil -- NPC铁匠

    self._FragementIconTable = {}
    self._FragementIDTable = {}
    self._FragementTitleDesTable = {}
    self._TreasureMapIDC_Table = {} -- 藏宝图配置文件ID表

    self._fragmentIcon = nil -- 碎片ICON
    self._npcIcon = {}
    self._isNew = false 
    
    self._k = 1 -- 点击左箭头的计数器
    self._i = 1 -- 点击右箭头的计数器
    self._topLayout = nil 
    self._MapDataName = nil  -- 藏宝图数据中的NAME字段
    self._FragmentDataName = nil  -- 碎片数据中的NAME字段

    self._contentSlider = nil -- 内容滚动条
    self._isScrolling = false   -- 文本区域是否正在滚动
    self._lastclickFragment = nil --记录点击的碎片
    self._box1 = nil 
    self._redpoint  = nil 
    self._mainLayer = nil 
    self._newFragmentID = {}
    self._tMapTitle = nil
    self._tMapTitleDes  = nil
    self._mapcontentScrollView = nil 
    self._visitable = {}
    self._preclickFragment = nil  -- 上一次点击的碎片
    self._haveTreaMapIDTable = {} -- 已有藏宝图的ID
    self._haveTreaMapIDTableOld = {}
    self._arrowRight = nil-- 右边的箭头
    self._leftArrow = nil -- 左边的箭头
    self._virtualNode = nil
    self._loadPngResList = {} -- 管理png纹理资源
    -- self:enableDebugDraw()
    self:registerListener()
end

function TreasureMapLayer:dtor()
    TreasureMapLayer.super.dtor(self)
    local textureCache = cc.Director:getInstance():getTextureCache()
    for k, v in ipairs(self._loadPngResList) do
        textureCache:removeTextureForKey(v)
    end
    self._loadPngResList = {}
    self:unRegisterListener()
end

function TreasureMapLayer:init(data,layer)
    self._data = data
    self._mainLayer = layer
    TreasureMapLayer.super.init(self)
end


function TreasureMapLayer:onInitView(data)
    local data = self._data

    local bg = cc.Sprite:create()
    bg:setSpriteFrame("ui_task_banner_treasuremap_bg.png")
    bg:setPosition(425, 333)
    self:addChild(bg,90)

    local topCap =  cc.Scale9Sprite:createWithSpriteFrameName("ui_task_banner_treasuremap_bg_up.png", CCRectMake(45,42,1,1))
    topCap:setContentSize(bg:getContentSize())
    topCap:setAnchorPoint(0.5, 0.5)
    topCap:setPosition(425, 333)
    self:addChild(topCap,200)

    local topLayout = UI.Layout:create()
    topLayout:init()
    topLayout:setSize(882,388)
    topLayout:setScale(0.866)
    topLayout:leftUp(-16, 8)
    self:addChild(topLayout,98)
    self._topLayout = topLayout

    -- topLayout:hide()
    -- topLayout:enableDebugDraw(UI.RED)
    for k,v in pairs(treasureMapData_C) do 
        -- print("--------------配置表中的藏宝图ID",k,v.ID)
        table.insert(self._TreasureMapIDC_Table,v.ID)
        table.sort(self._TreasureMapIDC_Table)
        for k2,v2 in pairs(data) do 
            -- print("--------------服务器发送的拥有的碎片数据",k2)
            for i= 1,#self._TreasureMapIDC_Table do 
                if  v.ID == self._TreasureMapIDC_Table[i]  then 
                    for k1,v1 in pairs (v.fragmentID) do 
                        if v1 == k2 then 
                            -- print("------对应的藏宝图ID--%s--",v.ID)
                            table.insert(self._haveTreaMapIDTable,v.ID)
                            table.sort(self._haveTreaMapIDTable)
                        end 
                    end 
                end 
            end
        end
    end
    for i = #self._haveTreaMapIDTable ,1,-1 do
	    if(self._haveTreaMapIDTable[i] == self._haveTreaMapIDTable[i -1]) then 
		    table.remove(self._haveTreaMapIDTable,i)
	    end 
    end

    for k,v in pairs(self._haveTreaMapIDTable) do 
        print("-----已经搜集的藏宝图ID",k,v)
    end  

    local givenMapData = MasterDataManager:getTreasureMapList()
    if(#self._haveTreaMapIDTable + #givenMapData >= 2) then 
        local arrowLeft = UI.Button:create()
        arrowLeft:init("ui_activity_left_0.png", "ui_activity_left_1.png", "ui_activity_left_2.png")
        arrowLeft:addEventListener(UIEvent.BUTTON_CLICK, self, onLeftArrowHandler)
        arrowLeft:leftUp(4, 170)
        arrowLeft:setTouchEnable(true)
        self._leftArrow = arrowLeft
        self:addChild(arrowLeft, 9999)
        
        -- SPINE 右边的动画箭头
        local arrowRight = UI.Button:create()
        arrowRight:init("ui_activity_right_0.png", "ui_activity_right_1.png", "ui_activity_right_0.png")
        arrowRight:addEventListener(UIEvent.BUTTON_CLICK, self, onRightArrowHandler)
        arrowRight:rightUp(4, 170)
        arrowRight:setTouchEnable(true)
        self._arrowRight = arrowRight
        self:addChild(arrowRight, 9999)
    end 
   
    -- 白色背景图
    local box1 = UI.Image:create()
    box1:init(BOX1)
    box1:rightBottom(12, 5)
    self._box1 = box1
    self:addChild(box1,201)

    local npcManBg = UI.Image:create()
    npcManBg:init("ui_task_teasuremap_complete.png")
    npcManBg:rightBottom(8, 34)
    self._npcManBg = npcManBg
    self._box1:addChild(npcManBg, 1)

    local diamondBg = UI.Image:create()
    diamondBg:init("ui_task_teasuremap_dia_bg.png")
    diamondBg:centerUp(40)
    self._box1:addChild(diamondBg, 2)
    self.diamondBg = diamondBg

    --纽带
    local ligament = UI.Image:create()
    ligament:init("ui_task_banner_reward_box_2.png")
    ligament:centerBottom(-3)
    self._box1:addChild(ligament, 10)
    self.ligament = ligament

    local ligamentText = UI.Text:create()
    ligamentText:init(UI.TEXT_1212320, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_204_102)
    ligamentText:centerBottom(7)
    ligamentText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    ligament:addChild(ligamentText)
    self.ligamentText = ligamentText

    --按钮
    local reciveButton = UI.Button:create()
    reciveButton:init("ui_btn_yellow7_0.png","ui_btn_yellow7_1.png","ui_btn_yellow7_2.png")
    reciveButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.reciveRewardClick)
    reciveButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.reciveRewardClick)
    reciveButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    reciveButton:setText(UI.TEXT_111035)
    self._box1:addChild(reciveButton, 20)
    reciveButton:centerBottom(0)
    self.reciveButton = reciveButton
    -------------------------------------------- 线索 ---------------------------------------------
    if(data) then 
        local contentBg = UI.Image:create()
        contentBg:init(BG_CONTENT)
        contentBg:leftBottom(80,118)
        self:addChild(contentBg,99)

        local contentScrollView = UI.ScrollView:create()
        contentScrollView:setSize(570,96)
        contentScrollView:init(0, 0, 0, 0)
        contentScrollView:leftUp(1,44)
        contentBg:addChild(contentScrollView,3)
        contentScrollView:setScrollType(UI.ScrollType.VERTICAL)
        contentScrollView:setTouchEnable(true)
        contentScrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_BEGAN, self, onTaskScrollViewScrollBeganHandler)
        contentScrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLLING, self, onTaskScrollViewScrollingHandler)
        contentScrollView:addEventListener(UIEvent.SCROLL_VIEW_SCROLL_ENDED, self, onTaskScrollViewScrollEndedHandler)
        self._contentScrollView = contentScrollView
        -- 线索背景图
        local threadBg = UI.Image:create()
        threadBg:init(BG_THREAD)
        threadBg:leftBottom(26,103)
        self:addChild(threadBg,99)

        -- 线索标题
        local thread_Title = UI.Text:create()
        thread_Title:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
        thread_Title:leftBottom(33, 3)
        contentBg:addChild(thread_Title,3)
        self._threadTitle = thread_Title

        local totalCount = UI.Text:create()
        totalCount:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
        totalCount:rightBottom(5, 3)
        contentBg:addChild(totalCount,3)
        self._totalCount = totalCount
        -- 线索内容
        local thread_Content = UI.Text:create()
        thread_Content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        thread_Content:leftUp(0,0)
        self._threadContent  = thread_Content
        -- self._threadContent:setSize(590,200)
        self._threadContent:setWidth(570)
        self._threadContent:setTextLeft()
        contentScrollView:addInnerNode(thread_Content)
    end 
    local cap = UI.Image:create()
    cap:init("ui_task_easuremap_mask.png")
    cap:leftBottom(80,0)
    self:addChild(cap,100)


    local noDataTips = UI.Text:create()
    noDataTips:init(UI.TEXT_1170911, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    noDataTips:center()
    bg:addChild(noDataTips)
    self._noDataTips = noDataTips
end

function TreasureMapLayer:reciveRewardClick()
    -- 处理藏宝图奖励领取
    local SceneManager = require("app.game.SceneManager")
    if not SceneManager:getInstance():isInTownOrInHome() then--不在洞窟 
        UI.ScrollBar:createByText(UI.TEXT_1212324)
        return
    end


    local treasureMapConfig = nil
    local size = #self._haveTreaMapIDTable
    local index = self._i % size
    index = index == 0 and size or index 
    for k,v in pairs(treasureMapData_C) do 
        if(v.ID == self._haveTreaMapIDTable[index]) then 
            treasureMapConfig = v
            break;
        end 
    end 

    if(treasureMapConfig) then
        local goodsArr = {}
        for k,goodsID in pairs(treasureMapConfig.goodsRewards) do
            local data = {}
            data.goodsID = goodsID
            data.num = treasureMapConfig.goodsRewardsNum[k]
            data.isGolden = true
            table.insert(goodsArr, data)
        end

        -- 判断背包是否满了
        local GameDataManager = require("app.game.GameDataManager")
        if GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == true then 
            if RoleBehaviorManager:treasureMapRewardNpcCheck() then
                printWarn(" been blocked when using treasureMap reward npc function !")
            else
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Net.NetTreasureMapSystem:receiveTreasureReward(treasureMapConfig.ID, 0)
            end
        else
            UI.ScrollBar:createByTextID(1110793)
        end
    end
end

function TreasureMapLayer:getHaveFragments(treaMapId)
    local haveFragments = {}
    local noHaveFragments = {}
    local oneTreaMapCfg = nil
    for k, v in pairs(treasureMapData_C) do
        if v.ID == treaMapId then 
            oneTreaMapCfg = v
            break
        end
    end

    if oneTreaMapCfg == nil then
        return haveFragments, noHaveFragments
    end
    
    local haveAward = false
    for k3,v3 in pairs(self._haveTreaMapIDTable) do 
         if(v3 == treaMapId) then 
            haveAward = true
            break
        end
    end
   
    for k, v in pairs(oneTreaMapCfg.fragmentID) do 
        local isHave = false
        for k2, v2 in pairs(self._data ) do
            if(k2 == v) then   
                table.insert(haveFragments, v)   
                isHave = true
            end 
        end
        if not isHave then
            table.insert(noHaveFragments, v) 
        end
    end

    if haveAward and #haveFragments == 0 then --奇葩处理 如果改藏宝图ID已经标记为得到 但是 一个对应的碎片都没有 则默认是已经获取了全部碎片 且已经领奖
        for k, v in pairs(oneTreaMapCfg.fragmentID) do 
            table.insert(haveFragments, v)   
        end
    end

    local isGetAll = self:onIsGetAllFragment(treaMapId, haveFragments)
    -- print("---------isGetAll or haveAward-----", isGetAll, haveAward)
    if isGetAll then
        noHaveFragments = {}
    end

    return haveFragments, noHaveFragments
end

function TreasureMapLayer:onUpdateView(data)
    local data = self._data  
    -- 是否显示小红点
    for k,v in pairs(data) do 
        -- print("----碎片的ID是否为NEW---",v.ID,v:getIsNew())
        if(v:getIsNew() == true) then 
            -- print("---新碎片的ID是：--",v.ID)
            table.insert(self._newFragmentID,v.ID)
        end 
        
    end
    for k,v in pairs(data) do 
        table.insert(self._FragementIDTable,v.ID)
    end 
    
    --当前已经领取的藏宝图ID
    local givenMapData  =  MasterDataManager:getTreasureMapList()
    -- 把服务器传的藏宝图ID放在同一个表
    for k,v in pairs(givenMapData) do 
        table.insert(self._haveTreaMapIDTable,v)
    end 
    table.sort(self._haveTreaMapIDTable)
    for i = #self._haveTreaMapIDTable,1,-1 do 
        if(self._haveTreaMapIDTable[i] == self._haveTreaMapIDTable[i-1]) then
            table.remove(self._haveTreaMapIDTable,i)
        end 
    end 
    for k,v in pairs(self._haveTreaMapIDTable) do
        print("现有的藏宝图ID---",k,v)
    end 

    if(self._i == 1) then 
        self:updateMapSTable(self._haveTreaMapIDTable[1]) 
    end 
    
    if self._haveTreaMapIDTable[1] == nil then
        self._threadTitle:setText(UI.TEXT_1170909)
        self._totalCount("")
        self._threadContent:setText(UI.TEXT_1170910)
        self._contentScrollView:scrollToTop()
        self._noDataTips:show()
    else
        self._noDataTips:hide()
    end
end

-- 服务器数据刷新
function  TreasureMapLayer:updateMapSTable(mapid)
    self.mapid = mapid
    local MapIDTable, noHaveMapIDTable = self:getHaveFragments(mapid)
    self.MapIDTable = MapIDTable
    self.noHaveMapIDTable = noHaveMapIDTable
    self:setTreaMap(mapid,MapIDTable, noHaveMapIDTable)
    self:createFragmentBG(mapid,MapIDTable)
    self:updateGetAllFragmentUI(mapid,MapIDTable)
end 

-- 获取藏宝图配置表中的碎片Table
function  TreasureMapLayer:getCFragmentTable(mapid)
    local fragmentTable = {}
    for k,v in pairs(treasureMapData_C) do 
        if(mapid == v.ID) then 
            fragmentTable = v.fragmentID
        end 
    end 
    return fragmentTable
end 

-- 切换藏宝图时，刷新收集完成碎片、领取奖励的UI表现
function TreasureMapLayer:updateGetAllFragmentUI(havetreasureMapID,fragmentNum)
    for k,v in pairs(treasureMapData_C) do 
        if(havetreasureMapID == v.ID) then 
            for k1,v1 in ipairs(v.goodsRewards) do 
                local goodsRewardsNum = v.goodsRewardsNum[k1]
                local virtualData = GoodsDataManager:createVirtualData(v1, goodsRewardsNum)
                if(virtualData) then
                    if self._virtualNode ~= nil then
                        self._virtualNode:removeFromParent()
                    end
                    if(virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemCoin) then -- 黄金图标
                        local GOLDAward = UI.TaskAwardGrid:create()
                        GOLDAward:init(goodsRewardsNum,UI.TaskAwardGridType.GOLD)
                        GOLDAward:centerUp(35)
                        self.diamondBg:addChild(GOLDAward,2)
                        self._virtualNode = GOLDAward
                    elseif(virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond) then -- 钻石图标
                        local crystalAward = UI.TaskAwardGrid:create()
                        crystalAward:init(goodsRewardsNum,UI.TaskAwardGridType.DIAMOND)
                        crystalAward:centerUp(35)
                        self.diamondBg:addChild(crystalAward,2)
                        self._virtualNode = crystalAward
                    elseif(virtualData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemExp) then --  经验图标
                        local EXPAward = UI.TaskAwardGrid:create()
                        EXPAward:init(goodsRewardsNum,UI.TaskAwardGridType.EXP)
                        EXPAward:centerUp(35)
                        self.diamondBg:addChild(EXPAward,2)
                        self._virtualNode = EXPAward
                    end
                end 
            end
        end 
    end 

    -- 是否收集完
    local isGetAllFragment =  self:onIsGetAllFragment(havetreasureMapID,fragmentNum)
    local givenMapData =  MasterDataManager:getTreasureMapList()
    local isReciveReward = false--是否已经领奖
    if(givenMapData ~= nil ) then 
        for k3,v3 in pairs(givenMapData) do 
            if(v3 == havetreasureMapID) then 
                isReciveReward = true
            end 
        end 
    end 
-- print("+++++++++++++updateGetAllFragmentUI++++++++++++", isGetAllFragment, isReciveReward, givenMapData)
    -- 收集碎片完成后的表现  显示奖励物品
    if isGetAllFragment then 
        if isReciveReward then
            self.diamondBg:hide()
            self._npcManBg:show()
            self.ligament:show()
            self.reciveButton:hide()
            self.ligamentText:setText(UI.TEXT_1212321)
        else
            self.diamondBg:show()
            self._npcManBg:hide()
            self.ligament:hide()
            self.reciveButton:show()
            local SceneManager = require("app.game.SceneManager")
            if SceneManager:getInstance():isInTownOrInHome() then
                self.reciveButton:enable()
            else
                self.reciveButton:disable()
            end   
        end
    else  
        self.diamondBg:show()
        self._npcManBg:hide()
        self.ligament:show()
        self.reciveButton:hide()
        self.ligamentText:setText(UI.TEXT_1212320)
    end 
end 

-- 是否收集完某个藏宝图的碎片 参数1：已有藏宝图ID 参数2：已有藏宝图ID对应的碎片数量
function TreasureMapLayer:onIsGetAllFragment(havetreasureMapID,fragmentNum)

    for k,v in pairs (treasureMapData_C) do 
        if(v.ID == havetreasureMapID) then 
            if(#fragmentNum  == #v.fragmentID) then 
                return true 
            else 
                return false
            end 
        end 
    end 
    return false
end 

-- 是否获得奖励
function TreasureMapLayer:onIsGetReward()
    -- 搜集完成的藏宝图数据ID
    for k,v in pairs(treasureMapData_C) do 
        for k1,v1 in pairs(MasterDataManager.treasureMapList) do
            if(v1 == v.ID) then 
                return true
            end 
            return false
        end 
    end 
end 
-- 是否存在数据
function TreasureMapLayer:onIsHaveData()
    local data = self._data
    for k,v in pairs (data) do 
        if(v.ID ~= 0) then 
            return true 
        end 
        return false
    end 
end 
function TreasureMapLayer:setBounceEnabled()
    if(self._threadContent._height <= 110 ) then 
        self._contentScrollView:setBounceEnabled(false)
        -- self._contentSlider:show()
        -- self._slider:setVisible(false)
    else
        self._contentScrollView:setBounceEnabled(true)
        -- self._contentSlider:hide()
        -- self._slider:setVisible(true)
    end 
end 

-- 参数1：藏宝图ID 参数2：藏宝图对应的碎片Table
function TreasureMapLayer:setTreaMap(MapID,treasureMap, noHaveTreasureMap)
    local selectIconType = nil
    local selectIcon = nil
    local treasureConfig = ConfigManager:getTreasuremapConfigByID(MapID)
    for k,v in pairs(treasureMap) do 
        for k1,v1 in pairs(fragmentData_C) do 
            if(v == v1.ID) then 
                local imageName = FILE_NAME..v1.value3
                table.insert(self._loadPngResList, imageName)
                local pointArray = AvalonUtil:splitStr(v1.value4,';')

                local icon = UI.ImageButton:create()
                icon:init(imageName, tonumber(pointArray[1]), tonumber(pointArray[2]))
                icon:setSwallowTouches(false)
                icon:setInterceptTouches(true)
                icon:setTag(v1.ID)
                icon:addEventListener(UIEvent.IMAGE_BUTTON_CLICK, self, onFragmentHandler)
                icon:addEventListener(UIEvent.IMAGE_BUTTON_CLICK_OUTSIDE, self, onTouchFragmentOutSide)
            
                -- 根据ID获取坐标
                local x,y = self:onGetFragmentP(MapID,v1.ID)
                -- print("----藏宝图碎片的坐标",x,y)
                local clippingNode = UI.ClippingNode:create()
                clippingNode:initWithFileName(imageName, 0.0)
                clippingNode:addInnerNode(icon)
                clippingNode:leftBottom(x,y) 
                self._topLayout:addChild(clippingNode, 9999)
                icon:setClippingNode(clippingNode)
                for k2,v2 in pairs(self._newFragmentID) do 
                    if(v2 == v1.ID) then
                        icon:addNewFragmentColcor()
                        icon:setOpacity(255)
                        icon:setCascadeOpacityEnabled(true)
                        -- local action1 = cc.FadeTo:create(2,80)
                        -- local action2 = cc.FadeTo:create(2,200)
                        -- local sequence = cc.Sequence:create(action1, action2)
                        -- local action = cc.RepeatForever:create(sequence)
                        -- icon:runAction(action)
                    end 
                end 

                if v == treasureConfig.fragmentID[1] then
                    selectIconType = 1
                    selectIcon = icon
                end
            end 
        end 
        for k, v in pairs(noHaveTreasureMap) do 
            for k1,v1 in pairs(fragmentData_C) do 
                if(v == v1.ID) then 
                    local imageName = FILE_NAME..v1.value3
                    table.insert(self._loadPngResList, imageName)
                    local icon = UI.ImageButton:create()
                    icon:init(imageName)
                    icon:setTag(v1.ID)
                    icon:setSwallowTouches(false)
                    icon:setInterceptTouches(true)
                    icon:addEventListener(UIEvent.IMAGE_BUTTON_CLICK, self, onNoGerFragmentClick)
                    local x,y = self:onGetFragmentP(MapID,v1.ID)

                    icon:setAnchorPoint(0, 0)
                    icon:leftBottom(x,y) 
                    self._topLayout:addChild(icon, 1000)
                    icon:setOpacity(0)

                    if not selectIcon then
                        selectIconType = 2
                        selectIcon = icon
                    end
                end
            end 
        end 
    end 
    
    if selectIconType == 1 then
        onFragmentHandler(self, selectIcon)
    else
        onNoGerFragmentClick(self, selectIcon)
    end
end

-- 根据碎片ID获取 碎片的X Y 坐标
function TreasureMapLayer:onGetFragmentP(MapID,fragmentid)
    local x = 0
    local y = 0
    local a = 0
    for k,v in pairs(treasureMapData_C) do 
        if(v.ID == MapID ) then 
            for k1,v1 in pairs(v.fragmentID) do 
                if(v1 == fragmentid) then 
                    a = k1
                    -- print("-------aaaa",a)
                end 
            end 
            
            for k2,v2 in pairs(v.fragmentLocation) do
                if(k2 == a) then  
                    local b = AvalonUtil:splitStr(v2,',')
                    for k3 = 1,#b do
                        x = tonumber(b[1])
                        y = tonumber(b[2])
                    end 
                end   
            end 
        end 
    end 
    return x,y
end 

function TreasureMapLayer:showShareBtn(parentNode)
    --分享布局
    parentNode:showShareBtn(handler(self, self.shareClick), PublicDefine.SHARE_MODULE.SHARE_MODULE_TREASURE)
end

function TreasureMapLayer:shareClick(shareChannel)
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_TREASURE,shareChannel)
    if shareDatas == nil then
        printWarn("----!!!! error !!!! treaseure shareDatas is nnil")
        return
    end
    local SdkBox = require("utils.sdkbox.SdkBox")
    if not tolua.isnull(self._ShareNode) then
        self._ShareNode:removeFromParent(true)
    end
    local contentBg, shareNode = AvalonUtil.getPublicShareBg(shareDatas, shareChannel)
    local npc = contentBg:getChildByName("npcBg"):getChildByName("npc")
    npc:setSpriteName("ui_share_npc_3.png")

    local npcDialog = contentBg:getChildByName("npcDialogBg"):getChildByName("npcDialog")
    npcDialog:setText(LanguageManager:getInstance():getLocalString(1192001))
    self._ShareNode = shareNode
   ---内容 begin
    local contentLayer = UI.Layout:create()
    contentLayer:init()
    contentLayer:setSize(contentBg:getContentSize().width, contentBg:getContentSize().height)
    contentLayer:center()
    contentBg:addChild(contentLayer, 10)
    
    local nameBg = UI.Image:create()
    nameBg:init("ui_share_head.png")
    nameBg:leftUp(390, 39)
    contentBg:addChild(nameBg, 1200)

    local name = UI.Text:create()
    name:init(UI.TEXT_111011, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    name:setSize(360, 46)
    name:leftUp(10, -3)
    name:setTextCenter()
    nameBg:addChild(name)


    local bg2 = cc.Sprite:create()
    bg2:setSpriteFrame("ui_task_banner_treasuremap_bg.png")
    bg2:setPosition(contentBg:getContentSize().width / 2, contentBg:getContentSize().height * 2 / 3 - 18)
    contentLayer:addChild(bg2)

    local topCap = cc.Scale9Sprite:createWithSpriteFrameName("ui_task_banner_treasuremap_bg_up.png", CCRectMake(45,42,1,1))
    topCap:setContentSize(bg2:getContentSize())
    topCap:setAnchorPoint(0.5, 0.5)
    topCap:setPosition(bg2:getContentSize().width / 2, bg2:getContentSize().height / 2)
    bg2:addChild(topCap,200)

    local contentBg2 = UI.Image:create()
    contentBg2:init(BG_CONTENT)
    contentBg2:leftBottom(270,180)
    contentLayer:addChild(contentBg2, 10)

    -- 线索背景图
    local threadBg = UI.Image:create()
    threadBg:init(BG_THREAD)
    threadBg:leftBottom(160,170)
    contentLayer:addChild(threadBg,99)

    -- 线索标题
    local thread_Title = UI.Text:create()
    thread_Title:init(self._threadTitle:getText(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    thread_Title:leftBottom(33, 3)
    contentBg2:addChild(thread_Title,3)
    -- 线索内容
    local thread_Content = UI.Text:create()
    thread_Content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    thread_Content:setWidth(580, 96)
    thread_Content:setTextLeft()
    local content = AvalonUtil:getSubNameStrByLabel(self._threadContent:getText(), 1500, UI.FONT_SIZE_16PX, true)
    thread_Content:setText(content)
    thread_Content:leftUp(0, 44)
    contentBg2:addChild(thread_Content)

    local topLayout = UI.Layout:create()
    topLayout:init()
    topLayout:setSize(882,388)
    topLayout:setScale(0.866)
    topLayout:center()--setPosition(topLayout:getContentSize().width * (topLayout:getScale() - 1) / 2, topLayout:getContentSize().height * (topLayout:getScale() - 1) / 2)
    bg2:addChild(topLayout, 108)

    for k,v in pairs(self.MapIDTable) do 
        for k1,v1 in pairs(fragmentData_C) do 
            if(v == v1.ID) then 
                local icon = cc.Sprite:create()
                icon:initWithFile(FILE_NAME..v1.value3)
                local x,y = self:onGetFragmentP(self.mapid,v1.ID)
                icon:setPosition(x, y)
                icon:setAnchorPoint(0, 0)
                topLayout:addChild(icon, 10)
            end 
        end 
    end
end

function TreasureMapLayer:refreshRewardPanel()
    print("-------------------refreshRewardPanel--------", self.mapid, self.MapIDTable)
    if self.mapid == nil or self.MapIDTable == nil then
        return
    end
    self:updateGetAllFragmentUI(self.mapid, self.MapIDTable)
end

-- 注册监听事件
function TreasureMapLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_TREASURE_RECIVE_REWARD_RESULT, self, self.refreshRewardPanel)
end

-- 注销监听事件
function TreasureMapLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TREASURE_RECIVE_REWARD_RESULT, self, self.refreshRewardPanel)
end
