--战斗界面怪物信息layer
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}
local MonsterPanelCell = class("MonsterPanelCell",UI.HWBtnComponent)
UI.MonsterPanelCell  = MonsterPanelCell

local Scheduler = Avalon.Scheduler
local size = cc.Director:getInstance():getWinSize()

--怪物血条血量怪物血量
local font =  "Arial"
local SHOW_BUFFER_NUM = 10

local BUFF_ICON_WIDTH  = 24
local BUFF_BACK_WIDTH  = 720 + 60
local BUFF_ICON_SPACING = 5
local BUFF_BACK_HEIGHT = 590 

-- 弹出详情页面的时间间隔
local TIME_SPACED = 0.2

local ZORDER_MONSTER_PANEL_NAME = 2

-- 测试开关
local DEBUG = false

local MONSTER_PANEL_INIT_INFO = {
  X = 0,
  Y = 0,
  WIDTH = 450,
  HEIGHT = 50--size.height
}

local MONSTER_PANEL_RES_LIST = {
    "ui_common_icon_effect.plist",
    "ui_town_guild_giftbox.plist",
    "ui_town_reincarnation.plist"
}

local BATTLE_CHANT_2 = "ui_gaming_battle_chant_2.png"
local BATTLE_CHANT_3 = "ui_gaming_battle_chant_3.png"

local MONSTER_PANEL_SPRITE_FRAME_MAP = {
    WEEKPOINT_VALUE = "symbol_monsterattribute_%s_0.png",
    M_ATK = "symbol_gaming_atk.png",
    M_DEF = "symbol_gaming_def.png",
    M_MDEF = "symbol_gaming_maggicdef.png",
    M_ASPD = "symbol_gaming_aspd.png",
    M_ATT_ATK =  "symbol_monsterattribute_%s_1.png",
    M_ATT_DEF =  "symbol_monsterattribute_%s_2.png",

    ESCAPE_SP_1 = "ui_gaming_battle_escape_1.png",
    ESCAPE_SP_3 = "ui_gaming_battle_escape_3.png",

    BLOOD_BAR_NEW_10 = "ui_battle_monsterhp_10.png",
    BLOOD_BAR_NEW_11 = "ui_battle_monsterhp_11.png",
    BLOOD_BAR_NEW_12 = "ui_battle_monsterhp_12.png",
    BLOOD_BAR_TITLE_ELITE = "ui_battle_monsterhp_00.png",

    MONSTER_INFO_BACK = "ui_banner_gaming_battle_monsterinfo_back.png",

    ICON_EFFECT_TEST_0 = "effect_buff_0.png",
}

-- 构造函数
function MonsterPanelCell:ctor(isGroup)
    
    MonsterPanelCell.super.ctor(self, UIType.MONSTER_PANEL, MONSTER_PANEL_RES_LIST, MONSTER_PANEL_INIT_INFO.WIDTH, MONSTER_PANEL_INIT_INFO.HEIGHT, true)

    self._data = nil
    -- 角色的名字
    self._roleName = nil 
    -- 角色血量
    self._monsterhp      = nil
    self._monsterhp_1    = nil
    self._monsterhp_0    = nil  -- 精英怪
    self._monsterhpNum   = nil 
    -- 头像
    self._avatarSp = nil 
    self._lastScale = 1 
    self._attactLayer = nil 
    self._propertyLayer = nil 
    self._bufftable = {} 
    self._debufftable = {}
    self._buffLayer = nil 
    self._monstername = nil
    self._weaknessSp = nil 
    self._isTouchLongTime = false
    self._buffInfoLayer = nil
    self._buffInfoBg = nil 

    self.isGroup = isGroup or false

    self.lastSwitchTime = 0
    self.targetID = nil
    
    
    -- 怪物信息更新
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA,self,self.onUpdateRoleDataHandler)
    -- 添加buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.addBuffView)
    -- 更新buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.updateBuffView)
    -- 移除buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.removeBuffView)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME, self, self.setLastSwitchTime)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_TARGET, self, self.onSwitchBattleUpdate)
end


    -- 初始化
function MonsterPanelCell:init(data)
    -- print ("====MonsterPanelCell:init====")
    self._data = data
    self.targetID = data.targetID
    self._attactLayer = cc.Layer:create()
    self._attactLayer:setCascadeOpacityEnabled(true)
    self._propertyLayer = cc.Layer:create()
    self._propertyLayer:setCascadeOpacityEnabled(true)
    MonsterPanelCell.super.init(self,data)  
    -- self:addTouchEvents()
    -- self:enableDebugDraw()
end

--析构函数
function MonsterPanelCell:dtor()
    -- print("MonsterPanelCell dtor:")
    -- reload_script_file("app.ui.battlelayer.MonsterPanelCell")
    self._chantTimer = nil 
    self._guideTimer = nil 
    self._data = nil
    self._escapeItem = nil

    self.lastSwitchTime = 0
    self.targetID = nil

    MonsterPanelCell.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 怪物信息更新
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA,self,self.onUpdateRoleDataHandler)

    -- 添加buff操作，添加更新移除
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.addBuffView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.updateBuffView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.removeBuffView)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME, self, self.setLastSwitchTime)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_TARGET, self, self.onSwitchBattleUpdate)

    reload_script_file("app.ui.battlelayer.MonsterPanelCell")
end

function MonsterPanelCell:onUpdateHeroDataHandler(heroData)
    if(heroData and heroData:getType() == RoleType.Hero and self._escapeItem) then
        if(heroData:isMasterHero()) then
            if(heroData:getIsDead()) then
                self._escapeItem:setEnabled(false)
            else
                self._escapeItem:setEnabled(true)
            end
        end
    end
