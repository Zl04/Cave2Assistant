--[[
    --HeroPanel.lua
	--Author:杜青辉
	--2016年11月18日 
	--Using: 角色信息的面板  
    --修改记录
    3、英雄主角整个界面排列
    经验条修改
    动画调整
    2017年04月11日 
]] --

require "app.ui.Component"
require "app.ui.heroHandLayer.HeadTips"
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local AngerProgressComponent = require ("app.renderer.component.AngerProgressComponent")
UI = UI or {}
local HeroPanel = class("HeroPanel", UI.HWBtnComponent)
UI.HeroPanel = HeroPanel

local Scheduler = Avalon.Scheduler
local size = cc.Director:getInstance():getWinSize()
-- 组件的大小
local WIDTH = 270
local HEIGHT = 100
-- 排显示的buff数量
local SHOW_BUFFER_NUM = 6
-- 呼出buff详情页面的时间
local TOUCH_TIME = 0.2

-- buff的宽度（正方形）
local BUFF_ICON_WIDTH = 24
-- buff之间的间隔
local BUFF_ICON_SPACING = 5
-- buff背景的宽高
local BUFF_BACK_WIDTH = 920
local BUFF_BACK_HEIGHT = 590

-- 蓝条居上
local MP_POST_Y = 71
-- 英雄（角色）头像居左
local AVARAR_SP_LEFT = 12
-- 队友背景居左
local TEAM_BG_LEFT = 6

-- 英雄等级背景居左
local HERO_GRADE_SP_LEFT = 64
-- 队友等级背景居左
local TEAM_GRADE_SP_LEFT = 50
local TEAM_GRADE_SP_BOTTOM = 5
-- 队长图标的位置
local CAPTAIN_SP_LEFT = -4
local CAPTAIN_SP_UP = 0

-- 层级
local ZORDER_HERO_PANEL_ICON = 1
local ZORDER_HERO_PANEL_NAME = 2
local ZORDER_HERO_PANEL_ANIMATION = 99
local ZORDER_HERO_PANEL_BUFF = 100

-- 测试开关
local DEBUG = false
-- 测试离线
local ROLE_IS_OFFLINE = false

local HERO_PANEL_RES_LIST = {
    "ui_common_icon_effect.plist",
    "ui_gaming_choice.plist",
    "ui_gaming_playerstate.plist",
    "ui_package_pets.plist",
    "ui_package_roleTalent.plist"
}

-- 构造函数
function HeroPanel:ctor(type)
    -- print ("====HeroPanel:ctor====")
    HeroPanel.super.ctor(self, type, HERO_PANEL_RES_LIST, WIDTH, HEIGHT)

    self._avatar_black = nil -- 头像背景
    self._avatar_SP = nil -- 头像
    -- self._avatar_frame = nil   -- 头像上的框

    self._roleName = nil -- 英雄的名字
    self._grade_BG = nil -- 等级的背景
    self._lvLabel = nil -- 英雄等级
    self._occupation = nil -- 所持武器类型
    self._battle = nil -- 战斗图标
    self._off_line = nil -- 离线图标

    self._hpLabel = nil -- 英雄血量
    self._mpLabel = nil -- 英雄蓝量

    -- 进度条，血条，蓝条，经验条
    self._booldTimer = nil
    self._mpTimer = nil
    self._xpTimer = nil

    -- 动画，技能目标，怪物攻击目标，死亡动画
    self._light = nil
    -- self._target   = nil
    self._dead = nil
    --被攻击动画
    self._attacked = nil
    -- 增益buff,减益buff
    self._bufftable = {}
    self._debufftable = {}
    self._normalBuffTabel = {}
    self._normalDebuffTable = {}

    self._buffLayer = nil -- buff页面
    self._buffInfoLayer = nil -- buff详情页面
    self._buffInfoBg = nil -- buff详情页面背景

    -- 是否为长按
    self._isTouchLongTime = false
    self._isFirstUpdate = true --是否首次加载
    self._lastScale = 1 --掉血前血量的比例
    self._data = nil

    self.viewState = 1 --状态:1正常,2灰,3黑

    self._search = nil --搜索特效

    self._dieState = false --死亡状态
    self._waitMateState = false --等待匹配
    self._waitJoinState = false --等待加入

    self._disabel = false
    self.isPause = false

    self._onLineState = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE --加入状态

    self.hpNum = 100
    self.hpMax = 100
    self.mpNum = 100
    self.mpMax = 100

    self._createHeadMark = false
    self._wearEquipmentDataArr = {}
    self._type = type

    self._waitingTime = 0
    Avalon.Scheduler:scheduleUpdate(self, self.update)

end


function HeroPanel:updateTeamGreedySelect()
    if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return
    end
    if self._data._onLineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
        if self.greedySelectLayer  then
            self.greedySelectLayer:removeFromParent()
            self.greedySelectLayer = nil
        end
        return
    end

    local function doLocalShow(isVisible) 
        if self._booldTimer then
            self._booldTimer:setVisible(isVisible)
        end
        
        if self._mpTimer then
            self._mpTimer:setVisible(isVisible)
        end
        if self._xpTimer then
            self._xpTimer:setVisible(isVisible)
        end
    end
    local isSelectingGrade = mvc.greedySelectModel:checkIsGreedySelecting()
    doLocalShow( not isSelectingGrade)

    if self.greedySelectLayer  then
        self.greedySelectLayer:removeFromParent()
        self.greedySelectLayer = nil
    end
    
    if isSelectingGrade then
        local com = UI.Component:create()
        com:init()
        com:setSize(100,100)
        self.greedySelectLayer = com
        self:addChild(com,1001)

        
        local bg  = UI.Image:create()
        bg:init("ui_choice_base.png")
        bg:leftBottom(2,2)
        self.greedySelectLayer:addChild(bg,21)

        local greedySelectConfig = mvc.greedySelectModel:getGreedySelectGoodsConfigByPk(self:getPK())
        if greedySelectConfig then
            local headBg = UI.Image:create()
            headBg:leftBottom(0,7)
            headBg:init("ui_playerstate_me_black_down01.png")
            self.greedySelectLayer:addChild(headBg)

            local img  = UI.Image:create()
            img:init(greedySelectConfig.icon)
            img:center()
            img:setScale(0.8)
            local _ckipperSprite = cc.Sprite:createWithSpriteFrameName("ui_playerstate_me_black_up.png")
            local _clipper = cc.ClippingNode:create(_ckipperSprite)
            _clipper:setPosition(46,51)
            _clipper:setAlphaThreshold(0.05)
            _clipper:addChild(img,20)
            self.greedySelectLayer:addChild(_clipper)

            if self._type == UIType.TEAMMATESTATUS then
                _clipper:setScale(0.8)
                _clipper:setPosition(45,35)
                headBg:leftBottom(0,-9)
            end

            if self._type ~= UIType.TEAMMATESTATUS then
                local btn = UI.Button:create()
                btn:init(
                    "ui_btn_yellow9_0.png",
                    "ui_btn_yellow9_1.png",
                    "ui_btn_yellow9_2.png"
                )
                btn:leftBottom(90,12)
                btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                    mvc.send(mvc.events.GREEDY_SELECT_DO_SELECT, false)
                end)
                btn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
                self.greedySelectLayer:addChild(btn)
                btn:setText(UI.TEXT_1213267)
            end
            local gou  = UI.Image:create()
            gou:init("ui_dreamword_task_line_yes.png")
            gou:center()
            bg:addChild(gou)
        else
            local gou  = UI.Image:create()
            gou:init("ui_choice_no.png")
            gou:center()
            bg:addChild(gou)
        end
        if self._type == UIType.TEAMMATESTATUS then
            local desc = UI.Text:create()
            if greedySelectConfig then
                desc:init(UI.TEXT_1213268, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 102,  g = 184,  b = 77})
            else
                desc:init(UI.TEXT_1213269, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 187,  g = 36,  b = 45})
            end
            desc:leftBottom(77,22)
            desc:setTextCenter()
            self.greedySelectLayer:addChild(desc, 10)
        end
    end
end


function HeroPanel:update(dt)
    if(not tolua.isnull(self)) then
        self._waitingTime = self._waitingTime + dt
        if (self._waitingTime > 30) then
            self._waitingTime = 0
            self:triggerInitBuff(false)
        end
    end
end

function HeroPanel:triggerInitBuff(isInit)
    if self._type == UIType.PET_NULL or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PETSTATUS then
        return
    end
    local heroData = nil
    if self._type == UIType.PETSTATUS then
        heroData = RoleDataManager:getScreenPetDataByID(self:getPK())
    else
        heroData = RoleDataManager:getHeroDataForPK(self:getPK())
    end
    if (heroData == nil) then
        return
    end
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(heroData:getSpriteID())
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            local _buff = {}
            _buff.bufferData = v
            _buff.bufferEntityID = v:getEntityID()
            _buff.bufferTargetID = v:getTargetSpriteID()

            if (not self:checkRepeatBuff(_buff)) then
                if (_buff.bufferData:getICON()) then
                    if (isInit == false) then
                        printError(
                            "HeroPanel:triggerInitBuff buffView no matching buff data icon=%s",
                            _buff.bufferData:getICON()
                        )
                    end
                    self:addBuffView(_buff)
                end
            end
        end
    end
end

-- 析构函数
function HeroPanel:dtor()
    self._avatar_black = nil -- 头像背景
    self._avatar_SP = nil -- 头像
    self._avatar_frame = nil -- 头像上的框
    self._roleName = nil -- 英雄的名字
    self._grade_BG = nil -- 等级的背景
    self._lvLabel = nil -- 英雄等级
    self._occupation = nil -- 所持武器类型
    self._battle = nil -- 战斗图标
    self._off_line = nil -- 离线图标

    self._hpLabel = nil -- 英雄血量
    self._mpLabel = nil -- 英雄蓝量

    -- 进度条，血条，蓝条，经验条
    self._booldTimer = nil
    self._mpTimer = nil
    self._xpTimer = nil
    -- 动画，技能目标，怪物攻击目标，死亡动画
    self._light = nil
    -- self._target   = nil
    self._dead = nil
    --被攻击动画
    self._attacked = nil

    -- 增益buff,减益buff
    self._bufftable = nil
    self._debufftable = nil
    self._normalBuffTabel = nil
    self._normalDebuffTable = nil

    self._buffLayer = nil -- buff页面
    self._buffInfoLayer = nil -- buff详情页面
    self._buffInfoBg = nil -- buff详情页面背景

    self._data = nil

    self._search = nil --搜索特效

    self._dieState = false
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, self.onLooksChangeHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onHorcruxChangedHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ROLE_ANGER_CHANGED, self, self.updateMasterAnger)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE,self,self.removeBattleUIHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
    mvc.greedySelectModel:unbind("allGreedySelectInfo", self, self.updateTeamGreedySelect)
    Scheduler:unscheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler)
    HeroPanel.super.dtor(self)
end

function HeroPanel:removeBattleUIHandler()
    if self.angerPgs  then
        self.angerPgs:removeFromParent()
        self.angerPgs = nil
    end
end

function HeroPanel:scenePauseOrResume(isPause)
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

    local arr = self:_getAllAnimation()
    for k,v in ipairs(arr) do
        if(not tolua.isnull(v)) then  
            if(isPause) then 
                v:pause()
            else
                v:resume()
            end
        end
    end
end

function HeroPanel:_getAllAnimation()
    local arr = {}
    if(self._attacked) then 
        table.insert(arr, self._attacked)
    end
    if(self._light) then 
        table.insert(arr, self._light)
    end

    return arr
end 

function HeroPanel:_hanelTimePauseOrResume(timer, data, isPause)
    if(not tolua.isnull(timer)) then 
        if(isPause) then 
            timer:pause()
        else
            timer:resume()
            -- local buffer = data.bufferData
            -- local action = cc.ProgressTo:create(buffer:getDuration(), 100)
            -- timer:runAction(action)
        end
    end
end

function HeroPanel:updateMasterAnger()
    if self._data:getType() == RoleType.Pet then
        return 
    end
    local master = RoleDataManager:getMaster()
    if self._data:getPK() ~= master:getPK() then
        return
    end
    local anger = master.anger or 0
    local percent = anger/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE
    if not self.angerPgs then 
        self.angerPgs = AngerProgressComponent:create(0,1)
        self:addChild(self.angerPgs, 100001)
        self.angerPgs:setPosition(cc.p(14,-5))
    end
    self.angerPgs:updateProcess(percent)
end

-- 初始化
function HeroPanel:init(data)
    self:setData(data)
    --[[]] 
    HeroPanel.super.init(self)
    if self._type ~= UIType.PET_SITE_UNLOCK and self._type ~= UIType.PET_NULL then
        self:addTouchEvents()
    end
    
