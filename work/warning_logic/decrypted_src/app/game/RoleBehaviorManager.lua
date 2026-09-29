-- RoleBehaviorManager.lua
-- Author:zp
-- 2018年7月9日
-- Using:角色行为管理

RoleBehaviorManager = RoleBehaviorManager or {}

-- 用于加载相同方法
local SceneManager = require("app.game.SceneManager")

-- 初始化加载
local function initRequire()
    
end 

-- 组队踢人
function RoleBehaviorManager:teamKick()
    initRequire()
end 

-- 检测玩家是否处于逃跑中
function RoleBehaviorManager:checkMasterIsInRunAway()
    if self:getMasterState() == FSMState.BATTLE then 
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine and machine.checkMasterIsRunAway) then 
            return machine:checkMasterIsRunAway()
        end
    end
    return false
end

-- 检车玩家是否处于移动
function RoleBehaviorManager:checkMasterIsInMove()
    if self:getMasterState() == FSMState.MOVE then 
        return true
    end

    return false
end

-- 检测玩家是否处于战斗中
function RoleBehaviorManager:checkMasterIsInBattle()
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if(machine and machine.checkMasterIsBattle) then 
        return machine:checkMasterIsBattle()
    end

    return false
end

-- 获取玩家是否死亡
function RoleBehaviorManager:checkMasterIsDead()
    local GameDataManager = require("app.game.GameDataManager")
    local masterData = GameDataManager:getInstance():getMaster()
    if(masterData) then 
        return masterData:getIsDead()
    end

    return false
end

-- 获取玩家状态
function RoleBehaviorManager:getMasterState()
    local GameDataManager = require("app.game.GameDataManager")
    local masterData = GameDataManager:getInstance():getMaster()
    if(masterData) then 
        return masterData:getState()
    end

    return FSMState.NONE
end


-- 检测玩家是否在上下楼中
function RoleBehaviorManager:checkMasterIsInElevator()
    if SceneManager:getInstance():getIsInLoading() then 
        return true
    end

    return false
end

--在城镇使用装备npc功能时的 行为校验 （包含 装备强化、改造、锻造、 分解）
--return is blocking· 是否阻断
function RoleBehaviorManager:equipTownNpcCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError(" not in town when using equipment npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using equipment npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using equipment npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using equipment npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using equipment npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using equipment npc function !")
        return false
    end
    return false
end 

--在城镇使用宝石npc功能时的 行为校验 （包含 宝石合成、转换、镶嵌、购买）
--return is blocking· 是否阻断
function RoleBehaviorManager:equipGemTownNpcCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError(" not in town when using gem npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using gem npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using gem npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using gem npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using gem npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using gem npc function !")
        return false
    end
    return false
end 

--在城镇使用猫饭\捏脸npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:catFoodAndBeautySalonNpcCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" not in town when using catFood or BeautySalon npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using catFood or BeautySalon npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using catFood or BeautySalon npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using catFood or BeautySalon npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using catFood or BeautySalon npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using catFood or BeautySalon npc function !")
        return false
    end
    return false
end 


--在城镇使用转盘npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:turnTableNpcCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" not in town when using turnTable npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using turnTable npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using turnTable npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using turnTable npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using turnTablen npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using turnTable npc function !")
        return false
    end
    return false
end 

--在城镇使用仓库npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:wareHouseNpcCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" not in town when using ware house npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printWarn(" you are in elevator when using ware house npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using ware house npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using ware house npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using ware house npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using ware house npc function !")
        return false
    end
    return false
end 

--在城镇使用黑市商人npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:blackShopNpcCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError(" not in town when using black shop npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using black shop npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using black shop npc function !")
        return false
    end
    return false
end 

-- 
function RoleBehaviorManager:randomShopNpcCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError(" not in town when using black shop npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using black shop npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using black shop npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using black shop npc function !")
        return false
    end
    return false
end 

