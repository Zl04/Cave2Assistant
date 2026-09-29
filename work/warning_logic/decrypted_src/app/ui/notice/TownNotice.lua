-- TownNotice.lua
-- Author:ydli
-- 2018年3月26日
-- Using:城镇界面公告
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local TownNotice = class("TownNotice", UI.DownShowWin)
UI.TownNotice = TownNotice
local SdkManager = require"app.game.SdkManager"
-- private:

local model = require("app.uiExport.NoticeModel")
local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
    "ui_general_notice.plist"
}

-- 构造函数
function TownNotice:ctor(dataList, closeCallback)
    TownNotice.super.ctor(self, UIType.LOGIN_NOTICE, COM_RES_LIST, 836, 530)
    self._curIndex = 0
    self:init(dataList, closeCallback)
    require "app.utils.ImageDownLoadUtil"
    ImageDownLoadUtil:setIsFirstShowTNotice(false)
    local pk = RoleDataManager:getMaster():getPK()
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.ShowTownNoticeTime..pk, os.time())
    self._loadPngResList = {} -- 管理png纹理资源
end

-- 析构函数
function TownNotice:dtor()
    TownNotice.super.dtor(self)
    self._curIndex = 0
    local textureCache = cc.Director:getInstance():getTextureCache()
    for k, v in ipairs(self._loadPngResList) do
        textureCache:removeTextureForKey(v)
    end
    self._loadPngResList = {}

    if self.closeCallback then 
        self:closeCallback()
    end
end

-- 初始化
function TownNotice:init(dataList, closeCallback)
    self._dataList = dataList
    self.closeCallback = closeCallback
    TownNotice.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
end

-- 初始化视图
function TownNotice:onInitView()

    self.noticeModel = model.create("Notice")
    self.noticeModel.root:center()
    self:addChild(self.noticeModel.root)
    self:setSize(self.noticeModel.root._width - 80, self.noticeModel.root._height)
    self.bg = self.noticeModel.root

    local contentImg = UI.Image:create()
    contentImg:init()
    contentImg:center()
    self.noticeModel.contentLayer:addChild(contentImg, 1)
    self.contentImg = contentImg

    contentImg:setTouchEnable(true)
    contentImg:addEventListener(UI.Event.COMPONENT_CLICK, self,function()
        self._data = self._data or {}
        print("----time---- now  ,  end", GameManager:getNowServerTime(), self._data.endTime)
        if  self._data.endTime ~= nil and self._data.endTime < GameManager:getNowServerTime() then
            UI.ScrollBar:createByTextID(1170080)
            Avalon.AudioManager:playSound("1503")
            return
        end
        local isLast = false
        if self._curIndex == #self._dataList then
            isLast = true
        end
        if self._data.redirect ~= nil and isLast then
            local isTapTap = false
            if self._data.isTapTap and self._data.isTapTap == 1  then
                isTapTap = true
            end
            
            GameManager:openUrl(self._data.redirect, function(isClose)
                Avalon.AudioManager:playSound("1503")
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_TownNotice, 1, self._data.id)
                -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_TownNotice_Redirect, self._data.id)
                if isClose then
                    self:closeWin()
                end
            end, nil, isTapTap)
        end
    end)

    self:setCloseStartCallBack(function (  )
        if self._curIndex >= #self._dataList then
            return true
        else
            self:showNext()
            return false
        end
    end)
end

-- 更新视图
function TownNotice:onUpdateView()
    -- self.bg:setScale(0.1)
    -- self.bg:runAction(cc.ScaleTo:create(0.2, 1))

    self:showNext()
end

-- 注册监听事件(可选)
function TownNotice:registerListener()
end

-- 注销监听事件(可选)
function TownNotice:unRegisterListener()

end

