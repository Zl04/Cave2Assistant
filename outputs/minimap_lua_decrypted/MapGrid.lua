--[[
    小地图的格子对象
]]

require "app.ui.Component"
local MapDefine = require "app.mapkit.MapDefine"
local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
local MonsterSubType = PublicDefine.MonsterSubType
local SceneManager = require("app.game.SceneManager")
UI = UI or {}

local MapGrid = class("MapGrid")
UI.MapGrid = MapGrid

-- 格子上的sprite的类型
UI.MapGrid.SPRITE_TYPE = {
    GRID = 1, -- 地图格子的sprite
    ELEMENT = 2, -- 地图格子上的元素
    ELEMENT_FUNCTION = 3, -- 地图格子上的元素--功能列表(该表现不会随着玩家移动刷新)
    HERO = 4, -- 地图格子上的英雄
}

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 格子上的sprite的坐标修正
local MAP_GRID_ELEMENT_OFFSET_Y = -8
local MAP_GRID_THICKNESS = 0
local MAP_GRID_SPINE_ELEMENT_OFFSET_Y = 5
-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0

-- 地图元素图片名字
local SPRITE_MAP_ELEMENT_HERO = "ui_minimap_icon%s_me.png"                                  -- 英雄（自己）
local SPRITE_MAP_ELEMENT_HERO_OTHER = "ui_minimap_icon%s_teammate.png"                      -- 英雄（队友）
local SPRITE_MAP_ELEMENT_MONSTER = "ui_minimap_icon%s_blame01.png"                          -- 怪物（普通）
local SPRITE_MAP_ELEMENT_MONSTER_ELITE = "ui_minimap_icon%s_blame02.png"                    -- 怪物（精英）
local SPRITE_MAP_ELEMENT_MONSTER_GROUP = "ui_minimap_icon%s_blame03.png"                    -- 群怪
local SPRITE_MAP_ELEMENT_BOSS_SMALL = "ui_minimap_icon%s_boss01.png"                        -- boss（小）
local SPRITE_MAP_ELEMENT_BOSS_BIG = "ui_minimap_icon%s_boss02.png"                          -- boss（大）
local SPRITE_MAP_ELEMENT_TREASURE_POT = "ui_minimap_icon%s_jar.png"                         -- 罐子
local SPRITE_MAP_ELEMENT_TREASURE_POT_DISABLE = "ui_minimap_icon%s_jar_01.png"              -- 罐子不可用
local SPRITE_MAP_ELEMENT_TREASURE_BONE = "ui_minimap_icon%s_material.png"                   -- 骨头堆
local SPRITE_MAP_ELEMENT_TREASURE_BONE_DISABLE = "ui_minimap_icon%s_material_01.png"        -- 骨头堆不可用
local SPRITE_MAP_ELEMENT_TREASURE_WOOD = "ui_minimap_icon%s_ordinary.png"                   -- 木箱子
local SPRITE_MAP_ELEMENT_TREASURE_WOOD_DISABLE = "ui_minimap_icon%s_ordinary_01.png"        -- 木箱子不可用
local SPRITE_MAP_ELEMENT_TREASURE_GOLD = "ui_minimap_icon%s_chest.png"                      -- 金箱子
local SPRITE_MAP_ELEMENT_TREASURE_GOLD_DISABLE = "ui_minimap_icon%s_chest_01.png"           -- 金箱子不可用
local SPRITE_MAP_ELEMENT_GOLD_BAG = "ui_minimap_icon%s_gold.png"                            -- 金币袋
local SPRITE_MAP_ELEMENT_TRAP = ""                                                          -- 陷阱
local SPRITE_MAP_ELEMENT_TOWN_ENTRANCE = "ui_minimap_icon%s_fam.png"                        -- 主城传送门
local SPRITE_MAP_ELEMENT_CAVE_ENTRANCE = "ui_minimap_icon%s_cave.png"                       -- 洞穴传送门
local SPRITE_MAP_ELEMENT_ENTRANCE = "ui_minimap_icon%s_stairs.png"                          -- 洞穴入口
local SPRITE_MAP_ELEMENT_ROOM = ""                                                          -- 密室
local SPRITE_MAP_ELEMENT_STATUS = "ui_minimap_icon%s_dianjin.png"                           -- 点击台
local SPRITE_MAP_ELEMENT_STATUS_DISABLE = "ui_minimap_icon%s_dianjin_01.png"                -- 点击台不可用
local SPRITE_MAP_ELEMENT_CHAMBER_ENTRANCE = "effect_buff_chamber"                           -- 密室入口
local SPRITE_MAP_ELEMENT_RUNE = "ui_minimap_icon%s_rune.png"                                -- 符文
local SPRITE_MAP_ELEMENT_MAGIC_PLATFORM = "ui_minimap_icon%s_enchanting.png"                -- 附魔台
local SPRITE_MAP_ELEMENT_PLAY_TRIGGER = "ui_minimap_icon%s_Plot.png"                        -- 剧情触发器
local SPRITE_MAP_ELEMENT_BUSSINESS_MAN = "ui_minimap_icon%s_businessman.png"                -- 商人
local SPRITE_MAP_ELEMENT_BLACKSMITH_SHOP = "ui_minimap_icon%s_blacksmith.png"               -- 铁匠铺
local SPRITE_MAP_ELEMENT_BLACK_BUSSINESS_MAN = "ui_minimap_icon%s_blackmarket.png"          -- 黑市商人
local SPRITE_MAP_ELEMENT_CAT_BUSSINESS_MAN = "ui_minimap_icon%s_catfood.png"                -- 猫饭商人
local SPRITE_MAP_ELEMENT_MAIL_BOX = "ui_minimap_icon%s_mail.png"                            -- 邮箱
local SPRITE_MAP_ELEMENT_WAREHOUSE = "ui_minimap_icon%s_warehouse.png"                      -- 仓库
local SPRITE_MAP_ELEMENT_RANKING_LIST = "ui_minimap_icon%s_ranking.png"                     -- 排行榜
local SPRITE_MAP_ELEMENT_TASK_NPC = "ui_minimap_icon%s_pipe.png"                            -- 任务NPC
local SPRITE_MAP_ELEMENT_TASK_NPC_NO_TASK = "ui_minimap_icon%s_pipe_01.png"                 -- 任务NPC没有任务
local SPRITE_MAP_ELEMENT_TASK_NPC_COMPLETE = "ui_minimap_icon%s_ask.png"                    -- 任务NPC完成
local SPRITE_MAP_ELEMENT_MAP_NPC = "ui_minimap_icon%s_pipe.png"                             -- 藏宝图NPC
local SPRITE_MAP_ELEMENT_MAP_NPC_COMPLETE = "ui_minimap_icon%s_ask.png"                     -- 藏宝图NPC完成
local SPRITE_MAP_ELEMENT_GUILD = "ui_minimap_icon%s_guildentrance.png"                      -- 工会入口
local SPRITE_MAP_ELEMENT_GOLDMETALLURGY = "ui_minimap_icon%s_goldmetallurgy.png"            -- 炼金术士
local SPRITE_MAP_ELEMENT_GUILD_SHOP = "ui_minimap_icon%s_guildshop.png"                     -- 工会商店
local SPRITE_MAP_ELEMENT_LUCKDRAW = "ui_minimap_icon%s_luckdraw.png"                        -- 转盘
local SPRITE_MAP_ELEMENT_SECRET_AREA = "ui_minimap_icon%s_cave.png"                         -- 秘境
local SPRITE_MAP_ELEMENT_PORTAL = "ui_minimap_icon%s_transfer.png"                          -- 传送门
local SPRITE_MAP_ELEMENT_PORTAL_PURPLE = "ui_minimap_icon%s_room_purple.png"                -- 随机房间传送门
local SPRITE_MAP_ELEMENT_SECRET_PORTAL = "ui_minimap_icon%s_room.png"                       -- 秘境房间传送门
local SPRITE_MAP_ELEMENT_ACTIVITY = "ui_minimap_icon%s_activity.png"                        -- 运营活动
local SPRITE_MAP_ELEMENT_GEM_STONE = "ui_minimap_icon%s_gem.png"                            -- 宝石
local SPRITE_MAP_ELEMENT_HOME_SYSTEM = "ui_minimap_icon%s_home.png"                         -- 家园
local SPRITE_MAP_ELEMENT_SKILL_ADVANCED= "ui_minimap_icon%s_upgrade.png"                    -- 技能进阶
local SPRITE_MAP_ELEMENT_EQUIPMENT_ILLUSION= "ui_minimap_icon%s_deformation.png"            -- 幻化师图标
local SPRITE_MAP_ELEMENT_DREAM_ENTERANCE= "ui_minimap_icon%s_dreamword.png"                 -- 梦境入口图标
local SPRITE_MAP_ELEMENT_EQUIPR_ECAST = "ui_minimap_icon%s_recasting.png"                   -- 装备重铸
local SPRITE_MAP_ELEMENT_EXPEDITION= "ui_minimap_icon%s_explore.png"                        -- 探险队
local SPRITE_MAP_ELEMENT_MANOR_SHOP = "ui_minimap_icon_house_trade.png"                     -- 庄园商店
local SPRITE_MAP_ELEMENT_MANOR_ENTRANCE = "ui_minimap_icon_town_manor.png"                  -- 庄园入口