end

-- 初始化视图
function MonsterPanelCell:onInitView()
    -- 任务快捷栏的检查
    if mvc.quickSideBarModel:checkHasTeam() then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_FOCUS_ON_TEAM_TAB)
    end

    self.fullEnergy = nil

    -- print("MonsterPanelCell:initView")
    -- -- 怪物名字 测试完成后打开
    -- local roteName  = self._data and self._data:getName() or "*未知*"
    -- local monstername = UI.Text:create()
    -- monstername:init(roteName, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    -- monstername:centerUp(34- monstername:getContentSize().height/2)
    -- self._monstername = monstername
    -- self:addChild(monstername,ZORDER_MONSTER_PANEL_NAME)

    -- 怪物背景
    -- local info_back  = cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.MONSTER_INFO_BACK)
    -- local px =  self:getContentSize().width / 2 
    -- local py =  self:getContentSize().height  - 81
    -- info_back:setPosition(cc.p(px,py))
    -- self:addChild(info_back)
    local offsetX = self.isGroup and 12 or 0
    -- 怪物血条背景
    self._monsterhp = cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.BLOOD_BAR_NEW_12)
    local px =  self:getContentSize().width / 2  -  self._monsterhp:getContentSize().width/2 + offsetX
    local py =  self:getContentSize().height - 53 - self._monsterhp:getContentSize().height/2
    -- print("_monsterhp ", px, py)
    self._monsterhp:setAnchorPoint(cc.p(0,0.5))
    self._monsterhp:setPosition(cc.p(px,py))
    self:addChild( self._monsterhp)

    -- 判断是否是精英怪
    -- 精英的血条外框
    self._monsterhp_0 = cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.BLOOD_BAR_TITLE_ELITE)
    local px =  self:getContentSize().width / 2 + offsetX
    local py =  self._monsterhp:getPositionY()
    self._monsterhp_0:setPosition(cc.p(px,py))
    self._monsterhp_0:setVisible(true)
    self:addChild( self._monsterhp_0)
    
    -- 真实血条 
    self._monsterhp_1 =  UI.ProgressTimer:create()
    self._monsterhp_1:init(nil, MONSTER_PANEL_SPRITE_FRAME_MAP.BLOOD_BAR_NEW_10, MONSTER_PANEL_SPRITE_FRAME_MAP.BLOOD_BAR_NEW_11)
    local px =  self._monsterhp:getPositionX()
    local py =  self._monsterhp:getPositionY()
    self._monsterhp_1:leftBottom(px,py - self._monsterhp:getContentSize().height/2)
    self:addChild( self._monsterhp_1)

    -- 宝箱表现
    local boxImage = UI.Image:create()
    boxImage:init("ui_guild_giftbag_icon_6.png")
    boxImage:setScale(0.6)
    boxImage:centerLeft(5- boxImage:getContentSize().width/2 * boxImage:getScale())
    self._monsterhp_1:addChild(boxImage, 100)
    self.boxImage = boxImage
    boxImage:setScale(0.6)
    boxImage:setVisible(false)

    -- 公会副本血条阶段
    local hpLayerText = UI.Text:create()
    hpLayerText:init("X 1", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_WHITE)
    -- hpLayerText:useDefaultOutLineShadowStyle()
    hpLayerText:setTextCenter()
    hpLayerText:centerRight(20)
    self._monsterhp_1:addChild(hpLayerText, 100)
    self.hpLayerText = hpLayerText
    hpLayerText:setVisible(false)


    -- 怪物血条血量
    self._monsterhpNum = UI.Text:create()
    self._monsterhpNum:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_220_220)
    self._monsterhpNum:useDefaultOutLineShadowStyle()
    self._monsterhpNum:setSize(300, 30)
    self._monsterhpNum:setTextCenter()
    self:addChild(self._monsterhpNum)
    self._monsterhpNum:leftBottom(self:getContentSize().width / 2 - self._monsterhpNum:getContentSize().width/2, py - self._monsterhpNum:getContentSize().height/2)

    -- 怪物buff词缀
    self._buffAffix = UI.Text:create()
    self._buffAffix:init("", UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_187_36_45)
    self._buffAffix:setSize(300, 20)
    local left = 75 
    local py = self._monsterhp:getPositionY() - self._monsterhp:getContentSize().height - 10 - 7.5
    self._buffAffix:leftBottom(left,py)
    self._buffAffix:setText("")
    self:addChild(self._buffAffix)
    
    -- 弱点文字
    self._weak = UI.Text:create()
    self._weak:init(UI.TEXT_DES_WEAK, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_36_45)
    local left =  self._monsterhp_1:getLeft() + self._monsterhp_1:getContentSize().width - self._weak:getContentSize().width - 40
    self._weak:leftBottom(left, py)
    self:addChild(self._weak)

    self._buffLayer  = cc.Layer:create()
    local px = self:getContentSize().width / 2 - self._monsterhp:getContentSize().width/2 + 100
    local py = self._monsterhp:getPositionY() - 26
    self._buffLayer:setPosition(cc.p(px,py))
    self:addChild(self._buffLayer)

    -- 弹出页面
    self._buffInfoLayer = UI.Layout:create()
    self._buffInfoLayer:init()
    self:addChild(self._buffInfoLayer, 100)
    self._buffInfoLayer:centerUp(50)
    self._buffInfoLayer:setVisible(false)

    self._buffInfoBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    self._buffInfoBg:setCapInsets(CCRectMake(12,12,2,2))
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))
    self._buffInfoBg:setAnchorPoint(cc.p(0.5, 0.5))
    self._buffInfoBg:setPosition(cc.p(0, 0))
    self._buffInfoLayer:addChild(self._buffInfoBg)

    self:addTouchEvents()

    -- 更新血条
    self:updateHpTitle()

    local heroData = GameDataManager:getInstance():getMaster()
    if heroData and heroData.residualEscapeTime and heroData.residualEscapeTime ~= 0 then 
        self:onEscapeClick(escapeItem, true)
    end

    -- 恢复buffer 表现
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(self._data.spriteID)
    if bufferDataList then
        for k,v in pairs(bufferDataList) do
            local _buff = {}
            _buff.bufferData = v
            _buff.bufferEntityID = v:getEntityID()
            _buff.bufferTargetID = v:getTargetSpriteID()
            self:addBuffView(_buff)
        end
    end

    self:onHorcurxEnergeUpdate()
