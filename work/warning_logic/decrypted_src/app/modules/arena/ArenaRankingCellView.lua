------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaRankingCellView = class("ArenaRankingCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 886
local COM_HEIGHT = 95

function ArenaRankingCellView:ctor(pRankingLayer, data)
    ArenaRankingCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.single = false  --是否是一个单独的界面，不放在tableview 里面
    self.isBottom = false -- 在single == true的前提下是否是 底部cell
    self.oldIndex = -1
    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx = data.rank
    self.pRankingLayer = pRankingLayer
    self.rewardItems = {}

    self:init();
end

function ArenaRankingCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaRankingCellView.super.init(self, ... )
end

function ArenaRankingCellView:dtor()
    ArenaRankingCellView.super.dtor(self)
    self:unbindModel()
    self.rewardItems = {}
    reload_script_file_mvc("app.modules.arena.ArenaRankingCellView")
end


function ArenaRankingCellView:onInitView()
    self.rootLayer = UI.Layout:create();
    self.rootLayer:init()
    self.rootLayer:setSize(COM_WIDTH, COM_HEIGHT)
    self.rootLayer:center()
    self:addChild(self.rootLayer)
    -- self.rootLayer:enableDebugDraw()

    -- ui_arena_rank_belowbanner.png

    local picRankNum = UI.Image:create()
    picRankNum:init("ui_rankinglist_gold.png")
    picRankNum:centerLeft(44-picRankNum:getContentSize().width/2)
    picRankNum:setName("picRankNum")
    self.rootLayer:addChild(picRankNum)

    --排名
    local txtRankNum = UI.Text:create()
    txtRankNum:init("1", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    txtRankNum:setSize(80, 30)
    txtRankNum:centerLeft(4)
    -- txtRankNum:enableDebugDraw()
    txtRankNum:setName("txtRankNum")
    txtRankNum:setTextCenter()
    self.rootLayer:addChild(txtRankNum)

    local headBg = UI.Image:create()
    headBg:init("ui_information_headframe_bottom.png")
    headBg:centerLeft(130)
    self.rootLayer:addChild(headBg, 1)
    headBg:setScale(0.79)
    self.headBg = headBg

    --名字
    local txtName = UI.Text:create()
    txtName:init("name", UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtName:setSize(200,45)
    txtName:centerLeft(208)
    -- txtName:enableDebugDraw()
    txtName:setName("txtName")
    txtName:setTextCenter()
    self.rootLayer:addChild(txtName)

    -- 图标
    local picData = UI.Image:create()   
    picData:init("symbol_character_hero_integral.png")
    picData:centerLeft(440)
    picData:setName("picData")
    self.rootLayer:addChild(picData)

    --排名数据
    local txtData = UI.NumberText:create("11", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- txtData:setSize(88,45)
    txtData:setTextCenter()
    txtData:centerLeft(466)
    txtData:setName("txtData")
    -- txtData:enableDebugDraw()
    self.rootLayer:addChild(txtData)

    -- 赛季奖励
    -- local goodData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Coin)
    local goodData = GoodsDataManager:createLocalGoodsData(20010051)
    goodData:setIsNew(false)
    local beginPosX = 63
    local itemPadding = 77
    for i = 1, 3 do
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        goodGrid:setTouchEnable(true)
        goodGrid:setSwallowTouches(false)
        goodGrid:showInfoArea(true, false)
        goodGrid:centerRight(beginPosX)
        beginPosX = beginPosX + itemPadding
        self.rootLayer:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:showCountLabel()
        -- goodGrid:setTouchClipNode(self.touchClipNode)

        -- goodGrid:hide()
        table.insert(self.rewardItems, goodGrid)
    end


    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(COM_WIDTH, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setAnchorPoint(0, 0)
    _picLine:setPosition(cc.p(0, 0))
    self.rootLayer:addChild(_picLine)
    self.picLine = _picLine

    if self.data ~= nil then
        self:reload(self.data)
    end
end

function ArenaRankingCellView:bindModel()

end


function ArenaRankingCellView:unbindModel()

end

function ArenaRankingCellView:reload(data)
    -- print("ArenaRankingCellView:reload",idx,rankingType,myRank,data.rank,data.faceId)
    if(data) then
        self.data = data
        local idx = data.rank
        local picRankNum = self.rootLayer:getChildByName("picRankNum")
        local txtRankNum = self.rootLayer:getChildByName("txtRankNum")
        if idx <= 3 then
            if idx == 1 then
                picRankNum:setVisible(true)
                txtRankNum:setVisible(false)
                picRankNum:setSpriteName("ui_rankinglist_gold.png")
            elseif idx == 2 then
                picRankNum:setVisible(true)
                txtRankNum:setVisible(false)
                picRankNum:setSpriteName("ui_rankinglist_silver.png")
            elseif idx == 3 then
                picRankNum:setVisible(true)
                txtRankNum:setVisible(false)
                picRankNum:setSpriteName("ui_rankinglist_copper.png")
            end
        else
            picRankNum:setVisible(false)
            txtRankNum:setVisible(true)
        end

        txtRankNum:setText(tostring(data.rank or "---"))

        if self.single or tonumber(data.rank) > 200 then
            local picBG = UI.Image:create()
            picBG:init("ui_arena_rank_belowbanner.png")
            picBG:setName("picBG")
            picBG:centerLeft(-35)
            self.rootLayer:addChild(picBG, -1)
        else
            self.rootLayer:removeChildByName("picBG")
        end

        if data.sex == nil or data.sex == 0 then
            data.sex = 1
        end
        if self.rootLayer:getChildByName("heorIcon") then
            self.rootLayer:removeChildByName("heorIcon") 
        end

        local txtName = self.rootLayer:getChildByName("txtName")
        txtName:setText(ToolsUtil:replaceShowNickNameStr(data.nickName))

        self.pRankingLayer:getHead(data.sex,data.faceId,handler(self,self.refreshFace),idx)

        local txtData = self.rootLayer:getChildByName("txtData")
        if txtData  then
            txtData:setText(data.score or 0)
        end
        -- self.picLine:setPosition(40, 0)
        if(self.single) then 
            self.picLine:hide()
        else
            self.picLine:show()
        end

        -- for k,v in ipairs(self.rewardItems) do 
        --     local goodsData = nil
        --     if(goodsData) then
        --         v:setData(goodsData)
        --         v:show()
        --     else
        --         v:hide()
        --     end
        -- end
    end
end

function ArenaRankingCellView:refreshFace(pic,faceDecodeID)
    -- print("pic,faceDecodeID",pic,faceDecodeID)
    if self.rootLayer and not tolua.isnull(self.rootLayer) then
        if self.headBg and self.headBg:getChildByName("heorIcon") then
            self.headBg:removeChildByName("heorIcon", true)    
        end
        pic:setPosition(self.headBg:getContentSize().width / 2, self.headBg:getContentSize().height / 2)
        pic:setName("heorIcon")
        self.headBg:addChild(pic, 5)
        self.headBg:show()
    end
end

function ArenaRankingCellView:setSingle(single, isBottom)
    self.single = single
    self.isBottom = isBottom
    if(self.data) then
        self:reload(self.data)
    end
end



return ArenaRankingCellView