-- npc的类型
local NPC_TYPE = {
    NONE = 0,               -- 不显示
    STAIRS = 1,             -- 楼梯
    TREASURE_BOX = 2,       -- 宝箱
    TREASURE_BONE = 3,      -- 骨堆
    TREASURE_POT = 4,       -- 罐子
    RUNE = 5,               -- 符文
    STATUS = 6,             -- 点金台
    MAGIC_PLATFORM = 7,     -- 附魔台
    CAVE_BUSSINESS = 8,     -- 洞窟商人
    TOWN_BUSSINESS = 9,     -- 城镇商人
    BLACK_BUSSINESS = 10,   -- 黑市商人
    BLACKSMITH = 11,        -- 铁匠
    MAIL_BOX = 12,          -- 邮箱
    CAVE_ENTERANCE = 13,    -- 普通洞窟入口
    BOARD = 14,             -- 任务
    WAREHOUSE = 15,         -- 仓库
    GUARD = 16,             -- 卫兵
    LUCKDRAW = 17,          -- 转盘
    PORTAL = 18,            -- 传送门
    SECRET_AREA = 19,       -- 秘境入口
    RANKING = 20,           -- 排行榜
    GUILD = 21,             -- 公会入口
    SECRET_PORTAL = 22,     -- 秘境房间传送门
    GOLDMETALLURGY = 23,     -- 炼金术士
    GUILD_SHOP = 24,        -- 公会商店
    GUILD_BOARD = 25,       --公会悬赏栏
    ACTIVITY = 26,          -- 运营活动
    GEM_STONE = 27,         -- 宝石系统
    HOME_SYSTEM = 28,       -- 家园系统
    SKILL_ADVANCED = 29,    -- 技能进阶
    EQUIPMENT_ILLUSION = 30,-- 幻化师
    DREAM_ENTERANCE = 31,   -- 梦境入口
    EQUIP_RECAST = 32,      -- 装备重铸
    STAR_PRAY = 33,         -- 星痕
    EXPEDITION = 34,        -- 探险队
    DESERT_EYE = 35,        -- 沙之眼
    DISTORTED_SPACE = 36,   -- 扭曲空间
    FESTIVAL = 37,          -- 节日活动
    WISHPOOL = 38,          -- 公会许愿池
    COLLECT = 39,          -- 采集物
    AUCTION = 40,          -- 公会拍卖NPC
    GUILD_BOSS = 41,       -- 公会boss
    MANOR_SHOP = 43,        --庄园商人
    MANOR_ENTRANCE = 44,    --庄园入口
    VOIDRIFT_BARTER = 45,    --易物台
    MANOR_WORKSHOP = 46,    --工坊
    MANOR_HOUSEKEEPER = 47, -- 庄园管家
    MANOR_DESK = 48,        -- 庄园书桌NPC
    MANOR_BOAT = 49,        -- 庄园远航NPC
    MANOR_DININGTABLE = 50, -- 庄园餐桌
    MANOR_DRESS_UP_SHELF = 51,   -- 幻化架
    VIKING = 52,            -- 维京时代
    EVER_WINTER = 53,            -- 永冬裂缝
    RUNE_MOLD = 54,            -- 符文模具
    PORT_DOCK = 55,            -- 港口码头
    PORT_BUSINESS = 56,        -- 港口商人
    PORT_TASK = 57,            -- 港口任务
    PORT_SUPPLY = 58,          -- 港口补给
    PORT_BET = 59,             -- 港口拉力赛
    CHAMBER_ENTRANCE = 1001,-- 密室入口
}