end

function MonsterPanelCell:addHead()
    local headSwitchLayout = UI.Layout:create()
    headSwitchLayout:init()
    headSwitchLayout:setSize(52, 54)
    headSwitchLayout:centerLeft(25, 20)
    self:addChild(headSwitchLayout)
    -- headSwitchLayout:enableDebugDraw()

    local monsterHeadBg = UI.Image:create()
    monsterHeadBg:init("ui_reincarnation_headbox.png")
    monsterHeadBg:centerLeft(25, 20)
    self:addChild(monsterHeadBg, 99)

    local head = self._data:getIcon()..".png"
    local monsterHead = UI.Image:create()
    monsterHead:init(head)
    monsterHead:centerLeft(20, 20)
    self:addChild(monsterHead)
    monsterHead:setScale(0.8)

    local battleSign = UI.Image:create()
    battleSign:init("ui_reincarnation_fight_fightting.png")
    battleSign:leftUp(-5, -5)
    battleSign:setName("battleSign")
    monsterHeadBg:addChild(battleSign, 99)
    self.battleSign = battleSign

    headSwitchLayout:setTouchEnable(true)
    headSwitchLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self)
        self:onSwitch(self._data)
    end)
    self:updateBattleSign()
end

function MonsterPanelCell:onSwitch(data)
    local spriteID = data:getSpriteID()

    if self.targetID == spriteID then
        UI.ScrollBar:createByText(UI.TEXT_223812)
        return
    end

    if data:getIsDead() then
        -- UI.ScrollBar:createByText(UI.TEXT_223812)
        return
    end

    local str = ConfigManager:getGeneralForKey("switchAttackInterval")
    local switchAttackInterval = tonumber(str) / 1000
    local nowTime = GameManager:getNormalServerTime()
    if self.lastSwitchTime > 0 then
        local nowTime = GameManager:getNormalServerTime()
        local remainTime = nowTime - self.lastSwitchTime 
        if remainTime <= switchAttackInterval then
            local tips = string.format(UI.TEXT_223813, switchAttackInterval)
            UI.ScrollBar:createByText(tips)
            return
        end
    end

    Net.NetRoleSystem:reqRoleSwitchBattleTartMessage(spriteID)
end

function MonsterPanelCell:updateBattleSign()
    if self.battleSign then
        self.battleSign:setVisible(self.targetID == self._data.spriteID)
    end
end

function MonsterPanelCell:setLastSwitchTime(time)
    self.lastSwitchTime = time
end

function MonsterPanelCell:setTargetID(targetID)
    self.targetID = targetID
end

function MonsterPanelCell:onSwitchBattleUpdate(targetID)
    self:setTargetID(targetID)

    self:updateBattleSign()
end

function MonsterPanelCell:onHorcurxEnergeUpdate(data)

    -- if isEnergeFull then
    --     if self.horcurxBtn then
    --         self.horcurxBtn:removeFromParent()
    --         self.horcurxBtn = nil
    --     end
    -- else
    --     local horcurxBtn = UI.Button:create()
    --     horcurxBtn:init("ui_btn_gray4_0.png", "ui_btn_gray4_1.png", "ui_btn_gray4_3.png")
    --     horcurxBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
    --         -- self:showContentPanelByIndex(tab:getTag())
            
    --     end)
    --     horcurxBtn:center()
    --     self.horcurxBtn = horcurxBtn
    --     self:addChild(self.horcurxBtn)
    -- end
end


local pngs ={"ui_gaming_monste_energy_00.png", "ui_gaming_monste_energy_10.png", "ui_gaming_monste_energy_max_2.png"}
--怪物能量条
function MonsterPanelCell:updateMonsterEnergyView()
    local percent = (self._data.energy or 0)/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE

    if percent <= 0 then
        if self.energyNode then
            self.energyNode:removeFromParent()
            self.energyNode = nil
            self.fullEnergy = nil
        end
        return
    end

    if not self.energyNode then
            -- 怪物血条背景
        self.energyNode = cc.Sprite:createWithSpriteFrameName(pngs[1])
        local px =  self:getContentSize().width / 2  - 12 
        local py =  self:getContentSize().height - 83 - self.energyNode:getContentSize().height/2
        self.energyNode:setAnchorPoint(cc.p(1,0.5))
        self.energyNode:setPosition(cc.p(px,py))
        self:addChild(self.energyNode,1)

        local width = self.energyNode:getContentSize().width
        local height = self.energyNode:getContentSize().height

        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(pngs[2]))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)  
        progress:setMidpoint(cc.p(0,0))  
        progress:setBarChangeRate(cc.p(1, 0))  
        progress:setPosition(cc.p(width/2, height / 2))  
        self.energyNode:addChild(progress)  
        self.energyProgress = progress
    end
    self.energyProgress:setPercentage(percent*100)
    if percent >= 1 then
        if not self.fullEnergy then
            self.fullEnergy = UI.Image:create()
            self.fullEnergy:init(pngs[3])
            self.fullEnergy:center()
            self.energyNode:addChild(self.fullEnergy,3)
        end
    else
        if self.fullEnergy then
            self.fullEnergy:removeFromParent()
            self.fullEnergy = nil
        end
    end
