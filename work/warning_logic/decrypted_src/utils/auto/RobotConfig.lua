--[[
    测试工具  2017/11/30
    -- 公共静态设置 --
	-- 影响所有GMUtil组件
    by CMonk
]]

require "config"

---------------------------------------
-- 引用UI命名空间
Auto = Auto or {}

-- 素子
local RobotConfig = Auto.RobotConfig or {}
Auto.RobotConfig = RobotConfig

-- GM属性开关
RobotConfig.GMSTATUS_SWTICH = false

-- 性能优化控制帧率
RobotConfig.FPS = 15

-- 场景切换等待
RobotConfig.WAIT_AFTER_SCENE_CHANGE = 2
-- 升级学技能等待
RobotConfig.WAIT_AFTER_LVLUP_TO_LEARN_SKILL = RobotConfig.WAIT_AFTER_SCENE_CHANGE - 1
-- 杀怪后的间隙等待
RobotConfig.WAIT_AFTER_KILLING_MONSTER = 0.5

-- nil使用随机账号
RobotConfig.ACCOUNT = nil
-- RobotConfig.ACCOUNT = "test_RUYI_34"
RobotConfig.CHARACTER_SEX = 1
RobotConfig.CHARACTER_FACEID = 1020301

-- 随机走路范围大小
RobotConfig.WANDER_RANGE = 8
-- 随机走路等待时间
RobotConfig.WANDER_TIMEOUT = 8

-- 尝试使用技能间隔时间, 毫秒
RobotConfig.USE_SKILL_INTERVAL = 1.5

-- 尝试下一层次数
RobotConfig.GOTO_NEXT_LEVEL_TRY_NUM = 3
-- 尝试下一层超时
RobotConfig.GOTO_NEXT_LEVEL_TIMEOUT = 15

-- 尝试接近一个怪次数
RobotConfig.APPROACH_A_MONSTER_TRY_NUM = 3
-- 尝试接近一个怪超时
RobotConfig.APPROACH_A_MONSTER_TIMEOUT = 10

-- 尝试打怪次数
RobotConfig.KILL_A_MONSTER_TRY_NUM = 3
-- 尝试打怪超时
RobotConfig.KILL_A_MONSTER_TIMEOUT = 10
-- 尝试到第几次换怪换怪
RobotConfig.KILL_A_MONSTER_SWTICH_MONSTER_THRESHOLD = 4
-- 尝试打怪长等待检查次数
RobotConfig.KILL_A_MONSTER_WAIT_NUM = 12
-- 尝试打怪长等待检查间隔
RobotConfig.KILL_A_MONSTER_WAIT_INTERVAL = 5

-- 寻怪中忽略尝试击杀次数高于此值的怪(避免出错卡怪), 一般和换怪值一起改变
RobotConfig.FIND_A_MONSTER_DEFAULT_MAX_TRY = RobotConfig.KILL_A_MONSTER_SWTICH_MONSTER_THRESHOLD - 1

-- 尝试重连超时
RobotConfig.RECON_TIMEOUT = 5
-- 尝试重连次数
RobotConfig.RECON_TRY_NUM = 999

return RobotConfig