-- 更新地图格子的sprite
local function updateGridSprite(self)
    if (self._gridSprite) then
        self._gridSprite:setAnchorPoint(0.5, 0.5)
        self._gridSprite:setPosition(self._posX, self._posY - MAP_GRID_THICKNESS)
        self._gridSprite:setOpacity(self._opacityValue * 255)
        self._gridSprite:setLocalZOrder(self._zorder * 3 + 1)
        if (self._gridSpriteName) then 
            if self._gridSprite.__frameName ~= self._gridSpriteName then
                self._gridSprite:setSpriteFrame(self._gridSpriteName) 
                self._gridSprite.__frameName =  self._gridSpriteName
            end
        end
    end
end

-- 更新地块元素的sprite
local function updateElementSprite(self)
    if (self._elementSprite) then
        self._elementSprite:setAnchorPoint(0.5, 0)
        self._elementSprite:setPosition(self._posX, self._posY + MAP_GRID_ELEMENT_OFFSET_Y)
        self._elementSprite:setOpacity(self._opacityValue * 255)
        self._elementSprite:setLocalZOrder(self._zorder * 3 + 2)

        if (self._elementSpriteName) then
            if string.find(self._elementSpriteName,".png") then
                -- 判断一下 减少开销 
                if self._elementSprite.__frameName ~= self._elementSpriteName then
                    self._elementSprite:setSpriteFrame(self._elementSpriteName)   
                    self._elementSprite.__frameName =  self._elementSpriteName
                end
            else
                self.spineIcon = Avalon.Animation:create(self._elementSpriteName..".json", self._elementSpriteName..".atlas", 1)
                self.spineIcon:setAnimation(0,"idle",true)
                self.spineIcon:setPosition(self._posX, self._posY + MAP_GRID_SPINE_ELEMENT_OFFSET_Y)
                -- self.spineIcon:setPosition(0,0)
            end
        end
    end
end

-- 更新地块FUNCTION元素的sprite
local function updateElementFuctionSprite(self)
    if (self._elementFunctionSprite) then
        self._elementFunctionSprite:setAnchorPoint(0.5, 0)
        self._elementFunctionSprite:setPosition(self._posX, self._posY + MAP_GRID_ELEMENT_OFFSET_Y)
        self._elementFunctionSprite:setOpacity(self._opacityValue * 255)
        self._elementFunctionSprite:setLocalZOrder(self._zorder * 3 + 2)
    end
end

-- 更新角色的sprite
local function updateHeroSprite(self)
    if (self._heroSprite) then
        self._heroSprite:setAnchorPoint(0.5, 0)
        self._heroSprite:setPosition(self._posX, self._posY + MAP_GRID_ELEMENT_OFFSET_Y)
        self._heroSprite:setOpacity(self._opacityValue * 255)
        self._heroSprite:setLocalZOrder(self._zorder * 3 + 3)
        if (self._heroSpriteName) and self._heroSpriteName ~= "" then
            if self._heroSprite.__frameName ~= self._heroSpriteName then
                self._heroSprite:setSpriteFrame(self._heroSpriteName) 
                self._heroSprite.__frameName =  self._heroSpriteName
            end
            self._heroSprite:setVisible(true)
        else
            self._heroSprite:setVisible(false)
        end
    end
end
 
