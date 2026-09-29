------------------------------------------------------------------------------
--author: siyu.lin
--date  : 2023/03/09
--desc  : 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetSkillTableView = class("PetSkillTableView", UI.HWBtnComponent)

require "app.modules.petreincarnation.PetSkillCell"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 384
local COM_HEIGHT = 360
--local COM_HEIGHT = 178

local GRID_WIDTH = 90
local GRID_HEIGHT = 90

UI = UI or {}

UI.PetSkillTableView = PetSkillTableView

function PetSkillTableView:ctor()
    PetSkillTableView.super.ctor(
        self,
        UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetSkillTableView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.petreincarnation", "PetReincarnation", false)
    PetSkillTableView.super.init(self, ... )

    self.skillData = {}
    self.skillObjs = {}
    self.curSelectIdx = 0
    self.lastSelectIdx = 0

    --能否拖拽
    self._canDrag = true

    -- ...为传入的petListIdx
    local petID = tonumber(...)
    self.curPet = nil
    if petID and petID > 0 then
        self.curPet = MasterDataManager:getBagPetById(petID)
    end
end

function PetSkillTableView:dtor()
    PetSkillTableView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.petreincarnation.PetSkillTableView")
end


function PetSkillTableView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    self._columnCount = columnCount or 4
    
    local petData = {}
    petData.petsArr = MasterDataManager:getBagPets()
    petData.packetMinShowGridNum = 8
    self._petsData = petData
    self._enableToDoubleClick = false
    self._showChoiceStatus = false
    self._CellList = {}
end

function PetSkillTableView:skillListInit()
    -- 技能书列表
    local gridList = UI.GridList:create()
    gridList:init(UI.PetSkillCell, 4, 2, 90, 75, 0, 0, 0)
    gridList:setSize(self.tableviewSize.width, self.tableviewSize.height) -- 380, 163
    gridList:leftBottom(-11, -200)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.cellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setCircleVisible(false)
    self.skillbookList = gridList
    self.contentLayout:addChild(self.skillbookList)
    self.skillbookList:setData(self.skillData)

    if self.curPet then
        local reincarntionLv = self.curPet:getReincarntionLv()
        if reincarntionLv <= 0 then
            gridList:setBounceEnabled(false)
            gridList:setScrollBarEnabled(false)
        end
    else
        if #self.skillData <= 8 then
            gridList:setBounceEnabled(false)
            gridList:setScrollBarEnabled(false)
        end
    end

    --gridList:setBounceEnabled(false)
end

function PetSkillTableView:setTableViewSize(tableviewSize)
    self.tableviewSize = tableviewSize
end

function PetSkillTableView:updateSkillList(data)
    local saveData = {}
    -- local i = 1
    -- for k,v in pairs(data) do
    --     table.insert(saveData, v)
    --     i = i + 1
    --     if i == 2 then
    --         table.insert(saveData, v)
    --     end
    -- end
    self.skillData = data
    self:skillListInit()
end

function PetSkillTableView:cellClickCallback(bagGrid)
    if not self.curSelect and not self.lastSelect then 
        self.curSelect = bagGrid
        self.lastSelect = bagGrid
    else
        self.lastSelect = self.curSelect
        self.lastSelect:hide()
        self.curSelect = bagGrid
    end

    bagGrid:cellClick()
    -- 技能介绍界面只能放外面，放滚动条里会被遮住部分。
    local cellData = bagGrid:getData()
    if cellData.skill then 
        local skillData = Data.SkillData:create(cellData.skill)
        -- local tip = UI.SkillTips:create(skillData, 3)
        -- local viewWidth, viewHeight = tip:getSize()
        -- tip:leftBottom(- (viewWidth + 28), -42 - 150)
        -- --tip:leftBottom(- (viewWidth + 28), -42 + 0)
        -- tip:init()
        -- self:addChild(tip, 1000)
        if(self.curPet and self.curPet.isFight and self.curPet:isFight()) then 
            local petData = MasterDataManager:getFightPetbyId(self.curPet.spriteID) or RoleDataManager:getFightPetbyId(self.curPet.spriteID)
            if petData then 
                if petData:getSiteId() == 0 then
                    skillData:setIsPetActive(true)
                end
            end
        end

        -- 创建显示信息要在数据初始化好了之后。
        local tip = UI.SkillTips:create(skillData, 3)
        local viewWidth, viewHeight = tip:getSize()
        tip:leftBottom(- (viewWidth + 28), -42 - 150)
        --tip:leftBottom(- (viewWidth + 28), -42 + 0)
        tip:init()
        self:addChild(tip, 1000)
    end


    if self.curPet then
        if self:getParent() then
            if self:getParent().curSkillIndexId then
                -- 这里的处理不是很好，但为了不太改动到老的技能处理的逻辑这里只能这样处理，
                -- 将传一个当前选中的技能下标给parent，然后让那里面的逻辑去运行。
                self:getParent().curSkillIndexId = cellData.id
            end
        end
    end
    
end

function PetSkillTableView:skillClick(idx)
    print("PetSkillTableView:skillClick : ", idx)
    -- TODO:广播点击消息

    local curSkillObj = self.skillObjs[idx]
    if not curSkillObj then
        return
    end

    local select = curSkillObj:getChildByName("Select")
    if not select then
        return
    end

    self.curSelectIdx = idx

    local curData = self.skillData[self.curSelectIdx]
    local skillData = Data.SkillData:create(curData.skill)
    -- print("PetSkillLayer ", curData.skill)
    if(self.curPet and self.curPet.isFight and self.curPet:isFight()) then 
        local petData = MasterDataManager:getFightPetbyId(self.curPet.spriteID) or RoleDataManager:getFightPetbyId(self.curPet.spriteID)
        if petData then 
            if petData:getSiteId() == 0 then
                skillData:setIsPetActive(true)
            end
        end
        -- print("PetSkillLayer 2", curData.skill)
    end

    local tip = UI.SkillTips:create(skillData, 3)
    local viewWidth, viewHeight = tip:getSize()
    tip:leftBottom(- (viewWidth + 28), -42 + 0)
    tip:init()
    self:addChild(tip, 1000)

    select:show()
    select:setAnimation("trigger", false)
    select:addAnimation("idle", true)

    if self.curSelectIdx~= self.lastSelectIdx and self.skillObjs[self.lastSelectIdx] then
        local lastSelect = self.skillObjs[self.lastSelectIdx]:getChildByName("Select")
        if lastSelect then
            lastSelect:hide()
        end
    end

    self.lastSelectIdx = self.curSelectIdx
end


function PetSkillTableView:bindModel()

end


function PetSkillTableView:unbindModel()

end





return PetSkillTableView