--在洞窟使用洞窟商店npc功能时的 行为校验
--return is blocking· 是否阻断
function RoleBehaviorManager:caveShopNpcCheck()
    if not SceneManager:getInstance():isInFightScene() then--不在洞窟 也不在大秘境
        printError(" not in cave when using cave shop npc function !")
        return true
    end

    if SceneManager:getInstance():isInDungeon() then
        if SceneManager:getInstance():isInBossCave() then--不在战斗层
            printError("you are in boss cave when using cave shop npc function in dungeon!")
            return true
        elseif SceneManager:getInstance():isInBlackHouse() then
            printError("you are in black house when using cave shop npc function in dungeon!")
            return true
        end
    elseif SceneManager:getInstance():isInCave() or SceneManager:getInstance():isInHero()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isDesertEyesCave()
        or SceneManager:getInstance():isDistortedSpaceCave()
        or SceneManager:getInstance():isInInferno()
        or SceneManager:getInstance():isInVoidRift()
        or SceneManager:getInstance():isInViKing() 
        or SceneManager:getInstance():isInEverWinter()
        or SceneManager:getInstance():isTitanRoad()
        or SceneManager:getInstance():isInTitanHero() 
        or SceneManager:getInstance():isDriedSpring() 
        or SceneManager:getInstance():isChaosWormHole()
        or SceneManager:getInstance():isInWormhole() then
        if not SceneManager:getInstance():isInShopCave() then--不在商店层
            printError("you are not in shop cave when using cave shop npc function in normal cave!")
            return true
        end
    end
   
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using cave shop npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using cave shop npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using cave shop npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using cave shop npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using cave shop npc function !")
        return false
    end
    return false
end

--在洞窟使用点金npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:goldPointNpcCheck()
    if not SceneManager:getInstance():isInCave() and not SceneManager:getInstance():isInHero()
        and not SceneManager:getInstance():isDesertEyesCave()
        and not SceneManager:getInstance():isDistortedSpaceCave()
        and not SceneManager:getInstance():isInInferno()
        and not SceneManager:getInstance():isInVoidRift()
        and not SceneManager:getInstance():isInViKing()
        and not SceneManager:getInstance():isInEverWinter() 
        and not SceneManager:getInstance():isTitanRoad()
        and not SceneManager:getInstance():isInTitanHero()
        and not SceneManager:getInstance():isDriedSpring()
        and not SceneManager:getInstance():isChaosWormHole() 
        and not SceneManager:getInstance():isInWormhole() then--不在洞窟
        printError(" not in cave when using goldPoint npc function !")
        return true
    end
    if SceneManager:getInstance():isInBossCave() then--不在战斗层
        printError("you are not in boss cave when using goldPoint npc function!")
        return true
    end
    if SceneManager:getInstance():isInShopCave() then--不在战斗层
        printError("you are not in shop cave when using goldPoint npc function!")
        return true
    end
    if SceneManager:getInstance():isInBlackHouse() then--不在战斗层
        printError("you are in black house when using goldPoint npc function!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using goldPoint npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using goldPoint npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using goldPoint npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using goldPoint npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using goldPoint npc function !")
        return false
    end
    return false
end

--在洞窟使用附魔npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:enchantmentNpcCheck()
    if not SceneManager:getInstance():isInCave() 
        and not SceneManager:getInstance():isInHero() 
        and not SceneManager:getInstance():isNotInFightScene()
        and not SceneManager:getInstance():isDesertEyesCave()
        and not SceneManager:getInstance():isDistortedSpaceCave() 
        and not SceneManager:getInstance():isInInferno()
        and not SceneManager:getInstance():isInVoidRift() 
        and not SceneManager:getInstance():isInViKing()
        and not SceneManager:getInstance():isInEverWinter() 
        and not SceneManager:getInstance():isTitanRoad()
        and not SceneManager:getInstance():isInTitanHero()
        and not SceneManager:getInstance():isDriedSpring()
        and not SceneManager:getInstance():isChaosWormHole()
        and not SceneManager:getInstance():isInWormhole()  then--不在洞窟 
        printError(" not in cave when using enchantment npc function !")
        return true
    end
    if SceneManager:getInstance():isInBossCave() then--不在战斗层
        printError("you are not in boss cave when using enchantment npc function!")
        return true
    end
    if SceneManager:getInstance():isInShopCave() then--不在战斗层
        printError("you are not in shop cave when using enchantment npc function!")
        return true
    end
    if SceneManager:getInstance():isInBlackHouse() then--不在战斗层
        printError("you are in black house when using enchantment npc function!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using enchantment npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using enchantment npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using enchantment npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using enchantment npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using enchantment npc function !")
        return false
    end
    return false