-- 构造函数
function MapGrid:ctor(sceneTye)
    -- 格子索引
    self._index = 0
    -- z序号
    self._zorder = 0
    -- 格子坐标
    self._coordX = 0
    self._coordY = 0
    -- 标志上下左右是否可以通过（true为可以通过）
    self._upFlag = true
    self._rightFlag = true
    self._bottomFlag = true
    self._leftFlag = true
    -- 地图格子数据
    self._mapGridData = nil
    -- 透明值
    self._opacityValue = 0.0
    -- 是否可见
    self._isVisible = false
    -- 格子上的sprite的名字
    self._gridSpriteName = nil
    self._heroSpriteName = nil
    self._elementSpriteName = nil
    -- 格子上的sprite
    self._gridSprite = nil
    self._heroSprite = nil
    self._elementSprite = nil
    -- 格子相对于父节点的坐标
    self._posX = 0
    self._posY = 0
    -- 格子相对于mapview的位置
    self._relativePosX = 0
    self._relativePosY = 0
    self._sceneType = sceneTye

    self._showTeammate = true
end


-- public:
-- 初始化
function MapGrid:init(mapGridData, coordX, coordY)
    self._mapGridData = mapGridData
    self._coordX = coordX or 0
    self._coordY = coordY or 0
end

-- 更新地块视图
function MapGrid:updateMapGrid()
    if (self._mapGridData) then
        -- 更新地块视图
        if (self:isGround()) then
            -- 根据上下左右的情况绘制地块
            local up = self._upFlag and 0 or 1
            local right = self._rightFlag and 0 or 1
            local bottom = self._bottomFlag and 0 or 1
            local left = self._leftFlag and 0 or 1
            local no = up + right * 2 + bottom * 4 + left * 8
            local spriteName = "minimap-small-00.png"
            self._gridSpriteName = spriteName
        end
    else
        assert(false)
    end
end

-- 更新地块上的元素
function MapGrid:updateMapElement()
    if (self._mapGridData) then

        local hasRole = false
        local hasElement = false
        local roleSpriteName = nil
        local elementSpriteName = nil
        local elementScale = 1.0
        local addTown = SceneManager:getInstance():isNotInFightScene()
        self._heroSpriteName = nil
        
        -- 绘制地块上的角色
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            hasElement = #roleDataList > 0
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                
                roleSpriteName, elementSpriteName, hasRole, hasElement = self:getIconName(roleData, addTown)
                if(roleData) then
                    local category = roleData:getDeformationCategory()
                    local type = roleData:getDeformationType()
                    if(category == Category.ROLE and type ~= RoleType.Pet) then
                        self._heroSpriteName = roleSpriteName
                    end
                end
            end
        else
            hasRole = false
            hasElement = false
        end

        self._elementSpriteName = elementSpriteName
    end
end

-- 设置索引
function MapGrid:setIndex(index)
    assert(type(index) == "number" and index >= 0, "MapGrid setIndex: index is invalid.")

    self._index = index
end

-- 获取索引
function MapGrid:getIndex()
    return self._index
end

-- 设置地图数据
function MapGrid:setData(mapGridData)
    self._mapGridData = mapGridData
end

-- 获取地图格子数据
function MapGrid:getData()
    return self._mapGridData
end

-- 获取格子上的英雄数据
function MapGrid:getHeroDataList()
    local heroDataList = nil

    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            heroDataList = {}

            local index = 1
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                if (roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Hero) then
                    table.insert(heroDataList, index, roleData)
                    index = index + 1
                end
            end
        end
    end
    return heroDataList
end

-- 获取格子上的所有角色数据
function MapGrid:getRoleDataList()
    if (self._mapGridData) then
        return self._mapGridData:getRoleDatas()
    end
    return nil
end

-- 获取坐标
function MapGrid:getCoord()
    return self._coordX, self._coordY
end

-- 地块的四个方向是否可以通过
function MapGrid:setWallAround(up, right, bottom, left)
    assert(type(up) == "boolean", "MapGrid showMapGrid: up is invalid.")
    assert(type(right) == "boolean", "MapGrid showMapGrid: right is invalid.")
    assert(type(bottom) == "boolean", "MapGrid showMapGrid: bottom is invalid.")
    assert(type(left) == "boolean", "MapGrid showMapGrid: left is invalid.")

    self._upFlag = up
    self._rightFlag = right
    self._bottomFlag = bottom
    self._leftFlag = left
end

-- 是否是地
function MapGrid:isGround()
    if (self._mapGridData) then
        if self._mapGridData:getTerrainType() == MapDefine.TerrainType.Ground then
            for k,v in pairs(self._mapGridData:getDecorationDatas()) do
                if (v:isReachable() == false) then
                    return false
                end
            end

            for k,v in pairs(self._mapGridData:getPlaceholderDatas()) do
                if (v:isReachable() == false) then
                    return false
                end
            end

            return true
        else
            return false
        end
    end
    return false
end

-- 是否可以到达
function MapGrid:isReachable()
    if (self._mapGridData) then
        return self._mapGridData:isReachable()
    end
    return false
end

-- 是否是墙
function MapGrid:isWall()
    if (self._mapGridData) then
        return self._mapGridData:getTerrainType() == MapDefine.TerrainType.Wall or (not self._mapGridData:isReachable())
    end
    return false
end