end

-- 更新视图:
function MonsterPanelCell:onUpdateView(data)
    -- print("MonsterPanelCell:updateView")
    if (data) then 
        self._data = data
    end
    data = self._data

    if data then 
        local hpNum = data and data.curHp or 0
        if hpNum < 0 then
            hpNum = 0
        end 

        local hpMax = data and data.hp or 1

        -- 判断是否为公会副本模式
        local guildBoss = SceneManager:getInstance():isGuildBoss() 
        if(guildBoss) then 
            local curHp = hpNum
            local maxHp = hpMax
            local guildBossPool = ConfigManager:getGuildBossPoolByID(data:getId())

            local multiHP = {1500,2388}
            if(guildBossPool) then 
                multiHP = guildBossPool.multiHP
            end

            self.boxImage:setVisible(true)
            self.hpLayerText:setVisible(true)
            local mulHpArr,index, indexHp = ToolsUtil:calculationMulHp(curHp, maxHp, multiHP)
            -- print("progressBg, progress, reward  1=", index, indexHp)
            local progressBg, progress, reward , progressPercent = self:_getHPSpriteName(index, mulHpArr)
            -- print("progressBg, progress, reward, progressPercent=", progressBg, progress, reward, progressPercent)
            if(self.preSpriteName ~= reward) then
                print("self.preSpriteName=", self.preSpriteName, reward)
                self.preSpriteName = reward
                self.boxImage:setSpriteName(reward)
                self.boxImage:stopAllActions()
                self.boxImage:setScale(0.9)
                self.boxImage:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 0.3), cc.ScaleTo:create(0.5, 0.6)))
            end 
            
            self._monsterhp_1:setSpriteName(progressBg, progress, progressPercent)
            -- self.progressText:setText(string.format("%d/%d", indexHp, mulHpArr[index]))
            hpNum = indexHp
            hpMax = mulHpArr[index]
            if(curHp == 0) then
                self.hpLayerText:setText("X ".."0")
            else
                self.hpLayerText:setText("X "..(#mulHpArr-index + 1))
            end
            
            -- local oldPercent = self.progressTimer:getPercent()
            -- local nowPercent = indexHp/ mulHpArr[index]
            -- self.progressTimer:setBarChange(oldPercent, nowPercent, 1000)
            -- self.progressTimer:setBarChangeAction(oldPercent, nowPercent, 1000)
        else 
            self.boxImage:setVisible(false)
            self.hpLayerText:setVisible(false)
        end
        
        local hpNumStr = ""
        -- 英雄血量显示方式
        local _showType = Game.Manager:getRoleInfoShowType() 
        if _showType == ShowType.PERCENT then
            local  HP  = math.floor(hpNum/hpMax*100)

            if HP == 0 and hpNum ~= 0 then
                HP = 1
            end
            hpNumStr = HP.."%"
        elseif _showType == ShowType.VALUE then
            hpNumStr = hpNum.."/"..hpMax
        end

        self._monsterhpNum:setText(hpNumStr)

        -- 怪物血条
        local scale = hpNum/hpMax

        -- 设置真实的血量
        -- if(self._lastScale < scale) then 
        --     self._lastScale = 1
        -- end

        self._monsterhp_1:setBarChange(self._lastScale, scale, 0)
        self._monsterhp_1:setBarChangeAction(self._lastScale, scale, 600)

        -- 记录本次的血量
        self._lastScale = scale
    end

    -- 通过MonsterData:getAllAffixArr()  获取词缀（MonsterAffixData）列表  ,在通过  MonsterAffixData:getAffixName() 获取词缀名
    local arr = data:getAllAffixArr()
    local text = ""
    for i = 1, #arr do
        -- arr[i]:getAffixName()
        print("==",arr[i]:getAffixName())
        if i <= 4 then 
            text = string.format("%s %s", text, arr[i]:getAffixName())
        end
    end
    self._buffAffix:setText(text)

    local weakness = data and data.weaknessType or 0
    if weakness == 1 then
        weakness = "fire"
    elseif weakness == 2 then
        weakness = "water"
    elseif weakness == 3  then
        weakness = "wood"
    elseif weakness == 0 then
        weakness = ""
    elseif weakness == 4 then
        weakness = "light"
    elseif weakness == 5 then
        weakness = "dark"
    end

    if self._weaknessSp then
        self._weaknessSp:removeFromParent()
        self._weaknessSp = nil
    end

    if weakness ~= "" then
        local fileName = string.format(MONSTER_PANEL_SPRITE_FRAME_MAP.WEEKPOINT_VALUE,weakness)
        self._weaknessSp = UI.Image:create()
        self._weaknessSp:init(fileName)
    else
        self._weaknessSp = UI.Text:create()
        self._weaknessSp:init("--", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    end
    self._weaknessSp:centerLeft(self._weak:getContentSize().width + 4)
    self._weak:addChild(self._weaknessSp)
    -- 更新血条
    self:updateHpTitle()


    self:updateMonsterEnergyView()
end

function MonsterPanelCell:updateHpTitle()
    if(self._data and self._monsterhp_0) then
        if self._data:getMonsterRare() == 1  then
            --判断是否是精英怪
            self._monsterhp_0:show()
        else
            self._monsterhp_0:hide()
        end
    end
end

-- 监听触摸事件
function MonsterPanelCell:addTouchEvents()
    local function onTouchBegan(touch, event)  
        -- return true
        if #self._bufftable > 0 or #self._debufftable > 0 then 
            -- print("===MonsterPanelCell==触摸到")
            local posStarTouch = touch:getLocation()
            local point  = self._monsterhp:convertToWorldSpace(self._monsterhp:getAnchorPointInPoints())
            local width  = self._monsterhp:getContentSize().width
            local height = self._monsterhp:getContentSize().height

            local nums = 0;
            if #self._bufftable >0  then
                nums = nums + 1
            end
            if #self._debufftable >0  then
                nums = nums + 1
                nums = nums < 2 and 2 or nums
            end
            local rectWidth = math.max(BUFF_ICON_WIDTH* 6  + 5, 100)
            local rectHeight =  math.max(BUFF_ICON_WIDTH* nums + 60, 60)

            -- buff信息页监听触发区域
            local rect = cc.rect(point.x+100 , point.y - 75 , rectWidth, rectHeight) 

            if cc.rectContainsPoint(rect, posStarTouch) then  
                
                Scheduler:scheduleUpdateOnce(self, MonsterPanelCell.onTouchLongTimeBeganHandler, TIME_SPACED, posStarTouch)
                return true
            end
        end
    end

    local function onTouchEnded(touch, event)
        -- print("=====触摸到")
        local posTouch = touch:getLocation()

        if (self._isTouchLongTime) then
            self:onTouchLongTimeEndedHandler(posTouch)
        else
            Scheduler:unscheduleUpdateOnce(self, MonsterPanelCell.onTouchLongTimeBeganHandler)
        end

        if self._buffInfoLayer then
            self._buffInfoLayer:setVisible(false)
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
    listener:setSwallowTouches(true)
end

-- 长按的处理
function MonsterPanelCell:onTouchLongTimeBeganHandler()

    self._isTouchLongTime = true
    -- print("====弹出页面===")
    if self and self._buffInfoLayer  then
        self:showBuffInfo()
    end
end

-- 不符合长按
function MonsterPanelCell:onTouchLongTimeEndedHandler()
    self._isTouchLongTime = false
end

-- 弹出buff详情页面
function MonsterPanelCell:showBuffInfo()
  
    self._buffInfoLayer:setVisible(true)
    self._buffInfoBg:setVisible(true)
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))
    local px =  BUFF_ICON_WIDTH + BUFF_ICON_SPACING
    local totalHeight = 0
    for id, buff in pairs (self._bufftable) do
         if buff.sprite2 ~= nil  then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)
            totalHeight = totalHeight + height + 10
        end   
    end
    for id, buff in pairs (self._debufftable) do
        if buff.sprite2 ~= nil  then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)
            totalHeight = totalHeight + height + 10
        end   
    end
    local py = totalHeight - 5
    for id, buff in pairs (self._bufftable) do
         if buff.sprite2 ~= nil  then
            local maxHeight = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            maxHeight = math.max(maxHeight, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)
            -- local  px =  - BUFF_BACK_WIDTH/2 + BUFF_ICON_WIDTH + BUFF_ICON_SPACING
            buff.sprite2:setPosition(cc.p(px, py - maxHeight/2))
            buff.name:setPosition(cc.p(px + BUFF_ICON_WIDTH/2 + 10 + buff.name:getContentSize().width/2 , buff.sprite2:getPositionY() ))
            -- print("_bufftable  width=",buff.name:getPositionX(), buff.name:getContentSize().width)
            buff.describe:setPosition(cc.p(buff.name:getPositionX() + buff.name:getContentSize().width/2 + 10 + 100,
                buff.sprite2:getPositionY()))
            py = py - maxHeight - 10
        end   
    end

    for id, buff in pairs (self._debufftable) do
        if buff.sprite2 ~= nil  then
            local maxHeight = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            maxHeight = math.max(maxHeight, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)
            buff.sprite2:setPosition(cc.p(px, py- maxHeight/2))
            buff.name:setPosition(cc.p(px + BUFF_ICON_WIDTH/2 + 10 + buff.name:getContentSize().width/2 , buff.sprite2:getPositionY() ))
            -- print("_debufftable  width=",buff.name:getPositionX(), buff.name:getContentSize().width)
            buff.describe:setPosition(cc.p(buff.name:getPositionX() + buff.name:getContentSize().width/2 + 10 + 100,
                buff.sprite2:getPositionY()))
            py = py - maxHeight - 10
        end   
    end
    totalHeight = totalHeight
    self._buffInfoLayer:setSize(BUFF_BACK_WIDTH, totalHeight + 10)
    -- self._buffInfoLayer:setPositionY(self:getContentSize().height - self._buffInfoLayer:getContentSize().height - 80)
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH / 2, totalHeight))
    self._buffInfoBg:setPosition(cc.p(BUFF_BACK_WIDTH/2, totalHeight/2))
