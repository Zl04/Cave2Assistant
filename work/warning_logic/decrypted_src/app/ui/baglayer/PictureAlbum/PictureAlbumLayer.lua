
--[[
    画册界面
]]

require "app.ui.Component"
require "app.ui.common.Tab.TabList"
require "app.ui.common.Animation"
require "app.ui.common.ScrollView"
require "app.ui.baglayer.PictureAlbum.PictureAlbumList"
require "app.datas.PictureAlbumManager"

local LanguageManager = require("app.game.LanguageManager")

local petPictureProfile = require ("profiles/commonProfile/ProfilePetPicture")
local petTargetProfile = require ("profiles/commonProfile/ProfilePetTarget")

UI = UI or {}
local PictureAlbumLayer = class("PictureAlbumLayer", UI.HWBtnComponent)
UI.PictureAlbumLayer = PictureAlbumLayer

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false
-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534

local CELL_SIZE = cc.size(740 + 40, 29)

-- 背包资源
local COM_RES_LIST = {
    "ui_picturealbum.plist",
    "ui_town_inferno.plist",
}

-- 构造函数
function PictureAlbumLayer:ctor(paID)
    PictureAlbumLayer.super.ctor(self, UIType.FUNCTION_TAB_PICTURE_ALBUM_LAYER, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._paID = paID               --画册ID
    self._petPicView = {}           --宠物画册视图,用于动画表现
    self._attributeTextView = {}    --属性视图

    self._petPictureData = nil
end

--析构函数
function PictureAlbumLayer:dtor()
    PictureAlbumLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function PictureAlbumLayer:init()
    -- self._paData

    PictureAlbumLayer.super.init(self)

    -- self:enableDebugDraw()

    self:registerListener()
end

-- 初始化视图
function PictureAlbumLayer:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:centerBottom(0)
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- print(" self._paID ==== ",self._paID)
    self._petPictureData = petPictureProfile[self._paID]

    -- print(" self._petPictureData ==== ",self._petPictureData)

    local backgroundPicture = self._petPictureData.backgroundPicture

    -- print(" backgroundPicture==== ",backgroundPicture)

    
    local bg = cc.Sprite:createWithSpriteFrameName(backgroundPicture)
    local width, height = self._contentLayout:getSize()
    bg:setPosition(width / 2,height- bg:getContentSize().height / 2 - 17)
    self._contentLayout:addChild(bg)


    ----------------------------卡牌展示-----------------------------
    
    if self._petPictureData then
        local petNameList = self._petPictureData.petName
        local petOffset = self._petPictureData.petOffset
        local involvePet = self._petPictureData.involvePet
        local unlockedDes = self._petPictureData.unlockedDes
        local mutationOffset = self._petPictureData.mutationOffset
        local sparkleOffest = self._petPictureData.sparkleOffest
        local limitStrs = string.split(petOffset, ";")
        local mutationOffsetStr = string.split(mutationOffset, ";")
        local sparkleOffestStr = string.split(sparkleOffest, ";")
        for index, str in ipairs(limitStrs) do
            local lStrs = string.split(str, ",")
            local picName = lStrs[1]
            local x = tonumber(lStrs[2])
            local y = tonumber(lStrs[3])
            --默认全灰
            picName = picName .. "01.png"

            -- print("picName ===== ",picName)
            local pictButton = UI.Button:create()
            pictButton:closeClickScale()
            pictButton:init(picName, picName, picName)
            pictButton:leftBottom(x,y)
            pictButton:setTouchClipNode(self)
            pictButton:setInterval(1)
            
            pictButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- if not PictureAlbumManager:picturePetActivation(self._paID,involvePet[index]) then
                    local petNameID = petNameList[index]
                    UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(string.format(LanguageManager:getInstance():getLocalString(unlockedDes[index]), 
                    LanguageManager:getInstance():getLocalString(petNameID)))
                -- end
            end)

            -- pictButton:enableDebugDraw()
            
            bg:addChild(pictButton,index)

            local moStr = string.split(mutationOffsetStr[index], ",")
            local mx,my = tonumber(moStr[1]),tonumber(moStr[2])
            --变异图标 
            local mutationImage = UI.Image:create()
            mutationImage:init("ui_picturealbum_mutations2.png")
            mutationImage:leftBottom(mx,my)
            bg:addChild(mutationImage,index)
            mutationImage:hide()


            local soStr = string.split(sparkleOffestStr[index], ",")

            self._petPicView[involvePet[index]] = {}
            self._petPicView[involvePet[index]].btn = pictButton
            self._petPicView[involvePet[index]].index = index
            self._petPicView[involvePet[index]].picName = lStrs[1]

            self._petPicView[involvePet[index]].mutationImage = mutationImage
            self._petPicView[involvePet[index]].soPoint = { x = tonumber(soStr[1]), y = tonumber(soStr[2])}
        end
    end

    ----------------------------卡牌展示-----------------------------



    ----------------------------属性加成-----------------------------
    local attributeTitleBg = cc.Sprite:createWithSpriteFrameName("ui_picturealbum_banner.png")
    attributeTitleBg:setAnchorPoint(0,0)
    attributeTitleBg:setPosition(36,144 + 20)
    self._contentLayout:addChild(attributeTitleBg)

    local picABg = cc.Sprite:createWithSpriteFrameName("ui_picturealbum_icon.png")
    picABg:setPosition(14,18)
    attributeTitleBg:addChild(picABg)

    --属性加成
    local attributeTitleText = UI.Text:create()
    attributeTitleText:init(LanguageManager:getInstance():getLocalString(1114012), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_151_151_151)
    attributeTitleText:centerLeft(42)
    attributeTitleBg:addChild(attributeTitleText)

    --分割线
    local lineIamge = UI.Image9:create()
    lineIamge:init("ui_inferno_line.png", CCRectMake(2,0,1,1), cc.size(778, 3))
    lineIamge:centerBottom(132 + 20)
    self._contentLayout:addChild(lineIamge)

    --滑动遮挡资源
    local picturealbumUpSp = cc.Sprite:createWithSpriteFrameName("ui_picturealbum_up.png")
    picturealbumUpSp:setPosition(width / 2,0)
    self._contentLayout:addChild(picturealbumUpSp,10)


    --属性滑动区域内容
    local attributeTableView = cc.TableView:create(cc.size(CELL_SIZE.width + 4, 115 + 20))
    attributeTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    attributeTableView:setPosition(50 - 15, 8)
    attributeTableView:setDelegate()
    attributeTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self:addChild(attributeTableView, 20)

    attributeTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    attributeTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    attributeTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    attributeTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    attributeTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    attributeTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    attributeTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)

    self._attributeScrollView = attributeTableView
    self._attributeScrollView:reloadData(true, 0.18, Game.TableCellInitTime, Game.TableCellAddTime)

    attributeTableView:initScrollBar(false)
    attributeTableView:setScrollBarWidth(6)
    attributeTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    ----------------------------属性加成-----------------------------
    local mNum,allMaxStar = PictureAlbumManager:getPictureMutatedNumberAndMaxStarNum(self._paID)
    --变异宠物数量
    local mutationsBg = cc.Sprite:createWithSpriteFrameName("ui_picturealbum_mutations.png")
    mutationsBg:setAnchorPoint(0,0)
    mutationsBg:setPosition(5,465)
    self._contentLayout:addChild(mutationsBg)

    local mutationsText = UI.Text:create()
    mutationsText:init(LanguageManager:getInstance():getLocalString(1114099) .. tostring(mNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_219_184_121)
    mutationsText:centerLeft(62, 1.5)
    mutationsBg:addChild(mutationsText)
    self._mutationsText = mutationsText

    --获得星数 
    local maxStarBg = cc.Sprite:createWithSpriteFrameName("ui_picturealbum_star.png")
    maxStarBg:setAnchorPoint(0,0)
    maxStarBg:setPosition(5 + 212,465)
    self._contentLayout:addChild(maxStarBg)

    local maxStarText = UI.Text:create()
    maxStarText:init(LanguageManager:getInstance():getLocalString(1114098) .. tostring(allMaxStar), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_219_184_121)
    maxStarText:centerLeft(62, 1.5)
    maxStarBg:addChild(maxStarText)
    self._maxStarText = maxStarText


end

function PictureAlbumLayer:numberOfCellsInTableView(table)
    if self._petPictureData then
        return #self._petPictureData.taskGroup
    else 
        return 0
    end
end

function PictureAlbumLayer:scrollViewDidScroll(view)
end

function PictureAlbumLayer:scrollViewDidZoom(view)
    
end

function PictureAlbumLayer:tableCellTouched(tableView,cell)

end

function PictureAlbumLayer:tableCellWillRecycle(tableView,cell)
    if cell ~= nil then
        cell:removeChildByName("cell");
    end
end

function PictureAlbumLayer:cellSizeForTable(table,idx)
    return CELL_SIZE.width, CELL_SIZE.height
end

function PictureAlbumLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    else
        cell:removeChildByName("cell");
    end

    local paData = petTargetProfile[self._petPictureData.taskGroup[idx + 1]]
    xpcall(function()
        local paCell = UI.PictureAlbumList:create(CELL_SIZE.width, CELL_SIZE.height)
        paCell:init(self._paID,paData,idx + 1)
        paCell:setName("cell")
        paCell:leftBottom(0, 0)
        cell:addChild(paCell)
    end, 
    function(e) 
        printError("------------------------PictureAlbumLayer:tableCellAtIndex-----------------error")
    end, 1)  
    return cell
end


-- 更新视图
function PictureAlbumLayer:onUpdateView()

    local mNum,allMaxStar = PictureAlbumManager:getPictureMutatedNumberAndMaxStarNum(self._paID)
    if self._mutationsText then
        self._mutationsText:setText(LanguageManager:getInstance():getLocalString(1114099) .. tostring(mNum))
    end

    if self._maxStarText then
        self._maxStarText:setText(LanguageManager:getInstance():getLocalString(1114098) .. tostring(allMaxStar))
    end
    
    for k,v in pairs(self._petPicView) do

        if PictureAlbumManager:picturePetMutatedActivation(self._paID,k) then
            --变异
            if v.mutationImage then
                v.mutationImage:show()
            end
        end

        --新获得宠物的特效表现
        if PictureAlbumManager:canPlayPictureAnimation(self._paID,k) then
            --播放特效
            local upSpine = UI.Animation:create()
            upSpine:init("effect_ui_picturealbum_petunlock.json", "effect_ui_picturealbum_petunlock.atlas", 1);
            upSpine:setAnimation("petunlock", false)

            upSpine:addEventListener(UIEvent.ANIMATION_EVENT,self,function(_, event, sender)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- 播放音效文件
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playSound(soundFilename, false)
                    end
                end
            end)

            local pNode = v.btn:getParent()
            local x,y = v.btn:getPosition()
            local btSize = v.btn._sprite:getContentSize()
            
            upSpine:leftBottom(x + v.soPoint.x, y + v.soPoint.y)
            pNode:addChild(upSpine,999)
            local fsc = 200 / btSize.width
            if fsc > 1.2 then
                fsc = 1.2
            elseif fsc < 0.8 then
                fsc = 0.8
            end

            upSpine:setScale(fsc)


        end

        --这里应该提出需要表现的图片
        if PictureAlbumManager:picturePetActivation(self._paID,k) then
            local picName = v.picName .. "02.png"
            v.btn:setNormal(picName)
            v.btn:setSelected(picName)
            v.btn:setDisabled(picName)
            -- v.btn:disable()
            -- v.btn:setTouchEnable(false)
        end
    end


    --直接删除红点信息
    PictureAlbumManager:removePictureRedData(self._paID)

end

-- 注册监听事件(可选)
function PictureAlbumLayer:registerListener()
    --更新图册界面视图
    Avalon.MessageCenter:bind(AvalonMessage.MC_PICTURE_ALBUM, self, self.onUpdateView)
end


-- 注销监听事件(可选)
function PictureAlbumLayer:unRegisterListener()
    --更新图册界面视图
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PICTURE_ALBUM, self, self.onUpdateView)
end