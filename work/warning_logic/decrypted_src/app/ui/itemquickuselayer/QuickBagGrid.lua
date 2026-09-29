--[[
    快捷动作条中的小格子
    Author：CZH
]]
UI = UI or {}
local QuickBagGrid = class("QuickBagGrid",UI.ListGrid)
UI.QuickBagGrid = QuickBagGrid

local size = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")

local QuickBarGrid_SIZE = {
  X = 0,
  Y = 0,
  WIDTH = 70,
  HEIGHT = 70
}

-- 选择快捷背包道具的光圈效果SPINE
local ITEMSELECT_JSON =  "effect_ui_gaming_itemselect.json"
local ITEMSELECT_ATLAS = "effect_ui_gaming_itemselect.atlas"

-- 技能冷却蒙版
local SKILL_SP_COOLD_1 = "ui_btn_gaming_battleskill_cooldown01.png"
local SKILL_SP_COOLD_2 = "ui_item_banner_black.png"

-- 快捷背包用到的资源
local GAME_ITEM_RES_LIST = {
}

-- 背包物品格子背景图片
local QUICK_PG_BG =  "ui_quickPanel_banner_itemuse.png"

-- 格子层级
local ZORDER_BAG_GRID_SPINE = 1
local ZORDER_GRID_ICON = 2
local ZORDER_BAG_GRID_SPINE_CD = 5

--边框形状 1；圆 2:方
BORDER_SHAPE = {
    CIRCULAR = 1,
    SQUARE = 2
}

function QuickBagGrid:ctor(type)

    QuickBagGrid.super.ctor(self, 
    GAME_ITEM_RES_LIST,
    0,
    0,
    true)
    self._data = nil
    self._itemIcon = nil -- 道具图片
    self._itemConut = nil -- 物品数量图片
    self._itemConutBar = nil -- 物品数量图片
    self._bgSprite = nil -- 快捷背包格子背景图片
    self._item_Select_Spine = nil
    self._gridType     = 0
    self._coolDownTime = 0 
    self._usable = true
    self._timer = nil
    self._cdTime = nil 
    self._isGray = false --是否是灰调状态
    self._lastTime = 0 --上次执行cd时间
    self._clipper = nil
    self.doClip = false
    self.countFlag = true

    self._isLock = false
    self._shapeType = BORDER_SHAPE.SQUARE

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
end

function QuickBagGrid:dtor()
    self._gridType  = nil
    self._data = nil
    self._itemIcon = nil -- 道具图片
    self._itemConut = nil -- 物品数量图片
    self._itemConutBar = nil -- 物品数量图片
    self._bgSprite = nil -- 快捷背包格子背景图片
    self._item_Select_Spine = nil
    self._isGray = false --是否是灰调状态
    self._lastTime = 0 --上次执行cd时间
    self._clipper = nil
    self.doClip = false
    self._shapeType = BORDER_SHAPE.SQUARE
    -- self._timer = nil
    QuickBagGrid.super.dtor(self)
    self:unbindAllEvent()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
end

function QuickBagGrid:unbindAllEvent()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SUCCECD_USE_IRONPICKAXE_CLICK,self, self.runTQPublicCD)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_USED_TOTOWN_CONFIRM,self, self.runToTownPublicCD)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SUCCECD_USE_SKILL,self, self.runPublicCD)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SUCCECD_USE_TWICE_SKILL,self, self.lockUse)
end

function QuickBagGrid:init(data,gridType)
    if (data) then
        self:setData(data)
    end
    if gridType then 
        self._gridType = gridType
    end
    QuickBagGrid.super.init(self)
end

