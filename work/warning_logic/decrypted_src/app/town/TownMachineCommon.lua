
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")


local TRIGGER_TYPE = GameTriggerType
local TRACKS_INDEX = GameTracksIndex
local SPRITE_STATUS = PublicDefine.SPRITE_STATUS
local SCREEN_TYPE = GameScreenType

local DEBUG = false

local Machine = Town.Machine


function Machine:_controlRemoveScreenRole(data)
    -- 根据情况清理掉相关的数据
    local heroData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
    if(heroData and heroData:getCategory() == Category.ROLE and heroData:getType() == RoleType.Hero) then
        if(DEBUG) then
            print("ROLE_REMOVE_SCREEN_ROLE pk=", heroData:getPK())
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_HERO, heroData)

        GameDataManager:getInstance():clearHeroDataForPK(heroData:getPK())
    end 

    local role = self._model:getRoleBySpriteID(data.spriteID)

    -- 这里过滤，只处理玩家和怪物
    if role then
        if(role:getAddNum() > 1) then
            role:reduceAddNum()
        end 

        -- 由于陷阱等占地区域比较广，会被多次加载。还不能移除
        if role:getAddNum() > 1 then
            return
        end

         -- TODO 停止所有的效果
        self._actionTrack:clearActionForEntryId(role:getId())
        -- 移除所有buffer
        self:_clearAllBufferForRole(role)

        local category = role:getCategory()
        local type = role:getType()

        if DEBUG then
            print("Machine:onExecuteControlCommand  CONTROL_REMOVESCREENROLE category,type=",category,type)
        end

        -- 这里需要更具不同的类型以及状态获取是否需要延迟移除表现
        local roleData = role:getData()
        -- 整理一下移除逻辑
        if category == Category.ROLE then
            if type == RoleType.Hero then
                self._view:removeView(role)
                self._model:removeRole(role)
                local pet = role:getFightPet()
                if pet then
                    for k, v in pairs(pet) do
                        self._actionTrack:clearActionForEntryId(v:getId())
                        self:_clearAllBufferForRole(v)
                        self._view:removeView(v)
                        self._model:removeRole(v)
                    end
                    
                end
            elseif type == RoleType.Monster then
                -- 这里如果死亡了就移除，等待死亡的移除
                if(not roleData:getIsDead()) then
                    self._view:removeView(role)
                    -- self._model:removeRole(role)
                end
            elseif type == RoleType.Pet then
                -- 移除自己的宠物
                self._actionTrack:clearActionForEntryId(role:getId())
                self:_clearAllBufferForRole(role)
                self._view:removeView(role)
                self._model:removeRole(role)

                Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
            end
        elseif category == Category.TRIGGER_NPC then
            if type == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or type == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
                if role:getIsOpen() == true then
                    self._view:removeView(role,false)
                    self._model:removeRole(role)
                else
                    -- self._view:removeView(role)
                    -- self._model:removeRole(role)
                end
                
                
            -- 这里如果城镇出现的需要确认是否需要添加操作处理。
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
                if role:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE) 
                or role:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.CONST_DECORATION)
                then
                    -- self._map:setPermanentVisible(coord.x, coord.y, view)
                    -- print("主城传送门加入常驻显示,不删除")
                else
                    -- 停止所有的效果
                    self._actionTrack:clearActionForEntryId(role:getId())

                    -- 这里直接移除，可能会导致一些飞行道具，或者正在使用该对象作为计算对象，前面修改过一次所有对象都使用ID来获得，目前应该得到的解决
                    if AvalonUtil.isSmallMemoryDevice() then
                        self._view:removeView(role)
                    end
                end
            else
                -- 停止所有的效果
                self._actionTrack:clearActionForEntryId(role:getId())

                -- 这里直接移除，可能会导致一些飞行道具，或者正在使用该对象作为计算对象，前面修改过一次所有对象都使用ID来获得，目前应该得到的解决
                self._view:removeView(role)
                -- self._model:removeRole(role)
            end
        end
        -- print("MC_BATTLE_REMOVE_GAME_MODEL notice ", category, type)
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, roleData) 
    end
end

--移除除自己外的所有角色（人物和宠物）
function Machine:_controlRemoveAllOtherScreenRole()
    local list =  RoleDataManager:getAllOtherRole()
    for k, heroData in ipairs(list) do
        local spriteID = heroData:getSpriteID()
        GameDataManager:getInstance():clearHeroDataForPK(heroData:getPK())
        if(DEBUG) then
            print("ROLE_REMOVE_SCREEN_ROLE pk=", heroData:getPK())
        end
        local role = self._model:getRoleBySpriteID(spriteID)

        -- 这里过滤，只处理玩家和怪物
        if role then
            if(role:getAddNum() > 1) then
                role:reduceAddNum()
            end 
            --停止所有的效果
            self._actionTrack:clearActionForEntryId(role:getId())
            -- 移除所有buffer
            self:_clearAllBufferForRole(role)

            local category = role:getCategory()
            local type = role:getType()

            local roleData = role:getData()
            if category == Category.ROLE then
                if type == RoleType.Hero then
                    self._view:removeView(role)
                    self._model:removeRole(role)
                    local pets = role:getFightPet()
                    for _, pet in pairs(pets) do
                        if pet then
                            self._actionTrack:clearActionForEntryId(pet:getId())
                            self:_clearAllBufferForRole(pet)
                            self._view:removeView(pet)
                            self._model:removeRole(pet)
                        end
                    end
                    
                end
            end
        end
    end
end