end

-- 初始化
function HeroPanel:getData()
    return self._data
end

-- 宠物未上阵头像状态
function HeroPanel:setPetNull()
    self._avatar_SP:setVisible(false)
    self._avatar_black:setVisible(false)
    -- self._equipmentType:setVisible(false)
    --主角背景
    local nullHead  = UI.Image:create()
    nullHead:center()
    nullHead:init("ui_pets_healthbar_view.png")
    self._avatar_SP_BG:addChild(nullHead)

    self:setNullPetUI()
end

-- 兽栏未解锁头像状态
function HeroPanel:setPetUnlock()
    self._avatar_SP:setVisible(false)
    self._avatar_black:setVisible(false)

    local lockFrame = UI.Image:create()
    lockFrame:init("ui_talent_btn_lock.png")
    lockFrame:center()
    self._avatar_SP_BG:addChild(lockFrame, ZORDER_HERO_PANEL_ICON)

    self:setNullPetUI()
    -- self._avatar_SP_BG:setVisible(false)
end

-- 技能选择好目标的回调
function HeroPanel:registerRoleHandler(target, clickSkillSelectCallback, _, clickNoramlCallback)
    -- body
    self._targetName = target
    self._clickSkillSelectCallback = clickSkillSelectCallback
    self._clickNormalCallback = clickNoramlCallback
end

-- 触摸监听
function HeroPanel:addTouchEvents()
    if self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return false
    end
    -- body
    local function onTouchBegan(touch, event)
        local posStarTouch = touch:getLocation()
        if self._data == nil then
            if self.touchLayout:checkTouch(posStarTouch) then
                return true
            end
        end

        --   --  worldspace
        local point = self:convertToWorldSpace(cc.p(0, 0))
        local rect = cc.rect(point.x, point.y, WIDTH - 50, HEIGHT)

        local nums = 0
        if #self._normalBuffTabel > 0 then
            nums = nums + 1
        end
        if #self._normalDebuffTable > 0 then
            nums = nums + 1
            nums = nums < 2 and 2 or nums
        end
        local point = self._buffLayer:convertToWorldSpace(cc.p(0, 0))

        local buffW = 30 * math.min(#self._normalBuffTabel, 5)
        if #self._normalDebuffTable > #self._normalBuffTabel then
            buffW = 30 * math.min(#self._normalDebuffTable, 5)
        end

        if self._type == UIType.TEAMMATESTATUS then
            if #self._normalDebuffTable > 0 then
                nums = #self._normalDebuffTable
                nums = nums < 2 and 2 or nums
            end
            self.buffRect = cc.rect(point.x - 15, point.y, math.max(buffW + 30, 100), 30 * nums + 10)
        elseif self._type == UIType.PETSTATUS then
            self.buffRect = cc.rect(point.x - 15, point.y - 40, math.max(buffW + 30, 100), 30 * nums + 10)
        else
            self.buffRect = cc.rect(point.x - 15, point.y - 40, math.max(buffW + 30, 100), 30 * nums + 80)
        end
        -- self.buffRect = cc.rect(point.x , point.y, 30 * #self._normalBuffTabel, 70)
        if cc.rectContainsPoint(self.buffRect, posStarTouch) then
            -- 符合长按 弹出页面 buff
            Scheduler:scheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler, TOUCH_TIME)

            if #self._normalBuffTabel > 0 or #self._normalDebuffTable > 0 then
                return true
            else
                return false
            end
        elseif cc.rectContainsPoint(rect, posStarTouch) then
            self:ShowLight()
            return true
        else
            return false
        end
    end

    local function onTouchMoved(touch, event)
    end

    local function onTouchEnded(touch, event)
        if self._buffInfoLayer then
            self._buffInfoLayer:setVisible(false)
        end

        if self._disabel then
            return
        end

        local posTouch = touch:getLocation()
        local point = self:convertToWorldSpace(cc.p(0, 0))
        local rect = cc.rect(point.x, point.y, 90, HEIGHT)
        if self._data:getType() ~= RoleType.Pet then
            if self._waitMateState == true then
                -- 在英雄模式不能请求匹配
                if (SceneManager:getInstance():isInHero() or SceneManager:getInstance():isInTitanHero()) then
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111442))
                else
                    if cc.rectContainsPoint(rect, posTouch) then
                        self:requestMatch()
                    end
                end
                return
            end

            local oldSkillState = self._isSkill
            -- 处理技能选择好的回调
            if self._isSkill == true then
                self._isSkill = false
                if self._clickSkillSelectCallback then
                    self._clickSkillSelectCallback(self._targetName, self)
                end
                self._light:setAnimation("end", false)
                return
            end

                local heroData = RoleDataManager:getMaster()
                local state = heroData:getState()

                local point = self:convertToWorldSpace(cc.p(0, 0))
                local rect = cc.rect(point.x, point.y, 210, 90)

            local posStarTouch = touch:getLocation()
            if cc.rectContainsPoint(rect, posStarTouch) then

                local isInTown = SceneManager:getInstance():isInTownOrInHome()
                if self._clickNormalCallback then
                    self._clickNormalCallback(self, self._data)
                elseif TeamDataManager:hasTeam() and (not isInTown) then
                    if self._waitMateState == false and not self._isTouchLongTime then
                        -- self:getParent():getParent():addHeadTips(self:getPK(), self._data)
                        Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_SHOW_HEAD_TIPS, self:getPK(), self._data)
                        end
                elseif not oldSkillState then
                    if self._type ~= UIType.TEAMMATESTATUS then
                        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
                    end
                end
            end
        end
        if (self._isTouchLongTime) then
            self:onTouchLongTimeEndedHandler(posTouch)
        else
            Scheduler:unscheduleUpdateOnce(self, self.onTouchLongTimeBeganHandler)
        end
    end




    -- if self._type == UIType.TEAMMATESTATUS then
    -- else
        local layout = UI.Layout:create()
        layout:init()
        self:addChild(layout, 100)
        if self._type == UIType.PETSTATUS then
            layout:leftBottom(0, 0)
            layout:setSize(290, 60)
        elseif self._type == UIType.TEAMMATESTATUS then
            layout:center()
            layout:setSize(290, 100)
        else
            layout:center()
            layout:setSize(320, 90)
        end
        -- layout:enableDebugDraw()
        self.touchLayout = layout
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)
        local eventDispatcher = self:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layout)
        -- listener:setSwallowTouches(true)

        if self._type ~= UIType.TEAMMATESTATUS then
            listener:setSwallowTouches(true)
        end
    -- end
end

-- 长按呼出buff详情面板
function HeroPanel:onTouchLongTimeBeganHandler()
    self._isTouchLongTime = true
    -- 弹出页面
    self:showBuffInfo()
end

-- 不符合长按
function HeroPanel:onTouchLongTimeEndedHandler()
    self._isTouchLongTime = false
end

-- 播放技能选择目标动画
function HeroPanel:ShowLight()
    if self._isSkill == true then
        self._light:setAnimation("start", false)
        self._light:addAnimation("end", false)
    end
    if GameManager:getIsGooglePlay() then
        if self._data:getType() ~= RoleType.Pet and 
            self._type ~= UIType.TEAMMATESTATUS then
            self._light:setAnimation("start", false)
            self._light:addAnimation("end", false)
        end
    end
end

-- 点击技能开始选择目标
function HeroPanel:ChoseRole(component)
    if self._dieState or self.viewState ~= 1 or self._waitMateState then
        return
    end

    self._light:setVisible(true)
    self._light:setAnimation("showup", false)
    self._light:addAnimation("loop", true)
    -- 使用技能状态
    self._isSkill = true
end

--  技能中断的操作
function HeroPanel:canelChoseRole()
    if self._light then
        self._light:setAnimation("end", false)
        self._isSkill = false
    end
end

-- 创建面板初始化页面
function HeroPanel:onInitView(data)
    --root节点
    self.rootLayer = cc.Layer:create()
    self.rootLayer:setPosition(cc.p(0, 0))
    self.rootLayer:setContentSize(cc.size(WIDTH, HEIGHT))
    self:addChild(self.rootLayer)

    -- 创建基础数据
    self:addBasicInfo()

    -- print("HeroPanel:onInitView:", self._type, )
    if self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return
    end
    -- 创建进度条
    self:createProgressTimer()

    -- 显示解救的人数
    self:createRescure()

    -- 创建动画
    self:createAnimation()
    -- 添加buff面板
    if self._type ~= UIType.PET_NULL and self._type ~= UIType.PET_SITE_UNLOCK then
        self:createBuffLayer()
    end
    if self._data then
        -- 英雄名字
        self._roleName:setText(self._data:getNickName())
        self:updateOnLineState(self._data:getState())
        if self._type == UIType.PETSTATUS then
            heroData = RoleDataManager:getScreenPetDataByID(self:getPK())
        else
            heroData = RoleDataManager:getHeroDataForPK(self:getPK())
        end
        if heroData then
            self:updateState(heroData)
            self:triggerInitBuff(true)
        end
    else
        self:waitMate()
    end

    self:updateHeadImg()
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, self.onLooksChangeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onHorcruxChangedHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ROLE_ANGER_CHANGED, self, self.updateMasterAnger)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE,self,self.removeBattleUIHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
    self:updateTeamGreedySelect()
    mvc.greedySelectModel:bind("allGreedySelectInfo", self, self.updateTeamGreedySelect)
end


function HeroPanel:setData(data)
    self._data = data
end

function HeroPanel:onUpdateView(data)
end

function HeroPanel:refreshRoleInfoShowType()
    local _showType = Game.Manager:getRoleInfoShowType()
    if self._data then
        local hp = ""
        local mp = ""
        if _showType == ShowType.PERCENT then
            local HP = math.floor(self.hpNum / self.hpMax * 100)
            local MP = math.floor(self.mpNum / self.mpMax * 100)

            if HP == 0 and self.hpNum ~= 0 then
                HP = 1
            end
            if MP == 0 and self.mpNum ~= 0 then
                MP = 1
            end

            hp = HP .. "%"
            mp = MP .. "%"
        elseif _showType == ShowType.VALUE then
            local showTempHpNum = self.hpNum
            local showTempHpMax = self.hpMax
            local showTempMpNum = self.mpNum
            local showTempMpMax = self.mpMax

            if showTempHpNum > 1000000 then
                showTempHpNum = AvalonUtil:getSimpleNumber(showTempHpNum, 5)
            end
            if showTempHpMax > 1000000 then
                showTempHpMax = AvalonUtil:getSimpleNumber(showTempHpMax, 5)
            end
            hp = showTempHpNum .. "/" .. showTempHpMax

            if showTempMpNum > 1000000 then
                showTempMpNum = AvalonUtil:getSimpleNumber(showTempMpNum, 5)
            end
            if showTempMpMax > 1000000 then
                showTempMpMax = AvalonUtil:getSimpleNumber(showTempMpMax, 5)
            end
            hp = showTempHpNum .. "/" .. showTempHpMax
            mp = showTempMpNum .. "/" .. showTempMpMax
        else
        end

        self._hpLabel:setText(hp)
        -- self._teamhpLabel:setText(hp)
        self._mpLabel:setText(mp)
    end
end

-- 更新视图
function HeroPanel:refreshPetInfo(data)
    if self._type ~= UIType.PETSTATUS then
        return
    end
    self:refreshView(data)
end