function QuickBagGrid:setShapeType(shapeType)
    self._shapeType = shapeType
    if self._shapeType == BORDER_SHAPE.CIRCULAR then
        self._item_Select_Spine:setPosition(self._hw, self._hh)
        self:addItemCirCircularCap()
        local sprite = cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_2)
        sprite:setOpacity(160)
        self._timer:setSprite(sprite)
        -- self._timer:show()
        self._timer:setPosition(self._hw, self._hh)
        self._timer:setScale(1.2)
    elseif self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setPosition(self._hw, self._hh)

        self._timer:setSprite(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
        self._timer:setPosition(self._hw, self._hh)
        self._timer:setScale(1)
    end
end

-- 点击背包格子选中一直出现的SPINE效果
function QuickBagGrid:showItemSelectSpine()
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE)
    self._item_Select_Spine:setAnimation(0,"showup_square", false)
    self._item_Select_Spine:addAnimation(0,"loop_square", true)
    self._item_Select_Spine:setVisible(true)
end
-- 拖动物品开始的效果
function QuickBagGrid:startItemSelectSpine()
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE)
    self._item_Select_Spine:setAnimation(0,"showup_square", false)
    self._item_Select_Spine:setVisible(true)
end
-- 拖动物品中的效果
function QuickBagGrid:moveItemSelectSpine()
    -- print("---QuickBagGrid:moveItemSelectSpine()")
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE)
    self._item_Select_Spine:addAnimation(0,"loop_square", true)
    self._item_Select_Spine:setVisible(true)
end

--拖动物品完成后的效果
function QuickBagGrid:endItemSelectSpine()
    print("---QuickBagGrid:endItemSelectSpine()")
    -- self._item_Select_Spine:addAnimation(0,"end_square", false)
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE)
    self._item_Select_Spine:setAnimation(0,"end_square", false)
    self._item_Select_Spine:setVisible(true)
end

--设置不可见
function QuickBagGrid:setVisiableFalse()
    self._item_Select_Spine:setVisible(false)
end

-- 双击使用背包道具SPINE效果
function QuickBagGrid:useItemSelectSpine()
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE)
    self._item_Select_Spine:setAnimation(0,"start_square", false)
    self._item_Select_Spine:setVisible(true)
end


-- 拖动物品开始的动画 
function QuickBagGrid:startSelectDownSpine()
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"showup_square", false)
    else
        self._item_Select_Spine:setAnimation(0,"showup_circle", false)
    end
    self._item_Select_Spine:setVisible(true)
end

-- 拖动物品中的动画 
function QuickBagGrid:moveSelectDownSpine()
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:addAnimation(0,"loop_square", true)
    else
        self._item_Select_Spine:addAnimation(0,"loop_circle", true)
    end
    self._item_Select_Spine:setVisible(true)
end

--  拖动物品完成后的动画
function QuickBagGrid:endSelectDownSpine()
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"end_square", false)
    else
        self._item_Select_Spine:setAnimation(0,"end_circle", false)
    end
    self._item_Select_Spine:setVisible(true)
end

-- 点击空格子后的Spine效果 移动过来的啊
function QuickBagGrid:barItemSelectDownSpine()
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"showup_square", false)
        self._item_Select_Spine:addAnimation(0,"end_square", false)
    else
        self._item_Select_Spine:setAnimation(0,"showup_circle", false)
        self._item_Select_Spine:addAnimation(0,"end_circle", false)
    end
    self._item_Select_Spine:setVisible(true)
end

-- 打开背包，点击格子选中一直出现的SPINE效果
function QuickBagGrid:showItemSelectDownSpine()
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"showup_square", false)
        self._item_Select_Spine:addAnimation(0,"loop_square", true)
    else
        self._item_Select_Spine:setAnimation(0,"showup_circle", false)
        self._item_Select_Spine:addAnimation(0,"loop_circle", true)
    end
    self._item_Select_Spine:setVisible(true)
end

--快捷栏（DOWN）隐藏SPINE
function QuickBagGrid:setVisibleFalseSpine()
    self._item_Select_Spine:setVisible(false)
    self._item_Select_Spine:clearTrack()
    self._item_Select_Spine:setToSetupPose()
end

-- 使用道具 的SPINE效果
function QuickBagGrid:itemUseSpine()
    if not self._itemIcon:isVisible() then
        return
    end
    self._item_Select_Spine:setVisible(true)
    self._item_Select_Spine:setZOrder(ZORDER_BAG_GRID_SPINE_CD)
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"renew_square", false)
    else
        self._item_Select_Spine:setAnimation(0,"renew_circle", false)
    end

