------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphsCastingLayer = class("GlyphsCastingLayer", UI.HWBtnComponent)
local GlyphsPacketLayer = require "app.modules.glyphs.GlyphsPacketLayer"
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {

}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local RIGHT_COM_W = 440
local RIGHT_COM_H = 430

local CELL_WIDTH = 838
local CELL_HEIGHT = 143

function GlyphsCastingLayer:ctor()
    GlyphsCastingLayer.super.ctor(
    	self,
    	UI.Type.GLYPHS_CASTING,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.dustUseBtnList = {}
    self.fragmentUseBtnList = {}
    self.crystalUseBtnList = {}

    self.dustUseLevel = nil
    self.fragmentUseLevel = nil
    self.crystalUseLevel = nil

    self.dustNeedNum = 0
    self.fragmentNeedNum = 0
    self.crystalNeedNum = 0

    self.dustUsedId = {}
    self.fragmentUsedId = {}
    self.crystalUsedId = {}

    self:bindModel()
end

function GlyphsCastingLayer:init( ... )
    GlyphsCastingLayer.super.init(self, ... )
end

function GlyphsCastingLayer:dtor()
    GlyphsCastingLayer.super.dtor(self)
    self:unbindModel()

    self.dustUseBtnList = {}
    self.fragmentUseBtnList = {}
    self.crystalUseBtnList = {}

    self.dustUseLevel = nil
    self.fragmentUseLevel = nil
    self.crystalUseLevel = nil

    self.dustNeedNum = 0
    self.fragmentNeedNum = 0
    self.crystalNeedNum = 0

    self.dustUsedId = {}
    self.fragmentUsedId = {}
    self.crystalUsedId = {}

    reload_script_file_mvc("app.modules.glyphs.GlyphsCastingLayer")
end

function GlyphsCastingLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:initLeftLayer()
    self:addGlyphsPacketView()
end

function GlyphsCastingLayer:initLeftLayer()
    -- 内容面板
    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    leftLayout:centerLeft(30)
    self.contentLayout:addChild(leftLayout)
    self.leftLayout = leftLayout

    local glyphForgingconfig = ConfigManager:getGlyphForgingAllData()

    for k, v in ipairs(glyphForgingconfig) do
        local useMaterialLayout = self:createUseMaterialView(k, v)
        useMaterialLayout:centerUp((k-1)*85)
        leftLayout:addChild(useMaterialLayout)
    end

    local line  = UI.Image:create()
    line:init("ui_glyphs_line_1.png")
    line:centerBottom(170)
    leftLayout:addChild(line)

    local usedMaterialDesBg  = UI.Image:create()
    usedMaterialDesBg:init("ui_glyphs_label_3.png")
    usedMaterialDesBg:leftBottom(15, 130)
    leftLayout:addChild(usedMaterialDesBg)

    local usedMaterialText = UI.Text:create()
    usedMaterialText:init(UI.TEXT_227056, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_152_151_151)
    usedMaterialText:centerLeft(10)
    usedMaterialDesBg:addChild(usedMaterialText)

    local leftCastingTimes = UI.Text:create()
    leftCastingTimes:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    leftCastingTimes:centerBottom(-12)
    leftLayout:addChild(leftCastingTimes)
    self.leftCastingTimes = leftCastingTimes

    local castingBtn = UI.Button:create();
    castingBtn:init("ui_glyphs_btn_2.png","ui_glyphs_btn_2.png","ui_glyphs_btn_2_3.png")
    castingBtn:centerBottom(10)
    castingBtn:setText(UI.TEXT_227054)
    castingBtn:setFontSize(UI.FONT_SIZE_20PX)
    castingBtn:setFontColor(UI.FONT_COLOR_47_50_55)
    leftLayout:addChild(castingBtn)
    castingBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:castingGlyphs()
    end)
    self.castingBtn = castingBtn
    castingBtn:disable() 

    self:updateDailyCastingNum()
end

function GlyphsCastingLayer:createUseMaterialView(index, data)
    local useMaterialLayout = UI.Layout:create()
    useMaterialLayout:init()
    useMaterialLayout:setSize(RIGHT_COM_W-30, 80)
    -- useMaterialLayout:centerLeft(20)
    -- useMaterialLayout:enableDebugDraw()
    -- self.leftLayout:addChild(useMaterialLayout)
    -- self.useMaterialLayout = useMaterialLayout

    local titleBg  = UI.Image:create()
    titleBg:init("ui_glyphs_label_1.png")
    titleBg:leftUp(0, 0)
    useMaterialLayout:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(languageManagerInstance:getLocalString(data.name), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_152_151_151)
    titleText:centerLeft(10)
    titleBg:addChild(titleText)

    local levelList = string.split(data.level, ";")
    for k, v in ipairs(levelList) do
        local levelBtn = UI.Button:create();
        levelBtn:init("ui_glyphs_box_1.png","ui_glyphs_btn_1.png","ui_glyphs_box_1.png")
        levelBtn:centerLeft((k-1)*85, 7)
        levelBtn:setText(string.format(UI.TEXT_227055, k))
        levelBtn:setFontSize(UI.FONT_SIZE_18PX)
        levelBtn:setFontColor(UI.FONT_COLOR_47_50_55)
        levelBtn:closeClickScale()
        useMaterialLayout:addChild(levelBtn)
        levelBtn:addEventListener(UIEvent.BUTTON_RELEASE,self,function(self)
            self:onMaterialUsed(levelBtn, index, k, data)
        end)

        if index == 1 then
            self.dustUseBtnList[k] = levelBtn
        elseif index == 2 then
            self.fragmentUseBtnList[k] = levelBtn
        elseif index == 3 then
            self.crystalUseBtnList[k] = levelBtn
        end
    end

    return useMaterialLayout