-- 是否是入口
function MapGrid:isEnterance()
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local category = roleData:getCategory()
                local type = roleData:getType()
                
                if (category == Category.NPC and type == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                    return true
                end
            end
        end
    end
    return false
end

-- 是否是npc
function MapGrid:isTriggerNPC()
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local category = roleData:getCategory()

                if (category == Category.TRIGGER_NPC) then
                    return true
                end
            end
        end
    end
    return false
end

-- 是否是某种npc
function MapGrid:isSomeTriggerNPC(npcType)
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local category = roleData:getCategory()
                local type = roleData:getType()

                if (category == Category.TRIGGER_NPC and 
                    type == npcType) then
                    return true
                end
            end
        end
    end
    return false
end

-- 是否是某种function npc
function MapGrid:isSomeFunctionNPC(functionType)
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local category = roleData:getCategory()
                local type = roleData:getType()

                if (category == Category.TRIGGER_NPC and type == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and roleData:hasFunction(functionType)) then
                    return true
                end
            end
        end
    end
    return false
end

-- 是否是宠物怪
function MapGrid:isMonsterPet()
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                local category = roleData:getCategory()
                local type = roleData:getType()

                if (category == Category.ROLE and type == RoleType.Monster and roleData:getIsPet()) then
                    return true
                end
            end
        end
    end
    return false
end

-- 设置透明度
function MapGrid:setOpacity(opacity)
    assert(type(opacity) == "number" and opacity >= 0.0 and opacity <= 1.0, "MapGrid setOpacity: opacity is invalid.")
    
    self._opacityValue = opacity
end

-- 获取透明值
function MapGrid:getOpacity()
    return self._opacityValue
end

-- 设置是否被探索过
function MapGrid:explore()
    self._mapGridData:explore()
end

-- 是否可以显示
function MapGrid:isExplored()
    return self._mapGridData:hasExplored()
end

-- 是否到达过
function MapGrid:isReached()
    return self._mapGridData:isReached()
end

-- 是否显示
function MapGrid:hasShowIcon()
    return self._mapGridData:hasShowIcon()
end


-- 是否是主角所在格子
function MapGrid:hasMaster()
    if (self._mapGridData) then
        local roleDataList = self._mapGridData:getRoleDatas()
        if (roleDataList) then
            for i = 1, #roleDataList do
                local roleData = roleDataList[i]
                if (roleData:getCategory() == Category.ROLE and 
                    roleData:getType() == RoleType.Hero) then
                    if (roleData:isMasterHero()) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- 设置格子相对于父节点的坐标
function MapGrid:setPos(posX, posY)
    self._posX = posX
    self._posY = posY
end

-- 获取格子相对于父节点的坐标
function MapGrid:getPos()
    return self._posX, self._posY
end

-- 缓存格子相对于mapview的相对位置
function MapGrid:setRelativePosition(posX, posY)
    self._relativePosX = posX
    self._relativePosY = posY
end

-- 获取格子相对于mapview的相对位置
function MapGrid:getRelativePosition()
    return self._relativePosX, self._relativePosY
end

-- 设置格子的显示z序
function MapGrid:setZOrder(zorder)
    self._zorder = zorder
end

-- 显示
function MapGrid:show()
    self._isVisible = true
end

-- 隐藏
function MapGrid:hide()
    self._isVisible = false
end

-- 是否可见
function MapGrid:isVisible()
    return self._isVisible
end

-- 创建地图格子的sprite
function MapGrid:createMapGrid()
    if (self._gridSpriteName) then
        local sprite = cc.Sprite:create()
        sprite:setAnchorPoint(0.5, 0.5)
        -- sprite:setTexture(texture)
        sprite:setPosition(self._posX, self._posY - MAP_GRID_THICKNESS)
        sprite:setOpacity(self._opacityValue * 255)
        sprite:setSpriteFrame(self._gridSpriteName)
        sprite:setLocalZOrder(self._zorder * 3 + 1)
        return sprite
    end
    return nil
end

-- 设置格子的sprite
function MapGrid:setSprite(spriteType, sprite)
    if (spriteType == UI.MapGrid.SPRITE_TYPE.GRID) then
        self._gridSprite = sprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT) then
        self._elementSprite = sprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION) then
        self._elementFunctionSprite = sprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.HERO) then
        self._heroSprite = sprite
    else
        assert(false)
    end
end

-- 获取格子的sprite
function MapGrid:getSprite(spriteType, sprite)
    local sprite = nil
    if (spriteType == UI.MapGrid.SPRITE_TYPE.GRID) then
        sprite = self._gridSprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT) then
        sprite = self._elementSprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION) then
        sprite = self._elementFunctionSprite
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.HERO) then
        sprite = self._heroSprite
    else
        assert(false)
    end
    return sprite
end

-- 更新格子的sprite
function MapGrid:updateSprite(spriteType)
    if (spriteType == UI.MapGrid.SPRITE_TYPE.GRID) then
        updateGridSprite(self)
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT) then
        updateElementSprite(self)
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT_FUNCTION) then
        updateElementFuctionSprite(self)
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.HERO) then
        updateHeroSprite(self)
    else
        assert(false)
    end
end

-- 获取格子的sprite的名字
function MapGrid:getSpriteName(spriteType)
    local spriteName = nil
    if (spriteType == UI.MapGrid.SPRITE_TYPE.GRID) then
        spriteName = self._gridSpriteName
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.ELEMENT) then
        spriteName = self._elementSpriteName
    elseif (spriteType == UI.MapGrid.SPRITE_TYPE.HERO) then
        spriteName = self._heroSpriteName
    else
        assert(false)
    end
    return spriteName
end

-- 更新数据
function MapGrid:update()
    self:updateMapGrid()
    self:updateMapElement()
end

-- 是否显示队友
function MapGrid:showTeammate(visible)
    self._showTeammate = visible
end