end

-- 使用物品的SPINE效果(快捷栏底部动画)
function QuickBagGrid:barItemUseSpine()
    if self._isGray then
        return
    end
    if self._shapeType == BORDER_SHAPE.SQUARE then
        -- self.item_Use:setAnimation(0,"animation", false)
        self._item_Select_Spine:setAnimation(0,"start_square", false)
        self._item_Select_Spine:addAnimation(0,"end_square", false)
    else
        -- self.item_Use:setAnimation(0,"animation_1", false)
        self._item_Select_Spine:setAnimation(0,"start_circle", false)
        self._item_Select_Spine:addAnimation(0,"end_circle", false)
    end
    -- self.item_Use:setVisible(true)
    self._item_Select_Spine:setVisible(true)
end

function QuickBagGrid:removeData(data)
    self._itemIcon:setVisible(false)
    self._itemConut:setVisible(false)
    self._bgSprite:setVisible(false)
end

-- 技能使用后的效果（显示选中）
function QuickBagGrid:barSkillUseSpine()
    self._item_Select_Spine:setVisible(true)
    if self._shapeType == BORDER_SHAPE.SQUARE then
        self._item_Select_Spine:setAnimation(0,"start", false)
    else
        self._item_Select_Spine:setAnimation(0,"start_1", false)
    end
end

function QuickBagGrid:onInitView(data,gridType)
    local item_Select = sp.SkeletonAnimation:create(ITEMSELECT_JSON, ITEMSELECT_ATLAS)
    item_Select:setPosition(35, 35)
    -- item_Select:setPosition(cc.p(40, 38))
    self:addChild(item_Select, ZORDER_BAG_GRID_SPINE)

    -- 快捷背包格子背景
    local bgSprite = cc.Sprite:create()
    bgSprite:initWithSpriteFrameName(QUICK_PG_BG)
    self:addChild(bgSprite, ZORDER_GRID_ICON)
    bgSprite:setPosition(self._hw, self._hh)

    -- 道具图片
    local itemIcon = cc.Sprite:create()
    self:addChild(itemIcon, ZORDER_GRID_ICON)

    local clipper = UI.ClippingNode:create()
    clipper:initWithSprite("ui_item_banner_black.png", 0.01)
    -- clipper:leftBottom(-5, -9)
    clipper:center()
    self:addChild(clipper,  ZORDER_GRID_ICON)
    self._clipper = clipper

    -- 快捷背包的物品数量
    local itemConut = UI.Text:create()
    itemConut:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_220_220)
    itemConut:rightBottom(0, 0)
    itemConut:setSize(60,20)
    itemConut:setTextRight()
    self._itemConut = itemConut 
    self:addChild(self._itemConut, 100)

    -- 快捷动作条的物品数量
    local itemConutBar = UI.Text:create()
    itemConutBar:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_220_220)
    itemConutBar:setSize(60,20)
    itemConutBar:rightBottom(8, -5)
    itemConutBar:setTextRight()

    self._itemConutBar = itemConutBar 
    self:addChild(self._itemConutBar, 100)
    -- self:enableDebugDraw()

    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    -- timer:setMidpoint(cc.p(0, 0))
    -- timer:setBarChangeRate(cc.p(0, 1))
    timer:setPercentage(0)
    timer:setPosition(self._hw, self._hh)
    self:addChild(timer,999) 
    timer:setVisible(false)
    self._timer = timer 

    self._item_Select_Spine = item_Select
    self._itemIcon = itemIcon
    self._bgSprite = bgSprite

    self._item_Select_Spine:setVisible(false)
    self._itemConutBar:setVisible(false)
    self._itemConut:setVisible(false)
    self._bgSprite:setVisible(false)
    -- self:enableDebugDraw(UI.YELLOW)
end

-- 复制一个Grid
function QuickBagGrid:copy(gridType)
    
    local newQuickBagGrid = UI.QuickBagGrid:create()
    newQuickBagGrid:init(self._data,gridType)
    newQuickBagGrid:setSize(70, 70)
    return newQuickBagGrid