end

function MonsterPanelCell:addBuffEffect(sp)
    if sp then
        local animation = sp:getChildByName("buff_spine")
        if(animation) then
            animation:runAction(cc.RemoveSelf:create())
        end

        local action = UI.Animation:create()
        action:init("effect_ui_gaming_buff_icon.json", "effect_ui_gaming_buff_icon.atlas", 1, true)
        action:setScale(1)            
        action:setAnimation("triggle", false)

        action:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function() 
            action:runAction(cc.RemoveSelf:create())
        end) 

        action:setName("buff_spine")
        action:leftUp(sp:getContentSize().width/2,sp:getContentSize().height/2)
        sp:addChild(action, 10)
        sp:setScale(0.24)

        local repeate = cc.Sequence:create(cc.ScaleTo:create(0.16, 1.7), cc.DelayTime:create(0.066), cc.ScaleTo:create(0.42, 1.0))  
        sp:runAction(repeate)
    end 
end

-- 添加buff
function MonsterPanelCell:addBuffView(data)
    if tolua.isnull(self._buffInfoBg) then
        return
    end
    if data and data.bufferTargetID == self._data.spriteID then
        local buffer = data.bufferData

        -- 判断是否重复添加
        if buffer:isGood() then  
            for k,buffData in ipairs(self._bufftable) do 
                if(buffData.ID == data.bufferEntityID) then
                    return
                end
            end
        else
            for k,buffData in ipairs(self._debufftable) do 
                if(buffData.ID == data.bufferEntityID) then
                    return
                end
            end
        end
        
        if  buffer:getICON()  then

            local  sp   = cc.Sprite:createWithSpriteFrameName(buffer:getICON())
            local  sp2  = cc.Sprite:createWithSpriteFrameName(buffer:getICON())

            local  buffTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.ICON_EFFECT_TEST_0))
            buffTimer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
            buffTimer:setPercentage(0)

            local  buffTimer2 = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(MONSTER_PANEL_SPRITE_FRAME_MAP.ICON_EFFECT_TEST_0))
            buffTimer2:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
            buffTimer2:setPercentage(0)

            -- 持续时间
            -- print("持续时间", buffer:getDuration())

            local action = cc.ProgressTo:create(buffer:getDuration(), 100) 
            local action2 = cc.ProgressTo:create(buffer:getDuration(), 100) 

            buffTimer:runAction(action)
            buffTimer2:runAction(action2)

            buffTimer:setPosition(cc.p(sp:getContentSize().width/2,sp:getContentSize().height/2))
            buffTimer2:setPosition(cc.p(sp2:getContentSize().width/2,sp2:getContentSize().height/2))

            sp:addChild(buffTimer)
            sp2:addChild(buffTimer2)

            -- buffer 名称
            local buffName = cc.Label:createWithTTF("中毒", UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
            self._buffInfoBg:addChild(buffName) 
            buffName:setWidth(80)
            -- print("====buff名称",buffer:getName())
            buffName:setString(buffer:getName())
            -- 描述文字
            local buffDescribe = cc.Label:createWithTTF("持续时间3S，每秒掉血2%",UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
            buffDescribe:setWidth(200)
            self._buffInfoBg:addChild(buffDescribe) 
            buffDescribe:setString(buffer.description)

            local datatable  = {
                sprite = sp,
                sprite2 = sp2,
                ID  = data.bufferEntityID,
                Timer = buffTimer,
                Timer2 = buffTimer2,
                name = buffName,
                describe = buffDescribe,
            }

            -- print("=====添加",data.bufferEntityID,"==",AvalonUtil:getCurrentTime())
            if buffer:isGood() then
                table.insert(self._bufftable,datatable)
            else
                table.insert(self._debufftable,datatable)
            end

            if(buffer:getIsAddNew()) then
                buffer:setAddNew(false)
                self:addBuffEffect(sp)
            end

            self._buffLayer:addChild(sp) 
            self._buffInfoBg:addChild(sp2)

            sp:setVisible(false)
            -- sp2:setVisible(false)
            self:showBuffView()

            -- deal with Pause Or Resume
            if self.isPause then
                self:_hanelTimePauseOrResume(buffTimer, datatable.data, self.isPause)
                self:_hanelTimePauseOrResume(buffTimer2, datatable.data, self.isPause)
            end
        end

        if buffer.buffEffectType == 626 then --如果是沙之眼的沙漏
            self:showDesertEyeBossProgress(buffer, true)
        end
    end
end

function MonsterPanelCell:scheduleDesertEyesBossProgressCd()
    if tolua.isnull(self) 
        or (not self.desertEyesBossBuffCdText) 
        or tolua.isnull(self.desertEyesBossBuffCdText) 
    then
        return
    end

    if (not self.desertEyesBossBuffCdText.cd)
        or  self.desertEyesBossBuffCdText.cd <= 0 
    then
        self.desertEyesBossBuffCdText:removeFromParent()
        return
    end 

    if self.desertEyesBossBuffCdText.cd > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleDesertEyesBossProgressCd, 1)
    end
    self.desertEyesBossBuffCdText:setText(
        string.format(UIUtil:lang(1043480), self.desertEyesBossBuffCdText.cd)
    )
    self.desertEyesBossBuffCdText.cd = self.desertEyesBossBuffCdText.cd - 1
end

function MonsterPanelCell:showDesertEyeBossProgress(buffer, isAdd)
    if not (SceneManager:getInstance():isDesertEyesCave() 
            or SceneManager:getInstance():isDistortedSpaceCave()
            or SceneManager:getInstance():isInInferno()
            or SceneManager:getInstance():isInVoidRift()
            or SceneManager:getInstance():isInViKing()
            or SceneManager:getInstance():isTitanRoad()
            or SceneManager:getInstance():isDriedSpring()
            or SceneManager:getInstance():isChaosWormHole() ) then
        return
    end

    if SceneManager:getInstance():getSceneType() == PublicDefine.SCENE_TYPE.CAVE then
        return
    end

    if(self.desertEyesBossBuffLayer and isAdd == true) then
        self.desertEyesBossBuffLayer:removeFromParent()
        self.desertEyesBossBuffLayer = nil
    end


    if not self.desertEyesBossBuffLayer then
        self.desertEyesBossBuffLayer = UI.Component:create()
        self.desertEyesBossBuffLayer:init()
        self.desertEyesBossBuffLayer:setSize(10,10)
        self.desertEyesBossBuffLayer:centerUp(130)
        self:addChild(self.desertEyesBossBuffLayer)

        local shalou = UI.Animation:create()
        shalou:init("effect_ui_gaming_warning_shalou.json", "effect_ui_gaming_warning_shalou.atlas", 1, true)
        shalou:setAnimation("idle", true)
        if(SceneManager:getInstance():isDistortedSpaceCave()) then 
            shalou:setAnimation("idle2", true)
        end
        shalou:leftBottom(-145, 0)
        self.desertEyesBossBuffLayer:addChild(shalou,199)
        
        local progressBg = UI.Image:create()
        progressBg:init("ui_gaming_warning_00.png")
        progressBg:center(-4,5)
        self.desertEyesBossBuffLayer:addChild(progressBg)

        local percent = buffer:getDuration()
        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_gaming_warning_10.png"))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        progress:setMidpoint(cc.p(0, 0))
        progress:setBarChangeRate(cc.p(1, 0))
        progress:setPercentage(0)
        self.desertEyesBossBuffLayer:addChild(progress)
        local text = UI.Text:create()
        text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_220_211_203)
        text:center(0,5)
        text:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        self.desertEyesBossBuffLayer:addChild(text, 10)
        self.desertEyesBossBuffCdText = text
        self.desertEyesBossBuffCdText.cd = math.floor(percent)
        self:scheduleDesertEyesBossProgressCd()
        self._salouProgress = progress
        self.yujingAniCountDown = 0
    end

    local percent = buffer:getDuration()
    local progress = self._salouProgress
    progress:stopAllActions()

    local oldCd = self.desertEyesBossBuffCdText.cd or 0
    self.desertEyesBossBuffCdText.cd = math.floor(percent)
    if oldCd <=0 and self.desertEyesBossBuffCdText.cd > 0 then
        self:scheduleDesertEyesBossProgressCd()
    end

    local action = cc.ProgressTo:create(percent, 100) 
    progress:runAction(
        cc.Sequence:create(
            action, 
            cc.CallFunc:create(
                function() 
                    if(self.desertEyesBossBuffLayer) then
                        local yujing = UI.Animation:create()
                        yujing:init("effect_ui_gaming_warning_yujing.json", "effect_ui_gaming_warning_yujing.atlas", 1, true)
                        yujing:setAnimation("idle", true)
                        yujing:center(-4,6)
                        self.desertEyesBossBuffLayer:addChild(yujing)
                        yujing:addEventListener(UIEvent.ANIMATION_COMPLETE, self, 
                            function() 
                                if self.yujingAniCountDown > 5 then
                                    yujing:runAction(
                                        cc.CallFunc:create(
                                            function()
                                                self.desertEyesBossBuffLayer:removeFromParent()
                                                self.desertEyesBossBuffLayer = nil
                                            end
                                        )
                                    )
                                end
                                self.yujingAniCountDown = self.yujingAniCountDown + 1
                            end
                        ) 
                    end
                end
            )
        )
    )