function MapGrid:getIconName(roleData, addTown)
    local roleSpriteName = nil
    local elementSpriteName = nil
    local hasRole = false 
    local hasElement = false

    addTown = addTown or false

    if(roleData) then
        local category = roleData:getDeformationCategory()
        local type = roleData:getDeformationType()
        if (DEBUG) then
            print(string.format("MapGrid updateMapElement: update role (%f,%f), category %d type %d.", self._coordX, self._coordY, category, type))
        end

        if (category == Category.ROLE) then
            hasRole = true
            
            if (type == RoleType.Hero) then
                if (roleData:isMasterHero()) then
                    roleSpriteName = SPRITE_MAP_ELEMENT_HERO
                else
                    if (self._showTeammate) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_HERO_OTHER
                    end
                end
            elseif (type == RoleType.Monster) then
                local monsterData = roleData 
                if(roleData:getDeformationData()) then 
                    monsterData = roleData:getDeformationData()
                end

                if (not monsterData:getIsTrigger()) 
                    and (monsterData:getMonsterSubType() == MonsterSubType.Trigger or monsterData:getMonsterSubType() == MonsterSubType.Treasure) then
                    if monsterData.monsterMiniMapIcon == "" or monsterData.monsterMiniMapIcon == "0" then
                        roleSpriteName = ""
                    else
                        roleSpriteName = monsterData.monsterMiniMapIcon..".png"
                    end
                else
                    if (monsterData:isNormalMonster() and not monsterData:getIsGroupMonster()) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_MONSTER
                    elseif (monsterData:isEliteMonster()) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_MONSTER_ELITE
                    elseif (monsterData:isSmallBoss()) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_BOSS_SMALL
                    elseif (monsterData:isBigBoss()) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_BOSS_BIG
                    elseif (monsterData:getIsGroupMonster()) then
                        roleSpriteName = SPRITE_MAP_ELEMENT_MONSTER_GROUP
                    else
                        roleSpriteName = SPRITE_MAP_ELEMENT_MONSTER

                        print(string.format("[ERROR] monster type %d ", monsterData:getMonsterType()))
                        -- print(debug.traceback())
                    end
                end
            elseif (type == RoleType.Pet) then
            else
                assert(false)
            end
        elseif (category == Category.TRIGGER_NPC) then
            hasElement = true

            if (type == PublicDefine.TRIGGER_NPC_TYPE.BOX) then
                local treasureType = roleData:getTreasureType()
                local isOpened = roleData:getIsOpen()

                local npcType = roleData:getDeformationTypeForMinimap()
                if(npcType ~= NPC_TYPE.NONE) then
                    if (treasureType == PublicDefine.BOX_TYPE.BOX_POT) then
                        elementSpriteName = isOpened and SPRITE_MAP_ELEMENT_TREASURE_POT_DISABLE or SPRITE_MAP_ELEMENT_TREASURE_POT
                    elseif (treasureType == PublicDefine.BOX_TYPE.BOX_BONE) then
                        elementSpriteName = isOpened and SPRITE_MAP_ELEMENT_TREASURE_BONE_DISABLE or SPRITE_MAP_ELEMENT_TREASURE_BONE
                    elseif (treasureType == PublicDefine.BOX_TYPE.BOX_WOOD) then
                        elementSpriteName = isOpened and SPRITE_MAP_ELEMENT_TREASURE_WOOD_DISABLE or SPRITE_MAP_ELEMENT_TREASURE_WOOD
                    elseif (treasureType == PublicDefine.BOX_TYPE.BOX_GOLD) then
                        elementSpriteName = isOpened and SPRITE_MAP_ELEMENT_TREASURE_GOLD_DISABLE or SPRITE_MAP_ELEMENT_TREASURE_GOLD
                    else
                        assert(false)
                    end
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG) then
                local isOpened = roleData:getIsOpen()
                if (isOpened) then
                    hasElement = false
                    elementSpriteName = nil
                else
                    hasElement = true
                    elementSpriteName = SPRITE_MAP_ELEMENT_GOLD_BAG
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
                hasElement = false
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.RUNE) then
                local isOpened = roleData:getIsOpen()
                if (isOpened) then
                    elementSpriteName = nil
                else
                    elementSpriteName = SPRITE_MAP_ELEMENT_RUNE
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                local npcType = roleData:getTypeForMinimap()

                -- 传送门
                if (npcType == NPC_TYPE.PORTAL) then
                    elementSpriteName = SPRITE_MAP_ELEMENT_PORTAL
                -- 秘境房间传送门
                elseif (npcType == NPC_TYPE.SECRET_PORTAL) then
                    if (roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR 
                        and roleData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM
                        and roleData:getIsRandomTransfer()) then 
                        elementSpriteName = SPRITE_MAP_ELEMENT_PORTAL_PURPLE
                    else 
                        elementSpriteName = SPRITE_MAP_ELEMENT_SECRET_PORTAL 
                    end 
                elseif (npcType == NPC_TYPE.STAIRS) then
                    elementSpriteName = SPRITE_MAP_ELEMENT_ENTRANCE
                -- 公会入口
                elseif (npcType == NPC_TYPE.GUILD) then

                    elementSpriteName = SPRITE_MAP_ELEMENT_GUILD
                elseif (npcType == NPC_TYPE.MANOR_ENTRANCE) then
                    elementSpriteName = SPRITE_MAP_ELEMENT_MANOR_ENTRANCE
                else
                    printInfo(string.format("getTypeForMinimap type %d no found.", npcType))
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
                local pointType = roleData:getTransPointType()
                if(pointType == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then 
                    elementSpriteName = "ui_minimap_icon%s_end.png"
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.QUICK_DOWN) then
                elementSpriteName = "ui_minimap_icon%s_key.png"
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER) then
                hasElement = false
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or type == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE) then
                local npcType = roleData:getTypeForMinimap()
                if npcType == NPC_TYPE.CHAMBER_ENTRANCE and self._mapGridData:hasShowIcon() then
                    elementSpriteName = SPRITE_MAP_ELEMENT_CHAMBER_ENTRANCE
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.SAIL_PORT) then
                local npcType = roleData:getTypeForMinimap()
                if npcType == NPC_TYPE.PORT_DOCK then
                    elementSpriteName = "ui_minimap_icon_port_wharf.png"
                end
            elseif (type == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
                if roleData:isMonsterNpc() then
                    elementSpriteName = roleData:getTypeForMinimap()
                else
                    local npcType = roleData:getTypeForMinimap()

                    -- 附魔台
                    if (npcType == NPC_TYPE.MAGIC_PLATFORM) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_MAGIC_PLATFORM
                    -- 点金台
                    elseif (npcType == NPC_TYPE.STATUS) then
                        local isOpened = roleData:getIsOpen()
                        elementSpriteName = (not isOpened) and SPRITE_MAP_ELEMENT_STATUS or SPRITE_MAP_ELEMENT_STATUS_DISABLE
                    -- 商人
                    elseif npcType == NPC_TYPE.CAVE_BUSSINESS then
                        elementSpriteName = SPRITE_MAP_ELEMENT_BUSSINESS_MAN

                    elseif npcType == NPC_TYPE.TOWN_BUSSINESS then
                        elementSpriteName = SPRITE_MAP_ELEMENT_CAT_BUSSINESS_MAN
                        
                    -- 铁匠
                    -- 装备强化
                    -- 装备改造
                    elseif (npcType == NPC_TYPE.BLACKSMITH) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_BLACKSMITH_SHOP
                    -- 黑市商人
                    elseif (npcType == NPC_TYPE.BLACK_BUSSINESS) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_BLACK_BUSSINESS_MAN
                    -- 邮箱
                    elseif (npcType == NPC_TYPE.MAIL_BOX) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_MAIL_BOX
                    -- 仓库
                    elseif (npcType == NPC_TYPE.WAREHOUSE) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_WAREHOUSE
                    -- 排行榜
                    elseif (npcType == NPC_TYPE.RANKING) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_RANKING_LIST
                    -- 任务NPC
                    elseif (npcType == NPC_TYPE.BOARD) then
                        local haveComplete = roleData:getHaveComplete()
                        elementSpriteName = (not haveComplete) and SPRITE_MAP_ELEMENT_TASK_NPC_NO_TASK or SPRITE_MAP_ELEMENT_TASK_NPC_COMPLETE
                    -- 公会悬赏栏
                    elseif (npcType == NPC_TYPE.GUILD_BOARD) then
                        local haveComplete = roleData:getHaveGuildTaskComplete()
                        elementSpriteName = (not haveComplete) and SPRITE_MAP_ELEMENT_TASK_NPC_NO_TASK or SPRITE_MAP_ELEMENT_TASK_NPC_COMPLETE

                    -- 士兵
                    elseif (npcType == NPC_TYPE.GUARD) then
                        local GameInDungeonManager = require "app.game.GameInDungeonManager"
                        local isReward = GameInDungeonManager:getInstance():isCanReciveSeasonReward()
                        if isReward then
                            elementSpriteName = SPRITE_MAP_ELEMENT_TASK_NPC_COMPLETE
                        else
                            elementSpriteName = SPRITE_MAP_ELEMENT_TASK_NPC_NO_TASK
                        end
                        print("NPC_TYPE.GUARD",isReward,elementSpriteName, self._coordX, self._coordY)
                        -- elementSpriteName = SPRITE_MAP_ELEMENT_UNION_MANAGER
                    -- 转盘
                    elseif (npcType == NPC_TYPE.LUCKDRAW) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_LUCKDRAW
                    -- 洞穴入口
                    elseif (npcType == NPC_TYPE.CAVE_ENTERANCE) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_TOWN_ENTRANCE
                    -- 秘境入口
                    elseif (npcType == NPC_TYPE.SECRET_AREA) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_SECRET_AREA
                    -- 炼金术士
                    elseif (npcType == NPC_TYPE.GOLDMETALLURGY) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_GOLDMETALLURGY
                    -- 公会商店
                    elseif (npcType == NPC_TYPE.GUILD_SHOP) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_GUILD_SHOP
                    -- 运营活动
                    elseif (npcType == NPC_TYPE.ACTIVITY) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_ACTIVITY
                    -- 宝石符文
                    elseif (npcType == NPC_TYPE.GEM_STONE) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_GEM_STONE
                    -- 家园系统
                    elseif (npcType == NPC_TYPE.HOME_SYSTEM) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_HOME_SYSTEM
                    elseif (npcType == NPC_TYPE.SKILL_ADVANCED) then 
                        -- 判断是否有奖励为领取
                        local haveComplete = false
                        local taskArr = TaskDataManager:getAllCycleTaskArr()
                        if(taskArr and #taskArr > 0) then 
                            for _, taskData in ipairs(taskArr) do  
                                if(taskData:getCompleteNPCID() == roleData:getId() and  taskData:getIsFinish()) then 
                                    haveComplete = true
                                    break
                                end
                            end
                        end
                        if(haveComplete) then 
                            elementSpriteName = SPRITE_MAP_ELEMENT_TASK_NPC_COMPLETE
                        else
                            elementSpriteName = SPRITE_MAP_ELEMENT_SKILL_ADVANCED
                        end
                    elseif (npcType == NPC_TYPE.EQUIPMENT_ILLUSION) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_EQUIPMENT_ILLUSION
                    elseif (npcType == NPC_TYPE.DREAM_ENTERANCE) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_DREAM_ENTERANCE
                    elseif (npcType == NPC_TYPE.EQUIP_RECAST) then -- 装备重铸
                        elementSpriteName = SPRITE_MAP_ELEMENT_EQUIPR_ECAST
                        elseif (npcType == NPC_TYPE.STAR_PRAY) then -- 星痕
                        elementSpriteName = "ui_minimap_icon%s_starpray.png"
                    elseif (npcType == NPC_TYPE.EXPEDITION) then 
                        elementSpriteName = SPRITE_MAP_ELEMENT_EXPEDITION
                    elseif (npcType == NPC_TYPE.DESERT_EYE) then 
                        elementSpriteName = "ui_minimap_icon%s_sandeye.png"
                    elseif (npcType == NPC_TYPE.DISTORTED_SPACE) then 
                        elementSpriteName = "ui_minimap_icon%s_twistedspace.png"
                    elseif (npcType == NPC_TYPE.FESTIVAL) then 
                        elementSpriteName = "ui_minimap_icon%s_festival.png"
                    elseif (npcType == NPC_TYPE.WISHPOOL) then 
                        elementSpriteName = "ui_minimap_icon_guild_wishingpond.png"
                    elseif (npcType == NPC_TYPE.AUCTION) then 
                        elementSpriteName = "ui_minimap_icon_guild_auction.png"
                    elseif (npcType == NPC_TYPE.GUILD_BOSS) then 
                        elementSpriteName = "ui_minimap_icon_guild_selectfloor.png"
                    elseif (npcType == NPC_TYPE.MANOR_SHOP) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_MANOR_SHOP
                    elseif (npcType == NPC_TYPE.MANOR_ENTRANCE) then
                        elementSpriteName = SPRITE_MAP_ELEMENT_MANOR_ENTRANCE
                    elseif (npcType == NPC_TYPE.FUNCTION_BARTER) then
                        elementSpriteName = "ui_minimap_icon_house_barter.png"
                    elseif (npcType == NPC_TYPE.MANOR_WORKSHOP) then
                        elementSpriteName = "ui_minimap_icon_house_workshop.png"
                    elseif (npcType == NPC_TYPE.MANOR_HOUSEKEEPER) then
                        elementSpriteName = "ui_minimap_icon_house_housekeeper.png"
                    elseif (npcType == NPC_TYPE.MANOR_DESK) then
                        elementSpriteName = "ui_minimap_icon_town_desk.png"
                    elseif (npcType == NPC_TYPE.MANOR_BOAT) then
                        elementSpriteName = "ui_minimap_icon_house_navigation.png"
                    elseif (npcType == NPC_TYPE.MANOR_DININGTABLE) then
                        elementSpriteName = "ui_minimap_icon_house_diningtable.png"
                    elseif (npcType == NPC_TYPE.MANOR_DRESS_UP_SHELF) then
                        elementSpriteName = "ui_minimap_icon_house_illusion.png"
                    elseif (npcType == NPC_TYPE.VIKING) then
                        elementSpriteName = "ui_minimap_icon_town_reincarnation.png"
                    elseif (npcType == NPC_TYPE.EVER_WINTER) then
                        elementSpriteName = "ui_minimap_icon_town_crack.png"
                    elseif (npcType == NPC_TYPE.RUNE_MOLD) then
                        elementSpriteName = "ui_minimap_icon_town_mold.png"
                    elseif (npcType == NPC_TYPE.PORT_DOCK) then
                        elementSpriteName = "ui_minimap_icon_port_wharf.png"
                    elseif (npcType == NPC_TYPE.PORT_BUSINESS) then
                        elementSpriteName = "ui_minimap_icon_port_merchant.png"
                    elseif (npcType == NPC_TYPE.PORT_TASK) then
                        elementSpriteName = "ui_minimap_icon_port_task.png"
                    elseif (npcType == NPC_TYPE.PORT_SUPPLY) then
                        elementSpriteName = "ui_minimap_icon_port_supply.png"
                    elseif (npcType == NPC_TYPE.PORT_BET) then
                        elementSpriteName = "ui_minimap_icon_town_rally.png"
                    else
                        printInfo(string.format("function type %d no found.", npcType))
                    end
                end
                -- print("MapGrid:updateMapElement",npcType,elementSpriteName)
            else
                if(type == nil) then 
                    type = -1
                end
                -- print(string.format("[ERROR] MapGrid updateMapElement: trigger npc type %d is invalid.", type))
            end
        else 
            hasRole = false
            hasElement = false
        end
    end 

    if(roleSpriteName) then 
        if(not addTown) then 
            roleSpriteName = string.format(roleSpriteName, "")
        else 
            roleSpriteName = string.format(roleSpriteName, "_town")
        end
        if not cc.SpriteFrameCache:getInstance():getSpriteFrameByName(roleSpriteName) then 
            roleSpriteName = nil
        end
    end

    if(elementSpriteName) then 
        if(not addTown) then 
            elementSpriteName = string.format(elementSpriteName, "")
        else 
            elementSpriteName = string.format(elementSpriteName, "_town")
        end
        if not cc.SpriteFrameCache:getInstance():getSpriteFrameByName(elementSpriteName) then 
            elementSpriteName = nil
        end
    end

    return roleSpriteName, elementSpriteName, hasRole, hasElement
end