end

function QuickBagGrid:setData(data)
    if data then
        self._data = data
    end
    
end

function QuickBagGrid:getData( data )
    -- body
    return self._data
end

function QuickBagGrid:onUpdateView(data,gridType)
    if (data) then self._data = data
    end
    data = self._data
    local heroData = RoleDataManager:getMaster()
    local fsmState = heroData:getState()
    self._bgSprite:setSpriteFrame(QUICK_PG_BG)
    if(data) then
        local banImage = self:getChildByName("ui_btn_gaming_battleskill_ban")
        if(banImage) then 
            banImage:setVisible(false)
        end

        if not gridType then gridType = self._gridType end 
        if gridType == GridType.BAR then
            self._gridType = gridType
            if(data:isNull() == false) then
                local iconName = data:getIconName()
                local count = data:getNum()
                -- self._itemConutBar:enableDebugDraw(UI.YELLOW)
                
                self._itemIcon:setSpriteFrame(iconName)
                self._itemIcon:setVisible(true)
                self._coolDownTime = data:getData():getCooldown() 
                self._itemIcon:setPosition(self._hw, self._hh)
                -- self.item_Use:setPosition(self._hw, self._hh)
                self._timer:setPosition(self._hw, self._hh)

                if(data:isSkill() == true) then
                    self._itemConutBar:setVisible(false)
                    
                    if fsmState == FSMState.BATTLE then
                        self:useShader(UI.COMPONENT_GRAY_SHADER)
                    else
                        -- print("--技能需要的蓝BAR--data:getData():getMPCost()--",data:getData():getMPCost())
                        -- 处理禁用技能
                        local checkInDisableSituation = GameDataManager:getInstance():checkInDisableSituation(data:getData():getDisableSituation())
                        if checkInDisableSituation then
                            self:useShader(UI.COMPONENT_GRAY_SHADER)
                        else
                            local costMp =  MasterDataManager:calculationSkillMp(data:getData(), data:getData():getMPCost(), PublicDefine.EObjectType.Hero)
                            if(heroData:getCurMp() < costMp) then 
                                self:useShader(UI.COMPONENT_GRAY_SHADER)   
                            else
                                self:useShader(UI.COMPONENT_NORMAL_SHADER)
                            end 
                        end
                    end
          

                elseif(data:isItem() == true) then
                    if(self.countFlag) then
                        self._itemConutBar:setVisible(true)
                    else 
                        self._itemConutBar:setVisible(false)
                    end
                    if count <= 999 then
                        self._itemConutBar:setText(string.format("%s",count))
                    else
                        self._itemConutBar:setText(string.format("%s","999+"))
                    end

                    local getDisableSituation = data:getData():getDisableSituation()
                    local checkInDisableSituation =  GameDataManager:getInstance():checkInDisableSituation(getDisableSituation)
               
                    if (data:getNum() <= 0 ) then
                        self:useShader(UI.COMPONENT_GRAY_SHADER)
                    elseif( checkInDisableSituation == true ) then 
                        self:useShader(UI.COMPONENT_GRAY_SHADER)
                        if(RoleDataManager:getMaster():getIsNOUSEITEM()) then 
                            local banImage = self:getChildByName("ui_btn_gaming_battleskill_ban")
                            if(not banImage) then 
                                banImage = UI.Image:create()
                                banImage:init("ui_btn_gaming_battleskill_ban.png")
                                banImage:center()
                                banImage:setName("ui_btn_gaming_battleskill_ban")
                                self:addChild(banImage, 100)
                            else 
                                banImage:setVisible(true)
                            end
                        end
                    -- elseif(data:getData():isNotUseItem() == true ) then 
                    --     self:useShader(UI.COMPONENT_GRAY_SHADER)
                    else
                        self:useShader(UI.COMPONENT_NORMAL_SHADER)
                    end

                end
            else
                self._itemConutBar:setVisible(false)
                self._itemIcon:setVisible(false)
            end 
        elseif  gridType == GridType.BAG then

            self._gridType = gridType
            -- print("==type==",gridType)
            if(data:getCategory() == Category.SKILL) then
                    
                self._bgSprite:setVisible(true)
                self._bgSprite:setPosition(self._hw, self._hh)
                self._coolDownTime = data:getCooldown()

                local iconName = data:getIconName()
                -- print(string.format("QuickBagGrid onUpdateView: icon name is %s.", iconName))
                self._itemIcon:setSpriteFrame(iconName)
                self._itemIcon:setPosition(self._hw, self._hh)
                self._itemIcon:setVisible(true)
                self._timer:setPosition(self._hw, self._hh)
                -- self.item_Use:setPosition(self._hw, self._hh)
                self._itemConut:setVisible(false)

                if fsmState == FSMState.BATTLE then
                    -- print("---11111战斗状态")
                    self:useShader(UI.COMPONENT_GRAY_SHADER)
                else
                    local checkInDisableSituation = GameDataManager:getInstance():checkInDisableSituation(data:getDisableSituation())
                    if checkInDisableSituation then
                        self:useShader(UI.COMPONENT_GRAY_SHADER)
                    else
                        if(heroData:getCurMp() < data:getMPCost()) then 
                            self:useShader(UI.COMPONENT_GRAY_SHADER)    
                        else
                            self:useShader(UI.COMPONENT_NORMAL_SHADER)
                        end 
                    end
                end
            elseif(data:getCategory() == Category.GOODS) then             
                self._bgSprite:setVisible(true)
                self._bgSprite:setPosition(self._hw, self._hh)
                local goodsGroupType = data:getGoodsGroupType()
                if data:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
                    self._bgSprite:setSpriteFrame(string.format("box_quality_%s_%s.png", data:getGoodsGroupType(), data:getGoodsRare()))
                end

                local iconName = data:getIconName()
                -- print(string.format("QuickBagGrid onUpdateView: icon name is %s.", iconName))
                self._itemIcon:setSpriteFrame(iconName)
                self._itemIcon:setPosition(self._hw, self._hh)
                self._itemIcon:setVisible(true)
                self._timer:setPosition(self._hw, self._hh)
                if  data:getNum() <= 999 then
                    self._itemConut:setText(string.format("%s", data:getNum()))   
                else
                    self._itemConut:setText(string.format("%s", "999+")) 
                end

                if(self.countFlag) then
                    self._itemConut:setVisible(true)
                else 
                    self._itemConut:setVisible(false)
                end

                local getDisableSituation = data:getDisableSituation()
                local checkInDisableSituation =  GameDataManager:getInstance():checkInDisableSituation(getDisableSituation)
               
                if (data:getNum() <= 0 ) then
                    self:useShader(UI.COMPONENT_GRAY_SHADER)
                elseif( checkInDisableSituation == true ) then 
                    self:useShader(UI.COMPONENT_GRAY_SHADER)
                    if(RoleDataManager:getMaster():getIsNOUSEITEM()) then 
                        local banImage = self:getChildByName("ui_btn_gaming_battleskill_ban")
                        if(not banImage) then 
                            banImage = UI.Image:create()
                            banImage:init("ui_btn_gaming_battleskill_ban.png")
                            banImage:center()
                            banImage:setName("ui_btn_gaming_battleskill_ban")
                            self:addChild(banImage, 100)
                        else 
                            banImage:setVisible(true)
                        end
                    end
                else
                    self:useShader(UI.COMPONENT_NORMAL_SHADER)
                end
            end
        end
        if self._shapeType == BORDER_SHAPE.CIRCULAR then
            if data:isSkill() then
                self:addItemCirCircularCap()
            else
                self:removeItemCirCircularCap()
            end
            self._timer:setPosition(self._hw, self._hh)
        else
            self._timer:setPosition(self._hw, self._hh)
        end

        if data.targetCdTime then
            local curTime = AvalonUtil.getCurrentTime()
            if data.targetCdTime > curTime then
                local percent = (data.targetCdTime - curTime) / (data.totalTime * 1000) * 100
                self:_runCdAction((data.targetCdTime - curTime), percent, true)
            else
                self:clearCdTime()
            end
        end
    end
