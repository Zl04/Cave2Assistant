-- ArchiveCell.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:图鉴cell
UI = UI or {}
local ArchiveCell = class("ArchiveCell", UI.HWBtnComponent)
UI.ArchiveCell = ArchiveCell

local COM_RES_LIST = {
}

local _width = 287
local _height = 68

function ArchiveCell:ctor(data,idx)
    -- print("ArchiveCell:ctor")
    ArchiveCell.super.ctor(
        self,UIType.ARCHIVE_CELL,
        COM_RES_LIST,
        0,
        0
    )

    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx =idx
    self:init();
end


-- public:
-- 初始化
function ArchiveCell:init()
    ArchiveCell.super.init(self)
end


-- 模版函数：初始化组建的视图
function ArchiveCell:onInitView()
    self.rootLayer = cc.Layer:create();--cc.LayerColor:create(cc.c4b(255,0,0,255))--
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(_width,_height))
    self:addChild(self.rootLayer)

    self.layer1 = cc.Layer:create()
    self.layer1:setPosition(cc.p(0,0))
    self.layer1:setContentSize(cc.size(_width,_height))
    self.rootLayer:addChild(self.layer1)

    local picBG = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_monster1.png")
    picBG:setAnchorPoint(cc.p(0,0))
    picBG:setPosition(0,0)
    self.layer1:addChild(picBG)

    local headBanner_Normal = cc.Sprite:createWithSpriteFrameName("icon_monsterhead_banner_normal.png")
    headBanner_Normal:setPosition(35,35)
    headBanner_Normal:setName("headBG")
    self.layer1:addChild(headBanner_Normal)

    -- 怪物头像
    local picHead = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_monster1.png")
    picHead:setPosition(28,27)
    picHead:setName("head")
    headBanner_Normal:addChild(picHead)

    --怪物名字
    local txtName = cc.Label:createWithTTF("我是描述我是描",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        cc.size(210,100),
        cc.TEXT_ALIGNMENT_LEFT,
        cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    txtName:setAnchorPoint(0, 0.5)
    txtName:setPosition(80,34)
    txtName:setTextColor(UI.FONT_COLOR_41_41_45)
    txtName:setName("name")
    txtName:setFixLineWidth(190)
    self.layer1:addChild(txtName)

    self.layer1:setVisible(false)

    self.layer2 = cc.Layer:create()
    self.layer2:setPosition(cc.p(0,0))
    self.layer2:setContentSize(cc.size(_width,_height))
    self.rootLayer:addChild(self.layer2)

    local picBG = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_monster2.png")
    picBG:setAnchorPoint(cc.p(0,0))
    picBG:setPosition(0,0)
    self.layer2:addChild(picBG)

    local headBanner_Normal = cc.Sprite:createWithSpriteFrameName("icon_monsterhead_banner_normal.png")
    headBanner_Normal:setPosition(35,35)
    headBanner_Normal:setName("headBG")
    self.layer2:addChild(headBanner_Normal)

    -- 怪物头像
    local picHead = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_monster2.png")
    picHead:setPosition(25,25)
    picHead:setName("head")
    headBanner_Normal:addChild(picHead)

    --怪物名字
    local txtName = cc.Label:createWithTTF("我是描述我是描述我是描述",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        cc.size(210,100),
        cc.TEXT_ALIGNMENT_LEFT,
        cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    txtName:setPosition(190,34)
    txtName:setTextColor(UI.FONT_COLOR_41_41_45)
    txtName:setName("name")
    self.layer2:addChild(txtName)
    self.layer2:setVisible(false)

    self.layer3 = cc.Layer:create()
    self.layer3:setPosition(cc.p(0,0))
    self.layer3:setContentSize(cc.size(_width,_height))
    self.rootLayer:addChild(self.layer3)

    local picBG = cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_monster3.png")
    picBG:setAnchorPoint(cc.p(0,0))
    picBG:setPosition(0,0)
    self.layer3:addChild(picBG)

    --怪物名字
    local txtName = cc.Label:createWithTTF("????????",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        cc.size(210,100),
        cc.TEXT_ALIGNMENT_LEFT,
        cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    txtName:setPosition(190,34)
    txtName:setTextColor(UI.FONT_COLOR_41_41_45)
    txtName:setName("name")
    self.layer3:addChild(txtName)
    self.layer3:setVisible(false)


    self.layer4 = cc.Layer:create()
    self.layer4:setPosition(cc.p(0,0))
    self.layer4:setContentSize(cc.size(_width,_height))
    self.rootLayer:addChild(self.layer4)

    --怪物名字
    local txtName = cc.Label:createWithTTF("我是描述",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        cc.size(110,100),
        cc.TEXT_ALIGNMENT_CENTER,
        cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
    txtName:setPosition(145,14)
    txtName:setTextColor(UI.FONT_COLOR_41_41_45)
    txtName:setName("name")
    self.layer4:addChild(txtName)
    self.layer4:setVisible(true)

    self:reload(self.data,self.idx)
end

-- 模版函数：更新组建的视图
function ArchiveCell:onUpdateView()
end


function ArchiveCell:reload(data,idx)
    if data.type == 1 then
        self.layer1:setVisible(false)
        self.layer2:setVisible(false)
        self.layer3:setVisible(false)
        self.layer4:setVisible(true)

        local txtName = self.layer4:getChildByName("name")
        txtName:setString(data.data)
    elseif data.type == 2 then
        if data.state == 0 then
            self.layer1:setVisible(false)
            self.layer2:setVisible(false)
            self.layer3:setVisible(true)
            self.layer4:setVisible(false)
        else
            local picHead = nil
            if data.select then
                self.layer1:setVisible(false)
                self.layer2:setVisible(true)
                self.layer3:setVisible(false)
                self.layer4:setVisible(false)
                local txtName = self.layer2:getChildByName("name")
                txtName:setString(data.data.name)

                picHead = self.layer2:getChildByName("headBG"):getChildByName("head")
            else
                self.layer1:setVisible(true)
                self.layer2:setVisible(false)
                self.layer3:setVisible(false)
                self.layer4:setVisible(false)

                local txtName = self.layer1:getChildByName("name")
                txtName:setString(data.data.name)

                picHead = self.layer1:getChildByName("headBG"):getChildByName("head")               
            end
            if picHead then
                local iconName =  AvalonUtil.getHeXieSpriteFrameName(data.data.icon .. ".png")
                picHead:setSpriteFrame(iconName)
            end
        end
    else
        assert(false)
    end
end