end

function GlyphsCastingLayer:addGlyphsPacketView()
    local hideTypeList = {
        UI.BagGoodsPanel.BAG_TYPE.ALL,
        UI.BagGoodsPanel.BAG_TYPE.ITEM,
        UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
        UI.BagGoodsPanel.BAG_TYPE.RELIC,
        UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
        UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
    }
    local showList = {
        UI.BagGoodsPanel.BAG_TYPE.GLYPH,
    }
    local glyphsPacketLayer = GlyphsPacketLayer:create(hideTypeList, showList)
    glyphsPacketLayer:init()
    glyphsPacketLayer:centerRight(0)
    self.contentLayout:addChild(glyphsPacketLayer, 99)
    glyphsPacketLayer:getBagList():changeBagDefaultIndex(19)
end

function GlyphsCastingLayer:onMaterialUsed(btn, btnType, level, data)
    if btn:getChoiced() then
        btn:setBtnStatus(2)
        return 
    end

    local materialIdList = string.split(data.materialId, ";")
    local useNumList = string.split(data.materialNum, ";")
    local haveNum = 0
    local needNum = 0
    local usedMaterialiIdList = {}
    local pk = RoleDataManager:getMaster():getPK()
    local materialName = ""
    if btnType == 1 then
        self.dustUsedId = {}
        
        -- needNum = tonumber(useNumList[level])
        usedMaterialiIdList = self.dustUsedId
        materialName = UI.TEXT_227069
    elseif btnType == 2 then
        self.fragmentUsedId = {}
        -- needNum = tonumber(useNumList[level])
        usedMaterialiIdList = self.fragmentUsedId
        materialName = UI.TEXT_227070
    elseif btnType == 3 then
        self.crystalUsedId = {}
        -- needNum = tonumber(useNumList[level])
        usedMaterialiIdList = self.crystalUsedId
        materialName = UI.TEXT_227071
    end
    needNum = tonumber(useNumList[level])

    for k ,v in pairs(materialIdList) do
        local id = tonumber(v)
        local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, id)

        if itemTotalNum > 0 then
            local itemData = {}
            itemData.id = id
            itemData.num = itemTotalNum >= needNum - haveNum and needNum - haveNum or itemTotalNum
            haveNum = haveNum + itemTotalNum
            table.insert(usedMaterialiIdList, itemData)
        end
        
        if haveNum >= needNum then
            break
        end
    end
    -- dump(usedMaterialiIdList, "usedMaterialiIdListaa")
    if haveNum < needNum then
        -- usedMaterialiIdList = {}
        table.clear(usedMaterialiIdList)
        -- self:clearSelectedData(btnType)
        UI.ScrollBar:createByText(string.format(UI.TEXT_227057, materialName, needNum))
        return 
    end

    if btnType == 1 then
        if self.dustUseLevel then
            self.dustUseBtnList[self.dustUseLevel]:setBtnStatus(1)
            self.dustUseBtnList[self.dustUseLevel]:setChoiced(false)
        end
        self.dustUseLevel = level

        self.dustNeedNum = needNum--tonumber(useNumList[level])
    elseif btnType == 2 then
        if self.fragmentUseLevel then
            self.fragmentUseBtnList[self.fragmentUseLevel]:setBtnStatus(1)
            self.fragmentUseBtnList[self.fragmentUseLevel]:setChoiced(false)
        end
        self.fragmentUseLevel = level
        self.fragmentNeedNum = needNum--tonumber(useNumList[level])
    elseif btnType == 3 then
        if self.crystalUseLevel then
            self.crystalUseBtnList[self.crystalUseLevel]:setBtnStatus(1)
            self.crystalUseBtnList[self.crystalUseLevel]:setChoiced(false)
        end
        
        self.crystalUseLevel = level
        self.crystalNeedNum = needNum--tonumber(useNumList[level])
    end
    
    btn:setBtnStatus(2)
    btn:setChoiced(true)

    self:refreshSelectedMaterialsView(data, btnType, usedMaterialiIdList)
    self:updateBtnState()
end