end

function QuickBagGrid:clearIcon()
    self._itemIcon:setVisible(false)
    self._itemConut:setVisible(false)
    self._itemConutBar:setVisible(false)
    self._bgSprite:setVisible(false)

    self._timer:stopAllActions()
    self._usable = true
    self._timer:setVisible(false)
    self._timer:setPercentage(0)
end

function  QuickBagGrid:clearData(data)
    self._data = nil
end

function QuickBagGrid:setCountFlag(flag)
    if(flag == nil) then
        flag = true
    end
    self.countFlag = flag
    self._itemConutBar:setVisible(flag)
end

-- 隐藏图片和数字 (移动过来的)
function QuickBagGrid:setVisibleFalse()
    self._itemIcon:setVisible(false)
end

--拖动的时候，只显示ICON
function  QuickBagGrid:setVisibleTrueIcon()
    self._itemIcon:setVisible(true)
    self._itemConut:setVisible(false)
    self._itemConutBar:setVisible(false)
    self._bgSprite:setVisible(false)
end

function QuickBagGrid:setItemCount()
    self._itemConut:setText(string.format("%s",0))
    self._itemConutBar:setText(string.format("%s",0))
    self._data = nil
end

-- 物品使用完
function QuickBagGrid:onUseShader(shader, shaderName)
    if (self._itemIcon) then
        self._itemIcon:setGLProgramState(shader)
        if shaderName == UI.COMPONENT_NORMAL_SHADER then
            self._isGray = false
        elseif  shaderName == UI.COMPONENT_GRAY_SHADER then
            self._isGray = true
        else
            self._isGray = false
        end
    end