-- 更新视图
function HeroPanel:refreshView(data, forceUpdate)
    -- 英雄血量显示方式
    local _showType = Game.Manager:getRoleInfoShowType()

    if data then
        if data:getType() == RoleType.Pet then
            self:setData(data)
        end
        local hpMax = data.hp
        -- 当前血量
        local hpNum = data.curHp
        -- print("血量 === ", hpMax, hpNum)
        if hpNum > hpMax then
            hpNum = hpMax
        elseif hpNum < 0 then
            hpNum = 0
        end
        -- print("血量", hpNum)

        local mpMax = data.mp
        local mpNum = data.curMp
        local xpMax = data and data.expToNextLV or 0
        local xpNum = data and data.curLVExp or 0

        if self._type == UIType.PETSTATUS then
            mpMax = GameDataManager:getInstance():getMaster():getPetHpStorage()
            mpNum = GameDataManager:getInstance():getMaster():getPetCurHpStorage()
            xpMax = data:getMaxExp()
            xpNum = data:getCurExp()
        end

        if mpNum > mpMax then
            mpNum = mpMax
        elseif mpNum < 0 then
            mpNum = 0
        end

        self.hpNum = hpNum
        self.hpMax = hpMax
        self.mpNum = mpNum
        self.mpMax = mpMax
        if xpNum > xpMax then
            xpNum = xpMax
        elseif xpNum < 0 then
            xpNum = 0
        end

        local hp = ""
        local mp = ""
        local xp = ""
        if _showType == ShowType.PERCENT then
            local HP = math.floor(hpNum / hpMax * 100)
            local MP = math.floor(mpNum / mpMax * 100)
            local XP = math.floor(xpNum / xpMax * 100)

            if HP == 0 and hpNum ~= 0 then
                HP = 1
            end
            if MP == 0 and mpNum ~= 0 then
                MP = 1
            end
            if XP == 0 and xpNum ~= 0 then
                XP = 1
            end

            hp = HP .. "%"
            mp = MP .. "%"
            xp = XP .. "%"
        elseif _showType == ShowType.VALUE then
            local showTempHpNum = hpNum
            local showTempHpMax = hpMax
            local showTempMpNum = mpNum
            local showTempMpMax = mpMax

            if showTempHpNum > 1000000 then
                showTempHpNum = AvalonUtil:getSimpleNumber(showTempHpNum, 5)
            end
            if showTempHpMax > 1000000 then
                showTempHpMax = AvalonUtil:getSimpleNumber(showTempHpMax, 5)
            end
            hp = showTempHpNum .. "/" .. showTempHpMax

            if showTempMpNum > 1000000 then
                showTempMpNum = AvalonUtil:getSimpleNumber(showTempMpNum, 5)
            end
            if showTempMpMax > 1000000 then
                showTempMpMax = AvalonUtil:getSimpleNumber(showTempMpMax, 5)
            end

            if self._type == UIType.PETSTATUS then
                hp = showTempHpNum
            else
                hp = showTempHpNum .. "/" .. showTempHpMax
            end
            
            mp = showTempMpNum .. "/" .. showTempMpMax
            xp = xpNum .. "/" .. xpMax
        else
        end

        self._booldTimer:setPercent(hpNum / hpMax)
        self._mpTimer:setPercent(mpNum / mpMax)

        --第一次刷新的时候，没有掉血的效果
        if self._isFirstUpdate then
            self._booldTimer:setChangePercent(hpNum / hpMax)
        else
            -- self._booldTimer:setBarChangeAction(self._lastScale, hpNum/hpMax, time)
            local time = (self._lastScale - hpNum / hpMax) * 2 * 1000 -- 从100到0  的时间为5秒
            -- print("===血条变化时间", time)
            self._booldTimer:setBarChange(self._lastScale, hpNum / hpMax, time)
        end
        self._hpLabel:setText(hp)
        -- self._teamhpLabel:setText(hp)
        self._mpLabel:setText(mp)

        -- 英雄等级
        local showLv = data.getUIShowLv and data:getUIShowLv() or data.roleLV
        self._lvLabel:setText(showLv)--(data.roleLV)
        -- print("heropanel  最大等级",data.roleLV,data.heroMaxLevel)

        -- 更新昵称
        if (self._roleName) then
            self._roleName:setText(data:getNickName())
        end

        -- 缺口处理（30度左右，330/360）
        self._xpTimer:setPercent(xpNum / xpMax)

        -- 记录本次的血量
        self._lastScale = hpNum / hpMax
        self._isFirstUpdate = false



        if self._type ~= UIType.PETSTATUS and self._type ~= UIType.PET_NULL and self._type ~= UIType.PET_SITE_UNLOCK then
            self:updateEquipIcon()
            local wearEquipmentArrMark = false
            local wearEquipmentDataArr
            if self._type == UIType.TEAMMATESTATUS then
                wearEquipmentDataArr = GameDataManager:getRoleInfoDataForPK(self._data:getPK()).wearEquipmentArr
            else
                wearEquipmentDataArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            end

            if #self._wearEquipmentDataArr == #wearEquipmentDataArr then
                for k, v in pairs(self._wearEquipmentDataArr) do
                    local mark = false
                    for k1, v1 in pairs(wearEquipmentDataArr) do
                        if v == v1 then
                            mark = true
                            break
                        end
                    end

                    if mark == false then
                        wearEquipmentArrMark = true
                        break
                    end
                end
            else
                wearEquipmentArrMark = true
            end

            local refreshHeroRenderEquipmentChange = self._isHideHelmet == RoleDataManager:getHeroDataForPK(self._data:getPK()):getIsHideHelmet()

            if self._createHeadMark == false or wearEquipmentArrMark == true or refreshHeroRenderEquipmentChange or
                self._faceDecodeID ~= RoleDataManager:getHeroDataForPK(self._data:getPK()):getFaceDecodeID() or forceUpdate == true then
                self._isHideHelmet = RoleDataManager:getHeroDataForPK(self._data:getPK()):getIsHideHelmet()
                self._createHeadMark = true
                self._faceDecodeID = RoleDataManager:getHeroDataForPK(self._data:getPK()):getFaceDecodeID()

                if self._type == UIType.TEAMMATESTATUS then
                    local wearEquipmentDataArr =
                        GameDataManager:getRoleInfoDataForPK(self._data:getPK()).wearEquipmentArr
                    self._wearEquipmentDataArr = clone(wearEquipmentDataArr)
                    -- local _wearEquipmentDataArr = clone(wearEquipmentDataArr)

                    local _wearEquipmentDataArr = {}
                    for k,v in pairs(self._data:getHeadID()) do
                        -- add by zp 这里统一把幻化ID装换为幻化后具体的装备ID
                        local equipmentID = ToolsUtil:handleNoMasterEquipmentID(v)
                        if v ~= 0 and equipmentID ~= 0 then
                            local goodsData = GoodsDataManager:createLocalGoodsData(equipmentID)
                            if(goodsData) then
                                goodsData:setWearPosition(goodsData:getEquipmentType())
                                table.insert(_wearEquipmentDataArr,goodsData)
                            end
                        end
                    end

                    if self._isHideHelmet then
                        _wearEquipmentDataArr = {}
                    end

                    Avalon.WidgetUtil:getHead(
                        self,
                        RoleDataManager:getHeroDataForPK(self._data:getPK()),
                        _wearEquipmentDataArr,
                        self,
                        handler(
                            self,
                            function(self, pic)
                                if self and not tolua.isnull(self) then
                                    self._avatar_SP:setVisible(false)
                                    self.rootLayer:removeChildByName("heorIcon", true)
                                    pic:setPosition(42, 34)
                                    pic:setName("heorIcon")
                                    self.rootLayer:addChild(pic, -1)
                                    self._heroIcon = pic

                                    if self.viewState == 2 then
                                        local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                                        if (shader) then
                                            self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
                                        end
                                    end
                                    self._heroIcon:setScale(0.8)
                                end
                            end
                        ),
                        true,nil,nil,nil,refreshHeroRenderEquipmentChange
                    )
                else
                    local wearEquipmentDataArr =
                        GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
                    self._wearEquipmentDataArr = clone(wearEquipmentDataArr)
                    local _wearEquipmentDataArr = clone(wearEquipmentDataArr)
                    if self._isHideHelmet then
                        _wearEquipmentDataArr = {}
                    end

                    Avalon.WidgetUtil:getHead(
                        self,
                        RoleDataManager:getHeroDataForPK(self._data:getPK()),
                        _wearEquipmentDataArr,
                        self,
                        handler(
                            self,
                            function(self, pic)
                                if self and not tolua.isnull(self) then
                                    self._avatar_SP:setVisible(false)
                                    self.rootLayer:removeChildByName("heorIcon", true)
                                    pic:setPosition(45, 47)
                                    pic:setName("heorIcon")
                                    self.rootLayer:addChild(pic, -1)

                                    self._heroIcon = pic
                                    if self.viewState == 2 then
                                        local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                                        if (shader) then                                   
                                            self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
                                        end
                                    end
                                end
                            end
                        ),
                        true,nil,nil,nil,refreshHeroRenderEquipmentChange
                    )
                end
            end

            local reincarntionLv = data.getReincarntionLv and data:getReincarntionLv() or 0
            if reincarntionLv > 0 then
                local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(reincarntionLv)
                if self._type == UIType.TEAMMATESTATUS then
                    self._avatar_black:setSpriteName("ui_playerstate_teammate_black_2.png")
                else
                    self._avatar_black:setSpriteName(headFrame)
                end
                
                self._grade_BG:setSpriteName(levelFrame)
            end

            if self._type == UIType.TEAMMATESTATUS then
                self:setTeamUI()
            end
        else
           self:refreshPetHead()
        end
    else
        -- 这里在状态改变为下线的时候，客户端还没有显示出来，会导致 CO-3376 bugs
        if self.rootLayer and self._data then
            self:updateOnLineState(self._data:getState())
        end
    end
end

function HeroPanel:refreshPetHead()
    local heroIcon = self.rootLayer:getChildByName("heorIcon")
    if heroIcon == nil then
        self._avatar_SP:setVisible(false)
        local pic = UI.Image:create()
        local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(self._data:getIcon())
        if spriteFrame ~= nil then
            pic:init(self._data:getIcon())
        else
            pic:init("ui_playerstate_pet_black_up.png")
        end
        pic:center()

        local clipper = UI.ClippingNode:create()
        clipper:initWithSprite("ui_playerstate_pet_black_up.png",  0.01)
        clipper:leftBottom(8, 10)
        clipper:addInnerNode(pic)
        clipper:setName("heorIcon")
        clipper:setOpacityFilterTouch(false)
        self._heroIcon = pic
        self.rootLayer:addChild(clipper, -1)
        self:setPetUI()
        self:updateState(data)
    else
        local pic = heroIcon:getChildByName("pic")
        if self._heroIcon._spriteName ~= self._data:getIcon() then
            self.rootLayer:removeChildByName("heorIcon", true)
            local pic = UI.Image:create()
            local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(self._data:getIcon())
            if spriteFrame ~= nil then
                pic:init(self._data:getIcon())
            else
                pic:init("ui_playerstate_pet_black_up.png")
            end
            pic:center()
          
            local clipper = UI.ClippingNode:create()
            clipper:initWithSprite("ui_playerstate_pet_black_up.png",  0.01)
            clipper:leftBottom(8, 10)
            clipper:addInnerNode(pic)
            clipper:setName("heorIcon")
            clipper:setOpacityFilterTouch(false)
            self._heroIcon = pic
            self.rootLayer:addChild(clipper, -1)
            self:setPetUI()
            self:updateState(data)
        end
    end
end

function HeroPanel:onHorcruxChangedHandler(data)
    if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return 
    end
    if data.isIllusion then
        self:updateEquipIcon()
    end
end

function HeroPanel:onLooksChangeHandler(spriteID, looks)
    if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return 
    end
    self:updateHeadImg()
end


local last = 0
function HeroPanel:updateHeadImg()
    if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        return 
    end
    if tolua.isnull(self) then
        return
    end

    local pk = self._data:getPK()
    local heroData = RoleDataManager:getHeroDataForPK(pk)
    local looks
    if heroData  then
        looks = heroData.looks or 0
    else
        return
    end

    if self.horcurxHead then
        self.horcurxHead:removeFromParent()
        self.horcurxHead = nil
    end
    if not looks or looks == 0 or looks > 9  then
        return
    end


    local horcurxHead = UI.Component:create()
    horcurxHead:init()
    horcurxHead:leftBottom(44,50)
    -- horcurxHead:enableDebugDraw()
    self:addChild(horcurxHead, ZORDER_HERO_PANEL_NAME + 4)
    self.horcurxHead = horcurxHead

    local img  = UI.Image:create()
    img:init("ui_playerstate_horcrux_0" .. looks .. ".png")
    img:center()
    self.horcurxHead:addChild(img)

    if self._type == UIType.TEAMMATESTATUS then
        self.horcurxHead:setScale(0.8)
        self.horcurxHead:leftBottom(44,34)
    end
end

--二次布局
function HeroPanel:setTeamUI()
    self._avatar_SP_BG:setScale(0.8)
    self._grade_BG:setScale(0.8)
    self._booldTimer:setScale(0.8)
    self._mpTimer:setScale(0.8)
    self._xpTimer:setScale(0.8)
    self._hpLabel:setScale(0.8)
    self._mpLabel:setScale(0.8)

    self._roleName:leftUp(83, 32)
    self._avatar_black:leftUp(7, 33)
    self._avatar_SP_BG:leftUp(-4, 25)
    self._booldTimer:leftUp(70, 53)
    self._mpTimer:leftUp(70, 65)
    self._xpTimer:leftUp(70, 75)

    self._equipmentType:leftUp(54, 30)
    self._grade_BG:leftBottom(1, -3)
    self._xpTimer:hide()
