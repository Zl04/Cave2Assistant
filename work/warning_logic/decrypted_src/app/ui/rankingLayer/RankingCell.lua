-- RankingCell.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:排行榜cell

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local RankingCell = class("RankingCell", UI.HWBtnComponent)
UI.RankingCell = RankingCell

local COM_RES_LIST = {
}

local _width = 557
local _height = 73

function RankingCell:ctor(data,idx,rankingType,myRank,pRankingLayer)
    print("RankingCell:ctor")
    RankingCell.super.ctor(
        self,UIType.RANKING_CELL,
        COM_RES_LIST,
        _width,
        _height
    )
    self.single = false  --是否是一个单独的界面，不放在tableview 里面
    self.isBottom = false -- 在single == true的前提下是否是 底部cell
    self.oldIndex = -1
    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx =idx
    self.rankingType = rankingType
    self.myRank = myRank
    self.pRankingLayer = pRankingLayer

    self:init();
    -- self:enableDebugDraw()
end


-- public:
-- 初始化
function RankingCell:init()
    RankingCell.super.init(self)
end


-- 模版函数：初始化组建的视图
function RankingCell:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(_width,_height))
    self:addChild(self.rootLayer)

    local picRankNum = cc.Sprite:createWithSpriteFrameName("ui_rankinglist_gold.png")
    picRankNum:setPosition(72,34)
    picRankNum:setName("picRankNum")
    self.rootLayer:addChild(picRankNum)

  
    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(552, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setAnchorPoint(0, 0)
    _picLine:setPosition(cc.p(40, 0))
    self.rootLayer:addChild(_picLine)
    self.picLine = _picLine
    --排名
    local txtRankNum = UI.Text:create()
    txtRankNum:init("1", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    txtRankNum:setSize(80, 30)
    txtRankNum:centerLeft(31)
    -- txtRankNum:enableDebugDraw()
    txtRankNum:setName("txtRankNum")
    txtRankNum:setTextCenter()
    self.rootLayer:addChild(txtRankNum)

    --名字\
    local txtName = UI.Text:create()
    txtName:init("name", UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtName:setSize(200,45)
    txtName:centerLeft(234)
    -- txtName:enableDebugDraw()
    txtName:setName("txtName")
    txtName:setTextCenter()
    self.rootLayer:addChild(txtName)

    --名字二级描述（公会ID）
    local txtNameDesc = UI.Text:create()
    txtNameDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    txtNameDesc:setSize(200,20)
    txtNameDesc:centerLeft(234)
    txtNameDesc:setName("txtNameDesc")
    txtNameDesc:setTextCenter()
    self.rootLayer:addChild(txtNameDesc)
    -- txtNameDesc:enableDebugDraw()

    -- 图标
    local picData = UI.Image:create()   
    picData:init("symbol_character_hero_power.png")
    picData:centerLeft(484)--leftBottom(484, 29)
    picData:setName("picData")
    self.rootLayer:addChild(picData)

    --排名数据
    local txtData = UI.NumberText:create("11", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtData:setSize(88,45)
    txtData:setTextCenter()
    txtData:centerLeft(500)
    txtData:setName("txtData")
    -- txtData:enableDebugDraw()
    self.rootLayer:addChild(txtData)

    local headID = {}
    local faceDecodeID = "30"..(math.random(100)%2 + 1).."0"..(math.random(100)%2 + 1).."0"..(math.random(100)%2 + 1)

    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:centerLeft(130)
    self.rootLayer:addChild(headBg, 1)
    headBg:setScale(0.79)
    self.headBg = headBg

    local headCap = UI.Image:create()
    headCap:init("ui_information_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap, 10)

    if self.data ~= nil then
        self:reload(self.data,self.idx,self.rankingType,self.myRank)
    end
end

-- 模版函数：更新组建的视图
function RankingCell:onUpdateView()
end

function RankingCell:hightLight()
    if(self.touchImage == nil) then 
        self.touchImage = UI.Image9:create()
        self.touchImage:init("ui_information_selectedbox.png", CCRectMake(16,15,1,1), cc.size(_width + 20, _height))
        self.touchImage:center(19)
        self:addChild(self.touchImage, 100)
    end
    self.touchImage:setVisible(true)
end

function RankingCell:unHightLight()
    if(self.touchImage) then 
        self.touchImage:setVisible(false)
    end
end

function RankingCell:reload(data,idx,rankingType,myRank)
    -- print("RankingCell:reload",idx,rankingType,myRank,data.rank,data.faceId)
    self.data = data
    self.idx =idx
    self.rankingType = rankingType
    self.myRank = myRank
    local picRankNum = self.rootLayer:getChildByName("picRankNum")
    local txtRankNum = self.rootLayer:getChildByName("txtRankNum")
    if idx < 3 then
        if idx == 0 then
            picRankNum:setVisible(true)
            txtRankNum:setVisible(false)
            picRankNum:setSpriteFrame("ui_rankinglist_gold.png")
        elseif idx == 1 then
            picRankNum:setVisible(true)
            txtRankNum:setVisible(false)
            picRankNum:setSpriteFrame("ui_rankinglist_silver.png")
        elseif idx == 2 then
            picRankNum:setVisible(true)
            txtRankNum:setVisible(false)
            picRankNum:setSpriteFrame("ui_rankinglist_copper.png")
        end
    elseif self.oldIndex < 3 then
        picRankNum:setVisible(false)
        txtRankNum:setVisible(true)
    end

    txtRankNum:setText(tostring(data.rank or "---"))

    if data.sex == nil or data.sex == 0 then
        data.sex = 1
    end
    if self.rootLayer:getChildByName("heorIcon") then
        self.rootLayer:removeChildByName("heorIcon") 
    end

    local txtName = self.rootLayer:getChildByName("txtName")
    txtName:setText(ToolsUtil:replaceShowNickNameStr(data.nickName))
    local txtNameDesc = self.rootLayer:getChildByName("txtNameDesc")
    if rankingType == PublicDefine.RankType.RankType_EquipMent or 
        rankingType == PublicDefine.RankType.RankType_Achievement or 
        rankingType == PublicDefine.RankType.RankType_Dungeon or
        rankingType == PublicDefine.RankType.RankType_Mentor
    then
        txtName:centerLeft(234)
        txtName:setSize(200,45)
        txtNameDesc:setText("")
        txtNameDesc:hide()
        if self.headBg and self.headBg:getChildByName("heorIcon") then
            self.headBg:removeChildByName("heorIcon", true)
            self.headBg:show()
        end
        self.pRankingLayer:getHead(data.sex,data.faceId,handler(self,self.refreshFace),idx)
    elseif rankingType == PublicDefine.RankType.RankType_Guild then
        if self.headBg and self.headBg:getChildByName("heorIcon") then
            self.headBg:removeChildByName("heorIcon", true)
        end
        local icon = GameDataManager:getInstance():getGuildIconForIconID(data.faceId)
        -- print("----data.faceId----",data.faceId,icon)
        if icon ~= nil then
            local pic = cc.Sprite:createWithSpriteFrameName(GameDataManager:getInstance():getGuildIconForIconID(data.faceId))
            pic:setPosition(128 + self.headBg:getContentSize().width / 2, self.headBg:getContentSize().height / 2)
            pic:setName("heorIcon")
            pic:setScale(0.8)
            self.rootLayer:addChild(pic, 2)            
            self.headBg:hide()
        else
            self.headBg:show()
        end
        if data.pk == nil or data.pk == 0 then
            txtName:centerLeft(234)
            txtName:setSize(200,45)
            txtNameDesc:setText("")
            txtNameDesc:hide()
        else
            txtName:centerLeft(234)
            txtName:setSize(200, 25)
            txtNameDesc:setText(string.format("ID:%d", data.pk))
            txtNameDesc:show()
            txtName:leftUp(234, 14)
            txtNameDesc:leftBottom(234, 14)
        end
    end

    local picData = self.rootLayer:getChildByName("picData")
    local txtData = self.rootLayer:getChildByName("txtData")
    self.picLine:setPosition(40, 0)
    if data.rank == nil or myRank == idx + 1 or tonumber(data.rank) > 200 then
        self.rootLayer:removeChildByName("picBG")   
        local picBG = UI.Image:create()
        if self.single then
            if self.isBottom then
                picBG:init("ui_rankinglist_bg1.png")
                self.picLine:setPosition(40, 74)
            else
                picBG:init("ui_rankinglist_bg2.png")
            end
            picBG:centerLeft(9)
        else
            picBG:init("ui_rankinglist_me.png")
            picBG:centerLeft(30) 
        end
        picBG:setName("picBG")
        self.rootLayer:addChild(picBG, -1)
    else
        if self.rootLayer:getChildByName("picBG") then
            self.rootLayer:removeChildByName("picBG")
        end
    end

    if rankingType ~= PublicDefine.RankType.RankType_Dungeon then
        if rankingType == PublicDefine.RankType.RankType_EquipMent then
            picData:setSpriteName("ui_information_equip.png")
        elseif rankingType == PublicDefine.RankType.RankType_Achievement then
            picData:setSpriteName("ui_information_achievement.png")
        elseif rankingType == PublicDefine.RankType.RankType_Guild then
            picData:setSpriteName("symbol_guild_tech_icon_medal.png")
        end
        
        txtData:setText(data.score)
        picData:setVisible(true)
    else
        if data.score ~= 0 then
            local level,score = ToolsUtil:getDungeonMaxLevel(data.score)
            -- txtData:setString(level.."#"..score)
            picData:setVisible(true)
            txtData:setText(string.format(UI.TEXT_110073,level,ToolsUtil:getTime(score)))
            picData:setSpriteName("ui_information_fam.png")   
        else
            txtData:setText(UI.TEXT_110075)
            picData:setVisible(false) 
        end
    end

    self.oldIndex = idx
end

function RankingCell:refreshFace(pic,faceDecodeID)
    -- print("pic,faceDecodeID",pic,faceDecodeID)
    if self.rootLayer and not tolua.isnull(self.rootLayer) and self.rankingType ~= PublicDefine.RankType.RankType_Guild then
        if self.headBg and self.headBg:getChildByName("heorIcon") then
            self.headBg:removeChildByName("heorIcon", true)    
        end
        pic:setPosition(self.headBg:getContentSize().width / 2, self.headBg:getContentSize().height / 2)
        pic:setName("heorIcon")
        self.headBg:addChild(pic, 5)
        self.headBg:show()
    end
end

function RankingCell:setSingle(single, isBottom)
    self.single = single
    self.isBottom = isBottom
end