end

-- 更新buffer
function MonsterPanelCell:updateBuffView(data)
    -- print("====MonsterPanelCell:updateBuffView====")
    local buffer = data.bufferData
    if data and data.bufferTargetID == self._data.spriteID then
        if buffer:isGood() then
            for id, buff in pairs (self._bufftable) do
                if buff.ID == data.bufferEntityID  then
                    -- print("=====bufff id",id)
                    if  buff.Timer then
                        local time = data.leftTime/1000
                        buff.Timer:stopAllActions()
                        buff.Timer:setPercentage(0)
                        local action = cc.ProgressTo:create(time, 100) 
                        buff.Timer:runAction(action)

                        buff.Timer2:stopAllActions()
                        buff.Timer2:setPercentage(0)
                        local action2 = cc.ProgressTo:create(time, 100) 
                        buff.Timer2:runAction(action2)

                        self:addBuffEffect(buff.sprite)
                    end
                end  
            end
        else
            for id, buff in pairs (self._debufftable) do
                if buff.ID == data.bufferEntityID  then
                    if  buff.Timer then
                        -- 剩余时间
                        local time = data.leftTime/1000
                        buff.Timer:stopAllActions()
                        buff.Timer:setPercentage(0)
                        local action = cc.ProgressTo:create(time, 100) 
                        buff.Timer:runAction(action)

                        buff.Timer2:stopAllActions()
                        buff.Timer2:setPercentage(0)
                        local action2 = cc.ProgressTo:create(time, 100) 
                        buff.Timer2:runAction(action2)

                        self:addBuffEffect(buff.sprite)
                    end
                end
            end
        end

        self:showBuffView()

        if buffer.buffEffectType == 626 then --如果是沙之眼的沙漏
            self:showDesertEyeBossProgress(buffer, false)
        end
    end