end

function HeroPanel:setPetUI()
    self._avatar_SP_BG:setScale(0.8)
    -- self._booldTimer:setScale(0.8)
    self._mpTimer:setScale(0.8)
    self._xpTimer:setScale(0.8)
    self._hpLabel:setScale(0.8)
    self._mpLabel:setScale(0.8)
    self._grade_BG:setScale(0.7)

    self._roleName:leftUp(72, 39)
    -- self._avatar_black:leftUp(7, 33)
    self._avatar_black:setVisible(false)
    self._avatar_SP_BG:leftUp(-8, 20)
    -- self._booldTimer:leftUp(59, 57)
    self._booldTimer:leftUp(4, 33)
    self._hpLabel:centerBottom(-12)
    self._hpBg:centerBottom(-8)
    -- self._mpTimer:leftUp(59, 69)
    self._mpTimer:leftBottom(-15, -15)
    -- self._xpTimer:leftUp(59, 79)
    self._xpTimer:setVisible(false)

    self._equipmentType:hide()
    self._grade_BG:leftBottom(-4, 2)

    -- if self._data.siteId ~= 
    self._mpTimer:setVisible(self._data.siteId == 0)
    self._roleName:setVisible(false)
    -- self._booldTimer:setPercent(0.7)
end

function HeroPanel:setNullPetUI()

    self._avatar_SP_BG:setScale(0.8)
    -- self._booldTimer:setScale(0.8)
    self._grade_BG:setScale(0.7)

    self._avatar_black:setVisible(false)
    self._avatar_SP_BG:leftUp(-8, 20)

    self._equipmentType:hide()
    self._grade_BG:leftBottom(-4, 2)
end

-- 头像黑
function HeroPanel:changeDark()
    -- print("HeroPanel:changeDark")
    if self.viewState == 3 then
        return
    end
    self.viewState = 3
    -- print("HeroPanel:changeDark")
    self._avatar_SP:useShader(UI.COMPONENT_GRAY_SHADER)
    self._grade_BG:useShader(UI.COMPONENT_GRAY_SHADER)
    self._avatar_black:useShader(UI.COMPONENT_GRAY_SHADER)
    if self._heroIcon and not tolua.isnull(self._heroIcon) then
        if self._type == UIType.PETSTATUS then
            self._heroIcon:useShader(UI.COMPONENT_GRAY_SHADER)
        else
            local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
            if (shader) then
                self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
            end
        end
    end
    if self._type ~= UIType.PETSTATUS then
        self._booldTimer:setSpriteName(
        "ui_playerstate_me_blood1_00.png",
        "ui_playerstate_me_blood3_02.png",
        "ui_playerstate_me_blood3_01.png"
        )
    end
    
    if self._type == UIType.PETSTATUS then
        self._avatar_black:setSpriteName("ui_playerstate_pet_black.png")
    elseif self._type ~= UIType.TEAMMATESTATUS then
        self._avatar_black:setSpriteName("ui_playerstate_me_black_03.png")
    end

    self._mpTimer:setSpriteName("ui_playerstate_mp1_00.png", "ui_playerstate_mp2_01.png", "ui_playerstate_mp2_01.png")

    --装备的武器
    self._equipmentType:useShader(UI.COMPONENT_GRAY_SHADER)

    -- self._roleName:setFontColor(UI.FONT_COLOR_215_185_155)
    self._lvLabel:setFontColor(UI.FONT_COLOR_160_156_47)
end

-- 头像变回正常
function HeroPanel:changeLight()
    if self.viewState == 1 then
        return
    end

    self.viewState = 1
    self._avatar_SP:useShader(UI.COMPONENT_NORMAL_SHADER)
    self._grade_BG:useShader(UI.COMPONENT_NORMAL_SHADER)
    self._avatar_black:useShader(UI.COMPONENT_NORMAL_SHADER)
    if self._heroIcon and not tolua.isnull(self._heroIcon) then
        if self._type == UIType.PETSTATUS then
            self._heroIcon:useShader(UI.COMPONENT_NORMAL_SHADER)
        else
            local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER)
            if (shader) then
                self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
            end
        end
    end

    
    if self._type == UIType.TEAMMATESTATUS then
        self._avatar_black:setSpriteName("ui_playerstate_teammate_black.png")
    elseif self._type == UIType.PETSTATUS then
        self._avatar_black:setSpriteName("ui_playerstate_pet_black.png")
    else
        self._avatar_black:setSpriteName("ui_playerstate_me_black_01.png")
    end
    self._avatar_SP_BG:setSpriteName("ui_playerstate_me_black_down01.png")

    if self._type == UIType.PETSTATUS then
        -- self._mpTimer:setSpriteName("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_02.png", "ui_playerstate_reserve1_01.png")
    else
        self._mpTimer:setSpriteName("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_01.png", "ui_playerstate_mp1_01.png")
        self._booldTimer:setSpriteName(
        "ui_playerstate_me_blood1_00.png",
        "ui_playerstate_me_blood1_02.png",
        "ui_playerstate_me_blood1_01.png"
        )
    end

    --装备的武器
    if self._type ~= UIType.PETSTATUS then
        self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
    end

    -- self._roleName:setFontColor(UI.FONT_COLOR_215_185_155)
    self._lvLabel:setFontColor(UI.FONT_COLOR_255_235_216)
end

-- 头像变灰
function HeroPanel:changeGrey()
    if self.viewState == 2 then
        return
    end
    self.viewState = 2
    self._off_line:hide()

    self._battle:setVisible(false)
    if self._type == UIType.PETSTATUS then
        -- self._avatar_black:setSpriteName("ui_playerstate_pet_black.png")
    elseif self._type ~= UIType.TEAMMATESTATUS then
        self._avatar_black:setSpriteName("ui_playerstate_me_black_02.png")
    end
    
    if self._type == UIType.PETSTATUS then
        -- self._mpTimer:setSpriteName("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_02.png", "ui_playerstate_mp2_01.png")
    else
        self._mpTimer:setSpriteName("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_02.png", "ui_playerstate_mp2_01.png")
        self._booldTimer:setSpriteName(
        "ui_playerstate_me_blood1_00.png",
        "ui_playerstate_me_blood2_02.png",
        "ui_playerstate_me_blood2_01.png"
        )
    end

   
    --头像
    self._avatar_SP:useShader(UI.COMPONENT_GRAY_SHADER)
    self._grade_BG:useShader(UI.COMPONENT_GRAY_SHADER)
    self._avatar_black:useShader(UI.COMPONENT_GRAY_SHADER)
    if self._heroIcon and not tolua.isnull(self._heroIcon) then
        if self._type == UIType.PETSTATUS then
            self._heroIcon:useShader(UI.COMPONENT_GRAY_SHADER)
        else
            local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
            if (shader) then
                self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
            end
        end
    end
    if self._type ~= UIType.PETSTATUS then
        --装备的武器
        self._equipmentType:useShader(UI.COMPONENT_GRAY_SHADER)
    end

    -- self._roleName:setFontColor(UI.FONT_COLOR_215_185_155)
    self._lvLabel:setFontColor(UI.FONT_COLOR_130_109_62)
    self:updateTeamGreedySelect()
end

--更新在线状态
function HeroPanel:updateOnLineState(onLine)
    if self._data then
        if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
            return
        end
        self._data._onLineState = onLine
        -- print("HeroPanel:updateOnLineState",onLine,PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE)

        if onLine == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
            --头像变回普通状态
            self:changeLight()
            self._off_line:hide()
            if self._buffLayer then
                self._buffLayer:setVisible(true)
            end
        else
            self:changeDark()
            self._off_line:show()
            if self._buffLayer then
                self._buffLayer:setVisible(false)

                -- 处理一下buffLayer和buffInfoLayer上的buff
                for _, buff in pairs(self._bufftable) do
                    self:removeOneInfoBuff(buff)
                    self:removeOneIconBuff(buff)
                end
                for _, buff in pairs(self._debufftable) do
                    self:removeOneInfoBuff(buff)
                    self:removeOneIconBuff(buff)
                end

                self._bufftable = {}
                self._debufftable = {}
                self._normalBuffTabel = {}
                self._normalDebuffTable = {}
            end
        end

        if self._dead then
            self._dead:setVisible(false)
            if(self.mMercenaryText) then 
                self.mMercenaryText:removeFromParent(true)
                self.mMercenaryText = nil
            end
        end

        if self._resurgenceLayer then
            self._resurgenceLayer:setVisible(false)
        end
        self:updateTeamGreedySelect()
    end
end

--死亡状态
function HeroPanel:dieState(roleData)
    if self._data and self._data._onLineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
        return
    end

    if not self._dead then
        -- 队友死亡动画
        self._dead = UI.Animation:create()
        self._dead:init("effect_ui_gaming_playerstate_daed.json", "effect_ui_gaming_playerstate_daed.atlas")
        self:addChild(self._dead, ZORDER_HERO_PANEL_ANIMATION)
        self._dead:setVisible(false)
    end

    -- add by zp 在复活后，需要等到服务器通知是否复活完成，这里会导致表现问题
    if (self._dieState) then
    else
        self._dead:setAnimation("showup", false)
        self._dead:addAnimation("loop", true)

        self._dead:leftBottom(110, 44)

        self._dead:setVisible(true)

        self._dieState = true

        if roleData:getState() ~= FSMState.BATTLE and self:getPK() ~= RoleDataManager:getMasterPK() then
            self:showResurgence()
        elseif roleData:getState() ~= FSMState.BATTLE and roleData:getType() == RoleType.Pet and self._type == UIType.PETSTATUS then
            self:showResurgence()
        end
        if self._type == UIType.TEAMMATESTATUS then
            self._dead:setScale(0.8)
            self._dead:leftBottom(100, 50)
        elseif self._type == UIType.PETSTATUS then
            self._dead:setScale(0.75)
            self._dead:leftBottom(90, 40)
        end
    end

    if self._light then
        self._light:setAnimation("end", false)
    end

    if self._buffLayer then
        self._buffLayer:setVisible(false)
    end

    self:changeGrey()
end

-- 更新角色的状态
function HeroPanel:updateState(roleData)
    if self._data and self._data._onLineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
        return
    end

    if roleData then
        if (roleData:getIsDead()) then
            self:dieState(roleData)
        else
            -- add by zp 在复活后，需要等到服务器通知是否复活完成，这里会导致表现问题
            if (self._dead) then
                self._dead:setVisible(false)
                if(self.mMercenaryText) then 
                    self.mMercenaryText:removeFromParent(true)
                    self.mMercenaryText = nil
                end
            end
            self._dieState = false
            if self._buffLayer then
                self._buffLayer:setVisible(true)
            end

            self:changeLight()

            local fsmState = roleData:getState()

            if fsmState == FSMState.BATTLE then
                --需要判断当前攻击目标是否相同
                self._battle:setVisible(self._type ~= UIType.PETSTATUS and true or false)
                -- 战斗状态
                self._attacked:setVisible(true)
                self._attacked:setAnimation("showup", false)
                self._attacked:addAnimation("loop", true)
            elseif fsmState == FSMState.IDLE then
                -- print("====IDLE")
                if self._light then
                    self._light:setAnimation("end", false)
                end

                self:hideMonsterTarget()
                self._battle:setVisible(false)
            elseif fsmState == FSMState.WAITING then
                print("====WAITING")
            else
                if self._light then
                    self._light:setAnimation("end", false)
                end
                self:hideMonsterTarget()
                self._battle:setVisible(false)
            end
        end
    end
end

-- 显示怪物攻击目标(弃用)
function HeroPanel:showMonsterTarget()
    -- 被攻击状态
    self._attacked:setVisible(true)
    self._attacked:setAnimation("showup", false)
    self._attacked:addAnimation("loop", true)
end

-- 怪物攻击目标改变(弃用)
function HeroPanel:hideMonsterTarget()
    -- 取消被攻击
    if self._attacked and self._attacked:isVisible() then
        self._attacked:setVisible(false)
        self._attacked:setAnimation("end", false)
    end
end