end

function QuickBagGrid:isCanRunCdAction()
    if not self._itemIcon:isVisible() then
        return false
    end
    return not self._isGray
end

-- 自身冷却时间
function QuickBagGrid:runCoolDown()
    local time = self._coolDownTime
    self:_runCdAction(time)
end

-- 根据传入参数 冷却时间
function QuickBagGrid:runCoolDownByTime(time)
    self:_runCdAction(time)
end

-- 触发公共CD
function QuickBagGrid:runPublicCD()
    if self._isLock then
        return
    end
    local time = ConfigManager:getPublicCDTime()*1 
    self:_runCdAction(time)
end

-- 触发公共CD
function QuickBagGrid:runTQPublicCD()
    local time = self._coolDownTime --ConfigManager:getPublicCDTime()*1 
    self:_runCdAction(time)
end

-- 触发公共CD
function QuickBagGrid:runTWSkillPublicCD()
    local time = self._coolDownTime --ConfigManager:getPublicCDTime()*1 
    self:_runCdAction(time)
end

-- todo 锁住最多3s，并且等待服务器返回后执行
function QuickBagGrid:lockUse(time)
    self:useShader(UI.COMPONENT_GRAY_SHADER)
    self._isLock = true
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if not tolua.isnull(self) and self._isLock then
            self:useShader(UI.COMPONENT_NORMAL_SHADER)
            self._isLock = false
        end
    end, 3)
end

function QuickBagGrid:runToTownPublicCD()
    if self.runTQPublicCD then
        self:runTQPublicCD() -- 同铁锹
    end
end

--私有函数 禁止外部调用(根据percent 来设置 初始状态)
function QuickBagGrid:_runCdAction(time, percent, isIngoreRecored)
    if self._isLock then
        self._isLock = false
        self:useShader(UI.COMPONENT_NORMAL_SHADER)
        -- return
    end
    if not self:isCanRunCdAction() then
        return
    end
    if self._timer == nil then
        return
    end
    percent = percent or 100
    percent = percent > 100 and 100 or percent
    time = tonumber(time) or 0
    local remainTime = self._timer:getPercentage() / 100 * self._lastTime
    if self._timer:isVisible() and  remainTime >= time then
        return
    end

    if isIngoreRecored == nil then
        isIngoreRecored =  false
    end
    self._timer:stopAllActions()
    self._usable = false
    self._timer:setVisible(true)
    self._timer:setPercentage(percent)
    local to1 = cc.ProgressTo:create(time/1000,0)
    local function CallFucnCallback()
        --播放技能冷却结束动画 
        self:itemUseSpine()
        self._timer:setPercentage(0)
        self._timer:setVisible(false)
        self:setTouchEnable(false)
        self._usable = true
    end
    self._timer:runAction(cc.Sequence:create(to1,cc.CallFunc:create(CallFucnCallback)))
    self._lastTime = time * 100 / percent
    if not isIngoreRecored then
        if self._gridType == GridType.BAR then
            GameDataManager:getInstance():setShcutBarCdList(self._data:getId(), time / 1000)
        elseif self._gridType == GridType.BAG then
            GameDataManager:getInstance():setShcutBagCdList(self._data:getId(), time / 1000)
        end
    end