end

-- 移除buff
function MonsterPanelCell:removeBuffView(data)
    -- print("====MonsterPanelCell:removeBuffView====")
    local buffer = data.bufferData

    if data and data.bufferTargetID == self._data.spriteID then
        if buffer:isGood() then
            local removeID = nil
            for id, buff in pairs (self._bufftable) do
                if buff.ID == data.bufferEntityID  then
                    buff.sprite:removeFromParent() 
                    buff.sprite2:removeFromParent() 
                    buff.name:removeFromParent()
                    buff.describe:removeFromParent()
                    
                    buff.sprite = nil 
                    buff.sprite2 = nil 
                    buff.ID = nil 
                    buff.Timer = nil 
                    removeID = id 
                    break
                end
            end
            if(removeID) then 
                table.remove(self._bufftable, removeID)
            end
        else
            local removeID = nil
            for id, buff in pairs (self._debufftable) do
                if buff.ID == data.bufferEntityID  then
                    -- print("=====移除",data.bufferEntityID,"==",AvalonUtil:getCurrentTime())
                    buff.sprite:removeFromParent() 
                    buff.sprite2:removeFromParent() 
                    buff.name:removeFromParent()
                    buff.describe:removeFromParent()
                    
                    buff.sprite = nil 
                    buff.sprite2 = nil 
                    buff.ID = nil 
                    buff.Timer = nil 
                    removeID = id 
                    break
                end
            end
            if(removeID) then 
                table.remove(self._debufftable, removeID)
            end
        end

        self:showBuffView()
    end
    
    if buffer.buffEffectType == 626 then --如果是沙之眼的沙漏
        -- if self.desertEyesBossBuffLayer then
        --     self.desertEyesBossBuffLayer:removeFromParent()
        --     self.desertEyesBossBuffLayer = nil
        -- end
    end