--更新武器ICON
function HeroPanel:updateEquipIcon()
    if self._data then
        if self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
            return
        end
        local id = 0
        if self._data:getPK() == RoleDataManager:getMasterPK() then
            id =  HorcurxDataManager:getHorcurxIllusionId() or 0
        end
        if  id <= 0 then
            local heroData = RoleDataManager:getHeroDataForPK(self._data:getPK())
            local equipType = GameDataManager:getInstance():getWearWeaponTypeForSpriteID(heroData.spriteID)
            if equipType == 0 then
                self._equipmentType:hide()
            else
                self._equipmentType:show()
                if self.viewState == 1 then
                    self._equipmentType:setSpriteName("icon-equip_small1_21080010_" .. equipType .. ".png")
                    self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
                elseif self.viewState == 2 then
                    self._equipmentType:setSpriteName("icon-equip_small1_21080010_" .. equipType .. ".png")
                    self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
                elseif self.viewState == 3 then
                    self._equipmentType:setSpriteName("icon-equip_small1_21080010_" .. equipType .. ".png")
                    self._equipmentType:useShader(UI.COMPONENT_GRAY_SHADER)
                end
            end
        else
            self._equipmentType:show()
            self._equipmentType:setSpriteName("icon-equip_small1_horcrux_" .. id .. ".png")
            self._equipmentType:useShader(UI.COMPONENT_GRAY_SHADER)
        end
    end
end

-- 添加基础信息
function HeroPanel:addBasicInfo()
    -- print("HeroPanel:addBasicInfo")

    --主角背景
    self._avatar_SP_BG = UI.Image:create()
    self._avatar_SP_BG:centerLeft(1)
    self._avatar_SP_BG:init("ui_playerstate_me_black_down01.png")
    self:addChild(self._avatar_SP_BG, -10)

    self._avatar_black = UI.Image:create()
    if self._type == UIType.TEAMMATESTATUS then
        self._avatar_black:init("ui_playerstate_teammate_black.png")
    elseif self._type == UIType.PETSTATUS then
        self._avatar_black:init("ui_playerstate_pet_black.png")
        local touchLayout = UI.Layout:create()
        touchLayout:init()
        touchLayout:setSize(63, 63)
        touchLayout:leftUp(2, 33)
        touchLayout:setTouchEnable(true)
        self:addChild(touchLayout, 1000)
        touchLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            local masterData = GameDataManager:getInstance():getMaster()
            if(masterData and masterData:getState() ~= FSMState.BATTLE) then 
                mvc.openPanel("Pet", "PetMain")
            end
        end)
        
    else
        self._avatar_black:init("ui_playerstate_me_black_01.png")
    end

    self._avatar_black:centerLeft(0)
    self:addChild(self._avatar_black, ZORDER_HERO_PANEL_ICON)

    self._avatar_SP = UI.Image:create()
    self._avatar_SP:init("ui_playerstate_teammate_wait.png")
    if self._type == UIType.TEAMMATESTATUS then
        self._avatar_SP:leftUp(10, 35)
    -- elseif self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
    --     self._avatar_SP:setVisible(false)
    else
        self._avatar_SP:centerLeft(10)
    end
    self:addChild(self._avatar_SP, ZORDER_HERO_PANEL_ICON)

    -- 武器类型
    self._equipmentType = UI.Image:create()
    self._equipmentType:init("icon-equip_small1_21080010_1.png")
    self._equipmentType:leftUp(61, 8)
    self:addChild(self._equipmentType, ZORDER_HERO_PANEL_NAME+10)

    -- 战斗图标
    self._battle = UI.Image:create()
    self._battle:init("ui_playerstate_battle.png")

    self._battle:hide()
    self:addChild(self._battle, ZORDER_HERO_PANEL_NAME)
    if self._type == UIType.TEAMMATESTATUS then
        self._battle:leftUp(180, 50)
    elseif self._type == UIType.PETSTATUS then
        self._battle:leftUp(180, 34)
    else
        self._battle:leftUp(225, 13)
    end

    -- 离线
    self._off_line = UI.Image:create()
    self._off_line:init("ui_playerstate_teammate_teammate.png")
    if self._type == UIType.TEAMMATESTATUS then
        self._off_line:leftUp(20, 45)
    else
        self._off_line:centerLeft(25)
    end
    self._off_line:hide()
    self:addChild(self._off_line, ZORDER_HERO_PANEL_NAME)

    -- 等级背景图
    self._grade_BG = UI.Image:create()
    -- if self._type == UIType.PETSTATUS then
    --     -- self._grade_BG:init("ui_playerstate_pet_grade.png")
    -- else 
    --     self._grade_BG:init("ui_playerstate_me_grade.png")
    -- end 
    self._grade_BG:init("ui_playerstate_me_grade.png")
    self._grade_BG:leftBottom(0, 6)
    self:addChild(self._grade_BG, ZORDER_HERO_PANEL_NAME+5)

    -- 等级
    self._lvLabel = UI.Text:create()
    self._lvLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:centerLeft(-36)
    self._lvLabel:setTextCenter()
    self._grade_BG:addChild(self._lvLabel, 10)
    -- TODO 颜色

    -- 角色名字
    self._roleName = UI.Text:create()
    if self._type == UIType.TEAMMATESTATUS then
        self._roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_235_216)
    elseif self._type == UIType.PETSTATUS then
        self._roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_14PX, UI.FONT_COLOR_241_186_100)
    else
        self._roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
    end
    self._roleName:setSize(150, 24)
    self._roleName:leftUp(90, 16)
    self:addChild(self._roleName, ZORDER_HERO_PANEL_NAME)
end

-- 创建血条等进度条
function HeroPanel:createProgressTimer()
    -- 血条
    self._booldTimer = UI.ProgressTimer:create()
    if self._type == UIType.PETSTATUS then
        self._booldTimer:init( "ui_pets_healthbar_bg.png","ui_pets_healthbar_02.png", "ui_pets_healthbar.png")
        self._booldTimer:leftUp(0, 0)
    else
        self._booldTimer:init( "ui_playerstate_me_blood1_00.png","ui_playerstate_me_blood1_02.png", "ui_playerstate_me_blood1_01.png")
        self._booldTimer:leftUp(90, 41)
    end
    
    self._booldTimer:setPercent(1)
    self:addChild(self._booldTimer, ZORDER_HERO_PANEL_NAME)

    -- 蓝条
    self._mpTimer = UI.ProgressTimer:create()
    if self._type == UIType.PETSTATUS then
        -- self._mpTimer:init("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_02.png", "ui_playerstate_reserve1_01.png")
        self._mpTimer:init("ui_pets_progressbar_bg.png", nil, "ui_pets_progressbar.png")
    else
        self._mpTimer:init("ui_playerstate_mp1_00.png", "ui_playerstate_mp1_02.png", "ui_playerstate_mp1_01.png")
    end
    self._mpTimer:leftUp(90, 57)

    self:addChild(self._mpTimer, ZORDER_HERO_PANEL_NAME)
    self._mpTimer:setPercent(1)

    -- 经验条
    self._xpTimer = UI.ProgressTimer:create()
    self._xpTimer:init("ui_playerstate_me_ex1_02.png", nil, "ui_playerstate_me_ex1_01.png")
    self._xpTimer:leftUp(90, 71)
    -- 把经验条带出渲染树自己渲染(经验条很宽并且在屏幕的最下方, 会导致文理缓存占据整个屏幕, 让填充率降得很低)
    -- self._xpTimer:setRenderGroupTag(2)
    self:addChild(self._xpTimer, ZORDER_HERO_PANEL_NAME)
    -- self._xpTimer:enableDebugDraw()

    --宠物生命值背景
    if self._type == UIType.PETSTATUS then
        self._hpBg = UI.Image:create()
        self._hpBg:init("ui_pets_bg_02.png")
        self._hpBg:centerBottom(0)
        self._booldTimer:addChild(self._hpBg, ZORDER_HERO_PANEL_ANIMATION)
        -- self._hpBg:setVisible()
     end

    -- 生命值
    self._hpLabel = UI.Text:create()
    self._hpLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    self._hpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    self._hpLabel:center()
    self._hpLabel:setTextCenter()
    self._booldTimer:addChild(self._hpLabel, ZORDER_HERO_PANEL_ANIMATION)

    -- 魔法值
    self._mpLabel = UI.Text:create()
    self._mpLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    self._mpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    self._mpLabel:center()
    self._mpLabel:setTextCenter()
    self._mpTimer:addChild(self._mpLabel, ZORDER_HERO_PANEL_ANIMATION)
end

function HeroPanel:createRescure()
end

function HeroPanel:refreshRescure(count)
end

-- 获取唯一标示
function HeroPanel:getPK()
    return self._data:getPK()
end

-- 创建动画
function HeroPanel:createAnimation()
    --技能选择动画
    self._light = UI.Animation:create()
    self._light:init("effect_ui_gaming_playerstate_light1.json", "effect_ui_gaming_playerstate_light1.atlas")
    -- self._light:center()
    self._light:centerLeft(42)
    self:addChild(self._light, ZORDER_HERO_PANEL_ANIMATION)

    self._attacked = UI.Animation:create()
    self._attacked:init("effect_ui_gaming_playerstate_target.json", "effect_ui_gaming_playerstate_target.atlas")
    self._attacked:centerLeft(44)
    self:addChild(self._attacked, ZORDER_HERO_PANEL_ANIMATION)
    self._attacked:setScale(0.83)

    if self._type == UIType.TEAMMATESTATUS then
        self._light:setScale(0.75)
        self._light:leftUp(40, 64)
        self._attacked:setScale(0.73)
        self._attacked:leftUp(40, 64)
    elseif self._type == UIType.PETSTATUS then
        self._light:setScale(0.63)
        self._light:leftUp(35, 64)
        self._attacked:setScale(0.61)
        self._attacked:leftUp(35, 64)
    end
end

-- 创建buff页面
function HeroPanel:createBuffLayer()
    print("HeroPanel:createBuffLayer")
    -- self:enableDebugDraw()
    -- buff 显示区域
    self._buffLayer = 
    cc.Layer:create()
    -- cc.LayerColor:create(cc.c4b(255,255,255,255))--
    self._buffLayer:setContentSize(10, 10)
    self._buffLayer:setPosition(cc.p(213, 20))
    self:addChild(self._buffLayer, ZORDER_HERO_PANEL_BUFF)

    if self._type == UIType.TEAMMATESTATUS then
        self._buffLayer:setPosition(cc.p(78, -4))
    elseif self._type == UIType.PETSTATUS then
        self._buffLayer:setPosition(cc.p(172, 8))
    end
    -- buff详情弹出页面
    self._buffInfoLayer = cc.Layer:create()
    self._buffInfoBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))

    -- 方向符号
    local directionImage = cc.Sprite:createWithSpriteFrameName("ui_information_banner_background2.png")
    directionImage:setPosition(0, 0)
    directionImage:setRotation(180)
    -- directionImage:setScaleX(5)
    -- directionImage:setScaleY(5)
    self._buffInfoLayer:addChild(directionImage, 2)
    self._directionImage = directionImage
    self._directionImage:hide()
    
    if self._type == UIType.TEAMMATESTATUS and self._buffLayerParent then
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_ADD_BUFF_INFO, self._buffInfoLayer)
        self._buffLayerParent:addChild(self._buffInfoLayer, ZORDER_HERO_PANEL_BUFF)
    else
        self:addChild(self._buffInfoLayer, ZORDER_HERO_PANEL_BUFF)
    end

    self._buffInfoLayer:addChild(self._buffInfoBg)
    self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + 95, -BUFF_BACK_HEIGHT / 2 + 70)
    self._buffInfoLayer:setVisible(false)
end

--只有在init之前调用才有用，不然没用
function HeroPanel:setBuffParent(layer)
    self._buffLayerParent = layer
end

function HeroPanel:addBuffEffect(sp)
    if(self.isPause) then 
        return 
    end
    if not tolua.isnull(sp) then
        local animation = sp:getChildByName("buff_spine")
        if (not tolua.isnull(animation)) then
            animation:runAction(cc.RemoveSelf:create())
        end

        local action = UI.Animation:create()
        action:init("effect_ui_gaming_buff_icon.json", "effect_ui_gaming_buff_icon.atlas",1, true)
        action:setScale(1)
        action:setAnimation("triggle", false)

        action:addEventListener(
            UIEvent.ANIMATION_COMPLETE,
            self,
            function()
                if (not tolua.isnull(action)) then
                    action:runAction(cc.RemoveSelf:create())
                end 
            end
        )

        action:setName("buff_spine")
        action:leftUp(sp:getContentSize().width / 2, sp:getContentSize().height / 2)
        sp:addChild(action, 10)
        sp:setScale(0.24)

        if self._type == UIType.TEAMMATESTATUS or self._type == UIType.PETSTATUS then
            local repeate =
                cc.Sequence:create(cc.ScaleTo:create(0.16, 1.7), cc.DelayTime:create(0.066), cc.ScaleTo:create(0.42, 0.78))
            sp:runAction(repeate)
        else
            local repeate =
                cc.Sequence:create(cc.ScaleTo:create(0.16, 1.7), cc.DelayTime:create(0.066), cc.ScaleTo:create(0.42, 1.0))
            sp:runAction(repeate)
        end
    end