function TownNotice:showNext()
    Avalon.AudioManager:playSound("1503")
    self._curIndex = self._curIndex + 1
    self._data = self._dataList[self._curIndex] or {}
    if self._bottomRichText ~= nil then
        self._bottomRichText:removeFromParent()
    end
    if self._titleRichText ~= nil then
        self._titleRichText:removeFromParent()
    end
    if self._middleTextBg ~= nil then
        self._middleTextBg:removeFromParent()
    end

    if self.itemBgs ~= nil then
        self.itemBgs = nil
    end

    if self._goodsLayout ~= nil and not tolua.isnull(self._goodsLayout) then
        self._goodsLayout:removeFromParent()
        self._goodsLayout = nil
    end
    
    local titleTexts = self._data.title
    local showTitleText = json.encode(titleTexts)

    local titleRichText = UI.RichText:create()
    local success = titleRichText:initForNetJson(showTitleText, 20, 20, true)
    if success then
        self.noticeModel.noticeContentTitle:setVisible(false)
        titleRichText:center(0, 0)
        self.noticeModel.noticeContentTitleBg:addChild(titleRichText, 10)
        local width = self.noticeModel.noticeContentTitle._width
        width = width + 70
        self.noticeModel.noticeContentTitleBg:setSize(width, self.noticeModel.noticeContentTitleBg._height)
    end
    self._titleRichText = titleRichText 

    local bottomTexts = self._data.bottom
    local showBottomText = json.encode(bottomTexts)
    local bottomRichText = UI.RichText:create()
    local success = bottomRichText:initForNetJson(showBottomText, 20, 20, true)
    if success then
        bottomRichText:rightBottom(137, 72)
        self.bg:addChild(bottomRichText, 10)
    end
    self._bottomRichText = bottomRichText

    -- 中部文字
    if (self._data.middleText1 or self._data.middleText2) then
        local middleTextContentTop = 5

        -- 中部背景
        if (not self._middleTextBg) then
            self._middleTextBg = UI.Image:create()
            self._middleTextBg:init("ui_general_notice_banner_up.png")
            self._middleTextBg:rightUp(137, 149)
            self.bg:addChild(self._middleTextBg)
        end

        -- 中部标题
        if (self._data.middleText1) then
            local jsonSecondTitleText = json.encode(self._data.middleText1)
            self._secondTitleRichText = UI.RichText:create()
            local success = self._secondTitleRichText:initForNetJson(jsonSecondTitleText, 212, 33, true)
            if success then
                middleTextContentTop = 72
                self._secondTitleRichText:center(7, -59)
                self._middleTextBg:addChild(self._secondTitleRichText)

                -- 标题分隔符
                self._titleSplitter = UI.Image:create()
                self._titleSplitter:init("ui_general_notice_banner_line.png")
                self._titleSplitter:rightUp(80, 50)
                self._middleTextBg:addChild(self._titleSplitter)
            end
        else
            if (self._secondTitleRichText) then self._secondTitleRichText:hide() end
            if (self._titleSplitter) then self._titleSplitter:hide() end
        end

        -- 中部文字内容
        if (self._data.middleText2) then
            -- 文字前的标点
            self._middleTextDot = UI.Image:create()
            self._middleTextDot:init("ui_general_notice_banner_purple.png")
            self._middleTextDot:leftUp(40, middleTextContentTop)
            self._middleTextBg:addChild(self._middleTextDot)

            -- 文字内容
            local jsonMiddleText = json.encode(self._data.middleText2)
            self._middleRichText = UI.RichText:create()
            local success = self._middleRichText:initForNetJson(jsonMiddleText, 314, 87, false)
            if success then
                self._middleRichText:leftUp(58, middleTextContentTop)
                self._middleTextBg:addChild(self._middleRichText, 10)
            end
        else
            if (self._middleTextDot) then self._middleTextDot:hide() end
            if (self._middleRichText) then self._middleRichText:hide() end
        end
    else
        if (self._middleTextBg) then self._middleTextBg:hide() end
    end

    -- 下部道具展示
    if (self._data.goods) then
        if (not self._goodsLayout or tolua.isnull(self._goodsLayout)) then
            self._goodsLayout = UI.Layout:create()
            self._goodsLayout:init()
            self._goodsLayout:setSize(339, 102)
            self._goodsLayout:leftUp(423, 338)
            self.bg:addChild(self._goodsLayout)
        end

        -- 道具标签前的标点
        local goodsLabelDot = UI.Image:create()
        goodsLabelDot:init("ui_general_notice_banner_yellow.png")
        goodsLabelDot:leftUp(0, 0)
        self._goodsLayout:addChild(goodsLabelDot)

        -- 道具标签
        local goodsLabel = UI.Text:create()
        goodsLabel:init(LanguageManager:getInstance():getLocalString(1112992) --[["你将获得以下物品:"]], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
        goodsLabel:leftUp(17, -2)
        self._goodsLayout:addChild(goodsLabel)

        if self._data.isTapTap and self._data.isTapTap == 1 then
            goodsLabelDot:hide()
            goodsLabel:hide()
        end

        -- 道具列表
        if (self.itemBgs) then
            for i,v in ipairs(self.itemBgs) do
                v:removeFromParent()
            end
        end
        self.itemBgs = {}
        self.items = {}
        local itemWidth = 84
        for i,v in ipairs(self._data.goods) do
            -- 物品背景
            local itemBg = UI.Image:create()
            itemBg:init("box_quality_box_03.png")
            itemBg:rightBottom(itemWidth * (i - 1), 0)
            self._goodsLayout:addChild(itemBg)

            -- 物品
            local itemData = self:getDummyItemData(v.id, v.num)
            local rewardGrid = UI.GoodsGrid:create()
            rewardGrid:init(itemData)
            rewardGrid:hideNewIcon()
            rewardGrid:setTouchEnable(true)
            rewardGrid:setSwallowTouches(true)
            rewardGrid:setTouchClipNode(self._goodsLayout)
            rewardGrid:showInfoArea(true, false)
            rewardGrid:center()
            itemBg:addChild(rewardGrid)
            table.insert(self.items, rewardGrid)
            table.insert(self.itemBgs, itemBg)
        end 
    else
        if (self._goodsLayout and not tolua.isnull(self._goodsLayout)) then self._goodsLayout:hide() end
    end


    ImageDownLoadUtil:downLoadImage(self._data.image, self.contentImg, function(imgName, localUrl)
        if not tolua.isnull(self.contentImg) and localUrl and localUrl ~= "" then
            self.contentImg:setScale(1, 1)
            self.contentImg:setTexture(localUrl)
            local xScale = 660 / self.contentImg._width
            local yScale = 320 / self.contentImg._height
            self.contentImg:setScale(xScale, yScale)
            table.insert(self._loadPngResList, localUrl)
        end
    end)
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_TownNotice_Open, self._data.id)
end

function TownNotice:showNotice()
    self:open()
end

function TownNotice:getDummyItemData(id, num)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(num or 0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end