function GlyphsCastingLayer:refreshSelectedMaterialsView(config, btnType, usedMaterialiIdList)
    local showIDList = {}
    for k, v in pairs(self.dustUsedId) do
        table.insert(showIDList, v)
    end
    for k, v in pairs(self.fragmentUsedId) do
        table.insert(showIDList, v)
    end
    for k, v in pairs(self.crystalUsedId) do
        table.insert(showIDList, v)
    end

    if self.selectedMaterialsNode then
        self.selectedMaterialsNode:removeFromParent(true)
        self.selectedMaterialsNode = nil
    end

    local selectedMaterialsNode = UI.RewardPreViewUtil:create()
    selectedMaterialsNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    selectedMaterialsNode:init(nil, 5.1, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    for k, v in pairs(showIDList) do 
        selectedMaterialsNode:addGoodsId(v.id, v.num or 0)
    end
    selectedMaterialsNode:centerBottom(45)
    selectedMaterialsNode:showGoodsView()
    self.leftLayout:addChild(selectedMaterialsNode)
    self.selectedMaterialsNode = selectedMaterialsNode
    -- selectedMaterialsNode:enableDebugDraw()
end

function GlyphsCastingLayer:updateBtnState()
    if not self.dustUseLevel or 
    not self.fragmentUseLevel or 
    not self.crystalUseLevel then
        self.castingBtn:disable() 
    else
        local totalLevel = self.dustUseLevel + self.fragmentUseLevel + self.crystalUseLevel
        if totalLevel ~= 10 then
            self.castingBtn:disable() 
            UI.ScrollBar:createByText(UI.TEXT_227058)
            return 
        end

        self.castingBtn:enable() 
    end

end

-- function GlyphsCastingLayer:clearSelectedData(btnType)
--     if btnType == 1 then
--         if self.dustUseLevel then
--             self.dustUseBtnList[self.dustUseLevel]:setBtnStatus(1)
--         end
--         self.dustUseLevel = nil

--         self.dustNeedNum = 0
--     elseif btnType == 2 then
--         if self.fragmentUseLevel then
--             self.fragmentUseBtnList[self.fragmentUseLevel]:setBtnStatus(1)
--         end
--         self.fragmentUseLevel = nil
--         self.fragmentNeedNum = 0
--     elseif btnType == 3 then
--         if self.crystalUseLevel then
--             self.crystalUseBtnList[self.crystalUseLevel]:setBtnStatus(1)
--         end
        
--         self.crystalUseLevel = nil
--         self.crystalNeedNum = 0
--     end
-- end


function GlyphsCastingLayer:clearSelectedData()
    if self.dustUseLevel then
        self.dustUseBtnList[self.dustUseLevel]:setBtnStatus(1)
        self.dustUseBtnList[self.dustUseLevel]:setChoiced(false)
    end

    self.dustUseLevel = nil
    self.dustNeedNum = 0
    
    if self.fragmentUseLevel then
        self.fragmentUseBtnList[self.fragmentUseLevel]:setBtnStatus(1)
        self.fragmentUseBtnList[self.fragmentUseLevel]:setChoiced(false)
    end

    self.fragmentUseLevel = nil
    self.fragmentNeedNum = 0
    
    if self.crystalUseLevel then
        self.crystalUseBtnList[self.crystalUseLevel]:setBtnStatus(1)
        self.crystalUseBtnList[self.crystalUseLevel]:setChoiced(false)
    end
    
    self.crystalUseLevel = nil
    self.crystalNeedNum = 0

    if self.selectedMaterialsNode then
        self.selectedMaterialsNode:removeFromParent(true)
        self.selectedMaterialsNode = nil
    end
    self.dustUsedId = {}
    self.fragmentUsedId = {}
    self.crystalUsedId = {}
    self.castingBtn:disable() 
end

function GlyphsCastingLayer:castingGlyphs()
    local master = RoleDataManager:getMaster()
    local castingFrequency = tonumber(ConfigManager:getGeneralForKey("castingFrequency"))
    local dailyComposeNum = castingFrequency - master:getGlyphComposeNum() >= 0 and castingFrequency - master:getGlyphComposeNum() or 0
    if dailyComposeNum <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_227073)
        return 
    end

    if not self.dustUseLevel or 
    not self.fragmentUseLevel or 
    not self.crystalUseLevel then
        return 
    end

    if GameDataManager:getFreeGlyphsBoxNum() <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_227068)
        return 
    end

    local levelList = {
        [1] = self.dustUseLevel,
        [2] = self.fragmentUseLevel, 
        [3] = self.crystalUseLevel, 
    }

    Net.NetNPCSystem:reqComposeGlyphs(levelList)
end

function GlyphsCastingLayer:updateDailyCastingNum()
    local master = RoleDataManager:getMaster()
    local castingFrequency = tonumber(ConfigManager:getGeneralForKey("castingFrequency"))
    local dailyComposeNum = castingFrequency - master:getGlyphComposeNum() >= 0 and castingFrequency - master:getGlyphComposeNum() or 0
    
    self.leftCastingTimes:setText(string.format(UI.TEXT_227072, dailyComposeNum))
end

function GlyphsCastingLayer:close()
    GlyphsCastingLayer.super.close(self)
end

function GlyphsCastingLayer:bindModel()

end

function GlyphsCastingLayer:unbindModel()

end


return GlyphsCastingLayer












