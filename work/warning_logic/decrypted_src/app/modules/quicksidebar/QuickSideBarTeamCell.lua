-- QuickSideBarTeamCell.lua
-- Author:lzm
-- Using:侧边栏team cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local QuickSideBarTeamCell = class("QuickSideBarTeamCell", UI.ListGrid)
UI.QuickSideBarTeamCell = QuickSideBarTeamCell

require "app.ui.heroHandLayer.HeroPanel"

local COM_WIDTH = 270
local COM_HEIGHT = 100

--构造函数(必备)
function QuickSideBarTeamCell:ctor()
    QuickSideBarTeamCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function QuickSideBarTeamCell:dtor()
    QuickSideBarTeamCell.super.dtor(self)
end

-- 初始化(必备)
function QuickSideBarTeamCell:init(data,buffLayerParent)
    self._data = data
    self._buffLayerParent = buffLayerParent
    QuickSideBarTeamCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function QuickSideBarTeamCell:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local cellBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_tast_btn_0.png")
    cellBG:setContentSize(206, 80)
    cellBG:setCapInsets(CCRectMake(106,63,1,1))
    cellBG:setPosition(110, 44)
    self.cellLayout:addChild(cellBG)

    local heroHead = UI.HeroPanel:create(UIType.TEAMMATESTATUS)
    heroHead:setBuffParent(self._buffLayerParent)
    heroHead:init(self._data)
    heroHead:leftUp(7, -10)
    -- heroHead:enableDebugDraw()
    heroHead:registerRoleHandler(self, self.onClickHeadCallBack, heroHead)
    self.heroHand = heroHead

    local _data = RoleDataManager:getHeroDataForPK(self._data.pk)
    if _data then
        heroHead:refreshView(_data)
    else
        heroHead:setTeamUI()
    end
    self.cellLayout:addChild(heroHead, 1)

    self.cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    self:setSize(COM_WIDTH, COM_HEIGHT)
end

function QuickSideBarTeamCell:onClickHeadCallBack(component)
    if component then 
        -- 获取英雄的唯一标示
        local pk = component:getPK()
        local spriteID = RoleDataManager:getHeroDataForPK(pk).spriteID
        Avalon.MessageCenter:notice(GameMessage.MC_HAND_CLICK, spriteID)
    end
end

function QuickSideBarTeamCell:getData()
    return self._data
end

-- 下面是一些HeroPanel的桥接函数
function QuickSideBarTeamCell:getPK()
    return self.heroHand:getPK()
end

function QuickSideBarTeamCell:ChoseRole()
    self.heroHand:ChoseRole()
end

function QuickSideBarTeamCell:canelChoseRole()
    self.heroHand:canelChoseRole()
end

function QuickSideBarTeamCell:hideMonsterTarget()
    self.heroHand:hideMonsterTarget()
end

function QuickSideBarTeamCell:showMonsterTarget()
    self.heroHand:showMonsterTarget()
end

function QuickSideBarTeamCell:refreshRescure(count)
    self.heroHand:refreshRescure(count)
end

function QuickSideBarTeamCell:updateState(roleData)
    self.heroHand:updateState(roleData)
end

function QuickSideBarTeamCell:addBuffView(data)
    self.heroHand:addBuffView(data)
end

function QuickSideBarTeamCell:removeBuffView(data)
    self.heroHand:removeBuffView(data)
end

function QuickSideBarTeamCell:updateBuffView(data)
    self.heroHand:updateBuffView(data)
end

function QuickSideBarTeamCell:updateOnLineState(onLine)
    self.heroHand:updateOnLineState(onLine)
end

function QuickSideBarTeamCell:updateEquipIcon()
    self.heroHand:updateEquipIcon()
end

function QuickSideBarTeamCell:showResurgence()
    self.heroHand:showResurgence()
end

function QuickSideBarTeamCell:onResurgenceCallBack()
    self.heroHand:onResurgenceCallBack()
end

function QuickSideBarTeamCell:refreshRoleInfoShowType()
    self.heroHand:refreshRoleInfoShowType()
end

function QuickSideBarTeamCell:refreshResurgence()
    self.heroHand:refreshResurgence()
end

function QuickSideBarTeamCell:showQuickChatTips(text)
    self.heroHand:showQuickChatTips(text)
end

function QuickSideBarTeamCell:refreshView(data)
    self.heroHand:refreshView(data)
end

function QuickSideBarTeamCell:onUpdateView()

end
