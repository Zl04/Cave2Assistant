-- ArchiveProBar.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:图鉴进度条
UI = UI or {}
local ArchiveProBar = class("ArchiveProBar", UI.HWBtnComponent)
UI.ArchiveProBar = ArchiveProBar

-- 关卡选择资源
local COM_RES_LIST = {
    [1] = "ui_package_log.plist"
}


function ArchiveProBar:ctor(height, resData, intervalNum)
    -- print("ArchiveProBar:ctor")
    ArchiveProBar.super.ctor(
        self,UIType.ARCHIVE_PRO_BAR,
        COM_RES_LIST,
        40,
        height
    )

    self.rootLayer = nil;           --root节点

    self._barHeight = height
    if(resData) then
        self.resData = resData
    else
        self.resData = {1,31,61,91,121,151,180}
    end
    self.intervalNum = intervalNum or 5            --中间几个点点
    self.maxIndex = (#self.resData - 1) * (self.intervalNum + 1)        --最多多少份
    self._dHeight = self._height/(self.maxIndex + 1)                    --每一份的高度

    self._selectIndex = -1;
    self:init();
end


-- public:
-- 初始化
function ArchiveProBar:init()
    ArchiveProBar.super.init(self)
end



-- 模版函数：初始化组建的视图
function ArchiveProBar:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(40,self._barHeight))
    self:addChild(self.rootLayer)

    local _h = 0
    for i = 1,#self.resData do
        if type(self.resData[i]) == "number" then
            local _txt = cc.Label:createWithTTF(tostring(self.resData[i]), UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
            _txt:setPosition(20,self._barHeight - _h)
            _txt:setTextColor(UI.FONT_COLOR_41_41_45)
            self.rootLayer:addChild(_txt,100)
        else
            local _pic = cc.Sprite:createWithSpriteFrameName(self.resData[i])
            _pic:setPosition(20,self._barHeight - _h)
            self.rootLayer:addChild(_pic)
        end

        _h = _h + self._dHeight
        if i ~= #self.resData then
            for j = 1,self.intervalNum do
                local _pic = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_point_0.png")
                _pic:setPosition(20,self._barHeight - _h)
                self.rootLayer:addChild(_pic)
                _h = _h + self._dHeight
            end
        end
    end

    self.selectPic1 = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_point_2.png")
    self.selectPic1:setPosition(20,self._barHeight - _h)
    -- self.selectPic1:setVisible(false)
    self.rootLayer:addChild(self.selectPic1,100)

    self.selectPic2 = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_point_1.png")
    self.selectPic2:setPosition(20,self._barHeight - _h)
    self.selectPic2:setVisible(false)
    self.rootLayer:addChild(self.selectPic2,100)

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self,self,touchPosition)
        local localPosition = self.rootLayer:convertToNodeSpace(touchPosition)
        self:scrollBar(localPosition.y)
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self,self,touchPosition)
        local localPosition = self.rootLayer:convertToNodeSpace(touchPosition)
        self:scrollBar(localPosition.y)
    end)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function(self,self,touchPosition)
        local localPosition = self.rootLayer:convertToNodeSpace(touchPosition)
        self:scrollBar(localPosition.y)
    end)
end

function ArchiveProBar:scrollBar(_y)
    if _y < 0 then
        _y = 0
    elseif _y > self._barHeight then
        _y = self._barHeight
    end
    self:dispatchEvent(UIEvent.PRO_BAR_ARCHIVE_TOUCH,_y)
end

function ArchiveProBar:updateNowBar(_y)
    local index = math.floor((self._barHeight - _y) * 1.0/self._barHeight*self.maxIndex) + 1

    if index < 1 then
        index = 1
    elseif index > self.maxIndex + 1 then
        index = self.maxIndex + 1
    end
    -- print("ArchiveProBar:updateNowBar", _y, self._selectIndex, index)
    if self._selectIndex ~= index then
        if index == 1 or (index - 1) % (self.intervalNum + 1) == 0 then
            self.selectPic1:setVisible(false)
            self.selectPic2:setVisible(true)
            self.selectPic2:setPosition(20,self._barHeight - (index - 1) * self._dHeight + 2)
            self.selectPic2:setScale(0.7)
            self.selectPic2:runAction(cc.ScaleTo:create(0.05,1))
        else
            self.selectPic1:setVisible(true)
            self.selectPic2:setVisible(false)
            self.selectPic1:setPosition(20,self._barHeight - (index - 1) * self._dHeight)
            self.selectPic1:setScale(0.7)
            self.selectPic1:runAction(cc.ScaleTo:create(0.05,1))
        end
        self._selectIndex = index
    end
end

function ArchiveProBar:initBar()
end

-- 模版函数：更新组建的视图
function ArchiveProBar:onUpdateView()
end