end

--在城镇领取藏宝图奖励npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:treasureMapRewardNpcCheck()
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using treasureMap reward  npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using treasureMap reward  npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using treasureMap reward  npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using treasureMap reward  npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using treasureMap reward npc function !")
        return false
    end
    return false
end 

--在城镇领取任务奖励 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:taskRewardNpcCheck()
    -- if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
    --     printError(" not in town when using task reward npc function !")
    --     return true
    -- end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using task reward  npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using task reward  npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using task reward  npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using task reward  npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using task reward npc function !")
        return false
    end
    return false
end 

--在城镇领取成就 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:achievementRewardNpcCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" not in town when using achievement reward npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using achievement reward  npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using achievement reward  npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using achievement reward  npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using achievement reward  npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using achievement reward npc function !")
        return false
    end
    return false
end 

--在城镇使用深渊npc功能时的（领奖） 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:dungeonRewardNpcCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError(" not in town when using dungeon reward npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using dungeon reward  npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printWarn(" you have dead when using dungeon reward  npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using dungeon reward  npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using dungeon reward  npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using dungeon reward npc function !")
        return false
    end
    return false
end 

--在城镇使用邮箱npc功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:mailNpcCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" not in town when using mail npc function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using mail npc function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when using mail npc function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using mail npc function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using mail npc function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using mail npc function !")
        return false
    end
    return false
end 

--增删好友 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:friendSysCheck()
    if SceneManager:getInstance():isInStory() then--在新手引导楼层
        printError(" you are in guide cave when add or delete friend!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when add or delete friend !")
        return true
    end
    return false
end 

--发送聊天消息 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:chatSysCheck()
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when chating!")
        return true
    end
    return false
end 

--组队 行为校验
--return is blocking· 是否阻断
function RoleBehaviorManager:createTeamCheck()
    if not SceneManager:getInstance():isNotInFightScene() then--不在城镇
        printError(" you are not in town or guild when create team!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when create team!")
        return true
    end
    if SceneManager:getInstance():isInBlackHouse() then
        printError(" you are in black house when create team!")
        return true
    end
    return false
end 


--取消组队匹配\同意组队邀请\拒绝组队邀请\确认匹配请求\离队  行为校验
--return is blocking· 是否阻断
function RoleBehaviorManager:teamChoiceCheck()
    if SceneManager:getInstance():isInStory() then
        printError(" you are in guide cave when using team system!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using team system!")
        return true
    end
    if SceneManager:getInstance():isInBlackHouse() then
        printError(" you are in black house when using team system !")
        return true
    end
    return false
end 

--除组队\取消匹配\同意组队邀请\拒绝组队邀请\确认匹配请求\离队 外其他所有 行为校验
--return is blocking· 是否阻断
function RoleBehaviorManager:teamSysCheck()
    if SceneManager:getInstance():isInStory() then
        printError(" you are in guide cave when using team system!")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using team system!")
        return true
    end
    if SceneManager:getInstance():isInBlackHouse() then
        printWarn(" you are in black house when using team system !")
        return true
    end
    return false
end 

--在城镇领取首充
function RoleBehaviorManager:firstRechargeCheck()
    if  not SceneManager:getInstance():isInFightScene() then--不在洞窟
        return true
    end

    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when got first rechargeReward function !")
        return false
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when got first rechargeReward function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when got first rechargeReward function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when got first rechargeReward function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when got first rechargeReward function !")
        return false
    end
    return false
end 

--月卡
function RoleBehaviorManager:monthCardCheck()
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when monthCardCheck function !")
        return false
    end

    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when monthCardCheck function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when monthCardCheck function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when monthCardCheck function !")
        return false
    end
    return true
end 