end

function HeroPanel:checkRepeatBuff(data)
    local buffer = data.bufferData
    if buffer:isGood() then
        for k, buffData in ipairs(self._bufftable) do
            if (buffData.ID == data.bufferEntityID) then
                if(buffData.data.bufferData:getID() ~= data.bufferData:getID())  then 
                    self:removeBuffView(buffData.data)
                    break
                else
                    return true
                end
            end
        end
    else
        for k, buffData in ipairs(self._debufftable) do
            if (buffData.ID == data.bufferEntityID) then
                if(buffData.data.bufferData:getID() ~= data.bufferData:getID())  then 
                    self:removeBuffView(buffData.data)
                    break
                else
                    return true
                end
            end
        end
    end

    return false
end

function HeroPanel:getBuffSetForBuffData(buffData)
    local allBuffSet = ConfigManager:getAllBuffSet()
    if(allBuffSet) then 
        local buffEffectType = buffData:getBuffEffectType()
        local buffID = buffData:getID()

        for k, v in pairs(allBuffSet) do 
            if(#v.buffEffectTypeID > 0) then 
                for k,ID in ipairs(v.buffEffectTypeID) do 
                    if(ID == buffEffectType) then 
                        return v
                    end
                end
            end

            if(#v.buffID > 0) then 
                for k,ID in ipairs(v.buffID) do 
                    if(ID == buffID) then 
                        return v
                    end
                end
            end
        end
    end

    return nil
end

function HeroPanel:getBuffSetFromNormalTable(buffSet)
    for k, buffData in ipairs(self._normalBuffTabel) do
        if (buffData.buffSet and buffData.buffSet.ID == buffSet.ID) then
            return buffData
        end
    end

    for k, buffData in ipairs(self._normalDebuffTable) do
        if (buffData.buffSet and buffData.buffSet.ID == buffSet.ID) then
            return buffData
        end
    end

    return nil
end

function HeroPanel:removeBuffSetFromNormalTable(removeBuffData)
    if(removeBuffData == nil) then 
        return 
    end
    local buffSet = removeBuffData.buffSet

    for k, buffData in ipairs(self._normalBuffTabel) do
        if buffData.ID == removeBuffData.ID or (buffData.buffSet and buffSet and buffData.buffSet.ID == buffSet.ID) then
            table.remove(self._normalBuffTabel, k)
            break
        end
    end

    for k, buffData in ipairs(self._normalDebuffTable) do
        if buffData.ID == removeBuffData.ID or (buffData.buffSet and buffSet and buffData.buffSet.ID == buffSet.ID) then
            table.remove(self._normalDebuffTable, k)
            break
        end
    end
end

function HeroPanel:getBuffSetFromAllTable(buffSet)
    if(buffSet == nil) then 
        return nil
    end
    for k, buffData in ipairs(self._bufftable) do
        if (buffData.buffSet and buffData.buffSet.ID == buffSet.ID) then
            return buffData
        end
    end

    for k, buffData in ipairs(self._debufftable) do
        if (buffData.buffSet and buffData.buffSet.ID == buffSet.ID) then
            return buffData
        end
    end

    return nil
end

-- 添加buff页面
function HeroPanel:addBuffView(data)
    -- print("====HeroPanel:addBuffView====",data.bufferTargetID)
    local buffer = data.bufferData

    if data then
        -- 判断是否重复添加
        if (self:checkRepeatBuff(data)) then
            return
        end

        -- 判断是否为融合的图标
        local buffSet = self:getBuffSetForBuffData(buffer)
        local oldBuffSet = nil
        if(buffSet) then
            oldBuffSet = self:getBuffSetFromNormalTable(buffSet)
        end

        -- 添加buffer，格式：{bufferData (table), bufferEntityID {number}, bufferTargetID (number)}
        if buffer:getICON() then --关闭测试时打开
            local iconName = buffer:getICON()
            if(buffSet) then 
                iconName = buffSet.icon
            end

            local sp = cc.Sprite:createWithSpriteFrameName(iconName) --关闭测试时打开
            local sp2 = cc.Sprite:createWithSpriteFrameName(buffer:getICON())
            if self._type == UIType.TEAMMATESTATUS or self._type == UIType.PETSTATUS then
                sp:setScaleX(0.78)
                sp:setScaleY(0.78)
            end

            local buffTimer = nil
            local buffTimer2 = nil
            if buffer.duration ~= -1 then
                buffTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("effect_buff_0.png"))
                buffTimer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                buffTimer:setPercentage(
                    1.0 * (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                )

                buffTimer2 = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("effect_buff_0.png"))
                buffTimer2:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                buffTimer2:setPercentage(
                    1.0 * (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                )

                -- 持续时间
                -- if(not self.isPause) then
                    local action = cc.ProgressTo:create(buffer:getDuration(), 100)
                    local action2 = cc.ProgressTo:create(buffer:getDuration(), 100)

                    buffTimer:runAction(action)
                    buffTimer2:runAction(action2)
                    if(self.isPause) then 
                        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
                            if(not tolua.isnull(buffTimer)) then 
                                buffTimer:pause()
                            end
                            if(not tolua.isnull(buffTimer2)) then 
                                buffTimer2:pause()
                            end
                        end, 2)
                    end
                -- end

                buffTimer:setPosition(cc.p(sp:getContentSize().width / 2, sp:getContentSize().height / 2))
                buffTimer2:setPosition(cc.p(sp2:getContentSize().width / 2, sp2:getContentSize().height / 2))
                sp:addChild(buffTimer)
                sp2:addChild(buffTimer2)
            end

            -- buffer 名称
            local buffName = cc.Label:createWithTTF("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
            self._buffInfoLayer:addChild(buffName)
            buffName:setWidth(112)
            buffName:setString(buffer.name)
            -- 描述文字
            local buffDescribe = cc.Label:createWithTTF("持续时间3S", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
            buffDescribe:setWidth(200)
            buffDescribe:setString(buffer.description)
            -- buffDescribe:setString("fsdhj fowei rewj fioewjf eiows fhjei owhrfi ohfiods fhsd fsdf sdf")
            self._buffInfoLayer:addChild(buffDescribe)

            -- 这里把所有使用一个公用图标给关联起来，方便后面释放
            if(oldBuffSet) then 
                sp = oldBuffSet.sprite
            end

            local datatable = {
                sprite = sp,
                sprite2 = sp2,
                ID = data.bufferEntityID,
                data = data,
                buffSet = buffSet,
                Timer = buffTimer,
                Timer2 = buffTimer2,
                name = buffName,
                describe = buffDescribe
            }

            if buffer:isGood() then
                if(buffSet == nil or oldBuffSet == nil) then 
                    table.insert(self._normalBuffTabel, 1, datatable)
                    self._buffLayer:addChild(sp)
                    if (buffer:getIsAddNew()) then
                        buffer:setAddNew(false)
                        self:addBuffEffect(sp)
                    end
                    sp:setVisible(false)
                end
                table.insert(self._bufftable, 1, datatable)
            else
                if(buffSet == nil or oldBuffSet == nil) then 
                    table.insert(self._normalDebuffTable, 1, datatable)
                    self._buffLayer:addChild(sp)
                    if (buffer:getIsAddNew()) then
                        buffer:setAddNew(false)
                        self:addBuffEffect(sp)
                    end
                    sp:setVisible(false)
                end
                table.insert(self._debufftable, 1, datatable)
            end

            self._buffInfoLayer:addChild(sp2)
            self:showBuffView()
        end
    end
end

-- 更新buff页面
function HeroPanel:updateBuffView(data)
    -- print("====HeroPanel:updateBuffView====")
    local buffer = data.bufferData
    if data then
        -- 更新buffer，格式：{bufferData (table), bufferEntityID {nubmer}, bufferTargetID (number), overlay (number), leftTime (number)}
        if buffer:isGood() then
            for id, buff in pairs(self._bufftable) do
                if buff.ID == data.bufferEntityID then
                    -- 剩余时间
                    local time = data.leftTime / 1000
                    if not tolua.isnull(buff.Timer) then
                        buff.Timer:stopAllActions()
                        buff.Timer:setPercentage(
                            (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                        )
                        -- if(not self.isPause) then
                            local action = cc.ProgressTo:create(time, 100)
                            -- if(self.isPause) then 
                            --     buff.Timer:stop()
                            -- end
                                buff.Timer:runAction(action)

                        -- Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
                        --     if(not tolua.isnull(buff.Timer)) then 
                        --         buff.Timer:pause()
                        --     end
                        -- end, 2)
                        -- end
                        if self._type ~= UIType.TEAMMATESTATUS then
                            self:addBuffEffect(buff.sprite)
                        end
                    end
                    if not tolua.isnull(buff.Timer2) then
                        buff.Timer2:stopAllActions()
                        buff.Timer2:setPercentage(
                            (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                        )
                        local action2 = cc.ProgressTo:create(time, 100)
                        buff.Timer2:runAction(action2)
                    end
                end
            end
        else
            for id, buff in pairs(self._debufftable) do
                if buff.ID == data.bufferEntityID then
                    -- 剩余时间
                    local time = data.leftTime / 1000
                    if not tolua.isnull(buff.Timer) then
                        buff.Timer:stopAllActions()
                        buff.Timer:setPercentage(
                            (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                        )
                        local action = cc.ProgressTo:create(time, 100)
                        buff.Timer:runAction(action)
                        self:addBuffEffect(buff.sprite)
                    end
                    if not tolua.isnull(buff.Timer2) then
                        buff.Timer2:stopAllActions()
                        buff.Timer2:setPercentage(
                            (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                        )
                        local action2 = cc.ProgressTo:create(time, 100)
                        buff.Timer2:runAction(action2)
                    end
                end
            end
        end
        self:showBuffView()
    end
end

function HeroPanel:removeOneInfoBuff(buff)
    buff.sprite2:removeFromParent()
    buff.name:removeFromParent()
    buff.describe:removeFromParent()

    buff.sprite2 = nil
    -- buff.ID = nil
    -- buff.Timer = nil
end

function HeroPanel:removeOneIconBuff(buff)
    if(not tolua.isnull(buff.sprite)) then
        buff.sprite:removeFromParent()
    end

    buff.sprite = nil
end

-- 移除buff页面
function HeroPanel:removeBuffView(data)
    -- print("====HeroPanel:removeBuffView====")
    local buffer = data.bufferData
    if data then
        -- 添加buffer，格式：{bufferData (table), bufferEntityID {number}, bufferTargetID (number)
        if buffer:isGood() then
            local removeID = nil
            local removeBuff = nil
            for id, buff in pairs(self._bufftable) do
                if buff.ID == data.bufferEntityID then
                    self:removeOneInfoBuff(buff)
                    removeID = id
                    removeBuff = buff
                    break
                end
            end
            if (removeID) then
                table.remove(self._bufftable, removeID)
                if not self:getBuffSetFromAllTable(removeBuff.buffSet) then 
                    self:removeOneIconBuff(removeBuff)
                    self:removeBuffSetFromNormalTable(removeBuff)
                end
            end
        else
            local removeID = nil
            local removeBuff = nil
            for id, buff in pairs(self._debufftable) do
                if buff.ID == data.bufferEntityID then
                    self:removeOneInfoBuff(buff)
                    removeID = id
                    removeBuff = buff
                    break
                end
            end

            if (removeID) then
                table.remove(self._debufftable, removeID)
                if not self:getBuffSetFromAllTable(removeBuff.buffSet) then 
                    self:removeOneIconBuff(removeBuff)
                    self:removeBuffSetFromNormalTable(removeBuff.buffSet)
                end
            end
        end
        self:showBuffView()
    end
end

-- 显示buff页面
function HeroPanel:showBuffView()
    -- print("====HeroPanel:showBuffView====")
    if self._type == UIType.TEAMMATESTATUS or self._type == UIType.PETSTATUS or self._type == UIType.PET_SITE_UNLOCK or self._type == UIType.PET_NULL then
        self:showBuffViewTeammat()
        return
    end


    local k = 1
    for id, buff in pairs(self._normalBuffTabel) do
        -- 控制要显示的buff数量
        if k < SHOW_BUFFER_NUM then
            if not tolua.isnull(buff.sprite) then
                -- print("====", id)
                buff.sprite:setVisible(true)
                buff.sprite:setPosition(
                    cc.p(17 + (buff.sprite:getContentSize().width + 2) * (k - 1), buff.sprite:getContentSize().height)
                )
                -- 用于计算buff的位置
                k = k + 1
            end
        end
    end

    local k = 1
    for id, buff in pairs(self._normalDebuffTable) do
        if k < SHOW_BUFFER_NUM then
            if not tolua.isnull(buff.sprite) then
                -- print("====", id)
                buff.sprite:setVisible(true)
                buff.sprite:setPosition(cc.p(17 + (buff.sprite:getContentSize().width + 2) * (k - 1), -2))
                k = k + 1
            end
        end
    end
    if table.nums(self._bufftable) + table.nums(self._debufftable) <= 0 and self._buffInfoLayer then
        self._buffInfoLayer:setVisible(false)
    end
    if (self._buffInfoLayer and self._buffInfoLayer:isVisible()) then
        self:showBuffInfo()
    end
end

function HeroPanel:showBuffViewTeammat()
    -- 队友buff界面只显示debuff

    local k = 1
    for id, buff in pairs(self._normalDebuffTable) do
        -- 控制要显示的buff数量
        if k < SHOW_BUFFER_NUM then
            if not tolua.isnull(buff.sprite) then
                -- print("====", id)
                buff.sprite:setVisible(true)
                buff.sprite:setPosition(
                    cc.p(15 + (buff.sprite:getContentSize().width - 2) * (k - 1), buff.sprite:getContentSize().height - 12)
                )
                -- 用于计算buff的位置
                k = k + 1
            end
        end
    end
    if SceneManager:getInstance():isInBigCrack() then
        for id, buff in pairs(self._normalBuffTabel) do
            -- 控制要显示的buff数量
            if k < SHOW_BUFFER_NUM then
                if not tolua.isnull(buff.sprite) then
                    -- print("====", id)
                    buff.sprite:setVisible(true)
                    buff.sprite:setPosition(
                        cc.p(15 + (buff.sprite:getContentSize().width - 2) * (k - 1), buff.sprite:getContentSize().height - 12)
                    )
                    -- 用于计算buff的位置
                    k = k + 1
                end
            end
        end
        return
    end
    
    if table.nums(self._bufftable) + table.nums(self._debufftable) <= 0 and self._buffInfoLayer then
        self._buffInfoLayer:setVisible(false)
    end
    if (self._buffInfoLayer and self._buffInfoLayer:isVisible()) then
        self:showBuffInfo()
    end
end

-- buff详情页面
function HeroPanel:showBuffInfo()
    print("---- HeroPanel:showBuffInfo()-------")
    -- body
    self._buffInfoLayer:setVisible(true)
    self._buffInfoBg:setVisible(true)
    -- 恢复背景原来大小
    self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH, BUFF_BACK_HEIGHT))

    local point = self:convertToWorldSpace(self:getAnchorPointInPoints())

    -- 默认显示buff 和 debuff
    local buffTpye = 2
    -- 初始y的值
    local py = 0
    local num = 0
    -- 这里debuff 和 buff的显示顺序改为相反的
    -- for id, buff in pairs(self._bufftable) do
    for id, buff in pairs(self._debufftable) do
        if buff.sprite2 ~= nil then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)
            -- 默认的x坐标
            local px = -BUFF_BACK_WIDTH / 2 + BUFF_ICON_WIDTH + BUFF_ICON_SPACING
            buff.sprite2:setPosition(cc.p(px, BUFF_BACK_HEIGHT / 2 - BUFF_ICON_WIDTH - py - height / 2))
            buff.name:setPosition(
                cc.p(px + BUFF_ICON_WIDTH * 2 + buff.name:getContentSize().width / 2 - 30, buff.sprite2:getPositionY())
            )
            buff.describe:setPosition(
                cc.p(
                    BUFF_ICON_WIDTH * 3 / 2 + buff.name:getPositionX() + buff.name:getContentSize().width / 2 + 120,
                    buff.sprite2:getPositionY()
                )
            )

            py = py + height + 10
            num = num + 1
        end
    end

    -- buff这列的高度
    local buffHeight = py + BUFF_ICON_WIDTH
    -- 计算buff的个数
    if num > 5 then
        num = 5
    end

    -- 若存在buff的时候，debuff 的x坐标
    -- local  px =  BUFF_ICON_WIDTH + BUFF_ICON_SPACING - 30

    -- 不存在buff
    -- if py == 0  then
    -- debuff 的x坐标
    buffTpye = 1
    px = -BUFF_BACK_WIDTH / 2 + BUFF_ICON_WIDTH + BUFF_ICON_SPACING
    -- end

    -- 初始y的值
    -- local  py = 0

    local debuffnum = 0
    -- for id, buff in pairs(self._debufftable) do
    for id, buff in pairs(self._bufftable) do
        if buff.sprite2 ~= nil then
            local height = math.max(buff.sprite2:getContentSize().height, buff.describe:getContentSize().height)
            height = math.max(height, buff.name:getContentSize().height)

            buff.sprite2:setVisible(true)

            buff.sprite2:setPosition(cc.p(px, BUFF_BACK_HEIGHT / 2 - BUFF_ICON_WIDTH - py - height / 2))
            buff.name:setPosition(
                cc.p(px + BUFF_ICON_WIDTH * 2 + buff.name:getContentSize().width / 2 - 30, buff.sprite2:getPositionY())
            )
            buff.describe:setPosition(
                cc.p(
                    BUFF_ICON_WIDTH * 3 / 2 + buff.name:getPositionX() + buff.name:getContentSize().width / 2 + 120,
                    buff.sprite2:getPositionY()
                )
            )

            py = py + height + 10
            debuffnum = debuffnum + 1
        end
    end
    -- 计算debuff的个数
    if debuffnum > 5 then
        debuffnum = 5
    end

    if num < debuffnum then
        num = debuffnum
    end

    -- debuff这列的高度
    local debuffHeight = py + BUFF_ICON_WIDTH

    -- 如果减益buff不存在
    if py == 0 then
        -- 如果没有增益buff
        if buffTpye == 1 then
            buffTpye = 0
        elseif buffTpye == 2 then
            buffTpye = 1
        end
    end

    if buffTpye == 0 then
        self._buffInfoBg:setVisible(false)
    elseif buffTpye == 1 then
        self._buffInfoBg:setContentSize(cc.size(BUFF_BACK_WIDTH / 2, self._buffInfoBg:getContentSize().height))
        self._buffInfoBg:setPositionX(-BUFF_BACK_WIDTH / 4)
    else
        self._buffInfoBg:setPositionX(0)
    end

    -- 取增益和减益最高的
    if buffHeight > debuffHeight then
        py = buffHeight
    else
        py = debuffHeight
    end

    -- self._buffInfoBg:setContentSize(cc.size(self._buffInfoBg:getContentSize().width, self._buffInfoBg:getContentSize().height * py/ BUFF_BACK_HEIGHT))
    self._buffInfoBg:setContentSize(cc.size(self._buffInfoBg:getContentSize().width, py - BUFF_ICON_WIDTH))
    self._buffInfoBg:setPositionY((BUFF_BACK_HEIGHT - py) / 2 - 5)
    self._directionImage:setPosition(
        -BUFF_BACK_WIDTH / 2 - 3,
        self._buffInfoBg:getPositionY() + self._buffInfoBg:getContentSize().height / 2 - 30
    )

    --  x  方向的偏移量
    local px = (BUFF_ICON_WIDTH + 2) * num
    if self._type == UIType.TEAMMATESTATUS then
        if(not tolua.isnull(self._buffLayerParent)) then 
            point = self._buffLayerParent:Local2Global()
        end
        self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2, -BUFF_BACK_HEIGHT / 2 + (size.height - point.y) - (BUFF_BACK_HEIGHT - py)/2)
    elseif self._type == UIType.PETSTATUS then
        self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + px - 50, -BUFF_BACK_HEIGHT / 2 + 45)
    else
        self._buffInfoLayer:setPosition(WIDTH + BUFF_BACK_WIDTH / 2 + px, -BUFF_BACK_HEIGHT / 2 + 70)
    end
end

--隐藏复活按钮
function HeroPanel:onResurgenceCallBack()
    -- print("HeroPanel:onResurgenceCallBack")
    self:barAndBuffVisible(true)

    if self._resurgenceLayer then
        self._resurgenceLayer:setVisible(false)
    end

    -- add by zp 在复活后，需要等到服务器通知是否复活完成，这里会导致表现问题
    -- self._dieState = false
    -- if self._dead then
    --     self._dead:setVisible(false)
    -- end
    -- self:changeLight()

    -- if self._buffLayer then
    --     self._buffLayer:setVisible(true)
    -- end

    -- if(self.mMercenaryText) then 
    --     self.mMercenaryText:removeFromParent(true)
    --     self.mMercenaryText = nil
    -- end

    if self.mBtnResurgence and not tolua.isnull(self.mBtnResurgence) then
        self.mBtnResurgence:disable()
        self.mBtnResurgence:setVisible(false)
    end
end

function HeroPanel:barAndBuffVisible(flag)
    self._hpLabel:setVisible(flag) -- 英雄血量
    self._mpLabel:setVisible(flag) -- 英雄蓝量

    -- 血条，蓝条
    self._booldTimer:setVisible(flag)
    

    self._buffLayer:setVisible(flag) -- buff页面
    if self._type == UIType.PETSTATUS then
        -- self._roleName:setVisible(flag)
        self._mpTimer:setVisible(self._data:getSiteId() == 0)
    else
        self._mpTimer:setVisible(flag)
        self._xpTimer:setVisible(flag)
    end
end

--显示复活按钮
function HeroPanel:showResurgence()
    print("HeroPanel:showResurgence")
    -- 隐藏血条和buff面板
    self:barAndBuffVisible(false)
    -- print("HeroPanelshowResurgence111:", MasterDataManager:getPetReviveTimes())
    local reviveTimes = nil
    if self._data.siteId == 0 then
        reviveTimes = MasterDataManager:getPetReviveTimes()
    else
        local reviveData = MasterDataManager:getPetSiteReviveTimes()
        reviveTimes = reviveData[self._data.siteId] or 0
    end
    if self._type == UIType.PETSTATUS and reviveTimes >= 1 then
        if  self._resurgenceLayer then
            self._resurgenceLayer:setVisible(false)
        end   
        self:barAndBuffVisible(true)
        return
    end

    if SceneManager:getInstance():isInBigCrack() then
        if  self._resurgenceLayer then
            self._resurgenceLayer:setVisible(false)
        end
        return
    end

    if(TeamDataManager:hasMercenaryTeam() and self._type == UIType.TEAMMATESTATUS) then 
        if(self.mercenaryLayout == nil) then
            self.mercenaryLayout = UI.Layout:create()
            self.mercenaryLayout:init()
            -- self.mercenaryLayout:leftUp(45, 55)
            self.mercenaryLayout:leftUp(40, 63)
            -- self.mMercenaryText:enableDebugDraw()
            self:addChild(self.mercenaryLayout, 100)
        end

        if(self.mMercenaryText == nil) then
            -- 添加倒计时刷新
            local roleData = RoleDataManager:getHeroDataForPK(self:getPK())
            self._mStartTime = 0
            if(roleData) then
                self._mStartTime = roleData:getDeadTime() or 0
            end
            local totalTime = mvc.mercenaryModel:getMercenaryReviveTimeSeconds()

            self.mMercenaryText = UI.Text:create()
            self.mMercenaryText:init(tostring(math.floor(totalTime - (AvalonUtil.getCurrentTime() - self._mStartTime) / TIME_UNIT)), UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_227_214_172)
            self.mMercenaryText:useDefaultOutLineShadowStyle()
            self.mMercenaryText:center()
            -- self.mMercenaryText:leftUp(25, 48)
            -- print("getContentSize=", self.mMercenaryText:getContentSize())
            -- self.mMercenaryText:enableDebugDraw()
            self.mercenaryLayout:addChild(self.mMercenaryText, 100)

            local action =
                cc.Sequence:create(
                cc.DelayTime:create(1),
                cc.CallFunc:create(handler(self, function()
                    local lossTime = totalTime - (AvalonUtil.getCurrentTime() - self._mStartTime) / TIME_UNIT
                    print("lossTime=", lossTime)
                    if(self.mMercenaryText and not tolua.isnull(self.mMercenaryText)) then
                        if(lossTime>0) then
                            self.mMercenaryText:setText(tostring(math.floor(lossTime)))
                        else
                            self.mMercenaryText:removeFromParent(true)
                            self.mMercenaryText = nil
                        end
                    end
                end))
            )
            self.mMercenaryText:runAction(cc.RepeatForever:create(action))
        end
        return 
    end

    if not self._resurgenceLayer then
        self._resurgenceLayer = cc.Layer:create()
        self._resurgenceLayer:setContentSize(cc.size(WIDTH, HEIGHT))
        self._resurgenceLayer:setPosition(cc.p(74, -14))
        self:addChild(self._resurgenceLayer, 100)
        self._resurgenceLayer:setVisible(false)

        self.mBtnResurgence = UI.Button:create()
        self.mBtnResurgence:init(
            "ui_dead_button_resurrection.png",
            "ui_dead_button_resurrection.png",
            "ui_dead_button_resurrection.png"
        )
        -- self.mBtnResurgence:setPos(0, 85 - self.mBtnResurgence._height)
        self.mBtnResurgence:leftBottom(-90, -35)
        self.mBtnResurgence:setScale(0.6)
        self.mBtnResurgence:addEventListener(UIEvent.BUTTON_CLICK, self, self.onResurgence)
        self._resurgenceLayer:addChild(self.mBtnResurgence)

        local picBg = UI.Image:create()
        picBg:init("symbol_gaming_diamond.png")
        picBg:centerUp(23 - picBg:getContentSize().height / 2)
        self.mBtnResurgence:addChild(picBg, 20)
        self._picBg = picBg

        self.mTxtResurgence = UI.Text:create()
        self.mTxtResurgence:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_227_214_172)
        self.mTxtResurgence:centerLeft(picBg:getContentSize().width + 4)
        -- self.mTxtResurgence:setTextCenter()
        picBg:addChild(self.mTxtResurgence, 100)

        self._resurgencePro =
            cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_dead_progressbar_resurrection_10.png"))
        self._resurgencePro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        self._resurgencePro:setMidpoint(cc.p(0, 0))
        self._resurgencePro:setBarChangeRate(cc.p(1, 0))
        self._resurgencePro:setPosition(cc.p(self.mBtnResurgence._width / 2, 18))
        self._resurgencePro:setPercentage(100)
        self.mBtnResurgence:addChild(self._resurgencePro, 20)

        local txtResurgence = UI.Text:create()
        if self._type == UIType.PETSTATUS then
            txtResurgence:init(UI.TEXT_1213412, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
             self._resurgenceLayer:setPosition(cc.p(74, -5))
        else
            txtResurgence:init(UI.TEXT_1110370, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
        end
        txtResurgence:centerBottom(-txtResurgence:getContentSize().height + 12)
        -- txtResurgence:setOutline(UI.FONT_COLOR_BLACK)
        txtResurgence:setTextCenter()
        self.mBtnResurgence:addChild(txtResurgence, 100)
    end

   
    if (not self._resurgenceLayer:isVisible()) then 
        self._resurgenceLayer:setVisible(true)
        self.mBtnResurgence:enable()
        self.mBtnResurgence:setScale(0.6)
        self.mBtnResurgence:setVisible(true)
        self._resurgencePro:stopAllActions()
        self._resurgencePro:setPercentage(100)
        if self._type ~= UIType.PETSTATUS then
            local action =
                cc.Sequence:create(
                cc.ProgressTo:create(CAVE_REVIVE_WAITING_TIME, 0),
                cc.CallFunc:create(handler(self, self.resurgenceTimeOutCallBack))
            )
            self._resurgencePro:runAction(action)
        end
        self:refreshResurgence()
    end
end

function HeroPanel:refreshResurgence()
    if (self._resurgenceLayer) then
        -- body
        if self._type == UIType.PETSTATUS then
            local itemId, cost = RoleDataManager:getMaster():getRevivePetCost()
            self.mTxtResurgence:setFontColor(UI.FONT_COLOR_227_214_172)
            if itemId ~= 0 then
                local itemData = GoodsDataManager:createLocalGoodsData(itemId)
                self._picBg:setSpriteName(itemData:getSmallIconName())
            else
                self._picBg:setSpriteName("symbol_gaming_diamond.png")
                if not Avalon.MathUtil:checkDiamonEnough(cost, GameDataManager:getInstance():getDiamond()) then
                    self.mTxtResurgence:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
                end
            end
            self.mTxtResurgence:setText(cost)
        else
            local roleData = RoleDataManager:getHeroDataForPK(self:getPK())
            if roleData then
                local need = roleData:getReviveEndDiamond()
                self.mTxtResurgence:setText(tostring(need))
               

                if Avalon.MathUtil:checkDiamonEnough(tonumber(need), GameDataManager:getInstance():getDiamond()) then
                    self.mTxtResurgence:setFontColor(UI.FONT_COLOR_227_214_172)
                else
                    self.mTxtResurgence:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
                end
            end
        end
        if (self._picBg) then
            self._picBg:leftUp(self.mBtnResurgence:getContentSize().width / 2 -(self._picBg:getContentSize().width + self.mTxtResurgence:getContentSize().height + 4) / 2,23 - self._picBg:getContentSize().height / 2)
        end
    end
end

--复活
function HeroPanel:onResurgence()
    -- print("HeroPanel:onResurgence")
    local roleData = RoleDataManager:getHeroDataForPK(self:getPK())
    if self._type == UIType.PETSTATUS then
        local itemId, cost = RoleDataManager:getMaster():getRevivePetCost()
        if itemId ~= 0 then
            -- Net.NetPetSystem:revive(self._data:getSpriteID())
            Net.NetPetSystem:revive(self._data:getPetInstId())
            self.mBtnResurgence:disable()
            self.mBtnResurgence:setVisible(false)
        else
            if Avalon.MathUtil:checkDiamonEnough(cost, GameDataManager:getInstance():getDiamond()) then
                Net.NetPetSystem:revive(self._data:getPetInstId())
                self.mBtnResurgence:disable()
                self.mBtnResurgence:setVisible(false)
            else
                UI.TipsLayer:onDiamondNotEnough()
            end
        end
    elseif roleData then
        local need = roleData:getReviveEndDiamond()
        if Avalon.MathUtil:checkDiamonEnough(tonumber(need), GameDataManager:getInstance():getDiamond()) then
            GameManager:battleReviveHelp(roleData:getSpriteID(), need)
            -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_HELP_REVIVE, self._data)
            self.mBtnResurgence:disable()
            self.mBtnResurgence:setVisible(false)
        else
            UI.TipsLayer:onDiamondNotEnough()
        end
    else
        UI.Tips:createTips(
            UI.TEXT_1110372 .. "HeroPanel:onResurgence",
            UI.TipsType.CONFIRM_AND_CANCEL,
            UI.TipsUiType.NORMAL
        )
    end
end

--复活倒计时结束
function HeroPanel:resurgenceTimeOutCallBack()
end

-- 等待加入
function HeroPanel:waitJoin()
    self._waitJoinState = true

    self._avatar_SP:setVisible(true)
    if self._heroIcon and not tolua.isnull(self._heroIcon) then
        self._heroIcon:setVisible(false)
    end
    self._booldTimer:setPercent(0)
    self._booldTimer:hide()
    self._mpTimer:setPercent(0)
    self._xpTimer:hide()
    self._hpLabel:hide()
    self._mpLabel:hide()
    self._equipmentType:hide()

    self._lvLabel:setText("...")
    self._lvLabel:leftBottom(-36, -6)
    self._off_line:hide()

    --等待加入

    self._waitJoinLabel = UI.Text:create()
    self._waitJoinLabel:init(UI.TEXT_1212043, UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    self._waitJoinLabel:setFontSize(15)
    self._waitJoinLabel:setSize(100, 50)
    self._waitJoinLabel:leftBottom(100, 3)
    self._waitJoinLabel:setTextCenter()
    self._waitJoinLabel:setFontColor(UI.FONT_COLOR_255_255_255)
    self:addChild(self._waitJoinLabel, 100)
    self._avatar_black:setSpriteName("ui_playerstate_teammate_black.png")
    self._avatar_black:centerLeft(6)
end

-- 等待匹配
function HeroPanel:waitMate()
    -- print("HeroPanel:waitMate")
    self._waitMateState = true

    self._avatar_SP:setVisible(true)
    if self._heroIcon and not tolua.isnull(self._heroIcon) then
        self._heroIcon:setVisible(false)
    end
    self._booldTimer:setPercent(0)
    self._booldTimer:hide()
    self._mpTimer:hide()
    self._xpTimer:hide()
    self._equipmentType:hide()
    self._lvLabel:setText("...")
    self._lvLabel:leftBottom(-36, -6)
    self._hpLabel:hide()
    self._mpLabel:hide()

    self._roleName:hide()
    self._off_line:hide()

    if self._search == nil then
        self._search = UI.Animation:create()
        self._search:init("effect_ui_gaming_playerstate_search.json", "effect_ui_gaming_playerstate_search.atlas")
        self._search:centerLeft(40)
        self._search:setScale(0.83)
        self:addChild(self._search, ZORDER_HERO_PANEL_ANIMATION)
    end

    if TeamDataManager:getReadyState() == true then
        self._search:setAnimation("showup", false)
        self._search:addAnimation("loop", true)
    else
        self._search:play("idle", true)

        self._disabel = false
    end
    -- 英雄模式不能请求组队
    if (SceneManager:getInstance():isInHero() or SceneManager:getInstance():isInTitanHero()) then
        self._search:setVisible(false)
    else
        self._search:setVisible(true)
    end

    self._avatar_black:setSpriteName("ui_playerstate_teammate_black.png")
    self._avatar_black:centerLeft(6)
end

--请求匹配
function HeroPanel:requestMatch()
    if SceneManager:getInstance():isInDungeon()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGuildBoss()
        or SceneManager:getInstance():isGhostAbyss()
        or SceneManager:getInstance():isActCave() then
        return
    end

    Avalon.AudioManager:playSound("1503")
    if TeamDataManager:hasTeam() then
        local _teamData = TeamDataManager:getTeamData()
        for k, v in pairs(_teamData) do
            if v:getState() ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                UI.ScrollBar:createByText(UI.TEXT_1110379)
                return
            end
        end
    end

    if not TeamDataManager:hasTeam() then
        local mapData = GameMapManager:getInstance():getMapData()

        Net.NetTeamSystem:createTeam(
            mapData:getCaveMode(),
            mapData:getDifficulty(),
            LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(mapData:getLevel())
        )
    end
    Net.NetTeamSystem:requestMatch()

    if self._search == nil then
        self._search = UI.Animation:create()
        self._search:init("effect_ui_gaming_playerstate_search.json", "effect_ui_gaming_playerstate_search.atlas")
        self._search:centerLeft(40)
        self._search:setScale(0.83)
        self:addChild(self._search, ZORDER_HERO_PANEL_ANIMATION)
    end

    self._disabel = true
end

--匹配中
function HeroPanel:notifySearchMatch()
    if self._search then
        self._search:setAnimation("showup", false)
        self._search:addAnimation("loop", true)
    end
    self._disabel = true
end

--取消匹配
function HeroPanel:cancelMatch()
    -- print("HeroPanel:cancelMatch")
    if self._search then
        self._search:setAnimation("idle", true)
    end
    self._disabel = false
end

function HeroPanel:showQuickChatTips(text)
    if self.quickChatTips then
        self.quickChatTips:removeFromParent()
    end
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(220, 55)
    self:addChild(layout, 100)

    local arrow = UI.Image:create()
    arrow:init("ui_tips_banner_arrow.png")
    arrow:leftUp(-arrow:getContentSize().width, 10)
    layout:addChild(arrow)

    local bg = UI.Image:create()
    bg:init("ui_chat_paperbox.png")
    layout:addChild(bg)

    local textLabel = UI.Text:create()
    textLabel:init(text, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    textLabel:setWidth(190)
    layout:addChild(textLabel)
    textLabel:autoAdapt()

    -- if textLabel:getContentSize().height > 50 then
    layout:setSize(220, textLabel:getContentSize().height + 36)
    bg:setScaleX(220 / 449)
    bg:setScaleY((textLabel:getContentSize().height + 36) / 95)
    -- else
    --     bg:setScaleX(layout:getContentSize().width / 449)
    --     bg:setScaleY(layout:getContentSize().height / 95)
    -- end
    bg:centerLeft((1 - bg:getScaleX()) * -449 / 2)
    textLabel:centerLeft(22)
    layout:leftUp(85, 55)
    -- textLabel:enableDebugDraw(UI.RED)
    self.quickChatTips = layout

    local fadeOutAction = cc.FadeOut:create(1)
    local delayAction = cc.DelayTime:create(2)
    layout:runAction(
        cc.RepeatForever:create(
            cc.Sequence:create(
                delayAction,
                fadeOutAction,
                cc.RemoveSelf:create(),
                cc.CallFunc:create(
                    function()
                        self.quickChatTips = nil
                    end
                )
            )
        )
    )
end
