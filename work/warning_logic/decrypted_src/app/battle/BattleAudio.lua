-- --[[
--     战斗音效：战斗中所有对象在场景上的音效
--     --弃用(孟繁东)
-- ]]

-- Battle = Battle or {}

-- local BattleAudio = class("BattleAudio", Machine.Audio)
-- Battle.BattleAudio = BattleAudio

-- -- private:
-- local DEBUG = true

-- -- public:
-- -- 构造函数
-- function BattleAudio:ctor()
--     -- 音效播放器映射表
--     self._playerMap = nil
-- end

-- -- 销毁
-- function BattleAudio:destroy()
--     self._playerMap = nil
-- end

-- -- 初始化
-- function BattleAudio:init()
--     self._playerMap = {}
-- end

-- -- 清理
-- function BattleAudio:clear()
--     local playerMap = self._playerMap
--     for id, player in pairs(self._playerMap) do
--         local player = playerMap[id]
--         player:destroy()
--         playerMap[id] = nil
--     end
-- end

-- -- 执行command
-- function BattleAudio:executeCommand(command)
--     if (command.category == CommandCategory.PLAYER) then
--         local player = nil
--         if (command.target) then
--             local id = command.target:getId()
--             local player = self._playerMap[id]

--             if (player) then
--                 player:executeCommand(command)
--             else
--                 assert(false, string.format("[ERROR] BattleAudio executeCommand: target %d has no a player.", id))
--             end
--         end
--     else
--         assert(false, string.format("[ERROR] BattleView _onExecuteCommand: command category %d is invalid.", commandCategory))
--     end
-- end

-- -- 添加模型播放器
-- function BattleAudio:addPlayer(model)
--     if (model) then
--         local id = model:getId()
--         local player = nil

--         local modelCategory = model:getCategory()
--         local modelType = model:getType()
--         if (modelCategory == ModelCategory.ROLE) then

--         else

--         end
--         if (player) then
--             self._playerMap[id] = player
--         else
--             print(string.format("BattleAudio addPlayer: could not create player for model %d.", id))
--         end
--     end
-- end

-- -- 删除模型播放器
-- function BattleAudio:removePlayer(model)
--     if (model) then
--         local id = model:getId()
--         self._playerMap[id] = nil
--     end
-- end