-- 刷新特殊事件
--return is blocking· 是否阻断
function RoleBehaviorManager:refreshSpecialEventCheck()
    if(not SceneManager:getInstance():isInTownOrInHome() ) then 
        printError("refresh special event must be use in town.")
        return true
    end

    if(self:checkMasterIsInBattle()) then 
        printError("refresh special event must be not in battle.")
        return true
    end

    if self:checkMasterIsDead() then 
        printError("refresh special event no use when role dead.")
        return true 
    end
    
    return false
end

-- 下楼检测
function RoleBehaviorManager:downstairsCheck()
    if(not(SceneManager:getInstance():isInFightScene())) then 
        printError("downstairs must be use in fightscene.")
        return false
    end 

    if self:checkMasterIsInBattle() then 
        printError("downstairs must be not in battle.")
        return false
    end

    if self:checkMasterIsInElevator() then 
        printError("downstairs must be not in elevator.")
        return false
    end

    if (self:checkMasterIsInMove()) then 
        printWarn("downstairs use in move.")
    end

    return true
end

-- 自动返回城镇的检测
function RoleBehaviorManager:autoBackTownCheck(callDetail)
    callDetail = callDetail or ""
    if(type(callDetail) ~= "string") then 
        callDetail = ""
    end

    if(not (SceneManager:getInstance():isInDungeon()
        or SceneManager:getInstance():isInCave()
        or SceneManager:getInstance():isInHero()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGuildBoss()
        or SceneManager:getInstance():isGhostAbyss()
        or SceneManager:getInstance():isInEaster()
        or SceneManager:getInstance():isInTitanHero())) then 
        printError("BackTown only use dungeon or cave.")
        return false
    end 

    if self:checkMasterIsInBattle() then 
        printError("BackTown must be use out battle.")
        return false
    end

    if self:checkMasterIsInElevator() then 
        printError("BackTown no use when elevator.")
        return false
    end

    return true
end