end

function QuickBagGrid:clearCdTime()
    if self._timer == nil then
        return
    end
    if self._timer:getPercentage() <= 0 then
        return
    end
    self._timer:setPercentage(0)
    self._timer:setVisible(false)
    self:setTouchEnable(false)
    self._usable = true
end


--  使用道具
function QuickBagGrid:useItem(data)
    
    -- 如果技能可用
    if self._usable and not self._isLock then  
        return true
    else
        UI.ScrollBar:createByText(UI.TEXT_1170920)
        return false
    end

end

--  使用技能
function QuickBagGrid:useSkill(data)
    -- 如果技能可用
    if self._usable then  
        UI.UIManager:useGoods(data, true)
        if self._gridType == GridType.BAR then 
            self:barItemSelectDownSpine()
            self:barSkillUseSpine()
        elseif self._gridType == GridType.BAG then 
       
            self:useItemSelectSpine()
        end
        return true
    else
        return false
    end
end

function QuickBagGrid:addItemCirCircularCap()
    if self._shapeType == BORDER_SHAPE.CIRCULAR then
        if self._data and self._data:isSkill() then
            self._itemIcon:retain()
            self._itemIcon:removeFromParent(true)
            self._clipper:addInnerNode(self._itemIcon)
            self._itemIcon:release()
            self.doClip = true
            -- self._itemIcon:setScale(0.9)
            self._itemIcon:setPosition(self._clipper:getContentSize().width / 2, self._clipper:getContentSize().height / 2)
        end
    end
end

function QuickBagGrid:removeItemCirCircularCap()
    if self.doClip then
        self._itemIcon:retain()
        self._itemIcon:removeFromParent(true)
        self:addChild(self._itemIcon, ZORDER_GRID_ICON)
        self._itemIcon:release()
        self.doClip = false
    end
end

-- 成功使用技能后收到消息后其它触发的公共CD
function QuickBagGrid:usePublicCDTime()
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SUCCECD_USE_SKILL,self, self.runPublicCD)
end 

--成功使用回城卷轴后的绑定消息
function QuickBagGrid:ToTownUsePublicCDTime(cdTime)
    self._coolDownTime = cdTime
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_USED_TOTOWN_CONFIRM,self, self.runToTownPublicCD)
 end 

 --成功使用铁锹后的绑定消息
function QuickBagGrid:ToUseTQPublicCDTime(cdTime)
    self._coolDownTime = cdTime
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SUCCECD_USE_IRONPICKAXE_CLICK,self, self.runTQPublicCD)
end 

 --成功使用二次确认技能后的绑定消息
function QuickBagGrid:ToUseTWSkillCDTime(cdTime)
    self._coolDownTime = cdTime
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SUCCECD_USE_TWICE_SKILL,self, self.lockUse)
end 

function QuickBagGrid:scenePauseOrResume(isPause)
    self.isPause = isPause
    if(self._timer) then 
        if(not tolua.isnull(self._timer)) then 
            if(isPause) then 
                self._timer:pause()
            else 
                self._timer:resume()
            end 
        end
    end

    if(not tolua.isnull(self._ti_item_Select_Spinemer)) then 
        if(isPause) then 
            self._item_Select_Spine:pause()
        else 
            self._item_Select_Spine:resume()
        end 
    end
end