end

-- 更新buff的位置
function MonsterPanelCell:showBuffView()
    if tolua.isnull(self._buffInfoLayer) then
        return
    end
    if self._buffInfoLayer:isVisible() then 
        self:showBuffInfo()
    end
   
    local k  = 0
    local row = 0 
    for id, buff in pairs (self._bufftable) do
        -- 控制要显示的buff数量
        if k < SHOW_BUFFER_NUM then 
            if buff.sprite ~= nil  then
                -- print("====", id)
                buff.sprite:setVisible(true)
                buff.sprite:setPosition(cc.p(20 + (buff.sprite:getContentSize().width +2) * k, 0 - buff.sprite:getContentSize().height*row))
                -- 用于计算buff的位置
                k = k + 1

                if k  ==  5 then
                    row = row + 1
                    k   = 0 
                end
            end
        end   
    end

    if k ~= 0 then 
        row = row + 1 
        k = 0 
    end 

    -- local k = 0
    for id, buff in pairs (self._debufftable) do       
        if k < SHOW_BUFFER_NUM then 
            if buff.sprite ~= nil  then
                -- print("====", id)
                buff.sprite:setVisible(true)
                buff.sprite:setPosition(cc.p(20 + (buff.sprite:getContentSize().width + 2) * k , - buff.sprite:getContentSize().height*row))

                k = k + 1
                if k  ==  5 then
                    row = row + 1
                    k   = 0 
                end
            end
        end   
    end
end

--怪物，页面的更新
function MonsterPanelCell:onUpdateRoleDataHandler(roleData)
    -- print("====MonsterPanelCell:onUpdateRoleDataHandler==== roleData updateView", roleData.spriteID)
    -- 怪物
    if self._data.spriteID == roleData.spriteID then
        self:updateView(roleData)
    end
end
 
function MonsterPanelCell:_getHPSpriteName(index, mulHpArr)
    local maxIndex = 4
    local progressBg = nil
    local progress = "ui_battle_monsterhp_12.png"
    local progressPercent = "ui_battle_monsterhp_11.png"
    local reward = "ui_guild_giftbag_icon_6.png"
    local mod = math.fmod(index, maxIndex + 1)
    if(mod == 0) then 
        mod = 1
    end
    print("MonsterPanelCell:_getHPSpriteName", mod, index, #mulHpArr)
    progress = string.format("ui_battle_monsterhp_%d0.png", mod)
    progressPercent = string.format("ui_battle_monsterhp_%d1.png", mod)
    reward =  string.format("ui_guild_giftbag_icon_%d.png", 5+mod)
    if(index == #mulHpArr) then 
        progressBg = "ui_battle_monsterhp_12.png"
    else
        if(mod == maxIndex) then 
            progressBg = string.format("ui_battle_monsterhp_%d0.png", 1)
        else 
            progressBg = string.format("ui_battle_monsterhp_%d0.png", mod + 1)
        end
    end

    return progressBg, progress, reward, progressPercent
end

function MonsterPanelCell:triggerMonsterRefresh(model)
    if(model and model:getRoleData() and model:getRoleData():getSpriteID() == self._data.spriteID) then 
        self.monstername:setText(model:getRoleData():getName())
    end
end

function MonsterPanelCell:scenePauseOrResume(isPause)
    print("---MonsterPanelCell:scenePauseOrResume---", isPause)
    local timerArr = {}
    if(self._monsterhp_1) then 
        table.insert(timerArr, self._monsterhp_1)
    end

    for k,v in ipairs(timerArr) do 
        if(not tolua.isnull(v)) then 
            if(isPause) then
                v:pause()
            else
                v:resume()
            end
        end
    end

    self.isPause = isPause
    if(self._debufftable) then 
        for k, v in pairs(self._debufftable) do 
            self:_hanelTimePauseOrResume(v.Timer, v.data, isPause)
            self:_hanelTimePauseOrResume(v.Timer2, v.data, isPause)
        end
    end

    if(self._bufftable) then 
        for k, v in pairs(self._bufftable) do 
            self:_hanelTimePauseOrResume(v.Timer, v.data, isPause)
            self:_hanelTimePauseOrResume(v.Timer2, v.data, isPause)
        end
    end
end

function MonsterPanelCell:_hanelTimePauseOrResume(timer, data, isPause)
    if(not tolua.isnull(timer)) then 
        if(not tolua.isnull(timer)) then 
            if(isPause) then 
                timer:pause()
            else
                timer:resume()
            end
        end
    end
end