-- 返回城镇的检测
function RoleBehaviorManager:backTownCheck(callDetail)
    callDetail = callDetail or ""
    if(type(callDetail) ~= "string") then 
        callDetail = ""
    end

    if(not (SceneManager:getInstance():isInDungeon()
        or SceneManager:getInstance():isInCave()
        or SceneManager:getInstance():isInHero()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isWorldBossCave() 
        or SceneManager:getInstance():isGuildBoss()
        or SceneManager:getInstance():isGhostAbyss()
        or SceneManager:getInstance():isDesertEyesCave()
        or SceneManager:getInstance():isDistortedSpaceCave()
        or SceneManager:getInstance():isInInferno()
        or SceneManager:getInstance():isActCave()
        or SceneManager:getInstance():isInEaster()
        or SceneManager:getInstance():isInVoidRift()
        or SceneManager:getInstance():isInTrialLand()
        or SceneManager:getInstance():isInViKing()
        or SceneManager:getInstance():isInEverWinter()
        or SceneManager:getInstance():isTitanRoad()
        or SceneManager:getInstance():isInTitanHero()
        or SceneManager:getInstance():isInCaveExploring()
        or SceneManager:getInstance():isDriedSpring()
        or SceneManager:getInstance():isInExp()
        or SceneManager:getInstance():isChaosWormHole()
        or SceneManager:getInstance():isInWormhole()
    )) then 
        printError("BackTown only use dungeon or cave.")
        return false
    end 

    if self:checkMasterIsInBattle() then 
        printError("BackTown must be use out battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("BackTown must be use role is live.")
        return false
    end

    if self:checkMasterIsInElevator() then 
        printError("BackTown no use when elevator.")
        return false
    end

    return true
end

-- 背包扩容的检测
function RoleBehaviorManager:unlockBagSpaceCheck()
    if self:checkMasterIsInBattle() then 
        printError("UnlockBagSpace no use when in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("UnlockBagSpace no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("UnlockBagSpace no use when in elevator.")
        return false
    end

    return true
end

-- 使用道具检测
function RoleBehaviorManager:useItemCheck()
    if(not SceneManager:getInstance():isInFightScene()) then 
        printError("Use Item must be battleScene.")
        return false
    end 

    if self:checkMasterIsDead() then 
        printError("Use Item no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Use Item no use when elevator.")
        return false
    end

    return true
end

-- 技能学习
function RoleBehaviorManager:learnSkillCheck()
    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Learn Skill must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Learn Skill  no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Learn Skill no use when elevator.")
        return false
    end
    
    return true
end

-- 穿脱装备的检测
function RoleBehaviorManager:equipOrUnEquipCheck()
    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Equip Or Unequip must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Equip Or Unequip  no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Equip Or Unequip no use when elevator.")
        return false
    end
    
    return true
end

-- 丢弃道具
function RoleBehaviorManager:lostItemCheck()
    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printWarn("Lost item must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printWarn("Lost item no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Lost item no use when elevator.")
        return false
    end
    
    return true
end

-- 洞穴商人卖掉道具
function RoleBehaviorManager:caveShopSellItemCheck()
    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Cave Shop Sell must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Cave Shop Sell no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Cave Shop Sell no use when elevator.")
        return false
    end
    
    return true
end

-- 黑商卖掉道具
function RoleBehaviorManager:blackShopSellItemCheck()
    if (not SceneManager:getInstance():isInTownOrInHome()) then 
        printError("Black Shop Sell must be use in town.")
        return false
    end

    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Black Shop Sell must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Black Shop Sell no use when role dead.")
        return false 
    end
    
    return true
end

-- 领取活动奖励
function RoleBehaviorManager:activityRewardCheck()
    if(not SceneManager:getInstance():isNotInFightScene() ) then 
        printError("Activity reward must be use in town.")
        return false
    end

    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Activity reward must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Activity reward no use when role dead.")
        return false 
    end
    
    return true
end

-- 公会任务，技能等限制在公会场景操作
function RoleBehaviorManager:guildTaskOrSkillCheck()
    if(not SceneManager:getInstance():isGuild() ) then 
        printError("Guild task or skill must be use in guild.")
        return false
    end

    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Guild task or skill must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Guild task or skill no use when role dead.")
        return false 
    end
    
    return true
end

-- 进入深渊检测
function RoleBehaviorManager:enterDungeonCheck()
    if(not SceneManager:getInstance():isInTownOrInHome() ) then 
        printError("Enter Dungeon must be use in town.")
        return false
    end

    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Enter Dungeon must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Enter Dungeon no use when role dead.")
        return false 
    end
    
    return true
end

-- 进入洞窟检测
function RoleBehaviorManager:enterCaveCheck()
    if(not SceneManager:getInstance():isInTownOrInHome() ) then 
        printError("Enter Cave must be use in town.")
        return false
    end

    if(self:checkMasterIsInBattle()) then 
        printError("Enter Cave must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Enter Cave no use when role dead.")
        return false 
    end
    
    return true
end

-- 使用战斗技能检测
function RoleBehaviorManager:useBattleSkillCheck()
    if(not SceneManager:getInstance():isInFightScene() ) then 
        printError("Use Battle Skill must be use in fightScene.")
        return false
    end

    if(not self:checkMasterIsInBattle()) then 
        printError("Use Battle Skill must be in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Use Battle Skill no use when role dead.")
        return false 
    end

    if (self:checkMasterIsInRunAway()) then 
        printError("Use Battle Skill no use when role runAway.")
        return false
    end
    
    return true
end

-- 使用辅助技能
function RoleBehaviorManager:useAssistSkillCheck()
    if(not SceneManager:getInstance():isInFightScene() ) then 
        printError("Use Assist Skill must be use in fightScene.")
        return false
    end
    
    -- 角色 死亡，战斗中
    if(self:checkMasterIsInBattle()) then 
        printError("Use Assist Skill must be no in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Use Assist Skill no use when role dead.")
        return false 
    end

    return true
end

-- 移动监测
function RoleBehaviorManager:moveCheck()
    if(self:checkMasterIsInBattle()) then 
        printError("Start move must be no in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Start move no use when role dead.")
        return false 
    end
    
    return true
end

-- 逃跑监测
function RoleBehaviorManager:escapeCheck()
    if (not SceneManager:getInstance():isInCave() 
        and not SceneManager:getInstance():isInDungeon()
        and not SceneManager:getInstance():isInHero()
        and not SceneManager:getInstance():isInDream()
        and not SceneManager:getInstance():isWorldBossCave()
        and not SceneManager:getInstance():isGuildBoss()
        and not SceneManager:getInstance():isGhostAbyss()
        and not SceneManager:getInstance():isDesertEyesCave()
        and not SceneManager:getInstance():isDistortedSpaceCave()
        and not SceneManager:getInstance():isInInferno()
        and not SceneManager:getInstance():isInBigCrack()
        and not SceneManager:getInstance():isInEaster()
        and not SceneManager:getInstance():isInHuLu()
        and not SceneManager:getInstance():isInVoidRift()
        and not SceneManager:getInstance():isInTrialLand()
        and not SceneManager:getInstance():isInViKing()
        and not SceneManager:getInstance():isInEverWinter()
        and not SceneManager:getInstance():isTitanRoad()
        and not SceneManager:getInstance():isInTitanHero()
        and not SceneManager:getInstance():isInCaveExploring()
        and not SceneManager:getInstance():isDriedSpring()
        and not SceneManager:getInstance():isInExp()
        and not SceneManager:getInstance():isChaosWormHole()
        and not SceneManager:getInstance():isInWormhole()
    ) then 
        printError("Escape must be use in cave or dungeon.")
        return false
    end

    if(not self:checkMasterIsInBattle()) then 
        printError("Escape must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Escape no use when role dead.")
        return false 
    end

    if (self:checkMasterIsInRunAway()) then 
        printError("Escape no use when role in runAway")
        return false
    end
    
    return true
end

-- 触发宝箱，陷阱，金币袋，符文处理
function RoleBehaviorManager:triggerBoxTrapGoldBoxCheck()
    if(not SceneManager:getInstance():isInFightScene() ) then 
        printError("Trigger Box,trap,goldbox,rune must be use in fightScene.")
        return false
    end

    if(self:checkMasterIsInBattle()) then 
        printError("Trigger Box,trap,goldbox,rune must be not in battle.")
        return false
    end

    if self:checkMasterIsDead() then 
        printError("Trigger Box,trap,goldbox,rune no use when role dead.")
        return false 
    end

    if self:checkMasterIsInElevator() then 
        printError("Trigger Box,trap,goldbox,rune no use when elevator.")
        return false
    end

    return true
end


--在城镇使用天赋功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:roleTalentCheck()
    if SceneManager:getInstance():isInStory() then--不在城镇
        printError(" in Story when using role talent function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using role talent function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when using role talent function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using role talent function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using role talent function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using role talent function !")
        return false
    end
    return false
end 

--在城镇使用梦境功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:dreamCheck()
    if SceneManager:getInstance():isInStory() then--不在城镇
        printError(" in Story when using dream function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using dream function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when using dream function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using dream function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using dream function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using dream function !")
        return false
    end
    return false
end 

--在接取梦境功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:dreamTaskCheck()
    if not SceneManager:getInstance():isInShopCave() then--不在城镇
        printError("not in shop when pick up dream task function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when using dream function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when using dream function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when using dream function !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when using dream function !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when using dream function !")
        return false
    end
    return false
end 

--星痕功能时的 行为校验 
--return is blocking· 是否阻断
function RoleBehaviorManager:starPrayCheck()
    if not SceneManager:getInstance():isInTownOrInHome() then--不在城镇
        printError("not in town when use star pray function !")
        return true
    end
    if self:checkMasterIsInElevator() then--下楼中
        printError(" you are in elevator when use star pray function !")
        return true
    end
    if self:checkMasterIsDead() then--死亡状态
        printError(" you have dead when use star pray function !")
        return false
    end
    if self:checkMasterIsInBattle() then--战斗中
        printWarn(" you are battling when use star pray function  !")
        return false
    end
    if self:checkMasterIsInMove() then--移动中
        printWarn(" you are moving when use star pray function  !")
        return false
    end
    if self:checkMasterIsInRunAway() then--逃跑中
        printWarn(" you are in RunAway when use star pray function !")
        return false
    end
    return false
end 



































































































































































